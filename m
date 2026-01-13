Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E5FCF45CB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 02:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfTrg-0007Qy-NM; Mon, 12 Jan 2026 21:10:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vfTrd-0007Qh-8c; Mon, 12 Jan 2026 21:10:33 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vfTrZ-0000FK-FC; Mon, 12 Jan 2026 21:10:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slhGVE2S801yF5d/+/YMLJfNPlvupmI/sE3s1Dmy1oOOFYR+kSgy2T3oA4TvtpxReoBGYdNaQUJwbo3xyyPxBYfPKQk+PwA5ite/hBIdLlYKdBtL4yJTiPgdo1RltwwiteF3u/m9IThveU0+3G41lKQWgeiR+8TlCi2stVPpA+e2f5GiV0P4vQ3SEtFn37Jz09SSYJI5RyUy+xg+VfGUg+97V+jimr06YwvjZdRajJbJpLY5hK17m7gJcwvpRQ55GW5Ha/iDqRmaM3AhoRVO7rtTHSlcgo9bMECvhS/L+ShGzmAYTydCcVGRZt7r8lr0lKuvL2hCYIsQylDic7ZuFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkpYAK1iVIVP7Ij2irKMgBUY7H/QX7J5RG7vsAkMMt8=;
 b=q0W8h0AQUUaL3Jx5vZxORsmDJhyXOq6rdpAKASNCC1V5E+Yv+mmaU8z9EnUSZVR/eiwo9/hLvT6jxFq8Mdg9O6rJHHucE8dFFxNc3/mxiWFG+jTAX3PO+pUlUDERh+BhGYwbraBq3WjD57dAhpz0UtbgTRW2R9PAnSVnjoC93Q6RnoYVTbub+fbERulWFyCEH2qyy5I2itfZVb/RTQoX2rMjaKDu3Ka+RXbMSA3hWQRzYfUgGrGdd20xrnDrCj5bcCHKoZJuzRqfe6s2YlvYnTCvFNIz6WruiA2YEarC0GzkQ3QWxhjZz3czP5+vbSRk3ttgaplXktnJRKPvmqdB8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkpYAK1iVIVP7Ij2irKMgBUY7H/QX7J5RG7vsAkMMt8=;
 b=LRCpp4X0NwchF8bxaFcEEd9CHG2mbOCqr81WWFGCSOdAvBXvbqHn3X68eoMNmPtgFh8N0FCoIKO+7a6bxTUg+ZGLusONdaE4UU0yVZv7jwq/ocA2GmnoC2/rUQ5Bp877SU9t1Yk0DqPZW01nXkuNgDnyUZEONjyRSf54rc8eILbHMSS+167W6ZeMxMFjx8AO3Zr3i02Gb0FxRwb//IpLGjvXSqc1DCP/p7LrIEGvXcdDsm3ZUg5NpFkLcoFeaKhJM5IYD5oXL3RDn5Uh974Pktgg3nUYa7JPpE400FPLs3kzxiYNLM3WbmRX79o9O3an0ONWQQ8MXsH57HGAjfhGxA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR0601MB5549.apcprd06.prod.outlook.com (2603:1096:820:c0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 02:10:18 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 02:10:18 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Kane Chen
 <kane_chen@aspeedtech.com>
Subject: RE: [PATCH] tests/functional/arm/aspeed: Update buildroot images to
 2025.11
Thread-Topic: [PATCH] tests/functional/arm/aspeed: Update buildroot images to
 2025.11
Thread-Index: AQHcflzy6lmMAUWEFU6h5GYJJFYDRrVO6ygAgAB60LA=
Date: Tue, 13 Jan 2026 02:10:18 +0000
Message-ID: <TYPPR06MB8206F9BD36CE489BCF0D319EFC8EA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260105160358.771511-1-clg@redhat.com>
 <bd3fb4b8-61b2-4605-8b5a-17b6485f165b@kaod.org>
