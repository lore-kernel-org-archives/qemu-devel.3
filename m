Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6CFCAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 09:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzAzm-0000Gn-5U; Thu, 18 Sep 2025 05:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uzAzf-0000EI-PT
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 05:31:59 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uzAzd-0001f0-7R
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 05:31:59 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45cb6428c46so6822815e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 02:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758187915; x=1758792715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GCQ6IJB4THH2mjQRZu4ktOVSYqENxEpi3gs7gRZNzTQ=;
 b=iBWl5DOeCJzY9FK83VO59UpMfjf3yKx45E8A1e5M86lPWj9SAv+Q5xwXibTShOm321
 gq+JV4T4RTC9HfuKl54HVeCHh+1viXMNBDj4N2TlMyxrOZF8rOzy1DSDCiFdEthyA8R6
 9sa6slzeU83aHJYefQjDxbrAJv8UgLSIegipNtExdBdrz4aXlgtmWOkBX916vj8bZwvg
 8++fsAjgrmMnbsZLXB2TIXInQnZu7gAMB/HAxYW4X3ddvJhs6Ll6kFfwCvcBYipDXleZ
 6geY9/7JK5h6k7wakZBLol7gp5zJiX8Xrf4uHJ9+g5VHyHGqEjwQh+413JzqjOWxxHXr
 +2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758187915; x=1758792715;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GCQ6IJB4THH2mjQRZu4ktOVSYqENxEpi3gs7gRZNzTQ=;
 b=YSemho7wQFMNE2UELiCDL6coawK5X865NbscokHJ7esWBVmS5MTJa0J5LteihtuNwP
 JTqUsedNjGhLiY6RsTfahZ6X/loFYViB4hqIoZaiKXIN01Yj7pBFJaog4NyNH2cSMdEt
 YSjBQFC95iUiHP2sFWQ2DO0vi7Eh6EUtDsz51Q8++fR2kYJlaZcOq5cRh9LzruDWrsm0
 cvtnyTn9FYdNfFD35LiHlha/dIj5BJ9GGmB4ZcWlF+1RSEusarVU9LZV3+ihfP2RiNMy
 BoqpGEFjUsrm+GcX9JUQWAwcaSzEabdzi+iblsj25eWIEyUDPWUUDvjgSoikNI8EfjKi
 FooA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuU5pSK5pd7v26Zc4bV2TW6f+OADkMmdQH44u0MB3HUrlHoEFrxVbdh88PcD+nrwv8NWhtag1xvr2P@nongnu.org
X-Gm-Message-State: AOJu0Yx4bZhXr3CFzwWB4F4s3m/v6xScz/gBWz0pENcz5TVdkIX+zj/o
 6W9Gs2gsqjvPgrLyJntb6rYmxbOfbAGu0EzMWAXbE09Ri6Z8s412YSZu
X-Gm-Gg: ASbGncuAd9OObdMQEcogrzhSAdA/bLQu7uBGsqwVdDq612tu0mgLSIyxWaexTLfchVC
 AI8GRpf6Rn0ZHB1BsZUt/9ChbM/xihyw702qQBDMOAfeOE6ocxgNIJFNRcviM7GOzW2xA2WoS/C
 oWL1mERAtx38hTus5V8ec/Rzgsk4fkkgE2UjCCzyET09KaTA6HwE/NesPUgjrzktFwEhBgISWxR
 JyoK4krUVb+FtpBQS9kWrTJTfqi7f/4tZm1CaEB30GD5daA8pde+/mvdbBCBh3wVdCYurMrPJYq
 GirkqwgnQ5va9u06TP2Zu2Kxwog1xwd28zH7wrlBqbs0UClgUEl5J5rhvH51iwZbCUkX1SrXRLd
 5+naLLxcawylFOHJ5hJHiixYnyDa85l+FYQGisztwNZCj2e8gsQevGRQz7z0Hkp9UyBODSRNJis
 eNdHTLuncMqg==
X-Google-Smtp-Source: AGHT+IGtMuNadmZNNj37hkcW+YL7g9nje/MbhOLrhpPeWq/9Gi1MZJfkoEpTwoaofA4ctjiD8Oci0g==
X-Received: by 2002:a05:600c:3b20:b0:45d:e110:e673 with SMTP id
 5b1f17b1804b1-46202175527mr46988065e9.4.1758187914516; 
 Thu, 18 Sep 2025 02:31:54 -0700 (PDT)
