Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22124606A31B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cq+uPelJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IDn4FL3u
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKVjF-0006Jn-NY; Sat, 24 Oct 2026 02:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKVjC-0006J3-Ra
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:59:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKVjA-0007k2-Qz
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:59:42 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O4BtfF047556
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:59:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=6ql3tJi85y24LYD6lUerNQRTKlNLRlL0XIl
 tX4M1aZw=; b=cq+uPelJ+o8Wcn/bJK3/uGXMaqT7C08pf+L+iLpoWO5f+PlqkxJ
 IV/9AmyXsZyDieZOn/DQm5XrskjUHo1LnS/0BRp+iB7Z5bfGaJjpX8dJkn89lXLO
 SbQri9wCWcEbzC3y5eF2xkwsj9mDkAxRtAXw81NF1ADGvvMecuTHmwYnBz46l7FV
 T8VuO8IVQUFz5Noxp87DxZzQ1E7scEKr+Cj0jVQs2LdXnpip2A8bjxr2gW6+zSVw
 woFdLSDqJA4XtGclr8uGzCxiOlpzj0l0onTRdEHNf01qPSWaKFBFzCvdTvlUozpy
 1j2QY3hNVgpEJywWH+/tdIQ9oWZsVjT7a8w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgnehg9a5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:59:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f13c143c8so289804085a.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 23:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792825177; x=1793429977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6ql3tJi85y24LYD6lUerNQRTKlNLRlL0XIltX4M1aZw=;
 b=IDn4FL3uvffr19IWblSyO8AyPPlczGDW1ihX5ME8AcrA5X2PiUJ3mqmZ3AmJlOrZ9G
 qsCQOgSazWRqpYwkRKuXto3+wA7VjqSsWtORPYTjmbcsmyAIfWlmkLuxygAM1RpzdSqF
 ScnJ+0A2sIAimfNLTy5gJIby/S/pBJtQV0Xu9XmP10eZG7yOYqJBrDz78+GCOdboUfeX
 4W9mn9L+xGagH0/HC6sbrzgCxvZd5seulItIfHO7aOh1p7lBZA7dVwchLx155qYFLGOt
 oLQhqzn/KHoPRj3hzO0OK4jA+kRlYNA5vrZ95aHBV2dyx3ekQbiL650gzm375sbuoKB+
 2/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825177; x=1793429977;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6ql3tJi85y24LYD6lUerNQRTKlNLRlL0XIltX4M1aZw=;
 b=G/QU1DOH4oyqBlqxZYtWBeDO9aXFlenASgYTxGMGo3efNgtuVGWAVvvq+NR6nvcGPD
 PTBbR7hLRVtP7T66Ucxx6VNac/EKNYT+4QRHMne2/pzH+lemY8u0b98Ixqgn0m03n7OX
 9PE0c127eKR7Eu1x3OEy7T5kCNwRiJWbqfc3xMwNL1NKx5HINXHrKRJWv7N8Z0cPp3bL
 9BNaF72wTaHodGXvAYXnBlVYaGJ2qONwslpsy/t5IhKxu6M5tDN9mtiCorrfX4ZmtA8k
 mMfkBkm6Ugj/LX8d+jvxvlNWx8rOAWm2XEkaOCCuzCCf2sUjGwxsclWz/9SO8D+wo/C5
 +taw==
X-Gm-Message-State: AFq9FYLr4GHcxDdu5kmXWEyLVXgRDwgN8jq8ajd1qq2Z+rscl1ZRGWGN
 Fc0L9HuV0bjguiztEHYOIuLEPLR1XmrzCY6FZBnvlyAXR+jmLhBy9ryhArftSyEPkeoENeSEWUa
 JHIGQ+jC+WhdD29XPFL7jHAlgpfMQcySpmk9l17oM+aIa9n46CapX9A/wEdmz097XoQ==
X-Gm-Gg: AYBFou1T3QHdSRCpCY7c/y74lyl0ZI+ODC3SEUr5bF+aceOvSd9BP52u+cjO5InjL8j
 aMSD9da0wx8OjgYxyRgYLvR2dTnFkLIJFzpE8ZaWJNoEIKO+CzCMCOvbSGzMR41V8AYLRoS52ZD
 Umri94Fl9ZP9xpJGYKALZVvxtY96umsgX2aIPWBfJO8q2wF3kX4sV9g4pS7UasNhV3CXKwe9RjM
 prmGi8JaXoIklf/H+0S3M8uTasGEi5/BY+RJGKRa6BZ0qNSp9w+l/2eacRd0efD3bnxVuDNUqGv
 gBiirGpwHggwEtshtugKV7ECr59QOcYNvhvJq7+eYSB3dCwYMo+pNrHZ4U+BdP850faot+Z/AY0
 BlDPiC6xZlVPLEFK7dAK+3TkwgSCKUiMDxC21Bw==
