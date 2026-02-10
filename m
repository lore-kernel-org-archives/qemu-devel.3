Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096ACEA3F04
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 05:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpg1U-0003DO-C9; Tue, 10 Feb 2026 00:10:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpg1F-00035b-P0; Tue, 10 Feb 2026 00:10:39 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpg1B-0000Go-HO; Tue, 10 Feb 2026 00:10:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ct8yq3F8Mz9b6o4wdQdMlx2EgNWSDYMpwL8JrWT9Foy+OdpOOocEEauXjL6EqB4wKuIVuBvj+Y0lticyG5f+7jv1gw4N8LNCyjTnk9Ae0zRZQJ6HYVUZgDeKFrfRJinyaSp2v8/7WZFlGHkyCDiHiQ0sOaHoHiSmdforKy3xCn3NystJFrAn1oAGdfiJbk38o5D3vlsvyWAt6gAmNwoWLNpW4WePCPcFWbpNAQ9kQMAGdXN+q1o5zsyQ4Pqay/P5grXNTzveeuGrtGiZvQZy5kMroyZaW6J3snelhf699cMErurBpmzCd0yyOhwgmQGncul54DMQIrPRjx9t56RWZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyrN4jVN1LtUeJ1cNws+7LBx6ls5ieFybZ6T+rhipKA=;
 b=yKoYZCKRcZ9lUCz1TM6g61tIGCcyIVuHrt8v2/c8xVA4ZkcrGTNi5QuPUE1STXPffO0v9hGG0L74OmhAKj5YaIhi7dJ3rfhxIuRYyG7ns5v9QYwCDnCI8fmHarcyYVGedMNZDQERmACH6mLqsq3PLJ/mVcQ0sR+AQ+dcsa1LlvM/Z42Qb9MY0sroBlaskYNOwXR1zi8QM/YzKCJ3/2mO8g09UhtPODlsCI/abPMzmLGZ0werUmo7DLsjHg/2Qh9tu5oz5KVU/j7jf0Z7pAN4Gx8VDTdBeLXm4/zWPrFGS9A0IRIkB+748DieXmkJTK9o/nojNM2LCCASvsoLs364pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyrN4jVN1LtUeJ1cNws+7LBx6ls5ieFybZ6T+rhipKA=;
 b=Ge2n3vVqKKPJGK/VzM7WBSmaw/uFwgKlrlI+4TsylbCZqveopQYonseXpbFUK7gN0OSmaN+nvJK5XaFvdQpAQFHPtJXZx0xeROyC1aHnKx04Oe7cfZUSxydtPWm+k6Mn50gbVZmk4dA8eyf/nWJaLPztuF77LZx7I3WeeVItbiHGGKqIdWCRn2+eNxUE9Gu+XI2IBW50ODbPwLND+26fohIcZvY+zTkNvmixOMg/ZZ0FRuAmLdgFiRhz3I/t4AYHkfSnUopQM6WNuS7fLroefL1nd+NyEsgnekqo27Tx//KGDHRSYunpUrspyQKS1To5rzy1/+Ib6et7y0nTRgs9GA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY1PPF9851F8D71.apcprd06.prod.outlook.com (2603:1096:408::91f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Tue, 10 Feb
 2026 05:10:16 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 05:10:16 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: [PATCH v2 06/11] tests/qtest/ast2700-hace-test: Use ast2700-evb alias
 for AST2700 HACE tests
Thread-Topic: [PATCH v2 06/11] tests/qtest/ast2700-hace-test: Use ast2700-evb
 alias for AST2700 HACE tests
Thread-Index: AQHcmkuLhnDtypIZREmAdCHhY1LZ9g==
Date: Tue, 10 Feb 2026 05:10:16 +0000
Message-ID: <20260210051008.355149-7-jamin_lin@aspeedtech.com>
References: <20260210051008.355149-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260210051008.355149-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY1PPF9851F8D71:EE_
x-ms-office365-filtering-correlation-id: 6e324b7f-5234-4f55-b6b2-08de6862ade2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Hs+YhIi1oiPeBpkCNiU5rvQJcgXQJQ5EpZLv+zURyoby3x0ekFxhHScxLm?=
 =?iso-8859-1?Q?WmBmwvukzeIB5G0kxq5wqie4D9e4kjSNTicKGKagb6ydn/0QcGiUPYdy/f?=
 =?iso-8859-1?Q?G8ytNH10dJKO4Y9cLQ5FIhUKtU7mdLJlXuYJyMPyJLsSFcp3vH7MP8GQws?=
 =?iso-8859-1?Q?1c2tdp8hdDqxQNdAEMEBo0YZWIbsMkJIc15VP+MRxN22DAcjPUzI6Mc5vn?=
 =?iso-8859-1?Q?yPNkL8JoNL3AZlYnqyPNhRwrViwo10G6KYDvBr1x+i7RNBslzR4grAd+PZ?=
 =?iso-8859-1?Q?zyJQaDaWncss153k5cOl0kDlbOGR3UdMYBdwhs0cVGPJEMg+80SAt2xv2B?=
 =?iso-8859-1?Q?f9rUuWHomBAeafhIcXPe5ntfyg5SpV7ldLrWvFiT+rcBcaJxw7xkwnNMeI?=
 =?iso-8859-1?Q?kuQBNIgXROhfbimNAgy7hI84mBoLKQJq8qPZc0e4EQ0YGvlx1zKAa1YANW?=
 =?iso-8859-1?Q?djbuiMFW0tDXz2wN1NrEE5Sk4I5Q/qhNEZU/S+kDGMJZaybL8ykUhovYYN?=
 =?iso-8859-1?Q?x08GvuXSVCFIA+c0dRNihPf7kZRHSPkaILyzIluiCf5Em5IvpW/3Woll7O?=
 =?iso-8859-1?Q?EoBylnJpOjaEVHZJ8w6zIW6oC/AZaH7PKvogS33wY3LuPcGx9iUycj3xoq?=
 =?iso-8859-1?Q?NAqI+QmVnYomshtVg/aydT+RzYqcq7ai5OgUW1UZpRw9v4YmOGoYQ1Ghg+?=
 =?iso-8859-1?Q?sa+33iT0FL2ff9/7l+FEkjxwoP7c/s1v9BxjQe2oSPQo6LjCAymQEPC0th?=
 =?iso-8859-1?Q?p/XUatYJnfhl43XDpKc9xR+rjGXjpsTDS616JnqwCJ+5LKB+Gp0wJv2nH5?=
 =?iso-8859-1?Q?5zEXdEBbXzXj1XtYxTIvP73Oj3tsdlUs77fFpWtF8tonPXwr+ycvY7INGp?=
 =?iso-8859-1?Q?C4T0l9fGfDK3q7/vnUfaUpeXxKD3+UMe/UkCXpfyVkZL/KHILVuveojd4F?=
 =?iso-8859-1?Q?DCKrhib1RYOrgEN8oDWk9Af6n2X1YUDAaD/8M2J+1a+P86n78vhOknwg6v?=
 =?iso-8859-1?Q?jhvgLOMCRSpfP8KmLkpWkU5YWCRCljq/ETgpGAXbT3uGpenb1cEuNsmObM?=
 =?iso-8859-1?Q?h9KzhffApDxY1w80gWb08TMKj0h6zDw6KAYIRbNuzBTi0XuzWtvQyNTvVW?=
 =?iso-8859-1?Q?LuIFhtO5CMCpSEMXWs9SftltjmeeFY3gOpNKSytopbGA2RTB3w1AMLGq4a?=
 =?iso-8859-1?Q?bF53zFNeCgZn7eZMQLueECOJRnTSRr4Zf8e7GZskltIZtvNIgFOFhJyojr?=
 =?iso-8859-1?Q?jAukGrz5ugHQnPFcQ8c/21fUJhHGTB+ClzeEt6jtUOPn9PO5iZGkv7DrHT?=
 =?iso-8859-1?Q?ArM4hNC10lIOjA8nIgkKPRJSUscr2IC2xjBLSLkc9JsWoWzKWabGpR+J6M?=
 =?iso-8859-1?Q?X9g5TwFchv/ABrn3e1kMwStWl3SANo9/Crbt0sRSqL+ywLx98tamLG46a3?=
 =?iso-8859-1?Q?cO5C2TFKW5qlXy9XzByYf6S/MSTJgxtvYJ09AECN00K7SdYKCR8kUPaNNd?=
 =?iso-8859-1?Q?00Xn2+STFIawsa7+0DWUTEI1VF2iujrYGdmkULein3riut20IldWUjKMGR?=
 =?iso-8859-1?Q?Zp3YfOLcFrVnPT0kTqabvPk5kY+4G1TJ51vwS9rCV3x4/4r6LXsqVs1UoM?=
 =?iso-8859-1?Q?CG6qt0GCNL3jepvqEZkTYur632nkoNd8HpRq9MvLVpE9mnSIkTB02WJa+D?=
 =?iso-8859-1?Q?wbSnibAT89Qonsej+92JpZhHePzABGrmZgNvv16f?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?f12V9L+4SUE70Qv5MmrQdKmUhoMlQGFQqUQbrY1MgJ7E/Bm/m6Jkw3iyKi?=
 =?iso-8859-1?Q?Ays7MxoYUrnF3xk8vV53MLMo9rrjm5uj/KgypeddrisCEjvcvz0VZx33R1?=
 =?iso-8859-1?Q?MdjMNfY9ODIsLkWyh/eKn3spDAGEHPs1Mu3JkwfYyr4ZYzlMQzLG3WCjvr?=
 =?iso-8859-1?Q?n6sn5I1HH6RFftQDhUaG/wqCGoBQJ2zibZTK73Pkg8a/GniKjZ/8PT01h0?=
 =?iso-8859-1?Q?YJyc/HzjOkZ1U2L6u9mkRaZLSH+2UbVNKVaI2iRzhSI0nnWmRUSh5djq3O?=
 =?iso-8859-1?Q?g6z897UA9AjX4tc1zUTHoF2s4EQvRETNPZJE4aHFBWF4AQdZHCQzdsdnwa?=
 =?iso-8859-1?Q?aWV0/Z0Ui7Hslc5xqFsLZTNiW0XKJN2RM9yCf0Yf0MzxQgaVwoLES25tUa?=
 =?iso-8859-1?Q?A9AyV63unv1sJVdLdTRMTdWjKFsH7vevC2T8bEACFNLFtjo6SS/wXkByw4?=
 =?iso-8859-1?Q?XH1xP8rYwchxRcK2lNNuthFtjwhwHbT6UdRQuYXSLus16ucc0QFsV/Ivll?=
 =?iso-8859-1?Q?1FEYeqftbJ5nilUPSv0BVqtAd5iqwCRTmnTsa/GJYqDCxHXWUaE7SO3pi6?=
 =?iso-8859-1?Q?46NDAb0uf/Aqt5Wtyf7+3MXpxBXuKr8jwYw/sux6IkUeSDjpbJ98uZLKAf?=
 =?iso-8859-1?Q?ShHluoQDzqL4qWC2NQnqLx5P0Rsa7p4Xdt2+tXwzvLlM0RMKpqp+6fFUDn?=
 =?iso-8859-1?Q?88JgpDRzu7xkzUwuuNe2yPiNSQtcB+hHq3xJMEJZ+u9nsrtkEACouuYA8b?=
 =?iso-8859-1?Q?fbUrMhWJtaKs7cfrSW0djETy8s8P5UrRfAT+yQSjbOiRrcEMc3V4N3TYu4?=
 =?iso-8859-1?Q?TTf5R097OOcMkFEuvweNb8dYviZ1ige72M449Mw332e0tfdPxhiYFBvu+P?=
 =?iso-8859-1?Q?pd74fSwywlmsSb/G3bN9Q63+rjyJL56lxiDBa1/9I7tApgw7GM2I5WUq76?=
 =?iso-8859-1?Q?6iCSnRxOxvWAAZNm78jVkotPSh2Nx28r209py5mAEhULabw9/iKDQ2haFz?=
 =?iso-8859-1?Q?hsKScieannxiUNU5Y/Rj1vvhebKJvHpK3iDxz/4cbmMJ/3v6eUAalXWyCD?=
 =?iso-8859-1?Q?HBHQLG9xtHTz9VT8DBwWiw8yYt7y0FRizSftC+7dvczWzDX8AINumKYpO3?=
 =?iso-8859-1?Q?VqOY2q70RsFWCGjAQN2j3N5rPY2aqzPwlT/zpwpGBCQUy4XGlnlbFpKFvj?=
 =?iso-8859-1?Q?181a0Y8ZrKTTiHQlzUEdXQP+51v8EG1E8QdebGggPDPEI1S2qQe5sbPTu9?=
 =?iso-8859-1?Q?c+JRITM8UqP4wTcadz1Hg8JKwFl6b127Xx3dgMC7tYletyTIQZ9qNIAZkN?=
 =?iso-8859-1?Q?wV/o89B8NzZ/DF6Qsmemv4WUvxhID5PYfiTJjQEHraRNI8KTTtNk40Z5q4?=
 =?iso-8859-1?Q?YUHOQKrTuIDgBZgtW2+SaOhPfTi74sDTXb5fo6cH5gVBpL/jklfW6ansNd?=
 =?iso-8859-1?Q?/5F7c+bXesPCvEiyWjlpE7W8DtYq1D0WEUISxJfvUoOyoz1DN2mImDJW7E?=
 =?iso-8859-1?Q?TWrj5DRs6/3pN+dTtSkKAgkOR9FMUE0Zt45gNzkxRFQDNCBmGPmPCBwdHr?=
 =?iso-8859-1?Q?J8+G02bwdnkfxEF7bsl6WcGIacuNTaaMUgyhWAc4urdCYKe1yqtLoXdizg?=
 =?iso-8859-1?Q?xrfAUGf1KCKKrDYXK1nuBXQM/JcIzcYv18U/8LORBx1OA3jUy53w6Kz2in?=
 =?iso-8859-1?Q?BXCz78jnJjCQRJnz1/NGmBfb9c3OysdkuX7T1iZSDeS5amCTTl7WOV+8Y1?=
 =?iso-8859-1?Q?nNuZ9ndoPPz1CBrdpdIjNmt2lcTUGHOiWgseYG3TL6ZFia4CH9kJSdEwhS?=
 =?iso-8859-1?Q?YSbzjIP4/A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e324b7f-5234-4f55-b6b2-08de6862ade2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 05:10:16.5920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JoMT/K0H+vG90gRoM+tQtCeCxwJ+KkQIA9TR+7Eyj+MqFdl4jGW7lU4vcAFJmmxQ/OrZypnpqf/jNorkRaaXpzLEN4jafrayCU5rXXVnUVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF9851F8D71
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

