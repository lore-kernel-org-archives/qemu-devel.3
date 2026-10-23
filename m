Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F059606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 05:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rckNN2Nr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK7jG-0000D7-JX; Fri, 23 Oct 2026 01:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deepagupta@nvidia.com>)
 id 1xK7jA-0000CP-Hi; Fri, 23 Oct 2026 01:22:04 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deepagupta@nvidia.com>)
 id 1xK7j8-0006mf-OI; Fri, 23 Oct 2026 01:22:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTTN09p3FA2WEWcLLTFMsibyNWWgKOE5WwkL1kCRZjEszbLcicginfBEFf22xlLjPLPfBBimBrcTMv5GpclmM654aBGOcc6/CloLEXlcaOwP+mGxfpRukCRE8Tbrq05yP700LhQ2VwLcyxwbqfYQ1A4lBEsxiUBewpiH9cN5QJoSe4ADOnvhbvhbrKjFEUCV9Fvc+b8efBP3uZIiZ74jmBAq8Mfz4MWUZMuEQAGd1oQcwVYj/d9Y1nGXWqqeaqLQI0pDlb40Fbkizf4v9RsmpGG+jzT87njeNS7UafKM6RgsUnb/Q7Vx06Km0H/yplTmgyEm75kKAdfqM58YSYV1bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWCfpYLzhREXeC9OdmX0btqsHq3IdtEUOlZM7rwoHIs=;
 b=bA74RLO5plrQkFntqKwyfGJs0z6q3nIWL1DdrhVpnb+4lpt+LQdE4vvcvn9gM0lNUNVtediimldL2hVeImWrs748vs6MdKBR0zM1sMjQ2xe3MYGwKJeorXTPsE5u4QCHBI/f52/gMaY1YHFGAyuY4l0AWvrzirHTz9Kn/SxctOVugNLC3EYxtcSZiA/PyugcY8SPfLL6J8Fp+XGx8jTm1TDu2UAH1j3dR31fyQurVANoDcxLzKvsVlXEKZyKXYFhwN+3gGTc053KhAqtvXmJNVgus6xG/sdaQGM3oV8bBsa3wjJVSy4UguNWILZPjOMeYhQbeyYIb1OutR5lF8AXww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWCfpYLzhREXeC9OdmX0btqsHq3IdtEUOlZM7rwoHIs=;
 b=rckNN2NrfQpH+D76A4psj0V4pbWX+d8GYSoOzULdONIFYDU8bWSF2MYDMhBf4QsYMaUI+Pt5gImZnlqL6y6jStjKFKwBw6n2VW31d+CVJncQXWwrzP8+xp9kPU66gutZGmW8nfNajWx/L2w29RK1Fxr5e5NDa4FLt+BB04BFlaDUNkautMSCaA3JmQKpl+kZ2NELTuAzmBKDfP1qIQ2OUIEA+WZIhH+1w+RmWwygsWmEUNZk5yLf2/vMRgGbgfgUqVSGlTOjZXIITrhx+VvrIRA5X04elK0G6b91hlegq1n8rOelkaSyZvhsdNSXIQ8xhYAeBNrCqWF9koI0/2gC1A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH0PR12MB5201.namprd12.prod.outlook.com (2603:10b6:610:b8::21)
 by SAVPR12MB999168.namprd12.prod.outlook.com (2603:10b6:806:4e6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 05:21:57 +0000
Received: from CH0PR12MB5201.namprd12.prod.outlook.com
 ([fe80::fa53:495c:c3d5:243]) by CH0PR12MB5201.namprd12.prod.outlook.com
 ([fe80::fa53:495c:c3d5:243%6]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 05:21:56 +0000
From: Deepak Gupta <deepagupta@nvidia.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, pbonzini@redhat.com, mchehab+huawei@kernel.org,
 jiaqiyan@google.com, oliver.upton@linux.dev
Subject: [PATCH v2 0/1] target/arm/kvm: handle KVM_EXIT_ARM_SEA
Date: Fri, 23 Oct 2026 05:21:47 +0000
Message-ID: <cover.1792728982.git.deepagupta@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1792191544.git.deepagupta@nvidia.com>
References: <cover.1792191544.git.deepagupta@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0191.namprd05.prod.outlook.com
 (2603:10b6:a03:330::16) To CH0PR12MB5201.namprd12.prod.outlook.com
 (2603:10b6:610:b8::21)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5201:EE_|SAVPR12MB999168:EE_
X-MS-Office365-Filtering-Correlation-Id: 0390808d-f402-4824-1f01-08df30c58e71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261021123027099003|261022105027099003|261009223027099003|56012099006|260925021311599003|260925021911599003|11063799006|260925022911599003|10067099003|18002099003|6133799003|261021121427099003|261021135927099003|22082099003;
X-Microsoft-Antispam-Message-Info: iNXkkWibymIoBPs0RR93J9Wx66NZaQtUa1rAPxLy8Z/1hz+a4HKvFgWzrx7YhbLuJkOi3xZXlWV2oJvAtrtqZtPy/Ii6TZ9BmuDE2esqfhAh3COeNjdVMWlVTVAwsTHghBclQUfpxL/nEm+pDNXAL4/qaFaI1KBRqL9uexy3icGfGqbbdRUYJ+PeMMxoAuAhhh//FNDTjrWGHX5nv+bRkARCFhLZhAyMKBYkabQwXfu5YGBOJnRaPz/78zmJJ9s8dglyQf96PPXuEAO6KzlzDDQhN8+ugcJc4q1uI+2UaSWn6Akd1OgD0mBP5nrN3jtbnvAO7bGjbmimLMDJQ4QIWZFofrzqn8BlaVUMccVeB/RYXXv+Y11rgkS9ryxfKgK0XPdPnzZMJccYdGgYoxIGlOAqEs1HUx9FFsNx5AFdKsKMlHpG4lKSIYWti3u3YyuTPFgOdiLuHXyJhuNI8VdmQzYr0tubxHiGdJVe+tVeTCXYD/1rjULkuUQVx8sB0fCCNO+VhknpfGSo8L4KYtlAzjxDBuGcnj6Q0vsgiD4BF55ZCFcYXF3M34/XRYeBzlEIiXIVovhZXI8BJPgzfur3EIONuws+Pbt2fTzeKQpV96JHS0a4ik3DKoUL7v4VcPVi81H5cu1R+7pgAxGdBqQ+jEiUHC1ND9o3uo/MyObsh+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261021123027099003)(261022105027099003)(261009223027099003)(56012099006)(260925021311599003)(260925021911599003)(11063799006)(260925022911599003)(10067099003)(18002099003)(6133799003)(261021121427099003)(261021135927099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j4adQZsFSG77gCTgt285HKHDZp4R9qcx0XMiiGr3T7tpCv4XXQB27ykfCG/p?=
 =?us-ascii?Q?V2OUM1tKp9ZP2xePKSpHCSKtobzhrhpNSR7HJc8VaNwIqL//LNvFcBVHPk+4?=
 =?us-ascii?Q?0vCdYkgl3nQLe3pumBzzBXYFY1sFL1Dl2AJb02yFNAyo8Hb3yjoGxLE/G7mu?=
 =?us-ascii?Q?T+El7EJR0aZt3qQCHPRphTBGLsH8gitGzUHQFLVfC+1EZUfme0AGG15Raap9?=
 =?us-ascii?Q?h05GPw4CLffQF+/9FAcDFSf6rSsAvJ/eTuXnq8PCwc30R5OXPBjCwcSHLNlq?=
 =?us-ascii?Q?GBcyt5/Du446+HZ7lYWRribv/5gcYQd6SJoxmYnykHmFNUHKneB1KqrF90RB?=
 =?us-ascii?Q?AeOTwkA2fdf7uebfwb07zaxdJkemqPep9xlq2wHvBrRWIODAvDpVk+0P/GQm?=
 =?us-ascii?Q?fkMtNJ617x4lD5PtfSTo4sWKtpizgMikT/xqqbgT2IMAUkczKlDfPMlY4A0Z?=
 =?us-ascii?Q?brWNfEXBWDScAkiR8qw/p6Gqh/zIEw/4eQB+jss+zAR6jJ45HYo6yOPopRZ3?=
 =?us-ascii?Q?XdcxScbGl7zz1/3A1ghKGeI8qBdY1BSmXTLa9kpu/IMXjAm7u11dIbddoMac?=
 =?us-ascii?Q?0VZzlGosxpA8X9cUb1FPxEvbQt5WutDy6aJoSwi51cjZhd1oRN2M8GQZ16PK?=
 =?us-ascii?Q?exCWvjGwpHctRCk9Z9H3Dmx8VTt5D2r63uI9girGh4yrGXFV8CvBH2pgo70E?=
 =?us-ascii?Q?FukEeeWhm/qKgyjb1hgIOfsOBSjc01TMrt/eT/ev0opPNQxeMkuv7qsjlGNj?=
 =?us-ascii?Q?W8FuWKpThP0fu4S3XMwURxC1vEiP1IczF4sgfAEiopjvcyY6KE7W2+6tP7b7?=
 =?us-ascii?Q?gyo8Qui7UJP7zvGCA/AXFFvcZq23QtsKduITdQE5C9gvhSXGcRquCotGsmeg?=
 =?us-ascii?Q?C0Zg38B9rguZmvD7mwzjmAbJKpAYzVKHzm6SaYMWWtWS8SpR2Ge+e7tLu5b3?=
 =?us-ascii?Q?hN4dbPQTZ4JoNDvXRm1CPhmmdfFxQhLnxVacrGH+gRYDhDHJec/6resfu+B1?=
 =?us-ascii?Q?/63W1QyBM9zR5yOBkBudd1+n0lfuN5mnrr27fOgnV2gLsl2KK2ELM8EjXftq?=
 =?us-ascii?Q?qPs/wfFQI5IGrzXdDPnWIA3kU/Mim8Jcq0vRLNSNpu1PoSm7a8gxuol9nwQ3?=
 =?us-ascii?Q?MAt52ulp8ivxbK/1MyhGQEVhXcYViYymumqTSFJPkOEbHChZ29mZQJBBZRNL?=
 =?us-ascii?Q?2IQ4G/Nu6QI5qF6QUSq3X2whkL2v/CVDF7c/JjM4UhDFJoK/KDXmnygPrFjH?=
 =?us-ascii?Q?8BCySl06qB0ntz66Ewk7q4wtYVThNRE5Xj53ewf6tJH8oez+wb7j+aif/VIn?=
 =?us-ascii?Q?q3+lL71BpMhv/S/q6wsf1cf3uJclzdL2RuvBIqbMlhdFzwRkDOstRVGKGfxO?=
 =?us-ascii?Q?NI7NgbLEND2oISmpuY5rozyvJVr51LKGNwZyiTSb1ws2bGmXHLGIwsQGq752?=
 =?us-ascii?Q?U3OuEtaIO1jni7dj9jeQzGGBag/nZ4r/DHtwuygGOM1S8/c9U14FE7nLijNP?=
 =?us-ascii?Q?N9IR+ZcEo2tLG8Wy/Vj++3/PgCxVS0eTzH16qnYPJxxJOqjd9QOR6LGNRaG0?=
 =?us-ascii?Q?Ojcl4m9sNDXkn6ppTlMBKT0WcKPuxnOiCnXF8WYay8Gdm/9AzuPrwGZkOVqu?=
 =?us-ascii?Q?josjWNTnTMKwY6bF7cJkaV/3Oc6qtjjtUVK1CNFWXJpXixUkP45vy+5OG9Q/?=
 =?us-ascii?Q?mhpPuWKOzcHdU0mItc0rHQ2BmgNXw1NDXe/56esMTn/OfS193IarAc2yMKLO?=
 =?us-ascii?Q?Jp8RLHm99g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0390808d-f402-4824-1f01-08df30c58e71
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 05:21:56.7648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9/zFMwqWIcoymjSP0BlrL7tso8YHqIVQUWtTOg6Q6t/qO2f82gGF9YzILOwJuX+D3QNjPTYJJ6qn3aYud4qHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999168
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=deepagupta@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Linux 6.19 added KVM_CAP_ARM_SEA_TO_USER [1]: with the capability
enabled, KVM returns a guest synchronous external abort that the host
could not claim through APEI to userspace as KVM_EXIT_ARM_SEA, instead
of injecting a virtual SError. QEMU does not consume the exit yet, so on
a host whose HEST has no SEA-notified GHES source every guest-consumed
memory error still ends in a guest "Asynchronous SError Interrupt"
panic.

This patch enables the capability, handles the exit by recording a GHES
memory error (when the exit carries an address backed by guest RAM) and
injecting a synchronous external abort that mirrors the original one,
and wires up the BUS_MCEERR_AO SIGBUS case so the guest learns about the
poisoned page asynchronously when the exit itself carried no address.

Changes in v2 (review feedback received internally):
 * Do not enable the capability for VMs that expose EL2 (nested
   virtualization): the injection always targets EL1, which is wrong
   for a guest at EL2 or with HCR_EL2.TGE set. Such VMs keep KVM's
   SError. The enable moved from kvm_arch_init() to
   kvm_arch_init_vcpu(), where has_el2 is known; the cap is per VM and
   enabling it repeatedly is harmless.
 * The GED-notified GHES source exists for virt machine versions after
   10.1, not 10.0 (hw_compat_10_1 clears x-has-hest-addr). Comment and
   commit message corrected, virt-10.1 added to the tests.
 * Document that BUS_MCEERR_AO delivery is best effort: a record is
   dropped with a warning while the guest has not acknowledged the
   previous one.
 * Clarify the kvm_inject_arm_sea() comment on the EC variant choice.

Testing: arm64 host whose HEST has only GSIV/SDEI-notified sources,
EINJ uncorrectable memory error into a page mapped by a guest, consumed
by a guest process (-machine virt,ras=on). Before: guest panic. After:
SIGBUS to the process, GHES record and hwpoison in the guest, guest
stays up. Also checked: the pre-existing BUS_MCEERR_AR SIGBUS path still
works (it is taken when the host's memory_failure() wins the race),
ras=off (bare external abort to the guest, no record), -machine
virt-10.1 (the AR path still delivers the synchronous record, the AO
record is dropped with the warning), check-unit on the host. The EL2
skip is compile-tested only: the test host has no KVM nested support.

[1] https://lore.kernel.org/r/20251013185903.1372553-1-jiaqiyan@google.com

v1: https://lore.kernel.org/qemu-devel/cover.1792191544.git.deepagupta@nvidia.com/

Deepak Gupta (1):
  target/arm/kvm: handle KVM_EXIT_ARM_SEA and report BUS_MCEERR_AO

 target/arm/kvm.c        | 176 +++++++++++++++++++++++++++++++++++-----
 target/arm/trace-events |   1 +
 2 files changed, 158 insertions(+), 19 deletions(-)

-- 
2.53.0


