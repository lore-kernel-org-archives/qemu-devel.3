Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BB5606A329
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=FLVP5/6s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO9HA-00029j-0x; Tue, 03 Nov 2026 02:49:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengtian10@huawei.com>)
 id 1xO9H7-00028s-Ct; Tue, 03 Nov 2026 02:49:45 -0500
Received: from canpmsgout01.his.huawei.com ([113.46.200.216])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengtian10@huawei.com>)
 id 1xO9H4-0007hH-3P; Tue, 03 Nov 2026 02:49:45 -0500
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=AOurnPq22SXFhXs8JjDvH8hDa9b8THyQJKgJlD9kp/U=;
 b=FLVP5/6s/7DhC9nvrWbJ8jN+VeKnNUccnOonTxirtpeJFf7LaMudPXWTm4qiOCvYhwUthGB3a
 Q+VF0hok7l/DMR2oYz4GU1qybWKaRs/5aY5e2z+ICNGESqTqwGVXz+UnDYEV+jG8RvEvPq7tciw
 EER7MvSEqVR3pC/2HJnDh4w=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jJggf3SCKz1T4GB;
 Tue,  3 Nov 2026 15:49:02 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
 by mail.maildlp.com (Postfix) with ESMTPS id 9EA5540575;
 Tue,  3 Nov 2026 15:49:20 +0800 (CST)
Received: from [10.67.120.103] (10.67.120.103) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 3 Nov 2026 15:49:19 +0800
Message-ID: <a2ea6291-4412-4f3d-a5a8-ef680d2db49c@huawei.com>
Date: Tue, 3 Nov 2026 15:49:19 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/7] hw/arm/smmuv3: Live migration for accel=on
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, "jgg@ziepe.ca"
 <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>, Aniket Agashe
 <aniketa@nvidia.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, liuyonglong
 <liuyonglong@huawei.com>, "tangchengchang@huawei.com"
 <tangchengchang@huawei.com>
References: <20260904180513.248396-1-skolothumtho@nvidia.com>
 <67d6e789-6620-4204-9ae7-37991b1ec432@huawei.com>
 <SJ0PR12MB861485BE2DAE769A16B32A87AB6A2@SJ0PR12MB8614.namprd12.prod.outlook.com>
From: Tian Zheng <zhengtian10@huawei.com>
In-Reply-To: <SJ0PR12MB861485BE2DAE769A16B32A87AB6A2@SJ0PR12MB8614.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr100010.china.huawei.com (7.202.195.125)
Received-SPF: pass client-ip=113.46.200.216;
 envelope-from=zhengtian10@huawei.com; helo=canpmsgout01.his.huawei.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/3/2026 1:04 AM, Shameer Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Tian Zheng <zhengtian10@huawei.com>
