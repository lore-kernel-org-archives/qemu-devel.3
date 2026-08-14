Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC296C5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 00:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wug5S-0005fG-EH; Thu, 13 Aug 2026 20:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wug5Q-0005f6-OK
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 20:47:52 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wug5O-0007bI-8C
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 20:47:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsNT5hr8j/i5yKitnqrGrkWVsaf8ts3kYG/XOB4nt+93Z1tuI8dqFHl7CbIqbeFCclcoHV/NbCgrVfGLiEP1ryZorjPlYVGrW/VZPcQt0U88Pe9dz8Q75GtrVFYnlDTGtc/OAAk/le5XDqulQDkH7lpZ/GXlqwN3HXWKUlujdgqiKy22x+W0HW6d8tSjXyDf9BTiroo3lfC34b5AD3Qk53xqXn8DYQ2tecJkmYrB0kV+DUe29a9pjwdQUaelFViVZYtFycWxQYao0RAbkIHgiUdx8oQuLIr5Q3PZtFRoGA1thirJAqCEQcG7poucg6Y1yUbdsOcBkakLKF+dLOv7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuKBdl/NuxVVDLKxqkglX7lAPF1b0R27GPl9w4UNfnQ=;
 b=S5d6LJkTCiyCdW0k1CQ9nwjQawunyErB+LKhrAqe/mJBKy/sbdEnTRZARoDfnLzgkAWQOWg2D6TV7bjyj1cH/HHz0gyDSlxTewy9KO4yy3kkpUem79iE8nRgbSJX/Ecy9g9J1XoSikuguaUQm9c7Bsyb3tIvg9pRud0ajkOACVmu7QpRaatYlskDCTv2Mw+amWszXfnk3q3WZTYUZ7tjbxy3lHW3NbR8ceQwy40PgCSaWxC0J4XrGPP22LU0HjiwIK7LjCnHYWwRz9RAc+mU9onVPXUPLRuHQFFvPzUQp9dY7pUoVEXawZ2BBpZzq9EeaN5EK2zryqnHkxztooiwGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuKBdl/NuxVVDLKxqkglX7lAPF1b0R27GPl9w4UNfnQ=;
 b=heCd0ECLx901eTOQR2oa4xuiGS/j6dzATimPFLB18CwZGxwA1RtIX3zj079yzCccvfzo98CDQtIP9vODJcgHF9OC+deaKDDrpN+pzuDRJaayvisICIkpRPSNDn7zuMrz0mspeATfX8rbGsoqLjRiwQ9zEDoJUK6QCdSQJKjoG6qvKOjq8KGWRfLAjG/TI8TH+WbyRoNKKzkzWhefviyb5kDATUsX6MZ1GW5+ZnCwYwzhqkkuFoxizt+5CM+M9B8AEytpj+XifO24Rf9KwiiYUEx+1tesYLa6/MYYykDuRA9IxdsXs831avPf+F1QhWK15UtCAo3bTWHXFSsxOUwbOw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SG2PR06MB5214.apcprd06.prod.outlook.com (2603:1096:4:1d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 00:47:40 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 00:47:39 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>,
 "clg@redhat.com" <clg@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@mailo.com>, Paolo
 Bonzini <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "clg@kaod.org" <clg@kaod.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1] hw/usb/hcd-ehci: Handle get_dwords() failures in async
 writeback
Thread-Topic: [PATCH v1] hw/usb/hcd-ehci: Handle get_dwords() failures in
 async writeback
Thread-Index: AQHdKvSrYy6CS2yN20qVd8jbUP7gcbabul8AgAD7jRA=
Date: Fri, 14 Aug 2026 00:47:39 +0000
Message-ID: <TYZPR06MB49808E3AB5205940589E3CF6FCDA2@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260813072340.637657-1-jamin_lin@aspeedtech.com>
 <0ab8c434-cb0f-48d8-ae00-b329c7c742b9@oss.qualcomm.com>
