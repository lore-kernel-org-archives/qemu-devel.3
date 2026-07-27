Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0606BC531FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 06:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woEks-0002Lg-I3; Mon, 27 Jul 2026 02:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woEkr-0002LF-0Y; Mon, 27 Jul 2026 02:24:01 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woEkl-0007pF-VK; Mon, 27 Jul 2026 02:24:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7wFWY9GFcF5EJ5pOY2IFH/xCmSM2lVs8o+8R7PRBx+D5YqpgsWVms/Y2vmrGDbA4r6rgV5VcLna67s4DAULyk0R1Hw9qmW0R/fjyBrR9KbU8i7WNKqoZ0oF9ALydmxivhrBoCNs5cZsmfQ8/4pjQUZtg0KcvR8PJrSOobeZzfnXZ8j36MjJHEOh+bwNaJXmNLZIYQn/sV1o7yTH5SX1otD2+2JrdHxbGuOTD/qe6GHUhcVBrZAQ5EGVvHMJynWoO/DaQ2+XKkAJabygXIsJHovVCGKf0kHv0NQoDsjKXIHX9hJHprSU8pq5AV8vsTUtGJCDDcMZtHaWZngSCnzsDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAePPg3exTqsxFDa08PJMLemjRtbLsbYo7AwhhsyNcU=;
 b=I3LEvVxBByy8ceKnw1K663nBc7ZXlGIN/3Sxr9rp4tK0n5Tj7mgqinGIb94JWG3CMgMEBhE6rxYCystStGeCH6oPNSTiteCJzjVftT6/paomItdzU4TCr/FPK8dieRY4+C9s8H0L5jpG+6J3jDgp8G6zF0VwV89/DNQPKsKWF9621B+6RyyZX9ZYgPI2nsozaUTglK5wDnohAqJrguRlQf2a45x7J9Sf8NUqPylLmLdBEpTu9zIaTOHTXSikxXFM63y+MXx3TDZ8guYQZ+a6t3yXex3ySqL5AXU0mioz2rzg+dJ7uZB8oGtMp8w4bwgAvXdTP4PdQRKRBzk+vIJN2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAePPg3exTqsxFDa08PJMLemjRtbLsbYo7AwhhsyNcU=;
 b=t/ovlX2zsP9R4Fdx4VHqQR5zRIg2IXlckJIee91HQYnYqFoMDXGhNHpO2kpY8WyR5eD3onYTUK41YxwgaBJA/muXQHU7fF/NzNA7iQWcJ7iTP8RS0mxaT79vW9xuZb+Xqj+8DN5JMlqZD9dW9LoymiLrWTHYJufiEC3LYJJnXTWT2WUAtsg4hpbgK6W6nQOdk6JH6fUnx1SAAxs2/4GwuadE7jZjZFr5bBMbiXtIET99ShtHPPCPqL9fJspvSBo2ox1TFuMqKVDNmKAgf8VMSQ+LwiRct8eGlCiokySOOGb8F3PRHZppvb6giHhByKrrpXzW4dmwbqaj3ZYkuilNdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TY0PR02MB5624.apcprd02.prod.outlook.com (2603:1096:400:1b0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 06:23:50 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 06:23:50 +0000
Date: Mon, 27 Jul 2026 14:23:44 +0800
From: Chao Liu <chao.liu@processmission.com>
To: flavien.solt97@gmail.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 3/3] tests/qtest: add RISC-V IOMMU MRIF notice tests
Message-ID: <amb5WWDBFlauiAd9@ChaodeMacBook-Pro.local>
References: <CANVUYGtOgMnNRkfU=zs=jvtg7yKOHXZVb8k5oVnp+D2=U4xeWA@mail.gmail.com>
 <CANVUYGs1Poa1i53Xwg=Us=UJejDbCmch2jGGmYw_Z0dE=Q-Utg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANVUYGs1Poa1i53Xwg=Us=UJejDbCmch2jGGmYw_Z0dE=Q-Utg@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::27) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TY0PR02MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ae89819-3cf6-489f-4a3c-08deeba79f88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|376014|7416014|366016|23010399003|1800799024|6133799003|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JqUPAu1xxNezQFDcl4o4Wtv67uxltL7md7hQ1XvMkeLLMQXRnQZHmzql01GSdSwNLu7V+Uuj2EKb/ZPofrKiS+Hlf4H8vwY/3mDWdMsoseXjj4nL3FgjXFx8UaxL0I1g5i8qnw6VnH9ZZ5LXUb46OTx9yrerPS1/RrCUxJga6h/KQnT9QKWHtDRRRUmaARf8N0TtjS6b31g5nnMLVY3I3pniziWThxAJV4vkUinIj9Q3RFO0Hsyedz0HTjaUk2FmaYNo3m3PwGgs9KTGwNwV7VeWFdlxA5ctlbkoPHHuhkS2z8gOno6Jk8CNa0jXU0+81I0E0mZW5NICGmy4vFcxysr+eNicWLmkm3VLZkiNjxqaXDij2L62/ut0ZTCm63idb0W+VYu7/Rz6IYSSP15Fo6haIIT4vn2gJwf5jD83QV139WsDuJAbpqAwyZcPYaxQfSUXLWILNPTmh6B39QtXYgiGdoFvN9Fg62qKZJojRcDjysu1Euc+C2IS34QmQaaY0k1DprjhlgkaENXzshg8eiWj8IdEkCpYD+0R9Rm8/7q4ARelkfGf5YfukYm1WHu0owfupdMafwxmHRpfGEbakEOnTd2CkAptfHQMCl8DYL4tPEcYMd7pR8jRlSSJ1DixHMRhxCdrP5ehXqeotJqo7uPhvBwgTMprtn3lWUJfp0E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(376014)(7416014)(366016)(23010399003)(1800799024)(6133799003)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LnqV1sfwyJ2DsovsqqeQBJZ/RekMR7WjsjuRovvtJdlZ2zPspf8GxYZ+n/s1?=
 =?us-ascii?Q?mUPUnG1MC1xXoJFw0O8NhLVy7r3N9qIIBI/PDviBSeY3bUVfqAvDTbpSjKKQ?=
 =?us-ascii?Q?3N8Wc0qi3Oyt9GbapSaKvEi3d7O6uUiat5oFkI6j3YBv9BQFV5fzImQh/LHY?=
 =?us-ascii?Q?U8GTHLejc49OGotteIs7gaRf5C/YNifTTVWcEl3Dw8Ngesf8LL+cfq8yAKHf?=
 =?us-ascii?Q?Pp26utP9OPlglY4dGXV6GZYRO1CDVX66X0GzY0vW220Abmh6o8q9HxW943DG?=
 =?us-ascii?Q?rIV4NAZKVqpy2OBOBF0qm4PQbbCVd/ATunXpFetyLAvNeojBOvkLuxCUnd27?=
 =?us-ascii?Q?6MrCyaKGNNsLUUB2KR2yts5xL/gQOfvou9O9JSD0i6vqXuaBGV2h1AECmg1s?=
 =?us-ascii?Q?6Nqwj0bqRaWdkt9rU1iz5zEEOhBzmwjYTbGfpQY5YS8Qa7HCTxkl0gjZhKS2?=
 =?us-ascii?Q?erjn5GS7b4RpesqqPMzcSB8kkhLRAt4eoq1pFoPIy9wrQyrW0GuN5+m/Vseb?=
 =?us-ascii?Q?JIcTI4B3BItWdY+6SlBWscUFy3tE7rOeTOCkWBp0VWEDAo0M14d3VuP3eaUD?=
 =?us-ascii?Q?2iCJ+8+Fw+pohaaBeJU1WVItNEf7siGIOJqR3hJyiZ+z7q4P/cKt2lM3c0Bq?=
 =?us-ascii?Q?W81Kk6dW2gK7Fi7z+N073w6okyFz7JJg+5YY+1sETxNYK1kQQ//rRBa42gH8?=
 =?us-ascii?Q?ol4VG9qfsUvQup+jakmIVSxAIa3BXrgvUzATKXGkuDrdMcCqv1e/crFxZpQH?=
 =?us-ascii?Q?VT4Rgr4VSQeQVodnC4UD8PFkOwl1rGBb4CSEQ9PH6MWmZuwRGzZr0IyvphL+?=
 =?us-ascii?Q?LvMQdaHPlkIdF13wbvXofEmspOpuS50NXTBjLe62IYwHTJQafdM61fc5ZJD3?=
 =?us-ascii?Q?bV0mXFW2YSWr5BvYE8PP8WzDAxPnwSDe9rrubWvnhN59iXSpPiqSum002hyr?=
 =?us-ascii?Q?3TXVxw/XUarIKIND5TRXFx4a+nLK0S19KxjPd8Wryp/B5YZMWyrBVBQmYArS?=
 =?us-ascii?Q?nPjwstjeN7gJBvqsZc98ddgWTT7lrRF9NzTQYOkl/xtdEVSZxYIXssT2eECx?=
 =?us-ascii?Q?/kQy7IXGN91m/RLTog2FYTDQwZuyl0rLFVxFPVsZqU/IGm48uyK3+TaKFsdM?=
 =?us-ascii?Q?L6Y5FkwXkEDAUUjUaFrupRk0DC9SCasam0FxImTMigowd7Xo/5ghn3sLv61j?=
 =?us-ascii?Q?EaL9fFJW+iqE45yyUWk2H5PER7h5bsM0UOhHwJPxvS3KwNaNhCZkdHgs97ad?=
 =?us-ascii?Q?4edMCm3rlRrcBLzrDOpruwYd07aPLtfeSozN7f5NJlJHpSICSZBDLnSXzvH6?=
 =?us-ascii?Q?w+WqKtym5h3kKjMRqVWS4Q4/5WLDhW2wT4To7Hm+hOgc/L9jIbcgjp5j25Ah?=
 =?us-ascii?Q?6jslWWw6lzAmUIv5JYR1afR3Py5b5UmCgLM/zOq3XHoLIqn7PW1lcO+tqC3q?=
 =?us-ascii?Q?19TgeIdMxGFT9zTo2uuS5OFcSWxqoMMtNoAxdrVQRhvWczi2vRrnX+Ogheeh?=
 =?us-ascii?Q?l7PSX4Ga9iNTBA7fEsgMWRMzzw7lJJ8ikHffgytIJLx0b8IiE+x2SKIzDErq?=
 =?us-ascii?Q?KOwdNOVkW1tlrJf2w9I4FDgk6H0wqI+BApzaqhMIgcnmA35f4TMOx3nyKoo7?=
 =?us-ascii?Q?EMjxixamsaM5ZBOgzkS1RXHulxjOooTJj+pm4twnt4GJz8LM1bsXSzvRH40r?=
 =?us-ascii?Q?5JBk/kNuXSwdGXq1842KzXyDPnr/T5Efnyw6ySoMM06mF4Pm4/Et7tiTtfds?=
 =?us-ascii?Q?xGC4RCG4H3fYgzIrva4nZOqa/l9V0fw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae89819-3cf6-489f-4a3c-08deeba79f88
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 06:23:50.3375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtWL+ZjlK/pFr1/ssGPzMDKuZso/Bw73XpqRivL7FQLydj29CwxCmfwH8+awm+PeME2j9M8/8yzcWqCo5gHDw1PRiol3+JfYUD2xXmStg3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB5624
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=chao.liu@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Jul 26, 2026 at 05:22:00AM +0800, flavien.solt97@gmail.com wrote:
> Exercise MRIF-mode MSI writes through iommu-testdev with the destination
> interrupt-enable bit both clear and set. Each case requires the pending
> bit to be stored plus the configured notice ID to reach guest memory.
> 
> The enable-clear case regresses the notice suppression fixed by the
> previous patch. The enable-set case provides a control for the existing
> path.
> 
> Signed-off-by: Flavien Solt <flavien.solt97@gmail.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

>
> ---
>  tests/qtest/iommu-riscv-test.c | 102 +++++++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)
> 
> diff --git a/tests/qtest/iommu-riscv-test.c b/tests/qtest/iommu-riscv-test.c
> index 2638024..85f79ea 100644
> --- a/tests/qtest/iommu-riscv-test.c
> +++ b/tests/qtest/iommu-riscv-test.c
> @@ -14,6 +14,7 @@
>  #include "hw/pci/pci_regs.h"
>  #include "hw/misc/iommu-testdev.h"
>  #include "hw/riscv/riscv-iommu-bits.h"
> +#include "libqos/qos-iommu-testdev.h"
>  #include "libqos/qos-riscv-iommu.h"
>  #include "libqos/riscv-iommu.h"
> 
> @@ -26,6 +27,13 @@
>  #define RISCV_BUS_MMIO_LIMIT       0x80000000
>  #define RISCV_ECAM_ALLOC_PTR       0x30000000
> 
> +#define RISCV_MRIF_MSI_IOVA        0x00000000fee00000ull
> +#define RISCV_MRIF_MSI_PT_GPA      (QRIOMMU_SPACE_OFFS + 0x00030000ull)
> +#define RISCV_MRIF_BASE_GPA        (QRIOMMU_SPACE_OFFS + 0x00031000ull)
> +#define RISCV_MRIF_NOTICE_GPA      (QRIOMMU_SPACE_OFFS + 0x00032000ull)
> +#define RISCV_MRIF_INTID           5u
> +#define RISCV_MRIF_NOTICE_ID       0x12du
> +
>  typedef struct RiscvIommuTestState {
>      QTestState *qts;
>      QGenericPCIBus gbus;
> @@ -264,6 +272,96 @@ static void test_riscv_iommu_nested(void)
>      run_riscv_iommu_translation(&cfg);
>  }
> 
> +static void riscv_iommu_setup_mrif_context(RiscvIommuTestState *state)
> +{
> +    uint64_t dc_addr;
> +    uint64_t msiptp;
> +    uint64_t pte0;
> +    uint64_t pte1;
> +
> +    qtest_memset(state->qts, QRIOMMU_SPACE_OFFS + QRIOMMU_DDT_BASE, 0,
> +                 0x1000);
> +    qtest_memset(state->qts, RISCV_MRIF_MSI_PT_GPA, 0, 0x1000);
> +    qtest_memset(state->qts, RISCV_MRIF_BASE_GPA, 0, 0x1000);
> +    qtest_memset(state->qts, RISCV_MRIF_NOTICE_GPA, 0, 4);
> +
> +    dc_addr = QRIOMMU_SPACE_OFFS + QRIOMMU_DDT_BASE +
> +              state->testdev->devfn * sizeof(struct riscv_iommu_dc);
> +
> +    msiptp = (RISCV_MRIF_MSI_PT_GPA >> 12) |
> +             ((uint64_t)RISCV_IOMMU_DC_MSIPTP_MODE_FLAT << 60);
> +
> +    qtest_writeq(state->qts, dc_addr + 0, RISCV_IOMMU_DC_TC_V);
> +    qtest_writeq(state->qts, dc_addr + 8, 0);
> +    qtest_writeq(state->qts, dc_addr + 16, 0);
> +    qtest_writeq(state->qts, dc_addr + 24, 0);
> +    qtest_writeq(state->qts, dc_addr + 32, msiptp);
> +    qtest_writeq(state->qts, dc_addr + 40, 0);
> +    qtest_writeq(state->qts, dc_addr + 48, RISCV_MRIF_MSI_IOVA >> 12);
> +    qtest_writeq(state->qts, dc_addr + 56, 0);
> +
> +    pte0 = RISCV_IOMMU_MSI_PTE_V |
> +           ((uint64_t)RISCV_IOMMU_MSI_PTE_M_MRIF << 1) |
> +           ((RISCV_MRIF_BASE_GPA >> 9) << 7);
> +    pte1 = ((RISCV_MRIF_NOTICE_GPA >> 12) << 10) | RISCV_MRIF_NOTICE_ID;
> +
> +    qtest_writeq(state->qts, RISCV_MRIF_MSI_PT_GPA, pte0);
> +    qtest_writeq(state->qts, RISCV_MRIF_MSI_PT_GPA + 8, pte1);
> +
> +    qriommu_program_regs(state->qts, state->iommu_base);
> +}
> +
> +static void run_riscv_iommu_mrif_notice(bool enable_bit)
> +{
> +    RiscvIommuTestState state = { 0 };
> +    uint64_t pending;
> +    uint64_t enabled;
> +    uint32_t notice;
> +    uint32_t dma_result;
> +
> +    if (!riscv_iommu_test_setup(&state)) {
> +        return;
> +    }
> +
> +    riscv_iommu_check(state.qts, state.iommu_base, QRIOMMU_TM_BARE);
> +    riscv_iommu_setup_mrif_context(&state);
> +
> +    enabled = enable_bit ? (1ull << RISCV_MRIF_INTID) : 0;
> +    qtest_writeq(state.qts, RISCV_MRIF_BASE_GPA + 8, enabled);
> +    qpci_io_writel(state.testdev, state.testdev_bar, ITD_REG_DMA_WRITE_VAL,
> +                   RISCV_MRIF_INTID);
> +
> +    dma_result = qos_iommu_testdev_trigger_dma(
> +        state.testdev, state.testdev_bar, RISCV_MRIF_MSI_IOVA,
> +        RISCV_MRIF_NOTICE_GPA, DMA_LEN, qriommu_build_dma_attrs());
> +
> +    pending = qtest_readq(state.qts, RISCV_MRIF_BASE_GPA);
> +    notice = qtest_readl(state.qts, RISCV_MRIF_NOTICE_GPA);
> +
> +    g_test_message("MRIF notice: enable=%u pending=0x%" PRIx64
> +                   " notice=0x%x", enable_bit, pending, notice);
> +
> +    /*
> +     * Interrupt remapping consumes the original DMA write; the generic
> +     * test device cannot read it back from the supplied physical address.
> +     */
> +    g_assert_cmpuint(dma_result, ==, ITD_DMA_ERR_MISMATCH);
> +    g_assert_cmpuint(pending & (1ull << RISCV_MRIF_INTID), !=, 0);
> +    g_assert_cmpuint(notice, ==, RISCV_MRIF_NOTICE_ID);
> +
> +    riscv_iommu_test_teardown(&state);
> +}
> +
> +static void test_riscv_iommu_mrif_notice_enable_clear(void)
> +{
> +    run_riscv_iommu_mrif_notice(false);
> +}
> +
> +static void test_riscv_iommu_mrif_notice_enable_set(void)
> +{
> +    run_riscv_iommu_mrif_notice(true);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
> @@ -275,5 +373,9 @@ int main(int argc, char **argv)
>                     test_riscv_iommu_g_stage_only);
>      qtest_add_func("/iommu-testdev/translation/ns-nested",
>                     test_riscv_iommu_nested);
> +    qtest_add_func("/iommu-testdev/mrif-notice/enable-clear",
> +                   test_riscv_iommu_mrif_notice_enable_clear);
> +    qtest_add_func("/iommu-testdev/mrif-notice/enable-set",
> +                   test_riscv_iommu_mrif_notice_enable_set);
>      return g_test_run();
>  }
> -- 
> 2.54.0

