Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CD5C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 12:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taZY8-00044N-AE; Wed, 22 Jan 2025 07:09:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1taZY0-000431-CM
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 07:09:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1taZXx-00079J-CL
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 07:09:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737547757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jfFLP6SeqWLVOYw05jBl3QcCVmlxwHdTsD1le28kfLI=;
 b=GhhSAFAQ7lxap1dLFLt/j9ckHlwRs9ozTfnB9vvAxc2OCslhp0yz64u9W+/YvaO8CUf6jf
 8jxKhJO8jeGUW8uGpQW14pIotrsYgopso3F5dgTpq6SuKmOyh5LdVkOwoKCG+CEonubQBy
 bJDQ2EcscFrrAaWo3t2kOW1d7nuQOBc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-CG5_x0xcOy2Xn1iB2unM2g-1; Wed, 22 Jan 2025 07:09:16 -0500
X-MC-Unique: CG5_x0xcOy2Xn1iB2unM2g-1
X-Mimecast-MFC-AGG-ID: CG5_x0xcOy2Xn1iB2unM2g
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5d40c0c728aso5830916a12.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 04:09:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737547755; x=1738152555;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jfFLP6SeqWLVOYw05jBl3QcCVmlxwHdTsD1le28kfLI=;
 b=vrzNKlLx4xHDDSQ96KnWxwsXSmjOEqqyP0kcPOUE+w0fyB+P/BX5aidg/F7E7rHbGA
 DVVWte6LG1VyoULoqnf4aU3HUNbDRQH1rfmerPK0W4/vNoxM2pYuGtkhN9GgImOEBohB
 ZMhKZdFAUg+lE/JMhObfgSjqXobrZx587ts1yX/stU+tFZYsQMOSP7ajeyTmFF4elgrU
 hS5Z63jowaRPFzrFRu89UPSxmKdN0G9cZLuZiO0nv589eeJD7ot8MEvsC1xI474SYQdg
 2A60Zxp8GiXFB2p/VSiN7NDYPnWCGJPrYjt3a7Om9Im1rwlHl0sD7VAs0Ulb1463HAEo
 sGvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUue1uw9fjr0Mrl/xJGfDI0CVl0EpEknvWOc/wiBqAYgnkHcEonZLRH/5dvuqTRWbMzZbGB0yFxZi46@nongnu.org
X-Gm-Message-State: AOJu0Yz/VC/seRG2sL9S9EPDKnujvgTnAn02+nizvRUGxCYM3yn1mIFz
 9X4uoQ179kykeTbyeaxP8sDHf+tWpOXNo/77vtV7tm77v4EybYmf+H6bum7p+n+sFgHdtNooJWt
 MV1+xy7EEVtWuafgFxBGDSbHWX2s/DkCHAYnlvpU/O6Xl8PZMJRS/0UOrOQxhVhe5oKEt7kACo5
 XSwVSmc6331XGhE+LC83MN70fUOEA=
X-Gm-Gg: ASbGnct1ndwYkCwDWQEJVWgNilJtNn04dzmva2y8FcvEW5VpPKs/XtBF7pbL3X3S/Mh
 +Qg7K55hc77ftkU4rFBpjWcmDJQ0kGYv/wVQiOfZKpkYRNqjBX2A=
X-Received: by 2002:a05:6402:518a:b0:5d3:ba42:e9e3 with SMTP id
 4fb4d7f45d1cf-5db7d2f5ec0mr53740444a12.13.1737547755249; 
 Wed, 22 Jan 2025 04:09:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFJjQQx8nnQ5qFfspQROOZAA+OhE+EXl8VRfjU6XIhOh+G7BfQnXj3/HGfN8c2JE7Cmqavm88Bclzng+49psA=
X-Received: by 2002:a05:6402:518a:b0:5d3:ba42:e9e3 with SMTP id
 4fb4d7f45d1cf-5db7d2f5ec0mr53740388a12.13.1737547754854; Wed, 22 Jan 2025
 04:09:14 -0800 (PST)
