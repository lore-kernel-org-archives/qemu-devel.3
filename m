Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F8BE9E31E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 14:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqBfh-00040J-MI; Wed, 11 Feb 2026 09:58:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqBfg-0003zk-CY; Wed, 11 Feb 2026 09:58:28 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqBfe-0008Sz-IQ; Wed, 11 Feb 2026 09:58:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvcG8GFz4EUshW1Nh0FbNwyvxj/nO5yotg8gFoozg2X7GP03seqK/3mCqQRnlajRBCb/P7aYnWy+ctBhtNCFIgrRHjitrl6+EQRHhaWpp1zEBOdyHdJmU5vmCG5hVPBZHadGtIGWljW9FCsBZ/N72ancEvcoTxVLZsWJkUzIL2r09MhXOHM7z9gH3oWhqSaoSAmLN0hYlgVPYqvKjILCXjwvhYzFbPUMu0pwqHr763c4S3gIiFSPe+557oT2QPvdmW+TuFuYdqfBEsKLUvoctKoS/Rf1MnUUQiIJvabEYwFerrXTwPFpctJoQnzn7QDdjhdJEperAfR7PVbjPc+2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8Iz8mTQgBb9ldLosJQ3hM9Kr2/8cGwsDa79aeYIEWs=;
 b=dIh3TSoYe1SXPmveeGCPZAVkHgOGG/hYk1ExXE+LJIgJB5HeBDS7WpHgTzRI1DtNazTEws+ZwIExIDuf6p7IWhpKhFPDo8Ma4br/X4m0iF/Ad3OqLiH9GKSmNzT7rXaMQWDnDui5IT9AqRg+y0DliIxGYg06IOq8Jdr6Gr8wgTDmHQ85+WUzcup9fD9Z6V5/DZQtiqq+0r6iMEcJQUD8f7UOZ61lOeq05+jgrNuqPPRWDi0C0Pnd5N3yF8Lv+UZIvHuZJDjb8ziK/ti6kpkZfetP6uACX77copeixZs1sHI7iz04PkRwCtr+IqTeWImC1zfuf35exLpGaF5Djw6eXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8Iz8mTQgBb9ldLosJQ3hM9Kr2/8cGwsDa79aeYIEWs=;
 b=ceq3JZXOP3DOturYESA5PltbZTEYqIyD1v8XNouChwKcwk4x616XJ/PjrbDEDoRe2AMzOriJc4+l+1V0ZY+3nIeS37tINsyaJ4gHPsVwH9dTg0efBGriv95F9bqJFFGUCBvM+vqHJTV/QGVk9mOqKacSgHmR1LdgYXwA38pnXxu5lotOSQYeLYNUIbfYfs+AiiiAD6I8cyUQ5qzi/MHkoPt2Tpfh5gNG4FkmwPharQEjc6tFmvqrqbsHunuj4Zwyde9QAvUy/H2pUliMUqN4y10AOqWjghv/XUihZ/qic1GFVE89puMOSeLMAJmftWwnVvpUzsqswIUSKDHqBoZJZg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 14:58:20 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 14:58:20 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v5 5/5] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Thread-Topic: [PATCH v5 5/5] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Thread-Index: AQHcmzFoqccf9GB5jk+fZEkMPLUyhLV9jkKAgAAGJsA=
Date: Wed, 11 Feb 2026 14:58:20 +0000
Message-ID: <CH3PR12MB7548E3A22BA52954843F1BC4AB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260211083415.133534-1-skolothumtho@nvidia.com>
 <20260211083415.133534-6-skolothumtho@nvidia.com>
 <275ab451-4c37-4a78-bf5b-a76329bbf873@redhat.com>
