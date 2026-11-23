Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED476606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 03:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=T9q+4jh1;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=j4bbgwQA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVL80-0007eF-6A; Sun, 22 Nov 2026 22:54:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVL7i-0007dC-7m; Sun, 22 Nov 2026 22:53:46 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVL7e-0001OL-FF; Sun, 22 Nov 2026 22:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795406022; x=1826942022;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=AVz2aH7mzAjDOJsdPv+ZkSdVLxmEJjEk/o+XfwAQmVk=;
 b=T9q+4jh1jpLlS1FI2UPBHm7lKUkeDEiB3XY2KZIIB14xTrVwGW410y6c
 e1dTyvl7FBPddGlr+4F213ulH1AR6Gp+RxVXUwCxw/+S+5v0t8Q/SZtN3
 RmB3Z0rp59196Pkr0KJ1leF4UZjznYSfq0x81eyBWX6gkGgp9w/4AHun8
 7mcaxC/7s1IGANjEnc2/wyuiRr/yjjSJGn5JfMSFEjD7Qr5wtOb9yPfDN
 t0iK8A5U5n/he3Flsy0xPhPCGcT4A4iQhOjxMg8pN72oNfgvoQiLflwL9
 fJRSCnVLnmHfgXADZpYWBoAta+kQcuASpomjS4muH981JedOldbeUhV0v Q==;
