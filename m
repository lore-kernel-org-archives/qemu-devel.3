Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6704BD78797
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAWX-00063n-Ix; Thu, 21 Nov 2024 11:59:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAVy-0004wZ-7T
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:58:50 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAVa-000887-0U
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:58:44 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43163667f0eso9780325e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 08:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732208300; x=1732813100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V6SxJES80JTPviCE8J9qJp14w+aImfeVkk90weg6pzA=;
 b=sB98wbr8XoWHb3Q9WP/XmucF5xQH4iF0fmp0hi/g9eLg0tcGe+xmR40HvD4NG5jMOx
 Im/mzhfNeP7bfoeSuj5j5uupw7YB+WrdyWctDZdrBZ4VVCrToEkESKD5P8LKo7LSRkCF
 NwARN/3FEGszL5zdcCVSjslve7ScObJsuEW3BLBOQqMRFIz6DfdlSCJYGQ9w2s7PXRZt
 XytiYyo3QEgmCkRmCQwMN/LI5zhfmDQt6irbDB24EWf9rhkbU4y1noJnw5u5o2ngzfI/
 IxKTkFL1VQDAA7XfT3nEmyoJHHkx6X+WCWNJ2dDY7/9FuB+Mh6cBLjAgGbBao58u+0Wo
 UP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732208300; x=1732813100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V6SxJES80JTPviCE8J9qJp14w+aImfeVkk90weg6pzA=;
 b=hTB4fs6J5F2uiXhOGIWg58DfmAA5DQcXrjQrko7L/deg39KDIMVOXDHTdB3jkgUl5v
 tCnX1cW5ewQcu3smBtnypqbnMYNJCuWEFlT1gKZUxIbxSesBU7cpPuIzbYzmJs23nVEm
 YfVkw4qEgQkiU/E+fMQucpAOzU6l7y+E1I8KdiD1khgC2109fZvNbhAo0VyCsbqPpOxj
 JrPa3hdeilKBv4p86DSlw9eDIIa9FLPwUoozzPReexxVzPvgvZxKl70oF+XcToX+XiOW
 Rl8BEXpEqDyV8opO3Z7mEwfwnVhxIDj6qWBzVDoOFXRZBHQIB5X5I+MErEvYkserHJiA
 TE1g==
X-Gm-Message-State: AOJu0YyKpfUcMwqyp8UshoEChKxzrw84F8eZcG/3iNp41w1HD4ldZxCC
 7bV7qEdXwB/+LIw5/VfmP3cjOtxekHLhkAODLErEepYJxMLnk8QOLav6zIvUtU0=
X-Gm-Gg: ASbGncvIGqJOLGat3KUjkQ3i3hEZJVLTC8SbD7c5vDps7JxhbwaT32iE8pSlaa5VJgY
 EA3agqNyovuewp2nyJF8PRrRwUpHZqlFoBkxuQAL4KUKYXh4X4G+5eHXVgmNTGqs7AE35JexuZa
 auXEzVgORKqwW9UPkaD+u3FQ308Xp6+iuLttprR3TrcHgrxoqzwXmeFfx7T8vk+ZQquUjdjftXd
 T7EdPYGpkJe+CKr0XJruI+AOwW+oXJ/cfSHg75cCylJRDNe
X-Google-Smtp-Source: AGHT+IE+LeE2Pzi++hrXGW8sI6wK67lsohMMsge1oZ0f7HhqUtkPtaw5ZKcZvhj1bU4G7Tq7YFHk6g==
X-Received: by 2002:a5d:64c5:0:b0:382:4f6e:a57a with SMTP id
 ffacd0b85a97d-38254b18c73mr5959922f8f.54.1732208300201; 
 Thu, 21 Nov 2024 08:58:20 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb27386sm32297f8f.51.2024.11.21.08.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 08:58:18 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4DAFA604A9;
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
Subject: [PATCH 31/39] tests/functional: update the riscv64 tuxrun tests
Date: Thu, 21 Nov 2024 16:57:58 +0000
Message-Id: <20241121165806.476008-32-alex.bennee@linaro.org>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Note we re-use the riscv32 kernel and rootfs for test_riscv64_rv32.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Anders Roxell <anders.roxell@linaro.org>
---
 tests/functional/test_riscv64_tuxrun.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/functional/test_riscv64_tuxrun.py b/tests/functional/test_riscv64_tuxrun.py
index 4e2449539c..0d8de36204 100755
--- a/tests/functional/test_riscv64_tuxrun.py
+++ b/tests/functional/test_riscv64_tuxrun.py
@@ -17,18 +17,18 @@
 class TuxRunRiscV64Test(TuxRunBaselineTest):
 
     ASSET_RISCV64_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/riscv64/Image',
-        'cd634badc65e52fb63465ec99e309c0de0369f0841b7d9486f9729e119bac25e')
+        'https://storage.tuxboot.com/buildroot/20241119/riscv64/Image',
+        '2bd8132a3bf21570290042324fff48c987f42f2a00c08de979f43f0662ebadba')
     ASSET_RISCV64_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/riscv64/rootfs.ext4.zst',
-        'b18e3a3bdf27be03da0b285e84cb71bf09eca071c3a087b42884b6982ed679eb')
+        'https://storage.tuxboot.com/buildroot/20241119/riscv64/rootfs.ext4.zst',
+        'aa4736a9872651dfc0d95e709465eedf1134fd19d42b8cb305bfd776f9801004')
 
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
 
     def test_riscv64(self):
         self.set_machine('virt')
-- 
2.39.5


