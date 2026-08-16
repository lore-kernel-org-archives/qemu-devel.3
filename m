Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E675C5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcDI-0006i7-TI; Sun, 16 Aug 2026 10:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcDH-0006he-3s
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:51:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcDF-0001uQ-MQ
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:51:50 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDlbUQ3534233
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a9khp9AuqoA/g4bzhUPoCf7nGUm5N3Vn1ZR7Ue779bg=; b=cQk1EllVqUGW06kk
 lkIt/u+s6i+xkP2/DP0M9F6/qN6bxM3j8X2KekfqZT8CR/Ki7FcG/Whm4GXWLZYK
 V3VJgd5iQOMQcM1qrwmp1dylm+Wl/Gcsxi4X7fhtVvqvbzx+9A/GIhEMaaSulKke
 0HN45yVBUF+7YrmUcZXjWtISvK2u6i8zyV3YidDahwMmdsA2GqrLYH2DbWutLHL9
 ESdIZlTfxEyxdnzqHyosLYkbxRYtXreuJZD9R/P7SzmyI75T9uxotceXzQL/0Rpe
 uc+t/zqmXyROqZcxWnGaKR6oOVrdX8n4iNjmyJQP2REKiWAL+RKFrVhOMi1SscK3
 dwjNeg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghf3mnj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:51:48 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c19493ac2so27615911cf.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891906; x=1787496706; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a9khp9AuqoA/g4bzhUPoCf7nGUm5N3Vn1ZR7Ue779bg=;
 b=CVmJFqi1PqUGWFi4OkfCuXjeoi9w3KpI34WktQTLPWYOlqbZYZ7/63hvk0UAWJjpVn
 mVX/r50UgHkthsb/N/sRHSH/C9N5ijad8gFQ0OPsCCOcSXv7VwaZgZwGSnhGojmH6kKe
 7lMi5DsSh9mdSfqYMy8RZ6uTYn/vUxSlO/pdEVRrGhUVYhQw1KGttIh5ZFAVoxxIBc4c
 9OBh33pPqtCN7Tb5A7RofLrhS6zyS0+1Cjrl3/DH+sW5Er/NRtJkPS0hhHqpt+vVQFgN
 eem6Q+/h7u3Oyvt39t3an6hpYte552eZUqqjef/OqyfLjZkEUG+Jgl9oHOMnWr+FrqH3
 5c7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891906; x=1787496706;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a9khp9AuqoA/g4bzhUPoCf7nGUm5N3Vn1ZR7Ue779bg=;
 b=s6oXWnYfDW2PKwH6SjqTYDMZ3WHbqYUOQnx/1j6o87TfycZVcZpAHhfiOdg1xns4Fz
 65VFAL0nI5D6Zs4jLru+aP9NiQpyLcbs/qvnOq7R7Tslxg/zTR8L1Jue/ilvId0bX+mj
 3sXqd5UvvaAHcPYpU3Tmf68YGtCv1frG0mAj4mKqV++3YjmJzxpVBv5IvRScasehmm3g
 fk508oMLx7gDCR2DYmMukxmTEaomjcFunxIoVqcIjkN1HjMO+Jr3bOljCQzjnYb1exlw
 nKthm6puUgc87FTcGgnu6krjKGFpPGZJHRN7MfCf7AdH3UDaYBGtlOQI5PZ7OXidzmh4
 SR1Q==
X-Gm-Message-State: AOJu0YxHZgCaJ1w/zy+QrcXZ4Wvdt1Y2A9/aAia+bmAymMFOZ6VFHehN
 +KY9OOeYWG07QVahwPP8JetsGPDBUORPTUEAu+4QSWHjtDEv9Ccoy+6GjAlt57zuS9dm5b6DoEe
 Y1EAyluG3mIjhlbI5BG4SbwPXhMtRt3uTlj2bgJ6KVPFIQ1f1ItHoa6zKvv52v0hbCg==
