Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D0CC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ1C-0004uh-Ro; Fri, 10 Jul 2026 17:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1A-0004u7-S2
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ19-0003R3-Eg
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:20 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3eip1846381
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RFjVJTQ2D0Wts7nay7wAsDwJ8itGt0KQqTQeD36rVUc=; b=aicqvzIcqt2Kc3ai
 EFcQZRPYOuoZq66E4zuHBiNTlEdYGNUxIK/skiEMTAGPsH0W/UWmFePGT0dGej2V
 lnNlLeNLn9fwd54RxpVMxmRDlLEecBOP8F62dUnVSvOLgPEdrzNHElFunAsIes71
 0VafrjGVcGO6nZTmI8k4BzBz5Kmwz4o4XZzZz4aJmEuVVvC5QcqBfM00N+HhZ2XV
 yIH7Dllaoc+PLem/Hy8AD1lvyt+oqOO/ZyLwQrcsr07PCa3pbsmr2tOA0PGFA7M0
 0jdCw8+IEn3hbDRkf5NZAKmMuGWyEYBGpesz7uNBxSwxbiIrm5Nz001K+aicAsT8
 ln2V3g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb649rj8f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:18 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c894391f000so308043a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719857; x=1784324657; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RFjVJTQ2D0Wts7nay7wAsDwJ8itGt0KQqTQeD36rVUc=;
 b=V77t7oU5Yobs4um5Gam9T67TM3Rv6+Bq2xhN6XstCc3GEu/e+Walwyxgt59mCMZsfK
 bBRPb09NnFqFSrivMzSa6FBF5ilFngi55sxotAevozBff9CYF1pq40mEwso24ITw4000
 EVoNAaLp2+h4VjtKw15XHXO35OUEKBpC9B8UkTi906RBUPhn/yjYx1S2JUacikimr+1S
 j6siEjMmQgE3lWaq0H5yY8YPcDOUFXHUN0LBVE5e5fQ108urpWHe8lKol1KE1ZKONYJD
 pABNM7XBAn+8fbp3hm6UhpzOV0Ke756A07L9lNN9D9fHos5Cvk9Lizb6tSSf96XQlGVv
 E7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719857; x=1784324657;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RFjVJTQ2D0Wts7nay7wAsDwJ8itGt0KQqTQeD36rVUc=;
 b=deoU2ta7VWWYvf2gj0BeL2jo+pOd37doLlqaCf5qExLW8/nPnlKgcbTrENZRCNcdhm
 7RE+VtONtp1aJcLqwIcWVBXLDXnBuHHwRhzEPtKgI+emsbUaEwZHnhO15eEVOZuVmxKE
 Z17W5vX+xxt9Ztk8GPgtpONNCxTfVBalZphp2yRxAGZfNp6AOS7pCsPqtrcdI0+XlQTv
 2YPn9XZe4Pv5xhziC+YxoiXv6Lq+rG30BhK+Wn/DBTD9HCeXz5ORYFmwqvX33/dnwu3e
 hCUFPQnQBH8baW6gPlaekfG6+eR4WlxzbsWdKLA/mc+nFYOCeOIwDmEpXi6fjrN+fAw5
 eXMw==
X-Gm-Message-State: AOJu0YwZL9oDVITBN37SvpXxXR51Z5P8w+Xf37c+SdFufXu0VlclF9ul
 OPMy9NRzgBln8y6ccHA3zvGXI2LWkGo7JPGpz5LoJcYF8vYBJKmtEOM9/K8T5651GwnPjX6odvy
 3FviMkmasR75RUEXMZ4SSacenhXS6qibQPEbo3/Gip0ny572P/YaF2LNov0tzKWWDoA==
