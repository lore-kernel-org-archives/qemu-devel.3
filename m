Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673C6EB28CA
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 05:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voETd-0003V5-88; Fri, 06 Feb 2026 00:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voETb-0003UG-Op; Fri, 06 Feb 2026 00:33:55 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voETa-0007WD-CV; Fri, 06 Feb 2026 00:33:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CaZneVNfHCn2Nw/pivYUGu3Texr2ma2hjlNxmOLkityVAtsoYSDm4pUHBS6P0fCAc4y/N2SJ0A7/mlLwQlV4Q8ooPGrdlVgXPuDAVwpa7schLONeLFqMlMZlR+VYCBvI+f2NypWrqQrWLek7bMB3Extt+MZZxuM66Ip9iLqCsv9+qxz2dqg+hm7wGHkLBhKxo02eRE4TQjVMRiRPfI7wbm76S0y0I6hxxnUe1fJWTp+58gJtegVK+m/iMtfwdHyUQV1zvXmxJkaRGvB1KL209zl9dSy1rYTEAzwSiUCMM4bALC1HStikFysfmyd89nFIcJcVjxt0n+sNVNcSj4c8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pr1sVOn2YEnkXrIDFyc403nZBZvIyTSv7V1X4GUAqkQ=;
 b=Xl7q3srBUeGRsr1+AdE72ZWdIIZwBXJecsMTIbiV7+sFlhNc1UqthgZGZOrvp+egimuU4YiGlUiMAjOGZLhwnyY6WbNTA6R5//yIMFvjWM61pxhvzBPKKw5ee3Ts41mka2YaoPm7XwSo0HSWmFbPs8x1mPrwpTMFrCgBI1D7EBd44Nv7lHOXdAovIrF4Rh4soro5vt0ACgdPGJ+g86nBqFFgazHtE3/kq7EFdM4Y+m/OCfUWk/LS7vjmpopfen0rdOgXr/L+9+5uRQKVi0CqmBmJi+m4p6IiDykdoFw93PxleMHuHyhdQKAYNyyNu7kz3pKMZB5li2tmdCuuDGNuwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pr1sVOn2YEnkXrIDFyc403nZBZvIyTSv7V1X4GUAqkQ=;
 b=ivhXQ9rifg+KMlvmrbtkeE/fw5i2Cy8mcS874iRq1aYE8YOKFeJgk9HuwTyFMi+3aZLQZyk3dCCyGyMZfSrHtFngOFhZW1xTAbKK0Sx2rJhsGoiGsqACQlZ7m6i/0FeX+EsGZGLP3AgZ6ISu7Fg+IuK9ygarx07KFdzUtgLZwc22P5V3YflmALw5zRkjVxDSgo+REHON3SX1PwnKzGz/Q8Znl/9D05KojacmigxawsK5fARF0yUl10OR59ygQ5ZmveggQRU6B8DZcUo54IeIZ6JTByWBexRu5o98BjNLeV2ROLVfXddP9PA9UIsj/fG/bGsAlJDylnmjZ4PwROHAhg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SI6PR06MB7165.apcprd06.prod.outlook.com (2603:1096:4:252::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 05:33:47 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 05:33:47 +0000
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
 <nabihestefan@google.com>
Subject: [PATCH v1 04/10] hw/misc/aspeed_scu: Add AST2700 A2 silicon revisions
Thread-Topic: [PATCH v1 04/10] hw/misc/aspeed_scu: Add AST2700 A2 silicon
 revisions
Thread-Index: AQHclyoqr6SX8E6y00ighWM2rzZKPA==
Date: Fri, 6 Feb 2026 05:33:47 +0000
Message-ID: <20260206053340.3716041-6-jamin_lin@aspeedtech.com>
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SI6PR06MB7165:EE_
x-ms-office365-filtering-correlation-id: b27bb129-a246-4ac7-36f3-08de65414d4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?STKh+/+YNMKs2UYiT3hKgy8KG6/DgClqNiCkOGy6Z/B7A6uzXV98EBqaoB?=
 =?iso-8859-1?Q?Ut3fFA6oALd8RysQEup7Sf9/PG47ILl2PhnK62AECecLwHb1LUELsW0aR/?=
 =?iso-8859-1?Q?ZESZ1sS9nhmy5D8Ba2G2LxVL2tdb+JxwSXbYgtb982BuQaW2BRDk6zqtvr?=
 =?iso-8859-1?Q?Q+M/HDJLpCsJTc+jWdtF9GDZj9gabH1y6jDarZNZqU2lufKBITWyf/LwvO?=
 =?iso-8859-1?Q?DV+VnW4eGTxxQtjSh/GepQEWwCijh+Bll5eq1wX+YDJQbmufAa0a9h3NDA?=
 =?iso-8859-1?Q?qSj1vDjG99eVfTaWvb/qX5vNdbxpv1PDF2ivrfUemnm60j7gxv2X+mQXIt?=
 =?iso-8859-1?Q?WB9mRB3TzY53Os6HenXYsOTs/i3ZuWXt7JEWoSvJYbSOvfM9681kw7hyD2?=
 =?iso-8859-1?Q?SX8Qx4kHXhEunMlZEwTEUQ8e7tavSwTdxI3f347L9PLgb3upt0jbBKRtuq?=
 =?iso-8859-1?Q?Bjae1IJUr9X2BxLzBydDIDyY5WsQSMdvA6tJcq2RX7VkoIVFT5koM7fdRg?=
 =?iso-8859-1?Q?yeWFvL8q2yO93Muiw/IBdAjZcnG8Qb6V1SiGxQ3Z5ETl7mvz3Pudt0rk3k?=
 =?iso-8859-1?Q?n6+TrYGjjg6fqxw9DGm79siumUWOlenXQEb5fp+4hTXyE1zFUc3wQol+e3?=
 =?iso-8859-1?Q?+O35M0oKNof9q1XFqG4jhoodOISU+NfrgkSGHcHjnYvBSqxQhzLajretFI?=
 =?iso-8859-1?Q?4Rnp0uML/t+mMgw3Dlz34CzWly063K/XrVjwIPriczKEm4rOfMJmRDpE5n?=
 =?iso-8859-1?Q?+UIUa7LhgdeNFWNpx7sUuAzY7IHt8S6j776r3e3dUq/yM3jTArKUzn865x?=
 =?iso-8859-1?Q?4UPFG9EumyJr64+Wwkmxz8boCdXdv8DYn0gWMQY0HQ+RuD4y19bZ0+daF4?=
 =?iso-8859-1?Q?E8KUjzHypOkkIGjVNJUURbvaiTfJgYgrUm20owrHzJh+vgg/HoeQQse6ge?=
 =?iso-8859-1?Q?hZjyssN1BphlLCvFTkOAhFdkFNFdU6aQiCztKj/Aj4tQXy5fE7TXDxEiKU?=
 =?iso-8859-1?Q?/N2f+gdjvS/UyBRzMrecKCS3eqk4gM7bmBAigOFVmGV7WISiadxJiCnfRc?=
 =?iso-8859-1?Q?eDDStJ3sgeO9ZMWYIa0a+0vpx/3eh3z1Z1g70MdyfFVt2Ch24g4cYk3L5E?=
 =?iso-8859-1?Q?R3KE1V8v/WjtwuBQN92ef8eugzqwR5+iUm3JofG1oaDfpDNsRMKU5vbwrx?=
 =?iso-8859-1?Q?DKfreTY3mwrA9IeZ4Ci+xxZC6lD/eYN7uv3cd5ltrXrnynt3s+QxSjJ6qD?=
 =?iso-8859-1?Q?H3yJFD6LbvStoDyrb7C87DxMsJFes5xIuL6nQjXP5DDSQ/R0ZPetDjlDnI?=
 =?iso-8859-1?Q?f/sCGx4/TFLB97Bh4x3k7iPrHj0Q7pTe7shQ5Oi99Qu1x2JS34lp41hS7Q?=
 =?iso-8859-1?Q?8BJhoLalXOow+GAO5D3K9iRL44fUzcWLB6OIEVQo54qoIh1YtaWRqsFnTz?=
 =?iso-8859-1?Q?O5gktnBd/s/kT0x4V4wI5OTiZ2K+0EOoiisy/q/yIwjipR1tHx70lZGDxW?=
 =?iso-8859-1?Q?lufndwueqwooMVDa3kdO0nhVKYztE1LBWJV1dsZsJViRWf0OjD64OfyUKE?=
 =?iso-8859-1?Q?Qei+tkWshOx6pE4q3q+T4AWuEcEnbRrbuw5LT2xwl/iYddsAXD59Yqha9z?=
 =?iso-8859-1?Q?5/vFz96xWSDTQExJQwKzTNllEUfxoA8vXVPqEkjSV1qhpqlqxpUrQKr+6M?=
 =?iso-8859-1?Q?Y6+LRCBTYD/j/vhrMyTmzZL5++sgPJJqmIOlcZuq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AF4TTjOnudgSJbM6J5W3jdQu83NHd2/QRLC9KAgZmErIz515fJyiA3r+q1?=
 =?iso-8859-1?Q?SWHql7EvAJFaJPDAKJSFkLPlqCN1MWRReK9bYixwpkE71dYstodYpFkmHG?=
 =?iso-8859-1?Q?QkBSx2jUFvFXstPPUjayWffchu/ccT+A2VG253hjd0CU1HNbQPRXfedpwI?=
 =?iso-8859-1?Q?5hJtvT71uKKpqcKHvfUDj2FvQigp9Vwa2ZiZayyW7S8FQb09SkzPNjWRHJ?=
 =?iso-8859-1?Q?cX+/xb3kRo7QpdQ/msv5LOSaFrXeysi6BzTnUXDMDrP8OS27NPk8jtr9j9?=
 =?iso-8859-1?Q?b8lCnL9LrCi3uhgjUqtIqYPnqmD3o6VjK5dPrJSzuws9i4v5iGvrhqn7Oc?=
 =?iso-8859-1?Q?eg3fulakhP5y9cBQWSksGdM346x9zjawsrkUAHB8K4c8bywRNEI361ortX?=
 =?iso-8859-1?Q?2gJOOwNibxBA6GnX0iv8xYK35LAfAes2OgrxadPCIV7BQUhlP6KC+0SwkG?=
 =?iso-8859-1?Q?aX6iYnMGGNxQk/DvHUZKF91l/0z/wCIkk7OOIbO7TBxPHg1ixc+S8K51V7?=
 =?iso-8859-1?Q?4xWNdFsdHRp5AFQO62IFIXs+LG08ALDJVNBzYbDkdSXLKcn90Q6m57lwq1?=
 =?iso-8859-1?Q?b5OgRTSSmn4uRpEMzUbKul8BJQfqFpZuk2IQfsi7tUMeUgVIE/YgWU0fVn?=
 =?iso-8859-1?Q?DFxe+VBjIycZG80uG/qelHwbCZ3K8VSTCzI7shEXLimzN2lL1eHque1/jb?=
 =?iso-8859-1?Q?sLQNIlS8SEqRgmBYH99IjXT/6sM/MXT3/5o/p3dPhVvM6E5G+cBlEk1dWr?=
 =?iso-8859-1?Q?4k66xEr2XnsnqGG6JAxg0xX0z3djp9IT7KSr2j1OA0HkHyNoXZlzRKiEEK?=
 =?iso-8859-1?Q?f1zNhfvzdDQCMKGeUVlpDvhiby/EHKiqvxWr7KBp/yLCJShiKv0xyHubhC?=
 =?iso-8859-1?Q?f2GdtDhHCg2YI0uSa/RW6X5JsyrY4oemXV51QC7rAGPxZymmg2IN9MxYY4?=
 =?iso-8859-1?Q?A8JhSVNXeTyQp31eo8lDOw2JKKx/GHo33zTUyHpTj9orHGtO14xyFsWq5g?=
 =?iso-8859-1?Q?tSac6cH0nY0PRhi+X2fr/BAFJbecxOijQSruBksB/TONIDGlZn3zOcNKAB?=
 =?iso-8859-1?Q?nANQtItxBgtRhDNbA92O+HAMLDuI1U+LGroFe89CDdotCiH8VW5MoUHvmn?=
 =?iso-8859-1?Q?XD5CtYhQsAiOQte7amiDRyb7ao+yxJiV5rI0aMBNjLmYwhl2MNYPIft1mB?=
 =?iso-8859-1?Q?gFrEfT1rurvACmpjD56JN/TDVdWzDpEnoOmvDIU/yd0MmFXuDhqveZe850?=
 =?iso-8859-1?Q?yHplTAQ669R9XPAQruNKRIPzET6yQXrUEv7nv/4GVgxIRvPOLD/VcC7KQs?=
 =?iso-8859-1?Q?fzIIo93hd+v8pDmzJYgzc0TSqtj2/lnMr0ZYSMOKbceOCxmO4MlPG1i4ug?=
 =?iso-8859-1?Q?IxhqBogrNtUMuWe+fWROolPrJASUI6Dwbu0aLuXj+3fDEiVWVxQ1DPD9Xk?=
 =?iso-8859-1?Q?teZqhucOalx6aZEyMMj08Mea0s4QSrj3DODFFE0A+9tLL0bzYJYPNP4q3C?=
 =?iso-8859-1?Q?0FdQYo64bPyr7LXfWsZyh3jSZeMVBHruyIpq9ZEbFNXDh9HGUD4UfivXRE?=
 =?iso-8859-1?Q?bwBIasvLn1QqDg9SwtVzCd4U2nwZz2cHwDhx/8RQ8ylq0kwMzOzZJrYXlR?=
 =?iso-8859-1?Q?mhxhaZIQQNIZl5tAN6xUgi69eklkTJFj9VpfWmYQ31kPO/KwHwaQ7NXqwv?=
 =?iso-8859-1?Q?QBHdG3zR8PTwpGsrV81YQ+d0qSmYGQz7sWy3/OfRSaw1czT6emP8o1Ic/o?=
 =?iso-8859-1?Q?mRNq5U5ap+joeBPXdCMODnfWyY1IUxRgUuM5eMkn0xuQmA/qAB16rSW68K?=
 =?iso-8859-1?Q?yik4igKd7A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b27bb129-a246-4ac7-36f3-08de65414d4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 05:33:47.6573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dRMthrK85xSW3jJ31o3UWFTMj1kczrhlgTqIpQhYEstdI0X1iomFYi7RZL4VgWHV3GtGaQ3ZAVyH6lDiYKNS/40fp0VsXlTxD5ehHjFLZAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7165
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

Add silicon revision definitions for AST2700 A2, and include=0A=
them in the list of supported Aspeed silicon revisions.=0A=
=0A=
This allows newer AST27x0 A2 silicon to be correctly identified via=0A=
the SCU silicon revision register.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_scu.h | 1 +=0A=
 hw/misc/aspeed_scu.c         | 1 +=0A=
 2 files changed, 2 insertions(+)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h=0A=
index 313a79f2f7..d003955428 100644=0A=
--- a/include/hw/misc/aspeed_scu.h=0A=
+++ b/include/hw/misc/aspeed_scu.h=0A=
@@ -47,6 +47,7 @@ struct AspeedSCUState {=0A=
 #define AST1030_A1_SILICON_REV   0x80010000U=0A=
 #define AST1060_A2_SILICON_REV   0xA0030000U=0A=
 #define AST2700_A1_SILICON_REV   0x06010103U=0A=
+#define AST2700_A2_SILICON_REV   0x06020103U=0A=
 =0A=
 #define ASPEED_IS_AST2500(si_rev)     ((((si_rev) >> 24) & 0xff) =3D=3D 0x=
04)=0A=
 =0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 0edf9c1b16..e4160356e4 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -561,6 +561,7 @@ static uint32_t aspeed_silicon_revs[] =3D {=0A=
     AST1030_A1_SILICON_REV,=0A=
     AST1060_A2_SILICON_REV,=0A=
     AST2700_A1_SILICON_REV,=0A=
+    AST2700_A2_SILICON_REV,=0A=
 };=0A=
 =0A=
 bool is_supported_silicon_rev(uint32_t silicon_rev)=0A=
-- =0A=
2.43.0=0A=

