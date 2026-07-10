Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1430EC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4fm-0007RF-61; Fri, 10 Jul 2026 02:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4fk-0007O3-Kd
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4fj-0005jn-3i
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:16 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nDrg3752753
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q8PkwRY4wQvuBi8f/fYPjgfggVIttbp39N3SRCXL6JQ=; b=Fp1YFfMb+TnzSmru
 zwgKwSdKa5J3i/CLxGcsViQYI8C4fJ58xElm2kYMEwkZr5SvCu4GE3U8kUdCQFnw
 zoiK/Lkc3azs6bQFYX4DfdU+qee6tLHRdn+xxPeX+/2ovEZ+3QYdL5lLDQgGDJCo
 1ueCwemDA1WIUEb99TQF6gCXKuQvahDJGnMJBzLhh1ln9yMPi2a0+itWgZL+db9V
 qQU1PZU1WT+CtALm/LsmdltbMBzCg1I3Zp4J23Sr2Vxx7npXDb5hhha5ZlbQwWrk
 xdV6SPqKFbh2Zb8VTWMwMktOJJs4+sqnk0zbcU+EY9uwmOM3n3jx2K8jXuuQptBv
 Mly4Qg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvjba74-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:14 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c892143db7fso586406a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664713; x=1784269513; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q8PkwRY4wQvuBi8f/fYPjgfggVIttbp39N3SRCXL6JQ=;
 b=DIvrz1IJ2wHj7ofMwXIC+nI7dIQUuFyj5USqV8oYjtZ9KZ/vszfHl/ZJ21EI6ocE7G
 wIXt0Aeb6OvrEl4uFanl6X8zClI50hMmTZ96girZP62RjGm1Yc8B4Q+f9n5TAvyhiMbR
 kTd7CvMNo9I/MiW9wXd2ATohDvNAOKQHPk9hj5liHkod7BSlwJ10cag5tVWAyZzDGFQ/
 zB4QMsEejk/v+rluiT/UV/leWPTt01qYl1oJS00ycKLVtqQnjj6sqnprQqaPYpp4IC4v
 RLG7NpWfYugqpI73UHFWHCeieDOfehr4XDFF+LWuJYugS5aoPKzVCFSyOfRdv3jYTfL4
 OCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664713; x=1784269513;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q8PkwRY4wQvuBi8f/fYPjgfggVIttbp39N3SRCXL6JQ=;
 b=N3Qmy5IBVK4LX5tM6P2q9yPlX+d3pMg18C64o3pheKJRT2/DvvXM5jgAw3anGUoWq/
 8dnd1h4yqo0QO0nRPkJmIP9Vsho5vVRAoeg1wxTcirTtZ8kPFld7qiGertNXNLuteLca
 wG9bX7bLekg09QI/c4h5w625DiT01ORUYLLmZN40D6QCENkNI5/hrhtBD5uW0/fd9Ucu
 icEXRVhjnRIGmoAN4wHksJQUD8L9yXE5Z5kAKqSRmHiLLnLnVij7Cg15CdJ3kzouKQk4
 /9nCsssXBK1e4OlLuF/5jZ0jyzHMOcTTckamyfpcu/xmY1OwxgRkRuey+AQLNInyJiRs
 5J+A==
X-Gm-Message-State: AOJu0YzZTWi7Cz425dWI2n8rIyXLlwoZoM2YHI+bBSIjAs/0ThsOVa/V
 n4FeoasTkbDsBXS2uZ6t+F3fjEnzvkfnhr2a+BNfWqT9NOYCov5xEHof56u004CFwuEmpffOtbU
 KdWubgsAu0T8JlvLc2m3GZxV3VId6wievt03Y1TMelG+xHDyhGK8O/1dFmnHRkldu5A==
