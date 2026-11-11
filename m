Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCA9606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 04:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=asc/yCT2;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=LKc8mAmn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR0N7-0007oY-FM; Tue, 10 Nov 2026 23:55:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xR0N5-0007nO-Lo; Tue, 10 Nov 2026 23:55:43 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xR0N3-00034O-Nu; Tue, 10 Nov 2026 23:55:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794372942; x=1825908942;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=vJFZ1Bgz29wTaPsZvTQd5Gk96ifuvZ8KEn5LtNsEEHY=;
 b=asc/yCT28kqyGMPhhdo5CXDs5N9NPQ+imnp1XWBCtolBio8YRSDA8Utg
 gyJLRyj4zbq3UDJpy4RQToHpH4yc7SPT1ABgOH/ARzDrlSfhtQwXqQ2G4
 2tm1wJOIwq+6skH6DDSq89Bv36/Yh8HNq/l7swdjCAUvPCZT2ySmPvUuK
 2pNnYq3lWB7WEACi55xwxF7MJCVSBNJDP6F9Wdf5UZ13HIg5+lfSs2iQw
 mvxbqe9ENQHZJnHwULkT7xmltRFVB8+C0tqUXy6upvtgJp9QpkXKpoTvQ
 3ExmaBmLzjfmYA+yTDkaQZHQgY6vKIdBb/fA6/g9Tl89nXAgbLuHo5tPE g==;
