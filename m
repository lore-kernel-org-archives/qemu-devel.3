Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D2A606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 05:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A9q27ih8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLa1c-0004oD-SJ; Tue, 27 Oct 2026 01:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLa1c-0004o5-3g
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 01:47:08 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLa1a-0004pJ-Gf
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 01:47:07 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6b413b0a974so4361812a12.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 22:47:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793080024; cv=none;
 d=google.com; s=arc-20260327;
 b=OkoqWj3GY+B64Bq7ZK90uzeBlCabC2HeKpIHds90tVn792UpxWwYv8qqWAdbCnKqID
 5CYKEbVkiZrAFXVtkihifnLLHwVKGkAx5m/VV/knONsaz2ZfWddYlw8qjAsNnAPwRaH/
 BO9/AFgyWSL9S4dFDqufijBJUlvUZRknLXXvQUT+mfgwpEVgIUN4ipiFgVDD3drMdvvo
 z+DFSD1XzYK35ThC3Voe2pGC2A5yoCrm1AlFo2zGDBGCebe12PcQ9D9RkwPnwNmfFQWB
 5aF/PZK17ERPxYK4KgqfeymWTSKbPAp0PfTFor9ADjCESi3OIMJ9omYcNP+TR5WrQ7Vq
 xi+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=Vnay7kZjXgLdgENXtYqYh8OxwAXYRqO3gl1Mq4e5cEY=;
 fh=ynMZpoLdc8EcguBEfEqlF67vL8jpBgF8ghejmEGS7cY=;
 b=AvSe09+PtbgdWWlbRyu1iStHCax/7oJuKPvjEWxs/lQrSPOmkAhNcIVbQUWsz5esoe
 oqDaJ+qMMlHUAACNfawwaLIyJHRgg8lewg6lRnbsM7odcTG6efn8cfypG3BL3HcBw5A3
 sdfwwc9scvOmPpNHnqNfvSk/IuL1c0ga9RjbLCcyUtieR59I9Y7W59cw+i+Fz+ziZUj5
 rH8yV1gzTdoTKkqQa4/Fl6IJVi+/7xvbJSNgnecXcOWd4EjRftYkXgGmjybhCSpaqRW1
 gVN7yGiwUC8Yx/bWyrGXbRsjGCCpP9NhJCB2Rnzxu+vNF6Sd47touWi0rK2zxMhMjkHz
 9AYQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793080024; x=1793684824; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Vnay7kZjXgLdgENXtYqYh8OxwAXYRqO3gl1Mq4e5cEY=;
 b=A9q27ih8MAyM5E73MxjJGp7NYeNsogFoFyNLQLtSrDsiI+EO2VWLo58tx4nsiIeL1a
 KomGyWLq52ZxxbhDHDNACsWXInpU/3qTeO57HMTaL8fhel8BKmlsS/UwTfpqbOqm66R6
 XbEJFqCBkyyCKZj1vvJPPZWtKHO0ozLJTBT7phicWcgJ1Rr/WUVTVXRCugb0AwntNDqI
 y5PuDrHupRu8Fba1ta0rtWBSMlKPJpBCDvnT3wMHbQk82hEG6X1xBcRe6SxlX5oplEPi
 0+iW2RnGXMHHsBulVeggRFwe8M/YkOrMQxRdeIdMuEx5UF6RZx13rp0GEz/9hLD7+mR0
 ihzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793080024; x=1793684824;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vnay7kZjXgLdgENXtYqYh8OxwAXYRqO3gl1Mq4e5cEY=;
 b=XHAzf+dyle3d61qHG1YhXi8PApTnWlwSaMZQV64eSs69ov+1eZenU8daiYY5/3uGWg
 i6wGsyTn7dxZy/xrdA51woQi+tPSpDMFKhw+OPXcAllBg65Ot3hi+M65ec6BdIlRxBQT
 nNeIS4svjN5SwcARhAHsI0mepQ+8ENec859lFaic0yuZRKubJGR7bqzctWQCD5f8Q3qh
 k8IiFjhjH9PrlM6eR8jl8ruMD1H6PeX4pCxmYseFPBK+k3jVA0UW/nnvxckv9L0DiQqJ
 8IUfcodJIf69+cVGV2QVmvyt3LQi6rJTxWnvXKBZoHZDxE3kDNmugHmbdGatYOmpD54N
 TD2A==
