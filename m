Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8214ECD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 15:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU52Q-0001Q4-1G; Mon, 01 Jun 2026 11:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wU52I-0001KO-2y
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 11:58:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wU52F-0007Qv-Hs
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 11:58:40 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651F4cD7145078
 for <qemu-devel@nongnu.org>; Mon, 1 Jun 2026 15:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lgPS1Aokeutc0awr2iH5UOBGjTYHZGfCMKVKhPP/HOs=; b=bQoap3qklYcYeRZH
 nxe8Ig+lhxk2rS2aspE/YaVftC6EV05fJdB4bM9c5wEtWh5W6r/tuIXLk1AX+ieV
 /WN0XHFEeX12Ia61Hu8TKPAgyTISg8BBvVuhXGQTt3NOixgutZGYG8Tnib//8y7q
 KPeMYPWK/wNnjO3WShRUrVJxgnwyW1sxARMZmE9oabsOBcgbWjuyHmD5Fnw1BVqW
 /L09ZCx04tn8TJgxiFD6sXOnIW+z9OQzvRkC6QqHNhGN8mjlkqlt4kgWMcFb5IWw
 +A7Yvb/IGYEDbA7frYQMVFNJpNygibGAKRlX3dBF/shMr1DTy9VjIfGdktzTzpeA
 92HoAg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6stsra9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 15:58:38 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304df51ff3eso4290545eec.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780329517; x=1780934317; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lgPS1Aokeutc0awr2iH5UOBGjTYHZGfCMKVKhPP/HOs=;
 b=JZlFQer2ZS3eTxkhj2IXKAtkTUPF/GN+KTMNVVzNpw0ytPZSm5A4LvDUorG5H1aEYy
 3e3jOf1JUycCTOYaLyzaG3nRxF4aegr/qGH69g/i48jxCRRFLouUj85E7V0jgA/pVYhB
 ASIE2In+G39PSAR/jqppYVpndNHUPpZ7UFR7njXyqNf5uc+1M4oz7+7ssSQg7j4+Rmpd
 AsZIB+ShDreVRpQIV0GO6Q3Yd951hCWQDAMDmXDIz6OdE0NlH0MgMO+ykyjq10RTlqIu
 3vCEKcMnI/9bWLQQgHRXkr+P9/GY3CNo7uAh0SdXE/2Qyrs+jRsZKdUUqM85p9LFdJ9A
 Ve3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780329517; x=1780934317;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lgPS1Aokeutc0awr2iH5UOBGjTYHZGfCMKVKhPP/HOs=;
 b=q5dBoU8Am/jSlN0502OIvAN0WlMV3IqVBvcfJEV86b1MQZP9MZx/i7zQpdy7FIPGS7
 qyqoSYpNBaILFyYnP4n5PP8KLTqGECidDZiyo8P3Tu+LYvTfaznWStVC9z85KpJAmtU1
 tamR9OwxdG1vfuqvMnVGhxxQw0xV5jWcta3gUoMh+L5ZWfRUrxO9E4J69Jq8boq6yy99
 SZqTJHbLiRgdfBx2molw1EUS0lH/tcxUqnVGWXBKLH+r1iHuYbEUJpRukp/WW4ZUkEtc
 ZYzAh6Vckg/M8F+GvizARIKZzxZAWecBKPrZfymyeN8o27TtNlLPvx3DsasShPEzcXqs
 ccFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ZRjnsoP3m8R8FtP/HmqBESRJ1hbGPt86v0Z9LTzdYBZRCLzLhyO2lz358048F7hvJa/MGSoBoEdRk@nongnu.org
X-Gm-Message-State: AOJu0Yxr7JGALO/DuywnzeQegWngtwfsxeZOPo5s5mlTfR5QEYSurtXg
 aTpaFGOzjgvUzsbKNhGUqnxNoPPNKqkEHxU6XW4vX3IeJXn6IS8byxiAqgNBsFyKhmxFA9TVeRB
 XZ0yYKn+ARuWfH2wdd3sOBXqXEe450YqwpYYsI2Z5mr2WYgZxn/afgz0x6Q==
X-Gm-Gg: Acq92OGy2YDUMMkR4IR2E09mKRPhJFx7tg8weVQAOCTye+2aiCGo/iDdrn35lcqgojj
 VQgy2twMnlXPF7nzAvIAcspcqIFYhDQZOlLUxTD2OP6vV0IQMrOgchJHjay8Z6Bfq1vuaiIQ9np
 3DCDhxqMdzg1mPQYfAWqYR3b0kI86fQSynSsb2p9pabJNZxImjycUt9MQPZS+91EAroEMLsGQNK
 0yqFJrcwTnLqtvdC/4XGiHhUE7XHHRt5O+QCKfABaLYoyNAW57K9UnMOEFGiuI9AiSx91Byl1Wd
 /1n/bus4RyWMPsoHRSfxFA+r4G/aCCfVhHTMravnsbfGGKZbwQlHHvVJE7joj74vuhMsEkLU5i1
 KGg5M3Bdp1GfB/PMGoRWvC//g3qGqESJsfl334oMJmqKyRp8I1KiPdM4PfLGlQXBEkBCX4Lwy09
 JZW10efJ59Ukke49FUw4k44otA
