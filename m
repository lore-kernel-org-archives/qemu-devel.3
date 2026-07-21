Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5E6C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm9ZP-0000kA-2H; Tue, 21 Jul 2026 08:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wm9ZN-0000al-5H
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:27:33 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wm9ZL-0004qd-AZ
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:27:32 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LAQvgR3250603; Tue, 21 Jul 2026 05:27:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=YpOinpXMRRhG8Pbf6cBQnfiXG+fmyxlPUm+J/q+TW
 MQ=; b=C1bN8fKVHRmjcfsuvgcw6h+qgxDZajgZsGMOEum6wlAkWrFuHF5L1mDEp
 uKcAaSPlwbJAZJX2eY7MtHhpBY5X/glOsnsx8BRE7MPb5FO/kaH/44COTJLIbhlG
 DHVgx/AeX9ZuGgeznsPBt62+plqSQCQExqCzC9Gv4paC7DkKTNlZSS+VHehTMOX7
 G2cQQ6upGbbXuixNPnyu24kpk/dkJDpOPecDBQgfWQV+cMSahhYixG1H7t6qn+Hi
 dMiv8t0b8lrl+LYvb0NBu09uD5vW9Dzdibs62sQ6ttzntm2S8h9JRlz+RUG3NB0l
 y18UkKHQNT7IT3qrVXm452lNyA6Sw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022094.outbound.protection.outlook.com
 [40.93.195.94])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg8tbpbx8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 05:27:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZUnBvi0kHR6DqlW9F/QDiawW30vRxdCLcSrXXGWHRVaxIIdXczsvTV3oKRoj1Oqkxz67uSXdOwezTazqmZvYVolYbALqdNMxH6kDxoVKiT1qf0HFFVhDDjnGAXwRoX8HRxYslfaT3/4L8OZvpJ70kh8cTRVpFy4LOhT9VcnZE8JLnbmsX3qU4tjxljJE0i4mmn4Hm2NsJVmMI0r1tIrZu5IkrPtD36qqnH8vtkT/3v2TbqncTKn/TpXedT+Rg4SXMbF/KIbAI9wPXAWwFejySWb/vlFln97dn2BE5MVijOOtXciS6cHQkw0pnYGuJKLOhcqTxAZsvCyDkxX61XVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpOinpXMRRhG8Pbf6cBQnfiXG+fmyxlPUm+J/q+TWMQ=;
 b=a+kp1M3NuCbmE+7s7Jk9Xxy2Th5Ka7Js6prtJtrohJXZ0/kPV3Mesar+5TUwQeCgan8P/Ctk0Pk49f5i8ZwSa8CFzMDCN2T1Y6U+MfBMF4EJYauxPXW5EKM6Wz+U2juZGNIxG5IPF02z2szO3oXQ7ECpvipQ9/8dFRNG6TK3Ip8h30hFomwQt41aDyU4GscFmpmcwxbtmH+FRm+jsi5zzoUqfLco7lIMykI0hsbl/4xcXkgvlD26uppk0plzsspG7aLXDh6F1+Sp/W2EiQOaUwquIrxX+wKX2dmJKTEzLwr6mfy1UaxQJwBJQYOe38ErHW+ef5Jx3XC0tb9/+GbbdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpOinpXMRRhG8Pbf6cBQnfiXG+fmyxlPUm+J/q+TWMQ=;
 b=eD5FbwEYB8Q0yA1ov2vvd0u/v+t02sTj0RmmV61lMh2FXMQnh72pGSLqPqNnQ+Vv1jt45ssNhB0Aqnq1c7f5OAFmjkJCKNFgOjDw/U0LxVkZUeFgEnY9QOozdhBsJVWv8JYdYWQqRA70iI8Uaow8QZEjyi7Ey5/dharNU2PRPkx0tBFz3/4gLrqVrGAUcOFFBj7VnGTQXA1e3ikfA19gOh548S5C4e1FJK5ZImSbnjAwaCbcr/6LjJDZG9NzgkyhG4Agx+tGgzgeZmlsqe98x0qccD5wPZO3SlKujjLc9eAQJg0DfGfSBsx7Eoa3TD3njjiXWQoBSpanS7lajiI1rQ==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by DS0PR02MB10249.namprd02.prod.outlook.com (2603:10b6:8:1a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 12:27:26 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 12:27:26 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>
Subject: RE: [PATCH v2 0/6] vfio-user: validate server responses
Thread-Topic: [PATCH v2 0/6] vfio-user: validate server responses
Thread-Index: AQHdGE/cu9eFH+JTE0yfU+CZbQ8hRbZ2j6kAgAD94oCAAEaMAA==
Date: Tue, 21 Jul 2026 12:27:26 +0000
Message-ID: <IA0PR02MB946250B4EA7F74C7C74675828BC22@IA0PR02MB9462.namprd02.prod.outlook.com>
References: <20260720091718.2642-1-thanos.makatos@nutanix.com>
 <20260720135823.21070-1-thanos.makatos@nutanix.com>
 <a4ddb949-7a65-4665-a802-890e47089e76@redhat.com>
 <5970506c-16b5-4269-9f9c-3374d7f51837@redhat.com>
In-Reply-To: <5970506c-16b5-4269-9f9c-3374d7f51837@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|DS0PR02MB10249:EE_
x-ms-office365-filtering-correlation-id: 43597264-1cdb-4ae8-05c9-08dee7236cd5
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|22082099003|18002099003|56012099006|4143699003|10067099003;
x-microsoft-antispam-message-info: Z3gudOaPXJjKsUDgxM4z2DZvqX/Ikvn1GfxLT9jA9xH63pxhibkRWB2LnlltPpjalW/+mDU0q3C7Oa3TryqbiSl6yv58GO5uFKhwQnoAiRagYhIKg29dbJGGgxlexDzuOiDm6mZNYQvGJhJseQ9/hkvcGulfbSH5JPnspyGsRm79FqaTf2imiv1ChYncQm3T6Q0NOLXPjatVIbgisTXlnFMOtr/h2TEJr4+JoVGXnEhlltIOOgCVwcDB7XQx50NLAHvvrQkZmtXE5mXyIK/0DmBHAKS6ZrryKj20gkGCZodoiaGEctYySPwo6bI7IoVIEnAHUYNfMelDDs3oU6MnvH+7HTxnWoypXSDuzaHVoCn6LfGIMCFG/XG46P51dp6Ht2u9KV7jd0pr603SPY3eK0CtsGu8Dn7qcrX0+5A2a6bD+puFGAt/dXHACFyL/vV4SIhBYco8bYjVu0YCEOR9XzwW/46Zj7HTnc+/vprc9t2IJ7Q3QLVTga0YjTVme1AwpGgqi4DgCBw18rWgGjLmzp6BKZDs3VksNDMsM+e7TVZCpv+9cjaEPFpbX0TnyJWT6XcmdgqpFphzVmfqNI9+Xdi7OvDzOcCiiEjC+LVM5u+3hdyr1HlunGU7eDI8qFOnSGUp5nVo6uE9pZonWeRT01gAFbcJxFKD+Qqc0thL2VpLGpYn98XDlavjEoVYcTbjSu40gvKABHd4uPlaXvUtXg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVVUd2FyeDdzdVFIYndra1IzWFYzM0RYa3VYdHlJUFhadUQ1MWwrL0YwdkMv?=
 =?utf-8?B?Ni9xV0VpL3hsVWZOVjFvVzR3Z0dRQkc3bG5MYVlqNjRvZEV3Snh4YktISUtS?=
 =?utf-8?B?eG5qUW8zQXJBT2hWRjNuWDk5eVZUZC9sNFJid084NUhUb3J4V3lCeFlOOVVo?=
 =?utf-8?B?cE5RcVV0cVRTUmcySlB6WDZyVytQb0ZQdXFRVXRVWCtDV0FYbWVma1pyeUpC?=
 =?utf-8?B?bVFsVEF6Wk10ZjZtOWFpeG5RdlRwTUVKakpvUVVkQUovYlRXU1J1QldwbkFw?=
 =?utf-8?B?MEhVTjd1T2pmV2RmVG0rWUhCMEg4UFpVc052MDRsbysxMlB6bzdlRnUzQ3d1?=
 =?utf-8?B?RXY2dUZKaGxXcW5DM29sSkxTdzVPSUpmS0NNUi9pRTJnWHdHNzRlMEdkSFU5?=
 =?utf-8?B?Z2pOSUxlUytoYlkxYktpaTFGZlJCU3pLSkRLelFZWWd4aXdmQlFjSThjKyt4?=
 =?utf-8?B?OHFFT2VrbkZkRlJYR1Q3NGl3YmVCUWs2b0JlelBNcHpPRWNhVFdTRVl4Vmhm?=
 =?utf-8?B?eEFwbnFGenc2aG5DbGFvTlJDKytMcTY3RWNJL0o2M0hmM1Z5UDRxbFJEZDVo?=
 =?utf-8?B?NHcyZHVmc2JZOXVXRlhDYWNKWFFvQllUR3BQSUthaWpCQzU4TllpdUdSdStr?=
 =?utf-8?B?Rm5jeTBLRlYrNmVkNmRVNFRuMVZBd3RQUmdvQ25uN0NRVEE1Q3V0YXVPU1dm?=
 =?utf-8?B?MmluQU9FV0JIZUJndVl2a1lUck5xcEluNTRXTmJuVGg5UVYrOERMM1Q0QitV?=
 =?utf-8?B?Tm9YeElwaXNIREY1NHN1RVcraTFpbnBWd0hrOS9LTE1yS2lsdHM4N0o1d2l4?=
 =?utf-8?B?dXN6dWtsRGMwRHBRUC84ejI4dlVQOVR0dHFCRTBGa0p5REE4N0VyMzZHd2tW?=
 =?utf-8?B?YkZnd3BKU2d2cW5kK2F3OXFLS2theFVPWlhoalpOZEYzTGFNM1JHWFI3Nndv?=
 =?utf-8?B?WXVIMTcrdFlIZGExa213VkJpY1NmbUxRV2tjd1ZoMFBqd1pDU3hUY3hOUmt6?=
 =?utf-8?B?YmYrWWpqcktQcVBZeStOd05jUXlyK0dLbUFKZ0Eyc05XdHVicDZ3VndoUkwr?=
 =?utf-8?B?S0ZuTy80Wkx1OUk0U0FWeUh0TGYwWng3TlRwbVhkbHUvNTlCWmdTWWdieWVW?=
 =?utf-8?B?VS9PdkpyeEVTRmJKdS9TVzdrbjNwVmRxKzRqNmUzaktzdXhvZGpzNXVyUXpk?=
 =?utf-8?B?ZjdpM3lVaGNCSm5yR0o2Sm13RzFVT2Jjb0VKTW9oTGJTVzk0MjZZSU5zVmJt?=
 =?utf-8?B?Z0paOFdWMmM2K1EyandjcktwY2VDWVdGcHpOYWRZeVlhVGVmT3pZYmMyeTdS?=
 =?utf-8?B?VDJGbmVpUVh0MGZibnR6SHI1STVsSEw2TFVudU1ESWk0Yng3b3ROSEl6U3lO?=
 =?utf-8?B?UUtIUzk4VUVVUHVOZHcxZERENE1Dek5yUXJEcTJJZ1BFYVFXNU1zMVBRT1hy?=
 =?utf-8?B?bytYNUNSYUFsK2F5TkVPbk1rL1Q1YlFpcTROOUZYRDFGZFJEUnZKUDhPRUkw?=
 =?utf-8?B?VXNiQkdFSkpPYzZwVzhtWk9BTVZ0ZTZWOVhSVUxFMU5CanJKbFdmN0pGc1FF?=
 =?utf-8?B?WUs0bG1mT3JTN3B2U28vMHhUWll0eWZNSnVSV2pzWWFJR0ZqYUNsWnh3ZUta?=
 =?utf-8?B?NjFtZ3hEWnRRZUExdm1RMjBuM3Y2aDJITGplSXJ0Ny9ycXgvVS92S2czVVFx?=
 =?utf-8?B?VG5xTC9qbHNsTDIvWHhVVEZKdXN5djNKNmV6RHlXWi8vOTg4WkpjYlMrZVNC?=
 =?utf-8?B?YXNzc2lMaGswL2ZuR3lGR1MzTFh2YzVVZWdyMHlmVmpiZjNSMEF5TDZaSS9Z?=
 =?utf-8?B?V3pxaFlDTDNieWNMWGhIbEdXQ0xwWG85SE0yV203dEpOMXNnSjBKNmx5Yytn?=
 =?utf-8?B?ekJnS1R1WG5rTmtnRnJUbGVPODEzRS9kcDFtcGdvUHc5ZDhpN3ZQT2pEUG1P?=
 =?utf-8?B?bkJ0ZmpHMFpRcTMzVlJkb2s0Ym5mdUtMd0Vlc2VwaG13eVA1ZUlPZGRWa0JX?=
 =?utf-8?B?QWREaDAvS3MvcVI2NFY2WTlZMVVzcUM0YURJeHAvSjJ3VHR3MGttUVdMNlJE?=
 =?utf-8?B?dVVGYk5Zb3k0RDdpR3hDdlJJZlBZTmpZNGxDOW0wVE5SRGM3T0gwNXQzZ0d6?=
 =?utf-8?B?WWNIV0s2SnpTUEc3NXBOMUdxa1FoU1FWd1hnOHhQU012c1FJTk9PUGlGL0tD?=
 =?utf-8?B?bktzZi8yRW10OXdOOHBMUDJNeW1JdHVIODhQWkRvL0pwYkZDLy9MQkxIRkxT?=
 =?utf-8?B?bm1MRWVLd00xMGFFMDhpL2lidDdid01RekVKeERWZklyYWpDZTFOZnNKcXVq?=
 =?utf-8?B?Ymo5VWQzVnFuaHN6eWYrQmF3RjhrRlVvK2oyaktxUE9MSkNNZkFndz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NIFfGWesHFs3/v/BZA7a2AV8zrKY0z6JBhN1d/KmPY7vYH/ynjsrH2Wtn7cd/snLJRoFGmONdfs6v3ra3PYiLltan1eA3UNovAV9fdi1/PlNEqPsOKgrL1dHm1LqjVnknohzWyeH16tJ7b6YNn9XYS0P2P1vYbkVpsvpUiZSrGgfMbe7TL3NcxdAHhMosIeW4lMyww/BEQyEwsdtL5RZEMPwbVM38RhxLh3NWJ8wo6mu8k+a3jjCiTyvFGrbYAlxdYMf3bHkUZ5b176oSaCZKomG1kg/vHWnPoUBUJ9tWycZb2UkKS8lChhByWYay2v9LbTNjRpApLtKZamI2J16uw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43597264-1cdb-4ae8-05c9-08dee7236cd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 12:27:26.8740 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WHl73FRCfZU+D4vWmQkMppKdh0O/ZxmOxk3B3KbxYidB/tQ0fEnSR3q8P8atjjlWPfbjYQgpIShEMLAhZRMzK+631bCU0ne/IGozYD1YAZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10249
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEzMiBTYWx0ZWRfX1iZcNJcFsoW2
 CJUbLgrLvOf43vf2V4W8vtHwMaXXlQamCSz2q9R3aDyCSbtKVgBAX5lfAZ9Jx31DlXbmBj5bht+
 W42gmFJdv/ELsEp5PgNLxpcpotpGDfnV7gc2EDX/UtIMS5Q/cAS6IHSr8maA7zUXBNaQErXouvn
 0WyRAUJikYsZ7MND23DYMv31AZXJOf3m7x9f+fPAQ8nyi+fjL/cP+w5lKCKwN9h2p27jUlKbFon
 4m3s/RQ9vWiFJPuzdp9COVBhxcrpCw2IwOGwff3HySRGjLUR44Rlw05fwwnqimjFsGsRbkUEw9O
 DPAlsbzNZ048XSn7PV493A8/YgM8f42FB4DjnEhP7Ze8oGiL2Mm0iD8fVWtcX3YJtIglKjgX593
 RZPs/isUdQ51K5I13uw2MylDcTZiy4mTjnxsmzpPCxB/LiYr5UxAHkWM6n7dmWZENuKexbCdpY1
 FSR66OF21uWFuiQXCKA==
X-Proofpoint-ORIG-GUID: XALTMQYZ2Kmwb8CWk1T70tlMukNNMvQo
X-Proofpoint-GUID: XALTMQYZ2Kmwb8CWk1T70tlMukNNMvQo
X-Authority-Analysis: v=2.4 cv=ZJ3nX37b c=1 sm=1 tr=0 ts=6a5f65b2 cx=c_pps
 a=rF5r1hn1HlY1CZmlW+R7dg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22 a=20KFwNOVAAAA:8
 a=64Cc0HZtAAAA:8 a=69wJf7TsAAAA:8 a=FzTXcQku4bcgRLNDupUA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEzMiBTYWx0ZWRfX458ALtpepRpp
 F5wwww3LEDN6on1jbNx6lfX0YpjpxA9hw+5L1Td4liGVRIaPi+QvEycIHb7AKIW+mF62NhHzvLB
 dluA4iW05BQXdlh1KJfvrjs4RbQBk9c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDIxIEp1bHkgMjAyNiAwODowNA0KPiBUbzogVGhhbm9z
IE1ha2F0b3MgPHRoYW5vcy5tYWthdG9zQG51dGFuaXguY29tPjsgcWVtdS0NCj4gZGV2ZWxAbm9u
Z251Lm9yZw0KPiBDYzogSm9obiBMZXZvbiA8am9obi5sZXZvbkBudXRhbml4LmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MiAwLzZdIHZmaW8tdXNlcjogdmFsaWRhdGUgc2VydmVyIHJlc3Bv
bnNlcw0KPiANCj4gIS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+ICAgQ0FVVElPTjogRXh0ZXJuYWwgRW1haWwNCj4g
DQo+IHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tIQ0KPiANCj4gT24gNy8yMC8yNiAxNzo1NSwgQ8OpZHJpYyBMZSBHb2F0
ZXIgd3JvdGU6DQo+ID4gSGVsbG8gVGhhbm9zLA0KPiA+DQo+ID4gT24gNy8yMC8yNiAxNTo1OCwg
VGhhbm9zIE1ha2F0b3Mgd3JvdGU6DQo+ID4+IFRoaXMgcGF0Y2ggc2VyaWVzIGZpeGVzIHNvbWUg
YnVncyB3aGVyZSB0aGUgdmZpby11c2VyIGNsaWVudCBkb2Vzbid0DQo+ID4+IHByb3Blcmx5IHZh
bGlkYXRlIGluZm9ybWF0aW9uIHJldHVybmVkIGJ5IHRoZSB2ZmlvLXVzZXIgc2VydmVyLg0KPiA+
Pg0KPiA+PiBUaGFub3MgTWFrYXRvcyAoNik6DQo+ID4+IMKgwqAgdmZpby11c2VyOiB2ZmlvX3Vz
ZXJfZ2V0X3JlZ2lvbl9pbmZvOiBwcmV2ZW50IGJ1ZmZlciBvdmVyZmxvdw0KPiA+PiDCoMKgIHZm
aW8tdXNlcjogdmZpb191c2VyX2dldF9yZWdpb25faW5mbzogcmVzcGVjdCBtYXhfeGZlcl9zaXpl
DQo+ID4+IMKgwqAgdmZpby11c2VyOiB2ZmlvX3VzZXJfZ2V0X3JlZ2lvbl9pbmZvOiByZWplY3Qg
dW5yZWFzb25hYmx5IHNob3J0IHN0cnVjdA0KPiA+PiDCoMKgIHZmaW8tdXNlcjogdmZpb191c2Vy
X2dldF9yZWdpb25faW5mbzogcHJldmVudCBleGNlc3NpdmUgbWFsbG9jDQo+ID4+IMKgwqAgdmZp
by11c2VyOiB2ZmlvX3VzZXJfZGV2aWNlX2lvX2dldF9yZWdpb25faW5mbzogZml4IGNhcGFiaWxp
dHkgY2hlY2sNCj4gPj4gwqDCoCB2ZmlvLXVzZXI6IHZmaW9fdXNlcl9kZXZpY2VfaW9fZGV2aWNl
X2ZlYXR1cmU6IHByZXZlbnQgYnVmZmVyIG92ZXJmbG93DQo+ID4+DQo+ID4+IMKgIGh3L3ZmaW8t
dXNlci9kZXZpY2UuYyB8IDQwDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0NCj4gPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pDQo+ID4+DQo+ID4+IENoYW5nZXMgc2luY2UgdjE6DQo+ID4+IC0gYWRkZWQgJ1Jlc29s
dmVzOicgaW4gcGF0Y2hlcyAxIGFuZCA1DQo+ID4+IC0gYWRkZWQgbWlzc2luZyBTT0IgZnJvbSBw
YXRjaCAxDQo+ID4+IC0gcmVtb3ZlZCByZWFzc2lnbm1lbnQgaW4gcGF0Y2ggMQ0KPiA+PiAtIGFk
ZGVkIGEgbmV3IHBhdGNoIHRvIGFkZHJlc3MgdGhlIHNhbWUgaXNzdWUgYXMgaW4gcGF0Y2ggMQ0K
PiA+Pg0KPiA+DQo+ID4gQ291bGQgeW91IHBsZWFzZSBhZGQgJ0ZpeGVzOicgdGFncyA/IE5vIG5l
ZWQgdG8gcmVzZW5kLCBqdXN0DQo+ID4gcmVwbHkgdG8gdGhlIGVtYWlsIHlvdSBzZW50Lg0KPiAN
Cj4gDQo+IFBhdGNoZXMgMS01IGFkZHJlc3MgaXNzdWVzIGludHJvZHVjZWQgYnk6DQo+ICAgIDY2
Nzg2NmQ2NjYyMCAoInZmaW8tdXNlcjogaW1wbGVtZW50DQo+IFZGSU9fVVNFUl9ERVZJQ0VfR0VU
X1JFR0lPTl9JTkZPIikNCj4gDQo+IFBhdGNoIDYgYWRkcmVzc2VzIGFuIGlzc3VlIGludHJvZHVj
ZWQgYnk6DQo+ICAgIGUyMzU4YWY1ODM4ZCAoInZmaW8tdXNlcjogc3VwcG9ydCBWRklPX1VTRVJf
REVWSUNFX0ZFQVRVUkUiKQ0KPiANCj4gQWxzbywgaW4gcGF0Y2ggNiwgdGhlIHZmaW9fdXNlcl9k
ZXZpY2VfaW9fZGV2aWNlX2ZlYXR1cmUoKSBjb2RlIGRvZXMNCj4gDQo+ICAgIG1lbWNweShmZWF0
dXJlLCAmbXNncC0+YXJnc3osIGZlYXR1cmUtPmFyZ3N6KQ0KPiANCj4gd2l0aG91dCB0aGUgaGFy
ZGVuaW5nIGFzIGRvbmUgaW4gcmVnaW9uX2luZm8uIFRoYXQgd291bGQgYmUgYSBnb29kDQo+IGFk
ZGl0aW9uLg0KDQpBZGRlZCBhIHBhdGNoLg0KDQo+IA0KPiB2ZmlvX3VzZXJfZGV2aWNlX2lvX3Nl
dF9pcnFzKCkgaXMgdnVsbmVyYWJsZS4NCg0KQWRkZWQgdHdvIHBhdGNoZXMuDQo+IA0KPiBJIHNo
b3VsZCB0byBzZW5kIGEgUFIgdGhpcyB3ZWVrLiBQbGVhc2UgdGVsbCBtZSBpZiB5b3Ugd2FudCBw
bGFuDQo+IHRvIHJlc3BpbiBzb29uLiBPciBJIHdpbGwgc2VuZCB2MiBhbmQgd2Ugd2lsbCBhZGRy
ZXNzIHRoZSByZXN0DQo+IGxhdGVyLg0KDQpObyB3b3JyaWVzIEkndmUganVzdCBzZW50IHYzLiBJ
IGNhbiBmb2xkIGFsbCB0aGUgYnVmZmVyIG92ZXJmbG93IHBhdGNoZXMgaW50byBhIHNpbmdsZSBw
YXRjaCBhbmQgYWxsIHRoZSBleGNlc3NpdmUgbWFsbG9jIHBhdGNoZXMgaW50byBhIHNpbmdsZSBw
YXRjaCBpZiB5b3UgcHJlZmVyLCBJIGRvbid0IG1pbmQgZWl0aGVyIHdheS4NCg0KPiANCj4gVGhh
bmtzLA0KPiANCj4gQy4NCj4gDQoNCg==

