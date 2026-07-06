Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63097C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrxj-0001ja-3v; Mon, 06 Jul 2026 18:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxh-0001U8-1C
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxb-0006ua-J2
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:48 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEFKJ1639584
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zYUOPeitLQ4
 odplrYsDnz8n2C7LrC9dud0kF1O4ZtFI=; b=pmryx1nN8Y8Jzbkfj3CtekC/k/5
 1KeTkGOiJUX7PF2kEp8JSQdBr2wh97bFKVVHRDUf50J3qBIT7p/dWYwv0Y4eg4g0
 SCxJrwqvIb6Vkuf/GV2lfoXNBBrqtdvyQDUJ8RmptXubjIrRWSBHaTAOw3imXKKe
 YHPVg+ebH4UX72JF5YEqfWRZGjbTWdSpGXPcUMn8ISEdqCeU0vrq+oF5MIC9fwd0
 xV63IY4gVJW1qv30vOHRBtD4rjVh1dg13jQ07uHpX/yHXBbcbT/4ZfcZIXzBZREY
 vmm8SEZEf5OCAi+92dWWiSkt2bArSjL3r6Cf6XJgTToYbEB182CFKasHOoA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r359g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:38:42 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c88cfe287e1so2649160a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377522; x=1783982322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zYUOPeitLQ4odplrYsDnz8n2C7LrC9dud0kF1O4ZtFI=;
 b=SaZT0VkZrPrda8RZs4h9N4UL9u3DZQAZHDuMUNiBjnh7yboOgyVZK16VeNI5AgrDL7
 7lcQh2om2wdMnxwMz4C3XhpaMmZYzyKpa5iLpVMYZBlVucEszv3Y8V4j0gJQI5I5cauF
 o/975h/ee6Unt8/TPbeOhF5Hm3RSlIK0tpa98jFlJMnk2i0liNtPJxvliO3TYtYRDXtN
 BiyBdq/iTdtAA7aFmC+6UyNyWngwlSv1nfRjGJUlFDAHbIQ0paT0Ofocn0Tl4Y4bDg3I
 Ry3S7dlHFh24rtgGTEgXcXFOpWBAuYfcfKKdYq6ETv/yDVDShFtBXZoipGgsdm20Izk7
 1F7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377522; x=1783982322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zYUOPeitLQ4odplrYsDnz8n2C7LrC9dud0kF1O4ZtFI=;
 b=nEgvv/OCswmk7JWQ7mPDGYQWdo1Q5/ZmWenjtXWXzCKZrOvuoeHa/oW5u6ZMm0mUq/
 0OVKR3QxqXjf8O26ndErUW9ndNPHDuEBEfSLIoT3NH4lnpgeq70AdCn41uMPEkW5hT9C
 5X8Uqyh/zFLh3vJqeoCV7SIrnnkk4ND8gCIyFs68/du3Wf1rMI3YeUpSPDUVq8/6lDJ+
 uw2mhwRsDYIuNgyPVcnpsSAkXovODrWX7F6QZHZ+zjP3/Ejv4PNLrClD5MoZWvOgW8Vt
 RrrPgE93i3j200SaFus3PvvbQ2mpdTAGzOjMlaHxWSCzA4c+iRW6+cuC+ivCu7n6gP7B
 JxRA==
X-Gm-Message-State: AOJu0YxmlD3uughTf9mHvwAvGAGf0KLioQKqZuwmrlyaI+RGVNkZbnER
 tA8iRc3J9xigBWGXwoaGUNyIYNksLkod9CsmXUmkO4YulDrzmDiO6sBGm2lU22exUVRF7he2AxK
 CL2V/500iREFr88llky4fJu0FzZw2vbhKKszgXf5ERZNVQS4MYzVKjQe1ykka2GkeIQ==
