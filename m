Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5CCD6EBE2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 07:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGvfl-00083N-BO; Fri, 29 Nov 2024 02:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfb-0007zA-G3
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:44:09 -0500
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfU-0002e4-9i
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1732866240; x=1764402240;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=SgZ/NdieoWyyUYJq31zTUmPy3l7qes7ujZUCB5UJYUw=;
 b=GGCQRfYD0NQLrQYMv87e3lfAgJRiwCpipyOZa7XfpGoCfYgk37r6VMiS
 oB7fD0/OGPG9O7IibWXVpsWW+5rt5CGKnY8sEOSu0+fz98keZm36qyqIq
 6aHCQkOHJ5VMnNqd6QcmQhYKWdvSn+qkBVd8+iDxkKYBJUIRPyWfEH7KS
 pvzzCZmf7EXqsovii/Hvu6BwSvyA5ylihh5mw3dV7o0mNLmJ3vhmw3Xh6
 POCqI0TK5r7E9iKdjaXg+z1hOT1xUxd70YUEzItEIHfmc9DdVA6TnGcL8
 GILShHxl3MEJa6esNr1ACe6o3TLAMztQwwyfrsnZYnywoDRwE+nSftzub g==;
X-IronPort-AV: E=Sophos;i="6.12,194,1728943200"; d="scan'208";a="25664404"
X-MGA-submission: =?us-ascii?q?MDFIMZM8J5+PI8S/UsUuFt+ekDXmTEttc6dhj1?=
 =?us-ascii?q?SNFbhvBlzVIMe27S9Nu4cvZbml3hSPCYsVx8xxk8AtMYHdj3zoVUeFNk?=
 =?us-ascii?q?iDH9t+ymmhxWIF/BhqdnXaOQPLwUwimfU3G5jYrBDaHT0smczfawrjJ2?=
 =?us-ascii?q?+4nborwyIHgetaQvmZBqRmtg=3D=3D?=
Received: from mail-am6eur05lp2109.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.109])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2024 08:43:57 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otDriJfUgLl+whCAijuGnbDawrrmQ18YKQA+L5fK2YVtWjqFNsaaKf/bYU6mZMR2mJG8uyI0+8UFyyp34FsGZdqOvOJ1eTp20Iyt96RUvLMl9RT0RKdtqxdfeJLx2giFOoNpqxqWgpDgvCDnhRbFmgdj/Q137YEK1+YIJaO5QqZkuNSdARWPIlfNjbIRMqTzaPXYTtohGqCkw9DsfCJgUejZEzTxml5qgOWNg3RIMz+vmEA1mDnQlDXHT6RWFVpOYUBs6Nvt7QrwbmfcuM8F1pjvQgWDygDINwx2p3NXQ2moq6XFHOAIGav8+Wnq6cEyIYfzqMmAvFX5BKb5E98T5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgZ/NdieoWyyUYJq31zTUmPy3l7qes7ujZUCB5UJYUw=;
 b=bYW4myQNDhHGjMG4nss1+P4mvlxxN31ys0riWilGtksER4Xii6gb9HHjUOnK/+ln7E3FHkAAoXgK5K/dnl49AkXS6crPimId7RPwDu7CJFhtOZT2OtauByg7g2tk2r5JyXc9LM3divMxIidLLW0hEzBCO2Ijr1J2XI++iJUDT6WHjwLYAOLdAi9vbXBK3NlcFnqhZLU7NfLoac2dPeldQU7kI7hsW1SrFfPzq8szbxwcwS4GYtGD9h6faC3tj4ZhC7zVHXPCcBnI5O6Q+GFnmXKwgxGBVSpbfODiq4SIzZT6XqWbAnAJRB7000so0WN1V80n1szO3Tetf1RoTP6Sdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgZ/NdieoWyyUYJq31zTUmPy3l7qes7ujZUCB5UJYUw=;
 b=WQlNKHgyxmIN6TxyYsCCr7dNIqHgylBrFGLdSebouAH7nQDlx2G+lYRkO4UtyHQV0T1KUklc+G9ZrzM5m2Ru+MiD4JYTPBTIB0U5ebSGrC04CluUSgSpa3qT2tONvm5GxaejCrhIpj20c+XXKS8ARQLvxwcyVYE1v0VNebgOzVdLCCVynKgdjZKiUeHNcwUQlIWPj9C60g7ceTi45EXFZizNLeltyUAYWNm9IRDBb1+wx91xvFaQWRbcFCx0T0SfBM4At99honZ0ZK55cQJhRVfGc4h54hZoONExCiLYsWJYYW6Wc6O2lN47jN3rV/9aWiaGEdlQVLm4E5p37ybZ4A==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7847.eurprd07.prod.outlook.com (2603:10a6:20b:39e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 07:43:56 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 07:43:56 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v1 08/19] pci: Cache the bus mastering status in the device
