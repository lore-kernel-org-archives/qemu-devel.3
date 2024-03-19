Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798BFC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmaPv-0000N3-KX; Tue, 19 Mar 2024 10:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmaPs-0000LN-MJ
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmaPq-0006SE-Bw
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710858369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Rnk23+3fmwV2oFOeDSeB6OMWafjToUQTdZdLKt7ZaM=;
 b=Jb9kedGcOD6bZSzUOVY6I7jU/OXD6WEfm4mHo6oU9ZxVgDhXovcuS1NBY4/e/P6B62S1TY
 DsaMl3947+aYcYFCpzD/b1YMYyPxxg6X34CizoTyWA+Qoc/afcXROccwaYK6t6pr/pR7W0
 dTDpwBq0hkztGMfEv7IGR4addJ86xwI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-elP5ud9wN9GTkulvCR9m7g-1; Tue, 19 Mar 2024 10:26:07 -0400
X-MC-Unique: elP5ud9wN9GTkulvCR9m7g-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33dbbe709ffso2879446f8f.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 07:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710858367; x=1711463167;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Rnk23+3fmwV2oFOeDSeB6OMWafjToUQTdZdLKt7ZaM=;
 b=eewXf8rSbf3qgopSbOb6Fz903/ZbBxG5pk/6ExhAKP4FPi5f0c5s59pA+pCB0TFMdB
 8rMlX+8NjrPrjRLYLniWEkC1Tl9509q7v0uskpj9MXngvN4YLcPK7kBtr5g8y3ih/tLz
 qlf+HdGsAEq5u+H1Zm7Aoc1AlZIWCNqFJ5mJpod6DoAlKq2V4G6vLGZAc/VnhIjZY9IF
 OETjy5Fd5nVQXvTdSN8xUtM0jgvPrBKIrqXtOZFlWb3hWgo/zn3rQCLrHIdciAI6vQbv
 Dt3OEaxaZ7UtfOymwwPSXDjcK48+XVu0T8+t4u7V2PFT9PaEXvVOLcbEe5o6FUWk5niU
 qCUg==
X-Gm-Message-State: AOJu0YzffJG7H1ykGxLRu7W2K/k/aw9BdbxOjGgoWpu/b4Tw3MBs/+lw
 DjC8bye9runPNVr+u+3mFMCVfNOGmiAIpEhwIxqHuRiZMRUPcKXVwmMutKi5Uz0LD5Gt/QYeMVq
 XucZwjW3a5ThvbbdyreYAN6Rd2ihNYDSYzl9fpWsImS3brRVApd3nO2v0ZQgwsK309bzkqITcQn
 9Y0obAUWyiLMw6EL7IdXOyzssrO4s=
X-Received: by 2002:a5d:44c5:0:b0:33e:786c:3354 with SMTP id
 z5-20020a5d44c5000000b0033e786c3354mr11593263wrr.14.1710858366836; 
 Tue, 19 Mar 2024 07:26:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM1lZHr0I6xNE9h6Dl1eG65k7ZZgPIXGu85Vau172hHNyB2G3SKbiJ+jqKSrbUF6xLT1WEHmKjNAo1VxuQxsE=
X-Received: by 2002:a5d:44c5:0:b0:33e:786c:3354 with SMTP id
 z5-20020a5d44c5000000b0033e786c3354mr11593248wrr.14.1710858366481; Tue, 19
 Mar 2024 07:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240319140000.1014247-1-pbonzini@redhat.com>
 <20240319140000.1014247-7-pbonzini@redhat.com>
 <Zfmd55tus3nV5DJV@redhat.com>
In-Reply-To: <Zfmd55tus3nV5DJV@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Mar 2024 15:25:53 +0100
Message-ID: <CABgObfZ7ikZHG3EEQHoPKoMo+1JpF6Ntb_QXsYTgEw6zF1zXmQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] target/i386: Implement mc->kvm_type() to get VM type
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xiaoyao.li@intel.com, michael.roth@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Mar 19, 2024 at 3:15=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> > +int kvm_get_vm_type(MachineState *ms, const char *vm_type)
>
> The 'vm_type' parameter is never used here. What value is it expected
> to have, and should be diagnosing an error if some unexpected value
> is provided.

It's the value of the kvm-type machine property, if any; but no x86
machine defines one, so right now it's always NULL. I left it in
because then it's clearer than this is an implementation of
mc->kvm_type, but I can remove it or pass it down to
x86_confidential_guest_kvm_type().

Paolo

> > +{
> > +    int kvm_type =3D KVM_X86_DEFAULT_VM;
> > +
> > +    if (ms->cgs) {
> > +        if (!object_dynamic_cast(OBJECT(ms->cgs), TYPE_X86_CONFIDENTIA=
L_GUEST)) {
> > +            error_report("configuration type %s not supported for x86 =
guests",
> > +                         object_get_typename(OBJECT(ms->cgs)));
> > +            exit(1);
> > +        }
> > +        kvm_type =3D x86_confidential_guest_kvm_type(
> > +            X86_CONFIDENTIAL_GUEST(ms->cgs));
> > +    }
> > +
> > +    if (!kvm_is_vm_type_supported(kvm_type)) {
> > +        error_report("vm-type %s not supported by KVM", vm_type_name[k=
vm_type]);
> > +        exit(1);
> > +    }
> > +
> > +    return kvm_type;
> > +}
> > +
> >  bool kvm_has_smm(void)
> >  {
> >      return kvm_vm_check_extension(kvm_state, KVM_CAP_X86_SMM);
> > --
> > 2.44.0
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


