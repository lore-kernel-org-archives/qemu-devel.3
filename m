Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D8CC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 08:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlO4f-0004cG-3s; Fri, 21 Feb 2025 03:07:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4c-0004ay-Mm
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:50 -0500
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4a-0005ko-WD
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740125269; x=1771661269;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BrG4y3xDgUJOKdvWUgQWbXUTo2tp+lMrO+qSWDscVRo=;
 b=memZNBwiLKK7AIDte16vo6MnkMVD2fvJ59yC40tzTME8AyHE4OSMNaxW
 z323FlrF5GQWozkfBidkk40EmxTrwKyk6BgJ2FI/gi9OheRlivPHlRrCo
 U3zaohaF+qJ7U1uQA+np39q8ewwcAg2BuBnQwWKa+gXd2SYlJlqsjtgkb
 NXMbAnLST51t0kmruSPWlqkHbYp6fv4P65vl3pNau3Z9t64TG0sX9nXFL
 EKeFp9uKflcMpDa5sQgxm6WzbYMiqXMpDc/x5ds87VypsfiJAuR7sGuDD
 vadlDoPup0nb+P+Kk6fk6/BzLlj2pUKqnPvrrWcCdTikRTyitPzIaDOet Q==;
X-CSE-ConnectionGUID: vaOXLAvTTTW8m0n1+0fJaQ==
X-CSE-MsgGUID: scMsAkXxSeGc6IWWpKbbmA==
X-IronPort-AV: E=Sophos;i="6.13,304,1732575600"; d="scan'208";a="31394146"
X-MGA-submission: =?us-ascii?q?MDEN2jHDneYqbeae3jxb5kBe0ShaTiDAxS9dzS?=
 =?us-ascii?q?mXOlxZ0ANpeD+t1B2pKEWIEU1dBG8cviNmR1hvfPdapr4G3iA5HQLN9v?=
 =?us-ascii?q?wPu75DqjV85/sStT4XHhvOIUR3WzbE5n5ca7sAXq5mO6WyYiBM3Wahut?=
 =?us-ascii?q?AHrYSSvEfzRF9Qx3biLqoYRQ=3D=3D?=
Received: from mail-vi1eur05lp2170.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.170])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 21 Feb 2025 09:07:47 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkMpXL4FvlRUSUYkxW+SQp4OFHLFkWJfWpSUjl5zWfs8V6MTT9M8KXijM3yWR5wo6+SW2/SeeWHY0GiMbi6COr98Ncnv9ocD9QzpWEgqEQRrKtNPnsQvZXx0/GI2w89r1TogkUJ8PFj0fEyLfPm5zjSTPVP6AkN1izUCuJ9Ue/coT0OV1sDR0G72fmN1acKIDltXOX5TXc5PxDUGHYU85vEAZ5Qvn6QtGe2lp9pqqiUDhugmtlUSderapGml5GugJ0/DKfhuQLxlcnAZ/1u2oXxIdg17dHD6oFuR9TfexGKCE9WucQGUQKkdTuFXhxRBY5AaYzSJmlR1PiHvCY/39g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srhIn/WpdlVpAE2cNticNNYMCyk2sH0vssLZt9U3Azs=;
 b=wTKdASl9wIhFYquY/mAMUaet6Tvv0dp2iQAE7obkelAGAQkqfOf6cE9qKjvi3gcTmK7CH0i8srmPoYSjrCVpfvk2AM2UPpxDSu0IkCiuc+dkEcUWCbrUhtaRzIzSPM3TzNEznkZzdYUVgHObhV/aNnuwUVi/MLrtJWKh6bpk3cm9/352yP/ibR5UV8hOYP/6+xfi1Brf6LO3n0q04ITNGZ+CvA6wGYaF7A158vBf4n8TSDJD5602jDLL0kf55gC6nfIbm2E4oQKm+mGW7x2n6RRTBeuktTOXLecX4hI4YrVHepEWcRBjE7SHQrVjT+SKjv7fWQAxaAgpo9XACRghGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srhIn/WpdlVpAE2cNticNNYMCyk2sH0vssLZt9U3Azs=;
 b=KQWg7AkaIuFYoGkER52wxSK3hP2Z/CAELR9XkWyi9KQdjQv1fC+6SEZJlfR9bWfhFeCwFwX2I0pBlsrzaCm+ZbYQ5ysitePejOEZd1LVlDjHDVny0yd39XI7/ZHZyM2+0OLHrjsZJ8qkhgIbFwC6gOZrvlSeBAvFeM9L6COD/zIBMlwbkADiFwEKgd/zOW3dxkfWExGhwujkkroMBptUn/zlHxEBBxXePwnPrQGkmjNbESTb0BTJls7sOSIJzPm6bu/a+e+kkxDCBKd0b9R5rn4dmnxu46cxce/swmzKFqNQeIxSiwQT4bkCLAjFuGMcPSPFznpPxLgial6ZTrjkwQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB8PR07MB6459.eurprd07.prod.outlook.com (2603:10a6:10:142::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 08:07:43 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 08:07:42 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v3 17/19] intel_iommu: Set address mask when a translation
 fails and adjust W permission
