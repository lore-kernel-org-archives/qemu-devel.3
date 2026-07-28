Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF03CC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZf6-0004PY-7w; Tue, 28 Jul 2026 00:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZey-0004MM-7X
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZew-0001X0-Ni
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:19 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3atEc1701619
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r2oWPAl2ZZwwHQqOdPWo7wy5ITpFG/oBsogbHWfJBhw=; b=JQYk24AzL+Ylg5nj
 f8HtxgrAPTR1VjQ3k0qDiPy2wV0QpUIUg1p7DOOvXgKnQnzvI+Uz8OyZRDcwZVzh
 mMtKHyqSOpTgQUR0n9p+HIkec0mf/3/mAPpY6r2r+2umBOE+Mk6AmAsbWIbv+EVv
 x6tFd7L/vdZk/Pcl3Np6xlUvCq4Gyc4TDZAc20LK7sOp+tFInhA40WKiXqzceTLU
 eCYZp3+YZ359m/k/S7W6INwily64lXqfUmLiNElURZzW1Wlb6ruzvCuV0LPuZZrf
 vLlrzYxGKtxdaNcWZUh6oGigpaKPnc3XNqwRWwNqn985kaC39/eVEPYVtuaCFEWj
 Zb991g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fphh7gw63-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:17 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e4758ab46so3734477a91.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213797; x=1785818597; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r2oWPAl2ZZwwHQqOdPWo7wy5ITpFG/oBsogbHWfJBhw=;
 b=H9kIIVq5p0lvmV1IRJQ+8Or0UAXeA4GqEFETpXozhdM0R+WvBJC0rTDVP+kneOtiSk
 ON0Bfb1YHDEiMpsb7lyUxXGbxFv19Tu94gDFepComWbQiS7KkfcdjuDGHYNQ15ZFgp3u
 9DtYQg2/Khirn6pwd8Q3EJiVgH8v2jxe9eMJqEZjEBSMlmKg5TrQ6e/2UXR6XXeDD5LB
 2P2jBt0hbkAIvRneBvRnjAteU1x7HQf+P/wvpAsbsDDCrT62a62B+n0I2IDIWQOaQoGw
 /fcrnbfwpRLOlFv5CxmLw81KrGBZIoJliLJ92FFH6s9GXHfImaVXFXGx0XJwmfe048yu
 0DNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213797; x=1785818597;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r2oWPAl2ZZwwHQqOdPWo7wy5ITpFG/oBsogbHWfJBhw=;
 b=Qusu4R+FsrIibab9JTYTXEUqR7HFcKuwqAUT2cAgMLCC2vKke4DEri8BeQs45EysDT
 3pGZRzsr6teUGRcuPAnpjykQ1F1N+HGR2V9eaYkpFXyd5jbhnkVZD8DkXddf2o7xBnFU
 kmkPNdcR1fwV+bcFTTI3X8At35NEzi7CLQOSeuGuVzugWTrE4B+PT6MKeWMYRBaE3oBs
 NgK/PybDG9dDhA5vSDtdXaTm4Gg/i0qFvjTu/zJFLUx57acAXfAnh0q4+l/+57M2mVyo
 MB8jiU02fHrKrau7Pq6YlfbzwucwVNUzS/BjN593l+5PRH2qUQAxOUe++7eYZmMMhcyL
 Lp5A==
X-Gm-Message-State: AOJu0Yx9AjFuBcutmn363VkKeB2k0LbBOPShMP6N7a4kZmg9o5Vnc/7z
 LhJpP4hbB1X9nm40CFa8aORcAraD5Kww0MhlGU7PgDbphotbaliyZFEbqf3gsDNbbnRF849UHPz
 4bnvxBCwpP35p41m3Jk6bvBVgPM9ThsSz+HkNvQBxPEUBNfUQqVLUMbLIwC0PCuAr4A==
