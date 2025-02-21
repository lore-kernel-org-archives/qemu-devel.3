Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F340C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 08:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlO4Z-0004ZQ-CO; Fri, 21 Feb 2025 03:07:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4X-0004Yd-M7
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:45 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4W-0005kF-1d
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740125264; x=1771661264;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=V223gIkaKR30sNUdnEml5N4wlPmNOlUUGNe6oZ+paVM=;
 b=eZp4dZhk3U7XBUpLl071utHNiP6u0opaR9iT1DG9gjBq0l+wCJdMdnWC
 YitvyztbeJBBtAO8Ri/Mot7vNhfAbBR6I0a3alD3GAzN+uoRjnSK0StCd
 XbLRdO/mfkxXNUVYyGIhTVK+24UFei+A/D6BMQbZjvcV5W2zHpkEGFxD4
 dA8b+n+j+Pe7e+4vVQEaJfGfCD+al+bUd+2dTtKdsQAiqrpFsJT7QzECO
 cu0DXkOzBD3xCBvRGJOJbIunAy5Q6afvtnUQhfemrPZxciMuvSNQGD9km
 ZOzJ4LBbxNGkAvFN2mLyX1HwyZ1WqWpg4XkjQAaYOrlYi/LIbYm8oBQId A==;
X-CSE-ConnectionGUID: 0PYWi60MSsutqnSDXW4sYw==
X-CSE-MsgGUID: NkdQhLKMTJue42aLwtW2nA==
X-IronPort-AV: E=Sophos;i="6.13,304,1732575600"; d="scan'208";a="32836651"
X-MGA-submission: =?us-ascii?q?MDHOVzXGxDUSe7RDM8CN5yxuTbWF1BgHrO/EcW?=
 =?us-ascii?q?gwjWTVsDaswVipfBerERInkdMbnuwM0a4et7sE7azWu/wlHZhzdpPZng?=
 =?us-ascii?q?9iV+KO0Kk4jmlSjNcB6stMsFy59DVLGlM3UDafwommc/BD6v3k8d305M?=
 =?us-ascii?q?leHOscLJvgvOqGD7Jf1Y53+Q=3D=3D?=
Received: from mail-vi1eur05lp2172.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.172])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 21 Feb 2025 09:07:41 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RknoAxTUKknUkJIXYRanzkzjPN2tA+WiJczJBkyX8FWM9h3CVfdRyOovOvr+VVmo4All4ewTKkeojlSDxZM6yBccIRX8tcZb2bGIU2pAvv/RyKpKBvfa6pLug9O51YbU4wIkPS1OmgmMyRMqCQJ1lXWG9gV5rZJc4VfIn1QKx4+39sDAxi3XiZEo9CW2+JiwS+KdjntIykMBqmCbWxDmNhmXi7T27yVlX0CPJ4zfS3eVhqIznsTBjasgBDpGlQFZcvV6gKKXG6FSbadCNhnZAeOnC1bwQD878dTVuF5SdCmVXNVNGJyDIf/Z2WYIhKRi9diMPZvS2KPXTravnRdtyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UxSyr3l4O0MfvKh7SI51WYPvr2HNFpIRSV5MiiWeWY=;
 b=Gk8GDhYB8B/eOBgkcGEIMCu8O3uQcValaigNfEzcKDAe7TNuit71ZnZ8dNiPvd6zPcOBP/8MdRsxm8VEHFpyllaOgmDj0cM1nYGAPynM1aXIoeazq+GN9e0hi54QbOate/YwSbUAXt0MojTT6w1Kdb39ff0w/vrK9r3EgRN+NdG4y2oQpVDyhvVSVx9fkPXJqP+Q36eMsDZA82fOgkujQpc4aj+0eI1nN33xj5V2DHfrL2ac++UM5NpALvQ1t+8WNoWYFfbz5s4mMNM/1yfP//K3G2FNjBxc/J8mvrPPQiKfEjrWBqcWS29nZtW4sB3DCWa8F8XpKpXM7tra7+Y0Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UxSyr3l4O0MfvKh7SI51WYPvr2HNFpIRSV5MiiWeWY=;
 b=m8y2fjwldsLgY6vhTnaMtVGMEeFbAms/TIrWM+naIGhGEGHwCP6M+ptkYG0PaP+YhXvQM7XrzKI5PVW3/4R3oNMEbzOQgymFEvsvKYLoHrHdJsnAuGnA+hAwxuADuUegAQiFCPqTtuA4dQWMiHY9mVQnWOpP8EEL35J/sOg8Y/268R949CEkbjA2k/BhRgqZzpGNyTYwtXKAS3K7dwFykVWkzRitb3BhFNy/eS0YcNwwGQOyTrGnzqDWt8kiO/SrvRSeybZhegLN7YOTYNlsFGjl+4UykWDU5l50oTH3c0cYmSBjaFNsHjJ91hcja5GxnEuyblkGRm+7NFqhjvP3vg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PR3PR07MB8162.eurprd07.prod.outlook.com (2603:10a6:102:175::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 08:07:39 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 08:07:39 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v3 11/19] memory: Store user data pointer in the IOMMU
 notifiers
