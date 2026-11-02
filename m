Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D017C607672A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=PY8szyjK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuAm-0001b2-KN; Mon, 02 Nov 2026 10:42:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xNuAk-0001ag-CX; Mon, 02 Nov 2026 10:42:10 -0500
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xNuAi-0006QO-BL; Mon, 02 Nov 2026 10:42:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTZeR2CEM2ajRyGsHVpEWg5m6Z06dibl3Jg53i0cbEfZcBjFrVD53DOkEg2Jg2MGrN3HUMhs+8FIAh3FyPgYf++zudQ+gcVV+OA5TNtHWSc+tLymbzB0mv9oK+uEDedI3d8cbgaeyYWyBcjJeDcQyw5Oa7wD7vlv79Gm/q7WU7ucTrPNbQadXiRQysdfhrmJQfNPZ5AehpnvWAWKR1I6MZJNrT/hn6yXu8i7WIsWPE105Z3Eh2LTCF7497yF8KuG2Eyd+BIcuMmtwSNFOT2PHFdW6x9ar9tpJcYfMTm/7LsYoJdULH3aNilA6DSlPoNZ0zZOM/dDGGVwKFZByWqsww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJW/fV5q82OMMAAtJgf3rUOfrHe9c+5DNerZjAOdiVk=;
 b=BjY4uotv6k+lWGBTVEIHA6ss/8viMywtAwkACm6tRl82AUlcCuwkMo7kThOBW3ykC0j6MPt6inhLpbkQDkkNJsd1bC5lddzyIlWsAazXLKusV/o5qYuw2Ppcqoi2ehf/tarqRhC6zDcLyGy38bKqCXMZlUgaMoqDmmsdsGdjZwQtvvKs6ngRZ6oFiTMqawOdhRYGf20LD9rX4NtCjDLeURWcBJkvnoRABk9CWWPPzvKED24kvGDBqnlqdeF0xy0//MGFBtbpJ1S3QaNVe758XWJmF+0oaubGFD30BSS5uDBjy4VLb4yHxI8/la82+AlAY+FdmfSpD38Z4JnFHCPQMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJW/fV5q82OMMAAtJgf3rUOfrHe9c+5DNerZjAOdiVk=;
 b=PY8szyjKS9e1vGGit/84Z7Z2937QsIqYHsZQedyuddu1asZtgBSfyMDXJuNrhPH3jugwdFhWfg8UyEVc+kOVAa0upuOrF1aYRf0C5sQIJ/stf2cIl0Cnjv5yIU2h5AtULA0zJzUbZ1/CVLWxRzN/i1O1EST57NyvOf3IHWd5LH0s7nKCh49VROA7TYQsDmU6N4R9MnXB7vMjvzDI+4W5/72sPvoCzasCj6HU6BWruzakHJvgxGyMyuY7zFo2iYev+eCT3+tWalItJA0GoNw8Fk96ajCmH2EScMcXyWmui8Kjy8vgyh6gdwh1dPJqMrlF8xe3CPtfDtkYrM81SaZyCQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AM9PR08MB6020.eurprd08.prod.outlook.com (2603:10a6:20b:2d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 15:42:02 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 15:42:02 +0000
Message-ID: <468bcc37-699b-45d9-a0dd-63f957ef1af5@virtuozzo.com>
Date: Mon, 2 Nov 2026 16:42:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ahci: Check Bus Master before starting DMA/FIS engines
To: Abhisek Panda <abhisek.panda1@nutanix.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, den@openvz.org, jsnow@redhat.com
Cc: andychiu <andychiu@synology.com>, "Michael S . Tsirkin" <mst@redhat.com>
References: <20261102134115.282413-1-abhisek.panda1@nutanix.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20261102134115.282413-1-abhisek.panda1@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR10CA0101.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::30) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AM9PR08MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: 0407657b-4cee-4f78-1ba3-08df38f7d699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|10070799003|1800799024|366016|5023799004|56012099006|261009223027099003|261028144727099003|261021121427099003|261022105027099003|261026140227099003|261026121527099003|261022075727099003|10067099003|18002099003|22082099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: XZ/Xh9gSNDNulwjVIUnJxdkeYvlNK+dxbNd2negHTzAhLUliVHbtE/BROrdBOd62RgxLL9gBJBakpk/+wN1ks1d9LPSSoPJXWDKM+WVMRlauUY1YNIzE8iQkdaj0nOQAQnPJVYsCusXx8ZGQKyJnTCBk0zl4B1kUWLt4xyc4Gx7TJLdJh/SM+HPy8gWTxCbcDY8ch6VHNC1I1C9F7XykjJokjYy3MbGI43zWduUgpR/gHWYp9KD0KNXg+AM72g/aHoqVDNWps6+IP3ebJgsMEE0u/9+Wnvq8EZHvljzYjyGUc2+JtUC5EhdDpMHzgoxyXVFPDDxZmJcZRvyx6HTrtewYNrCONgwFukbLlR/WhN/HwwcuGBDUGu2VCtHHb5Z6qbnNCmL8CrFe5+Jy/TgST6ubCp/ilOezu5qlr7Y4FCzcjLq5FnxJeuJBXi+ZvUJnUTdWN3nfKUOIttRtV5GJkgPO2yeYlFzHTzSRyUtXC/fLKY3KqUNTJf/eqOwSe0R7Vyn2NIh4Yak0sRuMHR+3bVWTS76x8qIBivEqhpdzwiPt7ZzBC5j9k3G5yVBemOW4Vkrg6FJn8ZJJCnOC0J13vuPB+Pre+G0G4G2esWKnZc9zl+1HZrEsQ9rZ4Snkx3z+bFbey6kpcxOOPJVHHNxubkIeYITjtmjfU/q82OB9/Lc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(10070799003)(1800799024)(366016)(5023799004)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnY5RW84SXpGYVFmTmFqVUg0QkFoZm1BTHVYYkU2VVlXMGI1bDNkWVhKd2pZ?=
 =?utf-8?B?VW5oWXhjcmZWYmhvbGJVOHMweTVzZytCTE44WVdVOFpZWlhyeCtjZytTV2VZ?=
 =?utf-8?B?dS9HekxWV0JhMUVXUWxxMlNmb3pWRGZKTmpNZlVQZTlmblNaM3dmcWxxeGFh?=
 =?utf-8?B?RUFicUdLd05mUU95U05oazVoUElsbTUwV0VPYTVGbTNvdWNlTHdWcXNoQlpm?=
 =?utf-8?B?YmJjYVF6akpGNC9MUmdEenA4WHBtM295Q3VsVFdCT3liVkFaQk5oS3FkWEJX?=
 =?utf-8?B?b2djRm4vd1YzQ3lJajJsTUtlREgyVmlVclBLRmgxNWVNalFsdno3Q2FWVFhT?=
 =?utf-8?B?bTBzdVdwMGR6SWd0ZFBJUk1IZG1EMVY2aGk4NmV0aXg1UUdnWS9tRVhOYzVx?=
 =?utf-8?B?T2d1Nk5jMGFPMDF1TVVBdzNGcTZOWDNNaEJsakpCWW1ZODFvQXJxRGtGaTJV?=
 =?utf-8?B?TmZ1aEoxM0t6VnlwenplaHJuRm5LYjVkUDBWNWp0a3dvalkxM0N5RktHQWcx?=
 =?utf-8?B?eTkxdWRCckpZVittYTdRcVRmNzJmVUl6dGoxVlZ4ekIwM21VY0dkOWpFQmU1?=
 =?utf-8?B?UU5icGRrWElRU2RiTGNWTFdnbUVJWDJCc3VWTDNqZlBHR0lBcGVQTEtRUllW?=
 =?utf-8?B?SFJ6QzN4YmNjeDZhY0c0TEszeGdyeXNPQ3VVZG02Z2txMDRoRVI0cEE2TkIy?=
 =?utf-8?B?ZXJUdFl0VmRUbEorOWFrYTg5QnVQWW40YmlQZEU5dkQ1cnlrWjlEVEFjVlJk?=
 =?utf-8?B?Q1ZZYklxUTFkWWI5RzdWVW5OMGRkNTBBTkdJdEVYYkFCQWkwU2dtQklnZm5T?=
 =?utf-8?B?anVYMFoyZlRVU2ZKa3dEcHRXYkwvWFpUbVlnYWdBRkczZHp5YUpiSkx6RlVO?=
 =?utf-8?B?MTJLTFNSMmkwS2EvWjMxcmZQUmRFcWl6bStQVFJ4UzVqRi80Szc2VjRjL21Z?=
 =?utf-8?B?QXlQanN0Sm1LVVdqbEdISVhpK1lRRE4vZVN3U2ZTejBIWmtyT05HUXJpanly?=
 =?utf-8?B?NEw2b1B6QTRqYTJleTJLUUNWdEhFelBta2pXanBTZ2dtWTBlN3dWcnNlQk1E?=
 =?utf-8?B?bHlianFaVmM0eERGK1dqSjQ5bS85S21VMVRURjNPbXVMUmxJMkd2OHM2OWFt?=
 =?utf-8?B?RGlPd0w3SGQ2cWtqSitsLzJxTnJ2cWNkcHBML0VYZ0hsUjMycmxTaW1HVWo2?=
 =?utf-8?B?YnZ1bmFzU1p1Qzlxbngxc0xGTlRyTnF2YzQwQVdJdWhCTTVZakljTEwyZlpw?=
 =?utf-8?B?SmVSQUV3ZWtYZUM0cVREb2pVRUtsSkdwcytaYnBjRUtBTThiaWp5RTNGSW1N?=
 =?utf-8?B?STlrbTRGZXk3UHl3STIvQjdGK1NGekFEYUViMi9tczdweTRGcnhjSjlTaGY5?=
 =?utf-8?B?d0xyUjV0OGJUWnZXejByOHI0Wi9SOUNTSTA0S1UvU2h3UmJrditqZmFpTW1s?=
 =?utf-8?B?aFY1QnhYMmpEaGNLL3pKR2VicHF0eXZ0Ky8wWC9idkpYS1dnSEFtbUkxODZ3?=
 =?utf-8?B?b2R0YXVXNE5nZG1BeWpDTmlFVU16S2ZNL2FMdHhBcHZEZmpOM3lPVUZVZnY4?=
 =?utf-8?B?amFLOVBtOFVqVzZtZUFGV3FMQnFhaHpBb1FYNC9NWFkySkwvWVp3eTkvaHIz?=
 =?utf-8?B?dG5ncEduTytSek1JNTBmRk1JYjNHRGYyR3VxVTZqeFF4Wk55Vi80T2FmSXpE?=
 =?utf-8?B?RnVLTHdvdlFoWlVENUhJdCtRSzQrUWFlWDE0RTVlSi9zYm9KZEYzUjNKTVpu?=
 =?utf-8?B?bkNLMUx6RWRzOFJ2aTMwZndESEI3Z3RNVmdGVyt0SGpnVGtZbXFOZUdLeUgw?=
 =?utf-8?B?aGN6Z2IwdnphUlViS2t5QVl0Rzl0cnlFM0dCQTB5azRtREVqT2tqUEFZb3lK?=
 =?utf-8?B?R2lZQVJIOTQvKzRMVHFBOC9UOWZjcHR0NEIyUTA2dkpVQmZ0cHQ2R2NQWTJM?=
 =?utf-8?B?aGNxWm9rcFg3YzB3cEc0TklveEt6MUJ1eFYySHNkOTE1RFdFeDFRT29YTTJL?=
 =?utf-8?B?RGx0SnNxSU9FUjlBTzVBS0x0T3JXZ29iQTZDU25iNTRjdTFkaTRNQ3pOd1N1?=
 =?utf-8?B?ZUp4QXVjaEcwTmdEeEF3RGYvVGYrdm1uclBsRW5EdDhZQUN0VkF0cUZuVkFD?=
 =?utf-8?B?OXpvMDdibzhPRzRhb0JwRGZXM3plLzJtTlNzb09xZnRoOGVEWDlhYlBOMU5O?=
 =?utf-8?B?VWhKelBqd2U4NnZ6U2lrQUgyeFloTU5ZRi9JazdHekpXVFhoMTErb3l4TUo4?=
 =?utf-8?B?b2NGTXJOOXNJMzN6UmxBNmNERE0zUG43SnN4Rm1Td3FZRExVaFFCS0ZhRzYz?=
 =?utf-8?B?RWxsMmxxYTB3d3FCU2gyK0ZoZFhZTGdST2VMS0IvZDJqb0U3aWNOS0QzVm5P?=
 =?utf-8?Q?SAek+cnuGd7htnn9Tn2HMWmSEqmBeIKZ/Q+QHhd/0IYR/?=
