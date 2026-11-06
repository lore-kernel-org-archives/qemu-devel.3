Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925C7606A326
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2026 00:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebius.com header.i=@nebius.com header.a=rsa-sha256 header.s=selector1 header.b=MD5PIkY+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPTw4-0006wu-AC; Fri, 06 Nov 2026 19:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonkuchin@nebius.com>)
 id 1xPTw0-0006vm-1Y
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 19:05:28 -0500
Received: from mail-westeuropeazon11020123.outbound.protection.outlook.com
 ([52.101.69.123] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonkuchin@nebius.com>)
 id 1xPTvy-0002VK-6v
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 19:05:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYE+WlH6xIagFJLwVEmj/FaK7ww6xgRbHv9GucOBDGX46Fg4bUAaVw1oJAnzywFE7zsUT8h+pJKkW0hgtoANmTId93baSsXr7LtxrjAxt+zsH1f7CFbLLrzW7ivvtaBTH0gYhxmfqZefRX70CeFUjKSClIFbKuMAg7oNpUKH3P627Xwe6z3dewFNYTdxBlBs71qI3gUXOWe+Yok4IN1BSc0LUA0ynAX1v3v1zKVF0w/8iRfH5IPBzykOt0yLT+fn6OpLwWEQVYYPLUtV0gHlkvNKqz+N1N/nOWXcJQi73EgVKYgKz/+dIkYXjyxJm4g1ZiGMeOSzYQyGHGpQ3Jdhvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDont1VeRzGq/MF2R/lEGwATAp2+GALlkGzBgwCtODs=;
 b=rw5mdDd5novFM+Ekhf9vb4NLSsUlA50MiUDDfPJ0BP0onzyaCMKhhK/kqJGVzOlbq0s24Oi5nS941/5h5KfaOdiv963yMPuOPj4RCinhFInev72K0al9XyjZByF12W6Wtcx9Qz+CNb1PoHKmyma+G3X8jtm/gkmv/bBApZigEHi3kpLAEuXvUx8hSDOMYI08iN8oQ6B34PGnsphEkA2I6kl9jKd8FZt3oKETJn6h2R+Qc7tmgJDtKY0M7dRyGhpZENd8mRz8lJ7WJesN+VfNEtNmenUa58zHd3IVQ2p1oH4+E6PINUboxEfPtOoGcaO9eKcKaaZs4MavvnmesU0yWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nebius.com; dmarc=pass action=none header.from=nebius.com;
 dkim=pass header.d=nebius.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nebius.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDont1VeRzGq/MF2R/lEGwATAp2+GALlkGzBgwCtODs=;
 b=MD5PIkY+uuB4OUCBzxWSm/QPU5pRgK5PrXHxiuIzPaX4Mu7M5oxQaeW2risjRI3fX77XCMjgtTxIoN2lb5InpBoNFU4vdMJzbbItUyFoFdI6g94Kk++Asp9o8IPn0MeqLkyd+QRGJqRcUIwcZD4loyAuKyKaW7HD2U19Dr+UAtUBDfdHC1508jWpoNyBsufeXU+St6ZZ+oe+b/Zxt6OEGdvp+W14PhSuZWTn5rWL2Qsn19npE9NyqUPptkl/4OzYhnXqfS2YS0qtDC3lOc5/BBsNyns9ivHR1WwwCAMuG4UBOr9aPnpZHzXfJVOsnWUVNh+vtv8+RDoCuKCxRePBhA==
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
Date: Sat, 07 Nov 2026 00:59:48 +0100
Subject: [PATCH 1/2] hw/acpi/aml-build: Ignore used ranges outside the
 requested window
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261107-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-v1-1-0cede42456c4@nebius.com>
References: <20261107-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-v1-0-0cede42456c4@nebius.com>
In-Reply-To: <20261107-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-v1-0-0cede42456c4@nebius.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Anton Kuchin <antonkuchin@nebius.com>, NB-CoreTeam@nebius.com
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794009618; l=1853;
 i=antonkuchin@nebius.com; s=20261107; h=from:subject:message-id;
 bh=lPP62xJTwOjWLJ7lhqw1AQa4Wzg1XyMY47LRmaXcqwk=;
 b=R3OeRf+mba9+zUElGcTtpQLtsUrepiKeT7o0UvWeZ9VIZm08hQbF1IRBQUmHKfsTngp6E0HL6
 GlEO+tswnmmBrlKcJVo2xO6CyA3ByI5VKp9JVR09jC6zdXmCi1O/QuA
