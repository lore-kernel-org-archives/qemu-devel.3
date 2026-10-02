Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0126BCA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCeb4-00017z-VA; Fri, 02 Oct 2026 10:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCeb1-00017G-VL
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:50:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCeaz-0004GU-3I
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:50:47 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692Du8hW858429
 for <qemu-devel@nongnu.org>; Fri, 2 Oct 2026 14:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6CT+55PBDK5dwkwCTxhO/f97Qd0xR83gew2znxSpzxE=; b=Ec+pMUOCcMYszObL
 TPIQnehPGJnnF9H0rbm3auNJTmMvimwyf7xPGjiTfYh4V2OTf4MCYPW0pAH74U7c
 0V5BYBTqegAS99XBQh1+xUCKXsQgKw85tF0fT0SQGfC2XC0TmuxZXVsqH6nwPRzO
 MDca5oIyOHnjx6gZXp777GE+Sq5cjdGMoXqSWONaBdZx6Sej87279qCV4zuFAqep
 7+js5DOBy5EAlBNhsacKJBgfNffslg492w8a2anaf6CCpi6R5gZMeT3JOCivfCDa
 vMpd+qvzW3gNhws+O7j7KxBpq1ADaqfRlUqQFDCJ0divyVH4OllQD0dXvbyRzN0V
 q5n78A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2dxdg7cw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 14:50:42 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93909014c85so1518518085a.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 07:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790952642; x=1791557442; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6CT+55PBDK5dwkwCTxhO/f97Qd0xR83gew2znxSpzxE=;
 b=Co4R8whwsO4N0Q6adzGGb7T0tPqv901k4AuJKUgeNC6VWfs+Hx4MQmoC/hL3wU+GD1
 FMndYbYEk64is7CYBSJyNtPexMVJoaBDv1zlNu2r4njzjrI5/SQappwStxJUWDluty5n
 +tdVxZn4unNFSrYlu4X6yjFxsQ/lQlN88KBljp+fEFEADkR98Kq6KC0xY/TNbRiX94PS
 fR3XrM7HvEP2FEeM07r0dXSmai42rCOq0vGSa8LHreHrgWyPR8bYrj5Zw3Zp6+TZuNsZ
 1Rzr9AyKZwZJ1CdeckCzsd1WMc04wDzyU0UBOPey5iOSbNIXS68qaPnG6u8/Z6VxUc1f
 WwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790952642; x=1791557442;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6CT+55PBDK5dwkwCTxhO/f97Qd0xR83gew2znxSpzxE=;
 b=p6q5A8+5KwdCbkRohWc461p3B/J6kw6biHIMPbH+F3M087Oiz3/u2TE0/4NM7faO8w
 MrIVKAZ58+ayYpHxqXu24dXQXfW2bSy37ocz3FyHp0lHBkGmJ5cPn1TdzKVh3vijMMGE
 tDzTNsLaGGUMHw3LDh9auD7YTiVIfIVA159AqxLELFOvf7MXO/WVtlJIiEFckc0oL7t6
 14SFmq7U1jsS0acfGs7+Aa3SW01OsPtak1HsY9I/J1aXktG4Tm3Dfi74Bpqpwr47gD1n
 39J3FQ6HNdHTSOn6ZYRt7PkWUxpE0Ga6+YEV8OyvkdMIXRSGjXTm69oXMwT/0mKhPzvz
 iMiQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZSUvLQffuzKBsZgEp7zCT61rX/k2X4OV5KrKdQoCUUqjWW0x/CR2j9AysOo+6YiP9Jv5EIXnQPvUb@nongnu.org
X-Gm-Message-State: AFuF++kNE/elgSLQIuaFFr5lPSZPu44Cojmte2VUdbwRG5XgkbBemXE9
 /5OVMeKJQfhz8c8vrZr0ijlFxzBbZskbTm2MdxM6Ji9djnlNP8qIAuG9HVXs8d2l87/IK8CB1V0
 +Ty8m1rUXqqs9qzEw1QGljMuYm/vW7/OytI+gYI7WIgD4BNnLKdvQp6/1Ew==
