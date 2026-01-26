Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0495DD1950F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 20:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkT2u-00073x-5q; Mon, 26 Jan 2026 15:18:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkT2s-00073i-Vz
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 15:18:47 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkT2r-0003pD-90
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 15:18:46 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42fed090e5fso2999624f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 12:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769458723; x=1770063523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bhIF6Mqn2N6gEaFAlahwqccWQe2+N/1xarR/CbAR/7s=;
 b=FEmrIELROleX2Z27qbdE7GDlyCYkixNYF1dw2HW97ZkFepmL8/g47LSpC9MJKZVUKd
 z4fLB9VuyqpzGOIk8jYPwhcmI0FgCM/JC7SpA9rC8KvcItzRfdoAsXvncVrQ7nn9JWJo
 5B3pVqfNjml1Sg75N+CU5IVv8q8w1dM8zQF1zaBys8duFc7Ky9gFTCBZ7yB6X8y1pJ+Q
 e/56rUMycw7MYhBbdMzKvEktJfflvoRfTD9EXKRhANAr817fddN81oHM3yANyqcVlm7L
 xZeSE+p2DH5MiGll5etvjeETO1oVca5sZDUkuV3H4nkRMxGApsWLzd6SGReibVoJ8nfH
 3IWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769458723; x=1770063523;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bhIF6Mqn2N6gEaFAlahwqccWQe2+N/1xarR/CbAR/7s=;
 b=b2S0rnan5eE9auJkAU7wDC6zyJnhyx7dTEJE2o0k6Z+DIi9EC4FUa59UdD9Xo1BlIL
 mqj63ISGv40bMNrdsAbFweJ/fdRVMW6hkJ4MtantVuakKf26ziF+HT4zA/OMJNJKFfi3
 uVdKA0rsb0D9hJXxQ3G4nCYvAKg8VLXSxc36n6gCuqnJYiiqO51NBz2UfIHYjjMCAy9T
 tg+28+VUHaTuFwgROCS/3XIvMLK0TPfJD7REPr5WNYIJGl4b2klsmZ7HYzV0c0uf8mpY
 gyVkHCYWR7FuQaN5b5uxKnK7yrB8OfPOMz7Zm5CY/Vy//iO41CpN0e8aCT6YqTgYMBoW
 3/rw==
X-Gm-Message-State: AOJu0Ywu+Kz+q04M6AVTcuzkz1qGbd/3NNWcFaQB1qMiARUWh6cF11nS
 peegD2JTPvC6EgItEa1YbbSbQiPDosP1/Gi5d5nJ1hW9TmJGDsF7hBGeNrj9NLkBb9Q=
X-Gm-Gg: AZuq6aJo/ucT8JuHkC8c1M1mk9g8cOdgV3a4ZGxdZQsLeg3iz5qMcfc/q1zKgYXqF+G
 cx2sU56Yqa8j+6OGw7eNHA1ut5Q6G+OqdIAeMnh1zhYPCrSl1kawIf326MuTSDbGoMVI6+3k/pK
 Wpkn1Ylacp8kKVp+nTneSBdGHfwYEgyoCCNVWZjV8bg2Z10nfvRRR5ZPRCu4cw4jzLjmbHwJ2S9
 afI62W2JxVJK/Mnqguuzb7l15TdX5sYohBITK5fWlMo7JCkrg40vdw0YsBaE2Rv6OIw9xBJOmcK
 rtkxd0rrfxLqS837j/fGDfBfwcc+XPyfjnhFn5jVlHVGXHeii/EuZX0j+CB3RlZZMltgx5xA7hj
 W5Y/atSy9vZ9zpWpzohhS6XmH5muLov4KfUuemPLAjuixu9AvDMrs74/5fXQOBX/RMW9SVuTNJO
 pOGTHjX8xyG0JZ
