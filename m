Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829F5D74EC2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 13:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjGla-0001Hn-RL; Fri, 23 Jan 2026 08:00:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vjGkU-0000zM-6d
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:58:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vjGkQ-0005OG-OR
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 07:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769173125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cPedSskjk4A/BdgStfVAlbU/IKfMuyDAhEG33N5YC+M=;
 b=HwQONknhWTz5anfQUvsT0aRMdOzxM+lerThF64NTwKvd3ZzDdqZdmQM0K87IrXF3T+qBdv
 KavwwOInV9IlztpEkLECdKPzP5DJE9vVCAUceWwhXUe8eknUvOQMjGLm63wRsuXxVanVjH
 YsZYysuwzCkITEmUNf3U4RIzABe8UII=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-353XMA3JPgarGA3BUYfLVg-1; Fri,
 23 Jan 2026 07:58:42 -0500
X-MC-Unique: 353XMA3JPgarGA3BUYfLVg-1
X-Mimecast-MFC-AGG-ID: 353XMA3JPgarGA3BUYfLVg_1769173122
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D89E219775AC; Fri, 23 Jan 2026 12:58:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.180])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 34E011958DC1; Fri, 23 Jan 2026 12:58:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0180A18003AA; Fri, 23 Jan 2026 13:58:38 +0100 (CET)
Date: Fri, 23 Jan 2026 13:58:38 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Oliver Steffen <osteffen@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>
Subject: Re: [PATCH 3/3] docs/interop: Add firmware digests to schema
Message-ID: <aXNslKemURR1tvE7@sirius.home.kraxel.org>
References: <20260123083204.999920-1-osteffen@redhat.com>
 <20260123083204.999920-4-osteffen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123083204.999920-4-osteffen@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

  Hi,

> +##
> +# @AmdSevSnpLaunchHashAlg:
> +#
> +# Hash algorithms used for AMD SEV-SNP launch digests.
> +#
> +# @sha384: SHA-384
> +##
> +{ 'enum': 'AmdSevSnpLaunchHashAlg',
> +  'data': [ 'sha384' ] }

Hmm.  When it comes to extending this:  Do we want be very strict, like
this, and have a per-type list of digests?

One possible extension which comes to mind is the 'platform-code' digest
measured into TPMs (pcr0).  The possible hash algorithms here are
everything supported by the TPM, i.e. sha1, sha256, sha384, sha512.
I think for something new introduced in 2026 we can ignore sha1,
leaving the other three on the table.

So one option would be to add a TPMHashAlg enum for this (sticking to
the theme).

The alternative approach would be to have a common 'FirmwareHashAlg' for
all types.  Would make the structs below a bit simpler, the
AmdSevSnpLaunchDigest is not needed then and FirmwareDigest can be a
simple struct instead of a union.  On the other hand it would allow some
invalid combinations such as sha256 for amd-snp launch digest.

Opinions?

take care,
  Gerd


