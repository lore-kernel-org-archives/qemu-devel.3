Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB31C5DF8C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 22:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxB6u-0006mt-C8; Thu, 20 Aug 2026 18:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxB6s-0006kD-P7
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 18:19:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxB6r-0000jT-7M
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 18:19:42 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KK7ZX5250328
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 22:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5sKPUKp2cV+68ah/NCagdF1WZpJPO8y1qK6KZRobbwU=; b=SJPx4k6HluvqD9qo
 zDRfrxQYH7+jwbj4RP/BWjMxIFpGZxdGui/nqnYVYmjUpzX8rrdF3BTFdwDiUQ7+
 l8Ls8EiVphh8/gm1BR6iSc5vkYR1qlRHzHbUifFOlAzvjH8zP81g8njpcO/kIoab
 hQLNwFrU+uZ/1JWUfswXLF/26wh2MIfLh7aLx9CCOXSHCzp33U8FQoJuygmlLcJV
 oB3RRfxCAUxE/8U5dkbadLGfH+nq5JN6WkMlLx8TwKo++kP0w8Z2TAHDDhJOAxxa
 zhRz3r4ITNwDMr3R7Z/aKrVRtT/m5T1Jc0ITlmHEzswVqrkVwhoPiF5Dr6gwp03j
 6gAG7Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5w49bu3c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 22:19:39 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d55d8cd938so6750405ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 15:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787264379; x=1787869179; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5sKPUKp2cV+68ah/NCagdF1WZpJPO8y1qK6KZRobbwU=;
 b=YEr813auxdgHNiZ2/iRwbC+p7yx6/urMPEhw+nLtSAPbL2kfGaLWfyIcSbyROU4+WU
 P3ANgZ/qT+8pkX48YaIYUurdBCRoAWk+AqnVC9GZmz2PIRbSNQvBHFml+gLT0JkE5ZQb
 14Oq+HRH2X1SD/vsq3RckjGbSeQq4hPWb44Jg6LK1KHUrQWFvEG14Nbyguk8g/gAQngp
 9FsdqA8MJejoyQiNRL2E88ZJkUECZMme4INPgN3DlFXbI+MuMr5xx0NuZArnt931P6yu
 O89oasDXgAPvNLmy/LRcdNHU6ZGHLDAMkGKxyi/98JHvNtpj2fup/klS9YrauvNd3zEm
 Lovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787264379; x=1787869179;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5sKPUKp2cV+68ah/NCagdF1WZpJPO8y1qK6KZRobbwU=;
 b=Sab1wl3qvN/4cKmia0H7FOvWS//HIC8JLp+c/FNfWGbDyhY4PMUFzLdpmvrRICz4k8
 wzw7Z5JCOXRjkv2NQBiZSm5K7E4tkl+dXp7JbydRNZX9+wJcFL2/xH/XCex1oDPxJX9H
 uweC82CTzrDcpenw3Pu15PgEVeqBPOzQXWvG1sG1S2Uh38bO5E5ERfDDaNRAhjXlNzFo
 BQafs8Hyfb97vcyivzatKaW+tLLIFBxn7BXCwc81AkjuL6u4ZorSFcbuW2oiRd14C6Yc
 YclnoTwFOnnKjntCzhULw3mOsC8E8zzg70PCWTQNq4uEbcau5LRPUXEvsOjmT5Xwt7Qr
 uqRQ==
X-Gm-Message-State: AFuF++mqx/0+xU5AroFQVD5wZ3oidGic3NaZrLixZKI8N5Il/ngAmdbI
 iv1kwcUGdupVWtxmcRc4bXwPEp2z/02chLAzjSE0e9FxlpaY0rSKk1Ch+N4swUUHzIAGl+N5jJS
 zUpB06eVWchnC5qZJlNkt2MfVblWD5OHFFkT4DbpSmkEHrztFEHYzjnYkKg==
