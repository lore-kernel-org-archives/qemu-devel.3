Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FC4606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 04:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=G2ut+yuB;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=p/kLbTBj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJkDx-0007BI-1o; Thu, 22 Oct 2026 00:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJkDv-0007B2-05; Thu, 22 Oct 2026 00:16:15 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJkDt-0007YK-3a; Thu, 22 Oct 2026 00:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792642573; x=1824178573;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=X/8A+cN1Sp9zTaU79AfCBSncIso0NxeDyPttmRtKwxA=;
 b=G2ut+yuBNEmYMTBF9+G0/66pn1JzYgRYFHh3tczkwcqADpQcZRId6xFa
 ohh5l53aBQAAAyXyZU+3GjOJVelUc0Y/IOKe8Q9/AufFUpSpij275KJde
 sjz3HQ1mZEKUImot9oYuqcGNQ93nE1XyykBJ6HMFL6TrLyADl66GYA4Ef
 IzRfEdZDST9GV1bk3V0r0iUM/nU7uspJTHYeKrowdTnBJUk6xTcaZg86I
 i5suA8xqhM0gE7ZO1tbb7hwxe1j9d392CxrBYJ0x/8BuYioaNxgwcfxdT
 iNmnNpJItaBrKHgS9Z8YhGNhakOKPeSK7pbBR2JSW1fifkHLZMKw9rMz/ g==;
X-CSE-ConnectionGUID: tVzQFVcXTXyPPR6Q00bBpw==
X-CSE-MsgGUID: su11XhUhRkGep14MsYNoyg==
X-IronPort-AV: E=Sophos;i="6.27,171,1786982400"; d="scan'208";a="157743107"
Received: from mail-southcentralusazon11011067.outbound.protection.outlook.com
 (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.67])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Oct 2026 12:16:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liiobWQyA/NOmfdRD/sfPXvF9G+oTWy/YKm0yNTL4tXt0wFpuicWcmyeKmqLVBOs+7pBP73LR8WXF23EG34RYhRZ7sYyXDC1YEDpNyHK9dUW505/D0Mx2BSf2rvYjLdYuOoYAe1nFBiZ3x1sevKaFHnBfv9DVVrBANkiiTbNmjNKsZi0Kr2aY6fmXHV6SO5Wge4YOhjgjXALsKCX1aGfGTwfx7dS3mXfxcQPNFTBx2FN/YQr1WtQQ5gfSQ6XspiDe1OU1FPbZ8JGeltP1z7/Dxy/wIXl/mMymQ+2sn5LVCaPe0KLrrlK8DDI2yVgurARfSnX4s6X/GGKs4v3MM/0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/8A+cN1Sp9zTaU79AfCBSncIso0NxeDyPttmRtKwxA=;
 b=euqPgEPFwaTUGKWGmnx7Qa5GJpgtOY1vQJKUhgHYmkKrjV2OO84i6fxzly02sIy2Zz4gOwGXdBjVLPNFWyF+nhVqpR53MNwssTN0A1gSak0XAUO7ozKMwwYTrm3MVgrRlVd1bSaTCBtT3Dtge7ejAS4lzT1Chtns4aV4TeqWEp/C+zwyP+CxifJsUYM/UrTpFBPse2ts72Owe9jF8nIzYFpT9obxLDSc7Dd07YkEx0wudkXu3vef07wb93Ni377xUG4uBzCpf23+CO7mU42l9QcR2CV//zbLkpsoR48CiTVpKiC7b5sWS+/07KtK4ZlyHLY1XSTXd14/RQ33lh6nhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/8A+cN1Sp9zTaU79AfCBSncIso0NxeDyPttmRtKwxA=;
 b=p/kLbTBjN8zVG5zcH98DKsb7JfPqo4LH/iBLvOWdaxG4yZFGyOiqiPCSrs7aWqCY06rrIMkgS7CZu96YF6xh5Y427gC3ZMDcRBeyR+tRlR7kBKam8Z0h7mrhX1wOL3GMVSbq7s8ghuwQe8x4mB9Y4VNpuU/KVfnOzMl+JSKiVeQ=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by MW6PR04MB8916.namprd04.prod.outlook.com (2603:10b6:303:246::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 04:16:07 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 04:16:07 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "sebasjosue84@gmail.com" <sebasjosue84@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v3 1/2] target/riscv: pmp: clear A and L on every
 implemented PMP entry at reset
