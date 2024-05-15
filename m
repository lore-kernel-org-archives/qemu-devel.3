Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFECFC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78qJ-0004XU-99; Wed, 15 May 2024 03:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qI-0004XB-0k
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:26 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qD-0000oi-No
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715757261; x=1747293261;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=PMN2/YZ4hr8ioAnlB9SWX5lZ5wPmzGuhK2ljrPklk+8=;
 b=r5YSsRb1lCSbps2z+B5VHHz3rxYO8sC1Ko5+oPUDbvlcbyCxglJlIdZW
 +/yZTneWOx1dDofl/6LN7JqgmOeKz9GDDq38SqyCDf1VeN9+DBsXLu2OV
 vq7f+axdL4aoo2OJ2Rdxc6e5Pl2S60vRzvKkkJAuHGFs2ZoPpJZLUO9Fd
 IVW1dvG0zxkGghpziEpI20GD/NzVUuYSiOH3JYTd9PNXOFNPBho284eO0
 cFDHmLb0eigz69Yqv97vrZkKT8nyxyb1Q2N1AHh6iDXZjveUNUQXYpTeD
 votmfgmE6E3FVkGnuKR1b6wtnZf1fE90tiy+w+OZiOZrN22Si4KWFRpty Q==;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; d="scan'208";a="12581793"
X-MGA-submission: =?us-ascii?q?MDEY7VqxBRDW9HoLGQwG05wxTjZBoaUi6o/VJv?=
 =?us-ascii?q?rEfLtbZqreNFW4x+bhF/jv25gH6yUkhj2lFC3gf4HnG/fMNyUHFrerWe?=
 =?us-ascii?q?yLBB9f9ZhxE309iNHzz7QIB35xvKDWLgY6/tc2zyUsHOP8J2fCvTIJWC?=
 =?us-ascii?q?2xfpUUyo6IcskqKDz+oq+oSA=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 09:14:16 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZB7Gdo6sD525RSSwdyJ9Hxkixzj+sGTwPZYTkWuv10zY8CLdaWwp+fhMW/l39gChx+vZ2xpq+4x7bqAPG3qJaxEGpTcCSfOEiiidLVzMhfsEA+VCtuKciIExxE5XAWGWmy0a7/p7+IDxm63ogugXDud1L6aaGkEE+U6b5MTegE1tkN3xS824MhX+rs3tUtN5xU79nSroFmosW/r4eyT8SeCPjCAzedDACqATfGMNBiKm2gV8d+05xlFckLhmVkFsPI7e3DSnUiN5/Kkh8SUu9r024Nnk9hakIs2Cveiusc772AtKgpSCq9kIhM0MtT46LkVmBCAH+OKiKP/LNwXPFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMN2/YZ4hr8ioAnlB9SWX5lZ5wPmzGuhK2ljrPklk+8=;
 b=j85GBVGhbgZoZ5OSZyPl0kmnopmIpNe9aiGer3vUvrX9kScEsvZvccyh6B65i07thxzJzi24+zV1ECyBwlsom4x6ONecTL1lKUl0Rk7RRc2oDbs9MVmE9zFJ02gyyVg1LiLr+GVcaC8W3sx8uowcUjOSoQAq7N67wrSLLkq54kHPDlihHwgTWnC5KbD6bg4GpO9mnzPIjsR7YOk98kZiVyG1bgt7CqHGHN6OvHYH/AnzYoRk6c8AFCLwRuAI3KAY9QsTBjK+v0aZA2Fhg6IttgjjwK7PEaGFjbUL+6Od3gSUs7F05WUpFDlEel2jpL9aSaeUZEft73t+W278GASxAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS5PR07MB9896.eurprd07.prod.outlook.com (2603:10a6:20b:676::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 07:14:14 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.056; Wed, 15 May 2024
 07:14:14 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v2 02/25] intel_iommu: make types match
