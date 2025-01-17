Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D35BC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 00:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYaAE-0007sJ-5p; Thu, 16 Jan 2025 19:24:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1tYaAB-0007s1-A1
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 19:24:40 -0500
Received: from out-175.mta1.migadu.com ([95.215.58.175])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1tYaA8-0000rG-KP
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 19:24:39 -0500
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1737073473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LCKFR+/+9ig7WOQZWf5TdCH6BD1FyjSsB0Pw5mMJOIg=;
 b=nyJ2kJ3uEjiYPzpLljaQb32xWcZvaoFlQ+xrfyxVOxhmeC+h+z9oUWbo384/oUX8Trb8qd
 3eafSTnX5EpQc6YXITCqI0l0gBbJgUJcZC5GH7JxEuMVPfOlXrWgWG3mGAk3x8/Pvej3Iz
 ypxh/Uul5eS7yFDnH9u9YA+bqgsX78o=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: CXL emulation on aarch64
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
In-Reply-To: <20250116105833.000056da@huawei.com>
Date: Fri, 17 Jan 2025 09:24:15 +0900
Cc: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C7740553-EA65-4576-9FAB-13780CA3D810@linux.dev>
References: <0C019F50-9020-42ED-B051-998F03BFB709@linux.dev>
 <483e8037-3c72-4560-b4b8-2437d37ca8c4@fujitsu.com>
 <20250110123128.00004a5b@huawei.com>
 <09D52CDC-44E5-48C4-8D32-E4DD0964F9AF@linux.dev>
 <20250114102626.00000c53@huawei.com>
 <88E9D774-A760-45F7-A173-24A07BB55733@linux.dev>
 <20250116105833.000056da@huawei.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.175;
 envelope-from=itaru.kitayama@linux.dev; helo=out-175.mta1.migadu.com
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



> On Jan 16, 2025, at 19:58, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>=20
> On Thu, 16 Jan 2025 15:04:53 +0900
> Itaru Kitayama <itaru.kitayama@linux.dev> wrote:
>=20
>> Hi Jonathan,
>>=20
>>> On Jan 14, 2025, at 19:26, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>>>=20
>>> On Tue, 14 Jan 2025 12:03:03 +0900
>>> Itaru Kitayama <itaru.kitayama@linux.dev> wrote:
>>>=20
>>>> Hi Jonathan,=20
>>>>=20
>>>>> On Jan 10, 2025, at 21:31, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>>>>>=20
>>>>> On Fri, 10 Jan 2025 09:20:54 +0000
>>>>> "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org> wrote:
>>>>>=20
>>>>>> On 10/01/2025 13:29, Itaru Kitayama wrote:   =20
>>>>>>> Hi,
>>>>>>> Is anybody working on the CXL emulation on aarch64?     =20
>>>>>>=20
>>>>>> I'm not currently working on the CXL emulation on aarch64.
>>>>>>=20
>>>>>> However, IIRC the CXL maintainer's tree should work.
>>>>>> https://gitlab.com/jic23/qemu/   =20
>>>>>=20
>>>>> Pick up latest branch from there. I'm prepping a rebased version
>>>>> with some new stuff but might take a few more days.   =20
>>>>=20
>>>> Thanks for sharing your work with us.  Your master and =
cxl-2024-11-27 branches give:
>>>>=20
>>>> $ qemu-system-aarch64: -accel tcg,cxl=3Don: Property =
'tcg-accel.cxl' not found =20
>>>=20
>>> cxl is a machine property not a accel one. So needs to be after virt
>>> There are tests in the tree for bios tables. Copy the command line =
from those.
>>>=20
>>>>=20
>>>> My commands are below:
>>>> $HOME/projects/qemu/build/qemu-system-aarch64 \
>>>>       -M virt,virtualization=3Don,gic-version=3D3 \
>>>>       -M acpi=3Doff -cpu max,sme=3Doff -m 8G -smp 4 \
>>>>       -accel tcg,cxl=3Don \
>>>>       -nographic \
>>>>       -bios $HOME/cca-v4/out/bin/flash.bin \
>>>>       -kernel Image-cca \
>>>>       -drive =
format=3Draw,if=3Dnone,file=3D$HOME/cca-v4/out-or/images/rootfs.ext2,id=3D=
hd0 \
>>>>       -device virtio-blk-pci,drive=3Dhd0 \
>>>>       -append root=3D/dev/vda \
>>>>       -nodefaults \
>>>>       --serial tcp:localhost:54320 \
>>>>        -serial tcp:localhost:54321 \
>>>>        -append "root=3D/dev/vda earlycon console=3Dhvc0" \
>>>>        -device virtio-net-pci,netdev=3Dnet0 \
>>>>        -netdev user,id=3Dnet0 \
>>>>        -device virtio-9p-device,fsdev=3Dshr0,mount_tag=3Dshr0 \
>>>>        -fsdev local,security_model=3Dnone,path=3D../../,id=3Dshr0
>>>>=20
>>>> Yes, I=E2=80=99m using Linaro=E2=80=99s CCA capable OP-TEE builds =
above. =20
>>>=20
>>> I'm a little curious why optee is relevant for this but shouldn't =
matter as long
>>> as an appropriate EDK2 is loaded.
>>>=20
>>=20
>> I picked up your tree=E2=80=99s =E2=80=9Cmaster=E2=80=9D and =
=E2=80=9Ccxl-next=E2=80=9D as of today, and only the latter at least =
booted.
>> The former gives:
>>=20
>> qemu-system-aarch64: Property 'virt-9.2-machine.cxl' not found
>>=20
>> Should I stick with the cxl-next? My concern is that the base QEMU =
version is a bit old
>> 7.0.50.
>=20
> Always use the latest dated branch on that tree.  I release whenever =
there
> is something new to carry or a major rebase needed.
>=20
> cxl-<date> is the right branch to use. Hope that helps.
>=20

