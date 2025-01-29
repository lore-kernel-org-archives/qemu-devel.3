Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76698C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 23:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdH9T-00044x-0c; Wed, 29 Jan 2025 18:07:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1tdH9Q-00044j-PF
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 18:07:17 -0500
Received: from out-180.mta1.migadu.com ([95.215.58.180])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1tdH9M-0002nh-GR
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 18:07:16 -0500
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1738192029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yoiunaMzsKKnHJMoO+ti7Wtkhq/h3akOoncHfuMDgfM=;
 b=YhSk5MdDIQMG/8KvLa55ueb4hpNDkgNz4o3Asluoh3kkN+o+W+yUpQJFvewF9sDfaLm0Sa
 IyUdzk80FElc5ov33CWZYsotfdYzm7OkV8mb4hO978SAFEmi3aFKtKBTpi1xXWZ94qnzRp
 Hr2jL1D1CyO3uiPEohA9KPUm1tx2Iqk=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: CXL emulation on aarch64
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
In-Reply-To: <20250129171635.00001c04@huawei.com>
Date: Thu, 30 Jan 2025 08:06:42 +0900
Cc: Jonathan Cameron via <qemu-devel@nongnu.org>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A60023D-21EF-4F4C-939D-40197C7AB32D@linux.dev>
References: <0C019F50-9020-42ED-B051-998F03BFB709@linux.dev>
 <483e8037-3c72-4560-b4b8-2437d37ca8c4@fujitsu.com>
 <20250110123128.00004a5b@huawei.com>
 <09D52CDC-44E5-48C4-8D32-E4DD0964F9AF@linux.dev>
 <20250114102626.00000c53@huawei.com>
 <88E9D774-A760-45F7-A173-24A07BB55733@linux.dev>
 <20250116105833.000056da@huawei.com>
 <9DF43D0C-E03E-420E-AB4E-0EE571D06A38@linux.dev>
 <20250117094311.00000e64@huawei.com> <20250122140712.00000682@huawei.com>
 <80DA1137-69C2-4B94-A0FA-43A1B3E1D4C3@linux.dev>
 <20250129171635.00001c04@huawei.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.180;
 envelope-from=itaru.kitayama@linux.dev; helo=out-180.mta1.migadu.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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



> On Jan 30, 2025, at 2:16, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>=20
> On Wed, 29 Jan 2025 10:14:34 +0900
> Itaru Kitayama <itaru.kitayama@linux.dev> wrote:
>=20
>>> On Jan 22, 2025, at 23:07, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>>>=20
>>> On Fri, 17 Jan 2025 09:43:11 +0000
>>> Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
>>>=20
>>>> On Fri, 17 Jan 2025 10:13:41 +0900
>>>> Itaru Kitayama <itaru.kitayama@linux.dev> wrote:
>>>>=20
>>>>>> On Jan 16, 2025, at 19:58, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>>>>>>=20
>>>>>> On Thu, 16 Jan 2025 15:04:53 +0900
>>>>>> Itaru Kitayama <itaru.kitayama@linux.dev> wrote:
>>>>>>=20
>>>>>>> Hi Jonathan,
>>>>>>>=20
>>>>>>>> On Jan 14, 2025, at 19:26, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>>>>>>>>=20
>>>>>>>> On Tue, 14 Jan 2025 12:03:03 +0900
>>>>>>>> Itaru Kitayama <itaru.kitayama@linux.dev> wrote:
>>>>>>>>=20
>>>>>>>>> Hi Jonathan,=20
>>>>>>>>>=20
>>>>>>>>>> On Jan 10, 2025, at 21:31, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>>>>>>>>>>=20
>>>>>>>>>> On Fri, 10 Jan 2025 09:20:54 +0000
>>>>>>>>>> "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org> wrote:
>>>>>>>>>>=20
>>>>>>>>>>> On 10/01/2025 13:29, Itaru Kitayama wrote:         =20
>>>>>>>>>>>> Hi,
>>>>>>>>>>>> Is anybody working on the CXL emulation on aarch64?         =
  =20
>>>>>>>>>>>=20
>>>>>>>>>>> I'm not currently working on the CXL emulation on aarch64.
>>>>>>>>>>>=20
>>>>>>>>>>> However, IIRC the CXL maintainer's tree should work.
>>>>>>>>>>> https://gitlab.com/jic23/qemu/         =20
>>>>>>>>>>=20
>>>>>>>>>> Pick up latest branch from there. I'm prepping a rebased =
version
>>>>>>>>>> with some new stuff but might take a few more days.         =20=