X-Gm-Gg: AYBFou2k5VmFWhGSf0A0a2PFlvlB0ROp3zo/226bG+vocQzFwhVedEH/AIHKqmgZI9/
 M0Jl6J//k2N4bp4LnVaJduQDtMRuFFtXF4zOPZR96/vNSrSWjJ+7xFP8fWe6H13tk7bmH6E7ayf
 zcRw1Y8qI4LaPhUAoisgJYJZU1cqYWviJjkmzxa8kbWFs4//vSHBljquxn9oZ/y1hwKwa0ui2Fn
 tFI+6gGdZfT+Qxh0tFba1kMUCFaGnZGSzipGAk8MidXAvZduEObg8eiHOXGZU8uKOKDkNYy5kmu
 p/D/UWRJx+3zN+HDYXdueJt4PZ75guWYQ5TCjzH/bJYWISJ3smNutWFvd2Lc1FTcMUjFKzFMKfU
 wiTC0X1pztIkHYIKrSYwd5A==
X-Received: by 2002:a05:620a:1723:b0:93c:b6db:8c with SMTP id
 af79cd13be357-93cda7e7639mr550685985a.0.1790952641287; 
 Fri, 02 Oct 2026 07:50:41 -0700 (PDT)
X-Received: by 2002:a05:620a:1723:b0:93c:b6db:8c with SMTP id
 af79cd13be357-93cda7e7639mr550679185a.0.1790952640772; 
 Fri, 02 Oct 2026 07:50:40 -0700 (PDT)
Received: from [10.111.137.66] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b38104f89sm6751669f8f.30.2026.10.02.07.50.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 07:50:39 -0700 (PDT)
Message-ID: <2becf449-a3aa-47b0-8329-04c8c5f64229@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 16:50:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 09/11] targets: Move interrupt handlers to
 do_interrupt()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260902152044.31291-1-philmd@oss.qualcomm.com>
 <20260902152044.31291-10-philmd@oss.qualcomm.com>
 <afa4d292-7292-4feb-8559-fb9186a4163a@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <afa4d292-7292-4feb-8559-fb9186a4163a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA1OSBTYWx0ZWRfXz+GqLgoHVop3
 fpCO20M1w4ncCCzfnCxSm0t2Bm4Ysfw7r/HOLy4zSmQqJm1l5JDEwLx0/9spdlAAQz+L6+jGY4H
 kMmXwvXl1nbmpZu0psbgYRilnToDA1c=
X-Authority-Analysis: v=2.4 cv=Ko/YSmWN c=1 sm=1 tr=0 ts=6abfc4c2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=fO3KdxxCRahBnyrE_4YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: ro-KEWj4xsQemlhyySCej50VPKHnikbr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA1OSBTYWx0ZWRfX57aQaRm9pBLj
 M8u29PHUwpkzEWBBdJf3HmhSPqMiawYkGRmit8HXmu+MTaNi7SAWSXqmqM2qtufomoiyIsaTQGl
 V/9J/dwqo2nzbX0VG99Q0sD1oKgYBKGURdmYwoA9PyF1nlYqzJlcaXZ+pn/McR4vq5Sb6SvTsfl
 V+qbF4QbKMmSYK4E8EHNH/4UQMDAAbMei/skxak860Yj3jhTv/Tke3/rq7B17bSAOgJkNqvvwzy
 zZiOMKebPiITqzEWdTQ5O/u3Hvbj27bMKU6tUveIM0Gxv33YZiWNsi0h3oyyrwswFueigRDplDj
 AdLBR+6TQNrHNEqxYZJVcm/1oiRXQ2AutklPfkR7S3j3VQqh+9O7FMTmDCZyNJO/PvOY4O3kWIY
 jlIVnJ9Jr+Q8ktM759v9SWp4dFm1EADPrCjezgNU5RaqUVLkHd5eRebMFcw9SaKl+zEsX0dpNaW
 CoxmiHEiLeOQxxgpeog==
X-Proofpoint-GUID: ro-KEWj4xsQemlhyySCej50VPKHnikbr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020059
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

On 2026-09-13 6:00, Richard Henderson wrote:
> On 9/2/26 05:20, Philippe Mathieu-Daudé wrote:
>> LoongArch, M68K, MicroBlaze, and OpenRISC interrupt handlers
>> don't require external BQL protection, so move them from
>> do_interrupt_locked() to do_interrupt().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   target/loongarch/tcg/tcg_cpu.c | 2 +-
>>   target/m68k/cpu.c              | 2 +-
>>   target/microblaze/cpu.c        | 2 +-
>>   target/or1k/cpu.c              | 2 +-
>>   4 files changed, 4 insertions(+), 4 deletions(-)
> 
> How did you determine that these do not require locking?
> E.g. why does alpha require locking when loongarch does not?
I couldn't find explicit BQL use in these, but now I see why this
poor audit isn't good enough. Better to convert all targets to use
explicit BQL locking (next patch), then remove unnecessary locking
one target at a time, with good justification in commit description.

