Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371D2C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrtu-0003C0-VJ; Mon, 06 Jul 2026 18:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtO-0002jv-8D
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtM-0005b6-Ko
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:21 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE6M21626349
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zPWXo0zxg/Ydu+V02OTrIkRiGbYnykVeGI/M3igllCc=; b=ALiTf5EUMmfDcUSQ
 ZT/9cy1Sa2sSBxAjNUn7iZZu2EILI9/0bQdYzBnAsHj3eMU5jWEJkAUd7wOEu+Xy
 nJMONHzJ+bBzzBFLeq41Ac+XVzuLHYhqg6ZxffV4Kot9Bdnj8IDsriWgpxv+NB3D
 FaBjA4sn4qqGD5rx787CBniWIuUgkCqCiXzXAQa3pMz+BPxz7nOx+EvFls1ymC3m
 PFyIwmmqddq9qns/vOADsaV8YKjrK5vtCGHJhtqnnzxHgPgY7eUN8ULAIYBMO7+x
 NtXLUAn5vxHXTUzHY4rjOTiU3DAhmUJgN6CtmEapyE1L4fidB4s/0ff2HN4+H54C
 zMIslw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h9bn54-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:18 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3811ae55313so2935028a91.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377257; x=1783982057; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zPWXo0zxg/Ydu+V02OTrIkRiGbYnykVeGI/M3igllCc=;
 b=FWz/t2ePo/q3X87PPuERfSSoNZSg8EKS+cyzwr9BHrtMszhDKscIMIYcgCdkWuNhpx
 QsiQnfItkAL1pgMwI7ZZ48AJb6Cd5EG2jbEO37XeiontR84FcJ/pc3f2t3af0x6zc6AC
 beTQ3UBXE7tfhHTbvVPEnN04q1t576qjctzjkZwJjOyLvqQ6geR+60w+BsldSirqnFOr
 m89XaD/8PZK2jnX2/2bAJV+UsUbI9PGcN0OxpJPoCHDaSnhbXSo7PXxUPHxlDJTO/0ko
 Xck50JR3CRV6nXHFdEaqk0tkpt1QonweGEOvEsceagCCzsRaDxEMdIxhSsRO8h26kvsz
 tqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377257; x=1783982057;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zPWXo0zxg/Ydu+V02OTrIkRiGbYnykVeGI/M3igllCc=;
 b=E7yTKuYTYDHQ6V7TFNuwLpeTCBtxXL6XuQ6cnogIgWFv6PP1fhBwd1dEDjPpB0DBzO
 k+cPAPQRn3umiXNzGTTPtzRd4yqPdhfSwqVN9oJF8+2uF6o4TxlVS9R7ylkraQTno0c0
 cth9b07aAdkfACkCbhrdIk3MTd3/6Hs8SGL98sgzQC8YDQf8qh6K4guITh3b2iDDUWUy
 0lrQSPydo/K3/C8xqRvENB4aVX8wawolQiQil9GUUYrfyjygGz4w+/GpIU/8pH+CSYlp
 ASxdkXkqbhfAKdV1qkTUBLDLXoUFuH76tJAi1R9v9MKsJPves+qqR8CcosTV6/dQwK7q
 lYLw==
X-Gm-Message-State: AOJu0Ywe9owawaeJZ7+q3sFscGnDj2im9C1xfA13TmkOiYdR+SU6dsf5
 gjch8Zv0YDrQ485KhwlR2dmytVSGQoL/ghf+HxK1z7GK1VjphJ2diH/XAMCsOf5E8HJzM0446XC
 qpGV0/cQf7zxztWofJQfA8sFH00TsPBKePJEmxTT+PW6WjWvhlOdP0qVfXnYUgCp6YQ==
