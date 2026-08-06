Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EB8C55838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 03:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wronJ-0003eJ-Qy; Wed, 05 Aug 2026 23:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wronI-0003eA-J4
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 23:29:20 -0400
Received: from mail-centralusazon11020135.outbound.protection.outlook.com
 ([52.101.61.135] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wronF-0005AS-SH
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 23:29:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTR4pkYXyjHRAMgPuFiFZjDtrY6sniLoJl2DHjryMUrJZtP/1HX8izhjZhOOzy8AnY0eGkEyjRMuGHWqgonL8EoqdB5w0jH7pYmfC5R2hQkwl+lhUvAAHC+mKqTYSMiYoM3wsGA00lK+GWCxAZFAtIhwjW96ghmZA73YVIi0c2t5WK8uBTe088+XWVxRVg2CEsxykM85hV2Dg9VCwwc0dhgLpI5dOjyGiVik2DglBuGAQaS/UnDZbUJMA/0h/1vFL55w0JkXr92eOwPLzI4/QH4iI6p3obgOn0W2hgUpOXEVLZ+ScYIcRegbOIUHfR+UIuPc2+313qzl6bSw7O3zug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riewZLav2Sb1Y6wPrGT09HiNhN7QHgMFjdpzMn+9Ssw=;
 b=k8YtCNzV/Y92kmG8NrNPmanVx2VS1LVec4OkVEmcEld4IXcFWAB0oBBG2zMGChgKRpyHRVItMfDQycK9PQWv0RLFaVsftXNdqC4vaXyapkHpPimAstV/ZiZ2ZnbwZZYp4Z0nIU8lk7x0zOA88vwtOPLoHzXOyUBQchHGGRO0ow5S0KTcut+JfceN4ie6GJN3//WEb0CikZrUlsOZgQz8WVQOYupnVJjoQRLE2qgAnARVMfTsTu7C/t+pRldh46X/an835fTC0meJdwzihttkyDboEo2K3MXSxpyZmqRrvsc9xlqBZnyIIEI4+BS1aZILdRuoOwOZyxK5NAeIvrEYCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riewZLav2Sb1Y6wPrGT09HiNhN7QHgMFjdpzMn+9Ssw=;
 b=FhQ0ZgcduGCJzwdvMBCbTYjVOExna+fi9JVU5EuIqwfuSkOLoWhvEtCSjbLeewcrvwdSONFyl35Q6F07PrkOvjdwS7fRJd7A87sVgXnfT/CoPXIWN5ykPzWVVc5P1fFOdsx/v/64N3MkymnFzZAbyul968E0dO3EsxkjzNNd8B2KNrZU1xdaEMC2R8M9vNbI/E+AeS4gl1WiUREjO14e7G2DmFThfuY/M6McrSInCl7NMxD5tm7yEFuH2KcM5byAfG5/KaOqOG1K6F/urWtENYTVgBafNloNzDuai+1YRjbgyb0anSaMy42y4loY0IYLLU+de0ZdC0xvpqOVf4gm1A==
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by LV8PR18MB5558.namprd18.prod.outlook.com (2603:10b6:408:184::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 03:24:11 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 03:24:11 +0000
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>
Subject: =?iso-2022-jp?B?GyRCMnNKJBsoQjogW1BBVENIIHY3IDAvOF0gQWRkIEF4aWFkbyBTb0Mg?=
 =?iso-2022-jp?B?QVgzMDAwIGFuZCBFVksgYm9hcmQ=?=
Thread-Topic: [PATCH v7 0/8] Add Axiado SoC AX3000 and EVK board
Thread-Index: AQHdEpmPDmMn8g/k5ECk9T61i6k3z7aQgJ7X
Date: Thu, 6 Aug 2026 03:24:11 +0000
Message-ID: <SJ0PR18MB4479A9CE51EC098BCFDE8F14D3D22@SJ0PR18MB4479.namprd18.prod.outlook.com>
References: <20260713073033.3883619-1-kchiu@axiado.com>
In-Reply-To: <20260713073033.3883619-1-kchiu@axiado.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB4479:EE_|LV8PR18MB5558:EE_
x-ms-office365-filtering-correlation-id: 4c176140-0efd-49f9-00b4-08def36a2efc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|56012099006|10067099003|3023799007|8096899003|22082099003|18002099003|13003099007|38070700021;
x-microsoft-antispam-message-info: OSiIy8lOQZb8Kke+GrbUeVDdSQoPMScb7dxNp1Zh9sBJGwGV3fj/9ddR+F0lt//ngRMZHK963R2Lr12iVa8aPqtj1fK60dzII9zR7ZmYOiTl5bSQvNlJTYDRVsPM03OF9syB+O1dzU91UPxc8K9RBfOVXZoDEkt3a2z7ZkjXXH1XhZLnzCi1Xywue9hVcaW2nfRyk93komadCv6p7j1YKwMhzJToi2OY6HhKYn2qLT5zbp4QdmU4NUquoSDhwvGGQsb/UCxEYTsqXDYCnAJXVLSPueO62ixB3X0APpf+ybzR+p84/1yk4RHhTue1luLe80UHBppERkac6+MhQ4Qxggwgp7BSZHSt7EvlsmhnygeyLZ3B8YPC4jZvH3dgWUuw3cIK5o1mGzoJT4BFx8urnCsKKmXeFjchVKKDshwmeQzbTGYXXJXDZmrOYE6y0NMWqUoAnFYyzdojy+Mu8ReCAORJrUJb89SUv5tyEBlpdCY304qEU7P2/Mqcnt6oiZziofgwY6mOiJHLsv6QxGp43hCHfwdgxMAWyHREiofqHP81UiuaBwMG1T68kbpyu7VeSPDOB9dDmOKAddAzj/D882hjX8FcUSgL9TGzzrWK0JXG+kCvqjhUdGkUpN85upGTBPKM8ugNdDM59x1EYjbqHFQhWI/ZrBELkSv99ty8SLrmBCtjRzWDURLc9ueWpg/Bf59VemjlrXxK9xSlpX52M4c3YGf3vIRyx2wSEoyr79g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(10067099003)(3023799007)(8096899003)(22082099003)(18002099003)(13003099007)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?SXlIVUh2N2Nma0J2b3puNmdmelYzTExuZEtTVVhlWmh4NlNPSElsQWVv?=
 =?iso-2022-jp?B?UWQwN3lENkhzQVNSYjBjYWFQNnp0Q29Ibi8yZVF0VThDZzk4QmxxWW8w?=
 =?iso-2022-jp?B?VWR1UWFLemdXRm9VcjZmaTJYT2c1MVJyR3FDZnVDTGZ1OW5zOUFwa3h4?=
 =?iso-2022-jp?B?eXNXcElZcTNZNmNsV2x0eFphb1BkL0M3T2JMeWZHSjhIbHJqSGNSNW9J?=
 =?iso-2022-jp?B?OHlOTmRvSUFxY2dDM1JVUUplekI4Y29XWmtHY05qYVF2UGQ4ZnRBQm40?=
 =?iso-2022-jp?B?OGV1UmdiK0pOM3ljNzNzeEN6YTVMZ2NoRWd3ZDAvRWQ4ck5iRXVkc1cr?=
 =?iso-2022-jp?B?eEoxRXdDSkM4QWVSK3hCTXpzNmdIdDhZcnFEWTVud1pxcVVNcys5M1o3?=
 =?iso-2022-jp?B?dkVSWDFlT0wrNzBoVmUwL0N5T2xRMThUbjIzeTF1QWFPRUpJeWZwTlc3?=
 =?iso-2022-jp?B?eVVRbTBiL0ZRVk95RTJ6bnRHVTRDTW04YjJSZklvOG8vUm1ncytEampL?=
 =?iso-2022-jp?B?a09hc0wvUW42UWdGYUpSaUJsMFhqdnZZaVk1Ny9iWVZBMW5MSERsc2hI?=
 =?iso-2022-jp?B?QVRhU2VvVjJ1M0VZNHNOaCtIRms2d0pmczBvTUljUWdCcmdKaW8zbTdU?=
 =?iso-2022-jp?B?bG02RCtjR01YMEtISDJnZG91ZjdGU28vcmE5MTF6SlQ4Z2cwdHBodGk3?=
 =?iso-2022-jp?B?YUxqVjFiOWpLVUVWY1UzdUZlYXd0bmhnb0lnSGlleVJkd0dIUUZGV2Yw?=
 =?iso-2022-jp?B?cUpUQm1Cb3BkcTdyMWR5OFpkN2ErYkNGOW9IL0xvS0I4Z2tvQkYwNWRo?=
 =?iso-2022-jp?B?RUt6cE1oQk5LUFRZUk00NDREb3pla0JCQTM5eUtmZC9nYWcrdjFBcEhW?=
 =?iso-2022-jp?B?dExPcEpWZzVZY20zemNZZnU2b0xIRWVmcHFJNnM2L1VRMER0emdFYXNh?=
 =?iso-2022-jp?B?L0FNbmVHMUE2aUc2OWZoS0lIdTZTV3JnVjZtdDZqdU9yYm5aYy9IcXVv?=
 =?iso-2022-jp?B?VTlUcFVXVHVrOEtobXdkZWRRekNjaitvZHpnb2FvUEtUbWRQK1p4Lyto?=
 =?iso-2022-jp?B?TitGR293enBycWdTMlAvU3ZPdkJKeHVYMHQ4cXJORUtNREFVeDc0a29U?=
 =?iso-2022-jp?B?VmVsZ3NUZjJ1L294aFgvZ3hweis0WHo2VzdnMVg4NnU0YkE1eEd4dDdS?=
 =?iso-2022-jp?B?UEZ6NjFIanRvS0svUVI1cm1yeFErNGN5TFdFMmRGV1JlcFQrbEJpcHRO?=
 =?iso-2022-jp?B?VWt3Z0FxUHVnRVB3RkloT1ZEUmkvbFdndU1zTnljZzI4bGNvYXNCK3Fl?=
 =?iso-2022-jp?B?SFJJemRlQWVTYVBtZFhxclV1N2JhMkhlRUQ3UTliOHRxaG8vMjF3WlQ0?=
 =?iso-2022-jp?B?Qm92dG9FUGI3U1laS0ZHUUhGRjd6bWJSbi9mY0xXTjN2OWUzOXczemh2?=
 =?iso-2022-jp?B?WXRMWFVwVlRPMTgyMkVGT3FpSFdLVG8vRnZnQk1HNzZ3V0tvZjNTS2th?=
 =?iso-2022-jp?B?U1hSTFVVaFdzU1dkSHVYeDQ5aWZ4S1RHT1RPdFVrMFN3OVcyR3ROejF1?=
 =?iso-2022-jp?B?c3pQdjM0c1ArZEdGUW1HVGM3ZUZVSjVnbGFDOHZBY1lzK3Q0dUtyTGdT?=
 =?iso-2022-jp?B?aDhpMU04NHdNT3pXbVplQTQ1SXhHR3o0WFZRajB5SVFYYzd0ODQwWTBp?=
 =?iso-2022-jp?B?UlBjTno4OWFNSmtuampza25mN0lDTkQwQzdPTGhQTHMyNkFoNVJzcUR6?=
 =?iso-2022-jp?B?TG9jTTB5eWRwNmNWczZTcHIxZ1B1eU1jbEEzU0JkU0Z0cEZTN3dsd1RQ?=
 =?iso-2022-jp?B?R0g0NFVOOXlubzFXY3YydWZTbHVpSWhxZ2dGSTRFQXRHRURYU1RWRUNK?=
 =?iso-2022-jp?B?dEhDWjI4TXdGQUxyMjZTSDczY0ROUDNoeko1VENCcnZpK1RzTDRxM09N?=
 =?iso-2022-jp?B?a1Z6TWtmMFlHRVZYbGc0WnQ2emlGdWpFOXNESWVOdy8ralVLRFczbllv?=
 =?iso-2022-jp?B?ZEY2WE91R1dHUklXR2tydzRYUEdvSmxPa3BJMGw3RnRiM0dhcmJoRitx?=
 =?iso-2022-jp?B?dy9oODc0dnJmUitZTFFucTA1ZUlQcVBvcHRtZ2pweHdPdURYczJvRERn?=
 =?iso-2022-jp?B?TExWUmRqVE1xNVlWbFMvVmlHZTRUQVdDZFlLTFNwSzZKS2VJbW9oLzNT?=
 =?iso-2022-jp?B?MU5kWWVSYjY1SHA4a0liVHlLMTdPRjVOT0tuREtGRzJOQVluZTVLWkJs?=
 =?iso-2022-jp?B?MTFtc1FYWEo2K2hqb2w1TUVYdkdtdzJZajQ5ak5SN3BpWU5YZHYvem9P?=
 =?iso-2022-jp?B?bk92Vno4dXBjdjlQU3FuTnVpN0ZtMklLZlZSWmJGZTVTNUk1M1ZPakgr?=
 =?iso-2022-jp?B?bUpITDFDdkhVNkVKMDRDV2JQL1dSWUJ3VlFEQlc0Z3M0L0M4bW1aWGVB?=
 =?iso-2022-jp?B?TXhoWnJpRXlrMWlkcERHeGw0UzlSS0VOS3hpck0xK2NqNDJNM0w5d09j?=
 =?iso-2022-jp?B?V3ZZRzdy?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR18MB4479A9CE51EC098BCFDE8F14D3D22SJ0PR18MB4479namp_"
MIME-Version: 1.0
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c176140-0efd-49f9-00b4-08def36a2efc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 03:24:11.3263 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 934NrvCV0Jw7JSY7i/NqUQFnk/aJXslz0XQA4Qn98FoYu9dQbSDXILJ+68zjQh5veLGgu0jzWhSiD6JaYbjtEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5558
Received-SPF: pass client-ip=52.101.61.135; envelope-from=kchiu@axiado.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: 35
X-Spam_score: 3.5
X-Spam_bar: +++
X-Spam_report: (3.5 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, MIME_CHARSET_FARAWAY=2.45, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

--_000_SJ0PR18MB4479A9CE51EC098BCFDE8F14D3D22SJ0PR18MB4479namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi reviewers

This is a reminder ping
________________________________
=1B$B4s7o<T=1B(B: Kuan-Jui Chiu <kchiu@axiado.com>
=1B$B4s7oF|4|=1B(B: 2026=1B$BG/=1B(B7=1B$B7n=1B(B13=1B$BF|=1B(B =1B$B2<8a=
=1B(B 03:30
=1B$BZ@7o<T=1B(B: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; peter.mayd=
ell@linaro.org <peter.maydell@linaro.org>; philmd@oss.qualcomm.com <philmd@=
oss.qualcomm.com>
=1B$BI{K\=1B(B: Kuan-Jui Chiu <kchiu@axiado.com>
=1B$B<g;]=1B(B: [PATCH v7 0/8] Add Axiado SoC AX3000 and EVK board

This patchset introduces Axiado SoC AX3000 and a EVK SCM3003 for emulation
The model for Axiado SoC AX3000 supports
  4 Cortex-A53 CPUs
  Arm Generic Interrupt Controller v3
  4 Cadence UARTs
  1 SDHCI controller with PHY
  8 Cadence GPIOs

Refer Axiado website for more product information
https://axiado.com/products/

Test plan:
1. Verified the machine "axiado-scm3003" with following command

qemu-system-aarch64 \
    -m 4G \
    -machine axiado-scm3003 \
    -device loader,file=3Du-boot.bin,addr=3D0x3C000000,cpu-num=3D0 \
    -nographic \
    -serial null \
    -serial null \
    -serial null \
    -serial mon:stdio \
    -drive if=3Dsd,file=3Dobmc-phosphor-image-evk-axiado-qemu.wic,format=3D=
raw

2. Run QEMU test suite
make check
Ok:                326
Fail:              0
Skipped:           20

make check-functional
Ok:                26
Fail:              0
Skipped:           8

Changes in v7:
  1. Create SD device only if -drive argument is present

Changes in v6:
  1. Add qemu_log_mask(LOG_UNIMP) into axiado_clk and axiado_sdhci for
     unimplemented registers
  2. Revise header of axiado_sdhci
  3. Add "const" to temporary data structures

Changes in v5:
  1. Include Reviewed-by tag in reviewed patches
  2. Add arm_load_kernel() in ax3000-boards
  3. Add axiado_clk to support AXIADO_CLK

Changes in v4:
  1. Remove ERRP_GUARD from axiado_sdhci
  2. Optimize ISR update function of cadence gpio with logical operation

Changes in v3:
  1. Add a new patch for Axiado SD host controller
  2. Fill in valid/impl parameters of MemoryRegionOps in
     ax3000-soc/cadence_gpio/axiado_sdhci
  3. Follow C99 standard to declare variable in for-loop
  4. Remove comment "TBD" from empty function
  5. Define marco for bit definition in axiado_sdhci
  6. Move object_initialize_child() to instance_init() from realize() in
     axiado_sdhci
  7. Remove callback of get_default_cpu_type() from ax3000-soc and set
     type of CPU to A53
  8. Update the command to run "axiado-scm3003" in QEMU

Changes in v2:
  1. Move axiado-* to ax3000-* in hw/arm and include/hw/arm
  2. Add axiado_sdhci to support AXIADO_SDHCI
  3. Move implementation for eMMC PHY device to axiado_sdhci
  4. Use UNIMP to create dummy device "timerctrl"
  5. Add cadence_gpio to support CADENCE_GPIO
  6. Enable Cadence GPIO controllers on AX3000 SoC

Kuan-Jui Chiu (8):
  hw/arm: Add Axiado SoC AX3000
  hw/misc: Add AX3000 clock control
  hw/arm: ax3000-soc: Enable Ax3000 clock control
  hw/sd: Add Axiado SD host controller with eMMC PHY
  hw/arm: ax3000-soc: Enable Axiado SD host controller
  hw/arm: Add Axiado EVK SCM3003
  hw/gpio: Add Cadence GPIO controller
  hw/arm: ax3000-soc: Enable Cadence GPIO controllers

 MAINTAINERS                    |   9 +
 hw/arm/Kconfig                 |  15 ++
 hw/arm/ax3000-boards.c         |  56 +++++++
 hw/arm/ax3000-evk.c            |  27 +++
 hw/arm/ax3000-soc.c            | 242 +++++++++++++++++++++++++++
 hw/arm/meson.build             |   6 +
 hw/gpio/Kconfig                |   3 +
 hw/gpio/cadence_gpio.c         | 292 +++++++++++++++++++++++++++++++++
 hw/gpio/meson.build            |   1 +
 hw/gpio/trace-events           |   5 +
 hw/misc/Kconfig                |   3 +
 hw/misc/axiado_clk.c           |  77 +++++++++
 hw/misc/meson.build            |   3 +
 hw/sd/Kconfig                  |   4 +
 hw/sd/axiado_sdhci.c           | 117 +++++++++++++
 hw/sd/meson.build              |   1 +
 include/hw/arm/ax3000-boards.h |  28 ++++
 include/hw/arm/ax3000-soc.h    |  98 +++++++++++
 include/hw/gpio/cadence_gpio.h |  55 +++++++
 include/hw/misc/axiado_clk.h   |  26 +++
 include/hw/sd/axiado_sdhci.h   |  21 +++
 21 files changed, 1089 insertions(+)
 create mode 100644 hw/arm/ax3000-boards.c
 create mode 100644 hw/arm/ax3000-evk.c
 create mode 100644 hw/arm/ax3000-soc.c
 create mode 100644 hw/gpio/cadence_gpio.c
 create mode 100644 hw/misc/axiado_clk.c
 create mode 100644 hw/sd/axiado_sdhci.c
 create mode 100644 include/hw/arm/ax3000-boards.h
 create mode 100644 include/hw/arm/ax3000-soc.h
 create mode 100644 include/hw/gpio/cadence_gpio.h
 create mode 100644 include/hw/misc/axiado_clk.h
 create mode 100644 include/hw/sd/axiado_sdhci.h

--
2.34.1


--_000_SJ0PR18MB4479A9CE51EC098BCFDE8F14D3D22SJ0PR18MB4479namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi reviewers</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
This is a reminder ping</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=1B$B4s7o<T=1B(B:</b> Kuan-Jui =
Chiu &lt;kchiu@axiado.com&gt;<br>
<b>=1B$B4s7oF|4|=1B(B:</b> 2026=1B$BG/=1B(B7=1B$B7n=1B(B13=1B$BF|=1B(B =1B$=
B2<8a=1B(B 03:30<br>
<b>=1B$BZ@7o<T=1B(B:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt=
;; peter.maydell@linaro.org &lt;peter.maydell@linaro.org&gt;; philmd@oss.qu=
alcomm.com &lt;philmd@oss.qualcomm.com&gt;<br>
<b>=1B$BI{K\=1B(B:</b> Kuan-Jui Chiu &lt;kchiu@axiado.com&gt;<br>
<b>=1B$B<g;]=1B(B:</b> [PATCH v7 0/8] Add Axiado SoC AX3000 and EVK board</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patchset introduces Axiado SoC AX3000 and a E=
VK SCM3003 for emulation<br>
The model for Axiado SoC AX3000 supports<br>
&nbsp; 4 Cortex-A53 CPUs<br>
&nbsp; Arm Generic Interrupt Controller v3<br>
&nbsp; 4 Cadence UARTs<br>
&nbsp; 1 SDHCI controller with PHY<br>
&nbsp; 8 Cadence GPIOs<br>
<br>
Refer Axiado website for more product information<br>
<a href=3D"https://axiado.com/products/">https://axiado.com/products/</a><b=
r>
<br>
Test plan:<br>
1. Verified the machine &quot;axiado-scm3003&quot; with following command<b=
r>
<br>
qemu-system-aarch64 \<br>
&nbsp;&nbsp;&nbsp; -m 4G \<br>
&nbsp;&nbsp;&nbsp; -machine axiado-scm3003 \<br>
&nbsp;&nbsp;&nbsp; -device loader,file=3Du-boot.bin,addr=3D0x3C000000,cpu-n=
um=3D0 \<br>
&nbsp;&nbsp;&nbsp; -nographic \<br>
&nbsp;&nbsp;&nbsp; -serial null \<br>
&nbsp;&nbsp;&nbsp; -serial null \<br>
&nbsp;&nbsp;&nbsp; -serial null \<br>
&nbsp;&nbsp;&nbsp; -serial mon:stdio \<br>
&nbsp;&nbsp;&nbsp; -drive if=3Dsd,file=3Dobmc-phosphor-image-evk-axiado-qem=
u.wic,format=3Draw<br>
<br>
2. Run QEMU test suite<br>
make check<br>
Ok:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 326<br>
Fail:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 0<br>
Skipped:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 20<br>
<br>
make check-functional<br>
Ok:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 26<br>
Fail:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 0<br>
Skipped:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8<br>
<br>
Changes in v7:<br>
&nbsp; 1. Create SD device only if -drive argument is present<br>
<br>
Changes in v6:<br>
&nbsp; 1. Add qemu_log_mask(LOG_UNIMP) into axiado_clk and axiado_sdhci for=
<br>
&nbsp;&nbsp;&nbsp;&nbsp; unimplemented registers<br>
&nbsp; 2. Revise header of axiado_sdhci<br>
&nbsp; 3. Add &quot;const&quot; to temporary data structures<br>
<br>
Changes in v5:<br>
&nbsp; 1. Include Reviewed-by tag in reviewed patches<br>
&nbsp; 2. Add arm_load_kernel() in ax3000-boards<br>
&nbsp; 3. Add axiado_clk to support AXIADO_CLK<br>
<br>
Changes in v4:<br>
&nbsp; 1. Remove ERRP_GUARD from axiado_sdhci<br>
&nbsp; 2. Optimize ISR update function of cadence gpio with logical operati=
on<br>
<br>
Changes in v3:<br>
&nbsp; 1. Add a new patch for Axiado SD host controller<br>
&nbsp; 2. Fill in valid/impl parameters of MemoryRegionOps in<br>
&nbsp;&nbsp;&nbsp;&nbsp; ax3000-soc/cadence_gpio/axiado_sdhci<br>
&nbsp; 3. Follow C99 standard to declare variable in for-loop<br>
&nbsp; 4. Remove comment &quot;TBD&quot; from empty function<br>
&nbsp; 5. Define marco for bit definition in axiado_sdhci<br>
&nbsp; 6. Move object_initialize_child() to instance_init() from realize() =
in<br>
&nbsp;&nbsp;&nbsp;&nbsp; axiado_sdhci<br>
&nbsp; 7. Remove callback of get_default_cpu_type() from ax3000-soc and set=
<br>
&nbsp;&nbsp;&nbsp;&nbsp; type of CPU to A53<br>
&nbsp; 8. Update the command to run &quot;axiado-scm3003&quot; in QEMU<br>
<br>
Changes in v2:<br>
&nbsp; 1. Move axiado-* to ax3000-* in hw/arm and include/hw/arm<br>
&nbsp; 2. Add axiado_sdhci to support AXIADO_SDHCI<br>
&nbsp; 3. Move implementation for eMMC PHY device to axiado_sdhci<br>
&nbsp; 4. Use UNIMP to create dummy device &quot;timerctrl&quot;<br>
&nbsp; 5. Add cadence_gpio to support CADENCE_GPIO<br>
&nbsp; 6. Enable Cadence GPIO controllers on AX3000 SoC<br>
<br>
Kuan-Jui Chiu (8):<br>
&nbsp; hw/arm: Add Axiado SoC AX3000<br>
&nbsp; hw/misc: Add AX3000 clock control<br>
&nbsp; hw/arm: ax3000-soc: Enable Ax3000 clock control<br>
&nbsp; hw/sd: Add Axiado SD host controller with eMMC PHY<br>
&nbsp; hw/arm: ax3000-soc: Enable Axiado SD host controller<br>
&nbsp; hw/arm: Add Axiado EVK SCM3003<br>
&nbsp; hw/gpio: Add Cadence GPIO controller<br>
&nbsp; hw/arm: ax3000-soc: Enable Cadence GPIO controllers<br>
<br>
&nbsp;MAINTAINERS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 9 +<=
br>
&nbsp;hw/arm/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 15 ++<br>
&nbsp;hw/arm/ax3000-boards.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 56 +++++++<br>
&nbsp;hw/arm/ax3000-evk.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp; 27 +++<br>
&nbsp;hw/arm/ax3000-soc.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 242 +++++++++++++++++++++++++++<br>
&nbsp;hw/arm/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 6 +<br>
&nbsp;hw/gpio/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +<br>
&nbsp;hw/gpio/cadence_gpio.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; | 292 +++++++++++++++++++++++++++++++++<br>
&nbsp;hw/gpio/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +<br>
&nbsp;hw/gpio/trace-events&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 5 +<br>
&nbsp;hw/misc/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +<br>
&nbsp;hw/misc/axiado_clk.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 77 +++++++++<br>
&nbsp;hw/misc/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +<br>
&nbsp;hw/sd/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 +<br>
&nbsp;hw/sd/axiado_sdhci.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 117 +++++++++++++<br>
&nbsp;hw/sd/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +<br>
&nbsp;include/hw/arm/ax3000-boards.h |&nbsp; 28 ++++<br>
&nbsp;include/hw/arm/ax3000-soc.h&nbsp;&nbsp;&nbsp; |&nbsp; 98 +++++++++++<=
br>
&nbsp;include/hw/gpio/cadence_gpio.h |&nbsp; 55 +++++++<br>
&nbsp;include/hw/misc/axiado_clk.h&nbsp;&nbsp; |&nbsp; 26 +++<br>
&nbsp;include/hw/sd/axiado_sdhci.h&nbsp;&nbsp; |&nbsp; 21 +++<br>
&nbsp;21 files changed, 1089 insertions(+)<br>
&nbsp;create mode 100644 hw/arm/ax3000-boards.c<br>
&nbsp;create mode 100644 hw/arm/ax3000-evk.c<br>
&nbsp;create mode 100644 hw/arm/ax3000-soc.c<br>
&nbsp;create mode 100644 hw/gpio/cadence_gpio.c<br>
&nbsp;create mode 100644 hw/misc/axiado_clk.c<br>
&nbsp;create mode 100644 hw/sd/axiado_sdhci.c<br>
&nbsp;create mode 100644 include/hw/arm/ax3000-boards.h<br>
&nbsp;create mode 100644 include/hw/arm/ax3000-soc.h<br>
&nbsp;create mode 100644 include/hw/gpio/cadence_gpio.h<br>
&nbsp;create mode 100644 include/hw/misc/axiado_clk.h<br>
&nbsp;create mode 100644 include/hw/sd/axiado_sdhci.h<br>
<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ0PR18MB4479A9CE51EC098BCFDE8F14D3D22SJ0PR18MB4479namp_--