X-Developer-Key: i=antonkuchin@nebius.com; a=ed25519;
 pk=WQsZ99gv454EEZuGZAy0F4nnukJHB0u8dHHKMSJUBws=
X-ClientProxiedBy: AS4P195CA0050.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::8) To FRWP190MB2486.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP190MB2486:EE_|DU0P190MB1980:EE_
X-MS-Office365-Filtering-Correlation-Id: 933e6bc7-2aed-4309-68b0-08df3c621d2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|23010399003|376014|18002099003|22082099003|10067099003|11063799006|5023799004|261026121527099003|261102123227099003|261021121427099003|56012099006|261021123027099003|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 6e7av4KBOV4tUH5vGlYVZQUdUzlj1ulGw01Eupfzqaeb9PXPsHUUNh48XxCOheiDAYglccrhdT//YgZkFikyNNuypqA/uY+2BlNsCFuSol31MUbm7VyPpnFE2CQscNMD3E5BQ799uj4aMSkBqc/JXimLk+3hSMqprUJtQ6OEciLCf4ixve2vN62vzfchU6aS4lAP7WtdZfZgurD1WV0MeaMHPfBOclDQL3ww3sQ+GMRIlqYLuYDFCNtZbODSI3lGTOhHi1LeQjGsA1dT2VeIPRl4YZDzKpe6mh98d6uqQNP7UhpU54MASZPoq+0+FXzCitf2VryzPQXTZE8Qo4jcympR4XL5GBcn7BRad5xb/niVzskT9kyQ+drrarykty1DymeSmq1IRaHgtWBQEcS17ULyIZLilDalan0dPiFTvuMQMnaR6FiA59EH8CzDjxkeOTACjYmpRCWMRWIftpiM/bd8/xhPbJpQCpVs7dlAYhPkyWigByXKrHJTAiyMjBUAdvBQz4SKSGaDoeTiengeI71oxF/MiL5Ptk5yZzQ5PZARqZjBgk9slqFsjQroVmZTsPTXNxw7mf101C3SixiKuGfeduWzTDU2PZY75TKWOnnjykEFSK5LJmAYte+StvrYNl0+byyCd8adQx39i/W18A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FRWP190MB2486.EURP190.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(5023799004)(261026121527099003)(261102123227099003)(261021121427099003)(56012099006)(261021123027099003)(261022075727099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzB0S1QvRm5CdHN5Qk85K3A3SzFab2FHeHJXWllhYkNxVHRYUVgvci9JdDJJ?=
 =?utf-8?B?TFNRMVNuTk9XaE00aVpzZUcrTjNmdS84UjhQdDRLMWFiVC80MzRvZnZFRWU5?=
 =?utf-8?B?dm1IbXYwalVEdXVhalVDeG84QTRFWXVFQjNPTUlJTEZmbUxGeWN5blVVS3Bh?=
 =?utf-8?B?R3VNekRFSFErd20ySDlrMUovMmpFTFBmNlR2ci9SaWpQdjBaRm5xZjlrMldZ?=
 =?utf-8?B?Rks0K0U2dDBWdHEwNXlPaUYxWWdjQi9GeFlhR2NlazhKOFJHMlpWdmpHdjVI?=
 =?utf-8?B?cjF5WllqT1hOSGNDVVc5Zk1jYXZtZHVZUmxlUnFwaEtYOGJHMHVvMlFhYTQw?=
 =?utf-8?B?ZU8wbTNNbEIrc1RXc0RQT2E1RHJhL0MxR29wQk9CbXhMS3BjVlhuRU1CN04r?=
 =?utf-8?B?L2F1c1l5aTAzWVVNVFlLU3dGaVgxZXBhQ1JkTDJDRG04SVQ0dEhHK0RvcWFn?=
 =?utf-8?B?SW9KTmlDMkpKUk41NEYvczBFUXU5YnRpYUpYT1VDTmxnL3dHL0lZWC9EM0R1?=
 =?utf-8?B?NW5KS2pGTDlWQXB6eEJvS1ovV3JGTHRyVnZvcTZJOHFyNnMxeUt0bEtrNnBq?=
 =?utf-8?B?b05OU2JldFZwdTZ0QkhjbnBtOHVkK3gzOFBWaDJ5Ymh6STV4WnN1Q2t6QURl?=
 =?utf-8?B?a01qT0lBR2R2VjF6OWY5L1RhK1FpUGxDYVhrTlFpRFF6elBiL2Ryd0xuMUl4?=
 =?utf-8?B?YjNhZjBqQytvMWdRTUFmR2FIRzMrTG15WUF3WDRpUjc2bEltZ2dyVXlRU0gr?=
 =?utf-8?B?NHNLaFJaSWJiNm81UWc4dm9jSk1XOUhmY2t0dWpWK1ZiaVNqMXYrMDczbUxF?=
 =?utf-8?B?YzN0YmlVb2o5U1JKNG0zMmRTM09GQjhQUjBIdmZCMVZJK0g0K3VWRThtSTRQ?=
 =?utf-8?B?djUrYW9wSEdCN3NBN2ljS2JyKzFXd1Z1N1pvem5CYTVxM0QwbFFTcHRQeEJ2?=
 =?utf-8?B?QWNWSVo2ZVhtUzZ3U1ExTXFuVXl2akR6RHBWdVZCOHNybGhIbU13MXdxd21K?=
 =?utf-8?B?T3dIVmEzWVc1NTlQckROcXV5d09GNnJBZWpxcGtySzhObGxWNXBwYy9kS3Zh?=
 =?utf-8?B?VDlOOGZaNUhqMDE0YmFvZSt0M2NNLytBUVZobnB2blE2RCtNbk4rNi9iU0g2?=
 =?utf-8?B?czdMUWM5Y21BYVBRb2VFMmhlTk4wbUNLbkhIb3ZBZXZpSGFZY0NzbzhoVm4r?=
 =?utf-8?B?RUlRYWlQSXR1Z0hEekVZMEJ0WEc5amRzMXhLSVRYdU5hcmdiMjkwbkpyb21t?=
 =?utf-8?B?SVJDalhlMHVjcDVxb3lIT2pyWGZoUjQ4REVTcm5FSDk1OGo3TmdYVVd3YTFU?=
 =?utf-8?B?VVFqSWhUUG8rdzlKRlVOMGpqdkJmUkJ2NHpSdW9SbUJsclNUT2Fwd3g3RitL?=
 =?utf-8?B?bHhvMnJycjdMVUF5eEhyT25HQ3Y0L1BpN3gvUDZQMDF6THlOcXdMVHdpK1A3?=
 =?utf-8?B?UFlTZWNneTU0a3FDNkRPY0RZb0V3S0FQNTZndEVtbVg2cW4yN1hLWGVjdWNW?=
 =?utf-8?B?eTQ0Wjhqalk3VFVTK1k2dWFmUlNTNTdvY3I0Wkc5b0ZXdHV4YlhTTndGNDd6?=
 =?utf-8?B?NzZJNGlqZGt5eUVmdUVjcndBVUVFYjYxckVSVkhnVjFXTUZaMzZkaEU4eFVV?=
 =?utf-8?B?cFNRSjJxS2x0VEN4QWFEUHZXTmx3TnJFOEJWOFY2MFU2RlF1NXNua1h6S0E1?=
 =?utf-8?B?VVZBcHh4dk9wYWEvak5oSjFOMndtVVNpdWxxOTJsN1M2UGx5eHdIZTc3dHNK?=
 =?utf-8?B?Wm5WQ21IUWNXMStNUGd2aFZnOEpHaTFnU0k0clRBdUNXM2I1bU1nM2dSRkNV?=
 =?utf-8?B?ZFJNYkRWUWNvL3V0LzFSQzBTZmUzRzlRZHcvaC9LSlhUd1RoWGYxZE54K1Zm?=
 =?utf-8?B?dGNjZ3crdDM3L29oVDZwN0lrcUsxTE0xQTY1WHRvczNORmZKRjZTcVdwVGRL?=
 =?utf-8?B?SmtWWGZKZldLaXdkZDBvdlk0Q3FRakNxTm83cGRwb0RrZWxTdlFoK0ZOMVpF?=
 =?utf-8?B?dk91c0ZCdG1VM2RWb0ZoeGkvaHllSld3akR6ZURnV1JXNi9RalliSXIyOG9r?=
 =?utf-8?B?bU9LcnV3MUJCN0FnWndmRGdveWpTR1djSjV5dHFaaFZFandYOFNzN3hRaFln?=
 =?utf-8?B?SFJqeFNxUFMwZGhIWFBEUUhJR3gzU3R4eWNJb2VtYlVOL2NidndWcjhHWStm?=
 =?utf-8?B?b2VxdlQ2b2p0ekVXM2tGQUhNc0Z6dlVkaWpodFg0dEpGZlBWZFRTVFV5YWM4?=
 =?utf-8?B?d2ZId1ZRMkRIVzBZL2p1YU1nSlRpMkluTkhkZDdKUExTVHlqaVhqLzNIV2hu?=
 =?utf-8?B?dGNrWG9BWnZpVjJUSFp0R2dtUW5xck9RdXkvTWYzQVovMDI5dm5idEJvQ3Va?=
 =?utf-8?Q?6PGIwhGfkj48w/VIDiNrQv4KdWTaKxAtFvDMI1XJSyLsN?=
