Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D464CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 13:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSaU8-00020E-Jh; Thu, 28 May 2026 09:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misetic@osec.io>) id 1wSZ43-0005QG-6E
 for qemu-devel@nongnu.org; Thu, 28 May 2026 07:38:15 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <misetic@osec.io>) id 1wSZ41-0003f5-Ln
 for qemu-devel@nongnu.org; Thu, 28 May 2026 07:38:14 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49050bfe053so32752405e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 04:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osec.io; s=google; t=1779968291; x=1780573091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Hh39+VkWeW9Vgj73BqA9hdVL5mKAmgiDInWKkDeD/Vg=;
 b=e/KEz0NUmity9bDByz6WSnGLQ00AdExhiOuTuC3k90SFQJi1QMNaSlObkKmAkKXVBi
 AASAUL/Sy2jAEJ1qTelN6mxqiRqkS3tK/DYdQ0+UvC+NPmOa4T4SQITgP8VGDJmBJqwt
 qinWupNenaJQhDrusqlxEQKTNiqa/xkLYnaDd4VQdhfTu44GLtyPQY/Nl1hUkurXPU7A
 gJeAxUq7sycu0gFe35pPwLB/3+YPw1a6g4PcoQfG+9MM3+2ctKpy1g46aUbVdBi0T+Oq
 2dQI6MAexWFi2FW/lDhK6JEzS0l4QOsQ+65BYFhHEalDu7rfVO9FXaRQWCP9kUJeYaVU
 LSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779968291; x=1780573091;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hh39+VkWeW9Vgj73BqA9hdVL5mKAmgiDInWKkDeD/Vg=;
 b=fC5mMVh1TWN5ByXqGebjuPzofpBSJbsoB1COrCw6d/MftMxrh11dF4eGTPkpygyMbG
 telE5v1C5t2fgPGo/SICLshQycSW4AMnK9bRN1dTi8IGRCBJnUwvUBSqW3iXeASJ8pkO
 pga9ivysgeQh8Uo1y7Q+Xyn9KH5eHxGMD3HMATkwdMX+Ktpd+U5PPuhAcBNGM7FXu/IK
 TVMjz8Dei/IZhIyRRiTDOLGAd2lVoZ92fklkhvnMFuG+LwSq0DzGAQdb4CzlrYzzXpxE
 Ms9bxqwVAqLX3Z/AdWBShDsUw5PfysBuQxXVjx2C2/GwyIM+yKm+RbTuGGzFF7O9vSQy
 KwwA==
X-Gm-Message-State: AOJu0YxZyvkn0zvgAOFLsNVB/2/rJrVPdVKbif1wXcSIjJRqnhl+LwPk
 a00KTzr61bWpAN5w/cYi3p6clytiP46J74bxukBP3h2784FiX0y2jwOVZov1EdjS6atiD3+7uVv
 euEQEkzEoxtr4SuFRszTrWPXoCLVit0dq3wBucxP9Eyxp9+8gTr4P1/B9sDHzzTtLnYgJJt2bMV
 kkFdFl2TwyIwwAp/Js+jF82Njq7uQGN/CilxgreQ==
X-Gm-Gg: Acq92OFLD1XWWDn+X3l5fy2ouh7zU+/gN/m9ovH6hI/E0RqgjfXhoyCUCL3ESwmTzlA
 PGYNRnbyoEsgKkr5EQzL0nR0ZkcxXZJw1QMC1LVahCeTAgn0xGER2u2S8wjIN+xSt2ruW6E7v5U
 uNvAbZ9/uSiqU+WoHX/2F7+kaeKTX4RIkuTMDTiGSvlG2QY3nKrMLO5z/EHS/FzgCGRpsRlOK+i
 vqGo24MdLvxgYn6N0ofSNIGIK7b3xIvVLnCJbqxlvzhAynVx1F8TnHYoOYC8g5zOaLLOZ91cf9c
 j319illYNYtLGR0fCtq0VOXb6v/m7u8F0oVPV/qBPlCJPaH3Svg1ueBPa8C7x9eFZlor+bUE3zs
 YwAl0l83N/oXpjOQ2W6eGv+zGn2kKIpsY+gOFwnbLWOjSKpPZ0CtC7fG+AFeChclpF5n8AcxRwX
 jQ/UoRf6CBRa5w8vSu0vPeWaE7zlj64Ds7OyxZ7aF9ZfeNBKXtSnYaERI=
X-Received: by 2002:a05:600c:37c8:b0:48f:e518:d110 with SMTP id
 5b1f17b1804b1-49042ae09eemr457910235e9.32.1779968290883; 
 Thu, 28 May 2026 04:38:10 -0700 (PDT)
Received: from localhost.localdomain (adsl19ht4.tel.net.ba. [92.240.41.4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb54903csm13343097f8f.6.2026.05.28.04.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 04:38:10 -0700 (PDT)
From: Hrvoje Misetic <misetic@osec.io>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 Hrvoje Misetic <misetic@osec.io>
Subject: [PATCH] target/i386: Add missing CPL==0 check when returning to VM86
Date: Thu, 28 May 2026 13:38:08 +0200
Message-ID: <20260528113808.86036-1-misetic@osec.io>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=misetic@osec.io; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 28 May 2026 09:09:10 -0400
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

helper_ret_protected only checks if the VM flag is set in the new eflags,
while the Intel manual says:
IF tempEFLAGS(VM) = 1 and CPL = 0
        THEN GOTO RETURN-TO-VIRTUAL-8086-MODE;

As CPL==0 check is missing in QEMU TCG, a 32-bit binary inside the guest
can elevate privileges by executing an iret and returning to VM86 while
setting IOPL to 3.

Fixes: 90a9fdae1f1a ("more ring 0 operations")
Signed-off-by: Hrvoje Misetic <misetic@osec.io>
---
 target/i386/tcg/seg_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 58aac72011..57cf668131 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -2068,7 +2068,7 @@ static inline void helper_ret_protected(CPUX86State *env, int shift,
             new_cs = popl(&sa) & 0xffff;
             if (is_iret) {
                 new_eflags = popl(&sa);
-                if (new_eflags & VM_MASK) {
+                if (new_eflags & VM_MASK && cpl == 0) {
                     goto return_to_vm86;
                 }
             }
-- 
2.48.1


