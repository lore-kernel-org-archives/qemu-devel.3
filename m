Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B26606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 23:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=X//5MPLh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO1oK-0003Mn-2u; Mon, 02 Nov 2026 18:51:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1xO1oI-0003MY-PX
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 18:51:30 -0500
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1xO1oG-0002lK-Qm
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 18:51:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQ/nT7Jfwg8g2YAvsDnd7+uTj+PBBlsuKEKn6zdbQSiGr+McfGqZn4cdh7QqUmaAA6ifu+ZqroHUZjzKKX0Bd530nz3Q5IzYSA5Kh71BEM1BoHq0PLtHdj//rRoAaswcIs/GZ8bfgAy1LNU6U4G+yv5OTpXUoOG0rd0MZj1qopSEz0s8mxcEka98icxR4Sx7NVCkOFzN1U3ZQPrNCbnXBVT6tXGNCxBjKPhNu2pcywktu1M0v+YuVjYPoV24BAtXRK8dQYcDamnJ1UowqTY/8bSuUj5uCF5bG4QiakVD0C7NuaCe/7QSMJ4SHsE0lIO+w2uCnTxiuuVJgWq05GN5TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFVF4bG6nGclac0h5BAnmleDN5u5XxSasr/GG6cZLCA=;
 b=CltQWW4AUwJKhU+R85XKAbuqcfFb487MSCE7Vy3FLw6MxOmwMrl0GuZ7dPSyv/E2ce92FoieFWJVzdlWXpWXI0W89dtErv+TSD9xbRGMdBYG1vJYQTHuhJHi7boUwNJVwzRgjXRXbqfdzFbrRZj+Z0TohvS8JTYP+VJErrSTXEuhAhoXVWVYuhxbi5bD4Hrivt9PQMw8Wmpyuqp/4mMmOqz0qcfI+KSVShK8+Oo3MdJifjK76MWnPj4vUJl5nwgmQLM3A+ivj/o91RpAtvnCywYof7Nt1Kr7irmhpytRvoX1+Pts29xccIV9vEh/0fvYm2/TNZL/3ho/MQegbTW/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFVF4bG6nGclac0h5BAnmleDN5u5XxSasr/GG6cZLCA=;
 b=X//5MPLhiKqILBxAE6sYAybO/fEeHlOjXXFTsY9OesUcWYlye5/e99UwOh+9W+Qhwk6C6KKce5FpIL5UsBV7rIsCAjBTAO1WepD1F9mgtsrqR8EZXiHU9YCvDCr7X2mvfNkpeet3K1gaXWANOI0zzIjbTN4dOkI5yawcBP+9LGDfN0tf53RCTCLA263aaHQ+TJJOCisL+v+MjqtlMMKQSMbsi3YBWqNXwHuVH88KGg1GkVqaLeKOeEibhjiimF0ckr5HfgBFLjyoXYlOMVXftNP2yVs/rf8RtKOSeAbZvqEqQFr0Omh1cxoGxom8bpxDNvM6kmFQn+stBBQsQwXDkw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by VE1PR08MB5679.eurprd08.prod.outlook.com (2603:10a6:800:1a8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 23:51:21 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 23:51:21 +0000
