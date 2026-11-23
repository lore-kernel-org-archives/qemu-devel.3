Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25E9606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 03:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=mPpR8Xzj;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=XDPerhor
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVKtW-0005YB-6v; Sun, 22 Nov 2026 22:39:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVKtU-0005Xw-BY; Sun, 22 Nov 2026 22:39:04 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVKtQ-000406-Iz; Sun, 22 Nov 2026 22:39:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795405148; x=1826941148;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=5fYteRG2AsPBVk3pmyonGfeNQ9w1WL1DlmYL5tLHV5s=;
 b=mPpR8XzjX5CDMNT1rL3wMBMWNxVlSVTVPosU+0idNpInADa2bjI0y9tC
 7DehIMBnSBSre0y5iELPxsWvg9XjHhKQVfNGl2BjECxrJPpGNPwVnb9/O
 N79NC5tgJv54HxqXLEEgipCp2cItN2j202gdJGjhuotBfToXmjohlxQ4h
 WGSxsz+EBqib7dsdYLOhL7iJK+A4H+bX+CrOs9ku/rQWquW/ErONd5u7N
 ZK5zqM4ANN6uCTVnOBPtgISzDGFgxUX/CB+uBahWgW9YMloxWorqsAg97
 KXLSazCDMDM62EMdgS2Qmctu6ZyrWW+1J4RxrwQnjB+PfDKYbOub/+25c Q==;
X-CSE-ConnectionGUID: 47SW5LZZRQiVEs4AxDbCOA==
X-CSE-MsgGUID: t0xf/BkLR+yWsDx/B7fkyQ==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; d="scan'208";a="162506591"
Received: from mail-northcentralusazon11010020.outbound.protection.outlook.com
 (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.20])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Nov 2026 11:39:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wm2DdYrhjeNdTZsLaL5YCGIqJu6iDG10NwaNuTJ6kIODe5L/inmJSbSdilDQKo2X5FZfCm0kPOuxbLTQ9ZOOcWTsT3kejs0QWaf1uFmEUWVtFfOdqssu4ebylbiojaoAfBrC96dBjyLtWWwtTL2dNoLXu5AbB5p5StDQOJnqD7qFwKbTIPS1F7K1glQ9beafU3jvreOnblsS1InwYWFsJbnGHuCEKtfCAox+1qeZKNcrMXotR6eo13JwhFyyQJbRmHg6j6uM6xrsPDVKroi1uW1q7Z5L1L1mlMNFbovqlP99yM/0ABLPOqDz72bZT/LUoKU9vcd+zbMSmJ6m0polxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fYteRG2AsPBVk3pmyonGfeNQ9w1WL1DlmYL5tLHV5s=;
 b=R72FMl9BYjsvIgQGDMSZ3Q8iZ+2ygMyJ0UXSTiBWAcp5CAqNKePUK0pKLvPR8+3uAkvHpXhPlcH4p/uhOXNebr5z1e+FdbYHevoSmDagY86IP0IOrd0zVaTCLczpOYO/hXwjmRzCocdBQ5kSJvL/ykZ38D1X3kSWdi7RpttMa9Tqo/bBVfbsc0NHo0NLY0payo614v+MOCFoTmfGJRqFAVzi3LXNtDA2VY9gYXSqaQYJM31UBjGJ5zTwOmpTrmHXijqS09GQd9gwVkATg6lzRu8pJe6X/0WFowuSox1GpamI38Pmo2Jc6fKhoVMvdBCJCPs8KT6m/x8ynTahPqcuPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fYteRG2AsPBVk3pmyonGfeNQ9w1WL1DlmYL5tLHV5s=;
 b=XDPerhorRct7nM/UFrXH/BiJxIYSjgrVBrqjhZKoJoz39cvsCpCQC6AfkiKIFq64pVvIJukZ9MfctZfpOc8/xIvPP9w0zbf/ySLZXOcpl+Cb8Zv8m/F99ltQyFsiqaWYe5fpjOZkpEmX1ppmyO1/E3zPC/Sa3Xf5rMFACg558BE=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by CH0PR04MB8163.namprd04.prod.outlook.com (2603:10b6:610:fc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 03:38:55 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 03:38:55 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 0/2] target/riscv: raise access fault for Zicbom
 MMIO-like accesses
