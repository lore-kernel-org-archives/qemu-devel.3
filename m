Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725F2CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBsK-0008QB-Jr; Thu, 18 Jun 2026 08:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBs3-0008E3-7s
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:29:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBs0-0007o2-Oc
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:29:22 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAslVU1372886
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oRSjp3ZRqQSrTHA7g1YMH70JMo2IgJ6pfVIky0+Gus4=; b=dbCrP5ULb7zmfxHs
 ZGA/2jcWzz3jzDPHvgElUBEriSEqWOetxaUflmv4lQx58I4ccmWQyWkv0k2qxr3d
 1DBIBFN3jkDLV+Lo/4Ut7BPbR6ObPdKLX55NeKJv1uFIr7NxsPP1IJgm8oe6A3w2
 8wg0djmP9av6lf7vyE3q2wrcYNKH2kVQp3KV0wPusVe+YrgSUOUIMRnZTnDZLlDP
 StgG3kuLH5Ve+69ONgD6LnLjffh5F41IswHN7Zf9EgSNlge6snsUW7GsVM39+GEY
 BkCW+kk2t9B51WqL6ez0f19rV7bVPmcGYFNRjq6uqcnzU+/faordS03OfhHYZ9JN
 C0q4Pg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev1rtu6nu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:29:19 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-59eb8eafe1cso1174384e0c.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785759; x=1782390559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oRSjp3ZRqQSrTHA7g1YMH70JMo2IgJ6pfVIky0+Gus4=;
 b=Hf2bEEqxK78EYWwh4lIacYrxBiZpaJh/gQDz180FowFtQ5gx/1uKRe3dP/fSxwM32G
 Kwo6NY55ZewxLyQbHLx6FbVUTOm4sDlKl1jmZ85+hxJ4ZM/eoigKSOxBydvov6Orf5dE
 sJrHbWNw7GaHahW+VbpU4o0HhZfZBV8iNHdmn3e8dh8p1OAipkFsCOd8rfDz3cpHOc7E
 q9sqN3gOXjke9VPiJiCej7rDVeZFYC7DB2JMMDGSiHHhQAA191WF1F7Gm5X//ScsHQpa
 KVmVAwgszFb0Dgl+pAfI7/zcl0MVXNRYP2vfNMDuhEyES1Qlea21xwlXMdzA9zlW7coB
 AvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785759; x=1782390559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oRSjp3ZRqQSrTHA7g1YMH70JMo2IgJ6pfVIky0+Gus4=;
 b=Xkd53nkJTJYZW/hxCUowBpxd3x+TXshLVoLUU3yMwKrWBCl51dUwDwoGPbZYEeAfiT
 eyzcRh8AwFUgHsDWZl3xPgY8Qembfc6eyZRs+phzuAThfP9N/guZJ5twnE7/RiHxh0V9
 B+eZHanUUJSL8eVVc57+A25UyeAEPZ1y4PLx1/SkM1czhk9mJpLJxY1rU4UNB/DLshX+
 W9ipe1EEI7OoHZbxOeSBB4Y5tQt3IbjAG/Ui+xZWeqjXRhkluxpZYpJ/njQnCCX8uaLC
 JbabtU8fuMP5tAS+9one47F84tjCmG9Szy6/utXLsDITCfO/3OLlyZXANhIOz2eld2M3
 J1mg==
X-Gm-Message-State: AOJu0YzSzCp8tl/ZmJ5EftBsjXOzQzC20rqAhuLmGL7Ut9Lb60lxeSC0
 /q3ysBZtagLV3HybNBx9lGHTFOCG4sItgR/B4ntDCECbrFmPRW/FLTLLr1NzQnLqqnIMk4E919l
 R4b3dP8Xk/dzhcaoiHMd2dXpZZkXmMzEYTXj/7dPRNcZPjNtrRLGprL0iB4ItaKWn4A==
