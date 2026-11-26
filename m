Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB5D606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 22:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SW5xHuun;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BL13qPnS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWhuW-0007qH-Rk; Thu, 26 Nov 2026 17:25:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWhuU-0007oX-EA
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:25:46 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWhuS-0003ol-Rz
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:25:46 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJwd2q361595
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 22:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FoIoiGPuSPe26i9fdJVUr8xYE/el7775Tv/MdM2Txac=; b=SW5xHuunz7uRtcbq
 WfpV2vxH86flk5mhioJslzOD47BJr6TjaIQmugUJnoaUUlnCXfbu7gh4cvwIhn02
 fjS0qYKN4pbwBfweIspX/U1WpHl1TNeAPWk6yyRAIdb0Ww4AVgsLCLXAt+uibFmU
 KbzJvGkvGv5JIRdIKth9rUjOB/7vIq+dmIHyEaan2yIWwYCeY64EETVGrHfq0929
 yRoEvhuovfDrn1lHti9DBgLRcNWYxoxAL1QtYN2Ii24t1wsVuDiuSxn9uzx8qCbf
 wY03uFlKVd+40Z9AZOV+XHGRMbnDHhykRI3JrXjC8EG0UpM6Ji1SBzUADjPRgWlX
 Hxdtkw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6f8rk23w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 22:25:42 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-949b0d322fbso1030685685a.3
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 14:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795731941; x=1796336741; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FoIoiGPuSPe26i9fdJVUr8xYE/el7775Tv/MdM2Txac=;
 b=BL13qPnSBroaxCNkg4SxWTIpUMEzGMtBxUAOLh9ssICuEwyu00raJjlrV6K0GYnCWT
 PKOLtn/LqN4gnym73U4CU9QJObCOBSNdCr2WItE3q/dl6LpgY4R279MN41WcF+nE8+cS
 hhBtlbRUQDNYH+6USPqSs8RVFifHlVAaaSMmBJVQy91o+ol63OIgTFqhRJQn4L6vwRhD
 odxP1ATlKCAzWfz/xLaoDT6DiSmnJqFjRkFSj1in9f/wHvQbwe7MYdS9BdfqGVW8lRLU
 SMLZCI2RuFKAZ7Pw4/t83pFgfQhqQ3LdEa6Ec5A82JXWipMLGXv1Js2dCyzp9DNL1xyd
 F/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795731941; x=1796336741;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FoIoiGPuSPe26i9fdJVUr8xYE/el7775Tv/MdM2Txac=;
 b=kqY4hU/6MVJkzeUQCWBGnt3xjEck/qW4u/NN9hcgHSAeartHMxqXvWReDdKltwk6HK
 7yGjos1gKL44Sd9a9KtXaO/Aic5v6do0E9Z+4E+HpozohUdrlZvfs2epyhYEv1b0iMnl
 ZkXWebHj6NLf3YiO/Ommy8pbHKKXvnqWFba8bHDCfmOdUApOJfB7vMwH6t2yDcIhqAJ9
 42dJxwrjpRimiGo2Lvioez2IXDV8/Km/2aP7mW72v+iRlESy6GRcCxLoJ3WZGzxffx2I
 6bojONYOkcbeVL1Mnb9PTdpXPfSOCzZQjopd85jjTE+wRTrumYHf7/q6G4aTIEHIfwJj
 WAtw==
X-Gm-Message-State: APuU4Z87b8oo6qYpRO/vu9rsNpXS/X9rLC471T1k3Aaec1FoRflCuVad
 pFWAJPAUr3rx6UfYsDyyUlGGNvSAHQUlmfQ7hWAXeV8GfyiCY/tMFNafeU0spEzweyL3RydMfrU
 dFN+F0OhHrvqaoVHZLQ6J3X7z+cWoHccrIHoXeC8eMGouZ/HYKFyrPERnTHSL9M5kEw==
X-Gm-Gg: AZFdTZcSXe+1Fjs96ka+LzH02YkPtIQaiqgLixxG1rhlEa+PuUm7yIy2EUM7vA2uZZC
 0yuE1mdMfC5nHjtWai/YePcCiB8b93CBdgVyGonGF37nI3sbJPJF8YMUXG3JzN8/WlbOW3noAix
 GvFt9CMLl+mboRRP+3juUp1ahjhxd/hwTtSOe+2Sr1Lr1MAKKNHqTM+n8KAjn7km6laaGw8IdLe
 VChim29sccdAv+QcIFhabjrBlciC7c2uyX6bdn85q8e0chhkRDOZPCuMYatAglnlZdVyq533BUU
 hjP40wJIVKHH/lFvV0Tud7aXdSvWCUZHPrnLC0aXaKxPn58LQYI4Nhfj1idytwDBpd1o4KQRhAC
 ijRSR9hWtoMwmZ85TiCcGuvDU/gKySqVqcYO8bKMAit/iN9JXcUTiwpW++PQyjjRDf0lrWDjY88
 GGxwbQ8v+AscHf1A==
