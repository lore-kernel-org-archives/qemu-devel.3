Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520E0E77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 14:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYPhG-000867-LX; Wed, 24 Dec 2025 09:18:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYPgf-00083l-Dw
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 09:18:03 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYPga-0004Ur-QB
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 09:17:58 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b735e278fa1so1050467466b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 06:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766585874; x=1767190674; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8BofzCtlTo6EXsov+Akxy7dn+iBdVlGsxF8E/Y2EvEQ=;
 b=kPNFMBEyVwMqY07141Tj0aO8fN9Sx8ZNiaCV2Hj5Jlg7jJUKEbqUBEqnrvQvRoddTS
 CO6u293urAKr2sPNweMBEPgow0gAs54xDrGWeCDqZc++jgInSbcqFKD1KvelxKzwxSYJ
 mjWUNaQUgC2XPjZKhLB5LdK5zGBcOyRq1QmDfbSqpOelvJaiBWH2Xd8gavocP0izfK4g
 HZDsdWbIyShvlH/6v4h3eTdQv87dI1RjuZuTMkHG6H029LK9krqde0TmcVecUiytK9Mb
 h1X3byDcL88bTExGPPDi6aJLqfsqJiyH2EREHsBRHZEGlFOQqLRPiiCmD/JlNnuUfMLR
 flAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766585874; x=1767190674;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8BofzCtlTo6EXsov+Akxy7dn+iBdVlGsxF8E/Y2EvEQ=;
 b=QHJx0n0xatEa0tWSuu0FvQ3BdUv6BzW3ifnslLC7dzcdA9yW9AkZpTOxpB2uyr2BbB
 GBYwoJc2xmAkSM3RXRoCKe8OYDr7iN9WqfXqykDUy6XrbBo2gqt0MugDNKP/c9f88Ut/
 C6TIqAmrBCQtPeSYtrtxPdFCIJJNQIKtr1FowuRAvLLd1W6Og4GCUGPMnEVR7Mp7EDYe
 dCalVqFCloT9YUuBWDAH5tcqwa94uKyGpG5KjISXTPc1XDT+R64jTj34c5Bn4Jkbw+/L
 Q9WHUKy9gLgH0VRZWCEKk3Y4G+0znuv8Ads7aVvOkqcmbTCfZuOw5JCBttgDuCfuqenK
 bImA==
X-Gm-Message-State: AOJu0Ywc5MB+Wwl1O9M31l59nt5LS0PuHgXBbBN+n4bvBDb7n5U4yJiL
 AXEHqPdOFrOcEJa2SLhQcum2trEZQZ4gsvwDI5RssQ21x9dFmJfzP4eRdJUKV09OPQirQsoIPab
 6GhYu+QXWa+qUZKPgELX19Oi4QDSMfhXWmYq1ied+Mw==
X-Gm-Gg: AY/fxX4MwPqzo+5H3exD7QytWekyOjAGtXPYrf+fYVDnBohnAvwIcL3a56kPQs1chsI
 jidkY1vEdZAGlIcBpNDAHJAEbeJwSWMdVPlBJwDOGvbBvw3wFLA8Ti4bI18KLNqHmP16a/vyUWy
 9ZskFsHNjO7/JQQ85AaASnpm4Kzp+CSvTDaImqZ72i2nWq2tLogsKkD3s99JKtVWq5ZzuAKxnAA
 UU8aXsARHBvM+Uy9VVnHaSLPLq98R6d4kUvcMxffPAg40xUB0EE7tSYToeqKKqcZ/EmJ4I=
X-Google-Smtp-Source: AGHT+IE6nKGTsnjtptHBkEZrl2AihkM/8lMOUFGqb4KqS39HpCZLk35Nk/8R2lNyqApyK/SnAHSplW+c1ExZOH/iE4o=
X-Received: by 2002:a17:907:8686:b0:b7c:e5d6:2462 with SMTP id
 a640c23a62f3a-b8036f60923mr1967065766b.28.1766585874202; Wed, 24 Dec 2025
 06:17:54 -0800 (PST)
MIME-Version: 1.0
References: <20251224133949.85136-1-philmd@linaro.org>
 <20251224133949.85136-2-philmd@linaro.org>
In-Reply-To: <20251224133949.85136-2-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 24 Dec 2025 16:17:28 +0200
X-Gm-Features: AQt7F2r6DDVzx2oFi2SpbZmG1L_0xHyXq5IHFHmy4uCCFdOa_x9z7IUokzbU3JA
Message-ID: <CAAjaMXZ8yZBXnKxUyhyNJ=ZyF852ZzXj-Zh0GeT3-2F39atBTw@mail.gmail.com>
Subject: Re: [PATCH 1/6] monitor/hmp: Replace target_ulong -> vaddr in
 hmp_gva2gpa()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x634.google.com
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

On Wed, Dec 24, 2025 at 3:40=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> cpu_get_phys_page_debug() takes a vaddr type since commit
> 00b941e581b ("cpu: Turn cpu_get_phys_page_debug() into a CPUClass
> hook").
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  monitor/hmp-cmds-target.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
> index e9820611466..2976f986d35 100644
> --- a/monitor/hmp-cmds-target.c
> +++ b/monitor/hmp-cmds-target.c
> @@ -301,7 +301,7 @@ void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
>
>  void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
>  {
> -    target_ulong addr =3D qdict_get_int(qdict, "addr");
> +    vaddr addr =3D qdict_get_int(qdict, "addr");
>      CPUState *cs =3D mon_get_cpu(mon);
>      hwaddr gpa;
>
> --
> 2.52.0
>

