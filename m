Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70099606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mU2vpOxr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZvCNRRsS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUAAo-0004Qq-Em; Thu, 19 Nov 2026 17:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUAAl-0004I0-8V
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:00:03 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUAAj-0000nu-59
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:00:02 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJUXdm3367487
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=fOg6NyAyMpIFNxp3USSt1H
 LNiJzfG/Fg0pPLuyc91gM=; b=mU2vpOxrqUe4UuKEu6lZeNRfCxkID6+8bXGLM1
 sbRiDAe1U3tu0zz9KBS9FAALp+yGt1MhjU5Up4SuLe2gs/V2iDjnvXlCB9I64kfh
 U/np6FYZRwv0T3JhZCTM0gEwdLQTtm2clKh4GY+3m4scM+BK44+EwndzCOuPaupW
 suLuZzByx8spK6gx3AJLNJwfjRbM7BcqJJrvQpg2wyYg25rtKzGxOtXaIqeo7Qu7
 HEXBpr8coyyKR7x7ouKgqq3Urcqs8lkGmRv3oNNP6rx+EScE1VzeCpOHDEEKlAIR
 NHWXmjpCiTHOfwjr3wrrJ+N7kVeXbuYGijcURDEIr7wMRZMw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27b5rnf1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:59:59 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9495a1f5e47so51390485a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 13:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795125599; x=1795730399; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fOg6NyAyMpIFNxp3USSt1HLNiJzfG/Fg0pPLuyc91gM=;
 b=ZvCNRRsSIzGAXDp6F5oV2b3QNszbVcM2A65zGgPHTp+N3UOWzSKGoQzOArG+4iF/c4
 tE1mEvg171cnvy8M5YpWoO5M91ivIMc6793uQPOPRrrOHfLguJ3otuPfKXOUYG+vSKtt
 4M64jMxDekfQQ+g2qnhGiwW5oj15kq3d13XgNcHVsML4MfHAzeiBnJKfY5xpbHg7rPaH
 Q5IGm2i/yABochDkIu92UHrt2+PWIbgxZFpFlvJsEp6g687BcQKn0wZyKmNMaSj2B0kK
 GqiRULQlvwEko+SZPRmoP5mhWFSIvixrg8WUOdZhU264jn5g1S9BLq+iWlMbeWpatioQ
 A+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795125599; x=1795730399;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fOg6NyAyMpIFNxp3USSt1HLNiJzfG/Fg0pPLuyc91gM=;
 b=DirTZTpNkd2W2G0YeTMu6bCt6smqwrwf52kENsccgcGrwoQZs5dGWr3Txmc6EFK1j9
 MV0H7kgWnDuR+gso7BHvpxuSoscQzOCN0yfViirrxs28jY2iBieJLCOzbDKwmKxjGfMi
 hZzc4v+ptIxzTL9u4Gly8Ic30VHjn8Nd5SkLt2LlGe0UN64Y5xr+iYlT4k5ZniIjsjzw
 y51BXtvQD+E9KD+uZzusgviFJ6YPbTBTl8Jj8aw7f61dJV/8FNgxquL572Eucbu46L5M
 MoRwRoiDFRBYYuHl8ion8x0rI3QlLg/ow+As3E0suDEht3r4XsNuSsW1xttigVneiFU7
 eFBQ==
X-Gm-Message-State: APuU4Z9uQ3Y7XTy32PbD4c5oPYNGsCImiR5g2g2UJuAsyLQdVK+xkE7f
 oVX+AMg1dDFtY/96Fd5lArHcrIouj+BhPqhEZhFfPQLt/65zaqT5f3DODhj3wS8LulUDb5thiqj
 Ovx7AJRmakrY66YVNA7FqKTvACceQj/Y7oTDWNRLKiGnZNnnuJHm3zmQfGvcQE/ObL50K
X-Gm-Gg: AYBFou3H6BfURhO6MQRA7VyGpNXSllZmkPIeCsuACVZxbI5MmULFaoBYe5TdI+Falho
 NNWxVZJ1eqLF0E9Dhstbna2/zoKDTwhzVkESso+hAbxBVCpfah+l0jQVvpswHtfxKuM6XHDlp2c
 rw23gZotaDff9SIv6L7qI/1KyMZr0qzlX8d4ihlse5rHma7AXTUUkUhovIpOxv8fabFrTpWSm9b
 che9+GwL9clU+OG59gtAR2WrMUic9XeXRBrFtQm9YCbFGIuGCEyObwOrbKu/lmW1VA0uIIk5ilv
 APAh8AlUwFYVqhxWOxp6zNCqph6Wdw77sXB8FIlQW8ricKtVUPF4mqb56SGYWKAxTbHAb9othVZ
 q6l0YXtH6LBKtXV/cIZyjgesR1CGadm35wBhtG0rb0Otj+gqJqjlxMXrTH5rePb5yckhL/fMLU4
 Z/rqV5uv5PeahHFg==
X-Received: by 2002:a05:620a:4551:b0:93f:362a:a893 with SMTP id
 af79cd13be357-949ba9e356cmr177006685a.50.1795125599234; 
 Thu, 19 Nov 2026 13:59:59 -0800 (PST)
