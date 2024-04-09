Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD45CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru40K-00068E-7L; Tue, 09 Apr 2024 01:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1ru40H-00067K-A3
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:26:41 -0400
Received: from mail-psaapc01on2111.outbound.protection.outlook.com
 ([40.107.255.111] helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1ru40E-0001WW-BS
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:26:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJCUTFJQh2VT9G6xDj/Jj20KFHK4Y+1bgJXGPss/GFTqBnILQ5ykDXioWoEFEYuYYqQbfa08HTKPGg18OFTFri4UZCsYalwYSzifMfmQ5ggrPILW44llHQgPs2bttnoOxpVKsNj2CvOU8my/Ps6aqEuNcpL8DPFyuIt7D1MacdKxoPU/n01iBdqbsjHaI2qj4cOYIwfEs2dd3VRRMPSjZsaDfGmZVgbvYEkihcHH+j/zFtQp1kw54O/RCWrl4PrGGNHB6zadiZgDlcM2PD+6CYJq5pNZ61nsMLpee9inXch73A1s3d/2JGjdIe3UXPCQhGcOMjDAsppCgP6qRKjAoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFFw+XEA5GKZ5RozIYOnlNdYm4PkgWuGJePZXQmC5jo=;
 b=R4NBSpyMbncDxdI1aCXArA68XIu5NaXF2DQa9l7EzA4OfArHQyZecv/059WmQ88/N3rU5h6ydnM96jnAAn/SpMDVjiXcFCOu7Fz/7ZEpHK0RE1tXyM63xB6o44LAEm0qVPvqYZZHaw+L6zZPVuWyx88bcnG2Gmnx+779UKhRCP/ncZmCpMYgH2CF9cZeWtwu3zslcjzWzXaCiFaPBNSv0XBF/O58Q/RZh1xYOoCm3gQmeX5ExVov4/pmIZ/Q52zpFaIDcb+6nsIst55Q7mEvO46ZC7nfvr+7/4Hi6w+FnP1rW+xMWNuBThSOJQ3b77KCerXlv8JTJpRRgezvZfLlJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFFw+XEA5GKZ5RozIYOnlNdYm4PkgWuGJePZXQmC5jo=;
 b=mRm+7rM08LKHYCQ6DQ8w9GtX64Am8BBpaGA7BBIQo8gOFbQhUz4sVxPgiTI8tBF51s6+isn40yhanxBkKdO80pDglGmBfvCN1elNdc85JdasF1ske/GYeMa6Y8TOdqhaqxmt53EWg/b+/wMOtMpYAHHN2aGds1poXOTNqeTUBDo9BLEcckcxSSBA1TQtJa0jUaEFE9r5kQkTFN+h6BqZMJNtnS8ufGIq+3KzAzvVoRiZbZjD9CNoZwcqUZPb8rw39U3sjiItHEuzbtDeJLWvTVF6jRrdH33HL8y81V8zxlSQCqUUqH46zVk+i9478cXxMhAOfVDhHIG1pxoSJNzECw==
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by TYZPR06MB5999.apcprd06.prod.outlook.com (2603:1096:400:33d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 05:21:30 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::807:eccb:cfd5:e6b5]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::807:eccb:cfd5:e6b5%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 05:21:30 +0000
From: Wafer <wafer@jaguarmicro.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonah.palmer@oracle.com" <jonah.palmer@oracle.com>, "leiyang@redhat.com"
 <leiyang@redhat.com>, Angus Chen <angus.chen@jaguarmicro.com>
Subject: Re: [PATCH v4] hw/virtio: Fix packed virtqueue flush used_idx
Thread-Topic: [PATCH v4] hw/virtio: Fix packed virtqueue flush used_idx
Thread-Index: AdqKPZTgqZB2kbJaQ/Kxd9wYOvHPMg==
Date: Tue, 9 Apr 2024 05:21:30 +0000
Message-ID: <PUZPR06MB4713186F5AAF536A02E4AB3BA2072@PUZPR06MB4713.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB4713:EE_|TYZPR06MB5999:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DXgEoh5jhxEszHlaAzApJGvH7P/BWYlHTf1pEwIwzaIKBXt/DlIH/ikchHw6kzizBA4lhlAxRdrjTdebsE6uwMothH/rV2yKdhDTUsJGnRxMHT4TRQZ87XOPF6L+cKglmzCRwa5nJTb4Bc8WQxL+RRWRIaJAvFJOQ9tMQ6rRwWnS/mF5yrsUfIcxkFplCX1Guy3NWUMJWm22TckKtTCM/1JnUKTYlHs04KA6nMwJXRUmr6xhOjrpWIT3FCg9f+2k8Mrgi+T2tW/1ykEyU6Z5BD3XVbfmSDWoObsZU6oyoxVWjGorcFx5i8WHc7DNRFkgeTR5t12Gz7XRRVs5WLfXPMwaZZhm7dzd3u76LEfBxoX/AM7YmHsRU06YFiXKbUq4qSCZrtuePOXeTYxRcR7Dcbq/H0kpjvLR0k3VL4iY8oAaBnahrDuDmy8uTCCl/gjt/h8BdNuQpjesMIdC1QUpoZdkjaFbNbdNw4FpQDYOUeKzDcwww4bZEyYPtxQI3BzR/KwrvralV09hy1RBTwHWZ7yPNUmU/KAkgnDgGvEtCeWTC73SwzcJ62hkA2tT6hWbO+bBhZxr0b9uaA9eDPyw3PsmNNNXlijR9HH0cKgXp6t/swc4SvdpCJ+7JOtZ0Z98pYipDJ3RqPvxdDOP+xq8TW9EKpVsVEfac9P/EjoKZX4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnhaQnQ3aHpoN25Fanh3L2gwRWpvMUNFQ1g5ZTdQU09TMGVJVkxtU2JDczlw?=
 =?utf-8?B?VHczNUVBWXgzVmN1T3g5U3VBQnU3dldtUGZXRTd2N2R6cXJrVzZ0dEN4VHJR?=
 =?utf-8?B?ODNDeTJXcEx4R0ptbjBuYjlZSjVCNkNHTXdrMHYrWmdZQ2tHVTJFMjIyTGNs?=
 =?utf-8?B?TzlWc2JnaXlLaWQ1enRPYzB2aUN6OEhBQ3NJTFlSVFJkaXM4SG9uVUxRc0JS?=
 =?utf-8?B?RHltK0luWW8zRVBkUVROMnVkVmVnMWZSU25UOFIvR2xVdTFsTk1hcFlqb3dS?=
 =?utf-8?B?elZnK3NLQWFHV2xEU1oxYkhMaGp3ZWk0cTVhTmZhcXZ5QzdxbkY0NDhZaWZT?=
 =?utf-8?B?ejhVdzk2bGFaZTlpZjRaamh3MU1vTi9JaE5ReENybWF2cDhGcCtqdzBLeW94?=
 =?utf-8?B?dDdKdlk1VHpQRStlSkd1MElObWVSZlJhdDBublltcWxpemdQajZpUVdCTWFw?=
 =?utf-8?B?enBXcTRKVE45d2t4aHJueGczSmk2T0VvVkJyVHU2SkVnbmFTOTBTaUdOY1Rr?=
 =?utf-8?B?bkg3NTk2VDRjRmFjcUdLUXZ6TklZczNCSEhYdTE5WUJJQnZuZ2ZXZlVJalgr?=
 =?utf-8?B?Nk9pY3ZaZHZFZE8zMXpJQngyYkkyQzFHQWUvaGN1aVc3d2xhblFyY0dsMllZ?=
 =?utf-8?B?RzJUcFVoVnEyTk0vTTZ3Y1lMVnI4SElaamRVa1RVN1ZUKzFjWlpjZ0VUVStF?=
 =?utf-8?B?RUpWUzRqSFRtYnpxRFN5UGI4b211OTY2RzBOcFFKZlIvVDBxVmhsZDlKd1A5?=
 =?utf-8?B?VVpLSHZlbXNYanpzcm5RUncrejJWeDdJd2E4ZmRhbDdsUEowYUZXRnY1ZU5Z?=
 =?utf-8?B?NzhUa011UkFabVFvYXZuRzJibFRTL0tnZU42RnFndFhabXNxek5pL2x4Rmtr?=
 =?utf-8?B?T25uTjdscTlWY0hkS0JQU3d0R0ZXajlOOXdyNDgxMTFEQ21pcmQxRUovUXRa?=
 =?utf-8?B?enZUSmpiMC9pTzVrVGtZQTlmTG9zUGhEcXhrdnhQSUtjREx3dDNxN3ZpMk9H?=
 =?utf-8?B?VjlpZ012TkRsK0lQdVA4aWZqelJTTlRCRDl4YzBKZHZ1bnZQL29xRXJUbFpw?=
 =?utf-8?B?RDJGdXJWV1hXY2hXY2VOY0tmMEZhZ2d1VUk5OEtEOWlldVB2Y2NqMHFUalJE?=
 =?utf-8?B?a2IzeVRmR0ovK2Y2UDI2NUxBTndCSStvdlpXV3NaQW9Ka1BIRGJmRXBzQzNv?=
 =?utf-8?B?L1laemt2WGd4UzRtUmErWjlMTnpUTXdFUzE4MnlsWkZBdGFUVzh2M3FpRk5q?=
 =?utf-8?B?SHhlaUU1eUZZaWZXL0sxNE93QzRUTU1LV3hzcHQzT0FMSkpvc3VjdURCSmho?=
 =?utf-8?B?bnB5UXMzWnNwSTk1RnR3TkV6RjFieEZNc21yVFZ3bVAzOTNyaWJBYW5oc082?=
 =?utf-8?B?RDJGUWltNDFqUTB5UzNXVnd6SU1UdnpOT3pkRWN1WFVIV0lWUHkvOFdORUQ4?=
 =?utf-8?B?TFNVZ2tScERwdFJ1NWFNbThuTitMamFxc1U1bXFGY2c4SDFkUlM4aWZ6bmRx?=
 =?utf-8?B?YXpjaDBLU2IvQUFLdnczSFIxU3dwcHRHNkxCODdnbjZwTXRzQmIyK3BqRXBU?=
 =?utf-8?B?TkZrQi9yU0M1OXBXaUJqNjFrS08ybzBIdDQxMHAyQzlwbzJta1pqMDQ3aGh2?=
 =?utf-8?B?bFgrbklLQ3ZrSVBYTDdOcU13bmtVMGJyZE55TmZlb1g4MGUzS1FmUWdoUnI5?=
 =?utf-8?B?Yi9DTi9wWnd0U3hjSXVYeFBpbTR1RXhjekJJRE1VbC93WEtQbVVuSVAvNmFm?=
 =?utf-8?B?RytNdG1ucVh1TzZmRGpmSXRWU0c4QkxlbzJvUVRQUUwrNzhxMWx6Ynh5b0pT?=
 =?utf-8?B?R0hiUERIem5IbDlENFh6Z0pOeWY1bVV3c1JuUVgxcVdrMmJ4UGI4U2xUbFBF?=
 =?utf-8?B?VUsxN0w5My9ITi9pM3VFaDZySC9pRzhqQVZCNzJEbjF4MTVVUEJZQkRYTDdv?=
 =?utf-8?B?Y2xDekd1NkZwSk5DN0VzNGM3YzVyc2VEVE9PcWdtT0txSE5La21qSkhNM2I3?=
 =?utf-8?B?ZFh3NitEeCtSbnBFL2pIL0FhOGdMYXZqeXdzL2FsU0dycUc0OXZqZFdUd3I1?=
 =?utf-8?B?blhPM1NkRW8vYWRNcVB4V0dRVTB5cC8yUzVOYVNtNXBUL3dpcmNoNFFEMVpi?=
 =?utf-8?Q?dxg6ejqTOCH/FRi5nyZccKad3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43c7f8d-44d5-429d-8e4b-08dc5854e9df
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 05:21:30.3776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NfvobC00OvGyKs7TRIPUdV6YhCAhTZ3rsyaLHFmkJ4iNYR6lZpQT2EbKLwiNq97EZL6y893Ej0iS99iGETLCZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5999
Received-SPF: pass client-ip=40.107.255.111;
 envelope-from=wafer@jaguarmicro.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

T24gNC85LzI0IDE6MzIgRXVnZW5pbyBQZXJleiBNYXJ0aW4gPGVwZXJlem1hQHJlZGhhdC5jb20+
IHdyb3RlOg0KPiANCj4gRXh0ZXJuYWwgTWFpbDogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20g
T1VUU0lERSBvZiB0aGUgb3JnYW5pemF0aW9uIQ0KPiBEbyBub3QgY2xpY2sgbGlua3MsIG9wZW4g
YXR0YWNobWVudHMgb3IgcHJvdmlkZSBBTlkgaW5mb3JtYXRpb24gdW5sZXNzIHlvdQ0KPiByZWNv
Z25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+
IE9uIFN1biwgQXByIDcsIDIwMjQgYXQgMzo1NuKAr0FNIFdhZmVyIDx3YWZlckBqYWd1YXJtaWNy
by5jb20+IHdyb3RlOg0KPiA+DQo+IA0KPiBMZXQgbWUgc3VnZ2VzdCBhIG1vcmUgZ2VuZXJpYyBk
ZXNjcmlwdGlvbiBmb3IgdGhlIHBhdGNoOg0KPiANCj4gSW4gdGhlIGV2ZW50IG9mIHdyaXRpbmcg
bWFueSBjaGFpbnMgb2YgZGVzY3JpcHRvcnMsIHRoZSBkZXZpY2UgbXVzdCB3cml0ZSBqdXN0DQo+
IHRoZSBpZCBvZiB0aGUgbGFzdCBidWZmZXIgaW4gdGhlIGRlc2NyaXB0b3IgY2hhaW4sIHNraXAg
Zm9yd2FyZCB0aGUgbnVtYmVyIG9mDQo+IGRlc2NyaXB0b3JzIGluIHRoZSBjaGFpbiwgYW5kIHRo
ZW4gcmVwZWF0IHRoZSBvcGVyYXRpb25zIGZvciB0aGUgcmVzdCBvZiBjaGFpbnMuDQo+IA0KPiBD
dXJyZW50IFFFTVUgY29kZSB3cml0ZXMgYWxsIHRoZSBidWZmZXJzIGlkIGNvbnNlY3V0aXZlbHks
IGFuZCB0aGVuIHNraXAgYWxsDQo+IHRoZSBidWZmZXJzIGFsdG9nZXRoZXIuIFRoaXMgaXMgYSBi
dWcsIGFuZCBjYW4gYmUgcmVwcm9kdWNlZCB3aXRoIGEgVmlydElPTmV0DQo+IGRldmljZSB3aXRo
IF9GX01SR19SWEJVQiBhbmQgd2l0aG91dCBfRl9JTkRJUkVDVF9ERVNDLi4uDQo+IC0tLQ0KPiAN
Cj4gQW5kIHRoZW4geW91ciBkZXNjcmlwdGlvbiwgcGFydGljdWxhcmx5IGZvciBWaXJ0SU9OZXQs
IGlzIHRvdGFsbHkgZmluZS4gRmVlbCBmcmVlDQo+IHRvIG1ha2UgY2hhbmdlcyB0byB0aGUgZGVz
Y3JpcHRpb24gb3Igc3VnZ2VzdCBhIGJldHRlciB3b3JkaW5nLg0KPiANCj4gVGhhbmtzIQ0KDQpU
aGFuayB5b3UgZm9yIHlvdXIgc3VnZ2VzdGlvbi4NCg0KSSB3aWxsIGFkZCB5b3VyIGRlc2NyaXB0
aW9uICBhbmQgU3VnZ2VzdGVkLWJ5IHRvIHRoZSBjb21taXQgbG9nLg0KDQpUaGFua3MhDQoNCj4g
DQo+ID4gSWYgYSB2aXJ0aW8tbmV0IGRldmljZSBoYXMgdGhlIFZJUlRJT19ORVRfRl9NUkdfUlhC
VUYgZmVhdHVyZSBidXQgbm90DQo+ID4gdGhlIFZJUlRJT19SSU5HX0ZfSU5ESVJFQ1RfREVTQyBm
ZWF0dXJlLCAnVmlydElPTmV0UXVldWUtPnJ4X3ZxJyB3aWxsDQo+ID4gdXNlIHRoZSBtZXJnZSBm
ZWF0dXJlIHRvIHN0b3JlIGRhdGEgaW4gbXVsdGlwbGUgJ2VsZW1zJy4NCj4gPiBUaGUgJ251bV9i
dWZmZXJzJyBpbiB0aGUgdmlydGlvIGhlYWRlciBpbmRpY2F0ZXMgaG93IG1hbnkgZWxlbWVudHMg
YXJlDQo+IG1lcmdlZC4NCj4gPiBJZiB0aGUgdmFsdWUgb2YgJ251bV9idWZmZXJzJyBpcyBncmVh
dGVyIHRoYW4gMSwgYWxsIHRoZSBtZXJnZWQNCj4gPiBlbGVtZW50cyB3aWxsIGJlIGZpbGxlZCBp
bnRvIHRoZSBkZXNjcmlwdG9yIHJpbmcuDQo+ID4gVGhlICdpZHgnIG9mIHRoZSBlbGVtZW50cyBz
aG91bGQgYmUgdGhlIHZhbHVlIG9mICd2cS0+dXNlZF9pZHgnIHBsdXMNCj4gJ25kZXNjcycuDQo+
ID4NCj4gPiBGaXhlczogODYwNDRiMjRlOCAoInZpcnRpbzogYmFzaWMgcGFja2VkIHZpcnRxdWV1
ZSBzdXBwb3J0IikNCj4gPiBBY2tlZC1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhh
dC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2FmZXIgPHdhZmVyQGphZ3Vhcm1pY3JvLmNvbT4N
Cj4gPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgaW4gdjQ6DQo+ID4gICAtIEFkZCBBY2tlZC1ieS4N
Cj4gPg0KPiA+IENoYW5nZXMgaW4gdjM6DQo+ID4gICAtIEFkZCB0aGUgY29tbWl0LUlEIG9mIHRo
ZSBpbnRyb2R1Y2VkIHByb2JsZW0gaW4gY29tbWl0IG1lc3NhZ2UuDQo+ID4NCj4gPiBDaGFuZ2Vz
IGluIHYyOg0KPiA+ICAgLSBDbGFyaWZ5IG1vcmUgaW4gY29tbWl0IG1lc3NhZ2UuDQo+ID4gLS0t
DQo+ID4gIGh3L3ZpcnRpby92aXJ0aW8uYyB8IDEyICsrKysrKysrKystLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9ody92aXJ0aW8vdmlydGlvLmMgYi9ody92aXJ0aW8vdmlydGlvLmMgaW5kZXgNCj4g
PiBmYjZiNGNjZDgzLi5jYWI1ODMyY2FjIDEwMDY0NA0KPiA+IC0tLSBhL2h3L3ZpcnRpby92aXJ0
aW8uYw0KPiA+ICsrKyBiL2h3L3ZpcnRpby92aXJ0aW8uYw0KPiA+IEBAIC05NTcsMTIgKzk1Nywy
MCBAQCBzdGF0aWMgdm9pZCB2aXJ0cXVldWVfcGFja2VkX2ZsdXNoKFZpcnRRdWV1ZQ0KPiAqdnEs
IHVuc2lnbmVkIGludCBjb3VudCkNCj4gPiAgICAgICAgICByZXR1cm47DQo+ID4gICAgICB9DQo+
ID4NCj4gPiArICAgIC8qDQo+ID4gKyAgICAgKiBGb3IgaW5kaXJlY3QgZWxlbWVudCdzICduZGVz
Y3MnIGlzIDEuDQo+ID4gKyAgICAgKiBGb3IgYWxsIG90aGVyIGVsZW1tZW50J3MgJ25kZXNjcycg
aXMgdGhlDQo+ID4gKyAgICAgKiBudW1iZXIgb2YgZGVzY3JpcHRvcnMgY2hhaW5lZCBieSBORVhU
IChhcyBzZXQgaW4NCj4gdmlydHF1ZXVlX3BhY2tlZF9wb3ApLg0KPiA+ICsgICAgICogU28gV2hl
biB0aGUgJ2VsZW0nIGJlIGZpbGxlZCBpbnRvIHRoZSBkZXNjcmlwdG9yIHJpbmcsDQo+ID4gKyAg
ICAgKiBUaGUgJ2lkeCcgb2YgdGhpcyAnZWxlbScgc2hhbGwgYmUNCj4gPiArICAgICAqIHRoZSB2
YWx1ZSBvZiAndnEtPnVzZWRfaWR4JyBwbHVzIHRoZSAnbmRlc2NzJy4NCj4gPiArICAgICAqLw0K
PiA+ICsgICAgbmRlc2NzICs9IHZxLT51c2VkX2VsZW1zWzBdLm5kZXNjczsNCj4gPiAgICAgIGZv
ciAoaSA9IDE7IGkgPCBjb3VudDsgaSsrKSB7DQo+ID4gLSAgICAgICAgdmlydHF1ZXVlX3BhY2tl
ZF9maWxsX2Rlc2ModnEsICZ2cS0+dXNlZF9lbGVtc1tpXSwgaSwgZmFsc2UpOw0KPiA+ICsgICAg
ICAgIHZpcnRxdWV1ZV9wYWNrZWRfZmlsbF9kZXNjKHZxLCAmdnEtPnVzZWRfZWxlbXNbaV0sIG5k
ZXNjcywNCj4gPiArIGZhbHNlKTsNCj4gPiAgICAgICAgICBuZGVzY3MgKz0gdnEtPnVzZWRfZWxl
bXNbaV0ubmRlc2NzOw0KPiA+ICAgICAgfQ0KPiA+ICAgICAgdmlydHF1ZXVlX3BhY2tlZF9maWxs
X2Rlc2ModnEsICZ2cS0+dXNlZF9lbGVtc1swXSwgMCwgdHJ1ZSk7DQo+ID4gLSAgICBuZGVzY3Mg
Kz0gdnEtPnVzZWRfZWxlbXNbMF0ubmRlc2NzOw0KPiA+DQo+ID4gICAgICB2cS0+aW51c2UgLT0g
bmRlc2NzOw0KPiA+ICAgICAgdnEtPnVzZWRfaWR4ICs9IG5kZXNjczsNCj4gPiAtLQ0KPiA+IDIu
MjcuMA0KPiA+DQoNCg==

