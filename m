Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3729CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 08:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uszhJ-000168-IW; Mon, 01 Sep 2025 04:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uszhB-00015B-5p; Mon, 01 Sep 2025 04:15:21 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uszh6-0005hR-59; Mon, 01 Sep 2025 04:15:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvBjj3QkV0IJHcRrtRtFR1j8QbyaT+fgrdOaOSx2ap79LjQDzXfN/PFcfOBEq4yLCxbAVRMj8JB//eWc/WCMygIP00IonuICUYARA/0A8ePIpyuB4qdcWeUiNLzm1jAMXHe9XKjUi1bNi/f6jsIwhWDAdYgLJ+SMHRS/p2+Mk3ixtRkziX0Nyddp/yNZKVmk2bf19FGLqJYULRrjqjIEoqzAbe4mLAHsYJU3U8/gFXegsJZmAqx1Sx7wyt9lLL4ctrHeS/recTO9jQ0Ds+1Lsf2uz0CnHN8K+urWrgm3o6m2Zwegd2oGWbcgKqD5dc0v9Xrdk5pQqTCom2/BvhptMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JI45afoYEGMx0x8fWyV3tAD/JdJbAoA2nHC5oVicmLo=;
 b=MHP8W0b7AKuZxasQcRfgvUwhtRD/XslyNK/ujiV3YM4TyMVTYCmuFiCyzEdMpc2NJ7KojU0ksS6NAup/WnY38UmC6WAamect6HMEZiDMTcge0DwJDuYc6CjTkhbMWRSbrCp5KlAyDXQad+N+l39VW1JoVEZ+d1M/+7MJsmVOH84LSn/7mMTNqHEmEw5t72nCCNLi7JMBOEbZFhklTYvhy06Evnq7UccLhFPEogjnNwM6+5Chi5ZMU8wnF3iqbmRcqDgaS6yju2F+mipZdLawZk3wU/qjHZ9oxTd8uxMfBTKSbU6s14gCvqVhuCyztxXYLNMVJQfRf7FMe9e3wXANkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JI45afoYEGMx0x8fWyV3tAD/JdJbAoA2nHC5oVicmLo=;
 b=AbJmGwGtspsfyRETDmHcqbY2bFLzFe+RqfrUNjck/6z6F12PHS6GoirHCA4y+xsuxp7fXiqVjmGwHUlCaY/8mMMES/EyUT+raMV5YSR8d5petMWK0QIX672ygulK9PE8sDqxIv3+J2HF9vMfHlbxvzxuYcPQRcDbrqx80BVDuDcdQjB//NYz8Yp4zdn1uSYOirjl7MGRUO8aQxUaRLid7DM7YdVDMD7uNFV7RA+LI+3BS+d/gIYMV3txxTgif6N7qr21l20stHueyCfXjt0x3f3zNjbaewJJCW3yxrk2TN5e2aBvH4Sj/SFBV14uK/s/YgaZwWJknPyFPlJOKu6UvQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB4311.eurprd09.prod.outlook.com (2603:10a6:10:153::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.28; Mon, 1 Sep
 2025 08:15:08 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 08:15:08 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>
Subject: Re: [PATCH v6 00/14] riscv: Add support for MIPS P8700 CPU
Thread-Topic: [PATCH v6 00/14] riscv: Add support for MIPS P8700 CPU
Thread-Index: AQHb9v6UGrCoAbtlqECp61EdLa3+x7RZGMSAgCUqTIA=
Date: Mon, 1 Sep 2025 08:15:08 +0000
Message-ID: <792efb1c-dd2c-4d13-b789-4a5a48b98aa7@htecgroup.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
 <6daaff50-c951-450e-bd94-9f0e4365ebe4@linaro.org>
