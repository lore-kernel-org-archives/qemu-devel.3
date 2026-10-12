Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F336CA9ED5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 05:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG8cE-0003mN-9M; Mon, 12 Oct 2026 01:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xG8c7-0003lx-2D
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 01:30:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xG8c2-0000Kk-5b
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 01:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791783012;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7RxD8Kncz8+fbuZzax4X5TUQtEW/CrJD3usSfsekNKE=;
 b=NdOVQReOhwpmiMbCZ7FEeg+du9SnG6mV8PO11RsAYAk64YU0J8v8GjwzA9D/OpDftE7zQr
 s2ReCB5tVdeUbNv6+bALK59tMe5D3bjWniMDNF38bG7u0fz9o1zJfGJ0/sbv3AJCNWZCI1
 Gri0I7DRSw1WJYxkLcMTdbtDpc43LWo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-_6xmc2dhM7GRYsxPLBJ9TA-1; Mon, 12 Oct 2026 05:30:10 +0000
X-MC-Unique: _6xmc2dhM7GRYsxPLBJ9TA-1
X-Mimecast-MFC-AGG-ID: _6xmc2dhM7GRYsxPLBJ9TA_1791783009
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a013ea30c0so9435555e9.0
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 22:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791783009; x=1792387809;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7RxD8Kncz8+fbuZzax4X5TUQtEW/CrJD3usSfsekNKE=;
 b=GpGcD2CHuUkHiFex5178iGahNv65KE8yTyJsyAK9Fu3MUIdh5aIszjbksPF6HNJUY3
 MdWyrI/7sZizG5QzXDwSguDwgGBwjmBAgt13BQ9u61RtOdvf9JYGdYvhppJr7ZtMmvf0
 cbZhklZwUtvAgyt1i0GTS6sUpVQ9l24KFkRNE/qG97utwQnZLHpNM9iSTbpujFH/I9fh
 ZBUQfTg03z5ChH73g4v5BJp+AFK3ZsuwmpJHmMWUnV5qxbSSYlJd01FADr8D52EsWh+U
 b8mJjJhvxwurhA2GfhPR67CcFFxIQ65m+U1dH9VoAJbv71GoWIiZxa5Qt4h2pDT4a25N
 LK0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxS4mNifvBWiNmqB2+2f5yHqBBz74ji6Q0yqfgurMebWX6g1AfE1CSx4eQfNfRHGn7j8M+36MGexC3z@nongnu.org
X-Gm-Message-State: AFq9FYJeI0Ye8VNdzoy8TNyZssPzVXEb2NQerK2ci9Sf+at3xGsFIeT0
 PIpvwgMdiVytLV/pwVqGRtJp5tPGA4NY3Lgj56fuUTtaZA8YJ/bAea+JUUIOtw4X87kLxwaqunB
 rHIt400kn81Esxr3A/Avemm6NoMlLVBnyj2ZVlXMspMdqMGTWVeK1dUiZ
X-Gm-Gg: AYBFou30i9IJ+2XBmt2cdyGxdm+3F+FAQTt0F12YO2Swib1XNy8N+FOTLfnE8yu0yb2
 OnOoUSNamPgXgQteiF5oHud4x2nbce2m8Neqg7v+cEx8ojD9Su5RogEygdddYrrN/HXYWv7elM+
 uS15kE5SHj8ty43wgLyxSsfkCs2bq3gdHfMqYeY4Sipz8d4Rjd9YMkYWvqbDNllqMKZQzXj0qCk
 4n+RXXQMtYlK+XnN+tSLxBBSxIPCoM3Bzy5LbYMYCfF9574RczyIKmE56bkPqM3PKUe+JeGlNu9
 cZywonNs3ovi886UqEgqsaR46XEC41o9+QUNauQ+YNmfPslupaptKImxbj6PxNzsn7PrdE7Yk6S
 aocr1HhMmuIapOM5nJp4cMblLdD2bdpikvy5tV0IsjSr0yzh4
