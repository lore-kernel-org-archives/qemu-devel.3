Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD14CC44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgruS-0004nB-Ab; Mon, 06 Jul 2026 18:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgru6-00045Z-VN
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:35:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgru4-0005i5-Ea
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:35:06 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEG4O1505081
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=DQToFcZVarA
 oUgyFMkF+c2YstmYNWhH2GwiayvkVXD8=; b=ct+Hy92Pt+Iu+mTgXpcPTxrQmvY
 twutSz+JELc6oL+YO1H21hR/18XBdrix8FrNafRKFfeLuFeY+JodvJ9OtMeurnbh
 DLynOnatY4N8sk+XnJoJDvVAEI6ecw5ADDhiM3RlnsynxLzHEVfVnnsyeMs/aI/F
 JoWwFRokluCuZNwIDqHJ8Ksl0lV2ssvHPHNaYsVlO1ybgtSFBUaoBiy6bh8wKUoO
 2ydTNEWCRjWgaMsKUSiVEB2XpHAgVvY7lKPl7gH1hyAjKgEc0msATqE2M7jKvkQ6
 /RNbOuHocRGw5iQ6PySytWn/nr0NaC0zUqFagKCItPA1eVEbLXs8issabdA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98k2r2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:52 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c892143db7fso2965595a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377292; x=1783982092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DQToFcZVarAoUgyFMkF+c2YstmYNWhH2GwiayvkVXD8=;
 b=JEkDEDZELOW4FuORiUkawUnV/aF8WoF+UTda9xqKMR1vPoWqgXjDThAndVprU2yVLo
 KShZR5+PhFbUt5i7Y0QSAI4/IEncaDa2it/2butvHmS72WKP6q32CelKViYkfmVFy3pu
 Dtg0FHzJe/9EOM3TDysu8MGh43XrmLmDiycYzQpcIXt8GEYAiCyvfzmiuIKRxlN6nLwd
 7TNLbRgNXsLbW5ZxVyGbuv6685JYCcuimJn/bWosIHzhttSeki4LhFwOoB1W5H4oLHbt
 I+w4MpZFLaKLkknCH3ThoPdI7YvrlsvF8y/vUKfcMKYD7ZEo7UKqqGUSRlUEH5k5U6qf
 SS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377292; x=1783982092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DQToFcZVarAoUgyFMkF+c2YstmYNWhH2GwiayvkVXD8=;
 b=sa0mWMFoIiyVhdFngqaZlhiJWTSxslY1bHDRZrU1yCAoevTzFPepQIiQRj/hGNKMFW
 kahib6dMOHiZ4h9HJBEAnXuKBcrnVzdujpaVALMbTDk2/iTGelK0XrVCspV+HeYar6Wg
 4sTsLhoo7eg6OYPyhuYkwDajVDsOBwd2KJyrSX23EIBJGW09eKhcE6zTmtI0qcI6l90o
 4OJ7Fwx6+a4m20NRONJbMFCZ+adxfIso2tpgFn9/OXz9k0Yyxr7ukm9qCjxwUt6TY3zr
 V8vtQx3smlaR64lan2VOSGlOzcYllKCrI1Hug24lyNESieLOHSpC8I+Vip+nlQkeQG4Z
 YBew==
X-Gm-Message-State: AOJu0Yyh2nZ06ZNH4BSeFdQXGv3L7P81ngxszYE6BwxCHeeXsssxsOGg
 ureylId+oaNER0vZPo68cU/U4sI2EdC+3+GkiQnzbXhSGW9Gl9eKJgCpxJ5rM3F4Rqr65Psb8az
 0BAOceYbmNC5/lagm+xGLXfK8yn6EIR3XI8q88YVaBQc53AVKoJMAautbIFJMihJqaQ==
