Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019CA606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ohwnHC1f;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RiSS2iSG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaoB-0004NB-RD; Wed, 21 Oct 2026 14:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJao4-0004LD-Hp
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:12:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJao1-000824-NR
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:12:56 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpXZb454741
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MZksaQUhXTz8dgWapwPFSun/vAOowcNQIYeUAsmgEDk=; b=ohwnHC1f6PBd4hd5
 mnh2bKoFeJNIe1GnoG8kZjC78Zlqlg7NB/OD/3+wIL1cQNYLBkUjYXvnBnS+tDD+
 a+9NtzGn7Lt058V7BtYCvh1+yBK3hyplvpN0ihlYlqDDs2o2FoL5xtK9tzhmhjBM
 I8GNwE9wIjmAKjOvjJBZZ1rrwVAqA3IMIIX8gfbygFxPFudp97q6YPVorVM6XGQS
 JEXVKko3h6fsfgt8OagtK76C31rwl3igBkPCivOShQknBLcu/HxvePZs/PYRUurv
 TjSDWrVfvNLyTi6WVhElgktOByv9s4SP1ZpqE0H/PnmYMY9wu4meu6v0Phhp7fSb
 /YIlZg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex589c1m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:12:52 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3a4a0017549so2696138a91.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792606372; x=1793211172; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MZksaQUhXTz8dgWapwPFSun/vAOowcNQIYeUAsmgEDk=;
 b=RiSS2iSG+v6fAQvtfuyFVeE0GAyo/NgSRCm/KpNWj79Z6jzGdKJY8gsgPVsA1KjYjm
 Y6Le2uK7yHBc+DQP29/rHxTs008G+ldslEvS8R5zmEClDDBT189HouajgZ+A6N6LEElu
 8OVjLTqMFb/MScQg1aSJ99jB0vgV3trVsGs52CMUiLE+MnFnKPk+QTmLrNzbX4I0rwdY
 JIujXvUQFvoLLZB3IkzB/3V/Ft1SWh6utAXnjgwH2q1amSx+Q5P+qUTo5E5Mj+MOWG+6
 zNcxRzEPiY+/WVvMN26Psu3t4OIhsZBRFTm0z7sZsHhMEN1gml9WlPs3xhPqap1XgeLp
 y5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606372; x=1793211172;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MZksaQUhXTz8dgWapwPFSun/vAOowcNQIYeUAsmgEDk=;
 b=JgtrJCi86m385xYPzTvzhE2g10V2dd1tMNBQpDDq8QNoNiyfrFvqGkyehjOBzwkA4O
 LViaWEt27r4Djwa0bTxKbYodPQFMMOapbWle8BkOtFIO4GdgKYpQS1IaB/QsNsbUUDHi
 pvhBhKvRZEqsf4Q5LkBF1Ehyrk+oGZUMg84snvbV42DPkmsrkTeK0kn74DjMuHDaiD4a
 RvEI2dSw/hSARL3H2qX7xk4LkedQaOrDkf7fTL3rjTm3XGzjLyfH1pDbDQMH+0gcfaQ+
 K2SyLZ6Iwn+dITu5Fq/vkYI7Kgwf2ErD6F15aFiGWSDbLHdlqmYdpmzUFDVx9cYaftrP
 VZWA==
X-Gm-Message-State: AFq9FYLOhRS3K9trBlLOuzZr9PCg+MlH8j61Daex8jv+4WnMRzzc4t3A
 i9xafL+UoPUCDRqm5QgD0izHW+g0/IefZoPdpI+7fZNB39cM92S6UjI99Glg2wc2mS65zFdn5T2
 IK53hCGGcAGe4ioS7d664RggnaaHu61fBhIx1Jqtl/eskaPD/OQZUQ5i8YOuYQPnBrA==
X-Gm-Gg: AYBFou1VRe9FIM0Q/1yEXSHSl9nnhh8V/ysmXNhyaq8q9d6h5FSE2oq7VNTrAX9YW2V
 Zuy4pY4lCLrS6LbRByXAgLEgMl3YcgqWzq3oE/gvvBqBFYWg6phjl120+axkqNW5xY1ENqZD5ue
 7JB6bxXNeHeqaY5S9qj1wfgdyzDsbA116IODKHVVDThnmw8NpUd/48fKx4nBjwcR1EbMff2/+Wj
 QOgA4IhEXvQhvVSPnGEKYChJu8kDgdaf+QNyt4MKf23ypSX4RnR9Reb2hSo/+RwBuPa1S8eVk2o
 6kc6BHXhIJgZoQU9RCpNEgaRrA+gK2be5Sf5khNbo/usmkXJH9Iav56h7MBGCNcyFg6qhDtMYY5
 jHrzZbepGzIsdMBG8dRiK9ChNn5UjYynVGS1qV7rKElBxw1y9x5xI/Y1TNEWVEv0=
