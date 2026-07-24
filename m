Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45898C531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 11:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnDsX-0004QA-CT; Fri, 24 Jul 2026 07:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wnDsV-0004PA-Cu
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 07:15:43 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wnDsS-00029v-Qx
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 07:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1784891740; x=1816427740;
 h=from:to:cc:subject:date:message-id:content-id:
 content-transfer-encoding:mime-version;
 bh=ttkjpT+rcqgr7C9D0WdW1brXG02vZfOv/vfPqIfzlH4=;
 b=iRPEyyNy8DwZzXeJKbOXpcFOKsTNyRW3r8Kr8ECGN8C7NCs8jumu30jA
 g3XV2ad7AR/jAlc/oO6w+vIL0tWCBzGoSyJbLeJW1jQksKR0jlQQww/+k
 P8qV/57u8dMRF/ri7DUr/9Hc4mgaNC81lhlIxIFhsZIAWAsR/nLHxoO7Y
 gRWyqE8nPI+jtdU4VmwPPFiDWT6RHw4HLndcFzuyaqhytJiqyWBWhceSX
 JITmvJTTxhYoeQRkMAZpKE7oAM/KDiB2lpOPbMlHQcKWkh/eFjb6sFaG3
 Yv6z6asMVEN+/8486BJg3XFDDVKS+KRRE+IqwpQPCng+EBjRfY97dLrba w==;
X-CSE-ConnectionGUID: w1/LTzLrS7yE8KtksJZaGQ==
X-CSE-MsgGUID: Z2yH8Ss8Qku1wKBE7C12Ow==
IronPort-SDR: 6a634957_zvTRrabYjFSTZgFr5SzMysCS6CXviSVojBnenZeNfUo7KNn
 aDCTudZVEQDmAiAC5H2dn5BCY7V/mPmgVakfMdQ==
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; d="scan'208";a="50598789"
X-MGA-submission: =?us-ascii?q?MDHySTy+WR052uJyiY7YxgH3vgeIUAuZpy6oMA?=
 =?us-ascii?q?p4MpC7LvzHCoG0zpJiU+xbUmjP297ZKdpbTBt8rzcE4g1t3qPEGn4eoI?=
 =?us-ascii?q?o02IKtT1sX0+xFg0vkVEblCzxDOG4qEWM05E2z574KW50hMNaBrrtGtV?=
 =?us-ascii?q?8SDBOM2wsfAG1e+hPStITKrw=3D=3D?=
Received: from mail-northeuropeazon11012046.outbound.protection.outlook.com
 (HELO DUZPR83CU001.outbound.protection.outlook.com) ([52.101.66.46])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 24 Jul 2026 13:15:35 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRRp8neEH202kw9mQtfjOHYDQaUZNTshscjOfYi0ByJIhkdJYhl71cibX/lH9rN7s1hdZ7NBXmlU6YrSwAmO2G4zqm23eejM8WjT7udB3iBOhPyQwRcpTG5507Lz5Sz6ogq3+pZ9YucnF7JjUYvREVAI3q84W2TBwLq2Y52jCDwZKCrVfZgJF4DuZx7nTW/kqltEkem1lh2nxHsNbQh6a3G2nSIxZjCvP6qOd4/ZC8K7jXqhzEKsWtvRClvytHz3rdBssvpdc3qtU4x/+4qqVO6SQhxAUmfbS7IVmfgs+TAqObANjnAwyEcnkZWf0cFMleO7DQxVTgjfGPq+j6N7uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttkjpT+rcqgr7C9D0WdW1brXG02vZfOv/vfPqIfzlH4=;
 b=hNviKC3RCzWW71YNeTtd40cx5lF5uunHap7zuZhFJA+3Wc6M1VzM6u7K+LZuc+Xm0R0J0W/trnlTskqEZmn5T8O4Y8xlQ7+C1Zb4M5hgu0gsgBsXitF610KCtwjX/DNIna4w5HxT8blF6GtkEI8r7bCrX0xn2KQC2mNOZ4EN72rQ37piqAuAYpRrrTxWRKpB+XfBob+dWojiqu8xTIOLACzsgBkyym+pPIK1LKRzyC/XFOZZ5uWcAnGADTd/aTMFQitDQaxj7VLI1wQRu42jOE/79ivgT47HWNj2GdbBETel+T71LUBtz85aWHi6DeuOBx4s1qnDq8Y3YiIZXTkaYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBAPR07MB6774.eurprd07.prod.outlook.com (2603:10a6:10:195::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.6; Fri, 24 Jul
 2026 11:15:32 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%4]) with mapi id 15.21.0270.005; Fri, 24 Jul 2026
 11:15:32 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "philmd@oss.qualcomm.com"
 <philmd@oss.qualcomm.com>, =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
