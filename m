Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB2ECC6B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6Cw-0005ic-0H; Wed, 14 Oct 2026 17:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6Cq-0005f7-Kf
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:08:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6Co-0000pu-Nh
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:08:12 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbQln3813076
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 h50a/tgsvrye6JIUxvkHhgt2nbdqQaiCzjfzIbkXwPU=; b=dyNSK2pVkv4WMrRJ
 +QxanyygzHH4bYzaZnDge28lDs3iiW7X6ebAea8nCWBYAPP/0IT8A8jhOwlWQC1N
 y8PEM/UBSZ5scj0vxCiuZdBsH6oMYSCFGSvIu5hBNxfMzgSzAKCRlwSfhMFUVsrG
 6chpyDqnteAMa9AaxzodPhvGiovjVjz1ODep55MMVLIW15iJEEGUyRs2oZkFEqE9
 OnFVPpUNFnrt+W8CojmMDqHRFGC2EpePwQ+scZfjof3EO4l5aKiNcaUy4jw2ciPE
 dMNwleZOcUMrDTJTNgDxuAplpfYcaqubcQ3jh91A+BwJt0Edm7jo6PWR3Gn5Otp6
 NnFvhw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha46u3hts-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:08:08 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso8441241eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 14:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792012088; x=1792616888; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=h50a/tgsvrye6JIUxvkHhgt2nbdqQaiCzjfzIbkXwPU=;
 b=SIxGnkBrBlBg2zN+dMX5iNA3dBE1i1czYPS4ZqCDKn73qCmC45Js2quDLtmeaFhZwU
 lgWDIBXsbbmeZobZhJkBg+wifOtoZBH774mEmrzGIWSlljbRM2+ewZh8uNRGfkgR8xD5
 ADC4pJ4JNLLpZVxiDwT1Ok4/+ddHu3yw+nCKTdznlbpxbcSRn28msBNzc+I80s9t9gpR
 mFatP36SsR/q9ACFICptsdlbF7NNh3euccnX6zkGsPkPXm9ajSUUEERPtbzjs81N6JRu
 G8NGvgbXUA8fqJ8/Jf78+N58miGmnS1DmGKbmQh88f/RCWMAShPOIk0RIjoco4sy9yXb
 HHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792012088; x=1792616888;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h50a/tgsvrye6JIUxvkHhgt2nbdqQaiCzjfzIbkXwPU=;
 b=M3GkjX5EoKhAaAcYtv+OquvxFZvQhp5XNx+1Q5GufkLXlBvwtogwQRm9euVN+5KE2r
 Tlr+kiv4pxE09Z9HJy0cUkOwviSURd4Fmc/fGPMfiq6wCaUbF5gzetXBXUhSG4CQ4q4s
 m1NuNkaYKlME3orDCw7j15EvRUCP3tftVqamxU+w48GddC+Se8Yv5jGpf/ToqY47XAkZ
 A9TRqeJMc9ENJjD519vaui1eIlrirNDrm3LTB6mVul3QLi4i3WSDsIjgkcT87vCuuG/2
 npF3T1Bwpyfr7BRVf7e6hhDXlBgLkbBt1O8ubjIpcM7RI/MOWz/PLidCFL+uRRSGV37o
 i2Vw==
X-Gm-Message-State: AFq9FYIazZPos8LNUHFNPFRU2wYjbC3gszE9MsAjAT0ze1aI3lDMI4nm
 abcoHjkAG3RP+T8uPtzLddUchrWkV6alwiOr8R/L4ZHDElpxvYrYO//0NlvYDnqnN1otBN13k7Z
 yPwIcKNy6ArZFD6PF6E5t/3vM1ixWLiqTXX7kEh0ZJlO58fpiSCTISDSdC6vWViJuNQ==
X-Gm-Gg: AYBFou24qrtNyrBnsAGJq0R4OfocE5DE/kCZfsZZGqqonkp+9jrBExnWZqbGDfT2UlH
 Q4EaL30tSkdQVMgdrcIQGfnAKIvcZNV8bGrIjcAS8F+hnrGR28Db8thjZySEKK9zTVq2Z2p6f+K
 u5p7nTdLk6lHqkjeKR1TEN24RKfXdcCzEXd1BPv9vEM34BOPkja5BGVAc8QBbneBVTdTmj23Nbd
 +IpIddFSUIg6HI+fy7AVd5g7Jy3RhrikmjgzFxuHPg6qjZTEFt8Ne/YnGLgTI5CMhnsjaFeuuAk
 lmZzdKPI7BcrPECUIuvTXgznOyTo99WQla2L8cG5gSqSoeVzAwm0DGAV0vWunMoFIQm9kXXJnpT
 XAkLzXCNk81LfH+Yn4kU+tWZxd0EQL2cCbJ8iZ5ip3WmpCvIzkZPj2SLzXQIJUv7haH5tYw==
X-Received: by 2002:a05:7300:f408:b0:359:525f:74cb with SMTP id
 5a478bee46e88-359525f817dmr16056571eec.24.1792012085552; 
 Wed, 14 Oct 2026 14:08:05 -0700 (PDT)
