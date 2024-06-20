Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB69C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 20:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKOJg-0007Rz-Rq; Thu, 20 Jun 2024 16:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sKOJf-0007Ro-Eq
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 16:23:31 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sKOJd-0005lC-QH
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 16:23:31 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f70ec6ff8bso8695ad.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 13:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718915008; x=1719519808; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4zUAahtlNGZrDkGQ3q0IjdEuM8KQCiY8cI4hYs0WCYE=;
 b=cKTWqqcmc2BG58mEkFmWosBh2ryCWo30yiSzGU/1i0vzVAsnaCZlW2OYqLlRRkiIZx
 laTRJ4xak+lbW5qs4hsEPACdJ/f8CIEhmZMp8dVO/LKnPbITvO/a7Vp2hxrB03Xbu9ER
 McwtQ2dNgi0xG4nOKJ85iZ1y5OyyATpXFiFekEUAlyX6tRd6OYeD8X2Xn2p9A54PI2aY
 zb9jP778tJpWInIwSaLiUPvYvU5J4lNmI5I7tqPzPWezNns4gsx6rCNVx7riXVx5CU1I
 i9j5nGzvaI6tMVlmiSGBuyMDeuU5GIwBwQuFL08R8BB4fxghFrAD9t+KDgBXLPpXCqgA
 tSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718915008; x=1719519808;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4zUAahtlNGZrDkGQ3q0IjdEuM8KQCiY8cI4hYs0WCYE=;
 b=HropuJH9iBZ2kN69rFb377yk8zfKKIFX08d8tMPWzyG77U82NJfysge5iBq3cR8uc5
 sML4SGRcMa139Kg2ac9LUkW/2jLhw+gSQGWdFreY1PSEtbTjCdq+4dF6HkUTphS57Dww
 Ohu8JClRwKWXBkCm2T0/DodQiWRgetb9dBqiAfx1pVBasUOND4ALyFGe0Nt26VSUH0uZ
 fp0Y0UVkmv3isrcWiV1SPb5EuOdp7wbjoGgavSVqJrH/N75i0FGvD6G8W/XcDESi65Uu
 TKZU3OsKaciYSNXR0740YwYAN92I2p1xL8b1NSGWmDevDqyVZVoX9NfVdX1bpSRo+Pnv
 Yvjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUbbwp1byLLfHKHoAVq27+ENo3fkjXPqIpC2nOjKzjoxgApPuLTmgajjmfa8LZFUd6WP+h5PDgER7N5YiePZMoSg6QYW4=
X-Gm-Message-State: AOJu0Yw4J325jWTTg/FMrkwUrgLGVlhX8fslk5OTTv40R19c+nfTraPk
 Ppor/wP0nUh8BPehZKgVrQHhh8PzFmPH39Zuhly9uvo/MVXXddFzAVRdNtDjEgxdokIbcXulNRc
 FIVNC/r2U0AjPCBBdZbAyZXG7HeOUwX+mOckK
X-Google-Smtp-Source: AGHT+IEf2yNr6fD7qv/w/fGK+c2jap3lCGTzYGTI2rajpAO/BJ1bZA5el48oBZevV5xHZv14PdUMAsxqs8aJLTCQNJw=
X-Received: by 2002:a17:902:f905:b0:1f6:ee4f:23d6 with SMTP id
 d9443c01a7336-1f9ec44a053mr28605ad.23.1718915007301; Thu, 20 Jun 2024
 13:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240618224604.879275-1-rkir@google.com>
 <495d3ddc-ce73-4ef5-badd-16ed61f9a5aa@linaro.org>
 <ZnKRLj3usYxmAIOE@redhat.com> <87le2zbqfx.fsf@draig.linaro.org>
 <CAOGAQeov7kwbopVPyVZwS3mYvWqMb_0=K4te09ENdtg-P7M23g@mail.gmail.com>
 <CAFEAcA-Mh-kVB57jWWwS_0RexnvFzNLLiHjxZJKOm49YHwXSgQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-Mh-kVB57jWWwS_0RexnvFzNLLiHjxZJKOm49YHwXSgQ@mail.gmail.com>
From: Roman Kiryanov <rkir@google.com>
Date: Thu, 20 Jun 2024 13:23:16 -0700
Message-ID: <CAOGAQeoda0GWHoki2-3Xvgigb4iaZhLeA_YCN_WJ_642n8HVag@mail.gmail.com>
Subject: Re: [PATCH 3/3] exec: use char* for pointer arithmetic
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 jansene@google.com, mett@google.com, jpcottin@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=rkir@google.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Peter, thank you for looking.

On Thu, Jun 20, 2024 at 12:09=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
> I think this is the point where I would say "you're making the
> code worse for upstream and the only benefit is to your out-of-tree
> downstream code". If you want to build QEMU, use one of the compilers
> that QEMU supports.

I think there is a value in letting other developers (not just us) to build
their code with QEMU. I understand your concern and sent an
updated version of the patch, which is only two lines long.

> There are lots and lots of places where we
> assume the GCC-or-clang feature set over and above plain C.

I am not changing this part.

