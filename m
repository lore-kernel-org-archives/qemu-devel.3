Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DF1CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBtU-00034T-40; Thu, 18 Jun 2026 08:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBtS-0002wC-35
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:30:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBtQ-0000XG-0P
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:30:49 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65ICT23c1808409
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EA8ekpIUt39iaM+Gippsl80etLpcd761bN6C4P7iDyo=; b=NK5IrRsEwv5tlfV8
 gXQxdVVLq9NjRjmBtqro/0G6KiM/lsg+HSUB09B6KBnnPnPzeagr76TMxis+DE8u
 MQvgjKN7VZNTZB3XMMbcuRNnSduHrKMiYyreGqZjeFFTMcLGSnxcnTzRmMD0gJ6a
 I10SHi77CQzsWEQnWo0Ac1jLwTdj55t97SJaf5GgiMcUVCQY2lP5yeVkStWLrwrg
 uOLJhsv9wg6HSFGzYMcjV4+s833tIDYPnrMJWTz6LmOrBan1rLerF6mwlgRRJTxj
 ChM4/E1RFegbrrKcgVD+2xm7+xzr2TKBP+sahXTRzE9pqBcc4w3INY6sLdfO3nCW
 IbNQyA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2jvfsq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:30:46 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-6cfd2462acbso1147766137.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785846; x=1782390646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EA8ekpIUt39iaM+Gippsl80etLpcd761bN6C4P7iDyo=;
 b=NKcU30yUNCUrIW/wvy6e8G91UgEmXMsuue8B6FA6ZwOBKbMgltA3VE0b4J3gMqaGi5
 gDMow1p78yG467SPFU2V6Seok7WdNRJcEGu5sfg+X8ZuL0sHimn9L/5W6eLG9LEm+XmH
 OKvWhz/nxLeZhMRQGirRvSjWwc2FtTTolntYU9BhCVppRcoop6lJwFxxilgPsYJ43oaG
 hf8MgYY4kROSOxGB0D8gEgCEwtZ5u+/6NtJGAHaByUQ94T+eyVhu+uapTNcef+v6F7BS
 AwKh+NBxvdUJ+12hBc2+U+ZQaklRz1BGq/ys60HgDv7rJKeE6lwYCiW12Jt4lg34m/w7
 ni+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785846; x=1782390646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EA8ekpIUt39iaM+Gippsl80etLpcd761bN6C4P7iDyo=;
 b=gvWuVD8EVxMwl++X7sL9N+v59/VWok9o4GAJ0lkFrHqIuPGhx8ndm0RUDJLL5fpJ7i
 mVdd45L41RD8/xIgoSTD8M3Apu2CHcsTZfc5pcoQHqpbHSfqhUHkyiE0g5WevJzVmdys
 ZBjmhMIMjihcQvevmepVUdtP2wvqKG5qwaVQ/M+qLJFwgxbKpdyDBLN9i8dme2JXg0YI
 cV3l0anjAD1j2v43eiwm0/RzMoqv/9C1Mv9SjrmVCZXbW6M6Sg7hKBELOdAEQP2hByJk
 f9NYX1fkTr6SOJ92GAtQ1CoLy/lE19ZxQPSPuycnhYc+a/wwrLyOlz7v4NCbXh/ix/99
 SQFQ==
X-Gm-Message-State: AOJu0YzyCKN//kmMpRXDjS0dxXvjm12alZG0dX5EUvcNbHtKZQvD2ntW
 nTSzggf+GGRXJTlCju3G476DrsSdeMVydAxg1eCOQ+HXUBQKzqZWbqESatXEwIHXFgdsKK9Bl/O
 WSdtY9xyJbab134KNpq5C/y2S3MdakJ9uhIFCs1VxV72SRVhQ2mgwITQsu6oPuyiYKg==
X-Gm-Gg: AfdE7clrlZFgpc6/CpsjnpkPdqK0HfhFcKslIpI0HX98R4gyoQ9mwyfcdm0Uo3wzvkG
 bsOoF0hnFgEqUfozgkzPP56jcf+o8lib/eitl+Dz31pa6cuvbqgEz5qzDypcFF0606TLUElYthw
 jDDhGmFKA5dkdGAgAEDnH3+R8Fxf52AvTH5HtmkLiC+v/kfJiqZU7G7Ie+mbiDmDYxgEjuFRjhZ
 8reUYReno4OPQ9WVQj0AZwlm4sX8AXdJic/MIKSRfiJd6cxnV6PfFdWAeFITtIsBJyBm2KtPUfS
 Np5gYGgQ1Fs/oRyMpLnTGg9njTfc/saFLHJ9JyhjzA21h1jOpAUTfvQI5LHq4RQzsAE4X1zSJ9d
 ZU5ExMuTz6SM9HW1C2ot97nANsWpz2fj7I42Po0taDLeYtc9DTMb+DZLXJut3QFYU5sli
