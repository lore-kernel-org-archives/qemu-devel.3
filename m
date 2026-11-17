Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C4B606A331
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=XgihinjS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTPJa-0003ta-0s; Tue, 17 Nov 2026 14:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1xTPJY-0003tC-DK
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:58:00 -0500
Received: from mail-westeuropeazon11020105.outbound.protection.outlook.com
 ([52.101.69.105] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1xTPJW-0000NG-QZ
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:58:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMmWqa9vGSFzwNqXanjcbSdce+uNVIJf4X88Lz/TrTyoJDLAIETF/sJmfqqei0tRCSH/3hwhTI+Gzcr8l6sYgp8z7CYko/s5Yzcccj8Qt11cJZPPsfC9g42uQjtHnzDBnVwqlc3g9C8Jp+dUzy5YCFYK+gxXCs+T+Enaw9LfEIkaYn8Ms/wOigmzzthlFbpdMUoCdcF5vYfAh2ACwH4Z5i77TQhQ79Ejh1jNJShtFT9bhMDXl8NuFJvxok/0kxpQ3lX/AtzjuI0DwB1iTEU9H0AUHJn4X00li4UGr5whJZvX+dL2aVuZY6QhRc1VVWVYWuu3MLQEyl8cILgELUFApg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOajsumGaNSdO99jXjwoI0RBrD5h05LDguPu89JHRsU=;
 b=aO6vtdyMgIR/T2EVrMM8Gk2mBL/c+Vb1oAFEn1Z2XPEtlR0CzDTObP5a22elQ2juJslhz3OzETyvjnkrW6qkiN+Dk7nrjLuGHN+MlS2zej05/ZTptRcWldLleIntyw15dufIyteMY1dyxuV/Q6PCZuQtfLii0y0AmVY1LMThZVYCBw3QouU5i5OcHPMm6U0MjIwaY0vO6ib2h3ULSTmvZcvgfzzKa2j2sHwFb2fKCtep21MnVmBLyqAajZcUMS8X74JlJ+hzkvBRJNJ9Jz+RigtJm15TGmpUKA1UinZdaL+BqejYEfJsoMu19Z9Edqa2YS/8Gq0i+EF41Vgil9EGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOajsumGaNSdO99jXjwoI0RBrD5h05LDguPu89JHRsU=;
 b=XgihinjSjkM1XqBi7bZySdtlwivMH/NLdc3Uu/tIei89Rb54OZfmiy7U0f5g4dv352ztFMK6F0yTeWhpDt8h7zHFcoWuq53gBmmebZuig3qo8BOhI9DHagAShLyYbkmtL4w1gk9q5lcdQdEmvTJvGR/rZATRsUYICWQ4SWbjwfIBsb0ggXO6mnmlwfB629c1yZK76EiLp+FdtlUmgccCvSvEhkmsQfTqHeBY1j1b/gJG8XSGa1O8FnlRnI6eqGslXq6PveMLgK3pXVO8zPzqS2mBVDjRcLSpa3+s7/ZFkMcZRVZm1KLK9x7pKFY0nuxnxds2eJjKl1dCri1diiJqmw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by ZR6PR08MB497186.eurprd08.prod.outlook.com (2603:10a6:910:dd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:52:46 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 19:52:46 +0000
Message-ID: <bb8ba3a9-66ad-41cd-a482-2cdaa2cd704e@virtuozzo.com>
Date: Tue, 17 Nov 2026 20:52:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] net: fix abort and busy loop when the tap device is
 deleted
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261106200309.122830-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20261106200309.122830-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI5PEPF0000091C.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::92c) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|ZR6PR08MB497186:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b5c5de-f6d9-4706-4214-08df44e45a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|23010399003|366016|18002099003|22082099003|261009223027099003|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261021123027099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info: k09rTjy1+xCxhPfsQcy94vyxL1q0BwEgDuxbOJopPTKQWnxvAYJL4nKRQfsa2gWqPwXDG/GkXBX8EaQK5GQ2Q3PiOyR8Z5aanyeZoFm4Rpq+IpUZIfsJ355sb9Ed3D4aYl64AshLs2dzgXP7xMJxaqcpEJg/Im+HTvLpEQduhj+Tse5Tbgck10qmoYSAi31zddp4vYUA7xZS2W1KX5I8piccK8BZnGIQMFIVT6qsi69JnrIu0VEcNgGyA6d6ci8QFnM+UbVkMRONEw7fjEEj74YECU7qJW2I0xDXGDM2nFXL750ayVG6zh4/KG5RNzpaZd7Lu5hyUkLjIj4V1mDbbDL1wl7qFL8zJcvCIx/UW5hHwUlU/GNmivpSLeA7EHGMUpj08e4AVyFrqZctcrDP/eBPWz7z8AoCN2OOzuKLvyBfO9ZikZwlw5o6MJvv0MR3d9MRWji3/stlqQXTF8t58P+pZMVWOJIyjSLHymdVTfV9Kzd2+HBUQTyS06OfnW1ApLz45Ohj0TmSbIsZN3nkn/e+jkBM/FbJzVC1so4p9uSPgrjGMn0Y1PP/eGQoQ1TVPStULsCsLdD5wYoO/oMfuK8Wye0hqgtOxieVhaXvjp+VtWZDb9eF+i5J2JgDZfEM4mlJsrf5f/rMXgQih1ERY9Mhs9djFuNSsXYvRGjPnY4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(261009223027099003)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021123027099003)(261021135927099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1I3SXlzRlNhdzd2R1VYb0FQUFdkNTZRUThtOEJSc0FxKzg3THRwSGtBK2Q0?=
 =?utf-8?B?clE1T2xmVXBEVEtBellMWnkwYWJGSWt0dGxIM2JSbzVxZUZoQWRWZlZYbkZJ?=
 =?utf-8?B?bEJuSUt5bFk5U0tGVEFnODVUSi9aV2hBK2k5c21qRUd6NExSRGFncWRENisv?=
 =?utf-8?B?cHZLWlhzRitFclY3YkNLWHZoME1hSkZwRFdORGxJR00xWTI4Vy9IeUdwTS9q?=
 =?utf-8?B?KytaM1NFNzBQeTJ4VjFVbTVpVSt5SlJ2MzkybWczb0xVdmVMMnphZERiQ21C?=
 =?utf-8?B?WEduMlNGU0N0Vk5ScWFmekdIN04vTHpnWXBXWEh5OXZuSDcyM21yWENiZkla?=
 =?utf-8?B?cFB4K2RZS2VPNi9rcmxrTnhFTCtzUHY3YldjTi9PcmVXeldpNHlsMFp4REhZ?=
 =?utf-8?B?R1A1bWl0SEI0VWxVTUJRUjJYVHdQclJ5Sk9DcnM0UG8rak9tcXlTYzRLM1lm?=
 =?utf-8?B?VWdYSjdiS2V5L3o2UjMrK0I2UlJ5cXpUYm1BODNwRytjUStYQ21uYXZaSkM5?=
 =?utf-8?B?dFRSbitueFB5R1dDN2NOMk9uTDF2bC9UejF4K280d3R4c1NJNTBHcmdlUElZ?=
 =?utf-8?B?UFRQZWtlaVIvZnI3UnFsOTlhVm1ReE00OGROK3hTZGF0M3JGbDU3dUNLN0Ey?=
 =?utf-8?B?SUVDTEVoZjduNHlNeHBDVkFCZG1ZZEhjUGVtMmJJQUpYeTdHVThROW04bDR4?=
 =?utf-8?B?dTNoMzgrdUVMOW0vMTZ0Q09yYWc5WmJoQTZ4ZDVxTmNCT0MzaU0yRFpWeVdh?=
 =?utf-8?B?TmNTYktrdDNrRW5TMitURk55OWpuUW9xamFBOVlqTGJtaDdLNlZ3TS8vSnNL?=
 =?utf-8?B?TU1HZklzaHlheFpWb1ltOTZLakl5UTA2VFIwUjBuc1N2VGlTQ2hzK3ZDcEQy?=
 =?utf-8?B?RVNJYjhmK2FFZnNTM0FxTm9LSjd5QXZXR1QxcExacVUrUXhUSUdLd09wMjln?=
 =?utf-8?B?ZDNNTXNNLzByU3F1eWpZSGM1TVliZDc5am5WeE9KNjNXNk5oSExYanNwRGNq?=
 =?utf-8?B?ZU9WaWJ4clV2ZE1wcksxT1RtMkxuQTkvVVdSS0VCVmg5cXp2TXJEYS9zdVBQ?=
 =?utf-8?B?VFVJOTB1amE4L0dxTGQ4Mjc3RUpNSjh2N2ppdU9NVEpuMFpGVVBXMjlSZklM?=
 =?utf-8?B?TkxGZjluNUF3VHF6dW55MXREQ1V6dVQ3YVlkSlJDVE90cEs5RHB5cnk3dm9p?=
 =?utf-8?B?QnZWTllCalArZ3JYTXpzVmc2R1VwRVlDWlNvNjRKM0VpUStnMS9xazBPT1Jk?=
 =?utf-8?B?T3hiTHdNVjRFSWZWdXo1RUU2R0JJRVpxTmd6RGRMaHhMakhMUndNbzJMdEpk?=
 =?utf-8?B?a2I3UGxjSmY1SVFZRzRPclptSWdWeUhtUzd6Vmh6UE5tQVdLaHRlTkNyMHdi?=
 =?utf-8?B?V3FVMzJiTVNpeDBMV3QwQWRzOFNha3BhcXVoRHFjS1pUN0VuSUdxN2RTcUxR?=
 =?utf-8?B?VFc0Kzhkc3E2VnVOSEVZeXJzWmMvZ1NKb0pNM1RNK3doNWZuc29uSjBMZ2k4?=
 =?utf-8?B?THhlUHJmaXphTnAyV1d4NXFqa2NBUWxCQ1M1OFVVbVRkQkJSdWNndXJ5VFQ4?=
 =?utf-8?B?cEVNckQ0UGlMazhuNE02MnJsOEU4cStZb3pVaVRyRFNwZWkvdUdncGhhRTJB?=
 =?utf-8?B?VUZ1a3hiU0ZTYWpPU2RkWVZ5MXowTWJUQm9TYUxEZXRwcHM4MmgxaUVvZWht?=
 =?utf-8?B?dXFMT0ozUmJEeklQaVVwUVZ4VFlqL1YvcUROWC9SRWdOZTdLQks0VkhPVndm?=
 =?utf-8?B?UCsreHgxbkJWR05ZeWdJZTZ4QmtNTkZkc3BqYkhOL0k0R2s5TGtGYW45bXVJ?=
 =?utf-8?B?a2hNZzFHVGxaQ2tnY1hUVGI0ZlB4amoxdTBzdU1ma1lLVFJQVmtRb1FZQkY5?=
 =?utf-8?B?MkZpUHlhZHBhaVNlK2FKTG9KMlh0K21ZYlpwWjJEZjZPR2ZoTjVSQ2lpS296?=
 =?utf-8?B?NDg2T1p0a09YMllWTDZOSk5wMXdIdCtZTnFwVmlXd21VYmhpRkFnam5XSUhP?=
 =?utf-8?B?dXBVK01xZElPK21tQnJLcXArNDA2YVp6NUROOFp3OEFEQ0pFL3Z2TmpqTDBO?=
 =?utf-8?B?eXg3L016b0psNjZxUGVTQVUzS0Z1Z2lmNE56Ulk3am9BdkhKeFlmbUhTbXpt?=
 =?utf-8?B?RU9KVmpKQmNOVFF5Yk1IR0hDLzZDblZ4MmtNT1k2eE45UXhaWkFBSE84QjhG?=
 =?utf-8?B?dUxJMWRocHViOUZETWFlcnQ3dDBpa0tRM0RHZ1lxZ3paQ3FVOXJoeUxuVnBE?=
 =?utf-8?B?RmtLNzU4S3JQZHgwbWFoK1pCMGpWbXNWd3JnSTRaWGZ5b1NvMUJaVkpkOVdP?=
 =?utf-8?B?SU55TGJBYW9abFlrcGh0b1gxK1oyaHllZWROUS9DOXNia2pFOU9lRnB3S0V2?=
 =?utf-8?Q?PJfuEIaP3bI24COzQQfgTt+lLdhVUoJ9UPE+MajXW3RhY?=
X-MS-Exchange-AntiSpam-MessageData-1: H+wCEfogijeTdw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b5c5de-f6d9-4706-4214-08df44e45a16
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:52:46.6197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmhbwSuoi3HBD4vCxWCA1ZEVsQTfJURcfk9DSdiEO+HlMJpF7HTSjczsP1wxxpqHEq4td/CQ3MDANqyf14q0dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR08MB497186
Received-SPF: pass client-ip=52.101.69.105; envelope-from=den@virtuozzo.com;
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

On 11/6/26 21:03, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> Management can delete the host tap device of a running VM while QEMU
> still holds its fds, e.g. OpenStack unplugs the VIF of an instance it is
> deleting before the domain is gone. QEMU should carry on with a dead
> link. Instead:
>
> - a multiqueue virtio-net NIC aborts on an assert as soon as the guest
>   changes the number of queue pairs or resets the device (patch 1);
> - every tap netdev makes the main loop spin at full CPU in tap_send()
>   (patch 2).
>
> The two patches are independent. Each adds a case to
> tests/qtest/virtio-net-test.c that fails without its fix. Creating the
> tap needs CAP_NET_ADMIN, so both cases are skipped when not run as root.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowangio@gmail.com>
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
>
> Denis V. Lunev (2):
>   virtio-net: fix abort in virtio_net_set_queue_pairs() on a deleted tap
>   net/tap: fix busy loop in tap_send() after the tap device is deleted
>
>  hw/net/virtio-net.c           |  25 +++--
>  net/tap.c                     |   8 ++
>  tests/qtest/virtio-net-test.c | 174 ++++++++++++++++++++++++++++++++++
>  3 files changed, 200 insertions(+), 7 deletions(-)
>
>
> base-commit: 76fdb3373c9a27b3f50ecc9e012cbdeb90af7151
ping

