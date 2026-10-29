Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D23D606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kWaDX5gt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LKDkXXP7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMVe7-0000RL-D9; Thu, 29 Oct 2026 15:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMVe5-0000Qq-KH
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:18:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMVe3-0005Xb-L4
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:18:41 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDJNP1654959
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 El1Se0cyrlfeDsExZ2wOtYIml0bGI2z3+gAwNMg/Juo=; b=kWaDX5gtbE6MgjZD
 y0+AEov4yeLT8QjX1Nwng7+4HM/Q795toQvD7YlHYVqpTQL7/iLElHCuNLKBq/1C
 03y2TMqQ0Mnqi4SBAZIQGuB+hQCq9Jxixzdvd4qhvhEociEdMfzk/YFVfn3P1bCG
 Vt5EFHsF3Bgpm9qSD5Z/3xizh6AriWDHX09Id3YIeAPYI0g0Tfuugk3TWij5nQXL
 7HikPhDI/g4rK1fhMfTSpRyjTtM8NZWwcM6rTjv+fZSWBJUAoORrIgpIqPvrbiO9
 V9zkumqxSSoCJAadE0xKlpOVJ+i8eS2jI+p7ZDRjYNgdRjzum3wkFBOF6oDcMcn/
 gmQHAQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm4a22dk3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:18:37 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36a223755e4so100533eec.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 12:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793301517; x=1793906317; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=El1Se0cyrlfeDsExZ2wOtYIml0bGI2z3+gAwNMg/Juo=;
 b=LKDkXXP7owQJOJH+RbniWxHd7HyE6Km0CDG2tQTbk1LdXIhrsqX5ZNzAHof+UCbFZ+
 xoxxHp+tp4DGVODONW8sV50FxzbLw/ou4LocchHPQ/SzO8//Y3MChAqx6e91p+scgFc3
 qGvASVCj/RKaLsC0BHkqgOQSWM4D+gVJGcQGMv46nARr4HBtPO/GckSOy0KrDTviW+uI
 v3Sa9MulcVWgbjy9s3RKvMBCvUvvtJXAkwprGPsoGgSvYnxF+onaE8gmIdr1erueExZM
 Yi6/ZbPTRV0wyMuuYO+P0BmJQBT5y0pWOd04955iGIFInPrSGk+f1in8bbcskcP8lJd3
 kZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793301517; x=1793906317;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=El1Se0cyrlfeDsExZ2wOtYIml0bGI2z3+gAwNMg/Juo=;
 b=YHaYcp3ADCtcM+edLKH5xu22VeOG63Ft0/LaajrFfP8JronUuDx8cZtPO1Pj5MveqW
 WjVl9ze+2ECEkzaPCv/axvvdK1X5Vd4CgMNtuOqA8DfNo1JjPGVv14CEXx+OFV5Mbk0l
 0ve/723NaT82x56TQ0JM4MPYAHwrsV2bY2gTwHcR4ABCK26xkA+99rhWyjnVKYieMR7v
 Y2YvAGHNI5pjPZOwdzw6EuieF94Bwb4ycznD6o9PLgtK0kF5xabMQeBf16x0/3EbjM8k
 rCaCH+Q3PM6gcP3uG02PX/mYkWkukf8vPzJKPSmhcln4JUbzWrgHkyiQYh4kAJZOXWMf
 K88Q==
X-Gm-Message-State: AFq9FYKQ7R/iKvj0yhkGT/Aj8TgkDBoN8bDIvVhJNlvGt/YOex7+jvu8
 zVwn+2ezfAXTnVjpIwd5CW9icH//W0HVGrBLxsxGaCTSh9KkQctSvwqz0rH2Qwm30yt6pLlP4Af
 NwY1q0PIjAIksXl2PJu5zj5fYQiBCeZue9N9CFbAGII1RqKAcJ4TFR/TF4w==
X-Gm-Gg: AYBFou1+8Ml8j9MReoO/g9JKFk5biUFLRKDz7bHeBltNgj8gAcxZxvLY2G49UDUnRzD
 KOhj/83pJ+gKn/KQ/o3P37WX5hGhMZHFyAkSRsVpt7nFUEXJ6X80kKcQqgP/6sVUPulqo2wLIiq
 FzUV5JBDh0k4Z3lCHGxziwbS/CeFac3IA0KxV1sDB+CPDhVzSsZBIpQx9eTdjSuugrH9T5WFKFs
 RQdS2fry/lZIv1QktbhbjdVD8u1cKv3UlN7tNoqXYsd7GL0s2qHYOdN3oMKvPqh4jLGapAjVMuf
 iYuyNrN28MmjntkyHr6VSd5hL3BIGN4hjhHKw+kmki3xFm6BkTwGHr2KlBb9/Phxb2Be51OMS42
 lMGiBqqfSiLX50SsGOApr63M0v6Ktk8Yy2XgCmbw6RXUVCXno2WQQL2XWfcEWg01dDXzX7kHS/F
 B0T3U6l4IQESuOiCHBk3QFXYQ75ENFd8ewoiTJj0h9kvE=
X-Received: by 2002:a05:7300:f894:b0:36a:1bd4:628a with SMTP id
 5a478bee46e88-36a4232bf34mr385890eec.9.1793301516618; 
 Thu, 29 Oct 2026 12:18:36 -0700 (PDT)
