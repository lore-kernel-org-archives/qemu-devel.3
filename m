Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EEF606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=amctNLif
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ7YG-0003nY-Pv; Tue, 20 Oct 2026 06:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xJ7Xn-0003as-Lr; Tue, 20 Oct 2026 06:58:14 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xJ7Xl-0007bE-0s; Tue, 20 Oct 2026 06:58:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKG7n+rjpn0fnwqjyLDa0Wo9cEfZhSJ6XmQqbiszLwCNoUIn2fJ8s1LgLtxO1MHRDgqHglw/VuPBv6mUHJszVHtEv2rNMSe0AFhXPjfEqtU4TBUrWvpCHjyyGO3Xi/ylBKU65i/hymfIFGfy17dGMUwIIyWN5FXjMLSDeICkGksW2m6cPH8194fpV807oWU0bR3UqLwabAmTWJh8wy0AP3IISL/d6SuC6b0txTaUMQNzVehuluHpdmjnQLn92ZnnFTmX6YoDwvKOjHyWSEKWmCnp6J17rboo1Gwzkzb/WDmneFedonpjA5i5YTcrklFPZpuUPTdkoGeQnpT0Y1xaIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcWmrTsLzxl6bloX+ipu5feouG2WRoGKEizP419PCuA=;
 b=NBZZIyoFL+8iv1wn49v3gRnBi125CFw0rKu++VsgbCDsjskvySwJkrxaigDJqKyuRAdlHzYjv4kb/FYsPrHz2QlM4wbZb6EgSUSM4ia3X+n18V0U/uH79vID45ZUsaVP3Kds+eERpcLw6oCtH8zdNIXBO3aZm0r2x7b1QrUJc5HYIFGcmjF8cafutivdtrhdKtbsiznPLoGQdqfd8RPw1Tb5x4t6xbCg8lDOHsMwm80mosmES2nQ+XPm1cMxqxopv0Ti3pmA4vsX9+gZzi9FMe0blps/AJxX9sqXYlLvF85RhFoJ+Nfz2jvc+VgHF8YOmMVtuapq2paHFB0Dd0kYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcWmrTsLzxl6bloX+ipu5feouG2WRoGKEizP419PCuA=;
 b=amctNLifxKCjc5OWoWz7ZXoCHHgl0Gp/+il9H1tkT5ibdNL7b0CwOR+fcQOtNJesXPB2OjA0Ev7OgES+ZEP14A22dCdgnpSWxNQ00c0pNn/21qKqOc/r8t2QPUQbXnx9072I9SmkqDi/kkeWDj4YSwg4V2ka9cfsHnHtIlJ+8P2+K63q0GruheCRFJzAXWrQ10yDYBaM6eUgCBfI35w99ArFPkFcNI0aMaXo3eTndSrArD1vwD7dnKXHrQSs+UtRYC/ClNL/O2ckK9aggciqRuAACu1kbqQ6eMjiNDsaWSW03BaYnAm0e6ZJq4Oo38DBxnmTBNHzrS84Bh/pMl2CmA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS8PR08MB10221.eurprd08.prod.outlook.com (2603:10a6:20b:63e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 10:58:01 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 10:58:01 +0000
Message-ID: <6ecf03a4-1792-4b84-bde3-2b481fcc5856@virtuozzo.com>
Date: Tue, 20 Oct 2026 13:57:59 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu-nbd: Add --all-bitmaps option
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20261019222205.2028202-2-eblake@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20261019222205.2028202-2-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0141.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34c::19) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS8PR08MB10221:EE_
X-MS-Office365-Filtering-Correlation-Id: beba4d84-c275-437d-cbc6-08df2e990211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|18002099003|22082099003|10067099003|3023799007|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: DQS0kcwWkUHCfT1IGeiyVnjpphtk1r0WJFw2NCiBkbelfIb6/jsKe8hd0sXl53Jlxz9sbvGq+XG3Jbpt2tFR1umttqvw45bqcT5BQsjt9lzpvJA/u6dfAeuKa8QMLm3cWxIo3KFde7Yk+Uhj0igWWFU1TONENaw9z0EJB5HqDfoT1QuY9jEom3GYXsD8EuUUz7VU2r19k3YoX4vJfCTlQDzCLPZHRvYxWzwFdTe+hplIPKYJTydCwkzc4nS0365y1gUqmWL2/SDkg26QmHCseSRaU7BnFx5ZOMTZea3u2o0Jr2MruL/zyBvt30L0pOFrcHHTeYaTQUlNKcEBLJ3oCzHvqBkDmesNjowX6KLmO2G3BU1C3RWWSlUQYN600iveyZ2pQJYPTuNFTAqpo6t2LS28GVcAmTpiO7hzQ/BO/7WvRtbQKEWkJoDYvdmlkXlZGbmQBjV9u1qX6cK0rXQKMaMhfHRaayK5wb9JMsC0KOMR1PJR6pd3uGxtvM8X/pylsM7KKS0QvhswgIOKaDysMATJxiw9mu2Emqj9kU+V0xkZjYRYkjJYEXt4PVhzTdy9AZnPl2RpHABEQLOFvTS42493lXs3YIKS4AIv6sDQGdpvLvnIlFp+w0f9Nuc2CR1bbW2bQW+UQnwuD1EiYMtbkI1zeKHh1BgVf8OD4ZeNSCM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWpCbFMwVU04dVlKR2Y5YXY5OWRlL2hJUXNwVnVKSXV5NTh3L1NIcTI0NGpL?=
 =?utf-8?B?M2tsRGx0Z2VhTWtZTDlJY2JLcmN2SmlzY1Q2RzczZUJNNkFMeTE4N0g5cE01?=
 =?utf-8?B?S2U4VjhaL3VKdWg5KzVKbUhseGxhL05OVzBPbjF2cm9IZHBwTXNzdklacThv?=
 =?utf-8?B?bnEwZmZFNDMxaUYvbytYZHdxQmhKZ3ZpbitCcGZmcCsyUDk0QmYxQ2JPOS90?=
 =?utf-8?B?SVdnUWdpemNHUkFlV01KM0ovMkZpckJJVWJoNS9ncUwrUW1uRWk4V2tyOVlp?=
 =?utf-8?B?bXF5RmFPQ2o4czhPVEozOHI2c0xWdVYxTmo4WHFIODMwNDZKb21yL3hrZlI4?=
 =?utf-8?B?MmdZR200SzNaOVV0TGVMOHpvbXdLYlpaL1JSZE1palRxU09ydHdDVVdHaUlh?=
 =?utf-8?B?aFBnWnJqcUlUU3ZJeVZMVVFONHlZdWNyOVBuT3lNcVIxN2RZa3JYaFp3ZHEr?=
 =?utf-8?B?UXJLTm5DL1cwY3ZEc1VqbndiY2Q1OTAyZjBJUFZEbUdWWHlFdkVJUWwzUm8w?=
 =?utf-8?B?cUJEK1VYVHFnZUQvaThsbEdBZ1ROcW11b1R3L3g1TWoxeVloaVdDcDhwUlh0?=
 =?utf-8?B?YUs3KzdxZGVZb1kyOXFISHJFOUhERDZ0Mmg1NS85ZzBaNUVqMnRBdGo0Vi94?=
 =?utf-8?B?aDRxRDRNREpsay9jeExCUDRoSEkxeW53blNZdUhTSkVtZkd1Z29JTmtzNTFE?=
 =?utf-8?B?Y3RJVjFiWEZOR1pPYTAyeG1qbG5Xd0ZRZ3Z4Skp5K1BtMGJSR0FhYXJvNFJK?=
 =?utf-8?B?c0duWVM2RXdHSDAxeUhGSnFzQkF3WTBXYWg1OFJUdzluWDVlT1hZWTBkQkpq?=
 =?utf-8?B?YkFUMWhKTnN1djRkaW1ZRFpSSXYzTE5ubklrbndFejFTSi9OaDYvYlQvVXB0?=
 =?utf-8?B?SU9LK1Z3S0J2ZENsSkFMWWFqSTM1Y3QvN3c3UlRDUnhjeW5xb3h3NjEzK25C?=
 =?utf-8?B?QU53cVB2N1Q5WU1UQ01KNkFWUHU4VHNEem5kNGZPZzlCSUg2MkRtQUR6OENn?=
 =?utf-8?B?ZWIyeTAzVVd5bVhHTmtIejJNZUdoL3dycUM2ODgycXdYTHZIdGtLdjZJay9P?=
 =?utf-8?B?UUhyWitNQUhteWRZdkxPT1hITmMvaHNqVWN2K2lQcEw2dTF1YVpCY3ZvcWF6?=
 =?utf-8?B?aUh4TG5tT1Y3R01WVTVCY0JlSmdSOXBKbDM2bVdXZ3A1Y2lpOURXL3dKSmJ5?=
 =?utf-8?B?TFZlL3BnZmdVbVA0K0xKVVFYWWhvTGZkdnR4ejl6L05zVnAzcTQ0Mld2OVl6?=
 =?utf-8?B?R0RMNnBRSGRlTllTVExDdkZvSndhUGhOZHM4QVp5Mlo5N0NWT0hYdmtnRjNS?=
 =?utf-8?B?N0IzUmdBdWJHN1pHckZJSjVoRHVHWHl5ZDN2YTMraHU2cWY1OGV2NDE0OG1F?=
 =?utf-8?B?VERmMURXSWIvc3VtZ0tWTmxmaHNCSFAyU3M2dUYxZnhkcFRtaWZFTDBPZ29N?=
 =?utf-8?B?Qnh3MUs3VEdaY3lvYWt5UzJvY0tWOGVCaXNjblpQOG0rYjRCYW5XLzRqOVMz?=
 =?utf-8?B?V2Z0elkrNUFaaENCUXVGVVZmSWV5Z0NEN3IyamJMMVFGV0JxNktwcDdZeGRp?=
 =?utf-8?B?dmJKcmhoMmIxZUtXMjQ5WXc5dFlBQkpPdkpUTFFySVhzSEdtbDE3ejBnR2hO?=
 =?utf-8?B?ZXNIL0RtRFUzclVleHh2VFNMeTArZmtkSFUwZmV1QldpbUZ3OVl3MFYrZ1Fx?=
 =?utf-8?B?Z3pNZTRyWGsydW9VbUpiTHl5MnFSb1FvR0VaeUs1b1E5dEZVSzJHZzFPK2ZJ?=
 =?utf-8?B?dVpiT0tFSlJid3VPaE43dmxQUHFBUFRBSWtjY0l2MENuRk9vazQ0clBBT1F2?=
 =?utf-8?B?alZxamVGTk5JeW1SaXRjZ2xTWmV0UG5IaXpyZFZ5ODZ0MHRJTHROMkp6U3cv?=
 =?utf-8?B?SVVhM2JzNm5jOUhGRGhkYjRBdkhyVHZSeUdkWHJ2djd3eGkrRXgyejdkeUx3?=
 =?utf-8?B?dGtGNThiMmdNRmpmQTlRa3F6enpTRnNJUlBlQStnZk9wSFo4M0c1M1hKUlVj?=
 =?utf-8?B?QXg3SDh0Slp2UFFQMkF3VHpQTFhYNHpKZHBLbFhsS25lRDNERTVrRWs2TS9N?=
 =?utf-8?B?SzZsN2licEwzb2ZmTGJsL2dBeml6clpDOWVjdmdFRU9JUTV0alpTUUVzMTJJ?=
 =?utf-8?B?eTB6NjRRU1JKL0s5QTBYNnNvNldyQllJRk1DTWIrRTBPNXFON2RWemxqM2J2?=
 =?utf-8?B?b2JObHlvdjZmVXF6V0V6WGVhNlhibjNuZUhKWEQ2Q0xUZERWUndETGViU1dV?=
 =?utf-8?B?R3Ixc21ZekV3L2o4Wlg0blRWbmVCNHBlbFd3OUlUTmJKaGtndVN0dCtlR0Qx?=
 =?utf-8?Q?QhRE8OjlW5k9RqnDR8?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beba4d84-c275-437d-cbc6-08df2e990211
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:58:01.1032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tePdFh9hT920py+SklWqslZLnhlHcVcDnEQY+BukEjiziVbgaF6pNjxizYt3HootU5VINV6W7I1o5VCILx1hbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10221
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=den@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 10/20/26 01:22, Eric Blake wrote:
> When exporting bitmaps over NBD, we previously required a user to pass
> one '-B name' per bitmap, which they would have to use 'qemu-img info'
> to learn the list of names to pass.  More convenient is an option to
> export all possible bitmaps at once, as discussed here [1].
>
> Implementation-wise, mixing --all-bitmaps and -B is harmless (grabbing
> all bitmap names already requires crawling the backing chain and
> deduplicating, so either the -B name is already detected as a
> duplicate from adding the name again, or it is an invalid name that
> will still cause a later error about bitmap not found). I also tested
> that mixing -s and --all-bitmaps still works (the temporary overlay
> image to make -s work has no bitmaps of its own, so starting the crawl
> for bitmap names at the original bs is just fine).
>
> Also, now that parallels can have bitmaps (and not just qcow2), a
> slight doc wording change for -B is warranted.
>
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2026-10/msg01234.html
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> CC: Denis V. Lunev <den@openvz.org>
> ---
>  docs/tools/qemu-nbd.rst                       | 12 +++-
>  qemu-nbd.c                                    | 57 ++++++++++++++++++-
>  tests/qemu-iotests/tests/qemu-img-bitmaps     | 13 +++++
>  tests/qemu-iotests/tests/qemu-img-bitmaps.out | 12 ++++
>  4 files changed, 90 insertions(+), 4 deletions(-)
>
> diff --git a/docs/tools/qemu-nbd.rst b/docs/tools/qemu-nbd.rst
> index 336b4aa46e7..a966c282be2 100644
> --- a/docs/tools/qemu-nbd.rst
> +++ b/docs/tools/qemu-nbd.rst
> @@ -83,9 +83,15 @@ driver options if :option:`--image-opts` is specified.
>
>  .. option:: -B, --bitmap=NAME
>
> -  If *filename* has a qcow2 persistent bitmap *NAME*, expose
> -  that bitmap via the ``qemu:dirty-bitmap:NAME`` metadata context
> -  accessible through NBD_OPT_SET_META_CONTEXT.
> +  If *filename* has a persistent bitmap *NAME* (possibly via a backing
> +  chain), expose that bitmap via the ``qemu:dirty-bitmap:NAME`` metadata
> +  context accessible through NBD_OPT_SET_META_CONTEXT.
> +
> +.. option:: --all-bitmaps
> +
> +  If *filename* has any persistent bitmaps (possibly via a backing
> +  chain), expose one ``qemu:dirty-bitmap:NAME`` metadata context per
> +  bitmap, accessible through NBD_OPT_SET_META_CONTEXT.
>
>  .. option:: -s, --snapshot
>
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index fcca88932a3..fa28609d7dc 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -28,6 +28,7 @@
>  #include "system/runstate.h" /* for qemu_system_killed() prototype */
>  #include "block/block_int.h"
>  #include "block/nbd.h"
> +#include "block/dirty-bitmap.h"
>  #include "qemu/main-loop.h"
>  #include "qemu/module.h"
>  #include "qemu/option.h"
> @@ -71,6 +72,7 @@
>  #define QEMU_NBD_OPT_SELINUX_LABEL   266
>  #define QEMU_NBD_OPT_TLSHOSTNAME     267
>  #define QEMU_NBD_OPT_HANDSHAKE_LIMIT 268
> +#define QEMU_NBD_OPT_ALL_BITMAPS     269
>
>  #define MBR_SIZE 512
>
> @@ -109,6 +111,7 @@ static void usage(const char *name)
>  "  -o, --offset=OFFSET       offset into the image\n"
>  "  -A, --allocation-depth    expose the allocation depth\n"
>  "  -B, --bitmap=NAME         expose a persistent dirty bitmap\n"
> +"      --all-bitmaps         expose all persistent dirty bitmaps\n"
>  "\n"
>  "General purpose options:\n"
>  "  -L, --list                list exports available from another NBD server\n"
> @@ -530,6 +533,48 @@ static void qemu_nbd_shutdown(void)
>      bdrv_close_all();
>  }
>
> +/* Helpers to implement --all-bitmaps option. */
> +static bool is_duplicate_bitmap(BlockDirtyBitmapOrStrList *bitmaps,
> +                                const char *name)
> +{
> +    /* Treat an anonymous bitmap as a duplicate. */
> +    if (!name) {
> +        return true;
> +    }
> +    for (; bitmaps; bitmaps = bitmaps->next) {
> +        if (bitmaps->value->type == QTYPE_QSTRING &&
> +            strcmp(bitmaps->value->u.local, name) == 0) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
> +static void collect_all_bitmaps(BlockDriverState *bs,
> +                                BlockDirtyBitmapOrStrList **bitmaps)
> +{
> +    GLOBAL_STATE_CODE();
> +    GRAPH_RDLOCK_GUARD_MAINLOOP();
> +
> +    for (; bs; bs = bdrv_filter_or_cow_bs(bs)) {
> +        for (BdrvDirtyBitmap *bm = bdrv_dirty_bitmap_first(bs); bm;
> +             bm = bdrv_dirty_bitmap_next(bm)) {
> +            const char *name = bdrv_dirty_bitmap_name(bm);
> +            BlockDirtyBitmapOrStr *el;
> +
> +            if (is_duplicate_bitmap(*bitmaps, name)) {
> +                continue;
> +            }
> +            el = g_new(BlockDirtyBitmapOrStr, 1);
> +            *el = (BlockDirtyBitmapOrStr) {
> +                .type = QTYPE_QSTRING,
> +                .u.local = g_strdup(name),
> +            };
> +            QAPI_LIST_PREPEND(*bitmaps, el);
> +        }
> +    }
> +}
> +
>  int main(int argc, char **argv)
>  {
>      BlockBackend *blk;
> @@ -553,6 +598,7 @@ int main(int argc, char **argv)
>          { "offset", required_argument, NULL, 'o' },
>          { "read-only", no_argument, NULL, 'r' },
>          { "allocation-depth", no_argument, NULL, 'A' },
> +        { "all-bitmaps", no_argument, NULL, QEMU_NBD_OPT_ALL_BITMAPS },
>          { "bitmap", required_argument, NULL, 'B' },
>          { "connect", required_argument, NULL, 'c' },
>          { "disconnect", no_argument, NULL, 'd' },
> @@ -602,6 +648,7 @@ int main(int argc, char **argv)
>      const char *export_description = NULL;
>      BlockDirtyBitmapOrStrList *bitmaps = NULL;
>      bool alloc_depth = false;
> +    bool all_bitmaps = false;
>      const char *tlscredsid = NULL;
>      const char *tlshostname = NULL;
>      bool imageOpts = false;
> @@ -725,6 +772,9 @@ int main(int argc, char **argv)
>          case 'A':
>              alloc_depth = true;
>              break;
> +        case QEMU_NBD_OPT_ALL_BITMAPS:
> +            all_bitmaps = true;
> +            break;
>          case 'B':
>              {
>                  BlockDirtyBitmapOrStr *el = g_new(BlockDirtyBitmapOrStr, 1);
> @@ -837,7 +887,8 @@ int main(int argc, char **argv)
>          }
>          if (export_name || export_description || dev_offset ||
>              opts.device || disconnect || fmt || sn_id_or_name || bitmaps ||
> -            alloc_depth || seen_aio || seen_discard || seen_cache) {
> +            all_bitmaps || alloc_depth || seen_aio || seen_discard ||
> +            seen_cache) {
>              error_report("List mode is incompatible with per-device settings");
>              exit(EXIT_FAILURE);
>          }
> @@ -1185,6 +1236,10 @@ int main(int argc, char **argv)
>          exit(EXIT_FAILURE);
>      }
>
> +    if (all_bitmaps) {
> +        collect_all_bitmaps(orig_bs, &bitmaps);
> +    }
> +
>      bs->detect_zeroes = detect_zeroes;
>
>      nbd_server_is_qemu_nbd(shared);
> diff --git a/tests/qemu-iotests/tests/qemu-img-bitmaps b/tests/qemu-iotests/tests/qemu-img-bitmaps
> index 979bc0d6c9c..5484fe6f424 100755
> --- a/tests/qemu-iotests/tests/qemu-img-bitmaps
> +++ b/tests/qemu-iotests/tests/qemu-img-bitmaps
> @@ -131,6 +131,19 @@ $QEMU_IMG map --output=json --image-opts \
>
>  nbd_server_stop
>
> +# Repeat with the --all-bitmaps option
> +nbd_server_start_unix_socket -r -f qcow2 --all-bitmaps "$TEST_IMG"
> +$QEMU_IMG map --output=json --image-opts \
> +    "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b0" | _filter_qemu_img_map
> +$QEMU_IMG map --output=json --image-opts \
> +    "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b1" | _filter_qemu_img_map
> +$QEMU_IMG map --output=json --image-opts \
> +    "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b2" | _filter_qemu_img_map
> +$QEMU_IMG map --output=json --image-opts \
> +    "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b3" | _filter_qemu_img_map
> +
> +nbd_server_stop
> +
>  echo
>  echo "=== Check handling of inconsistent bitmap ==="
>  echo
> diff --git a/tests/qemu-iotests/tests/qemu-img-bitmaps.out b/tests/qemu-iotests/tests/qemu-img-bitmaps.out
> index 99290d3ba5e..f2e97a090b0 100644
> --- a/tests/qemu-iotests/tests/qemu-img-bitmaps.out
> +++ b/tests/qemu-iotests/tests/qemu-img-bitmaps.out
> @@ -103,6 +103,18 @@ Format specific information:
>
>  === Check bitmap contents ===
>
> +[{ "start": 0, "length": 3145728, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 3145728, "length": 1048576, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false},
> +{ "start": 4194304, "length": 6291456, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
> +[{ "start": 0, "length": 1048576, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 1048576, "length": 1048576, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false},
> +{ "start": 2097152, "length": 8388608, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
> +[{ "start": 0, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 2097152, "length": 1048576, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false},
> +{ "start": 3145728, "length": 7340032, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
> +[{ "start": 0, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 2097152, "length": 1048576, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false},
> +{ "start": 3145728, "length": 7340032, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
>  [{ "start": 0, "length": 3145728, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
>  { "start": 3145728, "length": 1048576, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false},
>  { "start": 4194304, "length": 6291456, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
Reviewed-by: Denis V. Lunev <den@openvz.org>

