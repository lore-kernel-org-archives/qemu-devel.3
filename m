Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44290CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1OT-0001Oq-2Q; Mon, 17 Nov 2025 10:43:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vL1OF-0001OL-B4
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:43:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vL1OB-0006RM-UJ
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:43:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763394215;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eYxRBTKF/efXh7AVRrfnZP1B3XOQT5Fi8s8TQ5u/JIo=;
 b=hSCjY2YM+MkyUWqp1q4I6yausJEy1RqbNpwRnqMgxq6IbrbJmIGVXc+jySUA4OFI4WDXYV
 rhN5k6B0pY8oA3jDK1gCIdMfcfLQfXKpjciak5wxwZ//wwS/IA4ngcq03qYlp6tD2aDQHx
 BwFgtiYGztWsK6K3A8JwKrwPOXH88MY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-pyKqAfRbO_mNO0B7yf1ztw-1; Mon,
 17 Nov 2025 10:43:28 -0500
X-MC-Unique: pyKqAfRbO_mNO0B7yf1ztw-1
X-Mimecast-MFC-AGG-ID: pyKqAfRbO_mNO0B7yf1ztw_1763394207
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9620180123B; Mon, 17 Nov 2025 15:43:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.112])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFD82195608E; Mon, 17 Nov 2025 15:43:24 +0000 (UTC)
Date: Mon, 17 Nov 2025 15:43:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH-for-10.2] docs: Mention 32-bit PPC host as removed
Message-ID: <aRtCmHyEmyNlfi50@redhat.com>
References: <20251117153756.78830-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251117153756.78830-1-philmd@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

On Mon, Nov 17, 2025 at 04:37:56PM +0100, Philippe Mathieu-Daudé wrote:
> We removed support for 32-bit PPC hosts in commit 5c1ec5a1ee0
> ("tcg/ppc: Remove support for 32-bit hosts").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  docs/about/removed-features.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index 88ea0dc4edc..3ebbe9aec98 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -902,6 +902,12 @@ From 10.0, QEMU has disabled configuration of 64-bit guests on 32-bit hosts.
>  Debian 12 "Bookworm" removed support for 32-bit MIPS, making it hard to
>  maintain our cross-compilation CI tests of the architecture.
>  
> +32-bit PPC (since 11.0)

We're in freeze for 10.2, not 11.0

> +'''''''''''''''''''''''
> +
> +Keeping 32-bit host support alive is a substantial burden for the
> +QEMU project.

That's a suitable justification for the original commit, but for the
removed features user docs I think we can simply say

   "The QEMU project no longer supports 32-bit host builds"


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


