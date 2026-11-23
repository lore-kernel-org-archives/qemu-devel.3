Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D1B606A32A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 05:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=CkyEfhUJ;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=AKURPlhk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVMOX-0003ZG-E5; Mon, 23 Nov 2026 00:15:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVMOD-0003Xc-A5; Mon, 23 Nov 2026 00:14:54 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVMOA-0001EW-TH; Mon, 23 Nov 2026 00:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795410890; x=1826946890;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=LRbXyqz5qYe01geKqGX0YTF3i1yn8k8DfxtGlr0awu8=;
 b=CkyEfhUJUXK3zfQkVBhAeFhFt4qG6GisQjCSZjoMXAiYp32R0bGJ4Jd/
 tqbEKUdKKHcUXFZflPA57RaYVOYG5v2tTqcL46b0BuirCTzYWvXTex2wO
 l+inqEiiAdufGUlm3jhKYOq42a0T8BBsahl76KHCxNtxriP3kcIKwowA8
 AEcicJ3rGNf9lelYXxyZvEFILRrxUc+xTIUOvXQr2N8PBk8MNx164KUf4
 5lsYqi7BIXG4luB12Sh9pCQGeA7FD+ZqH0OS/dOzBpBTQuW0f8/2VVkz4
 MjU/CqUyKo+boNwfM06rzeRsDoIurFFmzzLZ8jKv02Gk4UjoeMUG0KBpl g==;
X-CSE-ConnectionGUID: LiEwGU7ZT/amSn2r1fu3zQ==
X-CSE-MsgGUID: QQLcqZlVQtu1WUQHmN4a9Q==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; d="scan'208";a="161460506"
Received: from mail-westus2azon11012067.outbound.protection.outlook.com (HELO
 MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.67])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Nov 2026 13:14:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0CvxttOwNM6erAYAHrWzBWyCbEeNorSMy4iEan5nRzvL4dV3FyvC1GM+HLd+DJHItZRt4eR2hFCm+xRp+HEyu9SjWvQKlQmg3gu6wGUW/3SKz/0ROSwUb1UvhwNlTGF267hNNEgvnT8WuEO6B6WmAHNF7/+NJnvCvECwtu1/AWgRNQiGzXnz1BymdvLbjuNwJFqBFwiRnwPKo5qn6RJXotzd+3VI70hU98UWU+G2kNc1fOfKzfJKog6id5MLutkjJxt9s3hUNxciNNATB/7g8oVhR48l74cB+ZpPIDXAASEGK6JgKdHJwkz5Re9D96eyI9CoEQ5KEbA8peeqloHJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRbXyqz5qYe01geKqGX0YTF3i1yn8k8DfxtGlr0awu8=;
 b=rDZzXn8iQxSwVq3jHAkSGLDS/5s0XKLaAu+YiFNTJMcgxU7mXZbOui1B0yQq1nJyhK3L7oJCPPUyBiBKm3ymBqGIf5bhJZLPpDWoLeNbGvA2EykAjROm2X/Oi4HdKxLxn/aQiCvr8L27WrO/+7xhQahJS2yyLwzuqidLvGg/AQwx9oewbPh1jXKjyVyDrHex5MSdeQA+21TRUWI/idxHzlQlm/eoMbqJbfpFznttuMelzqBT3QJgIN6xlCNFxQQ8ZRKsZZe97RfEmrHJtJFmnwRBRsuHr1vmKQY3jbymzzNoIcIffcCC63L8G9/aPbOMJ73xTqbZ+ZHqkqKWHh+TrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRbXyqz5qYe01geKqGX0YTF3i1yn8k8DfxtGlr0awu8=;
 b=AKURPlhkAL6SZDcIyOf5ELbR0vmFz5s1rszl8Sr/5XyeyeXbPF/lbVVhYrB1X3zhjhice9JGblcGP4gEeE0Yn25kyojzySRVDRb2YKdkAUq1+8ICRKx5B9hvC2tigFRlaHsrbTGLqOuB3IW+13wRemwwQF0zTQvPbp+59gEvmdE=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by CO6PR04MB7524.namprd04.prod.outlook.com (2603:10b6:303:b2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 05:14:32 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 05:14:32 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "bin.meng@processmission.com" <bin.meng@processmission.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "liwei1518@gmail.com" <liwei1518@gmail.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v5 06/26] hw/riscv: sifive_u: Correct the L2LIM maximum
 mapped size