X-Gm-Message-State: AFq9FYL9hFZZDi0f00LtFuZn3ZooBYbTm8XkbPXM4qQB+1G7tpPpf2ZY
 jCYg6yanhmJHsKUecSkn75W3raHgGmAuATUP8NA3ItR6E7TpdKnZJWV8imcI/B5mZ4LFm2Xe7UC
 sMLLym+XJPzgXmTgcV1uKqNM9Ueh9qrE=
X-Gm-Gg: AYBFou1+KEvibWsGfv5GAn6A4zKYlVoHRXS7xdEqZA68CzQ8KxvGwR1UrTKgcVvNLaA
 saR5tGsGzZslIwVuEuR89hATFdPM8BHkWUrAjqnRazUkRgeVrpzCphIhZVbUlqZvB9O/N81cdUy
 OuDdLq6llHgMJJ1ORyCJ7BRzHMGs0TI9rtX9ZvBmoWunUoPVt8ROAMCWyEUYg0lnxaHH/9+7hm3
 Yst0XKe+mKNMICuYRhLzHkyWWNloPg3VNCUvCcYgjR0TiFQmuHUiHMhORIdSFvHjesQUpBEzDpA
 m2JZ4qpvynkBipQzsOGEnARer/5yQhyQ1jZWiUQfKxRKR75ps5S85UzukvQVYv8ci/DWglMnx3s
 4R5RvuJPOyvip9N/Yxsu7c3Gpz9owQ75BuKB/
X-Received: by 2002:a05:6402:3218:b0:6b4:878e:64a3 with SMTP id
 4fb4d7f45d1cf-6b4878e6bd3mr75073a12.45.1793080024240; Mon, 26 Oct 2026
 22:47:04 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
 <20261024173649.7405-19-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE91maBskVqb=3XYgjQSAZ3t2=T51DWg01C0Xbs71oRBzg@mail.gmail.com>
 <088ee63c-3209-42f5-a692-bb631ce8556c@oss.qualcomm.com>
In-Reply-To: <088ee63c-3209-42f5-a692-bb631ce8556c@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 27 Oct 2026 13:46:51 +0800
X-Gm-Features: AclHuK9zRHZwEhEEivY8wQV5p298ZKGQGO1fhyIWCxVcY1PUzE1j9cW1WbwbJG4
Message-ID: <CAE2XoE94D1P7Jjp7qC10PzRhW3Sie0Jau9-1BpmmQf16sYO-DQ@mail.gmail.com>
Subject: Re: [PULL 18/20] target/riscv/kvm: restrict kvm-accel-riscv-cpu to
 riscv targets
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, 
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 25, 2026 at 4:15=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/24/26 1:01 PM, Yonggang Luo wrote:
> > Hi Pierrick
> >
> > Sorry to bother, but this has not Review-By yet, is that reviewed by
> > others offline?
> >
>
> This pattern has been reviewed-by for tcg accel cpu, and I would like to
> move on with this series.
>
> I saw your answer, and mentioned previously I would ignore from now on
> any message with inline patches or external links to branches or
> patches. So that's why I didn't answer.
> If you want to send a change, feel free to post a series with this
> change and discuss it there.

Hi Pierrick
Sorry for the late response, I am working on other things.
I am still learning how to contribute with QEMU community's style, I am hes=
itate
to send new patches because I received too much negative feedback, I
need to learn
how to send them(the patches) so it's easily accepted. I also received
you email about
suggest to me how to send patches properly( I am still studying and
learning on it).
I just learned not to "do external links to branches or patches.", and
the "inline patches"
I have already avoided.

About the " external links", I have seen in other patches, misleading
me that I thought
it's fine to do " external links".

>
> Regards,
> Pierrick



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

