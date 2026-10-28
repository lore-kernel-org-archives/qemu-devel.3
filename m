Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F93606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eR4lKRDY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eNlN1ftd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMAOC-0005Tb-88; Wed, 28 Oct 2026 16:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAOA-0005TL-Ml
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:36:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAO9-0004HI-0r
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:36:50 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPLHP1942060
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 grEDIXQ4F5YIW/ZdOFyS0BImQusuv/9clJVU2L9OHI8=; b=eR4lKRDYhJemHaxL
 QtoHX+xmNnsYTYKInEfypWY1DLgbYIxgfuwOEFm40H/n6OnRWWp1XxIW9ziGxcFY
 jrD5ubDizU/n77XHK8iIvaliuej0fd6NXk53OL45Li649U3qhegpT2hgfYJmxHrz
 gKAH+nk+vjOs2ktF/VTLZjh6J9PIAw0z+kLeqyU8khZmZrcP4QFDRIku+HOeOAUP
 jX1ytPploutysbI4WhrzzYw7yyOcDWpXQIayqXNkWRtmuf8IQTUvHi8k4yFBr9jY
 /8jRY04oL373/sjq4WjbDOQKLI7qqgJ70mWodds6Donzt2lfpNKN7Q6fmgHsoCBe
 EoktDQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkbhwbdaw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:36:46 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36a1e2485fdso3003550eec.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793219806; x=1793824606; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=grEDIXQ4F5YIW/ZdOFyS0BImQusuv/9clJVU2L9OHI8=;
 b=eNlN1ftdyeyCH+8DAiSOyPf3hew+08qippMtYKrcnv+96oQ4Y/jhDNg6fWHIdcnttl
 1p8LtKnE4Grqluvxfs9zLbVu/k7bT3J38r1D8OWSg663VpoqV8AefnmZyHKpxODQJzXI
 PFMYJ+odiR6kl2tf27qVsKnIr3Q6nrU2slM2CkUFcORZyKvPKfNIbRy3ovUgUTWUuKaB
 LrlzP06DmntWk0TXCTokpWsgTY1OXX8XEIFEJQqeR1lkIZKIsA0XgYX9pTPTxCyZ0iba
 rqzm/utBuKYXzE5KAZhW3Mq0BqP2P/2SEW0aNCtj8lQ8J9zSme/7yEhz5iejzPXvpXeH
 GIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793219806; x=1793824606;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=grEDIXQ4F5YIW/ZdOFyS0BImQusuv/9clJVU2L9OHI8=;
 b=lteiTn/FbVOf8LdTDH4DDs7Q7OQUxRlew0yxm4U4XsChaHgDQedW7uPnHgEef4rVWn
 CNQMZXc/4+YfEt/fzL3vQtrwpLfSRQAbyTH2ZarRKdeeH0Q0Ixc3TGv46zsUBHVorw7L
 GKR7ym0KT2FiZ9ubY1DuGd4lPLoRq4eWKGBhImj/T+FCTvwkEHTNLzRXAW9FnaLpaPoo
 UCi9RRbdHsLtEuYUYPvQsTm7t29THJd1iwWrfNKp2w6FtjyklNSarC+UB2mXYFOzIW01
 p/56lbjy7G26aoSaLBpV8j1EmKQ9jKWCDg+1Ty9dWrwUS1qkQIVww6FrukzK6ehGpWaw
 Wo0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBywDQ5qIcFm+tUovkHi/uQWb/kw4v5BXjTARxu9ELkr1qPMh1m5EPoMD52JkX2w/InexwONrx9IOHBh@nongnu.org
X-Gm-Message-State: AFq9FYIJggRmoRRAspXzkJxZ9o6Cs/uZxBCk0okVYegXtZ3BLCgsumhN
 DjRy10ooggk4Lwgx5zhgT4Y/DgZvhCOqECC82dIdANGhUfBoOPeSjVR9H1PcwI9Ken1zMkLAtz4
 EhwpYN2fJOTnPbDkWiBnGMfSk68NCsconfBFYlKB08zRTjNNIaxvau/xpXw==
X-Gm-Gg: AYBFou2A9G/5ptb687dKQlOUpUSefqto6sKN1Y4Q4lhRc2Bdjr4E+JRByuZ8tPxsgTC
 PdNmRgLv2x7Z6bMXyMNkA6K5HDoiKTqxkx+O3S9Cs398VWgxZtNrVogpqC5pDRlEVXOaDbwsdFk
 um/Z3BBFcvqeGKf7iNZ0OipfNlYdNJz4SQSmz2YJqYIo0XBsY1wRvmxo934tyCWmlkqDaJVhMci
 P7a2/WLplSSySsLUUs6AuyAIr3SHAMUa8ls/3JAHQ5CfVu3x/wrZOQEMTpOWv33VSOULORaBFNx
 rhlKz9vtAC0A6wHG1jRkt22jPZezISEcuuQvhsejiLWBgPH9oQcOwhXeQkZkNrfXNpALeQBfotl
 gvIDagM87zUu0HlbVexXLH6AOiT6cEA4z+qJviZCMxNPHTnQAoINwfO3vWP/NffaXa/9wKHu7nZ
 tIf4qgrTbBkmQRGFYGIBmLKMkC2DS3RU6jjDpNdMOgpd4=
