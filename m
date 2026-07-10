Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FB1C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4bH-000110-5M; Fri, 10 Jul 2026 02:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bB-0000vx-29
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4b8-0004Pq-Po
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:32 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3n6x03707643
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4zjHMK7zt/kkcT/vDp5YXo7zcENwd1jTzje8Z/8AHWc=; b=VyolMfX35H2vHqqZ
 48HXEwOcv9wSW25os4EhbDtuOCOHA8sQnUSEXi+CEyA1uGjuhGxJw0dm/phAd52b
 cjVCwigGGnEIepGtVmdBa8OYiDDSwKCQub2LDoHrF/J9vn40RRF6Jg82k55CGHOi
 B/UAWTj4gDfphq4mvzmEHTPVg7ckSnrMgN6Na0J7jPAKVK5WTiEhx0rFds/R7t+O
 K+DOnggR18QrxVDAmCUzWw3dLI8ek6gtdSCMaUqFRltVRJRODgw+7Om7XikopTJD
 LvV2z4l6rHXJWck6izwwjl7yrYMjkBecK0bVwuui6OSJinLT2iae+Ui7qdJDl5Si
 uiepIA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg5k307-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c8924f4d0a4so842328a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664427; x=1784269227; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4zjHMK7zt/kkcT/vDp5YXo7zcENwd1jTzje8Z/8AHWc=;
 b=eNvd5/Xhp7QPCA+HcvyCQDSpSNrOOWREwZtrIxPHn5Ft4eRSuH1DHypAO555i/Hs36
 OPy5CPz5nB3gyu1/E23hhcWKhSK5lqi4aw9/JnXFRS0btwPrzSDrFzOqJT1WdTz4eV7/
 3+svmKvgsfCKrO+yU8czJ5CDU0lbRZ1JLcmxqNqzmtCgGcAILzZFwlL8v9o1Fgy+xLD+
 ktUpNrEEU0lYq7yWtTDoIIj4BmtwRjoXFJnGh4iGhySRkrjHozPuXCRPAStSLe4LqaWM
 bznHIFSvdYG6JOAXmP/YnD+BED9lArzEx8wuaz+SrA6t+CW6gzysL059Zd/gnMCz3213
 SvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664427; x=1784269227;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4zjHMK7zt/kkcT/vDp5YXo7zcENwd1jTzje8Z/8AHWc=;
 b=O6wrka3fIYUuEMLOBTv0R9oVEE+CbSiRYqomflzOOJVf49jQYBY0+X45kOwqw7MTFN
 rvacrcoDoD//FNfqoZjtFt+m0fXErU2a9HC3Gl1LdpTvl0hI6e6NHXNgw9xNxGlXLGR5
 U6XVMhZf09zL6WMMG3bqzndiM4TXuTqkyI/AjgIYGg1u2k/0DcRVS2EJKGizLnCW4pt/
 P4bOaJtMtFho7bVueFUMdl3KNCu+0oGPph5YTBDzrM0mj0rXl6TuPR12Ri4b709Tq6Bq
 2ZeWf8m6k7oZ7Fus9QZfEpGe+YODJDofPvMhAKaDkj769lTK9hw3CJghv38l5B3LTKPf
 aVpA==
X-Gm-Message-State: AOJu0YzKa4M7iNu6zGE7QeXOJF76AKPkU+F9l/sEN7nepqXbYMFfj/5D
 LuiSBcfsML36kji3N9ZtcQc195VoPAl42e0kJ87WVyUpXMpeP70Cr8TvsqOt/7QOpvQRnihFK3L
 CSSRDo0jiTN8bU5jbin6lpqocqDRBXdA6C6U8y7UWEp5PkbvA6uvjFqlZ26eOYJaU3Q==
X-Gm-Gg: AfdE7ckmjvR8+cpceWcKEml1iFJ8hGSm0/TFiLGjSHMrWwy0jMJsf9kOUQb3915GcPf
 xJhNkkoKeGNH2FCA3DFnI0nVtbqkcefmKQ5PP/i75358/YtHzt20yFUXVpxXWivxSlrMhg9+rlZ
 97n1af5/JyY43cKjPx3KSh2YAXpiOcw9DNplGlLxStltbdBjrG3eg7OQyM6Rs4kolOfLuLiESuo
 Xu3v8NXn2PjhMH20A9k6lhF7KeuEfAuH1Vs9TL/g5qBD0jvQSKl1rpav78rRH363ygsBYXmVO1o
 0Nl01bNmpiF96B/rkZfP/m12Z3nK4UohGdMJWWE8ExYQAWQx2J1mko7Awt6BE5Py0K/OqA6lsfm
 fceJepjtDZCRCM/88T3QWWAxBv7vB1bXNT48EyEkXiWx04x/JSFn6BKPiT0SpmpDYVaW/67kh0c
 Zec8Mwvg==
