Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808F8C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0jX-0006cL-9i; Mon, 03 Jun 2024 01:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jW-0006bj-1J
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:59:50 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jT-00070x-KQ
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717394387; x=1748930387;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=S5v2LajcwCAxqit1K5GGaK+F/ETgt7e1xSPiPh6VS/s=;
 b=sNlNfVGiHXqUHVlp/kMH0CtBUbC6YJZNzflDVlshgkdAaa1Xi8H307/c
 t6FJgGpG2og+e/NwFiwbwC86gEXIMO+BP/8K4jNjo+u+wpjHWo9PInZND
 Sg0Jd1vtLVKLL/hEYiCG9rS4PPfVQmpJJZI2n742iCPJJ5NceFRXB7QZk
 9kgPDUYovCMtmGsXpgC7elTBYw7frvl6yY2GMp4k51St6gahduhzNslkk
 h9GntLdZpR4UaYE1rZxFivaXp/yYBxWOxAdEW4kjzuZFWXp5ve6eWSugz
 rN6uL6iNdjd0/k5ZMoY+6BqiKpkyCjhG1nK65V4fd+l/bOnGVVWTL89gP g==;
X-IronPort-AV: E=Sophos;i="6.08,210,1712613600"; d="scan'208";a="13815870"
X-MGA-submission: =?us-ascii?q?MDGllue0+6Hs+LKhCB7wXGGRUxeGB/JfQNCbpI?=
 =?us-ascii?q?qQX3u0wDfrUSmnlyrc6+8/BTxDp5+AX5yb+y5d3VMkiHBJJaUKEpiMIB?=
 =?us-ascii?q?YQnSg4EjYCsDWidNt8THWSnTRHIxgtwqpz2d6X5lUFjQ+NDW6ShKCeWf?=
 =?us-ascii?q?uCnVKtZBMhSnZ7cXVNKVLwbw=3D=3D?=
Received: from mail-he1eur01lp2050.outbound.protection.outlook.com (HELO
 EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.50])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 07:59:43 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYlB7NXk5mWmgipxECiLj3rmkPqj1j3bzjlIg0UO60OrWLRD/UXtfUbdz3LJ0XMfXX4EMoH6EhuwF2Ftd3vfN6rj7bsks5a046+D9XLzPUvINJrhw9AxK4WbIfBb+NGDyBmN/9UsJ2wBuGFa+gfZZmZ3nTGafbhqSPRpaLjJYlYBfc7IYVgQvpsz8nXkTjBFXSrvVQwu/wxt5K/HlaM2Jz8FUrbaEjqvSnNLLvK5Pqgf0Kgaq+MOpP/rNQHjgx//5r8Ma9/z8/0UwI5IsK81B/0jozovdHZEGQzLHlXG7Vz74cCYc+2KlW+k/ANehXr9xivXL78tOUL257V16/tz9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5v2LajcwCAxqit1K5GGaK+F/ETgt7e1xSPiPh6VS/s=;
 b=GZ02WCig/skTNIC440oWDEfxePnpo3A+531x/Xr2cB9RB3ocHbV+6PmoYESTswOsbtzQHVlC9Gx4T6Bs++Lpn6NJaRSjD0GdPiIpcN2Z13TtuvmEiLQM1RSQy17qlMT/rqhV4Fgz4/1qr4BkkbeOTNv1eRoArie2LvnUdRoVkS6iQZhb9SthUt4DQgHpNbt/3IjpHnkkJauPDPsj/YnsTPoEiV4Ff4EB7uoDCCpS3IVsaC0wgdVn4ZbNGTQdd6p3GsxPbebNhUAPZFlw8EXDpNO8G09ZjaoXZMaB5DEWG1Py38NeIA48EEEpSckpx+smfU5NJYeq6PH9M1lEv0ASLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5v2LajcwCAxqit1K5GGaK+F/ETgt7e1xSPiPh6VS/s=;
 b=A+oAs6mk/u7QyYmDpT1FKli+gZq0gfIf0IMt9pkxOLa1VEhQAoxmpOVXLK/QVwMF9nBfYXRdnSmR96I8dhO1Hr+IybyZCNsExWD9ZmsjiMWrEgaibQQ6FR2BsIGBgPMbMD2nptWRYmwRmyCtEW4DstMHM8JROr4N5BvdNLgwbg9JaavD9GHXHGqCSYVJc908IoR7v/f6oJFKcA8EOwrQnKx+pg+MCoffS94u3eZfqNNXi2C5OelBZGg9Jkjg7JI0vd3QoOekQiHHhV3H2NGaH5Mft/cLuI0KzHanjXfCfjgtYtkUZZeVu+JT9cFrU/JEPcrqQmL8hO3+GBTSBwKdjQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6238.eurprd07.prod.outlook.com (2603:10a6:800:136::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 05:59:41 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 05:59:41 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 02/22] intel_iommu: make types match
