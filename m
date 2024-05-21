Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D55C25B7B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 13:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9PI7-0008JP-Hl; Tue, 21 May 2024 09:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHU-0007i6-OD
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:55 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHR-0001Zh-PU
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716297109; x=1747833109;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=uArRsAtZO0QeDOuLsYInkvN90lliPubzGjvNNTs8OpQ=;
 b=DrQU/LKv5jOenlEoyZoLQN8+ID9egfTYE2/5s8v2gJtkBcNUJ2PHPRY8
 g24dMzkVbyW2gc+gZEt/UxOs1N4d+Cz7HZiNPTblBmfATAs4xbbHFFhYG
 OP0VLtOUUi26Z2yhJnO6iqAesFOTgRAucJPUg0XzDwzr1z6JqhnNo+rdU
 1Dh2bYNxohxe+ypAK3Q76YAPyIG7hUstVW4nrmTdoIVNQlW4gGG6dfRK+
 +qA5LULP7CmrSpRt45Hhx4Y/2IsMu0HuYXDZqnG4JNWdRq54N74cDeyS6
 vfrgF5uaRaEy7aGJENoJ1O3VzBbo29ZyNvo+ikTfeUEZGtIlJ1jnSdIrm A==;
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; d="scan'208";a="13061501"
X-MGA-submission: =?us-ascii?q?MDGLMDEiMuA9tmwdR9S42jc2p4jF/cXqufxVRF?=
 =?us-ascii?q?CeFuNXiavCb2MY1w1P6t8MQknTPA/fkuvlBS1v5JEekaczTK4JdZetYv?=
 =?us-ascii?q?8hwYfbb/nRJuVGdAAqbxK62Q9ld2sEgwHtIYXm3WLjvMdwBMpnFfLR8r?=
 =?us-ascii?q?VuXl+qPFSDrJfvDROsquyiew=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 15:11:43 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xx6D2ID6N4aHqYLUd7dYrjb17gGbR75OU93X0+eTyp3pc5yvupNPOmq7q5uSWW5TTrRtGVxtgtKaxeaaXvLE8IJiyZtPIGn8VipHg+LPqAXJZh0VZCVqiZuj5Osht+X/aVDf1zlgdeebi/NUxDvpu4xNimMr/7HBf/s1tArKgKd/hX1t061d/UgQOeUKsalWfrETrIO/REh4AyNu3jRjHRGPlSpfzUuJNo9G1T3zhyKZzlbk8Jh9l9cAPaxL7BVsBq72VbKOqferlXdlFBumaxwATlGhRA9feexrYVUvEK4PbEYLBdKJmC7f3ko1GkV7gwbmZwDuK4ee7Znh5Ii5xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uArRsAtZO0QeDOuLsYInkvN90lliPubzGjvNNTs8OpQ=;
 b=gze1v9EM++qwKT3/L56vz9Lim9T5igYcPn1wQvRSKre0KlW4gbC+ouyxEdCob6Y+EMfKyaIUPqKT0VBv9xKJTnd2e43ArTg61+2DO2IJHuY976MTu+LxN9HkNKKABTr/WXWM+ba93abcF8Hpn13+EloKzdcS7BVr9MXJwncZewQSLUJfYW+bQ3+JodqhQmtbKjb3pzRmn7njN0s6MYUHEZmVGhGYicWyPSC7zJqvN10QnmxJpla4RlLSxlKb9f/J96G6YMHAjBfGw/5XrU7WbGrxk363w9eZBNtmhSJg0ToHkPH73w2ok1Qe2yMwMI0ncm/i1JMUPDayFuM++pKajA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM8PR07MB8148.eurprd07.prod.outlook.com (2603:10a6:20b:323::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 13:11:42 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 13:11:42 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd 07/22] pcie: helper functions to check if PASID and
 ATS are enabled
Thread-Topic: [PATCH ats_vtd 07/22] pcie: helper functions to check if PASID
 and ATS are enabled
