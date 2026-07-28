Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A38C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZfi-0005Bi-OK; Tue, 28 Jul 2026 00:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfc-00054Y-76
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:44:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfZ-0001eL-8j
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:58 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3bC9K1063060
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gDup/KsI0LJAf0iBzQYFhDAOxBJXh+wxFj2U9fJCszc=; b=YIPsbdaP4vbSKMl/
 vwnvjZ4atqewt2DgW5D9Qv6yXbvl59bNz7h0KrXf5PGmFI8IKvq6sQrQbGC1BkCx
 XJGqZwLtFY/OAFZxVhL9Xp77+txCvpNRUkn3WXqmo1d3RR4a1hj91JmjLpKp3o7t
 WXT7hJUv9P1hap+ug2gA1QoipVsSZvV3eJT5+fgHgxIn9LT15nq+zE+v1gtv6kPL
 LS352He1Cb7ZwQMT6asWpMH+RwFi4vSGtraLJkbedHAL4JpZLtnDNUUmkWXOhtIv
 2AXlqOOyXzIQAbb/r9QAMTxmkIXEJEKwFsTXT113GRZCeKXsp4aZCYhj98zgaKMo
 E38ooA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4v6cguh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:55 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38f5ac7354dso2158322a91.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213835; x=1785818635; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gDup/KsI0LJAf0iBzQYFhDAOxBJXh+wxFj2U9fJCszc=;
 b=EWsZpHDqhrM6hwZ0sNlUEh35PK/QSH+LYx11b3WVN0q2nAMG0GSDQnn0yAJEozvJev
 XdiUuL1K34Jelw9uUviuVSukGx8OaGGuFabrOaHrO/62uHHF5B5mv/E19lZtpFoeGNXy
 8stHesaJAE/cGInoyVVI/kRYsnHGaxj0GhFvuADgF2BuQuM/HivwB9IUEqPlalp+RWSJ
 Oj4N4+0GvxrZCJFp/UYUMjkxvC1kJDgRYYp6R+RBM5DCmnVMZzO6eaUgAt3UiiiX6e+h
 YUVkXVRkKZZcqaMaVllPSGdAv23z4MrnTD2P+g2skj+6HYoSlSS6zw4Vpr38bzjj2mkJ
 afhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213835; x=1785818635;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gDup/KsI0LJAf0iBzQYFhDAOxBJXh+wxFj2U9fJCszc=;
 b=oOphQw1Mo77aRX+eEGWfyv1X2uafm/FhYgBUXXAFIsg1VHyiY8or8UMpKmWNte0sSw
 ZNjTYLz+YnJkR3cCJhf66eGW7nkNCbKStROKo6Jrpx3ZyISCSiJjOOUs9Kgmx516d7KX
 SC9RWr98Fs/MGXItiZ6jf0Kzv1iGgBtB+zkwbFGA0MIx9CySQJcJthCgqpz02zd0BI30
 HZjUH+p25Ghwh4cR9BrvpOkYLNIVGmS3fFjKobq4jmSV4TWRee9EY4O4byhbTPtlXglQ
 SlY2ERZu+1/qd77d6Au2ioiCVIH3i2YBP8DN+XywJFnzKXCHgpP58aETs+90H4kfETUi
 EJzg==
X-Gm-Message-State: AOJu0YxVEUJfkWA3cl17YvExALhR5yEHyx6oUVSL9HQSxbwPUrW8+KK9
 u+LAaVpCU22Nf5OTcNNhD/FTq9zJWdSz9Fr7Fsn9VJ8QH78iR1GKcbYbj4EoeeZeiM59fgC0Ctt
 4g2JaaqxIyTbCgtryefGhopdnPg27SdlE69/7w5cGqNiFo5nqcJbcP5VdQ+CKlKG0Vw==
X-Gm-Gg: AR+sD13fFdh/ly4PSI9+9lLXxrp9jSatq1n8SF0LPhoNacXJDcGzfcFTcI4wqhWOfil
 5N99FlY6ZaaHS9KcGnwXqxXgvM9FDYcxJyerXbYYIglJhM6l4yOob2EK8LjIHxLZE1QcJ+BChFo
 4Mcj4NyO+cbFFfe75kL2RfFTosnJb8ybeDeR+Oux0Jxw0zAN6AhYK7p1JMk2qaTMi9xDgnQh6sX
 1pJaeuTGOk/k4pg2DGJfOVkXXH2szWzzlTd238y8f3Xor43ddXQH8URqPIbSJlgUWliJ1xJ1O3+
 Tz5iIm0hS1sFiJEVEvis8xZtmOZfGNKxDDnscZps+x0sLP8Z1HL9fvgR2fyyESaXjOAw6Y6i3HS
 ZsH0SHK41OoXxWqdVXLQ4i4aP5LWrTjbohAP7WgtddA8l4Sv44zK88rr1+ePqdrVxA6O17WU=