Subject: [PATCH v2] intel_iommu: Check address mask before using it in
 pasid-based iotlb invalidation
Thread-Topic: [PATCH v2] intel_iommu: Check address mask before using it in
 pasid-based iotlb invalidation
Thread-Index: AQHdG12+ugJmxoQDwUaH45x2quwn9Q==
Date: Fri, 24 Jul 2026 11:15:32 +0000
Message-ID: <20260724111424.376680-1-clement.mathieu--drif@bull.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DBAPR07MB6774:EE_
x-ms-office365-filtering-correlation-id: c41f2f1f-19ab-4b4b-9981-08dee974e0a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|18002099003|38070700021|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: GhkxOWJ+dlhG0+phpscsV7QBYzjWDho+JljuLRaCMnx8BVeGVIExkQXISAkt8APrZreWMH4wSwWGjqlvM/RhkQTHFTbK+oVyAFGbJnDgitzKmSxAPlms8mMsjYsFq1AEau+hGcbjGd+8a7JZTcTneMVq2oxZp37ZZOLhEG9Fe402d4TMzG+X0uRnQxaAQy7UFD6FHoJzCMiaDBjqyCs7erWlvL+vqb6VlZEWsN8N1BqRqlfRPkT1kq0WE0no7r7UnipTczieLmN3aplueYfDXnwUu3oiLyfe8dFC3IlBXxgpguY5PfSWjigZ0C8ysmsDhLuo8LoYQ4qARSSn5cbh+Qpaq/kXbwdfDZGCRrBZkULtcgalsD1aipuRXmkDFIcTfqoO9K7FKdITQd1u8/CQpSaUcOpPpKSsvLHfczZmNUSl4DQshWHiZVha7W7xciMS9rfEnkrxhxMhLwnFVBuj6c/vGIasT2zxovc5KkSNxcpRjU8brmjyYl26GWDfU5LoXcAOZMZBxY/Trh681QGbg84WfcP6cABgDEYXkF9mhQ2VoMJjwjoeO2Z+cjsIFKBTRshRPokGQN1mokru9tFdj/iMD76I6fQGFXlnUVwsQjUVctCIvfO6sRH62f5kgx1obdxzYpPTZoZjdVJHhyJm+7Q3lBRmf3Xg0GGSzrDIwA2j1+KPpReYXSWOINr0SLkFz6cv8PVb1gOapecpyAZmrh3g4FGc88suqPSdLdFVBXk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(18002099003)(38070700021)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MERQUlhzUjVFblFqeURKRGlNOEJnNTJHb2tmc3BQL2F2dFk2NU5ZVFNWejdy?=
 =?utf-8?B?Ulc0Sk9EYUs5QjU5cHg1ZW42TkppWDJJN2NJTitKYVlkYWRSWTA3QVN5V1hX?=
 =?utf-8?B?RGNQM2Q5aXg0cVA3WTB3cDhYMlVUT1Nsb0UwTnVtdUxiWFpWK2ZmL3o2REJJ?=
 =?utf-8?B?aGFralk2NWNqQ2dSVmdrOXZncG9XNGFkakxqUGlTRlVML3RQcXB3YXY2UG5B?=
 =?utf-8?B?UVQrdzB3Q0VERGZRajJ2UzQ1TlJsRG8zWjF4NUwzRHhlRUZUanRKMUlPTUJH?=
 =?utf-8?B?ckJvV21GZ1NJS0VJTk9JTW43WnJtWTdKYndKUnZJTDd6TWpTRXJDVTJkbk9u?=
 =?utf-8?B?QjJrenpFNDR4VXArUGtCNHBveEwwRGJ6b1J2WnVObVVnT00ycitpMVRFanhT?=
 =?utf-8?B?aElMSmpGS096R3VSbW5aMit3RzRUcDhyYk00ZUM4YkxHRnJva25hZjhLM3g4?=
 =?utf-8?B?L0d4RnpSVnZDc24vdjcwZjYyYnp5QVY3anBJbEkrdk9nQnJ2VnZrMnRCYlZy?=
 =?utf-8?B?Qkt1cHlYUE1pVzZsTG9XbjM1SHFuOE84dm5LZ25IS3pmQzZ4UVIyUndwci9J?=
 =?utf-8?B?WEhEVDA5YXRmaW54bk43RDFqUFc5aHR3T1RZR0J1OHlnNlFYNkp0dDBQZjc4?=
 =?utf-8?B?VUYrWlhOYzV0andXUDVjNjRibUIvVG1SS3RGQ0ZJY05WSzYwYkFscmdXUGtR?=
 =?utf-8?B?NXdLSGNnNnlKbnk3Uzk0aU93VXJtMFJCbHZHRjByZ01Vc2VncHpWeXd2UFhN?=
 =?utf-8?B?NWw1MzAwcEQyQWVsdWtFbGtRRG83UW1xZHlLTXJyekVoalU0dTR6VURVUWJz?=
 =?utf-8?B?ZWo3SHRPV3cyR0xBM2NsT0NLUnZOZk5IN2hUcGx6VUVmYWI1UmV6enlZWGtl?=
 =?utf-8?B?empKc3l6OE52N0ttMU0rQ3YzYUo5ZGdUdkxXK2J3OFFxOEZEUS9YcHhzYlRn?=
 =?utf-8?B?bFFJbTdDVjJOM3RROFlqU2R4WFhZRTk5YVpGRGFvUTR5UHU3N1FhTkE3dVVC?=
 =?utf-8?B?Mk44aDJsL3pXeU9GaWhWTC9leFJZcjkxTnYvVUZLSWhVOHVJVzh0YXRyRUpu?=
 =?utf-8?B?SVc0NkU1ckZrUHkySC9YWWI5SzRRaVRuWTRRTWtqUm9aVHNTOFNPamlkMERm?=
 =?utf-8?B?b00wUHJadlk3RVlBbVdiQ1AwSUhEb1RwTlBGdHZ0K2cycE9BQStsM1BSSVF1?=
 =?utf-8?B?ZUdUUjlpc3lwMVA3dS90ZTVhZHYzY2djLzZ4WFRzTUxLS2lvUTNVbGt3U09q?=
 =?utf-8?B?Q2pQVThrWTdQaG9maHk1OENhTkxGS0ZCOEk2bktMUWhnbVhxd0ZLVDdZbGl4?=
 =?utf-8?B?YUpseE9Rd3lLeWdJVmo1T1FaMTEwN3BZZkc1eDcrUkVIREs1R0RLdEdlb0ww?=
 =?utf-8?B?ZG56S0hUK3pmNGtldHpZcHdmVkd1VExhMzQwb2tzdlZQSGYyRmptbm54M1Fa?=
 =?utf-8?B?QzMyTEJrWkVmVldwcCt0Y2JmYjNWTXVVWGg1dlNIZ2dJT0pVelExdGlDYnRH?=
 =?utf-8?B?UTJhcEV2Vmh1NDhRV1JiemZPK2s1dG0wTlhjK3NXS0c4Mml1OEpWTGNuRm51?=
 =?utf-8?B?VEtneTB2b0tESmIrYjNvUFpXNTlYUVdJWm9NTS9xWm9YRmJiTlE5Tkh2eUpY?=
 =?utf-8?B?d2R1T2xESGhRQWlqRnBHWlJ6eXNtSUVmMElXRWhGWU41MnY0bEhXbDNaanJO?=
 =?utf-8?B?alNSakY0aUh2RW5YcjhyL1pLdkZKaFROUVhZSXJ0THdBN1VSOVhaSXdoOEhU?=
 =?utf-8?B?bFVzSEVFZFJJK29qcTlTdTRyZ0QrRE4vdHF5SWRaNkVjcmdLU1IvV1pkdU5t?=
 =?utf-8?B?K0lkbU9neEVhWWgxekRlN1NLa0ttRkRZbkpnczFuRjhLSUJRWlFTck9GRC8y?=
 =?utf-8?B?QmZYcUtvMlArVUxzaytxZU9DL3EwQ2pEUEg3M3p5MnYzWUFBUFhtbkdMWERQ?=
 =?utf-8?B?cE52ckh6VTc0QVRkdTZ4NzFSSjB0S3pLaUkvT3VzKzJqdUdhUEtoZUpLd0Ey?=
 =?utf-8?B?UzhLM0xoNUFhUDMvbVhKQUVDOFMxc2NmVGovRVRvOWY3Y3NkL3F3U3F6Wi9u?=
 =?utf-8?B?QWpMR2xkblJxNlU3V1lUaTJBRTNqL0tEeXM2ekV3emZ1SFllRld5RURoY0tM?=
 =?utf-8?B?WTh1aHJGcmVwSW0xTUcrZlIxSnVGN1o3WTEyU0ZQaE01cDcxNmFnNWltUlJL?=
 =?utf-8?B?N3QyWWtWQzRVQnE5enp3WDRxWGNWSnpRa2dsK1dwVFNYNjZjY1krNlVPbnhL?=
 =?utf-8?B?MHExN1V1TXJQNUZtVk5PS0dUMDVhVE96QTdwWEpIYk9sM0ZLUy9FY2NCUTNq?=
 =?utf-8?B?NjJRZWlyRHBvZDRZMzVTUVBJVjF5QXNEUWQ0RzhjWTV1bHNRYlUzZjBsTi9x?=
 =?utf-8?Q?bWjndD2t9EhPgHXF9Tp5wqgy0BA6xuSNImp5z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <958F8A34284DD14BB758DA789439F74E@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FzizXcBoRZ1w4YdH/Q2pfaliRiIyyl+cE2wT5R6eIxl0WWtd3dqWj6w9r1QhTq54TMPnAbKJW5zaZzqdF5ur3NLsfDjnEVRr4CG6tqfCsdppEUrx29LABnKI7aaopZqjd2x6vKa72h+SptRHH+WmCq96EvsfusQM9TRmjTvc3hkwMNwsOH9I9igGsCiBLlrSE931gTVslvTiVJZJZrMlWJE8KJYTs5Dqqa3ZIMsuJxUhWCvXOvWxLVm3xlJ5gsXeSQr/SwG8PDbPjqEMkQaaPlSsNAra62XxIwEvX9mb4tXASVtrmObiW1vB3ipZ2EyBnnT+9dSaURijmB5YvxHe0g==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41f2f1f-19ab-4b4b-9981-08dee974e0a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 11:15:32.7301 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EKPkGV5AQU7pYehauhNDkLgCjnFTpEcT3T+rAOS+c4N6lRBDiAHl/ujLfUIuUhJmKHe8mgnFVd882oUxxJ3TiwyhsUJyR+uLP5Yev1G6nk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6774
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

