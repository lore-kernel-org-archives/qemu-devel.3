Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1321CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBbYk-000688-7b; Tue, 29 Sep 2026 13:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYh-00067A-Qb
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:24:03 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYg-0002l3-9B
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:24:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVG6Ktwwn52RqxKty+Blim3aLUhJ9YwpPBJ3hJFgHy3nhJ4z7cSaM7Why8zqZr2wLRGS/oxlCBd7PifA0Uh9fMGkS9IWCVjadqmEV4U1KVq4fF2kxWDTjQRshDT68tnb9N0pp1fT8bHDN3Wrudpm6I+E9fuLk74JUsUHR7uAE00ThdtOUEPY8jOoThs3WhbSiHxA8OcVfKR4uBLMfo4hEyyggI5o0XJ5Kf/9JULrYAlTVWDngPexFAowtmpdQszB4fAqsNGGZvI6A8UwUQ8N6mTCICpWuEUW2y029TrIaBWWhO/zWZHPtEF8X5JV5fPDuBCL/z2ZlXkNOqqznSKChw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFLHrTXYn30DKBGfZX9XawwQGNuxnOEL0tX4YglZD1Y=;
 b=rBhHk3/56v09KIAnGSvWGgwp79G8fgrzz6VdkfSIg8mk2r4lyzQP0szg6lwdyZjmWJUW9I08RoASBZ0cxwhcH3eoYmaNmPY1v7M8U05bgJyYFEbXJ3DqDEseMIFLMPoA8u6mwazjZ3F+JSRYlGML1+1MsOHEYy6bkF6F0+Mdstra+G9YkAZ3fBmtf8BaJMUtlaiw0S/5jxPPPdtaiA6KoHwEnY3tRWObBfIGh7lOCDjg/P72U/cxDYgwshKCut5cjZ8bEJq1I8PWxYAPIc7afkr3giL+9o2pWR5rBuSZqKioMUtJJ78TrQENLjxtb6sOYPt1LJcaCghMmGOvhO3SJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFLHrTXYn30DKBGfZX9XawwQGNuxnOEL0tX4YglZD1Y=;
 b=0QDjR8oSGm3QtqYevGMV2fK2Nr/OkXjRyRpBfJ2iXzXKsH7Ez2jaCeUz4i9vGoR8IkAtpZjPKe7I3imLb6tKk7L8ZulfCw3eXOBtep75mCauGy16m9PE8kpgONE9h31gQC2aRXIauJ8834mP/hzsUssP+N/3aF04dvNXEGVZm0KRgyhV2/rqpBs6JPOo0rwT4vMLFlcDIKzKucfmFV9tMShUikIEHUpK6Y8dg4SAff/xGl00lIQ+CfnUCZhUaGGU1zUk1f0BnvIvO9BCn/Y89uPRdBG9FIOcsr87yLmkysV06g30WE6qXvJlq1cWDzHDe11Oj03RB+fGj39waYmbLg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB8801.eurprd08.prod.outlook.com
 (2603:10a6:20b:5bd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 17:23:51 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Tue, 29 Sep 2026
 17:23:51 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 29 Sep 2026 20:23:28 +0300
Subject: [PATCH v8 09/17] vhost-vsock: fix FD leak in realize()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-up-vsock-vhost-v5-v8-9-12bcf1c0b84a@virtuozzo.com>
References: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
In-Reply-To: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, philmd@oss.qualcomm.com, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, clg@redhat.com, den@openvz.org, 
 andrey.drobyshev@virtuozzo.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, farosas@suse.de, peterx@redhat.com, 
 sgarzare@redhat.com, bchaney@akamai.com, dongli.zhang@oracle.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR04CA0130.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::28) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c6d9791-5092-4452-97d8-08df1e4e6dff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|52116014|1800799024|10067099003|56012099006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: IepUohilEFGd1CdVGP8IxbHcoM3dpd4/w5twr87Osl0Vw/xqRkbA4uXjp/hJK77HbL8OTyeon2110ON5xXQmy5j3AWT9WMRGWnATVcGHQUU18L0WjyhUFO+c2obM3K1DFynGyX+NSseaelzl3S7dVBXx+sQk+LVHj88cv/goeOSJU6NjoxruK32kwN2m0TOn5K6i142ETH/80cgX53j6JLim6aUZpOvQ82W1JlD0DL4GhY7tjvtedC7N7P6azvqui6oFTbIrh8I6iKt64vQEnxGie/etTy1DEissFLfhKYqNdJugjU5yBZcf9vrG+eUeY/4CWHF5899BKRqxr0GPnOF57fJrLLLEDEdclB2Kj+2kNXRUTClqWwaN6G32NM+ehmdQ892dfRPMObHqEh12y46rtwVPABWrB6ixQCQ7M0xNccLU8XklICphooRlHQ7pBv+5c8P87UJ2uZ90+V59OGlwQuuoNSBKpd9zQ/+RPtGWpQMu8mVuBJ8ZFawZgE2Nq4tQRhE9xK7nVIu27l8SgGmkylKPmRZFXKQ7vLJSm1bD4GTr92badmVUVIXFTAqCKqefeP5Eet2FAHG0eccEHQ3SJ9nVeilUoJyoHKg/5cm+a94VQP/zgCM965DO44QJG0UBY4bveUKgcQ9ZxfqDhL3AwiyzUJHnpt35yCdYtZsHh+wD8MYt35P0+Y/tX7BFvGEJVDW19jSqdnigOsrXmlk0FCqRXhovog9zCO02qeY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(52116014)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEJUTloxSmk0aC9taUQ0S2hWbFppRlNwK083STJyVjZ0QzlYQnU3akx1ZmtW?=
 =?utf-8?B?NFRLZHRpbnZIWGJnRFkzK3IzTEczU216RFlqazl2TWJpS1BKbzYyV05XTFQr?=
 =?utf-8?B?bjRuSkNBZmhIVHZWaWtZRHF4eWJSNjBIWnhWQzNBL2dudmU2ekpYaHB3bnVo?=
 =?utf-8?B?dEtQQkdvVzBucitLOUMrTkdDMFpqbDY4a3pHUXl5aWFxWDRzWFFWWkZ6OHVD?=
 =?utf-8?B?VXVLcjA4bUtGNi9LNmdlK3pNUm12cjFsK1ZWOUs4R1pYcGkralZMNGNvL0lG?=
 =?utf-8?B?SFkxcko1UHdYbWRXcEdaYXJwSkEwWDRYN3ZRcWc2M0RUbTM4Z05VY1ByYTlh?=
 =?utf-8?B?SVRUVVF0ZGlQSG95Rnk5a1V2ODFtYTN1Y2wrZUYrNzdCOUtrVVFKeEtGam5l?=
 =?utf-8?B?T25uaDBsWnZmYWhJanZPeFJ4MzdySUpkWU9aVnkrakJYMzZzcUhybElaeVgx?=
 =?utf-8?B?RlcvTDVwcFBwRGVwVVNlb05IOTJxWkg4SlJjZ0FhRTJlOEg3aTBLbEVKVms5?=
 =?utf-8?B?OElhdk5Ecit4c21RY2ZnK0VRaTk3VEdBYmMvbG10ejdnOURpVTN1eEsxOEtK?=
 =?utf-8?B?SVJ1MHF2b0NManlGeEFiMjgxQkl2NStBZys5d2VacUV1eTVhM3FYWWNENEtK?=
 =?utf-8?B?WnFJZzdkZitoT2w1NEdVa3VXZmlKZVVLMkZYTXZ0SWEyZTdtdjllSHJpclo2?=
 =?utf-8?B?NnNleWIrNU91cDl5WEVJM3M5MTNaZEtCMEJtbW1HemNvMytHUnVJVjVXNkQ3?=
 =?utf-8?B?bXpRcnRnUzVidE9iSUY3S25IMkRxVU5EM0dMTUtNbmxIeEtlT2I1Y3RReG9J?=
 =?utf-8?B?dEVUcklYNkdRN3BGd0RyeE56d2NpU0dtRkdtN044M3pyZFV5bVZJbmpXckpx?=
 =?utf-8?B?YU5NSVB1aloxV3NsNlFhZldWMk9QRTlRWnk4VU5VZTBrVTdzS3F0Ymx2SGFr?=
 =?utf-8?B?WFpCZ25RRVRiZHM3SUxxQXYxdm5abWduTGM5azBTZ1oranpoNysyTWYvb2xr?=
 =?utf-8?B?eFljbDNUemxzT3oxSHRxeVIvS3F2K2w1ZXF1dDF6QURBekNUdHRVdURpeldp?=
 =?utf-8?B?dzloVC9JaUM4dS9XL3JxN1lNcUFPREJGbFVPSjl0M1hZK2dDUTAyNld4RDVL?=
 =?utf-8?B?V2NlMUdXTFZpN3RzQzlMN2dlck5BclFlTVhFMHNER0M3eEVjN2t4bUtqb0tu?=
 =?utf-8?B?UnJrT1RYYjRKMGVqZDZMMHdzek14V1FqbGY0bGFFOWdTenBST0toRkZhazlM?=
 =?utf-8?B?NWFmajdHU0lEY3hoQ0VQM2hpOTY3ZUJGQW1pS2JzQllXckVPdUc3N3c1VUYz?=
 =?utf-8?B?SlJVRVVINy9oTmtZZnMxdjJVNENBVmk4d3Z3bEJnZlVWTlQzK3pKRVFzQzVL?=
 =?utf-8?B?UStGbnNwRVIxUFM1bWhXblc2UVN1SUpiK0dlem5iZTA4UFVpa1ZSTkN4RFA4?=
 =?utf-8?B?Y05NWTRoak5OK3pJMWdrMzU5aVBhSXJXSmQ5T0Ridy8xY0NJdUE1TW5HV204?=
 =?utf-8?B?bDV5azlxSzJkTDZPZGVTbzcyTFlkMy9DMUgxNFRSMjYzc09xVk53ZVJuR2Uy?=
 =?utf-8?B?SnRuRUVaYy9RQVEvVklTYkg0aEJRK2xyOUlobXhNR01DUHhETVVrbGpLQkFq?=
 =?utf-8?B?bERSSmVQYStNMVkrdjZLeU15Ymg4RGJYTW5LSGNYRW1id2dPRzhWOE02dTQ0?=
 =?utf-8?B?ejZGdnpEb2JUNWQwd1l6VjVmQ0lPc0lDWHJ1eEd2MGhsaTRMcWt0czBZRndu?=
 =?utf-8?B?WkdTd0VHakFOaHZDb1lnV01DREowTDd0eDdSSmlid282b3NuNkZXTzIzL1N2?=
 =?utf-8?B?WjlaSFErc1YxVkdQZ1VEVjBXamRMTGRjUXJLeVNMenBma213ZGdGOWd3VG50?=
 =?utf-8?B?clJtSTFZWk1hT2tkc25ZVUI0cW44aE1xbU5JYWVieWlNUldXaVdnaDZWVzdR?=
 =?utf-8?B?YW5BM3pZYnpKQ3BUOWh0VVVNcm1MNndYQk1sSHYyTHpCeXlHaG1VTk9ib1l5?=
 =?utf-8?B?Rk5mNjU0dUZaWVBZM3dMWk1VOUhDekZJM2gzc1RyOEV5Uy9KRW9pNEY1bWht?=
 =?utf-8?B?M3ByOFJhQWlIOG1BRy9FQUZMOTU0a1RtdjVjeUdqU0p5bVUzUTF2cmZZeEls?=
 =?utf-8?B?ZlRES0pCT3ErQWhnUGR5enRVZDRhZFV2MlhaS0xmQ0VhZFZYbXgzV0JnYmNs?=
 =?utf-8?B?WmtVbisxNk5iMkUxRFR1UzZ3emI2QzZUeXh4b1RsMHdKcS92T0NuNTFwME1m?=
 =?utf-8?B?aHUvTkNKcTJoYTdmU0lIUkorTlgxNHcvN2MwZUVCUkFxQW5tRlhwRTNyb3hu?=
 =?utf-8?B?eW9kWUZPbXpyMkFKRmpzTEliSUE3ZWZZMDZlakRuQkNhWlZaVDh1dm9ucFRo?=
 =?utf-8?Q?T34IP4/rS5l1Mk0I=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6d9791-5092-4452-97d8-08df1e4e6dff
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:23:51.2635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7EOpG49a+nkPIPeyxD4n64Ns7DT/tgI5p1fQl/yvKAsxotITayzT1Kr8St33XbCXfQ0fy4eRxHSi0unWDdxOsTPzhqgS499WRmbAI8i31Jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8801
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

In vhost_vsock_device_realize(), after unsuccessful call to
qemu_set_blocking(vhostfd, false), vhostfd gets leaked.  Let's close it
explicitly in this case.  CPR-saved FDs don't get automatically closed,
thus it is safe both for vhostfd obtained from cpr_find_fd() and from
open(/dev/vhost-vsock).

Fixes: 384c2561bddf ("vhost-vsock: set vhostfd to non-blocking mode")
Fixes: 701544cfaf46 ("hw: replace qemu_set_nonblock()")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index c582ac9fcc8..3ec20d87606 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -176,20 +176,17 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
             goto err_blocker;
         }
-
-        if (!qemu_set_blocking(vhostfd, false, errp)) {
-            goto err_blocker;
-        }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
             goto err_blocker;
         }
+    }
 
-        if (!qemu_set_blocking(vhostfd, false, errp)) {
-            goto err_blocker;
-        }
+    if (!qemu_set_blocking(vhostfd, false, errp)) {
+        close(vhostfd);
+        goto err_blocker;
     }
 
     vhost_vsock_common_realize(vdev);

-- 
2.47.1


