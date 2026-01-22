Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E895DD3EE64
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 13:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viuYO-0001g7-Ho; Thu, 22 Jan 2026 08:16:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1viuXw-0001Sv-P9
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 08:16:26 -0500
Received: from mail-out-4.itc.rwth-aachen.de ([2a00:8a60:1:e501::5:49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1viuXt-0005Ve-9m
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 08:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=rwth-aachen.de; i=@rwth-aachen.de; q=dns/txt;
 s=20240516-RWTH; t=1769087781; x=1800623781;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=yF+LBeUaFzy3/tXuiXOTIZL3LYrn5NbzIcQoL35uCFU=;
 b=Cp1Ceah7T8EdSiwBZttkT7Iw7DJpZ6bGnDBh1sC9VaOX9lp/cTRRfnya
 Ip0VV+x+t7IuGnmH/5Ud/gopuIqo6H04GhFpOfBQ+hhyAPmCZoiECoZQz
 VMoI9WOAYb93wVzMbuNZvNRzgly/smYdUtKcu79dT5EXYluVBM4X6b44C
 kUsnjaDY7gVMIhSJcRXaqPVGs9CBwJVZO9vla8fuvWn0Pi7fU8VDgSSFX
 l0uDy4TP2gPBbbwcAa4UvwYxaCisoVVli86ytsFEjKl76h81w+KFEk4Na
 i740YdbS8uoHSMHjtT6bKcy5IOa/MgaPHA1gq5U7sBXR/tIXXXHwXc6pR w==;
X-CSE-ConnectionGUID: uOQM46/qR4qxg5GddKbTZg==
X-CSE-MsgGUID: L79OsCJ5QfOdX4sqT6h4xA==
X-IPAS-Result: =?us-ascii?q?A2CgAgC2IXJp/54agoZaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBUIVPAYQ5kXQDoBkPAQEBAQEBAQEBCAFRBAEBhQcCFoxyJzgTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBAQEBCwEBBgEBAQEBAQYFgSGGCVOGWwEEASMRRQULA?=
 =?us-ascii?q?gEIGgImAgICLxUQAgQOgweCTSewCIEygQHfAoEsFYEKLohTAYFvhACEeIIMQ?=
 =?us-ascii?q?4EVJwsDDYJoPoQaKReDRDqCLwSCIoEOgRKKTIIUhg8JSXh4LAFVExcLBwVhQ?=
 =?us-ascii?q?kMDgQYjSwUtHYEjIR0XEx9YGwcFEyMyBhkGHBICAwECAjpTDIF2AgIEghB7g?=
 =?us-ascii?q?gEPhwCBAAUubxoOIgJBNwRDAwttPTcUG0GTDEKBCklCWJcmjCejLweCOF2BC?=
 =?us-ascii?q?qFyBC+XYJMLLphYqRYCBAIEBQIYgX+BfnF5AYI9URcCD44tFsl5gTQCBwsBA?=
 =?us-ascii?q?QMJgjmPMWABgRwBAQ?=
IronPort-Data: A9a23:IcOxw6iqI28Ca6RhKk1khoVPX161RhEKZh0ujC45NGQN5FlHY01je
 htvUWCGaP/YZDShfN9xPo+2908DupCGydZlQAo//y1mEC9jpJueD7x1DKtR0wC6c5efFhI3t
 63yTvGacajYm1eF/k/F3oDJ9Cc6jefTAOKgVIYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE0
 T/Ii5S31GSNhXguawr414rZ8Ekx5K2o4mtC1rADTakjUGH2xiF94K03ePnZw0vQGuF8AuO8T
 uDf+7C1lkux1wstEN6sjoHgeUQMRLPIVSDW4paBc/H/6vTqjnVaPpcTbJLwW28O49m6t4wZJ
 OF2iHCFYVxB0pvkxb5BCUkIS0mSCoUdkFPPCSDXXcV+VCQqeVO0qxllJBle0YH1Zo+bDEkWn
 cH0JgzhYTieoNuTnOz8U9Mwn9QscebnMKAVhkNvmGSx4fYOGfgvQo3w2uN48Qd1uZoLNLDEe
 NYZLDNjKhjNC/FNEg5MVNRnx7/u3Ce5KmAIwL6WjfNfD2z7yQVrzLnrdtnPfdGMRMNatkufo
 G/c9CLjHQ0acdWWwjqI9DSgi4cjmAuiB9NDS+fir5aGhnW3mT00EzY0CGK1hvWJ1lWnZ4xfd
 1w9r39GQa8asRbDosPGdwW1vHOe+BsVStZdF+kS7ACLw7DTpQGDCQAsVj5AbNkqnMs3QzUw0
 RmOhdyBLSVitaDQRX+D+7O8qzS0Ni4Ia2gYakcsRA8I85/prYc1gx/nStdlGbSyyNrvFlnNL
 yuitjcih7gDyNFRkqz950/bg3elqt7FQ2bZ+znqY45s1SshDKbNWmBiwQKzASpoRGpBcmS8g
 Q==
IronPort-HdrOrdr: A9a23:9YsRXqrzoOJ0r4A0PdU21N0aV5r5eYIsimQD101hICG9Kvbo8P
 xHnJwguiMdEF4qKQ0dcKO7Sc+9qBTnhOFICOgqTMqftWbdyQiVxe1ZgLcKhgeQfxEWldQtq5
 uIEZIOauEYZGIS5a2R3OD7KadE/DDtys6VbJLlr0uFOjsKV0gP1WtE402gYzRLrUF9dOIE/N
 D33Ls9m9OPQwVsUviG
X-Talos-CUID: 9a23:0022uG9SmrGZxLJq+7mVv1MzI+V5LDrE9ivJM0DlJmpla7epe1DFrQ==
X-Talos-MUID: 9a23:lD9waQXsNTNsmhbq/Buz1RZ5H+U12qqJBHBRiow65cnYJQUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,246,1763420400"; d="scan'208";a="17997221"
Received: from rwthex-w2-a.rwth-ad.de ([134.130.26.158])
 by mail-in-4.itc.rwth-aachen.de with ESMTP; 22 Jan 2026 14:16:15 +0100
Received: from rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154) by
 RWTHEX-W2-A.rwth-ad.de (2a00:8a60:1:e500::26:158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 14:16:14 +0100
Received: from rwthex-s2-a.rwth-ad.de ([fe80::9e0:8e94:8a31:2f0b]) by
 rwthex-s2-a.rwth-ad.de ([fe80::9e0:8e94:8a31:2f0b%4]) with mapi id
 15.02.2562.035; Thu, 22 Jan 2026 14:16:14 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>
Subject: Re: [PATCH 1/2] include/exec: Provide the cpu_tswap() functions
Thread-Topic: [PATCH 1/2] include/exec: Provide the cpu_tswap() functions
Thread-Index: AQHcfxJpX9kd3Z45hkeo12U1CBikfbVYdTOAgADUOID///aMgIAFBHUA
Date: Thu, 22 Jan 2026 13:16:14 +0000
Message-ID: <00BB587B-792D-4725-A42C-AE87A201C2E2@eonerc.rwth-aachen.de>
References: <20260106-semihosting-cpu-tswap-v1-0-646576c25f56@eonerc.rwth-aachen.de>
 <20260106-semihosting-cpu-tswap-v1-1-646576c25f56@eonerc.rwth-aachen.de>
 <ee9a0216-0a1a-46ec-b647-64045c892af3@linaro.org>
 <FDDAA4F9-C389-4E63-8DEB-B0FBE38FE5CE@eonerc.rwth-aachen.de>
 <CAFEAcA-P2xqNO21rMyt2VA_tRf9yzWh8qtJFggGr4Mn-AWjj5g@mail.gmail.com>
In-Reply-To: <CAFEAcA-P2xqNO21rMyt2VA_tRf9yzWh8qtJFggGr4Mn-AWjj5g@mail.gmail.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.105.26011018
x-originating-ip: [137.226.255.149]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E9290CA0D1D554D9B4FA1A550CA1ED1@rwth-ad.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:8a60:1:e501::5:49;
 envelope-from=martin.kroening@eonerc.rwth-aachen.de;
 helo=mail-out-4.itc.rwth-aachen.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  =?utf-8?B?S3LDtm5pbmcsIE1hcnRpbg==?=
 <martin.kroening@eonerc.rwth-aachen.de>
From: martin.kroening--- via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

T24gMTkuMDEuMjYsIDEwOjM5LCBQZXRlciBNYXlkZWxsIHdyb3RlOg0KDQo+IE9uICgyKToNCj4g
DQo+ID4gQWxleCB3YXMgd29ycmllZCBhYm91dCBleHBhbmRpbmcgdGhlIHVzZSBvZiBgdmlydGlv
X2lzX2JpZ19lbmRpYW5gOg0KPiA+DQo+ID4gPiBIbW0gbG9va2luZyBhdCB0aGUgZGVzY3JpcHRp
b246DQo+ID4gPg0KPiA+ID4gLyoqDQo+ID4gPiAqIEB2aXJ0aW9faXNfYmlnX2VuZGlhbjogQ2Fs
bGJhY2sgdG8gcmV0dXJuICV0cnVlIGlmIGEgQ1BVIHdoaWNoIHN1cHBvcnRzDQo+ID4gPiAqIHJ1
bnRpbWUgY29uZmlndXJhYmxlIGVuZGlhbm5lc3MgaXMgY3VycmVudGx5IGJpZy1lbmRpYW4uDQo+
ID4gPiAqIE5vbi1jb25maWd1cmFibGUgQ1BVcyBjYW4gdXNlIHRoZSBkZWZhdWx0IGltcGxlbWVu
dGF0aW9uIG9mIHRoaXMgbWV0aG9kLg0KPiA+ID4gKiBUaGlzIG1ldGhvZCBzaG91bGQgbm90IGJl
IHVzZWQgYnkgYW55IGNhbGxlcnMgb3RoZXIgdGhhbiB0aGUgcHJlLTEuMA0KPiA+ID4gKiB2aXJ0
aW8gZGV2aWNlcy4NCj4gPiA+ICovDQo+ID4gPiBib29sICgqdmlydGlvX2lzX2JpZ19lbmRpYW4p
KENQVVN0YXRlICpjcHUpOw0KPiA+ID4NCj4gPiA+IEknbSBub3Qgc3VyZSBpZiB3ZSB3YW50IHRv
IGV4cGFuZCB0aGUgdXNhZ2Ugb2YgdGhpcyBoYWNrLiBJIHRoaW5rDQo+ID4gPiBQaGlsaXBwZSBp
cyBob3BpbmcgdG8gZ2V0IHJpZCBvZiB0aGVzZSB3YXJ0cyBldmVudHVhbGx5LiBPZiBjb3Vyc2Ug
d2UNCj4gPiA+IGNvdWxkIHJlbmFtZSB0aGUgbWV0aG9kIGFuZCBqdXN0IHByb3ZpZGUgYSB3YXkg
dG8gZ2V0IHRoZSBjdXJyZW50DQo+ID4gPiBzeXN0ZW1zIGVuZGlhbmVzcy4NCj4gPg0KPiA+IFdo
aWxlIG5vdCBiZWluZyB2ZXJ5IGZhbWlsaWFyIHdpdGggUUVNVSdzIHNvdXJjZSBjb2RlLCBzb21l
dGhpbmcgbGlrZSB0aGlzDQo+ID4gc2VlbXMgbmVjZXNzYXJ5IHRvIG1lLiBJIGNhbiByZW5hbWUg
YHZpcnRpb19pc19iaWdfZW5kaWFuYCB0byBgaXNfYmlnX2VuZGlhbmANCj4gPiBhbmQgYGNwdV92
aXJ0aW9faXNfYmlnX2VuZGlhbmAgdG8gYGNwdV9pc19iaWdfZW5kaWFuYCBpZiB5b3UgcHJlZmVy
IHRoYXQuDQo+IA0KPiBUaGUgcmVhc29uIGZvciBuYW1pbmcgdGhlc2UgZnVuY3Rpb25zIHRoZSB3
YXkgd2UgaGF2ZSBub3cgaXMNCj4gdGhhdCB3ZSByZWFsbHkgZGlkbid0IHdhbnQgdGhlbSB0byBi
ZSBhICJ0aGlzIGxvb2tzIGxpa2UgdGhlDQo+IHJpZ2h0IGZ1bmN0aW9uIHRvIHVzZSBmb3IgbXkg
cHVycG9zZSIgZ2VuZXJhbCBuYW1lIGxpa2UNCj4gImlzX2JpZ19lbmRpYW4iLiBBbG1vc3Qgbm90
aGluZyBpbiBRRU1VIG91dHNpZGUgdGhlIENQVSBpdHNlbGYNCj4gc2hvdWxkIG5lZWQgdG8ga25v
dyBhYm91dCB0aGUgZGF0YSBlbmRpYW5uZXNzIG9mIHRoZSBDUFUsDQo+IGJlY2F1c2UgaW4gcmVh
bCBoYXJkd2FyZSB0aGUgZGV2aWNlcyBjYW4ndCB0ZWxsIHdoYXQgdGhlIENQVQ0KPiBpcyBzZXQg
dXAgYXMsIHRoZXkganVzdCBnZXQvc2VuZCBkYXRhLiBUaGUgZXhjZXB0aW9ucyBhcmUNCj4gbGVn
YWN5IHZpcnRpbyAod2hpY2ggaXMgYSBtaXN0YWtlIHRoYXQgd2FzIG1hZGUgYmVjYXVzZSBub2Jv
ZHkNCj4gd2FzIHRoaW5raW5nIGFib3V0IGl0IGluIHRoZSBvcmlnaW5hbCB2aXJ0aW8gZGV2aWNl
IGRlc2lnbikNCj4gYW5kIHNvbWUgb2RkYmFsbCBpbnRlcmZhY2VzIGxpa2Ugc2VtaWhvc3Rpbmcu
IFNvIHRoZSBuYW1lIGlzDQo+IGludGVuZGVkIHRvIHB1c2ggcGVvcGxlIGF3YXkgZnJvbSB1c2lu
ZyBpdCAoYW5kIHRvd2FyZHMgZS5nLg0KPiB0YXJnZXRfYmlnX2VuZGlhbigpKS4NCg0KVGhhdCBt
YWtlcyBzZW5zZS4gSG93IGFib3V0IHNvbWV0aGluZyBsaWtlIGBpbnRlcm5hbF9pc19iaWdfZW5k
aWFuYCBhbmQgDQpgY3B1X2ludGVybmFsX2lzX2JpZ19lbmRpYW5gLCB0aGVuPyBJIGFtIGp1c3Qg
bWFraW5nIHRoaW5ncyB1cCwgdGhvdWdoLg0KR2l2ZW4gbXkgbGltaXRlZCBleHBlcmllbmNlIHdp
dGggUUVNVSBpbnRlcm5hbHMsIEkgYW0gbm90IHJlYWxseSBxdWFsaWZpZWQNCnRvIGNob29zZSBh
bnkgbmFtZS4NCg0KQ2hlZXJzLA0KTWFydGluDQoNCg==

