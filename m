Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA510606A324
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=F43PENAK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLdDC-0001i0-Pb; Tue, 27 Oct 2026 05:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xLdD8-0001hj-SJ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 05:11:16 -0400
Received: from mail-francesouthazon11021121.outbound.protection.outlook.com
 ([40.107.130.121] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xLdD6-0006JX-NY
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 05:11:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDYXC7TBI9nKQHqeCEaSTdc5oEZ/C4FV482PX8rXCvUKENxf1AN7z5e7HtSYQNr6cm1DhVMuvG0TsirY2BuSfkeG42zRAguAKmwT2cIHtNnDyge3CyZFkewPHTtv1Gx6wHAjqB+SU0ntHO+OhPbD1W1wqQjoeZTJeZh0eKrpCcTtx1zoguiUEJiQXBKzDbfbvDCsCvn5Nh6BszYxmwMIKMzsOAQQYPLnHepe70vz7UFpFMLslief6pI/uz391vTtrliI8IXXrmCn3zNmvBxI6kFBPRa2vuh+7V7P5P+L/xNWW7bXR4UjCLQuYbpkx9dRMOai4z1qtZkE6nw9JKtEyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIrumOvvoAnUqUoKvJhV9Kvj/T74OGs6tCOuyjPqzU4=;
 b=kLT0zXjeczjjaHm3m7YTYZnrJh8nfwfRpTrWTTX3AVdvZHPEuCidxPNF0U1WrWcLvB/N4hbjc7gFne+Kwd7CoVEPJ55/f1c53c3t8B0YVLZA+bQbHy9zin8P7Kp0SyAxlXOHRAp7q87pQDHhp1JoWcJI2nL9bf0rWglXUayCYxyUkcvqBD9vnWzQP+k3hxj1+V6GUnmQ5hW/bzoSkOZrmcgCCg998PC6eSn0X7vJB/+5swp0iBKPYqFST1JNXK6S2T0axDxnfUmWohvtipRpeMU3KGta5YW7vnpzyrDF+Kk7xHpYwicCOeo4yr73Ji8hCyM+V+xzNKa/AkHbpD8cZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIrumOvvoAnUqUoKvJhV9Kvj/T74OGs6tCOuyjPqzU4=;
 b=F43PENAKwAclV40gsNv5WXt1pqSfkIud9FoYWWidtVEM/wE1XyS6FTj6zop+mi8Vg+OV2nOsMFZQSYWFK4aT5QHpd0HcArz3jGgQgim1wloFEqZ5+N6hCFYSTyLNgia/3GhJMeN9rX19dJ7qyqc313dw0fqHpLIWc4fstcnadQ2mLG2FG0OrY25ae/mce0sLwnPlqRn4OKLC5X5yl95R0afMavPmLJEvcBjVRulPKwnYY+9lhQHC5HVvfBujAr0aAZEBxTetqjh3uAULlec23ceW/FXjKVSLkL7lLMZuXkzRYTLmAYnzNEJxBh9J2iIgfFiSRaRA60dJ1heM8v2b1A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU2PR08MB10105.eurprd08.prod.outlook.com
 (2603:10a6:10:46c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 09:06:04 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 09:06:03 +0000
Message-ID: <c6460299-19b5-41e8-adfa-640988db7c25@virtuozzo.com>
Date: Tue, 27 Oct 2026 11:06:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 00/22] migration/cpr: support vhost-vsock devices
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, odaki@rsg.ci.i.u-tokyo.ac.jp, bchaney@akamai.com,
 mark.kanda@oracle.com, vsementsov@yandex-team.ru, clg@redhat.com,
 den@openvz.org, dongli.zhang@oracle.com, farosas@suse.de, peterx@redhat.com,
 dwmw2@infradead.org, philmd@oss.qualcomm.com
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
 <35dd9653-bde5-42d8-bcc6-20b692010eb1@virtuozzo.com>
 <e5fbac0c-b4d0-4e8f-8865-23791057c570@virtuozzo.com>
 <05d6cf1f-7e20-4ee6-838d-1e455720df76@maciej.szmigiero.name>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <05d6cf1f-7e20-4ee6-838d-1e455720df76@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::14) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU2PR08MB10105:EE_
