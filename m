Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36D6C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4gS-0000Up-BJ; Fri, 10 Jul 2026 02:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4gQ-0000OT-GT
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4gP-0005yR-0W
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:58 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nDNt3752752
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EUXYDtLfwP5
 97yNmX68wEnStI1EX6g2Gzo3fZ+5LZNQ=; b=TOxaH92mIDoG5cIOtcB8OUczgE8
 1kr2DgjNEH3PISKKCrX2FdsdRdtdWrJ5kask5t5wIJAI5JMrwHGEAOYgMFKTX0Zs
 Q5L7aZTG1svt9h4+jimYyYFgfE/YGmyw3XFIJ+45s3D6m0liLl3i5MqYx93XEWzg
 TshAKDoAsBa/LDywnmHeZ8SY3fpdPTEqgYbJO0Pd/Fpei6g5P3xmdSpM3n2F1+dW
 I8H8yEnPphoPWmEylo2TinL54WpN/nWwV22OtbvJwCGcXMev6fh3YiSw2IG08W61
 JLoSm9D/1iciF6Nxnq6DU/SmHQWcZVB1vFAI8eXj7HIEwv2GgWwtuxmloYg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvjbaa3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:45 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca6bd8a190cso957143a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664745; x=1784269545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EUXYDtLfwP597yNmX68wEnStI1EX6g2Gzo3fZ+5LZNQ=;
 b=iMVfnWRrT52gNT6gILDSjWy1zwwcZWqS+hMgT2T7wa8MznBb1Ro1YUo7ai/1wF9xwZ
 uVZpA0M7lkvdrLDr2DzXCDtXz9yWjwJl+VJokAqdjowzjT+AW7F3a6hitM3r0kcC2j/F
 vWVxlKZZ37d/3LXVKrJCMuvwDx4uTyNTiA5DO4eLMB7fifkpVXpTqBAwxKQGqaJl4Fr7
 1RxIx6/kjqlb45HPs8cAMPaAvG4zd9IYrZ5kMmSI3fnIwohBesoiG8ogtwyAmReX7W1F
 QYWJvReUJ5Cu93WA7G1INJEpg5ICuyem8jPNzRNAB/MTogSldz2AmvYG7EO7Zm9v1Uw9
 ozGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664745; x=1784269545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EUXYDtLfwP597yNmX68wEnStI1EX6g2Gzo3fZ+5LZNQ=;
 b=Yce4u2EbeyYLkvrZdh2oy7K3uDySiPj3rXbOLWOPN9JFUoB/voYP1ZWtBO0b5uNNpR
 xmxOKO2qGIliN7gfqsyMZ6jCrkjoZ1TtCEyeZob2pR3WXIUiMtcesnT2v/SzCcO1gUWg
 rsnF4GoWceYQU0LP774pGfutS6iVD/qH6eB9cSxKnXBhmX6wLNpMNh3A7GpRpdYh18fu
 kYarkaLobwae0tPrYPnpAVu8ZUW3nt52g1bLz0xgnmdK2ujh6KGKn6iIATEJFnNkpuj2
 Hrv19NqN+F3f5m5Agpj2vDSdjgd8CHQ0MC7w0jLmkPcoYVFxi2OWMEYByG4p0nveeVT9
 VGGg==
X-Gm-Message-State: AOJu0YxF8kHd4Q5+J2yXCvvwczAu8sb/6Ykz2kWQDny1KYM/oqf+Suq6
 sPdctLZMekzYDhTzjQko3jnyJvvxlwk9cXfzXm2X1EDaKZrafD33cMOqeaWM3IZLOT1opxT8b38
 asbtWd+TN1ZjQdgIOO6wLOvY6bbwxZXzW6vKtUefH/gkgMZEUugZizGuLVKtKL4ZXjQ==
