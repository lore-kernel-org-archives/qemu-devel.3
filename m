Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66930CF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 11:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svEyB-0001lQ-AW; Mon, 30 Sep 2024 07:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1svEy9-0001kx-Kl
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 07:53:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1svEy7-0007Ad-FZ
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 07:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727697214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hgo9kaUPqbQrP3gRIZ6A8rj4dGXRLVOe3FpRh1Cusb0=;
 b=cdzroKqcNilmBMhfBiiE2cRV0iQEg0A+cA6jYlGKSAGyC1C+Ur+p/BDDez2o4rvFJ1Q06F
 PZZ1nYSEpdl7hETBek7IoI9QVX3YissKRBDPpGkDmvDtXEEGP/IZxCh8aWnykAQ5iwSgDv
 yhsEBKVRCTuqeObDPq4hQKFSz9knAZk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-Rn0PgyhjMiW026zNEpdJAQ-1; Mon, 30 Sep 2024 07:53:32 -0400
X-MC-Unique: Rn0PgyhjMiW026zNEpdJAQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb940cd67so43394755e9.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 04:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727697211; x=1728302011;
 h=in-reply-to:references:user-agent:to:from:subject:cc:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hgo9kaUPqbQrP3gRIZ6A8rj4dGXRLVOe3FpRh1Cusb0=;
 b=bGwCNgg/fBZ+TL5qBNZG3Ysry9B58saLvApeqhKWr2+y/nbT+H2BO7GAnSQgr8BGFc
 YxeN8GfV4T4nOniNCtmMm8DaQ28amhXHGGi7JUD9+f8L9o3NBNJvReyM7UH671D6HSRl
 B0zW5Vvs3jdWCNHsX6LnRBY2dydW8G+zZqTSr6xh9r5nzprT26HeSk03oMh9Q4F4RFHa
 Ugow9CWFxCnFasgL+2TCqEavm/yuxNkdQ1qd7TxD2WWnTlCgOJJj6sxe4NoMj6rqHsRy
 GRT7uubBOpAuuEa0nBWx14YR+k9WLEhv0ySgs0+Mqel4QPtWnFhRlyvAmZ8bv9H5VY80
 N6/g==
X-Gm-Message-State: AOJu0YwqA22jHTbzkERPElF6SK5IhYo2zMR4fpdrn9xq3zSnz2iXrWOo
 UBHY5kW84GcDoxzigkRIMStVuLiJbSqgoccuPrXYqpWddYlBUn/s9Kzv2IXD3y87EWPIELKTp58
 nvCv3wsFleCiWxEAyamZijey+ZaRbXVphqYQ9kb0b23zFWKNPoBI7
X-Received: by 2002:a05:600c:5117:b0:42c:a8cb:6a5a with SMTP id
 5b1f17b1804b1-42f5844b9dcmr131613405e9.15.1727697211126; 
 Mon, 30 Sep 2024 04:53:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMRuvKXGKxNkPkxHS2Qc00xW6plZkQQCeJsJhGeodTT49sWvMpQFgsFpYxMj7w6mP6Y3OU2Q==
X-Received: by 2002:a05:600c:5117:b0:42c:a8cb:6a5a with SMTP id
 5b1f17b1804b1-42f5844b9dcmr131613075e9.15.1727697210688; 
 Mon, 30 Sep 2024 04:53:30 -0700 (PDT)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6867sm8845957f8f.49.2024.09.30.04.53.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2024 04:53:30 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Sep 2024 13:53:30 +0200
Message-Id: <D4JLJP8EH4KB.SMOJPAOIVC05@redhat.com>
Cc: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>
Subject: Re: Convert an error_report to tracepoint
From: "Anthony Harivel" <aharivel@redhat.com>
To: =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
User-Agent: aerc/0.18.2-67-g7f69618ac1fd
References: <D4JL6KP1Z58Q.1P5U7QZQU7AKP@redhat.com>
 <ZvqOxVzk_N24SYa9@redhat.com>
In-Reply-To: <ZvqOxVzk_N24SYa9@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9, Sep 30, 2024 at 13:43:
> On Mon, Sep 30, 2024 at 01:36:21PM +0200, Anthony Harivel wrote:
>> Hello,=20
>>=20
>> There is an error_report() in target/i386/kvm/vmsr_energy.c that would=
=20
>> benefit for being a tracepoint because this is not actually an "error"=
=20
>> as per se, but more a notification that could be used for debugging, and=
=20
>> it is quite verbose.
>>=20
>> Could someone give me some pointer on how I could manage that so I can=
=20
>> send a patch to rectify this ?
>
> Modify the file target/i386/kvm/trace-events   to define your desired
> tracepoint(s).
>
> Then #include "trace-event.h"  in your vmsr_energy.c  file
>
> Call your probepoint using  trace_{probe name}(...args...)
>
> See docs/devel/tracing.rst for general info on tracing
>

Right, I get it now !

Thanks a lot (again) for your support Daniel

> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|