X-Gm-Gg: AfdE7ckug7p45gVmcDTss7MTM7nwYU27nVvepGXUW2sj1mO3DqzTS3sd4SXWoKdHgn1
 t31W8uW+Upmqs5Zm2PMg1BUz/2JFzjhqeHzgnAtZW3PH7+DB5mXmlinvXlI5JPj0XvKB5Hn2Yce
 7FCc2PXe2tLsmHJn8p3ih+RnNQASRPku9lMJ+H7QdopzzLe5hiU5fFYGrQ9xPMASOCDVcBwXhYD
 naDgnw3FKvA15vVqzYKb8/ay/Y2ibBtR4fulQoovIQQHMIHSeaawK+0PbVFyMYeXf4DSl2v+dGe
 xP6o7WrAilDugbqanEqJBzmu4vzDoARFHxxqa4EcLiMCE3WJ95c4pAJ5IqRGu4pPqOXPH4S9PuC
 d7XHKW3eNEPTvnMk8YoDWVU0BZMzC2kDVr8g2BU/azq1hdWReWBW2sb3XX+ovmu/TuA1u
X-Received: by 2002:a05:6102:3a0e:b0:631:7781:fe91 with SMTP id
 ada2fe7eead31-7245da8121amr5120818137.9.1781785758931; 
 Thu, 18 Jun 2026 05:29:18 -0700 (PDT)
X-Received: by 2002:a05:6102:3a0e:b0:631:7781:fe91 with SMTP id
 ada2fe7eead31-7245da8121amr5120788137.9.1781785758399; 
 Thu, 18 Jun 2026 05:29:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c3782sm57312638f8f.25.2026.06.18.05.29.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:29:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/48] system/memory: Constify various MemoryRegionCache
 arguments
Date: Thu, 18 Jun 2026 14:27:44 +0200
Message-ID: <20260618122825.90331-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=MNpQXsZl c=1 sm=1 tr=0 ts=6a33e49f cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=fhQonfk0Xf6UbOH1hI0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXx4TMLgw8PnEu
 VgHWEMEasbjeOWtJTqC1dXevwEF50yUBDuyqqi9mvL+5aT0V091IMUdW1SxIrImOwD+OZFDr9+x
 yOwSsoX/kdx9Vckb4nJq/+hlkLA8EHGBRWhH39/SxvjHOfdrRdcimxnRKGthN+JsjTIAyOjBwE0
 SW3ML1G9OJ/g/hgsegqbNvdXoPoMzNTA7/4KtTWTUTm2VbQYNhZRoZXn4tEcyajcc5pCrjfbdM6
 aaV1ru+FBfV3Zf3BkguK+DQSsD3uevrenUXe4HlHjJLlFzKlFWehBU25pSB7+vW7dK5izQrzzHH
 iJCUkSSuRTFj0EpC1vBvcFNDKh2CuYeDs2Py83u9ZrIlCyRE0S18gkUcD83Cv8iT+KF2t0oYi4n
 GUYPVbCzbRTGT+4pdFbtm2EfbojgwuF3lzpNxEuw+WIX8tgBcoGzCqnFpUwYhGPr0yaRQpl2+6L
 73OEGBWDv+RZzDGSOVw==
X-Proofpoint-ORIG-GUID: HQqUilNZuSINjR5i84Q_NNsWm4QFPXoW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX8EwLACtVnpdf
 KqqPnkES11cDPqo4G92MiwNjDlMQKvk2b2MiXKBCZERDxaSIhEWYBRPMsyd5ghpGHpkQAMhM82R
 9EOFBqwvU1b+5r8Sav5c6Jz7IhFJNiw=
X-Proofpoint-GUID: HQqUilNZuSINjR5i84Q_NNsWm4QFPXoW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180116
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260616020359.18627-7-philmd@oss.qualcomm.com>
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
index 7ea65395863..9b3f461b123 100644
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


