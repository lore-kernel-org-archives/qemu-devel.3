Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5122EC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 13:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc3LV-00072g-Cw; Mon, 19 Feb 2024 08:06:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rc3LT-00071i-6t
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 08:06:07 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rc3LQ-0002oQ-8B
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 08:06:06 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-563c2b2bddbso5724397a12.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 05:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708347961; x=1708952761; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lvJENqQxJwJ0qoNic8x/19fJ5CctFxYM4poH/XDfkd0=;
 b=TT/ezoSxEbqmEw3DvFywOVuJliLVRoFmOUqqa5ehvNa6YU4lr0LQkej1vDOn3YLYnY
 GVjZ7COqQfMsPj2MaxVG9LFs/ulmgB9vM4q5nnSjFRhv9pTZVIWIVb6coYcahps7P1KY
 edUTNbToQgdUeFFAMXMxhGS9+OkgAOXsGAak8CD/wkqQf6JB5NfnEHaoTknG3yaogg46
 LQWlFCA8OG4PPvzRvJhI4iIxI4vizTS3QRHuqFs+m2x1kMOLyJFZIUC8lSY3n6MzER6M
 vilCC9URhyvbdf3gNNLnAeHbr2wCWapCEwYOMafxCdQR7HNqNFDd1WQ4cTNu+qW+dKNT
 wujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708347961; x=1708952761;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lvJENqQxJwJ0qoNic8x/19fJ5CctFxYM4poH/XDfkd0=;
 b=vI1JCH8EZOaUUiiemK6Ig1f9k907WfHS+C0edYx+PvH6XyCINXx+VPg6+96jmDXhAe
 Nc4CAYHCfdbsR/86K8nGmHDaLf2an2nrIjkwq6PaGZNEKPoi65wuBglYE1kQAN81jp/W
 gCXuQ6H8n4d+US+FQSOsaTqAogXw7E4aeyRYYR1YCWtVbaejRI0Yzfu+Xzb6Sqc0T7Ge
 Zam4sI6oDcusSMc72dtkonTUK6bMiS9wqDVE6xy6acaFBLgXBydzwGLk5gzfUc0KPwBS
 AZRvJ2r+1LnqyKuw62oj47GeKdmKL8+6qmqqeNvAjsRSbanxmhkfnn0R5IKHtnPV0sJr
 6MYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSxJo3DVG5FN8yCLjFQuXuMvUtmk+oVOn0ZXXcrZLLFo8s7MmxkVC8ib4IOdal/ax4DLBo7MZJcvyLnF3nw3jkJpM/A4I=
X-Gm-Message-State: AOJu0YyJoDc/Nd+LLwhYAroa4/B9lacQA86G68eBMjcbgFyGgLc1AwXy
 2ZhSu01t/Y3lBoTRiLtQxRmFNl57P1FR+xm/A1qdXe0kv0KhgACxM1GxxG7pVPmVEKyCO/Nsn2R
 szCDrfHpvLNkW5ZBWltNLhs2e1jHqUAWaAfcvdA==
X-Google-Smtp-Source: AGHT+IG0a56R0m32KsH2yanNp4494mtviVMwKnua2tCjbQig49UxZQOlGaYhAEyFptZRFwQdkSNdXT8JhydyBGbdVmA=
X-Received: by 2002:aa7:df8e:0:b0:564:6b09:9300 with SMTP id
 b14-20020aa7df8e000000b005646b099300mr2051292edy.15.1708347961461; Mon, 19
 Feb 2024 05:06:01 -0800 (PST)
MIME-Version: 1.0
References: <20240216153517.49422-1-philmd@linaro.org>
 <20240216153517.49422-2-philmd@linaro.org>
 <bcfd3f9d-04e3-79c9-c15f-c3c8d7669bdb@eik.bme.hu>
 <2f8ec2e2-c4c7-48c3-9c3d-3e20bc3d6b9b@linaro.org>
 <b40fd79f-4d41-4e04-90c1-6f4b2fde811d@linaro.org>
 <00e2b898-3c5f-d19c-fddc-e657306e071f@eik.bme.hu>
 <2b9ea923-c4f9-4ee4-8ed2-ba9f62c15579@linaro.org>
 <6b5758d6-f464-2461-f9dd-71d2e15b610a@eik.bme.hu>
 <bc5929e4-1782-4719-8231-fe04a9719c40@ilande.co.uk>
In-Reply-To: <bc5929e4-1782-4719-8231-fe04a9719c40@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Feb 2024 13:05:50 +0000
Message-ID: <CAFEAcA-Mvd4NVY2yDgNEdjZ_YPrN93PDZRyfCi7JyCjmPs4gAQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] hw/arm: Inline sysbus_create_simple(PL110 / PL111)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 19 Feb 2024 at 12:49, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 19/02/2024 12:00, BALATON Zoltan wrote:
> > For new people trying to contribute to QEMU QDev is overwhelming so having some way
> > to need less of it to do simple things would help them to get started.
>
> It depends what how you define "simple": for QEMU developers most people search for
> similar examples in the codebase and copy/paste them. I'd much rather have a slightly
> longer, but consistent API for setting properties rather than coming up with many
> special case wrappers that need to be maintained just to keep the line count down for
> "simplicity".
>
> I think that Phil's approach here is the best one for now, particularly given that it
> allows us to take another step towards heterogeneous machines. As the work in this
> area matures it might be that we can consider other approaches, but that's not a
> decision that can be made right now and so shouldn't be a reason to block this change.

Mmm. It's unfortunate that we're working with C, so we're a bit limited
in what tools we have to try to make a better and lower-boilerplate
interface for the "create, configure, realize and wire up devices" task.
(I think you could do much better in a higher level language...)
sysbus_create_simple() was handy at the time, but it doesn't work so
well for more complicated SoC-based boards. It's noticeable that
if you look at the code that uses it, it's almost entirely the older
and less maintained board models, especially those which don't actually
model an SoC and just have the board code create all the devices.

-- PMM

