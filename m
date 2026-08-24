Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C33C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyX4H-00056p-9d; Mon, 24 Aug 2026 11:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4F-00055r-9t
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4C-0001jW-3G
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:35 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OFmuqo3329504
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qQgXh0AjQZO
 C2+5toV72FGuXY8Sp2e1KTPKXdcHqZWE=; b=F4MYeTnnOGIz5Sc8uQj8dLleTjL
 AHjyVtkDPoHg9BXFjkKj3A72PL1JTVnxPwtmOXVLpwQEQtB87NDDl21Oy/difhbF
 1tA5GrC+1KfS1qSdX0FTmoEc7orFHZMpi7Wy5BB+FwahP7bNCpIvfFFg6GLp/3e2
 Ca5ciO1+/AGVzwYkpDyW+6R5ZSYfed2gVPNFX5YfW56OknHKf+xSoa2SDo0hEoVy
 NPmOg/TXdohBuu7JtpeModYnLMCtE+314o3bEMg/822jg4p5V+VEzpcmqGEHgg3x
 i+TFh1wHNu4gsKQ9aBLvvGwSUmc4ok0/GPG6N09f6Eeml24bqEEBkLa0Dsw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8j7r1xxw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:30 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-395543dc382so4390816a91.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787587109; x=1788191909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qQgXh0AjQZOC2+5toV72FGuXY8Sp2e1KTPKXdcHqZWE=;
 b=LWwIRFM1BxxrodrEZLWtStHL4dDTGocWIDlKKnSlYJ0io0KOqJ6My58OO7WhorS7Ed
 YDSUNvQlWQWoupRMAxIxJAe3ArMRuhpu0Rv5xJsSKbvUWASD4yh0e1q/wX9v3pJrydnS
 L0irD/tXkNCfJ4IQZC0Dj6rp+M4Zs44Eax4zVaSxMwOmDhCqI729zR71eUQZWA6ivacV
 2CqhGFIHlSay7csTEVu6ybgtXiQCwmxtRmUwv+zVDC7/VURi2kDgOK+duDKSAEgdZQkd
 dV1o8DJOqiHnO/jwwXaxEJ7x2dpxn/prkKARpeKjg6spdn+CUJHdYY2HlKtpMFwPiUxi
 whLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787587109; x=1788191909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qQgXh0AjQZOC2+5toV72FGuXY8Sp2e1KTPKXdcHqZWE=;
 b=bBKjf/aOHM3o08DOqCQzBs1YBtB42OX6lyho5/cYzHXxCiO1Ww0WcyZ3C5i4DHjW9x
 g5Zq4K9+FzwKQ/HDglPGbFSrhB9knjdHY/W4C/8GLSVqX5s9AS2l79XCctemdgdBc8Ip
 wuLYtqILbgVgMHkiM0iW2KmhyeePifgBP0f1c52nVAZi8nBwhy0HHFUqlSoxE/P+PNN7
 xHIpX3cG+JKb1TovqnC8b/RzpJodxDR9fWYs9s4A8tkir2we0jX7LhKRQmDT11RDJGA+
 ZkFxouPYFbg6qVj9J+iKOlEZkoe+LwfMDrqGPvdaTjadFzWFaLwqumJMC3719ILyE3Ew
 PCqQ==
X-Gm-Message-State: AFuF++ketGSMNiax96dYXqbLGNey2hD0pn+Kz7ARMthYoi+2gYdKIWaq
 scDtAtZz1vm0t1NRGLAQW2mP/CIBcvFtfXwqhNiqckOtAjJO1wgWqelH1nlgPZCS059eGp1U2iY
 RGipP8NcCd1riD5LksX6a+CeE2JuaxYU+HMhknFAOSA0cIPsTuNLbiwHNRYyxf0KqIGxG
X-Gm-Gg: AR+sD100CBj/jNvWfZUZWWh1w5D2NDhRwufhqFDEroHJI1TTKR3hZ4jv+fJ5zqONUST
 HMh3GsOyEqbnHXcYUjHNocgIglhvQcqL7UbMMPwKsUNrwQ9svRA2l37sHq9oS+lWNV+wBEtBwP6
 mw9hcOxkaZvZcOtuk7/qUB8PnHlfCmwjwfEDv7jxjRTR0flFGt+XbvQPjLFiy4cBVXOHMZjxaHJ
 KYG/qxCrEgMMRzs4rBcP6DFSGn49/ApDrBfukVxe+TmYNOadp3OdDDjBkI6n6kQfyaAyw61uoK8
 0/+16LQFASb9g3/sbLj4+WzWEYIrQvXlNn6pm1zc9qVpz39He5URnpNSZoiZ4TzDEhWv7PONX5s
 ES+3kgxF5OFr1uRGVlTHrGSny4YiTn0Hr/CiBV0rRVlONt62voUy775rkOzhluoY=