MIME-Version: 1.0
References: <20250116033418.226051-1-anisinha@redhat.com>
 <Z4+Jct1P0Tj4tobY@intel.com>
In-Reply-To: <Z4+Jct1P0Tj4tobY@intel.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Wed, 22 Jan 2025 17:39:03 +0530
X-Gm-Features: AbW1kvZ02nKYSb_Xm4iMatB8jNTYpiFLo5Lucwo-vl2aAYQXvd5-tfA8NYz6Dsg
Message-ID: <CAK3XEhPdxwKa_QOd-tNZgCUNYefh1ua72Jrwt-D86aYNxCikrQ@mail.gmail.com>
Subject: Re: [PATCH v3] hw/i386/cpu: remove default_cpu_version and simplify
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, imammedo@redhat.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Jan 21, 2025 at 4:58=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
>
> Hi Ani,
>
> Sorry for late reply.
>
> On Thu, Jan 16, 2025 at 09:04:18AM +0530, Ani Sinha wrote:
> > Date: Thu, 16 Jan 2025 09:04:18 +0530
> > From: Ani Sinha <anisinha@redhat.com>
> > Subject: [PATCH v3] hw/i386/cpu: remove default_cpu_version and simplif=
y
> > X-Mailer: git-send-email 2.45.2
> >
> > commit 0788a56bd1ae3 ("i386: Make unversioned CPU models be aliases")
> > introduced 'default_cpu_version' for PCMachineClass. This created three
> > categories of CPU models:
> >  - Most unversioned CPU models would use version 1 by default.
> >  - For machines 4.0.1 and older that do not support cpu model aliases, =
a
> >    special default_cpu_version value of CPU_VERSION_LEGACY is used.
> >  - It was thought that future machines would use the latest value of cp=
u
> >    versions corresponding to default_cpu_version value of
> >    CPU_VERSION_LATEST [1].
> >
> > All pc machines still use the default cpu version of 1 for
> > unversioned cpu models. CPU_VERSION_LATEST is a moving target and
> > changes with time. Therefore, if machines use CPU_VERSION_LATEST, it wo=
uld
> > mean that over a period of time, for the same machine type, the cpu ver=
sion
> > would be different depending on what is latest at that time. This would
> > break guests even when they use a constant machine type. Therefore, for
> > pc machines, use of CPU_VERSION_LATEST is not possible. Currently, only
> > microvms use CPU_VERSION_LATEST.
> >
> > This change cleans up the complicated logic around default_cpu_version
> > including getting rid of default_cpu_version property itself. A couple =
of new
> > flags are introduced, one for the legacy model for machines 4.0.1 and o=
lder
> > and other for microvms. For older machines, a new pc machine property i=
s
> > introduced that separates pc machine versions 4.0.1 and older from the =
newer
> > machines. 4.0.1 and older machines are scheduled to be deleted towards
> > end of 2025 since they would be 6 years old by then. At that time, we c=
an
> > remove all logic around legacy cpus. Microvms are the only machines tha=
t
> > continue to use the latest cpu version. If this changes later, we can
> > remove all logic around x86_cpu_model_last_version(). Default cpu versi=
on
> > for unversioned cpu models is hardcoded to the value 1 and applies
> > unconditionally for all pc machine types of version 4.1 and above.
> >
> > This change also removes all complications around CPU_VERSION_AUTO
> > including removal of the value itself.
>
> I like the idea to remove CPU_VERSION_AUTO. Though this patch introduces
> 2 more new static variables ("use_legacy_cpu" and "use_last_cpu_version")=
,
> as you said, once 4.0.1 and older machines are removed, it's easy to
> clean up "use_legacy_cpu".
>
> > 1) See commit dcafd1ef0af227 ("i386: Register versioned CPU models")
> >
> > CC: imammedo@redhat.com
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > ---
>
> [snip]
>
> > -void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
> > +void x86_legacy_cpus_init(X86MachineState *x86ms)
> > +{
> > +    machine_uses_legacy_cpu();
> > +    x86_cpus_init(x86ms);
> > +}
> > +
> > +void x86_cpus_init_with_latest_cpu_version(X86MachineState *x86ms)
> > +{
> > +    x86_cpu_uses_lastest_version();
> > +    x86_cpus_init(x86ms);
> > +}
>
> Could we simplify it even further, i.e., omit these two new helpers and
> just add x86_cpu_uses_lastest_version() and machine_uses_legacy_cpu() to
> the initialization of the PC & microvm, e.g.,
>
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -458,7 +458,8 @@ static void microvm_machine_state_init(MachineState *=
machine)
>
>      microvm_memory_init(mms);
>
> -    x86_cpus_init_with_latest_cpu_version(x86ms);
> +    x86_cpu_uses_lastest_version();
> +    x86_cpus_init(x86ms);
>
>      microvm_devices_init(mms);
>  }
>
> and
>
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -138,11 +138,10 @@ static inline void pc_init_cpus(MachineState *ms)
>
>      if (pcmc->no_versioned_cpu_model) {
>          /* use legacy cpu as it does not support versions */
> -        x86_legacy_cpus_init(x86ms);
> -    } else {
> -        /* use non-legacy cpus */
> -        x86_cpus_init(x86ms);
> +        machine_uses_legacy_cpu();
>      }
> +
> +    x86_cpus_init(x86ms);
>  }

