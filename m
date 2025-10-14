Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A64CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fWJ-00070K-B8; Tue, 14 Oct 2025 09:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fWB-0006w6-78
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fW3-0003ua-3Z
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760450195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QsW/K+OjUw5KExO7OMFQbWajSeWV+IBa+J005838qxE=;
 b=MSwki8TufFwwmcgo4bYzF9D8luDyZHkhF6yOunOcO4zAORbu68T6fW0UMr8bkQkgfwCpDL
 wLC0prt03wV5P5LzgqgolBIbylXs4Ic6M78Xk0g/MrLkw1ccwzt58WGlb1nSYdyyP8szAS
 cqQb4lL8x16kQ28aOh6m+c7H/HBXLWI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-hnoEwydWP7mdzniYYaLgag-1; Tue, 14 Oct 2025 09:56:33 -0400
X-MC-Unique: hnoEwydWP7mdzniYYaLgag-1
X-Mimecast-MFC-AGG-ID: hnoEwydWP7mdzniYYaLgag_1760450192
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ecdfe971abso4479136f8f.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760450191; x=1761054991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QsW/K+OjUw5KExO7OMFQbWajSeWV+IBa+J005838qxE=;
 b=tQ1amW3MnLiyrK9HfisGtnjuKD7TMqV3cCk7JJXyoLqv7qQRbBgxPn6VwRrSLuJGWM
 hDeBMi930WxaVHZicYxO7uMjKq6pfPHCHDycLMOmzGSTlce7/2ci27aVXRgrHuqcuaDA
 sCTxLCuw1EsJuJobOThaL6SMJHQvMtGGAX5jeXGnFpXvxF+MV2qWI98brr8LY89eiZdB
 a7CEH1WZasaB5AgEjRUCCk/2EidjfazRqEutVh8Yu7XqrDHDZvnywJ+6myLQAmi4R/4i
 wvJboKvEtSl3NaShwR17m8U6mkW30NOxZXWO1bA9SFjjgKs9Nl2dRZ2BW8YcfXanGcV5
 3bqA==
X-Gm-Message-State: AOJu0Yz4O4vMoVmz21pn/osixGLH35W62+OGiBYFjceIxwmDDNY0YN+9
 aKNZ4UiU4ZEWn65IXqg56vuzsXXTNTIoi2I6LzRavX32DNXePMcpj5d9yCg/wm0MFKnXONLRPEr
 5GPJzhbALLCrdVgYCgeeUxcsFzGOoa30dOP8dpsSYpSw0wvaixgiMdymrShv6RM8j8irRtoRN7T
 JmiYyvmJ6o59iPFDgAo9NsSBzMY5BTKQBW51k00hI=
X-Gm-Gg: ASbGnctB5pkQPfUgTY0EhIphh6Io0ezptsaKwOCstUO5mN24LaX5VCx8twBaoxdeuLb
 Cqc6/ehQQhQIBWUkyMafo0NFPF7t1gVE+9vwc6dapgq/MsWjL6YAlfHr4zhZ773gGHIWuT5ZBgu
 clWoE/Q/Pdt4rIOecPGYhNk1/lZNKZe0NFamOjlX8+x+zmQ/7vO1Kd5J6vq/b1szotZoxJoUIJV
 mFF1Sg00JBKRgJUk3nO6/nC
X-Received: by 2002:a05:6000:4285:b0:3e1:2d70:673e with SMTP id
 ffacd0b85a97d-4266e7e0012mr14560601f8f.37.1760450191511; 
 Tue, 14 Oct 2025 06:56:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnURVy9GkNiribx0SE8NwElFvpXRMM4YMaCezyPKZGBUz68a9ytQZ9CmjcNwJy63vdMhtQdVDRbvIZctpFXyE=
X-Received: by 2002:a05:6000:4285:b0:3e1:2d70:673e with SMTP id
 ffacd0b85a97d-4266e7e0012mr14560583f8f.37.1760450191047; Tue, 14 Oct 2025
 06:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20251001075005.1041833-1-pbonzini@redhat.com>
 <20251001075210.1042479-10-pbonzini@redhat.com>
 <aO3z7zbztw3TaxY+@intel.com>
In-Reply-To: <aO3z7zbztw3TaxY+@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Oct 2025 15:56:19 +0200
X-Gm-Features: AS18NWAf9-sTm4VgGjAqeXAtveUOrUNyUQa4eYRY9UNw5HbTOmivZebhJHrY-nA
Message-ID: <CABgObfZ6Nx-wP-huGqL6maeV4Z7s2rZnayGYfNFdh4fPPV=S_Q@mail.gmail.com>
Subject: Re: [PATCH 10/11] rust: migration: implement ToMigrationState for
 Timer
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Oct 14, 2025 at 8:33=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
> > +impl ToMigrationStateShared for util::timer::Timer {
> > +    fn restore_migrated_state(&self, source: i64, _version_id: u8) -> =
Result<(), InvalidError> {
> > +        if source >=3D 0 {
> > +            self.modify(source as u64);
>
> Timer::modify() is the wrapper of timer_mod(), and timer_mod() will
> re-compute the expire time with scale factor.

Ouch, of course you're right.

> So here we should use a binding of timer_mod_ns() - Timer::modify_ns()
> instead of Timer::modify(), just like C side did.
>
> Moreover, for Timer::modify_ns() & Timer::modify(), the simplest
> way is to build them based on timer_mod_ns() & timer_mod() (but this
> sounds like shifting the responsibility for type checking and overflow
> checking to the C side :-( ).
>
> Alternative, we can make Timer::modify() based on Timer::modify_ns(),
> but then it involves many numeric type conversions: scale is i32 but
> expire_time is u64, and Timer::modify_ns() may accept a u64 argument.
>
> Fortunately,, we can make Timer's modify() accept i64 to reduce type
> conversions.

I think it's better to make it accept u64 and assert that it's not
above i64::MAX (with .try_into().unwrap()). Anyway I left out this
patch, and it can be picked up when HPET starts using
ToMigrationState.

Paolo


