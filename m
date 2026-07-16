Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F7CC44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkPoz-0002Fa-Us; Thu, 16 Jul 2026 13:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkPoi-000299-Fn
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:24:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkPog-0000fD-6r
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:24:11 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GGT3Yb3396111
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 17:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0JhyKWeTrKZPaHH1dd/+XRZfAq+5mJrfFTIKWjhlujA=; b=cx4/tFDgWBqoEd2M
 VDIvZ8ThF2ngn4egsrgpWmHj0ONmmJxvRnQI8Z2A670yeF1KomDSTvfjPF6DhC9Z
 oJcpTgSq+37eNoFeIRAi4ka6SQPXOGqKAGhOqyq0JIm7S07Dd4HOtz/wu08os2ZN
 C7f70LDusMSLDu95ApApcOW543JaqBudNtwOgzzNMFif79L5TA8BrZKOf6YJySEJ
 DD5ZGLoCi5cG8RK5xmTpUlwhjpx1r74te782J8/vdDTUDsOjh2BCxs9tvXaZTASL
 dTqwCCaCTIcuo+7+U6kBzG+LOq2/G/xof4NFmFFMImyjujmu8Fh5fGxOOg7TRL9s
 0F8cug==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feym1998v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 17:24:08 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c8952346bb9so5905605a12.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 10:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784222648; x=1784827448; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0JhyKWeTrKZPaHH1dd/+XRZfAq+5mJrfFTIKWjhlujA=;
 b=WN502cuJt13/25mM7cTgF7P76/h3r/H8xod0zWuk7BtBmQc8TSDOzq3jH6JxIoGUYz
 N7Ceuf5EDDWQCcwvugS1U5V5NqclXQbusEwmNnNX9o9lkKIU+qjGZ67IJ1nBxkx5HRHz
 bejkYoDnLpuZBLWZ+AlFW2gvsiquBetQFMhtR/xgneboCdJis1rsKwnmqFJmBCSvhFz7
 IfkvXSbcVe6owC5EbvtugCmYtGPKHojmp0TpfwaDYucRxO0/SGsyK0rBMjai5a7NWvzK
 D+qFsIyc+n/YTttVr8bRZx+tj5Ae36btz9wep8mR9zzLIaicX5lkHFm+zMsbMhebxdq1
 Wn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784222648; x=1784827448;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0JhyKWeTrKZPaHH1dd/+XRZfAq+5mJrfFTIKWjhlujA=;
 b=jP8yqJU+reE1b9vocaq90pfJM5xL833y/fBVg8vxrfpnG39gtzwlnRctjrNa7iW6Ap
 0U8TFos/MRpNVMuKm9pAUj+tqOOVoCx4CaF4E1kQIMhXxcp+4fMJjD8g4jYY86mzbVUx
 CIBfwQz+9APzwS7V63iP17Mx1S/jnFy2sctBCWVJFLHfuS5piQElG2VsN8/+80LMEbmS
 VBfE5lROOyUAOIBSfqAd/BiThS1B0iLo6juNnPlJUBDFZjgqy22xfBFrg1ZvLq8d5r0g
 YEoSFsWsAVP0EBS3RJK2FQO74zPcCMyVRl1TVRGFlReh7DwUJBEiA7ZtKuvOXc3mIEzI
 y0NQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpN71T7GnT/AtcYVaXh/ZXm34NUYokXJvFXs39nBZpmN4B1slCKlqDEUNzIr4zi0StPuBHJkXhOVFhH@nongnu.org
X-Gm-Message-State: AOJu0YwZx/ApoWXdTyMlIN0HhbjFR0jbRwDJ6brrZCG8q2MsWObPdcWw
 ZCitfTMLgBXD87Mj/bDlj+iXSpqXhkMKHsTKdrHVsGpj4YJEowwKYHgQYlbi/UmndqbQ6fgVUaM
 eaa7SSWcZnc5dDHrBQMpDUVAtekZ1wxWFSxT487zAA72Uqk6Dfc2XdPhNhyT09hhjKw==
X-Gm-Gg: AfdE7ck448rEDsbq87YriErQgh4gt/hw8bd5EgrTz4tjZutPN3NMV/8ypxzsL0qBcBW
 lRrdkHxf0IPrD1+YvWxUc4hF/0dTCdnPPi3y6sh1Ueg/CkUvJCxOePN1b5uOYxDZq03OrWLaTho
 PnmfnlfAqb++cV6h7hbOWez739gw/dHuX3IbPTTN7BD4zQJzuUY1018EdD6f8TDFAkkQjzAkW6H
 sDTT7BegiOZEv9N7B0sF9V33DSZKcLm226HGEP8xHHxww97T+c9PmfKGqHEn+C7QcBETlB1MuNG
 LINnqj642Yxq2Zs8nIUrn+UMGH9jFzxVg3uONIWfkzTd1xn7n87IgbsVUU0KQwXCWz5zDdOK103
 SgbqtdKRYO/mJRGodJgH+IDYtYvpusdgzy5nuEU7SUH1mPSyEX0RMphik4YjNn/oMNOmF
