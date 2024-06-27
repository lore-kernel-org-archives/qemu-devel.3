Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7D9C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 11:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMmws-0001oV-1o; Thu, 27 Jun 2024 07:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sMmwq-0001oM-CE
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 07:05:52 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sMmwh-0003PF-SV
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 07:05:50 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-584ef6c07c2so749105a12.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 04:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719486341; x=1720091141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GidotyZ4N0yBisnM3ZhGLHji+omLgcc8IELrh9GrqEA=;
 b=n+DcXgJGnbg82Bs4FHBMvTx5gUJhZFRJ9WC+lIBZcftDBxlgfZ1DtfTla048kVTuvp
 qsfF8Rc9ARmmMRsCFXQqrtzF461w4CSC7twE/Tmfg/4bqll8knSpM+EN6evbfQP9LBty
 0l4PHVfqzh7KLU9R+7ohw2gzrTRHHTYwZEyaGQLQ7LfUraYeSKGDcWJqbukFgK80kt+Z
 P6JvkM6HcCVYh7i78DIpEbk1wDs4Ud4Rx040ZhYsI7Rdtv7NmReK8iDzx5B/C5Ea/EaQ
 w/qJCqKKJvACOm9HEY23QEw276DEUpnUjtySEWeBw2l0yxyBqKUJAHcRV48WKa3H+Eie
 C+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719486341; x=1720091141;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GidotyZ4N0yBisnM3ZhGLHji+omLgcc8IELrh9GrqEA=;
 b=FzbpzpJLCFqF0536mbQdDy13rBJyPIBHC2buYrw2eA/hSWy6SmxJU+lJABVL0rhKCo
 YFLc8uAukkdL91nbDBTT3oWnlK85rJ+Od6FiJj+2kytzA/5G7TuapuL16NauCpLwopb9
 mCy4nLE2/wSLERzN1i3d3U8UhxeCc3h0pRPeQBSRkcbFble6vnkEmpgKmx+nMHXYnOa/
 IKvCgbaWB80xKlGmlRF2ufl54k69doB9LX1HvsK6NfCsqV7SkCwkzGtp6IlGmYU0h9cn
 +bRPWDvxBrKO7XvXHpj72o2K0axR1QxpJ2953K/zlQN7gSF3Uz9pKgb1JrFkX85QEi1y
 ZgMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8DPq0Z/0FKfKjGFlk9JH5Jcu4gpxeapQOKUXyuFcgpnmKCXH/8CNsxIElUcnE/7dyc9EZ3s6P8fIWpGXqHtXGboPWUPQ=
X-Gm-Message-State: AOJu0YwNwO8fIwvtJOgE840fmCRTlt4vgbQ+y0RqGfrAlQ3mbf+P4Azj
 tPuzTeBryP/h8S5v/xD/oL5R+8qLOoRp4aukZV5fr40ACq6ddraZ9CxnwFg9usg=
X-Google-Smtp-Source: AGHT+IH38xlS4r0HWUswTGKbUKAq9uA6iq+QE/OaSuJq5U425jwyrXggUfAY6VIadCRoovfU6opFDw==
X-Received: by 2002:a17:907:d40c:b0:a72:8296:ca26 with SMTP id
 a640c23a62f3a-a7296f5b9cdmr174351966b.11.1719486340033; 
 Thu, 27 Jun 2024 04:05:40 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a729d71f5acsm48810166b.68.2024.06.27.04.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 04:05:39 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 86CA75F867;
 Thu, 27 Jun 2024 12:05:38 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Gustavo Romero <gustavo.romero@linaro.org>,  qemu-devel@nongnu.org,
 richard.henderson@linaro.org,  peter.maydell@linaro.org
Subject: Re: [PATCH v5 7/9] gdbstub: Make get cpu and hex conversion
 functions non-internal
In-Reply-To: <e0412202-3dd3-465d-8ed9-37ea9af1751b@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 27 Jun 2024 08:10:13
 +0200")
