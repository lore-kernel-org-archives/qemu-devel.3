Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CEFCA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xChTT-0007GO-Mg; Fri, 02 Oct 2026 13:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChQZ-0004Q7-Ro
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:52:14 -0400
Received: from mail-dy2-x0d.google.com ([2607:f8b0:4864:36::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChQX-0007Ua-5U
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:52:11 -0400
Received: by mail-dy2-x0d.google.com with SMTP id
 5a478bee46e88-34c4a0870d2so3020946eec.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 10:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790963528; x=1791568328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DnPGu3Cq8N2c5ApqFrNQY+BLbQI39d3Uoq0oUbreh6M=;
 b=jjOkApycNWb28C1gaxwSDGngiic/PmLmW6Nda/STH41NOcI2y7Lma/Y9MRHSHCBoFu
 KfYMf+kYvj7bFiHnoMac8R3yiGaivJTeiWYxWLju46ktWCWsMTF8Gi1Tjdoj3pMnmc5k
 qPxWn92RhRUKmON6yrNJi0L0BOpkjyWBB0MQVxJYOVt5WTtkXn9vj/txngMDo9GytkQu
 zIuD/z7WK3va5PO0zLZi+DBZT/E8F+cpujZxIgP24j0ou07c2KGVbXHchqGb03TfRJW3
 xzbbGphrIIOIDgLYr/cE7kev+Ah+AWRZfk9na3K9nAjYVeiA41jBgUxY4lD3IA8gAlQD
 q3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790963528; x=1791568328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DnPGu3Cq8N2c5ApqFrNQY+BLbQI39d3Uoq0oUbreh6M=;
 b=N7aDPTFOpIZGlTR04IXdJAJn9w/h4ja7o6IqknzbnKGplLtHCkvfywWSFQnKRS93hV
 AixF+ZvvwrkCohJCYIFt/tLlycvOHn/f+OqiDNiF5MbxZ65wkbQjrKfaMUdF0dI9a5Ov
 z/sNNeteMsGJDD7cnc7TrbNehIEwG+LkypGUBf9SY+ymk2fnwsvyytqHBrqPgqTQkfhr
 YnwR6sADPPCmmOz39RnmausWDkyhB+9ikX6OhStZW7ABe9W1wC4VTpnHFYRlKkchrtgi
 3Cco0qkYCeScHgAj9UJgWEX1+W3U2qA8dwhoUsCfWYv5NYQaaSyttm93Vuu/hDQxDqcF
 QrBA==
X-Gm-Message-State: AFuF++kP9v7EuP7oFx7OEws71eql2oHERKIkpVNAoUU64wR6ZOAguLMA
 iYt5BUx1JWYNSNt8na3ySHd783RMdPxgTZ3+KSljXuO8G7G/tsW5SuVP3+4JrKywWMk=
X-Gm-Gg: AYBFou2Vb7IJ4J2IJ0MprkgO/1l1Riny4tygBOyimXd6df6kcBXFvxBaw2ZSjcEmGWD
 BIk6Agrtx3KqdfKq6e9EUYy1R0Ly5ok5MLtE5a+3AFsuuE17B1EbgKPrsXrkgaM9AriRtByNH53
 VSMoihl11pTlyE4BF99d3GPvmHirnU8+g+W/CBSIXoKZlzJypotosb2amItOmMT4WtrFRxpxEh8
 WvYwP+aWRTbvyK/qqt5gIuYsXzBigCwtaithJLbEoBglLwaP52dgf0l6TtgkfjtXtNbFCuMu3zx
 5TnKBqFrpwepCYEuIIlaS302lq9uFYphmCszqlCzk+yKOyrqH7qnmg+Bfai+lnj4xLU0KC5Qno9
 5uKSFxblgzhT6mVDY4ty8CC+BNpFdvSuMnoesWzZBZ4eBWRs0Fjj11fsJBhHoBa/Rs6y5YieC3G
 IPybqdOUR95wG6pjeyaOVhVOMphlQlcP0KLv8nCg60hScw+YKnuxuJuXSv/QwXlQODhrRhdGlMa
 hJwZY8I+Zyc8btTXh92N0IHfI0Df6Q=
X-Received: by 2002:a05:7301:4709:b0:34e:e7f4:cc78 with SMTP id
 5a478bee46e88-34f14f18c23mr3650855eec.5.1790963527600; 
 Fri, 02 Oct 2026 10:52:07 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34f14f9f2afsm18027361eec.18.2026.10.02.10.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 10:52:06 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-s390x@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Rolnik <mrolnik@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Helge Deller <deller@gmx.de>, Chinmay Rath <rathc@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Glenn Miles <milesg@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 10/27] target/sh4: log all exception vector names
Date: Sat,  3 Oct 2026 01:50:18 +0800
Message-ID: <20261002175037.1747-11-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261002175037.1747-1-luoyonggang@gmail.com>
References: <20261002175037.1747-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::d;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add names for reset, manual reset, TLB multiple, and user break
exceptions in the SH4 interrupt log.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/sh4/helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 0fbd613f333..68f495b5ede 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -97,12 +97,21 @@ void superh_cpu_do_interrupt(CPUState *cs)
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         const char *expname;
         switch (cs->exception_index) {
+        case SH4_EXCP_RESET:
+            expname = "reset";
+            break;
+        case SH4_EXCP_MANUAL_RESET:
+            expname = "manual_reset";
+            break;
         case SH4_EXCP_ADDR_ERROR:
             expname = "addr_error";
             break;
         case SH4_EXCP_TLB_MISS:
             expname = "tlb_miss";
             break;
+        case SH4_EXCP_TLB_MULTIPLE:
+            expname = "tlb_multiple";
+            break;
         case SH4_EXCP_TLB_VIOLATION:
             expname = "tlb_violation";
             break;
@@ -136,6 +145,9 @@ void superh_cpu_do_interrupt(CPUState *cs)
         case SH4_EXCP_TRAPA:
             expname = "trapa";
             break;
+        case SH4_EXCP_USER_BREAK:
+            expname = "user_break";
+            break;
         default:
             expname = do_irq ? "interrupt" : "???";
             break;
-- 
2.52.0.windows.1


