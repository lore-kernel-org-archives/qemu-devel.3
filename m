Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464B9C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPg-0006hp-B0; Tue, 18 Aug 2026 15:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPe-0006gu-6h
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPc-0006d0-Hq
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:53 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH1H11006317
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jXEfn8HU1bsl+jhD9MjbjXqtYGzSg0NykruK6LyfA3g=; b=is2/+BQU/5rZUZpa
 yskvNT/smGZI+naKcaHk9F9pklNZfWXbwSiNpjXmutTtxovAYAtsvNFmS7Kpo389
 YLag+f832QQ2bX1Yr8ZnzvIc0QtfKG8skQbmqI+cmTZxLYv8y2WdSB2Sgj85dzG5
 p4w3xY/UtVFaL03icS0gGO5SgRnxvOKFqCWhTSTaue1IBDyzi7xy2fGMQb6kOi7Y
 OaW/xY5boBfi7J7fz+DPLckmE3mh0boD5/wuHtgDUjDPYWKWBanJxyc0fJpWWhw8
 kLhl2u/jurPm/h5sfYg85yhL3RrPMpnmpmCfkM8MkHJJlJesQBAHOb0PMtVZNXFl
 CfX+Eg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4tkmrv61-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:41 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cab048cdb3eso162337a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081020; x=1787685820; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jXEfn8HU1bsl+jhD9MjbjXqtYGzSg0NykruK6LyfA3g=;
 b=YWSwuwWRGxNEOzMeBSyt0MVzadvWeA/cdpNxQlTx8jmLvrg0T5qqKZ03JssCsqWOjy
 oUmnp0qc6YJFZB6HA/4WX8tTMklwfbHE3O5Z8HjfANm/KQdqRxr85v/mUGk+AXmCsFvc
 R2rOLnBpbVfZRgsHHhNhGhDfWoTGMVCRtt7OFDSrmeu59O1rZgtPLv7R5lwrtOXK5RKM
 jv+jZWV6lA3zpp1cUgA022YCMpCkP9Svuwug7IRJUVm/oGYSW1+s80cmqyg7rkTxiKVW
 vL1u6U01EY5TLuL+4nEFOnxdT4TXmdzkt+wPgwsPAqGX3xBK20GVZuf7KOIhvSykV/0l
 sKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081020; x=1787685820;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jXEfn8HU1bsl+jhD9MjbjXqtYGzSg0NykruK6LyfA3g=;
 b=Poe1B2lrvJsGyx8ziVGJRIRIUtgeMKWTzRKe1ij27qy4xLjxtzeyasfJ0oArodqGAc
 2XPvVwhiVfpafaU2+jYJWRjJellpyX7wf8ltqpRRw8D0HSKbReUlSXdg1OgMxqOPq8GL
 OCBzzqs2LR0+ghjk1AchXgWlHiop/exenzWOzR53vZVtPRSMRMP528TXr19CDtR9lqMQ
 rafEOcYe2E55B6gJee1yhR+WnVFDlArJR/Uu6EGFhwChMhDaBqZ9eVKUKqQWnSLYU6yH
 +tPLYWPYXwb3oohGhF58W+1NaPaIP6QNczN8h+Ip3r7z3Zj6Du6rD6ZznHBbIwJU0WbA
 pKfQ==
X-Gm-Message-State: AOJu0Yw9KWRHqt2hIlQ4vIQsmhk14CBYGqri/3jOUj6xBq1ACeHH0PXE
 VcdLZhn7gTLm7uaUtiDLCFQgXKztbBjDBmlBYbqzkG6QsfkOi5XliXePh9q3FcJKfhVMHT+VLSW
 gSE+pJ74k3n7ONMOD4eMeq7vZJ50xdnEBUloDC9mrUOgHlbJZUuz8lIyiNdWGDDjOQQ==
