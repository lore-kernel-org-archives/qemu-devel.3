Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8756FE78D44
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 08:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpMqU-0005Fk-Sz; Mon, 09 Feb 2026 03:42:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vpMqS-0005DO-Rh
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 03:42:13 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vpMqN-0000TH-AG
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 03:42:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1770626527; x=1802162527;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=MZgf10iR/zD1GSGMvWId0HXd6Rj6pO0Xk+wfAFtZ+xg=;
 b=CvY7BGgJ9h98rBBBY89hli78Rey7K2J5Nen3QfA3wN6NzmLDKIishkrN
 NmQ5xOMZuph+MkZMXsjg7BSmxXjcJZQaY/eOyo1mva34zJhOSjNNFIIgo
 2/aiLA5jnA1jQpRWUPxFChm65HnI2ihaxd5ZU27XqPPEfxOxP9D0CM6JB
 57Xxb92oPv3S38hlKxRJmKiDeC64OxGTAYqLOXHd7RlB3C4xGOvK1i2oE
 sPRSJmO3WV8eJwyBbtzVeU9pVjP3t0z8gD+Zxgr8ECjR9IjYy4S6pXGxQ
 pmdTA21Kn1d2LE2XE0tPB2QkESJLUiboOZG1frFU/6+fUzNQo4ovnz4TO A==;
X-CSE-ConnectionGUID: dxAAz8PlTEGfRZ+MYaNZNQ==
X-CSE-MsgGUID: uYSMb9zTRYe6zvE1nfIWmg==
X-IronPort-AV: E=Sophos;i="6.21,281,1763420400"; d="scan'208,217";a="48428695"
X-MGA-submission: =?us-ascii?q?MDE3c+isg4+CpoYXLXlBsGDY2+b4yndNC++thY?=
 =?us-ascii?q?O5lGaho/JImfJuBngeiFfhIynVy0hWbNyCofqwGVUY75AxGzt/b240PZ?=
 =?us-ascii?q?5gR40Qt8gVZdsELT5t0+Y1XT0vbGsjLK/uWSlS4T2D0dPn2sbIjy0RIA?=
 =?us-ascii?q?DinPe4mvvCq7YPC1MwEHwFhg=3D=3D?=
Received: from mail-francecentralazon11013065.outbound.protection.outlook.com
 (HELO PA4PR04CU001.outbound.protection.outlook.com) ([40.107.162.65])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 09 Feb 2026 09:41:59 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMXKtKR89NgR3p0V7qiVpiJT8jVDlyLIaS2lu4/dnXx7UVLh4fcP9IBqPcooOrKL+f0UH34tT6WC0UAwpkmNDLylHfNVQwEKTfyuHZNRnxjmQx2pIDvsS9WutWAs8CsgY7I6VuMq6Ti8NM4Ec3RTIpzf2ea8wkg/cYclAsFNljSWwxOumkt9VfbqOS0CqwE38aLQPCIv0KrPj/udIxpExjXRNsrurtK7MMbvkGhCO8v+xWRN9IAei5LM1aL+ndggTaW32zaTPeCPdL3vvn3qeyo7+rY05IC4WAWiUBJnHYtdcqArwxnQuvz/iw28881CLVb9tJifV/N4r/HuDHcPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekqc8NFzBnc6BFzLRX3bv3c/vBIX+lMD2iG2SmwlIcE=;
 b=yMdpa1Lammokhcw6BdIxOKnORrAXcL5obe8YMTnheRmA7wBBtkX02F1hibZAGttNhBYA2jnKXIDUsIycu57UBEsMMTfL1WRDc3W3JbwQ2ZQHJQLfPJfWE8xrL4rPZGD5OFHDFO4M4Ysqg/vHCk2hwkTFgtA0g20G7OU0CQInDJpeB95wgQFI4EEP/oZ7mJuP4dgRdERwdxF08ZdOWgF14BCYRrePT8HfhpFxqpYcUNQ9QX1aJh0zoR7YJ+Uw5rIETuKvgb8Ax5ShDt6ArbVTytaTvrhys+jVeVfBW3091d+6AYilNW7i0QaGdfGkWntztC9e8pLQ6vlyG1UZHBnYvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekqc8NFzBnc6BFzLRX3bv3c/vBIX+lMD2iG2SmwlIcE=;
 b=Z7F9iNIhPeQdccFkRd/cGbRw2dHzkzfopYBxU74zYucvUjHSJJHv/dIM3gNtitI4qZIcwKcZqTxJmvJgfL3KLfnJ2v17IkECQi08tpqppW7SAoXofEnKFCIMTRJ1y7kPo37JyxHENHq7TDkbqlTj9L3xyoCWrjpEiU+VPYzM+caU1To4tseqSiyt6HiuQvFSMB0zRflPlIQGunBJxa955P1bamxjLj9C5ZMgJW2zSwitYx9mgJ7EJwufFQk7N1JodNHqaEK+vXLYLHRryXjfIAe+gUE1p2kSN9mPX7ISS4pPy+6OSizUgiEmqOAQ8jq7cwbEQzR41zlybA3j//MQcA==
