Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34661C2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 15:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKJOq-0007Uh-Ub; Thu, 20 Jun 2024 11:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKJOk-0007SS-KV
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:08:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKJOi-0005Qt-H0
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718896104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tnwlUINMYdkSjNNUvhTv/cJTouCJchLU6F0iVgCDDKg=;
 b=SG4ih+enNV5hkSUehPhPa7TLUVHACzCqN1ZrqwFbjkAfUB3FIyBrB1GDOQZ8z6JOcAw+b8
 u9huEkmh81+V2HsjEVV/pmU6VJhYE4vpIhmibWGOiqzU2NFMnklwilM3UnuyVvxV1uPo7e
 ZH2X0gHMdeRc4tKsrBOFsJel5j1K6Go=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-lZwKc3LzMl6x2GMw07Nh8w-1; Thu, 20 Jun 2024 11:08:22 -0400
X-MC-Unique: lZwKc3LzMl6x2GMw07Nh8w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36279cf642cso367104f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 08:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718896101; x=1719500901;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tnwlUINMYdkSjNNUvhTv/cJTouCJchLU6F0iVgCDDKg=;
 b=HruH1j9mc32UNT+0CKP7igl5PwNWby7C5YWCrh4vQJR2o4K2vvNgz05xpNePCQst0X
 z1mamQfcnrhv6wEYyev05oDXNgLghm8s+Y9tq47ITVr7ebklMbzAeOqRt3qertOmQGsc
 mlhc4VBotb2xc5qT2GUyHRcxTrdh4fEFtcAmhH3C4zpisSGSiHLTnsfFkner/gLGzXXF
 XnAg8ccyFZhlDd/3xBKjxT7pYIIZ2XXqKgIy/LIawRjGCAF2bhCj/LdPs6h6BxXcgxom
 /Z3SSK2xwtGm6UN1l5VBovlUjaQqGTJDh0RG2zR6FjgpQEO0VJkJ+yd3i0R0Y+UE/SOx
 hBiQ==
X-Gm-Message-State: AOJu0Yydm6Eup974x2AglOf81yE7rsvwbNyFTflfLHsG5iEkmD3BpBFa
 4UbQU7t7lVRsmYlcUBkuQaV5x9kPN07scMmCMc/NjebTi1xK9uGFtv69ryXaVI1OA99ESS6QWee
 CVoNT+H31VrG7tiqsk6Mp/Ihd17lDtXHEukegxXXVWzHMj49r0cfLb4wVJI5zQZEmhkeOzCbHoZ
 PkHmm3UTnx3AXZTcG3IOiT3Rte/sw=
X-Received: by 2002:a5d:4242:0:b0:364:9941:cf92 with SMTP id
 ffacd0b85a97d-3649941d063mr1835949f8f.50.1718896101515; 
 Thu, 20 Jun 2024 08:08:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6GFNaXFlqpa9vAlz8WXSXb1ocs/ahi1wl+snM9E2atpiLaGE4Zy5lyurtMegh1WkonnFNsRFobdUbv0i7LEY=
X-Received: by 2002:a5d:4242:0:b0:364:9941:cf92 with SMTP id
 ffacd0b85a97d-3649941d063mr1835938f8f.50.1718896101178; Thu, 20 Jun 2024
 08:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240620130254.415699-1-pbonzini@redhat.com>
 <20240620130254.415699-7-pbonzini@redhat.com>
 <ZnRETaWTb57K0VO3@redhat.com>
In-Reply-To: <ZnRETaWTb57K0VO3@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 20 Jun 2024 17:08:10 +0200
Message-ID: <CABgObfZca69nJ-r2nqnmuSFREw+FZcvDKgengE_FfcP+CkiPwQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] meson: require compiler support for chosen x86-64
 instructions
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, amonakov@ispras.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
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

On Thu, Jun 20, 2024 at 5:01=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> >  config_host_data.set('CONFIG_AVX2_OPT', get_option('avx2') \
> > +  .enable_auto_if(get_option('x86_version') >=3D '3') \
> >    .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot=
 enable AVX2') \
> >    .require(cc.links('''
> >      #include <cpuid.h>
> > @@ -2875,6 +2876,7 @@ config_host_data.set('CONFIG_AVX2_OPT', get_optio=
n('avx2') \
> >    '''), error_message: 'AVX2 not available').allowed())
> >
> >  config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
> > +  .enable_auto_if(get_option('x86_version') >=3D '4') \
> >    .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot=
 enable AVX512BW') \
> >    .require(cc.links('''
> >      #include <cpuid.h>
>
> I'm not sure this makes sense. The CONFIG_AVX* options are used only
> to validate whether the toolchain has support for this. The QEMU
> code then has a runtime, so it automagically uses AVX2/AVX512
> if-and-only-if running on a suitably new CPU.  IOW, we want this
> enabled always when the toolchain supports it, regardless of what
> x86_version is set.

The difference is that if the toolchain does not support AVX2/AVX512
intrinsics for some reason, and you require -Dx86_version=3D{3,4}, meson
would report an error with this patch.

Paolo


