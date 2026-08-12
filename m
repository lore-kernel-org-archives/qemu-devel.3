Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1808C5CFEE
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7zv-0006Ia-UH; Wed, 12 Aug 2026 08:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu7zn-0006A9-3R
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:23:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu7zl-0001hS-Fb
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:23:46 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4XEA4182216
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bFuDeXoeC1GFIVZCw6cd7z1siQifytuqe3A3UCzq9WM=; b=lu5qCbzdIorjoRBc
 Px8y3k92GyYwnA6qtvt9ekT+CVii2sX3q++eHuTuTHGHJiSSp4pNnkYSS2nuARwO
 nnlab05MwjRbmHo3+ckyZcSisHP8goHC0HDAu67CnBUrs/WsHJERiA1A4PLf2u2I
 NtB/eYLo/kN4b5/mnlbmVvBl0CHuXfYtsANV5CFGIVqJF3n3q5WxnXPZ9YMZG0F2
 vXJq1QQYWFcISg6hdvzlMU+WKxVQ1gMHXcGNcF3F5mPGfWK7gHURMtTsPSsOdYmE
 61nD9KhVSsi6LssKZJeD851jmpjxcIJgqdNulSQ0DA8ddyFdu5WS+XuEWD2VWu9J
 U6awRg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08j5ksf3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:23:43 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5276aa86d00so10203581cf.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786537422; x=1787142222; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bFuDeXoeC1GFIVZCw6cd7z1siQifytuqe3A3UCzq9WM=;
 b=hgbvguYvvsipXu2euZiF6LlY3G2As6vWsq1Awjng6bgJFuPYXwTxPlUmxd0tbgoZ/G
 cpdMvedIAtTqiwT98zx95uBqv5IYg1h6FBUTchiTWQ4PtTgGqB/nCm2JD3MvJ64vNvMs
 h1lVOfRS/Zp/B18fyQ1bXqlPpVWgqbs1ydClZld+Ag7Vua4ochcFa6yFpDfAL40hKy2e
 bO/CZteaN1SLqHWgUcz1O6PTNJOxHKTx9KocgmQ1oiFcjWCS80QJSuarlE7JI6qkS2MB
 ADE5WQrjiEUjn9mlPY4qIML3GaCcDkd4O15YGG0GQp1ryvgPWyl6SVADtsBQpiP8nVGr
 p84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537422; x=1787142222;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bFuDeXoeC1GFIVZCw6cd7z1siQifytuqe3A3UCzq9WM=;
 b=sUqnbT8PgpedlZhDgC9GO/20m5fyR8TjyN1hpeKwcEkOSEc77haZw9thn0fBjfB5ca
 3JpiJP5mBJxq3umDH0i1bs414zIXNCaBv1bWYfZJ5vJiewx1mVwS9dkTRGUm8xyZExUO
 kVN4VaZGbFBuCrP1blxW1MLuGygriXWRM3MFKISJLdLEPihwn2USmAW/O4f08JJrJy3g
 4gbz6/2KZnYwRBtjhxxXfyGJk8sQzrFF2fi1BcJ8Zo19h4ZiqmBjfueMJru+QzjmV5hR
 Cf7XAnkmu2GjvFwZXmurAen2kKIs7nxcBKEHYyBH6inWWrG3395zkVOefUHg2UhvJJ6U
 XSdw==
X-Gm-Message-State: AOJu0Yw9DL8laKWBHV6xLdbbgrpIpxonGHFS8fta7MRAdA4J4bsybfPL
 eFXZuzeUKUcD1VZMHxGc4CR7zDZ5GDxKgzeEj4IblnWrVWazOLMTaFI/4gnGwm8eUbrX+kIfYac
 ZLoEwu3GyES7u12sxQSuVu78OyfpR5LI2FgVWc8342yjsPmvmfD8GxHXXRtW/IyQk5g==
X-Gm-Gg: AR+sD10XF0gYYUpakDXzJisPjhf0AV6dkGZByhMIrdZxKLABODKJyfgiib/Eq+WamgT
 QafjY0AXNApc5UXAkc9zra5W+xhSRM4lODIBNsDbN0mXMMSmdEej+2qDFLyBMPPwnqWslvxCOSk
 2NmxOwmBKum4gBFLgKZMARyrwQJzHfY34rcsBQIis2GiL8xa1BY/Tz7M7WDGzySYpRpWMoK/DxJ
 wFhrx1eJp4EMjVIjkbBvJslqo1dYNU0SALT0pQA82grf+eW9lQMXIDKue0tyD9LRoKYGSPGReye
 4JXjBZ00PILOPedj6rXRhawv9YIcIkCpJGVlP6jGwwQWXhLGZ1oF/AKspVqOsDnrVRYaG0lUCvX
 cikhmhqYk6Mx7Zly4azIhND14/rznvDQ1D56g55w/QQ==