In-Reply-To: <0ab8c434-cb0f-48d8-ae00-b329c7c742b9@oss.qualcomm.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SG2PR06MB5214:EE_
x-ms-office365-filtering-correlation-id: d4ae608e-8bf9-4747-62cb-08def99da45a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|56012099006|38070700021|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: Xy1/KNjP6VzWgfhFDQXjg9OPNQWGykzmDuYJZA2T1veU3dc5KcBQZq7YghJDQLXKRhZ/sGJJOoCscCQNVsa9LdBEfkJI8ieHDzJIZQnwRXqSz3kVT2V1eE71uw8hVGbKBsM9XZ5LKIPcYAkVVTCO6926EUIo4MykVDHwvjGssM29bOCBNZ8QpLCb3vF1/jIouN91DExipj4RO6N42M15CgnzPt82Ox60ZHW8nCEiFbyLdl0hg6Sxkz/EQN2k52cvGpB2mvmpSPdK7fIh4niFASV9mNZhDmV4phOe5zusaWFrgpq9Y7ClVWG8rOCA6Eh+esfrHRnNsNJZb+6fiGCP3B2kE2rMSk8XmeYZusg1yWz3+BCQ4ZR+Bje6/27OpgB0kfOOp88okV4iPstKgKa+n4Ym08xK8GzchSSmxSQo1ovi8F1HBACOBXhvva7s7eRgXLjbCdfVdOfNyLwl+W8sZy7u6CsLFDO2P6BpoWSULoiwlV0rXaBPUWPqMegGlyc+nIshjndyGKeLj9VZ024cqW7eZD8Qa09IwPJOvpldUNM/wSZrVqvp4OBcZl4gy+5dHhfsO6ZYu5g/vAl+qr2puBWqc308fJ9+AkoVlBjZncXDjhWsCMDp/TvcY8XYBynS5G/4y4XwRATZ5fLuSG700QPZLOp2EDDqLTmfUTRxbyS9nyzpKigCmSt3z5MPVgvEEPOhQvILM+2NcppSus7d8Z6Kr2OAfABVnpmR9Dk1X9U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(38070700021)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1UzOENzVWdIRnVXMWN3M0dkMXZrYk5mV2RaZFFtRzh2VXo1VVIxTmt4b0NX?=
 =?utf-8?B?VTRlT0ZJbWJiaXp6ZzVIbnVQVm82c2JuQmk0M29WOEJzaGsvaFpkTDZvN3JB?=
 =?utf-8?B?bzJ4RUF4VXJiTVl3YzJBNUF1Rnl4OWdZbWZhaVhqU0tGaEFsN3BMOUFzRHhM?=
 =?utf-8?B?QkNjQ1NWZlg1b0JpWVFDVmRvTWc5NlExSDBrQlJncVFseVhIUXd0UGo2MmJH?=
 =?utf-8?B?dXBhM29wT0xwVk52eXRQeEw1Sm9tanN5eitPRnRIK09jTkpwT0J6a29EbVdW?=
 =?utf-8?B?MXhmT0tQQjY5UjJGOENrc0tjejR5V1lJMWxYbmFjQ1h3OHBOY1dKT0s4d29F?=
 =?utf-8?B?MGRwQXZXSGdJRnNaNzdjQkYza2tNWElsTnFGa2NEcWhBK29EYkk3bW0yY09L?=
 =?utf-8?B?YmRrME0vbVdvK1VCYnkxTnh4V0ZYQ0xsZFltZmRYT3ZXODlrRTg1SnBHQlpN?=
 =?utf-8?B?cXZZUkx2MXVyUFRZRzF2YzdUZEV4YnRzUEN2cFowVDNUQzVFbTJjbkEwWnZT?=
 =?utf-8?B?Z2Jlbmp6UnlVbEFRb1g0SXR5dyszK215MGNjZVVlUEFIUjU3cjNZYkdkYjRw?=
 =?utf-8?B?alZYY2YxS1VsVjBUVm5LRlA4a1Z3TlJ2eVErZkZMY2dsbS9GUEtVLzFSQ0Ey?=
 =?utf-8?B?TFc3aENPNkVnUldadHdhYWo2QXNJUUlud25zVGRqbzhkeDlIaGJEdXBxYmd5?=
 =?utf-8?B?bERiUStSNXZFZW9SWE9Sall3bHV6M2NsMDZxbzMzVSt1TlRtRXExTGNWSDVV?=
 =?utf-8?B?aHA5NmwyRlhVMjh5VW16ZWk2WWVoQVZPdEEzWWlxQm1nUkVLTGk4MGgvQlJY?=
 =?utf-8?B?VDU1SmRLSUtHWHkwL0IyR1k3MEhINTY2dXgvc2pZQUJFVjkraEJMdzFDYXNS?=
 =?utf-8?B?bnF6aVllNXZoWEltS1dhL1ZqU0VrOURlcktXQnlBRE41b3pRRXFGanBjcWcz?=
 =?utf-8?B?b3oyWTUvWTVlSDBxYXZKLzE1MVVodHZmcENMVFZFdTlxYWt6L3AwcGpHSEJH?=
 =?utf-8?B?MDhKVUZ5cnVCNlprcHVZck9WTmliTmZOS0hLTGJreXNreW90YmJYaHdBa3BU?=
 =?utf-8?B?czJNNHdGM1VGcTQzMEtqczZWU3c2MHhqVnBzZWowT2w3dXhGdnNlYXRHRlUv?=
 =?utf-8?B?T3F6dTFuUVJpbUxraGpIWUdYWTZualA3MVhNSmJpQjR3MjFpM2lpUUVLU21u?=
 =?utf-8?B?eFVDZENCNnJtZ1FoK2d1c2hOVkFlZFFCdjVKYUF0amU3SnZCUktCQ3QvUXZ3?=
 =?utf-8?B?ellHVEY2cGZSK1I0VjBDQ0pOcUlhcE5vakpzRnhaMDdXdk5ianZyTFprN3dE?=
 =?utf-8?B?VlJtODQ1bFVBRWxuTFBXditKdTZ5eEJYV245NGI3Wk4yMzNxL0xiR2RnMjNa?=
 =?utf-8?B?KzlybHJzd2pKV0VNTVVUVHhYU1RmMFduNWMvS3hwdFVDbndIVlJFU3F6endR?=
 =?utf-8?B?QUdmemVGZVBiYkprRHp6RTZNdW9LcGJsc05jaGhiVVJ0UW9JaUZzMVpmKzc1?=
 =?utf-8?B?K0s0Mi9raHFUZWswL3kyL1dITVJ6QjM2VEZhbkRYZnNjU0QxZ2x2WnN5VGlU?=
 =?utf-8?B?Y3hSQWJQNm5sUGoyYXdPbHdHNjZkcUFLQnZ0NXNWYUd6Y0RiN3l6cUpBNDEx?=
 =?utf-8?B?YUxtd0FsQ0ZPdjVNa0x0dGVDRS91YmNHMHBVR3NtSEk0MVErRjdBOS8vUEZN?=
 =?utf-8?B?NDF1UDhiN2xSMVpEcm1rWDNOV0M5VHRYZ3A4NlVxd3JLeHRDbnVFd2VkMVZy?=
 =?utf-8?B?ZWtzYTd2K09SbW9QS05GZlBWeCsrYlFSazRDU1JWOWJnd1IvVHhXc0pJZFFt?=
 =?utf-8?B?aVY3MXV4ZVI2N21GZXVBaDM1VG9LeDFwbnJLeHFVY2xIVnkwc3lFRnUwYnBC?=
 =?utf-8?B?cndvQVM3c3VqTDE0QmxwMEdpaFczT21URUxUWndUYkZqaDlVcy9hWFQvRWN1?=
 =?utf-8?B?NDc4ZmluYUxOUC9LRjNxdVhJSnJLYzRFZUtBYVgrV0FDd3ZreWtmWlVvSUFa?=
 =?utf-8?B?cElOQzZqbjFheVNuUGE0RFd5UWw1Qnp4ZVpwaVJxVEQyVkQ5UHVHeDZCQTli?=
 =?utf-8?B?ZUF1N01uZ2lsZSt3ekVJNE5Ib1FuQTV4MkxPMlBML3VyU29QSll6VjBaVHBi?=
 =?utf-8?B?NFgrOGhoc2RBdG50Unp1QVVINzZ0TlJFSFpqTDM3Z2hsOTdVVDY0ZEd5OStv?=
 =?utf-8?B?VlZBVFF3N0lQT3FLSmt6WjgzdzR5TnRYYjBBOHUxNU9MOTVtbjI1bG5FUXl3?=
 =?utf-8?B?M043OWh6UnBaODE2T1pzWWFYN203amVLVjd1VC80VHVwWHdXbWNQNFd0QzN5?=
 =?utf-8?B?RWovSVludVNuSlFVaHVFUk9zMlgvOERrMjkrNmM5OWRuMmhRRVVpdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ae608e-8bf9-4747-62cb-08def99da45a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 00:47:39.3880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0VrGYk+tTw2rb73GGdLOYP5CzzNbA3fj8oBNBy7tBgEvbMWefbz5wgmjA0o40wHvzIbor6SrgVCPD/4MpH3QKqVa+BB7B4XAZvYAN+a3n2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5214
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

KyBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAb3NzLnF1
YWxjb21tLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAxMywgMjAyNiA1OjQzIFBNDQo+
IFRvOiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IGNsZ0ByZWRoYXQuY29t
OyBQaGlsaXBwZQ0KPiBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQG1haWxvLmNvbT47IFBhb2xvIEJv
bnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+Ow0KPiBvcGVuIGxpc3Q6QWxsIHBhdGNoZXMgQ0Mg
aGVyZSA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KPiBDYzogVHJveSBMZWUgPHRyb3lfbGVlQGFz
cGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBody91c2IvaGNkLWVoY2k6
IEhhbmRsZSBnZXRfZHdvcmRzKCkgZmFpbHVyZXMgaW4gYXN5bmMNCj4gd3JpdGViYWNrDQo+IA0K
PiBPbiAxMy84LzI2IDA5OjIzLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gQ292ZXJpdHkgcmVwb3J0
cyB0aGF0IGVoY2lfd3JpdGViYWNrX2FzeW5jX2NvbXBsZXRlX3BhY2tldCgpIGlnbm9yZXMNCj4g
PiB0aGUgcmV0dXJuIHZhbHVlIG9mIGdldF9kd29yZHMoKSB3aGVuIHJlYWRpbmcgdGhlIFFIIGFu
ZCBxVEQuDQo+ID4NCj4gPiBIYW5kbGUgcmVhZCBmYWlsdXJlcyBpbiB0aGUgc2FtZSB3YXkgYXMg
UUggYW5kIHFURCB2ZXJpZmljYXRpb24NCj4gPiBmYWlsdXJlcyBieSBmcmVlaW5nIHRoZSBwYWNr
ZXQgYW5kIHJldHVybmluZyBlYXJseS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExp
biA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvdXNiL2hjZC1l
aGNpLmMgfCAxMCArKysrKy0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gRml4ZXM6IDJiM2RlNmFkYTVkICgiZWhjaTogd3Jp
dGViYWNrX2FzeW5jX2NvbXBsZXRlX3BhY2tldDogdmVyaWZ5IHFoIGFuZA0KPiBxdGQiKQ0KPiBS
ZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBvc3MucXVhbGNvbW0u
Y29tPg0KDQpUaGFua3MgZm9yIGFkZGluZyB0aGUgRml4ZXMgdGFnLg0KSeKAmXZlIGFsc28gYWRk
ZWQgdGhlIFJlc29sdmVzIHRhZy4NCg0KUmVzb2x2ZXM6IENvdmVyaXR5IENJRCAxNjg1MjM2DQoN
CkphbWluDQo=

