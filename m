Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190D6C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4gK-0000EF-Iq; Fri, 10 Jul 2026 02:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4gJ-00007S-7O
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4gH-0005rC-Kp
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:50 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nSIo3803807
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mJSxmCwMAf0
 YMD0yXl2r4/R5DJdlBUigCCmI8KYccDc=; b=bCF9ZrnsmVJ2H6yhJ8x7p1bMcjS
 +cyftlaFvFr5tfwZG5RqR6WMH7uqI6jcLbQkv7Wct+4JNB4GDZ2BT3fb/ZuHLHt6
 tt5qDlXHdeyCY/oz+jMpY+FZ49dlxMay9PcAQ0vACWjiN68oiQswKnti4YCfn9vT
 g5oPKvwIXrNpwrA0GR/3SyxBvjXPvMlonZpoFQBG7pAfb3iWLxOrl7tqvcoH9VNh
 a4JzFOo6W3w+D+nS2mH1xev+5ep/QtoLqwqE9/IalYoJkxAgOkebvnYeBEkXWNP3
 igfsAyT/ZWqOs8dQBg2cFhR3YL/34J8VzKs2lGVOAiASiVzyHLKjvYtlfVA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf5mtujv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:38 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c88ad1558f4so1278285a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664738; x=1784269538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mJSxmCwMAf0YMD0yXl2r4/R5DJdlBUigCCmI8KYccDc=;
 b=c2rihizw9AXmj2Gd1P355Jp8wLqtyX6G4gtQ2ZunIRlz0MYgfudye8htne5I69kNDR
 yQPFiYyVeosetmh17SvaiT/DHTP7MHvSM2YCx4aIfPQ9ZEMMtWBZC8I8RsLKikXRiqoG
 Rw6NDDKQ6Rw0hTl4k3E+feK5d3QM1qEGhPH+IanSeVAqY3F80Ii9KXKu3i96YeRDHZJr
 gC74jQRC2YUG26ZvnWf7jPm344fd1QQ0g9r059DT0yP0Ir5n5dkjd057LYCAIZuz0tlK
 mEWST4FHCZJdp8hLTPnTGez/jwDWoxgJfo/J44i0aWQWLIGbQkxJ3SPBRoYUW7tLehtD
 ydog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664738; x=1784269538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mJSxmCwMAf0YMD0yXl2r4/R5DJdlBUigCCmI8KYccDc=;
 b=JiVEvXm67OKJJcLQaXl0idzauIuNFz/wNFZ8nancgibSrDsYWQOWFTKSRfuex3AAOO
 /6FYI3UWGGrvVfqdQHZVQVuGqyZIWvsCpmaqS9PXHxY5ZYcwboV/yVv2lVKzG+gkvPSW
 LOl5GbNnr8HYgop3iQRdN94eVPg6vz8Fdsa7u4M8NvKC1jNfZNZQwje4rWwFt2Po1phw
 quQbk8Iyapxzg1YtkNMFYaaxVpVhu2LZl1L2P+cwolatsd55/GACv2uclrDabhJL3QZ/
 nNxFY8HMptZSXSy1A0CaUe8qFlbaVl2HHSB0yQUE0D6Wixu0lPg6aTPrVCL3yYDqApEv
 Djpw==
X-Gm-Message-State: AOJu0YzDMLWyze6P94cZgTk25X4vG+v1u21TdnPpvKuo8C2o55ddVvCw
 iGze6+qVsvX6ULAozO88oSwNF/W3Eprkv64FFnmsRtzEsFP1nPrMyxrT6lRR6B+j+Bijef17Y7T
 M2kY2cvvjDjWDMe8gMb+d/PEVEs0nRdyC+6Ep7HNC3Leb1HE4SKqnYTYDn6FlWLj5sw==
