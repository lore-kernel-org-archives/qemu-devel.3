Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A4EC5DF9D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyXRB-0001dX-WA; Mon, 24 Aug 2026 12:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wyXRA-0001YA-G5
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 12:22:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wyXR7-0001g7-KS
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 12:22:16 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OFmWTQ2960742
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 16:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vfgMB4pTML5LLhB92ZPYfZFzI4L4O0kkGzL95VEiS8w=; b=Zt8kA9fErliaYIfY
 4a4TVZjeKyi1eGG1GpsoFKjwXFkrUAK/3Kt+s6ifxqtAdtAU1JvIUoctyXTMMMC5
 orSfxePaYZMaUzcXQ+O0m5YO1IJ37eIYwqSmg9cjVbTgK6B9xAjzF/Zqc9oKEo6N
 Z1lJwQVipElEOEWPMmaBfPmeDuC5vN1CHqIKM+/NKs9LsgIEWs3xZe+TQNY2csC4
 NpUkigsfFHxwgESzx07ApgE/89sbRjxv10FQalY9GsPzQgR8iuC9iXfAYQCfAUWP
 7dsrTJboV4THgbYu0vcdNima0K3VsNvaqkS9/kgVr9XHJvIgVlgQEGzQ9AnWLEvq
 ZDeofg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8rqug75m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 16:22:11 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e54b6556aso4285964a91.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 09:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787588531; x=1788193331; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vfgMB4pTML5LLhB92ZPYfZFzI4L4O0kkGzL95VEiS8w=;
 b=NAxcGOZrc/w1FT1yCHlfOX0b80JX2qDZD+rBVoqkLazu+qXxOh3LYr26KhM2Ub2thU
 vqqHGD0XPN2orsJ0K69BQ41+IfwRmoz1ZQQr7pC67r6BzfdBl4D1/BElTisNWjiDS8Mj
 ILPQrwXZMxNEEMDKFflAYlg0yaGYl0c28JTFYFRh0SzCuNDRAhdZGbSm6zD+vt74smEH
 8Gi7EpJkJJaej1pX8evt41yk3KOjVu+q92hyJ+hDdCTWqFT6nHYBGi/iMcqzwczUmB3d
 wJZpZZMvDKqQzlGWsWnT4/XK9LXBrFrQBWLwZfSgbiwumjuHsCoXT7CBf8EbM29qKIiJ
 Geaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787588531; x=1788193331;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vfgMB4pTML5LLhB92ZPYfZFzI4L4O0kkGzL95VEiS8w=;
 b=nVPYkvgIxlHdMW6OevU3uKn2GQY70FmhQ/sSfHCdG9UQn+PD360JMC2pp72ZNe6VMG
 UW5XE31ExFWjm7/DvVhNEWriidcSeFRTG6MYCCNHf5m1AKclZLA5Mw6QibNP8qU8rEbr
 3Xj+jED3WtBy26cimYYsdwxAQFuJcHnVWmedkWrAAIdyw3XeTLw5snLfekdHdi+NkXbk
 Izw+rvwLjkFFbMFHh+b+qYsShOY2bTU426OAj4exSZU5vmfjd8NUKK9/2qWegDDzd0uA
 /qYEs/9CwI5xKLcKtYx6eSdHuMATwke34WbiQfLU52tVGrz70UAowg+B3jRZcXjn5eU7
 LW4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RowpM8Fcsuhg4V8Twft8U5tHjM0cO+moerLeVvB2IOIhK8feR159MKrxO64aJnBbufh54w1ZUzvEJAW@nongnu.org
X-Gm-Message-State: AFuF++nwBeiszpTknyev+5hsRwIImXJps1WjMjclXibWqnVBPnCAmD2k
 3FsYWwKtJ/uYstFbQyl6s5isENHAVGlgopOkq5gQHXLuenD0nZB/zH1fBQ3Gwk285bqvBXmtA2X
 R9dipeQ8hjyYG7Ad3TF1HVLxJwRPrldsDZbeYyso7jMqpD3NpxC+vWf8iJA==
X-Gm-Gg: AR+sD11Ad94tA36lgdz+b1ryGHJ7iFNjE+81XtfEpj/jj6YVi2NaFnjq2nt0g5itSqm
 3ujUyZDB12zt7AJAyF520Za9iA4EPRpL94NihGve224JSzyVsIK1fQO4A2wxuxBVzdyjrE09zgN
 xMqh9fY/7T1WLYaLuEvvueDtktNTGoayti+mTY5lCkseH3snsxc9pY8MXro5WLozVkxIKjGJJvA
 jZv/OAUwhH8ATCJ+GtRyisoB/eUZEUf783XK2JZRLSaHFUVkD55wFSjhiAh0vm3FDO65FDQj0H3
 YgMDE+8XwPosvmEEGOudA+zb9NaGVmrVNJufxr0rj3i263tTxRLmMYXFg/o930uH8WttxutWZF6
 TZ19b80VFC6zj9YnZ3ZkTQm49IJuYoRlImN8hUhDkIfGWSpF1z3voqsjnUrFY1VOGYlbk
X-Received: by 2002:a17:90b:39ab:b0:393:19a3:4e5 with SMTP id
 98e67ed59e1d1-395df686f1dmr34246560a91.16.1787588531148; 
 Mon, 24 Aug 2026 09:22:11 -0700 (PDT)
X-Received: by 2002:a17:90b:39ab:b0:393:19a3:4e5 with SMTP id
 98e67ed59e1d1-395df686f1dmr34246387a91.16.1787588530546; 
 Mon, 24 Aug 2026 09:22:10 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f9236166sm27570254eec.28.2026.08.24.09.22.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 09:22:09 -0700 (PDT)
Message-ID: <9b5a4586-be66-4d69-8d08-fc1796336b2c@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 09:22:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] target-info: register le and be TargetInfo variants
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
 <20260823150731.896-10-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260823150731.896-10-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: iW5G__yKm-vtNyheJnPHVi39SMVZJ9MQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzOCBTYWx0ZWRfX6HizgIUM0ToO
 mMCwuYyHJxySMOqP+FBZuNezsUd58VZLJDOpTWWiz4/mtAYUCP28Q4iI/biYexfWWOQVI+wooyY
 VqgUySD2ia7v/921k8TuYwm1cEoP0dI=
X-Authority-Analysis: v=2.4 cv=CbQ4Irrl c=1 sm=1 tr=0 ts=6a8c6fb3 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=XXGCr3TU2SxsloKilKUA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: iW5G__yKm-vtNyheJnPHVi39SMVZJ9MQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzOCBTYWx0ZWRfX1nP6sV4twla2
 mbaj8xnxC0nhNZVjMFzXc38nzYfkszUoMDEoXHYDo7K6VSvGLXJEF26bQuuFf5ryFOJ4GtxH9na
 8Oko+6zDFC+68eyqSLyPhd3hRXWDxAkQ4O07VRW4pitrIaaXNHy9FFkOLWYMuHWBx9ZYQJNIgwb
 lEqDUsP0G/Lcmc0tiedgvlciPaYuBIw74MwgHH56bpKzdT/iVBdP46nQimWmqf9AJIUpLFd31Km
 /C795mhFN4Rp0AuWQ917uQZfr2s1cMQ3wxMYBUpPzumXesyN67h/omhjRbGj7emqOve73fZ2xVu
 Zjgt9weLhB5uBCPR163MftDo5o1dSDxruYeP0eMX0w3Kzdzle4bpxIXtdkGPqdWlNi3xvX5jcTI
 S0Cuit3RLltgV1/7zdUZDunCNFLpPUcT+M85H/yhyxoCIXOaI/H5iJfWcqkrSMm0D6U5yksNl8Y
 wWAY6OcGlE9L5ewv3Ig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0
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