X-MS-Exchange-AntiSpam-MessageData-1: IOfxfGeJYpD0GA==
X-OriginatorOrg: nebius.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933e6bc7-2aed-4309-68b0-08df3c621d2d
X-MS-Exchange-CrossTenant-AuthSource: FRWP190MB2486.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 00:00:20.5122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4eb23c52-f3a5-49bc-b555-0b061267a984
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkEnixm9lG0amu+nP5lSY12hKITKVA6aXo6U1JSX+HR+desLc3oHOVrGSPfJEPRrusCtuyhcugKlneNxC1nu6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB1980
Received-SPF: pass client-ip=52.101.69.123;
 envelope-from=antonkuchin@nebius.com;
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

build_crs() collects used resources without any information about
valid address windows. These resources can therefore lie outside
the interval passed to crs_replace_with_free_ranges().

crs_replace_with_free_ranges() assumed all used ranges lie within
the interval. Ranges outside it could therefore produce free ranges
extending below or above its bounds. As a result, the guest kernel
may assign a device an invalid address range.

Skip ranges with limit below the interval start or with base above
the interval's end.

Signed-off-by: Anton Kuchin <antonkuchin@nebius.com>
---
 hw/acpi/aml-build.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 990abc64cd8b..90837b513e69 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -124,7 +124,7 @@ static gint crs_range_compare(gconstpointer a, gconstpointer b)
 }
 
 /*
- * crs_replace_with_free_ranges - given the 'used' ranges within [start - end]
+ * crs_replace_with_free_ranges - given the 'used' ranges and [start - end]
  * interval, computes the 'free' ranges from the same interval.
  * Example: If the input array is { [a1 - a2],[b1 - b2] }, the function
  * will return { [base - a1], [a2 - b1], [b2 - limit] }.
@@ -140,6 +140,16 @@ void crs_replace_with_free_ranges(GPtrArray *ranges,
     for (i = 0; i < ranges->len; i++) {
         CrsRangeEntry *used = g_ptr_array_index(ranges, i);
 
+        /* skip ranges below the window */
+        if (used->limit < free_base) {
+            continue;
+        }
+
+        /* skip ranges above the window */
+        if (used->base > end) {
+            break;
+        }
+
         if (free_base < used->base) {
             crs_range_insert(free_ranges, free_base, used->base - 1);
         }

-- 
2.43.0


