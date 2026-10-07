Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E43CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 19:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEXTC-0005h2-1H; Wed, 07 Oct 2026 15:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manuele.conti@archimede-energia.com>)
 id 1xEXT7-0005gm-Bs; Wed, 07 Oct 2026 15:38:26 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manuele.conti@archimede-energia.com>)
 id 1xEXT0-0007N0-SS; Wed, 07 Oct 2026 15:38:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4fcEnnnwkJmmG3UUVzZVapw7fbrWZtVNftVk13lGRfSvL74y+PNtD6KxzuXj9v+1xGQr72zSIBWJK8FRkjRc3CDywRcI4bsBJK3U9/6dK/QrRTEx0wm8+rEQEnzv00uyXX4v96AWMZ8HtNMtqTXhrhVQ/nDom4jDobX5aS1IhlJoVpNQtdSwMICmUYc0wGCXxThMAexYUc2P9bMG6afDSVSvw+KRseaIVOn9SwQ6cJAty5dzgTcKZPI2osaPeuY/c1HU+vkyOPidivHDeiYP+IxCpUpe11AIdgNjg1mufF+SixMSNYIJJb2hvcrw/urdwtM4yqulAomeFfGFqTeSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcxwz7i3eGkFDSr1oYRGLMTcKP//Q/2dlXY5HM7/An0=;
 b=cDJkSMcEdEn2WAFymCKnNtHnvQom/bKT4FFtUmhWW3H7TAEnPk+sgiwG2zR99G6oPyeAhlOx4/j8a9vTWib/6gZxB8yK0ApXiRZRxmfUQhmJ91CLIkqXdbpJhhPS0O+hvUZrUxz2Io/EpAHf8FYAfdA+lyRU7eWx9yj+ALvFU4EQQU3U2lOdDQl5p4tZg0cy6zYz2x/HgCUV4mwzK9NNqGMLUCC9i1Q0VF2j9muz5dDW1Pd6mkHucBhtpQTTJ4TAyMtZkjCL3222C1ymFnP97fFVZQFcyYa3NRg5GQfJqTPSQNNQsqv6m/EGNpDmt0tdVTK0gkvki4dSL5CMpZ4LaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=archimede-energia.com; dmarc=pass action=none
 header.from=archimede-energia.com; dkim=pass header.d=archimede-energia.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ARCHIMEDENERGIA.onmicrosoft.com;
 s=selector1-ARCHIMEDENERGIA-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcxwz7i3eGkFDSr1oYRGLMTcKP//Q/2dlXY5HM7/An0=;
 b=UiOYBPciPlOArSOs7byCDno6tUJoH1fUvJauSrokM1kk9XPxtsI+AAMxRNs+2E91Z/et9XNs+YixEpbWBVzbYamNB8xq/hIj20f5RN2m5INRDrUXEJwLtf1M0vJ72xehzSuGck6vxh7a9oIzAMuo90koMibUc92TEKSDeRAjB4w=
