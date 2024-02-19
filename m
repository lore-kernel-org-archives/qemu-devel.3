Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA395C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4CV-0001UC-CU; Mon, 19 Feb 2024 09:00:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rc4CQ-0001Tg-Ei
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:00:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rc4CP-0005nl-1T
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:00:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708351247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5N1pkXCQ3ocyzN9RHKLM9moZ7or8GoZH/OW139oyAqU=;
 b=grV4izYdmYqRlRXDs877owEZQ7q6VApUQiEO+8N3QZ6+CrnZ4Pp/LzVw6UWqA61/dBUZQT
 4MLn5MJnFBMYqmZ76NuFJTZZebLddxD8kcI38QLfhFeVDnfm75L5kYq1WaxD3RImpTFZ2+
 seXHwMK33LkjuP8bCtgO9wTFTg1tYa0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-MEBwBR9GMZW0H6BFDYVDOA-1; Mon, 19 Feb 2024 09:00:45 -0500
X-MC-Unique: MEBwBR9GMZW0H6BFDYVDOA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a30f9374db7so539987366b.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 06:00:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708351244; x=1708956044;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5N1pkXCQ3ocyzN9RHKLM9moZ7or8GoZH/OW139oyAqU=;
 b=JH/32yJZmIdzLjz6yhB+kwkkLY26r6lcJ630OS/AcJTqDD+EHkTEHYOsQOhXmMhDtb
 yLFHn3cdXKp1qCm/D9paRv7G30GB6gCOxx7Rg6xYRD+ulFUNjqJPC4uABee8vGM1IQnx
 IvKXkBVmRvdKkPmWPLnyR2N/RJ/zTGzpapziT3p0D3ar6AnB1weJAfjfYFm4ORwSrbmN
 dVZE59pdQDDxfnRlAYn7Eqr1gt5q/fzDrAxsZud4gZCmmFX38XPnhmz3VL99NcygWbRA
 jD/i/X+Ja80IfOWYPc3r1fLI+pSsHeQVVCT6V6OKSOjQ6Sesx3imK1s7Bh0FnHnHlJDS
 L+rw==
X-Gm-Message-State: AOJu0Yx4RC9OaAJQBD1I/FeGjqbFwtcFGG51FbVE4llcOy3cd61ixmeD
 jJnOy0+xneHd4DUAmYaMAowrIv9bhMYcuxc30z5HO0bDdrlBuk8ip1DPyS9e2BbG+EBsxhnBIcy
 ASKp/sylIgTTGPiovNrINDZ/g8N6f/bpQRfLvfkiLOjB/S7l2rJ6MFeJr22KYwnRtit10pEtcPL
 KoFq+NczB+zZTFPoBfk5QFi3fXmg4=
X-Received: by 2002:a05:6402:3415:b0:564:16e:b91e with SMTP id
 k21-20020a056402341500b00564016eb91emr6802506edc.19.1708351244642; 
 Mon, 19 Feb 2024 06:00:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIqXl83yY1y4VqqWiEQGjJiKdt0Q6FbA/JJDXMCQEcRmfIPwYBwH1ttH342C79TAo6+H5xLkhf/K/FYjdrT+E=
X-Received: by 2002:a05:6402:3415:b0:564:16e:b91e with SMTP id
 k21-20020a056402341500b00564016eb91emr6802488edc.19.1708351244322; Mon, 19
 Feb 2024 06:00:44 -0800 (PST)
MIME-Version: 1.0
References: <20240219123900.430943-1-thuth@redhat.com>
In-Reply-To: <20240219123900.430943-1-thuth@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 19 Feb 2024 18:00:32 +0400
Message-ID: <CAMxuvazmk_cnxUOAsAi1D7=VsT7OkkyNPL6adqqCkwt2LWVscg@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest: Don't run the dbus-display-test without
 CONFIG_VGA_PCI
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Feb 19, 2024 at 4:39=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> When compiling with "configure --without-default-devices", the
> dbus-display-test fails since it implicitly assumes that the
> machine comes with the standard VGA card. Thus add a check to
> meson.build to disable the test if the VGA card is not available.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Not necessarily VGA, but a graphic or VC console. I am not sure how to
guess from the binary or compilation settings. Maybe it would be
simpler to check at run-time if /org/qemu/Display1/Console_0 exists. I
can work on a patch.

> ---
>  tests/qtest/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 2b89e8634b..c8e6d7df40 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -108,7 +108,7 @@ qtests_i386 =3D \
>     'numa-test'
>    ]
>
> -if dbus_display
> +if dbus_display and config_all_devices.has_key('CONFIG_VGA_PCI')
>    qtests_i386 +=3D ['dbus-display-test']
>  endif
>
> --
> 2.43.2
>