Thread-Topic: [PATCH v5 06/26] hw/riscv: sifive_u: Correct the L2LIM maximum
 mapped size
Thread-Index: AQHdbHMhA/EB/pb0eEGK7e3JIFTjKrc7OiSA
Date: Mon, 23 Nov 2026 05:14:32 +0000
Message-ID: <6a79b531095530f587479fee0c64208a829530f5.camel@wdc.com>
References: <20261104154207.641511-1-bin.meng@processmission.com>
 <20261104154207.641511-7-bin.meng@processmission.com>
In-Reply-To: <20261104154207.641511-7-bin.meng@processmission.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|CO6PR04MB7524:EE_
x-ms-office365-filtering-correlation-id: 0a1e63f0-a19e-489b-3f23-08df4920a856
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|366016|10070799003|376014|1800799024|18002099003|22082099003|4143699003|11063799006|38070700021|261026140227099003|261028144727099003|261021121427099003|261026121527099003|56012099006|261021123027099003|261022105027099003|261102123227099003|10067099003;
x-microsoft-antispam-message-info: R7Al+KK3A4uEjU169bvbSlx4oKpTHiTkZynHfWyozfB+f6lz8UTGTkVgL3srwpiRdl/UU6Q9GT+/R4BPQmJRoo/sULfEQFiUJTnyGGOmQjPFL4WCTy9NNk8pcKYe+wQm2LxMAarcQYM3jkoMh5k9ai6PqTodAcXpQ4RiHrMWYYBOWGkDEtc+s/W1uN3RAAbb1vhscJnqanWVjnKOdg1z4Nu5UiHlj/rlJLw0SSR3iMEiuJPiKV2MWxQYizoCa13+ZWcejL9KFADMFOphd50811MpeULzB7c7FOMU2RYZznjQ/KsTC6gv/PceH65EH0CSqFGX8j93rCqFqEFTVijeTcWd4NbxvTXUwfzvCqooHW2Qq9S7mOKwB4cUvRpZyUIOu3JiWvU+AOwntIC5QO6dVYrS/I5/u8lEHiVHGaNn4vWkp2IpX7Bmq4aje8f9J4YQV+Fd3RsJmSlSpByx5yEAXmBOJDsmP5uiPQ6Iis2g8hVfvp2g1HGSXYil+2gTeXiON8wqgAA5FnGzu0Z673E4p8XTEzYU6rsTBN34InGK5Vjf4oK140gMT9oTeTcLh7giwZzk1S5TyQeTrKm1K7JEVAFVBT77kweRRqtLqoZNrD/iI0YhNDJVCInIa+Cp74CpwuCDMxdgJytx+JL3P3h3+7nvDr3f91ALKGS2XD8TeOm0jjBgW9NTT3f9HHZia9Y2ckcyxKcA+7PZ7pj2oD3hfMlTbJoVPhhLlB9qyBVCDiA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(366016)(10070799003)(376014)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(38070700021)(261026140227099003)(261028144727099003)(261021121427099003)(261026121527099003)(56012099006)(261021123027099003)(261022105027099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUV6YWJZcjNINTlsWEZhckhtMndHbXIzSU1nRXh1ckhkS2p2TjZGdHlVWVI3?=
 =?utf-8?B?WDRYWmFuQlN1aDhwQ0FYd05MOFVISWl0U3Z3cmdtd0NoeHpkK0JnNGlzODdh?=
 =?utf-8?B?S1FwVEdrY3ZXeEVIRjJrRElYUXpnYmdaekswRi9KdGRSc2VFWVVCc3BFTU5M?=
 =?utf-8?B?cmF6enNYWWpoY2xFdmhtaVVrRDZKTjNpbWFRcTRyY2ExeWlJZlVzYVpYaXIr?=
 =?utf-8?B?VnpRZGREMVI4c0xpbkJ1NTFYdXpYMm41OU5aWFAxSlF6ZVJrNkJFRmYvN21O?=
 =?utf-8?B?dmgyS2pzSHBlcE5DZDkxYW1EZC9Wd3YrL1A3S1ZXQWVQWFZWeXYwVmlzVE9W?=
 =?utf-8?B?UWJRdy9ZRlg4bWxNL1JRY1V4K2I2SjZZVGpaOGNWbkJXUjhrWE81YzY0SjJn?=
 =?utf-8?B?VmtJTk5vVnpiL1g3SSsxYmx3NFYvS2hoZ2lKbVI5c1VFUzJDOUk1dDlwZGQw?=
 =?utf-8?B?aFdrSlc0UVp3RHF6cmd3YmxJaUl0b1h3MXdEc3hrcENwMGR0bnZFY1BvcVR1?=
 =?utf-8?B?Slc3K0N5aC8vTzZPc1RWeHdhaFRBSTJjc1p3d0ozd2lzaVhNdnVWZGdTTnhU?=
 =?utf-8?B?c0twc21VWHJmL1BBZWpmUThDb3haTng0NGdvN01XL2VEWWdvbHRVWHRDSUN0?=
 =?utf-8?B?emNwcWhnZnBFc0ptbll3SEpxV05tcGp1Z2FXdjlEblZhcitRZXJRVkFHYk9n?=
 =?utf-8?B?bi8ySUlpYkluQnhxajhUQlgwWE5JcTNvY3hkelVoNmhUNUlSdDhxOXhBT3l1?=
 =?utf-8?B?dGhwaWRVZDhxdHhmRmQ1UVFobm1xMXY5VnVkTnNvRzBjeEljQ24xSTNBQmd0?=
 =?utf-8?B?QTRkdFMxRUtlWWJYYkpHdzlyTlhaRDVqRjJRZFh4ZkdzOUVuZnpFRUpPL0gv?=
 =?utf-8?B?d2VncHhwZUZwS0pMcmVTc29zOHc2bmQwTUx1cEZvcFhqTVhJV2d6OUd2K3Uz?=
 =?utf-8?B?YTVNYUNweTdUNlNYbUZxREhxM2lMTzhFU0g0NDhkSFdkSGdlMGxsYW5DQkJT?=
 =?utf-8?B?eG4rN0FnVUo3U2ZUVGI1aEdyU1FjL3JVMDNjNVdsTUVzR2tLd051aDJOK0ht?=
 =?utf-8?B?cElzS0NkRFZWR1pmOTBtbTR3RFo4WmFmVytXRndhYUNIcXZ2T0F4cUxXN0M5?=
 =?utf-8?B?QUg1YmZNSUdMK09yUkZxZldiOFlFV2FvaFRMak8vMDNwenRQbVNNc0NTZnNS?=
 =?utf-8?B?clVFU3Q5U0RGU2NiWWgwMUhhOFZDM2FFS3NBaHQ0OHVCR0R3dTZFMzljVlR2?=
 =?utf-8?B?THVQQW14Y1FlZ0lpYXAvcHF3MlpRS1Zuek1YdmFtaGtEM3MvczFRc2lxRG5h?=
 =?utf-8?B?bFZLOCt2RzUxMXlnU0JVaWhWUlRmTG8wYU01Ny85dk13UmhBQ1AvNS96Zm81?=
 =?utf-8?B?b293NHdvbzBMMkFtRnNKK0dwbFR2TW9ZMDJMSllWazhRR2hhRW9KN0ZYL2E1?=
 =?utf-8?B?dWg1dWVRcXhtN0Z0VmNJTk1TWStmUUkxaWtLOTM3UmhhdGdKdWFONVZPa1FH?=
 =?utf-8?B?Zkx4Z05aM2p0VytOWXE5MWtPaU50ZERvSDZGSHIxejBTTDNRMC93eEZlWjkx?=
 =?utf-8?B?S0tkbDE0SU9zVDNMYitTR3RURDBiTUtSSmZSeTFaaVNaeS9yc0RMbFF0VHp1?=
 =?utf-8?B?YlI3TjhVUmVVbmRHaU9pQ0tqK2o4dG5jd096Y3EzZnBYb1MrVlBiYksrOVha?=
 =?utf-8?B?bDUzR1lvamRJaVN2ZVN3UUd4TzAvaUZtWHJHMkhhT280UFZtckd2bmg3WHV0?=
 =?utf-8?B?T2ZrS2c1ZlVQN0RzSWNZZHBJZTlHZ2ZtMEJ1YjJFQXgrOVJ5cE1iTjR2VUNV?=
 =?utf-8?B?WjZIcVpnbTgzY3VGeWZwamlxRnJpWUhxTjlJdnZtdElCWFkyekFJdGV2YXhI?=
 =?utf-8?B?TzdpbVJsaUlLcUorVEpXMTFDTVk2UktHaVpwWS83T1JhQ3BGRlRsVXpsaXZR?=
 =?utf-8?B?YmVzRDRKUy9qY2FZMUxZZGtka21xLzVIWmhEVmU4NmRyWXE5dmtCdTMvZUh1?=
 =?utf-8?B?ZW56NGlBaUlnT1orVGhGelZuNmh4bDNKc2M1Uk5kcFMwajVPTnhqMGlwbjZt?=
 =?utf-8?B?Vzc4Vk9CZXZaY3dyTHBrNkJDekZjUFRZVWZmanF2ejI5NmowL2c2RVBBNlJU?=
 =?utf-8?B?TFRKSDdKOFNrYVJ5Q21lZlJMR1hSdmpIV2RsNXkrSXlKZ2FCQUFwUENsWTVa?=
 =?utf-8?B?MUtsTHZ5UzhBZmNtVlNEWHpWQnBJT0hnR25hTHBBcEp5MUVKaTRnR2hjR1Yz?=
 =?utf-8?B?NHBiRTBXRllPcjcwakNZVy8yd0lRRUZ1azBSck1rdlZlWEI5NGVLREdjanBw?=
 =?utf-8?B?amFRNXcrUFJvOWJHekUreUtZV1Q1dDJCd0ZscU1ISUowcGdDYU4rdlZsUC9t?=
 =?utf-8?Q?grbRYCEiWsePt3O8EC3pjk0hzfRE9rzXqiAYo8ZgknqAy?=
x-ms-exchange-antispam-messagedata-1: knff9N2nLCWarAhL88STU3BYeSePSbveQNs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFA9DC668219AA4FBCA13EAD43B02E3F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: yEaP1Z3q/luXVty3vQbwE7S5NILv5CFVLa1IcHCYPQFCLNE586xhjmN5vQ9QGDa+v2zboEPN/zOb+vHAe+U3wJmubdsGsHcglG1mNWI6+Xm2TyajBj+fVTc1MKSabk7s89N8cIPtEG2a5gkZv+yEZPJjdS55N2FY4j+Is92Oel5VL3uiVnaChUIwlj4Qn6R23/baW4ZJRtzTA0bstm8l3HydOiA/rNbEVeGtE/jOjtc2XWP+25sQpLfSf/faGkblRNI1We787leqqG3BjT51DoRAW8yIXQE3YA7GLJcI5A2NPp3rSzxGWtGpwLrF4zTIkVAB6E5UU0ALr66x+wcxsA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Sb03gh/iMY2uKvBgVsP/wSAzFp2mZy/sY2v9vq9SOUB1/9uNnSWiY+fqZbDvWDnfomje9+cYCaCYtIVdJmnFppCE0cVI0A5jujPPPk1Xt6E4KjNHWr0BdCnttOrduU4ccm2QrjQuliWPxPBVzUgKwT/vviNH56c3d7vWpuTBnXd5Bt+5vjNIykVnsazUTNL2rLobckz+ewkfxR1k3K9R1sit671QJQl2dnEKEB9Wg3lDzuPeZx4AzZsF/ceMz8tS9DY20OfhzSjZWINVHnlrGpHCAoPrD4whsqKLiHeXg+jOvJVvfdCPpyNRWuBxy357aC09g0W7sWyBcXyN9h0eJ6ZiVv7PR5sfmRawXBH4fVpiQ3vmBRySKfYyYKOkusNFdctsHmi3qnLTSn2cJFDMPgA0J45TWw0SeyYXXfdUqQGIv0zEuerBK0L9TQbdPJaN0DOAE+3WtvFcsvxAPip5tJ5VZ5Zn+JBZx+dY327r5havHT9alASSlflgyFNNpvL6SYP5bkljIn6tkFsiBvCZ14QEmxPPA3IMkpWXPZmhUv5+8b6P9R315HoDGPIsQi3LjXJgyf4j74JYwr2rUJ0TXpjKMSnhfBIL/QetKAa5wALNvHxXLHeHfXnEgTGtnwHg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1e63f0-a19e-489b-3f23-08df4920a856
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 05:14:32.1017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1fc+jP4i3i7oj778liOoODnJjF/XMma/zBJcZfCKv6OxWlwM93RgMvTcDJuLM3ZlIwMsnSrg3zkWoI6PFqnVNpNDxIEbRijp08pKwcJpCAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7524
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=780e1cc66=Alistair.Francis@wdc.com;
 helo=esa1.hgst.iphmx.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gV2VkLCAyMDI2LTExLTA0IGF0IDIzOjQxICswODAwLCBCaW4gTWVuZyB3cm90ZToNCj4gRlU1
NDAgU29DIGhhcyBhIDJNaUIgTDIgY2FjaGUsIHNvIHRoZSBtYXhpbXVtIG1hcHBlZCBzaXplIG9m
DQo+IEwyTElNIHNob3VsZCBiZSBzZXQgdG8gMk1pQiB0b28uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBCaW4gTWVuZyA8YmluLm1lbmdAcHJvY2Vzc21pc3Npb24uY29tPg0KPiBUZXN0ZWQtYnk6IENv
bm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+IFJldmlld2VkLWJ5OiBE
YW5pZWwgSGVucmlxdWUgQmFyYm96YQ0KPiA8ZGFuaWVsLmJhcmJvemFAb3NzLnF1YWxjb21tLmNv
bT4NCg0KQWNrZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNv
bT4NCg0KQWxpc3RhaXINCg0KPiANCj4gLS0tDQo+IA0KPiAobm8gY2hhbmdlcyBzaW5jZSB2MykN
Cj4gDQo+IENoYW5nZXMgaW4gdjM6DQo+IC0gTmV3DQo+IA0KPiDCoGh3L3Jpc2N2L3NpZml2ZV91
LmMgfCAyICstDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvcmlzY3Yvc2lmaXZlX3UuYyBiL2h3L3Jpc2N2L3Np
Zml2ZV91LmMNCj4gaW5kZXggYjdkNWU3YjRkYS4uMWFjMGQxYmJkOSAxMDA2NDQNCj4gLS0tIGEv
aHcvcmlzY3Yvc2lmaXZlX3UuYw0KPiArKysgYi9ody9yaXNjdi9zaWZpdmVfdS5jDQo+IEBAIC03
Miw3ICs3Miw3IEBAIHN0YXRpYyBjb25zdCBNZW1NYXBFbnRyeSBzaWZpdmVfdV9tZW1tYXBbXSA9
IHsNCj4gwqDCoMKgwqAgW1NJRklWRV9VX0RFVl9DTElOVF0gPcKgwqDCoCB7wqAgMHgyMDAwMDAw
LMKgwqDCoCAweDEwMDAwIH0sDQo+IMKgwqDCoMKgIFtTSUZJVkVfVV9ERVZfTDJDQ10gPcKgwqDC
oMKgIHvCoCAweDIwMTAwMDAswqDCoMKgwqAgMHgxMDAwIH0sDQo+IMKgwqDCoMKgIFtTSUZJVkVf
VV9ERVZfUERNQV0gPcKgwqDCoMKgIHvCoCAweDMwMDAwMDAswqDCoCAweDEwMDAwMCB9LA0KPiAt
wqDCoMKgIFtTSUZJVkVfVV9ERVZfTDJMSU1dID3CoMKgwqAge8KgIDB4ODAwMDAwMCzCoCAweDIw
MDAwMDAgfSwNCj4gK8KgwqDCoCBbU0lGSVZFX1VfREVWX0wyTElNXSA9wqDCoMKgIHvCoCAweDgw
MDAwMDAswqDCoCAweDIwMDAwMCB9LA0KPiDCoMKgwqDCoCBbU0lGSVZFX1VfREVWX1BMSUNdID3C
oMKgwqDCoCB7wqAgMHhjMDAwMDAwLMKgIDB4NDAwMDAwMCB9LA0KPiDCoMKgwqDCoCBbU0lGSVZF
X1VfREVWX1BSQ0ldID3CoMKgwqDCoCB7IDB4MTAwMDAwMDAswqDCoMKgwqAgMHgxMDAwIH0sDQo+
IMKgwqDCoMKgIFtTSUZJVkVfVV9ERVZfVUFSVDBdID3CoMKgwqAgeyAweDEwMDEwMDAwLMKgwqDC
oMKgIDB4MTAwMCB9LA0K

