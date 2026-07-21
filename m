Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D60DC44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7uW-0007bs-Pj; Tue, 21 Jul 2026 06:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7uU-0007VW-Ob
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:41:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7uT-0003J3-2c
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:41:14 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LARQUx1482264
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EnKjjXVnCpxSTsSWFNkwK49wXGnwELieAUSstKMZs/o=; b=QVNjhO3GdOk9QcAX
 XCI+9Dsr6OEls5C6c8JsI3Bn99Nqcter4SQss8qnJ3QbRTdMjANuMR2dnnbqlnPP
 zZtTvxS+sHlBm4lKzbNUZkQUoV9Mg0N14N1SoSgG5WqBe2P+ZM/oNHyd6XnTUfNG
 55sJtNSJxyPX77A36bzJJ/Y6k1QxhiLTf04ca2wpgEKnX4J4QjctqbUB+nMKskau
 O8cHSqpFLS9cj6qbdVQtR9Z2tyfQHdWi0ObXYnET1/mHyTe2JEfY5C4wuTN4SUbY
 l8/oxm0eyKC6y8Ts+C5qlHARonwFIvmDYLCD2n2syFi8MFcwuWQ1qSBTmN3MBV2c
 rbcu4w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhvqnasfc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:41:11 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so226123001cf.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 03:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784630470; x=1785235270; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EnKjjXVnCpxSTsSWFNkwK49wXGnwELieAUSstKMZs/o=;
 b=hYwlAE50yzC/5okR9kXJt6MITF8l0BezSEaVpZFDTgF/NCYo/nMUh6Oiy0kk6t/s1V
 6TOMw37sHAgQOAE20RAC5IH4zD62N4oGFZNaTUWi3GRH+TKiA+Cv6c98eynu1sZENl/q
 gK7IVSSILBf7heY6Ucqyfw0SkaT7Pwnvd781PJxP1theW7pFm1hAInUuZgNmOkBsewHU
 NvvrLEBWCftMR/4zLWWwLA/wNvkkICO/jw+8uLdQC6bDqk05BaRWh8PSXcKddFH95FTH
 1gGqHYZwZmrCjudwbaVPo9JcY7qZc/j0jo2CDUS7ObaH8P9McwResI66iqRE3R+qPVz5
 APCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784630470; x=1785235270;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EnKjjXVnCpxSTsSWFNkwK49wXGnwELieAUSstKMZs/o=;
 b=ZITlGnrHs+C6V3HkC6VDhbQVg3BuxfcmNY16wkD79WgFpYq7O0O1BZ09J2y1xR0KBp
 3fSmqMcSI6apvNDRJLNjxFoFasw7lfebJDTv/UVvRSrVzW9JmXTvZlSsM37SbfqK0gor
 ydUCISBxyIKanZ+whWunX3v2wuQEp9czT91S4yK1Fcs5PYxT0QH6GdhsZOViVQphL7hb
 SGp9S/fFGn90I1bnMyKfBrPsB6phz12UmGGOnuas7X5q7xALmPvs2fe/1ecLMzw2h3V7
 FbuVWT/XhrQDQcKnFjwT2owQv8fV4QposkvgssJp7Oq9mO/Rl9P0SMu2N3XCHm6KPraB
 3q5Q==
X-Gm-Message-State: AOJu0Yye0U8ZiT4EpeHSsgxjOWK2NNSm4SJs4NqLOB46frnuofvkaiOK
 GNIPgn1xT9NB2o7XnUfl3Z8HaMmkGWQ8ZbNCMG4N0LPSt0apnrlowTglaXhwe3oIiuUoY3X2Aaq
 gAkZCBaR8Tz1g8nisIeOkfWy7JQYIVgrpUV/8srI6ECnYTWFaCwF7Q/QsxxLYLPfYDw==
X-Gm-Gg: AfdE7clCMnxiAyMIq0w/vEWEBR6g/1LAW+OnnEK9E1M4eDAuMKbu7KMHMxRww18/QNd
 HZkIk414zRBxvGAHCWVqDSC4Lsn8MKgN25h4T+N/2nax9atJZIRABFm92AOKv6gbQuDjffqOxDJ
 lBH1RspIDsOSBnmKO6RrPhUQEdsQVSUsdn4KboEdNnN2rjftSKmyVud5zM6Nhp/GEYIGlpYroQP
 x77n1Gq/W0YpBGl1XGzm3I82LdLj9CHaIURjGOtKhsm/MZgnC6jEevIfZxicW4pGkN1VejoQo0l
 dsGTayGIllDgNQ6tjzQAPxstOWH9zTfDy+QecXR6xhGC/pdR9LVYv6m1WE2bFKKBCXwxXm89atU
 3NyaEBw6S2/c1P7Ymxaa3LZetUZmyAFn4KoY2DUGOqs0RkhfZG3EOvewF5Q==
