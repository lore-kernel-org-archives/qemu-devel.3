Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89330CA9EC5
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFJSP-0006Y3-Vg; Fri, 09 Oct 2026 18:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJSH-0006Vt-Bo
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:52:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJSC-0002cg-F4
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:52:42 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699KhWDS2857752
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 22:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Z4Gf+z2Z/xR
 dNBBkQnMdoX+cA6AtKlPh6iaz7kKOB+I=; b=SNXtlJf+LAKsKXLzcVHtqS7SoF3
 PfSVZsK3mgoOOFWYYknDqvIP9Y2NiPf5BjM5cSqFBnrvZAOEfVdUmRs6uwDJQuNi
 NA/WwJdmS+7PQW3Wlkjc+UryC/16SoZ5pMa4DNVFNRlYpvfdXnrOlXzD3XootOg5
 3QdCMrfhsiVxGsOCeL7MFGew3Yfevt8R+BoP1V4wPscjjT3TAyiIoYuR+eOceSaD
 UWuVLs8TdHCSaDRiDneozzwPe+T8MZG8snnCUvVvVihTpbnIml0yuSCuqGG5/9Hg
 mpGb9+XznPZQ9F6erKv+HxIRP80PrEgh2MlDaFrUiWbTcqiZjdrlzbAnagA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t88yfa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 22:52:38 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3517ee4b01cso2269851eec.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 15:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791586358; x=1792191158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z4Gf+z2Z/xRdNBBkQnMdoX+cA6AtKlPh6iaz7kKOB+I=;
 b=LXtv3LMjfW64OQdyA4aJHxJiRYRM4k8Lg+e+tlg49bosxCSUggjsOTj3IY8GAL5Xm1
 ES5XroFj20rIkiOA9lgoqCiKgPJnGJcyyf2y5zgNDSt45MlM3cju4P5m91LScPIqEz0Q
 ZNXgc7CBOXtUWnQ5SgxvLZ5Z7wZueTZT+6UnghriGHPWkAS10CLsB3q9Jhqe8udUB7wM
 W9nl5E4iyiiU++GqIHGoUjDeB2QZPdA7gmBEQbRyT6LwcsURRS7UuoNGvYUJS0u+kvEz
 MCjfIzuNh9at0X8pmW0VzUTBTB4dzMFh6sJKNrOl+ngGofS/p76f06zwHr49Y5k30nP1
 CA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791586358; x=1792191158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z4Gf+z2Z/xRdNBBkQnMdoX+cA6AtKlPh6iaz7kKOB+I=;
 b=mejEhdypcTHmd9OppOKT4b+3sgRlMQ2xPerornOekYCOe+s9mCHQqa1ODxE2yeMnNe
 u/9yJHw8/wm/SdqXQoIlFgaYBEZP2k4mT1+TP04PMgwJg9OSL2ZW3D1kCpUkCA0kfAjX
 IgXYrYc3H17D7TYZuWyvOmx6jxjnJqphVpJ0ukMYFUkOqVZJuyTimHgf9SrKrJztheDF
 l2AXP1YJTFYNUcngLjOVWG6LC92je/DRrpHmr4MVdj9R2GmCw1fULHCCS4sxJL9Wij8c
 lP6aOs3TvynAyTIkimTgXmA9gPY3BDNP7G/DX1Ati8rWwUGo4tr57CJ+lQ89uaEaNxWc
 twBQ==
X-Gm-Message-State: AFq9FYKcKtWTbE/7ngEa6cS6exH92mwK+ciGd+DMs1Dc5ZQmHVCx1kEE
 b5ls6AaGTX6ipsPawby+0w00TVUNQIAbO0mic3w80hmZCJn5M6D4o9duabgC6LRCuydzJLed3OF
 Ec6BVHyLLEi7rxWRvfWyL9hq7SVz/w2TYcV1nxgUBKXnMurhOc5et/nsYcp3uhfq5JQ==
X-Gm-Gg: AYBFou3yu5BD8YyMyNarIdPvTdjwplV/5y5DVvAw9vJTS9YSm7mzaYwS0kTL/u21CUC
 oStZy0u9Kph2wcZybEmT+vy01Nfo5iHuWwbXoG16mozMKRh9SORrQFxxTv+IZ0/QFB0LNGXWRck
 KKN4rAgUlcvPT1ILyhlJhIsGENqeUGTUjmNFJE+ACOndVDptPmmEvHdw51LEhcC9xD7RZsO/5ZO
 xXCvyOa6lHtGk9AKqwIiw58yb8Y+hupmv9M33n9H9bQzS/seZhRmZ/XJ5zx43g9sQiwD17o6i7n
 xD6RAf6ATE70wZOd37o82RJMTC1dYg/qH0kqY0UV6nzukI5x+ucz0YsUJeSLWq/CypgqtQiJk1D
 N9vFCmeUDYDg8D+EaIsiVnWBXOaggeX8+khASZkR3ZGRsxdRXD1kG5e08nywe
