Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13D8C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 12:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqBkv-0004J5-TO; Fri, 29 Mar 2024 08:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rqBkt-0004Is-ME
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 08:54:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rqBkr-0002rT-NY
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 08:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711716884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tAj8S0vIOpczCGkf+n7t1iyF0rGdEiB23zLTJV99kJk=;
 b=ddlKv2WekCnIZXSKnpoJonNfZaZaEs1oAv9hE4GPc2Q268mRnsMJ6lwQWUUG9BgFHxP5qb
 pX1O3SABOrC7p5IeQ7xVmNOn/Y4ZkIxsnBNwqks2dZ++U5PXkEFt3zGDRhAT7heY3zGHl1
 MiZ5pEvl7x3DZ3x7nxrSyfKMe0Sg9/U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584--BbRK-y-N5aKd352PuleWw-1; Fri, 29 Mar 2024 08:54:43 -0400
X-MC-Unique: -BbRK-y-N5aKd352PuleWw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4147e733d20so9545425e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 05:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711716882; x=1712321682;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tAj8S0vIOpczCGkf+n7t1iyF0rGdEiB23zLTJV99kJk=;
 b=tIPZDheW23+fi1jZ+HcQJm/2iTcnb89cUcJbyP8yiNJiCtV8qhOEJo9arzflk5T4sd
 PuNblCPQ5NqGcHr29fXKUqCwscMTKaqHFVXI1nAqhmIVMMDh3aYFZkbuaoYRpHqHIRGN
 FyzVKRwwGpBwgjsVm/twYzNM4SQQmA/jf2Tivqc8tkmO51THix8RLp/Uj/NVaqK987tJ
 dU3jjkfKOTIYrHQHE/iBMbHoArnoQvCNyj+qT8zkOrn3B3ARvkDZo8Zi4k8dojitsFN8
 smjPgeJbufRts97wRgOh9nEo7bwJbC+wrhJa0pqlp52q/PN8XaykwkPNc0f7rLhnWzl0
 VpZw==
X-Gm-Message-State: AOJu0Yx2QYgr47sBKfmPH4AkuJ9oH6aVXaBZSbcJc0FIf/9rlrC4PFTh
 uspkdiAmX97KSjwOqYsQId6eyxGzmyqqj9GDr3Rm+J3opmDFpO0gaoO/Gc8mDFAbYcGn5CJdF2v
 GtvNiItnk397iFdb0HHN31cgnQBstidw4a5k2vPYp3MA9JNV99uw1NynkEfW/lXj+6hdBvRA850
 gDutmtkLf3/lYn0BcxFXZy6Vl6ZXI=
X-Received: by 2002:a05:600c:3b16:b0:414:95e0:388c with SMTP id
 m22-20020a05600c3b1600b0041495e0388cmr2167715wms.8.1711716881911; 
 Fri, 29 Mar 2024 05:54:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUygcvP2xNNok5BsdyJ0eVCreO1IulP08abHlrzced0lck40fiSq62hjGunJrEUqUC0P4Naqe1zyAnrgAAZg8=
X-Received: by 2002:a05:600c:3b16:b0:414:95e0:388c with SMTP id
 m22-20020a05600c3b1600b0041495e0388cmr2167697wms.8.1711716881511; Fri, 29 Mar
 2024 05:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240325141422.1380087-1-pbonzini@redhat.com>
 <20240325141422.1380087-2-pbonzini@redhat.com>
 <ZgVEpt7pOzNK2wrM@intel.com>
In-Reply-To: <ZgVEpt7pOzNK2wrM@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 29 Mar 2024 13:54:28 +0100
Message-ID: <CABgObfZrwTWMf3ag7TxDS6_6NO2rAGta_V93jnmEf11QAEURLQ@mail.gmail.com>
Subject: Re: [PATCH for-9.1 v5 1/3] hw: Add compat machines for 9.1
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Xiaoyao Li <xiaoyao.li@intel.com>, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Gavin Shan <gshan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Mar 28, 2024 at 11:07=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wro=
te:
>
> Hi Paolo,
>
> Just meet typos when compiling ;-)

Thank you very much! Fixed both.

Paolo

> On Mon, Mar 25, 2024 at 03:14:20PM +0100, Paolo Bonzini wrote:
> > Date: Mon, 25 Mar 2024 15:14:20 +0100
> > From: Paolo Bonzini <pbonzini@redhat.com>
> > Subject: [PATCH for-9.1 v5 1/3] hw: Add compat machines for 9.1
> > X-Mailer: git-send-email 2.44.0
>
> [snip]
>
> > diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> > index b1dcb3857f0..67e8b0b05e8 100644
> > --- a/hw/s390x/s390-virtio-ccw.c
> > +++ b/hw/s390x/s390-virtio-ccw.c
> > @@ -859,14 +859,26 @@ bool css_migration_enabled(void)
> >      }                                                                 =
        \
> >      type_init(ccw_machine_register_##suffix)
> >
> > +static void ccw_machine_9_1_instance_options(MachineState *machine)
> > +{
> > +}
> > +
> > +static void ccw_machine_9_1_class_options(MachineClass *mc)
> > +{
> > +}
> > +DEFINE_CCW_MACHINE(9_0, "9.1", true);
>
> Should be:
>
> DEFINE_CCW_MACHINE(9_1, "9.1", true);
>
> > +
> >  static void ccw_machine_9_0_instance_options(MachineState *machine)
> >  {
> > +    ccw_machine_9_1_instance_options(machine);
> >  }
> >
> >  static void ccw_machine_9_0_class_options(MachineClass *mc)
> >  {
> > +    ccw_machine_9_1_class_options(machine);
>
> s/machine/mc/
>
> Regards,
> Zhao
>


