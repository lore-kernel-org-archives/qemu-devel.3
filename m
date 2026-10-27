Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A064D606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0v5UnAHs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiDo-0000Tb-Of; Tue, 27 Oct 2026 10:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xLiCh-0007KL-2f
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:31:13 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xLiCf-0005CT-HK
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:31:06 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-93efc0452b5so275082285a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793111464; x=1793716264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x4IaF9z025l/Fpk2IsxGNfdeO5acQjE/iVO9VTHti00=;
 b=0v5UnAHshkW9461/PXPcU9GoCynKP/Otw1RyMQCI+ZNokNNbBCjw3NTele4EjhStzK
 d2EVkEqm8tQd77Rn3VEouYvNRSZhOWuJmYykAN2Fi5+RsZaS+61ZplaRIGpFT7KjlBlh
 g+li+HaKMbUvik+jIkVy38o15dluWtAgogNwqGac7Zm/SVPEKr/GxtJtt1g7Uxd61yns
 WhVx8aszxt/0sn2oxWs1bzFwRy26u8JXFMSCQcWRIo6Iy3pnGU+u3yhVZ0NcohLPYwLZ
 eR+rWUttB+BBcqV4S/IF9RKUfEtBdbXAZ3uQjMTUUUPwieb1+CBS+CoY5ss/HazEGvFn
 ansQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111464; x=1793716264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=x4IaF9z025l/Fpk2IsxGNfdeO5acQjE/iVO9VTHti00=;
 b=MyVuiZJO1+ZmoAXxAbkRzISl0bhEMAZ7D8uhvh9iayRHp0mQKxU62xaYrc4EXq/Zho
 D20yArqOhyN6xzjGTXe15bfNs6DDfVBc4Yr5gjeJ1Lu33wf17/Wwczbv8pgqo1+v9PQz
 Qq3W7F9lPAzJGkvN0sBvyxN8xgpaGRkGTnI+ZiIfNHzst1nY8zdJV3qXRBAS+kP9cXa1
 MM7uWjo+9x7HCBADcrDcd7+pVYPXoiX563eEoyAkE8po72u8b0JPkSJw1DCNrTMmISNo
 nQvgBn7g2LgbAugo3BazimJJ22464rvST3UjTAHwbNvo+l+qAjXTlQc5jYisrEyLzXSx
 AXPw==
X-Gm-Message-State: AFq9FYKLVnekV5FJBexE4YRLmovkgvey+rRAILJC2uugBr6AWl/SKjDk
 4Umk/cCZTl2jDGfxMJTlTJ0dHs+iQ5C0xtrMN6bNdvH1qCq7sWHFsraBIqfTWCiR
X-Gm-Gg: AYBFou08XG0k2Wjgq/Dg3z3qApOGMBShLQRpeh+XL35m525J/R35y5HYOzS6hsmA9ad
 vEnySWY18gxF+0Y88sG1EuhN+XkZOpG1k1mo2b+arIWXe1oCfk3+fxuaaORexC7sY/h+QcobvPg
 l1DNBlHqdxCUjHJ2wBMe7Um8EhGaycf3p5UpHuL67bHFixo/nat0EcKmhuAoQo1SdgVEUqjMoLm
 YM+Ai5AE/jNLlC1Iwm+6M2kax1yMRK3xIq5xm3jKZXc0vUIKU9yakSFl5Y6+LZMwzrzI3EhbBRu
 ZBpEJhC3iQHVS/FNq5qb3HDZlxIjr51/FvsI3fQZitNXcFG/Qi4hHNHPTcYYInKus1MenTXt6gN
 AY09ezlfc2JDhASD0EOfKOSrr5zd8iF5hqQ3CF+f7vJLKjtA/+XOOxId5hsY8KESG9ptRLXqLMm
 xvS+t+p9M4hdiIvC4v7ASHWrty6q+xg0tmSxwzQDimviuB6LJOnKGADjtc0epuEKSwVjq/5LIEK
 3qdp+VBXR6Rgr+4/hnERDjld+jM7UaE1/3Ss8o63Se4v7IyxqlU6nqiQLVhN1U9XqO+g6iwFMf/
 z+8nyYkufxTELzaE8hpKHc62tDXP1QAYFSJRG9eTaeIv5kIM15U=
X-Received: by 2002:a05:620a:4008:b0:93f:3bb5:545c with SMTP id
 af79cd13be357-940ef914106mr1625290885a.18.1793111464410; 
 Tue, 27 Oct 2026 07:31:04 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:9872:3600:589:5f3a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-940f0a78c06sm986400885a.35.2026.10.27.07.31.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 07:31:03 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 Marcelo Manzo <marcelomanzo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v6 16/17] docs/system/arm/raspi: move PCIe/GENET from missing
 to implemented
Date: Tue, 27 Oct 2026 10:30:35 -0400
Message-ID: <20261027143036.44973-17-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027143036.44973-1-marcelomanzo@gmail.com>
References: <20261027143036.44973-1-marcelomanzo@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qk1-x732.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

raspi4b now has a working PCIe Root Complex and GENET Ethernet
controller (added in the preceding patches); move them out of the
"Missing devices" list and into "Implemented devices".

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/raspi.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/raspi.rst b/docs/system/arm/raspi.rst
index 44eec3f1c3..a8fc37e920 100644
--- a/docs/system/arm/raspi.rst
+++ b/docs/system/arm/raspi.rst
@@ -36,10 +36,12 @@ Implemented devices
  * VideoCore firmware (property)
  * Peripheral SPI controller (SPI)
  * Broadcom Serial Controller (I2C)
+ * PCIe Root Complex (raspi4b)
+ * GENET Ethernet Controller (raspi4b)
 
 Missing devices
 ---------------
 
  * Pulse Width Modulation (PWM)
- * PCIE Root Port (raspi4b)
- * GENET Ethernet Controller (raspi4b)
+ * PCIe MSI/MSI-X interrupt delivery (raspi4b) -- INTx works; a PCIe
+   device that only signals via MSI/MSI-X needs ``msi=off,msix=off``
-- 
2.55.0


