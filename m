Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF425E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 11:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVqsc-0003DV-Ed; Thu, 09 Jan 2025 06:39:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVqsa-0003D6-21
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:39:12 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVqsX-0007p8-Vw
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:39:11 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ab2bb0822a4so172304366b.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 03:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736422748; x=1737027548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XT3rUIa+fR6lDSPgRgznesp0RAFvnwhRGc0eUOfj67s=;
 b=E/IRj/Ar88BjauL7fDA3e/txV3wS8hjxfm979hhWaBrrCS096PT6ONpK9vHpQ5BmOT
 3bcqXJPMTpS2W09blhUcllyPNzFiuvtx61T1EY4Wu+Z8+sCdWxiOBUmXFfbV5A3lKV0h
 hsLWsdZWcaDBsat4MbWrXAESwoLvgFP7ekxvCz3Yl6srhJSl3/mH0SYSHUgsIDx9ISTU
 +FFd9EPN9y5OuFwwTWeKyEQkcVivWRoqdNIllevG9eyMqec6IU6lptYpO3pcHohsoy9w
 mnEzlrF6R4bGvOA0fRrxk2ICfbfbItJ4y7IF1bjl90mMVbo5plfdbwq102vhqR9i7k5i
 ReEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736422748; x=1737027548;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XT3rUIa+fR6lDSPgRgznesp0RAFvnwhRGc0eUOfj67s=;
 b=GHZl1ZCi23XHarhTVme22vlr52UTB8Ko3dRoYwKzLZy8k14d2BAcDLom/B2RQQJ42H
 Mbner/9rQUqcSS9lRpnM2zDRceMhmltnjrIjJXAk1QsKlU6HATxs8uWSAnAOJPHHFWUj
 Vagjuq8+TDhJW5CBldMqnMBDdi9QqbQUTKqOxs7xYOx4tPVDydQE6ldP1rIz2wF7Otq+
 jkL+aga4smTzxl8r+whAKqWhC+x26tdxv83ltdyEoCfr36p3f2wd2VK4wRIXL7Y068zc
 bf3pQuK47ySfC6f150nqHKonFPp1TcEQ8L05LRwL0rPo1juDuWEZlcHLpAK0jvPYYD0k
 QcEw==
X-Gm-Message-State: AOJu0YzZuKGCxdBHLszXEpOw+qTQAa4ApEDeAOzLq2n6WkRlE1Dvl7EC
 o+oTOhy7AnGh2icGUgfYuIt2rXoR3XtQdTkrae4c2qeuTP3xDiVxF61QavPlW2U=
X-Gm-Gg: ASbGncs2DQFW+JsjSU2HxzngjFsftqKfVROISlgbmoqsyQPBENXxGOLkXh0UKBdd1g4
 Zs5IwinjVhTMD7VrEE68edB3LxgXEStuSuQs++TK9O/5vmzcdy4qGDKwGknh/1rbTi9A//J9h+C
 OTZjFCQajZiby7sWW/+C6F3KlRBw0vywy2IftJjlm+AgCkoGiFYu5N4y31Bmx1rRVtkMlnY4RQG
 rkrk3IAo505/Edv959obORHYGHG4VVaNW6zKl9Y31d7YkqErEN43uU=
X-Google-Smtp-Source: AGHT+IHE12jTTySfq+S0M4WATnxNqegCpOI3OkhXya67LHW2ppGg/fBa9cKgbQ7aLO3uxEnWDLieng==
X-Received: by 2002:a17:907:3f19:b0:aac:1e96:e7d2 with SMTP id
 a640c23a62f3a-ab2ab70a4bfmr493270466b.54.1736422748106; 
 Thu, 09 Jan 2025 03:39:08 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c905ec4dsm63111966b.35.2025.01.09.03.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 03:39:05 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CF78F5F87E;
 Thu,  9 Jan 2025 11:38:48 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Rowan Hart <rowanbhart@gmail.com>
Cc: qemu-devel@nongnu.org,  Alexandre Iooss <erdnaxe@crans.org>,  Pierrick
 Bouvier <pierrick.bouvier@linaro.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>
Subject: Re: [PATCH 1/1] plugins: add API to read guest CPU memory from hwaddr
In-Reply-To: <20240828063224.291503-2-rowanbhart@gmail.com> (Rowan Hart's
 message of "Tue, 27 Aug 2024 23:32:24 -0700")
References: <20240828063224.291503-1-rowanbhart@gmail.com>
 <20240828063224.291503-2-rowanbhart@gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 09 Jan 2025 11:38:48 +0000