X-Received: by 2002:a05:620a:4491:b0:939:a0f3:6aef with SMTP id
 af79cd13be357-949ba95e8e4mr4002752185a.23.1795731941532; 
 Thu, 26 Nov 2026 14:25:41 -0800 (PST)
X-Received: by 2002:a05:620a:4491:b0:939:a0f3:6aef with SMTP id
 af79cd13be357-949ba95e8e4mr4002748685a.23.1795731941085; 
 Thu, 26 Nov 2026 14:25:41 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b1ebsm44425705f8f.33.2026.11.26.14.25.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Nov 2026 14:25:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, TANG Tiancheng <lyndra@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 1/3] accel/tcg: Factor icount_running_cpu() out
Date: Thu, 26 Nov 2026 23:25:28 +0100
Message-ID: <20261126222530.62175-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126222530.62175-1-philmd@oss.qualcomm.com>
References: <20261126222530.62175-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA4OCBTYWx0ZWRfX7giv1Qb/arR1
 DRanKCPvARMd5c8y54wT4Apc0ptEjV9FPZLFJjr0eW3S+q65VrNvakzfFkfg01mJNPdDU5MLw/X
 9vrj6cDE8GnI7g4yJnuQI/4OE8Ar2D6szOxw7Hwwz/E+qwTL7FuzvxYzSPiPpvdtdXArvXw/9xO
 9/5bFTfWbvJjnbyvLipLM307t8hNzhwq09BWIZFvka0azvE3NT6UcE9UKbVL2U9TeYN3POH1GXg
 6DTJUUudYitFgzdv1T7ciARctseLXnOtotBAjZC/1Bry6lmuk5VMqIdP4fZMVRQZR2fvThzS6xG
 UPltbwX9R6fSA2pv9kVAR6/D5/JU2ZP2k+n1u+5j8uofcCVkO7kiV8AYy6cIXQAW0J6gLJ/LNV/
 0Zb6z/CB8Y30rN0P5ZnQd0312Q4fL+WzM9z2F+l65QbF93y9+Ujb3JCle2gSr4TANZm/4AmkcCt
 +cGZ3sbX7yzi/J43E8g==
X-Proofpoint-GUID: pp62VSR0zrayPNnhxHTJL_FVmozLnKxj
X-Proofpoint-ORIG-GUID: pp62VSR0zrayPNnhxHTJL_FVmozLnKxj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA4OCBTYWx0ZWRfXwrMuINGqoid2
 i3bi22vI+Y8jJKfePqRl9VFsv0W1UagzwDbNmP7krrJKWZsoU7s1XSKQ2MFp/hJE8Pt6qvVCvTs
 SHUpkHAfGoD0mPOAqitvFNRuZMFtZY8=
X-Authority-Analysis: v=2.4 cv=FuOQbGrq c=1 sm=1 tr=0 ts=6b08b1e6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=f-NT7oDAcE9xrb1U978A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260088
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Extract the running vCPU check from icount_get_raw_locked(),
to reuse it in a following commit.

No functional change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 accel/tcg/icount-common.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
index b1b6c005fe71..a11f2397489b 100644
--- a/accel/tcg/icount-common.c
+++ b/accel/tcg/icount-common.c
@@ -104,15 +104,26 @@ void icount_update(CPUState *cpu)
                          &timers_state.vm_clock_lock);
 }
 
-static int64_t icount_get_raw_locked(void)
+/* Return the running vCPU of this thread, if any, checking it may do I/O */
+static CPUState *icount_running_cpu(void)
 {
     CPUState *cpu = current_cpu;
 
-    if (cpu && cpu->running) {
-        if (!cpu->neg.can_do_io) {
-            error_report("Bad icount read");
-            exit(1);
-        }
+    if (!cpu || !cpu->running) {
+        return NULL;
+    }
+    if (!cpu->neg.can_do_io) {
+        error_report("Bad icount read");
+        exit(1);
+    }
+    return cpu;
+}
+
+static int64_t icount_get_raw_locked(void)
+{
+    CPUState *cpu = icount_running_cpu();
+
+    if (cpu) {
         /* Take into account what has run */
         icount_update_locked(cpu);
     }
-- 
2.55.0


