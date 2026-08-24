Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4AEC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wySgF-0001So-Fl; Mon, 24 Aug 2026 07:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySgE-0001SX-Ce
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:17:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySgC-000597-Pz
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:17:30 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O99DRQ2355869
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9962qy98qgv78VEwglyReKkX4KojPn8juYKMeNcCxIc=; b=loDqfDzF+qT5np6B
 uv7hRPJK525AtRMk1wD9I19ut8kklyB2D5g6a1mc5daVf0xmSkUgejOtjwQXIT33
 LBVuZTeDnojRjOEUkUVTqoQtn7A6+fvJiAkOrVMfTSLF4mPc5pJCGAEuLwML2XcZ
 pDvdNBmGSsC0QpuR5IwikSKIBzeYKAEzhwDuzCFSDjiUs2oOTyKnYMQiEQVDTW85
 jVkwFdwGNf1jF9oK0NLd74hz2cRz3tAdSQd1CDvQjmEtPZPAAB9ZFDNe0mg3iCJ6
 Lr3t+HhioSE84li4DpQWP9zI/Lg/AdHw07syuQEbrST/jqNU8McnDS3Lh+sFAjrL
 ToMagQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8gqn96e2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:17:27 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52d33c89a29so44994831cf.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 04:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787570247; x=1788175047; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9962qy98qgv78VEwglyReKkX4KojPn8juYKMeNcCxIc=;
 b=awLzf/Orz44M+8FYlVTcin5LjmtxHUNJ3wLRkc9IQLmdO630fj0Es85pMoI8rOWdQX
 413RAM6VK2tSeo0bKOIc9yMYOnCWZ40kZNMZZBG4uOsTvFm0E5FtOUPQX0yjPXfqLuj0
 NkL+pYk2G3GuZLilJZKB+Rvt7uqFoG+j+S44PS6jtZVO0lBHwidgqvo1lO5C7wiouFL1
 aqglgiIOKPxaWLedWN/kszv///C6T5kniVszONZx1RU0Ss+zixj0qmmQzNEVPL61DRR3
 r8EHNUjzRJMoauNcGPrlos2RWjL5iUfTXuMwm8XrHYjJQ96Fml+uuzQwTj1Tv2QLolVK
 DsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570247; x=1788175047;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9962qy98qgv78VEwglyReKkX4KojPn8juYKMeNcCxIc=;
 b=OTofq7SMp0gBXWsaVIXjnx59GTDitf+tMsDWw6ikfkzo7zM2FcBkrx3I1onwJsm0Rs
 YSXqrbeeD6M0VEhZRsxxBvn6x5812aFp435K3KNG2BmUrr76lIeqi8HdTDTerWhV2WiI
 Hq9i+Zp4OjAfScHwjSHIiHH6XTeYyG78IcIXGVyqhQHYosAFfgOetWsnwxcVVFXH7CvH
 MCRrCe6cZQwB4MzYcdx3WY6FOUmq6jUG7auTRePr/eV2RXvpEyhHwM15H8vtVQbQcK97
 Q4PmD8VdNdGZZ9TQWhNVVix4+0ZFMT3WPQnwuaFTtsBieU1MYvaGcWgKj7l1kt6mHSpN
 6e3g==
X-Gm-Message-State: AFuF++moTrkLNthJGWCJTa8bAkG9uEbW6tSO63nK7X4G3xRX4NTnBpnt
 EfUi5SqiWhwRFMKhDnId2SmoNZcYrvHHZVimqOwzYC7pcU/5bXi3bmrqsH8NIVFUPuWAoT+CsoK
 hE7A2j5GipKyEozVp8+A0tIqZ0BZcgk7KcqspFkrAEjJyP8c9NmbnIDPzA/qJ8SlIpw==
X-Gm-Gg: AR+sD13KDzI5FZpPJf4+6YF7G4ey0+TJOOQJ9jMBrEf35bN/r2y02p3odR8FUZnXYDb
 4eARondPsxGo7ggMAEIh6UxYn5CBrepymo4V2D/ftUiap3BfEZvgr9SnzIC3GPj3ppJEtPgyKIm
 ZVcDj81UShsCOEBSYRH12bKkptqvmz1AK5fHh3GOfgvJzDkyJQmYD4E60NmajQ4ZYoPHQv4a0Uu
 PTMGPaCv7KeQehBzSaJk5i46r0C/18pMpruI/PKaUlAvYg5r2OUBrt1sanpT/Dvg685U4WYHJNp
 +XwcT8ahydfBrdiNmlzKw7nR2nOPadicPmpNEefPerZXlqwVQoICFxss5vyTPyzi8dYk8v0I9aU
 xljd+h6sekGlHNbZ+o7vIwGa5fppkyM5TlL8Z43tTUM3ns3pFwQ==