Thread-Index: AQHaq4Bs64wl4DvR/kGSdis2w1PqIw==
Date: Tue, 21 May 2024 13:11:42 +0000
Message-ID: <20240521130946.117849-8-clement.mathieu--drif@eviden.com>
References: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM8PR07MB8148:EE_
x-ms-office365-filtering-correlation-id: f629a2fd-e705-4687-6aa0-08dc79978eef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?TlBXN3FDRjZvL0E1bEtYRXhnNTJZUGZVVGtKWldGRzgvM1VSbU52NVp4QWVp?=
 =?utf-8?B?cDhJRjFHNldtNDhmVFMzclBXcVZWNC9mcmpzUDFXcUhTUFNKbG0rTklBclJz?=
 =?utf-8?B?SVgzYXcvWW5sZTJraWRscURaemt6WUtyZ2xOdHYxOXVzUEZDd2ZEMVVpeHVH?=
 =?utf-8?B?NkR1S1JsaW9vNjhpSW51bkVqMUorSHZmRSs1WndEcFJGK3hPOUt4MmJSc05O?=
 =?utf-8?B?T1NTTGs0Umd0cklLY3ZTbk8vSlpOOGloK015VHZCNVYzL0NrSkgwY0hwTExH?=
 =?utf-8?B?WTd3ZllhekoxZWFjemtHNlhUd1FhWC84cVErdjA4dlF3bHptTVdHVDJvdG1a?=
 =?utf-8?B?K0wydnpHZFl0U1Q3R3FQQ1lCVEtzbXVZSzFQU0NzUmhBM2swbk9Ddk1qZnpF?=
 =?utf-8?B?UFpMVkNqQW1sdEkxRFlzU3FTZXh6ZkFJUU15QkR1YWQyY2h2VUhabWNUQnJw?=
 =?utf-8?B?NHQzS3d5VlhydzNmMi9IQUczY3M0MGxyQU5OUHFBalhDM20zaFBRZlN2bDRT?=
 =?utf-8?B?WW5lbGdyRm01YUdQSWZYdTBLQVB5SDVFV1BqVlZzNWFxcUplQllZUUp6QkEv?=
 =?utf-8?B?OXJjbmFlQmdWOWM5N2w5cEZZVDRsYVp5eTJ5RTkrR2V4OFdqU2NEcGI0VE9m?=
 =?utf-8?B?anEzU0daTnBNdk9ncWVRdFhpUzdoMEpDUlMwTy9rclhYaTdCZU1kQVd0MkNm?=
 =?utf-8?B?azZVZ0p6S0JUV3N2djFUUTdmOUlKQkdtSFZ5SVVzc1N6OGQzTUw2UHpJMzdX?=
 =?utf-8?B?dFhNaUI2N1dnbCtIMHBxdStwUjJKMjg3YW5ndk03Ni9EVys3S1VvVGt2bHRO?=
 =?utf-8?B?YnFqZ25JaHNZR1BzM0JvUTBuUzlHMFhmTGZWTFF5RkdVZStxRHNmWXZSV3h5?=
 =?utf-8?B?OW1VeHp5UjZSZ25FZ2NmaGROV0hwN3ZXQ2FzWWxsb3lqdFVuMmpKYmNiS1pi?=
 =?utf-8?B?eGtBemF2WGpwbytvYTg0YTRJa3hsZ0tXUGU3Z002V0crb3VPalVRTWtkYWl2?=
 =?utf-8?B?ODVLQVAxcUk0K1JNc3YwL2EvWFllNTVRY2xZcmVTNUlpOVlSNUpBVnljQ0h2?=
 =?utf-8?B?eWx1V09nUXcrU1VQVW9ITWVTbUVkM3hueGNDWTk5Z3ZFSFdHczFUejMySm9t?=
 =?utf-8?B?aTN5ejlXNERxQUpQM2dzU1dlVGFaSFNPUGwxR3JPOFlEWi9OZWlkSWpyeUhm?=
 =?utf-8?B?UVZUYUk2aFNzVUhuUXEwdkRIRE1sVVJEZUtDdjRhY21ydjZxYTV3V2hSZzZD?=
 =?utf-8?B?d29DZm8weXVQRW1FY3F0UEZYUUczYXIrbG1DQWRlSVAzb0xsNkU4cDR0c3I2?=
 =?utf-8?B?Q3VTdTQ3cmhUVEVwZFMzMHBNQkh3UGdMcWRtVGU0dVN3R3Erc1l1ZmM0R3BR?=
 =?utf-8?B?YkxVdCtQazcweE5DYkVDU3Z3VUVNZHE0SFBHMjhHT3M4ZE82eW1WVmk5S3I0?=
 =?utf-8?B?b3gxUGxuSHI1MWx5eU5mL2JxWUZjcndpQVBxNDNpdnZVeXpCaCtSQm5MSW9K?=
 =?utf-8?B?Ull1a0tnN2xvQnBPWXhTak5XZjAwSURVMmNucWJvKzI3d2tpUHVsZzZJdFFN?=
 =?utf-8?B?ajduUnNhaGpsTVZiMHZjaVVpSGtnYklCZ3Q5a01Zb2xRZzR3TU90UEp0RVU3?=
 =?utf-8?B?cjZ1TXNDVDF6RzJYQkxjdXk0TjlEK0NoTGp3N21BSEtWY0hoVnZlRXZ0dzNI?=
 =?utf-8?B?alBHZzZPYXhsbDV1alZBcTR0eW1mZThNc0xRQVByclF2ZzdnTlQzNitLdlQx?=
 =?utf-8?B?OXhjTE0vQWRIUUUzSmY4RzJyVHJMbkhCVkpWalZPZUhzZzBCUkZXaXQvVXlB?=
 =?utf-8?B?SThrTVlLYkdwRUUwaHJJUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3BtM3E0enZEbnMyYW04cUppOHQvM1B4bGZCSUR3LzE5N3ZtcFhKUDNzNkV1?=
 =?utf-8?B?Ry9LZmFYRDEvaEJwQ3ExQmJEUzR6VWw1anh1UFdSUXlpd0RkNnI0aEpJZWZJ?=
 =?utf-8?B?NDg1Zm9jTEZ6RnZieGMxd0VEM2t6RGFubW1QT1FKbmtvM3NCNjBuTVJwbkl2?=
 =?utf-8?B?a2gzSUtQNDRSN21zVnZiY1lLYUZnaFJ6MmVsaDdnM3F3SFh6QzlQd3hneTVn?=
 =?utf-8?B?WWpZbVVLK0Yva2pYallNeWVTMnNwc3YvbVhQdUV1SWIwN1p3WnZHdVB6WXk3?=
 =?utf-8?B?RE1yMmlUUXdtRXhsMy95STFPRTM2ZSsycS8xd2I0TWNWMHh0SFRFSlRncEpw?=
 =?utf-8?B?RjA0R0ZDdGdEWXROM0FqYkM3amNCZVU3T0NPQVZaWmJNbzQ1V1J4MVVyOUFO?=
 =?utf-8?B?K3NGY203ZnMyZzlkQlpVVlI2MFNtNlo3T1hVdFl0czUxSEU0d2F0TFY1VVZH?=
 =?utf-8?B?Snd0WHhTQUpDREIvc3dValBmVUJGbkhLR2NPVU51YVFieUVVenExM2xTZEFy?=
 =?utf-8?B?Nk10T05vMEs3L1QxSklrOUhQNzFoNWp0ai9RZCtOODNmNDRwT1NoZTVpbm5R?=
 =?utf-8?B?bjAzaHpXRXFVM1VRR0s3TVg0MEdNdllIOXkzY3NrNEVLczJZMnh0VnpJM1B2?=
 =?utf-8?B?ZHMrVmRQbWY0YnV4Qk9JQ01BQ3M3cm5qVmgraTNscVRtNDBmMUxsRC9hUWcx?=
 =?utf-8?B?Y2VPdEd6YWg2ZlV4eXU4M1ZIUmk0cFVpM3VNcEdaWEJWb2NyVmVydXVicDdr?=
 =?utf-8?B?OGd2eEpDeXhCRzNHVTJZQ1Q1L05Ec2UzKzIraE9iVkNuWW9teWZlakVMQlgr?=
 =?utf-8?B?UGxBSXZXTXNFK1d1bm05V0F0cnAwQ3hST3AwUXgxSHlmRDM4V0J5eHgvUThw?=
 =?utf-8?B?K3JDNDVINUxSTEhSRXZUdFd3aEJnV3Fab1IxdXdJWnlCNlVnSmdvMnpMYkRN?=
 =?utf-8?B?bUlpRms4RDRtejh5a1ZsNkhkV2x5Zk9WSEk5Y0lHY3ZxSzlNNnB1ZHV6WHIr?=
 =?utf-8?B?MUhQcEJJWFRvZkwyUXArT1MzTWZ0Qjh1amlyTTNwU1VxSDVlSjUzbSs0c2lq?=
 =?utf-8?B?NVFiMm9oMjMwVVVOVWNsWGhUL2svZklHY1ZWelZvcHE0bXNtdWlYWTJ1NTBw?=
 =?utf-8?B?Tm5ZRXNOcDhmUi8zMDc3c2UxUVpWOU10UHdHRkRwZnIzc0FtTnBnczIvZXQ3?=
 =?utf-8?B?aUxQZ3l1cGFFWUFwSWM0OHFMVHVXZnc0WDJvM1VaNWVnZmlQZEJuSUx3bzlK?=
 =?utf-8?B?QVgyVGk0Vi9ZWWx3d2pxaTdkUzFwaVNVYTlmc2o3VSt6ckJ4NVNVQWU5cUM3?=
 =?utf-8?B?VTMwelFEamJ5NkV5UmUrQXBEb1ZaZnhtUkM2c2tLNXpWdlNOeCtKcnJNdm0x?=
 =?utf-8?B?ODNrZFBaUjRJR2FyZGkveXJrMGttU1VIbWliekE3ZzZnTm53ZXZIQ1VaalBj?=
 =?utf-8?B?alNVT0E4S3JRTTVHWHlEZ2tNeko5S1hZNFQvYVkwQjZuSUxsUGxVZndHQ0M1?=
 =?utf-8?B?ZzlWczZWaTBpeHpQMkZqT1lYc29ZMXMzS0VuVHE1Qk1jYTYxdVpaY3lRNzBu?=
 =?utf-8?B?b2haOHFBUWNpVzB4d1FxdCtCUEVIbzFWQUdiYVJDMTJxdUdZTXJ3Z1BTTVU3?=
 =?utf-8?B?MEFTQ3dibUx0Rmw1dW15ZU1KNU90ME5keUtjTWdxTjlneU4zLzJKSTJITDlz?=
 =?utf-8?B?eWY1NUtNK0pZQUpGNnR3Y1djWk5VU2oydmpxY1lhdlBRbHRrTldFb2twUGNs?=
 =?utf-8?B?Wjh2NVl4dmh5cmp1YWwycjZSdC9OZC96WGI2WCsvZUhFMUlHbXNtcW42SWF3?=
 =?utf-8?B?ZnN2bWNSYjB3M2RpUEI2VGdOclhYK1NGekJrQ1lPRno4R2lnUU8zS25KSWY3?=
 =?utf-8?B?MlBObFExL3hoRE10UEExeThvc3JUNWkzcTM0VlRVTVp6aG9KbjJHQklvSlZO?=
 =?utf-8?B?T3U0blQzSHVtZ25wM3lCSmg1cmdQZGpSMXpoM05aN3lUdXdETFp5THlJYlFV?=
 =?utf-8?B?aitRTzVBZFh3ZEMzNzhHNC91cGduZ3hsTDhUWGdOcDRldVplbHYrWkJvODNr?=
 =?utf-8?B?VDVYTGs3cVM5NW9aTVhhNENQbXp0SkM1bTRTRWVBWVR5TkJCVlczaXd3dGtH?=
 =?utf-8?B?d0ZlM2dTcHZ6WFVhK2dEZHNrQUhGOW5lY3FzUU51OTQzZ25aVFowQlMyN0oy?=
 =?utf-8?Q?BbF50ZYGCzqZmyQYbcVBB3E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCB580694C93D34B9FD7EB76AD4BF048@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f629a2fd-e705-4687-6aa0-08dc79978eef
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 13:11:42.4223 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AOjSLVrAJEWxhhAqGwsKjlaFOuAUvlMYLyZ4ggf1eQzv/DXWuKyMJHuH8JC5Z1qqWHb45h/y3o5Jmnsl0yT1vU0ZUtWUkt9TrWTzDw6IRQoiKnXUEGUDnoUXgnPF9L+/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8148
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

