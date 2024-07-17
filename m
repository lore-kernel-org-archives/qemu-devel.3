Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3352FC3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2Xt-00062y-G9; Wed, 17 Jul 2024 07:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sU2XB-00030Y-W4
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:09:22 -0400
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sU2X9-0000NY-Ij
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:09:21 -0400
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-4f2ec49e067so487042e0c.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 04:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1721214558; x=1721819358;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f2xDtOSNBE5x+Th0TEVDyh8j7f0OFYS8aIeQ5Rl1BMo=;
 b=0BO4FdQO3UWJ08fa7COO2wOO1bTswwBf48lj7F9z5yX6PB1Pbi5XazQNEqtHyRzd+F
 NKtY6zQFBaWrxlLeGXOe6OoNQKEsg22menQREXj2WkPe5avn5Qv5Mi/IGLkFS3qIe15I
 zGXWA3Y64kB4cy7nAjrX0eOdvuReoksmi19tnhifw2v9+ylX+SmgRIOi0+dGZFKK1rJG
 EieByQGbCAzqOSxtiW2gda5OkRHNCtzKODA8tpcA2JV48H9Uf2JzJzPo43r+OybBmkBi
 U0YwuypYctZazCeb2zgKeNW2FlPuFoZxCjQY51kUdJdMsBbyZKa0TsK+AltbJ1I41w85
 RePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721214558; x=1721819358;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f2xDtOSNBE5x+Th0TEVDyh8j7f0OFYS8aIeQ5Rl1BMo=;
 b=XE/lC2Z9/PHFFqGlNJgDpXngWKjS3MbnRTGEe3y7g2zbAJBQh/4rhaSL6zzuhQcd4z
 nHOhuCSspVh6u0vZ99TSditYg6HyKu9Q/h4bEpnYvofXG+pv6qy+PvVZZijo+N8hj8dN
 wSBZ7ZBUlQWEVwEG6xJ780ZG4wMKwotNU/DaW/WaPpfeya02FDnxU7I8saXxSOf1RA+u
 jGbwkN4LljdPsWeSGndYFVAGXQtYcWLLk9TxKxnbCzP/Jdr1DUGfKl7PFd2ChJzHL75d
 YxOcoE2SwIM3gFNjKI81J6U4BN8Zzz5wGULaLasbXcRyltmgu8jMCAO9An6Q67cc3pVM
 HDuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo9TjL/k1/8SxcB4c86f3DLtbzy5wA9lESmTisWzW3wmLnKORWtkRr/QDNsxMxBIjK76l0E1DQ8LfsRAysSTiSVlgpT0M=
X-Gm-Message-State: AOJu0YybkPVg77HfKpsOeMaiPnJzDQE9QrN+5wL/MF+64hE8Rto9NRbC
 Vv5z3WQ4/+VlBSA+4/c2tO4Hslr/qdAZhBi8ShFlK9wvW/cA6MSQcfj+3tg4+WmyzgirRqa5XsF
 4MWy7uv4aAIhFtT2VmnXV2IhsI6YRlwz4iZFy
X-Google-Smtp-Source: AGHT+IH0scdGD9QoDcGnGDcUbQQ6gq/H9/IOnUaxBVij+RO1TAQP9PyVRzjGTfwUjFHuG7zX0SHA5lIT174zT205HkE=
X-Received: by 2002:a05:6122:30a8:b0:4f2:f057:eaf4 with SMTP id
 71dfb90a1353d-4f4df6d9a44mr1752700e0c.7.1721214558078; Wed, 17 Jul 2024
 04:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240715210705.32365-1-phil@philjordan.eu>
 <20240715210705.32365-17-phil@philjordan.eu>
 <28a35035-840a-4c70-aaba-4192f7cd8ef3@linaro.org>
 <CAAibmn1zEFWVt-K3LkucStVxL-jyj=EWThwwtewwyKbKodQ0Sw@mail.gmail.com>
 <94d3d008-4793-1b61-7704-860ac6b4ba90@eik.bme.hu>
In-Reply-To: <94d3d008-4793-1b61-7704-860ac6b4ba90@eik.bme.hu>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 17 Jul 2024 13:09:07 +0200
Message-ID: <CAAibmn0LYAzZdEH-BwS8xLD9tQLtvUhwJFdvTU25Kd4=MrvJFw@mail.gmail.com>
Subject: Re: [PATCH 16/26] hw/display/apple-gfx: Asynchronous MMIO writes on
 x86-64
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, pbonzini@redhat.com, agraf@csgraf.de, graf@amazon.com, 
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com, 
 peter.maydell@linaro.org, akihiko.odaki@daynix.com, lists@philjordan.eu
Content-Type: multipart/alternative; boundary="000000000000512542061d6f7e39"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=phil@philjordan.eu; helo=mail-vk1-xa2e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000512542061d6f7e39
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 16:48, BALATON Zoltan <balaton@eik.bme.hu> wrote:

> Only a guess but I think ARM like POWER has weak memory consistency so
> maybe some sync ops are needed between writes somewhere whereas it would
> work on X86_64 that has strong guarantees so no such explicit sync is
> needed? I may completely wrong though, it's just what this reminded me of.
>

I didn't think this should matter for MMIO, which causes a VM exit instead
of a memory write.

The x86-64 and aarch64 binaries of Apple's PVG framework clearly diverge in
a number of ways. (For one, the x86-64 binary completely lacks the
IOSurface mapper sub-device used by Virtualization.framework and the
vmapple variant of the code here.) So I think the reason is more likely
down to implementation details in Apple's framework.

--000000000000512542061d6f7e39
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Tue, 16 Jul 2024 at 16:48, BALATON Zoltan &lt;<a href=3D"mail=
to:balaton@eik.bme.hu">balaton@eik.bme.hu</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
Only a guess but I think ARM like POWER has weak memory consistency so <br>
maybe some sync ops are needed between writes somewhere whereas it would <b=
r>
work on X86_64 that has strong guarantees so no such explicit sync is <br>
needed? I may completely wrong though, it&#39;s just what this reminded me =
of.<br>
</blockquote><div><br></div><div>I didn&#39;t think this should matter for =
MMIO, which causes a VM exit instead of a memory write.</div><div><br></div=
><div>The x86-64 and aarch64 binaries of Apple&#39;s PVG framework clearly =
diverge in a number of ways. (For one, the x86-64 binary completely lacks t=
he IOSurface mapper sub-device used by Virtualization.framework and the vma=
pple variant of the code here.) So I think the reason is more likely down t=
o implementation details in Apple&#39;s framework.</div><div><br></div></di=
v></div>

--000000000000512542061d6f7e39--

