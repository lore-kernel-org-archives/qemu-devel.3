Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D52606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 02:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=CpBwH0zh;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=blxA1p+U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJiMN-0007LC-O6; Wed, 21 Oct 2026 22:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJiMM-0007Kx-DF; Wed, 21 Oct 2026 22:16:50 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJiMK-0002cX-8c; Wed, 21 Oct 2026 22:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792635408; x=1824171408;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=zSboUmfx6fbPapHvGVEjhEAxpKJM6KNuu5v71hTiXV8=;
 b=CpBwH0zhizTIt+3rp5sDXDzkitzb4/yhfpCBGEf8Zb4q7O52vd976sWV
 wHztFp/+qOx8j3DqH9v4HrpvJBV83SjUVApDu2+NfvzbU52xLWLcWgV6l
 dVKe3HRY/5io5sjuI3Q5qSbcvOVIE4EPUmsa8vuNn6GiuqjvLR6wxEbik
 FA6/IFOfQEUWBijaYlDPZJbzRjO2r9apED3MKb6ZAhANzUOyjirg+AcNO
 ZPgQEMD9I/Niflxgt20d/yJveeDqYqpRWFBITaBzX9neIAISANBH/MajD
 F1XfEcs8CaRt2nYzcRC6xROCbBRR0KmSKbkIsv8Wle2fddH3l6B2FRlhu g==;
X-CSE-ConnectionGUID: lKcqzgNEQk2ZLh+XfV0bmw==
X-CSE-MsgGUID: y0TEdXRuQo2fx6xbAPFo5g==
X-IronPort-AV: E=Sophos;i="6.27,171,1786982400"; d="scan'208";a="154471673"
Received: from mail-eastusazon11011042.outbound.protection.outlook.com (HELO
 BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.42])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Oct 2026 10:16:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAZIC0d0es+sEhZSW3IbIY1xhpx+eTW5VcVKUFu0s8/iiRQ8qNPD9ib+L4y0EMbLSY3TgUkxjHwsobMIpCirwx5/bDYeoHrAI5Vs8qQtYzzNygQuTiIM5k+Uaz4z9OY83LIVF+V3cxy3pkPXyncKmxPWTZHi/cInGPu6SgRnq+Nx+sMYHW8VYbA2BRe9ZDq39fsS43gvq4LbWEiOvA/X+aUZ8YsSb8LKCZoL0fZOKbjJ0wivuRabUtvmyD/o2cRl4xqFQZhbo4zUSMt7MsGZ4ztZGNFpCosq7XrHy/nnZL+uE2frasmuqq8z42XqYcWzB9BR7n84vCzws20hO8S+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSboUmfx6fbPapHvGVEjhEAxpKJM6KNuu5v71hTiXV8=;
 b=ufZjOpFmuXCayYhrwoLw8m3X05WsnXwYGzvJaUctrFve/PqUo+JjSpMAvAzP8BoGrDYFr8k32RkVSTjmNuxRN/+hxgGmqSm8N6/l1PeUHiJnwOWd83ueMD0q+Q9w7NHWdhGUc1UqPbPgVg6jaPCAWoBGr/1pHl2uHQXQo0863WIOx4Uo97pVDgykYHEUO7qHrdD4GUgdQ05Wnvd+KnrGqRDCM/SyaGgMRJaVch1cS54wyfzvbdaAQMCrboVm+F7GeBRRYT3AXBmXx/qDtelDQF9i3xshje83TIKTz1BU12GzN63H1BWfJZPj+RB8RJjF/6F4oAzQ3wTFOENkavN2rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSboUmfx6fbPapHvGVEjhEAxpKJM6KNuu5v71hTiXV8=;
 b=blxA1p+U9D12fvpAX7lis4Z4ssETyUnMWcZNxjvTIQ/DQB8CJTS5pTX8I5iVNVpxjOZqkNqO80UCoCnwSDbSJ5cbM5eeyQpZyiIwOAErXhcctiZMtq9cOR2GTuIQidTaUugQAlFUovaJAkjQC46TBhuwKRMuBTwWxWtGy5y328c=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by CH5PR04MB9576.namprd04.prod.outlook.com (2603:10b6:610:212::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 02:16:40 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 02:16:39 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "tanchi25@mails.ucas.ac.cn" <tanchi25@mails.ucas.ac.cn>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2 0/2] hw/riscv/riscv-iommu: reclaim invalidated IOATC
 entries
