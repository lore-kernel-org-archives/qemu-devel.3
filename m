Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4586606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q9zAuO4G;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hS9pCzDn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzwR-0001oV-8H; Tue, 24 Nov 2026 18:28:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzvq-0001C3-R9
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:28:16 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzvp-0007gU-52
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:28:14 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMb3M73274797
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JbK4tPqFCPso3MJUQ/AZKmIcHZEWzE9KC5WglzNwU2k=; b=Q9zAuO4GV8PBxc7S
 h7m6UXS8/M3QHnOUdECTfPZieTG+gKz93Cjxzi3suDjhLMVslC4E/a0ncGMuP0rQ
 d48Cv2IrVemyRWTPedD+eccDjRjJMNJzkC52qpYn/IIyaldGS/GvDnWwXKr5FTcU
 zB8UUV9ZKb0cMxZzq9sLsc5xDrqrRghRE6vI7V8ZBZdFTnRNrWCZDIciHCkpXnwL
 z3uSXfx3NlTocLCUoLHkupUBbkoU7ldjDUa4OLuAJ3n6j0XOfKlhvSGB2zMIH6M5
 9Q3SQM7MCtoiUrMjhxwK0kkGUc9LL4hFJcoYKHgEPQME3dukTr3+svZuo+1fpjmi
 CnG9vw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5gnf8r9p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:28:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94970ad532bso284154185a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795562891; x=1796167691; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JbK4tPqFCPso3MJUQ/AZKmIcHZEWzE9KC5WglzNwU2k=;
 b=hS9pCzDn6pR4ehGXT+uwOu48bm9jv9BWT4FTuFIsp6Z+qtVMN6k1kEx74yZFwR4DZn
 rDi5ykpnILrqYE4gV5/Z7m5RgU4VBqGqUoQmlGrzCuAf0csb6GvQaJ3X0ci6Iq1o+XH0
 KPu8YJHBpEvlRDIn4JJtHIQUcjp7Uo90LocUYX9o6nkoJvXQ/Fc1pExIGgWWW/PvVCm+
 B79KcHGNb/RCtpWACaaN57cHJ3yHMSu9pfdu+qBLVnPa745SN50a3lk9Z2tiFcJRjTuS
 LJkLpfl7COOYbICXWBlakefVsXkV38AuL99TZl8U1q87jBH7wxRG0vzBuDJ3meac8f5i
 Cw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795562891; x=1796167691;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JbK4tPqFCPso3MJUQ/AZKmIcHZEWzE9KC5WglzNwU2k=;
 b=FYUiBUloaNAMLBN1am5l0z4TlSm+WnlFTE4HQAYw8+Ojbjsb9vcm9S/Tcuk7WKbUeM
 ua753fYepjdbI4P1FiQUEDzthQ6H+k6XxxKpTTBiIl2HoRLPXcAYiO+W3Cf6kpnqGoux
 49EWdcvFm4GIJHdYmFvxRZkjtJIREmlCtZC/Q+nDj/ieolpdE+LyY02kG3GCRiZoTfrh
 8E9Vw24U7P8cHUr4Ft/ixzZv8C0tFD8PyOzdu48PaHPFhwrx1OUCsDIek+KSl1/ySiP8
 sMrQiJmyw3zCajvAdn8KIPXKJKm8Y3loriWPAZEiKbRmjn4TJL3xbgetTIqk5Gwl6vn6
 7Gsg==
X-Gm-Message-State: APuU4Z+OJUN3rbfS4KpdDpzgvmRDsC9pqDi+6hqZAarC6ymMujBvVnYT
 sWjgYpnn3X1FZCQIJsNsGvEjCwgnkMAglddjkGCsPYQmbIgdYavFUheZHDRfxI113HzOB82c/zJ
 uMtg1u20LEOJyfByzh7+6CW9xHB4ZttlsZ4GwPDgZwNXNI12Q5EsrqS8/ussI24BeiFL7
