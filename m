Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA9FCA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDPB7-00033h-Nm; Sun, 04 Oct 2026 12:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xDPAq-00032r-3b
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:34:52 -0400
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xDPAo-0002Z7-Jj
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:34:51 -0400
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-351224e684dso976848eec.1
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 09:34:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791131688; cv=none;
 d=google.com; s=arc-20260327;
 b=h95ifNmvVRXXK4gV3EhaQEXvuq/5Efa1orbuuRNyx3DQGfmaCKzhaGZTlS/pAtQ0kt
 M1B16mhJZiunyd3T8f173ZZQebA2G5qkDuoshR0dJEoM6kczO1BCFjO1EYzxOsTmW5Hl
 SyZEdxoA4bziWjvZQZ9haTtCQn4q3bckruFYuIUVR8e6M6D9GHdhJzNWRffPKWk3jAnf
 dirLOoQ7noX9h8p/3XoCJR5qvrK9M3rg872J/MhHy6zeDHAegV0/ec8ucwZqBGvmK5m/
 i5fARQdvcAZpbyNYUnwrPXrY+q8O5fZj3yJGczjiqbFuvp+mGDX9swNf3abqYRRaz3Br
 BKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hLHS1k1QvrlGci2lKCRv5iLcHX/sRzWhLrBDWQEqBEA=;
 fh=9J/Gwyb/4zJKC8CPj6CIAWvqsyEhLveUFmTr6Q7ERwE=;
 b=Q1t5KJcHOoyLS1QiE2hHH9yzdev4m6MS2BUmf4xleqWbtAy+WaxKUxcpGP1o4m/QSQ
 m55QFqCVHXG+4NaQmHrzb/71fGfwA0WhJRiddiztR3AVd7zkgQbRwqPp1hFVq8ECq04p
 32r6qY2G8jadgNheJrdoltnyt3RfnWeqPX8arCa0db0a3KtezT/xi0+KrVhSdW0zgpy7
 dn3hR8kTiXwsbWl7dStCUS6s8HhXtTPtI98xa1OSNttcQ4f6MLuPcx2EElGKQknfYGNu
 p4eH7pL/P7UD2m5W6jrk3zpYAbDqzpYp0d8eXh+AbI0M27NfPJuHbXB0ZZcuGr9yHpoQ
 VPzQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791131688; x=1791736488; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hLHS1k1QvrlGci2lKCRv5iLcHX/sRzWhLrBDWQEqBEA=;
 b=sf6sCndKeAylfEqZIbsLfJVwfzdx5hBK9+FUqDL2fwhJ8a1ejVzTOEY8jQYU4iRLFo
 I7V0EgrPtJWhjIk7BmDp5qlODRHxgVGNlvy9aTeWmQA3e0Ayxsu/kOBJFTtD2l69++7t
 mK9aUPicNUOWmMH/fkkfKqAZMAzDC2GIrx/wKm1M9AGmcDVYJ0JKtHsj8zHILYsCtAUJ
 kn4sxV6HY0iz5DH11Ow7hSfD/JsCe1F3DnEuJm7Gwr96bNMojPyqqakj8ij5Xv+E6KIG
 2jWCcf42rh39rhsPmta0g0cQBFALHplSE86CtLlT8GHcQLmoWDAwZME3j0Rv2LV/fmyy
 tzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791131688; x=1791736488;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hLHS1k1QvrlGci2lKCRv5iLcHX/sRzWhLrBDWQEqBEA=;
 b=2zZPKb0qnAK75jIhnmvkoA7yjw5r322BqqXc45eylmB3XM+9xQmrV5O8SnXx2OTlSh
 faFLuP6RKkgM1+auN4qB2yFH2KDtG8bUOfvH/4yO+YNTeerWAQVyxGxMKPRxB6/qp7wZ
 zUnemRKJ5TMznUVjF4fEMQ821s7wLDL2HTZscFMo34ACM6MQ0Sk4cAlC0hmRBGEpjcTA
 UaghHwuN1gIdmE7pf3ajsR1CYnyYDEgBKS7XLZhgt1VLNFSzxI+dJuG9PXzAErVdJqvo
 hSXMumBs5NvHy+fAFWEBkpOgqyWjalzS0KufcpFF+D7eFnON5cpbasLy1dCBIuCPxma9
 DPOQ==
X-Gm-Message-State: AFq9FYJBPLByj2WZvwa1SzJyIHLucXbcgErimQ9k+0dDGof0wD7mfuL2
 GakGtItLvJnbQMi/OgMlB23RsGjbqKS0BuoIcg1qVIuoJzLyi7y47+jOd8iBjxhl1wQL3lc9aDR
 juNKkvUii9/apAHKRIiAAN2Bs30+NHX4=
