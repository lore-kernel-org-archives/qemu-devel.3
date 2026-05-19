Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCFFCD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 04:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPBue-00061x-7F; Tue, 19 May 2026 00:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wPBuc-00061Z-Ms
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:18:34 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wPBua-0004K4-1b
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:18:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVEm1qnCxJcwFq7qfMYt45/zqlRS5jNJKcCeW4k5EH0ryDtARiU0tHkV0xt8yJne0kKTG36mmSh//reCDyMjcOsI8We8QGyBFaKB9tnJg+d0CVH8FE2IpSI/6gj7R+tPMgefMfB0aFM2nm/NHXzzGCX4u9NZlQx7s0vuHkl6xndDTjDY9f6ZWeQY99I5UOswRTYpylLfyffHf8Ymv795qzWHECIdRVfFqJ+VEhZLF6V4oGbbJhMJGZooH3UMOohzhgDGaCVJr93X65lf7JPy6uIvpx2Obb95mGg23sIBsgTgrRcDY1E3f8rMvFoQy0z8JxzR0gytNyPH89HuqX7lLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JH9pQODe58zzRy6VPLd0KwJEyHqkuGz5yRBdhgaXh0M=;
 b=RIvNtsaQGrPlrYsmHz/9x7Yp42UUtwaG2Det5F7iNxD8Gs1kXYjCbbjr4ad0AyZ/kiYeSIX2MI2Iaz3MK8o0hdkzkpJ8EgSvDiBvMZcYjOg00CcPzzSzpBmwg59kdwrwh5iAWabzyZasOBR+limaSdL9/H2OiV6f+S+OWjHjHRzdRTmLhdYyk87nC76HffxdKDsgRD958FffVh009coy346KWKrKJzyY2Bxotg54biWkftsJPmVNC1jfKz+m4yPNbqx4nPqy9p/jQfGfTdWHlYUzuoh34DpZv7pG8XJYMMSKEMe6mybiu0Z8V0n65ylWvOxxRVB6fihxlY+lpApKmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JH9pQODe58zzRy6VPLd0KwJEyHqkuGz5yRBdhgaXh0M=;
 b=EfNwxjTQqIAxt7qBFl0ghycYluArpW7a1cIPkzPA5zjS4OQeHSO4GSPq470A4AqraU6cW8QRMqbVAxI6+X3/NBGDVIQ+7pRdtoY/rpf0sRaexL9z4d71H+AwZfDqKbz3N7MCw3m7/289M3cpPrrmMb+mbi0Wf+e7qmmXj+SxicA=
