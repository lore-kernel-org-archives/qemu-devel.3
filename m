Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D40C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgr0q-0004Xy-G7; Mon, 06 Jul 2026 17:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgr0p-0004Xo-5Y
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 17:37:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgr0n-0000XR-61
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 17:37:58 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE88D1478347
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 21:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iVqOzfCbuJIAdO3bN/2oXaEvqv6FexsOZ2G8jCPNZkg=; b=O+lvQhSSRF+k+LP0
 /GWepnOXK9av9OzXc1e9+Bj44BDPhchmipJ20ofPQCSw0TOb3h30TVbeYFE5/GQ+
 D1OK1s/5PCNzqLVRk+sye8uCJ9C2AU+6GgaKCUHnjR5OFKZn6ymoiRRTIjW7wyQb
 KPNFCvzLC3q3riMN9zAS1MZaME54un22TZEhzsx+tQgzWk3V7gWw5G7l3QkT/5WL
 3FO+5VMHfguTQexGK0MX1y4FNQSk645apezHyJ7ja9D50UewAEaWyniuoT22V8fR
 EXsWPjK6mVLIZG24Sj/i+fk1ys4SipvLuB61bgvwcVUpsAkhRhnashlwX0K4nLBa
 +8PYDg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hsbf2m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 21:37:54 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-380c178acfbso3035998a91.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 14:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783373874; x=1783978674; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iVqOzfCbuJIAdO3bN/2oXaEvqv6FexsOZ2G8jCPNZkg=;
 b=IF0aB/YZADth23Ox55pRIdHjXgQdTfWk8cc/OFDSxD5cyvggbbXoANhrl0kONZPUTG
 A9wLktJvp1C1IGTyPipFXSSqSQnWMUKfS4w/o+RmsZ/Ihf2S3dXMZSHrm9hmn3Evz9kH
 9uRRPOipi06KzUmbJ+cYe595PlLZI8h3sfiDrzyzKGinFiwR2Go4ScX58Y+cxbxW2DVw
 mTvr8BfzVRN7QxTKMkAf8xXpWSG6dejIjfOifhBiQ7ZFKijHHH4/fknznd7LVtZ+PDzn
 ARJRBHG41SPTT+nzb75zh4HYXmVyJPxpLxEzVZy0aB4kHwbagtLGpJz72qso3X+Tat5a
 08mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783373874; x=1783978674;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iVqOzfCbuJIAdO3bN/2oXaEvqv6FexsOZ2G8jCPNZkg=;
 b=HzsjAbXXmz/Vn4iPker4LA/usu+hrUVfRYgKEs0VtGb5lxfFeUW3xXxvYrCimgZzgB
 tds6ytqmQrHjPSPYvZ4nVvOa8NlET1f/eE8xzedJEzgH8DiGLMiMEIo0Ihbueqlx2CUC
 OKZDJh2gdoIU2QlFJunG9Vy9q13XpmzHZVIQfwzfRllzTPZsObc/9bAIExmYDsiBNivd
 L6xm+tfMC4LtP67E414VOfEP6ILUT2c9nHNz+i5C2FRDj8kNNS0ztwho5zlHsF75ZGtT
 x1VL+536JC0p63DE+qmDsvCC1fU2aO3yT7YOEV3gUNnyHIZPe6qD5i2Sl/4b8H+Oqsnh
 4Z3g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpSQloQZF3JCqSgLJZ10E3eRw3AShQN+vZVGergmyhGTnWw3jb/bh2Dx310MY+Fs329jGCJfc6g8DXs@nongnu.org
X-Gm-Message-State: AOJu0YwUxFm+1YYvBC6lpEffZu0KqooU4H+LsnKNniPpmTEgPDDJUZuV
 FZZtyHPSgGNmeiCjO9jZStzKE5Djk1J3l8hmGaIhF8oEh9MPGT/fyXYxiPMSOBAJoO+bol3N3XM
 GOiyZQLpXb5zEZoEBR1jCJORzHKp+Sryg4OH09xLg1jjBZ6aUJsDQNRGjOg==
X-Gm-Gg: AfdE7cmdxggqm/y9elywF7UPuMj+KcH1txB02McjU2wJdSQMUpR/L8L9Qx07XX7fDjv
 fypmOYik13Ro5EVYjyVGkx9f0PTy+PnPHN3EkAYzwxh2J0EEg7HVYe7IOXOe6eT8uOkd6txAEnG
 ocZ2xm382nYAGJLxYgbk+LI8qQIUJV/DtGq7nr9HBqacI37jnZ3mP9co9Y/iTYRtGt+6xQEkrzq
 aG4+E7ZVf2I/KiEssJJZ9OHEvBkvalTERMRtjTvzcnKcsbsLtNNU/vRDiXgXsgVnCHx9V24cOP+
 EAZjHMrl1KuTPJ3Egz8t5KjjSBHhsg/R2hVrHGIWH8zg5PSi+AloghomnqDsmIrYMhn/ltqbcgu
 /lzboLIeOjaqxNkuItVZgZJTUTBI9+Kvi32nnuka8cDj6xAz8pX8LpmOUCkBTddQOHnJtq3WyMw
 9caDo=
X-Received: by 2002:a17:90b:57cd:b0:375:2a38:1d40 with SMTP id
 98e67ed59e1d1-38756ce1486mr2180043a91.20.1783373873894; 
 Mon, 06 Jul 2026 14:37:53 -0700 (PDT)
X-Received: by 2002:a17:90b:57cd:b0:375:2a38:1d40 with SMTP id
 98e67ed59e1d1-38756ce1486mr2180012a91.20.1783373873321; 
 Mon, 06 Jul 2026 14:37:53 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174a56848sm557994eec.16.2026.07.06.14.37.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 14:37:52 -0700 (PDT)
