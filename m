Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFD6C5DF88
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPQC-0008Bw-Hn; Tue, 18 Aug 2026 15:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPQA-00083w-1G
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPQ7-0006k3-9P
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:25 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH9AE1454264
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ClO2Zzt/VXColTDq0F35bZK+5PH4jaSyk4/eYBjQZnw=; b=X97VuJQyYyYqUqwm
 D+GXwZXbwUPwWdN2ldFvKSUlnYHYVRG/kcLXTWLsnVkfKUgi832kooiZPDUzkg5K
 rBiJygp9q7XnO++rRV+PAcub2I1yKHEjs2ROwG89W3SkjMhEo+LXNKfxhpB+oaAB
 fcLbB1B//zPr1RnRWOOTn9wXYjsPjnicZETCeskQMlN7yOjmibKBDiJ8u5G6diSi
 tTYo8TLHy8mQeazARDGsNA30oW23M+G6q7UScvb4vibrOuTF8qRQlICdgUuKzDDW
 MtEbiWUirocKk6Pl4KPIlqIWfPVd/IbfwIIvYraPrv7rbAuAX+yHP4VvDGEvU2pa
 unBlPw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4qxj1ued-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:24:11 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc15155cde2so106592a12.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081051; x=1787685851; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ClO2Zzt/VXColTDq0F35bZK+5PH4jaSyk4/eYBjQZnw=;
 b=ULwRDRsaSj5WNQGi4fouJd4Q5m/YNyJ+hMQieg3zFML99nMV9Nmj1ump65GEmA4QwP
 sgqgUqVhnPkizGHh1KtDBk5A56WolNyJtCOWSQto6XljWEGsHoYD7D/HP1491HEyursb
 avHwUMLCLBxTLdiOa6FZOOek0fywwQx7SaBCuUTPxrr7LJraxtcHD/Xhj167NK2Lsa+u
 LDBr6axiQJON4vzUgHtEt797XIM52/VdX84VBKSX9cA+ELHHBi73qTTVFFBxQArAF3wy
 49gWNU2v9t7fEGRlYIKd7Xa4U30y10n5bMy/vb2aX613xSUhdg0eV62nA8jL+Xe6Ts0A
 WD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081051; x=1787685851;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ClO2Zzt/VXColTDq0F35bZK+5PH4jaSyk4/eYBjQZnw=;
 b=Tb3qabR6ySw7NBbOimqlxcV2HIXcBWtOK2qf+0KoBN0VbxpovJkBLvqsnuXcpbQGgd
 VCu3/WKEkrhUo2a+AlkfqRhm+YOPMLA373YMRmJ9TYM9dEV/D42GiCnPWsYhB+D0kz2x
 bc3SGjH10H+DOqWEVVQnH90sYLgeev1xXdCfsMP9vWfVhCfiA8TocSDIc+DAgO7ZVMa7
 DLclLx7Fj+U81U7jlKXdcBww97c6h+rcmGK+955ZKMIAnTtrmWg8h+95Xo0E8Y6K8RWE
 dCm/edP77JSUWMl0pyCHEqzZCCLprXzTJQY6/mNgxYce6/gLwwSgNa35aVbeDCVnIc0w
 aOjA==
X-Gm-Message-State: AOJu0YxJZaLMXEspoXAzZDm8si2A9KP7sU8g/LuChYzMZ2Bxc1XVU8kP
 eZD4UWgvD1ONb4Qg4U/gXZ0bk5BVyUV5QrpWx7fpDZs0RNKXhoxwcN8kwN5mvuTqqMwcJbgQ/ec
 sc4NnPGuY3fXIR/04PaltYBDJrm5xwOdo5WHxk+T7VmWIw8O7sbh3T023MQ700KAojw==
X-Gm-Gg: AR+sD117iW+MwCz8gQK0kSW+PW5efjHPHVmaBH7tXRw5l20Ss1/Ec+sQTshVs3WRa5j
 QwCl2BiYEDI4LFPrcC5j5EdD/T+Yt/JXjzmtFK+LuLXYFNfgcVarI6nCEktf9wWSNTTKAeqzGpw
 jfw4Jcf6VvOhDe+0rOTMiVlcGNeF1JXu4BJZcCR6Uihx93kzvd8TYyM4PEy9schF4axNQrO75dD
 HhVrN/OF2Du6O4+Elo9BkvmDfrJUo+qFJdVZk81IBezxjMuAI1+LWJtLFMfD4aaOwoLmlcA8u75
 s2xrmoLTZnUWPmG6fu4YgzBio6rEM5IwAYZ1+x/DHfuZlTjj3WdGJEa5oNlI/UeNkRUbtaeU7k5
 tvrIQZ6ZDrOBmo99fY+qYAT5cOKE3y4lQCKwKFBHm266EMeQVZJ6w59jC6Dk=
X-Received: by 2002:a05:6a20:db90:b0:3bf:7eb5:9459 with SMTP id
 adf61e73a8af0-3ccff06626fmr174038637.20.1787081050627; 
 Tue, 18 Aug 2026 12:24:10 -0700 (PDT)
X-Received: by 2002:a05:6a20:db90:b0:3bf:7eb5:9459 with SMTP id
 adf61e73a8af0-3ccff06626fmr173970637.20.1787081050222; 
 Tue, 18 Aug 2026 12:24:10 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:24:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 037/104] tests/tcg/multiarch: declare system tests
Date: Tue, 18 Aug 2026 19:22:01 +0000
Message-ID: <20260818192309.22169-38-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX+IZT4TIbWVZ/
 vl4HC+ORgEv5nPc4rWzmJF1jjK9FGQH6yDgsRFCkimZ9GGNzTOhuZIlHbOmjbXQ4rN5XBDyYla8
 4HlTDAzE4E82DZgd4yonXR12DyTY1p0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX2jd5wmPv3X3h
 uHEygUDxdU/yf3s8WDjvhhGfrdO/OsFlzEO6XVk4fIkOCWPfAuo0QDByi6bRw+VXF2RUQAAXkx/
 HBPO1ZBOOWoBWNnensmeAvaGe7Ar/gjkaly4l+3jiiuPI+6JLfcUJKHM1nAZ3hvWn4bEEli1rvO
 J93cfp2ljPbcrCOlRAeeT7r53VnmlQ451zxP4Arssoa2Ne56ukITQ6Uop8jlqPYR+x12SmiAQBO
 rvcQpgIv5g53tWIP+WtP50yB5UbuzE59RsyXS6YAjmWSDbNFHHvX0UvKhQAMI2p0P2+PFYLHj1u
 z+r5xv0Pw8gp32nmQnJGVfWhylcRJss/tG1yNeZXv64v4tion/6v9pY84aslIasRq5WRNcEaFwy
 jm+CjWzdjvJ6THFQYE6h/w78tHlky0Zp2Ov1f7+boxrPJw9WtwEZr3TwZt8ydQQrBq5bvTR4qV1
 xaFLOnGdn8wY625B4zw==
X-Proofpoint-ORIG-GUID: mnpXbDEGzYD2I_FKY0rnLsepxaAH6q0J
X-Proofpoint-GUID: mnpXbDEGzYD2I_FKY0rnLsepxaAH6q0J
X-Authority-Analysis: v=2.4 cv=bvB8wkai c=1 sm=1 tr=0 ts=6a84b15b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=8vYM-gic8w0O4C_0kjEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
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
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
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
2.43.0


