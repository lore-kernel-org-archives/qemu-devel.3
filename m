Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC8C606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 02:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=M6F6OcSV;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=XGznXrD5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVgg7-0001XO-IO; Mon, 23 Nov 2026 21:54:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=781b605ec=Alistair.Francis@wdc.com>)
 id 1xVgg5-0001W5-Hi; Mon, 23 Nov 2026 21:54:41 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=781b605ec=Alistair.Francis@wdc.com>)
 id 1xVgg3-0008Hk-Aj; Mon, 23 Nov 2026 21:54:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795488879; x=1827024879;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=wFmpfQsTNsP+XHzLzYyE84kQBAbrpUOh+pUH28W0+bw=;
 b=M6F6OcSVRu40FrR0s2W4vJzsqWu8WQBYxFvMKoqyq3jNkFKtZEPKtOfU
 eOXobub+NAA21TGx4S8yHFKfw1Q5cpe0G+vufGgAs1vd2CpiGbMIpXLTA
 Gkr35B1N3OBSvOCg4Vo4k0PSOakFNw5k+QgNWykXAR0wkf4UfYDlGiYc1
 1WR8NqP9x/fQMx5Oewjpnjlt4irYM/0dWR7g8gDMO5q5mqYb3rblcz9Rt
 g2xDxQ9iJ6kuV5yFbuHUVaSS9V3mOhvCT6LMAEF0dBxOX2FuFgGQfHlYC
 fzypcKubAi+STGheIB3pDwG4NQCp/L8V/uNpSgPLjuvk6T69LhntnbCL7 A==;
X-CSE-ConnectionGUID: asYUQ20eQFOZW3pRTJqr5A==
X-CSE-MsgGUID: LE1pLX4zSK6EbKbG2XyxIw==
X-IronPort-AV: E=Sophos;i="6.27,230,1786982400"; d="scan'208";a="157368742"
Received: from mail-northcentralusazon11010035.outbound.protection.outlook.com
 (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.35])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 24 Nov 2026 10:54:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDI1MHBgNyzgm0zDdI36kgz12kNA//oWbU3NTbKvUJXi0dlsHkqM8H3RzVMDERq6i+2epihfCf6GYsqEhRPFLb+XRDCVN3vrimeSoK7bO4d96EAd3oHOJAor4J4iUlOpnJKytO3ZsNraanaHQXx56MF5X2aTTlCAYFtBNgmQsCyka8WAvNKmq0ASuMU7x/eXBlek0KMgHGckKLNp8BNA5BqhgNIHsXVBQC1Li10u9CKm7T19CvBApuzNjSeOo3omIHzl4yWI73puZo4kZjpT4fk1YHSlpaTe2zxC8OLTS3l//QjpT2JFBr5750JBd/yMUPxn5kkg13PbR8I6YyR79w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFmpfQsTNsP+XHzLzYyE84kQBAbrpUOh+pUH28W0+bw=;
 b=DuAaIGMWwiXvXuGqxuOXX0lVx6j3p4ib619QeRD8O+rz6xKX9uF7+R35oMUa3lh1Y7PinjJd4abMMz4G1TBw0/LtgmU8QiOBuDfMN75T7N93OZ8kQR9sUZW7JALsYIVDQPIYOP46jMTNl2r4SFnPCqOh/YYnfe+7FspG7SonZNdQ/yneX1kiDNw/n7a1/jDC8oynqqV+qeBdPSuh846Zu/e8Gfci6dAkQ86oG/rww84ExYPAVOz6Xlu4uX51x3XDCyfnDJbjJ4zTU2iXceIVOVWW6QNYyOP27/HNOdPCf7GNQE0rXXRWMTN3Uc3epQDBtW2FjyGWIaRNJStpSVi1TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFmpfQsTNsP+XHzLzYyE84kQBAbrpUOh+pUH28W0+bw=;
 b=XGznXrD5PTCh3UpZtUBfEzR7rnnzsQ7satUHNgGBfS9Ed1of0FChNQ3wEYKYCmwqzUZ29zSAeAZXAFIDd5IpLVJInhspMQeM6PodzdcwZCP4FfFjHNHnGehTM7dnksz2vMdXwGLCNKpoPJtQpYNYfVwfBpYK4O2fL38UjmU98+M=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by DM8PR04MB7989.namprd04.prod.outlook.com (2603:10b6:8:f::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.13; Tue, 24 Nov 2026 02:54:33 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 02:54:33 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH v2 0/1] target/riscv: do not write SXL < UXL [GL4821]
