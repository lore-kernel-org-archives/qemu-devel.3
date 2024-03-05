Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25F0C5478C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 03:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhLts-0001jH-5d; Mon, 04 Mar 2024 22:55:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rhLtm-0001ir-8o; Mon, 04 Mar 2024 22:55:26 -0500
Received: from mail-eastasiaazlp170120004.outbound.protection.outlook.com
 ([2a01:111:f403:c400::4] helo=HK2PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rhLtj-00023T-Am; Mon, 04 Mar 2024 22:55:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBz9JCK2oCwJ8o1Icw/QUP8VUsgPNzivyhMhoJlSEBal/Y30Hef7uIFStui5I08K3hdDICnW9vHicjPwSkfh2MLwI/FOhQb6DVUzNOmxjSkOAfIPXLaFYhG7X8cw/p98mkGEcVfr+zoKp5gDilJkKHKLe/4PYKzp2fFvu2aGTUzv8Ms+ZHGlZEAKzPGSEQvqG98mKZex42DwARIfWQF9bmRiOm7EKVFdibznoRR8zCsqryonlXuBghCtYFjF50sdPa+fghx6AKe8+g3pziJPHpXfa1T50gyWNxCRxxyZYH+QunfOrXwvcTFzA6z1PBumQdm+GQgrH+x1zHpW03dT0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIkvxHjuG6h4NCzdz2WiKc7uhe6oP+IKX8YvbP6vMxU=;
 b=PMUttosaXhr1mBPCmDIIZvKeVDnnzXUkQD6QF0grh1zdr9pXziCYDq/eKEaYG+m3AffeHeiA1p+zhDhOs92KCAnXefuXACzfneO2Un+k8Ef5kbQ6lGOVZBNqphBtqfUtSSrYMEjrz2OhvGT53m6Dcw70Ejg10CAkjQkQEa8/gTHDnrLmp0f03HMvUx36PHEgt15V2j9DqKIcrJWbB6qPfbAD6HUIDWGwNmEN6vpJ7Nz55WYhcg73pxsyDMh8/2J0FOaIvURuJz+YKnw++SrYDyNWa02rr6iod9CJCrVyI2pam4U/wMJ5KeRpHaAtmQz44vJMEUa3uWOp3K1eGT4fMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIkvxHjuG6h4NCzdz2WiKc7uhe6oP+IKX8YvbP6vMxU=;
 b=i03Oe2++vsYyIlX6NU/1eeHtcTjsHLKfX9gaHmJomvf+cONMDsu/uGG+e/1iiDhVl/ryEb1wHcaheq6jerT2sZyiwJbRPgil4BS2MfNUrbnmSpSOMpCXumr/dVddef4m6I8vu9gbakauFM7pOSoU0fdR4Mg0Vy1a3Y3OBg1+LAJRD1yi5VLytDGCXcyK4ijkepdsZ7fTcG5V5WoR7Yc/YRG5yAUJNEsrfougjcrvXWcV7HYCjyomKkmAnKlIgf+PQsCFDTlyPdAbBAXwchhZTkjgT7DcWUqOGgaQ+k70sbovQTdyha3NX5Y4mOG3amgrhzU9jOnoLYc6/2+w4kTRrQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SI2PR06MB5315.apcprd06.prod.outlook.com (2603:1096:4:1ea::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.38; Tue, 5 Mar 2024 03:55:14 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::14c9:526b:24b5:109d]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::14c9:526b:24b5:109d%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 03:55:14 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 7/8] aspeed/soc: Add AST2700 support
Thread-Topic: [PATCH v1 7/8] aspeed/soc: Add AST2700 support
Thread-Index: AQHaauAvnztD9ipc7Ee56KgMUCRZ/7EhECCAgAd7cWA=
Date: Tue, 5 Mar 2024 03:55:14 +0000
Message-ID: <SI2PR06MB504193A8F26C1C44B293F398FC222@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240229072315.743963-1-jamin_lin@aspeedtech.com>
 <20240229072315.743963-8-jamin_lin@aspeedtech.com>
 <01a71754-e278-439a-aea7-439c0bc26722@linaro.org>
