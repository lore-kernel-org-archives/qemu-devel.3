Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C723606A329
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 04:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=KQzRXDkU;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=cAu4bpaO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOpYO-0003bA-24; Wed, 04 Nov 2026 23:58:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7622369f3=Alistair.Francis@wdc.com>)
 id 1xOpYM-0003ao-MU; Wed, 04 Nov 2026 23:58:22 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7622369f3=Alistair.Francis@wdc.com>)
 id 1xOpYJ-0004Xf-HF; Wed, 04 Nov 2026 23:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1793854706; x=1825390706;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=wsyMbOCYmXHfd1r9d2mvzkJFpb9w5/+jp81yFK3qXVs=;
 b=KQzRXDkUECSHL4T0LO4tLUnoa2rjgBiSjeYVGI3X7wy6P0QYvGT1HrRU
 MvX15BAkz22/aNc4nL1EYV8tQORWrL4cJQ7zKjiUMkYRwXGpD+2H4BcJ4
 8vAzagbrzrxxYxz49oGDeaOM7UXO6UBgnyqgmsUiDVS3GTE/uTUTaljhW
 aN3YMIsT2ruLORjD+XeaYn8zjQLdN8WzLuj3+Z68eqHG5mj3dqXqkyohs
 aAKHpypYKRnnH9VjtOeU/12bJamocCY7rpc/r7IEcpORnAYNGUJHJvRZg
 WwKuC3NR565PKul8/yqyaNPdeyIV3xwkGps/hnvdinAm+zbw6kNykW9+j w==;
X-CSE-ConnectionGUID: b9zqDqZSSC27TsTLTmtr5A==
X-CSE-MsgGUID: ISGPYqdUT+uWMJ0dzUR17w==
X-IronPort-AV: E=Sophos;i="6.27,196,1786982400"; d="scan'208";a="158897449"
Received: from mail-eastus2azon11011070.outbound.protection.outlook.com (HELO
 BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.70])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 05 Nov 2026 12:58:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0tDg99gCjWAZt8rYP4f7XAzf9xT79pi18VcudEVgh+3caZ7VyNQBvoP3d5jZPdhWxYTDrgAlwgdw36XobqHCm8WFU5CoEr0i8vlLBz0svdC2UwQkoPaiX3Ik4JkdbshdIv2C7seOqfVcdzzWglnF8zTmCXIim6cac8n9O3qoZ+ZK0hQDKGdYWl808Li/rY7UHXSj8FDPp2DPqa/kkICVkDaj7tct7k0HFJlNak0iJhwYh2iFKmyiVrMaS4iMDtTQsMfa5OrKZZE/EyX6+nF2Aa9QqvU6ywYOGk4FywSAgvWjIP2CL2+7AQ00KO4X1X5Hz7IG3mjos8MvcmKg+kVkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsyMbOCYmXHfd1r9d2mvzkJFpb9w5/+jp81yFK3qXVs=;
 b=BpG61lmSBeOzehZZnorudSivdf3GZMDIPJhZPz56T5NQ+c/LYz43ngAhs7G9m7r2lFPnug6OPJju2h/v7BGHkL9eL0MI9oZmKFAAMM3Pv1xAMR3PIZdlDkzr6cH7P0uwogDjaqq0YE0RkaUy7BFG7+AcEgi5okKs37WsuGv7saJn+LJDo9vtEQeR2khnAB71lXBtb+38V8Fxlk6ElocGS+pUlam53zDmsKjvBWlm0qS1VCpBrBwdwIxpxMAyg8jDGgGTwTXul84t/6OhBBBlVktmkriXWAhcIzd/MvTVqJSL/DlzKj6RLJyR1G1cXQFkQ8nHEkVIntRYdezaEKg8DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsyMbOCYmXHfd1r9d2mvzkJFpb9w5/+jp81yFK3qXVs=;
 b=cAu4bpaOFlJo6Jn2OH8ov09jsx6hGaLw2EOND3mxYwaMrjpXPnHhwgx+dx1Cv7r3lw6K6EGOkv+NioN9EeNr5q20rWht82cMKqbgGzYZw3xop94z9iZIyRAo94Lx4CExG6iw/K42tLog9i6GLeFqkGJRsl/DfUC8rlj5Pf+eHIA=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by PH8PR04MB993683.namprd04.prod.outlook.com (2603:10b6:510:40f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 04:58:14 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 04:58:13 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 1/6] hw/riscv: do not realize the device in
 riscv_create_iommu_sys()
