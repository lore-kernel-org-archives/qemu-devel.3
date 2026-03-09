Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30937EFCD93
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 10:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzYG0-0004xo-3S; Mon, 09 Mar 2026 06:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vzYFy-0004uL-KZ; Mon, 09 Mar 2026 06:54:38 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vzYFw-0001Ec-L2; Mon, 09 Mar 2026 06:54:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLc4PToTAT6uUzgK9nIBJ+i8oncn0BLjg1TfIvSJs7bb73mfm4IhhxL+vp4js9QLdfbBU5sZGeHKDTpbVajDvu1RYMWoMNpZNW6e72GQUKNwcHorDVzcBXYdw7icS2UDEqhkuyP4lT9+9X53hyrV/73gLSih+7FcvTPRDrfI8oFcHpXAsjcTep4S6a+gd5B8lBykRqMpbjou5s3CYsPUUAerBTEko7qkRmKB7VrCO+CCOZnnAxKM9Pk4HK9cBYCoJL8y2zIBxiPZAQPupfB8yEG7wIiGV/Ho3/kCIzDECYHLmCnpIwOLKNyDrg5iPddM8zRM2M6tUO008BOSjeW01w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5FbpTpJQ52Ru/RMCJ7YDZ/WBzOz/+oltf3dmVXDGA8=;
 b=tFSBbm7vJPKNPz2L+3JML8VsOrxXj9G2M5fXAzoffb+/kcU8Nlhirunwi+5pQusrZtiJI1baH5ksz/c9WD9zI/t6fLzBtd0hlVNXSo2IbBKJES9XEn3N/qcAY4T5y2p9NhG/fw+BsqpaA0xKCMczDYSUPA80toLJPd2wVcFoNogVz59rQ7UtzCFphJt9V6G31kSXjMtAllmuGxnZJsUUg0BFWNk0j2SE8vCyP7VLgp7J/j+Rph0jWuuZvRRVzohIIJLdUtBSTlP2Hv0kk8HadajApCG0et7J+qjLbbkA0nGbooxr3BICKD6BPTzTGptaXS1CUKVyhw9gaUiO6IaPaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5FbpTpJQ52Ru/RMCJ7YDZ/WBzOz/+oltf3dmVXDGA8=;
 b=YoMzjojRVyH4/8XZuAvr/kqkDq77w+f5pTxYNRH6qgzlUq+sN2wA0t6VKIqJLd71ktCAP8MshCRwrIDKPcUqSsEC+HD+SeQYw+NJLBDHjC8kBbtYMMlNV/qY9Z+I4qr2wqeRPg4o0f3ljwH95tB1N/1ICHrppuco4HpCZ9VOw6cNSNsubrC4CRsn3hSnU3jWwlc/8DU08Ze3/VdznprIwSgM6tqfhS4gw5dKBJI1bsnjEZn2cW+gSDYUxvABL1nmSSyAg8VjJWoCFmtjF0RY9n3Lzj0cmhxkVG/TnJXUP+E6BYQ/Q57BU2bAY3sDyQzXg8zRfbjNFpCtKTeqE00uwA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 10:54:30 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 10:54:30 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>,
 "phrdina@redhat.com" <phrdina@redhat.com>
Subject: RE: [PATCH v3 10/32] hw/arm/tegra241-cmdqv: Probe host Tegra241 CMDQV
 support
Thread-Topic: [PATCH v3 10/32] hw/arm/tegra241-cmdqv: Probe host Tegra241
 CMDQV support
Thread-Index: AQHcpw3/8QIA2uf15keGrnUuF9TECLWmEagAgAAE/oA=
Date: Mon, 9 Mar 2026 10:54:30 +0000
Message-ID: <CH3PR12MB7548C5DE17B70F4C86EBC26EAB79A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-11-skolothumtho@nvidia.com>
 <b3627b0d-5e21-46de-adba-1c9ec84fb602@redhat.com>