On 8/23/2026 8:07 AM, Yonggang Luo wrote:
> - Register target-info-<name>-le and -be from one system
>   target-info-def.c unit, sharing arch fields.
> - Mark is_default from TARGET_BIG_ENDIAN so riscv/arm stay LE and
>   ppc/s390x stay BE when -target is omitted.
> - Pick the unique default in target_info_qom_set_target() when more
>   than one TargetInfo is registered. Leave user-mode as a single
>   target_info().
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  include/qemu/target-info-impl.h |  6 ++++
>  include/qemu/target-info-init.h | 29 +++++++++++++---
>  target-info-def.c               | 61 +++++++++++++++++++++++++--------
>  target-info-qom.c               | 33 ++++++++++++++----
>  4 files changed, 104 insertions(+), 25 deletions(-)
> 
> diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
> index de329ec2b86..b4222e4455e 100644
> --- a/include/qemu/target-info-impl.h
> +++ b/include/qemu/target-info-impl.h
> @@ -23,6 +23,12 @@ typedef struct TargetInfo {
>      const char *cpu_type;
>      /* related to TARGET_BIG_ENDIAN definition */
>      EndianMode endianness;
> +    /*
> +     * True on the endian variant that matches this translation unit's
> +     * TARGET_BIG_ENDIAN. target_info_qom_set_target() uses this when
> +     * more than one TargetInfo is registered and -target is omitted.
> +     */
> +    bool is_default;
>      /*
>       * runtime equivalent of
>       *   TARGET_PAGE_BITS_VARY ? TARGET_PAGE_BITS_LEGACY : TARGET_PAGE_BITS
> diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-init.h
> index b7024c9faef..25d00adcc66 100644
> --- a/include/qemu/target-info-init.h
> +++ b/include/qemu/target-info-init.h
> @@ -37,15 +37,34 @@ const TargetInfo *target_info(void)     \
>  #include "qemu/target-info-qom.h"
>  #include "qom/object.h"
>  
> -#define target_info_init(ti_var)                                            \
> -static const TypeInfo target_info_qom_target_type_info = {                  \
> -    .name =  TYPE_TARGET_INFO"-"TARGET_NAME,                                \
> +/*
> + * QOM type names are target-info-<TARGET_NAME>-le and -be so both
> + * endian variants can be registered from one system translation unit.
> + */
> +#define TARGET_INFO_QOM_SUFFIX_0 "-le"
> +#define TARGET_INFO_QOM_SUFFIX_1 "-be"
> +
> +#define TARGET_INFO_QOM_NAME(sel)                                           \
> +    TYPE_TARGET_INFO "-" TARGET_NAME glue(TARGET_INFO_QOM_SUFFIX_, sel)
> +
> +#define TARGET_INFO_QOM_TYPEINFO(ti_var, sel)                               \
> +static const TypeInfo glue(target_info_qom_type_, sel) = {                  \
> +    .name = TARGET_INFO_QOM_NAME(sel),                                      \
>      .parent = TYPE_TARGET_INFO,                                             \
>      .instance_size = sizeof(TargetInfoQom),                                 \
>      .class_size = sizeof(TargetInfoQomClass),                               \
>      .class_data = &ti_var,                                                  \
> -};                                                                          \
> -DEFINE_TARGET_INFO_TYPE(target_info_qom_target_type_info)
> +}
> +
> +#define target_info_init_le_be(ti_le, ti_be)                                \
> +TARGET_INFO_QOM_TYPEINFO(ti_le, 0);                                         \
> +TARGET_INFO_QOM_TYPEINFO(ti_be, 1);                                         \
> +static void do_qemu_init_target_info(void)                                  \
> +{                                                                           \
> +    type_register_static(&target_info_qom_type_0);                          \
> +    type_register_static(&target_info_qom_type_1);                          \
> +}                                                                           \
> +module_init(do_qemu_init_target_info, MODULE_INIT_TARGET_INFO)
>  
>  #endif /* CONFIG_USER_ONLY */
>  #endif /* COMPILING_PER_TARGET */
> diff --git a/target-info-def.c b/target-info-def.c
> index 5d38e405735..6722c43a08f 100644
> --- a/target-info-def.c
> +++ b/target-info-def.c
> @@ -28,39 +28,72 @@ QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
>  QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS_MIN);
>  #endif
>  
> -static const TargetInfo target_info_def = {
> -    .target_name = TARGET_NAME,
> -    .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH),
> -    .long_bits = TARGET_LONG_BITS,
> -    .cpu_type = CPU_RESOLVING_TYPE,
> -    .endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE,
>  #ifdef TARGET_PAGE_BITS_VARY
> -    .page_bits_vary = true,
>  # ifdef TARGET_PAGE_BITS_LEGACY
> +#  define TARGET_INFO_PAGE_BITS \
> +    .page_bits_vary = true, \
>      .page_bits_init = TARGET_PAGE_BITS_LEGACY,
> +# else
> +#  define TARGET_INFO_PAGE_BITS \
> +    .page_bits_vary = true,
>  # endif
>  #else
> -    .page_bits_vary = false,
> +# define TARGET_INFO_PAGE_BITS \
> +    .page_bits_vary = false, \
>      .page_bits_init = TARGET_PAGE_BITS,
>  #endif
>  
>  #ifndef CONFIG_USER_ONLY
>  # ifdef CONFIG_MULTIPROCESS
> -    .config_multiprocess = true,
> +#  define TARGET_INFO_CONFIG_MULTIPROCESS .config_multiprocess = true,
>  # else
> -    .config_multiprocess = false,
> +#  define TARGET_INFO_CONFIG_MULTIPROCESS .config_multiprocess = false,
>  # endif
>  # ifdef CONFIG_NITRO
> -    .config_nitro = true,
> +#  define TARGET_INFO_CONFIG_NITRO .config_nitro = true,
>  # else
> -    .config_nitro = false,
> +#  define TARGET_INFO_CONFIG_NITRO .config_nitro = false,
>  # endif
>  # ifdef CONFIG_XEN
> -    .config_xen = true,
> +#  define TARGET_INFO_CONFIG_XEN .config_xen = true,
>  # else
> -    .config_xen = false,
> +#  define TARGET_INFO_CONFIG_XEN .config_xen = false,
>  # endif
> +# define TARGET_INFO_CONFIG \
> +    TARGET_INFO_CONFIG_MULTIPROCESS \
> +    TARGET_INFO_CONFIG_NITRO \
> +    TARGET_INFO_CONFIG_XEN
> +#else
> +# define TARGET_INFO_CONFIG
>  #endif
> +
> +#define TARGET_INFO_COMMON                                                  \
> +    .target_name = TARGET_NAME,                                             \
> +    .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH),                      \
> +    .long_bits = TARGET_LONG_BITS,                                          \
> +    .cpu_type = CPU_RESOLVING_TYPE,                                         \
> +    TARGET_INFO_PAGE_BITS                                                   \
> +    TARGET_INFO_CONFIG
> +
> +#ifdef CONFIG_USER_ONLY
> +static const TargetInfo target_info_def = {
> +    TARGET_INFO_COMMON
> +    .endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE,
>  };
>  
>  target_info_init(target_info_def)
> +#else
> +static const TargetInfo target_info_le = {
> +    TARGET_INFO_COMMON
> +    .endianness = ENDIAN_MODE_LITTLE,
> +    .is_default = !TARGET_BIG_ENDIAN,
> +};
> +
> +static const TargetInfo target_info_be = {
> +    TARGET_INFO_COMMON
> +    .endianness = ENDIAN_MODE_BIG,
> +    .is_default = TARGET_BIG_ENDIAN,
> +};
> +
> +target_info_init_le_be(target_info_le, target_info_be)
> +#endif
> diff --git a/target-info-qom.c b/target-info-qom.c
> index 68ad734049c..2c1c57b05fd 100644
> --- a/target-info-qom.c
> +++ b/target-info-qom.c
> @@ -90,13 +90,34 @@ const TargetInfo *target_info(void)
>  void target_info_qom_set_target(void)
>  {
>      g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);
> -
> +    const TargetInfo *chosen = NULL;
>      size_t num_found = g_slist_length(targets);
> -    if (num_found != 1) {
> -        error_setg(&error_fatal, num_found == 0 ?
> -                                 "no target-info is available" :
> -                                 "more than one target-info is available");
> +    size_t num_default = 0;
> +
> +    if (num_found == 0) {
> +        error_setg(&error_fatal, "no target-info is available");
> +    }
> +
> +    if (num_found == 1) {
> +        target_info_ptr = TARGET_INFO_CLASS(targets->data)->target_info;
> +        return;
> +    }
> +
> +    for (GSList *l = targets; l; l = l->next) {
> +        const TargetInfo *ti = TARGET_INFO_CLASS(l->data)->target_info;
> +
> +        if (ti->is_default) {
> +            num_default++;
> +            chosen = ti;
> +        }
> +    }
> +
> +    if (num_default != 1) {
> +        error_setg(&error_fatal, num_default == 0 ?
> +                                 "no default target-info is available" :
> +                                 "more than one default target-info "
> +                                 "is available");
>      }
>  
> -    target_info_ptr = TARGET_INFO_CLASS(targets->data)->target_info;
> +    target_info_ptr = chosen;
>  }

Is it representing existing targets, or adding new ones per endianness?
I'm not sure if the goal is to add new binaries, or mimic existing ones
with specific parameters.