Thread-Topic: [PATCH v3 17/19] intel_iommu: Set address mask when a
 translation fails and adjust W permission
Thread-Index: AQHbhDeu169TFxh780WaPeBcIqbPLw==
Date: Fri, 21 Feb 2025 08:07:42 +0000
Message-ID: <20250221080331.186285-18-clement.mathieu--drif@eviden.com>
References: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB8PR07MB6459:EE_
x-ms-office365-filtering-correlation-id: 72974e0f-bdbc-43a0-4122-08dd524ed158
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?0YQ3OBIJ3r/cc6Kg7+0rIsBOJ4loLNlxIS0MC9owrneG6CLNyUR4oBcOQE?=
 =?iso-8859-1?Q?dLhPdWY00ZeFtvUazcWQeeBEQgy2PSm05KrOwdKskBX57KHHAFq8N8eYE0?=
 =?iso-8859-1?Q?LXI83bYZcyWnasrMMrgIPab3uhTkMrqCuRvDDodKW4WrgeUZY2bOFghA7u?=
 =?iso-8859-1?Q?OhDl1FQRqHKSe4bQCIk6VQanVNoxk8vqMHEul/gjD+SBiXNCaKRkJtGXNc?=
 =?iso-8859-1?Q?VJSmk1BORR5hP/IE2/nLgd+/9Ll3CUDR7qNlrtXlGfB2aUpnpgMKC1HhC6?=
 =?iso-8859-1?Q?J2i29JfCxxgfzCLZFOFQB9yz3XfLlOl4P+NaMygEafuCFDBX2lE0oWL4S+?=
 =?iso-8859-1?Q?AvPrDNPGKOt1eDS7PkjA2LIqaPmYmUO8byMjysCfPJPtOz/4AMiCb3Y7oZ?=
 =?iso-8859-1?Q?uCRXOwKqS2JbZYjv8P/d1Qt4/72gXPnlHnDMrycmWI/1a/mhYwylRmdoIt?=
 =?iso-8859-1?Q?gE4jKqDrR9ePWJTCa81gyDbk7hn2FiK6IN+QdS09e8twX3MJfrHLclnNkM?=
 =?iso-8859-1?Q?oGApbWzXhzJMTTIRm1bqec1mhuoCOCkQDAlS+FeSDec5zABJwa0oo/yUT0?=
 =?iso-8859-1?Q?4Vn2yyWWaVM8Coawz5ZsjWXVQ9X0mpg/rFMXYZwgSHIuVIO7gJgiHtT1o1?=
 =?iso-8859-1?Q?KfJybMgxQPyv38z4KTvjHoWMHjD29mv06tudijuNSYA4JobrEPgxrWhrWG?=
 =?iso-8859-1?Q?CWqh29hcgSkrTLAP5ufczdQrZBrh67YJrG/31FTjybihhwt6i4Y1HeDWXt?=
 =?iso-8859-1?Q?lZCIN8FOorTqLeApNaC9ZRUeVJkySofD1YfwcpJk0oiyp22ucf9RUPEwDD?=
 =?iso-8859-1?Q?9xjQvds+JD965aSu4kwknrN4Bz/BnRzEnT06c5wA5q8JBR4sVoT6PgnD+/?=
 =?iso-8859-1?Q?EAOHNAwIFk5uRyhJSf0GyX+z+RKhymoNsYrQJU3N5TOUHIg+kMmciEfl/M?=
 =?iso-8859-1?Q?0ysHwQL5xoIm/Psj4dgIhVqfnl5gSQ9CTWOA/HYtdtka9NHeSM2fhWQRUV?=
 =?iso-8859-1?Q?4MedrQ/R4JUNgpx6C+smL5k4ne2Yj5il3/oiRCjK/rt95xpFDgBGOzxRWT?=
 =?iso-8859-1?Q?fmg0/n8USfxbqVUwwiUBcwaIFzmQrhbkMqGsIMLScGHn8Q7WgCygrCCAfQ?=
 =?iso-8859-1?Q?DW9ltZBoVPDtvcFSml/m2TaSZEjuQg3WtN0i7oDgFMtHDAKmYEdeqz004V?=
 =?iso-8859-1?Q?jxfMymdMEsDgahD0ceis3omsTcZ8xXkVKbAXqNVXhvjQftgB4D4hEjbXWw?=
 =?iso-8859-1?Q?EMCbT+Ov5v/huJHo9qB5jcEKwhXWmXOzujKLQxufQiShPQnZ5rXnG0nlhD?=
 =?iso-8859-1?Q?bF/eOGLXJ06nklNeFR7lwNNFSpudaImWuCThJQuXAMrIo2kxkfkPZxsYNH?=
 =?iso-8859-1?Q?UcBO3/2J/tipGS6XCYvhn0PhBLXa9jHuBX0oKPL2ykjlmEKtmQD6kHq9Oe?=
 =?iso-8859-1?Q?6t1/YpcaWCDlE9kf6KdJnxWkaVE9JSHe8eYuFLiILZF69M44jRQkDxYeuQ?=
 =?iso-8859-1?Q?rppoLDgkuT67PbpdOuAIoh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mGn8lmtpcXtNlrt556d1Kx4cNjmIBtEC09gDnEqOJ+7t5d6ULfq8bCbtb+?=
 =?iso-8859-1?Q?0GjrxIrjHY6EXs8Ie59hJBuoWatK5NuzjkMKxa+ryRDmDKlBVoraSV9G+Y?=
 =?iso-8859-1?Q?7zwtVp3nO2Awp3hB2Y+J1bkU53siaio0KEmm/aH7ZjvnZgJVNZCPik7pac?=
 =?iso-8859-1?Q?qTkFXsZpN1Xz1E7xsP1gYv/DrwIqC9mAh75d26Mm/r3HFJ4D21JUmuyf/M?=
 =?iso-8859-1?Q?7aEl+HfDp/FE2e0d5mtzlxlXzOmb5OnQ5TFrxSNuzLh0hYyGON+o29xqhL?=
 =?iso-8859-1?Q?8aR7c4umzeSAqqlr2Mj6/S5f0RWkmNjpQrkdPNwxb+X7R5C0kuw+paiKO9?=
 =?iso-8859-1?Q?Ruvj+RVqJqKkOJFv3DPbRI9cXmXisI/xP6PXMETwaq9A2I2P9ZzmoHAbsc?=
 =?iso-8859-1?Q?YKeCGQS/FaO3ATWDyRuhO/pB5Fqdh0aocbC8FFxqWsv8aGgqgMGU8uXjEB?=
 =?iso-8859-1?Q?60QF0Ue4LV8N6cnn4FtuWPhoAeif37k2Juyl0En5mJM2ZLlGISG/fhd0GP?=
 =?iso-8859-1?Q?0GELlQ4C+YEOwa6D4DMvUVKlmBV0o4TcYHPMKeNGUqYwNImMQTvh9HYxa8?=
 =?iso-8859-1?Q?5tWEop44rQ5U8oNLsxmuqIzesHOqAQrudbtYfmljqIHSwaiNrCNKNYisyN?=
 =?iso-8859-1?Q?IfmF53RuBAMUhUJdg0SZmd+vaf2jUB3rUniruxMDnA3YufxaaGLFzp7DnM?=
 =?iso-8859-1?Q?Nt8MjuVqWWLujwZygbKk6alJHwFK0MzmHf1UBkedv2p5lo8D41DylaGcL4?=
 =?iso-8859-1?Q?duwZ1ak2foposjOl1EkQ3GFQcjRPsd/YSHraLqqFTrG5QKJew25ua4Rq/W?=
 =?iso-8859-1?Q?p9c2HZM0NTgU6GY5tNdFwjejn+Rd+1/K/5d9Awnek3gZOrgOTk6ZHx2Y+Z?=
 =?iso-8859-1?Q?6o9XBL1rpO+tNOrM5vjhKtC43EOvOHvxP4bATnHipJaLxWmeA0S/FJDSp/?=
 =?iso-8859-1?Q?9CT3OeKNoiwMhtdC8UKL2dFt+TZFiRbqfcR1hoH0hEyT2lSmfkz1ZV61U3?=
 =?iso-8859-1?Q?abX+lJAeQ3ZylwnqBZkmJB0p5CgbGrGmF+e89t+pVU8v8m+QQfzRjHAJie?=
 =?iso-8859-1?Q?6Nwo5lJVMaRq1HPDX6vHihrQV7H9b68xD13Wsv/IbLOuvfSIZeauz6MWe4?=
 =?iso-8859-1?Q?szE8C8eIZepqZVnMkZtVBneG30VVgi4qCsKw418MkXekqg4SQA3lpDXc6a?=
 =?iso-8859-1?Q?rIpOSUH8k6uRPaxSoFc2+6P5x6ZjM53/6mVtonU0HKSlatYt7AP6NqC/gt?=
 =?iso-8859-1?Q?McElFAnYJl0wmfNY0S8rjKprVvfvF3XwN4GlfO5bcd2ZUj6ESUmlZ8LSwm?=
 =?iso-8859-1?Q?6DHu2EcrIiGjEoUVR2bCZJAzanb6aQDmGxdNY4f3GqYLRCUQVlFuNrgv9D?=
 =?iso-8859-1?Q?B3LopflEmE4zK09YYxc+wI+OLgCFTPKV+k4o8zCgflYExT5khwEDRVIuRl?=
 =?iso-8859-1?Q?dYo0YkewrBywpmGtjBducgqw9GgUUWn/IE/UlrAi+BTT9dNl3L3G20hDkt?=
 =?iso-8859-1?Q?ZqT66PI70T/tmMV+/q1o/iK2fDYVzJ58BYi1cA1QqLaTOGtLvObPCDi70f?=
 =?iso-8859-1?Q?hWagoz17tRgSeXQMXRsdRBmjlXWLtgVpwYZDlufj5dvwJON9e/iw7CcbWV?=
 =?iso-8859-1?Q?W9wFm481YNdZz+W5s1S4hQwfnfbzYXnoKXfuz4tDK2iSGb/+74u6hspgZ8?=
 =?iso-8859-1?Q?5H7YbiYVp+cmXkBHJ9k=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72974e0f-bdbc-43a0-4122-08dd524ed158
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 08:07:42.9583 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dQYzHTkyuE2PiobLm35HuW08jGXa6ON2W9h0a4N2VVzMKqgCVbxnGTWQn94ZLdpBdiWZkTmmUm4fS8uoJPwW7O2p9Z4DTFx7CQRyF7Cs3hhMFzIeOpJBlgbY0QPPdnhb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6459
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>

