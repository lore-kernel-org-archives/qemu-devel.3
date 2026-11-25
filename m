Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A6606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 05:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=q99nUCVa;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=cQiNAWz9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW60U-0007RI-BO; Wed, 25 Nov 2026 00:57:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7821f5b77=Alistair.Francis@wdc.com>)
 id 1xW60S-0007Qh-ES; Wed, 25 Nov 2026 00:57:24 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7821f5b77=Alistair.Francis@wdc.com>)
 id 1xW60Q-0008MY-IX; Wed, 25 Nov 2026 00:57:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795586242; x=1827122242;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=eT3rwMoMFKafM6xxKxULd4hxfU7TH4FGQoScZiih84o=;
 b=q99nUCVac3l/CTobim7qSDddKrr0x46Ec+jWdKfjQY3oxVTZWWmE4qHN
 VqKplVmAbctNYS/Q/gVxy+dn9hDZKIvKBa2noKsAVXCnqFEbre1HJdL0M
 xW2kyPxTk5sxSOfI3UpLRJKoTqz5+6zh4eZ3pp+2Z9vCq2GKE4/6Kbbbi
 8xc/67yNAtAMD6pkoaEvjbAmz3eraBn7hATQ/BDAPtDZoxdiOw3JVxMPl
 H+V+klC2BPfqR3wp6VxrajOWnOefBrxpqnZSDec7R3oCpV/NgLsk3tJ+H
 H7rC00L0KFF5ofGusu0xjx3I9ssxoNsrqHmAKLfMd8yWoPpy196/P/7t0 A==;
