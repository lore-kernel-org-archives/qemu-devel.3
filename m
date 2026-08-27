Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF644C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziRW-0002Wv-6C; Thu, 27 Aug 2026 18:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRC-0002A0-OY
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRA-00075L-Vt
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:10 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM1Wh1117762
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kqEvKRUw09P
 NYcNEEF6PV4GEXuCCFIUdNeWt2KKiDhw=; b=Bvgy37q63YuzvE89chDpHgGfPXZ
 Tqfn0soanioPXUI8g75j8LwwQQfv+7GLna+BExb9cXkybuPssC2w1LAxQy1FbMJo
 +86MtdNVeg79P93okwbp57dzJTv2zozT7NAhLVmH8Nd5tAgYTspVVFk4Fb7/WvIW
 LcQrTmgkMBqVmCI3pCmSd42wy+2vy82a8yA4qoISHiHIcBUVyyUJYahB4ODOjEQf
 I8ofLja+jyOPTkvr5JwBsumL46Bhtqph0Gr2zw9swJeRPygij6g6nJqG22HXL4pa
 0ZHSCIgdohUKL66Lj9IOuVTZncVl+Vbm6eiuFM25IhAtYxd3rpjdY7smFeQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garn0hfv4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:07 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e54b6556aso277740a91.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869147; x=1788473947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kqEvKRUw09PNYcNEEF6PV4GEXuCCFIUdNeWt2KKiDhw=;
 b=YPfOdgGvLgv1JNZ6NP45P+wwIfgUt6PSb9NgUYp1hhjhRoodo0d1qQKPvBlRmLAMdT
 GsCiHmJ7NT7tZ5FR8YlufbX32y9Wu09xf1AhClxZ1MulB4L6b43aU0Xa/PrH1epNlFRr
 VwD3nuHC49FWkQfGOaeBg/wuZOp3eiolEElhxCQtM2D7DfaKnR7GXMMCKB2ujaH3ZhGk
 v6eFtkfhupwJTLQJTK/K21NgterlhbgnidbI7neUL1VL7eQHVkwUq96PjP6FG0y6VlYC
 vFUDzDJRulYwvQ5KNi/ttOuL8a/lV42+WAqRmP6kV5oJHyWVdgWuKypjjGZzrMr1ZNdn
 qECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869147; x=1788473947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kqEvKRUw09PNYcNEEF6PV4GEXuCCFIUdNeWt2KKiDhw=;
 b=h+PIBbHAA9U7ecPEyG6wodquqFHPwsBW5QJswj67Rrk6diciGRMH3rm7VOMQdIH3HX
 Xy0rUI2alJMNV9X9xN4GFBLy6rigE9UaHPsKSwbLE6JY5/MB649bHZ7BI9rQyzkbjBdy
 +/7ns1fHU7AxqWeD5mQlyuU2jfSZYF5L1oPBPtNP5tp7xFSWeF2/BeAI33ZrwOrHNXMm
 +VhQifSlqbJqyt8NBg6i0jQuJKUcb27KUFevDWg/bjTKUYT5ivXziN72kW7wVSjWPnCt
 5stclU8JHJ5KeQYO5bs0ub+bpZ/lBUyN0vaH+23BW7y9fryQj2N0HOQdg3bPueUGth40
 m9iA==
X-Gm-Message-State: AFuF++liLmS9ix2P7F6CXQwGys0KIyRipkRW1T7ZzOgQihSaz/jnzuxj
 Jrv+FBo9Y7P4B+nylT2YnIZIpmwbrFZmkTkePpVxR2i402VRrf1FwsWxdakIyKBnSnrNifYoZm4
 92JTSx3Fx0EtUv1WjcQ4mTwx0TatqaZevW7zIw/IFoYkzHQcTU5nHKuV7cmfyqLVIug==
X-Gm-Gg: AR+sD12wuNwqfANwnYZ10qRiJLcXiXC1a/9gjmb1OK1ZpiTcoyJnHn8g3pOYOQH6PYu
 n2yjRjYWfCgdR8NrLQnixcRZwFMjSn5a+hiiBU53YoXA6OB5DHl9zkrxzkETYrmYObtYgdXVQ1Y
 GL8ZpmvoFDsVQqP5E0N30ipBCmcsIVZ3xbFiBeHh398yrSH6IWsxHsXKXhB+TKis1kHdnQdZBRx
 7SzjK28S7TKgg2uG0Rq1zDKHbp0/jrCcbOricOhUIjRtCtfj6sJKp0aQuNcVxzYi3Twew23pYg/
 u3IkxjPcjQZM/iwXmrl/hhSx3fjRnKOyFDBkn1JdiyExaN2rrNcM+JRxOUPlyDedL3eG96SxIeT
 Rc8Yoo37vMEh8Ri+IBMkIZosqSG+Q8Cfjk6oEszFYBlFoMUrh0CVlc4xZv04=
X-Received: by 2002:a17:90b:440d:b0:38f:bbc:6a0f with SMTP id
 98e67ed59e1d1-396d0e5f35fmr3510707a91.1.1787869146640; 
 Thu, 27 Aug 2026 15:19:06 -0700 (PDT)
