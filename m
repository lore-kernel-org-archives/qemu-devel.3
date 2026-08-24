Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7721EC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyXPw-0000GU-BH; Mon, 24 Aug 2026 12:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wyXPq-00009T-W1
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 12:20:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wyXPj-0001BJ-Az
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 12:20:54 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OFmq2H2857136
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 16:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=QarRks+gJGQhwE7iWD/xbdr/
 NfkL13gWb6JqEtCMovk=; b=jKUA6wzVGwV8pAYvIATYqy+PR/OFeQK/aAzkw1tA
 xJDsFZXQeWxvHEfqSR0qSBNUna5OMbbsIrTmv1tyczHlrwVQjLkYaxLdj/AWLkhT
 Tizn1VDkcncPaBW5nuGth1wvyk1CemBFKvYagnYJSN67hDeoPfq+rSeipqxc8UAe
 nIERmHeVoyar+lEinXhyo3bSaw5CE8TJbtpuYeC30V70ciHQpiK9JZ9gnduEPCmh
 wQelHWHSs8jqSud2+9N85+6slz2zJAFvezNMiOLuWXu1i4s29e/c0THDTSPwN3Jk
 FblaXJZlTVogapYr6VhSAIbdwrUlZZHPRoo+g+x5NaZ6JQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8kdshqm4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 16:20:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e8e864ef0so7188535a91.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 09:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787588444; x=1788193244; darn=nongnu.org;
 h=in-reply-to:content-language:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QarRks+gJGQhwE7iWD/xbdr/NfkL13gWb6JqEtCMovk=;
 b=FQWvqPvhD+n7u6Xqv8pvHj6Aimy1WtHW99vyAgIjt3BVIdaPwvqkMSzmruvO6xTiaJ
 VvRxMMFBd5fP8vgkwW0Thra+47UWe+k7v8sJg4UUFGKURzCtxIk1UjPE8yR+5Xj9oZfP
 g9O8UPJjUCToNw58gfSdXO0PNZAFNXYd/W/wGgqymTQrOUjUCQ7F46Mcs+k7UQ/aBWwc
 cHMxGlqwifPLhX+oFVjEpEKBY8QdrR8oE7bkgtfuLXxzOGMTxJLA+gsJZtY4AvMTkFLe
 aXN7uWhI5vJc+LOEJ/SwRc3Qi3xdtwa8Sich75GHcGUyc0QccsohEpwQd9QuIuksWZnZ
 RgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787588444; x=1788193244;
 h=in-reply-to:content-language:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QarRks+gJGQhwE7iWD/xbdr/NfkL13gWb6JqEtCMovk=;
 b=AdRfjZc3ceQpXfYvqV6cz7yMEZKfC2nefPifyGJhHV4aT5jDORgMtRyy3+jUMDjZPp
 KDiJWT/1+Q2FwI28o/InchAMUdaypo+NDdhR/cvQzjxINco6lN7ZU6aHS23ypN0YfLA6
 NzO83ouC9KkMFUOckDf/0XedP0k3W5Ri+P6WenpXe77r96uoUhLZ0DpKmo/XzLLQF5Fu
 joqZ/EZIDTsUnok6CVwxx0SSpa+cLVWz2rKO/GVBg44jFx7x7XYEjTW30zlwTqYv7erc
 i96IY+CgBTO2fOmwgki8euTD+roSIqaXg1RRfGEGzi9BvhgPiH2Uw/+AX87V+9y2FCAL
 CO4g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqKPNry2o0PjiyYj3TUhuiqmCwVXAIXWa0OffvJtnThd1cnAMiniHOjqxfoK1yfSlLGHVGBx8bdA2iK@nongnu.org
X-Gm-Message-State: AFuF++kkuInHZOxGcww/ubKw+oSmvkZkAZ8mXmyPG8/vOigpDa6mzFq5
 sjjhN96Xa25clT8LRkafd2o2F1AWPe8g7W3saQQYm/GY7fag+ojpTOQL67XFsTgPoSKWD301srb
 /kCBPuLMDCaFX3lyDqW0K+/FCV6Ej9EHmhiDMc9IFk5yCu+XjL9OcUEsm8g==
