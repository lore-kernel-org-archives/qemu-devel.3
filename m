Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE71606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 02:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=oKFAwEKk;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=QSZ6FDwa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJj0y-0008K5-St; Wed, 21 Oct 2026 22:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJj0u-0008Jo-VX; Wed, 21 Oct 2026 22:58:45 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJj0r-0006A8-M3; Wed, 21 Oct 2026 22:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792637921; x=1824173921;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=uk0pN1bZ00pGrqdeWtCwFqkAf/iXVVVAA2dVZE90L+Q=;
 b=oKFAwEKkUdD39kRULR8q+JCKcwVfjABBAU0rxhm9dJhTZcj/aHNuBvS/
 GwkigY5yZb95qonX9mzWBATAs1NhO2X2SK0TfkH117ksUNR53+yH9xgl4
 4Bm0QUNNSKxmoV3bCotJaClZXNwjGooPNHjxsEaLggkLvrfr233fT8aXZ
 PN6pVGm5rOSEBKOlQmt4ZjT4MPxdKWYrNR6ixivSb+Dj+AeGbK8XFGH8N
 fuFFJJ8kRKpqCrK8l0ckecUTyUrO8QYMv1qXj+o4SJanTmDIMw3mo22dk
 Z/l2E5Y84otVU6pet6XMhQKPk2LEPqQIQ6vX33XLACTTbfsq5ChjmG7ex g==;