In-Reply-To: <6daaff50-c951-450e-bd94-9f0e4365ebe4@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB8PR09MB4311:EE_
x-ms-office365-filtering-correlation-id: 1e088562-56ba-4a1a-dfd3-08dde92faa4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZVFKd3FBU253MnlidHprY3ZLNzA3UXNLN1UwWkswRUJ5UGwxSEczbFJTRDVh?=
 =?utf-8?B?dnRYdDMyclZzZDZsV3ZiRXlQcmtXNXlHcDFCdGtyMVBUaEpRMGRSNGoyeDJs?=
 =?utf-8?B?VU5uSFU2MzNUTVpiUVdSWXQxR1VzMWdwckRqUFl0MVVNNU1VSUpLNHR3REVp?=
 =?utf-8?B?YXVjcFJmdC8xcXAzU2tFYWlqVWk5dk00b0JYT0krUHhvT0VKR3lLaTNtTllV?=
 =?utf-8?B?Q3orVnV0b1hydkdwVHNZU0J4U29CYmZJZm5PSkJlQnhyQlhNejFSYVdEbUZj?=
 =?utf-8?B?d2NRTEt1OUM2RTZvTVVYclhhVzliZTJvSDJhd1lDdFk3S2pLRkFyOGtYMmZB?=
 =?utf-8?B?dlR4SmU5blhXQjZHRWZGRnhaaURYZnVycTlWYjFuMUhkcWVSMXNEM3U4bmxU?=
 =?utf-8?B?ckZONUl3ZHNKQjJTd21yZFAxT2FyeEZnV3Vyd3NUTEIrWk5LNytMNE1OK1Qz?=
 =?utf-8?B?WExxaEwzUEFtSnZGenFBRmwrU1RBSXROTktGQnhjY2VnK29xQm9kUjFacUZE?=
 =?utf-8?B?QkVMd3VOK0UzVGI2c29DNm5CZHJEaGpQSy85SXBaRUl4QllDc3kxbGd2YWxy?=
 =?utf-8?B?RytnTUxnSGU4QXFnYTlkSVhOeCtodXJOS2FDQTcvVENjOG11Y0duV3g2RFdS?=
 =?utf-8?B?TTdOb0FhMXBxQ1EwTnljRVIvRG14dFBHVi9XZVp5ekJQU1RCMi94S0Ewcjdi?=
 =?utf-8?B?cUk1SmVSU2h4V0hzaU5CbWs5WTdORUx6N3pJSkQxM2RETGo4ZHc0VXNSYm1S?=
 =?utf-8?B?K2NlSUZIN2NUU0dDUFZ5OUFGL1RaL2RzckhMTTlTcE5WejQxQXZRK205d05X?=
 =?utf-8?B?bmdsWGtoWUh1Lzg5TXcvbVlwcloybGRtYUVvUTlxQWZIcjFRWDJRUzZtNEJN?=
 =?utf-8?B?Mmh2UjUyQXRDZjU1aGVoYXpWTHJlbUdMVFdzL0IxYVh3Uy8xSjNNQkNlZE9M?=
 =?utf-8?B?QzRMN2tCaUw3N1lmYy9ycWM0VkJFWEVjM3czUXh2dnRsbElsZXcyNk5KdUNj?=
 =?utf-8?B?SXpzRWtVc1l0VzNuajlNL0tXclBaQlJDeU5QNFBhS0pBaUZ2a1dXRlZOTTJn?=
 =?utf-8?B?dTZONDJuOVBWeFJwOXgzUGVncXlqaEUrakF2QVdXZklnMVFUa3FuSTdlQmNr?=
 =?utf-8?B?c1Z2ZmVTNUFUM2ZvZEE1RzFKY0oxdXdxZDY1ZVZkTWVMczA3Ti9CdXp5TzdP?=
 =?utf-8?B?NzR1N01kYjIvNWRIVGlVYXVqWnA5RnVyRWhZQlJ1UnFzQkNGMVpTYW1kWEtE?=
 =?utf-8?B?Tk52VUQ4Zldpa3JTTnFtOEJzWTJ1U250eUdxbjdmbG4wUmNhZDlPUTdieTNG?=
 =?utf-8?B?N1FlWktRL2FxakRrVEpya0cvWm80ekd5M3dBTUw5OWxlTXRUZkNEOXluRTgv?=
 =?utf-8?B?REdCVGtjUmdvZHpVUVNIdW1wZlB5T0orTGllZ05IZjQ4NlBZcmpNbTI0Qk1Q?=
 =?utf-8?B?UmRzcmlmRkpyY2lmWXlPYVkrM2pSMUR4T3gzUFBKQkx4MkMyeWxCMXJSWjZ0?=
 =?utf-8?B?SDBlTnk1TEZrVHJXZkJtMFRBalNZZEhPK3BqNUUwUExYdlNLamJqeG9BNVEx?=
 =?utf-8?B?M3V1cUQzRlVaOXdQbDRFa1pJYVRRWXI2aVZqYk5kSXVUOVVicnhHcXplY2Jt?=
 =?utf-8?B?R2ZxOERtY1Qzd09TOE4yd1JoNXJUUUxkYzVvZklacldiS0pWcWRBVDRZQWpn?=
 =?utf-8?B?SnB3TmUzWkM4aXorSGFlQVVIT0ZJNnVHaDdNYzJxdzluTTRJSnlXY3FyZ2pS?=
 =?utf-8?B?RjhsVUNtem1YSlB4eldnK0pmYno3VCsxYWVWOGoyNUpaN0Zhb3VGV2VPeXhW?=
 =?utf-8?B?OXdiTTFJL0Jxd0UrMTFpQ0xGaXR4azUrclJqSFFvSXp4aDBUQWpCd3JHRk01?=
 =?utf-8?B?MndvYmx1WUlTTXcvcytER2hlSFNQVlUxVEVCd2hMZTdkMkw4ay84NUtLTzBo?=
 =?utf-8?B?UTN6TXpwaktsRXBnaE1wRDNxcEY4V1E5M0FZcG5LYXpWcHY1RmhOVEk4TURv?=
 =?utf-8?B?SVFMRHpqV1R3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K294NStlYXFHVHc1M2xWRGNWZURxellPa1dzSjR2RkZmakQ3dzlhQ29YWEtE?=
 =?utf-8?B?NmswR0NjRWI0eGI2R2tLNTZzdHNjNENGT0IvVDdLQTN1NXBwQVErK3lycVhX?=
 =?utf-8?B?RUJCbEE3aVEwMm1INlpQcTR0YS9JazZTWEN6ekNicVROaGE4SElYNnFwTkpR?=
 =?utf-8?B?dHFORm9aNHI3MVdEeE9sbTAvcWlrTzBaYWhPT3J5aHFNY1kwUTZPaFFIUnhj?=
 =?utf-8?B?N285ZW5VazFXTnZxV0NWZ2xPUkMvWk04YWllekV6MGZiM2ovRmN5c0l0R0Vq?=
 =?utf-8?B?WnlzcGtPbk8rbCtRcUJueHM3ZjVhQnlEZWUyRGxWVWNXMm1xWFA1MG5SYndQ?=
 =?utf-8?B?Nk9rS2NUTTlnVGd6Q1k4T0syZDYwNUU5VmxlRVYySjJMeXc3U1lTRm9BM0xq?=
 =?utf-8?B?c0duZDhNdDY1RkQ4Y0VDd1ZYdisxZ2dzYzRmMkt5RVk0V3JpL2tDRkkxVFM2?=
 =?utf-8?B?Nnh1L1RjU0w3cFFkZTR0VTdPTXNNYjdWZVJwU3FPWHVYVUFJdkhDN2IxK3JW?=
 =?utf-8?B?TnZhTmNyQVZtMEYycnpVMEJuZnB3TGNBazZwSWNINXZTY1FGUHU0Q1diL3ZZ?=
 =?utf-8?B?TGxVcHYvM1RkR3VIakxRSHAxVWhkR1JiUCsvSW0zbUVtbElYbkZSR3c4cGUz?=
 =?utf-8?B?WVhvUDFHQVJGdDFwcWJ6TkpESmpaeDQyRGI5aFRQT1FhOVM4ZGhpQ3hiSnc5?=
 =?utf-8?B?S29URVhzbGt1aVJOQlM5emE0czZ2ZDg5Y2VHTlVjaGVyUkNGbFl2UmdXeEN4?=
 =?utf-8?B?OGF1cmhHRWdJcnB4bVVmYVhveXd0VnR2MXBiZW82d3Q0QkYvZU5SZG9RUExW?=
 =?utf-8?B?OUZDUUU3MFVLcElKTXJ1dVF6OGNPVElYWGRUQnR5VGlwVS9xbFZKNFR6RGNp?=
 =?utf-8?B?UzFFY3RPQmVFcWp0UE1BT244ZjAwNWpxR3FlNlZzWjdwL241dFdCWnFScEZY?=
 =?utf-8?B?N1NUMHpkc0JUYUVodk9SSDhLOHJNTlVRSFlUOEtjL29CUFpIZGxIL3Z3TGI3?=
 =?utf-8?B?VDUzRHIySDY5aWlEd09xMTFmRThNbGVLS0FmUm1XRUxSSm1zN0FtUDErYVRW?=
 =?utf-8?B?TzBMMHBOTStSd0ZjSTdHaTVvT3BjNEkySDVNR3ZnUXV5NTBrTHQ3K0gvVzI0?=
 =?utf-8?B?RWZleTc4b2FNVWtsY3VUd0VwdzcwQ3pvRWdKaTRRR1VvcGc2eUFoNHdnNzVN?=
 =?utf-8?B?U25xVkh2ME5LMHQyRzVwSmp5bTd4RTg3bGtLengvMThuT2pGVDNUQkhLVkxt?=
 =?utf-8?B?aUhWVmM5bTdvZUJkQlU2WDhGbmxrSURIejV1T2E4ejZSSzF4NU5ydGxTaGJB?=
 =?utf-8?B?V01EUFB0bVpQWjBkWVdaZWpwSURwdWF2UFdMNDBGYUJ4S3JDdHByTVltSkFj?=
 =?utf-8?B?Zzl6QU84U1FvdjZjUXg3aldPd1p5TkpXOFpWUWMrY1ovWVRsdXFQeFNNbkd0?=
 =?utf-8?B?aUN2eTBhbEJhUWo3ZnkwSktGTU8vYm9xbEVsT1VJUU5vZ2h6clg1TlVoYWpk?=
 =?utf-8?B?bEpQa2t0NFhQUFlNamFralAwMm1hb3VVSkRhOFR3TEI1eUVNb20wU3NLcFRE?=
 =?utf-8?B?WmlaL2xnbkVXL295dTRkSVM5NVVPeDF3WlhhcHAvMUJwSzN4ZERNcHBxcDhZ?=
 =?utf-8?B?ZmlnbUZnUGlRTTMrUDNBNnlqbXRnc0Y1TzhabFF0RVBlbXVzUWdWZHhrUlhi?=
 =?utf-8?B?bkVRMWJqU29PM2FNUVh6cFQrVVlRclNHRzZhRUlKT3pZc2xUZXY3RTF1THJy?=
 =?utf-8?B?NkE0V09jU0RoTGZCSGNwMmpUSW1FK1lUTG5hNG9yTjBqOUxwV3oyS2RzaTRR?=
 =?utf-8?B?TU9mL1hsOWZ0ZFl0Z0lmU3V0YmFDWlhFWnhqdlRXS2NMWFJMakk5YWNLdFhS?=
 =?utf-8?B?NmwwU2hDeE9WVzVrZVRqUXpaVGkxYi8zSmZvWlV6dGsrUU1wUjBEMFlpSjlG?=
 =?utf-8?B?eFU3dkN4OEcweUtUWFZscXdNZFd5RHhCMUJadVg0U0xlSjlsZTN6NzBjd1h0?=
 =?utf-8?B?ZmFJclhxdkVwUU0zNStENkgySFRGbjVXc1IxUTJaNFJUZm5BcmFvVEtwLzFk?=
 =?utf-8?B?NW5CUjZMZTRSRlBwR1R5NlZVa2plZzF6ZHdaLzBWQXNnRU93T2cyRVBFNm9E?=
 =?utf-8?B?NEFCcXJuR3pwandPcDBUeEFMOXlDcjdUdUUrQ1JleFA5K1pScmw2M1RWdk5C?=
 =?utf-8?Q?vIfdX9gR8nyWcomZI7znqGw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CDFA84AFAE29B46BCC49D200C1C7EA6@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e088562-56ba-4a1a-dfd3-08dde92faa4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 08:15:08.5531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YOx2t4WTFTqwULRuQbpV/Nv5OuZRoMPpmtrnOWckL7BJngCp61bQAycgH2DnCTX9IA5dgQmgd0DlyTdj4S0hr1DQrpWvhVfYKDXw0Q/1Ebs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB4311
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

