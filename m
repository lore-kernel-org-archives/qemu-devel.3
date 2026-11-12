Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF84606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 03:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=ZIjiH5OI;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=N5zqiGvk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRLdT-0005Qr-Ob; Wed, 11 Nov 2026 22:38:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=769f446c1=Alistair.Francis@wdc.com>)
 id 1xRLdS-0005QW-R2; Wed, 11 Nov 2026 22:38:02 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=769f446c1=Alistair.Francis@wdc.com>)
 id 1xRLdQ-0001Nb-Hd; Wed, 11 Nov 2026 22:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794454680; x=1825990680;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=y8bAuH97mVZ6GflHl0Lk0FzFNnGi/PMgpjw2qhk43E8=;
 b=ZIjiH5OIofN7CyXO01G3NYRgxT8/6B5jA3qQuvmgjpxAgR9EZFhs+U5b
 2+KQyEaxpnjIsWe+WmcBNQxHj/c9Hrc/ZI54NIrb/4CFrmfovNWmcHRwK
 8ZUJwtqK3aN0W+U1x4PvnARuzzwnXYMq+d+rjksrr5x6ACPTh6Sf7lYw+
 1OEFkYsJXU5uFJH1wYZkmHWt8pvuwHRlWtOkLVUIV61uKp093PJ5ZvTfT
 cV1CKPhTUwS01CX+XwGgwNUCo8g7N6O2ZJaETIPYTNatJkVwAckaQfuKJ
 KRL7n5cgpew5EGNDv2C+GlD7rCe1v+9W94hJb1XrqL3ENMd18NBduyEhP Q==;
X-CSE-ConnectionGUID: B6+vNOjEQCmssVxwCRRoLA==
X-CSE-MsgGUID: 6SWvnHQNREOsPK+73B9dBA==
X-IronPort-AV: E=Sophos;i="6.27,208,1786982400"; d="scan'208";a="160695986"
Received: from mail-northcentralusazon11013012.outbound.protection.outlook.com
 (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.12])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 12 Nov 2026 11:37:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeQQde4OMG0hgGZ246rsLGxIpgNyAZYxzeggt7ZHyhvaUTU2lE9L7gz1W6YEydGYUS/Gf2KIRJ1fb+FkQ4X2Im/jImEPSH8oqLkrB5ZnLGVa6R0kJVVAdN7TLHOH24mquGShN/uEAHuJUjGnNjRcjrFYQESbR6sxvfFzpY5eYyADk4x0dTUjQ6PtwFgJFAV+XQZIYoNHqdupAqgyVUbt14vEL3382aHQmK+/dRvm136/c7pVwZeJSrSXxiNUw7Q0Df4I72pEBZMJBY+zQu6b5qWYCsLzYG500Zfxj33Wdt+2NWkPoGU/kGiw89EpTnpJ5ED2mT77TdE9i7vbDzzlCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8bAuH97mVZ6GflHl0Lk0FzFNnGi/PMgpjw2qhk43E8=;
 b=kg2Ivh2Q93GBwKCGtdFfAEvxfYPs+5z4th0jOUwsTjse+Xdxuwj/JTINCmSyD0mjM5g30r7OtwjIL09qX/D8qRCZkQ9ySPZ3GtLo9/tkHfMA3hLCkECXpwMG/87rv7Kl0cetXGkKiMdZIInqneaeBOdwCzBkeZFao1yk/YOJqDYSQs9EB5N6TJt9gRR8eb1Ss0uScPr7NpJ/dYP/2mMA/y1WIRO0AhgU3pgJl0445BGeaEKXxUGcSx62ayXAdIEjYPvnYGhcBcRYnBOdy3XxGb1fiftF679XWxR5qyJIeaiwukAo8vy7C4z1TLr1mXasMvIkAgBKv2UZaYNqzTQwwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8bAuH97mVZ6GflHl0Lk0FzFNnGi/PMgpjw2qhk43E8=;
 b=N5zqiGvkfln4WcbvwmF6jAfV/rrp8SZjrmxD5b0TxFcRvtUGcWt6JZjcQ+k8RYmcCA+LJsmLmoY3DvWqx4A9kM9/sDoXcm9eoHUaOEHERmRD/cYJWMc8SXHi2SmqEkvFEIcyoV5Cusf3ziw5FTkg65PL8Nl3qpSb5V3G3Br63iw=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by DS2PR04MB994338.namprd04.prod.outlook.com (2603:10b6:8:4ac::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 03:37:55 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Thu, 12 Nov 2026
 03:37:55 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, "bin.meng@processmission.com"
 <bin.meng@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 0/2] riscv: boot the K230 from qemu-machine-images