Message-ID: <d39030ab-abc8-43da-a613-1b401e3fd4a8@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 14:37:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab-ci: Fix macOS build by using bison from homebrew
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
References: <20260706211336.11131-1-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260706211336.11131-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GY64RYt06OTOwCFUBuDY8933cg5ZufV7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfXziAit41W5qQO
 cV7M4NWFjH6pvpz+wkLcHnkBICebqR6kUl9c2WnHY3PCa+XWaow1+ZhMNjq4xp0WV5TwRlkJtw/
 7eC1+wuNxQzg1ZcyeUnssjXBYxtTyaC+0S3PLOABTMhMl1IJch320k5265boJcAngCYTv1xd0vB
 aES9iQP6qVygc1pEpfENU/GH0HyuAw9sciIDQueoIlI3HuuR+7W6E9+avhCsdxln0OB69ODl3xw
 slsgRE7RhoyNNnI47PI8PIHka+Fj/iCBCwMT0nBMOdtgekCp35ay1Eop9+TmCoYVZVgw2cYPTg5
 o18l3n527jRIziWO+nILQv1VSggvFwN7LsWHFSU15oJKHj3+j1PBwJAtSHN02KRxkw0d+ekZ7UD
 LJTIYKZD5PCENdOTateh0USeO3MVWn27RYUOjCDN8SLTwBrQ2jdNN4K7kE7uG1c47DMk+r5mESE
 SxqQlUF+P94NQ1l6jzQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX3xqW1q76qkU2
 tOI4vwnMFmHYMmVLTqWbliAa+au7LY6y6rLuVo/xN3JG0vZ/jXWQDLhz+Gv9WF0P0BFspz5Qv5v
 DZ6qGWsj/+Oyhe4JZRPbZNojhXCMeyE=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4c2032 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=6m9FYdwIFc1E3M2I2PoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: GY64RYt06OTOwCFUBuDY8933cg5ZufV7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060218
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

On 7/6/2026 2:13 PM, Philippe Mathieu-Daudé wrote:
> Since commit 6beec3bcdaa ("target/hexagon: add build config for
> softmmu") we build the Hexagon target by default when system
> emulation is selected. This commit introduced a hard dependency
> on the 'bison' program for the idef parser. The binary provided
> by Darwin is too old, and the build now fails:
> 
>   $ ../configure
>   python determined to be '/opt/homebrew/bin/python3'
>   C compiler for the host machine: clang (clang 17.0.0 "Apple clang version 17.0.0 (clang-1700.6.4.2)")
>   Program bison found: NO found 2.3 but need: '>=3.0' (/usr/bin/bison)
> 
>   ../target/hexagon/meson.build:300:8: ERROR: Program 'bison' not found or not executable
> 
>   ERROR: meson setup failed
> 
> Since we use a lcitool generated vars file, we already install
> 'bison' from homebrew, but we don't have its path in our $PATH
> variable. Add it to the macos.yml PATH_EXTRA variable which will
> amend it to the global $PATH.
> 
> Fixes: 6beec3bcdaa ("target/hexagon: add build config for softmmu")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
> This however doesn't help macOS users ... They need to manually
> register the homebrew bison path.
> ---
>  .gitlab-ci.d/macos.yml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
> index 53b6e6c4d8f..3a9e5f46702 100644
> --- a/.gitlab-ci.d/macos.yml
> +++ b/.gitlab-ci.d/macos.yml
> @@ -37,7 +37,7 @@ aarch64-macos-15-build:
>    variables:
>      QEMU_JOB_MACOS: 1
>      NAME: macos-15
> -    PATH_EXTRA: /opt/homebrew/gettext/bin
> +    PATH_EXTRA: /opt/homebrew/gettext/bin:/opt/homebrew/opt/bison/bin
>      PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
>      CONFIGURE_ARGS:
>          --target-list=aarch64-softmmu,i386-softmmu,x86_64-softmmu
> @@ -54,7 +54,7 @@ aarch64-macos-26-build:
>      QEMU_JOB_MACOS: 1
>      NAME: macos-26
>      DYLD_LIBRARY_PATH: /opt/homebrew/opt/expat/lib/
> -    PATH_EXTRA: /opt/homebrew/gettext/bin
> +    PATH_EXTRA: /opt/homebrew/gettext/bin:/opt/homebrew/opt/bison/bin
>      PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
>      CONFIGURE_ARGS:
>          --target-list=aarch64-softmmu,i386-softmmu,x86_64-softmmu

It seems like to be a classic issue on MacOS, given that the base system
comes with an outdated bison version. The only idea I have to help users
would be to explicitly search for homebrew version in meson.

It should push user to do something intuitive:
- configure returns an error about bison version
- user check which bison is taken, and which version it has
- eventually googles this and finds it needs homebrew version
- user install homebrew version
- configure is now happy

It does not impact other OS since homebrew file won't be present.
It leaves out users with custom path for homebrew, but I'm not sure a
lot of people try to change it.

What do you think?

--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -297,7 +297,7 @@ if idef_parser_enabled and ('hexagon-linux-user' in
target_dirs or
     )

     bison = generator(
-        find_program('bison', version: '>=3.0'),
+        find_program(['bison', '/opt/homebrew/opt/bison/bin'], version:
'>=3.0'),
         output: ['@BASENAME@.tab.c', '@BASENAME@.tab.h'],
         arguments: ['@INPUT@', '--defines=@OUTPUT1@', '--output=@OUTPUT0@']
     )

