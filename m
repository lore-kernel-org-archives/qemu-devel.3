Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C9DC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 18:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7HJ0-0000Iz-6i; Thu, 17 Sep 2026 14:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7HIx-0000Ig-4n
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 14:57:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7HIv-0005o8-5q
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 14:57:54 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HH5Lr91007377
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 18:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X6kHDgCocJ+JEbAfMeleyV2bUcLjmbHkhFGoGdLMnfs=; b=eoU3zgFssutkUD/O
 oBs0sWsW5pcT5h89gAZzpMH4mPERENN9TdQq3aoAGRCTAKPHRL78UhzFskgPSbPG
 SvPUoWlxHOHWwYO9Hpf4NLaelMWfHpz1XaiRjSp3c/6BXLUQrLHK0Nj9pSLv0TXL
 5rSXS07orPN72iUQKv+Mf8mrGuG9H/Nwf7u47JYE38cGOpmKTqD0O4XQDjx7Cn6V
 1JVf0zbaViSBD+9IpuT6Z+nnA59je8C4GdVM8rkM9BbOU6lOYgv5LU2KJIePMgUS
 SuLAws7f2X5a+2pWnFy9a1hVSUBHtrO7ePsKZBSeAo8PSjxTMF+WeR4MdFEpHmMO
 Uh3QQg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grjttryw2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 18:57:50 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39de1f85cb2so26459a91.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 11:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789671470; x=1790276270; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=X6kHDgCocJ+JEbAfMeleyV2bUcLjmbHkhFGoGdLMnfs=;
 b=Kw8ZHigcZDzvfnTU5gz37C/VORDW3nrlNt4Vr9B5RNCFNbespbAu8GlmzIj/50U/M9
 GfBQ5KeWPaD8amItYwac/cKowp24iOMYNGj8gDlgDljDDBzbl8hptyDg/JioUmjFxBQZ
 Xu6Tm15Z87FzmwXhQsooSdx7Y7cB5qUPhqVp7GlUrl+ogS7TmzRIdmuWh6vmTg7oTWz1
 W9QHg7pS0KcOJwhXjWzd6HMrIrGBSufDXx7FAvJraGwkoWMvoXgTKr779ZiKvu0Ze+jQ
 rFcaWtVE+H1izgAZ6sSDgUv9o4xCV5yrMcWkMMWo9AfxwXQfS2ZP2ZDYBsNO6cdvp6ZX
 5cTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789671470; x=1790276270;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X6kHDgCocJ+JEbAfMeleyV2bUcLjmbHkhFGoGdLMnfs=;
 b=p/uvgJkPpsrwNAsZouXmOzmBl22VHYTde/fn3ZyHKm+cNFWStqWjJTaApPC+NSL71M
 UhsQH5v6rFC8XUzwKr0guowulIWjIJDPsJK8hCAeLW4AZfVyDeRcnMNOfTkBGktoGXCK
 qjxArDO2e8e5MMKZ4kiP8clbm4nHcjT+BmUU9aEUr4cQo/2bORStf0UEoqDQqOBSZWq1
 1E38z6xtiwSKE7N47Pgc9oat9w4432pFpmjYU5JZ+w8HPqN4tbF3cnsFYyQ+CvQFrtc9
 xwu4b6drumCcF6ls6mKgu0iTLpY2sMIfiIGjvznR7b5JjCsJmGqxUA5zz+TWLMJ8OAUo
 6Ssw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxoiK2SoHxPIgFHdoWiseQ3EIduu3ANjRn6rLPoHzzYhTEBkjSrKNC0NTTV94ny+oSzYfGJa7RLoB/q@nongnu.org
X-Gm-Message-State: AFuF++kaKKvIp6d0SrXDc9tWybUEkI1aTJUcxzw2jwiROHgrV5D+yE4n
 Z0W8LzfZVkNa/NEQRbHgL14Penh//kGUAjcX5gBvYyCOTjGPcthhjPKCe2IwbLtJIHir+XA9W/7
 NAU/JFK59qWtJyb/6suOnISU7OK/ZjNjDwM04gAwdqJ5y+lV3sgeD+8CbLg==
X-Gm-Gg: AYBFou3W7fR+Ltk1kmxoaLHZys3u9YCRLLq0I0H4y0WRSykUkXZDGshsuo6rnPrle78
 tW2zQjO4kAyL76DrrRqPYz93Ob3uZp+kwrZzhP1Rn0HGwCG50/6x+udShzgI2OgpOg7brlMQMFx
 Ea3F8TvULfToxGRG0q2GTM3UvueMIFfp94Y2je2tfQZjdEsjCRV/mXLMsFSqKd5AFqc+blh42s7
 2nhcgcPvZDBfUv2fKv8d6Ey2A/SVUaXdPUCjYQXVRQzEYXqCLCX0SWm/SK4qOVKx6V8bKpZ0WUG
 bjaF1nGCP04lJn0DgFNN/+9WTwEehaNcPel9fqZoP1LenxzH2PETWmcJO89YaJVAbnM3MZo0NYf
 To1GPdv0NfX0g0vlnkMlakgH2KR/VqQ1pE/megRWXnY7WEf4MXOxLLp1nkq7tBme6x1v8
