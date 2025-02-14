Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5CEC02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 17:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tizi5-0003sj-Ox; Fri, 14 Feb 2025 12:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tizi1-0003sK-UJ
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 12:42:38 -0500
Received: from mail-vi1eur05on2101.outbound.protection.outlook.com
 ([40.107.21.101] helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tizi0-0005nP-1e
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 12:42:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSy5jBBL/AhiNf8JD474tyg6K0PGL5ksltynpbATQEjkQxfwp8PhyBpYFWCWdDPHW6fwft9f3yJhcqmOPlPzhV994NIEh8Dk3zP7eLjDtkyh2gLzEmZ9G/kKiUxQlOPTAA8jUTVAvoM4aGUSvtyDIx5Rlorz18omwcvSuzY35MWUmkEML0eJryfqz6jR8xN7n8P9yuNlLuynXbnXJNfc6Tk02ynddnB68W5rp5h/CNH6/DOIbIUXTVkQv7mh1ElARwnZE5NvLpGYhdY4cnSMBw1htSACeaINU1DphtOOMcwS/TMT1VK8pw9IKUHQTJbQnMwIgU601eK5Q6clzavaqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpLPDeJ54ONAc4TN0m+l0Q26iEh6HnNjgmk5qSw0gCg=;
 b=xkx4Bxww3hp8fYz68yEqiXqYhmhDepVfPt+8UFiJKCPv1/DmbGdJInYsjdEuuWVMJ6SUPPemYuW9A7bTwa8wcCqKw1LF60Ne14NtBHsil7EdRl1/yOhiS+3rUcXwlQQgAUwUsKiXa+fRrn10+rYF5ZQjubCSoJNBoEfguOsVTSS0c7jo927IVARKoPShgAUe6lrNCSNUEkcsHa8xWERkVVGIgwla+8XaKnvp3BEcCqiV0kOQ+VtBwRdnI35BprOlNW51xQOmrnYldVcjsgnNBEul8xINayNhFE86LzF3Vq6ejku45C3o3OhWQo/tOt+LvgNBd1q30EOoMcca1BWmWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpLPDeJ54ONAc4TN0m+l0Q26iEh6HnNjgmk5qSw0gCg=;
 b=Dt+Be0TgdvK55mqr6Vj1gfDinbXSM0aT464GGqaiY7RXiVqVim4GxXPtwFixDKzOhDffC6arU1yOKvCvxGjGFOmkU6NmwMt0clP58DBG5jAfAngfCJOBigltAYdEZnP2rWkIU4+G1JTfXXC8YFdDM9ITqUPAHaxM6sDFYH7mhGX8DnJoeLehNz+s4liHM0cXSbDj3FzOOTrcwFW+bZBtgtSoRxEgEygwbiorhrGXu3TUfUcuYQdAlOkoxEro9A4qyVaYrLtqzYkfFA1NKCYcK4UeVag9Cu11sspw5e953t+oxdk7mC1CdUmB0DCY5j4luj5l4iMeUuX2pcUPbzmNmw==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by PR3PR09MB4329.eurprd09.prod.outlook.com (2603:10a6:102:3c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 17:37:28 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%6]) with mapi id 15.20.8445.017; Fri, 14 Feb 2025
 17:37:28 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "cfu@mips.com" <cfu@mips.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: [PATCH v4 0/3] Improve Mips target