Okay the cxl-2024-11-27 gives this:

qemu-system-aarch64: CFMWS does not fit under PA limit

Below is my QEMU options I use currently:

/home/itaru/projects/qemu/build/qemu-system-aarch64 \
         -M =
virt,virtualization=3Don,pflash0=3Drom,pflash1=3Defivars,gic-version=3D3,v=
irtualization=3Don,cxl=3Don -m 8192 \
         -cpu cortex-a53 \
         -smp 2 \
         -accel tcg \
         -nographic \
         -display none \
         -kernel ${HOME}/projects/linux/arch/arm64/boot/Image \
         -append "root=3D/dev/vda rw earlycon acpi=3Dforce" \
         -drive format=3Draw,if=3Dnone,file=3D${HOME}/ubuntu24.img,id=3Dhd=
0 \
         -device virtio-blk-pci,drive=3Dhd0 \
         -nodefaults \
         -serial mon:stdio \
         -device virtio-net-pci,netdev=3Dnet0 \
         -netdev user,id=3Dnet0,hostfwd=3Dtcp::8024-:22 \
         -blockdev =
node-name=3Drom,driver=3Dfile,filename=3Dedk2-aarch64-code.fd,read-only=3D=
true \
         -blockdev =
node-name=3Defivars,driver=3Dfile,filename=3Dqemu-arm64-efivars.test \
         -object =
memory-backend-file,id=3Dcxl-mem1,share=3Don,mem-path=3D/tmp/cxltest.raw,s=
ize=3D256M \
         -object =
memory-backend-file,id=3Dcxl-lsa1,share=3Don,mem-path=3D/tmp/lsa.raw,size=3D=
256M \
         -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
         -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,=
slot=3D2 \
         -device =
cxl-type3,bus=3Droot_port13,memdev=3Dcxl-mem1,lsa=3Dcxl-lsa1,id=3Dcxl-pmem=
0 \
         -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G

> Jonathan
>=20
>>=20
>> Thanks,
>> Itaru.
>>=20
>>> Jonathan
>>>=20
>>>>=20
>>>> Let me know which branch you were suggesting.
>>>>=20
>>>> Thanks,
>>>> Itaru.=20
>>>>=20
>>>>>=20
>>>>> Note my main development work is on arm64 so that tends to work
>>>>> more reliably than x86 which I only lightly test for stuff that
>>>>> isn't ready for upstream yet.
>>>>>=20
>>>>> Give me a shout if you run into any problems.
>>>>>=20
>>>>> The main blocker on upstreaming this is resolving the missing =
device tree
>>>>> support for PCI expander bridges.  I've not made any progress on =
this since
>>>>> talk at Linaro connect in 2023.
>>>>>=20
>>>>> Jonathan
>>>>>=20
>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>> Thanks
>>>>>> Zhijian
>>>>>>=20
>>>>>>> If there=E2=80=99s a WIP branch, a pointer would be appreciated.
>>>>>>>=20
>>>>>>> Itaru     =20



