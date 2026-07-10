Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E15C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ5d-0003io-OJ; Fri, 10 Jul 2026 17:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5W-0002sd-4b
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:48:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5S-0004oe-Ez
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:48:49 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3GKt1892898
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q8PkwRY4wQvuBi8f/fYPjgfggVIttbp39N3SRCXL6JQ=; b=c8MmsA6VpqJdF9i1
 XlcR8mBo6KrXY5jx4V68AAOvHYxK5y1M1h2g8wcMrJjn83q3Sao4JgpESw2jegTb
 7e5GZmU0A7isO25qEBfan6cv8ciWHhl/W07w8lgU1RUKeDXVPQG/DCJAXMkP0rjf
 R4Rp3NqaKVg1GJ3CGVU/jO0SlEgxGVIOvGJphZ5Tp/51AEvONF5WJrSBUu6hV71P
 keULP7dpjFGJ24Fw+/EakNgtCHv7ZTFEaZs9LsvaY+iNVybZMf3gFWNo+S4lMYf/
 Y2HkOAn/nQb+0tuUGfWhpgToBmbp6jbsHHxGsh9DO9IuJR5SV5Ur/Gq3Ynl3v8Bx
 IvqhCQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb3xvs33f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:35 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c9d5a5b63c5so1983941a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720114; x=1784324914; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q8PkwRY4wQvuBi8f/fYPjgfggVIttbp39N3SRCXL6JQ=;
 b=Dk6mOLaTD8dsdkdaYofjL3j18N9vMV9+DmNu0GfLX8iosqjPFvZCT2dSuhqOBVMFqQ
 RP2KcGILPc4RfW6XPmKvV2+D0LqMyKX6N8bpeu5T7CgwAsi3mGDqu+jrFYxFz5yWlsPX
 5AWHOHrLYoJtPWkwIyNRYF07vQGI9umtsaQzdtvbdQAW43qhf8Z8BPrjg77hN22YcTYB
 vbWpwy/kIWsTuvUTZ9egmGv45pUY06vB11xeCcn0b8TI3AXAE+vmyVFNs/tllQq5ULIY
 hGvmv8fErNS4ij/Tl+9Ic3kV9C0r10VeyQ1mVcjLVj4f4X72jRm9NvH7auS8LZ9cGlx3
 tBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720114; x=1784324914;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q8PkwRY4wQvuBi8f/fYPjgfggVIttbp39N3SRCXL6JQ=;
 b=KECD3KQPHzrJG2P2W3yv8LNF4EHvQjVxo86gCMP2KUzh82T8jTu5OdY/xtmYd/whKJ
 x6v4e2DYkUs9JAxL9/b+550NVX9gatLib6+jZCQdL+EyfHjHvggr2Kel9n/NudzC0w/R
 pZFDREd2RxG0wvIL3Dl6FtkBL6eKzmg4dUOkEctkTTfdjmrK0EFqndLw5AXsjA6sQS+T
 XhtLC8Y12QYhL6WKe/04i2Sc7pAbm8ZqrwvycRpAknvc0sZP7fiwMX9A+7qc1PGljSuK
 A3FGC6aCFAL8L0+EdhB/QXGZKnIG5BpeRdlGUBswQTHwTGpmM1+cCF1+hmAu0Fmj0BHh
 WQsg==
X-Gm-Message-State: AOJu0YxRpK5rGQFxa3/CNbdOdkQ3NDihsB55k9RZ2xF8h5EiQzuB8HV8
 wU6QQhgtuS7s8aS+QKBulp/p7cys25sj802xX5cDtJfQPO2kWZ5iGxikODJdPC9OGRbidgFEyeJ
 fo2T5bUuoZ8xuayOqzQAnzuzL9pxxZvtuhJOU6LesbpnAmYuGToaz+vILC1W7Ifh1kw==
X-Gm-Gg: AfdE7cm3hTHQxbR83I5Qa1N0TbAH8lyZgSNExRR0aRzOzz6eHSCghLCW+6hAzB9+4yP
 nQ7ulEudTPkJO7QejYrxI/yKszfTmwSd74ZNfoXzzLktQP7EdLhBe1DOyNo7RiIVly0DwtmFMKa
 K0wEz1e1WsJcJxQQP/Nl1uZde25qz9AOA1FVKklaOXPzJw/WShBcsndYuNAhVFpFKR8KhqyCwl/
 3Jj2q7RvtTjQzu/bZkiEeG+pg1TT+z0JHYiKg3tRkpEVKggOF9jpL6A6dBwnFiJn3+Qfkt/FEFC
 MELvuRMQmMJe3bsoQ8i3sRi6i207p9JQJPdeGZwoAcUtsWOGEI8vkrGA0wADJSGxlMAyX9OJIFy
 hNP6OVfcML4/Z7pcxPCqrYR6iMSqubUu27GiOVLd9+AA7zbw7oKeZooi7MYUqZ8ooTfKF7+rtxK
 4dags0zA==
X-Received: by 2002:a05:6a21:6915:b0:3bf:6c08:4ebb with SMTP id
 adf61e73a8af0-3c110cdb215mr733037637.48.1783720114304; 
 Fri, 10 Jul 2026 14:48:34 -0700 (PDT)
X-Received: by 2002:a05:6a21:6915:b0:3bf:6c08:4ebb with SMTP id
 adf61e73a8af0-3c110cdb215mr733003637.48.1783720113775; 
 Fri, 10 Jul 2026 14:48:33 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:48:33 -0700 (PDT)
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
Subject: [PATCH v5 47/98] tests/tcg/hexagon/overflow.c: add missing include
Date: Fri, 10 Jul 2026 14:42:51 -0700
Message-ID: <20260710214343.2065491-48-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4fUA6aeyvDicHk3iKpbfpe8uIwRzcMni
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX3H6HjdZ3Py0X
 sCVu1yydb9nPMnk/ukUKDKHTQcC8YHnOgtXzKEsxvuloNbybN6jkYhIm+8ZAWfFHk2u6AtBQQ7o
 6pF3ZFsz6UW8qdoiwF2sxleJIk61NA3Nh9RS+HikW8tUOFKpI6wb6BbgbK1WP2gpC0+Swg29Eup
 /JQ8VHHdfQC3AcJ2Nn8rUwZWiegi8O1DkgujFsY7pkjMkCAO4C5LPpS958I0BsDvKZc2g3kV79d
 SgzSJCONz4IXvMwSZOebLDuWU5OwmLwkS/94b5GfXDSO0dM6L6xOdUklpkaHfal0t8CUXK2Z9wF
 WbsF0NSkmAr/Z7U5mSHPro+nvxE49n/KG8woLUHShvTjg4Dg2wzkgLl/Dvm3cSV6/JJl4fJAxvn
 Ntn5RE6cCChb+EVSQw4KyLyDTk7vgkZQR2Zu2wZrLnKMn9fvvziWyn1f4r0Y9hy/YE0RVpM0dcX
 9W6GHLEg5D3pZdy1IGA==
X-Proofpoint-GUID: 4fUA6aeyvDicHk3iKpbfpe8uIwRzcMni
X-Authority-Analysis: v=2.4 cv=HInz0Itv c=1 sm=1 tr=0 ts=6a5168b3 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=mDV3o1hIAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=27jwiZK16oKz2i4YsWoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfXxFatGKdWYlic
 ew6lmZ8x7uam7TC178zJWk7N1rA1nXatCdixoI1GYJljR+4PtamjnRg2TFnxanIE8MsPlXh4tA/
 DsCYwfLLEEhJQIsGEoMsPgTo8+mpAYQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100219
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


