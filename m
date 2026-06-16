Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B67CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 02:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZJAc-0006pZ-J3; Mon, 15 Jun 2026 22:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJAa-0006oo-R3
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:04:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJAX-00083h-M6
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:04:52 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G1xq0M2300445
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 R2wGHPAeHsBapB1nBDD8SmHsqh/WIW2RgVo66lnwkpA=; b=cfhloVCwD4TfbOId
 2TXt9B+w+Wq+rz8YorExhZaArmS/Zeoz+E6H0mI0XACrau+I+nY5s0rqB8QVC3ci
 Hyiizemd64+LIlKWh8k2KRweb6FD0okg6i2Ng9VupFVb1CnSiXs4j+inYfMrSrA8
 +xq7MsTSI8unBvAvsQmAFAm2R7uAmOfOyPOHdvTPWfrfQB89CtxJQjNKlTZy5WvX
 usHxCiiaMBE2n/MSSGKsQtNq28NwPWwYEINxmtvsp1XSzEuVTYZb4GVG+/tBAZVe
 P97gOA6uk3fi2dVYqBe1PsG+GNVN5iB9mqs4bVRKHbiI//UJu/a5Oxx5DVIMv2Ua
 joyuFw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eter245e9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:04:48 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9158f2c4b55so647319385a.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781575488; x=1782180288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2wGHPAeHsBapB1nBDD8SmHsqh/WIW2RgVo66lnwkpA=;
 b=SyTeIqywB6FltibvSOkVttc1e9ifFFIojCljpw3fb2ys0ZH1tbXKlj9QxXHjfxfo5O
 5psPErpobbEKKbzqTEtxmjPqRLxX7/Rmxt0Eb4KX0h9MWTMrJqqKHOq4Cj1FmFqqv6BK
 xNIMYAayexQUKYqr1d4LeGJBSF+SFjiqME9vqJuaDVRo/F3j9GbgEgeX4eaghvQflQOC
 JMm2zbQrzhcDNPb7BjkWp6m7sOL64XT3xlMa78EwX3pevAkaB/OmLRaP2d5r9nl3z/NP
 y/4TWGDcn4PoWz4Dy1/gCBVOFs1inZlDIm452ClUxGtgpjtrbgA8nYLCtUjFbd46wOBX
 CQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781575488; x=1782180288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R2wGHPAeHsBapB1nBDD8SmHsqh/WIW2RgVo66lnwkpA=;
 b=DMjSNRYcgMPL8Gna3qZBQz0Au98RNJY0eYIRHIz/rZtTn0AhS8s9Sn0lf/ngN64Gn2
 jgwqXxFPWVprB5dQ/58A8VyP+XPGzER3tv9QRPLVKC94SyOYiXoPUk4n2vtUxC5xbEPY
 sQa2e2uLSkkv8A83RoBEmHhqCVolvj0UNGtaMrNm4jqUiXA0TBRpZSIuCCVkylqwq0Fh
 K/iCMJThABkpa8augU/ej5YfMz81Ir80Utb1Wb9dJYXKSAZ/zit4L5YAegZ/ni7GJfj+
 IYmtKTO9cUS+mhngP07bNdejyFugOPEyaZ7t0pSCchwUTJttdafgRQobvoVPKHg4oapg
 xdSA==
X-Gm-Message-State: AOJu0Yx1RH6mA1XlFTrE7IRXnbnyNtFh2Vq9T6x5dxAA3iB8PeQFMrFc
 sAnl4e5TqOqzCsu1aq+bHzm6Rj2+nYVEy1ia7rXbup+3ru+TRC0bZOyJnM4ZCvWHZMjUo8HbDK/
 cZMwVoYG/tJSarweXKMUKvcSoulVB1KOQgRU30mz8/9e8vAW/aIBWyNBlO7Zvzp60Gw==
