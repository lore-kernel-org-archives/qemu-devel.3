Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB98CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 09:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruU23-0005xu-2h; Wed, 10 Apr 2024 05:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU21-0005x4-Ci
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:14:13 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU1y-0005b4-GH
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:14:13 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a4644bde1d4so883637666b.3
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 02:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712740448; x=1713345248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qxZBIWm4tgxEEXfwbtjrHn2I7XDplBRXPRN1tLGRLQA=;
 b=OlHQvv2iRL1kMwJPjfJ9lp1SyKf5m9/yk6nqLdQrJVQ2j6mn3rmd/1dOK6ds3NHnjM
 EbjJohb598s3SI7mvKbmgXN4gMcBmqkj36xKOr9+npNBNhGVjSkm9eRmyjSgERLrvdpo
 XajwAb+UoGXJwCtqoW/yLfcHmwENjjlTPXC0HCv+u1zrVMR3v/zfVXUu2w41bbilTw9R
 2QqIEpBb06NJV/oPJxHDKQt21zssNfk1jw8YVmYHrO9VeH1h29QVARhAxJvXMPSxbk1K
 x9ASERYFKU93MM6JYvXnc6mxDkNwR2y6+zmNEG1Br6TRL3LUAbznlEwANqyS3zPOCQm2
 J+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712740448; x=1713345248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qxZBIWm4tgxEEXfwbtjrHn2I7XDplBRXPRN1tLGRLQA=;
 b=JnMKwMoGXL9d0pkOycKE1yo5Wb4xRbZsZR834Cumhfa/wdYx/++gn80ZJMfMSHtcbT
 xTavoMIjAeppy/7DJrgx3ScP1jlM+kWrK4Xs/qYYw38ukJyx/IgCqrk8OI+nW0R3SnwZ
 iYCOtVfz1/X1WYssg2DUjLuwOtSm4bEiOjB9aNA7xBWk+BB+z4nR2MLIBzL+UMGE4j//
 +Ig3g4XTHHs1aT+D6b/ZhbvtiiG5n2DGKARFbEHzgJu7+pkcHG8ahRJhZcej9BEfhAR9
 fvPIcDV98Cc+b2HDgBnVzXDMpz5o88i+fhnGV37ta4y4JDVxhGSgBu7uJ4cp3k1BYQxT
 tgkQ==
X-Gm-Message-State: AOJu0YyKEbhm72uq0m4p5W2/TwkzTyRC4cDchDfPoIyeV1JZLQmStQl5
 fIaJcpRDp5O/CUZABrgMWwhYdTonqpVX7A7kbDzFB5dCTKO8KJKjiko6FgDLh8/xbeHy2yWbmy6
 S
X-Google-Smtp-Source: AGHT+IHal/yCxZbs+KzSvnDU/FItC8yAP3XgpbwhGMLLreT4BAJhrVqZt/Ofe8Y48yXtaTR7s5ebhg==
X-Received: by 2002:a17:907:7208:b0:a4a:aaa9:8b3b with SMTP id
 dr8-20020a170907720800b00a4aaaa98b3bmr1295738ejc.77.1712740448595; 
 Wed, 10 Apr 2024 02:14:08 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 me6-20020a170906aec600b00a51ef986051sm2016438ejb.57.2024.04.10.02.14.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 02:14:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Qiang Liu <cyruscyliu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 08/16] hw/block/nand: Fix out-of-bound access in NAND block
 buffer
Date: Wed, 10 Apr 2024 11:13:07 +0200
Message-ID: <20240410091315.57241-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240410091315.57241-1-philmd@linaro.org>
References: <20240410091315.57241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

nand_command() and nand_getio() don't check @offset points
into the block, nor the available data length (s->iolen) is
not negative.

In order to fix:

- check the offset is in range in nand_blk_load_NAND_PAGE_SIZE(),
- do not set @iolen if blk_load() failed.

