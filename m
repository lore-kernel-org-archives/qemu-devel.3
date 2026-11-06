Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7DC606A32D
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2026 00:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebius.com header.i=@nebius.com header.a=rsa-sha256 header.s=selector1 header.b=SHWGNG75
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPTrp-00067g-JC; Fri, 06 Nov 2026 19:01:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonkuchin@nebius.com>)
 id 1xPTrc-000678-KI
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 19:00:58 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonkuchin@nebius.com>)
 id 1xPTra-00022l-Mt
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 19:00:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLStfbzvReapUGnUe7hbUTPUxKecZfPRl1+sCzJGtVjUjJWvlj3Qz5PkuCkz1847mnmo35BHb7hpVwv7O1Vt+e5sQIvNdeYWKhVrnKH7B+ZCH0O5PYwEoeAQpParDdXh7zDl7GOhTE1lM24YWMFfvwm1mSjzR7QEdUT7sdp59d372OmNuxPig/QvKjR6Fl6f+TbXfN2sGV1jxTCWmiY7ZNCgxN/zTOwG5viWQdjddlktIudiQQvcErkltHbIDqZ94XVDToH822Ogz3WUTNO7es9UjF4bg3FdKq/yeG2rMsdA+2IoWrn+iacgFhVy1dzYGBFUROAc4q1Lu8Sy1ALJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/Dp/28odHvifXzumHAQ0+Sd/rAiZ6yweYwsM6OGikU=;
 b=Ij4NWKNLYdwWB8crjEDgjVTHgUz+XDKZpaSTXshrtQzlAEjIEPcWnnlqQDERu57/k5fGDlDPCM/WnqxVvaOBTOEXO6MDEkzaO9aVaTMHcZGd+/QeE7Q7cZN3/pGcHRb/6HyMDxvNFqhrhiG2xiBUhYND5G/yMseEYMgl4gRA3D2Y1E14vNfW5/82ksss0O7QzlfOYbN6tibBkgVnGMUFrF6hkE2vGtmczVudsRHV/05umO4ohwG5Usoagpl8GXAUdP4msMO+iivRQK8GOC/DvKwLzAnS6+Rq/UV+Bz7Kudrnx0kbMOCGK+qbtca5BKE5OZI8xSXxCkmN/XyF7n4Bpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nebius.com; dmarc=pass action=none header.from=nebius.com;
 dkim=pass header.d=nebius.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nebius.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/Dp/28odHvifXzumHAQ0+Sd/rAiZ6yweYwsM6OGikU=;
 b=SHWGNG75faqbAWNKWiYm4ySgupPBJlzv08PLJki+3245KIYdaE6ul0B3OC7o3CeyuJa6vC01xb/ioUmciUo05gMwCHYj/CwQ3Jb0eilP3JKpQ0i5mbHGfTGa7dZ9wvxzL7gpbUQHYHKh0WzKihS/AX+8xyg5QvYMptqqo5rOpJCeLacU06Qvhen44zq++YJ9n3YaO/8yyw2izRylDksamKimPOVtmvNJdSIBXFD1YAFDjeTh7K/TpqchOoesHh+etYuZ5lg/BkNCfDh/XtwDX9zQ+OhHhaROkaoTzxHziHiPl7zlF4CSzT+6H8VMzVH//3Yzbd7qLB2M0qBEe4xYSg==
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
Subject: [PATCH 0/2] hw/acpi/aml-build: Fix free ranges calculation in
 crs_replace_with_free_ranges()
Date: Sat, 07 Nov 2026 00:59:47 +0100
Message-Id: <20261107-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-v1-0-0cede42456c4@nebius.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPRp7moC/yWNywrCMBBFf6XM2oE8IEV/RVzEdGpGJSmZRIXSf
 zfV5eFy7llBqDAJnIYVCr1YOKcO+jBAiD7dCHnqDEYZp7Vy2Log6FPN6dFC5IQ1o1CacOYPhr4
 VWp4+EL65RpwLEZb9SHB02uij1VaNFnpgKdSdX/x8+bO0651C3YuwbV/u2LhgngAAAA==
