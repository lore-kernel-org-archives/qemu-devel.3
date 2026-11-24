Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC73E606A682
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Fogc7Iox;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C6maTA85
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVpfF-0000vQ-C3; Tue, 24 Nov 2026 07:30:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVpfD-0000ui-V4
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 07:30:23 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVpfA-0006W4-LX
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 07:30:23 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOAuLfk3541827
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 12:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3JkkZF7anUqLiXVgBGhzdx7HV4SfDqtjl/EyAew39As=; b=Fogc7Iox+kaeUKNT
 QMlIxWmXtTEfWgnIBtXkCrO/qsSDNbRqJbr6v7RKvZZQtgFr3PdqpOd9B4fQGILF
 GTGzY7SFxoJEPOlCaL7VIotFlE95Z3SvNs3iOJN2IVrvhis5cwDyp1dLYfTBSWtn
 Z01zQ1qZLcSJkLHLHeT2PENrfeU3hHJdYU549A9fEMwilUK0elCi5bHWJBiZWZZs
 5cHRlNXdsE9iuZ9OZLLHYlGL50Ym6S+MsbZQ9/j+cp4Ofnxa5euRAszELHldVPwr
 UdiwDJyQ0vyijThOrtENmkcVVeinm0NC/OZy4H37vEhXJJ3nfYB248iOq6cqxBTv
 wQlpdw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j54rh9kwd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 12:30:18 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-946038e22f5so882989985a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 04:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795523418; x=1796128218; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3JkkZF7anUqLiXVgBGhzdx7HV4SfDqtjl/EyAew39As=;
 b=C6maTA85oCbkzFAtiKQlNPsUGYiwaVmE+vqia14zfEcL84DACx9Q8LfcydT/NE3B//
 jJxHZSwvtfFu10zKmqoHCLWmHzI/v1dDITxZ4NYZWod2z1JqNzcfMZybFDXNa0324gQo
 ExlPjO/AJuTTVI3L31aU/bAzQJpRnlJ21stfWVXPsAsjtJR8MR+sZ1lx3f3qYtz3rM1/
 J6tmGZAfjevTPQzquFWJoucoM2fHjxNcLILoz7XsAvoS189Vkg8YvMU7Gw8d3hffeq1p
 j+Wi38rf5ySNWpID2rg7/eGzREqJwPCs7yarK0k+PoUsDu7UOI9aik3SuAJ14xuF4U7A
 WWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795523418; x=1796128218;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3JkkZF7anUqLiXVgBGhzdx7HV4SfDqtjl/EyAew39As=;
 b=lwOmS6G47m/olIKw757JKGmiUICxJxlTO1L9SuFD4UwceQu+chEpNE4cg4Loi7Cxie
 Obt3DIrwzom2dewVWBNtF+Bl0qznMJ9R0sLMwfTqa2KcnLZZj+eJ8v5skHTfc8Iq1OhL
 qjjlJGDX8zA15+dvpN0His7q6CXEcYgDsfDErW/MKjuFK/69A6QmNNisKAMQ7oyRam+B
 g/r6iuGkahiFOyJWLLydApByPw0sDGthJE9AMrHJOKEzvVep/YIJRg/kFyWVQvdFxS79
 kKdznpEKb2YSWKv7B5LuQHH3Pg0x9mMoAfj4H6ISAMro1fqT2o8oNNQG/2MgdPnh2zY3
 UWGA==
X-Gm-Message-State: APuU4Z/YiXXso9FgeW92zk4WK7Bg2xtaakjvB7U5yW7p8hx294rsr8tL
 0c9EL+gUWnevxO25cUhUIpmZd2x2AYTjqopsNLaxRXJjGbM9P0DSf4gMVLEhrSlLXvnVcugPiV8
 HzYOlwouv3Qso49YUAruw1ROU8qwcJK98gi1FtuDDIGiR3fCJZqHyHfHrYQ==