Thread-Topic: [PATCH v2 0/2] hw/riscv/riscv-iommu: reclaim invalidated IOATC
 entries
Thread-Index: AQHdXkVssnbWIJ7HTUewteYBupqo7rcI2jEA
Date: Thu, 22 Oct 2026 02:16:39 +0000
Message-ID: <72ea65e010e2e12fcd92f52ca560662b15699d2c.camel@wdc.com>
References: <20261017143943.15521-1-tanchi25@mails.ucas.ac.cn>
In-Reply-To: <20261017143943.15521-1-tanchi25@mails.ucas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|CH5PR04MB9576:EE_
x-ms-office365-filtering-correlation-id: 03fd9b8d-8a24-47b6-9618-08df2fe281b4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|10070799003|1800799024|19092799006|366016|261021123027099003|56012099006|38070700021|11063799006|261009223027099003|10067099003|18002099003|22082099003|261021121427099003;
x-microsoft-antispam-message-info: 3V8u04lBWh/z/LeAcYm87dP+3dIlz+GHRkGFDJ4RjNQhe9jETEdT6Q7Z+Pwkp2uEEiUa+6GJnKnDBCYGuTMUzy1i0tEiWrqSiSmxj0AkC9aUhNSZtnO4XCi/5IasgJDHMZkWPE7Bld/2lsX3ChelEyS3IWZf09lbA0MpKzY9+ITuE90sxcpg746KEoTTG01vn5xM8QSr63yPLCl2xDUv6ihqM1EbNE0KeqWtGu2dFtOwyD+wa5JdCU57kfXosTsCHkapekEKXYvYpRed3evUM4EGDQiGaMsVNPz4bnJxpXAplbpJsBYSTd6taJPvPPcT9N5+gC2ACgUsrgcb27UR3nZmed+P1usi4bm065Upz//jObWQB8xGFJ0WkuILR/Qq+q+1LwSEd1/6kJDLDKvuio7rfAZ3ZVt3CZ7AaBud/GBXMhwOO/2c/cAZ0uXEl4s3unkEuesvMSjG7+YsLW5kWUMx1X7kGDqXgq8oMC9vT2BPaoYrTeXvuehzcdeEC/XjOJdBOfAM0YITpUrEwN9PI6zqN41zvibzRIc4Bg43T7vMvm9P0v825its8dtRrIJmNhxr62BrOUD+7Pyzntrew56us/c6jyqvuKuyG9WtTv4hsjK4jF8bfIrS7bYjAZY78FrihJHLRvTaceXjOwfR1g/lTk10wIqBgSQoDn5EAkNPtZuc/fZInxr21HfNe15DFTxmmfva0sUiqDePrdRCnzuXAqxRMUbf+O6dZNENyFs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(10070799003)(1800799024)(19092799006)(366016)(261021123027099003)(56012099006)(38070700021)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3VWUS9iQWg4U2pvQ3VvcGlmYzhQa1oyQzcyTENmK1dadWllZTMyZHpkdTha?=
 =?utf-8?B?dDFMcVQvRG5EN0ErSzhCcjZYdHo3OGkvelpGMUtHVUN1MDJ2QzNPd3FmSlB0?=
 =?utf-8?B?TGFzbUpISVZGYlV3c2J5VDZ4SU9WcmZONXBBVi9lVks4ZGZBV1NxS1FXeHFB?=
 =?utf-8?B?b2pYeWI4eFllc1hlck9UV0YzaTg5c1c3SlB0QVU3bzc1TWdmR2t5RmhTNjJL?=
 =?utf-8?B?WmY1ZkxVMUVlTjQ0YXd6NytZRDhXTmUwTzJZSGZLdmFoV1VEM2VsOWxNZzlo?=
 =?utf-8?B?N2orWFlDWVVpMU5YaW0yb0ZKV1A5MHVuZVdyRytwUDMxbitlVjVOZVFEVEYw?=
 =?utf-8?B?WWd1NEtoOUhLL1pRT2thdWtDTGw2VXpOODV3T1hRblpIbFJkKzFvbDRTNjQr?=
 =?utf-8?B?YXR0a3dBbUd0MEhZQTlrdkl3N3hyelRYeUl5U1ZIWS8vUUhqa3hCR2RtUXBo?=
 =?utf-8?B?djc0NFJ6bzRpVElKTXRJU3pEdjdBQWZZUkhHeTlGd0ZiRjNna0pCejFvK1NV?=
 =?utf-8?B?bThvTnozWnFlYUhHZVhOTnpRY2IxbVFtY0c3cVFMVWY1YTBRRUtJNU1Xa3hq?=
 =?utf-8?B?ZU5jVXRYVzNtc2swOEtDVURwYW1KeGp6MWIwNFVxdkJKSndQRmI0QWRxaDBZ?=
 =?utf-8?B?Q1lSbngxK0xzRS9XZHRzVmdreTRmZmtqaFFIaE5zMjVmQ2tkK1pobmMrOWVE?=
 =?utf-8?B?SnJzQVhvdWRXeEpUQkFDNUdieWlPbmdXUFdjbjJHc1ovcnRycUR1U0dMdWsw?=
 =?utf-8?B?amE0bDJiT3FhZlpOT2lNU08rYm9ETDl6bTUxMUdnVEIzbXc1ZURranE3dVc0?=
 =?utf-8?B?ZXhZcExNWUpXZjQvU3BUcWhycVcxbWdDM3JFSng2dTFibk5lWHpGTnlGVk5R?=
 =?utf-8?B?cm1OanpEdmJjRmpwOW96cmVrcncyRU5nZmhaSXZMOFNSQXFoYktwbyszN2Fo?=
 =?utf-8?B?THZvTmtFTExlUFV6cStIZU1ZVkpYR2tkeGJKZ1p2SjMrM2lDamhzNkVxRVky?=
 =?utf-8?B?c25OazdQb0prZHBFSFhlVWVZZkJZWUFmTldYRFBoS1ZjUHdyQ2ltbXMwWWpl?=
 =?utf-8?B?MmQ5QzAyT1A0ZFFIb3VISlhzeWRCR0lnQlFjaCtENVJ6RkNNbkc2UjUxWHMy?=
 =?utf-8?B?ekVNOFpSRUpQVzZDU0d1a2xsUXNldHltNVRLbVozUWdJNFJPbUVQMjRhRDU1?=
 =?utf-8?B?eXVnM0RTUzJwN3JXaENSUkIyQ0hNdlRBTWQ5U0dLa3FENUVISUNsU0lVZjdw?=
 =?utf-8?B?NTdFNnl3azdGblRYUFVvZTY2S2o0MTlkeGZ1b3UzZWlZb1M3SjJMdzV2RXJK?=
 =?utf-8?B?aFl0MU4xWW1NOW0vSG1tQmJDVENWbldaMkhFbitNN2t1OG1zRFRZcXUwZmh3?=
 =?utf-8?B?dm8zQjAvMXAySmsrNE5MVFdvYjZvaUxnOS9EYTMveHJ2SjRNY3JTZHU0azBB?=
 =?utf-8?B?NGNtSHE3SjUvbHh5Y3YvWktLS1BJYkE0Sk15NUZyM2lYNTdBRDc2bDFJYnRI?=
 =?utf-8?B?VEpQMkxBOC9KUnRxcEErNC9tNWo1SzlGcGxJdVZ5ZHNkODlJUWtYSkwzdDhl?=
 =?utf-8?B?TGpxOFZib0RqSzZDaXZHQlFzUzdGaWxTcEhkaVNBVUliSWxsdmtVa3diOFRF?=
 =?utf-8?B?aDRFN2Q4Y2xpaUZiMWd1U05zNklUNzdWcDhscjUvOXUwdGl0SGJ6S1hwSGJS?=
 =?utf-8?B?ZzdUeW9SZXBUV2xJY3IwL0lDWnBWT2t6dHlYMnRTNlIyUTgrcDl1akEvNjZK?=
 =?utf-8?B?aW5KNjN3RHMvYUZnckZXYWhjNlRzRGRKeC9iQ0htUTk0b2VrRHFQOVFWV0lO?=
 =?utf-8?B?V1BzU0JPY1hZak9ha1BhN043eGtvOFVGWnVMbDNNNW1LNWZQLzQ2QTJTZjFV?=
 =?utf-8?B?dVMyM2ZGQWkxcC9ENTlNUmY4UWplZUw4S3R5YVFjODB1a0ZTMHl3Wm14ajgv?=
 =?utf-8?B?c0ZGd0J0eFAyUjFCb01haWdBY2xTanhiU0xPeGpZbWlNbUJMZEpNZHpSZ1lJ?=
 =?utf-8?B?eE9NY3B0MytLQWxoek05RVFiN3Bqd2lpdjFVR2pHUzEvbDNvVFo1dFViZjUr?=
 =?utf-8?B?OVFueTNlZkdXT25TalBYRy9HQkU5dzBydW1MTlh3blpMbGdWbHBGbkFKZ2Uw?=
 =?utf-8?B?T1VMdi9GTU5yUDhhOWh0TlB2K1A2Z0srOU9MQWhXTFErMGpzSFdtM1Z4SzhH?=
 =?utf-8?B?ZHFCSDhjcTFseHJEa1JIRGpUOGhjUFlpeDBQOFZZYlFLb0VQOGVFM2dLZ2Ro?=
 =?utf-8?B?Qno4Vnk1VTNFRjdRd1ZDeVduTk9OUDJLcUo4dFBKV0xiYnE5TCtxMk9lM1Jp?=
 =?utf-8?B?SHFzekJXWjlaWXBXUmdiS1FxUHRZWEdIOEo5RzNrblZhcTU0V0pKd0wwYkxn?=
 =?utf-8?Q?1q2f67qfIDP2UsCIlcXAnhUstfcFnwH41EZIc4jw8JU6F?=