X-Gm-Gg: AR+sD11mk2xy/eoYnxApM9V9mj4XUaL4HwtEGm2a3Yodi82XLWq4S+zwuXCz+okE212
 zhbtQ/feKRp9Zc7i4pAWq85YcABpJDSJblu+kzl9uDKQMPxgJjk0kVTNR8l92WN4Y00KnWwpZRg
 0rK5SMHrAU0BtQkup3CQDLT5nrosPrTIWuTTQwdRo0GaKRqMsc9f13KlolwLamFNB28wwOwK6gH
 wy3/d1jyj6a7NgGQ9mwhjpGaQMBS7PwiTBUQxeqyN+VBKCYuWmFnx4oDjM0F6WPfabJ0NxpOmeT
 ed4bn690UF3+oMxtWwQdZXbkNpE/rEN1cFCBYS7pNd3bfuQZpUc0byoP4bwGig2Ccsj3SZ9OIwP
 n0V7mFg5X4LLQlLAhMdVR6KBIp1QHEDulh1osDQz4G3Al36LYDvgqIM4F9UBR2SxT9OvU
X-Received: by 2002:a17:90b:1b04:b0:38d:dfd1:7c1 with SMTP id
 98e67ed59e1d1-395c33406e0mr46672377a91.2.1787588444048; 
 Mon, 24 Aug 2026 09:20:44 -0700 (PDT)
X-Received: by 2002:a17:90b:1b04:b0:38d:dfd1:7c1 with SMTP id
 98e67ed59e1d1-395c33406e0mr46672188a91.2.1787588443278; 
 Mon, 24 Aug 2026 09:20:43 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1418619d6ecsm25727002c88.14.2026.08.24.09.20.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 09:20:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------Y1YbvhavawekLLmLAYAwQoLQ"
Message-ID: <b9f0853b-adda-457d-94e1-add9bb2a2548@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 09:20:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] meson: link ARM and RISC-V into qemu-system
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
 <20260823150731.896-13-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260823150731.896-13-luoyonggang@gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzNyBTYWx0ZWRfX4BMZtOID3Dic
 goOoGfnonDjeiRYU8F3nFXF7HA92f8CHRXcPU3mXeoLEV3R64wKtsGqwvtJ0ExflncAh6i+J4RB
 Ou5dXJQmjqYuLaX6MfSWSzAur7E+mjk=
X-Proofpoint-ORIG-GUID: STwkonCKMZrRKpLghg5P645z2NGlosCs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzNyBTYWx0ZWRfX1hhkvKWswcOy
 PYi3mOWkxX/tV25goWM6rIkQ3TZurB+emFfHkwZkmNe3kUuo1PNn/s2npXekwESFBH2sP2dqTcU
 ScKIEI/92nFC1PCV6Hin0XSWm5DEqk5uRmze6OX1WOy6SOR+ftOvW5Xxqco22F9Sw68S/K7scyE
 f9+3cNod1wobKvlv8LeAP1LeRpY0XB8Nl/o7W2YxIv8Ej55pOFuWHJQ5zpKKZqsCTb41lHRMSrW
 Y47P8h7/Z1hbdSN9tqRQQ3zp126jhzonSKrN8zihERS9clOM1NB/mQJfvmAcjpCM9f1d9aG/VLq
 PDJ70wHBL0QSeuhTv0AXHJwuFv8ifQmSILyuH/93hJ98AKt6B1O1+2id0s+xl+ceVxUe1Qdw6j5
 BqOTHksl/U7rh8NSH10tWkSzTlOrPH7M+FTmPInoZKll/ULyCD7AysUTIBczEamkDwj4aMFMwaW
 GiqFtkSurMNVMWr3c7Q==
