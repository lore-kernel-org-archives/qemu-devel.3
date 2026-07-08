Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46952C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTqd-0001If-E5; Wed, 08 Jul 2026 11:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1whTqb-0001IJ-Sn
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:06:01 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1whTqa-0004Hv-Cy
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:06:01 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-47c6e9a694bso464715f8f.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 08:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783523158; x=1784127958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dRVxux8pVs6A+vZHuDVUKWF789ad5oaDNJlk9cNHFEc=;
 b=qbMSwnSDI9bIriuVw7wRDdiuXqAU1thGCIKnuzH11BxnUsokvJ7iyXhFTv8f9x6Sx2
 xmHnlYVnvuxn9k+tPFNN2HhVyLKmWQ3zzdWCJW54fnm+bd5cs16McjYYn0JMmyaaAvUX
 FflUmOzgy2hO+6Zr01/Hy0Pmcwvmx/pFtxit9RDbQD+cE7l6zZvOPi6c2qADOzZLfOVM
 u0TpgeWpChDgFJQBekcMbu8Y4ZJIHOEk5dNHP92qWRvVWvPDocwoBgvJpT4nFboW0QfP
 k/4gZ+1une3SskVNuzfsWxBlAK8pkJnuoWzzePrzINd1b2InBugV8wHLJn+pwSubEJ5r
 MxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783523158; x=1784127958;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dRVxux8pVs6A+vZHuDVUKWF789ad5oaDNJlk9cNHFEc=;
 b=V3OQdNYP/fyRKeJmCtcX0rum9ddsGsq0Ri5qt27RyIxZyNho05qlrs+2A/QpVjGHbb
 pmwqRJJQhax3ly3eHRPX+Q8jdcSTbOfA+qawAet1NvLL5fgDvzp2acnRQa5NsLbhlfXL
 tZk4Uw25tXSFpX74Ix+tz9zwSSoxpAh8SS6TnsI+DL7Cwuge5aHpJbF20edgbkLgv1e5
 1tOKMyhixiUAL8dQdejyG+X/4UYS/teHxGwgkSDGs6BgxOTUlhfq2JcBKBtCfxszFDRf
 j2Y06jUjFDyUw391RZ75mYaRXnq8R3EwQJPi1JWnG/fMr88tBGjalT+/XJ6L2xZ1PrSD
 oJag==
X-Gm-Message-State: AOJu0Yz0ZVGDF5pJ9Vur8UPEp2x5F1tflORPFl60uRBrBjMDqO3RxghE
 nhQz6qgTCua+429x4sU9rt45hZYlM+neAdmRU0TnbyndCID6vVTs3MaXJ6DFglRL
X-Gm-Gg: AfdE7cllz0Yj2IWXk8N4fKPfakZ/lDpkw3BFkVq7Fv8Lb6Slq6P6X4cTFkGYS3tIfXP
 pFT+FWeGZJKlJrtAel7ZdxZOO5hbIbLNy1W/7g3kaMfGQKsYYDFKiB5qB+hRvvosI3g9Bqd2kHP
 LTYiQiiUphm2iUUWGbPhSrgHmrwik/kjbQHi41PPt1l3aVY/1qdWyuLAJIUKEyJf/HsIsvu5bkY
 nvQKuh8I2KhTUGN/z+SOmiu+Fu1tlJqsRM1rq2jwSp5ihfEI7QH1As44UdJW+NKAeGaS08s5h5K
 0G9slabx157Jaa/kTSGs3dd1JU74w0AQ8v6zvCnMt6GP5VdhgGNA8SdB3C4Jlxi42GYFZu0KZtF
 xtYfT36P9DtcdGAY3HbI1lfBEc10xGCEeHnaIiPqdSLblPJnLDhhOrf2F+YAwUznS7aWOod1z9H
 Q/XWxeiVmbkeuJrLpIelAzfyiizrW3qdriUDOjlLKEYpUeppsmytt7EEJlD4pAY+vWAKpBECF34
 mLp1/xAAaT/
X-Received: by 2002:a05:6000:24c5:b0:46f:7d90:8114 with SMTP id
 ffacd0b85a97d-47df07b5278mr3414530f8f.14.1783523158275; 
 Wed, 08 Jul 2026 08:05:58 -0700 (PDT)
Received: from octofox.lan ([212.156.228.190])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039bcdasm44666812f8f.21.2026.07.08.08.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 08:05:57 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] tests/tcg: fix buffer overflow in
 multiarch/linux/linux-sigrtminmax
Date: Wed,  8 Jul 2026 08:05:41 -0700
Message-ID: <20260708150541.2137546-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Fix new_argv allocation size to be `(argc + 2) * sizeof(char *)` bytes,
which matches the way it's used to store `argc + 2` pointers.

This fixes the test for me, which otherwise fails on xtensa with the
following message

  linux-sigrtminmax.c: 59: main: Assertion `execve(new_argv[0], new_argv, environ) == 0' failed.'.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/multiarch/linux/linux-sigrtminmax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/multiarch/linux/linux-sigrtminmax.c b/tests/tcg/multiarch/linux/linux-sigrtminmax.c
index a7059aacd9cb..b5ea65f3d393 100644
--- a/tests/tcg/multiarch/linux/linux-sigrtminmax.c
+++ b/tests/tcg/multiarch/linux/linux-sigrtminmax.c
@@ -39,7 +39,7 @@ int main(int argc, char **argv)
     assert(qemu);
 
     if (!getenv("QEMU_RTSIG_MAP")) {
-        char **new_argv = malloc((argc + 2) + sizeof(char *));
+        char **new_argv = malloc((argc + 2) * sizeof(char *));
         int tsig1, hsig1, count1, tsig2, hsig2, count2;
         char rt_sigmap[64];
 
-- 
2.47.3