X-Received: by 2002:a05:622a:1b0b:b0:51c:7b12:5ff6 with SMTP id
 d75a77b69052e-5213d7a7872mr161875941cf.82.1784630470390; 
 Tue, 21 Jul 2026 03:41:10 -0700 (PDT)
X-Received: by 2002:a05:622a:1b0b:b0:51c:7b12:5ff6 with SMTP id
 d75a77b69052e-5213d7a7872mr161875771cf.82.1784630469937; 
 Tue, 21 Jul 2026 03:41:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c7desm78278315e9.7.2026.07.21.03.41.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jul 2026 03:41:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 9/9] vfio/listener: Remove unnecessary 'linux/kvm.h' include
Date: Tue, 21 Jul 2026 12:40:04 +0200
Message-ID: <20260721104004.84934-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721104004.84934-1-philmd@oss.qualcomm.com>
References: <20260721104004.84934-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDExMiBTYWx0ZWRfX9mW9cSr2G/m+
 n91E9Hdjpo+oEHywTHaq4rkhejOixQIO+w9Y55uCxqyzN7CfjrHRmvYjnFamtzd0oUpRwpUdwn5
 RkDZsGafs/wLnfcuSSa18IepIBFSscs1BdQ0S85GEQ0NWXbSytoV952jxfqjKm0zOAKEab/H2Db
 HpLuC5CtpSgbMeVm0UiTdjmIA1xzurAmk9W5yVfbuF51zjcxnVuADuW/Kjex+goy4X+WID7Dews
 555lJ0jVqQCnxcD2jU00xHs4Tgyz1NJ8KSuTSf/DLhJO51YRYh/YrWRhIoOqMR5ZUQLVVfwcHrF
 YA5bg6cH5xzPrITdasb72vF6oys+ZmdrVMO7WKYM5Wj3K19deo1/5ZxkPFXr0A8civaOgVTWh+C
 aRYXPh2k52T5Utl0bsn0b8lKGYOvwDVKu3xo5WUz6AeG3im94xALoMbGVYIAqo9x3uLBvXfOb7X
 9OOHeQ7U1hYGqBsPRbw==
X-Proofpoint-ORIG-GUID: 9MKUWC4M6eQGh0EESXn6HzQhwPxwZ2ei
X-Proofpoint-GUID: 9MKUWC4M6eQGh0EESXn6HzQhwPxwZ2ei
X-Authority-Analysis: v=2.4 cv=M5F97Sws c=1 sm=1 tr=0 ts=6a5f4cc7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=r1p2_3pzAAAA:8 a=9qUTvQc-AAAA:8
 a=w_hrQDA7Ve_DKnw8dLkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=r_pkcD-q9-ctt7trBg_g:22 a=axOgMmt4Ejcwn1cqzmsR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDExMiBTYWx0ZWRfXwvG1NVwtQfeU
 2zSQMLhign5o2l6hJexONE4oOWftfQm7hCnQDsbJQHqU3PHWieDH/3ZWcWZN5IR0Crau1uXsCfo
 ymtTWvkeTpihHDMB++zwSUgbLVAs72E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210112
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

From: Cédric Le Goater <clg@redhat.com>

Since commit d0e8bccafc23 ("hw/vfio/listener.c: remove CONFIG_KVM"),
the linux/kvm.h include is unconditional. This breaks the build on
targets that lack asm/kvm.h such as sparc and sparc64:

  In file included from ../hw/vfio/listener.c:23:
  linux-headers/linux/kvm.h:16:10: fatal error: asm/kvm.h: No such file or directory

This include is not needed in listener.c which only uses kvm_enabled()
and kvm_get_max_memslots(), both are declared in "system/kvm.h".
Remove it.

Fixes: d0e8bccafc23 ("hw/vfio/listener.c: remove CONFIG_KVM")
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>"
Suggested-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260721062745.3793066-1-clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/vfio/listener.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index c19600e980a..008f488a3e7 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
-#include <linux/kvm.h>
 #include <linux/vfio.h>
 
 #include "exec/target_page.h"
-- 
2.53.0


