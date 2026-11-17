Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D250606A898
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hiUWH/Mj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTHcQ-0005A9-Bl; Tue, 17 Nov 2026 06:44:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTHcH-00059s-R6
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 06:44:51 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTHcF-0001hA-7m
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 06:44:48 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-6798af41644so3326159d50.2
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 03:44:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794915885; cv=none;
 d=google.com; s=arc-20260327;
 b=f1zdKPomoDvIz8kvcczBCzEwfWiybITFnRol6uv5gQWC/X3KbDIHRRIhYyWGhzXYQL
 TZvM5WWGzc/+pb9Ge25rbwCmdTp/7uG6A6y85PlsAHmJiv2S0hHps0v8fC3d7haF9ksl
 rmlOCRxwDPW7sdqdJXzr9Cs6MFBnOWFsLI1pVJFErU2xkp1uTB7kiv+d0SJ7f+IFCud/
 JsqDV4RyHO4oQvtVwfiMxzZ0EdwX1bW75xymmaYMEMBARmZOMDU2shxhXReX4QN62G6E
 qU7u7GgDs4y52n4prEFzdSDlhQtzMaH0xJcrisvcJ9rxFC5lyQmBoZ2IsZyJxMKEayL2
 FllQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yq0W8rirLpbjfCpyhSTP0Gv/58+1Ms9AdlwMY9ZNUcg=;
 fh=pSaaFEU+5hNAM01y4+fmc3QX0uJDH2s1/nPhHy+FPVc=;
 b=gnuHxmqQ4SpeEBVgWqgb+zJLL1ZRWxTjCzewDNKdIezA3Xc0eLYKtNZn2RABZmSQXd
 1iG5kkw9fpkOgTI8tmgKmo4XBLrEs3tzQ76m4Uk/qkzYg861JKwxN9hftYQWA1czympq
 L3Qlr/bpY4088woAjnmILYo+J+iPO5IsVj73l6qQvHkJExGAecQEDxMxpS+8ltFZNl6M
 rZ+Gsc4DQf4q9fKIsYB9qtJawx/4pbcjXJhsu6DOi/VpMxgSUM+a8NcDsTDKNqdpW5lg
 qweCIu/FgYmW1UAffHoEQJaDaVF48J+dwSejVii7OlzN3skgooMFRXTrbxYqjfYZFK6S
 eX6A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794915885; x=1795520685; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yq0W8rirLpbjfCpyhSTP0Gv/58+1Ms9AdlwMY9ZNUcg=;
 b=hiUWH/MjHqG6W1++dDrzcyhzY/v06l4TTKV6RPiB409tKiCk7li3uS+rS9t1vh5Iw4
 MRXPUDxkT2mH0AgQ9Lxqf2069jP61Vl+NZC0e1dJJgrcrxV3Nw1l1/1nMOs4Wl8DRFL5
 1CYt2EHk+a5k0xpsiH8DXqGV2/heOSRKAbruZEGXjE22269MX+e2PoPOeAsc8eKj9hKR
 gZuox1ApjzUdG+pWf8kWzykjq7Sg6hjE6ZaFkWRJcnfZf9lSYMc6sOvVcVQe4xmxaW/w
 TOYpSzUXxMDd6mToetuP2KyNcuf7hbi9G3BpWgK4xnu22ARgq7NcmjWvAT7RN76lP9ru
 7yCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794915885; x=1795520685;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yq0W8rirLpbjfCpyhSTP0Gv/58+1Ms9AdlwMY9ZNUcg=;
 b=UQvvPb+l5NHREWnBCIt9iBYWwHGCeu6vMstVmrtTMZ9y+RcEIP+4EVMhFxuPHrWUSQ
 j3Ma93s6G1uRbHF0LF14nthzxbLetiSOtvUYoxPnG1HFLHR6TcGOY4vD4KMXbumfaFB5
 O8D1bR0dSJyCEC1kYbYqF0WCkFcDBmP31u4KbizlETvMa7gyhAGptWjdyGskvvR7C4YA
 WtcW7EG85DKzMj5jCSN1AEI2xdHWrOzqJDtsp92NHRzKTSX2YpN++hXLH5k3t3BWOmuy
 KkKcGV9T7aRC+qgn1F+BXjsxJcnPUXkQIRdvymDINFg3nLSzB1Ta7KqVtG8mhRqjyyXo
 w7LQ==
