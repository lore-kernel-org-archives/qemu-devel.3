Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4B3C9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB8vG-00052d-RU; Mon, 28 Sep 2026 06:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xB8vF-00052V-87
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:49:25 -0400
Received: from mail-francecentralazon11023112.outbound.protection.outlook.com
 ([40.107.162.112] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xB8vC-0005SH-Qw
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:49:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwYlgDMYKHthytOH0cwIryid+/1zyDif0zGO4PpAGfyUBDtT9XyMfI5GizQa2p09qE96O2nilCF9pzCSaGplgmh58zVg+OfAGjQcGUsNh6OGB5UipplWLHQin79v+s8MjIcYJKOet0nuq3iEOsgPqCaQowVoPPoVFChEuK5lxNuII3zGb+B0nN8RFIGcOXsEPPBnuQ7IX5i3Ysn5phGO6b96nlTqOMTF8TP5sjiKDl2Y8rJBA4avbTfneKgHlVlH8JByvF9YTx6vFY1s9ss1ipAZY9CqtYMNqpu2bYRpWaR24sdcxEUG5Ip8WlXfdOGbBPXm7YceOds6Vw61BdEeKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4G+3nwk8ZBFMWvA8Y2qTcpFnXRbXwcbM7b/xHs7Cud0=;
 b=hgNPxq1B6RG6r1aeNg8s03+pknHxAqNbXjTwkH3rZEO+gPYP6qxSr7NdPG8p8jTxvtWwwXs68GKMWHLk72XWrOTeuuPH5eRnN15vn1XFNGapLCAybxAZKeaOvbWSiYZEEPLWtlT37UxZxc2/dTgAl1RkBd2E0V1q97++OhvUOUFTjPrqbrzZHMiHTax3ob1r0+os5KLB1J70Vi0tOoFLDgELK5k09FoeRpbM7TS8l15TsV79y/tX65pT4Bhp3dSDjDvk35qOwKqsL5RYFtlkd8nKcQw3HwMDKkku2n7g8PNsUAlxlsX8L7JKlJN7ikucleeKQP4MAbIsvVxe8LkvWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4G+3nwk8ZBFMWvA8Y2qTcpFnXRbXwcbM7b/xHs7Cud0=;
 b=aCBqCqfthVT+/hm5AFTYqjaT/IAklqWjTqQVyztdDoK5J/NwQrBOAlx0Kfn4KuD32luBs1LKDv3pC36EzCiBh/4JI9T2OLsiUaxQx9A5+Xcpk5qk0WUKfzCAMUtg0ERu9bR9FqN4m6xkM7I8FbrOqmWncmIUj8fanD+jQO95xSSx1q0kofDQpeDOTZH6dFd3AqGf/Gs6DOpLY5t0nd8aM2L8s8RwI0ZZ6u9hHzydOKmbtFRiFNwct4qkXseO+N62LmKsiKx08hVPkKK16NtbjvphreferW5hACfYmQlcmivy4TmqEMzJioXtZ2majzhjVW/reeX1A78cuhmog/CDow==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GVXPR08MB10405.eurprd08.prod.outlook.com
 (2603:10a6:150:14c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 28 Sep
 2026 10:44:15 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0451.014; Mon, 28 Sep 2026
 10:44:15 +0000
Message-ID: <cc4290ef-432a-48f5-96cd-d0a607688c15@virtuozzo.com>
Date: Mon, 28 Sep 2026 13:44:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/16] migration/cpr: support vhost-vsock devices
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, bchaney@akamai.com, mark.kanda@oracle.com,
 philmd@oss.qualcomm.com, vsementsov@yandex-team.ru,
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, mst@redhat.com,
 clg@redhat.com, peterx@redhat.com, den@openvz.org, sgarzare@redhat.com
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0396.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::10) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GVXPR08MB10405:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ccb61bc-b634-48bc-b6af-08df1d4d70ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lvfl/iTb8P4NiNpQkOVVYEZMdGHEOnM7uVVts28NXhfz/bqinTZ7I1SzpCd2chV5TdiX3ST9kU8/6Rw/f0pLQDvGsYibLRyEsHs0/+GqF1jeu1/STEex54EgKCNZhaXsWZLI7VYMpux5vBzIO25BhxIcrfnHR2E1exP2Tv/ScstgQu+kEb7zp7zkfQpALoUHCyN/l6IB/QBa+nuueCqggjaJHgleoouVHP3+NCb18j3XDJsakrr5ZLfewbLDDA/vmTfMGtSOCYHmiO+5vi1IK5TNwKgdor6mC16TU4yJ7ykZP19SlVpcNkEjJ17J+sw5OtbsLMtZUjX6Ok/aySd7r9MZlviK0baXoGctU68trkcJ/9UCkXHSktA8RJ9vzeXQAxLrcdgULTJReNsQbMwrMqXMgKBCNvrgFY0oFY4aadpU/8LREruIsyDVcReYJYpX9Y913Gva+KvEfDfscNQYH105aCS9QR9pwFsBgOr97Wexnnc2Vpc647k8N2EIlxwPKUPRNRx/kPo4JgyaQwx9vEznRcVXzvim+66PCn7ItHbcg8o3JQk8NFU1vQWgCEjxTROtB/3PCqPRdTZAcWYUagD56xjpuZTYeHh7X1fmjtFSBk3UV4oE/N51QyEnripx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkNuQ1hUd0ZVSmZxNmRvejROMFFLUG1kWUhscHlKeGN6Mm5yamQ1bjlSTy9P?=
 =?utf-8?B?cmZmYVB5RHU1REFuTUFQVHQ4ZVhUZ255YVVYVnhMMjBWdVpaZEdPR2QrbDBp?=
 =?utf-8?B?UjVRUnF1YjN1SlZ3a08rNVZTaTVuTkdXck4xZklVa2FoZ0dtcGhTNGZjd09X?=
 =?utf-8?B?SXkybTZmbXBPbm5ZR3cydEdhOW1lRTFkV3NXOGI0Sk5qUFdjc2xWUWloYlB6?=
 =?utf-8?B?YkpRSHJ5QTQ4TjUzaEJoSlNVYnlJZDV2cTBFSmtJWlFhSWoyVXFTbVpSYzZR?=
 =?utf-8?B?MkFINmxBay82L3B6RS9oRzBnbUZJVVo0Z0pXK054S2R6a2NYOW5odWc0dkZt?=
 =?utf-8?B?dXJSM0hqR2dIR1FpekhkVVdnejkvNnBxai9WOU9nUytZMnJlZE4zaWExUVdX?=
 =?utf-8?B?TUx5dUFXak5RN0NBbGZ6NHk4amFyR3F4RnVwVVdiOHJWamhuaGlEKzUrQWRE?=
 =?utf-8?B?MHRJS3J6MWVUaWRxcVJhN1l4eThsdlppS0JhcWd1ZkdSZm9mWUdHdWtlNzVv?=
 =?utf-8?B?NG1CNWNWcVpBTW50YjU0RTMyc1AxUDdGcWFPUnZMVVQySkdYWGh3UmV4TE9t?=
 =?utf-8?B?Q3oxQWsrcUtMUXNyRW51aGVEUjUrclB6SDZIT1hsZ0JyWFc1eE5XK2NKVisr?=
 =?utf-8?B?WmpxVU9VOXZwTlZnOTFCUFd1YTQyQXNmOWowd003UjlWWkJqKzlOZ2g1R3JZ?=
 =?utf-8?B?dWxUMUdvZkpaaTdIU24vb1ZhdEVGSzhscmhPYXJDaW9CTjdiTUY4dER3T0tk?=
 =?utf-8?B?OHZxWDc5MjByMUh6SGgzOVhwWDl2MGo3dGR1SmQ1Si9MRm81czJDbEpOMlor?=
 =?utf-8?B?T1ZVWVRRMDIwN042eVZ5dmJTNTA0NnBzbGZPL3RRNnlGMW96NnhDT1ZxMUxK?=
 =?utf-8?B?WldIYVpJTStSa2VjQldVTXBuWkpoWFB1TEFIMUw4QlNtRVRSVGFjenJ3c1NG?=
 =?utf-8?B?SGI2Z1hwMkV5OUFqVjlZYTVLYTBpTGJ5MXN6NVVzUEx1WXNobmdyaTlOZUFo?=
 =?utf-8?B?VWQ3c0JuSXE4Y2grWUVaNDM2bXZGcFQzUWZQOS9COWhIbnI3Q21BOUxQRWlI?=
 =?utf-8?B?Z2dmcGdJUzZXRExTNURhUm5BbUs0V3dkV1ZzMDRyaEU4YlE5Tk94TmFtS2lH?=
 =?utf-8?B?VHlHbkFyQ2t3SFhMcGJZU2Vtd3pvd3ZobzgvYzRJRUJNL2pvY3dJekpsUHRG?=
 =?utf-8?B?cXpOUndoaWJyMTUxVHNiVVErM0tMUzBRQ2sveTdtbjdZUzRQWFoySnBLeDhm?=
 =?utf-8?B?VnltQS9xTjRucnBaM05pYVpBcWFlWW9tYVJ5OW5adkJ1MW1HWk9pRDRya0FY?=
 =?utf-8?B?TU90T2I0cmVpbUFyTHF0WlhBdnVpZjNZQ2U5Z2tQc1c0bVVZbENPMHhhdkJD?=
 =?utf-8?B?RDBSOGpMa1IwVllzVTN3NnY3YkRQclg4SFVKS1FiRmdHeWU5RlI5NHMvRUZU?=
 =?utf-8?B?MnRBVEh0UFZGMkhVN1VUREpqWGFoU1pkb0kxcURoOW9uL1daTDk3ZUE0Z1BI?=
 =?utf-8?B?NEEzamVkMlpJUHpjQVdIRkF6amgrNENpU2dtUDJ6R2FyMDRZQ28rdGQvQW9N?=
 =?utf-8?B?MTZsRGkrc1NSTk53QlNablM1Nk81RTkwTnM1anBZVUxmbHZZYUh2TUxPVEtw?=
 =?utf-8?B?SzZON09WUlVGSzJMbGhqMDkxempXVVppR2F1Yy9PSmdjT0xFYTRKMnpTTkNS?=
 =?utf-8?B?bFRlZlNLelBzRURLOXpGaGdLVVhTenVEWWVxT3ZTWURySDA0aWg0YnJCWUlv?=
 =?utf-8?B?MFlNSmxGbld5dkZKRFFab29WaC9nVEJSUzJydm1CdkVva0hsNFlqV01vd2tH?=
 =?utf-8?B?bS9VdFZFTWpPNWlhTEpqVERkeFdNamhGQmRFRHdCRTg4R1JHeDhUNkRVNE9L?=
 =?utf-8?B?bVljQzQ0MG1rZjBiVnJUWkZrZ1lMVmZNT2JQNDVCZiszNXpaVHg4YmlINzF2?=
 =?utf-8?B?bk1NZkZ5RTdOYXIvd2xNckdudVBNUXIwVHl6NzdLM2NRQ042blh1b2VYVzBs?=
 =?utf-8?B?YzJIRXJqQ1RkSml0aExKNGdpSzQ3TVYxL1JleG1LVk50WkNCVVI4UGRNc1A4?=
 =?utf-8?B?L2FjbHBDN3Y2ZG9lYlNMRE1DcGlXRmVTeEtqUk9MY3k2aE5zL3dBejVCUU9N?=
 =?utf-8?B?L2txYWlXV1JvVmx3Nko1VnB6RFlCMW9xNzNCR0oySHJYTEhTTWtnVG12S0dn?=
 =?utf-8?B?WDhFMEJpNVFQYVdFdFQ1Y3dEN29rN3VWTHd4S3g4L0QwRkRNWDZmRjhtVUVG?=
 =?utf-8?B?cWp5WUJ0aWFzV0dac2YwZCtGQVQrbDFVK0hFTzBvNzZiUnlja3dJd1NSNHBx?=
 =?utf-8?B?RVVhak9NN1FYeGFQcmFyOXdmdGpuNVBDTXJUYVVieGk5Tm1kN3hGUkhsNzZx?=
 =?utf-8?Q?Yz7e0ZpeAbNGd9kY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ccb61bc-b634-48bc-b6af-08df1d4d70ab
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:44:15.2069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZJs2+jnXLLR34Jw6HIsyQ1p6aB7U98IDGZlljavJNtWjypP3Ad68FbuOp7joJrM7I1kj1QrnYOARoukL3G43PdolY6rTROcDs2AwMdleak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10405
Received-SPF: pass client-ip=40.107.162.112;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

