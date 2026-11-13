Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4419606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 07:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KBuxtZ99;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=iamXQ/Gr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRlpb-0003ZC-KE; Fri, 13 Nov 2026 02:36:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xRlpZ-0003Yk-Ug
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 02:36:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xRlpY-0007cM-BL
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 02:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794555375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HoGZsJg/ryuecJNWLgDwwahIn0Lsi8Fq4wyXUT25d88=;
 b=KBuxtZ99eP1qZrDtoaO3o3cX0gXinHCfLoVnpzS33wAonFDH08pSRK6lFPHp7AqwDeCd+B
 zWD1ofQVIz8gt17pDajP5Mfn35Z0ojiQTM9X+nOD4fEc/SwXRpaptciilkLOfaUQbhhriw
 cIxCVR2SSq2p5wsvfUsdOXMvQHH0ozM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-k5r8LIJRMYGStRE984GRvw-1; Fri, 13 Nov 2026 02:36:13 -0500
X-MC-Unique: k5r8LIJRMYGStRE984GRvw-1
X-Mimecast-MFC-AGG-ID: k5r8LIJRMYGStRE984GRvw_1794555373
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cdb061cc4dbso1106036a12.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 23:36:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794555373; cv=none;
 d=google.com; s=arc-20260327;
 b=Yh8G66WpYg0s5zDcBFzDTwBawxoA4JP2dc3biOmFwcycou1xXOMcH80hC0DlQyRxbT
 E60Oy1H5Bv8pSyaQKuqo0cfEbt6q1EZnzf+d6e5ReItiWG45tFjrC+B1gLmSQs/eYRwp
 FGXTBNgqWYPYgfnrBxUzHAEpanmXTHJ+Ql8WSaz0fSyGjDV1na4DJhxL3iJB7joijMlO
 Y80JgOcuviIPDHyTourfKCUdyo/HH8Ec8KRU6z+QWyn8TJv0C4W40nncmqwjUhPQQZeE
 +LB1iKoR/H0zgJXw+gupzxVzwsxij1tZXh22VLXHz32pY8tyQ2jBFyeflNAj4P87vY1Z
 srbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HoGZsJg/ryuecJNWLgDwwahIn0Lsi8Fq4wyXUT25d88=;
 fh=bGNjJeNp6YEvkK1CrL0MiDDS4u1TwQ3xZ1qChefrrso=;
 b=goMuKdn2clNHO/BLtE0mSCJkGtCsHgBkPpDQLSvA5p+T8jlFoJfPzVge+2kpfJnNIX
 6nZo8lIjoHB11l3oXiJ9ZnpfZ3MH/8qczlvFgeo/zNmSh6vPJ74ZzIKniApxE8NtGXPP
 P85+C/NqfhwfwdkJEq8yATDqYahBYZ0+xw27jY7+weg2HpyN1i/dAtxzm032XdQn02Ui
 wXzvNCZ1UCAtxQPMnexKMhc7amc3f77gAl7J4R+Wu2zw6LPA+scq7G2VYZQ5rQy6MJgu
 r/cp/SX9G4xB5G6ghNUWiEsQWG4+QdZFNBAvnvCd08KGOMIhdijdhshkK0GVoI5iako8
 HzgQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794555373; x=1795160173; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HoGZsJg/ryuecJNWLgDwwahIn0Lsi8Fq4wyXUT25d88=;
 b=iamXQ/GrW0x3qkj5Zsc3J6GvWkr3oYFC3gV7bzgwI6fQp0idLoF16wh/5TUyobD7KX
 d+wJft93nQacmJli4cB+j7oopgib2fFXDEi+e0NKteBSiPhNHowXJ9fXT4zNcNcolv+P
 UxN4HSExK74GGyJwKW60X52zFYY7blgXs/HmtYy2PdIPUwDthHnrTMM2l5kre/Zbxfnt
 KaZr9/o3ICN5E2YVkEIPOjcybNdWV+K21szroplumieJTXtAP1GW3PDzHgil1W7695gj
 C+c55+oMn6wvIjcX/EEHByGJ/nFIfjJxjFATVN/T/Cl6gNdiDrIG5tJEPioOPT3jvHX+
 6Y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794555373; x=1795160173;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HoGZsJg/ryuecJNWLgDwwahIn0Lsi8Fq4wyXUT25d88=;
 b=J9jWfss8ni9EBBDJYWU7Sa5CEhT245bCqAVfEaVPTs238zqyPjNWYjBmIOWDAMEOCw
 KcUp1i0n8yIzmG0/trWaDfyRQbRTBC4+v2AreAtXGanekl6FldmG1zHdtqNChwyEgk0m
 95daiR0fCBfSjOc5VNDRZ61n+2my0Bgv0FAM4pEYcnflqbUXbLpxLYzLG8QsZdzT5Oj0
 w+r+AHN9UqEtrSbuZIPDu94hJBQUx4viBEgHn8Hx6A3BMWsAF0hcGiOvcNwNrwH986kg
 fcZAEYbp0ps/l7xAytwvcGXyAn9ZX8h9Q6ReUR/DxphHueKGO9j0gWsJ5OITCHqr4DJJ
 uLUA==
