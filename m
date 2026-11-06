Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D7B606A326
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2026 00:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebius.com header.i=@nebius.com header.a=rsa-sha256 header.s=selector1 header.b=co7NC0f6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPTru-00068B-0j; Fri, 06 Nov 2026 19:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonkuchin@nebius.com>)
 id 1xPTre-00067F-Sx
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 19:01:00 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonkuchin@nebius.com>)
 id 1xPTrd-00022l-2q
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 19:00:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a89+WdHgnSG2x4YIKtcrs7SBOYmfpzOxCyTCiKoBnB9oeCajt+dlPHsr9DAY57H1UVOiL8+FRP9KUuBO/Xn9Bbof59nxNw6RyBcqB6EPkmkkVPG1qeRzj7a3r5vY9Q12SvgXkFJNcJVoiyIpyG9SOf09OWw+DUm4ErhDZp2u93ts+f3sGgYiVLQn7vIhwD+gxKICCerV47iPFffa+KJ0/ve9bSwA4Hji9HoT27wYP2bcbE82F8rxxC6ED9CNoouinPWxGO0Pq6rd6lN8YMRJ56qAD59LJQouXI0Z3xulBN/KeBqABjmXj8vHvQCfAJVwdoEDR9XD1sxiJMer6djHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4zuOa5/BYM9GMTXnQLT9Ieapd5JzVt9iaNipPttBhE=;
 b=s185HBiS5Cx+MhDg52+7BDE7+9AUUxjVC2A5j+sUzyIeERZZfWmbLd4JrmcjFUL0GroQGPncsdHJYQaYuhq1dyIFjzrXaHdEvn1N+ylJlk7AHDj7UOIZh6P4ibyfovHOK7vHO8tEhOrSNo8T+NucWpTQkjVL3uDolbz9lSFflBisYyKQj/ioCSFU3fO8PiDaTpCy3hQJu4+ckPDOvGxG49FDmEijlcI7p91r/vafMiphS8CQHh0ct8cdfjY6hh2M+l7EutsMPpbdBCG29sayvEDMo0w52ypsSCbFCaHHMx9jbgFXxSjr5VcrLSmUubLT0/hyPzJWrj+sUTaajx7wGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nebius.com; dmarc=pass action=none header.from=nebius.com;
 dkim=pass header.d=nebius.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nebius.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4zuOa5/BYM9GMTXnQLT9Ieapd5JzVt9iaNipPttBhE=;
 b=co7NC0f6R7f/9RglMcdpkQ532+GVs1mRRzFW7Fd5G+/jrcegMLZCw6tSkWnrqJP9kfH5dm154sWAHfBjMaRCq6hmpzlMkJkF0QiMkjo/hQBL8C2YrVDXd6Ex8GVIMtEH6/504qonh3X5sX1G4U1dx4E3U8yCIA1ObUHT7gjoF5pqobgpnxrp8NIO5PGyIKstLk0+HPOrRxVe24S65oZt9iqx88oo4z19pXO0KvwE6hENXwg3vO6rTHbcgGX2GfmuFc8qzjXNBWvEmVNFq3rwOPzQ8O88LKdHMSmKe01FBsdY4tEfWyIC7RR+vlxMJqwQybJcZK8+1atLz/F5JWEIhA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nebius.com;
Received: from FRWP190MB2486.EURP190.PROD.OUTLOOK.COM (2603:10a6:d10:17c::7)
 by DU0P190MB1980.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:3b7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 00:00:20 +0000
Received: from FRWP190MB2486.EURP190.PROD.OUTLOOK.COM
 ([fe80::78f:90cb:c40b:7db]) by FRWP190MB2486.EURP190.PROD.OUTLOOK.COM
 ([fe80::78f:90cb:c40b:7db%5]) with mapi id 15.21.0592.009; Sat, 7 Nov 2026
 00:00:20 +0000
