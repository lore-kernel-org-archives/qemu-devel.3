Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DD5D609AD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 08:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGDJG-0001Dl-Bg; Wed, 27 Nov 2024 03:22:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tGDJE-0001DU-N3
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 03:22:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tGDJD-0007uB-1v
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 03:22:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732695721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DP47wj4tJ8N3vH2MLwc3iQnimSIxAjB3vsTH8u30yb8=;
 b=Ko3RP9s+DAPy0IIjuj80UybhzLbc6ALC24GX2SnqsMsnaY9yqxUIzReeqDFW7EIq48MsOi
 58i5q20l2h82blFv7fSQ5lgDP8eVWuvoNA4Oxd2kjqSkder7GL5LtYsog8jFXVjBWRjhm5
 RBZsYMOZ8gjL/O62XWT27r1FFEtq+GE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-LdsOajPEPEKXQL1KL3ifuA-1; Wed, 27 Nov 2024 03:21:58 -0500
X-MC-Unique: LdsOajPEPEKXQL1KL3ifuA-1
X-Mimecast-MFC-AGG-ID: LdsOajPEPEKXQL1KL3ifuA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38256b20f5fso4838107f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 00:21:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732695717; x=1733300517;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DP47wj4tJ8N3vH2MLwc3iQnimSIxAjB3vsTH8u30yb8=;
 b=t7fSr3O/T5O37XA1BEK+3UdvSjH1ynz6c4/LWUM8rGjdtPcCVPWjRzStMMDjiXLaXa
 4OE+de17EVDLiORaPgsSIskEkBd4+ctXB3ItSYMUwF0GyZhkb7BaQZMEjo6Zh2ezTxAI
 jQYibhzqb89ie9JlKU7aYCs4nNmbHCoFQ80141GXWJAIr98zSvtftF4yumTS/k0rItZr
 EhtTHjffZikKfl5poWzhz91HVj8B5hqZSjkYBFZ+F34sf0WlG5sOrWsMt4sSIXBpb+h+
 A4jSShXuFicTqJpgAKX/JBXuVj9JxO9FLYS44MnTCh/IE8bVu651DjK5QWryVYwZoz9N
 BbNA==
X-Gm-Message-State: AOJu0YyNcAAIWsE1Qe+WolaYGF+s9K6lfZTwQf/83jFbklmnYwVQIb+k
 +pIMeKbWm9+szYZQKDDhjrHPOUgc11BC9IqCD0YnzQo/NhIcPLVA3vVoisBSJTvLHMY2RLSMNKF
 sy94XIGYi6Jn4qh7Hqmic7kkzDq3hNC0OOyKXlEEWM464rmd1gGR2lvuOOfrgSH4YUmLhljbBAE
 y2DoWyqS4z4zbnnPXN+lhJfYyOXZs=
X-Gm-Gg: ASbGncvx2vUrL6DJyFh66PHn3X1bTv0Yyul8QVp0SvuET6V/8krrmRVCq/gAnAhbD4U
 IWuph6N2osx0mnhZEIrUf1KIfd6qs5yqs
X-Received: by 2002:a05:6000:1449:b0:382:4b9a:f506 with SMTP id
 ffacd0b85a97d-385c6ed95e6mr1939807f8f.36.1732695717139; 
 Wed, 27 Nov 2024 00:21:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCotwVjRpTeqkFRlC8nWWIYnrsnmeT11idGx3EdgiSKEGSdqqT5Q7gcR2sLcNNg8jeBUgW0Dy+AXPE7QuGI6k=
X-Received: by 2002:a05:6000:1449:b0:382:4b9a:f506 with SMTP id
 ffacd0b85a97d-385c6ed95e6mr1939786f8f.36.1732695716868; Wed, 27 Nov 2024
 00:21:56 -0800 (PST)
MIME-Version: 1.0
References: <cc40943e-dec1-4890-a1d9-579350ce296f@pbonzini.local>
 <Z0bAPQxjwyc15Hyv@intel.com>
In-Reply-To: <Z0bAPQxjwyc15Hyv@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 27 Nov 2024 09:21:45 +0100
Message-ID: <CABgObfYY1PrD9dRKRgzgyRAe8gzp-4KHvV1-Bgq32_2jpaTMPg@mail.gmail.com>
Subject: Re: Rust in QEMU roadmap
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000b54b990627e0a83e"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000b54b990627e0a83e
Content-Type: text/plain; charset="UTF-8"

Il mer 27 nov 2024, 07:28 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> Hi Paolo, thanks for your sharing and summary, do you have the plan
> about custom allocator (QemuAllocator in rust/qemu-api/src/lib.rs)?
>

No plan yet, but we'll see once we introduce C data structures allocated
from Rust. Adding the libc crate to the build is not hard and it may be
simpler than enabling the QemuAllocator.

Paolo


Regards,
> Zhao
>
>

--000000000000b54b990627e0a83e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 27 nov 2024, 07:28 Zhao Liu &lt;<a href=3D"mail=
to:zhao1.liu@intel.com">zhao1.liu@intel.com</a>&gt; ha scritto:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi Paolo, thanks for your s=
haring and summary, do you have the plan<br>
about custom allocator (QemuAllocator in rust/qemu-api/src/<a href=3D"http:=
//lib.rs" rel=3D"noreferrer noreferrer" target=3D"_blank">lib.rs</a>)?<br><=
/blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">No pl=
an yet, but we&#39;ll see once we introduce C data structures allocated fro=
m Rust. Adding the libc crate to the build is not hard and it may be simple=
r than enabling the QemuAllocator.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
Regards,<br>
Zhao<br>
<br>
</blockquote></div></div></div>

--000000000000b54b990627e0a83e--


