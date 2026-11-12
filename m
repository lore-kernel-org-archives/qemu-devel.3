Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CF7606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 04:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=dyy3jWsu;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=YRmyaS41
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRMZW-0003g1-1h; Wed, 11 Nov 2026 23:38:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=769f446c1=Alistair.Francis@wdc.com>)
 id 1xRMZQ-0003fJ-4p; Wed, 11 Nov 2026 23:37:56 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=769f446c1=Alistair.Francis@wdc.com>)
 id 1xRMZM-0006GR-N0; Wed, 11 Nov 2026 23:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794458280; x=1825994280;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=R/Rve5/cf4YKO5SdurRwF7aNQikgXJXjxFdN5dF7/Fw=;
 b=dyy3jWsuCJfv6JQD8mhMs/6OvnhdGK0uWhD4njXn2CxR7Avhx84ZnDiz
 T4M6bmSHBJZRJGT2KKQw5ajQiHD9Cq17jCFdWx4Gz7cwkWO1YDaGfLw1E
 NS6BHfbouhLP2GWiTg+GUC71dyZius2vNlEI1BJiCZde5gvVJfocQt8Z0
 eDCyPM7Ay3NCzsJEBjwlwit3ZXPCFUxzr6WyuqJv7Ku/wk9ZT9jAJKDGN
 cOkSUZ0tCZedIGomi8cOS/dwXabZv2VhAa4nUUCDx3xBkwAIn2iQv+7En
 ogz3s96TPik1wD4dBbC6pehXKlnf8rf7mZxU8hfx/gr9bR9QbpM9tVwug Q==;