References: <20240627041349.356704-1-gustavo.romero@linaro.org>
 <20240627041349.356704-8-gustavo.romero@linaro.org>
 <e0412202-3dd3-465d-8ed9-37ea9af1751b@linaro.org>
Date: Thu, 27 Jun 2024 12:05:38 +0100
Message-ID: <874j9eprwd.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 27/6/24 06:13, Gustavo Romero wrote:
>> Make the gdb_first_attached_cpu and gdb_hextomem non-internal so they
>> are not confined to use only in gdbstub.c.
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   gdbstub/internals.h        | 2 --
>>   include/exec/gdbstub.h     | 5 +++++
>>   include/gdbstub/commands.h | 6 ++++++
>>   3 files changed, 11 insertions(+), 2 deletions(-)
>
>
>> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
>> index 1bd2c4ec2a..77e5ec9a5b 100644
>> --- a/include/exec/gdbstub.h
>> +++ b/include/exec/gdbstub.h
>> @@ -135,4 +135,9 @@ void gdb_set_stop_cpu(CPUState *cpu);
>>   /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
>>   extern const GDBFeature gdb_static_features[];
>>   +/**
>> + * Return the first attached CPU
>> + */
>> +CPUState *gdb_first_attached_cpu(void);
>
> Alex, it seems dubious to expose the API like that.
>
> IMHO GdbCmdHandler should take a GDBRegisterState argument,
> then this would become:
>
>   CPUState *gdb_first_attached_cpu(GDBRegisterState *s);

Maybe instead of exposing this we can use user_ctx for something? If we
look at handle_set_reg/handle_get_reg we can see that passes down
gdbserver_state.g_cpu down to the eventual helpers. We could define
something like:

--8<---------------cut here---------------start------------->8---
fixups to avoid get_first_cpu()

5 files changed, 25 insertions(+), 18 deletions(-)
gdbstub/internals.h        |  1 +
include/exec/gdbstub.h     |  5 -----
include/gdbstub/commands.h |  3 +++
gdbstub/gdbstub.c          |  7 ++++++-
target/arm/gdbstub64.c     | 27 +++++++++++++++------------

modified   gdbstub/internals.h
@@ -129,6 +129,7 @@ bool gdb_got_immediate_ack(void);
 /* utility helpers */
 GDBProcess *gdb_get_process(uint32_t pid);
 CPUState *gdb_get_first_cpu_in_process(GDBProcess *process);
+CPUState *gdb_first_attached_cpu(void);
 void gdb_append_thread_id(CPUState *cpu, GString *buf);
 int gdb_get_cpu_index(CPUState *cpu);
 unsigned int gdb_get_max_cpus(void); /* both */
modified   include/exec/gdbstub.h
@@ -135,9 +135,4 @@ void gdb_set_stop_cpu(CPUState *cpu);
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
 extern const GDBFeature gdb_static_features[];
=20
-/**
- * Return the first attached CPU
- */
-CPUState *gdb_first_attached_cpu(void);
-
 #endif /* GDBSTUB_H */