On 9/18/26 4:46 PM, Andrey Drobyshev wrote:
> v6 -> v7:
> 
>   * Patch 9:
>     - cleanup closed vhostfd here rather than in #14;
>     - add !cpr_incoming guard before saving CPR fd;
> 
>   * Patch 14:
>     - remove closed vhostfd cleanup (moved to #9);
>     - lift !cpr_incoming guard before saving CPR fd - not needed with an
>       early return;
> 
>   * Patches 15-16 (NEW):
>     - add qtests running cpr-transfer/cpr-exec with a vhost-vsock-pci
>       device attached;
>     - add functional test with a live guest doing host<->guest vsock
>       transfers across a series of CPR migrations.
> 
> v6: https://lore.kernel.org/qemu-devel/20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
> Andrey Drobyshev (16):
>       migration/cpr: forbid saving duplicate CprFds into hash table
>       tests/unit: add test for duplicate keys in CPR FD table
>       migration: forbid snapshots in CPR migration modes
>       tests/qtest/migration: add test for snapshot rejection in CPR modes
>       vhost-vsock: block CPR migration modes
>       vhost: add vhost_reset_owner op
>       vhost-vsock: don't reset connections during CPR
>       vhost-vsock: fix FD leak in realize()
>       vhost-vsock: preserve vhost FD during CPR
>       vhost: factor out vhost_dev_init_backend()
>       vhost: make vhost_dev_cleanup() safe on a partially initialized device
>       vhost: add vhost_dev_set_owner() / vhost_dev_reset_owner() helpers
>       vhost: add vhost_dev_is_initialized() helper
>       vhost-vsock: hand off device ownership across CPR
>       tests/qtest/migration: add vhost-vsock tests for cpr-transfer and cpr-exec
>       tests/functional: add vhost-vsock CPR test with a live guest
> 
>  backends/hostmem-memfd.c                        |   5 +-
>  backends/hostmem-shm.c                          |   5 +-
>  backends/iommufd.c                              |   4 +-
>  hw/vfio/container-legacy.c                      |  17 +-
>  hw/vfio/cpr-legacy.c                            |  10 +-
>  hw/vfio/cpr.c                                   |   6 +-
>  hw/vfio/pci.c                                   |   5 +-
>  hw/virtio/vhost-kernel.c                        |   6 +
>  hw/virtio/vhost-vsock.c                         | 193 +++++++++++++++++--
>  hw/virtio/vhost.c                               |  57 ++++--
>  include/hw/vfio/vfio-cpr.h                      |   6 +-
>  include/hw/virtio/vhost-backend.h               |   2 +
>  include/hw/virtio/vhost-vsock.h                 |   1 +
>  include/hw/virtio/vhost.h                       |  61 ++++++
>  include/migration/cpr.h                         |   2 +-
>  migration/cpr.c                                 |  55 ++++--
>  migration/options.c                             |   7 +
>  system/physmem.c                                |   5 +-
>  tests/functional/x86_64/meson.build             |   2 +
>  tests/functional/x86_64/test_vhost_vsock_cpr.py | 245 ++++++++++++++++++++++++
>  tests/qtest/migration/cpr-tests.c               | 129 ++++++++++++-
>  tests/unit/meson.build                          |   1 +
>  tests/unit/test-cpr.c                           |  98 ++++++++++
>  23 files changed, 846 insertions(+), 76 deletions(-)
> ---
> base-commit: 5f664cd37aec17e8145aa117d8da68f507edc8f1
> change-id: 20260908-up-vsock-vhost-v5-c781b39f1c1a
> 
> Best regards,
> --  
> Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Friendly ping

Thanks, Andrey