X-CSE-ConnectionGUID: e+9wf4SRRdq2PGfSZ8LszA==
X-CSE-MsgGUID: IKsntgX+QKaVW1QBdCstMQ==
X-IronPort-AV: E=Sophos;i="6.27,171,1786982400"; d="scan'208";a="158594145"
Received: from mail-westcentralusazon11013070.outbound.protection.outlook.com
 (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.70])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Oct 2026 10:58:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=riROkwP5telBZ3Rno6dSXYOEcHICE+K1b2pflYaUisAXZrjnlAoqm7e496gxWu0Muv12Dd2Dw6E/a0/fTsHmIcBnWvYs3Xx4Bi3B3C2sX8uQc3LSsqUqJ1oSE+wK20HA2w2WwPsOM5T7WVPXE/uGCBphVIx9BnQaTdnw7crENcXEjTMro6tSCzGdvjwC+DC7RAuzAPGSDDubZLwu+EcCagIICjd7o17pY1ebNbu9kk88iWlrC9mlo89uZdAMqkuuZ1SljrWM2j1soOHCLdGAmc0tHT3NOKa840krTHgCfXrCW5hGfzSRcAuF9W6SWtIOKOS5lBSnAmcZW8yJldbWLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uk0pN1bZ00pGrqdeWtCwFqkAf/iXVVVAA2dVZE90L+Q=;
 b=QwFRSb8u8F37OLJRqu1Yf71OqDjqV458blrteCePUteENBsalKnGvqLjGDHO8m/73pnS6qL2YZWxOLG45X5Lr2OhE09T18q2uLn2Wv28UqAhV1qoqrYVxPnpGfs2LcMbWfiAUNLuJbkfHwZPDYLKXxgHimEm6ZhRm+jKc5B9wVh7D1etvBSzJNPUHNdyeGglgpe71iWh8DTfGoI0EEytktnWUKD8a06MIAk/cUtod00LbOOhHzl+yS11uup+92H1IxxqmNX/HuoiDiJCXxxyJJo+ha7QmT4ZfOGdFnPSVcJl2ppAP66/pdAboPOcJoAZucdETkiP1JRo83m6zTB7ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uk0pN1bZ00pGrqdeWtCwFqkAf/iXVVVAA2dVZE90L+Q=;
 b=QSZ6FDwaN6ZjgEDVNt9b1UYiiKNUi7yfubug6Z2v5VjIGy65dHT/2KRyyYJYkARAtOlrcSvht/qMefMSU5NzTBj7I3taw1+1+535DyVECNIagQunxwXZxu6XR+YJRPtAu/ScGpy/OEkidXAIXfTCn5DclND2w82aj35CCWakugA=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by BY5PR04MB6437.namprd04.prod.outlook.com (2603:10b6:a03:1e4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 02:58:37 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 02:58:37 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "wangyang25@otcaix.iscas.ac.cn" <wangyang25@otcaix.iscas.ac.cn>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "zhiwei_liu@c-sky.com"
 <zhiwei_liu@c-sky.com>, "liweiwei@iscas.ac.cn" <liweiwei@iscas.ac.cn>
Subject: Re: [PATCH] target/riscv: gate envcfg CBO fields on extensions
Thread-Topic: [PATCH] target/riscv: gate envcfg CBO fields on extensions
Thread-Index: AQHdXHwMW22sB1zNikyTjki/dSp04LcI6X4A
Date: Thu, 22 Oct 2026 02:58:37 +0000
Message-ID: <3bc7791644a1a4a4717acdd9693e305ee20f3141.camel@wdc.com>
References: <6AD08960.0F1C24.05843@cstnet.cn>
In-Reply-To: <6AD08960.0F1C24.05843@cstnet.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|BY5PR04MB6437:EE_
x-ms-office365-filtering-correlation-id: a157a59e-999d-4e71-7442-08df2fe85e99
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|376014|1800799024|366016|19092799006|18002099003|22082099003|261021123027099003|38070700021|11063799006|261009223027099003|10067099003|261021121427099003|56012099006;
x-microsoft-antispam-message-info: FuxJaO9NVC3JcPzvohK61DEEckzuNuAO0l4bI5pYKpHoYnaiA96WdKfXp95Vmn2wlRfjkywsAMCroFfq96k83pKEQm3Zrfm56aLLdlaVLa/EIIJWdNvJ+CdUP9GKxW0wX6C1f3DAlj0+deYecHvoOJrmNl5Wz6e+E28IC6o1i+CwKHfd4argEb7rkYhYlouInFBJNnvKNrKjX05VenlCWrNptAcKn9Z31T9f2jDzNSftgcjmD6fQRNsl5zT+ZyUtx1gU5zZDtRuTy+RAKH2U2ibqbaV8wWP0f3PzJoWJ7K5XE0O2X3kKvdLeAGm2Xx17EXCuLpyAnFbB5yHxHSsmGqzZgAjVzFlHbqTt/oKg3CpyFOMbicVbIDMnleJMVpSt9X3O9TgjaHlF+BTo3CrbtIDtkN38HcJrXZv5IJgsXbtr5y/+NeWwZuZlAXTxseyT4/Ket8gfOzH7JuQHzDCaaomo3StzUOFV7IExdMo55A0e1NHo7vLSI4IxCXAiNi0EXFIQ8fQcTo1IaqDB4qCNuTLbmRrrr4v/HeWstdRk44EZE9HDRsYnTe28YGUqIBqN9+8H73GzWPhlB4YYzKxYHIt/A/d3SFxviXg/NqXmT63sSpl3dvzqGRXxh9z7w/5cKETpBljhv/3EIbLxS3ouegyEHqyDoV9LA2AHh22fBaSIMQcwtpzHn1UnLMusr+rx1Jlzreq1lu0t5cSHTpPddFdFc0+Id3494sd90+r6qgw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(376014)(1800799024)(366016)(19092799006)(18002099003)(22082099003)(261021123027099003)(38070700021)(11063799006)(261009223027099003)(10067099003)(261021121427099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2ZuNWNic0d4MldDY3BDMHhDRWZoclNxL3Q5ODBYSW9jYWJyUUt3R09EU3FD?=
 =?utf-8?B?bHBDNXZiYk85dDl5WHdJRGt5VmEyblRpeW1QNm8wc3NVWGtwSmV4RjFhUFhm?=
 =?utf-8?B?Ui8zTW5IbVN0L0NHU0ZvV1hrWExjV3ZZZ3hhbWF6T21iZHA0ZWxKak9MdlBM?=
 =?utf-8?B?MTUydjdvYWRMSGxKQUdqa2VrRG5yQ24vTVRndDg5aG91S3BwZDNQNTVab01C?=
 =?utf-8?B?eVJtaXRyME5oRlVIN0FqTkFDb0t0SXhselhvb2dxNnVDTm15WUs3MkdnRDZS?=
 =?utf-8?B?Wm4rR09tS0dYbmNxQnluTkRoWlJtbWxWZjlrWDNkYnkrZERiSCs2aHF3TFdy?=
 =?utf-8?B?NldyaXVSVjlKNTZjNVhrNTFvcG1xUEM3TmZIZlpqWVhMQmFwaVJSbXIvNDUr?=
 =?utf-8?B?OXNVRkNnRUY0VUNmRHNPSjVFUFM1OGRlc29maDF3R3FvaVZ0cGRYTlF0ZmFp?=
 =?utf-8?B?b0NaOUdXRVZzeENXOUp4amgxQ0F3N3NmT1l4SU5LR3ZjNU5FcjBzbk9rbTdp?=
 =?utf-8?B?YmtFWXpuTE5PZXdQNzRDK3BHUXBZaWt0Yzdsc3IzRWQvV0JVc3FPR1V5ZFRU?=
 =?utf-8?B?WTVTR25sVXZsbDVGZXVMaDFnb3NuNFFIem5XSk9lNTZsbVV3SEd6dTFOVHo0?=
 =?utf-8?B?UzA4azhtVm1UYXJHditLejYvVW1iWk5CNVphOVJ3d0VkQlp0bE56OXd1SWtB?=
 =?utf-8?B?dmJmNkNhWTg4M0xoV2JzVHBpZW50a0hUREVhK001bElEcWsrSmRUTGJiZ3NP?=
 =?utf-8?B?c1hBME1VaUY3bmdudmhlZk9EMXhTRDBMQ1ZWQjliamRzVzlmZyt6bElMZnBw?=
 =?utf-8?B?TjBLUnVZUnE1cG1KOUUrWnE4VmNDUERvQm5FcEEvMkhYRU14RVV4b3pIQ1R3?=
 =?utf-8?B?cS9ycDlWSktjZ2VlTTEvQ0ppSjQxTW8xdnZRTGdjSTcxNExaTjhDdXhibjg5?=
 =?utf-8?B?T3VjM09kWElHanQrVjQ5M0VYLzlVRkcxMlBoZ2Y2UHlrVTB3cEZabEpNcGFY?=
 =?utf-8?B?TTJhQkR3NVQxUTludmlRRnQ1aFpnT04xQnNPY2g2enBLb2t1YVdOL0h0cUcz?=
 =?utf-8?B?UzJEUnorbGpoeFpsYTBleDNRLzM2QmQrM2J5aXhyeFAxN2NIdEhNZ2gvWjJ5?=
 =?utf-8?B?MjlSVktqOFBZZUNZQUhKdzY5TlJMM1BrVDNZRkQzUFBpY3FWZDhmY3hVZDZD?=
 =?utf-8?B?RW5COXo4UE1scGN0eWx2ODJaWTJtQkhYWGJUU0tocEVjQThEZDhSUlNLdlh3?=
 =?utf-8?B?clJQaVMxT2VRMFU3VVhDbTJTTTY2RlBaWDZzY3B4RzM0a3FKd3V0MEFXeG90?=
 =?utf-8?B?R1RyaEF0bmd2c1hRY2FaSDRvMGU4a3hnZ3RvbS9FY0dvUlp5dWNack5TRDVk?=
 =?utf-8?B?VFRBdUU4bXQ1QVp1WUF5YWlIc2NwVEtITkVSZ1pLYUpkN3BZQ0lUUWtEa055?=
 =?utf-8?B?SHZ0QzA1UUEwRm9CZWpnUkUrNE5PTTVleUF5TnozODBzZ05QYlI5OUZFWkhZ?=
 =?utf-8?B?ZTlqMnQvZTFaMERwelM4K2ZDeHhFcGxGY01pMFh3U3JnMVppcXlBVlZyL1Bm?=
 =?utf-8?B?M0oyb2dpNmdGUTAzc0lLbVgvb2NTS2tBeDJlWmx2di9pWGxXTlFMaXlDMGpi?=
 =?utf-8?B?TjFWRCtjVk5SQVJ6T3BTZnB2S2E5cEZ6Mk5BTnFsU3QxMW1tWk55OVN5WUta?=
 =?utf-8?B?czB2NTRiRE5kYS9lWEd6bzlhSkllMGZIZXoyRWlxZ1Vpb0RhRm1NUHF3aWZT?=
 =?utf-8?B?MjRrUjFkMU5OdENJRUZtdTBCaGpNbXFLSk5zNFhLcHhDN0xCVGN4Q3FCelQ1?=
 =?utf-8?B?b1k5S2gwL0FHbUFOYTN5K2hCY1pTaXZVSWxXK2xPQUVlWEduYU9ZZVI3b29r?=
 =?utf-8?B?VWhwL0tDY1ZmeXE3UjIrWHdSdzF3WCtUeldQWXdKb21OZE84QkJhUDFkSDls?=
 =?utf-8?B?TnVQNm85UHZHd2JOWC9kSXhvb3VFNnhJMk1DcFJMWmhPc1pnQTByaXB6QnBR?=
 =?utf-8?B?OUlUOXlPUGU2dGFURElyT1l6UUFsK3YyRjZ2YVpVeVo1aUJROVZxdHhDSStn?=
 =?utf-8?B?RVpxK2VyT1dreUVQUnRoZjNmcVd5dHVpNi93Y1RKT2VOTDdyY2VzRDBZMDl5?=
 =?utf-8?B?Q1hGcmxpWnh4U2FWR2JJUmtobVRpVkpaL3BPY2c4MkUwWW56TTk0NnJPVFZX?=
 =?utf-8?B?Q1BQZGtoTk1PR2J1YmkzS1hIblE3cllWRS9GUlNCaFZRRS8zc0V4MytXMVFj?=
 =?utf-8?B?OEhoSkJzR1Bha2ZTT3JLQWIrN3p6K29EVWtEbUs3RCs1WVEzOHQ0MkpWS3NL?=
 =?utf-8?B?WHVmajduV3VZd29RenBLWldjM3pHWXBibnB3eC9TQm4yK2laOUZtR3B4Ukx4?=
 =?utf-8?Q?aowSZg/28OQNv3l2grfpkCgUg7BBqv0P74HHo7UfF1P0Z?=
x-ms-exchange-antispam-messagedata-1: WCAiUQOl/fliwN8/G3DJ0f1eXBsK5CQyFjw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EE8FC65C3DB56458C0AA7F4104FA0CE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kFfQODRCX4Do2lS+2pwdNrR46LD49rLhgmUeGNz8FobPjHkBMx18hmJr37+ZJ0tOyAPyxnsVYb2e3Ts17Ozl/CSpNMxx+vCXXAVq2XWrgVvpEfTDEMFXChxZ6I7sacEZKevZKhmT4Fi6T4gW0HRf89l4obUxRzFNJLAQ1ItOoAxp/eHF3BI5YtQIyszBjc921MIhVMUJUWWU7x6wWxnMlOeJ8dslV5dRLuaUFWMFm4rI/mrKQXaPxytGkAH+QZ7jHAJ0xNZZPce3YquIQZm8llMq52py5gqpG9EJiTcPIDt9zro+Q8WZFvWqLZlWK4E3ioJy6fyygwmSTEGtUaP4HA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GdvXNAVx6SE2ciajlLB/jWwUGAHY+AXbX/eqT/tYpweLJ98M5yhtCnRCzHg3nNkb0/ab/P5OazxlkzERI+9/1G5iuNGUH4E6Qy3FBVlpTLGV/+en+ZqfRKhf9PD/8pjhpP5PTuf0CciDHuGMEizwqJUe2zaoHY3ih9459JrJ7jky6SUwGNcKaFZ3vX3xqAF7Af2dDg/3Bk390I8XXVJSu7Z1H9+m9TpwJSYO1LdrYaAiU3iBlVCgdfUgnTBl18fgsHNKJ7pQjg21QyJ1DXftE5xoRQdRP0kzTyh6t/jEHZymoeImI3lgjIaylQiDgOhi/jvnC8zB4gLiUq/RbBj5xNS21QlpTfjl8nLZHt9kBmkBocjU5jTntQeTFcqJRnW3YH5vfcZvZ6yCEtjr5HD2gW+pksrL7uz6cBvi5J727KrfHAnPvyMczgH++UT8lmEZDAMOzKbs7djMXQeXWlZWe+qjQ+XyQ7vrMMN/wbe4wK1dXv8WvsQSTSWXIshElfMhboFOGYVCRRxldTB3N8HzudID2HkCNSqa3upyCgC887+rEyPH5fjkkiJMOhee8H1o2cPzradvU2dDOids7BPgpaNFnMRHnevgD82IGz74GjhxicKKAZ0K1rEOuFjb4vnB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a157a59e-999d-4e71-7442-08df2fe85e99
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 02:58:37.5715 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: knmXW+dTKsDfzE9RW9zbcBGWklp42rBF1aicHJ4gkilkpeEbKTOP3Zd2CiRASBNaxoPJOPzqJUvCLCJfrQKnwqb9m4xZ2Au70EqKW+VrrBU=
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

T24gVGh1LCAyMDI2LTEwLTE1IGF0IDA4OjA1ICswMDAwLCB3YW5neWFuZyB3cm90ZToKPiBUaGUg
ZW52Y2ZnIENCTyBmaWVsZHMgYXJlIHByb3ZpZGVkIGJ5IFppY2JvbSBhbmQgWmljYm96LiBLZWVw
IHRoZW0KPiByZWFkLW9ubHkgemVybyB3aGVuIHRoZSBjb3JyZXNwb25kaW5nIGV4dGVuc2lvbiBp
cyBhYnNlbnQgaW4gYWxsCj4gdGhyZWUKPiBlbnZjZmcgQ1NScy4KPiBSZXNvbHZlczogaHR0cHM6
Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vd29ya19pdGVtcy80MjI1Cj4gUmV2aWV3
ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4KPiBTaWdu
ZWQtb2ZmLWJ5OiB3YW5neWFuZyA8d2FuZ3lhbmcyNUBvdGNhaXguaXNjYXMuYWMuY24+CgpUaGFu
a3MhCgpBcHBsaWVkIHRvIHJpc2N2LXRvLWFwcGx5Lm5leHQKCkFsaXN0YWlyCgo+IC0tLQo+IMKg
dGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYyB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQo+IAo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdGNnL2Nzci5jIGIvdGFyZ2V0L3Jp
c2N2L3RjZy9jc3IuYwo+IGluZGV4IDA2MWJjOWQuLjk2YzUxM2IgMTAwNjQ0Cj4gLS0tIGEvdGFy
Z2V0L3Jpc2N2L3RjZy9jc3IuYwo+ICsrKyBiL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMKPiBAQCAt
MzIyNCwxMCArMzIyNCwxOSBAQCBzdGF0aWMgUklTQ1ZFeGNlcHRpb24KPiB3cml0ZV9tZW52Y2Zn
KENQVVJJU0NWU3RhdGUgKmVudiwgaW50IGNzcm5vLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0YXJnZXRf
dWxvbmcgdmFsLCB1aW50cHRyX3QgcmEpCj4gwqB7Cj4gwqDCoMKgwqAgY29uc3QgUklTQ1ZDUFVD
b25maWcgKmNmZyA9IHJpc2N2X2NwdV9jZmcoZW52KTsKPiAtwqDCoMKgIHVpbnQ2NF90IG1hc2sg
PSBNRU5WQ0ZHX0ZJT00gfCBNRU5WQ0ZHX0NCSUUgfCBNRU5WQ0ZHX0NCQ0ZFIHwKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTUVOVkNGR19DQlpFOwo+ICvCoMKgwqAg
dWludDY0X3QgbWFzayA9IE1FTlZDRkdfRklPTTsKPiDCoMKgwqDCoCBib29sIHN0Y2VfY2hhbmdl
ZCA9IGZhbHNlOwo+IMKgCj4gK8KgwqDCoCAvKiBDQklFL0NCQ0ZFIGFyZSByZWFkLW9ubHkgemVy
byB3aGVuIFppY2JvbSBpcyBub3QgaW1wbGVtZW50ZWQuCj4gKi8KPiArwqDCoMKgIGlmIChjZmct
PmV4dF96aWNib20pIHsKPiArwqDCoMKgwqDCoMKgwqAgbWFzayB8PSBNRU5WQ0ZHX0NCSUUgfCBN
RU5WQ0ZHX0NCQ0ZFOwo+ICvCoMKgwqAgfQo+ICsKPiArwqDCoMKgIC8qIENCWkUgaXMgcmVhZC1v
bmx5IHplcm8gd2hlbiBaaWNib3ogaXMgbm90IGltcGxlbWVudGVkLiAqLwo+ICvCoMKgwqAgaWYg
KGNmZy0+ZXh0X3ppY2Jveikgewo+ICvCoMKgwqDCoMKgwqDCoCBtYXNrIHw9IE1FTlZDRkdfQ0Ja
RTsKPiArwqDCoMKgIH0KPiArCj4gwqDCoMKgwqAgLyoKPiDCoMKgwqDCoMKgICogbWVudmNmZy5M
UEUgKFppY2ZpbHApIGFuZCBtZW52Y2ZnLlNTRSAoWmljZmlzcykgcmVzaWRlIGluIHRoZQo+IGxv
dwo+IMKgwqDCoMKgwqAgKiAzMiBiaXRzIGFuZCBhcmUgZGVmaW5lZCBmb3IgYm90aCBSVjMyIGFu
ZCBSVjY0LCBzbyB0aGV5IG11c3QKPiBiZQo+IEBAIC0zMzI4LDggKzMzMzcsMTggQEAgc3RhdGlj
IFJJU0NWRXhjZXB0aW9uCj4gcmVhZF9zZW52Y2ZnKENQVVJJU0NWU3RhdGUgKmVudiwgaW50IGNz
cm5vLAo+IMKgc3RhdGljIFJJU0NWRXhjZXB0aW9uIHdyaXRlX3NlbnZjZmcoQ1BVUklTQ1ZTdGF0
ZSAqZW52LCBpbnQgY3Nybm8sCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRhcmdldF91bG9uZyB2YWwsIHVp
bnRwdHJfdCByYSkKPiDCoHsKPiAtwqDCoMKgIHVpbnQ2NF90IG1hc2sgPSBTRU5WQ0ZHX0ZJT00g
fCBTRU5WQ0ZHX0NCSUUgfCBTRU5WQ0ZHX0NCQ0ZFIHwKPiBTRU5WQ0ZHX0NCWkU7Cj4gK8KgwqDC
oCB1aW50NjRfdCBtYXNrID0gU0VOVkNGR19GSU9NOwo+IMKgwqDCoMKgIFJJU0NWRXhjZXB0aW9u
IHJldDsKPiArCj4gK8KgwqDCoCAvKiBDQklFL0NCQ0ZFIGFyZSByZWFkLW9ubHkgemVybyB3aGVu
IFppY2JvbSBpcyBub3QgaW1wbGVtZW50ZWQuCj4gKi8KPiArwqDCoMKgIGlmIChlbnZfYXJjaGNw
dShlbnYpLT5jZmcuZXh0X3ppY2JvbSkgewo+ICvCoMKgwqDCoMKgwqDCoCBtYXNrIHw9IFNFTlZD
RkdfQ0JJRSB8IFNFTlZDRkdfQ0JDRkU7Cj4gK8KgwqDCoCB9Cj4gKwo+ICvCoMKgwqAgLyogQ0Ja
RSBpcyByZWFkLW9ubHkgemVybyB3aGVuIFppY2JveiBpcyBub3QgaW1wbGVtZW50ZWQuICovCj4g
K8KgwqDCoCBpZiAoZW52X2FyY2hjcHUoZW52KS0+Y2ZnLmV4dF96aWNib3opIHsKPiArwqDCoMKg
wqDCoMKgwqAgbWFzayB8PSBTRU5WQ0ZHX0NCWkU7Cj4gK8KgwqDCoCB9Cj4gwqDCoMKgwqAgLyog
VXBkYXRlIFBNTSBmaWVsZCBvbmx5IGlmIHRoZSB2YWx1ZSBpcyB2YWxpZCBhY2NvcmRpbmcgdG8g
WmpwbQo+IHYxLjAgKi8KPiDCoMKgwqDCoCBpZiAoZW52X2FyY2hjcHUoZW52KS0+Y2ZnLmV4dF9z
c25wbSAmJgo+IMKgwqDCoMKgwqDCoMKgwqAgcmlzY3ZfY3B1X214bChlbnYpID09IE1YTF9SVjY0
ICYmCj4gQEAgLTMzODYsMTAgKzM0MDUsMjAgQEAgc3RhdGljIFJJU0NWRXhjZXB0aW9uCj4gd3Jp
dGVfaGVudmNmZyhDUFVSSVNDVlN0YXRlICplbnYsIGludCBjc3JubywKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdGFyZ2V0X3Vsb25nIHZhbCwgdWludHB0cl90IHJhKQo+IMKgewo+IMKgwqDCoMKgIGNvbnN0
IFJJU0NWQ1BVQ29uZmlnICpjZmcgPSByaXNjdl9jcHVfY2ZnKGVudik7Cj4gLcKgwqDCoCB1aW50
NjRfdCBtYXNrID0gSEVOVkNGR19GSU9NIHwgSEVOVkNGR19DQklFIHwgSEVOVkNGR19DQkNGRSB8
Cj4gSEVOVkNGR19DQlpFOwo+ICvCoMKgwqAgdWludDY0X3QgbWFzayA9IEhFTlZDRkdfRklPTTsK
PiDCoMKgwqDCoCBSSVNDVkV4Y2VwdGlvbiByZXQ7Cj4gwqDCoMKgwqAgYm9vbCBzdGNlX2NoYW5n
ZWQgPSBmYWxzZTsKPiDCoAo+ICvCoMKgwqAgLyogQ0JJRS9DQkNGRSBhcmUgcmVhZC1vbmx5IHpl
cm8gd2hlbiBaaWNib20gaXMgbm90IGltcGxlbWVudGVkLgo+ICovCj4gK8KgwqDCoCBpZiAoY2Zn
LT5leHRfemljYm9tKSB7Cj4gK8KgwqDCoMKgwqDCoMKgIG1hc2sgfD0gSEVOVkNGR19DQklFIHwg
SEVOVkNGR19DQkNGRTsKPiArwqDCoMKgIH0KPiArCj4gK8KgwqDCoCAvKiBDQlpFIGlzIHJlYWQt
b25seSB6ZXJvIHdoZW4gWmljYm96IGlzIG5vdCBpbXBsZW1lbnRlZC4gKi8KPiArwqDCoMKgIGlm
IChjZmctPmV4dF96aWNib3opIHsKPiArwqDCoMKgwqDCoMKgwqAgbWFzayB8PSBIRU5WQ0ZHX0NC
WkU7Cj4gK8KgwqDCoCB9Cj4gKwo+IMKgwqDCoMKgIHJldCA9IHNtc3RhdGVlbl9hY2Nfb2soZW52
LCAwLCBTTVNUQVRFRU4wX0hTRU5WQ0ZHKTsKPiDCoMKgwqDCoCBpZiAocmV0ICE9IFJJU0NWX0VY
Q1BfTk9ORSkgewo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsK

