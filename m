Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5F6EFB7F9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vul6d-0001rt-Ec; Tue, 24 Feb 2026 00:37:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6N-0001jl-1m; Tue, 24 Feb 2026 00:36:57 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6J-0001I9-IT; Tue, 24 Feb 2026 00:36:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLjyTo5XIa9CfSmMNW0tO/CBeYEz8Bb2D6y0xzK2YsCf883Lf7I4PFfdPCrTEexQBfg8ejHl4AQ+1ImSYBWqy5QnO++a8Cnz3fcRMX9sR0csiP4kOgBPIFlIXq3y5qLuUYYjgqamasj6N3LwPDCIkO0y+nRm8K9yoLJehaOwBx8C/bU1enHXqELXyqihfXkGtX3LFAs7tlAMFo7lTGlipIqqBaB8CGm2lNLrYSKp9eraDokyCRZTBmWkSd+olee5MSMiZItg2q5Be9w0bS1iGbyPhlQiaKnDLC9xNFSqhttA6Jll4dy4fJtLSmBHhkxba8aBEni18QlVnkFSpYGQDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TwHv/7KzfQ9FX9uU6wHs4J3dlaJJwwRwPKB8I479Jo=;
 b=XkZsD+7Q24vqUGzDBunnGrfB6Y87wvIJfx2g8khNJxUZCY0Dc7o/IMidghpd+vnWtEZ27mx2FsEHZ5IefDK+35aOU7hT+sEr9VKVLLRKtT1TJL87ECzgM2biWT4bFmtYtW/CjKxe6Kg8Ircp+wCjmNm1JUSQ3TaWoQSWv1Y7mWYfzPUHp+mIvcEtn8+7fqT6kc4XLR5fmH33Qg9Uy6e6etW9jquaxttW6rGJZc05NE8AcCfHQz0uQ5KPIhv2Y2M+U3ka/GQCA4+8Z8TJDY3ZWBJwki2pztKVJQKTp3fdufPTOOLjS5CJamn0h3Wj4M2F1bcZwzANuQWf2Siku1+7fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TwHv/7KzfQ9FX9uU6wHs4J3dlaJJwwRwPKB8I479Jo=;
 b=Ocvkve/sG6LiRDLJw+NZfZA37JmUtBKROJvp32x5jtlibCK+kCXQLIdr78zGH8xUIEcyhpYFVm3DScbKOAQG6avq3rUGixNnOrXXm10GBuCAvSAxppa9fg/MkfzIh2MIucU0u+EnIb3mSI8UysTLxH8gYaiXo8XsOiOwRN4eKDKKsZZXLs4sxszNYCD4JGUMh2HQJj1YhRl15DjFmdoIvIMAC9Uo382H8+Lp6QgfKzhegTmEbKxfN+UDgmtjDQx7ef7pGwaWCHy71EHzfoizsLYpdFm37QgOGVqpacviDrsl58qj4mCrYR0/aIJzSSifbxoBbxv2q4U3CJA0H5kIKQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5004.apcprd06.prod.outlook.com (2603:1096:400:1cb::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 05:36:37 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 05:36:37 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, Patrick
 Venture <venture@google.com>, Stephen Longfield <slongfield@google.com>
Subject: [PATCH v6 16/22] hw/i3c/dw-i3c: Add controller resets
Thread-Topic: [PATCH v6 16/22] hw/i3c/dw-i3c: Add controller resets
Thread-Index: AQHcpU+LNNQJ5bZ2UEKu8hXIn7oUTw==
Date: Tue, 24 Feb 2026 05:36:37 +0000
Message-ID: <20260224053613.589102-17-jamin_lin@aspeedtech.com>
References: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5004:EE_
x-ms-office365-filtering-correlation-id: 3303d85c-89ca-4be9-bee6-08de7366aded
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Q6GRjxerT+oNmNjf12vBokayx1TXE9Wb+NnMtSRgYuDQiPi5e7lciEqQxb?=
 =?iso-8859-1?Q?8jBy/E2hboI2q2dW13MqAclf3oE2QxJ3uulYACp79MUcqk6tcCG/ma7wpL?=
 =?iso-8859-1?Q?1fINhgUeFtFKav6zQ7efSV1hkg/WyzMGncgb7ujgTs0BjdGhCpd7kyVBi5?=
 =?iso-8859-1?Q?ymY+AMhbzJiDw0yZKsrNnHKeaL0vtQz56KHxDwNU5M5gPsMh5BkYDHC897?=
 =?iso-8859-1?Q?A3IYcJxZ9Vwm27DfSYfT8FOKwlDsCgyA/O3S3eu5KOBGKCl21lAqBdp0jX?=
 =?iso-8859-1?Q?/OHfyOXiBzZ3Hdy84IuhRIm4qse1wZYnTp5EhDXkl0oTdoWP92iOLrjPPl?=
 =?iso-8859-1?Q?G3qIweggNOy+vdJ8Zz3Q+gZGl1fiqzgNzhKtqdtPkJQprsPxDhQ2SxoavF?=
 =?iso-8859-1?Q?BbVDz0D84ISB/X5Jgn7KeuTIBw7RcnnfxURWmm0MncqNLOp1l0lpfJ5lus?=
 =?iso-8859-1?Q?CVq3xBYqcJO6IP4HY85mzammrHN1/rMB1g9uG3Ul/h+SXeZvDg4hdoDt3H?=
 =?iso-8859-1?Q?XqveT2At/XwyJvAKtotTGrInxtQTAh19N0IFCAiu5x5e/G9qJWuKzcOsI8?=
 =?iso-8859-1?Q?lVwqr6nyU4XzIdNTH1teY/EEoWz0HYEUjuI3Xj/GULNyRblIhqGyTXivRj?=
 =?iso-8859-1?Q?lx1EmYkooWJlRSSm1cQR0LrTS9MGfgL24m04MU4I3JZBEvbSSV1jus7ZsU?=
 =?iso-8859-1?Q?qP8L5h8tokMAoPc04lg/Vo6DiqLbRuFFBsPfFYF+sMyWoCCr0OMQCDq07O?=
 =?iso-8859-1?Q?DcqYHu4DUd4tjoueqva+dVb/Rh95bQ/hrJrohTACy/UFnfBwc958tFz2/l?=
 =?iso-8859-1?Q?eSlsXFXPqQ8iYYJ0Uybkn1K6C6E9u1/spyYxjepP/69F2dpmOkk200c2y/?=
 =?iso-8859-1?Q?Q8rAqjvwCBQK7IXvUazgHRSPgR3NlTVEiKwJ/wUDNA6eLER+WDyx5lDMNM?=
 =?iso-8859-1?Q?vCDdNTs4QqI7E5d+zKslZFXuboE530loYZ5iK5c3RjELEi//IcC7aGWUe9?=
 =?iso-8859-1?Q?9jd2fWM1H3faADFhajrG4gIiTXevPfah0WzaruLDiLT1bsXH/Qd5GmF8iC?=
 =?iso-8859-1?Q?FQpksbRr3bvF6oZts1YwmeuzE7DfYhSF7sRaMuU9AKBJsGTLBugRxwEEXX?=
 =?iso-8859-1?Q?CIXakMlQdOakK4lSDig24sEGJu0dWNggp8ge5orqE7Z6XPN05c2ObVGRwS?=
 =?iso-8859-1?Q?qH+n73wrP9M4TDqwupHvaapzxtI64i8ErOVrDqwubRVn8GRWwLhEowxkj1?=
 =?iso-8859-1?Q?eXRoJSw+oZAx+HAcLgnfqkwjAh3DIle1OP1fQVUPmtgj9RKtm1OogljPbo?=
 =?iso-8859-1?Q?kaxpEuNaPNhSb4RGhERL3mtMi07qsDxTSFcO86PaIRwBbLX8jZ+U6q0dB0?=
 =?iso-8859-1?Q?rI7jzpZn06R9PpwMRxB+93eND682rmnlEJBU3MZ9KtZV9UTVKSAr+Nd0DS?=
 =?iso-8859-1?Q?+JQCp366wAmNo8Nv1zsjoPJ/UAqViRxxpnn1ij9YpjdLHta+OHsqqOKODL?=
 =?iso-8859-1?Q?TE8wAlca4zadWavou3qNyoOVVsibwj+tsHEa5Vz6sp4oAqsulXSGD1LfFC?=
 =?iso-8859-1?Q?aoYOU2zLtbqq92P+vMJ/T+Rd72zeG8A1ewmT2ydPmeayXgHKLRqtoen0Ju?=
 =?iso-8859-1?Q?Ui9wT2HZKdraIljoTE84hftv+PHReZP0rTIS4UZCFi5kWL1SAljZtkVFy6?=
 =?iso-8859-1?Q?sSxDwbfYqp+ZATe58pHEztTWCHg+NgEKya36GWAR?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Tjtv6zk+98h72+8mAMe/yOSGeeKqP8IKo0+inwE1ELiOlKtUzOUdVH5cx5?=
 =?iso-8859-1?Q?Z9vRUTk6dXlP/t5YpQX9kiLclnMhpRYF3q/LUzv5Q4UW53g7fToLgxdvF8?=
 =?iso-8859-1?Q?lQivTfhk5DXuYFQZkhgBWEhRx8RbgRZ/TaWqdo+Pr2OwJnmcDCoF+ZVUP3?=
 =?iso-8859-1?Q?Q8QpsONic30/jg5uLl+pYZITOSWZXl/QpgriNjPIZvgmJRMwrn8SV3SZPY?=
 =?iso-8859-1?Q?GG9shBnAQSS5qvI1odW/fCDuE4LTLOJ3f4wmpUGtMWT0+qJrzqY7Jk2pQo?=
 =?iso-8859-1?Q?YjPcrAharVPMnO4NOrxZNJeTEeJZkB9w25pov3jXyayXzc0Fcvj0sRdmTp?=
 =?iso-8859-1?Q?NC7axA6Z/Vawj8mBTznu8HrKpj/mAXns045+BtNJO4BlEjUty7OJSfYH6o?=
 =?iso-8859-1?Q?2Up9obBMrCPEUlQgzlw8Ng3qbkhUFEdbX226R8d2Hvhs+qO71qx8AUFN88?=
 =?iso-8859-1?Q?NNCvajVuq6Dxs+8MslXXioCnUudzvrCankEfP3n2riYdpj7VkDJDfjbrjo?=
 =?iso-8859-1?Q?khGOQlzH80DC4U+X7YMI1yIetehU0DG7tTwEp4MsY6eYea9C6g/JD2pLb/?=
 =?iso-8859-1?Q?qWoY3yBgWp8jnnVuIHPgybSX/Q66Y5B8c7qGqfFg0a9X9FwmegDs2Sqt77?=
 =?iso-8859-1?Q?FeXiKTGfh7BL7Vy57FuQUdtWLcqitIC/D6oUHD1CT78BvDe2f4tkYXTY/M?=
 =?iso-8859-1?Q?P5C0qzYtScVttCfbe2e/yRLTtkjsdvV6K0/1ss4WqwQTZDi1t4HQgmuxVK?=
 =?iso-8859-1?Q?tQaZVepUbjObG8jfyJJKzgXN4VS5/P29JZ6Q6rPvzAR6FWgqI3rTbyyCMN?=
 =?iso-8859-1?Q?n7aFGdiAhehRM2Lpz//F8XDoNcpRj53NUasBf2WS9FZf/smT2gXyf9iRyW?=
 =?iso-8859-1?Q?MCcDk75jA6oHgHjFPzl+jEcOuiC0JWrhx1rdBUCprb5amA6l7f8qMQ9qha?=
 =?iso-8859-1?Q?ZSFq0AgETkGp0+DDUqoj7O0ZpJ5SECMJamnsIRaW6QeeHhK4YiaOvzfZLm?=
 =?iso-8859-1?Q?DwpEiSmcioMSyPke5L9emDhHqqB1HKEuTF6i1XJyfwCxpa+GJ2sgomuoD4?=
 =?iso-8859-1?Q?IyRyxZSnwLq9uSQ+SfGaQbthvTCvuVhC70g73qfFdT9FZKWeDSneJjjhkR?=
 =?iso-8859-1?Q?xBnThu6erlSxsiDtNB/Qbr1CH15evpCagWrp5NO1qzc9BDcf/PlhzMw9OL?=
 =?iso-8859-1?Q?9ef4P0V4sOp23i+MrJcTgo4nuhAsGOrrUhWi4m95kqEbRoTpj7fYu5zCX1?=
 =?iso-8859-1?Q?YfdZ09BIXIy7o/dvo7T8TFQ/2n++LzSzLWcqo7qHmZIZXvx18FFOnnVEaq?=
 =?iso-8859-1?Q?1MSGItxkRKAQXXR4gV7h4eYTXQSjUH+TPbI/FRhp5EAI5SMyobHCsQZ9Tw?=
 =?iso-8859-1?Q?8KlCnM+aKU+bNCVKO+j2Q+LRXsa8FXt4CxtvbfhLk8x8dZI8K9rpLtTVA9?=
 =?iso-8859-1?Q?WKjSGs4SC6uss/zzV/7thJxSKRR16BCx80AR7HUCiHDPLpQ7sEnMmzkt+U?=
 =?iso-8859-1?Q?DivbGBd6Y/wzrjzYhOaaB36ZqPLQBfEi8uZXA88YjkZtxHJUZtzKpMCd/R?=
 =?iso-8859-1?Q?CWWpqaQ7lhEoNagOfpTxC7NcxweQPjKwIXNqaltehTJbh1nfipcDBIZF55?=
 =?iso-8859-1?Q?6Mjkgkg762PU2c3J+6p3sruil3cXfRQOiqVU7wgK7wktl7CY6T+oy8fmk/?=
 =?iso-8859-1?Q?DswpoNuNLkpaXoT9PDvkvYeKtjUlktyE0Wd3da7AsidW4ZHgmWdytUns+H?=
 =?iso-8859-1?Q?xx8niAdyyGei4tV3GA3UsS8AznEgzDnhlLV6dqiFkUpMrrsWJnpxlBdNNZ?=
 =?iso-8859-1?Q?3mXIOadzeQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3303d85c-89ca-4be9-bee6-08de7366aded
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 05:36:37.3813 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k/aGxCKaEE5RnvKj7rv4NZOlhAh1d2E8IEypMpyqfWTwxzQogjSjJRh6iuF1lbPzm3d/4+gOd8LaxhugIYMum/9YXfGz6HTnmSNhEpku/NI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5004
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

Adds behavior to the device reset register.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Stephen Longfield <slongfield@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c     | 117 ++++++++++++++++++++++++++++++++++++++++++++=0A=
 hw/i3c/trace-events |   1 +=0A=
 2 files changed, 118 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index b6ec0d9579..d742458129 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -860,6 +860,122 @@ static void dw_i3c_intr_force_w(DWI3C *s, uint32_t va=
l)=0A=
     dw_i3c_update_irq(s);=0A=
 }=0A=
 =0A=
