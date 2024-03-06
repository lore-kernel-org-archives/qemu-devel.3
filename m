Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C65C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 13:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhqy0-0005Mw-Vk; Wed, 06 Mar 2024 08:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhqxz-0005MK-7A
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:05:51 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhqxw-0001EJ-S6
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:05:50 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dd10ae77d8so27647635ad.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 05:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709730347; x=1710335147; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=35epdlKFgsUnoD10TbsRqMnZ4hleOgbRmnX4nUudU/E=;
 b=hNMNSGUTJPdF257WXi6zOGDsmN7uKQWdV1S22lvAdvnCinwg7k7VXZB+kkuZI2nH3X
 2hCmEihUwFe6OoncgGwUG52uxtBqx1s51xqaGQlRoqQfkQUfB8X+6QStpw5uuuttySM+
 8cWgKaIqipbbc055FYUjw3LwhPAHlj7z7MDnrRKfTDeIdsZuD4Um2dEdDDtza2UESqKL
 N4ydQ7ufDFkfVzoQxPZqmqP/fJsRdRTND3yiUxC8dPeFbhAAPcBN8LtiXYo+SxEsInAL
 VybciFA8VC3mgRyGaOqOtRoKujQvci9vjBSfx2eIbsXFlitc8CFxQUu9XbzPsrHlzIOp
 RsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709730347; x=1710335147;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=35epdlKFgsUnoD10TbsRqMnZ4hleOgbRmnX4nUudU/E=;
 b=BVPZ5Ilz00rtwfJluk/Rq4SaDQaWdev77NvLK4VvcOV3GPvUnd0Jyveg4T3ntjr3Tt
 Pw3394yQri+VtpH7zfflcY+v64/RSQgeM5RbSZ17ubdOZKfF82/dLdwImHRXwUrVcKHl
 s8YkEAUQOuZnsRfODoa/bfBEvenpOr5KZMOjdxgK8vsWhcLmXoU0xKDFyp81HiEcprYV
 De9sRGHhZ4zPrCksSoQiXYGV6Y6Zgf5igLNAvpFe3ePzVykGS0YqeBvSDafM4jD4guk9
 qNVHRP61tqn62+HAiHhlaR+EY0mb6n4od2mNha4p9KwG0nnxnNjo8JkRcIJ6o/ctdG9b
 aFFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBht4PqllpODrJEGJVlhFqbsJQ56/n/Uj2jC1BJoZhACPgYIqH4BZ1UU4+tyl1ls7OfOuBw0+5/W3d6x5Wc6Ay5jEqeqs=
X-Gm-Message-State: AOJu0YyH523grR3XjJrx1mVwtMzXg+x30jZCQMrA18elFz8z/n9CKXtF
 jpZL7G17waaHpm+9Hq22taS4PNnBjBJKdl3/0Rdha+0FRvdTOjU/TKDEC4QMXQ8=
X-Google-Smtp-Source: AGHT+IH14s+S/6TL2M2cc57FagjbKBI2DXtWtOH8OhdAMn6jgQlpz1z/DhQ5++pSy/kUh1zfUdirjA==
X-Received: by 2002:a17:903:238e:b0:1dc:728d:b1de with SMTP id
 v14-20020a170903238e00b001dc728db1demr5587523plh.56.1709730347595; 
 Wed, 06 Mar 2024 05:05:47 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 ix19-20020a170902f81300b001db45b65e13sm12540439plb.279.2024.03.06.05.05.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 05:05:47 -0800 (PST)
Message-ID: <bf7da333-d777-4cb6-96b1-368410ba733c@ventanamicro.com>
Date: Wed, 6 Mar 2024 10:05:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] target: Improve error reporting for CpuModelInfo
 member @props
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, gaosong@loongson.cn,
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 thuth@redhat.com, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
References: <20240305145919.2186971-1-armbru@redhat.com>
 <20240305145919.2186971-4-armbru@redhat.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240305145919.2186971-4-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/5/24 11:59, Markus Armbruster wrote:
