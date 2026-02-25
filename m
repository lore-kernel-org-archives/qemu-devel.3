Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F561E9B25A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 06:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv86S-0005WA-TF; Wed, 25 Feb 2026 01:10:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vv86Q-0005Sn-5Y; Wed, 25 Feb 2026 01:10:30 -0500
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vv86L-0002U6-R1; Wed, 25 Feb 2026 01:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1771999826; x=1803535826;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=Oeu/zpEgWIRhFqSFYGI20bCr379nRpmxFOzHFnuHfAU=;
 b=VG4QmY8pcrnOEBLOZ89+nhZRsEQUkjQjo4RPeTNZbpmgfD7xHkRY6rC7
 GZ+8QzTqv8YV9wFttrYDsWl9a0q4DzzrHwXHNUZjbiSYW6NtIntPO3TTU
 OTUlQ1UI2g1ZPgNBARUZWHsS0jfU48jJyvkTnlwdvWFxIo5UXm9S7LFI7
 GNha/Unbpi4U0JeZ4Zivr0WbC+2PeZBpTp6MIpW6sgyomt8t2EKnfStrh
 5zFB+yy8hz+VDz57yFxTeOOibm+aoPdJMRUcKHfreWfHI4cCnyj4spBIx
 WsSmbcWQ8HdCaiNsFOr3z7BbrwqbqkEmV54To11t1P7iUOiBXSdaWFr6Y A==;
X-CSE-ConnectionGUID: j2uojjScRf6WZ2iHMkxM5A==
X-CSE-MsgGUID: wV5I23BARJeEPMO5tZBKlQ==
X-IronPort-AV: E=Sophos;i="6.21,310,1763420400"; d="scan'208,217";a="46650655"
X-MGA-submission: =?us-ascii?q?MDEWWzqf7jpZxexBiRwTNjby01V3YYxlOrOVMX?=
 =?us-ascii?q?O5LxxC3uQHjI41ibcMVoUx43uAY95+iCzXx+6qO6XOOuyyOMH90Dx3gd?=
 =?us-ascii?q?F7Z3Bjvmegrc2PfAsv4e1Ioaog+ittIQUGaWJX7YtzR7TcudAu1BfgxE?=
 =?us-ascii?q?G/MdDyx67+H90jrkiolu4Diw=3D=3D?=
Received: from mail-northeuropeazon11011035.outbound.protection.outlook.com
 (HELO DU2PR03CU002.outbound.protection.outlook.com) ([52.101.65.35])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 25 Feb 2026 07:10:15 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJfUWliRlorZxUcbhD5bZogFplJiPIEk5OClYc0lmET19avqrHDJ0pMmIU3S/mL9AcSXVZ22d2wx1aKdf3Oz99KE7IjoMacpGylts13b5D6anFDTbrYofnNKjLmJMfI/gfdBzBbfs3fPby/5MdHNzh6a7WxuuE9Gk9X1Rtu95p7ctztG2NdRdfkU8ayCbUy6oxSvPoa9qjspaiy95/JASazH8JkGURP+hioI5jvFDr1Smaibsti1a2Li2GTSq0Ayz2xFrsXzafrzwfsVRzisFweD/Y/JgZ5Uln9FyA9/pIbhJOWJZt+k28W4NM61TUA8i3B/4Ez7cEwD2a24dS1b9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFLL4eljmgwSwzgpEWR7LK6YwwZkL0Wt9UoXsNvk+m0=;
 b=I+fa5F4S8W1f9UHozy9CUd1hLsMjYUzRFL+5QPoaXb6S2ZJf20sfT3gh56KMb3ttl3oLxQYeIcoBcvm6B+7fTeN3mapWANt4uC4nUl7ABuYWYvJEbdRwlD5s86MN6qug7L/Xtxnh4FPwJ46dneoHNwLCoxBG0YWiHl/0lyb0TMtHuIZIoX39PSN0QnfCp3AuJFyIkxXyfxc2+rwyp1zP7k1Jw8ogKIg2YwwaSKqo3ce1zX8Rxcn1rG+OHI0cJHNxiyKzi//4bEk8n1dqhMP9W9I1CLtV1b++mK2l99edpMSKVdZOzaqKZJLSbkGZvTD9APCgTQcT49CBqth7y26Z2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFLL4eljmgwSwzgpEWR7LK6YwwZkL0Wt9UoXsNvk+m0=;
 b=KwlhotRKWJTO1Bt1sNm/C9mYNBVeAt0uAX+KNR3TAocVMokYp7Vr33fvlz0a4NJzl6XECrAIqh2U95RMv0EO3mQqTVie//9V623bAB66DoeHMCcCjutKBrYKNQ45D0zFvwFg5Sf4Gvh0N8AqZPaMhuTiy8KkG4FCe0wYLgEWTfL4i1/pJPGycycYELp6JH608ituy8CCz2falRT6CoYM05qGEYyVTvUpGYlVEUuy19EkoJZHER+Kg6RUXPQ6eiCsfEnezns2X2+s2CQzIA5V3lhqPzo+FVTwx3fyAmN/++xHgOqv9MZRf1z96omGjhXo3dXivXbY8MzivyWAxNuNlA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM9PR07MB7059.eurprd07.prod.outlook.com (2603:10a6:20b:2ca::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 06:10:13 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 06:10:13 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Shameer Kolothum <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Jason Wang <jasowang@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>
