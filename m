Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5818F606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=J3ZVvXu6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ7am-0007i6-5F; Tue, 20 Oct 2026 07:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xJ7aa-0007Uu-Tt
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 07:01:08 -0400
Received: from mail-northeuropeazon11021112.outbound.protection.outlook.com
 ([52.101.65.112] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xJ7aX-00084A-UA
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 07:01:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nz7kDtKyqMIitu/SyCGbHQRu8gw+ybtDnBmSFrKJdBRE/2JGfWbGsfyhfDyTVIRYbwee/Am/vMpYoEhg4gp3g5pkDrlTdZYNAAEitZsWjlYNqxIZ1/dMewtycfBdgp60TbJpMhP08Ha8H2btR/bXcq704O0xErlc4Iohe3MhNK6uWUOBnpOJRWyS+vLedh/uBIzprXFwiVZM9zaZ6Cdler+mAuH+KD+fMKWEzVVUoHGbtxwdHw3MSHKaT3kk8uzzkXheiNM2KX5ZKDkBJB6cP7HIAayCT45sdtsqkjYMEp3DyyWGV+kOADSh8RicUcJ25InD0RbywMfc8UAMDUXWXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhPGctPCPNklIZSnwZpjIvN+b4rjgqSJsj27ZDlAflU=;
 b=LW6manqZb6ZaDP17FhDSTqlrYbUmXS5KWkS/uR008VezmJYdoEKfHWcqdr9nlqPi8+M7ro+2Cksbg5crmAJF9SywnPNY/uvLKc+148B9kEGTPPCBpgDsI0pphlpnsrmRPOToWAfqwYoFVXZwKlcJA+YUlOYorWQGoj8n8Q7qUMW4suC94D/XMihVOhpjzVZ18nCJnSG5CvhZnb9P6/uEOG/UeorRWdwIlIHAqY9p81iwmzjtDnR8BrhmIIijQB4+gpwA0+SVEdVgAdHdoTgZFYpe+mro+r7U0v4yOBEbDLE6ygP9XPgR/Q4tcaMPfVcRDW1fgPjcwuo/joMeYn4ulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhPGctPCPNklIZSnwZpjIvN+b4rjgqSJsj27ZDlAflU=;
 b=J3ZVvXu6o0QQWX8+AejJL4I76IpHPuM/85+fUUZimErLVr/SjOcTkCNFg4pBinrkvdlp2qSxLC2ZL2HqHbtuzDB1tEYxkJY8A9ImcurfW5lwXy4YTpRzkcor+uvsxkWahPoiK5OjldCOVkE9h5QExYYsabAvm9RhvtRd/XexAN2fiDEuepXZoLNJeT8Wh10CTDgXjxnUXX2swc/ghYAW0sDvOAZJch0HUFlzlR+U4bz4AZfFWEx5BmVMFJw6GR+n2oCkmrqq5dyTo5pCuktfWNQSaBszcEH7hcoVG2B2GEEi74X4y9+GllPLM6ebSmFmxw+5wAH1KrEIPs4yf4a+Bw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB9004.eurprd08.prod.outlook.com
 (2603:10a6:10:47a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Tue, 20 Oct
 2026 10:55:55 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 10:55:55 +0000
Message-ID: <35dd9653-bde5-42d8-bcc6-20b692010eb1@virtuozzo.com>
Date: Tue, 20 Oct 2026 13:55:53 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 00/22] migration/cpr: support vhost-vsock devices
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, bchaney@akamai.com, mst@redhat.com,
 maciej.szmigiero@oracle.com, sgarzare@redhat.com, mark.kanda@oracle.com,
 vsementsov@yandex-team.ru, clg@redhat.com, den@openvz.org,
 dongli.zhang@oracle.com, farosas@suse.de, peterx@redhat.com,
 dwmw2@infradead.org, philmd@oss.qualcomm.com
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::13) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU0PR08MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c1950ed-0f1c-4c8c-1cd0-08df2e98b717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|7416014|366016|22082099003|18002099003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: FMHg8v1Bhqtepqd9EpRd27qGymNDguvAlSkWD5TLgI4L76AiCImpHqapQr7OlOBBG+7e7O3P4TK4SoekqvvjMfCscqxZlg8HvwunqT3c0/DqPMdl/4UrJKqmXtAFC83CUwnOZFle1UidWhTg5tCMDLzN0oXF9ld71IAxJHt+1qPNyDpkGLSZhv3VgILtfQU3xlcrwOUMUKpQiUSL9WDtwecF1vSi3Zia7T2XhSz/t3Mpeb/6M0ohbgg+oUzL4zPN0MS7IOYOksVLNDS58HEzTGggZZ+5sIpr7jbcpRN3t3JOXmIxHfwZ7psTNH66zMKIswlzijdAoS1skML+MnBu5BhDNsWfoGEaKng6QgSYP4ZgtJc+QGo+uLMEgYtxj4+kiMpRwEQeGEpGOhfIE4ESWlScGmUKaoTZ8d6horSMkzmUPvDuTGSPWqdIza/+w+9FLKNa2PkX+RkkZLQ76PQKjbtSCFjiGk+fL9V3yU9ARgy4RAfmfRCMysr1k6lpWXXpOtV2Wnv/HdOsyaFLD4KFgHF7hqiLd100/osY061KNDeOv2Dt2tsLvIs5XgRZwDLOCdQyCbMzEu7na1c26Dj/fl1jK/01pP4zyJ1vniwMXOxhhiUw5nuha87+Ik10mvEG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(22082099003)(18002099003)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmV3M1lvSkRHQ3VRWGx3T0JUMTd3SXhtcWtKeVF5M21icmhVZFZ0cHlBYm1H?=
 =?utf-8?B?Wi9kZHNod0prVXZVMHl3SjFJMHZ0ZGlzYk1PRHVPTmdJQTlNM0tpdFZsZ0h1?=
 =?utf-8?B?SkhkWVF2UWlpVTZVRHFOWU1tUVpRTG9QRWZ5UzdiSERXT3dLSHFnUkdrU2xY?=
 =?utf-8?B?RDB3OUtURjA1d29FUVphYm1CdkJNaWdVZld1QlNkcGpqc3RjM1cvb0ZtSldJ?=
 =?utf-8?B?bGlPZ1IzYkFTbkFWdGJQYkgrblozMUJibWdlUHZGMTZ1VVlJdEhyek5ZWTJz?=
 =?utf-8?B?N1hBemVlVWgzeFgwcXc0TVh4ODFRNkRDdk91Ym5PRGNMMytveFRLOWdoeWMw?=
 =?utf-8?B?b201QkhJdE9DVURRMjBHNG9yN3hwSWdUeVh6ckdUeVVGSk5Rc0tCRkNRRURy?=
 =?utf-8?B?cXowQ2JOcWtXaTJJOWs4Rlc2Tmc2NU9NRlBNc3poUUh6aDhDS0lLT29JT3Z2?=
 =?utf-8?B?S2E2RDRNWk9XNXRVSVA4MTdQY2RiS0E0ekpCTE1uZU5LTXVoZktzcWoxY2hi?=
 =?utf-8?B?Um9IZG1tekM3RkpSWjRXUnZEellNQ1pNZWphNHZ4ZHlobUxSWmFUdnZaVXdy?=
 =?utf-8?B?a3RSS1l0b1RIYS9IQXB3b3V4OXJYejhyOVpZVVBSQkdZamdoTkRjYzFjSHNz?=
 =?utf-8?B?azZCKzF5OVM0eGIwMlJBQUdiZVd0cXAyaW9lMm9BVU9LWXJOb2xqL2RiUjdy?=
 =?utf-8?B?Slh1alc5QWh5b0s3L29MYktNVExSTG1jMVoyQ0JFTG80cDJtUWltTndrQTVJ?=
 =?utf-8?B?Y3VmYlFBOVdTN0Z5VnFaTFRyWUk3SUR3OTEyRTJRM2dQN1JyWXZHTHZEV3gy?=
 =?utf-8?B?QmdLaE1DdVBvL29XMW9NdEdMNmJtc2MvUXFmclVUQTJMdTBNbTZlcGZRa1Ru?=
 =?utf-8?B?MVpnSDJGdU5iZDlaYXBTajdFTzA4Zm9aN3V1aTNhVDJ2ZkhkM1orQ3NVeVJp?=
 =?utf-8?B?ZnhwcUM4Q0tHdmtNcVIzcHczdEN3UDFleGR5elBhd1Q3SzFKVkJWRDViRmF1?=
 =?utf-8?B?blhwUU44Y2pkZnNjU0FJcFRaT04yMUJIQ1NCU01RSjU0TkRiaFp6YTY3blBa?=
 =?utf-8?B?a2lyVDRrN0dTUW44N1UzSE5Qbmwra1ZVaWlsM05XaWZyWlhBT2FnUmNvVHJQ?=
 =?utf-8?B?bExlQ29ZNzZSNXpSTERsSHR3TzNMamowOVpvdTJiOE5TQVRCdWtiNTh1SVl5?=
 =?utf-8?B?c0IxTnpGbGRxVzEzL3NMaWNRVkpKTGV2V3dGOElzZ01lUU90V3NLejZYaWRE?=
 =?utf-8?B?enRZbXd2UkdKWkhrVDVHRkRBV1lkRGFLT01PTllGUUs4ZFY2MC9TOWw2bzZL?=
 =?utf-8?B?UWNsdk4wdEpOdzNIZUVWWU05RDdWRTVCVWx3NGltTkcxVHcya2M0cnJGQ09G?=
 =?utf-8?B?T3dEczR3TFo3SFZkakZOOW5lVFBiMkIybFJ6U21wRDVGRm5Id1pRY3FWNHUx?=
 =?utf-8?B?bU1FQlpCUU1SdW9rUTdyNVROQ2pxdy9TOXFGbzI1bTdwQ3laUnpTV201Q2Nh?=
 =?utf-8?B?UnBTUWJCdzkyTklWU2M1TGwyaUwzMEtHdko0MUFCMFNXaVd3Rmo0VXE5M2pa?=
 =?utf-8?B?cys3UDNCaDg4VUFML3VqcEx2MUNhaVJ5Wkg4TDVtSHVRR0ppMjV0WkJOSFZQ?=
 =?utf-8?B?UnM0TVdORWRJQU8yaVNwemM0RXBzU1A2dmVDK1p0VWJQTTFTRXpoNGJUUkxQ?=
 =?utf-8?B?OWhtZ25JNTZWRkJ4QXJ0ZkpUZjlvTG4vUnZTMkJ4dENHMjBLU3lBUjE4NFF6?=
 =?utf-8?B?YmFSUmFGZCtGR09pU082aUJTSW5DbVA3aEpyZWJKVVV3SEdoTEpsaVMwNHdj?=
 =?utf-8?B?UkNSNjRJQmdjdXRISkxpYm0wNnNJVmxXS1E5NTcyODRFYUNuVHJ2NG53Ty82?=
 =?utf-8?B?b29DVXk3RHArTVVTMyt3Ym5Na0RhWGpSaURId2hLQjJ0M2FNTUVjbndqSVBo?=
 =?utf-8?B?dHJuanZ0dVB0YzNJd0JrY3VjR1VBV1RwTkMybTZ2YXFkOTZQQ3FJSVpTUE1z?=
 =?utf-8?B?VWxkRysxK2toQkVteC85TWc4SGl5cmFzc0crcUdod3BZNzhKWjdlSkpBNG02?=
 =?utf-8?B?aTgza2tpQWx6Y04rZmxoekp3d1BPV3pNY0QwS1dLNGZMTld4REkyL24rWTdY?=
 =?utf-8?B?VWl6YzRacktPZXZUcUdsUURVMDZ6QjhPcXhXZ2JhZ3lHQmZzdXFyb0lrS3Rr?=
 =?utf-8?B?WmlFbllEQ08wN2ZjZ1lpL3hiZ2t5OThmWXJzSm9lM3ZlTnNuaTZwWExTa010?=
 =?utf-8?B?QlhIZGxRaXZjM3FPNTMvSzU3YW1jWUZVQUdxQzJUcU5TUThFeVpwT3JIamZl?=
 =?utf-8?B?QmNTUkRhd01HS2RldEhvSS9GRVJMeGlZUVhIcG96WWdyZ3VndGs5VDB0MFE1?=
 =?utf-8?Q?cTBiIA2vVQ5dPCI0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1950ed-0f1c-4c8c-1cd0-08df2e98b717
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:55:55.2622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9u5ZHcRtDFKVevEQqzNVDq3Af83AjHva2NdNIgnRkaJlr7cGYs8dbj0p/FL6OHUt0ldNfL/xnZCh6ef12jMXwm45LwAdruta3bEHvsBjHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9004
Received-SPF: pass client-ip=52.101.65.112;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