X-Gm-Gg: AfdE7ckfWZL0F7rfXb8rIawz8UVgutfgufcCDyzgC5vb/FejlTO55pUyp0IWFhf4IVs
 Jc5tYqiua5YTnwclh0UPFzZcenrKAjSTv8GnYqxxqdtVNz0boEqO5i4/5/eCiUpSpKngMrBgLO6
 nd1cGBvS4rxjQD5/uofOPGt+3qnIOyot+gO55ddohlSq1x9S5IgmdHRKQH+xBlpQnInkzCPlK37
 LJAWNd1DLulpB2/dNlN8nmhFL5r/zx70EeasrLGZZARYWqWjkUZ64CYeeo0TWnHaGk1L3Z5IzLJ
 W/FvsG+JGq8FozmkUlVfQOINs/oaP5SJFDipeX3Zp71x8UoK1xbLRIzqx5WhFqJTeGLjNTZXMTq
 NyPzXwbCCb825Ah/TL3JBrbp8ZjEURaDk936xKMc6lhNYAh9YUCrwqwdtJvbt2EnxTxFxHt3RO3
 +dSpwFjQ==
X-Received: by 2002:a17:90a:c2c8:b0:37c:8628:f79e with SMTP id
 98e67ed59e1d1-38756ce1500mr2569419a91.16.1783377257290; 
 Mon, 06 Jul 2026 15:34:17 -0700 (PDT)
X-Received: by 2002:a17:90a:c2c8:b0:37c:8628:f79e with SMTP id
 98e67ed59e1d1-38756ce1500mr2569372a91.16.1783377256713; 
 Mon, 06 Jul 2026 15:34:16 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:16 -0700 (PDT)
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
Subject: [PATCH v3 15/91] tests/tcg/meson.build: introduce wrapper
Date: Mon,  6 Jul 2026 15:32:27 -0700
Message-ID: <20260706223343.988769-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PB0GfG-dlubmzw0DzZlXMVlKCf4dKUmj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX2F4IvwKd90mv
 +ciHyglqG5snow2E9LEVkiHCnlk8t6FwE9kp6FGm47oLHvqP/aQ96V4Si4xlIbpedVovNuqwY/K
 8iFGbHhwGi1lob24q9jQgtoF5slw8nI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX8l3fRnkz/U2b
 Poj+qbwxiznJVZwHIBWC2PQR2B9FBlFq209gVtMXnDxzNbYtp28dDSqTUNR0C7uzN1koVf/A3Hk
 221BE4nr2Jx+nh2JbDC5KpxAaqB7JnC/6o4ZVkJzUzgeVMbMyh3KmYV5Mkp5cz58ahfdaX3HtYV
 ImJuFK8wbbqfHSNn0iSPRPjLv1QvEFR3gA7F8UWFKy5QvY9P4Lp7TS8aYO0ek1EdwZuCuM3stV0
 yG8aAilUY9WzxJymUOBFDgjgyfXzPTxUKop8XjInzNn6nuZEWGWEm3F8Pa70Y3Jli6OOTGKZUz0
 NPS99SySy8At8H9wqc2rJr02SzIA5eOie7YfhUCm5fajm2VB2s4HbJkaSURqVT6dOZALaZaBl3z
 Ivjlnnmd1qysa4D6YuWzePkh5kH9YUPtS7/Ga2gNknsEB5QJqQG+U1yQmNa63God+r1Na/pcYIm
 q2jQZ5cVmMjTFWcbBYg==
X-Proofpoint-GUID: PB0GfG-dlubmzw0DzZlXMVlKCf4dKUmj
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4c2d6a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=oeoYDfJPrL2azRNJ8Y4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
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

We add possibility to wrap a test command through a given script. This
can be used to provide any kind of ad-hoc check for specific tests.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 7c20f97241f..2106f5d979e 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -26,6 +26,7 @@ tcg_tests = {}
 #           'qemu_args': ['qemu command line flags', ...],
 #           'gdb_test': ['gdb test args'],
 #           'env_var': ['VAR=value', ...],
+#           'wrapper': [program_to_launch_test, 'args'...],
 #           'plugin_test': {
 #             'plugin': 'plugin_name',
 #             'args': ['plugin_args', ...],
@@ -87,7 +88,7 @@ foreach target, plan: tcg_tests
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
         allowed = ['exe_name', 'env_var', 'cflags', 'gdb_test', 'plugin_test',
-                   'qemu_args', 'test_name']
+                   'qemu_args', 'test_name', 'wrapper']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -201,6 +202,10 @@ foreach target, plan: tcg_tests
               ]
       endif
 
+      if 'wrapper' in setup
+        cmd = [setup['wrapper'], cmd]
+      endif
+
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
 
-- 
2.47.3