X-Gm-Gg: Acq92OGFa+1/QR32/tb7HtNEKJDjInnPJl8ws5bew6gyY4CPjmVNXRrWyxnWSFnXaiJ
 xNOQRmDKPGzMi1aGVHm489m+IaYb6b4n8wRM9nzB2/RiUVlyrMaZBGXngjHs2Zak/8ALKRWtF2X
 WxpQAxlwT/TvoV0yaXYYB88OnuEtIPRXQ+l9TKVnV01PTtKMCHQA27LiOKo2Kqax2PgqlykmuMh
 UflV3Eiv7zlGlSiKN1Rtiz80WO3Q8ylf9V8kjWcTmvCC5ZDUvFrIx0mCUO2hAWr/KVLzCrgKuf9
 QkXbwMc1T1hDpBHtD4GPVNUcM3vxvOucURkrSifMdJAn5Dp86CVH4sLPU/YwQPc8TAQ+XSGkuZw
 lVQfeMNyeQE7mljP+bs+rbBwAkjvL7aaholafon230rlJdjts14H1J9AWjmS5USdhqeYQN72V5e
 XAQE0=
X-Received: by 2002:a05:620a:2890:b0:915:d443:e6e1 with SMTP id
 af79cd13be357-91c2602d5fbmr346673185a.26.1781575487861; 
 Mon, 15 Jun 2026 19:04:47 -0700 (PDT)
X-Received: by 2002:a05:620a:2890:b0:915:d443:e6e1 with SMTP id
 af79cd13be357-91c2602d5fbmr346670085a.26.1781575487392; 
 Mon, 15 Jun 2026 19:04:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a96b47sm13015455e9.13.2026.06.15.19.04.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 15 Jun 2026 19:04:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 6/6] system/memory: Constify various MemoryRegionCache
 arguments
Date: Tue, 16 Jun 2026 04:03:58 +0200
Message-ID: <20260616020359.18627-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616020359.18627-1-philmd@oss.qualcomm.com>
References: <20260616020359.18627-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAxNiBTYWx0ZWRfX49QvRJZslNeA
 WDwINZHkM8A5wGZdS6YR5gVlksbQRp3uPO8CCWSn/QfJneTML/qrUAdT//5T+GQmufCcX5k0Fs9
 ZKXQ+HUjlDFuBS6aNaIrPVIoI2uxQGM=
X-Proofpoint-GUID: ca_ZVjprW7fyEJ09HjfDIBJn3Omsskvp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAxNiBTYWx0ZWRfXy/jNPP8/svSO
 2NBs4YCN4ffUHZjQNiolr+UaevhnF5/p/Qe3YxMwp8YcdEGbNBjsqBegnLVuz14+L/sOX2rYm0p
 wrs3bDjw35psiH+aRwzkyoPRj3K1RfRcw+p7K/5yP4FnQe8yoj4AQukTys/grleFICWG1OIKAlx
 yxedGnpOKsbYg0SVkvFwmDSCxzWu9bKUuSNFxlpi5GZPS4GAMubGKBP7Pxpy/5/qw6BdQPkEUgO
 RbBbidHpuuRInHeEA33G56UcYMHlnAbsNSvdYQXuXPlz4KVjishAG0sC3up4PWs9kJOwCH3nCRf
 ELCsBI/6MSASqesvyCNGWGbPrKPg62/jD5WtEkeIWyuSY0RJGVYyoSLs+zz1II+R6EBm/ROR1jV
 Xz+JEpYsASavTfpPHYV2ant2+vIszPa//CqFJl4fxBYGRUUIG9w0KKMEiY8hkiR3MFhhLP+a9Uu
 YeESYKRSkX1Qti+l4TA==
