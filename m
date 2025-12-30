Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052C5E92722
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 06:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaT65-0002b9-Or; Tue, 30 Dec 2025 01:20:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaT64-0002ay-I6
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 01:20:44 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaT63-0006AU-1h
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 01:20:44 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-64b8b5410a1so10887379a12.2
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 22:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767075641; x=1767680441; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g4JlwfR6wGNR+xCf/PhewrTc6z907l4maBJeRzP/9Rg=;
 b=n5Xy28Xb1z9DVKQ2yCKIpDMcfLOKgLoEL4WUexTn4+KXEIbdVutSLFAhv8wx2EEQLc
 k7KAJH7FtId/d6WwkrMYIvpXsBkizE9Io2pFTghiTbith32QcX9+tBz98CeEO5l17ys+
 mJTY61d8XVJut9VgrpnaCkcBuAhpe1d16eBzkqD5lTes64zDLmNV8mn73ZAmHD/0CvsC
 yOKtC15wpUCpHnbWpy/IR8BXqjXs2L341PemwbpUi7AVJaGyeMrEBLvQVE5OjQQJQw8P
 4f/D08v7C996Exq3gJFD2gYbTC1iOl4SbA1Y+Xc0XGqoQYa+qrlWcgcaset7kNe3d5gN
 AkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767075641; x=1767680441;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g4JlwfR6wGNR+xCf/PhewrTc6z907l4maBJeRzP/9Rg=;
 b=GddBUhuwD7uK03sC6h9LlunSsIfpGaheBh7DVnhC6XILiCb16zT6OifWimYVEyjkvN
 lVXvDZqvurI0iXr4L5lFuMr2fU14IGkaNH6qDzjbd9nYWsEhG/GOJ//VtNW/pxJLv0F1
 uZDihR0XbnTAhLpuaAKVxFGcvodYblKRqAE2TiEVhNCfRhujH6f05bs9zLHPGefj1OVy
 xKtRkgZlgi3fY7w2mhBeygouNyyXsfPdrTvP5wDPRtq/LkT1Myrl/X1PQzn8iiSYbdnz
 jB0jaw6t1X1p//97u6n66hrFGg3QeyfrsisL2R3hg1TXs9rPRJpBlio0CXosOrC8pRN8
 knDQ==
X-Gm-Message-State: AOJu0YzZ0ZGnsiTfqGMx4fFUGze7Xp50szmZS6ZCj60lYB0lbvTf1vXe
 FvgMVNhWattM3OxtdSE0AyDbq4RwCle29yIZIwgpGcCb8mQi7bbuSQsoKE27Qrn/RQ2dUH2DnLW
 a3XVPZvRe6vBcFS7HtxBbwI7hZax/K/SVUt3fhZwK0g==
X-Gm-Gg: AY/fxX733QrfjtI3I3WGHgXaxqaNc+qfXilH0t2k53xuPL1tOsHor7rxS+8TWItcLtI
 w26Bqrjuw0bbB/N9ZMQPb74s10I6wyIHHIxJfx11250ASokOSYFwVXx2QTps72ZX2b+OaSKzAOp
 BORmADxDF03N1t6iwJpnv3zzSfGQVEhOij2D9Gb1oCdxL0u8soVIkbnCBHbuX8a/ZbNk+xBKop/
 4SUPVq0HgzhorWY2JuPVoKWji25CszbzZ7gdFhbTGx3eu5vqfXgP/dwXX3Fs97RfgHWbyXjvgFp
 rzXgREeUNHESf6xP/I0C1SS9YLZCJioAq/Sd4tA=
X-Google-Smtp-Source: AGHT+IG5uSFZzBnpvEZkyQnyAWABbUHt/3E9W6oXZ6xrVUBkQNO7AfZmgcIsH/zvGbTyhiLKBXUDX+ZyAJ+vuK9dsqY=
X-Received: by 2002:a17:907:868e:b0:b76:4c8f:2cd8 with SMTP id
 a640c23a62f3a-b8037233e75mr3266472266b.55.1767075640652; Mon, 29 Dec 2025
 22:20:40 -0800 (PST)
MIME-Version: 1.0
References: <20251229231546.50604-1-philmd@linaro.org>
 <20251229231546.50604-3-philmd@linaro.org>
In-Reply-To: <20251229231546.50604-3-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 30 Dec 2025 08:20:14 +0200
X-Gm-Features: AQt7F2om8yuNNMEh47MfYR7w6ICZbcOcszZtkVXIG9R_fOWp8lOW-LAKbGFUOkw
Message-ID: <CAAjaMXarjxwxBZhRJ-8y1N9M+Rxxd+ps0vEccWGC2tbKGY5A5w@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] monitor/hmp: Make memory_dump() @is_physical
 argument a boolean
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Anton Johansson <anjo@rev.ng>, "Dr. David Alan Gilbert" <dave@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, Dec 30, 2025 at 1:16=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Suggested-by: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  monitor/hmp-cmds-target.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
> index 2976f986d35..51dcb9e314c 100644
> --- a/monitor/hmp-cmds-target.c
> +++ b/monitor/hmp-cmds-target.c
> @@ -122,7 +122,7 @@ void hmp_info_registers(Monitor *mon, const QDict *qd=
ict)
>  }
>
>  static void memory_dump(Monitor *mon, int count, int format, int wsize,
> -                        hwaddr addr, int is_physical)
> +                        hwaddr addr, bool is_physical)
>  {
>      int l, line_size, i, max_digits, len;
>      uint8_t buf[16];
> @@ -237,7 +237,7 @@ void hmp_memory_dump(Monitor *mon, const QDict *qdict=
)
>      int size =3D qdict_get_int(qdict, "size");
>      target_long addr =3D qdict_get_int(qdict, "addr");
>
> -    memory_dump(mon, count, format, size, addr, 0);
> +    memory_dump(mon, count, format, size, addr, false);
>  }
>
>  void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
> @@ -247,7 +247,7 @@ void hmp_physical_memory_dump(Monitor *mon, const QDi=
ct *qdict)
>      int size =3D qdict_get_int(qdict, "size");
>      hwaddr addr =3D qdict_get_int(qdict, "addr");
>
> -    memory_dump(mon, count, format, size, addr, 1);
> +    memory_dump(mon, count, format, size, addr, true);
>  }
>
>  void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **e=
rrp)
> --
> 2.52.0
>

