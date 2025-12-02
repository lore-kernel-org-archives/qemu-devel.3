Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF04CFD376
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 10:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQNhC-0003yD-1l; Tue, 02 Dec 2025 05:33:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vQNh9-0003xi-IO
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 05:33:19 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vQNh7-0000yQ-Gv
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 05:33:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNE7uGkatHB47EN3j3oHgPguQ4SvQY4K/j/gM5HPfpzDHKq6/4jnLPL5/mPq3t1WrCmu8CgReM6xyut3rCiFzmsqn2qsOi1WUb9jm14y0xdUq329j/q9bm2bGhgqkhDK7ymRVeuwzThd2kSanjDMRn5NWt0aKHbseYSkShcl9N4zk2Q62nCqq91769i6xp1q160Sy5XX/0y69Fsm1cUswJLJ48d6jW30ytFWjw+S/aQ2slwCL2FPJ6aKryfPt3OURIe/wJ1ApdQyfRrWkfp4Q7JDv4GA9NZvoP1jO+lEvBWwmK/PQ9HmwvTbbf7oBkAW8pNFC2OojESlBME18gmBKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GO32HrRqZaYswQ3pHAEHt5rQYqPYPejTd82NqGmQKJ4=;
 b=GIlxcfk2OqvwRa2Nf6wb/Bx67v5zwwk2EaUsjw49tZwyEICf4I8oOBbpw9V5nz1+9JeQ5yBf8308Us5XYqepAU8nCOEfXXk2/DpyfAUDeW5avtYR2k6h+ms8IYgbgE/CKuqW6RTOFqVteMaKLsr7OW93h/gbwoJRiMdwcBW6rEixoA3vBD8U72n3M7GtRfE2AGtpoexKiTDTEHyhF9iPq0u4tx08tbgvU1NIsUInYaDZVvMV+M21mQeKfeC7mLDIfKst0M20SI0MdoawnEIUiZNKNY4Cs02nSQLEfXMEquMpTQCvaEW9P0lBLbaKfureaE9b4jYtPhxdjlYKS0YEWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GO32HrRqZaYswQ3pHAEHt5rQYqPYPejTd82NqGmQKJ4=;
 b=jj/wPvGdB3wMBeYvJGb1a5mGWRYYPpVpKqEAlhNZvYqAlC6QDwE0qT39DBwrr12+slqi+L2YFBjOdbW+nISkyUknTIZ4bsYBoA4FQOINEQ1ZSGilfhbWZbUHi6zFMmimvlHEgobFy6/66CNbiXn0TW/DZt2fYEZ9tSlPcx8RDYxK8pT/fMSQrbsmIjs0At2sTqKxMlLw2SEt7nq5JmqdDdGU7TJafZ/0hA0YVLYh59rURAmY9eZnp16Q+/0I9+/4tGx44olxDz93M6dyJmcUBqlmHGVRmnGqbWJ+ij68SkSPnkVPQGIW6YzljT9x9xI0pi5WVaUln9UPWWe3MT58vQ==
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by VE1PR04MB7423.eurprd04.prod.outlook.com (2603:10a6:800:1a0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 10:33:12 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 10:33:11 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Subject: RE: [EXT] Re: [PATCHv3 01/13] hw/arm: Add the i.MX 8MM EVK(Evaluation
 Kit) board
Thread-Topic: [EXT] Re: [PATCHv3 01/13] hw/arm: Add the i.MX 8MM
 EVK(Evaluation Kit) board
Thread-Index: AQHcWVR8vg+OgN6fY0K/4kkQkn7INbUOMgyAgAACORA=
Date: Tue, 2 Dec 2025 10:33:11 +0000
Message-ID: <AM9PR04MB848728E3D09323B636E7D54387D8A@AM9PR04MB8487.eurprd04.prod.outlook.com>
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
 <20251119130027.3312971-2-gaurav.sharma_7@nxp.com>
 <CAFEAcA8pb6cJ0h+L=fsE28HYpgkC2BWrT=kcwgVxCazJMPMy+A@mail.gmail.com>
In-Reply-To: <CAFEAcA8pb6cJ0h+L=fsE28HYpgkC2BWrT=kcwgVxCazJMPMy+A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8487:EE_|VE1PR04MB7423:EE_
x-ms-office365-filtering-correlation-id: a34f0185-6c2a-4ee5-6286-08de318e313d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?cHFBMSttRnRsM0JseGgxVW5wTlc1RXRCaVpwSEk5OVNMcHBMU2E1Qk5XTVAv?=
 =?utf-8?B?eXRDdERjOHM3cmZrR29XL1VCYWsxYTV3ZW1odXlpYlMvUTNKWkZBQVpDLytV?=
 =?utf-8?B?ZDZRSWpYK2Y4WE9JQWpiTFdFWnIvU2orQ2R5TWNKemIxSFcwTGlYNDc2alpR?=
 =?utf-8?B?ekpnUzcrMFF5dSt6TnlnMlhJMGNYdjg2VHByck8rYTFKZUIrOUlEMVZ2NlhO?=
 =?utf-8?B?RXlUWEFld2gybVBLSmFteFA2bm9PSU8vQnhLUEtFMkNaZFdQSnJTODg2NW1N?=
 =?utf-8?B?SitkbTZqQ0QwcVBxMjdnZEsrZTdRZi9aUkIvSURaY0ovZ0RlU3QwT1oxaVpa?=
 =?utf-8?B?Y0cySmlQVjRKRkNjazY0M2k1MWM5V2d2V3pGUUFKSGd4Zm1lbDJHZC9oR3Fj?=
 =?utf-8?B?NStWcnQyWW9SWHR3TytlWncvV0o5ZVpDZlZ3YjBGa1JQTzNxVDBrRnJTVzVO?=
 =?utf-8?B?bStNczkyNDBSOWFJZE4yTjRWenVmWUdYOENEL0lydzdnRVYvOElMeG5ocmRQ?=
 =?utf-8?B?Nmg1aUUxQTVIME9hOWUvczc0RVoxWDNZM05UQUxNVkc1WU9YNG5LMnFER25I?=
 =?utf-8?B?eHY5UWJCU3VhdG5ocHEvaWRZUVhGbGQ2d1R0YnZWcFRvTlhUYzdKUkZBWGRr?=
 =?utf-8?B?RmZtYzh3T0wxTFZzUk14OFJIQlJYa0hXUVE1MDUvcmlRem80VnJnc21reXRN?=
 =?utf-8?B?YWNaQ0dqZ0plN2lTSXdNMDN6b21OQnErRVdjQ1BLRzYxWEF3V2krTVBGdUtT?=
 =?utf-8?B?N0lBWmxpYzdSaElUMDhLYlM5eEVoWllxMUhGRVNHNVJ5bkw2QUJYTktEMHRm?=
 =?utf-8?B?L1Azdm5XbU04dGppTG1lZ2JNUFo1Z0MydVNEbGllMGNocG8vR2ZKUTMxQXVm?=
 =?utf-8?B?ZE85SVBGVFlOT0RabUZTaDI5cGM0c3laVEcrZWhKQU5YL2Q3K1NBQ1dGSjRx?=
 =?utf-8?B?VWFpaUR6cXdaYlE5YTNuMWhsSmV2QjVYQlk3MG42MEhrQ2V4dXlLMHdpOW54?=
 =?utf-8?B?SFBJU1hFSlZ4UWNjRDQ3M0VHNTJ2Ylp3dG1KNk02aG1pUUZDblJTODZJVmZR?=
 =?utf-8?B?ODdoS0c0Uk8yU0VlMkkxTFFGRGorRkZTOWhZdmpEU25pbnZpWTg3a3YwNzY1?=
 =?utf-8?B?MEE2Rm0waUhkYUFBbTF2RU4wdnAyMUVsbTBrWE5ab0R0cUM5bGlzN2RMa3lG?=
 =?utf-8?B?citxZWUrUzFjalVMMFAvUEhnTzZsRjR2NzJuVityWW9vWGtlRFhYZ2pHbHZq?=
 =?utf-8?B?bDBLa0h4YUtXWCtKMUdGcjVXNXh0cEZ5b3o5RU1sczYvOEZxME8vRzRCOWY4?=
 =?utf-8?B?QStYeURacnhQMDdCZmxwRGsxQXNteHhjZzVMZ3Q3VkFHQURoNFNobUt6WjRz?=
 =?utf-8?B?WmlQUG84NElBRUJEMHo0Y2taNVFCWGNFcGZxK09LV1dBNktLVDI3cVBvQmlt?=
 =?utf-8?B?M1VxMVNwTndrUHQrcXVtVWc0T2lFU0xGNWlPRkRBNGxyMUJDMTcxcUVWa09l?=
 =?utf-8?B?Nm5GRmVScmVLMGQ1VmxzVmhYNjFFWVZhdnEwYi9jWnd3UzBiQ0xQSzFDemtM?=
 =?utf-8?B?M29LQkNna3lDL3c1ZW52VHVwTW9ZekJuVjNLMzVDbXZCbXcydW9Ub0wwZGg4?=
 =?utf-8?B?SzNML28vQjhJUTVjVmtMV2xXUm5Td21rOHdSbmsyKzhnaGFqRi9DUTRFZmdC?=
 =?utf-8?B?V2FWNGVKQXFaRjNvcHlBclZtZWUzclNiNzBiTjBkNUZEVFV2UHZld0llRGRp?=
 =?utf-8?B?OXVweXAzSCtiSTU0bUlxUERqRVl0S0dackU3MWpFWUVBU2FTQlhoeVlXZ1Y3?=
 =?utf-8?B?ekNOM0xkYVVTZnp1MHo1ME9tN0hubUh6ZEJJTmNHV0dFc3JHajZ0azhjVnQ0?=
 =?utf-8?B?MXhuZ2JxZ1diZ0N5ekkwNm1GOGtyZEdWRmh2Y2NPbGErOGp1bVBWRHpxS3Vt?=
 =?utf-8?B?QndpclZ0MWJDMU9YcE90STZ0bmt3UVdiQTdHRkxNTW9ENmQ2T09NSU80Ny93?=
 =?utf-8?B?eEQ2eUgyZWc3cHVhZ1lYeFRJcFc2SnkwdnkzNHZ3Y2lzbUZ6aERyK0tLYlky?=
 =?utf-8?Q?y2ePXt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8487.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEpJOFBKaFRQRTFZQ1ZRUVMrM21GaHJ2elpUMC90R2Z3ZHhkbXNEU1VGREFF?=
 =?utf-8?B?aGZtaTFuMlQxZHhIZkxhQ0JXZFUvanBVQUxpOStMNlgrWjJGdHE2TXA0cHpm?=
 =?utf-8?B?WEc1NDNodUgraElXdUNRbTcyUHp0U3ZsVTdHaFBaa3ZPSUhTdHdtZGZ6TjVr?=
 =?utf-8?B?Vk9EdEhNUS90UE9oZXl5NEZuUnFvY09Db0h4SkRqbzV6cUZ1Z1FSb091cUJE?=
 =?utf-8?B?ckFNcVpIRDBLWThyTzlsd3FQbXQzZ0FTRTRBR0JHYlJtVDYraGZlTDZ0dmFp?=
 =?utf-8?B?dXNSYmRua08yZEE1enVRYzZYeFhUTXd3b3QrL3czSTlWbjJnOUV4M2d5c1lX?=
 =?utf-8?B?emRVaFFpbGNxTzFzamVQaG4yQmxrSnBBVDRkOXdPZ0EyZW9wbHI4UHA1MUNw?=
 =?utf-8?B?OEcrUi8xNXJMempwUk1BQUlCMWM5SGthZU1qaHllWngwOHBjdGZham40VUY4?=
 =?utf-8?B?WkIweGwxaWxzeFhicnNSRHluV1hRWnNEbThGaTBNR1Z4aVV2d003ZFNuZGNW?=
 =?utf-8?B?aHpiVzFFUFpwTEhiMDlNWS81Y0tsQlBiN3lYWE9YVnIyUGFpZjQ0MkUyU2lo?=
 =?utf-8?B?UVlOMUozNHpVS1RVaVZybFNlUHplRmhudEpHenhZTEkvNjF6bFBEdHpaZVhS?=
 =?utf-8?B?TlhzclZacXJQaGtDT0pmcnFPTUlkYVFlci9NK2ZsQ25kMFEwdUFCSE1teTZY?=
 =?utf-8?B?Q3JGaUQxTHpTeVU2ekQ4cmcvamhNOVRVMmxnNUxOZEZ5ZDRiRURzSjFkaTAw?=
 =?utf-8?B?WTE4bUcwZ2FGb1EwS1dIekJhTHQ4N3hDdDF3QVhtcndlR2pkOVlRMm5iN1ZX?=
 =?utf-8?B?MEV5SForSlVET1JKc09xU1FwU0dwdCtINTJqQVRLMmZyMjJMTW4rdDJGcHFn?=
 =?utf-8?B?UkhzTG1DRWxuZzJibjdReXFRb1dkQURKSVdmWitoZitzaVdiVVpvMDVtclBh?=
 =?utf-8?B?YXp3N3cyaDRyK1lQSmZPdWh6WnVla3dzaUdPTUxaNTUrWHg3TUJoSnZoM0tm?=
 =?utf-8?B?T1psNFc3OGM1elZ6bjJFUFZlcHlFV3JmR1FUNFhhYXFQeHllMW5ZallZUFBH?=
 =?utf-8?B?V0ZCTlFQamc5MlFkSHFjczNRZnQyTXNZVmh1Uk5hbTJBSXN3WUJQaFpOcG9E?=
 =?utf-8?B?Q3RaVy9BYjhiZ3pmM3dBTmRkRWpmempJL1dGTEV0YmFIVjNUL2NYV0RIcTFV?=
 =?utf-8?B?MHZuNlhXYkhZcTk5YzdqYldIcysxWVVwS2JSNnRkMk13ay9OMktmNW11cGFo?=
 =?utf-8?B?YUFmVk9SSVk1UTlzQ09ScElOOWt6Vm9xU05jVXAwS3BkQkxFYlh1VWFBdVcy?=
 =?utf-8?B?Y2ZSSUhGOTJWbU5NQ003c2VGMk1Ob24zTmRWTklzVHJLZW1NUUZhSWxLMmhl?=
 =?utf-8?B?SFRNa084TVpVN3RxNGtZN0V6dUhudks0UEF2eWthay9nUnJXb29qcmtrWmZU?=
 =?utf-8?B?dHJvemNTdFNBaUNDcVhWZGx1dGUyYjJ1Nm5kZW9IOUtKQ2tGWmw2R0VGQW1y?=
 =?utf-8?B?VHlaTHVVOHhDa0FHSjNmam5yaGZLdnpkNW5TRk9JUmRzV2FoT1dyYXh4ZEE2?=
 =?utf-8?B?TUd1OGk2dGcyWG5CeVZtbWVxdU1ZZU9aSkRMQ3EyaDUxZTYyb1lzL0xKekhB?=
 =?utf-8?B?S1JYNHRnYWFuQlBSWGI4a21Ra01jN1NoMEtEdWF2YXBGNTBZRk5UT3IyZW0z?=
 =?utf-8?B?bEpWdkl5WkpEVjlucjBOSXh1bHJzZTRPcGFWc0tLNUowUzZCOG5MWVdPK1A2?=
 =?utf-8?B?QStjTkxJcHNORW4zMDRtOWR5TnRrb0VsZWZna1VSaW8xdW54azBtN0o5Y0ww?=
 =?utf-8?B?Q0tlaXM1NjlOSUMvWC8zSXc2cTZpQ1ptamVBTjdWeVBoWDNxZlo1UUkvSW1h?=
 =?utf-8?B?V0VFWnNtSzFaVFZyaXI0aHJLeEZnVDZySFlDb2ZvN2dpYzFna3VlTG9Mdyts?=
 =?utf-8?B?YjdaUXI3bjZLVTJMd0JSdmMxejJiSHRNellaNGZpU1ExdCs0K1htNjlaVnlu?=
 =?utf-8?B?K2kzdzRJT1lNdmV1L2lldnZxVGVpZVQ3SDcwVlkzUTQzRUV6VUlqSmdLdkpk?=
 =?utf-8?B?ZlhtcDMrNmJzc0NhY015UGhadEMzYTkzZFVuOFYrbUZuUm1pWGJKSnMzdnNF?=
 =?utf-8?Q?t86Hpb3byGljN+meSZ2i6mBYw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34f0185-6c2a-4ee5-6286-08de318e313d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 10:33:11.3581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U9m5Ne9q3BEkctcp7z+Vrw9EuuCoLabBY2PdUwy1yTZ7z0aTT6H1gDJUEa7iTE7iUKJICUzSc7t12qW5q5zcxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7423
Received-SPF: permerror client-ip=2a01:111:f403:c20a::7;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBTZW50OiAwMiBEZWNlbWJlciAyMDI1IDE1OjMw
DQo+IFRvOiBHYXVyYXYgU2hhcm1hIDxnYXVyYXYuc2hhcm1hXzdAbnhwLmNvbT4NCj4gQ2M6IHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZzsgcGJvbnppbmlAcmVkaGF0LmNvbQ0KPiBTdWJqZWN0OiBbRVhU
XSBSZTogW1BBVENIdjMgMDEvMTNdIGh3L2FybTogQWRkIHRoZSBpLk1YIDhNTQ0KPiBFVksoRXZh
bHVhdGlvbiBLaXQpIGJvYXJkDQo+IA0KPiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVt
YWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3INCj4gb3BlbmluZyBh
dHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAn
UmVwb3J0DQo+IHRoaXMgZW1haWwnIGJ1dHRvbg0KPiANCj4gDQo+IE9uIFdlZCwgMTkgTm92IDIw
MjUgYXQgMTM6MDAsIEdhdXJhdiBTaGFybWEgPGdhdXJhdi5zaGFybWFfN0BueHAuY29tPg0KPiB3
cm90ZToNCj4gPg0KPiA+IEltcGxlbWVudGVkIENQVXMsIFJBTSwgVUFSVHMgYW5kIEludGVycnVw
dCBDb250cm9sbGVyIE90aGVyDQo+ID4gcGVyaXBoZXJhbHMgYXJlIHJlcHJlc2VudGVkIGFzIFRZ
UEVfVU5JTVBMRU1FTlRFRF9ERVZJQ0UgQ29tcGxldGUNCj4gPiBtZW1vcnkgbWFwIG9mIHRoZSBT
b0MgaXMgcHJvdmlkZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBHYXVyYXYgU2hhcm1hIDxn
YXVyYXYuc2hhcm1hXzdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZG9jcy9zeXN0ZW0vYXJtL2lt
eDhtbS1ldmsucnN0IHwgIDY4ICsrKysrKw0KPiA+ICBkb2NzL3N5c3RlbS90YXJnZXQtYXJtLnJz
dCAgICAgfCAgIDEgKw0KPiA+ICBody9hcm0vS2NvbmZpZyAgICAgICAgICAgICAgICAgfCAgMTIg
KysNCj4gPiAgaHcvYXJtL2ZzbC1pbXg4bW0uYyAgICAgICAgICAgIHwgMzYzICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICBody9hcm0vaW14OG1tLWV2ay5jICAgICAgICAg
ICAgfCAxMDkgKysrKysrKysrKw0KPiA+ICBody9hcm0vbWVzb24uYnVpbGQgICAgICAgICAgICAg
fCAgIDIgKw0KPiA+ICBpbmNsdWRlL2h3L2FybS9mc2wtaW14OG1tLmggICAgfCAxNTYgKysrKysr
KysrKysrKysNCj4gDQo+IENvdWxkIHlvdSBhbHNvIGFkZCBhIHNlY3Rpb24gdG8gTUFJTlRBSU5F
UlMgZm9yIHRoaXMgbmV3IGJvYXJkLCBwbGVhc2U/DQoNCkkgd2FzIGdvaW5nIHRocm91Z2ggdGhp
cyBodHRwczovL3d3dy5xZW11Lm9yZy9kb2NzL21hc3Rlci9kZXZlbC9tYWludGFpbmVycy5odG1s
LiBJdCBpbXBsaWVzIHRoYXQgdGhlIGNvbnRyaWJ1dG9ycyBhcmUgZ2VuZXJhbGx5IHBlb3BsZSB3
aG8gaGF2ZSBiZWVuIGFjdGl2ZWx5IGNvbnRyaWJ1dGluZyB0byB0aGUgY29tbXVuaXR5IGZvciBh
IHdoaWxlLiBTaW5jZSB0aGlzIGlzIG15IGZpcnN0IGNvbnRyaWJ1dGlvbiB0byB0aGUgY29tbXVu
aXR5LCB3aG9zZSBuYW1lIHdpbGwgZ28gdXAgYXMgYSBNYWludGFpbmVyID8NCg0KPiA+IGRpZmYg
LS1naXQgYS9ody9hcm0vZnNsLWlteDhtbS5jIGIvaHcvYXJtL2ZzbC1pbXg4bW0uYyBuZXcgZmls
ZSBtb2RlDQo+ID4gMTAwNjQ0IGluZGV4IDAwMDAwMDAwMDAuLjBjNjU4MTQxY2YNCj4gPiAtLS0g
L2Rldi9udWxsDQo+ID4gKysrIGIvaHcvYXJtL2ZzbC1pbXg4bW0uYw0KPiA+IEBAIC0wLDAgKzEs
MzYzIEBADQo+ID4gKy8qDQo+ID4gKyAqIGkuTVggOE1NIFNvQyBJbXBsZW1lbnRhdGlvbg0KPiA+
ICsgKg0KPiA+ICsgKiBCYXNlZCBvbiBody9hcm0vZnNsLWlteDYuYw0KPiA+ICsgKg0KPiA+ICsg
KiBDb3B5cmlnaHQgKGMpIDIwMjUsIEdhdXJhdiBTaGFybWEgPGdhdXJhdi5zaGFybWFfN0BueHAu
Y29tPg0KPiANCj4gQXJlIHRoZXNlIGZpbGVzIHJlYWxseSBDb3B5cmlnaHQgeW91IHBlcnNvbmFs
bHksIHJhdGhlciB0aGFuIE5YUCA/DQoNClRoaXMgd2lsbCBiZSB3aXRoIE5YUC4gSSB3aWxsIHVw
ZGF0ZSBpdC4NCg0KPiA+ICsgKg0KPiA+ICsgKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMC1vci1sYXRlciAqLw0KPiANCj4gSXMgdGhlcmUgYSBVUkwgZm9yIGEgcmVmZXJlbmNlIG1h
bnVhbCBmb3IgdGhpcyBTb0MgdGhhdCB3ZSBjb3VsZCBnaXZlIGhlcmUgPw0KPiANCg0KeWVzLCB3
aWxsIGFkZCB0aGUgbGluayBvZiB0aGUgcmVmZXJlbmNlIG1hbnVhbC4NCg==

