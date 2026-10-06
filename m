Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F05FCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 03:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEIYk-00053d-4y; Tue, 06 Oct 2026 23:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEFZC-0003a3-J0
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:32:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEFYl-0003yR-DU
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:31:11 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696HelCo1538675
 for <qemu-devel@nongnu.org>; Tue, 6 Oct 2026 18:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jD17LJdVd2X
 3CdnLia9agfv8941rUVRDu8/mH/+YD4Q=; b=KRjwvwLgfyWsNUoODiYqENq5/Z1
 fytpwNBSAL6HzOvuHg1uIZ5Yr75yaNX3MpFxoK/jmDc5FRHU6zOOB6REbdZrMbpR
 nEoQ65ugKFgev9WL+3cHWH0F0B/duzdN/4i0qt+vCkYgMViIIrBu+y7tZ+fkp0gj
 P2Du4wrOAwseleZ+tV6WZVHSOJBYkLAs+HzCEXoDoq5i8FFVXWTFf8QeDCT5vb07
 uL9UIt+uTzQ+HsfjMY1ffN1FdwHKlvEFnL6FqYSi1HgS7dd08SJaakzEryofE1kD
 VFnKZgtdLTa6ShKCjSbgcQn7HVRmheRfo0TmXPWm0uKXCbySi3d4VFnfV9w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h54620muq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 18:26:21 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso6276973eec.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 11:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791311180; x=1791915980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jD17LJdVd2X3CdnLia9agfv8941rUVRDu8/mH/+YD4Q=;
 b=g9X9scWsQLCq6OztEojrp8qgGN6e4FfPPC2SvcdthePXkKtf8d/J4K0srhulrhjt8w
 1fAhu24bqMghu2N51DRrGMPVDRB4PRaD/QxXDoVKv8glBeaNvXJdY/opqGGSKN1D0DgH
 o6G83JJhw8b0Be3QHT2YkSiyUJrlDv7foGryZz7psSvAR2vtYftob/E73/yV1H2L26Ru
 Ft5z0jLoDOlD2ESPuX6vtRByfFFVoWnX4vUfacIR4bNJjMkKDww6sFK3s/Z/IjXHKEmU
 qRoLM+ixbay07K8dg5cht65uFwRbO6XSpQ/FiAARaXKDvwOGKp/VKKx98lRhqh9V95t7
 jAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791311180; x=1791915980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jD17LJdVd2X3CdnLia9agfv8941rUVRDu8/mH/+YD4Q=;
 b=Q7HHtVhB6lWeAgkCHot26Szu2a+R/++Ddf3hxzpIJWRC+NC/r/I+HCouAbazTfknQs
 ygNqV5LdPCOeT+Q/1+a30pVUennOokUWplEnE+LLMqqL/Hu3bC+5u0vxmxrvhhYRKpDG
 i68Kqs8wpIKr2JIdkrOatv5xSZtgEFbWi1M0Gjk8lsIAyxfxVsSd1rZvxVOJOyNY98Qr
 veaZLHezD/KthM5g5pNaIuvFeSJmjheysJ26Di+E7DU6EKsHun8Wnmq/eRDWgqfpBJwa
 Bjo9yUQSCYX56a35Dosm7IQ2TWjikRK6PFtoxZmJ6q1cz7cYsV0PvhzjQntM/8qjdx2O
 J2nQ==
X-Gm-Message-State: AFq9FYJ0bGvSdjDyO3kAkmeZXTjQzI5HhvektNq4A9LzN9Ka8IkYOcqo
 nUGG2XwYRcSzwy2lZzMddHHXxW2csjAYgC8vBrar09yMKbUBaqXHlLhPYLFtkRyv5UVu3PnTxls
 BxV0DQTUgy/W6XOuMr9ZpzdeCgDYoqIjnPPy6iK6lTugtNcjOfm8Q0RNKGfZb9avK7Q==
X-Gm-Gg: AYBFou0Oh9X6FUsNxs87i1ZOpPEIwtQvEVZVIQrKjmWPRJWtmVj9VWsG0Ksx/D64LBc
 hQV0Hln5JAycAxq9nut4xAy3qSKz4JVVmq0L67OyVcFiSV6mpj+FXMimFEIhIPSKlvJU6F2qk5j
 NIENiPRmwV4DC/EGgx0Cn6LID3DffzEDnMDwYDMuXtjghuFqcuiu2gHiEmgESvsdSpdNQssL716
 +rhYrIYcLGM2zM1BOjddxbM2yeBVD1fpxxaQKoR5TpGAlFm0AWgg9aGbdVB8beD44EAMfhlvMom
 6rz3msIUlsXHUP+Igv5sEQCVVbsTwHS1TtRHEPDGk/OKTKsjW4C2DxpgML94qqeRaR+uZKNYleU
 uX4jyeQ2KfrIKEySy3Bb5f15kVm/zzBjNz3PBGggWgJ6u9QfqwR2tvA2AG44k