X-Received: by 2002:a17:90b:3d8e:b0:39e:2065:5f60 with SMTP id
 98e67ed59e1d1-39e54f9d37bmr188516a91.18.1789671470081; 
 Thu, 17 Sep 2026 11:57:50 -0700 (PDT)
X-Received: by 2002:a17:90b:3d8e:b0:39e:2065:5f60 with SMTP id
 98e67ed59e1d1-39e54f9d37bmr188471a91.18.1789671469465; 
 Thu, 17 Sep 2026 11:57:49 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d76834sm14649044c88.14.2026.09.17.11.57.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 11:57:48 -0700 (PDT)
Message-ID: <5b56381c-1a05-4359-985c-1a6ff5a60d72@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 11:57:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts: update meson-buildoptions.sh
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20260917185322.3457036-1-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260917185322.3457036-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI3MCBTYWx0ZWRfXzVN9UgioUx/P
 vjJRVAeTBQ8ikubiI+6025Vdi6nIZO3KKqCcRary2UpldAuWgSlqDI4Zv2Kpcog2fC5g+xP9vGy
 /0UVDhWBJqERTku+FP30CFjC8Z7s/zfQI6IGZRC/U46WHblFdgECKNW75m6gRx2gLIgRkOT+h1r
 s96T/1jam7OpZe3fIsrmG4cif5f2opX4AjG5ab5+BBq5qp4CXUsQ63FP59olKPEMiBFVfJl9SWA
 q6hnzrnrxAlDgd3rj6u8cPAciUcvd+FsIxMVV0GMCcdHtmSTRhWyaeeo5t6nGc9DfehoL+ASnb7
 Rf9wsImHqZOV++1TcVuWwJKIWhGVmWYOeWMxHtkFLV1UBYIyWb1dT93Y4U0ZXyoxRerZQ0BtsEG
 SREpwSBebQX0HaCXglwPaJS2WSB3kFVndQR2h4L/oqVLrc9DUVwZrXK99lBrN+DwuQmbRj5Gapo
 eCxOVzXpJcqtyof+u7w==
X-Proofpoint-ORIG-GUID: 3gcxRey09cOT2VRAzvHD1qCoocVTeZuI
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI3MCBTYWx0ZWRfX3bS8i13AK7Kg
 ZyQ3B78V5FX+u73KwYPf0UZdevEtwfoHYPA9Rg+1cCn0FKg/vvNNTbbk60wq+o6Iqxu3yabDbIK
 5DcZPcqYyjefZcnMGuk6j5/w3tZeuzY=
X-Authority-Analysis: v=2.4 cv=IP2XmQvG c=1 sm=1 tr=0 ts=6aac382e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=mKO_3-t5Na08OfwPOfMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 3gcxRey09cOT2VRAzvHD1qCoocVTeZuI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170270
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

