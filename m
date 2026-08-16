Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C22C5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcAQ-0004If-Bb; Sun, 16 Aug 2026 10:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc9b-0003ep-7b
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:48:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc9Z-0000oR-Nb
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:48:02 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDl0EX3214626
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W6XLpQEYOSu8dtevCqvevES5FCDZtbRvU20Y1amii/U=; b=NYRka8RSspKu0iHt
 X1aOmkIZiSKjXbxyWek9FmzhKmZU5dkEuy2folU5W2hIQKKY/doPvAAnWIBrM7mz
 UJTOFMw77uV6p27CSurQrL9/RQTxB7r6mJxdmVxbXTgJqoWiV+uHq8aejOMSE+KL
 xNCK8CtPFG6ZnG53TKAei6Ay2FnCZRxLQceW0ZsW5z5h7iGKba1EYnp6FwbUir4E
 m6fOz9apUaSiiYKH059P8ng+Z5sD2HDMIF+2IKohTsef3vg4mNuqhTs5tjN+L2F3
 JGzULR4yJILjPd/0/2uh/3mRvw5sVdGkoEHeIFmp3s99kFIYVAWggNHZO+nYIcJd
 q6EnLg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghfbn73-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:48:00 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1a97644aso30644611cf.2
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891680; x=1787496480; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W6XLpQEYOSu8dtevCqvevES5FCDZtbRvU20Y1amii/U=;
 b=WhXR4eUngpCK+eETwNNhmDgBaFvYC0IRuKqIcmI54DRAurGNUuzFZvGLosZVCGZd6O
 pslDK2xpt6wD6bvm3vN8bxDcv1AHqkOtiNZTX/7Poy0jUpENJkOsxHy5A9nTx4R0aV9k
 IV58yR4kp5NqlYitAfRKuvkCA9023F2QdLdltZv6w+OEl+jIRvBvFU+1sTvGejadZHOF
 5yGhlbAFxTqj+XDtCf16CYnaXKwO/G4lUUWGJ4NnHet96byrk+iOS2RnOCCyeLmKXAXO
 eBQp8Ih8dMF+MWto8botkawdVKeYk/zRK6qcB18nf47eCt7PvQzaOTOeQRTScy6nqIYQ
 y9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891680; x=1787496480;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W6XLpQEYOSu8dtevCqvevES5FCDZtbRvU20Y1amii/U=;
 b=n4DVEKdMBH30ksYaFHFU3uz50ExRI9iNPqXlV9Y70gekI/Q8EPZu+fFVIo0Xi+7Isx
 3wPHSH7Zdm9lsbgbJjhKY7hI6ORQj0E/og8ATfNzF6YdC9wm4tAU1LUssvpHgWm72gCc
 yB03ZLCaiV47m3Ysst4TGzRC87DvHFd3U17/O24nWAQloZjNGnHsxc3wkNLNnC5cPcZR
 oEfwFgLc+I6ZMRZnyTQlH/MKiPTiBJ0DHE8qHJ4RJBCGbwmEwy4MTSNtacln7JvvPGn7
 l+u6to19YWN89abUoKjVDGeZHOiZXKmgzF3GV5NuL2TjwzzegBhpWIsF92Ni2Q3T2aYm
 fc7w==
X-Gm-Message-State: AOJu0Yy6Xmt0IjXQFw7HaiCIEoz1TREjxtr9c6Sc2Dhku80TVTCtFMl+
 Cdeg3mpScs6TyXz3Q5W4TgwIBKkvKG43uE0E++xHsoDbd2wJzPZWrKqvR4I6bq6ZqTQTjLM6jBQ
 oW+vaxeQiMrLDG+9JF1gTwrzPFU+CI5cslBtC57XXYE5nmL0GDeI2bK8NAktq/N5vAA==