Thread-Topic: [PATCH v3 1/2] target/riscv: pmp: clear A and L on every
 implemented PMP entry at reset
Thread-Index: AQHdYdpGN/cVIeETXESs0WiuYJjcDLcI9GkA
Date: Thu, 22 Oct 2026 04:16:07 +0000
Message-ID: <8ef60815c8e34aff906f12d0793a0b91873063b7.camel@wdc.com>
References: <20261022040258.1509306-1-sebasjosue84@gmail.com>
 <20261022040258.1509306-2-sebasjosue84@gmail.com>
In-Reply-To: <20261022040258.1509306-2-sebasjosue84@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|MW6PR04MB8916:EE_
x-ms-office365-filtering-correlation-id: bb2d03b6-b6a9-4cbf-5875-08df2ff331f6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|10070799003|376014|19092799006|366016|261021121427099003|38070700021|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|261021123027099003|6133799003;
x-microsoft-antispam-message-info: gnrwfaa4cbt4FKSv+KzXKN5Kw5GVgrtoR9CMs95rFEAuMQcFwIsmfPSu4c0bCxSxy1Q4ok3rjCz9+OOV/hPXqP6rA0jEILPLJcZwqUm69702RMg8ajEdMOuQfXVf9rFcyVko62/HcMtCE5LGklZmlgXvLqkPi7Mi6Y1tHSBTvRHLT0vH3OhFzPziaE+YZpCaWI2EyE66noG/PdOQOmBC8CGcj+TEgpj8PNrHxp668JiSQkw+seS4uFCk+sgQQKgkCZJ8MU4gy5Q0bt6xXuqlWpy/B9KHxQLUIsbYj6hhOQKKqYMZm3UZYOyy06y4T2SRFmx6Iycma+UP6uNolYapA7yF8276XXhi4XiCLLbMtpdrOimqil6RqUss6Xc5P7AmernF0KtmGRq7EhE7Ka8qgoS3+MtsftiZGgKxYjvdQz1R8Rb5FfLAIdLiWvJ2zk05iul6zwO3WKcdTa6K0NcXFJHqXPyxnMP0/x8xl6YOWfKb9ODQu8Z1rFiL8J4CC0HFAZQV4Jpd5SC/N1DpgHNA0vKwrZn4HDf7Oh6ClgnWlyALAQb9Q7WNHhWSiCzNlMAPlXvJfkaJD5HZsve40YOyoP7rEFGCGvM7VLcVatwl2Uis/YhbctmDjVcfsQbf1WQ8PxfrfXS9+xabdmbw8gW28huAzUk+NNdEyrKXSJAibljesbza0QfbYi7Q5N2geXQBHvxgLjhjPunmalutNaX1w1f5n+OdAI1NhJJvxN6SU04=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(10070799003)(376014)(19092799006)(366016)(261021121427099003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(261021123027099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0MzL3ZtdmRVcmFqTU16dC9UMjhoRkRqQmxqU3k1YkdvR1ZqaWFMWitJRkxQ?=
 =?utf-8?B?a2h4b212VUg3OXorMDhFeWlZTCtDanZhOWo4aHY0akN6WXZyMXR6QnZHSmJs?=
 =?utf-8?B?bVZWTTQ5eWZVZDBJRTVYK3RodTFxVGRxWkNNUnFTa052R1VacElZaXVMdVpo?=
 =?utf-8?B?MDBuTWVwWDFLZGRhdVQvaG15VFVxclRwM0tWY2ZUNHdxd3YvZU4yenBVK3pG?=
 =?utf-8?B?NGR0S0ZYNHJFbHhIMjZldzRtOWVvZjk0blZaM1RaZitZdDNaQkxuQ3BKNS9D?=
 =?utf-8?B?RDlTcEZaelhTaCt2V1VLUlU3MWFrTGZuL1h6WGFLYStLaUZpNVNqVFM3bkU5?=
 =?utf-8?B?ZklhS2tvMXBiNUgzbDBBYkZMRWdIaTlpSXMxY3o3dEZ1blhEeDc5ME9JNFVB?=
 =?utf-8?B?dGtqZXBTeG01bEdTc1dkN2hGeElPR05QUmUxVzJKdXFkQ3ZIY3lSN1RoWHZT?=
 =?utf-8?B?Z1owd2l2N3lRWEQrR1NRNXY3SjBzcG1jcVJaZ2VUc2QzRXladVF1ZnhEUmJu?=
 =?utf-8?B?emlaREc3QUU5NUdIQVNGM1ZHSCszZXpLeXROSFZzZmx1dTB0TmhJZXNXOE02?=
 =?utf-8?B?Mk5jWkNnZmlmMUxuWlI0c05EV0h1aXJYc0JKc2txMzFZOEc2YTgraTF6ZFdm?=
 =?utf-8?B?NXFtUHpFdmJJWUJCdTl1Wldrem1OdjhUTzIwb0xick95dkU5dENlYkhGRVo1?=
 =?utf-8?B?cTZDVkNuWm9LV0ZBeE1FNTBUNGxYT1JHUzErcTFWVzA3RlN3a2Nlb0k1Wmsx?=
 =?utf-8?B?UGRCQVdGWStXRnhDaXRkcFVSVGJzdUc5dzdtS1dndVZmb2VQem53RzlpZnFr?=
 =?utf-8?B?WjVieUhKUndRUlNjbHhBalpXdkxOT2dscEIrSDF3OVM2cTYxaXFnVWo4Ym5M?=
 =?utf-8?B?b3ZFd3g3UkN4cFJ1NEJKeEVXcWtnTXU0bFZLY25UNDVKUnlKMnJES1Q0T1NZ?=
 =?utf-8?B?Qmt5eEY3YlI0NGZsVVlSSm5XT1h6emphK3RGZXhsMldnbVdZUGZrQllDOG5G?=
 =?utf-8?B?RnJrL0xOL1E5MHltTEZpTkFUeGtva3VWMnpYeGNqY3VVY1paVTQwM2VUSW84?=
 =?utf-8?B?czlZSFlvdEVHYTIwQjl2Sm94VVM4aEJVOFBrbmd0M3A5RWZ1TkJlZTU4ZE5T?=
 =?utf-8?B?eG1MS3ZwSEY5VlYvTGE5V25MOTltNUNIVS9QVmVZQ2c1UGZjcURYditkQWho?=
 =?utf-8?B?Y2JOMnBWZ0ZHczRiZFgyMUo1RUVMV2ZpNjlzRHZuV2RWRmdnYVJCZDQ4K2FV?=
 =?utf-8?B?bGthU3RXVDNITHd5SnlXS05OY1YvWDFZdmgwMVFCd2pUdG1TS3hzN281MENV?=
 =?utf-8?B?QkNnRFN4Y2lQZVdIdGNSazlEMXdYOElsUTdoT1NQdFlWbEVveVBpclB2OWpJ?=
 =?utf-8?B?U3J5bGx1Z0haNG42VnYramdvWlpoS0l2VWF0RHljcDJvTUFkSTl2cnNVVHZY?=
 =?utf-8?B?Z2JWaEw0K3BTbUc4eXkyOG9xK1BBYWJJbU5wbDFTcmUrYVJCVnFOTlJYRHlQ?=
 =?utf-8?B?N3pxbGZ2ejVzMkFRVzh4SEVZMTFRbjdGM2V1blRibzFvYUJJSmxSTjl5MjRQ?=
 =?utf-8?B?aUI4NjZETzUybEpqa0lVM203cVhwQ3UxOGd1MU1LeEFmeDBvSjNmZnMyZE9q?=
 =?utf-8?B?bHNDRWN4R2xFTGdNdkJLMzdSdVZ6dVJXdnl3Wm9keGlQS1k2SE55aUZuZW9j?=
 =?utf-8?B?WGhXTVJDdUQxTFV2MWVwUlFtemx6QkU1dEJwZ09IRFJlQ2RnQ29DbDhiTXBh?=
 =?utf-8?B?VlRXWmg1RjVleHQzSWhsdnk5cS83YXIyY2ozZDJzckdTQy8rbEJyVWdaT2tR?=
 =?utf-8?B?NEFFOUpjV2hVb0I0R0dBeFNERFJvTytWM3VXOW1IMVI2cXM0VE9jcGVob2Er?=
 =?utf-8?B?cHRKVmZ1Q2dtNWc4T2lXUHk5WkwzbWtEd0l1Q0l4cWx6WGNCZm96UzhpZDVR?=
 =?utf-8?B?cEFNQmFxNk5xZ2o4RGtyZThqSkNIbmNDYmRuRDBQQzI4ckRlcUloUGs0SnBX?=
 =?utf-8?B?TTJFUDBsQVZ2NTd6c3k0MXFpQXozdFhMN0RSRXdTY2NMaENOVE5VVHJEZGdp?=
 =?utf-8?B?L1ZOL0lFTHVqQTJIbXlLM1RQck9JYXBHNUpsUm5lelRvcFBFSldpTDZFSHhC?=
 =?utf-8?B?b292MU40Z0ppMXlTckd4Nmlsa0kvUFNFajFvcndyOUd0Q2RLUDA3K2I0Sk9R?=
 =?utf-8?B?VVU1VjZPYlVIOXB6dmlnVDJBSjhkVUVubG54TWhwWFpodGw5Vno0U0JUcDRh?=
 =?utf-8?B?MzVKZjNmd2VXQmc4YUJHczY1ZFozQXA5WWxhYXJFZEk1Rk44bFRjZTdaSUk4?=
 =?utf-8?B?dS9sTm5XUjBCdUhZSU1WTGNidmJhWUhUdWxaMlcvd2JYWWZOZmtRT0h4aUsr?=
 =?utf-8?Q?9tXAQChEchGyTFpzTQTN0Kjrl+1KMhhhbX0YL5SHv90Bq?=
x-ms-exchange-antispam-messagedata-1: slLMcDf8Kd2Tdz4LEYKTPofMI8j6r2w1jrw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B7066ABCB6F4C408896C1F52E2A4D41@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 5JarEWfM+vSsgUIwuBaQBvvhJpLaaaeyRQLtE4/SYxITgIZ3tGkIhYeI1m8Z+Hpg4IBkcVv2gdiCQSM3obprhR6NIaVR/iR41nb1tF6wUs4nZ48itFhouXcJeav3ZT0LbW1xoa7pCJ8uIxaI5QPbn1QARVbPgt/k0//xNLrnWMaF9fFwT7k11RvLSDeeQ0DfkRsz0zL4hqgNGzsxntmbVod2zqkhko+kuvw5Sk1zTpmN4mxCaxlVunW+x5DUZnxKI9baByHskuQuFOTqKFX2sNZrjHGEzSiXFOfQCEyBtAOsaT+L25/eQ4zGswCSevdSy5Y93nFWg0b3SHpA1SWP6A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fKaxRo7FPeoZbZ2JciJxm7BRFQ/7VRGpIoYMkT/g0HN6OtT4yexneR62F+b93C1Qw3lxjIlcRPySDJY6X6bnRB+zjtfbkLhGSdcxD1Yn1aJocLD8Zg9EBKRaZxgmxf52hFPeioUA4HUfu3SmwuBqUDXTlVzWTUswTelQsdnc+HQUQ3n3yg2bpNr69f6WL4S2kCnkoSPZ8KRKYXRnKJQryPaKeg2YE/rDV/PyzyIRWjC5r0iP3xAfOzpMaY399voRYtMuOONmaGlyLs2PCmhHsBR60MlevLRe2AkFd0Zhsiv5gRK29g1yyYGTQDOjjDeksuFeFWbhXMtgC0mpvFJVP48af7Okr6mhwRA/ldyfRUzg/tP3U2gqpkqfFs9e2MqK8hT9MOLFuM8XbIEC7Z2V8fb3bzVZbZd3pYHYM4GYVp7P1aLvlc3KK3tdFAO/ZwNdF7I5VhgtF4eGfgWOii10Qf3TA6ClHAhF4C2xQMf8JAUo6N39SkreRtDEFc0A/C8Hyu+VEtCoxNGm3AbmNDr9D58dcS4BvdmEBptPcY40hY6lluUWyIJIBwwU/hZSsH12a6e4PCzX+jc3UT0joERdLQYHwdOdxZzyjQ1Ao/3+Zm6c51dgIhpXSdJY/QurcZoh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2d03b6-b6a9-4cbf-5875-08df2ff331f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 04:16:07.1071 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M3RjXkJWSEiMVDLWDzY4pnsoSlntj+9yG538U4S+NEtTAxXOT5/B0ba1j1n7Ge/vq0u3stGEbOCPK+ibLUhemM63Lci4yHBBhoR8zfQyQVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB8916
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=748e7da1e=Alistair.Francis@wdc.com;
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

T24gV2VkLCAyMDI2LTEwLTIxIGF0IDIyOjAyIC0wNjAwLCBTZWJhc3RpYW4gQWxiYSBWaXZlcyB3
cm90ZToNCj4gcG1wX3VubG9ja19lbnRyaWVzKCkgYm91bmRzIGl0cyBsb29wIHdpdGggcG1wX2dl
dF9udW1fcnVsZXMoKSwgd2hpY2gNCj4gcmV0dXJucyB0aGUgbnVtYmVyIG9mIGVudHJpZXMgd2hv
c2UgQSBmaWVsZCBpcyBub3QgT0ZGIHJhdGhlciB0aGFuDQo+IHRoZQ0KPiBudW1iZXIgb2YgaW1w
bGVtZW50ZWQgZW50cmllcy4gV2l0aCBhIHNwYXJzZSBjb25maWd1cmF0aW9uIHRoZSBsb29wDQo+
IHN0b3BzIGVhcmx5OiB3aXRoIGVudHJpZXMgMCBhbmQgMSBPRkYgYW5kIGVudHJpZXMgMiBhbmQg
MyBsb2NrZWQsDQo+IG51bV9ydWxlcyBpcyAyLCB0aGUgbG9vcCBjb3ZlcnMgaSA9IDAgYW5kIGkg
PSAxLCBhbmQgZW50cmllcyAyIGFuZCAzDQo+IGtlZXAgdGhlaXIgbG9jayBhbmQgYWRkcmVzcy1t
YXRjaCBiaXRzIGFjcm9zcyByZXNldC4NCj4gDQo+IHJpc2N2X2NwdV9yZXNldF9ob2xkKCkgY2xl
YXJzIG1zZWNjZmcsIGFuZCB3aXRoIGl0IFJMQiwgYmVmb3JlDQo+IGNhbGxpbmcNCj4gdGhpcywg
c28gcG1wX2lzX3JlYWRvbmx5KCkgdGhlbiBzaWxlbnRseSBkaXNjYXJkcyBldmVyeSBzdWJzZXF1
ZW50DQo+IHBtcGNmZyB3cml0ZSB0byB0aG9zZSBlbnRyaWVzLiBUaGUgc3RhbGUgcnVsZXMgc3Vy
dml2ZSBmb3IgdGhlDQo+IGxpZmV0aW1lIG9mIHRoZSBtYWNoaW5lLg0KPiANCj4gQm91bmQgdGhl
IGxvb3AgYnkgdGhlIG51bWJlciBvZiBpbXBsZW1lbnRlZCByZWdpb25zIGluc3RlYWQuDQo+IA0K
PiBGaXhlczogNGJmNTAxZGMwMTE4ICgidGFyZ2V0L3Jpc2N2OiBwbXA6IENsZWFyIHBtcC9zbWVw
bXAgYml0cyBvbg0KPiByZXNldCIpDQo+IFNpZ25lZC1vZmYtYnk6IFNlYmFzdGlhbiBBbGJhIFZp
dmVzIDxzZWJhc2pvc3VlODRAZ21haWwuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJh
bmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDC
oHRhcmdldC9yaXNjdi90Y2cvcG1wLmMgfCAyICstDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2
L3RjZy9wbXAuYyBiL3RhcmdldC9yaXNjdi90Y2cvcG1wLmMNCj4gaW5kZXggNDFiNTU1MTlhOC4u
MDYxZjBlMDc4ZCAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L3RjZy9wbXAuYw0KPiArKysg
Yi90YXJnZXQvcmlzY3YvdGNnL3BtcC5jDQo+IEBAIC0yMDEsNyArMjAxLDcgQEAgc3RhdGljIGJv
b2wgcG1wX3dyaXRlX2NmZyhDUFVSSVNDVlN0YXRlICplbnYsDQo+IHVpbnQzMl90IHBtcF9pbmRl
eCwgdWludDhfdCB2YWwpDQo+IMKgDQo+IMKgdm9pZCBwbXBfdW5sb2NrX2VudHJpZXMoQ1BVUklT
Q1ZTdGF0ZSAqZW52KQ0KPiDCoHsNCj4gLcKgwqDCoCB1aW50MzJfdCBwbXBfbnVtID0gcG1wX2dl
dF9udW1fcnVsZXMoZW52KTsNCj4gK8KgwqDCoCB1aW50MzJfdCBwbXBfbnVtID0gcmlzY3ZfY3B1
X2NmZyhlbnYpLT5wbXBfcmVnaW9uczsNCj4gwqDCoMKgwqAgaW50IGk7DQo+IMKgDQo+IMKgwqDC
oMKgIGZvciAoaSA9IDA7IGkgPCBwbXBfbnVtOyBpKyspIHsNCg==