Thread-Topic: [PATCH v4 0/2] target/riscv: raise access fault for Zicbom
 MMIO-like accesses
Thread-Index: AQHdcVm6sgmn6Q+c7k2QVMpBLnFTmrc7FZ6A
Date: Mon, 23 Nov 2026 03:38:55 +0000
Message-ID: <c7e67365faa9379d729eeb057085d5fb0a26c9d6.camel@wdc.com>
References: <20261110212312.56809-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261110212312.56809-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|CH0PR04MB8163:EE_
x-ms-office365-filtering-correlation-id: dec1d06b-c31e-44c6-c040-08df49134cd0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|19092799006|366016|1800799024|376014|22082099003|18002099003|13003099007|11063799006|56012099006|261021123027099003|261028144727099003|261026140227099003|261102123227099003|261022075727099003|261022105027099003|261021121427099003|261009223027099003|38070700021|10067099003;
x-microsoft-antispam-message-info: aio9IDD2vGeurDZy8bfUdn9qwbeQQzIYqaVmidETK+swzb5FpS3tNnePgtUzwHLTLb/psyqE6jEDVssmpyaHMtzNFsG3O8CTA4PPlcSl663xhiH5+s/FB/U+/+KYp+KgLLqBS6PSeAP6o3/wV84AcyH0pKNN2HdkJgmsjRru3+y1xyeHkrf1KqkiZIJE7CG7MHCiiEIzAy1SJj+f0VSGORk/EsoYY5YoekkVGM3/8fNPBm2ZHCBgaG6kgMnm76pI1TJtp9v8EYStsm8srvY0Gj1sQ/nEO8+gfZfhoB+UcKKr7KQ/YqK8fPiKQi3ga4cFlZ7m+CGrp4LpEgz+VrTRK1wobr0mjPCJB8KQL4+9t8O4+lDvqSSEJXxYDihJy/7J9Vu+RKRj0U9G1w0GEdMETCW+BplmeoZrzTTrtSIBnqj/l6uGt71d+WGz8pHkJ9hq4dbRN/laO8uwHCfrH4LwMI+kRGy26LJwCHoNSkY88NXfdeTwR6cbgQM+AkIgip9T7iDAWB9xV+9X1ourN7KEf6QbZvpnVq0cov4dbdknK0pRHFOHf38ZZ1AkIq+D8r6BbmuASCKC5g7HW8K3YRIkuhENvgKxJQ9tLLMXEeNEUMzXMdyw8gidbO/67nVFpzAYtkSUpltr36gUmWlbFPQb0vPWD/PymX684K5C2uognVgPM7lorSDsXqSINeDGRpXZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(19092799006)(366016)(1800799024)(376014)(22082099003)(18002099003)(13003099007)(11063799006)(56012099006)(261021123027099003)(261028144727099003)(261026140227099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261009223027099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVUzSVJQRXpEdG1jbmllNlIzR241aGlveXNmbU1qcVI5TmFGaFF3UHRvamhu?=
 =?utf-8?B?RU1yTHd0TXdKczRwejNGVlhFc1lYT3R4RFlJTGtFRlFuZkpoR05ocERJVWNK?=
 =?utf-8?B?UGhCUWVSdHM2ZWV2Q3A5M1E3MjgzMlZyNnRORXdIWjRrdHMwckRnV0V1ejND?=
 =?utf-8?B?dHcwbXFScDVHeC9jSVhTNnQrQjQ3Y1FpRzlpTmtlM0JjUUJhYkdNTzRQNGtE?=
 =?utf-8?B?azdlL2JyeUpSVTdzS2hZMzFFZElxT01Hc1JlalJiREQzcisvSFVzLzh4VVZl?=
 =?utf-8?B?UXUzUzVCcWJtNlJMOHNlQytpTWFGTmF3MFpieTJPTmtNWmtydDh2Mm5UMGQ5?=
 =?utf-8?B?ZjEraG9NTUFRWW5ZUWxBY0M3MVVrQWtrREcwcVNzbWZqU3haY2NseG1HMk9z?=
 =?utf-8?B?WEZ0TTdkM0xhRjJ4WVAwd0RVVlJNQXg1WUtIU29CTzBtZ3F1VU0yK1IrSjhx?=
 =?utf-8?B?YTlqRkpNdjdYNVd5L3l2alV5empSUFdkbG5HSy9mc2Jta3Z1QUlsZDBZUDhU?=
 =?utf-8?B?YjkvUUlOTGpXbWpEU0t5b01lcXU2SjFqODcwK1ROc3owQWcrWWw1VElpcEpp?=
 =?utf-8?B?bnczbFFTcUcvVWpYU0lNZERMdUcrbmx2dUFDYUwyZFFhV3RjV1dFVHk3WDhv?=
 =?utf-8?B?eDdQTTZCTVozUndQQWRFZmhMMHJYL1lZZG12dWMzUDhFWHQ3Zi85OTNFeGhE?=
 =?utf-8?B?OUg3bUFGc2FaalN1aFppSUM1bjZQdytHRXdvd3Y2OGgrcjFuOVNsQ3I4OTBr?=
 =?utf-8?B?eFptbEZEZHhpeE8wcDVXTzAvR1J2azlYbVl6MzFXeHRWTTNpOWdPMDVVWTRN?=
 =?utf-8?B?VzAxUlBEempJUk02eDNMSU5EcHB0RDFKRXU5azF6L05MVk9NbDFNS251eUFL?=
 =?utf-8?B?NWJlVkZPSXVici9YTGp0Y1hSSjVpUHozMmZtRFc0MnNnT08wY3BlOXBWOERx?=
 =?utf-8?B?NUFQWWk3dmNjUDgraVpuM1A0SE9vNEY3WWk3V2I1Z1lsekxjc01qb2krQ3g2?=
 =?utf-8?B?ZWo4a2sxVXhiaXk5RWtyd0I5b1pCY3F0VWZBekVCMGlzT1d4dEZHM1AvQXVE?=
 =?utf-8?B?cWJRSUlXZmdRV1oxYVBubVFBSFlndmszZkFZMTBBQ01iVEcrY0ZMSFhWWVM5?=
 =?utf-8?B?ZVBXRm9hdDkwQlk3NnZoWGlLTUQ1bjVYMi82eVFBbFlWbnBtZzhUazJXZUwr?=
 =?utf-8?B?OXVrMklUV2NEVkhvWld2Y0FBcWhmc2pyOXlaRVByWG90TWRGdEtnVEF3VWt0?=
 =?utf-8?B?d0RPeHpMeDNMQTNnZ2oxYnRGYmllNG44SHk2dlBwcXhzZG9NdVFnUnRiWGdJ?=
 =?utf-8?B?ODlQeUVvejdCQjJSYlJkZkQwUWpQNjY4NlMrWUhvRWZIT2hBc0ZyYTB3ZzlP?=
 =?utf-8?B?THhaTE9MTVp4dWpsUzMzcXpYVnFEclZlZ284eHgzdU1yM1VTcWdHdWxVd3Jx?=
 =?utf-8?B?NWhINVQxNkpyV0dPSlJBK2lveDlEUExvRHVZeUE4aEczZHdwTGNVZi9qYXpX?=
 =?utf-8?B?Y1lHTnJrVDhyR3JZWWZPKzVzaVdwY2hQdDJQSzMybzhKekltWkY1bTBMVTlV?=
 =?utf-8?B?TTFCRGFEWm1JbEhjOGdmblZGNzVSRHdWa1VEM1liclB2K1c2VldaRi9IQUJJ?=
 =?utf-8?B?a0VoYjdEZG1oMndKcUxXalIydUxLY21YQjlFNVNhNkZCdjRzTWZiNHFCRjFM?=
 =?utf-8?B?KzVtdnB2OXRsUlZXZEhrdXMvSHpyN1U0NGJ6VzBPK0ZHNWxIYlRLdlVZZytU?=
 =?utf-8?B?OFR5TVhaN01DcE1KM0VWYS9kbS9qMEZMZitzZWp1d2c2VTNTbnNhajVDTm5l?=
 =?utf-8?B?c005dXJBOHVOL2w2c0ZzdjY5OEFLZjZ4aG5qeGxpOTdlWHhaVG1BSXRINE5q?=
 =?utf-8?B?VDQ2VCtSc290NDZvZzBDbFNocEtQZ000UVE2Qk1zektJeGdQcWZBS3VQNWJq?=
 =?utf-8?B?a1dJaTNiTkNPOVhkcVN3RWhXdm95QVM3UzFiRWh1WXQwSWIvZVc5UlFlK1VX?=
 =?utf-8?B?SnN5RjlKYWhCUURHcnNtbVZ6KzhBU0FTcU5XcWtwVklBZktBYWJCSktieTBP?=
 =?utf-8?B?THBEZ0JFMDYwYTZMQTlreXR3M0E5Zk5mY2IxR1lWaGF1dm9WNC9RK3hJdzFt?=
 =?utf-8?B?OWxOV29scXdrSWt3UktiblN2ODZ2UFI1TTE2SnFLSnh6aXZmMFM5WXNyK2tt?=
 =?utf-8?B?ekNaSitHM2ZUNUNZeXIxNEluQ3l2YVROc092cjR0MWhSMHJNbzRiKzkrdnB5?=
 =?utf-8?B?amJFT0FwUGpHSUVoNVFnLzkrTi9Lcmt0SjRNN1JCMDZWQkVmVmhjZHBiODJs?=
 =?utf-8?B?R0pUQm1TSkZrMk9QeVVGWEdBdlhKYk9FOXdWNGhzWTFGeGlpOGhxNmNWRmhO?=
 =?utf-8?Q?gweGlZMY+8ie4nS8qymgLRykkZUKRfqqWbhdxLxRFjY8d?=
x-ms-exchange-antispam-messagedata-1: 1njjxtiodOWc9cytgZIrCdsYFwwvIw4fzbA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A057ED44F9652458B2C86FA7EB068F7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dGLrirh7jBGPAQqFbKWVTNdb82hVetWP6gL1ZSqXdznsOw6Ps/x2B7bmRIZKSqJ2i79Crq2pXKuVhUj2ibPB8aU75Nk13YQ3e8+9aulHrmcRX6C65ilAirQwVou6F9AJcrELMxv440JhZdeRub3/1ktGnTGdSsR0c99jt/e92WGH80ERxJGSI2m7+NmHBKPfYsWGZwApczZ4xo7xGJkC3Ei1N5va+ktmq6rKgur2z2X8jWqQ9OhAfuRnLF8pRBpBJpjhIK0HxiiOfCY/KIGShZ1JinS4Nrnqw/IizAwPQX7zMq55VL5GTiK8P9/Orbr226jH/omuiGDkezAI0sbdAg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Jn2xuLOnc+moL4k+sDhpGjxPvfP0U+/o1j+8tD5JKa1ZBO7uuzkGjAmfCPMFLGgNCySXDrwXDlGIyl0Krmk+Oh4F8nyBWDSAAw3nqfnN5q8BUavWDe8PgJOjLhb6Xa15c4EX4I4jCPfJIXoWED5EVPvBx8FtVG1NvK0CO74vfvNyFIGKYeytn1mhDBo5dUdtTv9F+lOe3DYofI3idgz2Dp0m4Tt8sx2mEAK7RaskxxxtYaKeLYHcCs3XCBNTcs/YtEEfaB/jNzzAKmBY5dNMbN5VUV9/tIajMlNu/fBEL3VcRN5tkNcCmDWxad4oOuX3UKHYxjft8SBJTP2jwoCVecKKPhA7TieZMgC8HYn321tb9QgjTyvcbBf6felHmGQP8AmIWyoABIM5x/lMdXN/KA/hKB80Tiav6HVpkOm5i8GWgrg25d5sXp/e6soN390e/s7SqRPJqz0gg7oWc1inGChh//fWz0l+fzAzaa1orV3Vhn/2KvrdwNzsIrYpe3pVzeP+82GxO8JwThSRA98wT9nL1M0mgvtmHdGnlUyQZJFR11H6+gkyxSPAoe6QhyH+i0DjWMct28Gkj8prsvVs48sEOoX2+Nx5piJjLoi3LcjMHWixd+ABndV0C2/jy5r6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec1d06b-c31e-44c6-c040-08df49134cd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 03:38:55.1226 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uM3zFLO/TKb/DzDovlJriSEHNSI3NTREjVLucWBjO9E+axFpfgs9UruV3JI71OO+Ts7xyuiQWL0hhKkV65GV6LrjkZcCQt4ZwVoKj6pZ9EI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8163
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=780e1cc66=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

T24gVHVlLCAyMDI2LTExLTEwIGF0IDE4OjIzIC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gSGksDQo+IA0KPiBUaGlzIGlzIGEgbmV3IHZlcnNpb24gb2YgWmhlbmdYaWFu
ZyBRaW4ncyB3b3JrIGluOg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZl
bC90ZW5jZW50X0NBMzgwQ0JGNEE5OEM5OTBDMDdCQzA0QTlFNzQ4QzQzODMwOUBxcS5jb20vDQo+
IA0KPiBUaGUgcGF0Y2ggZ290IGRyb3BwZWQgZHVlIHRvIGEgdHlwZSBtaXNtYXRjaCBpbiBlbnYt
PmJhZGFkZHIuwqAgQnV0IHNvDQo+IGl0DQo+IGhhcHBlbnMgdGhhdCB0aGUgcGF0Y2ggZml4ZXMg
R2l0bGFiICMzNTAxLCBzdGlsbCBwZW5kaW5nIHNpbmNlIE1heQ0KPiAyNi4NCj4gTGV0J3MgZ2V0
IHRoaXMgb3ZlciB3aXRoLg0KPiANCj4gUGF0Y2ggMSBpcyBhIHRyaXZpYWwgY2hhbmdlIEkgZGlk
IHdoaWxlIGFwcGx5aW5nIHRoZSBmaXguDQo+IA0KPiANCj4gQ2hhbmdlcyBmcm9tIHYzOg0KPiAt
IHBhdGNoIDEgKG5ldyk6DQo+IMKgIC0gdXNlIHJpc2N2X2NwdV9jZmcoKSBpbnN0ZWFkIG9mIGVu
dl9hcmNoY3B1KCkNCj4gLSBwYXRjaCAyOg0KPiDCoCAtIHVzZSB1aW50NjRfdCBpbnN0ZWFkIG9m
IHRhcmdldF91bG9uZyBmb3IgZmF1bHRfYWRkcg0KPiAtIHYzIGxpbms6DQo+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvdGVuY2VudF9DQTM4MENCRjRBOThDOTkwQzA3QkMwNEE5
RTc0OEM0MzgzMDlAcXEuY29tLw0KPiANCj4gRGFuaWVsIEhlbnJpcXVlIEJhcmJvemEgKDEpOg0K
PiDCoCB0YXJnZXQvcmlzY3YvdGNnL29wX2hlbHBlcjogYXZvaWQgZW52X2FyY2hjcHUoKSB0byBh
Y2Nlc3MNCj4gwqDCoMKgIGNib21fYmxvY2tzaXplDQo+IA0KPiBaaGVuZ1hpYW5nIFFpbiAoMSk6
DQo+IMKgIHRhcmdldC9yaXNjdjogcmFpc2UgYWNjZXNzIGZhdWx0IGZvciBaaWNib20gTU1JTy1s
aWtlIGFjY2Vzc2VzDQoNClRoYW5rcyENCg0KQXBwbGllZCB0byByaXNjdi10by1hcHBseS5uZXh0
DQoNCkFsaXN0YWlyDQoNCj4gDQo+IMKgdGFyZ2V0L3Jpc2N2L3RjZy9vcF9oZWxwZXIuYyB8IDkg
KysrKysrLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCg==