x-ms-exchange-antispam-messagedata-1: A7qSsrTSoa2rtoPMHGQyX2rv4L7XEAq7b8g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <98352F4A9E018A478FFD65A67A6308B3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TfmSWz0mK9NMK2sL9XzXi9OM9EktTXEcrsBK5/avP7/IcITqIvmQehV2rJ0j/0+PK5KmU5OrAdRwXWI+yK6uMrJfdN0SImjjZF8x7SaL+V99pGxIwBkO4Dv+HDGUu0WqPyQIn7Xl45k5X9Fc2+cs9LnWbPX+wKZWVllFb6rFGnOxbt+5IS7uRmuquzdHhP4GJ3XA/rcEsYEXPh+YNtlpeu0iY23sglbaGWpw0jWw6wpclgXm/9sr5FT1V2Kq8NjuA2u8ZdGaraKYCkomb2U7UhzFcuaeqynaLfIoqWIchvzvmUJUnB89UxfKgug5oqPQ4SgRTsVV4qlpPRcIlRkKsQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QsnqFDe0XWS8IV3cb6qb/1FMov8HiJEHUkbg0rKQAg3gu7jUFvXh3igLBChKdvxpJU4t3vsr2ocgMaJoP9NKc8A13/YYwaQoSj2SG5SG1ly+fN3uwNXx6r78Kd+S+zQDfoSJOtlpq/TNmUjGvHWrGWdydPrrSPAkOp0c/faJ0dvdZaqoiyjWRFwUDHNTYOMmtPmng4MJplq4vZCf9hsEOs+46Uo6sWUj9amtju0dKh3ME36XX/3lJAvVHnVgwbsfRdHhuJRzRkPK5FFFrZrVK+XZVOI4K+2ntrf8wOhoiJsr13PiZt4xTrlUNVBr5ndCZCujnmErGOKoukMPxOITZ1iBtVnL/tIBdVxQQs8W0uX4SfnAQFy5DFsIjSKx7wbBU7q6X0q5j5bcngKgH/XlnFTBUUcUmVQxz67AyFcXc+5pxteByFELbMBXbtdGIv+91DMlJb2k9It9KJ4LapOkDii9QVf+O76emBA5NkjQJYx4KNmgYcXeCOGLt5zvOt2SjOmP0v5hzHxeDP+hM29iv0VXb/wkCELqbJQwuv8vxy9pduBUOUpf0yKPwYN8/W5GehAwpnFNQCTDv8PghG/KWCDtTILeQUwOhR+O0nFmu0Ojzg1vySLBvtNTYlWIpkB5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fd9b8d-8a24-47b6-9618-08df2fe281b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 02:16:39.4641 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ye7iuV6h9SOqQ7XsMWo1QYWIXNuNE/vTjQmDXQevIhIoKr8sAckRzR13xqf6E1RnOx1YF3nX+JHc3d33fZo7VT0/lJgIyw/v+yLJR4ATtBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR04MB9576
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=748e7da1e=Alistair.Francis@wdc.com;
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

