Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65E9CCD193
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 04:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9yto-0006gR-45; Sat, 18 Oct 2025 00:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freddy77@gmail.com>)
 id 1v9yth-0006gA-QJ
 for qemu-devel@nongnu.org; Sat, 18 Oct 2025 00:50:30 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <freddy77@gmail.com>)
 id 1v9ytf-0000F3-5L
 for qemu-devel@nongnu.org; Sat, 18 Oct 2025 00:50:29 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-63e1c0fd7ddso1276110d50.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 21:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760763023; x=1761367823; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BIcKoM0w5d+FWz+9+3EWxNCBqPh+IYEG3nR6drWx/WA=;
 b=UqcSPkdRKf80u0CIq1wYcn7sh1R/+iXIVtCh4s2FyRkVUCHhGKGoKMt6N7BixnDlNm
 gD0rgGeXI/MWGokyP0sSCNvzi+RcEhy57CTnwpyvIubJT3QoYwIOwGq3vjuPrFPo2CV6
 aOPL6oxPrDtm4Px1aHXct2cY452mgUO9/6HTNGBYUBbMg5hPfitNGVPHP8YMy3FZAF4m
 SdmwVot1ZZBvaJrN8yhKrHzqW/1URG1sxOQdsnR9OvfUi19sQcsd/tMB+ljD3Ii6nS8R
 Pfd1OnMVV4Sh4lgCjHvEhGZLQmJRcSGD3Vg1sBM5lzt7u5rYSZ7zXGjhHFXw8PqrfwtP
 zJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760763023; x=1761367823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BIcKoM0w5d+FWz+9+3EWxNCBqPh+IYEG3nR6drWx/WA=;
 b=dLkcEiFoZV5kGZ4zDu3VAaES8dFYiw25Rmjp+B7SZcaygpOk+PP8GxAyQYoPxyyd4t
 HggAcJBDCaX2a4QeJIyl1A2ftdIxEbr4pEdy58dw6JWRH0drcNNr+X+kGHiLiZwY1Kkh
 7El99icTuloJlRIi2asF90aIIrLAaRwfUNKzuTFSD+jWYn1g0uoCxbbzaPjn94puKC4D
 gb13p1mJv2BECi+MZmvvByV44a20irSFJvnUpDJMfkoA1aM7/Tj8ff6+KKpt21CWD5sC
 jdL8aOO878p0ODPnUpJI/y3/NnQUJK7dJY8CwVPpC08JYlsyeTLYmWjs0nOniwtXlAA/
 GwQA==
X-Gm-Message-State: AOJu0YzVyaySgG24GqZa1pWklAMcJyUzmmrH6zRZYyY99o1cR9KLHGi+
 zEPF9gb3xqS1NMsbxkRsVCXpJcQg9KRDTq6Sq5v5GiRDe1qQlYUHdbCE4b3t2XMCNBbwPLdwCii
 aC9CgRlE5xtT5vE0ULAifjgn/pz+lOyU=
X-Gm-Gg: ASbGncvixJvD7eGvIQ1H84Li1HfK/j88NjXav7HAcclFDSnlGjQIXgB3RRPYg4sbS4L
 tqa3zveZXL1qu6UmE9AbhCcgaVbwwRyr+iVbS+42jy63nmTW8VJQ8OPw4Iy8gemFATtVyvmP/Z5
 Oj/SMro2yRfo1Y/TQJMT/iQWOXjo0JlP4XM2iksrHZlIEkWplf7yWxDri18xR3dIsafWUxp8RnX
 4ncvfDptLvPkrTqcdrOvm+geHovZziqm2Wg/d+Kc+y0/tKveOczdSkx0aDKDuWFdY6OfMA=
X-Google-Smtp-Source: AGHT+IEilvWbtCW5uBzm7QpX6iKYSCadhAVZKn4tREbb4azBJtfoTD7u65ot1ZeFv6sGpoaqvlRwGvnbmi4Mxk986C4=
X-Received: by 2002:a05:690e:2505:10b0:63c:efd6:c607 with SMTP id
 956f58d0204a3-63e160d904emr4363604d50.3.1760763023085; Fri, 17 Oct 2025
 21:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20251017155136.16540-1-roger.pau@citrix.com>
In-Reply-To: <20251017155136.16540-1-roger.pau@citrix.com>
From: Frediano Ziglio <freddy77@gmail.com>
Date: Sat, 18 Oct 2025 05:50:11 +0100
X-Gm-Features: AS18NWAhPCgMVZ6RyFOMVIDyG8JZlvyB7tbnYI4D_8IsK9EL7c2IPK05IjJcI0c
Message-ID: <CAHt6W4cpBv3JhzFJg1pMw+z04uo41po2+GwJW1NZG8PD816U9Q@mail.gmail.com>
Subject: Re: [PATCH] hw/xen: pass PCI domain to xc_physdev_map_pirq_msi()
To: Roger Pau Monne <roger.pau@citrix.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=freddy77@gmail.com; helo=mail-yx1-xb12a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Oct 17, 2025 at 4:52=E2=80=AFPM Roger Pau Monne <roger.pau@citrix.c=
om> wrote:
>
> It's currently impossible for passthrough devices on segment different th=
an
> 0 to work correctly, as the PCI domain is not provided to
> xc_physdev_map_pirq_msi(), and hence it's unconditionally assumed that al=
l
> devices are on segment 0.
>
> Adjust the call to xc_physdev_map_pirq_msi() to pass the PCI domain in th=
e
> high 16bits of the bus parameter.  On versions of Xen where this is not
> supported the passed segment will be ignored and assume to be 0, no worse

typo: assumed

> than the current state.
>
> Signed-off-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
> ---
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony PERARD <anthony@xenproject.org>
> Cc: Paul Durrant <paul@xen.org>
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Cc: xen-devel@lists.xenproject.org
> ---
>  hw/xen/xen_pt_msi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/xen/xen_pt_msi.c b/hw/xen/xen_pt_msi.c
> index e9ba17317aba..df15ccf0d030 100644
> --- a/hw/xen/xen_pt_msi.c
> +++ b/hw/xen/xen_pt_msi.c
> @@ -138,6 +138,7 @@ static int msi_msix_setup(XenPCIPassthroughState *s,
>          rc =3D xc_physdev_map_pirq_msi(xen_xc, xen_domid, XEN_PT_AUTO_AS=
SIGN,
>                                       ppirq, PCI_DEVFN(s->real_device.dev=
,
>                                                        s->real_device.fun=
c),
> +                                     ((uint32_t)s->real_device.domain <<=
 16) |
>                                       s->real_device.bus,
>                                       msix_entry, table_base);
>          if (rc) {

Reviewed-by: Frediano Ziglio <freddy77@gmail.com>

This was tested on a real machine.

Frediano

