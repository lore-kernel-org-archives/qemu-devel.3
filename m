Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8B0C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 04:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7nmB-0000eo-7e; Thu, 24 Apr 2025 00:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u7nm9-0000eJ-Gx; Thu, 24 Apr 2025 00:01:25 -0400
Received: from mail-eastasiaazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c400::3] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u7nm7-0006vo-HZ; Thu, 24 Apr 2025 00:01:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMlUYk45sG5uKFLD16wGr8DF9s6U+okLspRTenlxmdl9i8rOZQq+Ccn3QXekjZlSeFShq/L8KVILENZCj/2dodQTkzxGSH+0FQsbxt4WRvLAAC8BqTwEbdKF63tr1xPE/wdHtLACgajs4A+0CWdwgOIIpkMue3m6ZJpN8H8TVNpTQiEWo9m0X0Yhr/NYicwe5sA4hU3LJOewW3Rgc7vQIXEp+Rgy1WINTME4+k6ByL8lypDnGrs4bFwj8XvRFyb0y9KFaGzjGD+q3/xvXD0C4Vjwf1+dtATkV8u6l4WH8uRxNcwZIzKMmEtb/ZAB8LiMHKAfio3r3djI9yAeTWPm0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DhM89U3kN8qzo5OLarnKjLkagVTCJPTgWkG1vo2nBE=;
 b=ZDhdvEzw0nE1eqiPrtXNoLlLLM7V9bGfm4mrOpPjJlFDol/Rzck5hEEYcNJfBxll0KoRVzUSTCgDRb4utasRfz69C8DVa3Ib5MNSHpIdXmBhuuJZRvTVWsVEP9+Nl7zKA/Sa/2OAy+NEoYNg0BpONQSBNAqJxwkq5xfTGmiJrCoExWEfxcCLuDnEauqzB2joczBMEIbKS79kiK8ELEoylfEyr12pUtjszwBTXgwXkhsT6GjWWS6VXfjGO3SB9CZXYG4IUXjBh1Jn8qQcHTFWsrFw9XmecPlF4sGfNoWayqey4bhvPvaWh7kYNtaUjgjx8INzDmwPx3cJbEzbIwMnTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DhM89U3kN8qzo5OLarnKjLkagVTCJPTgWkG1vo2nBE=;
 b=XkZHffGbljArikDWII3qfjT7e83g26k1TXLqd8mplIj+/v65cKxd5r43s9q9GbyLKT8sL/5sC+qFL6tu5UathxNGc6+AfezjX5H/Q/faAQ3jOFyORZC3b1EkVIuYjPcoJ2aDO2HbuLTjkvyjMDLrBbzhUy4mopQf+DRRLgDUkg33Alh7xBjcifkOMdsa+mT982VBZoiLIYE3bmRnqRP1KJjb6d/Y+BHrhVGrHlM9RhEw6YTowEvC6MaT6VamRvtkugBHMafwerWHaJtix8A2JrTr5F8qyQ4dKNJlgX9Kv678+nXfb4xLV1OTApk/+ZmuF519k23NX/XJ9X0LWVeERw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TY0PR06MB5443.apcprd06.prod.outlook.com (2603:1096:400:32c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 04:01:15 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 04:01:15 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v5 06/11] hw/arm/aspeed: Add support for loading vbootrom
 image via "-bios"
Thread-Topic: [PATCH v5 06/11] hw/arm/aspeed: Add support for loading vbootrom
 image via "-bios"
Thread-Index: AQHbtCCxh9qo/IFpL0G9004JIiaFOrOw+naAgAE4H4A=
Date: Thu, 24 Apr 2025 04:01:15 +0000
Message-ID: <SI2PR06MB50410B86FC1B8D69DD56ECA6FC852@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250423072350.541742-1-jamin_lin@aspeedtech.com>
 <20250423072350.541742-7-jamin_lin@aspeedtech.com>
 <5503c8b7-1b42-4a36-a768-33bdd61b8bfc@kaod.org>