In-Reply-To: <b3627b0d-5e21-46de-adba-1c9ec84fb602@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA0PR12MB8862:EE_
x-ms-office365-filtering-correlation-id: 6556263b-d2c5-4cf6-bfe8-08de7dca3dbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: iE3O+AO6t33fePaGjqqIGY5bnjFrY3udD7Q+FmxG8a1IJhAQ+cl+tBnKiXYVVnPvPGa19aF1ccHQCj+DwwVMsg3o1QUladboFTfuh6TRtsMlqsOLIxaGuZQ4RBDTPId4fHWDsOT1Ear7YeCf8K0h5lWTzxOEQUw7lQbOkBJS5d/EvY2azV7GmGYXxAusSuWn7aqhwDpvLPO8loPMgu+BO7/5ZHHRlrwmz/QZEaq/tSP+TAJgWGL099YLwsEZgNOfp3AQ/8+jfKVYrB9ZV3wVBvm+1ncE2fWzwi855K6WbJ0nqDWM7rdA21Mz20tzirpP/AWG23a9p8nLPTLWdoxG9GYuYkn20IS5vh79IIo546RZ2G90uLHRx8GmEZgeKnOB48ESMg7vGXj8QqJ5PXOUZMaSlHIGlyuIFWnoKTRbn/gpo21xywZTEXvpFWYWsQvlHbIw9prvFsFIjh2LFzGPv1ntK4R8sopkXZGy5fPZba7drVQDALBJSl+AElPeEgAJCuIV41dPfxlz2ogdJTEuaIISXFtbmGC6U0oRdXsCUSLhTuKtVJ8u5j5DBAHLz49ZvvbpkjMk4g5dfg1ocvs09LFYgEfksoY5T/oFoFQeul0Gz764JqvQfAFDUqwDtOe6Kvh8od7jORgywItxAbjK7doTXbWZgE0BUwMiKL1Mcdg4/Y2aji+44ddEE8mZhPuPZrTDnT11CaSQ7kXjaEmd6OzLaGOl0fxdMZk/JcD5nP3r10M5KInCFO8qDiDoWMTQK+zj09yLOc4QE4EUXUqDhmNRRsilRvTUdDMtUhlNXjQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjAvTU4wSTlzTEtBRlJ6ajRBMlZWcHBKVGRIQ1QrNFdXWVIvZGdSNmVyNUJr?=
 =?utf-8?B?UlltRTRYWGRJZXdRVlBKNDRZR3dtMVEzV3Y2TWh3b2ZwYkR0Zk0rWmZDY0VE?=
 =?utf-8?B?a1I3ZnRZZTFXNFBYa3o4OUdMOXNEZlJkUmFmdjdpbWk4cjZTZEZLVFY0L3ZD?=
 =?utf-8?B?K1FRNFI3VUYzZjhWVFlqcEZKSG9aMDJJSUZxcEtuaVNUcXRDbVExenQ2dlFL?=
 =?utf-8?B?U2dQcVFHcStoV0h6d2svNG53OEZ1Uzh6ZEduT1U3Q1lVTE9kSElkcDc1azlX?=
 =?utf-8?B?MjBvZzZIRlFVeFpKajBGR0JGZEJoNmhaNjBEeVZhR1FnTng2UHNBRkZ4SkFD?=
 =?utf-8?B?RTZaYks2Q2N3cExSb1VqSExsTGxHOU0xd1RNU2VWR2haVFlGYy9lSmZ3NHVk?=
 =?utf-8?B?aE80Njl1aVNvUkkvdHE2ZUkwZld2amczdURrRkNsR21SWWN3eUdQTnA2bDIv?=
 =?utf-8?B?bjBuUXQ4MXloWWw0dE9OMU5pWktJbFVSR0tvQk1kSUVGUHc4QzVNaVo3MHdp?=
 =?utf-8?B?UG5WWDdtN3ZoOGc3QWEyYXhnWk1EYjdKS2UrUkdvSGhTZ2Q5QTh6aWdBZUV6?=
 =?utf-8?B?SmtLcCtiVUxKOEh0WW0zc1BXbTQzRVdIK1N6WktjWTJlaEkzcVYyamQyLzJ3?=
 =?utf-8?B?T2dkcDF0dGk5RU85VTgzZWtPZFRCTGViaHJwdi8wdDNpdldQMGRQcDZaTHBG?=
 =?utf-8?B?QlZwM1QwRXprNFdCSkxnS0wrV2hpOEVpSHNERERCd3drT1hIeXd6U3NMdnda?=
 =?utf-8?B?MDdIUzIwWEhUV0VsaEZwRUtFaEZ2Q2FDYWZpYjZMajZIWGFUUHI5cE5LZE00?=
 =?utf-8?B?cXVkZDNmdEF0a2t3VGYvYzVLVitXWkJRSGFRRS9uRnA0ZE1taU5IUFk3bHlL?=
 =?utf-8?B?MGY1Z0ZrRVV6a0ltLzlPL2k2YW1GQTRDV1d1WVJRQW03N1BFeVBaL2g3YnF6?=
 =?utf-8?B?MEVhY1RjV1JjUUhTc2J4NXlNUXN5SDE2d2xxbEV6bU1IaE1FOUtEVndxNUhE?=
 =?utf-8?B?Uk9DMlY3MEgzdjQxUmdNWUo2bkRlTENpSEswdmE5WWhGOUNWQ3hHbEljMDFy?=
 =?utf-8?B?WUtoeE5QVktta1JQWnkzSVFIa2VnWUk2em5VNzgvMW9RREc0SjVGV2RBQlJ6?=
 =?utf-8?B?aHliem5mYlIyNmtocTM3T1VGQStwL0x3RXh6bzBIL3BSd0Y4WmcxRVBIa2R6?=
 =?utf-8?B?WjZkTjlweURJZEJhNnBKOEhvUVBuSkJkNjNFWk9leHNRMUkyVEFnL1lvZVdl?=
 =?utf-8?B?eXY4Z1h4S0RLd0Zzd2psVmJDbG1LYVhvODV6Y1JEZjFvTk5MemZJbzBFVnpo?=
 =?utf-8?B?aWFRYjU2SXIvdHl3NGwvbXphUFByR1hGZDJDTHlOcTd0MnNjY2tqQmIxdWpS?=
 =?utf-8?B?Uk5rUXhjQ04ycFhRcFE4NEx2NnF1WHRtcmE1UjVTL0ZSb2hRbFJpczkwVUJq?=
 =?utf-8?B?RVVvSHkwZU05TVA3UlRQNEkxM1BCcUlTOEJWb2pTczZ3OXRjN0pSeTQxN084?=
 =?utf-8?B?UDZJZUFtb014MXV5dWg5UDRvZWtQUTZ3VS9LVHhHaTF4V3ZXRmxSbFI2blho?=
 =?utf-8?B?V3krdTVPckM3Z2JFOFRPc2t4WE5lUUpIbDNGZDNhMzRTcWJ4NlNtdnllRGlU?=
 =?utf-8?B?UmxCa1ZhaFYwMWYvc2RnS0FTRUJZYlkzM3NuUnlMV0NhYlVVSFZFWWNROEM0?=
 =?utf-8?B?NXc5elliNnlPb3UrL1hndEZqbG1BN3hudnFCMm9wV0pGTnNaQkVXSHhtUWVF?=
 =?utf-8?B?dVhDNFBQdkxwNFg0RUFhTnBlR2hic1MvZkNqdEpLdjdGcGh4MmYrdUpNNmpj?=
 =?utf-8?B?ZzhaVHNxVWZrQ2NiVU1BY2wvMUlJWGwzOHZoZ3YrRzArUDRDcVBqNnVPRnlo?=
 =?utf-8?B?cklUL2k5Z2tTMER1TnQyQ1hpemMwQ2FZbUl3cCtpU2IyQzVpaGs1eWpBcyt1?=
 =?utf-8?B?aUJhRWtPRlJkMDg2aHJwMGIrcFh0S3Vod3QzUkpWVHJEYTJML3dIVDM5dkQv?=
 =?utf-8?B?OG42WWhRdC9HRVcxVVQzSjBqTUZDZUt2ZENBYkpSNFJFTFN1czNJWFNQY1Ft?=
 =?utf-8?B?RUkyR3NheTgzdWxWVUZybmZoWDNZYlhYSnFQMDBLcGJEcFFYTFp2bnpxN252?=
 =?utf-8?B?ZzBZaWdEM0loT0UxU3VXNEVXUnR0OUV0ci8rbmV6RE1VUFBlWVRmVklIR2Zx?=
 =?utf-8?B?a2lVeHUvbm1md1hGL3VHZ2laTHVaT0dtUXpnOGRvYkcwVHgzVjVZZURDQWhi?=
 =?utf-8?B?U2RMa0JHL1h2Q01Ca1puaUZUSG96QnFKT1F3dFN4RitGUEVPc0M3czBkK1Fh?=
 =?utf-8?B?cmtoOStBVyt3dU5taXE0Vm4rd0VVZ1JOLzNBMUFDRXN0bEZJMURNQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6556263b-d2c5-4cf6-bfe8-08de7dca3dbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 10:54:30.5809 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q98tE7RnYUWx4vdIbmuz+QF7k0+gdzEfL2J1fRKrTaIiqP+cAfOwtrCo2y5XqWF6Lidvwc6YvXt9RsXlBKAGxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwOSBNYXJjaCAyMDI2IDEwOjMxDQo+IFRvOiBT
aGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUtDQo+
IGFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVyLm1heWRl
bGxAbGluYXJvLm9yZzsgY2xnQHJlZGhhdC5jb207IGFsZXhAc2hhemJvdC5vcmc7IE5pY29saW4N
Cj4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRp
YS5jb20+OyBNYXR0DQo+IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+OyBKaWFuZGkgQW4gPGphbkBu
dmlkaWEuY29tPjsgSmFzb24gR3VudGhvcnBlDQo+IDxqZ2dAbnZpZGlhLmNvbT47IGpvbmF0aGFu
LmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56aG9u
Zy5kdWFuQGludGVsLmNvbTsgS3Jpc2huYWthbnQgSmFqdQ0KPiA8a2phanVAbnZpZGlhLmNvbT47
IHBocmRpbmFAcmVkaGF0LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEwLzMyXSBody9h
cm0vdGVncmEyNDEtY21kcXY6IFByb2JlIGhvc3QNCj4gVGVncmEyNDEgQ01EUVYgc3VwcG9ydA0K
PiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNo
bWVudHMNCj4gDQo+IA0KPiBPbiAyLzI2LzI2IDExOjUwIEFNLCBTaGFtZWVyIEtvbG90aHVtIHdy
b3RlOg0KPiA+IFVzZSBJT01NVV9HRVRfSFdfSU5GTyB0byBjaGVjayB3aGV0aGVyIHRoZSBob3N0
IHN1cHBvcnRzIFRlZ3JhMjQxDQo+IENNRFFWLg0KPiA+DQo+ID4gVmFsaWRhdGUgdGhlIHJldHVy
bmVkIGRhdGEgdHlwZSwgdmVyc2lvbiwgbnVtYmVyIG9mIHZDTURRcyBhbmQgU0lEcw0KPiA+IHBl
ciBWTS4gRmFpbCB0aGUgcHJvYmUgaWYgdGhlIGhvc3QgZG9lcyBub3QgbWVldCB0aGUgZXhwZWN0
ZWQgcmVxdWlyZW1lbnRzLg0KPiANCj4gQ2FuIHlvdSBleHBsYWluIHdoeSBpdCBpcyBpbXBvcnRh
bnQgdG8gY2hlY2sNCj4gDQo+IG51bWJlciBvZiB2Q01EUXMgYW5kIFNJRHMgcGVyIFZNPw0KDQpS
aWdodC4gSSB3aWxsIGFkZCB0aGF0Lg0KDQpUaGUgUUVNVSBUZWdyYTI0MSBDTURRViBpbXBsZW1l
bnRhdGlvbiBzdXBwb3J0cyBvbmx5IHR3byBWQ01EUXMgYW5kIA0KMTYgU0lEcyBwZXIgVk0uIFRo
ZSBjaGVjayBlbnN1cmVzIHRoZSBob3N0IGltcGxlbWVudGF0aW9uIGlzIGNvbXBhdGlibGUgd2l0
aA0KdGhhdC4NCg0KVGhhbmtzLA0KU2hhbWVlcg0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+
ICBody9hcm0vdGVncmEyNDEtY21kcXYuaCB8ICA1ICsrKysrDQo+ID4gIGh3L2FybS90ZWdyYTI0
MS1jbWRxdi5jIHwgMzIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gPiAgMiBm
aWxlcyBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2h3L2FybS90ZWdyYTI0MS1jbWRxdi5oIGIvaHcvYXJtL3RlZ3JhMjQxLWNt
ZHF2LmggaW5kZXgNCj4gPiAwN2UxMGU4NmVlLi4zMTIwNjRhMDgxIDEwMDY0NA0KPiA+IC0tLSBh
L2h3L2FybS90ZWdyYTI0MS1jbWRxdi5oDQo+ID4gKysrIGIvaHcvYXJtL3RlZ3JhMjQxLWNtZHF2
LmgNCj4gPiBAQCAtMTAsNiArMTAsMTEgQEANCj4gPiAgI2lmbmRlZiBIV19BUk1fVEVHUkEyNDFf
Q01EUVZfSA0KPiA+ICAjZGVmaW5lIEhXX0FSTV9URUdSQTI0MV9DTURRVl9IDQo+ID4NCj4gPiAr
I2RlZmluZSBURUdSQTI0MV9DTURRVl9WRVJTSU9OICAgICAgICAgICAgIDENCj4gPiArI2RlZmlu
ZSBURUdSQTI0MV9DTURRVl9OVU1fQ01EUV9MT0cyICAgICAgIDENCj4gPiArI2RlZmluZSBURUdS
QTI0MV9DTURRVl9NQVhfQ01EUSAgICAgICAgICAgICgxVSA8PA0KPiBURUdSQTI0MV9DTURRVl9O
VU1fQ01EUV9MT0cyKQ0KPiA+ICsjZGVmaW5lIFRFR1JBMjQxX0NNRFFWX05VTV9TSURfUEVSX1ZN
X0xPRzIgNA0KPiA+ICsNCj4gPiAgY29uc3QgU01NVXYzQWNjZWxDbWRxdk9wcyAqdGVncmEyNDFf
Y21kcXZfZ2V0X29wcyh2b2lkKTsNCj4gPg0KPiA+ICAjZW5kaWYgLyogSFdfQVJNX1RFR1JBMjQx
X0NNRFFWX0ggKi8NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmMgYi9o
dy9hcm0vdGVncmEyNDEtY21kcXYuYyBpbmRleA0KPiA+IGFkNWEwZDQ2MTEuLmEyNzBmYTdjZTQg
MTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmMNCj4gPiArKysgYi9ody9h
cm0vdGVncmEyNDEtY21kcXYuYw0KPiA+IEBAIC0zOCw4ICszOCwzNiBAQCBzdGF0aWMgYm9vbCB0
ZWdyYTI0MV9jbWRxdl9pbml0KFNNTVV2M1N0YXRlICpzLA0KPiA+IEVycm9yICoqZXJycCkgIHN0
YXRpYyBib29sIHRlZ3JhMjQxX2NtZHF2X3Byb2JlKFNNTVV2M1N0YXRlICpzLA0KPiBIb3N0SU9N
TVVEZXZpY2VJT01NVUZEICppZGV2LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBFcnJvciAqKmVycnApICB7DQo+ID4gLSAgICBlcnJvcl9zZXRnKGVycnAsICJOVklESUEg
VGVncmEyNDEgQ01EUVYgaXMgdW5zdXBwb3J0ZWQiKTsNCj4gPiAtICAgIHJldHVybiBmYWxzZTsN
Cj4gPiArICAgIHVpbnQzMl90IGRhdGFfdHlwZSA9IElPTU1VX0hXX0lORk9fVFlQRV9URUdSQTI0
MV9DTURRVjsNCj4gPiArICAgIHN0cnVjdCBpb21tdV9od19pbmZvX3RlZ3JhMjQxX2NtZHF2IGNt
ZHF2X2luZm87DQo+ID4gKyAgICB1aW50NjRfdCBjYXBzOw0KPiA+ICsNCj4gPiArICAgIGlmICgh
aW9tbXVmZF9iYWNrZW5kX2dldF9kZXZpY2VfaW5mbyhpZGV2LT5pb21tdWZkLCBpZGV2LT5kZXZp
ZCwNCj4gJmRhdGFfdHlwZSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAmY21kcXZfaW5mbywgc2l6ZW9mKGNtZHF2X2luZm8pLCAmY2FwcywNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMLCBlcnJwKSkgew0KPiA+
ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiArICAgIH0NCj4gPiArICAgIGlmIChkYXRhX3R5
cGUgIT0gSU9NTVVfSFdfSU5GT19UWVBFX1RFR1JBMjQxX0NNRFFWKSB7DQo+ID4gKyAgICAgICAg
ZXJyb3Jfc2V0ZyhlcnJwLCAiSG9zdCBDTURRVjogdW5leHBlY3RlZCBkYXRhIHR5cGUgJXUgKGV4
cGVjdGVkDQo+ICV1KSIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICBkYXRhX3R5cGUsIElPTU1V
X0hXX0lORk9fVFlQRV9URUdSQTI0MV9DTURRVik7DQo+ID4gKyAgICAgICAgcmV0dXJuIGZhbHNl
Ow0KPiA+ICsgICAgfQ0KPiA+ICsgICAgaWYgKGNtZHF2X2luZm8udmVyc2lvbiAhPSBURUdSQTI0
MV9DTURRVl9WRVJTSU9OKSB7DQo+ID4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiSG9zdCBD
TURRVjogdW5zdXBwb3J0ZWQgdmVyc2lvbiAldSAoZXhwZWN0ZWQNCj4gJXUpIiwNCj4gPiArICAg
ICAgICAgICAgICAgICAgIGNtZHF2X2luZm8udmVyc2lvbiwgVEVHUkEyNDFfQ01EUVZfVkVSU0lP
Tik7DQo+ID4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ICsgICAgfQ0KPiA+ICsgICAgaWYg
KGNtZHF2X2luZm8ubG9nMnZjbWRxcyA8IFRFR1JBMjQxX0NNRFFWX05VTV9DTURRX0xPRzIpIHsN
Cj4gPiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJIb3N0IENNRFFWOiBpbnN1ZmZpY2llbnQg
dkNNRFFzIGxvZzI9JXUgKG5lZWQgPj0NCj4gJXUpIiwNCj4gPiArICAgICAgICAgICAgICAgICAg
IGNtZHF2X2luZm8ubG9nMnZjbWRxcywNCj4gVEVHUkEyNDFfQ01EUVZfTlVNX0NNRFFfTE9HMik7
DQo+ID4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ICsgICAgfQ0KPiA+ICsgICAgaWYgKGNt
ZHF2X2luZm8ubG9nMnZzaWRzIDwNCj4gVEVHUkEyNDFfQ01EUVZfTlVNX1NJRF9QRVJfVk1fTE9H
Mikgew0KPiA+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgIkhvc3QgQ01EUVY6IGluc3VmZmlj
aWVudCBTSURzIGxvZzI9JXUgKG5lZWQgPj0NCj4gJXUpIiwNCj4gPiArICAgICAgICAgICAgICAg
ICAgIGNtZHF2X2luZm8ubG9nMnZzaWRzLA0KPiBURUdSQTI0MV9DTURRVl9OVU1fU0lEX1BFUl9W
TV9MT0cyKTsNCj4gPiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gKyAgICB9DQo+ID4gKyAg
ICByZXR1cm4gdHJ1ZTsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyBjb25zdCBTTU1VdjNBY2Nl
bENtZHF2T3BzIHRlZ3JhMjQxX2NtZHF2X29wcyA9IHsNCj4gQmVzaWRlcw0KPiBSZXZpZXdlZC1i
eTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPiBFcmljDQoNCg==

