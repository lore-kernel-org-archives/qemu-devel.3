Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5940D606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pC2JVv/A
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWBbS-0002pd-8E; Wed, 25 Nov 2026 06:55:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xWBbK-0002p0-PM
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:55:50 -0500
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xWBbJ-0007Fo-5M
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:55:50 -0500
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-3282db206d3so5587467eec.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:55:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795607744; cv=none;
 d=google.com; s=arc-20260327;
 b=m5Kn1JoI/zjNIcLcEztDb/qYCi1JpeB9qFiz+tqmNCJl3QI01t+7Snc0vDBRg+NnIf
 viriKkvTOUMOEuFBeNPmrRtNlcUw94qMuV6h7HYeT9rRGf91AASGofd/f85DC8xGbklc
 DMBPVGu+71qFikpu51DEprvxfXEIbwyNBXfDzWgfd0vKPY1qwwKtLf/7vTWmTmGvqLfB
 jg2S3rKuqMA8MmOXCBRO8EyxlIs33Twb1uHehejPq7q6yffvAtpocsDD1m8FVYgGcH8G
 lTMlK921THzbBHn12grBxZtTNbP0lB5w+rlC8m5Fwx18VTdx1GlVVq4a9vY2eA9JVUhj
 F3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bn+dO0n3bk+migXhjDAF6gZlaXEfYXlOJ4PYBUJygJA=;
 fh=SQBxbTsCFw5PmNdG123aODHkmhBo7PKmFA7+bzIBQT4=;
 b=Dqd1+SMV2NEFyW2QOmiAeLVt6JaLP/vBPZuY49tIrZGlfoql+dSTDZAVl+ntPtQ1hl
 aEYBi8amJkz/+edrw/nBwCYLsRDEL8NeyBbUlKhX4y3QRrJM9azL2M1Cn5CNEi7zLqjP
 MdcxxWXo6kfb3680zHAmZGWOKYStIdmHVObKg1wj/qvtwOLSeZc+TTavp0/XMp+mQwN5
 t+26bKBSUPeH9+AZ5spCEWVLWCM0Dj65CEPthnFCD8FawyYk+yFbtfiCVNoEt1DKrVs3
 sNp5W6DKy5YGTHfPxZ5Cn8jXSoHP3Vrs75//oTCMaWxp+e75Ocqi0OzjLb7VFzsUW/W0
 rkZg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795607744; x=1796212544; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bn+dO0n3bk+migXhjDAF6gZlaXEfYXlOJ4PYBUJygJA=;
 b=pC2JVv/A/6TVlPDdYF0n/KCsSjl59ddFbhlKYWQUDRMEtJ3VKFaBT4u8SAQTHgRJzD
 J959u0uGgDDuvku8fhUHeNn2PCdXjRg4Hyjhe1D6ekip4GUvl48V0smCzl9qd186JjlP
 EEv42nXqGWwesHe+Fv3+Z7AALm9CNFEq9+jvjDEeQEBP0wGC/oKA6aXhOEgiBj69mRw8
 RL0jhZ20vz5R3Y2+ekrP+8m+fRcfn6s36Evt9inSMpu6Q49X3Qiw9w1zvcqFx+Czfm4V
 /xBfq9zyOAzYS/ds01eDc7FwW9F0AE7kUJuF7vSSqUOWi0DWQ+FOSvmJzROoR0gVjFlb
 2wsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795607744; x=1796212544;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bn+dO0n3bk+migXhjDAF6gZlaXEfYXlOJ4PYBUJygJA=;
 b=L3vk2l20YXdrO+Ej+oQg1cJaC7+QvonrxWOfxV4D1bMHP7Ne2RnP6K271LqiWt5UM6
 Gz71sJh1ghYA91B10fHrCbpOozzh+tx62i6Mj3qgiKA4sXUQ565BC/o0Yd6BrtuMFVOQ
 TMc/I6wigpqKEvGIf3DNwXtiCUMkX58hh0N93wzuUvtDutuXple0cGwWMb/32KihaVMx
 VRhaCs5mJjfNVhXOX2XXDWSLNmzBipGO06OhXf6v8EkCzkwviwdnyJ80ITYbz1M21f8i
 Lps6U8W2n+TDb386wU6FpDugY7AF5krH8fLfvRn/KO9rDCPi95XPOivpS7IGzy+tW4Yj
 jAOg==