X-Received: by 2002:a05:6a20:7490:b0:3a0:b781:4c78 with SMTP id
 adf61e73a8af0-3c0bc903417mr12259079637.15.1783664427277; 
 Thu, 09 Jul 2026 23:20:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:7490:b0:3a0:b781:4c78 with SMTP id
 adf61e73a8af0-3c0bc903417mr12259046637.15.1783664426783; 
 Thu, 09 Jul 2026 23:20:26 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:20:25 -0700 (PDT)
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
Subject: [PATCH v4 02/97] tests/tcg/multiarch/plugin/check-plugin-output.sh:
 take test output as input
Date: Thu,  9 Jul 2026 23:18:40 -0700
Message-ID: <20260710062016.1818125-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FN8rAeos c=1 sm=1 tr=0 ts=6a508f2b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=BJ7t3AzVVyt49CR6OUkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfXxKRme6jGIsec
 pm5NKPvyg/uAyknyp3vcpRRhZjnLijFxt7Y8vhTRrMdmSI5MHADte6A0YJQLG6wUrOKzdg3Y2Pt
 18/nVlm/8HHVDaAaUuS5Hvj/oqxqWDA=
X-Proofpoint-ORIG-GUID: n6auisakWSisI3Lh43VSxqkeLklnsP-w
X-Proofpoint-GUID: n6auisakWSisI3Lh43VSxqkeLklnsP-w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX6KB58XGXu0Vi
 UqB8SkYzT20VEsmL0eAIjD2g2Yh3n8F1Ub++gQgywCkhf1UEOEDRG+049ievM57JS0brwdSePB2
 mKonBdw/ylwNPOtkYKYJos7mUDRNFeIUlGy6OvJCkvMrhGprwtI0Ki3t8hgi6ZImRVqWkfd6lbE
 gs/UgCXP+IR5W/m+1QgTOcVNC9RKdsjW6/Ils2oPimHRRDcZGuqNAOLohCLD9bJ8mcS/QfwhuUC
 sgObfR/xHHe7T8iuaWo8l+9e0IJJhXT/fTP5LE6ZAYnLQkQNDe/yF1ReiEhUO3o0e1dsqLL+VVE
 /5pmI+bmZszj+UDheTAFo0F0BW3feEoKaVP7FHVHS/XJrPpkWP6YEniZXg0VSoV6SvdqXKh1K1k
 rllXrN1EhxH7phYtp2IRUwJdgFIni51PztJ9Ah24YRbZMi6t3r2uxozkURG7Nuk+fMX5TOBdiuG
 pJx14t978Jhm8hJko3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100058
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

Instead of executing test, just read it's output from a file. This
allows to standardize how to call check plugins scripts.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/Makefile.target           |  3 +--
 .../multiarch/plugin/check-plugin-output.sh   | 22 ++++++-------------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index ab4bf9c5d53..9bcbbb11286 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -202,8 +202,7 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
 	PLUGIN_ARGS=$(COMMA)print-accesses=true
 run-plugin-test-plugin-mem-access-with-libmem.so: \
 	CHECK_PLUGIN_OUTPUT_COMMAND= \
-	$(SRC_PATH)/tests/tcg/multiarch/plugin/check-plugin-output.sh \
-	$(QEMU) $<
+	$(SRC_PATH)/tests/tcg/multiarch/plugin/check-plugin-output.sh $@.out
 run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
 run-plugin-test-plugin-set-pc-with-libsetpc.so:
 
diff --git a/tests/tcg/multiarch/plugin/check-plugin-output.sh b/tests/tcg/multiarch/plugin/check-plugin-output.sh
index 80607f04b5d..338c9ced23e 100755
--- a/tests/tcg/multiarch/plugin/check-plugin-output.sh
+++ b/tests/tcg/multiarch/plugin/check-plugin-output.sh
@@ -1,8 +1,7 @@
 #!/usr/bin/env bash
 
-# This script runs a given executable using qemu, and compare its standard
-# output with an expected plugin output.
-# Each line of output is searched (as a regexp) in the expected plugin output.
+# This script checks that plugin_output contains line from test_output.
+# Each line of output is searched (as a regexp) in plugin_output.
 
 set -euo pipefail
 
@@ -19,18 +18,11 @@ check()
     grep "$pattern" "$file" > /dev/null || die "\"$pattern\" not found in $file"
 }
 
-[ $# -eq 3 ] || die "usage: qemu_bin exe plugin_out_file"
+[ $# -eq 2 ] || die "usage: test_output plugin_out"
 
-qemu_bin=$1; shift
-exe=$1;shift
-plugin_out=$1; shift
+test_output=$1;shift
+plugin_output=$1;shift
 
-expected()
-{
-    $qemu_bin $exe ||
-        die "running $exe failed"
-}
-
-expected | while read line; do
-    check "$plugin_out" "$line"
+cat $test_output | while read line; do
+    check "$plugin_output" "$line"
 done
-- 
2.47.3