X-Received: by 2002:a05:7300:f408:b0:359:525f:74cb with SMTP id
 5a478bee46e88-359525f817dmr16056482eec.24.1792012083617; 
 Wed, 14 Oct 2026 14:08:03 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35d872762a3sm10786341eec.22.2026.10.14.14.08.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 14:08:03 -0700 (PDT)
Message-ID: <54e594a3-b8a4-4213-8395-7229203fc77e@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 14:08:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] multi-target: add hexagon
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfXwaRxZdAHb5nS
 4lLv5YaZXDurH465KSqogCc7WSfV2EpOnn/qsyeii5FwYMr43/h9ONsi40LsUege8CCheR6Hfuv
 mJhvUS3Jt2utSmu57lvsxgGUv4ZFTM4=
X-Proofpoint-GUID: age0yLJB2VoPiZVEyMSyWHpv44xrwQaI
X-Authority-Analysis: v=2.4 cv=Y6ttIReN c=1 sm=1 tr=0 ts=6acfef39 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Q9RrAthI1Nh1P9Vuh0AA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX9n6Bdn7LKtMm
 wHZRDQnon5oVGMiALA6s1gIKg0yR7+WsHa9WlyZ+frIPEzN6lN3hRXPltjf7rc380oGn3EFOpTE
 3qi55vjdB0IJuGF6tjje12NKhfie6A9Lg4XxBvqsbc68MY9UCA+hCvosgin+z3h2m7FoLMckIb6
 aoikY7nrn01HLiokHOR96T+PjNOVtQ6HUkbcLjj93RYrXm/LAM3pPof6XBcAuBj6iPBnOktwLJF
 7RTnxGuEQ0idRDk+rCmSujblhtmBNKnkgcSxG2ik+2oMG1UpTssYkFVSb/8cZ93vyi0fQBgdfNC
 M0AmAw8SjXQQr4vyth28RXDWmxmxRHmfL90KXsvRVrarF5Q4Ad+45rGXCfcTBAOMB+3jWb9CiLF
 a/3SwfnGYz5esJlUQzd4thFB6hYuLwE0q+ChPM4yaV6OsZoFjEyJvUyEkYWpJL/Z2sdlCEEgBj5
 zbg0mfNonANqlqjr5tQ==
X-Proofpoint-ORIG-GUID: age0yLJB2VoPiZVEyMSyWHpv44xrwQaI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140084
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/14/2026 11:25 AM, Pierrick Bouvier wrote:
> This series makes hexagon compatible with the other ones we already integrated.
> 
> The biggest change is to introduce a semihosting interface, since existing arm
> symbols conflict with hexagon ones. This is also need for when we'll integrate
> riscv soon.
> 
> v2
> --
> 
> - rebase on top of master (one conflict with helper renaming)
> 
> Note: this series is fully reviewed and I'll send it as PR on Friday if there
> are no additional comments.
> 
> Pierrick Bouvier (11):
>   target/hexagon: prefix helpers conflicting with other arch
>   target-info: add target_hexagon
>   hw/hexagon/virt: make machine available for hexagon target only
>   hw/core/cpu: restrict tcg_ops to CONFIG_TCG only
>   semihosting: declare semihosting cpu ops
>   target/riscv: declare semihosting ops
>   target/hexagon: declare semihosting ops
>   target/arm: declare semihosting ops
>   semihosting: use new semihosting ops
>   semihosting: remove common_* functions
>   meson.build: add hexagon-softmmu to multi-target
> 
>  hw/hexagon/virt.c                   |  2 ++
>  include/hw/core/cpu.h               |  8 +++++
>  include/qemu/target-info.h          |  7 ++++
>  include/semihosting/common-semi.h   | 24 +++++++++----
>  meson.build                         |  1 +
>  semihosting/arm-compat-semi.c       | 56 ++++++++++++++---------------
>  target-info.c                       |  5 +++
>  target/arm/common-semi-target.c     | 29 ++++++++++-----
>  target/arm/cpu.c                    |  4 +++
>  target/arm/internals.h              |  2 ++
>  target/hexagon/common-semi-target.c | 26 +++++++++-----
>  target/hexagon/cpu.c                |  2 ++
>  target/hexagon/gen_tcg.h            |  2 +-
>  target/hexagon/gen_tcg_sys.h        |  2 +-
>  target/hexagon/helper.h             |  4 +--
>  target/hexagon/hex_mmu.c            |  2 +-
>  target/hexagon/hex_mmu.h            |  2 +-
>  target/hexagon/internal.h           |  2 ++
>  target/hexagon/op_helper.c          |  4 +--
>  target/hexagon/translate.c          |  4 +--
>  target/riscv/common-semi-target.c   | 29 ++++++++++-----
>  target/riscv/cpu.c                  |  4 +++
>  target/riscv/internals.h            |  2 ++
>  23 files changed, 152 insertions(+), 71 deletions(-)
> 

sent v3, adding const parameter to semihosting ops defined:
https://lore.kernel.org/qemu-devel/20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com/T/#t

Regards,
Pierrick

