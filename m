Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5111BC54F51
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZfA-0004VU-8o; Tue, 28 Jul 2026 00:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZf6-0004QK-Le
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZf4-0001an-T8
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:28 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S40jBc1594067
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UxpkHnsYG15XIOwt2Igl6sOiUGb8GNbbD8oNvOBguFo=; b=oGZeHZ9aSoGm8PHd
 6RSKbjwPY+Cl0+Uc7yvhRXt0tQlpRi9f9tc96uw11pDtC1oF5S9folX8uwOs8bPy
 P22v7SBwvBBTAJrFWSE1rcr7J5GTHd5z/x3DvEuBZ4b5lWueIZzaAj6M/cCo29Sz
 J+tVJ8xiPVWimiLNliAxw+dbQhSnhl1CkTgJYdXw2+WatJ9SzP9j0XwiItdv+8sg
 KJbs0UnmUYJsTqsTBbsLdxo4D2Awysw3Mh7p6lHkwvG+6ADKlszr3uNnRtD21Lpc
 rEeNM2caSXU8twsYUBlAH5InZJ/e6RmYcTBNMRPk73wH/C6xvWoFxLaZ8Nk7hm/5
 0Pdbag==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn19g418-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:25 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c9fe4c5eb39so2350066a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213804; x=1785818604; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UxpkHnsYG15XIOwt2Igl6sOiUGb8GNbbD8oNvOBguFo=;
 b=Ia7E06dXHI2/B5e8mTeDHSTZzI/tXGEbX8M9TbamU6pO/kcfsHxEhC8tV3srIsdNUS
 IKPe4f8NYBjlu2wMeaeBqyjv3auVcaWy0mtze2W+DlEtFxdLDA5T7NfDbS5M56sgyInF
 VoQlaDlPADFNVHrQ94zGazEUH45IgoqABJ6zN8HRvrJ9iO6YRTlaDdVx+cxAKx4+Y09B
 oAy+h4/Zxzo/H9+fHpAkwrMKBPljMVvk6iJ/ZJbgIUdaXxY7GjcixPvAjrT1uxKjvO/w
 ggbyQauHTnkCEUB0Klb0QUIlQBjaUpk5J/bhO4LFZhM98WSPPTC3vmVWJXPtLOepHXre
 TyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213804; x=1785818604;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UxpkHnsYG15XIOwt2Igl6sOiUGb8GNbbD8oNvOBguFo=;
 b=sLhSYgxxrIEea6vNAhSMWUH3DOEg9zSBHBdN9PlQErnlqrDBxR0kCvNhr/xxH+GPUV
 OVKtv+D4wiIS3ye3PHIJoFwRZ9IlqZBcc0MPbvEFmZU+K4k0whVpcebKVc113YLonXCW
 RjSXausmTmXcYynTWyvqflAHo+4sBnNrFNIiPKjXJHKZtRWxJoUfoWd4rGtHCmkoyv8o
 O6gjUnjMlNwoXnbXJiv0VaLXlnEdExsW6zpdW8xwcy9RV//tLqsvLEeHnqvsmwvxKV7E
 eujHQxmNnQ3WqBcwbFx4BmUAcbQ2UVNtwVDWTOoJzKizWxPNf63NUNyHNTcp7oIPzkaA
 LVSg==
X-Gm-Message-State: AOJu0YwqPkuV4KKxaXns4zgSKFz9cS8JdQb2GM2GxyGIz3sNuoyvHGIv
 9sL0ArBIgKovdyqH6GhPCgyQ4j1Ocg8RwlAyluDSOnQyBEOQV7Ypvurz9snTd6gKWXQTDBcI2JW
 Uo4tRh8x+md5927TGOziANEWePlLVfEZilBzPYuwNcqC0VpCTLHf0m6Kt6C6Y9OsD+A==
X-Gm-Gg: AR+sD12uMnk85N/aq8DI3t1IYIG+kEl1UtpTTYXfij92vfEUawWjjdMSv1VfVgEFOGh
 zahXwjF1Uz2jz0ltGlVknMhe7ZcZeML3mLHe+eaIgxQPZluu/xCGAfF+oRHp0bJMl5OASgvRsUG
 IWcEQr5Wt9iXng8LKEDJGHjfHvDitP4H/AFOMXVDxNZHE1QIAos146qkZKZ/2/KAbu9WH+44hNZ
 mz/4jXqGxBQT0gQHcHlXohYgNefZvRbgKrrtVmHbZF5q9NtM4wS582ZAw1F173Wpexirubh9l1I
 A76xouSeG3PrLYjS+w2BwmqUAE6Q84FfE0He4aRC5hKWwhmZX8y4aKXxwiMiBMZWa1Z9McnMXHP
 /oVmrefw42a8IvFLy29206vUPjSOeQBWO2mY99Zm+oWDMqR+lVHy5ZDSAY3QEFQWy6/iJ1O0=
