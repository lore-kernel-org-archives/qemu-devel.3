Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF6A606A332
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 18:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qbcDE5o5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU7Gv-0006F8-6r; Thu, 19 Nov 2026 13:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU7GI-00067Y-KY
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 13:53:38 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU7GH-0002WC-7S
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 13:53:34 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-67db89857abso247255d50.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 10:53:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795114412; cv=none;
 d=google.com; s=arc-20260327;
 b=O0FaYVaQjuoMdth7C1l0frmbR5XdaEoY71BXxd95DW8OpnPnwRoMFIlIA33DsXGFnB
 O2pSJZtGETt1p4HEgtx8T/MFAAJ7TjG21HscrBO8evZF5hGRc9pVsqj6nKOZKQMq+T/d
 /6BHeSjbyh9jpIzaeW1cm/mq6VGIsdadbiZQDW5hbxCEyNsrkGUpS/h15g2Lw1162nZO
 uFZW9Iax2sYk5hnbo87W+VvWsg6A/0mNauZJXGAsioJy4SVCcSEM7BQyjdhL45lHs82f
 iI+oRcK8h0FW9b0Xshwa03wm7hgj6QZSSJ9/gow9kXoWiniHZnm8majMApzG6bsXcI9h
 751Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ajw4sIZfpHSpZREWgGfqsqKrqHKvWjtpxRAhQEGR9kM=;
 fh=jis90ebI1LXbWlN2f/uPaYiR3/160S3+nBo5cgb+Jhw=;
 b=id5+BmY/KWXtrZ7qrwGzIGWYSfBYyXpJ281sZUvl4VtTTeV+/khMSYpP7kwTONUk83
 PwXRUfV+g8sBYE3oH+faN4k6n1kHchpdqrhkdrUeI/MNOss+tqkgTogvQHpM5uRCbkmM
 mSplR5PiMd85LUXQKVqej+0UqI8WwXV/LCpSdenFKFC2+cWvux2j3B/QMcZMa1sgqWqw
 zeYSRaAFUTAUxtz0XHHqLMZ5aea7w+ojBxD2mHk8r1LPKj6QPZR51F2LWmQzqIsfMGab
 vbbhEnlRqueEOc1rFKZMw0Q+rQrG4wiIKjETg/8/d+BxaN1xYqq9tgzPoSFoJ/ExXLT2
 WNdg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795114412; x=1795719212; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ajw4sIZfpHSpZREWgGfqsqKrqHKvWjtpxRAhQEGR9kM=;
 b=qbcDE5o5LkpfpmURjYjmr49to0sZFoXiNUBLuO5jhpJhLvS0Q8jnJp+Aimgsy94u9z
 MYdHJE9o0MCW4E2NKWSP434qvzwywHX/5f9bsFHaFSWUDRt/TyPJfw+PthjaqhFrSpLV
 wMxFCU6kT89RcxY5S4e8piavw0NEVKcbJ+Yk7RIw+CVLuzY90v9/JFL2WOTps5YSy9hR
 z/Ayf3IQRc/iPdQn7VUuV18ELEy6oWibZ773L/l0ub7ktyJgMXCfo7NOg5sz3xSxQnhZ
 08FnmK22lQckA/ZxPH0QqzYgn7RPTDskCrLn7LHCgRvPr/KrjEXtHfaZJvhZXs1dQPaA
 qaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795114412; x=1795719212;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ajw4sIZfpHSpZREWgGfqsqKrqHKvWjtpxRAhQEGR9kM=;
 b=CAny4hNNwHYyjLSml7Hg2qGYVykTd+YAod9/qWFQD8mAqAXnOSvn6/NdUadWBWJi8u
 yiEDnu/gsKAhxZM7d04hLDGijDTdA0PGhzQ8czVz6NE2OcwW4aYrP4WWMwSvcU51OZDU
 qzRPYfv2gK8paFB2Fa1ckNAzIpcJ6mnwFJBra+5d1sb9iSzA3Wy9d8loSSz0q4A0Wp1q
 zDEE0pOsbb/l48FW6oYUGH8mnWH/LkIhFoO4pq8QKkU7Ek5HAUNKvT8Vbf71gco+JzSt
 cMyyT+bNAE0F82Gg89Rok0XaZAHZZByWaDtkT2Cl3k/zW5xfiTI0YlWa50HuDeZalXqN
 QkIw==
