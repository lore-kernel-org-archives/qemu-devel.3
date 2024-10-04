Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1524CFA774
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 12:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swhKe-0000I6-5X; Fri, 04 Oct 2024 08:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swhKY-0000GW-Mt
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 08:22:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swhKT-0001PR-S1
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 08:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728044559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Zxb368gKxy8SQkaFZ/CLr5LcRz9BDCWm++n8wri5D4=;
 b=SVQTRJzAcrbzM1cTI1N2u5j42+MPlxJfi84+Im2urthMjugXFBeGnK4aEbh47g1gx8IRU4
 3MedTTbWxd/V0DBq1bmmMqQTIHHACW8VbeI2+6xip0y0Kf9ubCsxXoHoytJFZsI1fYtTar
 mQAJy1o2cmtpsMEecuTQt24Wz+A4nsI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-p0_J-sd3M06-ZLnsbf7KGw-1; Fri, 04 Oct 2024 08:22:35 -0400
X-MC-Unique: p0_J-sd3M06-ZLnsbf7KGw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37ccc96d3e6so857693f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 05:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728044555; x=1728649355;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Zxb368gKxy8SQkaFZ/CLr5LcRz9BDCWm++n8wri5D4=;
 b=o1ON4L+F3bEcMQD+CsMLUiJqWrcqhR14VmqqJmY99pIHD9aDUq//H/EQJgsMHp2WSR
 KO4IgQAMoDYD0TWivPOxR7s2v/l/wYpsIkp0X0KVqs8T7PmNFB7idY9mkbwj479yU9Wx
 2xBwtRJ7cUqQ1D1lfD4GaMynUMCdyKfDYrO1n38iZ6HNHeN+F1yUD7qdvRJ6k+++yH0H
 Lbpxz4Na6hyk3gS9ci+Z1yeDzaJL/Zmv0vDffERxu0CjCB1vNiwv2uQuis8Bnbgxstn3
 43b+SeY3B2mi9GI5/SNkk0m6qhL8WFU0k7D6peZXFcmUxP5apFr0MclHR8qSn4n5lsCT
 IrtA==
X-Gm-Message-State: AOJu0Yznsnperw/mfC+E9miotqJ2YfJkVc/4CsP/0J5aIy+ujT4Da9MK
 dsBHtOoaQ6L8tXUaKqY5Y4tRlpVGtA+Um2e6I1kTj6NmXE6tlQoWj2D/4wvO7Jfb472abh239J6
 PBVU8DU+f7cOHHsezMSHdRB62Hb1hr79dUV+R1D9Ewa8Vwf2fYl2eDFSFrUdKp80LRefJ4WAxUi
 oal6onPrMg/gptaYKBUUpHTvQimNg=
X-Received: by 2002:a5d:5915:0:b0:37c:d1bc:2666 with SMTP id
 ffacd0b85a97d-37d0e6f2254mr1583362f8f.4.1728044554626; 
 Fri, 04 Oct 2024 05:22:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ52eJ+HsW/Q89opxjj/WsqSfgz76nbedrEoOkjLdRwR2a+mnNZqXybGPADXJ5HuxTRzhO/tcTSZyXIu85/cA=
X-Received: by 2002:a5d:5915:0:b0:37c:d1bc:2666 with SMTP id
 ffacd0b85a97d-37d0e6f2254mr1583336f8f.4.1728044554261; Fri, 04 Oct 2024
 05:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727961605.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <cover.1727961605.git.manos.pitsidianakis@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 4 Oct 2024 14:22:21 +0200
Message-ID: <CABgObfZ7bHgejGdDRyqze1eV66ugt2_CK80MW7ir_A8_9ULo5A@mail.gmail.com>
Subject: Re: [PATCH v11 0/9] Add Rust build support, ARM PL011 device impl
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, Hanna Reitz <hreitz@redhat.com>, 
 Junjie Mao <junjie.mao@hotmail.com>, Junjie Mao <junjie.mao@intel.com>, 
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 berrange@redhat.com, hi@alyssa.is
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.146,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Oct 3, 2024 at 3:29=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> WARNING: This series contains a patch with blob diffs (update of python
> wheels) and thus problems may arise with your patch workflow. The
> revision is available at
> https://gitlab.com/epilys/qemu/-/tree/20240814-rust-pl011-v7-v11 for you
> to fetch. HEAD is 6ec1d4fb8db2a1d7ba94c73e65d9770371b7857d
>
> Hello everyone,
>
> This series adds:
>
> - build system support for the Rust compiler
> - a small Rust library, qemu-api, which includes bindings to QEMU's C
>   interface generated with bindgen, and qemu-api-macros, a procedural
>   macro library.
> - a proof of concept ARM PL011 device implementation in Rust, chosen for
>   its low complexity. The device is used in the arm virt machine if qemu
>   is compiled with rust enabled (./configure --enable-rust [...])

Thanks, I think this is good for committing. There are certainly a lot
of things that are still a bit rough, but they can be handled
separately. In particular the priorities for the build system should
be:

- lowering the minimum supported Rust version

- completing support for CI and for clippy

- possibly, figuring out the magic that Linux uses to run doctests,
and port it to meson (ideally upstream meson would do that and also
support "cargo doc", but a QEMU-specific implementation would do)

As to PL011State, some mostly independent steps could be:

- improve initialization to avoid use of raw pointers. Two different
ways could be simply to use MaybeUninit<>, or something more complex
like the Linux pinned_init crate

- write bindings to the Chardev API (probably requires basic support
for QOM methods first, for which
https://lore.kernel.org/r/all/20240701145853.1394967-1-pbonzini@redhat.com/
has some mostly-developed ideas)

- generalize the extern "C" "thunks" that invoke idiomatic-Rust
implementations via a reusable trait, in particular:
  - figuring out the design for the callback design pattern (see for
example https://lpc.events/event/18/contributions/1786/attachments/1431/322=
6/hrtimer%20Rust%20Abstractions.pdf),
i.e.
  - make functions like pl011_realize or pl011_reset generic, so that
other devices can reuse them

- expand #[derive(Object)] into a more complete design that allows
overriding QOM methods, for example taking care of defining the
class_init methods

I was also wondering if an useful exercise could be to place a level
of maturity for each of the files, for example:

A: ready for production use, API supports the full functionality available =
in C
B: ready for production use, API should be safe (when possible) and stable
C: proof of concept for safe and/or idiomatic Rust code
D: still essentially C code

Paolo


