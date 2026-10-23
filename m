Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B003606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nhehg+KL;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PHsV+yF7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHuE-00045U-Qg; Fri, 23 Oct 2026 12:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHuB-0003x6-RA
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:14:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHuA-00025E-4p
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:14:07 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG6SAZ2216171
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tdwGQb0aM+NgFUeVe/gbj55Onpockxz5WXDTMIYn9B4=; b=nhehg+KLtOqbx2kX
 QFCKP8l6hc45TTabdZrpeXrCA8P0kWfvOCQEF1Ixol8R+D7s8OKql/fYkmilI3my
 LAwTDnnw8Au1C1rpsvM7C9SJk5q+hqHjC4Jb6aA535Giq74cKCSGA0iI1B71kV2/
 tyGCfnxxaDSvTRltoMCJE1rF4zVOjTNAWCjfKKnoy3Oy82Mk9Cu2C5vzP5oAOM6C
 Ohe5BW25ru2u+oSy9QETeT11+WHQfehXsHKE6aV+oa+9iJXZDBa54NT6fwwzG0Jf
 Ol7tzNEE+4CkLkFvXvjnL/kixkGmHUnOJVjc9D9srfwETKX7Y8koohhxIutyUqT0
 0Fl5/Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgatc811a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:14:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f33438950so241145385a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772044; x=1793376844; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tdwGQb0aM+NgFUeVe/gbj55Onpockxz5WXDTMIYn9B4=;
 b=PHsV+yF7Qs2ObHaob9vUJEjDnsKikLLZi2A9c02n517TEe2y9+nSTVZU08Pc7MnvS2
 8g2fgMDZJN1Hx4DS3uv16O/tmmwpKrp7dVJ659b4m7DpofM68VwpKwupw7hKDPQPv2f2
 jSzY1PeNXv7u/dGcazGMBLjcBAj8/nsJ9Wc1Kt2CiOoTfbekeNr0/b03lk4edpciy108
 JpV23R2NMwkexjWJ6qVZsJ2IJY/bBevfrvdVmeCfbgAaYLnAhpR1nqOH374MweASgHv8
 PfeeUq1wfjuKFgzrsrOuTMP/Sf9bG/x16vLt/bYaf0TrGHW2Ou84q/rdCLEiwW/NhTOI
 G1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772044; x=1793376844;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tdwGQb0aM+NgFUeVe/gbj55Onpockxz5WXDTMIYn9B4=;
 b=2UcEuJt/1jxMIuhGmGLeoJz+PHMOvMY9ILGHJlVHDuo+CBOCk+QI/euYc5hFaODqAY
 7WGnBkBsQ2lTrl009arBnE5y5SpZELvWzARkpqcWLHDTJX2b9H/a9rDmJwFtOwwhJmNH
 RbsG4dChvxA9n2sxTL8ggo9X100K01eaFjcwvy/OVVXQIj4ZGBlzXHb2+Nuk10likD8E
 bRi36pjwGkcCTg7eubEJk41RphTVX2Ebm9qOKocfQh2S9jXbXGnCznE50OBODq3chcUM
 h+C7slUrNurW3MatwfLmRFd8dH/p7UAm1+U7M8L1sNINfoB6dpw9+NxwsOdE7GRgXDSI
 ywTQ==
X-Gm-Message-State: AFq9FYJCeecKY2Lue+Y2BaKIvDPD/QIARyelHwHHOp8UAmagYd2ZYwLd
 VGofa+AoW8aFQfeBMlwkJ3wEciBJ8OkhIBbNISGNYu9dmRrE5Anu34RU4l6+uJyMiTwC7Yb3/2W
 rA627/ZHvB1cM6oD4zgvMrVC45SI18gHufDznWtYsehCr/xRHhX4bAn77K100//AfbqmP
X-Gm-Gg: AYBFou2lGIW3VeORxGrFt0m65CNDMKgQdZtaHkRq0fF0JHEma8msAllwWDSDHrKFkkL
 U5epW4Pw3jiAu6kjuJhB+vE/ZW5wHBpc+XFmAp90d9wXqJeHWxP94zHa4CErfqbY8zp/4TdjkdJ
 5yWRyIFLXiwpRAN187h0YvuQAqIsttJS7/c5+5JzOGATxRQH5aTpkzYcJsB8BcurT+f4ytBVC5g
 yEZVX6V61IEp3mU+q69KsB5G0zBlQrphf1yVsHPXN2U7P896OHds1rTxAhjk22Yn4LTbvu3emoh
 34J3cY9haSHzt7AtHf6zYH0OnHCDSfLjqKCVADY2Mwy9EBT2F1vHaqCu+uqazDWYpD8AWIfmoj7
 g7t5MVL02Y2mECginHA7L8Fb9VbN0ZxvrrGem5axv
X-Received: by 2002:a05:620a:25cf:b0:93e:4833:82e7 with SMTP id
 af79cd13be357-93f6f7975c6mr490753585a.46.1792772044488; 
 Fri, 23 Oct 2026 09:14:04 -0700 (PDT)
