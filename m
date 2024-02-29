Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC30C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 07:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfaXD-0000oR-UR; Thu, 29 Feb 2024 02:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <poffer@nvidia.com>) id 1rfaXC-0000nH-AQ
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 02:08:50 -0500
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com
 ([40.107.236.40] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <poffer@nvidia.com>) id 1rfaX5-0004Aa-0f
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 02:08:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MU1HVpbK4tK+Cwn+gJYhsbOhO6Kp8EDx0kCKrCTdlVBZPCsW7QjxOtU7jKedIla5FBbWwHqtML24djqhq6Q3M1QytUuqvP+nEb82qEB942jatMjFV645vLanyKMTzR4+7wGVmbKDWCsq/cNYygkVhkThT6kjsFEXpDe2ML+g9Oi/O4Q6cZYWwwdY1T7ueUaPDB9LL/uC2TFhtH4x9fmV52+k0QKrxqMwv+AJ+B51qrFvy4LEbLFyd5ZZCxc6YIx8ONGeg/FLCTqVCcwwYvfgTL7w4CR6SOudYKo8lc03xfWmow54fMTqPmZhZvUfI9A3befbMZpX5cVSNUTuLD/AQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kgfv7lwAswpJZBIvSPS5pt/Bb2qA7lEESM0VDvAkms=;
 b=RqNmOzSuZWfZ6+8K6/UF4Tc9li+PDk5LlprWQq+MZjQG4ZHRcW3Z8HCf21RAXcHbVtgYrR3m+mLvsLC2z+PyBAOlZHy5ZD/4/pIO0pzw1KNkOuo/HjYCjIaov0oqo5eB4s1LjLEKmJvLYs+901/YljJ4qIDiMoUy5646CsGPVpMvB2oowGW+mrVdXoD6rOeJajaKw3brVo5FzeSsGsia2/i4epAy+OGYS5teZYgEnP/b7bSJXjE418VEACxS+WfgzUHC9lu0oIZewW9/PF9zLAVSY6rvKX/ID/Nes/ApN10q3AmMGd36DI83V3JG53V7GKAhutNo+nJnCORZl2NKFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kgfv7lwAswpJZBIvSPS5pt/Bb2qA7lEESM0VDvAkms=;
 b=OiYn9Im/RVpQLubiB2wAl2ikLTw/k1Ee0FiqIMtrdvFWtjN4daTOmE9lQ/Kc5Cv8n5Og8gF92XpfiQ6F69sIOyIj0kdClTKobQp4MhP6aYeeIjImhhiXHvvGKSmYOZ5e/o6cUuWNoPy/ody1xXJPfeN6WWu5ETUZlmMu+i6ZJ/CkoAHEwmT2fgdpqIBFf2DGJNkS/1JSs0zsUUarMjYmEId9naLOYW2wAnELwcvnmEiJjpm0voHvGQLkCsj/zvNTLPymk7ADOXoKtXx4QZNHoyIpI/ZJFdv6GB+Jqlg0K9Rpe97jCtkxGiS2krBqzBjwzuce6YlQovkTtAfsrrVCOQ==
Received: from MW4PR12MB6997.namprd12.prod.outlook.com (2603:10b6:303:20a::14)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 07:03:35 +0000
Received: from MW4PR12MB6997.namprd12.prod.outlook.com
 ([fe80::1afb:ba76:620e:60c4]) by MW4PR12MB6997.namprd12.prod.outlook.com
 ([fe80::1afb:ba76:620e:60c4%7]) with mapi id 15.20.7316.032; Thu, 29 Feb 2024
 07:03:35 +0000
