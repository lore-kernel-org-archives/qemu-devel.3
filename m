Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6991C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIvk-0002rT-JL; Wed, 28 Feb 2024 07:21:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfIvj-0002r6-2Y
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:20:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfIvh-0003G3-Dd
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:20:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709122856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RdqPNhH1TnLEU64MPLqdasWP5r888PJhqms85ItiB9A=;
 b=TynfnKAxVbvXoRGHLEryFvEGZQzatEJfBafo+ALmyO83IgRV+SuGUOljm2F2YeSR5itB+N
 0fLKyI2EORd6dotj4JMoas3+MxLoEFFUaS7N+oXJUUxO3TN5CQ2CnC5HyWhlUEVjcYbs9e
 en3cvDlnOq9WigtpDQ9M0VGSpkj9gMg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-xL53c30ZPTmilBSMj4v3hw-1; Wed, 28 Feb 2024 07:20:55 -0500
X-MC-Unique: xL53c30ZPTmilBSMj4v3hw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-512e58cf80eso3870282e87.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 04:20:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709122853; x=1709727653;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RdqPNhH1TnLEU64MPLqdasWP5r888PJhqms85ItiB9A=;
 b=pZf3BR8+g5KKXPsMdS+DVhKkFoqeBtWyWghnQbHx9Cw9tW3pDQRqcSTGdxBeUiZCHD
 HUbMws2uUQsmEWAHy0KhNZYHNPl/CogkIAs2+Pnu18A2e3m3WiVWME66LXS+2mudTAB6
 EPKcDjpDMKnLirttU6caoDAqG0+6HCB9cKlG/hvQAxC5u+XWWQKNkVAOjo1k8g2mCPa2
 W6F/+BDk88O9hM94+6WWTsPWoCu+Z76KuBsyLF8WNJgJ3vxZJHv7b+vaCbA2DtunuX9A
 1ZPafmiQZEijK40VFYaUznBhQciZEV0jsORcsqxfZszU4hUTGuFtFazKPWUUK8P2snbO
 ZNqQ==
X-Gm-Message-State: AOJu0Ywh69sLN7cQ7gzFJyO+0ke8A/1rD2E6S0g0eDgFMpF1SewdTR/m
 540PgvRz41m8p24mEjdOl9Lbl6gQAdqRFYBrg5Urcjs5R1b92RxIlED6WgkIrnK4ADK4XLrcPdh
 VHYI/KXSSKRiV/dXD862R7ffOFMFTeZRKD/S1WKtOproMRG3se/Hox/5jdAzilw7LNlbmzWj0f+
 HTgblR1Wrpdr8ocQm/tLKlqfkn0oD3idpVNRI=
X-Received: by 2002:ac2:4833:0:b0:512:ccd2:5cb0 with SMTP id
 19-20020ac24833000000b00512ccd25cb0mr8205043lft.29.1709122852875; 
 Wed, 28 Feb 2024 04:20:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFv3qqOmGrKGarQcd08RU8p9NAAZVUSKjdh1LsP3LjxKrtCqKZTJG4Dmxmv+oJqVitvKKYTsrmAHlC2Dbizq+o=
X-Received: by 2002:ac2:4833:0:b0:512:ccd2:5cb0 with SMTP id
 19-20020ac24833000000b00512ccd25cb0mr8205030lft.29.1709122852496; Wed, 28 Feb
 2024 04:20:52 -0800 (PST)
MIME-Version: 1.0
References: <20240228110641.287205-1-pbonzini@redhat.com>
 <1f179ee4-cab6-49c8-a625-2ac9dbe4e3d2@linaro.org>
In-Reply-To: <1f179ee4-cab6-49c8-a625-2ac9dbe4e3d2@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 28 Feb 2024 13:20:40 +0100
Message-ID: <CABgObfaZPp_wAE4u70+_ShmtFpEf69RjyRyqZEQ8TjDkue_Q-g@mail.gmail.com>
Subject: Re: [PATCH] tcg/optimize: fix uninitialized variable
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Feb 28, 2024 at 12:19=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 28/2/24 12:06, Paolo Bonzini wrote:
> > The variables uext_opc and sext_opc are used without initialization if
> > TCG_TARGET_extract_i{32,64}_valid returns false.  The result, depending
> > on the compiler, might be the generation of extract and sextract opcode=
s
>
> Shouldn't compilers bark?

I expected that too...

Paolo

> > with invalid offset and count, or just random data in the TCG opcode
> > stream.
> >
> > Fixes: ceb9ee06b71 ("tcg/optimize: Handle TCG_COND_TST{EQ,NE}", 2024-02=
-03)
> > Cc: Richard Henderson <pbonzini@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   tcg/optimize.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>


