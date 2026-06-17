Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B4ECD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZslZ-0004dE-1u; Wed, 17 Jun 2026 12:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZslG-0004UF-4y
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:05:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZslB-00018W-8u
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:05:03 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HFqcV23048000
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 caDdUZnsitYpOPxAg/+61r37uh6hsA2GkISNHpMxgWU=; b=DAMPtDuoWkniK6oi
 CYH0dyMRqHMkb1G9S6Mmrc8UouhC3JdYDTCp7J6nAk7TTPYF6YrfdJS3GVMmkIb2
 XF1As7/sabbwxa/dgECbziyR+9k+J42teupTC20JF71j4Xj8mb7YDYlkcLQWtG7x
 vNGc6XMUEYGl0yVkIkSCWMx6UeWLqGrJhEDag3iinZDF97npQ4dIaSGPBeOqPpIR
 +xyA4gFnf7aDeW/6rYbvOtain8nzNJ2wbOZ9UKZS0OdvMJIvHwCAXsTcG+TfeRoy
 g/lZ3cp1NTOAqe95sQRydnur7pshNnVBC8zMHLiHQIx944qnljXlgwPdK2abTpvy
 u3r8Xg==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueesc3kp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:04:59 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7e71881b08cso5984520a34.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 09:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781712299; x=1782317099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=caDdUZnsitYpOPxAg/+61r37uh6hsA2GkISNHpMxgWU=;
 b=h13HAjEo+FueZS/Ng0PlACwG48vRRn9Y9by22Ps0v6ih6CJ+BUuQ2+qJ7KHx+7YjGS
 C8A2jSZjIKfs7mBwuP6QJ3NTQZEsJL2Y8ahrey8WoyhkZrDBS3gmNQgAxuXb3W6IA2yx
 OLH66y3rf2YTdpoXM2bigHm4nV5sb7ngk7wfaM5RRTI+PbvN43praTmGI8TqRtKKYPsS
 h+PUmmA5INSkTprkl7XRc/Xwzo6UwxNj6wXJ9GoC5Ii0GPq1q3MVj4wTUook+Isfz6iQ
 sfNHWQpVWUM/e23Dof5DB4OWMjyrD6cZzJ5ELhjbaf+CmT6uP0NKODSz38PHFhjMihJM
 Q/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781712299; x=1782317099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=caDdUZnsitYpOPxAg/+61r37uh6hsA2GkISNHpMxgWU=;
 b=rg03N/gAYsQ5PnhM08uME4tTRu3Bor9KddBE5PmPNuG0i0GpFya8g3AKdWy5l+c0bS
 LNCEoJwCyrl+rlhdn5E9swQKW3IVdF1oJQOoTczTp/EDkEcrowUFZ+pfSlixFu1V/EGH
 JE4ZNyoAEDPVz3/3erS+P00rG5csyom98xQ4F7drPbTS4MbcHuuwZkRfJZ5hPUgMvsOk
 FhzIJUrBpRJ3CTgSvmuJ7YzIBC232Fq+Pn441DKHVFlmnWhcCrPLHxsjDP3PXX7jpGJR
 xbmhjXqqJWLnDytpLPMxdNlPFiaaew5FZxt8rhMv3HYr8XxUxs5SsDW5dz/LsbEpBnIA
 Vlpw==
X-Gm-Message-State: AOJu0YzFyvKQVyrmqFtF62/LF1f/tYpiy82WdYzuoDbszwklJuFwaxj5
 XAK8hB+Fjq+oA0rDWTnpTJlC2XMSRFIhO4i+Vw6u5/sNO1s8h8YQxuJ9Ce/XmHR+t3Gu5tjuxGF
 PvHQqp+r4TcFHY/TckCY3GyZ5hVwmBpYt7WRMFrJicsM6ZEhac6MhMCvbzVvXLoU/0Q==
X-Gm-Gg: Acq92OH7WT5MRz9M9xVf/Ece+DGVikMe/KRxepYu3r2JK6+4t3ueLUzAp0xu35wd/GP
 8iJcclsIbgTwUfmU3tTgl6FEtvU68+qn/zLqU2tHQhGVH3nbx6yjyrPu8m5E65Yd+coA7Et0y8i
 XYQeJ3eiIcqtCJVXhTBhjSWWFwMRxBiqnQpVamr+RmM2qN5x5s99kS8qSbOlTaNw06xge+zx6d0
 WNI/k0CKpPdGAeBhJyX7NR81hwhcwEr5vZs9w7kgBFLOM8T82FNgMKDyiNFdNRFDGvQgOk7U5ro
 SkwigQ65BK6sR3dIgYONZEFDDgHr2BieOGX88SGACAb6M+zdvLf7tznBmuMTf3WhP2VIKgEYUWb
 cDlseo+VTjoCGXKF7DpfKFHDk/dqJQJoyrNKsEwdpL8etGM02bUcqvcJGhD1ol0leqERc