Received: from CYXPR02CA0088.namprd02.prod.outlook.com (2603:10b6:930:ce::11)
 by SN7PR12MB7856.namprd12.prod.outlook.com (2603:10b6:806:340::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 04:18:24 +0000
Received: from DS2PEPF000061C1.namprd02.prod.outlook.com
 (2603:10b6:930:ce:cafe::b1) by CYXPR02CA0088.outlook.office365.com
 (2603:10b6:930:ce::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.25 via Frontend Transport; Tue, 19
 May 2026 04:18:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF000061C1.mail.protection.outlook.com (10.167.23.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 04:18:23 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 23:18:23 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 21:18:23 -0700
Received: from [10.65.99.141] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 18 May 2026 23:18:20 -0500
Message-ID: <ab7ad06f-1f46-4e5a-9ade-a45f12170eb3@amd.com>
Date: Tue, 19 May 2026 12:18:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
Subject: Re: [PATCH v7 1/1] numa: add 'memmap-type' option for memory type
 configuration
To: Igor Mammedov <imammedo@redhat.com>, gregory Price <gourry@gourry.net>,
 David Hildenbrand <david@kernel.org>, David Hildenbrand <david@redhat.com>
CC: <qemu-devel@nongnu.org>, <jonathan.cameron@huawei.com>,
 <apopple@nvidia.com>, <dan.j.williams@intel.com>, <Zhigang.Luo@amd.com>,
 <Lianjie.Shi@amd.com>
References: <20260306082735.1106690-1-FangSheng.Huang@amd.com>
 <20260306082735.1106690-2-FangSheng.Huang@amd.com>
 <20260514150559.3148f9dc@imammedo>
 <d26cfb4b-d70e-415c-8747-904d94f8ccb2@amd.com>
 <20260515150453.409e0e3e@imammedo>
 <4a3de73b-03bd-446e-8cbd-dedd5323e295@amd.com>
 <20260518163239.2fd73491@imammedo>
In-Reply-To: <20260518163239.2fd73491@imammedo>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C1:EE_|SN7PR12MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b821788-6a3a-41b9-eb22-08deb55daad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|4143699003|11063799003|22082099003|56012099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info: DhH01y8h+nvu5I/5V+n8rFCgYwT4Q+PCjYJ7F9E/z6oXl3C0dNUr+cb7CoEGNAflqKQK3qrptjK4izu7n2u+AAaWJTzTG7/oiunS98nxhQ67UhrRD652qAf0ZJ6X91vyN7lXMh4xqzDf4tyYmybcl7JVfcN+2KFsorJ3pgjvjvvPDO1cg4okZMW6HzHardi+3+DVQDsAfaWHYyBss0fyGpk+du8N52APozgG+uUnm4JFdfMhQt+vZAYvkrX8urN4LsNB122ZL6TEHaZVRvGIIYQjupDca4rwxtl1z8AtNMgI5FXWmLdTdm+xvMfUuQ41aU6VFFsR+1EG3y1C/DYoo6JbHcsuvmfuUd+t6/GWllCLT7z8/yHNmA+ulxmAJlgHMDyfImnDlJdXu6uvJIwil2luOtxJirwekKwMRIEYECjElZ05zSiK0gyPryh8IDnxC5jWJKy07tU8fjHEdblRgbx9RVisKqmczQRM/Xq5pNAjfVuwk4+VD0kxLW7W/J8g1Ce/L+AhALu99LNWZXHuXM8Rh5+Ju/0kswo7SpsuPonMZGMRcO8wbdQ2aMFo/K8BzsixW2O15CGLKj7QttJzIhYSPmxWQk1IIncyVtt6RNlRJhoqnUEOhnOjlsDRqunpvh4Y8dovIsmH/4pxWDRYGIkN3uHvDe3IbhAFeKRvPrD7EVZwYYsZrXx69p4jsSyNRt1PEQNucMtHb8O9Z9WOmg0OAYFF5iQLqMmf3pSjTjI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(4143699003)(11063799003)(22082099003)(56012099003)(18002099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9osrLhWwT/vWxWLwxsuyqYh4xXn+QJT+u5esxKMNJwJIYjNoNi3si+84Qq1kqR0H7mhg7H+ATmvMnlZjHHLjJoXNtjEusQbiZnWXspioJ/Ti0McH6A1xlgaXt11zDvOJumSoW6OA04cpcVHlE/VfpqsOXWwLtnJTsfhFOvP9NJA2EsZflMKG+uT5Hje02ecYB6ZWb+Ej6SiZrV/iqXq+YsOVMFYRtBABt+FcsXpmW+XLMZvIDwMhD9cAtD4OGnIfYqnqPU+17n/Mj85vQrqcXwfxO7oqozgjBeqbh0sLaKgIBX5l/qVzfrWJVPgAjZWmtoVBHV3lbyYySoLndEMCSLx0mltPqRZhmbrK+f2KouYpSUzmGk6wt753r3g/5opWS3cqPKG/DSoiD3PWedDBOUaaOCs5FSyBX0yaUBfw0BRtENASzBQlbhib4f1XN25W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 04:18:23.5147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b821788-6a3a-41b9-eb22-08deb55daad2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7856
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=FangSheng.Huang@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Igor,

Thanks for the concrete pointers in this round -- the machine_done /
ACPI-runtime timing notes are useful regardless of where this lands.
Replying inline.

On 5/18/2026 10:32 PM, Igor Mammedov wrote:
> On Mon, 18 May 2026 18:43:10 +0800
> "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com> wrote:
> 
>> Hi Igor,
>>
>> Thanks again for the careful read.
>>
>> On 5/15/2026 9:04 PM, Igor Mammedov wrote:
> 
> 
> Without magic/hardcodding, firmware is likely to discover HBM memory
> as CXL device and adds E820/SRAT entries for it. That ideally how it
> should be modeled in QEMU as well. (not ad-hoc -numa foo options)
> 
> I won't push towards the feature being part of GPU pass-through,
> or being HBM being a CXL device (which it probably should be).
> but read on ...
>
Understood, and thanks for not making those preconditions.  Setting
CXL and GPU-passthrough-bundle aside for this reply, the remaining
question is whether the SPM topology is expressed on the -numa node
line (v7) or on a separate -device line (your proposal).  I'll
address that below under the mixed-memory point.

> 
> It shouldn't be done at realize time.
> 
> Ultimately we publish E820 table at machine_done time,
> and it's right time to iterate over present memory devices
> and add relevant entries if necessary.
> SRAT is produced even later
> (effectively at runtime on 1st access to acpi tables blob),
> so it can pickup memory devices at that time as well.
>
Noted -- machine_done for E820 and ACPI-tables-runtime for SRAT is
the right hook set for a memory-device-based implementation; that's
where the iteration over present memory devices would land.
(v7 itself sets the E820 entries during pc machine-init, which is
the appropriate hook for the topology-driven -numa path -- there's
no per-device realize step whose results would need to be iterated
over.)

>> (4) On the longer-term direction
> 
> that's exactly what I'm concerned about
> 
> 
> If we merge v7 approach, we are bound to support it for years
> and if we later on we add device based variant, it will increase
> support burden even more and complicate configuration, which
> in turn will propagate up the stack.
> 
> Hence, I'd like possible options on the table explored 1st
> before we commit to a particular approach.
> 
> I wouldn't object much is it were a fix that we had to rush in,
> but this is not the case (are we in hurry to rush this in?).
>
This is where I'd like to push back, on three connected points: the
mixed-memory question that the v4 thread already converged on; the
relationship between v7 and a future spm-memory device; and the
review timeline.

(1) The mixed-memory question -- v4 thread carries directly over

In the v4 round, an -object/backend-property variant of this feature
was set aside after pushback from Gregory and David on a single
concern: allowing a single NUMA node to mix SPM and normal memory.
The current memmap-type=[normal,spm,reserved] form was Gregory's
suggestion in that same discussion, and v7 carries Acked-by from
David and Reviewed-by from Gregory.

A -device spm-memory model reopens that question.  A memory device
is plugged into a target NUMA node via its node= parameter; unless
additional constraints are added, that node can also have normal
memory attached via -numa node,memdev=.  Adding a runtime check
that errors out on mixed-node configurations is possible, but it
changes the failure mode from "read your command line and see which
node is SPM" to "assemble a command line that looks fine, hit a
realize-time error, edit, retry."  For users composing multi-node
topologies on the CLI (or via libvirt-generated cmdlines), that's a
meaningful UX regression.

The whole-node typing in v7 expresses the SPM-vs-normal property
declaratively, on the same -numa line that already carries the
node's other attributes -- which is the form the v4 review
converged on, precisely to keep this kind of constraint visible at
the configuration layer rather than at realize time.

(Gregory, David: this is exactly the regression you raised in v4
that pushed the series away from -object form.  Would value your
read on whether a -device spm-memory variant raises it again, and
what an acceptable resolution would look like in that form.)

(2) v7 and a future spm-memory device aren't mutually exclusive

I don't see anything in v7 that conflicts with the device-based
direction you sketched.  v7 establishes the user-visible semantic
(whole-node SPM, with E820 SOFT_RESERVED + SRAT memory-affinity
emission) and the firmware-side compatibility (OVMF already
upstream, SeaBIOS in flight).  A future spm-memory device built on
memory-device infrastructure can target the same E820 + SRAT
emission and either co-exist with v7 (different idioms for the same
underlying semantic) or, if and when it proves out, subsume v7 via
the standard QEMU deprecation flow.

Three observations on the "merging v7 means committing to support
burden for years" framing:

(A) On your own framing, the existing -numa node,memdev= interface
     for attaching memory to NUMA nodes is itself on a long
     deprecation arc toward memory-device.  v7's memmap-type= is a
     sibling attribute on the same -numa node configuration, sharing
     the same lifetime envelope; it doesn't create a new long-term
     contract beyond what -numa node,memdev= already commits us to.

(B) v7 is the interim shape that a future spm-memory device can
     subsume.  If the device-based variant lands later and proves
     out, v7's memmap-type=spm can be marked deprecated under the
     standard two-cycle policy and removed.  That's the same path
     we'd take for any of the -numa node,memdev= family.  Treating
     v7 as a permanent commitment overstates the contract.

(C) The marginal code surface of v7 is small: a single new -numa
     node attribute that routes into the existing E820 plumbing in
     machine-init.  The marginal maintenance cost is bounded by
     that surface.  Compare against the cost of holding the in-tree
     use case while a memory-device-based prototype is designed,
     implemented, reviewed and stabilised.

(3) The review timeline

I want to be transparent about this rather than leave it implied.
This series has been in upstream review for roughly 1.5 years.  The
v5, v6 and v7 cycles went through with Acked-by from David and
Reviewed-by from Gregory; your previous engagement on this thread
was on the v4 round in January.  v7 was posted with the QEMU 11.1
window in mind, and the soft freeze is 7 July.

I'm raising this not to dismiss the technical questions you've put
on the table -- those are worth a separate RFC and I'd be glad to
take part -- but because gating v7 on prototyping a memory-device-
based variant first effectively pushes this past 11.1, and the
production deployment timeline that this series enables doesn't
accommodate that.  If the in-tree review on v7 itself had surfaced
this direction earlier, we'd be in a different place; at this point
in the cycle, the cleanest path is to land v7 as it stands (with
the tags it already carries) and pursue the device-based variant as
its own RFC.

> My hunch is that memory device based approach will end-up with
> more straightforward and cleaner code, not to mention proper
> backend/frontend modeling.
> 
> (also related to long term: ideally existing -numa 'some memory' interface,
> should go away and be replaced by memory devices.
> Adding more similar '-numa' options, doesn't help that case and only
> increases out technical debt).
> 
>
On the cleaner-code hunch -- agreed in principle for a green-field
design.  On the -numa-should-go-away point -- agreed as a long-term
direction; that's exactly why v7 sits within the existing -numa
node,memdev= lifetime envelope rather than committing us to a new
one (point 2A above).

I'd be glad to take part in the spm-memory RFC and in the wider
migration of the -numa node,memdev= interface family to
memory-device that you sketched.  Realistically, there are
architecture-level questions still open on our side that pace what
we can take on -- and landing v7 in 11.1 helps here by giving us a
stable in-tree baseline to iterate forward from.

My ask on this thread is: that v7 lands for 11.1 on the tags it
already carries, and that the device-based direction proceeds as
separate, parallel work.

Best regards,
FangSheng Huang (Jerry)


