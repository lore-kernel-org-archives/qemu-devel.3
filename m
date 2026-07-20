Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079DFC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 21:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlvAV-00045h-MI; Mon, 20 Jul 2026 17:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlvAT-00044f-I2
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 17:04:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlvAR-0001Dy-QX
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 17:04:53 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJTg2p3540058
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 21:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 55Z7wNA16ltcEvbM1CLER9fWwuEisiKz8pj8THDjbME=; b=mefbdneJYdBsfyDe
 mmzhz8jib3n07sojKZMhDrFwra5gsAlbwPxhaZSrBOJgUKu834oPPeeE74StzXpA
 eapolYJf8IQ4+Q0+R/gGnT4nz3stp7NpC5oLrK/wfgi7TvYBQv64Kxs3mN9shN6/
 xs2hEqCGDzHT7e+MrevHFy0RCscWS0hwgeCoNTPcf/Od5HJlr77tc4WnSqG3M1Il
 1Wo8a0cuL337HqnT61q3ddvnVgDmbNtgV0ICWWvQGX+CmQbfH6nbrP8DZvDQ/PSz
 JuZ3ISx2iNrE7Q8rI+bgYuPxfre2d9SYbHo9UvO1DyvO0+X56tEeAqTaijOrbOra
 kZnR+A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhk2fageg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 21:04:49 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c2af04aeeso15349191cf.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 14:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784581489; x=1785186289; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=55Z7wNA16ltcEvbM1CLER9fWwuEisiKz8pj8THDjbME=;
 b=ayTEPc5GhSVeG48hO7AqTcMWco6ST0Emj/8RYOjDeW5MNpXEcHcAneY8M17Aen9jRC
 Vf5hkuHibJ4CHCr9cDLuWLLqZPjQW7q3E6obTqEcx1VF6LFSslNphliKceYVW/+/IJZP
 60aDOC85AGcW6cDGiOCoYSfelH0z0SAp/dNeQiYP7m9IbgXdNZgaf39VDUZTpNd3KH/x
 y3BkbD8uu7c96+nbNDznBwoIhwWsx/SbsZVlbW6iYa342jJc8JP3IZoiRd9vt2ocP2zU
 wTIR75qdKvT9aAITHmt4IGaXyf3/K1YdaCBOxSUp5mHa7ec6DpXwa6ogLyF1i2cUajSB
 vDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784581489; x=1785186289;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=55Z7wNA16ltcEvbM1CLER9fWwuEisiKz8pj8THDjbME=;
 b=aNiLnYzjKM0PjtOjJch3NfxWHLkwTPHoshRwOTfdyB5cl9lJaqZbWuFGtD9TKw8f+V
 amZ5Ma4JxVkkrjt5aG77xvY24I2KH5XATIs1+DnVmy+GZgU6KzE672DooyCBnvYXWea/
 KCk8Cb1MPS6sLrCthngreRKPQjNo5wDixVgn8pgM6Yc/sMUqw9l+U8onL948u0owSUHR
 voumGjn9Op+3246cv0gO1ydBnHiVnapQEsO87ZJVQbWNx1q9DDoQbGxmTljv2aCcnB4k
 nL1g2b8S+zU73ck+1M8CGhCrIacv6ePchTAow84kNPMD9xWrrIB+lnp+JUz3ZvxgT32T
 EY/w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+0Dn1zDb70npCWZ1+CT7xKwuHbu2N28/eAhHwOxHXQEX6B/w3hOGmOjA0oRD2MONtIqxOsW/ckg4a@nongnu.org
X-Gm-Message-State: AOJu0YyV/l0bTugDcRPCoUBgRsDyz9LPCs/HUQDjkvD1wbavwSBYR5FT
 F7EjV3sJ8KcI4hXYEoKeT40hvgeYgeI2TsH0Y4IvSxN6a6Ieu/WNYnQgkC18XxFPLXRmMnMBGAq
 yDp0TeGMC6Y8HcLfNO5Qk1aYN254M32/sEjCPHEMHTsPG4yKwKWfDwJmBVQ==
X-Gm-Gg: AfdE7cknMQ10VlQlzeRNsZpwZyA3VXvlJS3V9VOh/SQxvvZ1wdUtStFtcJo+9I4C2fe
 1060iJSLNSM3Ogp4u3Ays/LmG9G+VI6ps5AMl6HGHcFVZDR0HONQPXvurTwDkaA2MIGk4TZrY0Q
 7Rwl9z9t0MPemVJ07eDtUujowkHBv8dP2j4Wo0TqGMrPcxYwD3tt4ZVMV/0AFzXJcLd2s+iedgm
 Udv8xhyE7Hz7TtRWyjvIkje0VEP8tz6klhW4IQezgcvFVjJXPInma5TbcPIVY13LzRTbUlH6ZVV
 l7MIkRA8S2hNXKYn/ZIoUAJPGULE8LI/g2vFYwClIN81N94F2/7Tmflj0o3PbNxaLi2hb1f2i1u
 CJJLMMXPCoygrNpVPCKL+riELT17h6yU4GI4nDkFTJjIV703I5RI=
