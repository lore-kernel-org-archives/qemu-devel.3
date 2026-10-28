Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B73606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RxF9Y6MX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jhhS/Cwv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMAUr-0008Ua-74; Wed, 28 Oct 2026 16:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAUj-0008Sj-UF
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:43:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAUh-0004ni-Gn
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:43:36 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPjFX1580418
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kyt6K2lZP9sCD8AT4GMJSwWF4qM2WeyRv5tYs/sYS8o=; b=RxF9Y6MXnuT/FmVt
 47ojWVjcMoZhxOIPZ3zdy3SbQZ+/sCNkEmZyx7EfE7SAB4lftnewFLBjr8q2kWWA
 M1jVb5zZpWKQwOsZWjOeCq6vqtp3t/K6ILLVp7+862KKQmbAJY5toealYH6BnPZF
 VMhTFcWDmnHS2nextEC1QZrh/41057YxEgGZEonw8+EGtnnBv7jTRDOLVLYg9dmC
 YDcw5JXsV6hNbAmE0eCweDfqSEN5UXW7r5lX+1vR7R0qOPjdZfR4jvlkBZFPc5L7
 FPbCqatXHtpE/bSflFYruSIKWjrkSfW0r1OHYPJs95aMSS779F/hmhncjzRrErVX
 TiEfNw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknkp8p7k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:43:34 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36a223755e4so4451974eec.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793220213; x=1793825013; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kyt6K2lZP9sCD8AT4GMJSwWF4qM2WeyRv5tYs/sYS8o=;
 b=jhhS/Cwv+lptR7xw2HD8VwsjbxK40VYrUyTVDT55UvpNvdb3fM8iHKVGjEDUSCKo0f
 668HQ1de4by8A35DMKCUIyNIMlWUDazIW4HZg6EwmYTkomjEmVaqVBWLjY+WFehKVvrf
 Q+Z4Ta+H4rhIeTBEHyTAjo0PyDSKvcJRJlm47LCDkbSPCBDArx3Qcgjdq8e7yALmS4xK
 czdqY6W4xs0I04DbiTNoZD30nl/kr3vmKIuH0JvVhRXIuSNDoQQUtWNo179QEootPw9P
 expVd6PPuocPJ92RoJDfgLLhR+1NiGCmdATBv6I1z/JTIyv6EUS8IAo+XHY/WzFXypyn
 zbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793220213; x=1793825013;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kyt6K2lZP9sCD8AT4GMJSwWF4qM2WeyRv5tYs/sYS8o=;
 b=w4bHoqsXf2RssBz9IP8csXUfS0/AmaHwmMGKVQFhpxbBrAPdegs7e1fFZoTQxTX6hD
 Fp/PGg1788TgfUsd45EahlH8tGEenZl5vo9pNN97xk98hovafoSJMid7kCYf91kZAKqk
 zqgrDXhTh/HQfIURMqAbjTs8cmjihdIKCK52Ta6DXKUSdkyCP9DHFjFBb5V3AlmDGX23
 t+VPfOAlpWtlq7CtVVpq61BCXI+tm3AK2rjAhr97UgryWw2tkZumeve1rBUE95z/YAuF
 Lbj8zWKKYgS7pbUFTjbINbYwAoYEr9LZs9Qd825n8IlB+fGtCTdghQk7JE6ZNb/IDQIs
 f2Ow==
X-Forwarded-Encrypted: i=1;
 AKwUvByDbJ0JqGZnkFqZ6H4A2EIvTojqvOBUwcbehAWY84XirtHEFCSyv2nd8YU9Dl+6k4ZFRiMo1naWOjuZ@nongnu.org
X-Gm-Message-State: AFq9FYIfWkYTB4QawRt7ZzQJZGqAorScXBjwDN4dMP6MFbCmqNapO6nT
 rxsaRTxQMDPDNAkxtcRxjVxJhxPL3+GI2DsaSHBRfa1WWgy4UutvQ0loP12nBLokeeLyGnXvdep
 EhlGdztsPapvqToWhRhZtiKpe7cUL17wadbaTlvZgph201Mx5NYIywMqiMQ==
X-Gm-Gg: AYBFou1HfuznWy2c46NLiIhyfydImvd5Lb/t0kNhh7jTGhwd8IOqdP++RZYIEocriFm
 dLQ5W7uWys8KmGsdSDic8VnbmZC6JMRSq8n4r/YUycfsPGBwyj7EdrzzErYsz2IENjxbcTRHCRQ
 4h4WlgkfXHy35/F7pm7RJRCgQmN2eNMPfkBI39vLlwRmNG0LjJcalNlD2mCZWIu4Ki/BfofvEau
 EpTwLT2WSdBDqcgrkBBVdxHqOT5USMeQ6QElHqsAyBfrxSwls7DT3eGycTrsFozJnJSmq3yqFzF
 0GwbG9iILgc33XFGWAADUniDMy2D70vyVTWTpRw7LxtsyHnZAiENvHSvJCJp7Q0q/B+hFKfPn6A
 KEt+CqTh7J/ksDJJxx2p6OAF48+09CeYRkIUSpGY3Ej1HtctTwtcd8P1NqMjLUNWYeeoUPamUwx
 7MoBNudkIagIvR5yl81289EhF3drdMY9lPBgaytzFX+RA=
