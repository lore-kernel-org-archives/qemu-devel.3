Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5934C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 13:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhqxm-0005Dq-A7; Wed, 06 Mar 2024 08:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhqxg-00058q-Hs
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:05:33 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhqxe-000178-EM
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:05:32 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dc49b00bdbso61736305ad.3
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 05:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709730325; x=1710335125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rFD4UDPrAnBcU7/XlDtbguDyQsDWQshU5jozKO2xm2Q=;
 b=lcF8NhG30YR+X4Von++kbJTrupxCVhWQEq2ib3nZlNN4WwW1iOIbyU1FRzkYFj1noc
 qbC3cH8UZD8MIxdcF2+kfATqb7yCJrLAJkFzz4zmYRgOU/mVNLV6mdudwdgaohzuUeIB
 2zcpCe+9Gk2cmpPVu/7MhIYnf/m0+tcyysOqcaaxLynL7wJNERTHIR77bTkf/uISBd3D
 b/SDLwzENKcvV56pmUpoYscZmh1vIwwfimwdO0vbWOhzM5Xrvsk4I0lH+LBPDAkRL+7v
 mCPXqcOxfqgXQcH+mGd6CS8zM7z7pY4jdqxFrSpU43/gTuihQYxneydhQ3aTt44f4iPS
 vtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709730325; x=1710335125;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rFD4UDPrAnBcU7/XlDtbguDyQsDWQshU5jozKO2xm2Q=;
 b=CXhALtdqSoGtCaQI+iD3Xbh3IgwjxtBracy/tjRClybRp7z/szSPRWc5XkAPOA278H
 kIj/R7Ev19KzVNNc5g3xwXs85VTsiYUGytbnHrPW/as8OchwOf2TDheZBrjGZT0Cw2E9
 uuDG2YodQn9ScgeXySbXym2NM8qwQ+xMWnU3kLQcXSvZkoCXbOMS59swuaTp6fHSAJ42
 QbmWBho8CTgGT2ddqoODLIFsjdOZxQ1r8bx4Gnav/RQafYyp5Ju3YKLGi0Cmy4P2O4Zj
 xz9v04Ddp2/9oUUjdbo/GCzW0nCf/T1N3BrpHXDmKfeoiL2nUkjcy7NI13w7YsL574bE
 1FEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQi6DbwnLMV1zayk5T83oGE0QyO0o+p+r/TlCU+HcdTK4blxhhDBH9lwYlr3PqJAjgLgvo9IVqHt7BQ+01N+XxPqlImWE=
X-Gm-Message-State: AOJu0YyM13r8lKl5U0tsMlnJu0qqTG2db/5hdx7yfF6lGzlGm3JMAI7x
 SZ3fxHDAyGRKmuDKoUw0BDiuHAc5bo7xLj+W3q31BFA1g9JS92aXNASvdqG38IU=
X-Google-Smtp-Source: AGHT+IG3gDo0UnS3XERZ/SJ64O76OgxDbohObTtd1ULlM9DeDpXMe7Z238Nge0vgzvn4AZcvO7lkAA==
X-Received: by 2002:a17:902:e807:b0:1db:ca53:403 with SMTP id
 u7-20020a170902e80700b001dbca530403mr5901332plg.26.1709730324779; 
 Wed, 06 Mar 2024 05:05:24 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 ix19-20020a170902f81300b001db45b65e13sm12540439plb.279.2024.03.06.05.05.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 05:05:24 -0800 (PST)
Message-ID: <995ee5be-882f-4ec5-90f3-2725778be078@ventanamicro.com>
Date: Wed, 6 Mar 2024 10:05:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target: Simplify type checks for CpuModelInfo member
 @props
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, gaosong@loongson.cn,
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 thuth@redhat.com, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
References: <20240305145919.2186971-1-armbru@redhat.com>
 <20240305145919.2186971-2-armbru@redhat.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240305145919.2186971-2-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
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
> CpuModelInfo member @props is semantically a mapping from name to
> value, and syntactically a JSON object on the wire.  This translates
> to QDict in C.  Since the QAPI schema language lacks the means to
> express 'object', we use 'any' instead.  This is QObject in C.
> Commands taking a CpuModelInfo argument need to check the QObject is a
> QDict.
> 
> For arm, riscv, and s390x, the code checks right before passing the
> QObject to visit_start_struct().  visit_start_struct() then checks
> again.
> 
> Delete the first check.
> 
> The error message for @props that are not an object changes slightly
> to the the message we get for this kind of type error in other
> contexts.  Minor improvement.
> 
> Additionally, error messages about members of @props now refer to
> 'props.prop-name' instead of just 'prop-name'.  Another minor
> improvement.
> 
> Both changes are visible in tests/qtest/arm-cpu-features.c.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

