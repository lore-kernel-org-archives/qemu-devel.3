Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9277606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 02:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=WHr/fpR3;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=LDn7ihEv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVJQB-0005cr-2B; Sun, 22 Nov 2026 21:04:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVJQ9-0005cS-2W; Sun, 22 Nov 2026 21:04:41 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVJQ7-0003mT-2c; Sun, 22 Nov 2026 21:04:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795399479; x=1826935479;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=i95mDKHwc43MQDghXGbBGPzSHZv42ROXY2iITdxWWNU=;
 b=WHr/fpR3XsiJN9+E/wka+k0REL3lKc4Tarxh5FY+Qygi7gxj83+YwhFf
 McYpWo/f4DbkjLNLplpatUI0lYKh3WsUmIWqYoG5M4tcNnlokZUWCvvuF
 lyE83EkZddGTbDrVqKeNH62kAb9Jj56/fXqD8TCmTl62OMnEMY2My+H2c
 wzy4oaQIoFn7GI8zN3RM9Nucj49DnecLCK2I3BFv8h7Jb/Bb+2i9UQM8G
 ehzoWMbN0YNBRpZTIxpScu+2d2fDbh8RkREsI5pj99yrY4I55IygFZeP+
 a55w8d5xJ9EGTjlm/DcQzqBBtal03gEM0s6gDS6k0Fvf1cY+3+bAXVwtt A==;
X-CSE-ConnectionGUID: xVbxqPP8Ri+HSHEyUc+gsg==
X-CSE-MsgGUID: 41q9BzlAR5+/ujtEBE+mRA==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; d="scan'208";a="159903492"
Received: from mail-westus3azon11012061.outbound.protection.outlook.com (HELO
 PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.61])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Nov 2026 10:04:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmrPRZokRnZTJ1dp4wz+4/8So77M/XhTGqke36NvvudyK7DJnTqhg0N87OQvc3sgteFcdBOfSOXAbdTHfH+GmVQDq+mGUCErpv4R+5w7cxC3ezJ5OvqCHZZyyz7FcU+7uwMSTD2mgoMwVRzANYmL+nonAIh1Jowo+8BYNy/ZU7PF/my4LNdYN9+6LZGv+qC5Jkf77847OlTRJUjUCtadH54ZUCR0gDqu30f9dGDkJHTR8jAhIRyFvcbqAYKXazJXCeEEUn+vYE6JAe1KKy8OnSywVmMvx9CPU8nCTP0EM15ezk1Uvg/xKYzGk37HnHvvFpEG6twVYJJEGTze427uVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i95mDKHwc43MQDghXGbBGPzSHZv42ROXY2iITdxWWNU=;
 b=k0BPgs+fxD+TP7EW/p18BUaIt24WfEXFp/p8bo3OHxDbHgItQecP5ppxDUKHlzEI6BEo4m+PIZOyEISM93qCsoYTsw3pe9IDdCn8qWlhN+LCdBs6GQG/yeC8kom3nHlQMj5AwNDn5Tc0pNsclQG5LqP8Z5b2OnA7wQ/hjd8Scb9rdnPpsLfcnJ8lA00wMossnFvC08HIwF+/D2BiO9uqAeRXvrGvGh4AssAEJNEbqsjCPdSomM9QWmTKNdhmpaCpCF7rnkyrRwJqdQjwOWrVr9UN/dXnbTdA9SR9xbYOvEaiQDl9fUX6PPoEOFq5n+Sf6GG4okkUMWqMb0sG4COT9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i95mDKHwc43MQDghXGbBGPzSHZv42ROXY2iITdxWWNU=;
 b=LDn7ihEvvCGvT8oixGnxav3EWsBU17U7DJA4r4ppVSUriPLH8W+2QSiEia+tLqrvmKnCFVA3m5AutTWJBaHuAHj+X1IH4P662ycO9yx5Upm45t1hh6TOA7C9pfNb0tN3ndcbmAn1DSkbFIag6/3XxktJOoOEnLaLHx1BtH02NcU=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SJ0PR04MB7485.namprd04.prod.outlook.com (2603:10b6:a03:328::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 02:02:34 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 02:02:34 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "christianslima@proton.me" <christianslima@proton.me>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH v4 1/2] target/riscv: change mstatus bits for read-only if
 S or U unsupported
Thread-Topic: [PATCH v4 1/2] target/riscv: change mstatus bits for read-only
 if S or U unsupported
Thread-Index: AQHdc7jYWTT4fwis0EumcfWUaz7YA7c69faA
Date: Mon, 23 Nov 2026 02:02:34 +0000
Message-ID: <e19ff2a418365432a3f7633ea95fa2bcaaf4227f.camel@wdc.com>
References: <20261113214854.40425-1-christianslima@proton.me>
 <20261113214854.40425-2-christianslima@proton.me>
In-Reply-To: <20261113214854.40425-2-christianslima@proton.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|SJ0PR04MB7485:EE_
x-ms-office365-filtering-correlation-id: 2ef4608c-7e08-4e1d-8b34-08df4905d738
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|19092799006|10070799003|18002099003|22082099003|261009223027099003|261021123027099003|261021121427099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|4143699003|56012099006|10067099003|261102123227099003|38070700021|11063799006;
x-microsoft-antispam-message-info: wGJRbNFOGnQordBz8lmU99Yp9WEbc7FMyRMZdzcL8YoSsozIDPT6tgoFHzU64g1aiXP9NHoZfKl62M4AFr5CZ2ZJjL9WP8DzGHYTh+x0ZpRM+0Wy2r7SNaxz11xpS/P7C8R1WOBQa0t9SOu48ndNbJRbIY+q83elq21/eQDrFGVygFn/Op/bAPzE/sekOxwNxinylzbzsHfkZ9nIk55HVzMRH5H9okv6GPFKAjg22stJftzN0kAzlfr+kFXWHwq/2bQIqykBCBVmuULLysmFjT0D43EIJ4SzysOMnj/dffys2toqOAV3Owdlc3T4tk6b8pw3EpLiEKr1HcUenVf3dyf7y0NPOsxFtwKtSRGDEWQF2Ru+yV7OvRU6XhfinvySRVrSkcDYi7KkBJFJnQleCPzKQc4WVu+s/2FmZwoYKYaG/Bm/Pjc/hbVW5gyb4/fQZjwbioRi1ScdEmA6QGMkJcd4fFzBiBHuOUeslvp0ueHwK+gAOBkdhenBvvIL6ZRIyVoZTdUTuwJS6uPzC5EeNiyfmcoAJxAWIWMLnYD9aovkTeDaGKDHAbolLGE9309ncwa9FTD3RF6Q+y4BIhDZTHm4l15CBvDWVoy2I11o/E+1eJsrczv8Petdkrw07gUzWLHPgAzdqxO+AhZ1QlZUrbRHxjEmpGWx5vnPUZLdbhM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(19092799006)(10070799003)(18002099003)(22082099003)(261009223027099003)(261021123027099003)(261021121427099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(4143699003)(56012099006)(10067099003)(261102123227099003)(38070700021)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2JPUXQvbGZHeFViVmdXTzExTS9WWWNFMEgyUzJOM2k4NFZyQkxFMnc1Qkdx?=
 =?utf-8?B?ZEkrUTdIR0gwNkJKWWVGczQ1Z1UrbDFOU3N3Y09KSzYzSEtLNitRSkJNOXJE?=
 =?utf-8?B?WFRjbWExRGlrdDJMRGdNWTZ2MHJYMnhleFJibHZpYkNyZUhKdnFjQUJpOFdo?=
 =?utf-8?B?VlBRZ0t6dTVnYlhidzd0K01BYXY5T2w3UjMwVWpmdjNhTnFlY3B5cjgydjdy?=
 =?utf-8?B?OXg4bnUwUFluWHQ2eG04dDlTYTBqbFF0SkM3NEhWa0pGdlllK0J4ZE1XM3JR?=
 =?utf-8?B?eU41YmpwRmJQVGtSdnNkVDdIRVRYckRjYzQvaWEwWFVLYjVXSktiTVVKQlRS?=
 =?utf-8?B?SStkb09JNkhSTnZ6RHl6NUxiZTlvMUcyVTJKYXVpZkpJYWcreXphbFVsYTdu?=
 =?utf-8?B?U2lHMGhPUVJkanllcWxYWVFBb3lRYlZkdlhna1RtSllOSnJnQ2t1bDJTcUhj?=
 =?utf-8?B?aWxjMDFwbXQ1TWJ3Nkl5bGt4ME1Rak9VVDJZVFhzbnhTZFNhMm5zRkJPYmJN?=
 =?utf-8?B?RlBKQmFGVlhDWVJBQWYrZENneEhHZXpJTTlYVTBrUUxBUXhlNGVTcGlsajNw?=
 =?utf-8?B?SXlGTm55ZklIUUh1M1F0ZU8xTU9WbFlEQTd3OUtVNzh3TE5lMjVOcVl5cU1n?=
 =?utf-8?B?RWxoNkhicUpndUl0aWZrVnE5cGpBaGpFZ1ZUMTdLbDh0N0tsdHJCdTNNdXJU?=
 =?utf-8?B?MG9iVGxhMjM3Ti9nVzYyejVrRXJkTy9YcE92N3U2c3lZU2xPMXVXZjdjcHZS?=
 =?utf-8?B?bXVtcjYxa2V4K053cmtFNjNQNEgzOE5kZldGdEVRaE93bUNPT2J5czFtbUxw?=
 =?utf-8?B?UFZsSFJGU0Jia3JlVjlMVUsvbHd1Nkx4dmhvWkF0a3NkbmFDV01RMTFlaXRS?=
 =?utf-8?B?RGFHR3NTOUNzc1RCcnRCUUVxL1c4VWpESVZYZUtIRVNXcWZoanQwcFFZSHdi?=
 =?utf-8?B?VzJMVkFpVkJ0amxUSkIxRnJ0anV5aFgxcng4dEJBTnhocVpQNVZoWXdZVjhl?=
 =?utf-8?B?OHNtSmNjejZQaWIvc2wvajVialM4YmlldWhyZ1dBY2RhMkpJVXU3bmd5M3Q4?=
 =?utf-8?B?VVhFN2F2QjROZGhoNlFTSjdKUHZ1T1VvM3NoRlBhc2tIZ1BINzRCcjd1L051?=
 =?utf-8?B?V1ZtQmJiUmZzZmx5SlM5ZXRycXhrUmlwblFpb3NxY0VaWFdDMGZ2RkRUaFdw?=
 =?utf-8?B?OHBST0J5TmZqZ3Y4L0MxMHl3VktpY1d0Ymc0Wng5KzVVL0lVTFlnaWt2dG9o?=
 =?utf-8?B?UDUxZDFjR1FsUlRxVityQysyN3BZOGtMUnJqcEVGSjFuTXFpckxjdnBSMENU?=
 =?utf-8?B?YzhkUHdzZ0MyKysvVHhvZGd5T3VZS3lKakFUVTRlVGJLamN3amQrSEY2MitI?=
 =?utf-8?B?c28zRStHYlBrSWRYR0NRb0w5SDBVVnVpTGxPUW4rcFo2LzV1RWQ5cXRpZ2s4?=
 =?utf-8?B?T21GcmVBZ1djQzh5QXZqWXphT2VaaVI0NXUwQjFDYTRod2NUYXVRUE5JeHly?=
 =?utf-8?B?a3pUZXNQUFFibE8vdWozTkhBcC95NndkSVlrWWRyRUdhdGNZbmdPdTRVYmsr?=
 =?utf-8?B?RUtic2hDc2JRcUhPTXRTeHZYVjhEVlFqU2lqQzZsWHhSNDVCSDZBL0lrTmRk?=
 =?utf-8?B?RzJUUm5yUHZ4M0tPVkYxT3RwSXRRcFNxYXFCU3ZzTzAzYmxEM2dYamUxaWpw?=
 =?utf-8?B?UWcxL3VINjBuZjMvdGpuOEtLNks4amdrSUN4SnpXZkdRNEpIdW8vMWFIZWdT?=
 =?utf-8?B?RHgxSGt2UlJUTCsydjVzdE5WN1lzeWlSQ1Q4WmozZElnTEhIZXRiM0dsRHBk?=
 =?utf-8?B?U0h0MnBzYVlBV3pldklrakJoSitUYU9OV3BUT2doRWxoUkM0ZDFHMEZNRTZk?=
 =?utf-8?B?MnA5Wnd1M1NFVmdaY01iM1JJeGVsc1BwVmVBd2k4ZC80TUV4OEVUMHE3enlD?=
 =?utf-8?B?aGo5K3FieSt1cG9tdlU2eGl3RERlVXVVKzVDVFhDSnJqTXIranpHYm1Mb1hF?=
 =?utf-8?B?MGtHQTd4dUVjWWw1aVJObjA5V0s5Sm0wTFV6SmZ3ODVFNDZMM1UyY2JIWkFR?=
 =?utf-8?B?ZFB2d1ZtVndpUVlaOEZ6QzVBVUJsR0dRUG5BbWNjMXh2OVFoLzduN0QzbEla?=
 =?utf-8?B?aUgyb01zWTNqQXMyWWhJTThOTlVxRTU0YkxNeFNPYVdCZC9ERjJyUHcxaWl1?=
 =?utf-8?B?alpIUVgzdjFlUENXbCtjYVF5NEh5dEtYRjdhYmFPRFRORnJ3NHZnd1JpbG15?=
 =?utf-8?B?TUN0ZXJGZTg1WWFvZTJvekRqMlNlY2R5L1lHRm1lVmxMUDJwYzlqZy9BRDNx?=
 =?utf-8?B?TFE3QlBHbXhaVnJVV05tVzFNZ3p0ZENzVkgwM2tZSlJQZDl3WEUzNW1rcWJN?=
 =?utf-8?Q?FhaASo2wC8MVBu0jwcieFF5MLUTGYzi0YtzyhzH0ObTE7?=
x-ms-exchange-antispam-messagedata-1: IGNhqEEPYHXaDn4PsV2Uy54Ct1LOzb3DswM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <232436DE78FB0348AAE3695C39C6EB66@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: i6pZ3AcHHL+i4FXcFYF4buqyjl2Ao2q7AulyhTq1CInPZX3+OPD0HEEl++bFNzYtCOwtKke0X6ok/QtrQKCgRUS7CkuMzrza9AC0pq5pdTN8H1wzQmQcomy7CU3Ztd1fEplleUrq1n0t7HfP4Hw+tG8J04qtw59WFs4XCltcM2Jfcwvt1iXcvu8Icm/OWeAsu44Hhkhp7xIijdZ4qnrvnBX5TJB6Cs+dKu9SfGzGnp0ToySYnTZm24Jg4iTav0kUsHpDYZH88SL/c9RA2Hxl1zPsR9JHA67XyRb5VaAwNzTxkXmZbMKsnzw3UQHUv7oDMkm2+p6ExqY6oFFaUHtKcA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Uu5UYSDxBSwDGbrx8KCgPKJlx8AaGSaSAlutZCxzeTQxoh6HnZHw/MFlswVaNhb/ITeJvrgio22MXHA5HQg5X6+AypfOolNZ++XhYSdJcQgfc/XjfxoJ69BL/VkTPjaj5x4vDRjGAj/2PmAqdExXOR4IeI1imxM+WvCrq3iO0BGuYXrNHwEBWCdnPr/Aju/9gUszx7X2OYU/WUm13NK8TCsReOXZOR/VfhA3k7lfGc2BxQtr1bJ6ft0hCRVuF3QbhGvM8Na7DjowPl2A8p74oy2quIDnfrL5od9bqz3gDyftMUFVQyZ0UpGAaE+98lGxPE/3fxZ4/vMSmJp71ER0zNFT2yYao7b1WWZ9d3T+9+/rzmT3uWa83vJpGfNBtC8QkCZRavYGETJN/yAm0OBTk/p+O79KsORz2OKkkl2lP7t986paOV/mer8CCQTWiZyKMToWpya1zJ/Dc0Dp+5d+oP8v+SwOGn271ahJUVN4AbmQdJx8cHJOJ3GYcgfIskV8X//upyPqmb3/3PM29HOk5HY/mbiBTmofrUR2hFqDo6U34wRgdkCQPf/20cxPAigAEFkIN2I5fFQainvVzoPjQyVZOJFmAjio7bPHCPPGDCgPjpg4nx2CImTHyMaq6Hey
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef4608c-7e08-4e1d-8b34-08df4905d738
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 02:02:34.3941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hBM6k/hqGT1uCGpwEAQ3c/ZxQ7F4CEczTb1tx8cNkVh/bikdfZ6KalUk5h24WQsbRJ2YVepEP2wfEmd0/rlSqQY3mByxqEytSz7956cKIzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7485
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=780e1cc66=Alistair.Francis@wdc.com;
 helo=esa6.hgst.iphmx.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gRnJpLCAyMDI2LTExLTEzIGF0IDIxOjQ5ICswMDAwLCBDaHJpc3RpYW4gUy4gTGltYSB3cm90
ZToKPiBUaGUgcmlzYyB2IHByaXZpbGVnZWQgYXJjaGl0ZWN0dXJlIHNheXMgdGhhdCBtc3RhdHVz
LlNYTCwgVVhMLCBUU1IsCj4gVFZNIGFuZCBNUFJWIHNob3VsZCBiZSByZWFkLW9ubHkgd2hlbiBT
LW1vZGUgb3IgVS1tb2RlIGFyZSBub3QKPiBwcmVzZW50Lgo+IAo+IGNoYW5nZXMgaW4gdjQ6Cj4g
LSBDaGFuZ2UgdG8gcGF0Y2ggc2VyaWVzCj4gLSBNaW5vciBjb2RlIGNoYW5nZXMgaW4gdGFyZ2V0
L3Jpc2N2L3RjZy9jc3IuYywgaS5lIGFkZGluZyBuZXcgbGluZQo+IGJldHdlZW4gc3hsIGFuZCB1
eGwgYW5kIG1hc2sgVFNSIGFuZCBUVk0gYml0cyB0b2dldGhlcgo+IAo+IExpbmsgdG8gdjM6Cj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1yaXNjdi8yMDI2MTExMjIwMjM1Ni4yMzk4MC0x
LWNocmlzdGlhbnNsaW1hQHByb3Rvbi5tZS8KPiAKPiBjaGFuZ2VzIGluIHYzOgo+IC0gRml4ZWQg
Z3JhbW1hciBtaXN0YWtlcyBhbmQgbm93IERhbmllbCBjYW4gYmUgY3JlZGl0ZWQgY29ycmVjdGx5
IGJ5Cj4gdGhlIHRvb2xpbmcKPiAKPiBMaW5rIHRvIHYyOgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3FlbXUtcmlzY3YvMjAyNjExMTAyMzI2MTQuODMwNTAtMS1jaHJpc3RpYW5zbGltYUBwcm90
b24ubWUvCj4gCj4gY2hhbmdlcyBpbiB2MjoKPiAtIERvbid0IGNoYW5nZSBiaXRzIGluIHRhcmdl
dC9yaXNjdi9jcHVfYml0cy5oCj4gLSBBZGQgY2hlY2tzIHRvIFMtTW9kZSBpbiB0aGUgbXN0YXR1
cy5TWEwgYW5kIFUtbW9kZSBtc3RhdHVzLlVYTCBpbgo+IHRoZSB0YXJnZXQvcmlzY3YvY3B1LmMg
ZmlsZSB0aGF0IHdlcmUgc3VnZ2VzdGVkIGJ5IERhbmllbCBpbiB0aGUKPiByZXZpZXcgWzFdCj4g
Cj4gTGluayB0byB2MToKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LXJpc2N2LzIwMjYx
MTA0MjIzMDQ5Ljg2Mjg2LTEtY2hyaXN0aWFuc2xpbWFAcHJvdG9uLm1lLwo+IAo+IFJlc29sdmVz
OiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS93b3JrX2l0ZW1zLzQ0NTYK
PiAKPiBbMV0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LXJpc2N2LzIwMjYxMTA0MjIz
MDQ5Ljg2Mjg2LTEtY2hyaXN0aWFuc2xpbWFAcHJvdG9uLm1lL1QvI21kZGJiMzRhM2VhODM3ZTNj
NzA3MTMxYTJlMzU0YzYzYzk4OWFiMDI5Cj4gCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIFMu
IExpbWEgPGNocmlzdGlhbnNsaW1hQHByb3Rvbi5tZT4KPiBTdWdnZXN0ZWQtYnk6IERhbmllbCBI
ZW5yaXF1ZSBCYXJib3phCj4gPGRhbmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20+CgpSZXZp
ZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPgoKQWxp
c3RhaXIKCj4gLS0tCj4gwqB0YXJnZXQvcmlzY3YvY3B1LmPCoMKgwqDCoCB8IDEyICsrKysrKysr
KystLQo+IMKgdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYyB8IDE3ICsrKysrKysrKysrKy0tLS0tCj4g
wqAyIGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCj4gCj4g
ZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHUuYyBiL3RhcmdldC9yaXNjdi9jcHUuYwo+IGlu
ZGV4IDE1YzI3ZjRjZTQuLjUwYmRmYmUwMjUgMTAwNjQ0Cj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L2Nw
dS5jCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdS5jCj4gQEAgLTk5Nyw4ICs5OTcsMTYgQEAgc3Rh
dGljIHZvaWQgcmlzY3ZfY3B1X3Jlc2V0X2hvbGQoT2JqZWN0ICpvYmosCj4gUmVzZXRUeXBlIHR5
cGUpCj4gwqDCoMKgwqDCoMKgwqDCoMKgICogVGhlIHJlc2V0IHN0YXR1cyBvZiBTWEwvVVhMIGlz
IHVuZGVmaW5lZCwgYnV0IG1zdGF0dXMgaXMKPiBXQVJMCj4gwqDCoMKgwqDCoMKgwqDCoMKgICog
YW5kIHdlIG11c3QgZW5zdXJlIHRoYXQgdGhlIHZhbHVlIGFmdGVyIGluaXQgaXMgdmFsaWQgZm9y
Cj4gcmVhZC4KPiDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiAtwqDCoMKgwqDCoMKgwqAgZW52LT5t
c3RhdHVzID0gc2V0X2ZpZWxkKGVudi0+bXN0YXR1cywgTVNUQVRVUzY0X1NYTCwgZW52LQo+ID5t
aXNhX214bCk7Cj4gLcKgwqDCoMKgwqDCoMKgIGVudi0+bXN0YXR1cyA9IHNldF9maWVsZChlbnYt
Pm1zdGF0dXMsIE1TVEFUVVM2NF9VWEwsIGVudi0KPiA+bWlzYV9teGwpOwo+ICvCoMKgwqDCoMKg
wqDCoCBpZiAocmlzY3ZfaGFzX2V4dChlbnYsIFJWUykpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBlbnYtPm1zdGF0dXMgPSBzZXRfZmllbGQoZW52LT5tc3RhdHVzLAo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgTVNUQVRVUzY0X1NYTCwgZW52LT5taXNhX214bCk7Cj4gK8KgwqDCoMKgwqDCoMKgIH0K
PiArCj4gK8KgwqDCoMKgwqDCoMKgIGlmIChyaXNjdl9oYXNfZXh0KGVudiwgUlZVKSkgewo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudi0+bXN0YXR1cyA9IHNldF9maWVsZChlbnYtPm1zdGF0
dXMsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBNU1RBVFVTNjRfVVhMLCBlbnYtPm1pc2FfbXhsKTsKPiAr
wqDCoMKgwqDCoMKgwqAgfQo+ICsKPiDCoMKgwqDCoMKgwqDCoMKgIGlmIChyaXNjdl9oYXNfZXh0
KGVudiwgUlZIKSkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnYtPnZzc3RhdHVzID0g
c2V0X2ZpZWxkKGVudi0+dnNzdGF0dXMsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBNU1RBVFVTNjRf
U1hMLCBlbnYtPm1pc2FfbXhsKTsKPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L3RjZy9jc3Iu
YyBiL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMKPiBpbmRleCBhZjQ0NGUzZTZmLi4zOThlMzEyYzlh
IDEwMDY0NAo+IC0tLSBhL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMKPiArKysgYi90YXJnZXQvcmlz
Y3YvdGNnL2Nzci5jCj4gQEAgLTIwODEsMTggKzIwODEsMjQgQEAgc3RhdGljIFJJU0NWRXhjZXB0
aW9uCj4gd3JpdGVfbXN0YXR1cyhDUFVSSVNDVlN0YXRlICplbnYsIGludCBjc3JubywKPiDCoMKg
wqDCoMKgwqDCoMKgIHRsYl9mbHVzaChlbnZfY3B1KGVudikpOwo+IMKgwqDCoMKgIH0KPiDCoMKg
wqDCoCBtYXNrID0gTVNUQVRVU19TSUUgfCBNU1RBVFVTX1NQSUUgfCBNU1RBVFVTX01JRSB8IE1T
VEFUVVNfTVBJRSB8Cj4gLcKgwqDCoMKgwqDCoMKgIE1TVEFUVVNfU1BQIHwgTVNUQVRVU19NUFJW
IHwgTVNUQVRVU19TVU0gfAo+IC3CoMKgwqDCoMKgwqDCoCBNU1RBVFVTX01QUCB8IE1TVEFUVVNf
TVhSIHwgTVNUQVRVU19UVk0gfCBNU1RBVFVTX1RTUiB8Cj4gLcKgwqDCoMKgwqDCoMKgIE1TVEFU
VVNfVFc7Cj4gK8KgwqDCoMKgwqDCoMKgIE1TVEFUVVNfU1BQIHwgTVNUQVRVU19TVU0gfCBNU1RB
VFVTX01QUCB8IE1TVEFUVVNfTVhSIHwKPiBNU1RBVFVTX1RXOwo+IMKgCj4gwqDCoMKgwqAgaWYg
KHJpc2N2X2hhc19leHQoZW52LCBSVkYpKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoCBtYXNrIHw9IE1T
VEFUVVNfRlM7Cj4gwqDCoMKgwqAgfQo+IMKgCj4gK8KgwqDCoCBpZiAocmlzY3ZfaGFzX2V4dChl
bnYsIFJWUykgfHwgcmlzY3ZfaGFzX2V4dChlbnYsIFJWVSkpIHsKPiArwqDCoMKgwqDCoMKgwqAg
bWFzayB8PSBNU1RBVFVTX01QUlY7Cj4gK8KgwqDCoCB9Cj4gKwo+IMKgwqDCoMKgIGlmIChyaXNj
dl9jcHVfY2ZnKGVudiktPmV4dF96dmUzMngpIHsKPiDCoMKgwqDCoMKgwqDCoMKgIG1hc2sgfD0g
TVNUQVRVU19WUzsKPiDCoMKgwqDCoCB9Cj4gwqAKPiArwqDCoMKgIGlmIChyaXNjdl9oYXNfZXh0
KGVudiwgUlZTKSkgewo+ICvCoMKgwqDCoMKgwqDCoCBtYXNrIHw9IE1TVEFUVVNfVFNSIHwgTVNU
QVRVU19UVk07Cj4gK8KgwqDCoCB9Cj4gKwo+IMKgwqDCoMKgIGlmIChyaXNjdl9lbnZfc21vZGVf
ZGJsdHJwX2VuYWJsZWQoZW52LCBlbnYtPnZpcnRfZW5hYmxlZCkpIHsKPiDCoMKgwqDCoMKgwqDC
oMKgIG1hc2sgfD0gTVNUQVRVU19TRFQ7Cj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAoKHZhbCAmIE1T
VEFUVVNfU0RUKSAhPSAwKSB7Cj4gQEAgLTIxMTEsMTIgKzIxMTcsMTMgQEAgc3RhdGljIFJJU0NW
RXhjZXB0aW9uCj4gd3JpdGVfbXN0YXR1cyhDUFVSSVNDVlN0YXRlICplbnYsIGludCBjc3JubywK
PiDCoMKgwqDCoMKgwqDCoMKgIGlmIChyaXNjdl9oYXNfZXh0KGVudiwgUlZIKSkgewo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBtYXNrIHw9IE1TVEFUVVNfTVBWIHwgTVNUQVRVU19HVkE7Cj4g
wqDCoMKgwqDCoMKgwqDCoCB9Cj4gLcKgwqDCoMKgwqDCoMKgIGlmICgodmFsICYgTVNUQVRVUzY0
X1NYTCkgIT0gMCkgewo+ICsKPiArwqDCoMKgwqDCoMKgwqAgaWYgKHJpc2N2X2hhc19leHQoZW52
LCBSVlMpICYmICh2YWwgJiBNU1RBVFVTNjRfU1hMKSAhPSAwKSB7Cj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIG1hc2sgfD0gTVNUQVRVUzY0X1NYTDsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdmFsID0gcmlzY3Zfd3JpdGVfdXhsKGVudiwgdmFsLCBNU1RBVFVTNjRfU1hMKTsKPiDCoMKg
wqDCoMKgwqDCoMKgIH0KPiDCoAo+IC3CoMKgwqDCoMKgwqDCoCBpZiAoKHZhbCAmIE1TVEFUVVM2
NF9VWEwpICE9IDApIHsKPiArwqDCoMKgwqDCoMKgwqAgaWYgKHJpc2N2X2hhc19leHQoZW52LCBS
VlUpICYmICh2YWwgJiBNU1RBVFVTNjRfVVhMKSAhPSAwKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIG1hc2sgfD0gTVNUQVRVUzY0X1VYTDsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dmFsID0gcmlzY3Zfd3JpdGVfdXhsKGVudiwgdmFsLCBNU1RBVFVTNjRfVVhMKTsKPiDCoMKgwqDC
oMKgwqDCoMKgIH0K