X-Received: by 2002:a05:6a21:114c:b0:3bf:b68f:4682 with SMTP id
 adf61e73a8af0-3c36c0e281cmr10128468637.7.1784222647621; 
 Thu, 16 Jul 2026 10:24:07 -0700 (PDT)
X-Received: by 2002:a05:6a21:114c:b0:3bf:b68f:4682 with SMTP id
 adf61e73a8af0-3c36c0e281cmr10128437637.7.1784222647193; 
 Thu, 16 Jul 2026 10:24:07 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6ebe98sm13027215eec.26.2026.07.16.10.24.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 10:24:06 -0700 (PDT)
Message-ID: <d20f1448-7da2-4c9f-8809-313591b3c908@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 10:24:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] plugins/execlog: fix segfault and flush output on
 vcpu exit
To: Harry van Haaren <harry.vanhaaren@openchip.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Alexandre Iooss <erdnaxe@crans.org>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260616161242.267315-1-harry.vanhaaren@openchip.com>
 <20260716094126.787556-1-harry.vanhaaren@openchip.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260716094126.787556-1-harry.vanhaaren@openchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KPRqylFo c=1 sm=1 tr=0 ts=6a5913b8 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=OZcmDFxvAAAA:8 a=EUspDBNiAAAA:8 a=MI6s7Ohd7u6-WKzijUcA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=liPxxeoTYnb3ClP5OJlV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE3OCBTYWx0ZWRfX+W2fDti+0JYj
 w34cVIo5Ss6Ij0CeJWS4XduuNZBOCD7zUDIVLW1l2UfGOwR+D74+2j2e9EQeDghZOzAdj8e+cb9
 4vDEj+1YehU1INriUQRGbXso/pOPUp+QABYSmNAvGdtVU9nbf77a46rFKiVmNseyiPrIcx/9HU8
 VTyrFNWK5OndfQN4Fwlk+0nYW0rtEwZWf1U0p4wjEmX9WfJQaVAjOfkhff7KHgQi63N1V92Xfz7
 2u9NVCVC47vy4YfkATY8VtLPp9PX7GyIKZD+8rUdN7cCVnW4T8+/SQbPgFyq3JB9l/UxG1OjdsP
 XNQeK9Hu+BbE5I95eRz5E/q1O9C1S/Y7XMqQxWXGPYIyUuttT+7j5Qbtc0vn9+kCncXCtiLPWps
 Ho7rX1noAD6atpmQHtnKaTcaZX1vxxDl7SJYNfHiNZH8rBhOh3li8HPOKE2Wsf0RRMfOILqzscU
 fY2JTX4OkC8ywYTNR5w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE3OCBTYWx0ZWRfX8yzrjv27JXUp
 AlJdGmcVgVendXmI+UBT4L7YVzh7EeYxuTlJV1azWt9duE9NePjsDnN5hj/I1awi8oycNyMe40a
 CxUxgFmsEbfFEPu/breA4cBYFhUlGfg=
X-Proofpoint-GUID: n69DHgPCOMixbFUrGBFZRV7E_3UhohRS
X-Proofpoint-ORIG-GUID: n69DHgPCOMixbFUrGBFZRV7E_3UhohRS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160178
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

On 7/16/2026 2:41 AM, Harry van Haaren wrote:
> From: Harry van Haaren <harry.vanhaaren@openchip.com>
> 
> Hi Qemu-Dev & CCs,
> 
> This is my first contribution to QEMU itself, but I have worked on
> DPDK, OVS, and QEMU-RS a bit in the past. I have experience with
> mailing lists for patches and some QEMU internals.
> 
> This is a "git publish" reply to the original patches that weren't in a patchset:
> https://patchwork.kernel.org/project/qemu-devel/patch/20260616161242.267315-1-harry.vanhaaren@openchip.com/
> https://patchwork.kernel.org/project/qemu-devel/patch/20260616161242.267315-2-harry.vanhaaren@openchip.com/
> 
> Thanks for reviews and input, the v2 reworks as follows:
> - I expect email to no longer have "| OPENCHIP" in my name, and the email footer removed
> - git publish used to send, with "--number 2" to hopefully get a v2 patchset out
> - rebased to latest branch, atexit() function signatures changed
> - avoid adding mutex for output, rely on QEMUs logging mutex (thanks Pierrick)
> --- use single call to log to avoid line-breaks corrupting output
> 
> Please note that LLMs were used to investigate and fix this bug,
> but all code in this patch has been reviewed by me, and I believe
> it to be a good solution.
> 
> Regards, -Harry
> 
> Harry van Haaren (2):
>   plugins/execlog: fix segfault/race-cond on per-vCPU structures
>   plugins/execlog: fix execlog vcpu_exit execution print loss
> 
>  contrib/plugins/execlog.c | 88 +++++++++++++++++++--------------------
>  1 file changed, 43 insertions(+), 45 deletions(-)
> 

For the series:

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

I'll pull this today.

Regards,
Pierrick


