Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A42EF06E2
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 14:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vp5tG-0002UA-Fr; Sun, 08 Feb 2026 09:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vp5tA-0002QN-Pa
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 09:35:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vp5t3-00042o-2j
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 09:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770561343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wBY7C5osNXIl9U9eQIGGBuwr5RKgeq0XS9iQwnmA8JM=;
 b=i1zRzoinf75mKaYuGIMNCF2IuXXtjJ48J0hJu+VqH5KD11R6V0wNrKrHWNMLUZVVHg1GM8
 b+qA2mAwbaq0FayIIvPy6VYMjSS+ZwM5ROxfmbtSLEGB1mVfJLeK8A+rymvuqm+LIjlsbL
 CsiS/fMDXixgvThdo2bLs3mmj9nnDQA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-0frpJoyfP72xciM6LW405w-1; Sun, 08 Feb 2026 09:35:42 -0500
X-MC-Unique: 0frpJoyfP72xciM6LW405w-1
X-Mimecast-MFC-AGG-ID: 0frpJoyfP72xciM6LW405w_1770561342
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8c882774f0dso625018385a.2
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 06:35:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770561342; cv=none;
 d=google.com; s=arc-20240605;
 b=JRyA9xwZvhyyEaM/bOT3IZ+zau9Z/f996Y5yfthHRyBb2JuERJFNI+84H3YndgBI8b
 P5M1A5FLycCC64gDju8qJXLEuSIogXifR31FFh+5iyWnr+JBjHURnkpiYopvqp+FFbhA
 ilKs+lB3yZ8UAycjoZ7f53tQvkPKXH/gvDLXx502Q75H75o27/X1bmOc/hXaTKSgWe8m
 EpekwOa4OrVYls+9B+331s/kvSnhU6tszQQYuy0/VNTpubzk6C78FBYkwAYZwoaY+3jI
 4S5sSV6tTMkY07zsuPOJc2EU6ABHhswCaRKVQfvOpLRRZRaoY0tN/LI8VEh4I4Fnr9ET
 WKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wBY7C5osNXIl9U9eQIGGBuwr5RKgeq0XS9iQwnmA8JM=;
 fh=1imIRpa1mEsd9pDUB5z0PwS8c7BMY3GW9+aB9w/XFRw=;
 b=H02D2egtKFBgnBotmUAJy/v5C0Kmt+3MfXXopylIHXFKVjHG9ggyZD9mDQKr6FR8kx
 ZrtmFn70Ao2tOXY/wVK1D6n8kwEBCgM2ZTwr9jl4HhaPG3IfV4tGlVACQsbISMb27Am3
 D9lVwBfmJOz5VZY+MXkbjOVfHrjf3E9bQzPwp9aynj5KTsa60KhwX/0sP+oamcmayEgx
 jsZrYoG9cQ5VD/q8XptYIOWfRJqUG2Ia18VDvgdIWa9p6gIhj9Bq4lIcn1wC8UcO7jq8
 KDCAg8q4+qq5uMVTgwWE8HB5foHol9y2zrds2s0nedFxqUczASHzn3vumiCQluji5b/g
 TdSg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770561342; x=1771166142; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wBY7C5osNXIl9U9eQIGGBuwr5RKgeq0XS9iQwnmA8JM=;
 b=gYyyPSi9OIDhP9D0cbSHQ2FYjEmkhH3VH01685TxZrtUByntZEINcyigsT5/xic1uN
 mdXKHQP+H+ONsUYzoHXCfjwgWDVcZ6SWWk80Bm6vpZQEbiRhgI6PsP3h3yjO+0FeLWE/
 MIOubE7PcjttE/MMse0IyPePYgIMhH8VsibBtuj0gmvtu61WArTkmK/jT6uLg8l0Usbr
 2RvyA5KOuWyDOLHFcSQ/RggFLqP7//dsB6pRTgiML/oYxbQtlsiYGqEvtAE4Vt9tRExi
 quUZH2ZDKvEVFl1fzk0dng+0ru02WQ6Kz3vhNoSiZpBfemdOXUOBbSFPlT8GothhOqTF
 omDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770561342; x=1771166142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wBY7C5osNXIl9U9eQIGGBuwr5RKgeq0XS9iQwnmA8JM=;
 b=E9pZIzIs6YfMEBIoEWcaBCki02Ynr1pchx5BVs3LA93EWhVIQRbysGlx8QcKIvgh8B
 79FIjhy5olzejukiRlXYwzw1MpdVckSpIFeBtwmGqikWnj1C/KvENVQ1QEKJXZ6ukf50
 P09vVDqF+he+pwRdwv2NZIW4/hz5r3jn254NtXCz5vAAQXlECCeLtMUgitoXJDf1u89j
 xyRa+nkKW/Twb+0/bNfNV1ErduuHNikk4PMlZLFUbhs8Ezobtqar3z+8u9w1LgBfNvUW
 qyUogCQ9IjDMutPCpNpxUmQbJ+lqgetnncmTaJywNBbNpFsscvWRdZyONGuG+DA5H30f
 r7Fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaTN0SBKQ8o4OC2qNFP5P7M1EUBVCFoPsW7zCrGrx/4FuqS6btfz87+BNB2jDqACx9rsOKEmcAQnMv@nongnu.org
