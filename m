Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E7BC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7pq-0007BS-DG; Wed, 12 Aug 2026 08:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu7pn-000791-Jc
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:13:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu7pl-0007cz-Sj
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:13:27 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4Od82860295
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sQbbgiiaJ0qijuxBreugUJN9rD1J9WUS5VDcLHO+JK8=; b=F8Efu87Ig1P3Rq2p
 HKlIrO2iriLMgwHa3JjgZg0nkeNjtL9ACF0Cgq2DXpKa3A7tdedSlZp1xsHb5JFk
 xBxQ8qbSdfvD2v3zEmeFa0a/tcN09IkdPhj+lWyREgVTqjL8ggbG7Vbqq3iDwGRy
 t7iG9vcTpKBQLjYBkYEY+eJL4BN/57dFLl1NbFh8QVErVuYNYg5tgws35/KwFnnV
 FBQtQIC8YcUwwCz6ZQBi+eZbSVLCJxKJJqtTQHN8YO70bktnJGcxRoLpFNQdYGNk
 B0nbCVNDfh+SY2Rj5NRVXbab47aY5cZYUH94c1nadj9Uom18uC2KcwVfa0/JwolM
 fgHq/A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0mnd8yyy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:13:24 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5174a23afcbso12218811cf.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786536803; x=1787141603; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sQbbgiiaJ0qijuxBreugUJN9rD1J9WUS5VDcLHO+JK8=;
 b=ARMRO8N1+8sIzm0V+q3owhOqmLwT+YEXRU+So1pv+AvDuL4jdoRAnkv03VaGXSGcnO
 HuKJDcxMJp+deJ1K2uwh5C2HdtYuHgRro7Tp0x3gkdp94ilQV7dXA7IHf/mwfivyS7iw
 /+IB8u+ZZ0Y22YGa2ztpr8Wsr0xUc8Aryg5ryi+JxAvDun9UD4vHTYDKEXsVyX5fUJGt
 r8ipYidjc4Fz+9o6USSFuOOiJMpv/cwFcy7g1HKbeuWxcl/BPNx2PZ1egHdz7fsDcMB8
 Yka3HgOLe2aSSbQgd5cGyWfMY+i4hAEUe4SYJuEwj6/VKVvSQHzNnfxNcyfURzzblIW0
 lYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786536803; x=1787141603;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sQbbgiiaJ0qijuxBreugUJN9rD1J9WUS5VDcLHO+JK8=;
 b=KH5xDss5aKcjbStBUp1EfgyTHAyNVS4ofwV83qaOXMi9iq5+KIzkkSq5z+Ti3LmF5a
 YLxDD7qiPLwDNvXE2277XnVqd1AKrI2x3iv2518pSokOqWCpPBsx9aBQI8dmRNxTL5z2
 ymAY+VY8StQunVDQ/5KFoilasXrfbcpFvCkYkwyhy1vX7dJzcGK7Rbn7zId7yen+lxd5
 JmUOXQHnjikvyAMS2810EbMYHquGadWy6HaEWR4XXRXQI1sPO3tpkiWG806xgI1bj2c0
 Rw7aKomxqjk9nbt6ijUMSWq88xrv1r/9MVwEodRcLHot4Omy10knJz9Mf5uJ3U8TO0FU
 Uh6w==
X-Gm-Message-State: AOJu0YzQKfiFe1eK9h5pEQ+gsmaxwlIq2O+GYf9176f1vEF+e67r5zOS
 ddiXmJNp0KMk9kv5MFV+5+cXBmdKEegWot6pE3vpNLWCYQ+Qj1yzb6Vnz3hJgX5ICzo4SM4vMvn
 FLuXDQS1KHebgMSKKkWsxIEKu7omfwO3Sulwe4BvrdDwujF+ACKZD8s4NYdCTctYRcQ==
