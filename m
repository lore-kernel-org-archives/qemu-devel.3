Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987DAC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 15:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh8bI-0004ih-9S; Wed, 30 Jul 2025 11:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uh7Pa-0001Rk-Lz
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 10:04:08 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uh7PY-0005Z1-MW
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 10:04:06 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ae708b0e83eso1259320866b.2
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 07:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753884243; x=1754489043; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ZTs40LFOpbnC+/hk30fN1exanZBIE05cCHHZRfMb1E=;
 b=VLgysrJDV2U1CtLPZThyCyoHYVtTNmPLNHaCI9CGdrnLxzbVc/tBAzbMZT2OlImQ4P
 O4M05kJV/149X3jLyAhffBKu7WZm4FaFEJZBI+N9jlImMb/kJKhK4BtfXUszf5koWRSZ
 qiDSb3fp6Gx+JurISsMNigOvkqozqd3IVbIpWilhEfSTr41jLzWVFtfDSlnAPHQqEx5F
 rnujCIs3lB5U/qIWXfYn3Kd9ba8TJmWb9n2JvuWMCAZNQhAYA37Jp2pzE6hmSpz1crb1
 7t5LJeARSxMCW/z0JTAsMirYXWh19PB9RrIhKVYIZnQQ9hc5FpnVwyLCPewpeJuWwkOC
 UNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753884243; x=1754489043;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ZTs40LFOpbnC+/hk30fN1exanZBIE05cCHHZRfMb1E=;
 b=ARQVT8E4HCxdZSLJ3MJ/L25C3O+TsRUjrLUiCQFQHH5IocM9+lUskFducxIKWFBZTm
 iKXexhnDfSi1EmXf4jwYu8mV7uVO1kXiEC89aXvsZ6CGkhUrgcBudU0p26WzClEwhk9q
 FhzdQzR2YRCy/cUznWNC8U6XZRtKAA5pgHYor68j1t64orJGmhB/W84b0D16btBrXsUf
 gqUicpdMtO0ZtFBApIm723vJWlbSllL09lXwxmnTNtEff0WCzA0B4O2YcrwVwrf9CRDc
 f1PdZqziR8X7Xbrtp+mKd5QKOsOae7ryU2Gp/eGB9k+foY53R385FmLq22nyzo8TuMPo
 vz4A==
X-Gm-Message-State: AOJu0YzJ/47qtmApka/4jXghkeCZXUxsyb3W0YEtt6+QxbHhEcIVFKbv
 cvqDyI8KK1IQGzmeCTsODUk0RvQ6Qa4yYYtKhWUlXnz/WTrUmeGOI2e2xpUhUlJT8qpPQyTXJyC
 C/HibuIljqKFYSaomVPa8b7a6Lbn6D+mCyNw3vjVDxg==
X-Gm-Gg: ASbGncsBD2RTcpPExS19ScFTlf2+BVpKEzr8qbBv9EOx/eV9o24AQne1y2Ys2VchhdC
 nFuHsVDS3L4a9qFYLR1Rsx9OlcYCEjmWHOMyUUUIp1wJNho9rQx9SfY631np2j7/rlLjTx9aDjU
 RMPJETlhAEIQuittCo8mBIPeES60vB6f5v86JqmkKgK3Ydmu7BWOXFX8BuxMn3y6P/qAjaPfH+r
 8ZftHM=
X-Google-Smtp-Source: AGHT+IEUuD+ftHHkz9M3cDsOPmgUqjgLUGTUUm1LTczjEynT3G90OBA9Y9SoXzKCE6xScnRf8ARMvipSLN7znVkYRv4=
X-Received: by 2002:a17:907:7290:b0:af2:bb2d:9b1e with SMTP id
 a640c23a62f3a-af8fd69be39mr407388666b.5.1753884242392; Wed, 30 Jul 2025
 07:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1753857212.git.asb@igalia.com>
 <cf5a00136738b981a12270b76572e8d502daf208.1753857212.git.asb@igalia.com>
In-Reply-To: <cf5a00136738b981a12270b76572e8d502daf208.1753857212.git.asb@igalia.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 30 Jul 2025 17:03:35 +0300
X-Gm-Features: Ac12FXySYvvNakrAIkQmW2KLXZNiHOsjnw4V4B9zrasiCS6lGQ7YKlrBIA8_2Co
Message-ID: <CAAjaMXZ=pONyiMVYa+=4WD++C=-MwQpTR7SbF1HvE0kuA4rHWA@mail.gmail.com>
Subject: Re: [PATCH 1/5] contrib/plugins/hotblocks: Correctly free sorted
 counts list
To: Alex Bradbury <asb@igalia.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, erdnaxe@crans.org, 
 ma.mandourr@gmail.com, pierrick.bouvier@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62c.google.com
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

On Wed, Jul 30, 2025 at 4:50=E2=80=AFPM Alex Bradbury <asb@igalia.com> wrot=
e:
>
> g_list_free should be passed the head of the list.
>
> Signed-off-by: Alex Bradbury <asb@igalia.com>
> ---
>  contrib/plugins/hotblocks.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
> index 98404b6885..d3dd23ed9f 100644
> --- a/contrib/plugins/hotblocks.c
> +++ b/contrib/plugins/hotblocks.c
> @@ -73,15 +73,16 @@ static void exec_count_free(gpointer key, gpointer va=
lue, gpointer user_data)
>  static void plugin_exit(qemu_plugin_id_t id, void *p)
>  {
>      g_autoptr(GString) report =3D g_string_new("collected ");
> -    GList *counts, *it;
> +    GList *counts, *sorted_counts, *it;
>      int i;
>
>      g_string_append_printf(report, "%d entries in the hash table\n",
>                             g_hash_table_size(hotblocks));
>      counts =3D g_hash_table_get_values(hotblocks);
> -    it =3D g_list_sort_with_data(counts, cmp_exec_count, NULL);
> +    sorted_counts =3D g_list_sort_with_data(counts, cmp_exec_count, NULL=
);
>
> -    if (it) {
> +    if (sorted_counts) {
> +        it =3D sorted_counts;
>          g_string_append_printf(report, "pc, tcount, icount, ecount\n");
>
>          for (i =3D 0; i < limit && it->next; i++, it =3D it->next) {
> @@ -94,7 +95,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>                      qemu_plugin_scoreboard_u64(rec->exec_count)));
>          }
>
> -        g_list_free(it);
> +        g_list_free(sorted_counts);
>      }
>
>      qemu_plugin_outs(report->str);
> --
> 2.50.1
>
>

This looks correct to me. `g_hash_table_get_values` documentation says
the returned value must be freed with `g_list_free`, but
`g_list_sort_with_data` might change the list head, so neither
`counts` nor `it` should be freed, but `sorted_counts` which is the
new list head like the commit message says.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

