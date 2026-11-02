Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EAB60A0C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=stCt6JQT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuxx-0001wJ-Ar; Mon, 02 Nov 2026 11:33:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xNuxt-0001ZT-5g; Mon, 02 Nov 2026 11:32:57 -0500
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xNuxr-0002cN-0A; Mon, 02 Nov 2026 11:32:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vs71Ko8/wpl7zAMYLulXX/E6PRuRz1fEXm06zK+I5m71qvpJHBZBJsYT/ROGTZ7Fvi0WvVtaovss/6jDAxzb3NRFEA/wKmLE5Ji5UF1nOH6cNs81SALNaIJGHqGwMU+nvYX/BMPJae1KcQjRAK3D8fus0dF/wTBl1meziBXmbAmy8OyUQKx4efjYiCAXF8vzy2liZP7u/iLSW6G6s5Sf4SHJMfvWJD5sXRogcOSeAreFpCeGrn0Lr/BnxCPLR77NDrV21uPuU+5LfOVegFHwREu1490D3ybkh08hjMiORwRev2Y0uDs33dGpsfZxgM36BXnHLQgVDtX88FgOIOpTsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfohODdfyMFTFjVPL3jaEf+NCK3B88aqkvtQjMVUveE=;
 b=U0Dg/AL5CzqNvTgXErQwZphiluYD8yVusCaK8HOs2TzZFPRQK8Hsjv2+Rt0MvHtfRwUmBBolki0boaBRyNC6+r8owclDx11yoNw32FJEY0YaTP3souWkHYLWVnC7Zf3eciiO7GFzo3Ing7OgimYKS/qqncvOxkQZBV5DRuq/AIrINYw29+e2cx458AaaQyTicPrKPJ6uN1tBnH+2SYmXK2Glzu2SBcpKbSrSZB6JBrYC9OaeHWJswuBYIvJ0PBDGOrmStBSSjguA4HyRDMKXTlgyFMH3UVV7chuJLuzbWGLh8sFI04kJUp8844GhkqKnBMNMjKrn+raNTDIwOiaLOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfohODdfyMFTFjVPL3jaEf+NCK3B88aqkvtQjMVUveE=;
 b=stCt6JQTEWo5QqKRTRCPpKCtPIhNcGUAiwTftafn2/PJ1Mp4mUmTmHWTKkIS6bhh1PI++pmNzsVoAHfdXu3Lu1BploTirEMj7OARahVjeLPwkA+ooj0S5UJh8L8xTpxCuLw0GgldPMksH7Qwdmy1ExMZJz5lK4lOMOB1I2uqmbvWkkz/EVJBxC/Y+xFq8AKTrEY2HyLgygW4hyEOTnjKfEPOhxiv6+AGZgP50rC5hWQ5SvRSxdLHTkBI6gKV725Z2hZSelCfGVvrrxLWgGaor2uDTwxb5aAAOwWfmQDt+A3MP4cN9NJkAUFhXvL3/K3PybyKfpIi+bw/isoaZo2avA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by GV1PR08MB10670.eurprd08.prod.outlook.com (2603:10a6:150:169::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 16:32:48 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 16:32:48 +0000
Message-ID: <f8f2fc8b-f59c-4dd4-8bd7-f6d30f505d85@virtuozzo.com>
Date: Mon, 2 Nov 2026 17:32:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] block, scsi-disk: honour a size change on child
 replacement
