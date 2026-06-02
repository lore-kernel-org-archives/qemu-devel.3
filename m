Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2621CD6E55
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 01:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUE8F-0001Er-NJ; Mon, 01 Jun 2026 21:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wUE8C-0001Ej-Uh
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 21:41:25 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wUE8B-0001Kh-13
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 21:41:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0zN640qaUdvP6/ZoM2ekISFRrE7bnrNydVfXDB9Do3QSE37vtw/reLn6Xxc9TVAKILrnlmc1Z8uwY/da8P1AH+Lh+/FxywGr9Y213XbI/qan7h9GG99h+3SqnzPfPxM0lxr2qx7yYfEAcTCh3cYqgsqtkRS9JRjtE86CIh789JDQaVUxVR8mTPY5BoVEz4bTxT7Ah3Ed1ArC3LKtBrhFLBX349EcEHqvF+EIgBX9JQrCL26kn9/i0HDxjcArEEjQLSGCgAoD0UHsI6CZtV9FbXtxigzJeBIAnBfeXv4OTWOYWDGVs7mNYt55WoSpXWZECeMKd3KI/sP39+pcpmsrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnrmVclue5g4KsT1dcaLp7GhRxUMvfjW5qhTl0b6PzY=;
 b=tpgIruGR6yEi7G+GmA1oCgelfSNebeYiym7sZQzR58R2IbDF5xGei6D0mMW7uPpsxB1cvkaUYxxrkPE758Dq+wG3oNlVh13ZdC08ujNaUed9TfYpkKhigZ9XPOLqJRbK1i1REdxWD5lPrWkx2kpkSf24ESAUtJdDLAN5ACwqtP7XPKuol47K07LlP9bNraX1u1dr+0UNcOvOL+emOVHfW23x15TJM7E1IRgsdt4K1KNVaIx1vAKWgpziDZtMW59Oa9fcmIYhTrElJTg03BjSgl1nprZj7aPxXMjSOdF4lmB9w0DnQQa6YWLRgMgYyfDCpaR+Ncq58ZcBbcX0DDAjyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnrmVclue5g4KsT1dcaLp7GhRxUMvfjW5qhTl0b6PzY=;
 b=ln2AYRhNtKIA9usRhD7/o4/VeAsSHpPwXYQAS8i/O66sjgl8DR5jCQF5MF8mvCvaBMApMJeVBqa0JqE+8rRGkWOU8G3/npBnrAqTX3yuv66zK3nKz+WgM/4fSuwT6JCLIR3f5PV+ZRsw1d+D6oVKSX713gq9qulmD+gSkrd28Ak=
