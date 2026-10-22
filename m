Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06DE606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YTgnsuvn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJq2S-00013Y-Jg; Thu, 22 Oct 2026 06:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJq2R-00012o-8j
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:28:47 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJq2P-0006tS-R9
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:28:47 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8b0dba37a7fso13788637b3.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 03:28:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792664924; cv=none;
 d=google.com; s=arc-20260327;
 b=rifau1ZqfDolMOhn45gZ+vTI2EH+gdYkZNCENIzbzZE10hX3SKK5EUAED6xszqPCsq
 6EfaEo26TU0iZWbamtb2pxU3jj6S+ov1W5HNqIRH01gd8P5jWqT5CS67FRK15lRbmmXt
 VHqQ2NOl37yH/ljfsdEriY1aRZSZeCYPklFhFsYKN7REgMHWJeHgnuTgqyezAd3swn4+
 AJ2YUr6bB9EgaYcoQ0enzxkEmSOAaj9VSXqkCKBtLY/4il1+olLnQui6a6/NqIQi0EAP
 3omjqPcv5eMHqucGuonOzDMvK4QPU0vKJ4FfT75zq5IHpNk2j2WLQZNLDbP/EMZRpoxr
 eByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=R9+slaVplhS0h+TANs82YWQX1if6DaqQLvnNGQd68DU=;
 fh=iALYmo8Pf+/UBg7oE67kKkNAIz+lqzT7FOfljDk0Evs=;
 b=g27zEZ3OHness2oNFqIhxMIn6fDCeGq4RMK0BpCiGukq7B05cjrp6FzxJczHuO97a1
 EoZJvTbC31RN8fLbkfJIrqDcxbzBTgS3Jvihw/S+ObAmv3NpJ/FoGwp+8/pqMYy1eR4E
 fVMz69qLRVCcq74FisCJ9uI11XSyAJuzhJAgXMkOioXfJ3qg7DTCur+PFraMv4yYqeLZ
 EAEBTnhaRfD31gSRsC67HRaMFwjaXgDIBHRQ5kzKCGllKrXGbPHcZbBgSEHz89lo8TOw
 HuN2eTeOOT7tQMn9dWADb3O7+KevzF8asjOaH0qZphjtTdC1mqCb98kESGZAlXttpSCz
 SIlg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792664924; x=1793269724; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=R9+slaVplhS0h+TANs82YWQX1if6DaqQLvnNGQd68DU=;
 b=YTgnsuvnxjMQjgM/DFNwH5jKmuXLGR8A3RMv4r4LT2OHR7iMqX/ozy7oieFueDQzr5
 yeVmo6+Z2JR8mYOWjcHQDHFqxBReuk1E5r9lzqrnkE+zSEor4rysmd0+CrosqcAMl7pl
 LHLV66pgkkUuGtSCwrDpjauxeOPFrbd/9DbNqJ520/tg5Yex1smcYPXki8LzEUylWNj7
 RuxTf6znxeN+veSLZ1TdY1Fb5XF+vThzrBnZ2L+uniV8Ldmj3TclgqQEeujYDpZ7KXqv
 XARZXKYykN2ndAe0tJ/pOdzFhMC9/478aKyFwCdMU8FsNezxrzwFXzaCQFm49Vh9BcdA
 5gVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792664924; x=1793269724;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=R9+slaVplhS0h+TANs82YWQX1if6DaqQLvnNGQd68DU=;
 b=G2f0YvLpYFUOOayHdRi6r3qLEvy2Z40d7X/cr2ZIkE9Pua2/DiCNIYgyq4j9xpcFvr
 ESIXrXZ3y1G3V3LwdIuQkj30z2m9WO+eknBzR8Aa9GcPBrEpn+8GGlgLRF8NLkl6jMxz
 Hi93zPo7aJbK8C37XeTvctBcnv8VXeeENAw2zv72osk8EcLrpl2Zr9OX2TuUo5nVS9Pt
 CIMNw3UYM+JeY90jJSeOaB3jQUpR/juX8IG1yOTp6Avi5VIBARY95gPhynz+uVogIwpq
 O5sSSS+KLTEj5k+vcQYN2gThslv1yPxrJOgGl1sGmdxEwl0x1bCk9GvQ7pZ//U9M1Ri6
 N8dQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwt6aJKlSTdmL7bWn/eS5lcjt/opIpWs2dpvaot6knr3wCvcqnVxnxpo/NRtM09ZluC5sPJT+bGh6ie@nongnu.org
X-Gm-Message-State: AFq9FYKAwGjUtPNViiUxpIZfyS3c0xqJukrTNUdz6XmUSwMNMAQLuMBD
 SVVhfnYWDkI5Ase6kT0ATHf1XROfNEWsHWOLf4y0CfsKfU045+vCGjkHZMTeM/5O0Fuocz94mcH
 S8ADw+E2rGk2m2tTQ2Mpoz+nPfs/MoQYPt06o/MYdvw==
X-Gm-Gg: AYBFou0oeMz0oIu4TIycw8AqlPAP6HHebrkjMkvNtCZIfFHHAGUSpQ3wkiGWTqlbZFs
 OLH9nDk0v9i3CDx5YATMfudplf72ZOI77Ah9Ufc6/CBntccDC1UtaC0E5z3Qt8B/I7wcanqyRQI
 XPqgev6fmnri6xR4P14N1YIaMNVXzdyInUDBcFRttxgXG/LD7oLYukSSZb0hT7Wl89XUBzpK8AC
 x7B8qNkfOOTKI3eHWW2E7LGiNqD9IB9sIJvhlE/MOunb5zpm0XvJjMhX1JO9rem9oRumixy0/Z2
 wyq3G/08j7QxvqWyC+aVqguIMO2DNmU9IN7WhmRG8o+5CrvVtvdnB9+KAJ7clhavT9U2WhGvYAp
 OllPKVdIayC+PaXp8PDHPQ5gBFChwgWcVygFYf021J1lSVeL7/DDsYoLQkx2ROH22NDQ7P14ujh
 /MKwNlfXjXsXazoCbWiT+3
X-Received: by 2002:a05:690c:e6:b0:8ae:85db:8e48 with SMTP id
 00721157ae682-8b134109c2bmr25286017b3.68.1792664924530; Thu, 22 Oct 2026
 03:28:44 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261010133725.642498-1-eric.auger@redhat.com>
 <20261010133725.642498-3-eric.auger@redhat.com>
In-Reply-To: <20261010133725.642498-3-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Oct 2026 11:28:33 +0100
X-Gm-Features: AclHuK93dWwl-q9PlNiq8ZHRWxeuR0zJWNXIhDag3YFIxNwVwRpCtcfZs_60VFo
Message-ID: <CAFEAcA_cNP-Gb2_r2xFW0qUUBrkygNpN2kxhz2curXfXXeWtww@mail.gmail.com>
Subject: Re: [PATCH v10 02/26] target/arm: Move MIDR into isar.idregs[] storage
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 kvmarm@lists.linux.dev, shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org, 
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com, 
 maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com, 
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com, 
 jdenemar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, 10 Oct 2026 at 14:37, Eric Auger <eric.auger@redhat.com> wrote:
>
> Move MIDR into the isar.idregs[] array as other ID registers.
> This will allow to overwrite it as others.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

