Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B7BC83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 14:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc3Cz-0001oD-Ja; Wed, 16 Jul 2025 10:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan.milon@eviden.com>)
 id 1uc36e-0006zj-QQ
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 10:27:38 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan.milon@eviden.com>)
 id 1uc36Y-0001sT-GS
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 10:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1752676050; x=1784212050;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=dXIHZ1V2YGaHdWeCb8CGYpLemVpwJ9WtNf8vsh+iqTU=;
 b=excDyYd9/UJQMifq8vlX1ZHChiSr3UpcrUaB0C6dYKHN4NShJTbtY3dg
 2azDDETb/eq6SjhKwMNV0N6ntgPXv7vkNrechYVFHYp09FRhtImkwvdyO
 +d4wQLJCsxD7n7t9dnVdy4cJnxl2CY8UyZqT1THq0dQuHu01PZ+/++pee
 JZ0FEc4uHh0gNxkAoQTJUSGHH7cjKOBYjXDkgu4ifbkMkuVtz4q/3R6x0
 YlzBHSLjyfKYDmGHtMJzF9CQpFLtrqx+JWkUv57Pwk3j5WDCjSy6+4yTH
 m2SKKLgEORv3N/WJgVoAIegBkJZhVVkNtGt/tBZlLC8S1+6wr5qQTS5H8 A==;
X-CSE-ConnectionGUID: npxFOClnSMemyh+rM6Ka+Q==
X-CSE-MsgGUID: Ci/AppqLR6Ke07IodN9b2g==
X-IronPort-AV: E=Sophos;i="6.16,316,1744063200"; d="scan'208";a="40411533"
X-MGA-submission: =?us-ascii?q?MDFzuVCe+scfE+Dl2fEp6tqSZ3xh1jSja0GAxk?=
 =?us-ascii?q?3pwVmeOK3H6g1qm4nSSukD2Ja2WE6IEmgi4Jdg/Yuosr2t3PHu+vTaHL?=
 =?us-ascii?q?aMIRUIdOKKJ7cFz+c+kUEJm9c9Y5FMGePZGjV5bCcDTeD3irU//iwB2o?=
 =?us-ascii?q?Uy9Kyyi5/mZ73fMGCGDhGDaQ=3D=3D?=
Received: from mail-northeuropeazon11011043.outbound.protection.outlook.com
 (HELO DU2PR03CU002.outbound.protection.outlook.com) ([52.101.65.43])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 16 Jul 2025 16:27:21 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSClksSXBb6Dto2oeHcUEUonqYoNP2GIJ7CGcLEQILxNl1ANT5W7ojPE1UoeLf1cY2G34vcQyrK7hGQJZJ44oji5O2XqP64IdW+2Af4QSQXBXeA2uEt6lRzUV8xTpOeH9gNHAJZ5CBmjaQyZozurTNMmLlLZawLN74YN2SjMx3R3P4V5Ay/DMpfevJne4dNdGmqeuMQbj69FsVcCFZjChMqZ6SaK+gPEpuKsmDrutISbIFyGmKxrpkuTf0wEy/qP6xl/O0EvWUgA2gJ5w7Q+/moTnxllzgSnm7m+NOI6n27vuLzuiNCuBs8HfC/S7fxb41PS3wHcMzUEKRHVsSyFyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXIHZ1V2YGaHdWeCb8CGYpLemVpwJ9WtNf8vsh+iqTU=;
 b=qWBUDKsVbJckNe0J415lfUeD/rJBPqlpGT7mwetgixyMtPLQkbWVJ1f3NqsU/ymN3qef/UkPCNXPeruOpgWl7xmSOViAsmrdB9TLJgEkrxXUFR3RkbD+3d6PKH6B3YgciOn/gokxNRKGyzKz0LVT5SauivcW6/yJ1/QvxuIGQCnHzmxvgGySN3/WVy7ybdIfXYLu0wB0Zb4P8AnO3zb7VFqxIE0tA5zweZTq5QTwWFzZK0ApJNMG2kEVtfdbIM2zqYQTfmig6OTTIT5DZ3zRdv6yoI9KgV2/P1Tswmy6X00BfruKPImxvZQ8doeLH6SpI1+U5DCfDEBjNm+vQ0Yj+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXIHZ1V2YGaHdWeCb8CGYpLemVpwJ9WtNf8vsh+iqTU=;
 b=TIimhns8lrPX88mdzsvHUSKDZXwkjnjb+PorSkMHXDDoeWD0yK5yu7Q8DmGgQ8E4dvifR9r8NK9UGt2o4/vMBZxFTgqkov8CQw9EjPYSY1oES0J+wlFZOZUvA5I2EzH8LK4tfW9JtWmB3/YSXx3kDucMKMMP7xNZnJ3XBiLMz6EfARfbT4Iew1pxEy7Kje91LbJTF9//z6Cpdw7PIOxisNHlbpe5Z8Psj/Mg/HZ4AwNEJr2ZChIoTalNXhN0zScljm09fz4UnQ6xTwnTJ+GaJZdvvuUm7lXBUFQoiU3vFEqi8FM7FRpjKaElBwVzuBY/14AtqNHVuiWuILZQSMmF6g==