In-Reply-To: <5503c8b7-1b42-4a36-a768-33bdd61b8bfc@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TY0PR06MB5443:EE_
x-ms-office365-filtering-correlation-id: db36ac95-fe67-4702-c2b8-08dd82e4a8e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NE5oUkpUWEZjc1BkNGR2cGY3bUdPUTRMSndhSTFNTTV2aSswakpKNkhqQzYv?=
 =?utf-8?B?bDByUlFqb0lidmcxRDlPdnVuSWV5Mlk4MHRUZEFocy9tcUVNdWRzdktqVWZQ?=
 =?utf-8?B?NUhBMFduM3dOc0I2NmVob1ZnRTEyUEZ3TUc1NDB4YnJPdERsTTJZZ09XWGpY?=
 =?utf-8?B?VW96dTk4SmdheDdZS2ZKK0E0TTBJYTFNUWwyRHdObCt4T2ZwSWc0TlE5ZW5U?=
 =?utf-8?B?ZWY0aVl3R1lEa3VZY0U5RlpOODJHTjU4R3R4cFovZk1GeGhtWXBXRUhNVGtC?=
 =?utf-8?B?WWM0YXIycWRVZHBtbW5yd3hJOE43dUpNaG4rK3VkQWNJaENZS29HQlpOZ01F?=
 =?utf-8?B?VXZJTHRCbmQzZjcyRjR0V0tkLzEzb1JxQWx2L0xXNmxJUk5MRk1GWUJ5RlBS?=
 =?utf-8?B?djVXdTJvdnl5b2VKUmxOMXl5WkM2eGthcFBmQW5jcDhxRFppNklYT2w5R1Y5?=
 =?utf-8?B?VFNDaldqN1prR2J6OXRwblN5cG9PVEpzdmphWDg3YlMxdnRNVXR5WEI3Z0Q1?=
 =?utf-8?B?dGJCbmFRaU0xVkxyYVBYU3E1c21ER2VCdHNDdTdoQ0ZWYloxNGN1K01HS05w?=
 =?utf-8?B?MDFqTHBRZnl1eHY5aGxyWjgzWDNCV256L2Y2TVBHNDFJV29lbTEzRmsrcDFw?=
 =?utf-8?B?QjNoT3ZrSGpweDJWb2pXcHd6M2I2d0t6Zy9yTTNIdUhBc05DWGFtVEhHcW5a?=
 =?utf-8?B?Q0xpT25xcDBNa1hNcGdGb052aWVzUnUwVFVNSUxIL3ZReFdoZEdlaW5iNFlE?=
 =?utf-8?B?RW82NUx4VXdGTDg3eGJ2RXlkRGZJZXBjQXRoMHF3K0xld0pkRjArMGRXQTA2?=
 =?utf-8?B?TXM5RUFSdFZiKzIrelpVVUFZZDV0RHRCYmRhTzgraTY1dkNRb2QwdGhTLzRy?=
 =?utf-8?B?MkdtUkpudWRtR1Vwa0NVNWVVZVFsc3BHeDhjeGdTWCtMaDRua3JTNTNRczhZ?=
 =?utf-8?B?anI5aDhIeUl6OVEzUGVDY2VVS3RFVGEveklLazk3N2V1SnpnS1RsTXZBZXIr?=
 =?utf-8?B?S2JaV3VFbjhvSGlGRitmTE44WTR2VFh2T0ZBZS9sY3dGSzc4bFhGTGIzMHpk?=
 =?utf-8?B?U01mQW1hRzBrMWhHT3pMVXEzbkU1QTdJWFplclNkcTBvRzlqdHdEOU5IQmRI?=
 =?utf-8?B?ZFFkR3hEK2pUZDlBb2NxTU16RWFtbTFoaDFvRTdXUmxzMHZMcmVnN0NxcWdQ?=
 =?utf-8?B?eXhGS21QaTVza05NL2xIU3ozeHd6aVloaElIQ2U3UWYxRGZQbzlvM0xuZUxj?=
 =?utf-8?B?THpUYkJuNjlpbm94OXdxMUpCYnRKZjRCVHArd0JNM2RVZ1NFb3FwM1VMdDBB?=
 =?utf-8?B?WU1tYkpwUzlLenBsMWI4a3hzdGpVblpLMHV6c3NobVdLSFAxdGE2S3VwWmcz?=
 =?utf-8?B?M0I5M1RPa01YS0cvK1M2TS9RT3pGYytRNzMyWnNEb3JJK3N1VGpjazdHRFYr?=
 =?utf-8?B?bnFNREN1a1lyeGF2RkhTemVFS0hPUUc0Y3B6U2RISmduZGtlbE5sZkViYS9p?=
 =?utf-8?B?akRYaFJjWExXbzYyRHBLZjA0aEVvV2gzRVh1ZmtOWlBqYVlRRHBoVmQyN2JK?=
 =?utf-8?B?THhXbXBoUElmY1pxWmJKK0IrdFdQeDBrWTBpSWpaRWx3VnpwZ0crWDg5cHNR?=
 =?utf-8?B?YXBDWCtOQlQ2Tjl1YzQxM2ljWngxdGUwT2ZiOUlRR1hkenM3ajVYOHNmYm50?=
 =?utf-8?B?SUFzTXFwVDYxUG1EczJjV08rOGYxckIrd2ZwRG5XRzNvZWwycXBZditpNEt5?=
 =?utf-8?B?WnN3V3lWVGJEUFRNSitNK0J0bkFXSW5KRTZjdnN4dFlZbVU5NDR4RFlMeC90?=
 =?utf-8?B?aVpQcytRTHZJdFZXWVFMM25SSFowanR5eW9yeWpDNnBkT3ZPTXhiZTJQbld3?=
 =?utf-8?B?M0JLTnUrcjFhYXY1WFVkTmpqcXU5c0pWSnN1R3pyS0p4aGs5T1RNUUJpc2l4?=
 =?utf-8?B?NmRMY1JGOFV3elRicithQ1JFWWNwMnpKbFZUMVpJTTlJRlY0aXhUb3Q3eEtK?=
 =?utf-8?B?MEtDeVAzUGpRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmRyOE1rK3czYjQ2UmhCVzdEV29wck8vUXdMRkN3ZnR0b3V3Tm9SMVpjRCtQ?=
 =?utf-8?B?T0FyVWdQMHR0OTFGR3hvVVZxaCtWVjVNOG5wU3N2MjFQRzZCYWJXc0pQUEVM?=
 =?utf-8?B?N2o5ejFwOHh6Sk9jeVJ6djNDSHpGMnUyUjdCQlZSbmhOdlZLczM3ZGZ3RnJV?=
 =?utf-8?B?RUxVVjJsaVA5UFpZeFAxSXBkVlJZbngydE9BYTNVaU0wTmFOT3dIV1JQa3hD?=
 =?utf-8?B?TWIzUE1GV2pLK0piWUhhcE9BUXl0UE8raDlUaWNiWTFudklPTm5vY25OOGt4?=
 =?utf-8?B?Z2VtN3lrQ0pMd0puVnlxVmhYRTlBM1RJTDlDRUZCRFRVajdpKzA5YWdpQ244?=
 =?utf-8?B?Q2FGd3dvbnF0Q3B1L3lzTmVLczM2bHRuVE8yRzdEdlN0TCt5N0xENmZraVRp?=
 =?utf-8?B?TklMUFBneFdCTmFvOFpIeDNOL0NiMFJtNGZmMyt5bW0yRExNeGFqZ1NaY1Jn?=
 =?utf-8?B?RnFpbHB6VjhtZUs3bVNJTnBXa3pVeERBZ2ZzY1pZMUV4SWsxVnI0R2c3cjVh?=
 =?utf-8?B?Y09jMVNXNUI0a2FtZ2NBaHhnTndtRVJVSUhvRXB4QUhySEJKdmlCL2lYdERw?=
 =?utf-8?B?cTJ1N0ZqdVpvK1hIb3hCampnTk01b3Y4UGFLN3FXbTBGelNITWdzZGNIeXhi?=
 =?utf-8?B?K3dzQ1o3RjQ1STFjS1crWUYvZW1qUlphU0poNEF4NE1nUmZ4TjNjUDBzbXhZ?=
 =?utf-8?B?YmpoL0VTY0I0cE5qRHRvTkRqd0NXeGx6c1FSZDc3M3FKbHZwekRhZ1VpT1hM?=
 =?utf-8?B?NjZNWDlyMU9wc0tNSXVLOHI1bThML2MyNnBGWU9ZY1ZoelJ2d1JvdGx3T2RY?=
 =?utf-8?B?TTFVaUpPbSswKzcySUVSRVpVd0RBekRvQ2xreER4eUR4b3dsVy9KYWR0L21X?=
 =?utf-8?B?am9oSFVJb3k4R2FpWXFEMVhmbzdzSUNnZ1pGUlZnR0NXVDJlWVVvNUkvSy9C?=
 =?utf-8?B?N3ZYSS84UEZmZitFcDQwUFczQmRRcDR1c0M1ZmRyQ05jSGYvYmRLU3N6L2Q4?=
 =?utf-8?B?bE5Rd2lRWFNRZG5iT3lhcUd6MVhZSk9tcEIxRlBLZUc5c0Y4RUFoUE92MVdD?=
 =?utf-8?B?clNWUlZEOWI4L2hOYnJKY3QvNzU4cEppdDZVeDZZd01nMmtJZUhpclh4cmxT?=
 =?utf-8?B?UldDSXd0ZjBrMGdPb2U4elZFWStNMFBhdU5LL01LTUdUSnIyYURUMkhDcG9t?=
 =?utf-8?B?NUxlLy8rd2JvNlpYV1kwcE5VcXMvRlEycElRUWxPZVAzMXEyZCtDN2ttMUFT?=
 =?utf-8?B?N0xSR3B3bUN0Tzd2WXUwVlJPUi9uVEJVNTlSWXFYY05mNmNZN3pleW00NitS?=
 =?utf-8?B?ZjZZZHVHMzRtWTk5cXlWa2h0OEk0c2ZERVcwNVJOR3ZyNWp1L0xRK2pHWkVl?=
 =?utf-8?B?eFRuVFBmNGJsNU8zRWlWbHgzSjI1c01FWS9JVm93WWdsZ2diNHR6ZEZjdjNn?=
 =?utf-8?B?UFZvREMyQ21QM2dGOXVTS1lZby9NcUNBalk3SW9va29xQUJ5MGVOcGNGM25E?=
 =?utf-8?B?RStCWi9LbnBkQUpiVHpvTUcwd01tSDIxczcwVFpjMlBTaDhlTWFRZmFORFhF?=
 =?utf-8?B?Y2grVjlrRmxCZWFSTnBaMFNQQ3hsK0NIZzFQMDNsRklwQ1VHU1NlT051dkN1?=
 =?utf-8?B?a25oZ2hLSDFta2dVOUY5Q3oybEtTM0xuZzRMbHZyOXZoWTQxZUZNTklIT1Jt?=
 =?utf-8?B?ZmVWdnlvWFY1TWxZWWJNaXhpQVFmYWh6MWUwY2tHeUNIOGVYUzM3bi8zZ2x1?=
 =?utf-8?B?ajEzZU1mSXRmeFY1UWRVZFRrejFEeWFNenJXcnNwNjIrNmJzem50MHJzRE5a?=
 =?utf-8?B?UjA4cmRCWW9tM3lXOFdlb3dMN3RUdkFvdll2dXQvOHlIMzRqbUNoSDUwam45?=
 =?utf-8?B?Q0xlbTZ5QjBoRnQvZ291dVRiTERaaUIvZFZHMUF6TStWdTVVSkdRRFNWTHJq?=
 =?utf-8?B?VFZWV3BieUhHMzFxYTcvc3pQdWRKOWpHaUdnMzl3cTFtRXlMWElveis0OWhG?=
 =?utf-8?B?MUp3ZkFqOUY1L1R5dWRCb1FZV2xQcWZVTXI0dENDK2pEWHNNbUFVOGIwTVl1?=
 =?utf-8?B?c2I4bGJRcGFyK3habE4rNTdnZWxYbzZyNDdMQUsvOVY4SXVvQzQ4Ymg3TXNr?=
 =?utf-8?Q?XjrqzqlMV75mhyvNxGC2lnC2d?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db36ac95-fe67-4702-c2b8-08dd82e4a8e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 04:01:15.3719 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TwL8lG4QdrNTr/EAltBizxrcN29Yz8KchV+oyt88PLDOoCvaJkwavzmgIpEj07QGYn42lapJYwqbjM0/m2CGB9o806xwIs6GRUlqn5ZIm6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5443