YXRzX2VuYWJsZWQgYW5kIHBhc2lkX2VuYWJsZWQgY2hlY2sgd2hldGhlciB0aGUgY2FwYWJpbGl0
aWVzIGFyZQ0KcHJlc2VudCBvciBub3QuIElmIHNvLCB3ZSByZWFkIHRoZSBjb25maWd1cmF0aW9u
IHNwYWNlIHRvIGdldA0KdGhlIHN0YXR1cyBvZiB0aGUgZmVhdHVyZSAoZW5hYmxlZCBvciBub3Qp
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhp
ZXUtLWRyaWZAZXZpZGVuLmNvbT4NCi0tLQ0KIGh3L3BjaS9wY2llLmMgICAgICAgICB8IDE4ICsr
KysrKysrKysrKysrKysrKw0KIGluY2x1ZGUvaHcvcGNpL3BjaWUuaCB8ICAzICsrKw0KIDIgZmls
ZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvcGNpL3BjaWUu
YyBiL2h3L3BjaS9wY2llLmMNCmluZGV4IGQ2YTA1MmI2MTYuLjRlZmQ4NGZlZDUgMTAwNjQ0DQot
LS0gYS9ody9wY2kvcGNpZS5jDQorKysgYi9ody9wY2kvcGNpZS5jDQpAQCAtMTIwMSwzICsxMjAx
LDIxIEBAIHZvaWQgcGNpZV9wYXNpZF9pbml0KFBDSURldmljZSAqZGV2LCB1aW50MTZfdCBvZmZz
ZXQsIHVpbnQ4X3QgcGFzaWRfd2lkdGgsDQogDQogICAgIGRldi0+ZXhwLnBhc2lkX2NhcCA9IG9m
ZnNldDsNCiB9DQorDQorYm9vbCBwY2llX3Bhc2lkX2VuYWJsZWQoY29uc3QgUENJRGV2aWNlICpk
ZXYpDQorew0KKyAgICBpZiAoIXBjaV9pc19leHByZXNzKGRldikgfHwgIWRldi0+ZXhwLnBhc2lk
X2NhcCkgew0KKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KKyAgICB9DQorICAgIHJldHVybiAocGNp
X2dldF93b3JkKGRldi0+Y29uZmlnICsgZGV2LT5leHAucGFzaWRfY2FwICsgUENJX1BBU0lEX0NU
UkwpICYNCisgICAgICAgICAgICAgICAgUENJX1BBU0lEX0NUUkxfRU5BQkxFKSAhPSAwOw0KK30N
CisNCitib29sIHBjaWVfYXRzX2VuYWJsZWQoY29uc3QgUENJRGV2aWNlICpkZXYpDQorew0KKyAg
ICBpZiAoIXBjaV9pc19leHByZXNzKGRldikgfHwgIWRldi0+ZXhwLmF0c19jYXApIHsNCisgICAg
ICAgIHJldHVybiBmYWxzZTsNCisgICAgfQ0KKyAgICByZXR1cm4gKHBjaV9nZXRfd29yZChkZXYt
PmNvbmZpZyArIGRldi0+ZXhwLmF0c19jYXAgKyBQQ0lfQVRTX0NUUkwpICYNCisgICAgICAgICAg
ICAgICAgUENJX0FUU19DVFJMX0VOQUJMRSkgIT0gMDsNCit9DQpkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9ody9wY2kvcGNpZS5oIGIvaW5jbHVkZS9ody9wY2kvcGNpZS5oDQppbmRleCBiODcwOTU4Yzk5
Li4wYzEyN2IyOWRjIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9ody9wY2kvcGNpZS5oDQorKysgYi9p
bmNsdWRlL2h3L3BjaS9wY2llLmgNCkBAIC0xNTQsNCArMTU0LDcgQEAgdm9pZCBwY2llX2NhcF9z
bG90X3VucGx1Z19yZXF1ZXN0X2NiKEhvdHBsdWdIYW5kbGVyICpob3RwbHVnX2RldiwNCiANCiB2
b2lkIHBjaWVfcGFzaWRfaW5pdChQQ0lEZXZpY2UgKmRldiwgdWludDE2X3Qgb2Zmc2V0LCB1aW50
OF90IHBhc2lkX3dpZHRoLA0KICAgICAgICAgICAgICAgICAgICAgIGJvb2wgZXhlY19wZXJtLCBi
b29sIHByaXZfbW9kKTsNCisNCitib29sIHBjaWVfcGFzaWRfZW5hYmxlZChjb25zdCBQQ0lEZXZp
Y2UgKmRldik7DQorYm9vbCBwY2llX2F0c19lbmFibGVkKGNvbnN0IFBDSURldmljZSAqZGV2KTsN
CiAjZW5kaWYgLyogUUVNVV9QQ0lFX0ggKi8NCi0tIA0KMi40NC4wDQo=

