Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2833ACE7AE6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 08:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smUBc-00038t-O2; Fri, 06 Sep 2024 04:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1smUBa-0002zY-2p
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 04:19:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1smUBY-00055f-Ih
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 04:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725610754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l+1rLl3MrSbQBC41PzVhy1iDmWn1l5eF4j/Pf/s0ZaI=;
 b=gtH59aNPrRw+FyEIHaBYgwKwxAXSt8LJEf2Z4ByUczad6h7t8L4pqQh52247sEC7zwto4h
 sSM77jNqs9J4tQy6QblZUgqbD0w2eBILfEWNQ0YrdLih7NMFkev7YWQSyjmVQ1FdeiUht3
 treM5SbM3IeSDGmW/R7r+DmljWcIEs4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-Hz6nBaNxOmWAzN9f_GikGw-1; Fri, 06 Sep 2024 04:19:13 -0400
X-MC-Unique: Hz6nBaNxOmWAzN9f_GikGw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-374ba33b2d2so993313f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 01:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725610751; x=1726215551;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l+1rLl3MrSbQBC41PzVhy1iDmWn1l5eF4j/Pf/s0ZaI=;
 b=P7z+EQ1V1MRkJII4RP4GdD+97VP6D57uudoSi4z9Q2lgE7/FkTgQsaOMMJF3wwTWcq
 wiezPvEcRoxymh+3coJsOFCjH9o9iMh21Jacvkf4iZ7wPRmSjJ6xiJq2K3cE3y10cpYw
 Xj5MDDHlhAyPd010rlD4/qsIdUILhiwlOvqAZ5pLRCYYvRF2KoftSvm/XZGj8rfuOc49
 AowuQs5z893P8XkRsnvw0X9M/f40oxnzAdr1n2uCMEx5lBHL48ork4JReYiR/D0lwgyt
 hXc/tzD78QvldYEeMf0ulKLuegrqdx25yW08sGhlnp0enXy3Z8/WFOXJAw7HnOrY8IpR
 OCLg==
X-Gm-Message-State: AOJu0Yx0CKhL7b5baNpc+L+ia/nD35vpiZQ8gfYckKxMFKEL9udDRj91
 wHpEunHXqUm4VkbGVbBkQYOyjAVXMzWs7d4vb4EYYqbqskIUKVM51vbU5MoDloiClC+6FqcFgtc
 6ETs2HCmT2n71zzkAP+bMDP75542j+vDDF206C1y/IjL4hGl3NEgcqoQnEIYlbwAe9moPCcbZrs
 tEI1eynKSKXrrvI/nNfCXaZWn48U2WC2dw9SrJrosj
X-Received: by 2002:adf:f88c:0:b0:36b:a2bb:b374 with SMTP id
 ffacd0b85a97d-378896c81bfmr1137910f8f.52.1725610751313; 
 Fri, 06 Sep 2024 01:19:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtgyP92uytpbE9rw1tLjLq0SXKCE5ymEC94qkcvGd6eTG0Ke8yoWJLW2gDWyTNehehoCDnr5GELhUzse5PjiA=
X-Received: by 2002:adf:f88c:0:b0:36b:a2bb:b374 with SMTP id
 ffacd0b85a97d-378896c81bfmr1137894f8f.52.1725610750785; Fri, 06 Sep 2024
 01:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240906073737.493254-1-pbonzini@redhat.com>
 <be6dfcb4-b1a4-4dff-a08b-e79e303960dd@redhat.com>
In-Reply-To: <be6dfcb4-b1a4-4dff-a08b-e79e303960dd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 6 Sep 2024 10:18:59 +0200
Message-ID: <CABgObfYbnsfxVHHTWkHU-eWFHMMCv-80OzqvLBrbznHpzD2+BQ@mail.gmail.com>
Subject: Re: [PATCH] virtio: kconfig: memory devices are PCI only
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 6, 2024 at 9:40=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
> On 06.09.24 09:37, Paolo Bonzini wrote:
> > Virtio memory devices rely on PCI BARs to expose the contents of memory=
.
> > Because of this they cannot be used with virtio-mmio or virtio-ccw.  In=
 fact
>
> Guess what I am working on at this very the moment ;)

Ok, then hardcoding VIRTIO_PCI is not nice.

> > @@ -45,7 +46,7 @@ config VIRTIO_PMEM_SUPPORTED
> >   config VIRTIO_PMEM
> >       bool
> >       default y
> > -    depends on VIRTIO
> > +    depends on VIRTIO_PCI
>
> depends on VIRTIO_MD ?

No, because VIRTIO_MD is "default n" (and anyway you don't want to
enable it by hand in the --without-default-devices case).

But something like this could be a good alternative if you plan to
support virtio-ccw as well:

diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index aa63ff7fd41..253e7d3f90a 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -16,6 +16,7 @@ config VIRTIO_PCI
     default y if PCI_DEVICES
     depends on PCI
     select VIRTIO
+    select VIRTIO_MD_SUPPORTED

 config VIRTIO_MMIO
     bool
@@ -35,8 +36,14 @@ config VIRTIO_CRYPTO
     default y
     depends on VIRTIO

+# not all virtio transports support memory devices; if none does,
+# no need to include the code
+config VIRTIO_MD_SUPPORTED
+    bool
+
 config VIRTIO_MD
     bool
+    depends on VIRTIO_MD_SUPPORTED
     select MEM_DEVICE

 config VIRTIO_PMEM_SUPPORTED
@@ -46,6 +51,7 @@ config VIRTIO_PMEM
     bool
     default y
     depends on VIRTIO
+    depends on VIRTIO_MD_SUPPORTED
     depends on VIRTIO_PMEM_SUPPORTED
     select VIRTIO_MD

@@ -57,6 +63,7 @@ config VIRTIO_MEM
     default y
     depends on VIRTIO
     depends on LINUX
+    depends on VIRTIO_MD_SUPPORTED
     depends on VIRTIO_MEM_SUPPORTED
     select VIRTIO_MD


and then you just need to select VIRTIO_MD_SUPPORTED from VIRTIO_CCW.
In the case of PCI there is some board support code as well, which is
why VIRTIO_{MEM,PMEM}_SUPPORTED is selected from "config PC", but
perhaps in the s390 code you can select those three from VIRTIO_CCW as
well.

If this looks good I'll send it as v2.

Thanks,

Paolo