X-Authority-Analysis: v=2.4 cv=F4tnsKhN c=1 sm=1 tr=0 ts=6a30af40 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=fhQonfk0Xf6UbOH1hI0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ca_ZVjprW7fyEJ09HjfDIBJn3Omsskvp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160016
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Mark the MemoryRegionCache structure const when it is only
accessed read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/system/memory_cached.h          | 18 +++++++++---------
 include/system/memory_ldst_cached.h.inc | 15 +++++++++------
 system/physmem.c                        | 10 +++++-----
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/include/system/memory_cached.h b/include/system/memory_cached.h
index 760ecb38c19..09d46821bec 100644
--- a/include/system/memory_cached.h
+++ b/include/system/memory_cached.h
@@ -51,12 +51,12 @@ struct MemoryRegionCache {
 
 #define SUFFIX       _cached_slow
 #define ARG1         cache
-#define ARG1_DECL    MemoryRegionCache *cache
+#define ARG1_DECL    const MemoryRegionCache *cache
 #include "system/memory_ldst.h.inc"
 
 /* Inline fast path for direct RAM access.  */
 static inline
-uint8_t address_space_ldub_cached(MemoryRegionCache *cache, hwaddr addr,
+uint8_t address_space_ldub_cached(const MemoryRegionCache *cache, hwaddr addr,
                                   MemTxAttrs attrs, MemTxResult *result)
 {
     assert(addr < cache->len);
@@ -68,7 +68,7 @@ uint8_t address_space_ldub_cached(MemoryRegionCache *cache, hwaddr addr,
 }
 
 static inline
-void address_space_stb_cached(MemoryRegionCache *cache,
+void address_space_stb_cached(const MemoryRegionCache *cache,
                               hwaddr addr, uint8_t val,
                               MemTxAttrs attrs, MemTxResult *result)
 {
@@ -93,7 +93,7 @@ void address_space_stb_cached(MemoryRegionCache *cache,
 
 #define SUFFIX       _cached
 #define ARG1         cache
-#define ARG1_DECL    MemoryRegionCache *cache
+#define ARG1_DECL    const MemoryRegionCache *cache
 #include "system/memory_ldst_phys.h.inc"
 
 /**
@@ -145,7 +145,7 @@ static inline void address_space_cache_init_empty(MemoryRegionCache *cache)
  * address that was passed to @address_space_cache_init.
  * @access_len: The number of bytes that were written starting at @addr.
  */
-void address_space_cache_invalidate(MemoryRegionCache *cache,
+void address_space_cache_invalidate(const MemoryRegionCache *cache,
                                     hwaddr addr,
                                     hwaddr access_len);
 
@@ -160,9 +160,9 @@ void address_space_cache_destroy(MemoryRegionCache *cache);
  * Internal functions, part of the implementation of address_space_read_cached
  * and address_space_write_cached.
  */
-MemTxResult address_space_read_cached_slow(MemoryRegionCache *cache,
+MemTxResult address_space_read_cached_slow(const MemoryRegionCache *cache,
                                            hwaddr addr, void *buf, hwaddr len);
-MemTxResult address_space_write_cached_slow(MemoryRegionCache *cache,
+MemTxResult address_space_write_cached_slow(const MemoryRegionCache *cache,
                                             hwaddr addr, const void *buf,
                                             hwaddr len);
 
@@ -175,7 +175,7 @@ MemTxResult address_space_write_cached_slow(MemoryRegionCache *cache,
  * @len: length of the data transferred
  */
 static inline MemTxResult
-address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
+address_space_read_cached(const MemoryRegionCache *cache, hwaddr addr,
                           void *buf, hwaddr len)
 {
     assert(addr < cache->len && len <= cache->len - addr);
@@ -197,7 +197,7 @@ address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
  * @len: length of the data transferred
  */
 static inline MemTxResult
-address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
+address_space_write_cached(const MemoryRegionCache *cache, hwaddr addr,
                            const void *buf, hwaddr len)
 {
     assert(addr < cache->len && len <= cache->len - addr);
diff --git a/include/system/memory_ldst_cached.h.inc b/include/system/memory_ldst_cached.h.inc
index d7834f852c4..b4c696bff1f 100644
--- a/include/system/memory_ldst_cached.h.inc
+++ b/include/system/memory_ldst_cached.h.inc
@@ -24,7 +24,8 @@
 #define LD_P(size) \
     glue(glue(ld, size), glue(ENDIANNESS, _p))
 
-static inline uint16_t ADDRESS_SPACE_LD_CACHED(uw)(MemoryRegionCache *cache,
+static inline
+uint16_t ADDRESS_SPACE_LD_CACHED(uw)(const MemoryRegionCache *cache,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
     assert(addr < cache->len && 2 <= cache->len - addr);
@@ -36,7 +37,8 @@ static inline uint16_t ADDRESS_SPACE_LD_CACHED(uw)(MemoryRegionCache *cache,
     }
 }
 
-static inline uint32_t ADDRESS_SPACE_LD_CACHED(l)(MemoryRegionCache *cache,
+static inline
+uint32_t ADDRESS_SPACE_LD_CACHED(l)(const MemoryRegionCache *cache,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
     assert(addr < cache->len && 4 <= cache->len - addr);
@@ -48,7 +50,8 @@ static inline uint32_t ADDRESS_SPACE_LD_CACHED(l)(MemoryRegionCache *cache,
     }
 }
 
-static inline uint64_t ADDRESS_SPACE_LD_CACHED(q)(MemoryRegionCache *cache,
+static inline
+uint64_t ADDRESS_SPACE_LD_CACHED(q)(const MemoryRegionCache *cache,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
     assert(addr < cache->len && 8 <= cache->len - addr);
@@ -71,7 +74,7 @@ static inline uint64_t ADDRESS_SPACE_LD_CACHED(q)(MemoryRegionCache *cache,
 #define ST_P(size) \
     glue(glue(st, size), glue(ENDIANNESS, _p))
 
-static inline void ADDRESS_SPACE_ST_CACHED(w)(MemoryRegionCache *cache,
+static inline void ADDRESS_SPACE_ST_CACHED(w)(const MemoryRegionCache *cache,
     hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult *result)
 {
     assert(addr < cache->len && 2 <= cache->len - addr);
@@ -82,7 +85,7 @@ static inline void ADDRESS_SPACE_ST_CACHED(w)(MemoryRegionCache *cache,
     }
 }
 
-static inline void ADDRESS_SPACE_ST_CACHED(l)(MemoryRegionCache *cache,
+static inline void ADDRESS_SPACE_ST_CACHED(l)(const MemoryRegionCache *cache,
     hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
 {
     assert(addr < cache->len && 4 <= cache->len - addr);
@@ -93,7 +96,7 @@ static inline void ADDRESS_SPACE_ST_CACHED(l)(MemoryRegionCache *cache,
     }
 }
 
-static inline void ADDRESS_SPACE_ST_CACHED(q)(MemoryRegionCache *cache,
+static inline void ADDRESS_SPACE_ST_CACHED(q)(const MemoryRegionCache *cache,
     hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
 {
     assert(addr < cache->len && 8 <= cache->len - addr);
diff --git a/system/physmem.c b/system/physmem.c
index d202e540c09..d21eb6620dc 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3878,7 +3878,7 @@ int64_t address_space_cache_init(MemoryRegionCache *cache,
     return l;
 }
 
-void address_space_cache_invalidate(MemoryRegionCache *cache,
+void address_space_cache_invalidate(const MemoryRegionCache *cache,
                                     hwaddr addr,
                                     hwaddr access_len)
 {
@@ -3909,7 +3909,7 @@ void address_space_cache_destroy(MemoryRegionCache *cache)
  * address_space_cache_init.
  */
 static inline MemoryRegion *address_space_translate_cached(
-    MemoryRegionCache *cache, hwaddr addr, hwaddr *xlat,
+    const MemoryRegionCache *cache, hwaddr addr, hwaddr *xlat,
     hwaddr *plen, bool is_write, MemTxAttrs attrs)
 {
     MemoryRegionSection section;
@@ -3990,7 +3990,7 @@ static MemTxResult address_space_read_continue_cached(MemTxAttrs attrs,
  * out of line function when the target is an MMIO or IOMMU region.
  */
 MemTxResult
-address_space_read_cached_slow(MemoryRegionCache *cache, hwaddr addr,
+address_space_read_cached_slow(const MemoryRegionCache *cache, hwaddr addr,
                                    void *buf, hwaddr len)
 {
     hwaddr mr_addr, l;
@@ -4007,7 +4007,7 @@ address_space_read_cached_slow(MemoryRegionCache *cache, hwaddr addr,
  * out of line function when the target is an MMIO or IOMMU region.
  */
 MemTxResult
-address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
+address_space_write_cached_slow(const MemoryRegionCache *cache, hwaddr addr,
                                     const void *buf, hwaddr len)
 {
     hwaddr mr_addr, l;
@@ -4020,7 +4020,7 @@ address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
                                                buf, len, mr_addr, l, mr);
 }
 
-#define ARG1_DECL                MemoryRegionCache *cache
+#define ARG1_DECL                const MemoryRegionCache *cache
 #define ARG1                     cache
 #define SUFFIX                   _cached_slow
 #define TRANSLATE(...)           address_space_translate_cached(cache, __VA_ARGS__)
-- 
2.53.0