X-Received: by 2002:a05:620a:4551:b0:93f:362a:a893 with SMTP id
 af79cd13be357-949ba9e356cmr177002485a.50.1795125598652; 
 Thu, 19 Nov 2026 13:59:58 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853368d3sm66692025e9.1.2026.11.19.13.59.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 13:59:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Tai Yunfang <yunfangtai@tencent.com>,
 Xiao Guangrong <xiaoguangrong@tencent.com>, Jason Thorpe <thorpej@me.com>
Subject: [PATCH v3] hw/rtc/mc146818: Set PF independently of PIE
Date: Thu, 19 Nov 2026 22:59:56 +0100
Message-ID: <20261119215956.30750-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfX2b7cjXVQE9UD
 hvyUXsSO05ls4togcubN6/q6DCDmJDrs/C+Mvt7RhLEFI/2rkZFs5KYhTj5cyFYEfbuxO5WlFG2
 EdFjE11E6LoopQMw3U6NMNfkDGRqzK4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfX52y2I/TrbyZD
 uYLzcWjp2Ip3EL2+LF6x/HMvxlRf74xVjMvAhXm4v5fvuv8GLS6/ZK0ymCpBLFwZXGsgMPuCBmT
 O7NuxLhyFbLeTw718vKzIINe5Q1DEWAu8FboM6vaPgaVveeeMepePzKUYClHqtTgGsj0QasTvHb
 Mb8bda6JJzAC/JWh08oEZrVhnYie6ljGmeIGmDRc1zRXFaJ7RMiBSlsOvOxxf7U67ty2IhLe2Dq
 J3vDgUfvg97J0jWwj8pwatWxQ+9Yy3/WGcgEOdyAAQht+CUdCYcGL8LPjbW0hJxi4WKJuYQMcNq
 lkM1bvfBL62XSYwffnVeJ3ts9zk35PWqrt6nTxRP2/quHZoxDjj2Qq0WufW4VhDXVV+bbdlBvVy
 on3vhd4b2j0UG088zjksLh3ybvssSZhhzqDlTaObHsb8/I+24arNtVL/ES9mnh/g9liHfFSoYiq
 rrb0865VAd7w4oEFPVg==
X-Proofpoint-GUID: 76K5jKboSN-HPaUtV_LQGjwEWxpw0HrC
X-Proofpoint-ORIG-GUID: 76K5jKboSN-HPaUtV_LQGjwEWxpw0HrC
X-Authority-Analysis: v=2.4 cv=LPTz05W9 c=1 sm=1 tr=0 ts=6aff715f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=GvQkQWPkAAAA:8 a=HHGDD-5mAAAA:8
 a=20KFwNOVAAAA:8 a=Skk9qRy4hXRyT7thaF8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190088
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The MC146818A datasheet says PF is latched independently of PIE; PIE
only makes PF raise IRQF and the IRQ line. QEMU skipped the periodic
timer when PIE was clear, so PF never latched.

Compute the period from register A regardless of PIE, and latch PF
without raising an interrupt when PIE is clear. Stop the timer while
PF is pending so idle guests are not woken every period, then re-arm
it when register C is read. Preserve the PF cadence for a late read,
and restrict SLEW coalescing to PIE=1 so it cannot inject interrupts
while periodic interrupts are disabled.

The qtest covers PF latching and re-arming after a delayed register C
read, and verifies that PIE still controls IRQF and the IRQ line.

AI-used-for: Regression tests
Fixes: 369b41359af ("mc146818rtc: precisely count the clock for periodic timer")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
v2: https://lists.nongnu.org/archive/html/qemu-devel/2021-06/msg05307.html

Cc: Tai Yunfang <yunfangtai@tencent.com>
Cc: Xiao Guangrong <xiaoguangrong@tencent.com>
Cc: Jason Thorpe <thorpej@me.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/rtc/mc146818rtc.c   | 35 ++++++++++++++++++++++++-----
 tests/qtest/rtc-test.c | 51 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 887a8b075825..a6d760fecd00 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -134,10 +134,6 @@ static uint32_t rtc_periodic_clock_ticks(MC146818RtcState *s)
 {
     int period_code;
 
-    if (!(s->cmos_data[RTC_REG_B] & REG_B_PIE)) {
-        return 0;
-     }
-
     period_code = s->cmos_data[RTC_REG_A] & 0x0f;
 
     return periodic_period_to_clock(period_code);
@@ -162,6 +158,18 @@ static void periodic_timer_update(MC146818RtcState *s, int64_t current_time,
         return;
     }
 
+    /*
+     * When the periodic interrupt is disabled the periodic timer only
+     * serves to set the PF flag in register C. Once it has been set
+     * there is nothing to do until the flag is cleared by reading
+     * register C, so keep the timer stopped to avoid useless wakeups.
+     */
+    if (!(s->cmos_data[RTC_REG_B] & REG_B_PIE) &&
+        (s->cmos_data[RTC_REG_C] & REG_C_PF)) {
+        timer_del(s->periodic_timer);
+        return;
+    }
+
     /* compute 32 khz clock */
     cur_clock =
         muldiv64(current_time, RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
@@ -194,7 +202,8 @@ static void periodic_timer_update(MC146818RtcState *s, int64_t current_time,
      *    to a shorter period, scale up the missing ticks since the
      *    OS handler will treat past delayed ticks as shorter.
      */
-    if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
+    if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW &&
+        (s->cmos_data[RTC_REG_B] & REG_B_PIE)) {
         uint32_t old_irq_coalesced = s->irq_coalesced;
 
         lost_clock += old_irq_coalesced * old_period;
@@ -241,6 +250,13 @@ static void rtc_periodic_timer(void *opaque)
             }
         } else
             qemu_irq_raise(s->irq);
+    } else {
+        /*
+         * Only the PF flag is affected when the periodic interrupt is
+         * disabled. Stop the timer until PF is cleared by a read of
+         * register C, so that an idle guest is not woken up every period.
+         */
+        timer_del(s->periodic_timer);
     }
 }
 
