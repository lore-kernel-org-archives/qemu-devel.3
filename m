Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95272CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBfK5-0000EX-2n; Tue, 29 Sep 2026 17:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfK2-0000Dy-79
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfK0-0003gG-6r
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:09 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TI3Yjq1724041
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3G6Xwd1BesLt1qWaNsyhly2an2kHQICKuXq2ccMuJio=; b=gIS6jrZj2VKOUqkp
 18iLLZ2MsWpHPYB9J4WTO/b2SDIppKObYHrfgrZyyB2VxiCylN8lw8FYksViGH97
 FRb2T424grVPGn/caOlkFjgGq8cs8bc9W5ytihGyJymJ0J9dBRXMFOg7vjv8q5vS
 ejfWJjvH2uDqNAfZRTiMlM49US97ValUCUhsFbajrTumfuPERnFGXLMC7eIAgv5I
 t7BdGQqWXhwP7KMjvuccstm4C6LVe3ttlE4skEAm6Nrq4YlI4q2LIW2/QTAewhwk
 z5rYHiFsh3fw815kpuQw8L75LvQnmQd2Iv/CFJRM90cxZxqJqpZrMudG2f7nXhDM
 FyVpGg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0j97rrjh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:07 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1383723dfddso3760493c88.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 14:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790717106; x=1791321906; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3G6Xwd1BesLt1qWaNsyhly2an2kHQICKuXq2ccMuJio=;
 b=eTSggkmVsb8HGYiMBoHZlBJHmpIevQGFMT6nm/V1z+lwbuElnyDUMtKki9HGMC6uxL
 alrQdW8fxE8msIEwYkr40kcCpb/lGhVvZha29Ui/S1wjdLHC4Ar25MRFAS/jbqWPYjsC
 hQS1KDb0hUmb+FAsiUPSX63cHbDtyIDYGPRHxEgdIp76177WtjuDhlsWpx4sTRiaYipO
 /o17dKQBFVcDp/yDW8M2D3jCS1PAhZRDE2DTTapI72VtYP9/xKVtzcXTOyBQVIrsqqY3
 JBtykhMQXvLaEa6GwwkZYcvnov8BYbxL5fB3kUUwRWqdtjeF5j/eSxb74P6E+8ZXSC4N
 5nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790717106; x=1791321906;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3G6Xwd1BesLt1qWaNsyhly2an2kHQICKuXq2ccMuJio=;
 b=jXZcRg1qHAw0qX2MHhmRNsdfpMugmfXnkV01fewPj8NCAprA8wSgBAdhr5GydCL799
 dInC2jtUpFAQauYM0PzxBcTy9/kmFXdUi78HkZb5zQYt+6OMOEaP2HlVsLRr5Sw1zSjA
 eZZCJ9lvRKWaqPbk6xyrrTqXDzhodELgZqwWWzjKNL+bRzBuqT4U1fGteXAzLtguOZPt
 YXSKuBob0zsC35tye5DiWey1olg2CcsVsIAHoYUQ5XAEnLCJopqsjLFB0R8fWPK5atnE
 lfceXK5n4k1t2ufYoTx8W+XMaQWUmy3ALtGbNmOVLQf21TFfGoXho5GvQuxCLWms65Ce
 qvYw==
X-Gm-Message-State: AFuF++lAx2FrzwLVnNQ+X/pV48RKnvv82pTQ1P9ImtG6gvpAKhkItr/9
 R2M5ZGMcmFx8Q53IDT7k9Xuyrw8kVw1cOX93PaVTXzt/qTdgFDX4xFdVFpEI8YqPuvzcil+SXTy
 YfDG1jVpUHEqOwEY25yPBCteTQE/h4lXwt1Jdp1YU2Rmn+OUFgTJz+HjmrYvKpsfdIQ==
X-Gm-Gg: AYBFou3lsAwtWaMXZ7+/AlvgLWf5RZau2j5od3+NddVPv8E/GsxmXYLPf2211wjJ36u
 wj9S9DyKFVlseTQcJH9R3KFpNQTnzDl60Y20yd9PKkvuHwhWxXIqrciFQGhkFQP70HfULHjJto+
 mTszvSvl0GXaWQw41K2vzzM8RoTWJS5q21fNBN7hiSoLziG+IS8JkpEsaS0W82pXk2oTpGC3GcM
 tAmc6rEJHU4vNPN7ysPVtDbBnnQJlNLdalGQMMntizTaJn9jr6fM/3NQXyqzltans5kHSS3381t
 53Ly7E0wLhtxCv2xmXMUvsXe+sJnS/5ndw/ap9sonrD2olxR/S2I/sRWhxTSET4QZvxRJC9QMra
 Yh5SiD7TO7gFUZ9Nyk6xT6tf+pVyZPLUCSuYRkfh8OaJh/QgT2GOAPodDPZ4d