For RISC-V changes:

Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/arm/arm-qmp-cmds.c        | 15 ++++-----------
>   target/riscv/riscv-qmp-cmds.c    | 19 +++++--------------
>   target/s390x/cpu_models_sysemu.c | 15 ++++-----------
>   tests/qtest/arm-cpu-features.c   | 12 ++++++------
>   4 files changed, 19 insertions(+), 42 deletions(-)
> 
> diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
> index 2250cd7ddf..0167759730 100644
> --- a/target/arm/arm-qmp-cmds.c
> +++ b/target/arm/arm-qmp-cmds.c
> @@ -104,7 +104,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>                                                        Error **errp)
>   {
>       CpuModelExpansionInfo *expansion_info;
> -    const QDict *qdict_in = NULL;
> +    const QDict *qdict_in;
>       QDict *qdict_out;
>       ObjectClass *oc;
>       Object *obj;
> @@ -151,27 +151,20 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>           }
>       }
>   
> -    if (model->props) {
> -        qdict_in = qobject_to(QDict, model->props);
> -        if (!qdict_in) {
> -            error_setg(errp, QERR_INVALID_PARAMETER_TYPE, "props", "dict");
> -            return NULL;
> -        }
> -    }
> -
>       obj = object_new(object_class_get_name(oc));
>   
> -    if (qdict_in) {
> +    if (model->props) {
>           Visitor *visitor;
>           Error *err = NULL;
>   
>           visitor = qobject_input_visitor_new(model->props);
> -        if (!visit_start_struct(visitor, NULL, NULL, 0, errp)) {
> +        if (!visit_start_struct(visitor, "props", NULL, 0, errp)) {
>               visit_free(visitor);
>               object_unref(obj);
>               return NULL;
>           }
>   
> +        qdict_in = qobject_to(QDict, model->props);
>           i = 0;
>           while ((name = cpu_model_advertised_features[i++]) != NULL) {
>               if (qdict_get(qdict_in, name)) {
> diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
> index c48b9cfa67..69dde0c3e7 100644
> --- a/target/riscv/riscv-qmp-cmds.c
> +++ b/target/riscv/riscv-qmp-cmds.c
> @@ -129,18 +129,19 @@ static void riscv_obj_add_profiles_qdict(Object *obj, QDict *qdict_out)
>   }
>   
>   static void riscv_cpuobj_validate_qdict_in(Object *obj, QObject *props,
> -                                           const QDict *qdict_in,
>                                              Error **errp)
>   {
> +    const QDict *qdict_in;
>       const QDictEntry *qe;
>       Visitor *visitor;
>       Error *local_err = NULL;
>   
>       visitor = qobject_input_visitor_new(props);
> -    if (!visit_start_struct(visitor, NULL, NULL, 0, &local_err)) {
> +    if (!visit_start_struct(visitor, "props", NULL, 0, &local_err)) {
>           goto err;
>       }
>   
> +    qdict_in = qobject_to(QDict, props);
>       for (qe = qdict_first(qdict_in); qe; qe = qdict_next(qdict_in, qe)) {
>           object_property_find_err(obj, qe->key, &local_err);
>           if (local_err) {
> @@ -170,7 +171,6 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>                                                        Error **errp)
>   {
>       CpuModelExpansionInfo *expansion_info;
> -    const QDict *qdict_in = NULL;
>       QDict *qdict_out;
>       ObjectClass *oc;
>       Object *obj;
> @@ -188,14 +188,6 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>           return NULL;
>       }
>   
> -    if (model->props) {
> -        qdict_in = qobject_to(QDict, model->props);
> -        if (!qdict_in) {
> -            error_setg(errp, QERR_INVALID_PARAMETER_TYPE, "props", "dict");
> -            return NULL;
> -        }
> -    }
> -
>       obj = object_new(object_class_get_name(oc));
>   
>       riscv_check_if_cpu_available(RISCV_CPU(obj), &local_err);
> @@ -205,9 +197,8 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>           return NULL;
>       }
>   
> -    if (qdict_in) {
> -        riscv_cpuobj_validate_qdict_in(obj, model->props, qdict_in,
> -                                       &local_err);
> +    if (model->props) {
> +        riscv_cpuobj_validate_qdict_in(obj, model->props, &local_err);
>           if (local_err) {
>               error_propagate(errp, local_err);
>               object_unref(obj);
> diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
> index 63981bf36b..ef19724888 100644
> --- a/target/s390x/cpu_models_sysemu.c
> +++ b/target/s390x/cpu_models_sysemu.c
> @@ -101,21 +101,13 @@ static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
>                                   Error **errp)
>   {
>       Error *err = NULL;
> -    const QDict *qdict = NULL;
> +    const QDict *qdict;
>       const QDictEntry *e;
>       Visitor *visitor;
>       ObjectClass *oc;
>       S390CPU *cpu;
>       Object *obj;
>   
> -    if (info->props) {
> -        qdict = qobject_to(QDict, info->props);
> -        if (!qdict) {
> -            error_setg(errp, QERR_INVALID_PARAMETER_TYPE, "props", "dict");
> -            return;
> -        }
> -    }
> -
>       oc = cpu_class_by_name(TYPE_S390_CPU, info->name);
>       if (!oc) {
>           error_setg(errp, "The CPU definition \'%s\' is unknown.", info->name);
> @@ -135,13 +127,14 @@ static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
>           return;
>       }
>   
> -    if (qdict) {
> +    if (info->props) {
>           visitor = qobject_input_visitor_new(info->props);
> -        if (!visit_start_struct(visitor, NULL, NULL, 0, errp)) {
> +        if (!visit_start_struct(visitor, "props", NULL, 0, errp)) {
>               visit_free(visitor);
>               object_unref(obj);
>               return;
>           }
> +        qdict = qobject_to(QDict, info->props);
>           for (e = qdict_first(qdict); e; e = qdict_next(qdict, e)) {
>               if (!object_property_set(obj, e->key, visitor, &err)) {
>                   break;
> diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
> index a8a4c668ad..1daceb2e31 100644
> --- a/tests/qtest/arm-cpu-features.c
> +++ b/tests/qtest/arm-cpu-features.c
> @@ -79,7 +79,7 @@ static const char *resp_get_error(QDict *resp)
>       g_assert(_resp);                                                   \
>       _error = resp_get_error(_resp);                                    \
>       g_assert(_error);                                                  \
> -    g_assert(g_str_equal(_error, expected_error));                     \
> +    g_assert_cmpstr(_error, ==, expected_error);                       \
>       qobject_unref(_resp);                                              \
>   })
>   
> @@ -194,8 +194,8 @@ static void assert_type_full(QTestState *qts)
>       g_assert(resp);
>       error = resp_get_error(resp);
>       g_assert(error);
> -    g_assert(g_str_equal(error,
> -                         "The requested expansion type is not supported"));
> +    g_assert_cmpstr(error, ==,
> +                    "The requested expansion type is not supported");
>       qobject_unref(resp);
>   }
>   
> @@ -212,8 +212,8 @@ static void assert_bad_props(QTestState *qts, const char *cpu_type)
>       g_assert(resp);
>       error = resp_get_error(resp);
>       g_assert(error);
> -    g_assert(g_str_equal(error,
> -                         "Invalid parameter type for 'props', expected: dict"));
> +    g_assert_cmpstr(error, ==,
> +                    "Invalid parameter type for 'props', expected: object");
>       qobject_unref(resp);
>   }
>   
> @@ -446,7 +446,7 @@ static void test_query_cpu_model_expansion(const void *data)
>       assert_bad_props(qts, "max");
>       assert_error(qts, "foo", "The CPU type 'foo' is not a recognized "
>                    "ARM CPU type", NULL);
> -    assert_error(qts, "max", "Parameter 'not-a-prop' is unexpected",
> +    assert_error(qts, "max", "Parameter 'props.not-a-prop' is unexpected",
>                    "{ 'not-a-prop': false }");
>       assert_error(qts, "host", "The CPU type 'host' requires KVM", NULL);
>   

