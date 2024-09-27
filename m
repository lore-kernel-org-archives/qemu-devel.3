Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8325CCEBF75
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 03:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su1Vh-0002DC-UV; Thu, 26 Sep 2024 23:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1su1Vf-0002BY-7Z; Thu, 26 Sep 2024 23:19:11 -0400
Received: from mail-psaapc01on20702.outbound.protection.outlook.com
 ([2a01:111:f400:feae::702]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1su1Vc-0000nE-ON; Thu, 26 Sep 2024 23:19:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wk9YNaI3hOFTJFf/u47ysz+tBfumnoZ+YeF+f8j2ZfQ7SyX5IuKesAiMgTfW2ZNtX8firuPvoOACbqXL14uaU973NLXprV9qHJjXnKVYTc58xt6RTnI8P5gLplpu/6tkNaPlT5shjon/hgUO0f7QdZzMGJnLKCNZznOnq1aoZEW1tWDMLMvris0iJ2RBTEKwO5+NMnNRa/DUbxAY76wgRieNM91L/AqK6lVDs7HRSlWxI1EvOt9xFCUBzAVC3X+ubvMWW0fvdiiNJzBfTCx9H0TJJ4yBp1EPhlKTD02TF5/eUL42G+MBkvsvWrLgpdCeB1B+H3UUaHq/nyqwBx4HfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Hmf3a3cHUGzEkPiJaWPBaQJ4/GZVLOy6DOi2igBV1g=;
 b=c3txc+s/4t2ZuTeY1/TVTpOM3w87SE27nqBbg7MT7i+SXEljqxA8X5w9Mc/LidcRbUGHdqmj5E8cgKPZW/HRqJqRn+qEfiUeNnR8zJgMoWpR2sJURx4Pv4APG1TX1Qc+RP0krL/oidysr3BafaNLH+EKub60mO7ga+i3Y0dwWHu1dq7w5wZLX8fIaZb0A8dzVy2PDLHEYk/aSN0c1ORegmQwdQpOR8C55PDTjkRnC/bPlA1tVhe1f/8RnZnHyyUWInOlyUH8JCaHcxdLunwA0PuiNl5CB3jALMRlSBZ5Ut7SYjlCP9HM7S1yg5qd8HPZa1q/UI3MlfOpZaxF3RXEpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Hmf3a3cHUGzEkPiJaWPBaQJ4/GZVLOy6DOi2igBV1g=;
 b=kCWS9nd6uEaiNCEAOFxv8syJTlN6BqHKTfrpLyoSWPyLRnDQI3Q7KanncMqsE+r4gLeqCcenUh2c3LpQmzwUVX1watSDlTVhChE1R2S5t9XidEStnkMLMtoTSRIxlCNjljkmyTxrAHo86hqjCjSagv5BONEua27RRu3RqLqcyAE4Z98LDRJsoLLoLxkEz726GuslL2mwlMsrc/+EsCNNMtbN0oJVsnBL1ade7iNlf37bMVQh6jI2osjExkoRRjOg0C05bDx74roeEZ9tgXJ/1160bNlp4iJj2Ehhi9WLOsLalATqp5GCSXSsvzp0e62qMLu4LqobBTZZS/7wITL3PQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KL1PR06MB6789.apcprd06.prod.outlook.com (2603:1096:820:ff::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.27; Fri, 27 Sep 2024 03:19:01 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8005.017; Fri, 27 Sep 2024
 03:19:01 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v3 5/6] hw/gpio/aspeed: Add AST2700 support
Thread-Topic: [PATCH v3 5/6] hw/gpio/aspeed: Add AST2700 support
Thread-Index: AQHbD+gbnlxKWGF+L0ac1loR0KLSUrJq56cAgAAQTrA=
Date: Fri, 27 Sep 2024 03:19:01 +0000
Message-ID: <SI2PR06MB504179310FA40090C7FC27E1FC6B2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240926074535.1286209-1-jamin_lin@aspeedtech.com>
 <20240926074535.1286209-6-jamin_lin@aspeedtech.com>
 <599cdb2fa47a4c1da5775be175ec67d66cf7cf43.camel@codeconstruct.com.au>
In-Reply-To: <599cdb2fa47a4c1da5775be175ec67d66cf7cf43.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KL1PR06MB6789:EE_
x-ms-office365-filtering-correlation-id: 4dcfe155-a118-4a5a-67a1-08dcdea32211
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M2NiMytUcWJLcEJXWTlleUtEeGsrU2xkZjNvRC9QdjJVNGxoU1UzbERKSStq?=
 =?utf-8?B?VkIxbHpCNmtTK3JkMTIvU0VDSzFxamNPcGloQmp4NWJmRXQzN1kwZTRSUUw5?=
 =?utf-8?B?ZW5TYnVqQ2J3a1J3OGVLNGVrNEUwS0ZFV203MHE5RzV2SmVPa1FXWU94Mjl5?=
 =?utf-8?B?c1ZTbEc5ZWJoTjhHa05xN0t1K3FCWVoraXMzRkhzdVdkb3dBVlBDRUgwWHRj?=
 =?utf-8?B?WHZneG9UL09hTFoyNmFqT0RSZGdoQ0lacis5YTFmaGFTSCtybWZNQ1RRTy9R?=
 =?utf-8?B?TXhJMmM0MjhHL3VZdDdUbDc4MFVwbEsva3RUVGQ3UzB2cU9lL3RYT1d3MG5k?=
 =?utf-8?B?eks4L0FjdzhQMzVtaTlxWml2VE1WQTl0S1R6ekk5Tm0yYTlnekRNM05HTGNT?=
 =?utf-8?B?ZFpVZ3Q2clNYejNuajgrK2lrZzZZenZyWFRnMENOemlaODFhNmNrYUFmWXNs?=
 =?utf-8?B?Q01tZVl5blc4TGhYelQxR2VSSmZtS3kvY20xLzlFQXhRNDhTbTV6QTV4OWdF?=
 =?utf-8?B?Zmh4TXFQb3ZhZDZjU3dNVFQ0b1hCMGZROFh4N011SExNMG00eFlkNWNDd0pW?=
 =?utf-8?B?ektPYVlXdGJZL3VQa3VwUTRkUm5HZWZUSWFXdlFISHJpakU2R2hOWC8zMnky?=
 =?utf-8?B?dUFUalRWRnUxZ21LKzAyOUZGR2FuSFVvQ2RBNU5VYzZidEF0Z280TDFYYjRE?=
 =?utf-8?B?bGZscm5sZ0I3MVJneHVNclBXaFQxU1phM0JsZzNJYnF1SzhJOWRnRWtFa29h?=
 =?utf-8?B?ajFKbGZaVmdmWWdIRnAxdnc1dlZNZ0RJdVlmSTJNaTREdDd5RGkzdUJpd2lN?=
 =?utf-8?B?VWJXUThkbUE3VUkxREptVTBhclJZMHNDRXgxT0lpdkpLbU5nbEFmakxVU2ti?=
 =?utf-8?B?bjBwcnA3SDZBV3NSQkpmRWpDcVlVNWtPTXRMbDdFbGFyTnlidzc5SFlJcEdq?=
 =?utf-8?B?T2dJSlgrWktSYUpReW94UHlEbzZVa0VpOFl4UGJaeGIwQnU3SWlyTjR2WVpw?=
 =?utf-8?B?VjJJRDJ1L21xbEtVMUdING5ZNFpaa0JHZkNuU255ZG9WcjQxVUE3M0NJdFRn?=
 =?utf-8?B?V21mekhMLzFrUmc5bDBVQVVCcm5RNXhxbThWR0xYUEUwc0pGTUZtRWFRMTBs?=
 =?utf-8?B?L2RBMU1BVEV0bHFWNmFxa2pzbnZ0Unl3REd6L24ybmpPZXhjOXFiM1hMR0w1?=
 =?utf-8?B?OVFXc3d6WW9SODlJRzFiZDhiK00vVm5CcnRnMEJnc3ArM3dwZTNkK0ZzdTFM?=
 =?utf-8?B?emFGY1REK0Q4TEJ5dlBrNFZnV21QMnZGVkVUZGJmNjA0UktPSzhwbXFQZldl?=
 =?utf-8?B?b3BEd2JmMWkvZ2wrSlh2UFZ6MUxkYS9GallBOTJrTWYwUkNWOGxaTDhObEIx?=
 =?utf-8?B?eG5XRFJJbitpS1hpU2h4M3RtOGs2VlErRlptRGVheXZKa05FbDF1YWtRUnhZ?=
 =?utf-8?B?ODBYTDNDbksxRFRnV2VMNVJRd2hVdmZuTVB2R05mUE55Q2d2ZU5SY1hDMGQw?=
 =?utf-8?B?NGVsUnM5Ti8xbW41VnBGSUpsRlRpMG9PcGFPeEc4Wm1uRFpyQkpWcFoxUWdG?=
 =?utf-8?B?eDlvWFg0RE1SaG5iQkFNMm5UVm5wRG95WHg4MmVBSnJrcGNQbnh5djJ1M1BM?=
 =?utf-8?B?RTBQMlpFRmQ5VFp0WStJbnhSNkx6eit2MTRON2lCR0VYR0dqNWIvMWZ1LzVO?=
 =?utf-8?B?R3lFMDQyV1dXcmdEM1FIL0o5K3JobWVSK05OZkx0QVQ1MW1pYmlRSTUySGUy?=
 =?utf-8?B?YmJYbEE2THJBVmNTNEUvYjJEWFliV2FaZjgrakpjdmp6YUNoSkxsdDhxSDlz?=
 =?utf-8?B?UGRqdzFLSHR0TE00K3hCd05jOTBXWCtnWmJGZFhseDJnSkxQNjRKTmpHdDRF?=
 =?utf-8?B?NU9wbTFMWUZDUTZsbG5LMkprVndoUjlFNFhTWGxCQ2g5U1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bndVN1Y5ZjQwRE00dDlRNlBsR2ZvYkdDeUJtczFRZ1NXWmt4STVJMVd5Snhw?=
 =?utf-8?B?ZDZ0SjZ5ZWV1dXI3L3BHN25rSmFobEg4WjhwRGVJbVJxQnNXeHJxOGJib3lS?=
 =?utf-8?B?Q0txcmtBNk41U2s4czU4Q2R6aWlDbnVXUzluSlp5Y3o0cHNQUjAzTHlXUHBK?=
 =?utf-8?B?bzE1ZkNvSUdPdXljOENDOCsvRDJXZEEyaFJER3JrY1YxNjRhN1RvVXM0VDFv?=
 =?utf-8?B?MDJTa3hWMm9idlhEUUtFdmQxUkFaTFIxVVFKdVR3ai9aTS9xbkRVQzVaLzZO?=
 =?utf-8?B?Zy9ZcDJhL2QwUEUrVDdoU083UUk4Ync1Z1NMS1Q0d3ZUbnRnWFc5S3ZvYWNG?=
 =?utf-8?B?VVV5Y2pFZE92V0ZnRStyem9NY1pVVDJpSTJ0SURYdWRKV2VrMWUrV0I4QklV?=
 =?utf-8?B?b3FhZy9Ia2Vva3VpZ1lnOERnekhNbWF1RG5QU2FzZVFKY09Vc09ldDJXQlpt?=
 =?utf-8?B?dVlaTXY1Tjl3TFR3TkI1RmtHamxPWkFEUHlvK3dpcHA1VHB5azJHSHU4MG1J?=
 =?utf-8?B?dFM0TjBkUWZNQ0dEQytUa2J3MFhqSlB3UFpXdEJwOFJId2t6dUhQN2JHVERt?=
 =?utf-8?B?THVXMklYd0NXVmNCbFZIMXFXcWRyR1pqeFFGRVFFRDRjeHAwem13Qy9nVkdQ?=
 =?utf-8?B?OEZUdUZ5NFROalhpUEFKcUVNUllWNjJFVTJJSzNwb3UrM1hpTkJRSEl4TzZY?=
 =?utf-8?B?aW8vZUp1c1VxamUybmpkMGU0UjFCK2NRc0Y4SDhVMENvVkpSU0JaNjRCOXdC?=
 =?utf-8?B?ZTB6K0JYcG9XajBQMTJZbjNCMFhqQ0t2Qnp5NDdNbVJlVmFaeUxWUnNuQUZn?=
 =?utf-8?B?Ny9Vdk5TbTFmT0hhejc2d01NUWZ1TjVWcmR5dXJKWDNQaTcwRmNFdjE5OXBJ?=
 =?utf-8?B?YjBPajZvaEdQdWxqTWIzSVVVQ0xxYk5pR2tKNGpGcW4ySnRiTnlCVE8ya0ww?=
 =?utf-8?B?emk1bVhSOC9XejZkUTE1YmYvYUxCTjFLaEhXZ1dVbzVBYlRvblVJRGY3N0pW?=
 =?utf-8?B?NGRMQitRY1BJanVwTFU5N1drRU0yRE1CNktrOC85YUdWZUVWeGhlaG14c1g4?=
 =?utf-8?B?d1VoOXMvNUYrN0tMUGxLdFQ2SWs5ZU42TlVSK1I2WjBERXAvcGdqWFREVkd1?=
 =?utf-8?B?WUZweHlHKy82dTF0Y3hyWEhsb3laVGk4c1lFeUFuTG5iSlpuQzhDUDZBMEkx?=
 =?utf-8?B?R29kZ2U3MHIrQ1luRVFheVRaMGVac3hpSVBGbEhTVWdOYU9iREcvd1pqVndR?=
 =?utf-8?B?Q25adktia0l6aU56YWw0K2dKdHJmRmlOcGtnOTlBWGdzNWN4ZWJMalREQjNl?=
 =?utf-8?B?SEcwTFZxcktCUTdKbGFUL3hnYW5aQy9yVStUbmh6K3J1eXc0MC8yYml1WCtT?=
 =?utf-8?B?b2JXdmQ4SGZabFFNVzVNdGhLVzBRMHQzV1JSYm1aaGhJWVdxblFFeGJFNGVY?=
 =?utf-8?B?eWhZbU1JUUV1Qk9oY1J1WC93SzA2VTVUSitrNnJlaVVEcjFpM1lNWnc1RkNw?=
 =?utf-8?B?ZmtqK1FrUk40eWdTZWJQS2xEb2oraS93bEF4R3MyUWFHUXNrT2VXMUtqTHBi?=
 =?utf-8?B?N0ZJS2pNNGZPK3BFbGhCajl1RW5RdzFrRXBCSWk5eFU5aUFtNG1FakxOUks5?=
 =?utf-8?B?MGowcjdMZ3haMVh4TkI5VkIxMnRweENRdnAza3MvYnZPc1ZDbStuMnFYdjIy?=
 =?utf-8?B?eXFod3hwYXBRYzhOazNibWJoc3ZwcENscGk1eDVJcWZ6UXJHN2NJdWk0YUlx?=
 =?utf-8?B?d2FZOWg4TXhFUUUreTFVcU5oRldQcE9kbkcvMGxlWGJQWU5TR1BOME14M0NH?=
 =?utf-8?B?cHZuNjJrWXdCeUgxQmNOMTJBamxhdmU5czl1SGpQMmxDeVFESlBMamN0ckdh?=
 =?utf-8?B?dEM0U1RhNkU1ZkMxd3VYVEcwcE54ZDhsYklPUVhxWm9KaUF4OWgxZ2gvbDVS?=
 =?utf-8?B?RFBxKzdtRzhlQWRlbU5PNGY0c1Bsa0tqR0J2RUlIRDZFWTFlL2tQeXVzVFk1?=
 =?utf-8?B?d0lnU3c2R3RnVW1TVktJWlZ5Z1d4MGNLN0hSSzY0eGFZSU9kRkRpengwbHdL?=
 =?utf-8?B?Vk1IQUROU1VwUXJ4T0ljVzNvUkpsdSttdCs3TlN2eXN2NlhySnQvdURvWGhl?=
 =?utf-8?Q?zkqdUsipJ8zPESCELUw981owI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dcfe155-a118-4a5a-67a1-08dcdea32211
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 03:19:01.2039 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lypYj0DIsmCUHMRJy0Rrm6XPH6VjMFll8DqqpsDNfrSvVZEL9F/PrteY3JrBXB2UX6rP5lRjVJ9wQvPXIi4F9ltEOhSamCwIxlvE6mq+Ty4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6789
Received-SPF: pass client-ip=2a01:111:f400:feae::702;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
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

SGkgQW5kcmV3LA0KDQo+IA0KPiBPbiBUaHUsIDIwMjQtMDktMjYgYXQgMTU6NDUgKzA4MDAsIEph
bWluIExpbiB3cm90ZToNCj4gPiBBU1QyNzAwIGludGVncmF0ZXMgdHdvIHNldCBvZiBQYXJhbGxl
bCBHUElPIENvbnRyb2xsZXIgd2l0aCBtYXhpbXVtDQo+ID4gMjEyIGNvbnRyb2wgcGlucywgd2hp
Y2ggYXJlIDI3IGdyb3Vwcy4NCj4gPiAoSCwgZXhjbHVkZSBwaW46IEg3IEg2IEg1IEg0KQ0KPiA+
DQo+ID4gSW4gdGhlIHByZXZpb3VzIGRlc2lnbiBvZiBBU1BFRUQgU09Dcywgb25lIHJlZ2lzdGVy
IGlzIHVzZWQgZm9yDQo+ID4gc2V0dGluZyBvbmUgZnVuY3Rpb24gZm9yIG9uZSBzZXQgd2hpY2gg
YXJlIDMyIHBpbnMgYW5kIDQgZ3JvdXBzLg0KPiA+IGV4OiBHUElPMDAwIGlzIHVzZWQgZm9yIHNl
dHRpbmcgZGF0YSB2YWx1ZSBmb3IgR1BJTyBBLCBCLCBDIGFuZCBEIGluIEFTVDI2MDAuDQo+ID4g
ZXg6IEdQSU8wMDQgaXMgdXNlZCBmb3Igc2V0dGluZyBkaXJlY3Rpb24gZm9yIEdQSU8gQSwgQiwg
QyBhbmQgRCBpbiBBU1QyNjAwLg0KPiA+DQo+ID4gSG93ZXZlciwgdGhlIHJlZ2lzdGVyIHNldCBo
YXZlIGEgc2lnbmlmaWNhbnQgY2hhbmdlIHNpbmNlIEFTVDI3MDAuDQo+ID4gRWFjaCBHUElPIHBp
biBoYXMgdGhlaXIgb3duIGluZGl2aWR1YWwgY29udHJvbCByZWdpc3Rlci4gSW4gb3RoZXINCj4g
PiB3b3JkcywgdXNlcnMgYXJlIGFibGUgdG8gc2V0IG9uZSBHUElPIHBpbuKAmXMgZGlyZWN0aW9u
LCBpbnRlcnJ1cHQNCj4gPiBlbmFibGUsIGlucHV0IG1hc2sgYW5kIHNvIG9uIGluIHRoZSBzYW1l
IG9uZSByZWdpc3Rlci4NCj4gPg0KPiA+IEN1cnJlbnRseSwgYXNwZWVkX2dwaW9fcmVhZC9hc3Bl
ZWRfZ3Bpb193cml0ZSBjYWxsYmFjayBmdW5jdGlvbnMgYXJlDQo+ID4gbm90IGNvbXBhdGlibGUg
QVNUMjcwMC4NCj4gPiBJbnRyb2R1Y2UgbmV3IGFzcGVlZF9ncGlvXzI3MDBfcmVhZC9hc3BlZWRf
Z3Bpb18yNzAwX3dyaXRlIGNhbGxiYWNrDQo+ID4gZnVuY3Rpb25zIGFuZCBhc3BlZWRfZ3Bpb18y
NzAwX29wcyBtZW1vcnkgcmVnaW9uIG9wZXJhdGlvbiBmb3IgQVNUMjcwMC4NCj4gPiBJbnRyb2R1
Y2UgYSBuZXcgYXN0MjcwMCBjbGFzcyB0byBzdXBwb3J0IEFTVDI3MDAuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gDQo+IFNv
bWUgb2YgdGhlIHdyYXBwaW5nIGluIHRoZSBjb21taXQgbWVzc2FnZSBjb3VsZCBiZSBpbXByb3Zl
ZCwgYnV0DQo+IG90aGVyd2lzZToNCj4gDQpUaGFua3MgZm9yIHN1Z2dlc3Rpb24gYW5kIHJldmll
dy4NCldpbGwgdXBkYXRlDQoNCkphbWluDQo+IFJldmlld2VkLWJ5OiBBbmRyZXcgSmVmZmVyeSA8
YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1Pg0KDQo=