Message-ID: <1112afee-0141-4cbc-9597-91160c6a3ad6@virtuozzo.com>
Date: Tue, 3 Nov 2026 00:51:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] virtio-scsi: fix hot-plug event racing device realize
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20261023162000.2796947-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20261023162000.2796947-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0273.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::40) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|VE1PR08MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e128d1-d5c8-4f97-0bfb-08df393c324d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|23010399003|261022075727099003|56012099006|261009223027099003|261028144727099003|261102123227099003|261026121527099003|261021121427099003|261021123027099003|261026140227099003|261022105027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 02mNPCBbJQ3F0BDtsIrJ6YnPTBLFAdA5uZRvvvvDcp5dHosZtck7QvdOFSg0tD+684dsI1VSJdahcpED4WXvK5r3yEuAya5zW+jlo9bNku9NyP4QjewGnjLfR7emCFsaoUtNV/DyoiWWmQZlqr38stshOcqU/asykEEuc3Okh8kx/ZfdnFN1wXK0GwWLOZnqOjaFcmwnz/ZO7EZpy4oxHpxgATsGWSEEJzB1jfwL5ZF6VRAR3+hsxwfY6g2TB8f/UZ9qrdHvL1mAYVcEQteTW6jAiePCalG/9Ij4Dfvh6Hjk72iabw76PbQc7ycIjodYDKlr8Z3uKxuC5VJwZYaYd5G32Yx0wKX+Yk8/dCQ/xFSCJIsZ++f8uQkaeEbzVw0GLcO+/k1XxqVjGmLoYnoyGJgxiSVL4P6arMyOZc/T/h5NCSSeO7hbKXDW+oNHu9S89iCS1sGpPL/H74wfAXja5SbqrZZL/T9BC2H2Ya2Jl4mXVLcGfp2uuVkmq45gRXEyFmI7UO7IaBK9J3OThEKKL5lZCp/c0V2qecVCFrv0Q2c2xUA5fEXKz3OSMadEwLYQZcZ7qWqXzrH0gA84pUi82rivk7mSZgeSmOfe7Wcu26dJX5wEt7ng7JIpInF5kvH+2wHAeV/GtHF9HXj7ufuFdHafxNyekvcxX1eQ56An06o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(23010399003)(261022075727099003)(56012099006)(261009223027099003)(261028144727099003)(261102123227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261026140227099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0NNZWRhdDcrN3NoOGdtUkNTeXlESGprT2lFMHRycnFQMk8wRG8vdHI5QzF1?=
 =?utf-8?B?S0lydXpXMXhGSU5zWlFzK1g3LzZXdGg1akF2Zmpmdk1yZk9hNy95bjJtWTJ5?=
 =?utf-8?B?cDBBV0N0czhueUpXQU5pcXdNRG9JczZMOEpOS3NBSEFnb0JXRTNQeDVuZW1p?=
 =?utf-8?B?UEFyTlozL1dlOERqamNEYmFaeEJYdkVTcmQrNE5xRzcrb0pDckJaNXFpM0NB?=
 =?utf-8?B?WGFCc0c1dmJmbnFvK1h5M2Y4SklKQVF2WFVkbDZkYm8rbGc4MnRRRnV3Vk1s?=
 =?utf-8?B?Y3Y2bFpwU0tiQ1B3ZThsaW0vTDZGOU51a1dtM1ZZcnY1ZEhiNTIwSzZ5YjFO?=
 =?utf-8?B?clRHbnZNeWlxWjFCRndvcVkwK1EzcU5CeU44NGhrZnBTVFRjRVJ1TE8yRWlv?=
 =?utf-8?B?WUV0MzVxWjVHVUtJNG1JT0Qxcmkxd2RLNEViTWRJUFA0TVUvRld1UnEwckRP?=
 =?utf-8?B?SzBjU1hkRFd2MDFCY2s1TDRpcG42dlVWR2ZrU2xITElyOGZGdjBNcndwTDhh?=
 =?utf-8?B?V25zUWEva2J6c242MmV5UlNVemN6a25jN01ybHVkZWxIbVNqazc4VW1XbTdO?=
 =?utf-8?B?MjA3QU0wYmV3WENJV0hKWUdUcGRnSno3TnRGMlNBMUE0dEtacE5WeUdmME5S?=
 =?utf-8?B?MC9nQUZ3NGhQYzVnSFNVd1B0Tmsza1hGU2VuOUFCQStIQjZ6WTAyeFlPWVNL?=
 =?utf-8?B?TjAxUEtyVGFVNEpwYkMySGhJblpLcjZVNVRIVkp3V3E0d0RUZ1AvZUFOZklJ?=
 =?utf-8?B?c09NR01WVGVTdThWaUVBeEtlUFlsM2Q2SWRsSTJhSUlQWk5kS2czMmI3eVFT?=
 =?utf-8?B?SEFPeHJUZ0RLcEdaK1dFRnJTWDZuMmZDcGU3Y09wZFZjVUZUMjhodm5jR3B5?=
 =?utf-8?B?TkNUTE9mUjVrbTRUQjBtUEx5ZXNnYzhWQTRkR3FlRDd5VFpXdFJINWxSVVRm?=
 =?utf-8?B?S2JwY3FrUEVRUUZmaWJNNlprUnU4VFljSlF4dkcxaFpMTEdVL29VVEVpRXJ3?=
 =?utf-8?B?ZDdZNWdhY2NDZ0F6Qmo0emQ1UTBsa0VsVS80SUV3eGFTVW1mYU44WUd1STFF?=
 =?utf-8?B?UGcrN1dOUjY2Snp2STRpUWxEemMrZEE4OXVYNk82dU96UmVaTkhjL3J6VUln?=
 =?utf-8?B?ckVaaVZJeTdjanp6eWZ5Y3UwbDAzaTFoWWt4bG91cG1PNTRCUTAzOFgzVTd4?=
 =?utf-8?B?ZnlhYVRITXZZMktxbzJLZll2cFZMejJrbjhuZE1GZVd5U05HWm9sUDNPby9u?=
 =?utf-8?B?c0czYWFTZ3B0TlZ4VXFzRTFSK2VLbGZ0TFJzaXk1OEpUMnJ3ZlM3VVFlN0gz?=
 =?utf-8?B?TGEyYlFib2VhaFlmSHdhelNlMktuQ0l0L3lVRDY5cldrbkt6Y09SV3lQQnBq?=
 =?utf-8?B?OFdIVFVrNDFoWGs1VkNEcVA4QTJ0YmdjMCtERHAvenhDTlU0bkVOeTVQVFRo?=
 =?utf-8?B?ZGgzTFBmNlM1ank2MmsvZC9sQTBBQW5qSzJqMDhOcDJzVk5pNkdwbU1LZ05u?=
 =?utf-8?B?ckNvbDRqMmRHT295ZjVMNFlDSWVqYVMrVGgyUFV6ZkZ3QmF0SnFWRW4vQkdr?=
 =?utf-8?B?dFZSKzhmQms0dFVNZVBRVEEzNHhSZ21jSit6R0QxcVZVMCs5Vk5TZG1UbHFE?=
 =?utf-8?B?dDNmMnBEUnhldGxDZVVtbzBCN2FNNUNLSC9tV28xKzA2ZklPdXRLUmx5WStK?=
 =?utf-8?B?VW50WXZXMnNuQVgxMjZ3cGdIWTlwdStiNDFIeUZMYWV6OFdXMVVsR1BwTnha?=
 =?utf-8?B?WVF0M29VN3B5TkdUS2IwL3E3UE44Y3lveEh3c1B3TTRKcVQxdDdFZjVSNXBt?=
 =?utf-8?B?WkEwTnpKc3pBazJ6T2VXa2E5STZTL2VTQTNvcUlBQUxqMkVSVDNXWTRCWVhx?=
 =?utf-8?B?RmNiMnlTdE1jSzdVdTFOclZSbXN1NUw5YitwOVdITjc5RG5wd0tnUEp0Vjd5?=
 =?utf-8?B?eTJZM3VlbTZOekVubG9MYlYvd25JbW44TnRsMWZVREdqRlVxL3prWnh3L0Nr?=
 =?utf-8?B?eDJkbkF3MXJnbjBPZXkvU3pBcnRTbkllNmJFNmlJL1ViWnBSbGo3dUpBclUy?=
 =?utf-8?B?dlJzWHhCVGlRaUxBWmdTRHNMNVYrWC9WbXliK1gxMUkvUml5SnhNN0tLRDFU?=
 =?utf-8?B?SDVNVlJwZjMwbHJmN1NtVzd3ekVFU1BZTHFaWHE5QUFoRGxQSTVzZkJWM1Bv?=
 =?utf-8?B?UDdTNXk5OXo2Vjl1WnE4RUxtNlRZWFdVeGJ6ZnBJYi9sMjBSNk96VFRlWU9u?=
 =?utf-8?B?UmlNTW11RkgvSFlTS2tQd2dDWkg1a2dKNmU2NlNWK2pZNmZxVnJOOTFkRlBC?=
 =?utf-8?B?WGR1SlVUdW9hWE1ncW5GU29NN2Y1RVFTaWxOSjA4RHoveFphcjdaQnp5anBE?=
 =?utf-8?Q?Pmafq2SOUK1IW6rIjyrFgQTMJ3z61/+NH1gjW7jpSrIvg?=
X-MS-Exchange-AntiSpam-MessageData-1: B//DmG8DjshsMA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e128d1-d5c8-4f97-0bfb-08df393c324d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 23:51:21.6546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqNuZ9TKhHWGty0RiC5fl0QIosU4krhZoHrVYjcEmoDALoeexI8/hHmuxCbXdSES3pcH6jei7BYQ1AtlmXxDZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5679
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=den@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

On 10/23/26 18:19, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> A disk or CD-ROM hot-plugged into virtio-scsi sometimes never shows up
> in the guest. QEMU has the device, the guest has consumed the RESCAN
> event, and a manual bus rescan finds the LUN at once. We see this in CI
> with Windows Server guests (vioscsi) and with Linux guests, always with
> the controller on an iothread.
>
> The event is pushed from the plug() callback, before the device is
> realized, and the iothread request path does not see unrealized devices
> since 8ddf958e8d62. A guest that scans right away gets BAD_TARGET and
> does not retry. The patch moves the event to a main-loop bottom half.
> The alternative, letting the request path see a plugged but unrealized
> device, would undo what 8ddf958e8d62 protects against.
>
> There is no test in the patch. The window lies inside a single
> device_add under the BQL, and a qtest or iotests client is served by the
> same main loop, so it cannot send a request in between. To reproduce, I
> booted a Linux guest with virtio-scsi on an iothread, ran QEMU under gdb
> in non-stop mode and stalled the main thread for 3 s in
> scsi_bus_set_ua(), right after the event is pushed, then hot-plugged a
> scsi-cd:
>
>   break scsi_bus_set_ua
>   commands
>     call (int)usleep(3000000)
>     continue
>   end
>
> Without the patch the guest never enumerated the LUN (3 of 3 runs).
> With the patch the same stall falls after realize and the LUN appeared
> every time (3 of 3). Without the stall both builds pass, which is why
> this only shows up on loaded hosts. tests/qtest virtio-scsi passes.
>
> Every release since 5.2 has the bug, hence qemu-stable.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Fam Zheng <fam@euphon.net>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>
> Denis V. Lunev (1):
>   virtio-scsi: fix hot-plug event racing device realize
>
>  hw/scsi/virtio-scsi.c | 38 +++++++++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 11 deletions(-)
>
>
> base-commit: b6c4b7e86dec12d07f5cac65265b986d38ee9002
ping

