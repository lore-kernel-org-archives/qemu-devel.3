Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77952C02184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfIu-0006Ys-84; Tue, 14 Jan 2025 06:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1tXfIn-00066h-O4
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:41:47 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1tXfIm-000692-0G
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:41:45 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-467b955e288so58210681cf.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736854902; x=1737459702; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TcWFQyhNc6naKavdeUrSg2t59/lqijn7V6MfrdULN8M=;
 b=Fg6SshBJztq+PPHPdx6IuCgfRDTUWrL0ruTHZy9U+Rk/6fwgUQKGFGNizd+lvOxJTw
 xKTHh56kug9tbAjLzNVZmGmapr3RLJsRiHzQldRFq7beRPk7Y2KC0F91cxQnlBHYaLZi
 Qt8zKusawy8M/kqd0ASKMxOu2KJW6RfE4DH0bBcrM8nazBiVfKIYn3Brzu37trzhkMIa
 kNvp249bX/B4oSuywNUjy2Ycy6o6T8haZVEdwy9aK/Hzmccmk5+v3ZQU2HI5IRf3Sj/V
 uCmNSWb4OxLveLSmpGmp7eUuYK9+z1YCpFFGKOeI91q8zJuxRgkpUsQbbYobbHkJ20oq
 ldGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736854902; x=1737459702;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TcWFQyhNc6naKavdeUrSg2t59/lqijn7V6MfrdULN8M=;
 b=VT/2K9u8qEnIoqBx3u2p3vNRc3IlCtPMv7XOk7eT+ZnMJq5stak+sj+P6wHoel6YCY
 qtbCSbKMjPYGexRmv+hiaBwlkeTz14rm3UdJO0J27CA/0sasB0V2EJqu48/zBBZNn2v9
 7Ls8CPmANNXhoSVZqoO09Lwbu7dq0bgb+mSuOFHotMyvn25GWJppDbwHHw3huyknrxhT
 jZCEgv3h9UINTFTaAf3U5GquIoEWVPmeogYlEG6L+fg1/zf6u2R/lTgfF1NxjEf+3y1d
 LkwfsaLvvxTrJrSQOS+6ZTUY2totevqB8ztCVZGEIr9UVfxTv8Fd17dhzfWlWOhmE1Sc
 DLUQ==
X-Gm-Message-State: AOJu0YwwC6q+RIo7hNUjku1PmCmBz9w/YMbe0bY6lkdEQCTb4L/53O8T
 OOg5cL0o2FRxqfsxvk4HLGHsAs4GllJocdk2oWfH1eU7/Xi9zP4wnD2seal3IL1gJYJ6FXhIv4q
 k7cQR0iWwK1uU0WWdZGifqGnHgQZX3ADC
X-Gm-Gg: ASbGncvxDOeA00/uTuVKgLXj5LLKIK/lY6+rz4iGzY3a8+IBGOLCGeDgEw3UeP+K/ME
 GQqMwh+x116TuAE+Y22nygY50My0JaE1ZnDg9
X-Google-Smtp-Source: AGHT+IHSYijrmfFi/N48oTc9SsZFL5sK3crICAcDoeIZFa4qme6MxIOXYS5u76CVctBw5pz8WyBLEJAEMIV3C4KzmSo=
X-Received: by 2002:ac8:594d:0:b0:466:8cc1:6221 with SMTP id
 d75a77b69052e-46c7109ddd9mr394651451cf.50.1736854901961; Tue, 14 Jan 2025
 03:41:41 -0800 (PST)
MIME-Version: 1.0
References: <20250114104753.2612342-1-marcandre.lureau@redhat.com>
In-Reply-To: <20250114104753.2612342-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Jan 2025 15:41:30 +0400
X-Gm-Features: AbW1kvaa6A3BabSxoJyF1JOCWlk6pHSw6spRS3Djvg_HLeCQtb6DlVWRR-RBjME
Message-ID: <CAJ+F1CK+9hcNc_2_ZtPGszOK+3dudkCkOcfxjKk_mDUA67yaag@mail.gmail.com>
Subject: Re: [PATCH] ui/dbus: on win32, allow ANONYMOUS with p2p
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
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

On Tue, Jan 14, 2025 at 2:50=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> GLib doesn't implement EXTERNAL on win32 at the moment, and disables
> ANONYMOUS by default. zbus dropped support for COOKIE_SHA1 in 5.0,
> making it no longer possible to connect to qemu -display dbus.
>
> Since p2p connections are gated by existing QMP (or a D-Bus connection),
> qemu -display dbus p2p can accept authentication with ANONYMOUS.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
....

> diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
> index b6a65806bc..9ad3f70bde 160000
> --- a/tests/lcitool/libvirt-ci
> +++ b/tests/lcitool/libvirt-ci
> @@ -1 +1 @@
> -Subproject commit b6a65806bc9b2b56985f5e97c936b77c7e7a99fc
> +Subproject commit 9ad3f70bde9865d5ad18f36d256d472e72b5cbf3
> --

bad submodule update, my bad.


--=20
Marc-Andr=C3=A9 Lureau

