Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CB7C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 01:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHwB6-000869-1u; Thu, 13 Jun 2024 21:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1sHwB4-000837-2h; Thu, 13 Jun 2024 21:56:30 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1sHwB1-0001vy-B4; Thu, 13 Jun 2024 21:56:29 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f6fada63a6so14267675ad.3; 
 Thu, 13 Jun 2024 18:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718330185; x=1718934985; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qVRxt3hhhGFjQUZh8NLxdLXcqbiKvrORDB3kQN8LCUQ=;
 b=GX1baNk+el5ei7otRc3EUAHkpn672X1c0wf0rYTEOYoxKxHnnLe0GjCBBxmdHX4KI1
 jnWuXnL+IGf5hBVHrSRCLopgZSGVbHIzrnb767XsQLJCoxrpDQda/N6/jUxuQs2kUR1+
 k+M94FryY8llVrKmPVTkN59/9V8lEZQM9htnD5iTHAx9b41nAxva09KKeGoxaw/pQkix
 CL7jdKX82tRbQlhBYBXFjLgWn6YR5M3hvr/X0/ms4DqnDRNnq4QS+OQg8w9jxjQpa50w
 m8xieiwfQ6q2/t4/JLkeoXoFe84cz1C+psNCILwrj0WiQOrupLk+0t677Pof6iJLO0XT
 LqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718330185; x=1718934985;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qVRxt3hhhGFjQUZh8NLxdLXcqbiKvrORDB3kQN8LCUQ=;
 b=gB9LX/+vvn2kg3fIqsNz6apWFZWafU/m2JN/CSJpKukyXSNAzILTlLxwWspW6gWNtG
 GsSlCGBcM4Ts9DTxYC0LxRru3yz1CUGg3c9DBYxdz8JMeTiaMCuGzXs5/1p1QIP1kI/S
 vgdO6Lh1y0nNvq2jIqT+gu+KJ8YKoCl9pxY7kx52qFTH9auC5LP0zc7tW7BS7DV4Skpp
 t/DVJOdo/AAntZe4rCn+egKF81sv6c3y1sVCrc0ElqCimOb8NA3thjEtntOpaNIBimOy
 4nim5KnvsEaaB/SpScSAKbXZNF+8PnwRxU7dqIylgKmuh8XIESrYcAmjrVbz1pUeAvcb
 0XhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJowApXyGebErMoeyetpi1qPhu7U3BY9aHdwd4Zwcqd3DpO3p5gENl1U8zmRVwLCFvwkHIFaI2/40XiiUPPdCYvhYxk6NNjFSSu93n5ly3I3kQHCmFkEJjBcvbYQ==
X-Gm-Message-State: AOJu0YzEI3egKu8a5vGgKbCPxrV8z5e9fzWPAbqD8etUh0mEQmfrr0uq
 ESoWPNYN5uiFqG9aDTm8FhEaVmolQ22kepsRCenfDpOYTA1JqwhO
X-Google-Smtp-Source: AGHT+IE/DPZ/iiEZPPgwD1Ptgna/C0hiqu+HySxhOvb932rp6gVI/pnPRk5foTT5MhLI8hZjFRLzvg==
X-Received: by 2002:a17:903:1249:b0:1f7:1c77:b74f with SMTP id
 d9443c01a7336-1f8627c7cbfmr14592775ad.34.1718330185234; 
 Thu, 13 Jun 2024 18:56:25 -0700 (PDT)