X-Gm-Gg: AR+sD10y/gl9sS8VdLGXmpIkBRpA1w/wEPuqc6JX6C1NtRmJtRyGHxPD+Fsb2oygeMf
 nSxkXckCVf2KkDuPmXNxbPpJk1Q1KNqoGxFKJMNZ/sI0jrZ3nh9Rmq145Bz7eX9tjTYYyqIH9NO
 IXgbrD26fbzdRv+TdUx5wiVJTV/2V+SBUM2FUBRrRXtNDOb5PbNzbWiKr0VDNge5wLiDqQAdXBp
 MbQhGgcVw/yHDoBQcaf5Eo6ydO610L8CepUA5bDuscFe/G+ij/X0JBb1m+p8WEvUc0P8lIVH3jd
 zNE856o/8ta2bGd0zF0fLHfiHKsx3WBxwAfkJWZjce1ngmr8M7Fa4nume3ek9rM7pWDKKQ+DTo6
 92jucOCip+wUTghldMc6knMf60+DUza4T7uZDMLo2Tw==
X-Received: by 2002:a05:622a:4118:b0:51c:1a4c:3c9f with SMTP id
 d75a77b69052e-52d85378db3mr218700111cf.4.1786891905753; 
 Sun, 16 Aug 2026 07:51:45 -0700 (PDT)
X-Received: by 2002:a05:622a:4118:b0:51c:1a4c:3c9f with SMTP id
 d75a77b69052e-52d85378db3mr218699821cf.4.1786891905368; 
 Sun, 16 Aug 2026 07:51:45 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f20058fsm27131895f8f.4.2026.08.16.07.51.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:51:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 40/56] qapi/qmp-registry: Remove unnecessary
 'monitor/monitor.h' header
Date: Sun, 16 Aug 2026 16:45:39 +0200
Message-ID: <20260816144556.69009-41-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QsVuG1yd c=1 sm=1 tr=0 ts=6a81ce84 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=hs6llZlkumWZFO0I0y4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: CnZFl0dj2RG5iXpkBPilferETILcszvx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfXxdqMSMQVVXnq
 FQAb4j9kgZQgXTMYNheu19lRmSHMODWAAVngapma9/UyTFSPH/9t5tkEv4mtgP4wCLYGemId5Dl
 fKw8t7rRSd26dqKH53FWaf7hiJ3WO/qcSlFl2CVp1ampqb2ZbqG101UAJyCj0Agtrb4Sdl4dM7T
 Sj1y5gujYzodyjdKb+xme/u+HGj4UF5MetoaD/9Df6Nw2WQ7GVY35xJ8W5fJcFUaX2Gbz1LfHBr
 RaHGao2YPJeD2rC+FZI5TyjbwaD8jd2QOOEddejjpZr1ceYvqlsqjTMTZmq7wNXm1g8d1Pp9NPs
 4/UM2/G3AQdJokGcRAHbu2cJV5dBtNjyfPXuH+VJ+sEFb2IjyirwRuvDQvlF543whyAevNQUJ/c
 A0+Rmwbj1QaDsh5l0xiwycc7NsPYK1+yl7PHS7H5JGM9txHtBKZn2ciMR3XRJz4/Pg4HPWCTm5X
 IzWt5bDE4k4BcgkU2cA==
X-Proofpoint-ORIG-GUID: CnZFl0dj2RG5iXpkBPilferETILcszvx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX9yZoZBrLyyGF
 tgdychVlt28Jqo3XSiqLj8pW6Ich9fWBK5HFgRoFsmvrNo3z5k+VheMb/bOktR+Sf2+x7CXqcK4
 BgtDYiQVvrcVHlgSeeWyhYzrrNxN2XQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160119
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260812211708.92824-6-philmd@oss.qualcomm.com>
---
 include/qapi/qmp-registry.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/qapi/qmp-registry.h b/include/qapi/qmp-registry.h
index e0ee1ad3ac6..6146306a3a1 100644
--- a/include/qapi/qmp-registry.h
+++ b/include/qapi/qmp-registry.h
@@ -14,7 +14,6 @@
 #ifndef QAPI_QMP_DISPATCH_H
 #define QAPI_QMP_DISPATCH_H
 
-#include "monitor/monitor.h"
 #include "qemu/queue.h"
 
 typedef void (QmpCommandFunc)(QDict *, QObject **, Error **);
-- 
2.53.0