X-Received: by 2002:a17:90b:53d0:b0:38e:bbf1:de3f with SMTP id
 98e67ed59e1d1-395c359a74bmr49036823a91.12.1787587109522; 
 Mon, 24 Aug 2026 08:58:29 -0700 (PDT)
X-Received: by 2002:a17:90b:53d0:b0:38e:bbf1:de3f with SMTP id
 98e67ed59e1d1-395c359a74bmr49036737a91.12.1787587109082; 
 Mon, 24 Aug 2026 08:58:29 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14186183c0esm41152935c88.12.2026.08.24.08.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:58:28 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, anjo@rev.ng, brian.cain@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH v4 02/14] target/hexagon: fix store-conditional on big-endian
 hosts
Date: Mon, 24 Aug 2026 08:58:11 -0700
Message-Id: <4fc8afeddfd0dabc6c50688b24901ebab1867b12.1787586642.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfX0GjK5ULb+8th
 bpJM1I+n0pX1QrdElXHy1fv0EkYKkHz9OvgtA3Wn7sK84KpEwWfilLkmydQoFBuuN9UjuyhO8+3
 M9PppIf1qR2otXFSms/ElUH1vLEPqOxkhjQRBHpKtpNxCyvhytJAxuGwtHq4mMR3ibmPlp4CIpE
 oMoNwG+Y+v5t9PxaifbmDkMvvoMXFTqzTqvSWtVje1MliV6CYzxOP2edWvKHMdg8x14WiTL+vh5
 WzcArlJrXpx4b4RaLECMAwUDFLY+daZD4PqsuquLLygZDs7CuMCkiH0+SmKpB48106OTmWvlYYH
 aClaPfnpFo7QtWHJ60IuknhKMFB3ccZRqqWZPzbCPA2Jvl1xin7a/2wxX8VkjLG+qMCsrbp6p+p
 LjuKwB6gfrxJgM5WJ27O3OESqgzbs25qnTcTMWzMP/xBjicdUwtdZ6xRGJ6P3pSYkRl1Zb618ML
 gDmKn/nxi3p5iO1Gkow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfXxogvkkXiTnAc
 L2j01tF+teke/V9TkGMC1DrMiZeBibqgQsKOyn/ru7aqV0REAYV0PL2IxijY/Xbp+slh94UdBK8
 aPccxvOT0D5uMKHDeaCc3qVtVBPYlIA=
X-Proofpoint-GUID: HyoUYe_eriqVkujDZ0cYHUmC2ALLPFrA
X-Authority-Analysis: v=2.4 cv=IL8yzAvG c=1 sm=1 tr=0 ts=6a8c6a26 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=leud2LzcgvzU7ZSISvAA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: HyoUYe_eriqVkujDZ0cYHUmC2ALLPFrA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240134
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

gen_load_locked4u() and gen_load_locked8u() read guest memory with an
explicit MO_LE, but gen_store_conditional4() and
gen_store_conditional8() are missing that, so we wrongly access guest
memory in host byte order.

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/genptr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index 2a98b13b71..9330732c99 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -576,7 +576,7 @@ static inline void gen_store_conditional4(DisasContext *ctx,
     zero = tcg_constant_tl(0);
     tmp = tcg_temp_new();
     tcg_gen_atomic_cmpxchg_tl(tmp, hex_llsc_addr, hex_llsc_val, src,
-                              ctx->mem_idx, MO_32 | MO_ALIGN);
+                              ctx->mem_idx, MO_LE | MO_32 | MO_ALIGN);
     tcg_gen_movcond_tl(TCG_COND_EQ, pred, tmp, hex_llsc_val,
                        one, zero);
     tcg_gen_br(done);
@@ -601,7 +601,7 @@ static inline void gen_store_conditional8(DisasContext *ctx,
     zero = tcg_constant_i64(0);
     tmp = tcg_temp_new_i64();
     tcg_gen_atomic_cmpxchg_i64(tmp, hex_llsc_addr, hex_llsc_val_i64, src,
-                               ctx->mem_idx, MO_64 | MO_ALIGN);
+                               ctx->mem_idx, MO_LE | MO_64 | MO_ALIGN);
     tcg_gen_movcond_i64(TCG_COND_EQ, tmp, tmp, hex_llsc_val_i64,
                         one, zero);
     tcg_gen_extrl_i64_i32(pred, tmp);
-- 
2.37.2


