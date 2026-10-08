Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34E6CA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 08:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEjiQ-0001uN-3j; Thu, 08 Oct 2026 04:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEjiN-0001u5-Cj
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 04:42:59 -0400
Received: from mail-norwayeastazon11023097.outbound.protection.outlook.com
 ([40.107.159.97] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEjiI-0007SQ-DD
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 04:42:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jr09rrw1WiAxrG+1gzSEZA56OknD6sZe2bpd2piw4twenbOmGFQLrrRgj1TqqUpPu3y2KNonOftLfHcnFuXv/PmAps6S2tIeh4MS0QgkyLXHGZaE2+bHjlk4Y/8TdS5ufaoA0O4Re7Sk+ADbxRZrbi5CsY02P0E9OGyer7i75xr3slbzAvakGfNEAFhaEdAxbM3wPcQAus5WwkfQ05LYd85TwKdaRtkpnYS8rsEq95nJ9JM7eFZNYOYoLj2lDiIVpXXY4csTMcV4mg3Ih0wA1m/Fuh9TqPqfkV8v8gHodsykU4L3xbpb1BaTp2AkAxZBk4M+cSScgXAnYVyU2GfvZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wF74r6cDkgapjmxOJREb/NufpNwejVVyu4NDfH4gGI=;
 b=aiqTHlM88G9IPiJsRUU0E0rg87nRTT32aFUuR0i2/+5Yu0DwXe3ZGwICiKIM70DlkhZ34C47mQrrQfYDi4F06MMOKWf6/oQVp3ye2nBCAYX3bUBZfBSLUVCRxbkTYu6/doWO+bNzmJzqhsN+Hqxvk01cPuANxjhMuFV7mBy3O/Q+y9aNZ7Vn2WqdIXOjo8dzpaaXxzQOAh4jfX/mQQKpjL0CJ9RdfrKBDIoX+kzwTXwQTr5cGymD5uwn5rwO0YknClZAMz8V7vcIphwZey7iJ6FJqmPTAsGq+F4hAsSf2hOLK00CeGo0hWZG2qNBusBRsfyWUoTFfkjjFd7Zfcganw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wF74r6cDkgapjmxOJREb/NufpNwejVVyu4NDfH4gGI=;
 b=o1MtBtj/8sE8JFAaJGyER/Ilaib6VnnSIIK95liJY+pHeoUyPcpB3iaBVG1BChl5zsFYg5EvouBytN/aBFNHsVUOfKU8LSqATodBIPWpEL112DBaDndqFgEQiFJsMUBeDgKY4YBqCn6dvcqEYl2XTYx7FJOOLsf84J0e1z9C7ZprDHgThBdSbimVM1GIXwnD/EdiyldcZ1ou06v9b1glgPisYr0+mTZs84LQ7O7mXoJwx8V5g67yz84Bh5mjE3IwJhG7ioa2pT1lJn4NFV2j0hl4Nrv6oa9EQBG0OYg3xNJs2oYTVMPufieGLIqXDvalcLcC3IPUdjFulSUBaal4OQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS2PR08MB8720.eurprd08.prod.outlook.com
 (2603:10a6:20b:544::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 8 Oct
 2026 08:37:45 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 08:37:45 +0000
Message-ID: <26d93613-15db-468d-9845-9f47d93610ff@virtuozzo.com>
Date: Thu, 8 Oct 2026 11:37:42 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 15/22] vhost: release ownership in vhost_dev_cleanup()
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: dwmw2@infradead.org, mst@redhat.com, vsementsov@yandex-team.ru,
 farosas@suse.de, peterx@redhat.com, dongli.zhang@oracle.com, den@openvz.org,
 mark.kanda@oracle.com, sgarzare@redhat.com, maciej.szmigiero@oracle.com,
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com
References: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
 <20261007-up-vsock-vhost-v5-v14-15-e16de9962df0@virtuozzo.com>
 <ca73056c-cde7-4835-b62f-48d9b498eb74@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <ca73056c-cde7-4835-b62f-48d9b498eb74@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0117.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::14) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS2PR08MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c73965-66f0-48a7-f140-08df25176cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|22082099003|56012099006|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: Sq5ZsIj/hzp8olHmXCHhUqI2p/iwNJC9GCLiaPV3FiRo6oHnSajAxeO3xxguaXezO2nTZvqMfG6lkZEvBjtpkMKDhsGVdwwTEsYtwNBH/dLzUNPKHVML5OKHlJF/F3luDxkuBgC3Fo880nAnPFSwNKfP5i4Uih3IKvARj/nXSkKYNF+p7PEffysZY1nngyj1lE7PzAzj8Fioa5o7VkHY83QAiBeK8Nzy9Yc6sBk99BuG1baOFQ6LrnodYAH21G/6wmcs27gh258ADrzBggg4ILetvGrAlf6YaAeLAzQsA+4p8essEJ6Q4+bSvfcjz2fikany3cobKX7E6AC0Yc7mhqxlbgLfKqy8J3k7PhHOQPg9GFGEsvZ1yoiTxujwXFuMz9DBYJ8hs4vMHLv7PEhm/waBTEjUfNgN0Ee7szz/Tyvq7OQloNcLht2aWkF3T6UbyHIsLX/68mhN2o9fmWhdGmR947MUuQyagIs65FjVdaJ928GMVrFFq1NEwsTNqIjJTpiBzjgYCrwWPkwgjw2CfU8WjAEMabIzwzYroZUHPiM/fIWiki0pegb3XtSK9jE6crTFgS5IjtoThrBaZzsYoHHFe64xpup0MMNJjYVx9jRznFHIYME4+en1R0xOmojy6lvoYKWDnXIXyNNpLRB/Y/pY6bRlwhBp81oNcZ30je8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(22082099003)(56012099006)(18002099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sndxaldaa01HcjV5UHVVYlpDNWJUenNXWVZoQWxuYjJYdU12NEFEdkhRR3Jn?=
 =?utf-8?B?ZkZpeFZIcm9venhEU2lkdHdOMk5zaFNjeUVVSldtbWJMbFpsS0lsWU1DSVVr?=
 =?utf-8?B?SzJxOXBzSG1MZkpUbkNPMHZselF1S2RXQ2c0c0dJaFBiRjMxb3l5T1c2bUIr?=
 =?utf-8?B?N2tLa1NlbmtOY1ArZmpEU3NWOXBaK1AyUkJHTG1sRVY3V1RHcFYzMjF5ak0z?=
 =?utf-8?B?WXBxOUxoUXZId3FOWjZIcTBxRllBY3ZNQnRoMXVSa0plalEyU0xyVW92MEtM?=
 =?utf-8?B?R09IMThZaVMyQS9ab1VCYTluSW1Zc3I0a1lTdHErUitOTFQ4RGxqb3c1c3dD?=
 =?utf-8?B?QUhyZTB1d0tyNDFqM2dtQWFoUlRFSUpiVWZRUXZVMjVwRDU5NTA0bjN6cnNh?=
 =?utf-8?B?Y1Y2dnVib250MXlNbGlCYTlMN3B1QWt0ME5yR3RqYzQ5a056UGR5QVZSZ24w?=
 =?utf-8?B?MkR3VWdRbm8xOTdBRzJ4NlRGTVlHT0R4NHVkbDZnRXN4QlltdzU5cnFoenM1?=
 =?utf-8?B?UHZPNEJUeGJ6MzFDV0J0WFRRVWEwZ3lPYmhneGVqb2J6TEgrZ3g3N2x0VjJP?=
 =?utf-8?B?QTdKVTlsWTNmNXBBcGR3cnpBeFFlM3l1T3N1R1Y4VHlCdG5lNWZJeTlWV2Rz?=
 =?utf-8?B?QjRHejF0eEdLbkdvTWZUcEZHSmtreTJBaGFzM2dEcXdEd0VJaU1jNFozSENx?=
 =?utf-8?B?RkRheXdxOWlyZWhUM2pwTVh4anRiTFZNRGU1ZEwxZm5odDBpMlI5Rm53WUds?=
 =?utf-8?B?azUram5oUmNtQ1RrR1E3alEwS3Y2a0FiUzN1dGFUcjJrQm95NnZsL2sybklr?=
 =?utf-8?B?Rlk0WnhWLzU4SE8yU2k4NEV2SCtYNHcyTUxCNHNSUjZEaHJ6aFJYZ3lRNXpK?=
 =?utf-8?B?VW8xM0IvZEd3MXhPY0ozWDdJd3N2cE4xMnVNSy9hMDNYTXB4VFprMUxCQjhs?=
 =?utf-8?B?Ukdod2RSZ3phMGdoN2JiajVqWW9DRll2Mnp6YSttSjF5UFRJbjVQdkEyMzBZ?=
 =?utf-8?B?NWNCQVZTVUl3TGRRajEvbEtnTmIwOVUrc0VWVktQOWNCekRqeUF5TmU3UEl2?=
 =?utf-8?B?NUJJbHpZL3VFWklxM0psK2VyaVJrWGw3TFhqdHBFMktlOXRFeHNYTGtkelhP?=
 =?utf-8?B?WGNGd3ZXMklqcFlsc3UrOUZCL0plNDdBb1FQcHMxTHpzOVRLTlhaeFhxekFP?=
 =?utf-8?B?VXJqaG5DOUQzSjkxUFNSeUczWVREdy9ycUdoNldEZldRVXd3a1VQOEhOaUE2?=
 =?utf-8?B?RE4yeUF0dm0yTkd6Q2RnaWlSSTloNHJxaStaWCt4WnFEMEU2VURtTXNEKy9N?=
 =?utf-8?B?MW1jeWVRWUZMaGxaOVpFYVV3eFJhNk1KcmFiaG4zSVRZK1lDSFpIZFU0aXYr?=
 =?utf-8?B?MEg0S2hJSHpjUjJhV1JzSk9MMFdXQmduS1N0Um05YWpQQWlYQUg0WDZVVjFx?=
 =?utf-8?B?ZnpqU2NnTnhmTWZnU0FRMEdQY3BsemhHV3dsdEYyeWZRd1RMU3A2N2ozckow?=
 =?utf-8?B?ZEdZWVhnZXVnL1FhMEN0cVRuMFBUcG5XOTd0MHlBZjJZVUR4N3NXNHhOVVdQ?=
 =?utf-8?B?eit4Y0UybHR6U242c2F5Vjl6SG1NMHJpakVjcnRMdmRMemZSS0c0anJCVXNx?=
 =?utf-8?B?a0tUV0loSFc4TGtTcjhPZFVJQU1JeUk5b2FwRG9ob2huZmVvK3dNRW9BeDhY?=
 =?utf-8?B?dm92SElyV1ViTUw0SFF0R3NLSHIrdVdQWTdBbk93bGhoYXJHbGV4NlpqWW51?=
 =?utf-8?B?WWNtVEgxR3g0Yk8rakVSTzBjSHdVODFrQ0VVK1VXNExsMHJpWEJNOW1zN3BR?=
 =?utf-8?B?QXhPelJvajc5Z3Rjb25lRjdWZXg3RWQ1eFdDdVdEb1RTVUtKaW0vSUNzSXJr?=
 =?utf-8?B?bk42TjZTczhJbUVMR1F5NlF4cGhhRmxKTUJrRHpnaldnRG9OMkdXNnBlUEZD?=
 =?utf-8?B?dGNtTjBadTJ6aVJrWlI2cDlYOU5XMW1RUjBHclNxMkFhZE54eW1hSEhaMENa?=
 =?utf-8?B?Q1gzYzdNYm9US2lQeUUzZm9ud2dTbEgxQk1BTFFlTHM0TzMwVkh5ZU9VS0JN?=
 =?utf-8?B?ZGR6UTloN2Y2QWJGN3RSRXpJS0NIbkxMcGpxTkVOQUxBVFVWdzFHc2tOeHpx?=
 =?utf-8?B?dExKV29WQVFtRE4vb0t1ZlZqeExQUXliaEwvWXVGd0ZWMzlFU3JzQkFxNGVP?=
 =?utf-8?B?cFpvMk5QdjE5d3ZPOCtwdm0vUmdZL3dIWVo1Z21IWFFWZHFtODdkNEdSZ3ZX?=
 =?utf-8?B?d2RlNDlVSW96SjRObVRadnVWekpaamU1UitmZ0tPOWl0eVFRclNzLy9CY29G?=
 =?utf-8?B?U1RiVVFnQ1BiUmdOc2ZncjhGU2psSitQWVJBZ0k3MHVaUERuSzB2eXBHaTY2?=
 =?utf-8?Q?2IEk2vJv2S+g85Jk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c73965-66f0-48a7-f140-08df25176cd5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 08:37:45.1463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: niGpIlGOThcBCEhsA9IVxNcwulknvdVTXhviSmTPBf/B67kLINx5/t0qahJKnkYqUp5AkQ8oId/9Ps/O3of4UIac8lqnl4AfUAFAnF/pfoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8720
Received-SPF: pass client-ip=40.107.159.97;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 10/7/26 6:37 PM, Akihiko Odaki wrote:
> On 2026/10/07 17:40, Andrey Drobyshev wrote:
>> vhost_dev_cleanup() closes the backend FD, but that doesn't release the
>> device ownership taken with VHOST_SET_OWNER if the same file is open
>> elsewhere.  That's the case on a CPR target: the source keeps the FD,
>> so if the target fails after SET_OWNER, either inside vhost_dev_init()
>> or later in its caller, the ownership stays with the target.  Once the
>> source is resumed it can't take the device back, SET_OWNER fails with
>> EBUSY.
>>
>> Track the ownership with a new 'owner' flag in struct vhost_dev, set and
>> cleared by vhost_dev_set_owner() and vhost_dev_reset_owner(), and issue
>> VHOST_RESET_OWNER in vhost_dev_cleanup() if it's set, as the common
>> teardown for all those paths.  That should be safe in any case: the kernel
>> refuses it from a non-owner, and an owner is about to close the FD anyway.
>>
>> Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   hw/virtio/vhost.c         | 24 ++++++++++++++++++++++--
>>   include/hw/virtio/vhost.h |  5 +++++
>>   2 files changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index c01ccc800cb..3432b9a43c8 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -1705,20 +1705,32 @@ int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
>>   
>>   int vhost_dev_set_owner(struct vhost_dev *hdev)
>>   {
>> +    int r;
>> +
>>       assert(hdev->vhost_ops);
>>       if (!hdev->vhost_ops->vhost_set_owner) {
>>           return -ENOSYS;
>>       }
>> -    return hdev->vhost_ops->vhost_set_owner(hdev);
>> +    r = hdev->vhost_ops->vhost_set_owner(hdev);
>> +    if (!r) {
>> +        hdev->owner = true;
>> +    }
>> +    return r;
>>   }
>>   
>>   int vhost_dev_reset_owner(struct vhost_dev *hdev)
>>   {
>> +    int r;
>> +
>>       assert(hdev->vhost_ops);
>>       if (!hdev->vhost_ops->vhost_reset_owner) {
>>           return -ENOSYS;
>>       }
>> -    return hdev->vhost_ops->vhost_reset_owner(hdev);
>> +    r = hdev->vhost_ops->vhost_reset_owner(hdev);
>> +    if (!r) {
>> +        hdev->owner = false;
>> +    }
>> +    return r;
>>   }
>>   
>>   int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>> @@ -1864,6 +1876,14 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
>>       g_free(hdev->mem);
>>       g_free(hdev->mem_sections);
>>       if (hdev->vhost_ops) {
>> +        /*
>> +         * Release the device ownership if we hold it.  Needed e.g. for
>> +         * failing CPR target, so the source can re-acquire it.
>> +         */
>> +        if (hdev->owner && vhost_dev_reset_owner(hdev) < 0) {
>> +            error_report("vhost: cannot release device ownership on "
>> +                         "cleanup");
> 
> Normal teardown produces a misleading ownership error. vhost-user and 
> vDPA set owner=true but do not implement vhost_reset_owner, so the 
> helper returns -ENOSYS. The new cleanup diagnostic therefore reports 
> ordinary cleanup as a failure. I reproduced the message with the 
> following test command even though it passes:
> 
> meson test -C build --no-rebuild -v \
>    --suite qtest-x86_64 '*qos-test*' \
>    --test-args '-p 
> /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-net-pci/virtio-net/virtio-net-tests/vhost-user/read-guest-mem/memfd'
> 
> Regards,
> Akihiko Odaki
Ah, looks you're right again.  I just noticed that the error goes silent
here and we better somehow flag it, even though we can't do anything
about it at this point.  I guess we can just ignore the cases where
either the backend doesn't have the reset_owner() callback (in this case
we get -ENOSYS) and when the kernel driver itself doesn't support
RESET_OWNER operation (in this case we get -ENOTTY).  So smth like:

    r = vhost_dev_reset_owner(hdev);
    if (r < 0 && r != -ENOSYS && r != -ENOTTY) {
        error_report(...);
    }

I'll post this if you don't have any objections.

Thanks,
Andrey

