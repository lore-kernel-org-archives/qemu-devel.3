Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2540606A332
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=eiuW9/CZ;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=xItaBo34
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM09j-0005yB-DM; Wed, 28 Oct 2026 05:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=75473350e=Alistair.Francis@wdc.com>)
 id 1xM09i-0005xn-Ak; Wed, 28 Oct 2026 05:41:14 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=75473350e=Alistair.Francis@wdc.com>)
 id 1xM09g-0008OF-H0; Wed, 28 Oct 2026 05:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1793180473; x=1824716473;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+FiPjxYrwg5XswQC87hlTaoVxQYartZFO8nkPo8lsVI=;
 b=eiuW9/CZhyoCnh+bcnQPsDfTUZeLLh+AQl92SVLMqQzgRXfCf6NFMBoL
 +mc1zsSzFacx7Ro838/drLeoFRd7ZsVosdGTU/J5Hlwmyy3dAKToDvF4q
 R1gBfX1mYoXzwwVs4Pzod6rwdZCCdE0X2pb0R1q9L5pSuK6YPSLlZv/BC
 XG0vhushggNavkYtLJT8LZdIcnkJoukUsNExDAlrSEbjYORKAnkaQ6Tk3
 t60H511yF0jGthdMM9FS00ZXbvZpQ/wE17KsDvlqKlUogLha5anRdHsXD
 CCGfXMbczVAcafvhDfjvj4z/IEWweJysyZqybRgyQ/p+uiPmJ28IUtVCX g==;