X-Received: by 2002:a05:6830:6993:b0:7dc:df37:844b with SMTP id
 46e09a7af769-7e90b386d41mr3968049a34.4.1781712298557; 
 Wed, 17 Jun 2026 09:04:58 -0700 (PDT)
X-Received: by 2002:a05:6830:6993:b0:7dc:df37:844b with SMTP id
 46e09a7af769-7e90b386d41mr3968019a34.4.1781712298163; 
 Wed, 17 Jun 2026 09:04:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-461eaa0d275sm11625460f8f.2.2026.06.17.09.04.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 09:04:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 4/5] exec/cpu-common.h: Avoid including unused
 'tcg/debug-assert.h' header
Date: Wed, 17 Jun 2026 18:04:25 +0200
Message-ID: <20260617160426.64461-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617160426.64461-1-philmd@oss.qualcomm.com>
References: <20260617160426.64461-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE1NCBTYWx0ZWRfX3aLIgjhFubn0
 quFrrhP/i0ggiCwKAuW28WoSiWTDYkRRMtma+o9tgHeqsSb0ntdfL+WD7dgEbzdONOZBySPbN9y
 Ja+GOMRI98ZdiDlnkxqgMFPikZG6wu8=
X-Proofpoint-ORIG-GUID: PM3pyjr7SFJK6cvPmZX4F2KE-0Y2ulrZ
X-Authority-Analysis: v=2.4 cv=R6oz39RX c=1 sm=1 tr=0 ts=6a32c5ab cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=EN0NE8wA606m7JOjE_AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-GUID: PM3pyjr7SFJK6cvPmZX4F2KE-0Y2ulrZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE1NCBTYWx0ZWRfXzsKO8uI1tk2/
 M6NCGLhs9HXZPM+4xRrmyAZ5ui0BKS8rDCvnguJK8zwiZLesp50Rp9XIyAas5B1PTL2pVJyHpuz
 t+uLGoJKmZZVr8yuyO43aGB2y9NmhmvQUB0IRdvRTjMfhbIpzqsAWGedBfgN21U+CapRD5LXsq0
 103EgY5xY0fsuQzDOMs2jWiY5aMeLMkAvkX9EWrqXWvIQPAa+DjNDL2oYJbQYLwjtj6Me2vgQFO
 c3of4CIHFA1/iawwzR7BqZ1qPzXCK1Z5PS41tpZObbzGbW1M5iHkrYdGW9qtZbZiCKQmggVubVN
 UsrNiOoSsf4aymRtMcTzuFOmzhg7mdAsJJjBQ5VeiIokFOyFYU7Ape0hmby1SPFl7i5+xes73po
 ntF55aBi0J1AKK+bugYLRoUgDKKPvwVcZDH5H7s9CduIrKcmcA/GyL8/VIpdoWR4/dQqMYBaBmK
 bOqk4CuqN5lJiqyUl0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170154
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

Since commit efe25c260cd ("include/exec: Split out
accel/tcg/cpu-mmu-index.h") the "exec/cpu-common.h" isn't using
anything defined in "tcg/debug-assert.h".

Include it in target/loongarch/tcg/tcg_cpu.c however, where it
is required but included indirectly, otherwise we'd get:

  target/loongarch/tcg/tcg_cpu.c:291:5: error: call to undeclared function 'tcg_debug_assert'
  291 |     tcg_debug_assert(!tcg_cflags_has(cs, CF_PCREL));
      |     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/exec/cpu-common.h      | 1 -
 target/loongarch/tcg/tcg_cpu.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 7dc8cab3263..d1a04025363 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -10,7 +10,6 @@
 
 #include "qemu/thread.h"
 #include "hw/core/cpu.h"
-#include "tcg/debug-assert.h"
 #include "exec/page-protection.h"
 
 #define EXCP_INTERRUPT  0x10000 /* async interruption */
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index f556234d9d2..83291c22c2a 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -13,6 +13,7 @@
 #include "accel/tcg/cpu-ops.h"
 #include "exec/translation-block.h"
 #include "exec/target_page.h"
+#include "tcg/debug-assert.h"
 #include "tcg_loongarch.h"
 #include "internals.h"
 
-- 
2.53.0


