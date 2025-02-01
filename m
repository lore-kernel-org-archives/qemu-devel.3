Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA976C0218F
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 00:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1te13m-0000lC-66; Fri, 31 Jan 2025 19:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>) id 1te13j-0000ku-68
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 19:08:27 -0500
Received: from mail-bn8nam12on2061.outbound.protection.outlook.com
 ([40.107.237.61] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>) id 1te13g-00014z-1r
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 19:08:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmLDSIdiykUPiAqCqW5KT1Xa34wspfN1/XT0jBwt7UXX1OVnswgm6gM440HAdhT3Xk38a26jlOcE3QNeOd84/clqjppo3ynkhDsFtDatkdDpYuqoorgn9eSHMI9xCf1d0SmRIMrksN91bGtOKf7cjqRec7jsl2h7njwFJYlgw8hMFcYOPMyn3cqTxakatFVgAeIIgmU7HR4t+/fgjyw5lVaaXxbL+o96drf9n4DU7DDN5KbZNo+byLReRPoqLZZgrQaQG4n+Fo3XqW08obvdRR8MN6flXgEfecKwnlbBPnq963RWnkTXXHo5ZDYD/IRwyVZrt+0GWX0/Z/t1GPuXKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uaenxmyi9IRfNlyHFN+yPIzm1VGMAewk/r8T0d/5heM=;
 b=Zx7CjcOk9wIXdM95LvfmCYre9kcHrOkIRdD+dsq8FxVVBIb80xZFkx0aeUPQ7oDot6YtJb/P4FKAQx+BUivaxKjHgmTLGGx7CL1ScbdHfJ6NNRxlGNDA/C1jOPCzHZuJn5Xj5dGosg/8n8gUXsuPgvI8tiLtJn/oB6Clx+u8FZ1FBbSwPTBkO/VWdqpZIjoclgpRzq5JXXJiXrX7xHKJaJLBAHhPjNziV2FiAE5uhTKUML+sZyrfmORd68MCiNDUHL9v4ZZeAL3h8zKMuSwk4ObrV0VEiJxhjv/ZAvM7eagtcQ9f4QYYdB6h2AWhgVbdbS6VP/eVonqqsvCnfdPReA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uaenxmyi9IRfNlyHFN+yPIzm1VGMAewk/r8T0d/5heM=;
 b=uMuq6DtzvwYMQ5UTNPvDhFYU6FiTSxrdLzkY1RiwVED0vRVlQnwKKQyNWcW+21nvqdKfil5jqVV58vjHii7ZwOQtBjuURFJtLMcPsHU+Gc6tY7gDN9TQzXoKm13Gk9tImvxqwSCTXs89K4q78bGuRsdaLv9NsoB36iKfnBetZbUfGpm/RnzuwEiOq0Q+nxOyqczDbvYy9cy1fLqhLzO731O2HYSI8GKrk4ia/2iK3n1MfharLq5K692jZRXYS4XRVNxQxnxJBy5oa7BB7RbON7bESrW5B4wbzJSGbdgPXMo3UL/pPYS8ZSoZc2J7brWoKzqbVkeaZE/3wj6nVo2lIA==