X-Gm-Message-State: APuU4Z+SZ/SaLnmozWhfmeOv4AhHhG/rwjToEaWNCm51ZG+Yg1uCa34l
 k6ryJ+AWbUjBAmAwBAD581F64jaNNt0hge7iWKS3Wv9yCOdGpOo9JRniTaCKw+vOjjgRf4FHqoN
 PP15X+tX6B6B9OdaQZ0PeeFNMKTETFxgp9GcOnz6/kUs3Y6HSfiQMGEk=
X-Gm-Gg: AZFdTZc6gC+/xyT3w7XaIw+4Pq5bkcJpDzMQyLMWTWLvT4VouX6221f+xNtmF8W9UpQ
 pnCUZe11axaU+LoXmD74kdsXx8XmunOR1OoXLrjKjsZ0wEmp8qURdV4cy8M78higp/zdKoorZUb
 2qXrnO0wKdTBJYtfTao6NhiL5o/3SJJWTWvBbqBuo8e9mkubjaII0KODqcq3UAFiHlgstZXcsaL
 KoMH/4QRl/5TEJ4SNqwJ1QibW20DxWS7A5pUc/2Fnck2Qb+a9vBotl1ln242oh2XtSSAnKI5NLg
 rZBtjhpuh/wmdSXykkynzKRQ/h2lFX5/WygdfMNd24Eu6dF3VONj6Ltia5HqBwguf9LAWKaHN9Q
 FphD+rKZxzqZVJWY3rw87yZKCBqaJgSk4pEj0PV4qGArRWXaynhGIy8zmFVXcNcT6Afz4Wjv2nv
 3UscFtoryNqhs+JU21Z94F
X-Received: by 2002:a05:690e:191a:b0:67d:bbf9:11f1 with SMTP id
 956f58d0204a3-67dbbf95439mr3104194d50.47.1794915884594; Tue, 17 Nov 2026
 03:44:44 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110134845.1770151-1-peter.maydell@linaro.org>
 <CAMxuvayZYH6_pSWunRYmQQmD2hOC2xLSyciMob2dieozAYhFUA@mail.gmail.com>
In-Reply-To: <CAMxuvayZYH6_pSWunRYmQQmD2hOC2xLSyciMob2dieozAYhFUA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Nov 2026 11:44:33 +0000
X-Gm-Features: AclHuK-6HxKPS-_iiFWKf2JT6gBDuC7dtRrmNDljtxVNfTBgjEsp9uAta5RIuKk
Message-ID: <CAFEAcA_26wwqGgUtVKtBXpFe4BMAN=J=ArgQr2=wyAZ+A31iBg@mail.gmail.com>
Subject: Re: [PATCH] tests/functional/x86_64: Add test for ccid-card-emulated
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 at 13:01, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> On Tue, Nov 10, 2026 at 5:48=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > Add a functional test for ccid-card-emulated.  This roughly follows
> > the usage procedure we document in system/devices/ccid.rst of
> > creating some fake certificates, pointing the device at them, and
> > then inside the guest querying the smartcard for the certificates and
> > checking they validate.  It deviates slightly from the suggested
> > commands in the docs because the buildroot based rootfs doesn't have
> > glibc and so "NSS-based smartcard integration with coolkey plus
> > certutil" doesn't work.  Instead we use opensc's pkcs15-tool to read
> > the certs off the card and check them with openssl.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks; I've applied this to target-arm.next with the style
nits and the unnecessary DEFAULT_KERNEL_PARAMS fixed up.

-- PMM