Reproducer:

  $ cat << EOF | qemu-system-arm -machine tosa \
                                 -monitor none -serial none \
                                 -display none -qtest stdio
  write 0x10000111 0x1 0xca
  write 0x10000104 0x1 0x47
  write 0x1000ca04 0x1 0xd7
  write 0x1000ca01 0x1 0xe0
  write 0x1000ca04 0x1 0x71
  write 0x1000ca00 0x1 0x50
  write 0x1000ca04 0x1 0xd7
  read 0x1000ca02 0x1
  write 0x1000ca01 0x1 0x10
  EOF

=================================================================
==15750==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x61f000000de0
 at pc 0x560e61557210 bp 0x7ffcfc4a59f0 sp 0x7ffcfc4a59e8
READ of size 1 at 0x61f000000de0 thread T0
    #0 0x560e6155720f in mem_and hw/block/nand.c:101:20
    #1 0x560e6155ac9c in nand_blk_write_512 hw/block/nand.c:663:9
    #2 0x560e61544200 in nand_command hw/block/nand.c:293:13
    #3 0x560e6153cc83 in nand_setio hw/block/nand.c:520:13
    #4 0x560e61a0a69e in tc6393xb_nand_writeb hw/display/tc6393xb.c:380:13
    #5 0x560e619f9bf7 in tc6393xb_writeb hw/display/tc6393xb.c:524:9
    #6 0x560e647c7d03 in memory_region_write_accessor softmmu/memory.c:492:5
    #7 0x560e647c7641 in access_with_adjusted_size softmmu/memory.c:554:18
    #8 0x560e647c5f66 in memory_region_dispatch_write softmmu/memory.c:1514:16
    #9 0x560e6485409e in flatview_write_continue softmmu/physmem.c:2825:23
    #10 0x560e648421eb in flatview_write softmmu/physmem.c:2867:12
    #11 0x560e64841ca8 in address_space_write softmmu/physmem.c:2963:18
    #12 0x560e61170162 in qemu_writeb tests/qtest/videzzo/videzzo_qemu.c:1080:5
    #13 0x560e6116eef7 in dispatch_mmio_write tests/qtest/videzzo/videzzo_qemu.c:1227:28

0x61f000000de0 is located 0 bytes to the right of 3424-byte region [0x61f000000080,0x61f000000de0)
allocated by thread T0 here:
    #0 0x560e611276cf in malloc /root/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
    #1 0x7f7959a87e98 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x57e98)
    #2 0x560e64b98871 in object_new qom/object.c:749:12
    #3 0x560e64b5d1a1 in qdev_new hw/core/qdev.c:153:19
    #4 0x560e61547ea5 in nand_init hw/block/nand.c:639:11
    #5 0x560e619f8772 in tc6393xb_init hw/display/tc6393xb.c:558:16
    #6 0x560e6390bad2 in tosa_init hw/arm/tosa.c:250:12

SUMMARY: AddressSanitizer: heap-buffer-overflow hw/block/nand.c:101:20 in mem_and
==15750==ABORTING

Broken since introduction in commit 3e3d5815cb ("NAND Flash memory
emulation and ECC calculation helpers for use by NAND controllers").

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1445
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1446
Reported-by: Qiang Liu <cyruscyliu@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240409135944.24997-4-philmd@linaro.org>
---
 hw/block/nand.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/block/nand.c b/hw/block/nand.c
index 5a31d78b6b..e2433c25bd 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -255,7 +255,9 @@ static unsigned nand_load_block(NANDFlashState *s, unsigned offset)
 {
     unsigned iolen;
 
-    s->blk_load(s, s->addr, offset);
+    if (!s->blk_load(s, s->addr, offset)) {
+        return 0;
+    }
 
     iolen = (1 << s->page_shift);
     if (s->gnd) {
@@ -783,6 +785,10 @@ static bool glue(nand_blk_load_, NAND_PAGE_SIZE)(NANDFlashState *s,
         return false;
     }
 
+    if (offset > NAND_PAGE_SIZE + OOB_SIZE) {
+        return false;
+    }
+
     if (s->blk) {
         if (s->mem_oob) {
             if (blk_pread(s->blk, SECTOR(addr) << BDRV_SECTOR_BITS,
-- 
2.41.0


