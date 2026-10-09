Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1F0CA9EBE
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFJ21-0003B2-Hb; Fri, 09 Oct 2026 18:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJ1l-0003A1-Fq
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:25:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJ1j-0000QZ-Nl
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:25:21 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699Khhwr3879858
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 22:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XRX1vDcUC5i
 hJ0l7O1bIRNCFnimdeaGqNn959tAoPdg=; b=jATiU5FCu72REA2VNm6+Z7LCakl
 JgV9U67okP+aQ0hd0J8eTYm+j/F/Yx5myq2dFyu/CFB2YtHlIOedvmX3ICXg0b08
 bU9ipsk7FvDEy7AXJBLYkTFuANMgKiEA4BGPsPNlKfIx3806lq/32+Wva5xVAv4Q
 yDosSDHuapgl18xWZ6lP9ambjRSsQQ+FXNl50qUqeC2926GuE+fE175SZfpNKRMy
 ilyxCuaIU+d5ydakgq5v/6d1RHH7m7gr+n4K3+3n02qqcEdIbQvNV0xwysDavW7J
 HyfAPTSFmzPnOQr4b3mRmapfcvYC3287nzrEFqqsSY4XUThK+AKKnzSHSrA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t80xat-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 22:25:17 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3548cdfd2fbso211868eec.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 15:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791584717; x=1792189517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XRX1vDcUC5ihJ0l7O1bIRNCFnimdeaGqNn959tAoPdg=;
 b=PxMOPa5qD9AkFE7dnuPzS2mo6Zw/1tPMxDeAHUrNugPzyo4F69QoL8zItOVECLwSsC
 Py/dmhlucC/p8WMyABxRhndCKCX8BBVpF6ONQwPlzuX76+K60yvW5a29Qnceo4xDi0kk
 PWcU7PzUMjc6OkgFu7lF7N/4DLSqLV2k6x4DfN3C4pII4LakI2mnS3ClKJ+a7MZuk+FV
 Xp2c83Mfk3QG145wQQL4Nq3jyKQb1uznD4dSwvuGuiw4sohlg4m5q9Zgz2QpWZmlEVRl
 vE/uhyP9Jo18mM3m+o74rkCjsdVkHQzpJ81awayU/BwHNm0QxPDP67Q+fIZ4PKYnR3xa
 xK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791584717; x=1792189517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XRX1vDcUC5ihJ0l7O1bIRNCFnimdeaGqNn959tAoPdg=;
 b=TvuBwJ3TCjVlnKgwWhAJn9axxf8ZYtiGmQ2xW7IBGWronIqIvJRQNzFDeQOW+LDuJM
 gxvEPkX3MXgt82uYPKbZQyx9V19x/NvYI/Qn+Zs/yixz7PCrOF/9fGhPpHiFDVVBRy2a
 Ef8AZBpk5Qe12GS8gles7LV8sbr9QTP/MnVLU+EwkBHrPKCBcjAIznsty0NVceQfptSA
 TD8pbkiFP0wMrvexStSHVMRhPWcTd3Afr2gDKtDytJDdjPXtnz0Rl7lNG/gnwDz+ztd4
 rnijSwsiY0sxcKW1BJjCc9UX/toOABsUb2zpbF1Klj06VJ0erwuYgru/DuRMBLnIJcDi
 6OPA==
X-Gm-Message-State: AFq9FYI/2Mkpp/Rlj3Gz1NvffE3GBuLo9F3RDF1sXVQGYypbzaZAIfgu
 RGEWbBcPpTIiPiTH4SMEiw9pRU5IQ3vAXsDTrKa6rjtiZCPv+BXjFJK9AJhQOHBHtEYBgaHuXPq
 VF5rSjxMqlM7yTc7bdG3LyIrYvinIA4HPUFRYsCJ9DUz3sc0WxlLUHMdyw356LBzPKQ==
X-Gm-Gg: AYBFou2h5AsDfXDHERh6hkrjKhgYpP4+yo/f/WATdDPdHPdFhQsI/qvdJm7t8MgqfOu
 lsd7YxiHQAojVoTwXckXkR7CvJEHLQ9l5dFgyW1Z2wBZsZvUnJ6QW9c18ZWM90S/e0sVzjQKo6z
 MTQn3bzDxU8OxlBwejf5eldA0utAAQdZXf6MZXp8UFkCplFJhRff6NkzTyOysoD3d4J+1TnMy6B
 oDXVISLT2HDJla1z9Cg7h1tlFm+DLsy0WCswpCn8MaJdgghbBhokYPtBWPPnQSJ5ZE7L/VhXjgc
 E16gMsZWKzcrYOdV/k0PvFMKgBaoKERB0tiN7OeXpaknKk1sNPHfOfG0FRSSHUt2JrNnwQIy9jj
 T4EbHnW3C5LNQvCXcq2BePYwqa9GDftuNKXJ8xME/2IQSskSfmftmQeBBXUDw
