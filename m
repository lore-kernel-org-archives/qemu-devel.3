Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B05C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 20:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVGlt-0006aT-Ql; Wed, 31 Jan 2024 15:01:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVGlp-0006SO-TP
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 15:01:19 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVGlo-00039h-0N
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 15:01:17 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-511207d62b6so197961e87.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 12:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706731274; x=1707336074; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tLufKUXyquvl+Xz4G93CWEejWvKBXDcxqEpEDJgoMyc=;
 b=Qw7fliyd5DrOl5XqqUg1ug0YUEX2ofBl/PazqUWiOxzG/magJlWkW/a7L/zUp3tSGT
 EZumUnPxxYqwnCu7NmRurf6MuLuWOKC3Y0JW8wrXlDWigwZKDtLvA2WvLwZwWNrTcglT
 I5xQX7Ci/XjLKNdH45U6B4hjADSMQTohUWgu61j/tQ3aHhkDnjtq9PN83gKzosfcW2jY
 lMJO+2EgVrOh/AyOD4nPdIENK17Hzp8B9Um3ZJ2T535zjL2Nl22ZQXMDQPWixrCLLZnY
 gm3Mphzt5eTMpbln4BDOvFhRxV25LBC9M+olnoqu/E0WJV1PpwOAvBu6bUV/XiAOCeys
 PDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706731274; x=1707336074;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tLufKUXyquvl+Xz4G93CWEejWvKBXDcxqEpEDJgoMyc=;
 b=KAnbJWmNuMdx04VU4CKMn86Jwn+6Dl6C6j2V5k6Gm/U5cQz5FE1Sf7Pe2ioRdu1Bu4
 ifXGIyJOwrzgCO9vsUa9GzMhsDzDsURVlrH5VPkIxap9nLUytKu50t4W277lQX0oL6Zi
 WYqgdxw6TaTRgNahZqE/b0+lKUxrGiMhF9bgERLatgp79vmFChB8+xRFuN6W08KA7bgM
 Ceq01g87Ps2X/acwz37ExxyLY6OP+XI5VUFY4+Bify4ZZNh8cWTJ/LDD5u+Xyjc43l5a
 oBjCTBA6VXMC2NGmOvJnR3Q1IrdLg7Ir0CbZe/11iQFBwCrnhCEBFfDlGbWuTr5qlVLk
 B1aQ==
X-Gm-Message-State: AOJu0YzVyzykE2J6fMW2pQfjc6VlJiPaDSTrzl3n92P4XY3fgaqx7z8P
 qmC9sPm8azUOhifaoSx3DlgqO3wY0yVfQTiquUOADmu2S0hph5VBDkLNI63Gjr3//Xuji8W3kJd
 nEF+oLXZ8cGwiJq5MapTECue1R43t44qq5HqwSQ==
X-Google-Smtp-Source: AGHT+IH8VjkN5Znt5wGPO2eANivIZBUPqzqvTPqoeFZdNzFbO6wHauqIVtY+Qjt//CJAQo++eDjDuqz1Tmd8y0BsjSA=
X-Received: by 2002:a05:6512:1143:b0:511:f41:dff7 with SMTP id
 m3-20020a056512114300b005110f41dff7mr135987lfg.56.1706731274019; Wed, 31 Jan
 2024 12:01:14 -0800 (PST)
MIME-Version: 1.0
References: <20240125173211.1786196-1-peter.maydell@linaro.org>
 <8d7f3b7a-67d9-4683-ba2c-9f2af1dddb91@redhat.com>
In-Reply-To: <8d7f3b7a-67d9-4683-ba2c-9f2af1dddb91@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 Jan 2024 20:00:43 +0000
Message-ID: <CAFEAcA87F36VP-vP-bD5CKbF60HzRQV6CpnvNwRuRt4K8uFw5Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Enable -Wvla, forbidding use of variable length arrays
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 31 Jan 2024 at 14:56, Thomas Huth <thuth@redhat.com> wrote:
> There's still a vla left in the ppc kvm code:
>
>   https://gitlab.com/thuth/qemu/-/jobs/6063230079#L2005
>
> ../target/ppc/kvm.c: In function =E2=80=98kvmppc_save_htab=E2=80=99:
> ../target/ppc/kvm.c:2691:5: error: ISO C90 forbids variable length array
> =E2=80=98buf=E2=80=99 [-Werror=3Dvla]
>   2691 |     uint8_t buf[bufsize];
>        |     ^~~~~~~
> ../target/ppc/kvm.c: In function =E2=80=98kvmppc_read_hptes=E2=80=99:
> ../target/ppc/kvm.c:2773:9: error: ISO C90 forbids variable length array
> =E2=80=98buf=E2=80=99 [-Werror=3Dvla]
>   2773 |         char buf[sizeof(*hdr) + m * HASH_PTE_SIZE_64];
>        |         ^~~~
> cc1: all warnings being treated as errors

Thanks for catching that -- it being in code built only on
ppc hosts I missed it.

kvm_ppc_save_htab() is called twice, and in both cases the
bufsize passed in is MAX_KVM_BUF_SIZE. So we could drop
that argument and have the buf[] array always be MAX_KVM_BUF_SIZE.

kvmppc_read_hptes() does this:
        int m =3D n < HPTES_PER_GROUP ? n : HPTES_PER_GROUP;
        char buf[sizeof(*hdr) + m * HASH_PTE_SIZE_64];

HPTES_PER_GROUP is 8 and HASH_PTE_SIZE_64 is 16, so we aren't
saving many bytes of stack by trying to make the buf smaller
based on the value of n. So we could have the buf always
be [sizeof(*hdr) + HPTES_PER_GROUP * HASH_PTE_SIZE_64].

thanks
-- PMM