X-CSE-ConnectionGUID: PSJtSbdoSAeI6m4/u/ocqQ==
X-CSE-MsgGUID: cjDmHo8pSxSLsbbURLifWw==
X-IronPort-AV: E=Sophos;i="6.27,232,1786982400"; d="scan'208";a="162697786"
Received: from mail-westusazon11012064.outbound.protection.outlook.com (HELO
 SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.64])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Nov 2026 13:57:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSqTQjUkuSo0QF7xxuM1Kr9rOe3UmaycjIQdim6shMWw1KX4e24G8348v1mcbYE4G6hb1kC5K4jzNJjbRbBUQ0wiqB5f03VxMB9wojKfOj5FYyUuGsGIpy2l/YqsZrg2OaCrnPel5wSkdQiyuUPhooOeXXUxJSo3QdM4JSFKabVwCI/A91cIV19mcKxSnAWxYJj0u/mmhFLjZgN0bV/p1lRnw8v9vT/O0eNy/5qpWjoDDD1CkBPZxH1kYECy3RjTjXq/mTEvTp+3RokK2iDTqQkoBlA/+o0iRWvrN2Yb1513HBsRRRbGP3obi4aL0196l7oMhOYtgRRJA/iyAVzkxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eT3rwMoMFKafM6xxKxULd4hxfU7TH4FGQoScZiih84o=;
 b=qeefAsvPbB2NCSKS0nNi+nTXgwKgzh8dzWF1U/HHpvII0NLZ/chxzoSOkPTB6tWYkK7rpD5FUvzWsUxsGIjHgCm/ePKP6VL7myAuXhcddI0f8NpBTeYeS9aeKVDhHW7KDulk8UmJWZXqo9JtNpl2Pp9/+4/RKAnhf+avn3QA7WRBzWrwvCKqvzjuIFcHK0+S6r5kFcgsSXkMGZXGJ8k35CRHt0dSrfgehFMaB3+SdQSqHbyjEnD3Fs+U3CSNetsKIjkp1ytX6gJ8oP8ipK9npxUzka0R2TiHa4+wL6wJr+b9jJZnBxd9Kj1Penv8SKORt3lJ+w9okYaAnxTikO/qug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eT3rwMoMFKafM6xxKxULd4hxfU7TH4FGQoScZiih84o=;
 b=cQiNAWz9hn9m89N8Op8Mtp5/Pj3LlFp5SdSMzqTG9iAvRpfuZ4LjrRSD8oa3avODEs/luIgNP6a1O0g5Sd8UUJTT7M06DLx8gNluf4kgmUl13pC/0d4SFyGe3ZCHs18cYLrkqVT5MUyqnNnihROHZAYs7Y4I48LXRhF41FzxKys=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SN4PR04MB8384.namprd04.prod.outlook.com (2603:10b6:806:203::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 05:57:16 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 05:57:16 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "lyndra@linux.alibaba.com" <lyndra@linux.alibaba.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: Keep cycle overflow deadlines in virtual
 nanoseconds
Thread-Topic: [PATCH] target/riscv: Keep cycle overflow deadlines in virtual
 nanoseconds
Thread-Index: AQHdeHQ4jIISyLoXQ0eJhazphV17nbc+UryA
Date: Wed, 25 Nov 2026 05:57:16 +0000
Message-ID: <49454833b35c454ae0665c711807fc6651da16dd.camel@wdc.com>
References: <20261119222036.71913-1-philmd@oss.qualcomm.com>
In-Reply-To: <20261119222036.71913-1-philmd@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|SN4PR04MB8384:EE_
x-ms-office365-filtering-correlation-id: cb35c339-21d9-41a0-ea1f-08df4ab8f5ba
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|10070799003|366016|1800799024|23010399003|376014|261022105027099003|10067099003|261026140227099003|261022075727099003|261028144727099003|261021123027099003|261102123227099003|261021121427099003|261009223027099003|3023799007|38070700021|18002099003|22082099003|56012099006|11063799006;
x-microsoft-antispam-message-info: v/UAvbyMIEsF0ZirWGb73tWxHu6+7RFJVGslRZLZJqK/56j29h+q+Ds+/eZXWpo5E2WgOjNLqJG3iQ2IaDLGdCIN8rgEUe0S6tB2xoSB2eqNvchcyJIVTkQRUTEeb/WpTwptZEQsysm+mjMELyMi9VKBR96okzQBDXQTMXATsgt+4XlYwfTBTa8GYM4uUhy6wpsWgXCzhTpHpvLzoFjuXBZAM5bh2b4rTCj10nl3SSYgObgESKVauDIhiiE9qf9hIf46rFFqi4Hu796dlRAAb1LytPtXyN+PV24fSzzPZsvLBmC3OzvHmjiC79fA9dhGjwQfDSqzcJcIulOhTVPfEsCCfJbtA8z/WkKx3xhgG+3snYPShy+h23H5ODsNGODmhOH+tKvm1HtRElDc+s8O3rUm26GZ+GJpiNJRvk5UsJKuaw5+c/dRwSPJgKYSd5VUqsU18yYWCedR2LccvvESBEo9RvCpkT6fQD7+No7VAfo0BTFAn0PShbK0MJsRUItYzx7JZ4XhR63k912xWCfxWOM2N0W3Ov3iCyFVRirg6HTKn5TJTEenc6pxtHUCw6uvbYkQcXiJVSQYeEbX//se2fQfRoi3KSTb9volKR4UcEJtL4vSXtdgCqHw8hVlvNwjRLoqqIPq0neGFac0/Hvh91ZakT229yTmG5l2RvhVHPXslWLvqplN4tyEjB8D1tkEnXW5+ve9/tUgMa4RBlcy9zp2+pE6zUNsOzJ3B94GibQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(10070799003)(366016)(1800799024)(23010399003)(376014)(261022105027099003)(10067099003)(261026140227099003)(261022075727099003)(261028144727099003)(261021123027099003)(261102123227099003)(261021121427099003)(261009223027099003)(3023799007)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGNmRWtHTEZza3JHWmcrRTRodFdEVk5jTjRyYWZEYzhteEw0aEQwUDJGd3BY?=
 =?utf-8?B?eDNlM1BuVEp4anVVR0ZYbnJnVGN0cHpiRndNMGI1ZHpaVHl0SkcxQ0ZES1Mx?=
 =?utf-8?B?Q3ZHZ2NYOFlHWkliNHFwOHRsYWZSS21jQ1llanZCMGt2R0kyNEo5cGZTWUN5?=
 =?utf-8?B?b05FcW5JMEE2Z01tMDdQU2JUZGRHMmJMdENzTVZPMFhCVU8xUFZZMEgxakFx?=
 =?utf-8?B?NWFKVXFMcnV5QU1tNEsxT3YvUDZFYmxaSGs0ckJNQURHeWwzOWdPejBqYWlC?=
 =?utf-8?B?OUZkZk1rekZKN05xc2t6Vm9EczlTRlJ5bkZLVDBTZGRCYURHeGE1bW4rd0tm?=
 =?utf-8?B?YVdOZUJhcWt4ZDRNSEpCVkU2elRFQ0duTDhBSVJNaUhtb1hsLzdHZkkraHNS?=
 =?utf-8?B?MFU5VlZaYTFLajE1eTdFTlF3QXVKd2dmNW5yY014NFZNNzJ3dVpyTWVaN21P?=
 =?utf-8?B?SlJ6cUw1cEw0d241YkpRVzNUK2dDa1RsR1NvNjVHMzFhdGhCUmVhUmVLeFFy?=
 =?utf-8?B?bVBWR1h6T2dlUGJEYmlYV1lhZ3JBK1pyYmlQT0lKVzdCLzd3VHV0MmFJMlIz?=
 =?utf-8?B?OUVvdTZCR3dEemZ6QVpuTXJPWTVBYmVPdHRJd0VSaDl2dUJoZGFhRVREYW5j?=
 =?utf-8?B?aTNySU1IcmFaYXZsTVBMNzhUYWZFcy8vczIrNEFPUzZlMXNYV0syNVZ4a3ha?=
 =?utf-8?B?Q0MxR0RGUWZGYWp5ZDlRdDFyVGowa0cxeWNuREhwNFFJNFhoTk95VHBocjJG?=
 =?utf-8?B?NnFXQUVyTjEzL1Axb3Vwc0tJN0h6NU5ZcTJxRjBidXZWdWtjZWhEN2tTOGdi?=
 =?utf-8?B?M1FUanVDNVRnZGZsOW1nMysvM2pFRGZjQmNaM1pucGdiZEdRSFNqQkFqbEFv?=
 =?utf-8?B?emhFN0NwME5UVHM1aGROaVJ2cHl4dHBqbWFQc0dpaVc3MDJHOEVRZW9NSjNh?=
 =?utf-8?B?V0lCWHZSYUx5YmFqWlFrNXZneHFrUHRxQVVNUUtFLzJNUjRXKzloVDlBTFlN?=
 =?utf-8?B?aWxiMG9MVnExZERjNlc5a0JJZjJvSUt1SklneTA4aDZ4M0pZOFQ2L1B0R2JU?=
 =?utf-8?B?dWw2MjBQRnBmTEs3K054M29WSHd2WFZHMWMybCttVEZTbWJaQ2c1NGNPN2dY?=
 =?utf-8?B?TSsrc2pWalZQNy9ZS3gyTnl3UmNJczRZV1l5YUhLenJSMnJ6SHRaU0tNU09u?=
 =?utf-8?B?MUVEM0xpWjRRdHBpbVJFNWtNK2U5ZUxSMUx5aTNudnVWUlVpTEFTZm1BNWpn?=
 =?utf-8?B?QlBqVjBYTm5EM1NicXB1Y0RSRmdSdDhtejF5WEVQS1JRTUh5NFFydG1neTRW?=
 =?utf-8?B?b2k5YTM3eU1xcmVSTGhJV2tIaW9YNUZ6dldURWQ5NFhnN1ZEaXphNnM5NmF3?=
 =?utf-8?B?TUxIaWFDMW1HSUdVbHNHYjY2bllOVlAxVlR0SWpzRndNNkpDbHNTUFJpbnFr?=
 =?utf-8?B?K3cwMjJDVUFsTk5KakIyZ0lnWGlZREhaOXNqOWdpL2tZY3MyTlE2YnhJYlBH?=
 =?utf-8?B?bVo0ZW9SU2d0WlFlRUZXZmc3WDhuTmNIejhXbTU0UHpQaWNCOEptb2h2ZStG?=
 =?utf-8?B?enpOOHhjbVA1TEp5YmNLbk9OOWwxem93UGxMR0pHZFcxN0hnTVVJRVVldVBl?=
 =?utf-8?B?WDRmU3F4TVNXNjg3NlRWMzZQRWNJUUlhdzArSjU0VnNrQ2wvaitIMUJmZXE3?=
 =?utf-8?B?aXNoNlZIQVBKSkp3bnhiMkE2QndQRE5RRFNDMzZCenZLQ0d4eDNvb2YwZGRW?=
 =?utf-8?B?Ull0M3pOR3BBSTdqMERYdTF0Rnl6NGcvVy9QaVN5WEdwcVBXZ1hxV2FrODNW?=
 =?utf-8?B?T0NjaGZFbWpRbjdjSVdHZ0tKalFGZlg5V0pDc2g0UDlXRGY5ZWp1dlVqVTc2?=
 =?utf-8?B?N0tCTjQwblRDZE93amFrSzk2cG5KbWJOSGgvekw1R2l1dGJnM3pjMVMxZ2xF?=
 =?utf-8?B?U2FKeWU1TUtWMnlsOW1PeW9DOHluNmJaeW1jWTNRRndWZExPQVo3TWFDaE96?=
 =?utf-8?B?UzdhR2V4TWRGYXAyQkE3THlGNDJ6R0M4ZXZERGxFTWorUENzbitCczNUWmJT?=
 =?utf-8?B?QjB6R2JaWGRNcTdaczlwQXJ1UGNmckZMRk9Nd0c1bG5IQWVJVWR3V0R2Um04?=
 =?utf-8?B?d2FzSDdoSlFnN3FqRjNEZWFZb3NGYzJyN2I5bmV3OWlxc25ZeC9QM2s3S0Q3?=
 =?utf-8?B?d2tPYzRpWTRQb3M5WjRHWWpSYjc2T010UVUxK25VcmcrM1lEb21yeklyYzNB?=
 =?utf-8?B?bURHMTNzaXR1WWlhc1dmNk5RVnZXRno4OENVYUdPNStETXJHR2xIQTdPTlI3?=
 =?utf-8?B?K3JoK3ZZTDdFaTdZMkowa0tQYzFkS3NqZFdVdUlPNS8xY2ZuR2lwVGFYaWNJ?=
 =?utf-8?Q?Vm5JoUxkSydlqMaoXQzoKISdPZXQHoigO4WS3UIRzP2m9?=
x-ms-exchange-antispam-messagedata-1: fyGBqOnd1EISlUPz018vRxpkyRdCHmd8WZg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36B5D3F5C0948F4392C2645C3C2F5E0F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bjW+JcNeGA56EZtX+cCKb9IBHfPgCdgrqTh31m0eyHivLAR5KUQDfVkzHRHO8XPGdiI6hovc7PmHm5WUx2tVxcnZkvzbazCLvKHmVs6Ixj4A0U3zUv7gf4rDWybH9ll2WV10ja0ii1d3d6C/sIY6eGZL23O5PMlUbMZ15TYlh41izdvKA1MhvKBEd9yxEzHiMX73HvSrUx5TIIo9b4C3/uH+3eJk05lTRAyrmw4qT9v+t1gM5fTe3oNYkUQhOcnN1RBIMx23v9Usi4rU6DYC8ppJvAKMfoBto+IevzQFkZSFB49E2RJD8+tX/wEj4NS5K+26Ec6R+pcWcd/AWn/txQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /FQ0HijTyjASq0kVdiyLGpM/nLWyGsmBMqld9RaaifZEAoqdIXoMogfiwXHiupKmD64u1hbrve5Y9lJGD7fDzHdFlJ4WOx5jwPASDhHObgWJ5mEVvnhsKDFGIfiF2TcpIDwamzIr98o4+RKZoRRzN8Y7NVTQkFjxI7MNppiAGJZ7/MbSRN5mAxpw4vG/tlvy2Axonuqk9L1w29aVcb2b2Yw8LS90nxHZJo1A4kMQ3W6dsXO3NLVa+tKWmobEVeUWniwViCiNkfhuz/aOMK8WiZ8JA2NPmejXn0nTKP7n/XjZqnwEhdvaPkUJm6q+Qt3UtgVbi0TEv9OqxAzSn2KinFS3Vgxbscae89rsm/hKAsbGBwKkVl6aiCsvpFnUUcHcCPy5DUfUAOL1/ud392zqX9eNR+ed/6KmdwkeTueDnvN7RJSwEoGWvzV1pz5tIaeUi2Jqi2k2szzYNOtzc3G4M9ViCgL7yqE3/8BA2GJsFnnV7iLAB+kHrP7KfXccFp4gztm0aGgfqt9r8EUk5/Azi5lnM5EB5jDaDCybcjsRl5Umr4fcIvxVz38jgdFpVzht6GAeaDP5Xn8UMpI7jzvmWHxXYy9BMc2eG+qamvFrDMGoHDsxwJf+CFXolz8oFRkj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb35c339-21d9-41a0-ea1f-08df4ab8f5ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 05:57:16.6386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5KVgUfx8wsdezKHsLOU0lEnVw6yDGY6T2vtNQgEvCyTiHKDPZS1JdJRalusL02mDE5kv3xMB5VRqbMaUmeiWXCBLWRtIPHpWTyUVGVr2mSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8384
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=7821f5b77=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTExLTE5IGF0IDIzOjIwICswMTAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4gVGhlIGN5Y2xlIGNvdW50ZXIgdXNlcyBpY291bnRfZ2V0KCksIHdoaWNoIGFs
cmVhZHkgcmV0dXJucyB2aXJ0dWFsDQo+IHRpbWUgaW4gbmFub3NlY29uZHMuIFRoZSBQTVUgb3Zl
cmZsb3cgaGVscGVyIGFwcGxpZXMgaWNvdW50X3RvX25zKCkNCj4gdG8gYm90aCBjeWNsZSBhbmQg
aW5zdHJ1Y3Rpb24gY291bnRlcnMsIHNvIGN5Y2xlIG92ZXJmbG93IHRpbWVycw0KPiBhcmUgZGVs
YXllZCBieSB0aGUgaWNvdW50IHNoaWZ0Lg0KPiANCj4gUGFzcyB0aGUgY291bnRlciBjb250ZXh0
IHRvIHRoZSBoZWxwZXIgYW5kIHNjYWxlIG9ubHkgaW5zdHJ1Y3Rpb24NCj4gY291bnRzLg0KPiAN
Cj4gRml4ZXM6IGIyZDdhN2M3ZTRlMzAgKCJ0YXJnZXQvcmlzY3Y6IEltcGxlbWVudCBwcml2aWxl
Z2UgbW9kZQ0KPiBmaWx0ZXJpbmcgZm9yIGN5Y2xlL2luc3RyZXQiKQ0KPiBTaWduZWQtb2ZmLWJ5
OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQG9zcy5xdWFsY29tbS5jb20+DQoNClRo
YW5rcyENCg0KQXBwbGllZCB0byByaXNjdi10by1hcHBseS5uZXh0DQoNCkFsaXN0YWlyDQoNCj4g
LS0tDQo+IMKgdGFyZ2V0L3Jpc2N2L3RjZy9wbXUuYyB8IDEyICsrKysrKysrLS0tLQ0KPiDCoDEg
ZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L3RjZy9wbXUuYyBiL3RhcmdldC9yaXNjdi90Y2cvcG11LmMN
Cj4gaW5kZXggMDE2NWZhZjA2Yjg2Li5jZDRkZTljZGUwYWIgMTAwNjQ0DQo+IC0tLSBhL3Rhcmdl
dC9yaXNjdi90Y2cvcG11LmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy9wbXUuYw0KPiBAQCAt
MjgxLDEyICsyODEsMTUgQEAgc3RhdGljIGdib29sZWFuIHBtdV9yZW1vdmVfZXZlbnRfbWFwKGdw
b2ludGVyDQo+IGtleSwgZ3BvaW50ZXIgdmFsdWUsDQo+IMKgwqDCoMKgIHJldHVybiAoR1BPSU5U
RVJfVE9fVUlOVCh2YWx1ZSkgPT0gR1BPSU5URVJfVE9fVUlOVCh1ZGF0YSkpID8NCj4gdHJ1ZSA6
IGZhbHNlOw0KPiDCoH0NCj4gwqANCj4gLXN0YXRpYyBpbnQ2NF90IHBtdV9pY291bnRfdGlja3Nf
dG9fbnMoaW50NjRfdCB2YWx1ZSkNCj4gK3N0YXRpYyBpbnQ2NF90IHBtdV9pY291bnRfdGlja3Nf
dG9fbnMoQ1BVUklTQ1ZTdGF0ZSAqZW52LCB1aW50MzJfdA0KPiBjdHJfaWR4LA0KPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaW50NjRfdCB2YWx1ZSkNCj4gwqB7DQo+IMKgwqDCoMKgIGludDY0X3QgcmV0
ID0gMDsNCj4gwqANCj4gwqDCoMKgwqAgaWYgKGljb3VudF9lbmFibGVkKCkpIHsNCj4gLcKgwqDC
oMKgwqDCoMKgIHJldCA9IGljb3VudF90b19ucyh2YWx1ZSk7DQo+ICvCoMKgwqDCoMKgwqDCoCAv
KiBUaGUgY3ljbGUgY291bnRlciBjb3VudHMgbnMgb2YgdmlydHVhbCB0aW1lLCBzZWUNCj4gaWNv
dW50X2dldCgpICovDQo+ICvCoMKgwqDCoMKgwqDCoCByZXQgPSByaXNjdl9wbXVfY3RyX21vbml0
b3JfaW5zdHJ1Y3Rpb25zKGVudiwgY3RyX2lkeCkgPw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaWNvdW50X3RvX25zKHZhbHVlKSA6IHZhbHVlOw0KPiDCoMKgwqDCoCB9IGVsc2Ugew0K
PiDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IChOQU5PU0VDT05EU19QRVJfU0VDT05EIC8gUklTQ1Zf
VElNRUJBU0VfRlJFUSkgKg0KPiB2YWx1ZTsNCj4gwqDCoMKgwqAgfQ0KPiBAQCAtNDU2LDggKzQ1
OSw5IEBAIGludCByaXNjdl9wbXVfc2V0dXBfdGltZXIoQ1BVUklTQ1ZTdGF0ZSAqZW52LA0KPiB1
aW50NjRfdCB2YWx1ZSwgdWludDMyX3QgY3RyX2lkeCkNCj4gwqANCj4gwqDCoMKgwqAgaWYgKHJp
c2N2X3BtdV9jdHJfbW9uaXRvcl9jeWNsZXMoZW52LCBjdHJfaWR4KSB8fA0KPiDCoMKgwqDCoMKg
wqDCoMKgIHJpc2N2X3BtdV9jdHJfbW9uaXRvcl9pbnN0cnVjdGlvbnMoZW52LCBjdHJfaWR4KSkg
ew0KPiAtwqDCoMKgwqDCoMKgwqAgb3ZlcmZsb3dfbnMgPQ0KPiBwbXVfaWNvdW50X3RpY2tzX3Rv
X25zKChpbnQ2NF90KW92ZXJmbG93X2RlbHRhKTsNCj4gLcKgwqDCoMKgwqDCoMKgIG92ZXJmbG93
X2xlZnQgPSBwbXVfaWNvdW50X3RpY2tzX3RvX25zKG92ZXJmbG93X2xlZnQpIDsNCj4gK8KgwqDC
oMKgwqDCoMKgIG92ZXJmbG93X25zID0gcG11X2ljb3VudF90aWNrc190b19ucyhlbnYsIGN0cl9p
ZHgsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgDQo+IChpbnQ2NF90KW92ZXJm
bG93X2RlbHRhKTsNCj4gK8KgwqDCoMKgwqDCoMKgIG92ZXJmbG93X2xlZnQgPSBwbXVfaWNvdW50
X3RpY2tzX3RvX25zKGVudiwgY3RyX2lkeCwNCj4gb3ZlcmZsb3dfbGVmdCk7DQo+IMKgwqDCoMKg
IH0gZWxzZSB7DQo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC0xOw0KPiDCoMKgwqDCoCB9DQo=

