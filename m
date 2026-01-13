Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C22D29DEF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfaKA-0004C7-7U; Tue, 13 Jan 2026 04:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1vfaK8-0004Aw-PJ
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:04:24 -0500
Received: from mail-out-4.itc.rwth-aachen.de ([2a00:8a60:1:e501::5:49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1vfaK6-0005R3-G9
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=rwth-aachen.de; i=@rwth-aachen.de; q=dns/txt;
 s=20240516-RWTH; t=1768295062; x=1799831062;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=FjZrhuNCBg2Qf8lN9cl+9xF/p6+rSGcLAPKTAImz3MA=;
 b=mgpJecO2yzUUxpMmCZYGBulQ7gDmPZK78Jzy74PQAOkBmy8K+90lBz5z
 uw6QcOVPBC1zQOgMahd0q0SXXXT2vzPdor1hfPwaGRA1SAz2q3qC1x2/F
 KX/5Ab1nRfZuh1wilZ7KigeRMu77RSEkf4yR1SjjM0I5bR6zWgm8etUpe
 d4KIecKx5gT6Wolfy0Hm2VgQnk0AbwsaH64HyD29rld+P7NrWI/1R9GQo
 IVjITh2rMW/Yobbqo7eO9AJVyq4ZNbuPo4tbRh3H6KANDnkJp9XNHbJQr
 lWRLNxXy8nK2Ws2lku9kaP7txO1bk7zXNV2LLNyxQOyMDh8TDrnbH3HFa w==;
X-CSE-ConnectionGUID: kBOUiXIMQxudmEPyGwQ90A==
X-CSE-MsgGUID: RSKjXXf1QN2A+nIeK2wwTQ==
X-IPAS-Result: =?us-ascii?q?A2AMAwCwCWZp/58agoZaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VCFTwGEObIQDwEBAQEBAQEBAQgBUQQBAYUHAhaMVig4EwECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQYBAQEBAQEGBYEhhglThlsGIxFFEAIBCBoCJgICAi8VE?=
 =?us-ascii?q?AIEDoMHgnSsUoEygQHfAIEsFYEKLohTAYFvhACEeIIMQ4EVJw4Ngmg+iB46g?=
 =?us-ascii?q?i8EgzCUHglJeHgsAVUTFwsHBWFCQwOBBiNLBS0dgSMhHRcTH1gbBwUTI4FCB?=
 =?us-ascii?q?hwGHBICAwECAjpTDIF2AgIEghB7ggEPhyOBAAUubxoOIgJGIgMLbT03FBtBk?=
 =?us-ascii?q?1lCghWXfq9WB4I4XYEKoXIEL5dgkwsumFipFgIEAgQFAhiBf4F+cXkBgj1RF?=
 =?us-ascii?q?wIPji0WwwSBNAIHCwEBAwmCOZARAYEcAQE?=
IronPort-Data: A9a23:Rt/fqaO/VCa9hLfvrR2plsFynXyQoLVcMsEvi/4bfWQNrUp0gzAHz
 WUfWmrUOvzeZmHzL410atzk/EpU6pSEzN83HHM5pCpnJ55oRWspJvzEdBuqb3PKRiHnZBg6h
 ynLQoCYdKjYdleF+FH1dOOn9SUgvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRWmthg
 vus5ZeGULOZ82QsaDxMsvvY8EoHUMna4Vv0gHRvPZing3eDzxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg7TtE1tzbv2U8Agqe0Iw/ylWZcWq8VJcSJS1mZT7I0buKxMAzxjyZa07FdVwxwp5PY1B3
 f8yDw0MXjGmvvKrzLeWcvhDmf1ydOC+aevzulk4pd3YJew5XZDOU+DVv5pSmi0vmsALFPqYa
 8dxhThHNU+cJUQUYhFNVtRnwbbAanrXKlW0rHqQrLAr4m6VzxZ23b7sNtX9d9uMSN9e2FyHu
 mKD9m3yAhwcctCSodaA2ivy17CezXukMG4UPIeD1fxasFPK/0pJIV4QdFaY++amtnfrDrqzL
 GRRoELCt5Ma/UimXp/3Uhu+rXOsuh8aUsBXVeog52ml06fR/kOVC3YJShZHb9opstJwQiYlv
 neRn9LtADBHtLyTQGiasLCOoluP1TM9N3AeZSIUCBRfptOlup4vjlfGQpBvHcZZk+HIJN05+
 BjSxABWulnZpZVjO3mTlbwfvw+Rmw==
IronPort-HdrOrdr: A9a23:2BGEWKiM81BeG4LQNVEFTrjo+XBQXjMji2hC6mlwRA09TyX4rb
 HIoB1/73TJYVkqNU3I9errBEDiewK5yXcK2+Ys1N6ZNWHbkVClJoF67Yfk3hXsFjbz7PR93b
 1gGpIOauHYNlRxjd/77A6kO9ss29Wc6oGljerT1B5WPGRXgsdbgTuRYTz2LqQZfmh7LKt8MK
 DZy9pBrz6hc25STsOgG3EDVeSrnaypqLvWJTo9QzM27wGLjTmzrJr3CQKR0Btbcx4n+9cfzV
 Q=
X-Talos-CUID: 9a23:x2hqCW0h/fnqJnivxNk07LxfGeoCT3zt7VLpM1K0DEtRWZKKcA7I0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3Ax7NmQw+yz3txTIwRvZ9LdxWQf/1TwKaeOE5UqLN?=
 =?us-ascii?q?ckoqCFCFTYSiCsA3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,222,1763420400"; d="scan'208";a="16979807"
Received: from rwthex-w2-b.rwth-ad.de ([134.130.26.159])
 by mail-in-4.itc.rwth-aachen.de with ESMTP; 13 Jan 2026 10:04:15 +0100
Received: from rwthex-s2-a.rwth-ad.de (134.130.26.154) by
 rwthex-w2-b.rwth-ad.de (134.130.26.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 13 Jan 2026 10:04:14 +0100
Received: from rwthex-s2-a.rwth-ad.de ([fe80::e27f:2822:3e3f:84f0]) by
 rwthex-s2-a.rwth-ad.de ([fe80::e27f:2822:3e3f:84f0%4]) with mapi id
 15.02.2562.035; Tue, 13 Jan 2026 10:04:14 +0100
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Subject: Re: [PATCH 1/2] include/exec: Provide the cpu_tswap() functions
Thread-Topic: [PATCH 1/2] include/exec: Provide the cpu_tswap() functions
Thread-Index: AQHcfxJpX9kd3Z45hkeo12U1CBikfbVFSJxUgAqQbAA=
Date: Tue, 13 Jan 2026 09:04:14 +0000
Message-ID: <D159A102-9AB7-438D-AC34-33DD5830CD35@eonerc.rwth-aachen.de>
References: <20260106-semihosting-cpu-tswap-v1-0-646576c25f56@eonerc.rwth-aachen.de>
 <20260106-semihosting-cpu-tswap-v1-1-646576c25f56@eonerc.rwth-aachen.de>
 <87y0maagpj.fsf@draig.linaro.org>
In-Reply-To: <87y0maagpj.fsf@draig.linaro.org>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.104.25121423
x-originating-ip: [137.226.255.149]
Content-Type: text/plain; charset="utf-8"
Content-ID: <45FDB06CCE20244BB9DDAA71E5CB40EF@rwth-ad.de>
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

VGhhbmtzIGZvciByZXNwb25kaW5nIHNvIHN3aWZ0bHkhIFNvcnJ5IGZvciBub3QgZG9pbmcgdGhl
IHNhbWUuIEkgd2FzIHRoaW5raW5nDQptYXliZSBQaGlsaXBwZSB3b3VsZCB3YW50IHRvIGNoaW1l
IGluIGZpcnN0Lg0KDQo+ID4gKyNkZWZpbmUgY3B1X25lZWRzX2Jzd2FwKGNwdSkgKEhPU1RfQklH
X0VORElBTiAhPSBjcHVfdmlydGlvX2lzX2JpZ19lbmRpYW4oY3B1KSkNCj4gPiArDQo+IA0KPiAN
Cj4gSG1tIGxvb2tpbmcgYXQgdGhlIGRlc2NyaXB0aW9uOg0KPiANCj4gDQo+IC8qKg0KPiAqIEB2
aXJ0aW9faXNfYmlnX2VuZGlhbjogQ2FsbGJhY2sgdG8gcmV0dXJuICV0cnVlIGlmIGEgQ1BVIHdo
aWNoIHN1cHBvcnRzDQo+ICogcnVudGltZSBjb25maWd1cmFibGUgZW5kaWFubmVzcyBpcyBjdXJy
ZW50bHkgYmlnLWVuZGlhbi4NCj4gKiBOb24tY29uZmlndXJhYmxlIENQVXMgY2FuIHVzZSB0aGUg
ZGVmYXVsdCBpbXBsZW1lbnRhdGlvbiBvZiB0aGlzIG1ldGhvZC4NCj4gKiBUaGlzIG1ldGhvZCBz
aG91bGQgbm90IGJlIHVzZWQgYnkgYW55IGNhbGxlcnMgb3RoZXIgdGhhbiB0aGUgcHJlLTEuMA0K
PiAqIHZpcnRpbyBkZXZpY2VzLg0KPiAqLw0KPiBib29sICgqdmlydGlvX2lzX2JpZ19lbmRpYW4p
KENQVVN0YXRlICpjcHUpOw0KPiANCj4gDQo+IEknbSBub3Qgc3VyZSBpZiB3ZSB3YW50IHRvIGV4
cGFuZCB0aGUgdXNhZ2Ugb2YgdGhpcyBoYWNrLiBJIHRoaW5rDQo+IFBoaWxpcHBlIGlzIGhvcGlu
ZyB0byBnZXQgcmlkIG9mIHRoZXNlIHdhcnRzIGV2ZW50dWFsbHkuIE9mIGNvdXJzZSB3ZQ0KPiBj
b3VsZCByZW5hbWUgdGhlIG1ldGhvZCBhbmQganVzdCBwcm92aWRlIGEgd2F5IHRvIGdldCB0aGUg
Y3VycmVudA0KPiBzeXN0ZW1zIGVuZGlhbmVzcy4NCg0KDQpJIGFtIG5vdCB2ZXJ5IGZhbWlsaWFy
IHdpdGggUUVNVSdzIHNvdXJjZSBjb2RlLCBidXQgaGF2aW5nIGEgd2F5IHRvIGdldCB0aGUNCmN1
cnJlbnQgc3lzdGVtJ3MgZW5kaWFubmVzcyBzb3VuZHMgbmVjZXNzYXJ5IHRvIG1lIGNvbnNpZGVy
aW5nIHNlbWlob3N0aW5nJ3MNCnJlcXVpcmVtZW50cy4gU2hvdWxkIEkganVzdCByZW5hbWUgYHZp
cnRpb19pc19iaWdfZW5kaWFuYCB0byBgaXNfYmlnX2VuZGlhbmANCmFuZCBgY3B1X3ZpcnRpb19p
c19iaWdfZW5kaWFuYCB0byBgY3B1X2lzX2JpZ19lbmRpYW5gIG9yIGRvIHlvdSBwcmVmZXINCmRp
ZmZlcmVudCBuYW1lcz8NCg0K

