Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21648C531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 20:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn01t-0001OS-T9; Thu, 23 Jul 2026 16:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn01s-0001MY-BS
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 16:28:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn01q-0000iG-Qr
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 16:28:28 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NImAMk974742
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 20:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ac/7nHSoQqwpi2S6FYhMwBHVpDNizEOLIobP2nFzNm4=; b=WQqMrA40LW48PaVF
 LU79rueCzWrdImmNdry+KI9eDZPtcar1SqCtWB2GLYi13NPzYHb/iMgHo3o3MaBI
 E5Slq+eI7FrZDLhf8/KsEuxUuFr7YdhNU5J7kbwSUpWj8M4P07Oy13Abtjyc9EQz
 S04vuKM92BSpWuvRa1O9yvWE0UMZdkDKEQ7LJAEQ5y7Fox2GhgCEVETB1r6bm2t+
 yJcLo1mPe7fkyNF/hSMDzbQ6Vh9XgxqKSrQ9StQJQYb7RIV9FLb6e04IbLOOcNa8
 kd6uSd2LWnC8OvK3A9aZ4RFS+blO+LcHDWhpB075Q+GvoqixRFhN1b3VmtH17OxY
 U4wSGQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqa08pda-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 20:28:25 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e8e864ef0so1922750a91.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 13:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784838505; x=1785443305; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ac/7nHSoQqwpi2S6FYhMwBHVpDNizEOLIobP2nFzNm4=;
 b=ZYbwgOO0oRMm8aju1IS0c9V3/KExJlIFOOsfFmK1r6slRV/ls+Tv0rJztooYvNruX/
 mM9YQezOV42okObSbVGnN9IOhPBNDShHX159RhcoJZ5ZOvrVvfqXQMnRnan1BGPAYiPP
 6cQH8eUSZPV08TjBq1q/aOnEnHMMK1tJ77NgANNBP5oE4CSDjNkqTC5Pal09SYqN4E+1
 Llp35OhdPAnLnStRfR6e/4Gab1K/SYLJCj6Cl3oyHAqBYEi0fDY7t25YIws/fErc1UFs
 sLc24Tq0QxfhrlhREIoEuTBTIHqoNrR364w78sAZtS7L2AH6VmC9rqDPLvG1Ly3L36z9
 /jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784838505; x=1785443305;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ac/7nHSoQqwpi2S6FYhMwBHVpDNizEOLIobP2nFzNm4=;
 b=kPueQLGdVYQuHqUEtfS+IuQqbV9CcOn180LjI3yjkXIOV0OT0CMbIAI9HmklXPmoKK
 5fXXeVJ301UEQ26pF5gYx7+mOPjx9IGnTLDiUncpvP05Si9RLrbUQh4T41m8aFu7RuuR
 3hpfnPhtJCPlqxJtSFu3aWoHGsdoKUB/Ml7qFLNioKP10wh6Dzg6mbHNrAOvW2WKlNYL
 PCpPmBSVfoD+CFEX4wHZp8frES4xbuCAPJXWf7G+E2hWEtiyvxxCJiVA+9JxktwLYDE2
 ZvG5TvuVnBEItK8SRhHWmXFhUl8isFxUleXCdq1CoU2jExKiN6BCT9EjX2J200o5ChbY
 59wg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+Un2XoP2Fp5xVSgsn70GRHsnmhzptptpkjzEI0eM0PjxwiuK3TabNCB2XNM2IgJY5MsPF43OF36Ll@nongnu.org
X-Gm-Message-State: AOJu0YyL1kf4azvb2qGwhUrk2c392It9BWR4wxAqbn5UVPRsKm9HPWI+
 QHD8PYjhrSarZls1T/04QFhIeGIzRZixgnw0qUH4/bmg2f4NRqKWRTpKqdlkhqadEZv09lPMmDs
 a0eg5b/hDlWHabhYtx3R/zivNi8hCSnKPNDHMnY9SWz/D0/XAz2fsft8cAw==
