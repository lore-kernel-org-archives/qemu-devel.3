Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA06C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 14:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRBnM-0005sy-Jp; Tue, 09 Jul 2024 10:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sRBnK-0005kn-Fv
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:26:14 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sRBnI-0002k2-Ms
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720535172; x=1752071172;
 h=from:to:cc:subject:date:message-id:content-id:
 content-transfer-encoding:mime-version;
 bh=qs1lwZoAnDEKngGz53ZyWtJ6SqlyIx8YSpXZvszOwMU=;
 b=kufsa5opOfaKuFhOS8z4ze/2uhZnvNu9KdiLuzNP2dEedRkVbYE92xiC
 lw5DIOL8bOnCKPvgm94Mag6XN6rpaprpp2tmQE53XYv4QqoT8YfwtCCro
 rBzhW36hNcD78CCAIlCa3KUWsrG6oYvtrAoGZLRvieIxW3Tp/x9GIf4eB
 2HUb9Zrx74oSrqZHnwitvhBi/NhrCbnSI9VTzBQOWaWQA+NbiV1GY2zWa
 bngLeb3NnJ6vVBpyXNFTKsoBHitNyxYMwJwWqeKOI0++mrMYnXYmJyoGo
 r4Lj8XaeAvgrtQzYvqwNiYK4bzvsbOwBxllQ3sz2e0wMMeUSv/3TgGnVH A==;
X-IronPort-AV: E=Sophos;i="6.09,195,1716242400"; d="scan'208";a="16172659"
X-MGA-submission: =?us-ascii?q?MDG3Fndzoz/TiZdLdSdrPElSQLoXp+IjKYOluW?=
 =?us-ascii?q?j06/idHD7dSVGyCxeyIyjpOZSipbKZJIXFEKw8SSXpROj0VhMT2PjT+D?=
 =?us-ascii?q?UMCFtCIIGtdQvxm2ios9l7f2XLRjcbUkxQHXSuA5AUeq/WS+55tbzTV6?=
 =?us-ascii?q?GgeWy7n9zfm/Th4S52BvcRow=3D=3D?=
Received: from mail-db5eur02lp2105.outbound.protection.outlook.com (HELO
 EUR02-DB5-obe.outbound.protection.outlook.com) ([104.47.11.105])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 16:26:09 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEblYKETNeh1C/qnzL1CUjvTWMA8DwgefdtQucdr/PmZuwTlhfLuirQd3opRS/ET6Nw4HI7lGJQ1BZCrgooWpcClHVMJeg15tsQ0OSSEGqsNhYOJ+Gbu9YXV7Dvh+yRfmpoZLaVRekx074CVGpLOpk6gy9qaBsxdWbbfFhqcKrZuozyHqCwI2oeYBIewQ4zPz9WO7Bbbxdb7f1jkpKHoJ7SbSx/jMeSffVyh5Zr9NSsE3QghzqGLdMi24nRAWv4tKiRQU9qt4QDEFbO/Gf3iEom19f2PzEp4l+aslaPobb+nOLRFanacmbwwEwKesm6REe0zhhwhlaNVsWvwKOPo9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qs1lwZoAnDEKngGz53ZyWtJ6SqlyIx8YSpXZvszOwMU=;
 b=pO16UvI7wpRxms4u+tqDWZbke49Zt18iCXgZ5erxCbeGfAQfSxo+48EkVht5daGUTsvtA5oXQ4Q8ETSc/7VunnoLNXo7I3kWdSYV+CHK0jBQSqLYZZzX9w1Lc0QvU47AmOFueloYDc2RqfYW6YhzagvEmSYSyX8C8YWXohjCOijytkkiQlYOClECVZUmOvRvWBQFuUwK8aKEiELNE+MF2YsXYzWTAeKPV9l+oZ06Hp+QAm1HBpKR4kUkP6pTn2MIyv5Z4UvtycXbzf3jVXTUMw074CyID49X/1go3BeWqWVb7c+nHlajliwuAAH6bEORW5/ulzuX+9yQpX+IiNVMww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qs1lwZoAnDEKngGz53ZyWtJ6SqlyIx8YSpXZvszOwMU=;
 b=Uj6yFVK4rLo7vNsGGk5ZbqekMTptG/v9Orhyp4ZrB1LZwCoIvnCXDI3y49twFQmVPeI1gKPzbpW9Ia6HBmIYVBevPsY9N8ErJ7TErlA5UPZcos4zHCFdKALwEBSba+wdUDaO6txx/i5PF32czCjF7sM+UN+STgtDZL4j2hhrrQ4POd4nHQZCTShRDw2E5IYkK3xClTO7gBbOGXrOK788oJk88NdNSYrjO4QwamcAddJLDs0O6q3KRHwCqMB2EMFzoK2P/SXAZulociY+M9H679slBWPd80tU3D3PfznVNSEenuv7dRcmXcrKOkCC/d3LMlcgLfRJwZwidBoFkd/0Pg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS4PR07MB8459.eurprd07.prod.outlook.com (2603:10a6:20b:4e6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 14:26:07 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 14:26:07 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH v7 0/4] VT-d minor fixes