X-Gm-Gg: AZFdTZf5TFEqiH3S1iBUv6DtnhDEQjN+5Tw8KEk49B0qWKNxbVTymrqaUpGyBDLeUtP
 2cBQhk8xN30dLhQKUpo03nICgdGe7KhEaI6mjbubi3lgZsDSPQWDzdPlS2bpER+I7H3sK91HjGn
 AFi8k8eKGWPvpWjbT5kzzRD1GKe83szesDqDBEmVxwXCShSZZ56wuro7du0K24h5ql18w/LBYHq
 ilWo0S0PxcHh2D95EWXXIkuRn4K87E9kaY77x78LU7AHGF9GTA1d6dhsZdjZy3VjZzx/tmhoIcp
 qkV62O4aPpsvMfwtv0hyAvmdkb51Ny+7IBmCzITyfk/OluIhB6hvbp4b+YkAvNSI3Z70lbEFx/o
 72miTRuPhLopwKN/13x0IFrF5jSCmpZWIu4OAmMZypVkUjMMikUm3HfrFmnp7Y4IgsaMTP9a+VX
 WEAAdFiCM=
X-Received: by 2002:a05:620a:2687:b0:93f:34c9:9248 with SMTP id
 af79cd13be357-949ba9b6de4mr2667760185a.22.1795523417569; 
 Tue, 24 Nov 2026 04:30:17 -0800 (PST)
X-Received: by 2002:a05:620a:2687:b0:93f:34c9:9248 with SMTP id
 af79cd13be357-949ba9b6de4mr2667720585a.22.1795523415054; 
 Tue, 24 Nov 2026 04:30:15 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88442693sm380762725e9.1.2026.11.24.04.30.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 04:30:14 -0800 (PST)
Message-ID: <9d555e9b-7707-4762-bb43-cc1a0966fd56@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 13:30:13 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2 9/9] hw/sd/sdhci: Report Auto CMD12 response
 timeout in error status
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-stable@nongnu.org
References: <20261123225349.54981-1-philmd@oss.qualcomm.com>
 <20261123225349.54981-10-philmd@oss.qualcomm.com>
 <CAFEAcA-DrMWdQEQuXa0UArTjob+N4Y6Bwq_BwQaQdkZVotG8Ww@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA-DrMWdQEQuXa0UArTjob+N4Y6Bwq_BwQaQdkZVotG8Ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BKkmP1QG c=1 sm=1 tr=0 ts=6b05835a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8
 a=Egf4CTR3nH1D_DSsu3MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0OCBTYWx0ZWRfX79yuJTo4QVbv
 6JStI9meDOIIGaOhflq0bvMwZ+w8iSG+Dbhh2o7lLVuPT+OcZM0za6BASEXlPDOe5rqm3Y1Ng/M
 aDbjbFJKo9X9PXx7QpDqhHUiOH9BxEs=
X-Proofpoint-GUID: MIi2np1GSu1Xa8flwVQtdOFO_CvFXUrC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0OCBTYWx0ZWRfXwN7OxZv4SttU
 FNcZlFfQ78J0LiiZEQvW6onMxT1yu7mL1GgE9Qr+lGt/sZomWujJ/FmWo7SF2LgZpoCN/QsW8d5
 KPXii3KRMA4049/hH/4CQgnGNtNQTPWBINk8sgPuMzrTkiXEWc2AyapckCDEPm4fgJ5TbfCq9Bj
 LnQ5b6Nc39gODIlwpALiegzCzz5dSj/ZX0iWVidL2KI8tTnNB8UXzjPZ71bDX9ZXIDtLn7m2w81
 NtIHWSCMDLCSFNTn7i79a1NRE7aN6WWkPncd8X/IqEMf1g/8HkvYoIUcM0o03rOcV9FfW7FZfZ/
 rjIZa8up4kxjhDkbYYN2E0GZ7ZgaFlhGMd6hRrcHIwDHnbweUW2/Ic09lgKzAuY/d9cYTmGybwK
 r33huDHrozQCewyaiX1OLL76aHTvcS/v9xvAF64erZCnds2DuKBXYa2LcP/oyiIrVVjqZDfvKIY
 AbfD42UEQ6ZsPmqqvQg==
