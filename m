Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF69606A890
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RRoxYRmQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUjM-0007Gg-Mf; Thu, 12 Nov 2026 08:20:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRUiW-0006be-9i
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:19:57 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRUiU-00076r-NP
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:19:52 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-67c2c2ac1c3so6227430d50.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 05:19:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794489589; cv=none;
 d=google.com; s=arc-20260327;
 b=osoJ/yJ0VsESwXJiQyCC6TgSh3bWqgCIpeSwwe49jHqe7cjljxCgZuI92LOq+hL8jJ
 zFeUmjgTSah3W1ARg/7aZ2HHEOtjgymnSxPwz9t5BAN2nc8q7uo5VX/iuK/FBBYPZcc5
 OcWWFAGlAyt1mK6t1lekFG5HzFwIP8Wp7bEzSjvXsAVKJdM8tbzB2XCegSGSpX1mS7bV
 F8ymhrjF7/FliXnq3e3p33KXTvmva78g+xhTcbuUTEHylLBLTJQHLp5jQG8i/D8hHgVB
 UnWqL3D6FcQsRy2j6JukYTYAQingDM4/5fI+vJ3Jml0G7iFm+Zr7r7Xctlg6k52qB/FV
 PgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8eAwW39cja+MmtUY1RZuvQaDz73zWjVGhSacFr+ZGuw=;
 fh=rzGEIgGWnwzhcAIcryai2Fbr/P3Y2Hk07bKA654eIwY=;
 b=n95BibsFkR9pnbzRHMwaTY4SCaYlrKLuJ+6TeOq0MAoBVMXc3raMQD9VErDNCO65wX
 xBHoGKJis4j/WdjB+OiX5gyNnbYryN9N2ROpHPFVYXiVtLV0NcThj8/Zf/uDJZrOGygH
 0vY5qRSLW/5BNKfAoeqb0Y9FeStcXcoWvoKD3vGEAi/k2Ji0Jtb4aSiXSCN1CtMEuBfv
 Gdwx5B2+ZPzuVPkigHknogfQrwqYkw/4tzFv6su0bwTYlpKS7WhXdWq6kabYExkV/IHc
 9EATCgvAzg2mvYlqLQyoB3oi6mET1qNPLS00Qm+Me5/8iBJcl/funyIz53MWNCjNHFnf
 h7fA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794489589; x=1795094389; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8eAwW39cja+MmtUY1RZuvQaDz73zWjVGhSacFr+ZGuw=;
 b=RRoxYRmQAezUqVIzAjo00SWIkFcgsDkkQl1UPiMFXcfw6dVZltK9koqYxN9NkKHp9n
 9nPMG951yi1U38sT8+BvdKRcLDejNTbSY0YCY3AIqqMpWAWmJ5GCVR8wonD3QayyDN5v
 l7joAK0u47Io7EXd/KIcc57A8OHRWUe6hmReqWGLUVxBhhaqbVD1BV4ODY+7+9T/Nmi6
 mrK4tNkZtwmRRfOB+q9E+X6+NEgG5knpiqeESL8tX3RJLKntTJX49EQGodzDRFBQEafG
 8yX/k3b3Pq5R5pHb2AyTdPhDGIzG5HM8hbmdDhFkpXy7pOCc/dnuUiBgNvePQcTQWksf
 aLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794489589; x=1795094389;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8eAwW39cja+MmtUY1RZuvQaDz73zWjVGhSacFr+ZGuw=;
 b=Jl8lsQUPPD7nvFx47ABaVWrewRzJvRuccTik1mbFAFc+eqYFt2H96TNPL/X94T8rL+
 xnXNAxZJGvgF5lz7k/VCYGSe+hIrLZ7z6K6h0REXQUsLhXVTZNuWUc8Iav//84c9SCGw
 1QjHhYx+jJQ6es2aCUbuTHXMfIAi8pWHCitDjEfU6JImTTf320JQSxRhJtuYO5GGZuJS
 EGZcTB6jfmNVtbggWDPao67Hv2hAHMFOCZtzfcZdLbOHNXJKrg6MbYxfgCH2gv/n544R
 CPTOIPwe1L/0ONMTfsQWwHEcABCgaTZPhmT4O7nt2PMQNAOZ+9q28ag1cqjemo07H1Iy
 vSLQ==
