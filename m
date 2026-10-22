Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3422606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 05:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=OhJPUQUr;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=PDSCfmPp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJl4Y-000829-Rd; Thu, 22 Oct 2026 01:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJl4X-00081p-95; Thu, 22 Oct 2026 01:10:37 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJl4V-0003ic-Bv; Thu, 22 Oct 2026 01:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792645835; x=1824181835;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=OjAJndjLVUCOaGIlpHuYK9siaeWwtXAissLgnq1UMxA=;
 b=OhJPUQUr1Eb136jXCq+BYmiWNhC8thXZqz4pjN9zfn1ggnKlq7biDN/c
 56MQe2040xE0Dv9J9nmwcutsu1vet0ELm0ApuwJiDU2kuUMId3Cdv8nPC
 SIrJb4po/4UjGKTRIAIcVwSpGMoDEC9mrvFWHgpVLxBoXidkblD8+kkHp
 MYqqbdUFSass3VcLjuWPE5LI1lowNsskzVFQi2+Ehk/EK9fTHYI5dSLh9
 UY94VND9/eDaLo8I7vrjwWs+Pdg3I4SBcGdUxe3aUTRCk6Jvye1OgCVcX
 y4F+yAZFaN/by9RLljUG97B4Cukp32oENl/Ez0x3mKvE48zVq+BD/Th74 w==;
