Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE81C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 04:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXumG-0000zd-S9; Tue, 14 Jan 2025 23:13:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tXumB-0000zC-RD
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 23:13:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tXum9-0007XS-Tl
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 23:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736914383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Jh4nNGqE2jO0tG/eZ7uF+qlMu8yWGMYVwlm1sZ5j8c=;
 b=bM5wmSlAms2v2Xbl+SlwBLZcGT5P+Wo6EGG6HbktcY9oKMoveCRaqh5c8AsEwvE5/8gDkz
 H5HJkLO1SThN/h0yP+OHj4MsyzUH9TSP9gNXjH8Wm5vKxRL3YRVdTRk0SA1AnNfemNMyAD
 +oCeysExjFHujMEnUrv84jRFYW+y3Dg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-QeHsEoCLPVu2X5UwPG-2Dw-1; Tue, 14 Jan 2025 23:13:00 -0500
X-MC-Unique: QeHsEoCLPVu2X5UwPG-2Dw-1
X-Mimecast-MFC-AGG-ID: QeHsEoCLPVu2X5UwPG-2Dw
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa6a831f93cso308720866b.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 20:13:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736914380; x=1737519180;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Jh4nNGqE2jO0tG/eZ7uF+qlMu8yWGMYVwlm1sZ5j8c=;
 b=SCHkO6lp2zTHndywZNpcXwjZ8r9NVCs2QaBNAnw6YeLjnKpbvIkfwnltqXfIuhDxmL
 18KVl8GRjnZit29xecW4jKXkc0ANmcAH/O4VsQmwIeCR54Rv6wp7C7xeBIRerfsipW/x
 TkbJwGl5taLMtwk7t18locnlvYPog9LVl/afwGS5plvBlxC7wb7fkCop1B/mvIf2QCZe
 eyvqRUnjSrjmP+f/RtFckHWgEGTserfzI4sg88SQyqFO8SUJJmR7HTnSXTKE63xxLzNp
 GHGHMUpwFWlZRn5RfIuVoc3kAx9n6xzxymubSTyy0dE0QQ4uj7Vdx/Drfe4806l7B44F
 lGgg==
X-Gm-Message-State: AOJu0Yx40Mj4PnQJFuMPE8YPYWtU9wP0T1BWWgRdwQkq0S/GrCuISUp5
 u7AhNDuvTNYWCvktQ4vo+rKbo84B2txHMXcmkm2SCLOZTcgTEgOryjCNokTHyUsHDGYwua6smZ9
 c9nw9cY+UZOSgtCSzyBCQdhgWFHZlZO0KNgI5YFQsd3GnziUm3HOaKBghnohRoEGRZ9ITej5YSq
 oVCVS3a/uvqvn1/HSKGgwv9c8AfpI=
X-Gm-Gg: ASbGnctL6UVIgWaoBc23fNXtRcBkSujiu6oN+ThG3Kt1Tltm16uDhbB3l71D4jErYs5
 IlJZHHe2LpjuJSdfvTuib3zTYNRJGs720xGh/jGhA
X-Received: by 2002:a17:907:8690:b0:aac:742:28e2 with SMTP id
 a640c23a62f3a-ab2ab6a8df6mr2540682866b.6.1736914379575; 
 Tue, 14 Jan 2025 20:12:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGH/VRH0yeMpmbGiYeC3Gwl03QQ/YgC4Hxdoi7VMdSpkNKcfzzpYq6+uCUQc3tHGoIHD7LTKhB01CaalTevj3A=
X-Received: by 2002:a17:907:8690:b0:aac:742:28e2 with SMTP id
 a640c23a62f3a-ab2ab6a8df6mr2540678566b.6.1736914379124; Tue, 14 Jan 2025
 20:12:59 -0800 (PST)
MIME-Version: 1.0
References: <20250114174601.23-1-alireza.sanaee@huawei.com>
 <20250114174601.23-2-alireza.sanaee@huawei.com>
In-Reply-To: <20250114174601.23-2-alireza.sanaee@huawei.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Wed, 15 Jan 2025 09:42:48 +0530
X-Gm-Features: AbW1kvYy_9ehAskdg2VTDfwbUiK-lKc7kN0ipOAvbddABNi3TweGyFWj9AMw8hI
Message-ID: <CAK3XEhO9GjdMnZTSY7vohbtkf21PRPAE0UhsqbrkDo=Pbp29-w@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] tests: virt: Update expected ACPI tables for virt
 test
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, zhao1.liu@intel.com, 
 zhenyu.z.wang@intel.com, dapeng1.mi@linux.intel.com, armbru@redhat.com, 
 farman@linux.ibm.com, peter.maydell@linaro.org, mst@redhat.com, 
 shannon.zhaosl@gmail.com, imammedo@redhat.com, mtosatti@redhat.com, 
 berrange@redhat.com, richard.henderson@linaro.org, linuxarm@huawei.com, 
 shameerali.kolothum.thodi@huawei.com, Jonathan.Cameron@huawei.com, 
 jiangkunkun@huawei.com, yangyicong@hisilicon.com, sarsanaee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jan 14, 2025 at 11:16=E2=80=AFPM Alireza Sanaee
