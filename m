Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DC2D1624A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 11:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0JXW-0002YG-JF; Mon, 14 Oct 2024 07:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0JX3-0002EL-D3
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:46:39 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0JX0-0005WH-NK
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:46:36 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fb501492ccso6765281fa.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 04:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728906393; x=1729511193; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4c2mZtnGfIGb1RGiTOLtPKx0pewl5f1rapee38uwDf0=;
 b=MG46x/pqURx7/xANuz0zCMU2Xb4MAf4slXx1zNbj+CTdSzzdO7g7ASFJRgghDHcw4R
 Cti/TUA9ku0VcWeckD37qA4bmkriDDZ7tA/ckj8YzdNkinaasiz+VYdQv9tDhup0OJwh
 4IFJ1+fsq2vWP67/076DNU6LUs4l8yGEfVG6UK/mc/bstpmGe9G9qPs0oamSHCl13jNv
 lNScNf/Xo7Gz8cO+Ts4kR2te/a3wyROC/uOwgSwx2036yisuyhp87v/JTWmHDpa4k5h0
 39RPzx/EV799ntmL/0WdRTb1Bs841T1O13fq3HVf9yrx3ACDmsRHkUcbZyK21YScvjM3
 xlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728906393; x=1729511193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4c2mZtnGfIGb1RGiTOLtPKx0pewl5f1rapee38uwDf0=;
 b=ctK8LqNRFGeRd/jYf3wVkzCQWB+MIV+azWToAbWnhy5VU5GCDWQJQ6UiWXHlOGq5Sy
 tovunFbMeqxZlFJpOtvc1LPv6zxK6NXsI255bf37jtGWMLRK+BP61hy7wjeqUSmJOgxh
 pZ8UoVFr8erACipNd8TfOh5e1v9XxRHb1WKvLiT6SG+gNlyqbP/KKGEGxI+AtaDAnV/D
 bjtiUmcOz5myULGwW6fLFAF00h7LQhMUWZz0wcd5AzDi4CIUS3Vy0alJeX9kNnouyYNx
 0TCNItB/g4yDjVHMyrwLyIXiwGVldAk7NmlgE2HCCIRJ5NnXpvR9UNmNtyh91MUtlgnD
 ATag==
X-Gm-Message-State: AOJu0YwKV9VAV9deS43mfweJWP39ngSAwUdIIaxnX8ld7OdtVGTUqpQ3
 MTV8XLDzAZMjgU94Bbfqg1jFRkA2BVckn/MtjuFar3GNcbNMAoOrYf4ssRlKRZdE402W+wHiHpF
 2kc61mnX2RX8gAOtQm+MicGPNLhc8WQ==
X-Google-Smtp-Source: AGHT+IG9zdXrsonsSInaCRAQ6E0BR9WF7AQIQ9enm+QZ0gpS3o+4Qju4qlqhGG7K1nUaUiIrELvcLro62oj9fetjCNc=
X-Received: by 2002:a2e:be27:0:b0:2fb:4b40:1e1c with SMTP id
 38308e7fff4ca-2fb4b4021e8mr15581631fa.36.1728906392528; Mon, 14 Oct 2024
 04:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20241010092619.323489-1-r.peniaev@gmail.com>
 <CAJ+F1CL8VPo64DVty94FY4KyKr1h8_dbmrqLfy06VuMzoNyYYA@mail.gmail.com>
In-Reply-To: <CAJ+F1CL8VPo64DVty94FY4KyKr1h8_dbmrqLfy06VuMzoNyYYA@mail.gmail.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Mon, 14 Oct 2024 13:44:26 +0200
Message-ID: <CACZ9PQW8QUvg9oDMy9iMx05++Pn9e+XNthtG5HtaSURWXpwJHA@mail.gmail.com>
Subject: Re: [PATCH 1/1] chardev/char: fix qemu_chr_is_busy() check
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=r.peniaev@gmail.com; helo=mail-lj1-x22a.google.com
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

Hi Marc-Andr=C3=A9,

On Thu, Oct 10, 2024 at 12:20=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi Roman
>
> On Thu, Oct 10, 2024 at 1:28=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.co=
m> wrote:
>>
>> `mux_cnt` struct member never goes negative or decrements,
>> so mux chardev can be !busy only when there are no
>> frontends attached. This patch fixes the always-true
>> check.
>>
>> Fixes: a4afa548fc6d ("char: move front end handlers in CharBackend")
>> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
>> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
>> Cc: qemu-devel@nongnu.org
>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> That would be worth some new tests for chardev removal. It seems to be la=
cking. And mux probably need extra fixing. I can take a look if you don't.

I've just sent an attempt to fix the removal of frontends, plus some test c=
ases.
Please take a look.

Thanks.

--
Roman