>> Sent: 31 October 2026 13:38
>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: eric.auger@redhat.com; peter.maydell@linaro.org; Nicolin Chen
>> <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
>> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; jgg@ziepe.ca; Ankit
>> Agrawal <ankita@nvidia.com>; Aniket Agashe <aniketa@nvidia.com>;
>> wangzhou1@hisilicon.com; jiangkunkun@huawei.com; liuyonglong
>> <liuyonglong@huawei.com>; tangchengchang@huawei.com
>> Subject: Re: [RFC PATCH 0/7] hw/arm/smmuv3: Live migration for accel=on
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On 9/5/2026 2:05 AM, Shameer Kolothum wrote:
>>> Hi,
>>>
>>> This series adds live migration support for an accelerated SMMUv3
>>> (-device arm-smmuv3,accel=on) with vfio-pci endpoints on the iommufd
>>> backend.
>>>
>>> The destination replays rather than receives. The stream table, the STEs,
>>> the CDs and the Stage 1 page tables all live in guest RAM, so once that
>>> and the registers are restored, the destination walks the stream table
>>> again and rebuilds the vDEVICE and the nested HWPT for every device.
>>>
>>> What the series does:
>>>
>>>    - drains the kernel vEVENTQ into the guest event queue when the VM
>> stops,
>>>      so that pending fault events are not lost (1, 2)
>>>    - migrates the resolved SMMUv3 feature set in a new smmuv3/accel
>>>      subsection and fails the load if the two ends differ (3)
>>>    - replays the guest stream table on the destination and restores the
>>>      vEVENTQ and the GBPA HWPT (4, 5)
>>>    - asks VFIO for dirty tracking on the Stage 2 nesting parent (6)
>>>    - replaces the accel migration blocker with one scoped to CMDQV, which
>>>      cannot be migrated for now (7)
>>>
>>> This depends on the host kernel supporting dirty tracking on the Stage 2
>>> nesting parent, for assigned devices that cannot track dirty pages
>>> themselves. A branch based on Jason's iommu page table work is here [0].
>>>
>>> Big caveat:
>>>
>>> This is not yet tested with a real device that supports migration as I
>>> do not have a test setup for that. Folks who do have such a setup have
>>> reached out and are copied here, so hopefully this RFC lets them give
>>> it a spin and provide some early feedback.
>>>
>>> QEMU branch is here:
>>>
>>>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub
>> .com%2Fshamiali2008%2Fqemu-master%2Ftree%2Fsmmuv3-accel-live-
>> migrn-
>> rfcv1&data=05%7C02%7Cskolothumtho%40nvidia.com%7C1686c4874d5c4be
>> 3e7fe08df37543fa0%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C
>> 639290507158409428%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOn
>> RydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ
>> %3D%3D%7C0%7C%7C%7C&sdata=M30uWfAzPcqdeQifvQlNcaOmZzHQbalNJ
>> uNtB9DhDPQ%3D&reserved=0
>>>
>>> Please let me know your feedback.
>>>
>>> Thanks,
>>> Shameer
>>> [0]:
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub
>> .com%2Fshamiali2008%2Flinux%2Fcommits%2Fiommu_pt_arm64_s2_dbm%
>> 2F&data=05%7C02%7Cskolothumtho%40nvidia.com%7C1686c4874d5c4be3e
>> 7fe08df37543fa0%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C63
>> 9290507158463751%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRy
>> dWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3
>> D%3D%7C0%7C%7C%7C&sdata=HO9UHPTS%2FWKbQnGf8DKsDy6oGrFYvNB
>> uw%2BZ4uh3ZDJ8%3D&reserved=0
>>>
>>> Shameer Kolothum (7):
>>>     hw/arm/smmuv3-accel: Factor out the single vEVENT read
>>>     hw/arm/smmuv3-accel: Drain the vEVENTQ when the VM stops
>>>     hw/arm/smmuv3: Migrate the accelerator feature set
>>>     hw/arm/smmuv3-accel: Add a helper to replay all STEs
>>>     hw/arm/smmuv3-accel: Restore accelerator state on incoming migration
>>>     hw/arm/smmuv3-accel: Request dirty tracking on the nesting parent
>>>     hw/arm/smmuv3: Support migration with accel=on
>>>
>>>    hw/arm/smmuv3-accel.h       |   2 +
>>>    include/hw/arm/smmuv3.h     |   7 +-
>>>    hw/arm/smmuv3-accel-stubs.c |  17 ++++
>>>    hw/arm/smmuv3-accel.c       | 192
>> ++++++++++++++++++++++++++++++++++--
>>>    hw/arm/smmuv3.c             |   6 +-
>>>    5 files changed, 210 insertions(+), 14 deletions(-)
>>>
>>
>> Hi Shameer,
>>
>> Thanks for the series. I tested it on a KunPeng 920 with a HiSilicon ZIP
>> VF passed through via VFIO, using the non-SVA accel=on path.
>>
>> Environment:
>> - Intra-host migration only, cross-host migration not tested.
>> - QEMU: your smmuv3-accel-live-migrn-rfcv1 branch.
>> - Host kernel: your iommu_pt_arm64_s2_dbm branch, plus one local change
>>     in arm_smmu_get_httu() to fall back to the hardware IDR0 value when
>>     ACPI IORT reports HTTU as 0. No other kernel changes.
>> - Guest: openEuler 24.03
>>
>> QEMU config (source; destination differs only by BDF and -incoming):
>>     qemu-system-aarch64 -machine
>> virt,kernel_irqchip=on,gic-version=3,nvdimm=on \
>>       -accel kvm -net none \
>>       -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0,accel=on \
>>       -object iommufd,id=iommufd0 \
>>       -device pcie-root-port,id=rp0,bus=pcie.0 \
>>       -device
>> vfio-pci,host=0000:31:00.1,iommufd=iommufd0,bus=rp0,enable-
>> migration=on
>>
>> Two non-SVA workloads ran in the background during migration:
>>     # (a) sustained load:
>>     uadk_tool benchmark --alg gzip --mode nosva --opt 0 --sync --pktlen
>> 4096 --seconds 60 --thread 2 --multi 1
>>     # (b) integrity: compress during migration, decompress after, sha256
>> compare:
>>     kp_utools k_acc -a comp -n "compress-deflate" -s 1 -i big.bin -o
>> out.gz -P -l 60
>>     kp_utools k_acc -a comp -n "decompress-deflate" -s 1 -i out.gz -o
>> restored
>>
>> Results:
>>
>> === 1) IDR matching (normal) scenarios ===
>> - Patch 3: matching IDRs migrate successfully, including between two
>>     different SMMU instances.
>> - Patches 1/2/4/5/7: live migration under sustained non-SVA load
>>     completes; no SMMU event storm or event loss observed; STE replay and
>>     accel state restore work.
>> - Patch 6: S2 dirty-tracking integrity passed. The device kept doing
>>     DMA writes during migration, and the decompressed output matched the
>>     original input byte-for-byte (sha256 equal). This device has no self
>>     dirty tracking and relies on host-side S2 dirty tracking.
>> - Repeated/ping-pong migration on the same host also completed and the
>>     device worked afterwards.
>>
>> === 2) IDR mismatch (negative) scenario ===
>> - Patch 3: with mismatched IDR3 (source ril=off, destination default
>>     ril=on), the destination correctly rejects the load with
>>     "SMMUv3 IDR3 mismatch".
>>
>> No errors were observed in the guest or on the host.
>>
>> Tested-by: Tian Zheng <zhengtian10@huawei.com>
> 
> Hi Tian,
> 
> Thanks for testing and the detailed results. Good to see this working
> with a real device. I will refresh the series, addressing Eric's
> feedback as well.
> 
> Thanks,
> Shameer

Hi Shameer,

Thanks for the update. Glad the testing was useful. I'd be happy to
re-test the refreshed series once it's posted. Please keep me Cc'ed
and I'll report back.

Thanks,
Tian