Message-ID: <877c749pyv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

Rowan Hart <rowanbhart@gmail.com> writes:

Apologies for the delay, I realise this has been sitting on my review
queue too long.

> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> ---
>  include/qemu/qemu-plugin.h   | 22 ++++++++++++++++++++++
>  plugins/api.c                | 17 +++++++++++++++++
>  plugins/qemu-plugins.symbols |  2 ++
>  3 files changed, 41 insertions(+)
>
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index c71c705b69..25f39c0960 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -868,6 +868,28 @@ QEMU_PLUGIN_API
>  int qemu_plugin_read_register(struct qemu_plugin_register *handle,
>                                GByteArray *buf);
>=20=20
> +/**
> + * qemu_plugin_read_cpu_memory_hwaddr() - read CPU memory from hwaddr
> + *
> + * @addr: A virtual address to read from

A physical address

> + * @data: A byte array to store data into
> + * @len: The number of bytes to read, starting from @addr
> + *
> + * @len bytes of data is read starting at @addr and stored into @data. I=
f @data
> + * is not large enough to hold @len bytes, it will be expanded to the ne=
cessary
> + * size, reallocating if necessary. @len must be greater than 0.
> + *
> + * This function does not ensure writes are flushed prior to reading, so
> + * callers should take care when calling this function in plugin callbac=
ks to
> + * avoid attempting to read data which may not yet be written and should=
 use
> + * the memory callback API instead.

Maybe we should be clear this can only be called from a vCPU context?
See bellow.

> + *
> + * Returns true on success and false on failure.
> + */
> +QEMU_PLUGIN_API
> +bool qemu_plugin_read_cpu_memory_hwaddr(uint64_t addr,
> +                                          GByteArray *data, size_t len);
> +
>  /**
>   * qemu_plugin_scoreboard_new() - alloc a new scoreboard
>   *
> diff --git a/plugins/api.c b/plugins/api.c
> index 2ff13d09de..c87bed6641 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -527,6 +527,22 @@ GArray *qemu_plugin_get_registers(void)
>      return create_register_handles(regs);
>  }
>=20=20
> +bool qemu_plugin_read_cpu_memory_hwaddr(uint64_t addr,
> +                                        GByteArray *data, uint64_t len)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    if (len =3D=3D 0) {
> +        return false;
> +    }
> +
> +    g_byte_array_set_size(data, len);
> +    cpu_physical_memory_rw(addr, (void *)data->data, len, 0);

One concern here is that cpu_physical_memory_* swallows any error
conditions so the user might not get what they are expecting even if we
return true here.

It would be safer I think to use address_space_read_full with
&address_space_memory and MEMTXATTRS_UNSPECIFIED and check the result so
we can signal to the user when it fails.

However that does gloss over some details because you can have multiple
address spaces. As each vCPU can potentially have its own maybe we want:

  g_assert(current_cpu);
  res =3D address_space_read_full(current_cpu->as, addr, attrs, buf, len);
  return res =3D=3D MEMTX_OK ? true : false;

However even that elides a complexity because a CPU can have multiple
AddressSpaces depending on what mode it is in.

For example Arm can have normal, secure and potentially normal and
secure versions of tag memory. Currently we have no way of exposing that
information to plugins (and maybe we don't want to, currently
arm_addressspace() is only used for internal page table walking and some
stack stuff).

x86 has two potential address spaces with the extra one being used for
I think System Management Mode.


> +    return true;
> +#else
> +    return false;
> +#endif
> +}
> +
>  int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArr=
ay *buf)
>  {
>      g_assert(current_cpu);
> @@ -534,6 +550,7 @@ int qemu_plugin_read_register(struct qemu_plugin_regi=
ster *reg, GByteArray *buf)
>      return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1);
>  }
>=20=20
> +
>  struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element=
_size)
>  {
>      return plugin_scoreboard_new(element_size);
> diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
> index ca773d8d9f..5d9cfd71bb 100644
> --- a/plugins/qemu-plugins.symbols
> +++ b/plugins/qemu-plugins.symbols
> @@ -20,6 +20,8 @@
>    qemu_plugin_num_vcpus;
>    qemu_plugin_outs;
>    qemu_plugin_path_to_binary;
> +  qemu_plugin_read_cpu_memory_hwaddr;
> +  qemu_plugin_read_io_memory_hwaddr;
>    qemu_plugin_read_register;
>    qemu_plugin_register_atexit_cb;
>    qemu_plugin_register_flush_cb;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