X-Received: by 2002:a05:6000:2885:b0:42f:bb4a:9989 with SMTP id
 ffacd0b85a97d-435ca1656a6mr9492255f8f.28.1769458723119; 
 Mon, 26 Jan 2026 12:18:43 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c246ecsm33294082f8f.10.2026.01.26.12.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 12:18:42 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B8C825F80B;
 Mon, 26 Jan 2026 20:18:41 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org,  laurent@vivier.eu,  imp@bsdimp.com,
 berrange@redhat.com
Subject: Re: [PATCH v3 2/5] plugins: add read-only property for registers
In-Reply-To: <8b36b6c1-83bd-462b-a346-f240dd17746d@epfl.ch> (Florian
 Hofhammer's message of "Tue, 20 Jan 2026 16:23:00 +0100")
References: <ef60bfbb-cc12-4411-acc1-8c131726f22e@epfl.ch>
 <8b36b6c1-83bd-462b-a346-f240dd17746d@epfl.ch>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Mon, 26 Jan 2026 20:18:41 +0000
Message-ID: <871pjcdt5q.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

Florian Hofhammer <florian.hofhammer@epfl.ch> writes:

> Some registers should be marked as read-only from a plugin API
> perspective, as writing to them via qemu_plugin_write_register has no
> effect. This includes the program counter, and we expose this fact to
> the plugins with this patch.
>
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---
>  include/qemu/qemu-plugin.h |  2 ++
>  plugins/api.c              | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index f976b62030..1f25fb2b40 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -942,11 +942,13 @@ struct qemu_plugin_register;
>   *          writing value with qemu_plugin_write_register
>   * @name: register name
>   * @feature: optional feature descriptor, can be NULL
> + * @is_readonly: true if the register cannot be written via qemu_plugin_=
write_register
>   */
>  typedef struct {
>      struct qemu_plugin_register *handle;
>      const char *name;
>      const char *feature;
> +    bool is_readonly;
>  } qemu_plugin_reg_descriptor;
>=20=20
>  /**
> diff --git a/plugins/api.c b/plugins/api.c
> index fc19bdb40b..de8c32db50 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -403,6 +403,12 @@ bool qemu_plugin_bool_parse(const char *name, const =
char *value, bool *ret)
>   * ancillary data the plugin might find useful.
>   */
>=20=20
> +static const char pc_str[] =3D "pc"; // generic name for program counter
> +static const char eip_str[] =3D "eip"; // x86 specific name for program =
counter
> +static const char rip_str[] =3D "rip"; // x86_64 specific name for progr=
am counter
> +static const char pswa_str[] =3D "pswa"; // s390x specific name for prog=
ram counter
> +static const char iaoq_str[] =3D "iaoq"; // HP/PA specific name for prog=
ram counter
> +static const char rpc_str[] =3D "rpc"; // microblaze specific name for
> program counter

It's ugly but I can't think of anything better as you say in the commit mes=
sage.

>  static GArray *create_register_handles(GArray *gdbstub_regs)
>  {
>      GArray *find_data =3D g_array_new(true, true,
> @@ -417,9 +423,20 @@ static GArray *create_register_handles(GArray *gdbst=
ub_regs)
>              continue;
>          }
>=20=20
> +        gint plugin_ro_bit =3D 0;
>          /* Create a record for the plugin */
>          desc.handle =3D GINT_TO_POINTER(grd->gdb_reg + 1);
>          desc.name =3D g_intern_string(grd->name);

Lets just set desc.is_readonly to false here.

> +        if (!strcmp(desc.name, pc_str)
> +            || !strcmp(desc.name, eip_str)
> +            || !strcmp(desc.name, rip_str)
> +            || !strcmp(desc.name, pswa_str)
> +            || !strcmp(desc.name, iaoq_str)
> +            || !strcmp(desc.name, rpc_str)
> +           ) {
> +            plugin_ro_bit =3D 1;
> +        }
> +        desc.is_readonly =3D plugin_ro_bit =3D=3D 1 ? true : false;

And fold setting it to true into the if statement. I have a marginal
preference for g_strcmp0(desc.name, eip_str) =3D=3D 0 style tests.

>          desc.feature =3D g_intern_string(grd->feature_name);
>          g_array_append_val(find_data, desc);
>      }

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

