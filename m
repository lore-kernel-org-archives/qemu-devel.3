Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5D5CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 17:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNvwM-0006bi-R7; Fri, 15 May 2026 13:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNvwA-0006Wt-BR
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:02:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNvw6-00074e-RM
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:02:56 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FBCU5g656082
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:02:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3Bm57uo1qVNMGj2vE9moZO3kD3cA/1KYeqT2XZWpjOc=; b=iZZLo02BovU0+whI
 at7wxXQHCfZkbfWJu6Xi97nfxGwQQk3DBZcJo25wRCrN3Y5pCtDEsSg+fh6VyR10
 ACBHF+lF1ltBSQBiJTm0yi9oWWNcXkA6TfHpva1Slg8Aqmlza8ar58P4CyjGuu0U
 7i3W0+4kb70HfTMGdBq/9iyFKZ8NrQzGh5iwnKqHnIULnKnS6HOV8b3CZ3ycA0gR
 BgYRKq7Ah1X602+HAiG4eyYM0/MsbwSM8+5YzYpXnbXXQphDoUYbP7N2WewlpAQb
 kAKkrrVj4D5+UeiQRRsv6BNet5yhHh+yddHUc9iRoCz3ljBy8xuEr/d6JABkGFZX
 UEW2PQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1pv6eq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:02:52 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-134cf343c58so5127347c88.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 10:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778864572; x=1779469372; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3Bm57uo1qVNMGj2vE9moZO3kD3cA/1KYeqT2XZWpjOc=;
 b=jfGOirLRCIOATDb8G4LfyYhLbOAnX41zGCbTt6blhnc9Un57byXQ7h+H3INmMliFM8
 h0VS1HD7Rs+3h7ALqT3Z6AsoQWW0nrgnM/GjtGBUY8XwEO1Ga+5fnF144VU+zVWa9AuY
 2eXFCJxpzbr8IJXGTD3EnlNnTDyfJD31tnRk4c8w53EzfwxxrW+MsBChWGtj4cbgRJhl
 ELKIK7MvOZHgDZOzaxfY7IfOdOiYF89b/qZicRFZjl8KRQKhPlZbk2YHcp8acAh9ff0Y
 V7imcJ4U4IxUClqvEbv0uNwCLKu+xY9h44RgyeLRbk9w1hFWufcqHvV9gF/Dfwt38UDZ
 RP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778864572; x=1779469372;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Bm57uo1qVNMGj2vE9moZO3kD3cA/1KYeqT2XZWpjOc=;
 b=Q/4wvEsKfwnyfdaZPdyLK+szMYNewbfUgfC/2PSKvQBUsijEkWwvKxtQ2vjHk/jN9D
 IWNlNh6JPHGSvVhiHKylQaqWOYr3WOIKGLUc7T83UsFbcGwPkJLotXNvNe07IsTuYSRK
 6gNWOGiC+QKXij7LkotMSUzvhJ8BfhQT0TFEWWBg31uhK6pzb7fiaC6jMdUXy64avFFU
 6z3MwHnzPjc3Sk6db6wi7LhGLI24C63CzT9ruwQU89Qos/t8OD9twdX6BDMeFtv83hA2
 M/yY8g7yrH0hlWrla5ddcb5GZWIvWuOpSZsDXhB00Wf9tSV+JiKj9q6D3vKBwKuumLxf
 26dw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9nhxlomUzzNgbG3haD6Z+o0FZZZ9WKnHRKDP6I+NDgEJaqQ/FYeYeVA7Sh+NWHSTm8dE+qrRwYmaYy@nongnu.org
X-Gm-Message-State: AOJu0Ywk5pjw2kQ5xFWzbEPwZGNMRfpkexs6ZQYa+HFYtsTG8X1ybmwZ
 lsGiowv0JW5lAFIfrm9YrJCaymYuvdNFL2OfonGpRJ/KW3OfR7vhIOQ6dguNdkEbC1N262PnHS8
 gnc6QSosruT70KHYYFTqMETOlmGIP4HwLp0uhkFGQsQyqev42uVN7Hj7vWw==
