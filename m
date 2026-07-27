Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5EDC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 06:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woEjB-00012A-U4; Mon, 27 Jul 2026 02:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woEj7-0000r6-AF
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 02:22:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woEj5-0007fr-KM
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 02:22:12 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66R1gAKR2382054
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 06:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sUtEzWtXJQlAwdOjECPID8kjSkP3jBnkmNI81rEjE0o=; b=AYYIyszgVt7gZzvf
 6wp2i0i+E0EZCYQafUHTwhedV2M4vlXxpBFc2LkiV+UfJ+TwcSJIxGeA+bBQvll6
 J8Gq9PLJtQFdrjheVgl6nuIPwcWOHTwkKgjUOjKDH05Gm2OhmHvGGuc6ao1KuwV7
 mmMlG5ZoBksfds1F2pExCDuNApiBjEU68cRtB0k6InmFv4g9RLQMRS+ZLireKl5T
 KdktsNU38Dx8hQYzdAUQxtatwDolgAfEwuZUf2ksBYcp4wfShbHmrteb6wSxVL0T
 qUiTFBkhfaBzQ7GOkix5PWvjo7Lrv6lWIEiPeBJ5DHnEZuhW2KUV+T2OxD54WBKJ
 cKRlog==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmn7vcr10-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 06:22:08 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-522de3c645dso50582361cf.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 23:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785133328; x=1785738128; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sUtEzWtXJQlAwdOjECPID8kjSkP3jBnkmNI81rEjE0o=;
 b=XZSOvjH9nA6xri7EzuMYFelCpSdsANQ0olREk7aHc+gGoshg3dmlQuyG0vOeEiTj4n
 z8j2QnbLHDsPduTT/U7fo8k0cGwZLPAE16jyv0dJON2l/YhOPEcPRNC/WFDnUVOhrda5
 76vTfYVQJP29Wlc0alCXi0H+Z7XOC0h+/C8m6UJbXqMsCqpcT91ek7KkhXVLx5/DTyC2
 8+zNFXGtDXQx81f0kc/7V8EQPnopFWTKNp7heo8BsTIlvR/NN7a9l37B0613dso0txdF
 CIlVCg0DaUob6yIfjMs8BP4GsKPVNt1bE1enAEFYenqCbUAJNuyxnF39TUlWwf9Hb2Kw
 2/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785133328; x=1785738128;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sUtEzWtXJQlAwdOjECPID8kjSkP3jBnkmNI81rEjE0o=;
 b=N4CmTfnFwhq32AjZh8TBugtYJ22mcVzU7lvaKZ1KpVlAwvZilpm/M8zKL4c1lefn4p
 5p9lQ+TUHDL6ZbyHJJVZBDE2GDJxDNLKrkTBoyvCLkfnLWrWd+PByp65zowkFmjIJ+6c
 z//0p1pdWJ6HkhmUzpFGRl5U8ExNG5ld6veHBC90CKIVlp8mnedZen5wYnsA3DOWd1rm
 ZgSRt/TEipzY2WXDn8gG5bSXLWbeUU0s4TJZ88GVJwdwjGG1xpI9asW9in0RTv9n3pFV
 mHhIm/fFDs9y3f2sLmFpJJkepMl8bcsBzaNwBaJZ3Is7r/fn/HcCpYVLEHGJSMtm8the
 b3vg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/3mmtbPv1xQDS/eAtELBu56ThabRN6XO3dxZT7fw81MxK+q6g5Vx/t2hjjPS32eE/MjbCaIInAWXd@nongnu.org
X-Gm-Message-State: AOJu0Yy59skb5DMykbQB6mZLz7Jr6To9eH4MIOfItM+MyiW3uL+/DoJ1
 NviXHJC+LXPDyCaeWX4igF1euQJDpVW7QNRI9nGmP7Ks9KvYW5poJLlAZBDAF6qukHKoGrXC8ZL
 5rXSEdubGgTI4z88J78mkCa76Efu349tdAJdODSPBGfTpnT0HBzrCGNy/Mw==
X-Gm-Gg: AR+sD10M/cGRpOM2hIyCfgvZWFQGEvSrx26As0rB7GcdHY3e5krVVgL1mjOxp2OmGKP
 emsJxSF6BalGpY3wbPpKZoRW+RaaIDfSeYjJw007NBgrQG6mrlrrU7+gJzD8VRPVi3dJFFOrZlT
 CgRS4dOGHQsyp5FMGJ9o9BxN3YEec9blinC9swF7vdglFX0mSqr5bwmROG5K3gduD/0Vi3rBVIw
 ZQV1ISzDMdfR0Wv2pyr/JPtmGQqGiDXbntflVGl1slQHqbqDp/LJeKnd18FuMISrtzyHnAlUIm7
 eeN0ydJpC79UJnET1XQAYkkMs6nqhlnq4RksDRHG5D5EDwxS2eIWgUV/63BmFouHmes/AfO3D81
 BhW99YLl9zmQi9jpI833S/mU+U1JDtIU3XyzPYx0KdBM/sY7a4sU=
X-Received: by 2002:a05:622a:64a:b0:51a:8bc9:2915 with SMTP id
 d75a77b69052e-529a8381d19mr76073881cf.8.1785133328040; 
 Sun, 26 Jul 2026 23:22:08 -0700 (PDT)
