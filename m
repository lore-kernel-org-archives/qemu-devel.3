Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D799CCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEYI2-0002uF-4C; Wed, 07 Oct 2026 16:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEYI0-0002td-1q
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:31:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEYHy-0003uN-EC
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:30:59 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697JNLMf1025055
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 20:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZjUrALbScEQ9SA9Vr7/e3cLxcjliL3E/uYbUUAuZWD4=; b=MnBIZEhaDrKOv/gG
 PuOC6i4qeOKA8WjSMhnUqM9RSDINISRZ+uxmsM0Uaq8LSM+oKImDhnbUO4BUNdDO
 OAuTZiEzJBRKK1pomIckYRyKuabDaYFzOUkR9bmaztZTLj/irKw+BU6SavitNX0P
 Z+V/+CgJG89BzHLVvoBt3tBs7ClVizjbHdLLOGT+f6Olz0KgLc62fDmu/t1IBkF3
 KSByurErF72Oy7OrxCrSReLQQjpSW5PVMhleYhYBxfB620u4fppeJQ9d+EVRKn+l
 3bX618g5SPDpwCUmg7u/3EjUDokTLBP3gZ8CYd+eZ2ILObANVcx8R7somUJqTNXc
 M3L6Wg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5td40q6k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 20:30:57 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3510a481ae9so8611131eec.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 13:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791405056; x=1792009856; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZjUrALbScEQ9SA9Vr7/e3cLxcjliL3E/uYbUUAuZWD4=;
 b=f8sQ3AUKpjYWvAfT2TzihMOXjQI78h43qP57vQj2L3GkEL4UYyz9L6q/H70Jc1fbWo
 LtnK5WEJYhFCbj0y//dzT7QyfuqDQGjG1e01w8ne1McuZgv8Z5ubm4H9xxX7PV/AMenb
 AgfujCI99a2hhYdM4cv5Z3BKyi0SzC3+/m8R23H6ShkY93eBI1fM83tuP1wP8sqg+J8L
 9wJ+D37+4jW1Wm9pDYsTj8jMTmK8vmKXL3e/eBRlZ3QCcA3wtolWrooQGSuJ1njSmN6J
 hHPr64HeuRD7celxvwzYUiL4gK8cUrsF3QTD7JzYujhhCMlpDMuSBbncSzUYLIVGLIKD
 b95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791405056; x=1792009856;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZjUrALbScEQ9SA9Vr7/e3cLxcjliL3E/uYbUUAuZWD4=;
 b=t6yH6fGqXi4ykncmT+GB7KkeM6N5e/QK2uYuTSaSvg2SFE87buaOy6NO+3H0WCqJFh
 g7VE35qvVs+Kel0FL3t86CQY2rr1Oo9aMMrI6G0/9zue1jn/PDcPZvzPf9WQELYdQx3T
 yYuE+Foo6swlx1sQPEmMEbSIGNeIRQxsZpcwhGmNko4Hey7y0Na3XVGOYm48umQHV8II
 piZ4IT12LZWmV1EMWSTAUudH3wrFgLfz9P0MViAly9v3U1saui8K5SFu4LONo5mjyToy
 tfnhiX4IQLZbAPeRXEmkG2/l3DebkWDj392HurZdyo9URmYoBbmaforPoESt61fSKXCm
 stXw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtn39xyUzuvfAsa2WHNPhYIbrsjtxhEn15DQN2kaAD86+IiLzqrx4Er8dj3jQlxHKMH58PTzImNTJH@nongnu.org
X-Gm-Message-State: AFq9FYLRnYvJVgfzH+z4b6jY0HadHwQ0Z/kNoYEr9MVjXmyHCMvfprJo
 eQVkXkjNCmDSp2PJ+EjYbj3+KkxZ/aD5DCFzdkExxpkjjI1Bk36kltJHXg3EAKPJKABfS95UJmb
 2iMmpx4PXVTAfilcbbbJIA7XM/1mBh9jWXeFKelBTjmyn70sCdawMLRx5pw==
X-Gm-Gg: AYBFou3lPYAGJJU/uFTXZlNc1tSqI8U1y6bZD1lB1K72OoMN62zWLfa0Xpyx+FjRZ6O
 nRuUTalMVs/Na/9ZuT0wpvlh5Yw6EnRQoBncY3/+m7j7rj5hz1+/8MtffiI8WHmjf4F5H4oQS2w
 5U0NFBYeS2rkdddZSEAfn6eoHAxjniobbR8yQq6hIljwey5AkRp0Yq9dTw5bVAD9e4M5MBKjzA9
 XhabiDDYC7mgBiq8GBlIodkUGy6tXWV+9Dzq/fGCLbxU1qs4wZm0JsU1MUx77y9wCcH+GB1TEUt
 8hQ+ZHPTFr+cpSKfb9J4vaJC2P19eyr6WTNb1K/7K+tPy3JYiQNRl97P5CJ3LOMBqtuCxN62wHR
 qI31JHPWsT14ioE4OHunrPXySmoBcNDMxx7yXbZoRTNx/MqLDy4G/IQgIdgLI8D735Cx1JQ==
X-Received: by 2002:a05:7300:2a92:b0:351:672:6803 with SMTP id
 5a478bee46e88-3515ddfbb82mr3913924eec.22.1791405056048; 
 Wed, 07 Oct 2026 13:30:56 -0700 (PDT)