X-Received: by 2002:a05:6102:b01:b0:631:4580:6a46 with SMTP id
 ada2fe7eead31-7246c8907c5mr5192363137.17.1781785846224; 
 Thu, 18 Jun 2026 05:30:46 -0700 (PDT)
X-Received: by 2002:a05:6102:b01:b0:631:4580:6a46 with SMTP id
 ada2fe7eead31-7246c8907c5mr5192334137.17.1781785845744; 
 Thu, 18 Jun 2026 05:30:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2e592csm65817003f8f.36.2026.06.18.05.30.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:30:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/48] target/arm: Remove vcpu_dirty=true assigments in
 hvf_handle_exception()
Date: Thu, 18 Jun 2026 14:27:56 +0200
Message-ID: <20260618122825.90331-20-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX/+0a0B/9cUOw
 3JSxkR1OUXB37BbaXb85MZqyG+x9T1uk53OZCNsryXIEr0rVRAN/70I+R5Sc9Ja26uQm5+wQ9kq
 GiWBXcfK+Bv24OHmWZrbi6t7mFuU+ZlqhHLmJkThiJ18rNApZ1BuSns/LPx+msueqozmnlMLsn6
 L7MWaE0DzPLI33wnzUJDNc0kP6LL5fOWVEjLcByPY/vjiYJT7GDu0gsHCxWBMoBThYa/iasSaaU
 Ixe5BNR7BbxWYekpZxLhlkn1ojv06eulBxw/IdAw7VBeugx+GSa5sSyaRq+5svO2EtXEa38DkWz
 GOX0eMkV4D0W6eLeUciDBmzNq86yautaS8eBDLSLezD2rWyc4H0lYeSJFZ/Z+kpQQfGaDNGa1hw
 tuEAjwW6f14DOvdWPhYXT+gMI/p8R9hwPYpFPP+J5OHOPUQX/87jrTq/odBb2g73zA4BnlnqL87
 Oo3ptCz1at7rAp0fscg==
X-Authority-Analysis: v=2.4 cv=Fsg1OWrq c=1 sm=1 tr=0 ts=6a33e4f6 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=5q2SuUuym3sBu2ZHr_wA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: x78nnEhG_96KMK_SMPLUT9n5tWOZVL7M
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX76Z/70PGm9Ej
 66+VciLOgxe1z5iZadPPDi8oofDtlBeZeD6XsivkvFdLzyxYrTPgRoUw0NosnLLSvI24Z0nlqpK
 c4H12z3uGHdEgNXNUP9GoxdzIWOij0A=
X-Proofpoint-GUID: x78nnEhG_96KMK_SMPLUT9n5tWOZVL7M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180116
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Commit  2a425aae0b5 ("target/arm: ensure PSCI register updates
are flushed") manually sets %vcpu_dirty in hvf_handle_exception(),
but these calls follow calls to cpu_synchronize_state() which
itself sets %vcpu_dirty. Better have the generic CPU API handle
this, but add a pair of assertions when serializing the accelerator
state to be safe.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260423170229.64655-13-philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/hvf/hvf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index d88cbe7c82a..a5b30b9ef0d 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -794,6 +794,8 @@ int hvf_arch_get_registers(CPUState *cpu)
     hv_simd_fp_uchar16_t fpval;
     int i, n;
 
+    assert(!cpu->vcpu_dirty);
+
     for (i = 0; i < ARRAY_SIZE(hvf_reg_match); i++) {
         ret = hv_vcpu_get_reg(cpu->accel->fd, hvf_reg_match[i].reg, &val);
         *(uint64_t *)((void *)env + hvf_reg_match[i].offset) = val;
@@ -945,6 +947,8 @@ int hvf_arch_put_registers(CPUState *cpu)
     hv_simd_fp_uchar16_t fpval;
     int i, n;
 
+    assert(cpu->vcpu_dirty);
+
     /*
      * Set SVCR first because changing it will zero out Z/P (including NEON)
      * regs
@@ -2498,7 +2502,6 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
                 /* SMCCC 1.3 section 5.2 says every unknown SMCCC call returns -1 */
                 env->xregs[0] = -1;
             }
-            cpu->vcpu_dirty = true;
         } else {
             trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
             hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized(), 1);
@@ -2515,7 +2518,6 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
                 /* SMCCC 1.3 section 5.2 says every unknown SMCCC call returns -1 */
                 env->xregs[0] = -1;
             }
-            cpu->vcpu_dirty = true;
         } else {
             trace_hvf_unknown_smc(env->xregs[0]);
             hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized(), 1);
-- 
2.53.0