X-Received: by 2002:a05:7301:105:b0:369:efd5:9cad with SMTP id
 5a478bee46e88-36a203aaf3cmr5404717eec.8.1793220213087; 
 Wed, 28 Oct 2026 13:43:33 -0700 (PDT)
X-Received: by 2002:a05:7301:105:b0:369:efd5:9cad with SMTP id
 5a478bee46e88-36a203aaf3cmr5404686eec.8.1793220212593; 
 Wed, 28 Oct 2026 13:43:32 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a2390c6dbsm8187368eec.13.2026.10.28.13.43.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 13:43:32 -0700 (PDT)
Message-ID: <f734a320-c884-4cdf-8fd8-16b7d8c522c0@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 12:43:31 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] target/mips: Describe gdbstub registers with XML
 features
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
 <20261028192538.31600-8-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261028192538.31600-8-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ju9kP84C c=1 sm=1 tr=0 ts=6ae25e76 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=CbWQ0NMC1jNkEBtz2-0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: AOu43zVh5CebjZcWL3oAjEx-BcIYCm3J
X-Proofpoint-GUID: AOu43zVh5CebjZcWL3oAjEx-BcIYCm3J
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfX5UTghjFtdHHP
 Ksk5BhTZXI9FDt0Rhg2t6pJP/y7qU1jLO6dxG/yyVUNohrGfdBkZHOntZD4qJt93h+yss+mMKwW
 GQpXKBPYhQDa0/FdbaE2WrR0qSoADQI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfX/rcRi7nOFjb5
 zjYH3NbSR2/58OHjqRKvmR+67yb4m/ON5yJYHum4ydIU65GoJB+yyUI92vlHdSb5pVo56MPZbeL
 dDlGcEmDVQ8XstKvaZoQsVgxR2le136Yh+v8XG+6PsZd/Zzv+RazjL+jQNXWuHWYg81/Nai3nax
 T59YZW7RsUYz+PqfQoMYPxSDTfvODvoqR9HJZw/5NcBftpG6gEMzKAWT27jZbRK8hS6eRFqyD5P
 rmib9d1ZNEeDIEEedqwkNnVIABqJUcZFMs4NowRMJ6mtoqDZmV1wYP5pLb4bw9Ide1uSot99f5x
 1PjZbpNXnIZAVu0nQT0LbDIN5++5UKHskdrwyaPhHRgWXRMgPvxS4OC+LGQt50mhbraxTBl1LU4
 GoeAiX8Ne0WUZMNTBhnHuJ4yIK+KzLZAMZ02pcdo2znSRg9qgJVvUq8/dj2wdb0+p61gHLodZQa
 fCNcuL5U61M47TlPZNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280082
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
> MIPS has no XML target description, so extra features can not
> be registered. Expose the cpu, cp0 and fpu registers as the GDB
> standard features, mapped to the legacy register numbers.
> 
> Registers are sized by the target long size (mips32-*.xml or
> mips64-*.xml) instead of the CPU: a 32-bit CPU on a 64-bit target
> now reports 64-bit registers. FPU registers are single-precision
> on 32-bit targets.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  MAINTAINERS                              |  1 +
>  configs/targets/mips-linux-user.mak      |  1 +
>  configs/targets/mips-softmmu.mak         |  1 +
>  configs/targets/mips64-linux-user.mak    |  1 +
>  configs/targets/mips64-softmmu.mak       |  1 +
>  configs/targets/mips64el-linux-user.mak  |  1 +
>  configs/targets/mips64el-softmmu.mak     |  1 +
>  configs/targets/mipsel-linux-user.mak    |  1 +
>  configs/targets/mipsel-softmmu.mak       |  1 +
>  configs/targets/mipsn32-linux-user.mak   |  1 +
>  configs/targets/mipsn32el-linux-user.mak |  1 +
>  target/mips/internal.h                   |  2 +
>  target/mips/cpu.c                        |  4 ++
>  target/mips/gdbstub.c                    | 86 ++++++++++++++++++++++++
>  gdbstub/gdb-xml/mips32-cp0.xml           |  9 +++
>  gdbstub/gdb-xml/mips32-cpu.xml           | 42 ++++++++++++
>  gdbstub/gdb-xml/mips32-fpu.xml           | 41 +++++++++++
>  gdbstub/gdb-xml/mips64-cp0.xml           |  9 +++
>  gdbstub/gdb-xml/mips64-cpu.xml           | 42 ++++++++++++
>  gdbstub/gdb-xml/mips64-fpu.xml           | 41 +++++++++++
>  20 files changed, 287 insertions(+)
>  create mode 100644 gdbstub/gdb-xml/mips32-cp0.xml
>  create mode 100644 gdbstub/gdb-xml/mips32-cpu.xml
>  create mode 100644 gdbstub/gdb-xml/mips32-fpu.xml
>  create mode 100644 gdbstub/gdb-xml/mips64-cp0.xml
>  create mode 100644 gdbstub/gdb-xml/mips64-cpu.xml
>  create mode 100644 gdbstub/gdb-xml/mips64-fpu.xml
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

