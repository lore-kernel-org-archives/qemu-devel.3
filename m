Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF86C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPr-0007ZC-Fy; Tue, 18 Aug 2026 15:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPq-0007Y9-73
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPo-0006hw-Do
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:05 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHHAGl2286976
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4M3+b78ZUbj
 1Ugec7TlMrFf/0Jevv5AOWzD7NEsPk9A=; b=XpcEuXDx8jDDI7YYt/pf3iQ9b43
 WLsqLNMEkhbiSPBesjXimIwotd2n96NLINyM148nx1VdDDgh0AG0KKecElM0ckYx
 H29PJ3wgazfezPrkGHpEUwUkW6A/nfSHbxRSp0ggzFd/pElYvw+VaFUQGwuIq6o2
 NGYEHwLyFj4o/xZ0fCqfE6pi4V1o9spF7J6UBFseTM1TfmsZE75EkQtaBCzLdQzo
 QUHyVKWelRVpR4k97OKkzv1EAYk4+hISMmYCGSL1s9tbYk2L7NZXDTNqE2rLZTV5
 AhmhfC2pJyLnN/UyBWoEZrDQdrBsYbKXqL+GoY06E/CmvcKfx5oM7I0QANA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4uhd0p9f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:24:03 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e7b87ce77so550597a91.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081042; x=1787685842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4M3+b78ZUbj1Ugec7TlMrFf/0Jevv5AOWzD7NEsPk9A=;
 b=CA7xc9sKnX30ub1hzk0TY4ix86AmTjQk5ge6jC5bj0s0e6T5VyiWfxLwJmSeHcLRMl
 Dqte+hKVqHU3G4NHfHz4VTtUfIWShBd2g+9S0GrCMBwfjdfx7PAxgZGnePv5Mk9j3RBP
 5Vg5xrKJPnpYL3yiflv2YAnFy2u4xwZ9WA78GaSBU8Bimi1goxmyNxA831uwzGELP+jf
 4QxcEvG9RKbi+X172wIiIKzGQJtaezflLJdn2y5rQUXR99SmE0YCDF8yDghduugZHFUz
 xA6nlt92sj9H5Ze7YB/fFuKmp3pgnI0+zj9xsp+xn//mo85vmB3Jtjo/x4aDdy6ki7WP
 tydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081042; x=1787685842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4M3+b78ZUbj1Ugec7TlMrFf/0Jevv5AOWzD7NEsPk9A=;
 b=n8deofXYylFtmtO7Mkyjy2Le6uyGuHtcCMzNeinpiYLvXsKm2pxChjSxPNyuCwuUdh
 p3pPVdQGN/3MxvfO41cDYjB49/6SKfqyXDjUrVOpjCv5zUckfvaYOk0lNAeeS7c5tEl+
 +7iR6UoYYosuiUI5lLG633oWbhASR/t1mHD88zyjTxVIKHhkSVU6uVX1qzEPD6tOTWk2
 9K7up2tyRDI7ZCUn31GBrLFw2kzZCFHmXzGv6wbI+JzuiROKcd8+ShU1K5KXYJ6U+Bua
 RZivwVk7g0TnjQOVg97RCnCXwKYMDlJs0/ObzWI+E4NCxSWCfjtf41lg4k++gPfR6lMU
 C9SA==
X-Gm-Message-State: AOJu0YwqpC7+V6H3WO4dG3AY20XkQTkXti4aWQqu0cpehy4kf6TCqvNj
 1JlGzyk8ObegTS41j/uLh6g4pR34Fy/LlKAmy+iRzwdqe+5uxZ5h0KkpagYo3hJlf+egsRfVFFI
 lUG+S3oc3IARB8hRnqKH6vnOcjBj/kePYBp2ubmtYDCcKmb8Q/r/aW6liQNq99aKiGw==
