Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DD2CCF2CF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 09:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhlJo-0002pM-IM; Mon, 19 Jan 2026 04:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1vhlJm-0002gv-21
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 04:13:02 -0500
Received: from mail-out-3.itc.rwth-aachen.de ([2a00:8a60:1:e501::5:48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1vhlJi-0004Rt-EC
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 04:13:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=rwth-aachen.de; i=@rwth-aachen.de; q=dns/txt;
 s=20240516-RWTH; t=1768813978; x=1800349978;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=2XJooU4YfGrTuPeAOT1LvWlBVk6213zopt2KylvjcTA=;
 b=VZuRPG6pXqriQyZLAEYzfmItUFI4nq044V2bHoF4l3o8TaUGa7l9B1pa
 u3BFPE4xZCLFfriyZz8J9R2EHirOzbIhSnXaauOxrn1tjwvfy2PL8tGQd
 IFCVlYnC2zlGLzkzUK0HOySI5/ARKiAavMTU0qTHxIyfDF6efrN/jbYU1
 qQzKPZbANaSv4rRBi32VlnJlarYWHnZh+KuBmqddbwik1yk3dqDjOrltH
 ZpDKzZOFYxpjfQlIgOQBSxRaIeDRe3TkRajToZvvhRMrScg2TbaRYkFGI
 ZGHkwjeAXOrnjDF+BLRBPUeMuENO4pKGF14BUPAHknv/VFEc1oi1G7NHp w==;
X-CSE-ConnectionGUID: lg3Df0h9QU2F8h8nI4/iUg==
X-CSE-MsgGUID: CPmN1ZjARtyAijXukOU70w==
X-IPAS-Result: =?us-ascii?q?A2DvAABj9G1p/5sagoZaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBUIIYh3GRdAOgGQ8BAQEBAQEBAQEIAVEEAQGCE4J0AhaMYyc4EwECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEBAQEBAQsBAQYBAQEBAQEGBYEhhglThlsBBAEjEUUFC?=
 =?us-ascii?q?wIBCBoCJgICAi8VEAIEAQ2DB4JNJ7FagTKBAd8BgSwVgQouiFMBgW+EAIR4g?=
 =?us-ascii?q?gxDgRUnDg2CaD6EQxeDRDqCLwSCIoEOiiwGgUiIFAlJeHgsAVUTFwsHBWFCE?=
 =?us-ascii?q?DMDKi8tI0sFLR1wDCcSDx0XEx9YGwcFEyNsBhsGHBICAwECAjpTDIF2AgIEg?=
 =?us-ascii?q?hB7ggEPhw6BAAUubxoOIgJBUgMLbT03Bg4bQZJyBj5CgggNBF8LlxCvVgeCO?=
 =?us-ascii?q?F2BCqFyBC+XYJMLLphYIqh0AgQCBAUCGIF/gX5xeQGCPVEXAg+OLRaBEgEMy?=
 =?us-ascii?q?SyBNAIHAQoBAQMJgjmRLgEB?=
IronPort-Data: A9a23:iJxvGauIGiOrJhAbbkDIKZEiFefnVFlfMUV32f8akzHdYApBsoF/q
 tZmKW6Gbq2JYDT1Ldtxa9i28kpSscWEytNnQAA5r3phESMXgMeUXt7xwmUcns+xBpCZEBg3v
 512hv3odp1coqr0/0/1WlTZhSAik/nOHfykVLKs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82AyaDt8B56r8ks14qyr4WNA5DTSWNgS1LPgvyhNZH4gDfzpR5fIatE8NvK3Q
 e/F0Ia48gvxlz8xCsmom6rMaUYDRLjfJ2Cm0hK6jID733CuDgRrukoKHKJ0hXV/0l1lrPgto
 Dl5jqFcfC9yVkH6sLlHD0MIQ3kW0Zpuo9crKVDn2SCaItavn3HEm52CB2luVWEUF3oe7Wxmr
 ZQlxD4xgh+rg+3t7LzjSrhVu54NfMm7OqJD/XBdwmSMZRomacirr6Ti3+Bk/BoAw/sUWNyYf
 dUFaX9mYFLMbnWjOH9OU854xbzwwCOhNWQF9Tp5poJui4TX5Al4yqTsNpzWYNuHQ8RTkW6Vo
 WTL5W+/GA4GNJmWwDGF/3TqiuKncSbTA9tKTOXmq6Y76LGV7kcrDTtPZ1mSm+Woo0+8a89cD
 HFLojV7+MDe82TuFLERRSaQuH6FuhsQc95RFeQg70eK0KW8yx+UA3VBQjNfZdgOssgwSjo3k
 FiTkLvBDDhioPufRHSb+7q8qTK0MDISa2gYakc5oRAt+cb/oIwjywmVC9wlCrGpjpj8FXf8z
 lhmsRQDulnatuZTv43TwLwNq2jESkThJuLt2jjqYw==
IronPort-HdrOrdr: A9a23:40l00q7sQ6aKX++QPwPXwPvXdLJyesId70hD6qkRc202TiX2rb
 HLoB12726WtN9uYgBHpTnwAtjkfZq0z/cciuhwAV7IZniAhILHFvAa0WKb+UyZJ8QSzINgPL
 1bHJRWOZnLFFB/yfzx5hK1euxN/DCYys6VbDjlpUtQcQ==
X-Talos-CUID: 9a23:uwWIbmPcaQRqEu5DXCY82EBMGpEcTyfznHeAJW7kTmdUR+jA
X-Talos-MUID: 9a23:Qp6iyAmsgp61skSxfPEndnpJDMJOupasIXoRgLwHufmZNgtNZG+C2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,237,1763420400"; d="scan'208";a="310006509"
Received: from rwthex-s2-b.rwth-ad.de ([134.130.26.155])
 by mail-in-3.itc.rwth-aachen.de with ESMTP; 19 Jan 2026 10:12:50 +0100
Received: from rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154) by
 RWTHEX-S2-B.rwth-ad.de (2a00:8a60:1:e500::26:155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 19 Jan 2026 10:12:49 +0100
Received: from rwthex-s2-a.rwth-ad.de ([fe80::e27f:2822:3e3f:84f0]) by
 rwthex-s2-a.rwth-ad.de ([fe80::e27f:2822:3e3f:84f0%4]) with mapi id
 15.02.2562.035; Mon, 19 Jan 2026 10:12:49 +0100
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 1/2] include/exec: Provide the cpu_tswap() functions
Thread-Topic: [PATCH 1/2] include/exec: Provide the cpu_tswap() functions
Thread-Index: AQHcfxJpX9kd3Z45hkeo12U1CBikfbVYdTOAgADUOIA=
Date: Mon, 19 Jan 2026 09:12:49 +0000
Message-ID: <FDDAA4F9-C389-4E63-8DEB-B0FBE38FE5CE@eonerc.rwth-aachen.de>
References: <20260106-semihosting-cpu-tswap-v1-0-646576c25f56@eonerc.rwth-aachen.de>
 <20260106-semihosting-cpu-tswap-v1-1-646576c25f56@eonerc.rwth-aachen.de>
 <ee9a0216-0a1a-46ec-b647-64045c892af3@linaro.org>
In-Reply-To: <ee9a0216-0a1a-46ec-b647-64045c892af3@linaro.org>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.105.26011018
x-originating-ip: [2a0a:a54b:1c96:0:5562:fcec:b2fe:7340]
Content-Type: text/plain; charset="utf-8"
Content-ID: <46B27F6A393CE449860DDCF708887B4D@rwth-ad.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:8a60:1:e501::5:48;
 envelope-from=martin.kroening@eonerc.rwth-aachen.de;
 helo=mail-out-3.itc.rwth-aachen.de
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

SGkgUGhpbGlwcGUsDQoNCk9uIDE4LjAxLjI2LCAyMjozMywgUGhpbGlwcGUgTWF0aGlldS1EYXVk
w6kgd3JvdGU6DQoNCj4gPiBUaGVzZSBmdW5jdGlvbnMgYXJlIG5lZWRlZCBmb3IgQ1BVcyB0aGF0
IHN1cHBvcnQgcnVudGltZS1jb25maWd1cmFibGUgZW5kaWFubmVzcy4NCj4gPiBJbiB0aG9zZSBj
YXNlcywgY29tcG9uZW50cyBzdWNoIGFzIHNlbWlob3N0aW5nIG5lZWQgdG8gcGVyZm9ybQ0KPiA+
IHJ1bnRpbWUtZGVwZW5kZW50IGJ5dGUgc3dhcHMuDQo+DQo+IEFyZSB5b3UgdGFyZ2V0dGluZyB1
c2VyIG9yIHN5c3RlbSBlbXVsYXRpb24/DQo+IA0KPiBJIHN1cHBvc2UgdXNlciBlbXVsYXRpb24s
IG90aGVyd2lzZSB5b3UnZCBoYXZlIHVzZWQgdGhlDQo+ICJzZW1paG9zdGluZy91YWNjZXNzLmgi
IEFQSS4NCj4NCj4gQnV0IHRoZW4gSSdtIGNvbmZ1c2VkIGJlY2F1c2UgYSB1c2VyIHByb2Nlc3Mg
Y2FuJ3QgY2hhbmdlDQo+IHRoZSBDUFUgZW5kaWFubmVzcy4uLg0KPg0KPiBDYW4geW91IGV4cGxh
aW4geW91ciB1c2UgY2FzZT8NCg0KVGhhbmtzIGZvciBhc2tpbmchIEkgYW0gdGFyZ2V0aW5nIHN5
c3RlbSBlbXVsYXRpb24uIE15IHVzZSBjYXNlIGlzIGVtdWxhdGluZw0KYmFyZS1tZXRhbCBzb2Z0
d2FyZSBzdWNoIGFzIGFuIE9TIHRoYXQgc3dpdGNoZXMgdGhlIEFBcmNoNjQgQ1BVIHRvIGJpZy1l
bmRpYW4NCm1vZGUgZHVyaW5nIHJ1bnRpbWUuDQoNCmB7Z2V0LHNldH1fdXNlcl91ezY0LDMyfWAg
ZnJvbSAic2VtaWhvc3RpbmcvdWFjY2Vzcy5oIiBjdXJyZW50bHkgdXNlDQpgdHN3YXB7MzIsNjR9
YCBmcm9tICJleGVjL3Rzd2FwLmgiLCB3aGljaCBkbyBub3QgcmVzcGVjdCBydW50aW1lLWNvbmZp
Z3VyYWJsZQ0KZW5kaWFubmVzcy4NCg0KUEFUQ0ggMS8yIGludHJvZHVjZXMgYGNwdV90c3dhcHsz
Miw2NH1gLCB3aGljaCBQQVRDSCAyLzIgaW50ZWdyYXRlcyBpbnRvDQoic2VtaWhvc3RpbmcvdWFj
Y2Vzcy5oIi4gSSBjYW4gc3F1YXNoIHRob3NlIGNvbW1pdHMgaWYgeW91IHByZWZlciwgb2YgY291
cnNlLg0KT3IgZGlkIEkgbWlzdW5kZXJzdGFuZCB5b3VyIHF1ZXN0aW9uPw0KDQpBbGV4IHdhcyB3
b3JyaWVkIGFib3V0IGV4cGFuZGluZyB0aGUgdXNlIG9mIGB2aXJ0aW9faXNfYmlnX2VuZGlhbmA6
DQoNCj4gSG1tIGxvb2tpbmcgYXQgdGhlIGRlc2NyaXB0aW9uOg0KPiANCj4gICAgIC8qKg0KPiAg
ICAgICogQHZpcnRpb19pc19iaWdfZW5kaWFuOiBDYWxsYmFjayB0byByZXR1cm4gJXRydWUgaWYg
YSBDUFUgd2hpY2ggc3VwcG9ydHMNCj4gICAgICAqIHJ1bnRpbWUgY29uZmlndXJhYmxlIGVuZGlh
bm5lc3MgaXMgY3VycmVudGx5IGJpZy1lbmRpYW4uDQo+ICAgICAgKiBOb24tY29uZmlndXJhYmxl
IENQVXMgY2FuIHVzZSB0aGUgZGVmYXVsdCBpbXBsZW1lbnRhdGlvbiBvZiB0aGlzIG1ldGhvZC4N
Cj4gICAgICAqIFRoaXMgbWV0aG9kIHNob3VsZCBub3QgYmUgdXNlZCBieSBhbnkgY2FsbGVycyBv
dGhlciB0aGFuIHRoZSBwcmUtMS4wDQo+ICAgICAgKiB2aXJ0aW8gZGV2aWNlcy4NCj4gICAgICAq
Lw0KPiAgICAgYm9vbCAoKnZpcnRpb19pc19iaWdfZW5kaWFuKShDUFVTdGF0ZSAqY3B1KTsNCj4g
DQo+IEknbSBub3Qgc3VyZSBpZiB3ZSB3YW50IHRvIGV4cGFuZCB0aGUgdXNhZ2Ugb2YgdGhpcyBo
YWNrLiBJIHRoaW5rDQo+IFBoaWxpcHBlIGlzIGhvcGluZyB0byBnZXQgcmlkIG9mIHRoZXNlIHdh
cnRzIGV2ZW50dWFsbHkuIE9mIGNvdXJzZSB3ZQ0KPiBjb3VsZCByZW5hbWUgdGhlIG1ldGhvZCBh
bmQganVzdCBwcm92aWRlIGEgd2F5IHRvIGdldCB0aGUgY3VycmVudA0KPiBzeXN0ZW1zIGVuZGlh
bmVzcy4NCg0KV2hpbGUgbm90IGJlaW5nIHZlcnkgZmFtaWxpYXIgd2l0aCBRRU1VJ3Mgc291cmNl
IGNvZGUsIHNvbWV0aGluZyBsaWtlIHRoaXMNCnNlZW1zIG5lY2Vzc2FyeSB0byBtZS4gSSBjYW4g
cmVuYW1lIGB2aXJ0aW9faXNfYmlnX2VuZGlhbmAgdG8gYGlzX2JpZ19lbmRpYW5gDQphbmQgYGNw
dV92aXJ0aW9faXNfYmlnX2VuZGlhbmAgdG8gYGNwdV9pc19iaWdfZW5kaWFuYCBpZiB5b3UgcHJl
ZmVyIHRoYXQuDQoNCkNoZWVycywNCk1hcnRpbg0KDQo=