From: Paz Offer <poffer@nvidia.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: ISO C90 compilation error
Thread-Topic: ISO C90 compilation error
Thread-Index: AQHaatn2NUOFjOdAQUCmfxifs8fkmg==
Date: Thu, 29 Feb 2024 07:03:35 +0000
Message-ID: <MW4PR12MB6997B8D6225D08E8F3E2DE55A05F2@MW4PR12MB6997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6997:EE_|SJ0PR12MB5663:EE_
x-ms-office365-filtering-correlation-id: 33a8d64d-56d8-4c93-ff89-08dc38f48c0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uGTsaVWQa07CUOUkDTOPW31I7xJmpQVe1qIuihmO2N1NUIqpg+hlcjed9+iUBfzP3y1qu6OW3CdNqv4+Vpvn2tQWEMYh1iCfhbGKjWys3Mqmzu6y9Lke1iLSeVEwYzN0uKiMZuEOMkqJGBjLg8s585ZOvbS0YOFyJYPAXNHSNtY6cZDVr5908F8Ywht7UKnatY9XN4beqOa37C/B4UcOL/0OWZYQpANOo/8jZaJ0SxR54Ylx8Eg9AROGcKdACihDxGVErbORGXzLXZxDzWPks4PBQXjKYsmXVM/WGjuDl6R9NCo5h1w1ZND7Spdtq5lrFhbjJ98fDE7yCn7uPBx19qUFUy+zqoqZ/dAxPJkI1PFrQyN9xqXGwHrZ4l4bUIUaXSembWXwW5qyG0Jcd69K3iJCRMBDBW8BoRqUG5Mx2S1UGq7LTFj1TFt1+fX6JQCz/dZWFmWwN+qjdJqRpvauKng78CbJfgkOi+a8wmd6AsXUuz3Lp86zmrLbVHXGDpmFnhHWCEx5kyXRFgCeKq1lFQSbhX2c3gQSOgBYxC1ze7/z5rpJ3TIsHEUPRMNBY22oCpZqlcv6NQ45OOzx72TdsOjWxoBQoIg8xpN/VNVuX5FUCdFPxZGln4qNKAtnO+ZmlqD/JnXMi18dZQbZnUnRSIrrnDmRtHp7gVvkCcq167uiFoC1Ml1UZyC7dB4GJpzL/nQF/ovHxunjMritCG1AJUsiQSUZr5QyapLCwl21Xug=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clpmanlKUmJUaTNMa3NjeVk2Qi9JbVVLbm83ZTJ3dVRXVVVCandFM3h2eHUz?=
 =?utf-8?B?OHVISnRSTWhzUnZPQUdtSWd2eGpoYmV5V005RXdhWTQzRXFMSmR5aFpnSGZK?=
 =?utf-8?B?c2tPN0wyOW0rVDhyR0svRWgvNmg0cHFmUjlMY1lVWGNab0FSSDdqc3ZiTDJ3?=
 =?utf-8?B?MG96bStFajdRa3NNcG9rMzk4K3kyUWRZRTNGZmxkYzhUMVZOMk1ES1JwZGhV?=
 =?utf-8?B?QURMYkhjUHdINE9ZOEZQVFI5YUVzRDNRMFVMV3BwU3FhRDdQczVTZXpvWkpO?=
 =?utf-8?B?b0ZOUmkwWk90Q1Yxa2xGMEhwQjdVSWx6aDduOXVLWVVabitiUytVcEVsQXg2?=
 =?utf-8?B?ZWxNTHNBU3JxbWZySDQ3KzJTYXN4SnR0azJVMHhCZERiNHBwNUpYWWV6TDU2?=
 =?utf-8?B?U0NlaHN2UjlMWFNZUzVNTWdnV3NHWjNyQ3VQSzFyVXJFOE82QjE1Y3dKQks1?=
 =?utf-8?B?N2hzMVk2R2NmTThRQjdTL2RDRUFEcm8rWlFZZDZOQXBhNllMWjhWUGxBSXBj?=
 =?utf-8?B?VGQ0U0FHdStvWnRRTHlDRzhXc0RhL3hlUVRjTzJWOUlQMlNrdG1FS0ZGS1Bw?=
 =?utf-8?B?OVJpdFZ5eVczOWVVOUh5MnhMVUtMUW1TWGhkdnpaY1BKRUJ5VGUxMSszTkNE?=
 =?utf-8?B?ZUhSN2c1R1FKY3l6YU4zOEppeWp1UkN2YldCZTVWRU93MWtJaGVYcEtSSGxB?=
 =?utf-8?B?NEpkMTRaYzdqekxFc3JqMmFBdmk3Q2dGSGpGdWJHUHNzRG0zZkxyMWx0Y3pp?=
 =?utf-8?B?bmRIL0JHTlhNeGZma3N4N0hhaE1hK2g3VzZqanVmS1pnZDcyTHljdXRvdWN1?=
 =?utf-8?B?ZnYrY3JadWRONmhuUTF4UVdzaXdCclVqVmJOOWxkQnVrS1dlQm5JMG5ERC9Y?=
 =?utf-8?B?Y0RUTEc3cThpMG5FTmRmdlROeWJ3ZDdpdVlWSkNnblA2eE4zWXhMWjh3Yit4?=
 =?utf-8?B?bEd6RThNSGVEZy9taVZnanpSMmIyWDlyaWhXc0pweElmTjFXa1h3N3pjdGVK?=
 =?utf-8?B?bEEwT2JrdmlocG5DS1VBZU1BWm16cVA2T3JpdDNpYUxHelZzcTluV3FQdXlV?=
 =?utf-8?B?UzVNYk9xaUVmclRaMTNZQUlQYndqQXBkWWp5Q2NPQTM2TTYvRTRsTFQzaEoy?=
 =?utf-8?B?UG91aTdVU3l6Z0xWdUJLbS9ub2plZHZJeWRGUC9mRmlOOC9kbnlTaUdJaUpx?=
 =?utf-8?B?WFNpZ29XWXhta2l3M256QVFTZ1pRL25SNURLYytFNENUbTV4R1NFWmNZQ01m?=
 =?utf-8?B?MUZXSDV5bmh4Q283VUZsclZBOUU4cmJERTVPS3BSNVAxWEd0U2FLWGoza0Vi?=
 =?utf-8?B?SUxXUW9qdENDa21XU3VUcjdSRURDSlRHbU0xOVEybjExdlF2a0QrQWRwSldI?=
 =?utf-8?B?UnpIajFwem9wWTVOOUtYWC9SMjJ4VHg4c2RlcU1VenNqTDFiM0NuSjBIaG9J?=
 =?utf-8?B?cm5kTWdDY1d1NVBEMk95RThza0VpelpLOWJHMTJZZyt4MzFkR1JONzV0M1dw?=
 =?utf-8?B?Wit0aHA0aU9GaTFFSHJCWGU5OFR0TTZKdUE1b3VESXBvbHF3VTRGdzBIUTFW?=
 =?utf-8?B?ZFRPL041eDI0ZWpKbU9Hejc5M2pVUHpSMjQ2MTNKd2g4ZkJtM0lpalZHRmla?=
 =?utf-8?B?WEdwSlBIZ3JjOHhxQUs5d0twblZ4L2lXZE51UFptQS9LbUZ5YVRkZlBDODh1?=
 =?utf-8?B?NkhNWjJLOU1YK05pejZ6aWJxaXl4OHpyMVA4US9oTEl3U2trREdMTlJXdmZh?=
 =?utf-8?B?MW9uOHRKNmk3b2NtWThCOGkxdHJXempNamRJWnpaNlcxb2Y5Y1AvV3NxZGJv?=
 =?utf-8?B?QTJXbmlEMkczZS94NnVVTFgzK1dwZUo1NzNCTWptU0lkc1JKeFFYMHREZ0xK?=
 =?utf-8?B?cUI3S25PRHp4cmcyUlJ0dDdTNy93aW1kOEhNM3BnblJRR2VBeUlqYVZPMEVR?=
 =?utf-8?B?NithRDlDV3gwQVB5VFl1dklLdmF5TW0yQmZVaFBNQXVudFFlMWNwMDh1RnYw?=
 =?utf-8?B?SDhKSzVhY3llR0NOOVZseEZvcE9iZG9SYjlnRjJwcnEzVHA2SnJmV1dDOGhM?=
 =?utf-8?B?TzhiM0tKWUtqVGF6T0J1UHlSTkVLZlVWNGlwSk8xZUNuVW93cGExN2FsSDll?=
 =?utf-8?Q?86iA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MW4PR12MB6997B8D6225D08E8F3E2DE55A05F2MW4PR12MB6997namp_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a8d64d-56d8-4c93-ff89-08dc38f48c0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 07:03:35.2130 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JbDpZyqbk3rTGaQkdj42Ky+8fY2Lu0495v5uEALI7zGKI2UJau+iGUpXoDWbCcMMKgoMkwGWZg9gbZbenfJydA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663
