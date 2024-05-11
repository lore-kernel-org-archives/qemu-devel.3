Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542F4C25B5F
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 20:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5tIv-0007tg-KQ; Sat, 11 May 2024 16:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s5tIu-0007tL-Ie
 for qemu-devel@nongnu.org; Sat, 11 May 2024 16:26:48 -0400
Received: from wfout4-smtp.messagingengine.com ([64.147.123.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s5tIs-0001pY-IE
 for qemu-devel@nongnu.org; Sat, 11 May 2024 16:26:48 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.west.internal (Postfix) with ESMTP id 336D81C00096;
 Sat, 11 May 2024 16:26:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Sat, 11 May 2024 16:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1715459202; x=1715545602; bh=gQ
 KPojefqIVdr5JNAd4NOG05AsiCaQAwxbfiM2/Wk/k=; b=TNGaTca/4li7kYadib
 yyvyRwTf9uT+hn8brW58dc3DgwGRnJJFKKjVu5BboCCq2SVIKru4t64N7nklB4eE
 rlpBuPSY7iObODG5EUip+s3YBYplc+xQZoe02su9QLgIch6xXRjCUpcJ52fFDIP1
 u8twejNmLOJJfYzTXn3EoCiE6umrUL768Tt6tR8UAHu6KFVnD2AahcuPsd/DzzD/
 GlTz7LYft0qeuTdgkwpcZc1puySWuZzuAHNMRCrkSJ9JgDHIm9zAvNNjZdAt7WEV
 BIYLaSJLLViDDZxHfgZRQo2nAwRZww9bQiOhYECjEDpn2p0stAXlROIKLycOJuEL
 q85w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1715459202; x=1715545602; bh=gQKPojefqIVdr
 5JNAd4NOG05AsiCaQAwxbfiM2/Wk/k=; b=QQRg9dJK+mgKRgU73FV5nv1eFafrB
 3umGZWwgTwsim6X8ZH639eybruHuVnm0z/0vl41BUqR9WxpQt1g//MKr/wlDm9qw
 qyMhyKyy+5f+/SpR6HOjnEdsZOWuLY9yD6alLUdBcR1tOFhryM4BhMMALTaFEgyF
 I1y7BsHlKqRWoyqWTkJLDG2MiKE3X4M+LKujTJRyVjLodHgxUl1FTqkd61UZlD5V
 7jgP56nrNDTiHSF2Sb/xH4PpIuWRaLNu8ZwwbKuXzZSVsX85fqoQHEMQZjtVHFzZ
 d3GTapm4l+OnnKsrJFjs03JPQOo1b5osJaI7AldZSg5oII5gFbqyQ1m5A==
X-ME-Sender: <xms:gtQ_ZrOQCyRtAOXFmZ08NjI5mxikvWEnaauuqMhN75q6O03McikLBA>
 <xme:gtQ_Zl-K56Oqaz7fh3qKpxJVfxPoSL8DyOxC1LQbOqM8FyzuXObcvNS56CFFmgkuB
 jJTJROaMpjZXE0jpzI>
X-ME-Received: <xmr:gtQ_ZqSc27jqUy8oLn3_DFNoO9uNaja3dRHRoj_E_cKMtliXNYxnObM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegtddgudegkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpeffteeugeektdfgjeevuedvgffhgedtvdfghedugefhgeehteeu
 udehudevjeethfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:gtQ_Zvt1UOhzbQo90Yg8Bc8RksuWxhCen-_YMa76OeSjGNIJBJVieQ>
 <xmx:gtQ_ZjeC6d3dsREfKxWGXFqMSMYTpqO3kjVQlnGNs9NGqoueC2aIYw>
 <xmx:gtQ_Zr13BIV1-sqsP_xWTu_TfJTaT0kPwpaFdxEnKu3vF9AbK7P9zA>
 <xmx:gtQ_Zv9aVGHeT4IIv2q7AgVWdsAZBEFSMbZJ1_bQPglsvH16DMQTCw>
 <xmx:gtQ_Zv4364I1JvPinuPIZj59FxqQS3lX7CCNDaRu-rtOauQkpwY0iy39>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 May 2024 16:26:41 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sat, 11 May 2024 21:26:35 +0100
Subject: [PATCH] mips64el-softmmu: Enable MTTCG
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240511-mips_mttcg-v1-1-1b71d9b85234@flygoat.com>
X-B4-Tracking: v=1; b=H4sIAHrUP2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDU0ND3dzMguL43JKS5HRdE/NEsyRDSwNzkyRjJaCGgqLUtMwKsGHRsbW
 1AIaoWSdcAAAA
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2652;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=dQbwlpBpzTP6I6Mh3Lfo9FcvSurXB4/+FmQzeaP8ZP4=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjT7K81bee342az0ArifFsR0iSeH3Ju6rvSlauapRPFjy
 SG35uzsKGVhEONgkBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgInMOMfIcKEwTKpMXehyfIJq
 +vmLDI2CQY7vzRw4WQvsTkxiZz51kZHh4qvLmmxyNmEK9xbtYKz4Zb9lz5ymeg/3vHOT5lSJhN3
 nAAA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=64.147.123.147;
 envelope-from=jiaxun.yang@flygoat.com; helo=wfout4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

MTTCG was disabled in a092a9554771 ("configure: disable MTTCG
for MIPS guests") due to test case instability.

I was able to reproduce this issue with in latest QEMU and look
into reason behind that.

What actually happend is kernel's CP0 timer synchronisation
mechanism assumed a consistent latency in memory access between
cores, which TCG can't guarantee. Thus there is a huge drift in
count value between cores, and in early kernel versions CP0 timer
is always used as sched_clock.

sched_clock drift back on some cores triggered RCU watchdog in
some extreme cases.

This can be resolved by setting clocksource to MIPS, which allows
clocksource to drift together with sched_clock. However this will
leed to other problems after boot.

Another option would beupdating kernel to later version, which
will use GIC as sched_clock.

In non-MTTCG build, the execution is slow enough so kernel won't
observe back drifts.

Test results:

With clocksource=MIPS
```
 ~/tmp/retry/retry.py -n 100 -c -- ./qemu-system-mips64el \
    -display none -vga none -serial mon:stdio \
    -machine malta -kernel ./vmlinux-4.7.0-rc1.I6400 \
    -cpu I6400 -smp 8 -vga std \
    -append "printk.time=0 clocksource=MIPS console=tty0 console=ttyS0 panic=-1" \
    --no-reboot

100, 0, PASS, 5.258126, 100, 100, -
Results summary:
0: 100 times (100.00%), avg time 6.508 (55.53 varience/7.45 deviation)
Ran command 100 times, 100 passes
```

With linux-next:
```
 ~/tmp/retry/retry.py -n 100 -c -- ./qemu-system-mips64el \
    -display none -vga none -serial mon:stdio \
    -machine malta -kernel ~/linux-next/vmlinux \
    -cpu I6400 -smp 8 -vga std \
    -append "printk.time=0 console=tty0 console=ttyS0 panic=-1" \
    --no-reboot

100, 0, PASS, 4.507921, 100, 100, -
Results summary:
0: 100 times (100.00%), avg time 4.233 (0.04 varience/0.21 deviation)
Ran command 100 times, 100 passes
```

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
I'll leave the test case alone as it's already marked as QEMU_TEST_FLAKY_TESTS
---
 configs/targets/mips64el-softmmu.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/targets/mips64el-softmmu.mak b/configs/targets/mips64el-softmmu.mak
index 8d9ab3ddc4b1..199b1d909a7d 100644
--- a/configs/targets/mips64el-softmmu.mak
+++ b/configs/targets/mips64el-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=mips64
 TARGET_BASE_ARCH=mips
+TARGET_SUPPORTS_MTTCG=y
 TARGET_NEED_FDT=y

---
base-commit: 248f6f62df073a3b4158fd0093863ab885feabb5
change-id: 20240511-mips_mttcg-47a6b19074b3

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


