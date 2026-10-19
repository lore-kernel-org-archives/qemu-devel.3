Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BFD606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l6GdLBUy;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Adz+UxEH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIv1O-0003Jf-LH; Mon, 19 Oct 2026 17:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIv1H-0003JF-4g
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:35:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIv1F-00079x-HV
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:35:46 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZNLP836412
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5kFLbHZyMxg9ywdDfXz7FbQD8m9M4qA6n/eC/pTOjAM=; b=l6GdLBUyDC91fuoX
 YR0zVYwr9dDIOStFdAJ/9gfBayfLFs3pUaWHNSfSOUekq1ExlWDdoaMfVxWdgZFx
 bwAdpdCtrgG4nol3m06RH9JlObXJbniFqC3aAsc81mw/BxqTD1aBVSqrnZ+p502h
 b3XdKAfyuNdSjLkf61lZzjwpdgXnjGc7N+gv2ZetujTGKeZ44TGZIQMLVb+lPTOx
 0uzjlPQ9+fkWveJQsWKP2XwHVAHe0JrKUSZdlB1+mY3DtNzUQQHrtNWgDBU1IjlL
 YYFMPiLsM60s3kWqgMlmzz7tiXIt6lE1BSz1VDkGJ3k2dtYZFbtqIrXBxqW1J4IF
 PAMl7w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf47kdjy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:35:43 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0d568830so5531106eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445743; x=1793050543; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5kFLbHZyMxg9ywdDfXz7FbQD8m9M4qA6n/eC/pTOjAM=;
 b=Adz+UxEH5KcaiQCEUpAts0lPI03aKTfzevUKCMh4JKOzExdC4CmwF8p85kTpxWRJ16
 wB4idRyx6kgRSshdCTmz6fsyLPnzLHzNjr95p4EigEZDZNGSBYAnQHW/cxvC5gAqueNb
 T3uPsBsdQ4cf4DiY3WN3YxtMYjBrqu+j/fxN+M21o6oyipQ0nGTNF04aKhsXyY07sGKx
 h52D6myWIzVt6G/aiz+iMS3K2Mf95KWp3anxFFRYmeZqA5v8m3/83QbMrM/RYvmd9J9q
 KpBIQ8fpnhEiT3NiqdDFV0SQ3aKljow5nN60nTKLOEHx0cfWdqjai8ffMe2eAIFygTs4
 lnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445743; x=1793050543;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5kFLbHZyMxg9ywdDfXz7FbQD8m9M4qA6n/eC/pTOjAM=;
 b=yVf0dQWZLuonOGRhoJ/5QfMAKEhhvcGHmvAF7/x4Rxr4x0mhe1A33N70uskWr1S6yW
 a83eSY9k7Q3wgLsswsl2x6SNRpAUffWwKlJj4+PIJFbSi9FrfQGyP8/iosWmNOH8A8Sz
 zPKJKx9duDONfAyli19gNXkaup7ZlKTnvKdRSXHnySKowYPWnBQXsFp4WQfyr+jabrY3
 K6fqnG2Rg4+UzniTorBbYMxQri8xm+i0cai16oZ0wz/D8Em1KAPCSzkq8vttHkfvKopX
 A1e7K0WRBKfeYnBHnkEMQiZ1Y+0TJ9e/QRogRtDQ3T6oAg+V7lhiAdd7NJqSm+HyFHQY
 CguQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBysAwh17Vt6HmxoBLFIWa3ej7XCKyoDCL8zCZqu2CgZIy7ULfFwkdZ+drmWslj3+tbwAFjWF3K08Eg1@nongnu.org
X-Gm-Message-State: AFq9FYKnDQ44oj1O0XOHMsL+qlb8uPdoGz7yR/xXdivHXOUSSPhAQn6X
 eJ2VPkApbMTAf3DQmBKft/1F/eLyuZEIUuImrSI92zOcTBkKvO6NA3y6wzqwGM25pGI/9hXVFdz
 pxwy45bvwO69NPpEv3my6PNt5itgzaZrm4z2VDcDIWDo8xPwJmmEHBO7Q4Q==
