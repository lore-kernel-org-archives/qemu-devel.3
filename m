Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950C1F4BB65
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 17:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuwXv-0004vh-Fa; Tue, 24 Feb 2026 12:50:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vuwXo-0004vA-Nt
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:50:01 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vuwXh-0005fr-BU
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:49:56 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so941066166b.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 09:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771955391; x=1772560191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fS8ze4JVTDCO/dgO2JejC8ZtIyG0TxH4O/d6/cq2RWA=;
 b=SwHI+anvaYqirUsjwP0F7cPd+NsvUt0GS8FOVKaWGyNQqBv68p3XaGD4uMoTT55ZtC
 dcx+nS1MWiRzfwRY0HB0WGYKQRasQzYlYkbj7G2QvpOv9to5nD6X2bQtV41B0FOg1rtp
 CO69a9X6g3zwDigY1lBL8Ai50MjszRhzFuq7ehP/36yVspRdsSVCrCwNqg0vZcHiFAh5
 FKvClc93xE6UM8tvXheZQfP4CgT1mxnyVUle3UJlRKFILDspqYAzkrgD1TkLrDvI7R16
 DNKshqQiTuSHNLHSwBa9L0+dxZ9ep3On3g5I8teg/mhPgcw/N/CsigprYPKJLNgA1Mid
 XbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771955391; x=1772560191;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fS8ze4JVTDCO/dgO2JejC8ZtIyG0TxH4O/d6/cq2RWA=;
 b=YXa/F2wFYLWeGxadowAkt46CdC/AOlXwbwaCIqBNu31tiYNMzfE2VijNEZS6JdqQIZ
 mCfiBKtf7qj6q53Td7cw2rwFdfdyBRKywshGvrtl1RDJ3UnxoLpK/4Ps7UDrPhruNGUx
 thHbymCLDvszAB2dmQ0yrD6fO6540gndJN+meBA2r55g+VkuQeDiNt9rqE3uFkiJdWj1
 +TAtCcfcPHnc0tPuiqLYrujVrQNIwmZVcEfmGLSHVok1I4WA9TZ2rybbRRcqJtg3X3PE
 cFV7vJpygwa7N1iQGkjgeYwey4LP0ApZE9Jv0QIEUEzEA1hF6nkEgRs+cvymo46bkbc2
 5T7Q==
X-Gm-Message-State: AOJu0YwG3B+NnJ4Lbrfnw4YBXccltmSdu44L3c83gkJZMTPCP7//R8co
 N/3QkVigSHCirYSL1+QQRiGpYWCe3VmcnQQ9cZkAztZj/LERWS/qVEyYYdIvVDqfX7M=
X-Gm-Gg: AZuq6aJlXdMV3k8zWzn7lDU2BL25QULlJ2HLB1NQq1pbOzXqWPrD8H/FnwixMfU/XG6
 2ZIMKo27zNUP8HKImdI8P/P6wTYtECaUMArFdb5KRb1rzSXtu9jJqJ/gjS6wACL7pa6GCmizWNi
 69Ge2IVFumqEi6rQWAY9CR/fhFkY3rshnP557QpEqbMAzzGWD7ZkWFR+mQRmNM6J12uZeRny5YF
 uelsjSWf1wmP3eGvm74icMB7LqjuvlgJd/KviyXVupocSJ7Wk338A7x5zMdr693rOz/OK27u9aS
 tR+7JuSDhDBnD9h868bKccONZfze2fMxMCIVIiSYszlQkmEketGsCK0KEIdMluihCn+wiRz66t9
 1xitAImVvLf5YOQ4chiq6jPd5ue2Ux1W+8umv3mBP3huMq1KEVNxrfHMtxZD21GpbbYLm9PKee6
 gcaZ7vlu/y7qfRHiHQOoqK+MI=
X-Received: by 2002:a17:907:98d:b0:b8f:8660:3caf with SMTP id
 a640c23a62f3a-b908196f4ecmr931213266b.5.1771955391402; 
 Tue, 24 Feb 2026 09:49:51 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9084cad8ebsm445252066b.27.2026.02.24.09.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 09:49:49 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E4EEB5F7B4;
 Tue, 24 Feb 2026 17:49:48 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org,  laurent@vivier.eu,  imp@bsdimp.com,
 berrange@redhat.com
