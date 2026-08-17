Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEA2C5DF6D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 03:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvoJt-0006Fd-AA; Sun, 16 Aug 2026 23:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvoJr-0006F5-M6
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 23:47:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvoJq-0007Id-5c
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 23:47:27 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLDSVI322167
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 03:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RNzZMtGebEmGJt4V8dweCp9KINfF1OA6npeLrJGrDBQ=; b=EhPuxhZn6btZZ1HA
 0JxyM1U8lqf+fyOZk3cFWsoR4paeQCJxl9IBsVPVNAl6Ytfvg/sdtLYGItiT2Q24
 422PEKo0dar8Ispgt9DuHM93vRoACBp9XoGKUNZGCnJnqSO6IRBbGAeTkkR61d+5
 fNBQ83n5i7Q7isjjaRmjeX3MVSMaS5aG3meMjCao1+ICsOwI9vYNbEdT1wwr55CN
 s1eqxOIv7CrEdN72MJjy4+HvYVPthbCrM55Pxa+48E8NSkW2KzaajOIG0+bYPaKN
 hAGWk8tiZuOqLvOwrHjeyoAtlmai66AVBCCK3B2tfp/egmxMo8ZwlCiko/45pZcm
 PQu9vA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghfvyxh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 03:47:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93494527488so505854185a.3
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 20:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786938443; x=1787543243; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RNzZMtGebEmGJt4V8dweCp9KINfF1OA6npeLrJGrDBQ=;
 b=kXpqAMa6Bv4PIHLwbJArvXtmhrysrxz/1/7OZHqCciJJ6zNXQzzA2vHIBgmkRnQ0nj
 YaNI3RQFFFM7x6YqmhTSsXAwsZGpA/gU5blY+RiKph7aZkn26wbM5vY9P6pOy8q/8EIW
 bmss54dtegWjlnajYDzjcTN0GQ1C3Jxx9Vyoy+xpzHee+AJxhT2bZv6b4K49iYoAyDR5
 pj0UoWY2uH/S4bRHC0LzBFj4UYR6ZlY/UG5RA7LtuDufGttkYAF6cNa4HYbBRrvDEizm
 VUVK3biL3WnjyVQXDFw7aWkdXCLBn94pKrMKmv4hsHXrgpjcm7nYw7FAYVxaaBkRuy8U
 feFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786938443; x=1787543243;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RNzZMtGebEmGJt4V8dweCp9KINfF1OA6npeLrJGrDBQ=;
 b=liP2O7lzIoV1O3Y9cYsWxTkzp6RritDzgBaR+S9ScDhAzX0MieRi9OM4S8M5ozFhNY
 +5xVT52340t7IZFZ9dF0oZ4tL0MzHlwa+STQVrm6m3hxqF+GThKXAH0uzuVrEZGbxCK8
 nCFuRirRC8/nSR9SXaFUBDIzWEQGuqEdVwmyXOiCbzqnJ8+DTsLfnGvOHPsPXJWe2TiR
 9hrPcK4YJXki2V3UeC9Bt1gv6ItnLQ+/Fsws2ABr9b/VsI/NvG2NyJsDgRN2AqH32/x2
 FA30/KfuS7qcnzJj0ryNGGcvAUx8CFswQFwBcL+QPYU/2RznCDmNg8cj7b8Z/iCQxEdG
 9O0g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rryzo9WrGWdDypz5ELWacSqTb8BZ2WNmg4rMJB7BbO5z3x0ywWeHP+wGaiTsVFypDUVdaRYaaAdrVUY@nongnu.org
X-Gm-Message-State: AOJu0YxaF56SeoKmQLTkddOHlAJKP4ap2qZvK0bgbbhO/NkJXKDUfVp+
 /5vaibfPV3RFAh1AdBfA3oei7SX+9gPz3zJMDnC8s3oCS8Rz6bEgLeX6QmqFdQFicNvkxsHS9QH
 pPpz1Ccbfg53xQV5rJVPTDBe4ujQSfHH05PDaEquneW74jTZliCPZR7b4iw==