Thread-Topic: [PATCH v2 0/1] target/riscv: do not write SXL < UXL [GL4821]
Thread-Index: AQHdeCNbYmocoQ0c6kuS/ss/qdWSg7c2I5qAgAXxNoCAAHkqgA==
Date: Tue, 24 Nov 2026 02:54:32 +0000
Message-ID: <a8e8d2d5cb5f11d3128c8c96861ead52354fbeef.camel@wdc.com>
References: <20261119124141.1279663-1-daniel.barboza@oss.qualcomm.com>
 <fc4c472c8652b624f8964eae5f0f95ec7c3a880a.camel@wdc.com>
 <a5a6cbd5-4220-425b-be7e-5726ff0221ea@oss.qualcomm.com>
In-Reply-To: <a5a6cbd5-4220-425b-be7e-5726ff0221ea@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|DM8PR04MB7989:EE_
x-ms-office365-filtering-correlation-id: e473c31e-7ab3-4644-b434-08df49d64469
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|10070799003|1800799024|376014|366016|261102123227099003|261026140227099003|261026121527099003|261022075727099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|4143699003|38070700021|10067099003|11063799006|56012099006|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info: b5NNivjtVE/5k0aPxSiONi8bMezegH95Kmq3H8htptlso0YUxH+LqfBugSWx7Eq//Ck/xp+TrRzmjeptpdMa1MrqMH81u4YDBd36QHkn9NM3ZYwoPDlB1SGgAzuwjv4gJC2wQL9Mbn7Y6tnDEXy19GuWF4/3/l7lvumnXBZB7EtO8e67B/o6QLrkQzzB1gPd/+nqHnRqhyAWbg8AKmjKBhkXppmAaxpZXEGsEkvvEHOKOZIdPEvHyIfJbGAlbYHgMIJ68Z2o367fjWgr3hZ1K1XRRc7/xvtj9jLWpA9WA37kxfHszWR2FLPkdXRIRqjHyU3DDehu68DmA49SeN61PlVN4Lz+bSmft2bA/67d7WYdwiyMLXvsQMrJD5SmzaewDOkUuqv3oNZ/ZjmJAt/3/Y1tKs221vCtOhRVNJWC6ICpsyqoscIo5lk13fCZJWU7rgIhC9IQ0M3rfu8T7H3coembyDVhwJ4ZWSmkkFc0a9SsjL1DwKkJ4pch/WZZJuv/x191sm47nFMyC0zNYEH9d7dFy6xiUYzOPoS9+iqnJN7OVHUsLRaP6JJinKehKn7/KorW36IRKcyOae+IaC2ltPn+q1eM6GvkkRReB3Af8VogTJZKflQys9W+Om9StcAVNAjw82wOPMmTh0Rk8ga/37lAbIBu6gBS4sTMQTz5hdE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(10070799003)(1800799024)(376014)(366016)(261102123227099003)(261026140227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(4143699003)(38070700021)(10067099003)(11063799006)(56012099006)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dU10UVp2QnpuWkllTUwxbXcrWGRpakpPclY1ZHhydmhDVDBpbFRzQU5qakFI?=
 =?utf-8?B?SXJNcnJKY3Q2VFRNd3dKOTNSdW1tQ0Z4K2xIRTNQdDJTaVlzSzhjakYvc1JC?=
 =?utf-8?B?RVVkNHM0bHZCaU1FT0VZSGk1Mm1iNEM0UmIxTEZSMmd1QUgwOGV2LzNYKzB4?=
 =?utf-8?B?Qk1UOG16SVBEN0JtSW1sbWhucVRwUitJTXNla0hpbCtIeGN0N1VRYytPWEZz?=
 =?utf-8?B?SXc4bVE2QVBZUG84UlFGVjZJa0F0NDlPN2RnQVZGdFhrNndjNWdtUkJGMHFE?=
 =?utf-8?B?dkJrditRaHBSV3Y2ZzExNjRiOUlaa3JCc05sbG4wR3VBbmR1TTc4K0NRdXkr?=
 =?utf-8?B?YXJ5cjdvazRtbzQydXBsU2FpbTI2b3BQczViQk5SZDcrNmJEdkxLSHNSejlk?=
 =?utf-8?B?ZHlsRWZUNXY2THQ4TXhMbDZybWwvQ2tnUVhxMkhlU0VFVGhBVnAxMDN1Z3pJ?=
 =?utf-8?B?ZHhCclNqa25yY3FmTEFHRDlPNXNlSGJzYlF3RDNvTHRjMnkxKzRLQW9iUnVr?=
 =?utf-8?B?UityUjF5RFg4a2ZkZzV3WFY2UGFEc0JMZlJZM0ZqMmZUM0wvekNPOC8wVExX?=
 =?utf-8?B?b1BqSy92TXhjM2pvNmJoT25OVmwrdWE2QVdyNncwalpWZFRPeGg2aytHNzlL?=
 =?utf-8?B?TFhpVyt5WHhTb0tEM3BCSU1HRmtCMEZXaTI2RUQrQWJYdnMrTTkvTGsrVi9r?=
 =?utf-8?B?YU9kSHlSaThpNkxDQkVGR3dlWThZZGR2QzhEdGFwY2ZYRGczejZJdm01UTBN?=
 =?utf-8?B?QTFUYVFoaFN3SkhVbktuOGhUZEx4UkJvVVl3VmJ6WGdXREhWZlM5SUNNOUcr?=
 =?utf-8?B?bUNqNUQwR25yYWpDMXVoNktseFBnQ0g4bkpQZG9mMjZsb2pYVVFCeDBwdXhu?=
 =?utf-8?B?MGVhT3ppS21tNjYxMlM5UHc5aFZ0S2xua05oUFhSNGJ6c01rN0JPeE10eHJu?=
 =?utf-8?B?UGJoQmwzUVYzOGhKcVBEcHoxaFVEQlgxQWR0OVZSY0U4TzRqNTdiN2VpQjRO?=
 =?utf-8?B?MHRRNFd1SlZZWXQyTkxCVmpLUi9DTUFVbkduVkhIQUdBL1BRbDZSdWFVQ2VQ?=
 =?utf-8?B?NGJOL2F5ZTNZR0xMVVMrcjN2bUExTEpqL3J6SW1CMC8rcDBvMDJNb2sxSzds?=
 =?utf-8?B?Mlo2N3lzZEFxbDZqZFhwQ0FqQzRrUi94bWxhSUJmZldEcVdmSXl6N2Y1eGxQ?=
 =?utf-8?B?TnNLQk1mNUhXQStaekZRREc4K0ZhaDRyeE9PekxQQ1prbkJ4dGcvQmZpRzhB?=
 =?utf-8?B?WFYrOFB6eDJGSHRHOUE2NDhDR0RUUVlhMFN3S0hTQWQwS0grc3dQVVA5ck5w?=
 =?utf-8?B?ZlN0ZE1meWFkNlpqWHJhd0tuYU5TVDN3VzBDbmpwbGVOUUphb2tqT08wODdH?=
 =?utf-8?B?T2pVWUdsNktRVXhuY1hwTTNsL0NVWENXVFUvZkh2TVBSRDdLYTkrMzBVaXdn?=
 =?utf-8?B?Mk92RHVrczJWVUR1WDZ3U1ZhOXlJRzFHTXlKL2lZbE96WlJpQ2ZLbmhxT2h6?=
 =?utf-8?B?N1FBd1BIdVZjU3oyRVFOUnRuMy82RklIamtZajRuK1hVcXJZdDVGeFRsYlZ6?=
 =?utf-8?B?R2Q1WStKRlBkbldkcTlMZVRXN3padmVGQXIvcmNlM051aE1aR1REMlp3bUdh?=
 =?utf-8?B?Z1M2eWtySWNpQ0NXNGw3aUZ2ZHd2MEpoZGJyd21acnlGc3NCNlNEc0duNjh3?=
 =?utf-8?B?ZVF2QlY0cDJybjE1RXdvUjJFbnZWV2lwclNOUXY1c0ZTUUxrRWkwVmVubFdL?=
 =?utf-8?B?TW1RL05OUlVSQ1dTbWJlM0JQNWluU3NVcTBWYmdLZ212QkpsZUY2WEs0bU1T?=
 =?utf-8?B?aUVtUGpJNjZQZzlPRjNzUVpwSTRyWVZKRzEvaEFzQkVnZStHTkRKUGhoUEli?=
 =?utf-8?B?cnhZMjd2SW83L3lwV2I2V0RlZlp0WnRDTzZYTHl5a2d5WW04UmU4WFYvTkRh?=
 =?utf-8?B?UHBjdlh0b1BsVUdHSGR3YWpPZ0tXRmdkUFBSdG1SY3FCNFp2K2FPSU5ITG9D?=
 =?utf-8?B?MmV2Z0xXRFkvMWg2WFBTQVJvN0VrbnFSVkczdkcxMEU2NUdaWHVWdXM5S1Zy?=
 =?utf-8?B?TmtRSCtsOFIwajFxYWdRZDcvSjllanFUVG9pMFdDNVUwRHJ6dERSQXdaRXNY?=
 =?utf-8?B?T3M1cmZ1WVdPY3VsaGZKRlpFbFpkM01Gbk55MkNQK3NXT1ZqWDhaUlAvQjBu?=
 =?utf-8?B?T2t2bUh6Sjh0dFdXcnlMS0grM05ac1hhakF6a2VqSGgrYjRXN1ZrcFJxS21Z?=
 =?utf-8?B?QmZPNkFkaitlVXA2SzRoSlVHOU01V0luZkx1eXRtenNRUnNrS0FWNXdsRWNV?=
 =?utf-8?B?RFRNdkJRem0rTm9zNUhUNjUvM1lmY2g1bnNKSXp0S0dNdHp3YklnVGpxbUFr?=
 =?utf-8?Q?Na1Gs9/ygljf6q6yVALSP2r+CRrNC/wy+4IKgHIIjeMul?=
