Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651E0CA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4Ld-0008GT-Lv; Mon, 01 Sep 2025 09:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ut2XU-0004KE-M0
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:17:32 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ut2XR-0004mW-OJ
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1756725450; x=1788261450;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=amPVrX+jmKm2/uDOdrP4xDSAH/CzR7LBcg7NaxuK/Jw=;
 b=QkcKMxPFzKIAOQQ721Lk0QAcHIq9FO4gurVHKHjYrdhnp6QFlxDhiYFh
 DScNsANupbOysrLF8rVFtdbnKjE2GTJiI7CcVCj/Z2e4T2LTtsI+8J9P8
 4gOq/ukGT59jLQjZRrbxcr6x4FkLHDVT5pvRyyVrsPM2iiNnEc0MjBHwP
 VuN614s49noYad2MJafPxsGIp6RezXBQ9//XIC/NNGC9Y0Od30+Um6g5l
 YnskuGmzc6q6C4x/BTTBR9kW7FGt43JN+kNT89LVZkVGdy5LqfMM4OE/D
 imXFcDECIrdI11xORigxAmVKM+zgAXfakrPRYrleS0ol+LyRau1BqqKa3 g==;
X-CSE-ConnectionGUID: 3bgnEg7jSPiVmr3K9FCi+A==
X-CSE-MsgGUID: KkjMts3FTl2yG+vca0Tmmg==
X-IronPort-AV: E=Sophos;i="6.18,225,1751234400"; d="scan'208";a="44649198"
X-MGA-submission: =?us-ascii?q?MDFRxcILZ71Lz8IZJ8H1xOF3Gx+/TCfXjRZVZx?=
 =?us-ascii?q?5Od+vcXGR7C1p7tRU+AQz90bOyn1iqG2RLz0Iz6o3oBNXUZWZYU8l6JV?=
 =?us-ascii?q?KHqufBAgMohpcjoyFtCkgFoZBCP3D4VXs1k0+525FzCsWxdhTrubcVhD?=
 =?us-ascii?q?iO3GK5ymHUZc9gyPHcHYTt/A=3D=3D?=
Received: from mail-francesouthazon11011025.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.25])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 01 Sep 2025 13:17:26 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8AASKdkRDTNkBDPnL+0tNsq7nLSt0o+kAWnb7yzMxErQDh1eARIM/3wYSpw1AZ3vP69vYDzQZMtPAwyXKYoS66FNlI+D4Fb1BmENYibCiRgqTuEITkAvWO7HCmTe8jTfBqHwhQFgysIpi8mhqQn7RrTSsPFPwW7cSH7cwoPsNOvvRSFbgpEibAmmEUByeLE6t0y1c5QKWujGs/mzhd8k5R0aN0uNL6tl7NozjnKvRYIuqSVtZa72n8DfZA+Zcdv6q7lg8cOEgKA/84kuUeeew6B8sc+JaeObFuupOpHRWc0M9pCsNFTILidhdrlvpPsD316ANLPKle09Y7ZBaJzhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XgBqkJ2w8BBAPlOMlCgmG8AAr4a/2XtJAoMjKXlbKQ=;
 b=NJvbCgR5005eIDEKXdsRhUJd+YMfh2hSzcyiLdfcQrzQGo7neb0wIdl2meY6RnRDoJmblKvKEwl0iYR0ztUb/iWN6oU4/GXoWKEerxWyGWjXSW/rC64XD2EWFbp7XdDijw0qWv3hxnL+MAMoIXo/vDLnT3/XdQnr8MUYlyap/Cd7ZUogEsrI6WfKm5gmBXa9oCMiTRWLnmx4TgDc9DJPDAD5lbYBJiPTEHBpdadK4XPADlkO2Ryk2V7rP6SaEMwIF4DeWNigWvkpc9xulygboZ4Q0WiFObUIrvR9az5HS09gjLfNkMINtrbEyOrjwV+kZbip5xiLn2FO8eCpTePfpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XgBqkJ2w8BBAPlOMlCgmG8AAr4a/2XtJAoMjKXlbKQ=;
 b=Ju4fVh8n0EuTrdirNaAthCiy2WwT/BcDzvtaWIPeXVxB+Eahia44E1STm6Dwm3SfsEbR7XQiZHo3RubBlB5s01G9F8hZVPOBZX7yVzVD2gDxdCClc18SnbIOSYCE6fZRAa1oD+gCxAGtIAcVCP4pr8ZKQjKfCNC6zfZe7YpCnCP616l+eofy7Hkqac3lIK+7HuZekboeZbBXOSZzlmB5twWnu7k8eB9FzPaG2NLuz8r4Z2j9zpRv3uZOPGbCM7ngXNbhu7hLzcn+/cOJARP1MvlU798kZe6SbimbLbCIhxh9UlyVytVD9BrO+LQINE5hkxZVVugc/0BiioQDOuJ3MQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAVPR07MB9215.eurprd07.prod.outlook.com (2603:10a6:102:317::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Mon, 1 Sep
 2025 11:17:21 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 11:17:19 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "kevin.tian@intel.com"
 <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "minwoo.im@samsung.com" <minwoo.im@samsung.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH 1/5] pcie: Add a way to get the outstanding page request
 allocation (pri) from the config space.
