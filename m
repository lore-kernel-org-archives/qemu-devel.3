Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDC0C4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkhy6-000440-9Y; Fri, 17 Jul 2026 08:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkhy4-00043P-4X
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:47:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkhy1-00022W-6l
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:47:03 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HCT0wa1964567
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 12:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qJs17cf4kbIBmbPMo7HwT69qZx9e+5H/33GPenmbJmQ=; b=k2vC68y0pvcm6nx4
 8dh+gT2kbEyp/09nRhM4b1U6H3FWcVRhtBvurIgmxWRmbzvLzs+xBwKruh8qRis3
 Gvo2yQwas+Ok7kBYOC+FCqn8w9VUUN6SpJE72xZbZaQLAdy3qGp7D0KuMZxkZLq4
 FgPBc0YU1G32/11FUloAztgp2fL5O6Rjo3cLZN0g8AVSHCU9rkch7RkgfATj5o2Z
 cfztv3pVWtT9XS1P4mgRBFPH553/rDvgLfBHKO6ADC5DpNtIeegFR51mgcRH2gdp
 qS/XCgpxSVbL7zGVrX6a6Iv67siFZrkmmYBPY7m2nBZJGRUvkVBQc2SQqWH82v5A
 qyzZag==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffd3astnw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 12:46:57 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84865f326efso8137866b3a.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 05:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784292417; x=1784897217; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qJs17cf4kbIBmbPMo7HwT69qZx9e+5H/33GPenmbJmQ=;
 b=VGC3jQYSiOcRJ3ah+GjGOwcIJzjU+XoTexO02Bg5IsNuxUa6TCT0nUfgxZIGakHDUD
 i5Hp3zpychQSRJSJ7342qfvHDHgZNDWiiHZFLaaDG77NNAYNraFYQcYtkf++9rKGNvcF
 2zCi0j/7WO0V9nj9KtFIvAO8EmQyBZ2bWKL1R5rJ1ndAAIxC5JB72KJmqRRtlAu+yWTD
 o/jkA2gvrwTKb7g5BbOLkwy3NvaUhn4LK1bDoxKzmYSd10LNBJ5PcqhUxCTauZyAxBPU
 2ggp0T0OVIdOn/d8YtYdbkUBnbHTQ3sd37DL6fibD89coBV1I5OJPInmipgcKE4iRtgP
 ++kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784292417; x=1784897217;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qJs17cf4kbIBmbPMo7HwT69qZx9e+5H/33GPenmbJmQ=;
 b=fKsKk16bTpuYgimOtcu25adnzPUvfC3zU4UVftlJst8dU3f4xFEjz06aRn26wqSLUz
 +tGZq+AYSfnw2A8oUfSGIQIZz4cFPrZmN63TjX21ehph3jsqVQ6fMc48s52OaC5LX3Z/
 +iRp3Um0IlOwUa0pYJsdIGzICIcnVhnNY5Ius3wG54j+6XyvVpP9FNBfKcsWiWyu9oqy
 1zgxI6MFZYEQFDYsFS+uSG766ZLua3dcIb2fRagfGZt+wrDeRShCkl6kzrucWXBNtyuS
 6XhhEw5B/2q5P0KGvlEhLrM3jy2llrwhdhXpNRvSJ1fATcxl0N8R0IgJRmDELFSfy3M6
 pVNQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpdx4wd3raghwOX4PbhOKgnCjjKv5BH0EKwP7n1q7sA9YyCzqZLzdiEzqfaFdYBMoGRK6Lfof8lDUtv@nongnu.org
X-Gm-Message-State: AOJu0Yz/3pVWQVBHJfg6xA2/CRNTHx6nFspAHb1+vfNJasGiQTkecphY
 2mcEmCxLdz+w6FEyX0/8Doq8EgMW/iEbB1Tyb3648f3QbiMa1U3KhcTn4lrEcrqFDGcTnPmXbEl
 6p4ARnV1OOX/Pdxup16gKZtlu4tJbiYgkh115t4DHAguNQtut9RkhpaMhOA==
