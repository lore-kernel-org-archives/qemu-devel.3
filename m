Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F6AC54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 17:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfjxp-0007xq-H5; Thu, 29 Feb 2024 12:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfjxh-0007pB-S3
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 12:12:51 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfjxY-0003PN-U1
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 12:12:47 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-412b83cfac4so8224935e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 09:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709226759; x=1709831559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wGW7Dw2lI/QUpTTbtuqGQP+uuWawunyBdyOZZI+3ae8=;
 b=yI/lXvpjQzWOiDvMna9FjtZyywKl9P1umo1nEOwtgLvn7ZN/B/+kihk36jx8JZKtd/
 UwxgFuOWWCaPW6AtE5kyAjGpfWXvn+eMYOW/H+rf3JCqcY6DED04rXczGZVfDd4MmhkK
 kU5jctnSa4FygxuWdQrPJAjyFk3xUGHhnodeHp+K3YIEfD/cw+pffFkldXbLxNPb/nsD
 vpFSMBiDjFBkJiak08HSIz0kOXp4ND5vET/NJIyJMjcJfzzg9Ot+DpwdgPKVUR71GGay
 E79fFGq41MwPsFnba51abGqYLFVi6mx3K5j4deqbY3o5L3hujko7U1dpB3KYkuUyMl4n
 O44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709226759; x=1709831559;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wGW7Dw2lI/QUpTTbtuqGQP+uuWawunyBdyOZZI+3ae8=;
 b=XyEPiUPQfMRvbk0nAgjfeMl+tr2yLZLRj/sAOG5zSLlBZA9x4OOOZ7fP2WO4vHIrW+
 W/mxpcrzFMvY4pQBRUnxnZrZh0T6rb9/Rd7VdH4iqRq1lJrxq+/CW6tdajlYwO3z/gCt
 qY+C8kyWJLNHYqClzIcMqmRbmrQEM8DHHlno830iqLT61v+g35BrEq4KMY6hGhV3cadQ
 mBvidG8LkdacsHgxpKCCoV3j3sYsP1ijPB3OwE34aUvlbTYW1oWSmFkD1ubfCdLJ+k4v
 CgeDP8dmjSAfWZfF3E4DnfcwngLkkmYIavoNUsa+2JYJZx1kjS6b7IdSNVYebuS8aEBH
 HIEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw9/aN0b80ltAAeWygnO+j2nK9eXz4NDur/s+kSqs2fl3pG4aureX3UKHitQnhBcdI+mcwE3SAdGUhAp/u2ptLxTBLEbA=
X-Gm-Message-State: AOJu0YywBm/JiTqqDEBJ3KwI54QVtRpNlb2ELwvIkwSfmWz6BwFzolqc
 0I8W904hr1Ajt1dbQgBLGrHmeDBSiwvgoKxcvS3qXpCYQ4XKyD4baJRoGUjJQ54=
X-Google-Smtp-Source: AGHT+IGXI2ZM/Qa7+MmHqIGobP0ehFV+ro7bwbC2U1x/tX+8nVRZrKw/UyiFHMxAQ1Cvu/6HL0laDA==
X-Received: by 2002:a05:600c:1392:b0:412:b0fa:c331 with SMTP id
 u18-20020a05600c139200b00412b0fac331mr2267097wmf.16.1709226759255; 
 Thu, 29 Feb 2024 09:12:39 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p6-20020adf9d86000000b0033e0dd83be1sm2239280wre.91.2024.02.29.09.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 09:12:38 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 976D35F885;
 Thu, 29 Feb 2024 17:12:38 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Sven Schnelle <svens@stackframe.org>
Cc: Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-devel@nongnu.org,  deller@gmx.de
Subject: Re: [PATCH 3/3] plugins/execlog: add address range matching
In-Reply-To: <20240229150729.1620410-4-svens@stackframe.org> (Sven Schnelle's
 message of "Thu, 29 Feb 2024 16:07:29 +0100")
References: <20240229150729.1620410-1-svens@stackframe.org>
 <20240229150729.1620410-4-svens@stackframe.org>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Thu, 29 Feb 2024 17:12:38 +0000
Message-ID: <874jdr6vp5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Sven Schnelle <svens@stackframe.org> writes:

> Allow to match memory ranges with the address matches. This
> allows to give a range of adresses like '-dfilter=3D0-0x400'
> which would only log memory accesses between 0 and 400.
>
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  contrib/plugins/execlog.c | 73 ++++++++++++++++++++++++++++++---------
>  1 file changed, 56 insertions(+), 17 deletions(-)
>
> diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
> index c89ebc08b6..b1b2a7baf1 100644
> --- a/contrib/plugins/execlog.c
> +++ b/contrib/plugins/execlog.c
> @@ -44,6 +44,11 @@ static bool disas_assist;
>  static GMutex add_reg_name_lock;
>  static GPtrArray *all_reg_names;
>=20=20
> +struct address_match {
> +    uint64_t low;
> +    uint64_t high;
> +};
> +
>  static CPU *get_cpu(int vcpu_index)
>  {
>      CPU *c;
> @@ -54,11 +59,12 @@ static CPU *get_cpu(int vcpu_index)
>      return c;
>  }
>=20=20
> -static bool match_vaddr(uint64_t vaddr)
> +static bool match_address_range(GArray *match, uint64_t vaddr)
>  {
> -    for (int i =3D 0; i < dmatches->len; i++) {
> -        uint64_t v =3D g_array_index(dmatches, uint64_t, i);
> -        if (v =3D=3D vaddr) {
> +    for (int i =3D 0; i < match->len; i++) {
> +        struct address_match *m =3D
> +            g_array_index(match, struct address_match *, i);
> +        if (vaddr >=3D m->low && vaddr <=3D m->high) {
>              return true;
>          }
>      }
> @@ -74,9 +80,7 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugi=
n_meminfo_t info,
>      CPU *c =3D get_cpu(cpu_index);
>      GString *s =3D c->last_exec;
>=20=20
> -    /* Find vCPU in array */
> -
> -    if (dmatches && !match_vaddr(vaddr)) {
> +    if (dmatches && !match_address_range(dmatches, vaddr)) {
>          return;
>      }
>      c->log =3D true;
> @@ -164,8 +168,10 @@ static void vcpu_insn_exec_only_regs(unsigned int cp=
u_index, void *udata)
>              insn_check_regs(cpu);
>          }
>=20=20
> -        qemu_plugin_outs(cpu->last_exec->str);
> -        qemu_plugin_outs("\n");
> +        if (cpu->log) {
> +            qemu_plugin_outs(cpu->last_exec->str);
> +            qemu_plugin_outs("\n");
> +        }
>      }
>=20=20
>      /* reset */
> @@ -178,7 +184,7 @@ static void vcpu_insn_exec(unsigned int cpu_index, vo=
id *udata)
>      CPU *cpu =3D get_cpu(cpu_index);
>=20=20
>      /* Print previous instruction in cache */
> -    if (cpu->last_exec->len) {
> +    if (cpu->log && cpu->last_exec->len) {
>          qemu_plugin_outs(cpu->last_exec->str);
>          qemu_plugin_outs("\n");
>      }
> @@ -239,8 +245,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct=
 qemu_plugin_tb *tb)
>          if (skip && amatches) {
>              int j;
>              for (j =3D 0; j < amatches->len && skip; j++) {
> -                uint64_t v =3D g_array_index(amatches, uint64_t, j);
> -                if (v =3D=3D insn_vaddr) {
> +                if (match_address_range(amatches, insn_vaddr)) {
>                      skip =3D false;
>                  }
>              }
> @@ -394,6 +399,17 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned =
int vcpu_index)
>      c->registers =3D registers_init(vcpu_index);
>  }
>=20=20
> +static void free_matches(GArray *matches)
> +{
> +    if (!matches) {
> +        return;
> +    }
> +
> +    for (int i =3D 0; i < matches->len; i++) {
> +        g_free(g_array_index(matches, struct address_match *, i));
> +    }
> +}
> +
>  /**
>   * On plugin exit, print last instruction in cache
>   */
> @@ -409,6 +425,9 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>          }
>      }
>      g_rw_lock_reader_unlock(&expand_array_lock);
> +
> +    free_matches(amatches);
> +    free_matches(dmatches);
>  }
>=20=20
>  /* Add a match to the array of matches */
> @@ -420,14 +439,34 @@ static void parse_insn_match(char *match)
>      g_ptr_array_add(imatches, g_strdup(match));
>  }
>=20=20
> -static void parse_vaddr_match(GArray **matches, char *match)
> +static void parse_vaddr_match(GArray **matches, char *token)
>  {
> -    uint64_t v =3D g_ascii_strtoull(match, NULL, 16);
> +    uint64_t low, high;
> +    gchar *endp;
>=20=20
> -    if (!matches) {
> -        *matches =3D g_array_new(false, true, sizeof(uint64_t));
> +    low =3D g_ascii_strtoull(token, &endp, 16);
> +    if (endp =3D=3D token) {
> +        fprintf(stderr, "Invalid address(range) specified: %s\n", token);
> +        return;
> +    }
> +
> +    if (*endp !=3D '-') {
> +        high =3D low;
> +    } else {
> +        high =3D g_ascii_strtoull(endp + 1, &endp, 16);
> +        if (endp =3D=3D token) {
> +            fprintf(stderr, "Invalid address(range) specified: %s\n", to=
ken);
> +            return;
> +        }
> +    }
> +
> +    if (!*matches) {
> +        *matches =3D g_array_new(false, true, sizeof(struct address_matc=
h));
>      }
> -    g_array_append_val(*matches, v);
> +    struct address_match *match =3D g_new(struct address_match, 1);
> +    match->low =3D low;
> +    match->high =3D high;
> +    g_array_append_val(*matches, match);

This is almost but not quite qemu_set_dfilter_ranges(). I wonder if it
would be worth a light re-factoring and then exposing the parser as a
helper function?

>  }
>=20=20
>  /*

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

