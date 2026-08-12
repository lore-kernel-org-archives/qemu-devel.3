Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B94C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8my-0004oe-5q; Wed, 12 Aug 2026 09:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8km-0003a7-Tz
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:12:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8kg-0006Qd-Hl
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:12:19 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4IAe3637776
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sMhnZePIGQRJ1GcAmTkyA85QXWrCwBcN99I8ECvu43Y=; b=WC3Sn+cJQxqAmqIT
 +8dcotlQYPfe2s0abdcqQUj1a8qDg3NFtJ+zi4ifeOA4eNH9jpL71pgZAg+Nd7E2
 UMo+JXQ09AlM8ChvNC741GzpHma8Bq/GYUAmM28yKOnSUaqe7tZI4iLdAqfA7IfK
 CGvsR0mtQ9LzXo3EmGnCAmloDkcJ3/j843JJl2BFHD70k3t0KbcUUfMIqKYZpiY7
 y/PzYfIh5BIPXL1pi216cUltirgDojYHOd1ilyxYDnLx83Ps9DVer12L4bVs7tdb
 7Wbts/XUpVYWQngCqqpL/NY+72e3J+b4Y8a9ZzpVrEKVvbHcsHC+iz8tKtVpHzBQ
 UY/hKg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0jgrhrrh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:12:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5283fa0656dso26657371cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786540332; x=1787145132; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sMhnZePIGQRJ1GcAmTkyA85QXWrCwBcN99I8ECvu43Y=;
 b=HPoa6NKqC3/c+dhuvh8D5AOWaZhaCKW/mwaLTxYHZxYMc7iEqe+01nAr7+CMbeShrD
 ecH18WOCj0hT7FZvFG0BR1QnLJebzb/r7v593/Y89cWFtFAJZfeaT+m9fKahxX+1nKZF
 MYWd/ayb0s19ef9iLEkMDNrbGtcjAkH7Rp25sJDIf63T4Vvtl54I0cazd3evvb7DjgoE
 n48V0icL3SqaX8cjDVSxymiyMMpLYR1nFipSRvYccOA5+xm+m7kUvxDLcN6ILx7KuGXS
 /DNNjZx0BM1Ox7CAx3BVjLLTfVUq/FgeJkfJSX8FqSyK/OCPfAj9eGa6xc90FTi2K11v
 TVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786540332; x=1787145132;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sMhnZePIGQRJ1GcAmTkyA85QXWrCwBcN99I8ECvu43Y=;
 b=K3cXUEQKb5gL1awKtPLSgS0xNNsrccirqzCgW4w3AIU1HM0knwz7+k17DnVW2hWEn6
 ai+wS3empdg390uV/4fAg3Xu/S45Lm7JwJENRlWmii+r1Pw+f1FBMNmamOC9ZkKCepPG
 QnnuTjWxrGHCXnMOlQ8b+/8su2QyceUH0UuGth8moiy565CAAy882BTsLAmfpxWuI8QU
 q96mdH929dj1Yw8y73eQcgoXujwgzPWGn3cDENFn18yP1QeZuLqhXof632hophEUQeHN
 N1MY8b2OIA9NcOJBVxDVKwpl1MocRgATeRF/y3eRZ3NYigPCuSvX6mJiqpVqr2q2UlGl
 EmYw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/p9WYm4loEqTeqOzodWfQdVxcpyfOPWF1+k2GQT//VhqgOZO6MAb/0gCdBlbJeJBAMfz5WVCZK9H5@nongnu.org
X-Gm-Message-State: AOJu0YxJWVth9AXvCGdJ2CxyIOk2dB0m/FG3oHiyxjWFtFCkezpFssqQ
 vMg+AWpx6wRuAaFSnhGFFrYwXT9/ZL4UQQ1EsNndMVRUcqVY41AclXd1JfdIkxn4IF1dO68JCtQ
 KsNno9Pl20OWGuKHj+LgX6kr5nFMzJPWIOdU/iA5j8vBygaOGqzsMq8Tbig==
