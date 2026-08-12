Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38F7C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu80L-0006go-1H; Wed, 12 Aug 2026 08:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu80G-0006cO-13
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:24:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu80D-0001nm-7x
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:24:15 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4JQK2860020
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tzSJvizIBg6YtfGtqY4W6z6sjd8EIOyQn4ckmYQI+Ss=; b=o1HZhG7FflfHNwip
 1k7jfquI73566Cer5NenyfQjfROAf3ipPR4CGSz/rc/EqSOX6u8Yy/YrVopOorHT
 yQIMGaigQ3lkqyJDkjTIa9Kf79FAppHscpqXNqsGzBLd4CLfghJRvOr0liNSkONm
 QrZ7KOGxGHA/sTzo1bUoaME1sLyZgnItqGnbzvvG+on5dZ15vd33acUDZtyu8J7r
 5hjZPZXpUzhm38AJyEewCPPiZoS4QoNshMKkK6z9j0dr16rTH+37voWv9cDZ+BgP
 4VdrpIvu+ySQPvSWEY7wMu5j5xId+Ax5YzF0WvAQxzCJAx0XavuZCRWbrtE5BiIE
 wHe2Qg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0mnd9190-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:24:11 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52ce3c7cb2eso16029731cf.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786537451; x=1787142251; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tzSJvizIBg6YtfGtqY4W6z6sjd8EIOyQn4ckmYQI+Ss=;
 b=KrumhomB0lk3kohoGhlTqyV5FHchMZLOuoYdKbNlBKYSrhtfDM4Gl6zOjDRVYtnkJi
 ipZmoX8ZhH4Jl3T5rwOYJdMxGja56Q8z7kOW8MGIddoyLbYMxtPps5f5Q3pVqqZk14a/
 P+sLDw8lwaLzAN3h0MmUzMvk3WeXOJ27Uk1ouOY7PP/2Os165PkhcU7ksrKbX5EsOcOV
 PnTK04AkmhXME6MPsW8nTKC/vr/2mWizk13/4MtEAbTV8msNzRNo2VU/3nAfivgAoxY+
 ATea/CNIhplVUg7t6vO1nFgVzeuWFvYQuZCvKEG9IE3owWK/2VQUT7bV7inWKnHsamwu
 V44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537451; x=1787142251;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tzSJvizIBg6YtfGtqY4W6z6sjd8EIOyQn4ckmYQI+Ss=;
 b=NxVWP89MDglP6jz4Dad2m3LcNK9FHG48jJvcafKyhKES3BrVOVpF/Ohgi3ixfBmgFP
 70OEGoLFVAOSbltSF5CDDaC7LB8kEd4hbq2hhuQ32T0j1zrEXDwZtOq2K1gHLk6dPJFL
 yfSVLUmnT1uAo30vvA7j1GzVgw5dUWbqGRRvTZrLvbi1S1waMsQZlfVIOwdfx3Rg5CEB
 /6AcSX47UIifoPDtrig+a0CoUSuw3xa57ounMzPgJl8V7d3HIMLPb/63AxSRlByVuSoa
 PAtS2doL0ft9A4HCeCckHqXR111lP77idLcui7kdPUaaD/SE3IYSkmXPCHrttRKT4BIP
 q0CA==
X-Gm-Message-State: AOJu0YwAt1W9Kd79AB6EZVb6PeZEbBLBJuVE+TJ+Z1W4/4pMiU/dl4Pm
 zYTxpvwvIAk0fM3l4Hd+piXfIxVL5pbgzusas36eHc+NIdIGGaVz/XPpRi5FvBoPCRgOMOl20iB
 NAnbjGfmv/8NkHxgaygX+/A7P3qkRh2dU+vLfkTvyWFYSlNzdXVN2AlJwC1Uktng5YA==
