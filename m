Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B448608360B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=oouKAn2U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOzjt-0001RB-IQ; Thu, 05 Nov 2026 10:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xOzjr-0001Ql-Hl; Thu, 05 Nov 2026 10:50:55 -0500
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xOzjp-00037Y-4r; Thu, 05 Nov 2026 10:50:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNzgDHTMSkTQpubb6F+hCRjvVibqRRIBIJiM5pytCXIJ+RTblNePjSFJcFP8swK+b6yzpmjyxlxzBbmtBAn3Qu3fx5gdgyb4exQmGWrDxXTXQPS2YxvK+qCgcl6XNvdDhUOGjWwudtPhIpps7UrjlusAIDEZ8C6AGuxYXAlU4HjSYsajja4+H0d1u9bspcnT2IRO/iBwWoqc51fyLBMVxa7dlAgiYT8YHpc8or5hZSrvHUCDYc3rOi05hw2vtCUQcx0kulMZdLacCEyP90yr1pqSVMouQhAxtA2UfdsWVU4CrwvF2FQmpzQNfcdeC/sQ28IPpTqNbwcsgZ5LVy6N8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9ViihKFcE9+d08lFkLJ4/YdH+jYHNQSBTCfgyz3jyU=;
 b=s1XTonn8n0QIVSd0rhdZHbPy0YDUpCENchHRRFmKpmLveI+/hBJ2lUkluAsqXVl8KK6Tb2f20jL2ra1Ec0GTguFw9Rh0uUQvqJy5QdraxZ9yuMSv1E5PY5bxUetD1XZDUuTsk1KeEKwuYmPi3+V5jab83fFDZ8CBStX73hnvr/3oCgToUcIVW476QQyig+eMr16eYv8Rwj30KxFNrc2vOocdtFqV4+CeL+6bNLMx3CvpK27KyUoupsCk8rpmzSyrGo8taEF7I3/boI5ZZuFe6WmTzj2TXivFTKob6Mxov9ul0SUHxoqsir73Ub6q7Lz4KcoOPHMAWo+3vQI77sRMhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9ViihKFcE9+d08lFkLJ4/YdH+jYHNQSBTCfgyz3jyU=;
 b=oouKAn2UUdjM0NbW/fR6csROo8TYJ3eqs3FFBb/ShiGIEH/EiOxFQ/02+v44eDq9EmtaK7CSPum9HUihcmMYQ8xim2j53D+LVYa2JA134pix68Lqt6UFFmibKYBIjBSyD9qvkJTDvThZgfWsFo+LW5mev1Wwr8x2LLZ6e+1VTWG1+p/DH85UHN3im5go3C/Yq4HWQm1QRjq0GC54EWTFj3GzD2L1sAqZKtgcA2ML/BiBVfBEmprtEw0mbhflP/uqhb/gLPNd4/D3xzz0nInYqJ9khyQPFG8y2tdFhW32YS0ZGSppPxWTN+JLczALaDWRaqF0nVHNosfV+Zp3XcoZCA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PA4PR08MB6094.eurprd08.prod.outlook.com (2603:10a6:102:f0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 15:50:46 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 15:50:46 +0000
Message-ID: <d5a7e7da-7996-485a-9dee-9d893d10addf@virtuozzo.com>
Date: Thu, 5 Nov 2026 16:50:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] block: notify the parent when a replaced child has a
 different size
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <20260812121500.1034178-1-den@openvz.org>
 <20260812121500.1034178-2-den@openvz.org> <aumxKEG88eJAAupA@redhat.com>
 <ab8f044d-79ad-40c0-8857-50cef77b0b68@virtuozzo.com>
 <auyju4uLIBaCGPKH@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <auyju4uLIBaCGPKH@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0074.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:349::17) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PA4PR08MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: 2690d3cb-6371-422a-6a8f-08df3b548e3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10070799003|6133799003|10067099003|18002099003|22082099003|56012099006|4143699003|261022075727099003|261021121427099003|261021123027099003|5023799004|261028144727099003|261102123227099003|261026121527099003|261022105027099003|261102130727099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: BA44v+FXCaPBMjNDj5020zgvZHx2L7hnmJKMUL4AKlQsjWy/H+ZFbZQF/cQGkrBiwGC60J2tAENYsXdPnghxpWgZ19H+q+lU/cJ7CXgjzA07IuHd+0tiYRvUMXRdJP/fLEMZQ2yLFKSqqvAH/8DZNDShPYPEhvD+hwPnOmYL7/zwHz8STMDB4ymifoZfOXlryvCQ9XJVrRImlSjyDbFsjP8muux8DzGCejzsWxKt+ee+aIQfyDkUn4Mt74dLI6aOggEYggVn8AngkmJ5b7VKqJKggKc+g/ocBwOB1PNuwTd+XN0WeN6IWyNdFW6WLtcHPE/dZmyeM9OnTWmctoTjHgjFKnz2aM27xxHVmIeXFrimIjOObnBJjQeuqsGVqxjOy+tGTRA8yYU5OEAS09dRpgGbDtBv4KIJEWBHhN4cRGL6pZZsT/UylOuLAsfmgRiMKbhFqsehTUz+tAklpu1+haZfD5M5iBXxh0enjxsL68TUCeNadRJ4DI0wITtsyTl/HZWWWvjL44+tqsAh+03RtNqJtzA04ZbeXpdge0RImFJ6E1c2aC2DPVJI6W2fjSbPrOGECeQq8DlxLrBHvOpaglhRhWkmmJPhaa2Aa7a8mV0OzxrO87eGV/1iBfu3EZugico4G7ESfiUIj3DOr7+ia8mCWCUnmZweA4eQcKbElKE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10070799003)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003)(261022075727099003)(261021121427099003)(261021123027099003)(5023799004)(261028144727099003)(261102123227099003)(261026121527099003)(261022105027099003)(261102130727099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFlqVmlPdWhIUzB5K1hSSnM4QkZTcHk0ODFPRnVUUmVNSy9lMkJUV2tWSWtL?=
 =?utf-8?B?LzhCUVR2TUpzcW1ySUg2VTI0ZGh6UE9vRVc5MkNaQlNhTEJ5QnpHUWxyOUVl?=
 =?utf-8?B?NUpPTDZnU3hxK3BZdTh3OXd4WHhOK0FvOEFQajV2RC9ESnhuRDJVUUxUUnFn?=
 =?utf-8?B?ek1ySlF6bVZwYTU0bExNWEFhMlVRQmZ0RTBRSzlBVHBqc3loRGpITzRWVjRI?=
 =?utf-8?B?WkdYMnVFc01vbFhvVUhacHZBR3Y4dW9xdG5xRVZGOE9iWnRLNzdyV1NWblUv?=
 =?utf-8?B?L3BBakY3ZjVvNjRkMXFKTlhsaExaVFdlR2FtRUlHRU40U1V5Yjg0Y2JqcDRa?=
 =?utf-8?B?WFRuWDRTMk4vS1RySjY3Qi9yNmhwMzRSL3RqeVZ1STB3Sm5uK21sRnlkZGdR?=
 =?utf-8?B?cWxxTWhLcWhTc0FQTTViUDJlYVA3R0xraFlrU0hDQW0zcnV1bUcyRWxKbC9P?=
 =?utf-8?B?eWVhV0lJTk1lV0tTbXVQZkNvZ1pCMjl1QjYzZ3F2VjBnRnZFem13bU9MV0Fo?=
 =?utf-8?B?cmh5MitMNmt6czg4OEVDSEJNRXpRTklma3NMQTNTcHNzb2ROUEhDOEU0d0I3?=
 =?utf-8?B?RUVWOG5BUGlzSjVzQzU0RHRJcTJ1UVhuV2FOMWNWZ05FY1RwY1JScTNNSUIy?=
 =?utf-8?B?YjlCS3J6TjhhaXJ0d2U3UVpPcWhtaWNjbWR3enFZYTczTkQzaDE1cDJCNmtq?=
 =?utf-8?B?aUczY2F3aDh1N3ZnZEpoUWZsRG5YNUJxWjBrVTZjbnZTczJ1L2V4OFBpemRv?=
 =?utf-8?B?aEpxckcvaWRBMUVEejVMdU9HVkh4clU0Y0MvRjAxTUlwbHhkcWdiNUNyVGo5?=
 =?utf-8?B?aWY0WS95L0xNcURBSVBNcXdEQUlIRWZOTkV5eGRxZ2hxajFIOTU5V25uckZq?=
 =?utf-8?B?QnlvS1lJeTRQOWFqK2JLNXpVQmJiMnRuc1FPM2dhV3JhWHZUQVEyVFluQlow?=
 =?utf-8?B?b3dYcGlicnJHeGxzdTRoVjRFVmI5eStPTTZBWkY0M05FNE16MDBmWG8rajk5?=
 =?utf-8?B?Zk9saHBNY3p3cVBtMEQ1UFBDM3N6MS8yWlY1MEc0UU5PTjdQblY3NFdWMUxH?=
 =?utf-8?B?M3FtRGZqWU5pVDlMZkFBV09zVjBwK1dUbzBVTUQ2cmZLd2VrTHNDeGk0bFMw?=
 =?utf-8?B?ZllKLzNsUThXWWlhbGI2bDk3TENNUVBzbGtzdFpkVTB4cTc4Ly9UMDF1bVUx?=
 =?utf-8?B?VlplR2ZBS1dYc25HZWJuOS9wamF4bmQwK2pNeDB3aldOSUpIRmZ3aHgxaHRv?=
 =?utf-8?B?bGV2M2lPc2hBdVB5ZDNSZlErV3p2TUM3SlQ0QS95NkJnNDFObUMwUGROa2V6?=
 =?utf-8?B?TS90a21uWjdHTEdzMDV6VG9kS3hBNFdJcCtZS1o1ZE1YNnkzU3h0cTNORU1B?=
 =?utf-8?B?TDcrTE4rMlM2Q0RzanhZUGFvU2hHeU1BbDBPV2xic3ZuSW9pRWlVdkxQOTg0?=
 =?utf-8?B?dTY4eHJVY0cvckhsbkZpV1kzTUQyN3VDUGl5ZFVhRndCcXlZQ3I4My8yc0tr?=
 =?utf-8?B?YjlaUTFxbzN2cDJNQ0c4UCtwTm9kMDFuSzE4SUNFamRtakNRUVBmWUNBZ0w4?=
 =?utf-8?B?NzJwZW01TkxOZkhraUh0QVFScCtJeUFVcTNzSkJWa0R4blZlcmlHSVFGOWJz?=
 =?utf-8?B?ZFo2TisyeHgxOUJVNzdtUnRxaFFHS2JZa3RhWlJnTHdJcS9rYUhKcFo5MHZX?=
 =?utf-8?B?VkZhclFyMENJVHdhOEs4U2lxMmtkQ29KcHpBS01scjR6STl5Wm0xY0VnbjR5?=
 =?utf-8?B?czZnckZrN1RWSzYwSG9Ja3dmQk0rbzlUd1JpTldGbDI2aDJnR1EySENOZVJq?=
 =?utf-8?B?Vk5GZFlKTDJSWHhQanJKbnplVnRiSkh2TDNmRlRBQVU2VXBVTGFyYUxxajVV?=
 =?utf-8?B?R1R3TnVxcFVkaGRCVTcrZTF0SU9jQ2Q0RE1aWXFXeDZUUzBNK25UamVtbkJn?=
 =?utf-8?B?bnlOMnBBSFNBaGkzMnBmOFhoSEUzdFFzY1ViaFZ2UVhrcWx5akt2c0R6c1BP?=
 =?utf-8?B?MVNmSkRnRVhsajhhWmJyTEJYbitkUG1pRW5KeUF0R2xObnlzSXBOQVpKaUZh?=
 =?utf-8?B?WHVlcnY1SFRGMFZqWFdWQWhDSThqM28xUnN1SFBCQmpqVGxNNlRXOFNqREhj?=
 =?utf-8?B?a3c5anNpalZrOFFJdkRwbm5SWUd4c2F4UndSSHhDMWpmendVcUhCUVJwWVUr?=
 =?utf-8?B?a0V6cnpXakpNZWZqOHRDTFkwZkwrbHZaNXhWTVorWjhkQndSelM2bFE3d1B3?=
 =?utf-8?B?YjRrUVlQbFNrcVJOUVkzaEpmWjhrQkpURlY0QVVHS1h5NUVoZ2dMUnhoNEVu?=
 =?utf-8?B?RlRrZGxRVitvY21lRnJ4bVM3Z0VtSDFwaCtMQkltQ3pjT1pEUlAzb1pvMUd4?=
 =?utf-8?Q?vAwea/0zr7uMHfoYEJD9Y1uTbX/J1WzPfYrXbl9ZquX9+?=
X-MS-Exchange-AntiSpam-MessageData-1: biRm2Yl6buWm0w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2690d3cb-6371-422a-6a8f-08df3b548e3b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:50:46.0665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 100n5zRnE2v3Cj7Ti3uEV5PBgttkTHunbmRC3sxJqCidhxwLRvHIyDqRo8CvPguTallbMn/CZB+GCaQU6QfVng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6094
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=den@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 11/5/26 16:41, Kevin Wolf wrote:
> Am 04.11.2026 um 15:50 hat Denis V. Lunev geschrieben:
>> On 11/3/26 11:02, Kevin Wolf wrote:
>>> Am 12.08.2026 um 14:14 hat Denis V. Lunev geschrieben:
>>>> bdrv_replace_child_bs() swaps the node a BdrvChild points to without
>>>> telling the parent anything about it, so a parent which tracks the size of
>>>> its child never learns that it changed. Every other way the size of a node
>>>> changes goes through bdrv_co_truncate(), which does notify.
>>>>
>>>> The device models which care all register the same BlockDevOps hook:
>>>>
>>>>   virtio-blk  resize_cb = virtio_blk_resize(), ending up in
>>>>               virtio_notify_config()
>>>>   ide/ahci    resize_cb = ide_resize_cb(), refreshing the cached size
>>>>               and the IDENTIFY data
>>>>   scsi-disk   resize_cb = scsi_disk_resize_cb(), reporting
>>>>               CAPACITY DATA HAS CHANGED
>>>>   xen-block   resize_cb = xen_block_resize_cb()
>>>>
>>>> Only scsi-disk is really hurt by the missing notification, because it is
>>>> the one which validates guest requests against a cached size.
>>>> virtio_blk_sect_range_ok() and ide_sect_range_ok() both call
>>>> blk_get_geometry() for every request, so a missing notification leaves
>>>> those guests with a stale idea of the size but never refuses I/O which the
>>>> node underneath can serve. check_lba_range() compares against
>>>> SCSIDevice.max_lba, filled in by scsi_disk_reset() and updated only by the
>>>> READ CAPACITY(10) and (16) handlers, so with nothing to make the guest
>>>> re-read the capacity every request past the end of the old node is refused
>>>> for the whole life of the device.
>>>>
>>>> This is reachable with qom-set of the 'drive' property, which is allowed
>>>> on a realized device, and it is silent on the host: out-of-range requests
>>>> are answered by scsi_check_condition() and never reach
>>>> scsi_handle_rw_error(), so there is no BLOCK_IO_ERROR event and io-status
>>>> stays 'ok'. The guest sees ILLEGAL REQUEST / LOGICAL BLOCK ADDRESS OUT OF
>>>> RANGE, which Linux turns into EREMOTEIO for reads as well as writes.
>>>>
>>>> Emit the notification from bdrv_replace_child_bs(), so that every device
>>>> model gets it through the path it already implements rather than any of
>>>> them being special cased. Send it only when the size really changed, which
>>>> keeps the callback out of the common case of a replacement by an equally
>>>> sized node.
>>>>
>>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>>> ---
>>>>  block.c                      | 13 +++++++++++++
>>>>  include/block/block_int-io.h |  3 +++
>>>>  2 files changed, 16 insertions(+)
>>>>
>>>> diff --git a/block.c b/block.c
>>>> index f0a6042e61..1fe66caf8d 100644
>>>> --- a/block.c
>>>> +++ b/block.c
>>>> @@ -5524,9 +5524,12 @@ int bdrv_replace_child_bs(BdrvChild *child, BlockDriverState *new_bs,
>>>>      Transaction *tran = tran_new();
>>>>      g_autoptr(GSList) refresh_list = NULL;
>>>>      BlockDriverState *old_bs = child->bs;
>>>> +    int64_t old_len;
>>>>  
>>>>      GLOBAL_STATE_CODE();
>>>>  
>>>> +    old_len = bdrv_getlength(old_bs);
>>>> +
>>>>      bdrv_ref(old_bs);
>>>>      bdrv_drained_begin(old_bs);
>>>>      bdrv_drained_begin(new_bs);
>>> bdrv_drained_begin() involves nested event loops. Can't old_len become
>>> stale here? It would feel safer to query it after draining.
>> I do not think it can. The only caller is blk_replace_bs(), so @child is
>> the root of a device and old_len is the virtual size the device checks
>> every request against. blk_check_byte_request() refuses writes past it,
>> and block_resize is a coroutine QMP command, so it cannot run while the
>> qom-set one does. Any size change that does happen goes through
>> bdrv_co_write_req_finish(), which notifies the parents of old_bs, @child
>> included, on its own.
> We're operating at the node level here, not BlockBackend level, so the
> node could have multiple parents. For example, in the past, surprising
> changes were sometimes caused by a block job completing at the wrong
> time. But you could just as well receive a truncate from an export that
> is run during the drain.
>
>> If the size could really move in the middle of a replacement, comparing
>> it at this point would not make sense in the first place, no matter
>> whether it is read before or after the drain.
> If you perform all of the querying, the comparison and notification
> within the same drained section, it should be consistent. Then you'd
> either get the notification from the concurrent size change (if the size
> change is run first) or from the node change (if that is first).
>
>>>> @@ -5542,6 +5545,16 @@ int bdrv_replace_child_bs(BdrvChild *child, BlockDriverState *new_bs,
>>>>      tran_finalize(tran, ret);
>>>>  
>>>>      bdrv_graph_wrunlock();
>>>> +
>>>> +    /* A parent caching the child size has to learn that it changed */
>>>> +    if (ret == 0) {
>>>> +        int64_t new_len = bdrv_getlength(new_bs);
>>>> +
>>>> +        if (new_len >= 0 && new_len != old_len) {
>>>> +            bdrv_parent_cb_resize(new_bs);
>>> This notifies other parents of the new node as well even though nothing
>>> changed for them.
>>>
>>> Especially since you already query old_len/new_len to avoid unnecessary
>>> notifications, we should probably call only child->klass->resize(child)
>>> through a coroutine wrapper here to notify only the BdrvChild that we
>>> actually changed.
>> True, but the extra call costs nothing. The resize callback re-reads the
>> size from the node: virtio-blk sends a config interrupt, scsi-disk
>> raises CAPACITY DATA HAS CHANGED, and the guest finds the capacity it
>> already had. A second parent on the new node also needs share-rw on both
>> devices, so this is rare.
> Yes, I think you can argue that additional notifications don't hurt. In
> this case, we should be consistent and not compare sizes for the parent
> getting its child changed either.
>
> For a node with an existing parent, notifying this parent if, and only
> if, a newly added parent experienced a size change is really strange
> and will make everybody think that this code wasn't thought through.
>
>> A dedicated coroutine wrapper for one call site does not look worth it
>> to me. If you still prefer it, I will send the patch. 
> You're already adding a coroutine wrapper for bdrv_co_parent_cb_resize()
> in this patch, so I don't think it would be very different.
>
> Kevin
no prob at all. Will do.

Thanks,
    Den