X-MS-Office365-Filtering-Correlation-Id: 89c6c20f-f23e-4517-780f-08df34098720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|10067099003|261026121527099003|261022075727099003|261021123027099003|261022105027099003|261009223027099003|261021121427099003|4143699003|56012099006|18002099003|22082099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: wdbUUPTy6x1RIPcE+EFU8F06xQKsFGA6+cJslo6m9ijKGIcXdr4chnHJfCUGlg86ms7ANj0bnEoc7kuSQ6tUAbOCo7smFm39vm96r9w99V6MhcmjPpFZBP+aul69iJn7OG2uQVyLUwyeZigCgAXSAtJhHu2bE/+9xl5U6kobx4mvkBqPH/Un6Zcz1K8i/kiROplxxxQawAugMfe82YFb8PMWDQFjeQwKUOOHG8AXG/MKbvy6z4evIRuyZAE9C7yh1uiXnH+KXSVobP+c+vmp07Mrp3tB4KVf1FHHMVIc5x+Z8PzXs2iEh73b/CQ0psYrF4ToO9toeeF3Wcou0JyMMzMN369cDpnIHj0qogMjjzuKr+4TSwC+9J0j9Md7+3z4HeOgX8aVLh6naGlAixkW4c+nci9ZNTf0YsITUi9XEMvJ6AMmno7JPZ/Q0jlNdwzOs5FcR5T6pj41uh5+PSxfadPg0tcw6+ZIHvHR3SNY+gkESSDs0Q+cZNUgWFuqJpRezJV0M51abk3tQM6xX/xgPzgc9E9ZVlI8Hyt0o2gFkL0M9VosRNWGKSJUHD2YMA6XKwGhdcUODetp/5cgejH/h1E19ENNCX/zYdQsSdyI18gwO5fs3rxpt3vI0NetYOzL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(261026121527099003)(261022075727099003)(261021123027099003)(261022105027099003)(261009223027099003)(261021121427099003)(4143699003)(56012099006)(18002099003)(22082099003)(261026140227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2pvd1hWa0syY0FqdTNzVUFaR0RpeW1hRXljcG5McTdFTG4wbFN0YUhkMG1y?=
 =?utf-8?B?YkFjcTd5MldWd0RGZVVyQjN3TWhRN2c0aWxEM1FRUFpCYm1FU3VIMEdidXlV?=
 =?utf-8?B?QWdTdjA4NDh0WWdocGZoTWNJeHdTb29hdDNVYzNYcTY2emh0Q2dNYXAyM0ZE?=
 =?utf-8?B?TXd5ME5qT04yaWpTcW4ycG8wUzBQckYwallSNjNjUGlxNVZVYTBsMXZWZjdP?=
 =?utf-8?B?c1owNHdUd2dWVVdwVy8rUlRoUVZBM2FJUG5CU0c3bEdNcnViYmsvMUYvZGw0?=
 =?utf-8?B?dGFva2g2UlVsZHdtSWhnOGtaUWNORS95V2FYKy8zdFI3TFlraG50d01CdWxn?=
 =?utf-8?B?b1NTQmtXTTUwMTRxakJkQlYzd1lxTjdoTmVqQ1VHYzF0aE41d2tiR2FyM1I3?=
 =?utf-8?B?endlMzBISk1oaW50eDFoc3d4RHlyNGQ3cFhpS3I5ZHNKN1BBcDNzdkttWllJ?=
 =?utf-8?B?cEFjRkNSY1dTNFBxQm14S3FMdUpDZ0xrdnQ5Q1piNkQ4L2R3ck5TUlNDZkUx?=
 =?utf-8?B?Qm5ta3ZVNjZhUEVOb083UW9rSHBZT3VkMUVnaXdLUExXVURna05QOHFMYzdJ?=
 =?utf-8?B?R29lK3BZbW5NSm5GcEg5NlFKb0EvUnZ3WDRSeGNkZHBJQ2EzdFVhQTFmZ0o5?=
 =?utf-8?B?b1Jua3hIYWdrQW43WERCM0V0ZWFNUVJGZFJ6dG9IWndoVERrdnA5aVo3NG9q?=
 =?utf-8?B?cm5Dai9lYUlIdVYrK3poVGZIY1BHRGY1UnRscCtVMlBuZ2RoUVV4WG1JbGhM?=
 =?utf-8?B?ZGlpanZFeXZPVHVqUUlFQThqcjdBdG1ORGc5KzdlNDVIMDZVRU11VGNQYjVw?=
 =?utf-8?B?MTRhcGptb3RtU3BrbGwvbHpUd1VqQ2hURXpoTTgvdDZQZFFMQlc2eTNDeGtm?=
 =?utf-8?B?YTRidXFGOSs2ZmIvNzNRVWNHSStFZE4xL0Vua0Y0N0p5SFp4dHhhVDlPSnR6?=
 =?utf-8?B?NlVtVi9qOTB5UDhTSTFoWE1PZlhGRWpOQ3JJcXJ1cUg1THJFZnB0NGhXUk1V?=
 =?utf-8?B?K3JoakZrSm5OUFV4VUV5SkNVb3N4aUh0T1BCcFhuQm9nSWN5L0pSb0tYUnpP?=
 =?utf-8?B?UlJlZmEzRVlBVlFEV3VsQlB1V29WMTU3ZWlCMXpjem11T2FBc09BMW12OGtW?=
 =?utf-8?B?V1RUODhHL3F1TXkrNytJYXdETXEzR3VOTXFiVGZ3TGlyTk1wblhFNnRMUDRJ?=
 =?utf-8?B?dmJ0TDF4TXIwUFZjeWM4c2hsOUJjQU1vaW55WGtiTC9yVHBJMmI4U09NZC9X?=
 =?utf-8?B?V0h0UVRsWS9Id0pLMGplNldEYWR3OTlPRHNUdWNleWVmVnp4cFpLemdWS0pK?=
 =?utf-8?B?TkovL3RTUnNFT080djZ5TE5VUnFzakIxRXBLUzFTbDE3M2krcWNZUVcxQlNU?=
 =?utf-8?B?b05rcHBjUzVKaDM5QThDUzlSem1vZnpvNXZNQXJFeEFlRTJwRGlZbTB3ZzR4?=
 =?utf-8?B?YStLdWtrNHd0VXJmTXRhOVQ3M1gzUzFpRWV4ZGgrOE1yWHJybU9pN0JPdHh5?=
 =?utf-8?B?b05LSFgzTEUySFpMeFV1dllrWE9Ddk1BZ05QT2RVRk5PaXhsa25uYStBNEtF?=
 =?utf-8?B?WnJsTHlwSDVENS9HRUgxdDNJdTFENVlMeEhuaWN3bHNDZVYwQWdWRGZKY0xN?=
 =?utf-8?B?OTc4NEd4MkNSNkxNWktDandGV0hQdW1PMmFvK0dKeWVTcGhZRHFFdDdIT0Nj?=
 =?utf-8?B?Qk5zS0FKWUJqTnNrOEtLVDFIeUJyQzM2V3FRZnI3d3lTUWJyV1JINFJwbVYr?=
 =?utf-8?B?YjFwRzM4V3dkSTJKRjJZazVqeHQ4M09mN0k3UjRpQlFwc082VzVDQUQrejYv?=
 =?utf-8?B?dG5adnZxaHNRN3E4T1dkTitWdll6aVVIZDJmOGlNa0h1K2RLd2Nsem5zTWJR?=
 =?utf-8?B?TWVuSjhPQlpubTZML2V3QnlZa2Z1ZmMzQWN5ZFpZOTQyZ084eUJ3R3k1ZXE4?=
 =?utf-8?B?UmxRTnd4OGlqeWVVZDI5czhHVExPcmoyVnlzQVNMSUsxUStvMUVFSzRORytP?=
 =?utf-8?B?d09uY0NSd09qRWNFUU5NQk9OWGVDam51bXU0RGhQUnRuckI5Mk9aeFZ2QlZu?=
 =?utf-8?B?VElmakh6djU2QWg1eGxaSk10YmZlM0ZiQXJ2aEZYWndESGV4c21PL0JmdGda?=
 =?utf-8?B?V1NMQWRLWVRIQ2p4WUxQOVVJNkR0L01CZ01BeWRYVFBBN05hd1NHWXIrdkhB?=
 =?utf-8?B?anFIT2Z1aTJFZ0hXMEpDKzdvYXRmVXpyaHhJT3YrdHRkcHdmOEtrYlFYcmh6?=
 =?utf-8?B?RFJmUlErMDA0dkx0elJST3lUa0NFTWhOVmIydzE0eEZPMzg1RkU4cDBCRXhZ?=
 =?utf-8?B?UFY0eUllMkZ5TXBjbnliQmQ3Y3N6UmpRT3l1VXRqY1dnQklOTlFMdC9kQUt3?=
 =?utf-8?Q?gJ4+NA+eSKnK1neA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c6c20f-f23e-4517-780f-08df34098720
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 09:06:03.7913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ch1RgsXIkTEsssl2git5iadWoutegiu363liyzI2tW5ptauM+WzNT+TfZjH7AHFZ02IIEXW8oyPlYPn9tZezaVDT/8Pw3E7c8NQAjCsmXfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10105
Received-SPF: pass client-ip=40.107.130.121;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 8:24 PM, Maciej S. Szmigiero wrote:
> On 26.10.2026 08:58, Andrey Drobyshev wrote:
>> On 10/20/26 1:55 PM, Andrey Drobyshev wrote:
>>> On 10/12/26 1:28 PM, Andrey Drobyshev wrote:
>>>> v15 -> v16:
>>>>
>>>>    * Patch 15:
>>>>      - replace the errno filtering in vhost_dev_try_release_owner() with
>>>>        a new 'owner_handed_over' flag in struct vhost_dev.  Release the
>>>>        ownership only if it was handed over to us, and report any failure;
>>>>
>>>>    * Patch 19:
>>>>      - set 'owner_handed_over' in .post_load() on the CPR target;
>>>>      - drop the redundant 'owner_reset' flag, use vhost_dev.owner instead;
>>>>      - drop Stefano's R-b because of that.
>>>>
>>>> v15: https://lore.kernel.org/qemu-devel/20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com
>>>>
>>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>> ---
>>>> Andrey Drobyshev (22):
>>>>        migration/cpr: forbid saving duplicate CprFds into hash table
>>>>        tests/unit: add test for duplicate keys in CPR FD table
>>>>        migration: forbid snapshots in CPR migration modes
>>>>        migration: forbid snapshots under Xen
>>>>        tests/qtest/migration: add test for snapshot rejection in CPR modes
>>>>        vhost-vsock: block CPR migration modes
>>>>        vhost: add vhost_reset_owner op
>>>>        vhost-vsock: don't reset connections during CPR
>>>>        vhost-vsock: fix FD leak in realize()
>>>>        vhost-vsock: preserve vhost FD during CPR
>>>>        vhost: factor out vhost_dev_init_backend()
>>>>        vhost: make vhost_dev_cleanup() safe on a partially initialized device
>>>>        vhost: add vhost_dev_set_owner() / vhost_dev_reset_owner() helpers
>>>>        vhost: add vhost_dev_is_initialized() helper
>>>>        vhost: release ownership in vhost_dev_cleanup()
>>>>        migration: add MIG_EVENT_INCOMING_FAILED
>>>>        vhost: release ownership when the incoming migration fails
>>>>        vhost: release ownership on exit
>>>>        vhost-vsock: hand off device ownership across CPR
>>>>        tests/qtest/migration: add vhost-vsock tests for cpr-transfer and cpr-exec
>>>>        tests/functional: add vhost-vsock CPR test with a live guest
>>>>        tests/functional: cover a cpr-transfer target going away with vhost-vsock
>>>>
>>>>   backends/hostmem-memfd.c                        |   5 +-
>>>>   backends/hostmem-shm.c                          |   5 +-
>>>>   backends/iommufd.c                              |   4 +-
>>>>   hw/vfio/container-legacy.c                      |   7 +-
>>>>   hw/vfio/cpr-legacy.c                            |  29 +-
>>>>   hw/vfio/cpr.c                                   |   6 +-
>>>>   hw/vfio/pci.c                                   |   5 +-
>>>>   hw/virtio/vhost-kernel.c                        |   6 +
>>>>   hw/virtio/vhost-vsock.c                         | 193 ++++++++++++-
>>>>   hw/virtio/vhost.c                               | 136 +++++++++-
>>>>   include/hw/vfio/vfio-cpr.h                      |   7 +-
>>>>   include/hw/virtio/vhost-backend.h               |   2 +
>>>>   include/hw/virtio/vhost.h                       |  80 ++++++
>>>>   include/migration/cpr.h                         |   2 +-
>>>>   include/migration/misc.h                        |   5 +
>>>>   migration/cpr.c                                 |  64 +++--
>>>>   migration/migration.c                           |  10 +
>>>>   migration/options.c                             |  13 +
>>>>   system/physmem.c                                |   5 +-
>>>>   tests/functional/x86_64/meson.build             |   2 +
>>>>   tests/functional/x86_64/test_vhost_vsock_cpr.py | 347 ++++++++++++++++++++++++
>>>>   tests/qtest/migration/cpr-tests.c               | 133 ++++++++-
>>>>   tests/unit/meson.build                          |   1 +
>>>>   tests/unit/test-cpr.c                           |  98 +++++++
>>>>   24 files changed, 1084 insertions(+), 81 deletions(-)
>>>> ---
>>>> base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
>>>> change-id: 20260908-up-vsock-vhost-v5-c781b39f1c1a
>>>>
>>>> Best regards,
>>>> --
>>>> Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>>
>>>
>>> Friendly ping
>>
>> Ping
> 
> I wrote at v3 that I am fine with these patches CPR-wise,
> so if/once vsock maintainers are okay with them too it's
> only a question of which tree this should get into: vhost,
> migration or CPR?
> 
> Thanks,
> Maciej
> 

Since the majority of the patches which introduce functional changes are
vhost-specific - maybe vhost tree is the best candidate here?

@mst Michael, do you mind?

Thanks,
Andrey