X-Received: by 2002:a05:7022:61b:b0:134:def6:e73f with SMTP id
 a92af1059eb24-137d40280c5mr4553202c88.21.1780329517497; 
 Mon, 01 Jun 2026 08:58:37 -0700 (PDT)
X-Received: by 2002:a05:7022:61b:b0:134:def6:e73f with SMTP id
 a92af1059eb24-137d40280c5mr4553179c88.21.1780329516957; 
 Mon, 01 Jun 2026 08:58:36 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b36c6700sm7056007c88.6.2026.06.01.08.58.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 08:58:36 -0700 (PDT)
Message-ID: <57d0477a-3bbd-4948-8e18-33df41991545@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 08:58:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] gitlab: work around the inability to build targets
 for MacOS
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Kyle Evans <kevans@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, John Snow <jsnow@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Brad Smith <brad@comstyle.com>,
 Warner Losh <imp@bsdimp.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Cornelia Huck <cohuck@redhat.com>
References: <20260601143129.144786-1-alex.bennee@linaro.org>
 <20260601143129.144786-3-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260601143129.144786-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE1OSBTYWx0ZWRfXx8WjJwortsNN
 POwAmILI9sP5hAQFDynBufw9gRp4tGsoMXCFg9eC5qIa6LAMJZZ0E4fE3Jlhb0Z573uA4RGgfY4
 P34nZ+vkLmnMapBjLYW4huT+KkYwo6oEqdGnkKEfDov4VrnioB0PO5Ft1mbGikNlGw1HvCYDsS8
 Fpa4pwXxbL4YOHjMI/BdOQapC/429F4m6yrOEPouWa+TQ//QFWIghaISK+Wdx/MUmk97G3/CDtD
 37D3uqtie7J7NQodDbLjDLwx65bHl8gVntGyY2A+QcL8duuQ4lh7YAR4m/QbjWG2EEfk/DfyyMe
 bdP/61HvMy6/JhjKA/OVs7OFIkX87x8M6R4ElWhmLhAe0sHkFjmkkr7XkzHyMUFYiTyJB005i/3
 PbmZFPiFYEhffYu9+jS2u5Zs3DWTWpaAcd0OJCgUPJslXwJh/qRSfanaRfsSLvI3yPoerwbkKUd
 q4svao4/G6e6O621gtw==
X-Proofpoint-ORIG-GUID: 6zvKOWRz7hH1N0vyHmEgw0o9k4DhKzHw
X-Authority-Analysis: v=2.4 cv=HrNG3UTS c=1 sm=1 tr=0 ts=6a1dac2e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=YHQvgl54SCjNhz-QoLoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 6zvKOWRz7hH1N0vyHmEgw0o9k4DhKzHw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010159
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

On 6/1/2026 7:31 AM, Alex Bennée wrote:
> Unfortunately a previous fix to ensure .ninja-goals was set for the
> TCG tests broken the ability to run check-functional-FOO. As we have
> now reverted we need a solution for the MacOS gitlab run. The simplest
> is to add an explicit make invocation to build the signed binaries
> before we run the tests.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .gitlab-ci.d/macos.yml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
> index f61750a3f4a..8366b4ad564 100644
> --- a/.gitlab-ci.d/macos.yml
> +++ b/.gitlab-ci.d/macos.yml
> @@ -29,6 +29,7 @@
>      - cd build
>      - ../configure --enable-werror $CONFIGURE_ARGS || { cat config.log meson-logs/meson-log.txt; exit 1; }
>      - $MAKE -j$(sysctl -n hw.ncpu)
> +    - for TARGET in $TEST_BINARIES ; do $MAKE $TARGET ; done
>      - for TARGET in $TEST_TARGETS ; do $MAKE $TARGET ; done
>  
>  aarch64-macos-15-build:
> @@ -44,6 +45,7 @@ aarch64-macos-15-build:
>          --cross-prefix-i386=i686-elf-
>          --cross-prefix-x86_64=x86_64-elf-
>          --disable-plugins
> +    TEST_BINARIES: qemu-system-aarch64 qemu-system-i386 qemu-system-x86_64
>      TEST_TARGETS: check-unit run-tcg-tests-aarch64-softmmu run-tcg-tests-i386-softmmu run-tcg-tests-x86_64-softmmu
>  
>  aarch64-macos-26-build:
> @@ -60,4 +62,5 @@ aarch64-macos-26-build:
>          --cross-prefix-i386=i686-elf-
>          --cross-prefix-x86_64=x86_64-elf-
>          --disable-plugins
> +    TEST_BINARIES: qemu-system-aarch64 qemu-system-i386 qemu-system-x86_64
>      TEST_TARGETS: check-unit run-tcg-tests-aarch64-softmmu run-tcg-tests-i386-softmmu run-tcg-tests-x86_64-softmmu

Could make all be enough?

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