X-Received: by 2002:a05:7022:c84:b0:146:5f73:d45b with SMTP id
 a92af1059eb24-16a54fab691mr3749246c88.3.1791586357910; 
 Fri, 09 Oct 2026 15:52:37 -0700 (PDT)
X-Received: by 2002:a05:7022:c84:b0:146:5f73:d45b with SMTP id
 a92af1059eb24-16a54fab691mr3749228c88.3.1791586357382; 
 Fri, 09 Oct 2026 15:52:37 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a5866477sm8443977c88.22.2026.10.09.15.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 15:52:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 05/11] semihosting: declare semihosting cpu ops
Date: Fri,  9 Oct 2026 22:52:20 +0000
Message-ID: <20261009225226.10657-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA5MSBTYWx0ZWRfX8JaZGhOysnT1
 1zt+2NXC7MS/9dhuEcTpO3xyp6CUanfGFL0cfdlqgsHPus4fvB2xVzlM/GsyP2893r/5rFY8C01
 cwabBeiQlYfpsZCxtBn/5v/3FQv4WBY=
X-Proofpoint-ORIG-GUID: EPwpvtT5j-lqHiJmFP-B6EY0Gv6--yd2
X-Authority-Analysis: v=2.4 cv=D9jSufRj c=1 sm=1 tr=0 ts=6ac97036 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=hb2kNex5ifQYlHlUoE8A:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: EPwpvtT5j-lqHiJmFP-B6EY0Gv6--yd2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA5MSBTYWx0ZWRfX2fRAKKfIfDqH
 iGTWOgrfdCtI5YNbsgWYZgC+SvareBSR4sPdT31XXHyG4cS8ibCiLoZiIlG/D7nnqfY2y/hcE11
 Iz3nnhV3iaZ4lbfEODTerDNEms2ThsGezj8Pflb6qq+gsJD11Dkrv4OfSckvCM1TDO9tjVjLyMl
 YhP+fsyBcTNSUOcGItl07c2iSrT9Hs82PMFtlc5cGAaAFdIljR+54vplJNzPdYGrGy+1TfdETnx
 aTMQwhu9zbVof9zmtByp8DpyqiT4MkDWoMjHPeLsivRW/gCt6nHNleg7jhqwBrxVpnUtRFRzV+3
 XqXqxtwCMYN0LkMcfbcIzKGmg8Q817zsciv2/mW6BARmak0N7IsmsP6DVyoZmR+1aeI3IVwQ93Q
 YUy6j7JYIQAKSTvaaXnOli5W2eO5Hd0VuRnWt6b8Eq3sRFrg6La5dvuZxGDkJlKRlMNdgfpiHlu
 udk6VJlhfyYzwAPxP9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610090091
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

This allows a specific target to declare its implementation of
semihosting.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/hw/core/cpu.h             |  6 ++++++
 include/semihosting/common-semi.h | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 8160a301978..8432c66906d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -98,6 +98,9 @@ struct AccelCPUClass;
 /* see sysemu-cpu-ops.h */
 struct SysemuCPUOps;
 
+/* see semihosting/common-semi.h */
+struct SemihostingCPUOps;
+
 /**
  * CPUClass:
  * @class_by_name: Callback to map -cpu command line model name to an
@@ -186,6 +189,9 @@ struct CPUClass {
 #ifdef CONFIG_TCG
     /* when TCG is not available, this pointer is NULL */
     const TCGCPUOps *tcg_ops;
+
+    /* when target does not implement semihosting, this pointer is NULL */
+    const struct SemihostingCPUOps *semi_ops;
 #endif
 
     /*
diff --git a/include/semihosting/common-semi.h b/include/semihosting/common-semi.h
index 1e7699d7bbd..618f60f76e7 100644
--- a/include/semihosting/common-semi.h
+++ b/include/semihosting/common-semi.h
@@ -34,6 +34,23 @@
 #ifndef COMMON_SEMI_H
 #define COMMON_SEMI_H
 
+typedef struct SemihostingCPUOps {
+    /* Return argument @argno */
+    uint64_t (*arg)(CPUState *cs, int argno);
+    /* Set return value for semihosting call */
+    void (*set_ret)(CPUState *cs, uint64_t ret);
+    /* Set an error for a semihosting call */
+    void (*set_err)(CPUState *cs, int err);
+    /* True if the guest is using the 64-bit semihosting ABI */
+    bool (*is_64bit)(CPUState *cs);
+    /* True if SYS_EXIT takes an extended parameter block */
+    bool (*sys_exit_is_extended)(CPUState *cs);
+    /* Return lowest address until which stack can grow */
+    uint64_t (*stack_bottom)(CPUState *cs);
+    /* True if SYS_SYNCCACHE is implemented */
+    bool (*has_synccache)(CPUState *cs);
+} SemihostingCPUOps;
+
 void common_semi_cb(CPUState *cs, uint64_t ret, int err);
 void do_common_semihosting(CPUState *cs);
 uint64_t common_semi_arg(CPUState *cs, int argno);
-- 
2.43.0


