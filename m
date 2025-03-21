Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E4AC36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 12:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvbk8-0002IO-LN; Fri, 21 Mar 2025 08:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tvbjr-000242-QS
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 08:44:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tvbjp-00064J-Jo
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 08:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742561074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uVrBRAu+ap8zzf0lzr+Lu65Jg9I+GR9/6N+U7337PBU=;
 b=ZaI5qvg72BiuKY9Ps/sQlFjw9HfQDmnE3S8Dnmjk8S1Ft6VaJJvsM5eOYZdTciOU+I9Ux/
 iTpzgqAUu5Byln09draIASXK8uJr2q+KmXcWFIDN/Trf2Hk5dAOvbsQD1uBUjuNrhNGhTH
 2hiEHrcrUrpSEEwEyhGDoE1m1Gv/vYs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-g8vysZIHMr6NOghjoiZj3Q-1; Fri, 21 Mar 2025 08:44:32 -0400
X-MC-Unique: g8vysZIHMr6NOghjoiZj3Q-1
X-Mimecast-MFC-AGG-ID: g8vysZIHMr6NOghjoiZj3Q_1742561072
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac287f28514so189675266b.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 05:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742561071; x=1743165871;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uVrBRAu+ap8zzf0lzr+Lu65Jg9I+GR9/6N+U7337PBU=;
 b=gpF1sKkpdgsoghW/nK5DZZ8/XUIeQD0opic+BCVHKczx8t/8Boj4tEzcHl2qg0tP3e
 wZbRkWax8AGvoXsD3KmWj2FSgXhFNWs2ZT00IRMwYsh0wYJCREL2ta1mpLntaFXPuEBK
 mGVEgh9PfX+XYrp1922Y2KV5Ui+oHfJEcaKxnnufibkQcidXRFcDJuLyPlqouOBkfV1D
 XqQOXGzlavJzA8FgndPTmFXSnpdSIxOm9BQ4juPT0DhLjTJMnyuYXTDgGPn2NfwkfeHf
 xfYKmSg2p1Iuar6drl6UeIJJcqUE6smGiSMq58t40gh4ym6wUS2Ov+9Uu006LeHRgKi6
 EBMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcqffVIb4f9J0wHnh/kgpovorCbVoSBu08qskZ7n2sHA+w4vYwvD073MioiGqwg7nd4DWl/9SLqPop@nongnu.org
X-Gm-Message-State: AOJu0YwO0/p5AMs0qmanzH9zjlbHhakq7Yhh5Mi9j3H/bw0HkVaxbR/m
 zZctS7Waattplgg23D6nd85rXXkgFcyKzYkVDox9axa6vJegP4d2XwyT5agZrhd6hCRXmg972xC
 0axHGn9kIr5vnWnk+ti8zPRp8vXszaWcDaC1VUOh89kuzOZ4SWcTBH1/eAJx7pgE7UgIVk6+av6
 GIdVo/YA8ShE9xI2fYxnkDQXW0Bgg=
X-Gm-Gg: ASbGncuFH+f/FmATc48ECqfqwghmz5YkK7l9lfR93be+TQpp1HoUNZHZQh7Yt7L8tLq
 8OxDPJ8xDnd8yI+ee6b45r9mLRk9wx9PnjT954H78DWmrD3sRI756ua9Cf7yZgcs2v9848cvwMX
 W5KTfYcYzFdsOSX23epNXWw2AX
X-Received: by 2002:a17:907:97d6:b0:ac2:9683:ad2c with SMTP id
 a640c23a62f3a-ac3f25412cdmr345170866b.57.1742561071470; 
 Fri, 21 Mar 2025 05:44:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0ekd48NDwI0ETOgwGXhibbygDfqjCHbGE7JSZgez52TFJX+8JcN6beSlGvHJVt7TMrEqccCgj9bnkDRmZAt8=
X-Received: by 2002:a17:907:97d6:b0:ac2:9683:ad2c with SMTP id
 a640c23a62f3a-ac3f25412cdmr345167166b.57.1742561071058; Fri, 21 Mar 2025
 05:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <sxavsa2i4drnei4kmy6pd4uekk3xaa43njd47jtogar7ui7qm7@n73chaex5ms2>
 <Z9LeILiEU5GfEHrl@8bytes.org>
 <CAK3XEhNS10gKLh6SKeSc9cKi+_qwu3+Yu5rAkni5h7tYS59D5g@mail.gmail.com>
 <aet7vo4qwexxrw5khiwvhelvhwya3w7wuk72w77jlq7idn3me5@2ojjjdw43u7q>
 <85a9745d-e3b3-4e0e-90ad-066e6dcc25c1@amazon.com>
 <ahtt7arm3pi7rlv6x4qepktrczgnsgaukftyee75ofn5duviho@v4wp6v7wlxbg>
 <4593a2fe-098b-488b-9d55-1adc1e970f59@amazon.com>
 <vajhincsurwwx5yfmfhamgmvo5i22hxsaaef22aaknkn24m7c6@yxuntxof4iie>
 <Z9vSeF67fNazkxBh@8bytes.org>
 <4p7orqixni5m3444l53isxe5awdwasrb5e5bu6wu4phhycqpir@z22wgnaxowsg>
In-Reply-To: <4p7orqixni5m3444l53isxe5awdwasrb5e5bu6wu4phhycqpir@z22wgnaxowsg>
From: Ani Sinha <anisinha@redhat.com>
Date: Fri, 21 Mar 2025 18:14:18 +0530
X-Gm-Features: AQ5f1JpqpR4hpMMrV6Dxfnzv8woVqXygI_PEvtDbjer7oCd0yUy6ZeVEtl65ocM
Message-ID: <CAK3XEhNeB29eaPxZ_1Cc7WfEzOGZZPcvTc5uC1XAdtG0uNfDRw@mail.gmail.com>
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Gerd Hoffman <kraxel@redhat.com>
Cc: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
 Alexander Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000a3f6120630d99d36"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000a3f6120630d99d36
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Mar, 2025, 3:38 pm Gerd Hoffman, <kraxel@redhat.com> wrote:

>   Hi,
>
> > >      While digging around in the igvm spec I've seen there is the
> > >      concept of 'parameters'.  Can this be used to pass on the memory
> > >      location of kernel + initrd + cmdline?  Maybe the kernel hashes
> too?
> >
> > The find the locations of the kernel, initrd, cmdline, ... I think IGVM
> > parameters, either directly or (preferably indirectly) are a good
> > solution. By "indirectly" I mean to put these regions on a separate and
> > measured page which also contains the region hashes.
>
> regions and hashes should be separate I think.  The regions are not
> necessarily fixed, the physical memory location where things have been
> loaded to can change.
>
> But also see my other reply.  I'm not convinced any more carrying
> forward the hashes logic makes much sense.
>
> > >  (2) Will the igvm be generated on the fly from FUKI data?  Or should
> > >      the distros ship igvm images with firmware + kernel + initrd?
> >
> > My preference would be that distros ship the tooling and components to
> > build IGVM files and build them during kernel update. If a distro comes
> > up with a generic initrd+cmdline it can also ship pre-built IGVM files.
>
> Working with the (F)UKI instead has the advantage that we can make use
> of the secure boot signature, with a workflow along these lines:
>
> (distro) build:
>  * Embed the firmware as igvm inside the UKI.
>  * Sign the UKI.
>
> first vm launch:
>  * Load the complete UKI.
>  * Pass on (a) the igvm section and (b) the UKI (including signature)
>    to the vmfwupdate device.
>
> vmwupdate device:
>  * loads the igvm image.
>  * passes on the UKI location (as igvm parameter?).
>
> second vm launch:
>  * firmware checks UKI signature.
>  * firmware (optionally) measures UKI into vTPM.
>  * firmware launches UKI.
>
> Going ship the distro kernel as igvm image would work too.  Will
> simplify the measurement pre-calculation.  Also there is no need to pass
> around any parameters, everything (how the firmware finds the UKI etc)
> can be arranged at igvm build time then.  Disadvantage: This introduces
> a completely new boot workflow.  Will probably need a new set of cloud
> images exclusively for the BYOF case.
>

What does all this mean for the hypervisor interface ?

>

--000000000000a3f6120630d99d36
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 21 Mar, 2025, 3:38 pm Ge=
rd Hoffman, &lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@redhat.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">=C2=A0 Hi,<br>
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 While digging around in the igvm spec I&#39;v=
e seen there is the<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 concept of &#39;parameters&#39;.=C2=A0 Can th=
is be used to pass on the memory<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 location of kernel + initrd + cmdline?=C2=A0 =
Maybe the kernel hashes too?<br>
&gt; <br>
&gt; The find the locations of the kernel, initrd, cmdline, ... I think IGV=
M<br>
&gt; parameters, either directly or (preferably indirectly) are a good<br>
&gt; solution. By &quot;indirectly&quot; I mean to put these regions on a s=
eparate and<br>
&gt; measured page which also contains the region hashes.<br>
<br>
regions and hashes should be separate I think.=C2=A0 The regions are not<br=
>
necessarily fixed, the physical memory location where things have been<br>
loaded to can change.<br>
<br>
But also see my other reply.=C2=A0 I&#39;m not convinced any more carrying<=
br>
forward the hashes logic makes much sense.<br>
<br>
&gt; &gt;=C2=A0 (2) Will the igvm be generated on the fly from FUKI data?=
=C2=A0 Or should<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 the distros ship igvm images with firmware + =
kernel + initrd?<br>
&gt; <br>
&gt; My preference would be that distros ship the tooling and components to=
<br>
&gt; build IGVM files and build them during kernel update. If a distro come=
s<br>
&gt; up with a generic initrd+cmdline it can also ship pre-built IGVM files=
.<br>
<br>
Working with the (F)UKI instead has the advantage that we can make use<br>
of the secure boot signature, with a workflow along these lines:<br>
<br>
(distro) build:<br>
=C2=A0* Embed the firmware as igvm inside the UKI.<br>
=C2=A0* Sign the UKI.<br>
<br>
first vm launch:<br>
=C2=A0* Load the complete UKI.<br>
=C2=A0* Pass on (a) the igvm section and (b) the UKI (including signature)<=
br>
=C2=A0 =C2=A0to the vmfwupdate device.<br>
<br>
vmwupdate device:<br>
=C2=A0* loads the igvm image.<br>
=C2=A0* passes on the UKI location (as igvm parameter?).<br>
<br>
second vm launch:<br>
=C2=A0* firmware checks UKI signature.<br>
=C2=A0* firmware (optionally) measures UKI into vTPM.<br>
=C2=A0* firmware launches UKI.<br>
<br>
Going ship the distro kernel as igvm image would work too.=C2=A0 Will<br>
simplify the measurement pre-calculation.=C2=A0 Also there is no need to pa=
ss<br>
around any parameters, everything (how the firmware finds the UKI etc)<br>
can be arranged at igvm build time then.=C2=A0 Disadvantage: This introduce=
s<br>
a completely new boot workflow.=C2=A0 Will probably need a new set of cloud=
<br>
images exclusively for the BYOF case.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">What does all this mean for the hyper=
visor interface ?</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_qu=
ote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex"></blockquote></div></div></di=
v>

--000000000000a3f6120630d99d36--


