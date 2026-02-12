Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECABBEE36B2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 18:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqb5n-0002xl-I6; Thu, 12 Feb 2026 13:07:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqb5l-0002xD-Gl; Thu, 12 Feb 2026 13:07:05 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqb5j-0008IS-Lx; Thu, 12 Feb 2026 13:07:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pi/50B30xu5hTZgFRt9hTPN3dyAvLq7QGYA5MTk5EZft0YGemJ3P0Tglk7rnT8htTg3uGr8++iLkvITv/9jH5cYH1HvV1STSfRr6yHC69e5zQNn6MdM1hrGkckuw6/0voIdUq/cwsLOjuUWhxhgZXmG7VN5947lyji8R3Q1cMF0eAPlGRr67TPla3AMuATFYv1BfQOSUbRYoml3HiaK41RS7HnY2vFPUqb2hJQ8NlCKcN4lnbEOiqFvVrf9qUbp/JuXhxc4RJCTwLMSLXnFNiFzyYvGJVvw0Path8u6Jiep8ZUfcQFqNkQ/q+0t05+SM5Q61WFLzb9u9/3dvrBbLLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFckBGr6ptH4IbNRmy8KBOVmDd9dH9UFCEUVgTFu6DM=;
 b=u+VKojcOxaQ6flVKthgpcDJriJpAzz7YXAJtSeDEtRYkq3nTtuVPGB1uZbUtulhpDuQ/7KeITOrFhY6nVwCJaNoIiWcwcfGDpAGHtin2FyKiT9fnfz5k2U7lOF01XIL9wDltomwi7hmWXcKF6s99ui4K1f8YtCGv64Y0i1yFtnTsR81o6vgPC14ocgj0Bvn+HPRalBvUe77CT80eBjMoZTWgFUlbOHTtDpAlOFGHcvK1fmBMV4Vu8KqKIIw1gI2Sw+oWfLwIrjGEcCCraFI+tL6gAukmPnxz5kLvLhGdfsgvvDOk/52hZKxwueQXpDOKvJbUagBmTCSd5hSDlkNyYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFckBGr6ptH4IbNRmy8KBOVmDd9dH9UFCEUVgTFu6DM=;
 b=kU2J7VosM0b4eQgNi1g6l1kdWDee5unP1pApYLk0lW8+kmpQnmglz+6K+jIEHsD80Z4449gNm9GM+P8LKT5CtTjvyPBDZjTlz/asqC3Ce/Xr7+D0ze9YWlwAwiEUTRiBhUsCKHp6hQaQk1E6AZaIPUsiXUz5mW/1S3kD8ORGZ8lmeApuJq1msRp6f8a5V0xWbCe7772JEq28hMbYm/J1Zu/+iusEiyqegw/hZwrInwVFUENF/vFuuXQJsZIHfELE/zjGnoFqzBrnrArFyef4W+pFQvRqkPW13Sc8DhNVuHLKTXx+O6fPr+qwDFcjM+mPBAp2IL0AtwQUFtPPHqXY3w==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM4PR12MB6470.namprd12.prod.outlook.com (2603:10b6:8:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 18:06:56 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 18:06:56 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v5 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Thread-Topic: [PATCH v5 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Thread-Index: AQHcmzFk1Etk+2u8DkWzxKPQ5vkZXLV9zEoAgAAB5gCAAALtAIAAA6kQgAAIBQCAAMFggIAAA8GAgACf5JCAAA01AIAADPkA
Date: Thu, 12 Feb 2026 18:06:56 +0000
Message-ID: <CH3PR12MB7548C15908608231158777B9AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260211083415.133534-1-skolothumtho@nvidia.com>
 <20260211083415.133534-4-skolothumtho@nvidia.com>
 <aYzFeMh1szhJlJJk@Asurada-Nvidia>
 <e66e82d6-0953-49f0-9d84-bf2776e8f3ce@redhat.com>
 <aYzJhEFg/zxtrJ8z@Asurada-Nvidia>
 <CH3PR12MB754855AE35A087B900B0C311AB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aYzTUDmTzIZZCwnW@Asurada-Nvidia>
 <39acf072-3227-442b-acfe-658829071917@redhat.com>
 <aY14rcVQuLs3ugll@Asurada-Nvidia>
 <CH3PR12MB75482F20A549CD3D480226E4AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <db4a1b89-aae2-4328-98b1-5233283e9351@redhat.com>
In-Reply-To: <db4a1b89-aae2-4328-98b1-5233283e9351@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DM4PR12MB6470:EE_
x-ms-office365-filtering-correlation-id: 47365c40-d61b-480b-6bf3-08de6a61824d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?T1lqUE1FQkp0VWlCc0JGUmlXWnFqTHN4M1JoSENtc25VS3EyTHFiZFRPOHQ1?=
 =?utf-8?B?b1oxR25jNDYvNGN0TUNjdUluS0pwZDRnSHpkYllXMjBBbGxlM1pnTml2a0F0?=
 =?utf-8?B?ZzByemZzRU1oN0ZrZkJTcWFwbXBzMis1NmVNcmI0SFhQZVVUdEoySFN2Q0x5?=
 =?utf-8?B?WFg0NTd5bno2QVB6TjJBaFNsSThQZzdFbTMrVzlsdVFEdVQ4VjFpdEJ3ekFW?=
 =?utf-8?B?YkFUMEtvb0Q0UjRTOVd3YmxLTWtXREg5TnV6TzRSbHNnamFzM0RuY1BQUXo2?=
 =?utf-8?B?c3d6MXFodHZYZ3IzRmtjVDZYUnJyaGhzMFkrbDFZL0xaalJ2THROcFFFUUdJ?=
 =?utf-8?B?RVhqYmFURGgxVTFOVkwvaVZmVEJFZllGNnMvOHRIbkZRd2pzQ1RnN04wYld2?=
 =?utf-8?B?d1RubmVyMmNrb0hXR3dSWE0vWStiU1pUMGJiaHdiVG4zb3l2QzQxTFA3ajhx?=
 =?utf-8?B?M1M2aFZaK3h6VjcxL1dqc0xJS0YwdjloQnh4QVdHVS9VSlRJK2tDZWs3cWdP?=
 =?utf-8?B?eEJPVDh1TjAyS2lUS0lNYkRJbkU1VDNqWm1VbFNOZTFCUk9UZGRSd2FJQS9x?=
 =?utf-8?B?eG1nV3VQSWdwY01GMXJkZk5VVE5Sck8xVERSWlhHY3pBUHZJQ2Z2VjhVWHJX?=
 =?utf-8?B?SGZQZTQ2YWpXeUhmSUhLNUY3TjVldjdrRTVIVWh0YjBMajZxKzRvcUhHTlVS?=
 =?utf-8?B?ZElpaytzWUljamFBL3AzTFI2MFREKzYvWlp5dXFoN09zVjN2a05Palk0QTFS?=
 =?utf-8?B?YTVqYUhERmFERmpBSFRFQjRwblM0amN0c05ocXlid2tnbkgvZGhwSVpMdHNK?=
 =?utf-8?B?OVQ3dWpveGQ4SGd4U01mVkFrUVNXUmpIdmwzS2ltaGt1SFZnampteUljcDB4?=
 =?utf-8?B?eW1ET0dhS1hLZXdjWS8zSVJuNE1YWWp6elRNTFBEMUpnWWN0RDl1NmdKcnRQ?=
 =?utf-8?B?M1dBSjFnTU5URFMzSVNNa0RsQXNEM2c3RWhiL0lZakMxdEQ0VnpRaE8xZW1a?=
 =?utf-8?B?V1kvOUJrdndodEFlSnpGdzBtTFFGRFc3VTZtcGwyWWpZS2l2bVBCNmU1Mi80?=
 =?utf-8?B?cTAydnRRaDlwUUZLMW16ZXluZlFRZ2NZbC9hNERvL1NCWHZ1UXlET295YXdL?=
 =?utf-8?B?RlhmZ2ZaYThvQlJMUUF2WWpPZEdsa0ZpRm9rYmZZMkQyVWsxbk0wejRQc2tF?=
 =?utf-8?B?WHowdFJTeXg2UWw3bFNKMVgvbHZDYW92RmdKemxmVHFxOWRtWjJ2STdyZFpt?=
 =?utf-8?B?SzlMSTluaTFtZjFIdjBqSXI4ZUViS1VKWUNjL1BaQ0p3TjlSdlF2VG5ncFI1?=
 =?utf-8?B?QThOMVFCTWpSUzFLQjVGMzQ5MllPSUNuYTVTQlBBYzhoWmgwZzdWNEdtbThK?=
 =?utf-8?B?a0c2YW9NSm10dVJmdHVXQWNhbFJoVGx3MVhFcTNBQkRBT0F3cTY0dllmcFFk?=
 =?utf-8?B?YnBZVVRrNmdCZ0xBK0RSL3VrZ1F6cFlwbzc3UXB0WllNcUNNM0VxblBSdkJK?=
 =?utf-8?B?bkV0RlhCbnBwQ1MwTm1HeTgzb3lyOFhCMkh1eElzdEVEZjFmM0d1Vjkzckx4?=
 =?utf-8?B?Vkw2cFViRXhNQVlLRHRnOWU2V0tkT3o4TG4wbVRKVmg0NnBlQXF4WmdHTFl4?=
 =?utf-8?B?M0JEckdURTc2TVh5UVhKUUpqQmpFQ05ZejRJY3lnMWw2SUkyQW9pSytxSG1y?=
 =?utf-8?B?QU81bHFlRFlaeUI4T1NLb2ZMS0Y3ZzUrMkdZVmNuc3I0RVpFUFZpMmwvY3B4?=
 =?utf-8?B?QzlNeXd4VTdKbFppSjZYVEhkUDMwdGtwaHVtWkR6czNmaFRGdG9DYlpjTlR2?=
 =?utf-8?B?SGFjNDI5bzRHdVV4ZXJPNWorU3dEVWVVWnc0ajd0VGN1QndsYjZERXBrODRN?=
 =?utf-8?B?TW85MDZDQ3loZmxMNXRweWNXZ1pyd2UwRVZWQnA1SkJvazFMbEMydVNtbHVy?=
 =?utf-8?B?Q2s4cmtlYTd0c3ZYNzVlZlVDVWxGbXlyRHFXL0E4UTR0OExsK1dPVGxvOGhk?=
 =?utf-8?B?cWVyaVVKNWtUUlBrc3VVRGk4MEVHUlVlYjBvTGhTa3NwWDV6SVZnNWlkb2JQ?=
 =?utf-8?B?QzJjeVBnbjJqZzBJakRDaG1KeTFuUzN6Y0g4bnVTZngxNndpZGp6WDFueVNv?=
 =?utf-8?B?TTFkS0hhM00yd3hhMFZlUHRaTmlEREJGelNZdW5IV2MzRlcrV3R2Tzc4V2pJ?=
 =?utf-8?Q?qvixmTz+VjwSOEt7Qx0OdoY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkxWK3B5dkRUT1NaaTM3ZVZWZUY3alh4S25VNzl5d1lMOGRJRENIUllDYUo0?=
 =?utf-8?B?L1hmTjY4eXlrci9ESG1qRFU2clJLQlI3Mm1wTnZ6RVNtc2d3NmY4ZTFVN1p5?=
 =?utf-8?B?M01KVGtDaHVhc3FYa3VNVmw2UlN6S1hMTzZPdUs4TjlCNS9GeFVndXI4TGcv?=
 =?utf-8?B?bUxsK1pjZ0RXVWgxcXkxL1hCWGdsTWdadVhDdlhCSWgrWHdjSVdDbmRmOXZx?=
 =?utf-8?B?Q3pKdkdMMzExTEszWC9ickJMVXgyWFFHUS92TWVQZ1hMalplTTlidzl0K2FJ?=
 =?utf-8?B?eUNwSGJDbWRyZWFZSUQ5MXVZR1FlcFNIMHZkOXYzT2NlNHBmeE80MURvOFZy?=
 =?utf-8?B?WElBbFJkeGhFMmJQUzl0d3Q5QXVia3huUW1yN0x2Sm1iUityUkhWZ3lsMGpU?=
 =?utf-8?B?Sk4xbjhDWjdjR213c3duNUcwVGF0TjFhYkxPc1p2OWZBbGJzenRTUWZBMWwx?=
 =?utf-8?B?RlV0QVE1aU1OQjZyM0lLd0JjSXpLdVVGNWJ1Rmo4dDZMNkorLzJlM3RBNkc0?=
 =?utf-8?B?dUZMbjJJUzJ6VnVvS0NsQWVJaGhUQ0xsd20wNTZ5VHNic1ozci9kZlNLOEhk?=
 =?utf-8?B?d3F5WmFzbFJxQ2Y5L0V5a3NldnlqTTJuTEIyNVFJQ243K3d5bU9IQUZSVzZ6?=
 =?utf-8?B?VEZDVWpVQWpONnFKeUNFc2MyMVJFMU4yWVNVT3Ayc2FuNnQ2dFM5T0FtcFFD?=
 =?utf-8?B?VTBWZXVodFROWVI0RFRpUkJJYmovS0ZNNzZaV0hsSjhXMytsWFowWW9KTElB?=
 =?utf-8?B?TDY3aDZRanNrNnJlSWVGUXZ3Qk91dU9Pd2RoanlxK0JyOHNKQi9DS3JyZHNr?=
 =?utf-8?B?UmNTWVlqSE8xa21iU3JCSzRxbUlrRzEwYWpCQjh0QlBwVEJQV1E3WFo0Zno5?=
 =?utf-8?B?Q0VyZlkrR3JnYXZkMXdINk5IOTRsTWgrMlZuUDZuMEU0aXZlRlAraUZBUW1X?=
 =?utf-8?B?WlphMVo0Y2tXWjljM0RCbFM1RzhRa0VvaWtyRDlSK2h4cE9RNUZWTHVoYldV?=
 =?utf-8?B?a0thSEJabVlyenFGM3JSUVY3UFc2ZkRRODJSZ1ZXSXVhNXpWelpBTmFIejA5?=
 =?utf-8?B?eW5qKzV2RTRiR0xVZ01ocnNYZ1lVaUluZGN3bkh2elA3STF0WVV5ZU9UZXFE?=
 =?utf-8?B?ck1hN2c4VzM3TVllSUtCYW5pckkxaVhicGtOd3UvenlnU3A3cW03b1A2QzNy?=
 =?utf-8?B?TlExRmhVTVJYV2ZDcFNMazE3V1h0NjVaajdYN2ZJVmlPQkFQU2VIWmd5Y1k5?=
 =?utf-8?B?a3JMUmEySm1XaDllcjV3VzVGellaL3lSMmNYZlh6amppYXhYcUQ4UXlqc21v?=
 =?utf-8?B?dmxSMiswcHY2V2FuU01haUg3NTFGRXhzaVVFWW0wT2d3VkN6amJjN3hnQ213?=
 =?utf-8?B?UUF6WW03ZU1TYkd6V0lGWG54WU13eTg4eHp0YTk2emk1NGwzUUMyL1Fac2V6?=
 =?utf-8?B?RVdmZFdpOGtsRmVpbUdIbDBSYTdYdmpvci93RUtFQVYxVVl0bzVZQ3NRNm0y?=
 =?utf-8?B?MytSd2NOdVNHQmlWaHU3MmVPSXNHRGhZcitONE02SFVaUUNaSHFJRkFZNmpr?=
 =?utf-8?B?MTltL2hGdUJhU28wK0xNbHdMRXpJdDNGWGtqRE9VeTVRMm9lWjFUeWxPcFlt?=
 =?utf-8?B?ck1kbnBnSUxUWnEyMDljekhuSVR0RzY0OCtKUHJqV1NpQ2dGSDh3U3k1OXBS?=
 =?utf-8?B?VXFiNHVZTWM5dWFEb0FiVFh6eXdNV1JySWJXajRNUnE5R3p5Wm5Od3ljaDh5?=
 =?utf-8?B?Ny9XRG1oMFNkNEVxQXZOUFR0ZE9yOHFWS2VLT2NQNVR2QUN0WURuSVJ6Qnhh?=
 =?utf-8?B?bThuYmFpRENKc00zdnlqandObW1sbWhqNHFYRnpWWVZyL2JNcTJrcmhLVzU1?=
 =?utf-8?B?TFJxVUlYdHh0NHBTR2czZXlBRFpyVm52dmxoWmVlWDdHeXYxL3M4QVhQTFdz?=
 =?utf-8?B?TDlJa0x0bkJpSUhNbDFsRzFCNlFyMk16NWd6a0xvMHFrZzBUMVRyQi9KQm9o?=
 =?utf-8?B?Wjc5Y2VBVUY3YzBVL0ZUNGNVa3BqT1VObVIwbU1Pd0dUbHEzZFRpS09QeVJ3?=
 =?utf-8?B?M0YzZjBsNWZVZGJMRVVFcnF3MGtWUjBqOGU1bUR6Z3U3RDFyM2ZkL0Z5U1lQ?=
 =?utf-8?B?NVFVb1hQeWVkREdVWEhEc3RjUVpCREhDcVhuRVZWb2tKMGIyb3Z2WEJMdXpa?=
 =?utf-8?B?Um9Zb2hIdlR0clB3Si84R0FJcHFXeElOMGxlSm0wZCtNVFozWnVsNS9GVCtv?=
 =?utf-8?B?eGhrc0xSTzRPbG5PZlhyQTBJSC9zYmE2U2JaeXdXMWx6MHpKbHdmbElPbEdD?=
 =?utf-8?B?Q1kzQ2ViRG5CamQ5MUdlbGxwS21INnlUTElrOWROakNrQXJWeUdWdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47365c40-d61b-480b-6bf3-08de6a61824d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 18:06:56.2721 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: svZHiNLpZ6ZGjmE11jXJ1HGN1OP7GSTd4hOr59FYWp79V7zA1tbJZks0LaCl8fqxNmxlg+1JODPqYj9aB83Quw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6470
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAxMiBGZWJydWFyeSAyMDI2IDE3OjEyDQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IE5pY29s
aW4gQ2hlbg0KPiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gQ2M6IHFlbXUtYXJtQG5vbmdudS5v
cmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBO
YXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPjsgTWF0dCBPY2hzDQo+IDxtb2Noc0Budmlk
aWEuY29tPjsgSmlhbmRpIEFuIDxqYW5AbnZpZGlhLmNvbT47IEphc29uIEd1bnRob3JwZQ0KPiA8
amdnQG52aWRpYS5jb20+OyBqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb207DQo+IHpoYW5nZmVp
Lmdhb0BsaW5hcm8ub3JnOyB6aGVuemhvbmcuZHVhbkBpbnRlbC5jb207IEtyaXNobmFrYW50IEph
anUNCj4gPGtqYWp1QG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMy81XSBo
dy9hcm0vc21tdXYzLWFjY2VsOiBBbGxvY2F0ZSB2RVZFTlRRIGZvcg0KPiBhY2NlbGVyYXRlZCBT
TU1VdjMgZGV2aWNlcw0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcg
bGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBPbiAyLzEyLzI2IDU6MjggUE0sIFNoYW1l
ZXIgS29sb3RodW0gVGhvZGkgd3JvdGU6DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPj4gRnJvbTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiA+
PiBTZW50OiAxMiBGZWJydWFyeSAyMDI2IDA2OjUyDQo+ID4+IFRvOiBFcmljIEF1Z2VyIDxlcmlj
LmF1Z2VyQHJlZGhhdC5jb20+DQo+ID4+IENjOiBTaGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29s
b3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUtDQo+ID4+IGFybUBub25nbnUub3JnOyBxZW11LWRl
dmVsQG5vbmdudS5vcmc7IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsNCj4gPj4gTmF0aGFuIENo
ZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQgT2NocyA8bW9jaHNAbnZpZGlhLmNvbT47DQo+
ID4+IEppYW5kaSBBbiA8amFuQG52aWRpYS5jb20+OyBKYXNvbiBHdW50aG9ycGUgPGpnZ0Budmlk
aWEuY29tPjsNCj4gPj4gam9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tOyB6aGFuZ2ZlaS5nYW9A
bGluYXJvLm9yZzsNCj4gPj4gemhlbnpob25nLmR1YW5AaW50ZWwuY29tOyBLcmlzaG5ha2FudCBK
YWp1IDxramFqdUBudmlkaWEuY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDMvNV0g
aHcvYXJtL3NtbXV2My1hY2NlbDogQWxsb2NhdGUgdkVWRU5UUSBmb3INCj4gPj4gYWNjZWxlcmF0
ZWQgU01NVXYzIGRldmljZXMNCj4gPj4NCj4gPiAuLi4NCj4gPj4+IFVzdWFsbHkgZXJyb3JfYXBw
ZW5kX2hpbnQoKSBpcyB1c2VkIHRvIGFwcGVuZCBhIHVzZXIgZnJpZW5kbHkgbXNnIHRoYXQNCj4g
Pj4+IGhlbHBzIHRoZSB1c2VyIHRvIGZpeCB0aGUgcHJvYmxlbS4NCj4gPj4+IEluIHFhcGkvZXJy
b3IuaCB0aGVyZSBpcyBhbiBleGFtcGxlIHRoYXQgcmVsYXRlcyB0byAiUmVjZWl2ZSBhbmQNCj4g
Pj4+IGFjY3VtdWxhdGUgbXVsdGlwbGUgZXJyb3JzIChmaXJzdCBvbmUgd2lucyk6IiBieSB1c2lu
Zw0KPiA+Pj4gZXJyb3JfcHJvcGFnYXRlKCkNCj4gPj4gSSBkaWRuJ3QgbG9vayB2ZXJ5IGNsb3Nl
bHkgYnV0IGp1c3QgcnVuIGEgZ3JlcCBmb3IgImFwcGVuZCIgOikNCj4gPj4NCj4gPj4gWWVhLCBJ
IHRoaW5rIGVycm9yX3Byb3BhZ2F0ZSgpIHNob3VsZCB3b3JrIGJldHRlci4NCj4gPiBJIGFtIG5v
dCBzdXJlIGVycm9yX3Byb3BhZ2F0ZSBtYWtlcyB0aGluZ3MgYmV0dGVyIHRob3VnaC4NCj4gPg0K
PiA+IElmIEkgYW0gbm90IHdyb25nLCB0aGlzIGlzIGhvdyB0aGUgY2hhbmdlIHdpbGwgbG9vayBs
aWtlLA0KPiA+DQo+ID4gc3RhdGljIE1lbVR4UmVzdWx0IHNtbXVfd3JpdGVsKFNNTVV2M1N0YXRl
ICpzLCBod2FkZHIgb2Zmc2V0LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dWludDY0X3QgZGF0YSwgTWVtVHhBdHRycyBhdHRycykNCj4gPiAgew0KPiA+ICsgICAgRXJyb3Ig
KmVyciA9IE5VTEw7DQo+ID4gICAgICBFcnJvciAqbG9jYWxfZXJyID0gTlVMTDsNCj4gPg0KPiA+
ICAgICAgc3dpdGNoIChvZmZzZXQpIHsNCj4gPiBAQCAtMTYxNCw5ICsxNjE2LDE1IEBAIHN0YXRp
YyBNZW1UeFJlc3VsdA0KPiBzbW11X3dyaXRlbChTTU1VdjNTdGF0ZSAqcywgaHdhZGRyIG9mZnNl
dCwNCj4gPiAgICAgICAgICBzLT5jcjBhY2sgPSBkYXRhICYgflNNTVVfQ1IwX1JFU0VSVkVEOw0K
PiA+ICAgICAgICAgIC8qIGluIGNhc2UgdGhlIGNvbW1hbmQgcXVldWUgaGFzIGJlZW4gZW5hYmxl
ZCAqLw0KPiA+ICAgICAgICAgIHNtbXV2M19jbWRxX2NvbnN1bWUocywgJmxvY2FsX2Vycik7DQo+
ID4gKyAgICAgICAgaWYgKGxvY2FsX2Vycikgew0KPiA+ICsgICAgICAgICAgICBlcnJvcl9wcm9w
YWdhdGUoJmVyciwgbG9jYWxfZXJyKTsNCj4gPiArICAgICAgICAgICAgbG9jYWxfZXJyID0gTlVM
TDsNCj4gPiArICAgICAgICB9DQo+ID4gICAgICAgICAgLyogQWxsb2NhdGUgdkVWRU5UUSBpZiBF
dmVudFEgaXMgZW5hYmxlZCBhbmQgYSB2SU9NTVUgaXMgYXZhaWxhYmxlICovDQo+ID4gLSAgICAg
ICAgaWYgKGxvY2FsX2VyciA9PSBOVUxMKSB7DQo+ID4gLSAgICAgICAgICAgIHNtbXV2M19hY2Nl
bF9hbGxvY192ZXZlbnRxKHMsICZsb2NhbF9lcnIpOw0KPiA+ICsgICAgICAgIHNtbXV2M19hY2Nl
bF9hbGxvY192ZXZlbnRxKHMsICZsb2NhbF9lcnIpOw0KPiA+ICsgICAgICAgIGlmIChsb2NhbF9l
cnIpIHsNCj4gPiArICAgICAgICAgICAgZXJyb3JfcHJvcGFnYXRlKCZlcnIsIGxvY2FsX2Vycik7
DQo+ID4gKyAgICAgICAgICAgIGxvY2FsX2VyciA9IE5VTEw7DQo+ID4gICAgICAgICAgfQ0KPiA+
ICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAgY2FzZSBBX0NSMToNCj4gPiBAQCAtMTcyNCw4ICsx
NzMyLDggQEAgc3RhdGljIE1lbVR4UmVzdWx0IHNtbXVfd3JpdGVsKFNNTVV2M1N0YXRlDQo+ICpz
LCBod2FkZHIgb2Zmc2V0LA0KPiA+ICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAgfQ0KPiA+DQo+
ID4gLSAgICBpZiAobG9jYWxfZXJyKSB7DQo+ID4gLSAgICAgICAgZXJyb3JfcmVwb3J0X2Vycihs
b2NhbF9lcnIpOw0KPiA+ICsgICAgaWYgKGVycikgew0KPiA+ICsgICAgICAgIGVycm9yX3JlcG9y
dF9lcnIoZXJyKTsNCj4gPiAgICAgIH0NCj4gPiAgICAgIHJldHVybiBNRU1UWF9PSzsNCj4gPiAg
fQ0KPiA+DQo+ID4gQW5kIGVycm9yX3Byb3BhZ2F0ZSgpIG9ubHkgd2lsbCBrZWVwIHRoZSBmaXJz
dCBlcnJvci4NCj4gPg0KPiA+IEluc3RlYWQsIGlmIHdlIGRvIGJlbG93Og0KPiA+DQo+ID4gQEAg
LTE2MTQsMTAgKzE2MTUsMTIgQEAgc3RhdGljIE1lbVR4UmVzdWx0DQo+IHNtbXVfd3JpdGVsKFNN
TVV2M1N0YXRlICpzLCBod2FkZHIgb2Zmc2V0LA0KPiA+ICAgICAgICAgIHMtPmNyMGFjayA9IGRh
dGEgJiB+U01NVV9DUjBfUkVTRVJWRUQ7DQo+ID4gICAgICAgICAgLyogaW4gY2FzZSB0aGUgY29t
bWFuZCBxdWV1ZSBoYXMgYmVlbiBlbmFibGVkICovDQo+ID4gICAgICAgICAgc21tdXYzX2NtZHFf
Y29uc3VtZShzLCAmbG9jYWxfZXJyKTsNCj4gPiAtICAgICAgICAvKiBBbGxvY2F0ZSB2RVZFTlRR
IGlmIEV2ZW50USBpcyBlbmFibGVkIGFuZCBhIHZJT01NVSBpcyBhdmFpbGFibGUgKi8NCj4gPiAt
ICAgICAgICBpZiAobG9jYWxfZXJyID09IE5VTEwpIHsNCj4gPiAtICAgICAgICAgICAgc21tdXYz
X2FjY2VsX2FsbG9jX3ZldmVudHEocywgJmxvY2FsX2Vycik7DQo+ID4gKyAgICAgICAgaWYgKGxv
Y2FsX2Vycikgew0KPiA+ICsgICAgICAgICAgICBlcnJvcl9yZXBvcnRfZXJyKGxvY2FsX2Vycik7
DQo+ID4gKyAgICAgICAgICAgIGxvY2FsX2VyciA9IE5VTEw7DQo+ID4gICAgICAgICAgfQ0KPiA+
ICsgICAgICAgIC8qIEFsbG9jYXRlIHZFVkVOVFEgaWYgRXZlbnRRIGlzIGVuYWJsZWQgYW5kIGEg
dklPTU1VIGlzIGF2YWlsYWJsZSAqLw0KPiA+ICsgICAgICAgIHNtbXV2M19hY2NlbF9hbGxvY192
ZXZlbnRxKHMsICZsb2NhbF9lcnIpOw0KPiA+ICAgICAgICAgIGJyZWFrOw0KPiANCj4gSWYgeW91
IHdhbnQgdG8gYWNjdW11bGF0ZSwgd2h5IGRvbid0IHlvdSB1c2UgdGhlIGV4YW1wbGUgaW4gcWFw
aS9lcnJvci5oOg0KPiANCj4gICogUmVjZWl2ZSBhbmQgYWNjdW11bGF0ZSBtdWx0aXBsZSBlcnJv
cnMgKGZpcnN0IG9uZSB3aW5zKToNCj4gICogICAgIEVycm9yICplcnIgPSBOVUxMLCAqbG9jYWxf
ZXJyID0gTlVMTDsNCj4gICogICAgIGZvbyhhcmcsICZlcnIpOw0KPiAgKiAgICAgYmFyKGFyZywg
JmxvY2FsX2Vycik7DQo+ICAqICAgICBlcnJvcl9wcm9wYWdhdGUoJmVyciwgbG9jYWxfZXJyKTsN
Cj4gICogICAgIGlmIChlcnIpIHsNCj4gICogICAgICAgICBoYW5kbGUgdGhlIGVycm9yLi4uDQo+
ICAqICAgICB9DQo+ICAqDQoNClRoaXMgaXMgdGhlIG9uZSBtb3JlIG9yIGxlc3MgSSBhdHRlbXB0
ZWQgaW4gZmlyc3QgYWJvdmUuIEl0IHdpbGwgYWNjdW11bGF0ZSBidXQNCm9ubHkgdGhlIGZpcnN0
IGVycm9yIGlzIGtlcHQuIFNpbmNlIHdlIGFyZSB0cmVhdGluZyBib3RoIHNtbXV2M19jbWRxX2Nv
bnN1bWUoKQ0KYW5kIHNtbXV2M19hY2NlbF9hbGxvY192ZXZlbnRxKCkgcGF0aHMgYXMgaW5kZXBl
bmRlbnQsIEkgdGhvdWdodCBpdCB3b3VsZA0KYmUgYmV0dGVyIHRvIHJlcG9ydCBib3RoIGVycm9y
cyBpbmRlcGVuZGVudGx5IGlmIGl0IGhhcHBlbnMuICBNYXkgYmUgaXQgZG9lc24ndA0KbWF0dGVy
IHRoYXQgbXVjaC4gSSB3aWxsIHN3aXRjaCB0byBlcnJvcl9wcm9wYWdhdGUoKSB0aGVuLg0KDQpU
aGFua3MsDQpTaGFtZWVyDQoNCg0K