Received-SPF: pass client-ip=2a01:111:f403:c400::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK3PR03CU002.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMDYvMTFdIGh3L2FybS9hc3Bl
ZWQ6IEFkZCBzdXBwb3J0IGZvciBsb2FkaW5nDQo+IHZib290cm9tIGltYWdlIHZpYSAiLWJpb3Mi
DQo+IA0KPiBPbiA0LzIzLzI1IDA5OjIzLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gSW50cm9kdWNl
ICJhc3BlZWRfbG9hZF92Ym9vdHJvbSgpIiB0byBzdXBwb3J0IGxvYWRpbmcgYSB2aXJ0dWFsIGJv
b3QNCj4gPiBST00gaW1hZ2UgaW50byB0aGUgdmJvb3Ryb20gbWVtb3J5IHJlZ2lvbiwgdXNpbmcg
dGhlICItYmlvcyINCj4gY29tbWFuZC1saW5lIG9wdGlvbi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IFJldmlld2VkLWJ5
OiBOYWJpaCBFc3RlZmFuIDxuYWJpaGVzdGVmYW5AZ29vZ2xlLmNvbT4NCj4gPiBUZXN0ZWQtYnk6
IE5hYmloIEVzdGVmYW4gPG5hYmloZXN0ZWZhbkBnb29nbGUuY29tPg0KPiA+IC0tLQ0KPiA+ICAg
aHcvYXJtL2FzcGVlZC5jIHwgMzUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvaHcvYXJtL2FzcGVlZC5jIGIvaHcvYXJtL2FzcGVlZC5jIGluZGV4DQo+ID4gYjcwYTEy
MGU2Mi4uYjU4MzFlZjRjMSAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vYXNwZWVkLmMNCj4gPiAr
KysgYi9ody9hcm0vYXNwZWVkLmMNCj4gPiBAQCAtMjcsNiArMjcsNyBAQA0KPiA+ICAgI2luY2x1
ZGUgInN5c3RlbS9yZXNldC5oIg0KPiA+ICAgI2luY2x1ZGUgImh3L2xvYWRlci5oIg0KPiA+ICAg
I2luY2x1ZGUgInFlbXUvZXJyb3ItcmVwb3J0LmgiDQo+ID4gKyNpbmNsdWRlICJxZW11L2RhdGFk
aXIuaCINCj4gPiAgICNpbmNsdWRlICJxZW11L3VuaXRzLmgiDQo+ID4gICAjaW5jbHVkZSAiaHcv
cWRldi1jbG9jay5oIg0KPiA+ICAgI2luY2x1ZGUgInN5c3RlbS9zeXN0ZW0uaCINCj4gPiBAQCAt
MzA1LDYgKzMwNiwzNSBAQCBzdGF0aWMgdm9pZA0KPiBhc3BlZWRfaW5zdGFsbF9ib290X3JvbShB
c3BlZWRNYWNoaW5lU3RhdGUgKmJtYywgQmxvY2tCYWNrZW5kICpibGssDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgcm9tX3NpemUsICZlcnJvcl9hYm9ydCk7DQo+ID4gICB9DQo+ID4NCj4gPiAr
I2RlZmluZSBWQk9PVFJPTV9GSUxFX05BTUUgICJhc3QyN3gwX2Jvb3Ryb20uYmluIg0KPiA+ICsN
Cj4gPiArLyoNCj4gPiArICogVGhpcyBmdW5jdGlvbiBsb2NhdGVzIHRoZSB2Ym9vdHJvbSBpbWFn
ZSBmaWxlIHNwZWNpZmllZCB2aWEgdGhlDQo+ID4gK2NvbW1hbmQgbGluZQ0KPiA+ICsgKiB1c2lu
ZyB0aGUgLWJpb3Mgb3B0aW9uLiBJdCBsb2FkcyB0aGUgc3BlY2lmaWVkIGltYWdlIGludG8gdGhl
DQo+ID4gK3Zib290cm9tDQo+ID4gKyAqIG1lbW9yeSByZWdpb24gYW5kIGhhbmRsZXMgZXJyb3Jz
IGlmIHRoZSBmaWxlIGNhbm5vdCBiZSBmb3VuZCBvciBsb2FkZWQuDQo+ID4gKyAqLw0KPiA+ICtz
dGF0aWMgdm9pZCBhc3BlZWRfbG9hZF92Ym9vdHJvbShNYWNoaW5lU3RhdGUgKm1hY2hpbmUsIHVp
bnQ2NF90DQo+ID4gK3JvbV9zaXplLA0KPiANCj4gcm9tX3NpemUgaXMgdW51c2VkLg0KPiANCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKSB7DQo+ID4g
KyAgICBBc3BlZWRNYWNoaW5lU3RhdGUgKmJtYyA9IEFTUEVFRF9NQUNISU5FKG1hY2hpbmUpOw0K
PiA+ICsgICAgY29uc3QgY2hhciAqYmlvc19uYW1lID0gbWFjaGluZS0+ZmlybXdhcmUgPzoNCj4g
VkJPT1RST01fRklMRV9OQU1FOw0KPiANCj4gSSB3b3VsZCBjaGFuZ2UgdGhlIHByb3RvdHlwZSBv
ZiBhc3BlZWRfbG9hZF92Ym9vdHJvbSB0bzoNCj4gDQo+IHZvaWQgYXNwZWVkX2xvYWRfdmJvb3Ry
b20oQXNwZWVkTWFjaGluZVN0YXRlICpibWMsIGNvbnN0IGNoYXINCj4gKmJpb3NfbmFtZSwNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPiANClRoYW5rcyBmb3Ig
cmV2aWV3IGFuZCBzdWdnZXN0aW9uLg0KV2lsbCByZXZpc2UgaXQNCkphbWluDQo+IA0KPiBUaGFu
a3MsDQo+IA0KPiBDLg0KPiANCj4gDQo+IA0KPiANCj4gPiArICAgIGdfYXV0b2ZyZWUgY2hhciAq
ZmlsZW5hbWUgPSBOVUxMOw0KPiA+ICsgICAgQXNwZWVkU29DU3RhdGUgKnNvYyA9IGJtYy0+c29j
Ow0KPiA+ICsgICAgaW50IHJldDsNCj4gPiArDQo+ID4gKyAgICBmaWxlbmFtZSA9IHFlbXVfZmlu
ZF9maWxlKFFFTVVfRklMRV9UWVBFX0JJT1MsIGJpb3NfbmFtZSk7DQo+ID4gKyAgICBpZiAoIWZp
bGVuYW1lKSB7DQo+ID4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiQ291bGQgbm90IGZpbmQg
dmJvb3Ryb20gaW1hZ2UgJyVzJyIsDQo+IGJpb3NfbmFtZSk7DQo+ID4gKyAgICAgICAgcmV0dXJu
Ow0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIHJldCA9IGxvYWRfaW1hZ2VfbXIoZmlsZW5h
bWUsICZzb2MtPnZib290cm9tKTsNCj4gPiArICAgIGlmIChyZXQgPCAwKSB7DQo+ID4gKyAgICAg
ICAgZXJyb3Jfc2V0ZyhlcnJwLCAiRmFpbGVkIHRvIGxvYWQgdmJvb3Ryb20gaW1hZ2UgJyVzJyIs
DQo+IGJpb3NfbmFtZSk7DQo+ID4gKyAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAgfQ0KPiA+ICt9
DQo+ID4gKw0KPiA+ICAgdm9pZCBhc3BlZWRfYm9hcmRfaW5pdF9mbGFzaGVzKEFzcGVlZFNNQ1N0
YXRlICpzLCBjb25zdCBjaGFyDQo+ICpmbGFzaHR5cGUsDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBjb3VudCwgaW50DQo+IHVuaXQwKQ0K
PiA+ICAgew0KPiA+IEBAIC00ODMsNiArNTEzLDExIEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9tYWNo
aW5lX2luaXQoTWFjaGluZVN0YXRlDQo+ICptYWNoaW5lKQ0KPiA+ICAgICAgICAgICB9DQo+ID4g
ICAgICAgfQ0KPiA+DQo+ID4gKyAgICBpZiAoYW1jLT52Ym9vdHJvbSkgew0KPiA+ICsgICAgICAg
IHJvbV9zaXplID0gbWVtb3J5X3JlZ2lvbl9zaXplKCZibWMtPnNvYy0+dmJvb3Ryb20pOw0KPiA+
ICsgICAgICAgIGFzcGVlZF9sb2FkX3Zib290cm9tKG1hY2hpbmUsIHJvbV9zaXplLCAmZXJyb3Jf
YWJvcnQpOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiAgICAgICBhcm1fbG9hZF9rZXJuZWwoQVJN
X0NQVShmaXJzdF9jcHUpLCBtYWNoaW5lLA0KPiAmYXNwZWVkX2JvYXJkX2JpbmZvKTsNCj4gPiAg
IH0NCj4gPg0KDQo=

