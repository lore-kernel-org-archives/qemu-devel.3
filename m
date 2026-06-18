Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4561CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBvU-0007ui-0M; Thu, 18 Jun 2026 08:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBvS-0007iv-7z
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:32:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBvQ-0001JL-Ha
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:32:53 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAs1Rp1055622
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gynoFaTDRgadZxzy2S/i16dtH2vqDTS+uWrxte7QDqo=; b=a9FhMLVZaTgx7PTP
 SWPXJxIy5c7fshIML0uTdqD3PM+eDcvdpmNcrG9zXeie42tyPyklUqBLuah09CzW
 2cf5WNRdT4GVAK/wLV6VeD0GTc/Dfzrj1Ik1UnMrBNr/ms+DrlqrX11FQqICSfWz
 ZeR5bNa/MBBUyZL1KGgD18XwYPcf/aH+KYM0ZbBk9gCUzDTrox9RgRDGRb+hDepo
 eMDooxbIJs5cVyvMhdOzOSt3w5PWCqCw6dIpDfXMU4WnwiZgV6gp5lfp256j66bQ
 4lVrQM4rVB2kktwz6zjN3h2HWt87+xBBkROQZJ8cJfCMaxJ04NLJ/ubDlIKDSd4Y
 D20J6A==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2ccfny-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:32:51 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-966d2fd33b1so152485241.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785970; x=1782390770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gynoFaTDRgadZxzy2S/i16dtH2vqDTS+uWrxte7QDqo=;
 b=Nicqzntapae7t4k/bvDaOcDDihBAN/peyAhvxiJVamPW7zcneZTIFMMiLM+A6HIwdO
 mRhxXzXIdJAYbO/gc1WHNrm9nbwHx3FzhkojPH0BkxsAMtigB8TM7mWMxgnZKI5uPKPK
 bMe8eR70xNEbVib50/vGlJ/vWTVvypJZTtDvdGW92K3Q4ktq6QVA3LRFJRlvahspQyeQ
 s0XiQt63A8UerZIT+zmc+Vb+DrxTqghxyQ8zbnCWNag6E9aembRi9/jSj0kUPZlvZjlV
 kBiXZCK/CxEZrob/pI5PEizpC9tw/q/hTOR6AXTSYMtp6wLYJAl5u5h7pv/p4qIObig4
 Td9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785970; x=1782390770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gynoFaTDRgadZxzy2S/i16dtH2vqDTS+uWrxte7QDqo=;
 b=N9rExChLNwZfj31fNbRQszA4dyg55ADPwbLn9kQIYc+by6ln0O0pSAVnohpbtmja+L
 yYjrBnXYYP3vxwR/vB4YRAxn1r8EstGxldMf8rhgqs5fxqe7Ds712LmdxZ6V+84Ka76R
 Q5YFFpiITijG+/vgL6PNQemqXpKAPitsEkigUj/y8IiQpsVL/k1+/NecX83ElLVibcee
 v9xbVkT6XEFY9RGqXt1MdOPySfemBuRj71WP/pKvERhBNoiPqgES3ojjlQh8YrCTyUYd
 GDPugTkLBkxiOiRSbb4ioOwuM4lv3rY1L5CA7jC3A41KqKZyIZCZflGorVlTOfwQYVDC
 bKWg==
X-Gm-Message-State: AOJu0YzxP8uY73gyR4q9qhwe5j6XLvh+1CUMv5pTtK0HJxdw0zouNT35
 hUw5qwOPjN4kcJuwScLkZmG0ofRaklSGfrEbx8Ihl5f56yUCHgTPp5D4oJh8g/W0o7rp/RGwujH
 QRKlm6rJnwwGPVWS4gV8e43qbMw8e/w3x1WsxP8ZG1YX5MeczxDtOU82Up4KTF1gaTA==
X-Gm-Gg: AfdE7cks3FmBrJt9XTQIHQagibKkPxwd0dtLsVfEqHMbzS5q7xsbB+2AdptVJngUxo0
 hpQEHHU1gPPDAwqVQyor+QtcoO8afZItxQrFJzkKcoC9JjpeSno9Ob0VGBLPT6Ptd2QSNJbdx+I
 US1fyAGmSKTI9mmDWjiB8Yr/A/tpLy0wR/pFazCUd6fGfKMjbIag8oo9RCJBsVl33rUiFoNaErt
 8IZ8Oy2QgVp6Pl3PhKPmhe1QW3EyLDp21OXo4/9hR7mcSVL0eQ3DPKCVnb9kKLctAL6idpIGiOv
 BBYc7LfJSpJnp5l2Ccgbo2P7lsSUAOePCaSab4JziTZpN9aACWhiaHIiDxVhxIpbYuWM5z5Oe0j
 8n1g62jtgi0+3UDcRNDzvA+VxbiKYptfga2fuPRA9AxGNZzqbpev2NGMlbebyGtyeJL1q