X-Gm-Gg: AYBFou0Yy5dDjeHxZW93AQo7nILENrIrrMslCG6biEKeWFYSbePU0Kz3tvpKCxLYmN6
 ACWoiEcwhZ002aGIC7g1SMsiz/SDExRFyn2+oJOmuaPignK+8LSVs1vz/FBMpwN6f+qKAtZedni
 jKVDm5BP93feMtZZtuRR/xOZ+RANM5Az0toDeHsM8t8Y6KlEOXbIS53PCb57YUQq5T4gGUcKp8O
 yuovGMLDrtU37lCqPv2q5YMw5qYMwjLCnAcOfvjUTw8Wh76kkSnkEPQJrht8Ajjcy1vLWy5iLVj
 maJ9d08PFPdGSR34i8WEhikvTOnxq18jN/eL0xMyHLWQoQldVvPYbPUOj20AV9o4RBXSE987LrC
 NW5k/YcWwUNvbd2LCl2shIVNGRMyuvgJW4Gcl5ozMs3xesLjKiUaCZ+ATKvFd69YZzPUoVg==
X-Received: by 2002:a05:701b:2807:b0:14d:3c0c:79e9 with SMTP id
 a92af1059eb24-1851160d021mr12325311c88.11.1792445742928; 
 Mon, 19 Oct 2026 14:35:42 -0700 (PDT)
X-Received: by 2002:a05:701b:2807:b0:14d:3c0c:79e9 with SMTP id
 a92af1059eb24-1851160d021mr12325218c88.11.1792445741400; 
 Mon, 19 Oct 2026 14:35:41 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831b75be5esm42992249c88.16.2026.10.19.14.35.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 14:35:40 -0700 (PDT)
Message-ID: <6d1f45fb-1b6e-4cc3-ad14-a280df8fadd8@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:35:39 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/hexagon: acquire BQL before reading interrupt
 state
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261019060911.1479329-1-brian.cain@oss.qualcomm.com>
 <20261019060911.1479329-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019060911.1479329-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2IVDdMwPwVuDx6J9Z6SBkIzr3aBDPNeC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX9DgT3NFCNesh
 qjnbQsVBWJsm0F0oYqZY2mLE5wE31YeR2fneY8cvziv/Wzoa2DqOL3GvnpTf6vHOyHchIXR60HK
 80VZaejPU/Er77XdB5bqItN7YZzun3Is/isgcYMnBeu3cmgebtb/Q8oHldQslHtIsL5pwl7nUDq
 ypXPxQP+szst7Zm+LXeUcB7sj8YFvPdWtWP6KT7WODwEsm8ptshf6GHDrjG+Fg6xI+PoXyVr1JU
 BLiTuaOmGd9qCXjSHYXLdyPPRiW4MDoG0NiZXl124A1enJ8rZoRDjgVCFrkPS8OtHtSn2CnIHqo
 CObrk0xiWsrZTytvkjThdxzdHx8AYgCC3r40l8jIAADSFpmTuZ3NU6WxdHXNEQrqHoeVuQPMSYp
 b0qNHRIG2SogCiPh1EcTqFlNIhnMn4FNizVldZWQ3XuyCFrIPuCwUCC6PrACdYgZbzfMVKooyjJ
 a4pEPI7MW52f9XC8DqA==
X-Proofpoint-GUID: 2IVDdMwPwVuDx6J9Z6SBkIzr3aBDPNeC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX3Ua9+wtVOamU
 u7zoXKnCURR5hzkJcHd9qmaEnS9sFDNjaYV+/imSFb0W0gexsxMvuoU2HDiGf5iyXsLQEnVZNUG
 OSbwA1CjKKJW8hjwQ+x5Wp+l+buhvqE=
X-Authority-Analysis: v=2.4 cv=cLt1IVeN c=1 sm=1 tr=0 ts=6ad68d2f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=jUABQhHfhdMBonUgdsEA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190086
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/18/2026 11:09 PM, Brian Cain wrote:
> Move BQL_LOCK_GUARD() to the top of hex_check_interrupts.
> 
> There was a race with hex_interrupt_update on other vCPU threads when
> enabling MTTCG.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/hex_interrupts.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