X-Gm-Gg: Acq92OHk5Av+ux5WnQlOBZBnS2A2yD7E1yZ85LK/wxqPb20nlpQciBwcvQPzw3BoZ6x
 /Ql5OTZQV9qI3WwP5JvbXgtTy5t9OyBOi2B8UfjUcXJnpaBLlVfzD9cf4ysnsE4dHZS2yLoQ9Es
 Vka30AR55hFRBBABxbtpdlCOAAvC87m1xhCQ3UQWc+/A/BZ/+E7M8r3mGVYVt83qiT/kAJ3PJDK
 pJcYtuLjADqunrDBckIQQL8sq2ai/+hmutOqNPEWnz3USeD7/1SwadE2d11LNUM02ebJkkQ27hN
 piIXw8RCf7uAyrOhabYx4eb+pA9WnuI+LpkZu6rQE1IbNSSaSsOufjqIjFiK5faw22dbnJHUhW4
 opw6aSsbQRHIKa4kju4bKFxYZcwfhFc1yQ1QcH7W0KRgmU61Xku91EdV4zW5/mZgW/wT8RwxTf9
 ijWsHwAkm2bXEXwg==
X-Received: by 2002:a05:7022:922:b0:132:7ab5:6cb8 with SMTP id
 a92af1059eb24-13504311c97mr2466457c88.2.1778864571853; 
 Fri, 15 May 2026 10:02:51 -0700 (PDT)
X-Received: by 2002:a05:7022:922:b0:132:7ab5:6cb8 with SMTP id
 a92af1059eb24-13504311c97mr2466340c88.2.1778864570906; 
 Fri, 15 May 2026 10:02:50 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cb5b3c20sm10870424c88.0.2026.05.15.10.02.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 10:02:50 -0700 (PDT)
Message-ID: <c0ed787c-ae69-4fd9-b62a-4147aca5365a@oss.qualcomm.com>
Date: Fri, 15 May 2026 10:02:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/20] single-binary: Make hw/arm/ common
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goate?=
 =?UTF-8?Q?r?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260515141032.3271-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kWGLNpJ9f5VEiI1FFViTr3JrmoBiFYGD
X-Proofpoint-ORIG-GUID: kWGLNpJ9f5VEiI1FFViTr3JrmoBiFYGD
X-Authority-Analysis: v=2.4 cv=GrhyPE1C c=1 sm=1 tr=0 ts=6a0751bc cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=180z37m1I2dKjCq-j5MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3NCBTYWx0ZWRfX8Yo2Mt/jKfLH
 2tJcYfb/PyPWDGEYeKBASFp5AiOIYhis/0Vm1wsc2nwL73qSBOpJSG7J2P+LGbHeEacm9J6VhmA
 AzdGf9oiqiui7O0aM0NHisIo+U2tERH3NOBHE5lXZw/L08YLe5xwivFfuSeE+Wmz9/TiC5cOlgt
 hGBVj0Y95EhYNsJPSt0Lp2Wlf7l4pSdbZhZrVammwaIFUHT6LJqd/YgMNn8zlkl4qXG7b4H4zDo
 LxQXUcD7tB+YIdXteJX7bl4vzuEU06ph1Ah1ScSKlpFF7SOsK/+Rw9qXMg6gs3nY49ZfM+ADi/C
 A3Rj75MjPmTeWpdyNZbT7K57C165VH7ee5g2NFvgqC3Eq5aq6jTVcqn79N9A4fzgMAkSvf2Z4lw
 uxSlyDW2Kl/9MX1JF3CSTnziHKk7pFcmzteF8uOllIlHuJP3mMFABE2m3XSkUmIflSOE7AB9RSi
 TCqvvAre1+Oxh6fEUVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150174
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