Thread-Topic: [PATCH v3 11/19] memory: Store user data pointer in the IOMMU
 notifiers
Thread-Index: AQHbhDesMr1WaksI3ka62I38Wp6M0A==
Date: Fri, 21 Feb 2025 08:07:38 +0000
Message-ID: <20250221080331.186285-12-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 74763b64-5195-45b8-2316-08dd524ecf23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?VbjkcH3bYfbDsjyUXSM/WnJbUwpCKTsTmHG7yifSSQUhmtOxgEwOAaLkxi?=
 =?iso-8859-1?Q?3NYTyCkHIkEF56qce43xLU3AG6dBvJOMYYC5p0Mh8pl3eqWeR/hmSp3ojZ?=
 =?iso-8859-1?Q?ZfnI5DcJluJnGLM0togEqO/ixgMlPZ8pJEbc8NA3HGis63QxUUZwBGfucW?=
 =?iso-8859-1?Q?5IfLmTXC8wLPG2/Ngz2OHPJAGuJVvhrPz5wM9ZfCVj77pVWnbIflJHIiwu?=
 =?iso-8859-1?Q?bG1y46fnNDY2fMOd1xhp7qMouyWO4+HGFMO7wkBflAbo2RPP8JMoxkI26T?=
 =?iso-8859-1?Q?PJAJNrYXd2D9A8PVQwtwigMrl7PqpU03pOIP10K5FDvCSaS/6fg/Vkui8j?=
 =?iso-8859-1?Q?iGfi8VkIZ9T/MCxDg6jUi1Gpcb16NqNB14wX61BR3JeT7WC98Xto5JA+ht?=
 =?iso-8859-1?Q?zvlwR+qtdX4d2ypCqVY+txUjtBUMF6Yhemv8Yv91N9U7mVrsJXJyLTLSdj?=
 =?iso-8859-1?Q?o1PfNwLFw5dWhLgzbCQIu05gWFQPSL/QLkJZSXueF7sEz0dLEyW+jUl27C?=
 =?iso-8859-1?Q?++I+hNuxe9KvZQcadhD4iZBnA3HT+BNzQ0R6lNl0cqa+9E1sWMlet0prHb?=
 =?iso-8859-1?Q?6T1fJJTGe7IZ/IXYZdKJADfdHSpOW3lGaBSuJYcAVbuJdQNaxAb+pr/aBX?=
 =?iso-8859-1?Q?9RibQk3BrUtg7V4rs8jBJw0+dh1dp5aG7y6UEOZrLfx3EzBLdWeoj7JW3U?=
 =?iso-8859-1?Q?cef4foKljo6r0NW1me3sHkxmeqLST+Wd3vC2xKM3wD9Sn2L0CTfCyyZo77?=
 =?iso-8859-1?Q?V2QYkoFq3axpsKwM9HATHCHCQrX+KdGNQO+7LTc1v995yX3WrfinOSkQM9?=
 =?iso-8859-1?Q?XRwSDi4AnDzEga6wuWyKIXXCI2PAtwP698zZgdzdtKVSTPGCIdMdaSIrdP?=
 =?iso-8859-1?Q?HZwikAL+PCHjzin6QL0CkJEedbu2PRceqwJ38W+XzQNr6vwopW3b6iwMPp?=
 =?iso-8859-1?Q?dtBMdQsaKSPm59OVxfrppYKRNFSuYIadUsoYlpYdkDKbgzOYtSjpOFi8jF?=
 =?iso-8859-1?Q?KMwhQEd2BnnZ/xLQ9l9brt/VW9pVQ0nW7UF8YPacinu9pDkJo598rvz1RV?=
 =?iso-8859-1?Q?dKYXdNgvXJkv3rw1p9DkfLG1tVjd/9Kz6IeIcuNQhCee4D1uRKDKO9Sj1C?=
 =?iso-8859-1?Q?unMVZ4Hz0UdsPCtTm1ZqNtRwGtV7B7PRrkvxjAiDoA4JzojVGvaAk23gqr?=
 =?iso-8859-1?Q?r/G1TYjYtB0yDvY0fJ94aTMgl8i/Wl9zOfvPmaXfyV7ZqM63fUzDAut0eh?=
 =?iso-8859-1?Q?+vXvD1CTkkaBx5ZvUuS64ZE/usZ7SciiewgQ0zGV8UhuUu70A0N+Sw0k4W?=
 =?iso-8859-1?Q?7Wa09Ty+Ea8sz8rA4SaKGp2kxCecW70bbkD4D3HVn0qA22HFJMiUBit+N1?=
 =?iso-8859-1?Q?yT26W0PQyYp40wEP6491obUU93VDcLQoUZWnyiCkuijNHChrkDvjNlJYef?=
 =?iso-8859-1?Q?wY80S5nU3sr8xeKgkSHfz6qXnBZybv6OoTSbSDbGfwXwVM3QCWEi+wEfX4?=
 =?iso-8859-1?Q?2hVCMWx6eWlU39bWARzDFS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9ffT6nC/4wLN9c9Q4VPCpt9AdmhejR1Gtt5Y7KRoKmyj9HMCJD7JQCPBej?=
 =?iso-8859-1?Q?gSYCdwmqgAHFkCdTiwCddXmAMimMFDQNEuyBjXjUMGVsHWOksoVHcUik8R?=
 =?iso-8859-1?Q?W402OX26WVLmtc46zfc3glfkiqVkNz3qaMewWO7r7oayrN49spjW6JrdPt?=
 =?iso-8859-1?Q?7YFC+5f+WEcQMZ7JLBEx5P6KbHyhh+XxIOAUzPdtowYV+YtSXpRxHCCz4G?=
 =?iso-8859-1?Q?E4H2Qt1jgCqi3KGgTRJDMehNDjdO9QuTswGKD3Mbum9qdMINf661l4GpV1?=
 =?iso-8859-1?Q?ST3mXx5PjhDCm1zRwuZXRZ0z49ZDYR+DB9d0S+yVBWvxZAmqlI/Z02JMdW?=
 =?iso-8859-1?Q?iBJ53hh5oRWhZH5/mkQnLr4SIz2UoKLBy3I4MO4804E7J5/O+4sb7pClHg?=
 =?iso-8859-1?Q?2rAFsLYkZuJXu94NLckD+aeo/a5GV5qxw8EbuvOg4irzGkv3rfh7D7WMWg?=
 =?iso-8859-1?Q?ImaWQgTD0BCI368SDKsyttSE+5p16vDqgq28HVPKRX0WOcmgChkY6lX3H1?=
 =?iso-8859-1?Q?drQbld4f0LGLKGYEil9ALOysx1tmlRy+YmGbSV1NlRIvGuwFnF4yo+2nun?=
 =?iso-8859-1?Q?5vG43Fa5YQmedF+njFZ5RU6TVhpexMV5ksGJkftjiIXsZ9kGs6TUhnziaB?=
 =?iso-8859-1?Q?SMPmuRfXP5RHr4ifusSCLnYLTN4/LvWUXvWKrBle2K5BbHHZjTLCPvHUQ3?=
 =?iso-8859-1?Q?5/ZN/lMCD2zjgq90D9VzeO7t7rbbPLH1pgHsaGLrqfU2hctdNQ3plq6rYX?=
 =?iso-8859-1?Q?Bi6X+eogYHq8w1TQQDbjmgAmFvXiB2omFi37WKYkMRSxWCTsMkC04Qsi3C?=
 =?iso-8859-1?Q?sTqV3bXrLhQr9Rf4etcIt2DtdAwzl1EHBiuPdr59yKy2ubHwueQ0zVtakK?=
 =?iso-8859-1?Q?LAqfasjfHmrF1L7G6z0IYxf5YP9CQkZf8QHCQ3n7R2adQrbI7zBsj7QODQ?=
 =?iso-8859-1?Q?AKcdSGpIPkczNRmmr/N4m13l+ytCCCjvyEueK5YabJR4qFBbN2s45ryujK?=
 =?iso-8859-1?Q?BINaOcfGZ23HDPY0yma2H56ac7f6ZMePuzvRU/ly9wUemd9S03gTP/m0Mv?=
 =?iso-8859-1?Q?te+AxzBTZxP8fgM9qKdUVmnHVdSTFYjzoXPYXUt5IWfZRzN4j6wHD57XQz?=
 =?iso-8859-1?Q?D4Y7FLWu6/2Z+9vlstDgxOAc1ZKUpkEEDCXEKD3n0v/t1oPR87+EynsQj5?=
 =?iso-8859-1?Q?s843YmYm+wSPepjNySuu/3+rMGLpuoTt/FJ/fPvRR4lyuYJGqIV97l9F0k?=
 =?iso-8859-1?Q?CedUR40UHgto8mA6L1CnVR1F3TXrDyBlXP7llEXVjXp5j/Jj3tfvZoQywI?=
 =?iso-8859-1?Q?Gfyv5z4Pi/DhfapZdHJbFY//LB0LJuF9SwOSsfiTb/vAakc1wfUpy5xw9E?=
 =?iso-8859-1?Q?w6Arb/DHngFjmxkUba+DCuXOBATPJM2POvVNv1Li3RSfN36qGZg/m4kTsQ?=
 =?iso-8859-1?Q?j93UzZmaLT38UBJZTX9qk5e4ggBQgEmE+3nucy6f+xJ2wsmleIFpmlg3iQ?=
 =?iso-8859-1?Q?BBP5zXBVtB/CosrEH7jP82zxVCwNFqYjBfJoSCSzqm8f+EdESVXGtzK6Fc?=
 =?iso-8859-1?Q?hX+j4TolK1cPa4578lLJ/Zng1BiftzufWCyGygqOajP1cFJTIoYxiwWisM?=
 =?iso-8859-1?Q?S8EC392fKN/vJZma0mOZVHouLLuD7RgXTAnaoNxsj9o7S+1f6ceNUJ1Nuy?=
 =?iso-8859-1?Q?KPv2zKes02kD1BkcAEM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74763b64-5195-45b8-2316-08dd524ecf23
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 08:07:38.4654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Llfpxm0q9P/FGGEFo46yU1NmW2kSdWq6x5gl1PgrHcJimrgl08NjuMPzHxJUTWm6HsXSHF66OcWjdJoFWW9eNkcSXx920Eb/0AQkCUWZats/IZpY+7BdNnNsMRlAC4Qt
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

This will help developers of svm devices to track a state

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 include/exec/memory.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index eee625a9c6..4d240cad1c 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -204,6 +204,7 @@ struct IOMMUNotifier {
     hwaddr start;
     hwaddr end;
     int iommu_idx;
+    void *opaque;
     QLIST_ENTRY(IOMMUNotifier) node;
 };
 typedef struct IOMMUNotifier IOMMUNotifier;
--=20
2.48.1

