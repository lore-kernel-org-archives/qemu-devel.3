Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD093C27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 12:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCeqL-00071i-1x; Thu, 30 May 2024 08:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sCeqJ-0006zN-II
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:25:15 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sCeqB-0006BP-BU
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717071907; x=1748607907;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=IlN3tIaCmeHp1OLg27eH0h46h/eGp9wjTvAZbRgPYyU=;
 b=oSptrorolwoGgTek8BKuvxdfc0IKJs0X0r+cKi4/LPBVHmqobDEOGu+c
 IvzgM27U68P+ayiBAJ83qFdwz2dweohdl8wmG6lJmubXTu0GM5kxUCsqU
 NoTkIZL9QEPWwOXnUCSf2gkqS6uHP+pnsemP6FAlFmv2IlUJ5PYcORqvs
 b72+XY3QMUFS2YDu5fHWkH+sqMdpAY/AAsGk8FKGkyR/LQP3Wc+WJTt+E
 hTJi8NI+Sey37wm+PLJuFKHmXabbS4ujOIueko0htvIAxBRPIr8uurpW7
 iMnV/3Yay+ttHkhLPZdp1Faovo/Qf14gcWp48nE/T7pKG9eW5ag7ePEwK w==;
X-IronPort-AV: E=Sophos;i="6.08,201,1712613600"; d="scan'208";a="13582414"
X-MGA-submission: =?us-ascii?q?MDGZrnJxGg9FrzMmr/4ToYpPJ800IPLC9OwFGM?=
 =?us-ascii?q?5b5D2xkM/tDW+tFDbdHbBwIZOaXrkla6g3UuN84/y3UkLwR1EBoVHxVP?=
 =?us-ascii?q?xtSIhdxQd3SKsxyesNqyJeLD1aj4lAO+3Z/R/+jWolV6/P81XEr5cL+D?=
 =?us-ascii?q?zwKmKgSlZfRYEdibkJegKyow=3D=3D?=
Received: from mail-he1eur01lp2051.outbound.protection.outlook.com (HELO
 EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.51])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2024 14:25:02 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k97Fdj1nldz6lM+86aln4rgLSWK2boOUtVVBwl9dm+JJxAJOTGfvvgxKaOZSBFgFrSjUBGGno+D7MHvWWqOD+1y+QhB+Pgryarq+1bQg1zyf5sSmOgl1jF/632ipoRbZrSuaavaaOZBE2e5pTPCUJ0SO62fXlt2olLmsgHwopDxzQqxBxzXPU6Dmnp+irELYie+Us6U2av1VD9MMg7K8s475v4pHf1nwbOsgf4oOvjRL0V0W3k24Rh035WwNKsqTMIyKd/IYNlbG6SRmqYys9I0FJRA0h8WVXNUdTGQ6cClh1o5ybneatAejd/2xr0f4fNYTT59CEJjo/vD88be8dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlN3tIaCmeHp1OLg27eH0h46h/eGp9wjTvAZbRgPYyU=;
 b=bF7+4g2jjcHfbuOdm42/K92dJrwf285oKDUzjnP6L3XwzEllvYEKNbMiy/kBKDib0fdQY9Yytq/kP+aDPDu66d73vuFt1GRPCVHLs/YWqtamkeVLsWHW+KPWKFNzKfV+sp/2X1gpcXmSNfZ7SdD2kbV7OxkKSJ9Q9NgNwZWcWoEzYhjC2nCvmTEks0VRimVJDqB4WNOJ73RqBBt0SupVtvNc23yQClSZYSDYzwrPsGO/KofpL79swd9kQ+y08+lGsfD4B+R8e/Yb/rFxOsK/n09cpJU+EjGAo1GpTjJQjqzeU07XFkwHo+nzRBbNz2KqODTpMVglx1r9hiTU1Igatw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB8069.eurprd07.prod.outlook.com (2603:10a6:20b:358::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 12:25:01 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 12:25:01 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v1 3/8] pcie: add a way to get the outstanding page request
 allocation (pri) from the config space.
Thread-Topic: [PATCH v1 3/8] pcie: add a way to get the outstanding page
 request allocation (pri) from the config space.
