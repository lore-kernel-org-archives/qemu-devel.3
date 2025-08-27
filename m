Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0668DCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 08:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urB7i-0004Dm-3e; Wed, 27 Aug 2025 04:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1urB7f-000453-HE
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1urB7c-0003JN-F3
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756281783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=enLp0vSBb+0c5x5/f1QRe0OEzIP0CKokhxei+hbso8Q=;
 b=DYsgE0FwPOYbwZJQPbontNjhVGXzNM2Vv/baPzpbjl8UMayySErT1KCc38G7ZLjbOnF1go
 c5QCJCNzSBb/HIC/dyjFlGjTlTS74RnTtMxpknpH+J7iLR0JMNUuGbpSfmTjozOTxpAH9B
 5LVAV/34aU3qdYd7phGzdeY164Iku10=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-lQgbcFC1Px-RGvEVuuEMqg-1; Wed, 27 Aug 2025 04:03:02 -0400
X-MC-Unique: lQgbcFC1Px-RGvEVuuEMqg-1
X-Mimecast-MFC-AGG-ID: lQgbcFC1Px-RGvEVuuEMqg_1756281781
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4b0fa8190d4so19926821cf.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 01:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756281781; x=1756886581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=enLp0vSBb+0c5x5/f1QRe0OEzIP0CKokhxei+hbso8Q=;
 b=thPzgLVlBo8wQvWKAkNHo+7GnWs3wI9+DAMNNTNXrGK0EXg3htsVpK5cxr9QZtSQVf
 c4XBeKWiCVPBwa2WzyjYw1PAL+VsKFKdZkqhwKIyuruRAuy4/k+38AWJUpiAz19s7PJs
 jLjuO3lSedHOz1qqhrgHsiMTZiAQiDEzmI5LCfdYXiisyQsqOO8l3YGhZl9IwEkrcQzw
 LA3/k1DbfRlxZxK3MPzn4estx+ZNdCCMK4Y/q9OybgIrrhRmQ2djJKmVuMwmtbWjncZ0
 Oh/EAzizcQ3kdOTY4q5OGzfnijdtyYDVHUJGnDiLtOvbwpyDQq6pkNwD+G9PGiF41+mi
 aINw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9zCDOdUjowV/nyR5516z4xG/qKcUZQsIA/hIx+rq6vRiGmHt7Pt5BhgZtIBBlnB9T52OoQ3oklnmZ@nongnu.org
X-Gm-Message-State: AOJu0YzvQvwaWUmIsS/4PamBCqUqiTfrj6f3YR13Y8ZxH/6on8Fbz4y5
 GFM/aeoY9w7aORThRbHwnI09Bssy3tqVKnMwlOYCVpqnBIO0ZBp9FumZtGNSUXjlKadt4gcLP8K
 ZysllUcIFPcXpfdK/YdnmeFDFY910BGO3RDxA7UkMv/IDkhv8FP4VQGbH
X-Gm-Gg: ASbGncuvaA+mLVkbZcwavkADzGFv6y+dej5FBbFlNeywVslj/HT0uiGPV9OrvxCag/7
 ZZHgAk8+l5ZbVRh3UwIxlS+IEra4WKR2Q7DDovYG+a15PxgCn4eephSbMhKmJfLGfXMN+XnrLaK
 pb2Mh0m3fvpYuWdhRz8zzhoOAfAARGKMTceIzuyhBZofPpWGdg3qNfs5QO9a9FBynDQ3JNuHy+u
 iP2kIvRDBkxlIf3aVOA1AiSiG9B58hKSi9+/lyeJm+7jpYTR26rEgp2d1Y5ZGQPzWtz/bm8iiKb
 dU1zcZmMYjjXtJvsQtEnSOWNkkOl/Q==
X-Received: by 2002:ac8:5701:0:b0:4ab:6101:51e2 with SMTP id
 d75a77b69052e-4b2e76f6c03mr57981121cf.9.1756281781284; 
 Wed, 27 Aug 2025 01:03:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjdumMzp2Z+l6swklN4j5aUb2EpfFgXL9S5vFwcN5HdoqwTKpet5B8nF8HXyN0MZxdlb9lrA==