Received: from VI0PR07MB10776.eurprd07.prod.outlook.com
 (2603:10a6:800:2b4::11) by AS5PR07MB10105.eurprd07.prod.outlook.com
 (2603:10a6:20b:683::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 14:27:20 +0000
Received: from VI0PR07MB10776.eurprd07.prod.outlook.com
 ([fe80::9c6d:5ed3:42c0:6e5]) by VI0PR07MB10776.eurprd07.prod.outlook.com
 ([fe80::9c6d:5ed3:42c0:6e5%4]) with mapi id 15.20.8901.033; Wed, 16 Jul 2025
 14:27:19 +0000
From: Ethan MILON <ethan.milon@eviden.com>
To: Sairaj Kodilkar <sarunkod@amd.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "alejandro.j.jimenez@oracle.com"
 <alejandro.j.jimenez@oracle.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH 4/7] hw/i386/amd_iommu: Support MMIO writes to the status
 register
Thread-Topic: [PATCH 4/7] hw/i386/amd_iommu: Support MMIO writes to the status
 register
Thread-Index: AQHb9iQpgqikzk6fm0SRzJBJaXPAG7Q0zySA
Date: Wed, 16 Jul 2025 14:27:19 +0000
Message-ID: <0ae88a3a-be70-47b3-9829-fbbb0dfcb8ab@eviden.com>
References: <20250716073145.915-1-sarunkod@amd.com>
 <20250716073145.915-5-sarunkod@amd.com>