X-Gm-Gg: AfdE7clW+3806cDPj2XDWXAg3ug5C8KZDj1e82nW+A4TY4cuEf1OVq4JnNm7bbaot23
 9mu9wmgt8DlvbZ2pKEfPxGyDyTGOYLh4chMYFBJEPgum3Cp/2mEmlx56p9mBAcd0ftLrpbZclWV
 EJZIsvnFBuJjLhgJFD6WeC6uOuZfLfBuUX/5c9pqJmX48m6WuE7QCEp8f/tNuzuxUGN/ppzLBAA
 PQCYRtklMI4QYvIcAJypeAHg4nKaIpwqyAGqz+0HLjHzjp1eVlnfS55W55xOlFSiQwvFFQzhQ3g
 ayxY/6rNcgr2z06O3FH0t8D5hTS1X6vcDw4sEi+LsyPHf2UnwvxZk07YjwWvHDA0okrPTN0xNOa
 pqJu6lTHCYZzeLFPh6BJnCUelFRCUpjDOIfmysw1+Q5FIlFeVWZ5jfvftXjFn6mg92LxhcV17Qw
 AArggHDA==
X-Received: by 2002:a05:6a20:430f:b0:3b4:7758:e397 with SMTP id
 adf61e73a8af0-3c110157a16mr680552637.16.1783719857523; 
 Fri, 10 Jul 2026 14:44:17 -0700 (PDT)
X-Received: by 2002:a05:6a20:430f:b0:3b4:7758:e397 with SMTP id
 adf61e73a8af0-3c110157a16mr680529637.16.1783719857084; 
 Fri, 10 Jul 2026 14:44:17 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 10/98] tests/tcg/meson.build: introduce env_var
Date: Fri, 10 Jul 2026 14:42:14 -0700
Message-ID: <20260710214343.2065491-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7ipffGfnbLKkbzjtrbLVUJxGdtUaUKEi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX2oUOy60m7pcT
 uJXty22B8ZwM9of/qZjMDGVROqjeWX2u0qprMGxKVCqR5LrtHn3nkb1qA3o9qe7AkQjfQBZ3r+z
 Ix5GwVtPVW8756yIz0ZkowAkVJotO0W1Lyl4je2gEtOOXpztj/reDVsp4kxocMcWSF9CML6nyFK
 giX5xTmaSKvpQ/cWakPVApobRd2hi54UVkGkGBlpZuQKc1Mv33rySeTq475T5Jr/QADQLN9gO8E
 DSkBajRAarSJHE4/1/zyrgRWnJtVQfN04dMbQK7Jlu2O7hd3n5bJVJTz1s0g2OVnCn0VPXVKvAr
 HTm84fVEq+TlhUhY/m9nezqZdumh1YHRTACPKXV90x56CZpma2rPgdUhQGijtmSI+PNh20Hal1k
 Brj4R+es94rRlAfNME/g6ykyzoScV2RnT6j5CDvWb06xMX8AfrgP3crd8d/G8lqJmpWpaxZF/oR
 Vrt4oAz/utVDo1Voljw==
X-Proofpoint-GUID: 7ipffGfnbLKkbzjtrbLVUJxGdtUaUKEi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfXySMdWPlU6CTK
 MCCMzEPR0WPs95uWrzzPgzq6cRZyMld2hf9eqDF0/a7/GLOb6wZtNPte/FmVylmlZxFn5hfgwSI
 y6vIH44X2rwtbMc1XL1q5nWQrIoSrqM=
X-Authority-Analysis: v=2.4 cv=VZfH+lp9 c=1 sm=1 tr=0 ts=6a5167b2 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=gbQ6B9eDvqgx0y-0Ix8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100218
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

We add possibility to set an environment variable when running a test.
An example of a test requiring this is
tests/tcg/multiarch/linux/linux-sigrtminmax.c.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index a7699b7f62d..fbee86e6b4b 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -15,6 +15,7 @@ tcg_tests = {}
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
 #           'qemu_args': ['qemu command line flags', ...],
+#           'env_var': ['VAR=value', ...],
 #         }
 #       },
 #       ...
@@ -57,7 +58,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'cflags', 'qemu_args', 'test_name']
+        allowed = ['exe_name', 'env_var', 'cflags', 'qemu_args', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -122,6 +123,10 @@ foreach target, plan: tcg_tests
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
 
+      if 'env_var' in setup
+        cmd = [setup['env_var'], cmd]
+      endif
+
       test(test_name, env, args: cmd,
            depends: depends,
            timeout: 120,
-- 
2.47.3


