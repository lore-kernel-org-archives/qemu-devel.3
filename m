Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4321CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBySd-0002ox-Rd; Wed, 30 Sep 2026 13:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByS1-0001yf-9k
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:50:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByRz-0001YD-P7
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:50:41 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHfCrA643953
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Tg+6JGrg8TlSUod8NUCzwBY6Ua5KjOcrJARbt2DJV6I=; b=Ios2Xbe0fFGXybAW
 dfwho+AXJg+iEMPtZv531n9bOnPKB39wiGQGoHIvOrp3iBDG8PNnVltC/AGV8fRw
 lVuj8kfgymSTQvJvoB4xPp5dFpx0KkLl95a5tcANYlAqJY2uLAoJ1++gayBxZlOx
 SYrpZuYqy6cRUjZOCxw8hwUK4hsB2b6lhik/3fjNvPFtTBL81WNd222EbUP0wvnq
 2qkPKnd6y6peu+c9+G4dW8TA15spL0Nesoej+WTJg5NGr8yjhDcia8jau6HUYmFl
 aP6O3nzfdLGHx20VRSysioLj3CSpad+RmYL9OAQa68Fmmetjeepwq+dfX7ToKSaU
 GX3spg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h14n20uxm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:50:38 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7b731e00834so2900688137.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 10:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790790638; x=1791395438; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Tg+6JGrg8TlSUod8NUCzwBY6Ua5KjOcrJARbt2DJV6I=;
 b=hxR99tugjG9Vp4BUd4z73K1qW/gGOFcZJCMUown5+xyN/0CmG8Yz3cd5JRbsmHnsLY
 aCPLg6FKRNZNq3yVwVm2VyjJDAGPMdkmunkVUBZS18cVaAH0pvFN9bgjx2P3s3ylbNLj
 Z97cu2fF1OME13bBF6agNirAq7kvYF3OiHUogbESNUICVOPkapDKPbhxiKNVwlJqB1PJ
 JHTLP4VSDYXD+4eK5Us1XYeV4D4z85peIu6YMQ3UUI6nB8yv9Kk+8EI29XgfDCJ6Td3r
 wE56/LX84XRCW+rwyHBGsmhKkVNyaLpcXlEsJ8ooqzIYgjFVwMy+9EOzaBZeiQJ40vpq
 d3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790790638; x=1791395438;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Tg+6JGrg8TlSUod8NUCzwBY6Ua5KjOcrJARbt2DJV6I=;
 b=ybIHLTzaAub1oILe7YuTg72sCs0YV2/NBOLbKxtiG9SiYRfOvU6ZrErqS4XCQ2dYJB
 EqSPlw+b0sQWTZnVgoQBcGzqHki/e2J8LYEFy4vjzWJm1JbbP5mx6xtmb03e2sO6Awn9
 Sn2DqbtvBpJcypeLe4s4CmeeieANXAzf6HFeq0tkJg/6PnhpwVanFLwTDnHKfkOsMGNT
 vAzK8UrBjdDkQzEZfwbLi2DELgqo3cF9Z9ibVWHLZoj8lnCKOa44R+Md8bpAaAQaUoBB
 xVSoPRpsI2uNZAHa4RHmxXVbLRwF4CY6nXY+lb13H5umTpiHPGDWGb5CZflrh564wxWn
 uKVQ==
X-Gm-Message-State: AFq9FYLeNhFLEXhWpP8yxvbA4vQ+zrqfwWLT72YknMqVxJe7WXLx0SbG
 9Nnfvd9ko2gRlkSgbHFnbtAvgav+4lAVGWLdVcUaV7ih8d7grO0wE6fJNJEloCIWXrrTKV7elpA
 I/9o6ODdqn1i4O7K/oFT+h8AnwFTXjWOjCQ3nIMx6t7fzN3VJEzq7jrl9xGusuz3eYg==
X-Gm-Gg: AYBFou3BCJVzPFD4kO+9M+ouJSz+7FDzfUFV4PAXCQLTK9p2zt9Yer/zveaf7wOUYTK
 6bBknOgC4XZAVScgiwf0vii4De7TiWBDav+xdjcL0vX1tkkTT/xFD3laxmQRJy8mHYvyjiDeAG+
 2IDxu8NeLmKb4SWt4s9Nginy3786xjf3JquyHxmA4DyoESCjrFNS6oBsqNEUl0x64BkxKxEPTdP
 wP5eVbK2+P6SKOxOIpnG6QAaoqsNXgAXhByHpcyR/Or3cNbepbknRi2EPPmlDVVD9siEPAAjf5n
 ru6nrO1ePZu/ytc3Qn7UAQc5/pwkkrEpj0w33JhQO+CGM3pw9Y4FQWAogjieEHCxa0L5A4bRAox
 TnqvkOMuA2f0MdXiJjDqn18gKml+uGqqbXlZKX4sF
