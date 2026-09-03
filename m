Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF534C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24uU-0005N6-4x; Thu, 03 Sep 2026 06:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24uS-0005Ec-Ed
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:43:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24uQ-0006vt-ML
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:43:08 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHJDJ055336
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:43:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kO7CM3FFkhGWOoPl2r+T8Du9X4KEmq/gC7/+tfEWtuA=; b=H/2gtcdtVonr/FBM
 eycBex6oaqDri7m7rLs5+AZQqlXfK0XloGScTX6KF7RW6RNPxecWwmyZr9a24CGr
 k0bZbItiN4mkhyKSZLZ+Dvg84Kr5mUpB5Un+x8I2XyZsJH0pWiIftkbYnM4UHqUs
 GGMZH7XGqBJenA4acLruxm6SnCpvpC8AIqUkcyPIkKJo0aYuUCf2tWpxe++7fZPS
 wlcBLOWDT6i90lVMK0ZSOy6ktrL3qnx2pJF49Fglm2JHu5fsWbxgyMNm0Qm/DMVq
 a4x1TuEf7lzmvXkMsQu+mySWLRo/XR4WhzsPRVImyYnQsc6vz10LHlfG63N1eYoI
 Ezah2g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdvgv1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:43:05 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so409555185a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432185; x=1789036985; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kO7CM3FFkhGWOoPl2r+T8Du9X4KEmq/gC7/+tfEWtuA=;
 b=KDNIAvO9EdMNdzEeBFvae+gmU6TXNcFeyH5NUyKTyIzn97pEGyyzhIRdrPN/exkfWl
 PQ0KQ7IFzfuNVytm5WtqxJsMewtVyoOXcSQ0WnheOzTijqSyvlc0ZHmN/chEExfGexaD
 Zi3RgXWpcHT3NTU1X3DLLjLu9+Ze9T3BIP6XatOt5F/A6i1ODC4PYodI9cAySsj8ose2
 IrrAVcn79cWE0UPIRAtdaeiB/9IMdXU7rm5x30KxyNg4VG4kScy11ukRUx+3BbJCavJu
 SGSUrIrnNhAQZpcyGqd/EAgBrGZ7SJRIs6N3Ei0q9OXX6YWsc1HoLyjIAyUVv62Afa9P
 kclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432185; x=1789036985;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kO7CM3FFkhGWOoPl2r+T8Du9X4KEmq/gC7/+tfEWtuA=;
 b=APJKvcLpQrtmugqFPqCtMMqsIGBMTyUNVVgEpIPw9dN6GgX2LMc1Tgf2qHoJ7NGnuo
 zl51upCWbTLryBy1P1pNg039vYl48jBsKa8Td9k0T3vf638oZebSj/YKNwvUPVDL7DL1
 CiZrrymmL3X+9M/Fuci8NVRM7QzdhHNRKelg/REg5mmWVAgQLfqGMYIjEQ4GoASIbIYf
 j928FknqcNsBsL105Dk2gnpwvcYV/ByDa2z1FHsi2n0QbglwL44qFhM30ZceiVSdIlx5
 ittE6CoX24iXRQrSPcCLGWGP6tPC3Ob+Q1O5h7b5kQOZRSgwWja2yVkPYVZcNX467NQN
 dfBw==
X-Gm-Message-State: AFuF++nT+DmWy3Q5SyOxI+uWA4rDZBonW0xfeRDi5lBNvf9XKT2k63Qi
 GbsgV9XGGWfv0xTDPTR4DLkSJXFFtVKAZbrs7qj1nBiQiZ1gQzycNBPGLggMv2rWWbiG//TsU4i
 0dPyCDXUKt+yZJQgBWetA2zapP5yOsAx7RKo0h3ZXnksqpViqp/WhhtbilSP94CgyUA==
X-Gm-Gg: AYBFou2rCxiRpxKuDPKbu1/ygQHa5t1x7/hBadHrFTWlthKkGx8d7VKQ/KK8CHRpQfV
 6lfQY45O0rMZD8Qaaxq1FOxpSLXOg2jaewkzyujcsyNER0rwySFbnRaWE6OWyeb/RSOVZnJOdo6
 GShi0n4reNWknvFxwdBcK6UzqJyp2S0XHAv2wPZncVR3T6bnpgiK9lnpjtL7obeVD7jgm6mb+g1
 4IyKo6+UYKy6wGnsOECwSIiBqF4Nh4YXYC+zbJUOr/wjkxicDysm3f8fQHjA4iDdOsVorNRE93W
 xLHY0T6V0urjspQqSr/I8EhqtFE7+kh91owV6sw6otewpRHn0TEtsY218EUlGg+g1QSexw56VNv
 s7WQJ75e2F2tL3sJXBKusxEnNczGs5i4+v0wCKB1z
