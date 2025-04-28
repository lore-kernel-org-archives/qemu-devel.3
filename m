Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036B7C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 14:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9PX6-0002Dc-I8; Mon, 28 Apr 2025 10:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u9PWt-0002Cv-Bj
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 10:32:23 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u9PWq-0001Mm-61
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 10:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1745850736; x=1777386736;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=XEphJwiSVf5f+HpRVNuHf/sqfxrlo0EoeJ3f+XKTMxk=;
 b=eg9ml2j2M7ZbKi77z77p/5uBNHasxw6NymOMOF6gp2bPfMPXN0X/VlRG
 V45YhXfyoySzdwQyF2hf+h+YX5tZTkumY7ljGt2LZDZjAPFGpNpBVXr6l
 vJBdTUPv3eaK8oBNZYheBpot15Hte5P2ECyLDflgdKOQexTxIdP2tEpS/
 uRlp9aJoP68+zaE0qLehnBXLwq8opM47wA41QBtElepNEtGrfZ+HMZFqP
 ioaZ8ErYlVBtDUy2CVehxyX0L8jGHGutOR4dg8kxGW4ryzXCxwh9FBMQF
 rEvJBM/aA7BlKmXbUgiJxvia4UAHL9h/yoCeX+wwyF1uoSBgjIn6mvoN2 g==;
X-CSE-ConnectionGUID: jVEV/KIOTzaM4WEMzBSQyg==
X-CSE-MsgGUID: b3511Ic/QqOyq45iqxB3gQ==
X-IronPort-AV: E=Sophos;i="6.15,246,1739833200"; d="scan'208";a="37973800"
X-MGA-submission: =?us-ascii?q?MDFscaBRgBWO0WnIaZhMz2ZysJxbBzqSPiuST2?=
 =?us-ascii?q?ZoqKyvPxgbD9lANwOgXgpwfGVXLDTXfMGKOpYa56dQbsWVqEh3l8Hf4R?=
 =?us-ascii?q?ZgGXhhKjHRRs3DTQIEJs9vNWNYiMIdgavP8Rx0SE530MvYQfpJyxwNVo?=
 =?us-ascii?q?8ybHfpMj/AaKq/vkNauNuaCw=3D=3D?=
Received: from mail-dbaeur03lp2168.outbound.protection.outlook.com (HELO
 EUR03-DBA-obe.outbound.protection.outlook.com) ([104.47.51.168])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 28 Apr 2025 16:32:12 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+1genoJgPXDJPY5YjgQZwmx1M7rD1opCPES2MZVCC4sUuDh/eHH+7Ls8Gwzza3fbxnh9SVw45lxbbXm9e3egAAVzMS2Y/efaWLWWD751p8eX7WlilDp0qjhSt+vPFCM4jSSjNvXq7s1zj8dXVf2r8+YK9VpKWGpcIhg6h4OyysUlxPvF7ccqMBodlSTV/Xb1iprNn3LR216iKMq+wOyPsCdQVHgSTlYsxfOtHpryYcPvX0M2pncFbpO0kfRfcbAeLRPKmRfmy1W0flfz17pahUfvn1X/qwkp/oU5tBoqHSYhzzy1sBSeqB7egs+SYCnev2E1OfBccc0gt7Wey0hxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEphJwiSVf5f+HpRVNuHf/sqfxrlo0EoeJ3f+XKTMxk=;
 b=GkviyVHOKd0cTx4O3kF1PrQ+/w0zSJkS1auLXt04yIx9XAraF5qzfP9dEEdQDYtnVOohrWGRJDaFUYJmSffuuwEKgo3ydF4gDaDVDdEn1Vq5k7tXe9LpchqD8qc8oHfjC7KjyCJIoXZioHneEMJK3NdOhO84MfCeE360yGf7sWw9l+qTBm/iH4FhBzyE7WElUelraRnFYkC5BCtcXfbmNLOw/4oQNJuniWiwHGhigRUGcj/TPDE78m7kQ4EIqQDusIa2WgQNujK1TXY+PS5/N56AFP+k2SfBT3av2NrYTYdKQHFxUMGugROFTIhM1vSZyPxN72HgM+SZyJS/fIH6zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEphJwiSVf5f+HpRVNuHf/sqfxrlo0EoeJ3f+XKTMxk=;
 b=UVjRuD2Yla3rPQ0cbBPxQ6mqsJXV5kzIAeGEMKl4ZF7th6BvwIyWPRa0ASnTVk+FXiT7r3+z/UEJcP/ZJTpaOcPNQVgOWfnIguWwgGoeZHe2uc5qIfeY0pkO/fZtDjeIcywkDcpJU9GCUyIjtQFNmUiZlbic/Amr/j+BYygRl+6UF5mFh+kmHIOWIHkMhelas+yszmiJjmd6WcyBgxD9vyKI0MV/96j/QOxgmw0lisV1Nl9xXH6AUepEn/jw11QuvI9iqVnWFV7i7eKLEoYFQv38cXj1A2gP5hZENX2hiDYgqRhB2NRzIRH8njg6NigAIPYBequcLsTGLAZh2v956Q==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GVXPR07MB9728.eurprd07.prod.outlook.com (2603:10a6:150:11c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 14:32:08 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 14:32:08 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH v4 3/3] intel_iommu: Take the VTD lock when looking for
 and creating address spaces
