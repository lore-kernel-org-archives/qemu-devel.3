Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF08C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyXTd-00031o-8t; Mon, 24 Aug 2026 12:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wyXTb-0002w1-2L
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 12:24:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wyXTS-0002Xf-MA
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 12:24:43 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OFmqXI2857133
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 16:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=gSM9nyKTkIeSxh66ZNMe+gx3
 AeG5MV9y+h9sx6cCrdg=; b=PTZUJY1YcdysKHNsKMnP0SIdmlO6Gc9nbS3MwX9k
 fcGKJg2vsfrauAV9AtHbktqyxZjmMqLq7NHXHlqw3aHRp81L7ukX8RnfH4Frl8kA
 HXVA0BYzYwXK3EnzQ6Z5b5FHnSEumg8QqydtfNv1BRBLvEr8wpGnOPygIiY1M0A0
 +9KneHKJXD0n5Vu7v/38K0kQTa8VEOOA2fk1zuNA93ExeH20G2D0IVEEOpopcd++
 umWCe21ftS8uPdDSSKc3jaJBHA+dfPvuzfJPrywfbkKI2I6AV0udLgHF3RVe38tX
 0+lWk8kyr8wpCBLK9RTCh8ejKvqGntq2ixFyLmthp0JkSQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8kdshr8h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 16:24:36 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-388b404eaa4so5764290a91.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 09:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787588676; x=1788193476; darn=nongnu.org;
 h=in-reply-to:content-language:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gSM9nyKTkIeSxh66ZNMe+gx3AeG5MV9y+h9sx6cCrdg=;
 b=knDJeWr5aEHRjwJL/mRmqranON34nmoBKKUz+cNZkVCBYCMY25C9xeyT0dwVEGZ5vb
 g6YNq8RJRhVcz3rLPYnxqXHTchjV1IKFNRy2/eL91rPkzGA6Bffyg7HMQHOgKh2PmnQb
 zRmxPZ1YWpIjD+kfAcai0rZ+g89FKkNgjYxH4wfmTKQO5c1y4+Cc0t9ADLnVLgzyvLq5
 H/9n0JZdlgbvSQpU9+HtKKqVfdSTGH53HlcjboneiiH9AZ5tlusZj4teP1qFaR4yNWM/
 a5eIwDNaDh+joAWwfyUxhmFIfT8kFYCq/32mg3sgD8rGWEh+PMLy4zX7uINBzwLkvo/8
 64EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787588676; x=1788193476;
 h=in-reply-to:content-language:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gSM9nyKTkIeSxh66ZNMe+gx3AeG5MV9y+h9sx6cCrdg=;
 b=pF4TgllISz2zbiLfIiNHsPamjLvc9y4AA/1eXEZ4xaE2lpnDbzn2rNlZHZTf2TGUC3
 bTKt5SAwokNQHSY0NO0wIovFXzRgxOUQwpX+RyNgjhvMJHlNEProLR/rf3Mp/0wFAFEN
 9tUPm0MM2uJyyBfKRJt7KoboGGvKpxHzSwdNqxqm0fcvwvac9jnql6EmJEQDCNjqUa8v
 zvJ5lGZUt5sHsnfVUbqbl0s9n109FLzspWiBQj8k/b+hYULcBkvCC8OXvTpbdfFmwaaZ
 3+8knpgdnvmZ6r3jw23P7aApCDP8rWbVgximIyh9TMfRt6P8T+CwzVba09ejG+SUqg9Y
 v+4w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr487bDdirrZdEuSgbdXscZm8k88DBPy4Q+WTUXGYEFNL00inrqY5aTTLEXF/f/xNOvWKAkLRR3slip@nongnu.org
X-Gm-Message-State: AFuF++m98jJ7jfkp6IFWCyv8L6GBblzljqISAsDfLLO+JHLC7BIZy3h3
 TbZMATwYBJDAUvOnlhRFKhIRbvLc1Y5ZDI5T2f1btMozN9QnpTSXNDC+ZlaKRxzhuqnDmUzP0w2
 Bq6J0gmwmc4Iyn69AzV2sRK7OEtRZaNXp8jfpIgFxyl8Yvkl4dxszZvN3IQ==
X-Gm-Gg: AR+sD10Uxqszqpzj84RCzu5LZKsHHKKKtYPsMu4UFvU00oKi7fNkiNAcsbOG8k35FSk
 hWHsCrb6I3biPHgiRp86YTiWXAlFG51D1m0rRdeYV8T81Kuk1gz0xr3QgG1Ipear8KMMDcn9Vja
 2YoCZqPukG+wsh7KoJjPlSlfKxSSdbH39MpEK6M6AlNMDr5N/FQvxtEoPghB79idXPePqJZ6mBf
 /I16h8QIlfPYDA8VhBkJeVTBKrMfoxznz8u4RXDVIpFhVH2Od/O+pVGWwI8zp5L7KuRRxELVIvq
 g3JxGFBXBjCjA/ciR/S+9qAmM1gkR95qbnd+W9bHxSZCKe6icjDEpWqelxX9D1UiuPV8mm2Ux3T
 ocdnqDEwqQxi3DrrNHXVe3BFDS9cY+psWRlsxG6JgFKYNdF8MEwB1V+BeLNNSARQyVn6d
