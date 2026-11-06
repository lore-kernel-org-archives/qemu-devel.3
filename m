Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24243606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z1D5Wg0/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fczKlP0u
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPO35-0000cQ-80; Fri, 06 Nov 2026 12:48:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPNzM-0007vq-1m
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:44:33 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPNzE-00065r-Ix
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:44:29 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6ExwHR1039344
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 17:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f+egSfW1Yy/NfJA68kWn9fzN5lTYBXv7cJUpQPUkICA=; b=Z1D5Wg0/VdYqGeJu
 f7C0Vn4fkomEVY9iL1ZOP0qdog+RvOJTouVERfbV1GIxXow0kO0Yn4mxLBgD7nd6
 pOVVfzy30x3srmQ9iEg8BbIypk84kFjJMRYo8bYC8qrrdhTdlyJeYz8iJeiVx26o
 URFlZZAPic8gTawjDnCAEpr/Sh6ch0uKr+l7r/ULbrc6q5AwQBxIqpsDSuLeFlOm
 AukLex4SigEoCzul2GwlRXFXeMdwk57gLPPbsV/1b9DqBuk5RMTqd8SZXww1w2ve
 MoH9P73KkFHC70njrm69ry0K4IyNzLojSglKGFpc1sCCIfByyQ5HfQWVkC2+xkwJ
 sZVZwA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9v0dt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 17:44:21 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36f26e6abe9so1560300eec.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 09:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793987060; x=1794591860; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=f+egSfW1Yy/NfJA68kWn9fzN5lTYBXv7cJUpQPUkICA=;
 b=fczKlP0uhk3bvtwTyvlf44SoU1HcRctLSGMKWKKA+mu4Eh7+qgkjQG2nY3ajHc/Vs3
 PGRDIzcR+e/BlitoU2mzTqp83lSsyIXG/6Pcht/3vAuis/OoRtn02KwWh68Dhyd+hwQg
 VXytnnIU+laWULiZkNhT4vj6HnD+QE2iVDPIUMAWMS6O7xQbVaV1owCmFegLJ89P5x5l
 mZuisWDBhRUQRFLiVTpj5eM6mgGoNLdyP5bYiQoG3lRvbtS1U048MlTYJCxkGF8F3/Td
 2Flv4Sl1ne6AicceiYS+Q7Jzj51XkQ9JWyAbOLdz8YWa0UfbB5+ODVwjW7dDyse86tyr
 WYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793987060; x=1794591860;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f+egSfW1Yy/NfJA68kWn9fzN5lTYBXv7cJUpQPUkICA=;
 b=swXp1Oq0Xiv3twRQwVN+1apVToZU6A6GtHiZh/xQMa2Y4ydkBRA3AkJL0PWqryiYRD
 SvHo30QgZdbU2fpFOARVxA2lqo+xXpEzauByTT1boB++2cG9afgacajmuvIp9osiO2hc
 OrA9KyIWsWbBvc5DAAF6Fte1FNKfCM6r54nVcyjsAdybrRx7KH9vAc/KVE66xhcNAHVu
 ptqlpsT3Da4JT/ZCYdmxVV0sE0457629GS3O0q6uJiwhKeulZnW/iqi5BjtfpP2yFOFa
 B2roXDao9gPi2PKfCLJ6HbGl1Y56HpM7qiiuDN6hFjPRX/4nckB47AYveLmF7jGvRpyi
 4d1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqU+w+yIQzDcCiymdy9AeTtZpKbcgBZisqpXq1edhR2H4QvoE9HaZaR+lpXgI3HahbGh/wDDiMKIT8@nongnu.org
X-Gm-Message-State: APuU4Z9GyTzgzNTsaYB50gJ+PG9GkAuBkPdzjanDXtCPufsrbXJMMIoX
 lcyJp75rZGotj1dRGFb6s0cLor1A+6bfg8mPgvgrxJ/NBdGi0EB47PRpfCYppU7bti3iXTsdWqx
 Jj3h9+w/sQM0Jrja201LrtZ4Bc2anc4rmoCwqXx/3RRJYPdE8JQHLx9avMw==