X-Received: by 2002:a17:90b:440d:b0:38f:bbc:6a0f with SMTP id
 98e67ed59e1d1-396d0e5f35fmr3510620a91.1.1787869146182; 
 Thu, 27 Aug 2026 15:19:06 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:19:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 045/105] tests/tcg/alpha: user tests
Date: Thu, 27 Aug 2026 22:14:06 +0000
Message-ID: <20260827221506.91574-46-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX0LFAnTO4tjLm
 gtLBm4fXxbcnl+/7eirYAcGmYxNxcil57rf4DA26JoOzSieCNn5/+BcVZ28QxghkWbEHCYw2fpy
 eRma9C7i/oMClYGFBIPga0IGRF1sahG2vj8pdqyaTQyz6DRkNuAlDYUTHosPrmATCPVNP1Ymvrj
 djgvNOTA3WyNI+vXf1Z0+m9TTUJYL6kC92DdNzVzFhUpLkoMlEX3uW1FLTEDUICIpNpRaMqMHNR
 EPpITB9LHu1v/fPJzBoba5vnMc5pWRLW/LeIvEu/qWviTcpggjY9z2nSZYxefoSZXG6uBg/A5tF
 1dtdKDTdSEtK9VMKIFMh01trfxQGDKdEngI525+mbuKm+oLXuTVrb9kBYAnbKimknysCwGbOQUo
 WFkwpd/8Qh+KyXjBSrhZxN60wR9hyYKxVjIk4iTPvZ6Yh1aHP5t7Il8Zbqou6wyALfnJuNBn8mE
 wRYXpbfX2ju7yGdM3QQ==
X-Proofpoint-GUID: SI53kfqssKHbypeM8OVZEVNGTOiJo8KO
X-Authority-Analysis: v=2.4 cv=C+3ZDwP+ c=1 sm=1 tr=0 ts=6a90b7db cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=HlkHknZ0qViDtorXcHIA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: SI53kfqssKHbypeM8OVZEVNGTOiJo8KO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX0pBLxfVxjoZR
 9UFisIZsveGxQv5cxFa9I9AOhZawx6XBz3kcOR8Q2+CPl1ta/lxROcRCxK1e5QjaW6xqYLSLmpK
 8dC2R4tFtO1DjfPrtIdDTnbbDMvcttk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270189
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

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/alpha/Makefile.target | 18 -----------
 tests/tcg/alpha/meson.build     | 53 +++++++++++++++++++++++++++++++++
 tests/tcg/meson.build           |  1 +
 3 files changed, 54 insertions(+), 18 deletions(-)
 delete mode 100644 tests/tcg/alpha/Makefile.target
 create mode 100644 tests/tcg/alpha/meson.build

diff --git a/tests/tcg/alpha/Makefile.target b/tests/tcg/alpha/Makefile.target
deleted file mode 100644
index 36d8ed1eaea..00000000000
--- a/tests/tcg/alpha/Makefile.target
+++ /dev/null
@@ -1,18 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# Alpha specific tweaks
-
-ALPHA_SRC=$(SRC_PATH)/tests/tcg/alpha
-VPATH+=$(ALPHA_SRC)
-
-ALPHA_TESTS=hello-alpha test-cond test-cmov test-ovf test-cvttq
-TESTS+=$(ALPHA_TESTS)
-
-test-cmov: EXTRA_CFLAGS=-DTEST_CMOV
-test-cmov: test-cond.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-# Force generation of byte read/write
-test-plugin-mem-access: CFLAGS+=-mbwx
-
-run-test-cmov: test-cmov
diff --git a/tests/tcg/alpha/meson.build b/tests/tcg/alpha/meson.build
new file mode 100644
index 00000000000..08e371116c3
--- /dev/null
+++ b/tests/tcg/alpha/meson.build
@@ -0,0 +1,53 @@
+cc = 'alpha-linux-gnu-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+cc_docker_host_arch = ['aarch64', 'x86_64']
+
+tests = []
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-linux-user']['tests']
+  foreach src, setup: t
+    new_cflags = []
+    if 'cflags' in setup
+      new_cflags = setup['cflags']
+    endif
+    # Force generation of byte read/write
+    if fs.stem(src) == 'test-plugin-mem-access'
+      new_cflags += ['-mbwx']
+    endif
+    if src not in multi_src
+      setup += {'cflags': new_cflags}
+      multi_src += src
+    endif
+    tests += {src: setup}
+  endforeach
+endforeach
+
+tests += {
+  'hello-alpha.c': {},
+  'test-cond.c': {},
+  'test-cvttq.c': {},
+  'test-ovf.c': {},
+}
+
+tests += {
+  'test-cond.c': {
+    'cflags': ['-DTEST_CMOV'],
+    'exe_name': 'test-cmov'
+  },
+}
+
+if 'qemu-alpha' in emulators
+  tcg_tests += {
+    'alpha-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'alpha',
+      'gdb_arch': 'alpha',
+      'qemu': emulators['qemu-alpha'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index d878581b660..e0789d9c1eb 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -138,6 +138,7 @@ endforeach
 # Now let's go through all architectures
 subdir('aarch64')
 subdir('aarch64_be')
+subdir('alpha')
 
 image_targets = {}
 exe_targets = []
-- 
2.43.0


