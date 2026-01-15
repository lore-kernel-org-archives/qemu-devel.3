Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E65D46606
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 17:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgRKy-0002fO-6t; Thu, 15 Jan 2026 12:40:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vgRKr-0002XY-1N
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 12:40:41 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vgRKp-0006Wq-1i
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 12:40:40 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-65378ba2ff7so2066347a12.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 09:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768498836; x=1769103636; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pFygvUPRNLSZ/XY8rCnQorj/Zj/aRb+urUYcsyKhDk=;
 b=KcImzeMrjEG/K4Sn8sqDNzyv4sH7jS5TIrmDQZPOW3dX2/NX7wyiCFR8ni8t+E5BNq
 OKfiTSu8WjWudsbvqxephn/Wb2CbC7IFxF1xcxia6uMqQZpjWTqPpkZgZLwwOrg6AvQs
 jd5GLxtBtHqTMXh94i8iE+ZBNsSn4j6l3FZ6/5/JMbfgkwDaf8goWBEdjeESzL9qsSLd
 qtGFC7NnibE+2LrDLSad4LW5JbMymS95ShOKrTlmHKBl6yd8BLtDWFGS3ubiTAB1pHHu
 BE1xoczcwEkd4cIu74QHRIw2oYYMux24P061JAt6dH3bW2xYqi55AmH72kxZIFQn70ad
 oZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768498836; x=1769103636;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2pFygvUPRNLSZ/XY8rCnQorj/Zj/aRb+urUYcsyKhDk=;
 b=KFfrrcbzXOvFrgDQezkOt50ry2KRnJQlP0qwndrwJ6/iWPdsMx+oa9mli8BxziEmFs
 Nek0SPNPQ23iL+lEhp6buQ9U3EARMjAvafgEjE89I3yu61VREPKia+AaWg3x/azCUWp9
 McaMosGR2/uyHW7zABQuzg5ndQAjU8hPRlCFe9rxs/YRu59jNoh2IJKc5dcTS4/H2cXp
 6dAG6Yl3CO6LfQUWfkdsgK7IGAJS+KAcQqfh6d1DdDM09Mr/vfdUxbluH6IS9cI1rr/X
 6k8dQk80C4TEi14K5tr/IE54nD3XSZ9g0A0CKaDmLmy8wf3PQ23xAjzPVlhDYqIa0Xwe
 1kMg==
X-Gm-Message-State: AOJu0YykJyJManHcvWOyFLaf3ToScPltIOKNM1aJvOEXZ6h/vFft0e0K
 zURKVIjI9wVkNpIi+/0bjg30LAzNm57P50BnDkhQ10HRXTWAzJwQ7dzvd4MQQvvnIV/2lgMrjBw
 782VmT8BN0TcTDgUrTUGDCdYOmU8baMVghYe4
X-Gm-Gg: AY/fxX6vT2OEjjvZr3mU6gvjrjizd/lmK4jMPwDAF5ODp0TZxyvABD3q1efhgFBEMED
 FJCJ2hbuDVEU0zcRL28YWxDuRG7p5v+eNn9Huo4u6YN7L1+991VgeU0O4yJCKAwkKbx8oULiz9Q
 wS61GPjZPWrAamUt+6yfvhJuvME4hdNpXgsP+YIlajEBuMr2c2zhWAFmkxwObgBHKSJdxRISf7i
 7zKhdjxHXsgQGiE9jBsTuVrAs7LfyEX0pqPWg9nenktD3kfay5XJVObJHYNC7IQK+F6bOHD
X-Received: by 2002:a17:907:94d2:b0:b86:edaf:5553 with SMTP id
 a640c23a62f3a-b879302924fmr35906466b.59.1768498835615; Thu, 15 Jan 2026
 09:40:35 -0800 (PST)
MIME-Version: 1.0
References: <20260115142629.665319-1-peter.maydell@linaro.org>
In-Reply-To: <20260115142629.665319-1-peter.maydell@linaro.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 16 Jan 2026 01:39:56 +0800
X-Gm-Features: AZwV_Qj9JliyKS3B_TKlviEryYyyt2RuH5ioW0vkb__sQ0xmD7K3S4kwXJnKk9g
Message-ID: <CAK3tnvKdSGRpy8q4kHsNFXCKdSezmG4ZHaDAbWKw=RZ=n-J9gA@mail.gmail.com>
Subject: Re: [PATCH 0/4] docs: Remove bogus mailto links, minor cleanups
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Li Zhijian <lizhijian@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52a.google.com
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

On Thu, Jan 15, 2026 at 10:26=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> I noticed while reviewing a patch to add documentation for
> a new Arm board that an unescaped '@' character resulted in
> an unintended mailto: hyperlink. This prompted me to grep
> to see if we had any others of those, which we do. This
> series fixes them, plus some other things I noticed along
> the way.
>
> The first patch cleans up some awkward rendering in the
> xilinx-zynq-a9 board docs, including dropping a hex
> address that was triggering a mailto: hyperlink.
>
> Patch 2 is all the easy cases which we can just escape
> or put into ``...`` preformatted text.
>
> Patch 3 removes some uses of "@var{...}" in qemu-options.hx
> which may be there because the authors had the impression
> that that would be rendered into italics -- it isn't.
> I've replaced them with uses of "<...>" as the most
> common way we currently mark up "my-option=3D<something>".
> These aren't mis-rendering as mailto links because they
> all happen to already be in preformatted text.
>
> Patch 4 makes a bigger cleanup to the colo-compare
> option docs: it also uses "@var{...}" and here it is
> causing mailto links to be generated.
>

For this series:
Reviewed-by: Zhang Chen <zhangckid@gmail.com>


> thanks
> -- PMM
>
> Peter Maydell (4):
>   docs/system/arm/xlnx-zynq.rst: Improve docs rendering
>   docs: avoid unintended mailto: hyperlinks
>   qemu-options.hx: Drop uses of @var
>   qemu-options.hx: Improve formatting in colo-compare docs
>
>  docs/devel/submitting-a-patch.rst     |  2 +-
>  docs/system/arm/xlnx-zynq.rst         | 51 ++++++++++++++-------------
>  docs/system/device-url-syntax.rst.inc |  4 +--
>  docs/system/vnc-security.rst          |  6 ++--
>  qemu-options.hx                       | 51 ++++++++++++++++-----------
>  5 files changed, 63 insertions(+), 51 deletions(-)
>
> --
> 2.47.3
>

