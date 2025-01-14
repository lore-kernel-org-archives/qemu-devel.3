Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB1DC02180
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 03:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXXDa-0005gy-LS; Mon, 13 Jan 2025 22:03:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1tXXDX-0005gi-LC
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 22:03:48 -0500
Received: from out-188.mta1.migadu.com ([95.215.58.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1tXXDT-00068d-5t
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 22:03:46 -0500
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1736823810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p2EILlSEDozgszdoKqDTJa0feemeKFTAaSGuvQrmH98=;
 b=IRS6KAji6aLUr0n5NhTZPSPMmZE9YQDICBMczFCli7M67p3Q3yESHZIWYfCy+scqkuY35W
 Da8vyPhNVNRRsBPJ37GyTB7S83uBq/YR0eM1qfeUWGeswfkDOkXpJnRVDb3KMF9UrJA0i/
 PDiWwBuznkntomSzIl4qEV/toAbb8B8=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: CXL emulation on aarch64
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
In-Reply-To: <20250110123128.00004a5b@huawei.com>
Date: Tue, 14 Jan 2025 12:03:03 +0900
Cc: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <09D52CDC-44E5-48C4-8D32-E4DD0964F9AF@linux.dev>
References: <0C019F50-9020-42ED-B051-998F03BFB709@linux.dev>
 <483e8037-3c72-4560-b4b8-2437d37ca8c4@fujitsu.com>
 <20250110123128.00004a5b@huawei.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.188;
 envelope-from=itaru.kitayama@linux.dev; helo=out-188.mta1.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Jonathan,=20

> On Jan 10, 2025, at 21:31, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>=20
> On Fri, 10 Jan 2025 09:20:54 +0000
> "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org> wrote:
>=20
>> On 10/01/2025 13:29, Itaru Kitayama wrote:
>>> Hi,
>>> Is anybody working on the CXL emulation on aarch64? =20
>>=20
>> I'm not currently working on the CXL emulation on aarch64.
>>=20
>> However, IIRC the CXL maintainer's tree should work.
>> https://gitlab.com/jic23/qemu/
>=20
> Pick up latest branch from there. I'm prepping a rebased version
> with some new stuff but might take a few more days.

Thanks for sharing your work with us.  Your master and cxl-2024-11-27 =
branches give:

$ qemu-system-aarch64: -accel tcg,cxl=3Don: Property 'tcg-accel.cxl' not =
found

My commands are below:
$HOME/projects/qemu/build/qemu-system-aarch64 \
        -M virt,virtualization=3Don,gic-version=3D3 \
        -M acpi=3Doff -cpu max,sme=3Doff -m 8G -smp 4 \
        -accel tcg,cxl=3Don \
        -nographic \
        -bios $HOME/cca-v4/out/bin/flash.bin \
        -kernel Image-cca \
        -drive =
format=3Draw,if=3Dnone,file=3D$HOME/cca-v4/out-or/images/rootfs.ext2,id=3D=
hd0 \
        -device virtio-blk-pci,drive=3Dhd0 \
        -append root=3D/dev/vda \
        -nodefaults \
        --serial tcp:localhost:54320 \
         -serial tcp:localhost:54321 \
         -append "root=3D/dev/vda earlycon console=3Dhvc0" \
         -device virtio-net-pci,netdev=3Dnet0 \
         -netdev user,id=3Dnet0 \
         -device virtio-9p-device,fsdev=3Dshr0,mount_tag=3Dshr0 \
         -fsdev local,security_model=3Dnone,path=3D../../,id=3Dshr0

Yes, I=E2=80=99m using Linaro=E2=80=99s CCA capable OP-TEE builds above.

Let me know which branch you were suggesting.

Thanks,
Itaru.=20

>=20
> Note my main development work is on arm64 so that tends to work
> more reliably than x86 which I only lightly test for stuff that
> isn't ready for upstream yet.
>=20
> Give me a shout if you run into any problems.
>=20
> The main blocker on upstreaming this is resolving the missing device =
tree
> support for PCI expander bridges.  I've not made any progress on this =
since
> talk at Linaro connect in 2023.
>=20
> Jonathan
>=20
>=20
>>=20
>>=20
>> Thanks
>> Zhijian
>>=20
>>> If there=E2=80=99s a WIP branch, a pointer would be appreciated.
>>>=20
>>> Itaru =20
>=20


