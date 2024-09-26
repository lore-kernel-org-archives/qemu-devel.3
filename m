Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FD6CCFA15
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 05:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stgm5-0008GV-9p; Thu, 26 Sep 2024 01:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1stgm3-0008EK-OT; Thu, 26 Sep 2024 01:10:43 -0400
Received: from mail-sgaapc01on2138.outbound.protection.outlook.com
 ([40.107.215.138] helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1stgm1-0004bd-P7; Thu, 26 Sep 2024 01:10:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QU1BOUBOYVnl1fS/WBbA/EJjKb3zE+gcX/Zshg92XW2iL/gvuMWHQKGDpu7HC1LY4idaVy8mTXvzalD5Ps8Po/d9lb/T8ErlGvYK/l+QVR1G1tUs5pLDrAGe2RZeR3LeGLIJqDLgUbX0UqjBym87Btl4J5k+n9XWAXvq++sJpHuVQqihTqCDfUbThVIIcuflHLriyf9iuY1Uyq68cqauRI5zfnpaLKr2jqlHOa5Im/kMv0BSIm/HJx8gv2Bgn6rDkCyvXc5dv4R8uvNUhud7xXLhv+e9rETEnuRHiW7717R5TvC41dxBfU/2xfrZypKCMmPf7iyqedldRzY2YXS3eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4v9wID5/TBuhYJ8ihQ3udRBVdXRlJyhrPwpHGKZ01w=;
 b=F3O09FGBGyInf3PVswYfMnGSQSOs0/OL8ZYJlkhZb8mvKzWs9WuJCdMF+z0cAKNmx+EB0JOlSCCBeln/IlC0XP5VEqPevAkwwKq7sK5Bf+sX4JivRPZhSoQH0+KWrHGPaxgCNKFMZ7CNAMXqmSgrdExLj2m4k6QW9uXk2G996kgdk/dNdyYQiSmmm/8t7z50hcV96R+8brNf+cI2+IAvrvIoja+S3u59Zkq/jIpetc9pTouGo7ey+JExVBnQt4pVgZJeY1xGI04gH9JGSgRLoZ+zZ+KHYfYU7VNugfawjwg4NhH6v5xLm+9VbVX4JUQ7FAs7t1lXpSNEO1FN/ZGsTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4v9wID5/TBuhYJ8ihQ3udRBVdXRlJyhrPwpHGKZ01w=;
 b=kHBNhkDiHfN/3smcgBvZYJbAxznIaIh4ZRUNmEvOkvof8b/XAL8RihUwfbzl/dHi1yrCNIFELD8uGYdW8TVD7HGzA78PvvxX5jONEmiAOcIINQNXxqDum+C7v2qAADS9RWbVk97JiT+UVHq58qHK9YeJBxAj4Y2bMffKBdkBZ0RNdfU43CX2JIeugKh3YHFu/Vpcp/jV+JaMc1owUKL6sOfKNJn4SSZvBFerWk9ZBxsBxGNHAgyFbk25utQSLeOpYAXVLwyt0Tkgd75c3ZRg86vKuafQM/ZJZtBopAFykunQeCVTmdgWInRvMNzQE9Y3N/CM1tgMSJeIqIIG9a1VgA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 JH0PR06MB6834.apcprd06.prod.outlook.com (2603:1096:990:4b::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.27; Thu, 26 Sep 2024 05:05:32 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8005.017; Thu, 26 Sep 2024
 05:05:31 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 4/6] hw/gpio/aspeed: Fix clear incorrect interrupt
 status for GPIO index mode
Thread-Topic: [PATCH v2 4/6] hw/gpio/aspeed: Fix clear incorrect interrupt
 status for GPIO index mode
Thread-Index: AQHbDvvqyQlqp4aCYkCMEvjEKNoB2LJpdPCAgAAPuZA=
Date: Thu, 26 Sep 2024 05:05:31 +0000
Message-ID: <SI2PR06MB504128F6C65C2B977DF7D99AFC6A2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240925033454.4117445-1-jamin_lin@aspeedtech.com>
 <20240925033454.4117445-5-jamin_lin@aspeedtech.com>
 <2fc6fc4954ff4a769c5ebd4562ce37280fd87c07.camel@codeconstruct.com.au>
In-Reply-To: <2fc6fc4954ff4a769c5ebd4562ce37280fd87c07.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|JH0PR06MB6834:EE_
x-ms-office365-filtering-correlation-id: 75a213d2-0abe-40ec-7894-08dcdde8d88b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N2JZcFBwMWdqalVEcU9lUW1OQTVSVk5BNzU2SFBLem5FdEJCa2NYWW1Uc21o?=
 =?utf-8?B?cmdrNC9VMFZNeDcySXRXQXBJV05mc01zL0k2MTlsL1NwMmt0SE9ySnQ1SVJy?=
 =?utf-8?B?ai9OZ01EbXdoQVlTWEJwbEorejZuVmIxMVhVM1QxVnp0a0FpTlRsVjE3Nm9i?=
 =?utf-8?B?MVdVa1RNRFNmbXBuYUpsbDZUU0pPb3huZGRTN2lyZ3lGWTFCbHZsZ0dEcnhJ?=
 =?utf-8?B?aU5mUE5KV2pqdmE4TnRPdmZCWmF2QktZNVpJWU9XamVxRnlVRGZ6c0JCWnF4?=
 =?utf-8?B?MCtOWEVZSEZOL1d5L0tjckFYWnduNk5OMEtMa2xWVmpySUF2c3V4bkdiUGVk?=
 =?utf-8?B?Qk8vdTdBVmd5TFNNOFE5N2kwekhaWEprOGcyZE5zL0ppMndhOGROcUZrdS93?=
 =?utf-8?B?M0FZakcrZFV6YlBucG9WSWRPRUtScjVVYzlEZFo1R21kck5SN1RaVytMUEJz?=
 =?utf-8?B?WkJwdks4RzBoQWJwQXk4aStYWnp4Szc5QS85MmJ5OXllZVdVQlpBOHUwcS9F?=
 =?utf-8?B?NENIRWUrdkVOWHBKNmZFR3RNM2lZMDJvY0IrWktUWWhqOHFUVTJKK3N3YzJG?=
 =?utf-8?B?ZUdoOUpiMmJFcEZ1NXRidjUraHM3Z1djWEdJM3o0YUpOUis5UTkyVVBlV3Qw?=
 =?utf-8?B?WngxQ2Zib1orcm1iN2FvMlVGTzJxSG9pajhkam1iZ25iQUJEd1ZZeW40b0Fz?=
 =?utf-8?B?ODZHQ1JzSXYrL3FNYTFYbTFaTGtDSkdRU3ZxNFpCSXFLTjZPUzh5Ujh1d1Nt?=
 =?utf-8?B?TnVnSlI3SnRIYVBXcWxEdjBjbWQ5RXpobEh5bDRhamRrYnZUYXJLUFNjYVZk?=
 =?utf-8?B?OEhqR0FDeFBSR2oxcnVKb0ZQbWlMVTlGN0Z0RlpqbGFnT2VmckJQWVJ0REVU?=
 =?utf-8?B?YSswMmhieURhQ0RqZUx5dk5kV3JycWYrSTlQWm5GSERRUlgrN2YxZ3plYjQw?=
 =?utf-8?B?Qm5OREd1SFIxVnRxNTl6aUJNUXFBeWJwaVRORGJIMHRLbnhIL1l1L25pT1lX?=
 =?utf-8?B?UHRicEozYzdHSDEzUzZwbmxTaE85ektxYThraUc4MHA5YS9TYjk4VFJHYkRV?=
 =?utf-8?B?Ny9VZy84OHBZTHQzcVBTM2Q0VlozeEsvRjdCYjhPRjdVdDI2YmdYbi9hRnRl?=
 =?utf-8?B?MUtCdDRMRGZmRHp6Mzk0TkRUVFVyOEt5U3pFTWdiYURBdkQvRkNzSEkvdkxh?=
 =?utf-8?B?ODBTa09NaTl4OHo4MVAvYlVxaUM2UnhpNll2NWU4N2UzUSsrenMzT1h5SVR1?=
 =?utf-8?B?cTN4dDczanVlRlgrMzhTamJUVzFhaGlqWTdQelIzNGg2OXN6K0g3dUlrWmVH?=
 =?utf-8?B?SFlWbmwwMVpzU2pqaUtPcSsrNHVSeDlWQWdNY0MwWENnd29kdE9SNVFFT3Z2?=
 =?utf-8?B?Z2xVWldZOERmQ0xTNHBjazk5OVJtWXdPeGhJcitSYzF2QUVabTJlRzkrb1FW?=
 =?utf-8?B?OUpDY1Z1RHhSSHFZUXNNWHIyYVhHaTJpbzRIK3lSZ3pxWWs0WXgrN042Nmha?=
 =?utf-8?B?cW9LOHl3bGl4MUtvNGFZeThoekZETmZQMHdHNXhDTkd0dkRIMFBrVXRLQUlN?=
 =?utf-8?B?SHRseXdiU0piMkExNS9KWXJBaUcrd3BoQUFLOUJPdk03dzlDKzdvektNZ21O?=
 =?utf-8?B?bDVheUpxZ3FqL1RkTmZBaEJ3WmJxbXZseDBDN3U3R1hSWHA1TmxFN3hwZktx?=
 =?utf-8?B?eSsyVjZYUWdDSEVzSVhVbzI5UzNGbG1wWkZQTmd1a3k4cWFBdjhscWs4V2Rp?=
 =?utf-8?B?SWhzTEs1R0cxWmI1d0gvU0djeHFqUTFKSzNRRDAwRVovWDIrS1IyNGNBa1ZV?=
 =?utf-8?B?ZCthWGxVTVF5d1czamFwQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTlZMnZPT1drd0VZVnQyaUxlck5RSTFUS1ZTaDlZREpEVE5USkdoY1VJWFlD?=
 =?utf-8?B?UGpRL1ljVllVME13aXlDc0lETkJTU29EcjdCRzdteUZTdTZ5Nys4a0dPSjVm?=
 =?utf-8?B?eVVjMU8vL05DWU5waWlhdFVERk5FVUJrdzZ0Yko2cEVSa1o4akIzUnA4bGNE?=
 =?utf-8?B?UjQrbUhVUTM0TEhvb2I4dldQc2tEOHhUWTVYYWVnelQrRGpDZmRUNzdwUWxj?=
 =?utf-8?B?VFhRMTUrZFU4UFRKc3dsdlE1K1VBaGlXdUk2UCt5d2pWdzJQTUJCTjdLdjln?=
 =?utf-8?B?TkY4L3FDOTlGWUtmYkYrazFjdnFzRVRTaVAzd00vMGYwQzNTaDdoYmRwVCt5?=
 =?utf-8?B?MHVLcDFtVG5xejd5eml6UmFMMGtJWEc3NTMwdHgyYTBsVU10Z2JJczArdm84?=
 =?utf-8?B?dnFtaVFjT1d6em5BTjZjMGtXWjBIZmErRGJxNGdjUXZhN1FwUUhORmx6UG91?=
 =?utf-8?B?dnlJcUNTRlhrdkhRYkg4dmNpZGRhNGhsc093ZzBHaHFvY0ZGbjhrSHZXKzFQ?=
 =?utf-8?B?NWdzdGRTRHMrODFDS0JXR3ZBdTVUL2c2TVQ3ZFBzRENpLzNQTnBzcEw2aWRo?=
 =?utf-8?B?NUUvK3pETTN3TXZKSW10djZ2K1NHTmk3a1BLdjNuczA4K1ZSeDdXUUZBMXJ3?=
 =?utf-8?B?eTVUaWJDMGo2N3B2SzhXcnNoTWU0TXp2SE5JdXRVU2UyMzcrT2JZdGRVMmNJ?=
 =?utf-8?B?Qm9DcUFBTGVhMGZEZnBhWjBzYS9Ed044Y2c4WjVSL0FLSnBHc1o3UVNjb0tW?=
 =?utf-8?B?N21Vekc2amtSRTA2c3hpRkVlM2oxNW55M3UvNVRsMGNWZWlZMmhxYUFrbmEz?=
 =?utf-8?B?bCszTXg4ZWRFNytOeXJCOW94Y2Y4dGtIb01oTDY0SVZFcGVzOGFEbksvSGtR?=
 =?utf-8?B?NVFUZGhkK2lUSkJnemtGZ2hPSmx4Y3JoZDhtVGZuRk50bXNQYkYxTEUvUHE0?=
 =?utf-8?B?elRDS29ZOGVBeU1vYk4zOGI4Wm9kQk81TDZDT2E2MGlkMWdmelYxOStuekhP?=
 =?utf-8?B?NTRhUnJ6cGxvR0w4NDlYelB0ZFhIQ0RJQTlvamw2bHJFeUlzNCt6UHEvcHN3?=
 =?utf-8?B?TTlKemRxc0xOTUl1ZUNIV3NqNlloL0pLdElHSngzMDRrN3QvbmdPM2lhM04w?=
 =?utf-8?B?bVZhK0tGbitpTzZHQlltaDRCVmZ5L3I5SFlKMFpqYjNJS0dubXlRc2piRUI5?=
 =?utf-8?B?aEliS3FFQmlqdDljcFNWUEN1SHg0c0tuSUtacEFXUThITFRLOWpCS0crbDJk?=
 =?utf-8?B?d0Nta01Bem1MR2s0ZVhTdDZGOWIzOXVhK2ZFVCtwaHdJZHB5b29CZkR0NFI3?=
 =?utf-8?B?V3Rja2dkRk9Vd3AxeVZsZWxKdXZmbnBWNm5kNjJQN1A4bWdZNFpleUd5Qkg0?=
 =?utf-8?B?UmsyTHBjZ3NCQS9YdGFPOGdMNiszZnVwT3hTV01zbHNzS2J0M0lRSmVDd0hU?=
 =?utf-8?B?S0JFSTg1dFRjWEJDTFhOY2pBVUJZU0VWR3B3bUllNzN0Z1VaTGZScGdhZG40?=
 =?utf-8?B?MmxaMmVEdkFoc1plc3RiY3ZwZkFTdTA3N2hHbkhPVEdRQVJxYjk4SDE5bmlO?=
 =?utf-8?B?NUVJbE03MWNCTEhWNmgzUHR6RWVZenFXN2tpZmhJb1ozTm1qdU45MlozL3lX?=
 =?utf-8?B?bnBFcXFWVllCSnNaR0Faa2J3UVZuVzZCdVhOT29Yd25lSmg4dXoxOU1WR0RG?=
 =?utf-8?B?TTBrWW55OTM2ZkM3VHZqUkVaU3VIT2NJaFd3QXI3a3V2R3BDN041cVFkRTI5?=
 =?utf-8?B?T2Zua05uY0FoMjV3ZkcwK2VYbld1OWJzMEtUeHRGTkRBUVFWb3locHkrUEox?=
 =?utf-8?B?dGJmOXU2NE9GczZsc0ZVYlVWREFBNzE1czAxa05OWHVsNWpuTC9qclEybXBv?=
 =?utf-8?B?dlZoWVpkamI2NUZKZlBKUTJmOWdTSnkvT1FGb0c5MnY5RmxNZjhoQUkvSHpo?=
 =?utf-8?B?dHdRREhBdDZtRS9sNXRGcXpKcEFwQkZVZDNzbUZlaVNCSFZKQmlQaVB4UEZt?=
 =?utf-8?B?eUY0Wk5qVEpkRktVNWoyblJqL093NmJFWnEyWG9ub1NrcjlGVzh3WVJRbEo0?=
 =?utf-8?B?NWpORU1CMHMvN05LNnpVMlNaWEdZbjVOenQrRHlTczN6NWt3WFhtZ3lQOHo5?=
 =?utf-8?Q?Nay33nvBp3iTqPOR6Vvq5/vN/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a213d2-0abe-40ec-7894-08dcdde8d88b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 05:05:31.4323 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eDMCeEyQF0QIchNgD063cseh5s/P0mQv7XgHv8HZK9uxttYIYtGNW4orSmi/+5hD5w1ZDWrADI7dAnI2qO91M2vk3DmjnrKh5gc7p3gIyzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6834
Received-SPF: pass client-ip=40.107.215.138;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.828, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

SGkgQW5kcmVzLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgNC82XSBody9ncGlvL2FzcGVl
ZDogRml4IGNsZWFyIGluY29ycmVjdCBpbnRlcnJ1cHQgc3RhdHVzDQo+IGZvciBHUElPIGluZGV4
IG1vZGUNCj4gDQo+IEhpIEphbWluLA0KPiANCj4gT24gV2VkLCAyMDI0LTA5LTI1IGF0IDExOjM0
ICswODAwLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gVGhlIGludGVycnVwdCBzdGF0dXMgZmllbGQg
aXMgVzFDLCB3aGVyZSBhIHNldCBiaXQgb24gcmVhZCBpbmRpY2F0ZXMNCj4gPiBhbiBpbnRlcnJ1
cHQgaXMgcGVuZGluZy4gSWYgdGhlIGJpdCBleHRyYWN0ZWQgZnJvbSBkYXRhIGlzIHNldCBpdA0K
PiA+IHNob3VsZCBjbGVhciB0aGUgY29ycmVzcG9uZGluZyBiaXQgaW4gZ3JvdXBfdmFsdWUuIEhv
d2V2ZXIsIGlmIHRoZQ0KPiA+IGV4dHJhY3RlZCBiaXQgaXMgY2xlYXIgdGhlbiB0aGUgdmFsdWUg
b2YgdGhlIGNvcnJlc3BvbmRpbmcgYml0IGluDQo+ID4gZ3JvdXBfdmFsdWUgc2hvdWxkIGJlIHVu
Y2hhbmdlZC4NCj4gPg0KPiA+IFNIQVJFRF9GSUVMRF9FWDMyKCkgZXh0cmFjdHMgdGhlIGludGVy
cnVwdCBzdGF0dXMgYml0IGZyb20gdGhlIHdyaXRlDQo+ID4gKGRhdGEpLiBncm91cF92YWx1ZSBp
cyBzZXQgdG8gdGhlIHNldCdzIGludGVycnVwdCBzdGF0dXMsIHdoaWNoIG1lYW5zDQo+ID4gdGhh
dCBmb3IgYW55IHBpbiB3aXRoIGFuIGludGVycnVwdCBwZW5kaW5nLCB0aGUgY29ycmVzcG9uZGlu
ZyBiaXQgaXMNCj4gPiBzZXQuIFRoZSBkZXBvc2l0MzIoKSBjYWxsIHVwZGF0ZXMgdGhlIGJpdCBh
dCBwaW5faWR4IGluIHRoZSBncm91cCwNCj4gPiB1c2luZyB0aGUgdmFsdWUgZXh0cmFjdGVkIGZy
b20gdGhlIHdyaXRlIChkYXRhKS4NCj4gPg0KPiA+IFRoZSByZXN1bHQgaXMgdGhhdCBpZiBtdWx0
aXBsZSBpbnRlcnJ1cHQgc3RhdHVzIGJpdHMgd2VyZSBwZW5kaW5nIGFuZA0KPiA+IHRoZSB3cml0
ZSB3YXMgYWNrbm93bGVkZ2luZyBzcGVjaWZpYyBvbmUgYml0LCB0aGVuIHRoZSBhbGwgaW50ZXJy
dXB0DQo+ID4gc3RhdHVzIGJpdHMgd2lsbCBiZSBjbGVhcmVkLg0KPiA+IEhvd2V2ZXIsIGl0IGlz
IGluZGV4IG1vZGUgYW5kIHNob3VsZCBvbmx5IGNsZWFyIHRoZSBjb3JyZXNwb25kaW5nIGJpdC4N
Cj4gPg0KPiA+IEZvciBleGFtcGxlLCBzYXkgd2UgaGF2ZSBhbiBpbnRlcnJ1cHQgcGVuZGluZyBm
b3IgR1BJT0EwLCB3aGVyZSB0aGUNCj4gPiBmb2xsb3dpbmcgc3RhdGVtZW50cyBhcmUgdHJ1ZToN
Cj4gPg0KPiA+ICAgIHNldC0+aW50X3N0YXR1cyA9PSAwYjAxDQo+ID4gICAgcy0+cGVuZGluZyA9
PSAxDQo+ID4NCj4gPiBCZWZvcmUgaXQgaXMgYWNrbm93bGVkZ2VkLCBhbiBpbnRlcnJ1cHQgYmVj
b21lcyBwZW5kaW5nIGZvciBHUElPQTE6DQo+ID4NCj4gPiAgICBzZXQtPmludF9zdGF0dXMgPT0g
MGIxMQ0KPiA+ICAgIHMtPnBlbmRpbmcgPT0gMg0KPiA+DQo+ID4gQSB3cml0ZSBpcyBpc3N1ZWQg
dG8gYWNrbm93bGVkZ2UgdGhlIGludGVycnVwdCBmb3IgR1BJT0EwLiBUaGlzIGNhdXNlcw0KPiA+
IHRoZSBmb2xsb3dpbmcgc2VxdWVuY2U6DQo+ID4NCj4gPiAgICByZWdfdmFsdWUgPT0gMGIxMQ0K
PiA+ICAgIHBlbmRpbmcgPT0gMg0KPiA+ICAgIHMtPnBlbmRpbmcgPSAwDQo+IA0KPiBOb3RlIHRo
YXQgSSBoYWQgYSB0eXBvIGluIG15IHJlcGx5IHRoYXQgcHJvbXB0ZWQgdGhpcyBwYXRjaCwgdGhp
cyB3YXMgbWVhbnQgdG8NCj4gYmU6DQo+IA0KPiAgICAgcy0+cGVuZGluZyA9PSAwDQo+IA0KDQpX
aWxsIHVwZGF0ZQ0KPiA+ICAgIHNldC0+aW50X3N0YXR1cyA9PSAwYjAwDQo+ID4NCj4gPiBJdCBz
aG91bGQgb25seSBjbGVhciBiaXQgMCBpbiBpbmRleCBtb2RlIGFuZCB0aGUgY29ycmVjdCByZXN1
bHQgc2hvdWxkDQo+ID4gYmUgYXMgZm9sbG93aW5nLg0KPiA+DQo+ID4gICAgc2V0LT5pbnRfc3Rh
dHVzID09IDBiMTENCj4gPiAgICBzLT5wZW5kaW5nID09IDINCj4gPg0KPiA+ICAgIHBlbmRpbmcg
PT0gMQ0KPiA+ICAgIHMtPnBlbmRpbmcgPSAxDQo+IA0KPiBTYW1lIHR5cG8gaGVyZSBub3cgOikN
Cj4gDQoNCldpbGwgdXBkYXRlDQo+ICAgICBzLT5wZW5kaW5nID09IDENCj4gDQo+ID4gICAgc2V0
LT5pbnRfc3RhdHVzID09IDBiMTANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8
amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICBody9ncGlvL2FzcGVlZF9n
cGlvLmMgfCAxOSArKysrKysrKysrLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBp
bnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2dw
aW8vYXNwZWVkX2dwaW8uYyBiL2h3L2dwaW8vYXNwZWVkX2dwaW8uYyBpbmRleA0KPiA+IDZlNmFi
NDhiNTYuLjU4YWU2M2UzYzEgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvZ3Bpby9hc3BlZWRfZ3Bpby5j
DQo+ID4gKysrIGIvaHcvZ3Bpby9hc3BlZWRfZ3Bpby5jDQo+ID4gQEAgLTY0Miw3ICs2NDIsNyBA
QCBzdGF0aWMgdm9pZCBhc3BlZWRfZ3Bpb193cml0ZV9pbmRleF9tb2RlKHZvaWQNCj4gKm9wYXF1
ZSwgaHdhZGRyIG9mZnNldCwNCj4gPiAgICAgIHVpbnQzMl90IHBpbl9pZHggPSByZWdfaWR4X251
bWJlciAlIEFTUEVFRF9HUElPU19QRVJfU0VUOw0KPiA+ICAgICAgdWludDMyX3QgZ3JvdXBfaWR4
ID0gcGluX2lkeCAvIEdQSU9TX1BFUl9HUk9VUDsNCj4gPiAgICAgIHVpbnQzMl90IHJlZ192YWx1
ZSA9IDA7DQo+ID4gLSAgICB1aW50MzJfdCBjbGVhcmVkOw0KPiA+ICsgICAgdWludDMyX3QgcGVu
ZGluZyA9IDA7DQo+ID4NCj4gPiAgICAgIHNldCA9ICZzLT5zZXRzW3NldF9pZHhdOw0KPiA+ICAg
ICAgcHJvcHMgPSAmYWdjLT5wcm9wc1tzZXRfaWR4XTsNCj4gPiBAQCAtNzA1LDE1ICs3MDUsMTYg
QEAgc3RhdGljIHZvaWQgYXNwZWVkX2dwaW9fd3JpdGVfaW5kZXhfbW9kZSh2b2lkDQo+ICpvcGFx
dWUsIGh3YWRkciBvZmZzZXQsDQo+ID4gICAgICAgICAgc2V0LT5pbnRfc2Vuc18yID0gdXBkYXRl
X3ZhbHVlX2NvbnRyb2xfc291cmNlKHNldCwNCj4gc2V0LT5pbnRfc2Vuc18yLA0KPiA+DQo+IHJl
Z192YWx1ZSk7DQo+ID4gICAgICAgICAgLyogc2V0IGludGVycnVwdCBzdGF0dXMgKi8NCj4gPiAt
ICAgICAgICByZWdfdmFsdWUgPSBzZXQtPmludF9zdGF0dXM7DQo+ID4gLSAgICAgICAgcmVnX3Zh
bHVlID0gZGVwb3NpdDMyKHJlZ192YWx1ZSwgcGluX2lkeCwgMSwNCj4gPiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgRklFTERfRVgzMihkYXRhLCBHUElPX0lOREVYX1JFRywNCj4gSU5U
X1NUQVRVUykpOw0KPiA+IC0gICAgICAgIGNsZWFyZWQgPSBjdHBvcDMyKHJlZ192YWx1ZSAmIHNl
dC0+aW50X3N0YXR1cyk7DQo+ID4gLSAgICAgICAgaWYgKHMtPnBlbmRpbmcgJiYgY2xlYXJlZCkg
ew0KPiA+IC0gICAgICAgICAgICBhc3NlcnQocy0+cGVuZGluZyA+PSBjbGVhcmVkKTsNCj4gPiAt
ICAgICAgICAgICAgcy0+cGVuZGluZyAtPSBjbGVhcmVkOw0KPiA+ICsgICAgICAgIGlmIChGSUVM
RF9FWDMyKGRhdGEsIEdQSU9fSU5ERVhfUkVHLCBJTlRfU1RBVFVTKSkgew0KPiA+ICsgICAgICAg
ICAgICBwZW5kaW5nID0gZXh0cmFjdDMyKHNldC0+aW50X3N0YXR1cywgcGluX2lkeCwgMSk7DQo+
ID4gKyAgICAgICAgICAgIGlmIChwZW5kaW5nKSB7DQo+ID4gKyAgICAgICAgICAgICAgICBpZiAo
cy0+cGVuZGluZykgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgIGFzc2VydChzLT5wZW5kaW5n
ID49IHBlbmRpbmcpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgIHMtPnBlbmRpbmcgLT0gcGVu
ZGluZzsNCj4gPiArICAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAgICAgIHNldC0+
aW50X3N0YXR1cyA9IGRlcG9zaXQzMihzZXQtPmludF9zdGF0dXMsIHBpbl9pZHgsIDEsDQo+IDAp
Ow0KPiA+ICsgICAgICAgICAgICB9DQo+IA0KPiBTbyBJIHRoaW5rIHdlIGNhbiBnZXQgYXdheSB3
aXRob3V0IHRoZSBuZXN0ZWQgY29uZGl0aW9uYWxzPw0KPiANCj4gICAgaWYgKEZJRUxEX0VYMzIo
ZGF0YSwgR1BJT19JTkRFWF9SRUcsIElOVF9TVEFUVVMpKSB7DQo+ICAgICAgICAvKiBwZW5kaW5n
IGlzIGVpdGhlciAxIG9yIDAgZm9yIGEgMS1iaXQgZmllbGQgKi8NCj4gICAgICAgIHBlbmRpbmcg
PSBleHRyYWN0MzIoc2V0LT5pbnRfc3RhdHVzLCBwaW5faWR4LCAxKTsNCj4gDQo+ICAgICAgICAv
Kg0KPiAgICAgICAgICogVGhlIGFzc2VydCBpcyBlZmZlY3RpdmVseSBhIGNvbXByZXNzZWQgZm9y
bSBvZg0KPiAgICAgICAgICoNCj4gICAgICAgICAqICAgICBhc3NlcnQoKHMtPnBlbmRpbmcgPT0g
MCAmJiBwZW5kaW5nID09IDApIHx8DQo+ICAgICAgICAgKiAgICAgICAgICAgIChzLT5wZW5kaW5n
ID49IDEpKTsNCj4gICAgICAgICAqDQo+ICAgICAgICAgKiBUaGlzIHNlZW1zIHJlYXNvbmFibGUu
DQo+ICAgICAgICAgKg0KPiAgICAgICAgICogQW5vdGhlciB3YXkgdG8gd3JpdGUgaXQgaXM6DQo+
ICAgICAgICAgKg0KPiAgICAgICAgICogICAgIGFzc2VydCghcGVuZGluZyB8fCBzLT5wZW5kaW5n
KSk7DQo+ICAgICAgICAgKi8NCj4gICAgICAgIGFzc2VydChzLT5wZW5kaW5nID49IHBlbmRpbmcp
Ow0KPiANCj4gICAgICAgIC8qIE5vIGNoYW5nZSB0byBzLT5wZW5kaW5nIGlmIHBlbmRpbmcgaXMg
MCAqLw0KPiAgICAgICAgcy0+cGVuZGluZyAtPSBwZW5kaW5nOw0KPiANCj4gICAgICAgIC8qDQo+
ICAgICAgICAgKiBUaGUgd3JpdGUgYWNrbm93bGVkZ2VkIHRoZSBpbnRlcnJ1cHQgcmVnYXJkbGVz
cyBvZiB3aGV0aGVyIGl0DQo+ICAgICAgICAgKiB3YXMgcGVuZGluZyBvciBub3QuIFRoZSBwb3N0
LWNvbmRpdGlvbiBpcyB0aGF0IGl0IG11c3RuJ3QgYmUNCj4gICAgICAgICAqIHBlbmRpbmcuIFVu
Y29uZGl0aW9uYWxseSBjbGVhciB0aGUgc3RhdHVzIGJpdC4NCj4gICAgICAgICAqLw0KPiAgICAg
ICAgcy0+aW50X3N0YXR1cyA9IGRlcG9zaXQzMihzZXQtPmludF9zdGF0dXMsIHBpbl9pZHgsIDEs
IDApOw0KPiAgICB9DQo+IA0KPiBUaG91Z2h0cz8NCj4gDQpHb3QgaXQuIA0KSSBhbSBoYXBweSB0
byB1cGRhdGUgdGhlbSBpbiBWMy4NClRoYW5rcyBmb3Igc3VnZ2VzdGlvbiBhbmQgcmV2aWV3Lg0K
DQpKYW1pbg0KDQo+IFVwIHRvIHlvdSB3aGV0aGVyIHlvdSBrZWVwIHRoZSBjb21tZW50cyBpZiB0
aGUgaWRlYSBtYWtlcyBzZW5zZSBhbmQgeW91DQo+IGNob29zZSB0byBhZG9wdCBpdC4NCj4gDQo+
IEFuZHJldw0K

