Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42378606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C61dx809;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZHOR7fBr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSsSy-0004jZ-Fq; Mon, 16 Nov 2026 03:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xSsSv-0004fR-Qh
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 03:53:30 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xSsSu-0007XT-1P
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 03:53:29 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AG7f9kA967117
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 08:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EBAblflXqVxM4gyT+sTs9PxFbLJEHnJewxOdLYnsQ54=; b=C61dx8096hpSw6FV
 efc8iDk939T+qtmYf/SPQ2piyNUpgzqMna9AfyVQRKegGj8Lwq/63wwoMcV+dWDX
 DzYZDDxwZdktXd3v41OlZUNVblFRIdF4N1uY5VKdNiIv3gE86qSsO/w/K+0HfXHm
 +PPgDr+DgXKDaoJlXrVwxbpsGZ3tMmUqI2ZI+FMKtN5eyiH6qz5tiqhx8Yi1gX4d
 tVh4357m+dkLumgQW0ULiJvchVk2gXZQezdPsoLRGdGfyHCm7rWT6QbXlVdGVpMy
 Z0WTigawC2w0LIxELblC1q97P1wqvosEO4yWAKeKNBcGbUEhx/TW8BEaMKru4NEn
 Gt9hSA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhk25ngm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 08:53:25 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f6f4fe531so575249985a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 00:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794819205; x=1795424005; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EBAblflXqVxM4gyT+sTs9PxFbLJEHnJewxOdLYnsQ54=;
 b=ZHOR7fBrN3ey1R/Amr0WEIT2TLjGtweVVJ+nDbo82GoKmikEwH4FcKiYn8pXFMCGao
 +rxCoXzNdeXSpGZCDVq68YJt5pE7YvtyPPds/9jW/lZIzuS27vpooO2ry5hCrG/XQ8cU
 b0l88YFE5Bza97N6czEFmog/5HVqZI1S3b6gDr4kiCEmJSNzAlnEqHjebEt56Gxjt31U
 PmssmclIMdFzI9iYpVtmf581r36lHw3TrxOM3KjCB3wW1hlSymzPD+qgApr9GqyZ4I2X
 BBZijHnBmGDjD7mGrz27bW58Q328L2xGdDdUM8R/9RiBkEsydBQO105t/iN/ir+6eLKq
 bGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794819205; x=1795424005;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EBAblflXqVxM4gyT+sTs9PxFbLJEHnJewxOdLYnsQ54=;
 b=BJ4YHrSNAn3YXyjGYzCslrrJSnf3GQicf6Dy63ZVAiBnUfq/tPIlbQimtLAKiUB3s0
 E2AC51HYXmVpPBJEdfk9F5nDg3TIwsTrKlBIkKBiyjuQB1cuLc3H+0csrQyQKnj9jVnH
 MTt4I3LdOt0Uzlp5OSc1Kf/H+uF6qpkypQPxozGwwBEBBersyzIVua6Ew87j5yVxIoT2
 ZcYSkscg+vmsvt1xQ0qQgWCgfZbNXrNhQa8D4MoZO7S0OlB7YJOo7LOYRtn8n2qrO0l6
 ICGEqWGu+knEgJhcd6k0oT6mN+gEe/qMKW4ZkatF6Eg/Rl4HkRd7D4LRTUS16+l5xHgf
 1VIg==
X-Gm-Message-State: APuU4Z+qyU7rs3NPTS1QHMJT/XLJhbiCdzeix0jrekw74r6YeDaxlXg1
 7eENOBMkcPuiiHnhd8Qw6mTFhFrzh9Ps+hffcxxnjvsdtQlwvwg451tZDYCvRhA7ESzBAvTA/73
 V0/HINeeI3RjCFIcpr3803aFPCExNfU4+d30jOJyGRPrDcLTooUKcjVWxLw==
X-Gm-Gg: AYBFou32T/IdjqPKKbrWR55TjOB1lSyfw2aVXUc2faNtns1/TfNfDBp7RdepPeyIpRP
 Ox8+kqIo1PQGLQUP3vkcpHX5N17m1xPJT70jJgAvOZLALiOQo5Yu8uhpPzz5kt8fAUcgQhzoIf4
 6NkcZwmgkag62DrWyiWB/GdPvMSviJI9jB4Qw9isCM/HYBDsy/KXIfSqNvn2MWfG2gqTqchu1lo
 q9r17ZAJmboRLT0+x8wLyg3+omxYRZ6uOwzdcWfX0csUS3rC5Sx88FhiHDydYvQjPp8Rqt6f3oR
 euh+b0i9+6oXsnzl4T1FNk2qG+aafgHppPHuvw21eGLivBCtzQPl0GQu23L9xwSHHE+0wZGL5bV
 +vMgA9d9NODny8BnxejYpq/zBc1Z541M0DtiDlrigbEMHf2U+KfO6kWnLjvXAv5ZMoqgQ9TqKJR
 E0kdXt/sI=
X-Received: by 2002:a05:620a:4514:b0:949:7502:69f with SMTP id
 af79cd13be357-949750208d7mr535706285a.78.1794819205123; 
 Mon, 16 Nov 2026 00:53:25 -0800 (PST)
