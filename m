Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53252C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4gF-000865-2z; Fri, 10 Jul 2026 02:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4g3-0007lB-5q
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4g1-0005qF-Nl
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:34 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3n7493802291
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RGkOv8AOsKq
 6jW8yMtCWFq5REU0cvYJMaX1VfDBxe7Q=; b=A2k8+pbWGMkGzjGRNAZ0KXeygnG
 Erqfa3s9KGKPo/iFzFvsM+XEUHJfcj/j7Qqjp92uBEt0roTFVopEGe4rWdLc1Iqj
 DdUFf9C7RtGCYKpCSdIqbiD4N3jIZMumid/sT95nljnHoqLJz9qsX8nu38ZxgGab
 psUhjR7P5isUY/PRxyMi6nPt8ZF0CxT/WEKtKSsC2bFoayP05JyutXtD40qbGaHP
 tXEnNhbmeuVccFufI4tHwbHFSxcZ5vXNQgclKaIOOPlODEMg+ifTjzt6dk/aFfC5
 i7KEdgbI+DpD17yF29fM/0RCfF4y11A7d5uB4HZb9UviYADO6XEGXCQgHsw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4facqpknqk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:32 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ccbb61893fso13829985ad.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664732; x=1784269532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RGkOv8AOsKq6jW8yMtCWFq5REU0cvYJMaX1VfDBxe7Q=;
 b=TDiCNW3GGTkwXhL4B2LlNFSRAy1iYXxvmvpdK6KTA36tskySd18U/5pDRSyAtpu0qm
 ihKLDjOsJD1miyoWWaTX81YvpB51cajn4whuxiWZ5fSNKxDaVd0577W98+/1SwZcvvmY
 ypZ2z46qpAnK4NDYBBif/aoSe4J6oiGgwtfNigcdHgLGIYdv+lfV0hn5vTFCDeeDBz7m
 XYJHDC1sn4aIt4Xhhw5bCtW/pnNgyCiwzpSnPov9O/MnMGwU+PM738gl1hlpE/cD/T/T
 TfYIrwjRTgMUBhtkTBG+v1FTvDwq/HgEyHxyz9V+gsm5NBUXBhJuvaoWUW3wg0OvbC2S
 8j+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664732; x=1784269532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RGkOv8AOsKq6jW8yMtCWFq5REU0cvYJMaX1VfDBxe7Q=;
 b=aBqjI+9YiKUVYC9608y5ncXwOyr4ZP11LrGDZRArXz4Kla13PPQ+hYWGA62hd/bCto
 ZLgWLLCSUyqx1a+DTBBX3WdV7fCGpXUeyzkyTeQV1C3dKE41tMfQjhXNmcwMJ81B8jD9
 LuOpTPhkO/E5Mcd/ukJg4xBOeVFEDB4yjLVrAlUVuAj3JPNcZN1oBkq+yVnvNJKxl8xG
 TuLQ8kn1SSv2xA1ReJAjfFqr1Zf8Nnjp0kFUUFzTpH0oqmkHfGlCxbL/39PWrSpk+LN7
 vbs/arBjSuSFf8nWiV5yyPQModo37Dw4q2momES7jdALc/7cGEQY/QMnrBX8xm09tJNT
 43GA==
X-Gm-Message-State: AOJu0Yx7to2xCxlrYWncVYIsH7oOMu89rKb4Rju6nYnJLLNozE1NpVnB
 NVBQN5JxvbGgITiRREatXW0Pd5ROsZ7FSBlYOZNGrm14SW+sot93RMtkyP7SOAzCe6d5Z/xzqXM
 O+LzMUSDIyBfa8BmNAJgJYeGyYe9yrNzQQp1M0t8DlUUUFRkLFumO43VCtx/tEhQ8Tw==
X-Gm-Gg: AfdE7ckeG8jzLAdEj34AWMtB1S8XpdQiCjbVNd1QITQFnSijfruZs5ggpauh+9Fh019
 DaAgYxmR162aFVoHUQyMAsSAflWC4GuGHPPT1/+CbnHhHgm8/YQdafULObKMSyS5K7r8fkkX1Rr
 Q37pILEV36s0WPNpQ+3fIDw4X5V7jouTRVo2ZUO/2WD6Lew3heUfmtk6hfYcrPqnsizfeAqQuau
 wh1oFnkN0GELdvSb3pwV6uDnKxXUPITRPZS+RxqktsXR79eqKoNOLDR56z1Wnvp9U3cmGmVyups
 8NcqzZ+eW1NHTHNNP08R4NqDld8VmAV18cpJvgXPMAOF4cG09ZWighl8xxzvh12wr7B4ODUvbAY
 c2wfHxEt8zlyjw7kKq07xNQh38SS15BD8FypqRwdjUqeY0KpAzmLfF1qgqz9welrnNCCJMPSyxS
 JHF+leUw==