x-ms-exchange-antispam-messagedata-1: JzQs0hkhRw8guPRKcGw4glLVDqabKVXXtyg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8AD5BC51E873B42B79560CF9CC1F249@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZlEWyC0+G7YIH4/GoU0J1B6+u57Mvy/wep5SsvWFAuVcZt4b89lxB+/GK/86la/+TqdyXrMtqRegG7IN4wCPpdcmND7M4EDWkgQMwoyXgNGWDhYlA8RXXpSk29keN6JaavMssIYyY0WHOplUdMYzcz4cpxp7od8Y+NP9RdPVx4BsNldB86gC8ipz3t4AVjIj2abNqMkhNdTP8lPW6j1S8GzK73ShW+NUun4cdAEf+ONL4zqp28PR4W55b7/cPN2lTU9YWz8PBHfwxuK9afxYZ94CnzWnAFzmkvVBTQkurJqicn88EadxHBitG+Xgchv/g8H7wjNai+9Q7CFpJ7mjTA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GBslcya/78hFtxpi2c0VHBLbbC7MI4GrV7TxENTmXvcuzc1kDHC2M7PBhwtIhYRUV1suf1aCdzwO61aUotQxD3Uq8Le8QQmA4jNZJLY16UBVRNjW4kWBiR7Zwvw6gN3ykwWRBTRQIWqQpcYdG4nth4WoCm1Y4b5PhjO/jsbz3dZ67yx2tmn4iyv4BPBsYIGdgMPw7zwamNGZJ5onUiDBwimO/rDwYEqR3s06z3F6mzXEG3nYcCW7A2GYGgZd6fZtOOyKqMgL8TrF+YkQRM3RxBJWcsbyETWQ53p1PmbLj5ADunAOrvzgRa97Wu2Z1Fj0a9w1qmc1+uT0Y0yNtpVFKzF1wMFbMJbRfuIPZ5YKS6C4L09EQTfNbcygJFcnd7fGYzpiJK6B1d52+88nDw5tzGgITIj6ViwOgRT1cqRKSpXVZ1xd39fPsCEgY5L0cVQNyM5xiAEmmN9rEvmp323Hd2EJEvvoejqqz51Ug7CLRvA2kZBPqHB5TNZV26ucoOelllPQraQmjAOEoOY5Xw8wXeL5SAbyfAYnuR6Ipkybz+eYzEVnk93+pDHqoHc9NOhSqsW3Ua8VAg80Z+THinUFExBk7Ci9uIk+6VHOTNzH8LT4iGSa79bpd4G9MtjLirLd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e473c31e-7ab3-4644-b434-08df49d64469
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 02:54:32.9133 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YrV/zSJQbjSFoWpjLFDjEnHb3Wn22MGGrl4wJ8hnE9su8m/4YQ8J3WQ8s+ltdmHlpfKpG/iUefoHTw5IKGxcSfbxFwWLHYPGUcDt5T0PgbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7989
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=781b605ec=Alistair.Francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gTW9uLCAyMDI2LTExLTIzIGF0IDE2OjQwIC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gDQo+IA0KPiBPbiAxMS8xOS8yMDI2IDk6NTYgUE0sIEFsaXN0YWlyIEZyYW5j
aXMgd3JvdGU6DQo+ID4gT24gVGh1LCAyMDI2LTExLTE5IGF0IDA5OjQxIC0wMzAwLCBEYW5pZWwg
SGVucmlxdWUgQmFyYm96YSB3cm90ZToNCj4gPiA+IEJhc2VkLW9uOiAyMDI2MTExMDIzMjYxNC44
MzA1MC0xLWNocmlzdGlhbnNsaW1hQHByb3Rvbi5tZQ0KPiA+ID4gKCJ0YXJnZXQvcmlzY3Y6IGNo
YW5nZSBtc3RhdHVzIGJpdHMgZm9yIHJlYWQtb25seSBpZiBTIG91IFUNCj4gPiA+IHVuc3VwcG9y
dGVkIikNCj4gPiA+IA0KPiA+ID4gSGksDQo+ID4gPiANCj4gPiA+IEluIHRoaXMgdjIgdGhlcmUg
YXJlIDIgU2FzaGlrby1zdWdnZXN0ZWQgY2hhbmdlczoNCj4gPiA+IA0KPiA+ID4gLSBhZGRlZCBh
ICJGaXhlcyIgdGFnOw0KPiA+ID4gDQo+ID4gPiAtIHNpbXBsaWZpZWQgdGhlICdtaW5fdmFsJyBj
YWxjdWxhdGlvbiB3aGVuIHdyaXRpbmcgU1hMLsKgIFNhc2hpa28NCj4gPiA+IHNhaWQ6DQo+ID4g
PiANCj4gPiA+IMKgwqAgIi0gW01FRElVTV0gSW4gdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYyAod3Jp
dGVfbXN0YXR1cyksIFNYTCBjYW4NCj4gPiA+IGJlDQo+ID4gPiBzZXQgbGVzcw0KPiA+ID4gwqDC
oCB0aGFuIFVYTCBpZiBSVlUgaXMgYWJzZW50LiBUaGUgbWluX3ZhbCBmb3IgU1hMIGlzIG9ubHkg
ZGVyaXZlZA0KPiA+ID4gZnJvbQ0KPiA+ID4gVVhMDQo+ID4gPiDCoMKgIGlmIFJWVSBpcyBwcmVz
ZW50OyBvdGhlcndpc2UsIGl0IGRlZmF1bHRzIHRvIDAuIFRoaXMgYWxsb3dzIGENCj4gPiA+IGd1
ZXN0DQo+ID4gPiB0bw0KPiA+ID4gwqDCoCB3cml0ZSBTWEwgPCBVWEwsIHZpb2xhdGluZyB0aGUg
aW50ZW5kZWQgZml4IGFuZCB0aGUgaGFyZHdhcmUNCj4gPiA+IGNvbnRyYWN0Lg0KPiA+ID4gwqDC
oCBUaGUgY2hlY2sgc2hvdWxkIGVuc3VyZSBtaW5fdmFsIGlzIGRlcml2ZWQgZnJvbSBVWEwgcmVn
YXJkbGVzcw0KPiA+ID4gb2YNCj4gPiA+IFJWVS4iDQo+ID4gPiANCj4gPiA+IFRoaXMgd29uJ3Qg
aGFwcGVuIGluIHByYWN0aWNlIHNpbmNlIHdlJ3JlIGJhc2luZyB0aGlzIHBhdGNoIG9uIGENCj4g
PiA+IGNvbW1pdA0KPiA+ID4gdGhhdCB3aWxsIGZvcmJpZCBVWEwgd3JpdGVzIHVubGVzcyB3ZSBo
YXZlIFJWVSwgaS5lLiBpZiB0aGVyZSdzDQo+ID4gPiBubw0KPiA+ID4gUlZVDQo+ID4gPiB3ZSBj
YW4gYXNzdW1lIFVYTCB3aWxsIGJlIHplcm8uwqAgQnV0LCBieSB0aGlzIHNhbWUgbG9naWMsIHRo
aXMNCj4gPiA+IHRlcm5hcnkNCj4gPiA+IGlzIHVubmVlZGVkOg0KPiA+ID4gDQo+ID4gPiDCoMKg
wqAgdWludDMyX3QgbWluX3ZhbCA9IG1hc2sgJiBNU1RBVFVTNjRfVVhMDQo+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA/IGdldF9maWVsZCh2YWwsIE1T
VEFUVVM2NF9VWEwpIDogMDsNCj4gPiA+IA0KPiA+ID4gQW5kIHdlIHNob3VsZCBqdXN0IHVzZSAn
Z2V0X2ZpZWxkKC4uLiknIGRpcmVjdGx5IGluc3RlYWQuwqAgU28NCj4gPiA+IHdlJ3JlDQo+ID4g
PiBlbmRlZCB1cCBkb2luZyB3aGF0IFNhc2hpa28gc3VnZ2VzdGVkIGJ1dCBmb3Igb3RoZXIgcmVh
c29uLg0KPiA+ID4gDQo+ID4gPiBObyBvdGhlciBjaGFuZ2VzIG1hZGUuDQo+ID4gPiANCj4gPiA+
IENoYW5nZXMgaW4gdjI6DQo+ID4gPiAtIGFkZGVkICJGaXhlcyIgdGFnOw0KPiA+ID4gLSByZW1v
dmVkIHRoZSB0ZXJuYXJ5IHdoZW4gYXNzaWduaW5nICdtaW5fdmFsJyBkdXJpbmcgU1hMIGxvZ2lj
Ow0KPiA+ID4gLSB2MSBsaW5rOg0KPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1k
ZXZlbC8yMDI2MTExMjE2MzI0Mi41MDk4NjQtMS1kYW5pZWwuYmFyYm96YUBvc3MucXVhbGNvbW0u
Y29tLw0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IERhbmllbCBIZW5yaXF1ZSBCYXJib3phICgxKToN
Cj4gPiA+IMKgwqAgdGFyZ2V0L3Jpc2N2OiBkbyBub3Qgd3JpdGUgU1hMIDwgVVhMIFtHTDQ4MjFd
DQo+ID4gDQo+ID4gV2h5IGlzIHRoZXJlIGEgR0wgaW4gdGhlIGNvbW1pdCBtZXNzYWdlPw0KPiAN
Cj4gU2hvcnRoYW5kIGZvciAiR2l0bGFiIi7CoCBNYWtlcyBpdCBhIGJpdCBlYXNpZXIgdG8gZmlu
ZCBwYXRjaGVzIHRoYXQNCj4gYXJlIGFkZHJlc3NpbmcNCj4gYnVncyBpbiAiZ2l0IGxvZyAtLW9u
ZWxpbmUiIGFuZCBmcmllbmRzIGluc3RlYWQgb2YgcmVhZGluZyB0aGUNCj4gIlJlc29sdmVzIiB0
YWcuDQoNCkFoISBOb3cgSSBzZWUNCg0KPiANCj4gTGV0IG1lIGtub3cgaWYgdGhpcyBpcyBhbm5v
eWluZyBhbmQgSSdsbCBzdG9wIDpEDQoNCkkgZG9uJ3Qgc2VlIGFueW9uZSBlbHNlIGRvaW5nIHRo
aXMsIHNvIG1heWJlIHdlIHNob3VsZG4ndCBzdGFuZCBvdXQgaW4NClJJU0MtViBsYW5kIDopDQoN
CkFsaXN0YWlyDQoNCj4gDQo+IA0KPiBEYW5pZWwNCj4gDQo+ID4gDQo+ID4gQWxpc3RhaXINCj4g
PiANCj4gPiA+IA0KPiA+ID4gwqDCoHRhcmdldC9yaXNjdi90Y2cvY3NyLmPCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHwgMzkgKysrKysrKysrKysrLS0tLS0tDQo+ID4gPiDCoMKgdGVzdHMv
dGNnL3Jpc2N2NjQvc3lzdGVtL21lc29uLmJ1aWxkIHzCoCA3ICsrKysNCj4gPiA+IMKgwqB0ZXN0
cy90Y2cvcmlzY3Y2NC90ZXN0LXV4bC1zeGwuU8KgwqDCoMKgIHwgNTkNCj4gPiA+ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gPiA+IMKgwqAzIGZpbGVzIGNoYW5nZWQsIDkyIGluc2Vy
dGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiA+ID4gwqDCoGNyZWF0ZSBtb2RlIDEwMDY0NCB0
ZXN0cy90Y2cvcmlzY3Y2NC90ZXN0LXV4bC1zeGwuUw0KPiANCg==

