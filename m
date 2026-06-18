Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999D4CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBrr-00080L-R0; Thu, 18 Jun 2026 08:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBro-00080A-Ot
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:29:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBrn-0007Zr-0H
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:29:08 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAreAV1054879
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PlDM/g2rSXeAVJuQ8J6ecDyvQnPg2dW9LpWDy9v5/2I=; b=Gvqu4IXhL9IeNofm
 X8mj6M32yCw9dP9unEn6ELS3R36cAjiKH7OhiNzw/JX21EdKGzo/Y8F1F5w35rOf
 Oq/len8/TQRhQqsP/DzjrijxKW3Quf5iO1UVg0kM26HyC7I6e60OYk7TUhDHWIBp
 NsqCJWi3qP8CKUnfQg8TUdAcDzqA0C02qcP+DtCM+S9k30dD97GSNWXBkz0ozKYp
 IYKSZJo8InRmTGIpEY3QAdyvMQUYnxQSyLh+BnNjplunlqG7DlLeZE7cA2tMH7pk
 xtbUyaulVY5EM1eUyFWO3CztNjDPEOnttu4bYGsYVBD8MYOJQP3nvtOaQDqYVwE5
 i3fnEw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2ccf95-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:29:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-91598ab3a1aso153929085a.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785745; x=1782390545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PlDM/g2rSXeAVJuQ8J6ecDyvQnPg2dW9LpWDy9v5/2I=;
 b=DXgGr3dEuhgMnGqhIA40fruQGsUULwLf8EuoRG1f8lEyBA+qEDwMKGELWRQg6htU2q
 g+Z+TP4DMI1Fu/Mu4uAU5OVgKA4gpk4144Rh0xTO/yzW/qKay2Njqx84Znc5nn1TI+fn
 4nJlnuOp084Euk+ZuTId9ZtagOwun/yMdTCVF4ZUC501nzkVZfABsKViSctWc89UxE2L
 a4eOHOgl/RuJX01c+iV6xe7+rgrxFhwk4tZtV20LnojQ+9U+ZsjWseu/zwgUSxW5JJj6
 zYucgGEvMdZj6cRtZpiG2YI5AhMlltoZ1WvBkivUgqlKgPKwI1NPn/C6ZdqZU9W9+zWz
 fhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785745; x=1782390545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PlDM/g2rSXeAVJuQ8J6ecDyvQnPg2dW9LpWDy9v5/2I=;
 b=D0oqBw+Nf+Oa26XfEo/7Jvq8Vb3fLGRSEX8GLYockbljC5XWwM16F0yl1VJ29m385P
 Yt7G53ZrM6SdRJyykIehnwWCsL1bs2HPpyHa5VxAszUPU5x7hZSetV08Gbk+U+1ZwIR6
 WVha1rWChpd0xqUwjVWm/+a3ZzzXMzD8mjlKhdwt2ZESFg8UzQ12PF+ERjNVMj+SvnaA
 +FdTLatFVQw8GYy3z7qQR5NbNFzHFo63JzohX57EkeA62EbPVuEtARVgAyxKlM5BwBXf
 4Fds5TCE9M6tA+1Xsa/IYecaMmeQ1Sq/vClBPsGIaoyWt12XGQfZynzOaBqXTuXETEQC
 lBZw==
X-Gm-Message-State: AOJu0YzCXVdyt/y7XDHVmgLT+ut+8A3trGJm9PozXgb1T9kPGZrntR6s
 zyYSvdw9Ym3zruj++C/NrWPWFBx5iXv6TQu6bS/Nr4dZ+P4nXMXD19d+Njui2IM500tHqW0PUVG
 QJBjuA9vM9wtpDYIE2n5S2JH18q0DvpbK8B6jSiBk8RUK+OHeZT9BkjWAJx+qmZFE8A==
X-Gm-Gg: AfdE7ckapt69tXJXzIN74YsRpJ2hQcOUH1k5oib+ogLFMI5KgX7ASWN+JUoeOW33iIW
 4sOlvZaQwO6lxfxW1EGxRcYtoTvqV5peqZOKLcZ+6N3UY24zQ+35viGlFGs5604pEXXp6kumY3t
 6lweI4KToP4i9IpUev4I5A041fnoBnKpV/+JTP3AVc0V7BJOhzKWiiQ7+6+XvV4u2d3kh2XG6dZ
 qVpjrd/1A/5+lJQwG5mvpPw0GwWqNKGJ6w0a9I3pIFHNsuiI16Vy/uB5YQPVNYQ/DecA8eyHIbT
 ydTyluIE+s9bxHvnuXLldKbT3ggyeZxv6MscvICZ1dhlOE4ONeU1j2KJLDLVvWD41ORFK1l1+kx
 33NCf4rC0cJ+F4arUWXRnwdC45xN+WiFKZYh2ybWvFm1OFkJ4X9uEHaquLoub1Q17WIAf
