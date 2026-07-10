Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A271C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4bx-0001Om-CB; Fri, 10 Jul 2026 02:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bp-0001FJ-EN
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bn-0004jC-Mo
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:13 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3moiE3629749
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qgDk5bJD+qrhapyeWT7J8B9YDAAjEUE8te2o/fnhaWs=; b=TTQzhzUwA6J3nhla
 Z5HX0v0HdK4c2RFnSRIn0w7SaCKlCLvpk4dKidaXovYmfr3kZMrA0nvYrfef0iNS
 8Ye2uwKQjwlV6CUJa3voc+fcmZNnXzY9GKAE05e1mN+5bbb8ulZiNGAIL/CUfdA6
 PfhZ8seiMp+6xFbeGJsspTjzD4aUaXL70oz6VcgGCsSYPMaPBtiYY0xW8Ix8ubbF
 gN9BTJvI3PZnj0IsALzyAqPcFH8EumO/hW/zeQjPdmr8GArNs4lyva6eI6ViiBE4
 grHohi8g7GQGMoyvKriiJuYP1ensQOIQdUL8LviOSEI9aw5uNE1bdC0KZ/V9JdfV
 JijM9w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fahv8hww9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:10 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88e0d11a3fso592317a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664470; x=1784269270; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qgDk5bJD+qrhapyeWT7J8B9YDAAjEUE8te2o/fnhaWs=;
 b=B0bigRLy9cUaAN7JFiwaDCsHMJF1OpanFQS6zZNRfD0gqoQ7FeyeFupbsI4cFAbcMP
 5FMH5vRWUHM52Qd+KAtrY8pNkFMxyykvgqanpysgQiM4ch8Ve6U7kN2xG86wYIuy5fTm
 cgPY+iwFTkUn+WKruLovCBXJsnirrOL4A7s2fKajCucgxiaPjfmRKD0lwwneNRGyQhri
 WDyGzEK1yy4OoNI3P9jeNeESdRZr06+2OeS8zvfC/qIChpWwWJPEEfUwkzZHURFg2Xkw
 7hIvipUGHPifxzvNfVlZRinboR8f++ApWoMgEquvurLq3Ym3XzwKSm10J6Qm7Un8Fwrr
 aonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664470; x=1784269270;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qgDk5bJD+qrhapyeWT7J8B9YDAAjEUE8te2o/fnhaWs=;
 b=iitxgiQqUZx3WPrFlB2ebrG5yC1vG/gZCXpUUWkjrzz10I2+sM0b9xx1BIMxJwM8Mk
 3cFldzflGL9Dg4d47yrHh3FmzE6m/x/+qSWuKezYvMWcw2yp/A34NIKfopKFve/h2exk
 exHs+rQPHT7j/JNmdC8CT362f8v3SoUshInIzkcVlPHoSu/5XEH0KBjCYlhxz6Y9oNMe
 kTh+ezdDCKBdXF7yr9v47oHTJAQEbMFo8xYB085DdvKgRpA4CXJ9kZIZBPa02ludP0xc
 1oLr9E4ayLKA1uHHWAYS+bmX6rPGl8JYNskCE4nAEvmduYqaVEmFelvwIn5Unww4l4Vw
 MPjA==
X-Gm-Message-State: AOJu0Yy2HPgP5BfLxK9NB+6cDdckbWVsWQ208M/AUUyyPf+pAlhYbjPZ
 0nghxPLR4/mjCjCi+MqbsRN7GZ4U3xowRhdylOek6EbZg41aUhYeXnItAbaoJGab3n5MrUr238l
 cvQJMhcZMutPip294+icX5tkzI5/ZjBqvAHv/vu2S9Ng60afvyG+ut9cEBjdBOI7p6A==
