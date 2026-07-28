Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595E0C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZp3-00071n-Fm; Tue, 28 Jul 2026 00:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZoB-0006Js-Ep
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZo8-0002ZP-Vz
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:50 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3ajoa2693067
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nVMjjJ4OH07
 2Y0/KWO5cHlOcsZLmQVqrGJd+g5ZdUMo=; b=T6gbNgsrPv4z3N7NyUC8XWy7aw4
 Z9f4k96FJHH1WozmLAdmKzWhX97nFfmgk3vuU3hSbDaP2GHJhCWtcPxn10S6C0SI
 +9kjQ7UBbEte2RJlJzBzoHycRBdnqrutr3pQsgKQ7ML1ra0ZaEsN83dPyqRLpfEa
 p7YGNALCkgF03Lb89USx3yJve0nKaIoWgVUq7xEHKX2mTABi3gxkK+s5ThMJg7so
 tT3AiA5Y6jCvTooQ7xy0ZYHMyMrQR5WsO59rk/6C7p0yeFjcBSK/+WHJPqs9CFyI
 nEhBTKw7VSP3zhxTuvUSQyVkpoHApm01sCl0x79wl4jCz9vj/CBg2vGW2mA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbp5jfg8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:47 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ccb687f82eso49997455ad.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214367; x=1785819167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nVMjjJ4OH072Y0/KWO5cHlOcsZLmQVqrGJd+g5ZdUMo=;
 b=awfiwXkTUMzAxPdqHnYkZVK9NYAH6qkDOaIlij06Clu17NBB6S0TQxEU0jkOI7gypW
 pq/62C0f2vlxVZAcBQLRY628C8owms8unpy865KTBNv8VUY6+y0rhtY9It7AYxETbaLS
 FUQH381s1Rs7dIHlu1tPV//yH+wOnqK63a+EWjd3jv7QJW/fc8xM0zDEj7uPoBVLklNd
 U6tFpuxYodwmVdELB3EbnJ9bvam0C2/kMuWENz1kgMCAcai547f+fQobXHBI/OmUPCwr
 2zsuBM/RB+XFLau7QIqL6XX2eOz23NUdQQEuwszzqYbfekNiEAJ5Eehl0cyVOMf/XZ2/
 DXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214367; x=1785819167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nVMjjJ4OH072Y0/KWO5cHlOcsZLmQVqrGJd+g5ZdUMo=;
 b=k5MeFJxuIh5i9TOLsa4UBnPxOFFzYEAntncBMzgZcfKdpMvUGNgodQ4/8OQAl3A2kI
 m+hgnRXR0kBSOVXXqvUT1CIdFUz3wz2GSgJdj+PAcM0bD/Rli5eLcXln+3ZveJ408cR8
 SETHl+y6GccIZsAYRuwUJcwdBENH2ED7Hm0OXj+ki/M4fj7Wfdf496zgTUfuFJCzDPjb
 BnQb7RbsGzBQUrSPdib6oZMNo57/0LbKkkzMGDe4QPqAVit4e8U3tnSiNtbAQzFeqBgb
 7Y5DofHEx4n8DvyQs3JOFCOJ+kFsuEJAHhN1Airj8GcmeetP3KsG//CAyFEbUAN5nxP5
 dZTg==
X-Gm-Message-State: AOJu0Yx8sYgoIHVpzgJLhM4RjymmV1V7CvaHJMXqkGobFhIHlHgCU5cs
 KtKHaqDZ1rrMbxg2O4fMnpmkanLWq7IfSZH5gvCrfQZFxvvb7CIJ+U4a+75q3NJ15Qcbn/Vlg7o
 QnI293PlDIjdXOi/rs9hldg1QI5Z3aj8RDnSJyXieD2Vv5zUJd6SBkNEW7hd0B3+DnA==
X-Gm-Gg: AR+sD11YLl0UP074uuI6qPKo02eJRYOeCWWlXAvBTzyX+q9YkXA03T84pOOQUcwkSM4
 ukwy/HuOhuhbGLWzQIdsYtkrP0TVAW1MZ8JOkRAuWdd3gYSYXeNHyggYrFlM7CTtVs7S2l09Yjq
 JFSorXz5W/NL8r3Dt9XLCbjwxYgInS2TrpA9vvAcf7qP7I53/GPv3yToEkzZKRIKJFYWCqPBXgd
 aKo5lTWdT7fQJo3JNj2ZQMMx0bpl4CB4f7m2+r1l896DUVUFFdVm4Le/4YZvTa7KYVSPwqpGWNA
 X+N9/kAAY+iyCx6zG+vFWbcsb7PbeWuuzNSUU2N8YtcykmhDVlVR+Jfc/xfHHzcK9TqwRq0fvhn
 aMWClhA/aBJ2JG7V31gIak0YKh14N86TwiIfHuY5SnoQSP0Uc2IbzciIKmvPvC5FgB3b4NH0=