>>>>>>>>>=20
>>>>>>>>> Thanks for sharing your work with us.  Your master and =
cxl-2024-11-27 branches give:
>>>>>>>>>=20
>>>>>>>>> $ qemu-system-aarch64: -accel tcg,cxl=3Don: Property =
'tcg-accel.cxl' not found       =20
>>>>>>>>=20
>>>>>>>> cxl is a machine property not a accel one. So needs to be after =
virt
>>>>>>>> There are tests in the tree for bios tables. Copy the command =
line from those.
>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>> My commands are below:
>>>>>>>>> $HOME/projects/qemu/build/qemu-system-aarch64 \
>>>>>>>>>     -M virt,virtualization=3Don,gic-version=3D3 \
>>>>>>>>>     -M acpi=3Doff -cpu max,sme=3Doff -m 8G -smp 4 \
>>>>>>>>>     -accel tcg,cxl=3Don \
>>>>>>>>>     -nographic \
>>>>>>>>>     -bios $HOME/cca-v4/out/bin/flash.bin \
>>>>>>>>>     -kernel Image-cca \
>>>>>>>>>     -drive =
format=3Draw,if=3Dnone,file=3D$HOME/cca-v4/out-or/images/rootfs.ext2,id=3D=
hd0 \
>>>>>>>>>     -device virtio-blk-pci,drive=3Dhd0 \
>>>>>>>>>     -append root=3D/dev/vda \
>>>>>>>>>     -nodefaults \
>>>>>>>>>     --serial tcp:localhost:54320 \
>>>>>>>>>      -serial tcp:localhost:54321 \
>>>>>>>>>      -append "root=3D/dev/vda earlycon console=3Dhvc0" \
>>>>>>>>>      -device virtio-net-pci,netdev=3Dnet0 \
>>>>>>>>>      -netdev user,id=3Dnet0 \
>>>>>>>>>      -device virtio-9p-device,fsdev=3Dshr0,mount_tag=3Dshr0 \
>>>>>>>>>      -fsdev local,security_model=3Dnone,path=3D../../,id=3Dshr0
>>>>>>>>>=20
>>>>>>>>> Yes, I=E2=80=99m using Linaro=E2=80=99s CCA capable OP-TEE =
builds above.       =20
>>>>>>>>=20
>>>>>>>> I'm a little curious why optee is relevant for this but =
shouldn't matter as long
>>>>>>>> as an appropriate EDK2 is loaded.
>>>>>>>>=20
>>>>>>>=20
>>>>>>> I picked up your tree=E2=80=99s =E2=80=9Cmaster=E2=80=9D and =
=E2=80=9Ccxl-next=E2=80=9D as of today, and only the latter at least =
booted.
>>>>>>> The former gives:
>>>>>>>=20
>>>>>>> qemu-system-aarch64: Property 'virt-9.2-machine.cxl' not found
>>>>>>>=20
>>>>>>> Should I stick with the cxl-next? My concern is that the base =
QEMU version is a bit old
>>>>>>> 7.0.50.     =20
>>>>>>=20
>>>>>> Always use the latest dated branch on that tree.  I release =
whenever there
>>>>>> is something new to carry or a major rebase needed.
>>>>>>=20
>>>>>> cxl-<date> is the right branch to use. Hope that helps.     =20
>>>>>=20
>>>>> When do you think you want to get them (aarch64 specific?) merged =
mainline. Any reason you want to carry the patches by yourself?   =20
>>>>=20
>>>> Nothing much has changed since I presented on this at Linaro =
connect in 2023.
>>>> https://resources.linaro.org/en/resource/hM986DSHfoTrZ98UjpvLg1
>>>>=20
>>>> The issue is device tree bindings for PCI Expander bridgess and the =
fact that
>>>> those need to be generated without the full enumeration that EDK2 =
is doing
>>>> prior to ACPI final table builds. In order to move forward with =
that it
>>>> needs a bunch of work to prove that we absolutely cannot get =
patches
>>>> upstream to support kernel base enumeration and breaking up of the
>>>> various resources (like EDK2 does). =20
>>>=20
>>> I was talking to Peter Maydell earlier and given developments in the =
last couple
>>> of years that have by necessity been ACPI only in arm virt he is =
less
>>> opposed to ACPI only features being added where device tree is =
challenging.
>>>=20
>>> So we may be able to move forwards without device tree support.
>>>=20
>>> The PXB enumeration question is also relevant for managing multiple
>>> vIOMMUs to represent multiple physical IOMMUs with the correct =
isolation
>>> and do it efficiently which is probably a more pressing usecase than =
CXL emulation.
>>> The discussion was mainly about that usecase, but maybe it also =
unblocks
>>> upstreaming this support.
>>>=20
>>> Thanks,
>>>=20
>>> Jonathan =20
>>=20
>> I finally made some CXL tests ran within the ndctl test framework =
along with the kernel modules (QEMU is on your cxl-2024-11-27 branch) on =
aarch64. However, the recent rebase cxl-2025-01-24 fails to start the =
system emulation
>>=20
>> qemu-system-aarch64: Property 'virt-10.0-machine.cxl' not found
>>=20
>> The build did not complain, what kind of tests you run against your =
periodical QEMU rebase?
>=20
> On this run I was focused on chmu testing which will have included =
what you
> are running into here.  It's made a little tricky by some local =
networking issues
> so getting a branch up on gitlab is far from straight forward.
>=20
> Ah. Looks like the push went wrong as that has 0 patches on top of =
main qemu branch
> so that branch is effectively empty. Typo in what I pushed.
> Sorry about that.