X-Gm-Gg: AfdE7cnZxhqnGSQ+bIqLNuQc7kGU4IXzZQGj02mkRdzbXLK6Rv5p52wStwouaK0ojkL
 gmdomphY+6JAtcQKS32bv1s52G+AAGmjooW3gUR4qItRNJ8YY+R4N95rcP3krrpl/AsqJBc6YmE
 alLz1Rse4JrOTXnTvAkoT4Jh0wEaArOacDBmBFqlSPzs2gTNgPNelQ1M7xl8fEDQPyrxtpVbcP0
 U7E9+i0AA6UrE19vABAqB5J14Fp92VFb5L9/fVkC84PWXp7SzmxFEuiuLpw7zMh992VM2xy/TY3
 x3hLNdxKgte/feVXehAXW5Fv0ieJIchm8bWGp8YniJJiuVTxPih4OuaQMEzXvRnXzxjr6NNzAuR
 gUXDe2Lhhs5+BMNH6OtMWMF+nIT2Z3vbUpmOQo6YoOhSvJ4LLfHbZR+qhiWKz3d3ko/fnUYiafp
 T65kgdcQ==
X-Received: by 2002:a05:6a20:a11d:b0:3b4:b24e:27b4 with SMTP id
 adf61e73a8af0-3c08ece00e5mr2741276637.1.1783377521559; 
 Mon, 06 Jul 2026 15:38:41 -0700 (PDT)
X-Received: by 2002:a05:6a20:a11d:b0:3b4:b24e:27b4 with SMTP id
 adf61e73a8af0-3c08ece00e5mr2741250637.1.1783377521128; 
 Mon, 06 Jul 2026 15:38:41 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:38:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 59/91] tests/tcg/mips64: user tests
Date: Mon,  6 Jul 2026 15:33:11 -0700
Message-ID: <20260706223343.988769-60-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfXxssf0iI8taFu
 ku25cius7V1+Rw4/KMW8KCxMWohs0bt8Ifuly5GV2mEMlHAX/QilPDmzSaBwon6/HCWRp7yZw1k
 efnIcCrPqQopmaSQiSRdEHhWSt5xNBMxHsfXxQ8KcS9j+5u6DR6HwjLh/TYOs1r05BETkJyArsX
 x/mxEN8lD/4QlmKOW/BOEk6tcWRdO6JfV877sVo2VtPeeGJPjcoWZ9DN1ipFIvFvWxJqd/Uj6gv
 f1LHq4pTp6VAv6zQJgC86ROqRYnQu7geMtdrcXMD4QVyzm069dDPdDBDzOugg1TuO+gGz3/tfp9
 peKKveDhgEjZiOobw43dL2VdjlxLurnFLCD4HQ5uhIgfEfRD/XKlONneVHyBZ/9SRSOGNROHz2/
 AMYMu1X4OHZCXOcAmI3smmeeVxZwyV5mddHxX5w6vM0F87KyrYkaWRy95FcfiZgejWSAAfuxm/A
 8GUPKm7qqroYJn5zQEg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX3dloe9P3VPmB
 GDCBvBXbFwNRkWw6kSNVLYTndniGzA1+dfm9a/GB5ehWta5VNg8iF9Es2oI01ZHe/x7S/J1E4Bz
 7wSWQ3B5wvwo9i3k3DOYdF9MBArZWBY=
X-Proofpoint-GUID: BKWW_TS9ylzIhdAp7vNq4CGJ99c-GjpS
X-Proofpoint-ORIG-GUID: BKWW_TS9ylzIhdAp7vNq4CGJ99c-GjpS
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4c2e72 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=HxDNkk9aEjkqqJLdU7AA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060228
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
index 72ad2690f93..2f4bb4b579b 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -144,6 +144,7 @@ subdir('i386')
 subdir('loongarch64')
 subdir('m68k')
 subdir('mips')
+subdir('mips64')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
new file mode 100644
index 00000000000..8b48c2ecd21
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
+      'cc_docker_arch': ['aarch64', 'x86_64'],
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