X-Received: by 2002:a05:6a21:b89:b0:3c3:abd4:ac74 with SMTP id
 adf61e73a8af0-3c8ba5b8b80mr961858637.39.1785213804165; 
 Mon, 27 Jul 2026 21:43:24 -0700 (PDT)
X-Received: by 2002:a05:6a21:b89:b0:3c3:abd4:ac74 with SMTP id
 adf61e73a8af0-3c8ba5b8b80mr961830637.39.1785213803777; 
 Mon, 27 Jul 2026 21:43:23 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:23 -0700 (PDT)
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
Subject: [PATCH v6 014/103] tests/tcg/meson.build: introduce gdb_test
Date: Mon, 27 Jul 2026 21:41:18 -0700
Message-ID: <20260728044248.137626-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TJV1jVla c=1 sm=1 tr=0 ts=6a68336d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ZkoTrUv0hqWFqrPu6skA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfXw1KAtdoJTMDI
 2r8jcKjPCqxIXNycY9dKuY07Xkqqt2RhAhosnQLiKt24b1oiugvtockn0aFamvYIqFj2fI0klRQ
 Kbd1oyXOqeL+MVDAnlf+WPH3cPFKwR2On2tZqyrTwbgVFaFZXOw01UHYunNaCuYHRSfnVz6Radw
 uhEZGw11nJhIEWiSp1iYPU9+r8POqVq2YXxVB8aun5nZXPU9ZShh/f1ldGQRa+eS8N2WMeGXK9p
 7Hd7vg7s/jZExq+1ClsiqP7tgU0dmPDbcdc1m7EMLWVvbekoQrKFQ3mLmOH8PJ7/DQuHY1NjrAe
 emTe3neJlB5urJhGuF/DR6gLDbhwR0PAmEhGpJkA+x5ELCny84Ss7OKg9u4ZWZg56o/uZsZXlVF
 kWxhfI2317SmR0lb3Iyc+Mpg3EbKQfdhttdgOmSkRBIH3Fgio78wP/Gu8Kj37kDVEJBSNkMtQ1s
 aUnBQ6vbxfamw4pQIEA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX4M+xrrSDDpNT
 8mD9FbWhG+OTVSg3xPuVfql5xivvwYenjsubrFMczLEFQAsagbheaBTRxvWhWSsvYLS0vtA1e16
 le++cdVQ9xX9kQQstpei8p6kAv73m9Y=
X-Proofpoint-GUID: 9BlfMKydHApoAzHJgS9QbmFt1ley3AqC
X-Proofpoint-ORIG-GUID: 9BlfMKydHApoAzHJgS9QbmFt1ley3AqC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280040
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

We can now declare a test requiring gdb interaction, based on
tests/guest-debug/run-test.py.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 3714fe4dc0d..76375615d0b 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -5,6 +5,7 @@ if config_host.has_key('GDB')
   gdb_progs = [config_host['GDB'], gdb_progs]
 endif
 gdb = find_program(gdb_progs, required: false)
+prog_gdb_test = find_program('../guest-debug/run-test.py')
 
 tcg_tests = {}
 # tcg_tests is a dictionary with following structure:
@@ -22,6 +23,7 @@ tcg_tests = {}
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
 #           'qemu_args': ['qemu command line flags', ...],
+#           'gdb_test': ['gdb test args'],
 #           'env_var': ['VAR=value', ...],
 #           'plugin_test': {
 #             'plugin': 'plugin_name',
@@ -83,7 +85,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'env_var', 'cflags', 'plugin_test',
+        allowed = ['exe_name', 'env_var', 'cflags', 'gdb_test', 'plugin_test',
                    'qemu_args', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
@@ -102,6 +104,10 @@ foreach target, plan: tcg_tests
         endforeach
       endif
 
+      if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
+        continue
+      endif
+
       if 'plugin_test' in setup and not get_option('plugins')
         continue
       endif
@@ -118,7 +124,9 @@ foreach target, plan: tcg_tests
       if 'test_name' in setup
         test_name = setup['test_name']
       endif
-      if 'plugin_test' in setup
+      if 'gdb_test' in setup
+        test_name = 'gdb-' + test_name
+      elif 'plugin_test' in setup
         plugin = test_plugins[setup['plugin_test']['plugin']]
         # remove 'lib' prefix
         plugin_name = fs.stem(plugin).substring(3)
@@ -182,6 +190,16 @@ foreach target, plan: tcg_tests
       exe = built_tests[exe_name]
       cmd = [qemu, qemu_args, exe]
 
+      if 'gdb_test' in setup
+        cmd = [prog_gdb_test,
+               '--gdb', gdb,
+               '--qemu', qemu,
+               '--qargs', ' '.join(qemu_args),
+               '--bin', exe,
+               setup['gdb_test'],
+              ]
+      endif
+
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
 
-- 
2.47.3


