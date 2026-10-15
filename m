Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB1CCC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHGAT-0007GE-Kx; Thu, 15 Oct 2026 03:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHGAS-0007Fm-2d
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 03:46:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHGAQ-0003xg-FW
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 03:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792050381;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ocxcnEbypXaZpgsA6tjd45fpan69lPXQqwnxeM2o9Zk=;
 b=V01vYzZSMM5geY79PjaECLWSqT7bVLjet1aPogAAUzP8RO8OuuUFugVaVYroV4Q40mvfIt
 dpVSSiimD9MMURYhttMOq+nCZvbWquYb2LRA2+e2fc70Ydi5cbxMcmtwK44N0sRI/GUsoi
 A6s3b5AIMMgWTmp6M8H3CM3pdtE96ho=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-3Yo3vhTmPEWWJmQzi2eJGQ-1; Thu,
 15 Oct 2026 07:46:18 +0000
X-MC-Unique: 3Yo3vhTmPEWWJmQzi2eJGQ-1
X-Mimecast-MFC-AGG-ID: 3Yo3vhTmPEWWJmQzi2eJGQ_1792050377
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C487A180076B; Thu, 15 Oct 2026 07:46:16 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 605D0300072E; Thu, 15 Oct 2026 07:46:14 +0000 (UTC)
Date: Thu, 15 Oct 2026 08:46:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Wesley Hershberger <wesley.hershberger@canonical.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hector Cao <hector.cao@canonical.com>,
 Alex =?utf-8?Q?Ram=C3=ADrez?= <alex.ramirez@canonical.com>
Subject: Re: [PATCH v4 2/2] util/coroutine: Reduce default idle pool max size
Message-ID: <atCEw5dxu8GCHNWU@redhat.com>
References: <20261014-set-default-pool-size-v4-0-a3aff89b94f0@canonical.com>
 <20261014-set-default-pool-size-v4-2-a3aff89b94f0@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261014-set-default-pool-size-v4-2-a3aff89b94f0@canonical.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 14, 2026 at 04:55:46PM -0500, Wesley Hershberger wrote:
> If g_file_get_contents fails (AppArmor, etc), use a more conservative
> default max size for the idle coroutine pool.
> 
> This avoids any possibility of the failure described in 86a637e48104
> unless the host kernel is configured with a lower-than-default
> vm.max_map_count.
> 
> This change is motivated by a discussion of backport risk:
> https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2168803/comments/8
> 
> Fixes: 86a637e48104 ("coroutine: cap per-thread local pool size")
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
> ---
>  util/qemu-coroutine.c | 73 ++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 46 insertions(+), 27 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


