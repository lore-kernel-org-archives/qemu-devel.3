Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF8FC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrxS-0000IC-F7; Mon, 06 Jul 2026 18:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxQ-0008TC-CO
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxO-0006tE-Eq
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:32 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE4RE1650822
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6oJAI57diuO
 hsrGRUfampm6F/qco1skBqvTuhe9ZXEA=; b=M6GUCjhIgevbV2Y14i+CwmFrkng
 LNBjrm3DbUeuo6ul5DsTrwgywv8mT67a7t/YjuFfuwnBMWyplVNk/I5As8Qq2m1x
 w6/Xm40On+2f6BouDNkRPdyiSZHTpDMXKZT1KiBkCzB2W2bQyh9XyYL1Ocqa3Nvr
 m8PgPmWJKhsNMYhYwwHIb4NwqTZllH6+6GAos0xsJvXC+shGyyj2WbrWPNX4ekK8
 TgtaAeOXcvSXzhunLqk93Y8GehBGK1zC8fozKG5k7/ffDSXBxbm2rv+jT7urXK1I
 C0pWLhglcSRKz8JkOBxFWlbJ+jxlsORjQjC7H0cL5RX+s7r9OZoVeAawyuQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgub1q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:38:28 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c9fe2607511so5204367a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377508; x=1783982308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6oJAI57diuOhsrGRUfampm6F/qco1skBqvTuhe9ZXEA=;
 b=CnrDOGf53KM6PGivEFNl6sFgUTEm6ygmQFtHbAzgu4oqUvGSh+sSG/+1vuFh31smXJ
 pOwIDiv2TxccB7OujCtzC95TKiH7Jye7iORfq/qaled1YSn2mWI4ddXp9Tpem8R9m/eM
 m0HhD8JfTl+6k9oyH4NUVdH9KStNN8hRzT7svpu7pLfyObMHuVW8VvZ5vS9fxKqT8Hts
 bCSooMVvyyjDWyZ7ZbhlBeYX/vQGjd4ZLkKZCoDkB+6YxWfT7poRvms5Voaw89mqfbMp
 S2y+DeuKi0oFm6UDwNpGReA0QWUVbIK0EPNAIY1keg6d2bCgTWlVlw//VOwVx3H+8V10
 B1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377508; x=1783982308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6oJAI57diuOhsrGRUfampm6F/qco1skBqvTuhe9ZXEA=;
 b=BlE1QDsc96PMPoAjCB4q/JW2UfVOWFb6/WKU47Qe2dKyruWjwO52iJmMZvrWG2fSYd
 59KQK0y7Uv6qolDN9UuZYcpJHa0f6RQXbj3HtYt3ZEzo+vtMYpEKEbpRavfrp5MwqlAS
 enDFVO07LeWZWyrOfwkd5TluBzfBjNYncnwZtmC9uTKLwmpcTw/gFIwTZQNz7kEO4AED
 AnUzhQgWC03niIJ/1hM5D4MfnzLRV39QPaIkY+bKtNS0MGeoaqF6mmU6i2/fg2Pro6Gd
 dj4VJaOFRLCdCZeUgOEWmQ6LGHicYSJw+CRxxOLpiBAwW4QzqoIxHFnGTnM4ZpdyJPha
 ilpQ==
X-Gm-Message-State: AOJu0YxAHwapJAr4JQ885AHvoQQmxRzEtzTbTZqNZV2xtt6c1dPkRNm2
 nS4ncTyWO6k9WKgyIkLcTGO3suMuVoaXbVaSS1th7G2bgAWgI/Qmx1IG6vQxxQSCFpMyGue+IX7
 L6txw8sCO4iGyqcspx26VliVZqd/EffhYQnqwu26vxLl7rhJSKLS5UT2qeXZNTIrTXA==
X-Gm-Gg: AfdE7ckJPJ/HeSlyDsAOrXunYCbMRt40iU1rnz1WtbtIboMrshXcGb+pMmqHBU8HdwX
 aFFCpLjO6lTvWmb4/iXXSitzkS/hGQU1R4ET8zC8q5N9cspaEttD/BHAgm4Wsn0paWycjRsq6/o
 8rO5XbdxmJaXemQ8PtjfaDtIayATdFH0XSaNGoLjE6rBr+erCkU0mapIAE6Kvb0l+Mz1H14JE3l
 u7PpDrSES6YbKK9L6Is0xYVOQ+vAlcK22h3kYr0FwAs9SBqCqQOlMbujv9b8xwMv8ZYlxfGOIbX
 AtAVzdSVHIEBExMQ4LbvbcsU1vepGpb4oXe8eYwWT6nJGdJ+KlpvHvhn2bJwxGdAlU2+ZhoJbAq
 mA3bn5pXi6HkrlI7sYyczs45Oq7NXdJlzabtr871IIBxFsb1w+FoaZvyTPpPNz8hB0NU4YM+tmJ
 qn4l8+AA==