modified   include/gdbstub/commands.h
@@ -54,6 +54,8 @@ typedef union GdbCmdVariant {
  * "stop reply" packet. The list of commands that accept such response is
  * defined at the GDB Remote Serial Protocol documentation. See:
  * https://sourceware.org/gdb/onlinedocs/gdb/Stop-Reply-Packets.html#Stop-=
Reply-Packets.
+ *
+ * @need_cpu_context: pass current CPU to command via user_ctx.
  */
 typedef struct GdbCmdParseEntry {
     GdbCmdHandler handler;
@@ -61,6 +63,7 @@ typedef struct GdbCmdParseEntry {
     bool cmd_startswith;
     const char *schema;
     bool allow_stop_reply;
+    bool need_cpu_context;
 } GdbCmdParseEntry;
=20
 #define get_cmd_parsers(p) (&g_array_index(p, GdbCmdParseEntry, 0))
modified   gdbstub/gdbstub.c
@@ -938,6 +938,7 @@ static bool process_string_cmd(const char *data,
=20
     for (i =3D 0; i < num_cmds; i++) {
         const GdbCmdParseEntry *cmd =3D &cmds[i];
+        void *user_ctx =3D NULL;
         g_assert(cmd->handler && cmd->cmd);
=20
         if ((cmd->cmd_startswith && !startswith(data, cmd->cmd)) ||
@@ -952,8 +953,12 @@ static bool process_string_cmd(const char *data,
             }
         }
=20
+        if (cmd->need_cpu_context) {
+            user_ctx =3D (void *) gdbserver_state.g_cpu;
+        }
+
         gdbserver_state.allow_stop_reply =3D cmd->allow_stop_reply;
-        cmd->handler(params, NULL);
+        cmd->handler(params, user_ctx);
         return true;
     }
=20
modified   target/arm/gdbstub64.c
@@ -427,9 +427,9 @@ int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *=
buf, int reg)
     return 1;
 }
=20
-static void handle_q_memtag(GArray *params, G_GNUC_UNUSED void *user_ctx)
+static void handle_q_memtag(GArray *params, void *user_ctx)
 {
-    ARMCPU *cpu =3D ARM_CPU(gdb_first_attached_cpu());
+    ARMCPU *cpu =3D ARM_CPU(user_ctx);
     CPUARMState *env =3D &cpu->env;
=20
     uint64_t addr =3D gdb_get_cmd_param(params, 0)->val_ull;
@@ -470,9 +470,9 @@ static void handle_q_memtag(GArray *params, G_GNUC_UNUS=
ED void *user_ctx)
     gdb_put_packet(str_buf->str);
 }
=20
-static void handle_q_isaddresstagged(GArray *params, G_GNUC_UNUSED void *u=
ser_ctx)
+static void handle_q_isaddresstagged(GArray *params, void *user_ctx)
 {
-    ARMCPU *cpu =3D ARM_CPU(gdb_first_attached_cpu());
+    ARMCPU *cpu =3D ARM_CPU(user_ctx);
     CPUARMState *env =3D &cpu->env;
=20
     uint64_t addr =3D gdb_get_cmd_param(params, 0)->val_ull;
@@ -487,9 +487,9 @@ static void handle_q_isaddresstagged(GArray *params, G_=
GNUC_UNUSED void *user_ct
     gdb_put_packet(reply);
 }
=20
-static void handle_Q_memtag(GArray *params, G_GNUC_UNUSED void *user_ctx)
+static void handle_Q_memtag(GArray *params, void *user_ctx)
 {
-    ARMCPU *cpu =3D ARM_CPU(gdb_first_attached_cpu());
+    ARMCPU *cpu =3D ARM_CPU(user_ctx);
     CPUARMState *env =3D &cpu->env;
=20
     uint64_t start_addr =3D gdb_get_cmd_param(params, 0)->val_ull;
@@ -567,21 +567,24 @@ enum Command {
 static GdbCmdParseEntry cmd_handler_table[NUM_CMDS] =3D {
     [qMemTags] =3D {
         .handler =3D handle_q_memtag,
-        .cmd_startswith =3D 1,
+        .cmd_startswith =3D true,
         .cmd =3D "MemTags:",
-        .schema =3D "L,l:l0"
+        .schema =3D "L,l:l0",
+        .need_cpu_context =3D true,
     },
     [qIsAddressTagged] =3D {
         .handler =3D handle_q_isaddresstagged,
-        .cmd_startswith =3D 1,
+        .cmd_startswith =3D true,
         .cmd =3D "IsAddressTagged:",
-        .schema =3D "L0"
+        .schema =3D "L0",
+        .need_cpu_context =3D true,
     },
     [QMemTags] =3D {
         .handler =3D handle_Q_memtag,
-        .cmd_startswith =3D 1,
+        .cmd_startswith =3D true,
         .cmd =3D "MemTags:",
-        .schema =3D "L,l:l:s0"
+        .schema =3D "L,l:l:s0",
+        .need_cpu_context =3D true,
     },
 };
 #endif /* CONFIG_USER_ONLY */
--8<---------------cut here---------------end--------------->8---


>
> Regards,
>
> Phil.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

