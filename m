Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1FFC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGKz-0007Ft-3t; Wed, 12 Aug 2026 17:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGKs-00072c-Jc
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:18:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGKp-0007ly-MW
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:18:06 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2bqp4038351
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XRXzSgA7Adl7gZWlg6d1p79tZSCWK9Hf77fhujcSFnk=; b=nXyGLg5W+SjxO0O1
 aFK0q8W9oOp2Az05AzLS2EpETo/5QPAmxJVWGQs4NIpFfIpsWVcJViyeNY1zHOEf
 nQKNqkrAzg42AbXv/rAwCj32OWjO2Tmem+xwmiIAaVgRWKrubLw841jQWh7DIrgd
 t7hldz+gu7IW6n/92ptLRaUOR+BfKpCKFFkq6gJgUuphyJjck+i/300pt059ZlEZ
 UOtEmmFC0zT8mWoVwBzy7V514cdE/HUan19graGoklfgPQiQBJLSAGuWaMS9Its7
 ZbaPtA6txUM06qsFWLFVSc+/lZjYLb2lw4fsj3JD6MXLbNkpI9rGra5uPlE6Jl6d
 2sfdpQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0mndbfmh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:17:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c26012cd0so125881cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569470; x=1787174270; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XRXzSgA7Adl7gZWlg6d1p79tZSCWK9Hf77fhujcSFnk=;
 b=GldgDeMpcuwz+j9TQ3YfTMpIREHQFdRdTgJfdQ0kl4lijKXOyqkMCB7cAuBehB6gL/
 M2/0T7e9NmPYs0DLoFiqtS8+iorvY8XwQ7+Mst+K2scRHhUXUWU9hGHZOso6PPJBMyho
 AVzdyzSnjFy8mhjgQi1fCYCf9DNWzGSiqf4xIAuQpU8Zq7S5PrH13iI84HVEJKaSPfLe
 kZ+/y8G2y7jASQm4ZZY3tfYIJ5NEmzx4PX8XSOy4UH855R0lDVqRtjS5xPBrBKl9Q18K
 lrRHUFuNQnMG0ht+D44wgpkKetI1IQMCLjzZdNXg3Uf2rB+AsFtD7PGX+Qlzv+1l8hrF
 4Crg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569470; x=1787174270;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XRXzSgA7Adl7gZWlg6d1p79tZSCWK9Hf77fhujcSFnk=;
 b=PTKhOqQrXh8Kj23+92QypK2+ChbpcrP2O/W0B0GsomEiCURnWwSsbgoKe3LfvIbWre
 rxQuiDY9tDvWNM3kuIhiEIuscXfO4ZaUwRlVSIj337ND096g4ao1c1U/eGIaFqLBcLji
 Bh3fqZVmicTCGT/HjctCwWM5shdsfDJZjSgJFQUjjaQk6EHZHGeB3SoHsVNF7N7Ik0f2
 SAtvDdl3sXBPK0JtPBogWJeZFFrnbrIQTrJ7V/U9X/EnMISjpUKhCzjaJ9KVOt+Ad2Xr
 54FC6Fru16vyW4DLoOjHAqnc8aw03bXC2Q5zHRaId7Lo0RdmZWKPURTuWbNFxek13LSH
 N98g==
X-Gm-Message-State: AOJu0YwCxKRy6p6EY9SGuA2oPIFqE8uToBmkREeM6b5iLOQCR/F5txoU
 KwwucnFw4BCVhXfaxvjyYzZ+iFST/2brzdbgmA4PVRNELcfE49/0uZ8Zz9M8nFZ9Pl2n45YV2rp
 Gu9WfgegmIkScbMShOCgHIBDFSI1ylhZJsmD9icayH723kMrmNvM7QCHt47fGJwHamA==
X-Gm-Gg: AR+sD118MHJ3bnEAyA/dNNOAYYoCS2Aont5K4PcBBDJ+1nuBSul7lIzCvDVcjm66Rop
 8DSMOMkzzk7yuyGXgnVU43ykhvQhVHi+J6VD8yZPoimt1kvoBzYoRe/sZltdf1eT6rRmJ9E+S63
 /dwhasQrdetm+eSwHxCeNumAC4cIkMyPpGBC0qbHeoTr2rD8vmvfBDh03l2TVvVtUw4QozYNZ1F
 jYFZ4GkGIPxAZp64nvNNwjxPRsiylUhmCAHAoRe+L7HxyJSK8zfnd6J6X43p0jMoxYX4cKYtLS4
 gRDNu49bUM4czEw+8pnvUukW3cCsvr/BPtiI3yf9G5+KyeaGTqknSkckxtbbYYmOL+c4lnmyuub
 eM80qPWNvgh48yzzabX557HEPGMJ7zunbV9xELHTKhA==
X-Received: by 2002:a05:622a:1e1a:b0:52d:3ff0:62ae with SMTP id
 d75a77b69052e-52d73e07de7mr12729441cf.35.1786569470030; 
 Wed, 12 Aug 2026 14:17:50 -0700 (PDT)
X-Received: by 2002:a05:622a:1e1a:b0:52d:3ff0:62ae with SMTP id
 d75a77b69052e-52d73e07de7mr12727771cf.35.1786569468743; 
 Wed, 12 Aug 2026 14:17:48 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a5af45fsm527217f8f.18.2026.08.12.14.17.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 14:17:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH v3 05/23] qapi/qmp-registry: Remove unnecessary
 'monitor/monitor.h' header
Date: Wed, 12 Aug 2026 23:16:49 +0200
Message-ID: <20260812211708.92824-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812211708.92824-1-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfXxO95z2x6b+x8
 A8u00l/vBV2HapztvSSuKLXzzCbJZqlt+FvYMVoA++W9bjwHcfKv6UTOR3d0U5gRW7p8lYVUnPJ
 JO4b9Wpa+uMdi9stganKGvYOloYPZE8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX8+i0DD/JiH9E
 TpcWxVanqQRd5HrPARzbFjszMOqMP/M+D/XrZ3j1yOcfiMeY6JSjni++Pk2zF9Db0ZOYXhCTe+Q
 /UENw1bi08HQVcieSsHi9zGRs9wgdmuOjU+l+ZhRp6IJzO9brJeqxO7I5TJZYAZAppu9zDn+jAA
 3S/FfyGu8U4adfMcTTrWcTgdppYDPJPkqsBmhmAZp4SZX+CNDNjqBdiZ+t3iH5u8VM86id/WnlM
 3Ha1gqxSWKCeU+93AYm3KSpiroIEJAB+VbNfMFfrzMDdYU+ne31raiwMbWWi90U9IOTstkFF4VL
 Fjfm1Bap5+g4YjVFnfO0lWnCJVneWQMxcuyhkypG0FogoJLFOdEp9j3sxCd2ywhuQFur6XU1w5p
 LxGD2W3blV6BaxRwzXW0uO61Oe3j1RGkiv0L69eQ9Ljd+K7PRsBjqE2TWv8gvdRJe0TfZql9Qxq
 HX8uIctVHvmr1W0hnpA==
X-Proofpoint-GUID: N7UnxgwUogmxI1HisfEX0CqTMGMqyyCl
X-Authority-Analysis: v=2.4 cv=C87ZDwP+ c=1 sm=1 tr=0 ts=6a7ce2ff cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=hs6llZlkumWZFO0I0y4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: N7UnxgwUogmxI1HisfEX0CqTMGMqyyCl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120171
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