Thread-Topic: [PATCH v4 3/3] intel_iommu: Take the VTD lock when looking for
 and creating address spaces
Thread-Index: AQHbt/wzwrZhvPrcvUqcZsB0k76GeLO4xrmAgABd6QA=
Date: Mon, 28 Apr 2025 14:32:08 +0000
Message-ID: <3972adb2-fc9b-42cc-bc9c-a1c578577c1b@eviden.com>
References: <20250428051235.10767-1-clement.mathieu--drif@eviden.com>
 <20250428051235.10767-4-clement.mathieu--drif@eviden.com>
 <SJ0PR11MB67441EF218A7D9B3D9860A1892812@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB67441EF218A7D9B3D9860A1892812@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GVXPR07MB9728:EE_
x-ms-office365-filtering-correlation-id: 143575ec-6db8-4a62-899b-08dd8661748a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZzZIMlFJeUx6UXc4b08wT1EyYTBjWXJnQk1jWU5OTmlzc2ExMGZDVnlFS0RX?=
 =?utf-8?B?dzVySHpHL1VtNmJDMG5xZW5PZ3c3SnhpOGRwMk5tWWtDQkxSaVE2R2s4NXcx?=
 =?utf-8?B?cU41b0FrZ1JWdGFGdVJrcHgzM1owNW13ZU5MbzV1WEJPaDdXU1J0dHp2UGQ3?=
 =?utf-8?B?Q3VLb3lGc3k0ZUFkUGNDRWZ4L3V1aHloZzhRbUJRL09yYjBPcU9VNG1qZXow?=
 =?utf-8?B?TTZKdkEwS0RyZVFtYXhGRUJ4a3ZacFVpR0M2SG10dlN0ejdsYlNDQnpWSmta?=
 =?utf-8?B?ZnFON1ZWVzloRXJvdHpZWVk5cC9wcWdXeExrT1ZmQTVjUXQ1eHJJampGaS9Q?=
 =?utf-8?B?cTIwSXkyVExEREJWZGtpWFZqNysxbHpUZUNKQUJpSlNKTVk1ZW93T0tTRUJw?=
 =?utf-8?B?ditIYjk3T01aRmNJNXBzbEVvWk0rUmNvYlU0L21DbCtvcytDUGN1dDRCM05T?=
 =?utf-8?B?YTAwRGJIa1MwMzZGR1dPUGVuUkdNSzZlZmZWWndkRGN4aDBoMmU1MVNTbzBH?=
 =?utf-8?B?eGlKQmlMeC82aXAzNjFSaHQvL2IvQ1lRaWpaQ1JuVFNjRnVKODdrcmJWSytV?=
 =?utf-8?B?b3gvS0VqRnY4SzRMSE1uei95dU5SaHhKdEZ4eGFYL3JRclRQb2VBRkZZMU13?=
 =?utf-8?B?M081RWJLNlBSZGZheXQ2MSt2VXA2MlE3S0F2WGpVenRhK2grYmlvMlpicVZ5?=
 =?utf-8?B?Q21PNElJTHNZTHhuQ3NpQkoweU1iMktVMEtPN1NMWG1xSGNoczBURVVhNjZM?=
 =?utf-8?B?QTlVTis2OVZYc3hSaHVmVm45NkNIVm9oOVExRHEvWkt2ZFNjVlBqRXlKbENl?=
 =?utf-8?B?aDJMMVpqNGhKNmg3Mjk3UXNkK3MrNHdTMEtmZkQ0UTdsVERjeHUwM001M3lY?=
 =?utf-8?B?TDR4dHppcUd6L0lSdUNFWFd1b3JKY3NuTjRpUGZDL0draUZiSUVxcnlkb2xB?=
 =?utf-8?B?ZDNIZmhWUWlBUTV2ZjI1QlR1MDF4NU41aW03U1psR1RBak96VE9FQ0pyd3pp?=
 =?utf-8?B?UzMrZUJ0YVg4S0U5Y29YQ01IU1lBN3FmcHloTVN2VlVpYkd6Skk4bzR3Wjc5?=
 =?utf-8?B?VDVJU0EvdFpBMXlta3QrNlpQYTRreEdUbExpL1BMZWE2T1hwRlMzYjdFNm11?=
 =?utf-8?B?S3Q2Wm5KODZ5U2JMYVpHam1Pc3lsdHhHSmFwZzR3ODAzL25OV3EwOGlXNysw?=
 =?utf-8?B?NFdTTEgrcmRjWW9qQUJHZytkZnF5cFY5QzVEd2NUSjN6OC93VXR3dGw3TVRE?=
 =?utf-8?B?VHRaZlFHblE5TCtwMlFTSHM1M2xFdHVTMHpJelJoczg5R0w5VXN6SnJsN2pD?=
 =?utf-8?B?U1pIOWtDSU5IQmIxdUxQZ0NxQU1SZzhRN1VMMmJzUkRKT2l6R3ZLNkkrRzd3?=
 =?utf-8?B?bDQ0TDBsa1pwOHBMclJod3M5TU9uVVVjSnRLeGR1bmZqTTIrRmdMelh3SEZl?=
 =?utf-8?B?QTBlWG9EUUUzMldMbGI5dUpVRVhXcFY3Q1B3dnlKUVdRWHpuSGxET2piOWRI?=
 =?utf-8?B?UXlkTlBtdDhMWjdTMitDSzg4QmlZd0tMbVZyWnpZMlhyZHl0eG45bUhBSDBw?=
 =?utf-8?B?V25FWEFYbWtJTmM5clBrRUkwakEyMHNzU00za1E1c0gvNUlETEtlUEhqdSth?=
 =?utf-8?B?SWRUdnNlZkZnOXl6N0lFWDlnVXYwS0w3eU9wMW01ZVVZdE9iOFE2YVcwTVg0?=
 =?utf-8?B?VnI1TlY0cyt2QTdYRjY3OVNVdkdhZGE1WFBrcHJobkRKZURwbWdtUmY4MlR1?=
 =?utf-8?B?MzVsYWNuL0E1bjBYUkxNNG5IemZVOXF6TUhlMVZYL0xORWp3NlRtS09WSlFr?=
 =?utf-8?B?SHdVK25WbDNpZ3FDcEM3RUtSVEErWERZUXZtODVUMWY5Ui9QQVdUOTlvd3Zz?=
 =?utf-8?B?VGVmM3VpbzZFRTdxL04wdnRrMGZXMTdVd2tWckVJRHVRU2dPRjY5QTY2WXdD?=
 =?utf-8?B?OVhuL0VDTGZad2VOTXRSV0NRc282bk1EUzcwTElNSndSMEoxMVZqK0VxWlZF?=
 =?utf-8?Q?sOPNH5s3+aYFSk+OoUJqk1O/Hxs/iY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzRlb2hSTjlEUHZ5TFhGNTgyMmZabjdFblljbSt5VUJCY1AxZTZSWFhEK3NX?=
 =?utf-8?B?bDZuZ2FVL0d2dVhXRE9hV3ZEQU5aWlV0TzFBeUpPV29WSVN3OHpVWkJReVBh?=
 =?utf-8?B?TVE2MkZ6V09HY2tvWFQ2b2pOSnh1V0xjRGZ3b3p4WHoxQWdjbUorSDUxWldL?=
 =?utf-8?B?dFRRcElxYXYwTkFjWkdQM0h0NVZHcUh5NjlaR0l1dnNxRFdHUjBXQ00vSUsr?=
 =?utf-8?B?RXNVUEswVG5VcTVqNjhWYUpmT1VqeVNnMlFCcENIaEY3Q1krVTJQWmhlODZr?=
 =?utf-8?B?MGx6VXFYaWpyQjAyRFVERmw1SEpoL1J4QndtMmxtWUpmYzVsQS9ESmx1WjN1?=
 =?utf-8?B?dUZDdytBVHNFVDdUbzFtcDZXQmhDS2hxeUczVTloMXpjL1ZXRHFwRjBDd3ND?=
 =?utf-8?B?cmxicTNBMW5XNkcwWDI4S3k5SkxBQnltdHhhc3YzMTREY3Y2WllCc29JVWM5?=
 =?utf-8?B?WStXY2FoTDViODVEYStqenlPZ0cycUVvaU5tZm0xUG1BUGtVYTM0dGRQNkJM?=
 =?utf-8?B?eDJOa1RTc2lJOVJ1cUlNUFV0R3BjMWdWUkZRK1BlR3AyWFJTQWRCWnRxOWdx?=
 =?utf-8?B?RzBZemp2dVJZNCtySy9FRUF6RW1zb2k1RUN4SnlpVHBIeWlMTEdINmJVWmhW?=
 =?utf-8?B?dFYrN0VHWmJGcmhtUUtuUXBGYnZ2OGlIMk0rQnBtQkNzNldPM25XdUlHbVpD?=
 =?utf-8?B?eUI1NnFvNkF2R1FQREYrZURDYWlCU2NlZDBkckZXTWVYQUI4RVduK253Qllh?=
 =?utf-8?B?TnBmYTk3RUZIVWxER01QNEdRN1hRWjRrSTY3Qks1QnM3RGM4OThFanF4WTFH?=
 =?utf-8?B?b3dQbWxxclNCRWZlUk9LelNta3dzTmpJeXNJZW5HemprZTgwVkFDQ093VTMx?=
 =?utf-8?B?Nk9GM0JtazlMNnZZR0JPcllXcjJaSW13NmY2R2JlMmlkU3FMeUpQa3FwZ0Mx?=
 =?utf-8?B?K0J5ODdsTEhmbzVhbnZaUWFTV0hsMzFtTEJQaHBENkZNQVJqeU4xU2hFRTBu?=
 =?utf-8?B?ZWVLU1lqNU5WUGdpa2hRSmhBdWltUDBqY3pwVmVYTEVmanNsNTRGUTYzdXNU?=
 =?utf-8?B?Q202ckF3VDdJV2hHV2Z1SDR3RXc2WHBBZ2xFRytPanUzTnlVWmp2MG1xRHNH?=
 =?utf-8?B?WFhoaTUvbXcxcnFiY1pkVFh6OWRjT09kRHBiZzQwZ2tKb0JYNTVtSS9MYTFv?=
 =?utf-8?B?dC9MU3R0R2NOQ2dGMVFFajA1Zk1kN21JT2hQK1k1MXJKcjRBZy9BRWdPOXdk?=
 =?utf-8?B?SjgzRjI2Ykh5Sm1Fa2MrbmFvNnQxa1JkOUl1MkdscDhkSnhYZ1NGUkY0NXds?=
 =?utf-8?B?WjFhbFFQN05SYkJFTjZPbCtZWXZtMWJKZTFTaEJwbjhIOHlQZDhTam1NbmtM?=
 =?utf-8?B?SHVmT0djZStZNmN3T1p5bE94YnNzd2o3cDNvTjRPRGVzNVZjZ3RlcmtnSFMx?=
 =?utf-8?B?dWRTOHJVNlo0Qkd1dVpLWHAyNHRtaXQxMm8zNGdYR2JOeVF4eE5EbkpRR1pv?=
 =?utf-8?B?dEt0cG1WeGxhM01xcHd5bm5rMnY1U0tCajNRbGVvWXRUYlRpcWpSL2NRK2Rs?=
 =?utf-8?B?WFVabytDTU42dER2ZnVsbXJoOXlWTnZPMVVlSE16RzdWbEN6TFlGY0lGazlW?=
 =?utf-8?B?ekdGd3N2c0JiVHI5NmVLWklYSXRWNDJqYXFEZnVid1FRUmRONVlJb3llRlRQ?=
 =?utf-8?B?dTUwR2lJQ2h5ZWh2T3lXTkNObXc2WG1QQmlXQ1VzcXhIV0IxRGxqNGppd2dH?=
 =?utf-8?B?SHQvU2kwWjRiSDhKTkpjajAxK2NSNHlOODkrb2Eva3VVV09LamtxS0FTb3h4?=
 =?utf-8?B?RDUyb3hYMnB6Wm5Nb2hmclU3WFhTRDl4Zjc2YklzMXY0Z2FyajV4M0lxeldO?=
 =?utf-8?B?V08rdUFVSkEvbVQvaU13ZE5hazBlRHdJdUZNc1Nic0NBS1QvMWtKYzJWQis5?=
 =?utf-8?B?R2xYRzJIVlV2MmpCdWhMUVloTlhYQ2VMYkxyM2FUcVRPYzdHd3c4UkV6WkFH?=
 =?utf-8?B?VVRuZ01QQy9JN3RhcC9lWnlCa3FuK1U0QTFmRTFvTENGMGZINkZaMTBZMTFv?=
 =?utf-8?B?dGowa1NGMS9vWlZDTlFrTTc1TTFscHZnQzRubWVRaU5UZU1qVmlzUHBxOFFN?=
 =?utf-8?B?UE5VeXluOEpBbXptVDREb1ZZMExDUzlzd0o2QW1tTjI1eDhDNXZpcE00bm5p?=
 =?utf-8?Q?B0/Ml0BvkrT7pZ11PNFVm1I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37D9D7E5B56DBC4B905C2AD19549B25B@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 143575ec-6db8-4a62-899b-08dd8661748a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 14:32:08.1411 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LE82Ok7QMqWzPdq8KqwpzeSD01TD16whLSaLjYgmVW8yuDwaDOtvypPkQuJqHNl1EFLMZKAW4dVj9kY8BazVKHEavQlnOlGZ8ZqLd0ZysjEUf72gBp5+V/dV8NUzba1N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9728
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