Thread-Topic: [PATCH ats_vtd v5 02/22] intel_iommu: make types match
Thread-Index: AQHatXs5E6voFkhgJ0eF3xAba32ANw==
Date: Mon, 3 Jun 2024 05:59:41 +0000
Message-ID: <20240603055917.18735-3-clement.mathieu--drif@eviden.com>
References: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6238:EE_
x-ms-office365-filtering-correlation-id: 9b99948a-8874-489e-53bb-08dc83925c4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NUxGNFdjQVZXREhiZjFqRndjaTZUL3o0MjFNNmovbTcraWpFaTlwTGdiTGZ3?=
 =?utf-8?B?Q1lKZnBoWDBjY0YvSzlFMDJrVmtsZ2hZTXpzT1UzeWozQlFYM0VOV2V5NEZi?=
 =?utf-8?B?WmRPQXpxeDI1di9XY3g2eHQycnlzNm1EVE9ubVNjRzRsSUI4WTJWWkRFWVla?=
 =?utf-8?B?ZVBFNFhiQkIzVWx2UGlnbzVKdTFuZzJuc2RqdlJCTUVXd2VHSURxakhtejlo?=
 =?utf-8?B?S3VWUnh2YVBTT2NkYVpIU1lNcjMyNkVkTSs3VzBUVzhxWDdETm5UbTErOWZx?=
 =?utf-8?B?eTNTR01qVVlZaFN3SStZRmovblpkNXIvcE9XeG16dUtsNElscmdvVWxCWTFp?=
 =?utf-8?B?T0M0Qit3NlBBT01EdjhJdzhtb1N1THcxc3BBV1h4QnRjWjB4enRjcE93Skpx?=
 =?utf-8?B?RTdZOCtXSEtiZ0RaSGhkU2xiQzdJUTRkRzEvRGpnTkpuSmlnZTd0ckJZVDRL?=
 =?utf-8?B?OWJpWVRWZnMwQnlwb3o2RVBOKzlaNTlkQ2E3OGg3VVdhNHN1bEhzVzh0L0Vh?=
 =?utf-8?B?TjlIaFZWbzUxMHlxTHhQTm1xTUp5b1hFazZJT3d0Q2c2aGxnUTNEeUUzYktl?=
 =?utf-8?B?TC9GQUZjdlZ0bW9WZUlhUDNpczA1TlJlbU4yMWJJS0dHWFd4UDRPcExNaGRN?=
 =?utf-8?B?RnZRL2tSc3dnS2ExWjNWWjNLT09rVEpzaEpzUnZvR2hvTzBDSEM5RzZ4QVBS?=
 =?utf-8?B?YUdnSWE4MzNvVGsrNElsdFprbWdnRStuTi9vVHV0TjZFWkpvNFNNdTlrVFpX?=
 =?utf-8?B?MlFGM0oyZEhITXFRaEdLc3RHcG9nOGNxckR2YmhJb3M5WDdXV0NDeHdSRzVF?=
 =?utf-8?B?LzVSUlpSYjNFRGJ5SmJmdTJ5czNHdzZsQjB5UE1tOFR4Qk9mcXJFMGlOUUNS?=
 =?utf-8?B?VXdqZTJWSENiWHlnTlM1RFhsNGxGVkU3TGJSaFJmczU4cmpWcHJHbkRUR3Rj?=
 =?utf-8?B?TXBQTXkrYmpKUWdZRy85SzlCTStjR1d2Wk5aUEthQ2dZTVQwS0gzd3c3VlBz?=
 =?utf-8?B?YmZReVhKbUdFRUlyQXRLMGNCR0ZIeUlVZ3NLLzNoTzhPd01TTHJsMEh3Ri9m?=
 =?utf-8?B?WTJLRlU2dFZVemJzazV3NzJPLzdVRk9sRmJMaXR1L29KQkM5SkVEWks0bHdR?=
 =?utf-8?B?bzV6TS9aS1VsN3I4OXgyM3Z2UkFERjYzMGJiVmtIS0ZzMGUrWUR2dVdxZkNv?=
 =?utf-8?B?ZkVSalc3ck4zTVBhNkl4SGgzV09sczVvTGRYREk2d05lR3N3YXpkSWd3alN1?=
 =?utf-8?B?N284Ujlrd2JJc3NabDBXek42cFk4aTZPQ3JqbFpITlovWmp6S01LWVFUMHBp?=
 =?utf-8?B?WUJCV3hSc3c5a25xKy9sNVBTZHpORVBSS3ZxY1E4bmd4N1RvMTJ4Q3R2dzQz?=
 =?utf-8?B?Tis1cEdnMzVVdjZuaXIvNVEyNEd0eTNpN3gxRnRyNmQvMVJuUjFtOEF1TWxQ?=
 =?utf-8?B?cmltUS9SMGJtTkxzaDAxVG9la040dXpmSG5RUjRtUFNDS01iYmpDVm9pVVVR?=
 =?utf-8?B?Y2NjMHk5Q0hZdi9pd0llaGtlaXNmbG1CYWcwNmxwSlBKTUY0VmxreUdxOUJt?=
 =?utf-8?B?aDRrVEpETzluZEJhZzlONVEydnFmbVpsRjhsS2FFeWcrbmt1NFIzMVRGREVZ?=
 =?utf-8?B?bXJNd0NPdUcyblZ1M2dpcWd2SVZVY0tDOVViM09RY2ZMYk1HK0VSL2VFWW93?=
 =?utf-8?B?bFMyVi9lWk9HL2lWWmpWVjFYUG9lY1E5aEFxZWRYSlJtajF2bEJ5dW5USzBS?=
 =?utf-8?B?Nk0rNko5Q1htOThhYWhocXgwdGMrN1hlMFY5SFNraWpxcU9qbGM5R0h5Z3lL?=
 =?utf-8?B?K1JnTHU1UlRZTlFUQXJ0dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFlUcVdOdFZQYzV6M0d3c0pXWE41MUwvTnJIZEVWM21vVFI2ZUNGUml5NXJ2?=
 =?utf-8?B?em1CVG1sQkFqVi9oVUEveFM5c3lmVFN3NE9BZzJFOXZ5TWI2NDkyeUZOOFFq?=
 =?utf-8?B?UzBpYWhGZkxRZFoyMFNVdDdyb0tMSk1kZ1lSYm5idkpNcStCUENDZGFTSU1Z?=
 =?utf-8?B?Y0tNT2pzSm9aVTBrRHNxWHRyN05QaTZ1TDI3Q2pnb0YydHI1L1BoU25YYjFu?=
 =?utf-8?B?VlZSc3hyT3hYOTBaMzl2a1JHOTIyM1ZydFJNSFEvRTdFZ3ptdjVUUmJWT3Fi?=
 =?utf-8?B?RFlhTWRZVHo5ZGI1ckZNOWNDRlRJK3pMWFZkTVNkdDNIcTBsNDhOOWhxVUJL?=
 =?utf-8?B?SFB6bGZGR21nU2ZzTC9ycm9BMFNLcENEUHlOK2hpbndSclZXdG0zOWZJWGZm?=
 =?utf-8?B?dXJMeTJocnJnRWQ2ekdCZW5jM3B3Tzl4S0x2dER3Tkl5cDJGUmdDcEk2aHVO?=
 =?utf-8?B?eDJib2l2MGEzSlVrc2NhUGFWWCtROTAzMk81YlQzUXlyTk9uSUhDZkRXQTg5?=
 =?utf-8?B?MXg2Vkd4T1F6QUI2TzJScU1xb2dBNlB6RmpqZkZLQ2NRM0xjTGtEVnRtYS9Z?=
 =?utf-8?B?YXNvMERwbTkxUmZuR0puVWk5TURJaWlGV1Jacm9GNVkzUkdkN09JckYzajM3?=
 =?utf-8?B?Z2R6ZHE3SitwQkZuU1NPVWlZQXh3b0k3UlNUK05KTzJudnZNOHRmWlkxdkUw?=
 =?utf-8?B?S1M2bDJuSDBzbzcvQlE3b1l0VG00M25GdDczaXA3WHdPNGt4ZlVuV0pHSVZX?=
 =?utf-8?B?M2l6ZnJ1Z1lBeWRoZ2lmMGJCLzNYUzRDNW81UkVNU2FjVW1pU21LemRFSTda?=
 =?utf-8?B?ODlNcEtGamVFdlhPY2VDVkxrVTk5UndRSHdHSW15RG1IOHZiTHpOU1ZYREpG?=
 =?utf-8?B?UDZyVTdhNWZZRGd1OTE1Qk1PRHhPSG9SUnh1Ry9CdCs3cWdWdG1nYTdnNTBY?=
 =?utf-8?B?djB6L2VJanRCZGQxSXhveHpyR1QxKzlWRUtQQng0Y3pNK1FITC9SNGR4ZTZy?=
 =?utf-8?B?MkVWOU9keHpJMUV6UlNkaGp5QnlBekJ2UEVuN283VnR0Tm03RXFPVjJuRWcy?=
 =?utf-8?B?NDVOSWhMRHQ5Ykp0M08wZTRFVjg2MFJsQk52ZjVBQ2U5dWc4aFRJM0dKeW4z?=
 =?utf-8?B?bHJoVkFyeHpvaHR1MmtNSGpzRFhlK085U1ZaQmN3RXhNRUJOaHhTS3JhNlFO?=
 =?utf-8?B?MHVlVXRYY3ZsSWRTN2lCNG85TzVTRWpUTWNPaWdBNE1WcTJHdWlWdlI3UlNN?=
 =?utf-8?B?TGYzT3JrN3BDbkNYY1ZERmEySkVOVis3SkRoWkl6dEd3UTF3ZlRmSGhReDdQ?=
 =?utf-8?B?MjVWY0h6emdqZm83QitoSmVsMGFhMnNnc1kwMkJ2bU0zQmdGbTZ2eEVSdTRS?=
 =?utf-8?B?NFI0OWtDOHl4WG9VekxWR0F5cVZuRGc3bHBrcUxjeVh4M1pxeStXbkYyMXlQ?=
 =?utf-8?B?NUJNWlhETllzWUd1bVdFQVNTT0lxTCtIVVBzTzU1VFpDSU9DRlhiRmpDL21F?=
 =?utf-8?B?anZaUy9EdHhQbmtkUlhBZGdxU2tMWm55cnF4cU9KcTh4V2hvc0kzVjdueHh4?=
 =?utf-8?B?NU9TMEQydVRYKytEY2I2S1BobGNqQk1Ic0Q3NExqN1VpYXlZY0NjdWNtSzd3?=
 =?utf-8?B?RmlWcHFscVh0TmF2dkhEbVplVERlWHd0dTBHVlNWUEZadkZSb1cxUHJQU3ZT?=
 =?utf-8?B?RldFdElDRHZjL1lFSXRvcjRXMXBQaEN2MExpQU1sM3dSU0hFcCtDSTZLOHlt?=
 =?utf-8?B?dXBYSzk4TVQycFJkaHZNMXRvZThnNU1uNmpES0k0WnlMVmdqWis4S3NJcmVN?=
 =?utf-8?B?cFQ1QnJFZVNCN0VkRkZCaUYzWEdEL2dOVGdtQmVIRjdjWDlDcElVc29TaVlh?=
 =?utf-8?B?ay9INXRaWEc3a2dydDg0ZDgraUgvZFhkQXRqQklwemtuYm1TRWhhTVJ4bXB0?=
 =?utf-8?B?SW5uMFRlN0hvQ09CWEVPdXF5Z0JsU2JHTklDd1IrdE9PcEtXdTB0MXZ3ZzV6?=
 =?utf-8?B?Nkx3Wmt4bDFncnZneDRzRTFwY2c5NmxLYU5YTW1iMnhERTl3am9DTndISGxH?=
 =?utf-8?B?YWRCVUtuWmZ1Q1lVRVhHMXhkVmE0SW5idTVibE5vbzJwNkN2eWU2SHVEZ0Ir?=
 =?utf-8?B?MkRTQ0dTTWNBaUhmNVN1OTZndnVaV3NzdTBlVlJaUWFYNmRRVjJSNnBLNW0x?=
 =?utf-8?Q?Hy08hdBMV2ghGcfnEhNzsmQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9141EAFAE0DE124FA6CAA1FE14C67B81@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b99948a-8874-489e-53bb-08dc83925c4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 05:59:41.6296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m3x0ZFedFXNSxXwXimWw1GqAFyfZvF/RrFfbBINmdleISVK3QfJNngN3lNpAiVvvta/4+XKCXPc+d9vv0CEF3Tcn/c+7U/bOpoytpRmebWKqe+t/pYJAi9r+6iZs7cjI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6238
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
bi5jb20+DQoNClRoZSAnbGV2ZWwnIGZpZWxkIGluIHZ0ZF9pb3RsYl9rZXkgaXMgYW4gdW5zaWdu
ZWQgaW50ZWdlci4NCldlIGRvbid0IG5lZWQgdG8gc3RvcmUgbGV2ZWwgYXMgYW4gaW50IGluIHZ0
ZF9sb29rdXBfaW90bGIuDQoNClZURElPVExCUGFnZUludkluZm8ubWFzayBpcyB1c2VkIGluIGJp
bmFyeSBvcGVyYXRpb25zIHdpdGggYWRkcmVzc2VzLg0KDQpTaWduZWQtb2ZmLWJ5OiBDbMOpbWVu
dCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCi0tLQ0K
IGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDIgKy0NCiBody9pMzg2L2ludGVsX2lv
bW11X2ludGVybmFsLmggfCAyICstDQogMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9o
dy9pMzg2L2ludGVsX2lvbW11LmMNCmluZGV4IGI0YmJkODM5ZDkuLjkwODQ4NmM5NTMgMTAwNjQ0
DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCisrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUu
Yw0KQEAgLTM5NSw3ICszOTUsNyBAQCBzdGF0aWMgVlRESU9UTEJFbnRyeSAqdnRkX2xvb2t1cF9p
b3RsYihJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQxNl90IHNvdXJjZV9pZCwNCiB7DQogICAgIHN0
cnVjdCB2dGRfaW90bGJfa2V5IGtleTsNCiAgICAgVlRESU9UTEJFbnRyeSAqZW50cnk7DQotICAg
IGludCBsZXZlbDsNCisgICAgdW5zaWduZWQgbGV2ZWw7DQogDQogICAgIGZvciAobGV2ZWwgPSBW
VERfU0xfUFRfTEVWRUw7IGxldmVsIDwgVlREX1NMX1BNTDRfTEVWRUw7IGxldmVsKyspIHsNCiAg
ICAgICAgIGtleS5nZm4gPSB2dGRfZ2V0X2lvdGxiX2dmbihhZGRyLCBsZXZlbCk7DQpkaWZmIC0t
Z2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oDQppbmRleCAxZTM3Yjk4YzY1Li5jOWE2NzM1ODVmIDEwMDY0NA0KLS0tIGEv
aHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQorKysgYi9ody9pMzg2L2ludGVsX2lvbW11
X2ludGVybmFsLmgNCkBAIC00ODgsNyArNDg4LDcgQEAgc3RydWN0IFZURElPVExCUGFnZUludklu
Zm8gew0KICAgICB1aW50MTZfdCBkb21haW5faWQ7DQogICAgIHVpbnQzMl90IHBhc2lkOw0KICAg
ICB1aW50NjRfdCBhZGRyOw0KLSAgICB1aW50OF90IG1hc2s7DQorICAgIHVpbnQ2NF90IG1hc2s7
DQogfTsNCiB0eXBlZGVmIHN0cnVjdCBWVERJT1RMQlBhZ2VJbnZJbmZvIFZURElPVExCUGFnZUlu
dkluZm87DQogDQotLSANCjIuNDUuMQ0K

