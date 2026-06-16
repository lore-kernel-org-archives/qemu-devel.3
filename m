Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FEFCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 02:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZJAL-0006jz-R4; Mon, 15 Jun 2026 22:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJAK-0006jb-A3
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:04:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJAI-0007zq-OX
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:04:36 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G1xgTL1766990
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VX7NLQYLerFMFCVchnq1CkD+pT2w/NHCxn4QKAYqUcU=; b=i1AIzcB62UiruuRV
 NnBdN0lDwR6KVtLtW9dAn8oKzl88gkVqAHVbsMcmOT+HlBqCIiIwGkRJzO1jx939
 RMnUZ1wreSXNHFpUD+iYWzeYZzPa01U/S6p1G7LgtgC840EdNs7ApW8xQNCfeOf3
 AIQZwOGy8caV4UhtUirSNUliOTQp4pCocvvmFb5ScdRpyfS/ictmw7qR7QB4iURT
 zNd48KejqrhAT1t2gzRiLNXfKAsZp/Brx4R51OuAOR2jLLDFM7C45FFeprHxYRKV
 +HZkKYTPTbzrmjFGJgSac8SvXMQ1UxTU8JpN7Z1Cksy6AtpeTtvmeXE0yRPx4reW
 VUAnRg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eteydc234-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:04:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-915c8347cd5so819712285a.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781575472; x=1782180272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VX7NLQYLerFMFCVchnq1CkD+pT2w/NHCxn4QKAYqUcU=;
 b=PxMO1q9p2QykIJ8uzgusDmOsIBjNHizGTX2ERCMhGY+T/XnCCu5h0WmYeMXBmUb/n1
 Qe/U9M/vb2j5PHCfbNZhEKfIflFzbVWZAkrP+l5WRJB1o5pzfNBONBrSj5mtzz6Khjuh
 zuqbhIZf1UaBbPHpcsCA1i0w58tsjcZFzNApKIVY6IRZt3Dznt9IKRmXK/59pL+Y61Iw
 WWNxg0Bxgjc05Vj/aZ5DntDZGRIqZDqq5JpGV6o6HpDKqVEbS3Hdnozq1PCertHPxWCi
 jA3BEOwL/ZDTsLEzVaezgXuKcy/8XehjXb6ZONP/dVETuXd78tQUFo+RlmCJ3bxPvBqd
 nKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781575472; x=1782180272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VX7NLQYLerFMFCVchnq1CkD+pT2w/NHCxn4QKAYqUcU=;
 b=NZUyBgrp/B2i3hstaaq7URBAreICMPpx7SzFkO7pyvZe9QIq2ec1KEMTVPljMQlhOe
 fZ0LGoKYMm7EFiNJgRpGSJOYkOAIVZdq7z7GCok7fdXjj97d8F5MEZmFaVHY6qKQpIBy
 kGC4JmZcPRoIRHNslTyofENhq0yBgy1CosPvdjRPTliRcjmxYE1TS7+D1DYPenGp8u9i
 2VgcZj/iLDBzCktZlhI6gfgP4B+p6dyUUlaYA/DoBcD3JoL7XDTQuOx5oD2NzHu0Hz5Q
 GdaSWiYs1xImX4EQIE/SfYhIbA6Lj0l8pc4PFlWkfC6hZewJ0hgRvIfHECgQBWzWlJmr
 +wtw==
X-Gm-Message-State: AOJu0YziXR3HfYOVUWQ/avRUMRlEwlFd9YtuYws9lzW6JP5J370e1h+J
 6uhXCGUqKdP9HcgTeLNJYoOpHsvbAlW5yna/+vr1mbeFPw+Gm2K8ph1Mw5LIxZmFOgW3ahAI7v2
 IoGSrksiQLDA6qhDqhEX48epd0+5wPR0re2g1m3XjbbtYLPvTqm2fSDA4seb847fjOg==
