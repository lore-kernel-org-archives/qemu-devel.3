Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC2EC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 08:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlO4X-0004Ye-R3; Fri, 21 Feb 2025 03:07:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4V-0004Xv-Mg
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:43 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4U-0005kF-0T
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740125262; x=1771661262;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XhwWxkxj+r+rx/BdxYfbt+I91UI6Lq8eWKoAUnza1aI=;
 b=iC6qcTsG5nCKB/dmfoXk1vtTjXNOwiQ6kv8XtieKE6Eu1OtMhkLGSX15
 /I4A3x/uNGzts73aXS5JJPog4SpoCICO9Nv+I5muqcw8VUm7cz0HZFPrP
 DvkuCUUsjoQrQPN03QLtTq2RWNC9EMJa90euFUUi5qwDpRckQnV1EYfgj
 LTSVhT1QtPoWKGymVgZwlbY2eJ8fiaqVOcGzqCmy/zplw00BEHhZtUiYB
 nP9jJZ+BirylzSxEMj5/ueqCNqnfqBwuepS82xl1GVl/8u/SroQlquogs
 Vlym6jTuXCtStES4btvE+B4OtfSm8cRAmY0F/YWCdOoGjsdggVi4IaXsm Q==;
X-CSE-ConnectionGUID: aKPf1IpZRw2nzwnD8NV4UA==
X-CSE-MsgGUID: zPIO3IfaTTO3H03S735UlQ==
X-IronPort-AV: E=Sophos;i="6.13,304,1732575600"; d="scan'208";a="32836648"
X-MGA-submission: =?us-ascii?q?MDGvXXpR3xqiy8YIk/FGbTxlEa96OWPOShFQ+o?=
 =?us-ascii?q?OcWOmA7HGuKvjIwNByQVwc9gf2ndgMpBJTl3NkRAjqSPqugANXrHLIwr?=
 =?us-ascii?q?Era5rf2zpKOuPYy7pj66l8+Krtplh80w7zIhFMpON1WPl7iuVjnYyGNQ?=
 =?us-ascii?q?LiZL3JppfgZQihDI8n8OYOdQ=3D=3D?=
Received: from mail-vi1eur05lp2172.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.172])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 21 Feb 2025 09:07:40 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpdMrxV906jP7rm3nETl0d55VQUl5p0xDW75fK73l79yeEfCl0r0QzZt3f5lUS27Sds6ZMX8aNRl8HYO9fQjUdiZ8QXs0kkzMjAVMVKKwX0sLaB1uo+ox3Q2NewVPeZZG/RU1GXebfV8FvCb/9ChXGFBca5Dk+t0779gqzKr31YsYT+GSTeMWHU/C4ccSs795u2HshDR5cmvlx0bn5GvvuN4lN8r69q/MWJ2niWCMwHGppOitQhyP/aARYuI5KFKO92Yc7hMIsgIofg8WUluUJVaxFCkvHkbyKUwXjgDHB0Hfb1pDypeBI3ZtOUINryHH8i5LHVU0Ao7MNTndy38xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6V3J9Voz0NXho2p4lgx9KAMBt+ze0a2/WvfE+49IGI=;
 b=M0gc+qrv9eEOwfASx8DRpecv1gY5bVEMDFa0ekvZYcaUNUdhf6DsTgn36cGnN1dL24eDx2lztDE0dwqyUH/hldsufJuPGP1ShelRB4XklpLm3JB8sOnE4OU3qhOLvVSPoT2G0oq8haplVhXd2qFM6pa3z60oeH5EvJ+zBrf6o2hElukKbmsjdbaWklqUa9x86dADk0808KsDxWr7ECB8efsXF0SrEsBL9b7JPxu9XhdstEH6hN4YWU0OV2abinRUPSag/SjJsX0kumkopeL+UsmqKfh9iWMd1NcA/bB2Nm+TbRBn0S5kadwMpR/68g2qyISEp/qDmkfNofYRTRSWLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6V3J9Voz0NXho2p4lgx9KAMBt+ze0a2/WvfE+49IGI=;
 b=rWOnsM4ANUCWnRv6rEUKqYwDkSfrm4U5RLUw9bOFFLjDXeCDg12KAu8OauIBbr9dnx6hMoEenulPLAibYwBKSQugPewM7fJUpXlxm1EtsQvSEcmOrqa/syIttEcRPnBkDZsO7Xpk1chzFOkJV6yyQw4bg26RLP7P4WLdJ3xWK5hpinKj9rlsWngMqmlDGIF3zZPpo3+gbpZHRmu09T6uUZtrt20LURgp6WCwxIMtsEJSJ1OknaOdVZb/SZHSS//+gfzKqnmnUTP36Q0ogN8D7Y5RpOP/o0XSFsDVd6LDBiyBY5DUfsFkvYQx3NjbjB5WglMNujv18xSXjPn3j4FHjQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PR3PR07MB8162.eurprd07.prod.outlook.com (2603:10a6:102:175::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 08:07:38 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 08:07:37 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v3 09/19] pci: Add IOMMU operations to get memory regions with
 PASID