Received-SPF: softfail client-ip=40.107.236.40; envelope-from=poffer@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

--_000_MW4PR12MB6997B8D6225D08E8F3E2DE55A05F2MW4PR12MB6997namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkkgYW0gdHJ5aW5nIHRvIGJ1aWxkIG15IGNvZGUgd2l0aCBRRU1VIGFuZCBnZXR0aW5n
IGNvbXBpbGF0aW9uIGVycm9yIGFjY29yZGluZyB0byB0aGUgSVNPIEM5MCBzdGFuZGFyZDoNCg0K
4oCC4oCC4oCC4oCC4oCC4oCCY29uc3Qgc2l6ZV90IGJ1Zl9zaXplID0gMzE7DQrigILigILigILi
gILigILigIJjaGFyIGJ1ZmZlcltidWZfc2l6ZSArIDFdOw0KDQrigILigILigILigILigILigIJl
cnJvcjogSVNPIEM5MCBmb3JiaWRzIGFycmF5IOKAmGJ1ZmZlcuKAmSB3aG9zZSBzaXplIGNhbuKA
mXQgYmUgZXZhbHVhdGVkIFstV2Vycm9yPXZsYV0NCg0KSSBub3RpY2VkIHRoYXQgdGhlIGNvZGUg
YnVpbGRzIHdpdGggJy1zdGQ9Z251MTEnLCB3aGljaCBpcyBuZXdlciB0aGVuIEM5MCwgc28gdGhp
cyBpcyBub3QgY2xlYXIgdG8gbWUgd2h5IEkgZ2V0IHRoaXMgZXJyb3IuDQpXaGVyZSBpcyB0aGUg
Y29ycmVjdCBwbGFjZSB0byBzcGVjaWZ5IHRoZSBsYW5ndWFnZSB2ZXJzaW9uIGZvciB0aGlzPw0K
DQpJIGFtIGJ1aWxkaW5nIFFFTVUgdXNpbmcgdGhlIGluc3RydWN0aW9ucyBvbiBRRU1VIHNpdGUg
KGNvbmZpZ3VyZSwgbWFrZSkuDQoNClRoYW5rcywNClBheg0KDQo=

