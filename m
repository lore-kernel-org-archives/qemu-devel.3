Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D11C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgg63-00078W-3c; Mon, 06 Jul 2026 05:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgg5z-00077s-EF
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 05:58:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgg5w-0008Ov-3F
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 05:58:33 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66694QpI4180268
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 09:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D1C/Z14o8fPaDLjf11XtsMihWSVAsObX24pFd2DwJtg=; b=gf4YYMNSXGV1/GAI
 azoUR+3FKVY1J8kNjebJkDpcFqao3ROAS2MWMbopcY1AADkIDn8WCdjrmpB/NUpN
 JE3B4PojuP0GWBJiVrRXxdARhCQEjiF8A7WNqbar7gu4bsPO7j0w5ZktzCDCtF+R
 j0ZXcdo5w39bPYFqi2h5jiPQ4Q1PStX8shoL6f8+QJvXmNW61V0yH5nfQ8B3Nm+g
 QBtprevfBdr3lPd/7QfTABl5pAuxGTYSuBRBPP3UOj37r2fEnAiZaDTfbIyV9D2n
 7N0eNMOAO9zXaaA3V/FL2nkcIpLXXOSCqclUUQwIHxXOt05W9ORKLs60sjXM3s2d
 LoxKyg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txengvb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 09:58:30 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so287862585a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 02:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783331909; x=1783936709; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=D1C/Z14o8fPaDLjf11XtsMihWSVAsObX24pFd2DwJtg=;
 b=M7sCtHLiSAfeu+exyNA3Mm9WPfByAkWErcMZQeLOvlEp7z2i8AW2v3BgHz4lrBUVCI
 efWujFyiuUrXE+zln9ka9mR0nlXXbuVRh09lea71xmaqPfwLEbEzQVbqcqvPFKpYYbDc
 uvlEZ/RFl/O4+XRNvzbpw8Z4DaJjGQ7f/CyJXXBYHa+7SsvDusqxl25z3Hl8ngmXJVb8
 lJ/kgenpeMB/B32L8sv2Gb2Rv/M/nZOn6iw/xbqBbJT26rk2RndDfE/MQpK799QSYj02
 tTOuqKFZrIfeGYOT5i5UmY1o6fRApiWGSVREdStlKGEak1SOiTTsoh+dXYDZz+Q59IFB
 q9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783331909; x=1783936709;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D1C/Z14o8fPaDLjf11XtsMihWSVAsObX24pFd2DwJtg=;
 b=ostLz5SKpH7xJ6oKGbrhOLJCHW3oDmVpooTgDypdjQXcoqhgROikOJIwsKP0dhPx80
 Z2Fm/czQAEe+yKRLcYlX9rXI8RAysdTkYocWUK+Ew5Ii2UfkTKR6H8rXLGP/ifKz2fQQ
 YK9Bfs+iIn6zwxn26CHDMSq1x/QZTbECz+GvxR1YxRWdDKmf2TbRSUW9MA7fCHYK2cOp
 2sAZYC7BCFA2PZdnU++l1EgwcQqNRRNzvGRB3L7e6nmoT92D7XkeYlpdl4wy6H7i0DCX
 3Ol/e5HlGWrRY55UN7DDkB/y7ab2q5LKC7bt10gTNbHEkqXzRA7jsdX/vuoDO6oHBl2j
 6eUg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqcwd1l9i8nlBMyYG1hew+0isOI+DQ4iUaC8H1hsnSupfE4Zw0U1hWxZhojD4wgy1J4TWuhdTEXdKx0@nongnu.org
X-Gm-Message-State: AOJu0Yy+9R6H1Wj5BctzreWxGkWVJ6xAeFQWOxqjiwNxYEcuiiHsllVA
 Ps6IkimWDsgeo59LD9HoyeRfG2ISQ8ucHyUKPiuGl34mEJwrdb7nIMp1fZMZxDMJK47OFOFF3kU
 RGaGHDEIbgJqLnuOIsWhAnGc16D3OCpvthrTDCwhiEqFKZ9iw8UMXEGWWPA==
X-Gm-Gg: AfdE7cnYEf4ggclaQQekwLI4lqoDOneHil/HwopLnT16iPF14YX6kQmYvnQohUYux3x
 FvQOqmVrqnNoFUCJYramUtwJCUxdsHPydbMYBpPI/JZhzwvGktCmCKfWBAqEVtrGskXIRNHvShA
 VWEUdyINGwkXZbG5Ok0RrOGLX8sjWu8UgU8RBq5gZB05gL5aybh2aY0GbBjcWiDzgQzu8zr6Lrb
 xLbPufH3bvxNQn+9y0mcNIHkKR3HHTrZYUKxaVv0lfdx4njkuPdlJ1ZE1Qnm3kMAqXDHWjUo5bE
 WsMcxvNxZgNBMBv9EGMJjh7v4Y6ZV3H8jYdfHRXe1ZEpQlXd5UhOgAJyNuHBkEABga74oJm6UuZ
 lhaZNOFY+J02GocR1ScupoMPol57C0HFeY4ilSB/ldh2L+nd83KYPySJER+kvGA==