Update AST2700 HACE qtests to use the "ast2700-evb" machine alias=0A=
instead of a specific silicon revision.=0A=
=0A=
The AST2700 A1 and A2 revisions are compatible for the HACE model, so=0A=
the tests do not depend on a particular EVB revision. Using the=0A=
"ast2700-evb" alias ensures the tests always run the latest=0A=
supported AST2700 silicon revision.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 tests/qtest/ast2700-hace-test.c | 22 +++++++++++-----------=0A=
 1 file changed, 11 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/tests/qtest/ast2700-hace-test.c b/tests/qtest/ast2700-hace-tes=
t.c=0A=
index a400e2962b..508a34dd6c 100644=0A=
--- a/tests/qtest/ast2700-hace-test.c=0A=
+++ b/tests/qtest/ast2700-hace-test.c=0A=
@@ -23,57 +23,57 @@ static const struct AspeedMasks as2700_masks =3D {=0A=
 /* ast2700 */=0A=
 static void test_md5_ast2700(void)=0A=
 {=0A=
-    aspeed_test_md5("-machine ast2700a1-evb", 0x12070000, 0x400000000);=0A=
+    aspeed_test_md5("-machine ast2700-evb", 0x12070000, 0x400000000);=0A=
 }=0A=
 =0A=
 static void test_sha256_ast2700(void)=0A=
 {=0A=
-    aspeed_test_sha256("-machine ast2700a1-evb", 0x12070000, 0x400000000);=
=0A=
+    aspeed_test_sha256("-machine ast2700-evb", 0x12070000, 0x400000000);=
=0A=
 }=0A=
 =0A=
 static void test_sha256_sg_ast2700(void)=0A=
 {=0A=
-    aspeed_test_sha256_sg("-machine ast2700a1-evb", 0x12070000, 0x40000000=
0);=0A=
+    aspeed_test_sha256_sg("-machine ast2700-evb", 0x12070000, 0x400000000)=
;=0A=
 }=0A=
 =0A=
 static void test_sha384_ast2700(void)=0A=
 {=0A=
-    aspeed_test_sha384("-machine ast2700a1-evb", 0x12070000, 0x400000000);=
=0A=
+    aspeed_test_sha384("-machine ast2700-evb", 0x12070000, 0x400000000);=
=0A=
 }=0A=
 =0A=
 static void test_sha384_sg_ast2700(void)=0A=
 {=0A=
-    aspeed_test_sha384_sg("-machine ast2700a1-evb", 0x12070000, 0x40000000=
0);=0A=
+    aspeed_test_sha384_sg("-machine ast2700-evb", 0x12070000, 0x400000000)=
;=0A=
 }=0A=
 =0A=
 static void test_sha512_ast2700(void)=0A=
 {=0A=
-    aspeed_test_sha512("-machine ast2700a1-evb", 0x12070000, 0x400000000);=
=0A=
+    aspeed_test_sha512("-machine ast2700-evb", 0x12070000, 0x400000000);=
=0A=
 }=0A=
 =0A=
 static void test_sha512_sg_ast2700(void)=0A=
 {=0A=
-    aspeed_test_sha512_sg("-machine ast2700a1-evb", 0x12070000, 0x40000000=
0);=0A=
+    aspeed_test_sha512_sg("-machine ast2700-evb", 0x12070000, 0x400000000)=
;=0A=
 }=0A=
 =0A=
 static void test_sha256_accum_ast2700(void)=0A=
 {=0A=
-    aspeed_test_sha256_accum("-machine ast2700a1-evb", 0x12070000, 0x40000=
0000);=0A=
+    aspeed_test_sha256_accum("-machine ast2700-evb", 0x12070000, 0x4000000=
00);=0A=
 }=0A=
 =0A=
 static void test_sha384_accum_ast2700(void)=0A=
 {=0A=
-    aspeed_test_sha384_accum("-machine ast2700a1-evb", 0x12070000, 0x40000=
0000);=0A=
+    aspeed_test_sha384_accum("-machine ast2700-evb", 0x12070000, 0x4000000=
00);=0A=
 }=0A=
 =0A=
 static void test_sha512_accum_ast2700(void)=0A=
 {=0A=
-    aspeed_test_sha512_accum("-machine ast2700a1-evb", 0x12070000, 0x40000=
0000);=0A=
+    aspeed_test_sha512_accum("-machine ast2700-evb", 0x12070000, 0x4000000=
00);=0A=
 }=0A=
 =0A=
 static void test_addresses_ast2700(void)=0A=
 {=0A=
-    aspeed_test_addresses("-machine ast2700a1-evb", 0x12070000, &as2700_ma=
sks);=0A=
+    aspeed_test_addresses("-machine ast2700-evb", 0x12070000, &as2700_mask=
s);=0A=
 }=0A=
 =0A=
 int main(int argc, char **argv)=0A=
-- =0A=
2.43.0=0A=