X-Received: by 2002:ac8:584d:0:b0:519:89b6:78b4 with SMTP id
 d75a77b69052e-52d648644f2mr36007371cf.40.1786537422611; 
 Wed, 12 Aug 2026 05:23:42 -0700 (PDT)
X-Received: by 2002:ac8:584d:0:b0:519:89b6:78b4 with SMTP id
 d75a77b69052e-52d648644f2mr36006991cf.40.1786537422195; 
 Wed, 12 Aug 2026 05:23:42 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997aaaecabsm73409225e9.5.2026.08.12.05.23.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 05:23:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 01/14] hexagon: Remove unnecessary 'monitor/monitor.h' header
Date: Wed, 12 Aug 2026 14:23:18 +0200
Message-ID: <20260812122332.72975-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812122332.72975-1-philmd@oss.qualcomm.com>
References: <20260812122332.72975-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfX/b614Zmw8WkF
 Ck2wWRLNFaHI/mB2WjzDTbZQOvBi0EGyVwntPI8wa/dOuVD/GrVxc0Djk40AgFdL5BHzOJY8Dq4
 TdmFYif2QNZxJe2mwPzGyoU/QOHxyU0=
X-Authority-Analysis: v=2.4 cv=evHvCIpX c=1 sm=1 tr=0 ts=6a7c65cf cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=-f94bmcIBZYFaPXTGXwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: QEBrnQwEiELkQv6A7iSdmAKe4YGgjO4h
X-Proofpoint-ORIG-GUID: QEBrnQwEiELkQv6A7iSdmAKe4YGgjO4h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfX8bl3FSew9cIN
 Y9LzqDMMxKqhQvYC0Hc5GlFilMBbThufxPGtQrU/Y45t47fbCwe/TeN/w3KuVIBmJqRj07lXBPI
 4lFuG9bbKV2ch+EPW1IgAndxDKbOXwHM5zrvahDq3Xrvu0E0gMCqWrEMbvWN5wD1N8MllEI4Ude
 c/RCQk+1WZS4fCQW+OmriGiPl68W26OB4GMIni4qyRPInNnfGGIaCW4IDnICyac23JslyDPSDaK
 Oe2bYAZ8ryreT2pDezErxXr0I0UZiL7ozmuY5H6+uGsvxeJwBIjRmdPWoWd7CUzj7K4P+BjQBzB
 a9wEtxE9eZuMA7mjP8a027JcrCm4aLrp/BKMbQZwqLa//gZ3Y8HQgHMOuEx1oMNJNn9cBEHgEX3
 L8wdQIa0fEzRz/lRM2SnYXoGi4d2Kj7SzVBski2p96wSxDN00ew8G4ot02gEHi7eYD8dns1kqYi
 7elV6fdHld38z9m492w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120100
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

The Monitor type is used in these 2 files, as a pointer.
Since the type is forward-declared in "qemu/typedefs.h",
which all source files include via "qemu/osdep.h", we do
not need to include it.

Do however include "exec/hwaddr.h" and "exec/mmu-access-type.h"
which declare the types used by hex_tlb_find_match prototype:

  extern bool hex_tlb_find_match(CPUHexagonState *env, uint32_t VA,
                                 MMUAccessType access_type, hwaddr *PA, int *prot,
                                 ^^^^^^^^^^^^^              ^^^^^^
                                 uint64_t *size, int32_t *excp, int mmu_idx);

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/hexagon/hexagon_tlb.h | 2 +-
 target/hexagon/hex_mmu.h         | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/hexagon/hexagon_tlb.h b/include/hw/hexagon/hexagon_tlb.h
index 90d9ed84043..760dc1ea811 100644
--- a/include/hw/hexagon/hexagon_tlb.h
+++ b/include/hw/hexagon/hexagon_tlb.h
@@ -12,7 +12,7 @@
 #include "qom/object.h"
 #include "exec/hwaddr.h"
 #include "exec/mmu-access-type.h"
-#include "monitor/monitor.h"
+
 #define TYPE_HEXAGON_TLB "hexagon-tlb"
 OBJECT_DECLARE_SIMPLE_TYPE(HexagonTLBState, HEXAGON_TLB)
 
diff --git a/target/hexagon/hex_mmu.h b/target/hexagon/hex_mmu.h
index 4f556c715a9..6aa450b9413 100644
--- a/target/hexagon/hex_mmu.h
+++ b/target/hexagon/hex_mmu.h
@@ -7,8 +7,9 @@
 #ifndef HEXAGON_MMU_H
 #define HEXAGON_MMU_H
 
+#include "exec/hwaddr.h"
+#include "exec/mmu-access-type.h"
 #include "cpu.h"
-#include "monitor/monitor.h"
 
 extern void hex_tlbw(CPUHexagonState *env, uint32_t index, uint64_t value);
 extern uint32_t hex_tlb_lookup(CPUHexagonState *env, uint32_t ssr, uint32_t VA);
-- 
2.53.0


