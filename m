Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC64CA6004
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 05:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEKQn-0007QY-CZ; Wed, 07 Oct 2026 01:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEG21-0008IF-1f
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:01:32 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEG1m-0001sy-T4
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:01:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paE5Cl0L+L7HYwFUbRUhsnTcYll4m/U6+wl+qCXdEIQH4FLTHWv+xZbALLpxY9pTrtcqr+bDc/OXNG70TmhTlmlxkmoIg9Cvunu8tRj+SDHZk+/MO5eY807KpCODwjYUlGMQ5tp2zMUbQqoYXO0IOEqORXzPA9NAkqy8ZhgXIosi1QdlUU8eJfZgej1EhjZcULMc35t4syPJeQH1/oq4HA+diqYxxS5+H9NZG73zwuencKBParaf0lheJUVGntmGZWljagjRVhmxYDbv7Kejl764Z34XnLJ+9/o6FA+FqBqgUmi3Za8bjI5ZDfGVNslbQttECARPsOiyoH7WIKsreg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsFB3FDQ+3FBoUdGrsPH789lm9GaLA45KHUm/J4Q16c=;
 b=zFMWaALmX3Sr68YqjMzgiI9pAe6RnFN44l+ggrxEpZ4/sNmJS5fNEjKjQktaxTqKqKccApNLvd4K+nqnWHxlWfURJ0U08k2+4kw/SEwdZkmSvSqIluaqSs8mG1JcQiYEdv7VWw5SHQTrq/6/Q2cs0BnbDNnuffrt8L2rKdgIHrxOmJIe90cSHOn0JrR30qUXMo2XRpVxy0cBdn43H5nPsQsQgErtd57Mxs2UW/yOLXmGiQUuHTq4CHw2/y3QkcDK3VUk8xlNiEp6WbVQoaFGmXsDQdb2nITkRJ0fhpGFIj3ZVaNDJKScZW/D1/RAAcMNCmo5SzBs3qilnfcJqB03ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsFB3FDQ+3FBoUdGrsPH789lm9GaLA45KHUm/J4Q16c=;
 b=S/h1VNExhBA7lY23fH628LKJxfVPB67tiN6n0TRANDInWC6OYmp4ZlNOdBC8C7jeef1NMKlG6Ef2QuIMO3r+LSEbk70/cZnnU1aE7T3QWgfNp/5XE63+D19579eGceOCVElHRnjWQK2M+MXvSsBvLudavORpCHtwLvo5aUZXr1LHKn/8ruNZ5DZesEYD7H8zqMTmtZ4BwHWP8es7+Tc2Hw3xVaFD8ipg7vSgd9To/MdQ4KoIjmRcKAESn9t0JxHWyugVwawOrYJeUdK8zLmCD2Wwcv2ElWa6xZ32nakzEMKVPqtcE6pZFQff54xhIlM0cFa9ndmZ8H3Yp031tgpRDw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 13:58:51 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 13:58:51 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 06 Oct 2026 16:58:27 +0300