Subject: Re: [PATCH 2/3] hw/i386/intel_iommu: Avoid including CONFIG_DEVICES
 in hw/ header
Thread-Topic: [PATCH 2/3] hw/i386/intel_iommu: Avoid including CONFIG_DEVICES
 in hw/ header
Thread-Index: AQHcpgVC6y+niP4v0ki1KV69m31C9bWS7oSE
Date: Wed, 25 Feb 2026 06:10:13 +0000
Message-ID: <AM8PR07MB76026EB248E7756C79F4C9FC8675A@AM8PR07MB7602.eurprd07.prod.outlook.com>
References: <20260225031658.32095-1-philmd@linaro.org>
 <20260225031658.32095-3-philmd@linaro.org>
In-Reply-To: <20260225031658.32095-3-philmd@linaro.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Enabled=True;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SiteId=7d1c7785-2d8a-437d-b842-1ed5d8fbe00a;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SetDate=2026-02-25T06:09:49.458Z;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Name=Eviden
 For Internal Use - All
 Employees; MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_ContentBits=1;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM9PR07MB7059:EE_
x-ms-office365-filtering-correlation-id: b01e1866-0760-4d80-9760-08de743489f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007|38070700021|8096899003;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?vEYlI7HO6azU+LRMQlDylwnfqGtPefCSpmgAIiJvn2Txnqd6SDUihLa1Ct?=
 =?iso-8859-1?Q?1LKl6/67y+Yx4tQPTdmCSZ6sOlirWCd0t4qmpYWLYmpfQGx+1wi6GnKM6p?=
 =?iso-8859-1?Q?1etY7RsRNHjC7c1Mmjjnel7mN0MvPnQ0p/kkwveTNJI+3vd3+1rQyxwZQ7?=
 =?iso-8859-1?Q?nnfuUtjHpR7fwigYuwBs+fwIw6QmUZKqJCEkYhs6J+rrhNe+6fodbhYjAk?=
 =?iso-8859-1?Q?hdTOyvohUoErYVVkr0Y2Nj0NacQ+m2Kjx+wAgDYVdwuD0GpVXZ8CT3l6EB?=
 =?iso-8859-1?Q?vfYhIZ+4mETGKaXdcCn8BKg5FtEMCwjWfwHFR69P5Kp72K5gjxMwl6o93w?=
 =?iso-8859-1?Q?1TldxmQHrzvInOpGyjRk/0MqqKQxVFnB+n8+6wwqPRwCXvRMsU/rq3VEn3?=
 =?iso-8859-1?Q?TrDnmmp8qzQ63DpIohg87YNqzXWJRFoQcw1pfpVByu3FkadYXwIrRM8ZHM?=
 =?iso-8859-1?Q?zvE77yGe9YlP5oCE+smj/HdAzzVUvcAVk53hJiZZBh4mjUOiI3Xd0Sn3Fu?=
 =?iso-8859-1?Q?RJ3+Pnost8o1og5A/V4BJVlmlJ8Vq8EpSDS61wL/zWqVTCZgsqoFu5Fqkr?=
 =?iso-8859-1?Q?NvH1hDxAvS/EEZtufQwqPkAG/umNoNhs8ZTioJo5FKfZZes5egQDcZU5Jv?=
 =?iso-8859-1?Q?cC+8Dw0QhZptpXk30ropZ8m0T7H39wmGOczE0WiV64suj8sk73i0teIEXZ?=
 =?iso-8859-1?Q?H4RKDx5MhI35dp/6Sabzi1+iaUho9Mmye0gXBwP+7OaZGdvCQ4NgUf6jMQ?=
 =?iso-8859-1?Q?dbGTdFYB06WKloko5ps3YDqSRiMRLtwq2y8Ybv9WPtEsbxwuB6RXbHdPfO?=
 =?iso-8859-1?Q?H+mlXp+tAHAlLOXRpDLv/JZb12WG/iklb9jcmskC4N7XnpcFVtYkWodL2K?=
 =?iso-8859-1?Q?/cHSxblsmsHFZcqMLSU+xGm0jc+oBHsTLTJ7WlrgdIywdAZ4YTEB9nE+LE?=
 =?iso-8859-1?Q?o6VURU9nzgBfw+aLTSCA07bPHJhWZQhaoibUHLfZRCu/wktJzjXIC6nXDi?=
 =?iso-8859-1?Q?B2P0cyL9Tu6/QMACfOvwTdRhNTvNY6dVTfcQiA6eEe04POOoFbQkeYoUo0?=
 =?iso-8859-1?Q?qfIXSETVSjCEipbOCUQmgCmr6Rk2VftRlkAuF0v16LmxWjCE3Z5YZ2grXJ?=
 =?iso-8859-1?Q?KG7uakpJf4r3hVWt7s+infXBtnw5+74bZroI5p6+iIDXC1gxfXIBPgYxRl?=
 =?iso-8859-1?Q?hKvmrqoXay2XgqAT7vXGiVjmlk14VyVAgqeLJ+L0FqSs71pqpQl1Kkw+We?=
 =?iso-8859-1?Q?mwCphC9WSGlSgwqiAp65hnSWL4ia8LS0fb0LN5UODpGEp7B0eTjQZ27csI?=
 =?iso-8859-1?Q?3g3gPSDkqnq7apVIw7MlkEgFyUCbol19noBepNE0L+9DGBOvGpNWF3v9lx?=
 =?iso-8859-1?Q?S6gOkcRzeqahAJoZ7x3UEIVjcCo8ecL9CabOhmtynAcIW/97VVvxwVG7af?=
 =?iso-8859-1?Q?nb5N6EeHvK0cZIM1rRb43I2Ibjdn8BZJ3ai4UrTCvxCd1KpLtnKj1sFEOD?=
 =?iso-8859-1?Q?uRHDw2Z7Tl4BnV5+ndcJsOBl3hofE4sjDmheTR0fakzxTYgSZRf+0DSpOT?=
 =?iso-8859-1?Q?BBD0veBRAfny5wORtlPcbc2FTX7MA5z2j+FnXRvAMb19ygUz3Jp680Vrsu?=
 =?iso-8859-1?Q?zTdPHj6ZWGNR7525sxhk3jKLwDE6S2yFJpVYoqd5NB9cuFC4Q36XnysZbV?=
 =?iso-8859-1?Q?ntZ++ndzbbR8lmlQU5o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?e2qO6Hl9xzdOmXs3q5gkL4XhmpoOL/lkLx7YK13tdpAnL1LwqzPHYk27d8?=
 =?iso-8859-1?Q?q6N+44B/OskGs7T/hm6ozKyedPY7AN1xN7x4QEGY1lWI6x28M/lYr7c5CB?=
 =?iso-8859-1?Q?hV4zf7clcD7VAtBoQ/jTWAg5N/sWqbsdHlvMNE5GafC7OJAHDZIyCSTqSm?=
 =?iso-8859-1?Q?F0GrK5VIxC+lTeEEWzAr4tqi739gGWFH6IhUNvxqb3lgJQZxjXJSkDlOwQ?=
 =?iso-8859-1?Q?oNTH7u/VQ0MAqQZRooeNzVawv4Hke91XAcfRpbLXIe6uNvapFgUkPkOXbR?=
 =?iso-8859-1?Q?SuvyE4QxahKkTRnD7OOVTa4ryB8GqjRt3B/QZ9g1rz3C/AXOg+n7Vp3Qvh?=
 =?iso-8859-1?Q?dz7wZPxJF2lPgeq3R6HCHW9Xt0ZsvN2sgTnK5tD4ej0VO0Cq9iVDt5M85r?=
 =?iso-8859-1?Q?vqZMuTH705M57OKtUbCpDVXduRHNY0KN0hO/X/M01uGP1AvpuZ4MBN6RSu?=
 =?iso-8859-1?Q?PTvc6o1BrjdNpN5AHT9x/JPKe0k8UH2PZOtBhILF5hoItogxpzZr3VS3QL?=
 =?iso-8859-1?Q?Zmn5esCUbQg8wTJzez1aWLUsGiTqwR1jLecLidMkBZwj4siTozFMG7Ta1Z?=
 =?iso-8859-1?Q?Mss65ZTrRH3nTWH1EcruGi6dkk7EXuie4c14pFlQLbvJxGdmRNBi4HOhnf?=
 =?iso-8859-1?Q?3H+ga8T2PE2UcaiGUnd/VtW0fe7DVaowc/pJTKHuYm1OYoR4H9XmdAOJCJ?=
 =?iso-8859-1?Q?WqFBV2LhE2gK3w1SeqNBrfeXWzhxLj/eidd4ohS7b1tvYjwfzpXyOhJvdD?=
 =?iso-8859-1?Q?zp5m5f/4WZ8bdqBClKH+bjbFKS/+UjDPKDutnYcbdgEg5gcaEHDVjcmRIf?=
 =?iso-8859-1?Q?VXHFzTyvu+8NZxrtS4Up+CZfw3gQmGHHmTBdW7MefDBPnhLHXz0VLHJUgP?=
 =?iso-8859-1?Q?DsgaEihfg7C4uEfhpoldsKQ0zY/IqQXQ3tzE3ujB/ca4luPfhERYnFjRDh?=
 =?iso-8859-1?Q?hMKvchXeDy0Lh2Fr+hC7f/fxUJe1q1tvmqiqIGa41oVN/U0/aapyrhmI+h?=
 =?iso-8859-1?Q?wipDTDW/nOc8jTGqZA2jDK63iQCwEYT7v1O9x6ZzAWq26dId7i1Z91gHyB?=
 =?iso-8859-1?Q?Pgqx1rH2+xQ4ZF0DoEOH6oeDd2DmZRl6MFhr8QRt2K375/4leLxLmLLSZ8?=
 =?iso-8859-1?Q?S0domD1oZsYsxTEKZQmlmxulzZjQ7uBGTT8A6wWKx62pRAhh4kDXM6958M?=
 =?iso-8859-1?Q?N3UU/Pboj53DMHQ/3PM744ZUXiXZ4CBADTQCysoJFx8OqjUsfDjLOurtf6?=
 =?iso-8859-1?Q?apoRTRsaaXecQpEuDSfh9m6bIITHrxhvkTP7QAOxYLY6cXcfSoETKcI7sg?=
 =?iso-8859-1?Q?ua2SqDO9oYb6mhN0zTabWubipf7mIagFifx31nkWH0Ondzr7J3+R06tQn9?=
 =?iso-8859-1?Q?J+cEsASGyorOb8FZvPy88lqhuGbmz0QII3RKQiln/xt+tuzXDMOHym1kUn?=
 =?iso-8859-1?Q?i/PXR5sRpxfsyyPEDmRu/89hJcncpcYyV6wf95Ckol/ROtnrcfEOjJUMmo?=
 =?iso-8859-1?Q?jC3gV97nIs2A5jinL9+BJ3zq9HJHWO9R2Us5XwbpTjRX4mGuaQjKAVz3QW?=
 =?iso-8859-1?Q?Q7PZM7skZIjt1j1i5FWXKpv0JC7gxuxVrvhgfEDUljYCCrlQqMuqaTvtja?=
 =?iso-8859-1?Q?BcGzJ2pbsM1zbUJoXzXDP17Y2o3h5W+aemFXoBx34bW/4pSKq1HrF8Qpjt?=
 =?iso-8859-1?Q?60w1Rjy8KVLxPOKWK9XXKQMRe6W6M355pxZTeUmsrho65lcrKZCYhQQbPw?=
 =?iso-8859-1?Q?OB89QuBT0jubaW/XytHKic3+ywXw3PWNUn2/2lQsPXrCUXMq/Fr4RSUxOI?=
 =?iso-8859-1?Q?pO2mtuZGt/sjN+FgFSPruhNMPhKl0hk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_AM8PR07MB76026EB248E7756C79F4C9FC8675AAM8PR07MB7602eurp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bdDYAxLo0h/XXosNfMFGW7LkhQaLT6ZqHx+sxiUGEGgajrHmtWaEwABbMnBQWg/lAPGq75jfruq9GKQaFBqh1BKQB4o0Lvo/4KgUakJBQF+2qAS+SOeRZUXAfOWOz+QHwZu6Pe+dBmJdhNi8VoAmEigQqpCbphCBg6Shvzc45izLgklboPsCZZZbBCDN5K8/md51AQfuql1GaQ1MLa17NzReixkSt4FfDADmDh+34fyamPkiNfjd6Oz+fPW2/Ek3jJu2GZBgPj7AbLOodjxLJv80sTsHSkFqrnH17XhCZCaaCboWmVR4DJmEjqVVPjhxKfywSQK3AKzGPBQawGmLXA==
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01e1866-0760-4d80-9760-08de743489f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 06:10:13.4570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Qfq6DbFajQE+q/Eryj3hMZ/imU9lf2F+yKdQC+vuSL7exfswX0TprfMIgbaTZreN9FRPgtk0J3gI4yTvitlctkaAK4b2cH1FoaeHrZSnVUsM77b3Pg3p3+Ohd5CS71k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7059
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--_000_AM8PR07MB76026EB248E7756C79F4C9FC8675AAM8PR07MB7602eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Phil,

Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>

