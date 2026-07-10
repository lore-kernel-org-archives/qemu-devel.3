Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB87C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4bq-0001Gr-Kn; Fri, 10 Jul 2026 02:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4ba-00018R-Dv
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bY-0004cR-NK
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:58 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nUA83900260
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /aqqmUfCJOQenNYpBa+QWj9SY8sxZjhEK/H75HHQycQ=; b=U1twuPOaU+MwmrcP
 tXDUTXtPX4HLAAVvwwkjL5Es4wg4UD7xZ32GBZDQrDl4yDDOGndRmaTqplx7QVN4
 0dIm1dW4+wHkkfSR/KKVVb9h8qYwpTthfLiJKyt9hbRdaLTVzQnsMt0wYLc+lmLa
 QPw6nHgXpncT9g9vn+WeeJLfLCXuiq+qi6FQ4gVdNpNolMX0xKqj0hBTLzed+Cou
 /0UTHf0uvof6ujbUZEpk6rw+gg/VG4pg/wHi2142JDeqF6cbvehR0UCLdIJP/Buc
 tkmIHiTOV7SphiOcn//oG+lxCmdej1HAwmlmG4rtkkQJZyfVsD6ViGXx8bQp5/wg
 58T8nQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg3k3r5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:55 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cc73f47bdcso9669095ad.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664455; x=1784269255; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/aqqmUfCJOQenNYpBa+QWj9SY8sxZjhEK/H75HHQycQ=;
 b=hAWIhUtCpofBsq7HdMislmipY2FwloAd5voHblzaxAgbFHRBdxU3denpst1ReBaz40
 p3uVu+WCMFghAUvPoltsxIDB+0heh9U61YMPxrphkN9VT7AXIyB0I3MyL3EbxTSDoU3u
 bnuqGhaXv/3H1Fk7dFI0FCW1t4LihsItw/EdaniL/EFfP/qb3+l6sPpRHqpneLrMMdbP
 rJDXKRMewmrnZGN0IRF4MVW3ySF+nYFlb3uQU/ccKPk+FMgwY7NHi2KYPkrd8YL5ITsG
 e9kJ8S6I8ktuhs3m9oA/bYXN3s9YiPuzKJV2q3pBBn0gpRnRbo8zQUDWr//+5A08LQeL
 sX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664455; x=1784269255;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/aqqmUfCJOQenNYpBa+QWj9SY8sxZjhEK/H75HHQycQ=;
 b=YAr3BnBXClHRlxR2bF7IPfi0ZXXdT/TdFvz+jEk5xlCBAZnsZT0vKVdCEeVwyE3Z5H
 +GowBA50kD1BgS5gMKcZKSFWebfMqQFKeujnRkWlDE3KHy9f4VkQb8FRSkBQ40f3qwhp
 /BzfcURH3yahIH+4RZyKX9K+wPGW5Su3wqu+bQ1PeqJ31v0AHWd/M8GVAnmSIhnyalPG
 ohlIXkRG7wukdOoP4pyce/yNXz1duYVFsIGArkhangpydRcRJJPVmgH9HpFmYLjjHZ45
 eOtvFuT6sNcHEY9wh5pAIXAbJctYYBdrM7otuDl5O+greQOp1qfpjHLAF6GOsfVP8Z0k
 hN4Q==
X-Gm-Message-State: AOJu0YyGWDLuJ1Q0AOvrfz9AXDTGEGInocTXCmyiIqyfi28EpSVVTY2p
 7eMGPJcw8zHlLi1eKIkVLRDWIehaYcgI8ALaXwKMHEKyu9hAIJ5Y8ACvMjIRc6Ri3U/iTStqUlK
 8kXCRImFjZe6fygOlvjgRTWatyV8GYgx9Xi3Rdp1WGyJ6RetuLD4a7glalcg7Z4PiVw==
