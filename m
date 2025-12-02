Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20AA9CFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 05:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQIuu-0002m4-Cm; Tue, 02 Dec 2025 00:27:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vQIus-0002jr-Tf
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 00:27:10 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vQIur-0001qJ-IA
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 00:27:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndGZJNHXVxM2lHCBSVpBA2RLhKMvo+pj4xUBtVeNBHKbbLresg93x8TLcZjBuLCoHaKChoo1oNdZqNhlBorwIKxCko7iFWW2FwESyxvY095MkvTATIjSBPQB0+i/fXJsorvXJjtYQtj0IzbYTbHpka6P3d0cOnVqOXKQ0tMBgaVerHmgizxMXG1yUZjjtnnPgEqrywOxrXasBvlSiBn7BCZ3WE0AXqBb0ETS/PnR0ZGNL8I/5JHHTLddwhOet2QBh8i13n1Oc9Ol4znYLxF4fn6b/zgQrxhwbDN3augJ1VyAixwkYAQXQ3IEmC6HB4kdyKmqdkk+yUe9PO8OVXoPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+l207DYoCvJmQtECLB+R8c0Kqxk3G3ZI/ADxLYJykM=;
 b=Qk6KStVf3+8LAQYbTpART5yCW9E4orGYi8DF8pNw3FHDd6/5apuPH4hGlZsV7ULJKpU6RaOXEf4ZXRcmLgeEgu7LrD3XA77c6qIbCrs+NL4AgBL0miHFD1lMzz+ElNJVuVAd6xVAbmiwuSpnxCU4BKlb7GNzWKxhkMDaBLUQDUizoyRd/kOVxpwmiIyKS/44NTVH28k/+iFsyJEh+yhmGnmQBrgTeUuWwz5LKjZgzh42velqfNeuPrazaWaiXxSC3gxSOicQXwDNyJ/JSQeIx9/dyd/lGLsZP/On3VTjNJwSryHf1mGLQ6gRGyQE8brSwpj+oi+RFkbkkQCmw5nRyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+l207DYoCvJmQtECLB+R8c0Kqxk3G3ZI/ADxLYJykM=;
 b=Q+u1/xkutOR5PSF6TVadrLYcOvi5+iaOpXrLeH1fpILBqM/fUn9OA8bCMcqE00dX08fPeMRsCPwe3LORTNZxxC8CJbzQyNyXH1IzsFTgq0+5vR3gukYBQ3ZKZEOUNdUlo3iw2lTmlFMTOYCUqu01u2TEsgorYNrP8DtpXzcCh/i485iN3OcY5p/m/03eqFZ0DhoUjk/3xWhLiocsXXKIUDko2MJKuQZxR5m1U2zDrTX8vwW+kA4CH9EiKgnsnmet7aEX3P4BlDm8+DryApXiG8nSo8uiIA4OeHA2j6+BePbkjwImvHL4/zt/O2ko5Mi8ja3AyNMLR13Zxagb9cb5BQ==
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by PA1PR04MB11430.eurprd04.prod.outlook.com (2603:10a6:102:4f0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 05:27:07 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 05:27:07 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Subject: RE: [EXT] Re: [PATCHv3 09/13] hw/arm/fsl-imx8mm: Adding support for
 Watchdog Timers
Thread-Topic: [EXT] Re: [PATCHv3 09/13] hw/arm/fsl-imx8mm: Adding support for
 Watchdog Timers
Thread-Index: AQHcWVR/ahEkbEtAfUWv60bF8HxV2rUNUGOAgACU0kA=
Date: Tue, 2 Dec 2025 05:27:07 +0000
Message-ID: <AM9PR04MB848780240A2A2A103F04FF5187D8A@AM9PR04MB8487.eurprd04.prod.outlook.com>
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
 <20251119130027.3312971-10-gaurav.sharma_7@nxp.com>
 <CAFEAcA9Qtu1EF3xT3thWEbZyKPVEkFP0E0HN9UjYJCEEas0CTg@mail.gmail.com>
In-Reply-To: <CAFEAcA9Qtu1EF3xT3thWEbZyKPVEkFP0E0HN9UjYJCEEas0CTg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8487:EE_|PA1PR04MB11430:EE_
x-ms-office365-filtering-correlation-id: 6f9c04d1-68c4-45b2-8dac-08de31636f43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?UExEOTNBZXVNcGFabGdldllJRnNUVGxtSWRMbzVGd3o4dnkzVGRpMUo5K3Yv?=
 =?utf-8?B?aWpSem1yNzdQMUdReFJTSzNHRWwrTmZBWkRReTA3dWtRTWg0WGR4NFNueDNq?=
 =?utf-8?B?b08yYStlUVpmelNROUVLNnNpQ0Z1eC83Q3N6VG5ZcWRMb1hOcFUzamlxMDUw?=
 =?utf-8?B?aDVva0VNR2o2TytzVEQ3bFowV0FpS3FBY25UMHJhV2VOMXpMR2hRVWNGbXhW?=
 =?utf-8?B?Vzc5bDNHbThGZUdwcHZGdlZtZlAxZERIOHpNeU1XMVowRjFGUTRreldySVdT?=
 =?utf-8?B?MmN2Unp1TGFhUmZUcHVVVTFuUFluWTY0SFRxVXllbDRQVkJlRTI0RTRSZjM5?=
 =?utf-8?B?QlFZQU9XRHF5OENvQVpCallha0toQWwrZDNWSEJwQTVQd1JKL0lNQ3VrYk12?=
 =?utf-8?B?dTNGLzVFL0tHU3ptSkZ2WHBibmdHM0VxZkFHMEJpVUlGazN5VHRpejZSd3Nt?=
 =?utf-8?B?MExJTnhscU5rdGtMM1dVTERSbVV0Nzc5QkoySjd1TmhZWW83bkZJM3o4V21v?=
 =?utf-8?B?RjZYZldFSzVCaGhHaWZkWnRoYjVIdGFzZlFYVzhuMGdFcmhhK2J3Q1RvMGNx?=
 =?utf-8?B?TGJteHJhVEJLdC8yZ3czVTlJemlKN1VGcngvcld4bkdoRlBrOUtCQzlpZ3dJ?=
 =?utf-8?B?c3dRV3pzbHB3UzlNMHRWL1RDenoxaXBzbmxLd1hUYnJnbkJmNUxpS0lJWVlR?=
 =?utf-8?B?VVU2cklWd2ZoQ3lBYi9qbnoxaU1LMjRLdlZDaEQwUHpCUEFGUDVzaDhaWDZh?=
 =?utf-8?B?eHhwUFdIWGtnOEtHZjdkOFRzeFdQWmx0alNvZHd3NWFraEMySlIyMnRMZDFk?=
 =?utf-8?B?ck15VGFIZ2RQRXdjUSswYlNNVWV5N0QvMWR4d3YrQXBEd1hxSFMzblliY29W?=
 =?utf-8?B?d2IyUE1XZUFyaXkyaUJBYWFSVU1NYVJWR3hzSGtoUTJYdmhBTDNWZ0U2ajhS?=
 =?utf-8?B?SkdKMlFVeEVuZGM2TldiczFURUR4dnlLYitXVUtMelcwM3F1UVh0a1hQWnJk?=
 =?utf-8?B?N05zK2pXck1lUGFST2paRmJWM2VzM1FXNkVDa2NZdXA4eHJrdCtmYjdFUUNw?=
 =?utf-8?B?ZEJqanV6K1AyN1dMd3FwK0dta2IxZms5UUg0WjZURkphNGhZOTRUZEo3Vm1u?=
 =?utf-8?B?cXB6eFFSRmsxUFc2azhuVmMwRXczTVpQTzNyL3c5eDR5UklMZUZQMjlTOXNU?=
 =?utf-8?B?Qlg4M01yc2NXeUJuQjN4WTRVd0V3OWhGWXFoeUFydFMrTENCREduaWxpM3ph?=
 =?utf-8?B?ZEJaelB1QThWcHlkM2JqMlhOY0l0dE1XSUJoYTlRWlRRa1YyNXUxREFXdFF4?=
 =?utf-8?B?am11dkpqcysxVXFsY0N3ZXB1ZUExbnlwUyt2NnNRVjB3NjRrT0QvM0Q0SmM5?=
 =?utf-8?B?VXRqc0thcVZ1UTNNOFc3UU1LaElZWC9PajY5UDNkdXFSdld5VFNUYjc3VnhW?=
 =?utf-8?B?V0RlSkVyd3B5aDNwNkNFSFl6cll5cmtZYjQza2NnMXN1TG54TXp0U2IwTEhm?=
 =?utf-8?B?VHVCdTNKeGd4ZnJoZW96VEx4bnIyaXU0R1VmR0EwRy9ma2VWRmlwVllmYmIy?=
 =?utf-8?B?NUx0S2hXRlQrMmVUOGV3RFNJaE5PUUEyVndiTUNCZWQ4OGd2NEVJMkU2Nmt6?=
 =?utf-8?B?Z2dTUlIvdmNTVEpreE9tUm1oYVN4UTk3WGs2dTFIeGZDd3p6alVOZGowVUl1?=
 =?utf-8?B?VmNhV3R3WHJTZmVSL2NjaHVLUlpBVEJQSGpTY3ZaQmhkRkR2cDVRWEFURncr?=
 =?utf-8?B?N1hSclVzeHZHWXBWS1NzdjZZMlRJd3R0Tmk1b0k3NTRGNkdSQ0k2YkRManJw?=
 =?utf-8?B?ZU1TNXp4Slgxa3VoL2FwYUNETEk4QkV5NUMvV1lIQWFZOWl1U25kTzlTTWhn?=
 =?utf-8?B?Vk1qRGJWNHVGcFNaSldwbEJSZEdMSnVyVUhKbHNYNmZPTEVkYldWa1p2cVVZ?=
 =?utf-8?B?UGZBS2ZJcGtHSWt5VVlxMjh0Y0ZDc2Uxa1ZWVGd6Y1o0QmJlZms3eEl5THBF?=
 =?utf-8?B?STJPeDJ4OUpsOHNUU1hKM2pzK202RjREck10aWE3UW4ydHNnZnNRKzlBajl0?=
 =?utf-8?Q?tpdpT1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8487.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0d0QzdKcGQwWkRlVk5aN0VlcTF0SU9DcDR0RjRrWDJKU3BWY0VFSWxPZ3dY?=
 =?utf-8?B?MlVtUWtZQittcERuRDE3ZnkzdkkwejVHbm5lQlEzQUlpT2IrN2luUGp1RmFO?=
 =?utf-8?B?TDdkQUhkQVRKOHJybDBrTWVSTjhuNTZMaG1CVllwT0VHb1p4YkJqUlVBeVNx?=
 =?utf-8?B?YWNnam1Od2RrcFpnbGpKVkJKTFY5WFJDa0VwK2p1ckN1Q05ldEh4aEJzR2Mr?=
 =?utf-8?B?a0h1aFE1Vk1jOHI1QXJRNnhBNHRYcktWMzdMYVRvWENJYUF4N21wNjNSSmVP?=
 =?utf-8?B?L0p1Q3pZSVJ6RElRUGxKL0w0Vlhoa3d3OFpmZmpNd0ZVOWRYdkdCdGtMeXM3?=
 =?utf-8?B?WGhiVHhUM1ozeW1kVW1XL1RiOGY1b3B2ZU9tby9KalJYSWRjeloxRVQyb25h?=
 =?utf-8?B?T3JxUlA2aVJhOWFIWFFlT1FkY1djaVlTOUwyRnQ5L1kvMUpMbnl4TElDZ2tj?=
 =?utf-8?B?SFNHNVBkNjJFb1JPc0l6MUJjTlF6SWU3YlhQYVU0QmJ0Q3QyZlZ1em9nTFNK?=
 =?utf-8?B?OUdZNFhSeG5ZOVFVUksrV0UybDkzMmplUmVTSTBVUXlLNjhFeGp5RWU5UjB2?=
 =?utf-8?B?OGMyYVArNkNOTk1CN0hZQWV4UkhCN0hNdnFmU1NzcTFNUFNxUzFSVFVENEhq?=
 =?utf-8?B?RFdoWFJrSFJWTnd6WmJZNWZRRkZuS2Z4Wnc3d2VLRlg5TVlJSHYyY3BXNncv?=
 =?utf-8?B?L3dYanprdUpNUHRjR3RDNFZxOVNxUFhZc2tyKzJMNFF1a25qcnlzVS9jdmg0?=
 =?utf-8?B?RkYwZVZQMXYyeTBLWWNMUDJXK2pLdzgrZzdramFZTElpZ2t5Y1BNMUk3ckMw?=
 =?utf-8?B?QWd2YUNuVGpGRnZuaWVQbm1qR05WOTMwdUpjeTNSVC9NZEFoQW5DWi9WTTMv?=
 =?utf-8?B?bWIvRkJXM01MTVBwdUhWalEydnh4dVBVSEtoalJQUjQ4d3BlbXdyd2ZWWVF0?=
 =?utf-8?B?N0RvWXJYam5ZQzFLWld3Mm56cGpoVWM5Q3kwNmptcFBVdmpuSy95N0dmd2l0?=
 =?utf-8?B?TDZqbEFiTGFOVGE2Zm1GT3JzS1o5WWRjVVNWVTNpUW9sc0xZdW52WXVORzFz?=
 =?utf-8?B?amREM29vWW9URWljcE4rNWNPQjRXZUhMYkJyU3lmejRFWEJxMGl6Q2t5Q0N3?=
 =?utf-8?B?NVAxVmoxdVZoQnYrTzJYR3NlUmc0UEFFT3p6VHhNSXFZTkpaZ1RvbHZXZHBU?=
 =?utf-8?B?aGxaSEVSaGIzTlFoU2FIbWM0Q2QxT0E5TzFlcWU5Z3BsOFd6K0pRUTU2ZUs2?=
 =?utf-8?B?cEUwNXk5U08zYm53SlpiWXRpWEZvOWlYU1dXS2ZCdEdpUDI0QzdNSzl2bDRj?=
 =?utf-8?B?VElRd2hIUXpQYzkrL3lVU25YWE55bXAxWlhiem8wdjVRbzBmZGFycURvcU11?=
 =?utf-8?B?WFZudmpnZU80UDIvSjRIUnJockQ0T0hpUlJQSCtjSjY0UVE4bThvQSsyVCtx?=
 =?utf-8?B?UTJBWFR3dkVkRFNPOHhyL0JjNysxS1Z5QlZ3ZnU1cERTcjA2TnJxOWx4MFdZ?=
 =?utf-8?B?RHR1TlNxeUZXaGJUd29sSTBvSWo4bkZZZTBvZnlRc3JMYm1pTyt5ZElqakZs?=
 =?utf-8?B?VGgvRC84Wm1Da2tWQWVjQXViNHd2ODRIUW9UTFliT21LRVdrdFBkRDRoWlFF?=
 =?utf-8?B?MzhHYk1SZ2xLT1gxMFBzVittNmk0N2oxNmZyMS81bjYwSDlWaTB2V1VIRUJ2?=
 =?utf-8?B?dFFOa2s1RGhQSHBnQ0NOaUJIZzhmditKSFA4aXdZc3lTMEE0cWpUMDBzV0xS?=
 =?utf-8?B?N3JJRHJwSGNUMUkycmtjNWNKZUc4aVp3YUFONVJyYkx6UEFkT2hCTVJKMHNh?=
 =?utf-8?B?Vm9Ea05aUkRianA5bUZuSURwM2J1ZUtFdkp0ZXZoTlQ1MVpYNjFQeHJkclkr?=
 =?utf-8?B?cmhuc29rWXF5MnlLbHhkTnZheGVWT01Ga2U0L1FXbmIwOG1jVW1FYm5hSFRw?=
 =?utf-8?B?TzlHVHhSVTV3YVl2WTV1ZGtnWGZyTkw5enkyajlzTnVkbE5nd1hGT1hqNnFV?=
 =?utf-8?B?RS9FbmxGSjRPbTAvU3EyUDJ5OElURlkyTS9mVHJmMWxEVXlSeW9kZmtEQ0xw?=
 =?utf-8?B?dWJEMTMrTURhLzN2cEtSTUJGejVEWktzOGM5NklLMDZ1MS9oVjV4SnhHSVZ5?=
 =?utf-8?Q?guqnLSzU4NWr/iQ6vtM8d2y1B?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9c04d1-68c4-45b2-8dac-08de31636f43
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 05:27:07.0907 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZxIaXmmJ0xbDvPxWTp+G0Pzey7Whh/c+zXukMe5v7JoilLkyqv9inuJoUPQSqzkaArgtARDe0qk9TkMmty6miA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11430
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

PiA+ICBpbmNsdWRlL2h3L2FybS9mc2wtaW14OG1tLmggICAgfCAgNyArKysrKysrDQo+IA0KPiA+
IEBAIC0xOTgsNiArMjAxLDEwIEBAIGVudW0gRnNsSW14OG1tSXJxcyB7DQo+ID4gICAgICBGU0xf
SU1YOE1NX0dQSU81X0xPV19JUlEgID0gNzIsDQo+ID4gICAgICBGU0xfSU1YOE1NX0dQSU81X0hJ
R0hfSVJRID0gNzMsDQo+ID4NCj4gPiArICAgIEZTTF9JTVg4TU1fV0RPRzFfSVJRICAgID0gNzgs
DQo+ID4gKyAgICBGU0xfSU1YOE1NX1dET0cyX0lSUSAgICA9IDc5LA0KPiA+ICsgICAgRlNMX0lN
WDhNTV9XRE9HM19JUlEgICAgPSAxMCwNCj4gDQo+IElzIHRoaXMgZGVmaW5pdGVseSAxMCwgYW5k
IG5vdCBhIHR5cG8gZm9yIDgwID8NCj4gDQo+ID4gKw0KPiA+ICAgICAgRlNMX0lNWDhNTV9QQ0lf
SU5UQV9JUlEgPSAxMjIsDQo+ID4gICAgICBGU0xfSU1YOE1NX1BDSV9JTlRCX0lSUSA9IDEyMywN
Cj4gPiAgICAgIEZTTF9JTVg4TU1fUENJX0lOVENfSVJRID0gMTI0LA0KPiA+IC0tDQo+IA0KPiBv
dGhlcndpc2UNCj4gUmV2aWV3ZWQtYnk6IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGlu
YXJvLm9yZz4NCg0KDQp5ZXMsIHRoaXMgSVJRIG51bWJlciBpcyAxMC4gSXQgaXMgbm90IGEgdHlw
by4NCg==