X-Gm-Gg: AZFdTZczNuNdPDbv4DfuKBBKHnCZ6KJyfT/o5DoULJrXutCbsAwINt1DaWYaV8dBaKt
 IDzfjLE3xbjjRtwYVQWRZxkTzkNPH6g1PDD5QxlkXIbZFQzvsaHDi8DT5CEkpmHqMxk5JYDN5Ig
 BkBr9q18LzLHZ0cm13/XbNMMs7ws9RVTDO1n1+x6x+Ev2Qb9bzekCHl7LNqZ+cRkqilciikqm+M
 iq6iWx1MoeX+RI6hl18OE0wdc2VXafT55bedhxKlHUrWx5zXS7kM0SjB8dxX5GYxws+kmRUe5k/
 Ta2PKhlKwLKPqzn97K13nVVCCR/mxn9v/yDjIrRE9yLWFmKw2ZlbBxZBhpYuG72T7ySkdsovj1s
 5kWw2LQ194DrtNBxfdQso3UUOdDU+9ZNual8ebSoPALog4QLzdTPc7yOozuDxeUdNTQyCoQ9fff
 MMOevDbGbSka34+Q==
X-Received: by 2002:a05:620a:44d6:b0:93f:34c9:925e with SMTP id
 af79cd13be357-949ba9b3971mr2757620485a.19.1795562891191; 
 Tue, 24 Nov 2026 15:28:11 -0800 (PST)
X-Received: by 2002:a05:620a:44d6:b0:93f:34c9:925e with SMTP id
 af79cd13be357-949ba9b3971mr2757617085a.19.1795562890713; 
 Tue, 24 Nov 2026 15:28:10 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b7515sm646414625e9.13.2026.11.24.15.28.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:28:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/18] target/mips: Check for MIPS II when decoding BLEZL/BGTZL
Date: Wed, 25 Nov 2026 00:27:10 +0100
Message-ID: <20261124232722.90234-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124232722.90234-1-philmd@oss.qualcomm.com>
References: <20261124232722.90234-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX1msn4thxigQI
 nHX69BfTFrhGPnjjZXiENzndEKVERoSiVhZTvJVVG4VHg9BuhWNCA8GfmQor8aTqMoRVftknxn6
 /HUl5xSbu9PYIgwQkQamVBUSrFMD4sQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX62hpxnajjYst
 wS1SFfAco4qJSSf3+fXlfMf8HPziHD7qtWXQc2dnzBFY2BcNUGdt7H7ZImIV5womwj5UrJrbp9z
 vaE+kuL0Uc6hrWa+OjIt+OnTWe5GfCad8SrJ/Gp+iAKWFCjYPNeZ7rKPuGTG3joBYgNDNH0GCc+
 qNMr6hXgZ/A5UkcKGbFQZ1efIM+eRdQi9nTvFwYunkl2GniqGX8s6AVHO9VsQZSSfyl0A6OEe2H
 icOcpH8Tn2G4qkH3vYIQ9+kzZ27yXfYSmAgOfSyw49AYFU+BEQHed7hYKCpvrxjTge2iRLCaaUx
 tB0oUjIN23YQgsGEEBc24PgDygqDE7aZuxRHC6GLq8x3kxWLvINmNvftIiseOR/+SeMRvXAFtTU
 BTB+gg6ItRDTI7M8g0pgpJgk9iLDF2EXUoAK5iw3S5UF7614MO7aUcADcq/QtA213pU6NLiYLEK
 R+5kbWhhOvPzcTyJ2lw==
X-Authority-Analysis: v=2.4 cv=f/Xdl+yM c=1 sm=1 tr=0 ts=6b061d8b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: VlrQeR2x1PquTLGhWB_v5wWSixakYksn
X-Proofpoint-ORIG-GUID: VlrQeR2x1PquTLGhWB_v5wWSixakYksn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240092
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

Branch-likely instructions were introduced in MIPS II; on MIPS I
they signal Reserved Instruction. BEQL/BNEL and the REGIMM likely
forms already check ISA_MIPS2, but BLEZL and BGTZL (non-R6) did not.

Fixes: d9224450208e ("target-mips: Tighten ISA level checks")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261113161158.25811-2-philmd@oss.qualcomm.com>
---
 target/mips/tcg/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 10811db827c9..f521e0ec5bd0 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -14621,6 +14621,7 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
             gen_compute_compact_branch(ctx, op, rs, rt, imm << 2);
         } else {
             /* OPC_BLEZL */
+            check_insn(ctx, ISA_MIPS2);
             gen_compute_branch(ctx, op, 4, rs, rt, imm << 2, 4);
         }
         break;
@@ -14634,6 +14635,7 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
             gen_compute_compact_branch(ctx, op, rs, rt, imm << 2);
         } else {
             /* OPC_BGTZL */
+            check_insn(ctx, ISA_MIPS2);
             gen_compute_branch(ctx, op, 4, rs, rt, imm << 2, 4);
         }
         break;
-- 
2.55.0


