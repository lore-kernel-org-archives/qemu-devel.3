Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082ABC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjii-0007FU-NA; Mon, 06 Jul 2026 09:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjiY-0007Dw-RW
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:50:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjiX-0007Xr-CH
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:50:38 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxO8i218524
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZB3yWyI/qpOQePgEoG7SeKYB22ffziKgbfDdg+0wJBw=; b=Xs4OinxBCQdEKbTm
 K7eB60H2z4SW6eFeLZFd9aOLWrOID6dFr+lFAkQ5OA2qRC8kybKHcuHEg8G6LiG6
 Jlt5li9tOc+efhVYHPt9WEO4nrPpkNxx8U4ooyCU11K20WZ21Iq1gs4w4jE4R1K0
 FSTZcXKxiQn9jbQlLQMG21bhAr1HPXnNwUhVFY5qeCBgWP2BvmEGNMtChybmCCee
 OhKCu73PefR9NY9lq1JtptdD8rxguyqale3XI+XeV9xmJUWOlMN2XE/1ZVcN8Ia9
 J/hwpxXHbbQBYaoC/1HvrAD01hsSKqHRH1EtMpwwvSYqVypn4yh+orEq2z7HHKct
 1xoy8A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hs9cqy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:50:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-91ed0e140c5so550984185a.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345835; x=1783950635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZB3yWyI/qpOQePgEoG7SeKYB22ffziKgbfDdg+0wJBw=;
 b=O2cS9iFy7424K/hwBlcTbqsEWk+79IoQPe/R6WCxUjC4MrJpv68n1gZTDyEYF44T69
 ofzmBr5GLyH5fMGSobNoNzJFvNXeP1N2g3ZKJODcOpQSh9aiSOm6vyyGQ1XOKHCMdh0t
 JEl9YC8bZlWaeQd/MlmSkd4tXZAzqC46+ZYyp6Bwc5AZQyxw811zllL2655GKFJ6qoCj
 d2WGED/jDWl6XG6UAOg+hWjIP32s7DkgfVt8zGWoD+Rl7SffQ4zWTBij5VOwjYxWNE/u
 TsVHK0taD6i7sDi+4+rkbVl4PoJpTA3ZX9pRWxgRKmRDSB7S8hJoI1XFxsk+MDznUnC0
 b4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345835; x=1783950635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZB3yWyI/qpOQePgEoG7SeKYB22ffziKgbfDdg+0wJBw=;
 b=sfGYFyIk2QDh0ugtxG2OLd1RlreaX5bAq1WwmMJvFPWpe2Zt+wJLO3ie/dhN7yfrQd
 g4A0xOHgkeXB1j11GtbuvdKdGGuKltTntcn2UreW2F/JHrKlum8REarNpjAocGyTpFxf
 wYaLwub/BeABZIiod0l+j+1Vy6uUDYN+HTR+PCVZig2y0hb8aM9WWblOLV6Riwlc/KjH
 Hz0iE8QojDU1nX/lvKrptAhj8SvWpdzZ2+lWoN1pv9PrxfNh0KpIQqeo3EiLtIu+4ImH
 GRxjmC3nYJJgAhRvYG0ofn+CyI3LRf9D5zNmfnlnvOfZBmfHQTc+/qsGmX119x6TZuWt
 GcqA==
X-Gm-Message-State: AOJu0YwgICCStZQmJj+FcxfeYjJfaEnkH3wJnHD9l5UwvAR/KDFk+Sdt
 h/WraFycifm/8WINFC2r0PxiVNGAexZJewqdijiYPDmFYqB5VFy/zUXiVZLYveViux5Dmyizbi8
 9s3lnUGmPFvx+o32fmpE+v8dBWt65cFwQqjrsD8KRiS3XYm8qbNhjSdmIdxv7ZQdSug==