X-Gm-Gg: AR+sD12v7LJbl++S9qsvn4g2SfPOnt/mrJRpXW3x6fGO3Hxz5JIEdpUl/59IUk1V+jB
 qh7QHgXVCwJKCevH+v1rWMpJGym9TB6xp4PAsaAbJPiFnSvBmqGoF4jQHNHojWQqSwOt9rGeXRm
 W6/N4oGUS7XSgh9WoW9UykYFU8jp9XX6aVVEDDyjGPF+VFg/rnBb8C98swNaoODKIOolS0uvTP7
 mdvDgfGDVBmrqQ0UzkA5cm3v9nKjH1JM8VPlUPC+mmY75lgvEgP9mK7FihufmkoglAl+LJPCkW+
 mvuQbYp6dTK3D2z0PuNJzHTo5s6f3CEZpLNI2UgDf1PG2sMPru3mBd865MT1KrBgDdHkthMiNed
 lxar7iAug39dgvQ+9r6lPPm3Uj316sadA6da6EqN8BQ==
X-Received: by 2002:a05:622a:905:b0:51b:fb4f:afdc with SMTP id
 d75a77b69052e-52d853d001dmr211400891cf.11.1786891679903; 
 Sun, 16 Aug 2026 07:47:59 -0700 (PDT)
X-Received: by 2002:a05:622a:905:b0:51b:fb4f:afdc with SMTP id
 d75a77b69052e-52d853d001dmr211400681cf.11.1786891679511; 
 Sun, 16 Aug 2026 07:47:59 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996127629sm48348565e9.14.2026.08.16.07.47.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:47:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/56] target/s390x: Use qdev_is_realized()
Date: Sun, 16 Aug 2026 16:45:13 +0200
Message-ID: <20260816144556.69009-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfXwzYPhHdvdGtr
 DKCrIoyTIbCopN270sLx1JplfpU/VtNMXXPiRgwEdpnwo56hRYJ6oBIwejHBNq2pKZWaz9pm5PE
 rcAu2ion6rC5zctTRsJP0/3RdVL6OaI=
X-Proofpoint-ORIG-GUID: 2WFKqP7-DUjAU15LVmn9J79eeciZjSdS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX1xFVL8VOtPn7
 PsB2IEumGzAKi9r6r/L0uGS3axB0IevKiyZ40TmeHstUfHByNUOzSH7BP2FyPQ7UdiGv0PAzgYY
 +W/TTEOrobc2IKGS6Sz15NdJI3lQ1XQXu53KGSJUkCKjsAMrZNcLxg4zep2ZbzLo9Iexlj45RRA
 MYKMo66Hf2debtVO+FlN4gD0F+V8wGhrVinR4hX3/MznMheYg2d76j+nNN/tLrPZn/7deShU1iB
 CCIT5VJBk6/QChUPcpoZcfYZ8xF0rWUG7P350OZKluAe50DN1fGaJUn7g3SL8p7cl514UCYbnV8
 fNeRP5wrucz0GQPqRmKI+RkA0jhMAAvBzyl9xfN04673DT5eNxkDV5Q57132heoskDZ7cBNUWSV
 mgzTvj0BlnBSkU94dajM4aM3xiUR0rKeG1SC0f+ZbaMPOlgiJN8Dtl6GA9VspshLe5iDd4cxiA6
 8TVJ9S89vvknlCBMmJg==
X-Proofpoint-GUID: 2WFKqP7-DUjAU15LVmn9J79eeciZjSdS
X-Authority-Analysis: v=2.4 cv=I/dVgtgg c=1 sm=1 tr=0 ts=6a81cda0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=uRxLgUfnyXHAhkBXUOAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160118
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

DeviceState fields should be accessed through qdev helpers rather than
directly. Use qdev_is_realized() instead of reading
DeviceState::realized directly.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260721-qdev-v3-13-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
---
 target/s390x/cpu_models.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 2dd9aac8078..f292af7ad01 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -714,7 +714,7 @@ static void set_feature(Object *obj, Visitor *v, const char *name,
     S390CPU *cpu = S390_CPU(obj);
     bool value;
 
-    if (dev->realized) {
+    if (qdev_is_realized(dev)) {
         error_setg(errp, "Attempt to set property '%s' on '%s' after "
                    "it was realized", name, object_get_typename(obj));
         return;
@@ -770,7 +770,7 @@ static void set_feature_group(Object *obj, Visitor *v, const char *name,
     S390CPU *cpu = S390_CPU(obj);
     bool value;
 
-    if (dev->realized) {
+    if (qdev_is_realized(dev)) {
         error_setg(errp, "Attempt to set property '%s' on '%s' after "
                    "it was realized", name, object_get_typename(obj));
         return;
-- 
2.53.0