X-Gm-Gg: AfdE7cnnHD2xnLOuUgkQqRD4z+td9Qv5+cygdR6l8z4M91iHMsUifZNULCmfp5oC7xY
 5n5rJXH/O4OCmYlNb0JSWjescV3ZjIKOJxF8/af6K/2aIRVV5+R9DMBicoS871Ck+AQfN4rYsfT
 L/kY/TsgXXRr3A0e1IDKYLmq2F8ERcFIfjQr8rS9VBmgOX7mqX6fI0KixCn9rWpU+qNwo16jZnL
 EWQNwokwA8c/w7zgDgDGYvZkFEdFB2pgDXG6P39tUjhERLRC/f/eYVmfPNf0SmyeYWUVM4YGvdO
 lnxu5Sx+/9cyAmzGGYXT5Dj66+nCGQRV+nnzUe2JDLe0H3GkK875oB2P2+ssqzSLn5q2VzVnSBp
 QbPzlnjtb/sbnsfcJdmRRsUK2HkYcQnU7CBLAlv46A+gXXEkAm9nGCFw8TSu55+ILM0Eht7ee4c
 cjFnT+Eg==
X-Received: by 2002:a05:6a20:7486:b0:3c0:9c1a:894c with SMTP id
 adf61e73a8af0-3c0bd2ea843mr13213535637.68.1783664713204; 
 Thu, 09 Jul 2026 23:25:13 -0700 (PDT)
X-Received: by 2002:a05:6a20:7486:b0:3c0:9c1a:894c with SMTP id
 adf61e73a8af0-3c0bd2ea843mr13213497637.68.1783664712725; 
 Thu, 09 Jul 2026 23:25:12 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:25:12 -0700 (PDT)
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
Subject: [PATCH v4 46/97] tests/tcg/hexagon/overflow.c: add missing include
Date: Thu,  9 Jul 2026 23:19:24 -0700
Message-ID: <20260710062016.1818125-47-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfXxJjoNdSfl/uu
 e8WTHwTBCy+Z/txDfUfgKepwm/BnOVHMn9HvGCbqrTmzZbRLNTZ1l6NWH870l4VHpdGY6fBjAQh
 mGLKWuRJuSkrUu+qad3+YTD26QM8sxJ+Pq3kAWedOwUnvtQMdK+t40FZyc9GNkuTM/ygKQhSr2+
 GTrgk9lwkewnxsjFOwa4kKYZ4hicQI5wABDccQAIXFPHqj8yEGI6cuL6tjfocHgwUoEQEpPgMAs
 K7qlbjpAH99rCccId6FR/l/JhWTMbwwqGSLK6uMqWj4ZueQe9VxHxdKWBoZIHoEk6l9j+KwEeLU
 bei0yxnQWdGdoGig8GMLKLdpZ/nvqMLh7vDcmy8LO2DML5uiEWGZXF0+0cYxNXZsbD/4PHUsBV3
 /qhFjYrsn3j/m2sQ/wxLzNQQn+5KTkhwJo6ndLypQoxvUi/WZvA3WAWulcrAL1ow1f0fYzYHLJX
 vIzB6yfM5EwHJbhgxfg==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a50904a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=mDV3o1hIAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=27jwiZK16oKz2i4YsWoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ukSzKFD-n-cKF-OoHv3fjh0hWyI5pHpp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX3JmaIVO2NxP9
 R1/Ck52E4xMZ0yp/WcUo+HCSoVBlZsZszuRgHsGsNqIfcgyOcjzRY7f6FsDIItZ8iFK5dvFCdvr
 TpR+6+a0kraSnGH8bgDVXZ7/0VVgwQo=
X-Proofpoint-ORIG-GUID: ukSzKFD-n-cKF-OoHv3fjh0hWyI5pHpp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100059
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

../tests/tcg/hexagon/overflow.c:59:1: error: unknown type name 'bool'

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/hexagon/overflow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/hexagon/overflow.c b/tests/tcg/hexagon/overflow.c
index 7b5b9ebdde6..9ac2d6eab62 100644
--- a/tests/tcg/hexagon/overflow.c
+++ b/tests/tcg/hexagon/overflow.c
@@ -15,6 +15,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <stdbool.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <stdint.h>
-- 
2.47.3