X-Gm-Gg: AfdE7cl4Q4aSdTqipGN3/HiY7v+PLAAHE5AhMVWIlPWFbeub0r1AgsCJnuyZnF03q44
 yLgJaqyb5ill8Ob4fCzuFoIEcKK6jSfOaKvpe2X5UQMGpqSqOFDULj0CW2IiRnK74UDeZz5iM0r
 P7UHOpsEDQHkgJ8hapEbnFG8rpQM9e1JrDAz4ML60IzgRd4+vEa/aM5WPXmoSmgu1mjB5PALQP0
 Kg2v0vOpcbwR/dGUyFV04n/cIQTn3zhlEx274LoqISV0qElV7SvPudmtOsT+z2cbCoOO2t24VtX
 xco+IckL+bf4ZJImSui/z2Gvs5flpOnFtTQLqOB6ep0MPYp8Imti79BtKsb3SfukPSMM4qBb7+J
 od5iws3aAutKH31sArI6ccQaaN+RcqDQPP4ysnbAGQt0br+dK3+vEUuBYww==
X-Received: by 2002:a05:620a:4707:b0:92e:7d1f:d3a4 with SMTP id
 af79cd13be357-92ebb4e4225mr92231685a.26.1783345835394; 
 Mon, 06 Jul 2026 06:50:35 -0700 (PDT)
X-Received: by 2002:a05:620a:4707:b0:92e:7d1f:d3a4 with SMTP id
 af79cd13be357-92ebb4e4225mr92224885a.26.1783345834747; 
 Mon, 06 Jul 2026 06:50:34 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d6e4csm23220534f8f.10.2026.07.06.06.50.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:50:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 32/32] cpu: Only check SSTEP_ENABLE flag in
 cpu_single_stepping()
Date: Mon,  6 Jul 2026 15:45:27 +0200
Message-ID: <20260706134527.84808-33-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FygeOyeoJSY826rJyfg9C8hPsuPQIP2J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfXwCGyUO8iRAnv
 qqgZecy7KgvyV20jwDm9gHX/cHC7DChB7Jq7a3yrFEkDc3rvu0DdyQuQxrL7HpLtAlQyul40gc7
 akThxkiNgl5wsCH0bzZ9U7Dk917C63X1a738hUXN8bzqxHaOchY2cnb0pTlSFxpIvb8o40c1AAh
 LZAdZzVBTHuuTcmPkSuj/zO8WJnpW3V6fj8ZgPgaHDDDWXZh52CE/sbQD/BdZt+ZD+d3bWr2cfw
 +ApW+GXIBztPrDcyMRdvcabYt8aSFNe7psY7i9M1hIqY6zWqa8YRXSuloQYNYL1qeAWTqWbeRdU
 9LKxNt4mjn70OegstFU+GSvTpQjl4qz/P/1/aE3Kcb+7u8p1k+Bjl7n3KX2q2KPf+z06yzI5fHd
 S/ES4GDnyB/zBGM75H79QePE0R/r70gm+HuXECzKfJWLRHy54ZwsZ1L9Wh6KgERIuHgv6t5l40P
 uxnBlpS6LD7BrqYnExQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX1kP1lH4pAQb9
 tRGgNQTab0rxfth8ZRyXRlWyUW0Zp18MxTv6xhz281nk+1PQi9V8t0xPAjsNFFG4OJZS/2v0k9v
 iNny8GkuwgsqhmHJWfm5CAFKRSZgWqU=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4bb2ac cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=c32rm7a_bKQHMAiu1xsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: FygeOyeoJSY826rJyfg9C8hPsuPQIP2J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Only the SSTEP_ENABLE bitmask means single-step is enabled.

Fixes: 60897d369f1 ("Debugger single step without interrupts")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260705215729.62196-33-philmd@oss.qualcomm.com>
---
 include/hw/core/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index db4865bd63d..b54035fb13b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1146,7 +1146,7 @@ void cpu_single_step(CPUState *cpu, unsigned flags);
  */
 static inline bool cpu_single_stepping(const CPUState *cpu)
 {
-    return cpu->singlestep_flags;
+    return cpu->singlestep_flags & SSTEP_ENABLE;
 }
 
 int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
-- 
2.53.0


