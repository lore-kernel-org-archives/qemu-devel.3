Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B620E60A2608
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=yNC5DwCZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xURBL-0001OJ-9n; Fri, 20 Nov 2026 11:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xURBI-0001NV-Gx; Fri, 20 Nov 2026 11:09:44 -0500
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xURBG-0007zR-7I; Fri, 20 Nov 2026 11:09:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yzx4tFKTYl5TfYFw3UR8JpdFGX0cv7M4yul4tUSPx3sTueemgCbtTa9/1iVUU/1yxV2tRIbXVWhW5GYpx9m3fzb1ERr4W16JwOeFNWyyP76LaFYbo3p7w2lu4UwRDg0j/A3r+xdwgy9Z7XwBNH/o3TTT9B4V69K4YKw8ChSgHGv+txSv7Fds7fuQ2LMcQ1ye5IrmxcpRYoLwv3dDYQXS0vF8gECMBki/Upvs0MGRoQVHGHowXlcHhHFvv+xwef8V2blEZZN6Hs8PWh+IE962fpMHm80iDBmbl2UiACYApgWiN7ZUf+9VmvtbxkIklAslbbkhNUcQSc/c2Txx3svBZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srKyheyjfZMIdf3qnD9Kn1oi2YaX64rzmtyyTMNMS7w=;
 b=SJczF+DT/bXGVNEgpzh1lCCPO9+wvbjKkmVcBxH+aNAZVD1bnTkmUwzhM2yKhLMJln38hdiWhmVMzkJXDjPEFDdDTtzJNA8BOml2TlliWWtTLO4OseoJ5tb+HiOpQevE6Jx+If6S7uD1yWFPuAQmXADDOPJg4wPT/fLcWb+q9PTjfuM4C1hH3DO4K2RM+RA+sDAQqACakdxEdgx38fFaI3f0kU3JQ8zvYnRMGCawZa6HlCf6SV5voB6y58Kg3vYXYEDhYS+yDfj1tVzpn9nL+pzpCuSsgDQgijzELL89Hv6Ybp0jmvsjT+1Px/UmCTCUOvX4t7PjKoSv7ly30KeiJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srKyheyjfZMIdf3qnD9Kn1oi2YaX64rzmtyyTMNMS7w=;
 b=yNC5DwCZLAICcFZUKQoa3kCF9lC65EDsgGCWcd6iYa73/FY1/np1UkKNISQx3bn5XusekVvqNR5pkVdSjD50lDeIJVVq4dzf4cO4UIbHYZKc8ElNxbO4iofCpQZxzjkRcJWrDj5JxomQtx23AzAmpAOVVJqPkrNqscWHpk78gNGUYZVUKtbzV/e3zsKmo7Y8XMUvWPm5ISwMtNmYwlJRuHzni8aR/dcXxOkEGLu7ujNerhuCmNRrYqJHYakUPWNAxE51eOeUZNoAdnsMwgH7TsgxY6rPdFoGPlHsBz+w1u7yyhai9XNtkdKgjdbILLX+8mX77MxPBF8i4EA/HWbkEQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DU2PR08MB10230.eurprd08.prod.outlook.com (2603:10a6:10:46e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 16:09:37 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%5]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 16:09:36 +0000
Message-ID: <e326053c-acc7-4484-b814-e1cd4375cac1@virtuozzo.com>
Date: Fri, 20 Nov 2026 17:09:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hostmem: fix cpr-exec of VMs with bound guest memory
To: Peter Xu <peterx@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org
References: <20260924125800.4188406-1-den@openvz.org>
 <20260924125800.4188406-2-den@openvz.org>
 <cd0292cf-2a87-4716-a8c9-d87853949c76@maciej.szmigiero.name>
 <asZaCerfcnfmAlIw@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <6144855c-f231-41a4-ac6e-b47760b7c8ce@virtuozzo.com>
 <asaPlV0HAyfQm_PS@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <20261105180146.2959656-1-den@openvz.org>
 <awBb-wKu6j8JqP1V@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <awBb-wKu6j8JqP1V@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIYP296CA0003.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::9) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DU2PR08MB10230:EE_
