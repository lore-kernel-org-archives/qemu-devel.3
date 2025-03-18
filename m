Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F515C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 11:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuVFX-000764-K6; Tue, 18 Mar 2025 07:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tuVFJ-0006yI-VU
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 07:36:37 -0400
Received: from mail-vi1eur03on2120.outbound.protection.outlook.com
 ([40.107.103.120] helo=EUR03-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tuVFF-00071k-56
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 07:36:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZTSu4/x0UGBIdEJ8b/6DQpoU0qeSUlxXAUtGGBIHuiTEGDgF1VI0g7tR/jxfFU75YOGIUixyQWwjdTsnHGXQDYXcvyGq0KPNNOrvUiH28VBeX2vtlqyiXl8ZlTlkRyewh2VqxZSxX+B4FX2O9dKuWdsGSZtdzfaw03jm0tKNWziWnNSo2AAJ0+vxVXBTxZ3ClUT5pgTvT5BshVn2iPm+tOD3dL8og0BfClbOIHt0+qx+FzlSx/GYSZm1Go8KtuTZsDG3Q71GY6NhOyUU6+Euw84QISsh5BTCYNKVpZBtJJOqs6E6nEECKNu+jLqZunYKbasPeVdJUi3WikYzNYTDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZobWECIg5X75TSpE1ssSHEjI6Yy44gMbtSD7AsJ4XI=;
 b=PxzH4sS45GKb9uL+xQ3MNIHstJPLBYz+mgvxwBHDfnURth+n7K6fJ3+buH46wgMO364qcbdiTjh+1brzpge9vvqEMpMAY17mkbQa8CUfDLoJptsUg2c75UmXBzKKA/d7fgpmD7z0NTLe7Omy9NOCnTQRhv+y9xN8wXqWLu5rjnLPAnyU+gO+lZohsW6JS+9D0hJNLvUgzhiJKwrua62c0VuYvfymaIbMa2zoDksaCG/P5PfAotMW1uehTzSrX+49cNEhVvqrCHgccG8joD8DTO+wd7R7SBSdA5Y/XCwzWDh1vt+G3okfU59ZMrBEbTd2VcyxjvzwW1Q059VJef/dcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZobWECIg5X75TSpE1ssSHEjI6Yy44gMbtSD7AsJ4XI=;
 b=ldL28CrFpEOqr8lAIYFmpDeV6RiET4fi6g29kR7wtTjZoCOMmbpNkkG63vmp8WF9MlMgKN6bT8EnXXH7UipaJAOmOYroiAjw2vQBgGtL4e0WqAeYaO1d36KWB68bguXi/M6EEYBkqqSRnH4r5K7ywEMZDnVTYs/Tp6M8LFA47rpfnzwfGk/Jr6VK50X3yJnOhs9wJVCjLO3gYkdfwMbGP8XVZfP2BcR99ippdzyYK8A1N5F7k+o/WVCZJk5ZI4gLmHZ2zqH2a5HSwI3Ad2kXZvNXM1E+wIa070yIQ2rEPVEqeU2wTJP6JHQqa9TvBlKdE9lqqNlV+QcIOJHwsbWfCw==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by PA2PR09MB7832.eurprd09.prod.outlook.com (2603:10a6:102:414::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 11:31:17 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 11:31:17 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Aleksandar Rakic
 <aleksandar.rakic@htecgroup.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "cfu@mips.com" <cfu@mips.com>, "fshahbazker@wavecomp.com"
 <fshahbazker@wavecomp.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 2/3] Skip NaN mode check for soft-float
Thread-Topic: [PATCH v5 2/3] Skip NaN mode check for soft-float
Thread-Index: AQHbiHBN9WWu61L0jUe8EWyWqAJpArNvr5MAgAkxxoA=
Date: Tue, 18 Mar 2025 11:31:17 +0000
Message-ID: <20250318113013.578865-1-aleksandar.rakic@htecgroup.com>
References: <CAFEAcA8RjNTZsuhShFwFUHa+YP5VKBUw2RneUPwAJ9eOVAL5Vw@mail.gmail.com>
In-Reply-To: <CAFEAcA8RjNTZsuhShFwFUHa+YP5VKBUw2RneUPwAJ9eOVAL5Vw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|PA2PR09MB7832:EE_
x-ms-office365-filtering-correlation-id: 2b14565f-2862-4f8e-241c-08dd6610661c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?IBaIAerEA39SZeIC5j+4SG22MEjsjX0ZmOW89rQvIbyIhXlec8vNXI6z/u?=
 =?iso-8859-1?Q?em2k06nm8zVMfU0J85RngKMywwYzw1yG9KFAIqXWCCYn18rc6VvBxWRiud?=
 =?iso-8859-1?Q?Ge0w2KzsJV/xBm2TZFhJYrpR89hsZiVgi9a8SvIXvEhuxrf6DFzneMSWiu?=
 =?iso-8859-1?Q?lVsMQZ5OmyNF7jV6flUmYRlyP78B42yGCzD+2zeow4SNAl8H1GpUzbkJp4?=
 =?iso-8859-1?Q?qv6p1BaM5O+5RexQrgTOd7ZvlfvddqDnA1nydPKp6ygqXrBTGFhqksA3N3?=
 =?iso-8859-1?Q?0Jwml9qrw7VsvdOupkEU6TJO82AAbaLmgjU5SjaFBvey7ISYR1HluCsjPf?=
 =?iso-8859-1?Q?so3uhI4lM4lQcjTJsb2HcEEtnlSWlKtqYo5FR9SN9kck8+/h3bzSKoMwPH?=
 =?iso-8859-1?Q?RzYRnPIE6UxVCtsDL/DVwmInGlhvbJ8vxufWqrbsB2nXdplFALfxacHMkl?=
 =?iso-8859-1?Q?MGAfFGbR56VwXXtczd0jnbshC7idBL4Rker0VoCfFLyh1UQAqoWX8rWpQ2?=
 =?iso-8859-1?Q?9Iq4KuWfd8y0WUsexFIf6Q4N6x41cZ5/dUoNevOR5z46YuMHJDb5yikBjw?=
 =?iso-8859-1?Q?U+HTWnREdcIspqKDhRtbXsQ6WidZ9wIy4DWg1oWBGxdvcsmd8ZOWkz4mhy?=
 =?iso-8859-1?Q?H+DOPZ0wdf7ftXtcvtaqFBDIRtyLO4b7FtSBDUWGJi1zskNlF06tkzX8vU?=
 =?iso-8859-1?Q?ZdB9vPvodpv+9C4GwUSgbFgxnLlaxPFQghf29YbGRf4pX1GoJSYAgaV6re?=
 =?iso-8859-1?Q?9aHzTO23tjEE3NYBqtTXSGAQsPQynStcUz7f7sTWF+9SPwiW69yMzifm28?=
 =?iso-8859-1?Q?an6KgEJmHt/jkbRnLkIUPF5qExwJ9ueZRxd45IjMpS8GltDxvFV70n6VpU?=
 =?iso-8859-1?Q?5Yb9C+6HJw1qRhJSVx+5lyxMPBqkO4XSgv+/TEXL0u1yyoOV/JZz08MSLx?=
 =?iso-8859-1?Q?A8cconRZpcOlHjaCkR93sFfpFTSe2cEcSpqsCy2f7QMNBgaJ7RZR6wxQec?=
 =?iso-8859-1?Q?HjmmuywcbMa4nokzL89I9C6iiRM+RH+XQGn7yGtoqB+bw44rWgjgiZOH2f?=
 =?iso-8859-1?Q?ICqDcDUJpGvd8jC6MsP3PDZqvJEDndruwnlwu785NzZHfsfNilyMkswCEl?=
 =?iso-8859-1?Q?Pr1kp/puHeFwOVB6LCufJ6dEk0DKnNYwRDP57pCAFbEwFX3Wo0ydWy1blc?=
 =?iso-8859-1?Q?zzHThmkfXoJiNX5x1g5kyPGEPPvsXmBSNGfZubGqHRnHeVxWeOEo2GPsTd?=
 =?iso-8859-1?Q?cqnP92/pl3WLNlPURqF6KRdBUC1d1nBOMuMizLpdPIqRGnmn3n+rfG/84E?=
 =?iso-8859-1?Q?24jj5A19UEwrEk5F4jlVcGGKNwMte3fYEGpALKxWMoPA6IU6Agj2UHx9Df?=
 =?iso-8859-1?Q?IS4UIWGCTspZgLgpN5Gi+L0PwV8oOiSBsapJCAFqGZZNndZx4LJVJBXp81?=
 =?iso-8859-1?Q?XvqMvhmONvEeGg8AAe1/gDbszHJ+tBSkkOQyvg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9wLnQPWwiL04cqjRztkkthgTF5U4CbG8vhue0cOswsuN5jCFUye9YdeGwE?=
 =?iso-8859-1?Q?NBZfADgQBjnvP34tI7VSPpTUxAG5IYB2ZcyMWez1w/ISyN5ymiJC82BR7v?=
 =?iso-8859-1?Q?EIfr05VLsDQ0hlvL9233oMdvxDaEx9+cEce64s9U0/Gx/8o1BQDa5o+tDF?=
 =?iso-8859-1?Q?UE93037yRAd/9QzXhQG4Sc6ApO6RzA+M5i5sc8Fu3BHpUkIAvjKwaQbgdA?=
 =?iso-8859-1?Q?Onruvl63yt+TEY+AxqI+02N7IpitUFATeWnnoHrL7OWrdI5d2OY/7Wri3r?=
 =?iso-8859-1?Q?5JtJgotrNzDhbe985vb9MyRm1ogiymxged5KKED+AapjTg0y4/9ENpLpft?=
 =?iso-8859-1?Q?uvkXPt5o64xaMY1m2jXyrxYjz7k2ITHZOCjmyTpMfURzrcf15idWKc1ghs?=
 =?iso-8859-1?Q?GybrbSOpwCdEBxeNYlFH6WKBwNUY5y8MG1PZdXmEm8YE8AijVbIybIU8Nr?=
 =?iso-8859-1?Q?kqJMa8tIgodt4OGYdNJ9HNf/Z1foDt7KClCJ7h8nNBYgJBaToe8N2oetpZ?=
 =?iso-8859-1?Q?oRrdXdeQeQSwyQDD9nRf5pbS8T1lKB3toKMxXCtb6OwnOF+s2b0TZZO+GM?=
 =?iso-8859-1?Q?qA/xyOnLIFeI3zvWCraejJFMhjo68p/jrrON0p3BcwrMHc38tuLObtUoBb?=
 =?iso-8859-1?Q?O8PJy34/ikCfSQfOy5+X4XdS18lbGp4yg+1O68ylOpTBXXgF6afBg9s/Zw?=
 =?iso-8859-1?Q?Tpd+IihSUFndESSsAxhFbJojtvQpsEJV6e3392qiBolEgbsbSsLetswYv5?=
 =?iso-8859-1?Q?MQymT+u82egF0nTrVabVFCDYtEhlpv+wUqDN7V6YenhTGYBudCijcLBsLW?=
 =?iso-8859-1?Q?db1PlsJnoMDLZxdSZP32VaZHlVeCLZ4FrgGGmDXRhdJM2+7xbN/HgA710X?=
 =?iso-8859-1?Q?0hD5hhygwcElb70VlCo22k2JVbTVzGYjrSxpzRI/IMyHnYI4mXYFeo+7Pt?=
 =?iso-8859-1?Q?2pLSpC1c3nZl9gsmQBhDzvIlHPyW+BkbD7MWdc8ZVeLD53/5NUEgyC34Cs?=
 =?iso-8859-1?Q?MzhdA3OxbDIG6qESF+5Esj+XxW7f+xAGdm/UMPlpJks2fC9VzQmZhe8iXm?=
 =?iso-8859-1?Q?JuMVmSOs86z/pHTW3ViI75s65PodNlocvQW5NnIrCKmNZX6Ov2/7kh9oUX?=
 =?iso-8859-1?Q?ullugn6d8HEyNxdzmhZSq9NM0/t1XMJACQFjDu4GyALmfqFTvrowuVng7o?=
 =?iso-8859-1?Q?c3SJ9lk5nIKQLm04dMHTWyJ635bcO9dynyW+VXu/s/7bKfeyGdNtfn1e2H?=
 =?iso-8859-1?Q?jpxxGNSqSTzYHeyH9s2v5YOtop7/p7HjgZ2e/Axpaw2LTvR/OaU3MJQd2h?=
 =?iso-8859-1?Q?purQz/PS+Q/4T+GIEZodZcMXjDHKz9KV4MUk5+lPO2SYp99rRFBO0dXoa0?=
 =?iso-8859-1?Q?pguhfbrwivyP7ufY4zXd83r90gaHDaZbT/Mb8EhaS329PEy7TglcWPYq2S?=
 =?iso-8859-1?Q?j63zpNzEhWTEUyFroEFAB2Eo3/oGoI6yE96gt9tTSFDNBu8om0FZac8UDe?=
 =?iso-8859-1?Q?xlTKiYod2i1uGmt0LAyuzZhR783uczqq/28WaLeGRoadg/ZDHArLUJhGmQ?=
 =?iso-8859-1?Q?iLx2DaDjLbqArUWvGfalWpWGGdGS+zFQNZL7gnjPHiOcqWIGEgTXPpkvJ3?=
 =?iso-8859-1?Q?lGWyJnTo91Am07Alt9O54dZ4WgJAQoxGeaikCGNPLlt0r6Liquk5/W+pxX?=
 =?iso-8859-1?Q?0qZ73mcqo5iWJ6A98ko=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b14565f-2862-4f8e-241c-08dd6610661c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 11:31:17.4644 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aT9Mot8H4uSoppnyoY1gKx/kWCV3Fqgju1NpBqW28UKk3PqHu+S9hGxJOh8b1OzU7DnkWB3afxMkopBv/qbUjxqWwDmmV4ru7JN73TD1Bm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR09MB7832
Received-SPF: pass client-ip=40.107.103.120;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR03-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Hi,

If ieee754 equals EMULATED, then the variables mips_use_nan_2008 and
mips_use_nan_legacy are set to true
( https://elixir.bootlin.com/linux/v6.13.6/source/arch/mips/kernel/fpu-prob=
e.c#L208 )
and any binaries are accepted regardless of whether supported by the FPU
( https://elixir.bootlin.com/linux/v6.13.6/source/arch/mips/kernel/elf.c#L1=
54 ).

Kind regards,
Aleksandar Rakic=

