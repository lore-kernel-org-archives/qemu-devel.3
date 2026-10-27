Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9813F606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=b215/DVg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLb6f-0007Gl-O3; Tue, 27 Oct 2026 02:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xLb6c-0007GE-JH
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:56:23 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xLb6b-0002KG-2h
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:56:22 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6b2237b596cso5817503a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793084179; x=1793688979; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=j5Hic5eKOORlv5GSjXr0pV1A8SO1Xs2+uTB+W1RKx7U=;
 b=b215/DVgg59lW68aIOJftKTUCoGuw06dx+dv37UXjAoN1lwF0RxSLcySX8GT91Wi3k
 jAndUEzAE8sGdugwsy7N/Tok92JSqdMhlOXUc35i/iNIY9H+nSwAVNmtn9FmoJfatcfd
 qC202xf61Fr7SpwbnJTU/v4sKBwd63bfG8dm338qvOAPs0uspR3LwBvyVVdKPtkFszxt
 vvQz42fK3zhhoJb9CRcxXoVxiQq9O3iD3blhYBg5dBzH3tdqf+D7n0MVo5T49h8k3mUi
 D1pP3396D1r9HOgeWldF4mG3MZ8mruYqCNjhgmihHnL1GT6Qe7EGu7YxtSue6Y5HghTC
 dwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793084179; x=1793688979;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=j5Hic5eKOORlv5GSjXr0pV1A8SO1Xs2+uTB+W1RKx7U=;
 b=FqFlDH6jUzonrAovd7Vy3eFoRboQ04m20rEiABOZGIWNsaS8TrrmDNs6bQBe5MOWRx
 XgYO6FyMiKUNNdftSm/H+kdYRetx5X4cu1cInVZsdS2Glp8+CYRvTehvX0zZxnthRL7Q
 MjrY//V/RW6a6HAxqXO2egA6EPAAHuYowFciF+DynN0siojFPUQLnuO2g0AalmStMSP3
 IdC/TYl/oiZiqjevq/IhH4Onpuek40GpoeCLqQ078Vnljeh3j1XHQ1liHQioX7CI05No
 Po1VQfWbVQkmuAsAg/EAW+Jjbn+T73k2ekc052Ux/xVD7kGX53AdGbQBihHMqcWV2Ent
 W7LQ==
X-Gm-Message-State: AFq9FYL3skumLmdBka3v21h3lOup9iMCPWE4uhvDApmCwNuT7WLDb/D5
 qqHOGIWaXQ5OHUl3TpOz6/ao7zn89kkDyeV4iGkjYunjs8OVhp7pBOJ81cM1wkrVqUHHfv3Pmxb
 4JITUhb7HOBJIrDsUoXUEQToOsK6mTL6c+GUkFov6OY6h94PAAKPzb1ykL0o+8kJSbbH993j7bL
 dssQX1AbZSYwtfD+tE9VBNqjOIECJ/4M+sQN3U4sRpKHA=
X-Gm-Gg: AYBFou1qatEQrJp1PPXaq/nQaFjFgQdbdhFKmJQyqohryFjn05mU3CSEudWruUbB2zC
 49J4JkK0DXdzT1oBVKPQSCdkpczSfIkxLeyLzren1Lk3ymEju2N0bSpPVyCYSICjyJH56aGW1np
 Fxlw14A1PrX2ArPKnxWv4cV0k4Oa1mQyvn219Z1MO8mlmlfXEkTcBb/XhneRu/Z85UtMoXGHak3
 DEZbA479tgqCYPtvKNRtMuVffV+wPgjTuWsRBO+451v+Xmjr97t5eTo6dUhzBYx1aBXV0HFcLVV
 WqC5kEVDQtPIWyv5Lr86XItk2omoLGFFNSe7Yi8KmrXZcYTUat0h9oesE7AhU+GzhTfEeo8wp8j
 6AKZIdGZcptDDyj8P5g0nQrzCtbqgi6iudJYIRriStUwTGYufXv5mgvxSc4Q+xy8ntqZgYKH+9f
 W+5bAZDX93JieblSoyFfb2f++xABKQQ9AMlEvr8lkj0j4gW/gLEzAKEHkyn0tR8j1GswquOIbr8
 9uddOjb2Cey3NNsevbAd588xIZMMVvsX9adbDwwtPrJuojpfmZ1wbiOgNHuddIf2DrPx05ipWy0
 G1gROXODAfVKArGHoQ==
X-Received: by 2002:a17:906:3a88:b0:c49:901c:d9f with SMTP id
 a640c23a62f3a-c49901c2556mr336913866b.49.1793084178870; 
 Mon, 26 Oct 2026 23:56:18 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com.
 [209.85.208.48]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd795bf8sm400475966b.70.2026.10.26.23.56.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 23:56:17 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6acb57c2b88so4430931a12.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:56:17 -0700 (PDT)
X-Received: by 2002:a05:6402:a15c:b0:6b1:a647:981e with SMTP id
 4fb4d7f45d1cf-6b442fffdaamr7072338a12.24.1793084176792; Mon, 26 Oct 2026
 23:56:16 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
 <20261021231346.2452179-4-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261021231346.2452179-4-daniel.barboza@oss.qualcomm.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Tue, 27 Oct 2026 14:56:05 +0800
X-Gmail-Original-Message-ID: <CAMXXpfa=h0RMtAtgY_aH_nEODpLGfNX4Z4J-rSm_4++Y9VfFtw@mail.gmail.com>
X-Gm-Features: AclHuK9i1RyZM5cmkJ4U-440SnMdtY4axXUljOsJuX1nZeWOy2P7Ft2TgqqOLlA
Message-ID: <CAMXXpfa=h0RMtAtgY_aH_nEODpLGfNX4Z4J-rSm_4++Y9VfFtw@mail.gmail.com>
Subject: Re: [PATCH v4 03/18] hw/riscv/trace-encoder: add trace start/stop
 logic
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, antikostya2@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: multipart/alternative; boundary="000000000000690323065eccf121"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=jay.chang@sifive.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000690323065eccf121
Content-Type: text/plain; charset="UTF-8"

> These flags are controlled by the trTeInstTracing bit. This bit requires
> other two bits to be set beforehand (ACTIVE and ENABLE). We'll revisit
> these bits in the future as more features are implemented.
>
> While we're at it, add hardwire bits to indicate which features we're
> (not) implementing at this time.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>

Reviewed-by: Jay Chang <jay.chang@sifive.com>

Thanks
Jay Chang

--000000000000690323065eccf121
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote gmail=
_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">These f=
lags are controlled by the trTeInstTracing bit. This bit requires<br>
other two bits to be set beforehand (ACTIVE and ENABLE). We&#39;ll revisit<=
br>
these bits in the future as more features are implemented.<br>
<br>
While we&#39;re at it, add hardwire bits to indicate which features we&#39;=
re<br>
(not) implementing at this time.<br>
<br>
Signed-off-by: Daniel Henrique Barboza &lt;<a href=3D"mailto:daniel.barboza=
@oss.qualcomm.com" target=3D"_blank">daniel.barboza@oss.qualcomm.com</a>&gt=
;<br></blockquote><div><br></div><div>Reviewed-by: Jay Chang &lt;<a href=3D=
"mailto:jay.chang@sifive.com">jay.chang@sifive.com</a>&gt;<br><br>Thanks=C2=
=A0<br>Jay Chang</div></div></div>

--000000000000690323065eccf121--