Thread-Topic: [PATCH ats_vtd v2 02/25] intel_iommu: make types match
Thread-Index: AQHappd9882RJ9fKeUKo9Sr4V6SJrw==
Date: Wed, 15 May 2024 07:14:14 +0000
Message-ID: <20240515071057.33990-3-clement.mathieu--drif@eviden.com>
References: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS5PR07MB9896:EE_
x-ms-office365-filtering-correlation-id: 3b4cfcaa-542a-499e-fd00-08dc74aea07b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Wkozek45c1ArdEdUQWFpSGQvRjV0ZmdVN0xPYUE1SUpaS3AvOVZ0YjhyeHpv?=
 =?utf-8?B?ZVRYUmJzMkJvM2JFUjlGajNjcnhXS1VGckVZM3Yra0NQUFprbnpRaGdZbTkv?=
 =?utf-8?B?OTVqODllMjlFQnNoaklpRkE1R0lOM3RWQXM5cFAzbWdkUTh1UUpOdGRmc0Zk?=
 =?utf-8?B?NUFOZ0NLUHdvQTlBSmVEdk5tZzd4NExVbURtSlBtaG0xWi9wSCswbTFGREZO?=
 =?utf-8?B?TnY5NmNtZ2s2QTdOS2NwSFRTemlITThoWE8zSVZFZVpKd20zRlQ3OWVFK2Jy?=
 =?utf-8?B?TEh5TWNIeFQwclhkaW1sQUhxdGZuU2VtVzlEalBrQmFQWjY1dEUvOXMwM1NJ?=
 =?utf-8?B?ZHYvVmlSc3dudGNRaWVVTkFyUVBYdkdsM0pKL1lDMmczQU5kSTA4YUpLaFpk?=
 =?utf-8?B?UWlQSDFaMGQwTk1RNW01RC9BNGxCVGxxckF0eWFIUzBmMlNsT1pBVkVWams5?=
 =?utf-8?B?c25QOWxpOFdkYVF5ZlVzYkM0UXkvRDRKSWtWS3F6dmxSSVh0NDBIb3dlM21k?=
 =?utf-8?B?Yk9IZVpCRlo4VTRKdW01MWMyb0xOTXNCVWVPOFdEb2diRmcvWE1vVElUSnpE?=
 =?utf-8?B?d2JsR3kzSDFFdmtCVVN3cklWMmo2ZmFCMjhBSjNrQkROVUZTODdlTHAybG5z?=
 =?utf-8?B?OTNTN1hObkljb1ZTUFNtK2NqREFLU3BjL2s4Z3BMYUxpcjVVb1liVnZMQmFq?=
 =?utf-8?B?ckdmTWM3LzRDV2hqZW1QMStsTGxLUHkyb0tneGRnV3haVlFTbit3QjFIWkdj?=
 =?utf-8?B?UkRTbDRINTE4cjRBNWNFYU4vbis2RlJnRSttc0c5WVJBTE5rVFdKRzFRaDJv?=
 =?utf-8?B?NkFlVUk3M1FYYTZJVFZvVWhNOGNzNDIyamVkYzFQTzlKTU1YZFFYVTVFRGdr?=
 =?utf-8?B?TTlRSDY0c0JCK0NyeUFOc0xnRGtlQWdPRC90U2xPWC9vVmdVVWZDU1N1UG0y?=
 =?utf-8?B?d2dPYXdlUmg5c0pUVkd0Tnl6MmdEL3Vpa09tdHpsbzYreitGSkRTOTdxS2JZ?=
 =?utf-8?B?bXJqWGZ3WndyY3dQa1FXYThxelVKK081bEY4MVE4eENvbWJQSkU5UDhmV2Jo?=
 =?utf-8?B?by9ONnY3MzM2SGVuN1h0QWdPUlVBTXd0NWpNYW54VFlGMk9FeDlzSWFVUDEr?=
 =?utf-8?B?UEVyV2RtUWQzQjRoUWJXL2UvYXIxdXJ5TVhPZE9NZm45RDFiM2MrZzlNZy93?=
 =?utf-8?B?cFdrc3o4NzFGZjhSaDJ3QjZ3WFF5emozQzdNOHRoS05zN0JoRXd4RU1FSjFv?=
 =?utf-8?B?WGgvWmdtME44TnNQcDZVNFVDYTUyR3FFYlRLMzMwdnFxdG9ET0hodHBiWTUw?=
 =?utf-8?B?UEJBV1RQU1h4NnFKOFBJdEJsWWRsZDcxZ3JPNlBXRnprbFRJNlh3QTE1RWVk?=
 =?utf-8?B?UENZSFZQUFJwUUxURzVBSXNSTHI0ZlhDN2cweTArODI0OTA0RThxaUUwTDZu?=
 =?utf-8?B?aFV2YXZlV2pqRnRodjdUSkJpdlI3akpHMWRCWmMyV3h5QnoxUXI4NmptOWxE?=
 =?utf-8?B?S01VOG9YMUNyb09IK3FzOVRDQUVDVUlaOWdOMFZQWTFISFFYQUNNSi9PZFJH?=
 =?utf-8?B?cmFCdkw1QnVMNXVtK2VNaXA4OU1JenFGT2lwN29BQXEwa1FWWnVNRktQMWNi?=
 =?utf-8?B?WjlQN1BoY0pINzh6OVcvc1VpblVyeXhscjU0NFo1RTlnRHFrbFBrT09QYzd6?=
 =?utf-8?B?NnRlRnNzVnFhNE1tWGRXb3Bxc3BhM0tYTUpkRDhkc2pya0pPQUtXQm1aQVNv?=
 =?utf-8?B?NEpXcG5qcXM1NTlEeW02cjJiUVFzYWlUYWFWTThrMlZ5R1ZVYlVlRVVLQTds?=
 =?utf-8?B?R21ucS9PNnZ2REkyaTBNUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUQ2NzhiMjlEd0lvRnRLVnVwWmhMeW5nU2VXbmVUWlFXa3QycC9SZDJhRnpK?=
 =?utf-8?B?S05kNmVPRUw5dTdMdC9GSGZsdGV6c2JtMkxSblRuUUdHemRKc0xwckpJcGlr?=
 =?utf-8?B?Z0dlMnpHV2NRQUJqc3ZWVk1aL2hTYVRjclJnVUVOeHVuTG9ZNkc3NTZtVnpz?=
 =?utf-8?B?SnI4WTYrendBQmxxMVozLzE5Wk9xcmRIWFJuRFp2YmtYMFdPUnM1cjFvcjBr?=
 =?utf-8?B?anVXeThGUThyNVpnOCtydzBaQ21jL3JQSmN4amJpSVp1aUxJenhYYWVuS3RC?=
 =?utf-8?B?V01pQzI2dDBXWXJmMW9ZYU5WaTY3c0ZqdFdvV0p0VlZMdCt5MHYzUHFhUkZa?=
 =?utf-8?B?TnJDUFpVeEVXOXkrWkRUS0dXdk9sTTBJYzEyNUZ5RnhQZUtTRjFKN2ZnelJv?=
 =?utf-8?B?REVyWVAxaVZOVzJSenM2ck8zMVp2aVQ0YjR1bURaV2xZZTJlSWhXc0l5RVdB?=
 =?utf-8?B?WVBjeDR5OEFlL3YySjJHejRJR1FIcEswS0c3UjZwNFl4NHRreGdxSFNzbWtO?=
 =?utf-8?B?R1VWS2R0WGtIazRBZ3ZSRy9CM1g3dndQQllkVFFBU0dDT1IzSkRHRnZVc3NX?=
 =?utf-8?B?cHJVR0x0eWs1ME9RUzMzVkVWZ0ZNdjZJbStsb2hzMWhQa2QzU0FDN0xlY0t5?=
 =?utf-8?B?eTVoaE42cGErNDA2cXJOQldOMG0rODFiU1FRR0U0TFZ4blJRdjdJWlFhOENE?=
 =?utf-8?B?Z3JuN2lQUGRrMUhvSFIvcHNadm41cW9iSHN6ZEozK1NGWndjOXgwa3IvRmJp?=
 =?utf-8?B?VG5GZ1hrbitHamNXeWlvejFNbHBCYWRmbzhjdnJiOE5aOVdLY2Z4eWhHb2Iy?=
 =?utf-8?B?c1Q3REFZR1kwRUdlYWZEZGs4SXpndUdiekVYYjRkN0JUcGk1OUIxbTNBcU9K?=
 =?utf-8?B?WkRnWEhKSnZKeGdiLzVTTlp4ZGVpS0pRQ1Z3UWJ3cEJld2R2M29mMWE3WGc1?=
 =?utf-8?B?TjdGOFRRWUlPaHEzTUw2MkFJQVo5cGRrbGlzSUgyQ2M4dld0VGV1QU1xSGMx?=
 =?utf-8?B?RTIySWtuWUZOUXcvdy9JYlJ4WFcraXdBd2NTVVQ1RFFsa1JjL0pIUEY4eTR5?=
 =?utf-8?B?YXhybWxaZHlnMWJkazlkcUVuMFd4ZEFzeEpxY2M3M2t2cjdiRUJiUTFFYTJz?=
 =?utf-8?B?c2lFbVBnTXoxZ3BFdkxkbkNJa0oyeDFEREpVNXh5SHJrL1J6MmxQR2tvQVZh?=
 =?utf-8?B?ZTV0UnBjVzVBS2Y1QjVhV3p5WE12OUw3ZkZVZDhpbUJRcXNodHFqNHBqNG5S?=
 =?utf-8?B?MXJibTBXUTZqUWw2eXVJVE83VDcvVnJWamlGZGxRcktJbElwZzhQUWs2WjA3?=
 =?utf-8?B?Nnh4YjVrOVZJbEVJTDJSdDJXQTg1bU01U3ZMYzdCODYrWGJiQUt3N200SFcr?=
 =?utf-8?B?VW1lTEF4RzFkTnhrYWZjWVRNOGZuKzBTZVA0UVB3ZjFaUVVyY3hIb3FEVTda?=
 =?utf-8?B?S2Yzc1RGN2JrOHhjSng4eHAzVjZGL284ZUs4d3I1czQzM1FrWjRUVEJkMzRY?=
 =?utf-8?B?V3VoTlliMHZwOFNqVW5PcXI2TStQOVZ1NVh0TmF6enFtY1crbnhLUzdQTEZv?=
 =?utf-8?B?TFFIZlE0Qnp5NWc4cEpZK0VpLy8xbWxlOEJSZmlvOUpPZHN4V0NTUTFiZjFQ?=
 =?utf-8?B?UUZEbjVieU96VHpTMXVrM0xKczhrT2VKNjdKWHZrMU00U042Uk5UTUpyYUg4?=
 =?utf-8?B?cXlwS3RGbk9NeCtUVXF5UW5nQkprWm9ZK2N4S1JTZWVEeXltUldUY25wMjJl?=
 =?utf-8?B?VGJwT05wVHlBR2N2cDdCUWc1VnppTzJBR1JtUCt3WHJ2ekhrbUkyK1NOdlJN?=
 =?utf-8?B?U0hZZmVRSXVSRWR2ZTFHNHFCdlk1OW9uNUpGaDVYa1ZmbTNQbERGMXNNeGtS?=
 =?utf-8?B?ditoSlR2dUNRUGV4aTl6dDZEVHFwNUUwWlRUZk5hNm15WkdvaVJ0bU9QVXBL?=
 =?utf-8?B?b05jbkdSajhiYjk5S3JIT3EwU1I1WW80a3FrR1BoWVN6OStnekpZZDdZOUo0?=
 =?utf-8?B?aVZPdDVjc2VUM1pjdjFzTG9GckNvdHdQWGJmM2l5d2EyblhROGk4cDR3aE5Q?=
 =?utf-8?B?TXkvcEZHYy9jV3M1ZENZZXp0MVV0eTJxbmRqdW9rTjRFRXlEcmloL3VmdTV2?=
 =?utf-8?B?MkwrcmVoNi9BOUthc1BNUlpONGdBcnlwSG16QUZCdzZaMjh5NTFoaE4xTWRE?=
 =?utf-8?Q?0SeLEINSiNsi28AjmxR7QwE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A37A9C65A984234289C5A10E26CB31BE@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4cfcaa-542a-499e-fd00-08dc74aea07b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:14:14.4798 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gZyqvtyxkidNwvf8U00jvGQk1Gx62TVnrC+9j7nS5UvNuIcXWXeolFmoYBJBmX1sH+hatUhrjyl6bqJbpd6zeC0MxPWmZcmx9NYbkq6X2h0l3OZgo4hJ6RtTkdiMtzcz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB9896
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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

