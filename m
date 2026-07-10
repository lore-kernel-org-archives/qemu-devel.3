Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B03C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ1B-0004uA-15; Fri, 10 Jul 2026 17:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ19-0004tf-Gd
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ17-0003Qd-Up
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:19 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AKDcaQ1811766
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r2oWPAl2ZZwwHQqOdPWo7wy5ITpFG/oBsogbHWfJBhw=; b=jC31dJEAUi5naVWf
 csPFXJY/uK8uTzs+/H3bOGjN5DwAZ/gopjEhr7fPncySK6BmBNgPErpzY2tO4fgQ
 lWPHOvaSySlFYpIyBLF8XEetrKLYovCU88kv/aE4huO85vbeFhbweU2XoYxxF0BQ
 0UoeDAWnGYR2l63sVzoDr3P9NqWAkkqVjjRaY/99DMcXxp+EEzyN34e1oXA5sjZP
 NjLkPeVNIFzknJKBlopnazoL10LV4w1uhubyEvC4FmziMaoqtkEVxKf+bJL43QuV
 XuH07qaDvtcCg0BhZJhARlP61b2mf5ko9ajsmzNOPua2xw0u6Q9IDhoDW4GhkSga
 5IwwNA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5fahna-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:16 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c894391f000so308010a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719856; x=1784324656; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r2oWPAl2ZZwwHQqOdPWo7wy5ITpFG/oBsogbHWfJBhw=;
 b=LRSd54knkD6gE+xRjT5qogqCgv5Bd22cNdlanKO8xtVunSWkSTb8obZw0bqrqDnfN3
 s4B+f84IF08l3IVoX5+3aQYBLK6MKSoEVrXWyWLgG7H6Jno898nxhN/4m0Mv5setG64q
 Bwb6GeMPOjojEgTVW40iHyfTqbV5sYgHYXrT7ZTV7Fh37v6VOyoxV56xPjPPsM5xluIc
 +Vn3zN7sQrYx7YMxZd3XYuK0T9lzQjiIoiL33xwGhBuws5m73d8RclXGHocvWnSKyHVx
 E5yT4a6pGeLL4Fr/YyZtNy+mPcNe5FC7/JDINaAuR/7Ko8T1oC9tYex8P5cm8UwXDdSd
 x71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719856; x=1784324656;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r2oWPAl2ZZwwHQqOdPWo7wy5ITpFG/oBsogbHWfJBhw=;
 b=nzQCSt/nvCTmdIb5E6hxOF9CfAcS6vlQfmXW+yQXg1pUIT+3ob/uJjnXiL2JlyZPZy
 wCLPoriTyyDgD0ZzxUEzeYgjAkVhELkvDU3C2BydqCBmNSbYBSi8W40/K4wk9ezmxHKk
 I8rtMACbFuFbrdepHKptee/0dTD4nz5QVJORDG7cN0QyvG201P2dhbkSfwRZ8RpajX5E
 0NjfdvqVzVupPm+4UaG/bLioWCLubcatBAGkGZjlR2HxRazEDUA4z6Wvt34yG6BxvFhy
 Vz54jdl5KboW4vjyqV9iZjYm6pF9zgCkbL7zXU0lHIG1k5JlqReORf0L0Vg24cNn1Bo8
 RYaA==
X-Gm-Message-State: AOJu0Yx2tR008LRiRtrUEByOTKpsNWoSF2ZknWRipxwrhpjunYefEvf7
 FfoGCHzpZyRYk3wI0avGfUCOjVNCwfkj08uw2A8dbuPTsJvjyogzXecU+KZu1sqnQt0VywM2sT0
 BPrWivl85P2a6M/ONeu+ap3KvwyTSki/cuwCpDMjI+8/C3BPVNvy6Yo+fVrcmHZ7CMg==
X-Gm-Gg: AfdE7cmA8D9MZKZS9BjvVqM9bOzdGc3CLQr02qgY2Yj42MV7GKpkWtEX9DramcHFuXz
 Wl9TQRrsyhlrq5F8fYocJOUXz0v/YSrNZUf7yP4cKLQg+xavR1yiyx+fvomE0cklp39LZ/CI/JW
 fTSatBeSbaqfd3DGRJQ9UWNdiq5ZoDhI2sHr7tJ72zzaBo2nWNZC95Yv2vNBsioAUaXRZU5mCfo
 nQXP7wI5TEnMMKrm3XHKpqEdYrQ/McflVtPv0W2bKZ643BOCl1NdQtJypLAV7TqOoxlEq9VMizr
 hdZMLCLf7Uqud0isaATKSHX+IIaAt6uXHTJvVSZJB7fyYZEO/62jzcILtHJGCh+nWFEVlKEqmj3
 c33brBdamPb04pIR7iA4xqtxmmdm+L08zhqv8LItyP0CEiGYxZ/kFAxG7oHiUL7GqxAUBSNJ/Ka
 93K8edOA==
X-Received: by 2002:a05:6a20:d81b:b0:3bf:7081:934b with SMTP id
 adf61e73a8af0-3c110163ecbmr767891637.26.1783719856104; 
 Fri, 10 Jul 2026 14:44:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:d81b:b0:3bf:7081:934b with SMTP id
 adf61e73a8af0-3c110163ecbmr767858637.26.1783719855544; 
 Fri, 10 Jul 2026 14:44:15 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:15 -0700 (PDT)
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
Subject: [PATCH v5 09/98] tests/tcg/meson.build: introduce qemu_args
Date: Fri, 10 Jul 2026 14:42:13 -0700
Message-ID: <20260710214343.2065491-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ab2B2XXG c=1 sm=1 tr=0 ts=6a5167b1 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=BgapuaGD2VAwZ5NCc8gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: -rfOBYYH2xnYbzEblrQObJY3_iCjLxhm
X-Proofpoint-GUID: -rfOBYYH2xnYbzEblrQObJY3_iCjLxhm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfXyFVmAhMbKZ7x
 AOxjcBp2pnppig0mblZ/YwkcjQ+hvmmZ6jxbnGKIQ8xnVhmTJYRJsZikypjwhNQ2uPSLOMmlxiG
 bAcn9pxP8N3M/z/rPLLduGWpvtgpHQM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX+oduk4//Mftg
 ltkSNfFW14e6EuIiky0wrs2glshH4LJzUt0raCdkktaiJVRFWeuLbS0thrBVv2K1Pd8BGPPsVZx
 L4I5Fwj+9VolgAn+GG/CofT8GojKckMohfDl3KayxotZGG+LzFwfN/6Gjs8jrPl69CYWvo52Hxj
 nMDOCzLaWkrcYIMSbUD8mn7H4pr4W9wVMMcceXi9vQSDvDkSz8Q2Bv2dpELmx5UyTIjogI/HxDn
 +e0nfNra6YE4tN3naZp82Vk/Txxpd1+VreSekRoCJ6tlcJldMXss05UUoYW8v9t9y1sZgtOv6Vj
 4NAPrXl4YG8KOiDasLIjW1tWY0Qgrl845UYHE8RAxLor0QdPN3Rtt0rvgGE1B4JLZnKQMlmIK/4
 LuY2qHUOrGy+07UDllTcQsMI9OrMgone/IWSpGv8Dh4vMJ8iqqFnaPofQAyP7Lxtes/32l3X6Ye
 UnoBms6ScADlyl1AcPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
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