X-Proofpoint-GUID: STwkonCKMZrRKpLghg5P645z2NGlosCs
X-Authority-Analysis: v=2.4 cv=d8DFDxjE c=1 sm=1 tr=0 ts=6a8c6f5d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=pGLkceISAAAA:8 a=A_whQAWMKvOnfy3BOIUA:9 a=QEXdDO2ut3YA:10
 a=dtgYW6BSnhTwMfQShTcA:9 a=m-Z_27IZkzAA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240137
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
--------------Y1YbvhavawekLLmLAYAwQoLQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/23/2026 8:07 AM, Yonggang Luo wrote:
> - Build qemu-system (and qemu-systemw on Windows) from aarch64
>   common/system objects plus RISC-V arch objects taken from the
>   existing riscv64 lib.
> - Pull 32-bit TargetInfo and 32-only boards from the arm/riscv32
>   libs so hw/arm and target/riscv are not compiled twice.
> - Skip linking qemu-system-{arm,aarch64,riscv32,riscv64} and the
>   Windows *w variants; symlink those names to qemu-system so
>   argv[0] still selects TargetInfo.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  meson.build | 156 +++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 147 insertions(+), 9 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 449d50f2983..b4f435f6a22 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4250,6 +4250,10 @@ endif
>  
>  traceable = []
>  emulators = {}
> +target_softmmu = {}
> +combo_softmmu = ['aarch64-softmmu', 'arm-softmmu', 'riscv32-softmmu', 'riscv64-softmmu']
> +have_qemu_system_combo = ('aarch64-softmmu' in target_dirs
> +                          and 'riscv64-softmmu' in target_dirs)
>  foreach target : target_dirs
>    config_target = config_target_mak[target]
>    target_name = config_target['TARGET_NAME']
> @@ -4399,20 +4403,37 @@ foreach target : target_dirs
>                   c_args: c_args,
>                   build_by_default: false)
>  
> +  if target in combo_softmmu
> +    target_softmmu += {target: {
> +      'lib': lib,
> +      'arch_srcs': arch_srcs,
> +      'arch_deps': arch_deps,
> +      'c_args': c_args,
> +      'link_args': link_args,
> +      'target_stubs': target_stubs,
> +      'main_rs': main_rs,
> +      'config_target': config_target,
> +      'target_base_arch': target_base_arch,
> +    }}
> +  endif
> +
>    if target.endswith('-softmmu')
> -    execs = [{
> -      'name': 'qemu-system-' + target_name,
> -      'win_subsystem': 'console',
> -      'sources': [main_rs, files('system/main.c')],
> -      'dependencies': [sdl, target_stubs],
> -    }]
> -    if host_os == 'windows' and (sdl.found() or gtk.found())
> +    execs = []
> +    if not (have_qemu_system_combo and target in combo_softmmu)
>        execs += [{
> -        'name': 'qemu-system-' + target_name + 'w',
> -        'win_subsystem': 'windows',
> +        'name': 'qemu-system-' + target_name,
> +        'win_subsystem': 'console',
>          'sources': [main_rs, files('system/main.c')],
>          'dependencies': [sdl, target_stubs],
>        }]
> +      if host_os == 'windows' and (sdl.found() or gtk.found())
> +        execs += [{
> +          'name': 'qemu-system-' + target_name + 'w',
> +          'win_subsystem': 'windows',
> +          'sources': [main_rs, files('system/main.c')],
> +          'dependencies': [sdl, target_stubs],
> +        }]
> +      endif
>      endif
>      if get_option('fuzzing')
>        specific_fuzz = specific_fuzz_ss.apply(config_target, strict: false)
> @@ -4481,6 +4502,123 @@ foreach target : target_dirs
>    endforeach
>  endforeach
>  
> +# Combined ARM + RISC-V system emulator (32 and 64).
> +# Common/system objects come from aarch64. RISC-V arch objects come
> +# from the existing riscv64 lib. 32-bit TargetInfo and 32-only boards
> +# come from the arm/riscv32 libs. Per-target qemu-system-* names are
> +# symlinks to qemu-system (argv[0] selects TargetInfo).
> +if have_qemu_system_combo
> +  a64 = target_softmmu['aarch64-softmmu']
> +  rv = target_softmmu['riscv64-softmmu']
> +  extra_objs = []
> +  target_info_def = files('target-info-def.c')
> +  foreach spec : [[common_ss, common_all], [system_ss, libsystem]]
> +    rv_src = spec[0].apply(rv['config_target'], strict: false)
> +    a64_src = spec[0].apply(a64['config_target'], strict: false)
> +    extra = []
> +    foreach f : rv_src.sources()
> +      if f not in a64_src.sources() and not f.full_path().endswith('_stubs.c')
> +        extra += f
> +      endif
> +    endforeach
> +    if extra.length() > 0
> +      extra_objs += spec[1].extract_objects(extra)
> +    endif
> +  endforeach
> +  rv_base = rv['target_base_arch']
> +  if rv_base in target_common_arch_libs
> +    src = target_common_arch[rv_base].apply(rv['config_target'], strict: false)
> +    extra_objs += target_common_arch_libs[rv_base].extract_objects(src.sources())
> +  endif
> +  if rv_base in target_common_system_arch_libs
> +    src = target_common_system_arch[rv_base].apply(rv['config_target'], strict: false)
> +    extra_objs += target_common_system_arch_libs[rv_base].extract_objects(src.sources())
> +  endif
> +  foreach pair : [['arm-softmmu', 'aarch64-softmmu'], ['riscv32-softmmu', 'riscv64-softmmu']]
> +    t32 = pair[0]
> +    t64 = pair[1]
> +    if t32 in target_softmmu
> +      extra_objs += target_softmmu[t32]['lib'].extract_objects(target_info_def)
> +      base32 = target_softmmu[t32]['target_base_arch']
> +      if base32 in hw_arch
> +        hw32 = hw_arch[base32].apply(target_softmmu[t32]['config_target'], strict: false)
> +        hw64 = hw_arch[base32].apply(target_softmmu[t64]['config_target'], strict: false)
> +        extra_hw = []
> +        foreach f : hw32.sources()
> +          if f not in hw64.sources()
> +            extra_hw += f
> +          endif
> +        endforeach
> +        if extra_hw.length() > 0
> +          extra_objs += target_softmmu[t32]['lib'].extract_objects(extra_hw)
> +        endif
> +      endif
> +    endif
> +  endforeach
> +  combo_objects = extra_objs
> +  combo_objects += a64['lib'].extract_all_objects(recursive: true)
> +  combo_objects += rv['lib'].extract_objects(rv['arch_srcs'])
> +  combo_deps = a64['arch_deps'] + rv['arch_deps'] + [sdl, a64['target_stubs'], rv['target_stubs']]
> +  if 'arm-softmmu' in target_softmmu
> +    combo_deps += target_softmmu['arm-softmmu']['arch_deps']
> +  endif
> +  if 'riscv32-softmmu' in target_softmmu
> +    combo_deps += target_softmmu['riscv32-softmmu']['arch_deps']
> +  endif
> +  combo_execs = [{
> +    'name': 'qemu-system',
> +    'win_subsystem': 'console',
> +  }]
> +  if host_os == 'windows' and (sdl.found() or gtk.found())
> +    combo_execs += [{
> +      'name': 'qemu-systemw',
> +      'win_subsystem': 'windows',
> +    }]
> +  endif
> +  combo_exe_suffix = host_os == 'windows' ? '.exe' : ''
> +  combo_alias_py = 'import os, sys; src, dst = sys.argv[1:3]; os.path.exists(dst) and os.remove(dst); os.symlink(os.path.basename(src), dst)'
> +  foreach exe : combo_execs
> +    emulator = executable(exe['name'], [a64['main_rs'], files('system/main.c')],
> +               install: true,
> +               c_args: a64['c_args'],
> +               dependencies: combo_deps,
> +               objects: combo_objects,
> +               link_depends: [block_syms, qemu_syms],
> +               link_args: a64['link_args'],
> +               win_subsystem: exe['win_subsystem'])
> +    emulators += {exe['name']: emulator}
> +    traceable += [{
> +      'exe': exe['name'],
> +      'probe-prefix': 'qemu.system.multi',
> +    }]
> +    foreach t : combo_softmmu
> +      if t not in target_softmmu
> +        continue
> +      endif
> +      tname = target_softmmu[t]['config_target']['TARGET_NAME']
> +      if exe['name'] == 'qemu-systemw'
> +        alias = 'qemu-system-' + tname + 'w'
> +      else
> +        alias = 'qemu-system-' + tname
> +      endif
> +      alias_tgt = custom_target(alias,
> +                                input: emulator,
> +                                output: alias + combo_exe_suffix,
> +                                command: [python, '-c', combo_alias_py, '@INPUT@', '@OUTPUT@'],
> +                                build_by_default: true,
> +                                install: false)
> +      emulators += {alias: alias_tgt}
> +      install_symlink(alias + combo_exe_suffix,
> +                      pointing_to: exe['name'] + combo_exe_suffix,
> +                      install_dir: get_option('bindir'))
> +      traceable += [{
> +        'exe': alias,
> +        'probe-prefix': 'qemu.system.' + tname,
> +      }]
> +    endforeach
> +  endforeach
> +endif
> +
>  # Other build targets
>  
>  if get_option('plugins')

