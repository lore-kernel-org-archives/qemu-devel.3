Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC932CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBfKY-0000nu-Ot; Tue, 29 Sep 2026 17:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfKS-0000fS-Nq
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfKP-0003tL-0b
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:36 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TKaqmo941991
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=F48ItYSyNvf
 QM28lnJH9XtroHIpo7q2NLuVmF9zG5GU=; b=aBq7krvE4xiag2yIyrQhiqhZYaC
 JV4b/JP0YeFv0kYP3zU6mOzJ/w/f0tZFWJCaImOdxa9lZGndVMyn3ydy4Tzqku0V
 XvgbhtABvY65MUxtfM6iPd9/va0V2wjuq3CV5VaCxWjysRJSifEFZzDkKO92GyR/
 4fVL/iUgG5K1K4s07TGiE84uA7UCyj9ITdeeKn26PMWRDrSmY9tL0MWwVt2NYEwq
 N1TLPSPZIDxvGn/vB8hFLvoQ39465BaXruUWFAk3QxOiSfnkku/BpKhBM0YiWJmR
 fPi/b0HfYrioRSTL89OmyTm63aFL4oe5HEj0fZms88VAqyl3wJKxrFJ6Kzg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0ftuhjup-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:31 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-342138eeff2so654229eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 14:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790717131; x=1791321931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F48ItYSyNvfQM28lnJH9XtroHIpo7q2NLuVmF9zG5GU=;
 b=P1KyAJh4vl3bagdV4ByCeWeTDMQlzoETTaMhkP/baqNMcaKgiyN+0EmK2hpgRTQQ+1
 +AHpNoKlA4XGOflCA5DVy21R0oYZVS0k6MOHEWusWVU696cfZCaAGkCmrGfrbp5mknZ+
 SA+/901aul2QQSg+mGXLK0Ax0gKpdo60oUf9XCoM1HFLdB1CJdm/2y1v6cLTvwpIKs9m
 i6z+llexowxw9BwKtUViZE0mKYkODfP2lSA1YnvOBL+WaDsrzsro0N38Nq/ECz189bM+
 xyseD/4XudKbdgUAmSHqLXa3K6oS3U089f90pDVGW+ecuXeA4bk9hQAOKaPcmB2ix4AF
 81SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790717131; x=1791321931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F48ItYSyNvfQM28lnJH9XtroHIpo7q2NLuVmF9zG5GU=;
 b=hRM7cyFlboSYbZzgdBjvsyDAnqS8FJCGk7INfnAsn+LG0KVVvvG6v45Gnh0ZZZhrV3
 HYOde+k67qXgzVtWwO3WjFHNOUnjFkgqqogwcE1PqDmHX2Vw4tfQLTT1aJehn765jjAn
 iEKvSu1EJu574izIEQgtyw8vqLftvJzc+JOvZHcWmxfQZMS66rSUWT27fU61ATlcmgW5
 wN0VH/12gDf9jIzih32OpCrVChb59dEZYlC63+snqz7NhhRYVgiTCIOmn46SGtHou3lA
 CWYWPRq8anuuyzfLYb0Z4nN6qJfGTrxX8JrjPjyqzwWONcI1i6adrifAxv+LaOXdidTr
 5OmQ==
X-Gm-Message-State: AFq9FYIXnmnBohzxOjopA7Joz8cmQH8yRPrlnopHejvSww53iU1cKxWK
 uB3/2TnrOsgytDfjIgsn62KQcayEuG93wyA/7cBQvh3BBkf+xVjT+CrdSrcglMvhVpn/rIH8EhP
 wwduFa114W0FMoh9Li/W5F6hJcGDzFRm3pavkzWnNshx8Yy3cGKRMNisAIwuNo8xHJQ==
X-Gm-Gg: AYBFou1lDKn2q08S0DRvsXYiNG/Z/1YIDroiIgZ36KF3fKf5MHj9kJTSbUEEoJUljaZ
 295meCc9HvyPOPxNTHTjEtT0o7XzQLNMGoWc9W/tS1T1ghFOKyoZh38WqH3QIMphqzqXwegjIKn
 1CX0slvMAyKNWXfbHrRCeXJed4XK4hmvrhBniBTDnr53nTekMCqL4TSMZglgQC9iHMK0oK/WSeZ
 7xc2mPiCy9U9Y00WW6NQjraxNvX3Oem+QavcabnNzCi1j4UiQq93D3C7F60xCl4OmZb7PZOXKBe
 jmZjMtZEnfUnTtrkS8Y9jbW94KZJLRnQYLZvHBCTz0vbgAEb2QK8PQdsamMYcBXGkIIeJxZkQ0b
 ntb51d7947E836cUQgzvHT8AxfgkdDIGHddDVnUbfiOvIIMRe9ZQ+dm5mLJLR
X-Received: by 2002:a05:7300:bf83:b0:34a:586e:84db with SMTP id
 5a478bee46e88-34c63ee7d85mr684061eec.2.1790717130906; 
 Tue, 29 Sep 2026 14:25:30 -0700 (PDT)
