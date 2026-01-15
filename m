Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2223ED46600
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 17:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgRG5-00070j-T4; Thu, 15 Jan 2026 12:35:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vgRG0-0006v8-QK
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 12:35:40 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vgRFy-0005sR-St
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 12:35:40 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b8707005183so194275166b.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 09:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768498532; x=1769103332; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2CTSgwHK1pN46ABhNv2DVVEMgriDuCcuXt4wWbMY2RU=;
 b=VKHCwRUS+1Ys0fgwbGIOMFdbmBY0mqdNolSWhrOd7P1NJGTVSAtwKCUq6wHIqF5dxP
 wH8ftno8BT5ipKz3qMGT6aU9pepcQgAvM8mn6GMM2N9rfY6yNUVSoQANvzJqx2+wjM7G
 SzcMZiCNcV2Cx0UDVv7sB1eDuzLQT/vYRHZQf3kvHJjY0FXC2U6IKQRrpVJTz7Ovxwp8
 NnR+2eA7LY4FNwRRD0NQXLcCMteQyWu2M6ksKsIcIG1wn3pV5Ic2EsvMC2huZ2gJ/jVh
 juJtQmLS22NguOp3CPW7u/N1lUsJXAybMWbVlq2hhFTJoWU+PvSaDbsUABr3sSkX2Ynp
 GA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768498532; x=1769103332;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2CTSgwHK1pN46ABhNv2DVVEMgriDuCcuXt4wWbMY2RU=;
 b=t9H+CReRUchjs1F49Bh2JXpFXQPQ9ELKWVj8cG2bwtIkS5cIIRopZRcoagoEhCyqri
 RC3fj2mNLM2P2ziheRF2zzE0mvFoV17LsLvcS8/GoWtUeWa2zEfcBW2Baxj5nomFFAwT
 2ctkZ+izIrz4Rq953hj5/Z+kWOrMf01f1rhQ11SnmNt2vvS+JNEKBq5RBHfXiHefcKyW
 w4k85a4W97EGWPJo9bqqUOVe9m2k7mYOnzOPyKwBfhihinRE2+EgcWQKWhPcGMXJzsM3
 tmlyL3WGoR4KGiithMKkZq12EcsI8mDvoO6zU6AokBnbrHQkdB6y/e8CQrWVnGdYyazr
 NNkQ==
X-Gm-Message-State: AOJu0YyK48yMJCDoE0QgavDVsdx5tT4C/LIsNHYaw7RRC/JxlmpeScAE
 KPp0zitYZc5uP3d3j9xjwJMrdZvcbI4wrIjESE4NPfPmzVmk5HYl4IbSIED4hLFdAJrGf0scVMg
 qoraFZAQvwMx45ErxKzk35zIYUzAmwag=
X-Gm-Gg: AY/fxX4xlUHv+sVaBifPRrk7kr81rxylhunqS/5zQ1Vv7IukCJCVr+8BH3WmaiFpiH4
 lWk3zJj4CRFSo6SuOb8U8JHlIj0AaoZVzVnL9pKT6aMGvapata75DkpVhtUESBRnCUQ/qQUy/e/
 wKcyzxvdmUnXrHq11uc5FfqpPro6yoVGWR3+7sbnenFuVVn+NUBo4PKB4afVj4akGuv9fJWPCoK
 2fBzSnTEzN+sBRLcR16cc1F1Jl04qGHNuP0dowdMFGocnKPeRpQF0wfGOgFCqP9Z162gSytPpj4
 kWfTgMw=
X-Received: by 2002:a17:907:981:b0:b83:95c8:15d0 with SMTP id
 a640c23a62f3a-b879327f182mr33565066b.52.1768498532140; Thu, 15 Jan 2026
 09:35:32 -0800 (PST)
MIME-Version: 1.0
References: <20260115142629.665319-1-peter.maydell@linaro.org>
 <20260115142629.665319-5-peter.maydell@linaro.org>
In-Reply-To: <20260115142629.665319-5-peter.maydell@linaro.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 16 Jan 2026 01:34:53 +0800
X-Gm-Features: AZwV_QiF8k8mQIZEZBL4PgWP1WK8Pxs2TlbKuero8W9HnFebEb-VTihsWBmEUio
Message-ID: <CAK3tnv+hyxE77kw4VAS8BD=5qGLs7hYusEh9hTmVX1MfZcrkWA@mail.gmail.com>
Subject: Re: [PATCH 4/4] qemu-options.hx: Improve formatting in colo-compare
 docs
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Li Zhijian <lizhijian@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x635.google.com
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

