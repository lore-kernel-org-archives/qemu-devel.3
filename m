Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18F3C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhjg-00085B-8Y; Wed, 19 Aug 2026 10:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwhjN-00082C-98
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:57:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwhjJ-0000Wh-15
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:57:28 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JEbo5h588414
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QgUysn3SMo2tJ02Sc8djy9h4bEXcPlT4sNQIBOYSXlQ=; b=Ue9iHFSeL+LnbV/C
 CHG/AxbzQCLfrnIqxBOEgh9Da8PLipHM09oCDiN9O5LGuVYTfc4jVbRRqlLHxfVS
 pbsv5rW/PC3JYw36QLrO83kVKpQxmj+HjhHhmISQOHCYnXkYok937fAD5l9YWU81
 3Aj9ryr2g/13RriF9HegS+eDwCuQNGKCXYQNOlM2e+JUQUVaDoITtR87AaazPaU8
 o9qscOyQyxx/Rp1PiWdT06y0DIJneUdtGgHL+G2Bhspoklr3sIYQ3AD9L0fes1oo
 6UFmKTIBVNxu1hLIAE9nex16CB5WApyAF5YAUx7/1MvL34QrxqoaNddIqEB/N76c
 HtrObg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfkbuqv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:57:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-936708f129aso100402885a.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 07:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787151440; x=1787756240; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QgUysn3SMo2tJ02Sc8djy9h4bEXcPlT4sNQIBOYSXlQ=;
 b=Mx0z3DtnwAE+Dr0IXC9ZU+Xku9gilTSPFtQ1BgxlmB56AkD+G2/nQvK2K5CMvIQxyW
 JaI2j9Y8FD+T6NuDE6SUF1AtCNKWsGPAKY2hW+Yk85/fBuaB76foMvPVB5F68s0iX3AS
 jwfjMPqHOXdO11tcDm9ArXEwF6A1HEnAT/ygWB3w9378Q0B/etf1GB4M4dRzvdJgJU8U
 O5Mu5idihC8cYP88rRKcw9H+Zq6F4xPpMLLanwFwPD3kShkZKUbOJrN3tPb970OEvUPz
 Y8R0iQr2TvaWDA54QXM5oYOv+nI420hD5bmuWciYBclFEGUVGM42XsVn38PBsRvCEuxP
 u28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787151440; x=1787756240;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QgUysn3SMo2tJ02Sc8djy9h4bEXcPlT4sNQIBOYSXlQ=;
 b=RDA6Kig4tEScKZMq3VmTXhRnb2b+OqC78WMtnNRX2LukPVYrftvC4MnpxtD8TO8Ow7
 6C600KTsQ2QK0YBw2KvVi2xIuVowUTi5eIbUZUjDjOGFtnPugLIdnG9szjwespGyB0eH
 a8PXxBsPqp6xpAPWyTjdbbumxosgCswZvX1UmTQZ+RMswEpcGzvd6B9yfR7NVgUq/6P7
 UCjKDvFqGxpLRl6cJsvTHfGYxuQ4aG/PagkUOWnFM2wBtVrhZBMLNdaO1TvEe8LSRs24
 P/nnF3xtK1gxGoz+RQIK+M20TYv/mqG9Dks8ORRGHOWVmSZiFIGSmh05BvhWPG6KGoWQ
 XZ4w==
X-Gm-Message-State: AOJu0YycCa77uW0Sc91ND0sCPDiVxzt3o/xKa5zLTUfrpT+eC1v3m8xX
 G30RwQznYUuIMw2m/fV34+/TwYJf7hCzY2JVkOt305uqjcwuwZXCapPQ3RKbd6DtU4i7yfrEtEc
 x/uIbmlojMfDjWcGi4SPrmPg9LHJF3r3rkP4vPK1DcEBmZGHhwiKs38zkSp7qVxYf8GKG
X-Gm-Gg: AR+sD11scdjWv6EeJ0Mjk6CUgJFArvzDR5lB9tjsGeHeFve7YHGtmiZ9vP7ZI57Jsj0
 9obgU4/Wk34iESKDhCnjzmmZd0KuY74hE0JVmdF1JAuyC68ee3XflCBCYeG20fVijqh3bXKUQsl
 9yEF1hrSkHG1gxO5cgIn9bYc8eSrp56+2yDlVpRafZoBYpyY+yCcQMtQcpkr2vLh1/SEB1Vt0li
 E4/NRkqmAxpSEFYpMRKqQU2LxP45fRTKB5NcapDzZhOdqaiN8ID1kh88YR7DSJASJnpYwmDmOpZ
 sdINhL2dBKaYF8ndBx6XIqaCMy2j0ukH/wo/V4quobeWIFfHyItdYJtHa+214x4Q2y6KqXR5Nut
 dlfSrSFX4rDRyXvJmsUlkFiR0Ro1oexMTbR56eUbZQQ==
