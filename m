Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8039CCD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3YV-0004wg-He; Fri, 26 Jun 2026 06:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wd3YQ-0004wD-IC
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wd3YO-00042F-Pi
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782468775;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DFPSH5gzDoDdZ/4KPHJHw0uqKqpaproebHn3ss781y0=;
 b=VXvR5b8ISqGueHHQLbEuK992r2izxvyOrm3W01mYN6gIQwNptimX+Aw3R2a9qmpC5CUQMN
 fMGFc/CspmN3L9G53rUunB2d1PwgEyVOe3NZXcRIIy3FC2sBu1AhI3dFvRhNp33pIGK5E1
 +EbgpoN5HfwJPz9BdFTtl8V7ub1YmUA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-JBq8-Co8OXmyRqejxHxalA-1; Fri,
 26 Jun 2026 06:12:51 -0400
X-MC-Unique: JBq8-Co8OXmyRqejxHxalA-1
X-Mimecast-MFC-AGG-ID: JBq8-Co8OXmyRqejxHxalA_1782468770
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D7D11955F2A; Fri, 26 Jun 2026 10:12:50 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85AD7195608E; Fri, 26 Jun 2026 10:12:48 +0000 (UTC)
Date: Fri, 26 Jun 2026 11:12:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ganesh Harshan <ganeshredcobra@gmail.com>
Cc: th.huth+qemu@posteo.eu, philmd@mailo.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/functional: use QMP to query available machines
Message-ID: <aj5QnMlxfeO5RBKY@redhat.com>
References: <20260625165310.54113-1-ganeshredcobra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625165310.54113-1-ganeshredcobra@gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Jun 25, 2026 at 12:53:10PM -0400, Ganesh Harshan wrote:
> Replace parsing of "qemu -M help" in set_machine() with
> QMP "query-machines".
> 
> The previous approach relied on parsing human-readable CLI
> output and substring matching, which is fragile and prone to
> incorrect matches. It is also sensitive to output format changes.
> 
> Use QMP instead to retrieve structured machine information,
> ensuring accurate matching and better maintainability.
> 
> Cache the result at the class level to avoid repeated QEMU
> startup overhead.
> 
> Signed-off-by: Ganesh Harshan <ganeshredcobra@gmail.com>
> ---
>  tests/functional/qemu_test/testcase.py | 32 +++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 6 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


