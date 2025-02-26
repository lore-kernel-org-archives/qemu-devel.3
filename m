Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40121C021BF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 13:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnHVr-00082D-RE; Wed, 26 Feb 2025 08:31:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnHVc-0007yQ-CK
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 08:31:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnHVW-00027c-TP
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 08:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740576686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NmYCxxwC5ba6fBkiBrMulR5DeQzReQayOwVm6eQdOTE=;
 b=EHlEo7qqZca/iVOk8fJqbtDgWYoH2gPrh6gsmOwZHpkXA04hKoNvOdlK4JsxoR3IW1YcPR
 9XLk01iu1UhHKXrQ7zKKaX2r+zXumUMidDq5VGV5QbYDq60cDBNNdYMsznIIHJrNcXoJD3
 AQ8OjwPDlGVK1PCTdrWvZuTfM95L7R4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-Wy2qjOYUOrOIo3wHPtY95A-1; Wed, 26 Feb 2025 08:31:21 -0500
X-MC-Unique: Wy2qjOYUOrOIo3wHPtY95A-1
X-Mimecast-MFC-AGG-ID: Wy2qjOYUOrOIo3wHPtY95A_1740576680
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4394b8bd4e1so34513275e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 05:31:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740576680; x=1741181480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NmYCxxwC5ba6fBkiBrMulR5DeQzReQayOwVm6eQdOTE=;
 b=rssOQ2nHBdPM1O0pF8YyIQN1cIWMY6xm86MhLhQbOcUtizKwzSZqVIXtjIiI4PnZ29
 jSKWH12FAxXGx7k0VkNmfmTfhBHru7zswuUyJKq1L9pxv5eOmFT6PGp+86MojJ6R8EzF
 Mml6fcyKCK0q3ldjfqyPHWUVJO0Y3zBHIltdVkYKmVywryDCd9huW8pm5hUD5Kaftl3P
 tLXuZ2aSEuXAcUdvrJGJ8l/pimtrieF0UeM4og9Rp7jLKlW+ZRmjdvAg2uEKSZNnfjsb
 1LdNuVAO01w/GvCmD7a+Cqb87STucEGLxaN1yooYBj7uz21YLF38qp3Ifz/7ur1AAgxS
 +xxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7lGI+T4XKUs/J7DpZczarV/YID9ZTxRmykieV6usfh8t3untPkQDqF0+WiLiA7Zgyf26Bz3MDN3J/@nongnu.org
X-Gm-Message-State: AOJu0YwAsiTD6jNhKyj2DqQerp8bkvq6aoZWjYbt5FykuuW5tZKsyYaS
 YWKPagu0rIIWeg+apSBh0objomFl/SHWjQlCzw7Xk1EQGdSj/4xUq8u6z50rP6myNcRL5W1sSqY
 XeRntjx9T7zcfkhOv+kpq3cKeD01gwQcsR6RoO4PUwrGeTQ+R4xnc
X-Gm-Gg: ASbGncvwfqWSB3t2SC9huRIzoyAda0ec2oy+07QSOjqcCBdDIlRUb0Z1hU+0i1Dvw8F
 3JU31Ba55Bp65bEef1CwxH0/Ma6glpaDSeQyboJ6kNvNYHnpH4Xr1fykNQQlIRQauD644hoWU1S
 pEK7gUE4nWKRc6arguy8k7vgC3ahbrxPhD/YUt5/ye9FtEZGCl5Uy2PEMr3C3hsTHtwOEIU9ART
 ADv7/Gw0NBduy7xS0uiv3xm89z3iJhB+UGaBWwL80MQRm3QTgTS7OZs1kZDprGh1c1tLu48xG69
 Ym+sk45XxN5FXpDaD1Xk9A7hBU02AdOlSmgs5ECGe8y9DJ5QDbutIoDLsdLdvYI=
X-Received: by 2002:a5d:64c4:0:b0:38f:3c01:fb2c with SMTP id
 ffacd0b85a97d-38f7085b1a9mr19171596f8f.48.1740576680134; 
 Wed, 26 Feb 2025 05:31:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvbFVJgQAZBEwO1tMtT0hWybmDr7462JYcdNsuGbzNVLpA3KTWt5J/Abr5gHHV8nTpldGWdQ==
