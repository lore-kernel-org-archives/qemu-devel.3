Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5761DC624CE
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 02:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Dpi-0007ww-Qp; Mon, 31 Aug 2026 22:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1Dpf-0007vC-Fx; Mon, 31 Aug 2026 22:02:39 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1Dpc-00065p-Vj; Mon, 31 Aug 2026 22:02:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edZJzqSKXEfLj2hea/WV2dRRuippXBwqV63G9HPsQD1imf5BhZJhDmSi+SRczSoUXC1iiSO7ieyWx0FTKPSPNqTFDfTNDLSaKpIjkJyAGy9FaYBWy1cORQOqbo1EUaSUv6mBLq7ObX8oWT8UK/hOdmFeSP0FbYHar7jJAwBbdIGNqU/V41fds6WpVlwFXmje0/hvn2QE/ucEEl+HfGkeaKE60Op4GlskjQzuEY2XcnwXEPNEFuVXW6gzZq5zaJw/7Zu38ioWRbSUjvjezq42vTnFWDCFV3+P3xKx9eYSr0llgh8Q0Ps8FS7AzMUkNt9C6AbktmXM9rCKyYTcltfUHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmcIpQaNitcXsyREh/XnDqBUGD/8PQ7DQz5sFfRqUM4=;
 b=xN9hmonTlcL7Gr3xHHfUsIFhJdVy2AvEfAVpifaHzvstszkf08X7PP0Hzc9NjZRRLnDR6x4UuV9ca6/QbtCyoEjEE4Cu+sJC51AAorht/agV1YMmDhMFQWGsZTB1shbdmDmZnpUAwIGYvDs0ZoNuMUZyjq42r2hU/2BZ0GA83tMJ/EVefiTwk9imd0cANjwUyvFdvfHSX3m7Ymah6cFxxexOWjWqP0y2OUBuiKZWdhFiX5XF7NAvp5u7HT6JjBcULD600KIVl99ceQFLQPzszZSaiF7W47qgb85mndl99/DutHU9mY3kFc3h1FQitboI/d5TTRSRYRq+FfMW/x+xLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmcIpQaNitcXsyREh/XnDqBUGD/8PQ7DQz5sFfRqUM4=;
 b=OcVA1FEK/kBJWjzZZczaVjloTcY4t8xRvZ47WIXpRJ/MIZxoYZ+L4Pvek1QIftqRxqBRoZJkaKH22VKLHR13nxtxCbn87nMrvkfQQFZSqExb5jIp7kjbYvorxMYchqP7PY2Xnz8ec3o7u3rzzJyGhNItA9ICIzjOAtciQksRvm9wFFLnralfC28+2n9P/hN7v83VSmFubnq/29egxbaixP5NkbTo1OehAk/HFwt7dnok1SAvJotiXD29ECTyPQOAIpDNQh1ZFCjf+/KgYAFqSNnavnkmYbj8zJP9xUMQrVvJbV8HjVbx5gWTUjs9FJGQ86eE2EoLARqCwQhZsbY+XQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB5039.apcprd06.prod.outlook.com (2603:1096:101:53::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 02:02:25 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 02:02:25 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open list:ARM
 TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 1/4] hw/usb/aspeed-udc: Add ASPEED UDC device controller
Thread-Topic: [PATCH v3 1/4] hw/usb/aspeed-udc: Add ASPEED UDC device
 controller
Thread-Index: AQHdOSoZ2J5PzhCKA0WJEJsAkb27yra37auAgAELtkA=
Date: Tue, 1 Sep 2026 02:02:25 +0000
Message-ID: <TYZPR06MB498032FED60DF9F1416B7197FCA82@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260831092125.1022201-1-jamin_lin@aspeedtech.com>
 <20260831092125.1022201-2-jamin_lin@aspeedtech.com>
 <ff5c148e-d187-4d97-aeb4-6ab5448f79e6@oss.qualcomm.com>
