Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F09EC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4lI-00063e-FU; Fri, 10 Jul 2026 02:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4lH-00063E-AG
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:30:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4lF-00074N-Rj
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:30:59 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3oj443854508
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yGWhsikFaac
 UQ2vGjaUHspU/5TGLvGPmiCMHDidbg6U=; b=Cjm8w+zzKN/sKYKr0hMMVe62ytl
 JPpzVTxrypRXK5NJFE2fdLHXfK5oBzneAIUsuoocZGhbhD1eLt2yHJiGH4H3sOoh
 2IkznqCBGcpvKEVBMRg7ANwmhyzwAbdtwZGfs6mTqq4/QkIodiYMG5G1Szo5nF54
 YQiPBUF1NBybPqy0LMFdn3YV0JF20TvCqj/KvbbsKSF5RrVRg7aUjvPXkfvizr2D
 3OqpX5L/Re1vGsRnGVMv9WGOa9aF0XyPV036zSC5EmVrIFdcZ3UBEMVjUoKkmOwG
 TjTWE+0I77JN5DT4BvEzRO9tfVxDD20J7aUDu75O6wA17dv+eLFrAPFRCyA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fas6n0jf6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:30:56 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38127ae6b99so1041729a91.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783665056; x=1784269856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yGWhsikFaacUQ2vGjaUHspU/5TGLvGPmiCMHDidbg6U=;
 b=YMUOCzDyPa2b7xxUEaZFhEyChRWeaxrJ4h641ures3aPQttsAbTIqX3b4bL/uQCoPp
 jZRX8BGKmitK3Zj0poriC0+jF6tU4xounq4cjhPRryddDUV49JiuLp1evQ5KuhzU7k06
 ZwzS0nH1f6yszITQYGg/pDF/94FuTyLauKtzPeM8GiZKRfYrYviob7cxQpe2NGdOOKTm
 VkT94/+SjetHcJKHuVAsPUjsoogXIhgBaZJIcX5BlUVvjv8myHZ21jyZWel7pDVRgaG3
 70lKRYhnn6voLc+J1yTwH8wOcppbGK/6HWd5yZVqfgyer5WbZ3XOACVR2E7avgGVW/7Q
 0HgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783665056; x=1784269856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yGWhsikFaacUQ2vGjaUHspU/5TGLvGPmiCMHDidbg6U=;
 b=MSFKqVbF93IrNb4+gyjpuVS5ledaX/FE4+pwDjJ+Ko5/VPNWy9yNV6Bswj31+rl965
 rZbVejQCFZBIRIsgnfHDJCYZBXqbZ2fsNxdw6S0psfpqVpuKraw/Gqa2Or2X1u5N48TH
 1bRuDTW7xwRhqUbMntDj7fO/zaA2kP7ca229tPpXL5x7p0HWmx3LPJyC/71hX5HH4CIg
 nHDYh7lDzuKgbQ23v/2RAUjX+8t0MZI1gGPHC0+RTa5wgBNDesSilxow2Wa1SN7EMSRN
 OU9+C0ulxq+TpuzQihL6eVKNZDMk5bbhJvmF5KSM0syG18y9PU5XBoCwZpYjDHRqXvY0
 rODA==
X-Gm-Message-State: AOJu0Ywg4BfoBpXzMudkngjJKc+6/y+3MKFow0znRJAGw01FRp6NFQTI
 iymNlt+OY0Zevk6X3/coiCLYK4OT4mCvj2bkRWetJDfx4Aq6d4iBqiupdSWBklwejTGTk6TG2WG
 Eb77/D2J8R0QCNa0XFQS29Lp6W4ArKwpwg5mR0EQbRSCsWcPsx5QhX0vTMnaZFWzbqQ==
X-Gm-Gg: AfdE7cl6wkrx68Ctj6nKPCh9bzDrdlPoQOcjLhX1wNM4oxM+9WYKqQ+/ibbwtfjPrik
 rnh3DW5A3HMG48+cgyjl6QWrqLSx8UrU7fVakMNOHUoPMPEGM+/pCtM7tTEJHFsCkG4FQTHuBVd
 pweeMZ4kjBfv06UfMchzTM22YBs+WC51STNWptYwEJ1toWH27HBI/ceT77rMv7cngYkjnoK6TRO
 VlQC2mReFENrk0OrC9gAQaWRkr+soHO5p+ipe6/L3g4DPJsfNd5mkhInjgW7IkrUnu8TR2h7tT1
 Lo8pziAKXZxl/8QrBRZQYVB9VVkA32rGcC6l0JZKFS/mS2sdzpCxezHrBdJzMPV2SrY2m/xncVY
 oHT1dQA0lWIvIpuTst15jkU/jSzMsZosaCaGk4fiMp4BvCMk35iveEbdZ/s7ph+DY6x+nT2np3F
 Dt30VD7A==
X-Received: by 2002:a17:90b:2401:b0:38d:9eda:fa04 with SMTP id
 98e67ed59e1d1-38d9edafc8emr599535a91.2.1783665055905; 
 Thu, 09 Jul 2026 23:30:55 -0700 (PDT)
X-Received: by 2002:a17:90b:2401:b0:38d:9eda:fa04 with SMTP id
 98e67ed59e1d1-38d9edafc8emr599488a91.2.1783665055244; 
 Thu, 09 Jul 2026 23:30:55 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3120c8e41fcsm6258960eec.15.2026.07.09.23.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:30:54 -0700 (PDT)
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
Subject: [PATCH v4 85/97] tests/tcg/sh4: user tests
Date: Thu,  9 Jul 2026 23:20:03 -0700
Message-ID: <20260710062016.1818125-86-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfX6t4ShAjyXSiP
 Q8eCsxNqnwZtt51mGxmYoP1+gJ+NLrBuw3DJDBia1IniIeV/KyLfJErV5rGY3dn9+Esl+L0uQ6B
 4/ClYnnc9BciNqJgcUfSdg3K1JVx85A=
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a5091a0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=fPVroQZirc9Ac6AjaT0A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: HoVsdGJA1Or6MSxQkR3jOCSIuK9672jz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfX04Lm0iF8AUj4
 sRnCuvRaKJoB9zB5Yya8N1k4YmjlZahninbA+IuQ1h4gLWBJewE9qQPQ5yLNQLD8YyAbVJpYLUI
 eRVsLD6tm5/VnWlTNH4pKnEWTbKH+exYcKfF3az1TKvVWG69zHO34cwODowpwnL0R3E8FAwfVjN
 l25a21l/SzYakzTkZ0i5BG01SDWoTqfKx8z9/msZgKzW0j0gotXmhR8M3UpCv9jHeB5BLcC1HDh
 IkPZSaI3RpFmqsck3cLx3nPg4HASX7aO1/5ULuGYEt0Pql2kldIaLFCj1ZpUDdy7l+NVcDZUbrY
 93XI+DILR0H4E6xIWFpqAzWYBzg74JeSVob0ysA3WLs0HeUpj813tegprGMjzeFa08d9K8lsX+j
 +vlu/B1LV2bXAsBHEdPUix+iDczZ3xkDoFHa1jJGAoP1r44v3qHPwA2z691wm2pyaRKk4ir6dNR
 ygZnAYuLNutde6czXFw==
X-Proofpoint-GUID: HoVsdGJA1Or6MSxQkR3jOCSIuK9672jz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100060
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
 tests/tcg/meson.build     |  1 +
 tests/tcg/sh4/meson.build | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 tests/tcg/sh4/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 2e87af4015c..834c3aeea81 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -150,6 +150,7 @@ subdir('ppc64')
 subdir('ppc64le')
 subdir('riscv64')
 subdir('s390x')
+subdir('sh4')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/sh4/meson.build b/tests/tcg/sh4/meson.build
new file mode 100644
index 00000000000..d73df074497
--- /dev/null
+++ b/tests/tcg/sh4/meson.build
@@ -0,0 +1,25 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'test-addv.c': {},
+  'test-macl.c': {},
+  'test-macw.c': {},
+  'test-subv.c': {},
+}
+
+if 'qemu-sh4' in emulators
+  tcg_tests += {
+    'sh4-linux-user': {
+      'cc': 'sh4-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'sh4',
+      'gdb_arch': 'sh4',
+      'qemu': emulators['qemu-sh4'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


