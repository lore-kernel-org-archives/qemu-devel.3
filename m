Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E27C98304
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 05:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9cCB-0000Sp-D8; Thu, 24 Sep 2026 01:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9cBy-0000Rp-5l
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 01:40:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9cBw-00035v-1M
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 01:40:21 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5eGA42277216
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 05:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 czgP6FT8YPpYvQI3C9SEY1kl21C5GpFVz+4+8A5HKrg=; b=Ytn2lDnGz4hizfK7
 jSYl4Wfv5K2t813LGR1zhYt6sN2Yv3aeuGw2oW+y3WAIUkdWDxwbIRYWN6q+C98j
 0AwfoLeKcK7rTLl+QlWtUPnxWZQUJRyQc3mrYaMJJN9EtDg+HqfzjEBQfXhjFAvf
 moUEPylwB18fw/eWGkHA3f6yVkLZovpsJMUuPXcNJTaWAdYFGPTg1/NPjR6pPv+U
 /D9nnR50yoV6DTy/v0t1Jr5CUEv6n2Gz0+I00QISnUt6zVzEH38S7mxuiAxOa7NF
 oMeXB/BujYgjOFzwKMHfCNMye418ylG+D3vvEnJ6SQ+bDfCwyf/GAqc6EMN5tqGH
 aRLrrA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjxuemb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 05:40:17 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93903622880so106036785a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 22:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790228417; x=1790833217; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=czgP6FT8YPpYvQI3C9SEY1kl21C5GpFVz+4+8A5HKrg=;
 b=kVbrUZejkVj1rKGamU7Tz+zeG2bdh/T0S6Ql2tTdfv23tnd/XqoPNSo8Y7NUwLx3gC
 YHdH/vmgb+Tjl27+vz37bb7S0WwRBsXClp/mnD0Pid7xAVJPnJ3MKcjVilglCj7GTuiN
 U/rzkxih8TJ+14wtkMJhLE/EIug0UVAku2DfmX0OhbGdFibKKaYTvLF1P+DMyA+kcdHI
 7QYOI0GvUCpOvmkGfhV8P+S2InHAqe4IwjUM7K0fOf3BwiD6QX9xkegn5u7/cjkdSHUa
 ipFcxAjm8CO0Na6pRuik6RvI3ybK4Kd3m0zWlwZ0wdsu+2ItItdouglQ2xH48OtV2Cb1
 k1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790228417; x=1790833217;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=czgP6FT8YPpYvQI3C9SEY1kl21C5GpFVz+4+8A5HKrg=;
 b=AWX89CM98Wfy4MX1k14pE21HD26MQm3SFqaezqyee9BpuTrKzLQCyz0CCwx0AV8v9p
 lrxrHMdOscqrjSPVXZSKZr7dBXyjqct9TQlsyq6YPg1GMV80JowpzDLqgofYVkYiGBpJ
 Pqxwi0gSQGR7aZn7tU68/0p5rAxRCHah26O/POQm5/YewOs40etZReApOuycx5RtKveY
 jmAyw3t5qYI9MBuStyb00qqE2vpJJMIo3urNzs62WONzTsiJPEtyfAF9J/nfW13npOUg
 4Ak6tdD6Lt+s5tjAenga4Z1JT1xTjpOPgIK6Re8QqdggwZaQbAmui47NmF/pCG2Ag0kJ
 mMCQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYXWlOEaobEnc3XYEwU6G9SAFhhktYzWkq1SLPfDxXgy9LMmxxO19ADRZDbjAwlHfV8P9cVe0HB+4X@nongnu.org
X-Gm-Message-State: AFuF++ke5/hAWD6f/TaPsXum7154iZxgRQns0U4fObuQNsVqNyvZjfYp
 KSVrJu58mUY3fKbrlwMTNAyrwADJNt5dunbMjIVBJgKfp4myDDNhkd8XgO83Se+X2Bg/iHXLwNS
 FfEAbl9L9siIE7T2Q3yL4XITGRcGn1G++fD9Sibb+BFiAoUGL1N7v49OHfYdY6AfGxxdz