In-Reply-To: <20250716073145.915-5-sarunkod@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR07MB10776:EE_|AS5PR07MB10105:EE_
x-ms-office365-filtering-correlation-id: f1412c76-b301-482c-5969-08ddc474defb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QTkyUTBXckFUc0ZHT2hQQ3gvL2h6R1FhSlB4T0hNclBnS3U2SU9UUUdJR2Vh?=
 =?utf-8?B?THhSZDA3WXNRNkxHZ1lhVnc0TFpNMkJ0bTFZalROY1RqellnTzBCZXB5VHdQ?=
 =?utf-8?B?N2JQdGZPRFNvK1dQK2RvdStid0NWMDJXbTU0cm9XeWNFVmxuZHJIZHBwWWps?=
 =?utf-8?B?NEU2bkhWNmMrcmdnMjNTUkordXIzMko3ZmpoRkZMeWRBdXRZSzFaTUhxNTls?=
 =?utf-8?B?aWxQUzFJK09kRHUwOWgzNXdtNVJGOUx6aThvNnlEMzFJRVIzOVBBMm9TVWM3?=
 =?utf-8?B?cDVlaEZGZ3R5MmJqUHBJdW9iVTE4b0k0MWJ4WDRicUhPejBYNG9kU00rZXkr?=
 =?utf-8?B?cjMybjl1L3hQV1lsOStCNTRGdExXYWsybVZ2TzhuNmtBVW5Ub1BGS1R3STBj?=
 =?utf-8?B?Q2R5WENiblUwcm9XVEdoNUFyeU92Wnp2SUN0YVdyTE1nUkwvUHdJdEhWWFlz?=
 =?utf-8?B?c3I1ZCtvTFB0UHFMZEluM1FNbmJ4UlZ5aXpoeS9UTTU4WmhOUUY5b3R2aGZu?=
 =?utf-8?B?MEg0bG5MWmxwemwvWW53QjB2VmozSGNtZWg3dEF2TG5PdzBBbkVZNjZwYjhT?=
 =?utf-8?B?bkE3bGZYNjBWcXMvOVZzT3Jvd21YcXIwMWNqUjJuT2d6SDBsSENSc0VvcXVp?=
 =?utf-8?B?eUxIYVMvV3ZTd3IrdTlSblc3R3FleWc3Vjc2UjVJK1F2aHh1N2FHVGoyQUdp?=
 =?utf-8?B?cXg4ME5PQXljNTdrQXdwa1cwM0N5V1N4dEZKelJtTHEwWk85Tjg5alR6cW9E?=
 =?utf-8?B?WlpaYzEvb25ha1JuczNqRlR5d0ZtZnozQkpCeXd6cEgzOEwrYjNnYWpuVEdJ?=
 =?utf-8?B?QXpGK2U4aHNXaGxpZGdQVkw2U0FmU0lRQzFqdFl4UnR5b2MwZndLZFI4OU9L?=
 =?utf-8?B?YXhTeTZINVVSRDA1NVhMNklaR2N1Z0I5QjJENXZ2L3RlV1psaGtVUy9oTTNF?=
 =?utf-8?B?OWc4MjVwTnhNSWhrdlE1ckdsVlVPd1lSZ3FrZGhaMjBRbWg0MFlJUi91YldE?=
 =?utf-8?B?TnZIZFVuWk5XbUNsOTU4Qnk0cVVTU2FxQVBjdVc2Zk03TTBneEpjVWIyNmx5?=
 =?utf-8?B?M3RzWVRYOHFMRTk5a0dCVk1EZ240ajdVUUVqMkkvckMwczdaRkZvWHNpUEM1?=
 =?utf-8?B?UGJsRXJlS0IzejVZdmpqQ1Bqdlo5QmRLN1FReWFJMkVrSVB5WXhCaEhGTXpK?=
 =?utf-8?B?U1libUxVQ1pUdk16UEZ5Y1AxUXRmTXkxdEhnM1AyWGpxY3hkL09QOUs3NTZR?=
 =?utf-8?B?VlBSTHh4OUVnd1hoc0JleWFHSUgxZk5ubVVucm84ZkY0a2E2R2ZZdUtOeGwr?=
 =?utf-8?B?Wjd6Q0kwM25rZnNtTHpFVWhLKzFBQzUxeU5WVk5VSjc5L0hpWXB2eDlxMGwz?=
 =?utf-8?B?RXNMdmdQeDFUOUtpcVlGRytqam9aMUFGWDhHcHFhOEFqUm9WbjZqcEVlSkVT?=
 =?utf-8?B?c1hQVXhRbktvVE9Zazgvb0tVRXhpeUdSMUE2WnJweEFrK1VwMFBkaGMzSHFL?=
 =?utf-8?B?NkMxbmc0TE1VbzQyN2pPVEN3M1QxS21yb29Sdk1QUkVnVXYzeWczSS9LQTJx?=
 =?utf-8?B?U0QyUGNyMUNpYlI4bDVBT1RTS3dBb2RhRWF1SjA5MXdxYVFIMjB6YjNXaVNv?=
 =?utf-8?B?YjZ2K241UTVGU21rVDR6UXZxYkdIZnl3ZU51b1BDbVZnN2ovOEZ0b0sySUlN?=
 =?utf-8?B?UWkyTXVEYTk4cWVHUTltYk5YQ1ZPbmxlSHlRamlDS0tnWVcxbGJWMEtpeWdp?=
 =?utf-8?B?Y2krSXBrS2VsWWpBbG5LdTNEUHc3OENKSnRtL3RheDkyR21mRTZtYXR5OVdt?=
 =?utf-8?B?VmNLc2d3Umw1cmM2Uk8xblFzYUdlc3labzhYYVRPR0xKMXhhVUlESUFzcnR3?=
 =?utf-8?B?MGpLSm96UlYrNXh2eUlBTW1idjg3VWJUSkdZKy9pSTRWNGFCSGNQTmFPcUNh?=
 =?utf-8?B?V2JWUkUyUUh4dDB6bzhjQkNmeGZNbWRlVGVBLytRdmRkSFdKbGFkZVQrcXEx?=
 =?utf-8?B?QmtPSlhDUHZRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR07MB10776.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3hhZU1nZ3FZOW1KTnViZmVXOCtEV1ZNdXQrZDU4L1JHaGZwOG5OclFtU2ti?=
 =?utf-8?B?U3BUNWZuUlRWTyszalVtNEVabFhlWGFhQk5sdzlTbzAvMEtDL2pCTkdvWkVi?=
 =?utf-8?B?dTduWTR6UzVlV1d2RnFpbXFGazUzeDFGby84UURhQ3ZoejhjMzlCQXNRM044?=
 =?utf-8?B?UEJneCtCZFVMMHRWU3ByY2ZyTDlzV2l0ZER5N2FST0ZRTkk2enZNU3RqNnU4?=
 =?utf-8?B?TmJpSThONnU2U1g2a2NGRlorMHd1Z2V0c1FyVC84bzFUSzBZMDUzcU84K3FQ?=
 =?utf-8?B?RGNUeWhLR2V4YyttWisrVEJTbHRpVDJsbU5MS24ycVpuY1JaOUIzVTdpRHBH?=
 =?utf-8?B?dUFMdGlTNmo1aTNjS2hvaHpZS2QxOC9nSFdoTFFVVW5oQU9meDhMdkR4VHBP?=
 =?utf-8?B?dy84YnpkMzJoTE1VUmJqMVY3dnJUN3hCL2lqMkN1Y25ya3Z2cTd1Qnl6UXgw?=
 =?utf-8?B?K0VVb1VjOTRHL3hlZVZBNzJXMmFNNWl3WlFWWUxJNE5DZHpXTnkzbms0anls?=
 =?utf-8?B?aFpBNGk5QWZaYVY5VENSbHFuQmhYN3NHblZtQi85azNhTHc4OVhmWGtQNnpv?=
 =?utf-8?B?Um1STWFQRlpzditCY21QZ0N6MFd4RkJ1MjBQVWRrWXA3VmFNcjh2aUs0eVk0?=
 =?utf-8?B?bUFCSk41djZFTUFDUi9xRm9KUnRGdTlDeUZXeTJIdzgxMDBLYjNhbzAwTDUz?=
 =?utf-8?B?SmJ5RE9TNUJaOG1JZnlkZUszckkvNlVBQ3Y5bmJLemtObGxEckJWRFlsNjZ3?=
 =?utf-8?B?d1RtWXNZRjlWNXBZV0t3R1Z4RTk1bEZYbzRLc0gyMGRkZFI3VFBKVTVzaDYr?=
 =?utf-8?B?b2QyT3pSelVtZ1N5b0FHWGE3Snh2UkxEK0pVL1hoZlRReFg1c0V6SC8yRlE1?=
 =?utf-8?B?ckd5SS9IeXJjQmR0SzlSMWo5d1pQbnUrR3lBZWhGYnpyc0xEanZMV1VTcVRZ?=
 =?utf-8?B?bHFOemc0Ny85QUd5b0NhSkxCSW1mQzI1UXFLQkJRYVJMVmZBWkpmQklMWXVk?=
 =?utf-8?B?eUFKOVJKSW9pRnZDOGtObGkyMm50aXFPUVMwQ0wwakJQTDVlS2xLdTJySURS?=
 =?utf-8?B?QnNRZFF0QTY0b3pwejYrWTNBU1gzeUZIeUVqTkp5czhGNWlBNHArR0V3WVdx?=
 =?utf-8?B?WGZ3V1RvNSt3Nk5XWDJ3YUw3cGZGVFRJdmtNWWVPWkpBWUhzWnRkWENvZkND?=
 =?utf-8?B?NXZUNG1PYmZWcjdpVlVKSDFuYjFjQnFveitSN2Q5YmFNSkdPdkxZRzJkU0hC?=
 =?utf-8?B?RVlDendNeXl3QjgyRituM1I4aE9USkdDV3BMRkswNS9BTTg3MXhmN1QyYjZD?=
 =?utf-8?B?MHVIRjdPei8wRUM0TU10ZEw4aXVSRm5ZeDExNEJEbUJVNkVmOWdLWHdHOFhl?=
 =?utf-8?B?VGtXQWEycGY5OTM3K0FjWG5mdjhUQ3J0LzlxZE5SMzJhSEFXTTdld3F1Z2p0?=
 =?utf-8?B?Zm1ZL1pNQ29DTFllYTgrdG8xeXNrQ0xMNXJ5L3NkcU1lNWUrSkN1WUd6NDBP?=
 =?utf-8?B?cW9WN2pHR1BudkhuVkRxNzFGamZNVXZyTHdxalZ1cWZoM3hxMG5YWFdmNmF4?=
 =?utf-8?B?ZzcyaDN1UHUyVnBXdlhUb1paYjNnb1U4Y1M2ai9uVzludmorYmV2dzJZc1RC?=
 =?utf-8?B?empsaHFNL0Q3MlhZeDh6bnBVa1l6RURiRE1VbGFBS0R5cjEyTHoyNFQ1YkdT?=
 =?utf-8?B?NGRFL3oydmJKRzV1S3BqTWdlTEpucU1BdFBHdFFEK1oxS2VvaksrR0hPYVRh?=
 =?utf-8?B?UmVwanNuM0t0dkFCdytQS082THNKem5ZdzVVc1lvVW5wZ2xpTUExZ0E4S2pH?=
 =?utf-8?B?cFlJWjB6UFRJYzNENXhCV3prdGhlOWJPbmpCRFBUNlFPbnIyNzRXcTlIRFlO?=
 =?utf-8?B?dEhqQVpUYnhaVGlSUlovMElnZVV0N3VoYldVWUh1UWtma3cxTVpNeWZ2QTFw?=
 =?utf-8?B?NHMvQkxZWmZGdDNqSitjZ2ZXQlVPTGp5TzRzNFdxREdqeXREZHA3cVhEUXJy?=
 =?utf-8?B?QzhVZ2gyOVdvNEtVUEFIaXdNbzVHaXROSXkwQ2dwVjV5VVF1V1hyQjYvWWR4?=
 =?utf-8?B?NTUydDY0Y212UGJQbmw1WXdkRHVyTnNtZnRrQ3VuRWpZY1c2WmxQdFliMHJJ?=
 =?utf-8?B?bGdmaVBFVkdYRHdDRWc3VFlndzN6YjhCVEoxdGxYKzBVYzVlYUdpTmc5WHhU?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75BC364CEC2F2643A42B5AE2CA4130B3@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR07MB10776.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1412c76-b301-482c-5969-08ddc474defb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 14:27:19.2355 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K1B+kiHrGqAOqOztDrESny0IZOaANjhv+h2Mq93qtRf0p1uuDEgutIuzqH8AsRpv5QH0J2TmmX3efV6A5HXBrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB10105