X-Received: by 2002:a67:e7c6:0:b0:7a1:84bd:7f50 with SMTP id
 ada2fe7eead31-7be61e90ccfmr698163137.1.1790790638203; 
 Wed, 30 Sep 2026 10:50:38 -0700 (PDT)
X-Received: by 2002:a67:e7c6:0:b0:7a1:84bd:7f50 with SMTP id
 ada2fe7eead31-7be61e90ccfmr698152137.1.1790790637730; 
 Wed, 30 Sep 2026 10:50:37 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b068bcb8fsm679369f8f.1.2026.09.30.10.50.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Sep 2026 10:50:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 7/9] target/i386: Use generic halt transition handlers
Date: Wed, 30 Sep 2026 19:49:43 +0200
Message-ID: <20260930174946.82195-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930174946.82195-1-philmd@oss.qualcomm.com>
References: <20260930174946.82195-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gr3XaU1C c=1 sm=1 tr=0 ts=6abd4bee cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=xWu8-Agft_6X_INOG6MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MSBTYWx0ZWRfX7qnEhkE+Vwu3
 qRHIN4RYH8YUOjZpj6h5Wz92Pg5n7b4fMBGo/t2KnngsJy0nf0sh7w75zDN42TKij5dMSSOeE+5
 BRDGVRYURBzqXShFoSoxYklMYPRriuo=
X-Proofpoint-GUID: RsFMkdgBq1E3I4b66UN5kta2l3s19D-s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MSBTYWx0ZWRfXzzLAklRlmJBv
 THq2/v+k3H4nkPvoOpwJZdHsMcM3fplkJGL/mjpoxJBVLFn/R8PEDNvL71OUpHhQR/i1ygd4tmc
 0771pSVetKWZ4wbM1HplGvqvT1nCOSIBtgXMHUybvcZrtwIHdSfq8okDALclJyMNJ4HdK37zCVJ
 Rc+AAgWjf+dBhrUY0tmohfOLo7N/DfSNd0u4Wyga9BP9566w2YCuS4ddYJUOUu9L/tvwVX8jOMp
 8SWyoVnQ/aaPMfpN8gagwOjC+Usd3A347mMLF1THL9jDuqSaI/PqApksKiBfXsgA+EjxccBcamM
 XZ5+zc4U5IDrZgfMem5LpdUvWiQiUOWlibgK3RAryoB+PcyXhODkFAnbhl7qkPbwZy5ICuUOq1w
 GfjOOTtzGNUzWDyHABh/Y81WzpDxVLACpsNWWMuHE+MSKEbp3fgX5OrvZJDS1zO5GfEvn/YAozz
 ICA5BZaU2ez7Dbg2ioQ==
X-Proofpoint-ORIG-GUID: RsFMkdgBq1E3I4b66UN5kta2l3s19D-s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300071
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

Register x86_cpu_poll_during_halt() and x86_cpu_leaving_halt()
with the generic TCG halt flow. Remove the target-specific
x86_cpu_exec_halt() wrapper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/helper-tcg.h        |  1 -
 target/i386/tcg/system/seg_helper.c | 11 -----------
 target/i386/tcg/tcg-cpu.c           |  3 ++-
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index 96accb30a80..4d543556a9f 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -38,7 +38,6 @@
 void x86_cpu_do_interrupt(CPUState *cpu);
 #ifndef CONFIG_USER_ONLY
 void x86_cpu_poll_during_halt(CPUState *cpu);
-bool x86_cpu_exec_halt(CPUState *cpu);
 void x86_cpu_leaving_halt(CPUState *cpu);
 bool x86_need_replay_interrupt(int interrupt_request);
 bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
diff --git a/target/i386/tcg/system/seg_helper.c b/target/i386/tcg/system/seg_helper.c
index 566b3d4d80c..e24d01000ad 100644
--- a/target/i386/tcg/system/seg_helper.c
+++ b/target/i386/tcg/system/seg_helper.c
@@ -157,17 +157,6 @@ void x86_cpu_leaving_halt(CPUState *cpu)
     }
 }
 
-bool x86_cpu_exec_halt(CPUState *cpu)
-{
-    if (!cpu_has_work(cpu)) {
-        return false;
-    }
-
-    x86_cpu_leaving_halt(cpu);
-
-    return true;
-}
-
 bool x86_need_replay_interrupt(int interrupt_request)
 {
     /*
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 6f5dc06b3b9..2fde412394f 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -180,7 +180,8 @@ const TCGCPUOps x86_tcg_ops = {
     .tlb_fill = x86_cpu_tlb_fill,
     .pointer_wrap = x86_pointer_wrap,
     .do_interrupt = x86_cpu_do_interrupt,
-    .cpu_exec_halt = x86_cpu_exec_halt,
+    .poll_during_halt = x86_cpu_poll_during_halt,
+    .leaving_halt = x86_cpu_leaving_halt,
     .cpu_exec_interrupt = x86_cpu_exec_interrupt,
     .cpu_exec_reset = x86_cpu_exec_reset,
     .do_unaligned_access = x86_cpu_do_unaligned_access,
-- 
2.55.0