X-Change-ID: 20261106-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-761219313073
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Anton Kuchin <antonkuchin@nebius.com>, NB-CoreTeam@nebius.com
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794009618; l=1341;
 i=antonkuchin@nebius.com; s=20261107; h=from:subject:message-id;
 bh=s8/ovN2VeW2Zpres/7yVgWvl0lprtQlcJw7X+1nf5Fw=;
 b=Dpiogx4VCOTIXfVf9UO3Xii4+ib10J30XbnnLTkqCvTUvsUXXoBGIszLHkg7XgvgjPUqOB/0F
 r21mDVX/mGNAkMcJA70JH+QJlxn6Odq8iSGRQv/vArqOFb/xmUbXISV
X-Developer-Key: i=antonkuchin@nebius.com; a=ed25519;
 pk=WQsZ99gv454EEZuGZAy0F4nnukJHB0u8dHHKMSJUBws=
X-ClientProxiedBy: AS4P195CA0050.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::8) To FRWP190MB2486.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP190MB2486:EE_|DU0P190MB1980:EE_
X-MS-Office365-Filtering-Correlation-Id: a67a4a35-a196-442d-1134-08df3c621d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|23010399003|376014|18002099003|10067099003|11063799006|5023799004|261026121527099003|261102123227099003|261021121427099003|56012099006|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: gObhD4u8yAp9aK7adWUWXlbIvvddvpbwQqTzdKdruHms/HNcbhLyyocblG3EKsEAbbA3rJCbtzhIUX3WwnW7crBLiLThCX+XEsDiIrJx/ufAcWkqCU1FQa5ep0wms7sRtGjCRLDM18Isjl6vwMkdTehDOeSCF2TFYJwMuT4nOgJ0cXbzWb63/o+efkW2AW6dJ9o70iVGiJbfe6BpF1bpIYktnZtmz5l0pqOVpjN5l/6Ocon/M59fU4tqp8D+zbnK4772grGBtukSnJ/w9Hh8GqlLKdy+nJHG8uZ1BiDeDUU21K0Dn/NLnUQ7uoLWFITt0twXp4So+2KLH23Ct82fwbqo1EqrBnmvv7o3Ygv9SBM+lOY1pISOiNdLjqmUVwtuSTJtiP5Mou2VU6GsHMMK/gA7Po0+peENxXTDrNavH/Mg7eQIDFe7og4nZo08+WLpc+tYQNBlUSkVLqeC17yLSfZpGOeiJHOhj6KmxaTqGG3yE+kDvivhv2DVrsGEPrx9FbPi8T8FBBYwtYshKEDlvMd8hnv2jhbpRDSoeuKPfwp81r+VJagi1C/m2VLQrpwLUjGUWIFZO+Oii7azsm1SM5iPVUND95Wr5FJEbd2lLGPMR/lcVSqJaRLO0cDZ6r37uUV9Lq5tTVvhZsLkJzV5fxOCgEvAnhTVLOdX67WZr8M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FRWP190MB2486.EURP190.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(23010399003)(376014)(18002099003)(10067099003)(11063799006)(5023799004)(261026121527099003)(261102123227099003)(261021121427099003)(56012099006)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEo1c2xaRVpIN3RUZnd2YzF2NnFGSmRwODBHaWNjOWZXa0E1SkR6OUxDYi9s?=
 =?utf-8?B?VElaaEdDVFJCVmtvK3BRdDFOWUtUejgzQlRYMU1DSnNPUlcrL1BKai9qRmt1?=
 =?utf-8?B?SjV4a2pmSDBTRmdFajA3VU9xOXc3czYwYlpEQ045UWxBbVg5a3JNbzNDK3FY?=
 =?utf-8?B?aVgvRE1FY2F3ckhMcUwyWWtrTTRBdEE3endQRGxqRjhpUzg0NlVQWEk3aXBn?=
 =?utf-8?B?a0kyaGE0RDR0WWNKazBQQzdIR2txMWwxQXdhL2hBUmVZRFlCS0IvekJCRlZF?=
 =?utf-8?B?ZTd2eFU0UFdjcENRU0d5eEx4d0RnWklBUjBGVW1HN3FqdGFJK0NRakMzZjhy?=
 =?utf-8?B?ZlNrVlNJOGtmaHI2bTlnU1c3cm5DT0w3WUxHaFNoZmJYWllVbFU3bnlBaVd5?=
 =?utf-8?B?R0R2YW0ydi9kcXRnUXBVNm5nSHhHYjRXVGN0YU5ON0ZRM2JRNnU3TGF2bnBy?=
 =?utf-8?B?SzZ4Yko2QTZmb3d2ZDMrd3d4ZHlqR2o5clhwbVdsc3lCdlltNEE5YkIyYlNt?=
 =?utf-8?B?OVNFY1V1eGZtVmJCanphL3A2NEJIa09tRFFhd0JFZXZlRDN1SmVQL2RYM2h6?=
 =?utf-8?B?Z256UkU2OEtrQURmSjgwcUJUUmdlTmVJYzNLWHZDVzRpeG9mOEpXbGdTVzNI?=
 =?utf-8?B?OCs5V3ZjR3dWSXNQdTFTcmlWNU92ZXU1YnVyQm51S3JiakpYNzQwTDFIMEZB?=
 =?utf-8?B?dzR0Y1V6RUI3Z0lzN0EwYUQyY205dmorZjBXTVREb2RXcFB4QVA0VjNPbmtw?=
 =?utf-8?B?SFprMDdCcG5reGxsdm5uMFl2YVN2MGRaaTRLcGgyMFoxUG5tamxTamdpVXVF?=
 =?utf-8?B?QlpwZmF6aGQrZlJTSlhzTHRMaVIzdlIyUDJwVWVsMzA3N0w0dmdVVHdVOGdY?=
 =?utf-8?B?NmJ0c0QzUWIrdy96Z2JmbklJWU1uUWY4TC9qLzBsV2JXSmowZTZjUm4vczYy?=
 =?utf-8?B?THpLUjljenJmRFVhdTdxc2tndWVQZEVDcGVzWldJY1BEbGFzaHJEWTFOMHhI?=
 =?utf-8?B?aGtYWThLeWcrTDNBUmJMemhKSFRkVEVLSWxJWm9MbE43TSt1WDJyWU5YVWFw?=
 =?utf-8?B?UE54UEtMWFBwTDcyRHIrMmtJaGlXbGZGTEc4VXIxOElKRGpMTDZuVXpoajJp?=
 =?utf-8?B?MEJicVRJSXpYR0hXTkNqL1BJeUt5NVRUU1hkRjJoM3JEUjBacmE0UGV1ZC9p?=
 =?utf-8?B?clNjaTB5VWV5anJTRnYweFFlam4vQ2dFUGxQN1J5WmRhQ2IyeDdKN3E1S3ZO?=
 =?utf-8?B?TlMyMG15OGhnWEpKTmxmZk1adjdOT1FlN2VtZUhNbjBFS3gyMGxHOHcvMTdI?=
 =?utf-8?B?Wlo4d1RPa2NidWdGdzB4azVKelg4MlcrZm5jdXUrbnBCcXVCUitkKzZYVU51?=
 =?utf-8?B?cng2YUdwSS9LaUFWSkpXT2pqMlJjZTZpZk5BWEpyd1c5TFZlK1FCeXY4VzVn?=
 =?utf-8?B?UGZ5S1RRcTZxZTV2OGpjemlaS3FSWE9BSnBCU3QxemVJZThjRE1MSTI5QWFl?=
 =?utf-8?B?NmZLZ3hvRm1WeittYTNjcjBuOFFvTGxya1VVZGFKM3ZSMUNiR0FyRWs4VFNC?=
 =?utf-8?B?UzRWamJ6SUllZGUycGJkRWVSOTFyTnR5cVUwc09xb3dNcUpBaGVlNGZCSGR3?=
 =?utf-8?B?RnVoS3g4dWlxMXNnZ0VzZERtZTB4U1V0QWFqQlo4bDhkU0RadnJuZDJseXRH?=
 =?utf-8?B?TFQ4ZlpBNDRtekRlS3JlMmhuY3dLOG0zTnNrTFdUNlJLbDBvSTVCS2RwUC9D?=
 =?utf-8?B?MlIvWFVuOE43eXI4cVhMMnBSR1BMVTVidEtQMTU4eCtpMmJTbDcwZ0xXclVU?=
 =?utf-8?B?VVhJeHVjNzZiQndiWnZvL2p5Vk5sN0QxTFRKaGU2U2pZZmVJZysyelBwVnYw?=
 =?utf-8?B?S0FCWlQ4V2l6aExIREFBK2NDdStWYm5PVHVRTDFpVWp1S1pEOHlVUWthdjF6?=
 =?utf-8?B?QTVMZ3FaNGxhUmcrWG9sUkVGaHVFOENkSGZ0S3BReEhRSzRRcGQvTkkvUnVz?=
 =?utf-8?B?d0lYd2JMdUF2MHpMeHpZakFTL1FQWmUram90ZlRobk1nTkRrWldMREFoM1B6?=
 =?utf-8?B?STZMM3hDTll2YmpJVEp2bnQvMysvLysrd2d5ZTNiNlU3NWVTRVgzNlV6VVNl?=
 =?utf-8?B?bGdCNGQ5bTh6a1YwZ2pxVWpWM3cxSzZsTDZVYzcvTzhnZzNNM3MxY2ozM3lG?=
 =?utf-8?B?cURRMFJMandpeUJQNzVuZm83SlhVdEJLMUhIT21NQnNUZEdDUWF3NHA4OTU1?=
 =?utf-8?B?aHEvM1kyMXRpbUplSTFnaHFZY09Td0p5NGxncE5GU0M2VzFhL2xxWUJQV0VB?=
 =?utf-8?B?dDlyYmdLaU1ySHR4bXRpWHNjNmpYbzAyZVd1OEk4dklNS1pmZ1NOdlZkR3lw?=
 =?utf-8?Q?vJu+tMpszzsTIY2vCb5cXnDdanxhOZe2Q/wzuTHSVWpoK?=
