Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1494CD8C90
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 01:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWPEL-0000NN-94; Sun, 07 Jun 2026 21:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1wWPEJ-0000NC-J3
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 21:56:43 -0400
Received: from mail-japanwestazon11010006.outbound.protection.outlook.com
 ([52.101.228.6] helo=OS0P286CU011.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1wWPEH-0004xZ-PY
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 21:56:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vE2Ch22yw/FudFQgqAM51eYQX+LFstC2xxho5gDBRnQT5Aj48mR35glVi9cCd8hhHtL3WNX/33R7w14vkoMlBf2xrVjRa40pQIRtmhvR3zFT/7pFNnKyDV+/XHV3VeY/btm3mseQY4Zlo2umd3T+ugiHi36SUkXJMKfY62pbCxikORHgF3pUi5o3e3s7aUIp0RtA869whslGI88VUNxWYpCvMiF7BoNM99JddIw0R9qk0DjUWo2MMVHQO3de2RLiPMYPtYh0R4O2HBGf3uwPnNkrd5iw5ZM6PmNLcocLmR8Sii9GfvJdIyBg823sA5jF5tjiACmIwvFTg6LfpouOwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHUWePzmrnGexB9xV3smmJKAqY4RR5kTfnoaz+s2Znc=;
 b=Jubpnf+5jutwpWQ9/lrTo9FwJ/bMUQNJVh8duJl2jWk5VYCiKN0f5Ov+ac37Bc/TxPoeVWbbgBC/8Zl1CtC68cy/S83c+tuVUBkPFUqqRhpzXroevswneN7LX2iYTC0gwW9pEusSL7PSlTMI7T9fAHtoPszNl3ZaWXtkDu4B/dfTqFOIeXJShlSFJBaUy6DcajNS3GrfJBXIaRFs/nS4Dq89eVNWTpueYxH1Ucwht0WujdEyIZQsEVbjE0uwiU9sLWcET4zmvLEFqUFEb/BavGr0rfuuO5ig3z44LJKGW6Eyn5ygfi6v9Jze9V1qo9f9PgA7Kn/N2eZAqRpTEQHPnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHUWePzmrnGexB9xV3smmJKAqY4RR5kTfnoaz+s2Znc=;
 b=cw9ukTIc42o9xRXXTHJx4sUKNkThdBjrS6FxNbNycyYs/VQ221WFClo+OavBN+RsJp5QRxVZcMVb2b9dRajvGsRWRynj80FwvLX2rNe2WrzuCytkjkGA97vH+hIm2Z0ZVqzrD/XbB5V9pJ0gPGwl5MZV7J1wW7/bM3Vl7vd6gwr3O/aPrAV+0ITX2aa6BhcnwLOvpodOwq5y66GH5MsbSmHuXvdrckU9FNMoVqYkGLg4krSyUsh1uu0bFEtI/b+78j+sTtP8ItHPrpiJ4PeNMxiUcIg8cTRFIfbpVoMNXqk+Ubu6zfRlZwltQdd7GrZVKEtauFWpf+Pw0//Yr4SXtA==
Received: from OS9PR01MB12148.jpnprd01.prod.outlook.com (2603:1096:604:2e6::7)
 by TYRPR01MB15948.jpnprd01.prod.outlook.com (2603:1096:405:2cd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 01:51:34 +0000
Received: from OS9PR01MB12148.jpnprd01.prod.outlook.com
 ([fe80::7a9a:2706:6589:5131]) by OS9PR01MB12148.jpnprd01.prod.outlook.com
 ([fe80::7a9a:2706:6589:5131%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 01:51:34 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Bin Guo <guobin@linux.alibaba.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 0/2] migration/rdma: fix blocking readv and zero-page
 accounting
Thread-Topic: [PATCH 0/2] migration/rdma: fix blocking readv and zero-page
 accounting
Thread-Index: AQHc7zlbiIhmXedfoUSJGDxMSUDrFrYz9DYA
Date: Mon, 8 Jun 2026 01:51:33 +0000
Message-ID: <c934b154-8b19-4f63-b70d-ecbc7b808df6@fujitsu.com>
References: <20260529070408.92651-1-guobin@linux.alibaba.com>
In-Reply-To: <20260529070408.92651-1-guobin@linux.alibaba.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB12148:EE_|TYRPR01MB15948:EE_
x-ms-office365-filtering-correlation-id: 74c4e427-6b5c-4789-44e6-08dec5007831
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|11063799006|56012099006|18002099003|22082099003|38070700021|1580799027;
x-microsoft-antispam-message-info: 6WA0EXVk7Hd41KmpUSHZJ2R5gKCnRL1xdQ+scQb96RwmzWxXY3SvBhwkTody3zHOsTdviz0YLKLEMMGUsNek7w2Mce4fP9ubbtwVwD6ys66TvsaLh4VVwbPisg8hQ/I9R76o33Ta62wNcIwEZF7XP4Qgdq+DSHw8AP7+ErO2aqe8Gii45sD1Ft9QnSaPLV8hEkI9vt9F0xjavjBErYqxbER8ZT0qh1KdoABpPlahRC53MfbX/Z2fNWA52sEUG0caSF+A4HXdSZDN001SkZsGRKOJ9l6da9+rSekqUQNiLgKm2CzMtYiLLRbSjtMXn5EUmO7LnM56+84SeGk7iL9v6qghWN8kGykCtsB+dtJqJCSrV7HduyXcD2z33qf/YJhLmRMFFsXzf2in7RL5HfYur863JVqFKa9acGhIhKBjdgqVHT3oTHiQO9xLWCmeCfcZlISx5wpp0jzo1GJJ9+dp6lY7JHmYcETXfCvMRWi6tEmutouhWzDgbuK/hQ3mjxZH1uTlT8bqpUFHI0mKckRSttctOmBWnEPsFEmnzWj6RtH07cbEJ+LUSEFnz9+4Y1dFImNfr0Fl1ZtKTlZMhhSHbEZ11syWVmwjiAOdspDwZNjhkc845TCQNBlZWGjF1GuveuLK3JXcSaIRlaf1FFScIZeA0gdJvDw5/Q81ji2PymZ0q9WfKG27Sywk0gP4Ox5FM9NwAJyFlMK5wUYcx9dMS/LjfUR9S3jIr7SmohM3LxVei2z46REDMj7T2aMT8zoY1muhnuGyg1cmDgKRYWPOlg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS9PR01MB12148.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEZoYlIrV09pU0lUdnJILzVkRjZZM3VxVGl0eFE1ZVlwNTdPTytWUTg1bDY5?=
 =?utf-8?B?OCswdWxERUVSR2tKR1c4cWYvM0xPN1RkbjN0QUE2ZElOdTZsNkRTYkZsM2Ji?=
 =?utf-8?B?SG1tY3h3RGpxZWY1bHlxUUM0d2FycGJ1azVQd1BLS2VsT2F2NnZlQVVTZ0R4?=
 =?utf-8?B?enNoWGNBam54R25pRVhFVWhBQ1NJcFhGaHhDdjd5WGJrWlhBU1IxUVhjcUZr?=
 =?utf-8?B?TGVybDJpM3kzNFNsNGFLRHBDK1VpOHR5SUd3MDg2eml6RXU3ZkFWbnVEa2hE?=
 =?utf-8?B?UVRuaElROWtvVHBRdDhYTkR4dFNyKzAzN2ZaaS95R2NBTjBRemE2VlE0L01u?=
 =?utf-8?B?dVM5QkxPei9tKzlWU3hhYXlaZmYyelU0ejl4VXhodHlwN041L0c1N3czY0VF?=
 =?utf-8?B?NktHdXJyUS9LeW5Bby9QMlNnbGFTeWMySE1HTmtWQVBiV2FjQmwxWlpsbWd6?=
 =?utf-8?B?bFMzWkpzdk03RUJTSG51MkxibjdCLy9nOGJpVmUxLzdHVzZzZm9qSDI2TmNR?=
 =?utf-8?B?cXRoSWFRTlBEYkZGYnVrNnhSNFNjM2hQRDArYUVTRTQzbGpabEduZldDRmlL?=
 =?utf-8?B?L0RrMUJvcEpoTUpsTU10VWRiejZsdnFqSXBwekYzaFBvQThCdER2dnNmYktU?=
 =?utf-8?B?Y3VDL1pkQXVqdnA5RWpmblNaWnVXUlROKzkwYUY0V3ZZSEQ3cktjNW5CUjFG?=
 =?utf-8?B?NmRIRkp5VStXVFE5QUx3L0oyZTdCQnBsaXVtd0IzZEVBclVQcFI3N3ZHbUlN?=
 =?utf-8?B?U0RpZ3E0VTJ4NWIrMHJBWVF6dCtUN3Z6TDFXTHlnanFPSlA2djRPVFFKdkVV?=
 =?utf-8?B?Q29rRzNhVDlFcW5RV0VObE85R3VWdG9Pdm9VRGZmRm9BWUxtOFk4QTVicVZj?=
 =?utf-8?B?NDFocm5LZGYzVVdOUnVrL2RBN1pXTzJ3Qmc3MGxVSjVHN1FVd0FpdjREMlVx?=
 =?utf-8?B?akZXWjBHbk5QMHJIOFZRRHRSY0VEL2JYenVMMEh3TXF0eVQvZG82MEhFNW1o?=
 =?utf-8?B?WDk4OHBVSEZjR1p6ak9TNUJEMGtINERGMXRkUURRYldlRkUxSndQVnlKZnEy?=
 =?utf-8?B?MmJ0ZU94WEFFRnhuR3R1Q1ZzS3BvSm9GeEZLSHNrUW45RFBlQVd6SUlIR3Zn?=
 =?utf-8?B?K3dDY0J5RnJWd1M4NTVEQngzZ1dDVFRvc1o2dWRFTzJIT0MyNkNOWGFJUldo?=
 =?utf-8?B?aWdidkxkVzA5SU9OQ3M5OWd6RldLczBLNkdpeU1FV2xlZ1FhSDNyblJTWHFX?=
 =?utf-8?B?d0F2ZGhoQWZUU28yU215c3ZvYWNJcmhpdHJDTnNHd2IwOW85S0ZnclJQYVZi?=
 =?utf-8?B?ZzRId21nNmkxaWh1RE5KbzVKdXBzNldyTGhNRGovWWFHdkNWMDhCdlc3WWF5?=
 =?utf-8?B?ZEFsYi8rQlNFMU96T0pTM010VUJvRVU4Z2E1TmR6SHBvdnR1Vmd3aUdhTzAr?=
 =?utf-8?B?TXV6MmdmN3hGTmk1WFBKRDlqNFdWR0RrN3BMOEpzOGd6VFNlUkI5NFIwSmND?=
 =?utf-8?B?OE5NYkZ5WVl4VlZJRDZxMFRka3BDQ3hhdy9BZklLUTFKVjVrYjQzbWhHYldz?=
 =?utf-8?B?MnJBTXg0SlRCNGJGSDQwM1lySzRwWVBCZ0FTN1NkRmV0b2N3SERGSlFDS1Vo?=
 =?utf-8?B?cXJKUkZNTUZ1RlpaRURXOC91ZDJDTUNYeDd1Q1Ivckl4V2UwbWxIZUhhVk0w?=
 =?utf-8?B?cXBrMnkzcmg0czJ4bE5hQ21DMHV3MUw4WjRZY1JuY0RuYnJVVXRqUkFsWUJV?=
 =?utf-8?B?WEt1b3FacGlGbkVnRjhlY1YzL2MrUGtzdm9HaTVhTmZmc3BEREtSSHZHUjFv?=
 =?utf-8?B?dWRlTXFqSTBQaHF3TVNWR2RYRG1vTlNWQzg2STdrRHY5RXA4NllYMWFpVERl?=
 =?utf-8?B?S0J4dFB5KzNIb1dFWFdsczFjK003QmprMUVzVktudFFLcCt4dHY2UmpBcm42?=
 =?utf-8?B?SVFDTzU4dWVsTVhDbDFtYWlRUHlReStKZVlhY2wzMWt2YmU3K1BOME9sd0tL?=
 =?utf-8?B?L3llNU9UcGxUb3AwbDJ5dktQUGJZWjFKYWcwdmJhYzV3VjhSM3djNjZ1K2gx?=
 =?utf-8?B?ZE1wR2ZyTWV0UzROQXN4bnlZbTc5bTltNFJRYlRYdDhIOUlCMDZUYTlKMmFG?=
 =?utf-8?B?VUxDbk12NmIvclRGc08ydmhIMS94ak5EU0drOXMrUDlrNUlBQi9wVEhYYmxq?=
 =?utf-8?B?dVgyZzkrTDdpWkozaFBHd1NxSVlnSS9mTkxkRFZWelJsbzMrVGlURnlsQ1pW?=
 =?utf-8?B?OWJzb0kxYlE4dWFwZHZ3anFWb1VybjVzUDRKYkpXYVp5dWd2WDRaaDZqSmI1?=
 =?utf-8?B?NmdGK0FRTThTNW8yaXAzRUROenl0SEVRTlU2SC8yNHc5bEVwS3p1UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F003B2AC1AAF44AA5B7F3FF27FAF36C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AJJ9JnlSlH2hbD/iCE6SlLAr69N/G5g/crCCnI912ScbucSYVjOdmcKgN3ZwPCGfJhtwxXr99WR4WvSCLgGUO6HBNhvdoJTIwMHX2MkdGs/56Ma6JGoybOkVY1aqsprfdUT1oHhJtHnBX0h5Fo3P4T99aahaBPnV17vQqaWpjKabHbnocsIUhAqA3LvjI+LGGFv2KXDZ6h6/dViy5istnWWiTQhx+LZkdbud3l8mwT0eKeTld7mlP6hMfBjlP8fM648I2aZf5rlTHMs1Rj9JKKlNfNmMIyWR0GtbMfG6hL44/HiCnhcQgGL67VUt8eJulfXqG5KIUeIKMXmk6QlH/A==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB12148.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c4e427-6b5c-4789-44e6-08dec5007831
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 01:51:34.0112 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lv/X2rRfBt7QxxRFogxbj+e7EX0kt1TDy36iOakMZDNUaac7DGjF8Gy3rTvelaYucAi643ahH4IOzJ1KfV4LVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15948
Received-SPF: pass client-ip=52.101.228.6; envelope-from=lizhijian@fujitsu.com;
 helo=OS0P286CU011.outbound.protection.outlook.com
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

DQoNCk9uIDI5LzA1LzIwMjYgMTU6MDQsIEJpbiBHdW8gd3JvdGU6DQo+IFRoaXMgc21hbGwgc2Vy
aWVzIGZpeGVzIHR3byBpbmRlcGVuZGVudCBpc3N1ZXMgaW4gdGhlIFJETUEgbWlncmF0aW9uDQo+
IGNvZGUgcGF0aCB0aGF0IHdlcmUgbm90aWNlZCB3aGlsZSByZXZpZXdpbmcgdGhlIFFJT0NoYW5u
ZWxSRE1BIGJlaGF2aW9yDQo+IGFuZCBtaWdyYXRpb24gc3RhdGlzdGljcyBkdXJpbmcgUkRNQSBs
aXZlIG1pZ3JhdGlvbi4NCj4gDQo+IFBhdGNoIDEgbWFrZXMgUUlPQ2hhbm5lbFJETUEncyByZWFk
diBob25vciB0aGUgYmxvY2tpbmcgZmxhZyBzZXQgdmlhDQo+IGlvX3NldF9ibG9ja2luZygpLiAg
UHJldmlvdXNseSwgaW4gYmxvY2tpbmcgbW9kZSBpdCByZXR1cm5lZCBpbW1lZGlhdGVseQ0KPiB3
aGVuIHRoZSByZWNlaXZlIGJ1ZmZlciBjb3VsZCBub3Qgc2F0aXNmeSB0aGUgcmVxdWVzdCwgZGl2
ZXJnaW5nIGZyb20NCj4gb3RoZXIgUUlPQ2hhbm5lbCBpbXBsZW1lbnRhdGlvbnMuICBUaGUgZml4
IGxvb3BzIG9uDQo+IHFlbXVfcmRtYV9leGNoYW5nZV9yZWN2KCkgd2hpbGUgdGhlIGNoYW5uZWwg
aXMgaW4gYmxvY2tpbmcgbW9kZSwgYW5kDQo+IHJlbW92ZXMgdGhlIG5vdy1zdGFsZSBYWFggY29t
bWVudHMgYWJvdXQgdW5pbXBsZW1lbnRlZCBibG9ja2luZw0KPiBzdXBwb3J0Lg0KPiANCj4gUGF0
Y2ggMiBmaXhlcyB0cmFuc2ZlciBhY2NvdW50aW5nIGZvciB0aGUgUkRNQSB6ZXJvIHBhZ2UgY29t
cHJlc3Npb24NCj4gcGF0aC4gIFdoZW4gYSB6ZXJvIHBhZ2UgaXMgZGV0ZWN0ZWQsIGFuIFJETUFf
Q09OVFJPTF9DT01QUkVTUyBtZXNzYWdlDQo+IGlzIHNlbnQgaW5zdGVhZCBvZiBhbiBSRE1BIFdy
aXRlLCBidXQgbWlnX3N0YXRzLnJkbWFfYnl0ZXMgYW5kDQo+IHJhbV90cmFuc2ZlcnJlZF9hZGQo
KSB3ZXJlIG5ldmVyIHVwZGF0ZWQsIHNvIG1pZ3JhdGlvbiBwcm9ncmVzcyBhbmQNCj4gYmFuZHdp
ZHRoIHdlcmUgdW5kZXJjb3VudGVkLiAgVGhlIHBhdGNoIGFjY291bnRzIHRoZSB3aXJlIGNvc3QN
Cj4gKFJETUFDb250cm9sSGVhZGVyICsgUkRNQUNvbXByZXNzIHBheWxvYWQpLCBtYXRjaGluZyBo
b3cgdGhlIG5vbi1SRE1BDQo+IHBhdGggYWNjb3VudHMgZm9yIHplcm8gcGFnZSBtYXJrZXJzLg0K
PiANCj4gQm90aCBwYXRjaGVzIGFyZSBzbWFsbCBhbmQgc2VsZi1jb250YWluZWQ7IG5vIGJlaGF2
aW9yIGNoYW5nZSBpcw0KPiBleHBlY3RlZCBvdXRzaWRlIHRoZSBSRE1BIG1pZ3JhdGlvbiBwYXRo
Lg0KPiANCj4gQmluIEd1byAoMik6DQo+ICAgIG1pZ3JhdGlvbi9yZG1hOiBob25vciBibG9ja2lu
ZyBtb2RlIGluIFFJT0NoYW5uZWxSRE1BIHJlYWR2DQo+ICAgIG1pZ3JhdGlvbi9yZG1hOiBhY2Nv
dW50IHRyYW5zZmVycmVkIGJ5dGVzIGZvciB6ZXJvIHBhZ2UgY29tcHJlc3Npb24NCg0KRm9yIHRo
ZSBzZXJpZXMNCg0KUmV2aWV3ZWQtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNv
bT4NCg0KDQo+IA0KPiAgIG1pZ3JhdGlvbi9yZG1hLmMgfCA2MiArKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMjkgaW5z
ZXJ0aW9ucygrKSwgMzMgZGVsZXRpb25zKC0pDQo+IA0K

