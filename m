Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B2FC88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 10:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x640d-0003Zb-VT; Mon, 14 Sep 2026 06:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x640d-0003ZS-48
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 06:33:59 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x640a-0006Wn-EH
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 06:33:58 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cc4902427c1so2457239a12.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 03:33:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789382034; cv=none;
 d=google.com; s=arc-20260327;
 b=EJOMJdo5V6CcQY3KgI2U/r7xhRkRtUiLuIMe25HqGHs5+PvIjsFAM+P7zE5HYXKDxD
 6/+DPsVU8QTfDMMvW1YlB4UXPXEyc9L25AccW2xXCW0IzNPyJOW6WUgurDjgLQv1GhnY
 HD6WvDhAa0uqUdDJjJrGGdSyqKNn3wbgpKHRiiUygjpFG7xb4QRbWtbLxaFKBooXkzfl
 jzT/W9GEXsU+SM4lbX3/2T5pOaVPVX8PcA/yZ+LTGhD5iRgVH32B5lkeQzRjpWDHyjb3
 ZkqXusBOkRIo8bnb455naSRY12YzQd5bqzvAJz+FBruh8iErApnGDWxkJehLaNjkgiLs
 f0sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fKZYynrUhy0dgSF+lvRzbu13yyaWu88X0TePtwfk+P8=;
 fh=vSFUzau90SrBg6o+Wv/r7agx+uwJOvigf5OzwEU3xPU=;
 b=JrDulGnGNyBcT/c3BgVfRmiyoOblShTB7L6z+U6Q5cfW6er1Vch+vdvJDXxogN+2og
 2yciJs6rbDHFz7jWuIahqndosbQTSI2ST5GHCQqZDGaRquHHsNsKA2ECyxJgMNRA10/l
 Szr8y6/URds6+QehrFkGVzp1MLlUt96gbkgNrQ8fCP4hU6SmmfqY3BJqRr5S98dWCURX
 Cw+qUCpvaEQHVNtSHzeq3CSzH40tCSLHhBGExXr7cLD6e8iSnOPtDzwT9Jt4H62zjcrg
 U3FpFhTShyKcURW5HL2EhYmFS4Yqv1eTpBv1ZKug3EMJMn6z/s6XnJFSj+B7XAl11VU2
 LHFQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789382034; x=1789986834; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fKZYynrUhy0dgSF+lvRzbu13yyaWu88X0TePtwfk+P8=;
 b=FZVs6wHa/UlTJde5uN5HErHTvk/wEO8TfoTmcWfqPXAovzwG7yDqbatQzFlBEniSOr
 YzIvE+Ac1s9AACi8E4wAJ5DgFhCOj9GQABP0tuqW7/FFiqUTY3+XGt9hYKEde/5ZFQiX
 UYIuDTKZt+q3ysktF81Bs07x7IR/objFrl0mS+XL53cdplNzF0J7SKLj4bsB+qPj57d3
 P7PKgT3fLnJWB9+Jb22L2ZUhAaNZ0QZkhDIq4R3mp9IsJRfMqYWZvz9Px4gGZmvDfGGi
 sm6yl4XRJDQOEp7ySNSn2zWOWxoeR3EBPFnCzbY3WJoa54IVE9mTqR/IfsC85bTCdpPI
 pWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789382034; x=1789986834;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fKZYynrUhy0dgSF+lvRzbu13yyaWu88X0TePtwfk+P8=;
 b=DsNmAZHdPdPZDdzmC6UycgnRpx32gFIL2RYpWTx53rFh9clcD/yM4nIrPDTK2bh8f4
 8VJBqNf0C3PRfw98i5/7SJkNGo9DiI4ttku99wIbkrSl6cFVJaSNC0mZ7RtJnqPAAneU
 CfBym8W0qQWukhxC294M4H05bBO/r7z7UGYM4RxClpeRnzdwvxl584AUm5Rdx2VOzL0A
 P/wWADzaGedTCUHzdC8gsBCDMuiAHd+ztDiNUxKgXtPlbF0fvpTpGuLXxJoyghHOkdqr
 uccETyMqoNBSAPZ4BUg3bomcG502ee5J1nQCUmxxS2rAVkAyOt9mt6VKTX+J+XlyfSy4
 gpQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxqB7DXQpKC1GAPCVg1hw68ZGfhrqWBt8KfjC08eQDpAwKScVmH0n7b2ksI3qQDp4I/B14o2skwsO2Z@nongnu.org
X-Gm-Message-State: AFuF++mO0SO3O8liZ90Dwhm7GCwulWzWKC5SMqT4F4ZqAfYyvpS8tdD5
 8QbPi6fwPnoYRuNY69awPkLdqOVNQFF33RdRa/csDCn4kNnNQahLKRtiPvNsF1ubgTGijgUjXed
 X1ed/W2dzJCUjwBfs9772bYSEcRPhvHk=
X-Gm-Gg: AYBFou0MLpStDVsL6cLrwBwhlh5MYBB+e4oIfvK8p7rcBe2ioRCzGdI7U+BC6W3+Ec8
 c10oMSpl6ztyVNQVhj9tHBBEYbxmTN53oI/AMlfz9KjuejMlUc4XfgwGeba9oLuIgfRNhq5wYbx
 UJbSTQgSdOC94jMNNcn+vxj6NygRTDcdUl5a0cXP8i69IwwhubUvrjXgcpbiHblHofMlo58wry3
 Xw2OS984ahm/ODeOvzRQI50/WPdPO3rzAJEhSEtqHGymVNS6NQayRxtLzANJNTbo/CruwgGSUBd
 FWIkQ4neEcR0KX9EgWqel07lVgdJRMlqO04ENVqZiFzIvD7qL7MiavbJXzUAB9oPJaI7eHt01h/
 gxn1l6npj0yw=
X-Received: by 2002:a05:6a20:7d9d:b0:3da:e57d:4a79 with SMTP id
 adf61e73a8af0-3db26e46995mr7604754637.13.1789382034275; Mon, 14 Sep 2026
 03:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260913-bcm2835-v1-1-b3719ca0df13@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA9aJJc_yRNYbATjA8d4ggZr_B=r5EmVNma1rzhi_ZrWLw@mail.gmail.com>
In-Reply-To: <CAFEAcA9aJJc_yRNYbATjA8d4ggZr_B=r5EmVNma1rzhi_ZrWLw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 14 Sep 2026 14:33:42 +0400
X-Gm-Features: AcwNN1UoirxbKnK8eipRShsMfteuzohLlAaCu0Q71lV1vxDpC1UWalpFJy5vTZU
Message-ID: <CAJ+F1CK3eC-t-uBDuCSd2VG=-hx9v+ev8cRf5_xh9oC=04O3Og@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/bcm2835_powermgt: Free the watchdog timer
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x534.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi

On Mon, Sep 14, 2026 at 1:32=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Sun, 13 Sept 2026 at 07:44, Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >
> > It leaks with introspection.
> >
> > Fixes: 21fcfb604608 ("hw/misc/bcm2835_powermgt: implement a real watchd=
og timer")
> > Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > ---
> >  hw/misc/bcm2835_powermgt.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
>
> Hi; Thomas Huth sent the same patch a few days earlier:
> https://patchew.org/QEMU/20260910175001.76278-1-thuth@redhat.com/
> so I'm going to take that version.

And earlier!
https://patchew.org/QEMU/20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com/2=
0260906-nohmp-next-v1-3-2b21e63974f3@redhat.com/

thanks

>
> thanks
> -- PMM
>


--=20
Marc-Andr=C3=A9 Lureau