X-Received: by 2002:a05:620a:4514:b0:949:7502:69f with SMTP id
 af79cd13be357-949750208d7mr535679485a.78.1794819196826; 
 Mon, 16 Nov 2026 00:53:16 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f5972a7sm19895896f8f.21.2026.11.16.00.53.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 00:53:16 -0800 (PST)
Message-ID: <ccfcea11-ada8-4753-a71f-f59ed1bcb067@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 09:53:14 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-12.0 v2 00/12] linux-user/aarch64: Support both
 endianness at runtime
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 devel@lists.libvirt.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org
References: <20261112180859.85380-1-philmd@oss.qualcomm.com>
 <9b64d3d9-736d-4878-80d7-4caa75eee778@linaro.org>
 <CAFEAcA8La+8TqFY0yCxRsXY2Ad9MA5Uu-sVEbysExZPkUXVawg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA8La+8TqFY0yCxRsXY2Ad9MA5Uu-sVEbysExZPkUXVawg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7rnIoPbvlQH3g9QxL3eh0fBXw0NywcsN
X-Authority-Analysis: v=2.4 cv=QanzLcbv c=1 sm=1 tr=0 ts=6afac485 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=hA93whgwREZ5Va0HPSoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNSBTYWx0ZWRfX5Vvsd6spZ2yO
 gyujeaiUDmbSOoMcTl+cD4Y5QR/9e401pRy8hY7fzp/8K+Ji5w7C4sAJ8kIIjTZwCrH40wQik/a
 XfSVzXhfFnLgeg6VHamZp/ytdEAvV4AdqMjEWbk20tVOhmFZ7sY5v9DOyEQfUatkhjH4aM3e1PC
 nH1Ik583sRvrMn6/fQKAKIfSEazJlr9jGamqgZ+L6dnxj6XgrYH5/1BgmW0jL+Yr6nk8kkS/m/P
 GS5fLRZ+uw6jj5QTbDPtEOA8BpVidPRv9RnStRdMOTXqhczunTF5hJfjmYBqWi/qpQNoz2N6ErU
 IKuRrApJjOG/8i3dma3zW+OuZIpTjqTBlWi6nMnFTP9dvyekp6JZObHyYdaZGQTk27nOd3DHZMK
 Yegc2Q0c9mj6k4YFMk/ut78vVrs8yy6Zmulis/JP0CtWspFocEaZGWxKMxiqgB+UocPhUj20V+q
 nXwMu47lfvSWR6Cs0pA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNSBTYWx0ZWRfX0DAVkZdxdh+H
 PSxco8qsihni9s/JKOiJ9ZZ5wvQw5io9PkwvIFaU7mr+FmD/kpK+B0JBSayEHwxGICnZajYLI/q
 o3x2/wv996EyP7qUPk+qdkBT2LR3784=
X-Proofpoint-GUID: 7rnIoPbvlQH3g9QxL3eh0fBXw0NywcsN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160035
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 13/11/26 19:55, Peter Maydell wrote:
> On Fri, 13 Nov 2026 at 18:39, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 11/12/26 11:08, Philippe Mathieu-Daudé wrote:
>>> Since v1:
>>> - add ./configure error msg
>>> - cover ARM32
>>>
>>> This series lets qemu-aarch64 run both little- and big-endian
>>> ELF binaries, retaining qemu-aarch64_be as a compatibility alias.
>>
>> Why would we want to do this?  qemu-aarch64_be exists, but is
>> essentially unused.  It's certainly not supported by upstream Linux.
> 
> I know the kernel just dropped big-endian kernel support
> recently, but did that also extend to userspace ?
> 
> (We should check with the kernel and gcc folks about
> whether/when it makes sense to deprecate qemu-aarch64_be.)
> 
>> Having runtime selection of endianness seems silly within that context.
> 
> As a more general question, is this something we would want
> for architectures where both endiannesses are relevant (e.g.
> mips, ppc64)? At the moment we consistently for all targets
> handle big vs little endian as "it's a separate target with
> its own executable". That's convenient because you can at
> compile time hardwire in things like variations in struct
> layout between the two. We could switch to doing that kind
> of thing at runtime, but what is the benefit we're aiming
> for by doing that?

I did the other conversions (Microblaze, Xtensa, PPC, MIPS, SH4)
and wanted to test the water first where this would get more attention,
with the series involving less changes.

My motivation is MIPS where we currently have 6 binaries and I'd like
to add binaries to cover more ABIs without having a combinatory
explosion and have 18 linux-user MIPS binaries. With this approach I
reduced the current MIPS set to 3 binaries and add 2 more, ending with
5 covering more ABIs instead of currently 6.

In order to get there I need the few core changes introduced in this
series, which affect all user binaries. I have the idea ARM users are
the first ones interested by no performance change thus is where
I started the benchmark to prove this approach have no impact in emulation.

The TargetInfo structure change (one initializer LTO-protected and
all accessors via read-only exposed structure) is also what Richard
was very keen to have (page size support planned) instead of the
current approach.

I'm thus returning the question as: why would we not want to do this?

Regards,

Phil.

