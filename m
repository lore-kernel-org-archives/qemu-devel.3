Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1DCC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfguw-0005og-9g; Fri, 03 Jul 2026 12:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfguu-0005nc-T2
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:39:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgus-0007wx-9d
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:39:04 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIZex489308
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J61D7vmFN/GCddU40nav9DK2OhgRp9ty5MKEmevp7T0=; b=I6cyRXlLwzbxEvBv
 ONv2WTod0wL5gPOl1RUa8yw2FF9E51Ok9a9UZ/jjA2iO2vFFVD81m3dNSt2BZf5Y
 4wORhI7fmxO6x+WP0ipYyYTTBnnEUpVST+aC3U7H9EUTWM9PoYatYl/oxCJilmnZ
 qMgRrnYFhrmqcSzAFaJa4u37u6f3536mVjyEhJDwOFe8iD607tgcwSi/zBHTPxNF
 G7nrTSNcI1oM7tVFMdqoPAkFjoAc3AeZTfFn6Nc/wSrjfIVZQH/zhvDKxGm4qVEn
 /b4zM20tY/uNlO8OqSqjQmR8tM311FE96O1+7vjx/7LDeKMx/kXulRvplbZ6rFqQ
 yO8PCw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ckj0yqn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:39:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92ac0a54110so82002585a.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096741; x=1783701541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J61D7vmFN/GCddU40nav9DK2OhgRp9ty5MKEmevp7T0=;
 b=dPAiv/5CG4F55mZ59FnMPNOIEjPnuxywBRCSsV1g1E/FJGZ/qIzLMuri1DwpvJeOqO
 yjh+N6S7zTTzUcYD8+tHyJAMY5D5UfrcQUPtBr5159GewhLsQGizF1YKXfbvTQB/0/Kc
 tYMiOI3y/ogXnZwfnck+6hCx6uDYy3CW8SDmnD3npO/Fv+1FlRZQDytUy8snCtrb+a9p
 5evjZ0WTfcK+jgx+ToG8hRmzOGKUFGxC1vzJ/Yb7tV9o2mFUkBF8MBH/9F2cAlZSlt4j
 7Ark1jznaFGTCKNizd2by8F3cMXI1FKgjPi0gcKImPtfF3s8KqfD5AEpJbGUv8AVWpHM
 HRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096741; x=1783701541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J61D7vmFN/GCddU40nav9DK2OhgRp9ty5MKEmevp7T0=;
 b=OvWc/UmrGDC0qraYmyTG8IujyTKB2w3WeC3tJCJqFRGA7DQljWindcW4EDpb6vWnCl
 YKPEOqBAQy02Tc12wegjb1DR0UxAdLFQScrWiObJPRId2Drjf0Yl832Gf3KeuXFITxlS
 9P8RC8ZXwVsQWnbrwegOENtfUJUkFWwnbeTkYAXXJNobimfSLpYUUc8ytWj+HEKpKZj/
 hIjbBaMsXWXuCdKpjpEWASSrezHpx2A+GGfVPHdOCvCn6/hCiv+hev4vpbwawGGTXhuS
 dlvtkLH37s+cRIs1dIiEUspZxEZaCZileYpWNM/EHe7m+d20uLAN0yAlbiHgzkyD2uU3
 tVEg==
X-Gm-Message-State: AOJu0Yy+U8WspCJf16KbUHhbWmk8nu5zJ4qlINw/MGL0VipFpK3JfhS7
 tgiWfbQEdRW0efrh7/KrrdboTcmfx7VyqoSQnw88b9Q8xgUs0qoTYSrqMultJDJIpGLvYK0b/A0
 telFc3tneTZ8uzIqv9k1zIYH79Tc4Yka52f67yoZTcczgg5QCzIhA0BHoy+2rdcfrxA==
X-Gm-Gg: AfdE7cnQePl+rkfDzj9Ln4XZk0kUP1lkjfSxyz/JA4zC83OAWzSAbr07ifzSj5+0zRc
 T8PhDWYpbWARkAFbWVWrioamgegiqfd11jsSGFwBsZp9UOGbtFkggqr+TnUM7QIlWwCI5HwP1og
 xukGOZqdtXhLgrjEsUS/AymKSOsZqwkjiMlJgB14MEGbanGQO31HNUFGcX5TRw7LdCd1VLj5kzL
 XZkJ8SE+aHZUtbwo/7C7tHExK0u0dVkYXQq+EfVAogHnW410XeyEU45Kx2t/0iwF24Ct8Gh7DYM
 LmcPil2Eie95a+wP6vvjAcaleyQgqe3WBGzL4cpJ9+p0AcmA0mkqETiBWxVoJ4FOUCpIXjRO9sg
 fkyYNeXZCCsMlca91i8Q6MoKlXyVRomlnv10GJQnmbDuPP6mZNyQeYjr1UlnFDzvXJ83l
