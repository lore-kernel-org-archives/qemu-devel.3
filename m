Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D22C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 05:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmoB7-00033o-JR; Wed, 20 Mar 2024 01:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rmoAy-00033O-2c; Wed, 20 Mar 2024 01:07:45 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rmoAw-0002OW-HJ; Wed, 20 Mar 2024 01:07:43 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e73e8bdea2so1764043b3a.0; 
 Tue, 19 Mar 2024 22:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710911259; x=1711516059; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJVHJSj6BukakDsadDHAJXnzFQAWZ78/dgRNkDGUMn0=;
 b=IdK9jc5ztAfNGAJ4JkT2MyoGCS6GUJcIU5rPRMcXbs0PDvFBjjQ2ezQc5C2nWbDb1e
 Q61N9zzI57PS64KlZiRw8QlNnOPW7TqXo5ZS6sr2Nk9ATozRyb151bISphAwTW5QUOZ+
 PfsJarbE5YyKVHmKb5M20ctEwmVINKPFYbiurSrRpv/PBAb53u37Es68z5n1iBI6zi9W
 OEKO9fOgTY32Jf2ZFIKq6Mdp7i72gRI1nNEvKHn8GwXzo29ookvaxYe+xLYPsoAklZs1
 /QHurO+yrQDG6wOg1mP1vffTGH/iLzXTkwaGZTbRJG2f2/I07qYU5j43s0WOpUV55WqY
 sa3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710911259; x=1711516059;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KJVHJSj6BukakDsadDHAJXnzFQAWZ78/dgRNkDGUMn0=;
 b=JQwBVsuG/pHXIEWLZPaT4lccxc41kOD9RHLUpRYA/A76op6h84i53S4jqrlFFa93XX
 /fDWLjbUB3btzaxk0onYKBUbqRo1RzCW4z9yscZcQw0OEUmIfh8lLmFLeI02bJ8dbv/b
 uK2kzmDusOq7I4vKCcnX9k/+bKiKTsTveKkCstiSKDP2e/hq2I55GR7nPXKScE/FHymq
 nEMlRLrcpmT/+f+IWyKfLmad3ipcJ3wNBYAEeeYLwmaKJn/euA/5B8F30UtCxoO4EoBN
 cE2eRTa6Ob9Z1wHV6Wx/ump4m5yW8s5X8VDVswIIgbSPRiMQv7w7g0TQOQJQV/5cCnZC
 8U4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUraEyFK0AH78Oef8N2RKHGZDZlgd3C84mXytrz3NMZs9ETwOVBj6All+3pcm8/Gfu0wDFvjbkkO6/M0Wnw/oxrac51a5C8wEVwc5QKTHeRd+Cf2jt/9KVTF6RqNixDwThB266FrSgNK40Tu4jfx1w6wpYjeKSUH3lzey6yESodG8BAaCJpcQ==
X-Gm-Message-State: AOJu0YzAunTFb82SdbBrLgWdSOsswxZQJZHnHN5snXL9LLaY+lDCmjCy
 KYO3CptEINei7AvlVMDFCY1OLGOybm8t2f2Qwi/Pm+tpTl+qf6QO93hao6TYGhg=
X-Google-Smtp-Source: AGHT+IH2rImir7dMVpxwcGcJl1oG1hMMEOKOVGjA6RjheRb67pXkXeq++fZZW/A5m6QXgXiQK4Zmxw==
X-Received: by 2002:a05:6a00:3cc5:b0:6e6:f9b6:4b1a with SMTP id
 ln5-20020a056a003cc500b006e6f9b64b1amr1131163pfb.11.1710911258995; 
 Tue, 19 Mar 2024 22:07:38 -0700 (PDT)
Received: from localhost (193-116-208-39.tpgi.com.au. [193.116.208.39])
 by smtp.gmail.com with ESMTPSA id
 k21-20020a628415000000b006e6bf165a3asm11477451pfd.91.2024.03.19.22.07.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 22:07:38 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Mar 2024 15:07:28 +1000
