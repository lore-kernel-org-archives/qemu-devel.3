Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BDBCCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 13:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBCVb-0005MJ-EC; Tue, 21 Oct 2025 09:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vBCVI-0005KU-AX
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:34:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vBCMr-0003TQ-4t
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761053072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Si5sYidSgOyKOBouiuY7SuAOZNYUofTTfdg+V1lFVA=;
 b=TMM4w4cnjV1q/Ph831wZ8GbnOgTwhqxjUI5KrZobZ2mY4a+TBtTbvbv2/CW9iIE2aMOVCh
 09OIu2D+WpBuPTIDObFvkf/nEIUlNnKRfYz70qxGdSXOJr9uEK7u+U+YoTAK/SKdrrpa+X
 jLGBWL2dyABB88nEDX74+MBeqRO46o8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-rW_Wfn15N3qKHhqU9kUjxA-1; Tue, 21 Oct 2025 09:24:30 -0400
X-MC-Unique: rW_Wfn15N3qKHhqU9kUjxA-1
X-Mimecast-MFC-AGG-ID: rW_Wfn15N3qKHhqU9kUjxA_1761053070
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-32eb18b5659so4594329a91.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 06:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761053070; x=1761657870;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Si5sYidSgOyKOBouiuY7SuAOZNYUofTTfdg+V1lFVA=;
 b=JZWVIewO2CidmBYrMOVe9H2bGnlD12ZH5X3g8iapBfQ+fw0nqueuXV+uUrbFHPks2C
 v9QWfSzjjnmWGm+jTJ0CZQwuBOceA1N1zLobKLoa4zRH794/xIGTSRLAIJYD0bpqZGNl
 dm/MOBnUmYH3kywp5hMbByfRNDidWZ8qEHXrqBpbWXau967vgoZ6ayo7xZD4aEcCxyVs
 gcbT3J+yLxSDaSW8Pe8714Rcy+rTKmFCRJr+hJUkipg6SEwCcBFGTP9K+ysJebP88nPV
 C3PMEtiCnC0Q9x23pmuwD+l/3rbYjCQj/s743diaXPIAE/98jGGZA6oUgeqnWBG0N5iZ
 5zrg==
X-Gm-Message-State: AOJu0YzxICTIxREpR56WjY55oeNZCARYQz5EfpoYUuLL1+yDNGh0NN51
 yiEbnSseV8BiRCn8QN2MHYIsXiiteMjuyA9uYBTGTYCh2pkCukRybVOJFy65fCRKXkFp3m7iAZF
 lDQtHDjXRmYCUAEK1ZOBNl24fS0mFsVC/2ot+czauU0uCrbjGiWc61ccnMO+udT1RpdGj6rEVOH
 +WN6d2KvAwXn1aEdaBwCWJ0GUxhQsfGMM=
X-Gm-Gg: ASbGnctEVHgcxSjqrFSi0iOLhRUf5X6EErCzmJFY7dTQ05IOjmrJ6e98iINLHpUBXni
 QeCnXEloIojSj1tfoCLneIFMlJezPI2Pve/K4Ln/N4LzHR+7HqS2+wLMKJZWUuzgZoewpchlBRO
 KQ3gYoS/VFwVih/ISh7vv/GsIBpDpon5YjqRGXx7QNjjWESc/YFT0GxJZhCiN79Sa75MojCrUzr
 oqECIZRLu6FCso=
X-Received: by 2002:a17:90b:2247:b0:32d:e780:e9d5 with SMTP id
 98e67ed59e1d1-33bcf8e5f10mr22942549a91.22.1761053069701; 
 Tue, 21 Oct 2025 06:24:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjruiiry2LGiHfcxlt27mMcM64Ks/i97oK3sHlL0fdGtbn03/sckYUFou/CukjfoQKFP0uZaKhEwOhVj+Sci8=
X-Received: by 2002:a17:90b:2247:b0:32d:e780:e9d5 with SMTP id
 98e67ed59e1d1-33bcf8e5f10mr22942513a91.22.1761053069208; Tue, 21 Oct 2025
 06:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20251021131825.99390-1-philmd@linaro.org>
 <20251021131825.99390-3-philmd@linaro.org>
In-Reply-To: <20251021131825.99390-3-philmd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Oct 2025 17:24:17 +0400
X-Gm-Features: AS18NWAoNFkYA9Hgr0kpbLrC_Ug-MAkyG2rDc_3UcOCr-QjzohF2rYwlCjbmaVM
Message-ID: <CAMxuvaxTYZTzWr85io2whE+soM8Ji58uV-BbfE8B9kpLzdFMwA@mail.gmail.com>
Subject: Re: [PATCH 2/3] hw/audio: Remove intel_hda_and_codec_init()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009f081f0641ab1e8b"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000009f081f0641ab1e8b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Oct 21, 2025 at 5:18=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> `-soundhw hda` was removed in commit 039a68373c4 ("introduce -audio
> as a replacement for -soundhw").
>
>
Sorry, that "hda" (=3D intel-hda + hda-duplex) short form is used by -audio=
.


> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/audio/intel-hda.c | 23 -----------------------
>  1 file changed, 23 deletions(-)
>
> diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
> index 0d35afa4ab4..83bb7e597db 100644
> --- a/hw/audio/intel-hda.c
> +++ b/hw/audio/intel-hda.c
> @@ -1301,28 +1301,6 @@ static const TypeInfo hda_codec_device_type_info =
=3D {
>      .class_init =3D hda_codec_device_class_init,
>  };
>
> -/*
> - * create intel hda controller with codec attached to it,
> - * so '-soundhw hda' works.
> - */
> -static int intel_hda_and_codec_init(const char *audiodev)
> -{
> -    g_autoptr(QDict) props =3D qdict_new();
> -    DeviceState *intel_hda, *codec;
> -    BusState *hdabus;
> -
> -    qdict_put_str(props, "driver", "intel-hda");
> -    intel_hda =3D qdev_device_add_from_qdict(props, false, &error_fatal)=
;
> -    hdabus =3D QLIST_FIRST(&intel_hda->child_bus);
> -
> -    codec =3D qdev_new("hda-duplex");
> -    qdev_prop_set_string(codec, "audiodev", audiodev);
> -    qdev_realize_and_unref(codec, hdabus, &error_fatal);
> -    object_unref(intel_hda);
> -
> -    return 0;
> -}
> -
>  static void intel_hda_register_types(void)
>  {
>      type_register_static(&hda_codec_bus_info);
> @@ -1330,7 +1308,6 @@ static void intel_hda_register_types(void)
>      type_register_static(&intel_hda_info_ich6);
>      type_register_static(&intel_hda_info_ich9);
>      type_register_static(&hda_codec_device_type_info);
> -    audio_register_model_with_cb("hda", "Intel HD Audio",
> intel_hda_and_codec_init);
>  }
>
>  type_init(intel_hda_register_types)
> --
> 2.51.0
>
>

--0000000000009f081f0641ab1e8b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 21, 2=
025 at 5:18=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:ph=
ilmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">`-soundhw hda` was removed in commit 039a=
68373c4 (&quot;introduce -audio<br>
as a replacement for -soundhw&quot;).<br>
<br></blockquote><div><br></div><div>Sorry, that &quot;hda&quot; (=3D intel=
-hda=C2=A0+ hda-duplex)=C2=A0short form is used by -audio.</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0hw/audio/intel-hda.c | 23 -----------------------<br>
=C2=A01 file changed, 23 deletions(-)<br>
<br>
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c<br>
index 0d35afa4ab4..83bb7e597db 100644<br>
--- a/hw/audio/intel-hda.c<br>
+++ b/hw/audio/intel-hda.c<br>
@@ -1301,28 +1301,6 @@ static const TypeInfo hda_codec_device_type_info =3D=
 {<br>
=C2=A0 =C2=A0 =C2=A0.class_init =3D hda_codec_device_class_init,<br>
=C2=A0};<br>
<br>
-/*<br>
- * create intel hda controller with codec attached to it,<br>
- * so &#39;-soundhw hda&#39; works.<br>
- */<br>
-static int intel_hda_and_codec_init(const char *audiodev)<br>
-{<br>
-=C2=A0 =C2=A0 g_autoptr(QDict) props =3D qdict_new();<br>
-=C2=A0 =C2=A0 DeviceState *intel_hda, *codec;<br>
-=C2=A0 =C2=A0 BusState *hdabus;<br>
-<br>
-=C2=A0 =C2=A0 qdict_put_str(props, &quot;driver&quot;, &quot;intel-hda&quo=
t;);<br>
-=C2=A0 =C2=A0 intel_hda =3D qdev_device_add_from_qdict(props, false, &amp;=
error_fatal);<br>
-=C2=A0 =C2=A0 hdabus =3D QLIST_FIRST(&amp;intel_hda-&gt;child_bus);<br>
-<br>
-=C2=A0 =C2=A0 codec =3D qdev_new(&quot;hda-duplex&quot;);<br>
-=C2=A0 =C2=A0 qdev_prop_set_string(codec, &quot;audiodev&quot;, audiodev);=
<br>
-=C2=A0 =C2=A0 qdev_realize_and_unref(codec, hdabus, &amp;error_fatal);<br>
-=C2=A0 =C2=A0 object_unref(intel_hda);<br>
-<br>
-=C2=A0 =C2=A0 return 0;<br>
-}<br>
-<br>
=C2=A0static void intel_hda_register_types(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0type_register_static(&amp;hda_codec_bus_info);<br>
@@ -1330,7 +1308,6 @@ static void intel_hda_register_types(void)<br>
=C2=A0 =C2=A0 =C2=A0type_register_static(&amp;intel_hda_info_ich6);<br>
=C2=A0 =C2=A0 =C2=A0type_register_static(&amp;intel_hda_info_ich9);<br>
=C2=A0 =C2=A0 =C2=A0type_register_static(&amp;hda_codec_device_type_info);<=
br>
-=C2=A0 =C2=A0 audio_register_model_with_cb(&quot;hda&quot;, &quot;Intel HD=
 Audio&quot;, intel_hda_and_codec_init);<br>
=C2=A0}<br>
<br>
=C2=A0type_init(intel_hda_register_types)<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div></div>

--0000000000009f081f0641ab1e8b--