X-Gm-Gg: AR+sD11x+Hb7P3gO+oF04COY4ZVzhUjgmEA9mQtTFVGbNmkS+DoeGhkZTMUlx3xkVFK
 ZTb7ZLgpAnHA6fucFxdOKv5az8tg3/yokZOZmGzUAf+Knd61Se0O7tZWTH45ou3cgBQ2U8ZjX97
 Igx2ppbEE6u7saxEZe8hehUnFwTx45ccAstYDehylTIO9Mp5X8XPvTNiJ54SWp7jxbPF/18t5EV
 dq3ZO5wP10ikyVFwHVaWgBLQRfftQKhl1fT9+AGuGksfo3e6v6ZrckFMtGyxDkFjc+4sl20Hcgk
 HC4cFyT2FJG4ZaqUYPuVwhvK/X5AS4pzpwQVIdFg9wnvj+Y79+sIqrVuwhjK6ES/bVAggq8oxva
 1YguNzOdEtDu3jKp6HybwN0CMia3wPYyZ8ZuVH5HYZQ==
X-Received: by 2002:ac8:5855:0:b0:528:3216:b802 with SMTP id
 d75a77b69052e-52d646d78aemr33463171cf.15.1786536803463; 
 Wed, 12 Aug 2026 05:13:23 -0700 (PDT)
X-Received: by 2002:ac8:5855:0:b0:528:3216:b802 with SMTP id
 d75a77b69052e-52d646d78aemr33462691cf.15.1786536802995; 
 Wed, 12 Aug 2026 05:13:22 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997c939574sm41443665e9.1.2026.08.12.05.13.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 05:13:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 7/7] hw/nmi: Raise NMI line only once
Date: Wed, 12 Aug 2026 14:12:32 +0200
Message-ID: <20260812121232.71958-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812121232.71958-1-philmd@oss.qualcomm.com>
References: <20260812121232.71958-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5OSBTYWx0ZWRfX5k6zME2h22YT
 GJrINfiRcAeEASRaiGiltirqo1jjH+nVEri7/iFhTsG9TrsbUURqJ407RW0m3eaFyX1foJYT2Tv
 t/Bx3fhzKjZD8EFlB3JkIDbRs7emujw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5OSBTYWx0ZWRfX5+uBzlHcMkMp
 QKyZER39fbZdIbwr8Gt8ow232tcRSTl6HZ7Z1wA0svCYPGdAZwMIZWFfxKrnVG51gfvL96P+t9F
 4fDCDrfh1f1Zs1NNCE7GJgl30TfqpDAoZZBMtk2m2Kf+djn9shJFgnNYLx3UXhwcBZj1n4GDyfg
 iRIsDQtP4Rtk4FdyMW/OhH4VSk3e80bdNk0K5bQbZOAqp2IJhZUrA5cJ9WRGV9cYl21nadf8yiM
 5tO8KpmvAQhoSZUXZQqK62Z3dlOHdfuzUY8g1W05Sre8lFXIoRJTVT+EgE3yAxdRZRIqZpRzj0G
 oSlzR5864XLqqd1hla3hudCQjxreAfequpJupmHunVmzbCcxE/5Id0bOaCAnD5iLGBSqAxulEFo
 s1IT3rZQk+NhAIOSNy6+4POvhvlKmAOnt4KAEaQhY9y1WwkthlFoT6FD0+YXnSyJqmENYG+8H7i
 Q+1yqomC6PwBKSny+aw==
X-Proofpoint-GUID: jxdvhT2_iFc1mDNq7l1rXJb7wiEZl9Yq
X-Authority-Analysis: v=2.4 cv=C87ZDwP+ c=1 sm=1 tr=0 ts=6a7c6364 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=HZQsDzxzLdBvz1sOA9cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: jxdvhT2_iFc1mDNq7l1rXJb7wiEZl9Yq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120099
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

We only expect one device in the system to implement the
TYPE_NMI interface (typically the machine, but in a few cases
for e.g. m68k and ppc this is an interrupt controller or
similar device); so we don't need to keep walking the whole
QOM tree once we've found it. As no machine type creates more
than one object implementing TYPE_NMI, this is not a behaviour
change.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/nmi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/core/nmi.c b/hw/core/nmi.c
index c44b0cf892d..84f21665987 100644
--- a/hw/core/nmi.c
+++ b/hw/core/nmi.c
@@ -31,6 +31,11 @@ static int do_nmi(Object *o, void *opaque)
     if (n) {
         *handled = true;
         NMI_GET_CLASS(n)->raise_nmi(n);
+        /*
+         * We expect only one object to implement TYPE_NMI, so once
+         * we've asked it to deliver the NMI we can stop looking.
+         */
+        return 1;
     }
 
     return 0;
-- 
2.53.0


