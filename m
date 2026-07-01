Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B051FC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weoKY-00015U-4c; Wed, 01 Jul 2026 02:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weoKW-000159-6d
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 02:21:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weoKS-0007vX-Hl
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 02:21:51 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6615lIHu138701
 for <qemu-devel@nongnu.org>; Wed, 1 Jul 2026 06:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5SEIZQ8nUJuZ6/Fa/D/YFkemtW1QOC5ubtTdeU2SWGY=; b=klXPflzH5TWJkc5G
 X9vcc3D1ZXmVeEcKpoP9JBd3APuE4SsO+7ZsvQRI4tXhsCQjitv6KIUw0D8USUij
 61VDIaVHAsxLTJ04viHaJYVG+YZeqImdufeufD4nhWlOxicaP9WY+i/aWwW79LbL
 of6IutFOsHoOCn6K6/5W1XB6WjrTFmYYiytqi5y+SNOyh3mTKFEDCBUU4m6U/P5/
 pnWIpEMdgPSBWl8NqDDh4tmSvtwYoz7UuJBaSHyXyhfSvaLlLhzfrAw2eTWpiB3M
 3xHoptM2Vd9x5h/TNVWGi/qQJ2oKaIniGw0xLhPwhZF7nnCMmS/9CEYuPwpNiSZG
 ACVOOQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4kgw2bpt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 06:21:46 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e55721a8cso34336285a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 23:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782886905; x=1783491705; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5SEIZQ8nUJuZ6/Fa/D/YFkemtW1QOC5ubtTdeU2SWGY=;
 b=KM0YdxNCXvU6Y0uaB3lsoixLH9kdcdDW5rQQB5SCZ3e/twVQtoH8j+ttJ7R4ULV9vx
 QBZzJLwWSnjPEECi6bZY4tZioDTb+lE/i0UQERtujaIz/zsvfAw52NXsiPJcQ5VKUOpi
 haZzV3guZE55dEX3xxZ84N13NoIrXHvxvOHX4dAYDbbmJfcsE7/iSQddqRGRrGgBVOuC
 ZmDGaJ9oCUCj87orgwP7NFr6nTJPGxCPcaMz+4pWHpvWsY2SguywAcOkftgAR5o6s7Ro
 BLhNMGOkIw+T6MPtH/MY+FVI6CAgq+NI2QJVYRqIWKD5b7DkMBLOoQ8raeZE+p0TH1d1
 Su2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782886905; x=1783491705;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5SEIZQ8nUJuZ6/Fa/D/YFkemtW1QOC5ubtTdeU2SWGY=;
 b=IwcRRfHCA5cLxtfJYSKOl2v85zcb2eQKe1xEu8y5o3khMnY1yffvnQXBLpyW/WKJ5L
 1Qc3rJZRTu9unLZ7eGC3GRe26GQhFl6jfePhB7s3zS2oNkfdBdLZrcAZm3FJX3Z+B8RA
 pa4UsDMEhRcZtZ0bQ98bJ5PWtSlD+P1xSJXi8kJMl5tM0BKdSE6Bmj7fgZjI3tP6EtIb
 b2riEOZ9XMznZFdA7oY6Hpd4PKw3scCsTYmaJx/YtFDC4LOA/IBzb5oECPT77YyfC3fA
 YSGG5E4CQgHyDJIYqstiPc9G4xMHkD6GgdkaS36HZPdkqKosYYvzP/VuxKYvBTQ6EKht
 6W0A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8lsracdU62LLXoTuqSfWCSg0pQ+8Teqiq3P9SZC7cWLyOw5vCulIlyEQFGXzjHDXM7MHHzjRHmaZz5@nongnu.org
X-Gm-Message-State: AOJu0Yy0TeLt9rsJSXVmL16ORuwqyMxpBgSZ8G+54WnFYw2akDNU5NwR
 FxbLjH1/z/jH0lufXxllqn7i6qcDhc9xxWuw/MQoitd307XpghaZ9GOodxATdWvX44NkJ9nReXK
 +nySLpml0s12UR8wDbDVZvxg947SGBI5jH6mNhEU92+RJ3OwWrRCZ9dDRlA==
