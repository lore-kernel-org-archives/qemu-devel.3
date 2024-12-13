Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFA1E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 03:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLwYo-0008Cl-JZ; Thu, 12 Dec 2024 22:41:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tLwYn-0008CP-Kl
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 22:41:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tLwYi-0000hq-NY
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 22:41:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734061300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gWxoOK16ufMqaxrl47YwVjkidkwl6/B+Ps0Qdp3TFlw=;
 b=hhYMaVsY0/FNYfPDROepQF+AjuWdouHP0k3Afz42Pnwf/UXwDJDENSzqtQIPOztqaQa+Db
 lKzVeow3vb4BS02ENMLXTdlUVuj/fVam/htQtQ3N6Dk+vmaYVXpQ3h9a3xcgPdJO0PSX3X
 GIt/Ppxa+seS4PoUQYf+Trwkek7i/Ww=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-Ph6lAmX2Msq5rGki_bz1yg-1; Thu, 12 Dec 2024 22:41:37 -0500
X-MC-Unique: Ph6lAmX2Msq5rGki_bz1yg-1
X-Mimecast-MFC-AGG-ID: Ph6lAmX2Msq5rGki_bz1yg
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ef79d9c692so1778079a91.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 19:41:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734061297; x=1734666097;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gWxoOK16ufMqaxrl47YwVjkidkwl6/B+Ps0Qdp3TFlw=;
 b=vjjY29zVcjtsv5oFOgYqKh39CrDGZ21cOwoeoIfjVRW5E2yvzF8/0BGheq9Dhnrz85
 vNLlzZUUigKR3bdBMRvee2gEAmOdFTAIHRJS9n8uamsnrpXVanYO2TpFyVCc4RNskh3t
 CoWgeP9NMuJB2OStnZbrEYD5GMuw8xQIksCeuyBYdRJk8SKLaZJxlXVtyw6t7kqgvOlb
 4igQ/+hV/t2/cXtz1sqhes0LRhru2apf6D7CZIHbRtuTBBVO5kR0qS8yjIOZOYVBjZjd
 8fF/YEvtjp2mdffinGYtLO7W6Y7QdKUpcSk0ULQNTjTIhS4b7t/hauvXwLe6oFlvIsU2
 d0ow==
X-Gm-Message-State: AOJu0Yzx/fk2q7JjT+hQ1NcXxHA6SJvsaKCRJE5yX8ieWVxDTn/eV2kl
 zIlYMH2IgizZYmeN8qZZRnj7EQxaojsnkAKVlpdYZE8kF6hUfF6px6LghM70NE8gztcqytMZzzq
 TKmMc0Frz2gSm+F1HZSYtD23j3rYyN5q1CSCunnRIaqsp22C2gZR+ioROs6B64hr5flFYeqGLcC
 H9dek1cjS7+LdBSna4GsheJBJTqRM=
X-Gm-Gg: ASbGnctcsjWtRaMhaaR3R5EPv4CjS9/QPRf20JPKYeOEt9XgA0oyROP5H+Z22Y28hb0
 o/d7zST1LSW1VIjwybB/iMvuVBIPPG682Cjv6+o8=
X-Received: by 2002:a17:90b:4a4f:b0:2ee:9902:18b4 with SMTP id
 98e67ed59e1d1-2f2900a9878mr1892496a91.27.1734061296914; 
 Thu, 12 Dec 2024 19:41:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGelOfpqxUg3ir1KddWS2YfwdujWVJBhb5o6ESA7Q2WYwzbMFtrNLugxRnxDaqdsXkIQvfJoPfUAqKogBHQ+n0=
X-Received: by 2002:a17:90b:4a4f:b0:2ee:9902:18b4 with SMTP id
 98e67ed59e1d1-2f2900a9878mr1892462a91.27.1734061296528; Thu, 12 Dec 2024
 19:41:36 -0800 (PST)
MIME-Version: 1.0
References: <20241212083757.605022-1-zhenzhong.duan@intel.com>
 <20241212083757.605022-18-zhenzhong.duan@intel.com>
In-Reply-To: <20241212083757.605022-18-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Dec 2024 11:41:25 +0800
Message-ID: <CACGkMEusBnsaaGCVY-Wo-X4PvfpfcT4GPZVZoLWsB_+N+bbEHQ@mail.gmail.com>
Subject: Re: [PATCH v6 17/20] tests/acpi: q35: Update host address width in
 DMAR
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com, 
 eric.auger@redhat.com, mst@redhat.com, peterx@redhat.com, jgg@nvidia.com, 
 nicolinc@nvidia.com, joao.m.martins@oracle.com, 
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com, 
 chao.p.peng@intel.com, Igor Mammedov <imammedo@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Dec 12, 2024 at 4:42=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com> wrote:
>
> Differences:
>
> @@ -1,39 +1,39 @@
>  /*
>   * Intel ACPI Component Architecture
>   * AML/ASL+ Disassembler version 20200925 (64-bit version)
>   * Copyright (c) 2000 - 2020 Intel Corporation
>   *
> - * Disassembly of tests/data/acpi/x86/q35/DMAR.dmar, Mon Nov 11 15:31:18=
 2024
> + * Disassembly of /tmp/aml-SPJ4W2, Mon Nov 11 15:31:18 2024
>   *
>   * ACPI Data Table [DMAR]
>   *
>   * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
>   */
>
>  [000h 0000   4]                    Signature : "DMAR"    [DMA Remapping =
table]
>  [004h 0004   4]                 Table Length : 00000078
>  [008h 0008   1]                     Revision : 01
> -[009h 0009   1]                     Checksum : 15
> +[009h 0009   1]                     Checksum : 0C
>  [00Ah 0010   6]                       Oem ID : "BOCHS "
>  [010h 0016   8]                 Oem Table ID : "BXPC    "
>  [018h 0024   4]                 Oem Revision : 00000001
>  [01Ch 0028   4]              Asl Compiler ID : "BXPC"
>  [020h 0032   4]        Asl Compiler Revision : 00000001
>
> -[024h 0036   1]           Host Address Width : 26
> +[024h 0036   1]           Host Address Width : 2F
>  [025h 0037   1]                        Flags : 01
>  [026h 0038  10]                     Reserved : 00 00 00 00 00 00 00 00 0=
0 00
>
>  [030h 0048   2]                Subtable Type : 0000 [Hardware Unit Defin=
ition]
>  [032h 0050   2]                       Length : 0040
>
>  [034h 0052   1]                        Flags : 00
>  [035h 0053   1]                     Reserved : 00
>  [036h 0054   2]           PCI Segment Number : 0000
>  [038h 0056   8]        Register Base Address : 00000000FED90000
>
>  [040h 0064   1]            Device Scope Type : 03 [IOAPIC Device]
>  [041h 0065   1]                 Entry Length : 08
>  [042h 0066   2]                     Reserved : 0000
>  [044h 0068   1]               Enumeration ID : 00
>  [045h 0069   1]               PCI Bus Number : FF
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Acked-by: Cl=C3=A9ment Mathieu--Drif<clement.mathieu--drif@eviden.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