In-Reply-To: <275ab451-4c37-4a78-bf5b-a76329bbf873@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|MN2PR12MB4286:EE_
x-ms-office365-filtering-correlation-id: 74833ea6-0b77-4df1-893f-08de697dfee2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UDNYM2t3am5WUVY0V1ZuQkZWYkVnczRpOGhUU05KelJsV0NPYWs1d0ZKeG9l?=
 =?utf-8?B?ZENZakxRQ1psSmJvSTFjMXlWT24rekJaMTlvN0R6U3FnbFQyNE9nV1RWVU9r?=
 =?utf-8?B?OEovc1NHaDdtT1c3bzVpQnZscVpZKzhJTUI0Q1lGVzlNb0RreUdtNzgvM3Rp?=
 =?utf-8?B?T0czSGxjT1A5NkJ6NW8xc0hDeTllYjJ3ZkNpeUJuR2F4RjQrS2x4T3pRclR5?=
 =?utf-8?B?Q2p5akRDVjZ1bjZmOG9zZmtWd0R5SVVEUFRUZVlManBJZVZuMk9PcGZRb0xl?=
 =?utf-8?B?MFJsSElscVFrR0hJZDFITFhkWkNiaTV3RUU4VjFaZWl1Vm5KSnU0b2h5VDZF?=
 =?utf-8?B?L2ZwaUtHWkxxWklhN005T1BHZzdOOVJaemtrQThScFJtVTJiMjg5OERoeXRK?=
 =?utf-8?B?SXFXWWIvemlrdjE0SUZibzdZRU92eEd1U2N2cEJMekthSmhRcC9HL0ZEdCtN?=
 =?utf-8?B?RFQ0RjJWd1Ywa1pPeWhzTm80RklUZG5VbFJQeUtuL1I2bXdnWWJvamYzZzVj?=
 =?utf-8?B?cDU4bm9MbHhKYnRuZ1NuVWw3SzlEMTg0ZmxtWTRtR2VGWEVsUXFidTJVZWJE?=
 =?utf-8?B?dFlDZzBKbnQyWTk1MWVpWTc4ODhPTVFwM2NxRjlzRXI3OUdKakZOeVJ6U0xG?=
 =?utf-8?B?Sk55Qy9NY1RCSmtWZ3hhcDNUckkxd1g0NmRHcGV2YU9QWS9yR2pyVUMyTDZY?=
 =?utf-8?B?RzV0MTFjTGFEYk9xVlpQeGFJa2dYZUFSbURmQ05ER1hqajlmZkNML3FkWHZk?=
 =?utf-8?B?Y1J6bG5GM3NpeUY0OTFrUzZxRS9zQ2tWdWRxUzR3L0h4SnFjekhrSFZCcExP?=
 =?utf-8?B?VGE5UlllVHdwa0Q3MWk3VHpMYzZGVkZ0b3QrTGVjWkpuOEFiZ1c5SlRzS2ps?=
 =?utf-8?B?dGFPcTQyT3BBTWFKcEdhSS9oV0FRNEd2QXBDRkY4N0JyRkFLMFNiWC85eUJr?=
 =?utf-8?B?NFBxT3l4V1N6NVk1UFF2WSt5TnZjUjlCeUhtQUwzYW1LeXFDejRBbVg2NUE3?=
 =?utf-8?B?eXhSUDVENlNndlFoSzVPbUxwMnRhM1BsbXVDUkovVWZBejd1SnBMTVZYMjh1?=
 =?utf-8?B?UU1JM3JPQnlFNmV2TkxjL0c0NTNLN2xMWmpRSzhpdjZyb28rTHVUbk1DbzJW?=
 =?utf-8?B?RCtEa0loR0FDUDhKZWJpQmFZeEkrWEJhK1pQd3R6OE9UcDFxQ2VyajMySnVr?=
 =?utf-8?B?NlNnUUN3NWxVdVBUbEJDQmRKVlQ0QXlVeU1taVRvbno3OFl5amJFazJydmMy?=
 =?utf-8?B?bFpOZWJ4YndMMGdSVTlGemV3cWhTaVpmamd3ckczaFhEdmNXQXhPMDlVYWxK?=
 =?utf-8?B?UkQrWlRWTTE2SXFLWEJnaUEwNWhoVzhuYkx2eXJ3Z2pSVFlkVVhTSnpJTTZr?=
 =?utf-8?B?SzExTU9ySXVMeUZnRXBEaDE3QnIyV1RDQ294V1gxMzdwdmNNaVJMZFBDRUd6?=
 =?utf-8?B?M2dsNDQvQzNJV1lPUGFFNGppa3ZtSmxGTkpUalBEU3Uxb1ZiU2NBV2RzeCs4?=
 =?utf-8?B?UitCYTgycWlhSm84VUZPbVRBY1FrK1ppVmozNXBrWnRVdTJidytYTUxEc09o?=
 =?utf-8?B?eVBaYjBhbEsxRnpJVHdVaFl1eGhJOXBPY0dRSUdMU0lmRm1HL3NyOGV4cG11?=
 =?utf-8?B?M2J3NGRBMkd6V2t2ODFPcUkwUWt6em43MCtZVFl5NTdQL3p3MXIvQ1JsMUVp?=
 =?utf-8?B?RjdzaHF1TFdWZjFhL3RCRG1aNE11QW9jbWdJN2lRcUFhVUhuR0tJNU1MclAv?=
 =?utf-8?B?VTEvc1hLQXY0bDRuL3Z1WHBsV2I1TFRBNkVIZ1o5R0FKUU82RHBrOWVFRzBi?=
 =?utf-8?B?VmthSm9YSVAxcldVeWxzSk5TSElrN1VWMG8xd2h2Z1VsS0JmaElWcS9MWHE2?=
 =?utf-8?B?WmlNMUhYWWRxa2pTOEFzUTJqaTdoMG5XUEV1dXpHTUlmRkpJcXIxSW10SWxY?=
 =?utf-8?B?ZUhML2tDR2lGQW9OMnFPeXJwUG9lS05RMjdvTU0zR0M4aHhiRk9JTk5OYVA5?=
 =?utf-8?B?YzE4TFZYcG9nNlVoUWF0TVZsYkRkN0lFT3AvbHBCbHFjNU11SGR5VEY1aWFn?=
 =?utf-8?B?OXhnWGxRTE0valY1bUhtc0JHd280c2gvMDlsM0tpTkh0S2xxSjhVb1Z5UXpv?=
 =?utf-8?B?VldBcjNrblF4bDdXbkJka05NZUg0WU9TNFVxT2prOVdyVGhJUkt5TVJ4THlO?=
 =?utf-8?Q?KCiWfwZqko/ccs808wIpyR0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXRaS1IrczlpZ2ZId3FoUWpjVDdzcmhsd05xYlRWWHZOM3pOckFqRjA2T2c0?=
 =?utf-8?B?dW5HVDhlOWozRkQreFFQUFdnWDZVR3ZVeFFyaks3eVg0OEhPeVFnZVY1c3FN?=
 =?utf-8?B?R0pOdFFYSkFzc0JPRXBvbjcxNzcxUkpzdkVUek9hWUQzV0VlTVVWcjZHSW5p?=
 =?utf-8?B?VXFlN0c2Nzg5TktqbFphdUdxcU9CRWNEVnNyeVA5NmRWRkw1aHFxbU9hSkN3?=
 =?utf-8?B?clZJOCtsQ1J6OG5TVytSQXh0ZzlyQzlaK0k2WitHd29PcUVzTlA2dEI5OHZt?=
 =?utf-8?B?aUFyWHIvdFV5ZkttVVlZbU1kZUlYMWFPa0tVRkF6MzM5RlJIK0dTT1g2RldY?=
 =?utf-8?B?YkN2Sk8rTENsOTlTWit4K2Q4ZjEvN055aW9wcDRHaFhCK0JxSG00RzJrK3Qw?=
 =?utf-8?B?VGdHMmU0NFpmdFRocm9QaThiRUNtNFhBSEp5NjQ1OVFzeGlacXdMRzFJQ3g4?=
 =?utf-8?B?VlJUalVydHp0d0pJR3JPazNtdmdGdy83ejUvU1AyNHBCU2t2WTFRclBwUjd5?=
 =?utf-8?B?aml3OXNCT3pxTXB5NVpCMkc2VGNZVDI2L0pBN2ZacFpyY014RXd1blRNRmhw?=
 =?utf-8?B?VFFveVRvVWVEZFBRcVd3Y0RJS2cyUEtYVjNUUDdzNmFTUHVEOG0wU0lMVlp0?=
 =?utf-8?B?cUF5VTdBSjdRMUxveXRKYnEwNlpBQUVtdTdQUk13TThLTmx0TENlMnhtRHhC?=
 =?utf-8?B?L0xJVEdiR3UweElnRUdST2tCZVBKNkhMbStmZG56NmZzQXlxVnBUbE5Hakpr?=
 =?utf-8?B?QjkyU08xNzlHK0ZMcVJ3VWR3TWhaelh5VlFnMHJsR0x2TXlCOVNEUFJPN2tD?=
 =?utf-8?B?eEJla1N5a3duOHhnM3hOMHY2RXlzVnpQYmp3ekVpd1ZFWjZZOTJQRzdwM05n?=
 =?utf-8?B?WWM1WWlaS3BtRTVJc3BKRXBXZHZTRGxGQ0o0MHdYYzNOa2xOdzNmQ3U5alJo?=
 =?utf-8?B?ajd4L3pKRmtFdjRQSy92NGpBNk1TbmZacVgxU3QvS1ArYXlVYXJBT3dMMHJH?=
 =?utf-8?B?ZVhZam5jVHRPV3Iya0ltR29xakI3VmRaRkZudEkyZ3BhS29RT2toSHNLTitn?=
 =?utf-8?B?aHJEZFl4Um5yWmUvV3JqRnFreFBXcTlLOTMwU1orKzBPSk1YajhzOGpYS1dT?=
 =?utf-8?B?VGRyVmZ6YjZLRkQ2YTJaYnBKeVBWWWZtWm5oZHoyWWhqQW1LbWRTSCtVcDJo?=
 =?utf-8?B?ZGhBTld3Q2tDMnRPK1JwT0VFZVR4ZjJjL3IwZVAxNUplQTVmRWZxSXZqcWFL?=
 =?utf-8?B?RVRaZGNGdkw0VFBTWHVHYnFxMjVWclVzWjJSbWgyOFBEclB1Qm9iQVQ3RzBq?=
 =?utf-8?B?VHk2NlR2ekNIRmdNUFBwd0J2K0FRcDVYTlhlay9tT3JFcWxxbzlTQTl5OXQ4?=
 =?utf-8?B?SzlxK21EWjRvRUJmeXNRRWtFbTFOWVp4QkNwNm8xQWlNVmJKck93RzcxNVY3?=
 =?utf-8?B?WXVicFkreUo3bDhVUXk0R1F6UXBobE5vS1ZZSkRKYVRYNEtHOXR1Q1RQYWtO?=
 =?utf-8?B?WjRZK0xacTFmaHFKY2hCNU13YmhSekxOVGhvMDc4RlJsL282NTczWHZzOEZC?=
 =?utf-8?B?QmNUN1hsb3NnN3pqc3VVT1RUOU5CL0RUeXZoNURySnprTk9tcGRjSmI0QTFp?=
 =?utf-8?B?c0RhWVpEaVU3R2pqa3hRdHNhNllHSFNvMjFBbTdiVzkvdkhkM2JIWFZubFV0?=
 =?utf-8?B?UTJZZEQ0Njl5bUFRbzFUajJJRitDUDFzVGtkL3dmMEo2OUFrSEorTnJ4K0lL?=
 =?utf-8?B?ME5xSXZGWDkxNmptRURBZ0l1cnVNSFhsQVVpbE1oWDJVQWs0QTcyZUtuSVFX?=
 =?utf-8?B?NWFqL2lmSy8zTzNkcFd5M001UTJNWEY2KzZNaXVNZDlHdTBHRlJGNlhQbzAr?=
 =?utf-8?B?YjlXK05mZXkxSTdGSGhkWGNKNHZlQUtQSDlzU1BOYU9GcC9VYVpNN0pPWFVF?=
 =?utf-8?B?ZytqR3lqa1JFaXlRVGx4L3kwMzNWbXU4SUdTbWtwZWZ4OWdBQlRTM0JJVEZk?=
 =?utf-8?B?WmgxT1pmSFZtQit5TVBzNVZ6c2M4WEJBZEk5VTdqQk5RUHNpYUpuOGdEajBu?=
 =?utf-8?B?MWZ6SVVWaG9sOFZCcjh5Mm9kelY0aXRuU090dGVYMUY5c2xRTTBHYUVTZ2Ra?=
 =?utf-8?B?eHpDdk83OFlucG03RWxUZitpeDJrQWZPWjR3WnlwTUs5aWEzbTI4YlIzbEs5?=
 =?utf-8?B?NXprQnFpeXRybi9FRmJseDA1Z2d5c2JLUnRlRWRkZW1weUtsY0ZRVWlQR3gr?=
 =?utf-8?B?OERJS05ZRzhtQ1RiS2VoSm01U2FzWGVyYS9qZTVwOURFREg1R2lFc0p2RUh5?=
 =?utf-8?B?L202RWRuWHVYYlJlNmtocVQzQW0rNlh2QTJBbEVTS2V4WTR3WUhCZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74833ea6-0b77-4df1-893f-08de697dfee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 14:58:20.0831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EpiWCz/m60WvegF/m2OyjRtjqFWcjai3YnggVaLy0r0mRJv7AYOe22SiDlQtTHJvg6Me75mFuwMNZzLhBcAqOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDExIEZlYnJ1YXJ5IDIwMjYgMTQ6