X-Received: by 2002:a05:6a20:a127:b0:3c3:b226:f165 with SMTP id
 adf61e73a8af0-3c8ba5ad288mr1190085637.35.1785214366639; 
 Mon, 27 Jul 2026 21:52:46 -0700 (PDT)
X-Received: by 2002:a05:6a20:a127:b0:3c3:b226:f165 with SMTP id
 adf61e73a8af0-3c8ba5ad288mr1190055637.35.1785214366234; 
 Mon, 27 Jul 2026 21:52:46 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38900559eec.3.2026.07.27.21.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:52:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 095/103] tests/tcg/xtensa: xtensaeb system tests
Date: Mon, 27 Jul 2026 21:42:39 -0700
Message-ID: <20260728044248.137626-96-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX2MO2eBgIXoBx
 zSHfcmT7canMp8SwPfA4a55PuvA1WhIgGTzgMluuRBUB2qd6IEvLGji5E7ncPcVTfosExvoasxu
 Iw8MpncF9en1C9yzhFCBXrI6+TP7eEs=
X-Authority-Analysis: v=2.4 cv=XuDK/1F9 c=1 sm=1 tr=0 ts=6a68359f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=Gpx40EtBKFK82MPJ2IoA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX6kA405NiDSHP
 1t3bfj6av+U5pISrEQG9m2kda03LSgpXjC80BJJ6xoQYF2DDVT21V+0mobZ6MWwbNuFoZsoIyFu
 Gn48YFP9NBystqXCWL856Gv/xpgKI1FJlqSCx04xSQElrrKKb+cQcvTxQuFTUeIniOAyha3DCU+
 +h266OyPY2KoX3ZD52pjGX7AfrlR27qMKMfpADkO4Kfz8KVpUZV028EO6tzw8+kg+gSzQnpzuMB
 mgKPMlmHqtUVvCzbTWapDamrc8hImSnCqZjf35Invb6qm/XrkAM4PNmtwj148TqDKU7CgfRtOnp
 gz9b7e9YPH5K7x5yScicP+ulyVo5xM0mvmAtFEsj+H3E1G/LCNZRzBNNozWcFj8u7OSOxvvM2qS
 aFnTk3n4JyTgnIG/0GiExfvCHKbP2jsghMWYNtLdxjly8xVM33/13SiZtDZxBW5ihAfcLtobx/s
 Et9IeM8aQy8vcQePaAQ==
X-Proofpoint-ORIG-GUID: MhbyF79Yg9ekW9wv1oBcWuUjGZi7RY6d
X-Proofpoint-GUID: MhbyF79Yg9ekW9wv1oBcWuUjGZi7RY6d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280042
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

Deactivate test_timer which is flaky with xtensaeb (25% of the time)
 ./build/pyvenv/bin/meson test -C build xtensaeb-softmmu-test_timer --repeat 100 -j 100

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/xtensa/meson.build               | 16 +++++++++++++++-
 tests/tcg/xtensaeb/Makefile.softmmu-target |  5 -----
 2 files changed, 15 insertions(+), 6 deletions(-)
 delete mode 100644 tests/tcg/xtensaeb/Makefile.softmmu-target

diff --git a/tests/tcg/xtensa/meson.build b/tests/tcg/xtensa/meson.build
index 7c3c4f7cd62..680fa02ff5d 100644
--- a/tests/tcg/xtensa/meson.build
+++ b/tests/tcg/xtensa/meson.build
@@ -1,5 +1,5 @@
 tests_per_core = {}
-cores = ['dc232b']
+cores = ['dc232b', 'test_kc705_be']
 
 foreach core: cores
   tests = []
@@ -94,3 +94,17 @@ if 'qemu-system-xtensa' in emulators
     }
   }
 endif
+
+if 'qemu-system-xtensaeb' in emulators
+  tcg_tests += {
+    'xtensaeb-softmmu': {
+      'cc': 'xtensa-test_kc705_be-elf-gcc',
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'xtensa',
+      'gdb_arch': 'xtensaeb',
+      'qemu': emulators['qemu-system-xtensaeb'],
+      'tests': tests_per_core['test_kc705_be'],
+    }
+  }
+endif
diff --git a/tests/tcg/xtensaeb/Makefile.softmmu-target b/tests/tcg/xtensaeb/Makefile.softmmu-target
deleted file mode 100644
index 3df131acea7..00000000000
--- a/tests/tcg/xtensaeb/Makefile.softmmu-target
+++ /dev/null
@@ -1,5 +0,0 @@
-#
-# Xtensa system tests
-#
-
-#include $(SRC_PATH)/tests/tcg/xtensa/Makefile.softmmu-target
-- 
2.47.3