On 5/15/2026 7:10 AM, Philippe Mathieu-Daudé wrote:
> Since v5:
> - Unify 'max' CPU type (rth, pm215)
> 
> Since v4:
> - Add DEFINE_MACHINE_WITH_INTERFACES (Zoltan)
> - Use GPtrArray for get_valid_cpu_type (Richard)
> - Define InterfaceInfo[] arrays (Richard)
> - Collect R-b tags
> 
> Since v3:
> - QAPI structure renamed as QemuTargetInfo
> - MachineClass::get_valid_cpu_types() runtime
> - target_aarch64() checking SysEmuTarget value
> - Remove CONFIG_TCG #ifdef'ry in hw/arm/
> 
> Since v2:
> - More comments from Pierrick addressed
> - Use GList to register valid CPUs list
> - Remove all TARGET_AARCH64 uses in hw/arm/
> 
> Since v1:
> - Dropped unrelated / irrelevant patches
> - Addressed Pierrick comments
> - Added R-b tag
> - Only considering machines, not CPUs.
> 
> Available here, based on my pending patch queue:
> https://gitlab.com/philmd/qemu/-/tags/single-binary-hw-arm-rfc-v5
> 
> Philippe Mathieu-Daudé (20):
>   hw/arm: Build ARM/HVF GICv3 stub once
>   hw/arm/raspi: Initialize 64-bit CPU types during DeviceRealize()
>   hw/arm/raspi: Build objects once
>   hw/arm/aspeed: Initialize 64-bit CPU types during DeviceRealize()
>   hw/arm/aspeed: Build objects once
>   hw/arm/meson: Remove now unused arm_ss[] source set
>   target/arm: Introduce common system/user meson source set
>   target/arm: Build gdbstub64.o as common object
>   target/arm: Build cpu64.o as common object
>   target/arm: Restrict IDAU interface to TCG namespace
>   target/arm: Rename Aarch64-specific methods
>   target/arm: Extract common code related to 'max' CPU
>   target/arm: Use make_ccsidr(LEGACY) in 32 bit 'max' CPU type
>   target/arm: Implement DBGDEVID* registers in max AArch32 CPU
>   target/arm: Only set %kvm_target when KVM is enabled
>   target/arm: Factor aarch64_aa32_a57_init() out
>   target/arm: Re-use common aarch64_aa32_a57_init() helper
>   target/arm: Define 'max' CPU type in cpu-max.c
>   target/arm: Build cpu32-system.o as common object
>   target/arm: Build cpu-max.c once
> 
>  include/hw/arm/armv7m.h                    |   2 +-
>  include/hw/misc/tz-msc.h                   |   2 +-
>  target/arm/internals.h                     |  10 +-
>  target/arm/{ => tcg}/idau.h                |   4 +-
>  hw/arm/armv7m.c                            |   2 +-
>  hw/arm/aspeed_ast27x0.c                    |   7 +-
>  hw/arm/bcm2836.c                           |  14 +-
>  hw/arm/raspi.c                             |   4 -
>  target/arm/cpu-max.c                       | 241 +++++++++++++++++++++
>  target/arm/cpu.c                           |  10 +-
>  target/arm/cpu32-stubs.c                   |   8 +-
>  target/arm/cpu64.c                         |  92 +-------
>  target/arm/ptw.c                           |   2 +-
>  target/arm/tcg/cpu-v7m.c                   |  11 +
>  target/arm/tcg/{cpu32.c => cpu32-system.c} | 191 +---------------
>  target/arm/tcg/stubs32.c                   |  10 +
>  hw/arm/meson.build                         |  15 +-
>  hw/intc/meson.build                        |   2 +-
>  target/arm/meson.build                     |  26 ++-
>  target/arm/tcg/meson.build                 |  60 ++---
>  20 files changed, 349 insertions(+), 364 deletions(-)
>  rename target/arm/{ => tcg}/idau.h (97%)
>  create mode 100644 target/arm/cpu-max.c
>  rename target/arm/tcg/{cpu32.c => cpu32-system.c} (80%)
> 

It seems there are some tests failing, and build failing also (on
kvm/arm with aarch64 host):
https://github.com/p-b-o/qemu-ci/actions/runs/25923481301

Regards,
Pierrick

