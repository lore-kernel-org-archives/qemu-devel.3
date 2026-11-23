Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DCA606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 04:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=C1a2DY9Q;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=DxO4PeZj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVLMc-0001es-UJ; Sun, 22 Nov 2026 23:09:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVLMX-0001eW-Jb; Sun, 22 Nov 2026 23:09:05 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVLMU-0003EB-80; Sun, 22 Nov 2026 23:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795406942; x=1826942942;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=T+U/3/KuModYtxHlvcONag64mgjJs80I/MqsytRVsv4=;
 b=C1a2DY9QqUYQ8hov+uab2PRL1R5Je1nIrsF0PD0ywqzVCdwokXnOhrDg
 srpmnpu9cOKBoPfbbLX107Itk1R5rExHOwYDgH+bOFJzm5IFmjkTJKC0F
 9Q+nxonA17czextXM1FH0vHx7JqZxh9apPms1FBYxzddYd/IKVgmO6R4B
 gczbWQUicW9iL87GjSAzrsnSl44YHkI1o6oiSmRM7Bjev0lfcKuOLEQGL
 MZRvOhQktNsBshOLtrj8s2J27YoCvnSZSKmx9aEmTyO7HLne1nHN/ERzm
 +2Y/bfy5rUCRSQHXfiMrkeWtEhkYe6XHVosc12UfWCGVjgnOF8NxziwNX A==;
X-CSE-ConnectionGUID: y1UTS5/jSeSrN4p5mLQD3g==
X-CSE-MsgGUID: gNAZLJKdQ6qj3+B222IzSQ==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; d="scan'208";a="160557121"
Received: from mail-westus3azon11010005.outbound.protection.outlook.com (HELO
 PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.5])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Nov 2026 12:08:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxQh0wv/mlc+sJjOpRkYdZ+wk7zV7uLYZDXrCI3R88TRnINXRHkyemIKO3JSKXXwXgudQIsnSl5ouSWZyFvj5G5ytoD8IPtwRgVxO6W6gXJEktNCvmhNgPsCd/UPq5vC+WHjXP41PSiFy6eOPYPhfwDdQouusQYsM5pUOS/ng3Wd1NeL0Ih8zFCppaavZWniDe5weBXd/MYe12ye94vPfq9WuJhSaLu5BUlGHkgu8QPkQB6Zt4fHVjUVvb2GzLmyd88Hy/iw8k2GvjB1FZxkqfN6NRgp1dZd9+VC3N6UOySrHvOB3GVOYUfc41/5X3LjuvFWASrGtF5Fv13emEO+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+U/3/KuModYtxHlvcONag64mgjJs80I/MqsytRVsv4=;
 b=t4Y9fZRsbK3JmNjsS7k+x+ztw3d9HnvnixAYjpJRtelecSIIHPTef/DeG65hpyy2anXDw9uYTHVC1ffwYOqFsKMRdwVgg38ejsvyvxiWfjAt0fKcbzmCaFEbXg380VaZhnqNbMvh//VdBwSoeKteHfSwIjphwVlLNFcNziKwZxCXwtvbN3cW+bGzOaDWarea15W2OSFj+oowUfJTH41cPxUOBKM+nJWBWoBFrv45KgWqVL0UeHVmXqGpnooxPuEfWC4/ctWfY7VO5ry4PKcAigg/OL/HWHZsEIy1j/gzSDCLhOmnJOIh1uEvUpCJm0zltlWTSuu+z+4oqoDyITCosw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+U/3/KuModYtxHlvcONag64mgjJs80I/MqsytRVsv4=;
 b=DxO4PeZjvi4RbGwaCdZgRELn7mQzMYDnmItvC/QsGcMK/5hNfbq7Cu4l/lN4TNSlpMvdnTcj2t38PRXR+7VBTwe8i/xRzD7n7MT3k5XQY/CmngJRkhDUQJIFZLHlBksFgs+cJ/KW3IsF76FCGZ55dtkTi6b3vCHgBXKHkIZM4PY=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by DS0PR04MB10122.namprd04.prod.outlook.com (2603:10b6:8:394::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 04:08:57 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 04:08:57 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>
Subject: Re: [PATCH 0/2] tcg-tests: detect redundant exe_name/test_name
Thread-Topic: [PATCH 0/2] tcg-tests: detect redundant exe_name/test_name
Thread-Index: AQHddiFKfpIU/RcKKEKPqMa1BEEWJbc7FHQA
Date: Mon, 23 Nov 2026 04:08:57 +0000
Message-ID: <7ce914dedee8d735e567b8e47e680b8444b6fa78.camel@wdc.com>
References: <20261116232140.2758664-1-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261116232140.2758664-1-pierrick.bouvier@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|DS0PR04MB10122:EE_
x-ms-office365-filtering-correlation-id: 48253cc9-6dfe-44c6-b35c-08df49177ed2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|23010399003|19092799006|376014|38070700021|10067099003|56012099006|11063799006|261026140227099003|261028144727099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 8CsUv5tutoikLjDnhh9/eflMWeetFJAIe0exPM37ezMCEM5hIEM66KjDeZFLrB+yxe9Pv/gLzaYyat4z0XxUuQc7VIO6o/TFSS0FbnpXlEr0K9XwLRnoqOWPlHjKPVZmwoTp2W+Negq+i+ATCNnkqXFzPJbuiT+WcCiB+Uj5hsZV2g72QAd3vBX4axoV/7C8ZpljNq96+yPXBGKDt6XmgyDmviINKqDihKSpK7JJmxWUvey2Xxo+mwK5tpv3pU/f2A+USVK3Yj4XpSIeZLwe+dsZ81Goy6ZjSmwAQIP2rez4mnepS6T8j2+JW3wHfrWCBctIDuIU7dJlJHVVQ1g8x5rXh57r9upXj2m1ih3PT91mT6rYXH1Kmd+MTrsBaoSZYeto/NilXh/h6U6lpVhGiTEhUUK6Y3cn1INtUhMU42qyJEOI2AUveuuoXZCWe3pOQtRkV1z8Jp+DX7l9B62u3za0QMUTv6/peIIOFt5AMxLzU/QBTs+AlKH5gUFsxZNe30oaTUDsiOhi9LF6cfvJb8Hovs83ZWay54Cttsf949gi4/xI0jfxc5pGwQBRCQsQVH5/tfPbkUMQrgYg1PTogwavi+D7HcX46SaTQuHbuwanctZc7NppJtEBd45A7SDATXrsZmz6j54iJtROO7a74zqERq9GpBEsGQGC3DTYZJp9LKZriYdhEE0pJ/x65eZ3sqYLhVGqDR9COgDPT1HDJeTPfsujo+0WLEgYmt353qI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(19092799006)(376014)(38070700021)(10067099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGpIdjJscUpTZmJ4T3BMT1JVbWdZcUgxNzJiZ25qeXYwRFRPV2hSaUxiS1g2?=
 =?utf-8?B?VGMxcldQUVFQVXdvQ2lUZ1VZbnkvdEw5VDRwak4xb3NTb21IUUpUWWpRcnRr?=
 =?utf-8?B?ZlB5WFRvZkRiWWNGVjJLZ0NlclFVNjlHcHRjWFdWd2NUSWtucGtqRVN1Q2Yx?=
 =?utf-8?B?bjg0NDBQeS93Q3VDZGl2bWM0Z0liT1JrQ0tBTGExa2tkSHdKcnlNMllPVXdy?=
 =?utf-8?B?am93UFlBUkorV2d4Nnc5dlhzdWdSdmhjTW9HQWNjbHdiRUowY2d1bGE1SkhK?=
 =?utf-8?B?SW9XQmRnOFNwcTdYMDJuVklNbnNzZzA4M25MYUo4QWp1WG9LcVNoT251U0l1?=
 =?utf-8?B?bXZOSXR1a0VOYzQ2eVY4Mmh6OTJDNTVtbHR5czdtN0xGQ3N6SmxHSkR0R1pz?=
 =?utf-8?B?bE94aEhacUQySTZFWElydUI2VVRIaVN3bFZ3MnIvM3YyOERCVHhKTExtdzVh?=
 =?utf-8?B?Z1JOU1puSHp4Z2NJL1hQYmZiRWhmbTd6REo5dVpUTlN0OWduNE1lWHMwTFNY?=
 =?utf-8?B?bnpxSWozbDR3VjZWMEoxMFFnU3VlWUtYYU1uUUxNMGltNUpYbDFOUjVzbjRC?=
 =?utf-8?B?ZHRtVlcrZ0kyVENvWExidjBLbldDVDJReENMYWxsSlRpMCtFRy9PRzNXMjl3?=
 =?utf-8?B?dUk1OCtyOTcraXhTQnovamwxTGF1MzV6MkU2ZFpoN1o0V1oxSUR3M2ZPT1FJ?=
 =?utf-8?B?dXJZWU5PMWxlYTk5RXFRQ0dQTGpMaVVpalJBRXY1K2IrVUN5N0NDZGdqUjdT?=
 =?utf-8?B?QnZOV1ZZWmFPNEs5cFdwRWc3YWdpdnJ0eC8wUEljbUViRFAxUzJFK0pSYXVa?=
 =?utf-8?B?REhYcFdlMmFvRDB5RTVjb1F2dmhGUzVncTdiMTlQWVVCeS9kdXJaWVJBRkRT?=
 =?utf-8?B?ZTByVUVZSFR4V0lBenFiSHFTMUNkZmt2MEhZZm9QNU9qRmZZbHYrMEtOSWRZ?=
 =?utf-8?B?S2RkYjFybUl2WEVBZzF2RFJrR2l2Tk5MeFpXZ3h6eXRBYmtjb2IxZlR0TU5K?=
 =?utf-8?B?NURTKzBpQ3p5ZUZzQkZlUGtPNG5iZU5XZVo3N2F0a1BxWE1JUHhaRmNQMmVD?=
 =?utf-8?B?ejdvekkyV1ZXbndhN0k5YXZhVEsyTzlsM25PbXZlSzc4SktLNnRicW1yNW5F?=
 =?utf-8?B?djJ5VDF3dE0veVkwSEFUZ2pwaTRJR1N5dVhPMlRCMkJqUHAzOGJ3elF2TU5w?=
 =?utf-8?B?bVplSmFRcmpoaHNBTlRZU3J3ejRXSThUTjNwTUZSQVY0WXF1aU8rZmhNV0tI?=
 =?utf-8?B?UXRSVFlvc21DRVVuMnpjNSsvZ1FMUldoQUIzMXpRSkxGWFk1emxic2ZBeVhW?=
 =?utf-8?B?U1BNWEJBdk9Ic05sSkR5Ly8zTWpuWTJGYmp2V2pkSktsYzNsTU93Z0pEcTdH?=
 =?utf-8?B?N3g5WGdBbmltOGdKdjNBVWdibDF1TGVZZjRkSndIWmNraU1FdVZYRnFDNnFK?=
 =?utf-8?B?NW5kSUxxS1BQRVN0a2N0RnkvVmZpZ2FDUGdHNzAvSHlwTWM2ZlpTbVB2MkJR?=
 =?utf-8?B?c2ZyZnVGR0llUFFsNkVNRlV5L08wdjl5RmVoczl1N2tMNldNVlpZNUlGTlFE?=
 =?utf-8?B?T2RRRi9BQSs1V3pKanhMWm1sZlIzaVQ3WUNqc0NnSGp1U2o4NG1Kam5iTDlu?=
 =?utf-8?B?WDVPdFNzd2NSWUh0bS9zRkRlbEdXb25PeGxCZjlzM3VrN29SVloxSlRxM3kx?=
 =?utf-8?B?ZG9UMytQYXpSbkpweGxBLzBmWllBK1AzZGRJMDBhbFdvbndlZnZXSTN2VHFI?=
 =?utf-8?B?bkdHNlVJc245RVZWMnlSYkhyZmdMd3VnTy9mSHRwU1MrTmkvN3lJa2h6OHRS?=
 =?utf-8?B?QUR6RXVyb1lYY0QwTmlKUG9sZDFDQjJSbks1dytKNDM0cXgxRWxoL0FwTWdW?=
 =?utf-8?B?cDNoeXJwNmhxcnJpZitDTnpNK29WZklMU3pmTm9sQURxZllCekQ4QzVMSE1n?=
 =?utf-8?B?OFl2cnJ1SXZjLzd0Zk5wY1hyUnZRNWVjRXl2Wm5RUWxCNnI2S2huM1ZaRjNu?=
 =?utf-8?B?WHNMOTg2RVpxZlpUd2k2TURUNkJwUnowdlZzdlNvbjZTVzZXY2Z4bngrazg3?=
 =?utf-8?B?LzFtTU9PcHc3MmNwU1JLeGpYOVU0Sk4vRXZaOFRJbFNINkdyLytTNlI1S2VO?=
 =?utf-8?B?cWNrTjlld3M5aDFMa2tXY3ZYUG13cGkxc24wSDJDcXppUWVhVkxzR0lnZHJz?=
 =?utf-8?B?TnJTTUpJdjlod2VDUTRkZWhab1pMQXY4a1pMZUEvaFg5YjI3QlBvamRCaGpX?=
 =?utf-8?B?cDQ1cHZUOEduQjQ5RGZjMWhqN3R6MW1TekM2bEFhWXdVdk9VWU9IUkF2Z0NL?=
 =?utf-8?B?Mmx1M1g5NnR6K1pnTXp2MzBFTDlTZGtzVHhPblpyY1ovUE1QQTZNd2Vzekdr?=
 =?utf-8?Q?TRFY/Vm3AYkSb0LELs4XtBYBQkmrXc5GfuDv8nhwlHItT?=
x-ms-exchange-antispam-messagedata-1: 8IvV0YDciyqSzn3O5Ti6lvkOiIoF5hfxZ+E=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1BD2C07685A1D4893B8CB5266C42F54@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mBrqXo8JadLl7MUfmC2BfN0QX6p6PxsJtOBqTv+hWOPgMUanq+EwrmVk28LHXiO0LAZxsRiXSMcwY+szMlc3LR8sMDGzLbUhRw7srf75WW4aS1HztMrSit1gke2uEAzB1ePijCL/QHGS1hW3pkaVGM3UKJnVscTyMNBFTWsvKQPkp7+RP3wqQ+GT/3f+C8zUIfLJJfbsFNLPJoTCVcPUDax76+1tT85AjxNIjuVWfyaC6qHUgrMTshB2zZVanKkXiQNvf7lHrBJaIg2ygSBohT5P83IOF+4nPoIE1AeiXqPuWfnZ9QUhP/FJZztIpRUwRctAcJQlY9m2EHsV8VSrng==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: F9ESjQU+W2VPFYcqfp7udF63isbYZ2EmkYlz5AkpQnLLRUaYK6ZxH18Mk3FF2/w2Fz3jlcjTbpUOd2858WJMkPfjIijMhNXNEfmzcyWpiaHF9KcJcWJe+x25F8QWfuE6eBN8P1kuiqg+iMo2gC94EyevEXGi+teb2qv7lB6eUVbUW/e23zMbO15unsEMPXr/1OLNyOItiW/Y+lB28zjwxNNB6KfkV/En1BcrMh9uL6QbWVFzx4jOHaMUjQPSlODnC04yIpPtBxnGWZkqA5cTCnE8EhDw5NO1k50SeB2li/wmehcOYK+tVT/6z3nJThDs92Pgu5Lirxvib7b2qROHV7a6TbYHcqP8yO5mGyH7tvYIAyxaFFw3IrDxAog2hTkOeWxAl2/ySwa/6kRp2b6tTo33DcIU9o5yff87VUQmhWgU3hxDpZAT4VJSEc6zm/V6GEdOuG9Id7Jwbnz5n8kEvTyGqTw9KUsW4XIqYP9U8KYnMOgIOoE6RRdqEFh27ypP7tWtNyGnhiqSS5ZG3sE0nlVUP6VChgmiUHmiJytM3LDGva71DsK95chQQqMcxgSx46jP6NKCCPWMnGMEByNlg9FOQHVjoigJH6Ju3VKwHlko17pcB7l2qFHLosXshkND
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48253cc9-6dfe-44c6-b35c-08df49177ed2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 04:08:57.0580 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LA7UkV97YCADMoWno3C8YZ/P7DWNTHxNojnGw8PgewnG0q78E5+vOz+FpUgqi0gVW44vWothH6oUJ8vP2PYyMdIr9aGvs6VWA8+vt5dJ9DE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB10122
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=780e1cc66=Alistair.Francis@wdc.com;
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gTW9uLCAyMDI2LTExLTE2IGF0IDE2OjIxIC0wNzAwLCBQaWVycmljayBCb3V2aWVyIHdyb3Rl
Og0KPiBEZXRlY3QgYW5kIHJlcG9ydCBhbiBlcnJvciBpZiBzZXQgZXhlX25hbWUvdGVzdF9uYW1l
IG1hdGNoZXMgdGhlDQo+IGRlZmF1bHQgb25lLA0KPiB0aHVzIGV4cGxhaW5pbmcgdG8gZGV2ZWxv
cGVyIGl0J3Mgbm90IG5lZWRlZCB0byBzZXQgaXQuDQo+IA0KPiBQaWVycmljayBCb3V2aWVyICgy
KToNCj4gwqAgdGVzdHMvdGNnL3Jpc2N2NjQvc3lzdGVtOiByZW1vdmUgZXhlX25hbWUgYXMgaXQn
cyBhbHJlYWR5IHRoZQ0KPiBkZWZhdWx0DQo+IMKgwqDCoCBvbmUNCj4gwqAgdGVzdHMvdGNnOiBk
ZXRlY3QgcmVkdW5kYW50IGV4ZV9uYW1lL3Rlc3RfbmFtZQ0KDQpUaGFua3MhDQoNCkFwcGxpZWQg
dG8gcmlzY3YtdG8tYXBwbHkubmV4dA0KDQpBbGlzdGFpcg0KDQo+IA0KPiDCoHRlc3RzL3RjZy9t
ZXNvbi5idWlsZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDggKysrKysrKysNCj4g
wqB0ZXN0cy90Y2cvcmlzY3Y2NC9zeXN0ZW0vbWVzb24uYnVpbGQgfCAxIC0NCj4gwqAyIGZpbGVz
IGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K

