Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A36C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4ga-0001AL-V8; Fri, 10 Jul 2026 02:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4gY-00012h-BC
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:26:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4gU-0005zU-FZ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:26:06 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3n63J3661828
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=APlwW2xUpKf
 vpaVFkpGiySgBx50QY7sJiOUwpfRx7PA=; b=GmxSLjMo+rDbVjs0aJOukxfNo1v
 iurJEvS757hX/ATTexY7q65bJQu8+fKnTS0qshw/7T0K8uaPdSgIJbuM5aQrv0lM
 jKRu3Pc9A3pTU2vyn++8/5lKx8icZi4WqYkR+zpWTlmxpekI5JnUDLpbvnd9ovsV
 Kwpwcj2paeAwuJRQx4l7nbildQWW3/Q81f1otY/9i1ZUfdEO15nH7zRgX6NKfG5u
 TiSmFiU5Evcf1eteVdYUUXsCZw/EeYAN18q5zUU7ajP7qAovw9tIM6wNi6s3jF05
 XoVQzaX3LPQuB+DkSyV78sNwYfpGcTjcgBCFn8eHuLS1btIKWxRLVUTuRVQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24twsc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:51 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88aab7c1d4so588235a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664750; x=1784269550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=APlwW2xUpKfvpaVFkpGiySgBx50QY7sJiOUwpfRx7PA=;
 b=jSKYGAaG7UYcCdeWmlE3vvXL714Kv4dt2MYNc0K/phQ98xhexn9Joski2voWun7ufz
 1IziUsMuesoN5vo2ix65N8AJvY43klhAqkeSjdjwOC2bf1/s9v3exWX4T58G3+U43ref
 7aMgmEVVlj9SbbxsngnYSWj+1Orz/rc9S8tErbhVlpOJ8zE0NeInYsx/Z4v5lzwHY3eY
 gt6/0hrpcCh7X3tRlII9pO0i85Ot7Y7JrdY49p1fWQtGsg77TVJBEV6l+6ax+LdEH/Cq
 HyZlAyKYg8YwvaHzN3BCGRTUcuHF+DQj37vw3sDakV6ubM9eDME6sik0UkfVxmStCZrr
 CEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664750; x=1784269550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=APlwW2xUpKfvpaVFkpGiySgBx50QY7sJiOUwpfRx7PA=;
 b=cAVKw1QcD3kd0KvVL2T2N8B4dmg6N4aEepKDgFDl0+TfzBb5w1RvUK9uf6TVo8R1cf
 oLTGt3Pcnn+jJhdliOvJW/AP5jH+qrmROW+wksgc3wQ1tW/wULr329QSpgveynJN/739
 kfxqgZMCvhRyXv0hSIisMFm0uL6KPEXXgqBtA1vcdgQxtSUKPHNl8qjje0yOzfV1Bw/p
 PsGz4JVUyrassDbrw4ekWPnxYL9Seht9xjpilQeSTItlRLdVCMRD2/eIH0MEayUwZFyn
 nmGbNk0aCRUNgLWGRUKAdObydd30dKt2NZogXBBLCzZh/jhFb7UC64aNqkof9afzqmE4
 FxnA==
X-Gm-Message-State: AOJu0Yy4TLU+/nUHCOH5S9mkApQPM9rIKQvT3f2EiVGVBmP/TvjzREzD
 k0r47IH2a4krwkDmYDeH9eMxHAPlK0LT/OvRB2OWWYDd3JJZ09oE3bTGAoKaHkwPUrVvI7qw/My
 aYjibyUvinhy2vkAZe59nOi61X+sl7XR0opf+j5WpCdXSoOvGEYg2YYp9JBVmiFswJg==