X-Received: by 2002:a17:90a:c107:b0:37f:bfa2:1887 with SMTP id
 98e67ed59e1d1-395deee4081mr39126505a91.8.1787588675828; 
 Mon, 24 Aug 2026 09:24:35 -0700 (PDT)
X-Received: by 2002:a17:90a:c107:b0:37f:bfa2:1887 with SMTP id
 98e67ed59e1d1-395deee4081mr39126276a91.8.1787588675134; 
 Mon, 24 Aug 2026 09:24:35 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3280d116cb1sm18150549eec.10.2026.08.24.09.24.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 09:24:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------aoXGcc1JabHcVkSZJcMT8BSp"
Message-ID: <06290823-209c-4c9a-b611-05f50f846564@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 09:24:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] target-info: add -target and program-name selection
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Farman <farman@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>
References: <20260823150731.896-1-luoyonggang@gmail.com>
 <20260823150731.896-11-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260823150731.896-11-luoyonggang@gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzOCBTYWx0ZWRfXyy9wuLAJUruk
 NBBjbaAlvf3Re5jkYBzQX0y4foSIBrejiN0sNUPhuGwK6SqkemphTLqaMf6JgbGpkoogTWWqs37
 2IhWrkCfe2hGgwZeMdQpR2ov2pD+5po=
X-Proofpoint-ORIG-GUID: aAHMNCHL6UYWtOdd7YldYN8gd6fYdf_2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzOCBTYWx0ZWRfXzSsmwI6m28O5
 K0/QGQZ6lDvxnMzyC50ok6uNBhtfOkJ6Hv7uafRfcSXK2Ns+wmOIcmSsMFCuBlZT31+Ui9T+4TL
 gwX+FAd3vAfXfRXzuCRKiP402vxrJpfItm4V40nW6EteEkslOKeFHjfGmg3n6wMwlS3eZ+z9cfj
 Kssy7oslUJNObZX1TEhWxMyyF+KoVolkdazUGGhaOK9BVmOCI+hXNgrb03fud//UpDs2sV4iosI
 vDb1AYsmVdLk+bFA4vucDjB8YtFIH3F+l+yCSA5ttHFwfp0nODyBrKnJnJ7cRuoBzCsJT4o0/y0
 u/ATeGRbWKaJmEayaRqgrPT7fA/CSoaNrPuGX8Iovhu49uEF4vigQPcw2prkrxI5Dr2GDt7BrHR
 AgAypRBzC23jHPlI+D4v89x3ijsH44Ppx5peyHvSx0u4z3Ydjk4w/uYZzATMp78RIzKcE6uyaDr
 gR16tqKljtMm5dBWOHg==
X-Proofpoint-GUID: aAHMNCHL6UYWtOdd7YldYN8gd6fYdf_2
X-Authority-Analysis: v=2.4 cv=d8DFDxjE c=1 sm=1 tr=0 ts=6a8c7044 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=pGLkceISAAAA:8 a=FM6jLdnHYzgpWUaxIOkA:9 a=QEXdDO2ut3YA:10
 a=kemcdkk9OJzm-CMI4xoA:9 a=m-Z_27IZkzAA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240138
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