Thread-Topic: [PATCH 0/2] riscv: boot the K230 from qemu-machine-images
Thread-Index: AQHdaQ0h74vgN96T5UmbLMe2u+84/bcp3EwA
Date: Thu, 12 Nov 2026 03:37:55 +0000
Message-ID: <f1cded9a181bb43590717a4a29e3b03a98e34ccc.camel@wdc.com>
References: <cover.1793433265.git.chao.liu@processmission.com>
In-Reply-To: <cover.1793433265.git.chao.liu@processmission.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|DS2PR04MB994338:EE_
x-ms-office365-filtering-correlation-id: cf741253-aaf0-47ab-dae8-08df406e5693
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|23010399003|10070799003|1800799024|18002099003|22082099003|6133799003|11063799006|261102123227099003|261026140227099003|56012099006|261028144727099003|261021121427099003|261022105027099003|261021123027099003|10067099003|261022115727099003|261022075727099003|261009223027099003|261026121527099003|38070700021;
x-microsoft-antispam-message-info: CynOkV+rnGUrKuej3bLxpTxgGcEgJyA+I70DIVcbBjxzEpZB2qW8P6+BJAvcTsj4ftFQMXstu/AjiV0VfA/q8R/nnlhQgZHxpZPqFNXTq3kYuY0BnWU3KbM6zfWUi/nnQVA4v3l7XpROLbeiJGIqkCS82tfchjHmNyB8cnuGBnq9dgUKtSXuQpQfNVNJyrLHaElLuW7pGIkEr9UdYb2jKhCzm1tngguvYN9ijbaeojjPil7uED5TJeNicFfwjRrldqZnCHytNlBFc1R0dtyBPU+QIsXq0NvGZVEuM26CXUzanbLY8iXjA/qYU72KmPM9/em4wJUfcrNEy60vpejNxQfT6KHNy6HfRkNNuWXiLC85eCgwXlQlEpmjqt4rmlU8gXNuwTVisDB3fCP5Olo2Zr8/J6M23oJ1Ig0o2TGxHgZE7sanEu8xo0xLn4Chvql7K8j3UTEKa3Njp5L6RIL4LLWpwnZcsfeFP6eQHy/af33cS54tGgScOpgpTlgXA/iOnCbd2KHPEYChJYTTlB/1ZIWw6no49zH5Inii/49I385G2p4CFwKLVNmoBo7eek9AEFPw/HB7XaNANI/EnKJDmKHMxWNCsqxgsLwtvuBQGjbhlYupux7GJhg1NZ2QN0RI2JJWYFVBN/Izx7npt6TwqtPajoEPeuQqWcNkiwH7vg3mENcsOXyk2Ms2dTPZxGj/8tm3MU/NvoQvgbZEepAYw9WhS7J51j37SluHhHYf5VU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(23010399003)(10070799003)(1800799024)(18002099003)(22082099003)(6133799003)(11063799006)(261102123227099003)(261026140227099003)(56012099006)(261028144727099003)(261021121427099003)(261022105027099003)(261021123027099003)(10067099003)(261022115727099003)(261022075727099003)(261009223027099003)(261026121527099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1FyYzVvenNaSHYyU08vT3d2b2NhcklIVDVTejFCZHpvL1o1aXA4cmdDY2xq?=
 =?utf-8?B?aVlVVGlXRllVSnNEQkI4Wk5RcU5HcExsUDJGMjdJOUk1MDBPMFdSc1ZZQnIz?=
 =?utf-8?B?dzVkVVNjV241M2s4cUZJVlVzQkRTQ291MHNqWldFK3laSmg5Mjk1MWNUem5X?=
 =?utf-8?B?RjhyY3hYbnhlV1l2Z2hIZTZrTU5wemVEODBoeTVDWEZyWUdkVlhzaTBaVjlv?=
 =?utf-8?B?RHlhOGRLMmhJQ0U5Zldlb0hucVBkamFoOHl1eFpzYVUyLzhBYm1nZVdKTmpN?=
 =?utf-8?B?ZE5nVllDT0tGNEhsL1gxOExyRXk0N1VpWW9idmk0YmdVSE9NTnorNUVoRXVI?=
 =?utf-8?B?am5OUmNJWC9CbmNRQ1lYeFdrNTNEODVzM3VVaTBxekE3amRUZHp1OXdtVmxu?=
 =?utf-8?B?WFphT0J0cGhqS3RxUDY2dzZuQWlpckFESXVTczZ4TXRiMWsyTU1hdmdjTGQw?=
 =?utf-8?B?dG1lMk94czhTUFdYaktIV016UkZpTXFZNnVadmFTSGhHN1hwQ04wL3B1MTJk?=
 =?utf-8?B?T0FqZTVpZitGOWhncmo0SzdzMUI5S0FTYkRmUzR2eGEzbkorVHFmNnh4eHky?=
 =?utf-8?B?clgxVGEyWnhDVjlGNTcxaSs0ODhjcUlqbTA1cGZabjY0MkR5UkZZR0hVSVhM?=
 =?utf-8?B?V3RpaGZpb2hwRE5hdEpEVEtnUjhNR3JyOWl0NU5uSTE5UGxuV0lhL2pKMEZm?=
 =?utf-8?B?YzRhNDYzU0wzKzRDZ1VZeERTeHN1Z3BOZWlIeVUyWjJvR3hmN0FuZThsTmdP?=
 =?utf-8?B?OGdMeThGb2hoc0FaZUVwdUJZa09meTVqR2NoUW42SjByUnZWMFpGdk85aEx0?=
 =?utf-8?B?bHpQOVpJYWFiMVhiVGdESjc5ZFJaeGtnbkhtMndmVnc3TDdMSzRpdk9Odmwv?=
 =?utf-8?B?WHRmK0RtbTJOQW5pY0U3bVRIWFZZOEM5WmMxeUVvL1duczlZMXo0ei9PRnJ6?=
 =?utf-8?B?SFR5ZzNJQW11aDZ2UmwxNHpTT0plSXdNZ1FVSDdGYmRWMlhCZzhHWFVkOVp3?=
 =?utf-8?B?dXllOFdqTU1TelptUFZCZ2JjNGJ4a1J4cjF1QTZJc0p6a1hOSWlpTUVPZmNi?=
 =?utf-8?B?OElqSFREcDJMbHRFcDVvQk0vYjQybkc4ZWt1Yk1NZ2FrNGJPRXc3b3JBWm5G?=
 =?utf-8?B?bllLSkd6YVMxeVczKyt1TCtlT0dGaUZSbE5lQW9oYzBHOTlvdDY2UGJ0aTRw?=
 =?utf-8?B?Y2hQRTBjWXlDcDFiRWJ6OVlJYUdWcmNzWFBpUU50THdJSGlmQzVBNklKNU5m?=
 =?utf-8?B?WTR6VVU3MDhkcHF5ZWtOSTVqNUhvMGJ2VXZLRWxMcTlYN0hBT3R1QVcrSHYw?=
 =?utf-8?B?Q0VDNEVNMzVEbk1oUzZOa1prakFNM3hsRTNhMER0SWQydWFFOGxqc01QcVo5?=
 =?utf-8?B?SjFSZVVQVFdpVGVMV3B0QTBYZnVucCtGaWFCN2pIMjBmb3U5M21FNlZhOS84?=
 =?utf-8?B?bUh5RHRRKzJ3bFA3dUVzbzlQbkwzSWovbi9YYnlzdTZHTm9nb2ttMFFaQWdn?=
 =?utf-8?B?akN6ejFpM200cVRrdXVkaFJHUGs2NVhwSnRBS0RMMTE2ZVdLN1BuT3doMStV?=
 =?utf-8?B?OVcvUlBHUkw3V3R6VXJIZTAzZ292b1N1Q2hwMVlDR3M4eDZmMSsxL0o5dTdW?=
 =?utf-8?B?TlhYWkN1V2sxR1hxdnlCbkpUUWlVSEZTdldhZEcrSzhqNndsZE5SZkVaMDNN?=
 =?utf-8?B?Mm9qMEFDZVd1RElaVk1zc0VBZWpFRS90TlJibVBiMVZscy9sZWlCZnJYT1dF?=
 =?utf-8?B?d0VqREcwNTF1OXFJQ3NUaEloYW9UYXpyVFVuajczREl6bE5naHZGamFTQmly?=
 =?utf-8?B?aHppMUZ4ZHVaejllL3k5bUxjU3N3bVJ1OUhucTRpR3dFVWNzVkdhZzlYT3BJ?=
 =?utf-8?B?N0l2MTZEVTFBb0dxbkhISGtwc29hYlRpc0xFK1JvdmQ4M3VmUEZvcUtMa3l1?=
 =?utf-8?B?eEZweW9MMnJBUDVPTkxyNFJxRStLOEt5Mm9KVkxUUUNVTUo5V3JIaWdNL3lM?=
 =?utf-8?B?NVlWSURNbFdqZ1hIRm9uWkphQTZnZW11TThkWjdySysxSEpZZCtLWXZhdGZZ?=
 =?utf-8?B?WkNGem1KRmxyYWFuV29JSW9NbSt6ZzYrNGZVay9tejAwS2haQXJqRzdTTGY4?=
 =?utf-8?B?ZGZWY2Q5YnlrQzd0eHBUWDlhUzNFaXpXZEFtN290MXBJVTR1ODBvRE0xYWRV?=
 =?utf-8?B?K2NKbEpsSHF5MFBCRE1DUmViOXJBUTlmOVhFK0NUTHJpNjBHK2dmQmsxK2dX?=
 =?utf-8?B?Q2xLUW9SdXFUWlZyWmFNcW9XY3VsOTVRU2FGV2RLbXBhOG03R013U3NZUExL?=
 =?utf-8?B?ZmNyTmNGQ24zRFNCNUduSGUyelphazdFVTFKM1FBZU5IaHg2bXRoZE9NdFVI?=
 =?utf-8?Q?LkKx+XLbQxR6IWOAw3G8maJhOF7nHcf1tlFFow3gBfOrJ?=
x-ms-exchange-antispam-messagedata-1: Si4L0Tb1iqJngPrLv5HG0RaqiDMs4Yv9WiI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7600C64435E8214C9DB0E5B98D050A90@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3VF02OJAAKuR/SXFzEMCAodI5nznEtFQG0QTtMWNHnIkuzzq1qrbIkh43rAT9ZgDr6oMdiSmJFOYn6+At4K76YSQIDc489Qts/HlNk1j8S+XxlrYDUrft033X28XPcywumymh4R5Td/0VihLnjpuqKit6mITJqY/rtog20DBi9q+ftbgQVgtNpNUEYy/SPTAx3XRBWgOK8NvxcNm3HXIJjTw3YU5dbfEPm5HP5R7mESTzvW+m4z9x7C80plk+LvHiShpoiROjj+n8QXqxxsm2C0Q1X0bCz/jaFzLI23aGOzygDDMbcOda9WFJwKg/ufBYGSA6OZEvVJRwMfSmbJwJw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JKyQsAD/RJU8TNa3UDQmVBUn0qvNjHfQsufyWh3UYFxAJRd46tmoPEIcCp4OckfqKVNNmnx1hlNtJZ8vNzGvk4wHzsITly4+FioJQb7mKiLzrQtJ5tP0XRgbo+G7fzHv9XBZyw9KA9aCviBzf3Fp9Hvtn2r1LXA0yHFPz5Qx7dQMhSumxZ2V+UpCVSf/KmKoeWUydY7G9ZFhXLwFtZW8d5upohEZRgt6lGiy++AVDrDXy+iOX85Jnr4RYeoQ2xgBAcHaxJemrL+1P2oMwdyERXdFwNGq64x9M/ARWtuUJqL4bgcnr/hFheMYGwOeeKlVNN1b14JD5I3IFcAJH/0Ad3H3aI+J3+mvIyd3/ulrsE5nE82mnHyprEYEur84ckBqj0h87aWL28qQpSP4hcu6OYO2Itckfry25ZdVKtZ4SvXowuO2VxhRB7QgDHEKs/xPzQwlAUovxst+oUXYXYdy6Ci+hkUAWrObB/VzdumlTIfWBMu9am0IHPjUCOzl8aJkIHpqhevKLPVFQHepoSrhsvU7QxvUnBQcox7O1J+QTc0U1OoJeqGQyKp7Ekk1xQkd0esDW8XtdhmV1vpRccw4+HuPvl0voRKJ7HmMSw2VDES5s+itFUFQi7NxrLYTEogJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf741253-aaf0-47ab-dae8-08df406e5693
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 03:37:55.2620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h3XIda8U4TIdsr6v/IJFJv8gOEesg3pI9rL82f4A0MA11QmMuNSS21wM/AJ3rn++M55frXSWD6+iJUIHwIUWSQRilXVQWRTtZeBa0Xzm9NY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR04MB994338
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=769f446c1=Alistair.Francis@wdc.com;
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gU2F0LCAyMDI2LTEwLTMxIGF0IDE1OjU0ICswODAwLCBDaGFvIExpdSB3cm90ZToNCj4gVGhl
IEsyMzAgbWFjaGluZSBoYXMgbWFueSBoYXJkd2FyZSBtb2RlbHMgbm93LCBzbyBJIHNpbXBsaWZ5
DQo+IGZpcm13YXJlIGJvb3RpbmcgZmxvdyBkb2N1bWVudGF0aW9uIGluIHRoaXMgc2VyaWVzLg0K
PiANCj4gVGhlIEsyMzAgaW1hZ2VzIG5vdyBjb21lIGZyb20gcWVtdS1tYWNoaW5lLWltYWdlc1sx
XSwgd2hpY2gNCj4gYnVpbGRzIHRoZW0gd2l0aCB0aGUgc3RhbmRhcmQgQnVpbGRyb290IGltYWdl
IGJ1aWxkIHRvb2xzLA0KPiByZXBsYWNpbmcgbXkgb3duIHJlcG9zaXRvcnkgdGhhdCB0aGUgSzIz
MCBpbWFnZXMuDQo+IA0KPiBUaGUgc2VyaWVzIGhhcyB0d28gY2hhbmdlczoNCj4gDQo+IFBhdGNo
MTogVXBkYXRlIHRoZSBrMjMwIGZ1bmN0aW9uYWwgdGVzdCBmb3IgZmlybWV3YXJlIGJvb3RpbmcN
Cj4gUGF0Y2gyOiBTaW1wbGlmeSB0aGUgazIzMCBib290IHByb2Nlc3MgZGVzYyBpbiBrMjMwLnJz
dA0KPiANCj4gTGluazoNCj4gWzFdOiBodHRwczovL2dpdGh1Yi5jb20vcHJvY2Vzc21pc3Npb24v
cWVtdS1tYWNoaW5lLWltYWdlcw0KPiANCj4gVGhhbmtzLA0KPiBDaGFvDQo+IA0KPiBDaGFvIExp
dSAoMik6DQo+IMKgIHRlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NDogYm9vdCBLMjMwIGZyb20gcWVt
dS1tYWNoaW5lLWltYWdlcw0KPiDCoCBkb2NzL3N5c3RlbS9yaXNjdjogc2ltcGxpZnkgdGhlIEsy
MzAgVS1Cb290IGJvb3QgZmxvdw0KDQpUaGFua3MhDQoNCkFwcGxpZWQgdG8gcmlzY3YtdG8tYXBw
bHkubmV4dA0KDQpBbGlzdGFpcg0KDQo+IA0KPiDCoGRvY3Mvc3lzdGVtL3Jpc2N2L2syMzAucnN0
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDYwICsrKysrLS0tLS0tLS0tLS0tLQ0KPiDCoHRlc3Rz
L2Z1bmN0aW9uYWwvcmlzY3Y2NC90ZXN0X2syMzAucHkgfCA5MCArKysrKysrKystLS0tLS0tLS0t
LS0tLS0tDQo+IC0tDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspLCAxMDcg
ZGVsZXRpb25zKC0pDQo=

