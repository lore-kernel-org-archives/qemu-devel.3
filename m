Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03379C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 21:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUrP-0005uy-Ay; Sun, 05 Jul 2026 17:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUrO-0005pc-0E
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:58:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUrM-00005b-Dt
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:58:45 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665HiV6h2273382
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 21:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J61D7vmFN/GCddU40nav9DK2OhgRp9ty5MKEmevp7T0=; b=TPYFyW9gGpv8vKwW
 e2LvB2WZv6loFB/AN+maBLwZ9YElLQbFoP0Zce+8PGq0bAHy/uPZ0aEQpqX0xwQ+
 Rk8cB0w9BnhdQUhlxpJBubewlv2VBzz3Q5884E9eGIz9xBQjvi7C8UvNS1LPSnzB
 /GPEu/GO441RJ/rJujd6I7ER21a3f8KJ22wPEliiCC5Am+yuACAlLCLzUut4Vi7y
 AUq3wQqy/jMUJ7HTtj/yX2QC89F7Femija9WJpdNF4iAc+PJUaJVqFrxNTsN3vqL
 6RRZMRKB5JCgri7x4/MZ0jtlWBAhjg1AFTR2hhF3LZcR7oVw+VIcAiti3o+quqCK
 jHcKUw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qhnktws-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 21:58:33 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so240357985a.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 14:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288713; x=1783893513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J61D7vmFN/GCddU40nav9DK2OhgRp9ty5MKEmevp7T0=;
 b=NWYdppV6K37Hnf4SiAu45EIOtbNRyhRNNRogXeYxQ6nuSp+SrKR6LULlYlZRPSbxJL
 HANJErTEAjY7DELZVE0/rOwkfTZ4KGRA8IXYntsTjHBNjEttqdqWLOP9ZezgC05UuDFJ
 3yQuuYH+585quJC9G9F1MfJ3w4FWKo3uLiDKETU/IU6vQQ1Lkz0UL/XuwAi1eD3EA+va
 vHVAB0+CQwN1JeBvZLlv5p+ZKzZ4wQKnibhV+8SD+IwMn0/W+F0+gV4rnvZcVzkX1vQe
 71CTyPAqhWW4ytzM5lmC5FlnsXkuOKBHdOjlcvb1/W+PPKItvJNshxjDDnEpcJAvnER/
 5PYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288713; x=1783893513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J61D7vmFN/GCddU40nav9DK2OhgRp9ty5MKEmevp7T0=;
 b=oz9Rb5gvmt7uwclrH7GC4l8iSbgrBbE0FgupZ2AQnGnU/GfMntOkxYcAXwwYvacNsn
 MJG07mVtBqYs9gQFKCmagusMvqI8GzdT8iqsbLjZf+IDg/BoC4BvT+vStqRcvoFkP9T6
 ZKuIa3gjxM+pOXZdr2pPfOD/d3HRK2LLdOuvJ8dX22/m1Lp6HHkCD2hufadzwZ2ijgzo
 vFRxe2ERfjaGNEjNQIjMlw3BNm+lf/qG4xv6/vGMrU+QYfoADH+W1agsf9nw74dvKyyg
 iTpFdBw6Zqg6kVk1p6Aowe0jbI5xftlakco1NnKJU8WH0rsZeAh7KPhH8gYqxQAbBoUf
 YrLQ==
X-Gm-Message-State: AOJu0Yx46VnBwQq0om24OhIeyXDPiAg7xJKFGp4P76prp/49v+oYXC1f
 T3x41W/vCSRYlgiY+aOZdKc2ggPEssC7eur6yCwR5Bv3fWtYHhbLXNihKHxA/6ATRVijC2W7Qxo
 XdDE+LPCNbg7CF+i/KQqKFIXyYTPm17ZyeZJLMvSyc1mG7n/WlOeF3Y9iczK6Uu/ulA==
X-Gm-Gg: AfdE7cltV73zqd9MB5c2putYkYQUisFW8d3rnzYKcEzTGxCRh5VOhhnSYYfpvcEiSrA
 mEPLfa8D3fF3v58ALZUscx9oPQh6AO+F6NLaHsn1KJBb87wKNsbdwsiasPHWLkVWnQThZ6Tb4SO
 0I6K05uHCPNvbx4tWQ6CxsrnbxuiyzNo3OFcQmmZCfuMNMoKZ1mkRRmDkuA1etAx7/Bd/jBVckv
 EA5byEDG3pPjCALG+GJXR9WR+T9PPTC6XNLFLIZnHrhujB1YGD4+Xd70+NgUZgEJQ1LVyIUwdnO
 BdCZv9T+j+vSeB5Z69yfzSKPUj63htKRAH33J43Rn/E5Cv22TawfQt+cANu5+ZcfCI2EXo2pCbx
 UkFczYOSen06JFWFhI444x8lL1Xsezk67KwLFaJ2JAePQwHGVPPVWhxfKAsr+HmTBAjyj
X-Received: by 2002:a05:620a:19a1:b0:92e:6430:3c79 with SMTP id
 af79cd13be357-92e9a3a4571mr1097554085a.24.1783288712820; 
 Sun, 05 Jul 2026 14:58:32 -0700 (PDT)
X-Received: by 2002:a05:620a:19a1:b0:92e:6430:3c79 with SMTP id
 af79cd13be357-92e9a3a4571mr1097551385a.24.1783288712380; 
 Sun, 05 Jul 2026 14:58:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ad69519c2sm19485857f8f.37.2026.07.05.14.58.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 14:58:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 08/32] accel/whpx: Implement missing
 AccelClass::gdbstub_supported_sstep_flags
Date: Sun,  5 Jul 2026 23:57:04 +0200
Message-ID: <20260705215729.62196-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfX1djRKMUcdEaf
 Cl8cYkDfP9ckjC9YeodjyBCkfm/fxFxRCnt74b6hDkaAtTiyuLKImMv1bYhrf8tcy5YwaSA/Cn8
 ufwihS6sw531lhYP/hoiLtklVgcCTFo=
X-Proofpoint-ORIG-GUID: q3gD8Irzf90SPTT0J667cNYxPaYaGCMw
X-Authority-Analysis: v=2.4 cv=J+yaKgnS c=1 sm=1 tr=0 ts=6a4ad389 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=glojBnVPa3CR4aLdIrwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfXzf2cGoJtQw7c
 by8DElYBSbh72bbm/wUi378f7kikaRvnPDEES/0DQGlIesw5XlLi0XucLJNa8ZBfpzZhcao0apu
 zMWGi5CiHOrBy1Y3kQaJ7ybkZSh6hMJwEK94PGiL6lCuPuNDLFXO4o1EOFkKn1UoAHEQK1gu1hc
 PbNnkm7vaVNqA+Ceuv8aEne/ZEvKyn8LtxXlS68dRQ7VX7ZnRgtfZrGlb1qt2AeVHN51mseVTWB
 k0eO83jwAo/+pMkRod/P4mjgHkez2qStIMr3YNG05QTiX9Tr6ea5FopiuDp+6azu2qC1BJOAvR1
 ND5iMbP9/Y2fhbdBWVsbcjOq0tm7e+MGMnHLP+fO0ME3J5Nt+AjN/q0bBvFiCofe/fySVBshreu
 0dVQjkQgEjKVl+lSw3cqCDtw0SpF+B2+LDt4sU2Yb18RiHzkPG/KW5DSWBT22IDMMyBcNsU5QUV
 CRZ1QEnvWS7RDB3q3vA==
X-Proofpoint-GUID: q3gD8Irzf90SPTT0J667cNYxPaYaGCMw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050237
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