X-Gm-Message-State: APuU4Z9ObMWLjzmK6Bj0znL3ilVlTf9QxQmXyW9Z+SDB6q4RfiajRRoc
 W8OHJ0/OZWqCh0Jq6BucY4Pig/o2xfJku8HYTEEC4HPjWuAv8ZxDvJt6tFS2a2g71w8b/XGlkew
 Tm4TFTU1onbmIMYiba+CXqM2HsCjmWZ/b92nwTngRyw==
X-Gm-Gg: AYBFou3UQoPgqkTK51uOh2UvIoOkSIkVhjm44wkHVStpLILojETnKScYBpnt9YGvkZl
 e/aYndTdQZ+UF4ckZtjeQS4TDOOMwdus0tzixg0gfjKwcs5wvqOuE7zDtA31SOyU3AsKygRm0OR
 ySoY0hfwg47PF92FZmcC46aBUaGKnHpdBnIhzw3fw+uCbzfGE4Yrz27RKdIEQZBHD8YsYQy1Hm0
 hBe6gb6QA5jIDYRSQO0qoOp1AdBBPYasbSNXcAVb00gT5zwiolgjoMOktZ1RpoleOOf3ftFm46a
 BXsTMFABuR43HbrWOrytYXPPNRJRwTZeUwbK/EcL1nEbjWUwVWzYJtmGrTMGP4vH8Ey1NCDXYBA
 Y9Nw06+Y06yaeqO+ZlnwCBpEUhE9+sKa6lzWJmR1BchxV9XmapDe7Ls/D3opr2EcA8jb3wlak+A
 ru3FEfpFJaWQAkc1f7MoCh
X-Received: by 2002:a05:690e:812:10b0:67c:2752:e528 with SMTP id
 956f58d0204a3-67c67f9e116mr2560279d50.63.1794489589197; Thu, 12 Nov 2026
 05:19:49 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112-pci-bridge-resettable-v1-1-ed36c7b26fbe@gmail.com>
In-Reply-To: <20261112-pci-bridge-resettable-v1-1-ed36c7b26fbe@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Nov 2026 13:19:37 +0000
X-Gm-Features: AclHuK_nZ424Rx68MEc0UTdBQUAvd-BlvNvpT8Nn-5XsmietDLC_-ttPDnjuiHk
Message-ID: <CAFEAcA8-b7xjuawxOR4bJwfEYPpu7doXAtoyvZ+RU3xWc0FgQA@mail.gmail.com>
Subject: Re: [PATCH] hw/pci-bridge: Convert pci-bridge to Resettable interface
To: =?UTF-8?Q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 at 13:01, Oscar Alejandro S=C3=A1nchez Lucero
<aleszlucero@gmail.com> wrote:
>
> Replace the deprecated device_class_set_legacy_reset() in pci_bridge_dev.=
c
> with the three-phase ResettableClass interface, chaining the hold phase
> to the parent class.
>
> Signed-off-by: Oscar Alejandro S=C3=A1nchez Lucero <aleszlucero@gmail.com=
>

> @@ -253,7 +266,8 @@ static void pci_bridge_dev_class_init(ObjectClass *kl=
ass, const void *data)
>      k->device_id =3D PCI_DEVICE_ID_REDHAT_BRIDGE;
>      k->class_id =3D PCI_CLASS_BRIDGE_PCI;
>      dc->desc =3D "Standard PCI Bridge";
> -    device_class_set_legacy_reset(dc, qdev_pci_bridge_dev_reset);
> +    resettable_class_set_parent_phases(rc, NULL, pci_bridge_dev_reset_ho=
ld,
> +                                       NULL, &bdc->parent_phases);
>      device_class_set_props(dc, pci_bridge_dev_properties);
>      dc->vmsd =3D &pci_bridge_dev_vmstate;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> @@ -266,6 +280,7 @@ static const TypeInfo pci_bridge_dev_info =3D {
>      .name              =3D TYPE_PCI_BRIDGE_DEV,
>      .parent            =3D TYPE_PCI_BRIDGE,
>      .instance_size     =3D sizeof(PCIBridgeDev),
> +    .class_size        =3D sizeof(PCIBridgeDevClass),
>      .class_init        =3D pci_bridge_dev_class_init,
>      .instance_finalize =3D pci_bridge_dev_instance_finalize,
>      .interfaces =3D (const InterfaceInfo[]) {

TYPE_PCI_BRIDGE (and its parent TYPE_PCI_DEVICE) don't implement
a reset method. Usually we don't bother setting up the infrastructure
in the child class to chain to the parent class reset unless there
actually is a parent class reset to chain to.

thanks
-- PMM