X-Gm-Message-State: APuU4Z+OlnnH35N2QynN2ItA8I6F0E6zh6GdCuZvwe3yB5PKioc3DdlX
 vd7I8txaUUBNqQLGPZ7FcGzUE42BeVQY4KeW1JaRUdf65HF+O6ptW1DcA/vr+wpQJu3nk/b6koX
 0QRV9znjDsA8JQDhAy0DOCCsVp+0BzmA=
X-Gm-Gg: AZFdTZcFNnY+l62MWh/Xq4XdiqTxiNbqqmYc07MyS4Y6cKMvK+3L5aRD3XohKCi3H0u
 P0R3OpuXhAPcoFPtyKQUX6oUavk+H4HjQSQeZikBHf9F/gKmC8yeEIMM/qQxRNU3/nPOopDX2S7
 zuCcaOFJ1zOmYGoJpWLOJr/mcIF9VTjgAx1vvdu8ZPzRSr7V3i/PIKll1bv5cCQI3UIuDZ/81p5
 m5GDDabQENisChNHJ2MgLHHPZjo69i0lV0XuQPJgOF9yE9gG//1MmNxbqwa8GSBmMNyXjR7HN84
 5yKvJjO+8pCY/Cu4TiZXvvoJ/m5Earnyl9frKdAh1V/DeRLu3Tv+c5ANMTCOH2h6x5Cpbs5dhMB
 QGrD1G02xblG4l3HREh74xrpNvTbrXNpdHCzm0BCbBGune6cbDOq0BhdamXTq+49FemZRtRP23D
 Fhhu/xf01lgMxs/A==
X-Received: by 2002:a05:7300:d108:b0:386:c6dd:2616 with SMTP id
 5a478bee46e88-386c6dd29ffmr3962730eec.41.1795607743913; Wed, 25 Nov 2026
 03:55:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261125115104.2002188-1-alex.bennee@linaro.org>
In-Reply-To: <20261125115104.2002188-1-alex.bennee@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 25 Nov 2026 15:55:32 +0400
X-Gm-Features: Aa3M54rk07xsLsdlidxDWWQ8gi28HlEhkgb1F9Kfd_RzWRsc-XMS6tNbt0p1LBM
Message-ID: <CAJ+F1C+KJXJvVAYchd3eWxDVCMW0UNYiGs92nssyDwwdJiicRw@mail.gmail.com>
Subject: Re: [RFC PATCH] docs/virtio: add note about virtio-gpu acceleration
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1333;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1333.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 3:52=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> 3d acceleration has a bunch of issues and is considered hard to secure
> in our current setup. As we have dropped it from the virtualisation
> use case lets call that out in the docs.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  docs/system/devices/virtio/virtio-gpu.rst | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/docs/system/devices/virtio/virtio-gpu.rst b/docs/system/devi=
ces/virtio/virtio-gpu.rst
> index d05f8cb8e3f..06e60ec6782 100644
> --- a/docs/system/devices/virtio/virtio-gpu.rst
> +++ b/docs/system/devices/virtio/virtio-gpu.rst
> @@ -29,6 +29,18 @@ host's GPU and for the best performance be able to rel=
iably share GPU
>  memory with the guest. Details of 3D acceleration requirements are
>  described in a further sections.
>
> +.. warning::
> +
> +   As 3D acceleration by its very nature involves giving the guest
> +   fairly complete access to a bus master processing unit in the host
> +   GPU we consider this outside the virtualisation use case with
> +   respect to security. You should only ever enable 3D acceleration
> +   with trusted guests. There is still the option of off-loading 3D
> +   acceleration to a separate process via :ref:`vhost_user_proto`
> +   depending on what guarantees that process can make and how well
> +   confined it can be if things go wrong.
> +
> +
>  QEMU virtio-gpu variants
>  ------------------------
>
> --
> 2.47.3
>
>


--=20
Marc-Andr=C3=A9 Lureau

