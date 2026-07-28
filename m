Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93803C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZjM-0000zX-I9; Tue, 28 Jul 2026 00:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZjC-0000h8-NE
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:47:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZjA-00024n-S7
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:47:42 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3uAHD1921090
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0rD/5x7B+oeA1ushLFd1/FkVFNtjW+XHxPAovDu1x8k=; b=Vwjv7PuQpjkY2bQd
 yMNdQ340a1VuqVnbW9GjMn86VW+8sgobzxj4rLJHhoLz5ahOQUCs9i4/x0CM0FWA
 EguZdh3ZSi+TYpQquQLd1RI5mKPFSXCREYArzTrGzBKVV05oy4V4ghfHj43E4v85
 DwwmoXb0/mKavUbBGCgchVjtZBWYe/vCo1U2DWQ5JsfmXZF8SeRXqZ3XmDV4TiPG
 Zqzz1zin+l5KDrguvYFfz4ZMvKCmrK7yCJwqCRKWDBfQmXeWoVaL10JJFOOqvo/B
 M0m7Ihul6V6YR7Z9p7w4PQ8p/VKhdMY/00C1sYu3kRlcQ/BUUQCq+FqVS1dU5KTX
 ALyw5g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpmy104v0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:39 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d001671a54so28014365ad.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214059; x=1785818859; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0rD/5x7B+oeA1ushLFd1/FkVFNtjW+XHxPAovDu1x8k=;
 b=AEYkZAufbz2pyarcWhJuBOgaWzmOGcPvFx2h+XIv/lk5u27lFAeq8I7JLTWtWN4AoN
 8hKzfxizLw0H9VCJDQL4KdB66VNgy6BWypaZrHAZTTZbVBEESNyqhjhU8AZZHKOtT6I+
 R9ERhzPfmWYj0wt01QdDpOquxQNXnN0AKTkLYn2qg3LXiH1CnvcQAKNbm17+J56vJUiv
 4SgtK2qj/30W7S74WUqnPYtioiasJcGViz1uktVizhRoJCr+c80TVtu/t8kJiVgjly+b
 KBDTkANWrBo6LUN8KgmWSgYndCUTJO0q2of/Xce3i7FJLYOhlyh8iZv24VE0UFAGqEgV
 4r6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214059; x=1785818859;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0rD/5x7B+oeA1ushLFd1/FkVFNtjW+XHxPAovDu1x8k=;
 b=E48QXSt7HNaqHYkzUjdmHccOHf0KHvBd8Ow91yF8aO3K7HYS7BbQseC+vL1EHCkbo3
 Vyz06eu4nOaqHDz5x4SKYsj9aKsnEPqj6r3dHcEIxR076uAHmidRqVNCY1fCQBNYNrV+
 CHLwtAttUntlA0pLbcw15MlJW3HitR5umlKTE66hGPcxz9xsKy8KS6O6skm3IUe8FdOQ
 nM86DV+GmWVv1uxRCMUnC4/eRqScT1eMr7G/aeT6H4ryTlRjCzTWSMz0pXeLbVAyt0b1
 toVRwyCJUmcpDiGqbGHRmud+kaFWJnWfNnjP5yFT/vzh2unMbRWiNLdKjx0mrHg/qhHX
 VDSA==
X-Gm-Message-State: AOJu0YylxdPsbSMhFLlrRqz9nx+c+d5UiDbzoeV23xEPrQWbJoVLBC54
 TPklNYN/nmx8TBpnITPaHlKGoZgXkmqjSQPgZO9qVs4stzOtMQC568Cb04wKJh3LGpj0ZuAVIQ7
 er0NSbuxLzHR8Ked2b+Q/oxjcmmzh70J1TafYV15eQbuKMzFdEAbvYOAGEF3rNtVGtQ==
X-Gm-Gg: AR+sD134iATe5PqGuDitvGcpBzy7hqYnimup5OIDhtDCvOWbXUEaq1hBiUwE1xPrI17
 j+GzCHFWCmKkv2Ab8rxVDLs4C8DFm3Wpn9TFn7J+gx1AEbPuhqPVQCDsLWJUDJLJDBA5zsqfU4q
 Bd9JZAOBdz1fhO7FpU+dEBLjRCy+K9CcG7zJCqh1FPZ3icf9b464ifBrjbi07KgPVUSMBUzruUL
 dmVs6PW/OZQiNRMDPnqf5R3X7HJAYlq2gnUkpctl+1+RcA8TVVaIj7L9y+oqeLhlQCkmY3ppnWb
 ENuk+zhtPnA+c69oCRCkFsgqJ3haFWmZ9EyzYKVuept8lj9ckFDfb2/LndvhUv/3gUt63JkJSj7
 to2VibJhlLadUR2V7xextd/suMGioBidUnpKYLDEA8SIrJXh50ptM6rSbx1wSJ7uoTHdKLDw=
X-Received: by 2002:a05:6a20:258e:b0:3c3:8044:8b0d with SMTP id
 adf61e73a8af0-3c8aaf7b055mr1128129637.12.1785214058851; 
 Mon, 27 Jul 2026 21:47:38 -0700 (PDT)
X-Received: by 2002:a05:6a20:258e:b0:3c3:8044:8b0d with SMTP id
 adf61e73a8af0-3c8aaf7b055mr1128098637.12.1785214058423; 
 Mon, 27 Jul 2026 21:47:38 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:47:37 -0700 (PDT)
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
Subject: [PATCH v6 048/103] tests/tcg/hexagon/overflow.c: add missing include
Date: Mon, 27 Jul 2026 21:41:52 -0700
Message-ID: <20260728044248.137626-49-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1sYcqvS8Z1AJA6cKXYbnPXvPReS4z6vu
X-Proofpoint-ORIG-GUID: 1sYcqvS8Z1AJA6cKXYbnPXvPReS4z6vu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX17WTOlLzLuIE
 9BPcSBhpksodMRCTvA4R1010hngjYRMfrKbKvNxMXWda1JH7/aP1jnFflEFVduEJ588mgzdgScz
 f6Uaz4nvQRbrAGfMyq/dr/7b5rK/Tg6oJ8qDd5TM0SJyQ/kE4QAfz+R6mBu7mEPDiO8Ulve6j7i
 ckSh4xomY1xJy/XkuUQ53Fjxl1NInZbkgxTdZ0lNSwe7Mzc6EmUn3aGa6vSNi5Wbt93ksn5czyP
 NFlFuPBYW03bVF23zOhP9Ge3+t07+r7P4gs0twuy1LtcH9k3tnI+fzog+mpWuvklwOPiijxxADY
 YE/qvGsD7xsgfm9UlNaJgaBtB9yt024OyKDzfGVDxBbt+BM4bRj207/BbzeURmKpbYvoWKf0zjk
 ruT1WVO6GaHMnwAc0mRT6xF8seFS3Pw8nIatUIWdLm/OLF/aq6yM2Cd28nRT3I/EiV0ZPHXMBFK
 4AHfjXFbWSz637wutJw==
X-Authority-Analysis: v=2.4 cv=PJo/P/qC c=1 sm=1 tr=0 ts=6a68346b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=mDV3o1hIAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=27jwiZK16oKz2i4YsWoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfXwhUBp6NV4bSH
 mt6iOwz50mwrSCYQyGZE36/nl+WKhzW4VJen9x5kO/ni6hHCSFyKv2OvjtsMkeIsDCxRQYBqrRk
 opVr5ihhYuSdZDSrmUrGPUfaipiAgxs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280041
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
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
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


