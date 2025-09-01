Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DED9CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 08:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uszpv-0007Hd-3V; Mon, 01 Sep 2025 04:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uszpk-0007H4-IL; Mon, 01 Sep 2025 04:24:13 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uszpi-0000WU-Bz; Mon, 01 Sep 2025 04:24:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0oePqaimhUNtcshqIyK+b5ozA7c1CQgW/arXoH4ytI5E+J5HNdiwZaKV28DIVR/Ssng9Gf8GEIWoX9uKUtuX5QlDAPob8L3FAtyQIXy742v1mkzq8nwGR27iQTQSUKfda+D+dbPTcwrm2VeIyFMA5PdjBCDr9H6B5tooL++fcQ2av75MaL8+U/COq8EK7S8Bvs9Pu11FOjlXKeaHDgIgEqvHyDSORMUxmC6udK2xW7UV1j6FlkWAi6Jf1ByfrrmaEOTF65hyN0L+dphma2ngUrhWdoyOpi5mAkeKAeh9QaP9kz+MlsxtZSYekwo3ADvdnPp4ediHcuRjAaRGKmkzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhLdagiKtUd4uFvOdq64MK8u4i1joc0gBxhPZro88t8=;
 b=Bj/NML2CNHUWpdDGi9KmIucVe5j/eaKY2vX4/KtaUyPE4phJ0mkHsnNhrKqvKiRzOn09Q25fDTZQcaXuYdagrkP1rR1dix1XTFo7rB/W1aHW1jox5isGcUeYZXi9utX1SRejEiBTRDe0YkfG5nn37zC2i1xu49GBFrZoluFocuFMYWw8LxAHLzpkVDM/GqMWW6Rb+G3QTdXzRLLzGxZzVLcIK2qffM6+Qfe/XjyT0vBeWq7elAfPltjn5x0WzTY42wUe6R4GyrKdbDPE5Eg4E8SXtjXtew8w+hf7W8Qm8soZSosZGjZyGQLYgBqZU3Xj1SVGc0tY5xt2xuQF5qpP5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhLdagiKtUd4uFvOdq64MK8u4i1joc0gBxhPZro88t8=;
 b=uzg9c53jukpC5/xRl7Cy9XOPjM0BHKDLoFflR24bNW16tZbAkm/W5deIS0qoS5/F7W4xlHx3B2B6GUaT/XWq/34Yy2IihK5kjfy06I+LXi9+S9ImnK1mvHRrHEdBjWVK0zDcBJdNO011u4VVXmFiN4FZwPrrdor8irSzLmwm76/m9hh+QdMJ4DXx9SaQIbkzaZ3Ft9LxMuOKQvd48rfYpBW3RPfaNGnrt/nw8dF6dPljTfGVLM47216TJro1+Pw4RvWBr+TE2BNArqpTPBCCEGPc3YRS4zRP16zUfMrUeXQWDO/W9cWrwJiA60/pRCKfz47oqZNrG4NiubEQLSgbUw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by FRWPR09MB8121.eurprd09.prod.outlook.com (2603:10a6:d10:19c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 1 Sep
 2025 08:24:00 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 08:24:00 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>
Subject: Re: [PATCH v6 08/14] hw/misc: Add RISC-V CMGCR device implementation
Thread-Topic: [PATCH v6 08/14] hw/misc: Add RISC-V CMGCR device implementation
Thread-Index: AQHb9v6Wv13ajPXjLkiShog0d4iGHbRZDQWAgAACNYCAJTZQgA==
Date: Mon, 1 Sep 2025 08:24:00 +0000
Message-ID: <4b7973d5-c126-44c8-970d-27059a806512@htecgroup.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
 <20250717093833.402237-9-djordje.todorovic@htecgroup.com>
 <a9874cc7-e18e-4b6c-aaac-2c6ce56c1bf7@linaro.org>
 <1cf4f7e5-c9d2-49fd-98db-fd8d05fd241f@linaro.org>
In-Reply-To: <1cf4f7e5-c9d2-49fd-98db-fd8d05fd241f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|FRWPR09MB8121:EE_
x-ms-office365-filtering-correlation-id: 17335ff1-c9b8-469b-dd70-08dde930e714
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cUVPR3FVbEQ4ZC9HWExscWxMQnFtMmlGNW8vQlZNRmtEQlNTTTJpeXJWUU5y?=
 =?utf-8?B?eXZMN2FSL1hPcklOY0oxWFBIb1lLRjdubTNVR2pyUzlad1lMT2NvQXF4Z1Fk?=
 =?utf-8?B?MXFoaUVPdGwxNExWbzVxbWhWMjRENUdYSXBjY2hhczFYdTNDZjBsSzl6YjZF?=
 =?utf-8?B?enl4ZnMyU1RlbkVKaDBkMCt6N1pyaVRaZWFTbXQ3cE9pRFZRR1VzTlNqc2No?=
 =?utf-8?B?NjZMRE0zcWloSDhjZTRuT0plN1VMUWVINzVYb25FSkI4U04vRWdLZHVvSzlk?=
 =?utf-8?B?MFpkdExINHYzK1J4cll4TzFsSFJwV2xYcmhIL3IycWw0b0twZTd4ZW0va2ZW?=
 =?utf-8?B?MnUvOWlwdEFYSHJnUitjZGwyQnc0UWJrMWtNVlN5SjFXSGFqWlZpRkRSTXVJ?=
 =?utf-8?B?SmNVM2Zna0RuNWljMlFGWVpaYytNdDF3K095WWpNNTl5ZUNrMmd2Q0hHZU1V?=
 =?utf-8?B?eUltVFM0OS9tZ0xmZ3hzSlpmZzRIMThHcGdLblJFcUJ5WnZLbDB4b2tZYVZU?=
 =?utf-8?B?T2Z6K2pxZTZwOFBrdE5TRjB5RERqQndjRDNXSGRMMXJ0dC80T1VuQWgwZW9E?=
 =?utf-8?B?U0o1T0cydk5KbXFyb0U2K1hrQ1REblYxcllNVndQN0RtZTZmTkNhaFJsZ2JW?=
 =?utf-8?B?NlVZMGtuT1lFVHVkaXNvUTViMnY5Q0h2OFRJbDhaMnhUODFJMVhYdDFhSUVI?=
 =?utf-8?B?ZVhDaHg3Tm9relZ2WDNzVndsQm5xSEExQUgzbE45NDl6VkFhM3NEcHV3S0Fy?=
 =?utf-8?B?RUc3VGJ5aUVsVjg2cjN2NUlEdDhEL0MxRmNFRFFTdkhMNWdGRXVVaWVyWVhv?=
 =?utf-8?B?UUFmQW5wSGh2THl2RThsM0VZZWUvSVpXWTJwRU84VndiWVE2VHFJdlBaM3pY?=
 =?utf-8?B?RkVnUWE1a25IbWovdEhUaytRN3pyNmlaOGdpVWJhaXFaTHVIUE1kZ2JpTTVl?=
 =?utf-8?B?Y2dlVnovS2ZZL2NTTFpJVjg2aWRFaWlYYTFLZUdmaGcxQUFCVGpFdlR5b21N?=
 =?utf-8?B?Qkh5S1k5TmcxOW5HTnJaNHg1VGw3blZGUzU0cUczUHEyamh3WVZsZlJJcmNE?=
 =?utf-8?B?cDArZktKcExXRDRxY3N3UEhnMWlqSkV6V1ZLSlZqdU05SnFncjZtcEl0bUpE?=
 =?utf-8?B?ZHFmMnhGSTl2VTRmU3ZUSHdZWitBdk5qdVRYU211SXk4T0Rtc2huOGU0N2ZO?=
 =?utf-8?B?b3dLdEd1NzkrYWxWYm5wcjJCaDl2SDBUMG13eU1hRUV0aER5Rjh5VG81eVl0?=
 =?utf-8?B?MWlqVlNQSDkrSCtRZmxkM1BHTzFHTzl6Z1ZNa2NPZGx3MFlZb0xITXA5VnR0?=
 =?utf-8?B?bXdyenZWTmI1a3ROUG5LQXhCQWVnU3NjemNraTBmMVZCbGVNcE5WOVp5MFBF?=
 =?utf-8?B?RktycGs3L3diR2hOSlBUY3czemxzNHJweWdsOGVQeDdwVW5MYnFYazRrYjR6?=
 =?utf-8?B?U1c0dzAxL2padFU0WTk4cGJhTS9PdVRrcStBeGYyWHFoWVp2ellSK2lHZkwv?=
 =?utf-8?B?bDd0SE50eWd3ZFFoYkZQOHhaK0Y5NzVSVzlqWlFNeVAxYjd3ckRuZGEvQmJi?=
 =?utf-8?B?QVNQUXZkdGNBZDN0S05mOWQra2JwM1R2TllYNFpzTU9jYXNnQ3B2LyszOG56?=
 =?utf-8?B?c2N4dllqdlMyem92NmZEVithckkybnJBaTdoQTJiM25pVHB0NHh1T0RyZXBV?=
 =?utf-8?B?bVVrK01SdDE3K2t4ejJKaDluU2FZNzRGMTdMYkkwaU96dmFtNmY4NFk2OVlm?=
 =?utf-8?B?RzBYQlBDZmZ5TkM3WWFKbU5IMDBjWnM5VUxxU1lZd1IwOW81S1dpdnNCRHMz?=
 =?utf-8?B?UlcxVGprTlJ6amlDWDZtZndNZHo4VEVKZXlSV1dwR08vKzJOWjBoYXREaGtV?=
 =?utf-8?B?cjYwRFRRVzlTWE9mKzh2ekpMR3c5dXZPSkFyREFQaEY3YlNia0ptVkdtNkJD?=
 =?utf-8?B?ekQ1Wi9PNHRpMXEzN0s1ZEVNN3phSjUvV2xaQlRrUWpKUVIxU2lnNjhzcHFs?=
 =?utf-8?B?TTJuZmh1RW13PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEZKT3VlU05DNFV0UXNwMjQ1c2wwdW5za2IzL3ZGQ2N6N0Q2Z0VhVzNMb2lm?=
 =?utf-8?B?TmtPMS81SHNySjJUaG56bGdJWVhUUEZrZTVNQ2lFRWd1c2oxYWQyYVBHU0l4?=
 =?utf-8?B?M0tLVTlTWHV1M3B6MUh5Z0pDR3hXdEpqaEFOSnk0YzVUL29QcENZcHFndXJ4?=
 =?utf-8?B?eU5pL0RaRVpnOVRGQlpLNGViVnBPUTZoYlJtNkQ4TjBiaUt5U2xFZzZESHpW?=
 =?utf-8?B?dFpBdWxRdkZJeDJoM0UwWEl1SGJQeXRrUG9VZWpndEJNSzZlcEQrVmhsSE8x?=
 =?utf-8?B?MlRDdHltNkFoV241Z3duckxDNzQvYVlPQW5VazFTQStSVEZFa3VVam83SlAx?=
 =?utf-8?B?bUYrYlpkYSs2NGlnRlVIM2d3SWJqekpYTmIxMWNSMFRLc2Rkenh5U2w4bGtq?=
 =?utf-8?B?YnpDYTRJbVI4UkJpL0Vydi9SOHZpVGw2VWpiOUhTM0w0bXRIY1U5djZIdVZB?=
 =?utf-8?B?SDFWc08xa29hckZIZVF6ZnRhV2tJMzMwVC9FSkpmMStyRnpZZUhUVzNzTmhD?=
 =?utf-8?B?TFhMR0N0YUFXRm55YWJIa1NNM0YvZ3oreEw4TGFhTUFKbk1nSlpMUzE0cUsw?=
 =?utf-8?B?ZXVkLzl5ZGNCS1U4dHozSnViQWxseUUxcFdFaWlXRVkrcGJtOWpPSmF5bjlB?=
 =?utf-8?B?TndHS2tKVUk4bG9tRTZpdm82UGpTeThKdi93RTN1Mis4YUlFNXNab2JFOXEx?=
 =?utf-8?B?RVh1NUI1NDdpaUozRnBicTRLWC9nMHAxdTRSL0s0ckloRnA2cElxWG16TGcy?=
 =?utf-8?B?dFAxOU5qazhOUFZDdlY1MUZtUHlqY043eTNDTTIxY0dNWXE4QjlxV2Q1OC9j?=
 =?utf-8?B?N3Q3NGZid1c1MlJGYytaenJ1TzJDTlpZVDhXNC9hall6OElHdFhlVlBzaWF4?=
 =?utf-8?B?T2hrVXU3OXptNHg2VzFhTXBuSG5UbEVLdVUwU0FsZ1VGdjNkZ0lmSlFXaTNO?=
 =?utf-8?B?czlJaTc4OEpNQXB4UzBnL0hFWHRxblZ2ZHV4NmpiUGNlVE4zYWpRTmpNb2JB?=
 =?utf-8?B?SnRybkMyUjBDUXpFUzlkcW1pMmVicHlONzRsb1RYdlRTdmVCaFl3QmlUVTd0?=
 =?utf-8?B?L1ZKNWxSdGdMUytCVEMwY3VTekp1Tjh3TWNmODVJaFFJMlZuaFQ4OHM4SFZQ?=
 =?utf-8?B?YWZPeTRoNVVRd3d5bUFWVzYwZUdWeTlnNjA1TXNkVG9Yb0pWOFpwQkNiUjZN?=
 =?utf-8?B?QjFkSi9UMEVqT2Iyc3hDa1dFSlZjQmRqRVpNN3BmbVJubkxhemlhMW5hV1R3?=
 =?utf-8?B?L29jcm1wcFY2R3hhME9zRDJSSzRPKy9wWTVYc1AxT09Mb0wwSkZXbkdEQXRn?=
 =?utf-8?B?OEpJcnAzVlVwLysyMUpQN1NCczAvTnAxcXNQNDcxTDhlOVJKQlRHNW1GaHlo?=
 =?utf-8?B?UU9nNDEvUnpJejlYZ3BadFZuUEUvd1h2c2o1aWxwRGRBaFhVMXpESExSYnVK?=
 =?utf-8?B?M25YNlRMcTN6M3NkNFFuVGw2Zm41VmpuMm9keEdaMU9VYUZRRXBsL2RrcFBL?=
 =?utf-8?B?SEl6MVowRFNGNzZJU3B4Vk5xWEF0eVdNOTZvWmpDcFhJUEpCNWhXMWxNUk9R?=
 =?utf-8?B?RjNONzBJZmlhdE40SVEyMlA5bStYL2QwNFplRHFrSnBEbWJwZm9jMWFnRUFN?=
 =?utf-8?B?WVpuN1VTeUQvWWNiWFJYck5PRnJwZUo4Qk1wVFhYUmJ4clkxRjRPNkNPMzNW?=
 =?utf-8?B?VzRXT0kwNS9YWVgyN0RRTlpvZ0lUQ0w1TVNmV0VZaXpDdHR1aVZtZE5tWFUv?=
 =?utf-8?B?Q1V1cTZCMlN5elhTLy9JYkRMeWNybU5sMGFDRWs2Q0hSQlRpcjFOdDBHZENC?=
 =?utf-8?B?cE84bUx4VWJZb1JYN2RXRVB6MGxDNUdMUjFOY1FUSzFLRXhNWUgrYjl4eDZl?=
 =?utf-8?B?NGhHRk9RSU1kT2NqcVlBN1lYZ3VVOUtEdUJSNmJIcFpaUVg4RkJ2YWVRdFp1?=
 =?utf-8?B?aVFGMmZIU0RPNmVKMGlDUzBoV05ZdTBGcndtOTVVYjBncHBJb0djbGwvSHBD?=
 =?utf-8?B?ZlBQK2V3dFRldWdVVmFmSnBYN1o1WUZtS3hvK1FBNVpHbW9DSVdzWDU4MWlN?=
 =?utf-8?B?K1B6MTZ3U2k2Z2RlaVdaUHdMdVhvZWdVNld2eG8yVlRieUFVVm1UMGg0cS9U?=
 =?utf-8?B?VVA0NWl2MWdMdnZiZVFZUUZJSWwwTFdPNGFZUDZNKzhtMzVaOFZjMVQvTWF5?=
 =?utf-8?Q?g8b85MhOMAES3Qos3qwGdpw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <720E38733A6C284ABBF307DA9A24EC8A@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17335ff1-c9b8-469b-dd70-08dde930e714
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 08:24:00.0646 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b/NsmxzE4tjN358+pw+ffYIzEt4rWZZEsJxWc8nJ9uWDvW3Rdcdq3tpSI2nPmA0Z/nCmJfEBf/rLmTjZ/gHAe+pTyYsNVIzZjmrJI9E0p3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR09MB8121
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

DQpPbiA4LiA4LiAyNS4gMTg6MDcsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBD
QVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6
YXRpb24uIERvIA0KPiBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIA0KPiBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZl
Lg0KPg0KPg0KPiBPbiA4LzgvMjUgMTg6MDAsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3Rl
Og0KPj4gT24gMTcvNy8yNSAxMTozOCwgRGpvcmRqZSBUb2Rvcm92aWMgd3JvdGU6DQo+Pj4gQWRk
IFJJU0MtViBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgQ29oZXJlbnQgTWFuYWdlciBHbG9iYWwgQ29u
dHJvbA0KPj4+IFJlZ2lzdGVyIChDTUdDUikgZGV2aWNlLiBJdCBpcyBiYXNlZCBvbiB0aGUgZXhp
c3RpbmcgTUlQUyBDTUdDUg0KPj4+IGltcGxlbWVudGF0aW9uIGJ1dCBhZGFwdGVkIGZvciBSSVND
LVYgc3lzdGVtcy4NCj4+Pg0KPj4+IFRoZSBDTUdDUiBkZXZpY2UgcHJvdmlkZXMgZ2xvYmFsIHN5
c3RlbSBjb250cm9sIGZvciBtdWx0aS1jb3JlDQo+Pj4gY29uZmlndXJhdGlvbnMgaW4gUklTQy1W
IHN5c3RlbXMuDQo+Pj4NCj4+PiBUaGlzIGlzIG5lZWRlZCBmb3IgdGhlIE1JUFMgQk9TVE9OIEFJ
QSBib2FyZC4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IENoYW8teWluZyBGdSA8Y2Z1QG1pcHMu
Y29tPg0KPj4+IFNpZ25lZC1vZmYtYnk6IERqb3JkamUgVG9kb3JvdmljIDxkam9yZGplLnRvZG9y
b3ZpY0BodGVjZ3JvdXAuY29tPg0KPj4+IC0tLQ0KPj4+IMKgIGh3L21pc2MvS2NvbmZpZ8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEwICsrDQo+Pj4gwqAgaHcvbWlzYy9tZXNvbi5i
dWlsZMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDIgKw0KPj4+IMKgIGh3L21pc2MvcmlzY3Zf
Y21nY3IuY8KgwqDCoMKgwqDCoMKgwqAgfCAyMzQgDQo+Pj4gKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPj4+IMKgIGluY2x1ZGUvaHcvbWlzYy9yaXNjdl9jbWdjci5oIHzCoCA0
OSArKysrKysrDQo+Pj4gwqAgNCBmaWxlcyBjaGFuZ2VkLCAyOTUgaW5zZXJ0aW9ucygrKQ0KPj4+
IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9taXNjL3Jpc2N2X2NtZ2NyLmMNCj4+PiDCoCBjcmVh
dGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9taXNjL3Jpc2N2X2NtZ2NyLmgNCj4+DQo+Pg0KPj4+
ICtzdGF0aWMgdm9pZCByaXNjdl9nY3JfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAq
KmVycnApDQo+Pj4gK3sNCj4+PiArwqDCoMKgIFJJU0NWR0NSU3RhdGUgKnMgPSBSSVNDVl9HQ1Io
ZGV2KTsNCj4+DQo+PiBQbGVhc2UgcmVwb3J0IGFuIGVycm9yIGZvciBpbnZhbGlkIG51bV92cHMg
dmFsdWVzICgwIG9yID5NQVgpLg0KPg0KPiBQZXIgdGhlIG5leHQgcGF0Y2g6DQo+DQo+IMKgICNk
ZWZpbmUgVlBTX01BWCA2NA0KPg0KPiBJcyBpdCBwb3NzaWJsZSB0byBoYXZlIGEgY29uZmlnIHdp
dGggNywgMjQgb3IgMzUgdnBzPw0KPg0KNjQgaXMgbWF4aW11bSwgYW5kIHdlIGNhbiBoYXZlIGZl
d2VyIHRoYW4gNjQgdnBzLg0KU28sIHllcywgaXQgaXMgcG9zc2libGUgdG8gaGF2ZSB0aGF0IGNv
bmZpZ3VyYXRpb24uDQoNCg0KPj4NCj4+PiArDQo+Pj4gK8KgwqDCoCAvKiBDcmVhdGUgbG9jYWwg
c2V0IG9mIHJlZ2lzdGVycyBmb3IgZWFjaCBWUCAqLw0KPj4+ICvCoMKgwqAgcy0+dnBzID0gZ19u
ZXcoUklTQ1ZHQ1JWUFN0YXRlLCBzLT5udW1fdnBzKTsNCj4+PiArfQ0KPg==