Thread-Topic: [PATCH 1/6] hw/riscv: do not realize the device in
 riscv_create_iommu_sys()
Thread-Index: AQHdYwjhW0Cd50ASIUqtDqAoK2ZaR7ce/nIA
Date: Thu, 5 Nov 2026 04:58:13 +0000
Message-ID: <3bdd1bbf2a30ce25c4019b0ac4f3f6ab95058715.camel@wdc.com>
References: <20261023160913.24992-1-daniel.barboza@oss.qualcomm.com>
 <20261023160913.24992-2-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261023160913.24992-2-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|PH8PR04MB993683:EE_
x-ms-office365-filtering-correlation-id: 96ece458-4aab-4297-8b26-08df3af965c8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|10070799003|376014|19092799006|38070700021|261021123027099003|261022105027099003|11063799006|56012099006|4143699003|261021121427099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|261022075727099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: Ghxt0JxHqAAm7brsmXjpy2LR9fyJPlFPygM+hkQxkPs48PBFez3i5JjvRQIkY2O7Ap5AdCjYFCqyL5vsIRyspTl6bkQj/UucirBQZGlLVshX/j2YVWTmVgy9XUbMJ5taax3MXHxaDiMPzpdH8RbytbCHtyLioqqgoF5MWfnuL+RdCGKu7GzrOGhXWzsWpzwVRRQZN5qLZqf7ZJjuJRlakPPKMgXHnhnYf13gXakhk/K092D3yFna6zV9vW451kT+H2Ez+7zLUI5lFHara+LrrLLLOtphR1sBB8YEJiBuot5Xj0hXeHm//Zs1MDQMuc86bW8/byQPZCZ63kI7AJc8v7EH/bmQjRbR2vEu+O+yN57yl90JvvABE34e6pHScGxjrTycDOTGj/RSYT+in8iU43zIP0UTYjZhQBfTbxQwNT+zE4RHIoPK4Kj9eCSN+FfFk8UT1NNHSQn5IgmQLOV1DICexzu29HJ31P+khqpT9s7X97ge7q1ROhgtHzi0LLJ4YHSwfGW+nAnw+Rb8DtU9/z6snGz6dIWaBXY84L9mPG3rp7OfC1U4zy6mIS/lTR2K8yEDxCAzWzuDnNCYL3+JQ5i2FsgMuEWoBgvJySj1j2LZwBabD06CaUqocRGNCr1RV915DetYeHOarBZVo3UH0fA+GBkE+2liOvs1wcOOcaYw2IOZLgRBIzG98upvOOMVXxOgi96BqhDfHWsGCn+nLkF58IRlUDxMrivUFrhpuE8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(19092799006)(38070700021)(261021123027099003)(261022105027099003)(11063799006)(56012099006)(4143699003)(261021121427099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(261022075727099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzBqUzAvUmFoOWlVTWtaTyszQk1CbGhoR3ArcUJvaVNidWt5ckp4R0JnY2Uy?=
 =?utf-8?B?YjRWd3BiRitPR0h5aWFaRytYTVNWY3AzVkxsTXJ2SGwxQmFDUEY5emN6bmR1?=
 =?utf-8?B?T0pnUVlRU0g5elBKYmdiVFV4WVl2TEFBcjdTTitYeXVBVFNzek5xNHZ5TGhT?=
 =?utf-8?B?MisxUkJWd24rTHd6cWR4WXZ3M3h3cldKQlJqMnFucWpteDI1MXRrQVU0dk9W?=
 =?utf-8?B?QjZjUTArdW8yUUh1N3hRZWQyNzhjdHJBNzZmWGpxVGNmdGtGQ0FVU3pPR1FK?=
 =?utf-8?B?WGprN09yVXRkVEtickwwb08wMHlPS2QvNEZPVzJuVThVYmM3OXVqYUlCaURX?=
 =?utf-8?B?KzF0KzhnR1FQd3FvZ3JTNGZXQ0tQK09ZUGNENExsd3NlT2dZdThzWEVsK0d6?=
 =?utf-8?B?cnhYYkxzZ0Nna0NzNUlweW1EN3hmUDNLWDVCc05yTHJNNGE2akM3T09NS0VZ?=
 =?utf-8?B?eEdnaUI0ZFRjcEpoSW1JSWJUSDZ5UXhzQ0FGYWxzbXc5NzBJWUtDQnNrSHFs?=
 =?utf-8?B?bEFCSGZyUjFJS2xzM1UrSGNjRmh1V045WkZmb0JBaXhZazZoNzg5ZUh3bk45?=
 =?utf-8?B?dlptbTc2eWtrcDJDdHJpdTZqTXB6blg2Z3NoMzMwV0luZWhzUjlHTnNYeE01?=
 =?utf-8?B?T1ZXWG95ZXJkUkhuNW5qT3ZJZGF6VGxwaUhydFZWMVE5M0xnOVZxdkU2TXVL?=
 =?utf-8?B?U1FlMitLMUpQNzhDOE1pS0RpWXdmVHJNb1NlelM0aXp4dUFCN2lmN3JJMi9X?=
 =?utf-8?B?amlVTWpOeU5jRmRMS0k3eUQ4eEFqVmpCZnVvMmlBaDZMZHAvQmNJRGZmbjlQ?=
 =?utf-8?B?SDRnNWpMZW9tRlRmd2pObUVWRGdPMHB5SjRkdGR5VnJrNEZoaTZWV3JyRFNu?=
 =?utf-8?B?d043MnFQUEFiUUJENWVDRElkbVZaRDVoV21uU2hjTVRCZUpzNzQ1K0JjajU2?=
 =?utf-8?B?TmxmcFVaYzdGZlltaEZ4aW56bHFtaXBWT3drd3ViOEdmQVVjUmdPMHZPN294?=
 =?utf-8?B?RTZlMU1jb2Y3WmVxc0pKclZWTVlpcDJZdnppbDVwUTY1d0g2dnhCUEk4VGlj?=
 =?utf-8?B?OTBWS3dLSUVIL2hWTjJiVmRCWE5COElPK3U4VEF2cG53R1RBMG4ySEpWNXVT?=
 =?utf-8?B?eHBwTGtkR0RlWndKSmFYVC9JRnI2VjlVZDhac3UxdVpIVjhGTWdFZEJZT3hr?=
 =?utf-8?B?czlaRERDZklrZjVWM3VWOGxpWmVmUnl1UmlCQWxlNkJoQjU4Wkhic29EMCtu?=
 =?utf-8?B?a2FKOHA1YmE3U1VRbnFzSHRVRXhTV1RQdkhSTFRaUGZFRytWR2dEMVNvSmxC?=
 =?utf-8?B?cVM3RFMrbjQ3ME1CYzdaTGlIZjVld0QvK1VvcTAzelBLVkMzUi9rTUhuUFlp?=
 =?utf-8?B?b3BUQng4ck1mWnVpelFhaGRKR0Rla0dNZlFxNzBncEw3ZkRzdVRUNmN6MnBa?=
 =?utf-8?B?ZWZYKzZOSXNxY2J2UzdRT3Jtczh3cTA3ck5kTmpybmM2ZDdxeVdQYjZpOEUr?=
 =?utf-8?B?V0dFZDNOYXYrYlY4YTRkUmRpOFpkVWpxRXA1TFJ0YVdwVlROSnBocjk1Q3R2?=
 =?utf-8?B?RTdJZHdPU1BWbldUZGI2VGJiS3IyVXNXb1BqaHR3QVZsbmtSRlZTRDMzUkhQ?=
 =?utf-8?B?d0lRaHdJWmM4V1Z5T3pMR2ZySXB2WndJdmM4MXREMEVKbGxCRXl0SkFGN1Jp?=
 =?utf-8?B?RXl5YzRRdjkzR1RxOFkwbm8wcmJzV2NMbVhjY3RjN1BTRFU1K2NnTnNCMXg1?=
 =?utf-8?B?aXp6RFNJWnVqMzM0Q0dLV0pQZC9PdVczNy9kSS9uYVdWM0VOdU9JUzlwbFlG?=
 =?utf-8?B?Z243NjZJd01jUlNKMnE3dm90MWVMWHl3dzN0UldFUUpDRlh5Z1NNMkNWZ084?=
 =?utf-8?B?blBNcDVyRUVRYWl1MVRPbHRwS3lqWG1MMzZOZnpmZHJ3R3EyYk9MNVVaYTJG?=
 =?utf-8?B?bmpFZkdjSmhjeUp2MFlYbVRtOGtNOEVBU1FDbGE1SDFVSGZMaThiMDlYem8z?=
 =?utf-8?B?bHpXZEUxOGhZUDlQbktaSmJkMEdkTmZKUGNTSzlRa1hwODVaQVZtcUptSExm?=
 =?utf-8?B?RktFajQzMXQ4M1lPNnJyMTBlamJvNjZxME5rUTlhR1VaQUU2ak9icXFTcmtF?=
 =?utf-8?B?dzcwSU5aRkx6Q2RlNjBNdldIUmtQaFY3VzdmVUVXdVNSOVRpalFGS2tSSlRo?=
 =?utf-8?B?UEIzVWQ3NEdSUVh5U3c1VDAwRzF1aWV2VVFWT0NmNlh1Q2wrdm43ZWd4ZHNL?=
 =?utf-8?B?bTZFZ2dIbU9iYXkzRys2TVJyY0RwOTVKVVVsTjY5d2JUczNSbWR1aks5NVBx?=
 =?utf-8?B?aE1UNm44ejZCOHNqL2VWeFI2eWdKcnliTUpqSUQ4VklGcGRXQ1V0Y3N0ZEN6?=
 =?utf-8?Q?wEePcSXtGkD9YGvvTiqs3TZ5JAdYZKkvJsDODk9BXDBJd?=