Subject: Re: [PATCH v4 6/7] plugins: prohibit writing to read-only registers
In-Reply-To: <cc5b7b1a-b562-4376-8e4c-f01607bbcf9b@epfl.ch> (Florian
 Hofhammer's message of "Tue, 24 Feb 2026 16:57:21 +0100")
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <cc5b7b1a-b562-4376-8e4c-f01607bbcf9b@epfl.ch>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Tue, 24 Feb 2026 17:49:48 +0000
Message-ID: <87ldgi2fr7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

> The opaque register handle encodes whether a register is read-only in
> the lowest bit and prevents writing to the register via the plugin API
> in this case.
>
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---
>  plugins/api.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/plugins/api.c b/plugins/api.c
> index b2c52d2a09..3a8479ddce 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -424,6 +424,7 @@ static GArray *create_register_handles(GArray *gdbstu=
b_regs)
>      for (int i =3D 0; i < gdbstub_regs->len; i++) {
>          GDBRegDesc *grd =3D &g_array_index(gdbstub_regs, GDBRegDesc, i);
>          qemu_plugin_reg_descriptor desc;
> +        gint plugin_ro_bit =3D 0;
>=20=20
>          /* skip "un-named" regs */
>          if (!grd->name) {
> @@ -431,7 +432,6 @@ static GArray *create_register_handles(GArray *gdbstu=
b_regs)
>          }
>=20=20
>          /* Create a record for the plugin */
> -        desc.handle =3D GINT_TO_POINTER(grd->gdb_reg + 1);
>          desc.name =3D g_intern_string(grd->name);
>          desc.is_readonly =3D false;
>          if (g_strcmp0(desc.name, pc_str) =3D=3D 0
> @@ -442,7 +442,9 @@ static GArray *create_register_handles(GArray *gdbstu=
b_regs)
>              || g_strcmp0(desc.name, rpc_str) =3D=3D 0
>             ) {
>              desc.is_readonly =3D true;
> +            plugin_ro_bit =3D 1;
>          }
> +        desc.handle =3D GINT_TO_POINTER((grd->gdb_reg << 1) | plugin_ro_=
bit);
>          desc.feature =3D g_intern_string(grd->feature_name);
>          g_array_append_val(find_data, desc);
>      }
> @@ -467,7 +469,7 @@ bool qemu_plugin_read_register(struct qemu_plugin_reg=
ister *reg,
>          return false;
>      }
>=20=20
> -    return (gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1=
) > 0);
> +    return (gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) >> =
1) > 0);
>  }
>=20=20
>  bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
> @@ -476,11 +478,12 @@ bool qemu_plugin_write_register(struct qemu_plugin_=
register *reg,
>      g_assert(current_cpu);
>=20=20
>      if (buf->len =3D=3D 0 || (qemu_plugin_get_cb_flags() !=3D QEMU_PLUGI=
N_CB_RW_REGS &&
> -                          qemu_plugin_get_cb_flags() !=3D QEMU_PLUGIN_CB=
_RW_REGS_PC)) {
> +                          qemu_plugin_get_cb_flags() !=3D QEMU_PLUGIN_CB=
_RW_REGS_PC)
> +        || (GPOINTER_TO_INT(reg) & 1)) {

Maybe this is better as:

      g_assert(GPOINTER_TO_INT(reg) & 1 =3D=3D 0);

      if (buf->len =3D=3D 0 || (qemu_plugin_get_cb_flags() !=3D QEMU_PLUGIN=
_CB_RW_REGS &&...

again the plugin is trying to do something it shouldn't.

>          return false;
>      }
>=20=20
> -    return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(r=
eg) - 1) > 0);
> +    return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(r=
eg) >> 1) > 0);
>  }
>=20=20
>  void qemu_plugin_set_pc(uint64_t vaddr)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