X-Gm-Gg: AYBFou2eU3L3wLZJo4wZEBBOxi9OjduXzeXp/1HFI13dLcZrp2WJeu6AejQaErXto4o
 0StTmgSyCoDRWDmHUdkYd6jDo3QuTRdQO+iIm5nTrtxOjvcbNZ3Ew4dfnof14ceQwcRNyMBNzLx
 F0uP6poaKiF+mTHnxlkq651Gw6+c2Km+43o35jbBDAv506WtCaURnuMWXd5P4AvMLoNlOQ3UL6l
 iG2R1NEzwVZctAf8NQqUMtA2iIXJYlRq8dUtftWaGxb3SAIapbwepsQ44sQpUVNWPglezkpWdG0
 Jhlo9tayF4eKbq+JulzUjCYXwl+s/hgQUXwYSUt5/Bb7s6BLDNJeGStmEAO005U6EcWptpVhVH7
 MGex3aM3c1To=
X-Received: by 2002:a05:7300:6c84:b0:351:2fc9:3844 with SMTP id
 5a478bee46e88-3512fc943c0mr728106eec.33.1791131688209; Sun, 04 Oct 2026
 09:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20261004042722.6937-1-junjie.cao@linux.dev>
 <20261004042722.6937-3-junjie.cao@linux.dev>
In-Reply-To: <20261004042722.6937-3-junjie.cao@linux.dev>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 4 Oct 2026 20:34:36 +0400
X-Gm-Features: AclHuK-2ZRXajtpU2ObKchpdZDYQZgmaiMX4eYK5cbeyMGFPHHObolVjRFEHaBs
Message-ID: <CAJ+F1C+nphu4S_ZJhr7oKV=s3q8SK=OBFpK3JVV1Ovx8UH8EZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb-host: free configuration descriptors on error
 paths
To: Junjie Cao <junjie.cao@linux.dev>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, kraxel@redhat.com, 
 philmd@oss.qualcomm.com, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi

On Sun, Oct 4, 2026 at 4:11=E2=80=AFPM Junjie Cao <junjie.cao@linux.dev> wr=
ote:
>
> From: Junjie Cao <junjie.cao@intel.com>
>
> usb_host_ep_update() returns before freeing the active configuration
> descriptor when an endpoint address is invalid or duplicated.
> usb_host_claim_interfaces() also returns without freeing it when fewer
> interfaces can be claimed than the descriptor declares. Each failure
> leaves one descriptor allocated.
>
> Fixes: 2b2325ff64 ("use libusb for usb-host")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Although it's an opportunity to introduce g_auto support:
typedef struct libusb_config_descriptor libusb_config_descriptor;
G_DEFINE_AUTOPTR_CLEANUP_FUNC(libusb_config_descriptor,
                              libusb_free_config_descriptor)

Then declaration should become:
g_autoptr(libusb_config_descriptor) conf =3D NULL;

And we can drop free paths. Up to you if you want to make a v2


> ---
>  hw/usb/host-libusb.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
> index fd4a16ee8a..491302feb7 100644
> --- a/hw/usb/host-libusb.c
> +++ b/hw/usb/host-libusb.c
> @@ -921,12 +921,12 @@ static void usb_host_ep_update(USBHostDevice *s)
>              if (ep =3D=3D 0) {
>                  trace_usb_host_parse_error(s->bus_num, s->addr,
>                                             "invalid endpoint address");
> -                return;
> +                goto out;
>              }
>              if (usb_ep_get_type(udev, pid, ep) !=3D USB_ENDPOINT_XFER_IN=
VALID) {
>                  trace_usb_host_parse_error(s->bus_num, s->addr,
>                                             "duplicate endpoint address")=
;
> -                return;
> +                goto out;
>              }
>
>              trace_usb_host_parse_endpoint(s->bus_num, s->addr, ep,
> @@ -949,6 +949,7 @@ static void usb_host_ep_update(USBHostDevice *s)
>          }
>      }
>
> +out:
>      libusb_free_config_descriptor(conf);
>  }
>
> @@ -1375,6 +1376,7 @@ static int usb_host_claim_interfaces(USBHostDevice =
*s, int configuration)
>          }
>      }
>      if (claimed !=3D conf->bNumInterfaces) {
> +        libusb_free_config_descriptor(conf);
>          return USB_RET_STALL;
>      }
>
> --
> 2.43.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