X-Gm-Gg: AfdE7cnNcqtNY+WFo4El2yRyD097pBoR/2IpPhsHQw4JbhVKEv0AwZTDG3sfN3cvDjZ
 v2h8tPLnSTTh0dHMjB8KFqnYMKz0KJiokerKaPAyEujjm64b3kihCtR057TjyWV/l32Rmu4zInK
 tYBZdnz4wnlCcT3gxj4XzDs5/hIBaOviPrppRz27tCIc2j+6tcC0wxmmLjAZM41qY4ekkz5I7Ih
 98HneWM3kLFVlWsr2Vifz8cmrkdNOVLkkfD2o+rD3oCTrpM2E0En/t5VN+ApnXnBpzo+s+Nolhb
 9uqIUhvll/R3REE3TxD+tpBqpWbG7nl2UDqa8GNTauWQfY9tr1vSXFG/UNVFzr3AHmHvbs/413U
 1dqc9U9o4RyrN/0HS/cFzJ6L9oclM1O8wGA7suuNBFKjjPcKi7i3Lbguz41ENhlQyC7V/RCQAmu
 a14kRxUQ==
X-Received: by 2002:a05:6a21:32a2:b0:3b4:b340:411d with SMTP id
 adf61e73a8af0-3c0bccaf83emr14101496637.24.1783664737768; 
 Thu, 09 Jul 2026 23:25:37 -0700 (PDT)
X-Received: by 2002:a05:6a21:32a2:b0:3b4:b340:411d with SMTP id
 adf61e73a8af0-3c0bccaf83emr14101461637.24.1783664737294; 
 Thu, 09 Jul 2026 23:25:37 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:25:36 -0700 (PDT)
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
Subject: [PATCH v4 57/97] tests/tcg/m68k: user tests
Date: Thu,  9 Jul 2026 23:19:35 -0700
Message-ID: <20260710062016.1818125-58-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lx-N8Xcb_RZmS0mkKSlwWiR9FVK9CNxn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX809BVRMeIq5X
 mltLhS6Axpjnb+qZO/aWgbDrjGoxW+0he1+BRsy4AMcSECmqRknW1EfaRKV83ZEW9SpbbwX6j3a
 PfzEnQdKG/1EXVTycafaXS/5J3DoZW8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX+I5pHiTE6nnW
 o3tA9vLF6KtiZeiybpfPRAaY8vxMBmyinGnmrBhz214h+qXoR6xOQ1rY/yJTRAucrpttTkX1PAi
 omF/G9/XG0+YBLJYuT1OZIF24S6KjzZKn4eliuqM49Op1oYSj2MghBR5tTl+McrRdfRP25Gyaro
 3ABGr8J1+yqY1n2H7l6il06NMke7aRnNAm/+biglfXOxsEWRzO+NYTmC4HzqBbfIz+Fg4aDa1CF
 vlaoDUiQhVYjnu5cIWuoSY4sLRseeyC2ECYDcUc7t8UNEQr4RiWLhTnOiStrgqLg6N5V0nvQcfP
 N5wP2TuiJsL+qwnAchelITcjB/CtbRsggRj1I3u50Lg4tfQc1jlxQTVRXFon43om4JmK1g+nkGt
 IAkYJCHo/IAqfs1QDKvM1Eeucn0lP/6l2CfCztH6EJ5qcbX7oTzL87X+M9IlCSg7I+9svd4Naao
 wbgTpSmAe7eEWSr5O7Q==
X-Proofpoint-GUID: lx-N8Xcb_RZmS0mkKSlwWiR9FVK9CNxn
X-Authority-Analysis: v=2.4 cv=N+QZ0W9B c=1 sm=1 tr=0 ts=6a509062 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=nWFgFrBpDVO3lh5CPioA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
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
 tests/tcg/m68k/meson.build | 23 +++++++++++++++++++++++
 tests/tcg/meson.build      |  1 +
 2 files changed, 24 insertions(+)
 create mode 100644 tests/tcg/m68k/meson.build

diff --git a/tests/tcg/m68k/meson.build b/tests/tcg/m68k/meson.build
new file mode 100644
index 00000000000..8ecf450ac68
--- /dev/null
+++ b/tests/tcg/m68k/meson.build
@@ -0,0 +1,23 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'denormal.c': {},
+  'trap.c': {},
+}
+
+if 'qemu-m68k' in emulators
+  tcg_tests += {
+    'm68k-linux-user': {
+      'cc': 'm68k-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'm68k',
+      'gdb_arch': 'm68k',
+      'qemu': emulators['qemu-m68k'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index be85fb39754..3fc2b361f20 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -141,6 +141,7 @@ subdir('hexagon')
 subdir('hppa')
 subdir('i386')
 subdir('loongarch64')
+subdir('m68k')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