X-Received: by 2002:a05:622a:64a:b0:51a:8bc9:2915 with SMTP id
 d75a77b69052e-529a8381d19mr76073751cf.8.1785133327618; 
 Sun, 26 Jul 2026 23:22:07 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c52fc0sm46137384f8f.23.2026.07.26.23.22.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jul 2026 23:22:07 -0700 (PDT)
Message-ID: <c31eb382-d50d-422f-af4f-543eccb37003@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 08:22:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/sparc: set reg window data structures currently
 after vmstate load
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, peter.maydell@linaro.org,
 atar4qemu@gmail.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org
References: <20260725123411.993099-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260725123411.993099-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GKk41ONK c=1 sm=1 tr=0 ts=6a66f910 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=69wJf7TsAAAA:8 a=pcZqCyVeAAAA:8 a=EUspDBNiAAAA:8 a=W7HDxenLHfcYYEYlDDAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=SGy6VSG0Ue1xmPAwIFl9:22
X-Proofpoint-GUID: 8JqJQjsEOY9c4wylUgGEQ0M8uBekWuzR
X-Proofpoint-ORIG-GUID: 8JqJQjsEOY9c4wylUgGEQ0M8uBekWuzR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA2MSBTYWx0ZWRfX35Kc/4q/tXOP
 hmHTMFCoFqi13ez6pGZiUDXneW5Vz3WcN1YVc0PL9A8fFJH6GX7VSOZVcllUF1sooMw/Qi8MmZ0
 mgcPnv3K9pz4v+EfoG1N5IiFZYhA/Gg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA2MSBTYWx0ZWRfX/Ta5A2eA4pAh
 rw435lYH55ltKJ/GYXZvz9z4Ht0rZEt8Rn6mff0JUHD65Fx9m50rtkYg6N9YqAvHqiVP8iycOep
 N4Ho6WO4qnunH6pMm3mX1BcHPy7Lb7M2q59GcaOYQsxnCzm8oj4ZY2sxfDGW6AvBiU9aqieNprU
 vT4A/c1vSBNLxuf4zMI31YfIuAG7ADLItwE5hu3BIoCxIlVHe2mEaoNQlFzohy6thxxn4gWnhjZ
 GyAiIffj/DJQgevLfUQ06UOORyHJAt39km32tb6KVKsRGxdemVozHuXyLSNxAA1iweiqE794KIc
 RfGpsFjjR2raPzT7zS+7AsckZ0ShQgJoH89/uNhkBXi8VYKvz9sDw1tgfJ5+oC98Y9UeqCC8H8X
 IjcGhS0xjZg69szOWzGu/QjEQRETWQzJKmHVndLz0T+2ZjJ2dwMTeEj8vgb/BBKgysuWU53F/5V
 j/IvIBkxmrMefx03icg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270061
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

On 25/7/26 14:33, Mark Cave-Ayland wrote:
> In the SPARC CPU state, env->regwptr points into the env->regbase
> array at wherever the architectural CWP (current window pointer) says
> we are in the register windows.  We don't migrate this directly,
> since it's a host pointer, so we must ensure it is set up again
> after migration load.
> 
> We also have to deal with a special case when CWP is (nwindows - 1).
> In this case, while running we keep the "in" register data for this
> window in a temporary location at the end of the regbase[] array, so
> that generated code doesn't have to special case this "wrap around"
> case.  In cpu_pre_save() we call cpu_set_cwp() to force a copy of the
> wrapped data from its temporary location into the architectural
> location in window 0's "out" registers.  We then migrate only
> (nwindows * 16) entries in the regbase[] array.  So on the
> destination we need to copy the "in" register data back to its
> temporary location again.
> 
> For 32-bit SPARC we get this right, because the CWP is in the PSR.
> The get_psr() function does:
>       env->cwp = 0;
>       cpu_put_psr_raw(env, val);
> which causes cpu_put_psr_raw() to call cpu_set_cwp() in a way that
> sets up both regwptr and the wrapped-register data.
> 
> However, for 64-bit SPARC the CWP is not in the PSR, and
> cpu_put_psr_raw() will not call cpu_set_cwp().  This leaves the guest
> register state in a corrupted state, and the guest will likely crash
> on the destination if it didn't happen to be executing with CWP == 0.
> 
> Fix this by adding a custom vmstate_cwp VMStateInfo with corresponding
> get_cwp() and put_cwp() helpers which does the same for the 64-bit
> case.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   target/sparc/machine.c | 40 +++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 39 insertions(+), 1 deletion(-)


> @@ -286,7 +317,14 @@ const VMStateDescription vmstate_sparc_cpu = {
>           VMSTATE_CPU_TIMER(env.hstick, SPARCCPU),
>           /* On SPARC32 env.psrpil and env.cwp are migrated as part of the PSR */
>           VMSTATE_UINT32(env.psrpil, SPARCCPU),
> -        VMSTATE_UINT32(env.cwp, SPARCCPU),
> +        {
> +            .name = "env.cwp",
> +            .version_id = 0,
> +            .size = sizeof(uint32_t),
> +            .info = &vmstate_cwp,
> +            .flags = VMS_SINGLE,
> +            .offset = 0,
> +        },
>   #endif
>           VMSTATE_END_OF_LIST()
>       },

No need to bump SPARC_VMSTATE_VER.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