cmd

________________________________
From: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
Sent: 25 February 2026 04:16
To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>; Thomas Huth <thuth@redhat.com>; qe=
mu-s390x@nongnu.org <qemu-s390x@nongnu.org>; Pierrick Bouvier <pierrick.bou=
vier@linaro.org>; Shameer Kolothum <skolothumtho@nvidia.com>; qemu-arm@nong=
nu.org <qemu-arm@nongnu.org>; Philippe Mathieu-Daud=E9 <philmd@linaro.org>;=
 Richard Henderson <richard.henderson@linaro.org>; Eduardo Habkost <eduardo=
@habkost.net>; Michael S. Tsirkin <mst@redhat.com>; Marcel Apfelbaum <marce=
l.apfelbaum@gmail.com>; Jason Wang <jasowang@redhat.com>; Yi Liu <yi.l.liu@=
intel.com>; CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH 2/3] hw/i386/intel_iommu: Avoid including CONFIG_DEVICES in=
 hw/ header

Caution: External email. Do not open attachments or click links, unless thi=
s email comes from a known sender and you know the content is safe.


By inlinining the stubs we can avoid the use of target-specific
CONFIG_DEVICES include in a hw/ header, allowing to build the
source files including it as common objects.

Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
---
 hw/i386/intel_iommu_accel.h       | 35 ++---------------------------
 hw/i386/intel_iommu_accel-stubs.c | 37 +++++++++++++++++++++++++++++++
 hw/i386/meson.build               |  1 +
 3 files changed, 40 insertions(+), 33 deletions(-)
 create mode 100644 hw/i386/intel_iommu_accel-stubs.c

diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index e5f0b077b4b..d75d232c6d4 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -10,9 +10,9 @@

 #ifndef HW_I386_INTEL_IOMMU_ACCEL_H
 #define HW_I386_INTEL_IOMMU_ACCEL_H
-#include CONFIG_DEVICES

-#ifdef CONFIG_VTD_ACCEL
+#include "hw/i386/intel_iommu_internal.h"
+
 bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod=
,
                           Error **errp);
 VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as);
@@ -21,36 +21,5 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s=
, uint16_t domain_id,
                                       uint32_t pasid, hwaddr addr,
                                       uint64_t npages, bool ih);
 void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops);
-#else
-static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
-                                        VTDHostIOMMUDevice *vtd_hiod,
-                                        Error **errp)
-{
-    error_setg(errp, "host IOMMU cannot be checked!");
-    error_append_hint(errp, "CONFIG_VTD_ACCEL is not enabled");
-    return false;
-}

-static inline VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *a=
s)
-{
-    return NULL;
-}
-
-static inline bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as,
-                                             Error **errp)
-{
-    return true;
-}
-
-static inline void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s,
-                                                    uint16_t domain_id,
-                                                    uint32_t pasid, hwaddr=
 addr,
-                                                    uint64_t npages, bool =
ih)
-{
-}
-
-static inline void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
-{
-}
-#endif
 #endif