X-Received: by 2002:a05:622a:3:b0:51c:11c2:dc17 with SMTP id
 d75a77b69052e-51fc214babamr178008371cf.40.1784581489150; 
 Mon, 20 Jul 2026 14:04:49 -0700 (PDT)
X-Received: by 2002:a05:622a:3:b0:51c:11c2:dc17 with SMTP id
 d75a77b69052e-51fc214babamr178008041cf.40.1784581488607; 
 Mon, 20 Jul 2026 14:04:48 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49565dbc288sm3916695e9.4.2026.07.20.14.04.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 14:04:47 -0700 (PDT)
Message-ID: <4cadb0cd-7393-4def-8aba-dbee0cabddf6@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 23:04:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/sd/sd: Fix error case for CMD18
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, Bin Meng <bin.meng@processmission.com>,
 Christian Speich <c.speich@avm.de>
References: <20260720201133.24796-1-shentey@gmail.com>
 <20260720201133.24796-2-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260720201133.24796-2-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FtPc7sG4X3ZE5BYCfZGp54jE8PbXec9S
X-Authority-Analysis: v=2.4 cv=X8xi7mTe c=1 sm=1 tr=0 ts=6a5e8d71 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=FRSEYCzRAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Chql7bB48b1flakHqOkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIyOSBTYWx0ZWRfXyNS4dV+bOAHO
 CUA9/yWkYFPowvXX0DJKVnlr8iF7aJXIDVLcPhtdw/05ecA8qAo3/1rnL03aaPBOqQAKvCJ2aCR
 16Wo+ytDmZII3mL6zmrYLvDxDdTVlZA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIyOSBTYWx0ZWRfX7rlDTmkWSXf/
 CnKXotYBiNLqSwaLP63q9wICNv/nFYT1EAsmd0J+iCLRjgzV4X8lKZoCm5MhYUtMDjp/CHuJYmr
 KMtVY34KL3/iElDdqclvy2/Nxhi7Q7G2L5B6FZazZOWc/DkCu5Kc8wAXYRg6c/Zwy8zy3vpiWoM
 bsav9ldbphiWuBzgzlEIwv1uZ/ckitct1tX1SjzHX98Cw0CCwprAN3+hf047SyJZjB1Fcq+XE4m
 RL0QFXCFq2SHY+KslsgAEtTFWzsvk/caKNHnybH3sapOsZ51Kg0bw6ola34CDIWcHHIerR6eg+P
 UejP6QWwqP3xpmtlXJzIudaucIdHW9Zp1AwDfhP3G20oKHpr08kJtKLU6FStCbq8YgCTxpLDQY/
 XWUO4wTm6F9BXLuutD+h+XUi2U4FE/sGu+gj55A4v1HGNyIpYoeYsWyeGpNNMCJaVEztoBWMAcI
 YLQzPAUAKY/C+6MeU6w==
X-Proofpoint-GUID: FtPc7sG4X3ZE5BYCfZGp54jE8PbXec9S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200229
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

On 20/7/26 22:11, Bernhard Beschow wrote:
> In commit 468fa450a7e0 ("hw/sd: Switch read/write primitive to
> buf+len"), `sd_read_byte()` changed its contract to return the read size
> rather than the read value (and was renamed to `sd_read_data()`
> accordingly). In an error case, however, `sd_read_data()` returns 0 by
> means of `dummy_byte` which is the code for the old contract. Moreover,
> `sdbus_read_data()` asserts the virtual method `read_data()` (and thus
> `sd_read_data()`) to return a non-zero size, i.e. to make progress and
> not loop forever. Fix the code to behave like the "DAT read illegal for
> command" case.
> 
> Fixes: 468fa450a7e0 ("hw/sd: Switch read/write primitive to buf+len")
> Reviewed-by: Bin Meng <bin.meng@processmission.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> cc: Christian Speich <c.speich@avm.de>
> ---
>   hw/sd/sd.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 3360757004..a30c541df0 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2860,7 +2860,8 @@ static size_t sd_read_data(SDState *sd, void *buf, size_t length)
>           if (sd->data_offset == 0) {
>               if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",
>                                     sd->data_start, io_len)) {
> -                return dummy_byte;
> +                *value = dummy_byte;
> +                return length;

Oops, sorry for missing that.
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

>               }