X-Received: by 2002:a05:7301:905:b0:351:27bb:271f with SMTP id
 5a478bee46e88-3537df5159emr3865042eec.11.1791584717180; 
 Fri, 09 Oct 2026 15:25:17 -0700 (PDT)
X-Received: by 2002:a05:7301:905:b0:351:27bb:271f with SMTP id
 5a478bee46e88-3537df5159emr3865009eec.11.1791584716585; 
 Fri, 09 Oct 2026 15:25:16 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca0e64csm9094339eec.10.2026.10.09.15.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 15:25:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 2/3] target-info: rename target-info-stub.c in target-info-def.c
Date: Fri,  9 Oct 2026 22:24:58 +0000
Message-ID: <20261009222459.32364-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009222459.32364-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261009222459.32364-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA4OSBTYWx0ZWRfX9OpD2Nah3Ggp
 4xO8nW8iLlEjFOsdCw/JPJtXnKwEedVaOzclWK+ka1fYbaizVEBTM8PxiYM/Va8GzbtkKRrkvcf
 GpChGTbwn2meWIo6pTb42/rVBa6vLIg=
X-Authority-Analysis: v=2.4 cv=NPtAaE6g c=1 sm=1 tr=0 ts=6ac969cd cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=mU-pWExia5dVUbmSroYA:9
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: 1vLHDGJhx-iOQgvswX8Qe_pCTabeM5BN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA4OSBTYWx0ZWRfX5D5yLgyuyw7Z
 YX8yjJaba3O3B7uLAb+4e+tJ014Gv/kVTc9hHHKHAEGhf6KEH/xTU2fbpzEElBQKgMUeLc/bMES
 WwCMCRWOBjsf1CepiWNcTTJA97Epmmbnavi7PeOm24SS8epVb/bJ36qwy77qsgo+GM2pZ7UXtae
 mNWOx7H2V7u8N3n86TWIolgAZ2icV+kW/RlPKVv68JIvYFptLPPDFJyYB8PF2NJ896ooayl8Pfa
 wk3pu5+/tVlgVUMOX1nSR/+BbdBcKshpIRD7tZreTCO0IwScT6UpgkEpxlhdx7h3Sg7tw9FfK3e
 nJ1/llZhYuAdyXg3VwPUz8yN0EvmC1KYrHfrznL8T86fQclVm+44Ceep3aXcVrswl2Snz/ihjA5
 VY30+OWw0wd+fXo7/ESE6xPUjOqpyNKqfX55MRvJTEaQQni8J4SZ5RHTSceXbXosEbS8zalFXOt
 RqVxm6aMsDIaBhSBugw==
X-Proofpoint-ORIG-GUID: 1vLHDGJhx-iOQgvswX8Qe_pCTabeM5BN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090089
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Now it's the only file left to define target info, we call it def to
make the intent more clear.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Link: https://lore.kernel.org/qemu-devel/20261007115253.328-3-luoyonggang@gmail.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/hw/core/cpu.h                   | 2 +-
 meson.build                             | 2 +-
 target-info-stub.c => target-info-def.c | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename target-info-stub.c => target-info-def.c (100%)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 328e30045ce..ae66f5e33e3 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -601,7 +601,7 @@ QEMU_BUILD_BUG_ON(offsetof(CPUState, neg) !=
  * Return the CPUArchState associated with the CPU.
  */
 #define cpu_env(cpu) _Generic(cpu, \
-    /* We validate that CPUArchState follows CPUState in target-info-stub.c */ \
+    /* We validate that CPUArchState follows CPUState in target-info-def.c */ \
     CPUState *: \
         (CPUArchState *)((cpu) + 1), \
     const CPUState *: \
diff --git a/meson.build b/meson.build
index 220bc7c02b8..255c887e8e6 100644
--- a/meson.build
+++ b/meson.build
@@ -4352,7 +4352,7 @@ foreach target : target_dirs
     endif
   endif
 
-  arch_srcs += files('target-info-stub.c')
+  arch_srcs += files('target-info-def.c')
 
   if target_base_arch in target_arch
     t = target_arch[target_base_arch].apply(config_target, strict: false)
diff --git a/target-info-stub.c b/target-info-def.c
similarity index 100%
rename from target-info-stub.c
rename to target-info-def.c
-- 
2.43.0