X-MS-Exchange-AntiSpam-MessageData-1: VIm/RRO1qkZuVQ==
X-OriginatorOrg: nebius.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a67a4a35-a196-442d-1134-08df3c621d01
X-MS-Exchange-CrossTenant-AuthSource: FRWP190MB2486.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 00:00:20.2636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4eb23c52-f3a5-49bc-b555-0b061267a984
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4G59rkWq56bbB+S0ffFovAADeowGy4RQL5ikzH4yR3SkQeKrl+PNGfXIe+m7iEKv3E1tnuTGC5diehkDQ7cPw==
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

The assumption that all used ranges lie within the provided window
bounds resulted in generation of free ranges beyond the limits and
incorrect address assignment in guest. As used regions are collected
without any knowledge about which limits will be applied later, some
non-standard topologies with multiple expanders and devices break free
ranges calculation. Skipping such used regions fixes the problem.

While at this fix potential uint64 wrap around if range->limit is
equal to UINT64_MAX that can add extra free range at the beginning
of the address space. Not sure this can really happen with some
combination of virtual topology and firmware version, but this
check doesn't look expensive and it's better to handle it now than
spend hours debugging this strange case later.

Signed-off-by: Anton Kuchin <antonkuchin@nebius.com>
---
Anton Kuchin (2):
      hw/acpi/aml-build: Ignore used ranges outside the requested window
      hw/acpi/aml-build: Avoid overflow when advancing the free_base cursor

 hw/acpi/aml-build.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)
---
base-commit: ddb42c53b4d91d12511f49ee4428d9594eb5eb49
change-id: 20261106-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-761219313073

Best regards,
--  
Anton Kuchin <antonkuchin@nebius.com>