X-Received: by 2002:a17:902:d2ca:b0:2ca:ed41:d337 with SMTP id
 d9443c01a7336-2ccea5823bfmr101907415ad.43.1783664731971; 
 Thu, 09 Jul 2026 23:25:31 -0700 (PDT)
X-Received: by 2002:a17:902:d2ca:b0:2ca:ed41:d337 with SMTP id
 d9443c01a7336-2ccea5823bfmr101907055ad.43.1783664731444; 
 Thu, 09 Jul 2026 23:25:31 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:25:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 54/97] tests/tcg/loongarch64: user tests
Date: Thu,  9 Jul 2026 23:19:32 -0700
Message-ID: <20260710062016.1818125-55-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX/AGKZDFRjwYH
 NYhJfwLq8pLlswHeyTgil9xvrUO1DDH5IoAyqsylAAuFvSKfGNSQr1kHCC9fh3InOTZowam8JLo
 8piSxnjrEnX+4pnIGovqgDvJKX+POvDw15pTNGWzaOCVirY4b7C/2SNDjdVvSclv5wILl/MNg5V
 Qw/BauV5FY/kzFqxS2PDVLUWQjjUmMt2/TYZOZFgN3IS/IkDYx00ofRRS2gQgCmIwf320kyV1vr
 fUNY1kvqU/QRWFxSdbx1nJoMtyxELjZnMr2ktnngsX/7N4ntkhIbZTqzibDLla2e2T24wjl7uO1
 B2qIpkeIUHmo60OY33FOOyskXCsPrDaGgSimHICA6XMP48NzER52AqjcJN9W2m6NomXu3qzPXJg
 lcJHq0l4HYLwJQjG4fl5AjdigW4uDZsI9RLEN7NqQBqJxSiONQF1nrZ2ILXkO3xa+5A+oNn7JLh
 dbtojqZKxWU/UVyNcrQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX0GMBX/jEyXSV
 VWYd6rhfnom5xfDlTGnVYVlMwiNYWDYqLzQmimsaEU1UFTqwVEUoqofxWhCBU8Non7URbqN3gR/
 i50NIJihw0fcth3NgzTYcTjfxkfo/VM=
X-Proofpoint-GUID: ZkNut9oOkzqsLTZkf63i-UdKjtN25ndK
X-Proofpoint-ORIG-GUID: ZkNut9oOkzqsLTZkf63i-UdKjtN25ndK
X-Authority-Analysis: v=2.4 cv=GJ441ONK c=1 sm=1 tr=0 ts=6a50905c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=wd7JzEHLXhEMQ8L8wEUA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100059
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/loongarch64/meson.build | 30 ++++++++++++++++++++++++++++++
 tests/tcg/meson.build             |  1 +
 2 files changed, 31 insertions(+)
 create mode 100644 tests/tcg/loongarch64/meson.build

diff --git a/tests/tcg/loongarch64/meson.build b/tests/tcg/loongarch64/meson.build
new file mode 100644
index 00000000000..209179fd96c
--- /dev/null
+++ b/tests/tcg/loongarch64/meson.build
@@ -0,0 +1,30 @@
+cc = 'loongarch64-unknown-linux-gnu-gcc'
+cc_dockerfile = 'debian-loongarch-cross'
+cc_docker_host_arch = ['x86_64']
+
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'test_bit.c': {},
+  'test_fclass.c': {},
+  'test_fcsr.c': {},
+  'test_fpcom.c': {},
+  'test_div.c': {},
+  'test_pcadd.c': {},
+}
+
+if 'qemu-loongarch64' in emulators
+  tcg_tests += {
+    'loongarch64-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'loongarch64',
+      'gdb_arch': 'loongarch64',
+      'qemu': emulators['qemu-loongarch64'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index f0266e461a4..be85fb39754 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -140,6 +140,7 @@ subdir('arm')
 subdir('hexagon')
 subdir('hppa')
 subdir('i386')
+subdir('loongarch64')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