X-Received: by 2002:a05:7301:f0c:b0:342:39f5:f9c5 with SMTP id
 5a478bee46e88-3514e0a8fd8mr2214744eec.18.1791311180244; 
 Tue, 06 Oct 2026 11:26:20 -0700 (PDT)
X-Received: by 2002:a05:7301:f0c:b0:342:39f5:f9c5 with SMTP id
 5a478bee46e88-3514e0a8fd8mr2214719eec.18.1791311179660; 
 Tue, 06 Oct 2026 11:26:19 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515aff5dd6sm242567eec.26.2026.10.06.11.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 11:26:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/2] meson.build: export TARGET_ARCH_VARIANT in target config
Date: Tue,  6 Oct 2026 18:25:57 +0000
Message-ID: <20261006182558.151956-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006182558.151956-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261006182558.151956-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wEFBA1p0htqMIuZDDssQm92EZavWLpYR
X-Authority-Analysis: v=2.4 cv=ZZiIpcVA c=1 sm=1 tr=0 ts=6ac53d4d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=cG8ItAKBDvZcF1xHM40A:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA3MyBTYWx0ZWRfX0SszFjMfrWoe
 vXNcA0XVjbQFf+piVJ+/OOuPYIEYvyNVcH0NwlsbBxAt06eUzKgDgUX5haJJ2U+a/MkItZKwNAc
 teApay/do+xGmZKjM1MbgyMy5RCwKt0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA3MyBTYWx0ZWRfX+rpW/vlm0uBQ
 KmYLaOqJdWNZDRh89cYpo1HirWhbvWFy0S8Dzx+FT6gVorwdmXa3QK91ByFo2fSNJn8CDX711XC
 04f6sXK3nlWxteK71BJ2ZMaoEK1Jag/rXOcx7/Tw/7nkX2+9olpjgGBBMH8xJ7I+ARs275a/GIg
 g55Z0rjBNDuNRCU4+CLTztn7tT5OVjmeEdmY7NcZb2OWusLOmZwLRq7VsmtLlgsmMDD4sgLX5xC
 MjNtcevFpKkhwapcK0ui2Ie34pS2HANTdECMgAoqGj0FRvPbw3syAZVTn6Zmicnb8r9H+Vw7fjo
 sQQRT7TREcF48rFyvIyuJNMBxsd6PNot+6rOE/Z2c+51WyQxUO83tSVqsQi4Rc/l1QonMluC2kK
 WXpd8Vo5h5EarveDluJO3DcAkK0f01f5hBtPDeEQVNIO7gFFqgWEILkLBPJj+4r7UQQr3p5HWkU
 5xebEBzvP54nNzgAzUQ==
X-Proofpoint-ORIG-GUID: wEFBA1p0htqMIuZDDssQm92EZavWLpYR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060073
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

For now, TARGET_ARCH only contains 32 vs 64 bit arch. The variants,
based on endianness, are accessible through TARGET_NAME. However,
TARGET_NAME is a string, and thus can't be concatenated to generate code
and retrieve matching SYS_EMU_TARGET enum entry.
Thus, export this information in TARGET_ARCH_VARIANT as an unquoted
identifier.

There is one more subtlety, user binaries have extra targets that are
not present in SYS_EMU_TARGET, like armeb.
Thus, for user binaries, simply export TARGET_ARCH.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index cae1591cd28..9bcfe84daba 100644
--- a/meson.build
+++ b/meson.build
@@ -3288,7 +3288,14 @@ default_targets = 'CONFIG_DEFAULT_TARGETS' in config_host
 actual_target_dirs = []
 fdt_required = []
 foreach target : target_dirs
-  config_target = { 'TARGET_NAME': target.split('-')[0] }
+  target_name = target.split('-')[0]
+  config_target = { 'TARGET_NAME': target_name }
+  if target.endswith('linux-user')
+    config_target += { 'TARGET_ARCH_VARIANT': 'TARGET_ARCH' }
+  else
+    config_target += { 'TARGET_ARCH_VARIANT': target_name.to_upper() }
+  endif
+
   if target.endswith('linux-user')
     if host_os != 'linux'
       if default_targets
@@ -3372,7 +3379,7 @@ foreach target : target_dirs
       # do nothing
     elif ignored.contains(k)
       # do nothing
-    elif k == 'TARGET_ARCH'
+    elif k == 'TARGET_ARCH' or k == 'TARGET_ARCH_VARIANT'
       config_target_data.set(k, v.to_upper())
     elif k == 'TARGET_BASE_ARCH'
       # Note that TARGET_BASE_ARCH ends up in config-target.h but it is
-- 
2.43.0