X-Gm-Gg: AfdE7cljFgtZFNIwVJUpwiv+wg67zzWB9+4e0MuPuHywSIUz74ESnFfqZwqtpDGqteE
 OEGzvhHWGFwA1/TH/O8h039QTOhdKLunMckOEB7Fuzr1NaFhW8MBDcL1dG6GtkK79X+IipB7AQv
 +Anwqaj5N8zxLSx2SjGfLQeuVz7WPUe2eXdykbq1rROIA4Zm7wmT8Tn+syMszlzJnHjyMHcyy+Q
 VF6L0JP0OPg20MJeAIu2iv+Ml8pm/Xb6VPS3Mn1+v3p6WG4gW/trtVIUSZ76VmVTwSRSbKObM/u
 +YkqNFw1NWHeZgUUk91S/8JJlPSIDLwBB4IgeH19kALCsNQ3gyYxnuHl7O4NsXvQC+ph2NgmbqJ
 jmTz6r7QXrUPRH1OtEVanqjQlflVVneEbCPnW/0TiEIscv+nXiCuwAuLg/3LTEvp50kcqNq7Xjm
 gu/HBO/w==
X-Received: by 2002:a05:6a21:398e:b0:3b3:216b:274c with SMTP id
 adf61e73a8af0-3c0bc9008aemr10976341637.22.1783664469633; 
 Thu, 09 Jul 2026 23:21:09 -0700 (PDT)
X-Received: by 2002:a05:6a21:398e:b0:3b3:216b:274c with SMTP id
 adf61e73a8af0-3c0bc9008aemr10976306637.22.1783664469199; 
 Thu, 09 Jul 2026 23:21:09 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:21:08 -0700 (PDT)
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
Subject: [PATCH v4 24/97] tests/tcg/meson.build: move gdb_arch support check
Date: Thu,  9 Jul 2026 23:19:02 -0700
Message-ID: <20260710062016.1818125-25-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rBgrhch2nxH6XUxIOT-KI5OD02GU3C-J
X-Proofpoint-ORIG-GUID: rBgrhch2nxH6XUxIOT-KI5OD02GU3C-J
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfXy4oZl4IU6TrY
 HVT3rBmViPSM/Ed2Ft78/3lDhiDgi1hNXvyxOuZumeFdOLBlVo6/OZvfSEenFsSMUlm+4BZRQvt
 ZZjGYBRnzHtCqyeTAapWCHrbUYYkQtI=
X-Authority-Analysis: v=2.4 cv=funsol4f c=1 sm=1 tr=0 ts=6a508f56 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=MXgxQx-SXXr_dT3-lbwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX/Q3tOxRwCk1R
 kV9hp79VE9p/vuVKGoGNG8/JI5s6HYcREj1YYT8/rAp/MeletvOoYNy8tjkU9YBWd9LUdKv0u/T
 R7tXAL3tObvjxCH8UfdEaDvtOyohDoIz3Y8cVH6g2Aeem9hvE7K/glFaTIv5CxX15OLtUvTkMn8
 5OwKGmQKUVZFycxpYqPvggsec5rrfVgdq6fHnFhNhfGGIHxsT/PiDQ4qjeE+DGIJu8vIE/SfmuK
 Nj0/d4fQ0UjRWUWA0Yt4r9p0dMzfnWbxIZjARfqL5REy1zYz5N7S33RI+Et2xrUwTqXpBaQgBsA
 gXHnoMOU7unc3TCLTUmbVJ2BVO8KF9lI+ZPt4Lsg6laVPp1aMiOr7OBcC2WEmhjG9Ap6rlrvXJs
 QkrFOh4yaR/GX1BjPvqwBF5gwnfodeOPR8dwB15YpEODbbRSEttAz5a0TdU54NT3VuENcT7CKAk
 5otViz1WHQE3KwfUKWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
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

This allows to report the correct skip reason instead of saying gdb does
not support a specific feature for some tests.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 993a948bb80..572003f4ee7 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -138,10 +138,6 @@ foreach target, plan: tcg_tests
       # if set, we'll skip test and print the reason
       skip_test = ''
 
-      if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
-        continue
-      endif
-
       if 'plugin_test' in setup and not get_option('plugins')
         # do not use the skip_test logic, and simply ignore the test
         continue
@@ -284,6 +280,10 @@ foreach target, plan: tcg_tests
         endif
       endif
 
+      if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
+        skip_test = 'gdb not available for ' + gdb_arch
+      endif
+
       if skip_test != ''
         # still declare test, but skip it and print reason
         cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
-- 
2.47.3


