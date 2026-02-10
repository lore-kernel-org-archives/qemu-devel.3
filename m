Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F05EA3F28
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjlu-0001VZ-0x; Tue, 10 Feb 2026 04:11:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjli-0001Di-VN; Tue, 10 Feb 2026 04:10:51 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjlh-0004jF-Gn; Tue, 10 Feb 2026 04:10:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bc9omW4HSgFO/35d+51CzUr37j+tWCg0RmdqcvERnmGtqQBqZkL5RNrolq4z5WrPcAlJmia5z4nX239JvjJ+31O1RLfeO9TvUiVNeDytdr/d2gega38V9d0acW4D+vuPLJo+SynBgH5iSnVgzYus8eABb7hdj42f0vcVjpC+ek5sv7yaR03jQlPNx14alDgQs7gfUccFpTCHwB2vxQNXD8QkMgKxZWso0NSMMAEgh1LeudtJ7d0eab+MvryydQXuqpgzb6gW9Y/KVu0/uzLgMdJ0ce2TOcpTK5csV5wpebaoDEAnWsiPmjXPWNpV4klZS9YqmNFt5becasPI1M4JDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WR1YkodCjzHBKGroe0DJUM7olLEYORn2iyAE7vug75s=;
 b=RoXP1SOEPVCu10UwDa9AwgrPU57fGxE13Crf4ZsPRUS4MSNKNHzsiNosIg5HlhEknU7/Ddo+Q0ZK3Ql9w1+bm9cc2zz5jZpTYwrH+AANbkZ3R6Luy/zCUaQad47CptcWr8PSBYL6RJLKNAcpaMonMf5NWhsRH9OYxL+QEutWYk5WG7Vp9hMpJKLhNEWJPIaO1yYZaPknHV2muTnIg7bzJ1o7oLJfYvIRlcsXvx4PcLPqS8Tw+gRmubB9zx5LvSFWdgWbixl9vhneEf4jkRuGx4p36TxFMjTm8DQJwFD8fQ0BRYBOIlhSTOUPBC3bDaqfJil83dh2Sid5UPnO5nVQOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WR1YkodCjzHBKGroe0DJUM7olLEYORn2iyAE7vug75s=;
 b=q4+ON7q+s+LQrYg+k3JF5/Idmh8kdtdQjXxlMlSiHbXgwgDeASpKzy1P2b6CTnZNDOJHyScwWM+Vlg5YiKjc4+yYuXzKXwXEKXtulvNaCxi4xPdU0wCA7EFouAUnoVNbcxT1i88CVU4mosxC5lQVRxVt7Dkq7SouxKGdaiukQR4m/o9CDewozPaFlgnP4t5kER6iKYSG4C6+y+c+L1pZk8ep5bXEn5BYcFvCu2bA3PycAf0v2ssKE923vPOQccZgKFMucIbDKtm3zHutI2SPA1ZXB4mAqFhkzK0l5Seb8RK/4J6sl9wTtYUVTubB017pmBXBRPXyhL6gpTIpa+T8BA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8268.apcprd06.prod.outlook.com (2603:1096:d10:62::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 09:10:31 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 09:10:31 +0000
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
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>, Patrick Venture
 <venture@google.com>
Subject: [PATCH v5 08/21] hw/i3c/aspeed_i3c: Add register RO field masks
Thread-Topic: [PATCH v5 08/21] hw/i3c/aspeed_i3c: Add register RO field masks
Thread-Index: AQHcmm0bMMzebGKx3kOkrGBB/SYJ3w==
Date: Tue, 10 Feb 2026 09:10:31 +0000
Message-ID: <20260210091018.1553489-9-jamin_lin@aspeedtech.com>
References: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUZPR06MB8268:EE_
x-ms-office365-filtering-correlation-id: 7d8107ea-5092-4a51-3b0c-08de68843dbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?PPqcCQ+BQ4VguIYpq6NhqrFUnqhhFEVqs7Gkl1bvCOYCOuD41vDOuG3KVk?=
 =?iso-8859-1?Q?3otByKYTJNfxqbrNdzRskRA3WMhQBxVYiX9pgv2+q2hG7jgouyd2UIT+4F?=
 =?iso-8859-1?Q?Z2PmFQMzpoUTSTcWdD57tCI5sUPl7ix4rSA5sAdp5z2n7v1LmI/7Ojoicu?=
 =?iso-8859-1?Q?QAYPUEXen6bwekBPWrkbRbnr5pxpTQKPm2iiCFZAcSHnhqvPE5SAY5OXqM?=
 =?iso-8859-1?Q?tyC7yKZhhgHW3D5npHSv02PI2wTKH2wVshVfe6QS4m8NX9QFU8lAIGY8p/?=
 =?iso-8859-1?Q?xQ/M8zNDGZofP9PfmtpASOd4Z+BmZDw2qNlNiC4cVrGO8/5ybbg/JWN+9c?=
 =?iso-8859-1?Q?bII9VGnyDyAWrsbJnICSfTdXUJJBUJIx/+qNHzos0maholoQDvwpuk74NE?=
 =?iso-8859-1?Q?47m7edfmKsBKfRe1VkYt9fBPyBlizOCGXJ1pCPzh5V39Wwn0/nmL4FBvll?=
 =?iso-8859-1?Q?+Buc1R6TLBa4r99/90ZC2R17FGffPrIa7b4qL8UtWiM4zUPVA/gBbT/1YO?=
 =?iso-8859-1?Q?AasI6GysMLXThFVVBSHjDL9CyKatTVd4pJQFmO4srMOc/tG49C8xXqBsX5?=
 =?iso-8859-1?Q?z+g4bkzUSYEfEiD280pUCUVpGOkJ8z1vti186DnRCUSFL30iXFbW43wz92?=
 =?iso-8859-1?Q?86TSxvG//4VtHZVD+MW0QjCYrslgfpP+++f9uoRrDVqRGaUhxdw+nebBY/?=
 =?iso-8859-1?Q?Ltc3e8aFv+ioX7jGkWv186//wSgoFRO3H3+Ojx57Zq3svQMGCKJUhyls2k?=
 =?iso-8859-1?Q?6aQn04/ITNsBYyJq5o0RGHFc5jFrzpUhpQtuWsnEtJ/MADKsYLJxTFMpGi?=
 =?iso-8859-1?Q?nb9bnG5jQNWwhEjM8mMf7RH5xcxoMKZSskdJUKrGKTMSwQ4sf1Fv/h4pA4?=
 =?iso-8859-1?Q?DrKnS+HzXwDwXjVuqA+n4ILRhTzU4cXc+ARYYTBuG9+0Ub9wIOfKE8ydue?=
 =?iso-8859-1?Q?OOoRRCNlJpTE0QPpDE+hHnC9xjduObEQpe9XuR6rWNClUcLGsffXROO3GK?=
 =?iso-8859-1?Q?d3Y4YmrqK/DJdTUqsQWPdmeQHl01C6kN/jt2lkb3pqjA3Y8tgu8JgIEgmQ?=
 =?iso-8859-1?Q?SVDz4qIG86ypzkgmnJBwwLLE0UnMJSw7/0XIEIzvEEcAD0l1RCYE5JKN/U?=
 =?iso-8859-1?Q?SpsUGtyEUb+/Xg+cN086PmJQAz+NeW7GwtdBT/WQUrXaMf5BsTcHFAz2xa?=
 =?iso-8859-1?Q?c68pAIEnbJ0KVbeM74cM7wXsoJHBWF4KuvxcNX3ZegDl7cCqATqkcrXHXS?=
 =?iso-8859-1?Q?nT7JYGeha8ICua89GxbASxbzT+WxlOinbP71G79N2lrWIyFE3hdSbBxJ9o?=
 =?iso-8859-1?Q?DNxi31ZnOvO16JSDcOLphKphCqDcmKIxn1R0NhT9ZNLxmvoMr0nlnsykmy?=
 =?iso-8859-1?Q?QQ94PZmrQTD3qo/au78c5GKbjI+r4D0No3XAE3ZSU7ZKDOybEtK8/oY18L?=
 =?iso-8859-1?Q?eYXxm5jinXVnN8d9cM85hRFLUe6Q4ZLTGGm6WPf0/BXfPLeWQc+O61Zz1z?=
 =?iso-8859-1?Q?kYZoo4+MH2y2F2NWkkH0Nw6C/N8d3wlI+7frPlNQWxFaxRgQM6nevCDRna?=
 =?iso-8859-1?Q?m9KIOerMJj0xgsb1SqBdOag0KXwVbxCMGuDr/T0epKrzEMa6JXCy/YktL0?=
 =?iso-8859-1?Q?VTl7XKQgXHuUHWa15iJ9cHmX9FYU3sOCeKTI9+AyTI2TSfTErr4i/9+8uF?=
 =?iso-8859-1?Q?rjyJ+wL2EnauZE8zh5Q/DkyqDNDYs9UeMLCJECqP?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?h2J7ZJa6CZ7EzsWo5fnXI21xe9xhA/mDIdJ9tPX8ZOMjtj9rmqcSf9IPPE?=
 =?iso-8859-1?Q?4A15s+frm+RyJEnk+ZR35fPKwRnz8qAmVFvqm0z+ZZWDGD0YyiveIXihXz?=
 =?iso-8859-1?Q?Y7P6uKfIj2pLHzZfrYhDSnRUmajZ46G3lFQbUuyhiVBZyQZjTNfOUSo5qN?=
 =?iso-8859-1?Q?tlqEp7zV8dayxMCDzKJtfeSN5l/H8dEub3WIw1f7Npf/ih78lu7K1yO9IZ?=
 =?iso-8859-1?Q?SOv101Bx7OwjYfuyuOZdLfboIp4kNd1Agt6FilkX+3rQONnoy93R2Htgc+?=
 =?iso-8859-1?Q?8lhRbTCBRHFptCJdigEgwos5hMiCqp/zFjbsqet8LrVWRhwM1Q5iInGUJh?=
 =?iso-8859-1?Q?M4LAWOkvYu/nhbGjH+0ZWCG3rjhUatasB7H2We/m0shRB4eawU9tsRAUGN?=
 =?iso-8859-1?Q?Jf6bslWha8UhShxn9E+1Azu7bP00laMJPIJjDIPOqE0EvPNz3pyn4NGZuJ?=
 =?iso-8859-1?Q?LQm3Z9IGSvIKupIO4o+MJDE6VV60efNOaRBaW0fzik9xYbV31Fhiisjg1X?=
 =?iso-8859-1?Q?g1G0McIHcEU2YrNfmMVEPEU4Q/ice5HlUIb7hhG+2xKuWRLbV2+MFmbf47?=
 =?iso-8859-1?Q?iB1MwzjrjUkvKizsiDUWNHFgkeriQ2tx5MYsjwbdsRa0G2Gd9dS8tXN5Wc?=
 =?iso-8859-1?Q?ktRcHODTIZHZGlVj78xwUjDDDpXDdnpQSA3hVV+nXiUX/GiN7CEsOf2Axd?=
 =?iso-8859-1?Q?yfZ+QN6hGaK4QVM3o8g6SqdzY4KK/owdNTBl8m4V1A79GxmBYAmKxOaT6F?=
 =?iso-8859-1?Q?oCAyAWksYc1e7gkcZBpK3uk04TlHeBiwRtiSkNNYWl9ba+3mVyreuOnXwZ?=
 =?iso-8859-1?Q?LovT0uqBiiFJRi/K7zsX8i9F8FaWgsNNbx7C1xN+gH7vGc+bXZLMYjMJq+?=
 =?iso-8859-1?Q?XOv/tsyNxppmbjEXq943SkjYHdmQS76AsecTF0W2zMhI3DTHVofzz6VJgQ?=
 =?iso-8859-1?Q?IA6fGO34pNxt1lS9OCJL0VuSyxcINDapB7vrLgd6KH+aC90XQKs2LuQV4L?=
 =?iso-8859-1?Q?4cV4NTvfKumvlkpGnAJLNotrK1VqEOiFgLSc/Yy+fh3JGrwi/9uPCvRKKM?=
 =?iso-8859-1?Q?k/sQFMbcZDhIUSo4oCql4OwWeANd6xrWADIRnUqBFfqujIBHBg85HDu301?=
 =?iso-8859-1?Q?pQQpt9WNeBMDaaAamPnIbEgWIN6cyeXet7V6nPDZsh8Q5Zhmy0jDxp+RsN?=
 =?iso-8859-1?Q?ZYq4V+Wu8uQUJzZd56dTfGeJtfSvUsRK51A2CDXeZdLaPHv4GKvnW5DgNH?=
 =?iso-8859-1?Q?TRCyeZfMkfpU1wIcfROc0GLiXqZ1GXQcbbc/uuNYQa7g9ymIWTFWGNBgmz?=
 =?iso-8859-1?Q?akufC4bqqHW3gxvO09rrYIA5Zdz2ZzY4zyI7RFgOZg7d+tXRuhDUCgrqhD?=
 =?iso-8859-1?Q?9/02GhrX/7viDK88GkVHCcBQUEkpFbZHUEXgBGLHbj98HBrOSUPAoeJrFc?=
 =?iso-8859-1?Q?z8/OFF/1Oqh6twduozX6A1cc2yKN0w5lsCOawl+4po+jyTG14M07XAV53b?=
 =?iso-8859-1?Q?M4NWWZnfXmWnNuYgclUQ+wu9bhUR1ZzxZYnmyBG6HIlOEcgfscheliVSbo?=
 =?iso-8859-1?Q?H+JMIfxtlaObwYI1TlRvCgGY8MuIJZ8XYHwBpt9xKl2Fqc9lpqdMiiEZii?=
 =?iso-8859-1?Q?sN62mL5N9PPh6TD7q181BFDVTrE0zwhuaBjJIr8lwzu3H/S1McF0oQSnQb?=
 =?iso-8859-1?Q?DpwR+dfRV7dFsoWOSQbtZ982FPqT+F5Wh1pzXVC7UiutvyO9Gqi/SNf0FD?=
 =?iso-8859-1?Q?AtY58thDe2P/4/ocXNGvHrWulU+OGqqA1DOhO2fja8YFUK03nY9Ub4egA1?=
 =?iso-8859-1?Q?WRcveWwKlA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8107ea-5092-4a51-3b0c-08de68843dbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 09:10:31.3609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s5IjozIANkntyzEtVzK7J41jmnlofmLLSq96T3G7U+rkpQsLSyny3HizoVu4PWVXebIMKgRaXNAYKKdDjED3/DH/cDEuG+uJJ4Alsj1QJbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8268
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Adds read-only register masks for the Aspeed I3C controller registers.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/aspeed_i3c.c | 16 ++++++++++++++++=0A=
 1 file changed, 16 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
index a215700288..2700c5f4cd 100644=0A=
--- a/hw/i3c/aspeed_i3c.c=0A=
+++ b/hw/i3c/aspeed_i3c.c=0A=
@@ -74,6 +74,21 @@ REG32(I3C6_REG1, 0x64)=0A=
     FIELD(I3C6_REG1, SA_EN,         15, 1)=0A=
     FIELD(I3C6_REG1, INST_ID,       16, 4)=0A=
 =0A=
+static const uint32_t ast2600_i3c_controller_ro[ASPEED_I3C_NR_REGS] =3D {=
=0A=
+    [R_I3C1_REG0]                   =3D 0xcc000000,=0A=
+    [R_I3C1_REG1]                   =3D 0xfff00000,=0A=
+    [R_I3C2_REG0]                   =3D 0xcc000000,=0A=
+    [R_I3C2_REG1]                   =3D 0xfff00000,=0A=
+    [R_I3C3_REG0]                   =3D 0xcc000000,=0A=
+    [R_I3C3_REG1]                   =3D 0xfff00000,=0A=
+    [R_I3C4_REG0]                   =3D 0xcc000000,=0A=
+    [R_I3C4_REG1]                   =3D 0xfff00000,=0A=
+    [R_I3C5_REG0]                   =3D 0xcc000000,=0A=
+    [R_I3C5_REG1]                   =3D 0xfff00000,=0A=
+    [R_I3C6_REG0]                   =3D 0xcc000000,=0A=
+    [R_I3C6_REG1]                   =3D 0xfff00000,=0A=
+};=0A=
+=0A=
 static uint64_t aspeed_i3c_read(void *opaque, hwaddr addr, unsigned int si=
ze)=0A=
 {=0A=
     AspeedI3CState *s =3D ASPEED_I3C(opaque);=0A=
@@ -97,6 +112,7 @@ static void aspeed_i3c_write(void *opaque,=0A=
 =0A=
     addr >>=3D 2;=0A=
 =0A=
+    data &=3D ~ast2600_i3c_controller_ro[addr];=0A=
     /* I3C controller register */=0A=
     switch (addr) {=0A=
     case R_I3C1_REG1:=0A=
-- =0A=
2.43.0=0A=

