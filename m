Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9EB606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=plSw4hox;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FE7COw/A
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFKN-0007aQ-Ij; Tue, 20 Oct 2026 15:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFKH-0007Sj-Ua
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:16:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFKG-00078L-HP
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:16:45 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KGuICL1200043
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nTGsGJ0avUK/TgXXgV9WWIsdb5xZN40tApPVqCKLQGA=; b=plSw4hoxMSjUuEgg
 0N/zwTiiiUwbkOm/Jt6nSsvDsNRbaQUN6I/rcVU1bPSu822reQdDl24GoxPFA89Q
 69Ts0mi/ISKPo1ezcK8suwaOHXpOpUv4uztGLbFFev8CIRf+rSykQ6TNhIsqF2Lv
 ylt/q5s/pOg7A7b6Br0UNL5OCC3d757oPQT7ljuxktR2GfQcbmIDbTpvlV8EN+AU
 DCULSqWT5eGGfNIKASi/BckH0CZ5Y/55nNKT7dKWnty9kVM825ZP3A/yVzpBQUvq
 XWPN3F29nP1E9Z9IP4L/dpTEQanMr8uXy7B/ImUwQkFp8wkrYsjd+fOLv9dF5htr
 ceBt8Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5sv2wu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:16:43 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35d4538fd74so11643041eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792523803; x=1793128603; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nTGsGJ0avUK/TgXXgV9WWIsdb5xZN40tApPVqCKLQGA=;
 b=FE7COw/AmnilmDi9J2M6/zPGs42gLTMqY4lnjPKZ2AjeRAUYKHol5gtCzbEIfM+f5J
 FENa4xpMylwFcw3eEVK69lw49NXTTMlyppu7yP65XN3TutClU4KNU/BJbbizkMJIQzum
 nrroF69IgwPg4KQLJG2x/OD39THyn2lXB54zj0fSPWF53Ii9RrvY9DIegq34rzt+a/gu
 +3YJDI73RW3kOqeyoyfdKTObDFWqnbruvUZWcxvDW7zXydFmV2idXdrfxIT5ibzvT/hS
 9EO69fSd/CKRYMRmspbfJqBJnyIS+nwJVQGN9cAD/LC3DyX1OOA+7g6ovdwnbjhC6tlo
 fLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792523803; x=1793128603;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nTGsGJ0avUK/TgXXgV9WWIsdb5xZN40tApPVqCKLQGA=;
 b=ciS5EVoaUh3kKWIg2Ul+jfPVKFg26JCb99gyCnFdCnaVVpkh04Yg/4+LtLbK0r4Mt5
 /PH6J90R0FDwx09mar9Vkwk2cWwCmbp+Ii1tDzvLGW4Zj6/R2jM3FNOhEhSVjgb/eSYB
 gij0xWGrDv19fL24vgMFMLEFn3T483PMQsIy5uEZdCXFW9Rw90D7zvEa8zQuIpZT67Ac
 q6dhO4a5pNG7XCtu9vjnm8TaEfb/A2S6axsyXG/1PNw+gQx3h5RiId7gSoJ/2SXwrdPw
 xrIo3Qzn3YYTdZolOBvdMNsyTNgNiYSQW0yE8231jroy+pgXcCOjUHdr+nzZqL2g2ZKo
 SIAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhwZkvL9RP6u5+7MbQAXymSy+UT4Jh3SX12Hpv3rpkMsQlJGbaYVKlthSrsfURTG485oWhZg6RMwq/@nongnu.org
X-Gm-Message-State: AFq9FYLvc5x+sF5gpVvEhAG2TWmgMQo4uW0zS3pNVyl3p0HBLuGWSlCG
 yqNbfhlC+QPVtamunhfi2xDTTynf96kRJmfxdPG85J/k92GzZh23vB0/4POcz4l5JnyApjGXOMq
 EGYLgdnrtAoZMfN3iP4eIZjMQQclC1uk02yRzEgWtzjofnJ2J5untv7GwHnEDrsOmOg==
