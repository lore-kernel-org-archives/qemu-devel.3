Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FACD44C71
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 16:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgPvj-0001MT-8V; Thu, 15 Jan 2026 11:10:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgPvf-0001Ku-Jo
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:10:35 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgPve-0002yu-5b
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:10:35 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-432d28870ddso562781f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 08:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768493432; x=1769098232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jpgxSAtpDvh4znvKu7HJhiw+YyxeOEm6t5Dlx0iqXbc=;
 b=L5B3crEaK+jVrMgMChw7/zxxODNv4UiKScrp1tMMSoohHrhUCW1vXMS4kghm33kYCf
 p7EU+dBt65Qu1drEIvRGPB0pWVllfihxZKNcfRQD1P9wgO33aNLpYK3UedTMhUDQ08/u
 NMDhUZdU5pkr6SQJPvAwByBo3z0Mj2O0P2vwu7no5itJqHe2yrKkVC7YScoBy3I3rlWU
 low/XoVNhJ7D3Pyzsrn64QvTKMODEvoN3+dtZlkVjez4OxmyHPHa4aUr60IW1mk/5Pnz
 FSZiq9AKgtQXlNscxJA4ie9lbC2bIDGyH9fyC9SOo0tylPklXQb3DR9cfRkqTzh7GfAQ
 jtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768493432; x=1769098232;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jpgxSAtpDvh4znvKu7HJhiw+YyxeOEm6t5Dlx0iqXbc=;
 b=e0cnOxhno0HjdUmPfPPpaqZWqIdsT9+JqZi8remy1c5PYtoqxtABuFbHw18f7UWi/l
 5E4FgizThDBcCKy4cAMdaXR/v0KsLc2GTbJzIFyBrAyewaou+0yhlwbS+Olr5IhbVX9C
 I0HpVK3w6pFq75cuU/GjsgkyXoB1vJnuyJCkE4dguiPWJ3zo6TeEN15jOVpzvBATwMej
 IP6EqoiMSYL/BuVxXZbq5tNuIO/lQ4nqvMoraG5d1cvs3kyuJNUUhSSshf433MFb6txT
 lssvFfrBL1Ye0PHzZ2PI/xneRnRf2gXN/rsE/4HAshxRMUm2IVLTvm8+6PJeCLVUKiu8
 AGVg==
X-Gm-Message-State: AOJu0YynQy47kYL4gsEyCL7jsGFLwHAwWQm8iSd8aBQIOxAiqeYNIOqd
 iA7Uz/OhOJ7lCMJNHkMTZioOXF4kX6XnO1D596Pgn8JY8YWTpvBx3BSXIsexJkrsjkL4DqWUC45
 7mCaJpf8=
X-Gm-Gg: AY/fxX58mVBt5rPcYv7zc4hPIpMjCV3ww8sRbRZ5MzGFyk6fcxpdZ5Bnxf0ZY6yMyW4
 Okp1Va9c1m8DhVYdJ3Aj1u/9wDp2p6jniYoNFIPlNhefgr8eaOCiltw3XYuGBeY5H17kDILXhaq
 0cJRM5bJ6suozGEdL3zHY+4/HLX4lP7UWVCFZVBcsWPm75eYG1wyw6IA7q74c1R0k6J9QciWrsC
 4NsaBz38ttTT3HzM5ox5aBY7ahOYXkBTkpPd+dVQ84KHB9rcS6eh47Pe2btzUXLw2wSVyiPwOzm
 hZRjv+J/r/wvbDH4sV+VuMx3Qt6smtepO+Cra2bY4aO7mJllbmUO77/DRg1rC0UW2jSFtpVNM11
 rWHc7Q06tahUpX+ca/+OnPQpfB9rPAYOTrTdgsE4+DHCZXgTcdgT5t74tewviwdlqGJwy3YTTcS
 DMRJiseEf7leUDcAjpIppGkVZxlC6oOIjFGjHeC1QxszgH74D5L5CokFOHbQWZNyrs/MWzoX8=
X-Received: by 2002:a05:6000:2c02:b0:432:8585:6830 with SMTP id
 ffacd0b85a97d-4342c557201mr8997291f8f.45.1768493431618; 
 Thu, 15 Jan 2026 08:10:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434a4cf4140sm6989654f8f.0.2026.01.15.08.10.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Jan 2026 08:10:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tests/functional: Require TCG to run reverse debugging tests
Date: Thu, 15 Jan 2026 17:10:29 +0100
Message-ID: <20260115161029.24116-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Record/replay is specific to TCG. Require it to avoid failure
when using a HVF-only build on Darwin:

  qemu-system-aarch64: -icount shift=7,rr=record,rrfile=/scratch/replay.bin,rrsnapshot=init: cannot configure icount, TCG support not available

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/reverse_debugging.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/functional/reverse_debugging.py b/tests/functional/reverse_debugging.py
index 8b9507674a0..8e6f0b0e923 100644
--- a/tests/functional/reverse_debugging.py
+++ b/tests/functional/reverse_debugging.py
@@ -67,6 +67,8 @@ def vm_get_icount(vm):
     def reverse_debugging(self, gdb_arch, shift=7, args=None, big_endian=False):
         from qemu_test import GDB
 
+        self.require_accelerator("tcg")
+
         # create qcow2 for snapshots
         self.log.info('creating qcow2 image for VM snapshots')
         image_path = os.path.join(self.workdir, 'disk.qcow2')
-- 
2.52.0


