Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC30C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8oV-0006PR-TG; Wed, 12 Aug 2026 09:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8kb-0003TA-It
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:12:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8kZ-0006O9-IE
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:12:09 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4MkO2860276
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0K59RZPEvdTZnclxJKg+xf1CCEDRT+nQLEi2vTumsU0=; b=Us66dijWuM/L8kfx
 z2pyxl9j2apOaus1yAklZLjd3wkXbZk+z1ZdOFM0V23DbTMY2cSayTcDMwyjD0a/
 5BAMSe4kfzON3qitg1H4/lMGB4hyqrIqEfwWnEfxu20fX7NBqiyxFjbY8hMSVILV
 wmz80pAyKPOjOmOeZYHrrUykEIaZnec/yCOWfZITeMoiEN+GkD0IOJNA5KQ/hEvO
 sLzQGAhYJe2ScVQEsbn9z2Q2MbL1r5A8V/sYhQnCQXUGQn+NMtFqBfMPgLHnCucg
 9VXhPYe0BMCp+z2e4ZmV4OnvNsJU2gBkSPkg2eP3DuxL8169IxVCUEssaXBD0IqG
 VOfyhg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0mnd977n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:12:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1c7f135bso16269811cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786540325; x=1787145125; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0K59RZPEvdTZnclxJKg+xf1CCEDRT+nQLEi2vTumsU0=;
 b=AUPQ9x55Gnly5fzazhMT9lFcNz+wUJHSzkv4eg76loKwcjq9/Jg2TpIzKG9BxE8m0z
 e+EWBQH9fJi1uazHP+IDtjG3qdTSGxDGdxoWoQxcV54D053082UP0hGooiDMeZvgT4Qc
 hzIqY5b11XMUdMsHpMYEn7doWAVjZOHknMpxFV/HKn9V+kuKnTW/9A6ImukuZUkprU6C
 4uK8buAzcoVKPLb/hX4b+zxBKh59m2HQhaB1Rr/AMrbXyU26DhRXe3uG8ItF9X94+/1j
 10mGLGEYmy6U1MT2XWOK6x0e0gxMAgGKz9keh54OQjLqlu7/0Iuy+DA6DdGiErZPwz04
 Asjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786540325; x=1787145125;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0K59RZPEvdTZnclxJKg+xf1CCEDRT+nQLEi2vTumsU0=;
 b=Qekaku8PYxo1KZp/xe6AWdnhMh2gjCd6o5HctvDjEswr62nYGPaqKlPnT1bTCL5IO3
 635Mhjmlf21iO1gulDQNP1FQ1JNyH79rq/0PfQUb/y/fxX8EVSASqrL0elsbPW9DpdVF
 IRNv04yVVH+MF5wZMcN8GBJa9di6Y8FKidxbXbiYVQjrKcAzMs3GGJge+BDrFG811BjD
 zO5BYSdcTLdJT9O4xQiTtUza3X0DpaywT/3oc6J7j/lLefgyZsyxY0XxWcievRzxivNd
 G5aJScgFCMMQqvkyu3672SZwDHuyCYSajZS1rKSZC3NQCixUg/RttNU6/GLJ7kNgBNJt
 R3ew==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOWJWEGQYUvA7eCJp+9eOZq+esQciwN8zVGMzYNrbRq/K3Z6t1iNN86cLxFbRRHEaovmq/GfnXL3nC@nongnu.org
X-Gm-Message-State: AOJu0YyYYcAtLLva9QYg/XVuNrYTiO20/S35WXQiLdszUogMc55LAlg5
 s32Edgk/YPwlApAuyn20CzUphOoIX6nLwob54EOOOWxuIjlhtQE7rxIwGZU8UtxiGR9sw9RhY/1
 8NtrQlAo5n9DAcklRiMN4BcbD5kYSZeT19cn9EBvdZFhSqfXrKOLVoRri2A==