X-Proofpoint-ORIG-GUID: MIi2np1GSu1Xa8flwVQtdOFO_CvFXUrC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
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

On 24/11/26 13:21, Peter Maydell wrote:
> On Mon, 23 Nov 2026 at 22:56, Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> Auto CMD12 copied an uninitialised stack buffer into the upper
>> Response register when the card did not respond.
> 
> NB that this is harmless since we compile with
> -ftrivial-auto-var-init=zero, but explicitly zeroing it
> is clearer.
> 
>> Zero the buffer. On timeout, set the Auto CMD12 Timeout Error status
>> bit and, if enabled, the Auto CMD12 Error interrupt.
> 
> Fixes: Coverity CID 1619307
> 
> (Coverity was complaining that this is the one place where we
> call sdbus_do_command() and don't check its return value.)
> 
>> Cc: qemu-stable@nongnu.org
>> Fixes: d7dfca0807a0 ("hw/sdhci: introduce standard SD host controller")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   hw/sd/sdhci-internal.h |  1 +
>>   hw/sd/sdhci.c          | 18 ++++++++++++++----
>>   2 files changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
>> index 2116995dccaf..9bc6f302b62e 100644
>> --- a/hw/sd/sdhci-internal.h
>> +++ b/hw/sd/sdhci-internal.h
>> @@ -174,6 +174,7 @@ FIELD(SDHC_TIMEOUTCON, COUNTER,        0, 4);
>>   #define SDHC_EISEN_CMDTIMEOUT          0x0001
>>   #define SDHC_EISEN_BLKGAP              0x0004
>>   #define SDHC_EISEN_CMDIDX              0x0008
>> +#define SDHC_EISEN_CMD12ERR            0x0100
>>   #define SDHC_EISEN_ADMAERR             0x0200
>>
>>   /* R/W Normal Interrupt Signal Enable Register 0x0 */
>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>> index bd74c60f7287..8c81b90f1a73 100644
>> --- a/hw/sd/sdhci.c
>> +++ b/hw/sd/sdhci.c
>> @@ -414,14 +414,24 @@ static void sdhci_end_transfer(SDHCIState *s)
>>       /* Automatically send CMD12 to stop transfer if AutoCMD12 enabled */
>>       if ((s->trnmod & SDHC_TRNS_ACMD12) != 0) {
>>           SDRequest request;
>> -        uint8_t response[16];
>> +        uint8_t response[16] = { };
>> +        size_t rlen;
>>
>>           request.cmd = 0x0C;
>>           request.arg = 0;
>>           trace_sdhci_end_transfer(request.cmd, request.arg);
>> -        sdbus_do_command(&s->sdbus, &request, response, sizeof(response));
>> -        /* Auto CMD12 response goes to the upper Response register */
> 
> Should we keep this comment? It seems like it goes with the setting
> of s->rspreg[3].

Kept it in v2:
https://lore.kernel.org/qemu-devel/20261124073406.87537-2-philmd@oss.qualcomm.com/

> 
>> -        s->rspreg[3] = ldl_be_p(response);
>> +        rlen = sdbus_do_command(&s->sdbus, &request, response,
>> +                                sizeof(response));
>> +        if (rlen == 4) {
>> +            s->rspreg[3] = ldl_be_p(response);
>> +        } else {
>> +            trace_sdhci_error("timeout waiting for Auto CMD12 response");
>> +            s->acmd12errsts |= R_SDHC_ACMD12ERRSTS_TIMEOUT_ERR_MASK;
>> +            if (s->errintstsen & SDHC_EISEN_CMD12ERR) {
>> +                s->errintsts |= SDHC_EIS_CMD12ERR;
>> +                s->norintsts |= SDHC_NIS_ERR;
>> +            }
>> +        }
>>       }
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Thanks!