X-Gm-Gg: AYBFou1kSEWCk2BQEz9bOpuQWRC8W3G6/AjNVbRFzOkvybFgALuXxSfs6SV6L//hYvb
 ZJozlCR8EGkP0pDr+hCyPOpWARxnGIqVgHFodV7VjfjI0VqLoc9iIMPl7O8+27XrFdWf5P3EKEK
 PXY+he+mvchguEMs1agQq+d39Namu50YduE/iIN0rGQXgnnSvSOFPQpmr9CDKQ9TbWYyIpznKbn
 I5mtpSJGT3p+Qudwb37t6HVQVgfLBHxxib1EnNFj3m4tQ9ctBTyN7QlkQQVyBcHsOMqvLwMZfji
 /f625tkO5XlKxXW4gPiC67V6bnDlpmgFc2rWUyWCr7LjEqWJs2UiVeKO8CN7W6Zr5ikrAII2G8j
 4PFdShiXpsZdrl1fKgpqSlELzZFj7BHsqBH1xxefSVpsEcsq0SOgGo1YZU+0pZNnAqOjo3w==
X-Received: by 2002:a05:693c:8354:b0:351:6409:25c9 with SMTP id
 5a478bee46e88-367502fb588mr200360eec.35.1792523802562; 
 Tue, 20 Oct 2026 12:16:42 -0700 (PDT)
X-Received: by 2002:a05:693c:8354:b0:351:6409:25c9 with SMTP id
 5a478bee46e88-367502fb588mr200312eec.35.1792523801993; 
 Tue, 20 Oct 2026 12:16:41 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3674198f1d8sm792782eec.24.2026.10.20.12.16.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:16:41 -0700 (PDT)
Message-ID: <b910d474-f58a-458d-9fa1-28747f4cf6eb@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:16:40 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/27] target/sparc: Remove well tested DEBUG_PCALL
 definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-25-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007094516.75732-25-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX+++5trWYMHPc
 aucA2CF+K7Cj2anM0GaDwliolt7nS8HZbRA0WxfVwun7xWgiQoPrqlVsy7eskDf2Uh7otQ3iDZT
 06mv+++ZS/EUh1ZSBKYifdGOS97hzfN4GKJfY7N1ADtoCNikKyOecBK44SCMz+1riCJWwxrO0OR
 +uekEIGddzE2WJgQWqHG9D+RECDUoO5LRPxzvxDWx7bZRPFeuXWXaM67AMr2i8f8gqbdruvLLVr
 inwm1aNCsQln8EkONCZ65+4SG2YYwJb2OWAIDBwcFlpyDavndxV82EVzM5tjBkMTUyLZkeu16aG
 uiXicTItVw6I4odlU0euF0eRDC5qkxk3vS1OsvvjMbNb6hoVgZ/X9KnXAhrlEfQUhU7j7x5tB/A
 4zdiGjGt2zUhzVW/diW4spxsJ178m6etB75/AemCqWIXwaawPuJt50HcOgxNXI8E8ByzAeZiG/S
 EF1WKKujPtei37/3Oew==
X-Authority-Analysis: v=2.4 cv=fIusTpae c=1 sm=1 tr=0 ts=6ad7be1b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=3shHJDwU74HqlicAzqcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: H6Q6xkiGWnzLAzGeg3kHkdq69zMBMD6w
X-Proofpoint-ORIG-GUID: H6Q6xkiGWnzLAzGeg3kHkdq69zMBMD6w
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX2be5v8iQ8sov
 skIkeKcFn2mRS7dAn/iQAxcW1vuEh5ZnhhyFIa638AI81/meoyqphgMrnsZIakF+ZZnIErUIkq/
 vowbi/UQWDKlIf7r85icFoSi+xpDEBY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200076
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/7/2026 2:45 AM, Philippe Mathieu-Daudé wrote:
> DEBUG_PCALL has been unconditionally defined for 14 years now
> (see commit b884fc5ecaa "target-sparc: Make CPU_LOG_INT useful
> by default"), so the #ifdef guards around the exception name
> table and the CPU_LOG_INT block are always taken. Remove the
> define and the now-redundant guards.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/sparc/int64_helper.c | 6 ------
>  1 file changed, 6 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

