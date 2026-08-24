Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E01C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 06:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNmv-0004rH-SY; Mon, 24 Aug 2026 02:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyNmt-0004qm-FK
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 02:04:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyNmq-0005vu-Kv
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 02:04:03 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O5RMDG1574481
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 06:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Pwlf4GvdjN1EWQEQlDiy0bNjLgPXY9sg9hStWXQKkPc=; b=Dwpd4pxRDVG/ll8g
 91QqDhL2FEZdMNAfnwSeeaK7tfWoZBOf1oMqA4j4N+peVyaNVjQRQrfNWMkLS+vV
 xDCaYtbEXLEmUNiQHoHqBo7BuMY0ApUSipuRz01Gh3Q4gVoj1Yn7q3gzUx6xaZRK
 S+HxGou5/a736aJ4zTQ13XcTWyQcRjJO5THnpFQY9zlHajQoxWlXo42BnKGskZdo
 wdOXVuaCMxYJNygI6qMQ2XtFf7FAodHwkfsIfWCZQ2HHKfZlpF39K4lMIO7EMam6
 z2M/smTnnlGmG30e/21KmFByA33eSaJovMhkVfXwgz1fpeE4D2CeOJorfTGBIlyn
 /vaIxg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g7456wnxb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 06:03:57 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-77cc8fbe356so53744137.3
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 23:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787551437; x=1788156237; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pwlf4GvdjN1EWQEQlDiy0bNjLgPXY9sg9hStWXQKkPc=;
 b=juKfRgYqOsalACLXtPfOy5UCLfRd3VCBzS0THQw4+JIOscf2P3ZE13i3YJo0Q4Emhs
 NU3CNlpgKtglkPzAkIyevMKkzdHWIq6UWnAXkPAL5wS22n2BHsstt/bXKh5/EsabqRZf
 7L7dlGpaoQ97fK2XE6G1/JhXBnlQm4r7dhYTN8iVLe2wCSF27mXA51JQ8VdqVsIiZat1
 Zgz2nryIwFoGhUGQBp4JUDXTwNXWP1B68YSpEln4n6FuJHV42rprMBvqfdzJiI2rYvVO
 Czc7EHETDNHT0eCUCcVWt9gK5q+USkhzvQS3ctaePlyGVC9mZqsCI9f8vKZ4na98UnCM
 Ribw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787551437; x=1788156237;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pwlf4GvdjN1EWQEQlDiy0bNjLgPXY9sg9hStWXQKkPc=;
 b=im4y2+a3NQYrwvvcQp65fR0X9iXbaThlj7NxYN5GbgKwAlO2ytgScKEActk1k9NNbV
 67Fz6LwLpJr9L9rJuvA8UrE2KYWO2mDfspPgfXS7Auk7BfMt3eazlm16fj0rqyvn3N03
 AS9sa7yRuLR07xyF5woYBI7PN5MYhTDfemFfh+Qdc1P7AGR4cxSOVF5F+mCYfYYFE3iE
 8yY99ifZknhMRVhzBrxdzvp5euJLisfvHX1sq9AwM0axjrWmrHIkCEBC6rnNHqXqzJkn
 D0miv8MyKLP73LZSBhxNs00gcFW8rd57ExxgYj0/DDkjLT8K4DgGume+p6J4WT/YR9oG
 pG7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqi7AMY6jIwq2o+aSw+woqaBF8QKXgXL3IfllrPWyoIW0CoQwWSWM7VeBa5CvZEIONl9VouKL319v7d@nongnu.org
X-Gm-Message-State: AFuF++k1lKItTOXjHn7hn6MPVS1ZEK7JBdK9//j2dcMqehUJu5yrdWuq
 UWXvL0e78BmphgwFJ4u1ZdYSZ7s2CniE00CugvOns21GahETn85omZBWhoSqAen8RGYXAa2P3bJ
 JiMTsRRCMqBEvIMoz6NQXyNTUAq/ZOaVKJoREGcj9jbFhoYrhi/9jUnZ8hw==