Not at all. I confirmed that the same branch now boots fine.
=20
>=20
> Note this is far from a production tree as it carries many patches =
with outstanding
> review comments etc.  Mainly exists for the purposes of testing =
specific kernel
> patches where the support is not ready for upstream QEMU yet.  It is =
not in any
> sense a 'release' with the sort of testing that would imply, so mostly =
a case
> of local smoke tests.

I understand this.

Thanks,
Itaru.

>=20
> Any help with more comprehensive tests would be much appreciated. I =
know some other
> folk in the CXL community are talking about that, but I don't think =
anyone has
> it in place yet. It's hard as there are typically a lot of moving =
parts.
>=20
> Pushed now.
>=20
> Jonathan
>=20
>=20
>=20
>=20
>>=20
>> Itaru.=20
>>=20
>>>=20
>>>>=20
>>>> Given PXB enumeration in kernel has some issues on ARM anyway (that =
you can paper
>>>> over with _DSM 5 - it self requiring an extra patch that isn't =
upstreamable because
>>>> of IO port issues) there is quite a bit of work needed, mostly not =
in QEMU.
>>>> Or convince Peter and others that not all virt support needs DT =
bindings
>>>> (note that PXB for PCIE has been supported for years without an DT =
support,
>>>> just no one noticed!)
>>>>=20
>>>> After that we'd need to figure out CXL DT bindings in general and =
add kernel
>>>> code support - despite there being no known DT based CXL systems =
out there, so
>>>> that is going to be hard to do.  Various CXL kernel maintainers =
have expressed
>>>> they aren't against such support, but it's hardly going to be =
review priority
>>>> (other than for me if someone else does the work!)
>>>>=20
>>>> For me this isn't particularly high priority. The ARM bit is fairly =
easy to rebase.
>>>> I would like to see it solved, but it is behind various other items =
on my
>>>> backlog.
>>>>=20
>>>> There are SBSA machine patches on list, but it's not a useful =
platform for
>>>> CXL kernel code development because of the limited supported =
configurations
>>>> (in keeping with the more or less fixed model that SBSA-ref uses).
>>>>=20
>>>> Jonathan
>>>>=20
>>>>=20
>>>>=20
>>>>>=20
>>>>> Itaru.
>>>>>=20
>>>>>>=20
>>>>>> Jonathan
>>>>>>=20
>>>>>>>=20
>>>>>>> Thanks,
>>>>>>> Itaru.
>>>>>>>=20
>>>>>>>> Jonathan
>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>> Let me know which branch you were suggesting.
>>>>>>>>>=20
>>>>>>>>> Thanks,
>>>>>>>>> Itaru.=20
>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>> Note my main development work is on arm64 so that tends to =
work
>>>>>>>>>> more reliably than x86 which I only lightly test for stuff =
that
>>>>>>>>>> isn't ready for upstream yet.
>>>>>>>>>>=20
>>>>>>>>>> Give me a shout if you run into any problems.
>>>>>>>>>>=20
>>>>>>>>>> The main blocker on upstreaming this is resolving the missing =
device tree
>>>>>>>>>> support for PCI expander bridges.  I've not made any progress =
on this since
>>>>>>>>>> talk at Linaro connect in 2023.
>>>>>>>>>>=20
>>>>>>>>>> Jonathan
>>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>>>=20
>>>>>>>>>>>=20
>>>>>>>>>>> Thanks
>>>>>>>>>>> Zhijian
>>>>>>>>>>>=20
>>>>>>>>>>>> If there=E2=80=99s a WIP branch, a pointer would be =
appreciated.
>>>>>>>>>>>>=20
>>>>>>>>>>>> Itaru           =20



