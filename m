Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42C4C624CF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1LBj-0000fC-0H; Tue, 01 Sep 2026 05:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LBe-0000ZG-4P
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:53:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LBc-0007cN-HJ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:53:49 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681792e4705426
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 09:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wc0yFFveao/k/OMW8MeygH5JlbqUOVDVNRms4LgrmoE=; b=J/Ejx8PBip6d3uVC
 bAl/e3gbr6I3UIHQefUlGm2LCvPuyBfK+N2hQ201nBCwZvPnzViZa49qRnWXJOu3
 xh21bzKc7crPbFOwKpq6PQFpQhA5smD6Fh9ZJa5kFOFKz1tDX2KwJ/Oc+TLt3Ruc
 mYWdOtdIn/AZGrKSa0/djEJUJw/KgVFShg66Y41bOz9B5OWIfnTYIFTBWtHhsJaX
 P5mN3HGRin2/GQ9YMCCrxJQ1WYaCSkX8i/qbQ/Soit4Y17d2k7ma9ZpAjI3GRuHI
 Ix/s/1wnh4S0r8d1/1sFPoLWZf1o7ON4Ldqwuo7CJRIHS/l9QhngUZAGWCS8sH2w
 UI/KOQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdrcsh67m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:53:46 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92ef13b61bcso938575585a.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 02:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788256426; x=1788861226; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wc0yFFveao/k/OMW8MeygH5JlbqUOVDVNRms4LgrmoE=;
 b=ABZQLKVBaIPYnj4yIxk2tLRZKw6ebZixXhfYeWfxXkbDhlJHQgsdl5maYzZnFGmExB
 vtqDsa2cd23B5BJa+LJ6qiJpZjeH6+WztkVfIymCpNrYghT/qwujIhQkysH0y6P0vScX
 U0ph75lqCOGMsk8awEkLs0WmcJSbE67Vd0nVVn31lcp3WsghDjOVHaqq3yvL5XlTVP5X
 /V9EwxTJNBbgPGo+BiOyw0+KvCsCuUs+3KqRQQWEd6E7IDOWt1oLUQVjWhbwlNU6LbFR
 xhhbKNfbWILCgKXIYjjYDxl2q3AFAdSZEF46T8aykV+KjX1DCi4kx3Ygt1EtC0jQCKLD
 khYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788256426; x=1788861226;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wc0yFFveao/k/OMW8MeygH5JlbqUOVDVNRms4LgrmoE=;
 b=Mv6f4E1CeBxNujYAvv3ZovTw4OqCOBRMzUvT6FtGEO7Z4T63YmV/h+VCKBB9Po35c5
 lVD4XzFSR7m0UFfcWIw0c9DYeYY9nTYW295fNjQADiiAXOakckICZEyFw1Z6ozH71ToK
 mgfz42lGUJxBvbAFTKSv1TWDfZp1nU6uuJ2VG6DvEaVc+6CS0HBE9wnXm9nqlhzBwCgw
 JMA9oDLJAO3lP402/Lc11f9vXIwUhbxorUVPunghqZvoKRpSTzTIDoLzn7Cin6ek6beT
 8omB6533f52EL9nlNeRq34BZTYWWi45pZ35j2BuTGVmu7LYqjxbrWCHXWGvXeC88bZfL
 HFYQ==
X-Gm-Message-State: AFuF++lYy+ChrZBrFzFwlGAI9kDaKCMRl9FvIoPT2YHuOnRMwGSaKi+0
 HEqO5KXAFQeERdngSeNh10xSgx8cffRQFVV6dcQ2aFLwE4AFcNwBgH89sIbcNpG6hiQGdgnLJxP
 6K7uA7vxeHsZQY+JDAww+sJnCwT8hwPX9SNnEiYl6lH5YiXPAov1oj5jg8o7mx2QmAA==
X-Gm-Gg: AR+sD12AEGUrIqjcNl/NxmRSjuYEWEUXSj5WKm/RBgrUmmDY53lsiTE+B0rsufZvfRZ
 4HFihnF2m/kOULqeOs1NSqRhXuWa1aLEZ5we1Wf6JV+YPTNs5tVr6g+smR/a6+1gNjIq+ZLhmt7
 kstLg8QSWy5A6VYVpKC5wyitxriOqUqEHZg9Kh42d5t4Qe+P/MUibfhFysGAdoCRDkWcRiwaL4g
 CKWCDlvMGC5TtYFTOi+kx02//KCAaNAfhvrK7t4yfnYM6Cl+u36VJWsAFGoa968ydyTi7ihbyss
 hnQliHllXs6FtplPJAI9Zd8SJ79uOY6VARDsz0vm4bydTipY5np0y1VUnRhz5AgRozBxqZI9QO5
 /JFJ3DjjdzXbu/l8Kj8+f6fkZCY9Z5nyIiQJQ3Z5I
X-Received: by 2002:a05:620a:c53:b0:939:47f3:c0ea with SMTP id
 af79cd13be357-93947f3c157mr943128885a.34.1788256425780; 
 Tue, 01 Sep 2026 02:53:45 -0700 (PDT)
X-Received: by 2002:a05:620a:c53:b0:939:47f3:c0ea with SMTP id
 af79cd13be357-93947f3c157mr943126385a.34.1788256425298; 
 Tue, 01 Sep 2026 02:53:45 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce1e3a9sm55439215e9.15.2026.09.01.02.53.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Sep 2026 02:53:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Song Gao <17746591750@163.com>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v5 10/21] target/loongarch: Constify LoongArchTLB
Date: Tue,  1 Sep 2026 11:52:16 +0200
Message-ID: <20260901095229.72018-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901095229.72018-1-philmd@oss.qualcomm.com>
References: <20260901095229.72018-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfX4HD9IzCWu+tO
 er2xPzuOGL9B87NGkPTTNHplQx8+xUuaR19SckQwJqvES4v5ZoWvfxgFi38XpwhdKv58/H3UW2n
 DoLI3919CMarc2hBcwA87KveHmmSJlU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfX4vZ5WuPKYkr+
 tdhU9vUQ6o7mA04/6r/7Zi8UtRSQWTlCRRRKfMIw4Nv+hSKIb7dxArbistRTH2eXFZqGTmSb50T
 S4/oCzFYEpPQHD4F1sTtBCGFgaYo64Puz6SUBwtB5oBf2n6yRKhadQ8VTQcdlkkUQDR9aKmW0/a
 xWJSgw5D99bNcyTCoTqlnfA0gnFcWVQFQUV4YrwLxQou3G9IVRbmJTGOG4DOJ1KlpfKmOy3P4Cd
 utwCFaN2vnmcznl+1QsUJtfvFu/Km+Kr5ilm2N6sl6H6xydSIVLqmGwI9mZYtxHBsZ2b0SCuUVn
 LMdgiDVW3tabhMJeUKogMpuY2BvSzg+eUwiLN2NxlthySQ4X/RsvjmWOBIonCUq8SllA+FWrzj/
 8UQJ8oh2slR5bmYwoBiphb3G1Xa7P4+MXq0sQS5r6oGJXWu1r7uviduvndpjCy2R0cgces9k9Eh
 UtipisqYXDbinT869UQ==
X-Proofpoint-GUID: QEGZJHMFFvw94p-cFpk5vl57DjVz-E1Y
X-Proofpoint-ORIG-GUID: QEGZJHMFFvw94p-cFpk5vl57DjVz-E1Y
X-Authority-Analysis: v=2.4 cv=QsNuG1yd c=1 sm=1 tr=0 ts=6a96a0aa cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=ttdALjtd2qF5AbuOeikA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010087
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