X-Gm-Gg: AfdE7cnm0CuxHdN6UOGcgI7AoHvHM9iB3q6EkJR2AyA65DMdn5Hg+Har0YRmazJAffA
 1mCkdw2QS4r/CqSgFaqEpyhe+M5omYtLAyF/zVs4Sl1lwTVet+RV77x/fY0V9EyIWyMqieuAt9u
 6QrxLGznDZ2oUMnNY71yoBIAZ6cR4joNzFyp7N9+wp4yATY941uyU5kmx095X6EfjR2srb72SYp
 PElW8fScDh38zoO2hKGW+5CtdiNyzgU92o/SAjdKgY373eU6MjbSbXCrBl202uM6e2z60/wrzwK
 3oeR3LLwIk/ZS89VkYtPXvOPi94tR1hP+hpZowZ7FNCX6+2qyghnXr5R3iTmvIPIMJYX/I5SnFj
 vtWZl/GVKF9/+QAMmPkDOEHd4kJrpuqccXICnMwW5VcDlfICDOOuNuK0Nfe+ibBYNoldpkZz9dn
 frcV699w==
X-Received: by 2002:a05:6a21:6b01:b0:3bf:baed:c797 with SMTP id
 adf61e73a8af0-3c0bd0fa3d7mr12259407637.49.1783664750456; 
 Thu, 09 Jul 2026 23:25:50 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b01:b0:3bf:baed:c797 with SMTP id
 adf61e73a8af0-3c0bd0fa3d7mr12259382637.49.1783664749996; 
 Thu, 09 Jul 2026 23:25:49 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:25:47 -0700 (PDT)
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
Subject: [PATCH v4 62/97] tests/tcg/mips64: user tests
Date: Thu,  9 Jul 2026 23:19:40 -0700
Message-ID: <20260710062016.1818125-63-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TaMoit1Bi_25k1bu-Mfd2fPl7hEz9Hmu
X-Proofpoint-ORIG-GUID: TaMoit1Bi_25k1bu-Mfd2fPl7hEz9Hmu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX0xW8zitS2Qma
 yjjN6zjaPTF+H5k3qxXT34qcxDm0XloRTqGdTAX3ank1lGRBKObFOHHJYiifF6ATtwB97DswGFk
 lKIwQVDihEBdEXEbH0f2lzRt/+H98ZI=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a50906f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=ycZrvm9wfOqsvS82YRMA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX3bDsyi2o1ae1
 kybJMrw63fRhuKOjfiAHgrJVA2LL914GtOFnIPx88uS6uxaXJdgziCuxELDn1N0XvfzyWVTVhOi
 zDT54cNOqPm/D46wqE0TalJNfBwXJfbzrYxqYDYGh7dI8Dw6Q2FubsJHfwdNsDTuwTUnDcqBYCx
 LG0CoyiZ9zYYLxWFApACzl/+bbBEhnSfV1LLmYSsdIAFbPl5J2M9gqZT9una2gy3SF8b+rE9TZV
 zBzTp4eqlXJMlYdp6gP+LqSvpk0kNPBOspl0n9hv2LM6NYCw5QPUynouGiWVP8gxRezB26dlpzm
 kGVB/y5K+0+LPNAQ2udQVzb9yfkKLsfPWXSzf/9P/6YrkfiIwi6vy6ifqEuXRN0F+UGSHL9KvtM
 5efvIu8ECNRPrIwJsw7w1r6sZWX/ojYVprMQ7PxhQrdaSkHZwP8aw2CyVu9O1wavvqoLPKyue2q
 M5b/wuAwHuBTSgLA00g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100059
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
 tests/tcg/meson.build        |  1 +
 tests/tcg/mips64/meson.build | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 tests/tcg/mips64/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 40d623b52a4..c3dbd8871e9 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -143,6 +143,7 @@ subdir('i386')
 subdir('loongarch64')
 subdir('m68k')
 subdir('mips')
+subdir('mips64')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
new file mode 100644
index 00000000000..69391c23187
--- /dev/null
+++ b/tests/tcg/mips64/meson.build
@@ -0,0 +1,27 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  '../mips/user/isa/octeon/octeon-insns.c': {
+    'qemu_args': ['-cpu', 'Octeon68XX'],
+  },
+}
+
+# export tests for mips64el
+tcg_tests_mips64 = tests
+
+if 'qemu-mips64' in emulators
+  tcg_tests += {
+    'mips64-linux-user': {
+      'cc': 'mips64-linux-gnuabi64-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'mips64',
+      'gdb_arch': 'mips64',
+      'qemu': emulators['qemu-mips64'],
+      'tests': tcg_tests_mips64,
+    }
+  }
+endif
-- 
2.47.3