X-CSE-ConnectionGUID: ChbtRuP9S76J58niMjd/Yw==
X-CSE-MsgGUID: PNZ4UQx3TH60wX6hcQQADA==
X-IronPort-AV: E=Sophos;i="6.27,209,1786982400"; d="scan'208";a="159734263"
Received: from mail-eastusazon11012020.outbound.protection.outlook.com (HELO
 BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.20])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 12 Nov 2026 12:37:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oa/2ubtf7u+8ttbRSM9OtXheo+eBI8ePUIKRJvC0ZX6O3yt69kX08Qq1wuZY54dnN41SmD2gQMDTCVQpWYvbfC/JHU/ngiPqWkX+tOEWYOP0YcHfYmcmudPgdohLWFhgEtIqmQqSPQYSlN8GuRwFQm8hECeYLO8Ub4iXHAzwLrD9Pazdo/dZXdkD6PDC1x17Av5k1Evt7HY8ZXPBHkXZ49yxdwnu9TVotWxIbn48o2w9dXZCm8Dp77lSp/uY+FJ9cZMjFDqHBfXGhJ9y1qSuVoT83vCBbu0YfmjJnABAiISVDyiEO9AEV6SHqCgacBbYPwxhIi846zyECsr/ZgOzfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/Rve5/cf4YKO5SdurRwF7aNQikgXJXjxFdN5dF7/Fw=;
 b=Jo6GCJ6Ahd6hJNqIhpbGw/x/C9pgaxOgipeQG+Q1DQe7V9sXk0WdudmFYGuw4oMIPAXEhhML9WXOFNPTpyNIS+s0UO9b5Mf6bDWCmR+hGiX15t+oUEJpZiFLVrq+JD974ptdAgUN9RZucDIRGH8xoOMzhJuruXNA/xuR/NnHrDFHDAoEOTiURgl+NsBKWk0QPqeQZdvdY8lYGbnBvI9AVEPJo0cvxMbEZCMPZyS6aGhyrwzJ4rYirZ1Z7ctZLMCYvXzJLOnjAl4RwQJS7Bx5Q2W0EpMssOO7vbe1PCzrTG16+/lKEsIuqriL9vzahQLEG7dbHQuppVYa6yo5NORKWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/Rve5/cf4YKO5SdurRwF7aNQikgXJXjxFdN5dF7/Fw=;
 b=YRmyaS41sdPxd57/jFZl+whDJ4CgSxOyNSnK8/8dp+GyxsWJuKydU5BxTIJiMLVuHGUd4440Cz/+JdqeDddFLdhRitiH1iGsKJ7fPiR5BHsAZ32Z+3yJtU2eYNIleVzinBQmhekheTFK6RuQ8jCSwCFwuFSTLuTe/FGwFY2IDdM=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by BY1PR04MB9636.namprd04.prod.outlook.com (2603:10b6:a03:5b1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Thu, 12 Nov
 2026 04:37:45 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Thu, 12 Nov 2026
 04:37:45 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "rishab@rispop.dev"
 <rishab@rispop.dev>
CC: "tarun.patanjali@utexas.edu" <tarun.patanjali@utexas.edu>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "christopher.elwood2024@gmail.com"
 <christopher.elwood2024@gmail.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>
Subject: Re: [PATCH v2 1/2] target/riscv: Factor out pointer-masking address
 adjustment
Thread-Topic: [PATCH v2 1/2] target/riscv: Factor out pointer-masking address
 adjustment
Thread-Index: AQHdb00J9kLBVhEumUq2x/sa4xGnsrcp4IQA
Date: Thu, 12 Nov 2026 04:37:45 +0000
Message-ID: <7ecb9b8306ca1b6a3ce34fd546d3c28486b3e806.camel@wdc.com>
References: <20261108064641.179764-1-rishab@rispop.dev>
 <20261108064641.179764-2-rishab@rispop.dev>
In-Reply-To: <20261108064641.179764-2-rishab@rispop.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|BY1PR04MB9636:EE_
x-ms-office365-filtering-correlation-id: fcf8a30e-7881-46ab-20e1-08df4076b29a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|19092799006|23010399003|366016|7416014|1800799024|18002099003|22082099003|38070700021|4143699003|56012099006|261028144727099003|11063799006|10067099003|261102123227099003|261021135927099003|261021121427099003|261026140227099003|261021123027099003|261022105027099003|261009223027099003;
x-microsoft-antispam-message-info: SpnHmdwwdlOSliXLo2RCa87kfzOehkC/Lt2IEsg8Ibw4Pc3jQAn9xMUY+pwSuX8VPsAm7KmnBrICCUu+yo3fT2BUIfAhBqmcwIFXDDbzUvsOH+mw9NCM0NIvJeT/KXnuN1g9pamB/eYbbSDJkZp3qR5ZAv1n5SumDDBmHGGFzdopMT4Kf9HlQpM4cRkJWUmTVtXJ2YPEZKnqj9P4INigQwWqLHjSDpaBwekZo4ypGqAcrIYSyKGDCXb0tsPd764O9ttjIBtXOktsv04qtObVitJ07vzQ+K2gkAxE6vTcD08cjojewMup5joTMINJQk+V6p7LqyfwSrSAjsOTSE0hewgKWLOmpmmBU1uFd8QD6VNLz5M4UxGBGUDrteysB00jeX4j571a+JW54oQuRX5pQP5hq1Eu1rU3oAO4XR4ulIrkDPJYH1imXVyAr91n99+aFGnw0FH5gjHmRmiyd+AYfqgsohpZ3bnKy1Fwv+e398NKdAQ/+LUKzwd5c5ZQBAp/fdK4reRRuo5xaQA+exkIygA4LCrUrEkNrP5gaRKxQst6LYGjtFUm14EiZTx4/UguVwfPLdXmEmLJ7t9UKALlVa6Xk06WBY81aCvLqwcTc+VmAuDY/Blnpcfd2HWqoc1inObgG4uWvDHiKgib16xuCHTy5Zc3foTqNt25ABv7X9zAB3oL27vQtnFE4Uj02EwUZvCxSzWGVLljoq80sxnKdfEGtS/OcGGnHTuis3Lq954=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(19092799006)(23010399003)(366016)(7416014)(1800799024)(18002099003)(22082099003)(38070700021)(4143699003)(56012099006)(261028144727099003)(11063799006)(10067099003)(261102123227099003)(261021135927099003)(261021121427099003)(261026140227099003)(261021123027099003)(261022105027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkdQQXY5YkpEU21XazhJdG85eVduK2FVb3hqYTZLbnpQU3J4aFJZTGNLSDdX?=
 =?utf-8?B?elpjUFBpRlR2SUtTbjVtWHFkU0ZRajJCN2FTdldVUk1UcU1YWjhDdWRCUmpN?=
 =?utf-8?B?dWVpdmFudEFQRGVXMlZWUnBLbjFKNGo5OHpGSUVFK1JSUGNyMG1nSkkrT3Ni?=
 =?utf-8?B?V0tTWWZ6VDVPd05FVlgyRDhXQlY4T1c0ZVExSTJKdHZ0ckF4Ri9ZWFdyZmJl?=
 =?utf-8?B?NXNsZ3o1VkpmdGRJd1d6V3ppNzAzYitnSEdCTFB2UFZGWkF0dExyd3V3U3hm?=
 =?utf-8?B?Y1l6UGR6RVNaMlJGMEtDT3BGVi8rKzNOc0l5cEFhbjZJWmRkODFQOGd1M0pu?=
 =?utf-8?B?bW1qMmRLdnY5V3NOb01UZjdLU29sZGJjbFA0Z1ZBWDllNk9NMHhGWWZvcnJ6?=
 =?utf-8?B?K2c4YitzUVhtQ01LMEdzWU84YXc2c3pMMytpRE5nQzRCZGpBNDhoWTBRNXRm?=
 =?utf-8?B?L0FUMW1QTHBoQ2cvMGxVZTVEVG45QWVLQVRrNjVVU2tpZEg0Q3NHNzVJeWlU?=
 =?utf-8?B?YUVNaGlWeDRmSCtqVFJYWng2cVpNdHZZTlVnejA5TUdVZ1hNci9iM3hqZXFC?=
 =?utf-8?B?dWZGU0c1dVNvYjI2dW0vMndWeEVDaWN5Rk55enRkY240VzBPeTAyVmRjbjB2?=
 =?utf-8?B?TmNtNFcxaXRyTzd6VzE1QnFqaFFYR2JSSENnbDM5YzJ5eFp5Kytvdll2TVo0?=
 =?utf-8?B?YnpaQVFnc1MxQ0hnVFdEbW8xY0JmT0lMT0NXdER6Wk5mc3p2cnU3ZDdTNXVF?=
 =?utf-8?B?U2ZncmIyNWRqT3lWcEFndEQ2dGRZZFlLZHFKUUlJMy92RFFoWkNkL2JkblAy?=
 =?utf-8?B?MjFTQ2UycTM5cStWSkFSQnllZFJnNVEwQVFWd3llNjBrTnVpUG9rWXNtd1Ew?=
 =?utf-8?B?TStWdmZZZU9LaFMyMWF0cTcxcGlRbldPdnhUSjdYcS9aSDFob2hMNzA5UXRz?=
 =?utf-8?B?cmFNS25FMGsvNy9ReDNGaGdnb0xEUVhGU2hKYlpPRmlTK3JNdndyOUthbGRm?=
 =?utf-8?B?cERwcTFwcWhMRXBtWEJ1a1p1VHhxa3B6aE9hS29jbngrNGpNVjE0RHJCdmkx?=
 =?utf-8?B?MW5ra25YRWZaUFNUbi9MV2xFekpnRzFQZW9GZ1BCMFp6NjNMVmtyNnhGcE9u?=
 =?utf-8?B?bXN4TWtIRGd5MnRPckFpSXZ1NWhZTnhnZU1CRER6ZFJhWFV6SWJ4alV3cHd6?=
 =?utf-8?B?VG5hRTFMN20wRlZQdmxvMC9VK3lZUFc2a2dqM2dhTFljSi9HeG5RY2tBQWVt?=
 =?utf-8?B?WTNoc205aTE2aERhRm1sNS81cTBZL2N4aFNtSDFHeW5PdG4rdXRwdkdTQWlm?=
 =?utf-8?B?UkgwMmg4WTBpVVArU0hWYXBCU3FQbDV6aVpIYm1XRDFkSEJQTnJnUGRwdDZw?=
 =?utf-8?B?cWE0eWhFZjhuS2VjLzRreFIyN013bEw0TnJVeTRHV3lQRzlBN2FsUHA4cXF3?=
 =?utf-8?B?RjRvaVpVMExNTFFyRnVSeDFHdFhrUStHRi9WbkN1cWYwV3dpRzRCRk95d296?=
 =?utf-8?B?VFJ2T2k0NHgrODFOdExDWWdPV3FiTUV4ZldzRzBDS1RHSGZwYXJvZFJaRzNs?=
 =?utf-8?B?WmthbXlQRHpqTG5sZk1KZ1pvUXhlaHFNa2R0OVVZQWtyaEV5K2t1UnFlSEVS?=
 =?utf-8?B?ZzRRN0lTMTViSHB0MWU1NjBlUWlGWm1ESUNkMURkRHY5ZDNpV09XY0cvRUtS?=
 =?utf-8?B?RUdTVm1QYityUmhjRlhpRitZaUZ6RVlkMFNEVWZ2QzdoUWExRXJFZzd4Ny9s?=
 =?utf-8?B?eE1Bd1grU0J2Y3BMb2dMQXhGYkI2R3Z6dnpoaFMzSmVYb3JjZlkvTjBUQVVE?=
 =?utf-8?B?Rlg3dlJxbFlnT0tESzNCWkZNRWdNN3JkWk5xa0FXYnJ4YWh1VWRWNS9sRmNl?=
 =?utf-8?B?YWR6dlByV3BWclNGdzBCeXRyMlluZ1BjZXZ0KzNCQ2RzRnp5L0dUV2V4Z3hw?=
 =?utf-8?B?ckJNOElpWWdDaGlod01ZSUdpT2ZHZjRvVEVVdEluQ0psWGJqaGI3ODlsZGlK?=
 =?utf-8?B?MlQ0TnNzenZ1V21zcmg3VkZVZVdQL1RFM3hTWmlCYnErK3FvVTZsbEIwT0lL?=
 =?utf-8?B?cHRwVG44eU9xS1dBSXAxY25vdTVHbENmdzRzdTgwR1pXek54SVRmejVCQWxo?=
 =?utf-8?B?SVhFMy80akZ0RElKcHBHYVgyQkFzWEZDOExkRDhBWWpTT0dVaXZITFRZSjha?=
 =?utf-8?B?RDVYbi8ybWhJUkJiQkVXemhkOWR4SDhCNWVRS1A2Ukh3Vko2eHgxWE0rTGlH?=
 =?utf-8?B?dG1udDFxeFc2TVR5WFdEMHlOeC84ekR4bUtEcW0zZnZjNXVLaGwvSGtBOUMy?=
 =?utf-8?B?RTEwYStmZlhpaWZyUEE5cnRFMkVNSGxZOE5XQmZlK09uNkNmOFR4Vk0raXVI?=
 =?utf-8?Q?+I8UP2JumGdvfQhxBZtyTT85QMl+st86Hki4vmp4P+bPr?=
x-ms-exchange-antispam-messagedata-1: I6i5GrkiwhcLr3rGg78PEgg2jY1K/XrmGFk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22B90CA60802474B980AAC0EE78E382A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ldYHfsGMcX1djjfRoAjnjTf4r/taqOUa60ba82+GaPDscLidnc1pejH72FeBFHv9xyeccCIjO2UAcmUHFbBPdZxjZOLxhXMSaBdxlRvMtCJ9oXdjbGFzSKQURj+FQLbiTdoWn99R627DdsQ9VwOaGsRJTwK2M/1kiMtS8hoh1EJliG0gGtdK7N3cii8N/HV+jvUuAdTts+a5SQosdQqMT5UKUtE5qri5TEcqPhsCDRbA7o4/fgbxrrSNcnHRC772KQtj9jREYCdqL5hxHR4b+pc0JkOm4se/rTdsnPflDGWfYgk4g+3oPqpherc8zN+tMbXJpgFPVFatL5jdZp0sMw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JwM6qRUXlEaLzUzZ4zacIjqX+yZDNlgu7NPoBoVQeH7zTuzK2T4lp6SkE4emPb1zotIetokPkEsDMgFKgw2nOT2xQnUoxPKx4WW1kfAZHjh5EBvJmrBLyoBOhIb8GXOkICNStofft/j4rxDe99gSrsypQtgzbwLXn7Z2MQlBQ52JyVMNOeUAvw1nGWs1kMU1dapEv56l/FRH/Up8BluM+PaC3OMT57rPM55J/Zb7QmmdNtTJNvuDK8UzArCYIWlBE7Big68ydlnEuRBtbgXlUiEspCpxAIKxWUeTbm4AxM1J179i7oGRL+Ka2nb3q81Hrsga+hd/g2sCSA67WemV+dnjBtiV0zFlg9TUtadnbu2pAxnHa7jYFQTTmkiC9D3xKS3Esa5TvRObG29d2gdo2FHijGwtTVDiQ3/yltyyj0SovImdzQ5Y/ugR5mkT83tLmUbclZzy9njF5alr9E4RLeGIg1HiR+o0LZLNbA9KPP+UPtrGEqUpJS/E74jUiX9da1m2qcJ/n9K0ZmWRWp2l9rQU20UK3l3DouusLngGtJB28q2Wn7J+yiVsk8sQNRHtB8F6duFoDk58gISOPGopcTfvfCkj2Wys5vSHRRG8DzZaxfhx3ZXX+5XRrawVl4nZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf8a30e-7881-46ab-20e1-08df4076b29a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 04:37:45.6199 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qVGeRge/xrEbM6lmKTYb9yg1cFTx1KmWOcFW7RjoWSCps0FHCh6cuiwMuwytyWfCPMURPrflV1Ko1vOM5aIWkRyS+UD90kzFrGWWSovSQ/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB9636
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=769f446c1=Alistair.Francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gU3VuLCAyMDI2LTExLTA4IGF0IDAwOjQ2IC0wNjAwLCBSaXNoYWIgUHJhZGVlcCB3cm90ZToN
Cj4gRnJvbTogUmlzaGFiIFByYWRlZXAgPHJpc2hhYkByaXNwb3AuZGV2Pg0KPiANCj4gTW92ZSB0
aGUgYWRkcl94bC9hZGRyX3NpZ25lZCBleHRyYWN0LCB3aGljaCBhcHBsaWVzIGFkZHJlc3Mtd2lk
dGgNCj4gdHJ1bmNhdGlvbiBhbmQgdGhlIHBvaW50ZXItbWFza2luZyBpZ25vcmUgdHJhbnNmb3Jt
YXRpb24sIG91dCBvZg0KPiBnZXRfYWRkcmVzcygpIGFuZCBnZXRfYWRkcmVzc19pbmRleGVkKCkg
aW50byBhIG5ldyBoZWxwZXIsDQo+IGdlbl9wbV9hZGp1c3RfYWRkcigpLCBzbyBpdCBjYW4gYmUg
YXBwbGllZCB0byBhZGRyZXNzZXMgdGhhdCBhcmUgbm90DQo+IGZvcm1lZCBmcm9tIGEgR1BSLiBO
byBmdW5jdGlvbmFsIGNoYW5nZS4NCj4gDQo+IENvLWRldmVsb3BlZC1ieTogVGFydW4gUGF0YW5q
YWxpIDx0YXJ1bi5wYXRhbmphbGlAdXRleGFzLmVkdT4NCj4gU2lnbmVkLW9mZi1ieTogVGFydW4g
UGF0YW5qYWxpIDx0YXJ1bi5wYXRhbmphbGlAdXRleGFzLmVkdT4NCj4gQ28tZGV2ZWxvcGVkLWJ5
OiBDaHJpcyBFbHdvb2QgPGNocmlzdG9waGVyLmVsd29vZDIwMjRAZ21haWwuY29tPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBDaHJpcyBFbHdvb2QgPGNocmlzdG9waGVyLmVsd29vZDIwMjRAZ21haWwuY29t
Pg0KPiBSZXZpZXdlZC1ieTogRGFuaWVsIEhlbnJpcXVlIEJhcmJvemENCj4gPGRhbmllbC5iYXJi
b3phQG9zcy5xdWFsY29tbS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFJpc2hhYiBQcmFkZWVwIDxy
aXNoYWJAcmlzcG9wLmRldj4NCg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0
YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gwqB0YXJnZXQvcmlz
Y3YvdGNnL3RyYW5zbGF0ZS5jIHwgMjEgKysrKysrKysrKystLS0tLS0tLS0tDQo+IMKgMSBmaWxl
IGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL3RhcmdldC9yaXNjdi90Y2cvdHJhbnNsYXRlLmMNCj4gYi90YXJnZXQvcmlzY3YvdGNn
L3RyYW5zbGF0ZS5jDQo+IGluZGV4IDc5YjBmNDQ0ZWYuLjcyZDM2NzY0ZDggMTAwNjQ0DQo+IC0t
LSBhL3RhcmdldC9yaXNjdi90Y2cvdHJhbnNsYXRlLmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3Rj
Zy90cmFuc2xhdGUuYw0KPiBAQCAtNjU0LDYgKzY1NCwxNSBAQCBzdGF0aWMgdm9pZCBnZW5famFs
KERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcmQsDQo+IHRhcmdldF91bG9uZyBpbW0pDQo+IMKgwqDC
oMKgIGN0eC0+YmFzZS5pc19qbXAgPSBESVNBU19OT1JFVFVSTjsNCj4gwqB9DQo+IMKgDQo+ICtz
dGF0aWMgdm9pZCBnZW5fcG1fYWRqdXN0X2FkZHIoRGlzYXNDb250ZXh0ICpjdHgsIFRDR3YgZGVz
dCwgVENHdg0KPiBzcmMpDQo+ICt7DQo+ICvCoMKgwqAgaWYgKGN0eC0+YWRkcl9zaWduZWQpIHsN
Cj4gK8KgwqDCoMKgwqDCoMKgIHRjZ19nZW5fc2V4dHJhY3RfdGwoZGVzdCwgc3JjLCAwLCBjdHgt
PmFkZHJfeGwpOw0KPiArwqDCoMKgIH0gZWxzZSB7DQo+ICvCoMKgwqDCoMKgwqDCoCB0Y2dfZ2Vu
X2V4dHJhY3RfdGwoZGVzdCwgc3JjLCAwLCBjdHgtPmFkZHJfeGwpOw0KPiArwqDCoMKgIH0NCj4g
K30NCj4gKw0KPiDCoC8qIENvbXB1dGUgYSBjYW5vbmljYWwgYWRkcmVzcyBmcm9tIGEgcmVnaXN0
ZXIgcGx1cyBvZmZzZXQuICovDQo+IMKgc3RhdGljIFRDR3YgZ2V0X2FkZHJlc3MoRGlzYXNDb250
ZXh0ICpjdHgsIGludCByczEsIGludCBpbW0pDQo+IMKgew0KPiBAQCAtNjYxLDExICs2NzAsNyBA
QCBzdGF0aWMgVENHdiBnZXRfYWRkcmVzcyhEaXNhc0NvbnRleHQgKmN0eCwgaW50DQo+IHJzMSwg
aW50IGltbSkNCj4gwqDCoMKgwqAgVENHdiBzcmMxID0gZ2V0X2dwcihjdHgsIHJzMSwgRVhUX05P
TkUpOw0KPiDCoA0KPiDCoMKgwqDCoCB0Y2dfZ2VuX2FkZGlfdGwoYWRkciwgc3JjMSwgaW1tKTsN
Cj4gLcKgwqDCoCBpZiAoY3R4LT5hZGRyX3NpZ25lZCkgew0KPiAtwqDCoMKgwqDCoMKgwqAgdGNn
X2dlbl9zZXh0cmFjdF90bChhZGRyLCBhZGRyLCAwLCBjdHgtPmFkZHJfeGwpOw0KPiAtwqDCoMKg
IH0gZWxzZSB7DQo+IC3CoMKgwqDCoMKgwqDCoCB0Y2dfZ2VuX2V4dHJhY3RfdGwoYWRkciwgYWRk
ciwgMCwgY3R4LT5hZGRyX3hsKTsNCj4gLcKgwqDCoCB9DQo+ICvCoMKgwqAgZ2VuX3BtX2FkanVz
dF9hZGRyKGN0eCwgYWRkciwgYWRkcik7DQo+IMKgDQo+IMKgwqDCoMKgIHJldHVybiBhZGRyOw0K
PiDCoH0NCj4gQEAgLTY3NywxMSArNjgyLDcgQEAgc3RhdGljIFRDR3YgZ2V0X2FkZHJlc3NfaW5k
ZXhlZChEaXNhc0NvbnRleHQNCj4gKmN0eCwgaW50IHJzMSwgVENHdiBvZmZzKQ0KPiDCoMKgwqDC
oCBUQ0d2IHNyYzEgPSBnZXRfZ3ByKGN0eCwgcnMxLCBFWFRfTk9ORSk7DQo+IMKgDQo+IMKgwqDC
oMKgIHRjZ19nZW5fYWRkX3RsKGFkZHIsIHNyYzEsIG9mZnMpOw0KPiAtwqDCoMKgIGlmIChjdHgt
PmFkZHJfc2lnbmVkKSB7DQo+IC3CoMKgwqDCoMKgwqDCoCB0Y2dfZ2VuX3NleHRyYWN0X3RsKGFk
ZHIsIGFkZHIsIDAsIGN0eC0+YWRkcl94bCk7DQo+IC3CoMKgwqAgfSBlbHNlIHsNCj4gLcKgwqDC
oMKgwqDCoMKgIHRjZ19nZW5fZXh0cmFjdF90bChhZGRyLCBhZGRyLCAwLCBjdHgtPmFkZHJfeGwp
Ow0KPiAtwqDCoMKgIH0NCj4gK8KgwqDCoCBnZW5fcG1fYWRqdXN0X2FkZHIoY3R4LCBhZGRyLCBh
ZGRyKTsNCj4gwqANCj4gwqDCoMKgwqAgcmV0dXJuIGFkZHI7DQo+IMKgfQ0K