Received: from AM7PPF9020C43FB.eurprd02.prod.outlook.com
 (2603:10a6:20f:fff1::816) by DB3PR02MB10402.eurprd02.prod.outlook.com
 (2603:10a6:10:439::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Wed, 7 Oct
 2026 19:38:06 +0000
Received: from AM7PPF9020C43FB.eurprd02.prod.outlook.com
 ([fe80::d6fd:d61:e01f:727c]) by AM7PPF9020C43FB.eurprd02.prod.outlook.com
 ([fe80::d6fd:d61:e01f:727c%3]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 19:38:06 +0000
From: Manuele Conti <manuele.conti@archimede-energia.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "alistair@alistair23.me"
 <alistair@alistair23.me>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Subject: [PATCH v2 0/2] STM32F405 timer and RCC fixes
Thread-Topic: [PATCH v2 0/2] STM32F405 timer and RCC fixes
Thread-Index: AQHdVpNftfLB/x7XS0armEsdLYl/UA==
Date: Wed, 7 Oct 2026 19:38:05 +0000
Message-ID: <C38CE953-7A98-42C7-AE35-443BED94674D@archimede-energia.com>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.700.51.1.1)
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=archimede-energia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PPF9020C43FB:EE_|DB3PR02MB10402:EE_
x-ms-office365-filtering-correlation-id: 9d01290b-acc9-4bc2-f3e3-08df24aa825f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|23010399003|10067099003|56012099006|5023799004|3023799007|18002099003|38070700021;
x-microsoft-antispam-message-info: aD0m2xO1K4vqXgt9UjspmcYKpj7WKj1vPz5c6/mXYM4YIa0LWtLueiUwQKdFZpxe8+P6mYo4/luICK977qrWpLzmXTaS1X9UjEXwqIEX/45Eq/n6ge9rFD04+UyIvnlYEz4CSDDqRPMAOZv95hJvBwz7BZoIw4cetScnple7p/PywJbAlxS0fRi6cSgCPIdiKKQKDe/E9Eve2sQ6iB/xP/QyfQfiB5lOXFFXYpjmnpL4pg6FA6yaA/YNHPuVdHjX/4DdHrbPj5hXKJuNBFPMacB+g6VH7f/uChqOIYlVd40NAmjjpBaidWDBiS27IK2JJ0ucyC1oR5wULwLLhKCdXCZCHPJd8TQ5W1qDsc+43VMgmeWxRzvxi5lKU5jTiQyTTcEPsYKwwZqe5cEuMiWgAI7+2ioRY0wl24UfDelCmzYCidLvJWTYwWJixmc63g9b73G+EqxzzVUt+TCw54zIDBge2LAH296vPeyPP9jBHcy5wd0oiaPcAgRxc05sZFwhDh4iqlqQoglnCqgPLuvO63YCEP/wYKu4axniElM3Nbql8o+7rsYQmAjWEC27G82mRFLrL8yLK0m4NHsZJaVtlezw4jGS8kIBow7R7RvO1T5gIqaeTVHvfQX58SBTk2Vf+E8I7LE9dMmUa9TBCvB7IfwESmE2rqq1FIEpg5QemkrikPsL1bFeFnOKa0Vn8rGGL5jPTNjP1LxdANmGZRxErg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PPF9020C43FB.eurprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(23010399003)(10067099003)(56012099006)(5023799004)(3023799007)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gTKJX+JOwkHjnNg9OENw9nP8nIKqtGybzCc5SAl2BojEWULPq1Dv9EMzW+HX?=
 =?us-ascii?Q?rB/uKhpqaQdIgRzw+7adS04Z7J0u0Tdr5IqxBsRtJg13e871S0j14ZbIzpta?=
 =?us-ascii?Q?YYWXou8iClZN0/QX9PX326wHplKE5qDNrZB9YUoRlRw4Pf3ez4HxatXR/GSG?=
 =?us-ascii?Q?dTQ1tE3MomWn8QbrdZVPtIEhLEIx6kdQi1xKAVZjs6CSQ82SMKpN0Br9Y0GW?=
 =?us-ascii?Q?iJcWm/nIeJjNnC0bZ+1xQpchwB4Hj2oOh/QVFpboGTk0bd6JFqvRdt35TsJX?=
 =?us-ascii?Q?wyLH3+gcnXFSpp7foPgQJY3EQ0ZBbPMzydqUAE6/GqBMjaj2EOLWEvL9O3Mn?=
 =?us-ascii?Q?Tn12eWDB7wKwetPbmveEJx+1szNY9hc9wXCj18KQPhaBTNbyNtLbqlyj5PS+?=
 =?us-ascii?Q?X2ynh+tkrCf5c719tFh3m4EwHueIRBc+ZYZ89T1VUYLI2RWW8/J8F9+70FaX?=
 =?us-ascii?Q?j2YsYf73qCjJdSAjacGORtzuNxcBJHRSWe6Z3EcMESNNc0Ycx4eYDdLTcysj?=
 =?us-ascii?Q?xtCGeDhgJw0dc29CSej+zt8vF3PxHTqP1gMr8HxL528cDXC0Zn3Ab9AoLSre?=
 =?us-ascii?Q?wefwrBihsjWA2Mnj3lt/Gpz4VZVn7nnNidPcmIBBmSXtrA8kb/M+i1wryzc3?=
 =?us-ascii?Q?DnqohgGIRW1F9fA8VXZUU9vrxI80eCCXvMnVPxoQd9hlTIuAtfvkmeLHPyfr?=
 =?us-ascii?Q?RGzIeYcfaSIWH3iJLKaO4Z0QpN+YtLV/etMjgEac9Ay8lZ4qFuvNBnVqRIeI?=
 =?us-ascii?Q?ftKGpq2pHsv5IsmHhm8s/BN9ES29iOPfgOpr23Kqb8PTwf6w/l1UipV7U9xh?=
 =?us-ascii?Q?AcGvkYhG5ORVvYBcJqrL1GzPU6IExdw1penuqWqwAJ1UPS051avhxmMR6HHS?=
 =?us-ascii?Q?gEr4lnqWzmNY4lwylJ4cP1AUhm/7XxUDTCC9HkNBGJXQ9SweaxzVmv3E6vO3?=
 =?us-ascii?Q?PvVNUaojTtEWN3iAPyCfOtMhALIHIfPhPfrVcQHd933EhZ5WPRnnn7Q5HqcN?=
 =?us-ascii?Q?rGKiJdiZhMRja17eqeQWY7y3G2M6QjUots80RDs5yq3HpWTn2AhaL6giIG2e?=
 =?us-ascii?Q?4Mz4zGggyRZpGmxPFHgq9udI3EA0Xu5NxQYFjlq82mqcFZi/1fOO216ctWHb?=
 =?us-ascii?Q?GUUOq5VWttkHgvXLcSQgMLP4wq5BEicnN4fF/FjVCdlhpP+4dq7PjXRdJ9Wl?=
 =?us-ascii?Q?z2aK83bm+jMvJk+/QfJRy3cWYScJ1P6RyYBb/PkFVtRENaOyvQDkX8iknFcK?=
 =?us-ascii?Q?dDeoXiggrcV6f4OkMceKkxGcznY8YPpBj5aHP5qGOz/TGTc86/qrPHWWY0/s?=
 =?us-ascii?Q?7B5/n1hFLXjZCPWQWeB6GPrtI4MO5XGXAwiHBkAn2q63tRQZWiyzvrOF+FxS?=
 =?us-ascii?Q?qC44JfH5FcGLNcXURqM87CpOnTE/NrtEc/eBGsfr9ldNeSvYSpJtSKBH+cCv?=
 =?us-ascii?Q?KuMwZwnbZUHWAUdHOX/NJAv8Oi4f68c8+oKbEDt+l29EpGdYkjwHEVv13WEf?=
 =?us-ascii?Q?DWpEMNofbRgXM5NOEfkVKf3OttB0BnkH1shEZzJn2b+0NutqG4GfNHqB5ueK?=
 =?us-ascii?Q?Rj1jhZHyjHh7WzMbHszI+z0jykgQvDfr8IFask9IhUHY7vvLE6VXPLcyTID3?=
 =?us-ascii?Q?zaxdyi/w7VXO3PC/kt0Y8rmlT1FjUs7FQjw4iUUHdlOmrE8UmhVC0J4WgqC5?=
 =?us-ascii?Q?SAsxPT1xhLtmQJroZgIuIhkQQn1evUKq/zJsmVf/oqlneqIpiD0D42uYyW1V?=
 =?us-ascii?Q?1cQzUdP2l1TTXrdMYw64G/z1vGUvSYVnO+yPyK9nbiSsZOS/yQES0mp/FEXZ?=
x-ms-exchange-antispam-messagedata-1: DOK99tuX4UKGOrZNnViHPRSjzqh+w2TCRbFpZ/3yBXECTV6U042J7KmG
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DCECDDF93512C248AC1448A784DA4F2A@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: archimede-energia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PPF9020C43FB.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d01290b-acc9-4bc2-f3e3-08df24aa825f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 19:38:06.0202 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1f446eb6-a8f2-46bc-96fd-2665698112e8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kgk5TXyUs9WFyTwS5wTX2we8YKyOS4Y5gbdeTuum8c7p/SKNpL5WvZWmuLPriTc5RbGhVQzN3mB2Uy7/dZfGy6Z/HItdU6j0gY7QRL6P+JfKasnpXR7Dt6xXBGsosilp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR02MB10402
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=manuele.conti@archimede-energia.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Hi Peter,

Here is the complete v2 series, resent as fresh emails with both patches
inline.

Changes in v2:
- Timer: make hit_time local, preserve stopped CNT verbatim, and set both
  VMState version fields to 2.
- RCC: mirror HSION into HSIRDY and PLLI2SON into PLLI2SRDY as well.
- Extend the qtests for stopped CNT and the additional clock-ready bits.

Manuele Conti (2):
  hw/timer/stm32f2xx_timer: fix periodic mode and CEN handling
  hw/misc/stm32_rcc: Mirror clock ready and switch status bits

Thanks,
Manuele


