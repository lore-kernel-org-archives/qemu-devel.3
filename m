Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1478E606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hfNZlZJr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CFck0pSK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVpeK-0000LA-DP; Tue, 24 Nov 2026 07:29:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVpeB-0000Fx-FO
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 07:29:20 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVpe9-0006Em-J6
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 07:29:19 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOAujHS601625
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 12:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kPCV5XBrpir3gcdOiHC9Kv9A4Rf3KgAr01HoXXhCDV0=; b=hfNZlZJrV/093CrC
 prmjr5min9JU1t418hNx3Lgn+vXEznD0uffXD0B0aJMFU5L8/v4kgth21cXLmjwj
 WS//ElvDkNlqsXxUP1mFkhmneFE3xoVPUIX3MMqvqHCdyhmfRq13BW1TYAGIOnM5
 jfqtwZRzsKsT3z7ixLFghlyOotMG1hdTmUQM2R2DjoJN+Gp6tgkPA3CxLdQ/a7wP
 YB+HvEFy7kMFnDwUZOoP0iUdEvoTgSLLApyvWsL8seBEwsb2ot5d+fcsH5IcB8z0
 ZN4AchaxInGspbobl++hgKTRxAz1CYwWbNvVOEYi4DwFV/BWds4KsL7hdMko8J4P
 LtSzkg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j50ky2j48-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 12:29:15 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-946038e22f5so882837885a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 04:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795523354; x=1796128154; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kPCV5XBrpir3gcdOiHC9Kv9A4Rf3KgAr01HoXXhCDV0=;
 b=CFck0pSK2HVWNyfvPNQFCFF9fd2rSaPQn2AecwFPiypiL9lPSTW2uS2EXXE+REAksT
 ZI4R/h30EBWjpYMtY+76Tn/pvbvFSDfUIX9Siahe0dBJxg+ZNMxxcf5lLz5sgQdHpyBh
 Mw9Dr9mTsdKfJ9f6BvBjN+dYXxNUd7Mv7yGGOscyPzaRtqnb7Vpe8ICL4f+t2Cn05E2u
 RoPRW0PVq9FjPwslT7kaKt2qB0hx9jMW7e5/5tI+kGfXEYzG2dWnq9i9LlSD2qhiVObe
 YbRGvs+FsHhzEsWuxwMXwyFmizkZjEum7TGj8dNi2FDqp0784gEDfrmoH4XXwPaA6qJ6
 O0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795523354; x=1796128154;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kPCV5XBrpir3gcdOiHC9Kv9A4Rf3KgAr01HoXXhCDV0=;
 b=fn1VsTOfuJTBb9oSAremxAYwErQA2eHWmAihliyXjElw0NTnAcoJXlzyTgvmsZjac8
 qLB8ijtnFtW2sT732ljneOn83aBnR6Z4c1kB2lwOVbFWHuQby9NW939RJGGOHymmqDQa
 2/+0YlePsIEfHhC7YfCVQSEDUmbeX6zGMUDdIapITaN4U0BRGc6b2UI3xLX95fY/rhQQ
 iWUbMiG3kN/jYGvSVC6tAVceaguW5LCBc3hIRLAqVC41I5LQ2u6yx2iEknoYJTzPn8Me
 IlUP13WgN4M4b7hFNkcYXT4DtxiQkFd8zkNjv/tkW2SG5rTpK5Nqyb4344K3yqcxqjmJ
 Koyg==
X-Gm-Message-State: APuU4Z9qHG3MxKiJOoR98CUo8z9kkJghL9sFnBdA21nQWnLOdsQiSNTv
 OGZz/xMWlR7YTI7CcezwLixSaB5z+wcy1FiCyrKG4hdUwqjtdKh1TIJqnkLl/akTUjHdzIeBn9X
 xSG8LYpNHhSeLlF3nTur1HtoLus07Bh5MCl+iNFI2FfgekmkV+6cuIG8ClqXNrMM1ma+1
X-Gm-Gg: AZFdTZf7tAF3T/2qpUzCPcX+SDLC3GEyhieuYRuHWHoj7TS9ZtqM5EDnTftGbaA/IKf
 D0wv+qm+HQbKiz1B+syVogwyAjjFbA1GLLV6OQ5GuDjqevniTqhLHqHzKORvbwHZ1FpFOwLxUKN
 nuqVjX9oC1az1zdISFpfkAmy/DWlaT/fTsa9P40tE8PhjS01cu/5BTQE3mjUIsuSfFMidN8u+jN
 S6icCbK8EBzQHzbsR5y485WKpNEo+vOMaRO069cb3w6MudfOfO2ACgZQrlQygSWzZQCFDxawuLJ
 W+CmaOsdgHJTG239W5mdPRPZfk+0OGiIUI9fDZ6n0Ie3hiHQlV32kiGDRWU8xRJokGYoOlTPDSK
 AVqSXXgmq3v/27j5c9HBF9pYd8rwAsoewHz9YUWK41MQ8QKO/JdpM6+Vky0TFpP6te+Y2T/VBUe
 2u2yrRoiA=
X-Received: by 2002:a05:620a:4056:b0:949:a71d:82e0 with SMTP id
 af79cd13be357-949ba9b8300mr2566928785a.13.1795523354535; 
 Tue, 24 Nov 2026 04:29:14 -0800 (PST)
X-Received: by 2002:a05:620a:4056:b0:949:a71d:82e0 with SMTP id
 af79cd13be357-949ba9b8300mr2566924685a.13.1795523354010; 
 Tue, 24 Nov 2026 04:29:14 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b205443sm29170301f8f.39.2026.11.24.04.29.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 04:29:13 -0800 (PST)