Implements the behavior defined in section 10.2.3.5 of PCIe spec rev 5.
This is needed by devices that support ATS.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d3772d8902..b9b5d492f5 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2100,7 +2100,8 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *v=
td_as, PCIBus *bus,
     uint8_t bus_num =3D pci_bus_num(bus);
     VTDContextCacheEntry *cc_entry;
     uint64_t pte, page_mask;
-    uint32_t level, pasid =3D vtd_as->pasid;
+    uint32_t level =3D UINT32_MAX;
+    uint32_t pasid =3D vtd_as->pasid;
     uint16_t source_id =3D PCI_BUILD_BDF(bus_num, devfn);
     int ret_fr;
     bool is_fpd_set =3D false;
@@ -2259,14 +2260,19 @@ out:
     entry->iova =3D addr & page_mask;
     entry->translated_addr =3D vtd_get_pte_addr(pte, s->aw_bits) & page_ma=
sk;
     entry->addr_mask =3D ~page_mask;
-    entry->perm =3D access_flags;
+    entry->perm =3D (is_write ? access_flags : (access_flags & (~IOMMU_WO)=
));
     return true;
=20
 error:
     vtd_iommu_unlock(s);
     entry->iova =3D 0;
     entry->translated_addr =3D 0;
-    entry->addr_mask =3D 0;
+    /*
+     * Set the mask for ATS (the range must be present even when the
+     * translation fails : PCIe rev 5 10.2.3.5)
+     */
+    entry->addr_mask =3D (level !=3D UINT32_MAX) ?
+                       (~vtd_pt_level_page_mask(level)) : (~VTD_PAGE_MASK_=
4K);
     entry->perm =3D IOMMU_NONE;
     return false;
 }
--=20
2.48.1