Please find attached a much simpler implementation, which only requires
a single line update as we add new targets in single-binary.

Regards,
Pierrick
--------------Y1YbvhavawekLLmLAYAwQoLQ
Content-Type: text/plain; charset=UTF-8;
 name="6261b0c255e1a8f0df2b41928b8dfb365d0fa488.patch.txt"
Content-Disposition: attachment;
 filename="6261b0c255e1a8f0df2b41928b8dfb365d0fa488.patch.txt"
Content-Transfer-Encoding: base64

RnJvbSA2MjYxYjBjMjU1ZTFhOGYwZGYyYjQxOTI4YjhkZmIzNjVkMGZhNDg4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2
aWVyQG9zcy5xdWFsY29tbS5jb20+CkRhdGU6IFR1ZSwgMTQgQXByIDIwMjYgMTA6NTY6MTUg
LTA3MDAKU3ViamVjdDogW1BBVENIXSBtZXNvbjogYnVpbGQgc2luZ2xlIGJpbmFyeQoKVGhp
cyBpcyBub3QgYnVpbHQgYnkgZGVmYXVsdC4KQnVpbGQgd2l0aDogbmluamEgLUMgYnVpbGQg
cWVtdS1zeXN0ZW0KCkFsbCBhdmFpbGFibGUgKi1zb2Z0bW11IHRhcmdldHMgYXJlIGFnZ3Jl
Z2F0ZWQsIC4vY29uZmlndXJlCi0tdGFyZ2V0LWxpc3QgY2FuIGJlIHVzZWQgdG8gcmVzdHJp
Y3Qgd2hpY2ggdGFyZ2V0cyBhcmUgaW5jbHVkZWQuCgpJbiBjYXNlIHVzZXIgaGFzIHRhcmdl
dHMgdGhhdCBhcmUgbm90IHN1cHBvcnRlZCwgd2UgZW1pdCBhbiBlcnJvcgptZXNzYWdlIHdo
ZW4gYnVpbGQgcWVtdS1zeXN0ZW0gdGFyZ2V0LiBUaGlzIHdheSwgaXQncyBub3QgbmVjZXNz
YXJ5IHRvCmhhdmUgYSBjdXN0b20gY29uZmlndXJlIGZsYWcsIGFuZCBxZW11LXN5c3RlbSBj
YW4gbGl2ZSBuZXh0IHRvIGV4aXN0aW5nCmJpbmFyaWVzIHdpdGhvdXQgY29tcGxleGlmeWlu
ZyB0aGUgd29ya2Zsb3cgbW9yZSB0aGFuIGl0IGlzIGFscmVhZHkuCgpTaWduZWQtb2ZmLWJ5
OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+
Ci0tLQogbWVzb24uYnVpbGQgfCA0OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvbWVzb24uYnVpbGQgYi9tZXNvbi5idWlsZAppbmRleCA1NTNkZjNlN2Yw
NTMuLjRhMzFhNTIwZDllYiAxMDA2NDQKLS0tIGEvbWVzb24uYnVpbGQKKysrIGIvbWVzb24u
YnVpbGQKQEAgLTQyNjQsNiArNDI2NCw5IEBAIGlmIGhvc3Rfb3MgPT0gJ2RhcndpbicKIGVu
ZGlmCiAKIHRyYWNlYWJsZSA9IFtdCitzaW5nbGVfYmluYXJ5X2xpYnMgPSBbXQorc2luZ2xl
X2JpbmFyeV9kZXBzID0gW10KK3NpbmdsZV9iaW5hcnlfY3JhdGVzID0gW10KIGVtdWxhdG9y
cyA9IHt9CiBmb3JlYWNoIHRhcmdldCA6IHRhcmdldF9kaXJzCiAgIGNvbmZpZ190YXJnZXQg
PSBjb25maWdfdGFyZ2V0X21ha1t0YXJnZXRdCkBAIC00NDE5LDYgKzQ0MjIsMTAgQEAgZm9y
ZWFjaCB0YXJnZXQgOiB0YXJnZXRfZGlycwogICAgICAgICAgICAgICAgICBidWlsZF9ieV9k
ZWZhdWx0OiBmYWxzZSkKIAogICBpZiB0YXJnZXQuZW5kc3dpdGgoJy1zb2Z0bW11JykKKyAg
ICBzaW5nbGVfYmluYXJ5X2xpYnMgKz0gbGliCisgICAgc2luZ2xlX2JpbmFyeV9kZXBzICs9
IGFyY2hfZGVwcworICAgIHNpbmdsZV9iaW5hcnlfZGVwcyArPSB0YXJnZXRfc3R1YnMKKyAg
ICBzaW5nbGVfYmluYXJ5X2NyYXRlcyArPSBtYWluX3JzCiAgICAgZXhlY3MgPSBbewogICAg
ICAgJ25hbWUnOiAncWVtdS1zeXN0ZW0tJyArIHRhcmdldF9uYW1lLAogICAgICAgJ3dpbl9z
dWJzeXN0ZW0nOiAnY29uc29sZScsCkBAIC00NTAwLDYgKzQ1MDcsNDcgQEAgZm9yZWFjaCB0
YXJnZXQgOiB0YXJnZXRfZGlycwogICBlbmRmb3JlYWNoCiBlbmRmb3JlYWNoCiAKK3Npbmds
ZV9iaW5hcnlfb2JqZWN0cyA9IFtdCitmb3JlYWNoIGxpYjogc2luZ2xlX2JpbmFyeV9saWJz
CisgIHNpbmdsZV9iaW5hcnlfb2JqZWN0cyArPSBsaWIuZXh0cmFjdF9hbGxfb2JqZWN0cyhy
ZWN1cnNpdmU6IHRydWUpCitlbmRmb3JlYWNoCisKK3NpbmdsZV9iaW5hcnlfbGlua19hcmdz
ID0gZW11bGF0b3JfbGlua19hcmdzCitzaW5nbGVfYmluYXJ5X2xpbmtfYXJncyArPSBlbmFi
bGVfbW9kdWxlcyA/IFsnQGJsb2NrLnN5bXMnLCAnQHFlbXUuc3ltcyddIDogW10KKworc3Vw
cG9ydGVkX3RhcmdldHMgPSBbCisgICdhYXJjaDY0LXNvZnRtbXUnLAorICAnYXJtLXNvZnRt
bXUnLAorXQordW5zdXBwb3J0ZWRfdGFyZ2V0cyA9IFtdCitmb3JlYWNoIHRhcmdldCA6IHRh
cmdldF9kaXJzCisgIGlmIHRhcmdldC5lbmRzd2l0aCgnLXNvZnRtbXUnKSBhbmQgdGFyZ2V0
IG5vdCBpbiBzdXBwb3J0ZWRfdGFyZ2V0cworICAgIHVuc3VwcG9ydGVkX3RhcmdldHMgKz0g
dGFyZ2V0CisgIGVuZGlmCitlbmRmb3JlYWNoCisKK2lmIHVuc3VwcG9ydGVkX3RhcmdldHMu
bGVuZ3RoKCkgPT0gMAorICBleGVjdXRhYmxlKCdxZW11LXN5c3RlbScsCisgICAgICAgICAg
ICAgc291cmNlczogW3NpbmdsZV9iaW5hcnlfY3JhdGVzLCBmaWxlcygnc3lzdGVtL21haW4u
YycpXSwKKyAgICAgICAgICAgICBkZXBlbmRlbmNpZXM6IHNpbmdsZV9iaW5hcnlfZGVwcywK
KyAgICAgICAgICAgICBvYmplY3RzOiBzaW5nbGVfYmluYXJ5X29iamVjdHMsCisgICAgICAg
ICAgICAgbGlua19kZXBlbmRzOiBbYmxvY2tfc3ltcywgcWVtdV9zeW1zXSwKKyAgICAgICAg
ICAgICBsaW5rX2FyZ3M6IHNpbmdsZV9iaW5hcnlfbGlua19hcmdzLAorICAgICAgICAgICAg
IGJ1aWxkX2J5X2RlZmF1bHQ6IGZhbHNlKQorZWxzZQorICBlcnJvcl9zdHIgPSBmJycncWVt
dS1zeXN0ZW0gb25seSBzdXBwb3J0IHRhcmdldHM6CitAc3VwcG9ydGVkX3RhcmdldHNACisK
K3Vuc3VwcG9ydGVkIHRhcmdldHM6CitAdW5zdXBwb3J0ZWRfdGFyZ2V0c0AKKwordXNlIC4v
Y29uZmlndXJlIC0tdGFyZ2V0LWxpc3Q9IHRvIGNob29zZSBsaXN0IG9mIHRhcmdldHMnJycK
KyAgdCA9IGN1c3RvbV90YXJnZXQoY29tbWFuZDogWydzaCcsICctYycsICdlY2hvICInICsg
ZXJyb3Jfc3RyICsgJyIgJiYgZXhpdCAxJ10sCisgICAgICAgICAgICAgICAgICAgIG91dHB1
dDogJ25vbmUnLAorICAgICAgICAgICAgICAgICAgICBidWlsZF9ieV9kZWZhdWx0OiBmYWxz
ZSkKKyAgYWxpYXNfdGFyZ2V0KCdxZW11LXN5c3RlbScsIHQpCitlbmRpZgorCiAjIE90aGVy
IGJ1aWxkIHRhcmdldHMKIAogaWYgZ2V0X29wdGlvbigncGx1Z2lucycpCg==

--------------Y1YbvhavawekLLmLAYAwQoLQ--

