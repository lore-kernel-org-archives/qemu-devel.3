Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF243C27C44
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 09:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE4KI-0005De-AR; Mon, 03 Jun 2024 05:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sE4KF-0005BN-JI; Mon, 03 Jun 2024 05:49:59 -0400
Received: from mail-sgaapc01on20719.outbound.protection.outlook.com
 ([2a01:111:f400:feab::719]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sE4KC-00056a-5N; Mon, 03 Jun 2024 05:49:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTDfSaxHU2IFoIaiAArvaaWPj7ltJd5jGAxMGdqJ0cmGivYiObX3+FctlZ9OTTASVIoss/P56sMwcKfHNYzNEz6VVi4Vruyxa2iCvTj4I5p569306lOowzVsYXHpCRNDt5OwvheM9ARJmSXLww8tWqitB3SYXj0BNSzNNVQCdsroy/s5hSF9rgYdp2H7A45RaZgbuiRSSCs1hR4+RPCHwwKL8Ac1AJbWmgwEomptAK9M+Qn6rpEh7xBQhljXlDb+EtdDVQnt7NdxYXvG/7piLIgLAEti1163wJ5JkUdGmO0KlbjyA3bi4ri4hj6TPgz3UCQVKhhmwY+LnvGXEtikrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmCyOh585GUmM45Nw8ZIIBjGwNKXt0+McBNI1MH7VLg=;
 b=bsSeSSj61iAF8xEY6CjzZfWKPfhg/hMeoEg0rAqYqL8mpRUGqBiSoxjAd0sgrUSuvzJg+T0xUyjh6kWuFtGxcg0dQtecbzX9ZhiMbcp4j07N3BAZu6lTuZU5N5KAT+PZ5a2+LrTU8ecGfuOJM6ajW+YWzHhjSDqOFYL2ogXl9db67EMsFYxkaFXZj+RL4yFAO+c/35jdJ5YZz8n3HNpb7jfXw0NhGuNNFosNdJ+TLw1x3P8Qtak5TZ8MkfuWfeJ05EQeOBGlu4pj2ESr7ZJncW9lnVZRhwHvSY+NPNIbbu9IjYdo1QV1N2lhM88Bays0kBt6wcNW4Ti4+x4Bne6FjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmCyOh585GUmM45Nw8ZIIBjGwNKXt0+McBNI1MH7VLg=;
 b=FFJGG5r73JYGIGvuTbX5lwnGC7fKP7O9eChmx/KHeKUBHE2AYnWvAK+oDCsSPSp87pwvluNedQHoEzfrivgggbU9IPDnBYNSfTmG8vjcSMDALjs7aQflVjqWWJITIL/u8zSzelBa2OYg8NrfE4BWoLsfBhyvm8ynnQNXGpB5T3hWhLJTMuWbVfkPiFYxAXScLkP9cBM27llC2C9twQ78Tz2P4tNrWDWe6giW2szjoJjY0j+KEdgryvSbd0CNqug4nOfb7MkaYtBnBspDUEFoOtfe3znm0YA7F4SgrzLPSvsAJeIqZYkfVN9UPcsUjEIkLfFBvqmD/GFhxAsc79Euyw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEYPR06MB5375.apcprd06.prod.outlook.com (2603:1096:101:68::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.22; Mon, 3 Jun 2024 09:49:43 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 09:49:42 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Peter
 Maydell <peter.maydell@linaro.org>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Cleber Rosa <crosa@redhat.com>, Wainer dos
 Santos Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [SPAM] Re: [PATCH v4 09/16] aspeed/smc: Add AST2700 support
Thread-Topic: [SPAM] Re: [PATCH v4 09/16] aspeed/smc: Add AST2700 support
Thread-Index: AQHasAxD7pGMgs1HT0+SNhsCAW+G/7GrPUCAgAD8sQCACVwRkIAAF4AAgAAms/A=
Date: Mon, 3 Jun 2024 09:49:42 +0000
Message-ID: <SI2PR06MB5041574C3A7283A1A29B81FCFCFF2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240527080231.1576609-1-jamin_lin@aspeedtech.com>
 <20240527080231.1576609-10-jamin_lin@aspeedtech.com>
 <b641018c-e906-452b-8072-1b46f141808b@linaro.org>
 <41e59fa6-c74d-47c7-ba01-690cfaf7f5f1@kaod.org>
 <SI2PR06MB504115C43768F1DF7E9621B9FCFF2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <98886224-8de7-41d7-9ae9-77ac85818605@kaod.org>
In-Reply-To: <98886224-8de7-41d7-9ae9-77ac85818605@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEYPR06MB5375:EE_
x-ms-office365-filtering-correlation-id: a10ffec8-1506-4734-d97f-08dc83b27e71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|366007|7416005|1800799015|921011|38070700009|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?QmtydVlvWmVzS1NEeTcyL0VTbkMzaFRLa01zVVhIVEJtb0p5RUg1cVRjWjlm?=
 =?utf-8?B?V1h2R0Z3MzcyUUVvK1BkQVVPTFI0S1hCeGhUd25oOWpVYVRaTmRncENqYlhC?=
 =?utf-8?B?eExmM0V1aG9laHpCc2p1YTdZYmdycGQ4ZkZUMkhFOHB4QlMzSDVjVkV5VTZP?=
 =?utf-8?B?cHdwdHV6REJXVkRPUHJ5UTNDV05pc0tzejhTNGxLS29ZZzdzN2l2YnpFaU9p?=
 =?utf-8?B?TEtlL00zWHhHRWM5OVJsTm9ySmVSNjRvRGJ0WUs5dkVMeWhmY0g1SWRSSElJ?=
 =?utf-8?B?cVJrSnUyTC9XZlFTN2lSdW0rVHNzWml1ZjA3VnJVenNPMlR6U0FnZWF1OGhk?=
 =?utf-8?B?YVZSaTJtUlRUWW51NjljZWxzMDEzelJTRXE0eStCLytnWDc5NWFJZEdkZGM5?=
 =?utf-8?B?c2J4aE4xQ1lDQUpMcGxtdkFtckdFb2FQQXZuVTNHT2RCNlFEMHFkOG92SC9s?=
 =?utf-8?B?dVpSWE9nWC9PL0RBSFlTK0JIM01hek9DenJZTlRubzBEQVQ4WkU5Smk1OWVr?=
 =?utf-8?B?YWRaNG9TVXhGcHVSYlF4MFZjTForQXRJL0tsNFA0OVlZNmgyQTVsYktLRnU1?=
 =?utf-8?B?bVRMQy9nRjQ5Y0pnRTAreXdZMWVFVUJWMkxLOVR4U2sxaEJVSWZWSEVrNytY?=
 =?utf-8?B?M0tJUjBNQnduL082ZjFWZjF0d0JrdnlFNlV2LzJqNUcrYU9jaE5tUDV4L1lI?=
 =?utf-8?B?YUdHV1BJWHlCaURxQkVGbCtxbXY1UWs3MnRzcUt2RjdFYmxTU0RObHk2Vmtp?=
 =?utf-8?B?Q1hkRjhrRFozcnRDWWtMbEd4RXF0cWJUczlGend0cnNNZUxiSmVZQjVYOTZZ?=
 =?utf-8?B?V09icnBuMjBJQTZqdEcxbW5acFQ0VDZaVkpiWUx0N3dOVDVIOEY5S3pVYkhh?=
 =?utf-8?B?aWQ3TkRJc3hUQWlKdzFES1V1aG9EUWZ2b2pMMUNmY3JJZFJLRVZRa3YxU0ZN?=
 =?utf-8?B?K094OHk0Qll1ZXd3bC96MDNDa0hvWEpVZ0pqVW1jQnAvT0FEOEMvcy9XZ2JG?=
 =?utf-8?B?NWZnMHRGb3kzdWNRQjFXVFI5eGJ6MTlKNW9obVpTYTN6NUgrUjh5aXNsZDNE?=
 =?utf-8?B?UWRVeExmSCtLZnFkVWY4VHNpdk1jd3FDOFhnbllDYzh2dUsyVjVtMTEyK2M0?=
 =?utf-8?B?aDY5VFF6dWdHOTJ3WCszc0FMaFBCUVVhMHBZbkYrNW5rc1dmOVpPVE8zUGo0?=
 =?utf-8?B?dDFib0I3c09aN3JNWjM3czF3Tk5laXU0Q01ReCtZQ09YdG5IUE15dDJPbDRR?=
 =?utf-8?B?SmpEY0dacDEzcCtnR3Z3UzY0Y1ZQRlVHblVJQS9wVklka0xhaG93Wlk2ZkpM?=
 =?utf-8?B?dkMrWEdNRWI2WDB3VDFpSDMwYW1IekFHTXBCRVJzd0Y4QmNlSTR6bUMvcUtk?=
 =?utf-8?B?cGlBSFpEZWlEZHJUTGFZSFJEVUFicTZ1aXhzWkF6WGJkaG52NlRNT21kQ3d0?=
 =?utf-8?B?TlJQWE5BR3dxWURNTzg3OENrRkQ2MDExazBSMmVsN2dYdTFQdnRmSmVITzRl?=
 =?utf-8?B?N3pMOW93OFpvR3RlRDRIUXpITVhEQktwQTlaVkEvY09jVy9Cc3I3WXJQNWlX?=
 =?utf-8?B?d1RZbXo3WFlYNjBsUHBiMy94Y3Jna3Nua2RPRVZ4cXhnRkRUVTJUWmlUWER2?=
 =?utf-8?B?STVland6NFRCS0FYUFRxM0hhUDk5dWtSOXFyZm5JTTRPSSs3cFg1Mzg3OTlo?=
 =?utf-8?B?Nlk5T0dlWE83UjdoSmErSzZNWGptYjFoM2dVQkIxWGxRT3M0WUJrQTNjcFNZ?=
 =?utf-8?B?SSszOWNEdmYvZGJycEU4dldrY2Vwd1lnMzgyOTA1Z1BQejVSNXVCQlVJVk5o?=
 =?utf-8?B?V3owT2F5SFFxSzdBbGNheDN1djJaSDNuL2prNENQSXdBMENzWUtmb1Z3UlVJ?=
 =?utf-8?Q?j5redaF1nfvku?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230031)(376005)(366007)(7416005)(1800799015)(921011)(38070700009)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ly9ibGdsS1JZNmcreUV4TjJ4VFVmL1lDMFZ1bFZGS3gxNUlmWmxSQzUrN0lQ?=
 =?utf-8?B?UXZ0cjVhU2dpNWpPLytrcnVMMno3YWVsZFE2Y1VaNFgwL25LU1ZEcnN4S0o3?=
 =?utf-8?B?MkphM21yTWdDYUd0WXFmUGxCVjJpTkYxK3JVeUJFQmlXU3NrZEVrcnQwV3Zt?=
 =?utf-8?B?eGxua1EwWFlUTzY5UDVTM05kTDl2ZW9tQnc0WkhtbHJpOTdHNGpldWllVStM?=
 =?utf-8?B?dTcybFBnV3loSENodldZbGJTeThyNXplZElTekkyYjlXdWJpWmZDTlJsOHRF?=
 =?utf-8?B?dlliYlpJd0M5ODdPYWdsekdzT1FlNERNTnhKb0RyRlFzdGdISXVnUms5RmpE?=
 =?utf-8?B?TUIySTY0MUJqSDAyUTVneGkzcnJsUk5QLzlzR052ZjA0bU1jUU01VFZFTlpn?=
 =?utf-8?B?RXVaTEIyRCtpSXJzZWxZK1R4ckVOQ21BQXpDaW5lZnlBZWxUUHJ5UnRPaVRJ?=
 =?utf-8?B?VDRNbWMzYmVDTHlHMGU3R1ZuRTBZVy8rUThjdmlzQzYyTkkxUHVLQllDWlhB?=
 =?utf-8?B?ajNMOC9Idko3YzFuay9leXpEL2VVN3hhU3FTSytjVnU3dFZYNW1VK2huSFZO?=
 =?utf-8?B?aU9OMFNTK2lZL29tQUhtS2k5R3NWNWhIQUl0ams2TksxT0E3U1VQdTlhcmxS?=
 =?utf-8?B?TlFuclgvOHdYNFlXU1JSc2FZNUlRWE51V0liNDQwU1p6WWpRbFFOQ2NHY1Zq?=
 =?utf-8?B?bVlMb09CdnNlVDdTa1VJWGFTcmRmRi9hOWRRQ2liYkdJdXp3cUtXbXFRL1pw?=
 =?utf-8?B?OUZDbTYyUGRRMk85dGo1RUtsYUExbFJMZmRLRlZ3UDIyQ2NicGdYRzYwczNG?=
 =?utf-8?B?SGZZajlCL3pKeGpFSGJsYVM5eTZ5L2VIM21kZlhIT3R4WUNSTUR1Z3RiRTRG?=
 =?utf-8?B?cjZYZDVxYmd2YXJJZnJWRmlBb3dFUm1tSmc0UjJ0MmVBeVlTNEhOQXgwQTNH?=
 =?utf-8?B?Z3pOMFRla1dsalYwSHBpaUZ1WlZOMTI2b3pTRjlPUGxCYmZneXp2KzdZWEdq?=
 =?utf-8?B?bVBpc0dkM0hBN3NMb0hldm1sTU9hQ1ZNZjU0K3JraFZJdmJ4RVFSUElxVHFV?=
 =?utf-8?B?anRZbGZyYmpXeWNCRStNMzZ1L2E2Z0RUdWdqYXoyMUV0QmVJTnk0UkRPTGRL?=
 =?utf-8?B?YXpNbUNUOEVncVdLK0x4cHhRZDVnT2VQcC90ZFYxYjcwMEZOQWNScnh6Z2Q3?=
 =?utf-8?B?Z2ZYS0xXTmUwcEN4OEpjS081eGwwVlhRblhZWkZrNTlOOU0ycHJTbTUrYjRY?=
 =?utf-8?B?dUZBbC9idmpRTElLVWhoUm9Oc1FYcHoyaWlWcWhmR2o4ZDR0b0dkMjBHTXdL?=
 =?utf-8?B?MWNsWXhiYTNjRi85Sm52Y2RJS0JwdW9WdDVZMDdzcGtVK1JJSDRjSVVaMjE4?=
 =?utf-8?B?ZHlHRlVBUWJyUWtyWHpmeWVxbVNVZWdWbEplajVHR0pSa3hCeUxQbjhTank3?=
 =?utf-8?B?M2tCcFBVZXNvVnlPYS9sOTd4UjJ3K2ZUZTRuRHpYMk0zUEFaTTh2MDA2N1h1?=
 =?utf-8?B?NEVMY1dTbmEyRE16UXE5SEpqWEI4VUdhNXY1MzVFdThKbGxhOVlzczI2QVdp?=
 =?utf-8?B?eXZFbVM2U1B6L0xDc0Rpd25nYlh4NmlKNi9TZ0NXQmNFUXJqWXdWR1JnK3hX?=
 =?utf-8?B?MFBpaDRuQjBsWmV6STlOU2s3cDhROTRXck00SCswWGcrbXdjRkhUY3UxaDA3?=
 =?utf-8?B?MzhvUUFTTlZINHJiK2t4VnF4bE5wSVV1dVZFU3lEZ00vcXh1YXp2ZWcvVkI1?=
 =?utf-8?B?S2RvK2JidSthSWNvU3VhK29xVlZvaHQrWVBYbzNRc0ZQMGJHeFE4SUNXUkda?=
 =?utf-8?B?a0ZqQmJYTHhKdDdPZmpkYjB1NEs0QjJaV1VWSW9PM3FxbE02cVBMNnRJV2hi?=
 =?utf-8?B?ZjBjL2NhVVAxcUtSa2Z6QUdyenhJeE1aQ3V0OGZZNXlMZnBTdkFreXdhakpn?=
 =?utf-8?B?TlArbXlkcEJMT21tZ05mUkFFM21nUVViOXo0RFdsVzE1OU9iMHBwQWxLd3lz?=
 =?utf-8?B?TnVKaGlodG11dzJsNGxMc1lOWnhkODc4UTg0RFdMVUI3U1E0dmo5VytFWTYx?=
 =?utf-8?B?OERKS2VDMzRDekluNmo0VGtiWXZ1K0RmRFJWT3dWTEFGRFYyR2RDbFREMXlY?=
 =?utf-8?Q?ttDK/7CeRAXu5Sihe0E7RFika?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a10ffec8-1506-4734-d97f-08dc83b27e71
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 09:49:42.8437 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iVXRpRKlsfnBXLJHRbFP5k1/0reL382xyDwCdTb0SEBpPhAk4Hzz/PARf4eMLBztyDDXeyhJ7y3O258G3YICAUuwqCVl9Yo7Et57dCtEjjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5375
Received-SPF: pass client-ip=2a01:111:f400:feab::719;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgQ2VkcmljLCANCg0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0K
PiBTdWJqZWN0OiBSZTogW1NQQU1dIFJlOiBbUEFUQ0ggdjQgMDkvMTZdIGFzcGVlZC9zbWM6IEFk
ZCBBU1QyNzAwIHN1cHBvcnQNCj4gDQo+ID4+Pj4gQEAgLTY3MCw3ICs2NzAsNyBAQCBzdGF0aWMg
Y29uc3QgTWVtb3J5UmVnaW9uT3BzDQo+ID4+IGFzcGVlZF9zbWNfZmxhc2hfb3BzDQo+ID4+Pj4g
PSB7DQo+ID4+Pj4gIMKgwqDCoMKgwqAgLmVuZGlhbm5lc3MgPSBERVZJQ0VfTElUVExFX0VORElB
TiwNCj4gPj4+PiAgwqDCoMKgwqDCoCAudmFsaWQgPSB7DQo+ID4+Pj4gIMKgwqDCoMKgwqDCoMKg
wqDCoCAubWluX2FjY2Vzc19zaXplID0gMSwNCj4gPj4+PiAtwqDCoMKgwqDCoMKgwqAgLm1heF9h
Y2Nlc3Nfc2l6ZSA9IDQsDQo+ID4+Pj4gK8KgwqDCoMKgwqDCoMKgIC5tYXhfYWNjZXNzX3NpemUg
PSA4LA0KPiA+Pj4NCj4gPj4+IElzIHRoaXMgYSBidWdmaXg/IElmIHNvLCBwbGVhc2UgdXNlIGEg
c2VwYXJhdGUgcGF0Y2guIE90aGVyd2lzZQ0KPiA+Pj4gcGxlYXNlIG1lbnRpb24gd2h5IGl0IGlz
IE9LIHRvIHdpZGVuIGFjY2VzcyBmb3IgQVNUMjYwMCAmIEFTVDEweDAuDQo+ID4+DQo+ID4gQWNj
b3JkaW5nIHRoZSBkZXNpZ24gb2YgU1BJIGRyaXZlcnMsIGl0IHVzZXMgdGhpcyAibWVtY3B5X2Zy
b21pbyIgS0VSTkVMIEFQSQ0KPiBmb3IgU1BJIGNhbGlicmF0aW9uLg0KPiA+DQo+IGh0dHBzOi8v
Z2l0aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy9saW51eC9ibG9iLzEwNjJhMDc0MjBmOWFlZDRlZDdk
YzlkZWINCj4gPiAzNDI5YjhlNzgyOGY1Y2YvZHJpdmVycy9zcGkvc3BpLWFzcGVlZC1zbWMuYyNM
MTgzMg0KPiA+IEFTVDI3MDAgaXMgYSA2NCBiaXRzIHF1YWQgY29yZSBjcHVzKENvcnRleC1hMzUp
LCBzbyBrZXJuZWwgQVBJIHVzZSA2NCBiaXRzIGZvcg0KPiBkYXRhIGFjY2Vzcy4NCj4gPiBodHRw
czovL2dpdGh1Yi5jb20vQXNwZWVkVGVjaC1CTUMvbGludXgvYmxvYi9hc3BlZWQtbWFzdGVyLXY2
LjYvYXJjaC9hDQo+ID4gcm02NC9rZXJuZWwvaW8uYyNMMjUgSSBzaW1wbHkgc2V0IHRoZSBtYXhf
YWNjZXNzX3NpemUgdG8gOCBmb3IgQVNUMjcwMA0KPiA+IHN1cHBvcnQuDQo+ID4gQVNUMjUwMCwg
QVNUMjYwMCBhbmQgQVNUMTB4MCBhcmUgYWxsIDMyYml0cyBDUFVTLCB0aGF0IHdhcyB3aHkgdGhp
cw0KPiBtYXhfYWNjZXNzX3NpemUgOCBkaWQgbm90IGltcGFjdCB0aGVzZSBtb2RlbHMuDQo+ID4g
aHR0cHM6Ly9naXRodWIuY29tL0FzcGVlZFRlY2gtQk1DL2xpbnV4L2Jsb2IvYXNwZWVkLW1hc3Rl
ci12Ni42L2FyY2gvYQ0KPiA+IHJtL2tlcm5lbC9pby5jI0w0NQ0KPiANCj4gWWVzLiBJIHRoaW5r
IHdlIGFyZSBzYWZlIG9uIHRoYXQgc2lkZS4NCj4gDQo+ID4gSWYgeW91IGhhdmUgYW55IHN1Z2dl
c3Rpb24gYWJvdXQgdGhpcyBwYXRjaCBtb2RpZmljYXRpb24sIHBsZWFzZSBsZXQgbWUga25vdy4N
Cj4gPiBJIGFtIGdvaW5nIHRvIHJlLXNlbmQgdjUgcGF0Y2ggZm9yIEFTVDI3MDAgc3VwcG9ydC4N
Cj4gDQo+IFBsZWFzZSBtb3ZlIHRoaXMgY2hhbmdlIGluIGl0cyBvd24gY29tbWl0IGV4cGxhaW5p
bmcgdGhlIHJlYXNvbiBhbmQgYWRkIGENCj4gVE9ETyBjb21tZW50IGluIHRoZSBjb2RlLg0KPiAN
Cj4gVGhlIGFzcGVlZF9zbWNfZmxhc2hfb3BzIE1lbW9yeVJlZ2lvbk9wcyBzaG91bGQgYmUgY29w
aWVkIGluIF9yZWFsaXplKCkNCj4gdG8gc2V0IGEgZGlmZmVyZW50IHdpZHRoIGZvciB0aGUgQVNU
MjcwMCBTb0MuIFlvdSBjb3VsZCBkbyB0aGF0IHRvby4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMu
DQpJIHdpbGwgZG8gdGhlIGZvbGxvd2luZyBjaGFuZ2VzLiBDb3VsZCB5b3UgZ2l2ZSBtZSBhbnkg
c3VnZ2VzdGlvbj8NCg0KMS4gYWRkIGFzYy0+bWF4X2FjY2Vzc19zaXplID0gOCBpbiBhc3BlZWRf
MjcwMF9mbWNfY2xhc3NfaW5pdCwgYXNwZWVkXzI3MDBfc3BpMF9jbGFzc19pbml0LCBhc3BlZWRf
MjcwMF9zcGkxX2NsYXNzX2luaXQgYW5kIGFzcGVlZF8yNzAwX3NwaTJfY2xhc3NfaW5pdA0KMi4g
VXBkYXRlIGFzcGVlZF9zbWNfZmxhc2hfcmVhbGl6ZSBhcyBiZWxvdw0Kc3RhdGljIHZvaWQgYXNw
ZWVkX3NtY19mbGFzaF9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkNCnsN
CiAgIC0tLS0tLQ0KICAgcy0+YXNjID0gQVNQRUVEX1NNQ19HRVRfQ0xBU1Mocy0+Y29udHJvbGxl
cikNCiAgIGlmIChzLT5hc2MtPm1heF9hY2Nlc3Nfc2l6ZSA9PTgpIC0tPiBjaGVjayBtYXhfYWNj
ZXNzX3NpemUNCiAgICAgIGFzcGVlZF9zbWNfZmxhc2hfb3BzLnZhbGlkLm1heF9hY2Nlc3Nfc2l6
ZSA9IHMtPmFzYy0+bWF4X2FjY2VzcyAtLT4gdXBkYXRlIG1heF9hY2Nlc3Nfc2l6ZQ0KICAgIC8q
DQogICAgICogVXNlIHRoZSBkZWZhdWx0IHNlZ21lbnQgdmFsdWUgdG8gc2l6ZSB0aGUgbWVtb3J5
IHJlZ2lvbi4gVGhpcw0KICAgICAqIGNhbiBiZSBjaGFuZ2VkIGJ5IEZXIGF0IHJ1bnRpbWUuDQog
ICAgICovDQogICAgbWVtb3J5X3JlZ2lvbl9pbml0X2lvKCZzLT5tbWlvLCBPQkpFQ1QocyksICZh
c3BlZWRfc21jX2ZsYXNoX29wcywNCiAgICAgICAgICAgICAgICAgICAgICAgICAgcywgbmFtZSwg
cy0+YXNjLT5zZWdtZW50c1tzLT5jc10uc2l6ZSk7DQogICAtLS0tLS0NCn0NCg0KVGhhbmtzLUph
bWluDQoNCg==

