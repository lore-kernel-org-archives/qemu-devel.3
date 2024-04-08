Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8239DC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 10:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtmDf-0005yu-Ry; Mon, 08 Apr 2024 06:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtmDd-0005yb-OS
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 06:27:17 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtmDb-0003v5-Rw
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 06:27:17 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56e69a51a33so292535a12.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 03:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712572034; x=1713176834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yxgeT6sGz2Hwa500oxeqpnpagOxlNk9XL0DEkKLleWU=;
 b=Ce+1WVXBgYSiy/WyLZVwqB/cVQbmitH/1QEy15ux7qTj7TlxbP+WhY3LbRy0YgIIbd
 Y4UoCen+0CWKE+AwC63N6h3665Hu61YCkojw0H9kZPu+zELlRpfC5UNKYYVlV1W+gD1X
 ypchOhor7TJdAJ/u7O6G9lN+oQA2WbXePD5C7SRyA6Tskp5Gx5N4Xa3pJogOzBu/bmr7
 RKcG+a2ks1hs1jmTpCX9lXzmCPW8wv9R5NJbnfG7iPfqIjNTHwxpQrmIN+1QaQHRdUF2
 TwwvPtt2i5Q1YHs1j/hpXpW2GIDrAssvJQorPQ+p2rs+A05hcwhIC/ev9COQ6nOu0NES
 EV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712572034; x=1713176834;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yxgeT6sGz2Hwa500oxeqpnpagOxlNk9XL0DEkKLleWU=;
 b=VyNB3J065fl8996nePNU+fZaQD+DNeiUP0Y9mDyDcYRd1Nqm135gKm4VC7T6DHmtqv
 BaTncSZ9sql5t4g8PgAjOL5JEdtBf5iJm1ARtdNlbcPw2g30L3LDyVJRpzj/Kdm8QZWa
 86O//sxWzJ4oW0BQbL+hVv0242X5bF1MVsAZOPWpF6mfz3NPmlnOdV/diyvkC+E+pfUC
 NYd0WtSv/BOnz0D2RFM0gxlX7Iqdg7fh9yzyhXSHE8DW5i4eeKETPvxc6vqfOE3SM3P7
 Xo/qQpXdXol6zMUZIE5jeq1VFg2m6v74uteGYeJiXa6ZsSHNr95k6gt2SrpM9ixE/z4t
 fLAQ==
X-Gm-Message-State: AOJu0YwlSxoXQsEnxCgLQEgIVJXaMJRpzanBGtt+XnN1vgBK2g6wqQID
 HvtJcwP0QWX7jK53Pz3K/Mwmyu0tXaqxGpuIu/Y1zfzZ8yvD1THMte02G3tbi2Jy+K+lYCLZDIv
 h
X-Google-Smtp-Source: AGHT+IGyg4P5tdglvfXs7uao0PxKIolVawJzbFoCTamfgrDqf2diEVHKSQy2pmULwadsZ56qTrhHTQ==
X-Received: by 2002:a50:c358:0:b0:56e:6d9:7bd6 with SMTP id
 q24-20020a50c358000000b0056e06d97bd6mr7471031edb.34.1712572033967; 
 Mon, 08 Apr 2024 03:27:13 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 u17-20020aa7d0d1000000b0056e4a626ff2sm2206884edo.10.2024.04.08.03.27.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Apr 2024 03:27:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-arm@nongnu.org,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0?] hw/net/smc91c111: Fix out of bounds access in
 packets buffer
Date: Mon,  8 Apr 2024 12:27:11 +0200
Message-ID: <20240408102711.58485-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

While the Packet Number Register is 6-bit wide and could hold
up to 64 packets [*] our implementation is clamped at 4 packets.

Reproducer:

  $ cat << EOF | qemu-system-arm -display none \
                                 -machine mainstone,accel=qtest \
                                 -qtest stdio
  outl 0xcf8 0x80000010
  outl 0xcfc 0x10000300
  outl 0xcf8 0x80000004
  outl 0xcfc 0x07
  writel 0x1000030c 0x66027cd6
  writel 0x10000300 0x64af8eda
  readw 0x10000308
  EOF
  hw/net/smc91c111.c:607:24: runtime error:
  index 175 out of bounds for type 'uint8_t[4][2048]' (aka 'unsigned char[4][2048]')
  SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
  =================================================================
  ==397944==ERROR: AddressSanitizer: SEGV on unknown address 0x629000077db4
      (pc 0x56272aed3b8d bp 0x7ffd1471f290 sp 0x7ffd1471ea20 T0)
  ==397944==The signal is caused by a READ memory access.
      #0 0x56272aed3b8d in smc91c111_readb hw/net/smc91c111.c:607:24
      #1 0x56272aecfd61 in smc91c111_readfn hw/net/smc91c111.c:650:16
      #2 0x56272d4b228b in memory_region_read_accessor system/memory.c:445:11
      #3 0x56272d46fb85 in access_with_adjusted_size system/memory.c:573:18
      #4 0x56272d46c58e in memory_region_dispatch_read1 system/memory.c:1426:16
      #5 0x56272d46bcd7 in memory_region_dispatch_read system/memory.c:1459:9
      #6 0x56272d4e8e03 in flatview_read_continue_step system/physmem.c:2794:18
      #7 0x56272d4e871e in flatview_read_continue system/physmem.c:2835:19
      #8 0x56272d4e98b8 in flatview_read system/physmem.c:2865:12
      #9 0x56272d4e9388 in address_space_read_full system/physmem.c:2878:18
      #10 0x56272d6e7840 in address_space_read include/exec/memory.h:3026:18
      ...

Broken since model introduction in commit 80337b66a8.

[*] LAN91C111 DS00002276A.pdf, chapter 8.17, Packet Number Register

Reported-by: Will Lester
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2268
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/smc91c111.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 702d0e8e83..286298bf06 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -429,7 +429,7 @@ static void smc91c111_writeb(void *opaque, hwaddr offset,
             /* Ignore.  */
             return;
         case 2: /* Packet Number Register */
-            s->packet_num = value;
+            s->packet_num = value & (NUM_PACKETS - 1);
             return;
         case 3: case 4: case 5:
             /* Should be readonly, but linux writes to them anyway. Ignore.  */
-- 
2.41.0