X-Gm-Gg: AfdE7ck2VPeCHNKdIGKknOMEh6dsgpC2UjtkwWNViLzsgJtnsC1RFYTEtjj20f3lKme
 ELScOF3b1cQTC0R5rVbJRCOok2Px6EYKfQycl7X4WV9vZOuT0lMadtYzfzUxvlWd9r07tgVKtso
 drzbZeUR/LBPwYvQsitxMvs9nwMBei/pob0SyDM6DYL6expz+PMnCe3gm9Azs+Pe8U81ZwpFUfz
 YJ65FWqsFzuKaG0NU8Vs8KfetfHFINb9BqW0FxGBpU/UiaYdTqlL74W9hL66zpBfupLnoyC/Mzf
 TPkGQJEfvmkM3adeROQzebiKyTJnen9s2k6Dsj19FDbM3kVPLlzbhUu1FYIrD1mho3XyazGKXzo
 SYJA3Of6fP03L8SpLscaC9HJtsbDBHC/z9axYaUJZeB7KdnNPIxIw74p91/BwlFFEMXePG5Iyiu
 Jmnp8Uig==
X-Received: by 2002:a05:6a20:3d0c:b0:3c0:29c6:20c5 with SMTP id
 adf61e73a8af0-3c0bcc2c127mr12776637637.55.1783664744997; 
 Thu, 09 Jul 2026 23:25:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d0c:b0:3c0:29c6:20c5 with SMTP id
 adf61e73a8af0-3c0bcc2c127mr12776616637.55.1783664744505; 
 Thu, 09 Jul 2026 23:25:44 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:25:43 -0700 (PDT)
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
Subject: [PATCH v4 60/97] test/tcg/mips: user tests
Date: Thu,  9 Jul 2026 23:19:38 -0700
Message-ID: <20260710062016.1818125-61-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfXy2IjstHS7/9K
 wNsUavuElsu7g+622fAf3CHOI1RqgoEKzOBDNMa3f2XInkxeyHpv/zfoP3ufvfxVfv+6SEC2999
 8zmy2pfM+rmYxfrj2tDC8h9fkeRByoyRQdKA71DrpYTFFa6X8hfAZbkrFBSVuqdl0i0qT1f5ZZb
 sOTbJqgyys4j7vfR1tomEXmqxpWSZ88y7PNtYCVRhFVMULdDcal4yi9kcWGaQYm5PGzCwFqV1mW
 XUUDV87QaYg12nWl0ZY712O2iU3sIqJ9MlnW/GvA43wFve63qhgtyrpeJ//CR2sAt0Nsk3ZRDeU
 8ag0K3KoxmYKSJFSiJNHuSs27wh+rFxRBGTqXWE9A4mtqX4GyRirGGbUTFXEQX/c+mTKTRhMa2f
 QtILhhsmycDQP0jb3WFGQLSTZKvEbtUsCSoU6d1z3lwF93QdF0vv409W+Pk4HlPMMmw+GDNJx2q
 pO7mGDvbAftSRqU9K6Q==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a50906a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=LRBJV9KmbJrVNcekR2wA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: QwfsUQDk7q58RJsLx7X8Z7LwSrnScwtO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX43haCSjRP4Jd
 +KZBT6YeEUWzDG7KPgW6ydpcRk+WoR/H/OgjztR1E0wLxZFXPbOsC9LOyIlPlod4YybwVoOqx3a
 cFKrR1c6i5nhjtKHdZFpx+F64S7J3vo=
X-Proofpoint-ORIG-GUID: QwfsUQDk7q58RJsLx7X8Z7LwSrnScwtO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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
 tests/tcg/meson.build      |  1 +
 tests/tcg/mips/meson.build | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 tests/tcg/mips/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 3fc2b361f20..40d623b52a4 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -142,6 +142,7 @@ subdir('hppa')
 subdir('i386')
 subdir('loongarch64')
 subdir('m68k')
+subdir('mips')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
new file mode 100644
index 00000000000..3c4f6ec482d
--- /dev/null
+++ b/tests/tcg/mips/meson.build
@@ -0,0 +1,25 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'hello-mips.c': {
+    'cflags': ['-mno-abicalls', '-fno-PIC', '-fno-stack-protector', '-mabi=32',
+               '-nostdlib']
+  }
+}
+
+if 'qemu-mips' in emulators
+  tcg_tests += {
+    'mips-linux-user': {
+      'cc': 'mips-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'mips',
+      'gdb_arch': 'mips',
+      'qemu': emulators['qemu-mips'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