SGkgWmhlbnpob25nLA0KDQpPbiAyOC8wNC8yMDI1IDEwOjU1IGFtLCBEdWFuLCBaaGVuemhvbmcg
d3JvdGU6DQo+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50
cyBvciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNl
bmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiBIaSBDbGVt
ZW50LA0KPiANCj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PiBGcm9tOiBDTEVNRU5U
IE1BVEhJRVUtLURSSUYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPj4gU3Vi
amVjdDogW1BBVENIIHY0IDMvM10gaW50ZWxfaW9tbXU6IFRha2UgdGhlIFZURCBsb2NrIHdoZW4g
bG9va2luZyBmb3IgYW5kDQo+PiBjcmVhdGluZyBhZGRyZXNzIHNwYWNlcw0KPj4NCj4+IHZ0ZF9m
aW5kX2FkZF9hcyBjYW4gYmUgY2FsbGVkIGJ5IG11bHRpcGxlIHRocmVhZHMgd2hpY2ggbGVhZHMg
dG8gYSByYWNlDQo+PiBjb25kaXRpb24gb24gYWRkcmVzcyBzcGFjZSBjcmVhdGlvbi4gVGhlIElP
TU1VIGxvY2sgbXVzdCBiZSB0YWtlbiB0bw0KPj4gYXZvaWQgc3VjaCBhIHJhY2UuDQo+Pg0KPj4g
U2lnbmVkLW9mZi1ieTogQ2xlbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRy
aWZAZXZpZGVuLmNvbT4NCj4+IC0tLQ0KPj4gaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwgMjggKysr
KysrKysrKysrKysrKysrKysrKysrKystLQ0KPj4gMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxf
aW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gaW5kZXggYjc4NTVmNGI4Ny4uOTMx
YWMwMWVmMCAxMDA2NDQNCj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gKysrIGIv
aHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBAQCAtNDIwMywxMSArNDIwMywxNSBAQCBWVERBZGRy
ZXNzU3BhY2UNCj4+ICp2dGRfZmluZF9hZGRfYXMoSW50ZWxJT01NVVN0YXRlICpzLCBQQ0lCdXMg
KmJ1cywNCj4+ICAgICAgICAgIC5wYXNpZCA9IHBhc2lkLA0KPj4gICAgICB9Ow0KPj4gICAgICBW
VERBZGRyZXNzU3BhY2UgKnZ0ZF9kZXZfYXM7DQo+PiArICAgIHN0cnVjdCB2dGRfYXNfa2V5ICpu
ZXdfa2V5ID0gTlVMTDsNCj4+ICAgICAgY2hhciBuYW1lWzEyOF07DQo+Pg0KPj4gKyAgICB2dGRf
aW9tbXVfbG9jayhzKTsNCj4+ICAgICAgdnRkX2Rldl9hcyA9IGdfaGFzaF90YWJsZV9sb29rdXAo
cy0+dnRkX2FkZHJlc3Nfc3BhY2VzLCAma2V5KTsNCj4+ICsgICAgdnRkX2lvbW11X3VubG9jayhz
KTsNCj4+ICsNCj4+ICAgICAgaWYgKCF2dGRfZGV2X2FzKSB7DQo+PiAtICAgICAgICBzdHJ1Y3Qg
dnRkX2FzX2tleSAqbmV3X2tleSA9IGdfbWFsbG9jKHNpemVvZigqbmV3X2tleSkpOw0KPj4gKyAg
ICAgICAgbmV3X2tleSA9IGdfbWFsbG9jKHNpemVvZigqbmV3X2tleSkpOw0KPj4NCj4+ICAgICAg
ICAgIG5ld19rZXktPmJ1cyA9IGJ1czsNCj4+ICAgICAgICAgIG5ld19rZXktPmRldmZuID0gZGV2
Zm47DQo+PiBAQCAtNDMwMiw5ICs0MzA2LDI5IEBAIFZUREFkZHJlc3NTcGFjZQ0KPj4gKnZ0ZF9m
aW5kX2FkZF9hcyhJbnRlbElPTU1VU3RhdGUgKnMsIFBDSUJ1cyAqYnVzLA0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnZ0ZF9kZXZfYXMtPm5vZG1hciwg
MCk7DQo+Pg0KPj4gICAgICAgICAgdnRkX3N3aXRjaF9hZGRyZXNzX3NwYWNlKHZ0ZF9kZXZfYXMp
Ow0KPj4gKyAgICB9DQo+Pg0KPj4gLSAgICAgICAgZ19oYXNoX3RhYmxlX2luc2VydChzLT52dGRf
YWRkcmVzc19zcGFjZXMsIG5ld19rZXksIHZ0ZF9kZXZfYXMpOw0KPj4gKyAgICBpZiAobmV3X2tl
eSAhPSBOVUxMKSB7DQo+PiArICAgICAgICBWVERBZGRyZXNzU3BhY2UgKnNlY29uZF92dGRfZGV2
X2FzOw0KPj4gKw0KPj4gKyAgICAgICAgLyoNCj4+ICsgICAgICAgICAqIFRha2UgdGhlIGxvY2sg
YWdhaW4gYW5kIHJlY2hlY2sgYXMgdGhlIEFTIG1pZ2h0IGhhdmUNCj4+ICsgICAgICAgICAqIGJl
ZW4gY3JlYXRlZCBpbiB0aGUgbWVhbnRpbWUuDQo+PiArICAgICAgICAgKi8NCj4+ICsgICAgICAg
IHZ0ZF9pb21tdV9sb2NrKHMpOw0KPj4gKw0KPj4gKyAgICAgICAgc2Vjb25kX3Z0ZF9kZXZfYXMg
PSBnX2hhc2hfdGFibGVfbG9va3VwKHMtPnZ0ZF9hZGRyZXNzX3NwYWNlcywgJmtleSk7DQo+PiAr
ICAgICAgICBpZiAoIXNlY29uZF92dGRfZGV2X2FzKSB7DQo+PiArICAgICAgICAgICAgZ19oYXNo
X3RhYmxlX2luc2VydChzLT52dGRfYWRkcmVzc19zcGFjZXMsIG5ld19rZXksIHZ0ZF9kZXZfYXMp
Ow0KPj4gKyAgICAgICAgfSBlbHNlIHsNCj4+ICsgICAgICAgICAgICB2dGRfZGV2X2FzID0gc2Vj
b25kX3Z0ZF9kZXZfYXM7DQo+PiArICAgICAgICAgICAgZ19mcmVlKHZ0ZF9kZXZfYXMpOw0KPj4g
KyAgICAgICAgICAgIGdfZnJlZShuZXdfa2V5KTsNCj4gDQo+IFdlIG5lZWQgdG8gcmVsZWFzZSBt
ZW1vcnkgcmVnaW9ucyB1bmRlciB0aGlzIHZ0ZF9kZXZfYXMgdG8gYXZvaWQgbGVhay4NCg0KDQpJ
bmRlZWQsIEknbGwgaGF2ZSB0byB0YWtlIHRoZSBCUUwgYWdhaW4uDQoNCklzIGl0IG9rIGZvciB5
b3UgaWYgaXQgbG9vayBsaWtlIHRoaXM6DQoNCnZ0ZF9pb21tdV9sb2NrKHMpOw0KDQpzZWNvbmRf
dnRkX2Rldl9hcyA9IGdfaGFzaF90YWJsZV9sb29rdXAocy0+dnRkX2FkZHJlc3Nfc3BhY2VzLCAm
a2V5KTsNCmlmICghc2Vjb25kX3Z0ZF9kZXZfYXMpIHsNCiAgICAgZ19oYXNoX3RhYmxlX2luc2Vy
dChzLT52dGRfYWRkcmVzc19zcGFjZXMsIG5ld19rZXksIHZ0ZF9kZXZfYXMpOw0KICAgICB2dGRf
aW9tbXVfdW5sb2NrKHMpOw0KfSBlbHNlIHsNCiAgICAgdnRkX2lvbW11X3VubG9jayhzKTsNCiAg
ICAgQlFMX0xPQ0tfR1VBUkQoKTsNCg0KICAgICBtZW1vcnlfcmVnaW9uX2RlbF9zdWJyZWdpb24o
JnZ0ZF9kZXZfYXMtPnJvb3QsICZ2dGRfZGV2X2FzLT5ub2RtYXIpOw0KICAgICBtZW1vcnlfcmVn
aW9uX2RlbF9zdWJyZWdpb24oJnZ0ZF9kZXZfYXMtPnJvb3QsDQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBNRU1PUllfUkVHSU9OKCZ2dGRfZGV2X2FzLT5pb21tdSkpOw0KICAgICBt
ZW1vcnlfcmVnaW9uX2RlbF9zdWJyZWdpb24oJnZ0ZF9kZXZfYXMtPnJvb3QsDQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAmdnRkX2Rldl9hcy0+aW9tbXVfaXJfZmF1bHQpOw0KICAg
ICBtZW1vcnlfcmVnaW9uX2RlbF9zdWJyZWdpb24oJnZ0ZF9kZXZfYXMtPnJvb3QsDQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAmdnRkX2Rldl9hcy0+aW9tbXVfaXIpOw0KDQogICAg
IG1lbW9yeV9yZWdpb25fdW5yZWYoTUVNT1JZX1JFR0lPTigmdnRkX2Rldl9hcy0+aW9tbXUpKTsN
CiAgICAgbWVtb3J5X3JlZ2lvbl91bnJlZigmdnRkX2Rldl9hcy0+aW9tbXVfaXJfZmF1bHQpOw0K
ICAgICBtZW1vcnlfcmVnaW9uX3VucmVmKCZ2dGRfZGV2X2FzLT5pb21tdV9pcik7DQogICAgIG1l
bW9yeV9yZWdpb25fdW5yZWYoJnZ0ZF9kZXZfYXMtPm5vZG1hcik7DQoNCiAgICAgYWRkcmVzc19z
cGFjZV9kZXN0cm95KCZ2dGRfZGV2X2FzLT5hcyk7DQoNCiAgICAgZ19mcmVlKHZ0ZF9kZXZfYXMp
Ow0KICAgICBnX2ZyZWUobmV3X2tleSk7DQoNCiAgICAgdnRkX2Rldl9hcyA9IHNlY29uZF92dGRf
ZGV2X2FzOw0KfQ0KDQouLi4NCg0KcmV0dXJuIHZ0ZF9kZXZfYXM7DQoNCg0KPiANCj4gVGhhbmtz
DQo+IFpoZW56aG9uZw0K

