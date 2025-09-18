Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3D8CA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 20:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzKrP-0007AQ-P2; Thu, 18 Sep 2025 16:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzKrH-00077a-Uy
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 16:04:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzKrG-0008Vv-57
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 16:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758225836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LgVRs4qDWWl/SassPeYOJGunpCbcT4oPhyAu1oaWNOQ=;
 b=S7Ki0vBOvTkGsDnbAugmyhW83aFqvZGqXhokZtk3aQrUJoHeQUqU2emEfsUZxamDcOt7Wl
 1phEZkaA+7AFuYsF20h6aEH3LBpVMtsVU1nLoSykrBjWfW8VWn59fYevUHxkQnT/GjQ9iL
 dIb5wk+wYHOMsIV4SsY5Lh08uHe1yDY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-9Yq0_1qFOcKMDyc1NyQSQQ-1; Thu, 18 Sep 2025 16:03:54 -0400
X-MC-Unique: 9Yq0_1qFOcKMDyc1NyQSQQ-1
X-Mimecast-MFC-AGG-ID: 9Yq0_1qFOcKMDyc1NyQSQQ_1758225834
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4b60dd9634dso28278861cf.2
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 13:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758225834; x=1758830634;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LgVRs4qDWWl/SassPeYOJGunpCbcT4oPhyAu1oaWNOQ=;
 b=bTDd/nB6qgNeiUNWEpnOOi3BMrC/sDsawG4n/cgLvaMnZ6E1jfk6MnyIA+v/cgUuL6
 JjYhDxJATJ3FI8ddZ0HGfjmStUeYKNroatByenBZB2eS+jLGeQ4Lp6OXzmHZye9epXkO
 FvQxX9B5WURRVxSKTwPLGWTw1g77MtRsxkyk0nQTE0jBmu7Kekl1fwEjKxGmaYDHIu4c
 F7EBdxi0F69D8tY011w6qaM3qo2X10PxGCKTesGC0T4cY2/1ONeRpLOoaOH7A6km+xGN
 pFm2ETPOHCPisUNBPrzSuW1pI0nuTYozf4AYFehozFmSY77MmA/nUpplLcf/0uu061CB
 Qd1Q==
X-Gm-Message-State: AOJu0Yx0jjZoROhCRQsy52piOuzVW9eQF222Tm+mYhgWq0YG9SXXAJun
 DW1GRABJMbN8tvPiU9k27Zm/WEa8hHKzaZG63PzJjL49DIeOOoO34+uHlIBd7kmK2Weba+rNZxe
 hh+WTdX0tAUU1xG0hech603Cm1cjV1vPHb1Hl+Y9Y0m3ApoXxIsVvvSnu
X-Gm-Gg: ASbGnctiazHEicf8YfAcLt6vfQOCoUDrRwpJV4KUm7QGLN/KPB/ptRZiADzWlkV3GIc
 496U8exfXXZ5MFnMqsWSLN6vvmBQuO6akhlVR0uhthnKhPlXG2Fp5sVxGJVR8uCDnsfRn6hX03g
 cIMZzByE66K3hDEIfhA/rQMG8tD7w0TOBjYc1HzmOtg0ax1JeO4OeFIKkOJv3OfPly67IgeX3UJ
 jhs5+bJQBZf8LCNh6HoBWRCR6F39H4egat1ylMi+dS3De225AQbrvX6sxDVqdK2c+u/IMX4g3Uk
 kU/1A5rkKIhke+ASm+H6cjwyg8+g778iX6LHlURkY3/KsFV72SkElhJ2lgLTRvxRXhwmIo03f6A
 BsFHcCYGDg0KSfnol+BCq8A==
X-Received: by 2002:a05:622a:5a88:b0:4b7:a98b:8933 with SMTP id
 d75a77b69052e-4c072d2d400mr6026021cf.62.1758225833777; 
 Thu, 18 Sep 2025 13:03:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB62ZbYxbCV9ZW2QX6E1EIwlRMLvImUy5ZMYB2/qRwmfyMDoEyMnXIs2TXp5P2RdybchVl+g==
X-Received: by 2002:a05:622a:5a88:b0:4b7:a98b:8933 with SMTP id
 d75a77b69052e-4c072d2d400mr6025121cf.62.1758225833133; 
 Thu, 18 Sep 2025 13:03:53 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4bda15f91a0sm19307741cf.1.2025.09.18.13.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 13:03:52 -0700 (PDT)
Date: Thu, 18 Sep 2025 16:03:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Bin Meng <bmeng.cn@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 1/7] docs/devel: Do not unparent in instance_finalize()
Message-ID: <aMxlpfp_LSgiIk9Z@x1.local>
References: <20250917-use-v3-0-72c2a6887c6c@rsg.ci.i.u-tokyo.ac.jp>
 <20250917-use-v3-1-72c2a6887c6c@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250917-use-v3-1-72c2a6887c6c@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 17, 2025 at 07:13:26PM +0900, Akihiko Odaki wrote:
> Children are automatically unparented so manually unparenting is
> unnecessary.
> 
> Worse, automatic unparenting happens before the instance_finalize()
> callback of the parent gets called, so object_unparent() calls in
> the callback will refer to objects that are already unparented, which
> is semantically incorrect.
> 
> Remove the instruction to call object_unparent(), and the exception
> of the "do not call object_unparent()" rule for instance_finalize().
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  docs/devel/memory.rst | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
> index 57fb2aec76e0..749f11d8a4dd 100644
> --- a/docs/devel/memory.rst
> +++ b/docs/devel/memory.rst
> @@ -161,18 +161,11 @@ or never.
>  Destruction of a memory region happens automatically when the owner
>  object dies.
>  
> -If however the memory region is part of a dynamically allocated data
> -structure, you should call object_unparent() to destroy the memory region
> -before the data structure is freed.  For an example see VFIOMSIXInfo
> -and VFIOQuirk in hw/vfio/pci.c.

Should we still keep some of these examples?  After the series they'll be
doing the right things.  Dynamic MRs are still slightly tricky, I think
it's still good to have some references.

> -
>  You must not destroy a memory region as long as it may be in use by a
>  device or CPU.  In order to do this, as a general rule do not create or
> -destroy memory regions dynamically during a device's lifetime, and only
> -call object_unparent() in the memory region owner's instance_finalize
> -callback.  The dynamically allocated data structure that contains the
> -memory region then should obviously be freed in the instance_finalize
> -callback as well.
> +destroy memory regions dynamically during a device's lifetime.
> +The dynamically allocated data structure that contains the
> +memory region should be freed in the instance_finalize callback.
>  
>  If you break this rule, the following situation can happen:
>  
> @@ -198,9 +191,9 @@ this exception is rarely necessary, and therefore it is discouraged,
>  but nevertheless it is used in a few places.
>  
>  For regions that "have no owner" (NULL is passed at creation time), the
> -machine object is actually used as the owner.  Since instance_finalize is
> -never called for the machine object, you must never call object_unparent
> -on regions that have no owner, unless they are aliases or containers.
> +machine object is actually used as the owner.  You must never call
> +object_unparent on regions that have no owner, unless they are aliases
> +or containers.

This looks like a completely separate change.  So we start to allow
machines to be finalized now?  I'm not familiar with machine object
lifecycles.  Maybe split it out even if it's true?

-- 
Peter Xu