X-Received: by 2002:a05:600c:548e:b0:4a0:1aa0:7cfa with SMTP id
 5b1f17b1804b1-4a18e4aa724mr159649155e9.12.1791783009034; 
 Sun, 11 Oct 2026 22:30:09 -0700 (PDT)
X-Received: by 2002:a05:600c:548e:b0:4a0:1aa0:7cfa with SMTP id
 5b1f17b1804b1-4a18e4aa724mr159648625e9.12.1791783008580; 
 Sun, 11 Oct 2026 22:30:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9abda3csm18465898f8f.36.2026.10.11.22.30.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Oct 2026 22:30:08 -0700 (PDT)
Message-ID: <01fa7204-d309-4044-9fca-610c77ff9f7a@redhat.com>
Date: Mon, 12 Oct 2026 07:30:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/26] kvm/arm: Introduce a customizable aarch64 KVM
 host model
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
References: <20261010133725.642498-1-eric.auger@redhat.com>
 <2F29CAAF-744A-433B-AD42-DF1881E07548@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <2F29CAAF-744A-433B-AD42-DF1881E07548@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Khushit,

On 10/12/26 6:38 AM, Khushit Shah wrote:
>
>> On 10 Oct 2026, at 7:06=E2=80=AFPM, Eric Auger <eric.auger@redhat.com>=
 wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> This series enhances the current host KVM model with capability to
>> set writable ID reg fields.
>>
>> Since v6.7 kernel, KVM/arm allows the userspace to overwrite the value=
s
>> of a subset of ID regs. The list of writable fields continues to grow.=

>> The feature ID range is defined as the AArch64 System register space
>> with op0=3D=3D3, op1=3D=3D{0, 1, 3}, CRn=3D=3D0, CRm=3D=3D{0-7}, op2=3D=
=3D{0-7}.
>>
>> The end goal is to get more flexibility when migrating guests
>> between different host hardware. This series is a prerequisite for
>> aarch64 named vcpu models.
>>
>> QEMU retrieves the writable ID fields from KVM UAPI and
>> match them against a generated description of ID regs and their
>> named fields that stem from AARCHMRS Registers.json file.
>> Current description is based on latest 2026-03 edition.
>> The content of the generated files was compared against kernel
>> linux/arch/arm64/tools/sysreg file. It is not straightforward
>> to have unit tests for python scripts as there are many cases for
>> field extraction.
>>
>> For each writable named field a uint64 property is created
>> following the "SYSREG_<REG>_<FIELD>" naming convention. REG and
>> FIELD names are those described in ARM ARM Reference manual.
>>
>> SYSREG properties are applied at the end of the initialization
>> chain, after legacy composite options (sve, pauth, ...). They
>> do not substitute to them because legacy options do more than
>> just changing the value of ID registers. They may also interact
>> with KVM to init the vcpu with specific features or set some
>> VM capabilities. SYSREG properties just affect the corresponding
>> ID register field. Some checks are performed to make sure their
>> value is not inconsistent with legacy composite options.
>>
>> The list of SYSREG properties can be retrieved through the qmp
>> monitor using query-cpu-model-expansion. They return the current
>> value for the corresponding field. The qmp command also allows to
>> test  setting new values. In static mode, they are tested at qemu
>> level only, against field length, arch enum values if any and
>> consistency with legacy composite options. With full expansion,
>> the values are tested against KVM using a scratch vcpu initialized
>> with the right legacy composite property values.
>>
>> Connie & Eric
>>
> Hi Eric,=20
>
> Thanks for the quick respin!
>
> I tried to build the series but it fails with:
> FAILED: libqemu-aarch64_be-linux-user.a.p/linux-user_syscall.c.o=20
> cc -Ilibqemu-aarch64_be-linux-user.a.p -I. -I.. -Itarget/arm -I../targe=
t/arm -I../common-user/host/aarch64 -I../linux-user/include/host/aarch64 =
-I../linux-user/include -Ilinux-user -I../linux-user -Ilinux-user/aarch64=
 -I../linux-user/aarch64 -Iqapi -Itrace -Iui -Iui/shader -I/usr/include/g=