X-Gm-Gg: AYBFou0cakN7aujUG8nzdqM88Cr1tebxQWanF6B5uD5eSQzHwAzUUVdiUaSSFT7jAda
 +VicXxmKrpchDc9mE0mTe1ztK6YDdC5TLjKx5Sie4I3/eSqsjl48x6sCcHj1EQngm/my8QEl7Pm
 X+YzVLss4zBHG/XLTZKbe2FeLZFVvUuyQHOhKX7c7a2xaCAHsQvf77fyBTAxXLhU6tlKz/GyjNw
 dUZFcbYez78FmnGwFsSAH4SEc4+SW3xPjr5F/muNxrgYgIpzshWf0AnCSwl+JMpdBFTPODe/ZDG
 fd6P6d2xhI6lch/FQ2JoZ1htU5vA4wXZ1FTx72lUAP782V19eKQD9eax6uBDgBO7svSgcWWq/bf
 1IkodSUwEL/Jfap5l+quF5W9MEBCX/wuTrPcqW5rC9k0I3tFilWdqnK28jDadC1z7ecsd+iUHNf
 E+t8vynSwbzTFLNwpUWDvs8IRL0+1FWg7HEYGxKKlEvA==
X-Received: by 2002:a05:7022:7e07:b0:166:f097:6f12 with SMTP id
 a92af1059eb24-1b25d2feca9mr4590317c88.15.1793987060003; 
 Fri, 06 Nov 2026 09:44:20 -0800 (PST)
X-Received: by 2002:a05:7022:7e07:b0:166:f097:6f12 with SMTP id
 a92af1059eb24-1b25d2feca9mr4590290c88.15.1793987059260; 
 Fri, 06 Nov 2026 09:44:19 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b25e4fd2d6sm7343320c88.23.2026.11.06.09.44.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 09:44:18 -0800 (PST)
Message-ID: <f84768d9-1aa4-463d-a0f5-4844a4babe22@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 09:44:16 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target-info: add target_mask_selected()
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Philippe Mathieu-Daude <philmd@mailo.com>
References: <20261105190346.1539-1-luoyonggang@gmail.com>
 <20261105190346.1539-3-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261105190346.1539-3-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3MCBTYWx0ZWRfX8BQqGaxjIRbW
 dduC7emtAIghEP0ITber5B66VwdP4G2sKmQvQvjgWyv69v9jSDG5Vci2W3BZEfuZ/Zm7MUgo9Wo
 76XERZttAbWb4L5mCqi3zP3IOuCiEKM=
X-Proofpoint-GUID: xqbVr3TxeMUTUaCC6c059_SJOOu4Lqd0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3MCBTYWx0ZWRfXzhaYcrWM3iO9
 0upz4qCd1qH2l0VABLlmuCArmZjc4qDCzOZUdS02QKaJojrzY31b+W9TaZaSXXqaUQYme1BpYaT
 U2GYvh+UK+U4fpIv8wTysRT3mTbfDnhQdH3o2FVGPYaHSDQwLPFtZaiYZ0Y7xk8aHM0qDvLLHFG
 y6iUswesWaD1lbig+z3PX7ZCMlcHx/QbV/I3AyxmSBhmS60XTUCuXU+CLclmMrojQ7sCGx8F4t/
 6kT0XagyLeptDWnmcheAHmqQ3YKqsrum8pzcI5iJa3yHY5cNPKzNQfub10WoxbUMR6bXWWTE5NJ
 bYDzQ7RpIe+en/lqXHj94fC2jPQyi8Rj4ePEIoozlciD7blZcp3tWx5uc2iJ25PrZS15vhHxw87
 H+PBxrzf53UfLUimbZCnh/UF0oGNFxjgsdJnChsljeRaJ9quefdBBtSGOfAo2HgutVzEH7uHTp1
 kGBwSSb5wJudq5CMZeQ==