yeah this simplifies things a bit.

>
>  /* ioapic.c */
>
> [snip]
>
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index a558705cb9..ad43a233d8 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -92,9 +92,6 @@ struct PCMachineClass {
> >
> >      /* Compat options: */
> >
> > -    /* Default CPU model version.  See x86_cpu_set_default_version(). =
*/
> > -    int default_cpu_version;
> > -
> >      /* ACPI compat: */
> >      bool has_acpi_build;
> >      int pci_root_uid;
> > @@ -125,11 +122,29 @@ struct PCMachineClass {
> >       * check for memory.
> >       */
> >      bool broken_32bit_mem_addr_check;
> > +
> > +    /* whether the machine supports versioned cpu models */
> > +    bool no_versioned_cpu_model;
> >  };
> >
> >  #define TYPE_PC_MACHINE "generic-pc-machine"
> >  OBJECT_DECLARE_TYPE(PCMachineState, PCMachineClass, PC_MACHINE)
> >
> > +static inline void pc_init_cpus(MachineState *ms)
>
> I think there's no need to declare as `inline`.

yes, otherwise we see failure like:

In file included from /workspace/qemu-ani/include/hw/xen/xen-x86.h:11,
                 from ../stubs/xen-hw-stub.c:11:
/workspace/qemu-ani/include/hw/i386/pc.h:133:13: error: =E2=80=98pc_init_cp=
us=E2=80=99
defined but not used [-Werror=3Dunused-function]
  133 | static void pc_init_cpus(MachineState *ms)
      |             ^~~~~~~~~~~~

>
> > +{
> > +    X86MachineState *x86ms =3D X86_MACHINE(ms);
> > +    PCMachineState *pcms =3D PC_MACHINE(ms);
> > +    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
> > +
> > +    if (pcmc->no_versioned_cpu_model) {
> > +        /* use legacy cpu as it does not support versions */
> > +        x86_legacy_cpus_init(x86ms);
> > +    } else {
> > +        /* use non-legacy cpus */
> > +        x86_cpus_init(x86ms);
> > +    }
> > +}
> > +
> >  /* ioapic.c */
>
> As my comment above, we can just call machine_uses_legacy_cpu()
> if pcmc->no_versioned_cpu_model is true.
>
> [snip]
>
> > -/*
> > - * We resolve CPU model aliases using -v1 when using "-machine
> > - * none", but this is just for compatibility while libvirt isn't
> > - * adapted to resolve CPU model versions before creating VMs.
> > - * See "Runnability guarantee of CPU models" at
> > - * docs/about/deprecated.rst.
> > - */
> > -X86CPUVersion default_cpu_version =3D 1;
> > +static bool use_legacy_cpu;
> > +void machine_uses_legacy_cpu(void)
>
> What about this name, "x86_cpu_set_legacy_version"?
>
> > +{
> > +    use_legacy_cpu =3D true;
> > +}
> >
> > -void x86_cpu_set_default_version(X86CPUVersion version)
> > +static bool use_last_cpu_version;
>
> Maybe "use_lastest_cpu"? Keep it in the same style as "use_legacy_cpu".
>
> > +void x86_cpu_uses_lastest_version(void)
>
> Similarly, What about "x86_cpu_set_latest_version"?
>
> >  {
> > -    /* Translating CPU_VERSION_AUTO to CPU_VERSION_AUTO doesn't make s=
ense */
> > -    assert(version !=3D CPU_VERSION_AUTO);
> > -    default_cpu_version =3D version;
> > +    use_last_cpu_version =3D true;
> >  }
> >
> >  static X86CPUVersion x86_cpu_model_last_version(const X86CPUModel *mod=
el)
> > @@ -5376,14 +5375,11 @@ static X86CPUVersion x86_cpu_model_last_version=
(const X86CPUModel *model)
> >  /* Return the actual version being used for a specific CPU model */
> >  static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *=
model)
> >  {
> > -    X86CPUVersion v =3D model->version;
> > -    if (v =3D=3D CPU_VERSION_AUTO) {
> > -        v =3D default_cpu_version;
> > -    }
> > -    if (v =3D=3D CPU_VERSION_LATEST) {
> > +    if (use_last_cpu_version) {
> >          return x86_cpu_model_last_version(model);
> >      }
> > -    return v;
> > +
> > +    return model->version;
> >  }
> >
> >  static const Property max_x86_cpu_properties[] =3D {
> > @@ -5987,6 +5983,12 @@ static char *x86_cpu_class_get_alias_of(X86CPUCl=
ass *cc)
> >      if (!cc->model || !cc->model->is_alias) {
> >          return NULL;
> >      }
> > +
> > +    if (use_legacy_cpu) {
> > +        /* legacy cpu models do not support cpu aliases */
> > +        return NULL;
> > +    }
> > +
> >      version =3D x86_cpu_model_resolve_version(cc->model);
> >      if (version <=3D 0) {
>
> I understand this non-NULL check is origianl for legacy CPU version.

yes good catch,

> So it's also necessary to remove it, or convert it to "assert(version)"?

good idea.

>
> >          return NULL;
> > @@ -6004,11 +6006,7 @@ static void x86_cpu_list_entry(gpointer data, gp=
ointer user_data)
> >      g_autofree char *model_id =3D x86_cpu_class_get_model_id(cc);
> >
> >      if (!desc && alias_of) {
> > -        if (cc->model && cc->model->version =3D=3D CPU_VERSION_AUTO) {
> > -            desc =3D g_strdup("(alias configured by machine type)");
> > -        } else {
> >              desc =3D g_strdup_printf("(alias of %s)", alias_of);
> > -        }
> >      }
> >      if (!desc && cc->model && cc->model->note) {
> >          desc =3D g_strdup_printf("%s [%s]", model_id, cc->model->note)=
;
> > @@ -6115,7 +6113,7 @@ static void x86_cpu_definition_entry(gpointer dat=
a, gpointer user_data)
> >       * Old machine types won't report aliases, so that alias translati=
on
> >       * doesn't break compatibility with previous QEMU versions.
> >       */
> > -    if (default_cpu_version !=3D CPU_VERSION_LEGACY) {
> > +    if (!use_legacy_cpu) {
> >          info->alias_of =3D x86_cpu_class_get_alias_of(cc);
> >      }
>
> Do we need the check of "!use_legacy_cpu"?
>
> x86_cpu_class_get_alias_of() returns NULL if use_legacy_cpu is true.

another good catch.

I have sent v4.


