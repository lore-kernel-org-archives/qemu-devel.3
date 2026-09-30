Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9147CA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xByMx-000641-El; Wed, 30 Sep 2026 13:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByMs-00063h-DV
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:45:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByMq-0000p0-Rd
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:45:22 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHedcF1198552
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bkKhElqUw7cZL8NILDXwH9MO0zNIcqbXKJS2Q28CYMg=; b=g8a3WgZIjlmbN3jZ
 pz/JK1CGjAoIiTL2jVfw0hyqcPcPrh7feLkotGQ42fvfn4bw21guc3j0CLK/z4+s
 LL85R/xvhhC0f+EvzpV/8KRRu8002Bqk+xK0TK58nsF0duMmdLDM7iOWbnaVZnuH
 DRo0BxRgkzY+lidEnLRvBHidlIlMnyFgpX1RC9EYvI0QX5+vSbX8RRvpoT69V+0A
 WgH4/H9RogvB3c0GSLL1RDG9va5RKAQ3ljk1qQP6rqJSgHXstBxmTlEB1PFhR2xy
 4M9MwS/TVFHPxJEnk5ZSjwfSE5hthEI8+OSHAgoQyMb4cAn97sB939YWUawhx20N
 Zdc1Ww==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h136th839-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:45:19 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91785bd637bso54734686d6.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 10:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790790318; x=1791395118; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bkKhElqUw7cZL8NILDXwH9MO0zNIcqbXKJS2Q28CYMg=;
 b=iFo2dfTsXjtUbsEAREb5SucrdNuQXyBvgVFRKrfzZT/Hl8CCOAEq/Eoc4r8BbKT0cQ
 vLIkcDIlAe5lL6F03WPh74Hj8+N2YgDXYwn6UV4mZRlAf4uOe0XV4JF6Ej1BWzF6wqRO
 6o83GhFMsUSOSpCs7+en1KFrrA4ymR8umzQNT7zKpwSc57i3V/QXOFDZmmCfq/+6LMBH
 G8+fT0nCDtc+FoAamJT5M5o340S9EryMGCpgZtyw+HHV+KtqcLwGiHftNlDsP9a6hCM5
 zUEpJyMaI2XZhhYaBEUnrDGJNlDgm1uOWIlAfaShCSekBVrbheNlHedoawxRjUL/p3Xk
 ewxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790790318; x=1791395118;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bkKhElqUw7cZL8NILDXwH9MO0zNIcqbXKJS2Q28CYMg=;
 b=JsFzcWrOUbNVZ+td6IjKMIB5r55Gp4lY4GaDJNwawtG5lfrvAIntOywOtET3q9tpR9
 HpqvN3lopvZ9/X3yTn6nONPLsj9lBOF+yUsWMvbtYbqkCcFWVqyF4Kyf9ezwGgAbSwGb
 YgO09z3mrcso4bB8HAbLkIz+YMy38Yam348k9xUaPMnjOeffjsKdBIR/EbwVtx16yX0u
 rn38HbFM/QagrjnJI3VD7oFKGnk+7G80ao5atDWP+KCKfUdCbItOKggY/pncgjoRLH11
 jKd2UHhjshRuGZvPZWMLIMqGdw+nA52WiWyxSqWNEVVe4FUGYPgAzEY85VH/+/UaPFKk
 ssdg==
X-Gm-Message-State: AFuF++mUsDVUaGgGOoV22ulTkmMXz+AUdq7iNyaTjhP6aNiBbqyt7A46
 +QReQXvcFvVnYjDlCClSJDbmBWrrRH/gukyBOZf8AX5Rh6IQ4+grVGQN/vRRUkB5m7iV06bZJrC
 VYrpTaamTgWxDegwXkkuQaprPvzZkPPdmehfkkXpxMU/diSF5aohDavTT9lBW6OLdrQ==