X-Gm-Message-State: APuU4Z8asMUFNK4brQuBU5NmSU/2MUAMKonY5dlVl/7ylW2TX2YMt0zb
 wtuhxwd/tmcmFVl0KbS1shWeQZQ1mvPbbXgPQhl+PnkXqTDggcql57XYR4enOwMhqJW+Gs+C8HD
 fAr0+Ij7mB9qh3ENzTjpSHfz8rRLanrc/8omCyXBvFeMzG6xhT5P3vQE=
X-Gm-Gg: AZFdTZfyeh/hv9U4xnv0FXt63xrtmJ1yhS6/IIt6Y54HGqzLIspcwdHudYIO1wAyx+I
 p0ItSEnXoV11Sus5Rf6uJ01diubszM/lN8VJI0BdyvAuf6CX2qUN7kruW1EAR26Oy8+la82h4FZ
 UL8tcDFKcevKe5jrFXMzYZJTbf2ETKefaal0VrupvIBtvaTik/+sXySxz10CsrBqKw3ztyXxEsN
 5qEHteYrJ6bq9V0OKtXq/Ye3y1rPG6pvxZZwvxwgF6SY39zbgfK4+gfUmHgnSBUorFDXncpfyZ+
 ipLRaGzXvFqM4XoEL+NWIsdPDtLatfOJ/PQcyPQUAeINsbZkE3O+N40Zv5K5RBJuOtINQqydI3z
 ALlgu8dQqrbUNuR+5TpVm1x5ClqY2ta6/zpe992+5XbyvNDwoMoizK77Fk9A9shFZvpftSod93q
 jkbNfxdo0vhn8c8WgxRGU2
X-Received: by 2002:a05:690e:1686:b0:67b:bf6b:d9d7 with SMTP id
 956f58d0204a3-67df452af7fmr134593d50.153.1795114411757; Thu, 19 Nov 2026
 10:53:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAFEAcA-iAdTGc0M4ZV5LYXscVVj2oEr7FN+Ac=oBo2_oxuygzg@mail.gmail.com>
 <av8k8oiG8lRh5bVI@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAFEAcA_8EAke9-dk-2HfkQ5BJyuODtcSK+DUcmYKRSKgEf=Wnw@mail.gmail.com>
 <av9D4pVMM989xNcE@zhexu-thinkpadt14gen5.rmtcaon.csb>
In-Reply-To: <av9D4pVMM989xNcE@zhexu-thinkpadt14gen5.rmtcaon.csb>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Nov 2026 18:53:19 +0000
X-Gm-Features: AclHuK-MRRH_jueV-A24IeYMa3tUAnes0fe6_qUwD3kN161R9Wct0gs48_auIow
Message-ID: <CAFEAcA8UWw+CpaS8wyy0A_MSeXhJ3NzJGcLm-iHkzmw5t9Cd_w@mail.gmail.com>
Subject: Re: VMSTATE_VALIDATE failures on outbound migration
To: Peter Xu <peterx@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 at 18:45, Peter Xu <peterx@redhat.com> wrote:
> IMO we have multiple way to achieve the same thing without VALIDATE and
> without VMS_MUST_EXIST (where I plan to remove both).
>
> Firstly, just to say if we follow the security update on migration, we
> trust migration stream so we should have zero concern assuming the
> num_timers will be trusted and correct in the first place..

That just says that falling over on a corrupt migration stream
isn't a security issue; it's still a bug. We should have some way
to do the validation before using the data value.

> If we don't trust it like above we could have used num_timers in loading
> the VMSDs with vmstate_hpet_timer, rather than num_timers_save, which will
> guarantee no buffer overflow possible, then post_load_errp() checks the two
> integers finally.  Should be functionally the same but safer.
>
> Or, if we really cared, we can also make the UINT8 num_timers_save to be a
> STRUCT instead, holding only the UINT8 with a post_load_errp(), that'll do
> almost exactly what the existing code do too.

I don't think you can deal with the pcie_aer usage this way though,
can you ?

thanks
-- PMM