X-Gm-Gg: AR+sD10PmPOzGSG8yyVXwQohZVeL7Wx3RGsuhMM/j8g1F1T719r/MmT6ojQcMN/NR+Q
 lbuGth5Sv5zFFduuqeb8gykO4+ICo5shIinZYLyEog0aOYEDNE4KC2K4RycZwTNgQMOqbQy+CgH
 0bLURdA9KyRLyK99bnZKwXHmD1qc134ar/YrhpX19TNbVJg2GI4envT1SvlahULjpYpvy8UaAls
 i7dmuKC3BfxTcYTsotPRaX2JmDQ9SX+lPMbqsppTLohuaFL0PnHXBBc+n3eFTlDzYsPqX09evU0
 IVWgfArIOqsybydqtiScdGbpgDYr/2Z4DDVes+kDCUM0+9d/WHI3XFyCJjx3km2gfrgLH5h7ST1
 QLC+sfhWx5/EmRhYoSGubFFbM66wOZTpatulA3wDm1A==
X-Received: by 2002:a05:622a:2589:b0:51c:1fd1:e755 with SMTP id
 d75a77b69052e-52d6484eb9amr40893961cf.36.1786540324876; 
 Wed, 12 Aug 2026 06:12:04 -0700 (PDT)
X-Received: by 2002:a05:622a:2589:b0:51c:1fd1:e755 with SMTP id
 d75a77b69052e-52d6484eb9amr40892951cf.36.1786540324404; 
 Wed, 12 Aug 2026 06:12:04 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997c998f27sm45775895e9.15.2026.08.12.06.12.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 06:12:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 02/16] tests/unit: Include 'qemu/main-loop.h' header in
 test-util-sockets.c
Date: Wed, 12 Aug 2026 15:11:33 +0200
Message-ID: <20260812131147.83188-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812131147.83188-1-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfXwRlxhaJ9CZrR
 QZoGY0WRlphCr6UVCvtFnj9qqaNBXxCppLrOb58jK4oYyTfu5k2HsIm6xRcvrj5aSsEM9dyf7me
 O8d4519zmOb5pXXZuLvI2W3T8ApktYc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfX0H7y2GH+UgNw
 1pkFXgkrCTCR65Xk5wdSwzfE0ZuYy60481IBg0sMxyWPY90puRmxT8Tbw5BSln9hrqNUP6Nr87t
 KM0gWJt74w1Z7kgoYnLAUy6PMg0ZERdiRqF/fJAV07/hhCr1srLx2TB24gMnBNZV9xAP/VS0ygj
 VSLpeUhUBtZcM0EvWS2X7RhAuA/FisRGHpLszoyxHSLHrdKVmPz03bdK2b/ZY7/kD4B/7bCrR3D
 INQ7KP+iUD2kqhf8i1rFqEoxYAQNjoLO0NN6lRjKeA6De/uRlZoScAWy7uKYiR93qyWVfbImDWY
 iGXnjlxJ/753EzPBDqKxXPHQRrygvVWLtByyk4BE0RvtUaojDSsRU580RnIidGfUk5r3ldr2WN+
 MVjhkQdS4TnJpXhPper4wyF30255Taz8Wd9ekfdXyAlgt9JPEn56rgvoImOofxAEwjv8FURvKJv
 RzE4oFeZJJgkvWV37vQ==
X-Proofpoint-GUID: Xxen5LUM8lTCDry4n-9_FmlHqdQ7n70U
X-Authority-Analysis: v=2.4 cv=C87ZDwP+ c=1 sm=1 tr=0 ts=6a7c7125 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=qNk81O5wtt-6jPY9Lu0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: Xxen5LUM8lTCDry4n-9_FmlHqdQ7n70U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120107
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

test-util-sockets.c calls qemu_init_main_loop(), itself declared in
the "qemu/main-loop.h" header. Include the latter to avoid when
refactoring unrelated headers:

  ../tests/unit/test-util-sockets.c:553:5: error: call to undeclared function 'qemu_init_main_loop'
  553 |     qemu_init_main_loop(&error_abort);
      |     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/unit/test-util-sockets.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
index ee66d727c38..ab3f39c3efb 100644
--- a/tests/unit/test-util-sockets.c
+++ b/tests/unit/test-util-sockets.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "qemu/sockets.h"
 #include "qapi/error.h"
 #include "socket-helpers.h"
-- 
2.53.0


