Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635EFC87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 20:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugqf8-0001xO-IT; Tue, 29 Jul 2025 16:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugoMI-0007Le-Nt
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 13:43:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugoMF-0004UZ-0d
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 13:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753811001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rgskk+ZQzjHNXQW4XaH1j7NCVKvv1bX1y1YXVkqkkq4=;
 b=XW8bQgtZhLkT/LqogqEiPkOP/+Y5JxW1fHLyDvNfODFSojt90uH0dKfGHYm5+7jVqX4YZC
 pIzFTEqJ2dpXudFnYhKi31q+NBKRr0jStouyLn/PY1IKur48ZaT/eoUPsj3FzhlKVPfyV1
 HlkwD1jLw4+SjJKzx+JJmfEu7v4Y4aQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-v-D8ha0ePpeSADCIU_JO3A-1; Tue,
 29 Jul 2025 13:43:17 -0400
X-MC-Unique: v-D8ha0ePpeSADCIU_JO3A-1
X-Mimecast-MFC-AGG-ID: v-D8ha0ePpeSADCIU_JO3A_1753810995
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDAFC19560AD; Tue, 29 Jul 2025 17:43:14 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.29])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6FEED1800288; Tue, 29 Jul 2025 17:43:12 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>,
 Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 3/3] pc-bios: Update vbootrom image to commit 183c9ff8056b
Date: Tue, 29 Jul 2025 19:42:59 +0200
Message-ID: <20250729174259.697405-4-clg@redhat.com>
In-Reply-To: <20250729174259.697405-1-clg@redhat.com>
References: <20250729174259.697405-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Full changelog since last update (d6e3386709b3) :

Jamin Lin (3):
      ast27x0: Initialize and enable SSP/TSP using SCU with reserved-memory from DTB
      ast27x0: Fix missing SCU module reset for SSP and TSP initialization
      ast27x0: Fix Makefile to unconditionally set CC to support correct cross-compilation

Compiled with gcc version 13.3.0

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 pc-bios/ast27x0_bootrom.bin | Bin 15552 -> 16408 bytes
 pc-bios/npcm7xx_bootrom.bin | Bin 768 -> 672 bytes
 pc-bios/npcm8xx_bootrom.bin | Bin 608 -> 672 bytes
 3 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/pc-bios/ast27x0_bootrom.bin b/pc-bios/ast27x0_bootrom.bin
index 0b9b3a2360e375bb6007ecdf13b39d931870f6fa..a4c94d64da55ade9b4beb2a409132f315fb51347 100644
GIT binary patch
literal 16408
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
Rt7@0xcVs@1NL*j?`F{}^giQbd

literal 15552
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

diff --git a/pc-bios/npcm7xx_bootrom.bin b/pc-bios/npcm7xx_bootrom.bin
index 903f126636f9ef5d1100c056656ccfb2b32e5e10..92282892b70dbcd6828c5054dff33ffe3385c485 100644
GIT binary patch
delta 218
zcmZo*Tfn-ZgR!26f#J8ofBlEI{{Mf)!0`7!1H=FS4NU+4D=_{AV+Q4dtyd(DNipaw
ze9g?taHn9eP6ms$Ny3-s+{*qRs+|P3PEPm#z~G{kA?7{HiTQ%0M}^D(?-Sl9We9`$
zVqkv9djW6hYVVEy9~hkcKU6zj`oW>dmB8aQ+mUf{s{aQD$BRE47#%iV{NbX=^p&CL
z|Mw&R8NM<U2<&C``171$e*k;vst|vFCk94_1_ptK4-8BU4Ot8f4228~43noY`S2(*
GAOHa1WmOyi

delta 298
zcmYj~Jxjw-7==%6VwD&qg$|AhI4WN752V_`L1^&<92^`SJ30uxh7N**Mmw83JGphL
z<R3V=h*Ofw3)(DBE~UIu74*Qv8J+`2&#BtOh1IJAmE`r}m3a(I8DP!@b6`!sfz-y2
z*52(b&h045fg@w*&D>X`7i4$j$gL7tpFWw#i&C4(%Fq5(#w42BAQ(_zretHc5P*Az
zlz^-Jk-2h$L65rs<jJobGFQhkB~LyRuxDz3D?)814Q&>}8$xhStso_PLl=j$qq;Vc
zl@QP|4&b)Jgv4rGJ~3CqQ>Cv)Z_7w&)}8r-`)dIE?e^v+mH=2#@YM$d)a|y|NxBU$
H#9zJu8yI@#

diff --git a/pc-bios/npcm8xx_bootrom.bin b/pc-bios/npcm8xx_bootrom.bin
index 6370d6475635c4d445d2b927311edcd591949c82..45fb40fb5987ab681cc902659d85e76a7385cb53 100644
GIT binary patch
delta 215
zcmaFBvVe6%2BV+@69X75fYFmH8MW&beohQhuv<{X$k23&QDEOE1r~;#P7Av(IlWl<
z=~3sYPfi^#KRGit1Ti-(Dq>{VaEXCs!zC34hoAEqm|ibrWC&4VaN0SafjQfeks;)7
z_5PKAnHeT3{c+r>`onSO17=pO`~Uw>|66@<#R3Kn!2`_k*Ay98CfYMFynguie+Vl>
z17{FSVq&1kBqkYEmH+?$t3VveAj81Gpu@nxVDkU}{|=B?2%o@Qrg@BRlO37l0jknV
A%K!iX

delta 152
zcmZ3$`haCa2BRPY69X6|!05@9jM_ebtM{)|_&G61!EQm(UuK4hj0{be7zOryQea`&
z$#kJN$cb@55u-!HB}ax0pBNY>TzdWg|MW!0rXa<H1w~8=`!6{%FzozWeQ?DA=J;!q
t4VZLPQ~v+|uL7}&L56{WL5G2Xq2&Mn|2`lwM?QhMO!F86CpR+50|3~$GJF64

-- 
2.50.1


