Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA38D2FFE0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 09:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1jjH-0002QO-5h; Fri, 18 Oct 2024 05:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1jjF-00029i-6M
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:57:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1jjC-0003Dn-T9
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729245420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6DPwp3kv75aBANOnbLu5QFbwkvVCFA67aPlX64wnaoc=;
 b=FLyseakfpuz8E1W0cK+aFDyTSj96vZ/2lY2sx+xL7HCogSZIZ9Gnja/wP8gPIkoOwHngjt
 dD1REsc9cI0e1mpwkaOiIizFxbkJui+U85Vvioi1NC0oBgN5Hpw25wy1KadkDMsCnVyaOy
 YXp2vPCSZIbnCPRIEAeX/dPED4xm1JQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-8o69cQ0HO76TnsJNj7AGmA-1; Fri, 18 Oct 2024 05:56:58 -0400
X-MC-Unique: 8o69cQ0HO76TnsJNj7AGmA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43159c07193so16144165e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 02:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729245417; x=1729850217;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6DPwp3kv75aBANOnbLu5QFbwkvVCFA67aPlX64wnaoc=;
 b=EQ7ZNleF/s/d/nPXCMwCpXceaY4hCw2VPOUIEbj6MlN8L3TCKmEB99jIme6udWQjFV
 VZORehKvU8gc0I2ou+NpdsA31j1u0I7FbR+B/pD94JCQbXqR3W1H8AqBXEOYrKVb1yDX
 kB8zxa3aema1l2RrRno/isBqV8rExp4XocqD04iqo8DLLBrOgFfzsyvaatRZe4YQzo73
 Tek9MXSgvbSV3Q0ApK0vQdwEOw0x3QFaGhCPjtSqHmlyUsXBSZ6XusJVYaar50AfHVRx
 BzheCeAkzkEB/kSYLS4y/tHtd74Ygli1dBUbmHWq70GgC9p3mZGNpn2p6NEWPP8xoH+z
 HIWA==
X-Gm-Message-State: AOJu0YxQIwiE1rbW8pFo0l8nFXARve1mnc/9F7SlV538ncP2uU9ps/22
 ba4nT23lh5B3g7UM3SQj3zy7L4J/9JdEffyvSzN5OjrPGm/Au/uBMGeTDR8BLC405e9JrH/ZLsj
 uyPMCVU9uzBbhU2k2p366FV0XUXesho4wyEo4dYFVaEeh6LHFwsBnXiYTO8ehv3jEr+So0VzqeN
 ViKKPIO2CWQjsGCBio5IHrZUw+V0w=
X-Received: by 2002:a05:600c:3b9b:b0:431:562a:54be with SMTP id
 5b1f17b1804b1-43161627c0dmr19477475e9.9.1729245417390; 
 Fri, 18 Oct 2024 02:56:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+K8MSIcqg7+nKwDpOye2oqZXWvcXOzZ15AAdpOnXZUdS376JRGzoqpwoqDABlLf0nXBxtH4rLmYNrjuL/ITQ=
X-Received: by 2002:a05:600c:3b9b:b0:431:562a:54be with SMTP id
 5b1f17b1804b1-43161627c0dmr19477305e9.9.1729245417074; Fri, 18 Oct 2024
 02:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-13-pbonzini@redhat.com>
 <SY0P300MB102670D06E55A6B463CD1BDA95462@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <CABgObfbqhmr=45c9ZiYoDAanM7Gsinz4RnwGMrivYDQgzP8kTw@mail.gmail.com>
 <SY0P300MB10269110D64F40C0F5AF0E7595462@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB1026A5E47899229BA3F559F595402@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY0P300MB1026A5E47899229BA3F559F595402@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 18 Oct 2024 11:56:43 +0200
Message-ID: <CABgObfYmLpw9emGvW4VzYrkV28snFF+FO7-x5ZMDcvJwxtYQpw@mail.gmail.com>
Subject: Re: [PATCH 12/16] rust: allow version 1.63.0 of rustc
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Oct 18, 2024 at 5:00=E2=80=AFAM Junjie Mao <junjie.mao@hotmail.com>=
 wrote:
>
>
> Junjie Mao <junjie.mao@hotmail.com> writes:
>
> > Paolo Bonzini <pbonzini@redhat.com> writes:
> >
> >> Il mer 16 ott 2024, 08:10 Junjie Mao <junjie.mao@hotmail.com> ha scrit=
to:
> >>
> >>  In my Ubuntu 22.04 environment (rustc 1.76.0 and bindgen 0.59.1 from
> >>  apt) the feature `proc_macro_byte_character` is not yet stablized but
> >>  used in proc-macro2. Downgrading proc-macro2 to 1.0.79 [1] and syn to
> >>  2.0.58 fixes that issue for me.
> >>
> >> This is handled by patch 5. Try "meson subprojects update --reset".
> >>
> >
> > Yes, that works. Thanks for the info!
>
> After cleaning everything to build from scratch, I met another issue:
>
>   bilge-0.2-rs| Downloading bilge-impl-0.2-rs source from https://crates.=
io/api/v1/crates/bilge-impl/0.2.0/download
>   Download size: 24524
>   Downloading: ..........
>   bilge-0.2-rs| Applying diff file "bilge-impl-1.63.0.patch"
>   bilge-0.2-rs| patching file src/shared/discriminant_assigner.rs
>   bilge-0.2-rs| Hunk #1 FAILED at 26 (different line endings).
>   bilge-0.2-rs| 1 out of 1 hunk FAILED -- saving rejects to file src/shar=
ed/discriminant_assigner.rs.rej
>   bilge-0.2-rs| patching file src/shared/fallback.rs
>   bilge-0.2-rs| Hunk #1 FAILED at 22 (different line endings).
>   bilge-0.2-rs| 1 out of 1 hunk FAILED -- saving rejects to file src/shar=
ed/fallback.rs.rej
>
>   ../subprojects/bilge-0.2.0/meson.build:9:0: ERROR: Failed to apply diff=
 file "bilge-impl-1.63.0.patch"
>
> It turns out that the sources in bilge-impl have CRLF line endings and
> `patch` does not ignore that even with the `-l` option:

Thanks, we need a .gitattributes file to ensure that line endings are
kept unmodified on checkout.

Paolo


