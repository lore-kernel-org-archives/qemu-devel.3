Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BFFC47BE2
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 11:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd5OR-0001Fb-Hp; Tue, 06 Jan 2026 06:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vd5O6-00010q-5r; Tue, 06 Jan 2026 06:38:12 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vd5O4-00049t-AR; Tue, 06 Jan 2026 06:38:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fo8Hk8zPDZyJhAp6ruF0RW4WiIdq8Q18zoch6JOa3yMZ4lwut/CB/ij+Oq4Qq3nHstnpDg2BTGDI4KoK4AkRfjBRfZ5wD91fx+qSkpUgmOSlPcMi2gKBErN01Qd8n24IHCNzPt2qDQMnZzaFuyatl421Pr8UPd+XxnNCNQyAvVrm3BrFgAkfuG8RoZzI+PJJe9ISCCFDuAadACO+GRyElZWSGg78PVaBi5PSbBetggzwsodVB/Esowj8/N1TQok+H2CEzSeq36VfeZnyQoIYjKD1dyuvevF/fY8TEcZMWdj51+fKnJ5hPSj7f1sPPTRQlTLJhPksvOHcNtvL86gv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqik6fEKh7FqWs0+W5t+LR+dyAOujTv+iWBaX95rusE=;
 b=aZCKsFWjsxJb1rji/WugXBgTbWyW1+6zXtZTQtJc1NDT2nFUpxdxR3vy1BwwMidXk9jmDmTgWyVyM6iNRUz12z2X8dxAmLGm126l5ssCf/M32SFvQlvgVwjOCRcVS/UOJSsebSZ8X+b1iWLfRDwDelaLCJDES09UPBjg3CnxbOBnGGUMqUoriCsCCudSz0VizuN0tfn6OEnLIe+FL0MFeve8GQstEMcBCRn6BLRlxLYFtLYmWMgpZYwwEQVKi3PWqzF+uOZP5fpOOrCQrIzetaTU43Jfr4iD02z8mDiSGacFDfSENT0jv0rpT9FWXaBCP7jP0ZGucgr1+pra5ShotQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqik6fEKh7FqWs0+W5t+LR+dyAOujTv+iWBaX95rusE=;
 b=aYK8/4wdm0vJwbKaouR5jOHEpx7jqnV4hBqkY4vBFGaHI0ptVuHh8WgxXzpHmLNlnze0ajdGd1qEfhiA2LwA0YyJlRnKsafEP5W7Lgz0+sBUoiUZjcR0Sv7Q/ukmi65tZ6PG47FqFkzYJZXEtOJIGjB/xdLmFacMsqEyj35boLFx/ducv47HTTNTm6VN9OujHm3/FLsr5qII/NvpavwY+g9SwbzLYZcUt22Ova0nnJL+RDEtzRwUqQzKJIHmppHDJORwFF+Q6MzImK3DXXfyPAfb2+z/bcyL96980iicnqnmxRkpGHi38VxBN17mFjFgWBeXRR6Qwt+g79TuIdQgcg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH7PR12MB6859.namprd12.prod.outlook.com (2603:10b6:510:1b5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 11:38:01 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 11:38:01 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "alex@shazbot.org" <alex@shazbot.org>
Subject: RE: [PATCH v6 32/33] vfio: Synthesize vPASID capability to VM
Thread-Topic: [PATCH v6 32/33] vfio: Synthesize vPASID capability to VM
Thread-Index: AQHcWiF4+M87KXwCtU+FhkmKmtDFGrUZLqSAgAAXyYCAKsLB0IABOFKAgAAFzNA=
Date: Tue, 6 Jan 2026 11:38:01 +0000
Message-ID: <CH3PR12MB75483839B76AB0C78803687FAB87A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-33-skolothumtho@nvidia.com>
 <7dc608a7-b36b-4250-befd-d26115b54e26@redhat.com>
 <483fa0e2-aeb5-43b7-a136-692bbd24d0ba@intel.com>
 <CH3PR12MB75489918DACE8B009A8F4F32AB86A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <4a1e1e8a-8480-4294-a176-b5e630b7d0c7@redhat.com>
In-Reply-To: <4a1e1e8a-8480-4294-a176-b5e630b7d0c7@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH7PR12MB6859:EE_
x-ms-office365-filtering-correlation-id: cbd98bfd-4937-400f-ae3c-08de4d180c52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?bjJkRWlnSS9mZjZVSzl4b3AzazBJSkFtSFVVMmJMajZaZFFVcytNR0h6bEk5?=
 =?utf-8?B?SndiVEhvR1hLZkRoTHRzK3AwK09sZUgzMzNzR3RYQSs3RUpEVjZQWTZ6Q0RR?=
 =?utf-8?B?eHVkS1FxcTgvbnZkeHhPSG5HVHRKT2hSUDFudUFUVXdvdjcwUTF6RFlpbG8w?=
 =?utf-8?B?NXJGNGIwS0lOWHNOeDljRDlvSG51Y3pJS0s0QXhDTU92NU9nN1Z4MXRlam1T?=
 =?utf-8?B?Vk1rUmlCUE9vaHovZnZDZitFRHQxazRiL1BsSHQzNHpqR2M1dEppNE81eDJn?=
 =?utf-8?B?MmpYL1BwQ3l2QlFkdkZBM1FDV0RmMVU2NDZIL0RmeGlTQTlvTEkyYU9mNU55?=
 =?utf-8?B?QVBTZktWeGJJNXJjM2k1dHRLeEZEcEdLUjZHR1RmZktmVVpxS21IUzdKSlFo?=
 =?utf-8?B?a1pZcVN6TU1mUGx4NUVCY0Q3WGhaaW0yYVJaT2szb2cyWlhFS01yY1JHek0r?=
 =?utf-8?B?VktEbWRTc3hYU3F5cmVSZjNQMWxLNGFkeU1md2VYY0h0RmcxYmxEdDZudDhL?=
 =?utf-8?B?aDAySzEyTitBZE9CMzBNbGNHanZWSjU5TEo0blVGbFYxQmdid0xZRHpoYm9D?=
 =?utf-8?B?RFdvMHZha2xnbTRyc3prMnpQeGk4QTRQSXNhZzZtWnN5OVhFbXlDaW8yREVh?=
 =?utf-8?B?ZlBKU3FvY3FBeER5RWhUVlpSdjVidG9VRFFFMmlGbUZSdnJpd0tSNFpsZFhM?=
 =?utf-8?B?UGh2Szkzb3k3OFNKUWdtR3FPMUlvczBqd2MzWDRHQmlQMmZOSnRhMUdSQ043?=
 =?utf-8?B?WVgyUFZWUGRJNTUzWlV5eGNZZjAwSUtoOE9uMlg0dDRQU1hZbDk5TEpmenhF?=
 =?utf-8?B?ZGhCdHpHS25FSEt6TG02SEVtWjJ3TWQ0V1RydGpmVUhaVXlURVBZU3NyV1Zj?=
 =?utf-8?B?Z25jRXpIb09kTUVxQ2IrdU5jUjhsRkNwMzhNMEZLekE2MUZzWnJjTEVpVXFw?=
 =?utf-8?B?TG8rcityZ213eW50eXJRaXFYT2NscTNQMnZYckJiMEJNL1AzcC9Wa1VLOW5v?=
 =?utf-8?B?cnUzcGExSlJoOUFjMk9nR0doUG93UHFHYnJZKzM1amZ4SSttZzdTdzZ5REor?=
 =?utf-8?B?R2lVQjFLVy9yc1Nsem5KT1dvY2djL1BlMTB4aGVuOXJ1R1lVLzNuOW9DNklE?=
 =?utf-8?B?cVU0R2t3T0tsUG1LbzI0V0YrTk9CVFF6Z1dZbzg3eHpMbHFKWkxJL1daa01p?=
 =?utf-8?B?UHRUZm9WOUh2alArRXJad1R2WFJWS0pMbHNuR3RYVDNkN3B0cGp1MEdsdEVX?=
 =?utf-8?B?anNrbDUrK2FEdGZkS01qc1lzUzRrTXFDcnBvUUxZWVl4cEZWUkdhQnVvNHFw?=
 =?utf-8?B?KzIxQ251TW1TaWI2VHp4UERaY29uZHVpeWwveFRja0RjaUV3RGhIZnh6UzQ5?=
 =?utf-8?B?MFJDeHVFSTk2enFJRjZJcnMrU201V3hWeld4S3lHdnQ0SUUxQkFQYjFzblRI?=
 =?utf-8?B?eGN3b3JYR2JOZ2F3MEFWWG1MRGJJdTJCTFY5aXoyZnlyMlYveDlrNEg2YmlU?=
 =?utf-8?B?UzZXYTNXWGxjaWtGeTZGVk5pUUVzbzdXS2s1UnovNnJxMGJ3bUJFNXpqRnE4?=
 =?utf-8?B?bGM1ZjVzNWN1YTdoY3NNM21YSlhyUThXQ2xLUGJmSnE1OFJIbmRpMGxoNmQr?=
 =?utf-8?B?UEZKcGpqSGdxYms0Um1CYUVRZ3lYRDZCZnVaZ0luVGZYV21kdFNyaXFoY2RL?=
 =?utf-8?B?cWlIVzF3NjhBaWhuRVpQSk1jcmRUYUtIL0c4bkpWWnlOd0JPb0I4NkkvL05S?=
 =?utf-8?B?SGZKb0tyMVBJc3J3YXlvRzNSUk1yS3JBQ1U1dHdJK3k0TFFyZzlqWXJLS3Js?=
 =?utf-8?B?bnQzTjdKR1VyUUhubjM5dWF5eHg3QnlvMWFZUW9ISnREOC9KUGo2ZzhvM0tj?=
 =?utf-8?B?OS9ERDJHeGp5VDVaZXNOY2dMZHNzVkp6Q2xiVnlnUkVMNXE5QUhCclZYdm55?=
 =?utf-8?B?YmpuL0dvQmxGc3JVeWdOenovOG9BZ1NNZVRPN20zaU5aZ2VDNm9FL3BZOHRH?=
 =?utf-8?B?YVpEanFCUVpoL0JtWEdTV2YzSm05dDlJdFE4ODZybHliMDd6VDd3TVdKMVAr?=
 =?utf-8?Q?NlLnps?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wkhkelkxbzlsb21ENkdZeSs1SlZUNnFOa1J0bSt4TVFoek1aZHRXRjBqT1ox?=
 =?utf-8?B?THdYSEl2ak5TejQwZCsydEEyRldIVFRMMU81WmJVb3N3QzNsYW5IY3hiY3By?=
 =?utf-8?B?aWhDaGErOTlHME1TSzdjTFAyY2VFUHNESGhvbHByaGo1RmttWnhtZE81K2NF?=
 =?utf-8?B?K3ltaDZvKzhWWjZvcVJBNEw2WEk2NmhLTFgvM1lYU3pBczFJR0RXYU12WVFY?=
 =?utf-8?B?WlFUMCt0TVBsYjRrSVRmM0pkSEJPMHpWb2xFYSsvTnI2dGl2UVRvNjJXUmN3?=
 =?utf-8?B?dVZqejhueWR0OXBQSUZxVzNVaDRVLzFlMVNWcUtxMWNSMU9uSlBhUzhRbDVG?=
 =?utf-8?B?c1g3d3dMVEl0YmFkMDBmZEp1dURjeXBDRlg4UHVxRFdyU1RkRHRDVTFQNUVX?=
 =?utf-8?B?dlV2cTBCMjZqc0FFclpKeDJaRWM3ZW1MQzZKQm9WSlFTeTNoNzU5MjBCNlpM?=
 =?utf-8?B?cjBFb3J0RVdLaituWWk2bmtwMk55T0pZd2JRMzhWTVBUZFFXNWt4MlRHVEtp?=
 =?utf-8?B?aW0vK1BQOW5vKzhZRlpQamFSRU1MU2ZCUkxJejJZanNsYjhPRDNHb0x0eXFL?=
 =?utf-8?B?Rm50aUpTOVZ5aTdUZmdlV2ZRVWx4emJWbjF3UmxoNVlsdCt4RXNEQi84Nmtv?=
 =?utf-8?B?aTRUSEVIbyt4SWZUVW9lUUxKL0ZNYkhaRHV2Mmp3bUtocnFrcmhLcTArTnJH?=
 =?utf-8?B?aXFTWUYxSDgybjhub0FNbkwwNU91bjJjRkhDZTJGN2lqeThOeUJBVGVhdlNS?=
 =?utf-8?B?cXF0TnMzU3NSdUxRUndDZnU2MHNqdzF0UkNGV0Rab0lQbUd4MWFaR2JpWU1a?=
 =?utf-8?B?ZXIzbWlQSG9WQjZpenRtVXhFb2YvYndNaFF2b1YraUprMW1kc0dkbEtzY0Zj?=
 =?utf-8?B?VXFMUFNPNENEODdTZkdlcjJiRm5hcC9EMnBlQkY5aktPVlVQOHF0QWVYYlpq?=
 =?utf-8?B?d1RqVEw5U1ZDSlI4WUUvQUkxVHBkcmgwSDNZZTcwZExLSjdLcHl3QkxvMFNU?=
 =?utf-8?B?NzkxemxaVlE2cDVTV0VJeXg5T0hXVmxocnlYSEZjS21RR3B5aUZwWDA1dUht?=
 =?utf-8?B?aG50UVpsZFJqelltNXNhRzZZSVY2TkZrUzh3YjE3eklnczVWUUUzb1NFNnRJ?=
 =?utf-8?B?d29mT2g5Y1lqV242dnpQOU9hb21FVlArdGRpczVyU3daYmllVmRRVXNQRWV0?=
 =?utf-8?B?c0l3dVNRVE9OdlJ6d1ZnZXU0R3VDWDBGTGcxTXVPWGxTMk1VOFJjL09jUUpE?=
 =?utf-8?B?Q25UbWNYamdZbGFtTmlqTnVHZENnTm1oNGdvdVJ4aktOVFZDNHFlT0JTYlEy?=
 =?utf-8?B?N2JBb2lpajZwNXgzMFZZVTF2Zy9ueGZSSlM5cnpsbWw5UHlUa3lGVUNieFJB?=
 =?utf-8?B?TEtGK1cvOUI0czB3UjZiU0IrS0puUGhVNjhSQm5NZm1JbnVkcmgvaXRRbHdW?=
 =?utf-8?B?SXNtZ2g4SDcwSVN2Tis3dU9GK2FQVWYveDV2ZU5KQnUva093eVp1aTJCQzg4?=
 =?utf-8?B?RGlLbnRTOUdHZDBRVkhXc0Y0NWkweFNmK2VVZ0RzdXkrd0dVNzNDUlJqVEpJ?=
 =?utf-8?B?NUxPTm1ZeGtCZTBjYmVKbG96enNyd3VvUXhVSlZlODl5cUc5akFYYTJnNk1v?=
 =?utf-8?B?Y1lCU2lMM2haUWpOeU1sQnMwRmNCMUVHUUZZWXpGQ25PbjJ5OGd0WVFmWVV5?=
 =?utf-8?B?WEs1S3loc1NsQlpmVTNYMTJFQ3FhM291ZkhyNlRrTjcySjBZcVk1V05tWDNT?=
 =?utf-8?B?a01Ld0puL29IWDg5MDFFcCs3emhhQ3lTeVdlR3pVUkpmNFhpUXVPZXlyVFVE?=
 =?utf-8?B?Qyt0Y1dPVmsrREpyb0VmeFdCZk5WcUdBWWNCQlZmelVpek90OHVFb05LeWtu?=
 =?utf-8?B?d3l6dkQ1WlRXVWl0UmxtLy9PVTVnWFcxdnh0a2grOCt1cEZ5TCtqMytxRGZx?=
 =?utf-8?B?ZzE0R2pQb2FxeG84K2FqcHFueThMN0tXNldTeFFKR241R21VUEgxc1UvdWxh?=
 =?utf-8?B?QWpvYXpVSU5MWWtQL0RxRElBSWpOSWFHSFc5Y2JvMHhzOFJZQjhaTXM2c2Jw?=
 =?utf-8?B?TCtuUWJ4Q3RLdllIRS9HK0x1L2tQd1NiY1ZnanNWcUlRU3ZacDJVZkVSQml2?=
 =?utf-8?B?VCtVOFpSaGNkNkxEN1hVSjVraHh2RzJyUml1eUx5VWx6UWhHVHJMYXNXWmlj?=
 =?utf-8?B?Mkl2ekxCajJCbHpTM3l5Qm92RnQzb3hMdmVGU1J3UzVtdkk1VGg3NFpqOWtP?=
 =?utf-8?B?a1dxUmZhNzd5NkI1THN5OGhMd3lSZWFiSmhpZ2IrUjc0L2MzMHJINlNZQnl0?=
 =?utf-8?B?VzdudlRLVCtTd0tYV1NKT2JGL2JJL3hTNVk3WkNJeTRCemhvMjg2Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd98bfd-4937-400f-ae3c-08de4d180c52
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 11:38:01.4080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: APdrNLCar1nsNJfeb+qoM2luwCKI1MarKlkZKO+LAmav9S+UqGHKUzsfWWfFQMmWi9MV+d2ndGcNsE8DXj2ovg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6859
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDA2IEphbnVhcnkgMjAyNiAxMDo1
NQ0KPiBUbzogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBZaSBM
aXUNCj4gPHlpLmwubGl1QGludGVsLmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2
ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBKYXNvbiBHdW50
aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgTmljb2xpbg0KPiBDaGVuIDxuaWNvbGluY0BudmlkaWEu
Y29tPjsgZGR1dGlsZUByZWRoYXQuY29tOyBiZXJyYW5nZUByZWRoYXQuY29tOw0KPiBOYXRoYW4g
Q2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPjsgTWF0dCBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsN
Cj4gc21vc3RhZmFAZ29vZ2xlLmNvbTsgd2FuZ3pob3UxQGhpc2lsaWNvbi5jb207DQo+IGppYW5n
a3Vua3VuQGh1YXdlaS5jb207IGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhhbmdm
ZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56aG9uZy5kdWFuQGludGVsLmNvbTsgS3Jpc2huYWthbnQg
SmFqdQ0KPiA8a2phanVAbnZpZGlhLmNvbT47IGFsZXhAc2hhemJvdC5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2NiAzMi8zM10gdmZpbzogU3ludGhlc2l6ZSB2UEFTSUQgY2FwYWJpbGl0eSB0
byBWTQ0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3Ig
YXR0YWNobWVudHMNCj4gDQo+IA0KPiBIaSBTaGFtZWVyLA0KWy4uLl0NCg0KPiA+Pj4gQmVzaWRl
cyB0aGUgZmFjdCB0aGUgb2Zmc2V0IGlzIGFyYml0cmFyaWx5IGNob3NlbiBzbyB0aGF0IHRoaXMg
aXMgdGhlDQo+ID4+PiBsYXN0IGNhcCBvZiB0aGUgdmNvbmZpZyBzcGFjZSwgdGhlIGNvZGUgbG9v
a3MgZ29vZCB0byBtZS4NCj4gPj4+IFNvDQo+ID4+PiBSZXZpZXdlZC1ieTogRXJpYyBBdWdlciA8
ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPiA+Pj4NCj4gPj4+IEp1c3Qgd29uZGVyaW5nIHdoZXRo
ZXIgd2UgY291bGRuJ3QgYWRkIHNvbWUgZ2VuZXJpYyBwY2llIGNvZGUgdGhhdA0KPiA+Pj4gcGFy
c2VzIHRoZSBleHRlbmRlZCBjYXAgbGlua2VkIGxpc3QgdG8gY2hlY2sgdGhlIG9mZnNldCByYW5n
ZSBpcyBub3QNCj4gPj4+IHVzZWQgYnkgYW5vdGhlciBjYXAgYmVmb3JlIGFsbG93aW5nIHRoZSBp
bnNlcnRpb24gYXQgYSBnaXZlbiBvZmZzZXQ/DQo+ID4+PiBUaGlzIHdvdWxkbid0IHByZXZlbnQg
YSBzdWJzZXF1ZW50IGFkZGl0aW9uIGZyb20gZmFpbGluZyBidXQgYXQgbGVhc3Qgd2UNCj4gPj4+
IHdvdWxkIGtub3cgaWYgdGhlcmUgaXMgc29tZSBjb2xsaXNpb24udGhpcyBjb3VsZCBiZSBhZGRl
ZCBsYXRlciBvbiB0aG91Z2guDQo+ID4+Pg0KPiA+PiBZb3UncmUgYWJzb2x1dGVseSByaWdodC4g
TXkgYXBwcm9hY2ggb2YgdXNpbmcgdGhlIGxhc3QgOCBieXRlcyB3YXMgYQ0KPiA+PiBzaG9ydGN1
dCB0byBhdm9pZCBpbXBsZW1lbnRpbmcgcHJvcGVyIGNhcGFiaWxpdHkgcGFyc2luZyBsb2dpYw0K
PiA+PiAoaW1wb3J0aW5nIHBjaV9yZWdzLmggYW5kIG1haW50YWluaW5nIGEgY2FwX2lkLXRvLWNh
cF9zaXplIG1hcHBpbmcNCj4gPj4gdGFibGUpLCBhbmQgaXQgc2ltcGxpZmllZCBQQVNJRCBjYXBh
YmlsaXR5IGRldGVjdGlvbiBieSBvbmx5IGV4YW1pbmluZw0KPiA+PiB0aGUgbGFzdCA4Ynl0ZXMg
YnkgYSBzaW1wbGUgZHVtcCA6KC4gSG93ZXZlciwgdGhpcyBhcHByb2FjaCBpcyBub3QNCj4gPj4g
Z29vZCBhcyB3ZSBjYW5ub3QgZ3VhcmFudGVlIHRoYXQgdGhlIGxhc3QgOGJ5dGVzIGFyZSB1bnVz
ZWQgYnkgYW55DQo+ID4+IGRldmljZS4NCj4gPj4NCj4gPj4gTGV0J3MganVzdCBpbXBsZW1lbnQg
dGhlIGxvZ2ljIHRvIHdhbGsgdGhlIGxpbmtlZCBsaXN0IG9mIGV4dF9jYXBzIHRvDQo+ID4+IGZp
bmQgYW4gYXBwcm9wcmlhdGUgb2Zmc2V0IGZvciBvdXIgdXNlIGNhc2UuDQo+ID4gSSBoYWQgYSBn
byBhdCB0aGlzLiBCYXNlZCBvbiBteSB1bmRlcnN0YW5kaW5nLCBldmVuIGlmIHdlIHdhbGsgdGhl
IFBDSWUNCj4gPiBleHRlbmRlZCBjYXBhYmlsaXR5IGxpbmtlZCBsaXN0LCB3ZSBzdGlsbCBjYW4n
dCBlYXNpbHkgZGV0ZXJtaW5lIHRoZSBzaXplDQo+ID4gb2NjdXBpZWQgYnkgdGhlIGxhc3QgY2Fw
YWJpbGl0eSBhcyB0aGUgZXh0ZW5kZWQgY2FwYWJpbGl0eSBoZWFkZXIgZG9lcyBub3QNCj4gPiBl
bmNvZGUgYSBsZW5ndGgsIGl0IG9ubHkgcHJvdmlkZXMgdGhlICJuZXh0IiBwb2ludGVyLCBhbmQg
Zm9yIHRoZSBsYXN0IGVudHJ5DQo+ID4gbmV4dCA9PSAwLg0KPiBJZiBteSB1bmRlcnN0YW5kaW5n
IGlzIGNvcnJlY3Qgd2hlbiB3YWxraW5nIHRoZSBsaW5rZWQgbGlzdCwgeW91IGNhbg0KPiBlbnVt
ZXJhdGUgdGhlIHN0YXJ0IGluZGV4IGFuZCB0aGUgUENJZSBleHRlbmRlZCBDYXBhYmlsaXR5IHZh
cmlhYmxlIHNpemUNCj4gd2hpY2ggaXMgbWFkZSBvZiBmaXggaGVhZGVyIHNpemUgKyByZWdpc3Rl
ciBibG9jayB2YXJpYWJsZSBzaXplIHdoaWNoDQo+IGRlcGVuZHMgb24gdGhlIGNhcGFiaWxpdHkg
SUQpLiBBZnRlciB0aGF0IHdlIHNoYWxsIGJlIGFibGUgdG8gYWxsb2NhdGUgYQ0KPiBzbG90IHdp
dGhpbiBob2xlcyBvciBhdCBsZWFzdCBjaGVjayB0aGF0IGFkZGluZyB0aGUgbmV3IHByb3AgYXQg
dGhlIGVuZA0KPiBvZiB0aGUgNGtCIGlzIHNhZmUsIG5vPy4gV2hhdCBkbyBJIG1pc3M/DQoNCkkg
dGhpbmsgdGhlIG1haW4gaXNzdWUgaXMgdGhhdCB3ZSBjYW4ndCBrbm93IHdoZXRoZXIgdGhlIGFw
cGFyZW50ICJob2xlcyINCmJldHdlZW4gZXh0ZW5kZWQgY2FwYWJpbGl0aWVzIGFyZSBhY3R1YWxs
eSBmcmVlLiBEZXBlbmRpbmcgb24gdGhlIHZlbmRvcg0KaW1wbGVtZW50YXRpb24sIHRob3NlIHJl
Z2lvbnMgbWF5IGJlIHJlc2VydmVkIG9yIHVzZWQgZm9yIHZlbmRvciBzcGVjaWZpYw0KcHVycG9z
ZXMsIGFuZCBJIGFtIG5vdCBzdXJlKHBsZWFzZSBjb3JyZWN0IG1lKSBQQ0llIHNwZWMgZ3VhcmFu
dGVlIHRoYXQNCnN1Y2ggZ2FwcyBhcmUgYXZhaWxhYmxlIGZvciByZXVzZS4gSGVuY2UgdGhvdWdo
dCBvZiByZWx5aW5nIG9uIHRoZSDigJxuZXh04oCdDQpwb2ludGVyIGFzIGEgc2FmZSBiZXQuDQoN
CkV2ZW4gaWYgd2UgbG9vayBhdCB0aGUgbGFzdCBDQVAgSUQgYW5kIGRlcml2ZSBhIHNpemUgYmFz
ZWQgb24gdGhlDQpzcGVjIGRlZmluZWQgcmVnaXN0ZXIgbGF5b3V0LCB3ZSBzdGlsbCBjYW47dCBr
bm93IHdoZXRoZXIgdGhlcmUgaXMNCmFueSBhZGRpdGlvbmFsIHZlbmRvciBzcGVjaWZpYyBkYXRh
IGJleW9uZCB0aGF0ICJzaXplIi4gSXQgaXMgc3RpbGwNCmEgYmVzdCBndWVzcyBhbmQgSSBkb24n
dCB0aGluayB3ZSBnYWluIG11Y2ggaW4gYWRkaW5nIHRoaXMgYWRkaXRpb25hbA0KY2hlY2suDQoN
ClBlcmhhcHMsIEkgdGhpbmsgd2UgY291bGQgaW5mb3JtIHRoZSB1c2VyIHRoYXQgd2UgYXJlIHBs
YWNpbmcNCnRlaCBQQVNJRCBhdCB0aGUgbGFzdCBvZmZzZXQgYW5kIHRoZSBvbnVzIGlzIG9uIHVz
ZXIgdG8gbWFrZSBzdXJlDQppdCBpcyBzYWZlIHRvIGRvIHNvLiANCg0KVGhvdWdodHM/DQoNClRo
YW5rcywNClNoYW1lZXINCg0K

