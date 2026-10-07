Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8877BCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN26-0002Qq-TO; Wed, 07 Oct 2026 04:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xEHmE-0006Xx-EV; Tue, 06 Oct 2026 22:53:11 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xEHm1-0004oi-Gm; Tue, 06 Oct 2026 22:52:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4eAJU+kWQ3ZHF/unq/9RXRrja0J33OtofwCp2BhGpyWS9XGlkZi6HmRE6dKaysaMQS1/1zUDOXGS+rrx5GjwTwxHiLqNlHuSTQp+rn9GC5aImPsxfZOQ/UjbwQV5y0Ei8qStuvkgPqCmg3oc8zIibpqGrD64x8g7zrk5xNjTWLqbZs8cKxPZ8zjJrXrVP6DIb0lYdZXIlW6MrBwc9kj/M9WX7OMAV7ntj3guEehRFpmlFDOfN/bOqiZuoQlFMat1udSRGoI2y5+jiuuxrA28jTVLcy4OIw6NXjI8Vc9ftNBkDsMLHdP5xVqa1SQJIyPyz2HYktmxL5i3Tb98Q4Z3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8tTw8hyswmTkKBaKhleqedmtQjLorclziyY5S2eT3M=;
 b=uOZ5iUaE6JiuQyRia1bPWH2J5BgP2dYLsbTDNU2+qhn1eClZ6gB65/TDTMaXiGmFnYMeGUmCh3ilMFWRSQMFG4qS5tviApDIunNYjipCNFDzLWfVP7j40e6DMa/zYyTt7phVOgu0JjrNw52ZlT9YUUn6qo86VGnrQt1kkOvB4edA5D+91+NHzOeABlUyz93QIQNIycgF1i1JeO6w6nA5pdmvzqM8Jyaj1yXBJ5rV4xlZg3/TwY01Kg+jrhmbGpdF3mwrJs4yxoX9m2u5gYWgz5Pf0ZGte5K4iO3Ut/K65H1ChB0KfTWJQbimHEp57mhtMgYtyntPd5zujSZeqW2GWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8tTw8hyswmTkKBaKhleqedmtQjLorclziyY5S2eT3M=;
 b=IpfF9SL+xm5Dw7wohhmpaQFQHFTwGSg/WMjFNQjfgAE45yJTrKGASKq6fuDKgIwm6wbjhF9eoX/qZ6Sv/GkVpD2QcrwLJf9KatzIFpC0vI/38MPJwOhFB35c0Qv9sa9Rq2qj0W+lb1rQ0k8Yt1i+yhAy5fLe45yg4l4IeDL9alCCZfLukGA9tizApcB6BvlZi9xt1RmK4zvrSgKCv+LEnJ9fLgUR64CO+2FzqgI6aTBEQggzJINCGq5wXGVaMvp3QlpjPfCeIVPbpW1z3nDZjEwxMwshJuztR4Iqc5WMZK63h+Hd/rvvRrxWzpVIP9hJdoVq1sV7KjjsLb0pQJHFMQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB6949.apcprd06.prod.outlook.com (2603:1096:101:1e4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 02:15:57 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 02:15:56 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>
CC: "clg@kaod.org" <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane
 Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 2/8] hw/usb/redirect-server: Add a usbredir server
 device
Thread-Topic: [PATCH v2 2/8] hw/usb/redirect-server: Add a usbredir server
 device
Thread-Index: AQHdVHh3uLXv2VFpZkCIJ+Dg/sNXx7bupqoAgAKx2RA=
Date: Wed, 7 Oct 2026 02:15:56 +0000
Message-ID: <SEZPR06MB736267CA04EA7BB0EE82D87DFC942@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261005032022.3980903-1-jamin_lin@aspeedtech.com>
 <20261005032022.3980903-3-jamin_lin@aspeedtech.com>
 <179119075845.699310.5944945395562648270.b4-review@b4>