X-Gm-Gg: AYBFou2SnkmATeLoO79pGkYtsMA+ETKZ5qlUnZUYasSOVosLpSQsvYwMkQq1NrRGTxC
 8uML78ZidHM/Z21AQhoEbj/HRaL2b2cbJlZ1TjzlAM+BQB87mYx9pptuUXgpnsLc1twZGZF0g+a
 CDlfiZ6jaBvVV288gmDfzBY8pgMlRbPq6QZT60RzI5Y8tPh9jYf68+qCQopJmAQTNdQM1fI2mSW
 wrNe8I8lYZjP1XFjTC8j93kQ7tmCPLpNUrNNmgIGvDBRbSqv444VWtZC8lmAGH2i0ar9WA966rR
 7RcUksWjoznLUhYrJJHw2vkcXf2S6izMjsVCSuRNB3RSRv8q+Wxu178TcPygXFhfY8vdjTzZ4M0
 bWGvopg1DEfHEXejjb8Umo+ZbUbGm+SAxzzGneFqc
X-Received: by 2002:a05:620a:a18d:20b0:93b:d7a1:ba17 with SMTP id
 af79cd13be357-93ca97dfe74mr285207585a.66.1790790318126; 
 Wed, 30 Sep 2026 10:45:18 -0700 (PDT)
X-Received: by 2002:a05:620a:a18d:20b0:93b:d7a1:ba17 with SMTP id
 af79cd13be357-93ca97dfe74mr285199985a.66.1790790317553; 
 Wed, 30 Sep 2026 10:45:17 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b06a361eesm544786f8f.37.2026.09.30.10.45.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Sep 2026 10:45:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 1/7] target/riscv: Document riscv_cpu_update_mip()
Date: Wed, 30 Sep 2026 19:45:01 +0200
Message-ID: <20260930174508.81497-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930174508.81497-1-philmd@oss.qualcomm.com>
References: <20260930174508.81497-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MCBTYWx0ZWRfX9oauG2nR7paL
 CSDfi05/S1i//cuXzkXKZ3BqFCsnAUj1IH6/6j7HWPl5M0LoXMzOhvjtwz1mgXvcLFDAXGkEc/O
 E/heEYxiBAVahyUQ2L0kqVcJuFF5FrI=
X-Authority-Analysis: v=2.4 cv=aPFlOr9m c=1 sm=1 tr=0 ts=6abd4aaf cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=kCCY7M0hfMRdwlDYS0kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: yEy3Jk66vnWj7KUj-rJ3mmJ-178GO332
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MCBTYWx0ZWRfXydVTnV+1mU1p
 WcaPTEUIlioyKrDQOm6Iizr20a+xckypdSaXxVv2Ze27HLRUyy0/5DrIFFRlfItAMY1lv9BAo3t
 YY4RFouOOD8tjfocnmnCVC5+kYbQn7M3UEzRhAfudtJglasrf6i5eKwDZHXfpbj8IGxl3TopHWZ
 o50Z+Fp4WvXbN5lb5u9eiHGmFI7RzPZWz2c9TVDilazhJeU2RhUIGQXU8tGVHBGolKbRZ9iQazh
 mO3O16w+RzjKyoHjpVDGEwnkZjnt6BL/72BoRchN4TcxdX9Cng2KVGxATF85LSOlgYiJof8qhb7
 5SRL6hlbSsm9WRDcQYaRFsynnBJN4uiWAYxx04HupRQHbDJ+9YEHSNcZTlCGBp9hDVUyjd+k/a/
 8J4W2Ixc0rbHaf/+PdFj+v/vyYgVoadpMDwZ1tmKSkqCe05uJ9DN90amwr/xOZkmIIlz3c9D95T
 S1DV0hWlinR9iDo1Gdg==
X-Proofpoint-GUID: yEy3Jk66vnWj7KUj-rJ3mmJ-178GO332
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300070
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/riscv/cpu.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8c8ffe94cd8..e34c0c676d5 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -684,6 +684,20 @@ bool riscv_cpu_translate_for_debug(CPUState *cs, vaddr addr,
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts);
+/**
+ * riscv_cpu_update_mip:
+ * @env: CPURISCVState
+ * @mask: Mask of the MIP bits to update
+ * @value: New values for the bits set in @mask.
+ *         Use BOOL_TO_MASK() for boolean values.
+ *
+ * Set or clear the Machine Interrupt Pending register (MIP)
+ * bits selected by @mask.
+ *
+ * Note: VSTIP is not maintained in MIP, so it is ignored here.
+ *
+ * Returns: the value of mip before the update.
+ */
 uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
                               uint64_t value);
 void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);
-- 
2.55.0


