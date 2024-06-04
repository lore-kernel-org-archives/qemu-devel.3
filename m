Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B181C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 04:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sELig-0005MF-GO; Tue, 04 Jun 2024 00:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1sELie-0005M0-P3; Tue, 04 Jun 2024 00:24:20 -0400
Received: from mail-sgaapc01on20706.outbound.protection.outlook.com
 ([2a01:111:f400:feab::706]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1sELia-0001Gy-L4; Tue, 04 Jun 2024 00:24:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBVkC7LqzDc9OVSm/4xi2IdFkUZGCaBnBjvrzhi7mI7sWCwtN6p2kmyK9sx6ird4zcS3m/krC0DmvEmPElkMXE9ZzX4otR/TaxQh24pMixwZCmzG1FtvxbHd88H2tk1lA+WhfnUnbZN/Oyi1lPSEzVqWUCLoCLED569fgJIGeM9xcZ427CHOJ/Cs/j7fNq3KDS+tIIJoMgJt/pcbkg+wuc6HdmbAOS0gUVncTzlpdv7qlbgX9AbS7GJLHSCg9UXYq5cKXs/cHIchmHjcreNJZdbTpaWn3ykirlHTnxtu75E22CmKMAepzeplMVvCnTuHU7vJfdrzMLsLIkpEI0vetg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpEpMzH3nsA8bCgKDpEVNx7A/peW4j474Zj0AQTC+bY=;
 b=dI366+/qjQjU0yOHTTvjdN9651bMEXSvcguans9SY7W9fmyrk+xrQ6ntPnyCOk2ZKWyRVQpTHHrWLzWELMw75WKmAff3gpA2GGPzYkeCneEASgYn4uliCD5E506DgLAd8RYc4+XJc7yXN7oMw6TREuxZVsURcIW6wYIAGRacKKk03cGJIGHAjibt9gZ0P+x+8+7u819rTsdoWz/HY7L5FhqOzb1u7f3EhWgvBQhqcjmj+FxU7wm8p9ZR/v07PHwNUVeuu2fMaZfc52w/eP9osmsLVJNYRhDZa96eI2vQcCFyvvbTuY1RJkt/9f1phuoxf8iBVXe72vjxVOWPGVefpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=andestech.com; dmarc=pass action=none
 header.from=andestech.com; dkim=pass header.d=andestech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andestech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpEpMzH3nsA8bCgKDpEVNx7A/peW4j474Zj0AQTC+bY=;
 b=kSNTDMdVbeGx+VpnNvVmopmTQDG/jm+9AmSHDXDhkFFiRMJwA5FX3deK5msKrLwks7+8lromT3hufQrH7omWsMaYmbqqiKhioelN0/bS089HYr9DpP/tgaur3a8nzfn8VOG0InTI7CoEC3/TauhEzgCcHxKAdfWe10X8FC3G5RcoEhKDbNKC3QlinBDfgbkRFnWKitIWo9ddwG1W0PpZRpWG54uilgAnxnhVFDizGo0zo9B622orMtfhX1jk7TaCAuV9zC3X/WBXVEvIrHDvcRqP0+F2Y7u9b8cRXQtV2FuXMAOt/vStLietKRDIfOeD4yW+o+JjISmdUl/KpzOFyw==
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com (2603:1096:101:69::14)
 by TY0PR03MB6998.apcprd03.prod.outlook.com (2603:1096:400:27f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Tue, 4 Jun
 2024 04:24:05 +0000
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::292f:e1ce:7df8:115e]) by SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::292f:e1ce:7df8:115e%5]) with mapi id 15.20.7656.005; Tue, 4 Jun 2024
 04:24:04 +0000
From: =?utf-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>
To: Alistair Francis <alistair23@gmail.com>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alistair.francis@wdc.com"
 <alistair.francis@wdc.com>, "bin.meng@windriver.com"
 <bin.meng@windriver.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: RE: [PATCH v4 0/4] RISC-V: Modularize common match conditions for
 trigger
Thread-Topic: [PATCH v4 0/4] RISC-V: Modularize common match conditions for
 trigger