In-Reply-To: <179119075845.699310.5944945395562648270.b4-review@b4>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB6949:EE_
x-ms-office365-filtering-correlation-id: 410ba5df-4095-422c-07db-08df2418ec12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|5023799004|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: n4sVAuIOoCX5I6gqDCsG1zXNo5M4DBZFEQ0Tv/kEzRkvtSpRr8lVw8e1PDmBwfanyaLqWBGd7rSfspR838Wu8Hydjv3CW5vDx2vsriMccggClaTHHsS/4E1HkCHYBUqa68GFfr1ifEpoNvGYlsD6nDoI3rFEMpqokb9ZmYy/8JhO7asS9A0RZ81RfvT1hqexlJKHF/h8MuH3xpIrsbPQElpjaFQ9Labw5BjOX+ugDCsdqwXMugCX0pJ6GvIPilMQO07ndgYNFGRtLCWjO6ceI91OPNf6BCuHmz8xzRGwUQWllV/PLroY9TbLJqUUW1IIGmZaX84VigZ7/xZCkpCe6AZi4Gn39yxmL5YyubkopYflOL0O8PTDG+2IeUIbG/H9BTrsVQbgIr47cL+fgPqVSlPWgpP+48o66Ctlcfk7GXA+jd/VVNAEYxVxcr3t8PkabUI//ujtPaTaIsScEWAKl+5lyfHlFxJzxI2u9nsS0XLEEOPKGWAMBsLd7eVHiO8dy8KKDQO89ZtwUsm7ZCkrlFtKz7j1y+ul33WOitKLXbjmvgEtJi1MUawq2co4ImzzQuS8fqEkqqQvSvAzqjAhxnUzCWNJ0n8OJRE+vEiT3O+CMsOFZJp5mCy3FZN9i819ACFJnO4fV+Uk0CIROX3QVaoSppAmaLEBAtfHI6DlZcbyRu7DUb5ikOImWI0A8qqdG2/9kZqeAMMOLoAHyHOYab6hGAlbCmcEYCe1scP+vEY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(5023799004)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmlOSGFTakplMC9XVUNENXduTTR4UFVJSHhrd0srd2VqMmdiZEdlZkViRGpJ?=
 =?utf-8?B?eHVwczc4ZFFxN2RZOTZVTWlmYUovc1VTcENMbFE4MVMwWmdwbFhpWjl0d2d3?=
 =?utf-8?B?MUR6RERtalBXSmc5cy9hRHlMU1NwSUtiQmEzamZkbzVDSCtMZ2x3eVo4M3hY?=
 =?utf-8?B?Z2dRVU5OWkw5dTBpM2ZpSmdrSDhwUXdrRFR5SFlNT0hZZDV1T09BTUtjeS9l?=
 =?utf-8?B?K2FvTDRGQkdNU0E5NE1YWFdVNGNtWEx5aFIza0FVZ0RwSVIxWlZJVkgyWlJx?=
 =?utf-8?B?RjVZWlJsQmRHNnZ3NW5JelltTTZuR1AzTXRxOHVhNmJOYnJDdFp5bGdsWjVy?=
 =?utf-8?B?TkR3L1M0TGRrRmZsQ1pzemovNU5lY1Y5VmJvRzBqNVRXWXhqU05WZmhYRVBx?=
 =?utf-8?B?cG1IYlkvTUZ0VlRzVzFab25SSWcxRTJ2d1NBR2hycnZOTDhtQmpSSW50Ukhi?=
 =?utf-8?B?K0lNanArUGlJVEp3Um1VaXFJNGZuTyt5SjhJUHZWVEVxbXJQR3JEYkpoL1kv?=
 =?utf-8?B?TzJxK1MwenU0a21ZZlk0UDVjUUFlaXQwK1F6Ny9vU0F6Q0FtT1ZxazdIbW9K?=
 =?utf-8?B?cml6SlpKcUVGdkp5RDNrY1FOL04yTWxnNE41Q201aE1qeHJWcG1qUStYOGJR?=
 =?utf-8?B?NG9MaUZBaVRaY25SS1V5R21RSXVzRzJUNmIxMXdBYnhmd0FFY1kxUHA4YVdk?=
 =?utf-8?B?MWxtNVM2c0Y2d0x5ODJUa1JMZG4zeFVOaUhMTXN6UFQvb3hvRDNCWGdkUHFM?=
 =?utf-8?B?OTRnbHdHMVhkbkJHcXVGb1RYbzFSWW1mRFBhZk9QcTBvRG9CTENocDVxRGcr?=
 =?utf-8?B?V2pOWmhKR2hRZEpTYVhkckM2UmpkdHlMMld0aldUQWt6RFV6QURLR2puckUw?=
 =?utf-8?B?UGNvcXFlbG43WWRGTWFIOXpvbHZIY1FORXBCUnJDQkNRbFczQWNBUG5MTXIz?=
 =?utf-8?B?L3ZQdi9rRVNjcUtzbGN2NXYyaURNY2R5Z3dET2ZHOEZORkFJcnBnMmthMlRZ?=
 =?utf-8?B?cC96UnpnK1F2MVJuOXJuZ08xTGRwU2tZK2xab0xsWkc5ZzlQWk45QnlVaG5H?=
 =?utf-8?B?cTNycWh0VVZxeDgzZ2NLYmlIVmxrYlhwWWRoOEhPalBodEwybTdCV2Z3UnQ0?=
 =?utf-8?B?VVlacU5iQjB5aWdQQjJDcXovb3h6azZpNmd3anR1Z1BNVWhtbHZsQjM0OWF1?=
 =?utf-8?B?czA0WGk2bEhRYURmYkttYUpDOER1ZkRqNTRuenl0bDRJMlk4eGlaNUFQMVhJ?=
 =?utf-8?B?SUZ4clorSW1KVWVpVktCUVlJNzZZR1FoVWdacjl5ZDBvaEo3ME9KdTZqM0FS?=
 =?utf-8?B?Z1RsQ3dQOWRiaFpiUDF6Qzl1eVgxQWZnR29zRE43ZCsxMTk4Ri83emJDVkZn?=
 =?utf-8?B?cmUyaXY5QlhpR0hFZTBoelhBZHlKSEFMb3Z2V1BzN1NuWUZsUUlZNHp4MVhS?=
 =?utf-8?B?dzJ4bVhtQWVJUzBFZVpGY3R6Ty9vSk01b3lxVWRNaFpaZ0sxY1lDN0JYQ1Vs?=
 =?utf-8?B?YmxWbWl2b1ZFR1lSSG0zaEZLeVFBdGxWQWp2UUorSWRnekxlckl1Z0hmbEpW?=
 =?utf-8?B?UFlYa3lCUzhqSGp3NCtXQVh4MU4yRlZLZ1QxdGhyU2tGVGtpWWtKaWZIajhI?=
 =?utf-8?B?dTlEQ2UyRUp2Ty81bWEzektnU3l4RHpIVlRlVmpYemRETnArOWxzSktsaTVU?=
 =?utf-8?B?eXlZVjhJVFlscWo4Q3pzNVAyQkdHNDZ6bTNDWlp6bUdhVVFKSElhU3FiTSti?=
 =?utf-8?B?UjRNWXIrZG9zSHlZR3NhTWpMZEh0L01rTWlsTzNNdDhCUEdvR25rUjFJdVoy?=
 =?utf-8?B?ZUgvcm5nUWpuL0UrSXZoaWtkRXpiUzdDL3ZSMnlJRHd2eFRuWTBCRHVQMGp4?=
 =?utf-8?B?L3lxSHBRbkkrOXRpYldlZTJsbG1kSVNtMkMzVEZDeklJc01MN0h4L0pCaTJt?=
 =?utf-8?B?RXY1NUJTUWRWQTNCMW9aMWcwcFdETU1wcEc1RFAxdExCTXoxbjNSVHZBUUM4?=
 =?utf-8?B?WlBRRnY4akJtTUVEK3hrSGR4aWl1aHJPdWhHWjR5cUdKVEI0eUhBMktFTnda?=
 =?utf-8?B?QjJzcDBNRnZ2Zm9ydnFWTlJkTTJiVmJSSzJiQkVlRGxSUTRXSUZwNERRL2Z4?=
 =?utf-8?B?YmJ2SEZKTTJNTDZJNW9yZ0xFWGVldlh2dmdmYjNCdWN3QTFOMDBLalpIVndl?=
 =?utf-8?B?OEtKdkczS28vQUtjMXZTTFBiWjgwT0FsbnhFbG54aDRPNWZiZlV2WENJVG1C?=
 =?utf-8?B?L09pUlJ5MXBiTzRac0VnSFl5QU1pTzB6c3BVakNudmlPYmh2Z09TZ3lUTitv?=
 =?utf-8?B?T0JQdnQwZTcxWTBFdFArOEM4WkExUmYxQUxpbWZCVXBhQnhDR08rUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZBcuSzNn7jI9zTp3TIsH/rKVzTWyQZzC+LF8l18dpTAw2eU+0L6xXC2HLxHnSKr/j0kNKJ7tOrtfKZhEjb6tSUFnSMnvHU86FjNLSq35AMGNRPFPQ7o/20oq6zvdI3r2vjS5LvvbVxCt5KH3wMfkd8G393zNTXMQkYl2MZdwSOitAE24iI2m5MFkZEdhlas0RMHg6kWMoMN5T6i05q0PkKhAM9qGZTAYTvhTUyGTzoSu+vJDY2Yygvpwn/ln9nwZ/SAkKrYPitxHoNiLN7nBDoLLhsHPmi9hR2Db19ZdxWM5/vfWr+LJauuTMhFh4hy+/nxwimQT2Tn6gUcDZvqvcQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 410ba5df-4095-422c-07db-08df2418ec12
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 02:15:56.8113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6LXawfwxN96b9qDByrVqYkxXb4h57SLiLOTMWNXubPS/Psxfx1jcdw/dSdQmnGsjPNN/l9M4GaeXwLUCdby0p1CTPef0Aw2Jy4C595gISgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6949
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgTWFyYy1BbmRyw6kgTHVyZWF1DQoNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody91c2Iv
cmVkaXJlY3Qtc2VydmVyLmgNCj4gPiBiL2luY2x1ZGUvaHcvdXNiL3JlZGlyZWN0LXNlcnZlci5o
DQo+IA0KPiBXaGF0IGRvIHlvdSBuZWVkIGEgaGVhZGVyIGZvcj8gSWYgdGhlcmUgaXMgbm90aGlu
ZyB0byBzaGFyZSB3aXRoIG90aGVyIHVuaXRzLA0KPiBiZXR0ZXIga2VlcCBpdCBhbGwgaW4gLmMu
DQo+IA0KPiAtLQ0KPiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0
LmNvbT4NCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24gYW5kIHJldmlldy4NCg0KTm90aGlu
ZyBlbHNlIGluY2x1ZGVzIGl0LiBUaGUgbWFpbiByZWFzb24gZm9yIGhhdmluZyBhIHNlcGFyYXRl
IGhlYWRlciBmaWxlIGlzIHJlYWRhYmlsaXR5Lg0KcmVkaXJlY3Qtc2VydmVyLmMgaXMgYWxyZWFk
eSBhYm91dCAxNjAwIGxpbmVzLCBzbyBJIHRob3VnaHQga2VlcGluZyB0aGUgc3RhdGUgc3RydWN0
dXJlDQphbmQgY29uc3RhbnRzIGluIGEgc2VwYXJhdGUgZmlsZSB3b3VsZCBtYWtlIHRoZSBjb2Rl
IGVhc2llciB0byBmb2xsb3cuDQoNCldvdWxkIGh3L3VzYi9yZWRpcmVjdC1zZXJ2ZXIuaCBiZSBP
SyBpbnN0ZWFkPw0KSWYgeW91IHN0aWxsIHByZWZlciB0byBrZWVwIGV2ZXJ5dGhpbmcgaW4gdGhl
IC5jIGZpbGUsIEkgd2lsbCBtb3ZlIGl0IHRoZXJlIGZvciB2My4NCg0KVGhhbmtzLA0KSmFtaW4N
Cg==

