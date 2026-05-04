Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D190FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 02:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJilL-0002rH-T6; Sun, 03 May 2026 22:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wJilJ-0002qt-Fg; Sun, 03 May 2026 22:10:22 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wJilG-00021r-VY; Sun, 03 May 2026 22:10:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/qwdl5DkuymbegyvwWMsKJgCA7deTM0oBrHGeES4nTRerqOZwbVhYJ5WKiF/uMnKRLyNAmq+WFFqstrnyaeLppVKBaznhHz2HtNGZ9JqC3tJhlNwlyP0Rjq/zrcp9hMrd+gRxU0708Umz/l1FvNfVaDZzVNy3NEyThkDmy456a3CfKz19A+247bD0ZLHY2t3SIcwP276dQUgyWJiBbRmdkvccQjdweGLPvgbR+SMgWZGo68omws8GT7UrHyFjC1XJT1lXde83shOfUXiQbAHGTcH6SLQMHWyA4EDCeCvcyrV2+EHXU6KHKUbAoXum/0ae6c2zEXuLWbgAb2C5N7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lZ/6z3DsxLCKRX2LgpGeWpVjjomLcVBg2vDdHbwjV0=;
 b=NR0qfMa34gcGEHmAIT0HWB/17lwkzwVhMtol1Z5YAF+WYQvKx1b9oCPeK7ax20b5dk0+ZpIflZQBHNBlJcFvvq5kOShnmpFM/HYtc/UIkFy0hwno1GHInv3XVM1ozIcbVgP0QqUoYniZDG4zyOFXNQt67X/ELmwY29S6E7sHc5dedOnA04O7kgjU6M44n0E5yeBQsOUphoIhs7aBaHoMG9rHuJ0bWpEM8VFdRytdGjm9WfqeUXjAI8Po5DC/kxYJjUp6pRiXI/jy9wVsDgloyE2RcuMNKfzXeErTHIVuJVwJFxFVc3k5jBNigfSFVITxXp97DU6chjndoUJpR9PnZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lZ/6z3DsxLCKRX2LgpGeWpVjjomLcVBg2vDdHbwjV0=;
 b=CR2FvQbVJ4KmaS46gXbT/PNXT1Fjdx+Hout22XzzVzYlpim68Ky98z6Pvqy5tbaVFD9fWn4h0vnUOBU0wKhW0+hgxdCWQlgOrwbnkLaJB+BaZw8aQUrCxXm89cZwmEMsSd2PlNy12zvxGCZraV5rP2trwomOEuH1zwnR3fqr7SvlT970fEjV3APIuAKG/tj/Nntq/uvYZJ+nliOXkaDw2pOM0n8M4vzUyJkEa/sLoSduxdUl1jJOG8BtfwnBDsNMLWxJof5Yfy5/DGimVWGYM3i4X++X8pvilCpFS5AX8knf+ppRi5SiOBSDRHLODLjXKvXsQTmJT4uxMPaGivG3Ng==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB8121.apcprd06.prod.outlook.com (2603:1096:101:2f1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 02:10:09 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 02:10:09 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, "peterx@redhat.com"
 <peterx@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin
 <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>,
 "open list:S390 Virtio-ccw" <qemu-s390x@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "farosas@suse.de" <farosas@suse.de>,
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@redhat.com>
Subject: RE: [PATCH v5 10/18] hw/usb/hcd-ehci: Add property to advertise
 64-bit addressing capability
Thread-Topic: [PATCH v5 10/18] hw/usb/hcd-ehci: Add property to advertise
 64-bit addressing capability
Thread-Index: AQHc08EZ0uYcgSAJ1kCww/BzBJkpZLX8zImAgABiDVA=
Date: Mon, 4 May 2026 02:10:09 +0000
Message-ID: <TYPPR06MB8206916A212D0A3C18EAA050FC312@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
 <20260424080508.53992-11-jamin_lin@aspeedtech.com>
 <105f9a81-441b-4221-8c04-238780dacd26@kaod.org>
In-Reply-To: <105f9a81-441b-4221-8c04-238780dacd26@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB8121:EE_
x-ms-office365-filtering-correlation-id: 615748a7-7f1f-4f64-0c99-08dea9824492
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021|921020|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: dd1xdlQOI7XK2o8uXEGUl2L/C2IvSDMwhexR8mChwrxAQgDzsbRlsW8TdSDG9KfBXeQQeA4Mn4+YyJXgIMU1UmLQVbg+/ZapeVleGH6TpNyS51b0K9dOLU/VwNoik3Swc8iE1Bk/lOxGwEl0jF9yDptFPkEnBfh1vBix94rNs8ttdsftihGhuxhBhnHD8NRj34MGdkPl3lLR+jRfHVNiuRIG7RbBrF4VCinw/+3ZYMtiQGuiDKl3Q6s+V0btt/+EcSIh9T/wEf97Q8Gu62JkdsyZ1p8R1/+bWHd+XaTJofPKJKIvMrtE7e27045g6dgDvWvduOrBfsF2fM95A+lO6J9G4pltPcFwjEZ8zFYAVhLq4C7Ok46pLFyrAZMJI+KMMTPQrEQdKsZ32nDEwSPk9qAxXKw2oQya+iB2gqslDioWSHwMgX3Xa8bRper3PMiXhmBoTO3zK6ZwAtEz1Kr16Df/3POZoj0+kQWpt1eMRV6jVYDG/D0J68B7Fzu87XMgTt1EzrVVxiLsqInMqtPbF/NvFrjqe4hZ30AtL0nLzFCAvZ+UyU64qJudmKq1v5mtmWjE6e9Dh5TWpJxHlJhi6403s2IJG46SghDa89a2TBO02V1evYQ0//NLImvu3VGXWuBBigZ2+PAMD5mAbtEGXrvJcO9Xapv1eignBn5fwm84nxFXyxjqgwj9pACrCQZ6YbFnQJypzHgMjiYEJU6HL4xT2Cxh7zVuXxsouUtfKgMkkXG8dvDbsNeWoTiW5B142r6KJiA4kpOS98x7QW4Deg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3F3WXlNem1MYnNVM1ZaS3lUQ0hwMEFSUzB6ODNBZjMrb2tZSDBVR1NabFg3?=
 =?utf-8?B?T1R0bFdrakhYTmJnSnZQSkpPTmlXbmJOcDJISFhSTjkwYmpLZ0FoRVJRZzZQ?=
 =?utf-8?B?K21YTC9zR2dEWUptTUNYdFNkV1NzOEZ2cFZHalp6NFpvVHRESVJxeituK3Fo?=
 =?utf-8?B?QU1CVWhZWkpwdDNzSktuZGVkL2pDaGlQU2NITSs1QTNnYTIzcllzWXpraWMv?=
 =?utf-8?B?REVZNDJBTUwzeC9ibWo1K2pPbEtiZXl2ejliZnlBWVlkelJXa3Z2M2NFd1Yy?=
 =?utf-8?B?endPVW10MlhlN3BlWnVaT3R5eEVzYjJISm8vVUpKbXpCOW5RUm1LVHNYcTJr?=
 =?utf-8?B?VUVaZmhjRHpHUVNPV0c5OFl2aVl1Y2pVY0UyWHljUkZYU3J4Z0d4aGg0cW5n?=
 =?utf-8?B?TkJQUlpIbEN5aG9OcDlOaWlhTW5MaXVFQmx0OXoyN3JpMWxrWTFBOG9mMENa?=
 =?utf-8?B?eVA5MTZCc3NoTDQrdzdRT0owUGZVVnpVY0dkSEZBdWdlMXlqOXRqZEpmMU5p?=
 =?utf-8?B?dkk1UWVqOWFyeFo5SWY0MFZ5Mlk5T3BSV2J6bW9XUzJQcEtxS3ptSStWdWlp?=
 =?utf-8?B?WVg5eEIycFdDVWtmSVZrNEh6bXQvS0U1SGZtMDFmeHlLdklRdGlpeFpzTTFu?=
 =?utf-8?B?Z3FacGpMN0ExZWR4TUZQMmdhTnk5QXo5VFlLVElZNGYyMHRKRnhFdXY0aDNZ?=
 =?utf-8?B?NllmZHJzdVFoRCtlamR4R0d3dlNuTDNadEJBVExoNUJZVUc3NzBPa2p0Uzh5?=
 =?utf-8?B?VTE1cFk2b2drL2FwYWg4ZFRUR01nT3JlWDhkK3pEdTdmQnZrRXAwS0FhSzg3?=
 =?utf-8?B?N3JTK3VjakxSRkJuOVY2UFBvd0lYOVZjclJKRlRnbktEZjVjUmtBVHkxczMw?=
 =?utf-8?B?VE1wVWVkUUZvT292SzhkbWlWa3o5UUl4cFpIb0FGTWRVNk03WDJpSmRKSVln?=
 =?utf-8?B?Z3g5Q1NYYzdlZzFTVnpnRFRnZnVEdi9LVUFpTExTYjFNS0F0cTZtZmR4V2xq?=
 =?utf-8?B?S1FrNzVsOEYwVTJFaTdXajcvdUt4cENZN0JMLzNYNEU1WVVrOXFGeC85Z0Mz?=
 =?utf-8?B?UUhCNEtzWWI4b2hrM3ZFL0ZIcXlRd2tBdEFDaUJ5d3B6WjUrMHAwNUoyeWI4?=
 =?utf-8?B?YjZ6SnVlS0tyTno1V1NaaVM0Y2RzSStJanJDZ005b09EYVgrSDl0WjFldkZ0?=
 =?utf-8?B?U1BpLzBWUFZaQ3RIRkIxL3NnNGlRUVBLS1YxcXJieG1LU1Q4aldRTytsQjlj?=
 =?utf-8?B?WW15YllHWEZEN1FlUUFUOWhTdlFlNWlIYnpxckdxdGZQY2FlZDNIc0ZVeS94?=
 =?utf-8?B?RzBXYS9yQzFzRHErZWluOHBwbStGT3U3Z0M0Z1A5cERQamRvWHd6enF0L1FQ?=
 =?utf-8?B?cmNZbTQycU5SR3RuaTBFN1lHN1VOa3NRYndYTkhCTFMrQXdQeG5MdTQvbXNl?=
 =?utf-8?B?d3lYM0hTSEo1cTEvTkZUZXZoekhncktqbHNlT0lyQ0I0bUNzMUFyQW12Z29O?=
 =?utf-8?B?Zit1VnRjRCtqZ2k4d1FCODM4ZkpLK09KSzlTcmVXQW4vNTl5QjZLbnpCRU1m?=
 =?utf-8?B?ZGlwc1dRMzJxaDRLYU95L0J1RHIyZitWWjlQVU9sTHFwc3V5dWw1VHB3Lytp?=
 =?utf-8?B?N293bVFlbnhaMVRyakJwM0d3UUZ2R3dzYmtlZGJBVjJveXAyM2JjY0MybnMz?=
 =?utf-8?B?R2I2UGpYNWxEOUF4LzkzRm5NblpCMFpnY3VrOXlTSGxOMHBzRmw2RDRmUHV0?=
 =?utf-8?B?Y1ZXSXRJZXlYZmNMejdWSGNEY2oyS3drRTN2NDJQWlRxSXhZYW5Xanlub2xh?=
 =?utf-8?B?Y2tNTEJQK20rekd6Q1VtQ2lJUDJycERmd1ZLbXNRSVI4QytORFFybmVkUDFp?=
 =?utf-8?B?U0I3QThIN25FSUpBaldsNC9aNW9iUnk5eWVyZzhNWk9HYVdrSkNTUFFmb2Nv?=
 =?utf-8?B?QTZ3Y1g1WFlqSHVScGZiMmxNOW80eVd1WDVTaDZ6ZFlYSS9sMjBPNGJLZXQv?=
 =?utf-8?B?STZjaEN3dzh3Uis3NFJIeGsvUHZjcVh2ZWYzSHM4U25ETFVxREZvZTAvVlNl?=
 =?utf-8?B?a0hHUGlXREpQYlNNK0FKalV3V0x3N0pvT1ZxejMrT3dYR3Q5U3JRbWtzemI3?=
 =?utf-8?B?dVRwa0pGT0FsQ3hQb09nbXMvbk8wWUlielNyeW9YaUFuak56Q2wzem1KbzI1?=
 =?utf-8?B?OHVialpxWTBaYTJWRGZjdnlDMDZEd0NOQ0tPbmRnVitoTjNLSEpLS0lRaHpX?=
 =?utf-8?B?K2V2Qnc5bjZCRldQWkkwelpyNVJyTVhLQ2hBbC9MNysvS1lIMk90UzQyYUFr?=
 =?utf-8?B?TzFvMWhLVlpKNGZCU1BleHViZlFBRHlEdnp6d2t2WW12bWNjK1YyUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cT6XYEsxGdN1R/gcOcU/lXg0Eloyv+i9hXIHyYbbhs9agGy7P6y5r6zuy6Yvk4nqelVaSk0pg7iwkRZCLbA5D4wdKam4PoBw99CqaH+/Wn7DI2z+d88o75abxY1WZ+JlJRnkvljsdGc/SyoHCe7KIg9Ca8JcRmvjiNp8KfKUU5LoMwaz4jfa4EZ0UJ5DfIMu4i+Je81Ezk/fh/puEObo3312dPeyeMnftCmejX2u2dzOEKLVDY4AW0/0Iul3TvS17UZeRdXpNj1UMwJqUJO+MGtk132bnumLGrR1+/g+VPfTx0/WXcpcizMC5GPWOcr0aTwzeafXYek2haZ7Wh3tGw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615748a7-7f1f-4f64-0c99-08dea9824492
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 02:10:09.4047 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0UMnCccM5XpSMxMaSBnIwRi9ezHo1JtTKe2/1B1ZulzL80sZSAiX6JUqfrUFeI29YIGeJ4ymlR+gD0k1yzhEZauwBWGpa1ECBtsvCzoRSeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8121
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMTAvMThdIGh3L3VzYi9oY2Qt
ZWhjaTogQWRkIHByb3BlcnR5IHRvIGFkdmVydGlzZQ0KPiA2NC1iaXQgYWRkcmVzc2luZyBjYXBh
YmlsaXR5DQo+IA0KPiBPbiA0LzI0LzI2IDEwOjA1LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gSW50
cm9kdWNlIGEgbmV3IGJvb2xlYW4gcHJvcGVydHksICJjYXBzLTY0Yml0LWFkZHIiLCB0byBjb250
cm9sDQo+ID4gSENDUEFSQU1TWzBdICg2NC1iaXQgQWRkcmVzc2luZyBDYXBhYmlsaXR5KS4NCj4g
Pg0KPiA+IFdoZW4gZW5hYmxlZCwgdGhlIEVIQ0kgY29udHJvbGxlciBhZHZlcnRpc2VzIHN1cHBv
cnQgZm9yIDY0LWJpdA0KPiA+IGFkZHJlc3MgbWVtb3J5IHBvaW50ZXJzIGFzIGRlZmluZWQgaW4g
dGhlIEVIQ0kgc3BlY2lmaWNhdGlvbiAoVGFibGUNCj4gPiAyLTcsIEhDQ1BBUkFNUykuIFRoaXMg
YWxsb3dzIHNvZnR3YXJlIHRvIHVzZSB0aGUgNjQtYml0IGRhdGEgc3RydWN0dXJlDQo+ID4gZm9y
bWF0cyBkZXNjcmliZWQgaW4gQXBwZW5kaXggQi4NCj4gPg0KPiA+IFdoZW4gZGlzYWJsZWQgKGRl
ZmF1bHQpLCB0aGUgY29udHJvbGxlciByZXBvcnRzIDMyLWJpdCBhZGRyZXNzaW5nDQo+ID4gY2Fw
YWJpbGl0eSBhbmQgdXNlcyB0aGUgc3RhbmRhcmQgMzItYml0IGRhdGEgc3RydWN0dXJlcy4NCj4g
Pg0KPiA+IFRoZSBFSENJIENUUkxEU1NFR01FTlQgcmVnaXN0ZXIgcHJvdmlkZXMgdGhlIHVwcGVy
IDMyIGJpdHMgWzYzOjMyXQ0KPiA+IHVzZWQgdG8gZm9ybSA2NC1iaXQgYWRkcmVzc2VzIGZvciBF
SENJIGNvbnRyb2wgZGF0YSBzdHJ1Y3R1cmVzLiBQZXINCj4gPiBFSENJIDEuMCBzcGVjIHNlY3Rp
b24gMi4zLjUsIHdoZW4gdGhlIEhDQ1BBUkFNUyA2NC1iaXQgQWRkcmVzc2luZw0KPiA+IENhcGFi
aWxpdHkgYml0IGlzIHplcm8sIENUUkxEU1NFR01FTlQgaXMgbm90IHVzZWQ6IHNvZnR3YXJlIGNh
bm5vdA0KPiA+IHdyaXRlIGl0IGFuZCByZWFkcyBtdXN0IHJldHVybiB6ZXJvLg0KPiA+DQo+ID4g
QWRkIGEgY2FwYWJpbGl0eSBjaGVjayBpbiB0aGUgb3BlcmF0aW9uYWwgcmVnaXN0ZXIgd3JpdGUg
aGFuZGxlciBhbmQNCj4gPiByZWplY3QgZ3Vlc3Qgd3JpdGVzIHRvIENUUkxEU1NFR01FTlQgd2hl
biA2NC1iaXQgYWRkcmVzc2luZyBpcyBub3QNCj4gPiBlbmFibGVkLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gUmV2aWV3
ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4gPiBSZXZpZXdlZC1i
eTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiA+IC0tLQ0K
PiA+ICAgaHcvdXNiL2hjZC1laGNpLmggfCAgNSArKysrLQ0KPiA+ICAgaHcvdXNiL2hjZC1laGNp
LmMgfCAxNCArKysrKysrKysrKysrLQ0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L3VzYi9oY2Qt
ZWhjaS5oIGIvaHcvdXNiL2hjZC1laGNpLmggaW5kZXgNCj4gPiAzYWNiZGRmYzVjLi5mMWYyZmRl
NTc4IDEwMDY0NA0KPiA+IC0tLSBhL2h3L3VzYi9oY2QtZWhjaS5oDQo+ID4gKysrIGIvaHcvdXNi
L2hjZC1laGNpLmgNCj4gPiBAQCAtMjU3LDYgKzI1Nyw3IEBAIHN0cnVjdCBFSENJU3RhdGUgew0K
PiA+ICAgICAgIC8qIHByb3BlcnRpZXMgKi8NCj4gPiAgICAgICB1aW50MzJfdCBtYXhmcmFtZXM7
DQo+ID4gICAgICAgYm9vbCBtaWdyYXRlX2ZldGNoX2FkZHJfNjRiaXQ7DQo+ID4gKyAgICBib29s
IGNhcHNfNjRiaXRfYWRkcjsNCj4gPg0KPiA+ICAgICAgIC8qDQo+ID4gICAgICAgICogIEVIQ0kg
c3BlYyB2ZXJzaW9uIDEuMCBTZWN0aW9uIDIuMyBAQCAtMzEzLDcgKzMxNCw5IEBAIHN0cnVjdA0K
PiA+IEVIQ0lTdGF0ZSB7DQo+ID4gICAjZGVmaW5lIERFRklORV9FSENJX0NPTU1PTl9QUk9QRVJU
SUVTKF9zdGF0ZSkgXA0KPiA+ICAgICAgIERFRklORV9QUk9QX1VJTlQzMigibWF4ZnJhbWVzIiwg
X3N0YXRlLCBlaGNpLm1heGZyYW1lcywgMTI4KSwgXA0KPiA+ICAgICAgIERFRklORV9QUk9QX0JP
T0woIngtbWlncmF0ZS1mZXRjaC1hZGRyLTY0Yml0IiwgX3N0YXRlLCBcDQo+ID4gLSAgICAgICAg
ICAgICAgICAgICAgIGVoY2kubWlncmF0ZV9mZXRjaF9hZGRyXzY0Yml0LCB0cnVlKQ0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICBlaGNpLm1pZ3JhdGVfZmV0Y2hfYWRkcl82NGJpdCwgdHJ1ZSks
IFwNCj4gPiArICAgIERFRklORV9QUk9QX0JPT0woImNhcHMtNjRiaXQtYWRkciIsIF9zdGF0ZSwg
XA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBlaGNpLmNhcHNfNjRiaXRfYWRkciwgZmFsc2Up
DQo+ID4NCj4gPiAgIGV4dGVybiBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9laGNp
Ow0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L3VzYi9oY2QtZWhjaS5jIGIvaHcvdXNiL2hjZC1l
aGNpLmMgaW5kZXgNCj4gPiAwYzhiZGI0OGFkLi5iMjNmZjkyZTEyIDEwMDY0NA0KPiA+IC0tLSBh
L2h3L3VzYi9oY2QtZWhjaS5jDQo+ID4gKysrIGIvaHcvdXNiL2hjZC1laGNpLmMNCj4gPiBAQCAt
MTEwOSw2ICsxMTA5LDE1IEBAIHN0YXRpYyB2b2lkIGVoY2lfb3ByZWdfd3JpdGUodm9pZCAqcHRy
LCBod2FkZHINCj4gYWRkciwNCj4gPiAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgICBicmVhazsN
Cj4gPg0KPiA+ICsgICAgY2FzZSBDVFJMRFNTRUdNRU5UOg0KPiA+ICsgICAgICAgIGlmICghcy0+
Y2Fwc182NGJpdF9hZGRyKSB7DQo+ID4gKyAgICAgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX0dV
RVNUX0VSUk9SLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICJlaGNpOiB3cml0ZSB0
byBDVFJMRFNTRUdNRU5UIHdoaWxlICINCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAi
ICAgICAgNjQtYml0IGFkZHJlc3NpbmcgY2FwYWJpbGl0eSBpcw0KPiBkaXNhYmxlZFxuIik7DQo+
IA0KPiBQbGVhc2UgcmVtb3ZlIHRoZSBleHRyYSBzcGFjZXMgYXQgdGhlIGJlZ2lubmluZyBvZiBs
aW5lLg0KPiANClRoYW5rcyBmb3IgdGhlIHJldmlldyBhbmQgc3VnZ2VzdGlvbi4NCldpbGwgZG8u
DQpKYW1pbg0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gDQo+IA0KPiA+ICsgICAgICAgICAg
ICByZXR1cm47DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgICAgIGJyZWFrOw0KPiA+ICsNCj4g
PiAgICAgICBjYXNlIEFTWU5DTElTVEFERFI6DQo+ID4gICAgICAgICAgIGlmIChlaGNpX2FzeW5j
X2VuYWJsZWQocykpIHsNCj4gPiAgICAgICAgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNU
X0VSUk9SLCBAQCAtMjU1NCw2DQo+ICsyNTYzLDkgQEANCj4gPiB2b2lkIHVzYl9laGNpX3JlYWxp
emUoRUhDSVN0YXRlICpzLCBEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgcy0+bWF4ZnJhbWVzKTsNCj4gPiAgICAgICAgICAgcmV0dXJuOw0K
PiA+ICAgICAgIH0NCj4gPiArICAgIGlmIChzLT5jYXBzXzY0Yml0X2FkZHIpIHsNCj4gPiArICAg
ICAgICBzLT5jYXBzWzB4MDhdIHw9IEJJVCgwKTsNCj4gPiArICAgIH0NCj4gPg0KPiA+ICAgICAg
IG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbigmcy0+bWVtLCBzLT5jYXBzYmFzZSwNCj4gJnMt
Pm1lbV9jYXBzKTsNCj4gPiAgICAgICBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24oJnMtPm1l
bSwgcy0+b3ByZWdiYXNlLA0KPiA+ICZzLT5tZW1fb3ByZWcpOyBAQCAtMjYxMyw3ICsyNjI1LDcg
QEAgdm9pZCB1c2JfZWhjaV9pbml0KEVIQ0lTdGF0ZSAqcywNCj4gRGV2aWNlU3RhdGUgKmRldikN
Cj4gPiAgICAgICBzLT5jYXBzWzB4MDVdID0gMHgwMDsgICAgICAgIC8qIE5vIGNvbXBhbmlvbiBw
b3J0cyBhdCBwcmVzZW50ICovDQo+ID4gICAgICAgcy0+Y2Fwc1sweDA2XSA9IDB4MDA7DQo+ID4g
ICAgICAgcy0+Y2Fwc1sweDA3XSA9IDB4MDA7DQo+ID4gLSAgICBzLT5jYXBzWzB4MDhdID0gMHg4
MDsgICAgICAgIC8qIFdlIGNhbiBjYWNoZSB3aG9sZSBmcmFtZSwgbm8NCj4gNjQtYml0ICovDQo+
ID4gKyAgICBzLT5jYXBzWzB4MDhdID0gMHg4MDsgICAgICAgIC8qIFdlIGNhbiBjYWNoZSB3aG9s
ZSBmcmFtZSAqLw0KPiA+ICAgICAgIHMtPmNhcHNbMHgwYV0gPSAweDAwOw0KPiA+ICAgICAgIHMt
PmNhcHNbMHgwYl0gPSAweDAwOw0KPiA+DQoNCg==

