Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D2E606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 03:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=PCZFsHij;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=xsvq4TqB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRLfm-0006Lt-Dn; Wed, 11 Nov 2026 22:40:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=769f446c1=Alistair.Francis@wdc.com>)
 id 1xRLfl-0006Ja-36; Wed, 11 Nov 2026 22:40:25 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=769f446c1=Alistair.Francis@wdc.com>)
 id 1xRLfc-0004dX-Mq; Wed, 11 Nov 2026 22:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794454816; x=1825990816;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=K8L/gAjwxP2NjuYTR7wbCdDW+em93oR5e67sH5e3Z8M=;
 b=PCZFsHij4Gsj90a4OMfS7nOjAqexIxCAMjn39EJPohbTWZlzJGOA8jKX
 OwMeLtOjOWUiPsmUaFfgzUT+paAhxzx11DMs+DwqacX0nPoAMzSvhZvhb
 MSlZ+5DamJirx52itKfdSq1Dk1csoSZb2X/b9XAPTQtI3zW5ff7gWii03
 dLIpmUo/AYD886DbIV2cCzeKe72EOiJsQ99zxkgts6x2NtjwXPHuBXY69
 ihVKLb1ZOkCWJi5+Z/sFvP+vPgiFyDm0PYOQYy6ulyzV5JKJ0A1xlwhsf
 eZnBE4ua5rWrXSeaocEYm7L8rg/gl9vLzkSfSSloVMxMT7DKvA2dPsKax w==;
X-CSE-ConnectionGUID: 6OypF2wCRHGUt+Z0s3TN4A==
X-CSE-MsgGUID: ADIwZW12TJCiSYLyphF2mg==
X-IronPort-AV: E=Sophos;i="6.27,208,1786982400"; d="scan'208";a="160626576"
Received: from mail-westus3azon11012063.outbound.protection.outlook.com (HELO
 PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.63])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 12 Nov 2026 11:40:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+BWFcWNwMBR26AycpZmhtE8Zbxwyb9q9wl/VsWUWYg5730eD53vKXxVzuuQp7G/E69HFy15O8PYEa7m/V5Xzwa8mKMIkG3qBm29sr16fzI0/WgNDKCHVpqCBTXzgVZOCvI4manabBSHfJ5kievA62GtPecBZccaqY6KExDrp8eMlZmW88UPqzWK+f5x9SObNBsC9F66U55/VBEy3ERd4guoFzV5RD7koUpa8ybpJA8I/QIXwR/A5d56Vc9uW56+kdqrLy02FfY068KXA+bt2fSPx3Va1TjEgoi3fF+rCWti7M0CKTKrzlh6z1528vBJ0fe2IgLob+h3A1hyQZoFSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8L/gAjwxP2NjuYTR7wbCdDW+em93oR5e67sH5e3Z8M=;
 b=LqtKFxBcNAxg1ufFqmmxx5ew/lL+8pw7aMMCMfc9gM8OaBRrvxZlGsWNq4vGt5rME8pOX0aZHEursxGYxHHF6wSrzvPixjvRVvoJ7ZMJpAYGL/KR3VF3DZRea/iZABsJSrCsPX0Lf8WD0jV7YDvyAblWrwpGCL+aPMLLE5ieI6JFNXjdNRQckcwcK9czGeBNtRDxA6X80eACvPbqLTT/+pc/q9uAWyWTZyvItSx2otc53ElRvsoPKs6M4JGOwk0Q4aIPlPbVytlz6GI3nKLlDzRdWbLtjehQRGZYGCxdgRNZdFsh0zd1TjmM/R0NkEQmelOtLBRP1auGIISS19zlPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8L/gAjwxP2NjuYTR7wbCdDW+em93oR5e67sH5e3Z8M=;
 b=xsvq4TqBYS1nib9st/iFUmT0UX1/yNu9zQhfythdhHQrxQESnJ1dGex0zn+8qMB7aV7PS7b0ufEbR4RT7SlZgYxcJPwNPgjcJ7bFV67CHg9hyLWa8OY+Zqnne9mO8fH1hOfIElsrieFQU9JQ+Nst9J7clE5ULHMsFcM6ApYVWxU=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by DS2PR04MB994338.namprd04.prod.outlook.com (2603:10b6:8:4ac::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 03:40:13 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Thu, 12 Nov 2026
 03:40:13 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2 1/1] target/riscv/tcg: clear itrigger_enabled during
 trigger_reset_hold()