x-ms-exchange-antispam-messagedata-1: irQeV1jQUsEPem54OYAaqmdtFDGx+iqrdbo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42F9CD3B473CC742B4964C7392C1B9F7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Sf6/d60rHa3Rf8kxBZy95LczmMIiT/VB4ogrLtth1WqpLvBcKuDSIP//9/zX22+YQDvZ1S5iEfpSDugk/cnL6Rl+UCKWRxB7W7SRS12NaPrO7+rBuyolv5OW/aH/zld8Ic3kzza1ZkuvzMUcHsMDyyOGvQ62kopWOElA4IXvJJ4RSOs5pu/aKPPkdRa/CuaLjrIqdPLUC9CbNCLuMqOA/Bzx2K+lhQz0wmej85wrI56Izr4irhoxO/vzFtGNI+XRB/8gE4RY2LVYPkPe230l5L1ICOxrzqzZNxW/Jkzyt/hD6CEk4jia0C9arbXCBnKCLJ+7b8guVdXXm9EnEMuU2A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KSjOk1BOl5QnXQ+zCfHt91z29vePcx3le3BFzECtTFZSeuTc+jK6fpZL9dYvIQxqoKuwrL5C1RYAcyPl05tfwsWoaMOD0ClSbx3p51uIoFIPpS5/+Ff+vvp1oWB5kv+JgKQP+++x0korKCECssZmokfSYfk4I+QhJsjrz6IeE+ZSPPESInv6Obu7EB2/4fsdCs5I9cqZjCgtFDXnzP5iuTkdTYgpaoPObpOWMQTtjdzA9FLmywXrzuKmi+f4rh82H3nmRCvLE/P5jCk2IQ5ALYjAwJguH2xRheGsDhycHSO/G9wPWj/xyLXcctHvSaU7dPUQDk2lecp8z+EHeZF1TCB6l8m1xyM6ih2oSZi6JOcPGSLgdgfTf6h0p4NRzYgunEtn+FqJgFOQWCzNIeqfqcDej30tMj51zh0f93IgM5XvLhL6b3IHq/v7VkaO6gDJPchUe4ZsNpw6Y8uyzYesunMg/z+eRgz2NxxeUXKz2n1Bz+ixiOBsDVoczbXcp9N2J+EGuL6Sh0i1x6YXurH5rh7tkdgP/kW1Gl3fiDi+5C83B0zcmBN446KhWT9YE7svR7svIjrcniI3clQPotW4O3sa9nHLs9dENMqdF/1JSg3COPupOK96LKULBo+t1n2i
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ece458-4aab-4297-8b26-08df3af965c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 04:58:13.7629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lhHKyFdkNp9RUpzZiUDO4V9sGTSuyJaeOeW8dkIfkQxVRoH68fLWSepEQVWCSZUNlYCZfeGF/sYxRWYMmxnSYS22UjIatMg92ZdSfNPzaG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB993683
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=7622369f3=Alistair.Francis@wdc.com;
 helo=esa5.hgst.iphmx.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gRnJpLCAyMDI2LTEwLTIzIGF0IDEzOjA5IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToKPiBUaGUgcmlzY3YtaW9tbXUtc3lzIGRldmljZSBpbmhlcml0cyBhbGwgcHJvcGVy
