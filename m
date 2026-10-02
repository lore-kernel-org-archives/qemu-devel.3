Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C04BCA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 10:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCaYs-0000iK-Mc; Fri, 02 Oct 2026 06:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCaYo-0000he-90
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 06:32:15 -0400
Received: from mail-westeuropeazon11020120.outbound.protection.outlook.com
 ([52.101.69.120] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCaYm-0004oA-CX
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 06:32:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXw7o0n4BYyydsg58HfkFJily+lIq8PS+qU0iGURLi5AZa8WZ2DPybRQdOSJ+werm7jc7R0MgBLr37jvGCzHyqshfy6Qk5z/NOvWh9k/rW9Xf2FTdM7jpqQ2u9LyMzyb+be2MVfnU5rZ5YS4j4TapqQpGiz3F7y3oYwVcELCR6CIcfxlK5JaIKtdRLlXWFGUlFUHMTWGqQ9PMUaKMOTKpvcydsxQgRgzYW+LKEEhub8RnbRCFv6tgt4uvcpNKnzu1voWxqcnAhXR/wtOQ2377CYfGKqwqLuz5jqSqacjPPUB0dfHPA13YB4sa7vMCAGBGQTjcWlIDTMm0IdtaqaUQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5h2a9wDnu4kK5j3Bl+ldXqEQOkCy2b7XekZCyZMWFE=;
 b=AUBqwiUPRSXX9PFy2lQ8jojbjZg8ak3a9WPDXPWjnu6e90n5con17zlWepQas4hSenJUGeV9eFHXVIhLJERj6lqmS5LWeg1y5Xwze6HPYmrBJPr6Y60rGOLg8F1Rzy/Bie/OPy6xhWBBrrpabNYYuKB/qf9V51zvtgDlG4OvkD4bcjqF7YRRohDJdPxAQ/Xkq8+XbGLRT1RzfGdi+tVZmpC3bCgLdUEPSpRhu0U9ggzBeMZwzyZqY5F909N82d+mIg7RRs3vyXqayMiixVppkEzN/Z5PKky72kn0puG9lDeNXwz3dNMq54VWfTcYaH/aKY9RMG/be+MT2Pb42FeTSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5h2a9wDnu4kK5j3Bl+ldXqEQOkCy2b7XekZCyZMWFE=;
 b=nY5P6plPozjMW175SItBS4BpJgDn6vfM5JpGQjI+ol5fGd5ndVjrli3p665pdFoa3okHfNTHYs1cpY1iG4Ow4mpneN2Qc3Y5yw2UsMFG1qOk4idSXCrZxicX3fYof8njzTWRHaMqav9owxHmzm2rPOzF75H4g6Z/AYk8uJaSAr4iXczK3APAwQem/txXdKdSKGmZj8Cse1qV+uctjhAYxpHZ2OHDF9auRqLUJBOXARawws6du92s6Rg13sKPNtWACNyFERzhaEiRrlDApthb5dSnoTMwz6QpTRwn1axchIckrAWOw785+dYGYEjsEx573RLAntimRcBo8i8F84d0sA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS1PR08MB7585.eurprd08.prod.outlook.com
 (2603:10a6:20b:471::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Fri, 2 Oct
 2026 10:27:04 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Fri, 2 Oct 2026
 10:27:03 +0000
Message-ID: <c8a4e48d-77ee-42a5-be7a-41fc8a7989a9@virtuozzo.com>
Date: Fri, 2 Oct 2026 13:27:02 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 15/18] vhost: release ownership in vhost_dev_cleanup()
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: den@openvz.org, dwmw2@infradead.org, peterx@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, vsementsov@yandex-team.ru, farosas@suse.de,
 mark.kanda@oracle.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com,
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com
References: <20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com>
 <20261001-up-vsock-vhost-v5-v10-15-8c094843e98b@virtuozzo.com>
 <44332097-63da-40e8-9908-d0535b7bf8e8@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <44332097-63da-40e8-9908-d0535b7bf8e8@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0039.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::16) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS1PR08MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e12faa-cf43-4a0d-c1f8-08df206fb3a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|1800799024|366016|4143699003|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iRmiHD+jNEX1ksHzjBW0VaQQHfxbEmfH32lywazahZUpEuU87SIVgOkAzXCxWHtDzIFm2JehvCAqGBJCFUbCX5dDcN85VqVzK42veCsVbIejaQBxZzEPEPRMmZ9t1Z5WO4Fq4+OhTuCkI20nJCi1Q8cca9NkEetBQNlMYPbzFpyCIGmC+CI50aO1703cjKhrfGI0TT+uKAMRsE2LyanCf73/J5N8ataTFPRUZ/I1K08iYZTvXp6abUxKKtRmtebEes1BByY2QdyZMQIGqu56UIrWUw1vWdDaO0E9NFPwt1YuLYA/xqxVlFA991BvV3MQKVqrEBMXB3Em6cPbKKxHrJoCcupqPUSKYxELCVAHS+9KJkctSEiZJ4JGwiwFdWUbKMM8aJJAsPquYkMcTmBQn+ZHgp9hKzEeZmJBcNtpY2sot/gjlQ9dLwbc7goZjn4jEbWlmTO+cT4dPS6lJbCIlBhv3PrzwpHOTIK7K38fA64gf4zqbs74xYpdb3wR5DBe+qoQhIzhRfRZfbVeVBw0jOeYlWl6YW7GDCH2D8oxPpt6wPcHwISALy7kawyH8McfIm69lFpEawRaomj73A/4MhghngbW1di98CkcL6P5w9PK7/hS7Z0djIHSHsayqI7NaOP3QXUP4nTIC5oM2MNrPV9n1ci46rcFKx8mCgKU5Nk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(4143699003)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVcxYXNOVVpwQytMRkZOYkNLQ1oyRG5VdzFyZmtyeXIzbnM3a0t1bVExM3oz?=
 =?utf-8?B?N1VTaEFBbWtwZC9zSkx6dmpIUjVHTmZGemVUL0ZPRzNyN0VoZDFpT0k1MDBK?=
 =?utf-8?B?b05vb2lvR0Y2VTRHRVZvYU5La2Y4WUpjeVpnb2JWUnpiRThXSXgydlRGY296?=
 =?utf-8?B?TVB3L3RLeWdrTFI0U3RGZEdGdzQ5L2YxVlFpTzA0OGtHcm52a2pXejNoTGFh?=
 =?utf-8?B?UVU5RGxKdERmNFdwS3A5SjNINkxWY3RqNmY4RGhqTE5PZDJaVFMwVFdRZzBY?=
 =?utf-8?B?T29jVFJNeFhFSXdNOVNuMElvSUl0ZnNka0dLNUhkR1hPTWJCMmtUQngrcXNW?=
 =?utf-8?B?ZU55NDdkTFJ3ZC9LWnVwcmk3S2dmdnhjak56TEVrLzhGdWx6bkdhSGlyVnpW?=
 =?utf-8?B?R1ZYRHVITFlEVnJ1Lzl4Yld0WXMzRnNDVmsxQVR2OVVlVk1YaXd5ZzdwUXJs?=
 =?utf-8?B?RnlFY2szcUNsT0FBaGZKQ2xXWDlVVFIva3pjOHk1RVdoR1hPNEFBS3FFWG9Z?=
 =?utf-8?B?ZFVRRjkyVll5dzYyb0llUERFayszbEhWQ2lvR2tZdEIrYmZCamhGNC9sbTIx?=
 =?utf-8?B?MExXQ0tXaVhOR0c2V3hkMTZnZUtuZnBGYWIxWnBIUm9WSXVBdzVNT05naG9C?=
 =?utf-8?B?aGY3Rmtla0pLYVkySEQzZ0RyemlBNjlkRDllTll1dGd3a1ppZXBHVDNDb2U5?=
 =?utf-8?B?ODlWaDZrakhhUm5UeWJlcXdNWWtJK2xrTHM3ajg3cWVMNTF6b2NMeDBnY3Bw?=
 =?utf-8?B?WmN3ZFBLbDVRSmd3YlFSUXdmaFhsY1FkRGwyWjdhN1BPY2RIajdhbWF2STRI?=
 =?utf-8?B?NU9BQm0vNEp5c2tRaHpnSmFPU0JnNStKUGVjRWJ0RlVZWWF6S2ZEOHh2TjVB?=
 =?utf-8?B?SzZyVjJDZkRCN1RKSDlOcWhlV1hseW5rQjFMK2hBaUIvV0svb1BuNGJqZEtz?=
 =?utf-8?B?QjJhZXJvOUZ3RU9EVzZHTDVvdzJxK2ZFb0lveEhneWM2ODk5TTVEbkVaMG9s?=
 =?utf-8?B?V090QjRMYlkrS205K1ZmUmFTNWRQeStwUnU0RTIyK3Z3cm02SndsYjh0aGh2?=
 =?utf-8?B?QndrNFRycmRsQmNCb1M4emNJOGxldEZRMFV5QUdyOVBwdmVXL29jN0s2aW1U?=
 =?utf-8?B?c00zUFh1Zjh6SkFEZGtJQ2p1TU1QbW8zTCs5UUNrcndJMzBzVGR5MnlZcmkr?=
 =?utf-8?B?R0NodzZ5d3RnbnRxNXdLblVjdnhNa1VnbXhPZDJFM1hqd1B2MitDZCt2c3Av?=
 =?utf-8?B?alovcUJKc0FlNlF1K3JFNW9ZTEhUTHVTL0oxanhVTEdNMlhCTEJ0VXRDcmw3?=
 =?utf-8?B?SHJuRFJNODZiNURJUXpITXZqVy85dG92KzI2MlQwa1N6UzFyeWNFWkRYVkF3?=
 =?utf-8?B?ZzZyVjk4WW5yaE1KdW1xTUVQTHU0Y1BHWEozUE1QUkVmQXkxekZ0UVBzckdo?=
 =?utf-8?B?UUQ4RUQ4L1VjZnZZMzA3bGx4dzRxaHM5elNsVEE0d3NqNGRLanRKMERKeGRj?=
 =?utf-8?B?cThuSDF5NlBDdWdraE4xbTk1U3RFWk5TdFNtQU5FK24vempkMSt2RFNyQVBy?=
 =?utf-8?B?Yndhamc2MzJuRVZRR05tczNqZVdzdHhvSVFpSHh4RkVLZjRBenVUeHlPTmtr?=
 =?utf-8?B?RlplR3BpWkRNSW1lS2ZORXgwUG5DR1p5cVFFazNrOUhMWUJnbThsejhUYWdL?=
 =?utf-8?B?RXFwVTQzQnRKelVpeVAzbXVISmpzVUhmTjYyWFBVZ1FlK0paSTRhL0M0RXBI?=
 =?utf-8?B?cVdRMkg3U0NYWWhwNzlUQS85WFhia2lsalNhdE9yV3V0bko3ZEduL2NTdDJ3?=
 =?utf-8?B?VlRyV1VTbEJvcHcxRGlUUThmbis1K2FweXRsdVNIVTZpL1B0a2FqZnpJdnJ2?=
 =?utf-8?B?ei9KckVLdnlPZ2pXcnFmYlNXNmcrTUh6TkYrZ3JYOG5QYWp6Q2tQYmVIY0FB?=
 =?utf-8?B?OC8ybUdFL2FuRjBuSm5MYlcvYjIzVERKTVBhZk1sU3lxZ2U1TnpORTArelB4?=
 =?utf-8?B?bUdMUzRXV1lUSExHK2pwRkVlTGZ0MXJMUlpMMm1WSlFHN0dLVE5HdXdDSmVV?=
 =?utf-8?B?OW5md01xVGNPRHBzRXBGaG9xRngvN0hrTytCcjlMdVV6R3ladWg1cXcvTFJV?=
 =?utf-8?B?TFhRZlJsRjQ3b3VrY3lucUlGSTVMR0JzYlgwV1FUUHE4WVllaStEMzlyMXlv?=
 =?utf-8?B?QTgzZjVKcGxUZXgrK2hXbC92T3YvaUZNbktXUEdsMUFZSXlmQWNFOW5rTzJj?=
 =?utf-8?B?V2Q3TXRiNE52YU91emdzVmIwWFhsamhJK1Q0Mmo4WlJIK2N5OFZnUzI3ZGF4?=
 =?utf-8?B?N2RsdTdsUHBWTERqb0ZVK2dNM2JYR01jT3A1c2dxNmhmaWIxaFJYU0dmZkR2?=
 =?utf-8?Q?DCOCSk8zg7/dUgzg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e12faa-cf43-4a0d-c1f8-08df206fb3a6
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 10:27:03.9241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQ6EbHazOtZ6sR7CKYx9DN1PVpqH7LRqBMWmFOPcwa1jM+yixvOlWjSS1tFfh0oDml/ZExjIlQk9nsOQSSv9EPuVQHwLRKjgIX2ZOPtaDmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7585
Received-SPF: pass client-ip=52.101.69.120;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/1/26 2:04 PM, Akihiko Odaki wrote:
> On 2026/10/01 17:25, Andrey Drobyshev wrote:
>> vhost_dev_cleanup() closes the backend FD, but that doesn't release the
>> device ownership taken with VHOST_SET_OWNER if the same file is open
>> elsewhere.  That's the case on a CPR target: the source keeps the FD,
>> so if the target fails after SET_OWNER, either inside vhost_dev_init()
>> or later in its caller, the ownership stays with the target.  Once the
>> source is resumed it can't take the device back, SET_OWNER fails with
>> EBUSY.
>>
>> Issue VHOST_RESET_OWNER in vhost_dev_cleanup() as the common teardown
>> for all those paths.  That's safe in any case: the kernel refuses it
>> from a non-owner, and an owner is about to close the FD anyway.
> 
> There is one minor counterexample: if a second netdev receives a 
> duplicate of an already-used vhost-net FD, initialization fails with 
> EBUSY, but cleanup then resets the first device.
> 
> Regards,
> Akihiko Odaki

Hmm, IIUC QEMU itself doesn't dup vhostfd backend FD provided to it by
the management.  So we're talking about the case when the management
(i.e. libvirt) dup'ed vhostfd and provided same backend FD for multiple
different devices.  Correct?

I didn't think of such config cause it's clearly illegal.  However I
agree we should probably be more error-prone for such a case.  So if we
want to have this covered, then I guess we'll have to add another flag
to 'struct vhost_dev', indicating whether this particular vhost_dev
instance currently holds the ownership.  That's pretty much what Stefano
was suggesting in the previous thread.

Thanks,
Andrey

