Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2C8CC6B16
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGepK-0006FO-Ut; Tue, 13 Oct 2026 11:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGepJ-0006Ci-C4
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:54:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGepH-0006UU-KL
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:54:05 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DE3wK11492054
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 15:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 givbYnEQQ6o0JPMY8SUlWAsFZdR17a/IK585pg5tHjg=; b=BG9Q3Dw3EQE1JeuY
 UPTWaluPGWhTTRWmC1/c8UaPiQtN/7xSpEndjI1IVaQDsIbM7pl2+8wSeAsB2A4z
 rQgTlfEW9rfbx1ljs1UY6dX8LXBKPSyKAxDHOuA5V/oT00GBRCyRqMscRh84nVdf
 +as0KWqg/0XQIHCk7lbtHaTEE8G/Ea+4uS4i2ENedF2k3Htp2iEakCE6ekaiUWPX
 YVjyo+ByIkT32Le+M3RjGkebF/2IAdDwMbV4IqIf8Jbfu9fRAexGFf2C2Gp2F45J
 4Npey1S3PnfZcga8QH//HiRLhtWETGzh+4f0U2EsSZhJy6wgX0A8koQs+sbRnAPD
 MNFUUw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9daqtvfb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 15:54:01 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91792488228so75643336d6.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 08:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791906840; x=1792511640; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=givbYnEQQ6o0JPMY8SUlWAsFZdR17a/IK585pg5tHjg=;
 b=VLVCCEUKOluEBN+F2qbNDai5Yifa9IZr+JBFbxZuLluzVME5N9MqvHSFFfrLw/90q7
 uohQ2BIL4fMBs3mkhXej5T97UOVlz3ji/3oACnlwx6SI13fmHMmC4KrhCOAUj5xfYcH2
 Qb5P/peEqAjpqyN/IVHG8UiQt92rKkvgXMymix+pA8+QvW1jhcr/Cnd2wElzCz6faLwo
 xnch6hoTgBm21TxRI+Ipw4C3OhZJTjptvfwRVhefBAaQ1NcFKPhmVTBtICNl9JuM6t+n
 DXOSBnT9dRUrJAvwjou/6+PvZibD7neSuuZBKOIkcnFMrUmV1zUdbKEtFLrl9iAbSs8R
 2DWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791906840; x=1792511640;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=givbYnEQQ6o0JPMY8SUlWAsFZdR17a/IK585pg5tHjg=;
 b=E1RjK0170qD2rBvDyQHDZVhUsxPWgOnAUPkK2pR3IsNUN0fL/BTXHsa5bS8aTY7B/c
 MyI9qy48BpFfOq6j0y+yDxmorDr0KuVKdb2qLESk+jo3qommJfQQ/O4A4C8G0kWaGLQ4
 spQHQQFegMrd3Tuac+0yjRPfVS/AAlBI6uw0/+baH6AqXtleTvm7PF99H6WWe4Wf5gZ4
 NSaOSCCcIi40Hn7zy9y15OCes7aaEzFVlIAkF+DQtiEk+GQcutNb2vqyll2ov57Kx1CU
 nuplANAFVtKGv4h2QbuhzW6v3q708i4i+qjr+BiCTeqxGcglG+VizaLE9FIUHwF7nkHp
 RFww==
X-Forwarded-Encrypted: i=1;
 AKwUvBzbC8l38L8up5A8D0TvBPzyba1dIGlmpRoTk2C3kTFe/y5fMU6lWC6bagAzc3G3BHjUQXjkmxV4kUsu@nongnu.org
X-Gm-Message-State: AFq9FYLrcSvOH9h4VW+KdQSRQe+uPy0e7Xlar20xVo3dbueVLAjDaE+I
 856lpDnpsPU8HG7emdJ3q1mc3nbwoKw6GTD62GBVXB54F/mnxzkiduv5gUdVXXfhCLvfv8FRqTZ
 mDVTtZKjVtHCnmCWLH3w3NtMSFZdeXOpnLdAFxzucc6iWKsbOIzu5zf6iOQ==
X-Gm-Gg: AYBFou2WpshHA75NFVAh18SR4UnmqJIDkfB4bmbFaNdMZa/csd/SwkUsNG01QlM3Y6m
 GlwL+n8ScWlPxnTAzEIJtvJUb/7ZKfaIR3Dsmy8ZSkmV5xDPGN1Sjr7aktgtWmqnTtnwmd+sRhp
 4/3KJVWQWkZI5nP1m6QYnIut+vjjuBN2tOOFbDJbAII51vVNebSPqxW/4zlBSJNxLcn0S65m6y6
 +QkCTgQ1CHoImcMCa5UCGVug9z4pJJ6UGF6FIgzFOFdmjToW/Yh09ijTQX0/WEuSdWx/5s2XcMV
 vIV97No0951IDEfq/4FUqGpDEXEFbNdM7K1Y2GxHyORvdul+rAKAJNIupJByq7//8SkssqsnCRO
 f5skYm8Ny/jXLm7k1CxIoIKUeewMHWXgSqw==
