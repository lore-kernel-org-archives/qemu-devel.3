Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDDFC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 17:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf075-0008Q1-1Z; Mon, 03 Feb 2025 12:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1tf06s-0008N0-Ox
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 12:19:46 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1tf06q-00040c-Up
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 12:19:46 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-467b74a1754so59821391cf.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 09:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738603183; x=1739207983; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hz7Qpw8DiAEmNhs73hTo78lZWzySWRHjnujk7zGlscY=;
 b=hYIemv04Q9MRa2xgkstSlpmC9OjTgYdfGVlKLGH9xGtn8Ezk1sooWVik4hHTi/k+ak
 lKf4E6OF1yLjgzsYWn9EOH6fvayhLDhTkNmAbECIdG7jo4FH7yntP788WeVJVMNiSyb4
 oXgGcr2wyU6ghHH8MOogZTazqq6EnPrcnTuJYOmyt/66qjzTCHkV870nFTpeBR3X1QZK
 F7q4t7Sq2A6bqTdZQqLmOD2VqFP402A7+EMnSc2IbLk1Tx02NiohpM+5SRYfEyjCB8UH
 Jw+kuernrDTnWBghna05sS09FppWXvQcmDlrwIzM9bpa83LPMoSmx5Phz2riyR4M4ZQf
 2fvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738603183; x=1739207983;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hz7Qpw8DiAEmNhs73hTo78lZWzySWRHjnujk7zGlscY=;
 b=E8uYZIodiIQcZmDtpgVVVmOczaGY4Ag6hCHYDFo3c/kSKmYZTIg75vyjioMr7w662a
 w7DmBWJ8JaG5sbtx83Mtz2SylMqkuS21uXAq5RvSo4sLtMZwymsERwK6oXrFcaOQOhiP
 NDVO3+i3rqJgrsNOoE2yhUtw/2kbheepKlp/XQe9xdOAp/LHXKJPD/5Y2PWzXLk7cW5O
 CpqOxiSa9lZ0yS5bVJLlaxxNst7htcEWSTsUey6I0ZRZy8epNA+fWm2tTdTouQh6f82l
 yVjjEeDO99nIDhbxwZNfVEGwU+NWVg2IbjyxoGWYv2/zVAJ1pQ6RfUhRLfDIwhyeMGBK
 jzqQ==
X-Gm-Message-State: AOJu0YyNjssmL3h6pA++KOwklMfA9Zra4fbltztrg2c8UF2EOyETi1r6
 wl570rJNB9C5/4k9OCYSe0T378rSPWDgzIuMqYQvwQPwvVqcXZFhd4bQsDapCwc+sEt0nXy9xGs
 TpfD2M4oZhzbCEUUA9Qhw0I/fCKs=
X-Gm-Gg: ASbGncsyMAQRt247nj0YiwUBSS2uGEspz7C5qMkHL58GQi6AFeXnn3Gz68klkYw4MZa
 EUqIpZKPse8WHK65f3VMQjPG2mJTOIEGMxkdObJ0JFrKQuPj7fGKzD9uqZGW0Ll2PW9DOqR+Sya
 SO2oXSnYrQqiEp4krHAsrWxd9dhdatSg==
X-Google-Smtp-Source: AGHT+IEoo9SWoVqyDNx5yAEN7cos/yy0Tvh6OZM0ChIWG0d9ot6w207N7xSI4Miu9w6p0aHKFIZX/RCivqwwNyxobdU=
X-Received: by 2002:a05:622a:1e92:b0:467:6226:bfc1 with SMTP id
 d75a77b69052e-46fd0adcbeamr329809341cf.29.1738603183091; Mon, 03 Feb 2025
 09:19:43 -0800 (PST)
MIME-Version: 1.0
References: <20250203125721.640451-1-marcandre.lureau@redhat.com>
 <CAJSP0QX+zW0eenxwdZL4=jrdXB2=dVjpb2hw8BzFM7Ee9EHdrw@mail.gmail.com>
In-Reply-To: <CAJSP0QX+zW0eenxwdZL4=jrdXB2=dVjpb2hw8BzFM7Ee9EHdrw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 3 Feb 2025 21:19:31 +0400
X-Gm-Features: AWEUYZl-taOUzofv75peo87aMeua-83_LLNT4uQsBS9I7Ob8hq21TBnoU1BbH3E
Message-ID: <CAJ+F1CJifV4Dk_7fCoH6arHZYDRo=eOr-uDGVbDLVVuU8z1Uew@mail.gmail.com>
Subject: Re: [PULL 0/8] Ui patches
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Markus Armbruster <armbru@redhat.com>, peter.maydell@linaro.org, 
 Gerd Hoffmann <kraxel@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82b.google.com
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

Hi

On Mon, Feb 3, 2025 at 6:29=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com>=
 wrote:
>
> On Mon, Feb 3, 2025 at 7:58=E2=80=AFAM <marcandre.lureau@redhat.com> wrot=
e:
> >
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > The following changes since commit 6fccaa2fba391815308a746d68f7fa197bc9=
3586:
> >
> >   Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu in=
to staging (2025-02-02 11:09:10 -0500)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request
> >
> > for you to fetch changes up to f327a2cea1502a8cad2beb13bc4e2c12b95b10ba=
:
> >
> >   dbus: add -audio dbus nsamples option (2025-02-03 13:58:08 +0400)
> >
> > ----------------------------------------------------------------
> > UI/chardev-related patch queue
> >
> > ----------------------------------------------------------------
> >
> > Marc-Andr=C3=A9 Lureau (4):
> >   ui/dbus: on win32, allow ANONYMOUS with p2p
>
> Hi Marc-Andr=C3=A9,
> There is an unexpected submodule update in this commit. Although it's
> not included in the patch email sent to the mailing list, GitLab shows
> it:
> https://gitlab.com/marcandre.lureau/qemu/-/commit/31d9023965ba1963afd1e0e=
0f48c75399a7bc23e
>
> Please rebase onto qemu.git/master and remove the spurious libvirt-ci
> submodule update before resending this pull request. Thank you!
>

Sorry, bad .gitconfig.. resent, thanks


--=20
Marc-Andr=C3=A9 Lureau