X-Received: by 2002:a05:622a:4d8d:b0:527:7813:a439 with SMTP id
 d75a77b69052e-52df5a09808mr283859951cf.27.1787570247091; 
 Mon, 24 Aug 2026 04:17:27 -0700 (PDT)
X-Received: by 2002:a05:622a:4d8d:b0:527:7813:a439 with SMTP id
 d75a77b69052e-52df5a09808mr283859341cf.27.1787570246700; 
 Mon, 24 Aug 2026 04:17:26 -0700 (PDT)
Received: from localhost.localdomain (44.170.88.92.rev.sfr.net. [92.88.170.44])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f9cbcsm1353929266b.29.2026.08.24.04.17.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Aug 2026 04:17:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 01/20] target/i386: Remove const qualifier in ptw_setl*()
Date: Mon, 24 Aug 2026 13:16:50 +0200
Message-ID: <20260824111711.26297-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824111711.26297-1-philmd@oss.qualcomm.com>
References: <20260824111711.26297-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfX10OJwpzmqUOK
 6AK7mQIEpvMn0NZkRJ8ONbBM3MhIvXNnwIr67Lok2Lk3UIzALtAVbHFLTwdy5WdHPRfU0O+kinK
 Nl+oL49XB9pcBxKkcvsn5AjHh3EOlbA=
X-Proofpoint-GUID: J3ppgpKnx0N7siuf9aG3RMRcBatF8d6l
X-Authority-Analysis: v=2.4 cv=fqXsol4f c=1 sm=1 tr=0 ts=6a8c2847 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=s1NLoHz9uzatdv2VNqxUSg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=6zyGMrF3NIoAil_mprYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfX3/Krgfvqqx2P
 kJk5HRUaeijiWCLD9ShgEHhE62cZZi/aHgPnzLPRdTTnzsFWiuwxawCkeOU/Ok6tCLNg+p7Drjg
 Gp+iXH4uDSQfoOxYhl2gXUjaW4Hmpj45H5Ju5cX580wOGHTaRcr036yvyjRpHBfwJuVZ+gFkUoH
 D8s5/Jw3+602JS7mEaWu63gYmbu9sMI8mxvMevQ4a+/x0hPlgGaOWwqshnJLLbcN9oJn38Ub3ZA
 g6PRteV8qSLyBk9xJf0HJZIsXURF/18+4lo6Z0nMknbjBJdnk58RSjsDMOWPiw50+YMOHAfiF5r
 JJITaXXQEh6m4QdzUVsE9F7fm3STU1WvrM3ldM2CFbkdws+bhRMy5LBNQk1oj0RglLh0FFvQi6/
 ZQWX7oetfqsTE4SK/QW5ajKEw8wwVc82LR59/1Kq83DsH2HxaSIiyC4CKnTBRZ61iO97Z13xuhx
 0nRx27/tQSbRB3+jZvg==
X-Proofpoint-ORIG-GUID: J3ppgpKnx0N7siuf9aG3RMRcBatF8d6l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240094
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Both cpu_exec_start() and cpu_exec_end() take a non-const CPUState
argument, however here we get that argument via PTETranslate::env
so @in->env can not be const. Remove the const qualifier.

Fixes: 4a1e9d4d11c ("target/i386: Use atomic ops for pte updates")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/i386/tcg/system/excp_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
index d7ea77c8558..44be98a3c92 100644
--- a/target/i386/tcg/system/excp_helper.c
+++ b/target/i386/tcg/system/excp_helper.c
@@ -106,7 +106,7 @@ static inline uint64_t ptw_ldq(const PTETranslate *in, uint64_t ra)
  * even 64-bit ones, because PG_PRESENT_MASK, PG_ACCESSED_MASK and
  * PG_DIRTY_MASK are all in the low 32 bits.
  */
-static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
+static bool ptw_setl_slow(PTETranslate *in, uint32_t old, uint32_t new)
 {
     uint32_t cmp;
 
@@ -125,7 +125,7 @@ static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
     return cmp == old;
 }
 
-static inline bool ptw_setl(const PTETranslate *in, uint32_t old, uint32_t set)
+static inline bool ptw_setl(PTETranslate *in, uint32_t old, uint32_t set)
 {
     if (set & ~old) {
         uint32_t new = old | set;
-- 
2.53.0