X-Gm-Gg: AR+sD13W9y6Q7YXUhU6SgqwA7I938IFlE8PytQovdLx9E7+FfvXFFFbx+NoJC4+k3zS
 f7jzDQx9T5ksjxtS1IUS5Iwclp+xge60TLksqwwHljaYglp7tLMU8kQC5kVWmYC1D12aS6WDAtb
 FMVWNYoob1yJJbuD31z6fdNO/+VLudfQ4sxIabzcxjyKoWNM84xp1RGQtrKcmsl1HJI0W7ahSo4
 nnh3R6VGzLv0zggvqCY4MI1OVsrn4/JvIbXIAo6JBpNUVsKq+nSOU16HWJC1HwC0rKi5L8UI9nv
 0jT8i/oecGMDC7LytMTL3uoG0nOUJEKAe3CfwMg/uhkf9YjpHpnCKLdSG+o8TrfuyprcRS4dmqy
 u3KhCtilIsXVBYQmla4O9DgWsv00nrTfV4olb6YsYDA==
X-Received: by 2002:ac8:7dc1:0:b0:52d:3483:ed0a with SMTP id
 d75a77b69052e-52d6030e1femr60099301cf.18.1786540331965; 
 Wed, 12 Aug 2026 06:12:11 -0700 (PDT)
X-Received: by 2002:ac8:7dc1:0:b0:52d:3483:ed0a with SMTP id
 d75a77b69052e-52d6030e1femr60098421cf.18.1786540331438; 
 Wed, 12 Aug 2026 06:12:11 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d702c9sm7464522f8f.34.2026.08.12.06.12.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 06:12:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 03/16] qapi/qmp-dispatch: Include 'qemu/aio-wait.h' and
 'monitor/monitor.h'
Date: Wed, 12 Aug 2026 15:11:34 +0200
Message-ID: <20260812131147.83188-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812131147.83188-1-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfX1Sz+cqCe7VqL
 3nCR9hQIY1XLKIQamDgmBetBZDj4C02Qb078mL3qTp23u+eICp4J7jcpvE57ESvditKMyxE9jeR
 xIVE7xMjcgFJMy0a8B5qcqCxUx5ZgmuoI045bFslCHzXuFwzqCrgjxWqBHikQN1JuzAzbh7TFxC
 g8a6QrCWc8kbQh1nXFtavHDrWoer7pGSj7moLXheRMC+/Nm0JtAKi+CPZqgJRvDQjX5t9TyW2Oa
 TcRKO01zbh7waepEsl+wfxOyAwTupQaD0IlNNZimhkDpoHLsyNx7V7pv/YacfqkxWQrVozKjKun
 lMy1Mcn34BBECyrFoM5M/VIPdTk1HN8anv+jcVtB8HUf6HhEoiLJ6LTK5tji1cSutCI3im2v1/h
 1Se24cvW1GgAn+WWk5d2yg/jabYO49TWox+MOu4BDlRW4qoiBVjuNIwO0pz/IpSQmnC0DIJ/f5j
 EmeyXq9XkTaUM5PR7lw==
X-Proofpoint-ORIG-GUID: 3ywty-3SFpfvuCFRUkB9pjyTkCA4UEEl
X-Authority-Analysis: v=2.4 cv=TNJ1jVla c=1 sm=1 tr=0 ts=6a7c712c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=nvPXPl7hlwrUdsg_yu4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 3ywty-3SFpfvuCFRUkB9pjyTkCA4UEEl
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfXxgNftsEK6lK3
 EZ9O5Pi4kC31DfvwPXVJW9/Cg1V0H9vbUSzKBQ49bEyQa25X74DQBpyfjKHEf8S+9K7v+eAVl0g
 DQKN2JlVRHQAHffq75iKT9y20W9SWok=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120107
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

qmp-dispatch.c calls aio_wait_kick() and monitor_cur(). Include the
header declaring them in order to avoid the following build failure
when refactoring unrelated headers:

  ../qapi/qmp-dispatch.c:126:12: error: call to undeclared function 'monitor_cur'
    126 |     assert(monitor_cur() == NULL);
        |            ^
  ../qapi/qmp-dispatch.c:141:5: error: call to undeclared function 'aio_wait_kick'
    141 |     aio_wait_kick();
        |     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 qapi/qmp-dispatch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index e3897d51977..965cad64998 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 
 #include "qemu/aio.h"
+#include "qemu/aio-wait.h"
 #include "qapi/compat-policy.h"
 #include "qapi/error.h"
 #include "qapi/qmp-registry.h"
@@ -24,6 +25,7 @@
 #include "qobject/qbool.h"
 #include "qemu/coroutine.h"
 #include "qemu/main-loop.h"
+#include "monitor/monitor.h"
 
 Visitor *qobject_input_visitor_new_qmp(QObject *obj)
 {
-- 
2.53.0