X-Received: by 2002:a17:90b:5645:b0:3ac:b7b9:6471 with SMTP id
 98e67ed59e1d1-3ad8707b58bmr2150658a91.65.1792606371696; 
 Wed, 21 Oct 2026 11:12:51 -0700 (PDT)
X-Received: by 2002:a17:90b:5645:b0:3ac:b7b9:6471 with SMTP id
 98e67ed59e1d1-3ad8707b58bmr2150643a91.65.1792606371223; 
 Wed, 21 Oct 2026 11:12:51 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48ed74bsm499152a91.3.2026.10.21.11.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:12:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 03/21] include/qemu/typedefs: add ArchDumpInfo
Date: Wed, 21 Oct 2026 11:12:26 -0700
Message-ID: <20261021181244.867840-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX3jT8JOWFD/S6
 vn1i0atOqp5+A3xXbPtmHSiJ6VCSvrlhZGhk7YTc+rqcySr741A4uGcWCDbvxX7bloN5v5ol9Us
 5VPR45BSI8yoUd/WxSsjlkQBO2MOsB0=
X-Proofpoint-GUID: L_jp57cW1HvC4zcxdKaRF23zBs6zKFAT
X-Proofpoint-ORIG-GUID: L_jp57cW1HvC4zcxdKaRF23zBs6zKFAT
X-Authority-Analysis: v=2.4 cv=Ku7YSmWN c=1 sm=1 tr=0 ts=6ad900a4 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=WAb2S511oTjnKBTKeboA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX6hDv5+P4kCNt
 tC6chGJxxTBnbyrpYDl4J0fzou6isoBHFqGJIFVqCBjHNn6SgUjCy9HOh5qmv1t/WfVy7SWuHXw
 3LkdX/4/gc+BKKkAbiIW2KA5v5WFFyU9/r9M2rlpy9LlR9+h28ddVKu9+3LBFZueFIhoNT5dP1Y
 wltkkw3FJIQskQCtnlMfyVMmKwZLKueY/1VTQkpVjK8q98MBRsQXqVdZc59XylLBYrQ2b9A/438
 nEOMjJwngDtOrLXOPZq+EsWywwDGKEnCueiIicEEF1W41RwAo9D6T7gkNMpQjIj22P8gGtlNNrI
 AmEosyDjtb7l582cp28tTz3OUfYbzkBfDA+rGAhwpoQCVLHJ3JdoLpKG1xt63ZMj8rK22CozYXa
 oTZq9ByvwjX2tZMvk+DdqZfN20+af3mgOJgBbra2rzN5N07UoybAGnRj+nG+PUgrOqdubY/6yUr
 p5W8b4Cxa0u3rGodCHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210072
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This allows to use a forward declaration instead of including
system/dump-arch.h.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/typedefs.h    | 1 +
 include/system/dump-arch.h | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 2344c92182e..8fa7f752dac 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -28,6 +28,7 @@ typedef struct AddressSpace AddressSpace;
 typedef struct AioContext AioContext;
 typedef struct Aml Aml;
 typedef struct ArchCPU ArchCPU;
+typedef struct ArchDumpInfo ArchDumpInfo;
 typedef struct BdrvDirtyBitmap BdrvDirtyBitmap;
 typedef struct BdrvDirtyBitmapIter BdrvDirtyBitmapIter;
 typedef struct BlockBackend BlockBackend;
diff --git a/include/system/dump-arch.h b/include/system/dump-arch.h
index 743916e46ca..7165a5bbd03 100644
--- a/include/system/dump-arch.h
+++ b/include/system/dump-arch.h
@@ -14,7 +14,7 @@
 #ifndef DUMP_ARCH_H
 #define DUMP_ARCH_H
 
-typedef struct ArchDumpInfo {
+struct ArchDumpInfo {
     int d_machine;           /* Architecture */
     int d_endian;            /* ELFDATA2LSB or ELFDATA2MSB */
     int d_class;             /* ELFCLASS32 or ELFCLASS64 */
@@ -25,7 +25,7 @@ typedef struct ArchDumpInfo {
     uint64_t (*arch_sections_write_hdr_fn)(DumpState *s, uint8_t *buff);
     int (*arch_sections_write_fn)(DumpState *s, uint8_t *buff);
     void (*arch_cleanup_fn)(DumpState *s);
-} ArchDumpInfo;
+};
 
 struct GuestPhysBlockList; /* memory_mapping.h */
 int cpu_get_dump_info(ArchDumpInfo *info,
-- 
2.47.3