X-Gm-Message-State: APuU4Z/c3HJcv/bFIuVCpovC5JSsgbwpQRwciWkZobx5Fl2gTqmt1DPa
 NwlKV34pHNuDSmKULmL2K6FYsW0obgTRzA0yN2x818u/vFhhNNOhcnnXMtcC1NAKAnG39FHS5xJ
 pfbBaaKGGBz8n1slLFa02tTj9JlsSBl8jx3A2z/v4yVmOAJSp3ljakpcHua+HoVQRvWWwvJKTWn
 acJPgUJ+hffvwXfTbEzJ+B22teX2S90SE=
X-Gm-Gg: AYBFou1rPjKrUkWy66/exB/ckyEELH5LJ0YTbpV4rrneKIFT9bg1SbsbxKUdt5i2QZd
 /qm+PKgiNQhjgzUVWcOZlSiB8xBmzO1/cxbvpIZABCaZriS94U5HHCC6yPJbmsiXRwWYABqfut4
 7T7yrcT58O4MnHRsHqKQLINMPjltgLFtILPUtHXEFqwaWg44xY7/iukX+TnESgSOH3SSJejWQZ4
 A4Vwf6xsTExRDpqQVErMSTdt56FvbdQTGT1T1tpeIF6Otr0L6+bc9G2qezR/YcFPs6UV3ORC0ji
 NA==
X-Received: by 2002:a17:903:1850:b0:2d8:d4d2:d136 with SMTP id
 d9443c01a7336-2edf1f0c3abmr34500085ad.18.1794555372690; 
 Thu, 12 Nov 2026 23:36:12 -0800 (PST)
X-Received: by 2002:a17:903:1850:b0:2d8:d4d2:d136 with SMTP id
 d9443c01a7336-2edf1f0c3abmr34499885ad.18.1794555372174; Thu, 12 Nov 2026
 23:36:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112164857.2083799-1-berrange@redhat.com>
 <20261112164857.2083799-3-berrange@redhat.com>
In-Reply-To: <20261112164857.2083799-3-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Nov 2026 11:36:00 +0400
X-Gm-Features: AclHuK8BR2TTacF-LN5YzCUVgtIDviWc5-S83elLAnjJKf12yJ51vsjACa6Ha9M
Message-ID: <CAMxuvaxU9j0XD_uWpixGicL29gvKm+M6EUVFmNDr1hxhzPvkqw@mail.gmail.com>
Subject: Re: [PATCH 2/2] qapi: correctly mark 'ignore-unavailable' deprecated
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 8:49=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> Follow the proper QAPI syntax for deprecations and mention it
> in the documentation.
>
> Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  docs/about/deprecated.rst |  8 ++++++++
>  qapi/trace.json           | 10 ++++++++--
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 0891bbc44de..a39feb23f5b 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -182,6 +182,14 @@ execution.  This special treatment of ``"no"`` is de=
precated.  Use an
>  empty string instead.  In a future version, ``"no"`` will be treated as
>  a plain file name.
>
> +``ignore-unavailable`` in ``trace-event-set-state`` (since 11.2)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +Trace events are now unconditionally built-in to all QEMU builds,
> +so the concept of an 'unavailable' trace event no longer exists.
> +The ``ignore-unavailable`` parameter in ``trace-event-set-state``
> +thus has no effect and should no longer be used.
> +
>  Human Machine Protocol (HMP) commands
>  -------------------------------------
>
> diff --git a/qapi/trace.json b/qapi/trace.json
> index 8533e378977..5792a436115 100644
> --- a/qapi/trace.json
> +++ b/qapi/trace.json
> @@ -67,10 +67,14 @@
>  # @enable: Whether to enable tracing.
>  #
>  # @ignore-unavailable: Do not match unavailable events with @name.
> -#      Deprecated: since 11.2
>  #
>  # Since: 2.2
>  #
> +# Features:
> +#
> +# @deprecated: @ignore-unavailable no longer has any effect
> +#    (since 11.2)
> +#
>  # .. qmp-example::
>  #
>  #     -> { "execute": "trace-event-set-state",
> @@ -78,4 +82,6 @@
>  #     <- { "return": {} }
>  ##
>  { 'command': 'trace-event-set-state',
> -  'data': {'name': 'str', 'enable': 'bool', '*ignore-unavailable': 'bool=
' } }
> +  'data': {'name': 'str', 'enable': 'bool',
> +           '*ignore-unavailable': { 'type': 'bool',
> +                                    'features': ['deprecated'] } } }
> --
> 2.56.1
>


