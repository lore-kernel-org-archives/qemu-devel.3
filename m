Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17409C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwJSY-0005SV-Sz; Tue, 18 Aug 2026 09:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwJSW-0005SJ-UO
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:02:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwJSU-0003T5-CF
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:02:28 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IBgFIa1196469
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 13:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tmFnaeabtACHoDFjqzcal9LftBrVpTlf876zuCaK9KE=; b=migWPyr5q0z3PaeO
 fdHkretgh3gMb3IFpHN1pIt1v9fS4OPG/IOTloOrnpwfBhh3ViZ9IYd7U71lfGy9
 o080f8HUYugYe0XagIWb27xplHxPaP8SnGhD0w6wZJrwsTfZA5psloSZ70/PnpMf
 AhIhKgozJC16B8h+nOpepND56HE5gR5HTOJyOk+6KlIrtyBI9Zi5pe07eldjHlO0
 3GpVHynGGJHqWWgRiP1+3ye8IuCfQnSEsS0XLpg5mogTaRZpAe+1tIXkNfnSIdZf
 CbxjRSKYytZTv+4GRyVXi671JL2D00tseLO89OAvcfEHmG6x9XZx3eSJ+wN6JYjJ
 ysC/iQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4prn09cp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 13:02:23 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-737f1f1e0e5so318109137.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 06:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787058142; x=1787662942; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tmFnaeabtACHoDFjqzcal9LftBrVpTlf876zuCaK9KE=;
 b=d58k46VHD6KciD6apa1iIltLDxyP+vWv9sKf4nuyhA1Y7qUQBx2kAex/QzLIfcmyPG
 w5nYunuRwLDfz4iry5ph8zdfvKqCcV+DtBD4lRN47awJC+8P5mg7dmWRVxbTvTFYFtJE
 IgiSYawud65elys6+5A7V1VVkm077JoRuOjqBogyt3wNQHDDxcEx4ESH+twig5JYQQBf
 7OwRAWE91cfLWXcuSzpyUSauUtufS/wpn2L+sJqRUlIxEevUQw7Z5mpXNjsEKEbXobQ8
 pOToB/M1ltnvZboWJhVQqhtqL3bih9NL8zlOyE3z0Bg7rPX9PIhXBNX/OnhszfNx1apq
 ETAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787058142; x=1787662942;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tmFnaeabtACHoDFjqzcal9LftBrVpTlf876zuCaK9KE=;
 b=TI40q9ohF5QW2daQEd5m1CKC9/RjtdULVkAePmOWIlgOs6jLjmIfILxNjKk34Y3zoR
 z/esPv0Yg7qCvTPQ3Vymed2nxZMjYbFactSG/dxqeK362TxZbUZlqm5PzVsE0DXlQq2O
 f6w5Fp49CemCcjjOblRzvpgSFsmCYbw27/nx3xhi/Qi2eIK5/KaueJonYH8IbNNIQ3NJ
 vXuEoeTLhM28hKYrwlyIZRF17OJI8yeWxPHZPibHdJ04IfiYy9j5ApCVAqx9VVp0F9jF
 /mtiXhlt2Ync9Y9g9EB2ELMBJbYnFjL8FvkljlnTFHtGZWNMq6hO3O+h1EoGI2BPzhGZ
 0xow==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqq+QHMaJ9eta03uMmxn5eaWIvv2kR6I7S139q5jrE4udNMppyBjZHE5brSMeyZ7CCvDaB9RUt9QFdX@nongnu.org
X-Gm-Message-State: AOJu0Yy+x7MfPqH7gLY5uhNtJnmuK0DxpRvn3jpx4JrHof6Z7ZDA32y2
 dXL5yujWWGLfak5DmdhS8Xkqw+F/5PTJRKixrAmGGLixqxDByDUywrdj/JBPAZKNVYrc8vOroHa
 GyyOQ+tVEu63AoLO5lRvr1j/XamMYBVn+fgoSLEy1ba0sYzZ2NNX2usANCA==