Thread-Topic: [PATCH v3 09/19] pci: Add IOMMU operations to get memory regions
 with PASID
Thread-Index: AQHbhDerWrLlxqejqU6iqmu50TquXw==
Date: Fri, 21 Feb 2025 08:07:37 +0000
Message-ID: <20250221080331.186285-10-clement.mathieu--drif@eviden.com>
References: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PR3PR07MB8162:EE_
x-ms-office365-filtering-correlation-id: 0cc42c02-1b9c-4411-aa86-08dd524ece42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?yCdjXvLG1V2/eVhGwDzeLWn+QJhvP85wn6Qc/SziYs7P4ZzLLPz7iHcaWT?=
 =?iso-8859-1?Q?i8Qxv5FrbVKZaboH3qpzYq3guPAPKoLhv34DsEk97yKNbrvsxChVWBKe0k?=
 =?iso-8859-1?Q?iMvqswq7vCu1HGWnPG47yIlpvWq1CQKnP3JKyX1x2kog3d3nO599Qp144I?=
 =?iso-8859-1?Q?n8h+qiw0lFGcXGUi9widZUUdJrg3yLi9NGbyoNDDLL/lnFL9srr0c+t734?=
 =?iso-8859-1?Q?2KXJN/ziqVa9jL2STylENHCr2vcmzpXAfbCm+3M6wx4JkPBZ7VS8k5vDh/?=
 =?iso-8859-1?Q?W9hM+LHXBTYpWq1Oy/Qx27kjdvPLelIL6O4XTV2tehLf/qoGU1tceFK9mU?=
 =?iso-8859-1?Q?7pDAUOMoeG0yaEHEXJE3C26qohvcmjXSOUP8cibJoq8pkwuN6NWiKPE6YK?=
 =?iso-8859-1?Q?tKERtISlV4klB1a4ikMk+fGe7ELaD039ZquAjg/qB/21EwcwNEiQjiVpVW?=
 =?iso-8859-1?Q?kD+CBzVDuBathMBS1DoO0zvUjA80eaHG7K7i/qqpSn5jqP6mwRHYQKpdyX?=
 =?iso-8859-1?Q?bs7StgStMPMq0axSMMJjWOUJFZ90kLt0EVteIoLLDU7j6JIAeEs6KbDP8L?=
 =?iso-8859-1?Q?vMSjYv1IyR762kMOQMI1TzHoKjjiuN4ovDxE8zDG0+10/atAgGk3ThSsZY?=
 =?iso-8859-1?Q?VRKCAtPIMsYTlobgt3aVLptAIDhDC8JvPCqYzcq6mjgh8d7Co+/vmTnnfm?=
 =?iso-8859-1?Q?yLZDdwCExmGyafkw5lqYuKG4JbMDzzPzhXse20p62CjSkQUv4Wd9Q6J+WR?=
 =?iso-8859-1?Q?VK23DOyE6HAwHy1vtFRo0oL7EJRvVPWGjmIirEMttAfi+j29N1tPfwLO4v?=
 =?iso-8859-1?Q?N2rb5v/gGUJtdT3iTlcwqu/25R4c4g6bf5fUFRxjsY1CiJhfFQB6wRY3ON?=
 =?iso-8859-1?Q?LeiPM+CCTpwV8B5JQFOWpWiFemmTLl8WqNo/FeyCO3ceiZ3wkD/JDzjy8O?=
 =?iso-8859-1?Q?qFAynxB9m8QNydO4f5wCn70G8VN297oTFl4hPew89JcGjfgqt7nJh/xsrq?=
 =?iso-8859-1?Q?mxNrQX+xhPcvxYoK6zqhqblHvIh0Fw574y7I7tGoG4SFloq8J+R1viZ3iK?=
 =?iso-8859-1?Q?iuq4RRr77YIoh2EdARmhTfz1Vfi1EOqmpMqsqhAeVcqRXm/eoFXwLzaw7W?=
 =?iso-8859-1?Q?132197LpmV1E/FPKWt/dZqnmDoSR7l0pkawOslQ3L0yRpE2LhZ8ZRX6QEn?=
 =?iso-8859-1?Q?m5OqR2YjZs5b2AyKiORTzYmgkANXZpPyureDsqeJAbieImAviOsQ1cpfS+?=
 =?iso-8859-1?Q?fa6A6qATkOBsrJTfW+lot1KeeyD2fDEjULD7a7aJ92EvzCXEpt21Y59gAf?=
 =?iso-8859-1?Q?ruSPSRZqHat9MeLOn0AdfwW+/wlx5Pn9neeLMV7gzt7YaGcs5bcUF9q4t5?=
 =?iso-8859-1?Q?pw70g89QH636f1LAcN1m1RuhySsWz93z5CYu5OAUkfaK+Ks8LslAbTi7BA?=
 =?iso-8859-1?Q?4GBF7PAAEQ/pF2ExP6RLbndI3yBTVNPKNYVBYcywht+QtmSJFK90tVvO8d?=
 =?iso-8859-1?Q?HmhxoUPtKXJh4LDAc8lxZS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?H4l9e1s/U3/bQsGVSpPjUXA0kVi7u5N0kanCeuOw0w8JCrxta45kaaqykR?=
 =?iso-8859-1?Q?hirriQe6+eWVQGj1yn8kf1dRmwOOBmTwFfIHwWga595NVtd+mMHvKlNOg1?=
 =?iso-8859-1?Q?Eby0zNc8Opje8/3wJT1RUfLi//18niKMe7bcMOdaVpbAyBYWSVoPAvDlAM?=
 =?iso-8859-1?Q?yTG/atAVq1Ymx5gGXkmANmERq+N+e6pdUMUxvBKUUykL7DCAe43rtriCy/?=
 =?iso-8859-1?Q?XjVnQH0ES79KrP95QlSPFuXNhh1uwRrb8nNkyaT4J30co4YDzrt01jWO5z?=
 =?iso-8859-1?Q?ukESFRqaaSoY8fKqY6c6qq4zBBebjOG/19jyMNdhbDNkWf7s2vRdoDw17g?=
 =?iso-8859-1?Q?McMc0YUuhgaK1boMGW+vJ9cHOWiqOML2DTOXS1bbbn14UY77vcAXHtGwae?=
 =?iso-8859-1?Q?Ok4J78tsVHb5LyLhIxxesbfUpnMuLHaBrpyT3qZ2/BvNtcjDJi0GPtMI39?=
 =?iso-8859-1?Q?2Ewqg1BbTtF6TS8d9GNT0iShYVb5meFJDMU+trZPVd/Vj74h8+Zk0yj1i1?=
 =?iso-8859-1?Q?7Sa9nw5EEallM3DiOitZKXDFKdkMXhg7OCxVKz+12BCsveACmsuGGcaUa9?=
 =?iso-8859-1?Q?tIqCs5e0sdW4Zy4wVzcBsaKiZDOh8xTbgAF4smxnWXm///qFwe2pISDSX3?=
 =?iso-8859-1?Q?3+TajB5fIqOApphEjtNbsRP9MRX3s+9XgKDd21rva1RlpNA7T7ClnjWIeO?=
 =?iso-8859-1?Q?dWv+t3ZA7950O3ueeVb9RIsF87D9jKwzjMn2U8+jnPRXJ7D548x4ZD8/cS?=
 =?iso-8859-1?Q?Me+6soUovHEWoPOPZ3eEQvINm0HFL17rSIlaG5g+gaNUvE5NJDnXt8zzmc?=
 =?iso-8859-1?Q?W/MrUbOCZODTdhQMhZvosmn1fjvu/fg6rQ2t8fdlwd0VGvDT8DRtJBdNVy?=
 =?iso-8859-1?Q?yN5887aEj8LXSyt+f3PVX5GVvobtKWvdU1AmQYF9BjMFhNTmxqqY+wSnja?=
 =?iso-8859-1?Q?mtHd9us3YWrBDgkirM3nixcT0VckSyLOstYDiFW3qr9zdef742e0XnKHzd?=
 =?iso-8859-1?Q?EjH+dl6YhYYZ3dKUv7sXM55BoaNc9XE2KdTdQhndFSIamAlxjP2TJNwkpZ?=
 =?iso-8859-1?Q?ffEFhNorWJb0ObRQhOXRGVkB/HosoNcnqCgBnqxaUL4aq0eBLVtRmOwDbZ?=
 =?iso-8859-1?Q?OSchzVK3eF+MvfQP3FLjMn3OpYtilkrnxCIqanVsEtatT5XMedyS7q5Dvp?=
 =?iso-8859-1?Q?6dEFK1n0/df5Fkt+FP8LWZOe8pVx32mThhl6Ny0wz3yZVrhDd+FTakjGiI?=
 =?iso-8859-1?Q?LJ5xioIuSgEOSTN3Llftb6wRekr6sUV7/MUfIu8wmQR4/n1JPeBaGt9Gjm?=
 =?iso-8859-1?Q?1j75wOg/BzeQ5xWPITFndMU+gceTFgyVlShMzDJUl9ne30dLuYyIPaQpec?=
 =?iso-8859-1?Q?33jS1r/5zHGVQe2ED3wtJS+k1E60neFH8+45qkM6tVgTlUWwz4AgZrhCl/?=
 =?iso-8859-1?Q?BctZSacsU5Ar2N+ymSAnskur8mFOL1Kx0HHnc3TVUpdOPNdMQSBLHKO03C?=
 =?iso-8859-1?Q?NeFCCj/Z9xbsgOM3BmwIBJ7rKevJd/WHBk29VCFlGmQramaVryvxf6BNpv?=
 =?iso-8859-1?Q?9n9E9JDZNkCxQcO+kfXuM9PjMs+c1aRsopFo8GwpbKNQgi7lbA1MdZGre3?=
 =?iso-8859-1?Q?7AiBrr1RvYseZAKa9YpATIrpr4hnlF850oPGonraF00GaVlH4TKR1KE7p0?=
 =?iso-8859-1?Q?I/ct5iig1Sv+GuWNMYQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc42c02-1b9c-4411-aa86-08dd524ece42
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 08:07:37.0635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aHMnMAse38LLLNiFgXiimYUmzhZDO3GdpBoRS2beBQjXhrL0i7HBIdWuuBfypVdYnW+Deb0d7q8WVHV0PfjqObjtkHQ8uopi3IPVBpNdzmqoOjpjzuDrms7txejfeFez
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8162
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

The region returned by this operation will be used as the input region
for ATS.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 include/hw/pci/pci.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 4002bbeebd..644551550b 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -391,6 +391,22 @@ typedef struct PCIIOMMUOps {
      * @devfn: device and function number
      */
     AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int dev=
fn);
+    /**
+     * @get_memory_region_pasid: get the iommu memory region for a given
+     * device and pasid
+     *
+     * @bus: the #PCIBus being accessed.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number
+     *
+     * @pasid: the pasid associated with the requested memory region
+     */
+    IOMMUMemoryRegion * (*get_memory_region_pasid)(PCIBus *bus,
+                                                   void *opaque,
+                                                   int devfn,
+                                                   uint32_t pasid);
     /**
      * @set_iommu_device: attach a HostIOMMUDevice to a vIOMMU
      *
--=20
2.48.1