X-Gm-Gg: Acq92OF+FvNyQRbNlYNmrHeY4rku9tzuXUGJGi6m/KTiV/jdbG/f5HMAzQzH5R6OA5Y
 tyGorZVq50hDLQbpWNOFNGPf7/nMugYoQOMtovyTpUY8inq8GEjoHH2+4yBdFtj6Sdm7UohJQ1q
 eGuxJS8CdTwsN80IAkRiEZfHg59hx9n8hCNpZfhdSQoUUL+/WbQHDmeP6xorVZCH4XmA1fYfRHY
 C33rGaEChzEviNu5XXFKpfUuS4gRcuyLO2AxH/jjQCV5sTPa6M6mXglLCHEttVFN6A1rI1Md9nD
 J4uJBc5YEDgXyZvan/EgPsY2jYmY7BawPgDuRvcutTVIf7vuQerQUrGlFRwvG+zEUYQ6sTLXPzs
 Q//F6aptSaYGfPCgrXkGffIF+/XQZ5qc+ehWnOtuhzORURFAIJnS94+5CW3uCOZHrdcUXuaIsbK
 lqnEA=
X-Received: by 2002:a05:620a:25d4:b0:915:ba3c:8c2b with SMTP id
 af79cd13be357-917efcb331amr2159742485a.19.1781575472431; 
 Mon, 15 Jun 2026 19:04:32 -0700 (PDT)
X-Received: by 2002:a05:620a:25d4:b0:915:ba3c:8c2b with SMTP id
 af79cd13be357-917efcb331amr2159740985a.19.1781575472079; 
 Mon, 15 Jun 2026 19:04:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a4601esm17317795e9.1.2026.06.15.19.04.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 15 Jun 2026 19:04:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 4/6] system/memory: Constify various AddressSpace arguments
 (cache)
Date: Tue, 16 Jun 2026 04:03:56 +0200
Message-ID: <20260616020359.18627-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616020359.18627-1-philmd@oss.qualcomm.com>
References: <20260616020359.18627-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IBCyjySzyRVkSrJ-zD0UQTIsf7E3esD5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAxNiBTYWx0ZWRfXwuLS9+NYGAZB
 94HjKw3lMx8sGzh6796RSGAfl7EyIe/aDDgOBgXz0LAcascdqleauw2H3HiN8JZsge667C0xDwm
 3sOEIIMKy05+Lcjc3BEzpWVm62nA3bY=
X-Authority-Analysis: v=2.4 cv=QrJuG1yd c=1 sm=1 tr=0 ts=6a30af31 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=e-NtlPoBfifz4Kb8xpcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: IBCyjySzyRVkSrJ-zD0UQTIsf7E3esD5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAxNiBTYWx0ZWRfX5oDHOG5qvGkb
 CCQH4ZQdQ3hgJdwVOn+L2iW8gNVa4h2wOn49G+JBMb3Euao05LgSsZdxk+JZUNWyG8XyNbuwmQ3
 UVorRPodT2Dz6HXsXgDBPBTNAwaSMa+6anKM64bmcdcmwXXloich3St3LtzV0Ux0G3iHFKALkmb
 98/jBybFuiygKMUwGK7W19pd0EeCwmrjcMW93QFhUXdcBHwy6bgyYjpQl5fc8G0noo7ZoIkJqXR
 63fFaXsvtiGq889LRo1j3UoSB1JNmYfF8qGrannKb+380MIsQA3K0qLuY1m1Ei9JMal1NDNoo1O
 8Q2UJwmp1suaaGH+vc4mkx6SpDN89HqTvkvAYdvuK8gnRreXzfOzNUtASkF7ru9eP6kPRxxM5j4
 DiD87atm/tkOGxIJwoSs3+Yyl5/IBHspXnuAeXz9z6D71pbzzms8rfQ4yZNlrnxAd7FLwjMdBTW
 mFS6znmEsZNUMJJPgnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160016
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