<alireza.sanaee@huawei.com> wrote:
>
> From: Yicong Yang <yangyicong@hisilicon.com>
>
> Update the ACPI tables according to the acpi aml_build change, also
> empty bios-tables-test-allowed-diff.h.

Where is this part? That is the part where you empty
bios-tables-test-allowed-diff.h.?
You are supposed to send a patch that first adds the tables that you
are changing into bios-tables-test-allowed-diff.h.
Then you are supposed to add the code change patch that makes changes
to the tables.
Then the patch that updates the tables (which also clears
bios-tables-test-allowed-diff.h.).

>
> The disassembled differences between actual and expected PPTT shows
> below. Only about the root node adding and identification flag set
> as expected.
>   /*
>     * Intel ACPI Component Architecture
>     * AML/ASL+ Disassembler version 20210604 (64-bit version)
>     * Copyright (c) 2000 - 2021 Intel Corporation
>     *
>   - * Disassembly of tests/data/acpi/aarch64/virt/PPTT, Thu Sep 26 08:54:=
39 2024
>   + * Disassembly of /tmp/aml-QNEIU2, Thu Sep 26 08:54:39 2024
>     *
>     * ACPI Data Table [PPTT]
>     *
>     * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValu=
e
>     */
>
>    [000h 0000   4]                    Signature : "PPTT"    [Processor Pr=
operties Topology Table]
>   -[004h 0004   4]                 Table Length : 0000004C
>   -[008h 0008   1]                     Revision : 02
>   -[009h 0009   1]                     Checksum : A8
>   +[004h 0004   4]                 Table Length : 00000060
>   +[008h 0008   1]                     Revision : 03
>   +[009h 0009   1]                     Checksum : 26
>    [00Ah 0010   6]                       Oem ID : "BOCHS "
>    [010h 0016   8]                 Oem Table ID : "BXPC    "
>    [018h 0024   4]                 Oem Revision : 00000001
>    [01Ch 0028   4]              Asl Compiler ID : "BXPC"
>    [020h 0032   4]        Asl Compiler Revision : 00000001
>
>    [024h 0036   1]                Subtable Type : 00 [Processor Hierarchy=
 Node]
>    [025h 0037   1]                       Length : 14
>    [026h 0038   2]                     Reserved : 0000
>   -[028h 0040   4]        Flags (decoded below) : 00000001
>   +[028h 0040   4]        Flags (decoded below) : 00000011
>                                Physical package : 1
>                         ACPI Processor ID valid : 0
>                           Processor is a thread : 0
>                                  Node is a leaf : 0
>   -                    Identical Implementation : 0
>   +                    Identical Implementation : 1
>    [02Ch 0044   4]                       Parent : 00000000
>    [030h 0048   4]            ACPI Processor ID : 00000000
>    [034h 0052   4]      Private Resource Number : 00000000
>
>    [038h 0056   1]                Subtable Type : 00 [Processor Hierarchy=
 Node]
>    [039h 0057   1]                       Length : 14
>    [03Ah 0058   2]                     Reserved : 0000
>   -[03Ch 0060   4]        Flags (decoded below) : 0000000A
>   +[03Ch 0060   4]        Flags (decoded below) : 00000011
>   +                            Physical package : 1
>   +                     ACPI Processor ID valid : 0
>   +                       Processor is a thread : 0
>   +                              Node is a leaf : 0
>   +                    Identical Implementation : 1
>   +[040h 0064   4]                       Parent : 00000024
>   +[044h 0068   4]            ACPI Processor ID : 00000000
>   +[048h 0072   4]      Private Resource Number : 00000000
>   +
>   +[04Ch 0076   1]                Subtable Type : 00 [Processor Hierarchy=
 Node]