SGkgUGhpbGlwcGUsDQoNCldlIGhhdmUgY29uc2lkZXJlZCBpbXBsZW1lbnRpbmcgaXQgYXMgb25l
IG1vZHVsZSwgYnV0IHRoZXJlDQoNCmFyZSBjaGFuZ2VzIGJldHdlZW4gTUlQUyBhbmQgUklTQy1W
IGltcGxlbWVudGF0aW9ucyB0aGF0DQoNCm1ha2UgdGhhdCB2ZXJ5IGhhcmQuIEZvciBleGFtcGxl
LCB0aGUgcmVzZXQgYmFzZSBmb3IgQ1BDIGlzDQoNCmF1dG9tYXRpY2FsbHkgc2V0IHVwIGZvciBw
ODcwMC4NCg0KSSBoYXZlIGFkZHJlc3NlZCB5b3VyIGNvbW1lbnRzIHJlZ2FyZGluZyB2NiwgYW5k
IEkgYW0NCg0KcHJlcGFyaW5nIHY3IGZvciBzZW5kaW5nLg0KDQpUaGFua3MsDQpEam9yZGplDQoN
Cg0KT24gOC4gOC4gMjUuIDE4OjQyLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4g
Q0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5p
emF0aW9uLiBEbyANCj4gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciANCj4gYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2Fm
ZS4NCj4NCj4NCj4gSGksDQo+DQo+IE9uIDE3LzcvMjUgMTE6MzgsIERqb3JkamUgVG9kb3Jvdmlj
IHdyb3RlOg0KPj4gSSBhZGRyZXNzZWQgc2V2ZXJhbCBjb21tZW50cyBpbiB0aGlzIHZlcnNpb24s
IG1ham9yIG9uZXM6DQo+PiDCoMKgIC0gc3BsaXQgQ1BDIC8gQ01HQ1IgaW50byBzZXBhcmF0ZWQg
Y2hhbmdlcw0KPj4gwqDCoCAtIHNwbGl0IENQUyBpbnRvIGEgc2VwYXJhdGVkIGNoYW5nZQ0KPj4g
wqDCoCAtIGFkZGVkIGZ1bmN0aW9uYWwgdGVzdHMgZm9yIGJvc3Rvbi1haWEgYm9hcmQNCj4+DQo+
PiBEam9yZGplIFRvZG9yb3ZpYyAoMTQpOg0KPg0KPj4gwqDCoCBody9taXNjOiBBZGQgUklTQy1W
IENNR0NSIGRldmljZSBpbXBsZW1lbnRhdGlvbg0KPj4gwqDCoCBody9taXNjOiBBZGQgUklTQy1W
IENQQyBkZXZpY2UgaW1wbGVtZW50YXRpb24NCj4+IMKgwqAgaHcvcmlzY3Y6IEFkZCBzdXBwb3J0
IGZvciBSSVNDViBDUFMNCj4gSSdtIG5vdCBrZWVuIG9uIGhhdmluZyB0aGVzZXMgbW9kZWxzIGR1
cGxpY2F0ZWQgd2l0aCB0aGUNCj4gTUlQUyBvbmVzLiBBcmUgdGhlIElQcyByZWFsbHkgZGlmZmVy
ZW50PyBUaGV5IGFyZSBqdXN0DQo+IGRlYWxpbmcgd2l0aCBiaXQgbWFza3MgdG8gc3RvcC9zdGFy
dCBWUHMgQUZBSUNULg0KPg0KPiBDb3VsZCB3ZSBtb2RlbCB0aGVtIHdpdGggcGxhaW4gQ1BVU3Rh
dGUgb2JqZWN0cyBpbnN0ZWFkPw==