X-Gm-Gg: AR+sD10Rihq31oHEwNCum5eRQHwCEDs6KgC1rdMy+zY7uq0c+SwEWlld+gB7Gk3NzHJ
 40c0SMqI94GC+P7Kms/Wqwpu7SBmJm0K1VsHRgSVW3kE6Z1G7YbxKVxUi0XRUZXU2di9/lDt5dw
 YdTFt8CVH+SO06yhGFBJRW+xZbbLU1LpEDVyINGKOvkcu6j0s5HZpwl5bacXWYN9MRP8zJDJUZn
 8M0D6GpL0xPrukEV8xqsQgQL1iDYQKaoQKeqYbaHPJax8rbC2AdO7z0jTBELZIEeWc/WrD+EZsi
 WW4NzAaJfDnptmGR3FtrlJpkE7FSlAPtNWl4tCnYIVeKX5fQQAeOjPVBxyk8c5QEFtxEqs2192M
 oiqwnu5uRKq9IVXZGHRg3vqQlx7xVmpISdWTY6KHHH2GCd622cphbTMu+yp9mH1Fn2Lud
X-Received: by 2002:a17:90b:1cc7:b0:381:f7a:2e0d with SMTP id
 98e67ed59e1d1-38ec66379c9mr4101177a91.33.1784838504577; 
 Thu, 23 Jul 2026 13:28:24 -0700 (PDT)
X-Received: by 2002:a17:90b:1cc7:b0:381:f7a:2e0d with SMTP id
 98e67ed59e1d1-38ec66379c9mr4101153a91.33.1784838504039; 
 Thu, 23 Jul 2026 13:28:24 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13002f39sm19123362c88.1.2026.07.23.13.28.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 13:28:22 -0700 (PDT)
Message-ID: <5dcda48f-1e8e-4d4d-ad74-85302f82bbaf@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 13:28:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tests/arm: add explicit CFLAGS for system build
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>
References: <20260723200904.224413-1-alex.bennee@linaro.org>
 <20260723200904.224413-3-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260723200904.224413-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Iq1eNumvBvwA4vVhnse342MEe4TsuRez
X-Proofpoint-GUID: Iq1eNumvBvwA4vVhnse342MEe4TsuRez
X-Authority-Analysis: v=2.4 cv=e/k2j6p/ c=1 sm=1 tr=0 ts=6a627969 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ALCCpff1BQAnXA4x45UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE5OCBTYWx0ZWRfX02bJxn6iNJ2e
 RcgH2s2YGdxF8SW+fjF66bHak7LBQBnzx2CcrH+q41uUw9lXjEHplauV7A1qf7x2n5DVe+dN23R
 Oa1ZZmALs5iHrMZQffTu4BrjrQhOVX4u0KeLILXptJGE4ZBuGKFglYZKAEkGuwpMC6T9FAijUo4
 b960tHAcJ+UanwxMqrOGsvt45HMSfHbnX6Jpd/rNwgyti6WhrwgHA82jCLFMx84FGUorGZz/HbR
 9a+1zVbCNRl+AyDdehx2eO3anzfKtGAG4YQuH85/gF6+8dF1BQNS2NG1/IT947tMb/mIdJbPYgV
 kUV1RBGWbJdW53rJJrVmOTnMpmghpxYWdNkT3anYY09bALWF+05PjJ2ws7Ru050rbUlwlI2+NbL
 P3JsXkxNLEen8llBf5sO9h53Y56jNfPUrDK5We21WHS/w+6w0GQw+3AcoFxVxPC5IJJaCCN+AZb
 yOv7UJ/+9eyJHoI1e8w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE5OCBTYWx0ZWRfX0QjsLCbXh1An
 VKNbV6qVGN1vmzuKFgN5MKiIFUKtPeNiubPuoA/abfNjw30wicwAzegY3UXgM/nZrbCixx3vnCf
 O5qudjRyPTvEuDbz5+sSv+ke632GgIE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_06,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230198
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 7/23/2026 1:09 PM, Alex Bennée wrote:
> The brew toolchain on macOS (arm-none-eabi-gcc) is a little different
> from the default on Debian (arm-linux-gnueabihf-gcc) as a result it
> defaults to an older architectural baseline (without isb's), assumes
> softfloat and will get confused by including stdint.h without being
> told it is compiling freestanding code.
> 
> Make these all explicit so we can build arm-softmmu tests on macOS.
> The test-armv6m-undef is unaffected as it has it's very own build
> stanza.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/arm/Makefile.softmmu-target | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

