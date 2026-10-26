Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E731E606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=pO8TbEA5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLFgX-0003cb-Q7; Mon, 26 Oct 2026 04:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xLFgT-0003c7-0y
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 04:03:57 -0400
Received: from mail-westeuropeazon11021128.outbound.protection.outlook.com
 ([52.101.70.128] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xLFgP-0005UV-PG
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 04:03:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oy3JgTYaWIQAXLbDtd7vEFofENT/SWWbGHmWK2WqzMAvI9oIf8W3Al4iyZ2jxIJwbtVoqUJbRNy8kN5J2DR1uwddA8EJc7HVNUeTeRb1TMeBo4e03DCWFsY+z90I+4SLOFXJNfW7P0ROe1klJJsrm4nxlGU2kkIw9wGVgJSEtdV+8PFJL7XtZK8knwsCJLJc8JlIbWQ7pSewMRf6RCdgJ+7RThJe0mpdQQ/3XYnce2AqhZtzaOo1vC6w2IHtTeEpk4ScbwGSOnhhtr7y4M2Ry5XMT5AGiuqA26AjuUSS4aTUre9ILVsvO/Zp62htJhKdIQsI8gZ5f8NVDltqNQp4wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTSpu8LGMdpmfDZJk0gS8x4/jpsfSYFKt6tnrqgvQ9k=;
 b=yd1lFNmUMK7ma1Ok/Z0qtoE+9qS0dciukqzQRMYCyn3EjgwDtB85l3jKmBFVIiFdAGJX0si4osZXiYKk0ATRgz8XvmsiHKBRRGVQDpOnXPBakL1ElWi7SoW3pszSmhhApHmWS7qRP5OpCL5yprSc6Zdgojty+R2yUUVGB9TTJbRRt+zrzM3JPpNuMl3n2LZGjLms/vwKEoM8GuheHILPle0HcPZvddCN/hgri9TcHABtvw4+YH3a6n7UVClAzG5wn9CAoUzfOjr2ld38DAbPpP1ILicw0ykiXeRBDPzXzhKj2nPUAzTSsYbox16aj4hmc2rvY6tbzNwp9A3mdDJ0oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTSpu8LGMdpmfDZJk0gS8x4/jpsfSYFKt6tnrqgvQ9k=;
 b=pO8TbEA5JSpxGO0woRWOrFOai/sUjfam440f9xay9ugHC3LMMVa01Sjki2l/ESb9EJ4btR6M3JeSZYIVQAbqt488QvOqCaL1XajVYJ/64OB9ybV5/jymFCSp1emJ9tzsMK6/bQ5McUow96KEvJ3P/Nsaos6pkusnou0Z18NhS5kvSlZB/3auT8BOJ2KVTomDg/w3YC90O1xlMmh7XXcDWK+PYo1LUAhvMxHBMvgCTrl1smiD3XC38Ur9bKX9ifWudYp0W/uhBFaBwVAra7RnndKIoebMoz38h554u9yYyhMsu/B7JZ93A2SsjKqXHh45El9ajDhh0lNjGWky/KnFuw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by FRZPR08MB10901.eurprd08.prod.outlook.com
 (2603:10a6:d10:139::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 07:58:47 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 07:58:46 +0000
Message-ID: <e5fbac0c-b4d0-4e8f-8865-23791057c570@virtuozzo.com>
Date: Mon, 26 Oct 2026 09:58:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 00/22] migration/cpr: support vhost-vsock devices
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, bchaney@akamai.com, mst@redhat.com,
 maciej.szmigiero@oracle.com, sgarzare@redhat.com, mark.kanda@oracle.com,
 vsementsov@yandex-team.ru, clg@redhat.com, den@openvz.org,
 dongli.zhang@oracle.com, farosas@suse.de, peterx@redhat.com,
 dwmw2@infradead.org, philmd@oss.qualcomm.com
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
 <35dd9653-bde5-42d8-bcc6-20b692010eb1@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <35dd9653-bde5-42d8-bcc6-20b692010eb1@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0144.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::23) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|FRZPR08MB10901:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f2f63af-0f42-4b1a-d1a4-08df3336f66a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|23010399003|366016|10067099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: v3flVmQpghSJLd5Mp3zZ0xKydFPd46Nnh4jmqlRb3s6tfkBDqMF/l5r9HjTPkl8KJtW4a6FrWkJroBl0jMmfoNRbdvgHzk9d0NgWkH6cKWRZV8pIzq0xf5tdmcy+Gu8yHblNb86xy71urucJ+f/MQYyIGa6LLFQwJ87iwxjD6i7FTLHbeMxvvbJjUt4RWur6VW2zpV/7F7y3KjvLF3rIFUGCurtKK3tagYzvrEhZQwJ3iNCmN5nZWZpse2k0mcYzV8qdITVkB12LQEmEMEvIHCbDXwfR6GOP+tc23XSSz/5F3ADoRsER+8ozVNBVOuXZJlsd9M2qVd4z38SsealUBkZe0IJ8pKArvxGygeEdW5DUgDEc3V5wUaD4Cq8fHuBZb7OoHlSk/4NKVfhDCmbIjmtXVR38ou9AyG2y7Wp/wx7mWoKWr3WF+U6Fh0eO+4XLO507hyAAJma8aDB57PP9xR/9U4wOi5dsEBl+RNt4FRdJCf2fZTt9N19U40DMDIGsioTclexkn+K2/k6y9JwYN8HY2jmTN2s59mUWTDtc+JLgjBJ2Vr7OF1BGYnnbhPltdLtpanOO72qQgsA/OcsCW9QXc9IiHHHv2bOcgowjAXRpcUKqL2CSCFTn0OybfZHw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(366016)(10067099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZldOaHBCSk0zNlFWMkVyKzZmVzBFNVQreWJaa0UwN2JQdUI4QkQySUl3S2hj?=
 =?utf-8?B?Z2ZvemF4eTBGOTg2SkVYbmo1Y3MvOFIvTTdqTE1pMVNHdHlyaDdabFpDTDdy?=
 =?utf-8?B?Tlk2YTEraVNoVGtYdHVyOUsreVdkOVdjNUVDcmhHMEUrVGRyKy9zRytESm4y?=
 =?utf-8?B?K0VYR2pnamRSOFhqQU5yQ2RpeXVEaDVtWk1kSklxSk5vZGhra2VIak8vNU5Y?=
 =?utf-8?B?UTBQOU94cVFKZUZndlZoNkNHUG51TnpZd0F2NlRQeE80WThFWHdNdlBjM0Zi?=
 =?utf-8?B?M0JwUHVrc0RmcG9ENlQ4M096WFZwOUxkQXQ2cGFFSUZyRklzSmN2UzQvYVlD?=
 =?utf-8?B?Rzd2Q0psWDM5NzFJMjFhTzhxQ0FITTRBWlZ4dmpHT3dwaTgwbEExUWJheHJx?=
 =?utf-8?B?b2NMUmJyaExTdWNDRGlTZkVEZWlSSUx6cmh4ak5zd2lIQy8vdEhCSk1oeGdv?=
 =?utf-8?B?Q1I0WVNJbFl5R1Zic2I5OFBOdkZPdkVuTFdvbi8vK2RPNmV0VUtrR29zSmY4?=
 =?utf-8?B?N3V6SW5FRFpiWFBXYk90Y2IvdmhjemdyU1dXakpuQU96Y0txNWR0ckpLRWM3?=
 =?utf-8?B?ODV2YUxrZzlsWmY5RDU3QW4vMWVRVjNiYTArUjRMTENDUXJKQXl5aTZsY1ly?=
 =?utf-8?B?R2FBeloxR2xReVJkWlZ5OG1EVS85NXRyb3FralpoNTlheDMrRzZGOVd6emNz?=
 =?utf-8?B?ZFVKSlVnVVpCZXFPTjBycnZwSXZySzZCT2NoR1hrVW9JWVM4NlF2ajVmQVFG?=
 =?utf-8?B?VVFoVzJpWTh3b0ovWG1VZ0UzeThiWlRrOHc2VEZ2UnNIVUY3UWgwYUs5UjlM?=
 =?utf-8?B?MFVUSkZDZTdvK2Q4ck9xdEF1cThwMk4vTkRYak8zSm5zMllDMldlQVpwQStu?=
 =?utf-8?B?M01GSExXREM1WklvM2lPNysxamJHRUVQSjFud2xOSVY5WjlEaVNYbGFVbC9k?=
 =?utf-8?B?SUsyYVpyRFRQelV5QlRZTFM2TlJITU5MUmlNNmk5aGpndG5LdHFSb29OUjRh?=
 =?utf-8?B?QjRrSEdXejVEYnpCa0p3STNzTkg5eDB1REhRdzZFWXFiMCtESUVFZnJIYlNP?=
 =?utf-8?B?NVp4Ylk2K2U5d3FMTldPbC9pYjdJR2FNK1NlNE5wZ3NkTVVIVUtFazh6Q0Vv?=
 =?utf-8?B?akpGb2NpUmxBbG1jZ3ZhazU3cUczcXoxa1EyYStWQWQ2WWtueWUyeVJUdnpU?=
 =?utf-8?B?aFhiem4wY2JCYUZ0UTdaVXBZenNDL3hVaG05b0NucTZuYWRrQkNrcm9odU12?=
 =?utf-8?B?dGFHOFdWZE9pU2Y4TStFWTd6dC9ScWllTjZ3WHlpR2ZJLzdLWllvMzZ6bS80?=
 =?utf-8?B?dkR5a2xKRmQrTjJ4NjZnc2pWNXFsOHQwSjdxLzJWWU9MdGs3dlU4S2E5Nmd3?=
 =?utf-8?B?RlFpeHpyZ3gzbXlNVGJtR2c3ajA4SjJrZVJOWDhSN28zTUhET3BMV2hydkUv?=
 =?utf-8?B?K0JaaXltRU94aDRDWWN1ZWdDaDlKL1N2OFJCM1NTSGJJMkxTYWF2RmtSN2ZE?=
 =?utf-8?B?YzVtVE1vM2M5NlliSjY5dmtGVHFXYVJWVGVxQTdGV3pyN2EyR3BzQkxURWxE?=
 =?utf-8?B?RUhDakU3QmZuN1ZFMUdwaSswaXVhTHVxUnIzQzdwWCsyNnE2QmQ4bXVESDIy?=
 =?utf-8?B?RmdDSW5GWlBadklUQzFRejBscVJNc2JVZHh0SnU1VVI3RUhFQTJCb0xwbk5o?=
 =?utf-8?B?djVpL1VFQnlWTDZSNnNXVjc5bjBNaCtqOG52V3hrdllGNTd0MWk5WUhPMllG?=
 =?utf-8?B?YzJtRUladkVnWkxvUnhBNVgzd0xjdCtSRnR1TGpYdnNabEpzMFBKaEk5ZUxs?=
 =?utf-8?B?NWdVMkkzbVF1UGJ0K0JOR1ZKdGUxbEZNRDZxUUpYL25YQ2lTbC9CdG5JWjJh?=
 =?utf-8?B?OGQyd3R5NUhXVGUvSUhSc1kzODRqVE82OTZTWVRBOEhKSmZLWWV6dzNZR3dQ?=
 =?utf-8?B?WmVVdXpubCtzZzlHR1dKcEU1cG9mRnBkK05JNTFId0F0bmc0NG4rWUJ2ZTR5?=
 =?utf-8?B?ckZoR1ZXYWZUekFYcmdRTUVQZFNMYmN2dDl2T3VBZ2g4SmRLMFdsVHNaTlNU?=
 =?utf-8?B?cGttN1pQVXEvc1Q5MEZ0bHlqYUdkcEk0b01hVnRhVzB6Vm14MjZDWU5JV1B6?=
 =?utf-8?B?a3liMzRsMlpwZHdFdFJCV0VDMzZnMU9VRnUweVBBMWVKcGtIM1ZVQUN2OEF0?=
 =?utf-8?B?dWNUejlQRDdwNU1WeHJ3MSs3ekJ0WGNnbUY2T0ZBdUVwN2xYTGpSSVREL0Zj?=
 =?utf-8?B?VEhwTWtMUmNkb1BFOTlNWmRubDdVWmxSck5HaXJZNlVod3RQYzk4cSswaWtW?=
 =?utf-8?B?NDRSRjNYRVk1MGtDZDlLVDRWSk9pcGpTRmR5UnlXOFlnY3lLakROWVhRTVVx?=
 =?utf-8?Q?Q55yar2bltJKz+7c=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2f63af-0f42-4b1a-d1a4-08df3336f66a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 07:58:46.7471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +HNwuCuWdqbDP9lh+B4yT7e8Q0/EdUNpvgLKDLY70EgqkGefPsnwK0zVH/yf+NQF4LBQEp2m2ciSi3Nl+5rM+67dCRZx4uQRmucHV5ynaac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB10901
Received-SPF: pass client-ip=52.101.70.128;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

On 10/20/26 1:55 PM, Andrey Drobyshev wrote:
> On 10/12/26 1:28 PM, Andrey Drobyshev wrote:
>> v15 -> v16:
>>
>>   * Patch 15:
>>     - replace the errno filtering in vhost_dev_try_release_owner() with
>>       a new 'owner_handed_over' flag in struct vhost_dev.  Release the
>>       ownership only if it was handed over to us, and report any failure;
>>
>>   * Patch 19:
>>     - set 'owner_handed_over' in .post_load() on the CPR target;
>>     - drop the redundant 'owner_reset' flag, use vhost_dev.owner instead;
>>     - drop Stefano's R-b because of that.
>>
>> v15: https://lore.kernel.org/qemu-devel/20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>> Andrey Drobyshev (22):
>>       migration/cpr: forbid saving duplicate CprFds into hash table
>>       tests/unit: add test for duplicate keys in CPR FD table
>>       migration: forbid snapshots in CPR migration modes
>>       migration: forbid snapshots under Xen
>>       tests/qtest/migration: add test for snapshot rejection in CPR modes
>>       vhost-vsock: block CPR migration modes
>>       vhost: add vhost_reset_owner op
>>       vhost-vsock: don't reset connections during CPR
>>       vhost-vsock: fix FD leak in realize()
>>       vhost-vsock: preserve vhost FD during CPR
>>       vhost: factor out vhost_dev_init_backend()
>>       vhost: make vhost_dev_cleanup() safe on a partially initialized device
>>       vhost: add vhost_dev_set_owner() / vhost_dev_reset_owner() helpers
>>       vhost: add vhost_dev_is_initialized() helper
>>       vhost: release ownership in vhost_dev_cleanup()
>>       migration: add MIG_EVENT_INCOMING_FAILED
>>       vhost: release ownership when the incoming migration fails
>>       vhost: release ownership on exit
>>       vhost-vsock: hand off device ownership across CPR
>>       tests/qtest/migration: add vhost-vsock tests for cpr-transfer and cpr-exec
>>       tests/functional: add vhost-vsock CPR test with a live guest
>>       tests/functional: cover a cpr-transfer target going away with vhost-vsock
>>
>>  backends/hostmem-memfd.c                        |   5 +-
>>  backends/hostmem-shm.c                          |   5 +-
>>  backends/iommufd.c                              |   4 +-
>>  hw/vfio/container-legacy.c                      |   7 +-
>>  hw/vfio/cpr-legacy.c                            |  29 +-
>>  hw/vfio/cpr.c                                   |   6 +-
>>  hw/vfio/pci.c                                   |   5 +-
>>  hw/virtio/vhost-kernel.c                        |   6 +
>>  hw/virtio/vhost-vsock.c                         | 193 ++++++++++++-
>>  hw/virtio/vhost.c                               | 136 +++++++++-
>>  include/hw/vfio/vfio-cpr.h                      |   7 +-
>>  include/hw/virtio/vhost-backend.h               |   2 +
>>  include/hw/virtio/vhost.h                       |  80 ++++++
>>  include/migration/cpr.h                         |   2 +-
>>  include/migration/misc.h                        |   5 +
>>  migration/cpr.c                                 |  64 +++--
>>  migration/migration.c                           |  10 +
>>  migration/options.c                             |  13 +
>>  system/physmem.c                                |   5 +-
>>  tests/functional/x86_64/meson.build             |   2 +
>>  tests/functional/x86_64/test_vhost_vsock_cpr.py | 347 ++++++++++++++++++++++++
>>  tests/qtest/migration/cpr-tests.c               | 133 ++++++++-
>>  tests/unit/meson.build                          |   1 +
>>  tests/unit/test-cpr.c                           |  98 +++++++
>>  24 files changed, 1084 insertions(+), 81 deletions(-)
>> ---
>> base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
>> change-id: 20260908-up-vsock-vhost-v5-c781b39f1c1a
>>
>> Best regards,
>> --  
>> Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>
> 
> Friendly ping

Ping