X-Gm-Gg: AR+sD12KX23Lf7BUKevDoE8XLYz03LtHzkoilj7LfStxcjRAbCqk0mo9TKFopd9psxQ
 08cdVtgX9xSM7D92qHdWdNoNM8fnCE/QWkxNYDWdOY7VujuxrTBb/OSyAxi8LmRPcUNRzf4Cp2N
 JAxjdVYD2pF1LIueKR/MA89+uh5BzpK2mhDdlwMJ3teoNFkfOtqrEvjBrczJyThdICiHNbfWh2Y
 pH3+v6HHQhwlXfra/G73B+pyOxh18oRTgw0GGrwVjGucMsysyBpBUTuleXUaPdYApFND4JxkfTj
 jfS9/nR7MLbxByb5zIxnseKF8bqOi8WePndeZ78WTuahe5PuNQTRJKxEF3P1lMlqytkaakWlvXS
 G58Fw/3pqPLKcoTU7r5i56tBuDeq+QMMBrLs9A2j0bX5GwbmmEfLSFCf4+iYLWtfdo0xa
X-Received: by 2002:a17:90a:e7c3:b0:38f:dec8:f7e9 with SMTP id
 98e67ed59e1d1-395c37130d0mr2771639a91.12.1787264379056; 
 Thu, 20 Aug 2026 15:19:39 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c3:b0:38f:dec8:f7e9 with SMTP id
 98e67ed59e1d1-395c37130d0mr2771584a91.12.1787264378616; 
 Thu, 20 Aug 2026 15:19:38 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ac3d1bfsm18528719c88.0.2026.08.20.15.19.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 15:19:38 -0700 (PDT)
Message-ID: <7c50a156-6539-4ae7-85a0-1b3110f67491@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 15:19:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 07/28] hw/arm/smmuv3: Reject secure STEs with stage-2
 enabled
To: Tao Tang <tangtao1634@phytium.com.cn>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162446.2806393-2-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260813162446.2806393-2-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2NiBTYWx0ZWRfX53IFSdvaoJ2d
 7VI+HcEen9mOobGQ4ZIrScLx2DrFJpiSDGfiN/Wrw/OAY3JGei20rBnHVxZo6A2UrwAidhxratm
 cGXWwEwYVpBxdDzQhANBFw4b6KtDJgQ=
X-Authority-Analysis: v=2.4 cv=YP+vDxGx c=1 sm=1 tr=0 ts=6a877d7b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=fgrLqfBXAAAA:8 a=EUspDBNiAAAA:8 a=_3-Uk8twvu21G8tx10wA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=_Ge82aPy-h_wFa7gWU4u:22
X-Proofpoint-ORIG-GUID: DxATudXFSv5wxZKsk8DotMzzj2aIIY0X
X-Proofpoint-GUID: DxATudXFSv5wxZKsk8DotMzzj2aIIY0X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2NiBTYWx0ZWRfX8a4ECB7/P+XC
 Yh/orKnErstFZLrfEY/Q7sRhOfkHU5JcBbXrVhqIhmbd7TjHyXY0BhBHQpJOj0Hq+iUHDGvgFl2
 R1YCbvi9DCAmWkuClhcBxEMKqqM5+IDqXuyI3QOIt13bRPa73afiaq0Z8RUjcIz7LFFjtw1ouiQ
 cW8hGyeDXn0HEtSLXrLGM1bSLh+H0oMqMnOWGxPBIlQeWnDisUvLJlHgHKfIozYD/eUhg009K99
 ClxOM58zSaBp1K5wKLLNOkaXe09DSKFQStkyKHDjnrHhArx//L0dd40pFTA8Tp6GQNtutaLCk0L
 LXvI/jDBpd12tmNpZ5tUrvbCoxWh06DJlyfxN1hLJOJOQdgR/kFYCkbGPoPx0zFqvfktWisU5d9
 AI2qWCpxNdwHzsqzLM0Xi0d2U2calETyAG7nMp0+uZcK7vu2IrvdNgAYWKE9gilTPi+xVTqL/Fg
 vIFjhQrlPRqkHxSb/mw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200166
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/13/2026 9:24 AM, Tao Tang wrote:
> Pass sec_sid into decode_ste() and treat a secure STE that enables stage-2
> translation as an illegal STE.
> 
> The current model does not implement Secure stage-2 translation, so reject
> Secure STE configurations that enable stage 2 and report BAD_STE. This
> restriction can be relaxed when SEL2 and Secure stage-2 support are
> implemented.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmuv3.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