X-Proofpoint-ORIG-GUID: xqbVr3TxeMUTUaCC6c059_SJOOu4Lqd0
X-Authority-Analysis: v=2.4 cv=ZIZCCn7b c=1 sm=1 tr=0 ts=6aee11f5 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=pSNG63jt_PDhM6JafDwA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060070
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/2026 11:03 AM, Yonggang Luo wrote:
> Return the QEMU_ARCH_* mask of the selected target. System mode
> returns QEMU_ARCH_ALL until a target is selected. User mode returns
> that target's bit. Tools return 0.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  include/qemu/target-info-init.h | 15 ++++++++++-----
>  include/qemu/target-info.h      |  9 +++++++++
>  stubs/meson.build               |  1 +
>  stubs/target-mask-selected.c    | 13 +++++++++++++
>  target-info-def.c               |  3 +++
>  target-info-qom.c               | 10 ++++++++++
>  6 files changed, 46 insertions(+), 5 deletions(-)
>  create mode 100644 stubs/target-mask-selected.c
> 
> diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-init.h
> index b7024c9fae..8492986832 100644
> --- a/include/qemu/target-info-init.h
> +++ b/include/qemu/target-info-init.h
> @@ -24,12 +24,17 @@ module_init(do_qemu_init_target_info, MODULE_INIT_TARGET_INFO)
>  
>  /*
>   * User mode does not support multiple targets in the same binary, so just
> - * define target_info().
> + * define target_info() and target_mask_selected(). The target is always
> + * selected.
>   */
> -#define target_info_init(ti_var)        \
> -const TargetInfo *target_info(void)     \
> -{                                       \
> -    return &ti_var;                     \
> +#define target_info_init(ti_var)                           \
> +const TargetInfo *target_info(void)                        \
> +{                                                          \
> +    return &ti_var;                                        \
> +}                                                          \
> +uint64_t target_mask_selected(void)                        \
> +{                                                          \
> +    return QEMU_ARCH_BIT((ti_var).target_arch);            \
>  }
>  
>  #else /* CONFIG_USER_ONLY */
> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
> index 2cd4cc5671..5673d10eba 100644
> --- a/include/qemu/target-info.h
> +++ b/include/qemu/target-info.h
> @@ -134,4 +134,13 @@ bool target_base_riscv(void);
>   */
>  bool target_riscv64(void);
>  
> +/**
> + * target_mask_selected:
> + *
> + * Returns the QEMU_ARCH_* mask of the selected target. System mode
> + * returns QEMU_ARCH_ALL until a target is selected. User mode returns
> + * that target's bit. Tools return 0.
> + */
> +uint64_t target_mask_selected(void);
> +
>  #endif
> diff --git a/stubs/meson.build b/stubs/meson.build
> index 744fb759a2..49cede8582 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -12,6 +12,7 @@ stub_ss.add(files('monitor-hmp.c'))
>  stub_ss.add(files('qapi-event-emit.c'))
>  stub_ss.add(files('replay-mode.c'))
>  stub_ss.add(files('trace-control.c'))
> +stub_ss.add(files('target-mask-selected.c'))
>

For which configs is the stub required?
target-info-def will always be present.

>  if have_block
>    stub_ss.add(files('bdrv-next-monitor-owned.c'))
> diff --git a/stubs/target-mask-selected.c b/stubs/target-mask-selected.c
> new file mode 100644
> index 0000000000..510a515851
> --- /dev/null
> +++ b/stubs/target-mask-selected.c
> @@ -0,0 +1,13 @@
> +/*
> + * Tools have no selected target.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/target-info.h"
> +
> +uint64_t target_mask_selected(void)
> +{
> +    return 0;
> +}
> diff --git a/target-info-def.c b/target-info-def.c
> index bcf9cfe1e4..a992019626 100644
> --- a/target-info-def.c
> +++ b/target-info-def.c
> @@ -9,6 +9,9 @@
>  #include "qemu/osdep.h"
>  #include "qemu/target-info.h"
>  #include "qemu/target-info-def.h"
> +#ifdef CONFIG_USER_ONLY
> +#include "qemu/base-arch-defs.h"
> +#endif
>  #include "qemu/target-info-init.h"
>  #include "hw/core/boards.h"
>  #include "cpu.h"
> diff --git a/target-info-qom.c b/target-info-qom.c
> index aeeedb7e81..fb4c9835e5 100644
> --- a/target-info-qom.c
> +++ b/target-info-qom.c
> @@ -9,6 +9,8 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qom/object.h"
> +#include "qemu/base-arch-defs.h"
> +#include "qemu/target-info.h"
>  #include "qemu/target-info-def.h"
>  #include "qemu/target-info-init.h"
>  #include "qemu/target-info-qom.h"
> @@ -40,6 +42,14 @@ const TargetInfo *target_info(void)
>      return target_info_ptr;
>  }
>  
> +uint64_t target_mask_selected(void)
> +{
> +    if (!target_info_ptr) {
> +        return QEMU_ARCH_ALL;
> +    }
> +    return QEMU_ARCH_BIT(target_info_ptr->target_arch);
> +}
> +
>  void target_info_qom_set_target(void)
>  {
>      g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);


