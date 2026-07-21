Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB55DC44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm9UN-0003cJ-4G; Tue, 21 Jul 2026 08:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm9U5-0003Gw-OB
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:22:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm9U4-0003wZ-5J
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:22:05 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LART7v1455614
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 12:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Sg+aRlSfL1je4BTZTcRTkOp9Hr5XLA1t0eyNuOYYM9s=; b=Um1G55YFxtOpIwik
 YxKX58AksiBbWDaHidB6DZZwxRbH94d7NiGo57rLHZf3Y/Gd0KXw4yB2lKM5pz8z
 hjKN4qPsj/d9ppLZ9wATGpgWWu8kSfRnHOZsNdTy3tUqQyoiQ74LLVIy86rHaTd+
 UPEuZwa/Ntez7PqWKZ31JOjxwgpkPHlCbmpAXY8d8edmV1BRLWn3DsaSRy2ffP59
 BIf2njiGZ3swIVXF9dyCUr0L6CKd0sAlhLEUyK39GPssGum+lBCNwnHbQiaAJcHC
 pFp2pGcP0JhtVj7esDuQmWR5SkuEjrSUgkS3zBeQhbAo7tv66RAYfn5BT1hISoFs
 vKjxmw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1duj855-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 12:22:00 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso1901171cf.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 05:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784636520; x=1785241320; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Sg+aRlSfL1je4BTZTcRTkOp9Hr5XLA1t0eyNuOYYM9s=;
 b=PG2GF+2S61eQMBd36Er1O9FLV0ZBkQjFRok91ekKpMwni8iXVwuf9MvquROAybaqQ5
 dGjCYSQ/qM3yCakFNHSKAqzD5HP9OgwOShUQsTAco4Ll7F/pDJhlv3a28kvQYz7BRiz9
 ZMrsmuFduQ0A+KWmD5AxuvKH2+p5+TQROcjw+Q4cCNw2KjgS2OLSt1V5dAbvDPj2/oF1
 J7t6/rXwMBqT+S1FCT7ooA1ZVmjfBTYHKl9TjuJVzLJP7EyA/DFMzx5vqkNfeBeX+e6A
 53Ce/B1XAvfQ1RE/C6sbAqpRtArshBmGgtpKWDh3uDLnlpS+s+vQqaU2Q4BpRyys112O
 2oNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784636520; x=1785241320;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Sg+aRlSfL1je4BTZTcRTkOp9Hr5XLA1t0eyNuOYYM9s=;
 b=H1kAk0bohE/4wZlJD8v5QzOkTjf6rxStZ+/cygJAfBpbmnaqt61WK1LY53o2rm2JG6
 bpvFC4TE4G+YYkTO5+1p9LuEIoY/6Jp6E2D3zpjSeXPpOjoPtdWmTcyqQLjiBGtHh1L8
 7psISZRU92YtG1AydDW7a4pc4ddXj+6bco2cvrh06DDowEw3KiBnNVk6vWtlC9dbCEBa
 jlFqT+Ijl9vski5gmAwnM2cbvnDMTEoxDizaRI4bOCoORqrhcTKSmL30O6Z96FBtUaTl
 WZMC6003aLEm3gCWrkWfVA74te79Ul1UU2nlqrHDNYFgsRDMjFOJIjXcGN+s6nBMsDLk
 KtvA==
X-Gm-Message-State: AOJu0Yyxrc8cETOULGkLx9+M3CJneMPRMHhUgdVlwcvOPrF/vNcV56Ek
 cfLW9I1imWAYdMohyXkB0muiZ+djd3dw44Gfnig8d73FX5ds2S7Kao0vkdAdfuP5uk8ukebD2NU
 yAtH1rT2o4wkzild/CGb4RdV0e6+RlS4T9WfHIVdLDTfRtz8R1tDxMs8JgzxfjfXvXw==
X-Gm-Gg: AfdE7cn2du7k6udTqGMdCKuCnQWW2nfOP6ZdZozVhqDlyDd8EVQ+12OSEONIzedo5UZ
 Fy84IuSo0BRqF4J6ap1EVyv5vkkJSeGlMLBknxqz8DG/m7GNU/DT3IhPoJCWZuFb9m8PugPEXJ+
 TpRp6mmKtc8qts2mNNRAA2LxBQL//ZgSMLUGLDYTRqO9KIabKiuG0+UG17t6fs57rEf0jFfumWi
 tLYQGpeowcy0/FQ7ZOc4ClajThASmFh+Fqw7+i7xn+iZDvCT9wWnkw0QfDon5eZSiSf/I55ASeC
 0F4N2Y6LKiOLHZze8QtpzOF65mSD3jeIutJuRSj5JtmJ5AQFOxq6P7ytqygYSYCNINMBfNgawAY
 XfjJndEMwqnZxNU4JJIeP2rvyM/zueYF8+kY/Hj9Vq0crRoZYenklstokjg==