X-Gm-Gg: AR+sD10KK9oSK36iaxSqmFLVCjwiWh4lSg4SE0UUpn87JTdlrBsbBjOLnR0xaa/Uq7s
 XRHGY3wOBjWeSz07LYrAUxEHvOzKHyCzK5DEmcc5rX6x7lRrF8sLI0roub3XofP0FFqmqIztAuG
 WOaQ+dPm28UNMdrBUNhu9TzGOir6dAAtKSrVHjtfh48oRItegvjhHa8h1TQbiAkaSAEh0Sp2Vlf
 8Gd02CIcWV/t7MC9Oo99hRbXUqzcXzv2sAaSguq6F5Z+QrHnE4fOfjuIelcBNn0QDupkZoEWLOk
 mqUhRCK/JHBCH4dsuZN0rAmQC1W25ZwLTwsfvQTzCxWBWT/E7jq3GdG9308xpK8TgTsAlYQnE6J
 Nj0v6UhlXkSHfjvX/38rIyJ2y1FsCiKwEmCocM9hBZnwrWOdA5voPR3+qbpM=
X-Received: by 2002:a17:90b:5684:b0:395:5eec:b932 with SMTP id
 98e67ed59e1d1-3957b345e1cmr32470a91.11.1787081042465; 
 Tue, 18 Aug 2026 12:24:02 -0700 (PDT)
X-Received: by 2002:a17:90b:5684:b0:395:5eec:b932 with SMTP id
 98e67ed59e1d1-3957b345e1cmr32368a91.11.1787081042012; 
 Tue, 18 Aug 2026 12:24:02 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:24:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v7 031/104] tests/tcg/meson.build: use full path for QEMU
 binary
Date: Tue, 18 Aug 2026 19:21:55 +0000
Message-ID: <20260818192309.22169-32-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX5ze8R2ruGppC
 Px2yELmHflKIYx+5SAPJa520oTIRCg/nbS2gGv155zO9G0zFQjPWlAV+ZQIVsWSu9e1rM0HLuxB
 ZBjTBNWE47zQNR2gQph9qE4eBFocPZ9IB9788F4zsLX3qZ8dR6fHqQqHFnSTri4s0nMnFVm28kR
 /VfWxa20Uh/LSw+K3wCwRlRiSF3RxIGYVVatpEvzyobRhjaGatzOn2ntqLdd3e2I1Lxu+UqMMct
 NLbeRV1c/TORMLHjPIXVg4hWbPk8Hu2jQ5zY29HVkhfrTnaIQt8pQnr9TzyRpTFwVAQKHEFEfgH
 93bhY1XrBWmYo0hsfLJdLLaDdZ0TC7Njt/jYwSGi2+8zR/LTawo1lamk0HwR9zyp01nfObqkLjN
 qNLsjJ/DERkhf6lyrlDm5vKFsHVn4fyOrHAx0eNEfVGg84RNjQ0Venusw58A7iQ4ckWA8+GIzDV
 K8UEWXUWNNzbRRR0MVQ==
X-Authority-Analysis: v=2.4 cv=bN0m5v+Z c=1 sm=1 tr=0 ts=6a84b153 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=ke3tvEix_agMRfSZQQYA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: Rz5KInumZZJwOS1FF8fjK5cvapkYaAA6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX6udNtuW9mG6x
 OyubJgcuS+pohLE4F6qmHrB+754eKecdn6IXeAqyEBH80J7r4NB/l1krzk9O8ETJ8tfgW5xCYpb
 fqA2GduuZZ/DGs0SSyIrAuNM95oieq8=
X-Proofpoint-GUID: Rz5KInumZZJwOS1FF8fjK5cvapkYaAA6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On MacOS, meson does not find qemu binary. Use full path to fix it.
Also, add qemu binary as dependency for the test, to ensure it's built
automatically.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index ea17a947628..fe382638297 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -323,12 +323,13 @@ foreach target, plan: tcg_tests
       endif
 
       exe = built_tests[exe_name]
-      cmd = [qemu, qemu_args, exe]
+      test_depends += qemu
+      cmd = [qemu.full_path(), qemu_args, exe]
 
       if 'gdb_test' in setup
         cmd = [prog_gdb_test,
                '--gdb', gdb,
-               '--qemu', qemu,
+               '--qemu', qemu.full_path(),
                '--qargs', ' '.join(qemu_args),
                '--bin', exe,
                setup['gdb_test'],
-- 
2.43.0


