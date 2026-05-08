Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D31CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 20:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLRpb-0006ZK-Js; Fri, 08 May 2026 16:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLRpM-0006YV-Ji
 for qemu-devel@nongnu.org; Fri, 08 May 2026 16:29:44 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLRpK-000715-PC
 for qemu-devel@nongnu.org; Fri, 08 May 2026 16:29:40 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dca5f64e86so2039078a34.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 13:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778272176; x=1778876976; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aryo46g01QFyoAYXRcBUc50AehaHbGVfb26NMi04+L0=;
 b=rPEp7os9PVSKLB+OVjQlrOTNQTqv2867gO41Jdn5Jqa1d0d3wEY9pND7pS2AKAaM9z
 BhwZ0AI7cPJGjPfAjGnEvuzi8+rjDUOUergRLGlD1awtkbRFZN1R5sotVYcOtISgNW9f
 iJYSQOHOAmw4fD7jo+aV/UFrKt6VLWgr3rgQsjLcxYf+cf/PGJi+K39We8lQepct9BeW
 3vg72nOdjW9KQ3j/04qlZHmeljASiTiWPGc8rxZSHk/EJXCdlRpzxjuTXSu36WatHGbE
 bQpPn0aoaGoUxY7Z58ZT1wcMefFQe9OeRyC/vOkzKfmgl9OTmADTEeaahnMHgA4puyxy
 wiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778272176; x=1778876976;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aryo46g01QFyoAYXRcBUc50AehaHbGVfb26NMi04+L0=;
 b=ToFOyVKSBoiZ3DRkD4bzBvhmGd0aAVl/EW696Z1IwjJ7vJPHJa3V07sM6X1NT7VNjW
 sNlm+y7MO9R4dAnguz0+xU5xwlulUD8OY87OKUpPn8wc6usnXgGYRdK+Mw6BuIRXMhfk
 O6jlk/p4LFAiCB9fut0NHm8KDA5Kz/mKBNvcw1EO3AHGGkv+sKjLzeMLPUciy0USu2yg
 atng52mNLaEZcDRjz3ljhAJEuCR/WYJbhIN4RiIlX4+7TwU3Ic+ocEObZ+RHUsPrdHSA
 R24YThLC8MJTgldl9CtJRGaiapm91nrvDNEOFdWpVKI9FH0Ha/nVZecmQ+SCqwe+p/e+
 +pkg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/X/ND/WpANTXyzyIoT8z8GisGaSWx+UojZaOO+bnBrINhO72fSwtVMWneeTVPQMQ0YKjdM4sNOK1v@nongnu.org
X-Gm-Message-State: AOJu0Yxv6Q6TCI4+ii4UzOkM79H0U2KbdXGu2QyZ129ARI+I/k5YZvU9
 +8n5DA2+xkyxzftzilxNctGjXXoL/wuFeVMEm/nyfU/UGdlgs8HmUHXOtMA6c50e33U=
X-Gm-Gg: AeBDievOr+w6lLgNXSZAGf9gmPm6PrQn45ZTOMGyI3MczoeVS8CleHZkTV3YfthPwzt
 KvKjrP9BdaA7d5RnUqmBDtElpCwwCkC16iQtWfHoRys0oHIrhbGpkraq6QUtqYeHl4bDoKvIYEt
 QYNy/xH93u4zD/9MqkaLq+IgMddWpRY1chHunGo/EYmhptv5xRdgQ7PsXUkVKqoSmWc7E8xfQZ/
 ubiihMkBn8sJ5kGuaX3xSz2yedlyMQyOAf+g7VPmiW4fgTrmKgilPgrw4gzPM4/3PaEx0UEKjQJ
 i7H6Y6aMxUx/J/ugHvQRCCMWU/YYiz/e0xEUkq07cJcDyyfL1ATGl4XDPjIgYHSyCt6vii2WRdS
 ZJYCXV3Xs2e+EJjADpIETy24hK4wSRoEM4MW5RYykZ7VCLuxUap8hlc3MiiHuUC0JxhhxYDvIwx
 1J7FAg1X59QZSL0FiQG8AIBY6t/z49C4oruuTequ1EnfbRMiC/n88Wxp691kxFPYrN2JCkxa6Fa
 pqPVFw=
