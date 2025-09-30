Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18698CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 01:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3PHq-0004VZ-Ff; Mon, 29 Sep 2025 21:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1v3PHh-0004NA-LJ; Mon, 29 Sep 2025 21:36:06 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1v3PHZ-0003WO-2d; Mon, 29 Sep 2025 21:36:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NR0hVJOHXy0aF0TGghHAnZxyUvkMJPjsIRjwmI/jha0FXyXoPL3DgAtKaHfDLufiGprQCjE9hyQVGbwbaOV2d6CDv9W78BXEFj4K/otBzuW0n7L3HuG/QE+QycTDFDTkH80syhYMERuIub56DpBHt+t0D/0/jpbugd+EMJKs7VbR/rXD5nHhGul+Jvo/syok3cpSKEYiM5Ge3hl5GUD/bcidibFYfJN5FgD0TnNhiJZ4vxMJRKgJ116BiHD1ThI7p17K9elCyqvZXlI6rqvffQ9o8hhJF+TpnQVXJELXGa3rhy1zBpZW8NAhazT8p6uATccvN1yN3pFhgs5wAnRs5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4/04yPkKjHvWEmFMupLydvdhV02vBFtxYozMNC0A3g=;
 b=QTjU5odvm1QARmlqsZgQHcXrbSy66Iwrcw1e6+Q7xSfH84Z5Vdx+Rs+hBwZs3G0sk6zHSI+bwohuL+t29Ko4apSFqQ84FxgDDwZirKwefsA9MflL3mOZXLtZej6UPNCHMbIAgnrtvCrL0V6z/hzA51jgED/1SWSuyAdKwthU1dkIxQqfG3DbeLzidQcIXI43MN9Q486lHr3g5Th9ITlMV2M4bowBZJhjxz6kvq1pyH7VVTB8o5HExxYdd2jjxvYinSEqukStTXubZ3VomoUr8KifqOheia7f/IG6dfJcGQ6KlnTVtkRAE7m4Exk/+BKplR1mztdhQsVySsOzx81s+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4/04yPkKjHvWEmFMupLydvdhV02vBFtxYozMNC0A3g=;
 b=SDEOBXxNpxtmelWiPoG4wGnIkEVdfvYMn5Q4FZhT/PIChNiLzL51Dj3QOAxp3ZXCJC8j8c1OMdPedEChvwECi7UohjiAgUVOYhsrikDLtwb8iEFN3Q5TN+aCPC2ydOgFa5uCVmXzGfOP5/EU7crsWkanurNvjxFQ7cKnsAHrKMbJXo729fByhEZuXuTV5nVgLCVrsUGhjWbsXtqrA5dAuuCItlhjIDEYVDa14JTNaBd8DrAzG1/p17DQCXFIsYYyjtCp48Kgr/aqtJI3R1ydRXeAiaS4uGomuLr1t+n1Os17QdhcUzgSzwPNx8pU/Z1+XxdU1LBE3emGI0hvNwHUyw==