X-CSE-ConnectionGUID: mY+fX3lrQRWUnTbIQzZHWA==
X-CSE-MsgGUID: 1IUovxP5RBiy3uIyD2EHiQ==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; d="scan'208";a="160556179"
Received: from mail-northcentralusazon11013013.outbound.protection.outlook.com
 (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.13])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Nov 2026 11:53:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKylKll8tB+xFoPdjA5jM96OohlApuV4Diu//K6bIWjtkHIsMYgsrmFlkyWHaF2CjrmKyOrfm8vS7tGIxyMgXAF1L5BZFrwA7qQw6/KzJrSU+Tx8xTnKsvOpFFEr3uGLpPY7T0HDcEWlvEyibCDFEq7Zkeqg+9QyYYN8ljcB0UeqoetGR3Wk0gmjDc1igjSy4//6BlLnITSOwzMpaoEszOsxRJ9celhv/qJ18+YRbzNCRERadiSl7p0ohTAO6ZnaCatyYYFC1GVEIPYKkgagPyKUJYHsUI67dHArNCTZTKKVeiAKDk6IuR6/hm+jBs4zpZFhSOcWPOG4jgGNex61cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVz2aH7mzAjDOJsdPv+ZkSdVLxmEJjEk/o+XfwAQmVk=;
 b=u65VGyabw2NJbH80yTN0U4d8wsMySWcDr0BseamGOYHFxmBml2UcBko46LaPIGqXi8OnXliazUFo4VpnDRexMBgTGS41MujXz/fMFUuWJ7XEpSheYHC+n94BZO7pMbR8u4sW6D8sNXP5MX0jUp/2t2NK7sqWwaL8ZGHxrrmH85twioodCbYq07fRCKCcbMcZnGueBz50P+r++PZgi+6aUBeRwhOrbsbpYFx5+lm0lYty/g4LWnWcz0oPyfIxWgTwXX4QyjT/RMyo2QaiqQ+py4sDQF495Y6vnYLRkQ02RLeL/g5B+NE71+w/h6AJtPdfBZGgw6IVG9Y1966UBRGFNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVz2aH7mzAjDOJsdPv+ZkSdVLxmEJjEk/o+XfwAQmVk=;
 b=j4bbgwQAH7sWlNOFZYEOoaBBgx5LgbpoJeT4Wh7b75NB223+I1RuCoTFVlLwYPUEGzTsVAMjIigbgs/sc5rJo3kBurKuQCE6DXd9R7cPzLFSp4BTVHeJjqxQrDOcQNWuHqVTZCghEMjWOs8l5mlXXGt8iq0lkvyjWSgX5ruO1Vc=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by DS2PR04MB993728.namprd04.prod.outlook.com (2603:10b6:8:337::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 03:53:35 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 03:53:35 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "b8da8748-a668-4481-b483-66f333a0614b@oss.qualcomm.com"
 <b8da8748-a668-4481-b483-66f333a0614b@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-security@nongnu.org" <qemu-security@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "cosmos.xu@synclite.com" <cosmos.xu@synclite.com>, "antikostya2@gmail.com"
 <antikostya2@gmail.com>
Subject: Re: [PATCH v2] target/riscv: add support for the hcontext CSR
Thread-Topic: [PATCH v2] target/riscv: add support for the hcontext CSR
Thread-Index: AQHdeNhQhsWmOXAAGkCGT+xcUTJTxbc7CrsA
Date: Mon, 23 Nov 2026 03:53:35 +0000
Message-ID: <f2dc9c97ae4b194ce944a87fd3d6425f35eb20ba.camel@wdc.com>
References: <> <335b83ef-aec7-4345-a95c-6eb669d48a66@outlook.com>
In-Reply-To: <335b83ef-aec7-4345-a95c-6eb669d48a66@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|DS2PR04MB993728:EE_
x-ms-office365-filtering-correlation-id: ee54230e-f66c-4f33-bed4-08df49155958
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|10070799003|1800799024|366016|376014|7416014|261026140227099003|261026121527099003|261102123227099003|261022105027099003|261028144727099003|261021121427099003|38070700021|11063799006|4143699003|10067099003|56012099006|18092099006|10086099003|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info: nxFWvQU4rWNqXOzvrmZ929mKWgzuKVZqIGUa+AjAK2gpPCGAY/K/2doWSdQNtVv4UaHJnDMcBAFAMPuhtfcKI+QKJYxhmZjdYVI09z9RlVdYMPJpzGS7niFoGsMSTBWdhELtKV6olLr0bytp2Dj9oSrfRryBPNamMubrJVkmQOtvrtGQdkqn9GNs9MZe1jnv6RvO98b5ziMqApnHQ3KrF6GclR/q3c7Qq8x1UqeOky2k/4EYfAa/umVk8HgrPJ0vxo/rZzfkYXQLDCof3YuhDmfuknPfA8DGShXNbj5+Ts3RHQFBJT0/uOw51jMGgJc4KSRM3BqDr1vYg23KOa4BLvl5/ZhsrG78lNpzT1M5pED7IxOmMkr8vy/Hk0eKJ0+ad5y9d8DfufVoFjlALUYR/+a4tch/8mecwYLdcLRPsmBWuasKjegQAg/jBVlDT7BcjL//tpGlkaWauyj8YBdb3MLngXVRLocP0tBxEi5lhzdMgcCUMTMZ7gRFFi0yFAL0tNWP6V4cX/EgqSsnYYenhT+pkOANButwePzbw7a73GcndXjIqgr7LgWcY7204bsiCmM2muTyk8Nj/GnhAnRC7v3fg3p/cBNUq7sWOeQUnxWoDTbxreZB1gQAFg9SNWtx1/0ehqRH3ygki+fcoDZKGDMF2mVFFbv+R7JieaObIgz+/6nDm6qLYoo7qc3YgzUSIrbCkklYzvG/2o04EMQH9gk32v7BukSt+0uagqp0k+U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(261026140227099003)(261026121527099003)(261102123227099003)(261022105027099003)(261028144727099003)(261021121427099003)(38070700021)(11063799006)(4143699003)(10067099003)(56012099006)(18092099006)(10086099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Umt5YjRTN09NcEdpQ2Z2WGdiNWo4eDU3NXJwZFR2bU5JZlYvcnM0RTEwQXpq?=
 =?utf-8?B?RG44ZFV0eVU5YjNldkRQbTRSUnNpWUJWL0pRTzVxdjJ2NkwvNXZmRzJTZlpz?=
 =?utf-8?B?WElSZGlJOWNRZ1lsVEdaUEg3ditQNlVzOUNMM2JZckQ2VnI2UW1veGwwaGNH?=
 =?utf-8?B?Ym1qa3FOckpZbnVwVi9ESGZTZE5mVVV6TlVkbWpJOXRnNGFRdHFsQ0pOM0Zz?=
 =?utf-8?B?b0lmaHNiejM5Q1pkbHNXUjlvZTJMcXorNHVJamRCMXR6dnpJV3VYUlJVNnZv?=
 =?utf-8?B?RDNzcno1MVdiNXhjY3JGRmhxYlJ4VG1rVWdhSlRtWXdvZjBSZ2ZFcG82cnAy?=
 =?utf-8?B?dHNDbzJ2NFY3em8wVitMVFlpQkd6VGFCMUQ3cEplNFZ4SVlGWUUxMERnYk9Z?=
 =?utf-8?B?TWt6Nk8zK2xyMmpZdkkwbE9qUnR0dE4rdW84MzZhRDNzSklrQlF6MEJqZFVv?=
 =?utf-8?B?VHM5VzFaSnRjR1N0SWl2UXgxZFpKU2t5dUJmRnlsM0ZnaU9UTmZIaFVUelFG?=
 =?utf-8?B?amNycEh4ZUJWSTNtMERHMGlkakR6SnNFWHAwaWVhaCtRWWdiY25DVDZRbUo2?=
 =?utf-8?B?TS8xZWlMQ0lIbEdNaHNqK0U2a0lNcE0xeGFUczJsMkUwbFcvQnlGQUZoRVQ0?=
 =?utf-8?B?eDVQS1ZWZjg0QStPR0doVC9aUXEzd0V3aTJNWVdEOHBLbTdGSlhtQzFwelh3?=
 =?utf-8?B?Unc0bjc5anNpTyt6bHVyU0dQaXdldnFsaEpVUDUwcjFNUWdsWENDd3c2VFZD?=
 =?utf-8?B?aFBWMnlCUmxKdFBaVCtWcUVUU1dKenpzOEZDZ2RuN2gyZHNJc3BUaVhFenNn?=
 =?utf-8?B?N3A3Vlo5TnBVc2VHNjRIOXY1enBaTy9Dd1dUNDJCSFN0MmN6bVRldW9CaGdO?=
 =?utf-8?B?QzBtQWdGQnZZZmRwYXVRQVNHUkhhUjlZNXhmVEVKbEhrYldOY2dqNzE3a1Yv?=
 =?utf-8?B?VXBINXpWSzhrUW5DeUVTY3VsaHExRjdzdkVkaFBMK284cTFGSG1ibms3WEhC?=
 =?utf-8?B?QkNhZGhSTlJ4RmV1NUloUDBOSzJzOVB5amFhQzJBczRvaHE5TFBVN3lHdmp0?=
 =?utf-8?B?ZnloYUVRZjB1dElqUyttZGJCSnlncHM5L1Vpb1dDT21tNVNzSURuZDJNMVgy?=
 =?utf-8?B?M1I2K041dm51QUtyZHU1UnNRdEliWEc5VHJKUXhDTXNVcUNYTWJhUzQyZE1l?=
 =?utf-8?B?N3gwVVdRWnZiY3FNY3VQZkdVN3lRczVFc1kxbUNqZUNQbk9KNG82Z1FIYTIz?=
 =?utf-8?B?Mlc5SXdqWUxwanpKMWRzejR3T1M3ajQxYWdNalM0QldpR0QyeHFxWkYyL2pL?=
 =?utf-8?B?QkdsN0plU1Raa3JjMVJQSUZWM1BVSFpkVWZmV2VjVmdwMTc4RWpmcXhnRWw3?=
 =?utf-8?B?SjJYT0VzRVUzSnVUWms4aTVtRUlVbjBJSXk3V0JWUHIyZ1dsTkdIdUMzUzN3?=
 =?utf-8?B?cVk3cXVzdk5ZcVpxdm5TUDVaWHozRmNqaklYa0Z5ellBbzJUbVVGRHlZRUtU?=
 =?utf-8?B?ZE4reGlYZkJmemhWWjRCbDNCN2xjTzVKdklaZTg2dlN5YWR3NURzQUtMQmJC?=
 =?utf-8?B?Y0hoWE5kTksxY3hKNkRZOHpzQlJoTHcyQ2NZQTNtMkpIaEFmV3djNkM1cTIy?=
 =?utf-8?B?a05YbDZCd0RXODdMVmRoZThRQmEyNmpIZFkrSDBhREJFT25ERjNQOSthOVNO?=
 =?utf-8?B?VURIRFNaQkxCZ3BJNDBXZVFKbzhjNmpmS0xjeVY3T0xPRGhKUEkzV0kzbjV6?=
 =?utf-8?B?ZG1zSHRIeXRtQTcwSWlwV28wajh5V0VlZE1YYU0rZURkSC9Oam14b3NGcHdu?=
 =?utf-8?B?TmJia1NGZ2JFUysrQUZEQ3FCaHZZalZmWWZ2QURQMEg4SkJkTTRrb3FPUzBP?=
 =?utf-8?B?QnpRdWF6cFhQVFdyUXNmQmNaNnM4R05UbVNBUGsvejIvUDgwM1R0YzhsR2VM?=
 =?utf-8?B?NzZ6dCtJQ0xIWDJoNFJwcEh0d3Rtbzl4eXBJSFpZQzdYaWZwMGpyUXpGc1Ax?=
 =?utf-8?B?ZEVMVXlDT3AxNHE0Mys1cCtEMkNZNTVFM3BZbjJVTUQyYURZeCtSOVlXNGJE?=
 =?utf-8?B?ODVwZzFKWDZiVWkzakNFRnZpRjMzVVcrK0NHTlBsYTFHOXpMQmtDdHJscWl6?=
 =?utf-8?B?UkM1a2thakt6bCtINVNJbTQxVWhSRWQ5V3JPSllHOWNrODBycGcrNnpLWmxa?=
 =?utf-8?B?dnpRc2VTdVRkQnNxS256ZEg2WkRXSjlpVTNMSnpDTE44RVVDckxrUFhzTHpz?=
 =?utf-8?B?NGR1U3lXbG4rVVZmdXlyejNPRlFKNXl6QjNpcEl0RkFEQjk2czluWS85M1Iz?=
 =?utf-8?B?UU8wWklUV0xnbmlJZ1FVbzVMRkdhUC9VUHNtNlVWOUJOWlZ3R0Z2QnRKek1R?=
 =?utf-8?Q?KoAwVK/agITurQRzzGmvOLhQetlcFaYOR/yLuSbq+XpCZ?=
x-ms-exchange-antispam-messagedata-1: KObNkOS2RKT+x355JZWzLc+jC9kvL5r4Y2o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7A703D96B9DB84AAA9858975A720541@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Z8EBt6Bw4UicnrtfIpaFR51wKFFIWdQcZHHRqHjICt+Y6r/AsMNWV65EOHXnqXLqpW3T8C/PV8aAQ5POtD/L05arNFYKGDCJSjpI4udtTGQtxzlMWPUzvCBVis6hrUlWMV2fbY5jMUuJwU04GHJdrUCxVt5ZR8L+UlarnGRq+DGoEh8A1p7BQqulwKjSdgFDSU2D6J0LppVtikUe+FyBqCi8/rdyJvOpWA9tVdy2oFCv4R6r97+cwnwlzMQv4bB74h/Fsw958rVwHsO1hI3QD4Uwc1ukPfCoklsSqloYWAh2OYa9D9t3FiVtpKxMy8RM/Ux38E2X6Ruvd3kDrR72cA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0lSG/RACwoPNq71TZ7ZvhwnXuIMM3MkqZU7mBEzaiPx5mt6m39hKxUklFDfsbU9uq9MY2bNTlvFf/nqVYvvOq9Z6XIeFkie4PZ+M4tM+aNxEovv8XSVV0yd7N7sOnQwtx2ExvQ9yHDvB/ZPHbY0yIAMmqJi+tkHo9RZ3vox7CvN6xJTZjD88JUF+OSKdZchbYdIUVQpS7VLXhQ5ienJxNW/Usw4fMHIo4hAOYsB0Sp9WLievyKHaig2/MqwGYv3NFpg9b+1JZQcccxMKftPZUjHrQmLlxUytWX7GkA108Iozot9PhuPpWNEYcy3jBdt19WiOzTXlhfu0lq7XoycXsOwEtQGz7KgH59Bx5YqUx8RFOHTAaSnEGAKShTpAL8qyPBpRAqN5EqzN1N3nLpx7wi2z+MJlcbVZETFHJWSXwDW21+Xl8c4+jwLJMYYsjhiq6uTteyX9NyVtyGrVOJTGg8aF4a7EVjNjxPTsRuAc+e9VH1hN6znmjzpCo8secUs30dMYjkhXASubZgLeKR0THInOCHcGCnZtyjbu7lHqNwlYuzwFAMaAu9JWSJYKMvYI01f4LQ9Wq8RI1amwpZgZZdQn2GldxJY5polRCpPd6I3amG+V7gFEHaDU+i03/PBR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee54230e-f66c-4f33-bed4-08df49155958
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 03:53:35.1833 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HD59DZd5fwq5xipaKIImyt7SocoolhL6gIwHWqzQH4NKFxvs+0x4cS0kWC1UoY18KXU+u24j5scsjf7eKdsm5ho4ZgqmCCthsmz6/A7QvQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR04MB993728
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gRnJpLCAyMDI2LTExLTIwIGF0IDEwOjE4ICswMDAwLCBBcnNlbml5IFNlbWVub3Ygd3JvdGU6
Cj4gCj4gSW1wbGVtZW50IHRoZSBoY29udGV4dCByZWdpc3RlciBkZXNjcmliZWQgaW4KPiAiVGhl
IFJJU0MtViBEZWJ1ZyBTcGVjaWZpY2F0aW9uIiBWZXJzaW9uIDEuMC4gVGhlIGhjb250ZXh0IENT
UiBpcwo+IGFjY2Vzc2libGUgZnJvbSBIIGFuZCBNIG1vZGUsIGdhdGVkIGJ5IHRoZSBTbXN0YXRl
ZW4gSFNDT05UWFQgYml0Lgo+IAo+IENoYW5nZXMgZnJvbSB2MToKPiAtIFRoZSBTbXN0YXRlZW4g
SFNDT05UWFQgY2hlY2sgaXMgbm93IG9ubHkgYXBwbGllZCB3aGVuIHRoZSBhY2Nlc3MgaXMKPiDC
oMKgIG1hZGUgZnJvbSBIUy1tb2RlLCBhcyByZXF1aXJlZCBieSB0aGUgU2R0cmlnIHNwZWMuCgpQ
bGVhc2UgZG9uJ3QgcHV0IHRoZSBjaGFuZ2Vsb2cgaW4gdGhlIGNvbW1pdCBtZXNzYWdlCgo+IAo+
IFNpZ25lZC1vZmYtYnk6IEFyc2VuaXkgU2VtZW5vdiA8YXIuc2VtZW5vdkBvdXRsb29rLmNvbT4K
ClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+
CgpBbGlzdGFpcgoKPiAtLS0KPiBUaGlzIHNlcmllcyBhZGRzIGVtdWxhdGlvbiBzdXBwb3J0IGZv
ciB0aGUgaHlwZXJ2aXNvciBjb250ZXh0Cj4gKGhjb250ZXh0KQo+IHJlZ2lzdGVyLCBhcyBzcGVj
aWZpZWQgaW4gIlRoZSBSSVNDLVYgRGVidWcgU3BlY2lmaWNhdGlvbiIgVmVyc2lvbgo+IDEuMC4K
PiAKPiBUaGUgaGNvbnRleHQgQ1NSICgweDZhOCkgaXMgYSByZWFkL3dyaXRlIHJlZ2lzdGVyIGFj
Y2Vzc2libGUgZnJvbSBICj4gYW5kIE0KPiBtb2RlLCB3aG9zZSB2YWx1ZSBpcyBkZXJpdmVkIGZy
b20gdGhlIG1jb250ZXh0IHJlZ2lzdGVyLsKgIEFjY2Vzc2VzCj4gYXJlCj4gZ2F0ZWQgYmVoaW5k
IHRoZSBTbXN0YXRlZW4gSFNDT05UWFQgZW5hYmxlIGJpdCBhbmQgd3JpdGVzIGFyZSBtYXNrZWQK
PiB0bwo+IHRoZSB4bGVuLWRlcGVuZGVudCB3aWR0aCBkZWZpbmVkIGJ5IHRoZSBzcGVjLgo+IAo+
IE5vIGJlaGF2aW91ciBjaGFuZ2Ugb2NjdXJzIHdoZW4gdGhlIEggZXh0ZW5zaW9uIGlzIG5vdCBl
bmFibGVkLgo+IC0tLQo+IMKgwqAgZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHVfYml0cy5o
IGIvdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmgKPiDCoMKgIGluZGV4IDM1Nzk3ODlhMWYuLmJmYTEw
YWZjYTggMTAwNjQ0Cj4gwqDCoCAtLS0gYS90YXJnZXQvcmlzY3YvY3B1X2JpdHMuaAo+IMKgwqAg
KysrIGIvdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmgKPiDCoMKgIEBAIC00NTYsNiArNDU2LDcgQEAK
PiDCoMKgwqAgI2RlZmluZSBDU1JfTU5TVEFUVVPCoMKgwqDCoMKgwqDCoCAweDc0NAo+IMKgwqDC
oCAKPiDCoMKgwqAgLyogRGVidWcvVHJhY2UgUmVnaXN0ZXJzIChzaGFyZWQgd2l0aCBEZWJ1ZyBN
b2RlKSAqLwo+IMKgwqAgKyNkZWZpbmUgQ1NSX0hDT05URVhUwqDCoMKgwqDCoMKgwqAgMHg2YTgK
PiDCoMKgwqAgI2RlZmluZSBDU1JfVFNFTEVDVMKgwqDCoMKgwqDCoMKgwqAgMHg3YTAKPiDCoMKg
wqAgI2RlZmluZSBDU1JfVERBVEExwqDCoMKgwqDCoMKgwqDCoMKgIDB4N2ExCj4gwqDCoMKgICNk
ZWZpbmUgQ1NSX1REQVRBMsKgwqDCoMKgwqDCoMKgwqDCoCAweDdhMgo+IMKgwqAgZGlmZiAtLWdp
dCBhL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMgYi90YXJnZXQvcmlzY3YvdGNnL2Nzci5jCj4gwqDC
oCBpbmRleCAwNjM1OTBmNTZhLi5lODE3YjgzODNlIDEwMDY0NAo+IMKgwqAgLS0tIGEvdGFyZ2V0
L3Jpc2N2L3RjZy9jc3IuYwo+IMKgwqAgKysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYwo+IMKg
wqAgQEAgLTgxNCw2ICs4MTQsMTYgQEAgc3RhdGljIFJJU0NWRXhjZXB0aW9uIGRlYnVnKENQVVJJ
U0NWU3RhdGUKPiAqZW52LCBpbnQgY3Nybm8pCj4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFJJU0NW
X0VYQ1BfSUxMRUdBTF9JTlNUOwo+IMKgwqDCoCB9Cj4gwqDCoMKgIAo+IMKgwqAgK3N0YXRpYyBS
SVNDVkV4Y2VwdGlvbiBobW9kZV9kZWJ1ZyhDUFVSSVNDVlN0YXRlICplbnYsIGludCBjc3JubykK
PiDCoMKgICt7Cj4gwqDCoCArwqDCoMKgIGlmIChyaXNjdl9oYXNfZXh0KGVudiwgUlZIKSAmJgo+
IMKgwqAgK8KgwqDCoMKgwqDCoMKgIChyaXNjdl9jcHVfY2ZnKGVudiktPmRlYnVnIHx8IHJpc2N2
X2NwdV9jZmcoZW52KS0KPiA+ZXh0X3NkdHJpZykpIHsKPiDCoMKgICvCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gUklTQ1ZfRVhDUF9OT05FOwo+IMKgwqAgK8KgwqDCoCB9Cj4gwqDCoCArCj4gwqDCoCAr
wqDCoMKgIHJldHVybiBSSVNDVl9FWENQX0lMTEVHQUxfSU5TVDsKPiDCoMKgICt9Cj4gwqDCoCAr
Cj4gwqDCoMKgIHN0YXRpYyBSSVNDVkV4Y2VwdGlvbiBybm1pKENQVVJJU0NWU3RhdGUgKmVudiwg
aW50IGNzcm5vKQo+IMKgwqDCoCB7Cj4gwqDCoMKgwqDCoMKgwqAgUklTQ1ZDUFUgKmNwdSA9IGVu
dl9hcmNoY3B1KGVudik7Cj4gwqDCoCBAQCAtNTcwMyw2ICs1NzEzLDUyIEBAIHN0YXRpYyBSSVND
VkV4Y2VwdGlvbgo+IHdyaXRlX21jb250ZXh0KENQVVJJU0NWU3RhdGUgKmVudiwgaW50IGNzcm5v
LAo+IMKgwqDCoMKgwqDCoMKgIHJldHVybiBSSVNDVl9FWENQX05PTkU7Cj4gwqDCoMKgIH0KPiDC
oMKgwqAgCj4gwqDCoCArLyoKPiDCoMKgICsgKiBSZXR1cm5zIHRydWUgaWYgd2UgYXJlIGluIEhT
LW1vZGUsIHRoZSBvbmx5IG1vZGUgd2hlcmUgdGhlCj4gwqDCoCArICogU21zdGF0ZWVuIEhTQ09O
VFhUIGJpdCBnYXRlcyBhY2Nlc3MgdG8gdGhlIGhjb250ZXh0IENTUi7CoCBNLQo+IG1vZGUKPiDC
oMKgICsgKiBhbmQgRGVidWcgbW9kZSBtdXN0IGhhdmUgYWNjZXNzIHJlZ2FyZGxlc3Mgb2YgU21z
dGF0ZWVuLgo+IMKgwqAgKyAqLwo+IMKgwqAgK3N0YXRpYyBib29sIGhtb2RlX2hjb250ZXh0X3Nt
c3RhdGVlbihDUFVSSVNDVlN0YXRlICplbnYpCj4gwqDCoCArewo+IMKgwqAgK8KgwqDCoCByZXR1
cm4gcmlzY3ZfaGFzX2V4dChlbnYsIFJWSCkgJiYgZW52LT5wcml2ID09IFBSVl9TICYmCj4gwqDC
oCArwqDCoMKgwqDCoMKgwqDCoMKgwqAgIWVudi0+dmlydF9lbmFibGVkOwo+IMKgwqAgK30KPiDC
oMKgICsKPiDCoMKgICtzdGF0aWMgUklTQ1ZFeGNlcHRpb24gcmVhZF9oY29udGV4dChDUFVSSVND
VlN0YXRlICplbnYsIGludAo+IGNzcm5vLAo+IMKgwqAgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGFyZ2V0X3Vs
b25nICp2YWwpCj4gwqDCoCArewo+IMKgwqAgK8KgwqDCoCBSSVNDVkV4Y2VwdGlvbiByZXQ7Cj4g
wqDCoCArCj4gwqDCoCArwqDCoMKgIGlmIChobW9kZV9oY29udGV4dF9zbXN0YXRlZW4oZW52KSkg
ewo+IMKgwqAgK8KgwqDCoMKgwqDCoMKgIHJldCA9IHNtc3RhdGVlbl9hY2Nfb2soZW52LCAwLCBT
TVNUQVRFRU4wX0hTQ09OVFhUKTsKPiDCoMKgICvCoMKgwqDCoMKgwqDCoCBpZiAocmV0ICE9IFJJ
U0NWX0VYQ1BfTk9ORSkgewo+IMKgwqAgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJl
dDsKPiDCoMKgICvCoMKgwqDCoMKgwqDCoCB9Cj4gwqDCoCArwqDCoMKgIH0KPiDCoMKgICsKPiDC
oMKgICvCoMKgwqAgKnZhbCA9IGVudi0+bWNvbnRleHQ7Cj4gwqDCoCArCj4gwqDCoCArwqDCoMKg
IHJldHVybiBSSVNDVl9FWENQX05PTkU7Cj4gwqDCoCArfQo+IMKgwqAgKwo+IMKgwqAgK3N0YXRp
YyBSSVNDVkV4Y2VwdGlvbiB3cml0ZV9oY29udGV4dChDUFVSSVNDVlN0YXRlICplbnYsIGludAo+
IGNzcm5vLAo+IMKgwqAgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0YXJnZXRfdWxvbmcgdmFsLCB1aW50cHRy
X3QKPiByYSkKPiDCoMKgICt7Cj4gwqDCoCArwqDCoMKgIGJvb2wgcnYzMiA9IHJpc2N2X2NwdV9t
eGwoZW52KSA9PSBNWExfUlYzMjsKPiDCoMKgICvCoMKgwqAgdGFyZ2V0X3Vsb25nIG1hc2sgPSBy
djMyID8gTUNPTlRFWFQzMl9IQ09OVEVYVCA6Cj4gTUNPTlRFWFQ2NF9IQ09OVEVYVDsKPiDCoMKg
ICsKPiDCoMKgICvCoMKgwqAgaWYgKGhtb2RlX2hjb250ZXh0X3Ntc3RhdGVlbihlbnYpKSB7Cj4g
wqDCoCArwqDCoMKgwqDCoMKgwqAgUklTQ1ZFeGNlcHRpb24gcmV0ID0gc21zdGF0ZWVuX2FjY19v
ayhlbnYsIDAsCj4gU01TVEFURUVOMF9IU0NPTlRYVCk7Cj4gwqDCoCArwqDCoMKgwqDCoMKgwqAg
aWYgKHJldCAhPSBSSVNDVl9FWENQX05PTkUpIHsKPiDCoMKgICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiByZXQ7Cj4gwqDCoCArwqDCoMKgwqDCoMKgwqAgfQo+IMKgwqAgK8KgwqDCoCB9
Cj4gwqDCoCArCj4gwqDCoCArwqDCoMKgIGVudi0+bWNvbnRleHQgPSB2YWwgJiBtYXNrOwo+IMKg
wqAgKwo+IMKgwqAgK8KgwqDCoCByZXR1cm4gUklTQ1ZfRVhDUF9OT05FOwo+IMKgwqAgK30KPiDC
oMKgICsKPiDCoMKgwqAgc3RhdGljIFJJU0NWRXhjZXB0aW9uIHJlYWRfbW5zY3JhdGNoKENQVVJJ
U0NWU3RhdGUgKmVudiwgaW50Cj4gY3Nybm8sCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGFy
Z2V0X3Vsb25nICp2YWwpCj4gwqDCoMKgIHsKPiDCoMKgIEBAIC02NjIwLDYgKzY2NzYsOCBAQCBy
aXNjdl9jc3Jfb3BlcmF0aW9ucyBjc3Jfb3BzW0NTUl9UQUJMRV9TSVpFXQo+ID0gewo+IMKgwqDC
oMKgwqDCoMKgIFtDU1JfVERBVEEzXcKgwqDCoCA9wqAgeyAidGRhdGEzIizCoMKgIGRlYnVnLCBy
ZWFkX3RkYXRhLMKgwqDCoAo+IHdyaXRlX3RkYXRhwqDCoMKgIH0sCj4gwqDCoMKgwqDCoMKgwqAg
W0NTUl9USU5GT13CoMKgwqDCoCA9wqAgeyAidGluZm8iLMKgwqDCoCBkZWJ1ZywgcmVhZF90aW5m
byzCoMKgwqAKPiB3cml0ZV9pZ25vcmXCoMKgIH0sCj4gwqDCoMKgwqDCoMKgwqAgW0NTUl9NQ09O
VEVYVF3CoCA9wqAgeyAibWNvbnRleHQiLCBkZWJ1ZywgcmVhZF9tY29udGV4dCwKPiB3cml0ZV9t
Y29udGV4dCB9LAo+IMKgwqAgK8KgwqDCoCBbQ1NSX0hDT05URVhUXcKgID3CoCB7ICJoY29udGV4
dCIsIGhtb2RlX2RlYnVnLAo+IMKgwqAgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZWFkX2hjb250ZXh0LCB3cml0ZV9oY29udGV4dCB9LAo+IMKgwqDC
oCAjaWYgIWRlZmluZWQoQ09ORklHX1VTRVJfT05MWSkKPiDCoMKgwqDCoMKgwqDCoCBbQ1NSX0RD
U1JdwqDCoMKgwqDCoCA9wqAgeyAiZGNzciIswqDCoMKgwqDCoCBzZGV4dCwgcmVhZF9kY3NyLMKg
wqDCoMKgCj4gd3JpdGVfZGNzciB9LAo+IMKgwqDCoMKgwqDCoMKgIFtDU1JfRFBDXcKgwqDCoMKg
wqDCoCA9wqAgeyAiZHBjIizCoMKgwqDCoMKgwqAgc2RleHQsIHJlYWRfZHBjLMKgwqDCoMKgwqAK
PiB3cml0ZV9kcGMgfSwKPiAtLS0KPiBiYXNlLWNvbW1pdDogYTE5ZjU5YTcyZDk2MDU2ZDlhOGY0
OGNmNmM3N2Y1Nzg3NDkxZTQxNAo+IGNoYW5nZS1pZDogMjAyNjEwMTktaGNvbnRleHQtZThlOGY1
NDk4OWE0Cj4gCj4gQmVzdCByZWdhcmRzLAo+IC0tCj4gQXJzZW5peSBTZW1lbm92IDxhci5zZW1l
bm92QG91dGxvb2suY29tPgo=