X-Received: by 2002:a05:7300:f894:b0:36a:1bd4:628a with SMTP id
 5a478bee46e88-36a4232bf34mr385855eec.9.1793301516076; 
 Thu, 29 Oct 2026 12:18:36 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428af1easm585992eec.5.2026.10.29.12.18.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 12:18:35 -0700 (PDT)
Message-ID: <2f0355b9-fcdf-4ab2-88c4-8e16a06a67b4@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 11:18:34 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] tests/tcg/mips64el: Add bare-metal harness for
 R5900 system tests
To: Fredrik Noring <fredrik.noring@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
 <20261028192538.31600-5-philmd@oss.qualcomm.com> <auOPHGG6lAEIlGr-@aerith>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <auOPHGG6lAEIlGr-@aerith>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3NSBTYWx0ZWRfXxlw2bKdd1Dzu
 xDAUtY+3C5E3rANI/eRwSHDGhH/9G097ubEF3jHZSpPWPyTvs7IGcYAJpsMfnw97rFtnyY9Up5R
 t+lecMq640ZBPELTmAORbFHSNZUWBi0ftwdDlWsLE//D/oDCnuXfNlKmoRksWeHaAZlhTG2TL68
 CNFWKCSLGEEeacZgjZ8Kgu0+KbAN5PsrRsXrki5KTODmJ5ckY4sfv1Xyia0mBwIl6btVmykmPvn
 Kw/fkijmbqtoC1kHt9MBbpUoQ33ChMUcs2AMb+O4HF9iIea7tGDQb+Orw68cUdunefcK8L4ZOqN
 KWMYqRj7fCqm/1PpS4dtVxp5WOmPMEfwuTRiYrmLT3vO8p5mqPW1FTINJ7PgFkG9Se43mkSrDYy
 i0a3haRZh9OQZmRrBNabJzNv4NO3l+tT1EuxXHCkJnOP+QxBUPI3UBI8g4QsxV0KDuKeJmUDFhi
 UQ7wGQ2YzuX3wttq+tQ==
X-Authority-Analysis: v=2.4 cv=E8tYNqdl c=1 sm=1 tr=0 ts=6ae39c0d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=BcPKCTjPAAAA:8 a=NEAV23lmAAAA:8 a=rf04l5cdAAAA:20
 a=7mOBRU54AAAA:8 a=-UBrNGQF8oijzdajUSQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=MNXww67FyIVnWKX2fotq:22 a=wa9RWnbW_A1YIeRBVszw:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3NSBTYWx0ZWRfX4kasfqy86/l9
 DWZuMRL66GDTh5IQNV4bs/ng2HJGjmhuA9xrlnZFQ6rSIv4zQ0jAHOQ4wROltwh8W9C3MbARBGB
 hOhCitcELOPEG2YjiHm7EgbjWIvrWNg=
X-Proofpoint-ORIG-GUID: hoT3VnGxEYnsrHRwTaaNPcXgJlhEiJyS
X-Proofpoint-GUID: hoT3VnGxEYnsrHRwTaaNPcXgJlhEiJyS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290075
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/2026 10:23 AM, Fredrik Noring wrote:
> Hi Philippe, Maciej,
> 
> [ Maciej, a post [*] from you in 2021 is referenced in the following. ]
> 
> On 28 October 2026, Philippe Mathieu-Daudé wrote:
>> There is no libc for the R5900, so its tests can not run in user
>> mode [*].
>

I think that Philippe meant "there is no *prebuilt* libc for the r5900".

> Both Glibc and Musl are available for the R5900.[1][2] In fact, we also
> compile Gentoo for it. I believe the -mfix-r5900 option is used for the
> official Gentoo MIPS downloads.[3]
>

If precompiled glibc or musl with companion toolchain are available from
a .tar, yes it could be used.

> As for QEMU, I maintain my own fork with R5900 user mode support since
> 2020, based on QEMU v5.2, as well as a corresponding Gentoo package,[4][5]
> because later versions of QEMU became unfixable and unusable for R5900
> user mode emulation.
> 
> A proper QEMU R5900 user mode must emulate the FPU like the Linux kernel
> does, which is why QEMU 5.2 remains the latest usable version of QEMU for
> the R5900.
> 
> It’s worth mentioning that there are discussions on introducing additional
> FPU modes for the R5900 and Linux, which would allow use of FPU hardware,
> despite its noncompliance with IEEE 754.[6][7]
> 
>> [*] https://lore.kernel.org/qemu-devel/alpine.DEB.2.21.2103172243160.21463@angie.orcam.me.uk/
>>
>> Inspired-by: Maciej W. Rozycki <macro@orcam.me.uk>
> 
> Fredrik
> 
> [1] https://github.com/frno7/gentoo-mipsr5900el
> [2] https://github.com/frno7/gentoo-mipsr5900el/blob/d84d04b2fd9d47d5cce9c1c0884026cc37d008cf/scripts/install-crossdev#L16-L17
> [3] https://www.gentoo.org/downloads/mips/
> [4] https://github.com/frno7/qemu
> [5] https://github.com/frno7/gentoo.overlay/tree/main/app-emulation/qemu-mipsr5900el
> [6] https://github.com/frno7/linux/wiki/R5900-floating-point-unit-(FPU)
> [7] https://github.com/frno7/linux/issues/3