X-Received: by 2002:a05:7301:4701:b0:359:8492:20ff with SMTP id
 5a478bee46e88-36a20393e95mr4037460eec.12.1793219806244; 
 Wed, 28 Oct 2026 13:36:46 -0700 (PDT)
X-Received: by 2002:a05:7301:4701:b0:359:8492:20ff with SMTP id
 5a478bee46e88-36a20393e95mr4037427eec.12.1793219805600; 
 Wed, 28 Oct 2026 13:36:45 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a239338e2sm10520712eec.18.2026.10.28.13.36.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 13:36:45 -0700 (PDT)
Message-ID: <efc20a14-3d7f-4a07-ac18-418176dce90d@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 12:36:44 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] tests/guest-debug: Allow placing the binary within
 system QEMU args
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
 <20261028192538.31600-4-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261028192538.31600-4-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lILx0zVsd2z9B6aEG2uOPaAk5iyhiDMC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfX1tkMe3dhN9BF
 8copp0iQiXnuuzCOpEYzsIo5FbmptQ9qXusDTe0vGjKh8bxwqUzpAY1SE8jgNWIugwmgwKE67uU
 7sx1p3NbuSkzRMZ/lo9DMBF3bu1QabU=
X-Authority-Analysis: v=2.4 cv=V+joQuni c=1 sm=1 tr=0 ts=6ae25cdf cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Nyd8YNKHd-aJ2aKkoSgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: lILx0zVsd2z9B6aEG2uOPaAk5iyhiDMC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfX50xfuQFESY9S
 tX96kyxG45gDBKk13OrtWOVuc+wYiAOZknC+YP9fdiXb3KfY/wJbbcYI6jmKqeUjErNVmFnHS+8
 /drxS8wpP6OYWq486yyiK2FBA3Z9Yvazj+YfRHHkUgwgc5w6CcZoAHpv/bEiDce9LmRxFGQlxWC
 r1ahiAzP4MLRNVF2GjqUDu4vauJTuQiuKphmFuBLP4CY9ArmGO7NK3J4e/kgi1CBMGkly4Thr1r
 O0Sgc5TdkZnO55i0J7NnS63HwL3TUG9kFT17Itsp+09XE7mfFKHuujtp0/4nZFyKDX4qdWgJBwc
 CDZcYKZO6cXUbZWNijoo+M4hAoP+w9guRD8V4Z3Rtz7GtVLyheRl2TOgkIZCqO2109VOgxnh5eb
 TTs5Bhm9oDzdsv/O2CFGo2YgIOyB4Z1vDP0HOEhp+kwkOByy9dxCvZ56mp1T6I5LgJTyXTPK56r
 Ctc4kef9RpJenQ0ic4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280082
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

On 10/28/2026 11:25 AM, Philippe Mathieu-Daudé wrote:
> In system mode the binary is appended to the QEMU arguments, which
> must end with an option taking it, such as -kernel. Machines without
> -kernel, like 'none', load it with the generic loader device, where
> the path is part of an option value.
> 
> Replace @BINARY@ in the arguments by the binary path if present,
> otherwise keep appending it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  tests/guest-debug/run-test.py | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
> index 9fdf05b55d31..e6911300e8d0 100755
> --- a/tests/guest-debug/run-test.py
> +++ b/tests/guest-debug/run-test.py
> @@ -87,9 +87,14 @@ def format_cmd(cmd):
>  
>      if "system" in args.qemu:
>          # for system mode we assume qargs has set-up for binary if
> -        # indeed we have set one.
> +        # indeed we have set one, either ending with an option taking
> +        # it (e.g. -kernel) or using the @BINARY@ placeholder.
>          if args.binary:
> -            qemu_cmd.append(args.binary)
> +            if any("@BINARY@" in arg for arg in qemu_cmd):
> +                qemu_cmd = [arg.replace("@BINARY@", args.binary)
> +                            for arg in qemu_cmd]
> +            else:
> +                qemu_cmd.append(args.binary)
>          if not args.no_suspend:
>              qemu_cmd.append("-S")
>          qemu_cmd.extend(["-gdb", f"unix:path={socket_name},server=on"])

A bit implicit, but good for me.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

