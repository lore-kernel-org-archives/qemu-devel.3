Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE8EC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 09:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reXhy-0000ch-Od; Mon, 26 Feb 2024 04:55:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1reXhv-0000cG-MK
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:55:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1reXhr-0003Ez-Bz
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:55:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708941329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JdRiONgdu9DBpB+u5/6Zl5DGOKX1Qb1QOLz1pWFcZBM=;
 b=ekD78CpbdUoDL1GX/PXilh8DA4J/BfrZWiMblKh4ElktXswX1RF8BeVRgrFjO1YzvhET3K
 985qP5xnk1VAvfy83OiIB5rD/H3kBUVO7m5spF7gRHplAyu7n/tse77AD4F1uBsyltBD/K
 t83CYca3SWfrIbpvmspM4MBgddCS9uI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-EYkY4hREMHeT2XwuGLK7Fg-1; Mon, 26 Feb 2024 04:55:27 -0500
X-MC-Unique: EYkY4hREMHeT2XwuGLK7Fg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33d23c8694dso1359233f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 01:55:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708941325; x=1709546125;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JdRiONgdu9DBpB+u5/6Zl5DGOKX1Qb1QOLz1pWFcZBM=;
 b=XlNxCAB3P9txu8iQpHmF2JUjk+y/sbaTeMPFqdVkMQMqB62U40DubfB4grbLIF7DtG
 ypYRWtK4JluXiSxhKcdxAXilT2r90waBDSrEOl784jpNlq7HOZ+yBWMZQ/9XjyDpXiGH
 yqDm1iDvJQkuvBGZaWd9XsVbYdg0jkwH5y5LBtCfQ0TO8nUHx2JXF6qQLtamGfi6NcB1
 dHwZldioKLr9hFudsK6/o4eB05f3RZbTCLZRVVlTX6sY8JFc1BpmzcpiyYJ/luZ6Vicb
 WB7dGfqSlUFRswv1x81BoOcwEdH6VsbZ/NtHzmRrUltmHXjRu7SVoRz6tQgGSNjrzcDd
 rTaA==
X-Gm-Message-State: AOJu0YxdIs37BqWuK0Rf7gWbOHdiIkFwj6UTQ4kx9GQDo2OlyKWCFpFh
 EuIIzDZ0AvynghuPjuw14iIirtV4AP693ZLeQeRHMBLFeEv+KyNu3dEoGrrm9jeaECpklWL+efM
 y8NSNhXtIoV5Lebj6zTs5cvFsGNwykh383a36aM5ULHCuQDDbp62tYw20YAiOlDdhjxjrN1ZMNM
 upVJJUvlvTmGhSmslbdWk76gG9utXZ1jtwdmk=
X-Received: by 2002:a05:6000:1a89:b0:33d:226e:cc2d with SMTP id
 f9-20020a0560001a8900b0033d226ecc2dmr5017500wry.2.1708941325501; 
 Mon, 26 Feb 2024 01:55:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFK7755RF90jVkXNBbMH/2m0lSGqvFq+QPiSo5/yJ24jnlH4VDlW+4EAEXDBGQ5832RPIM/50Ijguuz+Z3Gv2I=
X-Received: by 2002:a05:6000:1a89:b0:33d:226e:cc2d with SMTP id
 f9-20020a0560001a8900b0033d226ecc2dmr5017485wry.2.1708941325185; Mon, 26 Feb
 2024 01:55:25 -0800 (PST)
MIME-Version: 1.0
References: <20240223130948.237186-1-pbonzini@redhat.com>
 <20240223130948.237186-5-pbonzini@redhat.com>
 <ZdxNkStjZyB6iJtk@intel.com>
In-Reply-To: <ZdxNkStjZyB6iJtk@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Feb 2024 10:55:14 +0100
Message-ID: <CABgObfYz0MitUFmLkm3YncpmLFpQ=YOspr=KrYYWn7cFiuouKw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] target/i386: use separate MMU indexes for 32-bit
 accesses
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, mcb30@ipxe.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Feb 26, 2024 at 9:22=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
> On Fri, Feb 23, 2024 at 02:09:45PM +0100, Paolo Bonzini wrote:
> > Accesses from a 32-bit environment (32-bit code segment for instruction
> > accesses, EFER.LMA=3D=3D0 for processor accesses) have to mask away the
> > upper 32 bits of the address.  While a bit wasteful, the easiest way
> > to do so is to use separate MMU indexes.  These days, QEMU anyway is
> > compiled with a fixed value for NB_MMU_MODES.  Split MMU_USER_IDX,
> > MMU_KSMAP_IDX and MMU_KNOSMAP_IDX in two.
>
> Maybe s/in/into/ ?

Both are acceptable grammar.

> >  static inline int cpu_mmu_index_kernel(CPUX86State *env)
> >  {
> > -    return !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP_IDX :
> > -        ((env->hflags & HF_CPL_MASK) < 3 && (env->eflags & AC_MASK))
> > -        ? MMU_KNOSMAP_IDX : MMU_KSMAP_IDX;
> > +    int mmu_index_32 =3D (env->hflags & HF_LMA_MASK) ? 1 : 0;
> > +    int mmu_index_base =3D
> > +        !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
> > +        ((env->hflags & HF_CPL_MASK) < 3 && (env->eflags & AC_MASK)) ?=
 MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX;

> Change the line?

It's reformatted but the logic is the same.

- if !SMAP -> MMU_KNOSMAP_IDX

- if CPL < 3 && EFLAGS.AC - MMU_KNOSMAP_IDX

- else MMU_KSMAP_IDX

The only change is adding the "64" suffix, which is then changed to
32-bit if needed via mmu_index_32.

Paolo