X-Received: by 2002:a05:6830:7107:b0:7d7:b841:c6dd with SMTP id
 46e09a7af769-7e1def17034mr9191142a34.11.1778272176109; 
 Fri, 08 May 2026 13:29:36 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1a91:1de:21e3:45a9:5df:5a65?
 ([2607:fb91:1a91:1de:21e3:45a9:5df:5a65])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367c0bc16sm1754636a34.12.2026.05.08.13.29.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 13:29:35 -0700 (PDT)
Message-ID: <fd1ff950-1f9c-4097-9bdf-57a7c650c305@linaro.org>
Date: Fri, 8 May 2026 15:29:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] target-info-qom: detect target from QOM
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, marcandre.lureau@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com>
 <20260505224826.2698753-6-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260505224826.2698753-6-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 5/5/26 17:48, Pierrick Bouvier wrote:
> For now, we expect only one target to be available at runtime. This will
> change with the single-binary and we'll detect which one to use
> dynamically.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   include/qemu/target-info-qom.h |  2 ++
>   system/vl.c                    |  2 ++
>   target-info-qom.c              | 16 ++++++++++++++++
>   3 files changed, 20 insertions(+)
> 
> diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
> index 585995c7ad0..91be415ed33 100644
> --- a/include/qemu/target-info-qom.h
> +++ b/include/qemu/target-info-qom.h
> @@ -25,4 +25,6 @@ typedef struct TargetInfoQomClass {
>   
>   OBJECT_DECLARE_TYPE(TargetInfoQom, TargetInfoQomClass, TARGET_INFO)
>   
> +void target_info_qom_set_target(void);
> +
>   #endif /* QEMU_TARGET_INFO_QOM_H */
> diff --git a/system/vl.c b/system/vl.c
> index 2b6739271ba..77b2b4e673d 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -28,6 +28,7 @@
>   #include "qemu/units.h"
>   #include "qemu/module.h"
>   #include "qemu/target-info.h"
> +#include "qemu/target-info-qom.h"
>   #include "exec/cpu-common.h"
>   #include "exec/page-vary.h"
>   #include "hw/core/qdev-properties.h"
> @@ -2891,6 +2892,7 @@ void qemu_init(int argc, char **argv)
>       os_setup_limits();
>   
>       module_call_init(MODULE_INIT_TARGET_INFO);
> +    target_info_qom_set_target();
>   
>       module_init_info(qemu_modinfo);
>       module_allow_arch(target_name());
> diff --git a/target-info-qom.c b/target-info-qom.c
> index ba2c7923760..9d1f50ffcab 100644
> --- a/target-info-qom.c
> +++ b/target-info-qom.c
> @@ -36,3 +36,19 @@ static const TypeInfo target_info_parent_type = {
>   };
>   
>   DEFINE_TARGET_INFO_TYPE(target_info_parent_type)
> +
> +static const TargetInfo *target_info_ptr;
> +
> +void target_info_qom_set_target(void)
> +{
> +    g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);
> +
> +    size_t num_found = g_slist_length(targets);
> +    if (num_found != 1) {
> +        error_setg(&error_fatal, num_found == 0 ?
> +                                 "no target-info is available" :
> +                                 "more than one target-info is available");
> +    }
> +
> +    target_info_ptr = TARGET_INFO_CLASS(targets->data)->target_info;
> +}

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

For future improvement, I suggest structuring the code more like page-vary-common.c, where 
exactly one compilation unit sees a non-const "TargetInfo target_info", all others see a 
"const TargetInfo target_info", and target_info() the function is eliminated.

One could even plausibly unify page-vary with target-info, rather than duplicating some of 
the page_bits information between the two structures.

Most pieces of target_info are really only referenced at startup, but target_big_endian() 
and target_long_bits() are the big exceptions to that, and it would be really nice for 
them not to require an out-of-line function call.


r~