X-Received: by 2002:a5d:64c4:0:b0:38f:3c01:fb2c with SMTP id
 ffacd0b85a97d-38f7085b1a9mr19171507f8f.48.1740576678839; 
 Wed, 26 Feb 2025 05:31:18 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd866ed2sm5656022f8f.16.2025.02.26.05.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 05:31:18 -0800 (PST)
Date: Wed, 26 Feb 2025 14:31:16 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas
 Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH 4/4] tcg:tlb: use tcg_debug_assert() in
 assert_cpu_is_self()
Message-ID: <20250226143116.3d575622@imammedo.users.ipa.redhat.com>
In-Reply-To: <c7c2d873-3ea7-41a5-8842-1ebf33b5a560@linaro.org>
References: <20250225184628.3590671-1-alex.bennee@linaro.org>
 <20250225184628.3590671-5-alex.bennee@linaro.org>
 <c7c2d873-3ea7-41a5-8842-1ebf33b5a560@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, 25 Feb 2025 12:02:02 -0800
Richard Henderson <richard.henderson@linaro.org> wrote:

> On 2/25/25 10:46, Alex Benn=C3=A9e wrote:
> > From: Igor Mammedov <imammedo@redhat.com>
> >=20
> > that will enable assert_cpu_is_self when QEMU is configured with
> >     --enable-debug
> > without need for manual patching DEBUG_TLB_GATE define.
> >=20
> > Need to manually path DEBUG_TLB_GATE define to enable assert,
> > let regression caused by [1] creep in unnoticed.
> >=20
> > 1) 30933c4fb4f3d ("tcg/cputlb: remove other-cpu capability from TLB flu=
shing")
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Message-Id: <20250207162048.1890669-5-imammedo@redhat.com>
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > ---
> >   accel/tcg/cputlb.c | 7 ++-----
> >   1 file changed, 2 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> > index fc16a576f0..65b04b1055 100644
> > --- a/accel/tcg/cputlb.c
> > +++ b/accel/tcg/cputlb.c
> > @@ -73,11 +73,8 @@
> >       } \
> >   } while (0)
> >  =20
> > -#define assert_cpu_is_self(cpu) do {                              \
> > -        if (DEBUG_TLB_GATE) {                                     \
> > -            g_assert(!(cpu)->created || qemu_cpu_is_self(cpu));   \
> > -        }                                                         \
> > -    } while (0)
> > +#define assert_cpu_is_self(cpu)                             \
> > +    tcg_debug_assert(!(cpu)->created || qemu_cpu_is_self(cpu)) =20
>=20
> I think this check is just wrong or incomplete.

the point of the path is to bring out check out of ifdef limbo.
Whether it's correct or not it's up to another patch to fix.


> The intent here is to check that we're not attempting to modify the softm=
mu tlb=20
> asynchronously while a cpu is running.
>=20
> (0) A synchronous flush to the current cpu is (obviously?) ok.
> (1) A flush to a cpu that is not yet created is (or should be) a no-op.

my another patch that was touching the check

"[PATCH v2 06/10] tcg: drop cpu->created check"

is trying to remove (abusing)usage of cpu->created
which should be used only for syncing main loop and
a to be created vcpu thread.
The creation of vcpu is not really complete yet by
this point so it depends on luck (being nop).

End goal from my side is to get rid of users that
use cpu->created as workaround to move from one
incomplete vcpu state to another still incomplete state.

We can drop the check after reset/postload paths are
fixed to schedule async flush.
=20
> Not checked here are any of the other reasons a flush might be ok:
>=20
> (2) The system as a whole is stopped, on the way in from migration/vmload.
> (3) The cpu is offline, on the way in from poweroff/reset.
>=20
> If we decide that {1, 2, 3} are too complicated to check, then perhaps th=
e solution to=20
> queue flushes to the cpu's workqueue is the appropriate solution.  But so=
 far all I see is=20
> that we have an incomplete check, and no ready explanation for why that c=
heck can't be=20
> improved.
>=20
>=20
> r~
>=20


