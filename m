Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79160D1624E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 12:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Jtu-0001Oc-4j; Mon, 14 Oct 2024 08:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0Jtr-0001NQ-Rg
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 08:10:11 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0Jtp-0008PD-FC
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 08:10:10 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a998a5ca499so636223466b.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 05:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728907807; x=1729512607; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MgcAr/r6SrzlQFMbVItq7R5mi6DywgulqY9j+YWEK2M=;
 b=zC9/J8h6kJK4PcHUhS793J7x8Va1DgiKM9qrG75Hx5rLURw60UfXWAx+8Qev4LMc8f
 0v/1IaOnmMUsQgraOaRMvRoVOML9mdydAFqDFpJT94iY6Gt2+p4MR4krhCZUhLRT40jU
 GXhCP+J+YRr1f8PPZUzA4tyQPF4tp+nNWBAynsq3qEjebWHbC47ioX7TOQgXqgilDXlR
 YPhIXMZtEokYWNSO5Ir4YPvq/c3AuVdDThSsAbO0npxVVA+0O3JOxWRCGNpfbNDzpMWh
 yxVpt3l2nN/DRpQram/w5dTVVUJYQ6/vawvmSC++09TxI6tU08ljak1qzUbYSM0BDNKv
 SpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728907807; x=1729512607;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MgcAr/r6SrzlQFMbVItq7R5mi6DywgulqY9j+YWEK2M=;
 b=vsyoobIhjE0Sy/9n5hckWLD5VWqFfrde6ZppNa8TMh4hA+n+nIPZeNlKJi48e7L3Vx
 LFzRdd8JVO2mjeSHUj/rGlP7HYEeQn7TTxKmTrI9zkp09sfn+5o0YQDrwNawhtYGtol2
 oo1K18QejyZMpxb0LN55BjXSOliwp8dVlF6DlsJhV1jXZG0aHbSv2ijo5i6pWyYaKOP3
 1fbV3WFuWbzLrSHM9jvRQDAGD1PK+EFw5BwduGjetQMf0zEwwTzi4PIclNpuVs7HW2Nz
 zvAcQo2m5u0/O6HoDSH/On9IGr44fPk0OZrOXbGt4BFwYWxbnspwsmtkHxyi0CutGxg0
 vuKA==
X-Gm-Message-State: AOJu0Yzaf2bIE4PHChopQiWMDjj2DSHf3Cp/btVhVTIo6H8vjgqLt9zl
 CeZiGPQbmCA62wCLWLmVw+W3jt1YxyUA+0No7v+YcD5S6gCTTrUP76F6reIbD/FlPh5YWnxU2C2
 lXD4Oj0r8QqwU8UmNVtjSDRF+dbcSrfOhwbxvNUB1uyApT4w4
X-Google-Smtp-Source: AGHT+IG3cKVXEiFKdOoBd3+Y8N7xq2qS6bV0NBrQ83l7hJKj9/slsbhRFw0MAgNyA8CzYv1LShSv6WEtJziN1Hh1hHM=
X-Received: by 2002:a17:907:9283:b0:a99:4ca4:4ff4 with SMTP id
 a640c23a62f3a-a99e3b6dabfmr786605466b.23.1728907807399; Mon, 14 Oct 2024
 05:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20241014110113.173946-1-pbonzini@redhat.com>
 <CAFEAcA-8wdDV4fziAj5FqfR2isjdAvLxXZHvqN0=GewDNS9iLA@mail.gmail.com>
In-Reply-To: <CAFEAcA-8wdDV4fziAj5FqfR2isjdAvLxXZHvqN0=GewDNS9iLA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2024 13:09:56 +0100
Message-ID: <CAFEAcA_vUxNXRNnWtDd1DeWmC8dDT64VwvB8yswnjp5QzyOt0w@mail.gmail.com>
Subject: Re: [PATCH] configure, meson: synchronize defaults for configure and
 Meson Rust options
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 14 Oct 2024 at 12:45, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Mon, 14 Oct 2024 at 12:01, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > If the defaults for --enable-rust ($rust in configure) and Meson's rust
> > option are out of sync, incremental builds will pick Meson's default.
> >
> > This happens because, on an incremental build, configure does not run
> > Meson, Make does instead.  Meson then gets the command line options
> > from either coredata.dat (which has everything cached in Python's pickl=
e
> > format) or cmd_line.txt (slow path when Meson version is upgraded), but
> > neither knows about the rust option, and the meson_options.txt default
> > is used.
> >
> > This will cause have_rust to be true if rustc is available; and the bui=
ld
> > to fail because configure did not put a RUST_TARGET_TRIPLE in config-ho=
st.mak.
> >
> > When in the Rust pull request I changed the $rust default from auto
> > to disabled, I should have made the same change to meson_options.txt;
> > do it now.
> >
> > Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> This fixes the issue I was seeing with my local
> incremental rebuild.
>
> Tested-by: Peter Maydell <peter.maydell@linaro.org>

...but this change broke 'make vm-build-openbsd', because
meson-buildoptions.py fell over with an error from the JSON
decoder:

make: Entering directory '/home/peter.maydell/qemu-openbsd/build'
/home/peter.maydell/qemu-openbsd/build/pyvenv/bin/meson introspect
--buildoptions /home/peter.maydell/qemu-openbsd/meson.build |
/home/peter.maydell/qemu-openbsd/build/pyvenv/bin/python3 -B \
  scripts/meson-buildoptions.py >
/home/peter.maydell/qemu-openbsd/scripts/meson-buildoptions.sh.tmp &&
mv /home/peter.maydell/qemu-openbsd/scripts/meson-buildoptions.sh.tmp
/home/peter.maydell/qemu-openbsd/scripts/meson-buildoptions.sh
Trying to enter hw/core which has already been visited --> Skipping
Unable to evaluate subdir([]) in AstInterpreter --> Skipping
Traceback (most recent call last):
  File "/home/peter.maydell/qemu-openbsd/build/scripts/meson-buildoptions.p=
y",
line 245, in <module>
    options =3D load_options(json.load(sys.stdin))
  File "/usr/lib/python3.10/json/__init__.py", line 293, in load
    return loads(fp.read(),
  File "/usr/lib/python3.10/json/__init__.py", line 346, in loads
    return _default_decoder.decode(s)
  File "/usr/lib/python3.10/json/decoder.py", line 337, in decode
    obj, end =3D self.raw_decode(s, idx=3D_w(s, 0).end())
  File "/usr/lib/python3.10/json/decoder.py", line 355, in raw_decode
    raise JSONDecodeError("Expecting value", s, err.value) from None
json.decoder.JSONDecodeError: Expecting value: line 2 column 1 (char 1)
make: *** No rule to make target
'/home/peter.maydell/qemu-openbsd/scripts/meson-buildoptions.sh',
needed by 'config-host.mak'.  Stop.
make: Leaving directory '/home/peter.maydell/qemu-openbsd/build'

-- PMM