X-Received: by 2002:a05:620a:4015:b0:915:9fba:8794 with SMTP id
 af79cd13be357-9371e204e33mr497456385a.6.1787151440094; 
 Wed, 19 Aug 2026 07:57:20 -0700 (PDT)
X-Received: by 2002:a05:620a:4015:b0:915:9fba:8794 with SMTP id
 af79cd13be357-9371e204e33mr497451785a.6.1787151439592; 
 Wed, 19 Aug 2026 07:57:19 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0d6964sm61440885e9.9.2026.08.19.07.57.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Aug 2026 07:57:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 04/11] accel/tcg: Refactor halt-to-execution flow in cpu_exec()
Date: Wed, 19 Aug 2026 16:56:42 +0200
Message-ID: <20260819145649.23439-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819145649.23439-1-philmd@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XLwJBL0Z-tVrKg4G6vPTFHz34XiVySAl
X-Proofpoint-ORIG-GUID: XLwJBL0Z-tVrKg4G6vPTFHz34XiVySAl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExNiBTYWx0ZWRfXyxdHMl8mCw7T
 UgOPVQmIEBtfXGtbS1pQ3WiyVHM1IhbRXbFFtR4V7SFokWZKqAN64ZKqhXy6cDKliNXjAJKtpmH
 VliIXmZkVJXLCj1Efa2WhdhFRzN18YsSMhulUVo+SE0yd6YCeFh6reaRoeE5QHZouIHlXrj9D8E
 buenXjiT1T3P5j+L389IecBv1D1jnF6N0N5azktY+qdzr/1IgLdkyzFAbluuXLNXR1YBH/xkF7D
 S1r2bi8uT4/W71cNunYjX/f9FqMnkdTscqAHMGNDlaTuaLE8MKj9Sati75PumKPUq9hMJbjnj7f
 LKSr/tlCsXZVxGU9b7C+k22ru3RR/rEWhqFnli8K3M3o1UVOjHfwFwi38c39NhlUgA2hKjRJdUu
 RIezCntzrZZrpBBkiIr7D1Dc7DIOFtwmF2NRF4HCnyhyhksI3bMSU0gWZx1mxdp0hGGV7NtK7CW
 KRmcusO5wyh58YFNkLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExNiBTYWx0ZWRfX2B7smCFbMBhY
 +iMMuzHTe/IzVOsYn4Kgkp3+E0NyXEVNnTuyzymrnkr8IIPT35ohhmLwp9XEmlkf1A+jq1vdOkq
 ak9cI1NAi3VPZINdidhbrBt1jqqDjZ4=
X-Authority-Analysis: v=2.4 cv=fvfsol4f c=1 sm=1 tr=0 ts=6a85c450 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=sbHou6fnXi9S1vdf29wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190116
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

Invert cpu_handle_halt()'s logic to read in cpu_exec() as
"if halted, try to process async events and find work; if
no work, return".
Rename as cpu_has_work_after_processing_async_events().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 accel/tcg/cpu-exec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 46b723cb734..1a942664895 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -654,18 +654,18 @@ static inline void tb_add_jump(TranslationBlock *tb, int n,
 }
 
 #ifndef CONFIG_USER_ONLY
-static inline bool cpu_handle_halt(CPUState *cpu)
+static bool cpu_has_work_after_processing_async_events(CPUState *cpu)
 {
     const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
     bool leave_halt = tcg_ops->cpu_exec_halt(cpu);
 
     if (!leave_halt) {
-        return true;
+        return false;
     }
 
     cpu->halted = 0; /* allow execution */
 
-    return false;
+    return true;
 }
 #endif /* !CONFIG_USER_ONLY */
 
@@ -1027,7 +1027,7 @@ int cpu_exec(CPUState *cpu)
 
 #ifndef CONFIG_USER_ONLY
     if (cpu->halted) {
-        if (cpu_handle_halt(cpu)) {
+        if (!cpu_has_work_after_processing_async_events(cpu)) {
             return EXCP_HALTED;
         }
         assert(!cpu->halted);
-- 
2.53.0