On 10/12/26 1:28 PM, Andrey Drobyshev wrote:
> v15 -> v16:
> 
>   * Patch 15:
>     - replace the errno filtering in vhost_dev_try_release_owner() with
>       a new 'owner_handed_over' flag in struct vhost_dev.  Release the
>       ownership only if it was handed over to us, and report any failure;
> 
>   * Patch 19:
>     - set 'owner_handed_over' in .post_load() on the CPR target;
>     - drop the redundant 'owner_reset' flag, use vhost_dev.owner instead;
>     - drop Stefano's R-b because of that.
> 
> v15: https://lore.kernel.org/qemu-devel/20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
> Andrey Drobyshev (22):
>       migration/cpr: forbid saving duplicate CprFds into hash table
>       tests/unit: add test for duplicate keys in CPR FD table
>       migration: forbid snapshots in CPR migration modes
>       migration: forbid snapshots under Xen
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
>       vhost: release ownership in vhost_dev_cleanup()
>       migration: add MIG_EVENT_INCOMING_FAILED
>       vhost: release ownership when the incoming migration fails
>       vhost: release ownership on exit
>       vhost-vsock: hand off device ownership across CPR
>       tests/qtest/migration: add vhost-vsock tests for cpr-transfer and cpr-exec
>       tests/functional: add vhost-vsock CPR test with a live guest
>       tests/functional: cover a cpr-transfer target going away with vhost-vsock
> 
>  backends/hostmem-memfd.c                        |   5 +-
>  backends/hostmem-shm.c                          |   5 +-
>  backends/iommufd.c                              |   4 +-
>  hw/vfio/container-legacy.c                      |   7 +-
>  hw/vfio/cpr-legacy.c                            |  29 +-
>  hw/vfio/cpr.c                                   |   6 +-
>  hw/vfio/pci.c                                   |   5 +-
>  hw/virtio/vhost-kernel.c                        |   6 +
>  hw/virtio/vhost-vsock.c                         | 193 ++++++++++++-
>  hw/virtio/vhost.c                               | 136 +++++++++-
>  include/hw/vfio/vfio-cpr.h                      |   7 +-
>  include/hw/virtio/vhost-backend.h               |   2 +
>  include/hw/virtio/vhost.h                       |  80 ++++++
>  include/migration/cpr.h                         |   2 +-
>  include/migration/misc.h                        |   5 +
>  migration/cpr.c                                 |  64 +++--
>  migration/migration.c                           |  10 +
>  migration/options.c                             |  13 +
>  system/physmem.c                                |   5 +-
>  tests/functional/x86_64/meson.build             |   2 +
>  tests/functional/x86_64/test_vhost_vsock_cpr.py | 347 ++++++++++++++++++++++++
>  tests/qtest/migration/cpr-tests.c               | 133 ++++++++-
>  tests/unit/meson.build                          |   1 +
>  tests/unit/test-cpr.c                           |  98 +++++++
>  24 files changed, 1084 insertions(+), 81 deletions(-)
> ---
> base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
> change-id: 20260908-up-vsock-vhost-v5-c781b39f1c1a
> 
> Best regards,
> --  
> Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> 

Friendly ping

