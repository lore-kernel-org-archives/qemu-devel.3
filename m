Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0169AC47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 07:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rULwC-0000C5-4Z; Mon, 29 Jan 2024 02:20:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rULw0-0000BI-HF
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 02:20:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rULvx-0006Af-QO
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 02:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706512795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=He/wCGnhrhk+tilklckNJZ0qQj+M/ebV1MNUWGWbIr4=;
 b=EqKURuOxvT1nstU0o/zlLLp4t3M4HTw8tJDbaqBp2687c3rus5JQ+pfVrupRoRaYwJo8RY
 smIb0fnul6CtG8P0Y1247EvRqDX8Xvu4chY5gJ/GqW5R9QYkFyN4Ry6SzmKbneM5cAajsi
 CJh7eUarf3HYP2ibavNTW0u4GA2nQFc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-6mfvLS-XMMKaDlwzWmLNSQ-1; Mon, 29 Jan 2024 02:19:52 -0500
X-MC-Unique: 6mfvLS-XMMKaDlwzWmLNSQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-558fe4c0c46so1417978a12.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jan 2024 23:19:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706512791; x=1707117591;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=He/wCGnhrhk+tilklckNJZ0qQj+M/ebV1MNUWGWbIr4=;
 b=HlyGEnPFmEhDANI1lS7ZVZBPwf52DRKonVsTKf+3Ymzt1oo6FqRREr0YfeIdPXiZZX
 wsrKmP2zxOyRudyjrl3M0Z+SBIO7Ql32tHOWCbcjOz0maO7m8cvPOiik+jyMrUmtrfdf
 Yz4/y0p0cGGGqaoz2Awxe+CE8Xwyr49YTuqfEmu8JftM14arMIB/OA0tTCi/tR7rE23n
 nSiQaxwffati0d7n11pgBxEl4lmOzCDtKt+FF1Mc/kNB7z56eYxq2nkP1j2C3H+Hgu40
 NaUL8ZUHJHTZMa5NHrzxTYRCV+wquKampHgCY6iWWJKCYZWFpEp5bN/FeTtqyw+psPEg
 LB5A==
X-Gm-Message-State: AOJu0Yz5gyQx7g4fzhV/rlVAYJtBdKqbeKOmV6HCupTpb7K94rNJWtiE
 IV22ulr1TKt6KgGVl/CDHgQrcrwlQDlSNPxsDKBIcvted2s2BKTWQJG1QCNnHRV4CR4tvjRwf5l
 klAYVAy/jTYu9s8zPolCGNfXt3/WHZb9a1NTqGBIwu11cWtOIPSnKX2f1IDzqeiiIa3LcTaeGYh
 +GL3yGJEpOqP1rWKeUZOh5D8jsb3M=
X-Received: by 2002:a05:6402:615:b0:55f:1656:b918 with SMTP id
 n21-20020a056402061500b0055f1656b918mr274725edv.14.1706512791685; 
 Sun, 28 Jan 2024 23:19:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+eCDQU+1Vl3T84KD0M4s0ERPXHdW3WSh19isgsKaJE6jGVXgax+fKX/V6fnqgrXQ3+9Z1BbwSQ3tjvEyQgzU=
X-Received: by 2002:a05:6402:615:b0:55f:1656:b918 with SMTP id
 n21-20020a056402061500b0055f1656b918mr274714edv.14.1706512791391; Sun, 28 Jan
 2024 23:19:51 -0800 (PST)
MIME-Version: 1.0
References: <20240127215253.227583-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20240127215253.227583-1-dmitry.osipenko@collabora.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 29 Jan 2024 11:19:39 +0400
Message-ID: <CAMxuvaxs24TUJuuR9EfG-keFhyUq8m8vLZRU8RossJAJOZUEzA@mail.gmail.com>
Subject: Re: [PATCH v1] virtio-gpu: Correct virgl_renderer_resource_get_info()
 error check
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sun, Jan 28, 2024 at 2:10=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> virgl_renderer_resource_get_info() returns errno and not -1 on error.
> Correct the return-value check.
>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Can you also correct the code in vhost-user-gpu ?

> ---
>  hw/display/virtio-gpu-virgl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
> index 8bb7a2c21fe7..9f34d0e6619c 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -181,7 +181,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
>          memset(&info, 0, sizeof(info));
>          ret =3D virgl_renderer_resource_get_info(ss.resource_id, &info);
>  #endif
> -        if (ret =3D=3D -1) {
> +        if (ret) {
>              qemu_log_mask(LOG_GUEST_ERROR,
>                            "%s: illegal resource specified %d\n",
>                            __func__, ss.resource_id);
> --
> 2.43.0
>


