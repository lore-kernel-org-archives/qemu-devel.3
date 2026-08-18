Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D81C5DF7E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHf8-0001bC-AR; Tue, 18 Aug 2026 07:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wwHf6-0001aX-OK
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:07:20 -0400
Received: from mail-francecentralazon11023089.outbound.protection.outlook.com
 ([40.107.162.89] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wwHf4-00041C-Q1
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:07:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmhT6BmKLCeWq8+aBvXyaHlozAHMyQuOBIu5OpiRiY36QvMkFyhg7XDlA/8WeslcST+5uc6BSPX8YZsizGkiMO+bDgA7eJYzl6GKc2K6YaFtGbSLdofxoGMXNyr1+f3bpT87Le/hDFhV7Gzmdb56yEddaA4jPn3QLW25XAPXhRgZOAf4e8OYM83DF1/ad/QfOgMfOPDaIUHIFMruWUAKvLwyhTsMXPhJHDRkkyr/x0ykrGhUMn+qRHi8OiTA68StB7RYN3w3tJAwyb9MpZl6t9xVeH7mYQAy0QY5mbaBRx7WUHnJEtQdzI721ykbO8z/T3loHZmE09Nw8mvjGwPbSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uu4uoTbUNgmgGlORDEm3tSZcc0kMEYSTHaU6GsTPOXw=;
 b=kpPMda0h533ZSpybJ2wuwF+N6YjTcT0WITIRBOrKRlZ7mtevuUrNNxSsM2vvV4/ZZbRx1k2GNBlnXhl4LRPQdNVDiEzIYBtGsZVEpmZumSJbs5IBngcwaCGZvDaFEso0mhtZbBx7bGArPysTjZDy0chaCIpuznOsBj5GWrHxd6qSlJEzZDD04RKAtSrZPf0lhmsjP6Pq1KX/n0ZxXV7uCx4dVcNRSe91RKnNaehx4uKXX24pRUO7pl/1l3vFxxf3zU+AOCvv5W3hfaYAUJlD/wR1AgKlbRHLFvErLyz71AHsj2x7CydNqrAUAzkitgxn2kR+/gNvECjLaxbHI7n5ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uu4uoTbUNgmgGlORDEm3tSZcc0kMEYSTHaU6GsTPOXw=;
 b=DFO7OienaLklhvLEmlpHfPW1AUEnEuX/PkddrUJ9+AwQWWiUNL/kUf/C4YqT9UtULCFErfa5PDlXYElhE3h2BWJBHiXD9iI9Xw15p/Hl1rBA7G2x6QZpZIu3QUTVynPnO40u5vgNQF3T7+mYnvF9gZwjupsDnsWn1Bj4S0M1XMj7oxyyt458j4SGw1SbMTwQNEc37JRyx9pPKQshJTWQzZ4DXWyQ6BQSPmsZ4Q4jKuxqtOaJ4aWWZwujf2PVZ5uDRc+Nz2X2YnNTIPFgZFAEOLk5sMqGE7xUU47MBXZIJLUYGhpFo8gYL5n9zVIFQ+V7U7zjxaO/oTz8Cmd+qUq3Hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB6602.eurprd08.prod.outlook.com
 (2603:10a6:10:23c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 11:02:12 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 11:02:12 +0000
Message-ID: <dadd79c2-89c7-405a-b2c9-7973c3fe62d1@virtuozzo.com>
Date: Tue, 18 Aug 2026 14:02:10 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] migration/cpr: support vhost-vsock devices
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com,
 den@openvz.org, mail@maciej.szmigiero.name
References: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
 <ee6fc8e2-dffd-4a93-8501-7894c593b760@maciej.szmigiero.name>
 <f335aadd-1157-4a57-bd8c-18bd6b76582c@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <f335aadd-1157-4a57-bd8c-18bd6b76582c@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::20) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b35735-af3c-407c-bb19-08defd1827be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|56012099006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: jMM87zuWij0/EB+K4duIO7fzR9C2Xw5f8MvGPuSjOv2Sm1U+zxhybe9gKTe1f2vPTkLLODcYlc3ockgj8fT0nO/njVAnsB0tB8E3fg55mIKkqeHhK9t5O0UO4mboRS0F81/x+NW/UvC3aMm7Ho9b2dPZ+x+LSHLoxRF0C+2yVwsnPxKA9C1U2wEgxRCvxdiBZ69eAeuU0QDbKa/WBkDh6+gRdtBwnkfP3a23XTP3mFgkWG7CUSo/A0EeVEKnym5kJ0XjVrUjjFa9hwx/y06kAL9JGvEtScvr0c8jdYbxpicNxWH08umR3R/umKcjrQPHj0m8xqtRqZ/KHeHb560A+SH4oF0/yjf7pbWcvUCBDW7UnUZsygOXyVcLC8nl8+90ivfTtWvL2p0eyLPzfP+0tw2/tKcVsPYmdjEPQ5HQ5ztaNQiMkej5FEDJqf2DN8Nn0iZA86TsQUAJk3yqifV3dhaRCh+ypKswPGhaggFKd1lRt98GXjr2oWEgxe6pGjho2dJBx4PNbhKmdlxZqJYW+G6mM1Ko/7ES82HKou1fqBgJlYr6+I6iRQUk/gIqwcLMD5oXZvVT67unpZ23oZcIIzXU3MCKfVDNZXRhjV7Ys7mykFe9gPAHJx8ghGQlP84QjhsUI7oCmVM8WHise1gDIxKecSzwxuhGvHiZetRWcvc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkZ3RERhZkE2dGNIT2dHTjlJUlJBSWNyQVJsNU1JY2tMc0lKU2JqSVNFOWxp?=
 =?utf-8?B?Q1M1RWx2VzhuQk5sTFlaRGdFVDBRQnZFZEYrWjlmOFJ6ZmEySVNrUjc1LzFM?=
 =?utf-8?B?UHdQTGZnZTZzZWRPSUVFeG1pRnBLV00xb01GalBKR1dZZHBhSFpUZ1VMUW9C?=
 =?utf-8?B?QUV3UDlRcCtCMEkzMitwbGJWdnprUDJjdEltQUo4THJxNktwdkI2NW1hcW5G?=
 =?utf-8?B?b1A1R2IzZmJFRnppUlExSklNVitpQW1PeWJIRm5GRnF1clArQ01DbHUzM2kv?=
 =?utf-8?B?T245MGtWWVV5MkhESnJ6UVNFZ2tBS293Q2RlMUZGNFZSZndPek9zZVhIcHd6?=
 =?utf-8?B?TTIxejJNNGhIN2x3MlBoMk8wSU41b1g2U0R4VnRhZEFzV3B3MmZlWU9ZcXhR?=
 =?utf-8?B?RnFaeSt2cFpTTXpJRzcwUmVXY0xhMHBJU1hYYUtOazJBZWFjZmJ4SFFoUWRD?=
 =?utf-8?B?ek84QU5Ibm5sNkl4aWRsV1dBMFlrMTNoL2NUeXR3a05uQWxrQmlHTi9QTjUr?=
 =?utf-8?B?c2lsR0NDNGtMTUxBRVBUZy9ORks4NGRFVWJSMEhXZllURmJsLzJ1NjBWaWpq?=
 =?utf-8?B?dUorMXg5bUt4dVBHcW8zdDk3ZGV5YXRQQi9aUXgzZnl0V3RYemhCaCtoR1JQ?=
 =?utf-8?B?N1ZmM1BUNFBkVVR0OGZzUUc1Yzd1bE1TdCtFeWVVenM1a1V4bVBOQktEQXo1?=
 =?utf-8?B?RjdKNVhZL2l2d3BwT1Y3V2hkWkw5TnlCWFdaSy9VMkpxRVhTUHUweGhyV1dC?=
 =?utf-8?B?eXJpcFgvWm8yeHQ1Z2p4dC8yV0d3TnpEcmhEY0ZZMk1vZ0t1NUJ5VUExSTd1?=
 =?utf-8?B?OVJsK1pXL1NKOC9YRFdGS1YvM2Q3L3FjeXdsRTBCTkZudC9IL2ptRzR3eDNr?=
 =?utf-8?B?dTFWdWtsOHF6YUx5TlFmOHhLekQ3a1kzTHBwZC9jRnVMRlUxZkxvTDg2M0My?=
 =?utf-8?B?eVR0b2hNcTZiN2Q3b0hyNVE5dW8wdkVDcmFoMzlqalR4ZGlZei90dU1Ja0Zt?=
 =?utf-8?B?M2s1aWFnOHVvRFVxejNpRUJ0dURRV1lHUjExWVdHOVZWVWQrajVTL09hR25W?=
 =?utf-8?B?OGd2U1BhZ0kwUHVDZFlWUGRxb0dYNnJRVk03MWdqcy8yYjdGUVJnT0xxMVNS?=
 =?utf-8?B?MjlTZDVOMEhYc291WnpLQzFRWDI4K0NXZk9FMHVZTGQ3SVpraVlDMjExNlE3?=
 =?utf-8?B?dWJ5N0N3d291cEZRM1JqNUNFU2d3dTJGczFCaVJKQVZVN0V0WTVSeXdCcGhO?=
 =?utf-8?B?Zkwvb1JrWStucGE4aXRMa2dBTTdtb1RkZnpIR1hrZnBnNWgzK1Y0MHVsOHhF?=
 =?utf-8?B?Ylg3N1E2TlVPRy9jbG5VZzB3QUt3RmhNaitKeEY0SE5vZ3dLU3QyRVVtZEhv?=
 =?utf-8?B?dzJlZnFoQnBDcDRaOSt3NFA2ZUl2M0lrUnRGWEFSeHFtb0R2ZDVRaDQ1bHZn?=
 =?utf-8?B?cUh0K2JXNDZqNWc1SE1CaStCUTBpdHlTZDlydHdzWXdHaVYwa0dORlVNWjRr?=
 =?utf-8?B?akx0SlMrdVBONlJWYWp5UFJac3c0Zkt0T1NIeE9PUTlBYzJmMlZPVWFlRW16?=
 =?utf-8?B?KzRRQlZJc3g2RmkzMGZYSlR4MVFtSVd0QllvODkxZ3djNDVKTlJNUjVkTkpr?=
 =?utf-8?B?dFdiUXZKaGk1cW53TlJyZFh1S1FUZmk1SWlZcDZxZ2M2V0lsV3F0cjZvQnlY?=
 =?utf-8?B?b1RkU09RMU54R3dqaGl6cHBBY29sUTkrWjBTV3FtYXdVZzhxYktaY1hXZEtp?=
 =?utf-8?B?SlhVZzRXalN6a1lDOU9mMEs0cGsxN28zZmFMZitVWWQ4ckIva1B1NVZlamR2?=
 =?utf-8?B?bXZLMnU3NmdoczJodnBFbUx5ejFWall4UE53S1o2eXMzMmlpWXJvZHJwR3hl?=
 =?utf-8?B?VUFXb05SZnFtbWRVM0wzaXNhSGp6bVhYNHNwcWNTeWM1RUEvYTdiNjBkSmEy?=
 =?utf-8?B?Q21HY0pLZjZlZlpISmNMSGtROVFXVUo0Zk9tUmRzTGlCZGloZUltWHNjZ3hR?=
 =?utf-8?B?M21OOFoyYWpVbjF5a1VRUnFVdXE2ZWxtZjdZZk5DcGJyVlNhN2lOZzhHWVhZ?=
 =?utf-8?B?ZndYaWp0WjRNZUptVWhmK3BYL2MyTnErNHF2Q3JPakdXbHgyWkVVdDFTVFVV?=
 =?utf-8?B?TW05cS9yMXRHNUNUL3VrVWpoRFd2ckx5MzdxNU8rd2hOeG50akxHdDhZLzl1?=
 =?utf-8?B?clR6ekF3VXd6SXBnR0dvRitFcUdZODlIRUVzY2M2bVpjNGJCcHRFWkRGR2M5?=
 =?utf-8?B?Z1E4V0p1L3dJeHF3MldOM3BSRG5FdSsrSnJKeFhFTmx6MENSbkRWNzU0RlJh?=
 =?utf-8?B?LytFZkFrVGdKSWlrZVVxNHBsMlVrYVpGeUM0czcyQ1FEc3BXTW9BVVVoWDRr?=
 =?utf-8?Q?ldZBA1w1UHSFVpkI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b35735-af3c-407c-bb19-08defd1827be
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 11:02:12.2481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lx/sjLwh6gVAkarZ9bW0NaZQP854W+anvH1+sNR+yQMIQdicDUpR4PvAs5Ii+PC7B9yBQCXImrR+l6gtBCfYb4UmRkVDV7P5jEsciCs8iZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6602
Received-SPF: pass client-ip=40.107.162.89;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 8/11/26 5:12 PM, Andrey Drobyshev wrote:
> On 6/30/26 9:35 PM, Maciej S. Szmigiero wrote:
>> On 26.06.2026 18:46, Andrey Drobyshev wrote:
>>> v2 -> v3:
>>>
>>> Re-design device ownership hand-off (suggested by Dongli).  Do not rely
>>> on SETUP migration notifiers, as this approach forces us to reorder
>>> generic migration code (see v2 discussion).  Instead:
>>>
>>>    * .pre_save() releases ownership on the source (RESET_OWNER) once VM
>>>      is stopped;
>>>    * .realize() is adjusted to defer device ownership acquisition for an
>>>      incoming CPR;
>>>    * .post_load() actually claims the device (VHOST_SET_OWNER);
>>>    * FAILED migration event callback re-aquires the ownership on the
>>>      source after re_save released it.
>>>
>>> v2: https://lore.kernel.org/qemu-devel/57c9c9b3-d758-489b-95b8-d16c258b9b0c@virtuozzo.com
>>>
>>> Andrey Drobyshev (7):
>>>    vhost: add vhost_reset_owner op
>>>    vhost-vsock: don't reset connections during CPR
>>>    vhost-vsock: fix FD leak in realize()
>>>    vhost-vsock: preserve vhost FD during CPR
>>>    vhost: factor out vhost_dev_init_backend()
>>>    vhost: add vhost_dev_set_owner() / vhost_dev_reset_owner() helpers
>>>    vhost-vsock: hand off device ownership across CPR
>>>
>> These patches look okay CPR-wise, so:
>> Acked-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com> # for CPR
>>
>> But the vsock parts still need review by their maintainers/reviewers.
>>
>> Thanks,
>> Maciej
>>
> 
> FYI the kernel counterpart series adding VHOST_RESET_OWNER ioctl to
> vsock ended up in Michael's vhost tree ([1], commits
> 6236e765f16d^..c7bfb8815d83).
> 
> Therefore - friendly ping for this series.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
> 
> Andrey

Another friendly ping