Received: from ehlo.thunderbird.net (78-80-105-95.customers.tmcz.cz.
 [78.80.105.95]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f1627140sm34295795e9.6.2025.09.18.02.31.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Sep 2025 02:31:54 -0700 (PDT)
Date: Thu, 18 Sep 2025 11:31:46 +0200
From: Filip Hejsek <filip.hejsek@gmail.com>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, qemu-devel@nongnu.org
CC: =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Szymon Lukasz <noh4hss@gmail.com>
Subject: Re: [PATCH v4 03/10] chardev: add qemu_chr_resize()
User-Agent: Thunderbird for Android
In-Reply-To: <e025952d0d0e1f78b68cfe42dbe39975570a94bc.camel@linux.ibm.com>
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
 <20250912-console-resize-v4-3-7925e444afc4@gmail.com>
 <e025952d0d0e1f78b68cfe42dbe39975570a94bc.camel@linux.ibm.com>
Message-ID: <4C88D994-7C6A-48EE-96BC-9D8ACC31B2A9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x32d.google.com
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

On September 18, 2025 10:45:13 AM GMT+02:00, Maximilian Immanuel Brandtner =
<maxbr@linux=2Eibm=2Ecom> wrote:
> On Fri, 2025-09-12 at 05:39 +0200, Filip Hejsek wrote:
> > From: Szymon Lukasz <noh4hss@gmail=2Ecom>
> >=20
> > This function should be called whenever we learn about a new size of
> > the terminal connected to a chardev=2E
> >=20
> > Signed-off-by: Szymon Lukasz <noh4hss@gmail=2Ecom>
> > Signed-off-by: Filip Hejsek <filip=2Ehejsek@gmail=2Ecom>
> > ---
> > =C2=A0chardev/char=2Ec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 11 +++++++++++
> > =C2=A0include/chardev/char=2Eh |=C2=A0 2 ++
> > =C2=A02 files changed, 13 insertions(+)
> >=20
> > diff --git a/chardev/char=2Ec b/chardev/char=2Ec
> > index
> > 635d19fea4fd4bd0c7f171f055fe940f9f5ebed5=2E=2Eb45d79cb9b57643827eb7479=
257
> > fdda2cf6b0434 100644
> > --- a/chardev/char=2Ec
> > +++ b/chardev/char=2Ec
> > @@ -351,6 +351,17 @@ int qemu_chr_wait_connected(Chardev *chr, Error
> > **errp)
> > =C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > =C2=A0}
> > =C2=A0
> > +void qemu_chr_resize(Chardev *chr, uint16_t cols, uint16_t rows)
> > +{
> > +=C2=A0=C2=A0=C2=A0 if (cols !=3D chr->cols || rows !=3D chr->rows) {
>=20
> Perhaps it would be better to discard resize events if the requested
> cols or rows is 0 as it indicates that an error has occurred at some
> point during the process of receiving the winsize=2E

Maybe=2E But then if the size actually changes from known
to unknown, it wouldn't be possible to get it back to the unknown
state=2E And what if only
one of the values is 0, and the other differs from the last value?

What I want to say is, I don't think QEMU should be in the business
of trying to fix broken size info=2E The kernel gave us zero,
so we should forward that and let the guest handle it=2E

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chr->cols =3D cols;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chr->rows =3D rows;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (chr->be_open) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qe=
mu_chr_be_event(chr, CHR_EVENT_RESIZE);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0 }
> > +}
> > +
> > =C2=A0QemuOpts *qemu_chr_parse_compat(const char *label, const char
> > *filename,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool permit_mux_mon)
> > =C2=A0{
> > diff --git a/include/chardev/char=2Eh b/include/chardev/char=2Eh
> > index
> > 45cb6349756ac8072dffab9354108caf90cd3565=2E=2E1e69b038241074d627ebb7f0=
96e
> > 98aee9953ebdf 100644
> > --- a/include/chardev/char=2Eh
> > +++ b/include/chardev/char=2Eh
> > @@ -232,6 +232,8 @@ int qemu_chr_write(Chardev *s, const uint8_t
> > *buf, int len, bool write_all);
> > =C2=A0#define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, l=
en,
> > true)
> > =C2=A0int qemu_chr_wait_connected(Chardev *chr, Error **errp);
> > =C2=A0
> > +void qemu_chr_resize(Chardev *chr, uint16_t cols, uint16_t rows);
> > +
> > =C2=A0#define TYPE_CHARDEV "chardev"
> > =C2=A0OBJECT_DECLARE_TYPE(Chardev, ChardevClass, CHARDEV)
> > =C2=A0
> >=20
>=20