On 9/17/2026 11:53 AM, Alex Bennée wrote:
> This wasn't run because the automatic trigger is fickle. We don't want
> to expose all the tcg-test-cross-cc options to help as we already have
> processing via --cross-cc-ARCH so we tweak the CONFIGURE_HELP filter
> in the update script.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> For PR:
>   - I'll stack this at the front of the PR I roll tomorrow.
> ---
>  scripts/meson-buildoptions.py |  3 +-
>  scripts/meson-buildoptions.sh | 54 +++++++++++++++++++++++++++++++++--
>  2 files changed, 54 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/meson-buildoptions.py b/scripts/meson-buildoptions.py
> index 9e3a75c8b11..a2bfff9c4bf 100644
> --- a/scripts/meson-buildoptions.py
> +++ b/scripts/meson-buildoptions.py
> @@ -56,6 +56,7 @@
>  # Options that configure prints help for, so we can skip
>  CONFIGURE_HELP = {
>      "gdb",
> +    "tcg_tests_cross",
>  }
>  
>  # Builtin options that should be definable via configure.  Some of the others
> @@ -194,7 +195,7 @@ def print_help(options):
>          key = cli_help_key(opt)
>          # The first section includes options that have an arguments,
>          # and booleans (i.e., only one of enable/disable makes sense)
> -        if opt["name"] in CONFIGURE_HELP:
> +        if any(opt["name"].startswith(h) for h in CONFIGURE_HELP):
>              pass
>          elif require_arg(opt):
>              metavar = cli_metavar(opt)
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index ba3c9de216b..4ad8c1c5d35 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -10,7 +10,10 @@ meson_options_help() {
>    printf "%s\n" '  --block-drv-rw-whitelist=VALUE'
>    printf "%s\n" '                           set block driver read-write whitelist (by default'
>    printf "%s\n" '                           affects only QEMU, not tools like qemu-img)'
> +  printf "%s\n" '  --container-command=VALUE'
> +  printf "%s\n" '                           command to build/run containers'
>    printf "%s\n" '  --datadir=VALUE          Data file directory [share]'
> +  printf "%s\n" '  --disable-containers     use containers to cross compile tcg tests'
>    printf "%s\n" '  --disable-coroutine-pool coroutine freelist (better performance)'
>    printf "%s\n" '  --disable-debug-info     Enable debug symbols and other information'
>    printf "%s\n" '  --disable-hexagon-idef-parser'
> @@ -195,7 +198,7 @@ meson_options_help() {
>    printf "%s\n" '  spice-protocol  Spice protocol support'
>    printf "%s\n" '  stack-protector compiler-provided stack protection'
>    printf "%s\n" '  tcg             TCG support'
> -  printf "%s\n" '  tests           build test suite'
> +  printf "%s\n" '  tests           Build the test suite'
>    printf "%s\n" '  tools           build support utilities that come with QEMU'
>    printf "%s\n" '  tpm             TPM support'
>    printf "%s\n" '  u2f             U2F emulation support'
> @@ -282,6 +285,9 @@ _meson_option_parse() {
>      --disable-cocoa) printf "%s" -Dcocoa=disabled ;;
>      --enable-colo-proxy) printf "%s" -Dcolo_proxy=enabled ;;
>      --disable-colo-proxy) printf "%s" -Dcolo_proxy=disabled ;;
> +    --container-command=*) quote_sh "-Dcontainer_command=$2" ;;
> +    --enable-containers) printf "%s" -Dcontainers=true ;;
> +    --disable-containers) printf "%s" -Dcontainers=false ;;
>      --enable-coreaudio) printf "%s" -Dcoreaudio=enabled ;;
>      --disable-coreaudio) printf "%s" -Dcoreaudio=disabled ;;
>      --with-coroutine=*) quote_sh "-Dcoroutine_backend=$2" ;;
> @@ -518,9 +524,53 @@ _meson_option_parse() {
>      --disable-tcg) printf "%s" -Dtcg=disabled ;;
>      --enable-tcg-interpreter) printf "%s" -Dtcg_interpreter=true ;;
>      --disable-tcg-interpreter) printf "%s" -Dtcg_interpreter=false ;;
> -    --tls-priority=*) quote_sh "-Dtls_priority=$2" ;;
> +    --tcg-tests-cross-cc-aarch64=*) quote_sh "-Dtcg_tests_cross_cc_aarch64=$2" ;;
> +    --tcg-tests-cross-cc-aarch64-be=*) quote_sh "-Dtcg_tests_cross_cc_aarch64_be=$2" ;;
> +    --tcg-tests-cross-cc-alpha=*) quote_sh "-Dtcg_tests_cross_cc_alpha=$2" ;;
> +    --tcg-tests-cross-cc-arm=*) quote_sh "-Dtcg_tests_cross_cc_arm=$2" ;;
> +    --tcg-tests-cross-cc-hexagon=*) quote_sh "-Dtcg_tests_cross_cc_hexagon=$2" ;;
> +    --tcg-tests-cross-cc-hppa=*) quote_sh "-Dtcg_tests_cross_cc_hppa=$2" ;;
> +    --tcg-tests-cross-cc-i386=*) quote_sh "-Dtcg_tests_cross_cc_i386=$2" ;;
> +    --tcg-tests-cross-cc-loongarch64=*) quote_sh "-Dtcg_tests_cross_cc_loongarch64=$2" ;;
> +    --tcg-tests-cross-cc-m68k=*) quote_sh "-Dtcg_tests_cross_cc_m68k=$2" ;;
> +    --tcg-tests-cross-cc-mips=*) quote_sh "-Dtcg_tests_cross_cc_mips=$2" ;;
> +    --tcg-tests-cross-cc-mips64=*) quote_sh "-Dtcg_tests_cross_cc_mips64=$2" ;;
> +    --tcg-tests-cross-cc-mips64el=*) quote_sh "-Dtcg_tests_cross_cc_mips64el=$2" ;;
> +    --tcg-tests-cross-cc-or1k=*) quote_sh "-Dtcg_tests_cross_cc_or1k=$2" ;;
> +    --tcg-tests-cross-cc-ppc64=*) quote_sh "-Dtcg_tests_cross_cc_ppc64=$2" ;;
> +    --tcg-tests-cross-cc-ppc64le=*) quote_sh "-Dtcg_tests_cross_cc_ppc64le=$2" ;;
> +    --tcg-tests-cross-cc-riscv64=*) quote_sh "-Dtcg_tests_cross_cc_riscv64=$2" ;;
> +    --tcg-tests-cross-cc-s390x=*) quote_sh "-Dtcg_tests_cross_cc_s390x=$2" ;;
> +    --tcg-tests-cross-cc-sh4=*) quote_sh "-Dtcg_tests_cross_cc_sh4=$2" ;;
> +    --tcg-tests-cross-cc-tricore=*) quote_sh "-Dtcg_tests_cross_cc_tricore=$2" ;;
> +    --tcg-tests-cross-cc-x86-64=*) quote_sh "-Dtcg_tests_cross_cc_x86_64=$2" ;;
> +    --tcg-tests-cross-cc-xtensa=*) quote_sh "-Dtcg_tests_cross_cc_xtensa=$2" ;;
> +    --tcg-tests-cross-cc-xtensaeb=*) quote_sh "-Dtcg_tests_cross_cc_xtensaeb=$2" ;;
> +    --tcg-tests-cross-cflags-aarch64=*) quote_sh "-Dtcg_tests_cross_cflags_aarch64=$2" ;;
> +    --tcg-tests-cross-cflags-aarch64-be=*) quote_sh "-Dtcg_tests_cross_cflags_aarch64_be=$2" ;;
> +    --tcg-tests-cross-cflags-alpha=*) quote_sh "-Dtcg_tests_cross_cflags_alpha=$2" ;;
> +    --tcg-tests-cross-cflags-arm=*) quote_sh "-Dtcg_tests_cross_cflags_arm=$2" ;;
> +    --tcg-tests-cross-cflags-hexagon=*) quote_sh "-Dtcg_tests_cross_cflags_hexagon=$2" ;;
> +    --tcg-tests-cross-cflags-hppa=*) quote_sh "-Dtcg_tests_cross_cflags_hppa=$2" ;;
> +    --tcg-tests-cross-cflags-i386=*) quote_sh "-Dtcg_tests_cross_cflags_i386=$2" ;;
> +    --tcg-tests-cross-cflags-loongarch64=*) quote_sh "-Dtcg_tests_cross_cflags_loongarch64=$2" ;;
> +    --tcg-tests-cross-cflags-m68k=*) quote_sh "-Dtcg_tests_cross_cflags_m68k=$2" ;;
> +    --tcg-tests-cross-cflags-mips=*) quote_sh "-Dtcg_tests_cross_cflags_mips=$2" ;;
> +    --tcg-tests-cross-cflags-mips64=*) quote_sh "-Dtcg_tests_cross_cflags_mips64=$2" ;;
> +    --tcg-tests-cross-cflags-mips64el=*) quote_sh "-Dtcg_tests_cross_cflags_mips64el=$2" ;;
> +    --tcg-tests-cross-cflags-or1k=*) quote_sh "-Dtcg_tests_cross_cflags_or1k=$2" ;;
> +    --tcg-tests-cross-cflags-ppc64=*) quote_sh "-Dtcg_tests_cross_cflags_ppc64=$2" ;;
> +    --tcg-tests-cross-cflags-ppc64le=*) quote_sh "-Dtcg_tests_cross_cflags_ppc64le=$2" ;;
> +    --tcg-tests-cross-cflags-riscv64=*) quote_sh "-Dtcg_tests_cross_cflags_riscv64=$2" ;;
> +    --tcg-tests-cross-cflags-s390x=*) quote_sh "-Dtcg_tests_cross_cflags_s390x=$2" ;;
> +    --tcg-tests-cross-cflags-sh4=*) quote_sh "-Dtcg_tests_cross_cflags_sh4=$2" ;;
> +    --tcg-tests-cross-cflags-tricore=*) quote_sh "-Dtcg_tests_cross_cflags_tricore=$2" ;;
> +    --tcg-tests-cross-cflags-x86-64=*) quote_sh "-Dtcg_tests_cross_cflags_x86_64=$2" ;;
> +    --tcg-tests-cross-cflags-xtensa=*) quote_sh "-Dtcg_tests_cross_cflags_xtensa=$2" ;;
> +    --tcg-tests-cross-cflags-xtensaeb=*) quote_sh "-Dtcg_tests_cross_cflags_xtensaeb=$2" ;;
>      --enable-tests) printf "%s" -Dtests=enabled ;;
>      --disable-tests) printf "%s" -Dtests=disabled ;;
> +    --tls-priority=*) quote_sh "-Dtls_priority=$2" ;;
>      --enable-tools) printf "%s" -Dtools=enabled ;;
>      --disable-tools) printf "%s" -Dtools=disabled ;;
>      --enable-tpm) printf "%s" -Dtpm=enabled ;;

Looks good to me. Good idea to hide tcg-tests options.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