X-Gm-Gg: AfdE7cnNpwhCTVMDU8/2C4ePZ440Vo2LrU/CQDWXXFWUiLGvRPV/HuaQdQecqhiggJh
 sBRGgVMxNGCzlkvbNIZSgqHI+h3ArgWHNgUoznvtbQ3nBouFxIlL8yQMRsz5QlIHSnFoYgbODp0
 Fz3JtPQYGjB48awVSAJ+BZfIUZPrortbV9YelUEWZ6pnQFzI87gwvoNcne+W+Fou67/qDyEW+Dg
 ojWdl8p9MIC1SEWL7K+9I6jJIGZteCGRJjy0dLkm/+tb3s2IWd3fBnsiBIudR4uR0Y0aa/BUQwT
 OrK3i/VtRXZlDQwWPDv959l9aex/cFGAxyJw+j5gSimVSWabnm+XAmmtxoJw4jyPWjWM7qajKsy
 KKh4XlABN0tNuxlgSKsZgFRFNa1lx9s6octXspQ==
X-Received: by 2002:a05:6a00:a212:b0:848:48e7:438f with SMTP id
 d2e1a72fcca58-84c2954e507mr2471531b3a.64.1784292416770; 
 Fri, 17 Jul 2026 05:46:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:a212:b0:848:48e7:438f with SMTP id
 d2e1a72fcca58-84c2954e507mr2471489b3a.64.1784292416292; 
 Fri, 17 Jul 2026 05:46:56 -0700 (PDT)
Received: from [192.168.68.105] ([152.234.122.204])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cb5159b11a5sm789389a12.0.2026.07.17.05.46.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 05:46:54 -0700 (PDT)
Message-ID: <cf949a48-5e9f-455b-a9c0-74b0a0ff77ac@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 09:46:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] build: add optional librpmi dependency
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260714075659.2258023-2-subrahmanya.lingappa@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260714075659.2258023-2-subrahmanya.lingappa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEyOSBTYWx0ZWRfX7E5T7tLwwsga
 rCg8zCRpAOIjkGJORam6bP6WyVkbdQyRSytwhUhwg6LfHmlO12aFU3pbuSazJtF86BxvRPeBJVw
 MhqJiLLhTcJpDJ1hVFe5f3lOoHuh23E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEyOSBTYWx0ZWRfX6WYF1jVBVCas
 VngAjW0BLtvd7WWaIfJO4lcNyRKzs6Ezzcou6pbQTNkEUmCY597Dn7weiKU18W4jRG7FNBXtWyq
 frt6yCXmNljFDfnZhk28bvznssaAn+2ShCTkdwlGksqjzcGON6gE2Kkbmhc2qGi+UpP/6z9vE/G
 vXVDWFvG1OpoRoh0yDddFPsJttOoiY2jquoqyeW6L/es+yxEVauxLMhh9Dcis4levNxibO7r3X3
 RoITJoLnepb+YcDf5E9V+rMJ9XP7TcXkAlBBzdIfg1eoxLGTbKmi9m2OhzFHHVvScKeL/2mCYla
 YZzb4rMdtsjjT/gAcIr+epsZT0vsvhRMLpgILYRcByMLfeKAJTePrAJLy0W3uBpcfC8U4GrCt22
 NUirRAxWiOarZEgHKNLbOd7faHhxuivNJiCazIizRooI3XeYdNfd9k5D/UkTl2RlfIvXVH/NSJH
 yQRfrVHtPhqCQYXChTg==