X-Received: by 2002:ac8:5701:0:b0:4ab:6101:51e2 with SMTP id
 d75a77b69052e-4b2e76f6c03mr57980831cf.9.1756281780814; 
 Wed, 27 Aug 2025 01:03:00 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b2b8e1cd7esm88574151cf.39.2025.08.27.01.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 01:03:00 -0700 (PDT)
Date: Wed, 27 Aug 2025 10:02:56 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 richard.henderson@linaro.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] kvm/kvm-all: make kvm_park/unpark_vcpu local to
 kvm-all.c
Message-ID: <20250827100256.64694a52@fedora>
In-Reply-To: <d109215c-2b3c-46e4-9fb2-49fe70076a5c@linaro.org>
References: <20250815065445.8978-1-anisinha@redhat.com>
 <20250826132322.7571b918@fedora>
 <d109215c-2b3c-46e4-9fb2-49fe70076a5c@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, 26 Aug 2025 17:09:27 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> On 26/8/25 13:23, Igor Mammedov wrote:
> > On Fri, 15 Aug 2025 12:24:45 +0530
> > Ani Sinha <anisinha@redhat.com> wrote:
> >  =20
> >> kvm_park_vcpu() and kvm_unpark_vcpu() is only used in kvm-all.c. Decla=
re it
> >> static, remove it from common header file and make it local to kvm-all=
.c
> >>
> >> Signed-off-by: Ani Sinha <anisinha@redhat.com> =20
> >=20
> > Reviewed-by: Ani Sinha <anisinha@redhat.com> =20
>=20
> Do you mean Igor Mammedov <imammedo@redhat.com>?

sorry for mistake,
I've surely meant myself

>=20
> >  =20
> >> ---
> >>   accel/kvm/kvm-all.c  |  4 ++--
> >>   include/system/kvm.h | 17 -----------------
> >>   2 files changed, 2 insertions(+), 19 deletions(-)
> >>
> >> changelog:
> >> unexport  kvm_unpark_vcpu() as well and remove unnecessary forward
> >> declarations.
> >>
> >> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> >> index 890d5ea9f8..f36dfe3349 100644
> >> --- a/accel/kvm/kvm-all.c
> >> +++ b/accel/kvm/kvm-all.c
> >> @@ -414,7 +414,7 @@ err:
> >>       return ret;
> >>   }
> >>  =20
> >> -void kvm_park_vcpu(CPUState *cpu)
> >> +static void kvm_park_vcpu(CPUState *cpu)
> >>   {
> >>       struct KVMParkedVcpu *vcpu;
> >>  =20
> >> @@ -426,7 +426,7 @@ void kvm_park_vcpu(CPUState *cpu)
> >>       QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
> >>   }
> >>  =20
> >> -int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id)
> >> +static int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id)
> >>   {
> >>       struct KVMParkedVcpu *cpu;
> >>       int kvm_fd =3D -ENOENT;
> >> diff --git a/include/system/kvm.h b/include/system/kvm.h
> >> index 3c7d314736..4fc09e3891 100644
> >> --- a/include/system/kvm.h
> >> +++ b/include/system/kvm.h
> >> @@ -317,23 +317,6 @@ int kvm_create_device(KVMState *s, uint64_t type,=
 bool test);
> >>    */
> >>   bool kvm_device_supported(int vmfd, uint64_t type);
> >>  =20
> >> -/**
> >> - * kvm_park_vcpu - Park QEMU KVM vCPU context
> >> - * @cpu: QOM CPUState object for which QEMU KVM vCPU context has to b=
e parked.
> >> - *
> >> - * @returns: none
> >> - */
> >> -void kvm_park_vcpu(CPUState *cpu);
> >> -
> >> -/**
> >> - * kvm_unpark_vcpu - unpark QEMU KVM vCPU context
> >> - * @s: KVM State
> >> - * @vcpu_id: Architecture vCPU ID of the parked vCPU
> >> - *
> >> - * @returns: KVM fd
> >> - */
> >> -int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id);
> >> -
> >>   /**
> >>    * kvm_create_and_park_vcpu - Create and park a KVM vCPU
> >>    * @cpu: QOM CPUState object for which KVM vCPU has to be created an=
d parked. =20
> >=20
> >  =20
>=20