To: Eric Blake <eblake@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
References: <20260812121500.1034178-1-den@openvz.org>
 <b052d608-7dca-4100-a7dd-5d44f8529198@virtuozzo.com>
 <aui6P33zxACLgXAV@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <aui6P33zxACLgXAV@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0101.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:351::15) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|GV1PR08MB10670:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a273b47-bd90-4f6a-6b8e-08df38feee94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|23010399003|10067099003|18002099003|22082099003|261102123227099003|56012099006|4143699003|261026121527099003|261022105027099003|261026140227099003|261009223027099003|261028144727099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: k5Q/pbQoF4zy6WFTnUXGAHVgFIwNb/zMo5NfkcBVt0sTrLkTTib70YLsllVtLyxp4MORs5AUp2JrmnDUa63P1Zo83BrZ9mLnCn/gxYevFUy3eznuhfuhoHzoyZaFZttObcYLlbui7PF13ss04XecA1gXB75+ittL/HaaP+CFqckptslQKYbO2nksTNRymBMDFdrvlDZxs41HzNOzRL4IwTUC6J79Y45Xnx4jBZP5+r/83hrfazeIJIH1UyFNZYruy0OSEa3dN3N9jTbD6xqrJ5opH5ac95Y3E2lMXCtWIVt+2mXRmldNF8rvnje+7SWUaYoZMyGTWV0Y6Ovt5wwJP0PXtHjc98Eq4TUDWOSPBVLGnbTCcyiQ2H3qt0AvdZoPSWkTxM/el+pgNf94c/2k/yRUt00xpwf/HQL5E5wPgZHkJQIyXX9NNanXSkmX9crd8g1OFBdH6Y+/qRW6my/6cSfvW2pVofKQpiYXDdNDztVmfWAhtXo3qXOo+BFCmDE8GbmqRWWeSPbAMKYAcFZnN+nFIGZX8JS8tGvO5rIsZtW2u0w07+dt7QFKYKzWtmZVLlwqYjN3Aj4o6DlB/iJmlh0Gl9DU7Az70qkBVQYkkWgJACwLendYlsxYncmbi4zPrSbf07MgVwQ0O+7sFTVE96adaK8L5yBxQN9Z9um4RWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(23010399003)(10067099003)(18002099003)(22082099003)(261102123227099003)(56012099006)(4143699003)(261026121527099003)(261022105027099003)(261026140227099003)(261009223027099003)(261028144727099003)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEE3ZG9Xa2MvRmR2QnVUenBVcjl2eEVHMkJkbFZieHAwdVVWNndpaVRLdTJN?=
 =?utf-8?B?TERWT0xtRGY5U3FSenQ2cDlxZzNPQldCNHdoM2Zud0FpdjBBcE1sclFkdnlh?=
 =?utf-8?B?bjBwTlRzbld0NFBxOEJubEYyNHY4SmNneVlZa2JwSm1jWmdNbDc4WmhHQ0ZQ?=
 =?utf-8?B?K0hielVqMDduYTVaVlNzNDNodC9nN2R4ZjV5VjZwRnZISkh6RlZPMVNxR21a?=
 =?utf-8?B?amtIWUpHL1pDQi9YbWpBMFdDUWZkRlJJRThBVUJ2S1lQNUtwMVBPZ0kwMXor?=
 =?utf-8?B?cWlINGptOUt1TEZ1WjZSZXl0dUFpdmk3OXQ2UXVQbHZiWEVkSENIUExxYjZj?=
 =?utf-8?B?S0ZnUTVhT1N0NTZ4V081ZEpIcCsxMjFIOFdPOHZsakNaSXFjSzV2ZU5Sbkto?=
 =?utf-8?B?WFB0ZmhsT1NiMEl4Q3dDcFVNSDhmNVBxbDRWVld6ZkpGdVFoQUhQZVIyM0cw?=
 =?utf-8?B?VmZpWUtIRXBTVHdKRFJGdktXRWNDWlBFcGVrS2l0Z3dubXZ5VktDY0RnV09T?=
 =?utf-8?B?anNmYnkvbUVieExmZWJhRWlhMzkrb0d2SWM1ejhJWUdsb3pXUHc2emNpdjUv?=
 =?utf-8?B?REhKS0NRU0thNXR6eVBrR0hNblRHSG1XRDhKZjh0Zlo5czE3ZG9pSDV4eEZ5?=
 =?utf-8?B?bXJMQVl5T0tTcjZkU2lEb3lLM29nTDByN25hTE1nNDdTeTNNdWQ2U3FYOVZr?=
 =?utf-8?B?Q1c3dDhaR1ZJajlBQXpxNTJvZ0s1T1NoTXdEZ2xqWHdHcWhhajJhS3hTdTlu?=
 =?utf-8?B?WTF3MWU4Qm5Sekk1Q0tQN2lYTHBiWmJSL1NxTEpRUjUrbXZOdW1zVS9vM3Vk?=
 =?utf-8?B?TWtucTRxcVVYSHRkT2JYMUhlRjQ4T2pPSzJWTitPNk9OT0NmVGJMaEZZeitw?=
 =?utf-8?B?YVlaOXRFTmtiNjViUjZ5QURtOE1pcDZRSjVjR3Y2Y0tIblhoUXI5aU41RDFu?=
 =?utf-8?B?YlJIWWJnc3JsV2s5ZTdaU3JOVnM2OGV0MkpKQ0RFOEhHNHZKZEpRdTY0R3pB?=
 =?utf-8?B?ak9qb0NIbkxncnZvL2l1U05IYnU1d0FhLzdNQTV2bE5QeS9JYVlQYlBOVTdv?=
 =?utf-8?B?MjVHN2Z0OUNFLzZyd3U3QmZFRFRWNUczU3d3M1MxTjF0bGJGeTZtMHdtZkV0?=
 =?utf-8?B?SmxJbzBxcjA0VGI1Z0dRYUlTc3MvckhWVFVlbDdJMzM0ZmhQR213bVlheVF1?=
 =?utf-8?B?OVE0Skd2dE11bjk3Ny84RjdzZmsvdERrRHdscGx3Mi84ODBzbEYwTVZlV3Vk?=
 =?utf-8?B?eEFSMWNGRUFXbE5jUERmOGZGalNMcEt6T21CcWtSUkRqWUdQVGFCV3NncXhZ?=
 =?utf-8?B?VFBHZ3NHR1crSkJONHJzRTRVVkdCQWxWN0M3T0Q4Q1BuQ214V09pMXlLRWlo?=
 =?utf-8?B?aWpueW9EUmEvZEdtZ3RTcEJKUW9PWFQ3TUlqM2h4Nm9aM1ZUdTN6MWxXaGlK?=
 =?utf-8?B?ZzRZbDh1ekx5elRHNWNkaGlEeGVFUU5WTXdoU3BVK0ZFN01mWmpoRjBaSTVS?=
 =?utf-8?B?bHZIR2JySjZsRFdWRzJIdmhJV3ZXSXVoTFZYaUY3bWdOK0tSTGJManUxUTZk?=
 =?utf-8?B?UFozMEhuK0twSDV3Zlo1VElCZjNjcE0zTUFIK2dQZ2JvdUFZNHlTTWY1eEZs?=
 =?utf-8?B?d0NwV2lzcnBSNXNnNXdFSnk5QlNjWDkzT1dDRkRrTFprbUFKb012VXNDY2Z1?=
 =?utf-8?B?ZHl1TXJzNUExY0ZveFJXUjEwek9vTlhvMzBUcnFTQ29rb2FJK3BVWmlLcFQr?=
 =?utf-8?B?QWtFdUxtVk9LblBZRnVjeXlnUm1WaTJSVDh1dFhQRmt4SzRLZmJGOUlsOGlV?=
 =?utf-8?B?V1ZwSm81SnlrUGhUKzJsM09aMDNiSkVNc3lFbEtId0VvOEF3cDl0TG5lMm5D?=
 =?utf-8?B?bHhwMEJyU1YwSEpRVFltdVc0SnI0SmppRklmR29obUp1R0cwS0ZGMFdsMGZF?=
 =?utf-8?B?RXZOQmQyR01XaDdVVzJTTUJNU2ZLbFVQZ0hKaHQ0RnNLa01qZFRQVVZjd1dQ?=
 =?utf-8?B?RHFBSENiQ0VKR1B0RTUwTUs5eEk2RXNxNDBLRm5jalNkTlNvS0xwN0JaTXVs?=
 =?utf-8?B?b1RBRnRiclBtZld6S3BqVm1XZElvWTZkY2E2WHRJVHlNbTdMcmwrU010aDAr?=
 =?utf-8?B?NWplaXR0eFpyVHpTQ2dPaWoyOTlPMkF5SXhmUHFOZytnU3p1VWRxbVZFUWdk?=
 =?utf-8?B?UVg4cGZlbURZaEU2RW04YXhxMVp6OTJzMFZlVnJlQXhNeDB6Ymp1T2NOWTZV?=
 =?utf-8?B?Tm5UY1QxSGlnaVhnTzZ6TmpOU2h0N1hzOENhYzZCRDJOWW5pL2ptSE1XWTVh?=
 =?utf-8?B?dzJuNjg4bkVwL3ZnYXBXZGs1UVJCWUNrSHg4NHZKdXRGVFNuYml4RXlZTXh3?=
 =?utf-8?Q?2RKLeEwKT9kFvms1x1pLEaJBaml3jSrjvxxE8/XrJpz//?=