X-Gm-Gg: AR+sD136F3Rtad7e0dfhKyw9LBgggOZBjCOOtDYIzw/URz9tUVyINLr/hdDaLCuSz8X
 uouBX6411PR9HB7NellClxvMSodPXIYushhn88mS0ezMFsaxijhk0Drb+lcFgBKR6OxsHn1xKpl
 eTEFhSKku/IjSzxEnW6zMAKBif11GiyVcLDH/WqmMyuy9/hVc0BBBMgUiheJmfIUWAVU1krF2pL
 kUTv44lzsLBK1ZUs2uPQlQOlAvh4ubUCDiiE2pGBIyx1rjIGbcz6ct/aH2k6qGWYQnSf74sCA+n
 fN93C3tyyOE8QLRN/AFAMcTiF1wu9a1AhYBLrmDLMUkP9QpNubru0B930gNWQwGs0l5xCA0rrpR
 guoHRjWxH6hxAbP9PSMwbQuv8gm1KGGajvUr9dzR73g5k1gMKUDnAqonsm9gOpaVDx6JurNc=
X-Received: by 2002:a05:6a20:728c:b0:3bf:a698:ce4d with SMTP id
 adf61e73a8af0-3c8ba60b710mr944611637.54.1785213796592; 
 Mon, 27 Jul 2026 21:43:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:728c:b0:3bf:a698:ce4d with SMTP id
 adf61e73a8af0-3c8ba60b710mr944575637.54.1785213796188; 
 Mon, 27 Jul 2026 21:43:16 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:15 -0700 (PDT)
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
Subject: [PATCH v6 009/103] tests/tcg/meson.build: introduce qemu_args
Date: Mon, 27 Jul 2026 21:41:13 -0700
Message-ID: <20260728044248.137626-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfXySXLI+lOGHLK
 i/BQu6E8/cD3UjjI3KV9LF4HCFOAJxZaCtZkSwNEl/a+NNUSLm78juAtgwFXoaCebOFHxtTUIwj
 KNwwzO1ZO3DOApqmAd5mDV3PK8VVeDVBmdo6+O2MZcE8y1Fy8RFrNLMR+86xTRcSNHi51ZYVfOD
 hl/B0LMd1Fh/4ugg8HmEVLvySpnjmAp4lCYS/2DE4qmUPkHuXhfsR5hxzoyKTv/IyVw/AvSv20o
 kAUUyHT2UPkaY0jwtmuqSnELkTWyJh/8zbPBJhM5u7oBq5RI/fRhV/nX2zlxf6ctvpvV10s6UPW
 OQpBDOiBpf1VCfgKq+Gus6xEncWOtOYkSajJ/PgOT8lSCQdGw1sejJj/N7+SzFZ1K1J1OefWx4A
 UeLQVfp8Za0199r3eBcRTzfxEN8DfJRvLI5hOnN1iUsjjQtEuU4bnWc7pUYPbcgAsQLYGRwdj7W
 nLe1GXLSVdiuFi/0nNQ==
X-Proofpoint-ORIG-GUID: KK-DYSWWBbltUOVJ-Vnx87D0tIh44XSV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX6zqtuh53YRYf
 4Xa3gk1qs0VMNEWGJ83xETDbyRypKYGPj9v10/p2VDgNfhA5D1dWRExKjUOL70ASCoujjF35qiF
 5ZE11yc8lgHAuqZLSXVMMrbhBukrnug=
X-Proofpoint-GUID: KK-DYSWWBbltUOVJ-Vnx87D0tIh44XSV
X-Authority-Analysis: v=2.4 cv=b+6CJNGx c=1 sm=1 tr=0 ts=6a683365 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=BgapuaGD2VAwZ5NCc8gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280040
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

We add possibility to use custom arguments when calling qemu for a test.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index e8d8cfbcf88..a7699b7f62d 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -14,6 +14,7 @@ tcg_tests = {}
 #           'exe_name': ['provide an alternative binary name'],
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
+#           'qemu_args': ['qemu command line flags', ...],
 #         }
 #       },
 #       ...
@@ -56,7 +57,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'cflags', 'test_name']
+        allowed = ['exe_name', 'cflags', 'qemu_args', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -110,9 +111,13 @@ foreach target, plan: tcg_tests
       endif
 
       depends = []
+      qemu_args = []
+      if 'qemu_args' in setup
+        qemu_args = setup['qemu_args']
+      endif
 
       exe = built_tests[exe_name]
-      cmd = [qemu, exe]
+      cmd = [qemu, qemu_args, exe]
 
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
-- 
2.47.3