From: Anton Kuchin <antonkuchin@nebius.com>
Date: Sat, 07 Nov 2026 00:59:49 +0100
Subject: [PATCH 2/2] hw/acpi/aml-build: Avoid overflow when advancing the
 free_base cursor
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261107-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-v1-2-0cede42456c4@nebius.com>
References: <20261107-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-v1-0-0cede42456c4@nebius.com>
In-Reply-To: <20261107-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-v1-0-0cede42456c4@nebius.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Anton Kuchin <antonkuchin@nebius.com>, NB-CoreTeam@nebius.com
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794009618; l=1110;
 i=antonkuchin@nebius.com; s=20261107; h=from:subject:message-id;
 bh=/r1QNUpRS1pAD4reHaV2lyLhrWut/E4oI81GiahjEno=;
 b=1BYbO75sOFtlyXQa/g/kuC3iG4aESPYc1uFE7NUVVUil6V+sg1TjVWR1ucy8AyhapNreRzIKN
 fK4lL40STXTDFprfNpXr98HdN/eUl1UujTmJsIaSsn5LsaD6ixQEZGm
X-Developer-Key: i=antonkuchin@nebius.com; a=ed25519;
 pk=WQsZ99gv454EEZuGZAy0F4nnukJHB0u8dHHKMSJUBws=