Message-Id: <CZYBF4Z72ZXF.3V28R4RT25I8K@wheely>
Cc: <qemu-riscv@nongnu.org>, "Anton Johansson" <anjo@rev.ng>,
 <qemu-s390x@nongnu.org>, <qemu-ppc@nongnu.org>,
 =?utf-8?b?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?= <berrange@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Eduardo Habkost" <eduardo@habkost.net>,
 "Claudio Fontana" <cfontana@suse.de>, "Richard Henderson"
 <richard.henderson@linaro.org>, "Peter Maydell" <peter.maydell@linaro.org>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, "Manos
 Pitsidianakis" <manos.pitsidianakis@linaro.org>, "Zhao Liu"
 <zhao1.liu@intel.com>, <qemu-arm@nongnu.org>, "Thomas Huth"
 <thuth@redhat.com>, "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH-for-9.1 19/21] target/ppc: Factor
 ppc_add_alias_definitions() out
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>, "Markus Armbruster" <armbru@redhat.com>
X-Mailer: aerc 0.15.2
References: <20240315130910.15750-1-philmd@linaro.org>
 <20240315130910.15750-20-philmd@linaro.org>
In-Reply-To: <20240315130910.15750-20-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri Mar 15, 2024 at 11:09 PM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> Factor ppc_add_alias_definitions() out of qmp_query_cpu_definitions()
> to clearly see the generic pattern used in all targets.

Looks equivalent.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/ppc/cpu-models.h   |  4 ++++
>  target/ppc/ppc-qmp-cmds.c | 26 +++++++++++++++-----------
>  2 files changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> index 0229ef3a9a..89a5e232b7 100644
> --- a/target/ppc/cpu-models.h
> +++ b/target/ppc/cpu-models.h
> @@ -21,6 +21,8 @@
>  #ifndef TARGET_PPC_CPU_MODELS_H
>  #define TARGET_PPC_CPU_MODELS_H
> =20
> +#include "qapi/qapi-types-machine.h"
> +
>  /**
>   * PowerPCCPUAlias:
>   * @alias: The alias name.
> @@ -480,4 +482,6 @@ enum {
>      POWERPC_SVR_8641D              =3D 0x80900121,
>  };
> =20
> +void ppc_add_alias_definitions(CpuDefinitionInfoList **cpu_list);
> +
>  #endif
> diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
> index a25d86a8d1..528cc3e4af 100644
> --- a/target/ppc/ppc-qmp-cmds.c
> +++ b/target/ppc/ppc-qmp-cmds.c
> @@ -189,17 +189,9 @@ static void ppc_cpu_defs_entry(gpointer data, gpoint=
er user_data)
>      QAPI_LIST_PREPEND(*first, info);
>  }
> =20
> -CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
> +void ppc_add_alias_definitions(CpuDefinitionInfoList **cpu_list)
>  {
> -    CpuDefinitionInfoList *cpu_list =3D NULL;
> -    GSList *list;
> -    int i;
> -
> -    list =3D object_class_get_list(TYPE_POWERPC_CPU, false);
> -    g_slist_foreach(list, ppc_cpu_defs_entry, &cpu_list);
> -    g_slist_free(list);
> -
> -    for (i =3D 0; ppc_cpu_aliases[i].alias !=3D NULL; i++) {
> +    for (unsigned i =3D 0; ppc_cpu_aliases[i].alias !=3D NULL; i++) {
>          PowerPCCPUAlias *alias =3D &ppc_cpu_aliases[i];
>          ObjectClass *oc;
>          CpuDefinitionInfo *info;
> @@ -213,8 +205,20 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Err=
or **errp)
>          info->name =3D g_strdup(alias->alias);
>          info->q_typename =3D g_strdup(object_class_get_name(oc));
> =20
> -        QAPI_LIST_PREPEND(cpu_list, info);
> +        QAPI_LIST_PREPEND(*cpu_list, info);
>      }
> +}
> +
> +CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
> +{
> +    CpuDefinitionInfoList *cpu_list =3D NULL;
> +    GSList *list;
> +
> +    list =3D object_class_get_list(TYPE_POWERPC_CPU, false);
> +    g_slist_foreach(list, ppc_cpu_defs_entry, &cpu_list);
> +    g_slist_free(list);
> +
> +    ppc_add_alias_definitions(&cpu_list);
> =20
>      return cpu_list;
>  }