In-Reply-To: <bd3fb4b8-61b2-4605-8b5a-17b6485f165b@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR0601MB5549:EE_
x-ms-office365-filtering-correlation-id: b2bdb2b6-3c6d-47a4-74e9-08de5248e5e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|13003099007; 
x-microsoft-antispam-message-info: =?utf-8?B?UW5PUXU0dXdXWUU5TUpLTWFZOWtzeVpNNmRqTFZ2Sm9maHQ5aGMvcVpKNGJV?=
 =?utf-8?B?eW5OL1dBZS83SUFlVmpsRjBrbzdTc3RVK3lHdjVLbXJPMHM0TlFvSHU0cy9K?=
 =?utf-8?B?ZTJvSkNGc01HeXBnRXNaSXlMem1wdWpka2Vjc092bmlPT2VKVXhXSklDVXZZ?=
 =?utf-8?B?WVhOVnR6RXVBY2xJN0YwUUgzTTJrN2JQRDVmSi9QeW0wMGIzUmJMTUpTYkZa?=
 =?utf-8?B?UnlaNi9IbTlWaTRxMXBpajZPWUIzYjN1cGYyUWZiRW83Ry81dkl2bWVLNWli?=
 =?utf-8?B?bzZKTmt6bzIvZmQzWjdFa0pWbWpGOGlUU29iUVltSWdHS2JhdjJ5Tmw0Q2Nz?=
 =?utf-8?B?MHNSaVhucEZMZnZXUEdoRlc2N3k1WlpMRW80eHNnVi9RbmRwTng2Ykxmb0tF?=
 =?utf-8?B?MkZpeDlac3o5ZjI2QzVDMFdOVzBGelJQbkxlb1JMTHFYNmNod00zTzIrU0J5?=
 =?utf-8?B?bTVyVzF4N3B5VnpNZDkvckk5Mm42dkl2T01sWC96UlpGam1nZFoyUHU5YnZr?=
 =?utf-8?B?L1ZISlRYbS9kUCtraFh4K0ZweW1JVlNIMzk4VnlNTU9mdWpOTVAyZUdBdU1l?=
 =?utf-8?B?OGpKbHFjRmVZdncrV251UzBkaDRYY01FcFU2ZVVxekpXanAxd0ltZTRMWmVJ?=
 =?utf-8?B?aHU5RXBkTVdxdWVnMUJsK2d0K2F4WEgzNExjU2pNQzhOYXJlVkJRYjhXaVNu?=
 =?utf-8?B?bEdkV1FZNGJ2eTducjltL2s4d2xvaE1pQlp3b2lNNDliY0NZL2twSTVVNDRU?=
 =?utf-8?B?RkEwV09rTzZVdmIxTzNzcC9adFJlT1g5V3FpUldGdHF2cG5qUHROb0IyQ3Yy?=
 =?utf-8?B?eXRWMEdtVFNMOEZGMFNqNit6TThnMjM5emxzZ2JSaHBWNkxuWFFneFVCcTBQ?=
 =?utf-8?B?a2NzbWs2VHk4d3IrOWU2MzFTZEd6Nll0UlN5OHBvc2tUM3duNlZMcEIrMUht?=
 =?utf-8?B?bzUyQkR4eEVGREZPNXc4UkFXemV3c05pWlM2bExHUlVzSHNKVmJ2VzF2SmtK?=
 =?utf-8?B?TUppV0xBTjYxdVdIQVlmMllQVkczRjVLeEJORHRiM0JyVlV1aE5YNjUvOHRI?=
 =?utf-8?B?c0tqSUh1N1I2WjBjR29pTXl4SnZhTXZXdk5Ha3pIWGMwRTBqMGczc3FMcnpa?=
 =?utf-8?B?Wi83dzN4M1pla013UzhEU2J3V2J3Z0hYOE1YcTRWUXY3YzZNTE43Ulk2TS85?=
 =?utf-8?B?TE8zbGdEUlJ5MXdBNlg1VWt6YVdVWTV1aWZYcldDTE1rZktOWTh4VXIrbkxR?=
 =?utf-8?B?aTRlbys5UktwU2ErZ2dWT0FQL0JpK3hPb1FzelJ2SmY4ZnVJMWpVeEloa1A2?=
 =?utf-8?B?UXhUejE4MTNQbWh3OGJSdW5MT1pYVTBySTlJYS9jSFhMODF2czRXTTl6SFlS?=
 =?utf-8?B?bVN0akJDTmFMc0NVZTZycTA2ZU5SQ1V1NUlweEhDTFppNzc0UjEyMVlqTE8w?=
 =?utf-8?B?cE56OHFVdVBFRjlpaTV6NnFqYjNubEJqc3Vzd0pQMHhqbmtDTjZLbWpVbkdv?=
 =?utf-8?B?N3U4UHBFV2lleng4Z2NEcGhtRkNhc1JlTHk0SHhmVzEvY0E4S2R3aDJiWmZI?=
 =?utf-8?B?OE9PVWxGY3I1SHVUcTNPSkJzR08vNGVMOUUxQktNZ21Tc2FYa0tRSGNldW50?=
 =?utf-8?B?K3F1blExWENPRk1YMlQ5b0VvOVl6b2pyLy9aQXM4eHkyYWtUdnM2UHdWdXoz?=
 =?utf-8?B?MzZUeFN6TFFvNEc2YkREcFZTZTE3MHR1dWU4QzJMajgvU2c3d3d6Y0N5WEVN?=
 =?utf-8?B?SzBCWnNXT25vWTNJb3p4WU11ME5DSnIvc2JUQmoyWGE3NWlJUHZnOTdsMkJh?=
 =?utf-8?B?Wks2VzJaNEREQTVtUndORFVSUTlMNk5XRmNWVkFVZHZmZHl2alJTZEw3NVJ4?=
 =?utf-8?B?a05HeklIQ1JSM1pRN1htU00zVUtmZlU1OGlNNE1mT1JndWJuSWVvbjQ2Y1lz?=
 =?utf-8?B?THlIWmM3Wm9PZEtjZkZoVHdxb1h6dXIrOThIS2FxUEMyOUZyYXFFeG9DTWV1?=
 =?utf-8?B?YVBua1VkaStOS1VlTi82T1k1Z3Z2bWI2UEhpYm1GU1NCVS9SMzhvaXFEMkJl?=
 =?utf-8?Q?CKZf4r?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(13003099007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGhUd3dRRW9Gd1gvcGViTE5DS04zSlh5ZmNZa0l2Kzd0S0xGODRCbnZrYmdn?=
 =?utf-8?B?Q0JlUmkxMFk0QVptdlNvTlZNbWFrb2pGa2tGU2RLUTVQQ2hRRVpSZlZhZEIr?=
 =?utf-8?B?MkZxNTF4NFpSNFVYRHBhUjAvdlY0aTZxRjhpVTR2bjRxdXZ3RDZQaGt6MGs5?=
 =?utf-8?B?QlVaM0pURWIrd0pOdjhTQ0VNL1c0WWJNRDN5T2dzclpiNjFTY1dVc0RFeS9K?=
 =?utf-8?B?alQ3LzhpVU9rUFhXdGlVTXdXTHNHL0hid1BnMXR4Nzg3dVFINXFOd0lSVjFQ?=
 =?utf-8?B?Y1B1QXRpUk5nV3RLYXRCdFVGSlZweVNyajdOL285SHQ5S0JtdWEzY3JSemJz?=
 =?utf-8?B?TWIzVjZRWTQ2MUswa05iQktKeStUaFhtaHJyaEo2RWpkNHhrSG1UVWFtRGcr?=
 =?utf-8?B?U1BLeEdPNUhTekJEQVhWM0UyMUJOSHZDZC8zODJPZEpXa2l1OHNLSGFCaUpv?=
 =?utf-8?B?RmV2U2IxOHIrdmN4TW9zZ3d6cWNsOWpobW8vZFNDKzV6cWM4WjkzWC9XVW9k?=
 =?utf-8?B?S0lmTURRWkovYVBuTDBFK1UwV0tjRytqaUt3cFFWQlZKYkxtYkgzMkNLdngr?=
 =?utf-8?B?MlI1QXJZNWJJYVh5SEJwRkxIK1FsbE9iYnBQYnkzdmpseWxYTjdWYytZVG5U?=
 =?utf-8?B?N3UwaS9zQ2dDdXE2VlY2eUc4RjkxRGloTlNGRG00KzQxam1UcEpueWc4RWZ0?=
 =?utf-8?B?dHFKSk5XUGFZTm5QanF1UEtkVnQyRExXL1ozNFhFWFlLYmlHK29xL1BleXFa?=
 =?utf-8?B?ci9sQkJYWDREZE50bVdvbzVLcGZ5Sy9pTVZld291R1l3eUc2bWFzVThLZ2M4?=
 =?utf-8?B?ckk1ZkFqM0ZDZnJuY29mUmhGUFpNMGVuTy9TaHZmVEFYUHdVWEU4VWpNeDdG?=
 =?utf-8?B?S3dCblFOVjlSRm9RdmM5YVVzTDg4eEFpN1FWYTJuZVphZUhCQWtIcVBaMzVt?=
 =?utf-8?B?UmlBVExOZjNtMEg5ZTRDcE5zOUJiamtzV2VjTDZPTkh3T3Zra1YwQ0lqYnk5?=
 =?utf-8?B?bjNkV0l4bmZNWDFYNkxpMDJKb0JIV0pPYTlSRGhlMzNNV0tHZGx2TGlIdjgr?=
 =?utf-8?B?WG5weVZwbW1wVkVxcUVGYm0rSW92bHFsTmtpWEViaUNiejRZUHBKMGVRRmEw?=
 =?utf-8?B?TkZTQklpTHlxbWtOd2U2TXRITFJsb3RSMklUYXQ3STdYRm83U0hqSlVLSDVX?=
 =?utf-8?B?aFIzZlBjOVJLZFNYSyt2cnozaFV4SS9oMW9lcHRMMURwR3pndXBzS2g3cFRs?=
 =?utf-8?B?RG1aQXB5aDUrUG1RalB6REZTUEpKOTRJNUZYUlV2UTdEMUhKWkE3OFFza0xF?=
 =?utf-8?B?dTFDTjl1L0MrTkd0bWgxWmhBNEJIdFQ3QStibEc1MmxDN1lkVkgwajFkRit5?=
 =?utf-8?B?TFVRWnk2N3hyVm9YaTkyRzBuenZrVUYxQnNKRUxGZFFKWTdXY0lvWW56UGpq?=
 =?utf-8?B?bWlDYUozRHg5T3FPWGVjUHAzODZrQ005VGpkRGZaZWVMWXJ2TWlDVEI5N2dw?=
 =?utf-8?B?ZEpWRnFZZXpqeDVOdHU4UVRqWWRqSGFvVzVyTkJQNXQzZjZFM0I0R2oyL29D?=
 =?utf-8?B?d0pTMExUYjBLSDhPMHUxU0dyMnJhWXp4U3k0VmJLeEhrZm0rWmVxR2NNQk8r?=
 =?utf-8?B?NU02VENmWWxIRjNrcHVQTHgydy9UalZpWkdQSG9JMUxLcjdHV1AvS2NZSGwr?=
 =?utf-8?B?bDUxS014eVlKQUF6VTk5K3pYUTRzc2RVdlpmM09CaDRLSC9IRlBWZlgvbVFm?=
 =?utf-8?B?aWpLbDI3c296Rk1QRDNzYklBa3FNb0VQK0tFL014SkVaY0t3ZVRHVTdjcmZ2?=
 =?utf-8?B?a3BVN3BxTndveFJZcGg3eGpSSHNCbjUyREhObHFQVksvcEIwaWRRZGk2RUEw?=
 =?utf-8?B?Y05KSXIzN2dhVzRCRlo3Mk04S1dxdmRySDJzM2t6ZlZ5NnBwOGlYODJodTY1?=
 =?utf-8?B?TjFra0pYZjE0NXN4Q2ZjTEJsTVpsampZRlZYQksxRUEzRmM0eVF1ZFRYNVVl?=
 =?utf-8?B?OC9pcTlQNGIxanpyejRyd0xLWTFKNUd4Z0FTTFpNdVhQR0lEUkhhQktKNEFY?=
 =?utf-8?B?M0RQOUhHai81VTNxbSsxUzd0ZEhVcHgyc0ZHS2xoUVNQYWZibWh6d1V5TXo0?=
 =?utf-8?B?U0FWQVRNajIvTjNTKzZwbGJDamJjRjk0VjczSVhiUit4L0VBSFl1aFFZUWkr?=
 =?utf-8?B?SktJS3hGZHJCdkdSWVduYzhTejdRQ2IzaVhJbmN4cm9XYkZsMEJIY3FxNGRV?=
 =?utf-8?B?UVA1d3d3Z05WNUgxSGsrakNuZ08vbHJ1TzBIMi9DMk43dmRvVm5JNkN4Nm04?=
 =?utf-8?B?YVR0L29Uc2FySEdpalRaZUs1ZUtCUm81UGM5MHFGa1dlL3hmMjZlQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bdb2b6-3c6d-47a4-74e9-08de5248e5e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 02:10:18.0874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pJi3/GOOjS4cQa4Cl3E9rcdETzzD7WveI61Mr9STK1xBbIep7eAHwupAStceJQIxhkYkb+KO8Ce/dAXv8YAwWfxwsIK62lCifp/gPfLcgRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5549
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
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

PiBTdWJqZWN0OiBSZTogW1BBVENIXSB0ZXN0cy9mdW5jdGlvbmFsL2FybS9hc3BlZWQ6IFVwZGF0
ZSBidWlsZHJvb3QgaW1hZ2VzIHRvDQo+IDIwMjUuMTENCj4gDQo+IEphbWluLCBLYW5lLA0KPiAN
Cj4gT24gMS81LzI2IDE3OjAzLCBDw6lkcmljIExlIEdvYXRlciB3cm90ZToNCj4gPiBUaGUgbWFp
biBjaGFuZ2VzIGNvbXBhcmVkIHRvIHVwc3RyZWFtIDIwMjUuMTEgYnVpbGRyb290IGFyZQ0KPiA+
DQo+ID4gICAgLSBMaW51eCB2Ni4xOA0KPiA+ICAgIC0gbGF0ZXN0IE9wZW5CTUMgVS1Cb290DQo+
ID4gICAgLSBleHRyYSBwYWNrYWdlcyAoc3NoLCBldGMuKQ0KPiA+DQo+ID4gU2VlDQo+ID4NCj4g
PiAgICBodHRwczovL2dpdGh1Yi5jb20vbGVnb2F0ZXIvYnVpbGRyb290L2NvbW1pdHMvYXNwZWVk
LTIwMjUuMTENCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdA
cmVkaGF0LmNvbT4NCj4gPiAtLS0NCj4gPiAgIHRlc3RzL2Z1bmN0aW9uYWwvYXJtL3Rlc3RfYXNw
ZWVkX2FzdDI1MDAucHkgICAgICAgICAgIHwgOCArKysrLS0tLQ0KPiA+ICAgdGVzdHMvZnVuY3Rp
b25hbC9hcm0vdGVzdF9hc3BlZWRfYXN0MjYwMF9idWlsZHJvb3QucHkgfCA4ICsrKystLS0tDQo+
ID4gICAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4g
DQo+IENvdWxkIHlvdSBwbGVhc2Ugc2VuZCBhbiBBY2sgPw0KPiANCg0KDQpBY2tlZC1ieTogSmFt
aW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQoNClRoYW5rcywNCkphbWluDQoNCj4g
VGhhbmtzLA0KPiANCj4gQy4NCj4gDQo+IA0KPiA+IGRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlv
bmFsL2FybS90ZXN0X2FzcGVlZF9hc3QyNTAwLnB5DQo+IGIvdGVzdHMvZnVuY3Rpb25hbC9hcm0v
dGVzdF9hc3BlZWRfYXN0MjUwMC5weQ0KPiA+IGluZGV4IDVlZmQxMDRjMmI5NS4uYWMzM2M2MmE5
Zjg1IDEwMDc1NQ0KPiA+IC0tLSBhL3Rlc3RzL2Z1bmN0aW9uYWwvYXJtL3Rlc3RfYXNwZWVkX2Fz
dDI1MDAucHkNCj4gPiArKysgYi90ZXN0cy9mdW5jdGlvbmFsL2FybS90ZXN0X2FzcGVlZF9hc3Qy
NTAwLnB5DQo+ID4gQEAgLTEwLDE1ICsxMCwxNSBAQA0KPiA+DQo+ID4gICBjbGFzcyBBU1QyNTAw
TWFjaGluZShBc3BlZWRUZXN0KToNCj4gPg0KPiA+IC0gICAgQVNTRVRfQlIyXzIwMjQxMV9BU1Qy
NTAwX0ZMQVNIID0gQXNzZXQoDQo+ID4gKyAgICBBU1NFVF9CUjJfMjAyNTExX0FTVDI1MDBfRkxB
U0ggPSBBc3NldCgNCj4gPiAgICAgICAgICAgKCdodHRwczovL2dpdGh1Yi5jb20vbGVnb2F0ZXIv
cWVtdS1hc3BlZWQtYm9vdC9yYXcvbWFzdGVyLycNCj4gPiAtICAgICAgICAgJ2ltYWdlcy9hc3Qy
NTAwLWV2Yi9idWlsZHJvb3QtMjAyNC4xMS9mbGFzaC5pbWcnKSwNCj4gPiAtDQo+ICc2NDFlNjkw
NmMxOGMwZjE5YTJhZWI0ODA5OWQ2NmQ0NzcxOTI5YzM2MTAwMWQ1NTRkMGQ0NWM2Njc0MTNlMTNh
Jw0KPiApDQo+ID4gKyAgICAgICAgICdpbWFnZXMvYXN0MjUwMC1ldmIvYnVpbGRyb290LTIwMjUu
MTEvZmxhc2guaW1nJyksDQo+ID4gKw0KPiAnMzFlNWE4ZTI4MGI5ODJmYjBlN2MwN2ViNzFjOTQ4
NTEwMDJmOTlhYzYwNGRmZTYyMGU3MWE1ZDQ3Y2M4N2U3OCcpDQo+ID4NCj4gPiAgICAgICBkZWYg
dGVzdF9hcm1fYXN0MjUwMF9ldmJfYnVpbGRyb290KHNlbGYpOg0KPiA+ICAgICAgICAgICBzZWxm
LnNldF9tYWNoaW5lKCdhc3QyNTAwLWV2YicpDQo+ID4NCj4gPiAtICAgICAgICBpbWFnZV9wYXRo
ID0gc2VsZi5BU1NFVF9CUjJfMjAyNDExX0FTVDI1MDBfRkxBU0guZmV0Y2goKQ0KPiA+ICsgICAg
ICAgIGltYWdlX3BhdGggPSBzZWxmLkFTU0VUX0JSMl8yMDI1MTFfQVNUMjUwMF9GTEFTSC5mZXRj
aCgpDQo+ID4NCj4gPiAgICAgICAgICAgc2VsZi52bS5hZGRfYXJncygnLWRldmljZScsDQo+ID4N
Cj4gJ3RtcDEwNSxidXM9YXNwZWVkLmkyYy5idXMuMyxhZGRyZXNzPTB4NGQsaWQ9dG1wLXRlc3Qn
KQ0KPiA+IGRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL2FybS90ZXN0X2FzcGVlZF9hc3Qy
NjAwX2J1aWxkcm9vdC5weQ0KPiBiL3Rlc3RzL2Z1bmN0aW9uYWwvYXJtL3Rlc3RfYXNwZWVkX2Fz
dDI2MDBfYnVpbGRyb290LnB5DQo+ID4gaW5kZXggNTc1YTVmNjQxNDNmLi4zZDEzMGI5ZmQxODkg
MTAwNzU1DQo+ID4gLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9hcm0vdGVzdF9hc3BlZWRfYXN0MjYw
MF9idWlsZHJvb3QucHkNCj4gPiArKysgYi90ZXN0cy9mdW5jdGlvbmFsL2FybS90ZXN0X2FzcGVl
ZF9hc3QyNjAwX2J1aWxkcm9vdC5weQ0KPiA+IEBAIC0xNiwxNSArMTYsMTUgQEANCj4gPg0KPiA+
ICAgY2xhc3MgQVNUMjYwME1hY2hpbmUoQXNwZWVkVGVzdCk6DQo+ID4NCj4gPiAtICAgIEFTU0VU
X0JSMl8yMDI0MTFfQVNUMjYwMF9GTEFTSCA9IEFzc2V0KA0KPiA+ICsgICAgQVNTRVRfQlIyXzIw
MjUxMV9BU1QyNjAwX0ZMQVNIID0gQXNzZXQoDQo+ID4gICAgICAgICAgICgnaHR0cHM6Ly9naXRo
dWIuY29tL2xlZ29hdGVyL3FlbXUtYXNwZWVkLWJvb3QvcmF3L21hc3Rlci8nDQo+ID4gLSAgICAg
ICAgICdpbWFnZXMvYXN0MjYwMC1ldmIvYnVpbGRyb290LTIwMjQuMTEvZmxhc2guaW1nJyksDQo+
ID4gLQ0KPiAnNGJiMmYzZGZkZWEzMTE5OWI1MWQ2NmI0MmY2ODZkYzUzNzRjMTQ0YTczNDZmZGM2
NTAxOTRhNTU3OGI3MzYwOScpDQo+ID4gKyAgICAgICAgICdpbWFnZXMvYXN0MjYwMC1ldmIvYnVp
bGRyb290LTIwMjUuMTEvZmxhc2guaW1nJyksDQo+ID4gKw0KPiAnYzY0YTA3NTU1MDEzOTNkNTcw
Y2EzMThlMzI2ZTFlOWY4MzcyZWRjNWE2NDUyY2RjY2MzNjQ5YmM5ZmQyYzEzOCcpDQo+ID4NCj4g
PiAgICAgICBkZWYgdGVzdF9hcm1fYXN0MjYwMF9ldmJfYnVpbGRyb290KHNlbGYpOg0KPiA+ICAg
ICAgICAgICBzZWxmLnNldF9tYWNoaW5lKCdhc3QyNjAwLWV2YicpDQo+ID4NCj4gPiAtICAgICAg
ICBpbWFnZV9wYXRoID0gc2VsZi5BU1NFVF9CUjJfMjAyNDExX0FTVDI2MDBfRkxBU0guZmV0Y2go
KQ0KPiA+ICsgICAgICAgIGltYWdlX3BhdGggPSBzZWxmLkFTU0VUX0JSMl8yMDI1MTFfQVNUMjYw
MF9GTEFTSC5mZXRjaCgpDQo+ID4NCj4gPiAgICAgICAgICAgc2VsZi52bS5hZGRfYXJncygnLWRl
dmljZScsDQo+ID4NCj4gJ3RtcDEwNSxidXM9YXNwZWVkLmkyYy5idXMuMyxhZGRyZXNzPTB4NGQs
aWQ9dG1wLXRlc3QnKQ0KDQo=