X-Received: by 2002:a05:620a:25cf:b0:93e:4833:82e7 with SMTP id
 af79cd13be357-93f6f7975c6mr490750185a.46.1792772044041; 
 Fri, 23 Oct 2026 09:14:04 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d3f0b8asm762327f8f.11.2026.10.23.09.14.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:14:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/83] target/arm: Convert cpu_exec_halt() to leaving_halt()
Date: Fri, 23 Oct 2026 18:12:12 +0200
Message-ID: <20261023161332.60153-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX8rzh8ai/rPPX
 fvYkL8VVctl6NnJ72HmTmSBdiz8eXtWqTTN+DIDMqecmn6LYwlUeMJ4e8ECppbStrXEWsBZeKR1
 udPZewtO38rhpxBj1Q7idESHQZI/JLUqdXQLRX04Zu2FnaL2oGygDZvrdFBRdPsppVx2YLyjJq3
 rWl8Sy+nnp1lW4Y4zZU7a4hIGp4dns6rL8/FxGjqXWXdifGirPf0j5qgdKaVBinAWuuQXUUUREP
 LI9m1Yd2N0jpqlvOE0dU2R/igTkoNKNTgxFM8ZNoSs3rC6a7/XCdVm4XXsj/TrWMHxQPyw1exep
 htAexdbkPMzzxD7f62QB3EIsiB785Jshv3rUz5/8BLoGuU2SuxCO6y0ND3JdFR1cJhd88qatpxG
 QDy+zFBaW0Dl1tL/BMNuCfsnB2Wt9F9rMMPvJArSD3M0AYkX6qYpMHjP/Th038139CSTB56bP8k
 fAG9kYQdL6fNlyd2h7Q==
X-Proofpoint-GUID: oKCQaLMR7X4n4vlwau-AehriJkETaMyg
X-Authority-Analysis: v=2.4 cv=Scxi5fRu c=1 sm=1 tr=0 ts=6adb87cd cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=AtaPWBxvZOLBLR1XvpsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: oKCQaLMR7X4n4vlwau-AehriJkETaMyg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX8e7YOwlrghVu
 qJs5aT8ut2fIz45NjmW63qUWtsfFPwQu2R2gSmfsnANbTfgvnhPLkKYCvpVAEirDDp6xrZYu9/x
 2MaXnmFZ5RefQgC/mbQidKVaD3uaXOA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230063
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

arm_cpu_exec_halt() now merely checks cpu_has_work() and
conditionally call arm_cpu_leaving_halt(), which is now
the generic flow in cpu_has_work_after_processing_async_events().

Register the leaving_halt handler to use the generic
target-agnostic flow and remove the arm_cpu_exec_halt() wrapper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260930174946.82195-5-philmd@oss.qualcomm.com>
---
 target/arm/internals.h   |  3 ---
 target/arm/cpu.c         | 12 +-----------
 target/arm/tcg/cpu-v7m.c |  1 -
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 06092d29b36..509ed236a1a 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -431,9 +431,6 @@ void arm_restore_state_to_opc(CPUState *cs,
 #ifdef CONFIG_TCG
 TCGTBCPUState arm_get_tb_cpu_state(CPUState *cs);
 void arm_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb);
-
-/* Our implementation of TCGCPUOps::cpu_exec_halt */
-bool arm_cpu_exec_halt(CPUState *cs);
 int arm_cpu_mmu_index(CPUState *cs, bool ifetch);
 #endif /* CONFIG_TCG */
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index af0c64d196e..03a0ae02ebb 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -883,16 +883,6 @@ static void arm_cpu_leaving_halt(CPUState *cs)
     /* clear the halt reason */
     qatomic_set(&cpu->env.halt_reason, NOT_HALTED);
 }
-
-bool arm_cpu_exec_halt(CPUState *cs)
-{
-    bool leave_halt = cpu_has_work(cs);
-
-    if (leave_halt) {
-        arm_cpu_leaving_halt(cs);
-    }
-    return leave_halt;
-}
 #endif
 
 /*
@@ -2627,7 +2617,7 @@ static const TCGCPUOps arm_tcg_ops = {
     .tlb_fill_align = arm_cpu_tlb_fill_align,
     .pointer_wrap = aprofile_pointer_wrap,
     .cpu_exec_interrupt = arm_cpu_exec_interrupt,
-    .cpu_exec_halt = arm_cpu_exec_halt,
+    .leaving_halt = arm_cpu_leaving_halt,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = arm_cpu_do_interrupt,
     .do_transaction_failed = arm_cpu_do_transaction_failed,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 48b31d5eac8..1093c6cbf63 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -302,7 +302,6 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
     .tlb_fill_align = arm_cpu_tlb_fill_align,
     .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt,
-    .cpu_exec_halt = arm_cpu_exec_halt,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = arm_v7m_cpu_do_interrupt,
     .do_transaction_failed = arm_cpu_do_transaction_failed,
-- 
2.55.0