Received: from TYPPR03MB9497.apcprd03.prod.outlook.com (2603:1096:405:319::8)
 by TYQPR03MB9459.apcprd03.prod.outlook.com (2603:1096:405:2ac::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 01:35:46 +0000
Received: from TYPPR03MB9497.apcprd03.prod.outlook.com
 ([fe80::b1e1:e93d:d3bd:3956]) by TYPPR03MB9497.apcprd03.prod.outlook.com
 ([fe80::b1e1:e93d:d3bd:3956%4]) with mapi id 15.20.9160.014; Tue, 30 Sep 2025
 01:35:46 +0000
From: "KFTING@nuvoton.com" <KFTING@nuvoton.com>
To: Yubin Zou <yubinz@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Hao Wu <wuhaotsh@google.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Titus Rwantare <titusr@google.com>,
 "KWLIU@nuvoton.com" <KWLIU@nuvoton.com>, "CHLI30@nuvoton.com"
 <CHLI30@nuvoton.com>, "Avi.Fishman@nuvoton.com" <Avi.Fishman@nuvoton.com>,
 "tomer.maimon@nuvoton.com" <tomer.maimon@nuvoton.com>,
 "tali.perry@nuvoton.com" <tali.perry@nuvoton.com>
Subject: RE: [PATCH 3/7] hw/arm: attach PCIe root complex to npmcm8xx
Thread-Topic: [PATCH 3/7] hw/arm: attach PCIe root complex to npmcm8xx
Thread-Index: AQHcIdazLnI4xSHj+kWAOUNGw2J70LSrEUxg
Date: Tue, 30 Sep 2025 01:35:46 +0000
Message-ID: <TYPPR03MB94974F2A86D1702C6129C325DB1AA@TYPPR03MB9497.apcprd03.prod.outlook.com>
References: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
 <20250909-pcie-root-upstream-v1-3-d85883b2688d@google.com>
In-Reply-To: <20250909-pcie-root-upstream-v1-3-d85883b2688d@google.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR03MB9497:EE_|TYQPR03MB9459:EE_
x-ms-office365-filtering-correlation-id: 00109e71-7b05-454a-5c9c-08ddffc1adc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TnArMkRuTGhmbUFoRDRkQXZXVVh4cGpiMXNCVnNteFAwVUVLbXhETzFBSmhr?=
 =?utf-8?B?MmptQ0toallSaGsxcHE4SFduZDUzeDNkRm1DSWlhN0lCN3h5dmwvdUI3eXJ6?=
 =?utf-8?B?MUN4UmpINmJYT1JSeVZpQkN0bGFoR0lZQ0kyZEZEbkUvUCtpZ1VGdzVsR3g5?=
 =?utf-8?B?aTBpZGlvQVBtN2paZFkwekZnOFprN0FjZVdUSmhiQWt2dEI1Rjg4WVVSQmtL?=
 =?utf-8?B?YlVkb1IxM053Z1hNNlAwR3NMdWZVcng5MDN4WFFLbk5uMkZ5ZEtSTEhQZUNw?=
 =?utf-8?B?QlZlWEprRldhSkdpTFJkdEdUeUJ0WUEzdHhqSnV4SThpY29TZnN5aTEyRVFO?=
 =?utf-8?B?UlZDSkpIbmhLRGk2clpWLzhyZ2pIRGFNUEZZSUk3S0JTSkpkZ0krbkN0WG94?=
 =?utf-8?B?UGlFbUs2SGViTWF5T2tHeXFqSUM0WklDQndodTNDTjRhcDZmQWJhQ1NhWkJB?=
 =?utf-8?B?bG5vR2R1cXNzUGQyUUduZGxWbURlR2RsUFUvcXZkMSs1NHA3THNtU0pqNTFx?=
 =?utf-8?B?M21rbEwvanNmNEtZRGRPL1kwS0pzUitoNk9OUkdrSk9YZkNSUFdFZEJNMUx5?=
 =?utf-8?B?cUVlamt5cXpQL2tFTTZKL1h4bzdtbXpiSzBIak1BeTFJaGduRDdob1QyaGo5?=
 =?utf-8?B?V2Y4U2JZelBSUDZLdVlicElYdk9OS2Rob0pZUGlLTDY1ZGNSUGVsMUtHU29n?=
 =?utf-8?B?NFBKWWxiM0VpeW83cUM3TWlhckQ2QzlYd1NYSWVUVDh5ZGI3eDNwQllCbW4w?=
 =?utf-8?B?VHg1cE1ySDkveHVZQXFJMmZNdFNmZmJYRjlqS2JsUmRVWnhINm1TZHJGRFVm?=
 =?utf-8?B?dkxLcWhQWUNhSzgwZnZGcXk1eFpURFZZeUlneVkvSHVDM3FhT05VWHYxbGhm?=
 =?utf-8?B?WGgrYnpyS29QNnBVVVVzVkJ0NjVuMUQ2cE1XVGtsN1poTGZ0T2dlbHJBNEJM?=
 =?utf-8?B?bzJQRldUcUxHMVZXRnJSTnlGNlFPd0VwR3JaRS9ENXh2a1czbERqbElScVBD?=
 =?utf-8?B?emsrRHJnMExKMW5laGQ0Vy9OT2d0MnlrNStnaHM4WnBiODRSbTI2R21vNmNP?=
 =?utf-8?B?eFdoSkRwRk9ua2l5QjJuZ1prMS9MaUFEMmwrc0JYZlNDZVFxZVo2bzhtV0t2?=
 =?utf-8?B?blJtaVlJL2xqR0c4WXB1cFBwRHRIcHVQWDRnanpzMmYvSFl6bjJ0dEJXSmM4?=
 =?utf-8?B?d09nOUFZYmJiYW94VHNBM0tOUFQ1SFoxMWhQOHVhaFJPeXpuZVdLa0d6UmRa?=
 =?utf-8?B?WlJRNGpsaE5xOHJCM1U0S0JwR0JlOGhRNFhSS2w2dXNlV1lCdk5sQVJ2QUJy?=
 =?utf-8?B?bEZ4UXBtTWxVbWxlWHBETE9TbkVXYzFLWDAxZnBkaTVZclN6dTcxZ3JadVZk?=
 =?utf-8?B?SDlxTkI1TXRtUmJkcFBxRzRUMHdnNGpOWU1MNWt0ZStaTkdyZWEyMDM0WFVq?=
 =?utf-8?B?T0ZONWJhY2NFbWVoNC9mRDNyUnV3RkNxUzBpU0hFUWozN2RDd1QxOVBvR2RY?=
 =?utf-8?B?bi9lRks4MytKWGcvQi9Jc0pjOXJrcWJ2VHFab21WWWhWOVdYUnF3bk8xMm91?=
 =?utf-8?B?VU9ya1U2TWRJZWNraUhhMUQvMmxJS05wUEsydXk3RzIyY1Q0cnYza0VJMmpq?=
 =?utf-8?B?RUVBVEFCMmYveHpmU3JsNWk4R2IybHBYVnJqNE5iUXJtZld6RnErQ1R2ZDk4?=
 =?utf-8?B?dDJpMUJWbVVnWUVENjlMSTlPWlh5Qy9PODhJYjhWMXFIeGh2M1A0L0hwU3lo?=
 =?utf-8?B?UEN5M2xINUVnSWltNTZWWkxmeUJuU2s4N3BnSXZTZGkvVmVGV09jUlIxNytW?=
 =?utf-8?B?Z2tOUitEalg2WjlNZjhvZ0lka3R1dCszMDhCVGpCSkkxbDFoTWhhU2p5WGx2?=
 =?utf-8?B?U3dvc2lNZ25EK29kV1cvNnVPWmlVeFptTzF4c3kvWUU3K3Y2SVJQL2Vua3VS?=
 =?utf-8?B?SGxxSDc4QkpDRDV2Qmx3SnpjVnRLTlV6Z01nWWRtSm9VQUNhVEdiVU82aUxC?=
 =?utf-8?B?emw1Q0cvMG1DajQvRlFSbHYwYUtYVHBSdmltUkhkWGVlZ3YxdWNtTEoyWUxw?=
 =?utf-8?Q?dp5+Ud?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR03MB9497.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vnh0NVZQMlhMeFNhRU4zR08ydjNyTlZsUExZblJuT2FQSTlSR1d0dWE5dVRF?=
 =?utf-8?B?Z0gzTm4rZ2l1aldMRGdXd2NoV3FwMW8yRGhmUHBLQm5iSlFTQ1Yxb3lTeGRF?=
 =?utf-8?B?dVFxeG9Rbm9WUjlUekIzbkRDQ21odVUwNUIzSHpDNnJidE02Sms3bXNlOVZW?=
 =?utf-8?B?aCs1dXhaZjVzYnUzVmZvYStvZWlXVnVYeWh3OEpNTWxOUjBBTms0SnoyVXVn?=
 =?utf-8?B?YVExdXBZVzhSVzJyWUJrMG5vV2lDVlp0US8rU0MxNDRqS05DNEJFN241WmVr?=
 =?utf-8?B?YklLd3JsclpIUkFLNEJxekFZQWIzcG9pWUhMa293aUQ2QUtWTWlOY1E5S3Uy?=
 =?utf-8?B?VnVZMlhLSjJJV3lEbkRBVTdVeStQTy9NYkxOWnFyN0NIbndsY3IrclJ1aWxh?=
 =?utf-8?B?cG12VGxGVk5KK0JPN0JFdHU3d3l6SDVXVmpoblplMnd6YXFpREQ0eHZvQ0c1?=
 =?utf-8?B?MWhyZG8yMUd2V2tCL1JIQjdkeUxRUDZVZi9YV285c1dpWk82YjRVNFZUOE1B?=
 =?utf-8?B?WXM0K3ZVTVlYWEtURnRKTVdxRXFHcGRCdXdQZmliTmk5QzhGTXVVYkU4bXJQ?=
 =?utf-8?B?NVJHUW5xcnhtUkk2eDliZ2N0VmV4Q21meFBWQmIwcVN5UzBrcC9GTzZEM0VM?=
 =?utf-8?B?a3FUdzBCYXgyYkF0QSs2NUwyQTA5Z1RXc01Rbm1PNjlrS09SYytRbVJKejRB?=
 =?utf-8?B?NDM5Sy9yM3FqVmpEZDBqbStHTTRKbE1EOTNUNTY4RzBYT3B1MHNkcnJ2eG1h?=
 =?utf-8?B?VkJ6NmhZdVlIM1M3VnJXbzN6U2hoTGZ3aFliRjhnU1pBd2w3WWZ1MUhzYm0r?=
 =?utf-8?B?TXptV0FYa0tOQ0loeStnVUpDeCtBcHF5MjIxS2lIKzlsY254bWV0cVcyWjIr?=
 =?utf-8?B?TFdOWVBHY3ZaenhnRW9UdGxrbUxZYmg2YWQxVkpLS3VIMk9qR0tobUpyU29V?=
 =?utf-8?B?ZXpEWnVBZ1lJb3krN0tyTEhmT24va0R6UFpFVmM3SlErdDM2d3ViVXZsalFU?=
 =?utf-8?B?cjlyYVYxOUdzYmFrMmx1Skh0cURyQnI1RjZlVnFqRUFSSVdjWlFmL2ZzU1Ew?=
 =?utf-8?B?NzVYMnZHYVlGdFZIc0srdzIwa216eTI1M1FQOEg1NlIzNVhuWHlDcUdGUWlD?=
 =?utf-8?B?eU9Mb1VST3VZQmhxbzhjRFVVaFdzSFRYNkEyM29Ub3B2amgvQ21uWFJVRWZ3?=
 =?utf-8?B?NTZSWDVTYlpNQlNUa2xKamExaGNYZ3VoTUU0Z3YzWTduUjliWFdFRlVybGg5?=
 =?utf-8?B?UnVXajlRVmJ3bW0ySlhUZHFNYUxFVCtoYUpvcnExOVZ1ZjNPS1M5SXlzcTlW?=
 =?utf-8?B?UDE4YTVjc3hhWHdQd2pwejB2cGI3QjhhektOdUdhZC9PMXZOcTFSUThRd051?=
 =?utf-8?B?aHJpWW5wV0R4SXNDRiswV3lOenVSeUNNOWU1RCs3RTRMR0o3MVVUTHVuS0Rp?=
 =?utf-8?B?SFdSR3hqYm1UdlM2MHNtZEpjdXBlY2JBNWtBT1kxWUVJY2szQ2Nla2dzblJn?=
 =?utf-8?B?bmliSmY5R2NmQ2NtbXZDcTgyMFUxY3locUUxRE1vS2s2ekNyMm04SmEvWm9E?=
 =?utf-8?B?WTNYb1ZQOG94b1Y0WE53bkczYVIxLy9OdHNzMm5JSFpkblFpc3grZ0JoQ3V4?=
 =?utf-8?B?dHpsdHBjOU5DSjlzdWI5aVdmK3pJT2NHT2VacUd6NVljVXIweXdDZnZOb0FG?=
 =?utf-8?B?UThuQ0xJZE52N0pNdlNiazZYZ2UyYXlSNVQ2VzZjQWxvZk9IZ3Qxb2pOUktL?=
 =?utf-8?B?TTVRbTdwVDhmN2hWeWNZVDVORXlnck5CeldwMC9kSHNpM0didlkrU0d1L0Fp?=
 =?utf-8?B?VlBReWZ0UG90MzkvdzB5K2dhMllXd1BGZjFTUG9Ld2cwSDdIQzZ0OXduZnZZ?=
 =?utf-8?B?VEt6alYzQ0YyOVVJWW5WU3dBeDZiaXhzWS9qbEtBL1FoZ0Fxdk9KMVAxL2lT?=
 =?utf-8?B?NGNkUXhjWllDU3A5bDlpemZEVHk3Z3JhMUJXYkZJTnNwT3h6UEtOclJDTjB4?=
 =?utf-8?B?RmdOc2twR1JKK2tnOEFEcXZwd0RUTlBnQ2dZR2xYRS9nc2JMY1lkV05neXlQ?=
 =?utf-8?B?NXBsL2hYYjliczlWMktHZktXOVc3dUUzYVhXNlJmcnpKVXh0TndKd3owUGhK?=
 =?utf-8?Q?MyieuvtDF3E17Nv1snHNk2RpB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR03MB9497.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00109e71-7b05-454a-5c9c-08ddffc1adc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 01:35:46.5178 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hCUMD4l7BLX3WAUhpJDjoCna+QuqdszvxKxaz5gO76HLQmiATqnk09euqWIJptj0iNE2/7OrYGR42HklVi+ePw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR03MB9459
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=KFTING@nuvoton.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

TG9vcCBpbiBtb3JlIE51dm90b24gZm9sa3MuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBZdWJpbiBab3UgPHl1YmluekBnb29nbGUuY29tPg0KU2VudDogV2VkbmVzZGF5LCBT
ZXB0ZW1iZXIgMTAsIDIwMjUgNjoxMSBBTQ0KVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KQ2M6
IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+OyBDUzIwIEtGVGluZyA8S0ZUSU5H
QG51dm90b24uY29tPjsgSGFvIFd1IDx3dWhhb3RzaEBnb29nbGUuY29tPjsgcWVtdS1hcm1Abm9u
Z251Lm9yZzsgUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgWXViaW4g
Wm91IDx5dWJpbnpAZ29vZ2xlLmNvbT47IFRpdHVzIFJ3YW50YXJlIDx0aXR1c3JAZ29vZ2xlLmNv
bT4NClN1YmplY3Q6IFtQQVRDSCAzLzddIGh3L2FybTogYXR0YWNoIFBDSWUgcm9vdCBjb21wbGV4
IHRvIG5wbWNtOHh4DQoNCkNBVVRJT04gLSBFeHRlcm5hbCBFbWFpbDogRG8gbm90IGNsaWNrIGxp
bmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBhY2tub3dsZWRnZSB0aGUgc2VuZGVy
IGFuZCBjb250ZW50Lg0KDQoNCkZyb206IFRpdHVzIFJ3YW50YXJlIDx0aXR1c3JAZ29vZ2xlLmNv
bT4NCg0KU2lnbmVkLW9mZi1ieTogVGl0dXMgUndhbnRhcmUgPHRpdHVzckBnb29nbGUuY29tPg0K
LS0tDQogaHcvYXJtL0tjb25maWcgICAgICAgICAgIHwgIDMgKystDQogaHcvYXJtL25wY204eHgu
YyAgICAgICAgIHwgMTAgKysrKysrKysrLQ0KIGluY2x1ZGUvaHcvYXJtL25wY204eHguaCB8ICAy
ICsrDQogMyBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvaHcvYXJtL0tjb25maWcgYi9ody9hcm0vS2NvbmZpZyBpbmRleCAyYWE0
YjVkNzc4NjRmZjAxZTY5NjUwNzExZTdkOTE0ZjM1MWU5OTY2Li42YWMzOGQwODNlNGEwMWUwOWZj
MDBlNjNkZjY2MDQ2YzdjMTdiMzU2IDEwMDY0NA0KLS0tIGEvaHcvYXJtL0tjb25maWcNCisrKyBi
L2h3L2FybS9LY29uZmlnDQpAQCAtNDk5LDcgKzQ5OSw4IEBAIGNvbmZpZyBOUENNOFhYDQogICAg
IHNlbGVjdCBTRVJJQUwNCiAgICAgc2VsZWN0IFNTSQ0KICAgICBzZWxlY3QgVU5JTVANCi0NCisg
ICAgc2VsZWN0IENNSVMNCisgICAgc2VsZWN0IE5QQ01fUENJRVJDDQoNCiBjb25maWcgRlNMX0lN
WDI1DQogICAgIGJvb2wNCmRpZmYgLS1naXQgYS9ody9hcm0vbnBjbTh4eC5jIGIvaHcvYXJtL25w
Y204eHguYyBpbmRleCBhMjc2ZmVhNjk4NTcxNWNmODJlYTBhYzdiYjVhYWU3OGQyMDAzY2NmLi45
YjNlNjQ4ZTNmYzNjYTQzNTJkNWM4ZDMxMGExOWVhNDYyZTYyY2M3IDEwMDY0NA0KLS0tIGEvaHcv
YXJtL25wY204eHguYw0KKysrIGIvaHcvYXJtL25wY204eHguYw0KQEAgLTUwLDYgKzUwLDcgQEAN
CiAjZGVmaW5lIE5QQ004WFhfQ0xLX0JBICAgICAgICAgIDB4ZjA4MDEwMDANCiAjZGVmaW5lIE5Q
Q004WFhfTUNfQkEgICAgICAgICAgIDB4ZjA4MjQwMDANCiAjZGVmaW5lIE5QQ004WFhfUk5HX0JB
ICAgICAgICAgIDB4ZjAwMGIwMDANCisjZGVmaW5lIE5QQ004WFhfUENJRVJDX0JBICAgICAgIDB4
ZTEwMDAwMDANCg0KIC8qIEFEQyBNb2R1bGUgKi8NCiAjZGVmaW5lIE5QQ004WFhfQURDX0JBICAg
ICAgICAgIDB4ZjAwMGMwMDANCkBAIC0xMzYsNiArMTM3LDcgQEAgZW51bSBOUENNOHh4SW50ZXJy
dXB0IHsNCiAgICAgTlBDTThYWF9HUElPNV9JUlEsDQogICAgIE5QQ004WFhfR1BJTzZfSVJRLA0K
ICAgICBOUENNOFhYX0dQSU83X0lSUSwNCisgICAgTlBDTThYWF9QQ0lFX1JDX0lSUSAgICAgICAg
ID0gMTI3LA0KICAgICBOUENNOFhYX1NNQlVTMF9JUlEgICAgICAgICAgPSAxMjgsDQogICAgIE5Q
Q004WFhfU01CVVMxX0lSUSwNCiAgICAgTlBDTThYWF9TTUJVUzJfSVJRLA0KQEAgLTQ2Nyw2ICs0
NjksNyBAQCBzdGF0aWMgdm9pZCBucGNtOHh4X2luaXQoT2JqZWN0ICpvYmopDQoNCiAgICAgb2Jq
ZWN0X2luaXRpYWxpemVfY2hpbGQob2JqLCAibW1jIiwgJnMtPm1tYywgVFlQRV9OUENNN1hYX1NE
SENJKTsNCiAgICAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQob2JqLCAicHNwaSIsICZzLT5wc3Bp
LCBUWVBFX05QQ01fUFNQSSk7DQorICAgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKG9iaiwgInBj
aWVyYyIsICZzLT5wY2llcmMsDQorIFRZUEVfTlBDTV9QQ0lFUkMpOw0KIH0NCg0KIHN0YXRpYyB2
b2lkIG5wY204eHhfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApIEBAIC03
NjYsMTAgKzc2OSwxNSBAQCBzdGF0aWMgdm9pZCBucGNtOHh4X3JlYWxpemUoRGV2aWNlU3RhdGUg
KmRldiwgRXJyb3IgKiplcnJwKQ0KICAgICBzeXNidXNfY29ubmVjdF9pcnEoU1lTX0JVU19ERVZJ
Q0UoJnMtPnBzcGkpLCAwLA0KICAgICAgICAgICAgIG5wY204eHhfaXJxKHMsIE5QQ004WFhfUFNQ
SV9JUlEpKTsNCg0KKyAgICAvKiBQQ0llIFJDICovDQorICAgIHN5c2J1c19yZWFsaXplKFNZU19C
VVNfREVWSUNFKCZzLT5wY2llcmMpLCAmZXJyb3JfYWJvcnQpOw0KKyAgICBzeXNidXNfbW1pb19t
YXAoU1lTX0JVU19ERVZJQ0UoJnMtPnBjaWVyYyksIDAsIE5QQ004WFhfUENJRVJDX0JBKTsNCisg
ICAgc3lzYnVzX2Nvbm5lY3RfaXJxKFNZU19CVVNfREVWSUNFKCZzLT5wY2llcmMpLCAwLA0KKyAg
ICAgICAgICAgICAgICAgICAgICAgbnBjbTh4eF9pcnEocywgTlBDTThYWF9QQ0lFX1JDX0lSUSkp
Ow0KKw0KICAgICBjcmVhdGVfdW5pbXBsZW1lbnRlZF9kZXZpY2UoIm5wY204eHguc2htIiwgICAg
ICAgICAgMHhjMDAwMTAwMCwgICA0ICogS2lCKTsNCiAgICAgY3JlYXRlX3VuaW1wbGVtZW50ZWRf
ZGV2aWNlKCJucGNtOHh4LmdpY2V4dHJhIiwgICAgIDB4ZGZmZmEwMDAsICAyNCAqIEtpQik7DQog
ICAgIGNyZWF0ZV91bmltcGxlbWVudGVkX2RldmljZSgibnBjbTh4eC52ZG14IiwgICAgICAgICAw
eGUwODAwMDAwLCAgIDQgKiBLaUIpOw0KLSAgICBjcmVhdGVfdW5pbXBsZW1lbnRlZF9kZXZpY2Uo
Im5wY204eHgucGNpZXJjIiwgICAgICAgMHhlMTAwMDAwMCwgIDY0ICogS2lCKTsNCiAgICAgY3Jl
YXRlX3VuaW1wbGVtZW50ZWRfZGV2aWNlKCJucGNtOHh4LnJvb3RjIiwgICAgICAgIDB4ZTgwMDAw
MDAsIDEyOCAqIE1pQik7DQogICAgIGNyZWF0ZV91bmltcGxlbWVudGVkX2RldmljZSgibnBjbTh4
eC5rY3MiLCAgICAgICAgICAweGYwMDA3MDAwLCAgIDQgKiBLaUIpOw0KICAgICBjcmVhdGVfdW5p
bXBsZW1lbnRlZF9kZXZpY2UoIm5wY204eHguZ2Z4aSIsICAgICAgICAgMHhmMDAwZTAwMCwgICA0
ICogS2lCKTsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2FybS9ucGNtOHh4LmggYi9pbmNsdWRl
L2h3L2FybS9ucGNtOHh4LmggaW5kZXggYTgzNzdkYjQ5MDU4NjYzNmNhNGMyZTQ5MWM5MWY0MGRl
MGYxN2Q4Ny4uZmE5NjhlOWMwODgxYWRhYzZhMjdmYjVmMjExN2UyZmNlMTYzYmU0NyAxMDA2NDQN
Ci0tLSBhL2luY2x1ZGUvaHcvYXJtL25wY204eHguaA0KKysrIGIvaW5jbHVkZS9ody9hcm0vbnBj
bTh4eC5oDQpAQCAtMzEsNiArMzEsNyBAQA0KICNpbmNsdWRlICJody9uZXQvbnBjbV9nbWFjLmgi
DQogI2luY2x1ZGUgImh3L25ldC9ucGNtX3Bjcy5oIg0KICNpbmNsdWRlICJody9udnJhbS9ucGNt
N3h4X290cC5oIg0KKyNpbmNsdWRlICJody9wY2ktaG9zdC9ucGNtX3BjaWVyYy5oIg0KICNpbmNs
dWRlICJody9zZC9ucGNtN3h4X3NkaGNpLmgiDQogI2luY2x1ZGUgImh3L3RpbWVyL25wY203eHhf
dGltZXIuaCINCiAjaW5jbHVkZSAiaHcvc3NpL25wY203eHhfZml1LmgiDQpAQCAtMTA0LDYgKzEw
NSw3IEBAIHN0cnVjdCBOUENNOHh4U3RhdGUgew0KICAgICBOUENNUENTU3RhdGUgICAgICAgIHBj
czsNCiAgICAgTlBDTTd4eFNESENJU3RhdGUgICBtbWM7DQogICAgIE5QQ01QU1BJU3RhdGUgICAg
ICAgcHNwaTsNCisgICAgTlBDTVBDSUVSQ1N0YXRlICAgICBwY2llcmM7DQogfTsNCg0KIHN0cnVj
dCBOUENNOHh4Q2xhc3Mgew0KDQotLQ0KMi41MS4wLjM4NC5nNGMwMmEzN2IyOS1nb29nDQoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXw0KIFRoZSBwcml2aWxlZ2VkIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBjb250YWlu
ZWQgaW4gdGhpcyBlbWFpbCBpcyBpbnRlbmRlZCBmb3IgdXNlIG9ubHkgYnkgdGhlIGFkZHJlc3Nl
ZXMgYXMgaW5kaWNhdGVkIGJ5IHRoZSBvcmlnaW5hbCBzZW5kZXIgb2YgdGhpcyBlbWFpbC4gSWYg
eW91IGFyZSBub3QgdGhlIGFkZHJlc3NlZSBpbmRpY2F0ZWQgaW4gdGhpcyBlbWFpbCBvciBhcmUg
bm90IHJlc3BvbnNpYmxlIGZvciBkZWxpdmVyeSBvZiB0aGUgZW1haWwgdG8gc3VjaCBhIHBlcnNv
biwgcGxlYXNlIGtpbmRseSByZXBseSB0byB0aGUgc2VuZGVyIGluZGljYXRpbmcgdGhpcyBmYWN0
IGFuZCBkZWxldGUgYWxsIGNvcGllcyBvZiBpdCBmcm9tIHlvdXIgY29tcHV0ZXIgYW5kIG5ldHdv
cmsgc2VydmVyIGltbWVkaWF0ZWx5LiBZb3VyIGNvb3BlcmF0aW9uIGlzIGhpZ2hseSBhcHByZWNp
YXRlZC4gSXQgaXMgYWR2aXNlZCB0aGF0IGFueSB1bmF1dGhvcml6ZWQgdXNlIG9mIGNvbmZpZGVu
dGlhbCBpbmZvcm1hdGlvbiBvZiBOdXZvdG9uIGlzIHN0cmljdGx5IHByb2hpYml0ZWQ7IGFuZCBh
bnkgaW5mb3JtYXRpb24gaW4gdGhpcyBlbWFpbCBpcnJlbGV2YW50IHRvIHRoZSBvZmZpY2lhbCBi
dXNpbmVzcyBvZiBOdXZvdG9uIHNoYWxsIGJlIGRlZW1lZCBhcyBuZWl0aGVyIGdpdmVuIG5vciBl
bmRvcnNlZCBieSBOdXZvdG9uLg0K

