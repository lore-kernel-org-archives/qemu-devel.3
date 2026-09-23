Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B275C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9QZf-0000bD-MK; Wed, 23 Sep 2026 13:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QXW-0006Tw-DG
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:13:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QXT-0001LV-JA
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:13:49 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGTh1B3938136
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /5gPZ0r9el1io2TJV/MmocNJREFtJ5CHkCI5Btb3anw=; b=puIIDaR63fI+3uYW
 4W041okidglmLhaedEalM+0c9Abq2Ulva1r/iFZAIWYWMynbEo6wGxrhMRQR6osd
 T7avsjHucBZcCIp4PMifaa3wwBWPZE1nFXq0uht2afJ5Nxis5kfw4q8MlredVs6o
 ZN0jKjpC/Ki7DJocls0cD+1tT35n/s1ogq2/bPR6QQIeEwkVLCo46ULFzlPTMGPj
 ncNNI0MZTORgw+SCKXdRbtfEmNt5xLEMbxAaDnioO9nMzXGRe9U5Y2zWXPVCt+rU
 Mmj1nHU2F0sV2cxskhO/qiJflsdCG7+NP4aFD0yHDHt2KfD0Du9lZSJDHmaraJfo
 x5E9oQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbwma2qw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:13:36 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7a9378b844dso413527137.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790183615; x=1790788415; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/5gPZ0r9el1io2TJV/MmocNJREFtJ5CHkCI5Btb3anw=;
 b=BjWtUF2A39y/eMkVM0Rwkq6NnytT/Yi0y/23z1W/EBzJGbKZp+fcC0WwG4lanjhcDI
 ATwR13j22Gf+wDu33iwr5YL6kYhrXIcgO1n3ZpwxnKmKYyha/kTkONkG1oE9XVm9JJQj
 EzR0K/Z4H5Gnem5Gs9+7Q2xuIDjslsrZ3kH5ntUU8gV5yZR1g0TTqfecimFwMzTwULmE
 ghx6GrWwteyrPXuKBgZnkxNdQvc9F8/HCTIvmOrk+JvwIfKhunA6TtIInSayZe0LE6SH
 4zy3fE2AYtNEkQqC/PXbfFoMKRZiwPH/qX2y+7WNOrfKgJOwRk3IH9yvrI3fAI68Y+ZH
 V0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790183615; x=1790788415;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/5gPZ0r9el1io2TJV/MmocNJREFtJ5CHkCI5Btb3anw=;
 b=qzh979sLf1DP8eJoimI31quuYo3CODmMfguTG9WS3qX3w5oUU0eHnxn+9vVDk/mLR3
 fiCzexFf05F1N1yec2CvTmX8GIc+Yabxm0RwuhVmZ1Md2fumme5Qud55ggYmihGZfCk/
 8VAh+2QqD59Kr8yTHJYAWATt+IAsmZ96Dug9/ARRE7u2NZng3V480Qb0w0KKdAOYgBni
 rDErQ3sFtjzgqEy1nvZUw+aCt3Dbc5veLs82JKG2vzqjC7Y9ewWD/nXTlDpyiXaETR04
 1ZbTXQ7w/i4IlEc+Cl7shU0caZNSdYYnY8A9SfcH7KqILZx3etDAiIqMAnrqfcmQHsNz
 fXxQ==
X-Gm-Message-State: AFuF++n1eAenJGVlxQYtxqJUvUdf7HIBeqgPN5IKhPHbf7g1VlNFjeAF
 lMfpE2S5Smq6IlUm3Wfs3udAQif0RhmSzNEsB5cTudJf5Uspyx6yiM5i2ZimJbfxJzSCmz1m8Al
 A8HD0h7/2G+esZW0wiAb7J2uogj9UwBTk1oApRlsRKQ6CgDBEG0zX8gMGbch4fqSAQPf4
X-Gm-Gg: AYBFou0yugy278N4D+DoyHYWIBGSmlgyIQQnHRHvqK0uqzf3Wcj6lie6KZbpJ5QiwmS
 caCMXUZsqU6sw0udRqeod2+QlQ3E6chXOZbh15tNsWflCmLoTIV0tye9IGzmZHbSCx6ud/kdZbI
 Iy3fpMWys1Tresryaq0WnJBMFk38iQDTNY7eJ2gtZKZ8jM9eDOQtAViBF/2PmzBWvrnM9LFGAt7
 dzXwnEjMFTixfvmAc/pYCUJbiizU/C5rxs6Kz47QTldf4qVc0fZEKzXE40GXFwUifXOHjtqDx9V
 09+PUDSynXurMlxr4HRM5QWPNsVCRlgAzJLAwZnAmewtJvg7ZoE0QyzfyB6GX3cbRINIoqc+GZ/
 Ol/nElm5g+cWa6ugz12uKogcE3c7JQtsa4Q9nVTWo
