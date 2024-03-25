Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DD4C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 14:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rokv1-00082h-Px; Mon, 25 Mar 2024 10:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rokuy-00080m-Bs
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:03:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rokuu-00042e-GW
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711375390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NzEwJ/TLdtIK1z7siIJpay+naJntjoNugRHXM5d2wE4=;
 b=c4mpfQkZUUQcA72grhbwifupPBtHCzJ2dm08h97/Gapfd8M3+uzRPN3e/Gu9UytHMxqucL
 vTMY8JlNZd1+lNm9GL3tcJgnaEnIashaaBDvuqv3Zad45vi3bBG3gxzDDnFFxI1GBUj8O5
 pwLIeTRVLRI2YmIrEed8hWKlo2X+WZQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-iyR2UykZN4e9KnNVfl-E3Q-1; Mon, 25 Mar 2024 10:03:05 -0400
X-MC-Unique: iyR2UykZN4e9KnNVfl-E3Q-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33ec06aac83so2841431f8f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 07:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711375384; x=1711980184;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NzEwJ/TLdtIK1z7siIJpay+naJntjoNugRHXM5d2wE4=;
 b=JCqX5wqr0mDZVF/N9uBmXHvghUK4Bb7BsJP6Se9niR4O2HMVq25LHYU4Ko1JrjN0gJ
 bvqdKA4vlq1drFAMbAiPRkH53OCPVZRKfKQYxFbeCC2ICDNIpi96Lby4K6KHWLvams76
 oAdKRz+mmw68SKLeap3yyt39ndv+C1j+DzYHfl8dNekb9bh5rMRzWjCwwyGbg4sqJrF9
 EdOLGjr1iG8PLB0D7VB60T45UbV51y4DIR/BitI0ROReW2HoaZgXva+PRl3ie9oI2Fr5
 G2FElvwmXwObkeg4W65JbCgXy41ZhQHvcdi3nXMlhGTnkPyfz5nQGbpLjPRQFzVaqre8
 ZyzQ==
X-Gm-Message-State: AOJu0YwhfwU6+Ec8LLPTXskBVEArSKAAmsLBgSEE+Ou12zg7sug05XCh
 zoLRsMLiRUUAHXcXQUgCML8lBkexiqd/Ld+FZwia+LKOdb/yksdq5ivJf9Da0RyTrS0izxt0vEq
 oXiaKdSnXZjhU+LIZxNsrnbst23iXJi4Egg/Y+D5gY0xcV0xDG2aWhrQ9HsUTJbxAOrdNUaMv7g
 on4nEBchuNm0ppij/uYTnjphrJHxw=
X-Received: by 2002:adf:f64c:0:b0:33e:9f81:4a3f with SMTP id
 x12-20020adff64c000000b0033e9f814a3fmr5510799wrp.0.1711375383869; 
 Mon, 25 Mar 2024 07:03:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ8ET+jsAIyMhmkq6UmhP4g12c8I/UXdGSAV/gFzmknovLQl1N2ed4YjP2R7NAT89gpiO2p2MJeGwNcpBeeWI=
X-Received: by 2002:adf:f64c:0:b0:33e:9f81:4a3f with SMTP id
 x12-20020adff64c000000b0033e9f814a3fmr5510787wrp.0.1711375383577; Mon, 25 Mar
 2024 07:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240325135906.1372946-1-pbonzini@redhat.com>
 <CAFEAcA9jZQ9UB1Fpi-rMjra1Z63HKa9V=Et0X0UpgJy9Or2YuA@mail.gmail.com>
In-Reply-To: <CAFEAcA9jZQ9UB1Fpi-rMjra1Z63HKa9V=Et0X0UpgJy9Or2YuA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 25 Mar 2024 15:02:50 +0100
Message-ID: <CABgObfY8UC0p=d04z7wT_C928b7pwDYaor6+WpHm10PhDqAiqQ@mail.gmail.com>
Subject: Re: [PATCH] pc_q35: remove unnecessary m->alias assignment
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, cohuck@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Mar 25, 2024 at 3:02=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Mon, 25 Mar 2024 at 13:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > The assignment is already inherited from pc-q35-8.2. -s
>
> Missing signed-off-by and a stray "-s" in the commit message :-)

You can probably guess that the two are related. :)

Paolo