VGhlICdsZXZlbCcgZmllbGQgaW4gdnRkX2lvdGxiX2tleSBpcyBhbiB1aW50OF90Lg0KV2UgZG9u
J3QgbmVlZCB0byBzdG9yZSBsZXZlbCBhcyBhbiBpbnQgaW4gdnRkX2xvb2t1cF9pb3RsYiAoYXZv
aWRzIGENCidsb29zaW5nIHByZWNpc2lvbicgd2FybmluZykuDQoNClZURElPVExCUGFnZUludklu
Zm8ubWFzayBpcyB1c2VkIGluIGJpbmFyeSBvcGVyYXRpb25zIHdpdGggYWRkcmVzc2VzLg0KDQpT
aWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRy
aWZAZXZpZGVuLmNvbT4NCi0tLQ0KIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDIg
Ky0NCiBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfCAyICstDQogMiBmaWxlcyBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9ody9p
Mzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCmluZGV4IDcwNzM1ZTIz
NzkuLjgwY2RmMzc4NzAgMTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCisrKyBi
L2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KQEAgLTM4Niw3ICszODYsNyBAQCBzdGF0aWMgVlRESU9U
TEJFbnRyeSAqdnRkX2xvb2t1cF9pb3RsYihJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQxNl90IHNv
dXJjZV9pZCwNCiB7DQogICAgIHN0cnVjdCB2dGRfaW90bGJfa2V5IGtleTsNCiAgICAgVlRESU9U
TEJFbnRyeSAqZW50cnk7DQotICAgIGludCBsZXZlbDsNCisgICAgdWludDhfdCBsZXZlbDsNCiAN
CiAgICAgZm9yIChsZXZlbCA9IFZURF9TTF9QVF9MRVZFTDsgbGV2ZWwgPCBWVERfU0xfUE1MNF9M
RVZFTDsgbGV2ZWwrKykgew0KICAgICAgICAga2V5LmdmbiA9IHZ0ZF9nZXRfaW90bGJfZ2ZuKGFk
ZHIsIGxldmVsKTsNCmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgg
Yi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCmluZGV4IDRmNmIwMTU0YjUuLjkwMTY5
MWFmYjkgMTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCisrKyBi
L2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KQEAgLTQ3Myw3ICs0NzMsNyBAQCBzdHJ1
Y3QgVlRESU9UTEJQYWdlSW52SW5mbyB7DQogICAgIHVpbnQxNl90IGRvbWFpbl9pZDsNCiAgICAg
dWludDMyX3QgcGFzaWQ7DQogICAgIHVpbnQ2NF90IGFkZHI7DQotICAgIHVpbnQ4X3QgbWFzazsN
CisgICAgdWludDY0X3QgbWFzazsNCiB9Ow0KIHR5cGVkZWYgc3RydWN0IFZURElPVExCUGFnZUlu
dkluZm8gVlRESU9UTEJQYWdlSW52SW5mbzsNCiANCi0tIA0KMi40NC4wDQo=