X-Received: by 2002:a05:620a:390c:b0:915:7ecf:86e3 with SMTP id
 af79cd13be357-91dbb94a887mr1291409685a.29.1781785744724; 
 Thu, 18 Jun 2026 05:29:04 -0700 (PDT)
X-Received: by 2002:a05:620a:390c:b0:915:7ecf:86e3 with SMTP id
 af79cd13be357-91dbb94a887mr1291402385a.29.1781785744015; 
 Thu, 18 Jun 2026 05:29:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923a1d6d1csm29750375e9.2.2026.06.18.05.29.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:29:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/48] system/memory: Constify various AddressSpace arguments
 (cache)
Date: Thu, 18 Jun 2026 14:27:42 +0200
Message-ID: <20260618122825.90331-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX47bcTA6ZiDQx
 +u4emne0n1Gg4gcJYRe97j7TmK/fHIZd1Hp5Yk5qEkgQx9PUOpDklICug26hPjK8BCnWt6klp4/
 VqyHUVfUXzJCzbNESu4eOmwfTSajAZ3S8NKDRH4B7F5qavzply8iKsOxeT/17X8e+eF3Urvpzft
 Wy57YKpm/znsjB9caZZocfP7Gqv3OHw5h1NX1zEd77psQW1SZvih3peTTy/vI5Frc9F3vxrspZI
 LIVBasleLwiIKSd1X5uH+838Ee7GAPaeGoQpoYlFvYJewA+8zs+yea/8MhGQ2bFsD/5/7JGWRjf
 bravAqXYZU1Fz26ScMx9tE8TLEu1/qqmLdivrMab/MAY8P9bYQAVW2by3jrxnie5TMnTic31YVt
 1Rm3iRxv/IbAi4aexCfYS4DfDWHYIe6D+LJXXYSAS0hMJcNX3hid1vyCD1PlLNdlItMtDqbeM0V
 nW2xO7Z0/1ddVfMrIqA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX59vHe0SPZxlt
 mLu0rxQp1vumAPQylIvNRaJm0KavccruGzaRINEa2TVbpKt43EKXzQNAlPh/9vK4A6tQKBqsiW6
 lFqZw2egnkCXjtaMOgbz7ZylhAYs1eE=
X-Proofpoint-GUID: rM4-Am3VUrFM9iLrDI_Jp0UZ3uL2ZZ1u
X-Proofpoint-ORIG-GUID: rM4-Am3VUrFM9iLrDI_Jp0UZ3uL2ZZ1u
X-Authority-Analysis: v=2.4 cv=WN1PmHsR c=1 sm=1 tr=0 ts=6a33e491 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=e-NtlPoBfifz4Kb8xpcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180116
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Mark the AddressSpace structure const when it is only accessed
read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260616020359.18627-5-philmd@oss.qualcomm.com>
---
 include/system/memory_cached.h | 2 +-
 system/physmem.c               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/system/memory_cached.h b/include/system/memory_cached.h
index 6eb6179140b..760ecb38c19 100644
--- a/include/system/memory_cached.h
+++ b/include/system/memory_cached.h
@@ -117,7 +117,7 @@ void address_space_stb_cached(MemoryRegionCache *cache,
  * are relative to @addr.
  */
 int64_t address_space_cache_init(MemoryRegionCache *cache,
-                                 AddressSpace *as,
+                                 const AddressSpace *as,
                                  hwaddr addr,
                                  hwaddr len,
                                  bool is_write);
diff --git a/system/physmem.c b/system/physmem.c
index e8a2c438c7d..b33aa14ab64 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3829,7 +3829,7 @@ void cpu_physical_memory_unmap(void *buffer, hwaddr len,
 #include "memory_ldst.c.inc"
 
 int64_t address_space_cache_init(MemoryRegionCache *cache,
-                                 AddressSpace *as,
+                                 const AddressSpace *as,
                                  hwaddr addr,
                                  hwaddr len,
                                  bool is_write)
-- 
2.53.0