lib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/sysprof-6 -fdiagnost=
ics-color=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O2 -g -D_GNU_S=
OURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -=
fno-common -fwrapv -ftrivial-auto-var-init=3Dzero -fzero-call-used-regs=3D=
used-gpr -fstack-protector-strong -Wempty-body -Wendif-labels -Wexpansion=
-to-defined -Wformat-overflow=3D2 -Wformat-security -Wformat-y2k -Wignore=
d-qualifiers -Wimplicit-fallthrough=3D2 -Winit-self -Wmissing-format-attr=
ibute -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wold=
-style-definition -Wredundant-decls -Wshadow=3Dlocal -Wstrict-prototypes =
-Wtype-limits -Wundef -Wvla -Wwrite-strings -Wno-missing-include-dirs -Wn=
o-psabi -Wno-shift-negative-value -isystem /home/ahv/qemu-upstream/linux-=
headers -isystem linux-headers -iquote . -iquote /home/ahv/qemu-upstream =
-iquote /home/ahv/qemu-upstream/include -iquote /home/ahv/qemu-upstream/h=
ost/include/aarch64 -iquote /home/ahv/qemu-upstream/host/include/generic =
-iquote /home/ahv/qemu-upstream/tcg/aarch64 -pthread -fPIE -DWITH_GZFILEO=
P -isystem../linux-headers -isystemlinux-headers -DCOMPILING_PER_TARGET '=
-DCONFIG_TARGET=3D"aarch64_be-linux-user-config-target.h"' -MD -MQ libqem=
u-aarch64_be-linux-user.a.p/linux-user_syscall.c.o -MF libqemu-aarch64_be=
-linux-user.a.p/linux-user_syscall.c.o.d -o libqemu-aarch64_be-linux-user=
=2Ea.p/linux-user_syscall.c.o -c ../linux-user/syscall.c
> In file included from /home/ahv/qemu-upstream/include/fpu/softfloat-typ=
es.h:83,
>                  from /home/ahv/qemu-upstream/include/qemu/cpu-float.h:=
4,
>                  from ../target/arm/cpu.h:24,
>                  from ../linux-user/qemu.h:4,
>                  from ../linux-user/syscall.c:133:
> ../linux-user/aarch64/../arm/target_proc.h: In function =E2=80=98open_c=
puinfo=E2=80=99:
> ../linux-user/aarch64/../arm/target_proc.h:28:30: error: =E2=80=98ARMCP=
U=E2=80=99 {aka =E2=80=98struct ArchCPU=E2=80=99} has no member named =E2=
=80=98midr=E2=80=99
>    28 |     midr_rev =3D FIELD_EX32(cpu->midr, MIDR_EL1, REVISION);
>       |                              ^~
> /home/ahv/qemu-upstream/include/hw/core/registerfields.h:56:16: note: i=
n definition of macro =E2=80=98FIELD_EX32=E2=80=99
>    56 |     extract32((storage), R_ ## reg ## _ ## field ## _SHIFT,    =
           \
>       |                ^~~~~~~
> ../linux-user/aarch64/../arm/target_proc.h:29:31: error: =E2=80=98ARMCP=
U=E2=80=99 {aka =E2=80=98struct ArchCPU=E2=80=99} has no member named =E2=
=80=98midr=E2=80=99
>    29 |     midr_part =3D FIELD_EX32(cpu->midr, MIDR_EL1, PARTNUM);
>       |                               ^~
> /home/ahv/qemu-upstream/include/hw/core/registerfields.h:56:16: note: i=
n definition of macro =E2=80=98FIELD_EX32=E2=80=99
>    56 |     extract32((storage), R_ ## reg ## _ ## field ## _SHIFT,    =
           \
>       |                ^~~~~~~
> ../linux-user/aarch64/../arm/target_proc.h:30:30: error: =E2=80=98ARMCP=
U=E2=80=99 {aka =E2=80=98struct ArchCPU=E2=80=99} has no member named =E2=
=80=98midr=E2=80=99
>    30 |     midr_var =3D FIELD_EX32(cpu->midr, MIDR_EL1, VARIANT);
>       |                              ^~
> /home/ahv/qemu-upstream/include/hw/core/registerfields.h:56:16: note: i=
n definition of macro =E2=80=98FIELD_EX32=E2=80=99
>    56 |     extract32((storage), R_ ## reg ## _ ## field ## _SHIFT,    =
           \
>       |                ^~~~~~~
> ../linux-user/aarch64/../arm/target_proc.h:31:31: error: =E2=80=98ARMCP=
U=E2=80=99 {aka =E2=80=98struct ArchCPU=E2=80=99} has no member named =E2=
=80=98midr=E2=80=99
>    31 |     midr_impl =3D FIELD_EX32(cpu->midr, MIDR_EL1, IMPLEMENTER);=

>       |                               ^~
> /home/ahv/qemu-upstream/include/hw/core/registerfields.h:56:16: note: i=
n definition of macro =E2=80=98FIELD_EX32=E2=80=99
>    56 |     extract32((storage), R_ ## reg ## _ ## field ## _SHIFT,    =
           \
>       |                ^~~~~~~
>
> (Seems like you missed the midr change ../linux-user/aarch64/../arm/tar=
get_proc.h)
>
> I will use a local change to bypass this for now.

thanks for the report. I missed that occurence. Will fix that asap

Eric
>
> Thanks,
> Khushit
>
>> This series can be found at:
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_eaug=
er_qemu_tree_arm-2Dcpu-2Dmodel-2Dv10&d=3DDwIDAg&c=3Ds883GpUCOChKOHiocYtGc=
g&r=3DPGWMyignA0NiDmTlyP7vOTHozBws_VN86yrVmSMkBp0&m=3DEQ1t39vqC5VSSSw_jZu=
Unx8XXPMM-ahIV_dh7aGklyYX3735JsqABWwM82QHgpmJ&s=3Dmi86fJIDXGllId7EXkRflzO=
zb4Rajf_9mL4xlxG-6Jc&e=3D=20
>>
>> History:
>> --------
>> v9 -> v10:
>> addressed all Khushit's comments/suggestions. Here is the
>> list of main changes.
>>
>> - MIDR, REVIDIR, MPIDR storage move (this may be sent as a
>>  separate prerequisite series)
>> - rebase on demux register handler that has just landed
>>  - update the json extractor accordingly
>> - Generate conditional enum values
>> - reorganize script patches to have the generated header
>>  in the same patch which is much easier to maintain
>> - New macro to encode arch enum value and ValueRanges which
>>  gives a much more compact header. Also enabled to remove
>>  check-patch error
>> - Put a maximum of code in cpu64.c instead of kvm.c to
>>  pave the way for other acceleration support. Also
>>  changed the consistency check handling by skipping potential
>>  new props that are known to collide with legacy composite options
>> - add writable_only param to pave the way for exposing all fields
>>  as props
>> - fixes in the qmp expansion code
>>
>>
>> Cornelia Huck (3):
>>  target/arm/kvm: Retrieve writable ID reg map
>>  arm-qmp-cmds: introspection for ID register props
>>  arm/cpu-features: Document ID reg properties
>>
>> Eric Auger (22):
>>  target/arm: Move REVIDR into isar.idregs[] storage
>>  target/arm: Move MIDR into isar.idregs[] storage
>>  target/arm: Enforce MPIDR into isar.idregs[] storage
>>  target/arm/cpu-sysregs.h.inc: Update with automatic generation
>>  arm/cpu: Add infra to handle generated ID register definitions
>>  target/arm/cpu-idregs.h.inc: Generate with script
>>  target/arm/cpu-idregs.h.inc: Generate enum values
>>  target/arm/cpu-idregs.h.inc: Generate reserved fields
>>  hw/arm/virt: Make sure virt_get_caches() keeps on reading CLIDR_EL1 a=
s
>>    0
>>  arm/kvm: Initialize isar.idregs[] with all writable host ID regs
>>  target/arm/cpu64: Add properties for writable IDReg fields
>>  target/arm/kvm: Implement SYSREG property setter and getter
>>  target/arm/kvm: Let kvm_arm_init_cpreg_list propagate an error handle=

>>  target/arm/kvm: Pass an Error handle to kvm_arch_init_vcpu
>>  target/arm/kvm: Introduce kvm_arm_override_idreg_field helper
>>  target/arm/cpu64: Introduce arm_cpu_apply_sysreg_props
>>  target/arm/kvm: Apply SYSREG props
>>  target/arm/kvm: Add consistency checking for SYSREG props
>>  target/arm/cpu64: Add helper to test SYSREG props against a scratch
>>    vcpu
>>  target/arm/kvm: Add an error handle to
>>    kvm_arm_create_scratch_host_vcpu
>>  target/arm/kvm: Introduce kvm_arm_vcpu_prepare_init_features helper
>>  target/arm/kvm: Introduce kvm_arm_create_init_scratch_vcpu()
>>
>> Shaju Abraham (1):
>>  target/arm/cpu_idregs: Generate tables for Arm64 ID registers and
>>    fields
>>
>> docs/system/arm/cpu-features.rst              |  111 +-
>> include/system/kvm.h                          |    2 +-
>> target/arm/cpu-idregs.h                       |   76 +
>> target/arm/cpu.h                              |   12 +-
>> target/arm/kvm_arm.h                          |   26 +-
>> target/arm/cpu-idregs.h.inc                   | 1549 +++++++++++++++++=

>> target/arm/cpu-sysregs.h.inc                  |   13 +
>> accel/kvm/kvm-all.c                           |   15 +-
>> hw/arm/virt.c                                 |   11 +
>> hw/intc/armv7m_nvic.c                         |    4 +-
>> target/arm/arm-qmp-cmds.c                     |  130 +-
>> target/arm/cpu-idregs.c                       |   93 +
>> target/arm/cpu-max.c                          |    4 +-
>> target/arm/cpu.c                              |   24 +-
>> target/arm/cpu64.c                            |  330 +++-
>> target/arm/helper.c                           |   29 +-
>> target/arm/hvf/hvf.c                          |    6 +-
>> target/arm/kvm-stub.c                         |   17 +
>> target/arm/kvm.c                              |  277 ++-
>> target/arm/tcg/cpu-v7m.c                      |   18 +-
>> target/arm/tcg/cpu32.c                        |   37 +-
>> target/arm/tcg/cpu64.c                        |   42 +-
>> target/arm/whpx/whpx-all.c                    |    6 +-
>> target/i386/kvm/kvm.c                         |   22 +-
>> target/loongarch/kvm/kvm.c                    |   27 +-
>> target/ppc/kvm.c                              |    6 +-
>> target/riscv/kvm/kvm-cpu.c                    |    3 +-
>> target/s390x/kvm/kvm.c                        |    2 +-
>> scripts/aarch64_sysreg_helpers.py             |  118 ++
>> .../update-aarch64-cpu-sysreg-properties.py   |  331 ++++
>> scripts/update-aarch64-cpu-sysregs-header.py  |   59 +
>> target/arm/meson.build                        |    1 +
>> target/arm/trace-events                       |    9 +
>> 33 files changed, 3232 insertions(+), 178 deletions(-)
>> create mode 100644 target/arm/cpu-idregs.h
>> create mode 100644 target/arm/cpu-idregs.h.inc
>> create mode 100644 target/arm/cpu-idregs.c
>> create mode 100644 scripts/aarch64_sysreg_helpers.py
>> create mode 100644 scripts/update-aarch64-cpu-sysreg-properties.py
>> create mode 100755 scripts/update-aarch64-cpu-sysregs-header.py
>>
>> --=20
>> 2.53.0
>>


