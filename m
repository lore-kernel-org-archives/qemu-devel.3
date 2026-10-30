Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCA1606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vecf6rY9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMjMh-0001Px-I4; Fri, 30 Oct 2026 05:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMjMg-0001Pd-3j
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 05:57:38 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMjMe-0003D0-Fo
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 05:57:37 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso3348125e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 02:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793354253; x=1793959053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VfaJ4F1gIGp2Zh2Ykw383pEaDYAt1luMqXttPDnnVxo=;
 b=vecf6rY91ubjif6BP1mJYYzsHkKd4NdnL5LM+FKylCYXLeG6lxl35BlirJem4dWTMn
 0nZO5Spi0VwZSmR7vSHMrd1zalb0/1T+VjofgjaA4rw2ygzsDMzF1Dx2XXBKX2FNPj+a
 BQkc//p7mdkw3db8udioLlUwUjTGCPG3dNLbXxLPB4/U4PN/tbWYUANuy/2Yr7Y4ZARb
 A7FCk1aMVD6Pi2l2Fjo9XAUf3E7G0HtkiAuEinreurO6/DvanQ7N2s661GJMrM5vSHEu
 jsgbr+aHJ8AHmPZ1xaTiaQI+uZOk2snAmY9ht5brUaIenNPKrUh9Hq6ky19bK/EgpMFl
 U0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793354253; x=1793959053;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VfaJ4F1gIGp2Zh2Ykw383pEaDYAt1luMqXttPDnnVxo=;
 b=svaa07jpruIl0RWd9DtLlqfKSmerkrkfnpiNNlZZz05xem7ErN7PrTaSYeRdSyCtLm
 TccePW8N3rRtCyGKW00bxQt2VCjXkiDjPZuIvG5XJJWgk+noEpmskJ6l+5h/trhRGyz5
 Wjs6FL6TkMzqvpP8lJiam65jBbQ51YKfov2VOODY00KFfpeM0WHW9ANFKwcuj96l+hND
 NO0wOHp87ltQ28BCFcDpuFKsrQNZ3VsRTUSg0S3GZccjrdGq0NAAgaMHeEJoZS//9Zgp
 WAu+zq0kuMxeFP4F05CTa/Sd+MH34yIj5c+NQNEdMw8FiMiqkw6ZLtUFe3VLioCyk86l
 gGyg==
X-Forwarded-Encrypted: i=1;
 AKwUvBya1NgVXrFEmFwxVyJGP14+1MPAAX3smx2stPDfiyLE4+Is8mptGokf0zFYdtO3pTx0F8GiJqON5duo@nongnu.org
X-Gm-Message-State: AFq9FYLwv68Z7gGHBdpvkBde4fl8/9Gws6+5PgkrtEj+Xbnf3V+HprqE
 yiXMFMa4K1i44d/ti/VGb+Bk7J0Kh9g4qGUxZmp6un3SlmnQSt8tQPGWfCyYKEPUgKo=
X-Gm-Gg: AYBFou1IIZAjIw/x9Ww+VQiv5oTwMNF1uTb58WCEJ58gv+eS9GCl1851mlT01quIGd2
 b5/6dWJLzngy/MkFcQ5ckY+7BKHdHdzoVH+g47VOqfSdN+QjQCS20jTYt26WjYLHz9tdJF/phL1
 eGEAIN3fnauveYEGENc3A/aFR61ihuQgO5IUrNgxZPhBU7FKn96+uSfCB4BT1XH723cKx1rZQ5a
 nsHGltL0op6P7aUYtG+d94sUrmF/iwMeNFuIp71dXMgLoPRmuctdKABRPxWabFSUelcj3bLxLpr
 +e3Oo6stE0Yk7RoIQvGX/TGuZ6HvykW/m/pBxTT9w/WMVftnejTMRfMCbZEk85qMycycW7PbJMJ
 YTQcHPHPrtR4sKO0ZIJmTy7EtSHC90fDsr8GMM2otiOTEUBvcZROAOP8V8Xq++rJ0uooeW+Fubb
 PnknQhw5PPPYKWD9Nk+Xh/KAurWtkQ0UiSQ9TNh/ic8keqFw/zleyNaxoj9Cv6M54G+S9v/sVPw
 u6ATrxlsh5xEtXZYU6fRCqykt9JOBdGG4TjnBLTSXHqV/5ZHAyxwfQBz4cJQH29wz0W487Q3IQD
 H9lxkP/GGXS2fbgxzZDM3IPLVmAWHEomr77VV6YcQr7dUXW3WztvUNWrRAyFzZ2/LTQMXwtvA6E
 Q3EJNJU4EXqwGussOReaNA6lOr8bLvOE8oxa/GnAsngOk8vtnuVkSUjY=
X-Received: by 2002:a05:600c:8183:b0:4a1:fc0a:8b75 with SMTP id
 5b1f17b1804b1-4ac183d1507mr28928855e9.24.1793354252936; 
 Fri, 30 Oct 2026 02:57:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa81a896ecsm132444005e9.9.2026.10.30.02.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 02:57:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Bin Meng <bin.meng@processmission.com>
Subject: [PATCH] hw/arm: Deprecate Nuvoton quanta-gsj board model
Date: Fri, 30 Oct 2026 09:57:31 +0000
Message-ID: <20261030095731.581512-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The latest OpenBMC release as of June 2026 no longer supports the
quanta-gsj board model (as noted in docs/system/arm/nuvoton.rst);
support was removed by OpenBMC back in 2023:
https://github.com/openbmc/openbmc/commit/ab5062cf6f562ad0c844570ba1ea0089961848ca

If OpenBMC don't care about this model any more, it's unlikely to
have many users.  Deprecate it, with the intention of deletion after
the usual two-release period.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I don't insist on deprecating this if the Nuvoton maintainers
think it's still useful. But this is a "hello, are you paying
attention" call, since you didn't respond when I asked in
code review on a different patchset :-)
---
 docs/about/deprecated.rst | 10 ++++++++++
 hw/arm/npcm7xx_boards.c   |  1 +
 2 files changed, 11 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index dab47b6ca38..c579342b312 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -287,6 +287,16 @@ The machine never got fully implemented and can only show the firmware prompt.
 Given the incomplete state and slow progress on improvements, it might get
 removed again without replacement.
 
+``quanta-gsj`` Arm machine (since 11.2)
+'''''''''''''''''''''''''''''''''''''''
+
+The ``quanta-gsj`` machine models a system with a Nuvoton SoC
+intended for use as a baseband management controller in a server.
+Support for this machine type was dropped from the OpenBMC project
+in 2023. If OpenBMC no longer care about this hardware, the QEMU
+model is unlikely to have many users, so we are deprecating it.
+Users should consider one of the other Nuvoton-based board models.
+
 
 Backend options
 ---------------
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 9c526a26839..ec4b530986b 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -496,6 +496,7 @@ static void gsj_machine_class_init(ObjectClass *oc, const void *data)
     mc->init = quanta_gsj_init;
     mc->auto_create_sdcard = true;
     mc->default_ram_size = 512 * MiB;
+    mc->deprecation_reason = "No longer supported by OpenBMC";
 };
 
 static void gbs_bmc_machine_class_init(ObjectClass *oc, const void *data)
-- 
2.43.0