X-Received: by 2002:a05:6102:6442:b0:631:e729:4575 with SMTP id
 ada2fe7eead31-727c49a0405mr1638193137.5.1781785970206; 
 Thu, 18 Jun 2026 05:32:50 -0700 (PDT)
X-Received: by 2002:a05:6102:6442:b0:631:e729:4575 with SMTP id
 ada2fe7eead31-727c49a0405mr1638177137.5.1781785969751; 
 Thu, 18 Jun 2026 05:32:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4620b3ed0d2sm27028466f8f.22.2026.06.18.05.32.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:32:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 36/48] exec/cpu-common.h: Avoid including unused
 'tcg/debug-assert.h' header
Date: Thu, 18 Jun 2026 14:28:13 +0200
Message-ID: <20260618122825.90331-37-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXwYFZs0WSYVOi
 BtI17G0zFQVp1kcBYQARLDT8gulOWhoQvX1KHO6zakZQlEy4vYTqKYy5ALPS4FY9ZdnVfaV7epW
 yHEPGjK8Yib44XYRb0HW7s0zlBNSWkwRh07ZSzl738ckqz2W9JQVYEN85IPGlRUPDSWiw00R3+0
 nciuNQNk/i8zngTxpZqJBfvyeGtf881V1prEm9lfZ4tFF+1TuWv16KrnDWPfn0FUH3NxcVyBqaN
 gEJk4iYZZR+HiSGvlYEL5tVQP5M6+bo0TpiyST9JAbGFzGjJyVfCtVSEnsdwRWsJ5a0HUa/9kwW
 x7km8xgu7zcO9fg0du9rGMEvqixqWOLYCyvra76u58TzxhRbh7f/IlIlnqacx6IV8KU2HXQAY31
 O50oGDodd1AKPyenWviazLGd+iXbcAH11PPXSqo/R6OeNH3YIo6VtMBwvOayPjXuMK8XLgIfY0e
 ILwfp41Tgh8j7OC8e2Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX8ZxWvKi0rSFM
 oe1mepDWIDBUjTcS2OVruAaCkTQIWEcoo/x/MVbOyXvz/SuZXVcMqz9WKga5SkKgXp4Du9pOQbh
 XhEQ6wGgmIxAK4whAepEhYwUSFsL1E8=
X-Proofpoint-GUID: z1QjM7inmBKHynYFmWKGQkPuNm20hLhV
X-Proofpoint-ORIG-GUID: z1QjM7inmBKHynYFmWKGQkPuNm20hLhV
X-Authority-Analysis: v=2.4 cv=WN1PmHsR c=1 sm=1 tr=0 ts=6a33e573 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180116
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Since commit efe25c260cd ("include/exec: Split out
accel/tcg/cpu-mmu-index.h") the "exec/cpu-common.h" isn't using
anything defined in "tcg/debug-assert.h".

Include it in target/loongarch/tcg/tcg_cpu.c however, where it
is required but included indirectly, otherwise we'd get:

  target/loongarch/tcg/tcg_cpu.c:291:5: error: call to undeclared function 'tcg_debug_assert'
  291 |     tcg_debug_assert(!tcg_cflags_has(cs, CF_PCREL));
      |     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260617160426.64461-5-philmd@oss.qualcomm.com>
---
 include/exec/cpu-common.h      | 1 -
 target/loongarch/tcg/tcg_cpu.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 7dc8cab3263..d1a04025363 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -10,7 +10,6 @@
 
 #include "qemu/thread.h"
 #include "hw/core/cpu.h"
-#include "tcg/debug-assert.h"
 #include "exec/page-protection.h"
 
 #define EXCP_INTERRUPT  0x10000 /* async interruption */
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index f556234d9d2..83291c22c2a 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -13,6 +13,7 @@
 #include "accel/tcg/cpu-ops.h"
 #include "exec/translation-block.h"
 #include "exec/target_page.h"
+#include "tcg/debug-assert.h"
 #include "tcg_loongarch.h"
 #include "internals.h"
 
-- 
2.53.0