Received: from PH8PR22CA0015.namprd22.prod.outlook.com (2603:10b6:510:2d1::23)
 by CYYPR12MB8892.namprd12.prod.outlook.com (2603:10b6:930:be::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Tue, 2 Jun 2026
 01:41:15 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::87) by PH8PR22CA0015.outlook.office365.com
 (2603:10b6:510:2d1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 01:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 01:41:14 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 20:41:14 -0500
Date: Mon, 1 Jun 2026 20:29:30 -0500
From: Michael Roth <michael.roth@amd.com>
To: Peter Xu <peterx@redhat.com>
CC: <qemu-devel@nongnu.org>, Juraj Marcin <jmarcin@redhat.com>, "David
 Hildenbrand" <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Chenyi
 Qiang" <chenyi.qiang@intel.com>, Fabiano Rosas <farosas@suse.de>, "Alexey
 Kardashevskiy" <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 02/12] kvm: Detect guest-memfd flags supported
Message-ID: <zf5tkv5zvegsag6s6eb3wzaivrgm6aw5lzmmkpcetrgqhh46od@sxregfy6u7u5>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <20251215205203.1185099-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251215205203.1185099-3-peterx@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|CYYPR12MB8892:EE_
X-MS-Office365-Filtering-Correlation-Id: b7fb3189-21b5-4d4f-6d42-08dec048089d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: WCclDwYF1gX5P17qaQXaBNvdR80UogBWTeRVMyCLSJX4DOcl+oL7LI+FBuHERjUQYyfiraX6mqgDNprkDynQY0hgRzo1Dpq9SJTvd1UULAHp449dGKVOv7urJT6PniySidVLPbNiItTst4E+G86vg8ap13g6AzmVB5FpC6DvPT4qSMyqnn4CFfsAvKVYeyzKHtosYbPUBxGOTRM+/+kgqjSQUQHwxPurmfueBUfXJjcDPs+nOQXfm8lwMh8lzqR/KmiKYytttDvso0mty7N4PDT9rkFqLvr2m/9M+Y1i0qDpV8Rm5j8sVypVLvQw1i6FKdYRSEv6BD5we4v/EC7ZZF1I2F+YulPG75R9UHDenNdepn1Ww3sx7Rh0rKg+hcadh7223UZVR+dw82jQnRJpst24tJXXPVbJJgUfsYra1nODso4sezkP5J8eZ+9MyU6iibUYqj5jvhgZpLXrXgKlhUXM8KDqONBMPtos7g7lwHqNeTpS3i2u5nqZCuHijNe8jipFyksn3Cx/iknAW+0P6I+dKnpStQ8R1Q8Lj4QpTK7dW/0PrszPgmWRm9axjCtc53/CS6GNKPwbpGKHAZctvmJxBD3F1kEqoAQWZ6ZLAoFoLQb9rwoUg3J8gUewrUAyk08QTl7NZkVDR0jHlPSLlZnPQNthbgUKIhCbp6pLnTTeHSr/kyTA2Cw91dSAa9WDlV37Ve0FizfS69dj9y+Sf2/SK5DDHaWF8XOYkOi70eo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A9dZnMorCKzz3TVm2ftwO1QvryxvMrWyGFVCmVj5tyXq0eHbhHA72NdUpYH4hPJ14DGoa7OotijQnPhN0qcljALa0IbxXQ85USKw1P1Knyn+CcrVEgJaYzXEm8eS1m4SrQz3s+DCkQeTmGdwEUQkG5pahEGu4ZkUWeXdv+axAMQpVKsR+gcp7jtH5F/Jy5fWIjF/Z7LSDzCZ2F11CZg32ZzxqtvAeROK/NctPYy7s7jpeAlvnSXAX1TPrgEvFIizUIwkXzU5NOqQXHJKbTF0IYlp5YAAf50/q2Jrd+ONjo4nfw+8QVtsS0zA+PBU0YPRLtA0jBqfHjJfG/N3Nk5uECjsua9nF1Kxur/cj6KxTRtWJCx1CCCEH017Gh4+kw/Nh5ZZo4vHelf/IriOmDMC5BqxW3A4D/KR3YDS36NgrWO2DlTI4U7DzBa6c96v3JUu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 01:41:14.7247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fb3189-21b5-4d4f-6d42-08dec048089d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8892
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=Michael.Roth@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Dec 15, 2025 at 03:51:53PM -0500, Peter Xu wrote:
> Detect supported guest-memfd flags by the current kernel, and reject
> creations of guest-memfd using invalid flags.  When the cap isn't
> available, then no flag is supported.
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  accel/kvm/kvm-all.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 59836ebdff..68d57c1af0 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -108,6 +108,7 @@ static int kvm_sstep_flags;
>  static bool kvm_immediate_exit;
>  static uint64_t kvm_supported_memory_attributes;
>  static bool kvm_guest_memfd_supported;
> +static uint64_t kvm_guest_memfd_flags_supported;
>  static hwaddr kvm_max_slot_size = ~0;
>  
>  static const KVMCapabilityInfo kvm_required_capabilites[] = {
> @@ -2787,6 +2788,10 @@ static int kvm_init(AccelState *as, MachineState *ms)
>      kvm_guest_memfd_supported =
>          kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
>          kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
> +
> +    ret = kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD_FLAGS);
> +    kvm_guest_memfd_flags_supported = ret > 0 ? ret : 0;

kvm_vm_check_extension() zeroes out negative return values already so
should be able to use the same format as below.

But either way:

Reviewed-by: Michael Roth <michael.roth@amd.com>

> +
>      kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
>  
>      if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
> @@ -4492,6 +4497,13 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
>          return -1;
>      }
>  
> +    if (flags & ~kvm_guest_memfd_flags_supported) {
> +        error_setg(errp, "Current KVM instance does not support "
> +                   "guest-memfd flag: 0x%"PRIx64,
> +                   flags & ~kvm_guest_memfd_flags_supported);
> +        return -1;
> +    }
> +
>      fd = kvm_vm_ioctl(kvm_state, KVM_CREATE_GUEST_MEMFD, &guest_memfd);
>      if (fd < 0) {
>          error_setg_errno(errp, errno, "Error creating KVM guest_memfd");
> -- 
> 2.50.1
> 
> 

