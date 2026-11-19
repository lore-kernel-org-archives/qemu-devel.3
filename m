Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEF7606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z1q1U22A;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h/uwVbof
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU02U-0005yY-Qo; Thu, 19 Nov 2026 06:10:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xU02S-0005yI-PV
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:10:48 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xU02R-0007Gk-1u
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:10:48 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJB51rC2093132
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jvzgIuLTw318ckcPHEY6MTeFi7LrGSiFLYxFes+o+Fk=; b=Z1q1U22Agh3RV265
 /Od1lvWeXZnpNn+rrYcGtVtXHbBLrkEc2jFvSytxCB0RpoPHflw2Kf7OnSDn9JAX
 LbQhcuuA51BwBk5BHB4AeEtYMQsLs4EIjIZ/vYYTSmcD8CGsLCeOacCvnZwkEXhN
 PB7Xm/Y4JLx9JyUnvsIbdceO7eC87nqA891i0bZ4ja4zABkT+yUl4kNrzZ9JCOUh
 lZiA5EKIqTMH9YlsXLp3Y8XjWNywzII7pG/qZdA2B2M0b9+6yFPsdJdfpTMYBQmr
 Z+UxO/YNPiX4SPXFYNHCshJJBC3STTxvpxGc5GLUPOsEIlq9A9es1bMFGTa7Mnxp
 IQ8wpQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1yx680kr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:10:44 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f6f4fe531so342336485a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 03:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795086644; x=1795691444; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jvzgIuLTw318ckcPHEY6MTeFi7LrGSiFLYxFes+o+Fk=;
 b=h/uwVbofhTTcZXQ/pIfy7b1YA/sylTx1q6QV+9g4pPMPef7QI6ArhGR9juPQsFrmg8
 /wjefjJ4XrRsCyXyKpLzYYzV4uHpTx4I2TpcFODb+g5M7rxF2Egtp20kUBu0MySwysBB
 Q1gE8eJiPOJvzLgSqqwl2cOfE211Wc35Qsf38Y+BbBupUcIAWwh3Nv0nI2xxh0FvNAjB
 T7ikiyZXobaE9okBe+2Dvz/y39dufmStXr4OWmqeb4wN+xINGVFrCEw/4rBVdjlYRkFL
 be4tlPQ36s17yM8zPW6LO49Px4CNjPg5EoeFmQNV1J5AVdARxh/cdE3H1/7Yn+m5YUrd
 Peog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795086644; x=1795691444;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jvzgIuLTw318ckcPHEY6MTeFi7LrGSiFLYxFes+o+Fk=;
 b=Lf8yI+pvzuraCYhNECpHcGVFR5vfl6+lGCWFqpK+PqBbLdV78tiVWn7NdfBssBxLk7
 SKQuj4QO1mZjTPmcKHvHHjgIWjn3AnK2qAmCo02O/KMbxSKD5SaVqutOxqq1yIMrAFN2
 2z602pNBikTOTNpSBAv6ymNcAW3uCQetEEPHFmq93anZUXxN1LBH+IVfvjA4YTiiMmlV
 OW6z+5R+jsVxhiVazzK2hjfDIivlgHUxpAUI6HKGAqT/qU3xReOhGwm5pdsuIUN54eF5
 ky0Qun+d1iGo5CfYkhF0LxfvmTRcV///RIqdgNatLqTqC/1oMyV14uzAs35LY+d5RnhI
 Ctqg==
X-Forwarded-Encrypted: i=1;
 AL+hErG3ndqf81o3zfmzMwkT/fCwXWOmAKaA/R3GDSO1FCEvHek6+p9VBRZFZfVhlcrj8YDNqV2J+G4CqXg4@nongnu.org
X-Gm-Message-State: APuU4Z+63CfMt8EZ0GuohoyEpL1NLNhGkJtFCldJ8im/zOcMqsYV8jZk
 2It24jN5YKkpmULLzRg+RGxZKCHaeQ+xEC9C8IjoNH3oKxinwM/v/h/QBxWM5J44txH6YKaxoFI
 UzMLmVHsoKAE4l7BWMmqhxquEwyA9kdNkrWP/e2xEnYgivWeqjAwH7FhoTQ==
X-Gm-Gg: AYBFou3ql5KmvgKcgtdTtQQ/DkLjUdBbfzk8W7yrORL1lA7tIwAaLTbFYECGT83oaJf
 zLr/PQ+Br7o96ZAEmrxyiWZKlDsBAtQOtyrOLzRw6jsIx5Z8xPkjhxBi3iS9xZcR3aNPVbVoHkX
 lxXPd5ECLxIYQ0yg2gRnliOsjU2DW/D6r2V4b6bcEWTTqfMoi0eQR/0TlvTyTLTstNDomS1u0jM
 9/tQo1ALPypDOK7tCKRCr0YM7zS4hXNYUQMfmUdpRkrz1SVFHH4rugVO9Hk+hnf/ezBDJf38dqc
 H/xumYtNpiv07PmgWD6HQPoJbzWmkrL3BM70dUscbIFKZ8F3xlRF8LSvw1s8RoMm70mRU8896rK
 oNmEdSqJcAtIyKoxKxUTkO4KrMhq2lNQ5WumuYbWbwdmczr+Ms0UHDhTZrOnmRktFOdNZ1zY0jE
 2ZyvRDMWM=
