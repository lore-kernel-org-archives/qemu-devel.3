Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33F0C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 10:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ6fz-0006lN-0j; Wed, 31 Jul 2024 06:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sZ6fu-0006a6-V6
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 06:35:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sZ6ft-0007UA-FV
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 06:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722422115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cdzPwaiNwHNCDBJE8ngGr2ArAngzavLEonuUm5mNPNI=;
 b=NTqUdn9Y2T5aXshu4MVbwag1ghQ9UJus8ieDkMsERcaSgc7ToytfsXTre1pWZgGzvTGX/O
 poQtOqeNdYU2rxONQCOvC0y7z3OhkOpXOb15i3XA1Ix8ZmvhaU2J+6cJovMXFP66U0PGCW
 Sw85chGxSd5R5YuEn6hgAbQAWJLXwiI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-eDzOGhyxPzGWNCA-UpOMGQ-1; Wed, 31 Jul 2024 06:35:14 -0400
X-MC-Unique: eDzOGhyxPzGWNCA-UpOMGQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ef3133ca88so54233031fa.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 03:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722422113; x=1723026913;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cdzPwaiNwHNCDBJE8ngGr2ArAngzavLEonuUm5mNPNI=;
 b=GAFMkmqGCCOsXY7TKM/TNsVeOUy45Ze645z9IWiMWVmH93QvOT7oS801ngejzKyydn
 HwPknhQlLX4gw5Ffz/+GtcoLDrB90Iyc0cwBe9PEI67S76dRUhczqC1LfO4/lpoyGyIv
 xXzjDhFYdsS8BILSwzXQPW+nAbGihFC8+1/CcUWsHtm3qYtYP1r0gAc4B/bhTAvhhyEE
 E+yj4AIFYyzxnc8N4x9VIVyDXlHnI1Ds36//H5gGmklgKmEyUKPsgAuLqHeaMOvipmhO
 k1uhSc1wkNcdtcuBml9ESrgwwyJfFSm6nn/qlCSCg2cy9OnM9TQw67rkPBmsi2A1kD/z
 z1Cw==
X-Gm-Message-State: AOJu0YyF9pzfzmy3TkCz6L/scRNBNaRi78lWAzHrESNHft0rPgZytddu
 NO4zQ9uTpc2VQNrefWSnq5jgprIwmq7MliuaKpveeQrIT7hzGM+lg+2/llMpRsjv9XFjn3sOGzp
 zGrI1y1Ib97QXLdVpm3RAxYplLLYxpxx9CamdOJl++fC4kHK+gSDQVUXRQoVhAfG4jNV4d7+80S
 o71DHUjLp+o02m0acI+RxirdvDF3w=
X-Received: by 2002:a2e:9091:0:b0:2ef:29b7:18a7 with SMTP id
 38308e7fff4ca-2f12ee5bc21mr89404911fa.37.1722422112877; 
 Wed, 31 Jul 2024 03:35:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwGbBGRUSuay0gVFdWktVdTRl0e3l55oSGi/yRntHaLJzCnQvHNqVvFBHyikt3Y9yPzAKxcKgI38hGJpx85S8=
X-Received: by 2002:a2e:9091:0:b0:2ef:29b7:18a7 with SMTP id
 38308e7fff4ca-2f12ee5bc21mr89404671fa.37.1722422112547; Wed, 31 Jul 2024
 03:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
 <bc27a983-f0b7-4803-96f7-060a4a331348@redhat.com>
 <h4gxy.dr366knvycy@linaro.org>
 <CABgObfZOqBogWQtzfghjKMsW-J_sp-iL5dt7mmYnvE5eQb9G5w@mail.gmail.com>
 <h61ku.ipxyjqsxu75@linaro.org>
 <CABgObfa-dxDD_oVGu8PrQffVhvP=MFifUUTinC-brzTnqdkK0A@mail.gmail.com>
 <h6cgm.o8scn84hx1ry@linaro.org>
 <CABgObfbyw0qPM_T=SpGyHYD02x2jOdSy5nfwKpOx-WruhkJe9Q@mail.gmail.com>
 <CAAjaMXY3jL=cVs=e+6kiJw_WrfG5vOaqaNFu74BdoK2-bO7ZLQ@mail.gmail.com>
 <CABgObfb27wbwgErFsMdsuSo1BxQVBoRfbrUmK2k-x5Ya3ez0TA@mail.gmail.com>
 <h7zb4.aog50x8tfxkp@linaro.org>
 <CABgObfbJjcwXcJ-=c7yfXQX=xLnqqVsvDqibrFgiLPm4C_uC6Q@mail.gmail.com>
 <CAAjaMXatq0jGrght=Fc-7TpZvuGzirhWyKsAsCRq1BW_U_CW=g@mail.gmail.com>
 <hhfb9.99e4vl1r79fa@linaro.org>
In-Reply-To: <hhfb9.99e4vl1r79fa@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 31 Jul 2024 12:35:01 +0200
Message-ID: <CABgObfYWykrXt1Do_NtUb6nirhAALva1n5jpmS8w6NrGJ1h=Ww@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/8] Add Rust support, implement ARM PL011
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Wed, Jul 31, 2024 at 11:50=E2=80=AFAM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> On Fri, 26 Jul 2024 12:26, Manos Pitsidianakis <manos.pitsidianakis@linar=
o.org> wrote:
> >On Fri, 26 Jul 2024 at 11:19, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >> As I said, I don't see the point in discussing this more, and I'm not
> >> going to unless you provide a clear pointer to documentation that
> >> states the opposite.
> >
> >Same here.
>
> Next patch series version is taking more time than I expected because of
> unrelated issues, plus I'm on PTO these days, so I am posting the
> resolution (which I hope satisfies everyone) here early:

I would be okay with just a TODO comment (I think we all agree that
the issue is theoretical), but this one's okay too if you prefer.

Paolo