X-Received: by 2002:a05:6a20:4322:b0:3c0:9c1a:8937 with SMTP id
 adf61e73a8af0-3c09c1b46d8mr83050637.63.1783377508117; 
 Mon, 06 Jul 2026 15:38:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:4322:b0:3c0:9c1a:8937 with SMTP id
 adf61e73a8af0-3c09c1b46d8mr83015637.63.1783377507647; 
 Mon, 06 Jul 2026 15:38:27 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:38:27 -0700 (PDT)
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
Subject: [PATCH v3 52/91] tests/tcg/loongarch64: system tests
Date: Mon,  6 Jul 2026 15:33:04 -0700
Message-ID: <20260706223343.988769-53-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vBiDkQTn2MMabtTo9ilwHwX97JXK8IQC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfXyB/evZpK2eWf
 tDRsH/psqi7LOuAGzhxVRUBNYciB2hXKfpOjzuczWnu3pwKiv0hLwahYEzofn/gvJDC9jrCRFRY
 gzRhmPwZQdsCADtmWBpVaI5PPL1x1nN5/82BVMjMlfOA/mD4ya2SLnhdcglRS8PkCqQdLPsBp/c
 YpSb7wovBN4kQNAyCD85EtEV6NFDWZEFELnwt2NnNS1m4eELBR2bIQS007TZlNlFOA7/m/ZBrUy
 DFLeRPSzUKDOwNa6id8htwSsW8dH6CwcHUGI4UT8DStrNgkmyCkx3YwXWvq5QvWlXcfClIiqI/W
 gkI1tekJuxUjM0A1XDsotm1m3nxs6NNUhBVnOa0SkuEiy96rudNozfj0dyhTZ+GOC4RKNYRKi31
 Gw4CVVIUrlVSm4aIUkpGR1oFaC/t16WXxWRnj89uXLUTcsoxOJLbCjuyLpretvJG+aomNwiXiDo
 KNQHyjUqTzG5kowo4Zw==
X-Proofpoint-ORIG-GUID: vBiDkQTn2MMabtTo9ilwHwX97JXK8IQC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfXz5RoxhnKsd7W
 gYv9pUg5C20MxR7+D2TjNILCFkFrMiiq+42hj4kYovFhG1uqn41JNsZe7BN//XVfAY/24Rz8a5E
 m7UlYYVulw4+dYOdqcNlnCspVO+Iv3g=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4c2e64 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=4F7OrdlOo6ohLtspjYMA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060228
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
 tests/tcg/loongarch64/meson.build        |  2 +
 tests/tcg/loongarch64/system/meson.build | 47 ++++++++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 tests/tcg/loongarch64/system/meson.build

diff --git a/tests/tcg/loongarch64/meson.build b/tests/tcg/loongarch64/meson.build
index 399c1617a99..b3cc68543a3 100644
--- a/tests/tcg/loongarch64/meson.build
+++ b/tests/tcg/loongarch64/meson.build
@@ -2,6 +2,8 @@ cc = 'loongarch64-unknown-linux-gnu-gcc'
 cc_dockerfile = 'debian-loongarch-cross'
 cc_docker_arch = ['x86_64']
 
+subdir('system')
+
 tests = []
 
 tests += tcg_tests['multiarch-linux-user']['tests']
diff --git a/tests/tcg/loongarch64/system/meson.build b/tests/tcg/loongarch64/system/meson.build
new file mode 100644
index 00000000000..d72921dde2d
--- /dev/null
+++ b/tests/tcg/loongarch64/system/meson.build
@@ -0,0 +1,47 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('kernel.ld')[0]
+boot = files('boot.S')[0]
+cflags = ['-nostdlib',
+          '-Wa,--noexecstack',
+          '-I', minilib_dir, minilib_printf, boot,
+          '-Wl,-T', link_script,
+          '-march=loongarch64',
+          '-mabi=lp64d',
+          '-Wl,--no-warn-rwx-segments',
+          '-lgcc']
+qemu_def_args = ['-display', 'none',
+                 '-serial', 'stdio',
+                 '-kernel']
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += '-DCHECK_UNALIGNED=0'
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_def_args}}
+  endforeach
+endforeach
+
+if 'qemu-system-loongarch64' in emulators
+  tcg_tests += {
+    'loongarch64-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_arch': cc_docker_arch,
+      'folder': 'loongarch64/system',
+      'gdb_arch': 'loongarch64',
+      'qemu': emulators['qemu-system-loongarch64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


