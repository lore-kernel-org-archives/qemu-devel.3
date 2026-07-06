Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09482C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrxK-0007iq-Hv; Mon, 06 Jul 2026 18:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxI-0007Vc-UO
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxH-0006rJ-2G
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:24 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEXPm1666178
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=WXeKfB/dhmv
 08rx52wM7VUXmviLCEnfMT31g/TrK6SI=; b=pohSLtow6/+JZiW8NVglaYSHRWf
 +u7cF7non6Rp+9HWXufypbRaQ1XbqK1qATI8Yv6n9I5Ag2uU7Lrvngptr8GntKwO
 3Ce15aqKM/LrPjR82QmLUXLAJ5/sBHUJ+M6geL0Q96hSumJpRzyUJGYt4AlNSEAg
 jYMWKIaQKkw4Qhvw9ZumPiLhSxPZdXpszduu0akaFOWsIl6eMaEroxHLzWtyyL9N
 BlWDQR2UToo5Zc7rWy6fHfz+rhFJhTYEbBqUJNr9EXU1FsT7OZ08n3cYle5KEcDU
 6yx5CXkvXR8dctRkTorGS1oSTxeczuGx4nadD/qSUSM+LxtrfBwAc7mTOcw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gu6xv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:38:21 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c88ad1558f4so5885513a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377501; x=1783982301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WXeKfB/dhmv08rx52wM7VUXmviLCEnfMT31g/TrK6SI=;
 b=Yvbq4ghdgKGquCqczS9YdXj9nG2Dp6I+BMN7P1cbbBexMBYhAcXIHv09k2qpb4pXbI
 UgKzEPS4ZZnPlSllsuLiKDweeX7shFbO0VYr111ceiZbSFDUqSNJJKR+h2sW2oIEXSPg
 6hqlMvDChgQTFWMcsRnY9k/TXvgTymAlXP3s++I3zLTM/0L07weyfyqOixP5meeoDO8q
 J5xkr20tO6TVuJ3ZdzbXXoEsKwsraLVyGtwUJjgy/yKX6HWoMECIMG6kz/HuvXplcNUE
 rwIm3r4Upqd5RDkvMP1yezBVyk2tOKuABCc83c8gOR99wSjMKGACiHRWjKK/VT4TD/Ew
 1CsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377501; x=1783982301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WXeKfB/dhmv08rx52wM7VUXmviLCEnfMT31g/TrK6SI=;
 b=k8/IjeJIxUmsoCkyNqgSKLQeJznrHnxMBbKhDQ7RjZKN0Upi+ETxlKZbXwmp8s1Hcm
 GcRzEV9MYKJlx1gfvJOvY2pua6Rh7mgb+Dzwt4kVNsBFgBz2aBf+tzyRia/eC/rX5QEC
 6kdfRLE0V45b+Kup6GZLVuk+m9L6da9XwnNTG+vn1ckMascVL2H0liHvtMYHEswW2IgY
 nmj+/uDXC10dRPZYWrzoUSpHsUT8uwBukREsivER/wQycv3DTIO8TpSxA8Ezjk6NCWXv
 0A/kvfXgAYfuuIGmck5L6qbmUY3R/Jn6PhUvmiF8s2MPnsU4xRxfSRWs+kiXbdtc7sNZ
 7sYg==
X-Gm-Message-State: AOJu0YxEUyptXc8C2dnCMopp58iew2HbnNInF04C7VYzZGEZrvdgdlCW
 tHcvv3Ts2jphepMbeK8R0B1Dc7TKaHaKr8duULctgZAqgfIPH4YPEdS4o9h8qpj75DsRpiL8CX+
 Wvcfaq3J8/HsaYVK2s0nh2wGE4bFjBcbl3+sxZLbMy//gvqzWAxMRWwHU44KALav39Q==
X-Gm-Gg: AfdE7clj/RoU6ovCLGKy5z++OUtS/U3q9Aqao+Vn6lqXbcZbP2/3RlHGHAZPrizErxC
 9viVdWqwmb1z8P5OTwnGenuse2MD/d0NKHE1Kp5bRpoDb455DZfznBsJhHqwI9lSng6Q7HZILe5
 QDXbTrczDilQoSkukLnWlHKrF6xAS7io/6or3u48tYsT9c22hKmauuxImZ1ZO2KMGQWLVBObc1z
 zZjbPeq3eQP68tirTFqIiF3WWfw9VmlGCkoso4ZDUsAB+591PInfsCqwe+7i4jQK5lJYIjn/iZS
 k7SixI5kskm3Gs/U9Tsp0xf/qoGWTyebDFHtyX3aVrD//aM408+1NuAjv87M7imIigZWnfeg6l3
 DX2KLoJrFbm+IZ5PyhWxtRoJgO95IQQq6QA8ct8i4Ewp6TzJ5jyOKolEVEgfsLF0B9b+VofzyIZ
 lBVG97HQ==
X-Received: by 2002:a05:6300:6690:b0:3bf:6f30:1ccd with SMTP id
 adf61e73a8af0-3c08ef83ec7mr3099582637.42.1783377500774; 
 Mon, 06 Jul 2026 15:38:20 -0700 (PDT)
