Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1507C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77aJ-0003y1-UP; Thu, 17 Sep 2026 04:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x77a8-0003v6-Iz
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:35:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x77a6-0003Ua-QZ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789634098;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ik26bOfsXZGpXhYJCk46YY++gVp2OxoA64fhTZV+Vgc=;
 b=QTH1MkkBagvYeYqAvfBY4BRpR92AS5UDvcPyPiNiiq6tpDTej6Q5ri1AmPJHg7fbJ7NkWq
 /WYUta/9r8MlfaJyNjSsRV2s+PGMT+BtOzHgCjoBZDJbDcIhucPiDl2Lov4t/uJKaO4XAc
 my8UctHcJxvBohgAONMuTW7sCOYiOzw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-GVXDMmCtOZCqEBaopHd8rA-1; Thu,
 17 Sep 2026 04:34:54 -0400
X-MC-Unique: GVXDMmCtOZCqEBaopHd8rA-1
X-Mimecast-MFC-AGG-ID: GVXDMmCtOZCqEBaopHd8rA_1789634093
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E96801802178; Thu, 17 Sep 2026 08:34:52 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E9AE427; Thu, 17 Sep 2026 08:34:51 +0000 (UTC)
Date: Thu, 17 Sep 2026 09:34:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander von Gluck IV <kallisti5@unixzen.com>,
 John Snow <jsnow@redhat.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH] tests/vm: Drop the broken Haiku VM
Message-ID: <aqumKKh9rjksBnjC@redhat.com>
References: <20260917062615.783485-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260917062615.783485-1-thuth@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 17, 2026 at 08:26:15AM +0200, Thomas Huth wrote:
> The Haiku VM has bitrotted again: At least since Haiku r1beta6 has
> been released, the image does not work anymore. I tried to update
> the script to use the r1beta6 repositories instead, but after the
> update, the Haiku kernel only crashes during reboot.
> 
> Given the fact that hardly anybody seems to use this image and
> that it is more often broken than working, let's stop wasting our
> time here and simply remove it.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  If somebody wants to see Haiku being tested more frequently again,
>  it might be better to look into alternatives like Github actions.
> 
>  tests/vm/haiku.x86_64 | 124 ------------------------------------------
>  1 file changed, 124 deletions(-)
>  delete mode 100755 tests/vm/haiku.x86_64

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>




With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


