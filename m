Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47AA1C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4ft-0007Zo-6z; Fri, 10 Jul 2026 02:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4fs-0007ZW-Cn
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4fq-0005nw-Ty
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:24 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nCce3752746
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qIslSoZ9zDt
 0jpL7X3xebstyaYAO8fyGZXO58hX0TC8=; b=MfHIWIMdx829f7P8kzIXSuzpbM6
 epB5FbtYnwdZsn0KtPTlAiDSOur5FpMa4ssvNpNviWqPJ0z2w5VzXrGL+hb9UiBZ
 Wsr03duKt0zmXAFC1Pkkbdqr/soG6nSNJKmXPLIpVOOPUM/utU4oZl8hFBMgkg92
 MUm/GkUcU8RHujzGf59Q4sbtCu/Q/i9HwU2EOGWYYm+SL8HibsBypsC1bJmZIhHh
 QoXhPYKRNVKM10ge8oyMMLo5aa267lsrmFaGO0yvpdVlvrY4Tw1ypuZwt2ogu6jX
 uYVqgK3zueVBDKVH7gxoAL9Q04ljiiTl0yVU70baO61o1++Fr3EXBiNX9tw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvjba7j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:22 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c7f385887bso11779835ad.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664721; x=1784269521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qIslSoZ9zDt0jpL7X3xebstyaYAO8fyGZXO58hX0TC8=;
 b=KNAVtbFxEBrlzPrW9PMKMaJLU4iB7F/qaJS/fx/dhaPQFevT4LTMvTrke69VXAMmPq
 rMOc1a09NIAA+FQuV9KfUYNLwgnxZhUBWdEp2EErOKATBUiebt4JRNf4GC65ypXOriwL
 DFpYABDA9iebZ+6M5fK6NULkzolgs6GCQRdZynFPyFmFp70W0Yleh7a/mTpiqWNaC+Ej
 TtyXB/4mOdM4JzZQ39BBqWtU82w8TseOS+BhrJE7kdJhcPVGfc0eo/98CVt5WnBUylPb
 UuHu2Y0IMvwg3SF9fCohw7vHouh3VDyNwaANCXHWWoxROP7vEwWQ702zaTQyTv3V6R8T
 r9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664721; x=1784269521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qIslSoZ9zDt0jpL7X3xebstyaYAO8fyGZXO58hX0TC8=;
 b=YdN5COpwYcZ+fWOdFNX/qdYL/FBohaVWmlG863R64A0n4/CSSHzjYFZAyB9SUVYBP0
 Q8F4Vq2xNYCszUanrEWlmBj7FxwpDqGGeiCUu5k5Iy8KdU3UYjhFpiHtoJXWeW87uz4w
 g3fGY8ZCyyLuHUZxv04CGBV7R04dB0OKDz+HaVqyCLIxgN0OnIjh/pItC40dgumZ05op
 JIiAVTM0EnC0rHw4hZOQ/Y72UgHzmn6/GjF4rquObFj7Kdc8x7qlKh3OHl69rbDkW0Ek
 xTgdkGjLdZCszdX6vZ7X+haDtr0TyZqPU0RnePIN7uKPCG0a8iJE0eaTWWhhIVWzp4Q1
 FyVA==
X-Gm-Message-State: AOJu0Yxgah1JskMVD9zcRXoq/ajuf20q7WfCvRoLxKK+cXaaMXd6SnbU
 cWG1omEfwJakBfvCwmXyLuvgwzORKa1p15SUYhc1/z2s01kpc+OlpvuUxmSd4cEHjUWVcO8ExNB
 4MqaeZPTTgNA4BRKFnRyKPFp2KVI48mbYZ8bRTDoTP3xeXJj1UbGeeHxK3Uo6AEb+LA==