UHJldmVudCBhIGJ1Z2d5IGRyaXZlciB0byBleGVjdXRlIG1hbGZvcm1lZCBpbnZhbGlkYXRpb24g
b3BlcmF0aW9ucy4NCg0KQWRkIHRoZSBzYW1lIGFzc2VydCBhcyBpbiB2dGRfaW90bGJfcGFnZV9p
bnZhbGlkYXRlLg0KDQpMaW5rOiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUv
LS93b3JrX2l0ZW1zLzM2MTkNCkZpeGVzOiA2ZWJlNmNmMmEwNjYgKCJpbnRlbF9pb21tdTogUHJv
Y2VzcyBQQVNJRC1iYXNlZCBpb3RsYiBpbnZhbGlkYXRpb24iKQ0KU2lnbmVkLW9mZi1ieTogQ2xl
bWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb20+DQpSZXZp
ZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBvc3MucXVhbGNvbW0uY29t
Pg0KUmV2aWV3ZWQtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+
DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgfCA5ICsrKysrKysrKw0KIDEgZmlsZSBjaGFu
Z2VkLCA5IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUu
YyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KaW5kZXggYmY0ZjBmMmY2Yi4uODI0NTQ1MmQ4OSAx
MDA2NDQNCi0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KKysrIGIvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jDQpAQCAtMzAyMSw2ICszMDIxLDggQEAgc3RhdGljIHZvaWQgdnRkX3Bpb3RsYl9wYWdl
X2ludmFsaWRhdGUoSW50ZWxJT01NVVN0YXRlICpzLCB1aW50MTZfdCBkb21haW5faWQsDQogew0K
ICAgICBWVERJT1RMQlBhZ2VJbnZJbmZvIGluZm87DQogDQorICAgIGFzc2VydChhbSA8PSBWVERf
TUFNVik7DQorDQogICAgIGluZm8uZG9tYWluX2lkID0gZG9tYWluX2lkOw0KICAgICBpbmZvLnBh
c2lkID0gcGFzaWQ7DQogICAgIGluZm8uYWRkciA9IGFkZHI7DQpAQCAtMzA2MCw2ICszMDYyLDEz
IEBAIHN0YXRpYyBib29sIHZ0ZF9wcm9jZXNzX3Bpb3RsYl9kZXNjKEludGVsSU9NTVVTdGF0ZSAq
cywNCiANCiAgICAgY2FzZSBWVERfSU5WX0RFU0NfUElPVExCX1BTSV9JTl9QQVNJRDoNCiAgICAg
ICAgIGFtID0gVlREX0lOVl9ERVNDX1BJT1RMQl9BTShpbnZfZGVzYy0+dmFsWzFdKTsNCisgICAg
ICAgIGlmIChhbSA+IFZURF9NQU1WKSB7DQorICAgICAgICAgICAgZXJyb3JfcmVwb3J0X29uY2Uo
IiVzOiBpbnZhbGlkIHBpb3RsYiBpbnYgZGVzYzogaGk9MHglIlBSSXg2NA0KKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICIsIGxvPTB4JSJQUkl4NjQiIChhbT0ldSA+IFZURF9NQU1WPSVs
bHUpIiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgaW52X2Rlc2Mt
PnZhbFsxXSwgaW52X2Rlc2MtPnZhbFswXSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBhbSwgVlREX01BTVYpOw0KKyAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCisgICAgICAgIH0N
CiAgICAgICAgIGFkZHIgPSAoaHdhZGRyKSBWVERfSU5WX0RFU0NfUElPVExCX0FERFIoaW52X2Rl
c2MtPnZhbFsxXSk7DQogICAgICAgICB2dGRfcGlvdGxiX3BhZ2VfaW52YWxpZGF0ZShzLCBkb21h
aW5faWQsIHBhc2lkLCBhZGRyLCBhbSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFZURF9JTlZfREVTQ19QSU9UTEJfSUgoaW52X2Rlc2MpKTsNCi0tIA0KMi41NC4wDQo=

