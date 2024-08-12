Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB76AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 10:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdRq8-0003il-3M; Mon, 12 Aug 2024 05:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sdRq6-0003go-5j
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 05:59:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sdRq3-0007b4-6a
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 05:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723456782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7uCX/ZYYqt69jPFMi9ZYUM1vQaXvbsxv/vCDz+D4QdA=;
 b=fI7HBg/RYxj183hB8wjPk273jLKqgQx+GXsDeq9OWBj2vONyY6uVUrC1HWyco3njGK0Bhc
 4hGauVqVQ0x110wOC4SirUAEIMOroMIKtHROKsf7qJEuAwmoNW6Ul/zXOAgSRcPXDeO+fe
 zdKSsSZsqYM3Fxwp1wDueeh/+erDJvs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-aLfBhOBZOx2ARySl7LKGeQ-1; Mon, 12 Aug 2024 05:59:35 -0400
X-MC-Unique: aLfBhOBZOx2ARySl7LKGeQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5bb90be4d87so3288747a12.2
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 02:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723456774; x=1724061574;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7uCX/ZYYqt69jPFMi9ZYUM1vQaXvbsxv/vCDz+D4QdA=;
 b=OCMkPZxVgNL4ItH1ngikcaWJ4LNGs/4jSrANHylLZ8pW35e2pCuwGFX9BCK1SqUN01
 5J/u7s+7J83+Y4gPXKlPlpS5B82V9Sxl9r9LYjTbA5n2xvD7ai1K5ZwZBlMP4kwlVo+v
 rEDhN6Q3lHEXKHCGrhPwe1A3WX9kK6uHxxBhBt5ME9wB9UtWf8aCEGrZBKIaAqeqUtea
 y82GX274fl90RvKO4iqr+jyG7XbqRNqwvU01fFTEVOE6Y26yuXW4Vz9cI14NfM8V99m8
 dh86lteFWeXTJLvMEO0dgBieBWX6V0ixzO00gdI2+DCRm9hIP1GNanWI2onMcRsSN/yy
 0V7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMdd9OlXJF0qKzDPRRamY6BKyXv5Zb5V+tQ4ZRWEM38LhSCeaYdDEuCSN3vJDcQKD1OdJBhVnY8cSJL8SxXEEfeUf/uP8=
X-Gm-Message-State: AOJu0Yy+0gT+FG1N8pSLpmx3Ls2He8n6IN3Vq/xxZT2+oJvwPT1xJboN
 UEAyk2F11Wd5rjvF+yfY+bKWYTW4Cgkd0CmhnkYSudzzJ4d8ZrhQLCpviJ4FDTrBkJsvjbYKZG2
 j1dDOiqxZgQyX4yfrElBxvTLPArBoE+MsPf24ymM3E5p5MkxBcqgYmGo5n95Foxk1RQmZT8NXvf
 DAem+wjB0Zv65pbtctpOb0btH92O4=
X-Received: by 2002:a17:907:e6e4:b0:a7a:9ca6:527 with SMTP id
 a640c23a62f3a-a80aa557aa3mr620518966b.8.1723456774086; 
 Mon, 12 Aug 2024 02:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3RFNxx0Bpd/Kju5djSBc0p79tBUazXImqUeViKFfpoo5ZwYsM/6Noy0sQqCdXFRMtxzsc5tzq/V0sB3UxzdE=
X-Received: by 2002:a17:907:e6e4:b0:a7a:9ca6:527 with SMTP id
 a640c23a62f3a-a80aa557aa3mr620517466b.8.1723456773634; Mon, 12 Aug 2024
 02:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240809064940.1788169-1-anisinha@redhat.com>
 <8913b8c7-4103-4f69-8567-afdc29f8d0d3@linaro.org>
 <CAK3XEhM+SR39vYxG_ygQ=hCj_bmDE3dOH6EPFQZbLYrE-Yj-ow@mail.gmail.com>
In-Reply-To: <CAK3XEhM+SR39vYxG_ygQ=hCj_bmDE3dOH6EPFQZbLYrE-Yj-ow@mail.gmail.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Mon, 12 Aug 2024 15:29:20 +0530
Message-ID: <CAK3XEhPZ8X1-Ui6pJ+kYY3Er-N-zW0f5MqpLyaU7t2d3qaQXkA@mail.gmail.com>
Subject: Re: [PATCH v3] kvm: replace fprintf with error_report/printf() in
 kvm_init()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org, 
 Zhao Liu <zhao1.liu@intel.com>, kvm@vger.kernel.org, 
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c74cf1061f798ce1"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--000000000000c74cf1061f798ce1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Aug, 2024, 3:23 pm Ani Sinha, <anisinha@redhat.com> wrote:

> On Fri, Aug 9, 2024 at 2:06=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philm=
d@linaro.org>
> wrote:
> >
> > Hi Ani,
> >
> > On 9/8/24 08:49, Ani Sinha wrote:
> > > error_report() is more appropriate for error situations. Replace
> fprintf with
> > > error_report. Cosmetic. No functional change.
> > >
> > > CC: qemu-trivial@nongnu.org
> > > CC: zhao1.liu@intel.com
> >
> > (Pointless to carry Cc line when patch is already reviewed next line)
> >
> > > Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> > > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > > ---
> > >   accel/kvm/kvm-all.c | 40 ++++++++++++++++++----------------------
> > >   1 file changed, 18 insertions(+), 22 deletions(-)
> > >
> > > changelog:
> > > v2: fix a bug.
> > > v3: replace one instance of error_report() with error_printf(). added
> tags.
> > >
> > > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > > index 75d11a07b2..5bc9d35b61 100644
> > > --- a/accel/kvm/kvm-all.c
> > > +++ b/accel/kvm/kvm-all.c
> > > @@ -2427,7 +2427,7 @@ static int kvm_init(MachineState *ms)
> > >       QLIST_INIT(&s->kvm_parked_vcpus);
> > >       s->fd =3D qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
> > >       if (s->fd =3D=3D -1) {
> > > -        fprintf(stderr, "Could not access KVM kernel module: %m\n");
> > > +        error_report("Could not access KVM kernel module: %m");
> > >           ret =3D -errno;
> > >           goto err;
> > >       }
> > > @@ -2437,13 +2437,13 @@ static int kvm_init(MachineState *ms)
> > >           if (ret >=3D 0) {
> > >               ret =3D -EINVAL;
> > >           }
> > > -        fprintf(stderr, "kvm version too old\n");
> > > +        error_report("kvm version too old");
> > >           goto err;
> > >       }
> > >
> > >       if (ret > KVM_API_VERSION) {
> > >           ret =3D -EINVAL;
> > > -        fprintf(stderr, "kvm version not supported\n");
> > > +        error_report("kvm version not supported");
> > >           goto err;
> > >       }
> > >
> > > @@ -2488,26 +2488,22 @@ static int kvm_init(MachineState *ms)
> > >       } while (ret =3D=3D -EINTR);
> > >
> > >       if (ret < 0) {
> > > -        fprintf(stderr, "ioctl(KVM_CREATE_VM) failed: %d %s\n", -ret=
,
> > > -                strerror(-ret));
> > > +        error_report("ioctl(KVM_CREATE_VM) failed: %d %s", -ret,
> > > +                    strerror(-ret));
> > >
> > >   #ifdef TARGET_S390X
> > >           if (ret =3D=3D -EINVAL) {
> > > -            fprintf(stderr,
> > > -                    "Host kernel setup problem detected. Please
> verify:\n");
> > > -            fprintf(stderr, "- for kernels supporting the
> switch_amode or"
> > > -                    " user_mode parameters, whether\n");
> > > -            fprintf(stderr,
> > > -                    "  user space is running in primary address
> space\n");
> > > -            fprintf(stderr,
> > > -                    "- for kernels supporting the vm.allocate_pgste
> sysctl, "
> > > -                    "whether it is enabled\n");
> > > +            error_report("Host kernel setup problem detected.
> >
> > \n"
> >
> > Should we use error_printf_unless_qmp() for the following?
>
> Do you believe that qemu_init() -> configure_accelerators() ->
> do_configure_accelerator,() -> accel_init_machine() -> kvm_init()  can
> be called from QMP context?
>

To clarify, that is the only path I saw that calls kvm_init()


> >
> > " Please verify:");
> > > +            error_report("- for kernels supporting the switch_amode
> or"
> > > +                        " user_mode parameters, whether");
> > > +            error_report("  user space is running in primary address
> space");
> > > +            error_report("- for kernels supporting the
> vm.allocate_pgste "
> > > +                        "sysctl, whether it is enabled");
> > >           }
> > >   #elif defined(TARGET_PPC)
> > >           if (ret =3D=3D -EINVAL) {
> > > -            fprintf(stderr,
> > > -                    "PPC KVM module is not loaded.
> >
> > \n"
> >
> > Ditto.
> >
> > " Try modprobe kvm_%s.\n",
> > > -                    (type =3D=3D 2) ? "pr" : "hv");
> > > +            error_report("PPC KVM module is not loaded. Try modprobe
> kvm_%s.",
> > > +                        (type =3D=3D 2) ? "pr" : "hv");
> > >           }
> > >   #endif
> > >           goto err;
> > > @@ -2526,9 +2522,9 @@ static int kvm_init(MachineState *ms)
> > >                           nc->name, nc->num, soft_vcpus_limit);
> > >
> > >               if (nc->num > hard_vcpus_limit) {
> > > -                fprintf(stderr, "Number of %s cpus requested (%d)
> exceeds "
> > > -                        "the maximum cpus supported by KVM (%d)\n",
> > > -                        nc->name, nc->num, hard_vcpus_limit);
> > > +                error_report("Number of %s cpus requested (%d)
> exceeds "
> > > +                             "the maximum cpus supported by KVM (%d)=
",
> > > +                             nc->name, nc->num, hard_vcpus_limit);
> > >                   exit(1);
> > >               }
> > >           }
> > > @@ -2542,8 +2538,8 @@ static int kvm_init(MachineState *ms)
> > >       }
> > >       if (missing_cap) {
> > >           ret =3D -EINVAL;
> > > -        fprintf(stderr, "kvm does not support %s\n%s",
> > > -                missing_cap->name, upgrade_note);
> > > +        error_printf("kvm does not support %s\n%s",
> > > +                     missing_cap->name, upgrade_note);
> >
> > Similarly, should we print upgrade_note using error_printf_unless_qmp?
> >
> > >           goto err;
> > >       }
> > >
> >
>

--000000000000c74cf1061f798ce1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Mon, 12 Aug, 2024, 3:23 pm Ani Sinha, &lt;<a href=
=3D"mailto:anisinha@redhat.com">anisinha@redhat.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">On Fri, Aug 9, 2024 at 2:06=E2=80=AFPM Phil=
ippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org" target=3D"=
_blank" rel=3D"noreferrer">philmd@linaro.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Ani,<br>
&gt;<br>
&gt; On 9/8/24 08:49, Ani Sinha wrote:<br>
&gt; &gt; error_report() is more appropriate for error situations. Replace =
fprintf with<br>
&gt; &gt; error_report. Cosmetic. No functional change.<br>
&gt; &gt;<br>
&gt; &gt; CC: <a href=3D"mailto:qemu-trivial@nongnu.org" target=3D"_blank" =
rel=3D"noreferrer">qemu-trivial@nongnu.org</a><br>
&gt; &gt; CC: <a href=3D"mailto:zhao1.liu@intel.com" target=3D"_blank" rel=
=3D"noreferrer">zhao1.liu@intel.com</a><br>
&gt;<br>
&gt; (Pointless to carry Cc line when patch is already reviewed next line)<=
br>
&gt;<br>
&gt; &gt; Reviewed-by: Zhao Liu &lt;<a href=3D"mailto:zhao1.liu@intel.com" =
target=3D"_blank" rel=3D"noreferrer">zhao1.liu@intel.com</a>&gt;<br>
&gt; &gt; Signed-off-by: Ani Sinha &lt;<a href=3D"mailto:anisinha@redhat.co=
m" target=3D"_blank" rel=3D"noreferrer">anisinha@redhat.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 =C2=A0accel/kvm/kvm-all.c | 40 ++++++++++++++++++----------=
------------<br>
&gt; &gt;=C2=A0 =C2=A01 file changed, 18 insertions(+), 22 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; changelog:<br>
&gt; &gt; v2: fix a bug.<br>
&gt; &gt; v3: replace one instance of error_report() with error_printf(). a=
dded tags.<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c<br>
&gt; &gt; index 75d11a07b2..5bc9d35b61 100644<br>
&gt; &gt; --- a/accel/kvm/kvm-all.c<br>
&gt; &gt; +++ b/accel/kvm/kvm-all.c<br>
&gt; &gt; @@ -2427,7 +2427,7 @@ static int kvm_init(MachineState *ms)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0QLIST_INIT(&amp;s-&gt;kvm_parked_vcpus)=
;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;fd =3D qemu_open_old(s-&gt;device=
 ?: &quot;/dev/kvm&quot;, O_RDWR);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;fd =3D=3D -1) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Could not acce=