X-Received: by 2002:a05:701b:42c3:20b0:143:8860:afa1 with SMTP id
 a92af1059eb24-14c9e486d5bmr565495c88.46.1790717105914; 
 Tue, 29 Sep 2026 14:25:05 -0700 (PDT)
X-Received: by 2002:a05:701b:42c3:20b0:143:8860:afa1 with SMTP id
 a92af1059eb24-14c9e486d5bmr565467c88.46.1790717105316; 
 Tue, 29 Sep 2026 14:25:05 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388d0110sm1415413eec.20.2026.09.29.14.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 14:25:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 08/24] tests/tcg/mips64*/meson.build: remove unused cc_feat
Date: Tue, 29 Sep 2026 21:24:23 +0000
Message-ID: <20260929212439.110454-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4wLxULsUIZB1_Du4IHsxZcWPaQZuv7dd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX+GFlpTF8iZX6
 WO4dDVvtOihZpX0wdDV9tG3KPv3wZDTVgJmxYP1BRNO4oOs2wBteuBjB5fjCWXnqGGe72B+7tsg
 hgsp2LlxpGF12kpbhFUHibg68qSvA1uuJirmwbasDU/NlOLY/uWzcCyBRBbUcLUa9VMPvKP9FF3
 i7H9HykGAOoW0YvZfM+eO86SSUCXPVEJEMFCZd3kgfuXwmaXnDoLV5cBj0Km/chHLVPvEsaFwSU
 aQwTW1i496/UgWRhY7kyp3AeVwKkRKC5BQrUWd2jh8k8zlkGbMw2IoKDFs/s+rW6ayflOq/symh
 T+3JFsDAgIxA3px8DdyIo7WYchW/7/oSssGeNR3M2J3y9YOdfA643sRAjROXF5RvMQoa6JLTVD3
 PrCPWiBK6RgXdt9WtkTA3tyexsHJpDD9ySUJtMy3J44siwJpqGNqmskM6YYiYZjP/qcVvvDiIEf
 4XBJaE9YnWddopt1RVA==
X-Proofpoint-ORIG-GUID: 4wLxULsUIZB1_Du4IHsxZcWPaQZuv7dd
X-Authority-Analysis: v=2.4 cv=BPImP1QG c=1 sm=1 tr=0 ts=6abc2cb3 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=9k7arhYmT5PAGqctRaAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX7yJAnVK8H6pG
 azSroeL19jLE/Hqf9TYAy1LTczoqr7kXKX3rQQsTFsVPkuGVOkmv2H4kS6KGY4cMEqOTtzGhhGW
 kRbeIF6TrtanyUU2D/jtmAzy3a2cqOc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290085
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

mips64 has no cc_feat defined, and it was a wrong copy from a previous
architecture (cc_feat defined for a previous arch was used).

Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips64/meson.build   | 1 -
 tests/tcg/mips64el/meson.build | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index a324a16d671..f08d1182576 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -16,7 +16,6 @@ if 'qemu-mips64' in emulators
     'mips64-linux-user': {
       'cc': 'mips64-linux-gnuabi64-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_feat_cflags': cc_feat_cflags,
       'folder': 'mips64',
       'gdb_arch': 'mips64',
       'qemu': emulators['qemu-mips64'],
diff --git a/tests/tcg/mips64el/meson.build b/tests/tcg/mips64el/meson.build
index 2aafbba750d..d74c7de9b7a 100644
--- a/tests/tcg/mips64el/meson.build
+++ b/tests/tcg/mips64el/meson.build
@@ -3,7 +3,6 @@ if 'qemu-mips64el' in emulators
     'mips64el-linux-user': {
       'cc': 'mips64el-linux-gnuabi64-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_feat_cflags': cc_feat_cflags,
       'folder': 'mips64el',
       'gdb_arch': 'mips64el',
       'qemu': emulators['qemu-mips64el'],
-- 
2.43.0