T24gU2F0LCAyMDI2LTEwLTE3IGF0IDIyOjM5ICswODAwLCBUYW4gQ2hpIHdyb3RlOg0KPiBUaGlz
IHNlcmllcyBjaGFuZ2VzIHNlbGVjdGl2ZSBJT1RJTlZBTCBoYW5kbGluZyB0byByZW1vdmUgbWF0
Y2hpbmcNCj4gZW50cmllcw0KPiBmcm9tIHRoZSBJT0FUQyBpbnN0ZWFkIG9mIGxlYXZpbmcgdGhl
bSBpbiB0aGUgaGFzaCB0YWJsZSB3aXRoDQo+IElPTU1VX05PTkUuDQo+IA0KPiBQYXRjaCAxIGFk
ZHMgZXhwbGljaXQgc2VyaWFsaXphdGlvbiBmb3IgSU9BVEMgYWNjZXNzZXMsIHByb3ZpZGluZyB0
aGUNCj4gZW50cnkgbGlmZXRpbWUgcHJvdGVjdGlvbiBuZWVkZWQgYmVmb3JlIGVudHJpZXMgY2Fu
IGJlIHJlbW92ZWQuDQo+IA0KPiBQYXRjaCAyIGNoYW5nZXMgc2VsZWN0aXZlIGludmFsaWRhdGlv
biB0byByZW1vdmUgbWF0Y2hpbmcgZW50cmllcy4NCj4gVGhpcw0KPiBhdm9pZHMgcmVwZWF0ZWRs
eSBzY2FubmluZyBpbnZhbGlkIGVudHJpZXMgYW5kIHByZXZlbnRzIHRoZW0gZnJvbQ0KPiBjb250
cmlidXRpbmcgdG8gdGhlIElPQVRDIHNpemUgbGltaXQuDQo+IA0KPiBUaGUgcGVyZm9ybWFuY2Ug
bWVhc3VyZW1lbnRzIGFyZSBpbmNsdWRlZCBpbiBwYXRjaCAyLg0KPiANCj4gdjI6DQo+IC0gU3Bs
aXQgdGhlIElPQVRDIGxvY2tpbmcgYW5kIGludmFsaWRhdGlvbiBjaGFuZ2VzIGludG8gc2VwYXJh
dGUNCj4gcGF0Y2hlcy4NCj4gLSBSZWR1Y2UgdGhlIHNjb3BlIG9mIGlvdF9sb2NrIGluIHRoZSB0
cmFuc2xhdGlvbiBwYXRoLg0KPiANCj4gdjE6DQo+IGh0dHBzOi8vbGlzdHMubm9uZ251Lm9yZy9h
cmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDI2LTEwL21zZzAxNjA2Lmh0bWwNCj4gDQo+IFRhbiBD
aGkgKDIpOg0KPiDCoCBody9yaXNjdi9yaXNjdi1pb21tdTogc2VyaWFsaXplIElPQVRDIGFjY2Vz
c2VzDQo+IMKgIGh3L3Jpc2N2L3Jpc2N2LWlvbW11OiByZWNsYWltIGludmFsaWRhdGVkIElPQVRD
IGVudHJpZXMNCg0KVGhhbmtzIQ0KDQpBcHBsaWVkIHRvIHJpc2N2LXRvLWFwcGx5Lm5leHQNCg0K
QWxpc3RhaXINCg0KPiANCj4gwqBody9yaXNjdi9yaXNjdi1pb21tdS5jIHwgMTczICsrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAtLQ0KPiDCoGh3L3Jpc2N2L3Jpc2N2
LWlvbW11LmggfMKgwqAgMSArDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCA4NyBpbnNlcnRpb25zKCsp
LCA4NyBkZWxldGlvbnMoLSkNCg==