X-Received: by 2002:a05:6300:6690:b0:3bf:6f30:1ccd with SMTP id
 adf61e73a8af0-3c08ef83ec7mr3099555637.42.1783377500317; 
 Mon, 06 Jul 2026 15:38:20 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:38:19 -0700 (PDT)
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
Subject: [PATCH v3 49/91] tests/tcg/i386: user tests
Date: Mon,  6 Jul 2026 15:33:01 -0700
Message-ID: <20260706223343.988769-50-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tcyO43IrBcSKapCJGlXWJZeEbUHOVO3-
X-Proofpoint-ORIG-GUID: tcyO43IrBcSKapCJGlXWJZeEbUHOVO3-
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4c2e5d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=vYhEOyJg7SS-lUoC9VAA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX+RfaXU9mJpoq
 IBWiWf50Os6LUIZJU9i/x2pf3xxjJVPCK2R8jYaKGS3vW/0oxsijXb6YS2WXJDhXtco+msbi9D5
 1XdpucvPs8aXJBuFMR58bPX8hx7sWGaN5sUT8YDXApn1T89HTKVUPpcrAbeR3ZzEbzDTj8Un9TT
 JXG6Pr9RagMZ/KwcdLVDW4jY5Mr633B/g8Jlp7hFq0UO80SZy26xVRqIIWw5O16WdjzyNJxGDIw
 SwIngiQNaVHkV2txUlB2M7CAfairusw7cIKQXYdjwAeVhiQCbE6yt8KWg4SDr7JCBZ2lJX4W1RW
 Fss+SaFkHoMvgaypYiWPHZuXJzhUm+qDQHObdr6e9VhUFpQJwJokk80cFMsGct+Bzwl59b3bV2e
 SPU8AZGsRPjiMVDY4iSbfBw5y3K4Y51T36hZUp6dr476fL3fJvNdxV1r6fqXPLXwBgRXM83mboR
 s5PkSMnnhSOGBR5QrJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX+/lOGBvyOlxx
 ccacoZV6kWHRH2YCqlRLBByCoLYNczAokmM3nHghu1ky7lsg7I76uFGiA4PqFbDBeJHv/qU3swQ
 SlCxcYqac4mTNjbd6LKvAlR9zelNrfk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060228
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

We did not include test-i386-fprem.c test as it has four problems:
- it's the only tcg test declared as "slow", which would require to
  create a test suite just for it.
- it compares output to host which limits how to test it
- it produces a gigantic reference file (64MB)
- finally, because it is in its own category, it never runs, and thus
  it's currently broken, there are flags difference with existing
  qemu-i386.

If we want to resurrect it, we could generate a simple hash as output by
default, and store the reference, which would solve the first three
problems. Also, we could add an option to do a full dump for debugging
purpose, fix it, and solve 4.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/i386/meson.build | 56 ++++++++++++++++++++++++++++++++++++++
 tests/tcg/meson.build      |  1 +
 2 files changed, 57 insertions(+)
 create mode 100644 tests/tcg/i386/meson.build

diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
new file mode 100644
index 00000000000..858485ab62c
--- /dev/null
+++ b/tests/tcg/i386/meson.build
@@ -0,0 +1,56 @@
+cc = 'i686-linux-gnu-gcc'
+cc_dockerfile = 'debian-i686-cross'
+cc_docker_arch = ['x86_64']
+
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'hello-i386.c': {
+    'cflags': ['-ffreestanding', '-fno-stack-protector', '-nostdlib'],
+  },
+  'test-aes.c': {'cflags': ['-O1', '-msse2', '-maes']},
+  'test-i386-adcox.c': {'cflags': ['-O2']},
+  'test-i386-bmi2.c': {'cflags': ['-O2', '-fwrapv']},
+  'test-i386-f2xm1.c': {},
+  'test-i386-fbstp.c': {},
+  'test-i386-fisttp.c': {},
+  'test-i386-fldcst.c': {},
+  'test-i386-fp-exceptions.c': {},
+  # TODO: this test is too long, and its output needs to be compared to native
+  # execution. Make it faster, and compare only a hash as output.
+  #'test-i386-fprem.c': {},
+  'test-i386-fpatan.c': {},
+  'test-i386-fscale.c': {},
+  'test-i386-fxam.c': {},
+  'test-i386-fxtract.c': {},
+  'test-i386-fyl2x.c': {},
+  'test-i386-fyl2xp1.c': {},
+  'test-i386-pcmpistri.c': {'cflags': ['-msse4.2']},
+  'test-i386-pseudo-denormal.c': {},
+  'test-i386-snan-convert.c': {},
+  'test-i386-sse-exceptions.c': {'cflags': ['-msse4.1', '-mfpmath=sse']},
+  'test-i386.c': {
+    'cflags': [files('test-i386-code16.S'), files('test-i386-vm86.S'),
+               '-lm', '-fno-pie', '-Wl,--no-warn-rwx-segments'],
+  },
+  '../multiarch/sha512.c': {
+     'exe_name': 'sha512-sse',
+     'cflags': ['-msse4.1', '-O3'],
+  },
+}
+
+if 'qemu-i386' in emulators
+  tcg_tests += {
+    'i386-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_arch': cc_docker_arch,
+      'folder': 'i386',
+      'gdb_arch': 'i386',
+      'qemu': emulators['qemu-i386'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 1eb887a8e3b..f1f27c2da1b 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -140,6 +140,7 @@ subdir('alpha')
 subdir('arm')
 subdir('hexagon')
 subdir('hppa')
+subdir('i386')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


