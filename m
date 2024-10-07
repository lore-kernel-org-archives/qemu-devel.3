Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D60CFB441
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 14:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxp2P-0008QL-Od; Mon, 07 Oct 2024 10:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxp2N-0008Pc-Qe
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 10:48:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxp2M-00049N-Gt
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 10:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728312515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JigYAc32zxmqoN/1OsqvHHP0IjrVY4uAdTMxLn2WQW4=;
 b=FriKrA5Nrg1GKNV8WhSq+NylLCYK/HtEMmzbs2b98o4PrlFlehOjXcTALOZjkWORatbE2W
 WUC6aP+li/z3OuCqowD2EVgN+R6RModOIMKnKSwTdmFR/gmXH1oCQlLOKmlPBuWWLtkZHq
 dbZsjCbX0WEDoBZZhAbwQpRiFBMbTgs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-6i0PSJAMMV2eLFHpnv-gJA-1; Mon, 07 Oct 2024 10:48:34 -0400
X-MC-Unique: 6i0PSJAMMV2eLFHpnv-gJA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37cc9b5e533so1924388f8f.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 07:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728312513; x=1728917313;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JigYAc32zxmqoN/1OsqvHHP0IjrVY4uAdTMxLn2WQW4=;
 b=KTltRciVsTPwQXtsrf1JKlBhQbu41VRXmP2KCT/mcQ0kU730flneKaOCKakdQdaoYb
 Xk68zaAW99XVJedh20v7UBW8Fa/l1Ci1v/9U5Gg40rgOYOnSSiYJkUdMKHhAjYVYKiF3
 ztwFYSUhG+km4Yrvw786l3jCenKlRnw04obPK+c+dhn7IL6TY2ZfkvB+aSqo+gg2jj1r
 bHmvVB3u2LzKSzhr6SuxT4yBoCvhalJ2HnDpzFZyVaMWs0vfkrhhPZYR7alhbwxQLqbk
 FKUFXta7zvEr1hSKuJCKy3Dx68RhyaSGghNM3uLKNI8JLVI3S9nZdOplkN+eXWLMMcki
 7GHw==
X-Gm-Message-State: AOJu0YyvPuuW+JCBFHuaUJ4+NB0JMCYspENRQwE7wnsiw7PSjFaBd0PI
 JCCXg1APmOpYqaaXMpoX5u1hTQwttaLfxcn/s6gB67qlxI5jX6WuvRWj0n8Fr+eGuYs8f/y/fv+
 EdJ8eL16zFMRINW8U6AkL32c69H0dlyshL1QvHY3XCl8MI7MJfMUvrLjbp2Ky90xpNiKgK/Wv95
 KxJq3qnklFdL3+678znnl1zSm/z9s=
X-Received: by 2002:a5d:64a3:0:b0:37c:fde2:93b6 with SMTP id
 ffacd0b85a97d-37d0e6da837mr7444728f8f.11.1728312513610; 
 Mon, 07 Oct 2024 07:48:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAfqhHKMTWxCITccZoxmG3MkJ1T+bnVm7qr77TWbraiDzAY0N3xORlugT1WudQDHrZi6Z67yHFPn+7pTJo1Hs=
X-Received: by 2002:a5d:64a3:0:b0:37c:fde2:93b6 with SMTP id
 ffacd0b85a97d-37d0e6da837mr7444712f8f.11.1728312513198; Mon, 07 Oct 2024
 07:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20241007084342.1264048-1-pbonzini@redhat.com>
 <20241007084342.1264048-2-pbonzini@redhat.com>
 <86423148-2cbb-4263-a351-dac0ece198e7@linaro.org>
In-Reply-To: <86423148-2cbb-4263-a351-dac0ece198e7@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 7 Oct 2024 16:48:21 +0200
Message-ID: <CABgObfYu2jqKMJ_xrNv1Ci5B2NSxrcaaUO2piu=3o=Ca=Sn_tQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] meson: define qemu_isa_flags
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, qemu-stable@nongnu.org,
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Oct 7, 2024 at 4:46=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
> > -  qemu_common_flags =3D ['-march=3Di486'] + qemu_common_flags
> > +  qemu_isa_flags =3D ['-march=3Di486']
>
> Use +=3D ?

Here the qemu_isa_flags are known to be empty.

> > -      qemu_common_flags =3D ['-mcx16'] + qemu_common_flags
> > +      qemu_isa_flags =3D ['-mcx16'] + qemu_isa_flags
>
> Likewise, why verbosely prepend, rather than append with +=3D ?
> The same for all others, including
>
> > +qemu_common_flags =3D qemu_isa_flags + qemu_common_flags

The prepending behavior came from CPU_CFLAGS originally being before
all other compiler flags.

I just didn't want to change behavior here (especially since this
patch was already about subtle changes in behavior). But you're right
that at least within qemu_isa_flags the order should not matter.

Paolo