Received-SPF: pass client-ip=80.78.11.82; envelope-from=ethan.milon@eviden.com;
 helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGksDQoNCk9uIDcvMTYvMjUgMDk6MzEsIFNhaXJhaiBLb2RpbGthciB3cm90ZToNCj4gU3VwcG9y
dCB0aGUgd3JpdGVzIHRvIHRoZSBzdGF0dXMgcmVnaXN0ZXIgc28gdGhhdCBndWVzdCBjYW4gcmVz
ZXQgdGhlDQo+IEV2ZW50T3ZlcmZsb3csIEV2ZW50TG9nSW50LCBDb21XYWl0SW50ciwgZXRjIGJp
dHMgYWZ0ZXIgc2VydmljaW5nIHRoZQ0KPiByZXNwZWN0aXZlIGludGVycnVwdC4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFNhaXJhaiBLb2RpbGthciA8c2FydW5rb2RAYW1kLmNvbT4NCj4gUmV2aWV3
ZWQtYnk6IFZhc2FudCBIZWdkZSA8dmFzYW50LmhlZ2RlQGFtZC5jb20+DQo+IC0tLQ0KPiAgaHcv
aTM4Ni9hbWRfaW9tbXUuYyB8IDMgKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9hbWRfaW9tbXUuYyBiL2h3L2kzODYvYW1k
X2lvbW11LmMNCj4gaW5kZXggNzg0YmU3OGY0MDJkLi5lMGY0MjIwYjhmMjUgMTAwNjQ0DQo+IC0t
LSBhL2h3L2kzODYvYW1kX2lvbW11LmMNCj4gKysrIGIvaHcvaTM4Ni9hbWRfaW9tbXUuYw0KPiBA
QCAtMTYxMyw2ICsxNjEzLDkgQEAgc3RhdGljIHZvaWQgYW1kdmlfbW1pb193cml0ZSh2b2lkICpv
cGFxdWUsIGh3YWRkciBhZGRyLCB1aW50NjRfdCB2YWwsDQo+ICAgICAgICAgIGFtZHZpX21taW9f
cmVnX3dyaXRlKHMsIHNpemUsIHZhbCwgYWRkcik7DQo+ICAgICAgICAgIGFtZHZpX2hhbmRsZV9w
cHJ0YWlsX3dyaXRlKHMpOw0KPiAgICAgICAgICBicmVhazsNCj4gKyAgICBjYXNlIEFNRFZJX01N
SU9fU1RBVFVTOg0KPiArICAgICAgICBhbWR2aV9tbWlvX3JlZ193cml0ZShzLCBzaXplLCB2YWws
IGFkZHIpOw0KPiArICAgICAgICBicmVhazsNCg0KVGhpcyBmaXhlcyB0aGUgYmFzaWMgaXNzdWUg
d2l0aCBpbnRlcnJ1cHQgcmVzZXQsIGJ1dCB0aGVyZSdzIHN0aWxsIGENCnN1YnRsZSBidWc6IGFu
eSB1cGRhdGUgdG8gdGhlIHN0YXR1cyByZWdpc3RlciBjbGVhcnMgdGhlIGludGVycnVwdCBiaXRz
LA0KcmVnYXJkbGVzcyBvZiB0aGUgdmFsdWUuDQoNClRoZSBjdXJyZW50IFcxQyBsb2dpYyBsb29r
cyBsaWtlIGFuIGluY29tcGxldGUgY29weSBvZiB0aGUgSW50ZWwNCmltcGxlbWVudGF0aW9uLCBh
bmQgb25seSB3b3JrcyBwcm9wZXJseSBpZiB0aGUgVzFDIGJpdHMgYXJlIGFsc28gc2V0IGluDQpy
b21hc2suDQoNCldlIHNob3VsZCB1cGRhdGUgcm9tYXNrIHRvIGluY2x1ZGUgdzFjbWFzaywgZWl0
aGVyIGluIGFtZHZpX3dyaXRlW3dscV0sDQphbWR2aV9pbml0LCBvciBkaXJlY3RseSBpbiBhbWR2
aV9zZXRfcXVhZDoNCg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvYW1kX2lvbW11LmMgYi9ody9pMzg2
L2FtZF9pb21tdS5jDQppbmRleCA2NmQ0MmYuLjQ4ZDk5MSAxMDA2NDQNCi0tLSBhL2h3L2kzODYv
YW1kX2lvbW11LmMNCisrKyBiL2h3L2kzODYvYW1kX2lvbW11LmMNCkBAIC0yMTMsNyArMjEzLDcg
QEAgc3RhdGljIHZvaWQgYW1kdmlfc2V0X3F1YWQoQU1EVklTdGF0ZSAqcywgaHdhZGRyIGFkZHIs
IHVpbnQ2NF90IHZhbCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCByb21h
c2ssIHVpbnQ2NF90IHcxY21hc2spDQogew0KICAgICBzdHFfbGVfcCgmcy0+bW1pb3JbYWRkcl0s
IHZhbCk7DQotICAgIHN0cV9sZV9wKCZzLT5yb21hc2tbYWRkcl0sIHJvbWFzayk7DQorICAgIHN0
cV9sZV9wKCZzLT5yb21hc2tbYWRkcl0sIHJvbWFzayB8IHcxY21hc2spOw0KICAgICBzdHFfbGVf
cCgmcy0+dzFjbWFza1thZGRyXSwgdzFjbWFzayk7DQogfQ0KDQpUaGFua3MsDQpFdGhhbg0KDQo+
ICAgICAgfQ0KPiAgfQ0KPiANCj4gLS0NCj4gMi4zNC4xDQo+IA0KPiA=