Received: from [192.168.0.247] ([159.196.15.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e71a15sm21071925ad.83.2024.06.13.18.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 18:56:24 -0700 (PDT)
Message-ID: <3d3fd378de147c7236357eba7f9976ed8cac4d23.camel@gmail.com>
Subject: Re: [PATCH v7 3/3] hw/nvme: Add SPDM over DOE support
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair23@gmail.com>, wilfred.mallawa@wdc.com, 
 marcel.apfelbaum@gmail.com, lukas@wunner.de, qemu-devel@nongnu.org,
 mst@redhat.com,  Jonathan.Cameron@Huawei.com, kbusch@kernel.org,
 hchkuo@avery-design.com.tw,  cbrowy@avery-design.com, its@irrelevant.dk,
 jiewen.yao@intel.com
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-block@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 Klaus Jensen <k.jensen@samsung.com>
Date: Fri, 14 Jun 2024 11:56:17 +1000
In-Reply-To: <20240614012846.1016856-4-alistair.francis@wdc.com>
References: <20240614012846.1016856-1-alistair.francis@wdc.com>
 <20240614012846.1016856-4-alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 2024-06-14 at 11:28 +1000, Alistair Francis wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>=20
> Setup Data Object Exchance (DOE) as an extended capability for the
> NVME
small typo here =F0=9F=A4=93=EF=B8=8F [s/Setup Data Object Exchance/Setup D=
ata Object
Exchange]

Wilfred
> controller and connect SPDM to it (CMA) to it.
>=20
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Klaus Jensen <k.jensen@samsung.com>
> ---
> =C2=A0docs/specs/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
> =C2=A0docs/specs/spdm.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 134
> ++++++++++++++++++++++++++++++++++++
> =C2=A0include/hw/pci/pci_device.h |=C2=A0=C2=A0 7 ++
> =C2=A0include/hw/pci/pcie_doe.h=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A0hw/nvme/ctrl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 60 ++++++++++++++++
> =C2=A05 files changed, 205 insertions(+)
> =C2=A0create mode 100644 docs/specs/spdm.rst
>=20
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index 1484e3e760..e2d907959a 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -29,6 +29,7 @@ guest hardware that is specific to QEMU.
> =C2=A0=C2=A0=C2=A0 edu
> =C2=A0=C2=A0=C2=A0 ivshmem-spec
> =C2=A0=C2=A0=C2=A0 pvpanic
> +=C2=A0=C2=A0 spdm
> =C2=A0=C2=A0=C2=A0 standard-vga
> =C2=A0=C2=A0=C2=A0 virt-ctlr
> =C2=A0=C2=A0=C2=A0 vmcoreinfo
> diff --git a/docs/specs/spdm.rst b/docs/specs/spdm.rst
> new file mode 100644
> index 0000000000..f7de080ff0
> --- /dev/null
> +++ b/docs/specs/spdm.rst
> @@ -0,0 +1,134 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +QEMU Security Protocols and Data Models (SPDM) Support
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +SPDM enables authentication, attestation and key exchange to assist
> in
> +providing infrastructure security enablement. It's a standard
> published
> +by the `DMTF`_.
> +
> +QEMU supports connecting to a SPDM responder implementation. This
> allows an
> +external application to emulate the SPDM responder logic for an SPDM
> device.
> +
> +Setting up a SPDM server
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +When using QEMU with SPDM devices QEMU will connect to a server
> which
> +implements the SPDM functionality.
> +
> +SPDM-Utils
> +----------
> +
> +You can use `SPDM Utils`_ to emulate a responder. This is the
> simplest method.
> +
> +SPDM-Utils is a Linux applications to manage, test and develop
> devices
> +supporting DMTF Security Protocol and Data Model (SPDM). It is
> written in Rust
> +and utilises libspdm.
> +
> +To use SPDM-Utils you will need to do the following steps. Details
> are included
> +in the SPDM-Utils README.
> +
> + 1. `Build libspdm`_
> + 2. `Build SPDM Utils`_
> + 3. `Run it as a server`_
> +
> +spdm-emu
> +--------
> +
> +You can use `spdm emu`_ to model the
> +SPDM responder.
> +
> +.. code-block:: shell
> +
> +=C2=A0=C2=A0=C2=A0 $ cd spdm-emu
> +=C2=A0=C2=A0=C2=A0 $ git submodule init; git submodule update --recursiv=
e
> +=C2=A0=C2=A0=C2=A0 $ mkdir build; cd build
> +=C2=A0=C2=A0=C2=A0 $ cmake -DARCH=3Dx64 -DTOOLCHAIN=3DGCC -DTARGET=3DDeb=
ug -
> DCRYPTO=3Dopenssl ..
> +=C2=A0=C2=A0=C2=A0 $ make -j32
> +=C2=A0=C2=A0=C2=A0 $ make copy_sample_key # Build certificates, required=
 for SPDM
> authentication.
> +
> +It is worth noting that the certificates should be in compliance
> with
> +PCIe r6.1 sec 6.31.3. This means you will need to add the following
> to
> +openssl.cnf
> +
> +.. code-block::
> +
> +=C2=A0=C2=A0=C2=A0 subjectAltName =3D
> otherName:2.23.147;UTF8:Vendor=3D1b36:Device=3D0010:CC=3D010802:REV=3D02:=
SSVI
> D=3D1af4:SSID=3D1100
> +=C2=A0=C2=A0=C2=A0 2.23.147 =3D ASN1:OID:2.23.147
> +
> +and then manually regenerate some certificates with:
> +
> +.. code-block:: shell
> +
> +=C2=A0=C2=A0=C2=A0 $ openssl req -nodes -newkey ec:param.pem -keyout
> end_responder.key \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -out end_responder.req -sha38=
4 -batch \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -subj "/CN=3DDMTF libspdm ECP=
384 responder cert"
> +
> +=C2=A0=C2=A0=C2=A0 $ openssl x509 -req -in end_responder.req -out
> end_responder.cert \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -CA inter.cert -CAkey inter.k=
ey -sha384 -days 3650 -
> set_serial 3 \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -extensions v3_end -extfile .=
./openssl.cnf
> +
> +=C2=A0=C2=A0=C2=A0 $ openssl asn1parse -in end_responder.cert -out
> end_responder.cert.der
> +
> +=C2=A0=C2=A0=C2=A0 $ cat ca.cert.der inter.cert.der end_responder.cert.d=
er >
> bundle_responder.certchain.der
> +
> +You can use SPDM-Utils instead as it will generate the correct
> certificates
> +automatically.
> +
> +The responder can then be launched with
> +
> +.. code-block:: shell
> +
> +=C2=A0=C2=A0=C2=A0 $ cd bin
> +=C2=A0=C2=A0=C2=A0 $ ./spdm_responder_emu --trans PCI_DOE
> +
> +Connecting an SPDM NVMe device
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +Once a SPDM server is running we can start QEMU and connect to the
> server.
> +
> +For an NVMe device first let's setup a block we can use
> +
> +.. code-block:: shell
> +
> +=C2=A0=C2=A0=C2=A0 $ cd qemu-spdm/linux/image
> +=C2=A0=C2=A0=C2=A0 $ dd if=3D/dev/zero of=3Dblknvme bs=3D1M count=3D2096=
 # 2GB NNMe Drive
> +
> +Then you can add this to your QEMU command line:
> +
> +.. code-block:: shell
> +
> +=C2=A0=C2=A0=C2=A0 -drive file=3Dblknvme,if=3Dnone,id=3Dmynvme,format=3D=
raw \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -device nvme,drive=3Dmynvme,s=
erial=3Ddeadbeef,spdm_port=3D2323
> +
> +At which point QEMU will try to connect to the SPDM server.
> +
> +Note that if using x64-64 you will want to use the q35 machine
> instead
> +of the default. So the entire QEMU command might look like this
> +
> +.. code-block:: shell
> +
> +=C2=A0=C2=A0=C2=A0 qemu-system-x86_64 -M q35 \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --kernel bzImage \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -drive file=3Drootfs.ext2,if=
=3Dvirtio,format=3Draw \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -append "root=3D/dev/vda cons=
ole=3DttyS0" \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -net none -nographic \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -drive file=3Dblknvme,if=3Dno=
ne,id=3Dmynvme,format=3Draw \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -device nvme,drive=3Dmynvme,s=
erial=3Ddeadbeef,spdm_port=3D2323
> +
> +.. _DMTF:
> +=C2=A0=C2=A0 https://www.dmtf.org/standards/SPDM
> +
> +.. _SPDM Utils:
> +=C2=A0=C2=A0 https://github.com/westerndigitalcorporation/spdm-utils
> +
> +.. _spdm emu:
> +=C2=A0=C2=A0 https://github.com/dmtf/spdm-emu
> +
> +.. _Build libspdm:
> +=C2=A0=C2=A0
> https://github.com/westerndigitalcorporation/spdm-utils?tab=3Dreadme-ov-f=
ile#build-libspdm
> +
> +.. _Build SPDM Utils:
> +=C2=A0=C2=A0
> https://github.com/westerndigitalcorporation/spdm-utils?tab=3Dreadme-ov-f=
ile#build-the-binary
> +
> +.. _Run it as a server:
> +=C2=A0=C2=A0
> https://github.com/westerndigitalcorporation/spdm-utils#qemu-spdm-device-=
emulation
> diff --git a/include/hw/pci/pci_device.h
> b/include/hw/pci/pci_device.h
> index d3dd0f64b2..15694f2489 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -3,6 +3,7 @@
> =C2=A0
> =C2=A0#include "hw/pci/pci.h"
> =C2=A0#include "hw/pci/pcie.h"
> +#include "hw/pci/pcie_doe.h"
> =C2=A0
> =C2=A0#define TYPE_PCI_DEVICE "pci-device"
> =C2=A0typedef struct PCIDeviceClass PCIDeviceClass;
> @@ -157,6 +158,12 @@ struct PCIDevice {
> =C2=A0=C2=A0=C2=A0=C2=A0 MSIVectorReleaseNotifier msix_vector_release_not=
ifier;
> =C2=A0=C2=A0=C2=A0=C2=A0 MSIVectorPollNotifier msix_vector_poll_notifier;
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 /* SPDM */
> +=C2=A0=C2=A0=C2=A0 uint16_t spdm_port;
> +
> +=C2=A0=C2=A0=C2=A0 /* DOE */
> +=C2=A0=C2=A0=C2=A0 DOECap doe_spdm;
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 /* ID of standby device in net_failover pair */
> =C2=A0=C2=A0=C2=A0=C2=A0 char *failover_pair_id;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t acpi_index;
> diff --git a/include/hw/pci/pcie_doe.h b/include/hw/pci/pcie_doe.h
> index 15d94661f9..9e1275db8a 100644
> --- a/include/hw/pci/pcie_doe.h
> +++ b/include/hw/pci/pcie_doe.h
> @@ -108,6 +108,9 @@ struct DOECap {
> =C2=A0=C2=A0=C2=A0=C2=A0 /* Protocols and its callback response */
> =C2=A0=C2=A0=C2=A0=C2=A0 DOEProtocol *protocols;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint16_t protocol_num;
> +
> +=C2=A0=C2=A0=C2=A0 /* Used for spdm-socket */
> +=C2=A0=C2=A0=C2=A0 int spdm_socket;
> =C2=A0};
> =C2=A0
> =C2=A0void pcie_doe_init(PCIDevice *pdev, DOECap *doe_cap, uint16_t
> offset,
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 127c3d2383..db41f7c8d0 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -203,6 +203,7 @@
> =C2=A0#include "sysemu/hostmem.h"
> =C2=A0#include "hw/pci/msix.h"
> =C2=A0#include "hw/pci/pcie_sriov.h"
> +#include "sysemu/spdm-socket.h"
> =C2=A0#include "migration/vmstate.h"
> =C2=A0
> =C2=A0#include "nvme.h"
> @@ -8087,6 +8088,27 @@ static int nvme_add_pm_capability(PCIDevice
> *pci_dev, uint8_t offset)
> =C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> =C2=A0}
> =C2=A0
> +static bool pcie_doe_spdm_rsp(DOECap *doe_cap)
> +{
> +=C2=A0=C2=A0=C2=A0 void *req =3D pcie_doe_get_write_mbox_ptr(doe_cap);
> +=C2=A0=C2=A0=C2=A0 uint32_t req_len =3D pcie_doe_get_obj_len(req) * 4;
> +=C2=A0=C2=A0=C2=A0 void *rsp =3D doe_cap->read_mbox;
> +=C2=A0=C2=A0=C2=A0 uint32_t rsp_len =3D SPDM_SOCKET_MAX_MESSAGE_BUFFER_S=
IZE;
> +
> +=C2=A0=C2=A0=C2=A0 uint32_t recvd =3D spdm_socket_rsp(doe_cap->spdm_sock=
et,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 req, req_len, rsp, rsp_len);
> +=C2=A0=C2=A0=C2=A0 doe_cap->read_mbox_len +=3D DIV_ROUND_UP(recvd, 4);
> +
> +=C2=A0=C2=A0=C2=A0 return recvd !=3D 0;
> +}
> +
> +static DOEProtocol doe_spdm_prot[] =3D {
> +=C2=A0=C2=A0=C2=A0 { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_CMA, pcie_doe_sp=
dm_rsp },
> +=C2=A0=C2=A0=C2=A0 { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_SECURED_CMA,
> pcie_doe_spdm_rsp },
> +=C2=A0=C2=A0=C2=A0 { }
> +};
> +
> =C2=A0static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error
> **errp)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 ERRP_GUARD();
> @@ -8157,6 +8179,25 @@ static bool nvme_init_pci(NvmeCtrl *n,
> PCIDevice *pci_dev, Error **errp)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 nvme_update_msixcap_ts(pci_dev, n->conf_msix_qsi=
ze);
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 pcie_cap_deverr_init(pci_dev);
> +
> +=C2=A0=C2=A0=C2=A0 /* DOE Initialisation */
> +=C2=A0=C2=A0=C2=A0 if (pci_dev->spdm_port) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t doe_offset =3D n->pa=
rams.sriov_max_vfs ?
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCI_CONFIG_SPACE_SIZE +
> PCI_ARI_SIZEOF
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : PCI_CONFIG_SPACE_SIZE=
;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcie_doe_init(pci_dev, &pci_d=
ev->doe_spdm, doe_offset,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doe_spdm_prot, true,=
 0);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_dev->doe_spdm.spdm_socket=
 =3D spdm_socket_connect(pci_dev-
> >spdm_port,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errp);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pci_dev->doe_spdm.spdm_so=
cket < 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n false;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 if (n->params.cmb_size_mb) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvme_init_cmb(n, pci_dev=
);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> @@ -8407,6 +8448,11 @@ static void nvme_exit(PCIDevice *pci_dev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(n->cmb.buf);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 if (pci_dev->doe_spdm.spdm_socket > 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spdm_socket_close(pci_dev->do=
e_spdm.spdm_socket,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE);
> +=C2=A0=C2=A0=C2=A0 }
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 if (n->pmr.dev) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 host_memory_backend_set_=
mapped(n->pmr.dev, false);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> @@ -8451,6 +8497,7 @@ static Property nvme_props[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 params.sriov_m=
ax_vq_per_vf, 0),
> =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("msix-exclusive-bar", NvmeCtrl,
> params.msix_exclusive_bar,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 false),
> +=C2=A0=C2=A0=C2=A0 DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port,=
 0),
> =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_END_OF_LIST(),
> =C2=A0};
> =C2=A0
> @@ -8522,11 +8569,23 @@ static void nvme_pci_write_config(PCIDevice
> *dev, uint32_t address,
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 uint16_t old_num_vfs =3D pcie_sriov_num_vfs(dev)=
;
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 pcie_doe_write_config(&dev->doe_spdm, address, val, l=
en);
> =C2=A0=C2=A0=C2=A0=C2=A0 pci_default_write_config(dev, address, val, len)=
;
> =C2=A0=C2=A0=C2=A0=C2=A0 pcie_cap_flr_write_config(dev, address, val, len=
);
> =C2=A0=C2=A0=C2=A0=C2=A0 nvme_sriov_post_write_config(dev, old_num_vfs);
> =C2=A0}
> =C2=A0
> +static uint32_t nvme_pci_read_config(PCIDevice *dev, uint32_t
> address, int len)
> +{
> +=C2=A0=C2=A0=C2=A0 uint32_t val;
> +=C2=A0=C2=A0=C2=A0 if (dev->spdm_port) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pcie_doe_read_config(&dev=
->doe_spdm, address, len,
> &val)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n val;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 return pci_default_read_config(dev, address, len);
> +}
> +
> =C2=A0static const VMStateDescription nvme_vmstate =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "nvme",
> =C2=A0=C2=A0=C2=A0=C2=A0 .unmigratable =3D 1,
> @@ -8539,6 +8598,7 @@ static void nvme_class_init(ObjectClass *oc,
> void *data)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 pc->realize =3D nvme_realize;
> =C2=A0=C2=A0=C2=A0=C2=A0 pc->config_write =3D nvme_pci_write_config;
> +=C2=A0=C2=A0=C2=A0 pc->config_read =3D nvme_pci_read_config;
> =C2=A0=C2=A0=C2=A0=C2=A0 pc->exit =3D nvme_exit;
> =C2=A0=C2=A0=C2=A0=C2=A0 pc->class_id =3D PCI_CLASS_STORAGE_EXPRESS;
> =C2=A0=C2=A0=C2=A0=C2=A0 pc->revision =3D 2;