Thread-Topic: [PATCH v2 1/1] target/riscv/tcg: clear itrigger_enabled during
 trigger_reset_hold()
Thread-Index: AQHdcasjpPJSk+syG0eG04plLC6qyLcpy7OA
Date: Thu, 12 Nov 2026 03:40:12 +0000
Message-ID: <181e08eee0f1d1bab3170e54a3fd9806fa7fc41d.camel@wdc.com>
References: <20261111070600.169519-1-daniel.barboza@oss.qualcomm.com>
 <20261111070600.169519-2-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261111070600.169519-2-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|DS2PR04MB994338:EE_
x-ms-office365-filtering-correlation-id: f1f2b068-2f2d-4860-5d06-08df406ea8ae
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|23010399003|10070799003|1800799024|18002099003|22082099003|6133799003|4143699003|11063799006|5023799004|261102123227099003|261026140227099003|56012099006|261028144727099003|261021121427099003|261022105027099003|10067099003|261021135927099003|261022075727099003|261009223027099003|261026121527099003|38070700021;
x-microsoft-antispam-message-info: 9KOaxE3YvOdM9AMLzSOlK4y4nHm3Akezpe/WSk9/yHiJN4ghOBYC2zKZbvBc4Bi8cyEk7xGDFEz+S2Eybm2G/h6GHahKlT442nTPLRXmqGlXMaKJFAkszFyH2+X68bR9WppnQM/6XMGo4mUtfsjSnMPkCzCYTNWTNkjSo8h60My4JVtuD3GpFi4n7RCHybQDwCK0TGGe8DNCk8ycNlAucjXlCP9lBsQalqxIt41VoKKDRNBrBKFDBqKf12ocIMj3V30wvBtMn2ESjZtNZpIQvN+m+KKt3hbAMZECkfPhsEwbGWiuIMf2XWyoVa0zwhJOq2KCLuFfS6WeCqrO3p4ywlsbU3tlrrYiVd5tGk9G0/gk+ea0RJz8yJnH4eD2ZiS/G2efEjma67bH/h2cFwEsHI0ra8miknJqE6ew2iODKn8xM21K9rpL9Lfb7+labUUywOpvlTjH/T4Uy3vPdnJ/rEzcpXLQrOcawfhwDMI/riQfIAA+IMwWj49cHk6Zqhl+JNAogo9gwYLl1sf3UGJX6XAOcwBPZZoo99wMCgouFd07s7HOAAGT9ns/Ymp/TgCmDn+aayJZm+UuTQlRqg1FtrhDg4cJxc2JoVEXzGu6w+7i3bmf3rae+fugdqonmJB6L//9KNy6u4SuYorAcuA4x62UYvhuvfbWTIdfbkUSyavD7IOg9KPxHcM2XXKSeV3ibxhO1jzd4Q44+6YjcGXl7mLUMadxyV2AmBsFttFEfX0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(23010399003)(10070799003)(1800799024)(18002099003)(22082099003)(6133799003)(4143699003)(11063799006)(5023799004)(261102123227099003)(261026140227099003)(56012099006)(261028144727099003)(261021121427099003)(261022105027099003)(10067099003)(261021135927099003)(261022075727099003)(261009223027099003)(261026121527099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFVwbytrcDBnM3JjUnNsRm45OEFSdnVnUzdyVU9md0lkUzRjQktHQ3pkWHp6?=
 =?utf-8?B?RVEvVmduQTE4M0NneUVlamwzY0VBeSsvMEI0c091OVMrZVZCd0JmUUlqQ0Ns?=
 =?utf-8?B?eTYvdzA2dm1uOHVGTVUvMUtDNmo3Snp4RXNJMktvYzkyRDJIQzcxTUZIZlRh?=
 =?utf-8?B?dVpjUU44S0hOSGVITythWHpEdGxabDRoOFZSUUlqRVpEZkhzUVlLK2szc0pM?=
 =?utf-8?B?UVllNTZ3aUprSDNPQ2F5aEl6UGIyR2hNcXlqZWVvZ2JHSlcyMThSR0dtMXNt?=
 =?utf-8?B?cExCNFlSVUlseUxva0JyY3JsMzQvRCt0WWUwL2ltalZSMi9NY0tjTGxCY1Vz?=
 =?utf-8?B?NUd6a2k3U25ZSkRmVXZqQkNGTUJQZzlhRTBlRGhSbW04TFNjcW8vMk1iQktn?=
 =?utf-8?B?c0ZlaFVTNlRaRzZiV0NIc09zMXFWSEtlVWY1WUlhT3pRS1REU0xHR3AwOFZ2?=
 =?utf-8?B?N3VwOWN4Rzg1c1NZU1hMSWp4T1RzajNOZ2d2aDEvRDNqeEFMTmIrOHlnU0lx?=
 =?utf-8?B?S0tlTXZhNGZlYkV1aVQyM2JqMjJpS1Fib3QzK0dLa1g1UlVRWXU2dDlINklQ?=
 =?utf-8?B?SS9nRWNrZys3TkxOa1p6RDkvK1V1NlFYV1RQRWpaaUY3WlRYcWxiamhUMTE4?=
 =?utf-8?B?b0w1dWhmQW0rMEI3YjY2d25KbWNkdUpva3E0VkRQQkY5bS9pdnFuNGNNbnNS?=
 =?utf-8?B?VVAwbkUyVjFYMGVFYWhlM0JpUnEvS2NSM1dGSTE5ZEorQXkxVXlETEZNQ2h3?=
 =?utf-8?B?c05XU1VTOTJIWDdUZG9HRHlqQnlMaXE2eHh3Wk1HcFhzc0YzSms3KzFjdE1O?=
 =?utf-8?B?U0RJSERlNWNaSFA5YzBzYzQwaGZweWhzdVVJczRscVdwcktpUWVjVXhWUXp3?=
 =?utf-8?B?eXk3OXIxNEgzMUd6TjFJVDJLVDdRYk51RUhJUHZRaXN4Nk0yL2pHWjgwemtW?=
 =?utf-8?B?dExNNHhkQ05GU2EzVkJIdkVEdFRiemd1L0xWd2JaZGRVV2lDdWtTd3BBT3VG?=
 =?utf-8?B?dWNOd1RYM3htZ3V1ekJwT0RaNGNqQmpZVzM1OUxDK1ovQXYybmpxczdxYzJm?=
 =?utf-8?B?bFZZTHhxUnNPRlAyWThMa0tOOFBKRFdMQ2NZYWIrcnB0ZXM3M25VdVRkUTFq?=
 =?utf-8?B?VTY5YkV6dmh6WHNCRTRzdHJpbE9oWTU0UkRXSXBZNkJiVnU3b1QwdEZrZEFj?=
 =?utf-8?B?Z2FmU2ZaV0doZ1lQZVIwOTI4QkFBcWtvbCtyR0hTV2xLZ1JINFRIZE1FOWdY?=
 =?utf-8?B?TjFZa3BoUi9DcXNpejJVUXgrMjBLMThTNVVZYndsQ2drYUMxOGJSZGNZUnVj?=
 =?utf-8?B?bk53SzgvMnpyeWdyNW9uZDIwWE40ajlLNlNxZDZTNkl1ZzVJUnJSajhDZ0t2?=
 =?utf-8?B?aDBMUVNaMmxuQ29sMjZKYWh1eXFxZXpOZ1hEcGhHSk9VdFJOc0didEhnei9G?=
 =?utf-8?B?dWhOMndlRzZxaW0xTVQ3OEkxM3YyV2EwMkdOSkJHWWJobEZvQkh1ZEdvSGZu?=
 =?utf-8?B?aTlkcUtuMExJdVdodHFlU1BMSUp5djlSbWhPT2tCWTJIQzF5YTVKRUpMYmxq?=
 =?utf-8?B?K2cwSUFtUDJQYUJkTktOY0NEa3o3MnU0d1o1aFYxNWduNlFyY1JieExaTUN1?=
 =?utf-8?B?anp4WEhFdXl4QzN0ZXVNWm5qeWZ1ajAvNkQxR3lGN2pLN2tjN1hnQ1hpRVFS?=
 =?utf-8?B?cVEwS20zV2pYRlU1OEx0ZWVtSGYxRGcyczNlMVNYaktRckorcEpDOG9vU0Jx?=
 =?utf-8?B?TzJpaWtHVHNZYXppY0c2c0tUeEtpNWYwSENZMkxXcUh6UU04L011MFZFVUFZ?=
 =?utf-8?B?Q0huOTJ4UHRyOEw0bTVHRURBZnNVczFuRHY5emE3T2dGRzFpSGVRTDZzUjkr?=
 =?utf-8?B?bDlMU3hMcmxwSEpKMXl3aVhJT1orMUVUMkh6N3RhYzZFRlNlTTFNYTRHZ2Vp?=
 =?utf-8?B?ZWlvcjBJUXRjSUFHVjgzVEt2cnlqek8rVFpNK2YxTzRqK0JwaDk4MWFJWGZx?=
 =?utf-8?B?WE8wTXViQktUUVlNVC9OWk0zb1hUcVJjSmJBR2QyQStZVWEwcFJ3KzhzL1cy?=
 =?utf-8?B?YllFY2pzMUNTNzFNWVZpMnNFN1FYWkVJWXVLWHl3MnJBS1FKZ2t1QXZhVER6?=
 =?utf-8?B?S3hRT1V3UDJMckxKRFU3eU16c2luY0xDd00zOS9NdU5COE1MOTBPRjJBZXUz?=
 =?utf-8?B?Mk0wd0RsanJZY2JYOXdzNTk5L09mQ3Q5VEJJOGVXSTBBbTN4VHBFeFZhRXBR?=
 =?utf-8?B?U2VnVWYwUks1YmpRL2ozQkRWb01TZGZ1S1U1WGpyNVdielBSb3dDVUlxYS9C?=
 =?utf-8?B?UjJabm1wT3ZRRW9kNDBZNWNPWGp0RklMdzBLRktGcUM4Mi9FYXVGOENJSVZ4?=
 =?utf-8?Q?EGMS2TpJ8pll66v5S1LFQyBmGDebBAe02oMMaNioY2Br9?=