X-Gm-Gg: AfdE7cmfeBFtScGEe/G0Ct2hn4fJguZKqmiy9njU/ZEf0wfcQZh83TedU/4EXqMVcBv
 n4vjwvXWa60oolMZSYjIPYpTbuQQ1d+QIAhZPBGxS/keyMN4qFZ3ijJo1lVbIFUXedQPSk14uKr
 mA57Xvc0WPQF0IBw3LKOI8OUz4tfvE2ZJ6CTeUS4LUQerwEpgOVYt9SFBD+XWPGrB6/mTMRQ9qp
 2fBO7c9Xl6uGgayVFACQn1HT8tTRGuBhd0jEqTBfNFtIOF73bsBOcT1rm/GLlPh/NT76FENtqDf
 Sk15/Ne66dm6KZwthn/Ll2UOrcshCXEH0b8nYNXXvUs2L9dGTMJixCV8Vz5GN4KpjQKG2MOsuo3
 PdtaBc+ORLc9Xu0LB7mNUadweRneKS9qoBhMrM3w2m74tCiOQ/mIysUHflive8JAmCqFfR9jNfq
 KhpLTKqg==
X-Received: by 2002:a05:6a21:1fc3:b0:3bf:97e8:a07d with SMTP id
 adf61e73a8af0-3c0bc902b2emr11902374637.10.1783664721054; 
 Thu, 09 Jul 2026 23:25:21 -0700 (PDT)
X-Received: by 2002:a05:6a21:1fc3:b0:3bf:97e8:a07d with SMTP id
 adf61e73a8af0-3c0bc902b2emr11902344637.10.1783664720594; 
 Thu, 09 Jul 2026 23:25:20 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:25:19 -0700 (PDT)
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
Subject: [PATCH v4 50/97] tests/tcg/hppa: user tests
Date: Thu,  9 Jul 2026 23:19:28 -0700
Message-ID: <20260710062016.1818125-51-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX1ES/ppn9sSi4
 Nw63jD8HN4N7iz5WXlaJiLH2Wm4HuIKWigVwq/bT+pcusbAd+ezc99jsTLVSORUcSD5C2Vrovkq
 rcseQv5aqcTc2Un7zPPZ356QoETMRElRZajW+4xYI1RHzVkTKIb2uJmPSSTvJDB/Qq3MphXmTWO
 46OhpQlENuEdrbJsY1uUPaYhmWzNpO7z9zYH78ttwXLIKsGqQj2QQeWRpIiZZEkHup5huukNfgI
 9ShiDsODxb+EvAcu28TvSnDUuteCZdfnORAQixr+ERtazMwK7XG0IpTJ4Ji+hgPIcYWX3IgaF8O
 UNWTYroWtJvPDgVmchC7pNHlCAmhScDRUOp1HkwXOHZfv5iYGJtASUe9OExXS5tAbrbgiM3gUNX
 Ip0VIlXQ8vc/gLE5rNziNSIFjEXhyghOndNWpYFEKvYi2CJegsq7pVDD27AuLRx35KnpiTG1Shs
 4asMdHw6QaE5NH3tG+g==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a509052 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=4B79coCtw6dFRsRaMeUA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 3quwWY_AXygMwSOo6uyqOk42G9EgWyKI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfXxFqRrQq0r3uu
 QSFs5sdVTjxH3M2uBJIMAFch4nJUqgXk1zImVI0pzxfbG4+pEbgZ0ta8XnWdyQmrJ5TCfoTbMom
 q++G5kttjncyoQWPETqJ6rKmXQyNSWg=
X-Proofpoint-ORIG-GUID: 3quwWY_AXygMwSOo6uyqOk42G9EgWyKI
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
 tests/tcg/hppa/meson.build | 22 ++++++++++++++++++++++
 tests/tcg/meson.build      |  1 +
 2 files changed, 23 insertions(+)
 create mode 100644 tests/tcg/hppa/meson.build

diff --git a/tests/tcg/hppa/meson.build b/tests/tcg/hppa/meson.build
new file mode 100644
index 00000000000..9ca8f29fa93
--- /dev/null
+++ b/tests/tcg/hppa/meson.build
@@ -0,0 +1,22 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'stby.c': {'cflags': ['-pthread']},
+}
+
+if 'qemu-hppa' in emulators
+  tcg_tests += {
+    'hppa-linux-user': {
+      'cc': 'hppa-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'hppa',
+      'gdb_arch': 'hppa',
+      'qemu': emulators['qemu-hppa'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 195e5975e17..cd4c6a981b7 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -138,6 +138,7 @@ subdir('aarch64_be')
 subdir('alpha')
 subdir('arm')
 subdir('hexagon')
+subdir('hppa')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