X-Received: by 2002:a05:620a:44c2:b0:915:9a39:1d68 with SMTP id
 af79cd13be357-92e9a35b22dmr27526685a.5.1783096740456; 
 Fri, 03 Jul 2026 09:39:00 -0700 (PDT)
X-Received: by 2002:a05:620a:44c2:b0:915:9a39:1d68 with SMTP id
 af79cd13be357-92e9a35b22dmr27522985a.5.1783096739856; 
 Fri, 03 Jul 2026 09:38:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039bcdasm562551f8f.21.2026.07.03.09.38.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:38:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, alex.bennee@linaro.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 08/33] accel/whpx: Implement missing
 AccelClass::gdbstub_supported_sstep_flags
Date: Fri,  3 Jul 2026 18:37:31 +0200
Message-ID: <20260703163757.55500-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX2xqTN7iY6m9c
 JagdMXTptZ8pIPhlSbnaZwvBz1iot21Yzr+s0qE0B7f7vbh6oingbIVBPlxO/I7O7lhSjZmhvJB
 xOGZAWMITrySUoLw904nhYwBpk7PdxQ=
X-Authority-Analysis: v=2.4 cv=E8v9Y6dl c=1 sm=1 tr=0 ts=6a47e5a5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=glojBnVPa3CR4aLdIrwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: HksTlOpZuUkcOf6iv9JAVj1e_hN0vmj3
X-Proofpoint-GUID: HksTlOpZuUkcOf6iv9JAVj1e_hN0vmj3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX/P1wS69PhK1G
 LDc3w9O8yaspsrtRu4TkwY3Tx5c9aEFDLGsyPiWFiBR2KqPmycbokz7wb1I5OGpOstb6g/3KhTj
 BatMnEJUZyy0K575RooVxFLaRNvkCRP8uptYYZjN36FZeJH5sa1o0I7CH6FDAJAOJm/YQIYLiEW
 UKFz5qjEUkKZ/qSPhrNZJ6EztvsJN5G5o15CtHHZaHS10c06k16MxjVlJTyRCyvYlzGmRxwHj+M
 IwFX1gJ6XxYIWIpiNjBj7V7DUrPzx58Na8RF41TL3P6TaJhOEuB43l9KXec0rEVtFjKjTU8xdIK
 OY9OEr4+6a3RLf8jx0EElxCzSQ85vrknZ6ZnBfuX0p1zF6Lw9k35H98kn/UGLclo2dDHNS/UlCP
 V1ISUzSz5IYLRGwuo/UoBjnHon06oa4tODichQrJp4TbAHdFNMOSH8+XgMKtEdp/iMtUnmqMv3R
 ldjXXyWqNdFwnSZGndg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030164
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Correct gdbstub support requires some gdbstub_supported_sstep_flags.
Apparently missed in commit d7482ffe975 ("whpx: Added support for
breakpoints and stepping"), even with the recent 19b48084f71 ("whpx:
i386: re-enable guest debug support") fixes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/whpx-all.h   | 1 +
 accel/whpx/whpx-common.c    | 1 +
 target/arm/whpx/whpx-all.c  | 5 +++++
 target/i386/whpx/whpx-all.c | 5 +++++
 4 files changed, 12 insertions(+)

diff --git a/include/system/whpx-all.h b/include/system/whpx-all.h
index 4022571ffff..0e2d333e919 100644
--- a/include/system/whpx-all.h
+++ b/include/system/whpx-all.h
@@ -23,6 +23,7 @@ void whpx_arch_destroy_vcpu(CPUState *cpu);
 void whpx_arch_accel_class_init(ObjectClass *oc);
 
 /* called by whpx-accel-ops */
+int whpx_arch_gdbstub_sstep_flags(AccelState *as);
 bool whpx_arch_supports_guest_debug(void);
 
 #endif
diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 247e12db812..e3f93efc61f 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -527,6 +527,7 @@ static void whpx_accel_class_init(ObjectClass *oc, const void *data)
     ac->init_machine = whpx_accel_init;
     ac->pre_resume_vm = whpx_pre_resume_vm;
     ac->allowed = &whpx_allowed;
+    ac->gdbstub_supported_sstep_flags = whpx_arch_gdbstub_sstep_flags;
 
     object_class_property_add(oc, "kernel-irqchip", "on|off|split",
         NULL, whpx_set_kernel_irqchip,
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 3079c6293c8..5208d7e1dfe 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -295,6 +295,11 @@ void whpx_translate_cpu_breakpoints(
     /* Breakpoints aren’t supported on this platform */
 }
 
+int whpx_arch_gdbstub_sstep_flags(AccelState *as)
+{
+    return 0;
+}
+
 bool whpx_arch_supports_guest_debug(void) 
 {
     return false;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index e626acef2f0..f6e1636a4e0 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1853,6 +1853,11 @@ void whpx_apply_breakpoints(
     }
 }
 
+int whpx_arch_gdbstub_sstep_flags(AccelState *as)
+{
+    return SSTEP_ENABLE;
+}
+
 bool whpx_arch_supports_guest_debug(void) 
 {
     return true;
-- 
2.53.0