X-MS-Exchange-AntiSpam-MessageData-1: YFcVEvIuAbVGLA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0407657b-4cee-4f78-1ba3-08df38f7d699
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 15:42:01.9873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWWwOv3a0RiNRourTp3UlcDxZNj4b0IaM5DYxGSc6orrKHTak4/VBTCmvHDig4LbcD1Sqxy1H2YziZImcAjREg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6020
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=den@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 14:41, Abhisek Panda wrote:
> When a Windows guest puts an idle SATA drive into standby, it disables
> PCI bus mastering on the AHCI controller but fails to clear the port
> engine bits in the port command register. During post-migration
> handling, QEMU’s ahci_state_post_load function checks only these port
> engine bits to determine whether to start the engines and map the FIS
> receive buffer (PxFB) and Command List buffer (PxCLB). Because PCI bus
> mastering is disabled, DMA access to guest memory is blocked.
> Consequently, the memory mapping requests fail or incorrectly route
> through bounce buffers instead of direct guest memory, causing the
> destination QEMU process to abort the migration.
The fix is right, but on current master the abort is the less common
outcome. Since 637b0aa139 ("softmmu: Support concurrent bounce
buffers") each PCI device has its own 4k bounce budget, and a started
port takes 1024 bytes for the command list plus 256 for the FIS area.
While the started ports fit into that budget, post_load succeeds with
lst and res_fis pointing at private zero-filled bounce buffers, and the
migration completes. When the guest later stops the port, the unmap
writes those buffers back, i.e. zeros land on PxCLB/PxFB in guest
memory. Only when the budget is exceeded does post_load fail.

I have checked both on q35 with a qtest: clear bus mastering, migrate,
re-enable it, stop and restart port 0, issue IDENTIFY. With one disk
master migrates fine and stopping the port zeroes the whole command
list and FIS area. With three disks the destination fails with "bad
FIS receive buffer address". With your patch both cases migrate,
guest memory stays intact, and the restarted port works.

Please describe both outcomes in the commit message, the silent memory
corruption is the more important one.

> Starting DMA/FIS engines when bus mastering is disabled might lead to
> buffer mapping failures or improper bounce buffer allocations. Do not
> start the engines in the aforementioned scenario. When the guest
> re-enables bus mastering to access an idle drive, it should reset the
> port engine, safely allocating the buffers and starting the engines.
"it should" is what the patch relies on, as nothing restarts the
engines on a bus master 0->1 transition. Andy's trace in the 2019
thread shows that Windows 10 does exactly that: it re-enables bus
mastering, rewrites PxCLB/PxFB, clears and restarts PxCMD and issues a
COMRESET. Windows 7 does not clear bus mastering at all. Please state
this instead of "should".

> Reported-by: andychiu <andychiu@synology.com>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Suggested-by: John Snow <jsnow@redhat.com>
> Link: https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg01544.html
> Signed-off-by: Abhisek Panda <abhisek.panda1@nutanix.com>
With the commit message updated:

Tested-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Denis V. Lunev <den@openvz.org>

Den

P.S. John - will you take this?