Thread-Topic: [PATCH v4 0/3] Improve Mips target
Thread-Index: AQHbfwceUr8DrAArg0SLvh99V0Mq+Q==
Date: Fri, 14 Feb 2025 17:37:28 +0000
Message-ID: <20250214173702.2308488-1-aleksandar.rakic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|PR3PR09MB4329:EE_
x-ms-office365-filtering-correlation-id: 6dfa1ed2-2050-43bb-d66d-08dd4d1e40bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?9MJxJx7PRWyX+pvGvnK0dK3WHjJCB48lTjkuyDJdHoykAhPYNMgbleYiLw?=
 =?iso-8859-1?Q?RgwBetQ9G1rrqX7Gnckze1KegaVCwVKPMi5KQCzFATUYaSQ/19XT7camU3?=
 =?iso-8859-1?Q?wV8KhHhv+pkknACsumj/xxB/V+5s3JB8wxcH48seikb/k1TaGFT5Z34NUx?=
 =?iso-8859-1?Q?iS/1wIIkpgGcapvTw1tAtbq7XsAQcqBOfuUhuMT79uV535P1COho3AL4dX?=
 =?iso-8859-1?Q?3oTNZuRWwdGN+Iv64Gji6EGgnFPADq3VpWW/YE+vRTA4ibfuqUV7ns5X5T?=
 =?iso-8859-1?Q?71GteFXR2GV1sxBRA/3E/uWhhkYn4WuGvsjQYGcCav24NZlAsP8rq4XWDG?=
 =?iso-8859-1?Q?SXv/Xq81B/305Dbkr6w+KzHe/fNYkKoVYz1z6GpV5h862VxtCl+0JSlKks?=
 =?iso-8859-1?Q?pwc+xvg65ywiKf47JQZCwZqK556JgGF1m/fwuXbTYZswe8J6ad8trOaR+n?=
 =?iso-8859-1?Q?LU47HxuDjYI/7GXuflpKNKrlabtIqEev0u3+19QfofqbGBAz/o7fx7XgLN?=
 =?iso-8859-1?Q?pRZ4sQspIN+eFbODO2xeJogYpCVSMI5XQiFRQIMgPDMwwcNM6U5qAZQEq0?=
 =?iso-8859-1?Q?p/SUSTT3uMTjEf07IxlnKb1mW9w7w5IvGcwPc9dBy9QpBRPzcXyW8wDP41?=
 =?iso-8859-1?Q?tKlYUa1gUj7GcPt7z56g4tFlk6spkyymvA8AkJgx+lItAFnxKe4Ls2ayXY?=
 =?iso-8859-1?Q?y0pStzmHkVntkBIkvOKvcmvXqHbR/NoyRw8HQ09e34v00YLOOgphT4u093?=
 =?iso-8859-1?Q?+AfwsFba8MVp3zDI7duE0vWrYlg0G6b0lXAt6KZ0y+CZVP370Psf3EUzWx?=
 =?iso-8859-1?Q?WPcaBybd7NlWGBujkv7Ai2D/IrisHhorudbmlTVlshECL9SyGlQXxR514l?=
 =?iso-8859-1?Q?kwdpu2Jjb5dqw63zb5u9WAXuyA2VBt+m6OTE5XXWR9F5kuUuFOrTj3994i?=
 =?iso-8859-1?Q?BVl7CR9BdK4YNF/FHAOhcqfU9I/1ekrBByzdCjY3Hu50hkp9PYyP9h3Wu8?=
 =?iso-8859-1?Q?u+UdAYu4ZEiIV0ggz2iXdSz/zGZBviDOewuy4VH7YZeD5Aq+wFYL7qwF1w?=
 =?iso-8859-1?Q?rGGQJyPqJ6Y8qB+3+Ubo7SKi6P82+0iUz6NF1UNMxC8RWcgnyOOO0/JPwe?=
 =?iso-8859-1?Q?CMdOOzdpdABEMwaFz/Rxh0pnCeE6K9/8ndFm4+Za2F/fcZEstcQjcr8XYc?=
 =?iso-8859-1?Q?f1D0vNT/BaRFrdZW1BjCqQpMJyg7FxfJZJP0k2ZTeh4sMEHJ7spBFnOVJH?=
 =?iso-8859-1?Q?eQAWLUJy+yXysBa8G2EKfcpEf1aal3Y2QndAI2abY8ECkpvTz4kOdjCvUy?=
 =?iso-8859-1?Q?C1nGYJ5TMdxwKMClT8mqZZK4z+/WkfawI0ItZqwJZxG0+itsM3HxVh2but?=
 =?iso-8859-1?Q?IPrTxAKHsWWlvOohiXFCK92tOZaPu2cOjXdouHHDLosiWasp7N3YES1M3C?=
 =?iso-8859-1?Q?lFfgbUwEMLXkGxUqjh7avbYAkliNlKMJn+ke7qr0IO5WSmf8Z71+GjgHMF?=
 =?iso-8859-1?Q?KVSe3lOF409gLFeglvVcye?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DchGce5jZalO/3PkLdFXRFpUgmmKlZ9TNJbi3dBeiQ9G7H4/pQuRd+qSKj?=
 =?iso-8859-1?Q?Dm7foTAQJdaaPtSVQUF+mazjF2TVWrrE5pdAiQrgZTfuQ2FoYHnC0egZW5?=
 =?iso-8859-1?Q?lXWr97ugH2m9MVXovUSjG1YF5BIiY9UOGJNXrBgvPe1aNQnf+u9gm2k6eO?=
 =?iso-8859-1?Q?v/HUwvJ5v+4ZwaS+mTkcksxfjiZkFBtoaZL94i4uZMDbLlRUDZerTyDbLu?=
 =?iso-8859-1?Q?C6JFor0YIR2gM5nAfNZwGtxH61eCJzzUxl4VxQp7iLPgGhB7LKjGYs+lvZ?=
 =?iso-8859-1?Q?3GlsE6ZvuYYlNQGEunV+aQJrVjC4p/oM9WYzJFNzj/i6uzsT/GMPEzDalx?=
 =?iso-8859-1?Q?WQKpm9I9qBtQ5gI0Y5a+vYQ2C/M0ARSWxip/YWyFd1JqOaAJf1ktsw6lFi?=
 =?iso-8859-1?Q?HXja39icZpqLKcqY06IessMxm50qYQwUT26gwBwJw1u/8o7MJRRzYInI35?=
 =?iso-8859-1?Q?D+F8owOJ/WMoWL4s/43Eg8E3mddLnuDBN0lFbBCJiES50j0RY42vfbyT58?=
 =?iso-8859-1?Q?MfO8v1GlQ5eHHJSOASmLktdWhOvyhaG9q37k8bbc0YJG6uwqTVHICso+dB?=
 =?iso-8859-1?Q?P3fT52ypY2n8iGT9eqocToMrxooilCPNvcrq9QRggAQHQUPSEqa8yhBTfU?=
 =?iso-8859-1?Q?xHHJKWXmubnPFCUI+rTq/yyH1yEQWWnYsAdoEM7PmfZqtr7PE/Zydjfun6?=
 =?iso-8859-1?Q?qRs1702p7r2lg1GuRRtAmhhMp2cHL/aX/ssm0w9YMajzrcomWMa3S56J7T?=
 =?iso-8859-1?Q?ERtWCjfbCzhCmNXkfjQohZpWsMCImdrzgPlpiSlhm+sqcoMkARjUKB+Kv4?=
 =?iso-8859-1?Q?m4lGe17DXaXvLhPqFyi3TsnoIthLE9L6MOeHtKrBL/fe9Lzes8N1t6dT5T?=
 =?iso-8859-1?Q?Supcbx4FjxkKHpSYgF2ZJff39Z33d6qLw/b2HcaGJoyyc86eeuiiZejl5k?=
 =?iso-8859-1?Q?CeEyZpGTiL2rG9jvAbN8HYa40yb+zw5ZV0ag1t5sH5HGSAPaiUtWmwcVNj?=
 =?iso-8859-1?Q?o0mqN7Ll8i9AL2LnT9lHxB2eXpE76nWZIgtKwIJNjvrRJ04ZZD8h3tdaJY?=
 =?iso-8859-1?Q?meMnuLUIW6BhbEpJ5OEo6tDWDLqjcDGbKa4NppxKKECvdjBYvhYmZHE0za?=
 =?iso-8859-1?Q?tkgtE/c7Upei46Q75Vk8MdGAbpNT2T8QQOi9evoZFU88lhdw+D/7eE06bN?=
 =?iso-8859-1?Q?wSC3AgQl8pjbDQlT/bcNI5JwsuNRdJAO3bYtvBdgb65JNKqCpbLCObccMy?=
 =?iso-8859-1?Q?330m5rnESdN7b/ymDkwydHpY5f9Yb8V6Quzu6jVmBD0lVxQJQyYrVk6v+k?=
 =?iso-8859-1?Q?N4SH9hcHCSHcP3cNqKXjJmRi3xsSCI8y6/anMS6vHQvlbm2+jBMpP5ejgk?=
 =?iso-8859-1?Q?BzV5VKD3/L6w00G5cK1D0IsfCQykX83WJ3pspyebUVPzvgXKzfd4Sg1+eZ?=
 =?iso-8859-1?Q?+9Tv3KL2VoAJTmkm6XtDGahdQhzDCi6LJ2FR1luJoe0eSAqyjoZvttfOle?=
 =?iso-8859-1?Q?glVuDnQUL6VjT1y2/cM4A3I64uYJStjy8dLAtOzXY+GwDam1YHgGp7ry8z?=
 =?iso-8859-1?Q?xdaRcGbITRZJlZaPgc6pcNuOQpinsJcckV1VVikkh3EJvDtsF0/FRktpMB?=
 =?iso-8859-1?Q?7Z2Tp0Yoc+x7hWFJvXNG36oSbnXdgRvDIoJuk18rm2d8sCuVNfBcPkSMoD?=
 =?iso-8859-1?Q?auruHFpf9xsnZXMmKMs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfa1ed2-2050-43bb-d66d-08dd4d1e40bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 17:37:28.6332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q2V1/A8s/L6SSwNl6BCrcPz8JLdjm8EU5KI/lHqjdJ80wnbkUQIjsWZWv8SoHahMIpqgSA2Hff2XKAOqRj7gM7O8rVc47Z22mn1yvV+3PiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR09MB4329
Received-SPF: pass client-ip=40.107.21.101;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

This patch series adds support for emulation of CRC32 instructions for
the Mips target in QEMU, skips NaN mode check for soft-float, and adds a
CLI flag for enabling an MSA feature.

The CRC32 instructions are available in MD00087 Revision 6.06.
Since the disassembly for crc32 is hidden in commit 99029be1c28, the new
version of the patch 1/3 is basically identical to v1, except tests
being added.

Most of the following patches are cherry-picked from the branch
mips_rel/4_1_0/master on the MIPS' repository:
https://github.com/MIPS/gnutools-qemu/
Further details on individual changes are included in the respective
patches.

Kind regards,
Aleksandar Rakic=

