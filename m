Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E185FE66884
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 21:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWha7-0001r9-RA; Fri, 19 Dec 2025 16:00:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1vWha1-0001nY-Iw
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 16:00:05 -0500
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1vWhZy-0005Ky-L2
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 16:00:04 -0500
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3e37ad3d95aso1585177fac.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 13:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766178000; x=1766782800; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QllVLyfEum5ZRYt5XWIi8BBO11zIKKjfdLb7eic4MUI=;
 b=nAeVFOPs2v9gPk+q89sa/0cuse5PF+0lsfGxW7KEJeD6u7qQCqwu0RwPx1i73Msrd0
 pu+FNNTwNcNAcmI+tZYeMRQN1fgrA9os6XDsCmdRN46uJmpLB/dDQIxc3MpKM5gWcBbB
 5n7ZuJbq1zQdPIELyaTcxkM/VjoXgilDr0hY7ZWJHmSFILzEKALWDH9Y5SywBMFLUPoE
 CBNIS6jBdEp/NZCgydzzcvvTSF5TksSZiZ5LEst42LrD6DG7AMOrF30sI4cFVkAiems8
 7MMlKu+Xi/saClZzn+PuMBNBeti3gbYCTGWc/WsCot87yZrvcyDZBCsuJn2j1CdjZ3AO
 w0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766178000; x=1766782800;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QllVLyfEum5ZRYt5XWIi8BBO11zIKKjfdLb7eic4MUI=;
 b=Jtg9oNOgRLca44IAoKCYYiz/2g00G6BYvshIHMYzV/fMp8Kd8C8MmQEwBIz2R2MrIq
 RVzJ81xlOgKG8R281stVZgxct9+dTrvAat6v1C3TGCup1I1zXL6v3WwvaGMRO1PV7TE3
 8AB8XL+gcbgqK3Wj5aHJh4FQ5q1YosV3KEpxYKQYX+hjYNoKnX2JigK/mpyh3SPn9Fxk
 9UVSmZ9avhjhD3byqzJdFgUa4O3YYbkxTITR1yHI4n+A/gnlcxwsIBdVKOaLO0Mj+dJ0
 zrCA53T3UNNuanalEAOtR11FtCbe83VIKEC3oPmXlLoS/OkIeA6EPhuZHZwOAOLBk57B
 mwkQ==
X-Gm-Message-State: AOJu0YzT7yMH85hk4/ii/e+SyL0AO2gIvaLgM1x5Upq/OUhAIlfmU4vu
 ZFgLvlPibR8ISTPSfpV0T3pqVtf1gjokFQbHXh/UuiRtw9hv8KPGGiDGeDwXoZtNdJ63N9ZbBza
 czrzuiKMeSW3JRWVpaqUouehLsqeGf5o=
X-Gm-Gg: AY/fxX7u7ebNTEW0b/n85K7Zp3BZLPMj9NbEpeRB6iktNVMoFpuWZpIDLh/A06Z4dMT
 Ql7vgbgEzedOePBaDjmU7Geg9bnDVy7vnDEKExaW4C4NPti0LbOIqqN4NIAKAHIRGhHPw1n7C0g
 wlFK3Pzdto1oxYOIn82Nm0U8n5EM+tx7DUNf6fPXI664Rh5xoriiVuDFMJupF5AUJCOZ8k0i1+b
 BNnijB4cU8zvwTHCOPwZVE4XHW3DjNzSM/wdaK9Sz54EbePSMp0j1C8Nu1/RPiHhspbV4bjdUBm
 wD5oBPDCYnoeWw+jerCwcOyripmwyaSJi1SWqWgl
X-Google-Smtp-Source: AGHT+IG2f+svwskhLEM0CEvCJ04JzpJe4tIYTpzTg8+N7bugVoMkBvKoq8ACOlhLcnL/z6cXXMs0jZCDon+U0KXDuvI=
X-Received: by 2002:a4a:e1c9:0:b0:65c:fb86:8a94 with SMTP id
 006d021491bc7-65d0eaa2672mr1472544eaf.36.1766178000466; Fri, 19 Dec 2025
 13:00:00 -0800 (PST)
MIME-Version: 1.0
References: <87ike27ucd.fsf@pond.sub.org>
In-Reply-To: <87ike27ucd.fsf@pond.sub.org>
From: Jackson Donaldson <jackson88044@gmail.com>
Date: Fri, 19 Dec 2025 15:59:49 -0500
X-Gm-Features: AQt7F2qtuMEWiFwXhJ87faAMAZxmY6YisGC1kB0OYA0-zts0kVKUBHGdUQrRyTM
Message-ID: <CAMyd1rQ6CLN2FPic=4pNpZtcw46io2xftkBDSLfd8V9S+Jyu0A@mail.gmail.com>
Subject: Re: MAX78000 machine needs a maintainer
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000053f8720646545cea"
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=jackson88044@gmail.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--00000000000053f8720646545cea
Content-Type: text/plain; charset="UTF-8"

Hello,

> You added the MAX78000FTHR machine in the v10.1 development cycle.
> Would you be willing to serve as its maintainer?

I don't think I'm a good choice for a maintainer. I no longer have access
to a physical MAX78000FTHR to verify against, since submitting those
patches I have joined a company with a restrictive IP agreement, and I'm
fairly low on time in which I could contribute.

- Jackson Donaldson

--00000000000053f8720646545cea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"auto"><div>Hello,<div dir=3D"auto"><br></div><=
div dir=3D"auto">&gt; You added the MAX78000FTHR machine in the v10.1 devel=
opment cycle.<br>&gt; Would you be willing to serve as its maintainer?</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">I don&#39;t think I&#39;m a =
good choice for a maintainer. I no longer have access to a physical MAX7800=
0FTHR to verify against, since submitting those patches I have joined a com=
pany with a restrictive IP agreement, and I&#39;m fairly low on time in whi=
ch I could contribute.</div><div dir=3D"auto"><br></div><div>- Jackson Dona=
ldson</div></div></div>
</div>

--00000000000053f8720646545cea--