ss KVM kernel module: %m\n&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Could not access =
KVM kernel module: %m&quot;);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -errno;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; @@ -2437,13 +2437,13 @@ static int kvm_init(MachineState *ms)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &gt;=3D 0) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EI=
NVAL;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;kvm version to=
o old\n&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;kvm version too o=
ld&quot;);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &gt; KVM_API_VERSION) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EINVAL;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;kvm version no=
t supported\n&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;kvm version not s=
upported&quot;);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt; @@ -2488,26 +2488,22 @@ static int kvm_init(MachineState *ms)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} while (ret =3D=3D -EINTR);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;ioctl(KVM_CREA=
TE_VM) failed: %d %s\n&quot;, -ret,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strerror=
(-ret));<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;ioctl(KVM_CREATE_=
VM) failed: %d %s&quot;, -ret,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 strerror(-ret));<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0#ifdef TARGET_S390X<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D -EINVAL) {=
<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;Host kernel setup problem detected. Please verify:\n&quot;);<b=
r>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;=
- for kernels supporting the switch_amode or&quot;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot; user_mode parameters, whether\n&quot;);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;=C2=A0 user space is running in primary address space\n&quot;)=
;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;- for kernels supporting the vm.allocate_pgste sysctl, &quot;<=
br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;whether it is enabled\n&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Hos=
t kernel setup problem detected.<br>
&gt;<br>
&gt; \n&quot;<br>
&gt;<br>
&gt; Should we use error_printf_unless_qmp() for the following?<br>
<br>
Do you believe that qemu_init() -&gt; configure_accelerators() -&gt;<br>
do_configure_accelerator,() -&gt; accel_init_machine() -&gt; kvm_init()=C2=
=A0 can<br>
be called from QMP context?<br></blockquote></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">To clarify, that is the only path I saw that cal=
ls kvm_init()</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;<br>
&gt; &quot; Please verify:&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;- f=
or kernels supporting the switch_amode or&quot;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &quot; user_mode parameters, whether&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;=C2=
=A0 user space is running in primary address space&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;- f=
or kernels supporting the vm.allocate_pgste &quot;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &quot;sysctl, whether it is enabled&quot;);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;=C2=A0 =C2=A0#elif defined(TARGET_PPC)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D -EINVAL) {=
<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;PPC KVM module is not loaded.<br>
&gt;<br>
&gt; \n&quot;<br>
&gt;<br>
&gt; Ditto.<br>
&gt;<br>
&gt; &quot; Try modprobe kvm_%s.\n&quot;,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (type =3D=3D 2) ? &quot;pr&quot; : &quot;hv&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;PPC=
 KVM module is not loaded. Try modprobe kvm_%s.&quot;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 (type =3D=3D 2) ? &quot;pr&quot; : &quot;hv&quot;);<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;=C2=A0 =C2=A0#endif<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt; &gt; @@ -2526,9 +2522,9 @@ static int kvm_init(MachineState *ms)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nc-&gt;name, nc-&gt;num, soft_vcpus_limit);<=
br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nc-&gt;=
num &gt; hard_vcpus_limit) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(=
stderr, &quot;Number of %s cpus requested (%d) exceeds &quot;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &quot;the maximum cpus supported by KVM (%d)\n&quot;,<=
br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 nc-&gt;name, nc-&gt;num, hard_vcpus_limit);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_re=
port(&quot;Number of %s cpus requested (%d) exceeds &quot;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;the maximum cpus supported b=
y KVM (%d)&quot;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nc-&gt;name, nc-&gt;num, hard_vcpu=
s_limit);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0exit(1);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; @@ -2542,8 +2538,8 @@ static int kvm_init(MachineState *ms)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (missing_cap) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EINVAL;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;kvm does not s=
upport %s\n%s&quot;,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 missing_=
cap-&gt;name, upgrade_note);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_printf(&quot;kvm does not supp=
ort %s\n%s&quot;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0missing_cap-&gt;name, upgrade_note);<br>
&gt;<br>
&gt; Similarly, should we print upgrade_note using error_printf_unless_qmp?=
<br>
&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt;<br>
</blockquote></div></div></div>

--000000000000c74cf1061f798ce1--