dGllcyBmcm9tIGl0cwo+IGFzc29jaWF0ZWQKPiByaXNjdi1pb21tdSBkZXZpY2UgdmlhIHFkZXZf
YWxpYXNfYWxsX3Byb3BlcnRpZXMoKSBkdXJpbmcgc3lzX2luaXQoKS4KPiAKPiBXZSdyZSBhbHNv
IHByb3ZpZGluZyByaXNjdl9jcmVhdGVfaW9tbXVfc3lzKCksIGEgaGVscGVyIHRvCj4gaW5zdGFu
dGlhdGUKPiB0aGUgZGV2aWNlIGFuZCBhdm9pZCBkdXBsaWNhdGluZyBjb2RlIGJldHdlZW4gYm9h
cmRzLsKgIEluIGl0cyBjdXJyZW50Cj4gc3RhdGUgdGhlIGhlbHBlciBpcyByZWFsaXppbmcgdGhl
IGRldmljZSBiZWZvcmUgcmV0dXJuaW5nIGl0IHRvIHRoZQo+IGNhbGxlciwgcHJldmVudHMgYW55
IGFkZGl0aW9uYWwgc2V0dXAgb2YgdGhlIGRldmljZSAod2UgY2FuJ3QgY2hhbmdlCj4gZGV2aWNl
IHByb3BzIGFmdGVyIHJlYWxpemUpLgo+IAo+IFNwbGl0IHRoZSByZWFsaXphdGlvbiBjb2RlIGZy
b20gdGhlIGhlbHBlciBhbmQgbWFrZSB0aGUgYm9hcmRzCj4gcmVhbGl6ZQo+IHRoZSBkZXZpY2Ug
bWFudWFsbHkuwqAgSXQncyBhIHNtYWxsIGluY29udmVuaWVuY2UgdG8gcGF5IHRvIGJlIGFibGUg
dG8KPiBjb25maWcgdGhlIGlvbW11LXN5cyBkZXZpY2UuCj4gCj4gU2lnbmVkLW9mZi1ieTogRGFu
aWVsIEhlbnJpcXVlIEJhcmJvemEKPiA8ZGFuaWVsLmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbT4K
PiAtLS0KPiDCoGh3L3Jpc2N2L3Jpc2N2LWlvbW11LXN5cy5jwqDCoMKgwqAgfCAzICstLQo+IMKg
aHcvcmlzY3Yvc2VydmVyX3BsYXRmb3JtX3JlZi5jIHwgNyArKysrKy0tCj4gwqBody9yaXNjdi92
aXJ0LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA5ICsrKysrKystLQo+IMKgMyBm
aWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYg
LS1naXQgYS9ody9yaXNjdi9yaXNjdi1pb21tdS1zeXMuYyBiL2h3L3Jpc2N2L3Jpc2N2LWlvbW11
LXN5cy5jCj4gaW5kZXggMjU4YzE3MWVmZC4uMTkwYWIwYjY0NiAxMDA2NDQKPiAtLS0gYS9ody9y
aXNjdi9yaXNjdi1pb21tdS1zeXMuYwo+ICsrKyBiL2h3L3Jpc2N2L3Jpc2N2LWlvbW11LXN5cy5j
Cj4gQEAgLTIxNyw2ICsyMTcsNyBAQCBzdGF0aWMgdm9pZCByaXNjdl9pb21tdV9zeXNfaW5pdChP
YmplY3QgKm9iaikKPiDCoMKgwqDCoCByaXNjdl9pb21tdV9zZXRfY2FwX2lncyhpb21tdSwgUklT
Q1ZfSU9NTVVfQ0FQX0lHU19CT1RIKTsKPiDCoH0KPiDCoAo+ICsvKiBOb3RlOiB0aGUgcmV0dXJu
ZWQgaW9tbXVfc3lzIGRldmljZSBuZWVkcyB0byBiZSByZWFsaXplZC7CoCAqLwoKSXMgdGhpcyBy
ZWFsbHkgbmVjZXNzYXJ5IGp1c3QgdG8gc2V0IGhwbS1jb3VudGVycz8KCkl0IHNlZW1zIGxpa2Ug
dGhpcyBpcyBhIGJpdCBicml0dGxlIGZvciBvbmUgcHJvcGVydHkKCkFsaXN0YWlyCgo+IMKgRGV2
aWNlU3RhdGUgKnJpc2N2X2NyZWF0ZV9pb21tdV9zeXMoRGV2aWNlU3RhdGUgKm1taW9faXJxY2hp
cCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaHdhZGRyIGFkZHIsIGludCBiYXNlX2lycSwKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYm9vbCBpc18zMl9iaXQpCj4gQEAgLTIzNyw4ICsyMzgsNiBAQCBEZXZpY2VTdGF0
ZSAqcmlzY3ZfY3JlYXRlX2lvbW11X3N5cyhEZXZpY2VTdGF0ZQo+ICptbWlvX2lycWNoaXAsCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpc18zMl9iaXQgPyAzNCA6IDU2LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmVycm9yX2ZhdGFsKTsKPiDCoAo+IC3CoMKgwqAg
c3lzYnVzX3JlYWxpemVfYW5kX3VucmVmKFNZU19CVVNfREVWSUNFKGlvbW11X3N5cyksCj4gJmVy
cm9yX2ZhdGFsKTsKPiAtCj4gwqDCoMKgwqAgcmV0dXJuIGlvbW11X3N5czsKPiDCoH0KPiDCoAo+
IGRpZmYgLS1naXQgYS9ody9yaXNjdi9zZXJ2ZXJfcGxhdGZvcm1fcmVmLmMKPiBiL2h3L3Jpc2N2
L3NlcnZlcl9wbGF0Zm9ybV9yZWYuYwo+IGluZGV4IDVmNDg1YjFjNzkuLmU5NTM2NTE1ZGEgMTAw
NjQ0Cj4gLS0tIGEvaHcvcmlzY3Yvc2VydmVyX3BsYXRmb3JtX3JlZi5jCj4gKysrIGIvaHcvcmlz
Y3Yvc2VydmVyX3BsYXRmb3JtX3JlZi5jCj4gQEAgLTQ4MSw2ICs0ODEsNyBAQCBzdGF0aWMgdm9p
ZAo+IHJ2c2VydmVyX3JlZl9tYWNoaW5lX2luaXQoTWFjaGluZVN0YXRlICptYWNoaW5lKQo+IMKg
wqDCoMKgIE1lbW9yeVJlZ2lvbiAqbWFza19yb20gPSBnX25ldyhNZW1vcnlSZWdpb24sIDEpOwo+
IMKgwqDCoMKgIE1lbW9yeVJlZ2lvbiAqcmVzZXRfc3lzY29uX2lvID0gZ19uZXcoTWVtb3J5UmVn
aW9uLCAxKTsKPiDCoMKgwqDCoCBEZXZpY2VTdGF0ZSAqbW1pb19pcnFjaGlwLCAqcGNpZV9pcnFj
aGlwOwo+ICvCoMKgwqAgRGV2aWNlU3RhdGUgKmlvbW11X3N5czsKPiDCoMKgwqDCoCBpbnQgaSwg
YmFzZV9oYXJ0aWQsIGhhcnRfY291bnQ7Cj4gwqDCoMKgwqAgaW50IHNvY2tldF9jb3VudCA9IHJp
c2N2X3NvY2tldF9jb3VudChtYWNoaW5lKTsKPiDCoMKgwqDCoCBpbnQgaW1zaWNfYml0czsKPiBA
QCAtNjM1LDggKzYzNiwxMCBAQCBzdGF0aWMgdm9pZAo+IHJ2c2VydmVyX3JlZl9tYWNoaW5lX2lu
aXQoTWFjaGluZVN0YXRlICptYWNoaW5lKQo+IMKgwqDCoMKgwqDCoMKgwqAgY3JlYXRlX2ZkdChz
LCBtZW1tYXApOwo+IMKgwqDCoMKgIH0KPiDCoAo+IC3CoMKgwqAgcmlzY3ZfY3JlYXRlX2lvbW11
X3N5cyhtbWlvX2lycWNoaXAsIHMtCj4gPm1lbW1hcFtSVlNFUlZFUl9JT01NVV9TWVNdLmJhc2Us
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
SU9NTVVfU1lTX0lSUSwgZmFsc2UpOwo+ICvCoMKgwqAgaW9tbXVfc3lzID0gcmlzY3ZfY3JlYXRl
X2lvbW11X3N5cyhtbWlvX2lycWNoaXAsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcy0KPiA+bWVt
bWFwW1JWU0VSVkVSX0lPTU1VX1NZU10uYmFzZSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJT01N
VV9TWVNfSVJRLCBmYWxzZSk7Cj4gK8KgwqDCoCBzeXNidXNfcmVhbGl6ZV9hbmRfdW5yZWYoU1lT
X0JVU19ERVZJQ0UoaW9tbXVfc3lzKSwKPiAmZXJyb3JfZmF0YWwpOwo+IMKgCj4gwqDCoMKgwqAg
cy0+bWFjaGluZV9kb25lLm5vdGlmeSA9IHJ2c2VydmVyX3JlZl9tYWNoaW5lX2RvbmU7Cj4gwqDC
oMKgwqAgcWVtdV9hZGRfbWFjaGluZV9pbml0X2RvbmVfbm90aWZpZXIoJnMtPm1hY2hpbmVfZG9u
ZSk7Cj4gZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L3ZpcnQuYyBiL2h3L3Jpc2N2L3ZpcnQuYwo+IGlu
ZGV4IGQ0YjUwMTgwMmYuLjM5MzgxY2IyMWQgMTAwNjQ0Cj4gLS0tIGEvaHcvcmlzY3YvdmlydC5j
Cj4gKysrIGIvaHcvcmlzY3YvdmlydC5jCj4gQEAgLTk0MCw4ICs5NDAsMTMgQEAgc3RhdGljIHZv
aWQgdmlydF9tYWNoaW5lX2luaXQoTWFjaGluZVN0YXRlCj4gKm1hY2hpbmUpCj4gwqDCoMKgwqAg
fQo+IMKgCj4gwqDCoMKgwqAgaWYgKHZpcnRfaXNfaW9tbXVfc3lzX2VuYWJsZWQocykpIHsKPiAt
wqDCoMKgwqDCoMKgwqAgcmlzY3ZfY3JlYXRlX2lvbW11X3N5cyhtbWlvX2lycWNoaXAsIHMtCj4g
Pm1lbW1hcFtWSVJUX0lPTU1VX1NZU10uYmFzZSwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIElPTU1VX1NZU19JUlEsIHJpc2N2
X2lzXzMyYml0KCZzLQo+ID5zb2NbMF0pKTsKPiArwqDCoMKgwqDCoMKgwqAgRGV2aWNlU3RhdGUg
KmlvbW11X3N5czsKPiArCj4gK8KgwqDCoMKgwqDCoMKgIGlvbW11X3N5cyA9IHJpc2N2X2NyZWF0
ZV9pb21tdV9zeXMobW1pb19pcnFjaGlwLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cy0KPiA+bWVtbWFwW1ZJUlRfSU9NTVVfU1lTXS5iYXNlLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgSU9NTVVfU1lTX0lSUSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJp
c2N2X2lzXzMyYml0KCZzLQo+ID5zb2NbMF0pKTsKPiArwqDCoMKgwqDCoMKgwqAgc3lzYnVzX3Jl
YWxpemVfYW5kX3VucmVmKFNZU19CVVNfREVWSUNFKGlvbW11X3N5cyksCj4gJmVycm9yX2ZhdGFs
KTsKPiDCoMKgwqDCoCB9Cj4gwqAKPiDCoMKgwqDCoCBzLT5tYWNoaW5lX2RvbmUubm90aWZ5ID0g
dmlydF9tYWNoaW5lX2RvbmU7Cg==