X-Received: by 2002:a05:620a:27cc:b0:92e:6c15:24d2 with SMTP id
 af79cd13be357-92e9a37aaabmr1374165385a.18.1783331909333; 
 Mon, 06 Jul 2026 02:58:29 -0700 (PDT)
X-Received: by 2002:a05:620a:27cc:b0:92e:6c15:24d2 with SMTP id
 af79cd13be357-92e9a37aaabmr1374163185a.18.1783331908908; 
 Mon, 06 Jul 2026 02:58:28 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c12b629a1c7sm710412366b.30.2026.07.06.02.58.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 02:58:28 -0700 (PDT)
Message-ID: <6c097a17-efeb-4299-839c-f2ec890423d3@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 11:58:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] hw/{block,ssi}: Fix spi-nor flash dummy byte
 handling
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Hanna Reitz <hreitz@redhat.com>, Hao Wu <wuhaotsh@google.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Kane Chen <kane_chen@aspeedtech.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org
References: <20260630135729.466264-1-bin.meng@processmission.com>
 <bb4b7240-ea2c-4738-80e1-83e259f3ef4b@oss.qualcomm.com>
 <0830c96b-9fde-4b0c-89ff-f6c0bed60725@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <0830c96b-9fde-4b0c-89ff-f6c0bed60725@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEwMCBTYWx0ZWRfX+tnQqjrU6Xm2
 zIwwOqBSTv490GrfuzmaeFeGlAFSqChoYoPeYt76Dp9U3Qjlk+OMHyne8qP/YywPl+XcBnaTC7h
 C7EuItGgHj4b/TELUbmCdG9IFaftQgs=
X-Proofpoint-GUID: yUcTJLAuL6SygJbBa9IlEWNoF8yHSzPP
X-Proofpoint-ORIG-GUID: yUcTJLAuL6SygJbBa9IlEWNoF8yHSzPP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEwMCBTYWx0ZWRfX1g080zLiOvSC
 E/K4Ca5sXXlaps3SyJqZmait3HWE7UnbprS/zYYy7s0KlS4sypFWd2yQULkhiGXYhDy9v6BeAXY
 G0XdAVjlstu49g1cCjxjYVYciWDmZfQILCaLvFm4FYfxV8iJFjJ4XrSYGUo78AdacjWSnIQBb16
 TgT65TNLYHS7S659EhFF6IKhRWjeO3W0T6ykmtkpZJVgcAX9KWez9AMKNgpTaA51aLevWeX3e2i
 aGcEhoGf/roe8vMjvdSNZn2rdXSmzzbuR7Ifi5eQjI/QNUhEsBqXX7JmjVcxTwlBvzgNRHkbnHw
 l1RmGb7ZujfC2swEI5tNDIFoUbJVGcDllm3zn/3bDJ1KD5LJEcC5w20/s0+Tor8VwpCigaddBjC
 nGDNlgkQ1ZsQI0/VMgMmVoqXBIr2SvOrmTIFAeisnTMzl0zuZJ2BgDHH5797WI9w0toE5VAivnI
 /Tfod+9yriV0OZTURRQ==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a4b7c46 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EK3YEsEo063TKsytiuIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060100
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/7/26 10:40, CÃ©dric Le Goater wrote:
> On 7/6/26 10:19, Philippe Mathieu-Daudé wrote:
>> Hi Bin,
>>
>> On 30/6/26 15:57, Bin Meng wrote:
>>>
>>> This series fixes dummy-cycle accounting for SPI NOR fast-read
>>> operations across the m25p80 flash model and several SSI controller
>>> models.
>>>
>>> The root problem is that the affected code paths mixed two different
>>> units. Flash datasheets and controller registers often describe
>>> fast-read dummy phases in clock cycles, while the SSI bus interface used
>>> by these models transfers byte-sized words to the flash. As a result,
>>> some paths treated cycle counts as byte counts directly, and other paths
>>> compensated in controller-specific ways that duplicated flash command
>>> semantics.
>>
>>
>>> The final patch documents the intended ownership boundary: flash models
>>> own command semantics and dummy-byte consumption, while controller
>>> models own hardware-generated dummy phases and cycle-to-byte conversion.
>>
>> I'd blame the API. I'd feel safer having the block/ layer use bit
>> cycles, and a core layer converting bits to bytes when calling the
>> SSI layer. Maybe too late to improve. The documentation you added
>> is helpful, but I'm pretty sure we'll introduce more regressions.
>> Anyway, thanks for your work :)
>>
>>> Some background:
>>>
>>> While recently working on some device modeling, I hit this issue
>>> again. I then realized that I had sent a fix series for it more than
>>> five years ago, but it never made it upstream.
>>>
>>> This series picks up that old work, refreshes it against the current
>>> tree, and fixes several issues in the SPI controller models. The 
>>> original
>>> series is available at [1]. I have tried to verify all the SPI 
>>> controller
>>> changes by booting real-world guest software to ensure the change does
>>> not break anything.
>>>
>>> [1] https://lore.kernel.org/qemu-devel/20210114150902.11515-1- 
>>> bmeng.cn@gmail.com/
>>
>> (Could we add this as a functional test?)
> 
> Nearly all aspeed machines will test these changes when booting.

Are you saying that currently the Aspeed tests pass without this
series?