--_000_MW4PR12MB6997B8D6225D08E8F3E2DE55A05F2MW4PR12MB6997namp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgc3R5bGU9
ImRpc3BsYXk6bm9uZTsiPiBQIHttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO30gPC9zdHls
ZT4NCjwvaGVhZD4NCjxib2R5IGRpcj0ibHRyIj4NCjxkaXYgY2xhc3M9ImVsZW1lbnRUb1Byb29m
Ij48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6IEFwdG9zLCBBcHRvc19FbWJlZGRlZEZvbnQsIEFw
dG9zX01TRm9udFNlcnZpY2UsIENhbGlicmksIEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1z
aXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+SGksPC9zcGFuPjwvZGl2Pg0KPGRpdj48
c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6IEFwdG9zLCBBcHRvc19FbWJlZGRlZEZvbnQsIEFwdG9z
X01TRm9udFNlcnZpY2UsIENhbGlicmksIEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXpl
OiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+PGJyPg0KPC9zcGFuPjwvZGl2Pg0KPGRpdiBj
bGFzcz0iZWxlbWVudFRvUHJvb2YiPjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTogQXB0b3MsIEFw
dG9zX0VtYmVkZGVkRm9udCwgQXB0b3NfTVNGb250U2VydmljZSwgQ2FsaWJyaSwgSGVsdmV0aWNh
LCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiByZ2IoMCwgMCwgMCk7Ij5JIGFt
IHRyeWluZyB0byBidWlsZCBteSBjb2RlIHdpdGggUUVNVSBhbmQgZ2V0dGluZyBjb21waWxhdGlv
biBlcnJvciBhY2NvcmRpbmcgdG8gdGhlDQo8aT5JU08gQzkwIDwvaT5zdGFuZGFyZDo8L3NwYW4+
PC9kaXY+DQo8ZGl2IGNsYXNzPSJlbGVtZW50VG9Qcm9vZiI+PHNwYW4gc3R5bGU9ImZvbnQtZmFt
aWx5OiBBcHRvcywgQXB0b3NfRW1iZWRkZWRGb250LCBBcHRvc19NU0ZvbnRTZXJ2aWNlLCBDYWxp
YnJpLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigw
LCAwLCAwKTsiPjxicj4NCjwvc3Bhbj48L2Rpdj4NCjxkaXYgY2xhc3M9ImVsZW1lbnRUb1Byb29m
Ij48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6ICZxdW90O0NvdXJpZXIgTmV3JnF1b3Q7LCBtb25v
c3BhY2U7IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPuKAguKAguKAguKA
guKAguKAgmNvbnN0IHNpemVfdCBidWZfc2l6ZSA9IDMxOzwvc3Bhbj48L2Rpdj4NCjxkaXYgY2xh
c3M9ImVsZW1lbnRUb1Byb29mIj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6ICZxdW90O0NvdXJp
ZXIgTmV3JnF1b3Q7LCBtb25vc3BhY2U7IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAw
LCAwKTsiPuKAguKAguKAguKAguKAguKAgmNoYXIgYnVmZmVyW2J1Zl9zaXplICsgMV07PC9zcGFu
PjwvZGl2Pg0KPGRpdiBjbGFzcz0iZWxlbWVudFRvUHJvb2YiPjxzcGFuIHN0eWxlPSJmb250LWZh
bWlseTogQXB0b3MsIEFwdG9zX0VtYmVkZGVkRm9udCwgQXB0b3NfTVNGb250U2VydmljZSwgQ2Fs
aWJyaSwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiByZ2Io
MCwgMCwgMCk7Ij48YnI+DQo8L3NwYW4+PC9kaXY+DQo8ZGl2IGNsYXNzPSJlbGVtZW50VG9Qcm9v
ZiI+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiBBcHRvcywgQXB0b3NfRW1iZWRkZWRGb250LCBB
cHRvc19NU0ZvbnRTZXJ2aWNlLCBDYWxpYnJpLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQt
c2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPuKAguKAguKAguKAguKAguKAgjwvc3Bh
bj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6IEFwdG9zLCBBcHRvc19FbWJlZGRlZEZvbnQsIEFw
dG9zX01TRm9udFNlcnZpY2UsIENhbGlicmksIEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1z
aXplOiAxMnB0OyBjb2xvcjogcmdiKDIzNywgOTIsIDg3KTsiPmVycm9yOg0KIElTTyBDOTAgZm9y
YmlkcyBhcnJheSDigJhidWZmZXLigJkgd2hvc2Ugc2l6ZSBjYW7igJl0IGJlIGV2YWx1YXRlZCBb
LVdlcnJvcj12bGFdPC9zcGFuPjwvZGl2Pg0KPGRpdj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6
IEFwdG9zLCBBcHRvc19FbWJlZGRlZEZvbnQsIEFwdG9zX01TRm9udFNlcnZpY2UsIENhbGlicmks
IEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAs
IDApOyI+PGJyPg0KPC9zcGFuPjwvZGl2Pg0KPGRpdiBjbGFzcz0iZWxlbWVudFRvUHJvb2YiPjxz
cGFuIHN0eWxlPSJmb250LWZhbWlseTogQXB0b3MsIEFwdG9zX0VtYmVkZGVkRm9udCwgQXB0b3Nf
TVNGb250U2VydmljZSwgQ2FsaWJyaSwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6
IDEycHQ7IGNvbG9yOiByZ2IoMCwgMCwgMCk7Ij5JIG5vdGljZWQgdGhhdCB0aGUgY29kZSBidWls
ZHMgd2l0aCAnLXN0ZD1nbnUxMScsIHdoaWNoIGlzIG5ld2VyIHRoZW4gQzkwLCBzbyB0aGlzIGlz
DQogbm90IGNsZWFyIHRvIG1lIHdoeSBJIGdldCB0aGlzIGVycm9yLjwvc3Bhbj48L2Rpdj4NCjxk
aXYgY2xhc3M9ImVsZW1lbnRUb1Byb29mIj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6IEFwdG9z
LCBBcHRvc19FbWJlZGRlZEZvbnQsIEFwdG9zX01TRm9udFNlcnZpY2UsIENhbGlicmksIEhlbHZl
dGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+
V2hlcmUgaXMgdGhlIGNvcnJlY3QgcGxhY2UgdG8gc3BlY2lmeSB0aGUgbGFuZ3VhZ2UgdmVyc2lv
biBmb3IgdGhpcz88L3NwYW4+PC9kaXY+DQo8ZGl2IGNsYXNzPSJlbGVtZW50VG9Qcm9vZiI+PHNw
YW4gc3R5bGU9ImZvbnQtZmFtaWx5OiBBcHRvcywgQXB0b3NfRW1iZWRkZWRGb250LCBBcHRvc19N
U0ZvbnRTZXJ2aWNlLCBDYWxpYnJpLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTog
MTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPjxicj4NCjwvc3Bhbj48L2Rpdj4NCjxkaXYgY2xh
c3M9ImVsZW1lbnRUb1Byb29mIj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6IEFwdG9zLCBBcHRv
c19FbWJlZGRlZEZvbnQsIEFwdG9zX01TRm9udFNlcnZpY2UsIENhbGlicmksIEhlbHZldGljYSwg
c2Fucy1zZXJpZjsgZm9udC1zaXplOiAxNnB4OyBjb2xvcjogcmdiKDAsIDAsIDApOyBiYWNrZ3Jv
dW5kLWNvbG9yOiByZ2IoMjU1LCAyNTUsIDI1NSk7Ij5JIGFtIGJ1aWxkaW5nIFFFTVUgdXNpbmcg
dGhlIGluc3RydWN0aW9ucyBvbiBRRU1VDQogc2l0ZSAoY29uZmlndXJlLCBtYWtlKS48L3NwYW4+
PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiBBcHRvcywgQXB0b3NfRW1iZWRkZWRGb250LCBBcHRv
c19NU0ZvbnRTZXJ2aWNlLCBDYWxpYnJpLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6
ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPjxicj4NCjwvc3Bhbj48L2Rpdj4NCjxkaXYg
Y2xhc3M9ImVsZW1lbnRUb1Byb29mIj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6IEFwdG9zLCBB
cHRvc19FbWJlZGRlZEZvbnQsIEFwdG9zX01TRm9udFNlcnZpY2UsIENhbGlicmksIEhlbHZldGlj
YSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+PGJy
Pg0KPC9zcGFuPjwvZGl2Pg0KPGRpdiBjbGFzcz0iZWxlbWVudFRvUHJvb2YiPjxzcGFuIHN0eWxl
PSJmb250LWZhbWlseTogQXB0b3MsIEFwdG9zX0VtYmVkZGVkRm9udCwgQXB0b3NfTVNGb250U2Vy
dmljZSwgQ2FsaWJyaSwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNv
bG9yOiByZ2IoMCwgMCwgMCk7Ij5UaGFua3MsPC9zcGFuPjwvZGl2Pg0KPGRpdj48c3BhbiBzdHls
ZT0iZm9udC1mYW1pbHk6IEFwdG9zLCBBcHRvc19FbWJlZGRlZEZvbnQsIEFwdG9zX01TRm9udFNl
cnZpY2UsIENhbGlicmksIEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB0OyBj
b2xvcjogcmdiKDAsIDAsIDApOyIgY2xhc3M9ImVsZW1lbnRUb1Byb29mIj5QYXombmJzcDs8YnI+
DQo8YnI+DQo8L3NwYW4+PC9kaXY+DQo8L2JvZHk+DQo8L2h0bWw+DQo=

--_000_MW4PR12MB6997B8D6225D08E8F3E2DE55A05F2MW4PR12MB6997namp_--