Message-ID: <e4fc7ca7-5b74-417d-b34f-892cf5cb0901@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 13:29:12 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2 1/4] hw/sd/sdhci: Report Auto CMD12 response
 timeout in error status
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Karl Mehltretter <kmehltretter@gmail.com>, qemu-stable@nongnu.org
References: <20261124073406.87537-1-philmd@oss.qualcomm.com>
 <20261124073406.87537-2-philmd@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261124073406.87537-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Y+ptIReN c=1 sm=1 tr=0 ts=6b05831b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=2bSHTTrPnHbvUA9WNPMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: GpDcvx7zVMitIubGcE54dUuAwAWiPOag
X-Proofpoint-ORIG-GUID: GpDcvx7zVMitIubGcE54dUuAwAWiPOag
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0OCBTYWx0ZWRfXyaVQbsRzP+iF
 r4IzMaGyKBKBOPXJJvdN/rVuhn1c4j4wz+4XvX2WE5QlSW/F3Tb1loR8ct+Rqo4TRTLcoavzND7
 9iuLKh3cAajXmco+KSmZjJMk4GPlF+Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0OCBTYWx0ZWRfX+pU7z0ksN0T8
 sfb1mCnpCLeuXaqoB11ueA06XmVOUOQ8hYPNrcTSQVY5zeQwTRvQtlVh7DQ/Xooi/WGQFynz8+j
 0MLE+0vNqGQxFv7Ojk6kIJna89QReQsWLsahZaQa4Hvyb7XSiHEYgQGHtX9NE0D0hLwnWxWNdBM
 2Cd6Fv0QfxfJqAmz6qoVnCzx+eeWUdObJ0wbC/wpKuIbsu2c2waAVoZ1vTBx8aMkt3WdVTf4fSV
 CZILDYmYnjIWHpM2CGDN6rT+3zN/+VJilHCRokk6Gy3orwviH4lw9G5xelBfi9M3mCytD592hY7
 prv8fT5BoZdzabENTuqr1s5bBe1qZN7CVx9VfB59SkOFw1LA9FyFPnR4qoBdHvEjZL+vLRLVqG+
 LfVZHXvbmgVFSPYEsERVmHml5W328w3PEtKK35rcKbKSQjdmHo579ozdz9gQtj0TJ8MrJKO4uQ+
 8o5YUNEqV2ik3jqCPSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240048
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24/11/26 08:34, Philippe Mathieu-DaudÃ© wrote:
> Auto CMD12 copied an uninitialised stack buffer into the upper
> Response register when the card did not respond.
> 
> Store the response only when one is returned. On timeout, set the
> Auto CMD12 Timeout Error status and, if enabled, the Auto CMD12
> Error interrupt (SD Host Controller v1.00, sections 1.11, 2.2.23).
> 
> Cc: qemu-stable@nongnu.org
> Fixes: d7dfca0807a0 ("hw/sdhci: introduce standard SD host controller")

Per 
https://lore.kernel.org/qemu-devel/CAFEAcA-DrMWdQEQuXa0UArTjob+N4Y6Bwq_BwQaQdkZVotG8Ww@mail.gmail.com/:

Fixes: Coverity CID 1619307
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   hw/sd/sdhci-internal.h |  1 +
>   hw/sd/sdhci.c          | 17 ++++++++++++++---
>   2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
> index 2116995dccaf..9bc6f302b62e 100644
> --- a/hw/sd/sdhci-internal.h
> +++ b/hw/sd/sdhci-internal.h
> @@ -174,6 +174,7 @@ FIELD(SDHC_TIMEOUTCON, COUNTER,        0, 4);
>   #define SDHC_EISEN_CMDTIMEOUT          0x0001
>   #define SDHC_EISEN_BLKGAP              0x0004
>   #define SDHC_EISEN_CMDIDX              0x0008
> +#define SDHC_EISEN_CMD12ERR            0x0100
>   #define SDHC_EISEN_ADMAERR             0x0200
>   
>   /* R/W Normal Interrupt Signal Enable Register 0x0 */
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index bd74c60f7287..1e70e1e7dd52 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -415,13 +415,24 @@ static void sdhci_end_transfer(SDHCIState *s)
>       if ((s->trnmod & SDHC_TRNS_ACMD12) != 0) {
>           SDRequest request;
>           uint8_t response[16];
> +        size_t rlen;
>   
>           request.cmd = 0x0C;
>           request.arg = 0;
>           trace_sdhci_end_transfer(request.cmd, request.arg);
> -        sdbus_do_command(&s->sdbus, &request, response, sizeof(response));
> -        /* Auto CMD12 response goes to the upper Response register */
> -        s->rspreg[3] = ldl_be_p(response);
> +        rlen = sdbus_do_command(&s->sdbus, &request, response,
> +                                sizeof(response));
> +        if (rlen == 4) {
> +            /* Auto CMD12 response goes to the upper Response register */
> +            s->rspreg[3] = ldl_be_p(response);
> +        } else {
> +            trace_sdhci_error("timeout waiting for Auto CMD12 response");
> +            s->acmd12errsts |= R_SDHC_ACMD12ERRSTS_TIMEOUT_ERR_MASK;
> +            if (s->errintstsen & SDHC_EISEN_CMD12ERR) {
> +                s->errintsts |= SDHC_EIS_CMD12ERR;
> +                s->norintsts |= SDHC_NIS_ERR;
> +            }
> +        }
>       }
>   
>       s->prnsts &= ~(SDHC_DOING_READ | SDHC_DOING_WRITE |


