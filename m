Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613A2CCF2C3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 20:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHoYa-0006tg-UD; Fri, 16 Oct 2026 16:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHoYZ-0006tV-RK
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 16:29:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHoYU-0000fB-5g
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 16:29:35 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GJeXDw2873531
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 20:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9izqE6kEaA7hn+Nt4tKOujUP8HMmHavAa6g0LWBtP4g=; b=dZJUeBOTeNiYY39B
 +PHZ12dK1rD1gqAG5U42O1kdUniS8PYtZkCRvCJwrVnvpv4hbBN3BxlnIbD5l544
 qeimowVRH2UNEF2RdAQD1uDVeQlWDXKhkClj0qeskpvFP//mh2mysZ5pqDZNsViZ
 4KqSwR+a/ZTFF/vPi8zus8n/NAoA3lPPqRND5MwDfM6o7r3dJ11328a8n5E+1tsr
 9F/etAidLGXJnLlJ58VCe3/ji4erPTDjDhNvT1RjRDbfXMB26HOKtPOYDF32cbmc
 gqr61Kpp8aqOBC3eidnc2KYv4Nf202gth9YcRG2gz3EmBAlbUex0LuAjq/2TiMjQ
 W4CtmA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbhumt7wf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 20:29:19 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso372052eec.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 13:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792182559; x=1792787359; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9izqE6kEaA7hn+Nt4tKOujUP8HMmHavAa6g0LWBtP4g=;
 b=GHS7azQc/stQ5+Npiju4VwzLpU4ACdw9R3164DL0XpYVObaztt476VgUlw40xxoX7T
 3dI2jYXCbUc9szhtTpUWEQE3zl8bGliR82wRn3qUeWe7BVIEX5KpBvXmbDIRDFCR1iiC
 vgZqBtoq9vpd+RLECV4gVdw0vT83Op+fQvSAhrcm0R33sdohOXm0Vn1dCZkLX0G45iNf
 RFCfFN237hdwNM2XPasLXbSuuUDTXbIOMHLA09r2V9ZQGbJRjNd/8daDa2F7UYCS6+qo
 ktJmtiQL7mjzO3DSjQZ2V1Fp6ftgf526EZztDbLIGp4q0tbbjUtnNR7jemqRKzHkYHSL
 bq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792182559; x=1792787359;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9izqE6kEaA7hn+Nt4tKOujUP8HMmHavAa6g0LWBtP4g=;
 b=sGWqIGjG78KQh8K0VtHxaeFAF5kFeZFK1kU5ohQwlU+NaU0b18yTk4Noyg1jj3fNdJ
 ziv+H7amp6hcqVm52JPj3alczjOAnLKPoppQdpREN3ElATgQBgnCCNuHNoiBsYKw9iBu
 JtZp1n1VUaHNEfXi28/WABy7ZVsq9a3pbvOV7vbj63BZ7AG2p0Q+Sn6FVv4HcnXHHPW5
 hmU6I1SBsiyvYkxGB3V2ZGS6z3WQQYx0TSXnHCm9xdgxrQQZrRjgS7ilLtUd1Z/RsuGg
 408B8lcRY3zbNfM+lAxI0DSVi7OeJwUJgKAtmaCmpL+WUrRTj57eLZCyEotzAI7n7yVN
 iSEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1EXbgoQbaf2uHUxWme+Wrek6gx6nfYTERgWakDP33x7/xlg6PjKAlB/bDFpG2q+7mBHBgP8N6njou@nongnu.org
X-Gm-Message-State: AFq9FYLZ0I9hgjWE8Fd+kzw3yJCKFfk53bPkUZRjibRYZPRSlr14rE5C
 cWTQbvTNVAqCb7g8Fuj2grdOOvAk9rkTGVxjff62497+rL+mH2IfxreZARcuQHZtJB4p2Es155O
 vr5LpOqL4wpELcnJjakSvkflpP0OxEk/L/6rO/QYRGnvzBRS0aDvYtpl+zA==