Thread-Index: AQHasoxkx17E2CeSRk6sKhg4F2Rw/Q==
Date: Thu, 30 May 2024 12:25:01 +0000
Message-ID: <20240530122439.42888-4-clement.mathieu--drif@eviden.com>
References: <20240530122439.42888-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240530122439.42888-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB8069:EE_
x-ms-office365-filtering-correlation-id: 61f153da-5b18-4385-ef44-08dc80a38738
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VWZiVE92a1VsQ21JUEFHQzgzZ0s2dDlEdFA5RlN4d25xc25QbGNESGxZVXU4?=
 =?utf-8?B?SUNlN2U0RXg5Z0JGZDZrNGtWUkJOYU55QVFGV1pRdGV6V24xdkF0UlFoOHVM?=
 =?utf-8?B?L1hOWlhmbnBmclp2ZWtVTFlPWWtUYzhPbVVacWsvRFd0YkoxSlBORncra3R4?=
 =?utf-8?B?eXpPV2ZDQmpYaWRtZVRWTlNZdWRWdzhtN0VkWHZHZi9rd0dMcnBDMldlN3l3?=
 =?utf-8?B?eFJxanhEc1dMWGEzdmdnbGk3U01ybTZMM3hjMlNEQzNZZ2RLLy9OOXpsSVBJ?=
 =?utf-8?B?c3Q1NElNNTRqS0N5L0hmSHRKQ2x4NDZoSy9DMWdzOUpicE9wYU5VbG94M2c5?=
 =?utf-8?B?elRrODRkZnBoMVRLdXJOMG1nNHovdmM1aE1LSkZDOVZPVlptVnBtczZPWFMy?=
 =?utf-8?B?TFdPejdFb0FCaFh4Ykd5T0dQRXRiR0VIRnphVXRlWGN5MEd1OFFXeWd0MlR1?=
 =?utf-8?B?ZmxQOUZwN2hucjg2OC96SVJOUWNwTGhMV1dkb0JSYmNQQmc0cFFwYysrNGZj?=
 =?utf-8?B?YW1xQVNySHFEaENXOWxJZ2ZTN0VtYXF6bEFYSGZVenRGZU9QOTlnVUhmMkU1?=
 =?utf-8?B?YVBVbzZVdm1hMXQzT01ZNzRHdVVJVVN5YkpGekdacGQrajAvR2VsNUZMeWI2?=
 =?utf-8?B?QWV2WjI1V29VRGV5dkg3NDZrTG1Wa1BoM3lnWUgxcTMzbFF6SXpaMkVyZDBO?=
 =?utf-8?B?STd0WGhuaHM2ZHdqTk1MNFRPNDJLNlh4cVYrWE5PZGZaNGJ0VUl3YWQrOTNx?=
 =?utf-8?B?NnBYaEVZVzJwMkxiRUlkTFVsTWhkLzNBMzZVNXFFamt0ak9ESnpXUXpQRjVZ?=
 =?utf-8?B?ZDJWV0JiSTQrdkk3U2xxVk9Wdlo4UGxtaG1ncTBlaTh1V0lQK2hpMWhCaUZV?=
 =?utf-8?B?Umx0V1ZLazg1ejhzd0tmT1IwcDVlamIyeGoyeEVubEFzcFhFa2ovMTRBSko4?=
 =?utf-8?B?eXlSS3FNc2U3QkdmN3VNOTI1OU53Ty9ZUGE3UHNNQ3krR0NwbEdnU0FCajR2?=
 =?utf-8?B?a25WVi9LMmlZMFJVckQrOGxVQ3VlVWpJRCt6ZjN2QkZRSERXd1RvOFk1TEw5?=
 =?utf-8?B?UVRJakVMR3ZmakFuajVXRlhCQ2hSZVpmNzJvUUN2NktqUkdiN091VWxycFEw?=
 =?utf-8?B?VmM5bjNQSUIySFRKNUQ0YmR2ckNiMDNZK3Y4YS9ia2UwWHFMN2Uxemg3RVda?=
 =?utf-8?B?SEdvNm1RMjF6S1dpSVJMSWdXSXU3ai9Fei9rZ2tEWVI0UHJORUhqN2JOOThF?=
 =?utf-8?B?WFFlOEk1UWdFV0ptZ0pPKy9wb1RvK3Frc2ErZkdtNFZGVHZGS1BURDJuNEJV?=
 =?utf-8?B?Qnk3MXB3M2l0RDVUVTlza3BPT1UrREh3Mm1Ka0t3Ymc3QTc3NDVMYWhtV1pu?=
 =?utf-8?B?cXVYNDVBZmEwNDd4VDU4NDdDZEprVGNyMnNQUW9uRDZVb3JGWkkwUjhmK1c0?=
 =?utf-8?B?OXBSTHh6WndGVnNVbXZjbFE3R1k2MDk3cGRGYVQ1blJuUzU1NVJnWERreUh5?=
 =?utf-8?B?UCtjaGhkUVJVM1JqSFBNczN3WUVpTytVWUREM2lxTXZlUmdEckRKNERnMm5U?=
 =?utf-8?B?NVo4SnFobjIzcWkrb05iZjF1dkMrMXFqZGJFRU03SCt2SW5UNlhCZTI2azlG?=
 =?utf-8?B?bE5ueUd2TFBoSjc4QUlURmFVbHFOZDJQb1dHbjNWZWZzUlRTYlplTWE5SGJr?=
 =?utf-8?B?YU5iV2lZQURTcUltcExWUTlzSUYrYUxrSUFQUmo3U1EvTE1QeG1PQ1FkTTdi?=
 =?utf-8?B?eFZWdS9RYzBmdlUwR0trZEp2Zjk2V1ZPb3REemZKU0tSWktIL2tiZ2NCTWh6?=
 =?utf-8?B?N2xxcVFpMnltdFpTUTdDQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yi9wMHl0TkZubmJPdFhQMndMTFRQVkMwOEhvU1BOb2pGaHpwSGJpbURiMkNO?=
 =?utf-8?B?cDJiM0NHQm9uRVZpUHhUc1lBMzk0aVB2d0V0WCsyelc0aGJaaVRJb1FSQTE2?=
 =?utf-8?B?ZE9TZVJZY2Vla3JPM0pNYUp1TCtkVEcwMlM0TnRlNk90aTM2Mmw4NytSVnk4?=
 =?utf-8?B?cUJmKzJjZ1ROaktpZXpNeFluY2dUdytRcFN5ZHdOQ2M3OSt3T3U2eWVwZ2lw?=
 =?utf-8?B?K1hXYldyOHFpc3B0OXNWaGZDUGpXbWJaS1UxRzRwZ0dlK2ZjaWtKbC9zVndX?=
 =?utf-8?B?WmczWVQ4WTluRVNsN2FKODNDSUE2a0RQNlRDdXZPeVY1cnliNWxWOXhmZlZB?=
 =?utf-8?B?MDc1V0RXckYvZk0xMmRLdXRqSlNWdHcrNjkrZjF6NFhwcHdjQWVMd2hRVU5R?=
 =?utf-8?B?SzNsU2drdjBrVHpjUzFtVEpXZ3VYRlFmaHVEWmxaeW9mdTJ4VS91NnFpREVK?=
 =?utf-8?B?L3Q0VkhQL3RFaE9yV25OaGExaUJINHNteXlEMndPZ2Z2RjU0bS81QjJSYzcy?=
 =?utf-8?B?ajBhcFlBMmlhMUNBSW95RHNuM0ZZNFYybkJqMmpBVWw0V2F4TjBsSnRvUnFw?=
 =?utf-8?B?Wk5vT0hRcUh5MmVUaldsM0hHNFZWNVNoU3NFUU91a0VvcWFBZ2FaVFpOS29W?=
 =?utf-8?B?dmNpclg4MEp2QUZOZERNdDdUZEFlQzlxcW1CWU5lNmRwQkJZM2VDUHJEck5W?=
 =?utf-8?B?YTBYeUJzUnRLeTdmb1NOUFBVd3N2QmVlcDJwM1dPaUw0Z05IdWRYL2J3QlNt?=
 =?utf-8?B?UGppWHVuRENFVGdRZEZ3Skhxem1zbm5nbWFLSXh3VTVnQjk0TUFsNU8rTkwz?=
 =?utf-8?B?MTh6TThtbGhsc2VJYjBZN0lUa25JWUJSVWIxL2lMYlJYUktJY3VlczJsZjhN?=
 =?utf-8?B?aVhBNVF1dGpPaGhlTzdYY2FhU2FEajk3U0syaW1uSnhSNnpxSUtwNWlDNmd2?=
 =?utf-8?B?YzNwaTlMaE9QaG9qTm1oc1B4aWR4U2xMY2lwTzhLaDFWVnFEaGlsWG5Sdm5t?=
 =?utf-8?B?TXRLZmN0bytrb1cxbi9RSmw5eWNwRGtwVU1QcjNxeWdpTUo4Y1czVzlZT2xZ?=
 =?utf-8?B?SkR2RTBSTFVpQXRKdUpobnB5bi9QUjdhdnd2ZGs3ZnlzRkc5WjR1NUdGUXJ5?=
 =?utf-8?B?dnNxbFcrTjdZYkgrc1lrWkF0TXZraEJ1U29QNGs4Rlp5b21lUDhqb3FZRExa?=
 =?utf-8?B?bXE0NkJSRWozYVdGZUZqSnJSOUdJMkhtQWFCWFFkR3lFYy9iYzZSUnRSUENT?=
 =?utf-8?B?ZFh4S0M0ZEtiZHAzWTdmKzVNRzRGTTJuRHJlQ3NyYWJxNzd1OXFZZEZrWHRr?=
 =?utf-8?B?TlJsQjJ4elErVEpOS2Vwc0F0R0U5T1h4cTkwRDFQbG81azcvWXU1WkVaUTlD?=
 =?utf-8?B?ak5GdllSWERPRDl2Rnc2Ny9ZQmlMeDlVQW1La1VIdlU0ZnFDU1R3N0VKa2tD?=
 =?utf-8?B?Z0p0WWJ5MXdkcGM3bEU1U0xFSmNUejdJakN1SmNFenBRZWNvQStxK2M0dzAz?=
 =?utf-8?B?WFZrVHEwNk9UQjNqRXVoa1VDbFFpYmlQNXF4TE5mQytWdkpaSzA2WGtHOHhK?=
 =?utf-8?B?dS9GOEdoSStxTUg5MjNzM212blJGTVhMWktueGNieHFCTGo3ODVWQTVBM0VU?=
 =?utf-8?B?VkxITW1od3Q4QmdLd2xDeDZ0WWR1eWJqNGpKcjA4ZjJ5TXpuaFpkanlPLzZh?=
 =?utf-8?B?WE9rR3BRQjlEcWZYb1hsc3Y1ZHE3Tm9nM1M1aFRTN2lac0kzTG1TeHArWGtC?=
 =?utf-8?B?VEx0TGcwN1dDbTEycnQ5SkZUeWJmMmEvK1N1SlpuOTJWYVAvZGJ5bk4zdnNV?=
 =?utf-8?B?YkZER2lGVmlvT3VTS1U2Q2JTSmJITFR6b3VkOGNaVFZqd0s1VXRBMVIzZ0t6?=
 =?utf-8?B?ZWpIcnhodllWWko2aXQ3MlFhTlZlUU9CNU80TVduRVpRczFUNERFWFhDNS9U?=
 =?utf-8?B?M1JqS0lKemtScEUvS25PNGNSOUFPVFNPTlpaSWJXRlpGYU5UQ1ozc0szOFVJ?=
 =?utf-8?B?UEZCR1llaldZbWRrcFJlckd3OUFGTmxUVURaTVJLWGFMb2MyemZ6WUNUMURM?=
 =?utf-8?B?V1N4L2JsakZkazY2ZlN3RFhXZWxUSmpramtHZnBuc1dxbzQyZ1pNTzNINGJF?=
 =?utf-8?B?OG43cHVlWHlOazdITXZXc1pyWCtabmpiTVpGSmx2QmNOWEZrU3YrL0oxdTli?=
 =?utf-8?Q?uGKtkzkupWOzHNr94UMP2Bs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <146F358A85B7294D98209D060FF9792C@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f153da-5b18-4385-ef44-08dc80a38738
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 12:25:01.5987 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0tmMSh24gP8rnsG51pEQvtowUUiq4IR4W+ZS6DWNyvLcdM8iAMwiw6iI5X4Lu2F93j1Q/ZwDplW6HdRzHBvZ5NACq9GqQAaKRh10RT5gY7V/HbmDqp2Gky9FmbADJkEL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8069
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9wY2kvcGNpZS5jICAgICAgICAgfCA4ICsrKysrKysr
DQogaW5jbHVkZS9ody9wY2kvcGNpZS5oIHwgMSArDQogMiBmaWxlcyBjaGFuZ2VkLCA5IGluc2Vy
dGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2h3L3BjaS9wY2llLmMgYi9ody9wY2kvcGNpZS5jDQpp
bmRleCAzZmI2NTg4YzMxLi5kMTFiMTFmYzM0IDEwMDY0NA0KLS0tIGEvaHcvcGNpL3BjaWUuYw0K
KysrIGIvaHcvcGNpL3BjaWUuYw0KQEAgLTEyMjcsNiArMTIyNywxNCBAQCB2b2lkIHBjaWVfcHJp
X2luaXQoUENJRGV2aWNlICpkZXYsIHVpbnQxNl90IG9mZnNldCwgdWludDMyX3Qgb3V0c3RhbmRp
bmdfcHJfY2FwLA0KICAgICBkZXYtPmV4cC5wcmlfY2FwID0gb2Zmc2V0Ow0KIH0NCiANCit1aW50
MzJfdCBwY2llX3ByaV9nZXRfcmVxX2FsbG9jKGNvbnN0IFBDSURldmljZSAqZGV2KQ0KK3sNCisg
ICAgaWYgKCFwY2llX3ByaV9lbmFibGVkKGRldikpIHsNCisgICAgICAgIHJldHVybiAwOw0KKyAg
ICB9DQorICAgIHJldHVybiBwY2lfZ2V0X2xvbmcoZGV2LT5jb25maWcgKyBkZXYtPmV4cC5wcmlf
Y2FwICsgUENJX1BSSV9BTExPQ19SRVEpOw0KK30NCisNCiBib29sIHBjaWVfcHJpX2VuYWJsZWQo
Y29uc3QgUENJRGV2aWNlICpkZXYpDQogew0KICAgICBpZiAoIXBjaV9pc19leHByZXNzKGRldikg
fHwgIWRldi0+ZXhwLnByaV9jYXApIHsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3BjaS9wY2ll
LmggYi9pbmNsdWRlL2h3L3BjaS9wY2llLmgNCmluZGV4IGI5NzZmZDczOWEuLjdlYjQ0ODE0OGIg
MTAwNjQ0DQotLS0gYS9pbmNsdWRlL2h3L3BjaS9wY2llLmgNCisrKyBiL2luY2x1ZGUvaHcvcGNp
L3BjaWUuaA0KQEAgLTE1OCw2ICsxNTgsNyBAQCB2b2lkIHBjaWVfcGFzaWRfaW5pdChQQ0lEZXZp
Y2UgKmRldiwgdWludDE2X3Qgb2Zmc2V0LCB1aW50OF90IHBhc2lkX3dpZHRoLA0KIHZvaWQgcGNp
ZV9wcmlfaW5pdChQQ0lEZXZpY2UgKmRldiwgdWludDE2X3Qgb2Zmc2V0LCB1aW50MzJfdCBvdXRz
dGFuZGluZ19wcl9jYXAsDQogICAgICAgICAgICAgICAgICAgIGJvb2wgcHJnX3Jlc3BvbnNlX3Bh
c2lkX3JlcSk7DQogDQordWludDMyX3QgcGNpZV9wcmlfZ2V0X3JlcV9hbGxvYyhjb25zdCBQQ0lE
ZXZpY2UgKmRldik7DQogYm9vbCBwY2llX3ByaV9lbmFibGVkKGNvbnN0IFBDSURldmljZSAqZGV2
KTsNCiBib29sIHBjaWVfcGFzaWRfZW5hYmxlZChjb25zdCBQQ0lEZXZpY2UgKmRldik7DQogYm9v
bCBwY2llX2F0c19lbmFibGVkKGNvbnN0IFBDSURldmljZSAqZGV2KTsNCi0tIA0KMi40NS4xDQo=