X-Gm-Gg: AR+sD1395QTG0S02tcmtSqf0UEtHHKvBu+7TUCjdDqZvgcP/HWnD985G4gK1ncEytP9
 VYCNIWrSolccz0exhnN+WeWO7Qt/Afv1jUtqDTMsH96AY+15b7rR3MUKFjiZ+Hbi/N+W6N666fh
 0VGZrTmwVZpTF3ZnIqXw+6GvEVQNr00COcbaMUyvvX5KEH9NnCwrUTX1/8QS6gEUGE0I9cYGm2y
 0f7rdpG5yzJ2sZJKJUznJlfpY13lrh+VnUcRa6uYKsUtMFeap0WQF70TM9J2kg/IkU59Manvp39
 OJRU1Xdmq0Qt+zzxnDC1BPQlFijOXfKpR5imypvRC4y9AG3L7z9uvjF8mTz96bzvhsFIeFkcVW6
 cqlNtCUffQrvXyNok0XgthDE9GM3CtXx6COw=
X-Received: by 2002:a05:6102:41ab:b0:760:418c:8a9f with SMTP id
 ada2fe7eead31-76f2d5816f5mr5333859137.13.1787058141814; 
 Tue, 18 Aug 2026 06:02:21 -0700 (PDT)
X-Received: by 2002:a05:6102:41ab:b0:760:418c:8a9f with SMTP id
 ada2fe7eead31-76f2d5816f5mr5333831137.13.1787058141205; 
 Tue, 18 Aug 2026 06:02:21 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d078523sm131711575e9.6.2026.08.18.06.02.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 06:02:20 -0700 (PDT)
Message-ID: <36e99f39-b769-44c1-b6b5-87b6d26b3d23@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 15:02:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/block/pflash_cfi01: Always set romd mode when clearing
 wcycle and cmd
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
References: <20260818115742.2268257-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260818115742.2268257-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA5NiBTYWx0ZWRfXzjtPhbJ0jIa7
 AUXlFr3e6aY+BKSDIy3jtgTN8OQPJsthFwdE/r7g+NR5pKjFtEM7MmcGKNl3BdW/kWkvDvei/8u
 oSi7D92uSUeougtTfaLRlwS808rCSxg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA5NiBTYWx0ZWRfXzGu3F/1yIJkC
 6AbzNhse8m+VysLJO6jl3sks1pzt8vkmUKacHn12Dnnqee9KKiTB9GzMsZBYfDta3WnwxTvXe4E
 49GomONuLkg6TCgdzOqUy9Q9DF9U95t2A9HGZKOchem7nZ3Zfd7tA10j6Sx+gIVceWALjG8q/1y
 hgIAHe/0b+3UUybe90rJ86x4oMy8Ur5SjD4Vs9dDpgwLACIwJ9QkJs0gYWWU1G8stUGLUL/ZCRA
 4LTNHiY56xCv/EvdTmh/zOpENdccTp3XirEByC3pw+NyeKUJhlYsMSk2/tmDe15s3znJfFrfJGR
 15fqbE6CheZvt1vbTc0+m3kYQ+igMHhQFBq7MhR5XQym/v7O98CgfFzWxrS/5kO6Ki+yx74ck/s
 8JkxCGCjY+dd4Sea9ht3l975zyl+tS8OE8x262F/UomptzbZE1LczACmHbYQ5ued8OHqFUUycCG
 9wfTjXHIp+m0UMyH0ZA==
X-Proofpoint-ORIG-GUID: AaIYLpNvZ_jfteB1BwwCQdZyQrvn_5Wr
X-Authority-Analysis: v=2.4 cv=HNrz0Itv c=1 sm=1 tr=0 ts=6a8457df cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: AaIYLpNvZ_jfteB1BwwCQdZyQrvn_5Wr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180096
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

On 18/8/26 13:57, Peter Maydell wrote:
> The pflash_cfi01 code has an invariant that the MemoryRegion is in
> ROMD mode if and only if wcycle == 0 && cmd == 0.  We rely on this
> for setting ROMD mode on an inbound migration.
> 
> There is one corner case where the code clears wcycle and cmd without
> also setting ROMD mode on the MR: in the "should never happen" code
> path in pflash_read().  As the comment notes, that code really is
> unreachable (unless an inbound migration feeds us a bogus pfl->cmd
> value), so this isn't a problem in practice.  But it does make the
> code a little trickier to analyse.
> 
> Pull out a function which does the "clear wcycle and cmd and set mode
> to ROMD", and use it in the three places that need to do this.  This
> makes it clearer that we are preserving our invariant, and tidies up
> the loose end noted in the commit message of 60d010f66f2ad7
> ("hw/block/pflash_cfi01: Restore ROMD mode after migration").
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/block/pflash_cfi01.c | 31 +++++++++++++++----------------
>   1 file changed, 15 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

