Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A12A606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 02:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=DX7MruSh;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=WFfWxcc1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJj00-0007vH-QY; Wed, 21 Oct 2026 22:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJizq-0007um-64; Wed, 21 Oct 2026 22:57:39 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJizo-00068C-E9; Wed, 21 Oct 2026 22:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792637856; x=1824173856;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=B1ZDhTZJkZyT1OzzUlC7Fcx3FcePo89rWqaUGeIXa1M=;
 b=DX7MruShUamKHd4luo7TYpHTwhA5eZuCrAeCud3qNbeKJrAzzcMSVIEa
 JMCP+IChjf3AN0ZEHBAiSyNH2EififmLT/xl4lqeA4+nWPHpWWw3IXgDY
 gDfD2psLTV8guit2sah/CbXVUlkShUziA144GS4OWwaXx3jYG8GbTj+Lg
 b0U0qR2FAd+pdbcikMR1uD9BSeWLoB0/xOgDtnLF6FHa6kAggh1vBubDc
 ciQYiQbIf4X3Oma9cutBI5aQwA8Ibzk8sfO3vTLHEZtB4kavsM5dDfaup
 ST9Vo2tih+2OdTgZMZdTsVFzmqCr+2LpY4QSl1dxxUJK4MNu9gdQ7e0bs Q==;