X-MS-Office365-Filtering-Correlation-Id: 37cc0c7d-b0c4-4135-c642-08df4720ac57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|10070799003|22082099003|18002099003|4143699003|56012099006|5023799004|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261102123227099003|261021121427099003|261022105027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: pFBkZ+2xaaipOuugUUlGBLBcKMvdl5cROIYz3v9qSKoZL07WRR6QRIHc3sBfBWZb2fNrNpf+CUU6Od4Wy25YAb/pkg/UBKuyK9H8Ld4VaBhq4cXVChvC0rvDjTI6oK0uv+Of22ZBKn9DX5NsBOGbEccwbbiuVljbw4oi2BNGTHzJt8Nnxd6ytru6TjKSozXKvGMYZP0+v+0LiTRDXj78FL1adRaozREOKlcYfs5bo5lEWmS6sIdcITyvsPcwX95kyFIY330nDQcvcxXvwWSb22D5j+h00FM6rVuuUkWVbyefXgagNSQxttWHr/51D3BB++RFJBm+oY1ZRgyiRogzgalE/N/IhlSbgMCyhu02u9P0LMn8bihM0se2yRuTgDOFFpRJMvQdQ1gZE2cYEsIUDlL7j5VRRF+4L7puiEJ9qZaohPxj2O3AIxpBnlIhSbZuTyRIHYZI3/ugfveBtePS6TewA8LJrbGQu/bGY8RBTmQFXhY+6M+82r5Ir4c4A7feE8LHV4KcuzrLsxycV4QbNWNAE5v6ooIv1IHCL4gcPDAMJaz6FeFK/+TST3UKKm+0slvUhbDGfo5y/D3PWRLIIvCNv6s0vCEo9H72ocvM26Y9i77nmL7JiuKoeYg3S67SBHOFrfEMqwDC+Bjv8INmD8CiPf5HhJPn+xvKyJvj0RU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10070799003)(22082099003)(18002099003)(4143699003)(56012099006)(5023799004)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261102123227099003)(261021121427099003)(261022105027099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjU0Vk1PdEpaUDR6bGVyRUhzcXBhekRmM05PZXlwZVZ1Y3VUblZaaXpnRG0w?=
 =?utf-8?B?TmY3cGRydWtyWlJkV1ZSTUcyMzJncG5ZNndsdnBnbjYyY0V4WGtpTzVmNFRJ?=
 =?utf-8?B?VE5kZTlKU0k3ejdqMFZRSllyblJqaGtpTDZuUjhYTWhHdlJlL2xkOFIvSXBO?=
 =?utf-8?B?ODM3N3lmMjlsaU02Wlo4S01PMmdQOXhGb2h5eW83dml3ejdPL1dSMFJEdEhE?=
 =?utf-8?B?VkxjR05aemtMc1IwaXhJMzZ6S0pKZTc2M3RVNzVBZnpaMUt0WmJtSnNOQWky?=
 =?utf-8?B?WnV4a3hyT05zMFE2dFhlZ2xUZDNGejBuV1MxZmpRVFRHYlltS1Vmc21qN3k3?=
 =?utf-8?B?YWl3dk1iQW1aQTdiVkpqSWNWdnpmdzhTMzRDczdDN2NDbEJsVFZ4eHJqaFU2?=
 =?utf-8?B?WWpDVXp2TlRWK1RZSm9TM2d4dnM4d2xPQzB6RzZEOGhwK0VwMTNRaDV2SDg3?=
 =?utf-8?B?VDk3eDd0M0NVTkdKWS9xMGUvVXU3WmhFMHFzMGlMYUlJczlLc1JVNTRGalZC?=
 =?utf-8?B?NEIyWjJHNi95VE9RV25GRTRXdDBneXo4Um00TGpiUlZ1MTBaNG9sVjVaTnBw?=
 =?utf-8?B?c0ZVdEhmcHRwTjVpc3RwWUZaM1JGSG9LbkNudVhRYnBBeVF0QW8vYmxSajZl?=
 =?utf-8?B?aHIzV3d1VWk4L2t2M2tpellURWpHUTdOUXJLbmZ6dENLY0J5YzhHYnBZdk1i?=
 =?utf-8?B?QU9LWTJLRFNoR0R3S0NwaG1rQ2krRmVTZkdNTWdteDk3QmpHU0Izd3dDRm8r?=
 =?utf-8?B?RUh5NzhvUk9XQjMvRWdWUXFQN1pqRnRqclFuMDhNVTQ1TDBDTDAveW9QOHdp?=
 =?utf-8?B?eUx1YzNlZXE0eElhWklPUEh6M2JSYjFFWFZxYTRNbzdudkpORGdkQVBWZktN?=
 =?utf-8?B?UTlWQ25IZnlvazdHd21VdkFNUm1PS0owL0FybHI4OHduRXdYcElYS2h4MHpk?=
 =?utf-8?B?Q0poaitjRFFJQlFIWk1VeTcwdGpLZmpsRUNFVEQ0bHNpZkVYdGJYRUhVK1Y4?=
 =?utf-8?B?c3pBdUZsY2M5RzBaanp3TGE5OHE2Wmo3cDVZRXBpMHFIMnB4RlVSbkYwei9J?=
 =?utf-8?B?ZWpQN1Q2MlZsd3RNM29TSm9yY3FmVkV5aWdDc0ZUZzZIOWdMTytWdmRpWVBG?=
 =?utf-8?B?dTJUWHlsRDFLU0RNTC8wVUIyQ1lQY0k4eitLQ3hGT2ZicHdSODIxZW5teEdS?=
 =?utf-8?B?WTY5Zmg3ZVJWd0JUMFM2cm81UFpROVhWNmhnT2g1M1JKb21NUC9VWW9ROGwy?=
 =?utf-8?B?WEJWckFFZjF5QjFxczFLSkJxaWhyV1A1Q0dRalpaV3ppVzRjdlFTM2EvMStN?=
 =?utf-8?B?Y1hLR1ZWWld4SlNKMVAyZ0JkVEZMNUxEdXBJSzluaXRWK3hONURWakRZMm9I?=
 =?utf-8?B?SUZ6MFpLUG93Q29KSmZyYnVPeDZYOGdRS2pTVGVRTU5WelFFRVh2R1hCSWxX?=
 =?utf-8?B?NVhKVUVTUG5YeklEcHd0RG0vc3NPS2hzYXhDQzh4bEZPbDh3K1ZwUkdpTHJx?=
 =?utf-8?B?S1ZVODd2VndwcTlYMG5vNTRKZk04YWFuSytid2VEOENNVGNhaGVVQUFTcFlx?=
 =?utf-8?B?S0tCTzhaYXhPZVk0RURUQ2hVa2kwaTFvMFEyM09qa0dGblE5T1V5NU8wRWhm?=
 =?utf-8?B?MCszOFptWTBTS3ZxOGFNRzhYd29tQ2NmZU11NEs1NndIaExiVWxLdXd5TEJC?=
 =?utf-8?B?a3ZBWEd1QWZyNFVVdm9ZNmdOMTZ4ZVRxVnd0S0wvWHJaZ0U5NXJwUTRHYklQ?=
 =?utf-8?B?THZGSHBwS0U4M0ZiZnplMWRlQng2VFFDcTBabkZrb3BKbHhmOHd2d3JBTHds?=
 =?utf-8?B?c2kyTnhVd3M2N0lGM05ITU94NDJvOTgxTnZONDh0SjJiUHRCQjd5YVM0TUZD?=
 =?utf-8?B?aFBXZjdYeFh3UGNQMGVHTnZxc0xFYm82MThWSWRMYWYrMHVvcGFBNEVIeDE2?=
 =?utf-8?B?bUJXeWFSeXJXTmdYcldmdUFQVGRoa3d6WmxJdEFBU3pJaHJQeEZqV1RoNzEr?=
 =?utf-8?B?ODZRYjJqdHNCQTc5UTh4c3BKQXlzOUhYR3UvbjBiT210TlJxZzVXN1ZnMis0?=
 =?utf-8?B?b3hGK1FkdXZFcjJiaFRRYkx4VEhqRU5mRHVrYys2SjVuV2U0VFFMdUVpMmpz?=
 =?utf-8?B?NzBJSGsrcllrcTF3bERtbm9FM2ZkcFJrdWtpUWllT1NBRUM4aU5LRnFXbW9k?=
 =?utf-8?B?cUpkTHQ0cWN6Vml2cmVXTVQxelBhTFZkdE54V1hVM3ErRTNqclFsTFNkemo4?=
 =?utf-8?B?R2tRYUV0NTc2ZVZieDByRzYwVGw2ZC9kTkdnY29jODVQTTU2SWtjdk1CSFI2?=
 =?utf-8?B?dE5zY3FaaVFNaGNsYmtvVFJDSExzcG9wUUJYbklQWTRzdC9ZazVFNHpCSEt6?=
 =?utf-8?Q?v+MNTvSZaa13etCmP/DAQR0+alcWcuTTYOmLdLdd9jBGz?=
X-MS-Exchange-AntiSpam-MessageData-1: pbY+32jaG9MQag==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37cc0c7d-b0c4-4135-c642-08df4720ac57
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 16:09:36.7160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xFIGw26FZQ157T3T06pPsVIFewo0lR+5AkymXtKSIJOlAQIdQSeYqW7XzgnafyvGCb75DGY15CMZnARyVxqPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10230
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=den@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/26 16:13, Peter Xu wrote:
> On Thu, Nov 05, 2026 at 07:01:45PM +0100, Denis V. Lunev wrote:
>> On Wed, Oct 07, 2026 at 02:29:41PM -0400, Peter Xu wrote:
>>> One thing I can think of that we need host-nodes= is when different
>>> backends may be bound to different numa node, but since the current use
>>> case already enabled memcg and looks like it can shift to completely
>>> different numa nodes, it doesn't seem to be the case.
>> That is how these VMs start: libvirt turns the guest NUMA topology it
>> gets from OpenStack into one backend per guest node, each with its own
>> host-nodes. The cpuset is moved later, and not by libvirt, which
>> refuses to change the nodeset of a running domain in strict mode. I
>> agree that host-nodes plus a moving cpuset is not a setup to
>> recommend, but it is what the stack gives us.
> [sorry for a delay on respond]
>
>>> So it looks like a real issue and also looks severe, but it's a matter of
>>> whether it should be fixed in qemu. If we want to fix it in QEMU, we
>>> should have some solid reasoning.
>> QEMU never asks the kernel for a static binding. It calls mbind()
>> with MPOL_MF_STRICT | MPOL_MF_MOVE and without MPOL_F_STATIC_NODES.
>> Without that flag the kernel contract is that the nodemask follows the
>> cpuset: when cpuset.mems changes, the policy is rebound to the new
>> nodes (Documentation/admin-guide/mm/numa_memory_policy.rst, the
>> MPOL_F_STATIC_NODES section), and on cgroup v2 the pages are migrated
>> with it (cgroup-v2.rst, cpuset.mems). By the time of the update the
>> running QEMU had its policy rebound and its pages on the new nodes,
>> and the guest ran fine.
> True.
>
> However also since QEMU uses STRICT+MOVE, it means mbind() is also expected
> to fail and ask qemu to bail out early if it can't move them at least when
> QEMU boots.  This patch will change that behavior, even if only for
> cpr-exec.
>
>> The incoming CPR QEMU is the only one that objects. It takes the
>> nodemask from the command line and re-applies it to memory it did not
>> allocate and the kernel has already moved. host-nodes no longer
>> intersects cpuset.mems, so mbind() fails with EINVAL before it looks
>> at a single page, and QEMU exits. The EINVAL itself is documented
>> kernel behaviour. What QEMU adds on top is a lost guest.
>>
>> A normal migration destination never sees this: it is a fresh process
>> which the management layer places before it starts. With CPR the new
>> process inherits memory that has a history. Steve fixed the same class
>> of problem for ROM contents (b42f28111e), pflash (e56ba1878f), PCI and
>> vfio-pci reset (24c156dcd9, 031fbb7110) and IOMMU mappings
>> (6ff4cccd13): realize must not redo what the old process already did
>> to state that CPR preserved. 2b7e9739fa made the backends inherit
>> their fd, but the mbind() and prealloc tail of
>> host_memory_backend_memory_complete() still treats the memory as new.
> At that time, Steve was pretty advanced on the design, and it's a huge
> piece of work so likely we didn't really have enough resources to fully
> review and discuss all details.  But I think we should not take that as a
> reason to say we can keep adding cpr-exec check into more places: we'll pay
> at some point, I have that feeling.
>
> One example, the iommufd change it hid the check into map/unmap, it smells
> hackish on its own: IMO it's saner if we can skip all map/unmap completely
> from top when cpr-exec dest QEMU boots, if the fd will be preserved.
>
> Another: I don't know why ROMs needs to be skipped either, logically with
> aux-ram-share=on it should apply to all such MRs, if not it sounds to me we
> should fix that instead of hacking rom code to bypass a memset.
>
> I confess I didn't read anything yet into depth. But these are
> pre-this-patch questions, feel free to ignore too and we can focus on this
> one.  I just want to say some of them may not stand on its own so I also
> don't want to use that as reason to merge more of such.
>
>> Prealloc, when enabled, is the same story. It runs MADV_POPULATE_WRITE
>> over the whole inherited guest RAM while the guest is stopped. That is
>> downtime growing with the RAM size, spent on pages that already exist.
>>
>> Maciej is right about extra backends. A backend the old QEMU did not
>> have gets a fresh fd because cpr_find_fd() finds nothing for it, yet
>> cpr_is_incoming() is true, so v1 would skip its binding too. v2
>> decides per backend, by whether its fd was inherited. For an inherited
>> backend it still calls mbind(), reports a failure with warn_report()
>> naming the backend, as Maciej suggested, and skips prealloc.
>> Continuing after a failed mbind() is safe: at fault time the kernel
>> ignores a bind policy with no node in the cpuset and allocates from
>> the cpuset. Backends created fresh in the new process keep today's
>> behaviour.
>>
>> Peter, would that work for you? I would rather agree on the direction
>> before sending v2.
> So the cpuset is decided from the top, it was broadcasted to qemu in form
> of host-nodes=, then if the top changes decision, it should notify qemu or
> they're inconsistent.  It's almost by design..
>
> We either shouldn't do it, or we should notify to qemu or at least libvirt
> on the change, so that libvirt should know what to do.
>
> At very minimum if such notification is hard: do you still think it's still
> feasible fixing your mgmt code to not attach host-nodes= at all for
> cpr-exec targets (aka, cpr-exec-command), assuming that doesn't make much
> sense if all RAMs are persisted?
This can be done, sure thing and this will put burden to
management.

Anyway, I get to your position and understand it. In reality
the amount of kludges ahead is enormous according to what
I see right now in our downstream (released to public).

This is not a priority item, the functionality should jump
in first. Once done we will have a chance to re-discus.

Thank you for you time,
    Den