X-Received: by 2002:a05:6102:8083:b0:798:8ca:3452 with SMTP id
 ada2fe7eead31-7ac1aad2aa1mr3022017137.1.1790183615285; 
 Wed, 23 Sep 2026 10:13:35 -0700 (PDT)
X-Received: by 2002:a05:6102:8083:b0:798:8ca:3452 with SMTP id
 ada2fe7eead31-7ac1aad2aa1mr3021994137.1.1790183614917; 
 Wed, 23 Sep 2026 10:13:34 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5de187asm317215e9.7.2026.09.23.10.13.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Sep 2026 10:13:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 18/21] target/i386: Split APIC polling from
 x86_cpu_exec_halt()
Date: Wed, 23 Sep 2026 19:11:12 +0200
Message-ID: <20260923171116.31276-19-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923171116.31276-1-philmd@oss.qualcomm.com>
References: <20260923171116.31276-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfXzqzuRCMfp4T4
 nZe9TLHCXprbKJqsG4CuO6Z4gmm5G8yrZ/Xy//wYrNWDksn+pGVt2T65dHQLEZht6LBFIL/JhBo
 CtUygTuh9QBaItx40VHMLQB+9dY8wPs=
X-Authority-Analysis: v=2.4 cv=R/6WitRX c=1 sm=1 tr=0 ts=6ab408c0 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=h7OMh5kjI76PbTVxvEwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: UaUCudZ1D1YbLCJzN55O2Je7VgpTmgeP
X-Proofpoint-ORIG-GUID: UaUCudZ1D1YbLCJzN55O2Je7VgpTmgeP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfXxe5VdlpJSBh/
 XfJo9+RyOu3Z8wPgWXOPzO4rXe7ze7w7LyKQ3oFAUyBlGAEv/aCOlu9W8tnkxT2ky3E6EZES4OL
 OsMEq+Zk78Hir7lOkirxavAtSchfHNgfw9PcysUf83L/7JChlhVaUw/iOGHOBqhpZXDiBJJgSfG
 M9S6DX22/3UxkXNELpgl4kjI+XPpiDvQrBg3z1eD1xfCTzUf3c9qULsEsvgg6R0o9JNcyPjNTLT
 zz7+dFq3BaBaugfZrOJAnD3nZ2pmoPXPqlOwPVWU1BPt+HjBHoKPVnsXz7j1844JsoKmQHRBDnw
 /ZGHUz93VetJD2FIZlSaPxBhJggxxP/Sa3N5qNY05s/Lp1k3paJquxLBfH52AUxLVURl25FGG6x
 F2bBL6h10DaaV+rbYHJt4amaEofg4GFvyzNslSZ2+/ed3LzBhIuBCdmGP0DFbhWNxULdXjknvLO
 BpxPTa/m2MIdxgaCEpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230068
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

Move APIC polling into x86_cpu_poll_during_halt() while
keeping the remaining halt handling in x86_cpu_exec_halt().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/helper-tcg.h        |  1 +
 target/i386/tcg/system/seg_helper.c | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index f4b2ff740d5..58e8ca0bc1b 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -37,6 +37,7 @@
  */
 void x86_cpu_do_interrupt(CPUState *cpu);
 #ifndef CONFIG_USER_ONLY
+void x86_cpu_poll_during_halt(CPUState *cpu);
 bool x86_cpu_exec_halt(CPUState *cpu);
 bool x86_need_replay_interrupt(int interrupt_request);
 bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
diff --git a/target/i386/tcg/system/seg_helper.c b/target/i386/tcg/system/seg_helper.c
index 8c7856be81e..9ce608a0bb7 100644
--- a/target/i386/tcg/system/seg_helper.c
+++ b/target/i386/tcg/system/seg_helper.c
@@ -128,10 +128,9 @@ void x86_cpu_do_interrupt(CPUState *cs)
     }
 }
 
-bool x86_cpu_exec_halt(CPUState *cpu)
+void x86_cpu_poll_during_halt(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
 
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_POLL)) {
         bql_lock();
@@ -139,6 +138,14 @@ bool x86_cpu_exec_halt(CPUState *cpu)
         cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
         bql_unlock();
     }
+}
+
+bool x86_cpu_exec_halt(CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
+    x86_cpu_poll_during_halt(cpu);
 
     if (!cpu_has_work(cpu)) {
         return false;
-- 
2.53.0


