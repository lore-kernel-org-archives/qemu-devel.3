Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47041C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 10:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rohxs-0007yO-81; Mon, 25 Mar 2024 06:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rohxo-0007xm-PR
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:54:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rohxn-0002Rm-6o
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711364038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tklpr1vJNOxg8yYU0a597Klmyl1cv964Zi6PZfYxPIU=;
 b=c0jxoT5oH6RK8cp40BeswbYO7BoI/m9ChpBDtWy1Jxo3wyao41WzKvN/iobT3kTHn9I0gB
 g66Sb7UaWfOKvjrckr2lo2hlL4c0vtcocPIWH9nqbVVCsi4CXDcXKbP8BFiNPeUGTdBhlu
 YewXkJCYC5+eEcmFj8716YIerhypawg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-xtnpfwJuN2m8U7tLzFKLVw-1; Mon, 25 Mar 2024 06:53:54 -0400
X-MC-Unique: xtnpfwJuN2m8U7tLzFKLVw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-513e0c5f399so3551730e87.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 03:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711364033; x=1711968833;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tklpr1vJNOxg8yYU0a597Klmyl1cv964Zi6PZfYxPIU=;
 b=fSboky2VAe6iUPPgtl8Pn4AbtXauIVQ2/sfNmE5as3V/Y3iDJGz3P/CbxAl6L33IKl
 U6OvBQ9bF7jQgAm37bLGZwmLX91a19j5UIFKJSyQrzTzY/+1Z5FBR8OrQaABHPiBRwKX
 yQdD8iL269/VC3YHX+rSVsAhjPgKE94PMWdZ84iuc3I27n4rTNJShCiX/TmCEK8xGRtW
 FDqx/UGlobzRtjJSPcudAFUSdflCOi+xOtbd9uH+ssQGQJCRihEo/BYAFN0FY6qCQ1n6
 mv3TwmtcG9j3OowOtDrFbkrSZoUJOSkdG/RibPcKLyTOCk7iRK8Ul+A+kAuS69X9dXgN
 fGdg==
X-Gm-Message-State: AOJu0YxnqbbYoN+1kpI3CbGMPDnQzFGWsqIPxkvc/YLo63Nv3hLP1KFM
 5ltOo0Ox/r1VsZMqHT6ibPbFjlSYo4r1g4V2DlBgS5+7mAvDNDLMCqdYBkDVVewNFrsBlXH4suu
 rx9byI6gr9zhEN1PnYSf/FJemiTtCEn7HIJ2+iO6KGi0k4WFVRNY4CDxoG+dHG9IcYPkbpB1sfM
 pzLhnO0Qm/GJzOpgr+mARYPWkG/7A=
X-Received: by 2002:ac2:505c:0:b0:513:8f53:cab0 with SMTP id
 a28-20020ac2505c000000b005138f53cab0mr4822536lfm.27.1711364033434; 
 Mon, 25 Mar 2024 03:53:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGjmV+PWWd9dPCYqr19NbLDo2EHnAozs2FTMAbbEadjFVispshG+cdO4zA3Sy9gSMwxidal3ufSUPHueJBjBc=
X-Received: by 2002:ac2:505c:0:b0:513:8f53:cab0 with SMTP id
 a28-20020ac2505c000000b005138f53cab0mr4822525lfm.27.1711364032994; Mon, 25
 Mar 2024 03:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240322181116.1228416-1-pbonzini@redhat.com>
 <20240322181116.1228416-4-pbonzini@redhat.com>
 <4f6143f9-5322-4947-aa03-0f3fe87c868f@linaro.org>
In-Reply-To: <4f6143f9-5322-4947-aa03-0f3fe87c868f@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 25 Mar 2024 11:53:40 +0100
Message-ID: <CABgObfZfcONEB0vH+-3Of26tGK+9+TqZPBWTCU+enSYfPTWzZg@mail.gmail.com>
Subject: Re: [PATCH 03/26] confidential guest support: Add kvm_init() and
 kvm_reset() in class
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, xiaoyao.li@intel.com, michael.roth@amd.com, 
 david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Mar 25, 2024 at 9:33=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Xiaoyao,
>
> On 22/3/24 19:10, Paolo Bonzini wrote:
> > From: Xiaoyao Li <xiaoyao.li@intel.com>
> >
> > Different confidential VMs in different architectures all have the same
> > needs to do their specific initialization (and maybe resetting) stuffs
> > with KVM. Currently each of them exposes individual *_kvm_init()
> > functions and let machine code or kvm code to call it.
> >
> > To facilitate the introduction of confidential guest technology from
> > different x86 vendors, add two virtual functions, kvm_init() and kvm_re=
set()
> > in ConfidentialGuestSupportClass, and expose two helpers functions for
> > invodking them.
> >
> > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > Message-Id: <20240229060038.606591-1-xiaoyao.li@intel.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   include/exec/confidential-guest-support.h | 34 ++++++++++++++++++++++=
-
> >   1 file changed, 33 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/exec/confidential-guest-support.h b/include/exec/c=
onfidential-guest-support.h
> > index ba2dd4b5dfc..e5b188cffbf 100644
> > --- a/include/exec/confidential-guest-support.h
> > +++ b/include/exec/confidential-guest-support.h
> > @@ -23,7 +23,10 @@
> >   #include "qom/object.h"
> >
> >   #define TYPE_CONFIDENTIAL_GUEST_SUPPORT "confidential-guest-support"
> > -OBJECT_DECLARE_SIMPLE_TYPE(ConfidentialGuestSupport, CONFIDENTIAL_GUES=
T_SUPPORT)
> > +OBJECT_DECLARE_TYPE(ConfidentialGuestSupport,
> > +                    ConfidentialGuestSupportClass,
> > +                    CONFIDENTIAL_GUEST_SUPPORT)
> > +
> >
> >   struct ConfidentialGuestSupport {
> >       Object parent;
> > @@ -55,8 +58,37 @@ struct ConfidentialGuestSupport {
> >
> >   typedef struct ConfidentialGuestSupportClass {
> >       ObjectClass parent;
> > +
> > +    int (*kvm_init)(ConfidentialGuestSupport *cgs, Error **errp);
> > +    int (*kvm_reset)(ConfidentialGuestSupport *cgs, Error **errp);
>
> Can we get a docstring indicating what these functions return?
> Looking at the next patch, the KVM specific return value doesn't
> seem used, so can we return a boolean instead?

It is propagated all the way up to accel_init_machine().  _There_ it
isn't used, but I think it's not a good idea to return a "wrong" value
from kvm_arch_init() because we know that ultimately it isn't used. It
should be refactored top-down, though I admit that to be honest it
won't happen.

Paolo