This is a multi-part message in MIME format.
--------------aoXGcc1JabHcVkSZJcMT8BSp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/23/2026 8:07 AM, Yonggang Luo wrote:
> - Parse -target before TargetInfo is fixed; CLI overrides the program
>   basename.
> - Tokens are target_name or target_name-be / -le; -target help lists
>   registered names in sorted order.
> - When -target is omitted, infer the token from g_get_prgname(): strip
>   .exe, take the longest dash-separated registered suffix, and retry
>   without a trailing w for Windows GUI binaries.
> - A basename that matches no registered token falls through to the
>   unique default. Combined binaries with no suffix require -target
>   when more than one default TargetInfo is registered.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  include/qemu/target-info-qom.h |  10 +-
>  qemu-options.hx                |  13 +++
>  system/vl.c                    |  28 ++++--
>  target-info-qom.c              | 167 ++++++++++++++++++++++++++++++---
>  tests/qtest/fuzz/fuzz.c        |   2 +-
>  5 files changed, 197 insertions(+), 23 deletions(-)
> 
> diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
> index 842cf241e0a..3b59cf82d65 100644
> --- a/include/qemu/target-info-qom.h
> +++ b/include/qemu/target-info-qom.h
> @@ -40,7 +40,15 @@ typedef struct TargetInfoQomClass {
>  
>  OBJECT_DECLARE_TYPE(TargetInfoQom, TargetInfoQomClass, TARGET_INFO)
>  
> -void target_info_qom_set_target(void);
> +/**
> + * target_info_qom_set_target:
> + * @name: -target token, or NULL/%empty to infer from the program
> + * basename or the unique default
> + *
> + * Tokens are target_name (arch default endian) or target_name-be /
> + * target_name-le. -target overrides the program basename.
> + */
> +void target_info_qom_set_target(const char *name);
>  
>  /**
>   * get_machine_types_available:
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 34970fffc94..638b531aa49 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -223,6 +223,19 @@ SRST
>      as -machine.
>  ERST
>  
> +DEF("target", HAS_ARG, QEMU_OPTION_target,
> +    "-target name    select target ('-target help' for list)\n", QEMU_ARCH_ALL)
> +SRST
> +``-target name``
> +    Select the emulation target (``-target help`` for the list). The
> +    default endian is the architecture default (``riscv64`` is little
> +    endian). The other endian uses a ``-be`` or ``-le`` suffix
> +    (``riscv64-be``, ``ppc64-le``). If omitted, a matching suffix of
> +    the program basename is used (``qemu-system-riscv64-be``, and
> +    ``qemu-system-aarch64w.exe`` on Windows). ``-target`` overrides
> +    the program name.
> +ERST
> +
>  DEF("cpu", HAS_ARG, QEMU_OPTION_cpu,
>      "-cpu cpu        select CPU ('-cpu help' for list)\n", QEMU_ARCH_ALL)
>  SRST
> diff --git a/system/vl.c b/system/vl.c
> index 83b9425de9b..405f434e036 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -166,6 +166,7 @@ typedef struct DeviceOption {
>      QTAILQ_ENTRY(DeviceOption) next;
>  } DeviceOption;
>  
> +static const char *target_option;
>  static const char *cpu_option;
>  static const char *mem_path;
>  static const char *incoming;
> @@ -2899,19 +2900,12 @@ void qemu_init(int argc, char **argv)
>  
>      os_setup_limits();
>  
> -    module_call_init(MODULE_INIT_TARGET_INFO);
> -    target_info_qom_set_target();
> -
> -    module_init_info(qemu_modinfo);
> -    module_allow_arch(target_name());
> -
> -    qemu_init_subsystems();
> -
> -    /* first pass of option parsing */
> +    /*
> +     * First pass: options needed before TargetInfo is fixed.
> +     */
>      optind = 1;
>      while (optind < argc) {
>          if (argv[optind][0] != '-') {
> -            /* disk image */
>              optind++;
>          } else {
>              const QEMUOption *popt;
> @@ -2921,10 +2915,21 @@ void qemu_init(int argc, char **argv)
>              case QEMU_OPTION_nouserconfig:
>                  userconfig = false;
>                  break;
> +            case QEMU_OPTION_target:
> +                target_option = optarg;
> +                break;
>              }
>          }
>      }
>  
> +    module_call_init(MODULE_INIT_TARGET_INFO);
> +    target_info_qom_set_target(target_option);
> +
> +    module_init_info(qemu_modinfo);
> +    module_allow_arch(target_name());
> +
> +    qemu_init_subsystems();
> +
>      machine_opts_dict = qdict_new();
>      if (userconfig) {
>          qemu_read_default_config_file(&error_fatal);
> @@ -3687,6 +3692,9 @@ void qemu_init(int argc, char **argv)
>              case QEMU_OPTION_nouserconfig:
>                  /* Nothing to be parsed here. Especially, do not error out below. */
>                  break;
> +            case QEMU_OPTION_target:
> +                /* Parsed before TargetInfo is selected. */
> +                break;
>  #if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
>              case QEMU_OPTION_daemonize:
>                  os_set_daemonize(true);
> diff --git a/target-info-qom.c b/target-info-qom.c
> index 2c1c57b05fd..be03573a699 100644
> --- a/target-info-qom.c
> +++ b/target-info-qom.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/help_option.h"
>  #include "qapi/error.h"
>  #include "qom/object.h"
>  #include "qemu/target-info-impl.h"
> @@ -87,7 +88,139 @@ const TargetInfo *target_info(void)
>      return target_info_ptr;
>  }
>  
> -void target_info_qom_set_target(void)
> +static const TargetInfo *target_info_from_class(ObjectClass *oc)
> +{
> +    return TARGET_INFO_CLASS(oc)->target_info;
> +}
> +
> +/* Default token is target_name; the other endian is target_name-le or -be. */
> +static char *target_info_option_name(const TargetInfo *ti)
> +{
> +    if (ti->is_default) {
> +        return g_strdup(ti->target_name);
> +    }
> +    if (ti->endianness == ENDIAN_MODE_BIG) {
> +        return g_strdup_printf("%s-be", ti->target_name);
> +    }
> +    return g_strdup_printf("%s-le", ti->target_name);
> +}
> +
> +static gint target_info_token_name_cmp(gconstpointer a, gconstpointer b,
> +                                       gpointer data)
> +{
> +    const TargetInfo *ta = target_info_from_class((ObjectClass *)a);
> +    const TargetInfo *tb = target_info_from_class((ObjectClass *)b);
> +    g_autofree char *na = target_info_option_name(ta);
> +    g_autofree char *nb = target_info_option_name(tb);
> +
> +    return strcmp(na, nb);
> +}
> +
> +static void G_NORETURN target_info_list_and_exit(GSList *targets)
> +{
> +    printf("Supported targets:\n");
> +    for (GSList *l = targets; l; l = l->next) {
> +        const TargetInfo *ti = target_info_from_class(l->data);
> +        g_autofree char *opt_name = target_info_option_name(ti);
> +
> +        printf("  %s%s\n", opt_name, ti->is_default ? " (default)" : "");
> +    }
> +    exit(0);
> +}
> +
> +static const TargetInfo *target_info_find_default(GSList *targets,
> +                                                  size_t *num_default)
> +{
> +    const TargetInfo *chosen = NULL;
> +
> +    *num_default = 0;
> +    for (GSList *l = targets; l; l = l->next) {
> +        const TargetInfo *ti = target_info_from_class(l->data);
> +
> +        if (ti->is_default) {
> +            (*num_default)++;
> +            chosen = ti;
> +        }
> +    }
> +    return chosen;
> +}
> +
> +static const TargetInfo *target_info_find_token(GSList *targets,
> +                                                const char *token)
> +{
> +    for (GSList *l = targets; l; l = l->next) {
> +        const TargetInfo *ti = target_info_from_class(l->data);
> +        g_autofree char *opt_name = target_info_option_name(ti);
> +
> +        if (!strcmp(opt_name, token)) {
> +            return ti;
> +        }
> +    }
> +    return NULL;
> +}
> +
> +static bool target_info_base_match_token(const char *base, const char *token)
> +{
> +    size_t nlen = strlen(token);
> +    size_t blen;
> +
> +    if (!base || !token[0] || !g_str_has_suffix(base, token)) {
> +        return false;
> +    }
> +    blen = strlen(base);
> +    return blen == nlen || base[blen - nlen - 1] == '-';
> +}
> +
> +static const TargetInfo *target_info_find_prgname(GSList *targets,
> +                                                  const char *base)
> +{
> +    const TargetInfo *chosen = NULL;
> +    size_t best_len = 0;
> +
> +    if (!base || !base[0]) {
> +        return NULL;
> +    }
> +
> +    for (GSList *l = targets; l; l = l->next) {
> +        const TargetInfo *ti = target_info_from_class(l->data);
> +        g_autofree char *opt_name = target_info_option_name(ti);
> +        size_t nlen = strlen(opt_name);
> +
> +        if (nlen > best_len &&
> +            target_info_base_match_token(base, opt_name)) {
> +            chosen = ti;
> +            best_len = nlen;
> +        }
> +    }
> +    return chosen;
> +}
> +
> +static const TargetInfo *target_info_from_prgname(GSList *targets)
> +{
> +    const char *prg = g_get_prgname();
> +    g_autofree char *base = NULL;
> +    char *dot;
> +    const TargetInfo *chosen;
> +
> +    if (!prg || !prg[0]) {
> +        return NULL;
> +    }
> +
> +    base = g_path_get_basename(prg);
> +    dot = strrchr(base, '.');
> +    if (dot && g_ascii_strcasecmp(dot, ".exe") == 0) {
> +        *dot = '\0';
> +    }
> +
> +    chosen = target_info_find_prgname(targets, base);
> +    if (!chosen && strlen(base) > 1 && g_str_has_suffix(base, "w")) {
> +        base[strlen(base) - 1] = '\0';
> +        chosen = target_info_find_prgname(targets, base);
> +    }
> +    return chosen;
> +}
> +
> +void target_info_qom_set_target(const char *name)
>  {
>      g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);
>      const TargetInfo *chosen = NULL;
> @@ -98,25 +231,37 @@ void target_info_qom_set_target(void)
>          error_setg(&error_fatal, "no target-info is available");
>      }
>  
> -    if (num_found == 1) {
> -        target_info_ptr = TARGET_INFO_CLASS(targets->data)->target_info;
> +    if (name && is_help_option(name)) {
> +        targets = g_slist_sort_with_data(targets, target_info_token_name_cmp,
> +                                         NULL);
> +        target_info_list_and_exit(targets);
> +    }
> +
> +    if (name && name[0]) {
> +        chosen = target_info_find_token(targets, name);
> +        if (!chosen) {
> +            error_setg(&error_fatal, "unknown target '%s'", name);
> +        }
> +        target_info_ptr = chosen;
>          return;
>      }
>  
> -    for (GSList *l = targets; l; l = l->next) {
> -        const TargetInfo *ti = TARGET_INFO_CLASS(l->data)->target_info;
> +    chosen = target_info_from_prgname(targets);
> +    if (chosen) {
> +        target_info_ptr = chosen;
> +        return;
> +    }
>  
> -        if (ti->is_default) {
> -            num_default++;
> -            chosen = ti;
> -        }
> +    if (num_found == 1) {
> +        target_info_ptr = target_info_from_class(targets->data);
> +        return;
>      }
>  
> +    chosen = target_info_find_default(targets, &num_default);
>      if (num_default != 1) {
>          error_setg(&error_fatal, num_default == 0 ?
>                                   "no default target-info is available" :
> -                                 "more than one default target-info "
> -                                 "is available");
> +                                 "multiple default targets; use -target");
>      }
>  
>      target_info_ptr = chosen;
> diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
> index a3a131c80f8..489c7138bb9 100644
> --- a/tests/qtest/fuzz/fuzz.c
> +++ b/tests/qtest/fuzz/fuzz.c
> @@ -174,7 +174,7 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
>      /* Initialize qgraph and modules */
>      qos_graph_init();
>      module_call_init(MODULE_INIT_TARGET_INFO);
> -    target_info_qom_set_target();
> +    target_info_qom_set_target(NULL);
>      module_call_init(MODULE_INIT_FUZZ_TARGET);
>      module_call_init(MODULE_INIT_QOM);
>      module_call_init(MODULE_INIT_LIBQOS);

It could at least be useful to list available targets for users when the
one passed is incorrect, or when they must pick one.

See patch attached for inspiration.

Regards,
Pierrick


--------------aoXGcc1JabHcVkSZJcMT8BSp
Content-Type: text/plain; charset=UTF-8;
 name="a3e5a8f350e14ce533262b29e7dc37af6d76425d.patch.txt"
Content-Disposition: attachment;
 filename="a3e5a8f350e14ce533262b29e7dc37af6d76425d.patch.txt"
Content-Transfer-Encoding: base64

RnJvbSBhM2U1YThmMzUwZTE0Y2U1MzMyNjJiMjllN2RjMzdhZjZkNzY0MjVkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2
aWVyQG9zcy5xdWFsY29tbS5jb20+CkRhdGU6IFN1biwgMTcgTWF5IDIwMjYgMjE6NDA6MjIg
KzAwMDAKU3ViamVjdDogW1BBVENIXSBzeXN0ZW0vdmw6IGFkZCBuZXcgb3B0aW9uIC10YXJn
ZXQKClRoaXMgY29tbWl0IGFkZHMgYSBuZXcgb3B0aW9uIC10YXJnZXQsIHdoaWNoIGNhbiBi
ZSBhbGxvd2VkIHRvIHNldApjdXJyZW50IHRhcmdldCwgb3IgcmV0cmlldmUgbGlzdCBvZiB0
YXJnZXRzIGF2YWlsYWJsZSB3aXRoICdoZWxwJy4KClRoaXMgb3B0aW9uIGlzIHRoZSBmaXJz
dCB3ZSBuZWVkIHRvIGhhbmRsZSwgYXMgYWxsIHRoZSByZXN0IG9mCmluaXRpYWxpemF0aW9u
IGRlcGVuZHMgb24gaXQuCgpTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVy
cmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogaW5jbHVkZS9xZW11L3Rhcmdl
dC1pbmZvLXFvbS5oIHwgIDEgKwogcWVtdS1vcHRpb25zLmh4ICAgICAgICAgICAgICAgIHwg
IDggKysrKysrKysKIHN5c3RlbS92bC5jICAgICAgICAgICAgICAgICAgICB8IDM0ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKy0KIHRhcmdldC1pbmZvLXFvbS5jICAgICAg
ICAgICAgICB8IDMzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQogNCBmaWxl
cyBjaGFuZ2VkLCA3NCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2luY2x1ZGUvcWVtdS90YXJnZXQtaW5mby1xb20uaCBiL2luY2x1ZGUvcWVtdS90YXJn
ZXQtaW5mby1xb20uaAppbmRleCA5MWJlNDE1ZWQzM2YyLi44N2YzYTUxY2NkNGFmIDEwMDY0
NAotLS0gYS9pbmNsdWRlL3FlbXUvdGFyZ2V0LWluZm8tcW9tLmgKKysrIGIvaW5jbHVkZS9x
ZW11L3RhcmdldC1pbmZvLXFvbS5oCkBAIC0yNiw1ICsyNiw2IEBAIHR5cGVkZWYgc3RydWN0
IFRhcmdldEluZm9Rb21DbGFzcyB7CiBPQkpFQ1RfREVDTEFSRV9UWVBFKFRhcmdldEluZm9R
b20sIFRhcmdldEluZm9Rb21DbGFzcywgVEFSR0VUX0lORk8pCiAKIHZvaWQgdGFyZ2V0X2lu
Zm9fcW9tX3NldF90YXJnZXQodm9pZCk7Cit2b2lkIHRhcmdldF9pbmZvX3FvbV9zZXRfdGFy
Z2V0X2Zyb21fbmFtZShjb25zdCBjaGFyICpuYW1lKTsKIAogI2VuZGlmIC8qIFFFTVVfVEFS
R0VUX0lORk9fUU9NX0ggKi8KZGlmZiAtLWdpdCBhL3FlbXUtb3B0aW9ucy5oeCBiL3FlbXUt
b3B0aW9ucy5oeAppbmRleCBiOGUyNzEwYTJjYmQ0Li4xZDcxOWIyMzdjYjYwIDEwMDY0NAot
LS0gYS9xZW11LW9wdGlvbnMuaHgKKysrIGIvcWVtdS1vcHRpb25zLmh4CkBAIC0yNCw2ICsy
NCwxNCBAQCBTUlNUCiAgICAgRGlzcGxheSB2ZXJzaW9uIGluZm9ybWF0aW9uIGFuZCBleGl0
CiBFUlNUCiAKK0RFRigidGFyZ2V0IiwgSEFTX0FSRywgUUVNVV9PUFRJT05fdGFyZ2V0LCBc
CisgICAgIi10YXJnZXQgdGFyZ2V0ICBzZWxlY3RzIHRoZSB0YXJnZXQgYXJjaGl0ZWN0dXJl
ICgnLXRhcmdldCBoZWxwJyBmb3IgbGlzdClcbiIsCisgICAgUUVNVV9BUkNIX0FMTCkKK1NS
U1QKK2BgLXRhcmdldCB0YXJnZXRgYAorICAgIFNlbGVjdHMgdGFyZ2V0IGFyY2hpdGVjdHVy
ZSAoJy10YXJnZXQgaGVscCcgZm9yIGxpc3QpCitFUlNUCisKIERFRigibWFjaGluZSIsIEhB
U19BUkcsIFFFTVVfT1BUSU9OX21hY2hpbmUsIFwKICAgICAiLW1hY2hpbmUgW3R5cGU9XW5h
bWVbLHByb3A9dmFsdWVbLC4uLl1dXG4iCiAgICAgIiAgICAgICAgICAgICAgICBzZWxlY3Rz
IGVtdWxhdGVkIG1hY2hpbmUgKCctbWFjaGluZSBoZWxwJyBmb3IgbGlzdClcbiIKZGlmZiAt
LWdpdCBhL3N5c3RlbS92bC5jIGIvc3lzdGVtL3ZsLmMKaW5kZXggYmQ3YjlhOGYxNGFjMi4u
Zjg4OTU5NGM4OGQ4NCAxMDA2NDQKLS0tIGEvc3lzdGVtL3ZsLmMKKysrIGIvc3lzdGVtL3Zs
LmMKQEAgLTI4NCw2ICsyODQsMTUgQEAgc3RhdGljIFFlbXVPcHRzTGlzdCBxZW11X2FjY2Vs
X29wdHMgPSB7CiAgICAgfSwKIH07CiAKK3N0YXRpYyBRZW11T3B0c0xpc3QgcWVtdV90YXJn
ZXRfb3B0cyA9IHsKKyAgICAubmFtZSA9ICJ0YXJnZXQiLAorICAgIC5pbXBsaWVkX29wdF9u
YW1lID0gInRhcmdldCIsCisgICAgLmhlYWQgPSBRVEFJTFFfSEVBRF9JTklUSUFMSVpFUihx
ZW11X3RhcmdldF9vcHRzLmhlYWQpLAorICAgIC5kZXNjID0geworICAgICAgICB7IC8qIGVu
ZCBvZiBsaXN0ICovIH0sCisgICAgfSwKK307CisKIHN0YXRpYyBRZW11T3B0c0xpc3QgcWVt
dV9ib290X29wdHMgPSB7CiAgICAgLm5hbWUgPSAiYm9vdC1vcHRzIiwKICAgICAuaW1wbGll
ZF9vcHRfbmFtZSA9ICJvcmRlciIsCkBAIC0yOTAxLDYgKzI5MTAsNyBAQCB2b2lkIHFlbXVf
aW5pdChpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAgICAgcWVtdV9hZGRfb3B0cygmcWVtdV9z
ZW1paG9zdGluZ19jb25maWdfb3B0cyk7CiAgICAgcWVtdV9hZGRfb3B0cygmcWVtdV9md19j
Zmdfb3B0cyk7CiAgICAgcWVtdV9hZGRfb3B0cygmcWVtdV9hY3Rpb25fb3B0cyk7CisgICAg
cWVtdV9hZGRfb3B0cygmcWVtdV90YXJnZXRfb3B0cyk7CiAgICAgcWVtdV9hZGRfcnVuX3dp
dGhfb3B0cygpOwogICAgIG1vZHVsZV9jYWxsX2luaXQoTU9EVUxFX0lOSVRfT1BUUyk7CiAK
QEAgLTI5MTAsNyArMjkyMCwyNiBAQCB2b2lkIHFlbXVfaW5pdChpbnQgYXJnYywgY2hhciAq
KmFyZ3YpCiAgICAgb3Nfc2V0dXBfbGltaXRzKCk7CiAKICAgICBtb2R1bGVfY2FsbF9pbml0
KE1PRFVMRV9JTklUX1RBUkdFVF9JTkZPKTsKLSAgICB0YXJnZXRfaW5mb19xb21fc2V0X3Rh
cmdldCgpOworCisgICAgLyoKKyAgICAgKiBJZGVudGlmeSB0YXJnZXQ6IGZpcnN0IGZyb20g
b3B0aW9uLCB0aGVuIGZyb20gYXJndlswXS4KKyAgICAgKiBUaGlzIGhhcHBlbnMgZXZlbiBi
ZWZvcmUgaGFuZGxpbmcgLS1oZWxwIG9wdGlvbiwgYmVjYXVzZSBpdCBtYXkgY29udGFpbgor
ICAgICAqIGVudHJpZXMgdGhhdCBhcmUgdGFyZ2V0IHNwZWNpZmljLgorICAgICAqLworICAg
IGZvciAoaW50IGlkeCA9IDE7IGlkeCA8IGFyZ2M7KSB7CisgICAgICAgIGlmIChhcmd2W2lk
eF1bMF0gIT0gJy0nKSB7CisgICAgICAgICAgICBpZHgrKzsKKyAgICAgICAgfSBlbHNlIHsK
KyAgICAgICAgICAgIGNvbnN0IFFFTVVPcHRpb24gKnBvcHQgPSBsb29rdXBfb3B0KGFyZ2Ms
IGFyZ3YsICZvcHRhcmcsICZpZHgpOworICAgICAgICAgICAgaWYgKHBvcHQtPmluZGV4ID09
IFFFTVVfT1BUSU9OX3RhcmdldCkgeworICAgICAgICAgICAgICAgIHRhcmdldF9pbmZvX3Fv
bV9zZXRfdGFyZ2V0X2Zyb21fbmFtZShvcHRhcmcpOworICAgICAgICAgICAgICAgIGJyZWFr
OworICAgICAgICAgICAgfQorICAgICAgICB9CisgICAgfQorICAgIGlmICghdGFyZ2V0X2lu
Zm8oKSkgeworICAgICAgICB0YXJnZXRfaW5mb19xb21fc2V0X3RhcmdldCgpOworICAgIH0K
IAogICAgIG1vZHVsZV9pbml0X2luZm8ocWVtdV9tb2RpbmZvKTsKICAgICBtb2R1bGVfYWxs
b3dfYXJjaCh0YXJnZXRfbmFtZSgpKTsKQEAgLTI5NTgsNiArMjk4Nyw5IEBAIHZvaWQgcWVt
dV9pbml0KGludCBhcmdjLCBjaGFyICoqYXJndikKICAgICAgICAgICAgICAgICBleGl0KDEp
OwogICAgICAgICAgICAgfQogICAgICAgICAgICAgc3dpdGNoKHBvcHQtPmluZGV4KSB7Cisg
ICAgICAgICAgICBjYXNlIFFFTVVfT1BUSU9OX3RhcmdldDoKKyAgICAgICAgICAgICAgICAv
KiBoYW5kbGVkIHByZXZpb3VzbHksIGlnbm9yZSBpdCBoZXJlICovCisgICAgICAgICAgICAg
ICAgYnJlYWs7CiAgICAgICAgICAgICBjYXNlIFFFTVVfT1BUSU9OX2NwdToKICAgICAgICAg
ICAgICAgICAvKiBodyBpbml0aWFsaXphdGlvbiB3aWxsIGNoZWNrIHRoaXMgKi8KICAgICAg
ICAgICAgICAgICBjcHVfb3B0aW9uID0gb3B0YXJnOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0LWlu
Zm8tcW9tLmMgYi90YXJnZXQtaW5mby1xb20uYwppbmRleCA3OTU4YTVjYzY4NWY5Li41YTNh
YmVjZWI3NjcyIDEwMDY0NAotLS0gYS90YXJnZXQtaW5mby1xb20uYworKysgYi90YXJnZXQt
aW5mby1xb20uYwpAQCAtOSw2ICs5LDcgQEAKICNpbmNsdWRlICJxZW11L29zZGVwLmgiCiAj
aW5jbHVkZSAicWFwaS9lcnJvci5oIgogI2luY2x1ZGUgInFvbS9vYmplY3QuaCIKKyNpbmNs
dWRlICJxZW11L2Vycm9yLXJlcG9ydC5oIgogI2luY2x1ZGUgInFlbXUvdGFyZ2V0LWluZm8t
aW1wbC5oIgogI2luY2x1ZGUgInFlbXUvdGFyZ2V0LWluZm8taW5pdC5oIgogI2luY2x1ZGUg
InFlbXUvdGFyZ2V0LWluZm8tcW9tLmgiCkBAIC03Myw2ICs3NCwzNiBAQCB2b2lkIHRhcmdl
dF9pbmZvX3FvbV9zZXRfdGFyZ2V0KHZvaWQpCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAibm8gdGFyZ2V0LWluZm8gaXMgYXZhaWxhYmxlIiA6CiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAibW9yZSB0aGFuIG9uZSB0YXJnZXQtaW5mbyBpcyBhdmFp
bGFibGUiKTsKICAgICB9Ci0KICAgICB0YXJnZXRfaW5mb19wdHIgPSBUQVJHRVRfSU5GT19D
TEFTUyh0YXJnZXRzLT5kYXRhKS0+dGFyZ2V0X2luZm87CiB9CisKK3N0YXRpYyB2b2lkIGxp
c3RfdGFyZ2V0c19hdmFpbGFibGUodm9pZCkKK3sKKyAgICBwcmludGYoIkxpc3Qgb2YgdGFy
Z2V0cyBhdmFpbGFibGU6XG4iKTsKKyAgICBnX2F1dG9wdHIoR1NMaXN0KSB0YXJnZXRzID0g
b2JqZWN0X2NsYXNzX2dldF9saXN0X3NvcnRlZChUWVBFX1RBUkdFVF9JTkZPLCBmYWxzZSk7
CisgICAgZm9yIChHU0xpc3QgKmVsZW0gPSB0YXJnZXRzOyBlbGVtOyBlbGVtID0gZWxlbS0+
bmV4dCkgeworICAgICAgICBjb25zdCBUYXJnZXRJbmZvICp0aSA9IFRBUkdFVF9JTkZPX0NM
QVNTKGVsZW0tPmRhdGEpLT50YXJnZXRfaW5mbzsKKyAgICAgICAgcHJpbnRmKCItICVzXG4i
LCB0aS0+dGFyZ2V0X25hbWUpOworICAgIH0KK30KKwordm9pZCB0YXJnZXRfaW5mb19xb21f
c2V0X3RhcmdldF9mcm9tX25hbWUoY29uc3QgY2hhciAqbmFtZSkKK3sKKyAgICBpZiAoIXN0
cmNtcChuYW1lLCAiaGVscCIpKSB7CisgICAgICAgIGxpc3RfdGFyZ2V0c19hdmFpbGFibGUo
KTsKKyAgICAgICAgZXhpdCgwKTsKKyAgICB9CisKKyAgICBnX2F1dG9wdHIoR1NMaXN0KSB0
YXJnZXRzID0gb2JqZWN0X2NsYXNzX2dldF9saXN0KFRZUEVfVEFSR0VUX0lORk8sIGZhbHNl
KTsKKyAgICBmb3IgKEdTTGlzdCAqZWxlbSA9IHRhcmdldHM7IGVsZW07IGVsZW0gPSBlbGVt
LT5uZXh0KSB7CisgICAgICAgIGNvbnN0IFRhcmdldEluZm8gKnRpID0gVEFSR0VUX0lORk9f
Q0xBU1MoZWxlbS0+ZGF0YSktPnRhcmdldF9pbmZvOworICAgICAgICBpZiAoIXN0cmNtcChu
YW1lLCB0aS0+dGFyZ2V0X25hbWUpKSB7CisgICAgICAgICAgICB0YXJnZXRfaW5mb19wdHIg
PSB0aTsKKyAgICAgICAgICAgIHJldHVybjsKKyAgICAgICAgfQorICAgIH0KKworICAgIGVy
cm9yX3JlcG9ydCgidGFyZ2V0ICclcycgaXMgbm90IGF2YWlsYWJsZSIsIG5hbWUpOworICAg
IGxpc3RfdGFyZ2V0c19hdmFpbGFibGUoKTsKKyAgICBleGl0KDEpOworfQo=

--------------aoXGcc1JabHcVkSZJcMT8BSp--