X-ClientProxiedBy: AS4P195CA0050.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::8) To FRWP190MB2486.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP190MB2486:EE_|DU0P190MB1980:EE_
X-MS-Office365-Filtering-Correlation-Id: f29dd3e7-25ff-47f7-e8dd-08df3c621d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|23010399003|376014|18002099003|22082099003|10067099003|11063799006|261026121527099003|261102123227099003|261021121427099003|56012099006|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: g2rphzoyljjwrGt8uUvpfdxBSgji9m+dJK8xkf/7EPMpJ2J0EOOoMO6B+QiQiwL5Tf3yjYjDSeM1CT3PcPTT6UzfKx1QGQi6NlsbLC03dxuGD0NODKd4XQWjPyLyd8YYrGyRfbUuJW/RESwDfBf+vcekYehmmxmNfBtj9T55MPriyCLkS/dGTPc1filc0zZEIh4h8Pkrq08TRrB+ZYC5BpQ62h4DD5bNP9TDwMDAIU3rHSDzA3KV7O5eEduu1cTC1cmxo1NiQ9moTEVPmbrXZzk5VqG/SyCQzTUWQNPhdTVvPmvG1N4kTIoXO+Ht1kvBHO2ujB1GJNC8ExBiYeHzPDvLvIphyIcOV4h36MT3NBy5DMRDOiV8kqccbJ4KR/6fwGYkdBKvEK9omB/3FsvTyuFflKcLU1MGgsK7q7iFd+OYcyGbW1/tKDpQPNNmfoW1IORRZNdaaWLl15AE1XgOIV2POO9fEKKeFN9MjfIOxnpR2G8h5v/pfu97TUIfcRO3jptuRCly5BQjHjVzlni598Ao35ZBMFZXtimYNKJxZtNkUIxrJfg4Lb1xnygzf4Y38eUL9Nsr31r4DMjdckv8FV4QlHrF50srbCFuEa5DJdUlumbb1K6e8aq0O+4wvgs7m7L/FZuFOlG8vQOX2ls0dwtmyN6QbeqGIjgoPcBUqGQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FRWP190MB2486.EURP190.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(261026121527099003)(261102123227099003)(261021121427099003)(56012099006)(261022075727099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1FpSnVaMEtZa0FJWW5nNHBPYVgybU83dGdOcDVnNm5GRWU1L0xmQUlkWnZr?=
 =?utf-8?B?c3dubmFDb1VzTHpYWloyakhoVkxLWUFieUpWZGNMeXRvODErNENmQjZKT0hz?=
 =?utf-8?B?c1pTT0MzVHVlZmpwcGRLQWVnb2lrUFZtejlBNzFHaldYUlE4VlVXeHJpSUpU?=
 =?utf-8?B?T3NSNXMzWVBVL2tVZy9qcEVPdnVyR2VKQisyNFcvbk5BcDJxSHUxb3l5MmRD?=
 =?utf-8?B?cXVUdGRVK1NQUklUbkpMR3U1MHZpd09kNDBvSFR5cEtwZmpCeVVmMEtJRjRn?=
 =?utf-8?B?YzRKZGtFL3VOWVJnT2pZTFpLN0xFRHJxaDNMNlYyV0VkUERXQUt4VVVCYm55?=
 =?utf-8?B?Z0Raa2xjRTVLOFZwNFlsa3hyYThHTGpTZWl1K3JVejFPZ0ZlUTZ4RmxjRkF3?=
 =?utf-8?B?NFFTZzZhQXoxQ3cwaUF6QnFvRWVkd09oY3RhblByZEtMK3gwWWpWVktEOVM5?=
 =?utf-8?B?RlkvNm53UnA0TDNvbFJVZHlvZC91ZVZUZWc1VzhOOFFBRFNnY2FQVCtRQ0tt?=
 =?utf-8?B?M0RkS3ZxZG9ydFZtVmhaK0JuL3kxUXRZTjFlYWU3Z1VqdFVGWnBTc240SHRT?=
 =?utf-8?B?K3B5TDBzWjZYMXlGU2d2MzkrR1FEZFBaWjF5c0U3YTFZandjNUNudFYrNU81?=
 =?utf-8?B?U0c1VkE0V3UzZk1IWFJSM1hKSTJzcnhRaVc0Myt6ZWdLK05EeWYyZU1lRFRY?=
 =?utf-8?B?OGpXb1BkRmdzTUtvTlFuejMybStOWGlCS1o3bWtOY0FkbHhyU29heUNnaTEr?=
 =?utf-8?B?MCtWYnBKL2ttbmViWTY5NlVubUVpVTloSVBoVkEvWnFBV3UrVHpJQlFVemI5?=
 =?utf-8?B?OXhYNkJWT2YvRG9NV1dVOGFycWNBclVwOXNTS1k5SFpvSUJoblRPVzVkR3Zy?=
 =?utf-8?B?TmpiTW1OUSt2OVBkaFlrenMwa0pUdXFUS1Z5ZUV3ODZTZUNWWGZVbG45SmhX?=
 =?utf-8?B?MTg0U0ZKay84OHdTUEdqcHN1aHJkWXRaNGpndS82MXh6V3FvMi9nNmgzd2RF?=
 =?utf-8?B?bmVTU1ptOTl4Y3NnS0p3SFBNWXNuOE1LVWRGTTBGNWFLOVlwcXE5T2E5WmVG?=
 =?utf-8?B?WjZKOWN2WkFTbGxTa3BJQTJUTk1ndmNmR1RZRzJWaXorKzRxbGx2TjBIMWtG?=
 =?utf-8?B?ZnVSbjhad2ZGOVdBd2oyVzhOVnZ1S3BRemF2U1htUjJHQlBkVWxvV200Zktx?=
 =?utf-8?B?WS9jTVBBK3IyaUtrdWFxTUlscTNmSXJjbUQ5VWh1TUFRUUhiVmlWSElqa05h?=
 =?utf-8?B?VTNkc2kxMDJWblVDQXlFSW03dVRUT0d4UXVIOGgzZ1RKOHorRy9PWThyN3ZP?=
 =?utf-8?B?MlEwZUF5eXVmeVpRRlhjK1BvcGJoOVNPdEI2N3lHUUNGSjJlSHZ6TnJTU01H?=
 =?utf-8?B?RjlNQ1F5UnNvMk1pUHVVTncwYUE2cTk0bk9pV1l2MVB2bmNzd3dIQ3dRYzhY?=
 =?utf-8?B?TFV1blFuK2Vpeld0emMwaCthUmxDOEM2TzdiVXJBVDBXdmFLcFlhK1N4Qk1V?=
 =?utf-8?B?M0JtNHZTRWpnWmI1a05ZMHhJK004bFhwNndVM3ZieWQ1anJYK3drd240c0VF?=
 =?utf-8?B?VFBQZlAxTWdmeVd3VGhzQk13SVhnRGFKYmFxbWJKcUw3ZHJyMTFYalhSeEpa?=
 =?utf-8?B?NElvcXZXT0VTY21qem5qWVIrazlqUERxTGNwWmNOVjlxWnF0RC9xTHc0TGZX?=
 =?utf-8?B?OG9zeUs1YXhNSWFVT3ZHNXkxaVBsR3BtMjJURWo0T3ZMb0FjVGI1SGR3SjBr?=
 =?utf-8?B?NC9NaTRBSWFsTTkvOS9xUWJDc2pCeFdZMjJtRFVVcHhnZi9ZWHdwOENsUGRH?=
 =?utf-8?B?cjFlNm5hYkNQa055cXN2RkpvRWxVZ096RTVvYU5iVzFPbDNZbTYrOXdncmly?=
 =?utf-8?B?SmpsNWlXbVlLSzJTUnRuclgxR2l6VmZGSWxLUnJPTXZFTkNjaG1pZ1RHbHlE?=
 =?utf-8?B?REdVc1BGaXF2RVNNQ3crRnFVSytMV1FYMUdTVXpla28yQnJhQTltYnpBSlFh?=
 =?utf-8?B?STEvZ242UGx6WXEvV1ZBZFNWOVgrbEVIOVlIU2VPaFFiTzFnZnh4eTNkb0Ur?=
 =?utf-8?B?RHJxSGo4c09kT0VDdGlUV09hWmdoU1p1V0xFQXRYNmJxSHF6Q3NmZUFLTFUw?=
 =?utf-8?B?LzZ6dndzMURCeDIyT0hnYk03Uk9vRjF6c0FzZnQ3Q2tWaU5BbDhBYVZ5WFRS?=
 =?utf-8?B?ZlExK00xL253YWN2b202SC9CbzVtWGpjUnk2ekVKRDh3bU5MUVJ0eURucVB0?=
 =?utf-8?B?UWxWUzk0dXZ1aDNvV1NwdWIwWWp2YisxNE1SQXByYWpTY0diMVlLZWxhakFS?=
 =?utf-8?B?R0FodjM5dmtlV1lGZUpreHdKalNjT0dMekg4U2dZaDB0aFpNRjUvTkdIUmhH?=
 =?utf-8?Q?RC5q6+FDAjwii+rsUVDOiH/vr1dNTxp0VCUm5iq/dxytl?=
X-MS-Exchange-AntiSpam-MessageData-1: QBfCSvWDGHkmbg==
X-OriginatorOrg: nebius.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29dd3e7-25ff-47f7-e8dd-08df3c621d54
X-MS-Exchange-CrossTenant-AuthSource: FRWP190MB2486.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 00:00:20.7724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4eb23c52-f3a5-49bc-b555-0b061267a984
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fof2Ukf6UYNxQcu6wUI09wNcmTlV4mX/rMpwFdAVcpUJLkMunS+MMPhTqJOV6WqIUhVjt56VyKTCiSvZtRmKtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB1980
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=antonkuchin@nebius.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

crs_replace_with_free_ranges() advances its cursor past each used
range by adding one to the range's limit. If the limit is
UINT64_MAX, the cursor wraps to zero, potentially producing free
ranges outside the requested window or overlapping used resources.

Adjust free_base and stop processing when a used range reaches or
exceeds the interval's upper bound to avoid cursor wrapping and
final free range insertion.

Signed-off-by: Anton Kuchin <antonkuchin@nebius.com>
---
 hw/acpi/aml-build.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 90837b513e69..b71d82b5e8a9 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -154,6 +154,12 @@ void crs_replace_with_free_ranges(GPtrArray *ranges,
             crs_range_insert(free_ranges, free_base, used->base - 1);
         }
 
+        /* avoid free_base overflow when used->limit equals UINT64_MAX */
+        if (used->limit >= end) {
+            free_base = end;
+            break;
+        }
+
         free_base = used->limit + 1;
     }
 

-- 
2.43.0