X-MS-Exchange-AntiSpam-MessageData-1: rtVmfIo3hck95Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a273b47-bd90-4f6a-6b8e-08df38feee94
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 16:32:48.6369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8aw8JrnjyUxDLeJhqaccjvCQo59Ao1DWFybNO6lqdbHxzZZOQfXLux0Mlh8gW3k0Qbg32lcAEzwEKEOrKXrkoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10670
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 17:30, Eric Blake wrote:
> On Fri, Oct 30, 2026 at 12:08:24PM +0100, Denis V. Lunev wrote:
>> On 8/12/26 14:14, Denis V. Lunev wrote:
>>> qom-set of the 'drive' property is allowed on a realized device and ends
>>> up in bdrv_replace_child_bs(), which swaps the node a BdrvChild points to
>>> without telling the parent anything about it. Every other way the size of
>>> a node changes goes through bdrv_co_truncate(), which does notify, so a
>>> device model caching the size of its child has no way to learn that it
>>> changed.
>>>
>>> scsi-disk is the one really hurt by this. check_lba_range() validates
>>> every guest request against SCSIDevice.max_lba, filled in by
>>> scsi_disk_reset() and updated only by the READ CAPACITY(10) and (16)
>>> handlers. Point a scsi-hd at a larger node and every request past the end
>>> of the old one is refused with ILLEGAL REQUEST / LOGICAL BLOCK ADDRESS
>>> OUT OF RANGE for the whole life of the device, which Linux turns into
>>> EREMOTEIO for reads as well as writes. It is silent on the host:
>>> out-of-range requests are answered by scsi_check_condition() and never
>>> reach scsi_handle_rw_error(), so there is no BLOCK_IO_ERROR event and
>>> io-status stays 'ok'. virtio-blk and ide call blk_get_geometry() for
>>> every request, so they end up with a stale idea of the size but never
>>> refuse I/O the node underneath can serve.
>>>
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> Cc: Kevin Wolf <kwolf@redhat.com>
>>> Cc: Hanna Reitz <hreitz@redhat.com>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Fam Zheng <fam@euphon.net>
>>>
>>> Denis V. Lunev (4):
>>>   block: notify the parent when a replaced child has a different size
>>>   scsi-disk: refresh the cached capacity from the resize callback
>>>   tests/qtest/virtio-scsi: cover a replacement that changes the size
>>>   tests/qemu-iotests/qom-set-drive: replace with a differently sized
>>>     node
>>>
>>>  block.c                                    | 13 +++++
>>>  hw/scsi/scsi-disk.c                        | 16 ++++--
>>>  include/block/block_int-io.h               |  3 ++
>>>  tests/qemu-iotests/tests/qom-set-drive     | 14 +++--
>>>  tests/qemu-iotests/tests/qom-set-drive.out |  2 +
>>>  tests/qtest/virtio-scsi-test.c             | 63 ++++++++++++++++++++++
>>>  6 files changed, 104 insertions(+), 7 deletions(-)
>>>
>>>
>>> base-commit: 3e3ccab106f879b1512f8e0d51a827dd4de30e22
>> ping
> Looks like this one has sat for a while; while it is not directly
> related to my usual NBD pulls, I'm in the middle of preparing a block
> layer pull request today so I'll add this one in my queue if it passes
> my testing.
>
That would be very kind of you.

This one is circulating here for months.

Den