Thread-Topic: [PATCH 1/5] pcie: Add a way to get the outstanding page request
 allocation (pri) from the config space.
Thread-Index: AQHcGzH7Sukw9YjjskO8f5QA00gK3A==
Date: Mon, 1 Sep 2025 11:17:19 +0000
Message-ID: <20250901111630.1018573-2-clement.mathieu--drif@eviden.com>
References: <20250901111630.1018573-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250901111630.1018573-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAVPR07MB9215:EE_
x-ms-office365-filtering-correlation-id: 499e8e22-88a7-4bee-02b9-08dde9491da4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?PLJ/kWGnONOa9XHdXleFyUusNQbYCoMTycUKOsU24qFY/3utRChElJFkvh?=
 =?iso-8859-1?Q?hQjjrfmPQBYzW3rcO9K+Xe9872LCovajeVmXIRxwSa/Bud6XbAv9p6R5Xw?=
 =?iso-8859-1?Q?icSVjOswiqDWBa+5RwI9+8CAUd+aw3+bb/rNQnTZ4v5nYoU26mL6LYaPML?=
 =?iso-8859-1?Q?Pzn8J9/+Srohm4ShtxAgGjKRrpoI2U5vJrlvkc8li4Pp0lHfa0XhhznLU6?=
 =?iso-8859-1?Q?8ir4Mshjq33ge3CPSZiCpjkoskRJH+jceeDhhrD7KLI/SMtBkSyA6bVLNm?=
 =?iso-8859-1?Q?u/1UUCy+ZAV16fy8VFfcGLxfQ2Y2cztQH5jIFb8d71cVTHSiKOThXOPQNC?=
 =?iso-8859-1?Q?1jCbK3O9Fay92ZJtW5iHcYvY1e8Qnw6vBeRGZhyl1LO1fl09dPYIVeqcnF?=
 =?iso-8859-1?Q?YuyyTOF8RXMFPl8YiWPVuoF+5N64exgIcq+SxlX62xXtljEB9umJGcSovW?=
 =?iso-8859-1?Q?AvMdhp4YcpsEH3SSOEnniBxNDOX7Mpm94VYfQaL5diMsYgVsmkuBLIXNtH?=
 =?iso-8859-1?Q?EmASQ8RrSDlIEECuOg+h09h5Ycgz3PcmU0hdZEAiJQl2I38I5id4v/qqIr?=
 =?iso-8859-1?Q?XOpheItY6CQimqarGeIHBF+WyV/hcb7PoMMiu3FNGKpeP4aupfqPXm2Qyv?=
 =?iso-8859-1?Q?8XUiRxOGZysF67zdSMUYw2ecobtzUYc/WDwlL1WBhNTgj644BGQYhbgS05?=
 =?iso-8859-1?Q?HXoGmS/F0yumOfObaazLkENBGWr5qGuwgD4Cwr0eIhr+DH8K3XiaASbQdq?=
 =?iso-8859-1?Q?8PhKbAq2s9Eu7bk7mXSDv7CPAqGvEyjKwCLeVrV/KU7k4N/L8F2TIIogKa?=
 =?iso-8859-1?Q?x+85lh4FexYRvpzTXlzvXMD17jqWbtw1P3aOvXhBN5/n1ejsU/a89hmpRC?=
 =?iso-8859-1?Q?sI/NhO/AntTRxzKjpginxAyn5IuYKFU9QAJqvbVFwseivNA6g9St9FW+Ff?=
 =?iso-8859-1?Q?H5ArkKEpl+i5Ei9BBU8//bepxnVf4M4DWeTEjjZaO5kPVgthv/2NL6sjQE?=
 =?iso-8859-1?Q?qXYvZ8BNlvO+N4rox47mgdkR2V0JoTJqjqgPydBdhoKdm4HPJ3CQqhFE8a?=
 =?iso-8859-1?Q?QD5iAcrGxYNVb1bNXPlX39AeJKuYguoDkgiJsBTz9I8gWwgnkhoP7Gf0P3?=
 =?iso-8859-1?Q?iGtepTcF2x5FifBfrD1FCtm9g8VtYGJxy8rsEQwz8tGrvglO87sdARXbAd?=
 =?iso-8859-1?Q?j0gHmwSVVZ3yPGVrL5k7ksVAzccKbR44INCXUNyEmoseQ8hqthuJhMWDL1?=
 =?iso-8859-1?Q?p7zHq+cYmQEpTDbwBAKtIDOybOT860mgktZLRgh8/OSWCDF5ZWYl/nS8BD?=
 =?iso-8859-1?Q?txfeKzfJmFeXoKHF7Z5BMlFu2KGmhgAahrhLTRyezdAXf9cBnxBku1FfUD?=
 =?iso-8859-1?Q?34BWwMzbSIlN+/zLJqZyWn7oS2XrZDMMKo5IieqUkB37/EBrUUVPnWQDtr?=
 =?iso-8859-1?Q?Ufl12TXcWOHqhg0wzYCxlfTqDA5K9UuyKoNY03AleC/YZcQdPvbrUDq3QO?=
 =?iso-8859-1?Q?k1WcUc97ONCdQllLBYD3pLfZ9p7chLBGznk3+2o5Jdfg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?edzPqlmIw3MbfDpVXwRaDP8OR0ObgzE93S6SaXCdWXamd4jCmOsBWvXQDu?=
 =?iso-8859-1?Q?YZ/LKaIFx235qLoy9kwFUVulFNK3nNeRkbpkrxLdCokYUBXwrHOy02E7aZ?=
 =?iso-8859-1?Q?k1dGr7h9deCs0Vrm211PZGgQ4yrJCdLo0p+VX3qa/M2H3oDo3mE6Ycmpm2?=
 =?iso-8859-1?Q?QkCeKTb3GgXlXccdizYNYW39I6HKpl/HDevZGwEZRBGf/0S5ngqVz2fWku?=
 =?iso-8859-1?Q?GaYjyVIgDCxMmHdV4s2EkE8aB1JxDSIiJDqsXz3ppnK0Eq826HSxxAs/u5?=
 =?iso-8859-1?Q?KTF+rOc06mwFd+qs6Byw2h5xXcMf+wG9nt5cXhEesxBiDVh8dsrOitFdtX?=
 =?iso-8859-1?Q?4t/WLLTRf1r53qGKWzKTWCm22tX/IHML4BhlLpYqt6hyU8Z71PkLUEtORh?=
 =?iso-8859-1?Q?3Lv5peSFK9B83QuseQNDlV1XB/2XDH4ZeAmw3iaMORmZliqHOAVbu+Bvz2?=
 =?iso-8859-1?Q?CooIMNchFgufhRoM/1yKK+hhdVJM+d5PiQT1ncjasd2BimV9mqcUrqNKHn?=
 =?iso-8859-1?Q?9F51ozLh9k7ZHstZslBoiKmqutdZTh0Y9c5ycrYvYKre8LEWIHGSIUDSCk?=
 =?iso-8859-1?Q?m+31b45KhlOIQ7uNEh9UM7ekILG+7cXJUsmoAIbKDDMmNWLcfdHsssI5Pf?=
 =?iso-8859-1?Q?l2y6WRBc/4iwI7r2PmQc4WgUuZLVgSMr9IDxyxvyOLnULMhcEbYXWzwzk/?=
 =?iso-8859-1?Q?Fhrjs1+t52YKWRss+mIyQv3qIW7zkR15PkbqDY5x+efqAhIYJ/5h2yEh4b?=
 =?iso-8859-1?Q?2c5MUDO+2zQjt4UoCv3hVQ/Cph+j9qnqzHBa8iY0571lbc0MOK3EHKNd8R?=
 =?iso-8859-1?Q?XLb/WR4+RcbjOgL3aMZC10EKOxQoSHlzrT8HQeBbzAbXf7VYhHXIfbrepe?=
 =?iso-8859-1?Q?TWi27PWHhYI/ErByZxxqWf0JC2jvCRA61EgCCwmqf/xziOXl5230pZKdBb?=
 =?iso-8859-1?Q?cxowXIPyxXdZFyW5cdmqqQgygNWWuac5mQBRgH+ie1Z7Reo8ljMrcmPaGA?=
 =?iso-8859-1?Q?MC+CjScyw3vVYCadcbdQZLN1JztAiR0Iqf1u0bafCwSayyJ5kWVZihZFCt?=
 =?iso-8859-1?Q?+AWanB9OQGNAAHhvfzLuv0IhYH6d3ySEOyZXPtDezKihzXPAkpNQpvoJOQ?=
 =?iso-8859-1?Q?iJdJm6FdI3cRuZTWawkI9pI+lRQB0fIr3h/X0uBfrK+ezB/netuHLvP4us?=
 =?iso-8859-1?Q?4c5MB2gUyVWa9RgulYXFBKTti0/s2qiG73Xn15TdeCl0m2yGYofcFcX3jH?=
 =?iso-8859-1?Q?zs/Vi4b0y9zJbD+sISXhkuPO2CwXTOPBNLXgojG5IKUpZHLC0fxNZ9zQWT?=
 =?iso-8859-1?Q?jDowqBVMLi/kRoVquUyWnDdtxCWCNfBbIEcC140vRP3SFc3+hnGfeRWfpu?=
 =?iso-8859-1?Q?E/kYMxIc8crQFGs0Ltj5aIkP2bzahSnKAQRD7YO/1M739I89XHsTm1KMtz?=
 =?iso-8859-1?Q?EB/D0oakvcIU5wgUiGmCZXXUGaN+ldgLFKneLLR9sVJN/cqzDWmDsB34ee?=
 =?iso-8859-1?Q?svPKKkiU5Pezr2vrruBUbXRI5fnNmogf8SQIDA/OPJFHK9JmItWJuHUyVz?=
 =?iso-8859-1?Q?Llc+Yq7s1fGO0fiqD6ep27YXjHfTWtgNFE+5oq+gNyS5fweVB5OEG0y+bw?=
 =?iso-8859-1?Q?lRbpRki2I1kcAEIgWO9VCn+mvWzxi6PnyAEtUy2FSmd4Tmpmjlko84shnp?=
 =?iso-8859-1?Q?2tvfbULRZrlLEPZuzzY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499e8e22-88a7-4bee-02b9-08dde9491da4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 11:17:19.5539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TW7f3L7xRj4Oh2q6RZxOXW1o7arQjSJTH4rvk/J+/oB6aZWVOzyY5Fhb0ssO+32Y84BBUdFqvuQQWgJBitMOtvGjXmUX0W1uO/rkob6Tgak+VGDGp+JkNTL9wsOEWQNi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR07MB9215
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 01 Sep 2025 09:13:13 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pcie.c         | 8 ++++++++
 include/hw/pci/pcie.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index eaeb68894e..b302de6419 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1266,6 +1266,14 @@ void pcie_pri_init(PCIDevice *dev, uint16_t offset, =
uint32_t outstanding_pr_cap,
     dev->exp.pri_cap =3D offset;
 }
=20
+uint32_t pcie_pri_get_req_alloc(const PCIDevice *dev)
+{
+    if (!pcie_pri_enabled(dev)) {
+        return 0;
+    }
+    return pci_get_long(dev->config + dev->exp.pri_cap + PCI_PRI_ALLOC_REQ=
);
+}
+
 bool pcie_pri_enabled(const PCIDevice *dev)
 {
     if (!pci_is_express(dev) || !dev->exp.pri_cap) {
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index ff6ce08e13..42cebcd033 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -158,6 +158,7 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset, u=
int8_t pasid_width,
 void pcie_pri_init(PCIDevice *dev, uint16_t offset, uint32_t outstanding_p=
r_cap,
                    bool prg_response_pasid_req);
=20
+uint32_t pcie_pri_get_req_alloc(const PCIDevice *dev);
 bool pcie_pri_enabled(const PCIDevice *dev);
 bool pcie_pasid_enabled(const PCIDevice *dev);
 bool pcie_ats_enabled(const PCIDevice *dev);
--=20
2.51.0

