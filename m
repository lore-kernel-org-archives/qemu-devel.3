Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F55C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 18:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiFif-0000Ud-Gz; Fri, 10 Jul 2026 14:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiFid-0000UK-1v
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 14:12:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiFia-0005Ax-QN
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 14:12:58 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AH55So1407282
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 18:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3kswRUuNIGIPNOVlVMT3M7ixSyvsxJDJCdHVCTCPMGQ=; b=U+PF5Mor1c4BVxRW
 z5kmBfxId4FA4mDfyPpYibKn4blwKOo9b9oHiJGnoJXHoFyPD74Ozg0x0XJJX35t
 TK/srjwHyA/sATpa6HKOTB8qu+kKcNMh8Vd83xpvJTQCd/r+eUjssq/VsITBMHEu
 xy2fYM9oRbTfn27kAbKChuqgOKr3gPeDVmvxjo9ODNRl00iSlqcOjtpkVLHunXDx
 MeUUTKw1AIPcveI734NWXp/9zmNBEqPZjVdBWdS/fZYe76O8RRVobMUoVsB8GHPV
 LKt53NM3k7YxFflO6bUgEirDg0guwlNj284CcfvRxKOhK77yItCs9mA6stKyKrtI
 gPi3uQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5f9x0y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 18:12:54 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38c7de7baf1so1325057a91.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 11:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783707173; x=1784311973; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3kswRUuNIGIPNOVlVMT3M7ixSyvsxJDJCdHVCTCPMGQ=;
 b=MA4tX40xHwaCR5q1/i7Vi/FcRjGsdl16YyJusz0mr6blfJ5rPKJFqY7O7HNEdLoVmu
 Zrgd2qLBPEnFx8lhuFv4xbYmzibN1I90gAP8d+661nw06rxIhv7PusK+XIJKLXnUuE2y
 NFB2By5at9Hx4g6w+6f0Jd0AqTbSCws+Zs5fjDlXdI0pEBSENzxrTx+ZPL5/c63Kz4w9
 VG3GB9JkfUSQ56estwfNswDjd0uD1CK+JfnFrRm5e07c6RFcy3nsLC/EtMWCqhLj4QeO
 88tF3iVf8L2as+Oj92YSqluC4wrwFofAzLKwPiD2VJdSdBgQBVeYwi8qY8/NRuLcbnZQ
 8kGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783707173; x=1784311973;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3kswRUuNIGIPNOVlVMT3M7ixSyvsxJDJCdHVCTCPMGQ=;
 b=U6PmEUDN+rDzHCnpIr3/8+v/yS7vk+GqCaNUJ0rNUndG0JJ45J32F5SWedpgqBUH1x
 wZ2KB+Vpk2XfHVUTeKxU35uHMSWc1qq73P9aGdOT4iYx/k3ylsqy+3uhLGD5DiwSnyoq
 e7e/yFWMmjJwirQa775XJhvlHGP7y6FARV9sVaiKWoj+b2zM4aVpjOa3E7koRsa1APa3
 zUbHSKN5NEb8N7GByL3kl4pvrFbr2OXCEAzQbQyX/tsqrwcx2wjvaoW+0E3BahTCc223
 Ds35YXMnXqeUWCsHBgVv372xhCjbWKCR7L/SkP2PVswIPOuT7iiDVwhnzwlSBlWed1Y2
 sh2g==
X-Gm-Message-State: AOJu0YyLSDrPWWdn1eJfjhb5+m+e6jim0BefsdxtfOaY3Hzrgf6VDykM
 CFXA/JQxiJd6KqG29o8bqk6J2iHAjBa5FzmdejGkuLS3I/Gvbk1EQRmIGnsC/JaP1Gd7xPGTowL
 Zs39ZRSx7Afu0TTw3HvfmXSMebXZ1HxpzNUKs8N2iO4pr0Bk5JStgBR0LmbnVaV+IMg==
X-Gm-Gg: AfdE7cnpEbYDnaTnB21QHBjMZTb+rfeeyK/S1VD2k06ha/VLXrJkg1EcEAVb0gEocxP
 5XpR+ILHyJ4ECV0GoK7A+6j6+rjbtdGwEvEhJbJeCCxphDpkpCiU7lRPmxyoezmfYMlUUCibBTU
 moNCdncBiN/uhqPFNqfnhb3owwT3SkkQEjkEcQMb6sa49eMNVgCNJR8wOw0ivJlEz5CyOe4uTv9
 673OupUuuLfWZlfG49JQILi+TVIBkGirTIRYItJToCzAZLkRlvXeTljEBTZ2OOKCwgkAwoLeB3Z
 AKGwv1kE/qD+oJHBmmjsIqcZZHzXkRPsweVSfdo4q1L6PLuS2AIR0XchWdmNSO9lJpQLLHp+7p/
 CRmh6C6Z0fEc2f6laRUE0GqMGdnb0qJA8ti/Ix/lrTYYDSFCu6EmVTKudWIzu9q8fTdBRKo66k0
 zKVG4=