X-CSE-ConnectionGUID: 0qvbXXSPTSCFMf4Fzi0TEw==
X-CSE-MsgGUID: e4bIThgyTaSRdVKXcChj1w==
X-IronPort-AV: E=Sophos;i="6.27,171,1786982400"; d="scan'208";a="158709858"
Received: from mail-northcentralusazon11010009.outbound.protection.outlook.com
 (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.9])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Oct 2026 13:10:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WY0MK1Pd0y5XEdanO1mLcZzB7OP+qMGVYI2e6nDuJTZqpUiNv6PzAVcSmsAkbpMWGvus+ukD7YjykHsJk1dpZs6WogBSqYnjpz3K8gOzhWe1QKeKO3tqpEqLPGT2voM2FOGyL5aL0g+8XDd52raTKhc4p6IEDN30fXfSQgmvel4hspB5Y9X719kKnnynnbNylVnjZFdIedz9a9xIZFG/dIiuRp7G/SIVujRSHa1Uaa83wQk13zTrp9EhbWs6zkrZhV1U7xNrhtKuH67CEh0QHC9bLWzggvqo2Mn/gwevKGzy6oaxJyK+vsc6Atz73jVG8wt4A6W5PIFlDOT02jETqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjAJndjLVUCOaGIlpHuYK9siaeWwtXAissLgnq1UMxA=;
 b=stWuT0f1Ui+0hDJ3a67hiqU/D4lfiXHJZ885ce5nPYckCx7SspKs+1H3M31XpBX1uNUOXLse01qSRAqfqpsWB6mHjeNAlPlsMiVt5IaeoSo0DLhrC9FH61qJ1vODAcD4fddUxTQQuyxMgrV6NsTbjeD6YSPMNyPaG2pd/YS+0CsFH4xKif6qwI0xE87hiQJ2nLbWpH6jCzVsq0+LSOxtb5gqFc2+OsF4sHvn83Ri4RLXwPDt7GxWPcA0/LhDurlsVw6gUaX/PWv+yscrnyYEDJHVtqa/FZv+ACy1Ndgkg1PtjvDPOqs1s2PvzZoimLmQeqzM/ktYXZacjVSY/Aik7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjAJndjLVUCOaGIlpHuYK9siaeWwtXAissLgnq1UMxA=;
 b=PDSCfmPpd3TLzWzIyVNuPgnWCHIrqiM8ukha2KOJgOxEpshs5mcmnpzs3ToX5OUME5UKxZw7t4ZHWNZ0P4KZCrtyA97kmwS/UE57aH1jC9fP9ItTRcSTXW9L7esV55FDmrl7bGZtWKWPlYytkxd6zqFtQ+R6Q0DAwCYKtgfTkiw=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by LY0PR04MB550669.namprd04.prod.outlook.com (2603:10b6:404:217::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 05:10:30 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 05:10:30 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "wangyang25@otcaix.iscas.ac.cn" <wangyang25@otcaix.iscas.ac.cn>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "zhiwei_liu@c-sky.com"
 <zhiwei_liu@c-sky.com>, "liweiwei@iscas.ac.cn" <liweiwei@iscas.ac.cn>
Subject: Re: [PATCH] target/riscv: mask inactive senvcfg.SSE on read
Thread-Topic: [PATCH] target/riscv: mask inactive senvcfg.SSE on read
Thread-Index: AQHdXHwHOiG4nPaMhU+FuyqJwVOxWLcJDleA
Date: Thu, 22 Oct 2026 05:10:30 +0000
Message-ID: <54e78d641777e7830ced9bbbc84739c6c5afd979.camel@wdc.com>
References: <6AD0895D.0F1C23.05843@cstnet.cn>
In-Reply-To: <6AD0895D.0F1C23.05843@cstnet.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|LY0PR04MB550669:EE_
x-ms-office365-filtering-correlation-id: a87e37f0-1817-44d5-c266-08df2ffacb18
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|10070799003|19092799006|366016|11063799006|38070700021|56012099006|261009223027099003|10067099003|18002099003|22082099003|261021121427099003;
x-microsoft-antispam-message-info: mScLOBWgoiG5QwxoKJOU/kJtC2NydrBShRk01Y4lMPkwdf5yJc4wBglA0iF8uMmSQGelahDJghvjWG6Hj09Aor7/dZOP4h1kvGTK+DoRlE6Kvw9hPmQZ6UdFnhV8rYg28PAW8LQuOPTl+pelUEZo8oF5DWz+FKp9EQ4H0y6ZqJ5ZjYQ2TE+W5FWdQpasUK510lssFpHibn7y+lOuXrXVmhiwADZYaZKkNDDcQ25UJ6+HEsmGOSMuybmKRr/3sI0Q74Vnh8ek5cPLxS9CV0p9w9hm/1e7+xUe7/dtUv2HMdyviirlVf8Oq0PWTiQqgl9JmMZ6BN4OaNtjaOKGpBzqUY4SOzB2DWZS0O+CrNe462zDHxVgWJ9sz9qlgwsuGMnAlOx/o9xHAXg0qcHLNlSQ75D3dW5Eoxw4rXRKPI98GDh6nkpFmLoJjsRW8X9agj/MRC+aLxd28UefgqkClL9WBX6cj4KJocrUW9IsLFju/JO05wJeaeUy0k4wUNH2YkDPxD4F2lNhVILbCC176n6ayxa+W9z55JHtXtG7FJwrWzqcomGs4pwvnmQUP4SiGLvj7DPsfxZIn3IgKlaWTMl/Bu6toA2asXQ/QolbKRn5zubzt9h4p/42mli9zN7bYmz6rEo8+DO14tRquvs7Y1L8cqL07xGqx83+sWrFZS9qcRVlA4N4iZpnztANa5QOowo9m50/47yh47X3eEfIU4ErAykPrbUuA/1KfBlq9Jiy1WU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(10070799003)(19092799006)(366016)(11063799006)(38070700021)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEMzQXFndlF5ZjFCeGNKbktpZmR2bmZ5ZmhQOFJTeVFWT285c2FXRzJzWldK?=
 =?utf-8?B?aE5pa2w3YXM4SjRLZ0JFbmI1a1hScmlTQTkwbXRpTjFPeVJIR3JvN1hPNUFV?=
 =?utf-8?B?VzJ5Q3lkaTU2emxoZE1ZRUgzaWFBTTZXdS9wbUJZekJRNDhxdnRtbSt5R2hL?=
 =?utf-8?B?Qk1YcHBMT1o2d1h5akNVU29EOHdtVjhTb0Z6MVNRa1dGbkFYVTBhL0kyQ01x?=
 =?utf-8?B?VVlKcVBscE9NNHFXQzdMbXlsbGt5NlMvSUtOcW5HNG1hSllwL0dJWGdGM2F4?=
 =?utf-8?B?NEtLcVkrTlMrb2EzeFhzS0N1R2g2NTYvU3M0cW0yWEV6Tnd5VEtrRG1yc2dD?=
 =?utf-8?B?WUJOaXFtVUdTRWh5TitEVTF6bDQ5L1JXc05SNUlYS2Flc0xRLzlLd21VQkcr?=
 =?utf-8?B?ZnluTlNTUUF5Q3A1VmwxenJYOHE5MmpMMmpNMERqaGc3dS9MNzloR2NkbHph?=
 =?utf-8?B?T21oWUxpNjdnd0JMVklpdWNwOWsrbmRFTnRuRWxndHhvMXFYMzNLdkNqdEdT?=
 =?utf-8?B?azZGV2pscXZLbUc2WnpaNStrYjhtNjFSbkdVaUZ2WnluMWs0YUFYaVNVMm03?=
 =?utf-8?B?SnlDenp2OWpKZ0FZei94VGN0NHN0N0JGdGUraWdEWjY2WXhET0IrMytQWkVH?=
 =?utf-8?B?RGZCb1l0UzF6ZlJzbW50aFJGd2E2eWh0ZEU2RG1Wd0RlYTlLNXM0QWh4OXZJ?=
 =?utf-8?B?RXRTOHhMUWp3eE9lQVhOcnVlQ0JZYzhmaTNGT3I2NFgvbXl4UnNyTHVLWFFX?=
 =?utf-8?B?SUsyQnJvRmt3SU5INEtzblpIbHV6RmpNdUw2RmllMnFKVkt5ZXpGZnJVdEw4?=
 =?utf-8?B?bk5QY09ROXdudVN4SjQ1YXRFTVVvVU9VSnBORU8wamt3UE5iM0VFSkg5dy9j?=
 =?utf-8?B?YjU4YXhjNVZYVFphelRIcURXUVAyMVExd3dxWDc1ZWN4OXJ2YmVDbm42d2NQ?=
 =?utf-8?B?a1JpWDAxQzBrZEIrZHJnTTZyYTJPa3VHQXlEWllBZGhpazduMTFHbkJ2TXFl?=
 =?utf-8?B?SURvR1FwVCthSGRzY1p5ZEM2OTFkRG4vaElPVjJ2NCttNHlJcDV1T29jZnZX?=
 =?utf-8?B?akFEdVBBT3VZWnczVkJWK01ubG5NVkJncFBFa2NmQjN3L1hvd1VNUmZmUXYy?=
 =?utf-8?B?QURtUWtFdWlVSWFUdmFKcDRpSHZjWEFZNEhaRDF1dnRWc240SGdLVXJCMTcy?=
 =?utf-8?B?VjZWK2FNYk9odWIvNi82STVldHZEUW1BT1FyREJVRXE3UVd2OW5OdjhSaUUr?=
 =?utf-8?B?Y3UyZEtBWlFDaXdFRDF4UEJ6OXc5RW11MUdRelJoaFgvQW1yZGV0SmtVcVFM?=
 =?utf-8?B?MTlYYzNyMUJyU0h4VjVROEI0dnVFc05JRWx2WjdSZkdWYTN0QUtBWklzaTRR?=
 =?utf-8?B?Uy9RUUF0U0RET2ZqTll3YWJLM24wWWJMUVdVQ1o0VjFiYjMyaGdkNWIrUkVF?=
 =?utf-8?B?RStTM0paR3ZiUmVqd3g3UXFwNUFVYzRwMkxCSXB0OGxwKzlUUk54dEZ6c2FW?=
 =?utf-8?B?b3FIamdtbmJVaTB5cEFpNkt6U0N4VUlXWkh2RWdkSndiSVFSUURDVE5LRWw0?=
 =?utf-8?B?WmIveWk3bWtwSks1M0ZuaWxIRERGczFrL2s0RzlNUEFlZ0FWSThVVWJuU2s3?=
 =?utf-8?B?UVFuMzFBMEdlaksra051bnI1dG5QY1VYTW9zVE43WHNrUnIrcEIvOGFNYWZF?=
 =?utf-8?B?dmsyVGNZREx6eGxyb1BCdE45cjgvUmx0cUNzckZPKzV1OS93T3hqS1FKenJU?=
 =?utf-8?B?aGc1elpreC9tQzFybFZQbW4zVTF1cEJxN2ZiZVFScEFldjBUS2FhR3gxQVNx?=
 =?utf-8?B?d2xCclFsSGUzRmZVL1pYN2x2M25kSlNzb1E3U1RvdHI1bU44TW12WEp1MDJX?=
 =?utf-8?B?N201WnVYakx2T3VIL25VdUtRSEJKREU2WkZMV0huUjRjMk1KeGM2Skc3cEV4?=
 =?utf-8?B?SVU2MU9TU2Zwa3pNWVNlYXA5NnRSM3pSbXBJekJpQ2FvaXBORUM3R01lWTFv?=
 =?utf-8?B?QW0rMUQ5eWh3bEtQbHlsSWQrdnk2Rjl6cUowY3dsbzNSZ05JemNEMStycHJx?=
 =?utf-8?B?MFBBZENUZWtqbzk0d3poKzR0RDYrd0JFbERleDIzQUJrUEt5RXJOTVFyMDdm?=
 =?utf-8?B?a2xvRUl5dHRXQzUxVTlqOUN1cVZoYUpOQ3l0dmExY0c0RGhMU1djY2lGL0dZ?=
 =?utf-8?B?ZCtKcGkvNVlVRUhYYnFVSHlHNHhsNjFEaDNNYjRvNE5VbDc5YVcxSHBnUXJP?=
 =?utf-8?B?RkZhbzRwRFZIb0w4QWtTVWRKdUdEVTBHcm5GTVpabWlJZ3l1eDdnOENLUldH?=
 =?utf-8?B?S2QzNzE5V0Y5RGRmaStGKzdoc3ZNTVk0ZEZUeDFoeE5MRERCVkwxNnB6RDZK?=
 =?utf-8?Q?zFLPeEIla+nczpzzl8UeUnH0v3P5lq8tZqGMGZBbZNF6H?=
x-ms-exchange-antispam-messagedata-1: dS2IO/afoxOpSZ/3B/eHEeqvvpMIVxJhWqs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9AB4BA8F2FC0C4C92D30EB3265CAC7E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: k3/P1mC4D3qjZTfkqaQvE8tvFzRemeCbmZyyxNCs2Jn21E7+gkbhMThu8fSYPxVXfCnX4zPJ0fIO6W4hd7p2q9Rnh5S0mWN/dDmUcZ9Q3Q8A/ypN30S+kFqnc7dIypvNJDF6UKenLRv5gdckdD716huqX/RuTRWWr8FznBS8gO1OgwQp0cxkIc/rlV8hAt79ELvAuhQs366l8zAFJEdMjtXrXsBUK+XgsVEzn3UIBq1i1xkjYfn6lVmvxTsNeFoYk2TII/mQJHJyMY/cg74PcGmJf2TQ6MGTmSI8yMvtmUTCg8jGCV3qRWgL/BqbltJm8BYgmfUKkS8S0uA9WROquA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +gMyeHJYb5YklnDZq+6HGuj37ICmPUwiqJ1swwuT8frJFWBSrbvUKKpJVM6d4AlKrjndArF6pRmrrOLANHDntMwl3zvvGYW74F0BG4xWKFAzuBjl2gYqynF18t13Rl71eROUXNpL6eg+bo1t9lv5EkcEYviVITtJFKxWTlpXcCUy3IzQX7p5BQgH8CJe6t+UBGpt1905nxu892XZq0OLcjhqwD0UWTGxZWK3BiyACYU83xQPdkg48mktUfnJTcYjXcy/wO7d3D5gMELcfkqxTm8Rnin2idsdv6t7yaB14HdxRNFQo9jxNW8TbQOvE1J+Q+Frib1UNG/3cMRxiQrxzRIy/zqWb8+UWkAmA0Cymqif5bi3GXzLqJIyCwww7XAOgf1upGsf2kw0+zdiqYKfB84w6mt4J0jCnwFZ+uKGVwneGcQtbhYsPnjXM4C5ya9HD/qkEztKlF5d7eiiyUWaPikwc2RgkdCSh5HsN+5WacycUAN8TSCXvhy1Cb4NbYkYxzWbaoe7pyMVzFlBb9PUQsHeXurPE9sZ0oEQxlbWyJkWI/+BfBaDCoV6wse4QBALEiJn3nOOZTxOwNmov+SJQ0PUS5FAIEPK0g04y7e7KeynXENxnE8GaoZlb8AoqHBn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87e37f0-1817-44d5-c266-08df2ffacb18
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 05:10:30.5188 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4c/e/0PbTIBGQ7iWO6eV8rMKxk9w7aDu+tW3cT0Pw9teQ+EP0Zr16RJ7AStTbvPnIoYdauRxWY9vNvpM4MHkd7IWnL5NwdWzLyh+pm3S/C4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR04MB550669
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=748e7da1e=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTEwLTE1IGF0IDA4OjA1ICswMDAwLCB3YW5neWFuZyB3cm90ZToNCj4gVGhl
IENGSSBydWxlcyBtYWtlIHNlbnZjZmcuU1NFIHJlYWQgYXMgemVybyB3aGVuIG1lbnZjZmcuU1NF
IGlzDQo+IGNsZWFyLg0KPiBJbiBWVSBtb2RlIGl0IGFsc28gcmVhZHMgYXMgemVybyB3aGVuIGhl
bnZjZmcuU1NFIGlzIGNsZWFyLiBNYXNrIHRoZQ0KPiByZWFkYmFjayB0byBtYXRjaCB0aG9zZSBy
dWxlcy4NCj4gUmVzb2x2ZXM6IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVtdS8t
L3dvcmtfaXRlbXMvNDIyNA0KPiBTaWduZWQtb2ZmLWJ5OiB3YW5neWFuZyA8d2FuZ3lhbmcyNUBv
dGNhaXguaXNjYXMuYWMuY24+DQoNClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlz
dGFpci5mcmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgdGFyZ2V0L3Jp
c2N2L3RjZy9jc3IuYyB8IDggKysrKysrKysNCj4gwqAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYyBiL3Rhcmdl
dC9yaXNjdi90Y2cvY3NyLmMNCj4gaW5kZXggMDYxYmM5ZC4uN2ZkMTQ4ZCAxMDA2NDQNCj4gLS0t
IGEvdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYw0KPiArKysgYi90YXJnZXQvcmlzY3YvdGNnL2Nzci5j
DQo+IEBAIC0zMzIyLDYgKzMzMjIsMTQgQEAgc3RhdGljIFJJU0NWRXhjZXB0aW9uDQo+IHJlYWRf
c2VudmNmZyhDUFVSSVNDVlN0YXRlICplbnYsIGludCBjc3JubywNCj4gwqDCoMKgwqAgfQ0KPiDC
oA0KPiDCoMKgwqDCoCAqdmFsID0gZW52LT5zZW52Y2ZnOw0KPiArDQo+ICvCoMKgwqAgaWYgKGVu
dl9hcmNoY3B1KGVudiktPmNmZy5leHRfemljZmlzcykgew0KPiArwqDCoMKgwqDCoMKgwqAgaWYg
KCEoZW52LT5tZW52Y2ZnICYgTUVOVkNGR19TU0UpIHx8DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIChlbnYtPnZpcnRfZW5hYmxlZCAmJiAhKGVudi0+aGVudmNmZyAmIEhFTlZDRkdfU1NFKSkp
IHsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKnZhbCAmPSB+U0VOVkNGR19TU0U7DQo+ICvC
oMKgwqDCoMKgwqDCoCB9DQo+ICvCoMKgwqAgfQ0KPiArDQo+IMKgwqDCoMKgIHJldHVybiBSSVND
Vl9FWENQX05PTkU7DQo+IMKgfQ0KPiDCoA0K