X-Gm-Gg: AfdE7cnC+ZDEkc+ZYSjZxWzeebAsU3iCh+mR00x6O6zDD86T3Q2kggmW62+NXMQfc/K
 HmOQedh/2KbBV/V3HIQ5x1BmYMVJauXOOy4E8SEhmWp6VDfQb5LVTDIkKbSD91MaNGvHYlqfDiS
 jdAhf7Ae6pfiY1xwlvbv115EyQfD4aqWHGio8GzF18rq5DO1qWzczPj7krR5zWkeC24w+H7TC6f
 f7ZH1pqAuQqBPvcQjUCO2cUb9FlT6HN4N2NKX2br0HRFPu5shb0rMLZrfzkoHXQSQn79UbeqjDL
 KeVodzhH3+4R6V/YAeKX6AwCEcIu5o2bUE8QNHU1m0f3yWtJNfEgbIrl5MKcWDb6JsCVeu6Wsk2
 k3O0nlhFWuj3sQVCdvYhOwIOWCs+829eBwvLVTPzcXmZo8cTlVdoTKzgyVfqbLft6e+XeDJ/YFy
 j+59jXjA==
X-Received: by 2002:a05:6a20:12d0:b0:3b4:6f7e:d0f4 with SMTP id
 adf61e73a8af0-3c0bce18a95mr12553757637.15.1783664454504; 
 Thu, 09 Jul 2026 23:20:54 -0700 (PDT)
X-Received: by 2002:a05:6a20:12d0:b0:3b4:6f7e:d0f4 with SMTP id
 adf61e73a8af0-3c0bce18a95mr12553710637.15.1783664453920; 
 Thu, 09 Jul 2026 23:20:53 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:20:53 -0700 (PDT)
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
Subject: [PATCH v4 15/97] tests/tcg/meson.build: introduce wrapper
Date: Thu,  9 Jul 2026 23:18:53 -0700
Message-ID: <20260710062016.1818125-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX1/IeCwRmmgLy
 J1L8yAcA895qdSlEloq4IGpenWORac8xMG6ig9OL9kwMTy00hOGvT8jL63+lWMyB14wcauGzU/q
 3zjf//K4D8h5v+5LKzHkY+AKOUX/hP+yyzckANkjDSCgbpDGiOmIy/fkxV0ZwN2Y1ezv/pydnzi
 R5mwF4JsFncK5oSC6q57XTpbl8Mw2LWklVQxbdan1ccubrinfAgChgepwVHGrWgIhpokMfiQsC4
 onP5Yjog3GA99m3O3rtgH3ukC+emk6jyYRSGqRu8Q247x8o4OH3ewTfJcCy4pxEtOcwci9MdVbC
 jmcWRME8dP6bIJVX8rocW4NLrT/OTZK3A7wCzJfxYScUgOVGNOYuIA92FZH2K7T/Ja51+FbUNM2
 6hbS7FJcEo0cJzerZJE91QP544PXp0FaBy+Aoh8To6rwXykOhV2Y8fSPIIxf0sF5wha24JogWW6
 DEhU6pep9QUBwf20/oQ==
X-Authority-Analysis: v=2.4 cv=ZcMt8MVA c=1 sm=1 tr=0 ts=6a508f47 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=vz2bFB4F5KyvM8IiXWkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX5mI1OoZa/uRU
 TwYlk9SAL0xPGJD2sEWXV283yQ0YwrjNvItyRswsBEt1qk1tTHn+YbWtyCisLWOpmZOfkzqH6W0
 qXVXpvuml/UOtTOyZAJMYkwBmqKA6OA=
X-Proofpoint-GUID: J9L_QJKMWlhCzbhjHS-T83bSQ57rDfNI
X-Proofpoint-ORIG-GUID: J9L_QJKMWlhCzbhjHS-T83bSQ57rDfNI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
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

We add possibility to wrap a test command through a given script. This
can be used to provide any kind of ad-hoc check for specific tests.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 7b439ee027b..9845c59f108 100644
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
2.47.3