X-Received: by 2002:a05:620a:4689:b0:93c:70da:e45e with SMTP id
 af79cd13be357-93ebd223c74mr2225558085a.36.1791906840277; 
 Tue, 13 Oct 2026 08:54:00 -0700 (PDT)
X-Received: by 2002:a05:620a:4689:b0:93c:70da:e45e with SMTP id
 af79cd13be357-93ebd223c74mr2225555085a.36.1791906839816; 
 Tue, 13 Oct 2026 08:53:59 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf1358asm375432785e9.4.2026.10.13.08.53.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 08:53:59 -0700 (PDT)
Message-ID: <84ae2610-83fe-4947-bf7d-6df246349ae5@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 17:53:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/coroutine: Reduce default idle pool max size
Content-Language: en-US
To: Wesley Hershberger <wesley.hershberger@canonical.com>,
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 hector.cao@canonical.com, alex.ramirez@canonical.com
References: <20261013-set-default-pool-size-v1-1-7be19402af6c@canonical.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261013-set-default-pool-size-v1-1-7be19402af6c@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: VOd3RrQy-edzRUdQHY3tKVcI5AKUqqUI
X-Authority-Analysis: v=2.4 cv=FZuiV5+6 c=1 sm=1 tr=0 ts=6ace5419 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=danhDmx_AAAA:8 a=DfNHnWVPAAAA:8 a=ESHcrJg4XHRjUGyFnAEA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2MyBTYWx0ZWRfX3zvKYGKnGXZ3
 le59kmj5XWCWnX8h9IS5QFG887r7lwFe5RfgzC+D8834XNnb14KiGK4zFhFqN5ojJQ50qBmm/Cc
 5T/wX1f5LtziO23nfA9WF8In/5TcjQQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2MyBTYWx0ZWRfX66jikEWMYS1D
 TumwNznUP2AmtrRfwkSaQczUqSjmfq2haSWgiLe0fcoK+h2UBPXCJ1OZXvkX3GeA+69GotC//5I
 HRaNfefhDdso4aBC3H7OHpI4RBFP9uA1uQtXTpjHYf0u2v9VnGnCLDQJqVRle0rRXn45Wdbu5/e
 oSgs0QfOqBgUqKYBuLKdRfSQSwfvDznp4s0KtSVY4WlBtlpai7Txd240DXAUZgaYIqaFD9P4h7/
 ufKmZr1LzJB7LXhYyUaLK2w/wvHApYiwMDloO5J8pxLWGVmQV+/gVHyIvhzNIaKVog8V9ONKiPa
 5AW5eMK7KvRtZRGA9aVpVzA5jsR/7n/8+i1q8pHSIjqwhQbafFaqw3kHxeMzwHrYx5QpzT5b3yi
 3ub2ECl4cesCU7iHTiqYURCdJyn8vfxS7Ybu4euyzZaH8x8wvs2J+HLIpJ/IgqC1TTISFWfWTdV
 H4s4lzzLnthBe4CDXSw==
X-Proofpoint-ORIG-GUID: VOd3RrQy-edzRUdQHY3tKVcI5AKUqqUI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130063
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

Hi,

On 13/10/26 16:38, Wesley Hershberger wrote:
> If g_file_get_contents fails (AppArmor or other LSM), use a more
> conservative default max size for the idle coroutine pool; this avoids
> any possibility of the failure described in 86a637e48104 unless the host
> kernel is configured with a low vm.max_map_count.
> 
> This change is motivated by a discussion of backport risk:
> https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2168803/comments/8
> 
> Fixes: 86a637e48104 ("coroutine: cap per-thread local pool size")
> Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
> ---
>   util/qemu-coroutine.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
> index d17135f585a..d8853e3b227 100644
> --- a/util/qemu-coroutine.c
> +++ b/util/qemu-coroutine.c
> @@ -391,7 +391,11 @@ static unsigned int get_global_pool_hard_max_size(void)
>       }

I think you want here

           else { your Linux code }

>   #endif
>   
> -    return UINT_MAX;
> +    /*
> +     * Read from /proc might fail due to LSM; use (DEFAULT_MAX_MAP_COUNT - 5000)

I've heard of AppArmor, not LSM acronym.

> +     * for distributions that don't change the kernel default
> +     */

because this ladder is used on BSD, Windows, ...

Also since modifying this area it would be nice to add some
self-describing #define for this fixed amount for non-coroutine
users magic number.

> +    return (60530) / 2;
>   }
>   
>   static void __attribute__((constructor)) qemu_coroutine_init(void)
> 
> ---
> base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
> change-id: 20261013-set-default-pool-size-8b27c0fca8e3
> 
> Best regards,