X-Received: by 2002:a05:620a:2615:b0:949:869d:a011 with SMTP id
 af79cd13be357-949997b691cmr876420485a.72.1795086643607; 
 Thu, 19 Nov 2026 03:10:43 -0800 (PST)
X-Received: by 2002:a05:620a:2615:b0:949:869d:a011 with SMTP id
 af79cd13be357-949997b691cmr876417385a.72.1795086643101; 
 Thu, 19 Nov 2026 03:10:43 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb85399e2esm34128325e9.7.2026.11.19.03.10.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 03:10:42 -0800 (PST)
Message-ID: <5f1d7ff2-8a61-4e2d-b751-001bb5eece58@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 12:10:40 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/19] target/mips: Add the NMS check to the nanoMIPS
 CACHE instruction
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-10-philmd@oss.qualcomm.com>
 <224749bf-2ff8-4311-a19c-8a92721cf8c7@linaro.org>
 <3d1087fb-e42d-44aa-bff1-a23f392fc015@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3d1087fb-e42d-44aa-bff1-a23f392fc015@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pOWM6J93_TV8j90JbAWgecg4r-Vr_IRu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0MyBTYWx0ZWRfXzpv2EerMzjv4
 SFxhCEM5TNesx2NDQIxGm5VloRgc239sEya0XkJHGNuBB/aAMXRwvcb6JdiUioo3gPY9DYwxEzb
 mVmm0mROXOJzTX7CggyBFFJ13NQmhVo=
X-Proofpoint-ORIG-GUID: pOWM6J93_TV8j90JbAWgecg4r-Vr_IRu
X-Authority-Analysis: v=2.4 cv=FPmOVOos c=1 sm=1 tr=0 ts=6afed934 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=RP31ohRRExpPAdQ0A4AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0MyBTYWx0ZWRfX22UHH2DxovK6
 eflXDN0BYOi4w11Fya3Tr3JPcB/5XkkzKd/kdpyobz0YKnIq/1Xj6At3QsySq6s8cqlgitqBEXe
 4BhY5catjmKwxmt9IxzDQwOTLyH8w/WXQxxcLwsXjZQYVmktVLEWq3R8hBBj3JyoBLkENY9qKIB
 b/1idqMCNfe0QCFZwMwrtBVHMzRNL6hIJYn/w1JMPD1tpJK9QyxfLRd9nr1aCAE/j9pukjm194y
 +3EU6FkhIdCxh8YePIwbQwjYEq2mWVWhq5aGW7cmYi+xttcp6/jLs9QkcsBZkDE5AkU278qd4C7
 /2b1vVL2auZtfJxdCxITunkY+Z/ji6NdPezA8lkF+RKQQA1oD0TBneiygr6f1tewoJ7jqJmYgPh
 Z+auigdSId5jPNBK9zR/CvG/Qr3sp0dzDbiNXP+6mJaFktopbNL01pzk3ZV3KLAbYes4iIdrwku
 WEymV+iRGOaBRxWTXGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190043
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

On 18/11/26 00:07, Philippe Mathieu-DaudÃ© wrote:
> On 17/11/26 20:12, Richard Henderson wrote:
>> On 11/13/26 08:11, Philippe Mathieu-Daudé wrote:
>>> CACHE and CACHEE share pseudo-code raising Reserved Instruction on
>>> NMS cores without caches, but only CACHEE performed that check.
>>> See MD01247 rev 01.01, "CACHE/CACHEE" (printed page 63).
>>>
>>> Fixes: 8f1d9b6d6397 ("target/mips: Add emulation of nanoMIPS 32-bit 
>>> LD/ST")
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>> ---
>>>   target/mips/tcg/nanomips_translate.c.inc | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/ 
>>> tcg/nanomips_translate.c.inc
>>> index c883b5514f1c..20e96f2ad9be 100644
>>> --- a/target/mips/tcg/nanomips_translate.c.inc
>>> +++ b/target/mips/tcg/nanomips_translate.c.inc
>>> @@ -4131,6 +4131,7 @@ static int 
>>> decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
>>>                       }
>>>                       break;
>>>                   case NM_CACHE:
>>> +                    check_nms_dl_il_sl_tl_l2c(ctx);
>>>                       check_cp0_enabled(ctx);
>>>                       if (ctx->hflags & MIPS_HFLAG_ITC_CACHE) {
>>>                           gen_cache_operation(ctx, rt, rs, s);
>>
>> Also missing check_eva.

The EVA check in the shared pseudo-code is gated by the per-format
is_eva flag -- CACHE sets is_eva = False, CACHEE sets is_eva = True
(MD01247 rev 01.01 p.63): "if is_eva and not C0.Config5.EVA: raise
exception('RI')". For plain CACHE it is dead (never raises RI), and
check_eva() would wrongly raise RI on cores without Config5.EVA.

I'll post the NM_CACHEE reorder as a follow-up.

> Hmm looking further commit 84c2fdc397b6 ("target/mips: Fix CACHEE opcode
> (CACHE using EVA addressing)") added the check at an invalid position;
> we check EVA -> CP0 -> NMS; the spec checks NMS -> EVA -> CP0 (in
> MD01247 rev 01.01 p.63 pseudo-code block). On a core with NMS=1, no
> caches, EVA=1 and CP0 disabled, the spec says RI while we deliver
> Coprocessor Unusable.
> 