X-Received: by 2002:a05:622a:2b07:b0:51c:7b12:5fe6 with SMTP id
 d75a77b69052e-5213f378922mr180367251cf.82.1784636519991; 
 Tue, 21 Jul 2026 05:21:59 -0700 (PDT)
X-Received: by 2002:a05:622a:2b07:b0:51c:7b12:5fe6 with SMTP id
 d75a77b69052e-5213f378922mr180366871cf.82.1784636519457; 
 Tue, 21 Jul 2026 05:21:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49548e0fcdbsm309001545e9.2.2026.07.21.05.21.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jul 2026 05:21:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 3/4] target/arm: Only compile gicv5-cpuif.c when GICv5 is
 selected
Date: Tue, 21 Jul 2026 14:21:33 +0200
Message-ID: <20260721122135.6288-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721122135.6288-1-philmd@oss.qualcomm.com>
References: <20260721122135.6288-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: I0_36NrA4adraf_nRG9L0j3A1Ivwq_D3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEzMSBTYWx0ZWRfX4OsOV6xpOYxT
 1VKG28d/QjdEzszG7B97j1E+N0xc/kefCmqfSeOoFrVdAeYXE+acU0mqpeBW4AMP+jUI1qJbfIe
 7fpKuNjMgQtWrmzi/56RluV4XbqsvA1wGp7KoTYwNZMHM6FufrHCW4H/+tmzlWoHY5xBkuApUlu
 DFauoTTPGNki3QUorDa286IvHfLJJkWLpVWMeWzPL5AHH5A+FpYK793St+DLd8Nsq99VqeJkLuH
 +P+SW4glMv7gvdJcaI8dW86+LawqUz9+O67p/WZ512WTpWM+XRJL23umafqwwINXsut939hLPHE
 0SFeitJr+a2OB/ZQeGN0KxWJXol/YeREGApqjH4daArjyg36qlu+AsPh0XKyNIsObr580lOMsHb
 iefo82pFuycw3FPRY5GMSfGH96pHUtk3o6TuvDNvPIJ4BiZvpvwNwnvrkRzUqZ6a4zJ58jz9FCP
 NVppVwaNFn4L5UgKUbw==
X-Authority-Analysis: v=2.4 cv=I9JVgtgg c=1 sm=1 tr=0 ts=6a5f6468 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=EH4q0pLv-eCGfy9bPtsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: I0_36NrA4adraf_nRG9L0j3A1Ivwq_D3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEzMSBTYWx0ZWRfX02NCleBmJXAV
 v15d4vLpYSuCFGSlfz4D4hBq8ZRvpF+/JShgulfADirZgXOma/1gkGM6BAt/wMCMdQmU8vTCPeg
 kfzlPZsr3wS26Fy1yzpWHxaQK0eBi4Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210131
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

Only compile gicv5-cpuif.c when ARM_GICV5 is Kconfig-selected,
otherwise we get when building with --without-default-devices:

  Undefined symbols for architecture arm64:
    "_gicv5_activate", referenced from:
        _gicr_cdia_read in target_arm_tcg_gicv5-cpuif.c.o
    "_gicv5_deactivate", referenced from:
        _gic_cddi_write in target_arm_tcg_gicv5-cpuif.c.o
    "_gicv5_get_hppi", referenced from:
        _gic_hppi in target_arm_tcg_gicv5-cpuif.c.o
    "_gicv5_request_config", referenced from:
        _gic_cdrcfg_write in target_arm_tcg_gicv5-cpuif.c.o
    "_gicv5_set_enabled", referenced from:
        _gic_cddis_write in target_arm_tcg_gicv5-cpuif.c.o
        _gic_cden_write in target_arm_tcg_gicv5-cpuif.c.o
    "_gicv5_set_handling", referenced from:
        _gic_cdhm_write in target_arm_tcg_gicv5-cpuif.c.o
    "_gicv5_set_pending", referenced from:
        _gic_cdpend_write in target_arm_tcg_gicv5-cpuif.c.o
    "_gicv5_set_priority", referenced from:
        _gic_cdpri_write in target_arm_tcg_gicv5-cpuif.c.o
    "_gicv5_set_target", referenced from:
        _gic_cdaff_write in target_arm_tcg_gicv5-cpuif.c.o

Fixes: ee0f1ce00db ("target/arm: GICv5 cpuif: Initial skeleton and GSB barrier insns")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/tcg/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 573e8b5af48..1cd98c1b857 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -83,11 +83,13 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
 arm_common_system_ss.add(files(
   'cpregs-at.c',
   'cpu32-system.c',
-  'gicv5-cpuif.c',
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
 ))
+arm_common_system_ss.add(when: 'CONFIG_ARM_GICV5', if_true: files(
+  'gicv5-cpuif.c',
+))
 arm_user_ss.add(files(
   'tlb_helper.c',
 ))
-- 
2.53.0