X-CSE-ConnectionGUID: uDLmzi+SRLCoWdmzDGTRgw==
X-CSE-MsgGUID: 5+1o9s8CRO6CGW4lFMIxHA==
X-IronPort-AV: E=Sophos;i="6.27,207,1786982400"; d="scan'208";a="156367671"
Received: from mail-westus3azon11010022.outbound.protection.outlook.com (HELO
 PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.22])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 11 Nov 2026 12:55:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUOHV5huiAVKiMqoeIKWT8OYACLYC6LWqe2HY79Va/rcDCHqqbYkHRODrIjuLqJ1YAMreWXw99PIP/BwUozTszceNEtDjF91d7hHbyFUIGy7jqWIIYLaJSGC2Vo8ZbG/9HDS5usLHISyHsUECNBogs8n5j3RHBirAl7O6Ta7R32LUr3BVZMxgUoejWMM6Ur/WKpddHIFSdkn6fgtQrTaRFUsIL82XmXryb/aGVgBcV6QCcR5Vzjz/iIc7Sari5Uqh4PuduVRJ+hInmvjNoZTW3scvbNrfdxpUjH/FrcRtoItS1rC29UnStL+f36oHiQ8dg5ofsVc2IVbqjki8MGN0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJFZ1Bgz29wTaPsZvTQd5Gk96ifuvZ8KEn5LtNsEEHY=;
 b=Cx1Kx5t+GNJJxfTcJpeQ2bTjDs5ZTQ+R8BMxvwQTl3GB8UMtE7EvHkL0jOgT2xfwMa8fxK6nNXij1q/D0h3AjAjIx079IFMARVLAOC6GPKvnBI41yNsEbcQcczlre/Ty9CPD2awCNpFtdLGXiYP2liCdUCcQhx/wsA++wmHWvcps74nFse9ltM8nAY59q2TBORnY86bSWjDS/eNzQA8lvPC/NMD0O0BnRMd0XHvvR5qLe19PkT/bYteuSlwfe7l+Q0iF6R4WTfPm3c6dYEJR4MzJZRc/wD11gBWVuIwNpEDavahgH679ZjiN/TI1iM2OfnLXci3eX60dDYNO20QkpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJFZ1Bgz29wTaPsZvTQd5Gk96ifuvZ8KEn5LtNsEEHY=;
 b=LKc8mAmn1X6QhNaziKwSVXunoE8/s0A8FPY9SJnxASNQorPCrXXgAS1k3OvtBDdNXI5zl+YAbYhtGu/DY0h3l+3nMiBE+UKClPhxQK+/qdQ54XcO/ww5+wRFtNegGdsR8umAHVcwR+vT6ZGL5ReoZnBg9A5cvFavaMy6dkLzObg=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by SA0PR04MB7308.namprd04.prod.outlook.com (2603:10b6:806:db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 04:55:36 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 04:55:36 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "ralf@vmexit.de" <ralf@vmexit.de>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "ralf.ramsauer@oth-regensburg.de"
 <ralf.ramsauer@oth-regensburg.de>, "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>, 
 "lukas.landgraf@st.oth-regensburg.de" <lukas.landgraf@st.oth-regensburg.de>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>
Subject: Re: [PATCH v3 0/4] hw/riscv: describe only the PLIC contexts that
 exist
Thread-Topic: [PATCH v3 0/4] hw/riscv: describe only the PLIC contexts that
 exist
Thread-Index: AQHdYmMP7b5MXT8DFUGhgzJXj2gwqbcobQCA
Date: Wed, 11 Nov 2026 04:55:36 +0000
Message-ID: <e9458955ed4759ec98f06e52624a1e068950ce49.camel@wdc.com>
References: <cover.1792700406.git.ralf@vmexit.de>
In-Reply-To: <cover.1792700406.git.ralf@vmexit.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|SA0PR04MB7308:EE_
x-ms-office365-filtering-correlation-id: 36be6f30-19f9-4462-1f14-08df3fb00680
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|10070799003|1800799024|366016|376014|7416014|261028144727099003|261026140227099003|261026121527099003|261102124527099003|261102123227099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|38070700021|11063799006|56012099006|10067099003|22082099003|18002099003|261009223027099003|6133799003;
x-microsoft-antispam-message-info: FMuzEvBvQ4F+vDKpgc3QqP1tHASlLGE016NefjycnuL0rD/FR8tuZBCTzta5ip8z1KOceFbuuYJBGGswnjG/92jCxWnlW0H+b6YSYoS+teYwurFDsktWZLGpcxy41QOD11X2lSTuuHpbL63eB86M1EGwH9vU8W5nGjL50YbYCB0UujKG9t6TTUtja2gDoBkIns3Di/ynzXEabN+Xny3N9zBxgOBVdXXf5xSloP7bc1mqGvjP4uhNUnWyKwLLqN0WH6j4cqXPQ95Kd3tfayACOSI1raiMEqgeKJ/eCFpRs7/bTuG8lGb1KwZbeL8BDfWIgh98jHkMpaWwAFwqsmo0Okt0fDmucsBS2oC5Eaoe1YqmJ0hbNiD1u0dounvsNcGTvucUiae8u2yno0on8OBThwD7AvexAz28MaWXDL+bP/ranGODainYb4GyIjRSAzYfTqnv3em/MO8kI8vP9d42oilB76KSsv71ylW6eZxe3uTfwbyt6gsEozAIFkm0hf+OYSD6PG55Emr23fxhAAigwDQveMuJXl27+9DDczzdEkPf7EZiCcEOpABnfjwhs91TV4LEu1Upxhls8PkvXzjrY+v/+bRyue/UiFeRnYYVRHD+4lzd1Dz+lLC4dV3iWY/Qk0pIAOc16gIJZGjWicbSDsVf8ZW34QPfI1apA2UyB+4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(261028144727099003)(261026140227099003)(261026121527099003)(261102124527099003)(261102123227099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(38070700021)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHhuNDNyZ3ZQN1dwVVlGYWowR01zK0JTM3FLcEcvbVg4Y0FIUDY1RTZ5ZC8r?=
 =?utf-8?B?YzUvMElSZ08xV1N0aVgrRFpHZ0VPU2gvL3V1MEtKVmlrTTFsL3hrSCtTN2Y1?=
 =?utf-8?B?S3JnMGNVVU5tZjJrQVRPU1Nabk1DaEh5eVp5WEpKOUx5SlNJZnduSlBIcUh2?=
 =?utf-8?B?NVFhd1pQUXNVOTdiRFlmWlVmaW1yQlQ2RzFHekF5ZDhIWVBNcXJ5K0pGR0hy?=
 =?utf-8?B?NS9kZ1NWV3lDd3JkSit2RVczNkRBNFYzS1pKMlFPc0dDNklhRkw5Uk5vRzdT?=
 =?utf-8?B?a01qNjlUZ0dJd2NGWnBTM0d2aXFjOG1UVk8vcnQvMjZNTnROVkxUejFpbE8z?=
 =?utf-8?B?enpvdFVVTlJkSTVJTVd3cldPSWFvQ1pXMlhOT2Jxa2NnUGZHd0RBb0hlWEdp?=
 =?utf-8?B?VkdySkpWcUFpT3VLY080c0ovdmdNRE9TcHBicXkreEhhbCtCRmRjZUYyVlFG?=
 =?utf-8?B?MTJPUW1qSkF6WnlXTUw5NzM3NHZXaE9RVlU4ZEFwcHB6eWdmaXZZakR3NDkv?=
 =?utf-8?B?d2hjWDR1U3o2OXBxbjhUK0ZCOFFES3Uwa1NwOUtYbkZyQW9KS0ZhQ1lIaFNa?=
 =?utf-8?B?dWkybHdzQWFZVkhtaVlUUkVYWnFWQ1c0aHA4eEZTMGNMRHZ6bXIwYnB1ZEJw?=
 =?utf-8?B?TkcwVVZtbzhUL1JSdVNCSHVOQjh2bGs1bTZ6MDJOVmlKOXVyT3FqK1I4d3lZ?=
 =?utf-8?B?bXUrNUEvRWo2ajZFUnNTa0dKbmJrbXpiZVJmOFFTSWFEd01hdU1VaWZiaHNu?=
 =?utf-8?B?M24zWkVxV1JtQXlYbUc0Z3hnb2M3Q1M1K1NKUXZzOEJ1TzJMZUJybndjNjZ6?=
 =?utf-8?B?NFlUbjE4ajIvUnVDd3MvMmswbzNmOEJtWmt0YmZ3RGdQQ3o4LzdvbCsxNUJm?=
 =?utf-8?B?S01hQ3Jqck14bEtHYVZGVkFYdldCNWZSWXV2K3hjVm52TWRQYU9xcWFYZEkr?=
 =?utf-8?B?UEpEMVdCWVhURWQxQWNBcEF6ZTRCbTNCbjFyR05iZ3BGVnpRZVp5Tldyekh2?=
 =?utf-8?B?T2NFdG1IMDBWVXdSeFBBdlplUUpHZ3hxUTFWbkNSSmJUOE01OWdnQWVPZ2RO?=
 =?utf-8?B?RTFxb2ZZRE9UZ3l6UHViQkRDRmxFR1NUVUNoNW5pWitoZkdNbERNVWExcFQ5?=
 =?utf-8?B?eXNwWkd6d21vUklTRGZkblFNUWZqRklIL0JrbWlSWm9FSHVOYVVGZWl6UE83?=
 =?utf-8?B?NGxxRksxMlh2eDZ5TWU2OHliOGZPV05INDdsWGI4Y0p2d2hGQ2N3NkVsa3Vr?=
 =?utf-8?B?dlFoeWlRQ1R1SHBjT0N2YkNnRnExc1JvT0JnMkdMUUZXN1NEcEhGVjUxU2do?=
 =?utf-8?B?b0ZvaGZMb3U5WjRLM0hsR3hwREE3eXJiTUZVV2NoQkc5ekFVN1RsalpHRkxp?=
 =?utf-8?B?b1JkbTkreHc4bWp6VXZoSE14bGkwZ3d5RGphU0c0TFJIZ0NQaGo1OE1hRHcz?=
 =?utf-8?B?MG1NYjFaOUxIdHYyRmR6Y2krdnNXN1hJb3hZRTdQWUZHWjNZcXhuNFgwcGR4?=
 =?utf-8?B?RkxvMzZ4aHNWNVQwTVU3SHpxMUtTNEJPckhXekltT1B2UmR1Y3Y3ZGhrSFpI?=
 =?utf-8?B?cUVXMjJ2ak1lbitzMjVXTUlURFN2L20wRTJ3bHNyR0o4R0ZUeWxzQVBXWkRD?=
 =?utf-8?B?clpHRW1DNVo5cnlEeXQ1ZndxZ29FSkpLZWZVeXBJcEFmUUVOc25keUR0NWRw?=
 =?utf-8?B?V2Z0ZFkxd3RkUk1oT1Y3dkVpZmR2R1RKdXM2VDV4OGNYUjQzcUVuY0pQUVY2?=
 =?utf-8?B?YmZZa29aTGpLUVo4Vy8xbjRmZ01Ra1p5Ynp0TE90aUFVc09uTFRHN3JsMW0y?=
 =?utf-8?B?SGR4dStqZjFDc052UEJ4UmV3UDdIRHJFdTJJUHo2MmNONWJ2dFZhSUt4bHpa?=
 =?utf-8?B?VWljUVJsMkw0cTM3dG15SHZBY0xjbVdVYUNobWhWeWFJQjUwSGZ2K0NZWENW?=
 =?utf-8?B?dU84ZkFISnN1UituVU5KTVB2SVJRcFpJcEV4azR2d2hMa1FmOXRRQmgrcjQy?=
 =?utf-8?B?anVac0MvaFFjNk1ESis4cUN5LzYwVEptdmdIbzhiVk9YdHhzcW9ud2ViVG14?=
 =?utf-8?B?bUozSDh3TDkzbU9oQ0FXZW5xQUFFem96SFI5TWhYdjFsVlMzczMxdVgwYWth?=
 =?utf-8?B?Tmo2OWhLMGZQY3hhWW1OTEpxVnJ2VS85a3k0Z2w2SEJQTUpDbDI3OXppZVFB?=
 =?utf-8?B?VjNHSVVIVWJMS3pLdGIrQjg2THVnKzF5UW4rMFhlNEpqY2RqVGpjQXBYV1Na?=
 =?utf-8?B?ZGY2K21nUU9xbjBuS1lZdW5RVG9UbFlzOFl0OHo1NzZXa0VnNFpzSzlLU2g4?=
 =?utf-8?B?a0hKRjQzcUVtOHgvUE5tOVFQNVFadE0wVnJYVmNzbGMrOFlmdlpoencvNExz?=
 =?utf-8?Q?rjlzDPcqQdyZ1JbpLv4Le+BjCcmPXlQMXeS3wvWYnnkwz?=
x-ms-exchange-antispam-messagedata-1: mdjN72bfSDOevHKJ44VLB/54lHt0YCdDO+c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B6A6B1DA98B344D8E93F47E5CFF8A38@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hP59glIAvBvFlk9AuK4kjk0D8St0pQuf5V5Kl+EZvkIfYdSgk9KODFpgZs4m6dLuzNUc3wUWpYksQSqepI5gVhgSqGi7kTlKqCO0JakzTczO2+r00RhquLgoPh6r0bKh6ERkxjzMcB94lf2qU3yqaCbBxywYfKTPMytDD+GI/635b2QcfBdGcHXxjaOvliClEdUkB0NnkGFx+HziUAq2xmN/8/u4QrZPVgjNz09qxecjZamYyP9sOxqZQOLBIcRFnBFVbRwtL0AWm5j3dezDTRiF8PWX8jPf/yGfOskIeascP0V32/JuBULYbpVaOp3k9+1AkxycurcqDSka0BgzJA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: T5A8gLkiIN0pxhXI7oGBzZGqgWLUpPR3OYQQlz/5FKjbUxbu8AGOEp3nf78wdfbSTqOCsgnwbaowKtX+53C1w/JZ9ET27KaZEBtClMamb2K5cxuHr27fCQED5hBRrtKBVev7AFZ4OjJgLCfFs1xpwVNPzNYCIHq6GrwZT9jlcEQf0ZpDrTsbxWNU67H56DydEggSgC31g5gRB1IMwCBEx255CTc6JVXoXQh/ObtHNjSG80JvKLUI2DZDUfiXSHaaJLax0beP9Ku3UJSpWCuE/pkzpq1hty7TFOyayvSIcyU7jBICPIoyBF+waTmGf8OhzXG57U7Y+RFXTa57nvryNf9a2rkG8G3Y6KT7EcaNu0ZTM5qkSja6hPeqvneeZbrP+jNDmkYk316IpV8FN8ZaSKgnb5UW9jQn9v1SobY8iZVRKM2o3I//fMQHDAqkcXFJRvIndLAIGySHu8e0v1URr7IhDxZCsA581K54Dv6mggsHoEHDT3RW81UqrLUT8tudtHzD1tfd00GiU6FGeOZe+mVnE+9sufbihlqOfF4M7YVWYZixIKCr522565sDPHKjRyx/6nOBSNn5jrgA8TlVYTk6o1eVVnISQb3ogs0GyV44ZTpmYyKnBX7FAntzY24r
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36be6f30-19f9-4462-1f14-08df3fb00680
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 04:55:36.5333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XLlFaUARXAR7WoaH/tbfmk9MkIpHfv207oRFO1BlPLcFKoy8eLu1CZlijjIKK0Td3ZHN4dO3JzH2ws/Hv9TBAXpkB8+bmjiBo5B2cpgFT0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7308
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=76810307e=Alistair.Francis@wdc.com;
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTEwLTIyIGF0IDIyOjIyICswMjAwLCBSYWxmIFJhbXNhdWVyIHdyb3RlOg0K
PiBBIFBMSUMgY29udGV4dCBpcyBhZGRyZXNzZWQgYnkgaXRzIHBvc2l0aW9uIGluIHRoZSAnaW50
ZXJydXB0cy0NCj4gZXh0ZW5kZWQnDQo+IHByb3BlcnR5LCBzbyB0aGUgZGV2aWNlIHRyZWUgYW5k
IHRoZSBkZXZpY2UgaGF2ZSB0byBhZ3JlZSBvbiB3aGljaA0KPiBoYXJ0cw0KPiBjb250cmlidXRl
IGEgY29udGV4dCBhbmQgaW4gd2hpY2ggb3JkZXIuwqAgT24gdGhlIHZpcnQgbWFjaGluZSB0aGV5
IGRvDQo+IG5vdDogdGhlIGRldmljZSBpcyBidWlsdCBmcm9tIHJpc2N2X3BsaWNfaGFydF9jb25m
aWdfc3RyaW5nKCksIHdoaWNoDQo+IGdpdmVzIGEgaGFydCBhIHN1cGVydmlzb3IgY29udGV4dCBv
bmx5IGlmIGl0IGhhcyBzdXBlcnZpc29yIG1vZGUsDQo+IHdoaWxlDQo+IHRoZSBkZXZpY2UgdHJl
ZSBsaXN0cyBhIG1hY2hpbmUgYW5kIGEgc3VwZXJ2aXNvciBjb250ZXh0IGZvciBldmVyeQ0KPiBo
YXJ0LA0KPiB1bmNvbmRpdGlvbmFsbHkuwqAgQm9vdCB3aXRoDQo+IA0KPiDCoMKgwqAgLWNwdSBy
djY0LGg9ZmFsc2Uscz1mYWxzZSx1PWZhbHNlIC1zbXAgNA0KPiANCj4gYW5kIHRoZSBQTElDIGlt
cGxlbWVudHMgZm91ciBjb250ZXh0cyB3aGlsZSB0aGUgZGV2aWNlIHRyZWUNCj4gYWR2ZXJ0aXNl
cw0KPiBlaWdodC7CoCBBIGd1ZXN0IHRoYXQgdGFrZXMgaXRzIGNvbnRleHQgbnVtYmVyIGZyb20g
dGhlIHByb3BlcnR5IHRoZW4NCj4gZ2V0cw0KPiBpdCB3cm9uZyBmb3IgZXZlcnkgaGFydCBidXQg
dGhlIGZpcnN0LsKgIFRoaXMgaXMgd2hhdCBhbiBNLW1vZGUga2VybmVsDQo+IG9uDQo+IHZpcnQg
cnVucyBpbnRvLsKgIHNpZml2ZV91IGhhcmRjb2RlcyB0aGUgZnU1NDAgdG9wb2xvZ3kgaW5zdGVh
ZCBhbmQNCj4gaGFzDQo+IHRoZSBzYW1lIGxhdGVudCBwcm9ibGVtLCByZWFjaGFibGUgd2l0aCAt
Y3B1IHNpbmNlIHRoZSBib2FyZA0KPiByZXN0cmljdHMNCj4gbmVpdGhlciB0aGUgQ1BVIHR5cGUg
bm9yIGl0cyBleHRlbnNpb25zLg0KPiANCj4gMSB0byAzIGFyZSB0aGUgZml4LCA0IGlzIGNsZWFu
dXAgYW5kIGNhbiBiZSBkcm9wcGVkLCB0aGUgcmVzdCBkb2VzDQo+IG5vdA0KPiBkZXBlbmQgb24g
aXQuDQo+IA0KPiBUZXN0ZWQgYnkgY29tcGFyaW5nIHRoZSBQTElDJ3MgJ2ludGVycnVwdHMtZXh0
ZW5kZWQnIGFnYWluc3QgdGhlDQo+IGhhcnQtY29uZmlnIHN0cmluZyBvZiB0aGUgUExJQyBkZXZp
Y2Ugb3ZlciAxNCBjb25maWd1cmF0aW9ucyBvZiBib3RoDQo+IGJvYXJkczogNyBkaXNhZ3JlZSBi
ZWZvcmUgdGhlIHNlcmllcywgYWxsIGFncmVlIGFmdGVyLCBhbmQgdGhlIGRldmljZQ0KPiB0cmVl
IGlzIHVuY2hhbmdlZCB3aGVyZXZlciB0aGUgZGVmYXVsdCBDUFUgaXMgdXNlZC7CoCBUaGUgS1ZN
IHBhdGhzDQo+IGNvdWxkDQo+IG5vdCBiZSBleGVyY2lzZWQsIGZvciBsYWNrIG9mIGhhcmR3YXJl
Lg0KPiANCj4gdjM6DQo+IMKgLSA0LzQ6IHRoZSBmZHQgaGVscGVyIHRha2VzIGhhc19tX21vZGUg
ZnJvbSB0aGUgYm9hcmQgcmF0aGVyIHRoYW4NCj4gwqDCoCBjYWxsaW5nIGt2bV9lbmFibGVkKCkg
aXRzZWxmLCBrZWVwaW5nIGFjY2VsZXJhdG9yIGNvbnNpZGVyYXRpb25zDQo+IGluDQo+IMKgwqAg
dGhlIGJvYXJkcyAoRGFuaWVsKQ0KPiANCj4gdjI6DQo+IMKgLSBhc2sgcmlzY3ZfY3B1X2hhc19z
dXBlcnZpc29yX21vZGUoKSBpbnN0ZWFkIG9mIHJlYWRpbmcgUlZTIG91dCBvZg0KPiB0aGUNCj4g
wqDCoCBoYXJ0J3MgQ1BVUklTQ1ZTdGF0ZSAoRGFuaWVsKQ0KPiDCoC0gZm9sZCB0aGUgS1ZNIGJy
YW5jaCBpbnRvIHRoZSBjb21tb24gbG9vcCwgaXQgZGVzY3JpYmVzIHRoZSBzYW1lDQo+IHJ1bGUN
Cj4gwqAtIGZpeCBzaWZpdmVfdSBhcyB3ZWxsLCBhbmQgc2hhcmUgdGhlIGNlbGwgYnVpbGRpbmcg
YmV0d2VlbiBib3RoDQo+IGJvYXJkcw0KPiANCj4gdjE6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3FlbXUtZGV2ZWwvMjAyNjA5MjcyMzE4MzguMjM2NjE2LTEtcmFsZkB2bWV4aXQuZGUvDQo+
IHYyOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYxMDIxMTEwODM4
LjMwOTc5NTktMS1yYWxmQHZtZXhpdC5kZS8NCj4gDQo+IFJhbGYgUmFtc2F1ZXIgKDQpOg0KPiDC
oCB0YXJnZXQvcmlzY3Y6IGFkZCByaXNjdl9jcHVfaGFzX3N1cGVydmlzb3JfbW9kZSgpDQo+IMKg
IGh3L3Jpc2N2L3ZpcnQ6IG9ubHkgZGVzY3JpYmUgUExJQyBjb250ZXh0cyB0aGF0IGV4aXN0DQo+
IMKgIGh3L3Jpc2N2L3NpZml2ZV91OiBkZXJpdmUgUExJQyBjb250ZXh0cyBmcm9tIHRoZSBoYXJ0
cw0KPiDCoCBody9yaXNjdjogc2hhcmUgdGhlIFBMSUMgaW50ZXJydXB0IGNlbGxzIGJldHdlZW4g
Ym9hcmRzDQoNClRoYW5rcyENCg0KQXBwbGllZCB0byByaXNjdi10by1hcHBseS5uZXh0DQoNCkFs
aXN0YWlyDQoNCj4gDQo+IMKgaHcvcmlzY3YvZmR0LWNvbW1vbi5jwqDCoMKgwqDCoMKgwqDCoCB8
IDE4ICsrKysrKysrKysrKysrKysrKw0KPiDCoGh3L3Jpc2N2L3NpZml2ZV91LmPCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8IDE5ICsrKysrKysrLS0tLS0tLS0tLS0NCj4gwqBody9yaXNjdi92aXJ0LmPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjYgKysrKysrKysrLS0tLS0tLS0tLS0tLS0t
LS0NCj4gwqBpbmNsdWRlL2h3L3Jpc2N2L2ZkdC1jb21tb24uaCB8wqAgMyArKysNCj4gwqB0YXJn
ZXQvcmlzY3YvY3B1LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTQgKysrKysrKysrKysrKysN
Cj4gwqB0YXJnZXQvcmlzY3YvY3B1LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4g
wqA2IGZpbGVzIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gDQo+IGJhc2UtY29tbWl0OiA0ZjQyMjU4NzRkNGQzNzQ3ZWMxMTQyZTkzNWRiZDMxNDIxODk5
MmZhDQo=