X-Received: by 2002:a17:90b:55c5:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-38f6a1b8aa0mr836207a91.0.1785213835120; 
 Mon, 27 Jul 2026 21:43:55 -0700 (PDT)
X-Received: by 2002:a17:90b:55c5:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-38f6a1b8aa0mr836180a91.0.1785213834669; 
 Mon, 27 Jul 2026 21:43:54 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:54 -0700 (PDT)
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
Subject: [PATCH v6 036/103] tests/tcg/multiarch: declare system tests
Date: Mon, 27 Jul 2026 21:41:40 -0700
Message-ID: <20260728044248.137626-37-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX1YvSJaaJvygT
 enc3g8LspKwSshY24V5slwgLP4X3co3BrPe1zdGTT2hdiF3NkD/SRl0Jy4Y9oa00nNgWLFWSaKJ
 Uf7ApQBMS7Hr0rvvQTgMg2KSpg+Up/Y=
X-Proofpoint-GUID: GU0dDRlezSjydkeFkcIndBlbqDQVz1Dz
X-Authority-Analysis: v=2.4 cv=ev3vCIpX c=1 sm=1 tr=0 ts=6a68338b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=8vYM-gic8w0O4C_0kjEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: GU0dDRlezSjydkeFkcIndBlbqDQVz1Dz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX/KGst4i/HvpA
 UDSoBqSeHLfweWU3yCNnggelpQUOG0FZwIJi6UfHWgCNNpYXhVw7RtGjYLV3u1iDpZt4D13Sn4O
 +S3Z5OOKYLUc8xuXtC7l1W+8EfK/Ss52o/LwpKdd3vF2uyzSbPzA+DriEopLw4fvgVoT6tPmVwS
 z+QQ6TVP31aJ7j/LqUQBQAX/N72xlx919G3rKoCYixeljegeDkRGaDop4dZ2OaGWGgV5NMKiV1a
 w7ZCsPltKNfFAQMzoQyc8Ppo6EIBaze+SjM61JpRPUs9qNDACzZc5tAFmPYW0D71OLYNjlUfJp+
 gwz0/o3moibKo1NSzUgTeBWxGmgy9cwkrnSp4XjLPrjSPsHgBdvE7F/2zPmIEaPCsXKAJqhfCCk
 3b9+5yvYZN36+sx4LRYYRazDTqTZAdvh5a9JpULJt3A0+8baKZIvq0g4WGhNNhk/wWgPWhx6P7e
 ISDd2RgMrCYTTPgqxCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280040
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

We now declare all multiarch system tests.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/meson.build        |  2 +
 tests/tcg/multiarch/system/meson.build | 53 ++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 tests/tcg/multiarch/system/meson.build

diff --git a/tests/tcg/multiarch/meson.build b/tests/tcg/multiarch/meson.build
index 99af41b3fcc..508fdb585b7 100644
--- a/tests/tcg/multiarch/meson.build
+++ b/tests/tcg/multiarch/meson.build
@@ -1,3 +1,5 @@
+subdir('system')
+
 tests = []
 
 float_helpers = files('libs/float_helpers.c')[0]
diff --git a/tests/tcg/multiarch/system/meson.build b/tests/tcg/multiarch/system/meson.build
new file mode 100644
index 00000000000..f71c12db38e
--- /dev/null
+++ b/tests/tcg/multiarch/system/meson.build
@@ -0,0 +1,53 @@
+tests = []
+
+# multiarch src path are written to be included from any other arch folder,
+# so all arch can directly add those tests.
+multiarch = meson.current_source_dir()
+
+tests += {
+  multiarch/'hello.c': {},
+  multiarch/'interrupt.c': {},
+  multiarch/'memory.c': {},
+}
+
+tests += {
+  multiarch/'memory.c': {
+    'gdb_test': ['--test', files('../gdbstub/memory.py')]
+  },
+  multiarch/'interrupt.c': {
+    'gdb_test': ['--test', files('../gdbstub/interrupt.py')]
+  },
+  multiarch/'hello.c': {
+    'test_name': 'untimely-packet',
+    'gdb_test': ['--gdb-args',  '-ex \'set debug remote 1\'',
+                 '--output', '/dev/stdout',
+                 '--stderr', '/dev/stdout'],
+    'wrapper': [prog_run_and_check_forbidden_output,
+                'Packet instead of Ack, ignoring it']
+  }
+}
+
+tests += {
+  multiarch/'memory.c': {
+    'test_name': 'registers',
+    'gdb_test': ['--test', files('../gdbstub/registers.py')]
+  }
+}
+
+tests += {
+  multiarch/'memory.c': {
+    'test_name': 'memory-access',
+    'plugin_test': {
+      'plugin': 'mem',
+      'args': ['region-summary=true'],
+    },
+    'wrapper': [prog_check_plugin_output,
+                find_program('./validate-memory-counts.py')]
+  }
+}
+
+tcg_tests += {
+  'multiarch-softmmu': {
+    'tests': tests
+  }
+}
-- 
2.47.3