X-Received: by 2002:a05:620a:4408:b0:93f:1936:b206 with SMTP id
 af79cd13be357-940ef9d4881mr159171985a.83.1792825176838; 
 Fri, 23 Oct 2026 23:59:36 -0700 (PDT)
X-Received: by 2002:a05:620a:4408:b0:93f:1936:b206 with SMTP id
 af79cd13be357-940ef9d4881mr159170085a.83.1792825176392; 
 Fri, 23 Oct 2026 23:59:36 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([152.234.125.162])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-940f0a9720csm112753785a.42.2026.10.23.23.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 23:59:34 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fangyu Yu <fangyu.yu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] target/riscv/csr.c: allow regular mstatus MPV/GVA writes again
Date: Sat, 24 Oct 2026 03:59:30 -0300
Message-ID: <20261024065930.26750-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAyNyBTYWx0ZWRfX0mdZc+YfpjzD
 N/ucAqkDvKpo6jUrxeDJUfFw1JP32BWrvdFyq73Ze3cZ6uUta8s+axPouVeN7ChufyhyFbh1zWY
 kyeOupei8eNc5tvUehKKKhB1hwYSYzM=
X-Proofpoint-ORIG-GUID: H13Sskbpqw0h0DdRWtRM0iMXo8NQTBgN
X-Authority-Analysis: v=2.4 cv=d5tgWhjE c=1 sm=1 tr=0 ts=6adc5759 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=AgQEunjic7gIBKSbIeB6Ag==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8 a=2-HHZJNMt9pQZSuXdbMA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAyNyBTYWx0ZWRfX7oXgNBlZXcB9
 smn3EjHIcN4wQxM6ACyZA1cQqDV1joQn/8RIZj8o5yKC5XdlMtu9SQr1n1QJumhq0rnVOuhznSE
 tbDtHvkM+ZA+PcehHltg/Z3Ck9hzFPpRPKI+hTapeNzOPxwWx/F0+g45rToHfhxxaf+CTXPf1Ud
 4sBEnprJXptMP/J9eaUrEFGd+rHN7sqTsxc5S8UTDDcYqOx+F+hvOLmL78+MOyuuoWkWg2tBjA5
 xQrqhR2xLp/8S/W1w6QtQjKroCcsGrEpGQwHwHxgJlL9YPCP1j+RFoHKTSQzUevCle39hmbuzKA
 /o/QZubAlvRwvZt0/2vOdUkMoaGA/Bh+5jOn0gmr9MQGwKt7ypUM2rpsrhd8LEunz6u/sCJxblZ
 sROrtghjClcYW4Xvk9NNFbXJbPcnJkhu08S7Q22p8hRika/q8AnvNHE9IZV/0jKj0/03mU+IwNe
 c9RpYef/+z3nrFupRXg==
X-Proofpoint-GUID: H13Sskbpqw0h0DdRWtRM0iMXo8NQTBgN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240027
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In commit 18645f195789 we removed the capability of MPV/GVA writes by
software, claiming that the ISA says that these bits are changed by the
implementation (i.e. hardware).

This fact alone can't be interpret as "so software can't change them".
The ISA never mentions that, and we shouldn't just assume read/write
accesses based on whether hardware updates it or not.  M-mode software
can do whatever they want, unless clearly stated in the ISA, and that
includes mstatus MPV and GVA updates.

And in fact existing software is writing to these bits, as reported by
Fangyu in [1], and that change ended up causing real problems in the
end.

Revert "target/riscv/csr.c: do not allow mstatus MPV/GVA writes".

This reverts commit 18645f19578955ec5ff2c40cd2c8753d6bc460c2.

[1] https://lore.kernel.org/qemu-devel/20261022120111.24298-1-fangyu.yu@linux.alibaba.com/

Reported-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/csr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 13675b4a84..af444e3e6f 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -2108,6 +2108,9 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
     }
 
     if (xl != MXL_RV32 || env->debugger) {
+        if (riscv_has_ext(env, RVH)) {
+            mask |= MSTATUS_MPV | MSTATUS_GVA;
+        }
         if ((val & MSTATUS64_SXL) != 0) {
             mask |= MSTATUS64_SXL;
             val = riscv_write_uxl(env, val, MSTATUS64_SXL);
@@ -2150,7 +2153,7 @@ static RISCVException write_mstatush(CPURISCVState *env, int csrno,
                                      target_ulong val, uintptr_t ra)
 {
     uint64_t valh = (uint64_t)val << 32;
-    uint64_t mask = 0;
+    uint64_t mask = riscv_has_ext(env, RVH) ? MSTATUS_MPV | MSTATUS_GVA : 0;
 
     if (riscv_cpu_cfg(env)->ext_smdbltrp) {
         mask |= MSTATUS_MDT;
-- 
2.43.0