X-Received: by 2002:a05:7300:2a92:b0:351:672:6803 with SMTP id
 5a478bee46e88-3515ddfbb82mr3913857eec.22.1791405054630; 
 Wed, 07 Oct 2026 13:30:54 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515a8b7c5dsm10409062eec.0.2026.10.07.13.30.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 13:30:54 -0700 (PDT)
Message-ID: <8e38b5a7-7f1f-4b16-9e72-063e26120da6@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 13:30:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] meson: load all target .mak files into target_mak_all
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Stafford Horne <shorne@gmail.com>, qemu-arm@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Alexander Bulekov <alxndr@bu.edu>, Darren Kenny <darren.kenny@oracle.com>
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <20261007115253.328-7-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007115253.328-7-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SAa8NZGIeiXz6MtBhz1sGwjJL3EZqO6N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA4MSBTYWx0ZWRfX/JJUVrrJxZJH
 sGumhqf2RUi90ij4L72KE5zv2XXsSHgcTXEpcJJoyWEPuqGo15F4QspY1xz8GtcOROIXvxbqaCv
 nR5VxNX+/eWqqSBryQTwnziZJh1vVG7sh5apvGmokkMAawEXJsIWwfzRWugKtcbywvegJKZTi2Y
 48jTJevFgYCPpHUBIcmy+5pNa1VsFKm9i0Kt9MVcKsx7jDmL9DTCBuecwnwHGeg/J9Ry1u5jKsL
 0GQQ4GsVATEBnJ90iG/aTotST4Gqd8Q47nZmOJuqxNz3kL6BpzHmMY5yhGnZCsFOtqQCcUOUZuN
 FvE6ZqW7tLq+JgEJIKcDlAYGU6GaC0CeqRgdzP7UAQfQ5o3B3G7eI6QmZnGz8knQI7P2ln7g3lp
 ovbZaweJXzht9ZFAUiwm6qw5pkSI6fUlvSr1/EEmiiUM8QfPkD0Yr7CIk7nMnNYczL788Aiu+DH
 4DN3OErZN7CCNKkwTDQ==
X-Proofpoint-GUID: SAa8NZGIeiXz6MtBhz1sGwjJL3EZqO6N
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA4MSBTYWx0ZWRfX7LH1KhJba7IO
 NKrrJv088UhuLLoubtAriVcaLIP9H3I+dpyyo+TgQr5bGeqc0kY/vutJugx49BIp/WdqHk6tGFv
 T/UcTQYRvy3Hvv7qrwIUGa8SJgnmPSM=
X-Authority-Analysis: v=2.4 cv=NY1zRGD4 c=1 sm=1 tr=0 ts=6ac6ac01 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=yNdNqd1FjBS0SJpvGbQA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_06,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070081
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

On 10/7/2026 4:48 AM, Yonggang Luo wrote:
> Load every configs/targets/*.mak once into target_mak_all, keyed by
> target_dirs_all, with TARGET_BASE_ARCH defaulted to TARGET_ARCH. The
> per-target loop now takes its config from target_mak_all instead of
> loading the file again.
> 
> target_dirs is still the --target-list filtered subset and is the only
> list built. target_mak_all is for later use by code that needs target
> properties independent of --target-list, such as generating
> TargetInfo helpers for every target.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  meson.build | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index fd7a4f68389..d070dafe2a9 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3239,6 +3239,21 @@ config_target_mak = {}
>  config_base_arch_mak = {}
>  config_target_info = {}
>  
> +# Load every configs/targets/*.mak unconditionally; target_dirs is the
> +# --target-list filtered subset of target_dirs_all.
> +target_dirs_all = run_command(python, '-c',
> +  'import os, sys; print(" ".join(sorted(f[:-4] for f in os.listdir(sys.argv[1]) if f.endswith(".mak"))))',
> +  meson.current_source_dir() / 'configs/targets',
> +  check: true).stdout().split()
> +target_mak_all = {}
> +foreach target : target_dirs_all
> +  mak = keyval.load('configs/targets' / target + '.mak')
> +  if 'TARGET_BASE_ARCH' not in mak
> +    mak += {'TARGET_BASE_ARCH': mak['TARGET_ARCH']}
> +  endif
> +  target_mak_all += {target: mak}
> +endforeach
> +
>  disassemblers = {
>    'alpha' : ['CONFIG_ALPHA_DIS'],
>    'avr' : ['CONFIG_AVR_DIS'],
> @@ -3318,7 +3333,7 @@ foreach target : target_dirs
>      }
>    endif
>  
> -  config_target += keyval.load('configs/targets' / target + '.mak')
> +  config_target += target_mak_all[target]
>  
>    target_kconfig = []
>    foreach sym: accelerators
> @@ -3348,9 +3363,6 @@ foreach target : target_dirs
>  
>    # Add default keys
>    config_target += { 'TARGET_' + config_target['TARGET_ARCH'].to_upper(): 'y' }
> -  if 'TARGET_BASE_ARCH' not in config_target
> -    config_target += {'TARGET_BASE_ARCH': config_target['TARGET_ARCH']}
> -  endif
>    if 'TARGET_ABI_DIR' not in config_target
>      config_target += {'TARGET_ABI_DIR': config_target['TARGET_ARCH']}
>    endif

What is the goal of this patch?
In case it's to simplify further patches, if a script can read one .mak
files, it can probably read several also.

Regards,
Pierrick