X-Gm-Gg: AfdE7clPX0Y+0vtfaThhSPvJUscCKE8NSclkTTT3Jz34Le9Q658ThebLWqbTJjF3n6c
 h1RASLmIaRnMX320yQvf6Er7KFk4Mg3Da2u65GgbIJSVVv9ETnobhjT2A1H499TPu2574V5Qc2B
 JtQKnznbZDZIEcHxCxxrVOYp+Rt3MSh8lUtLuDaxiPRjb7vvX33qAD2e+7fkfKnzzFH5BLQdo88
 sTxlo/sk6ewWvTpfzeo0QjaOTN+ev416FtXs+WV5NflrA1+IY7RABtzUcgL5pxYv2I8L+PLKInC
 ZhzK7UYzVlNld6wRpMhF6ruzlQtOcsMap/jSisnGCOUby1sVan+njaEWzgsoDlYremxSgV/gMFp
 CGjIgguRpGEr4ftXUFl/i3qIgB6hMT98AWEIQNgL3Q655rYSYuRbBjuDLkw4V4w==
X-Received: by 2002:a05:620a:6018:b0:921:dae6:a701 with SMTP id
 af79cd13be357-92e784fa0e2mr40181685a.54.1782886905393; 
 Tue, 30 Jun 2026 23:21:45 -0700 (PDT)
X-Received: by 2002:a05:620a:6018:b0:921:dae6:a701 with SMTP id
 af79cd13be357-92e784fa0e2mr40179985a.54.1782886905015; 
 Tue, 30 Jun 2026 23:21:45 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47567a6f0ddsm13633869f8f.37.2026.06.30.23.21.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 23:21:44 -0700 (PDT)
Message-ID: <809cd495-7459-45d0-bcbd-f8af88516726@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 08:21:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] hw/display/ati: fix HOST_DATA accumulator overflow
 and bpp==0 crashes
Content-Language: en-US
To: Junjie Cao <junjie.cao@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Chad Jablonski <chad@jablonski.xyz>, 
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260519023937.439077-1-junjie.cao@intel.com>
 <20260701032836.2076507-1-junjie.cao@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260701032836.2076507-1-junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Co2PtH4D c=1 sm=1 tr=0 ts=6a44b1fa cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=57R0qBCtAAAA:8 a=mM618wOG2A8x6RhA-R4A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=mR_gFduoMj4eUoa7Ntlv:22
X-Proofpoint-ORIG-GUID: ALrCsJNi-Uo6800zBTgv0ufZjjrm1WPk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA2MyBTYWx0ZWRfX9ihJUtd9wCrD
 b3yXIKLpO96GFLZyMk+HtIO9y35Ag7AHD3I8EEpOYm2KoWrp8WpH+zbp0Xwx1lI4iZdch5uOADE
 AtQpgb+RgXpiK+gBLhpCDOjj7XUM0mA=
X-Proofpoint-GUID: ALrCsJNi-Uo6800zBTgv0ufZjjrm1WPk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA2MyBTYWx0ZWRfX+F+ZghqEAVRd
 tIyIrpvnbztPbP+0+J4RFNl6yJ9cNz1+CCiUJwOVsfWTvvdM6vyG8lhUvKCs59XXOnl/biiFXi9
 WnVuZjhd2YsdRM62di6pr1cCi46pxnA5vBMdjU++k99Hz6LZCZYCNSx6dNH2ubmK1rN1u957zTy
 0jj888kKxYzRhkYZ7J9pLaPglYc+9oq0HkOz2Ahrcp884gS55TdbDIm+tXOIRc7v2J+8rW/8tkr
 bt4zuH+6CiVb+avX79OAVM3sdmH7/b4QoQoZIz7f0FVrtmupAXdfoX4MQBFezwQc/smmBjACnoA
 48xPjiR/VOmLlTXzn+MXm4uWGthHaJlXf985wQhzXLWRcAwvKJvw5XlH8N//EXOMdSmwdB9Q3Ho
 443YtkV64Y/2D0UnWdeNYlzcTPCbMBBJ44UoDWPl/sIiVAQ+kf6tWe0KfNPPdj5gQEJEpgYTxt+
 BYK2lFWsiwkzNcA2woA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010063
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

Hi Junjie,

On 1/7/26 05:28, Junjie Cao wrote:
> Hi Philippe,
> 
> Ping on this v2 series.  It has been ~6 weeks without pickup.

I'm sorry, I suppose I missed it during my work email change.

Queued!

> Both patches have:
> 
>    Reviewed-by: Chad Jablonski <chad@jablonski.xyz>
> 
> These fix two guest-triggerable crashes in the ATI VGA host-data blit
> path (heap-buffer-overflow via accumulator index overflow, and SIGFPE
> from division by zero when bpp is 0).
> 
> Still applies cleanly to current master.
> 
> Thanks,
> Junjie
> 


