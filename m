Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049E1CCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 06:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8CFz-0005Pj-0v; Mon, 13 Oct 2025 02:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v8CFw-0005PC-Q4; Mon, 13 Oct 2025 02:42:05 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v8CFu-0000Lq-D5; Mon, 13 Oct 2025 02:42:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlnBJgI+RAHmti6JSmfWsazzzl4Kk6KzhmspEA7nw8yZTbnoZgjmNgT1T0QKFAckaBsS/NA91G7lp8kjb8itIG+3kYeIeqNH+H1g3+A3tzHbC8KCdmd21hHlWGYwiWOhpaAC18YdblkywQX3OlWoMcihGp2CMJi0d0a/b7Qza/11ZhvVpfI8osKj7xZaOMOHK3Zi5258AtL/vzfAc/hQGs790aK5AV/aIARUlN9IUYeLL9Ncrgy+WMZB56vHig9k5g595LwztOhhoNmo7EXXaG6OO7Wy2EqxC9JWVoBRTuPDWIwdNr+WbFHJHWu0x7yDQ1P0lSQd8Vyu+7u63lg+dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDJtd71t5IUnVgGcyBSZTHlwZeIvyiAwp07jQ5+09Sk=;
 b=RfaQ7vT0Gb7JwdrA9VMr8Lj8szvT80yDMSCOWIbcpVFtHKzT3n3GOYoKO194NrWHFD80igF2PuAoPabWwhyVBau/+BfsetRLKzvBXmKS6XSY+i+XtJ3fnxhwkdW655vjDdmoN6cXtKNGDbH8YLnfxy6q0rhPnoCqi9V1Zr+IEitb9Cz8t+bv4LEsbz7ARoi5vOINBePAjy/3OUKPApMgys9qjVeWx0enuH/GtXYbV7NltoX8sgJi7lnoEgmLq4VatF5O7G07b8QJnlGO+5noEl15LSY7Xb5X1S7dSHKqCCFfIME6Crp0LmEGNhmSBAEh09IRTTXiv27n+IH+/PdJ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDJtd71t5IUnVgGcyBSZTHlwZeIvyiAwp07jQ5+09Sk=;
 b=Gf+g5n1L4KsEFdEgItelcHL/fJgRhnKzML/Bln5hwZiJm9aA1SGMCAFK39x/q7k7PVWtJGj9Wgm8V/MIXOixFQd+zt4Zqpl5riP0YVgSkNZLg+CkvXsw26NtQHNR6KpTLCWQ57lGjsRNaDp/q0DQ/li+tvTo50ZfuM13kW414/KqRLdcLIqCnwRyPRzWnZpBhoCVo8gfUTmRPo8BWDQB0mqxUsHmpO6jhWbh5KRb3oSBkimlgdJgFXbznQYsvWz/kEiGTrSGZd1h12NuZYuc5epSxfQ0G/kXA+vdevOimhDxl1VuEHIH1l/b9kdjH7pVT/fYVFy2llVHeCBchIR8PA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AS8PR09MB5301.eurprd09.prod.outlook.com (2603:10a6:20b:372::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Mon, 13 Oct
 2025 06:41:56 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 06:41:55 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
Subject: Re: [PATCH v10 00/13] riscv: Add support for MIPS P8700 CPU
Thread-Topic: [PATCH v10 00/13] riscv: Add support for MIPS P8700 CPU
Thread-Index: AQHcNFLPBgrPC/ey2EWWlLi3ONa6A7S/sEiA
Date: Mon, 13 Oct 2025 06:41:54 +0000
Message-ID: <dc602c2c-d531-4a3d-91cd-cd9969aaa785@htecgroup.com>
References: <20251003104443.51501-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251003104443.51501-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AS8PR09MB5301:EE_
x-ms-office365-filtering-correlation-id: 491c42e5-dcea-4214-4204-08de0a2399c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?QXByaHR5cFFMSElJTmFIMUg0Sy9rTHRzSDlwbCtXRDVQWEZRNEFTWDk3T3NX?=
 =?utf-8?B?OEo1S1YwZmpsM3U0WkpUZU5wU1JqK0hDYnlhMHZyZExTVHBwMWVGd0dscmRH?=
 =?utf-8?B?UWkzWkJCbGRjS0FpaFZycE1nSG5nNkRQZ1U4SXRFMzVWQU5jWDdNbHFXVVo4?=
 =?utf-8?B?YmJLVDJWOThoSzN5c2Q3QlZnbHBOUVhhNGVyNm15dVplRis5WllNOFFoVVZP?=
 =?utf-8?B?VTMxMVhrUEF1blA2Ym1XL1BFandzNmpQNnpUMnFHVmQrOVZzbkFWc0tRQ0RZ?=
 =?utf-8?B?UHRDVUljSllLOWpJbndMaFVsU0ZmUFVQYXl6b3NRdU1QNTk1T2gzb21FR2NM?=
 =?utf-8?B?VjMrR1MxSVJoM0luZHp0Z09rL3pyaCsyUzZCSHp2Vjc4b1k5RzBFcmlSZTRT?=
 =?utf-8?B?NHljWXdGU1VmZXZEa09WQ2dPK3hPZXhuOGdCSGxZNktsUTVGSWJsWlJXcWx1?=
 =?utf-8?B?UGx2OHd5Q1RIZk01bGZ4VDAxMlJLMnEwRWYzajJnUXdHQitWT3NrMGJDRnJB?=
 =?utf-8?B?TlI3d0xHZWtMOVFKS1FqQ0pCWkhJRFlQYllLTHRvOGFpSFovd1hXeGMzZXQy?=
 =?utf-8?B?b2M4eTVhb0IxY2dWejJWNmlDVXpRYW1vUFVkd1JSODBjUGJmZHdydlovbHIy?=
 =?utf-8?B?TmRmbkR6ZEtNTC9seHdqMk1EbmZXcGoyYlFwZS90NjZheUxROVZ4U2JYc2k4?=
 =?utf-8?B?azcrM1M4Skt6MnNYYmFRd0pCRGVmQzRFNm5TTG5lYmoxazJlNUJYbHV6MUlX?=
 =?utf-8?B?SVM3RUVBQ3RwMXRMeTJwTi9rNXpkYnJLajBFSnJoS1V1MTMyZVlaQXBwd05U?=
 =?utf-8?B?U2RKVWlTZDA2TENLd3BDQlZtQlBjbGZsZ0VRbkJQOGI4STFqV3lxUzlVZ1dh?=
 =?utf-8?B?MitMeHUrelp5dlNEUDRPa3F6UVNqOVJEZnA4bG54bTJabStsYnZ6Rzg3dUhJ?=
 =?utf-8?B?Ymg0SXNodThRcTZCb1FDUU85bmJOWFFhRVQvWUZkK0l5SmNNSUhQcUVZSzhy?=
 =?utf-8?B?TFNNeGhWRVh3UWplK1dnNmt6Z0N0MDJSYjhZZEYwZWRCRGFrdEt6MG8ybFJl?=
 =?utf-8?B?VFFHQlM3bWk3SUZ4clRrUlVQN21DM3F6SDBKeG9qaTBNY011L1M4VWtUbXht?=
 =?utf-8?B?R3ZwQVh6bGI4T3JMamxmcmNyZ3VjT2ZVU2FkVFIxOFVFSzUvVm1SMjdTSHdo?=
 =?utf-8?B?d2JuSjVuYWpqVHlJRTh6d0R0Y0NtTi8wMnUvZzNzWUNjWkNMcGtySVd5aVFS?=
 =?utf-8?B?V1BHMFdGK0syVmsxVFRUYjFTVERhUFBJSDZxamtlMHRHSFJWcEFORmkzcnVz?=
 =?utf-8?B?Wnp2R0dMd3B6MFdjSlpFK0IvZk1VajRSZVhMYkExdFVnSnJFMXVPSXM3Z1Vw?=
 =?utf-8?B?SExMbTJTcVdHSk1Ca2FzUjYzc0hQMG5RUGJvM3JWSEdtWEZQdVg0REE5UWJK?=
 =?utf-8?B?U3BSMTRnZi9XUTg3UVJaOVI3VGRRaEJHWktCWHBwelFGL1lRTHFJZFBPRURh?=
 =?utf-8?B?amJhRC9xaU5vYS9BR3dXZnVDNUw1dlY1eUd1SXVqWi95NFc4TjE2RmtaTno3?=
 =?utf-8?B?V3pmait0ckRzK3k2TjZMM2xoQkhIYThOV3RMQ3FMTlNsVm1qSFZ6VTF6eHNY?=
 =?utf-8?B?Y2s5b1hkWWovQy80NW9kRWFxd1BpdGhKOXBhdk5NLytPL0M5VkNuZDEwYVMz?=
 =?utf-8?B?VmdHZExGTTVIckRoVmRQUnFhZ2xWVFN6WUF3SlpLaDV6QjhOZTBhV1Vqay9x?=
 =?utf-8?B?SjM5ZDNtT1VkNFZSUHZDdXlqM1BIOVRBdHRZanB4UGRyN0dWZURnN0czMzJC?=
 =?utf-8?B?VHR5Wm1Gdm1sWU0xSXlKanp1c1REbE1rR3FGVkgra1RRMUxkOXZQWktEOE9V?=
 =?utf-8?B?cDdsNG9MWG03aG8vYStsLzhBcTJ1Y3Ayd3cwUjZ1TmZjWTc2d2NaLzZ4c3VI?=
 =?utf-8?B?UVBzenVjUHFlUWtObi9FQnQ0d0JqUU1HR0VwUWlCeDFJOVJlYVoxcjlnOGJQ?=
 =?utf-8?Q?Q3DUUseTo6j15RGCzF8TCrw2pWTuiA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUd6VVQxbEpnNGVzdG5pTXVYcUZXTS96RzlrNUxuMllPME1Ic3FPZkpuS0oz?=
 =?utf-8?B?Y205OFcyanN0eXFtM0o2djZCaUlqRkRUeExZYUwzc1FUTWwxZ0FwblVPNlU0?=
 =?utf-8?B?VWJET0lHelplcDAxUnZzdVdxWHhsY0dtb1ZpWWhIZlBIb2taNU4wY3ZsQVFF?=
 =?utf-8?B?VEhYZS9MdWQ2YlQ0K1gybzltdS9wbStnTXJiOXFpVDIrMXA1dVdQeGs0cTlG?=
 =?utf-8?B?bGY2aW9MaExUVGx2UnZrMG5JWmxZSHdNT29KdGNiTldOU0ZHdGtMM25hcnN0?=
 =?utf-8?B?MnBZMCtFcTdmU0grMXQ4UzRVWHlobEtzS3R4SWFia0k5T0NOK0oyeFEwZ3JC?=
 =?utf-8?B?ek9kY3MxUmN5eHV0VytzUG9yaDJMQ1NwbjFKcVpEVlNTZmN5UUZXWWVxWjVy?=
 =?utf-8?B?QjdyTWZpa3dCcVBxWEN1MjBhd1doR3l4T00xTnpzam5tanBJcmE0MTd6OVpl?=
 =?utf-8?B?YyswMDlDOFV0UVYrZVBNNW45bEU4ZzlSYlB0YWJFbXdnTTQ0UktxSHpKUENY?=
 =?utf-8?B?YlYzT0dzRWVEeEVyUkZQSDMxT3ljUDJxZjlMUEd6TlZlc2N5WE9UZkpVbk1x?=
 =?utf-8?B?NXBPb05GOUdhQ3hDYjF1djBhQ2ZoTElTV0RoVjZmVXVESXFzZHVnNGhXOGxo?=
 =?utf-8?B?eVJ3M09wbXhHQWFNaHA4aVhxaVB4bkRkUzU5UWUwQS96cDh1cFZtYnRqVldo?=
 =?utf-8?B?UGwxbnFJa0t1V2RSdGFjb1J4ejd4RE8xN05pb2F0QXAySmxaNUl2NUZOQk5Y?=
 =?utf-8?B?QVcvQWpwWTU4VzRjajVBcjNKT2FDS2s4a1RGODlFemo4WGVZODdsay8xRXNV?=
 =?utf-8?B?QnI2R0RTY01OMDY5T1U3YzNqMFZZcjZLQ1R6TUkrbWhydDU2MFdjSzVEVmpG?=
 =?utf-8?B?b00wTjlmd3U5RnRzdE5ZRFU0cVlBL25qZmhsRWViT24wMUpQcjVGWXFJR3pU?=
 =?utf-8?B?Y0U4cTg4T0hqd0tUb1pzbGhyZ05UcWU5QnRyRUVRTVRGR1R3dml2WTdJUm5W?=
 =?utf-8?B?aXFwbEgvYUxLbldyV0Q5TUZ4NXN4REQ4MHdwVTMyWUxVdHBSclFHUE5ic0dY?=
 =?utf-8?B?M3RlSTVrSFZMT0VCNTZ0clhEYjFCM28zdFlMeEt2b0xmTXFRS0Fob1ZsbG5w?=
 =?utf-8?B?WWs5OVpVa295S0R1RFhJcXBSdys1RVU2TG9FaXYvMG9nVnFWTHVXQjJ6WG9v?=
 =?utf-8?B?Q0haVExRb3RvVzk3N0xpTlJXOHF3RExqVXphWkk3NjNjcGE3TnZhUk5aSWcr?=
 =?utf-8?B?L1JIRGdHN051NWhaMTMwTmxvVHdYNGJtbWRmaWlNbk5aTDhQZm5sTVRQd2kz?=
 =?utf-8?B?Q1NYR3JISElxVXV6OFAyWTNkMmxRNlNBeml3UHYwa05OYjI3bWtiTDNKeTMv?=
 =?utf-8?B?WTIvMGcwQ3lDRlNyQndrTzdNM1lYNjRqNldyRy9TcEpJZEpheWJCVEYySmhn?=
 =?utf-8?B?S0NmVGIydzJCaFlFNHFrUm94YUcveUIwanFNQ2Fsd1ZRRGhHN1ViK29kZ0ZK?=
 =?utf-8?B?R0FFQ2IwVUlsdFRvcUhzYnROTVRyQ0hFYU9rRnllZFdGVWZmV2FCRk8rcW1m?=
 =?utf-8?B?dEJzaDZpUTlJODRTTDNxRWdZcWY1RUNvRWs0MmFROXRiNDFmL0E0VUxXUm5l?=
 =?utf-8?B?bkN0WlVydnFNNmJ3ZEVISE0zSXVTNy9yamVxa1kxOENjNkVDaVMyNlJKbnov?=
 =?utf-8?B?bjRaTGhlL3RydXJDWmZidUdRTmQ2RCtGVFpVbDluSk5kLzZXb2ZFV0d3SC82?=
 =?utf-8?B?Q0QwK0JiSEIyaUlGZ2RKWkpES0YvZ2Nsd0E3R0djNndtMVgwamxkcDAwNXNF?=
 =?utf-8?B?eEhMNWdlQWFIWUp0M2V4NWYyUjdPNFp3cnQxWE5FUDFjQmE1c2pnN0JWTVRE?=
 =?utf-8?B?K2toMURocllOdkFqVzRJNEE2OWQyOXpIVzJ1bndER3lLSlhMeXVIeGtiMnAx?=
 =?utf-8?B?TVNPNEErZ0ZpYm9OY252TVFnV0xaWFNqODBjSVVpUDMzdGo5K1NISWNOdzkz?=
 =?utf-8?B?VjN5bGpvdkF0Mm1vckhtQnJQRTRwQVhYQlhlQjExZ1RoNUNFNmxDZGpjYjUx?=
 =?utf-8?B?QTQ0K3VyeVFjclZqaHpxMU13bnp0SE9pWktKQ05INVBWVk9OeVpzNE0rRVV4?=
 =?utf-8?B?M2NWanBqeGVnUUtreDRWdUJvV1hQWk9hT0RpU1dHbzJwRTFVdE9OeHZFN3RI?=
 =?utf-8?Q?ixaAhBb63a3yNo204YNrWDM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB3924E11F617043A1C072807E10F6BA@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 491c42e5-dcea-4214-4204-08de0a2399c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 06:41:54.7223 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5vmJHucn4SIl6N5qyrT4FupnaS3msYecKK7L4q9tjUkHtgduu2uEnsIxyynn8V+WDJ17pWLIAJzNGukESR5rnG/WJknICNPh9/Clox7a5vE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB5301
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

SGksDQoNCklzIHRoZXJlIGFueSBhZGRpdGlvbmFsIGNvbW1lbnQgb24gdGhpcz8gOikNCg0KQmVz
dCByZWdhcmRzLA0KRGpvcmRqZQ0KDQoNCk9uIDMuIDEwLiAyNS4gMTI6NDUsIERqb3JkamUgVG9k
b3JvdmljIHdyb3RlOg0KPiBJbiB0aGlzIHZlcnNpb24gb2YgcGF0Y2hzZXQgSSBoYXZlIGFkZHJl
c3NlZCBjb21tZW50cw0KPiByZWdhcmRpbmcgdGhlIHRlc3QgY2FzZSBhbmQgYWRkZWQgb25lIGNv
bW1lbnQgZm9yIHRoZQ0KPiBjcHVfc2V0X2V4Y2VwdGlvbl9iYXNlIGZ1bmN0aW9uIHdlIGFkZGVk
Lg0KPg0KPiBEam9yZGplIFRvZG9yb3ZpYyAoMTMpOg0KPiAgICBody9pbnRjOiBBbGxvdyBnYXBz
IGluIGhhcnRpZHMgZm9yIGFjbGludCBhbmQgYXBsaWMNCj4gICAgdGFyZ2V0L3Jpc2N2OiBBZGQg
Y3B1X3NldF9leGNlcHRpb25fYmFzZQ0KPiAgICB0YXJnZXQvcmlzY3Y6IEFkZCBNSVBTIFA4NzAw
IENQVQ0KPiAgICB0YXJnZXQvcmlzY3Y6IEFkZCBNSVBTIFA4NzAwIENTUnMNCj4gICAgdGFyZ2V0
L3Jpc2N2OiBBZGQgbWlwcy5jY21vdiBpbnN0cnVjdGlvbg0KPiAgICB0YXJnZXQvcmlzY3Y6IEFk
ZCBtaXBzLnByZWYgaW5zdHJ1Y3Rpb24NCj4gICAgdGFyZ2V0L3Jpc2N2OiBBZGQgWG1pcHNsc3Ag
aW5zdHJ1Y3Rpb25zDQo+ICAgIGh3L21pc2M6IEFkZCBSSVNDLVYgQ01HQ1IgZGV2aWNlIGltcGxl
bWVudGF0aW9uDQo+ICAgIGh3L21pc2M6IEFkZCBSSVNDLVYgQ1BDIGRldmljZSBpbXBsZW1lbnRh
dGlvbg0KPiAgICBody9yaXNjdjogQWRkIHN1cHBvcnQgZm9yIFJJU0NWIENQUw0KPiAgICBody9y
aXNjdjogQWRkIHN1cHBvcnQgZm9yIE1JUFMgQm9zdG9uLWFpYSBib2FyZCBtb2RlDQo+ICAgIHJp
c2N2L2Jvc3Rvbi1haWE6IEFkZCBhbiBlMTAwMGUgTklDIGluIHNsb3QgMCBmdW5jIDENCj4gICAg
dGVzdC9mdW5jdGlvbmFsOiBBZGQgdGVzdCBmb3IgYm9zdG9uLWFpYSBib2FyZA0KPg0KPiAgIGNv
bmZpZ3MvZGV2aWNlcy9yaXNjdjY0LXNvZnRtbXUvZGVmYXVsdC5tYWsgICB8ICAgMSArDQo+ICAg
ZG9jcy9zeXN0ZW0vcmlzY3YvbWlwcy5yc3QgICAgICAgICAgICAgICAgICAgIHwgIDIwICsNCj4g
ICBkb2NzL3N5c3RlbS90YXJnZXQtcmlzY3YucnN0ICAgICAgICAgICAgICAgICAgfCAgIDEgKw0K
PiAgIGh3L2ludGMvcmlzY3ZfYWNsaW50LmMgICAgICAgICAgICAgICAgICAgICAgICB8ICAxOCAr
LQ0KPiAgIGh3L2ludGMvcmlzY3ZfYXBsaWMuYyAgICAgICAgICAgICAgICAgICAgICAgICB8ICAx
MyArLQ0KPiAgIGh3L21pc2MvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAxNyArDQo+ICAgaHcvbWlzYy9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgICAzICsNCj4gICBody9taXNjL3Jpc2N2X2NtZ2NyLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAyNDggKysrKysrKysrDQo+ICAgaHcvbWlzYy9yaXNjdl9jcGMuYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgMjY1ICsrKysrKysrKysNCj4gICBody9yaXNjdi9LY29uZmlnICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDYgKw0KPiAgIGh3L3Jpc2N2L2Jvc3Rvbi1haWEu
YyAgICAgICAgICAgICAgICAgICAgICAgICB8IDQ3NyArKysrKysrKysrKysrKysrKysNCj4gICBo
dy9yaXNjdi9jcHMuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxOTYgKysrKysr
Kw0KPiAgIGh3L3Jpc2N2L21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAg
MyArDQo+ICAgaW5jbHVkZS9ody9taXNjL3Jpc2N2X2NtZ2NyLmggICAgICAgICAgICAgICAgIHwg
IDUwICsrDQo+ICAgaW5jbHVkZS9ody9taXNjL3Jpc2N2X2NwYy5oICAgICAgICAgICAgICAgICAg
IHwgIDY0ICsrKw0KPiAgIGluY2x1ZGUvaHcvcmlzY3YvY3BzLmggICAgICAgICAgICAgICAgICAg
ICAgICB8ICA2NiArKysNCj4gICB0YXJnZXQvcmlzY3YvY3B1LXFvbS5oICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDEgKw0KPiAgIHRhcmdldC9yaXNjdi9jcHUuYyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICA0MyArKw0KPiAgIHRhcmdldC9yaXNjdi9jcHUuaCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgNyArDQo+ICAgdGFyZ2V0L3Jpc2N2L2NwdV9jZmcuaCAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICA1ICsNCj4gICB0YXJnZXQvcmlzY3YvY3B1X2NmZ19maWVsZHMu
aC5pbmMgICAgICAgICAgICAgfCAgIDMgKw0KPiAgIHRhcmdldC9yaXNjdi9jcHVfdmVuZG9yaWQu
aCAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICAgdGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMv
dHJhbnNfeG1pcHMuYy5pbmMgICAgIHwgMTM2ICsrKysrDQo+ICAgdGFyZ2V0L3Jpc2N2L21lc29u
LmJ1aWxkICAgICAgICAgICAgICAgICAgICAgIHwgICAyICsNCj4gICB0YXJnZXQvcmlzY3YvbWlw
c19jc3IuYyAgICAgICAgICAgICAgICAgICAgICAgfCAyMTcgKysrKysrKysNCj4gICB0YXJnZXQv
cmlzY3YvdHJhbnNsYXRlLmMgICAgICAgICAgICAgICAgICAgICAgfCAgIDMgKw0KPiAgIHRhcmdl
dC9yaXNjdi94bWlwcy5kZWNvZGUgICAgICAgICAgICAgICAgICAgICB8ICAzNSArKw0KPiAgIHRl
c3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC9tZXNvbi5idWlsZCAgICAgICAgICB8ICAgMiArDQo+ICAg
Li4uL2Z1bmN0aW9uYWwvcmlzY3Y2NC90ZXN0X3Jpc2N2NjRfYm9zdG9uLnB5IHwgMTI0ICsrKysr
DQo+ICAgMjkgZmlsZXMgY2hhbmdlZCwgMjAyMiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygt
KQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkb2NzL3N5c3RlbS9yaXNjdi9taXBzLnJzdA0KPiAg
IGNyZWF0ZSBtb2RlIDEwMDY0NCBody9taXNjL3Jpc2N2X2NtZ2NyLmMNCj4gICBjcmVhdGUgbW9k
ZSAxMDA2NDQgaHcvbWlzYy9yaXNjdl9jcGMuYw0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9y
aXNjdi9ib3N0b24tYWlhLmMNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvcmlzY3YvY3BzLmMN
Cj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9taXNjL3Jpc2N2X2NtZ2NyLmgNCj4g
ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9taXNjL3Jpc2N2X2NwYy5oDQo+ICAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvcmlzY3YvY3BzLmgNCj4gICBjcmVhdGUgbW9kZSAx
MDA2NDQgdGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMvdHJhbnNfeG1pcHMuYy5pbmMNCj4gICBjcmVh
dGUgbW9kZSAxMDA2NDQgdGFyZ2V0L3Jpc2N2L21pcHNfY3NyLmMNCj4gICBjcmVhdGUgbW9kZSAx
MDA2NDQgdGFyZ2V0L3Jpc2N2L3htaXBzLmRlY29kZQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDc1NSB0
ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9yaXNjdjY0X2Jvc3Rvbi5weQ0KPg==