Received: from MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19)
 by PH7PR12MB7843.namprd12.prod.outlook.com (2603:10b6:510:27e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Sat, 1 Feb
 2025 00:03:15 +0000
Received: from MW6PR12MB8897.namprd12.prod.outlook.com
 ([fe80::7c55:5a45:be80:e971]) by MW6PR12MB8897.namprd12.prod.outlook.com
 ([fe80::7c55:5a45:be80:e971%3]) with mapi id 15.20.8398.018; Sat, 1 Feb 2025
 00:03:15 +0000
From: Matt Ochs <mochs@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Nathan Chen
 <nathanc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>
Subject: Re: [PATCH] hw/arm/virt: Support larger highmem MMIO regions
Thread-Topic: [PATCH] hw/arm/virt: Support larger highmem MMIO regions
Thread-Index: AQHbcZ4NVBrM9t9rn0KftTkrAnTiqbMscwGAgAAEbACAADxXAIAAr2MAgAAEI4CAAAFNAIAELYKA
Date: Sat, 1 Feb 2025 00:03:15 +0000
Message-ID: <2C5CA04C-EFBD-443B-9F57-BE6E8F839FF4@nvidia.com>
References: <20250128160237.3379569-1-mochs@nvidia.com>
 <73f3e4cf927845809c6b10424c00c0ff@huawei.com>
 <cb91da0e-9163-4e59-a060-4a76a077c5d5@redhat.com>
 <BDF4F631-8A96-41B5-B7CE-2BD631C23A2B@nvidia.com>
 <0d303a69-0779-4309-9c00-c76afc82d324@redhat.com>
 <188a25cb7640462ba1cb81456a2fdd90@huawei.com>
 <7d470652-6439-4b5c-afee-d74826ead969@redhat.com>
In-Reply-To: <7d470652-6439-4b5c-afee-d74826ead969@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8897:EE_|PH7PR12MB7843:EE_
x-ms-office365-filtering-correlation-id: fcaeeb8a-d2dc-4be2-ec7a-08dd4253d3c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SEdSdDY2RldReHpCYjlOODRxMHEwSGtXWGFuTlhYR1VWdGU3S0JGR3N4Zzcx?=
 =?utf-8?B?TGJ1RXAxbStESHhwdi8vTDdUOTZVd0F0VGFyUVkrV1pLV3dwcFE2TzNINEpT?=
 =?utf-8?B?TmZEdi9PWDFDWkFjS2IzSEJvL0E4a2xPMEIyZ2R5N25ueTJhOUxOWTQ5bFlB?=
 =?utf-8?B?QzdOTEF1bnFSNHJsUk5OY1JuYXN4WjVjL1lxbThNcVA5VUdWYzhqN0N1VG1r?=
 =?utf-8?B?M3hESEFGNlI3SWFkUEpRUkN3dDRmVFNOMy9POXIzTnYvZFRJU3JNVllCcDBF?=
 =?utf-8?B?b3JjTlFaeGNjOEx3MXI5K0lMQmZmaElQaElXK3VHQk54aEhNS0tOUUxFdjBW?=
 =?utf-8?B?cTVhbFYzNmdvcDQyZVBIL1NudytGMjlRYno2L3ArMzVoeEFpY256YlVkdHZL?=
 =?utf-8?B?bkw3RzRTSE4rNkNVZERjTlc1Vm1iV3dWbFJJTjhKOHZ6ZUwyVDA1eHNpM2xS?=
 =?utf-8?B?SGlwTytHL2Vlc24vMWhXS3UvZWZZV0RSZ3U2TE1mcDVqTWwvYTVtUkFTOWFr?=
 =?utf-8?B?L1BWb2pQOTZEYmhyUGJjbzUwZk9KNmoxamFiT2tsSGtEUFhmdzUvYlhtY3Er?=
 =?utf-8?B?RWRWTzlxT2cxdU9wQ3o0K1Q3bTE4a0F0Q1R3QitPMVVnbmpLejNxbWhKTE1D?=
 =?utf-8?B?U01LUm1TMFRDc2F6Sm9WSm5FSitRZ214QXFhQnhHYVB4NXhtYkVhSGdNR1ZW?=
 =?utf-8?B?bHJMZlRCZFdWcUV0Y1c5aDMxeGRFZVhYZGlTSUdtZ0ZGeGFPa3BlbnFFUWFG?=
 =?utf-8?B?bXhCdFRNTHlHWHNXZ1JFcVB0M2NQSlh1MmQzQkpBV3VkS1NCaFg2bU92WjlZ?=
 =?utf-8?B?MmJ4K0E2QUxydVJiY0luZmxYVzI5RFJ6djJpbS9meDJ0TzZzbVdLa21xYlov?=
 =?utf-8?B?YlBCNktEZElYRkFkdGRlc29qWmkvbUVTRzhwWHFkcTJnbHI4c05uN2VYc1Qr?=
 =?utf-8?B?RWhyYTk4OGk0UitHYlRsMUFJOWFDRlVuQnRNeWJGQ0J2Wm0rL05nTXl1dVVI?=
 =?utf-8?B?T21obWVCYXVKVyttKzFlYlNJYnBrZW5BQ3J0TDQwbVpVWUVQeXNKZTNDMk9H?=
 =?utf-8?B?UmVsdkxCZitKTHFZQXBqUHZJKzFOdXV0UjZKbmMvQjZRSENRS2htL1ZTbmNW?=
 =?utf-8?B?S3FOYVphRXNIaENXZkdDQ1IwTTRKcnB5bE8zNjRrU2EwODdqZ0JBQ0xBMHIv?=
 =?utf-8?B?amFTc1ZtaHdBNFhpeTRrOU9hVnRteGluZElxMzNnU3VzeU10bzJ0UUY3UTlG?=
 =?utf-8?B?bWxwK2FJVU9NWFc1aDlEZ0JPNmhDUUtSWDMzRkVsS0UzalpHUXdKUzhpOW5Y?=
 =?utf-8?B?ZzhzN3RBKzJtUjF4NE5ZZm1uSi9lRDUzcHEvSjV3MGJCQ2dXTDNYUXA5Z29Z?=
 =?utf-8?B?alJKamZacVU2VjYvd01BVjdkc3Z6dzJ0RkhST1hBRnRUZnBOSE9CTHk2Q3BH?=
 =?utf-8?B?VzVqdzAvc3YvTk9LTEN2Z0RzamRlZEdBWXF5T0FUQVVuTjFOOUd2M2VRQXdR?=
 =?utf-8?B?aFlpdVJ4NWtRby9zRkpJcVFvTzJIaDNMWHdLS0R3aHgzejE4bnNKd0F1d2RX?=
 =?utf-8?B?eTMyMmFrOWZPdWpMNnZ0dVkwSVlLWjlrUFl6ZmtRUld4VnZ1elBIZnBZYXhQ?=
 =?utf-8?B?QmlaYjdJUFRtcjNMZldWak9rblVPcWE3QjFWdVZkOE5TMThBMFUxS04zVFRG?=
 =?utf-8?B?bkNFL3BlQnJJcmtObjJ4dGNUbVFnaXY5WXp0NGQ2NEgzR095ZXBVSno2T1Bw?=
 =?utf-8?B?Q1k3QUNQN3RBcFNETWlSRFdkdldzZklwNHdkMm9UQXM1YVZhWjkzNmcybXht?=
 =?utf-8?B?WGk4aUttT0kvSzlhUmg5WWpSM0x4eEhBdlVIbWlra1QwSTI1ZlA0akVORGxQ?=
 =?utf-8?B?K2lVWmNuKzBGZTUwbjBmU3NhY2tDbDZBbThvdVk0T2pOT2hpRWRHKzBSYUxY?=
 =?utf-8?Q?dtDRICjThTaVQFVJd/9f7UPrxkRX7/7f?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFBPUjFRSVZiVFZKMjVSMVM0SWtRTHFVU0N0SlJZU1lXN0tDak55cENXd2k2?=
 =?utf-8?B?ajQ2YkdydHNzUE1wYXpYcDJjYmduTkZrRDBtMENOYVpOVVVjdThSVDA0dFpP?=
 =?utf-8?B?bnRVeDkwRW03OEovdnRnRHlwcU43cGdwaFlWdXZCVTdlWG84RkY0TXYxUWx4?=
 =?utf-8?B?SVNSc1BBeTdCeFA0bXhVUFdYc0VyTTZSU2pONFh0SUVTeU0vVy9DR1lUdFVT?=
 =?utf-8?B?VFNQYzlLZDhsNWJVR1FlQ045TEliUHgrSFVyc0pISXZSYzJ2RFI3MHNHUU5Q?=
 =?utf-8?B?N0d0anJlbHFLd2E3SXZnc2dwbm9vTFFrSjlBcG00NERDKzJrMmgwZ2VDS3dR?=
 =?utf-8?B?Tnd0Rm5yWU01UUE4REpmM0s4bzFZbVFxd1U3M3lRTDc1ZDJBRk1wazRGYmk0?=
 =?utf-8?B?TU1CYXp0RnBsT1pGemJOamhyVTYyQzlwZmoxdjhsUGVqamtHVno4RWwydEQr?=
 =?utf-8?B?OGFZT3hYc1JydktVd29ldStoT3IzNVpRNEE4cjA5U0M4cWU4OEJpNFl0QUxz?=
 =?utf-8?B?L29zWW9DblVUY01IanY1QVJDUzNYUnUxT2NtNHZZcnVWSnRkV1VnVEZDRndu?=
 =?utf-8?B?aUxpaEpUWmpxckRNWW1KanM1QXNzYXpUL0dkc2Nac25NdnppQTMvdmY1eHJD?=
 =?utf-8?B?UGh5ZSt5Rk9LZlVCcXo3WEFOOVpZZ2MwcEtRajRVdnkxcUlRZm16MzBPeEMw?=
 =?utf-8?B?b3R0MUkzMkVJZDV3S3QvTHY4YllySDErZVR3SmZHby96L0duUmdGR0VFSjhC?=
 =?utf-8?B?TzEreHpKZFI0OXFRWUYyZ1YvOHRPMGcya0MwckwyVlJHZFdEZndlS2E4L2h2?=
 =?utf-8?B?NTA4enBmQ3BSa3UrVURUQlovNXU4c3ZrTVUwU3B6NGtGY3QzZE90bEErdnQz?=
 =?utf-8?B?UlhGd2JFRHl5VGdMbW8xMEY3a3lDVFp2N0hqMnNUYUtocUVLSjBodWI0NGgz?=
 =?utf-8?B?ZUVFakdjWTRqZ3dOY3NKenU5L2dhc09sOVUxcjNGWkpQMGZrZGRRdEVuVmNy?=
 =?utf-8?B?Yld4d096MGlIamk3bUlFbnd0eHpwUDEvcmw2eDlVNGxFRy9yUDZPRVgvOUt6?=
 =?utf-8?B?WE1rZHdFeE9WckxHSkdpNzNML1lvNXRzYUVSZGtpcnd4M1BaMXJJNHZBcXZp?=
 =?utf-8?B?QVgvUEhPMmh2K0xOS0xOQVhKY3lvdXhqTzJjMG1LQlRIMFJDUDZQT3pEN3FI?=
 =?utf-8?B?c2lsazJFbU5ZUGEzKzYzbDU3WUJGWEpsY0t3VkNqcXJvRG0zY0VIVWZFVnlC?=
 =?utf-8?B?K050WlJsNG1heDBJRUpjbVg3RGpzWUkxZjdiNjZWVmdGTjVoMUtHdkVXdEFn?=
 =?utf-8?B?S2RsWENQSDNGWVRRaUhhejYyTmtSYW5rRXFVRWZrT095SHdJWFArY3kzTTl1?=
 =?utf-8?B?NExhaDJ4Wm9OaEkrSkZOaDZXTjRoeXdoaVBnNlVOQzRWUyswcHhNS3d3ZEND?=
 =?utf-8?B?aGthMnZoaHNnVHhhUzhPV3ZSMlpydmJUSTBBeHlpV09ZZ2MwWDVycVI1Z29X?=
 =?utf-8?B?U01tRW9jN1psdGNXSC9rWDNpK2NoVlV1ajVqZHZ4WjFCZFZ1M3hBSGpVUnor?=
 =?utf-8?B?SFVMckFUME1aQmJWb0tod0NaeUZKZUc4c284U3RWd2g1M2hXN1djOHpTSW94?=
 =?utf-8?B?b3FRNXRSMDRJaCticXVJN2U3bFk4VStaS1lkUEh3QkJOZEtMTG1UZHRXSmov?=
 =?utf-8?B?RHA0MDlDckVrblZPZmRQRzFEWVc1dC9EbzlHc0pSUllzYkp3SXB6bWdtZ3JX?=
 =?utf-8?B?OWh5ZitObGw4R3ArNDRkTXNKcWVwOExpall4L2R4M0F1VmhiNFBNM1lqQ0Jq?=
 =?utf-8?B?YkFBeFJQc0ovdHQxbEF3MGkrZ2R1cDZTSDdoMDBwWlUvVXpua1I5MiswTmE2?=
 =?utf-8?B?VlQ2NERabmdlSkZaVjVwbmdPNjhMOHZlMzg2OXdoVkxtOWlZWUc3ak5QK3hM?=
 =?utf-8?B?blg1em1RNjAxWjcvVTJWVXdkV0VRSEY4UlFGRXRYcjI2RzIyb003TXlKL08r?=
 =?utf-8?B?eUFwaGljLzdDbWVTc1Bpa1NaVkxLT09BYklOdzFJN3h4eVYxc3Y0Zk9rMU94?=
 =?utf-8?B?WjAvVjFyMXhqeEptV3lGOFlycWpaK3NBMVVTVFpNSjNoeitQaFVaaHZXUk5J?=
 =?utf-8?Q?QOFmwnwJ8+Wd6zf5OgOxqsWOz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC0DD50BE9BA2B4C8B5402D09D3EA55B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcaeeb8a-d2dc-4be2-ec7a-08dd4253d3c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2025 00:03:15.8592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ImKuK5URb6lcS6J7OsQwy0R4BGvJYkpBxMGdzHDu65rvD+kJKLRMeIIBXfgwfxxxRAdzXWde2cGLH02HFNBrlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7843
Received-SPF: softfail client-ip=40.107.237.61; envelope-from=mochs@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

PiBPbiBKYW4gMjksIDIwMjUsIGF0IDI6MTXigK9BTSwgRXJpYyBBdWdlciA8ZXJpYy5hdWdlckBy
ZWRoYXQuY29tPiB3cm90ZToNCj4gSGkgU2hhbWVlciwNCj4gDQo+IE9uIDEvMjkvMjUgOToxMCBB
TSwgU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSB3cm90ZToNCj4+IA0KPj4+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQu
Y29tPg0KPj4+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAyOSwgMjAyNSA3OjU2IEFNDQo+Pj4g
VG86IE1hdHQgT2NocyA8bW9jaHNAbnZpZGlhLmNvbT47IFNoYW1lZXJhbGkgS29sb3RodW0gVGhv
ZGkNCj4+PiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPg0KPj4+IENjOiBx
ZW11LWRldmVsQG5vbmdudS5vcmc7IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+Ow0K
Pj4+IGRkdXRpbGVAcmVkaGF0LmNvbTsgTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29t
PjsgQW5raXQgQWdyYXdhbA0KPj4+IDxhbmtpdGFAbnZpZGlhLmNvbT4NCj4+PiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBody9hcm0vdmlydDogU3VwcG9ydCBsYXJnZXIgaGlnaG1lbSBNTUlPIHJlZ2lv
bnMNCj4+IA0KPj4+Pj4+PiArICAgIGlmIChzaXplIDwgZXh0ZW5kZWRfbWVtbWFwW1ZJUlRfSElH
SF9QQ0lFX01NSU9dLnNpemUpIHsNCj4+Pj4+PiBOb3Qgc3VyZSBpdCBpcyBiZXR0ZXIgdG8gZmFs
bGJhY2sgdG8gZGVmYXVsdCBzaXplIGhlcmUgaW5zdGVhZCBvZiBzZXR0aW5nDQo+Pj4gZXJyb3Iu
DQo+Pj4+PiBJIHRoaW5rIGlmIHRoZSB1c2VyIHNldHMgYSB2YWx1ZSBpdCBzaGFsbCBiZSBvYmV5
ZWQNCj4+Pj4gQWdyZWVkLg0KPj4+PiANCj4+Pj4+IE5vdGUgdGhhdCBwZXIgdGhlIGR5bmFtaWMg
bWVtb3J5IG1hcCBhbGdvLCBjaGFuZ2luZyB0aGUgc2l6ZSB3aWxsIGFsc28NCj4+Pj4+IGNoYW5n
ZSB0aGUgYmFzZSBhZGRyZXNzLiBTZWUNCj4+Pj4+IA0KPj4+Pj4gdmlydF9zZXRfaGlnaF9tZW1t
YXAoKS4gQnkgdGhlIHdheW4gd2h5IGRvIHdlIGZvcmJpZCBhIHNtYWxsZXIgc2l6ZT8NCj4+Pj4g
VGhhdOKAmXMgYSBnb29kIHBvaW50LCBJIHdpbGwgcmVtb3ZlIHRoaXMgY2hlY2suDQo+PiBJcyB0
aGVyZSByZWFsbHkgYSB1c2UgY2FzZSB3aGVyZSBhIHVzZXIgd2lsbCB3YW50IGEgc21hbGxlciBz
aXplIHRoYW4gZGVmYXVsdD8NCg0KSSBjYW7igJl0IHJlYWxseSB0aGluayBvZiBhIHVzZS1jYXNl
LCBzbyBub3QgaW5jbHVkaW5nIHRoZSBjaGVjayB3b3VsZCBsaWtlbHkNCmZhbGwgdW5kZXIga2Vl
cGluZyB0aGUgY29kZSBzbWFsbGVyL3NpbXBsZXIuIFRoZW4gYWdhaW4sIEkgZG9u4oCZdCBoYXZl
IGENCnN0cm9uZyBvcGluaW9uIG9uIG5vdCBpbmNsdWRpbmcgaXQuDQoNCj4+IA0KPj4+Pj4+PiAr
ICAgIG9iamVjdF9jbGFzc19wcm9wZXJ0eV9hZGQob2MsICJoaWdobWVtLW1taW8tc2l6ZSIsICJz
aXplIiwNCj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmlydF9n
ZXRfaGlnaG1lbV9tbWlvX3NpemUsDQo+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHZpcnRfc2V0X2hpZ2htZW1fbW1pb19zaXplLA0KPj4+Pj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMLCBOVUxMKTsNCj4+Pj4+Pj4gKyAgICBvYmpl
Y3RfY2xhc3NfcHJvcGVydHlfc2V0X2Rlc2NyaXB0aW9uKG9jLCAiaGlnaG1lbS1tbWlvLXNpemUi
LA0KPj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIlNl
dCBleHRlbmRlZCBNTUlPIG1lbW9yeSBtYXAgc2l6ZSIpOw0KPj4+Pj4+PiArDQo+Pj4+Pj4gSSB0
aGluayB0aGlzIHByb2JhYmx5IG5lZWRzIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgdG8ga2VlcCBt
aWdyYXRpb24NCj4+PiBoYXBweS4NCj4+Pj4+PiBJc24ndCBpdD8gU2VlIHRoZSBub19oaWdobWVt
X2NvbXBhY3QgaGFuZGxpbmcuDQo+Pj4+PiBJIGd1ZXNzIGlmIHdlIGtlZXAgdGhlIHNhbWUgdmFs
dWUgYXMgZGVmYXVsdCB3ZSBhcmUgZ29vZC4gVGhlIGRpZmZlcmVuY2UNCj4+Pj4+IHdpdGggaGln
aG1lbV9jb21wYWN0IGlzIGl0IHdhcyBzZXQgYnkgZGVmYXVsdCBmcm9tIDcuMiBvbndhcmRzIGhl
bmNlDQo+Pj4+PiBjaGFuZ2luZyB0aGUgbW1pbyBsYXlvdXQuIEhlcmUgYnkgZGVmYXVsdCB5b3Ug
a2VlcCB0aGUgc2FtZSBJSVVDLg0KPj4+PiBJ4oCZbSBub3Qgc3VyZSBJIHNlZSBhbiBpc3N1ZSBz
aW5jZSB0aGUgY29kZSBpcyBkaXJlY3RseSBtb2RpZnlpbmcgdGhlIHNpemUNCj4+PiB2YWx1ZQ0K
Pj4+PiBpbiB0aGUgZXh0ZW5kZWRfbWVtbWFwIGFycmF5Lg0KPj4+IEkgbWVhbnQgdGhhdCBpZiBi
eSBkZWZhdWx0IHdlIGtlZXAgdGhlIHNpemUgdmFsdWUgZXF1YWwgdG8gNTEyRyAodGhlDQo+Pj4g
ZXhpc3RpbmcgZGVmYXVsdCB2YWx1ZSksIEkgZG9uJ3QgdGhpbmsgd2UgbmVlZCB0byBjYXJlIGFi
b3V0IGNvbXBhdHMuDQo+PiBZZWFoLiBJZiBpdCBoYXMgZGVmYXVsdCBzaXplICwgaXQgc2hvdWxk
IGJlIE9rIEkgZ3Vlc3MuIEJ1dCB3aGF0IGlmLA0KPj4gDQo+PiBZb3VyIHNvdXJjZSBpcyBzb21l
dGhpbmcgbGlrZSwNCj4+IA0KPj4gLi9xZW11LW5ldyAtbWFjaGluZSB2aXJ0LTkuMSwuLi4saGln
aG1lbS1tbWlvLXNpemU9WFhYDQo+PiANCj4+IGFuZCBoYXMgYSB0YXJnZXQgVk0gc3RhcnRlZCB3
aXRoDQo+PiANCj4+IC4vcWVtdS05LjEgIC1tYWNoaW5lIHZpcnQsLi4uDQo+PiANCj4+IFRoZSBt
aWdyYXRpb24gd2lsbCBiZSBzdGlsbCBzdWNjZXNzZnVsIGJ1dCB3aWxsIGhhdmUgbWVtb3J5IG1h
cCBkaWZmZXJlbmNlcywgcmlnaHQ/DQo+PiANCj4+IE9yIHRoZSBhYm92ZSBpcyBub3QgY29uc2lk
ZXJlZCBhcyBhIHZhbGlkIHVzZSBjYXNlIGFuZCB0aGUgb251cyBvZiBtYWtpbmcNCj4+IHN1cmUg
d2UgYXJlIHVzaW5nIGl0IGNvcnJlY3RseSB3aXRoIGRlZmF1bHQgc2l6ZSBpcyBvbiB0aGUgdXNl
ci4NCj4gVG8gbWUgd2hlbiB5b3UgbWlncmF0ZSB0aGUgcWVtdSBjbWQgbGluZSBpcyBzdXBwb3Nl
ZCB0byBiZSB0aGUgc2FtZSBvbg0KPiBib3RoIHNyYyBhbmQgZHN0LiBCdXQgd29ydGggdG8gYmUg
dGVzdGVkLg0KDQpJIHRlc3RlZCBtaWdyYXRpb24gYW5kIGVuY291bnRlcmVkIEkvTyBpc3N1ZXMg
KGhhbmdzLCBleHRlcm5hbCBhYm9ydHMsIGV0Yykgd2hlbg0KdGhlIHZhbHVlcyB3ZXJlIGRpZmZl
cmVudCwgYnV0IG5vIGlzc3VlcyB3aGVuIHRoZSB2YWx1ZXMgd2VyZSB0aGUgc2FtZS4NCg0KSSBk
b27igJl0IHRoaW5rIHRoZSBiYWNrd2FyZCBjb21wYXRpYmlsaXR5IGNoZWNrIGFsb25lIHdvdWxk
IGhlbHAgaGVyZS4NCg0KQXJlIHRoZXJlIG1pZ3JhdGlvbiBmYWNpbGl0aWVzIHRoYXQgZXZhbHVh
dGUgc291cmNlIGFuZCBkZXN0aW5hdGlvbiBjb25maWd1cmF0aW9uDQpwcmlvciB0byBtaWdyYXRp
bmc/IElmIG5vdCwgaXTigJlzIHVwIHRvIHRoZSBvcmNoZXN0cmF0b3Igb2YgdGhlIG1pZ3JhdGlv
biB0byBlbnN1cmUNCnRoZSBzb3VyY2UgYW5kIGRlc3RpbmF0aW9uIHZhbHVlcyBhcmUgdGhlIHNh
bWUuDQoNCg==

