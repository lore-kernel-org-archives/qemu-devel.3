Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6CAD4A604
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 07:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgeIe-0000KA-DN; Fri, 16 Jan 2026 02:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vgeIY-0000F2-CR
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:31:10 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vgeIS-0005b7-Gz
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:31:09 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 16 Jan
 2026 15:30:26 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 16 Jan 2026 15:30:26 +0800
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 "Hao Wu" <wuhaotsh@google.com>, Michael Tokarev <mjt@tls.msk.ru>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>, <nabihestefan@google.com>, <komlodi@google.com>
Subject: [PULL 3/3] pc-bios: Update vbootrom image to commit 1c8e9510b22c
Date: Fri, 16 Jan 2026 15:30:21 +0800
Message-ID: <20260116073024.3485812-4-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116073024.3485812-1-jamin_lin@aspeedtech.com>
References: <20260116073024.3485812-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, LOTS_OF_MONEY=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Full changelog since last update (183c9ff8056b) :

Joe Komlodi (1):
    npcm8xx: Fix u-boot copy size

Jamin Lin (3):
    ast27x0: refactor FIT boot loader into fmc_image.c for future Caliptra Manifest support
    ast27x0: Add Caliptra Manifest boot support and MCU runtime loader framework
    ast27x0: Fix compilation issues on Ubuntu 22.04

Compiled with gcc version 13.3.0

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
---
 pc-bios/ast27x0_bootrom.bin | Bin 16408 -> 28564 bytes
 pc-bios/npcm7xx_bootrom.bin | Bin 672 -> 736 bytes
 pc-bios/npcm8xx_bootrom.bin | Bin 672 -> 672 bytes
 3 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/pc-bios/ast27x0_bootrom.bin b/pc-bios/ast27x0_bootrom.bin
index a4c94d64da55ade9b4beb2a409132f315fb51347..626499b117c72ea59d906c60655780d91229616e 100644
GIT binary patch
literal 28564
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

delta 4114
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

diff --git a/pc-bios/npcm7xx_bootrom.bin b/pc-bios/npcm7xx_bootrom.bin
index 92282892b70dbcd6828c5054dff33ffe3385c485..60e5517eedfd6b35095bfb8d18181f561bafe556 100644
GIT binary patch
delta 287
zcmZ3$`hayq2V=b;1H)^B|N0Ma{r~@pf#L6e28RFt4>0}zufX^hj2R3TJQi@!eaU>F
z=>fBY!vh9}n8(Zy93KcY?7hKoVBS*}1LsE!2U?zf1M24ns{O43QD0%u^pweQ!D9x6
zDNkz*=09a-2ztoKz`#|)F#qZP|NmdJ0L60*=GVg|Qh*XWff5No#XJU=pE586KV}1J
zU{VAcDze})hvKBC3<`};T@-+Z883Jk0kS}F!D9!;i9odhk6D0fT@)uiWzuPSbP;F{
z6Hmh<pd(*M0L=x_0qmixdVn4a@%MLH45S$t85$S_*cv`CFflYt_F(ehQDi^>0H^PJ
AB>(^b

delta 209
zcmaFBx`1^<2V*@C1H*5F|N0Ma{r~@pf#L6e28RFt8<_t8S77`L#tg~@TdznQlVZ?W
z_?nrO;ZDI`oeUOhlY}qNxt0AtR67Z5ot*Cffx$&7L(F@Y6Y~X0j|!Ln-zU6J$`A(g
z#lZZI_X6J1)!rL{DxHA3954OgP~=MB@tW<(I5`z4=y>sm1Ea&ni$7cxnZ7a<{r`UC
zKf_ms0)f4(9)F%Q><?fMT@~W*@5I2!(7+(j@PUDep&^TbfuRtHC-*RUOuoP*001-0
BR<{5E

diff --git a/pc-bios/npcm8xx_bootrom.bin b/pc-bios/npcm8xx_bootrom.bin
index 45fb40fb5987ab681cc902659d85e76a7385cb53..4b6f82f38d61750c49f2eba61fb3f77dbcb179f4 100644
GIT binary patch
delta 99
zcmZ3$x`1`V14hS#j0_<v3{E@eGcac-0@;77_pkiR%rH^)hvQDAKaM*eFtchoF>nap
z`~QFX-|B-a7691?nB%W0GO$dvXJB}JaI!3u{A33v6W$&MAPC_Tn9DSe(S33wlRN-G
C%_3(2

delta 98
zcmZ3$x`1`V14i40j0_<v3{E@eGcad60@;77_pkiR%rH^ukK<0&AC5a8Ftcji|Nnpb
z-|B-a7BFxK9$=2YrpUlD(Vl_f^~1@EO!5;GSSC9#necWn06_?!z+9$zjBb+~ndAXS
CTO!>6

-- 
2.43.0