Thread-Topic: [PATCH v1 08/19] pci: Cache the bus mastering status in the
 device
Thread-Index: AQHbQjJwwtKQ1xqBiESCRkJz4hVdrg==
Date: Fri, 29 Nov 2024 07:43:54 +0000
Message-ID: <20241129074332.87535-9-clement.mathieu--drif@eviden.com>
References: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7847:EE_
x-ms-office365-filtering-correlation-id: cd734155-2d13-4014-8e76-08dd10499427
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?RmJDcGwxWDFQNmVFV1MvU2ZiamhuNlplVUZQZG1QeXBhY3RWaXA1bmw2c2JB?=
 =?utf-8?B?dzJJQUVzbkd6MS9WT2liWWt5azRvalVsdUtkTzBGTko0VTQ0eXI4YVREb05Y?=
 =?utf-8?B?NjU4ZGRjVE96T3I0czg4cEd2S0daU1dzMGppeVZzOTl5Nm9iNEROd002ME1J?=
 =?utf-8?B?SzN5bnBSOTFHdjFLek41b1QxbW1RdEtLZjVDQzVvSlBXUUd0bXRPT1pTd3Y3?=
 =?utf-8?B?SWEvR0MvU2hVb2ZydUlPdnljN3lmTHVLeE1jdjc3R3dXdDlmN1pvN1RpN1N3?=
 =?utf-8?B?OC9sd2Q1MUlKZmF5R0prdThJcFd5bTcvK2pNY01wQTF3eGtlRHB2RkhHU2wx?=
 =?utf-8?B?U1YzbXZ6d1A3K0xOVFZUWjdSY1JsN2pvQjMvNUFwMFVNSjJ5N1Z4L3ZSSnI1?=
 =?utf-8?B?K21GVG5IV2hZK1JDUjZPVlZ5WXFGdlNZd0JwTVRVWlVRTXByb0lvRElObnor?=
 =?utf-8?B?aG1LTXBvTWhxUmkrL3ZVSWFKcFVnWDZpRnBPeDRhVVR5T3dURzM5QXlPK2hn?=
 =?utf-8?B?Zk1XL1VjbVptcHBEQ21GLzM3WUxuTUx6Nlh1bkVVUXRwaktVSTdTQUNKTHFS?=
 =?utf-8?B?N20rejVMT2FYcXFIR29FbTg5d0M1TnNyL2g5SnVMSzhvd21RYzc1NVhOb0pN?=
 =?utf-8?B?Q1h5Y2c4N1ozRmU4V29EbjZXMXZHa2RsYmhKS09WZEdYTkxGVGVGR2NwYzFp?=
 =?utf-8?B?Sjg3K09VVU5PQXJPSHdWQXJpKzczRGNja2t1c1prcDJYZURkZ2syeVV3WXFR?=
 =?utf-8?B?RjJ4RGN1ME9HY1lMNElGdEE4amtLeWtYZzg2WCtGMHNOenpxdVR1Y1hPbXE4?=
 =?utf-8?B?VFJidjNEaG1WaWdvanVUMHBYYjZ6Qjl4VkwrNjZXK3diOFBmWUF2YnV0TTkz?=
 =?utf-8?B?aE9DYVNzTFMvdGtzNGluL0Z6NDZFSEJBZ3liNWd0SDV2am5CWkg5SWlpcXRp?=
 =?utf-8?B?ZU01T0xhTzJmR2Y2ZzdYRnZJOVgyZTBPcjIyY2RHSkVJSkh5MTBFekwwd3A2?=
 =?utf-8?B?akxsNVFPVzdCemlNdlNVZlFSSnBJTXdObGNaekhPNjY0MDVBOWM2Yi96TmZh?=
 =?utf-8?B?T3Q0Q1Vyc2ZIRU1sd1YzbXJUekg0TlVwMjlUMGIzN1FNUkNzUWtxdXJZZEpE?=
 =?utf-8?B?aVRDaU1SNHRyemdPeWRXTHcwK1huR1Z0R3dhOGlFeHFQQTFVU2FXYlhBZk8r?=
 =?utf-8?B?Yi9YRllSWDFzSFUvY2EwcGNURkJ4SUJWaTVNMXZubmJTMlNkVHlycTVNT2h0?=
 =?utf-8?B?NExFZEZ2Vll6MnJZMG5NYnRrMzV3NXY0UlIwbnlxZmdTVjJtY2k1RXRwTUEx?=
 =?utf-8?B?NFZ3d2pOVWRtUy94aC9SbG85YXRTYzhMOERNRGs3b2FTLzRITzQ2Z3QzOEdQ?=
 =?utf-8?B?RExnOFJlTytPcys1VVNJRTBVTmZ0TVplY3RyM0UvQjBSRGpsRUFjeE1zMEJ3?=
 =?utf-8?B?czRXRWZWanhtTjdMeExHVWU2bVlzQXhkZzlHbFhhbGVTT3JZTU82MlVza3VJ?=
 =?utf-8?B?ODRTTlNYamljcHNsK0hxOWIzaGlrVEVseDZvcmx3R21DSzBHQUp0N204MHhz?=
 =?utf-8?B?UFBEUE94Z2dKZEI3cWJJNlBDUHdTbFhDMm1LV1hDc1RIUVI1eGd0THN5ak0x?=
 =?utf-8?B?YSt0MC9sRTYvdTh2cEJsV3JoZTE4bjh0dmpWdnBycXlnVnQ1ZkVKRy9rZmJv?=
 =?utf-8?B?ZVJKbUh1OWM3UFlMT2g0SFlQOWF1K0pkSlNEdDJMUlRkc2YvS05YOTFKNzNW?=
 =?utf-8?B?WXBjM2ZBTGtDUU5ibDl6SThEMWxVamlNNnpJMXovQWdMbXNVZ3RURVdSYW40?=
 =?utf-8?B?NWNEZHFKVklINWUwcWtPRFZBakZ5Mm82OEVwbWJjSVBFYVAvcmJHQXcxVzMx?=
 =?utf-8?B?YllhRlV3dWloMU1HQjg5VU9YdnF2Q1dDVHVJczdMOGwvc3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWhxRVc2eEQ3SkJYTFpJbHY0THNaSXY1K2JQVHdzUnVYMWdyWFkxelRtK2Mx?=
 =?utf-8?B?ZUNOZEU1dHI3ZEY0SFhTQ2NRWkJGclJxK0w3NnQ0T2t4c0N3YU5DSmI5UDhp?=
 =?utf-8?B?QkYwaDRsaXFkM2JZSVdVNWd0bU9LUXdpMFpGTWx6VGNHb2xVZHlXQjgwdXlH?=
 =?utf-8?B?eDRYQ291ZFl2ZzB6ZmtCaDc1OVpmNnB5YXRiQy9FaFdSOGNSR2JRdXlqSGwz?=
 =?utf-8?B?VGFncWJaYUpHSEtvL2Z4ZUh3UC9VdHFiVUppalB2RFRubWUzb1Ara2lsL21t?=
 =?utf-8?B?OFZyZzNDU3VyRy83b3VxRDQwK0kzR3NNOERxTjZycnlkNVM0WEdyalYwUE4v?=
 =?utf-8?B?bU1KK0JEODZrdVlFN2ZWa01ZeE1zWURSb0JEUW16QzVCQldZOUlEZE1hY2F2?=
 =?utf-8?B?cVRJVEhYdHBmSkhnNEh2Q3FCOFRrL1g3L2NVZFF4Q1lMUUxhWllETDVFd1lI?=
 =?utf-8?B?R01qckNRMUE3amFnajJnS1Z5bXpKdmFya0FaZWVhUThEaEZ6WXY1cWs1bjk4?=
 =?utf-8?B?cENXRVA5S0cxZ0wxdUN6a1pjVnphUXRpUWo0M3ZhZllabm1UMklicXZmaXMv?=
 =?utf-8?B?ekZDOUVoMHlISG9YVVBaUTVoV3hCbDlxdFhxN0doSmFFa0w4R2pnaUxGYzBG?=
 =?utf-8?B?S09Yc09MMk5ISXEwUGJ2emg5SzJpakJLV1duUHV0Y1N2V2o2YXdwS1o4bUJp?=
 =?utf-8?B?UFE1YkI5VWpSek8wRmVyaFRCT1JNdzJ3WXc5T29pODRRbG5kU2kwNXA3cWdz?=
 =?utf-8?B?OWsrT0NNUytWdXBUWkZKMGF6RkhzUU9mbXZ5VnpJVVhIVFB0VkR3K2liclNw?=
 =?utf-8?B?dzRsRzJKN3pCR2grK0lQUXVuWVJEOHZHVVNlaER4N2I1Z0gwRzFPY0NQMS9s?=
 =?utf-8?B?Ulg0STZwNXVZYmI0bDM5d1dTTjZvMlNGdXBja3F5Q3FLODNKT3V1ZWpCNzNT?=
 =?utf-8?B?d3VGSDFaUFdVQzNVbzNrajZMTDAwblE2bnNCMkZBSERVUmJJcm41SVlJSUNa?=
 =?utf-8?B?dVEvM1VzdWJOaWpJZVorU2laM0U4dXRpOEQ2eEE1eDBCUUhON2Vtdjd0bFNh?=
 =?utf-8?B?Wll2SVhONmgweVVHRkZhWTV5YTUxSStNakFDYkQwMzlMQitPSmFzeTVMMVd0?=
 =?utf-8?B?MnZFaU9mdkRpWCtKQXhtVm9vaENYL2FHNjNjdlB6MzA4TzlvekYvcWNtM2R5?=
 =?utf-8?B?K3dPTXZaUUt5R3VkTk1iOFpRYTlNa1pTUE5VdHNvVG00RUUzRy8rNUFFZnpw?=
 =?utf-8?B?VzNuMFNLd0U2Z3h6TG9OVmkzblFoeXk0Z1RDd1RJSXEvN2h0bTlndFRISjVF?=
 =?utf-8?B?VjZLdURqVWc0VzNWZEZETjhaUXVlYi9VaEo3Y0h2VGh4Z0p0b2wrdGZ4MlZB?=
 =?utf-8?B?Szh0VE11Q1YwNGpRSis5YTg2c0MyUlY4c0FqWG1sM0VjdFU5cUZydTliOFM3?=
 =?utf-8?B?MzVJMHpBQW0xTEFBSnNEZm45Ly95Z2VwRU1pa2F3RVFEaXl3VmttVFRCS21t?=
 =?utf-8?B?N2hGbHNQckVldUJXMjdVYXduRzdFVlg0b0RDMm52Y08rQVVUV08wTGRJQW1I?=
 =?utf-8?B?Q0xuWStqRW92cC9jdEtrOFBydWlSNk16MTFnS285bEthSDRkdXB3QUJUb0t4?=
 =?utf-8?B?N2YzTXlYNmhVWXJoMmlmNjZSZmtVOUhwenBDUXRkLzVoZUVRc28vRzZqZk9K?=
 =?utf-8?B?b0dsZ0MxZG1jS0xmN3hjNXRIdHd2QjEzRVNIMUR4RjRkRkoxWGM4SVNhUjdP?=
 =?utf-8?B?SG0yUnB6WXdJdlN3TXRlU0NRbWh4TFgrQ3pUR0NtWFdQSnkrNXFOdVdCOEtR?=
 =?utf-8?B?bjc1OFdEL0x4WW54ZEloZi9wUkkrSGcrRE1naVYwemcrSUJsd3ZaYzdHL2tG?=
 =?utf-8?B?b2M0ZjRkclk2ajFpU1EwL0Fnai9TV096SHJscDBiK2JwZjM2ekpQUCtocTN6?=
 =?utf-8?B?NXhrbnBKc2pOaDMrTzFGR205L2tZSFlHWnI2M2dKdlVXTWhtSjI0QjUvQWFT?=
 =?utf-8?B?Z0NONGIxZ0o3cGUvMWNuRzArdFVaV3IwTDRSeThodDBZN1pwTTBPVHh5dG1W?=
 =?utf-8?B?VnFaRGs4US9OZDRicWZyWlRRT2tKaHJOV05OaE9zSTdYZ0lRc3NadTRNVC9q?=
 =?utf-8?B?NDJUK0piSGY5UW9zZlVlc3lwSWtTTWNuK2JLOFdMQllxL2dYOGgwWklUeVhW?=
 =?utf-8?Q?LaOgC/VQrcKCLPlg3wjwHhk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B09B198DCA12D14DA8D317914FC19981@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd734155-2d13-4014-8e76-08dd10499427
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 07:43:54.8071 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q+dUZ+XaSu9H2rCgHharpwAmSYdU+Mjr0dk/LzopfzfG8ebUaSbagrDe+5Phw1asvGowcgxgafLFzDivAmN7JqFmTDD3G268hXtQWdH+LpqfL8BgHgiHP6NmtpmsxEm2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7847
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClRoZSBjYWNoZWQgaXNfbWFzdGVyIHZhbHVlIGlzIG5lY2Vzc2FyeSB0byBrbm93
IGlmIGEgZGV2aWNlIGlzDQphbGxvd2VkIHRvIGlzc3VlIEFUUyByZXF1ZXN0cyBvciBub3QuDQpU
aGlzIGJlaGF2aW9yIGlzIGltcGxlbWVudGVkIGluIGFuIHVwY29taW5nIHBhdGNoLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZA
ZXZpZGVuLmNvbT4NCi0tLQ0KIGh3L3BjaS9wY2kuYyAgICAgICAgICAgICAgICB8IDI1ICsrKysr
KysrKysrKysrKy0tLS0tLS0tLS0NCiBpbmNsdWRlL2h3L3BjaS9wY2lfZGV2aWNlLmggfCAgMSAr
DQogMiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL2h3L3BjaS9wY2kuYyBiL2h3L3BjaS9wY2kuYw0KaW5kZXggMTQxNmFlMjAy
Yy4uYmQzNmM1MjI3YiAxMDA2NDQNCi0tLSBhL2h3L3BjaS9wY2kuYw0KKysrIGIvaHcvcGNpL3Bj
aS5jDQpAQCAtMTM0LDYgKzEzNCwxMiBAQCBzdGF0aWMgR1NlcXVlbmNlICpwY2lfYWNwaV9pbmRl
eF9saXN0KHZvaWQpDQogICAgIHJldHVybiB1c2VkX2FjcGlfaW5kZXhfbGlzdDsNCiB9DQogDQor
c3RhdGljIHZvaWQgcGNpX3NldF9tYXN0ZXIoUENJRGV2aWNlICpkLCBib29sIGVuYWJsZSkNCit7
DQorICAgIG1lbW9yeV9yZWdpb25fc2V0X2VuYWJsZWQoJmQtPmJ1c19tYXN0ZXJfZW5hYmxlX3Jl
Z2lvbiwgZW5hYmxlKTsNCisgICAgZC0+aXNfbWFzdGVyID0gZW5hYmxlOyAvKiBjYWNoZSB0aGUg
c3RhdHVzICovDQorfQ0KKw0KIHN0YXRpYyB2b2lkIHBjaV9pbml0X2J1c19tYXN0ZXIoUENJRGV2
aWNlICpwY2lfZGV2KQ0KIHsNCiAgICAgQWRkcmVzc1NwYWNlICpkbWFfYXMgPSBwY2lfZGV2aWNl
X2lvbW11X2FkZHJlc3Nfc3BhY2UocGNpX2Rldik7DQpAQCAtMTQxLDcgKzE0Nyw3IEBAIHN0YXRp
YyB2b2lkIHBjaV9pbml0X2J1c19tYXN0ZXIoUENJRGV2aWNlICpwY2lfZGV2KQ0KICAgICBtZW1v
cnlfcmVnaW9uX2luaXRfYWxpYXMoJnBjaV9kZXYtPmJ1c19tYXN0ZXJfZW5hYmxlX3JlZ2lvbiwN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE9CSkVDVChwY2lfZGV2KSwgImJ1cyBtYXN0
ZXIiLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZG1hX2FzLT5yb290LCAwLCBtZW1v
cnlfcmVnaW9uX3NpemUoZG1hX2FzLT5yb290KSk7DQotICAgIG1lbW9yeV9yZWdpb25fc2V0X2Vu
YWJsZWQoJnBjaV9kZXYtPmJ1c19tYXN0ZXJfZW5hYmxlX3JlZ2lvbiwgZmFsc2UpOw0KKyAgICBw
Y2lfc2V0X21hc3RlcihwY2lfZGV2LCBmYWxzZSk7DQogICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1
YnJlZ2lvbigmcGNpX2Rldi0+YnVzX21hc3Rlcl9jb250YWluZXJfcmVnaW9uLCAwLA0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgJnBjaV9kZXYtPmJ1c19tYXN0ZXJfZW5hYmxlX3Jl
Z2lvbik7DQogfQ0KQEAgLTY3NSw5ICs2ODEsOCBAQCBzdGF0aWMgaW50IGdldF9wY2lfY29uZmln
X2RldmljZShRRU1VRmlsZSAqZiwgdm9pZCAqcHYsIHNpemVfdCBzaXplLA0KICAgICAgICAgcGNp
X2JyaWRnZV91cGRhdGVfbWFwcGluZ3MoUENJX0JSSURHRShzKSk7DQogICAgIH0NCiANCi0gICAg
bWVtb3J5X3JlZ2lvbl9zZXRfZW5hYmxlZCgmcy0+YnVzX21hc3Rlcl9lbmFibGVfcmVnaW9uLA0K
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBjaV9nZXRfd29yZChzLT5jb25maWcgKyBQ
Q0lfQ09NTUFORCkNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmIFBDSV9DT01NQU5E
X01BU1RFUik7DQorICAgIHBjaV9zZXRfbWFzdGVyKHMsIHBjaV9nZXRfd29yZChzLT5jb25maWcg
KyBQQ0lfQ09NTUFORCkNCisgICAgICAgICAgICAgICAgICAgICAgJiBQQ0lfQ09NTUFORF9NQVNU
RVIpOw0KIA0KICAgICBnX2ZyZWUoY29uZmlnKTsNCiAgICAgcmV0dXJuIDA7DQpAQCAtMTYzMiw5
ICsxNjM3LDEwIEBAIHZvaWQgcGNpX2RlZmF1bHRfd3JpdGVfY29uZmlnKFBDSURldmljZSAqZCwg
dWludDMyX3QgYWRkciwgdWludDMyX3QgdmFsX2luLCBpbnQNCiANCiAgICAgaWYgKHJhbmdlc19v
dmVybGFwKGFkZHIsIGwsIFBDSV9DT01NQU5ELCAyKSkgew0KICAgICAgICAgcGNpX3VwZGF0ZV9p
cnFfZGlzYWJsZWQoZCwgd2FzX2lycV9kaXNhYmxlZCk7DQotICAgICAgICBtZW1vcnlfcmVnaW9u
X3NldF9lbmFibGVkKCZkLT5idXNfbWFzdGVyX2VuYWJsZV9yZWdpb24sDQotICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIChwY2lfZ2V0X3dvcmQoZC0+Y29uZmlnICsgUENJX0NPTU1B
TkQpDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmIFBDSV9DT01NQU5EX01B
U1RFUikgJiYgZC0+aGFzX3Bvd2VyKTsNCisgICAgICAgIHBjaV9zZXRfbWFzdGVyKGQsDQorICAg
ICAgICAgICAgICAgICAgICAgICAocGNpX2dldF93b3JkKGQtPmNvbmZpZyArIFBDSV9DT01NQU5E
KSAmDQorICAgICAgICAgICAgICAgICAgICAgICAgUENJX0NPTU1BTkRfTUFTVEVSKSAmJg0KKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGQtPmhhc19wb3dlcik7DQogICAgIH0NCiANCiAgICAg
bXNpX3dyaXRlX2NvbmZpZyhkLCBhZGRyLCB2YWxfaW4sIGwpOw0KQEAgLTI5MTcsOSArMjkyMyw4
IEBAIHZvaWQgcGNpX3NldF9wb3dlcihQQ0lEZXZpY2UgKmQsIGJvb2wgc3RhdGUpDQogDQogICAg
IGQtPmhhc19wb3dlciA9IHN0YXRlOw0KICAgICBwY2lfdXBkYXRlX21hcHBpbmdzKGQpOw0KLSAg
ICBtZW1vcnlfcmVnaW9uX3NldF9lbmFibGVkKCZkLT5idXNfbWFzdGVyX2VuYWJsZV9yZWdpb24s
DQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKHBjaV9nZXRfd29yZChkLT5jb25maWcg
KyBQQ0lfQ09NTUFORCkNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJiBQQ0lfQ09N
TUFORF9NQVNURVIpICYmIGQtPmhhc19wb3dlcik7DQorICAgIHBjaV9zZXRfbWFzdGVyKGQsIChw
Y2lfZ2V0X3dvcmQoZC0+Y29uZmlnICsgUENJX0NPTU1BTkQpDQorICAgICAgICAgICAgICAgICAg
ICAgICYgUENJX0NPTU1BTkRfTUFTVEVSKSAmJiBkLT5oYXNfcG93ZXIpOw0KICAgICBpZiAoIWQt
Pmhhc19wb3dlcikgew0KICAgICAgICAgcGNpX2RldmljZV9yZXNldChkKTsNCiAgICAgfQ0KZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvaHcvcGNpL3BjaV9kZXZpY2UuaCBiL2luY2x1ZGUvaHcvcGNpL3Bj
aV9kZXZpY2UuaA0KaW5kZXggOGVhZjBkNThiYi4uZGU1M2E0NGFlOSAxMDA2NDQNCi0tLSBhL2lu
Y2x1ZGUvaHcvcGNpL3BjaV9kZXZpY2UuaA0KKysrIGIvaW5jbHVkZS9ody9wY2kvcGNpX2Rldmlj
ZS5oDQpAQCAtODgsNiArODgsNyBAQCBzdHJ1Y3QgUENJRGV2aWNlIHsNCiAgICAgY2hhciBuYW1l
WzY0XTsNCiAgICAgUENJSU9SZWdpb24gaW9fcmVnaW9uc1tQQ0lfTlVNX1JFR0lPTlNdOw0KICAg
ICBBZGRyZXNzU3BhY2UgYnVzX21hc3Rlcl9hczsNCisgICAgYm9vbCBpc19tYXN0ZXI7DQogICAg
IE1lbW9yeVJlZ2lvbiBidXNfbWFzdGVyX2NvbnRhaW5lcl9yZWdpb247DQogICAgIE1lbW9yeVJl
Z2lvbiBidXNfbWFzdGVyX2VuYWJsZV9yZWdpb247DQogDQotLSANCjIuNDcuMA0K