X-Received: by 2002:a05:7300:bf83:b0:34a:586e:84db with SMTP id
 5a478bee46e88-34c63ee7d85mr684032eec.2.1790717130303; 
 Tue, 29 Sep 2026 14:25:30 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388d0110sm1415413eec.20.2026.09.29.14.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 14:25:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 19/24] tests/tcg/mips64: add mips64r6(el) tests
Date: Tue, 29 Sep 2026 21:24:34 +0000
Message-ID: <20260929212439.110454-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX1dkBhceV7pt9
 y8tdN/Vtyz7LJSbmJK9ZYVKZNMhYWLx3mIRXpt2vV+pVKIrUHPf/NOZS0PfnJhu6+5D6S9QlpAR
 GH/jywpDarFBqcGqIs81UWkH8HIdcRndHAl1jkqGxFRgDnofCxLZXdAtyTQq7uR3/KYRy0afUhC
 nupatuctQw5DmiicD9sKtbpyehUnEKt1WB22agNPklHauSDLA0oryZVrrlCO6Xg4j7J3oIBUkFj
 +s9h2ouIne5xaQNZuZ9m1PyVYZW5xpIxbJN1dVcfrZle65T5C8zlcM7FxT3bta2J+BiX++cAe5d
 v2MO8t0QfoZWXcZYjxV1glggl1WYBkgkaReuZpxXcyWwasCiCzp8LGzF1MGFH5FR5xFxHjGYmcb
 ptJE6a0fyNMi0AiiY9qQuBeyPJ+er/jgslp4yw8NrMOYrNlsESxVMtKz86tHa4bqUS6FPgYRReo
 m1Nnldbm5/BE4yOG20w==
X-Authority-Analysis: v=2.4 cv=AoB7T+9P c=1 sm=1 tr=0 ts=6abc2ccb cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=wCgUcsEHi0jYncpm0KkA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX9I/wq7keqMFO
 4Ypf9YKqQ1adveNW9Zb6W+C+xWs6gLhuXyhNaHzCblJt+LWyRbEiv99uPSJ39WbyXqGGkiExs6m
 s1r/nmx/b5hoY4H/raHiDFy7aRy4GM8=
X-Proofpoint-GUID: e4Qodl17zC5kMLNgYfXwlkpTKT6CqkI9
X-Proofpoint-ORIG-GUID: e4Qodl17zC5kMLNgYfXwlkpTKT6CqkI9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290085
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

We need to define two new test suites mips64r6-linux-user and
mips64r6el-linux-user to be able to use a different compiler from
mips64-linux-user, as cc is setup only once per suite.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson_options.txt              |  8 +++++
 scripts/meson-buildoptions.sh  |  4 +++
 tests/tcg/mips64/meson.build   | 57 ++++++++++++++++++++++++++++++++++
 tests/tcg/mips64el/meson.build | 11 +++++++
 4 files changed, 80 insertions(+)

diff --git a/meson_options.txt b/meson_options.txt
index e6dd64b5a87..07b016c0fd4 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -445,6 +445,14 @@ option('tcg_tests_cross_cc_mips64', type: 'string',
        description: 'cc for mips64 tcg tests')
 option('tcg_tests_cross_cflags_mips64', type: 'string',
        description: 'cflags for mips64 tcg tests')
+option('tcg_tests_cross_cc_mips64r6', type: 'string',
+       description: 'cc for mips64r6 tcg tests')
+option('tcg_tests_cross_cflags_mips64r6', type: 'string',
+       description: 'cflags for mips64r6 tcg tests')
+option('tcg_tests_cross_cc_mips64r6el', type: 'string',
+       description: 'cc for mips64r6el tcg tests')
+option('tcg_tests_cross_cflags_mips64r6el', type: 'string',
+       description: 'cflags for mips64r6el tcg tests')
 option('tcg_tests_cross_cc_mips64el', type: 'string',
        description: 'cc for mips64el tcg tests')
 option('tcg_tests_cross_cflags_mips64el', type: 'string',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index b46005ee96c..4076a7f6b59 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -540,6 +540,8 @@ _meson_option_parse() {
     --tcg-tests-cross-cc-mips=*) quote_sh "-Dtcg_tests_cross_cc_mips=$2" ;;
     --tcg-tests-cross-cc-mips64=*) quote_sh "-Dtcg_tests_cross_cc_mips64=$2" ;;
     --tcg-tests-cross-cc-mips64el=*) quote_sh "-Dtcg_tests_cross_cc_mips64el=$2" ;;
+    --tcg-tests-cross-cc-mips64r6=*) quote_sh "-Dtcg_tests_cross_cc_mips64r6=$2" ;;
+    --tcg-tests-cross-cc-mips64r6el=*) quote_sh "-Dtcg_tests_cross_cc_mips64r6el=$2" ;;
     --tcg-tests-cross-cc-mipsel=*) quote_sh "-Dtcg_tests_cross_cc_mipsel=$2" ;;
     --tcg-tests-cross-cc-or1k=*) quote_sh "-Dtcg_tests_cross_cc_or1k=$2" ;;
     --tcg-tests-cross-cc-ppc64=*) quote_sh "-Dtcg_tests_cross_cc_ppc64=$2" ;;
@@ -563,6 +565,8 @@ _meson_option_parse() {
     --tcg-tests-cross-cflags-mips=*) quote_sh "-Dtcg_tests_cross_cflags_mips=$2" ;;
     --tcg-tests-cross-cflags-mips64=*) quote_sh "-Dtcg_tests_cross_cflags_mips64=$2" ;;
     --tcg-tests-cross-cflags-mips64el=*) quote_sh "-Dtcg_tests_cross_cflags_mips64el=$2" ;;
+    --tcg-tests-cross-cflags-mips64r6=*) quote_sh "-Dtcg_tests_cross_cflags_mips64r6=$2" ;;
+    --tcg-tests-cross-cflags-mips64r6el=*) quote_sh "-Dtcg_tests_cross_cflags_mips64r6el=$2" ;;
     --tcg-tests-cross-cflags-mipsel=*) quote_sh "-Dtcg_tests_cross_cflags_mipsel=$2" ;;
     --tcg-tests-cross-cflags-or1k=*) quote_sh "-Dtcg_tests_cross_cflags_or1k=$2" ;;
     --tcg-tests-cross-cflags-ppc64=*) quote_sh "-Dtcg_tests_cross_cflags_ppc64=$2" ;;
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index f08d1182576..676a47f5c8f 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -23,3 +23,60 @@ if 'qemu-mips64' in emulators
     }
   }
 endif
+
+tests = []
+
+tests_mips64r6 = [
+  '../mips64/test_mips64r6_and.c',
+  '../mips64/test_mips64r6_bitswap.c',
+  '../mips64/test_mips64r6_clo.c',
+  '../mips64/test_mips64r6_clz.c',
+  '../mips64/test_mips64r6_crc32b.c',
+  '../mips64/test_mips64r6_crc32cb.c',
+  '../mips64/test_mips64r6_crc32cd.c',
+  '../mips64/test_mips64r6_crc32ch.c',
+  '../mips64/test_mips64r6_crc32cw.c',
+  '../mips64/test_mips64r6_crc32d.c',
+  '../mips64/test_mips64r6_crc32h.c',
+  '../mips64/test_mips64r6_crc32w.c',
+  '../mips64/test_mips64r6_dbitswap.c',
+  '../mips64/test_mips64r6_dclo.c',
+  '../mips64/test_mips64r6_dclz.c',
+  '../mips64/test_mips64r6_dmuh.c',
+  '../mips64/test_mips64r6_dmuhu.c',
+  '../mips64/test_mips64r6_dmul.c',
+  '../mips64/test_mips64r6_dmulu.c',
+  '../mips64/test_mips64r6_dsllv.c',
+  '../mips64/test_mips64r6_dsrav.c',
+  '../mips64/test_mips64r6_dsrlv.c',
+  '../mips64/test_mips64r6_muh.c',
+  '../mips64/test_mips64r6_muhu.c',
+  '../mips64/test_mips64r6_mul.c',
+  '../mips64/test_mips64r6_mulu.c',
+  '../mips64/test_mips64r6_nor.c',
+  '../mips64/test_mips64r6_or.c',
+  '../mips64/test_mips64r6_sllv.c',
+  '../mips64/test_mips64r6_srav.c',
+  '../mips64/test_mips64r6_srlv.c',
+  '../mips64/test_mips64r6_xor.c',
+]
+
+foreach src: tests_mips64r6
+  tests += {src: {'cflags': '-march=mips64r6'}}
+endforeach
+
+# export tests for mips64el
+tcg_tests_mips64r6 = tests
+
+if 'qemu-mips64' in emulators
+  tcg_tests += {
+    'mips64r6-linux-user': {
+      'cc': 'mipsisa64r6-linux-gnuabi64-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'folder': 'mips64',
+      'gdb_arch': 'mips64',
+      'qemu': emulators['qemu-mips64'],
+      'tests': tcg_tests_mips64r6,
+    }
+  }
+endif
diff --git a/tests/tcg/mips64el/meson.build b/tests/tcg/mips64el/meson.build
index d74c7de9b7a..606f300804a 100644
--- a/tests/tcg/mips64el/meson.build
+++ b/tests/tcg/mips64el/meson.build
@@ -9,4 +9,15 @@ if 'qemu-mips64el' in emulators
       'tests': tcg_tests_mips64,
     }
   }
+
+  tcg_tests += {
+    'mips64r6el-linux-user': {
+      'cc': 'mipsisa64r6el-linux-gnuabi64-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'folder': 'mips64el',
+      'gdb_arch': 'mips64el',
+      'qemu': emulators['qemu-mips64el'],
+      'tests': tcg_tests_mips64r6,
+    }
+  }
 endif
-- 
2.43.0


