Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB51C52D6F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 15:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg4JE-0008Mt-GQ; Mon, 19 Aug 2024 11:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sg4JB-0008LV-J3
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 11:28:37 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sg4J3-0001y3-MO
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 11:28:37 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4fca589dba3so463075e0c.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 08:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724081308; x=1724686108; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4BVmD+rPd7o/hLYFRuCRS748I1PRB8vBHzACL/hCo0=;
 b=P3X1kDno84A4oZnWCGIoLyPGu1Q7elkomzVnra+frpd1UM1ESZoc10U5Qg6cr0UX17
 zON4urxmmEnBN+sK6LddWjwbYUxeFiHsHPJah6HeMFmbgE0yyTraDwprFX7bcH0BnEwT
 pVEYbEHBanaD4DOUHmbxTpjBwegVBbvI5HqRvADGGJJTpCnE5srsa0RBxLnd1iH/sZKX
 Rps3j8QUankIarGHkrEFgTUUDcBkVw7Q8RXz5xfBHSN+RWW4m0WefNzInKjgEcFuTnkD
 scEydL9gPF0+rWBQB3Uk9filGOapT9ot9SYOkEYcnDVs4Tz+7JGwi+Eg/Asvm8NPzOHm
 fwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724081308; x=1724686108;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/4BVmD+rPd7o/hLYFRuCRS748I1PRB8vBHzACL/hCo0=;
 b=d+kYG0ZU+K+wqIaHp2JJWFZV/7OGElo96oV7VuXTp6iSlVnARIluV+X/6tec07zeBF
 e/r93LQKctI7yBMgF/OdEFV5qXf1iCDiRBUoKcji/c0KDmM6qV2f+KwcXu27ACatr447
 MGkAcCPdMT6DvmRBQQLY1+RD8WL+5Yo0ID9JsITy0/iWbyUQKr38XKTxnO+pobyWhLhB
 F89vRPz+A9qn3ardwDiGjo559CpPmDjSapoHhNt3fEjgPf8E3la6mj4vLUGuyBhOVWCO
 /YAaoQST5kuxbWcw+iOYUOm1jETjNXCE3HY3mpA91P//I/tE723WylNAX5MpyTRrXmkV
 AItQ==
X-Gm-Message-State: AOJu0YwzG16Sqy24dB1bAWJTEQGPXO7dkS4hO+9JZH+dlRqlDVjFuV4z
 5JcNIjwTFGQoByLrAWzbuTwguT7cuoUDFUOvwfhQwG2XLwgWjca6USEnUNpbwQSEW1QmJae7zyH
 PvBvqI8cDkkO6DgtVyLE15On3bFo=
X-Google-Smtp-Source: AGHT+IEKxaZ2YMSH4IpUi72s29/EwTOMga+9Yttm8XhWEtnyqHYij+YKuPhoZ1t1XDBqPxXhrydSno8HbW5Qi0pFxyQ=
X-Received: by 2002:a05:6122:d8b:b0:4f2:ea44:fd14 with SMTP id
 71dfb90a1353d-4fc6c5a3df5mr13868876e0c.2.1724081308101; Mon, 19 Aug 2024
 08:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240818114257.21456-1-dorjoychy111@gmail.com>
 <20240818114257.21456-5-dorjoychy111@gmail.com>
 <bffedf65-6046-4264-a2fe-011ff8c58860@amazon.com>
In-Reply-To: <bffedf65-6046-4264-a2fe-011ff8c58860@amazon.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 19 Aug 2024 21:28:21 +0600
Message-ID: <CAFfO_h6eSmizJuSwRSQ1+gzeVBfmsmrLiN0mCXYuQFXGaJ4_Vw@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] machine/nitro-enclave: Add built-in Nitro Secure
 Module device
To: Alexander Graf <graf@amazon.com>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, stefanha@redhat.com, 
 pbonzini@redhat.com, slp@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com, 
 berrange@redhat.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vk1-xa2f.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Hey Alex,

On Mon, Aug 19, 2024 at 4:13=E2=80=AFPM Alexander Graf <graf@amazon.com> wr=
ote:
>
> Hey Dorjoy,
>
> On 18.08.24 13:42, Dorjoy Chowdhury wrote:
> > AWS Nitro Enclaves have built-in Nitro Secure Module (NSM) device which
> > is used for stripped down TPM functionality like attestation. This comm=
it
> > adds the built-in NSM device in the nitro-enclave machine type.
> >
> > In Nitro Enclaves, all the PCRs start in a known zero state and the fir=
st
> > 16 PCRs are locked from boot and reserved. The PCR0, PCR1, PCR2 and PCR=
8
> > contain the SHA384 hashes related to the EIF file used to boot the
> > VM for validation.
> >
> > Some optional nitro-enclave machine options have been added:
> >      - 'id': Enclave identifier, reflected in the module-id of the NSM
> > device. If not provided, a default id will be set.
> >      - 'parent-role': Parent instance IAM role ARN, reflected in PCR3
> > of the NSM device.
> >      - 'parent-id': Parent instance identifier, reflected in PCR4 of th=
e
> > NSM device.
> >
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > ---
> >   crypto/meson.build              |   2 +-
> >   crypto/x509-utils.c             |  73 +++++++++++
>
>
> Can you please put this new API into its own patch file?
>
>
> >   hw/core/eif.c                   | 225 +++++++++++++++++++++++++++++--=
-
> >   hw/core/eif.h                   |   5 +-
>
>
> These changes to eif.c should ideally already be part of the patch that
> introduces eif.c (patch 1), no? In fact, do you think you can make the
> whole eif logic its own patch file?
>

Good point. I guess it should be possible if I have the virtio-nsm
device commit first and then add the machine/nitro-enclave commit with
full support with the devices. That will of course make the
machine/nitro-enclave commit larger. What do you think?

Regards,
Dorjoy