Thread-Index: AQHaaRuw1Ic9+cKyFUOVkNF4KptLBLErnOcQgIvWNQCAACcQYA==
Date: Tue, 4 Jun 2024 04:24:04 +0000
Message-ID: <SEYPR03MB6700CDA466F9EB47588F45D9A8F82@SEYPR03MB6700.apcprd03.prod.outlook.com>
References: <20240227012405.71650-1-alvinga@andestech.com>
 <SEYPR03MB6700853CCA2198D3E7DA7E7DA8202@SEYPR03MB6700.apcprd03.prod.outlook.com>
 <CAKmqyKPT35UqF3xFqKbGgOx7ba_nDBVWjg20czMeJYfsJY8zvw@mail.gmail.com>
In-Reply-To: <CAKmqyKPT35UqF3xFqKbGgOx7ba_nDBVWjg20czMeJYfsJY8zvw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=andestech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6700:EE_|TY0PR03MB6998:EE_
x-ms-office365-filtering-correlation-id: 03452585-5458-476b-5003-08dc844e2b34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?TDIvNTk1YmVvT1FrRkZ5RXY4YnBNZlJjNmJIRUVReEJUcktJajlnR0hDeXZ3?=
 =?utf-8?B?V1FzWC9saGQvSVQxOWJ4VG9kZzJpT1c3SnRHVHNHUjJadzNKUkRUSzllS3p2?=
 =?utf-8?B?MDBkUW1JSjZDVjZqRkttQktuNzQwRE9Xd0VnUDFUTE43aG9BTFR5UG53YUJ4?=
 =?utf-8?B?dFRmNEFzSTRJVkdERE9aaHNPRnlRTHhZWUlxdW1waUdUK0M0Tjl0d2NUMGJC?=
 =?utf-8?B?Z1EzeWl3QVBpN05jdFRLZzNlVGlpMG5jZWJBQldyTy9ZcUZrTmMxVFh6TE1t?=
 =?utf-8?B?LzRBZ1c2bmZoaUkvcXN0cmx4TTdLMGpub1F1cXhmUUZuZHBGNWE2SlhpT1RQ?=
 =?utf-8?B?WVBVZUJTM01mU0huZXUwWWJSb01KbXpJem51TWMzL29HRDdOZ25COS9aWUpG?=
 =?utf-8?B?UzZLb3lMRjNBU1lLbGdzT2NIZ0NuZjkrSXRXQitpYUFjbjZaekppL1FWUWsx?=
 =?utf-8?B?WERjMy9NcjA5WitpaXpLYkhsZE1MUEt1QjdDanVoc3F0U1VVMnpjQnBTNHFS?=
 =?utf-8?B?cUozNXlUYVUzWlZVSEVyZlAzWHZ3YUc3NHhGaGk4TE9oV1hRODJia2pYaXZt?=
 =?utf-8?B?aFlVRzdEVktXS1JsTVF3ZWNUS1hQTDRkMG1aZlNxdlRqRWJWVmJ5UFoyYll1?=
 =?utf-8?B?Tm5INFhOZnZWcXdsVjlHVC9wQzM0bnZWaDFkOGtnTjhzY1p2RGRMU2tRVXoy?=
 =?utf-8?B?TnNFR3M1UU5ob0JhLzF6Qm1RbVF4bFpYRUhZekZEek5LOG1zWjlyNmxISUFq?=
 =?utf-8?B?STh3MDcwYVhKVTUvZ1QzQ0JreHFZV1FTYWJLU2k1aEo4eGpGcEtIeGRIN3JR?=
 =?utf-8?B?TnBxN1hCRFJKQnJSWUV1VDdEN2U1S3B2WnVqdTd2VmhVQmJrb2hMSGpCWjM5?=
 =?utf-8?B?MlRBQUZCQ0lKMmRCUFN6cHRLa1E1TVZJcUlwMjYyaVQvTzBwa3o0cmYwVFBi?=
 =?utf-8?B?ODBldzFvOWtjZzhmVVgxUFpVRWxwNXl4eDk2TlVoV2NLdUpwaTBJUTVWOVNt?=
 =?utf-8?B?cjltT21hOG80eUtOaDUzTElZMGo0K0QvTTE0NmlhY1ZTYzBHOE1lTUNMZXFS?=
 =?utf-8?B?Slh5MWRPMXc1Yk83ZmhkRlhPUkhSb2E0SUVNOGk4Y1B5RHRaaGNCRWE4Y2lB?=
 =?utf-8?B?b0x5cHg3cGNnWk9GbThRZVgwVUp0K3Uzb0p1YjVkMGJlNDNHZ1F5WFg3SDA2?=
 =?utf-8?B?R05CK0F1eTF5R2pjOWRZTnhacHBmdVlkcytMTjlBb2FTd1ZoN1dFb2Z3eTVY?=
 =?utf-8?B?NjF3U1V4Z2RkL1RKd2JZOFI3QWl0a2pBNWNHYXlxSnlhV0xXTlBLVVRoMnpV?=
 =?utf-8?B?QnhHMUU4RTRsb0QwMFRPNjVBV0JDcGR5VEFMMG1HZDZ3R3dmNjlJRWszZVd1?=
 =?utf-8?B?WjNiOUlqaTJCT0cwc0ZTYkZHOFNuQWFVZldjWU9UN0VLaWFUZHZycUlvczNO?=
 =?utf-8?B?T0JRaDl6WTJSejBBUFRWTFZuVmcrc2lZdTFjU1dYbTQ3WldPWmxkRXNGYWNP?=
 =?utf-8?B?WUR3RERaZDl6OFA4SWFKLytQSU9UMjM4bGRjQndEZ0VqVitXRFRzV202bjJH?=
 =?utf-8?B?b1BGM1E1VXRUUGR5UG9HaUkyM21sSkxTWHJBNU11OGpyeWtxeE9UeEhacTFY?=
 =?utf-8?B?N0RzclJYREduOGNDZ2tYVlNNb09sVWZWRWJ2SEdrWFc1L0psdzV3QmtNS0p4?=
 =?utf-8?B?bU9hemZFaEc4bnpqNFlwMjN3VEZIeS94OXpGRGJMdWdjd0hYZzBFU2k4dmd0?=
 =?utf-8?Q?mvk6fcZ525c8NB2NAkgOVymjTrzJUP4ggTQO0EC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR03MB6700.apcprd03.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bC9tb0ZvN1NGZ1h0ZE9hZVFLNzU1aHVPWkVyZFZlNVlFMTlPaUNxMzhMZjhS?=
 =?utf-8?B?dHA4K2hieWpQMDQzQm1hVUdERk96aHZXTGE3R0JDQkZjRS8zN2M4YkU4bnlI?=
 =?utf-8?B?WEVORHhlODJOY2hkWVZwdnUwSWhMdXV0TmZMcWRuTnllSE4yWm5VaVY1WFU2?=
 =?utf-8?B?YTd2V3dzeGx3MElVS09oQitHTG0yY1h5NHVtWklob1hEeVBkMXhLcmdDaktV?=
 =?utf-8?B?a2FLV1NlOGhVdkMxV2YwYnJBd1BYajhpdFRxczE4YS95WnNETzVXeHJ4TTls?=
 =?utf-8?B?MlhOT1R1dHY1M2IyOXN5SUxpV3IyaGlGZEdaT2N6cVMzUStpSVNIRzN5RmZI?=
 =?utf-8?B?MFd6Q1hzUEtvYkFIZ0pSTWhyUVgvVlo4dFVXYm4yQTRabVhHczJiRUJ0NUdC?=
 =?utf-8?B?b3cyMllNc1lOblpUaEJVd1lSVzIwU0VsYi9RcjBtbDZHelJYZ2Y3MEZBcEZV?=
 =?utf-8?B?R1loWmtySFZSSHhVZVI3VlA1ZWhTY1RvS2VLWHFTUjhWNFQ1TlRRajducHZU?=
 =?utf-8?B?eUZnczEzWm5jN2ZkZnplMFk3a1ZGNmd3NFRxUStvWU9uZFVGQ3U5RUlxTnlP?=
 =?utf-8?B?OFZmL1FiRXZOWnhWaDRoajcxeG5FbHl6bnRJNDVqdkgrUG9ldTBBbyt3K0p3?=
 =?utf-8?B?TzlCaTF0T0FJcHpjMGRUbGQrZjNDOVJvRTVPMUZ2V2NWbFAya0w1a2hGRFlT?=
 =?utf-8?B?cXhrODVxZkdQa3ZXOHU2ZkZsTkxKTTQ3UjZhZkc1VjRGYkJFcWFOODN0cDJW?=
 =?utf-8?B?MkJBSWJhYWVBbU5IWVRWVDVOS2hpRFZWeGlLMUgwc3BURzZzdTZDN1RGK3Bx?=
 =?utf-8?B?TTdTVVB4TDJ3ZDhIMDZKaFVLMi9nL0JUdW5oVUtLUUp4cjZ5VW9QRndFMElO?=
 =?utf-8?B?RTVHejYzQjMzcjVMWGF2a1NDYThoTHd6elNQQ3psRkxDWDJFODNiTG44UCtF?=
 =?utf-8?B?T3RuZEFQU2tYaFg0aTRkcSt3SmhDZ2xaTSs5RlgxQjY4RkN4RHpXT0o3ZXFx?=
 =?utf-8?B?NGU0bXlWeks4WndIRGd4Y0RCVGp0bE43R1lMQXNtQ1lBZnlFU21yMEpQY3Bm?=
 =?utf-8?B?ckYxWlFsa2RKZ21XaytOUDE0aWtzejk0ejVpYS83T1JTcnJwN1g5blYyc2Ni?=
 =?utf-8?B?VG05NVR3OTBLMldBbTFLZXVwcy9JQjJQazZNSExRQVcyYUptSThkU2NhZ2lM?=
 =?utf-8?B?Z2ZsNGx5cXJGRUJGbnppUXZtS1pMbzZHMGJrNlRMUlN0YVNCOE52VHJwKzVT?=
 =?utf-8?B?Wi9sbE5MRkVhTm5Ha3pldGNuY211OXA0NlhwcXpmSXNwYjJVeW0zRkVLOVor?=
 =?utf-8?B?SkhMWDEzMElZRnQvUG9GZHZFWHd4cE9iYUcydUp4TzNLYTh5UXUwK255MzBs?=
 =?utf-8?B?MHFSZVRZVUN0VjJyRUFiTk1xNEx0L084QkV1c0JsNEN2SHkwWlpncEY0dGFK?=
 =?utf-8?B?K1NQQVVZMGxYdU9LdkNYVnkzVjRXdGJWR1o4R2hlbFA4ai8wMUpFZmFFMzRh?=
 =?utf-8?B?UThXMjZmYkx1SnBac3lhYm1tMjJVMlVya3Z4QWxvMEg0NzF4dlRCeStqbW4v?=
 =?utf-8?B?ZVBReTJWVHNyUmxFMTJ5RzlxRUhISjh4Y2czSFZEUVk5SllhQjBRQWVkS2Qw?=
 =?utf-8?B?Y0pzc0RWK0sySFpsMEk1OUY3NE5mdnFycFBLTzdWZTNMdWZ5Vm0zNXpQM1U2?=
 =?utf-8?B?QXplNjVoVXBWQ2YwN24vSXpZRG53Z2E1cWtveEN3clRpZEQ2ZTVTQWV5Vmg0?=
 =?utf-8?B?RTlzTlQvYzdka2lCOEpzYjdUSTV1dlVOekNTUjJndjlDYUo0SXN3dU1seWp5?=
 =?utf-8?B?QU9McjlqMmJLM0VhOWZ3bUJXT1pwOE5RZnUrR1EwTk1BSFpkSURiNTVJdko4?=
 =?utf-8?B?Y0FMZjdUTXdRWUVNeU9nZitNMENadnQzQStZRkF6T29ra2hxang0SFp4REFa?=
 =?utf-8?B?aUR4YVdaekMzUzdYNGVZdE1RT2ZJb052cTJFa1JSYnRYU2NDRzRnRHJSRFJJ?=
 =?utf-8?B?amM2N1ZrNzFtbWM3TXhPa0ZpZWgxZ0ZVVzZZbFgwNEc1cmVRSm9TbzZzNUdN?=
 =?utf-8?B?WHNDL3luVDlBYksyRzU0UnNJSUk2VGtSSVE1SWRsZG5YTFc1YXBjM0k4TE13?=
 =?utf-8?Q?DdqVx7dsQk1yHlCcxEW6nLhH0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: andestech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6700.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03452585-5458-476b-5003-08dc844e2b34
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 04:24:04.6887 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e3ec21b7-ec6c-4041-9add-61aea8171458
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kyLeRG3GUBeszS+3+sN1dY5+UhClsXvUu8k1KeQPoCyRv2bvqekVik/VjlqxOyHhcEy9gOdm8Sr1O5oTmSz/5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6998
Received-SPF: pass client-ip=2a01:111:f400:feab::706;
 envelope-from=alvinga@andestech.com;
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGlzdGFpciBGcmFuY2lzIDxh
bGlzdGFpcjIzQGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgSnVuZSA0LCAyMDI0IDk6NTgg
QU0NCj4gVG86IEFsdmluIENoZS1DaGlhIENoYW5nKOW8teWTsuWYiSkgPGFsdmluZ2FAYW5kZXN0
ZWNoLmNvbT4NCj4gQ2M6IHFlbXUtcmlzY3ZAbm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUu
b3JnOw0KPiBhbGlzdGFpci5mcmFuY2lzQHdkYy5jb207IGJpbi5tZW5nQHdpbmRyaXZlci5jb207
IGxpd2VpMTUxOEBnbWFpbC5jb207DQo+IGRiYXJib3phQHZlbnRhbmFtaWNyby5jb207IHpoaXdl
aV9saXVAbGludXguYWxpYmFiYS5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwLzRdIFJJ
U0MtVjogTW9kdWxhcml6ZSBjb21tb24gbWF0Y2ggY29uZGl0aW9ucyBmb3INCj4gdHJpZ2dlcg0K
Pg0KPiBbRVhURVJOQUwgTUFJTF0NCj4NCj4gT24gVGh1LCBNYXIgNywgMjAyNCBhdCAxMjozNuKA
r1BNIEFsdmluIENoZS1DaGlhIENoYW5nKOW8teWTsuWYiSkNCj4gPGFsdmluZ2FAYW5kZXN0ZWNo
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIaSBBbGlzdGFpciwNCj4gPg0KPiA+IFBsZWFzZSBhbHNv
IHRha2UgYSBsb29rIGF0IHRoaXMgc2VyaWVzLCBJIGd1ZXNzIGl0IGlzIHJlYWR5IHRvIGJlIGFw
cGxpZWQsIHRoYW5rcyENCj4NCj4gVGhpcyBpcyBhbGwgYWNrZWQgbm93LCBkbyB5b3UgbWluZCBy
ZWJhc2luZyBvbg0KPiBodHRwczovL2dpdGh1Yi5jb20vYWxpc3RhaXIyMy9xZW11L3RyZWUvcmlz
Y3YtdG8tYXBwbHkubmV4dCBhbmQgc2VuZGluZyBhIG5ldw0KPiB2ZXJzaW9uDQoNCkRvbmUsIHBs
ZWFzZSBjaGVjayBwYXRjaCB2NS4NCkkgYWxzbyB0b29rIGNhcmUgb2YgRGFuaWVsJ3MgbGF0ZXN0
IHBhdGNoOg0KaHR0cHM6Ly9naXRodWIuY29tL2FsaXN0YWlyMjMvcWVtdS9jb21taXQvMDA5OWY2
MDUzNDEwZjU2MTE3OTYyMTNiNzIzZTkwOGNmYzgwNTVlYg0KDQoNCkJScywNCkFsdmluDQoNCj4N
Cj4gQWxpc3RhaXINCj4NCj4gPg0KPiA+DQo+ID4gQlJzLA0KPiA+IEFsdmluDQo+ID4NCj4gPiA+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBBbHZpbiBDaGUtQ2hpYSBD
aGFuZyjlvLXlk7LlmIkpIDxhbHZpbmdhQGFuZGVzdGVjaC5jb20+DQo+ID4gPiBTZW50OiBUdWVz
ZGF5LCBGZWJydWFyeSAyNywgMjAyNCA5OjI0IEFNDQo+ID4gPiBUbzogcWVtdS1yaXNjdkBub25n
bnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gPiA+IENjOiBhbGlzdGFpci5mcmFuY2lz
QHdkYy5jb207IGJpbi5tZW5nQHdpbmRyaXZlci5jb207DQo+ID4gPiBsaXdlaTE1MThAZ21haWwu
Y29tOyBkYmFyYm96YUB2ZW50YW5hbWljcm8uY29tOw0KPiA+ID4gemhpd2VpX2xpdUBsaW51eC5h
bGliYWJhLmNvbTsgQWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ0KPiA+ID4gPGFsdmlu
Z2FAYW5kZXN0ZWNoLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFtQQVRDSCB2NCAwLzRdIFJJU0MtVjog
TW9kdWxhcml6ZSBjb21tb24gbWF0Y2ggY29uZGl0aW9ucw0KPiA+ID4gZm9yIHRyaWdnZXINCj4g
PiA+DQo+ID4gPiBBY2NvcmRpbmcgdG8gUklTQy1WIERlYnVnIHNwZWNpZmljYXRpb24gcmF0aWZp
ZWQgdmVyc2lvbiAwLjEzIFsxXQ0KPiA+ID4gKGFsc28gYXBwbGllZCB0byB2ZXJzaW9uIDEuMCBb
Ml0gYnV0IGl0IGhhcyBub3QgYmVlbiByYXRpZmllZCB5ZXQpLA0KPiA+ID4gdGhlIGVuYWJsZWQg
cHJpdmlsZWdlIGxldmVscyBvZiB0aGUgdHJpZ2dlciBpcyBjb21tb24gbWF0Y2ggY29uZGl0aW9u
cyBmb3INCj4gYWxsIHRoZSB0eXBlcyBvZiB0aGUgdHJpZ2dlci4NCj4gPiA+DQo+ID4gPiBUaGlz
IHNlcmllcyBtb2R1bGFyaXplIHRoZSBjb2RlIGZvciBjaGVja2luZyB0aGUgcHJpdmlsZWdlIGxl
dmVscyBvZg0KPiA+ID4gdHlwZSAyLzMvNiB0cmlnZ2VycyBieSBpbXBsZW1lbnRpbmcgZnVuY3Rp
b25zIHRyaWdnZXJfY29tbW9uX21hdGNoKCkNCj4gPiA+IGFuZCB0cmlnZ2VyX3ByaXZfbWF0Y2go
KS4NCj4gPiA+DQo+ID4gPiBBZGRpdGlvbmFsIG1hdGNoIGNvbmRpdGlvbnMsIHN1Y2ggYXMgQ1NS
IHRjb250cm9sIGFuZCB0ZXh0cmEsIGNhbiBiZQ0KPiA+ID4gZnVydGhlciBpbXBsZW1lbnRlZCBp
bnRvIHRyaWdnZXJfY29tbW9uX21hdGNoKCkgaW4gdGhlIGZ1dHVyZS4NCj4gPiA+DQo+ID4gPiBb
MV06DQo+ID4gPiBodHRwczovL2dpdGh1Yi5jb20vcmlzY3YvcmlzY3YtZGVidWctc3BlYy9yZWxl
YXNlcy90YWcvdGFza19ncm91cF92bw0KPiA+ID4gdGUNCj4gPiA+IFsyXToNCj4gPiA+IGh0dHBz
Oi8vZ2l0aHViLmNvbS9yaXNjdi9yaXNjdi1kZWJ1Zy1zcGVjL3JlbGVhc2VzL3RhZy8xLjAuMC1y
YzEtYXNjDQo+ID4gPiBpaWRvYw0KPiA+ID4NCj4gPiA+IENoYW5nZXMgZnJvbSB2MzoNCj4gPiA+
IC0gQ2hhbmdlIHRoaXMgc2VyaWVzIHRvIHRhcmdldCBEZWJ1ZyBTcGVjLiB2ZXJzaW9uIDAuMTMN
Cj4gPiA+DQo+ID4gPiBDaGFuZ2VzIGZyb20gdjI6DQo+ID4gPiAtIEV4cGxpY2l0bHkgbWVudGlv
biB0aGUgdGFyZ2V0aW5nIHZlcnNpb24gb2YgUklTQy1WIERlYnVnIFNwZWMuDQo+ID4gPg0KPiA+
ID4gQ2hhbmdlcyBmcm9tIHYxOg0KPiA+ID4gLSBGaXggdHlwbw0KPiA+ID4gLSBBZGQgY29tbWl0
IGRlc2NyaXB0aW9uIGZvciBjaGFuZ2luZyBiZWhhdmlvciBvZiBsb29waW5nIHRoZSB0cmlnZ2Vy
cw0KPiA+ID4gICB3aGVuIHdlIGNoZWNrIHR5cGUgMiB0cmlnZ2Vycy4NCj4gPiA+DQo+ID4gPiBB
bHZpbiBDaGFuZyAoNCk6DQo+ID4gPiAgIHRhcmdldC9yaXNjdjogQWRkIGZ1bmN0aW9ucyBmb3Ig
Y29tbW9uIG1hdGNoaW5nIGNvbmRpdGlvbnMgb2YgdHJpZ2dlcg0KPiA+ID4gICB0YXJnZXQvcmlz
Y3Y6IEFwcGx5IG1vZHVsYXJpemVkIG1hdGNoaW5nIGNvbmRpdGlvbnMgZm9yIGJyZWFrcG9pbnQN
Cj4gPiA+ICAgdGFyZ2V0L3Jpc2N2OiBBcHBseSBtb2R1bGFyaXplZCBtYXRjaGluZyBjb25kaXRp
b25zIGZvciB3YXRjaHBvaW50DQo+ID4gPiAgIHRhcmdldC9yaXNjdjogQXBwbHkgbW9kdWxhcml6
ZWQgbWF0Y2hpbmcgY29uZGl0aW9ucyBmb3IgaWNvdW50DQo+ID4gPiB0cmlnZ2VyDQo+ID4gPg0K
PiA+ID4gIHRhcmdldC9yaXNjdi9kZWJ1Zy5jIHwgMTI0DQo+ID4gPiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDgzIGlu
c2VydGlvbnMoKyksIDQxIGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IC0tDQo+ID4gPiAyLjM0
LjENCj4gPg0KPiA+IENPTkZJREVOVElBTElUWSBOT1RJQ0U6DQo+ID4NCj4gPiBUaGlzIGUtbWFp
bCAoYW5kIGl0cyBhdHRhY2htZW50cykgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIGFuZCBsZWdh
bGx5DQo+IHByaXZpbGVnZWQgaW5mb3JtYXRpb24gb3IgaW5mb3JtYXRpb24gcHJvdGVjdGVkIGZy
b20gZGlzY2xvc3VyZS4gSWYgeW91IGFyZSBub3QNCj4gdGhlIGludGVuZGVkIHJlY2lwaWVudCwg
eW91IGFyZSBoZXJlYnkgbm90aWZpZWQgdGhhdCBhbnkgZGlzY2xvc3VyZSwgY29weWluZywNCj4g
ZGlzdHJpYnV0aW9uLCBvciB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4g
aXMgc3RyaWN0bHkgcHJvaGliaXRlZC4gSW4NCj4gdGhpcyBjYXNlLCBwbGVhc2UgaW1tZWRpYXRl
bHkgbm90aWZ5IHRoZSBzZW5kZXIgYnkgcmV0dXJuIGUtbWFpbCwgZGVsZXRlIHRoZQ0KPiBtZXNz
YWdlIChhbmQgYW55IGFjY29tcGFueWluZyBkb2N1bWVudHMpIGFuZCBkZXN0cm95IGFsbCBwcmlu
dGVkIGhhcmQNCj4gY29waWVzLiBUaGFuayB5b3UgZm9yIHlvdXIgY29vcGVyYXRpb24uDQo+ID4N
Cj4gPiBDb3B5cmlnaHQgQU5ERVMgVEVDSE5PTE9HWSBDT1JQT1JBVElPTiAtIEFsbCBSaWdodHMg
UmVzZXJ2ZWQuDQpDT05GSURFTlRJQUxJVFkgTk9USUNFOg0KDQpUaGlzIGUtbWFpbCAoYW5kIGl0
cyBhdHRhY2htZW50cykgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIGFuZCBsZWdhbGx5IHByaXZp
bGVnZWQgaW5mb3JtYXRpb24gb3IgaW5mb3JtYXRpb24gcHJvdGVjdGVkIGZyb20gZGlzY2xvc3Vy
ZS4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgeW91IGFyZSBoZXJlYnkg
bm90aWZpZWQgdGhhdCBhbnkgZGlzY2xvc3VyZSwgY29weWluZywgZGlzdHJpYnV0aW9uLCBvciB1
c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaXMgc3RyaWN0bHkgcHJvaGli
aXRlZC4gSW4gdGhpcyBjYXNlLCBwbGVhc2UgaW1tZWRpYXRlbHkgbm90aWZ5IHRoZSBzZW5kZXIg
YnkgcmV0dXJuIGUtbWFpbCwgZGVsZXRlIHRoZSBtZXNzYWdlIChhbmQgYW55IGFjY29tcGFueWlu
ZyBkb2N1bWVudHMpIGFuZCBkZXN0cm95IGFsbCBwcmludGVkIGhhcmQgY29waWVzLiBUaGFuayB5
b3UgZm9yIHlvdXIgY29vcGVyYXRpb24uDQoNCkNvcHlyaWdodCBBTkRFUyBURUNITk9MT0dZIENP
UlBPUkFUSU9OIC0gQWxsIFJpZ2h0cyBSZXNlcnZlZC4NCg==