Received: from PA4PR07MB7613.eurprd07.prod.outlook.com (2603:10a6:102:c0::19)
 by DU4PR07MB12086.eurprd07.prod.outlook.com (2603:10a6:10:62f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 9 Feb
 2026 08:41:57 +0000
Received: from PA4PR07MB7613.eurprd07.prod.outlook.com
 ([fe80::5df5:6816:4d46:4648]) by PA4PR07MB7613.eurprd07.prod.outlook.com
 ([fe80::5df5:6816:4d46:4648%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 08:41:57 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>
Subject: Re: [PATCH] intel_iommu: Do not report recoverable faults to host
Thread-Topic: [PATCH] intel_iommu: Do not report recoverable faults to host
Thread-Index: AQHcmNSOJ7Sj/3HqskaUgGs/GeGqALV5+3uAgAARrKg=
Date: Mon, 9 Feb 2026 08:41:57 +0000
Message-ID: <PA4PR07MB7613E77A57763CA798D92AC28665A@PA4PR07MB7613.eurprd07.prod.outlook.com>
References: <20260208082252.288-1-clement.mathieu--drif@eviden.com>
 <IA3PR11MB9136AACA4BFA95DBE6B92B599265A@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB9136AACA4BFA95DBE6B92B599265A@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Enabled=True;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SiteId=7d1c7785-2d8a-437d-b842-1ed5d8fbe00a;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SetDate=2026-02-09T08:41:37.384Z;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Name=Eviden
 For Internal Use - All
 Employees; MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_ContentBits=1;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB7613:EE_|DU4PR07MB12086:EE_
x-ms-office365-filtering-correlation-id: a40fb16d-a9b7-4fa0-3163-08de67b715c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|8096899003|7053199007;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?1dyEZyZ1RprXhOrSRusWm60Y7aNzfvXVdv5tuh3Dvm/pS8rXZwDcpHpBLG?=
 =?iso-8859-1?Q?xYCMoN/9wrXjBNcMgVqlveozBjVwsp5pMaSDqu88f9pSbuGYU1A2uw8KHR?=
 =?iso-8859-1?Q?HD1Es/konh36EQwaum2h/kCr/xgyrqnzgJQPg4dkuUDMRC1OLO/AaBUn1Y?=
 =?iso-8859-1?Q?boMLdmvBaMFnsQc6nf3eIJGdmHUuOYDNOJjnrBRw/sp2HO3LNxxJ/DYa1o?=
 =?iso-8859-1?Q?nwPf2bsBKFp0mZvdmknDhL/XOqsRTKH/o2fppNS/Uv3jIZ3g+N2VpOiDcD?=
 =?iso-8859-1?Q?eRTNn3d+QmNz3KnEfbV3qLcv6Zl+j8ABosQ2tqIN3YbUOLPEZ3ZF5ovdBn?=
 =?iso-8859-1?Q?pnH7+18VRKmattfBvBpUVlYUQWif9Nq094piDS0VfYT1RG829M6k+6gdip?=
 =?iso-8859-1?Q?7/lPpKSP70DrNpdA7u2/tgwkukn5xJhGSZZGEKcLEqC3TloPIFUx9bOvdk?=
 =?iso-8859-1?Q?5T4+BCq8I43H3EAZkbJ7Z5LFk7J1hKIG4lMONQoWAm1M+R4HhSScKQrNxY?=
 =?iso-8859-1?Q?047I/9RfZV9URpwJI+eRz54GSSd4jNxa+na3nqrRFuWS+9Wsh94gbSTxDg?=
 =?iso-8859-1?Q?wUK1G5gMOzNbVP1IOIXCmjJYZPwgro8YAZcEfuXh8HKG6BYrVa3+ReciUP?=
 =?iso-8859-1?Q?UEpO1/Ma1bWtl6pm7AnysYpmEwnpJ3i8wFE+JnMF/MimbrXFUU3IUbDXBN?=
 =?iso-8859-1?Q?NIc6HQfYOXdkLW3dIRY4Nz6nMNEC70X3249d++L99NluPf6z0CWn/VQARJ?=
 =?iso-8859-1?Q?XXHhEHwgM96t48LAJEi0/kQTl/LFGNV9aE2EP9xbhxdmkXWhovfOmtrW3i?=
 =?iso-8859-1?Q?H1nP/mBlxk4YJ1DPvc0RDiY2w7IBAKLoZVU+Kx/HT/syTf1ey0gh6EA23Z?=
 =?iso-8859-1?Q?muUXgFPZQcQvYkgQ9yWDVSRVAgCSXHIMDhCuSdHIXondpcSguaDV/5N2nw?=
 =?iso-8859-1?Q?5eDoOURrQIe/I391eCifKMwfOusYa6JGqEGTebqrRJnfWxPYHuqcpWgqp8?=
 =?iso-8859-1?Q?lx2Xu1vBKHVFaLaVf5r8y73Nv5ebZvkMobcw68WPiDf0SbgTyF9DENBxLN?=
 =?iso-8859-1?Q?IivoZ5UOgFAZ6zhu+3G6aCOzduDRFbhwmpxq37rs424B43M1Gsfhe+pmGR?=
 =?iso-8859-1?Q?weEqNhubeKvG93cfhS2iI4zFLHgWmlq3RQkqNQXVlu7q9zKzV+x/x/Z/oS?=
 =?iso-8859-1?Q?AOik3NEdTsTSJbAPfLB4FpnnTGZBnZDAsHzJbfz/LlL9I5Lw6GDLbhOhvF?=
 =?iso-8859-1?Q?dtGjXYn24OZUfy3LZBu2sBxE+IGI6UCTHmkWa4XLasX/2a+i4DfZzNoJ1U?=
 =?iso-8859-1?Q?cg6YkEo9Zo7wvopUteuIqoy/YfuXMSb27sygwlV+Ie+YdmfrwHoz6cy482?=
 =?iso-8859-1?Q?87K/uFHF3I/5AfcNn6IH3phqLvjvkI/Y3IyrakeyNmeeZj5EwxZSeb9kru?=
 =?iso-8859-1?Q?E7+YkuSdkA+gWIiI7t/GDeDMgkQ5nLmNoQCThZKHxPs0AGjivB/TqX+x+z?=
 =?iso-8859-1?Q?pwsBJ1ZjJvduAVd1L9BW4WBn5llyTY+cJCCwhVagVl0xuerFz9YHYCA5Zz?=
 =?iso-8859-1?Q?tk3EcXVOVe3BHWJOgVr7ynjcmWuRtZNR4B1d2Jycp/0KNfcBugmhZVX/VO?=
 =?iso-8859-1?Q?lFm89clEBOaKm9EeBghnidIGzg4/SG6vxsL1I7hPd+oYQKPebZ3MpMZ32G?=
 =?iso-8859-1?Q?j9+FkP5dHnUeyrTyPw0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR07MB7613.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/jZQjab07TaW6GV1X87FiJQtWVCmj0z444W2Wl3+31Rd0VQp3qYjAlep9y?=
 =?iso-8859-1?Q?FawaNNAbHL1S17vPJaVo0se2G/1dz8g3ouBT3guefFfSQ4OWAH91pcb8fx?=
 =?iso-8859-1?Q?OKJF+5jjWjIA+biovf3V2q5kAPa4kwXCOjEZO8YuaEkUtpvBfZjT6MZjIB?=
 =?iso-8859-1?Q?VQ3nM5i6ga9QjP/cD1DQ59QU7qzz7GPfeJh2l/Fu2YYVq+P9hRSQ8vEuhd?=
 =?iso-8859-1?Q?Apy+I5MqN7wgkE2of1BqhkxSo15FH5RESjp7iO78rM7DE7uZBEeBggEceH?=
 =?iso-8859-1?Q?qhLbq4ItGLE3rYqvdvZXzxMsXZOFfBx26hPA+N+3d2RgSl71dec2GG38S1?=
 =?iso-8859-1?Q?yu+/1CYS+0lPMjrDQJjKnc3dpFde/bjFhfmV2xa6h+V1o0YBoghDLUSk5i?=
 =?iso-8859-1?Q?gUjbJ6x4rJqwUs6xG/1t+NazEzQnw4GbpBOUfJdf73T7rKoXXcYp+yG3T4?=
 =?iso-8859-1?Q?Cp7dJI6PmUKkzE6WG2zx2oULvPvGv3WRP8MeISTFjJ73NfGYp0+wLlR23M?=
 =?iso-8859-1?Q?K6X7AHkNy5QctZzqtMTnnce7lhrwJB05y6iwLatVQ21CC9iihKb14l2pmT?=
 =?iso-8859-1?Q?0U2DLDOsKsH9+P3+33Yv6f5u9YJdVDylCn8krwv7DLH2N0fVQC/Wcvecm8?=
 =?iso-8859-1?Q?zP4nCNw2vfD+Ron77U2TOOuybxIznwMadU1wr0QVeLdXwHjOBYZTlQFf13?=
 =?iso-8859-1?Q?JgyOvHr2i5yGJDkH81toUqmGBXjxppoHQ13jvd09F/8aZ4ZiN3Z+Bi1miO?=
 =?iso-8859-1?Q?hzO9ayEQFq3hq5vbYI1SXx2fBL4M2CsCbbT8V7ypQwURD5tY2InzetF05H?=
 =?iso-8859-1?Q?01JePHUtWar/9DgSAv8WPYSv2xeQ3OmgBVZnW4QuJ1cryVN5Ahev/QTHtf?=
 =?iso-8859-1?Q?LK8BJcr7WddnUZekkIFzLG/ZEwkZH8dkympI5y/v59wQbSOm/WJqQhWto+?=
 =?iso-8859-1?Q?G3CfrpTuWuMIbcR4qRJM5x3XSiUa8zJ0c4gSsP9lqFRCosHV8J21uT9d8T?=
 =?iso-8859-1?Q?R5ZFCMdFsfRQuX5tY4cXwTR+0OdSxnFZsC6fDPGJOAPnDD3rNLfKCzm1Y7?=
 =?iso-8859-1?Q?duZE/pGxQeFx9XxBbz2UwQT0RnHoGgyTOBDRnD3R75myjexjaeceRFi1Yr?=
 =?iso-8859-1?Q?doVFxeHWOUJI560NroJc4N7mIj9lg9GXPEws4uJ0RO75IrRM8nXROrUrjo?=
 =?iso-8859-1?Q?9+Y9uffjQ9E7LRpqhH5tc6V+msjeT5CSJ7Lv5UvSVXbhe0SpFh2aylxB4L?=
 =?iso-8859-1?Q?NYD28Q6gzx6VHusyv5XZyLsS0Uesu6t1442hGGpJw8I+IKpnPnkPPuEKf7?=
 =?iso-8859-1?Q?4y8H6x97xDHCtXmBBoauIc5pdcUR26ocVJDt98x6jtMHgje6QhhCZPgxk7?=
 =?iso-8859-1?Q?8V8ycEkC6nQwwdNAo9BFwr9o3+m4IP+6jo6RZbg/l4SUK0NtvFTu9Zpl+M?=
 =?iso-8859-1?Q?L/Jj0R99jron+cOA4+F2AAIT7hYJD5PwsjuGYJ3wAfy5EO11kyTDVjwV7v?=
 =?iso-8859-1?Q?oWSnjdb+suoIU/Dd7yE2m/zVuyWoaW2lZ2rmcvdXoRZopMgPQiWg45fbBr?=
 =?iso-8859-1?Q?CwELdTYVdszBplxM7uUGKhNb6oc4RWNXdODsisYCOUibFQNsXHZCsmW5lp?=
 =?iso-8859-1?Q?ttsEauQCp/9fZMAPWlheBTBpsOu2N1uSmp3T00t4yGM3o08hACzgTaNmoN?=
 =?iso-8859-1?Q?+kfIJU2P24rgKwmDVhT6V4mfrcQ8HCUqgbI9qClWr4yhkT/xnG8TJgn7IY?=
 =?iso-8859-1?Q?8N3/Y8xMdQM51TVcFz8qk0Y4N/GgpOq4LG95CFUvm5BiqRQ9x3Xv3FFu9w?=
 =?iso-8859-1?Q?UkxVFEEyOvckbsbh/i81e0GvqHJQiJM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PA4PR07MB7613E77A57763CA798D92AC28665APA4PR07MB7613eurp_"
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB7613.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a40fb16d-a9b7-4fa0-3163-08de67b715c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 08:41:57.4587 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dsgirNsbbNhvgHi3dgH01nDZMtDQ3zODXto+Q0ascpwuZVXqhgB/hbLaWZbjGRfhFg49wXGm0itiaFRrL30UtIewmNZJeHmkQlqzrwxz0kbaEAx3Pob37DIAHlrOWPqe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB12086
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_PA4PR07MB7613E77A57763CA798D92AC28665APA4PR07MB7613eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Zhenzhon,

Yes, you can have a look at table 26 of VT-d 4.1 or table 30 of VT-d 5.1.

These faults are descibed as follows:

"When remapping hardware detects a recoverable fault on a translation-reque=
st from Device-TLB, it is
not reported to software as a fault. Instead, remapping hardware sends a su=
ccessful translation
completion with limited or no permission/privileges"

In the aforementioned tables, such erros contain mentions like "Success wit=
h R=3DW=3DU=3DS=3D0" or "Success with effective permission".

cmd

________________________________
From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
Sent: 09 February 2026 08:34
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>; qemu-devel@no=
ngnu.org <qemu-devel@nongnu.org>
Cc: pbonzini@redhat.com <pbonzini@redhat.com>; peterx@redhat.com <peterx@re=
dhat.com>; david@redhat.com <david@redhat.com>; mst@redhat.com <mst@redhat.=
com>; jasowang@redhat.com <jasowang@redhat.com>; Tian, Kevin <kevin.tian@in=
tel.com>; Liu, Yi L <yi.l.liu@intel.com>; joao.m.martins@oracle.com <joao.m=
.martins@oracle.com>
Subject: RE: [PATCH] intel_iommu: Do not report recoverable faults to host

Caution: External email. Do not open attachments or click links, unless thi=
s email comes from a known sender and you know the content is safe.


Hi Clement,

>-----Original Message-----
>From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
>Subject: [PATCH] intel_iommu: Do not report recoverable faults to host
>
>Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
>---
> hw/i386/intel_iommu.c | 26 ++++++++++++++++++++++++--
> 1 file changed, 24 insertions(+), 2 deletions(-)
>
>diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>index dd00079a40..0735b24ac0 100644
>--- a/hw/i386/intel_iommu.c
>+++ b/hw/i386/intel_iommu.c
>@@ -1857,6 +1857,21 @@ static const bool vtd_qualified_faults[] =3D {
>     [VTD_FR_MAX] =3D false,
> };
>
>+static const bool vtd_recoverable_faults[] =3D {
>+    [VTD_FR_WRITE] =3D true,
>+    [VTD_FR_READ] =3D true,
>+    [VTD_FR_PASID_DIR_ENTRY_P] =3D true,
>+    [VTD_FR_PASID_ENTRY_P] =3D true,
>+    [VTD_FR_FS_PAGING_ENTRY_INV] =3D true,
>+    [VTD_FR_FS_PAGING_ENTRY_P] =3D true,
>+    [VTD_FR_FS_PAGING_ENTRY_RSVD] =3D true,
>+    [VTD_FR_PASID_ENTRY_FSPTPTR_INV] =3D true,
>+    [VTD_FR_FS_NON_CANONICAL] =3D true,
>+    [VTD_FR_FS_PAGING_ENTRY_US] =3D true,
>+    [VTD_FR_SM_WRITE] =3D true,

Which fault reason is classified as recoverable fault?
Is this documented somewhere?

Thanks
Zhenzhong

>+    [VTD_FR_MAX] =3D false,
>+};
>+
> /* To see if a fault condition is "qualified", which is reported to softw=
are
>  * only if the FPD field in the context-entry used to process the faultin=
g
>  * request is 0.
>@@ -1866,6 +1881,11 @@ static inline bool
>vtd_is_qualified_fault(VTDFaultReason fault)
>     return vtd_qualified_faults[fault];
> }
>
>+static inline bool vtd_is_recoverable_fault(VTDFaultReason fault, int iom=
mu_idx)
>+{
>+    return iommu_idx =3D=3D VTD_IDX_ATS && vtd_recoverable_faults[fault];
>+}
>+
> static inline bool vtd_is_interrupt_addr(hwaddr addr)
> {
>     return VTD_INTERRUPT_ADDR_FIRST <=3D addr && addr <=3D
>VTD_INTERRUPT_ADDR_LAST;
>@@ -2237,8 +2257,10 @@ static bool
>vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>     }
>
>     if (ret_fr) {
>-        vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
>-                         addr, is_write, pasid !=3D PCI_NO_PASID, pasid);
>+        if (!vtd_is_recoverable_fault(-ret_fr, iommu_idx)) {
>+            vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
>+                            addr, is_write, pasid !=3D PCI_NO_PASID, pasi=
d);
>+        }
>         goto error;
>     }
>
>--
>2.53.0


--_000_PA4PR07MB7613E77A57763CA798D92AC28665APA4PR07MB7613eurp_
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
Hi Zhenzhon,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Yes, you can have a look at table 26 of VT-d 4.1 or table 30 of VT-d 5.1.</=
div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
These faults are descibed as follows:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&quot;When remapping hardware detects a recoverable fault on a translation-=
request from Device-TLB, it is</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
not reported to software as a fault. Instead, remapping hardware sends a su=
ccessful translation</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
completion with limited or no permission/privileges&quot;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
In the aforementioned tables, such erros contain mentions like &quot;Succes=
s with R=3DW=3DU=3DS=3D0&quot; or &quot;Success with effective permission&q=
uot;.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
cmd</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Duan, Zhenzhong &lt;zhenzhong.duan@intel.com&gt;<br>
<b>Sent:</b>&nbsp;09 February 2026 08:34<br>
<b>To:</b>&nbsp;CLEMENT MATHIEU--DRIF &lt;clement.mathieu--drif@eviden.com&=
gt;; qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Cc:</b>&nbsp;pbonzini@redhat.com &lt;pbonzini@redhat.com&gt;; peterx@red=
hat.com &lt;peterx@redhat.com&gt;; david@redhat.com &lt;david@redhat.com&gt=
;; mst@redhat.com &lt;mst@redhat.com&gt;; jasowang@redhat.com &lt;jasowang@=
redhat.com&gt;; Tian, Kevin &lt;kevin.tian@intel.com&gt;; Liu, Yi L &lt;yi.=
l.liu@intel.com&gt;;
 joao.m.martins@oracle.com &lt;joao.m.martins@oracle.com&gt;<br>
<b>Subject:</b>&nbsp;RE: [PATCH] intel_iommu: Do not report recoverable fau=
lts to host</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">Caution: External email. Do not open attach=
ments or click links, unless this email comes from a known sender and you k=
now the content is safe.<br>
<br>
<br>
Hi Clement,<br>
<br>
&gt;-----Original Message-----<br>
&gt;From: Clement Mathieu--Drif &lt;clement.mathieu--drif@eviden.com&gt;<br=
>
&gt;Subject: [PATCH] intel_iommu: Do not report recoverable faults to host<=
br>
&gt;<br>
&gt;Signed-off-by: Clement Mathieu--Drif &lt;clement.mathieu--drif@eviden.c=
om&gt;<br>
&gt;---<br>
&gt; hw/i386/intel_iommu.c | 26 ++++++++++++++++++++++++--<br>
&gt; 1 file changed, 24 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt;diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c<br>
&gt;index dd00079a40..0735b24ac0 100644<br>
&gt;--- a/hw/i386/intel_iommu.c<br>
&gt;+++ b/hw/i386/intel_iommu.c<br>
&gt;@@ -1857,6 +1857,21 @@ static const bool vtd_qualified_faults[] =3D {<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; [VTD_FR_MAX] =3D false,<br>
&gt; };<br>
&gt;<br>
&gt;+static const bool vtd_recoverable_faults[] =3D {<br>
&gt;+&nbsp;&nbsp;&nbsp; [VTD_FR_WRITE] =3D true,<br>
&gt;+&nbsp;&nbsp;&nbsp; [VTD_FR_READ] =3D true,<br>
&gt;+&nbsp;&nbsp;&nbsp; [VTD_FR_PASID_DIR_ENTRY_P] =3D true,<br>
&gt;+&nbsp;&nbsp;&nbsp; [VTD_FR_PASID_ENTRY_P] =3D true,<br>
&gt;+&nbsp;&nbsp;&nbsp; [VTD_FR_FS_PAGING_ENTRY_INV] =3D true,<br>
&gt;+&nbsp;&nbsp;&nbsp; [VTD_FR_FS_PAGING_ENTRY_P] =3D true,<br>
&gt;+&nbsp;&nbsp;&nbsp; [VTD_FR_FS_PAGING_ENTRY_RSVD] =3D true,<br>
&gt;+&nbsp;&nbsp;&nbsp; [VTD_FR_PASID_ENTRY_FSPTPTR_INV] =3D true,<br>
&gt;+&nbsp;&nbsp;&nbsp; [VTD_FR_FS_NON_CANONICAL] =3D true,<br>
&gt;+&nbsp;&nbsp;&nbsp; [VTD_FR_FS_PAGING_ENTRY_US] =3D true,<br>
&gt;+&nbsp;&nbsp;&nbsp; [VTD_FR_SM_WRITE] =3D true,<br>
<br>
Which fault reason is classified as recoverable fault?<br>
Is this documented somewhere?<br>
<br>
Thanks<br>
Zhenzhong<br>
<br>
&gt;+&nbsp;&nbsp;&nbsp; [VTD_FR_MAX] =3D false,<br>
&gt;+};<br>
&gt;+<br>
&gt; /* To see if a fault condition is &quot;qualified&quot;, which is repo=
rted to software<br>
&gt;&nbsp; * only if the FPD field in the context-entry used to process the=
 faulting<br>
&gt;&nbsp; * request is 0.<br>
&gt;@@ -1866,6 +1881,11 @@ static inline bool<br>
&gt;vtd_is_qualified_fault(VTDFaultReason fault)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; return vtd_qualified_faults[fault];<br>
&gt; }<br>
&gt;<br>
&gt;+static inline bool vtd_is_recoverable_fault(VTDFaultReason fault, int =
iommu_idx)<br>
&gt;+{<br>
&gt;+&nbsp;&nbsp;&nbsp; return iommu_idx =3D=3D VTD_IDX_ATS &amp;&amp; vtd_=
recoverable_faults[fault];<br>
&gt;+}<br>
&gt;+<br>
&gt; static inline bool vtd_is_interrupt_addr(hwaddr addr)<br>
&gt; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; return VTD_INTERRUPT_ADDR_FIRST &lt;=3D addr &=
amp;&amp; addr &lt;=3D<br>
&gt;VTD_INTERRUPT_ADDR_LAST;<br>
&gt;@@ -2237,8 +2257,10 @@ static bool<br>
&gt;vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; if (ret_fr) {<br>
&gt;-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vtd_report_fault(s, -ret_fr=
, is_fpd_set, source_id,<br>
&gt;-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
addr, is_write, pasid !=3D PCI_NO_PASID, pasid);<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vtd_is_recoverable_fau=
lt(-ret_fr, iommu_idx)) {<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vtd=
_report_fault(s, -ret_fr, is_fpd_set, source_id,<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; addr, is_write, pasid !=3D PCI_NO_PASID, pasid);<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;--<br>
&gt;2.53.0<br>
<br>
</div>
</body>
</html>

--_000_PA4PR07MB7613E77A57763CA798D92AC28665APA4PR07MB7613eurp_--