MjYNCj4gVG86IFNoYW1lZXIgS29sb3RodW0gVGhvZGkgPHNrb2xvdGh1bXRob0BudmlkaWEuY29t
PjsgcWVtdS0NCj4gYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzog
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5j
b20+OyBOYXRoYW4NCj4gQ2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPjsgTWF0dCBPY2hzIDxtb2No
c0BudmlkaWEuY29tPjsgSmlhbmRpIEFuDQo+IDxqYW5AbnZpZGlhLmNvbT47IEphc29uIEd1bnRo
b3JwZSA8amdnQG52aWRpYS5jb20+Ow0KPiBqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb207IHpo
YW5nZmVpLmdhb0BsaW5hcm8ub3JnOw0KPiB6aGVuemhvbmcuZHVhbkBpbnRlbC5jb207IEtyaXNo
bmFrYW50IEphanUgPGtqYWp1QG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUg
NS81XSBody9hcm0vc21tdXYzLWFjY2VsOiBSZWFkIGFuZCBwcm9wYWdhdGUgaG9zdA0KPiB2SU9N
TVUgZXZlbnRzDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5r
cyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IEhpIFNoYW1lZXIsDQo+IA0KPiBPbiAyLzExLzI2
IDk6MzQgQU0sIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4gSW5zdGFsbCBhbiBldmVudCBo
YW5kbGVyIG9uIHRoZSB2RVZFTlRRIGZkIHRvIHJlYWQgYW5kIHByb3BhZ2F0ZSBob3N0DQo+ID4g
Z2VuZXJhdGVkIHZJT01NVSBldmVudHMgdG8gdGhlIGd1ZXN0Lg0KPiA+DQo+ID4gVGhlIGhhbmRs
ZXIgcnVucyBpbiBRRU1VJ3MgbWFpbiBsb29wLCB1c2luZyBhIG5vbi1ibG9ja2luZyBmZCByZWdp
c3RlcmVkDQo+ID4gdmlhIHFlbXVfc2V0X2ZkX2hhbmRsZXIoKS4NCj4gPg0KPiA+IFRlc3RlZC1i
eTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+
ICBody9hcm0vc21tdXYzLWFjY2VsLmMgfCA2Mg0KPiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ID4gIGh3L2FybS9zbW11djMtYWNjZWwuaCB8ICAyICsrDQo+
ID4gIDIgZmlsZXMgY2hhbmdlZCwgNjQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2h3L2FybS9zbW11djMtYWNjZWwuYyBiL2h3L2FybS9zbW11djMtYWNjZWwuYw0KPiA+IGlu
ZGV4IGQ5MmZjYjFhODkuLjBkNWRjZWY5NDEgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3NtbXV2
My1hY2NlbC5jDQo+ID4gKysrIGIvaHcvYXJtL3NtbXV2My1hY2NlbC5jDQo+ID4gQEAgLTM5MCw2
ICszOTAsNDggQEAgYm9vbA0KPiBzbW11djNfYWNjZWxfaXNzdWVfaW52X2NtZChTTU1VdjNTdGF0
ZSAqYnMsIHZvaWQgKmNtZCwgU01NVURldmljZQ0KPiAqc2RldiwNCj4gPiAgICAgICAgICAgICAg
ICAgICAgIHNpemVvZihDbWQpLCAmZW50cnlfbnVtLCBjbWQsIGVycnApOw0KPiA+ICB9DQo+ID4N
Cj4gPiArc3RhdGljIHZvaWQgc21tdXYzX2FjY2VsX2V2ZW50X3JlYWQodm9pZCAqb3BhcXVlKQ0K
PiA+ICt7DQo+ID4gKyAgICBTTU1VdjNTdGF0ZSAqcyA9IG9wYXF1ZTsNCj4gPiArICAgIFNNTVV2
M0FjY2VsU3RhdGUgKmFjY2VsID0gcy0+c19hY2NlbDsNCj4gPiArICAgIHN0cnVjdCB7DQo+ID4g
KyAgICAgICAgc3RydWN0IGlvbW11ZmRfdmV2ZW50X2hlYWRlciBoZHI7DQo+ID4gKyAgICAgICAg
c3RydWN0IGlvbW11X3ZldmVudF9hcm1fc21tdXYzIHZldmVudDsNCj4gPiArICAgIH0gYnVmOw0K
PiA+ICsgICAgdWludDMyX3QgbGFzdF9zZXEgPSBhY2NlbC0+bGFzdF9ldmVudF9zZXE7DQo+ID4g
KyAgICBzc2l6ZV90IGJ5dGVzOw0KPiA+ICsNCj4gPiArICAgIGJ5dGVzID0gcmVhZChhY2NlbC0+
dmV2ZW50cS0+dmV2ZW50cV9mZCwgJmJ1Ziwgc2l6ZW9mKGJ1ZikpOw0KPiA+ICsgICAgaWYgKGJ5
dGVzIDw9IDApIHsNCj4gPiArICAgICAgICBpZiAoZXJybm8gPT0gRUFHQUlOIHx8IGVycm5vID09
IEVJTlRSKSB7DQo+ID4gKyAgICAgICAgICAgIHJldHVybjsNCj4gPiArICAgICAgICB9DQo+ID4g
KyAgICAgICAgZXJyb3JfcmVwb3J0X29uY2UoInZFVkVOVFE6IHJlYWQgZmFpbGVkICglbSkiKTsN
Cj4gPiArICAgICAgICByZXR1cm47DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgaWYgKGJ5
dGVzID09IHNpemVvZihidWYuaGRyKSAmJg0KPiA+ICsgICAgICAgIChidWYuaGRyLmZsYWdzICYg
SU9NTVVfVkVWRU5UUV9GTEFHX0xPU1RfRVZFTlRTKSkgew0KPiA+ICsgICAgICAgIGVycm9yX3Jl
cG9ydF9vbmNlKCJ2RVZFTlRRIGhhcyBsb3N0IGV2ZW50cyIpOw0KPiBpbiBjYXNlIGluIHRoZSBm
dXR1cmUgd2UgZW5kIHVwIHdpdGggc2V2ZXJhbCB2RVZFTlRRcywgaXQgbWF5IGJlDQo+IHJlbGV2
YW50IHRvIGxvZyB0aGUgcXVldWUgaWQvdHlwZQ0KPiANCj4gQWZ0ZXIgcmVhZGluZyB0aGUgbGlu
dXggdWFwaSBhZ2FpbiwgdGhpcyBzZWVtcyB0byByZWNvcmQgYSBxdWV1ZQ0KPiBvdmVyZmxvdy4g
SSB3b3VsZCByZXBsYWNlIHRoZQ0KPiANCj4gInZFVkVOVFEgaGFzIGxvc3QgZXZlbnRzIiB0cmFj
ZSBieSAicXVldWUgPHR5cGU+IDxpZD4gaGFzIG92ZXJmbG93ZWQiLiBUaGlzDQo+IHdvdWxkIGFs
bG93IGRpZmZlcmVudGlhdGlvbiB3aXRoIHRoZSBjYXNlIGJlbG93Lg0KDQpPay4gTWFrZSBzZW5z
ZS4gPGlkPiBpcyBhbHNvIHVzZWZ1bCB3aXRoIG11bHRpcGxlIFNNTVV2MyBpbnN0YW5jZXMuDQoN
Cj4gDQo+ID4gKyAgICAgICAgYWNjZWwtPmV2ZW50X3N0YXJ0ID0gZmFsc2U7DQo+ID4gKyAgICAg
ICAgcmV0dXJuOw0KPiA+ICsgICAgfQ0KPiA+ICsgICAgaWYgKGJ5dGVzIDwgc2l6ZW9mKGJ1Zikp
IHsNCj4gPiArICAgICAgICBlcnJvcl9yZXBvcnRfb25jZSgidkVWRU5UUTogaW5jb21wbGV0ZSBy
ZWFkICglemQvJXpkIGJ5dGVzKSIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgYnl0
ZXMsIHNpemVvZihidWYpKTsNCj4gPiArICAgICAgICByZXR1cm47DQo+ID4gKyAgICB9DQo+ID4g
Kw0KPiA+ICsgICAgLyogQ2hlY2sgc2VxdWVuY2UgaW4gaGRyIGZvciBsb3N0IGV2ZW50cyBpZiBh
bnkgKi8NCj4gPiArICAgIGlmIChhY2NlbC0+ZXZlbnRfc3RhcnQgJiYgKGJ1Zi5oZHIuc2VxdWVu
Y2UgLSBsYXN0X3NlcSAhPSAxKSkgew0KPiB3b25kZXIgaWYgd2UgbmVlZCB0byBoYW5kbGUgYW55
IGh5cG90aGV0aWNhbCB3cmFwLXVwIHNpdHVhdGlvbj8NCg0KVGhpcyBzaG91bGQgbm90IGJlIHJl
cXVpcmVkLiBUaGUgc2VxdWVuY2UgaXMgX191MzIgYW5kIHRoZSBkZWx0YQ0KIGlzIGNvbXB1dGVk
IHVzaW5nIHVuc2lnbmVkIGFyaXRobWV0aWMsIHNvIHdyYXAtYXJvdW5kIGlzIGhhbmRsZWQNCm5h
dHVyYWxseS4NCg0KVGhhbmtzLA0KU2hhbWVlcg0K