X-Gm-Gg: AYBFou1eU7WsBB1kAYmVMnqqidc7+c/ajr80pNbQjMy2dbydLaBlhVCfnUb9y2oy4nF
 SJw8IgghA8+zIFME85YF1kUmT9wVBy2G36Q+P60m/So3Ve3U6Lkydrfb6GQiiF7qg1YvZB08LhJ
 7LYPfez9H7gN89UoZtLWMX2ec+Z6dGU98KsnQLqhQwyPMy6cSYnSe6D/aOc4qyATcudBTgWcOxR
 6Pu7au1L2YD4/rhbruc5SdidNLBjokKrWz7NOU9B/iBeVABhn0yswS/YJnoKcogzTbU5YlZlETw
 05x4fv/X4HNxI879Lhbu/MCjAWnTHnG7BeI9qw1Sf02ClQbFONSu0RMaQuXQ2tRtK6DKalsI+xw
 PfY6KDRojNmJhSxK0ybm/imnfGjlivtS2Zsgqup2N6JRvg05At8bQuIbWBup0BHInzkf+Pg==
X-Received: by 2002:a05:7301:53c6:b0:358:45f5:daf with SMTP id
 5a478bee46e88-361a1e4db23mr956328eec.29.1792182558786; 
 Fri, 16 Oct 2026 13:29:18 -0700 (PDT)
X-Received: by 2002:a05:7301:53c6:b0:358:45f5:daf with SMTP id
 5a478bee46e88-361a1e4db23mr956292eec.29.1792182558075; 
 Fri, 16 Oct 2026 13:29:18 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360826875b3sm9225943eec.21.2026.10.16.13.29.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 13:29:17 -0700 (PDT)
Message-ID: <950ab15c-e61d-4fb6-80de-d46cfe9f693c@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 13:29:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon: fix the allocframe framekey
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
References: <20261016170848.4024042-1-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261016170848.4024042-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA4MSBTYWx0ZWRfX3qp1h7eVBgJQ
 ZTxJa+OZgoZ5UoJwf2YrBIOOh9zjKdafxNccKkTJ2R64ui6cK+jEmc065rMZj/d3blgOU2DJi2F
 Cgmq/WbiMcJnGOmDbbPf3EN9celNPnE=
X-Authority-Analysis: v=2.4 cv=H+BOUOYi c=1 sm=1 tr=0 ts=6ad2891f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=l-pAoWCK6HthENGasyEA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: oah2ejvxXumjP5bhoMsUEfdcCAj5bkHs
X-Proofpoint-ORIG-GUID: oah2ejvxXumjP5bhoMsUEfdcCAj5bkHs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA4MSBTYWx0ZWRfX7Qf1is76y3b2
 cyZKU6+/r+r61vM0bYFVgfj2LcGDKWLsHvUEU7Nvr3HGvg9KDSDDL5KmeCQHaV83ta30nK7lKN/
 NOfMkyTWLEp+3SvF+Grbl9D8QeSs00J1WERrNsXvxvrrReX79WgtssKy/Sa71+LmJStZsBlOElJ
 OFgJi+j1NBueZeBw8vyxj37M2JtEr+786w44IiEl/dLFWx8KRxgcQ6I1tb66m+3Ac9pZ7pcKMhX
 h3pmML9oxVEgd9KRuDHP0I2LyBJDuYyMPK0d2ng1cdM2ATpN+wnVGhLSv1pD0u8YdKGfxkCuoRr
 Dn1pqZXKvGmiii+uuP+Riva6zMTD/5NPZT/wSmuo9yalfSjOJKLAb7ia7Rjb34EUM9FDNpZF/tC
 EjkjrpiBPQU58r8+fu4ULA8oCVgN9bMXz+iTrC0bCVWbjIfrcdbK9f2Rpyo6M4fbYCaq9Xskynm
 ZGvzaYTFvOwf7IdhTLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160081
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
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

On 10/16/2026 10:08 AM, Brian Cain wrote:
> The frame that allocframe pushes is {LR, FP}, and what is scrambled is
> the LR word: FRAMEKEY is XOR'd into the upper 32 bits.  The generated
> code for fFRAME_SCRAMBLE built the key from FRAMEKEY in both halves of
> a 64-bit value, so it scrambled FP as well.  deallocframe and
> dealloc_return only undo the upper word, so a FP restored from a frame
> pushed with a non-zero FRAMEKEY was corrupt.
> 
> Uncovered by testing some boot images using QuRT.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/idef-parser/parser-helpers.c |  2 +-
>  tests/tcg/hexagon/framekey.c                | 67 +++++++++++++++++++++
>  tests/tcg/hexagon/meson.build               |  1 +
>  3 files changed, 69 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tcg/hexagon/framekey.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