X-Gm-Message-State: AOJu0Yx2/N508vS6OztfyIJWj7CZ0S2bgnO+nF2rYqEWsdz9Y2tipnao
 CAXe4F1ksIs4TJ+KMzVgKOBPGVd5AZk+oocP4Fb2wZaWCgn+rRPMC7MawYSaofmKnPVbVr+CYW9
 fEEXpfLYKFGQrnZSZE/fGZuSoc1IieXj/JXSquy84/TcALdhHtUmQNu/FM+Em43l1BrLi/9uAT/
 DiAPyE0WEEB6e7TN1RR8sRj/Pb/iJHKwg=
X-Gm-Gg: AZuq6aLyQcoE4iII1MXCMuqLtTN6dpFepkV51K6I7p5BBCA46Pn/JtwzOQDedgeDKzQ
 +lEaloEe/5pQq57H0LgTgMgPBes69A2xnsN6obhXwSyIEA3tIkMrVrpDy5rJ79yP4ZZhujwaZzo
 YQKFPfjDWR/RUw5RIn7SmYmEUfmPth1O9xdXjnA9vWjw5QZeHevBknjcM8SZbxuQZLu9dftU2yn
 0J0bCYuR68lTGe7njRYcCxwdtE3
X-Received: by 2002:a05:620a:2906:b0:8c7:1b3c:8e8 with SMTP id
 af79cd13be357-8caef9d452fmr1003201985a.40.1770561341645; 
 Sun, 08 Feb 2026 06:35:41 -0800 (PST)
X-Received: by 2002:a05:620a:2906:b0:8c7:1b3c:8e8 with SMTP id
 af79cd13be357-8caef9d452fmr1003200485a.40.1770561341204; Sun, 08 Feb 2026
 06:35:41 -0800 (PST)
MIME-Version: 1.0
References: <20260127051612.219475-1-anisinha@redhat.com>
 <20260127051612.219475-25-anisinha@redhat.com>
In-Reply-To: <20260127051612.219475-25-anisinha@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Sun, 8 Feb 2026 20:05:28 +0530
X-Gm-Features: AZwV_QjYWKQsTf80JGkrdDzB02aPv1MqFqHdkNHZxVcTqfEBmROMxPd2Tjo6KKo
Message-ID: <CAK3XEhNTkwRpebXmChP4vxCfQbeZv75--LBQA1ZhDCCP+OFgFg@mail.gmail.com>
Subject: Re: [PATCH v3 24/33] kvm/i8254: add support for confidential guest
 reset
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: kraxel@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jan 27, 2026 at 10:47=E2=80=AFAM Ani Sinha <anisinha@redhat.com> wr=
ote:
>
> A confidential guest reset involves closing the old virtual machine KVM f=
ile
> descriptor and opening a new one. Since its a new KVM fd, PIT needs to be
> reinitialized again. This is done with the help of a notifier which is in=
voked
> upon KVM vm file desciptor change during confidential guest reset process=
.
                                  ^^^^^^^^
will fix the above typo and also add a functional test to exercise the
changes in this patch for the next spin up.

>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  hw/i386/kvm/i8254.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
> index 255047458a..a754de0c8d 100644
> --- a/hw/i386/kvm/i8254.c
> +++ b/hw/i386/kvm/i8254.c
> @@ -52,6 +52,8 @@ struct KVMPITState {
>      LostTickPolicy lost_tick_policy;
>      bool vm_stopped;
>      int64_t kernel_clock_offset;
> +
> +    NotifierWithReturn kvmpit_vmfd_change_notifier;
>  };
>
>  struct KVMPITClass {
> @@ -203,6 +205,21 @@ static void kvm_pit_put(PITCommonState *pit)
>      }
>  }
>
> +static int kvmpit_post_vmfd_change(NotifierWithReturn *notifier,
> +                                   void *data, Error** errp)
> +{
> +    KVMPITState *s =3D container_of(notifier, KVMPITState,
> +                                  kvmpit_vmfd_change_notifier);
> +
> +    /* we are not interested in pre vmfd change notification */
> +    if (((VmfdChangeNotifier *)data)->pre) {
> +        return 0;
> +    }
> +
> +    do_pit_initialize(s, errp);
> +    return 0;
> +}
> +
>  static void kvm_pit_set_gate(PITCommonState *s, PITChannelState *sc, int=
 val)
>  {
>      kvm_pit_get(s);
> @@ -292,6 +309,9 @@ static void kvm_pit_realizefn(DeviceState *dev, Error=
 **errp)
>
>      qemu_add_vm_change_state_handler(kvm_pit_vm_state_change, s);
>
> +    s->kvmpit_vmfd_change_notifier.notify =3D kvmpit_post_vmfd_change;
> +    kvm_vmfd_add_change_notifier(&s->kvmpit_vmfd_change_notifier);
> +
>      kpc->parent_realize(dev, errp);
>  }
>
> --
> 2.42.0
>


