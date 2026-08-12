Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D15C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8oC-0005rU-DH; Wed, 12 Aug 2026 09:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8kX-0003Ov-ON
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:12:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8kR-0006Mj-HX
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:12:04 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4SW93963406
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bFuDeXoeC1GFIVZCw6cd7z1siQifytuqe3A3UCzq9WM=; b=IIm1S+Nwd/sm+xvn
 +Nodqtwklv2IJFtw95984gv4RjHnbm73JwbG6ZlK5VzbmhrNHnvEdqGxg+f0ESHp
 EUOauC4nB6BP0ffJbOBYvSSboif4+u9RDMrVLCu/PsmpbKPFRWkv/v0lYDfRkyn7
 bExNnJGxN9lj9A1KY7czQZjLJ/yPeTqlamDIsencWX7FGxFC02o4x9Dw3WGYtFIw
 /Q3JVH2sfSlwZw6/miSoAp7wWvVM8OY8b/0O3g7zIyA4YhHLsEoq2y0RKcGIg4De
 qYvXcy6MtfD52/8iiq8NNxf0ZH57i5OIZgw9sZhJVG211/RlDipOVqQBKZQWJSKU
 4MC2Aw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0nucgwkw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:11:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5276aa86d00so10743681cf.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786540318; x=1787145118; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bFuDeXoeC1GFIVZCw6cd7z1siQifytuqe3A3UCzq9WM=;
 b=Rve4ha7Gf16006DRHRW5gmEnqHZ+zKrytAANDE9r/YzpgfKcr7odUwdQrswMZWk8tj
 HArg+BVegpDpxucys2CATo0hiSi5a8VHC3q7b9oIEwSDlauUTp80MLpUZ0wnR/W6ov4J
 t6wItsNLq55s7Ec0su4CgZKjI7tkOGALRegO5w8Tus9s++2lpJ7J1IkGh1weA01qMGdO
 Tg02aB64dyKkNohFgbrjOm7U10Ae1BMPkdgxB4495+yi7tiFkKihezpag5/44krh1XAf
 5axWM8TWvV8pX8a6Y0U/ByHYxZiWcpcMT15/4s7IENWbXZMwybj7Rrh8rpHlD+CAwd/r
 xOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786540318; x=1787145118;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bFuDeXoeC1GFIVZCw6cd7z1siQifytuqe3A3UCzq9WM=;
 b=QL8TSST1efSj47Cmj1Bp10aYmkiL61UwnqmAv4wccNxlXVCpCUsgoZ7jD6nG40sj7P
 RQp1Lk0UghuL6orSXHE8GNSmf3fKho+/ItAtlnlFQXc93qmWrK7PYGx+uIQWyBRjCuaQ
 eZoXqK43HoYyokwBtryQIH5gnCvy8KHY9Zvsz3pzHfX1pfNiZxir/KIcMMHUd7ekaP9p
 6dr5T30lbpZg5O9sJs1OF7+4ogDp60Q6UVRERY9wmhnEXwXJdtSN5vDhfMGANOfN7sn7
 SBOkphzoSnOwhC6lUGK0GpWcBxwB5l4IDGwBP/n2U2YCDVFCczgG+tN+LwLlJgLcRT13
 slHw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5INJfz7Aczp/71CYDS/LMqdbIR//y2bRXtMM1NMRrwB0v2v/Pl1RqUGXlrYJixhCC1RjVvQ+lxRiu@nongnu.org
X-Gm-Message-State: AOJu0YwBf8wF7jgFStdIkMHvNRyQeKi5zmes1sNkbyL5b1e6ecBWxJAU
 1veSLHjbHMo4ShJJCCvntllH9OlMwYiFJZEriFURz9c3KomvKPSD+suQ9RMAQqKQRS3rp3fIvYH
 llEqQnBK64xFvH/e8n6GKuIgt3TtxX8rmsVbvA8vzZYdL7GHyLxMUIEPNtA==
X-Gm-Gg: AR+sD10TJbtVe3EnWz1l1g+DLk120L8YDiXw0ZMH9mocMDeMImw/BFPwUJwkGEmwSB6
 kXpkT5BBqXHCUD9LyChPN0Wag0OkGFVVYhPbGCR7bAJa0HCopgxGI1Oy5GRNAacYoQ16LvN4Umo
 mR4SMo3hBixItNXS7JRhFFYPtIFLYqeGSU2ahlEHoIZD1MGMUSZx99ErhSOe2LKNf+HedV4ToYs
 WcTz9JR0Ns5d6b64q0JMNYS+3kfKXGUb6wP5iPUj8MoL6kUV/zhTMlPN8JGkZAmOogFgotGRYsF
 d5FQPwevSeoFOgIZDRtb0nl6gdyJWEq4KKTbFDooBrlw1eBWo6pp2l9TlSvtZCgI7lTryYqh9qC
 MT0p1e3yCczqNUboOZVDKcE+xxuSSwIDYaZJtckpOgg==
X-Received: by 2002:a05:622a:2b07:b0:51b:f640:2a4f with SMTP id
 d75a77b69052e-52d646b88f2mr41231191cf.4.1786540317874; 
 Wed, 12 Aug 2026 06:11:57 -0700 (PDT)
X-Received: by 2002:a05:622a:2b07:b0:51b:f640:2a4f with SMTP id
 d75a77b69052e-52d646b88f2mr41230251cf.4.1786540317407; 
 Wed, 12 Aug 2026 06:11:57 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997abf8fdcsm151719485e9.12.2026.08.12.06.11.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 06:11:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 01/16] hexagon: Remove unnecessary 'monitor/monitor.h'
 header
Date: Wed, 12 Aug 2026 15:11:32 +0200
Message-ID: <20260812131147.83188-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812131147.83188-1-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wyyZ_egwnHO4vWGu8KzZNjWircu9Lsjz
X-Proofpoint-ORIG-GUID: wyyZ_egwnHO4vWGu8KzZNjWircu9Lsjz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfX7XzXykU2XTnS
 uHQkJwjTUtSL5BPUMMr0KmxjFRWDE/xaxX3mfS/10HzgtGUuJuTYSu0+DRK1nskTCKVpGXAyxoC
 sD6D1q/Y5NhYLGbQuX8dpn4tYQdzNssdUBV1jnmfAVE+Jn89/laXBUEpxvn2CJ5MTG3tucGrxN6
 5klatFlrw3CWZK3Ey8x1c1uDSU+TayZgAqEBQByBydZ6LIpc7SWsoYI/hP/fzpM+Lz1Riex/g44
 EycNX5fvJ1Pjw280YojZkuAAb7FRclGDE3oF76GTt91kRorZQtkp1fXfGoUsegoEdq34kvFwYlu
 or+E41mKLpHmtO8I6DRPEw9Db2oRzeZTGq6qrRcpO2jjRzW7Dat+JBVLvqmGHgbuRMOOOdo3kGL
 laYu4RgfB+3exIttyljTLkaezHavw7YYOzkqtuQjkfPRSpK1E2H56pY9IMwDY8TC7Pm+wat9Pgo
 BAvWP+idGT/v/+lTnYA==
X-Authority-Analysis: v=2.4 cv=VcjH+lp9 c=1 sm=1 tr=0 ts=6a7c711e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=-f94bmcIBZYFaPXTGXwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfX40jFakep7C4x
 lO6GaITCf4+xOYn5BFYtclD7yyDU4ANcd/gr3zULWg7J/pRV56RMvy1nhIOKG5HBtTRgUTczABS
 lPWMk7wbTrSI9XXBE/u5D1skCzrWJ+8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
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


