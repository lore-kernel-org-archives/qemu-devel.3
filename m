Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D01FD7879A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAde-0000Dg-A6; Thu, 21 Nov 2024 12:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAda-0008I7-Vj
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:06:39 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAdR-0001aC-CW
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:06:38 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4315eeb2601so13358175e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 09:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732208785; x=1732813585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v7PcFAUN+QI/IN3kZDWblpe2r+If/B/i2TwqX+gbbUo=;
 b=OT+O1/6GSZ4e4tEC2oLxctCKAgLNKE4RstYOgkzEyCZJZLF+595lCEx32F/ehZaG54
 hPWBL8pYNVvbbE+AvsG7laZbs4aSBwa5R+it1FFdo3fuMn7tJI0Tkn0jPbwbnN3+DSVS
 kPCsjD4eWoHwAZsUE2ChOlvleAN61MXFQE3ZA3QlVS8yZAGtRpcj1OQhPVLT2L+pwIp+
 v33wcZuzCDSAG4NDsfmm3nR5J/HM0ZQ0kyRTqFr/KjFnmJzWxbkmk/0cEDyTki61YQ11
 XX2JKMbc/lC2qUjbhkZ0Ekq1k8XIidgqfym/b4ztHizz1VPE5/hKDtxO8MAAssvTwrOL
 KjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732208785; x=1732813585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v7PcFAUN+QI/IN3kZDWblpe2r+If/B/i2TwqX+gbbUo=;
 b=KVfzQwHvO8N5QtfhOhPRhAAfmLzRQeOhdFdMjamhtRVi/GpuRdjly8jvij/Bf2gWp+
 WOhpV8/GmxtejA3CrY6k5fY7f4ngpyIqlXGaqb/hrga75x/qybrIEtt8HG8P/37jkfAw
 V5wXzSxBOlt93BxOYr0XWNBp76AoapYIlDQGEVrY+MLgbvByAVCScN2wcgUutVd/LjmV
 f9saNGhN6eZJIsYWuii/TbVgErYWD9MCtI38fBTN/jn6DT+NJA9etypPf9IGIatoPDNZ
 oapb0VMXUoKnNk8msCy/VYaDBrhYdGwJnDEQvYGh1D4VQChtde0ISQp06Ia+sFbjzJKX
 rW/w==
X-Gm-Message-State: AOJu0YxHcNhD6kLzNGdHZU7labtZQmO/PbM5sNEpqcgov1wnC39aKyLY
 eAUED/esqP9DIUokETsD1paryKGeTZ28+t2Y15BqOUEZvU79UwkSlbL6oHnima0=
X-Gm-Gg: ASbGncvjyM4FBic2NpZf7ophDv0K2cbos6W4GhAW4Z7sQ44nbZeFRdQzGrWxg+3rUqU
 zoyV3+23sXPAb8Vgt4rwQlcGX4Foahdrg70Qfer4EGBCBSGtwy1hp3qcz8MDe9Kjp91Nchqazrn
 as9cJFqCdeOI1imJgNR5L/sPwL8rDLkNZfGb8gclRURvRVI3xqmc89koY9ST3nqJKBbJ+WAbOhH
 9PFuTA6wq3ANsYMxtk6ZQ+zGAGr7RGzYcISFQgE+9poPSGt
X-Google-Smtp-Source: AGHT+IFkNgK64zCIjQB60w+M5qeXV/kUk+nLtFcGA8ZCFcwj0g8v0GKlHRzArsN/q7iyvIyLdop68w==
X-Received: by 2002:a05:600c:5013:b0:431:54f3:11ab with SMTP id
 5b1f17b1804b1-4334f01e2a7mr71165055e9.33.1732208785021; 
 Thu, 21 Nov 2024 09:06:25 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432f643b299sm61613635e9.0.2024.11.21.09.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 09:06:23 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9B52D60454;
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
Subject: [PATCH 24/39] tests/functional: update the mips32 tuxrun tests
Date: Thu, 21 Nov 2024 16:57:51 +0000
Message-Id: <20241121165806.476008-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121165806.476008-1-alex.bennee@linaro.org>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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
 tests/functional/test_mips_tuxrun.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_mips_tuxrun.py b/tests/functional/test_mips_tuxrun.py
index 6fec44c2bf..6771dbd57e 100755
--- a/tests/functional/test_mips_tuxrun.py
+++ b/tests/functional/test_mips_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunMipsTest(TuxRunBaselineTest):
 
     ASSET_MIPS_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/mips32/vmlinux',
-        'bfd2172f8b17fb32970ca0c8c58f59c5a4ca38aa5855d920be3a69b5d16e52f0')
+        'https://storage.tuxboot.com/buildroot/20241119/mips32/vmlinux',
+        'b6f97fc698ae8c96456ad8c996c7454228074df0d7520dedd0a15e2913700a19')
     ASSET_MIPS_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/mips32/rootfs.ext4.zst',
-        'fc3da0b4c2f38d74c6d705123bb0f633c76ed953128f9d0859378c328a6d11a0')
+        'https://storage.tuxboot.com/buildroot/20241119/mips32/rootfs.ext4.zst',
+        '87055cf3cbde3fd134e5039e7b87feb03231d8c4b21ee712b8ba3308dfa72f50')
 
     def test_mips32(self):
         self.set_machine('malta')
-- 
2.39.5