Subject: [PATCH v13 04/22] migration: forbid snapshots under Xen
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-up-vsock-vhost-v5-v13-4-2ea78fd1b7ed@virtuozzo.com>
References: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
In-Reply-To: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, peterx@redhat.com, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org, dongli.zhang@oracle.com, 
 bchaney@akamai.com, den@openvz.org, farosas@suse.de, 
 andrey.drobyshev@virtuozzo.com, clg@redhat.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, sgarzare@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI6PEPF00000229.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8f3) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB285920:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d1d646-145a-44cd-1246-08df23b1f36c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7416014|23010399003|38350700014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JYnA21pdbAY1p/e3c6icdrOG/OiwLqnwNRGy+Zy29dfQUQUhlH+pvFin5ZJVigKpzzAnXu83ir00Rb1MEIJxkztYfEdicpxvMdtIq2BASdlNqw8Rc3aEjI/Yx1lDm6upzvmVK5tz+CH/jdikEY7swUa1HUVExRYDO9Xm8bTsnOY7l7GaUGVEg+ptYV5XhPiEJ7918Soe8IJqpYhyyFHvD9KZi+c0//8Hu0WqUFopXgje1bKepG+hvPcWdOpQQyv16VzfIddoxpqy74gyAbeDVbsK90QJLcbHy7+Q6MHUYFBdcWv/gzA2r9AXl8kKl18LTmXet6chYiDEY7gTnacesCyPt0Icc6f1aOplJcxN+x8nwz8wtrhGgA0iuu+XhK4zEQLhK/lm/0kz+8DYbVmWtTMLM9Yf3xXlnzkEW+Dj3lzTUno6x2YjyvM36Izmsk1MiuGDRt9FXAKJdVzkiD1BpPuFeHwI0Pdt7UsdcccIljOSHGbw5FUeuO1DXVAAsgLAZ+jjhQ2FacAHInwpFCrjXrrsgamiUPe+vgY7UU4Y21V49gwqPM5PmUjK6fggLBNXKiFeGMXI+oPDTVtNnJs23ijSxTfhiITBvgZI+SFgHAR3othWElDWkIPrL5bu6bweEcRDZCgc1X0TzZs877/lKovhJpPrejHxU93tQJU42eLjgLzmzVcoaCOWxE5z30BtuiSAaacUFyEvUq+gv09NXpH/m+CIJneT1ATpEzMjKq4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(23010399003)(38350700014)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVAwTmt4VDFkejRFTG9jb3JveHlNNlkyNlY3eGtDRnVmVEk2eE9uNWZLM3dh?=
 =?utf-8?B?VDlUamd6b1dUYzNhcnprVFRnRzdmdFR4dEYvT1oxVUlaeE10dm1YamRRbHNn?=
 =?utf-8?B?T0RSVzlYWHpjYmEzYS9jZU5iM3M0b3pRRDYydUNkeVJLU0JjQWdsbG14cUdj?=
 =?utf-8?B?bHVxcTViTjBiWWlESEFxUjduemxSWFFvQzF3N2lpK1locWtKMGtDaG1weWpj?=
 =?utf-8?B?WXV1ZytEbDFqdWZXejZDRElFc2FkODV5L1NkdERPS0VmUzgvcHVGNGhYWjZj?=
 =?utf-8?B?LzFzN3RjenU3b0wrYlZIZCtaV0lBcXVXVTVUUzRDMUdMeHBBWmFCQllFNjY0?=
 =?utf-8?B?aWJNdTRYNDlhQkFVcE94eEs2MTlRcEhwMTVOQXJ4LzBYdll1OUNicmM2dXhq?=
 =?utf-8?B?L1ZDTTBkd3REVkF6WmpCNGVjQklSODNWY1h5WkdPUmpZZVNoT2EvNm1QYzB3?=
 =?utf-8?B?aFVnU3JWbi8xakdCNmNzRHU3RHZ0SnBXRksvSlNlUm1qaHVHOEd0ZkxKQld4?=
 =?utf-8?B?Nk95UFlkVXRCNlBFVVJselNvQlJpaWdhWkx0blNpZWFKV2FJMDhtN2FvMzNX?=
 =?utf-8?B?dkd5dUZES2ZaM3hvb2hJLzhpYzV3ZklXVC9lMHROM3c1MnpGMk5jMHU2YW5G?=
 =?utf-8?B?Nm1zVDVGV2dXdFNMTGhyNUdGU2ZidGtTRWdTY0dURlZIQm5xL0JPeStIaDBP?=
 =?utf-8?B?N1BFRytwNVY4NElxWTdISGhkSTQvaW1FOWt6Z3ArWDNCa3NLazhLWTZKR0pQ?=
 =?utf-8?B?d0xsd1RmK05NZnZKQ2REMTFQVjcydXZpVFR1bktZb2ZISGt5ampBUWJuMDN3?=
 =?utf-8?B?a1BKYTgyOStNOE5KU1U0YmlnWnE1QXJncTVudFIvcitHY3VNdlRENnZua04w?=
 =?utf-8?B?dGNhMEtIR0dqdVBrb3JwQWthdG5JSm8wMkdtQkZGMm5MUnh0eFdsV2wvZVpW?=
 =?utf-8?B?Mm0vQjNXUmlvcllLVXRUS2tjWGdBbjY5WG5KMGZVYXU2U1M3L0RtOEx6cHNV?=
 =?utf-8?B?a3JrbFdLSVdhMFFiSm9PZlBNOWFXR1VJdmMwek0vdm9KVUNZeW9CLzlEVlUz?=
 =?utf-8?B?WEdsZUJUSGtxcmNDNDhxOSsrYXlnRmtxbkl4SXBuV0QxWVErSmFOOE50TEFz?=
 =?utf-8?B?YWI2QUxLcVo3aW4zNmNFZHUvd0Z3N3Nac0poQjlEWVZudW53dWdUcDNHQjZS?=
 =?utf-8?B?UGhVS1JVRy9vSXB1MVhzMTBIRjJvNXpDbEFvNmtQZTh6REZkSjgxWkJSaHQy?=
 =?utf-8?B?UUp6a3oxZGFzTmhYcDhGbFYrSEgxUStteFU3SjVSSmVnZWNvK1A2QVR5ck9q?=
 =?utf-8?B?SDJwR1I0a0t5MmZmR3E5MnFua0RaV0EyVGFqUUxidXdVN2djM3N3SkxWa0VO?=
 =?utf-8?B?bXRjbkZyWlBPMExNa2lVdWtRQWNtOEltdzViWHFyVmJ1V3c5Q3UreXZKRHBk?=
 =?utf-8?B?aXVmeG44S3ZPb1NxT3EvN1dQcWVoVWZVTHcvR2VPSXpFaVlxa0MwRmpqb2Ru?=
 =?utf-8?B?cEU5Njk4U3Bsd0xIZUxxaEhVYXh0MWMvdmdEV3MwV0RlSDM4TVFvUGF6VGxT?=
 =?utf-8?B?VzZZRnFpRGU4MFVPVlF1MkNXMnZNR0pCbzdpbzc0ejhLOXJXZjBKZm92KzN0?=
 =?utf-8?B?KzRVaCt0dlFhcDJib2hvRTMwVTZGRE91Zzl2cFliTzhyMXJUQ2xENDI1aitT?=
 =?utf-8?B?RkJPVGM0K0FZdE9ua2MvMVlaSGFieE9xK3NDRTlJK3F2Slp3N0VBYWpsWnpO?=
 =?utf-8?B?NHBsR2xYSzAyMVg2YjdzVVE5SmpKUklwbG4zSjBFSTNWQStjblVaU1F4L2tT?=
 =?utf-8?B?eWp1RXhNaGo4SHljd2Z6MXNlQ2NqbFcrekw5QzgyZllmYWRKaFpnbGRHY3hR?=
 =?utf-8?B?M2x6cEtZRXBRZHlMQ1lHdEJhK21ib0cwLzd1WGJwdVVseWZ0S3hTYWc1bzhv?=
 =?utf-8?B?YUdhQzJHeUt0UE11bnhkTmxEd0lIUmtDeXZEcGFRQzU3NktkcUFURCtXa0s2?=
 =?utf-8?B?eThYNUlpbTQ1OGdsZUpLOWZZQk05ZC9Ob2ZXNUxCaUNwRnFzbEZ5aVRUUE5P?=
 =?utf-8?B?dW5QV0MrdFh2WXFHU3M1ZzlFYlpjYkFqaWZrUVlWczRkN0gwczhCaS95Q0RN?=
 =?utf-8?B?OWN3Z1ZWZ1lna1N3U0ozbWltbGZHeCtrNjdVdjRJdjlxNm5sVFloWFhzNFU5?=
 =?utf-8?B?MkszdElUNzJnRDE2U1VlTHpVVTJ3bjVzV2FYT2FUM0NVL2dCQ3oxenh0L2NP?=
 =?utf-8?B?ZEdDY3cwY1c3ZzlETmxBZVkrREVpNU8rdDZSYW85Y1Jaay80S0VVYVpkTGxK?=
 =?utf-8?B?RlFxTHhpVDJQdGJQWlp4bGxyNmhTZmhFMkp5cko1enZmcSthOVp6dGhoMnhQ?=
 =?utf-8?Q?ctNLn5QAmiKF/DJg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d1d646-145a-44cd-1246-08df23b1f36c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:58:51.0974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npTZl8Pyo43u7SXM11fjMvuKx5BvHcvRXEB90NRuH2E6IgpO1ZS+TzTA7zFJQmi7QqmMJxlFh5NLVkm+OmoV9SDh2H3PWxFxRiq7uE6DdD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB285920
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The snapshot RAM-saving path does not support Xen's memory mappings.
Refuse 'savevm' and 'loadvm' when running as a Xen device model, the
same way they are refused for CPR migration modes.

Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 migration/options.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index 92eda90114e..0b7f393492d 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -37,6 +37,7 @@
 #include "ram.h"
 #include "options.h"
 #include "system/kvm.h"
+#include "system/xen.h"
 
 /* Maximum migrate downtime set to 2000 seconds */
 #define MAX_MIGRATE_DOWNTIME_SECONDS 2000
@@ -563,6 +564,11 @@ bool migrate_can_snapshot(Error **errp)
     MigMode mode = migrate_mode();
     int i;
 
+    if (xen_enabled()) {
+        error_setg(errp, "Snapshots are not compatible with Xen");
+        return false;
+    }
+
     if (mode != MIG_MODE_NORMAL) {
         error_setg(errp, "Snapshots are not compatible with migration mode %s",
                    MigMode_str(mode));

-- 
2.47.1


