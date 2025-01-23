Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD8DC02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 08:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tasFt-00033c-J5; Thu, 23 Jan 2025 03:08:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tasFr-00033F-Lk
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 03:08:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tasFo-0008LE-V2
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 03:07:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737619676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bNTrDwnyA6hG3EWigwlqQotwZmozE+/SgmY26jwH9LE=;
 b=KEY3Rx4IfuxH5VxTx3439yt0QBAIxzc07q7er9ovSGU76Ae8u06Qbkc1WDFC3u5kMWgbzP
 +DlVBzHQso99ZGe5dm2zw6k/11dKjwS14AcK8RiQl5gRseum0wNFBBYWse+tetXqg/KQt1
 E79DPhMntLKbFgEV+hHlUHTzAxnIzaQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-iRYoBESBPwSFRXX3ogPRsg-1; Thu, 23 Jan 2025 03:07:53 -0500
X-MC-Unique: iRYoBESBPwSFRXX3ogPRsg-1
X-Mimecast-MFC-AGG-ID: iRYoBESBPwSFRXX3ogPRsg
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38a2140a400so387760f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 00:07:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737619672; x=1738224472;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bNTrDwnyA6hG3EWigwlqQotwZmozE+/SgmY26jwH9LE=;
 b=euChdxi/YvkzbZ1Tr98aXtuw2GFH9x6zz0Po7n61Zg9nPC1f85cPURJAvjssAK+y9K
 qbKb5mJHhE4IJGILi2TodhWoRIyn0NwNSPzh5qhzGEfnRoYqn9sD1y1O+UkhFGPWFLgS
 lpVUu4Ro9GkWI7XFZypCYYBFpGCsoM7SVrtCLTavypdQKj6Dk5YJ0uKnLGDnvuO8euKQ
 4M9N5+/MYowp+kVWVGpdDIsqE0naJ4P8vYfIQe9ctqkGZdlRebKhDH9dPpGXvo2DSVDv
 e+kwIkEU87O/UnfbZqLKuhUd63PiGdAWprjCNyNm2lwMWwQTdRuRNHZTVFgH36mtdQG8
 9TOA==
X-Gm-Message-State: AOJu0Ywg3WW7HbADyquX1N7oymFwAQzAV8QCitPg8NhfMab4yrEzX29H
 xLYNoBcWjrOVzW3dgfBtKA3O/dMUSt/Nt3n95RxRuJJRrnYuA+K+nTkWBFjIH3Qn2/b5peR6qTJ
 OkxAiuAwqbS2FhFrcj3/b/9VTSCP68HYSGdCZq1EJnKFx48X0h3MaAn+GfFChph8Yq1l+F61CRa
 ssuwwyKVqQSi9QiWrtjgg6XZ7rhvqDn6xCkL0/gw==
X-Gm-Gg: ASbGncslQTfk0Y0tHF2M7vc9pWx7TXvkwBa19GsbBkEAr5JbvKPIoiM4+Kk4SQ1/5za
 laKotRx1A9IPWiMb0TnIRTN6PS0l5In//BJx10G3boRSDtC6Q5pQ=
X-Received: by 2002:a5d:64ed:0:b0:385:f72a:a3b0 with SMTP id
 ffacd0b85a97d-38bf57dc942mr21958127f8f.55.1737619672050; 
 Thu, 23 Jan 2025 00:07:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuvfJYW56lcpFSbyw/UwT+9DgrIy3yYtbYYCxZqoOqWqutAWHu6DUnPVVHBRU+B6J26+DGThyPrvhfBc4nZ8E=
X-Received: by 2002:a5d:64ed:0:b0:385:f72a:a3b0 with SMTP id
 ffacd0b85a97d-38bf57dc942mr21958099f8f.55.1737619671663; Thu, 23 Jan 2025
 00:07:51 -0800 (PST)
MIME-Version: 1.0
References: <20250117092657.1051233-1-pbonzini@redhat.com>
 <20250117092657.1051233-7-pbonzini@redhat.com>
 <Z5G7HOjOfvE9+810@intel.com>
In-Reply-To: <Z5G7HOjOfvE9+810@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 23 Jan 2025 09:07:40 +0100
X-Gm-Features: AWEUYZmak5nzNgVNDhXl0G_nuQYwFFYc-G3HwC3CsBiZSxJiZhHmrX2ifRP_hDU
Message-ID: <CABgObfYqtBGgXXDKN+6-EQY_rncMPHP9mTOUhrxTK3cRXcyurg@mail.gmail.com>
Subject: Re: [PATCH 06/10] rust: pl011: extract PL011Registers
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000048db45062c5b1b96"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--00000000000048db45062c5b1b96
Content-Type: text/plain; charset="UTF-8"

Il gio 23 gen 2025, 04:25 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> > --- a/rust/hw/char/pl011/src/device_class.rs
> > +++ b/rust/hw/char/pl011/src/device_class.rs
> > @@ -6,11 +6,11 @@
> >  use std::os::raw::{c_int, c_void};
> >
> >  use qemu_api::{
> > -    bindings::*, c_str, vmstate_clock, vmstate_fields, vmstate_of,
> vmstate_subsections,
> > -    vmstate_unused, zeroable::Zeroable,
> > +    bindings::*, c_str, vmstate_clock, vmstate_fields, vmstate_of,
> vmstate_struct,
>
> Oops, I forgot to clean up this bindings::*.
>

No big deal (it's a secondary file and will probably be merged into
device.rs as soon as VMState bindings are more complete).

Paolo

> +    vmstate_subsections, vmstate_unused, zeroable::Zeroable,
> >  };
> >
>
> Very good example!
>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>
>

--00000000000048db45062c5b1b96
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 23 gen 2025, 04:25 Zhao L=
iu &lt;<a href=3D"mailto:zhao1.liu@intel.com">zhao1.liu@intel.com</a>&gt; h=
a scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; =
--- a/rust/hw/char/pl011/src/<a href=3D"http://device_class.rs" rel=3D"nore=
ferrer noreferrer" target=3D"_blank">device_class.rs</a><br>
&gt; +++ b/rust/hw/char/pl011/src/<a href=3D"http://device_class.rs" rel=3D=
"noreferrer noreferrer" target=3D"_blank">device_class.rs</a><br>
&gt; @@ -6,11 +6,11 @@<br>
&gt;=C2=A0 use std::os::raw::{c_int, c_void};<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 use qemu_api::{<br>
&gt; -=C2=A0 =C2=A0 bindings::*, c_str, vmstate_clock, vmstate_fields, vmst=
ate_of, vmstate_subsections,<br>
&gt; -=C2=A0 =C2=A0 vmstate_unused, zeroable::Zeroable,<br>
&gt; +=C2=A0 =C2=A0 bindings::*, c_str, vmstate_clock, vmstate_fields, vmst=
ate_of, vmstate_struct,<br>
<br>
Oops, I forgot to clean up this bindings::*.<br></blockquote></div></div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">No big deal (it&#39;s a seconda=
ry file and will probably be merged into <a href=3D"http://device.rs">devic=
e.rs</a> as soon as VMState bindings are more complete).</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 vmstate_subsections, vmstate_unused, zeroable::Zeroable=
,<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
<br>
Very good example!<br>
<br>
Reviewed-by: Zhao Liu &lt;<a href=3D"mailto:zhao1.liu@intel.com" target=3D"=
_blank" rel=3D"noreferrer">zhao1.liu@intel.com</a>&gt;<br>
<br>
</blockquote></div></div></div>

--00000000000048db45062c5b1b96--