x-ms-exchange-antispam-messagedata-1: acxXezgW5t03NE6XirFgBHzBQldnp8gQS7c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB6FCE3DF51DD0488236642D7319D674@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: r2cBUj8yUWl3k938r/Tsi7eRoE8qxUXsKBHVSb4Hg17XsyaUiRbSwz+34eSBnuN+k8ZaVM0kXy7T/kyByPdAVgavvqYL7Lrq/avmswFPadyJzXbR6WIoEAGGuqiGvCTCgStalNZWK2bJdLNR7MwAVveKHMPH9r7JubpcxOxYpNhgUlmvpYkRCVOXswzR+FmKWiQvRPOK46ydAfyHQJ3c7sIBq9MIaX7gi299ewJmGLCeNX73C2A2OCoznYhRoN4Ntkujpw3rPI1JOse9M9cx+HpopIlNWJlnR88AIB/FXsXnHi60uOsd1+Ca0BICftfNqeeN82eDxVvP1vyKqn6a5g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ya+0r3dFNozHleojd/fuOgy85UjnzFq5/uSB9psKqJk+2rhAquOZ2NYon2kXP88PbOW9uNABXM7PlX6eDB+TYGkyGNQ4GRYqEYzWEajVtcw2C1w9TzXGZJTx1lkVuC7FAo0TlQ6qWRlLfHJhzf63cq3DTjwuAshQjFYoJ4B1evfXeaxIA+M/AXB31r/89EYhCmx+g2CgZS3mcDYDq/cO3DR8yDDPHWuLF9CQIrFwDltNWeKEI6kavLj4TdPeqrFlmbO7585gWJutGToz7sQStF9E6kz3LsApsajZR147a+ix8LirMQxQY5NALF9nhTUx3wBKS7z+WeVaLxKvfm0GdlFKyux8A6XGt08l/hsCd+QAXw7exysRZGjDgkBvHbl+N5/hAfrVBYjnFu2eEu4QzclbZUZZ20Um32lGvtm1dfuEPYvRPogG0fGsgYpgw+GFiXswM88xr0ZGUKWUth1WX4qkBfiMugwSdEMPGK2MRNst2Cl1kHGcARLABfvJBoC0onF+UzYcXx0StQZN03MAh30r7NwLrvMinQBuGcpgdjlyPGyHXoRgHYkMu6wiAi9C9BofiBdXWgvUmHEns6gJbXcu7s5S0fT0GWq6YKw1RBeCLrCCDYVBXA2jw/PjmqYk
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f2b068-2f2d-4860-5d06-08df406ea8ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 03:40:12.9975 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ciMc4CLT554KxRquFalD7FExOEjx/6Cwme9txs6iz4XoJ13dNx7g/7VHRHXnMnN5IBYq75qChmvVfYJWr+SXvJG2/qDoa5yfyiYNrIt55tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR04MB994338
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=769f446c1=Alistair.Francis@wdc.com;
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gV2VkLCAyMDI2LTExLTExIGF0IDA0OjA2IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gV2UncmUgbGVhdmluZyBlbnYtPml0cmlnZ2VyX2VuYWJsZWQgdW50b3VjaGVk
IGR1cmluZyByZXNldCgpIHdoaWxlIGF0DQo+IHRoZSBzYW1lIHRpbWUgcmVzZXR0aW5nIHRyaWdn
ZXJzIHRvIEFEX01BVENIICh0eXBlIDIpLg0KPiANCj4gU28sIGluIGNhc2Ugd2UgcmVzZXQgdGhl
IENQVSBkdXJpbmcgYW4gaXRyaWdnZXIgc2Vzc2lvbiwgdHJhbnNsYXRpb24NCj4gY29kZSB3aWxs
IGVudGVyIGl0cmlnZ2VyX21hdGNoIGhlbHBlciBldmVyeSB0aW1lICh2aWEgY3R4LT5pdHJpZ2dl
ciksDQo+IGFuZCB0aGUgaGVscGVyIHdpbGwgZG8gbm90aGluZyBzaW5jZSB0aGVyZSdzIG5vIHR5
cGUgMyB0cmlnZ2VycyBzZXQuDQo+IEFuZCB3ZSdsbCBrZWVwIGRvaW5nIHRoYXQgdW50aWwgc29t
ZXRoaW5nIGVsc2UgY2xlYXJzDQo+IGVudi0+aXRyaWdnZXJfZW5hYmxlZC7CoCBUaGlzIGlzIGEg
bmljaGUgY2FzZSB0aGF0IGl0J3MgYSBiaXQgaGFyZCB0bw0KPiBoaXQNCj4gYnV0IGl0IHdpbGwg
Y29zdCBhIGJpdCBvZiBwZXJmb3JtYW5jZSBmb3Igbm8gZ29vZCByZWFzb24uDQo+IA0KPiBGb3Vu
ZCB3aGlsZSByZXZpZXdpbmcgYW4gaXRyaWdnZXIgcmVsYXRlZCBwYXRjaC4NCj4gDQo+IEZpeGVz
OiA1NzdmMDI4Njk0ODggKCJ0YXJnZXQvcmlzY3Y6IEFkZCBpdHJpZ2dlcl9lbmFibGVkIGZpZWxk
IHRvDQo+IENQVVJJU0NWU3RhdGUiKS4NCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEhlbnJpcXVl
IEJhcmJvemENCj4gPGRhbmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20+DQoNClJldmlld2Vk
LWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0
YWlyDQoNCj4gLS0tDQo+IMKgdGFyZ2V0L3Jpc2N2L3RjZy9kZWJ1Zy5jIHwgMSArDQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jp
c2N2L3RjZy9kZWJ1Zy5jIGIvdGFyZ2V0L3Jpc2N2L3RjZy9kZWJ1Zy5jDQo+IGluZGV4IDhiNThj
YmQwN2EuLjk4OGJjODE1ZDcgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNjdi90Y2cvZGVidWcu
Yw0KPiArKysgYi90YXJnZXQvcmlzY3YvdGNnL2RlYnVnLmMNCj4gQEAgLTEyMTMsNCArMTIxMyw1
IEBAIHZvaWQgcmlzY3ZfdHJpZ2dlcl9yZXNldF9ob2xkKENQVVJJU0NWU3RhdGUNCj4gKmVudikN
Cj4gwqDCoMKgwqAgfQ0KPiDCoA0KPiDCoMKgwqDCoCBlbnYtPm1jb250ZXh0ID0gMDsNCj4gK8Kg
wqDCoCBlbnYtPml0cmlnZ2VyX2VuYWJsZWQgPSBmYWxzZTsNCj4gwqB9DQo=

