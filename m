Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B14D7879A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAWZ-000650-Bl; Thu, 21 Nov 2024 11:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAW3-0004xs-Am
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:58:52 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAVc-00089P-5J
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:58:48 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4314f38d274so13331465e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 08:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732208301; x=1732813101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0J8O7B8rz7327JxRDKQglna3WLH/kEnovSnEWelS8Vo=;
 b=veXnaYiWzgjzje4yAgtma0DEN7ur/8pFV4kHUPFc1nhQMQaV7YZa4n58WjCeMurym8
 zkpJv+u9bItCkhTGYtpJaV0nJDHPxqHsAjJH9d7UZc7WZvtgs7VVszWfk0G6l7JpvLJh
 /CFZ/2Yi4IjNcvUw1NwGYpEfxTc6y6pgvVHx9Ud5Cc8siNJN6aMHuTN3sZ+Dip5FVs//
 kOz9ZooKtvdBUSf3m4hGdsUPWwlcLJ4k75KZCjZGakuDuF/VOvPaiswrJPhp9xvnkglf
 RzhhB4MDEm/15bxEFQzcjVCFAPgqNrKeeVrOln90K8xb+T5FShlK36zizj6dUKValPY1
 8hyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732208301; x=1732813101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0J8O7B8rz7327JxRDKQglna3WLH/kEnovSnEWelS8Vo=;
 b=R3qxcDUJTMJz/RG9dfFRY1037taGVB54SWC2ToyxT5G5XDlCwmlOjUd0d8p8oVwSK0
 t31qR/PhCInyZaZi3vj/yqDbsIyQqoF1wYF9xyjug+P7MT2kJTq5PiF0EbiM750EGl20
 uj2xhX7UWAk8RFRuCC3encLgMIEVrFRyhythtS/fidJLHOQ+fIfxmxr9Ip79Gycd2Q+V
 JiIIJElzyOMNkcS5aWAI/TbFu54D08BZ2V45//DL3yg4Arwe7LU/sED1VklnZD4+Slpb
 OCSGucwgH1mjQND7OGNXmifLWFhcA+VK1IoYyQpsHiINcs5R453Qlm6XxNZDg2d9E0ux
 jIpg==
X-Gm-Message-State: AOJu0YzaBCNCGyF1lrEFotJDrPJqw8SeBzwblUK5u11bDU6Z2r/eaOpI
 fxbH/HPFOIUrtPs/mR2KzCeGPcMiZS7PpVZfxbNv7yhchtCKId/QLzEJXarcPMI=
X-Gm-Gg: ASbGncsqAlocxLuZ5RS1HgL6WPsHVOYUBwgY8dOkH0i7bzKHQqtxXiUF0fmMMbBPaWU
 kmSMP8tLYtQvggifFx04mTnV/Sl+WyPPALJ3OpJT6jXdZg0lZ8H8diAn42oCp7vikq6h8t0DmOJ
 YcRjI/M4JT8xx7CzkE7HGFwPvNJBsJCZABx6m7Il160sSdVk/BDQsvoeUt3yXMF09axQ7BuPWLv
 O1yP5nf176UWfZbWI30PPseMkQjMKzWkfOcxQM3UGnXshgb
X-Google-Smtp-Source: AGHT+IHrHUSpDrsPdu3fCdaafhILv4IsH9mJhPQ37dBOQiFLK5Ur8PnW7t6NdUCqCPRkr22uuFzATg==
X-Received: by 2002:a05:600c:3514:b0:431:9a26:3cf6 with SMTP id
 5b1f17b1804b1-43348981878mr80507875e9.4.1732208301522; 
 Thu, 21 Nov 2024 08:58:21 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45d4dd6sm65367955e9.24.2024.11.21.08.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 08:58:18 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 36160604A8;
 Thu, 21 Nov 2024 16:58:09 +0000 (GMT)
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
Subject: [PATCH 30/39] tests/functional: update the riscv32 tuxrun tests
Date: Thu, 21 Nov 2024 16:57:57 +0000
Message-Id: <20241121165806.476008-31-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121165806.476008-1-alex.bennee@linaro.org>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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
 tests/functional/test_riscv32_tuxrun.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_riscv32_tuxrun.py b/tests/functional/test_riscv32_tuxrun.py
index 49b57cd428..3c570208d0 100755
--- a/tests/functional/test_riscv32_tuxrun.py
+++ b/tests/functional/test_riscv32_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunRiscV32Test(TuxRunBaselineTest):
 
     ASSET_RISCV32_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/riscv32/Image',
-        '89599407d7334de629a40e7ad6503c73670359eb5f5ae9d686353a3d6deccbd5')
+        'https://storage.tuxboot.com/buildroot/20241119/riscv32/Image',
+        '872bc8f8e0d4661825d5f47f7bec64988e9d0a8bd5db8917d57e16f66d83b329')
     ASSET_RISCV32_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/riscv32/rootfs.ext4.zst',
-        '7168d296d0283238ea73cd5a775b3dd608e55e04c7b92b76ecce31bb13108cba')
+        'https://storage.tuxboot.com/buildroot/20241119/riscv32/rootfs.ext4.zst',
+        '511ad34e63222db08d6c1da16fad224970de36517a784110956ba6a24a0ee5f6')
 
     def test_riscv32(self):
         self.set_machine('virt')
-- 
2.39.5