X-Gm-Gg: AYBFou1eMprFIWk47IqH/1BL7jD2612ABoHry9Zg//abQZWpb2NpM1pmojlUydU50LD
 KWOPeHDrFCtzE4AbOLHW/F/T5QErGJC3WQfb8W1Kfvkq3k7dquJ2Ksa+6i4mmT2cb1rpr6k0bTv
 qV+Cgbum3YasTBPKE3zEBYCw6IXJ5jzp5DRfbM9MkQV+sYb1AmqWv84W9b7pMLxRpZsxBlBZTLV
 0jtbbC3fNIs/H66f4dUi7y1i5DYzE/QXYng5S5jsEkB8u7wDbiRhlafK65JwyXa1PPk+kEjqAMs
 G9SU/9SSUtSQsx8Twi6YuvhIfITTvV/WX9cCncNZ6IbrhBUwYqoFi40Cc6Agl2tZoZcnKETeRn9
 v0SR1bX0GrnJDDFlYao6XI4fkeu+Dbdd9Mw==
X-Received: by 2002:a05:620a:271d:b0:939:a095:e458 with SMTP id
 af79cd13be357-93c3661d870mr118499485a.3.1790228416663; 
 Wed, 23 Sep 2026 22:40:16 -0700 (PDT)
X-Received: by 2002:a05:620a:271d:b0:939:a095:e458 with SMTP id
 af79cd13be357-93c3661d870mr118496585a.3.1790228416177; 
 Wed, 23 Sep 2026 22:40:16 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488682673bdsm11674193f8f.2.2026.09.23.22.40.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 22:40:15 -0700 (PDT)
Message-ID: <599589c2-5a2e-4506-a69c-3d2f262b842b@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 07:40:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] target/mips/tcg: Fix zero in gen_mxu_d8sum
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260914230901.1781309-1-richard.henderson@linaro.org>
 <20260914230901.1781309-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260914230901.1781309-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9SIwsPJQ8jzs0xfED8rru4Wf_fprhB47
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyNCBTYWx0ZWRfXzCadO/q0px3m
 MjAIjZeifpSQO0myBFNI3HZemJxBV1qMtNYt9aGv7XHML4B6BHquLCl7AFEzAMCLERSdoM3+hGw
 1v7rSZunMS2eNQ2O6PRUGBeFg0ZSuYTGJDtxYFjUTVHTxU0Fif9ZqH69Fd0MRBFGslLnPFepzHi
 xRpxUa4D2eLzl6jc9C/rSHGsTTNsj7jZLmpLFAk9/08D5qaGMqMauV/OH8G2QC/ETmgje7nqWd4
 +h6z7tsdNO+/3hQWvcxsX6C5toLAmibjWrK/43TusvDbRzwo0KNZRtPInh0k874B9vnUKfejCJC
 jvR4yZP8j3M9NA7G6NeAd1KHM2CMi0WuM24DBXQOdk4ez+W/Bp9y7YyaprOdAHx0PUPubY/Ehtm
 0ApqFvvVJTak8IgyRvc3MdE+GcuO1r3gENhJ0PTNUBWpN6wv+ATpRXp7Js5l3UDThuV4AJEScjF
 +7ExbYzwPV/ROpZSP3Q==
X-Proofpoint-GUID: 9SIwsPJQ8jzs0xfED8rru4Wf_fprhB47
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ab4b7c1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=UzISIztuOb4A:10 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyNCBTYWx0ZWRfXx1b1vguI/buz
 2gDnol/xyADeU0fl7G7TCMHHO2Hy99rJ/58sz8lbXChJTAU8y/1T4ZAvIJB14Ge6c/kOp500ytW
 ug3Awr/idQTHKypWeN8boOHlg6ghi3s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240024
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 15/9/26 01:08, Richard Henderson wrote:
> This is obviously an attempt to set temps to 0,
> but accidentally passed NULL to a regular move.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/mips/tcg/mxu_translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