X-Received: by 2002:a17:90b:2d4e:b0:385:393e:7124 with SMTP id
 98e67ed59e1d1-38dc7847bbdmr46095a91.14.1783707173044; 
 Fri, 10 Jul 2026 11:12:53 -0700 (PDT)
X-Received: by 2002:a17:90b:2d4e:b0:385:393e:7124 with SMTP id
 98e67ed59e1d1-38dc7847bbdmr46070a91.14.1783707172519; 
 Fri, 10 Jul 2026 11:12:52 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313b3206aaasm7624526eec.13.2026.07.10.11.12.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 11:12:51 -0700 (PDT)
Message-ID: <79ebf178-063a-49fd-8cdd-f29317f569b4@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:12:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 95/97] tests/tcg: remove Makefiles
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710062016.1818125-96-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260710062016.1818125-96-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ab2B2XXG c=1 sm=1 tr=0 ts=6a513626 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=32ggs3lF5JV5lGpjTxAA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: _JJzCSuqsu0Xnj_I6qWdDhb5w3yuUkpQ
X-Proofpoint-GUID: _JJzCSuqsu0Xnj_I6qWdDhb5w3yuUkpQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE4MyBTYWx0ZWRfX0vUvfZoyy2El
 9O6T5AZFGCmjAwkh2vloCVIv6kJUvsJB0FT/6fyfi2YsLexVlGGuEodvgzCuNTVTrMC4TrjWPFM
 1L345y4nXUgT8nGn6NnrVmrCDWgmhjU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE4MyBTYWx0ZWRfX6NHH0Hd8gUZY
 lq5z6O2HJ1VoYVR4mb9mgzg0ZK1846YzRADb/1FDlTyOHaR+XhUbSv/YtqWN6Z7Wyy8tiwBDUD1
 DhsODh0xP7ap+cLxIfPmP8RfG+/WSybfFnc+6FXoRBOPtJ+isfTYoAq7Byu0DJ27VA2qFZg1Jlv
 auPsdCDLWK/0QDonRtJeMsjETypov1ma9ma/jiVCltfKPKmUGUWUOivDdJY+MyIUBC2UW9weXoe
 /PkBD54BHST19rUF8Wyy6rAAsPF+whZuSB/yPFj8Ct9ZCr8gS1pvcYGs7BPkIAsUah6FFKjnww6
 f8FC3AbXfLc+furQZD9z8iVJYrRM+n8+gXS26tWJzBMb9f5X4NCqrlDOXLnB+Uu+IT3RjG96NV1
 LXkoLA5iUV0uXKXPuD55a5/z2oNdTqyulFwuM/PYgRDb511dndJ/gJTtS2z9CKBotmUAlyJRDnX
 YL2kqUxfWFS1F6YV52Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100183
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 7/9/2026 11:20 PM, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---

...

>  delete mode 100644 tests/tcg/Makefile.target
>  delete mode 100644 tests/tcg/aarch64/Makefile.softmmu-target
>  delete mode 100644 tests/tcg/aarch64/Makefile.target
>  delete mode 100644 tests/tcg/aarch64_be/Makefile.target
>  delete mode 100644 tests/tcg/alpha/Makefile.softmmu-target
>  delete mode 100644 tests/tcg/alpha/Makefile.target
>  delete mode 100644 tests/tcg/arm/Makefile.softmmu-target
>  delete mode 100644 tests/tcg/arm/Makefile.target
>  delete mode 100644 tests/tcg/hexagon/Makefile.target
>  delete mode 100644 tests/tcg/hppa/Makefile.target
>  delete mode 100644 tests/tcg/i386/Makefile.softmmu-target
>  delete mode 100644 tests/tcg/i386/Makefile.target
>  delete mode 100644 tests/tcg/loongarch64/Makefile.softmmu-target
>  delete mode 100644 tests/tcg/loongarch64/Makefile.target
>  delete mode 100644 tests/tcg/m68k/Makefile.target
>  delete mode 100644 tests/tcg/minilib/Makefile.target
>  delete mode 100644 tests/tcg/mips/Makefile.target

>  delete mode 100644 tests/tcg/mips/user/ase/dsp/Makefile
>  delete mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/Makefile
>  delete mode 100644 tests/tcg/mips/user/isa/r5900/Makefile

Philippe mentioned to me that those Makefiles were not currently ran by
check-tcg, and it would be nice to add them.

They require custom toolchain(s?), so I'll add a dockerfile for it and
integrate them to mips user.

Regards,
Pierrick