X-Gm-Gg: AR+sD10z5zKo4y4bfj4OtNP5K8d09gBdgJyBtdGI+lF6pPsz8+tvYXj033Kc/zfv9Hd
 fBQtUkqrROnemEGbjBFioCqeY/hCFy8JmpyHQLOuw91RuatzSH6gjqIblKN5GzMCz85HMRPBanh
 bTofcHqwkZJAijjclIk7p40g8WMwAd/J1ctU6NWRg1XzGUxN4g2pE4Pq25uME1ppqbm+7mYbJwD
 UDC8e67VZNqATrV1jGWOzDwgtNPNX5S9p/FxHzphJCMsWwWO0ePtR+DJA+G/97UDLN51ZzCANgc
 gMq09Tjb2hjEJ2vLwcj0dQOYFRADEAAy5euU91HjjrHE/Lews1GBQDj9e75hlXK/jyG/7U27uTA
 I9NZejtdX/wKJoUYz5PrnaFkO+xHV/shqLRFbOTYvc8IeQB3fnNMwiwCaZrs=
X-Received: by 2002:a05:6a21:7303:b0:3c3:9993:d5c3 with SMTP id
 adf61e73a8af0-3ccfedd048emr265225637.9.1787081020104; 
 Tue, 18 Aug 2026 12:23:40 -0700 (PDT)
X-Received: by 2002:a05:6a21:7303:b0:3c3:9993:d5c3 with SMTP id
 adf61e73a8af0-3ccfedd048emr265157637.9.1787081019656; 
 Tue, 18 Aug 2026 12:23:39 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:39 -0700 (PDT)
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
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 015/104] tests/tcg/meson.build: introduce wrapper
Date: Tue, 18 Aug 2026 19:21:39 +0000
Message-ID: <20260818192309.22169-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX/1uUMSnzNbmk
 sEBdXLcRCYhj2rCVotWyyxLcYGlZb0kgojtfglI6raCLx1Dsjcsiur6UmpCEquS3AC7806Nvbut
 VUCv+3bbpHjNbeQ65Xgop6GjrWk6NZJ7XfNeyr1GEVTqqep0nmX1KY64tpV5z8u3+zbDtFuOCgv
 py4UopC90U1S+S54QXhRFS8RuTFYJTxQpHzrpaykVL0fmE6TYY5CPqDoj3rEqjwXE9FZDJ3bCMo
 0thaXC3EmbnBNFIjE20XnVGmPUkrC405fnQsR7K6r39yvNwj+7dXF32w4vkpMkhWA52DHyMUXY/
 d5ObWasVFDUAqC6B1kD+gusVskhOqPVIK1/pRgoWEnr1sq0uD2l/l9XJ9qXV9nNtSR7Q56yh3wP
 RQWoEQuzb7L06xoB0kVy5up63ONxMCy5yueZ+Uqms+8NvCNVRwCrMiUuWwJrEQOncUXAhXo+2Gz
 rVFUoKW3Yk51wguiK4Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX+izONRAu/Zdu
 RfzXahuJWKSjsfHLOr81V0m0uVwQe6u3CkWJ+pcEExDypXKUaCCUubC+/kZO4Vpjh5H1Og+ZMfj
 10Zdhf5cMHzAbjEPj0QPKRautfpasdY=
X-Proofpoint-GUID: Obu8P1-DWQRQmQhqMuhx2GcB9QNBFx13
X-Proofpoint-ORIG-GUID: Obu8P1-DWQRQmQhqMuhx2GcB9QNBFx13
X-Authority-Analysis: v=2.4 cv=R+Mz39RX c=1 sm=1 tr=0 ts=6a84b13d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=vz2bFB4F5KyvM8IiXWkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180142
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

We add possibility to wrap a test command through a given script. This
can be used to provide any kind of ad-hoc check for specific tests.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 76375615d0b..0311b2432e4 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -25,6 +25,7 @@ tcg_tests = {}
 #           'qemu_args': ['qemu command line flags', ...],
 #           'gdb_test': ['gdb test args'],
 #           'env_var': ['VAR=value', ...],
+#           'wrapper': [program_to_launch_test, 'args'...],
 #           'plugin_test': {
 #             'plugin': 'plugin_name',
 #             'args': ['plugin_args', ...],
@@ -86,7 +87,7 @@ foreach target, plan: tcg_tests
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
         allowed = ['exe_name', 'env_var', 'cflags', 'gdb_test', 'plugin_test',
-                   'qemu_args', 'test_name']
+                   'qemu_args', 'test_name', 'wrapper']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -200,6 +201,10 @@ foreach target, plan: tcg_tests
               ]
       endif
 
+      if 'wrapper' in setup
+        cmd = [setup['wrapper'], cmd]
+      endif
+
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
 
-- 
2.43.0