X-Proofpoint-GUID: zgA3QZjCYksMMnMqnflU-_t3D9hFyzVJ
X-Proofpoint-ORIG-GUID: zgA3QZjCYksMMnMqnflU-_t3D9hFyzVJ
X-Authority-Analysis: v=2.4 cv=e/M2j6p/ c=1 sm=1 tr=0 ts=6a5a2441 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=J0RmenBMOwS19r/fhzI3tQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=OVeDvAaIbfOGYRnav5QA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170129
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 7/14/2026 4:56 AM, Subrahmanya Lingappa wrote:
> Add a meson option and config probe for librpmi so RISC-V machines can
> opt into RPMI support when the library is available. Keep the dependency
> optional so default builds without librpmi continue to work.
> 
> Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   Kconfig.host                  |  3 +++
>   meson.build                   | 14 ++++++++++++++
>   meson_options.txt             |  2 ++
>   scripts/meson-buildoptions.sh |  3 +++
>   4 files changed, 22 insertions(+)
> 
> diff --git a/Kconfig.host b/Kconfig.host
> index 933425c74b..6f98dadb2e 100644
> --- a/Kconfig.host
> +++ b/Kconfig.host
> @@ -8,6 +8,9 @@ config LINUX
>   config LIBCBOR
>       bool
>   
> +config LIBRPMI
> +    bool
> +
>   config GNUTLS
>       bool
>   
> diff --git a/meson.build b/meson.build
> index 19e123423b..103b4649b8 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2005,6 +2005,17 @@ if lzo.found() and not cc.links('''
>     endif
>   endif
>   
> +librpmi = not_found
> +if not get_option('librpmi').auto() or have_system
> +  librpmi = dependency('librpmi', required: get_option('librpmi'),
> +                       method: 'pkg-config')
> +  if librpmi.found() and not cc.has_header_symbol('librpmi.h',
> +                                                  'rpmi_service_group_logging_create',
> +                                                  dependencies: librpmi)
> +    error('librpmi support requires the RPMI logging service group API')
> +  endif
> +endif
> +
>   numa = not_found
>   if not get_option('numa').auto() or have_system or have_tools
>     numa = cc.find_library('numa', has_headers: ['numa.h'],
> @@ -2427,6 +2438,7 @@ config_host_data.set('CONFIG_LINUX', host_os == 'linux')
>   config_host_data.set('CONFIG_POSIX', host_os != 'windows')
>   config_host_data.set('CONFIG_WIN32', host_os == 'windows')
>   config_host_data.set('CONFIG_LZO', lzo.found())
> +config_host_data.set('CONFIG_LIBRPMI', librpmi.found())
>   config_host_data.set('CONFIG_MPATH', mpathpersist.found())
>   config_host_data.set('CONFIG_BLKIO', blkio.found())
>   if blkio.found()
> @@ -3258,6 +3270,7 @@ host_kconfig = \
>     (multiprocess_allowed ? ['CONFIG_MULTIPROCESS_ALLOWED=y'] : []) + \
>     (vfio_user_server_allowed ? ['CONFIG_VFIO_USER_SERVER_ALLOWED=y'] : []) + \
>     (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=y'] : []) + \
> +  (librpmi.found() ? ['CONFIG_LIBRPMI=y'] : []) + \
>     (have_rust ? ['CONFIG_HAVE_RUST=y'] : [])
>   
>   ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR' ]
> @@ -4971,6 +4984,7 @@ summary_info += {'TPM support':       have_tpm}
>   summary_info += {'IGVM support':      igvm}
>   summary_info += {'libssh support':    libssh}
>   summary_info += {'lzo support':       lzo}
> +summary_info += {'librpmi support':   librpmi}
>   summary_info += {'snappy support':    snappy}
>   summary_info += {'bzip2 support':     libbzip2}
>   summary_info += {'lzfse support':     liblzfse}
> diff --git a/meson_options.txt b/meson_options.txt
> index a07cb47d35..9f773a7886 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -204,6 +204,8 @@ option('lzfse', type : 'feature', value : 'auto',
>          description: 'lzfse support for DMG images')
>   option('lzo', type : 'feature', value : 'auto',
>          description: 'lzo compression support')
> +option('librpmi', type : 'feature', value : 'auto',
> +       description: 'RISC-V RPMI support')
>   option('pvg', type: 'feature', value: 'auto',
>          description: 'macOS paravirtualized graphics support')
>   option('rbd', type : 'feature', value : 'auto',
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index c003985047..e8a20068e7 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -140,6 +140,7 @@ meson_options_help() {
>     printf "%s\n" '  libkeyutils     Linux keyutils support'
>     printf "%s\n" '  libnfs          libnfs block device driver'
>     printf "%s\n" '  libpmem         libpmem support'
> +  printf "%s\n" '  librpmi         RISC-V RPMI support'
>     printf "%s\n" '  libssh          ssh block device support'
>     printf "%s\n" '  libudev         Use libudev to enumerate host devices'
>     printf "%s\n" '  libusb          libusb support for USB passthrough'
> @@ -376,6 +377,8 @@ _meson_option_parse() {
>       --disable-libnfs) printf "%s" -Dlibnfs=disabled ;;
>       --enable-libpmem) printf "%s" -Dlibpmem=enabled ;;
>       --disable-libpmem) printf "%s" -Dlibpmem=disabled ;;
> +    --enable-librpmi) printf "%s" -Dlibrpmi=enabled ;;
> +    --disable-librpmi) printf "%s" -Dlibrpmi=disabled ;;
>       --enable-libssh) printf "%s" -Dlibssh=enabled ;;
>       --disable-libssh) printf "%s" -Dlibssh=disabled ;;
>       --enable-libudev) printf "%s" -Dlibudev=enabled ;;