Thread-Topic: [PATCH v7 0/4] VT-d minor fixes
Thread-Index: AQHa0gvviOR0C7Mtb0uxee8sx3GKOg==
Date: Tue, 9 Jul 2024 14:26:07 +0000
Message-ID: <20240709142557.317271-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS4PR07MB8459:EE_
x-ms-office365-filtering-correlation-id: f3abe533-9553-4774-89f9-08dca0231262
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TVZ4RHRKWEg5cE9sQTdFQk9icUl6MjhDNFZJYUpTQ0daR3BVcXpxYUZoa1Nu?=
 =?utf-8?B?RFBkTTE5UU1RSlBFWXpScSsvckgrUGxERjBEQmRxcnIzakhTWkkyUFd6KzEy?=
 =?utf-8?B?aW95RDRSL2g3K2Zub29mN09jUkdZRjJtSkRoQWtwYWlPT2ZFcWVnYmFMY3V1?=
 =?utf-8?B?REUxSEI5eVVBTzVDQVRlUFdRdTdhVXUvVGhJQ0pYREUyQkJ2TTdoYWVLTUpr?=
 =?utf-8?B?RTFjVkREb0I2V2lXQTZjWW5lWVRyeFUxWEE4dm9oZEFNN0pLeG5YaTFwdUI1?=
 =?utf-8?B?bWtzYVcrd3hiOXZsL3BYLzNBWHNnRlp1UWcwMVBPbUQxVlUyN05JdVF2TmRy?=
 =?utf-8?B?cmxuZXU1cHFSdlI0Q3pDbVo4Z2lNUW40TFBNTDVOeTJBWVRybDNiWE5RaUM2?=
 =?utf-8?B?cFVIRlhxSlhWKzJRM3piWHpJbW1EZ09xN0hobDFxczQ4d1A4NVoxQlBkWlFt?=
 =?utf-8?B?M1F1QnFabmtMdzNEYmtKd1JhOEhIaWwrUldRV1AxU0xiQ3JMNGMvMGtGVW9L?=
 =?utf-8?B?VlBta3lxQlVhNlhmSnZTU1dHNDVzdWdkOWhxSlFrTXRNb0x6U3UyTlpxYWVE?=
 =?utf-8?B?clFqTWVCNHQzQ0RpdXR2WjRYdUhOUnNXdzdOUnlTdzVqNFQyVXBjRVhjdTlv?=
 =?utf-8?B?dVNrQ0djUWpRS1kzTlZPelFwSTZreUE5aHdGMkZJV09maXZMYTNPNUZFVElq?=
 =?utf-8?B?WTBVTVJXbFFmeURkaDRtdk1SRnVkc3AyUTBYZG5EckdwcXpQMmxsRWIxOHFN?=
 =?utf-8?B?cjN5em0yTHJNWmJ5dUFpdlFPQVdFT1JZVy95bGVCSUw0U0JVb2dZYnlSK09h?=
 =?utf-8?B?eUVaNWJuU0UzOWdUMWUvUEQ5RG1KVE5PeDVnQzNOQWNRU0tyQ2FmSzY5TkJz?=
 =?utf-8?B?L1hNUnk4Y3Q0Rk9HTitmMHFVV01uSjlNYzBzUUxHMkc0WFZ2MEFBVU4yb05J?=
 =?utf-8?B?aEVZS3htd2JoZ2tpSW1wd2RjVmhiMHVoZE01aEIzSVZiZnZZNTBOZWFaaGhM?=
 =?utf-8?B?ak1DUmdOYThrUlFlcjg1Zm1TaE15VzhTRmt0NEtrM0Q4U3kwM2F6bHVlYWN6?=
 =?utf-8?B?dGpjYTdQR3E1UHU4MSthOFlwNURrTDdOQUZ2WUw0NGRNenJBV0ZTRnJHYlFN?=
 =?utf-8?B?WlBTeWxxdWdsbTM4VzJxc1pZOFFua2NEekwvbURuWEI2MDZvMU54eWlMTHQr?=
 =?utf-8?B?T25zazZFdFp0bmNuc2U1NGdHWnhuVkpMVDBnUWdjUzh4QkhoS25tM0dlRGhM?=
 =?utf-8?B?b00vNjJGQ1l1a0JrS3BKWUhycWpIaG5oSGlRTFYxRDBSekQrVzQrb29oT1B6?=
 =?utf-8?B?dHNEKyt5bXZDQ3NiKzN5bWxRYmRTS0hROWJucTBkYm5tZzYza0tyRENxZkVY?=
 =?utf-8?B?d0R0Znhwa0tjbGoyRTFnZVp0dTdsY0pmTjlJRk1PSzJzcUFla1ptZ1NNOG1R?=
 =?utf-8?B?ZlF5bDJyL1VLYzM5dlhJYno5ZjBwN2F5RE93VXAvc3F5U1A1eXVnNWIrcGU1?=
 =?utf-8?B?VjFmZGJ0cjg3bVl6bmZteFRNbnJ4eDlUZy9JOTJObmJzbFVMQ0ZKTGF6aU5n?=
 =?utf-8?B?Zkw5dGlMY3IzQ3FQWHBLbExFQXhkalloNjk3UlVvOXR1aTVTb28rUlZhZ3NB?=
 =?utf-8?B?Ym0weXRGSnc4K3RJY0RJeEVTOXg0OG5obVUvK0lqQlZ2S0puSmxJdWxKRFdy?=
 =?utf-8?B?bVorNnYwMmR6OHpKZHg0Yjc3QnBIaC9ibWd5V0pkcWxRTUFaQjRYQXZGZEpK?=
 =?utf-8?B?bFZGV0txUXVnV050RnNGVk9qTWp6c2t1L2xHaFNiVFVlL2NoUE9kNkVVcEhs?=
 =?utf-8?B?WWtEaG5pVTY4TCt4ZVQ1MVpMOEtmMXFac2JZYkE5V2MwM0dtM2ltd3NUYVZx?=
 =?utf-8?B?OGJ3aHhNenJxT04wTVE4ZDEvcGlzNnc1TkRxOE5sR1c5SlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1gvWnhWbVR3Ynh5dXFUYjhhOTNqdXFPMEhhU0pSb0IwaUtoVTZ4TlZFMFp0?=
 =?utf-8?B?OEVSTDBOeWFMbEErT3E3c1F2bDJadGZUdGg0QWN3bzVMZTU2LzhVSkQyUkx0?=
 =?utf-8?B?b1U1aDR1ZEN0NmVzUllkVTBJSTQvNVR4c1J5Qm5yWDZPL2gwaEVpL1R3VS9n?=
 =?utf-8?B?TXZTWjc0UDh2NVNGcUxmQ1oybEVsY3hxZGdSb1Rod09LWTUxdjU3TXhncEc1?=
 =?utf-8?B?bXlSb0RINjZhNmtpMFM5djhhQTM2dDBLcmNhVThTSmU1QURWN3RSeTFuUW1m?=
 =?utf-8?B?b2lNaTlYNm1EMVFBRW43Z0ptZFA0eFFYT3dWQnFqRVBLWlY5UVVrWTJuTTJ0?=
 =?utf-8?B?ZFIwUkdOUHdQN0lEalJKQy9PelY5UUtCdWcxdWNyc29jSEc2VklXVVRkOGpY?=
 =?utf-8?B?RlBLSmwyeWVKdWVGcEV4SkZ2MitjWlVBOFR4L2t6RW1YalZzYlh6Rk1ZVjdT?=
 =?utf-8?B?YjJYeFovSjZkOXpISUFZRUtzeDdBL3RrTXByNzBOcnFiZXNYaG45STQzemIw?=
 =?utf-8?B?T0oxZDRmM1FCeUFNWHd1elVXZHVlc2FqVy93TzUzdVJQMmRzeit6UjVscFk0?=
 =?utf-8?B?MzdWU1BTY2gyV1JvUkhrNjI1SEY2NkVTVXhoS295WFJ0SHNKM1JiN3YwRTFN?=
 =?utf-8?B?cWtVUEhoUUk5L1IrbDloNmV4bW1LbHRRK0lsbml3bnZQVHU0RGVQZ1JxaVBH?=
 =?utf-8?B?K2FmaFlDbjExVzhqMXZ1OFI2NjRCVHJOQzNTUGZEdlpDZ091anVMajVjR0w5?=
 =?utf-8?B?SlVENGpWRUlDTW55M2JpRTJWMW1ZczF3TWVrVk5UVVFQd1NERk9zYVFNeWcv?=
 =?utf-8?B?N0tzRVVrS012RDBPVVJBZWx2UTlseFpvYm9URTlFcnU4ZEZpdmFzL3pEZWkv?=
 =?utf-8?B?ejNaeHg5SWIvaGY2b2NOTndiQ3dDU0JTYm5sRW9pQTFBMTdGbDdUdmJGQ1Rh?=
 =?utf-8?B?RDlDL01sNGFCQXJTekJoUC9IY3FVUUtNcTVEcmlpejhxQ1NDOG80a1lZb1Jm?=
 =?utf-8?B?SElnc25GUzZ1ZzUwWHM5dTA0c3A2TXdNNjFPMEFGOEZkSHVVNVNZRTNYYkVB?=
 =?utf-8?B?RVh0RmRNR0J3d2RGN0JTOHdwbTM0QitXSTNOVi9jd013WG5BQW1zcHFsVGVK?=
 =?utf-8?B?SVNkMDlFM3EyNXdYM3hVVnBROGVsbnFXK2N5SUo3S2dHTG16TCtIcU5hTDVt?=
 =?utf-8?B?Z0pJVWlpanppZ1Z3MVIrNS9XTTFLOGVWS05kQXhDVlAzYmRlSzZlSDZ1N3py?=
 =?utf-8?B?bm1GdnUvSitKVjZGT0U5MjArQmZ4K2hMQXh5OHB3OXFycGpQZXZ5djJaNUYw?=
 =?utf-8?B?Q204TGZTYit6VjlReUl1VzZ5cHBjNEE5Z3EyNFoveG9zbHAxdDRKTVRtMVdx?=
 =?utf-8?B?ZmFNSTFOMm5NcVRJK2d2cjB0V0tONFFuN201SVdGTGZORy9EYTFnTnlJS2tr?=
 =?utf-8?B?Sy9ldW42TWlBNkpvakMxNmlhUHUzb0g2Y0djbHJsNTFTT1htN20wYWRpc2Vw?=
 =?utf-8?B?Y00xMDlxRjZncHora2N1VW1rc29jK2tlVjQ1MTFvNVN5dmxHSDBocmJMMmJF?=
 =?utf-8?B?Yk9RMndLUE1rekFrQm5FdHBRc3pBTTlVcVdzQS9xSFduUFozT2psTkV1WHMz?=
 =?utf-8?B?dzkyRXpwZ1VoamhHaEM4b2dTVFpnS0txSEJpWU8vYUVHaVMwSmdZQUxRMFhy?=
 =?utf-8?B?b0VEWjlvVGhCT1N0Y2hQb3FhOGFQOS8wR3VyUjNPek4vNzRFUEJsZXQweVND?=
 =?utf-8?B?K0VKZUtoelcyaFk1SS8wazFES2FuRjZSVndjZnRzOGhCaEdTRThjWGRGeUVH?=
 =?utf-8?B?UVZuNVpKelU4TVhUZGFNOHk4Y0NGbktieFpHMTVwSGJzUGh4Z2pEeGNtKytI?=
 =?utf-8?B?cXFJcXVVNjM3b0dUV1BCSnhVRjVjM24rU1JBU05FSlA1TVRtVlhoNEN6bEtQ?=
 =?utf-8?B?cTB3bk4rS1hQS2d2MmZERk5mWDRwSTllalRBSEpRSWNWMFE0dWFRTEZSVGJE?=
 =?utf-8?B?a3lDOU5xVmFndU82VGxzQ0J5MWNlb0RMZWMvdFY3eSt4amVKeHArMVQ1M05I?=
 =?utf-8?B?anNsMTg5ejNNYjVNaWd0eGJkT2J0MXMzd3FrL1hwT3cvcTNYUkhPS201Ry82?=
 =?utf-8?B?ckdoeGtQemc4UTNMUDdVSDRjaENCajUzRU5CdGxlRWFIQ0hORzNuRDgrY2V5?=
 =?utf-8?Q?XOsCITDwRorvBVmpAdtsE00=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10C89F8D1086CA469E09AD4090E231B3@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3abe533-9553-4774-89f9-08dca0231262
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 14:26:07.2075 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yNZhK3BRb6vhC8xnuFtkI4Pd1paH6y0UyeiI6zmJVEjrJpxkWRvRFHeQO6IC/8uxtf7s7ivu76Xm2TGj/a48c4VNXEYbweeMEq1PYGvaObDkmpEvJPj29T0VHorSm7Ls
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8459
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClZhcmlvdXMgZml4ZXMgZm9yIFZULWQNCg0KVGhpcyBzZXJpZXMgY29udGFpbnMg
Zml4ZXMgdGhhdCB3aWxsIGJlIG5lY2Vzc2FyeQ0Kd2hlbiBhZGRpbmcgaW4tZ3Vlc3QgKGZ1bGx5
IGVtdWxhdGVkKSBTVk0gc3VwcG9ydC4NCg0KdjcNCiAgICBpbnRlbF9pb21tdTogZml4IHR5cGUg
b2YgdGhlIG1hc2sgZmllbGQgaW4gVlRESU9UTEJQYWdlSW52SW5mbzoNCiAgICAJLSBFZGl0IGNv
bW1pdCBtZXNzYWdlDQoNCnY2DQogICAgaW50ZWxfaW9tbXU6IGZpeCB0eXBlIG9mIHRoZSBtYXNr
IGZpZWxkIGluIFZURElPVExCUGFnZUludkluZm86DQogICAgCS0gQWRkICdGaXhlcycgdGFnDQoN
CnY1DQogICAgaW50ZWxfaW9tbXU6IGZpeCBGUkNEIGNvbnN0cnVjdGlvbiBtYWNybzoNCiAgICAJ
LSBSZW1vdmUgZW1wdHkgbGluZSBhZnRlciAnRml4ZXMnDQogICAgDQogICAgaW50ZWxfaW9tbXU6
IGZpeCB0eXBlIG9mIHRoZSBtYXNrIGZpZWxkIGluIFZURElPVExCUGFnZUludkluZm86DQogICAg
CS0gRWRpdCBjb21taXQgbWVzc2FnZSBhZnRlciBjb21tZW50IGZyb20gWWkNCiAgICANCiAgICBp
bnRlbF9pb21tdTogbWFrZSB0eXBlcyBtYXRjaDoNCiAgICAJLSBFZGl0IGNvbW1pdCBtZXNzYWdl
IChzLyJtYWtlIHR5cGVzIG1hdGNoIi8ibWFrZSB0eXBlIG1hdGNoIi8pDQoNCnY0DQogICAgLSBN
b3ZlIGRlY2xhcmF0aW9ucyBvZiBWVERfRlJDRF9QViBhbmQgVlREX0ZSQ0RfUFANCiAgICAtIGlu
dGVsX2lvbW11OiBtYWtlIHR5cGVzIG1hdGNoOg0KICAgIAktIGVkaXQgY29tbWl0IG1lc3NhZ2Ug
dG8gZXhwbGFpbiB0aGF0IHdlIGFyZSBub3QgZml4aW5nIGEgYnVnDQogICAgLSBpbnRlbF9pb21t
dTogZml4IHR5cGUgb2YgdGhlIG1hc2sgZmllbGQgaW4gVlRESU9UTEJQYWdlSW52SW5mbw0KICAg
IAktIGVkaXQgY29tbWl0IG1lc3NhZ2UNCg0KdjMNCiAgICBGUkNEIGNvbnN0cnVjdGlvbiBtYWNy
byA6DQogICAgCS0gTG9uZ2VyIHNoYTEgZm9yIHRoZSAnRml4ZXMnIHRhZw0KICAgIAktIEFkZCAn
LicgYXQgdGhlIGVuZCBvZiB0aGUgc2VudGVuY2UNCiAgICANCiAgICBNYWtlIHR5cGVzIG1hdGNo
IDoNCiAgICAJLSBTcGxpdCBpbnRvIDIgcGF0Y2hlcyAob25lIGZvciB0aGUgZml4IGFuZCBvbmUg
Zm9yIHR5cGUgbWF0Y2hpbmcpDQogICAgDQogICAgUmVtb3ZlIHBhdGNoIGZvciB3YWl0IGRlc2Ny
aXB0b3IgaGFuZGxpbmcgKHdpbGwgYmUgaW4gdGhlIFBSSSBzZXJpZXMpDQoNCnYyDQogICAgTWFr
ZSBjb21taXQgYXV0aG9yIGNvbnNpc3RlbnQNCg0KDQoNCkNsw6ltZW50IE1hdGhpZXUtLURyaWYg
KDQpOg0KICBpbnRlbF9pb21tdTogZml4IEZSQ0QgY29uc3RydWN0aW9uIG1hY3JvDQogIGludGVs
X2lvbW11OiBtb3ZlIFZURF9GUkNEX1BWIGFuZCBWVERfRlJDRF9QUCBkZWNsYXJhdGlvbnMNCiAg
aW50ZWxfaW9tbXU6IGZpeCB0eXBlIG9mIHRoZSBtYXNrIGZpZWxkIGluIFZURElPVExCUGFnZUlu
dkluZm8NCiAgaW50ZWxfaW9tbXU6IG1ha2UgdHlwZSBtYXRjaA0KDQogaHcvaTM4Ni9pbnRlbF9p
b21tdS5jICAgICAgICAgIHwgMiArLQ0KIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8
IDYgKysrLS0tDQogMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQoNCi0tIA0KMi40NS4yDQo=