In-Reply-To: <ff5c148e-d187-4d97-aeb4-6ab5448f79e6@oss.qualcomm.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB5039:EE_
x-ms-office365-filtering-correlation-id: 41c87406-9329-43f6-989d-08df07cd1193
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|921020|38070700021|6133799003|3023799007|10067099003|4143699003|5023799004|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: XYu3Hb8LRcIPgVaDlu9CbwaSvphCOdomCiHiznWP2Vvr369WkfgTmiDzpRyTh2YYfkWeGLspzqbr4g2o/qntjSHnnyGY99eMaPB9b9qEuWZoN2D+OV2AFAt+chetcrOhGXswYKVsRBBKp3HN8HStQNCJEFk7UTnhVsMwCLhhmYThxz+R4T5RFxJHLCNwsVfd4fnUytNOsMAV0vFjTIX5zyL8nZ0v1oFBr7ojt9xMqfKKXQqpFn+XChj4YrZu+FM/pZAUd9XA2Ho1iqA6a1kZegQQsEpFRdQbJNLTrhawvyfb8WuOXx/9fHGOsyt+8WmvlUptEq6s+1fmFK/QNcjXqk7XtiNOYTlCChuvyM5yaP+RgeH96VgEvfHrsX3Ks/Cq/NcVknGaeAIDzY9bK50byGKESBJG9JG9ZA6ocPs6hhWY96Vl8q2cOm0auChO6roJ484UcyRb8Q9pFGkJvFL2km4x3mwWVf/8OvyE6aM1TC5Y7G1CFcpv/Ch3cEPh2P69rKgyoKuP0XFc04i9sHz/+fMGVvvbUXusgqfqDb1t2EsW/TWvCL5tOlfXuxHoznp7KYukzOUUcyU4Xz3C1PzH0kU31Z8x6D7ie7XQMT3bFWUkwj1AXTvp0FDIeE4b4eGCzY4uXt8vdR4DVOsYgVca1IMpQYBg0eiEg9Z1Gt34stBwNYFSIBl8h4ZIH5oniSNir+Hc78jHMJgjI43LO2VdKG1ksWW1F6awe3GNLsJDWyg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(921020)(38070700021)(6133799003)(3023799007)(10067099003)(4143699003)(5023799004)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlpyUjF1NURwbThxTXFtVkt5WGhhS3NnaVpsWHJWN2ZIY3BNN081ZEsrbnF3?=
 =?utf-8?B?UkdEdXFIaHU0MkVYYnNFTEdrNStINXRyTXowT0NjZmI1eGYzYWJxZm5qWmhM?=
 =?utf-8?B?QWtabXE1V1greHZlRmxMMm9BR0liSkdKYzY2QTU4ZTVQRTVnZDdTbTBQTlpX?=
 =?utf-8?B?Tm9ScDBEMDEwR0FzTE9saGk1bDF3ZTIzQkxNMFVnMEkra05ZbW9yMHVHaWxY?=
 =?utf-8?B?UWxwclpSWkQwZmhPS1FGZzNmRjlWWmp2cnErb3hrc0RqZWJSWnlzTHRmYVl3?=
 =?utf-8?B?V05JSmltY2hPcE52aXVUME1UWkYzVFphN3lEcE15TTE4REdlS2hXM0xkMnRT?=
 =?utf-8?B?VlFOb0UrUVlRalI1MFJWcG11dGhiZEpjVTU1WlY2a3NRcWRDN21iUUxwWkEr?=
 =?utf-8?B?dkZIWkpnT2swcU4xSkhpeHpEQ0Q2d2JKV0N0UUJFbEk1K2hPZG93UTdRN3cx?=
 =?utf-8?B?d25CZjZITCsvVXdpTjMzMEtSZGFRRnd1NnhNRGxsSHJLZVlxWGx3MUJPc2F0?=
 =?utf-8?B?ejNISkdRL3BjWmhQQ2dYbkFvek92aW5vbWdqaGU2YVluNWU5S0NNNzk5R1NF?=
 =?utf-8?B?NmFySjdCZWNDMnl1djFjYXR1emVNN3BqS2pDUWF6dVl0ZDB1cEpHb0pURmVV?=
 =?utf-8?B?cVVHN2pSdklwck5VSEhRUGRRbjFxNVNjaGVKL1ZNWDB0VllMTTRRZGFXTzVM?=
 =?utf-8?B?UXU0VTB5dllubW5OQ3dDTW5PaUcvTzJGWmRSaUkwUURFckEyOWw5U3hDbnRq?=
 =?utf-8?B?N2ZDMEsxa29McldkTkRyc3dUVGgrUDdKbUpmaTAwc2dPM2xRam5LQk0zSWN0?=
 =?utf-8?B?MWVRZkdjcHR1Z3crelNPd2IyVHNWQ0c3OHEvcC9QcDMxcU5KK3E5czErQ0p2?=
 =?utf-8?B?WGcyelpOT1I4RnJKQ2NTbkQ1cWplSEV3YzJlRHorLzFCNmRSbGJXM1ZnekJY?=
 =?utf-8?B?cnlyeE1TdzV4NTlqM1BOTTBITjVBUnpFV2E3TnlwRmpYTjVxNkJrbHF0ZVg3?=
 =?utf-8?B?K3lScWEwMHEyYUcxKzNvSzRmRzN4ekNpUk9sMVA2YnRZdjh6MmJqUFVaOGhE?=
 =?utf-8?B?ZjYvcmczZDBQMWljeUFkNFNoaEtIb3BFdlU0K0ZiWWtCdE5hRks4RFdaQUZr?=
 =?utf-8?B?MVJJQnhHMGJMMkhrdnlZeG1lQlZvM05PNmdzSlFpTmNKTXdEVHBiTmdtWVhS?=
 =?utf-8?B?d2wvNzkwUHU5Ylp6dmprdmhBRUhMR2NFWDhwNGZaSndlWDI4WnVHSzdyL1pO?=
 =?utf-8?B?eHRZSXpQZ1VTZVBGN3pBUHpVZDgyVjh3WUNnSGtWclZkaEQ1enB3azJNOHJI?=
 =?utf-8?B?Z0crYTJzWE5hVm5JTTV2SG93UU1vSCs2N0ZqMFZYbW5oeVdybzdJWk5vOWpG?=
 =?utf-8?B?cGwrM3FEN203Y1Zkc0RoaEd5Y1EzSG5vVXc5RjBtclROb0NOL1hKaVQvbWNi?=
 =?utf-8?B?NWlnL0pTcUVHenZCSlV6VU5sYllKK0dJY2I3SzlKaURlaHhSaDEyNkY5MTBS?=
 =?utf-8?B?TjRwMGE0S0lrRXJjU3JjQW9yZVhqSU55VEw2TE5US01ZZ08zdTBKNnJmVm9G?=
 =?utf-8?B?ZDJ6NVhQZ1dKQk1pMXBKeWlSUTBkNmhRVWRYWFJyaGNIbzZ2QVp0eGFEUVdQ?=
 =?utf-8?B?NHhid3QrbE1uWXN6VjFncVFBSm9iWE9NOXdWa1p3bkY2d0k4NnRKZXVsaFFs?=
 =?utf-8?B?bTU3VFpJR3UyOVZlWFBsR1JQb25LUk5ESlRDRjU3TS9jU0Rzc3lESTJKb3lB?=
 =?utf-8?B?Tm1OZzlBMW84SzFFU1NkT1N1NkgxT1RVTVpMajdGN2syVEJLVXRSaFc5a2FI?=
 =?utf-8?B?UFhxZHJKdWVBOEVoKzY1SG5SZTlNMndYYllZOFhvOG9TZzduQ21FU2lmckpy?=
 =?utf-8?B?UERKSEhBRzNsYXF1aHZ0ZEE5OS9uRG82SXc5dnJtUzEyaG5RcXF6eGt4NlZt?=
 =?utf-8?B?T0hSSUprQjNFZjdoNzlCNTc4K0JLa2VPWEYxNUt3VDAxb01tcTA4WHVMSUhU?=
 =?utf-8?B?QzZoRWJ6eXU2SjRKZ2lKMXNBZjllQXp4UnB5T0pPRFlic2hPc3ZNcmVCSnp6?=
 =?utf-8?B?L0ViNm1YYkpNM092N1A2S01aKzFuRVdnTU84NTRjeG5Rb1FUcTJ5NzZ1UWxV?=
 =?utf-8?B?Q1BXclM1YkhQZ3FDK3ZDNitrZFY4a3M3NmdhM3VSek1XS0I1djFXYzM1MkRk?=
 =?utf-8?B?VVg5L095VmF3Z241N1VWd3ZYYnNmQmFUcnkzYWFrV0NhL0YwbFB6dSsvTTVH?=
 =?utf-8?B?QXNHTjBXNE1DZXFtSDNsZnlsbkZrT2xHUGlVYUxmQzRYQmJtODY5YS9QUmd4?=
 =?utf-8?B?NDlPcG5rdTZ6M0wwNUpOdmNoRmZqVTdyYlZJRDJSWFNTbjVJRmI2QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PEbJ8MF/gySq42kwRs3bYFzBsmbjUaxhfSXvSyA23utGAdR7GOR/NrKBlpKDBPZ+8kyfaachvxuQc3VUgysOjpNQ2u1PnlA4959ZtbkXcudYxf8ukV28nJDwMCqzKvENiuselaoJhiEZy5tHPhAFp5YblDJ9uel7rtgehkR0ecCEcKjcu9HxTQriRdpC25262/WVikN+ah0LJHuwCrgkZKqnCKva8VpJMcyxkVEo+GyxNPulqseg+uxXzuoypAS4JoCHmv0rt+GA9GOOOCNLEDUpXy2qGTx4GT0EefbMB2X2sDPUDiYlEv3fu1xH4jWTHXPSp9LB1wBGutSm36Ob3g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c87406-9329-43f6-989d-08df07cd1193
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 02:02:25.3871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: URrQDYq4trjjf4YO74ILNC4kJjKDjA0H+HAEEeEHvXTd944iXSExrb9/Ha2IYXrSOWjEHrcTpBtCVn0v5tY0qcFyfAcmonmbyDi5UqitLuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5039
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvNF0gaHcvdXNiL2FzcGVlZC11ZGM6IEFkZCBBU1BF
RUQgVURDIGRldmljZQ0KPiBjb250cm9sbGVyDQo+IA0KPiBPbiAzMS84LzI2IDExOjIxLCBKYW1p
biBMaW4gd3JvdGU6DQo+ID4gVGhlIEFTVDI2MDAgaGFzIGEgVVNCIDIuMCBEZXZpY2UgQ29udHJv
bGxlciAoVURDKSBhdCAweDFlNmEyMDAwIHdpdGgNCj4gPiBvbmUgY29udHJvbCBlbmRwb2ludCBh
bmQgZm91ciBwcm9ncmFtbWFibGUgZW5kcG9pbnRzLg0KPiA+DQo+ID4gQWRkIHRoZSBjb250cm9s
bGVyIGFzIGEgc3lzYnVzIChzeXN0ZW0pIGRldmljZTogdGhlIE1NSU8gcmVnaXN0ZXIgbWFwDQo+
ID4gZGVzY3JpYmVkIHdpdGggdGhlIHJlZ2lzdGVyZmllbGRzIG1hY3JvcywgdGhlIGludGVycnVw
dCBsaW5lIGFuZCB0aGUNCj4gPiBzb2Z0IHJlc2V0LiBUaGlzIGlzIG9ubHkgdGhlIHJlZ2lzdGVy
L3N5c3RlbSBzaWRlLg0KPiA+DQo+ID4gTm90ZTogdGhpcyAiZGV2aWNlIGNvbnRyb2xsZXIiIGlz
IHRoZSBzeXN0ZW0tYnVzIGRldmljZSAoVFlQRV9BU1BFRURfVURDKS4NCj4gPiBJdCBpcyBub3Qg
dGhlIGdhZGdldCBVU0IgZGV2aWNlIChUWVBFX0FTUEVFRF9VRENfR0FER0VUKSB0aGF0IGEgaG9z
dA0KPiA+IGNvbnRyb2xsZXIgZW51bWVyYXRlcywgd2hpY2ggaXMgYWRkZWQgaW4gdGhlIG5leHQg
cGF0Y2guDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3Bl
ZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGluY2x1ZGUvaHcvdXNiL2FzcGVlZC11ZGMuaCB8
ICA0OSArKysrKysrKw0KPiA+ICAgaHcvdXNiL2FzcGVlZC11ZGMuYyAgICAgICAgIHwgMjM2DQo+
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgaHcvYXJtL0tjb25m
aWcgICAgICAgICAgICAgIHwgICAxICsNCj4gPiAgIGh3L3VzYi9LY29uZmlnICAgICAgICAgICAg
ICB8ICAgNCArDQo+ID4gICBody91c2IvbWVzb24uYnVpbGQgICAgICAgICAgfCAgIDEgKw0KPiA+
ICAgaHcvdXNiL3RyYWNlLWV2ZW50cyAgICAgICAgIHwgICA3ICsrDQo+ID4gICA2IGZpbGVzIGNo
YW5nZWQsIDI5OCBpbnNlcnRpb25zKCspDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVk
ZS9ody91c2IvYXNwZWVkLXVkYy5oDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvdXNiL2Fz
cGVlZC11ZGMuYw0KPiANCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2h3L3VzYi9LY29uZmlnIGIvaHcv
dXNiL0tjb25maWcgaW5kZXgNCj4gPiBkZTk1Njg2NzIwLi5lOGMwMGY4MTNhIDEwMDY0NA0KPiA+
IC0tLSBhL2h3L3VzYi9LY29uZmlnDQo+ID4gKysrIGIvaHcvdXNiL0tjb25maWcNCj4gPiBAQCAt
MTQ2LDMgKzE0Niw3IEBAIGNvbmZpZyBYTE5YX1VTQl9TVUJTWVMNCj4gPiAgIGNvbmZpZyBVU0Jf
Q0hJUElERUENCj4gPiAgICAgICBib29sDQo+ID4gICAgICAgc2VsZWN0IFVTQl9FSENJX1NZU0JV
Uw0KPiA+ICsNCj4gPiArY29uZmlnIEFTUEVFRF9VREMNCj4gPiArICAgIGJvb2wNCj4gPiArICAg
IHNlbGVjdCBVU0INCj4gTm90aGluZyBkZXBlbmRzIG9uIFVTQiBzbyBmYXIsIHNvICJzZWxlY3Qg
VVNCIiB3b3VsZCBiZSBiZXR0ZXIgYWRkZWQgaW4gdGhlDQo+IGZvbGxvd2luZyBwYXRjaC4gT3Ro
ZXJ3aXNlIFFPTS9RRGV2Og0KPiANClRoYW5rcyBmb3IgdGhlIHJldmlldyBhbmQgc3VnZ2VzdGlv
bi4NCldpbGwgc2VuZCB2NA0KSmFtaW4NCj4gUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIDxwaGlsbWRAb3NzLnF1YWxjb21tLmNvbT4NCg0K