X-Gm-Gg: AR+sD12+HiEYFJ93DVJFbIKCA28pdUepsQqeheVBYlVRHb6F6KrTgtwWnGRT0HJ1BE2
 cOuhMCzpKRzIe7R/dbmpwYaRUfOJEX/Nb+S5mNA89rRS32gtwbKzwN38vOveEZJteJPLaHbm6Wc
 WYmItE+O26pAJymuGTea8ArBW+VPSTP43ZCEaLvZScixKikeCZ1FKS3ldBiVFhHq+Isrf3bL7Ft
 w8abeQFXVg4vYHB9T6zS0Ztby+9K4jvHEYSTMr8FN+YeHJTyYm1PQUVQ5J32RpuUjrGnleqIkIS
 KASVrSnJJmMVerIHKMqrsPzhG/q4Ie3PnT60/kWqLoysfF1wAgJl0FlpBuvSohSAJVxlHcumo1G
 HbIiOG9vvKYrEIPQJxQNzvpblZ4C06Zpy2aZMTA/6rA==
X-Received: by 2002:a05:622a:14d4:b0:516:ed02:c85d with SMTP id
 d75a77b69052e-52d646c7b0amr29779721cf.3.1786537450765; 
 Wed, 12 Aug 2026 05:24:10 -0700 (PDT)
X-Received: by 2002:a05:622a:14d4:b0:516:ed02:c85d with SMTP id
 d75a77b69052e-52d646c7b0amr29779261cf.3.1786537450288; 
 Wed, 12 Aug 2026 05:24:10 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815231c308sm6452527f8f.11.2026.08.12.05.24.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 05:24:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 05/14] migration/hmp-cmds: Include
 'block/block-global-state.h' header
Date: Wed, 12 Aug 2026 14:23:22 +0200
Message-ID: <20260812122332.72975-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812122332.72975-1-philmd@oss.qualcomm.com>
References: <20260812122332.72975-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfX7PAdZ6M9V8nU
 KIqWm6euaCUBsfnzaPX1lDt+y6oQmTVsaUj3ECb4d11bpIt1bxciCTTZaNLPLHBOMrKCOc9ATkZ
 TVQwR80RbRy2ZE17p1slOA9et14LgsA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfX0uhSTh4t84Md
 1flQbglSuFZLvQTcuAqSZjMu8diTqbuGy7BUhJZsj5iZ8E9FvoNYtoAP6mtbEzJY5K2AenW54Em
 6mEbKo580m3pyONqZDI+KP4Wmodw5Jr56f2Tvc0GklgrMhOs6pJ/j4OEp4YzemeWE7pvVZlVfcW
 j6pDo9RXkqkRwGS28FZ3/BTbOcE4u6Cxwd7TmwsXkIz2ScZpL9Sc6CoeIuGwcaW7/xsKHtsrDBi
 8+mgEn8OOPbOSBJ01yhv3NkEBzAaypMlAlD+c5vhpAT5ATszpvn8pCY7wn+ekyO5cLwIDH57JXX
 WjVP7H0rEV1njvLFK6ZRQOWDEEqEXGYSlI14vCJ+kVdV7i+MEhzltvUlzHQYUx+79T7QzVBRW8H
 vGmmy23uyv5cb/mjQt0awaVdJgNbtm0DvbKAkGoex9FTjDVSmwKos2xr65mu/DR8/pusdXnqEnT
 rHHhrJBit5FT5lPO70A==
X-Proofpoint-GUID: qxaf0MrLH3NQdBmJoQOr5AvziaSgRCso
X-Authority-Analysis: v=2.4 cv=C87ZDwP+ c=1 sm=1 tr=0 ts=6a7c65eb cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=jqKsQrdABW1tU0UTsM0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: qxaf0MrLH3NQdBmJoQOr5AvziaSgRCso
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120100
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

migration-hmp-cmds.c uses types / methods declared in
"block/block-global-state.h".  Include the latter otherwise
we get when refactoring unrelated headers:

  ../migration/migration-hmp-cmds.c:911:5: error: use of undeclared identifier 'BdrvNextIterator'
    911 |     BdrvNextIterator it;
        |     ^
  ../migration/migration-hmp-cmds.c:918:15: error: call to undeclared function 'bdrv_first'
    918 |     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
        |               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 migration/migration-hmp-cmds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index b04fc4489f4..351512942af 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -15,6 +15,7 @@
 
 #include "qemu/osdep.h"
 #include "block/qapi.h"
+#include "block/block-global-state.h"
 #include "migration/snapshot.h"
 #include "monitor/hmp.h"
 #include "monitor/hmp-completion.h"
-- 
2.53.0