X-CSE-ConnectionGUID: PBz23vHvQVynlWsLDjLsxQ==
X-CSE-MsgGUID: aSj7n9TtQDma/Qysq4SEGw==
X-IronPort-AV: E=Sophos;i="6.27,182,1786982400"; d="scan'208";a="160157578"
Received: from mail-northcentralusazon11012049.outbound.protection.outlook.com
 (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.49])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Oct 2026 17:41:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOlOPEUNi0138z2r6DGXW5m/M5APCJWhCVxBLyxcJL6zHLBbDl22x8JqT1HLbKUuwVcKqfvWJATl4XSC80hbqodd9ZE+HBdkMFyxLkBTmBQscL7wS269iMaTtkwslOaW6pJuaJFfYF+IF1LZjiiGrTn9E6gnQWW89iv8FYULadKPbxaFeR4txHXkYTxKZqJRmpDpntoDSKag64/Me3WEis1NZqLMJL7dUK5vycB+WuTX+gHfq8euomepJ/20iKrZ9s/SFnOlumpsC0MawBG30CFmmq5Rpx/wlqFH5mdLbWztRL0rTpxuYkzR2h8UIIFDuIqD98aGXvd9g6vYloTkog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FiPjxYrwg5XswQC87hlTaoVxQYartZFO8nkPo8lsVI=;
 b=cHK0oAkMXX5//DCeg/BE45QSGruXRMD03X6CfSHhWfMVzqarl2lbd9bta56+R3O0jPZSrqd5NWvRj9/aZPETQOCcDg4cnqcbCBXbgQI3KmcMSAYuOqLxdl8D1K4iVVVKKcvAOar86ZOK0WiZeNk8BQoZB1zWv9w4Wne565PR0JxlzdcUuARBGD6nGb8Wjb0GE3+1fHuD+13eBQqN/Ke+oVuh4rM6d0CB1ua6zFujFFV/GvMPMTv4D8nTL6ftjgtIGzLYISilRknfWd3csOdPhkev2K7HtkuLrgMiS1B7oQE7hJNuU+Y6GB3SVzQj6Z9zeL5lvjFWgvi1sHex7LxejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FiPjxYrwg5XswQC87hlTaoVxQYartZFO8nkPo8lsVI=;
 b=xItaBo34Gazbn2VNAEjinfYBnKWK+l+ud7BW7Pf/7onxMFSn4mloeK6jPxZ/m70bi7OTR1eEZJZRGXlmp2/A8TZGJMlfHcczCbxWwMVtQlbwSVxx7hrbQKKltkBG2J60Hqhzt65O80QAJFRJnhW32Hn6RIcjK2U2YWJtgSQCArs=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by DM8PR04MB7768.namprd04.prod.outlook.com (2603:10b6:8:37::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 09:40:29 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0546.024; Wed, 28 Oct 2026
 09:40:28 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "portias@oss.tenstorrent.com" <portias@oss.tenstorrent.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mpe@kernel.org"
 <mpe@kernel.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "npiggin@gmail.com" <npiggin@gmail.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "asrinivasan@oss.tenstorrent.com"
 <asrinivasan@oss.tenstorrent.com>, "zhao1.liu@intel.com"
 <zhao1.liu@intel.com>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>, "joel@jms.id.au"
 <joel@jms.id.au>
Subject: Re: [PATCH v2 04/10] hw/riscv/atlantis: Create CPU cluster for
 Atlantis cpus
Thread-Topic: [PATCH v2 04/10] hw/riscv/atlantis: Create CPU cluster for
 Atlantis cpus
Thread-Index: AQHdZpU9yqt3VDm84UaaJGvdQFenXbcSs5AA
Date: Wed, 28 Oct 2026 09:40:28 +0000
Message-ID: <41af199b622552d4e63eaf4df1a144109a1413a8.camel@wdc.com>
References: <20261028043059.600498-1-portias@oss.tenstorrent.com>
 <20261028043059.600498-5-portias@oss.tenstorrent.com>
In-Reply-To: <20261028043059.600498-5-portias@oss.tenstorrent.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|DM8PR04MB7768:EE_
x-ms-office365-filtering-correlation-id: 8d4e9ee7-f8df-4c10-f907-08df34d78091
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|19092799006|1800799024|366016|23010399003|22082099003|18002099003|56012099006|4143699003|11063799006|261022105027099003|261022075727099003|261026140227099003|10067099003|261021123027099003|261021121427099003|261009223027099003|38070700021|260925022911599003|260925021911599003|260925021311599003;
x-microsoft-antispam-message-info: FO2mLDmG+G3tXnPycDVaJ6Z1hs9NDT3SGcuahNFAuSJ1jQre3DRqf/APnKg8MqPBVZnj9LD4it7WzzVbewNUyNNuJRyEkLhZUK/P/sGy+e0WXchrFEC3bpHMDHkfBqcZlKLv9HmLF2+NpfvNxahHbxpb2RkqEUdndSUlOsXXfBdbL1vyQrRZhIlzhlo6LAbysP+KUqhatROGVLrMqjRg86ClXrW9R8TVx1A1pZXSrma8b1K/u7QNODTBnQpJqNKlj6Nma3IlkxC48VU6DtmIPdK2E2Bn7FK/rGzVcUcwxzLTfs8VNQoqPy03SJjV5wz71U46zk9NJUtQKBecgPKMD4FQ3VR23FLKGnIzpmNxwS7kKKSSw4CsMNGkzWvveRR+mxOCvOtsmt4Pv5vLBVDWVcptgF++t2XG9eT/BFc8sFv50dhO4D/N5ZGwn0cDQ4zxuTqmi/zbsw2/GG/KUUQA8EEjWCrJPkvuTykjz8EdEGO9kHGXQiY4SBgpXW7rBk04udUpZRVl6pbEhwPl2BNvXTEDsjuq0shkLD6FZNS+F4ehctYifi6FniGuUsPCVs6QnBHcMRpS3verm+0yWa/HI4n/23CO+e9fs4EvXOtQYmks6sPRXzD1hNxJBw7GCRvOJPZpLLN98s1wyZZAHMPXZxHRLGhet+mq60doIOmRwvckbnpZHF+Vuv4kW+ZEomZjs50sZ9aLlfspVgcwBckIxIczfAF8B+wKg/0ecfmP+9s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(19092799006)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261022105027099003)(261022075727099003)(261026140227099003)(10067099003)(261021123027099003)(261021121427099003)(261009223027099003)(38070700021)(260925022911599003)(260925021911599003)(260925021311599003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFZ6bGZjN1ZIMWREV1A4QW1NSWJneENkNThkcUJFeWFRWHJpb1IrazNXcGs4?=
 =?utf-8?B?YWIzeWRpN1hzaXliZmZjYUFrRS8yVmgzWHNXSEtDZDZiU2xUVkFibmNtN2xE?=
 =?utf-8?B?QkFJRVlIaEhhNTJuQ0JNWUREQWZOcFZiRGlsaVNpdGNibXlkS1ZkVk5iTEp5?=
 =?utf-8?B?endudEd2RkhFenlkNkJ1SE1RRGNBa1BmWmwzYnlEZE83UForNWZYYzQrajlv?=
 =?utf-8?B?OTlBSEtIQnUxQ0x4endZS3FsaWptQUlCbVVvd2Uwa3Z6Vk0rTUJXeWhkNVBQ?=
 =?utf-8?B?djFsNll5WWRaV0ZaMGFWS0dsNVNCZ21ESWR2TTBvMWo2OXpzMnZHWklTVVNt?=
 =?utf-8?B?TVNaVFdmL1Qzd0s0MEhjRzlRRGpXLzhKQ25ka2dGNjh0SkpObnFEa3pzVVkr?=
 =?utf-8?B?YW5tT0xZWGV5TnZGSGxtSjBDMTl2OFkxc1E1dllNZTBYSDhTemgyZnlaN1Z4?=
 =?utf-8?B?ZUlkQURTTFo4cm9tNFJRM3dpL0I2REl6YVB3d2NteUJNYWxybUg0TUR1K2VD?=
 =?utf-8?B?N2U0NHZBd1lFOG4xWUR3Nkw2UzVvQldkdXVXTFFnanducHRvdFZVQ0lKNkdO?=
 =?utf-8?B?YitHWFZnSFZoU2Z1QlI3Vm9ucDdLbjF6MTJPVlgzaTJiVyt4QzdSUk5IQXpy?=
 =?utf-8?B?a091NVJFZ2c1N29iRUtnRDQvM1JaRTJUamdMTlNENW9LSGdFZWtnbWRIUW5l?=
 =?utf-8?B?NE5sNk5SYzlUMEZ3NktWTWNFYUZDTVk3UHdFLzVMY3FyL21PcFUvOU41ckdL?=
 =?utf-8?B?MzJ3eWZzSjFBRmpSbi9TYUowMlZWNnlLdW56c2JxYm9HNGVnM2dTU21UUHU3?=
 =?utf-8?B?VUlXQm05b0lsWVBxcWpvRE1rQUJzOGo5aHJKbXBnVE03NmxoSVNzT3o1RWFV?=
 =?utf-8?B?Rk1yVStIZnNMTjV1b1U4TVgxTzNoOTZ6L2FubCtnY0JxVjQrd1lDZnpjUmJm?=
 =?utf-8?B?MFZTcVBPdHlId2dnakUrQ2o2UmUySXRja1g2dHBoRm5tMFNKUzJxdHdSWlJY?=
 =?utf-8?B?MmVxcnhpNkVJYjRJQUlwdFJNUFZES2pwVm94Y1VVem96M3B1U0EyV25UaFo3?=
 =?utf-8?B?aW1FdVBIMHNEQUhpa0VzVmNrZGlhOHUzaXgrRnpidy9CZGVnK2FuOW8wNTFj?=
 =?utf-8?B?cWlaeGlDeVI4c0ZsYkJGcUQzdEh5TjNGU3dMdnVJcWdKWnRuY2xCRlNPd3dD?=
 =?utf-8?B?eUo1NERIK3R0b2RydGE2aFRUYzU2bDJ2NG1aRXVmTXVpQ0ZPK0VXbTFzdTZq?=
 =?utf-8?B?VXhidzJDM2pmVm8yZDN3QWg0YWQ2MzBwcjFpdWN5SkZqTVNmcjV6WmIyWlNL?=
 =?utf-8?B?M3hMVGpDZDJnanBCa1kxNnI0WnFGcUh0QWNPM0dTVWJ1amhLVGFnNHRKMXJP?=
 =?utf-8?B?Z0tXS1NCdGJMVFA4VUVFUXVadHhwR0FRUDNZMFdIOHR4eVRSWitjelNjZWps?=
 =?utf-8?B?K2JTVjYyU3RZNG5rbjJKY2QrMWpNQjJQem1oMHRtbWRnRmkwazh6YnlHWlpT?=
 =?utf-8?B?NWVIK3lmTFhhT1VvZzdmdnQ4aFpmQWJtL1k3S2hXS2dHcUMrZGRXdkliczl6?=
 =?utf-8?B?ajhCbmxUcTAyWWEyd1EreFRqU2JDeVZJM1JPREFTckQyRFVUV25VSWZrZm5B?=
 =?utf-8?B?R1NZbzdqTXhOZVloM2ROT3VjV3U5d1Uzd1FEaFFxRUFwY3NlbE1MSXVWb0VP?=
 =?utf-8?B?UG1RaUFGYktMbEl5YVRhVmYyekE0b3NmZFE1YmJkdzc4eDdBZDhCandKOGVl?=
 =?utf-8?B?RUl5MXVFTGo1S0xTWmhnRjlnOWUyd1ZUMHdQSzY3WnZaTE5VUUtJUUp1NGhM?=
 =?utf-8?B?bnZzc0FsbzlET0lmNlN6N1RLdDZsS3NpOE1Ob0EvdmFpemhNcm5Sb0FuVGNF?=
 =?utf-8?B?a0lMYWJhSXBCMVJwR0s2S2luVXc5cHBVbGFSN20yQmQzWSt6NG03cXFMVHVG?=
 =?utf-8?B?QkVGR2NiYkV1Skt0amdIMWpNWDdIdFljS2NnUjFEemJlcFFMajdLSE9OMDRx?=
 =?utf-8?B?SndNR2UrTlZBVmtYSFNrcnVjNTl1Wm9vdW5MTmN4RkYvZnYrdGI5d2tTRXVk?=
 =?utf-8?B?RjJLZWpua1JaRGpVOEFkZ210VFR0dTh6QmVKcWM3VHJENVJma005bVBFVVZa?=
 =?utf-8?B?ajU4a1dEb1BtRlZtRWw3RlRNRUR6UCtGRGZrVFBIa1JhNlJKK2RQaGs4Yi9J?=
 =?utf-8?B?bFNucXNZOEtBVzlFdGVxUWd3M0hjN0FaZlRGMENmbHU4TEVORGVvRnRwVW1S?=
 =?utf-8?B?UGZZUTErVmJ3Ly9jbG5uUGZNNmcvNXZndUlFLzBQVVhoRUN3a0puUDgvZTNx?=
 =?utf-8?B?Vk9MVEljQ3d0eDFvOU9aZGQ4OTRmN2VLVE00aldHTWFPcGd3RFNXN2pwYUpJ?=
 =?utf-8?Q?rH5z7ldZ+W/wHpsqbL2TKnXLsxwB2xX7c/Tz17QDErj03?=
x-ms-exchange-antispam-messagedata-1: PqhmQQBFou5R7zGe1XLUiaZaG+mocYWNGJw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <517718655B204549A522DFFA87689306@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0J1rZTij7/ebyvDVBbeZdhDI8TvorlO7poCemYU5mRed20beiIq/BHXC+v6cRb8f6U7nEHIBFMhjTcST9k2ypxAJpg5GWyHXMm3aFIcoK6qtYARhuBMRckz1DWW2Cw0YqyFfhqmMpPl9+U4nIec0dIvxpZF5nwsSXJR7x0ZEprU+RdlePitQargIKTXq1znXxaTB9lVN9N4zpUvT17m05YNQoin5GkGSL6S8drEbeqCTUGWTS9/gjGMBv4akaYREqCelMJ++yO/R1RsBw+7zEBwCNluBzXJNPc4Wgx/sCMEwA9JqQ/3+EoJ7nnWO1kmV9o+R+pszVsJjTrpk8CJPJA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: v+vUKJh0PDrOOeR0hESFa7YZ/AaEcYxxIcK+2rGr73EKcxr0ncLbhWkgwpdwVn1kW9lH+Gr80aAQ2hAGfaJm635RJ0gdbe2BOuIrXud65TytNCIcbjGK1idaDIYiVqFUpGTwmERVAY3S4v82suhGNTMPyBWQD8GoAsArQcjb7+dVXgszjUPIB90aw+GOhGYWsMbO8h9kENGJGWaiV7lCfmcKuiKyewrflpUvIMQU6mk2isqQDmWqDRkaDBdtFL0xuXC0YDFWjrlWlIp0uw01hXGX63G6fJbwIcQyZfwkQiyzZ1jX+8mUkLmzDhpfJcveEu1Fxz6Lom7nU+jbujxE5vaLMUX3bvU/Ewd9icuzgyCUgo5m/dZKvcwmliyzj8c8C7MTGEAtYnPmt/DkU0QUkkl6wqCGXRAaaMU3lCb42wzht8kBmm/g/IGmhEUcKeOpUCJ8AFIVcxtBFWSgWjg20EK8kkVww5lrvex4NMW9nZwVletMFDct3zDkKYTveWFMyz8CtIXxRW0hSrwfGhISlEQYOo6h7wRDk/4mTgYOZHziiZpMSaK7a/Ce1dgv1ok/QHUhS7rA4P8ASBQeA13oiyuj1kP8GGgsI+pg4DGGf5d2ijWvYCVu3GdU7IWYzw76
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4e9ee7-f8df-4c10-f907-08df34d78091
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 09:40:28.9448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CX+K+GtR72Z+RxvmRBkKG8T3hkIouYDKHabM9gSqUC84FBNus8r3XOyCSxZtQ1IIymAOSPu25yuvJ07j+kIoCXMnY75oO3CTfjrfq8dfuwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7768
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=75473350e=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
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

T24gV2VkLCAyMDI2LTEwLTI4IGF0IDE0OjMwICsxMDAwLCBQb3J0aWEgU3RlcGhlbnMgd3JvdGU6
DQo+IEluIHByZXBhcmF0aW9uIGZvciBhZGRpbmcgdGhlIFJDUFUsIHB1dCB0aGUgQXNjYWxvbiBo
YXJ0cyBpbiBhDQo+IENQVUNsdXN0ZXIuIFRoaXMgd2lsbCBhbGxvdyBnZGIgdG8gcHJvcGVybHkg
aGFuZGxlIENQVXMgb2YgZGlmZmVyZW50DQo+IHR5cGVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
UG9ydGlhIFN0ZXBoZW5zIDxwb3J0aWFzQG9zcy50ZW5zdG9ycmVudC5jb20+DQoNCi0gW01FRElV
TV0gSW4gaHcvcmlzY3YvdHRfYXRsYW50aXMuYywgVFlQRV9UVF9BU0NBTE9OX0NMVVNURVIgbmV2
ZXINCnNldHMNCiAgZGMtPnVzZXJfY3JlYXRhYmxlID0gZmFsc2UgKHVubGlrZSB0aGUgc2libGlu
ZyBTb0MgY2xhc3MgaW4gdGhlIHNhbWUNCiAgZmlsZSksIHNvIGRldmljZV9hZGQgcmlzY3YudHQt
YXNjYWxvbi1jbHVzdGVyIHJlYWxpemVzIHRoZSBkZXZpY2UNCndpdGgNCiAgY3B1LXR5cGUgTlVM
TCBhbmQgdHRfYXNjYWxvbl9jbHVzdGVyX3JlYWxpemUgdHVybnMgdGhlIE5VTEwNCiAgb2JqZWN0
X3Byb3BlcnR5X3NldF9zdHIgd2l0aCAmZXJyb3JfYWJvcnQgaW50byBhIGhvc3QgcHJvY2VzcyBh
Ym9ydC4NCiAgQWRkIGRjLT51c2VyX2NyZWF0YWJsZSA9IGZhbHNlIGluIHR0X2FzY2Fsb25fY2x1
c3Rlcl9jbGFzc19pbml0OyB0aGUNCiAgdHlwZSB3YXMgaW50cm9kdWNlZCBieSBhbiBlYXJsaWVy
IHBhdGNoIGluIHRoaXMgc2VyaWVzLCBzbyB0aGUgZ3VhcmQNCiAgYmVzdCBiZWxvbmdzIHRoZXJl
Lg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoGh3L3Jpc2N2L0tjb25maWfCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4gwqBody9yaXNjdi90dF9hdGxhbnRpcy5jwqDCoMKg
wqDCoMKgwqDCoCB8IDEzICsrKysrKysrKysrKy0NCj4gwqBpbmNsdWRlL2h3L3Jpc2N2L3R0X2F0
bGFudGlzLmggfMKgIDIgKysNCj4gwqAzIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9yaXNjdi9LY29uZmlnIGIvaHcv
cmlzY3YvS2NvbmZpZw0KPiBpbmRleCBkODlmZGZjYzg2Li40ZWNjZmE0NDNlIDEwMDY0NA0KPiAt
LS0gYS9ody9yaXNjdi9LY29uZmlnDQo+ICsrKyBiL2h3L3Jpc2N2L0tjb25maWcNCj4gQEAgLTE0
OSw2ICsxNDksNyBAQCBjb25maWcgVEVOU1RPUlJFTlQNCj4gwqDCoMKgwqAgc2VsZWN0IERFU0lH
TldBUkVfSTJDDQo+IMKgwqDCoMKgIHNlbGVjdCBEUzEzMzgNCj4gwqDCoMKgwqAgc2VsZWN0IFRN
UDEwNQ0KPiArwqDCoMKgIHNlbGVjdCBDUFVfQ0xVU1RFUg0KPiDCoA0KPiDCoGNvbmZpZyBYSUFO
R1NIQU5fS1VOTUlOR0hVDQo+IMKgwqDCoMKgIGJvb2wNCj4gZGlmZiAtLWdpdCBhL2h3L3Jpc2N2
L3R0X2F0bGFudGlzLmMgYi9ody9yaXNjdi90dF9hdGxhbnRpcy5jDQo+IGluZGV4IDliMzdlODQ1
ZGEuLjU4N2M2ZWE3MzMgMTAwNjQ0DQo+IC0tLSBhL2h3L3Jpc2N2L3R0X2F0bGFudGlzLmMNCj4g
KysrIGIvaHcvcmlzY3YvdHRfYXRsYW50aXMuYw0KPiBAQCAtNTAsNiArNTAsOCBAQCBRRU1VX0JV
SUxEX0JVR19PTihUVF9JTVNJQ19TVFJJREUgIT0gKDB4MTAwMCA8PA0KPiBUVF9JTVNJQ19HVUVT
VF9CSVRTKSk7DQo+IMKgI2RlZmluZSBUVF9BQ0xJTlRfTVRJTUVDTVDCoMKgwqDCoMKgIDB4ODAw
MA0KPiDCoCNkZWZpbmUgVFRfQUNMSU5UX1RJTUVCQVNFX0ZSRVEgMTAwMDAwMDAwMA0KPiDCoA0K
PiArI2RlZmluZSBBU0NBTE9OX0NMVVNURVJfSUTCoMKgwqDCoCAwDQo+ICsNCj4gwqBzdGF0aWMg
Y29uc3QgTWVtTWFwRW50cnkgdHRfYXRsYW50aXNfbWVtbWFwW10gPSB7DQo+IMKgwqDCoMKgIC8q
IEtlZXAgc29ydGVkIHdpdGggOic8LCc+IXNvcnQgLWcgLWsgNCAqLw0KPiDCoMKgwqDCoCBbVFRf
QVRMX0REUl9MT10gPcKgwqDCoMKgwqDCoMKgwqDCoMKgIHsgMHgwMDAwMDAwMCzCoMKgwqAgMHg4
MDAwMDAwMCB9LA0KPiBAQCAtNTUxLDcgKzU1MywxMCBAQCBzdGF0aWMgdm9pZCB0dF9hc2NhbG9u
X2NsdXN0ZXJfaW5pdChPYmplY3QgKm9iaikNCj4gwqB7DQo+IMKgwqDCoMKgIFRUQXNjYWxvbkNs
dXN0ZXJTdGF0ZSAqYWMgPSBUVF9BU0NBTE9OX0NMVVNURVIob2JqKTsNCj4gwqANCj4gLcKgwqDC
oCBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChvYmosICJjcHVzIiwgJmFjLT5jcHVzLA0KPiBUWVBF
X1JJU0NWX0hBUlRfQVJSQVkpOw0KPiArwqDCoMKgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKG9i
aiwgInR0LWFzY2Fsb24uY2x1c3RlciIsICZhYy0+Y2x1c3RlciwNCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBUWVBFX0NQVV9DTFVTVEVS
KTsNCj4gK8KgwqDCoCBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChPQkpFQ1QoJmFjLT5jbHVzdGVy
KSwgImNwdXMiLCAmYWMtPmNwdXMsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVFlQRV9SSVNDVl9IQVJUX0FSUkFZKTsNCj4gwqB9DQo+
IMKgDQo+IMKgc3RhdGljIHZvaWQgdHRfYXNjYWxvbl9jbHVzdGVyX3JlYWxpemUoRGV2aWNlU3Rh
dGUgKmRldiwgRXJyb3INCj4gKiplcnJwKQ0KPiBAQCAtNTg5LDYgKzU5NCwxMiBAQCBzdGF0aWMg
dm9pZA0KPiB0dF9hc2NhbG9uX2NsdXN0ZXJfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJv
ciAqKmVycnApDQo+IMKgwqDCoMKgIGlmICghc3lzYnVzX3JlYWxpemUoU1lTX0JVU19ERVZJQ0Uo
JmFjLT5jcHVzKSwgZXJycCkpIHsNCj4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+IMKgwqDC
oMKgIH0NCj4gKw0KPiArwqDCoMKgIHFkZXZfcHJvcF9zZXRfdWludDMyKERFVklDRSgmYWMtPmNs
dXN0ZXIpLCAiY2x1c3Rlci1pZCIsDQo+IEFTQ0FMT05fQ0xVU1RFUl9JRCk7DQo+ICvCoMKgwqAg
LyogY2x1c3RlciBtdXN0IGJlIHJlYWxpemVkIGFmdGVyIHRoZSBoYXJ0IGFycmF5ICovDQo+ICvC
oMKgwqAgaWYgKCFxZGV2X3JlYWxpemUoREVWSUNFKCZhYy0+Y2x1c3RlciksIE5VTEwsIGVycnAp
KSB7DQo+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+ICvCoMKgwqAgfQ0KPiDCoH0NCj4gwqAN
Cj4gwqBzdGF0aWMgY29uc3QgUHJvcGVydHkgdHRfYXNjYWxvbl9jbHVzdGVyX3Byb3BzW10gPSB7
DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3Jpc2N2L3R0X2F0bGFudGlzLmgNCj4gYi9pbmNs
dWRlL2h3L3Jpc2N2L3R0X2F0bGFudGlzLmgNCj4gaW5kZXggNTJiNDQ1MDRhZS4uZTVmY2UxZjY3
NSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9ody9yaXNjdi90dF9hdGxhbnRpcy5oDQo+ICsrKyBi
L2luY2x1ZGUvaHcvcmlzY3YvdHRfYXRsYW50aXMuaA0KPiBAQCAtMTUsNiArMTUsNyBAQA0KPiDC
oCNpbmNsdWRlICJody9pbnRjL3Jpc2N2X2ltc2ljLmgiDQo+IMKgI2luY2x1ZGUgImh3L21pc2Mv
dHRfYXRsYW50aXNfcHJjbS5oIg0KPiDCoCNpbmNsdWRlICJody9jaGFyL2R3ODI1MC5oIg0KPiAr
I2luY2x1ZGUgImh3L2NwdS9jbHVzdGVyLmgiDQo+IMKgI2luY2x1ZGUgImh3L3Jpc2N2L3Jpc2N2
X2hhcnQuaCINCj4gwqANCj4gwqAjZGVmaW5lIFRZUEVfVFRfQVRMQU5USVNfTUFDSElORSBNQUNI
SU5FX1RZUEVfTkFNRSgidHQtYXRsYW50aXMiKQ0KPiBAQCAtNDAsNiArNDEsNyBAQCBzdHJ1Y3Qg
VFRBc2NhbG9uQ2x1c3RlclN0YXRlIHsNCj4gwqDCoMKgwqAgTWVtb3J5UmVnaW9uIG1lbW9yeTsN
Cj4gwqANCj4gwqDCoMKgwqAgUklTQ1ZIYXJ0QXJyYXlTdGF0ZSBjcHVzOw0KPiArwqDCoMKgIENQ
VUNsdXN0ZXJTdGF0ZSBjbHVzdGVyOw0KPiDCoMKgwqDCoCBNZW1vcnlSZWdpb24gYm9vdHJvbTsN
Cj4gwqANCj4gwqDCoMKgwqAgdWludDMyX3QgbnVtX2hhcnRzOw0K