> query-cpu-model-comparison, query-cpu-model-baseline, and
> query-cpu-model-expansion take CpuModelInfo arguments.  Errors in
> @props members of these arguments are reported for 'props', without
> further context.  For instance, s390x rejects
> 
>      {"execute": "query-cpu-model-comparison", "arguments": {"modela": {"name": "z13", "props": {}}, "modelb": {"name": "z14", "props": []}}}
> 
> with
> 
>      {"error": {"class": "GenericError", "desc": "Invalid parameter type for 'props', expected: object"}}
> 
> This is unusual; the common QAPI unmarshaling machinery would complain
> about 'modelb.props'.  Our hand-written code to visit the @props
> member neglects to provide the context.
> 
> Tweak it so it provides it.  The command above now fails with
> 
>      {"error": {"class": "GenericError", "desc": "Invalid parameter type for 'modelb.props', expected: dict"}}
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---


For RISC-V changes:

Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/arm/arm-qmp-cmds.c        |  2 +-
>   target/i386/cpu-sysemu.c         | 11 ++++++-----
>   target/riscv/riscv-qmp-cmds.c    |  6 ++++--
>   target/s390x/cpu_models_sysemu.c | 17 ++++++++++-------
>   tests/qtest/arm-cpu-features.c   |  5 +++--
>   5 files changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
> index 0167759730..0efbee8af8 100644
> --- a/target/arm/arm-qmp-cmds.c
> +++ b/target/arm/arm-qmp-cmds.c
> @@ -158,7 +158,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>           Error *err = NULL;
>   
>           visitor = qobject_input_visitor_new(model->props);
> -        if (!visit_start_struct(visitor, "props", NULL, 0, errp)) {
> +        if (!visit_start_struct(visitor, "model.props", NULL, 0, errp)) {
>               visit_free(visitor);
>               object_unref(obj);
>               return NULL;
> diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
> index df91f97827..3f9093d285 100644
> --- a/target/i386/cpu-sysemu.c
> +++ b/target/i386/cpu-sysemu.c
> @@ -130,14 +130,15 @@ static void x86_cpu_to_dict_full(X86CPU *cpu, QDict *props)
>       }
>   }
>   
> -static void object_apply_props(Object *obj, QObject *props, Error **errp)
> +static void object_apply_props(Object *obj, QObject *props,
> +                               const char *props_arg_name, Error **errp)
>   {
>       Visitor *visitor;
>       QDict *qdict;
>       const QDictEntry *prop;
>   
>       visitor = qobject_input_visitor_new(props);
> -    if (!visit_start_struct(visitor, "props", NULL, 0, errp)) {
> +    if (!visit_start_struct(visitor, props_arg_name, NULL, 0, errp)) {
>           visit_free(visitor);
>           return;
>       }
> @@ -158,7 +159,7 @@ out:
>   
>   /* Create X86CPU object according to model+props specification */
>   static X86CPU *x86_cpu_from_model(const char *model, QObject *props,
> -                                  Error **errp)
> +                                  const char *props_arg_name, Error **errp)
>   {
>       X86CPU *xc = NULL;
>       X86CPUClass *xcc;
> @@ -172,7 +173,7 @@ static X86CPU *x86_cpu_from_model(const char *model, QObject *props,
>   
>       xc = X86_CPU(object_new_with_class(OBJECT_CLASS(xcc)));
>       if (props) {
> -        object_apply_props(OBJECT(xc), props, &err);
> +        object_apply_props(OBJECT(xc), props, props_arg_name, &err);
>           if (err) {
>               goto out;
>           }
> @@ -203,7 +204,7 @@ qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>       QDict *props = NULL;
>       const char *base_name;
>   
> -    xc = x86_cpu_from_model(model->name, model->props, &err);
> +    xc = x86_cpu_from_model(model->name, model->props, "model.props", &err);
>       if (err) {
>           goto out;
>       }
> diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
> index 69dde0c3e7..ee7465297d 100644
> --- a/target/riscv/riscv-qmp-cmds.c
> +++ b/target/riscv/riscv-qmp-cmds.c
> @@ -129,6 +129,7 @@ static void riscv_obj_add_profiles_qdict(Object *obj, QDict *qdict_out)
>   }
>   
>   static void riscv_cpuobj_validate_qdict_in(Object *obj, QObject *props,
> +                                           const char *props_arg_name,
>                                              Error **errp)
>   {
>       const QDict *qdict_in;
> @@ -137,7 +138,7 @@ static void riscv_cpuobj_validate_qdict_in(Object *obj, QObject *props,
>       Error *local_err = NULL;
>   
>       visitor = qobject_input_visitor_new(props);
> -    if (!visit_start_struct(visitor, "props", NULL, 0, &local_err)) {
> +    if (!visit_start_struct(visitor, props_arg_name, NULL, 0, &local_err)) {
>           goto err;
>       }
>   
> @@ -198,7 +199,8 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>       }
>   
>       if (model->props) {
> -        riscv_cpuobj_validate_qdict_in(obj, model->props, &local_err);
> +        riscv_cpuobj_validate_qdict_in(obj, model->props, "model.props",
> +                                       &local_err);
>           if (local_err) {
>               error_propagate(errp, local_err);
>               object_unref(obj);
> diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
> index ef19724888..8338084d00 100644
> --- a/target/s390x/cpu_models_sysemu.c
> +++ b/target/s390x/cpu_models_sysemu.c
> @@ -98,7 +98,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
>   }
>   
>   static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
> -                                Error **errp)
> +                                const char *info_arg_name, Error **errp)
>   {
>       Error *err = NULL;
>       const QDict *qdict;
> @@ -128,8 +128,11 @@ static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
>       }
>   
>       if (info->props) {
> +        g_autofree const char *props_name = g_strdup_printf("%s.props",
> +                                                            info_arg_name);
> +
>           visitor = qobject_input_visitor_new(info->props);
> -        if (!visit_start_struct(visitor, "props", NULL, 0, errp)) {
> +        if (!visit_start_struct(visitor, props_name, NULL, 0, errp)) {
>               visit_free(visitor);
>               object_unref(obj);
>               return;
> @@ -216,7 +219,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>       bool delta_changes = false;
>   
>       /* convert it to our internal representation */
> -    cpu_model_from_info(&s390_model, model, &err);
> +    cpu_model_from_info(&s390_model, model, "model", &err);
>       if (err) {
>           error_propagate(errp, err);
>           return NULL;
> @@ -254,12 +257,12 @@ CpuModelCompareInfo *qmp_query_cpu_model_comparison(CpuModelInfo *infoa,
>       S390CPUModel modela, modelb;
>   
>       /* convert both models to our internal representation */
> -    cpu_model_from_info(&modela, infoa, &err);
> +    cpu_model_from_info(&modela, infoa, "modela", &err);
>       if (err) {
>           error_propagate(errp, err);
>           return NULL;
>       }
> -    cpu_model_from_info(&modelb, infob, &err);
> +    cpu_model_from_info(&modelb, infob, "modelb", &err);
>       if (err) {
>           error_propagate(errp, err);
>           return NULL;
> @@ -331,13 +334,13 @@ CpuModelBaselineInfo *qmp_query_cpu_model_baseline(CpuModelInfo *infoa,
>       uint8_t max_gen;
>   
>       /* convert both models to our internal representation */
> -    cpu_model_from_info(&modela, infoa, &err);
> +    cpu_model_from_info(&modela, infoa, "modela", &err);
>       if (err) {
>           error_propagate(errp, err);
>           return NULL;
>       }
>   
> -    cpu_model_from_info(&modelb, infob, &err);
> +    cpu_model_from_info(&modelb, infob, "modelb", &err);
>       if (err) {
>           error_propagate(errp, err);
>           return NULL;
> diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
> index 1daceb2e31..9d6e6190d5 100644
> --- a/tests/qtest/arm-cpu-features.c
> +++ b/tests/qtest/arm-cpu-features.c
> @@ -213,7 +213,8 @@ static void assert_bad_props(QTestState *qts, const char *cpu_type)
>       error = resp_get_error(resp);
>       g_assert(error);
>       g_assert_cmpstr(error, ==,
> -                    "Invalid parameter type for 'props', expected: object");
> +                    "Invalid parameter type for 'model.props',"
> +                    " expected: object");
>       qobject_unref(resp);
>   }
>   
> @@ -446,7 +447,7 @@ static void test_query_cpu_model_expansion(const void *data)
>       assert_bad_props(qts, "max");
>       assert_error(qts, "foo", "The CPU type 'foo' is not a recognized "
>                    "ARM CPU type", NULL);
> -    assert_error(qts, "max", "Parameter 'props.not-a-prop' is unexpected",
> +    assert_error(qts, "max", "Parameter 'model.props.not-a-prop' is unexpected",
>                    "{ 'not-a-prop': false }");
>       assert_error(qts, "host", "The CPU type 'host' requires KVM", NULL);
>   

