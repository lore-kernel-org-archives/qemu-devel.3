Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC34EB594E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 02:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpzlh-00057J-OR; Tue, 10 Feb 2026 21:15:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpzlZ-00054q-8a; Tue, 10 Feb 2026 21:15:46 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpzlX-0001hz-Mc; Tue, 10 Feb 2026 21:15:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXfWClH6cYdLcrgyM6C/hgCqPamJXmphGFAaIyt5BqkZA/qnekq9ROR7l9j+Fxm+zAQd2EKG5ZyT3h9Xg54hwOUeaQqupEL39RNc3vxzoCNsAE87lYmF/DHJ7RPzcN/qm9dc5g5yJZdA8xixFnaOOCrF54YapMAojE8xyC0W/l0BEBIhxU2MULK68h3U+3nNyQty4xkPzfhjkDaeIln8dZZjNmiZkwk32k6F3LQPW6dKBocwzlUOZwJGMHVS6IZuZsINhEXCT0iku4dJz+QXDZw5vuEA0UyWmBoT10n2yKPe3jJCCKsMIXjZ2qHTwRw8GhJuLyPTax/gS4oX/vukQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyrN4jVN1LtUeJ1cNws+7LBx6ls5ieFybZ6T+rhipKA=;
 b=TTK83BHNSS9RLg+K72lI0dLsCFjiu8wtKCZG0NhVuVACLjwHPOggM2FO9qXBlfQNIaxiJLQh7HjvcET1Rul1PWvtxlCEKvh80y74mwr0MhO1jvIhkXKUZ8e3Hl0SqX38KLyojjrm3lad6m7xnGicYNne0MuV7kSau/XWtQlhGQYlS9fx2B1qL62r/14z2LehV+uiRLn++CLqUX7EcOFTpPmLtkS1NZnyAZO50EKyET9onLKFxDzJRCbbtSiaQxP2wWaYgwnetseo21gg7Fm/Nn1P4JdSJ2aCYC2qLAlgqexeeCIsFOZ4byglElpHpkWlMRPWt4wfp+DCVyXbb6OU8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyrN4jVN1LtUeJ1cNws+7LBx6ls5ieFybZ6T+rhipKA=;
 b=pfyVcZt6qXac4RCxuSMtD/YZGbkKFZCksK/VehrvO+HrNCPQdS7p1y3qRpx6TF2+ZPtnkOy0uBbtSQSprfkIN13TMepdakbIbVExlVqfIwLtYVuqfylF66Eg/tzO2kCIq4n+0DZKLKDun9iCyXt3IEZFAQfwOWUXsDAg0Ce9a2A7qz5SIY7CNnNgk4GxD6U4At4it15nMYPMTPs4rMkHcPf5rIVK8tt8gPm20OlPqf4AMXOOB257u+6FVr9k/j54Kk1OZMhhHD0wQ/rw+l+A60/8riy6XbPKVqBl0RpwF1nCodXC34/Ky+8EIjRfJHIOAPrQmCyTHGdpdofH9ai8uw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYSPR06MB6541.apcprd06.prod.outlook.com (2603:1096:400:47d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 02:15:34 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 02:15:34 +0000
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
Subject: [PATCH v3 06/11] tests/qtest/ast2700-hace-test: Use ast2700-evb alias
 for AST2700 HACE tests
Thread-Topic: [PATCH v3 06/11] tests/qtest/ast2700-hace-test: Use ast2700-evb
 alias for AST2700 HACE tests
Thread-Index: AQHcmvxOovpJlU+v+U+AySaWgOTe2Q==
Date: Wed, 11 Feb 2026 02:15:34 +0000
Message-ID: <20260211021527.119674-7-jamin_lin@aspeedtech.com>
References: <20260211021527.119674-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260211021527.119674-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYSPR06MB6541:EE_
x-ms-office365-filtering-correlation-id: a5236684-f1d1-4368-0d43-08de69137097
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Sp9BxXCO4Z81iy7OCyec0oBkrM+D8qTP3dr0oPrJDvadnTNEgsxc+lfkRM?=
 =?iso-8859-1?Q?NQICXvAtxRN8LP4WhQsF0piZUlKki8HOqxw8t9LUD5TMMghZeTituWbgg2?=
 =?iso-8859-1?Q?4h1Zsaa1sWho/2r4afbDx1QmxOa9nIagjDskBhcdPxV6qp2DElDjHK1Thx?=
 =?iso-8859-1?Q?BAtI9TZ5XPrdQpP2gvQAjcK5SGhp68b68uUx55vskNLAJ4od/R312N/Bzf?=
 =?iso-8859-1?Q?lLAt/34AFJM0fakw2lTJZuF4HiysO4W3tdGJKf6N5a6cqI8WeWAImKLBUN?=
 =?iso-8859-1?Q?pu1w6JfBxOYwm61XK6XXT8NK+e8BNMt4/n/3Y7ItEvXuPjv9R6an3mhoO8?=
 =?iso-8859-1?Q?7gZBS/Miptjf0UoDYmRkccINCreI3BNi692OF6XzjUd/q3T0fAMa0HlOE1?=
 =?iso-8859-1?Q?fmqsU7D4mpdG+qjLn9bd8LZQ0flY1tkL8ip8lf4s3twz0B6myqEOQ2vJjh?=
 =?iso-8859-1?Q?o1h48H88ZOWM3CwSrOcqkm6oKd99v0CVMJSoAWO+Q0k6iksEqY0+exxUFY?=
 =?iso-8859-1?Q?Ri+NvRo81NG7D+tCnGNAjqyU8UKTFzpjXPDvwkXGg0oAOmkla1WBBkbuz+?=
 =?iso-8859-1?Q?c6vP+VMRSzJJwaCs+cwBjWHnURChvGKug6/by63M+QuE4PhW44r3mvSIRD?=
 =?iso-8859-1?Q?VS7hklrhEwtqnBSIe9FlHLfu8yvrQTyhx99Rv5DPr8IiOf3ZdfT5a74NE2?=
 =?iso-8859-1?Q?eRrAiPFUTiTooAo65ByEplvF+IeP0w07r4IejpVRgH2wCWdcawcvhqJASu?=
 =?iso-8859-1?Q?Cudy5JYVtcIMyF8y/2q3jliZ61KX8EOK8DH0iQYxeUwtARcV+FrLryC5bH?=
 =?iso-8859-1?Q?IFRVODzvOyeuP4vlut2AuMyRBg7sTaG9a+yjFvX5oNcIICRoYBKrRVWtgm?=
 =?iso-8859-1?Q?tDyw5IHVYg2cFU5/TUcUo6aQadM2Vfz0FOxfaeyymwQ58KZUucCpVZGo9E?=
 =?iso-8859-1?Q?8C5YExIoVLwchEmdG81o0I9johEfFqUxjtEPtZso3opcrVqqQVYxtm2p+s?=
 =?iso-8859-1?Q?9zqBdcsVVxxP/IsxCByCUSci/5KBv6M5eZnylrHKxDZLNGo98uaSpnc/HV?=
 =?iso-8859-1?Q?yubm7KM5HJldcA4hlW8JmvczfFc34EW662vaSaVUBd/uwdBRHtpGHS48qG?=
 =?iso-8859-1?Q?vffUnbWfTK9wFZgif/YaDSPcBYN5Wr83lCO1oy59wcN8kpnR2ngomofzY3?=
 =?iso-8859-1?Q?jShnZA+rCG7T5lQpfM/13OGRqrSilomN+RmMkhmkNHZYmY/WwSEOMh399D?=
 =?iso-8859-1?Q?I20Qw95qG1nIDFUr+N7YAbPd+jgdibu33IPoLlTm58h550TfpPZGhIG1+V?=
 =?iso-8859-1?Q?7jDIWuTBC39q7SYahyeysvzyrymPqsxwFRdWemN+QX/pPHLb20dSm5WHgC?=
 =?iso-8859-1?Q?2v0qsev3IS2ghB0Jb0DfJhuV81UK+zP1euWS1E/wnYXb01RMtlmAlEk3Xg?=
 =?iso-8859-1?Q?V+SMki1PbrT1TyYgouf31mt28Pm3cfQMzffzg/Nb1fAbl+TudNTOsp9GKz?=
 =?iso-8859-1?Q?ZA05llE4zzLtsfWg2uXwNbE1dh1oNJM9gFJGw9G494t6FL/cpqD49tJssh?=
 =?iso-8859-1?Q?bmaMjjt0Pf92u95g+PIeZPREmlaBdNmBsWWnTswIRBp/pyL4w/DvXc4WNu?=
 =?iso-8859-1?Q?IUdIL2Xlej7TorudhvX7NaQ7yXzpdR33ZXnGmvCBKomEyiaNLiKpDaJZth?=
 =?iso-8859-1?Q?m2SLL4WUpoEHl1AMlhs++sj5p72CHpmQnJhXQm3d?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cczNnSY9KO2oQebP+aRyFT0YfvQ1pSps4K5SmZTJodow2sUO7Nz82jfp5l?=
 =?iso-8859-1?Q?5BggUECml1PplH+C2PVuDDlmOTBPUetffqlxtNQxdNifrbWtZ9rqS34AUq?=
 =?iso-8859-1?Q?e3yrx84p/0YgwHo0uwMx4mYmy2LIkUFz0ZmfgZz6NM2uXM0VYcCgch5sqO?=
 =?iso-8859-1?Q?omHtseYjtpRImXTAysr51KGmhGkb029GmZTzmXfNJu0dJorkAJyn33dh80?=
 =?iso-8859-1?Q?eghOKUU/M0Kk3sMqsov2OfPFxUhJ2crlp4d8q7tdF2eNvbKf8Gv0KYK6sU?=
 =?iso-8859-1?Q?Y0ArgcOMHeIdmXMA50Hgf8U6JrADlMkH1IwN76xrhCBEBNyOGQpVOaJMRf?=
 =?iso-8859-1?Q?hoUXPAXvVLA+kRGDrf+jfxThe560x3PUp53SMf9duHAKHIwjnxXlmMinJ5?=
 =?iso-8859-1?Q?VTyLbFlR6K4pLNFBljx8wjbJlmUalLcd1K4U9OOkLgZrpjL8jtkLf+yUev?=
 =?iso-8859-1?Q?ftbV8d49IMhgfTLfqDL5rlJe11ySzcmRLFO+ydxqJgZ64mQBhR5R8Owfsv?=
 =?iso-8859-1?Q?z5+rhV1t5d/r1ZM5yePsMKAV20S6JkVaKUWsQ1I5Q1SSkQvwh/ch8EzjMV?=
 =?iso-8859-1?Q?s6cLpJIFETL8cHgty/UkDKPEw7h1gZg/+9MLdrhhAqUWFN2KZrAkJ3Iucy?=
 =?iso-8859-1?Q?MOl2qOCMovItu7nrMWMdlQcLtqr3BzwMYjjoChApYfmJGLsDEELcrhpfXI?=
 =?iso-8859-1?Q?fxVxClAbJrJXlJeK4CQGfsUADVcy9PIaFLKFGhU47xch9P2iGoZoo9SnCU?=
 =?iso-8859-1?Q?vE4k4aejdlAeJcA30UoDGkJqKY/dnIbRxowfPIfnE8VwRKHpSsc8mNDs2k?=
 =?iso-8859-1?Q?1NHu0WKGug3YI7II0WbdenDiXcC15S6MiYulx1PzR3ibLH2lkMs0Cz2ni1?=
 =?iso-8859-1?Q?R/GSaAe96Le0amfLU7IpogYvxJ9JwTeVW+J8hsxNLYEv7m+uxRL/8VxasC?=
 =?iso-8859-1?Q?SR6Pa126ylbLV0eOeRhBTdC0t2B+QCvdE4vQ5jPCuVwPC2oJV4CT5n+vJn?=
 =?iso-8859-1?Q?29IRjTY6owuQ0QfOLN1t8rZxlIwX83/VvT+ZCMQtVehri/wl3IMwLVvkYc?=
 =?iso-8859-1?Q?bhoRhJC/rBS7CE3REOcwm2/7hxZHI6/tGly6TJ2vNVzIJpkw1j4dh1WHNx?=
 =?iso-8859-1?Q?Hat28koCGCUnez+naRnKooO8j6mXiNpZwxT9X0WLkj+KheDGWeV2FBtvMR?=
 =?iso-8859-1?Q?7EKD3Er67VBRuWbrW9wSoo+7cwRsHQikmsq/o2ie076I49gKjIMHIWAMdh?=
 =?iso-8859-1?Q?SYKT+A5OnfMeYtgAXF+pVzgMJpMBChZvEBnIMVo92wGOkh638y97p0WOZJ?=
 =?iso-8859-1?Q?S0dGTqS7jNXkXTkwh3OyU64GCqgwo/hYommu263veElUbcvpFxm7nBnbOJ?=
 =?iso-8859-1?Q?/lkNjlVcXkqar5mBS9EDb855ajItgsdXakhEdc6zSKMiprlQZ2qQq4iF3k?=
 =?iso-8859-1?Q?lgHbH3RSIFSzaWpnSA84o/bHk2cK8dHIoSseQ4eZ+VmgmKZFl1tHg8Pcoo?=
 =?iso-8859-1?Q?kGeBZem9/2uTQw25OXfxB96NmEGIMlUWbnylY93b3IZtzaCuF261I2l3s9?=
 =?iso-8859-1?Q?H+K841c7MuyysI06NAwcaKwMaI8pYbg991Rd/LX38NjqVIoHGb0F/AS8Ic?=
 =?iso-8859-1?Q?Auv/qlHK7rTmwXfOwBPSjFS9lsrVnZP+Fiow1bpUUEXIJu/F5R/wl2LXHX?=
 =?iso-8859-1?Q?3FKAoApvB+Ittbt/4QUIiDM8Vp3daYrN1MaBiduYh34M5Zyhil0nGigxBk?=
 =?iso-8859-1?Q?yBMeKyLAv2fMOxA3RCYM/LYB6loJhILJowPEDh5Oi8PlAavFiTh1IU55f5?=
 =?iso-8859-1?Q?ZKK8ABZSkQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5236684-f1d1-4368-0d43-08de69137097
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 02:15:34.6887 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R2llnzrR5zu5KE5MuAncDm7LkRQnzTQ4/bLDMNaV5QY53rw11gIp2/c2ua1QbQm7Z5HSO+VyEMYe9YrSZzM3xEn6ww5HAd6++kD2i5mn90k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6541
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