X-Gm-Gg: AR+sD13LujOmBsMJZkh4gx7Esc4if9nIDA5VXVqSiFVLM9Kj2xdbgQf3/gote4Lr26b
 Q2a+piAFCLw2dDxm+/b0RRDwTfBDEsL4vJsJAw3n7ewv0Dl+3lEIyrXFSMF/CFSd5t/VdyVrc93
 BNHvCXEqLqQuGqPUYvTVXM2kc3/wHbjjz1ivZw+H/nRvp60dv3XoO3fLMWPqnukGp5Wc32t9+TA
 xW8foYmpbOvXz2flvTrVnfv7+B258xSLDkZvyhZOtLWxgDXUde9wNosX7kqC/ANUFvtAE+wLQtM
 sEc2neaHB7tiJBTbqPuj8Jpi7v2vRtUxI2sr+5YqOdIQyzH6FO6Uk3WRvHT7FNJp71rmvdN1/Cc
 1AYg36YRRnUm4z5MSdvyWm7vBdXE8OA43ulU=
X-Received: by 2002:a05:620a:8f8a:b0:916:10f6:780f with SMTP id
 af79cd13be357-936d22cdfb1mr1519074285a.27.1786938443502; 
 Sun, 16 Aug 2026 20:47:23 -0700 (PDT)
X-Received: by 2002:a05:620a:8f8a:b0:916:10f6:780f with SMTP id
 af79cd13be357-936d22cdfb1mr1519073385a.27.1786938443172; 
 Sun, 16 Aug 2026 20:47:23 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999cfcee58sm4253475e9.0.2026.08.16.20.47.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 20:47:22 -0700 (PDT)
Message-ID: <3a540f76-6d9f-406b-8b3e-fcea9714f306@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 05:47:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 42/49] target: guard MonitorDef tables with CONFIG_HMP
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-42-e53fc35bc550@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-42-e53fc35bc550@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAyNiBTYWx0ZWRfX+D16Ayk7IHD2
 G/3IC2J23jDPi2qzl6e+rfefpPiinFD/CphLD2jzwqppE8Uusax09Za7vHgR8w9Ibjf1YesNDLJ
 Ur02/y72W6b70HBLo5U4c4658czRt6Q=
X-Proofpoint-ORIG-GUID: uMuDH6CZkx1yMc-Z5iYefilRat8suRTc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAyNiBTYWx0ZWRfX1e9AlyjIQJPg
 aXZqqgIK8z3WnZJHMCM6hPxl8aHs/DJgQDvJAXl3vCqWC9CEIAukOF18OAwBWd69NLLIdUOylde
 MvkY2vUSr10GTLIUYTmDMB06JXWm7sNveMG5eTMwPKo/jyh5avx/c/ItZCcoxIxAP6OYGzYLU+R
 COqrYy9kt+OCZPh7DTKnYZe0g9GzvMPMqTY0FVjkzvnIHWhD15kfmsGaKY+hfDtoEu8Wui0lvEu
 uGsoLyY+WhlRUTwL+LOBCzu8G4opKoveaLNGIUO30wtKAI1lPjzZUnDs5WJjUwqKZ6P0Rq2wNLa
 V/skuyxDxsL0/NwJqN8svqfxwDXVSZiDfP6b/CyIbMaETYLRr77ek+l8xtjdqn68KvxzSN3I5Tf
 xKQhOH3jbFj6oaPqgXq8StbD3CTFZZ3frruqZ366eJnH4sT/8kom/3TSKIgjyeAHbZ/epdzoXyr
 KCQ67WcoTpjJFSMMJdw==
X-Authority-Analysis: v=2.4 cv=TMJ1jVla c=1 sm=1 tr=0 ts=6a82844c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=mX4pIciRXg39azDaiXgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: uMuDH6CZkx1yMc-Z5iYefilRat8suRTc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170026
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

On 16/8/26 21:13, Marc-AndrÃ© Lureau wrote:
> Guard SysemuCPUOps::monitor_defs field and the per-target MonitorDef
> arrays with CONFIG_HMP. These tables are only used by HMP 'print' and
> 'info registers' commands.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/hw/core/sysemu-cpu-ops.h | 2 ++
>   monitor/hmp.c                    | 4 +++-
>   target/i386/cpu.c                | 4 ++++
>   target/m68k/cpu.c                | 4 ++++
>   target/sparc/cpu.c               | 5 +++--
>   5 files changed, 16 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