diff --git a/hw/i386/intel_iommu_accel-stubs.c b/hw/i386/intel_iommu_accel-=
stubs.c
new file mode 100644
index 00000000000..6015e0df2a1
--- /dev/null
+++ b/hw/i386/intel_iommu_accel-stubs.c
@@ -0,0 +1,37 @@
+/*
+ * Intel IOMMU acceleration with nested translation (stubs)
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/i386/intel_iommu_accel.h"
+
+bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod=
,
+                          Error **errp)
+{
+    error_setg(errp, "host IOMMU cannot be checked!");
+    error_append_hint(errp, "CONFIG_VTD_ACCEL is not enabled");
+    return false;
+}
+
+VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
+{
+    return NULL;
+}
+
+bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as, Error **errp)
+{
+    return true;
+}
+
+void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_=
id,
+                                      uint32_t pasid, hwaddr addr,
+                                      uint64_t npages, bool ih)
+{
+}
+
+void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
+{
+}
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 63ae57baa51..0f058761b66 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -22,6 +22,7 @@ i386_ss.add(when: 'CONFIG_VMMOUSE', if_true: files('vmmou=
se.c'))
 i386_ss.add(when: 'CONFIG_VMPORT', if_true: files('vmport.c'))
 i386_ss.add(when: 'CONFIG_VTD', if_true: files('intel_iommu.c'))
 i386_ss.add(when: 'CONFIG_VTD_ACCEL', if_true: files('intel_iommu_accel.c'=
))
+stub_ss.add(files('intel_iommu_accel-stubs.c'))
 i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
                                 if_false: files('sgx-stub.c'))

--
2.52.0


--_000_AM8PR07MB76026EB248E7756C79F4C9FC8675AAM8PR07MB7602eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi Phil,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-by: Clement Mathieu--Drif &lt;clement.mathieu--drif@eviden.com&gt;=
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
cmd</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Philippe Mathieu-Daud=E9 &lt;philmd@linaro.org&gt;<br>
<b>Sent:</b>&nbsp;25 February 2026 04:16<br>
<b>To:</b>&nbsp;qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Cc:</b>&nbsp;Paolo Bonzini &lt;pbonzini@redhat.com&gt;; Thomas Huth &lt;=
thuth@redhat.com&gt;; qemu-s390x@nongnu.org &lt;qemu-s390x@nongnu.org&gt;; =
Pierrick Bouvier &lt;pierrick.bouvier@linaro.org&gt;; Shameer Kolothum &lt;=
skolothumtho@nvidia.com&gt;; qemu-arm@nongnu.org &lt;qemu-arm@nongnu.org&gt=
;;
 Philippe Mathieu-Daud=E9 &lt;philmd@linaro.org&gt;; Richard Henderson &lt;=
richard.henderson@linaro.org&gt;; Eduardo Habkost &lt;eduardo@habkost.net&g=
t;; Michael S. Tsirkin &lt;mst@redhat.com&gt;; Marcel Apfelbaum &lt;marcel.=
apfelbaum@gmail.com&gt;; Jason Wang &lt;jasowang@redhat.com&gt;; Yi Liu
 &lt;yi.l.liu@intel.com&gt;; CLEMENT MATHIEU--DRIF &lt;clement.mathieu--dri=
f@eviden.com&gt;<br>
<b>Subject:</b>&nbsp;[PATCH 2/3] hw/i386/intel_iommu: Avoid including CONFI=
G_DEVICES in hw/ header</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">Caution: External email. Do not open attach=
ments or click links, unless this email comes from a known sender and you k=
now the content is safe.<br>
<br>
<br>
By inlinining the stubs we can avoid the use of target-specific<br>
CONFIG_DEVICES include in a hw/ header, allowing to build the<br>
source files including it as common objects.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=E9 &lt;philmd@linaro.org&gt;<br>
---<br>
&nbsp;hw/i386/intel_iommu_accel.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 35 =
++---------------------------<br>
&nbsp;hw/i386/intel_iommu_accel-stubs.c | 37 ++++++++++++++++++++++++++++++=
+<br>
&nbsp;hw/i386/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<br>
&nbsp;3 files changed, 40 insertions(+), 33 deletions(-)<br>
&nbsp;create mode 100644 hw/i386/intel_iommu_accel-stubs.c<br>
<br>
diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h<br>
index e5f0b077b4b..d75d232c6d4 100644<br>
--- a/hw/i386/intel_iommu_accel.h<br>
+++ b/hw/i386/intel_iommu_accel.h<br>
@@ -10,9 +10,9 @@<br>
<br>
&nbsp;#ifndef HW_I386_INTEL_IOMMU_ACCEL_H<br>
&nbsp;#define HW_I386_INTEL_IOMMU_ACCEL_H<br>
-#include CONFIG_DEVICES<br>
<br>
-#ifdef CONFIG_VTD_ACCEL<br>
+#include &quot;hw/i386/intel_iommu_internal.h&quot;<br>
+<br>
&nbsp;bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd=
_hiod,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; Error **errp);<br>
&nbsp;VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as);<br>
@@ -21,36 +21,5 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s=
, uint16_t domain_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t pasid, hwaddr addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t npages, bool ih);<br>
&nbsp;void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops);<br>
-#else<br>
-static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; VTDHostIOMMUDevice *vtd_hiod,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; Error **errp)<br>
-{<br>
-&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;host IOMMU cannot be checked!&qu=
ot;);<br>
-&nbsp;&nbsp;&nbsp; error_append_hint(errp, &quot;CONFIG_VTD_ACCEL is not e=
nabled&quot;);<br>
-&nbsp;&nbsp;&nbsp; return false;<br>
-}<br>
<br>
-static inline VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *a=
s)<br>
-{<br>
-&nbsp;&nbsp;&nbsp; return NULL;<br>
-}<br>
-<br>
-static inline bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Error **errp)<br>
-{<br>
-&nbsp;&nbsp;&nbsp; return true;<br>
-}<br>
-<br>
-static inline void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; uint16_t domain_id,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; uint32_t pasid, hwaddr addr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; uint64_t npages, bool ih)<br>
-{<br>
-}<br>
-<br>
-static inline void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)<br>
-{<br>
-}<br>
-#endif<br>
&nbsp;#endif<br>
diff --git a/hw/i386/intel_iommu_accel-stubs.c b/hw/i386/intel_iommu_accel-=
stubs.c<br>
new file mode 100644<br>
index 00000000000..6015e0df2a1<br>
--- /dev/null<br>
+++ b/hw/i386/intel_iommu_accel-stubs.c<br>
@@ -0,0 +1,37 @@<br>
+/*<br>
+ * Intel IOMMU acceleration with nested translation (stubs)<br>
+ *<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;hw/i386/intel_iommu_accel.h&quot;<br>
+<br>
+bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; Error **errp)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;host IOMMU cannot be checked!&qu=
ot;);<br>
+&nbsp;&nbsp;&nbsp; error_append_hint(errp, &quot;CONFIG_VTD_ACCEL is not e=
nabled&quot;);<br>
+&nbsp;&nbsp;&nbsp; return false;<br>
+}<br>
+<br>
+VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; return NULL;<br>
+}<br>
+<br>
+bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as, Error **errp)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; return true;<br>
+}<br>
+<br>
+void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_=
id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t pasid, hwaddr addr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int64_t npages, bool ih)<br>
+{<br>
+}<br>
+<br>
+void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)<br>
+{<br>
+}<br>
diff --git a/hw/i386/meson.build b/hw/i386/meson.build<br>
index 63ae57baa51..0f058761b66 100644<br>
--- a/hw/i386/meson.build<br>
+++ b/hw/i386/meson.build<br>
@@ -22,6 +22,7 @@ i386_ss.add(when: 'CONFIG_VMMOUSE', if_true: files('vmmou=
se.c'))<br>
&nbsp;i386_ss.add(when: 'CONFIG_VMPORT', if_true: files('vmport.c'))<br>
&nbsp;i386_ss.add(when: 'CONFIG_VTD', if_true: files('intel_iommu.c'))<br>
&nbsp;i386_ss.add(when: 'CONFIG_VTD_ACCEL', if_true: files('intel_iommu_acc=
el.c'))<br>
+stub_ss.add(files('intel_iommu_accel-stubs.c'))<br>
&nbsp;i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if_false: files('sgx-stub.c'))<b=
r>
<br>
--<br>
2.52.0<br>
<br>
</div>
</body>
</html>

--_000_AM8PR07MB76026EB248E7756C79F4C9FC8675AAM8PR07MB7602eurp_--