+static void dw_i3c_cmd_queue_reset(DWI3C *s)=0A=
+{=0A=
+    fifo32_reset(&s->cmd_queue);=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,=0A=
+                     fifo32_num_free(&s->cmd_queue));=0A=
+    uint8_t empty_threshold =3D ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,=
=0A=
+                                               CMD_BUF_EMPTY_THLD);=0A=
+    if (fifo32_num_free(&s->cmd_queue) >=3D empty_threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, CMD_QUEUE_RDY, 1);=0A=
+        dw_i3c_update_irq(s);=0A=
+    };=0A=
+}=0A=
+=0A=
+static void dw_i3c_resp_queue_reset(DWI3C *s)=0A=
+{=0A=
+    fifo32_reset(&s->resp_queue);=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, RESP_BUF_BLR,=0A=
+                     fifo32_num_used(&s->resp_queue));=0A=
+    /*=0A=
+     * This interrupt will always be cleared because the threshold is a mi=
nimum=0A=
+     * of 1 and the queue size is 0.=0A=
+     */=0A=
+    ARRAY_FIELD_DP32(s->regs, INTR_STATUS, RESP_RDY, 0);=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_ibi_queue_reset(DWI3C *s)=0A=
+{=0A=
+    fifo32_reset(&s->ibi_queue);=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, IBI_BUF_BLR,=0A=
+                     fifo32_num_used(&s->resp_queue));=0A=
+    /*=0A=
+     * This interrupt will always be cleared because the threshold is a mi=
nimum=0A=
+     * of 1 and the queue size is 0.=0A=
+     */=0A=
+    ARRAY_FIELD_DP32(s->regs, INTR_STATUS, IBI_THLD, 0);=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_tx_queue_reset(DWI3C *s)=0A=
+{=0A=
+    fifo32_reset(&s->tx_queue);=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC,=
=0A=
+                     fifo32_num_free(&s->tx_queue));=0A=
+    /* TX buf is empty, so this interrupt will always be set. */=0A=
+    ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TX_THLD, 1);=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_rx_queue_reset(DWI3C *s)=0A=
+{=0A=
+    fifo32_reset(&s->rx_queue);=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, RX_BUF_BLR,=0A=
+                     fifo32_num_used(&s->resp_queue));=0A=
+    /*=0A=
+     * This interrupt will always be cleared because the threshold is a mi=
nimum=0A=
+     * of 1 and the queue size is 0.=0A=
+     */=0A=
+    ARRAY_FIELD_DP32(s->regs, INTR_STATUS, RX_THLD, 0);=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_reset(DeviceState *dev)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(dev);=0A=
+    trace_dw_i3c_reset(s->cfg.id);=0A=
+=0A=
+    memcpy(s->regs, dw_i3c_resets, sizeof(s->regs));=0A=
+    /*=0A=
+     * The user config for these may differ from our resets array, set the=
m=0A=
+     * manually.=0A=
+     */=0A=
+    ARRAY_FIELD_DP32(s->regs, DEVICE_ADDR_TABLE_POINTER, ADDR,=0A=
+                     s->cfg.dev_addr_table_pointer);=0A=
+    ARRAY_FIELD_DP32(s->regs, DEVICE_ADDR_TABLE_POINTER, DEPTH,=0A=
+                     s->cfg.dev_addr_table_depth);=0A=
+    ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER,=0A=
+                     P_DEV_CHAR_TABLE_START_ADDR,=0A=
+                     s->cfg.dev_char_table_pointer);=0A=
+    ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER, DEV_CHAR_TABLE_DEPTH=
,=0A=
+                     s->cfg.dev_char_table_depth);=0A=
+=0A=
+    dw_i3c_cmd_queue_reset(s);=0A=
+    dw_i3c_resp_queue_reset(s);=0A=
+    dw_i3c_ibi_queue_reset(s);=0A=
+    dw_i3c_tx_queue_reset(s);=0A=
+    dw_i3c_rx_queue_reset(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_reset_ctrl_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    if (FIELD_EX32(val, RESET_CTRL, CORE_RESET)) {=0A=
+        dw_i3c_reset(DEVICE(s));=0A=
+    }=0A=
+    if (FIELD_EX32(val, RESET_CTRL, CMD_QUEUE_RESET)) {=0A=
+        dw_i3c_cmd_queue_reset(s);=0A=
+    }=0A=
+    if (FIELD_EX32(val, RESET_CTRL, RESP_QUEUE_RESET)) {=0A=
+        dw_i3c_resp_queue_reset(s);=0A=
+    }=0A=
+    if (FIELD_EX32(val, RESET_CTRL, TX_BUF_RESET)) {=0A=
+        dw_i3c_tx_queue_reset(s);=0A=
+    }=0A=
+    if (FIELD_EX32(val, RESET_CTRL, RX_BUF_RESET)) {=0A=
+        dw_i3c_rx_queue_reset(s);=0A=
+    }=0A=
+    if (FIELD_EX32(val, RESET_CTRL, IBI_QUEUE_RESET)) {=0A=
+        dw_i3c_ibi_queue_reset(s);=0A=
+    }=0A=
+}=0A=
+=0A=
 static uint32_t dw_i3c_pop_rx(DWI3C *s)=0A=
 {=0A=
     if (fifo32_is_empty(&s->rx_queue)) {=0A=
@@ -1617,6 +1733,7 @@ static void dw_i3c_write(void *opaque, hwaddr offset,=
 uint64_t value,=0A=
         dw_i3c_cmd_queue_port_w(s, val32);=0A=
         break;=0A=
     case R_RESET_CTRL:=0A=
+        dw_i3c_reset_ctrl_w(s, val32);=0A=
         break;=0A=
     case R_INTR_STATUS:=0A=
         dw_i3c_intr_status_w(s, val32);=0A=
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events=0A=
index a262fcce39..39f33d9a50 100644=0A=
--- a/hw/i3c/trace-events=0A=
+++ b/hw/i3c/trace-events=0A=
@@ -11,6 +11,7 @@ dw_i3c_send(uint32_t deviceid, uint32_t num_bytes) "I3C D=
ev[%u] send %" PRId32 "=0A=
 dw_i3c_recv_data(uint32_t deviceid, uint32_t num_bytes) "I3C Dev[%u] recv =
%" PRId32 " bytes from bus"=0A=
 dw_i3c_ibi_recv(uint32_t deviceid, uint8_t ibi_byte) "I3C Dev[%u] recv IBI=
 byte 0x%" PRIx8=0A=
 dw_i3c_ibi_handle(uint32_t deviceid, uint8_t addr, bool rnw) "I3C Dev[%u] =
handle IBI from address 0x%" PRIx8 " RnW=3D%d"=0A=
+dw_i3c_reset(uint32_t deviceid) "I3C Dev[%u] reset"=0A=
 dw_i3c_pop_rx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] pop 0x%" PRIx=
32 " from RX FIFO"=0A=
 dw_i3c_resp_queue_push(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push=
 0x%" PRIx32 " to response queue"=0A=
 dw_i3c_push_tx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push 0x%" PR=
Ix32 " to TX FIFO"=0A=
-- =0A=
2.43.0=0A=