X-Gm-Gg: AR+sD12eGihdSLWM7MZfJOz9RGrp6bPm/k00V+zDgScK/DT3gfJoR4Fsk5fPJvEhvC+
 by8Oo95BUznzyktiJNOqL3sbR5YHjAuLZotWHgf2U+ikCqlQMdBCkhjBk1pjc5CU2uzQGUOvKVC
 5PfuVDLfWNVeE//u7X1co0PTY4+KUY0NCtSbNpmqSB9p3iAVJ3FNl7A06nf785zNlCKrx0vn+fF
 rg8KoARMKuP2BSAqpIYwsoKU74zESzgLPjQgjgWvqHLH/Lc15q+fKu/0IUCMExbzz6vG9FePDYf
 5ZNPyzkhDcBQl/FrmkNRV75GTnlDcCkkbW/dLNJedilrMJkXsy6Ozqx7waR+EQrSRizzCptw+BW
 RkNutCIqa9b9BHrIhGIi42uUsNs17HMQhC/vFxFFYW0TdQPfhcg==
X-Received: by 2002:a05:6102:442a:b0:779:78ae:9a94 with SMTP id
 ada2fe7eead31-77bd0ab7564mr4440969137.2.1787551436918; 
 Sun, 23 Aug 2026 23:03:56 -0700 (PDT)
X-Received: by 2002:a05:6102:442a:b0:779:78ae:9a94 with SMTP id
 ada2fe7eead31-77bd0ab7564mr4440959137.2.1787551436494; 
 Sun, 23 Aug 2026 23:03:56 -0700 (PDT)
Received: from [10.254.188.74] (241.170.88.92.rev.sfr.net. [92.88.170.241])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e1d741asm6512681a12.27.2026.08.23.23.03.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Aug 2026 23:03:55 -0700 (PDT)
Message-ID: <9327fe97-1a04-4542-aa3c-2caafdceac9b@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 08:03:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] tests/functional: Avoid unnecessary removal of
 scratch files
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260824055642.41098-1-joel@jms.id.au>
 <20260824055642.41098-4-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260824055642.41098-4-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA1MSBTYWx0ZWRfX5oa0mPbDvhmq
 JtTsXtQv7y/SNWFLEZ8egb3gR2pf4ZTjL+CYhdfkzxYpKORWgR5+aQeGSrYzXtiJIcO75MDLF5T
 5HoUa9xEIqltek6yUQufoU8qozPbk2o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA1MSBTYWx0ZWRfX1gIlov/lFcSo
 v6fjz65PVSos3rRTJM78KQJwVPf5E5QyCgog2STxVNSxVwrFGnMI+NII9W1yOQumJPXubesh0NC
 swL3SPNCyyHTWTpqGXIx6hfEzNpk/f9rOy1PSo2Vor8fOnDaUXVRBYcqqM+E9HoylVj3sNm2koY
 Trq+7CVqlRhFVGqmGxCo5ApJMTnyQAi9uRpvHXM9fc1UblyjTky3zgofiim7a6fR/qVKU+KCXqo
 Q1yMdPBWFHQQBJG9MuyZERTYdAoDh2xHyMWHAkFEtnyIiKIMrbA3kEcDxPjknqBTSGIKT2tYD2f
 g735wx/A/uo4U9DAiXG66dmk6GSFuBbW/QDvXEUJ8fc9+j0EX62cjUXHwm/ed73EI7mOeOoGusV
 V5ge7xrMoeLkQeYoNszclReyt0qhozWa9G+rE/Zsf54BTRIaumtZXxVIxSXkZwyfPDpXcBJL58f
 YU+sNol1x1jV27Q/RmA==
X-Authority-Analysis: v=2.4 cv=RtL16imK c=1 sm=1 tr=0 ts=6a8bdecd cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=+Tg70iCNDwYGP/1Xem9bLg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=_42GJx7MB-dApGGGqoEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: e-mVJMQjPxk-aL26b2KYtscDKePdTrUf
X-Proofpoint-GUID: e-mVJMQjPxk-aL26b2KYtscDKePdTrUf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240051
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

On 24/8/26 07:56, Joel Stanley wrote:
> Files written by uncompress() and archive_extract() are placed in a
> temporary directory that is cleaned up when the test exits, making
> os.remove() redundant. Drop it and the unused os import.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   tests/functional/arm/test_bpim2u.py       | 11 -----------
>   tests/functional/arm/test_orangepi.py     |  9 ---------
>   tests/functional/riscv64/test_sifive_u.py |  4 ----
>   3 files changed, 24 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