X-Received: by 2002:a05:620a:8084:b0:939:191c:cac7 with SMTP id
 af79cd13be357-93972cbb0c3mr303118985a.13.1788432184968; 
 Thu, 03 Sep 2026 03:43:04 -0700 (PDT)
X-Received: by 2002:a05:620a:8084:b0:939:191c:cac7 with SMTP id
 af79cd13be357-93972cbb0c3mr303114285a.13.1788432184399; 
 Thu, 03 Sep 2026 03:43:04 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e80745sm13043953f8f.15.2026.09.03.03.43.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:43:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/51] target/loongarch: Constify LoongArchTLB
Date: Thu,  3 Sep 2026 12:39:12 +0200
Message-ID: <20260903103936.62355-29-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a994f39 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=a6ClGZL5xczCKn2Z3mQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 1msfcXQaMQB9K_XNeT-ULSDkc8ru9MAD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfXyhLaMjJkTSKh
 +gQ1KFqpAUddziTO8LM1ohqzbVtsdVAAxb6FDEO80ssItjwvfPOU0Q6caMaHIHTxTtVwhJhRi1i
 ri4GdpcsTxanu80Z28ORW8b0LrZAiILsMDjBg0xJs+bd45bM+m/l6bkG90DNSJqaxIlhG/OXcQZ
 vfDtEsPZkk6jPNT3F+ykFUgRh950Hr5GK4jLJdjUJzR/Y8tEuUU5e57Y/I2z7enMuqryt0uY2Au
 KaQ55hHhQaM9ikUeh5NhkEBgRNEgWnmaqBC8mD29CcgIGg5xbQAaRUCkjkHS5YAs1QlPjUVY+Ha
 RS8J+h3SF0G7qDJ/Kq0HH0B4/tTZfBw4JoEHyiuVyVZy1KPjBQgWtZO/OjXvGoS49oPDi3BSMQa
 c2XZv3fLOdgXkoauSnRBkrvcocezNciz3IzpoHDcl2rraMGPk6YCqS8UtaUfmF6b+tse3jpIt60
 pMcQq1SgjdBOk7JlNLQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX/8MuOBo+oyeZ
 GH2Myub8AsFN+c8kJKHHeXuj5rcHoqWVAgoQK9rjjLnRoo20HqrLeZPYroG8ax8GRRjpjHR8+RR
 h3YfKqKucP4uMCWqaGTP2mLLaYbzfW4=
X-Proofpoint-ORIG-GUID: 1msfcXQaMQB9K_XNeT-ULSDkc8ru9MAD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
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

The pointed LoongArchTLB is only read, not modified: mark it const.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-Id: <20260901095229.72018-11-philmd@oss.qualcomm.com>
---
 target/loongarch/tcg/tlb_helper.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index a4b90beca65..40cc0764248 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -238,11 +238,11 @@ static uint32_t get_random_tlb(uint32_t low, uint32_t high)
  * field in tlb entry contains bit[47:13], so need adjust.
  * virt_vpn = vaddr[47:13]
  */
-static LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
-                                             vaddr vaddr, int csr_asid,
-                                             tlb_match func)
+static const LoongArchTLB *
+loongarch_tlb_search_cb(CPULoongArchState *env, vaddr vaddr,
+                        int csr_asid, tlb_match func)
 {
-    LoongArchTLB *tlb;
+    const LoongArchTLB *tlb;
     uint16_t tlb_asid, stlb_idx;
     uint8_t tlb_e, tlb_ps, stlb_ps;
     bool tlb_g;
@@ -296,7 +296,7 @@ static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
 {
     int csr_asid;
     tlb_match func;
-    LoongArchTLB *tlb;
+    const LoongArchTLB *tlb;
     CPUSysState *sys = env_sys(env);
 
     func = tlb_match_any;
@@ -594,7 +594,7 @@ void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
                              target_ulong addr)
 {
     int asid = info & 0x3ff;
-    LoongArchTLB *tlb;
+    const LoongArchTLB *tlb;
     tlb_match func;
 
     func = tlb_match_asid;
@@ -608,7 +608,7 @@ void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
                                   target_ulong info, target_ulong addr)
 {
     int asid = info & 0x3ff;
-    LoongArchTLB *tlb;
+    const LoongArchTLB *tlb;
     tlb_match func;
 
     func = tlb_match_any;
@@ -842,7 +842,7 @@ static TLBRet loongarch_map_tlb_entry(CPULoongArchState *env,
                                       MMUAccessType access_type, int index,
                                       int mmu_idx)
 {
-    LoongArchTLB *tlb = &env->tlb[index];
+    const LoongArchTLB *tlb = &env->tlb[index];
     uint8_t tlb_ps, n;
 
     tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
-- 
2.53.0