@@ -702,6 +718,15 @@ static uint64_t cmos_ioport_read(void *opaque, hwaddr addr,
             if (ret & (REG_C_UF | REG_C_AF)) {
                 check_update_timer(s);
             }
+            /*
+             * Clearing PF re-arms the periodic timer: it may have been
+             * stopped while PF was pending with the periodic interrupt
+             * disabled.
+             */
+            if ((ret & REG_C_PF) && !(s->cmos_data[RTC_REG_B] & REG_B_PIE)) {
+                periodic_timer_update(s, qemu_clock_get_ns(rtc_clock),
+                                      s->period, true);
+            }
 
             if(s->irq_coalesced &&
                     (s->cmos_data[RTC_REG_B] & REG_B_PIE) &&
diff --git a/tests/qtest/rtc-test.c b/tests/qtest/rtc-test.c
index 02ed4e123859..5eca6f65ea95 100644
--- a/tests/qtest/rtc-test.c
+++ b/tests/qtest/rtc-test.c
@@ -540,6 +540,56 @@ static void am_pm_alarm(void)
     g_assert((cmos_read(RTC_REG_C) & REG_C_AF) == 0);
 }
 
+/*
+ * The manual says the selected periodic tap sets PF in Register C whether
+ * or not PIE is set (PIE only additionally gates IRQF). With PIE clear
+ * the tap must still latch PF, without raising the IRQ line, and reading
+ * Register C must clear PF and let the next period latch it again.
+ */
+static void pf_without_pie(void)
+{
+    uint64_t first, second, period;
+    uint8_t c;
+
+    cmos_write(RTC_REG_B, REG_B_24H);
+    cmos_write(RTC_REG_A, 15);          /* RS 1111: 2 Hz */
+    (void)cmos_read(RTC_REG_C);
+    g_assert(!get_irq(RTC_ISA_IRQ));
+    period = periodic_clock_to_ns(periodic_period_to_clock(15));
+
+    /* PIE is clear: PF latches but no IRQF and no IRQ line.  */
+    do {
+        first = clock_step_next();
+        c = cmos_read(RTC_REG_C);
+    } while (!(c & REG_C_PF));
+    g_assert_cmpint(c & REG_C_IRQF, ==, 0);
+    g_assert(!get_irq(RTC_ISA_IRQ));
+
+    /* Reading Register C late must not delay the next PF edge.  */
+    clock_step(period / 4);
+    g_assert_cmpint(cmos_read(RTC_REG_C) & REG_C_PF, ==, 0);
+
+    /* ...and the next period latches it again.  */
+    do {
+        second = clock_step_next();
+        c = cmos_read(RTC_REG_C);
+    } while (!(c & REG_C_PF));
+    g_assert_cmpint(c & REG_C_IRQF, ==, 0);
+    g_assert(!get_irq(RTC_ISA_IRQ));
+    g_assert_cmpint(ABS((int64_t)(second - first - period)), <=,
+                    period / 4);
+
+    /* enabling PIE makes the next period raise IRQF and the IRQ line.  */
+    cmos_write(RTC_REG_B, cmos_read(RTC_REG_B) | REG_B_PIE);
+    while (!get_irq(RTC_ISA_IRQ)) {
+        clock_step_next();
+    }
+    g_assert_cmpint(cmos_read(RTC_REG_C) & (REG_C_PF | REG_C_IRQF), ==,
+                    REG_C_PF | REG_C_IRQF);
+
+    (void)cmos_read(RTC_REG_C);
+    cmos_write(RTC_REG_B, cmos_read(RTC_REG_B) & ~REG_B_PIE);
+}
 /* success if no crash or abort */
 static void fuzz_registers(void)
 {
@@ -709,6 +759,7 @@ int main(int argc, char **argv)
     qtest_add_func("/rtc/update/uip-stuck", uip_stuck);
     qtest_add_func("/rtc/misc/fuzz-registers", fuzz_registers);
     qtest_add_func("/rtc/periodic/interrupt", periodic_timer);
+    qtest_add_func("/rtc/registers/pf-without-pie", pf_without_pie);
 
     ret = g_test_run();
 
-- 
2.55.0


