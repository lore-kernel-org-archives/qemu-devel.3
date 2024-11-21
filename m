Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AED4D78799
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAfw-0004wj-VP; Thu, 21 Nov 2024 12:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAdz-0000yc-W8
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:07:04 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAdY-0001i1-4C
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:07:03 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-432d9b8558aso13577745e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 09:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732208794; x=1732813594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bFU4el5KlCeAp3YtkOJsY4eYz2mtebMU2xCmSIZyiTw=;
 b=VV8uIK0ODFgxYEYp915CgjkDG+byNSdd3eDEnpMx3FS/vi9J5GpODEHheZQrvpbEW2
 C36ylmlRV8jiaIh1nRYYnkbWb9PoLSptx7kt7gNcp4bB4RsbJFSEtIN7aHKvxVFXp08g
 r43orLgO+ee5Q/E/DgSoMZIg0hvW4c+NfcoJx4VLnGPGbrUUakrtuUMmmNEQjikICg39
 LtpgBgNVaCojDoMovCh/pq+4hGr2tUSvqfBp3aAKHCwBbJpdiEkRy7HDfcp6BGajrzbO
 iqzWGFZJLULyx38qBv1huUgoAQ4SarouG4m3g4+Pp2LXta/t1PZUAe6N8aMuFVgNfJgl
 SkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732208794; x=1732813594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bFU4el5KlCeAp3YtkOJsY4eYz2mtebMU2xCmSIZyiTw=;
 b=ZLAV1LehS9GJlc3hieWy2y/kQpNXKA1rL5TIvFVmsVfLvR1Ls/+lCrtVZLFHs3Njdp
 +oESTCYVj3S+f3o4Rb5HVI7akEHWafxx8GGeDqFN6aha6+AKwk1KfcIyXachoQlDRo8R
 8P1TgOs5RrwizdVHUptwoq7SSSTgNDJgnvLtHoz/Ke1jE66TPsBd552mb9tYbstWWGo5
 pFileriGLzSzMnoLP2xtHTXJB53Vesq5REzGj5DjVyEtDh78Mp2Iae/KjzDc3E2wCCft
 sl+AaX+Swi03dKjDjW7ODdmlC6NzzWMy9odfOd60fQ53mld4WxuuYvQeWm4ad3zRqqAT
 1Qwg==
X-Gm-Message-State: AOJu0Yy6/tGrmSg6byyD8VVqw7VjNeFZ937afC/LJWpje/NtHiNQSvOD
 JEe50XtptUXIm1VdhwaHIip0yfK+IVfPbSkSd3CsbVcBd6uyPimHv9bjiShuNE4=
X-Gm-Gg: ASbGncu4uYkrFXjss4PANXuQgcnXcGMI7t6R642Prcq+kOkQatg58O8cG3Kkrt7fthU
 tyoBOlOhJejafKhNNrbEDlKxaVrWfuf0tPZ7PAlJiOD1RxLs+OV2YeK0kbqCxZN9gAx7+7TEGIR
 PiXavHt1MvmTX5vdy/hp/l2mIPsQcc9BXHUq610t3oin+w1DOBbsUJ48uGty0YeWmaFcNQ3d3Cc
 /mEoawRnctCy/0s+He0Ur8N5npEcQ6Gbw627IFfTP0Wzf7Y
X-Google-Smtp-Source: AGHT+IGpZzsOfWKIxnHwhDiYdAIYTFTTusnUuC4Lsp7DaH54JkclD9fSEl5Lekatt8v4buYU2bsXcA==
X-Received: by 2002:a5d:6c6a:0:b0:382:4b04:a586 with SMTP id
 ffacd0b85a97d-38259cf1b3cmr3162856f8f.16.1732208793251; 
 Thu, 21 Nov 2024 09:06:33 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc3531sm37567f8f.80.2024.11.21.09.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 09:06:30 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CB11E6046F;
 Thu, 21 Nov 2024 16:58:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-s390x@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-rust@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Markus Armbruster <armbru@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 26/39] tests/functional: update the mips64 tuxrun tests
Date: Thu, 21 Nov 2024 16:57:53 +0000
Message-Id: <20241121165806.476008-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121165806.476008-1-alex.bennee@linaro.org>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Now there are new upto date images available we should update to them.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Anders Roxell <anders.roxell@linaro.org>
---
 tests/functional/test_mips64_tuxrun.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_mips64_tuxrun.py b/tests/functional/test_mips64_tuxrun.py
index 54af1ae794..0e4c65961d 100755
--- a/tests/functional/test_mips64_tuxrun.py
+++ b/tests/functional/test_mips64_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunMips64Test(TuxRunBaselineTest):
 
     ASSET_MIPS64_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/mips64/vmlinux',
-        '09010e51e4b8bcbbd2494786ffb48eca78f228e96e5c5438344b0eac4029dc61')
+        'https://storage.tuxboot.com/buildroot/20241119/mips64/vmlinux',
+        'fe2882d216898ba2c56b49ba59f46ad392f36871f7fe325373cd926848b9dbdc')
     ASSET_MIPS64_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/mips64/rootfs.ext4.zst',
-        '69d91eeb04df3d8d172922c6993bb37d4deeb6496def75d8580f6f9de3e431da')
+        'https://storage.tuxboot.com/buildroot/20241119/mips64/rootfs.ext4.zst',
+        'b8c98400216b6d4fb3b3ff05e9929aa015948b596cf0b82234813c84a4f7f4d5')
 
     def test_mips64(self):
         self.set_machine('malta')
-- 
2.39.5