In-Reply-To: <01a71754-e278-439a-aea7-439c0bc26722@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SI2PR06MB5315:EE_
x-ms-office365-filtering-correlation-id: d4e81dc0-ed9e-4b11-44d4-08dc3cc81070
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: noGfpQl8QP46WejktBEAIFI8uBUqa4RjSKKpgETNT+UYK4dzSPQfF1UI5VW/DbJN2OrzWMLK6TCCVlTWy9uHAx7dUtwLx9jXFUMP19tZtTEdvrugPETBELhBQMVx7A/yq3bdG75WpUQDNZV2lmwPfVCJPo2ZbpBlk+6Ja6E7BasSNMCsP04blhDG9ZRFIuvjOMxiN/BHSQglVqYLHJQPz/Sln/fn+C9IM9p08MhoO7ZkhEttW3Wh/mLos5yibvbBW9Icsm704JC3mnudFlVR9trPUqAHOKg+vzfvhNZEeHd7eDL5RpKlqAJ+jFoj5ztwCC8LIbrMLAxOEKaFMtfyoKxtVgmWxGVi40xBFNlMlRVH3R21njfq5I4+yPyrCniuRxDzZUDf9c3Vsu91e6sb92HcnAO0q5V9MVI/tfBGMvvyXFTlE18rV6YuLWPVLch1YDvTtJewxISn87BpCS2M4J9xI8PSARULs46f9Ti2Z6qgut+nmpJO03g9yRsFLUFh73A5OZo62PwdCGDsjQxbYwAkSatp51dDb8LBE+cl9TU11ZwpTzzZcI1q47uOV3NONUCcXxLoppaNB/fvTr6rdWfqcAsGTR8BqsruIfgNVxuI5E3ifz6RjC7a2yPU67aog7RoJukoB0Lpjj4vHPv59yKumnARQ4hFvvofEu1e2Ps=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aStqTXhyVlFaMHF4RjNRcHRyUCt6MyszeW9XejRNN0F1VUY1KzVKb0NEcmxw?=
 =?utf-8?B?elZqZ2wrLzg2bEI2L284TGpTdFQ1ZXArM21XSE1idmtKR1J1UTB0TEd0aHB6?=
 =?utf-8?B?NEoxam8rMlEyWmR2R0x4dUJVTXNZNGU3Q1ptN3ZxYTFoTkdZOXpjTXowVDhN?=
 =?utf-8?B?a0xqbVU0RElKR3BsUFlHcHlSaE1MWFNPOFVMZ3puT3M1dzdXaklSMVk2YzhB?=
 =?utf-8?B?d0lnYnpvSDZpN1poZThLMkhOd0RNQXd3MGw4djJLUkU5OTVDZ0dwWWlHRUVH?=
 =?utf-8?B?REZ1dVo1M1k0cVVURVhYVXZYMm1ZeWdUNlZGV2dMa0FXdzQ3bnJ2emtZTWEw?=
 =?utf-8?B?YVBHbnVGVEQ2ZGhyOG9sRjRLRjBBbzgvRkhKNjRLeVNVYk5TdCtnZzgvckhz?=
 =?utf-8?B?alZPMWxLc2creW9xSnQ0MHVndUdUN2MrYVc4Q3M2bW9CZzB1TXV0am9XWXdm?=
 =?utf-8?B?clk2blY3TWJZWlNIZkRvZWRnYUNKY1BuelQ4VGFCSktOVWpJS1pPbVZ6ZHdU?=
 =?utf-8?B?LzBSeVpibUkzdUtjUjZnRExuWC9OeThzNnY2WS9zTzVKQ1B0UU4zUlJIMHFr?=
 =?utf-8?B?bi9ib2pqMHVUU2pzd0Y2OUExUkU2UVlaaUk2dG44bXA4ckRZcks1UExMK1hj?=
 =?utf-8?B?aExqUWdOSDJ2QklVM1JBNXh2cXA4bmNlZlYxaDBNdXp4M3E4c0tWenkvSXdZ?=
 =?utf-8?B?ZTFtRUNaUDY2NndRTEJ4ajRjVnpta1h3NXNOVlpEeTM1aG9hZEt5VTVrMVpW?=
 =?utf-8?B?d1VNLzMydHFrSmdZMnR3aDl6Ykl6TXhYNXh2MkFJRzRkSVRoR2FPL1V2cVU5?=
 =?utf-8?B?a3BLNzNOd3lMelNQZWEwZVlYWWd5ckxQN3FVdEFGUTNhVkV3ejk5OU4wdWo0?=
 =?utf-8?B?SEUyL1Y1RGdmZHBPYTZkN0NQL0ljTjJkZmI4aXdqRTRUMitBVFV6ZTNweUNp?=
 =?utf-8?B?ZnJPc2FhNmI0YkRLNmcxTWxwamErSTRzWm5yekFkaGRoY3FtSjBHOEtjSkpj?=
 =?utf-8?B?OTFOQ2VDWTF3L3dsUy9UMGhHRDlRVkZRV1ZNbXJoa0dFTmc4UTl5aVlOejhr?=
 =?utf-8?B?Q0xEVVRGMTQrYUxlUDJ3Skt0TUhNbmpTam5jeHRGQTZsd1JEeEZPdXJrQjRh?=
 =?utf-8?B?UGNpU2lNVjhES000UGloR1ZkWHZTT0hycGZ6WVYwb2ExVG1Oc1B2SThuNzVS?=
 =?utf-8?B?cGdlL0Z3ZlZwb0d1Y2R4U0d1SjlPb0FlRzhBY1IwTFhrSXZielUzbkYrM3hq?=
 =?utf-8?B?ODl4NjQza2VlTVk5U3haQnRTVzdlNW5nL1FvQ3ZwRWwzdjRTTHNMZXFpMER5?=
 =?utf-8?B?M1h5MWdlakFlMHhpMUhvZ2VTQnFYS1daRmVDOE1Mb2FFcEtxaE9zaFg2S09G?=
 =?utf-8?B?Nkp5UEpPNE1GTTYwbGZqTnVlOXBzNlJqMjlPTkR3aG9TSEVZMC9aL1ZSTkpa?=
 =?utf-8?B?WHgzVE1JNHQ1V1IyK09lQS82UkxPcFd5YlBwK3NUYlRlUXcxMC9RWHhtN2hW?=
 =?utf-8?B?am96UTVtUGhKMHJKV1VKT1FxM3lVUTZxZHNKbzIxNmFTb0g1T1FaaG1leDhR?=
 =?utf-8?B?ZHhzeU1BdHVqNWhvTFFYV0wyWFpFZE9vQkdLNUtBeURYS1NrczFGNGVvWlZ3?=
 =?utf-8?B?QUxkeW82VVhNR2xKbjc4cXNvMnJ1NXJ5aGhsaW5heWREUzRYZndTcUxoUHZK?=
 =?utf-8?B?V0tkcExhdmxnNXMzNzZCWGYxcEJQTEE5QkxFZzY2QU1aS0pLSzJSZExqVEF6?=
 =?utf-8?B?VkVrcWpVVkRrYXNncEFRZWl2S203akpGcGY0bUkxS3lncG03UWZHRkJScWdF?=
 =?utf-8?B?OVhHdUxuOEFvRWVlTTR0ZUNRWTlYT2lCYlB2ZnNMQXlCdkwrNGR0cnl6QjVM?=
 =?utf-8?B?TnZKaU16L2hHZkpnbVd0ZnNhYUdQaFl1T3JBS3ZGSG1SYldqeGtJWjdRUVZE?=
 =?utf-8?B?NW5GSUVWeEtJc2hBaGt3eUJ2Z255QURIcEtUVkVoNGVTUGdrWWR1bmd6VG1N?=
 =?utf-8?B?Sk1xVUJuVEZrYk43RnpnenhKVnk0SXYrclFaejJ1dHRPNGhDUWJMQW9MbEZR?=
 =?utf-8?B?dWNzOGdwc0dtVnBSbUFIVkZUNjBSWkdDbDBUWFlYZGJPeUIyRlVCM0ZHc2pm?=
 =?utf-8?Q?mLiagr20KrtYLlq1CcdzABQhV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e81dc0-ed9e-4b11-44d4-08dc3cc81070
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 03:55:14.6319 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 44OWxOVZ+Kko6Fxfy7OTMwoDpcq44Ub0g3Y5jpipbrVD1eUngHAQyslT45synKiFK2OUrwScVRhU+ilpk+ukWBLAK0oNpHxXOtDUyzi3210=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5315
Received-SPF: pass client-ip=2a01:111:f403:c400::4;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK2PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaGlsaXBwZSBNYXRoaWV1LURh
dWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSAyOSwg
MjAyNCA1OjM4IFBNDQo+IFRvOiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47
IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+Ow0KPiBQZXRlciBNYXlkZWxsIDxwZXRl
ci5tYXlkZWxsQGxpbmFyby5vcmc+OyBBbmRyZXcgSmVmZmVyeQ0KPiA8YW5kcmV3QGNvZGVjb25z
dHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47IEFsaXN0YWlyDQo+
IEZyYW5jaXMgPGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+OyBvcGVuIGxpc3Q6QVNQRUVEIEJNQ3MN
Cj4gPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBvcGVuIGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZQ0K
PiA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KPiBDYzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVl
ZHRlY2guY29tPjsgWXVubGluIFRhbmcNCj4gPHl1bmxpbi50YW5nQGFzcGVlZHRlY2guY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDcvOF0gYXNwZWVkL3NvYzogQWRkIEFTVDI3MDAgc3Vw
cG9ydA0KPiANCj4gSGkgSmFtaW4sDQo+IA0KPiBPbiAyOS8yLzI0IDA4OjIzLCBKYW1pbiBMaW4g
dmlhIHdyb3RlOg0KPiA+IEluaXRpYWwgZGVmaW5pdGlvbnMgZm9yIGEgc2ltcGxlIG1hY2hpbmUg
dXNpbmcgYW4gQVNUMjcwMCBTT0MgKENvcnRleC1hMzUNCj4gQ1BVKS4NCj4gPg0KPiA+IEFTVDI3
MDAgU09DIGFuZCBpdHMgaW50ZXJydXB0IGNvbnRyb2xsZXIgYXJlIHRvbyBjb21wbGV4IHRvIGhh
bmRsZSBpbg0KPiA+IHRoZSBjb21tb24gQXNwZWVkIFNvQyBmcmFtZXdvcmsuIFdlIGludHJvZHVj
ZSBhIG5ldyBhc3QyNzAwIGNsYXNzIHdpdGgNCj4gPiBpbnN0YW5jZV9pbml0IGFuZCByZWFsaXpl
IGhhbmRsZXJzLg0KPiA+DQo+ID4gQVNUMjcwMCBpcyBhIDY0IGJpdHMgcXVhZCBjb3JlIGNwdXMg
YW5kIHN1cHBvcnQgOCB3YXRjaGRvZy4NCj4gPiBVcGRhdGUgbWF4aW11bSBBU1BFRURfQ1BVU19O
VU0gdG8gNCBhbmQgQVNQRUVEX1dEVFNfTlVNIHRvIDguDQo+ID4gSW4gYWRkaXRpb24sIHVwZGF0
ZSBBc3BlZWRTb2NTdGF0ZSB0byBzdXBwb3J0IHNjdWlvLCBzbGksIHNsaWlvIGFuZCBpbnRjLg0K
PiA+DQo+ID4gVXBkYXRlIHNpbGljb25fcmV2IGRhdGEgdHlwZSB0byA2NGJpdHMgZnJvbSBBc3Bl
ZWRTb0NDbGFzcyBhbmQgYWRkDQo+ID4gVFlQRV9BU1BFRUQyN1gwX1NPQyBtYWNoaW5lIHR5cGUu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5j
b20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5j
b20+DQo+ID4gLS0tDQo+ID4gICBody9hcm0vYXNwZWVkX2FzdDI3eDAuYyAgICAgfCA0NjINCj4g
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICBody9hcm0vbWVzb24u
YnVpbGQgICAgICAgICAgfCAgIDEgKw0KPiA+ICAgaW5jbHVkZS9ody9hcm0vYXNwZWVkX3NvYy5o
IHwgIDI2ICstDQo+ID4gICAzIGZpbGVzIGNoYW5nZWQsIDQ4NiBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2FybS9hc3BlZWRfYXN0Mjd4
MC5jDQo+IA0KPiANCj4gPiArI2RlZmluZSBBU1QyNzAwX01BWF9JUlEgMjg4DQo+ID4gKw0KPiA+
ICsvKiBTaGFyZWQgUGVyaXBoZXJhbCBJbnRlcnJ1cHQgdmFsdWVzIGJlbG93IGFyZSBvZmZzZXQg
YnkgLTMyIGZyb20NCj4gPiArZGF0YXNoZWV0ICovIHN0YXRpYyBjb25zdCBpbnQgYXNwZWVkX3Nv
Y19hc3QyNzAwX2lycW1hcFtdID0gew0KPiA+ICsgICAgW0FTUEVFRF9ERVZfVUFSVDBdICAgICA9
IDEzMiwNCj4gPiArICAgIFtBU1BFRURfREVWX1VBUlQxXSAgICAgPSAxMzIsDQo+ID4gKyAgICBb
QVNQRUVEX0RFVl9VQVJUMl0gICAgID0gMTMyLA0KPiA+ICsgICAgW0FTUEVFRF9ERVZfVUFSVDNd
ICAgICA9IDEzMiwNCj4gPiArICAgIFtBU1BFRURfREVWX1VBUlQ0XSAgICAgPSA4LA0KPiA+ICsg
ICAgW0FTUEVFRF9ERVZfVUFSVDVdICAgICA9IDEzMiwNCj4gPiArICAgIFtBU1BFRURfREVWX1VB
UlQ2XSAgICAgPSAxMzIsDQo+ID4gKyAgICBbQVNQRUVEX0RFVl9VQVJUN10gICAgID0gMTMyLA0K
PiA+ICsgICAgW0FTUEVFRF9ERVZfVUFSVDhdICAgICA9IDEzMiwNCj4gPiArICAgIFtBU1BFRURf
REVWX1VBUlQ5XSAgICAgPSAxMzIsDQo+ID4gKyAgICBbQVNQRUVEX0RFVl9VQVJUMTBdICAgID0g
MTMyLA0KPiA+ICsgICAgW0FTUEVFRF9ERVZfVUFSVDExXSAgICA9IDEzMiwNCj4gPiArICAgIFtB
U1BFRURfREVWX1VBUlQxMl0gICAgPSAxMzIsDQo+IA0KPiBXaGVuIG11bHRpcGxlIGRldmljZXMg
b3V0cHV0IElSUSBsaW5lcyBhcmUgY29ubmVjdGVkIHRvIHRoZSBzYW1lIGlucHV0IG9uZSwNCj4g
YSBJUlEgT1IgZ2F0ZSBoYXMgdG8gYmUgdXNlZC4NCj4gDQo+IFNlZSBwcmV2aW91cyBleHBsYW5h
dGlvbnMgaGVyZToNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC81YTc1OTRk
OS0zZmJkLTRkOTAtYTVmOS04MWI3Yjg0NWZiYTdADQo+IGxpbmFyby5vcmcvDQo+IA0KVGhhbmtz
IGZvciB5b3VyIHJldmlldyBhbmQgc3VnZ2VzdGlvbi4NCkkgYW0gc3R1ZHlpbmcgdGhpcyBkZXNp
Z24gYW5kIHRoZXkgd2lsbCBiZSBtb2RpZmllZCANCmluIFYzIHBhdGNoIHNlcmllcy4NClRoYW5r
cy1KYW1pbg0KDQo+IChQcmUtZXhpc3RpbmcgaXNzdWUgaW4gYXNwZWVkX3NvY19hc3QyNjAwX2ly
cW1hcFtdKQ0KPiANCj4gPiArICAgIFtBU1BFRURfREVWX0ZNQ10gICAgICAgPSAxMzEsDQo+ID4g
KyAgICBbQVNQRUVEX0RFVl9TRE1DXSAgICAgID0gMCwNCj4gPiArICAgIFtBU1BFRURfREVWX1ND
VV0gICAgICAgPSAxMiwNCj4gPiArICAgIFtBU1BFRURfREVWX0FEQ10gICAgICAgPSAxMzAsDQo+
ID4gKyAgICBbQVNQRUVEX0RFVl9YRE1BXSAgICAgID0gNSwNCj4gPiArICAgIFtBU1BFRURfREVW
X0VNTUNdICAgICAgPSAxNSwNCj4gPiArICAgIFtBU1BFRURfREVWX0dQSU9dICAgICAgPSAxMSwN
Cj4gPiArICAgIFtBU1BFRURfREVWX0dQSU9fMV84Vl0gPSAxMzAsDQo+ID4gKyAgICBbQVNQRUVE
X0RFVl9SVENdICAgICAgID0gMTMsDQo+ID4gKyAgICBbQVNQRUVEX0RFVl9USU1FUjFdICAgID0g
MTYsDQo+ID4gKyAgICBbQVNQRUVEX0RFVl9USU1FUjJdICAgID0gMTcsDQo+ID4gKyAgICBbQVNQ
RUVEX0RFVl9USU1FUjNdICAgID0gMTgsDQo+ID4gKyAgICBbQVNQRUVEX0RFVl9USU1FUjRdICAg
ID0gMTksDQo+ID4gKyAgICBbQVNQRUVEX0RFVl9USU1FUjVdICAgID0gMjAsDQo+ID4gKyAgICBb
QVNQRUVEX0RFVl9USU1FUjZdICAgID0gMjEsDQo+ID4gKyAgICBbQVNQRUVEX0RFVl9USU1FUjdd
ICAgID0gMjIsDQo+ID4gKyAgICBbQVNQRUVEX0RFVl9USU1FUjhdICAgID0gMjMsDQo+ID4gKyAg
ICBbQVNQRUVEX0RFVl9XRFRdICAgICAgID0gMTMxLA0KPiA+ICsgICAgW0FTUEVFRF9ERVZfUFdN
XSAgICAgICA9IDEzMSwNCj4gPiArICAgIFtBU1BFRURfREVWX0xQQ10gICAgICAgPSAxMjgsDQo+
ID4gKyAgICBbQVNQRUVEX0RFVl9JQlRdICAgICAgID0gMTI4LA0KPiA+ICsgICAgW0FTUEVFRF9E
RVZfSTJDXSAgICAgICA9IDEzMCwNCj4gPiArICAgIFtBU1BFRURfREVWX1BFQ0ldICAgICAgPSAx
MzMsDQo+ID4gKyAgICBbQVNQRUVEX0RFVl9FVEgxXSAgICAgID0gMTMyLA0KPiA+ICsgICAgW0FT
UEVFRF9ERVZfRVRIMl0gICAgICA9IDEzMiwNCj4gPiArICAgIFtBU1BFRURfREVWX0VUSDNdICAg
ICAgPSAxMzIsDQo+ID4gKyAgICBbQVNQRUVEX0RFVl9IQUNFXSAgICAgID0gNCwNCj4gPiArICAg
IFtBU1BFRURfREVWX0tDU10gICAgICAgPSAxMjgsDQo+ID4gKyAgICBbQVNQRUVEX0RFVl9EUF0g
ICAgICAgID0gMjgsDQo+ID4gKyAgICBbQVNQRUVEX0RFVl9JM0NdICAgICAgID0gMTMxLA0KPiA+
ICt9Ow0KDQo=