X-CSE-ConnectionGUID: zWnxtneIQPG5+yoipzQrAw==
X-CSE-MsgGUID: KivMWXXBS1K0KPjiyHbPgg==
X-IronPort-AV: E=Sophos;i="6.27,171,1786982400"; d="scan'208";a="158594051"
Received: from mail-westcentralusazon11013040.outbound.protection.outlook.com
 (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.40])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Oct 2026 10:57:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HlmEwqaVnPbYYXIYfMsqskvLGHReyWlmr/gFPbf+doZo7Bf6tno4fS5Y/FVkb9x7uOV4tI+oveQwAcEuFnBYgq5PmXjpUlw1d4onA6u9UYlbRTku1KMFV0NyvxKyu7FiZM2vULEiuyZ/PgPzieS2G55P5GlXZsSFuy7YnIWF9Twb/3BHogPimoE5UMKkIGa/cr59EximCMG8Xjs3QIVHACQyhoQKAYVpDIAU5pksZHgtm6BhK1NHuT/Aw7I2PYuZr/8ur4CPmGyCgKEkJAWaEQ02BZAMk3dgTjHbdjggO4HECc/5H5khG0pk2P5YxHlZp7E/V/UVcXXUzTdjTkT4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1ZDhTZJkZyT1OzzUlC7Fcx3FcePo89rWqaUGeIXa1M=;
 b=Sd7jIGEBbNOA9gMY52ZP7GpWMABlhVAXjWya5/a8f1eHub83DEPrUvYq8HhmfMS4lwGUFGszAQzJcV+N7qb1b/WMkft4mGqPiv8YKzO3QSE+s/exNxt9vDCj+vT4jFHnmQgLb8wlIjgfaZJ7Db5sa7NvHXdL4ru2MKvfp8efcdqn/kxJdeWT+j0jLbe7K1p+GF1UA0ULj3I0nk6q200vnv+PuujslK9t/DfiS2Sh5iRJmqPCvrbPTr0cfeMZk/FLroNPJqKtOrvh6uaRS+44CPHCXiywgwW2u+z3arQZ9Gb7lTUf6zmdWGG+QXGETIQOlONJ0jOjSYgxc0s49T9eHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1ZDhTZJkZyT1OzzUlC7Fcx3FcePo89rWqaUGeIXa1M=;
 b=WFfWxcc1772VcEKHQNEVUPQW2MHKehGC84XwJBSKXr1DFAQSrwbHxgOg5fpJ0QVnEkYkDb7URer84vYDWZPTU3bihTxW+1XXLv4I9CvTWA+sl1WoleGVBWWD1lESrXtuaKeDSeQmO360TsGUcLgO6f8P+JlncNy0fh6bq9SUj1g=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by BY5PR04MB6437.namprd04.prod.outlook.com (2603:10b6:a03:1e4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 02:57:32 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 02:57:32 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "wangyang25@otcaix.iscas.ac.cn" <wangyang25@otcaix.iscas.ac.cn>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "zhiwei_liu@c-sky.com"
 <zhiwei_liu@c-sky.com>, "liweiwei@iscas.ac.cn" <liweiwei@iscas.ac.cn>
Subject: Re: [PATCH] target/riscv: make mnstatus.MNPELP writable with Zicfilp
Thread-Topic: [PATCH] target/riscv: make mnstatus.MNPELP writable with Zicfilp
Thread-Index: AQHdXHwDhlPEbQlf9UWuFJ8xJpVsCLcI6S8A
Date: Thu, 22 Oct 2026 02:57:31 +0000
Message-ID: <762caae2baa561707f90ab52c956936c5a0b3979.camel@wdc.com>
References: <6AD0895A.0F1C22.05843@cstnet.cn>
In-Reply-To: <6AD0895A.0F1C22.05843@cstnet.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|BY5PR04MB6437:EE_
x-ms-office365-filtering-correlation-id: fe4ca115-115e-4d4f-d8a3-08df2fe8377d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|376014|1800799024|366016|19092799006|18002099003|22082099003|38070700021|11063799006|261009223027099003|10067099003|261021121427099003|56012099006;
x-microsoft-antispam-message-info: vihLsU4crskRmnEKqtL1xzSPRFvWPIW9/XbD4o8+W5voQv9/IjIKLlwgUSlsxF3Jvszza/wqfA+/1kfw0M5kERmDjGrbbJ/1cgqDa5FsR8XuvRK82BziXAgsfRN7aXyZGNzxr5Fz5qp3QfwfLse4pmsOImxeIN/h57Os988CPPmCI4iVHnudtkdqAVggX4AkDnbaknTAjdH/oWSmYKYtNLPYOLHgub+Yb2gk0W5u1Z8VHsh9Prg9gksoNUq0e1W+WxNOisKhccfKVr1waAHv3NQHpHf2HrD1YSHwHahoJStRwoCBYMsD5M0OXen7FGTGxdSkPcIZ0j0LJFdbNV8cao29NQFFLuM+lRqPklEar/2/eYpwxIkp7ynxfF5Mk20EjoarZnIkKE3XhIjVyrAF+DrEp66PKvP5U7fdwVqCXyhunYM2t4abHSahnfqnlSMBmQgdXh3Whu2S3Q6/jrTFLzEJsVk2ijrj9J0oh1SczG1aRZPAZbZA938o3FEA9QmBPGYEvLe0jfW3NCsl4rvx0NFLZfXaXaKLAcvjdos0VVFrK/jr8bFtY5a5qVtvqLHurFUhj3KAgC7SXnec39K0pna5vWtGL343ZseOlJHoaMbX+6l/yW1d1d+iP4JHDJ/ae4yipZ0wsjDDv7CE1c7/ESD4yRT5kptc5js8gBcFaHmZzEtLNM5bzySoCz2d9uehup8wqx6Ndhr/UEz9Qwe1l3n8YkRcLMtify6ZNkuaCQY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(376014)(1800799024)(366016)(19092799006)(18002099003)(22082099003)(38070700021)(11063799006)(261009223027099003)(10067099003)(261021121427099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFNCc1VSN1lVSmhmQzBQM3dQcithTGRFbGdWcmZpMG1lUzZmVFhrSlRhbXJB?=
 =?utf-8?B?RERaT0pYVFhJajFjVmdPNko3dDJqMzNzQmJhYVZ3VHRmMDcybW9KQzliR0Fv?=
 =?utf-8?B?T2thUUtRaWpybU54TUltbkJZUmk0bk5KeGYxa3RNQ0JZQmJQQVpRRlhSYytT?=
 =?utf-8?B?WjJ6RnBpN3Z6N2xWTGh3RXRlTGxqalU5bmFIVExrOGx2eGVTOXVEbjhPaFhH?=
 =?utf-8?B?NUFMcExJM2JCUVQwelM0QkE5OHYyTlhQbTRhYjFsajZLR0kwTllQM01uNWJn?=
 =?utf-8?B?Vmx5RFFhRWVtRXBpT0JpR0FTYzVSL2hSL25VVEhJWXdhQ0lDZTRibkVqRG5E?=
 =?utf-8?B?aGR6TU16S2FldnFqdXZhWHZ3YTNHUW8zWUVPZlJjeG5kekZHZTFmT1JQNmlG?=
 =?utf-8?B?VTNvckIxYWJHamlVSkZEZEdqalJ1N3FtcHFPVGZFVWpRSGg2cDZNQktmMXNw?=
 =?utf-8?B?cDRibUpoTVlxcUlIa21aMzhONHZhcHZPenowck5VQ210U1RjdXpKTGpYMkZE?=
 =?utf-8?B?Vy9nQnl5U2tnQVN4cFZMdWZndjhJSHNHTE1xMlVLbHY5clZJeHF1bklDanQ4?=
 =?utf-8?B?R2xUdmtYV0FLdDdad200dXhzdkNSeHlMamxKK2xuRCtKM3kwOWdIbTlveXBE?=
 =?utf-8?B?ZjcvYTJRZS9QeTF2QVNNdDZlOVp1S0taMEo3MDZTWm5NQSt0czNENkp3YVdz?=
 =?utf-8?B?aG83Y2s4cmRTUXR2eGV0RFVKajAzajlyblJBL3B4cjk1ZEhKa0NYT0dJcUJL?=
 =?utf-8?B?ZURSQ3l4N0NsVkRCM2RSV2U3amtPRG5rQ1V2dWNuK3dxTHNRTW4yVEdTY3hR?=
 =?utf-8?B?QVpEU2pNMFNob0hFUG1IYk9tanBkdDJqT0VRb1BuYlJpbjdoZGdrUE5XZXlL?=
 =?utf-8?B?MENzT3lOeUFFY0kvY1VwUU1NZTRzaDZ4cTNvdC9UQnYyM3laUldRRHNDaTIx?=
 =?utf-8?B?OEMvUDJiVHlWN3pMV0QzbTZybHNvSyt6K1ZRdVdDOE1iK1o5NXhrNHo3Mk9U?=
 =?utf-8?B?N0VPK29vdE5OWnJVc1ZMbzVNMlBaOFc5UC9wK3JLV1Y2cTdTdzlDKzhJaFha?=
 =?utf-8?B?Q2ZRTGRwTDVETzRaUWtFRFl6ZDJPWXhZWU00bURHZlM0NG1ieXIvTXRhU0Iy?=
 =?utf-8?B?aVl5R2V3SkxoZjhVL3RpbFhaTmlIMzMwU2lGWmw5L2ZlZHhHT0R0MDRJZHdW?=
 =?utf-8?B?S3VEUTlhOUpOMnkwUEZTTHo5Z3JZUno5WUhXcERFR21XbVc2T2VaTXl5TThk?=
 =?utf-8?B?V3dmWmZjeFVyVk8wVmFQbStGdWxsTXZRcHlWdGdpdjZFd2w0cVZhNXlnek9m?=
 =?utf-8?B?d2R2eHRNOFZlMVhOKzVjMHpTbGRFVnkzUlFGTzVUME5hakxySFJlOXo4WERs?=
 =?utf-8?B?N3poek5TeG80UlpwMUh5WUtVS2FHdE5GalBackNzT2VVbWRWM3VFTVNUV1VJ?=
 =?utf-8?B?WlN1Y2tDTUN6V1hTb3FVRTBUdWVXSW55S3phWHN3S1hDOG11eW9DanFPc1Vk?=
 =?utf-8?B?ZHczOFY5QUdtZXJRTkpqdXVYelJqK2FTQ1MxRGI4R0gybTNTOE1QK2V4Vml1?=
 =?utf-8?B?dDB2eG9wOWp5NytPblJwVnR5YkVUbkYwblIwd1FkenMyOGNIK0NadmUwenpx?=
 =?utf-8?B?ek9QeGcwQlhNM2RMbXNnaG5jNTROUlozVW94Wi9KMS9jUVdkOHJKQ2pxVnQx?=
 =?utf-8?B?ZXE0eUdWSFZ4Y09WdHRzNDl0T1hMTjAxdmczblNYZkFMM2VzRzhHS3l6WGxV?=
 =?utf-8?B?V2FvV3VYWWVWaXhKRUpwdlJoZ0l4OEtDb0NOQ0dZRW05cC80N0xvYWJWbkpF?=
 =?utf-8?B?Tjl1UkhzYVZRMmFWcGRSQzBvck5UZXVXM05VdDViUmFZa0NJYnhDUHc0OTJq?=
 =?utf-8?B?eGgxWXRXTDhITDBITE5LQzFvUHg3MDZuNU5qNXhrcy92WW1iVkVWQmFLc0hR?=
 =?utf-8?B?ZVhzWGRSenVwRld5aWp1NEo4NFBLK2pFekpwREtReHZOWXFtT3ZxSUZ4ZXlr?=
 =?utf-8?B?QjNTZVRxcndDUzIrZ0h4SHU0N3NLanZPMTVJb3BqcDlyWmRiTm9JNFViMFRh?=
 =?utf-8?B?SjZ4Q282NjdzcENCbU5wTnJNQ2ZyaEdLNDl3WGxUeUdpcDAzbzNsSmNFZDh2?=
 =?utf-8?B?YWJLVkN0YktQQjZXaFBYVEd6QjNVY3dqYmloQXBJTTlRN0V5Q1JlRWRReTJ2?=
 =?utf-8?B?Q2hKVklKV0M0clNQWXJiVUtleFl0bkE2U2w5RklBL2htSXJ6MHpwLzZoQ2Js?=
 =?utf-8?B?d0JJVUVCUEZGRDkzNFRabzN3WWVsRWU2OCs3OUJjaXV6YjcrMnY4SzBKeXNG?=
 =?utf-8?B?NVJVSUQxTS9PbVFubFl2U3pUL1pjZlJtbzViQmR0QmdaWVFoUjlyZ3g4a0lX?=
 =?utf-8?Q?0Eret6JculumuhZo2x79s2u7nmvyvXjyvHc/CQ+OXz8MF?=
x-ms-exchange-antispam-messagedata-1: jNZtRZWZCA5EOr0q0+Q6dSCBeZL0UIIpbJc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1D9FB67C649104F933DA8202157FC3E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CIjaaGYB+8X3OP8XvUe0B8+dQk7nRPTZHokOTwpWO/pjnh14L8ujxW7TuHbXwZMpgInkUwfpwlb/eKJ2JXwzQ4W4N8vuY+XmvpIxetfEqjRm5daoSRtdWkM1fWiJtskae2ib7rM6U/dbNfu43iBI3C9o4Su7o/VKSC05tchIkwXbi7v0HW+r784MLkhZ4ImyncWE2fr7H1SMdxXafWyfSrss7awOSQSha8fAA4m3FiEmBD/SGQf2emgGdXtUZ07+omR2wBL1QJVn9qrGH5Ayn8uzTSfBipz7INCnewNOKdUFHdQDdFokfV7HKC2CTsFwfcH5x4IyCkcLivfMcnP2yA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rxrSa0GRG/x8yLP5xp12EZKQ638aY7/JDG0U9T5YjFLuTMBn/B/PAQmkQoFLbrAM8jZIkgY5QEYL+s35aN8jTwVY1lXeINj9a2PSDR6ZkbHEeGUSebnxX/OlKiKIi4lJKKC1ImXwEKdVHGefXLm0KapiNze1+82JWxdLvFR1Nna2c+zIvVyVPqc9eYFiLn44lx8CIP+m01pmGdpbFesz4PhpWKFdrTLVwjEoiUDFpuJccBfrCYMNGy0IvCO166ScXrZa5Yuzy284sgay4ddmzEgXa2Sde+nrXaglp+6TBYS1B1VfB7W9C0kusERwM33D3C469WGmy13Yz1Kpjb+SUwOWd+YX861AoUslr73883A4LfRK94+MrBY0r6nME5esmt7hhxdK8ydCLrVsaJ2jc5LODYrG2qkecnBTXw+HzF0ejD83lJQAmi8dI2Dw0L7URyCQylic/1xSTiaPkWTDGLp6yXZ5xb0uqgwmnbDBYEQmEcGA4d/hmxyZ+9Ihcs33Y7MN81nvcY5uS2R2v63zjsVD4s+ffreqwZfYJzcaIo0XOXu1efANlB56Ck4+LDLngxFcYH0UaH64bttRSQ3Un3aXHtFCpJUmnsxQQCp06FRCrPdDCI80/ws9vyKVYZhz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4ca115-115e-4d4f-d8a3-08df2fe8377d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 02:57:31.9737 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfTcs+jGMeUgI/TcyACIM1BE1bfHj7qXMSIA9+KJbZHta5gBmNQAyV5t7nZBzNpAJkVPQI6H8ysC8lkoscBWZZkGX+K9Z/erl2KDfDFBzBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6437
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=748e7da1e=Alistair.Francis@wdc.com;
 helo=esa1.hgst.iphmx.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTEwLTE1IGF0IDA4OjA1ICswMDAwLCB3YW5neWFuZyB3cm90ZToNCj4gWmlj
ZmlscCBhZGRzIE1OUEVMUCB0byBtbnN0YXR1cywgYW5kIE1OUkVUIGNvbnN1bWVzIGl0IHdoZW4g
cmVzdG9yaW5nDQo+IEVMUC4NCj4gSW5jbHVkZSB0aGUgZmllbGQgaW4gd3JpdGVfbW5zdGF0dXMo
KSB3aGVuIFppY2ZpbHAgaXMgaW1wbGVtZW50ZWQuDQo+IFJlc29sdmVzOiBodHRwczovL2dpdGxh
Yi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS93b3JrX2l0ZW1zLzQyMjINCj4gUmV2aWV3ZWQtYnk6
IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogd2FuZ3lhbmcgPHdhbmd5YW5nMjVAb3RjYWl4LmlzY2FzLmFjLmNuPg0KDQpUaGFua3Mh
DQoNCkFwcGxpZWQgdG8gcmlzY3YtdG8tYXBwbHkubmV4dA0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0K
PiDCoHRhcmdldC9yaXNjdi90Y2cvY3NyLmMgfCA0ICsrKysNCj4gwqAxIGZpbGUgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L3RjZy9jc3Iu
YyBiL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMNCj4gaW5kZXggMDYxYmM5ZC4uZmRiNTViOCAxMDA2
NDQNCj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYw0KPiArKysgYi90YXJnZXQvcmlzY3Yv
dGNnL2Nzci5jDQo+IEBAIC01NTg0LDYgKzU1ODQsMTAgQEAgc3RhdGljIFJJU0NWRXhjZXB0aW9u
DQo+IHdyaXRlX21uc3RhdHVzKENQVVJJU0NWU3RhdGUgKmVudiwgaW50IGNzcm5vLA0KPiDCoMKg
wqDCoMKgwqDCoMKgIG1hc2sgfD0gTU5TVEFUVVNfTU5QVjsNCj4gwqDCoMKgwqAgfQ0KPiDCoA0K
PiArwqDCoMKgIGlmIChlbnZfYXJjaGNwdShlbnYpLT5jZmcuZXh0X3ppY2ZpbHApIHsNCj4gK8Kg
wqDCoMKgwqDCoMKgIG1hc2sgfD0gTU5TVEFUVVNfTU5QRUxQOw0KPiArwqDCoMKgIH0NCj4gKw0K
PiDCoMKgwqDCoCAvKiBtbnN0YXR1cy5tbmllIGNhbiBvbmx5IGJlIGNsZWFyZWQgYnkgaGFyZHdh
cmUuICovDQo+IMKgwqDCoMKgIGVudi0+bW5zdGF0dXMgPSAoZW52LT5tbnN0YXR1cyAmIE1OU1RB
VFVTX05NSUUpIHwgKHZhbCAmIG1hc2spOw0KPiDCoMKgwqDCoCByZXR1cm4gUklTQ1ZfRVhDUF9O
T05FOw0K