>   +[04Dh 0077   1]                       Length : 14
>   +[04Eh 0078   2]                     Reserved : 0000
>   +[050h 0080   4]        Flags (decoded below) : 0000000A
>                                Physical package : 0
>                         ACPI Processor ID valid : 1
>                           Processor is a thread : 0
>                                  Node is a leaf : 1
>                        Identical Implementation : 0
>   -[040h 0064   4]                       Parent : 00000024
>   -[044h 0068   4]            ACPI Processor ID : 00000000
>   -[048h 0072   4]      Private Resource Number : 00000000
>   +[054h 0084   4]                       Parent : 00000038
>   +[058h 0088   4]            ACPI Processor ID : 00000000
>   +[05Ch 0092   4]      Private Resource Number : 00000000
>
>   -Raw Table Data: Length 76 (0x4C)
>   +Raw Table Data: Length 96 (0x60)
>
>   -    0000: 50 50 54 54 4C 00 00 00 02 A8 42 4F 43 48 53 20  // PPTTL...=
..BOCHS
>   +    0000: 50 50 54 54 60 00 00 00 03 26 42 4F 43 48 53 20  // PPTT`...=
.&BOCHS
>        0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    =
....BXPC
>   -    0020: 01 00 00 00 00 14 00 00 01 00 00 00 00 00 00 00  // ........=
........
>   -    0030: 00 00 00 00 00 00 00 00 00 14 00 00 0A 00 00 00  // ........=
........
>   -    0040: 24 00 00 00 00 00 00 00 00 00 00 00              // $.......=
....
>   +    0020: 01 00 00 00 00 14 00 00 11 00 00 00 00 00 00 00  // ........=
........
>   +    0030: 00 00 00 00 00 00 00 00 00 14 00 00 11 00 00 00  // ........=
........
>   +    0040: 24 00 00 00 00 00 00 00 00 00 00 00 00 14 00 00  // $.......=
........
>   +    0050: 0A 00 00 00 38 00 00 00 00 00 00 00 00 00 00 00  // ....8...=
........
>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  tests/data/acpi/aarch64/virt/PPTT              | Bin 76 -> 96 bytes
>  tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt | Bin 156 -> 176 bytes
>  tests/data/acpi/aarch64/virt/PPTT.topology     | Bin 336 -> 356 bytes
>  3 files changed, 0 insertions(+), 0 deletions(-)
>
> diff --git a/tests/data/acpi/aarch64/virt/PPTT b/tests/data/acpi/aarch64/=
virt/PPTT
> index 7a1258ecf123555b24462c98ccbb76b4ac1d0c2b..cafd4ee23cb4579234b36bc1b=
06d1380ac8fafea 100644
> GIT binary patch
> literal 96
> zcmWFt2nk7GU|?WYbMklg2v%^42yj*a0!E-1hz+6{L>L$ZK{PUeim9N9aRK=3DjNMZmJ
> Cw+8_L
>
> delta 38
> kcmYfB;R*-{3GrcIU|?D?kxP!15y)bg=3DqSvi0%AY`0D`Lo$p8QV
>
> diff --git a/tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt b/tests/data/=
acpi/aarch64/virt/PPTT.acpihmatvirt
> index 4eef303a5b6168c6bc3795c2e2c53f65b4c4cfd4..8d560405bc7c557867efa32fe=
f5b579f5709d729 100644
> GIT binary patch
> literal 176
> zcmWFt2npH1z`(%F<K*w`5v<@85#X!<1dKp25F11@h%hh+f@ov_6;nYI;{x(6aEO7;
> b0?8riMHU0;EdgRCkQxvGs)LC!Lqr$=3Dth)&T
>
> literal 156
> zcmWFt2nm_Pz`(%t&&l7}BUr&HBEVSz2pEB4AU23*5Mf{d(;zks0L8d~Y!w(EL?em8
> b)g$Re76a)`0AeN}1_P+x1R#eQBEkRwWK9VH
>
> diff --git a/tests/data/acpi/aarch64/virt/PPTT.topology b/tests/data/acpi=
/aarch64/virt/PPTT.topology
> index 3fbcae5ff08aaf16fedf4da45e941661d79c1174..d0e5e11e90f33cbbbc231f9ad=
0bd48419e0fea65 100644
> GIT binary patch
> literal 356
> zcmWFt2nk7HWME*P=3DH&0}5v<@85#X!<1VAAM5F11@h%hh+f@ov_6;nYI69Dopu!#Af
> ziSYsX2{^>Sc7o)9c7V(S=3D|vU;>74__Oh60<Ky@%NW+X9~TafjF#BRXUfM}@RH$Wx}
> cOdLs!6-f-H7uh_Jy&6CPHY9a0F?OgJ00?*x0RR91
>
> literal 336
> zcmWFt2nh*bWME*baq@Te2v%^42yj*a0-z8Bhz+6{L>L&rG>8oYKrs+dflv?<DrSKu
> z#s}p4;1GkGi=3D-D>45YUMh?!vef$Csl%t&G&Cde(wdO>1GKm-gx_1*yTS+Iz)B8h>R
> aAic=3Duf$S9l3b27BK>%tVNQ@mK!T<mOd=3D3Es
>
> --
> 2.34.1
>