X-Gm-Gg: AfdE7cl8hmfzJr/QinY/Motw1ksfxeTMUIYxcD7pf4hU7P8HKScCbL8AMuMWRvn5YmQ
 5JtPjjd1Fzqu6gBaiip7NAvjzDcpGH6ARep2JZDI1fq+v7kIbysLvtR1BJyoQ8ZlyLLDtpsFj4I
 +nprcHdYPOPyqHVRLlXwwqiYol9527j4BipEoA3s2UqMh05r57moKRNJx1ZK5BO68n+A+1J11C/
 Cu1BDPonGpy6xK8117EGENO51SZZ+9VYRk8osBbTrKMru8OISy4MKELYwJg4S2Syg97X6QUOL9x
 13Vt8lb3PD9t6ellFg4LIzKORl8GtFA3yKu9FzfL7ftACdNFblxUt2dwlAGP/QT52QBpclJ8NdT
 i3u6gXZiTqZeRUrdMGGqV58xTlRRgy03u/YdfZARGkZ1g6cEhjCondEKfkLjJnmiHN3BA3Ok87T
 NCnIvTMQ==
X-Received: by 2002:a05:6a20:914d:b0:3bf:6ac8:8d29 with SMTP id
 adf61e73a8af0-3c08ed0f367mr3206926637.21.1783377292228; 
 Mon, 06 Jul 2026 15:34:52 -0700 (PDT)
X-Received: by 2002:a05:6a20:914d:b0:3bf:6ac8:8d29 with SMTP id
 adf61e73a8af0-3c08ed0f367mr3206899637.21.1783377291798; 
 Mon, 06 Jul 2026 15:34:51 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:51 -0700 (PDT)
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
Subject: [PATCH v3 39/91] tests/tcg/alpha: user tests
Date: Mon,  6 Jul 2026 15:32:51 -0700
Message-ID: <20260706223343.988769-40-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4c2d8c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=KwDHnCMQy87TepIpjtgA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfXxpzMh6PVHJYJ
 Pfaeh/s1lg6OkZNspnSs4K9a4SewirohfrNeXwOPI6Q36gleSu+hHIxEWoEwQBTLqLxH23xEkqq
 vgv4815D7Ol4VormTeMkIO0K4yKI5L2CcrZPLb6uDlTgrdkUENEsapsVlfmHk19fxRzf6qvNHfy
 XFTWNJOQeb91Jz4xqUcdOPyoBLYpiKV2r+JlbSoFjAF6f3mPxfHcMTXir6cSSj8x+Uiq6IMjCCL
 LyewxReIQQay5LrgE2nePlQ0C0Ve419Z49Pj5dE4lXJr5oKEpKiRjccEhmUdf6wOo9JJYkStFzf
 qBa2tgjqaouSHoKmjAOmiOfncMkryrLnDhe9aU2g20dYPB5STCHRRSedExIpiWPxhHuXcG5RX4z
 o5YziMz6PWdEaRjIyi28S9qkYXZhd2PrqQJLOlo0Ls/rpkQ/j91Hri0BDygPFU4cdwo/aJINhZj
 +EuOkXVEwk8uNudXWjA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX1ixFavfxN7kv
 ea69WkaI0LH5LCNNLRKaypEICinXUinl2dyNcYkeke395Mt9yTA8XrsOPTBWFCEV7NHdIUIS1eZ
 7eyxxyEx1y4bom4iM1kC1p7S2xmZO4U=
X-Proofpoint-GUID: 13JFG_AFjIrbeGPDd1lpcg4n7p9yW8F0
X-Proofpoint-ORIG-GUID: 13JFG_AFjIrbeGPDd1lpcg4n7p9yW8F0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/alpha/meson.build | 53 +++++++++++++++++++++++++++++++++++++
 tests/tcg/meson.build       |  1 +
 2 files changed, 54 insertions(+)
 create mode 100644 tests/tcg/alpha/meson.build

diff --git a/tests/tcg/alpha/meson.build b/tests/tcg/alpha/meson.build
new file mode 100644
index 00000000000..d473f62bcbc
--- /dev/null
+++ b/tests/tcg/alpha/meson.build
@@ -0,0 +1,53 @@
+cc = 'alpha-linux-gnu-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+cc_docker_arch = ['aarch64', 'x86_64']
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
+      'cc_docker_arch': cc_docker_arch,
+      'folder': 'alpha',
+      'gdb_arch': 'alpha',
+      'qemu': emulators['qemu-alpha'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index bfd426c4459..d43e34225f5 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -136,6 +136,7 @@ endforeach
 # Now let's go through all architectures
 subdir('aarch64')
 subdir('aarch64_be')
+subdir('alpha')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


