Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17CBC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu809-0006Z9-HX; Wed, 12 Aug 2026 08:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu800-0006Xv-EP
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:24:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu7zy-0001lD-Ot
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:24:00 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4XOt3637939
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sMhnZePIGQRJ1GcAmTkyA85QXWrCwBcN99I8ECvu43Y=; b=hZU9YqTwY8TvwrOV
 ZmbGd8ZIWTYYZwl6C6AwrbOS3YdKsI9tB+Xk9YzyB3KyIGjmjWLH3TBYXB+Sxvit
 CnRrsyRTX1MaOFPhOppmt8uptxJgJSmdJ95eUfUSrtFmQcCvFU0wLqZ9mLeciPB7
 nXXkAE54Vf/Qs83A5w38SrVnOrrDcZubW/ARXXTuZqWjSxz4VIiVHF0tGUFogNd9
 houN8EsuhpUlewfvI2GH/tdzcgxzZdNyhwVhQCn6+IwpuFDQE9RzlSq+i3btkJzG
 eJrIFI2rMjBILSg1AZBYPWLaeCIkCbT7aN8Im4nL580x3H4x0bAosNWKpC3fv57Z
 5jnzQg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0jgrhjtk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:23:57 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52d33c89a29so7195911cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786537437; x=1787142237; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sMhnZePIGQRJ1GcAmTkyA85QXWrCwBcN99I8ECvu43Y=;
 b=c3StNn7/tYSgz7g5g6fUfwKhQJuxzzlUjDAY1HtqsV34rSywbrBi8W2wP+PvuJdKeq
 pGDR7+9AXpne2sv8/2E9R+IRqMWlyHofsLblj5lItb+GPeaVaT50TdI9VFDH8UdOx4BY
 I69ULQo/LtZJPjLueFgXP0rgx5oSWY83KMqL7ut6lKv6aSjACmc7XFEmlEwa7nsT6ljH
 zKnCFuZXnpNdoPak5/N4aTUejmh5WbciDROd+I/BibsKzO2GzlvPz3FHvFEWYMyZk/y9
 aUoF7UoxYpr2v9bQgEf5W3XNKNS9ubzbids1lFfYbHXM1wUXWXEciXXK09WyYb+MkJ2g
 1JRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537437; x=1787142237;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sMhnZePIGQRJ1GcAmTkyA85QXWrCwBcN99I8ECvu43Y=;
 b=kZP8kYfdQL+tD2B93OAjHcL2jU9d/ZX+UE1eIk5rSKPrvuhAh4nRD5+AV+mFKPXnl+
 eKiApbn1n7IHRxezWVSzxQ7L30tTyL5xN3jeN/n8ORuUksIUxNlx4H8uFry48kj0jOId
 rDGE/4VTc2823YI07+GuANC8QWf8cktqa0+tHX2XSLFYauF8X1zua9g8eUBdUqV8yukj
 hu+Ll6i6RZIMI7tszTTxOCxZP+PzDvBOjW+TsYRI/D9ncYwyR3KVScpFx/yxa4Gfj0Ci
 uvZauBz5q0KJXjsSBEXdioO4KLh9y/1Ukqgfx+bQhYjqDD0pUDIBhAI97GbsltxQW4Nl
 Kdng==
X-Gm-Message-State: AOJu0YzF37WWqrvV1F+oy4GmtAYUFbmQTgmNzm167vEECxTVqmf6NhOs
 wLENH4b13Z+sptkWs8r33jhTJGoE9IZSCs0ZCPOAJnwYhwGajPOTArxCxrj3eGxd4emBoiHKirT
 rNy3e/DlJvh43a/DlU971m/fXrpb4sZevi7xUrgsk/Rgb9MNjQUjH/hkySwMzVRdR3w==
X-Gm-Gg: AR+sD10p/XXVu0BFdS00CmTIR+iMHgtH4xuuXrC+tos4029XVt5NpcMfVbi5lU9Ap8z
 coCPmw5StWZpKgUxu4PNNzMeCdyyItp7Rtf1KdqJDdrO0V8gVTFjxd8ab66yRQVCWfgumjO2vvi
 TP83v+DGp4TLuIgJGdbxzd8F5buljhwwC7v0ivKPsIWUgpnRuqtaVJKZ0Bs9pyT1XXlf9qKuZZx
 gTETBgbqoKlnnzXueM7rN1W2NI1WMg9V25xsA2OAnH9BjNjSRIljUxfiexzf2WdSpmCvRA+v+yw
 l1KFaNIEvYVykzMgGzyFRCyjsRdk2m/Ib/8KD/xZrguN63d73im2ASNLxwjXSqsBTCT3HyPiefe
 lmXlEgAPJWYfA1wWyPAGjeHi3Kb+PIu6uv5kLewE+lg==
X-Received: by 2002:ac8:5982:0:b0:52c:cc14:ff5f with SMTP id
 d75a77b69052e-52d64907e0amr34640021cf.38.1786537436849; 
 Wed, 12 Aug 2026 05:23:56 -0700 (PDT)
X-Received: by 2002:ac8:5982:0:b0:52c:cc14:ff5f with SMTP id
 d75a77b69052e-52d64907e0amr34639601cf.38.1786537436302; 
 Wed, 12 Aug 2026 05:23:56 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d5dfadsm7383472f8f.29.2026.08.12.05.23.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 05:23:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH 03/14] qapi/qmp-dispatch: Include 'qemu/aio-wait.h' and
 'monitor/monitor.h'
Date: Wed, 12 Aug 2026 14:23:20 +0200
Message-ID: <20260812122332.72975-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812122332.72975-1-philmd@oss.qualcomm.com>
References: <20260812122332.72975-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfXzGXY8fCiNYUN
 ij/G1TyjUiZnxEkydJvE4JXmW8sUX6a65n8jFzHObPt2KNVw6+mr6TlcepKqr0+0ZpNc7LqkIdo
 aEiwkS4S1aemOsilGR9O9fsCa+TZW6oGOoBQKt49yMXd/aPM34r2MFWse2JmW/k0rqSphnFCqWQ
 0FP3TqhUYPEMb6rTSMz5mW9cYkwgvyFnkG0ayqPXw7q+/4tKe+DFXvERxR+jpyxGGSWUdnMgyBn
 1xLNUEaWY9VXbSFxtcIStHbehEw0wGu6BY61IREmprg6F68eCBKje8c6R+eX6eTUBnElGfiO97y
 D7+FUgkMbX4yr4AOcKjLX0ELDElu/mLahkHeIX2hrllTs+PgzWEK4OF7JNzHkAjQTu5PfVofD2+
 OXow4tFNb2pT32bloTmQoZyKxGasPMCH03YjxLR8mCd1RxgzsOzo6IiyVLnwAouJWrNmWhzmskS
 QDN6x4eR1PBdhJE3jJw==
X-Proofpoint-ORIG-GUID: V0Ai7uA6O1GryrqZCVxfRSi3lwT2W3Nz
X-Authority-Analysis: v=2.4 cv=TNJ1jVla c=1 sm=1 tr=0 ts=6a7c65dd cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=nvPXPl7hlwrUdsg_yu4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: V0Ai7uA6O1GryrqZCVxfRSi3lwT2W3Nz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfXwzxjtK9nZ15U
 qu7XjW+K2gASYTnkzaMf9ebo8z8EDBphgB02iWtRxrcJAwmC6ohGRFfXjya2x6P0WYt8ZKJ5BlP
 Sstek8vOJCyMlOusz2awyk1VMDAJw+I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120100
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