On Thu, Jan 15, 2026 at 10:26=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> The colo-compare option documentation has some formatting issues: it
> uses a "@var{...}" syntax which is not used elsewhere and which is
> rendered literally into the HTML documentation.  The bare "@" sign
> also results in an unintended 'mailto:' hyperlink.
>
> Rewrite this into the style we seem to use most in the rest of
> the command line options, where an option which takes an argument
> is written as "my-option=3D<thing>".
>
> We take the opportunity to make the documentation a little clearer
> by splitting up the long paragraph and using preformatted-text
> markup for the names of the suboptions.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> As I don't know anything about colo-compare, I may have
> accidentally introduced errors here; please check.

The format is more readable, LGTM.
Reviewed-by: Zhang Chen <zhangckid@gmail.com>

> ---
>  qemu-options.hx | 41 +++++++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 16 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index aca9dba8b9..3883afb484 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -5972,22 +5972,31 @@ SRST
>          stored. The file format is libpcap, so it can be analyzed with
>          tools such as tcpdump or Wireshark.
>
> -    ``-object colo-compare,id=3Did,primary_in=3Dchardevid,secondary_in=
=3Dchardevid,outdev=3Dchardevid,iothread=3Did[,vnet_hdr_support][,notify_de=
v=3Did][,compare_timeout=3D@var{ms}][,expired_scan_cycle=3D@var{ms}][,max_q=
ueue_size=3D@var{size}]``
> -        Colo-compare gets packet from primary\_in chardevid and
> -        secondary\_in, then compare whether the payload of primary packe=
t
> -        and secondary packet are the same. If same, it will output
> -        primary packet to out\_dev, else it will notify COLO-framework t=
o do
> -        checkpoint and send primary packet to out\_dev. In order to
> -        improve efficiency, we need to put the task of comparison in
> -        another iothread. If it has the vnet\_hdr\_support flag,
> -        colo compare will send/recv packet with vnet\_hdr\_len.
> -        The compare\_timeout=3D@var{ms} determines the maximum time of t=
he
> -        colo-compare hold the packet. The expired\_scan\_cycle=3D@var{ms=
}
> -        is to set the period of scanning expired primary node network pa=
ckets.
> -        The max\_queue\_size=3D@var{size} is to set the max compare queu=
e
> -        size depend on user environment.
> -        If user want to use Xen COLO, need to add the notify\_dev to
> -        notify Xen colo-frame to do checkpoint.
> +    ``-object colo-compare,id=3D<id>,primary_in=3D<chardevid>,secondary_=
in=3D<chardevid>,outdev=3D<chardevid>,iothread=3D<id>[,vnet_hdr_support][,n=
otify_dev=3D<id>][,compare_timeout=3D<time_ms>][,expired_scan_cycle=3D<time=
_ms>][,max_queue_size=3D<maxsize>]``
> +        Colo-compare gets packets from the chardev backends specified by
> +        ``primary_in`` and ``secondary_in``, and compares whether the pa=
yloads
> +        of the primary packet and the secondary packet are the same.
> +        If they match, it will output the primary packet to the chardev
> +        backend specified by ``outdev``; otherwise it will notify COLO-f=
ramework
> +        to do a checkpoint and send the primary packet to ``outdev``.
> +
> +        In order to improve efficiency, we need to put the task of compa=
rison in
> +        another iothread; the ``iothread`` option specifies that iothrea=
d object
> +        (which your commandline should create).
> +
> +        The ``vnet_hdr_support`` flag tells
> +        colo compare to pass the vnet header length when it sends and re=
ceives packets.
> +
> +        The ``compare_timeout`` option sets the maximum time that
> +        colo-compare will hold the packet for, in ms.
> +
> +        The ``expired_scan_cycle`` option sets the period of scanning ex=
pired
> +        primary node network packets, in ms.
> +
> +        The ``max_queue_size`` option sets the max compare queue size.
> +
> +        If you want to use Xen COLO, you need to specify ``notify_dev`` =
to
> +        tell colo-compare how to notify Xen colo-frame to do a checkpoin=
t.
>
>          COLO-compare must be used with the help of filter-mirror,
>          filter-redirector and filter-rewriter.
> --
> 2.47.3
>

