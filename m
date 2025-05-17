Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347CAC54754
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 10:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGEiP-0006NT-Qr; Sat, 17 May 2025 06:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marko1616@outlook.com>)
 id 1uGEiO-0006NJ-13
 for qemu-devel@nongnu.org; Sat, 17 May 2025 06:24:24 -0400
Received: from mail-australiaeastazolkn19011027.outbound.protection.outlook.com
 ([52.103.72.27] helo=SY2PR01CU004.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marko1616@outlook.com>)
 id 1uGEiJ-0006a0-WA
 for qemu-devel@nongnu.org; Sat, 17 May 2025 06:24:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvDY+UbdgpC49N4QoV4MosuNsFzeMAHC/X2qiMDI2QAzMbMtU0Xx6F9EBXCiNkdLfaJS8M1ndplSqR8jVKTSYX6IqvV9z7hDcSTlNuZhQ2gjOnbfH4D6C/Io4kVwFzGAVE7AGHgDIjHTigO9I2NYcpH8nIzj80ynZDJXrbSNgJ5DgitFIvd6VNcactx1PqjFR9MspUNMpD2wGUM9fUX73hzV+eh+dkp2q7Xfn97n8U2phBqDvM+Cj12kefaOGNXymXka22+Mk8C0yZR/fMNxqGHJHMdlWVEYrmoaiE1bDDILa9FkZR2ZfiNitZiMJuuTKbDYXjCHHNmn+dUFTh0dlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0myVDnER+/RYj+ARPg1UH14zQn5t0AlFj/qHZPAdoPg=;
 b=h15U2LTnQC5+/1hxqSgTEjcwgRP9bsidvSE3DGnxCQWu6/4mGDIiE4XPF1c6INfd17sMJOrJaxvWr7hOuucgOwLiIS+Zq3/nliClQienBV6U5JXKyCUvOqd2Zo2/ifuuezPlramxnJz8b98k0KVW9q4ySfW649U/1CTQXbYBsdIArLrGBm1Pbwu1l2YjmFYkFmZdHzwP7xuZ070XNNVg49PpfQpnsdM3Ugesn1rlrcLeo/w7PX6dITbR+lyszcDlcsMl/ztDPg8zH5/bqtm3b6xOtUvuLxT5JTdff1tIn3inbYU4CiGrcZtAAVT600v/dJ43BsF2WWCU/cNJr/m9GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0myVDnER+/RYj+ARPg1UH14zQn5t0AlFj/qHZPAdoPg=;
 b=YCbORM0Kkr4C/b9iuyACPSEPiQXiRH5DS9HbRdTcuyU6JgChxJ/odbfAGkOs5C4OvONblLOjmqwPNvy33B2hXCPHO5yvKMFSV187AFeJx0NzzuzG5JDxsnpMbT6pIlCpaMm92/c2auq5OpIQMNTeACA0DDOZeRcdLoItUEmb1KpWMQcQulBDASGuV3gQj9v4pqN5LJfKQMJzIcNGjw/0ZyTVX7n+4Evxr69k9vfitmA0idCOYDUtu1jsjzIooSaJ1K/LPezyQ1YybdvaDENZqWUmGCLKks5sykyQAtV+onHQWNRf+hdJb9hoqabC7Jl1frptPx61zKvO91f5ZreJ/Q==
Received: from ME3P282MB2793.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:13e::12)
 by MEYP282MB1830.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sat, 17 May
 2025 10:19:10 +0000
Received: from ME3P282MB2793.AUSP282.PROD.OUTLOOK.COM
 ([fe80::79ac:1f5e:43da:5460]) by ME3P282MB2793.AUSP282.PROD.OUTLOOK.COM
 ([fe80::79ac:1f5e:43da:5460%4]) with mapi id 15.20.8722.031; Sat, 17 May 2025
 10:19:09 +0000
From: Liu marko <marko1616@outlook.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "erdnaxe@crans.org"
 <erdnaxe@crans.org>, "ma.mandourr@gmail.com" <ma.mandourr@gmail.com>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>
Subject: [PATCH] plugin: Add callback support for vCPU hardware and
 architecture-specific interrupts
Thread-Topic: [PATCH] plugin: Add callback support for vCPU hardware and
 architecture-specific interrupts
Thread-Index: AQHbxxRfUgfCT9DQy0uWUr6qXW22qQ==
Date: Sat, 17 May 2025 10:19:09 +0000
Message-ID: <ME3P282MB27933F3CA48FA7C7EB0BCBBFA692A@ME3P282MB2793.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME3P282MB2793:EE_|MEYP282MB1830:EE_
x-ms-office365-filtering-correlation-id: b74c17c5-4829-451c-7c15-08dd952c4361
x-ms-exchange-slblob-mailprops: Om8TgR6f4EDb6Nw8821nJiyawZ3Rt9ILZY9VwQbnt4QK4dNo4fpI/MRxErfplSb3kfuxdILTJ+HAiqBJFjWsVV0PRBnFQp/ha0fVYdfHgxpmxSyqjxWS14XBgDfYqqb+QOc25cgPY7A/aDu2wrOHsNHC9j5nPyD3MtkN5V/DEzI3sl+falGYxun4otlhomIbidpE+zIuJTqKTlKl/PqNoiZMbn8YaibzLHXKnNVtkMOr/WFmHN8RRgb6DhCcc/wIGdheO8hWZjsLvIkFB1WCT8gFUQmWzrcikbf+as/Z9K7a6fWRTGjxSJFBQSpqNJWrD0WAiQfuBw3kMXuI107NIBXucau0i77hzDWZp+VrPNZfURn8hL2sp87o81Ppgy8ySWi78hi0oRc4KeNUrk9/plPjfZg4niccj8PxeNLvqxhcFbEXRJbJHcmUJ77OHvxk8/5K1GQJihYUoXyNIlef/kdY/CWmjz+jKlKIPnzrzoiKzTk7IcM5RCHyRijCmEEZbPABSO5FVEOUxDahpb4tmvlWhmCV1oglHAshaB07JUN8ShXU4DRp8Ng4h/doPurKKqIdgNPTRl75+ELT8YEAxei2tzv5CL8FKLLbjG4nU8kn8wZ5fb9O/UlXEy+PGVmmLyjBVSyAgygMwLIR6bBLDfU5O4eA04fP2S8mNTtid++6UVkpX6BmbxVz/kDQZ2kK8W9/0+/aVCJRb7CLZ/jilDyxd1wLnJTXLIlItEFS5BPf+KODF5vK9q6VHW/1XJFWrYIEQKIi/T1enrkaSocWAcgc91W+/gT50mDVeIquPJywMH17dlgFa+JW1gSUjZ0jhT9gEUMXNYgrMMcLZvG6gsoTgzsUwImG
x-microsoft-antispam: BCL:0;
 ARA:14566002|461199028|15030799003|8062599006|19110799006|8060799009|41001999006|5062599005|15080799009|7092599006|102099032|3412199025|440099028|10035399007|12091999003;
x-microsoft-antispam-message-info: =?gb2312?B?RjhmODh6YmZ0M0lxZDdrT2tQbkJNeFE0WGZNY1MrOWNlbmFNSFdnajRQS1R6?=
 =?gb2312?B?U2EzMWpNNG1hOTk3NUgrTFVGcytIQ0hENE1icEE0Q0hMakF2OVpkTG5oaXZC?=
 =?gb2312?B?QnpXeGtSVWxHUVM2SEd2cGt0NlprWlRab2hVdXFPcllTRngreU1NM3RVVklJ?=
 =?gb2312?B?Z3JKSVJHZVpSODhteFIvdlVpcWFJNStPM1FhNkZweFZIZlJKNEYrLzR1K2JB?=
 =?gb2312?B?QXZwbXpmRDdZeCtKV1R3VTc5eW0zcU9NRG5DK01zRjJQYXFnTzlGdTFQVWtY?=
 =?gb2312?B?ZEhxUE51ak84Z2s2eWJsdEI2dzhOMzNrMW43Z1B6d1Rja0s5L0dqMG02b1B0?=
 =?gb2312?B?S05sdkRBRDBQS201bU94eWw2MDFocmVCdUpoK05qZ2NSWXRCQk1BNUIzdjVs?=
 =?gb2312?B?QmRhTE1SVHV1eG15emhSOHNiV01GMk41RVlGL1ZKQzVwancrbkFsQ1VHZTQx?=
 =?gb2312?B?QXpGS0h1U3FaRjBkSEJSMmcxVTFjODFKY3ozcFlIbWhtQ0phMk9Ia1JLa2R5?=
 =?gb2312?B?T0hOVlhpbEZoRHcvS2VKOU1LNXB3S3pLc3Zzdml3dG1OcTltV3NOUjNrZXc4?=
 =?gb2312?B?T092dm15YlNScStWa1h2RkN0Sko2WlpzYU1tUUFSNWhpZWN3MmtqL1VMcitF?=
 =?gb2312?B?dzk5NVg5eTdtbVlSOTgxRElXQ1Axc3hxdWYwVlFBSm0vaFROOHFmNWZWSHdJ?=
 =?gb2312?B?Uk4wdGMxRlhFRkZpZll3TUkyZm5BSGxLL2thQ1JvQ1BORmRTVkcvUE1WN1lU?=
 =?gb2312?B?Q0NIOWMyMUVNTDcwSXcvNXVXZUNuMWk2M1M3Y0lSYVliRml0dmczbHkxeDdw?=
 =?gb2312?B?TjlHaVJ4MHY0bkRZdmx4b0c5bEpPNmwrM28wK0h1UndaemZaak9QM2llTXBE?=
 =?gb2312?B?WW1sRE9DUEQ4KzNJVC94WncrcS9SUEJ4dEtkZzJldXFVNVhtZDhOMHFHcXpr?=
 =?gb2312?B?bCtNdzRNeDB6MkFEQ3BDOTcyUTRnYlJWK0E2b2t6ZFI1SUJPaCtISG1VWFFj?=
 =?gb2312?B?RHFSS09ud2dZR21ENUZmMGdLL3FVOUhGaVFFYVk4a0QrU3BaNzZBQ1pxVmdL?=
 =?gb2312?B?SDBwdmZiVjJhbkhVOFF3d3lwMTR0aU0rNHF2aU9YMm9mbUJjMXFnWDgzTUUx?=
 =?gb2312?B?ZEUwNGFabHhWWUpOamRUQVpLRWlOc0hBTC9VRlVCaHVkSzlaRzdpNVh1T0dx?=
 =?gb2312?B?NzY4clcyaWtMRW81MG1WbGJMRFhFYWtxTG9uUGxMRlN6bFFiZUlzVjJWeG5n?=
 =?gb2312?B?dmQvUnFEc0VkYVorR09tb2UyWWVCM05Rb3BJNTBXcXNoc2Q0T0VCbWVGZ2o3?=
 =?gb2312?B?M1V2QVZrdTF5OGJSRGN2WldpeHVWV0dUSHducjExM1dFK3FUNFY1NWUvelFV?=
 =?gb2312?B?cWJCRU5ZUldWYW55Ymh1aWdUb0dzQzhpblZETzdFaDRZV2NGSDNtMWx4VmRw?=
 =?gb2312?B?SGJnMmJSanhnQUtpaFlvTlAvRktadXRzSHY1UFI1WkpLbC9PWkxrc2IvcXJJ?=
 =?gb2312?B?OE9iaURQUmY3VFhYM3MweU9RV3pOYmU3Y3FUMlZ4anBGdWh2WDdMRmNDUXk4?=
 =?gb2312?B?cTNDMGg2UmhBSjN4b1lqQ291a3FOR1dDMjh5OE14eUplT2ZQWVRaUk9EQU54?=
 =?gb2312?B?aVlqNkp1c1dzeCtjcTNHS0tLQlFrK2R4ZHgwNHJiMjV5NCsxdGRSNDVGSzdS?=
 =?gb2312?B?b3BhTnAyZ0pIdXJ1QVhKeHFGTC9sMXZkREJJY0REWWZSZzROQ3htZWdPRjd5?=
 =?gb2312?B?OGpTUS80WmxKKy85RVB6anVLTGFueFEzNmZaNXBEV3hmWWxhNWFTZU8vUUVy?=
 =?gb2312?B?QVQyZFUwbm9xYktPLzVVdz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?OVBvaHp1OTFNRUxmcGsreUExclgvM21ZL2V0R0NCZU5IRTJjaDRtN3pjcFlM?=
 =?gb2312?B?di9XTXZHdXBUOVhrZnhzNzVCZDNOK0VVK0xSQWdwbEZBUWVnT2FBcEdLNG9J?=
 =?gb2312?B?bFlWV0dEM3dCdkFJMzVTVGdXVVNPQnNLVk9nQ3BnZjZiZmt4cm9HWUNFWXRy?=
 =?gb2312?B?cFNFeHJlcGlQSm1RZjJwYlgvZjVEUDMvNUh4MkMzNHhVb1VyaWZDMEVCN2hR?=
 =?gb2312?B?ZTI1azVsY0lKYW5OQzNUd29jb0ZXQ3RTVVdpbnpCY2hVbmo3TGJsaFpCaWdx?=
 =?gb2312?B?cHR3UzZLVTRqV2xBZXhNUUwvcC9WRW82Wm9kY2svc1RtdFd4d2srNXZaOHIx?=
 =?gb2312?B?QmdlcVk0RStmbFB1R2NhNzFEei9FdDRJb2Q1Y3lNVFZvOUpXWG1WU3puNVVo?=
 =?gb2312?B?U0xxL0pseDBlRFZPaVg4UFduSmxNbXh1d3lMVHR1ajRiMWFLNEVKK3VxQTVq?=
 =?gb2312?B?UmcwL0dyZmRDSjA5Tnk2Y1dFNmdmMktMRFhpaEczTnZadWhpclZaeEdBMysr?=
 =?gb2312?B?M2lvdk4rbUViRjMwWnZ2RTJNcEhGTGZ3VTRqNTVvK1VZWFIzWGhFR0RTSWNC?=
 =?gb2312?B?T1JHZEZJVWYzT081RHgrVEZEaXQ4MmJtc3ZLNFBpZE1WYUxZOXdCVEhaNWZh?=
 =?gb2312?B?eWszU1pDcmZzWFRCWVpaR1BvM3MvQlY1M3dLWU5BVmczTFFENXR4b2tTZ04x?=
 =?gb2312?B?eFZ1VFkvNTlEZGtOZWgzdmZJL2twejZ3Y1N0N3YvbUw3c0tMckxZczNHRXFZ?=
 =?gb2312?B?VnplZVdtdWhWckpEdmZBVUxDbUhFV2xHajduc283WHVmYWoyYnl2bEVRWkVu?=
 =?gb2312?B?UGlrTHVOMFJaY1Y4L0xXN3ZpQS8zWUdKdEZLS21HbWJxOU5xNkpmUGhBeSth?=
 =?gb2312?B?WVpaS0M5VDRHQVBSYjNNemVrNHVmaDRoWVNCL3lDYUlhMlFFd25BTHllOVRo?=
 =?gb2312?B?R2lqMjRYVGlGeitGS3lxaW1zRll1TnlVcDM2ZG9CaEtQd2tmOFlYSUZBOUc2?=
 =?gb2312?B?cXdzRThvL2pxOE9wbWE4R2NORC9xOTZSWHVVbU56bHR6NXRKWXMxMXFWOXUw?=
 =?gb2312?B?NXpreTI4aURNZDBoZEkyaCtoK2luaDNDR1RpNEVUeVpYdkVHR0Y1ajh4bjAr?=
 =?gb2312?B?OUllcEl4eHMvL2RBaXBnRWJrdlJzM0Qzc0JJbHFoaCsvNXJYbFZxcmsxa2gv?=
 =?gb2312?B?bkNGUmYxQitwM0poZDVpQ0RSYjI0ZEhsM3M3SjVKSVdzK3dVUUxMM0EzWGNr?=
 =?gb2312?B?aDc2d3RLN1VLTldVd00wVUkrRTJYUDMrc2IzTXcxbXJoT1lDRXhzRDhMYTlp?=
 =?gb2312?B?b0t6WHJ5b3gxNDJWR2hGSDE3eVdHRXo1UHQ4Zlh5OXdORWdWOE53enFkMDVs?=
 =?gb2312?B?eUh2OGp6TktRN0tHNUpxc204M0gyMlZTWHYyRzB5RTJGb2JlTlQ1V01DU0t4?=
 =?gb2312?B?dHhlTFpOcjJmZUZjS0hFRlRzRTF1N3NtNCtvQWRhcUhVK3JUMEJyWGs4STVs?=
 =?gb2312?B?SEdyVW83TVhSR25vckVETllNbmlrY1RKQzR3T29MbEZoSWdMTGZlTi9RTVdG?=
 =?gb2312?B?TTdnbEFZVEd1OE9RVkZvdUdTSG1zNzNnempPazBYbTg5MUV1NHJVZ3Zxd0Rp?=
 =?gb2312?B?TDdWRnpDOFRTOGhYbkV6VnpRb0FWTHo0WGZkekNrSjc0MnZURzdPWThOVDd2?=
 =?gb2312?B?Q0o1cWc3SjV3NXE3SkhEZ21HejVYcXBWdEpRRXJEMWZhSXM5SWxINTdIOFpK?=
 =?gb2312?Q?sdBh2gqgvRne0q+2/4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_ME3P282MB27933F3CA48FA7C7EB0BCBBFA692AME3P282MB2793AUSP_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB2793.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b74c17c5-4829-451c-7c15-08dd952c4361
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2025 10:19:09.7628 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB1830
Received-SPF: pass client-ip=52.103.72.27; envelope-from=marko1616@outlook.com;
 helo=SY2PR01CU004.outbound.protection.outlook.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--_000_ME3P282MB27933F3CA48FA7C7EB0BCBBFA692AME3P282MB2793AUSP_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SW1wbGVtZW50ZWQgdGhlIGBxZW11X3BsdWdpbl92Y3B1X2ludF9jYmAgY2FsbGJhY2sgdG8gYWxs
b3cgcGx1Z2lucyB0byBvYnNlcnZlIGhhcmR3YXJlIGFuZCBhcmNoaXRlY3R1cmUtc3BlY2lmaWMg
aW50ZXJydXB0cy4gTW9kaWZpZWQgYGNwdS1leGVjLmNgIHRvIGludm9rZSB0aGUgY2FsbGJhY2sg
b24gaGFyZCBpbnRlcnJ1cHRzLCBhbmQgYWRkZWQgYSB0ZXN0IHBsdWdpbiAoYGNvdW50aW50YCkg
dG8gZGVtb25zdHJhdGUgaXRzIGZ1bmN0aW9uYWxpdHkuIEEgc2ltaWxhciBhcHByb2FjaCB3YXMg
cHJldmlvdXNseSBwcm9wb3NlZCAoaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9x
ZW11LWRldmVsLzIwMjMtMTAvbXNnMDczNTkuaHRtbCkgYnV0IHdhcyBub3QgbWVyZ2VkLg0KDQpT
aWduZWQtb2ZmLWJ5OiBtYXJrbzE2MTYgPG1hcmtvMTYxNkBvdXRsb29rLmNvbT4NCi0tLQ0KIGFj
Y2VsL3RjZy9jcHUtZXhlYy5jICAgICAgICB8ICA5ICsrKysNCiBjb250cmliL3BsdWdpbnMvY291
bnRpbnQuYyAgfCA5MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogY29u
dHJpYi9wbHVnaW5zL21lc29uLmJ1aWxkIHwgIDIgKy0NCiBpbmNsdWRlL3FlbXUvcGx1Z2luLWV2
ZW50LmggfCAgMSArDQogaW5jbHVkZS9xZW11L3BsdWdpbi5oICAgICAgIHwgIDUgKysrDQogaW5j
bHVkZS9xZW11L3FlbXUtcGx1Z2luLmggIHwgMTcgKysrKysrKw0KIHBsdWdpbnMvY29yZS5jICAg
ICAgICAgICAgICB8IDIzICsrKysrKysrKysNCiA3IGZpbGVzIGNoYW5nZWQsIDE0NiBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGNvbnRyaWIvcGx1Z2lu
cy9jb3VudGludC5jDQoNCmRpZmYgLS1naXQgYS9hY2NlbC90Y2cvY3B1LWV4ZWMuYyBiL2FjY2Vs
L3RjZy9jcHUtZXhlYy5jDQppbmRleCBjYzVmMzYyMzA1Li44MjlmNGMyNmYwIDEwMDY0NA0KLS0t
IGEvYWNjZWwvdGNnL2NwdS1leGVjLmMNCisrKyBiL2FjY2VsL3RjZy9jcHUtZXhlYy5jDQpAQCAt
MzQsNiArMzQsOSBAQA0KICNpbmNsdWRlICJ0Y2cvdGNnLmgiDQogI2luY2x1ZGUgInFlbXUvYXRv
bWljLmgiDQogI2luY2x1ZGUgInFlbXUvcmN1LmgiDQorI2lmZGVmIENPTkZJR19QTFVHSU4NCisj
aW5jbHVkZSAicWVtdS9wbHVnaW4uaCINCisjZW5kaWYNCiAjaW5jbHVkZSAiZXhlYy9sb2cuaCIN
CiAjaW5jbHVkZSAicWVtdS9tYWluLWxvb3AuaCINCiAjaW5jbHVkZSAiZXhlYy9pY291bnQuaCIN
CkBAIC04MTgsNyArODIxLDEzIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBjcHVfaGFuZGxlX2ludGVy
cnVwdChDUFVTdGF0ZSAqY3B1LA0KICAgICAgICAgICAgICAqIFRydWUgd2hlbiBpdCBpcywgYW5k
IHdlIHNob3VsZCByZXN0YXJ0IG9uIGEgbmV3IFRCLA0KICAgICAgICAgICAgICAqIGFuZCB2aWEg
bG9uZ2ptcCB2aWEgY3B1X2xvb3BfZXhpdC4NCiAgICAgICAgICAgICAgKi8NCisgICAgICAgICAg
ICBjb25zdCBpbnQgcHJldl9pbnRlcnJ1cHRfcmVxdWVzdCA9IGludGVycnVwdF9yZXF1ZXN0Ow0K
ICAgICAgICAgICAgIGlmICh0Y2dfb3BzLT5jcHVfZXhlY19pbnRlcnJ1cHQoY3B1LCBpbnRlcnJ1
cHRfcmVxdWVzdCkpIHsNCisjaWZkZWYgQ09ORklHX1BMVUdJTg0KKyAgICAgICAgICAgICAgICBp
ZiAoaW50ZXJydXB0X3JlcXVlc3QgJiBDUFVfSU5URVJSVVBUX0hBUkQpIHsNCisgICAgICAgICAg
ICAgICAgICAgIHFlbXVfcGx1Z2luX3ZjcHVfaW50X2NiKGNwdSwgcHJldl9pbnRlcnJ1cHRfcmVx
dWVzdCk7DQorICAgICAgICAgICAgICAgIH0NCisjZW5kaWYgLyogQ09ORklHX1BMVUdJTiAqLw0K
ICAgICAgICAgICAgICAgICBpZiAoIXRjZ19vcHMtPm5lZWRfcmVwbGF5X2ludGVycnVwdCB8fA0K
ICAgICAgICAgICAgICAgICAgICAgdGNnX29wcy0+bmVlZF9yZXBsYXlfaW50ZXJydXB0KGludGVy
cnVwdF9yZXF1ZXN0KSkgew0KICAgICAgICAgICAgICAgICAgICAgcmVwbGF5X2ludGVycnVwdCgp
Ow0KZGlmZiAtLWdpdCBhL2NvbnRyaWIvcGx1Z2lucy9jb3VudGludC5jIGIvY29udHJpYi9wbHVn
aW5zL2NvdW50aW50LmMNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwMDAwLi42
MDFiN2YzMGQ1DQotLS0gL2Rldi9udWxsDQorKysgYi9jb250cmliL3BsdWdpbnMvY291bnRpbnQu
Yw0KQEAgLTAsMCArMSw5MCBAQA0KKy8qDQorICogQ29weXJpZ2h0IChjKSAyMDI1IG1hcmtvMTYx
Ng0KKyAqDQorICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCisg
Ki8NCisNCisjaW5jbHVkZSA8c3RkaW8uaD4NCisjaW5jbHVkZSA8Z2xpYi5oPg0KKw0KKyNpbmNs
dWRlIDxxZW11LXBsdWdpbi5oPg0KKw0KK1FFTVVfUExVR0lOX0VYUE9SVCBpbnQgcWVtdV9wbHVn
aW5fdmVyc2lvbiA9IFFFTVVfUExVR0lOX1ZFUlNJT047DQorDQordHlwZWRlZiBzdHJ1Y3Qgew0K
KyAgICB1bnNpZ25lZCBpbnQgdmNwdV9pbmRleDsNCisgICAgc3RydWN0IHFlbXVfcGx1Z2luX3Nj
b3JlYm9hcmQgKmludF9jb3VudDsNCit9IEludFN0YXQ7DQorDQorc3RhdGljIEdIYXNoVGFibGUg
KnZjcHVfaW50X3RhYmxlOw0KK3N0YXRpYyBHTXV0ZXggbG9jazsNCisNCitzdGF0aWMgZ3VpbnQg
aW50c3RhdF9oYXNoKGdjb25zdHBvaW50ZXIga2V5KQ0KK3sNCisgICAgY29uc3QgSW50U3RhdCAq
cyA9IGtleTsNCisgICAgcmV0dXJuIHMtPnZjcHVfaW5kZXg7DQorfQ0KKw0KK3N0YXRpYyBnYm9v
bGVhbiBpbnRzdGF0X2VxdWFsKGdjb25zdHBvaW50ZXIgYSwgZ2NvbnN0cG9pbnRlciBiKQ0KK3sN
CisgICAgcmV0dXJuICgoSW50U3RhdCAqKWEpLT52Y3B1X2luZGV4ID09ICgoSW50U3RhdCAqKWIp
LT52Y3B1X2luZGV4Ow0KK30NCisNCitzdGF0aWMgdm9pZCBpbnRzdGF0X2ZyZWUoZ3BvaW50ZXIg
a2V5LCBncG9pbnRlciB2YWx1ZSwgZ3BvaW50ZXIgdXNlcl9kYXRhKQ0KK3sNCisgICAgSW50U3Rh
dCAqcyA9IHZhbHVlOw0KKyAgICBxZW11X3BsdWdpbl9zY29yZWJvYXJkX2ZyZWUocy0+aW50X2Nv
dW50KTsNCisgICAgZ19mcmVlKHMpOw0KK30NCisNCitzdGF0aWMgdm9pZCB2Y3B1X2hhcmRpbnQo
cWVtdV9wbHVnaW5faWRfdCBpZCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQg
aW50IHZjcHVfaW5kZXgsDQorICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGludF9y
ZXEpDQorew0KKyAgICBJbnRTdGF0ICpzdGF0ID0gTlVMTDsNCisNCisgICAgZ19tdXRleF9sb2Nr
KCZsb2NrKTsNCisgICAgew0KKyAgICAgICAgSW50U3RhdCBrZXkgPSB7IC52Y3B1X2luZGV4ID0g
dmNwdV9pbmRleCB9Ow0KKyAgICAgICAgc3RhdCA9IGdfaGFzaF90YWJsZV9sb29rdXAodmNwdV9p
bnRfdGFibGUsICZrZXkpOw0KKw0KKyAgICAgICAgaWYgKCFzdGF0KSB7DQorICAgICAgICAgICAg
c3RhdCA9IGdfbmV3MChJbnRTdGF0LCAxKTsNCisgICAgICAgICAgICBzdGF0LT52Y3B1X2luZGV4
ID0gdmNwdV9pbmRleDsNCisgICAgICAgICAgICBzdGF0LT5pbnRfY291bnQgPSBxZW11X3BsdWdp
bl9zY29yZWJvYXJkX25ldyhzaXplb2YodWludDY0X3QpKTsNCisgICAgICAgICAgICBnX2hhc2hf
dGFibGVfaW5zZXJ0KHZjcHVfaW50X3RhYmxlLCBzdGF0LCBzdGF0KTsNCisgICAgICAgIH0NCisg
ICAgfQ0KKyAgICBnX211dGV4X3VubG9jaygmbG9jayk7DQorDQorICAgIHFlbXVfcGx1Z2luX3U2
NF9hZGQoDQorICAgICAgICBxZW11X3BsdWdpbl9zY29yZWJvYXJkX3U2NChzdGF0LT5pbnRfY291
bnQpLA0KKyAgICAgICAgdmNwdV9pbmRleCwNCisgICAgICAgIDENCisgICAgKTsNCit9DQorDQor
c3RhdGljIHZvaWQgcGx1Z2luX2V4aXQocWVtdV9wbHVnaW5faWRfdCBpZCwgdm9pZCAqcCkNCit7
DQorICAgIEdMaXN0ICpzdGF0cyA9IGdfaGFzaF90YWJsZV9nZXRfdmFsdWVzKHZjcHVfaW50X3Rh
YmxlKTsNCisgICAgZm9yIChHTGlzdCAqaXQgPSBzdGF0czsgaXQgIT0gTlVMTDsgaXQgPSBpdC0+
bmV4dCkgew0KKyAgICAgICAgSW50U3RhdCAqc3RhdCA9IChJbnRTdGF0ICopaXQtPmRhdGE7DQor
ICAgICAgICB1aW50NjRfdCBjb3VudCA9IHFlbXVfcGx1Z2luX3U2NF9zdW0oDQorICAgICAgICAg
ICAgcWVtdV9wbHVnaW5fc2NvcmVib2FyZF91NjQoc3RhdC0+aW50X2NvdW50KQ0KKyAgICAgICAg
KTsNCisgICAgICAgIHByaW50ZigidkNQVSAldTogJSIgUFJJdTY0ICIgaW50ZXJydXB0c1xuIiwg
c3RhdC0+dmNwdV9pbmRleCwgY291bnQpOw0KKyAgICB9DQorICAgIGdfbGlzdF9mcmVlKHN0YXRz
KTsNCisgICAgZ19oYXNoX3RhYmxlX2ZvcmVhY2godmNwdV9pbnRfdGFibGUsIGludHN0YXRfZnJl
ZSwgTlVMTCk7DQorICAgIGdfaGFzaF90YWJsZV9kZXN0cm95KHZjcHVfaW50X3RhYmxlKTsNCit9
DQorDQorUUVNVV9QTFVHSU5fRVhQT1JUDQoraW50IHFlbXVfcGx1Z2luX2luc3RhbGwocWVtdV9w
bHVnaW5faWRfdCBpZCwgY29uc3QgcWVtdV9pbmZvX3QgKmluZm8sDQorICAgICAgICAgICAgICAg
ICAgICAgICAgaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KK3sNCisgICAgdmNwdV9pbnRfdGFibGUg
PSBnX2hhc2hfdGFibGVfbmV3KGludHN0YXRfaGFzaCwgaW50c3RhdF9lcXVhbCk7DQorICAgIHFl
bXVfcGx1Z2luX3JlZ2lzdGVyX3ZjcHVfaW50X2NiKGlkLCB2Y3B1X2hhcmRpbnQpOw0KKyAgICBx
ZW11X3BsdWdpbl9yZWdpc3Rlcl9hdGV4aXRfY2IoaWQsIHBsdWdpbl9leGl0LCBOVUxMKTsNCisg
ICAgcmV0dXJuIDA7DQorfQ0KZGlmZiAtLWdpdCBhL2NvbnRyaWIvcGx1Z2lucy9tZXNvbi5idWls
ZCBiL2NvbnRyaWIvcGx1Z2lucy9tZXNvbi5idWlsZA0KaW5kZXggZmE4YTQyNmM4Yi4uMTdlM2Iw
ZWMyNyAxMDA2NDQNCi0tLSBhL2NvbnRyaWIvcGx1Z2lucy9tZXNvbi5idWlsZA0KKysrIGIvY29u
dHJpYi9wbHVnaW5zL21lc29uLmJ1aWxkDQpAQCAtMSw0ICsxLDQgQEANCi1jb250cmliX3BsdWdp
bnMgPSBbJ2JidicsICdjYWNoZScsICdjZmxvdycsICdkcmNvdicsICdleGVjbG9nJywgJ2hvdGJs
b2NrcycsDQorY29udHJpYl9wbHVnaW5zID0gWydiYnYnLCAnY2FjaGUnLCAnY2Zsb3cnLCAnZHJj
b3YnLCAnZXhlY2xvZycsICdjb3VudGludCcsICdob3RibG9ja3MnLA0KICAgICAgICAgICAgICAg
ICAgICAnaG90cGFnZXMnLCAnaG93dmVjJywgJ2h3cHJvZmlsZScsICdpcHMnLCAnc3RvcHRyaWdn
ZXInXQ0KIGlmIGhvc3Rfb3MgIT0gJ3dpbmRvd3MnDQogICAjIGxvY2tzdGVwIHVzZXMgc29ja2V0
LmgNCmRpZmYgLS1naXQgYS9pbmNsdWRlL3FlbXUvcGx1Z2luLWV2ZW50LmggYi9pbmNsdWRlL3Fl
bXUvcGx1Z2luLWV2ZW50LmgNCmluZGV4IDcwNTZkODQyN2IuLmNkOWY5ZWIyNWIgMTAwNjQ0DQot
LS0gYS9pbmNsdWRlL3FlbXUvcGx1Z2luLWV2ZW50LmgNCisrKyBiL2luY2x1ZGUvcWVtdS9wbHVn
aW4tZXZlbnQuaA0KQEAgLTE2LDYgKzE2LDcgQEAgZW51bSBxZW11X3BsdWdpbl9ldmVudCB7DQog
ICAgIFFFTVVfUExVR0lOX0VWX1ZDUFVfVEJfVFJBTlMsDQogICAgIFFFTVVfUExVR0lOX0VWX1ZD
UFVfSURMRSwNCiAgICAgUUVNVV9QTFVHSU5fRVZfVkNQVV9SRVNVTUUsDQorICAgIFFFTVVfUExV
R0lOX0VWX1ZDUFVfSU5ULA0KICAgICBRRU1VX1BMVUdJTl9FVl9WQ1BVX1NZU0NBTEwsDQogICAg
IFFFTVVfUExVR0lOX0VWX1ZDUFVfU1lTQ0FMTF9SRVQsDQogICAgIFFFTVVfUExVR0lOX0VWX0ZM
VVNILA0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvcWVtdS9wbHVnaW4uaCBiL2luY2x1ZGUvcWVtdS9w
bHVnaW4uaA0KaW5kZXggOTcyNmE5ZWJmMy4uZjFkNWQ5MTE0MSAxMDA2NDQNCi0tLSBhL2luY2x1
ZGUvcWVtdS9wbHVnaW4uaA0KKysrIGIvaW5jbHVkZS9xZW11L3BsdWdpbi5oDQpAQCAtNjEsNiAr
NjEsNyBAQCB1bmlvbiBxZW11X3BsdWdpbl9jYl9zaWcgew0KICAgICBxZW11X3BsdWdpbl92Y3B1
X3VkYXRhX2NiX3QgICAgICB2Y3B1X3VkYXRhOw0KICAgICBxZW11X3BsdWdpbl92Y3B1X3RiX3Ry
YW5zX2NiX3QgICB2Y3B1X3RiX3RyYW5zOw0KICAgICBxZW11X3BsdWdpbl92Y3B1X21lbV9jYl90
ICAgICAgICB2Y3B1X21lbTsNCisgICAgcWVtdV9wbHVnaW5fdmNwdV9pbnRfY2JfdCAgICB2Y3B1
X2hhcmRpbnQ7DQogICAgIHFlbXVfcGx1Z2luX3ZjcHVfc3lzY2FsbF9jYl90ICAgIHZjcHVfc3lz
Y2FsbDsNCiAgICAgcWVtdV9wbHVnaW5fdmNwdV9zeXNjYWxsX3JldF9jYl90IHZjcHVfc3lzY2Fs
bF9yZXQ7DQogICAgIHZvaWQgKmdlbmVyaWM7DQpAQCAtMTYwLDYgKzE2MSw3IEBAIHZvaWQgcWVt
dV9wbHVnaW5fdmNwdV9leGl0X2hvb2soQ1BVU3RhdGUgKmNwdSk7DQogdm9pZCBxZW11X3BsdWdp
bl90Yl90cmFuc19jYihDUFVTdGF0ZSAqY3B1LCBzdHJ1Y3QgcWVtdV9wbHVnaW5fdGIgKnRiKTsN
CiB2b2lkIHFlbXVfcGx1Z2luX3ZjcHVfaWRsZV9jYihDUFVTdGF0ZSAqY3B1KTsNCiB2b2lkIHFl
bXVfcGx1Z2luX3ZjcHVfcmVzdW1lX2NiKENQVVN0YXRlICpjcHUpOw0KK3ZvaWQgcWVtdV9wbHVn
aW5fdmNwdV9pbnRfY2IoQ1BVU3RhdGUgKmNwdSwgaW50IGludGVycnVwdF9yZXF1ZXN0KTsNCiB2
b2lkDQogcWVtdV9wbHVnaW5fdmNwdV9zeXNjYWxsKENQVVN0YXRlICpjcHUsIGludDY0X3QgbnVt
LCB1aW50NjRfdCBhMSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgYTIsIHVp
bnQ2NF90IGEzLCB1aW50NjRfdCBhNCwgdWludDY0X3QgYTUsDQpAQCAtMjQyLDYgKzI0NCw5IEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCBxZW11X3BsdWdpbl92Y3B1X2lkbGVfY2IoQ1BVU3RhdGUgKmNw
dSkNCiBzdGF0aWMgaW5saW5lIHZvaWQgcWVtdV9wbHVnaW5fdmNwdV9yZXN1bWVfY2IoQ1BVU3Rh
dGUgKmNwdSkNCiB7IH0NCg0KK3N0YXRpYyBpbmxpbmUgdm9pZCBxZW11X3BsdWdpbl92Y3B1X2lu
dF9jYihDUFVTdGF0ZSAqY3B1LCBpbnQgaW50ZXJydXB0X3JlcXVlc3QpDQoreyB9DQorDQogc3Rh
dGljIGlubGluZSB2b2lkDQogcWVtdV9wbHVnaW5fdmNwdV9zeXNjYWxsKENQVVN0YXRlICpjcHUs
IGludDY0X3QgbnVtLCB1aW50NjRfdCBhMSwgdWludDY0X3QgYTIsDQogICAgICAgICAgICAgICAg
ICAgICAgICAgIHVpbnQ2NF90IGEzLCB1aW50NjRfdCBhNCwgdWludDY0X3QgYTUsIHVpbnQ2NF90
IGE2LA0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvcWVtdS9xZW11LXBsdWdpbi5oIGIvaW5jbHVkZS9x
ZW11L3FlbXUtcGx1Z2luLmgNCmluZGV4IDNhODUwYWEyMTYuLjY1MDk2YzRjNjQgMTAwNjQ0DQot
LS0gYS9pbmNsdWRlL3FlbXUvcWVtdS1wbHVnaW4uaA0KKysrIGIvaW5jbHVkZS9xZW11L3FlbXUt
cGx1Z2luLmgNCkBAIC03MjgsNiArNzI4LDIzIEBAIGNvbnN0IHZvaWQgKnFlbXVfcGx1Z2luX3Jl
cXVlc3RfdGltZV9jb250cm9sKHZvaWQpOw0KIFFFTVVfUExVR0lOX0FQSQ0KIHZvaWQgcWVtdV9w
bHVnaW5fdXBkYXRlX25zKGNvbnN0IHZvaWQgKmhhbmRsZSwgaW50NjRfdCB0aW1lKTsNCg0KK3R5
cGVkZWYgdm9pZA0KKygqcWVtdV9wbHVnaW5fdmNwdV9pbnRfY2JfdCkocWVtdV9wbHVnaW5faWRf
dCBpZCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgdmNw
dV9pbmRleCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBpbnRl
cnJ1cHRfcmVxdWVzdCk7DQorDQorLyoqDQorICogcWVtdV9wbHVnaW5fcmVnaXN0ZXJfdmNwdV9p
bnRfY2IoKSAtDQorICogICByZWdpc3RlciBhIHZDUFUgaGFyZHdhcmUgaW50ZXJydXB0aW9uIGNh
bGxiYWNrDQorICogQGlkOiBwbHVnaW4gSUQNCisgKiBAY2I6IGNhbGxiYWNrIGZ1bmN0aW9uDQor
ICoNCisgKiBUaGUgQGNiIGZ1bmN0aW9uIGlzIGNhbGxlZCBldmVyeSB0aW1lIGEgdkNQVSBnZXRz
IGhhcmR3YXJlIGludGVycnVwdGlvbi4NCisgKi8NCitRRU1VX1BMVUdJTl9BUEkNCit2b2lkIHFl
bXVfcGx1Z2luX3JlZ2lzdGVyX3ZjcHVfaW50X2NiKHFlbXVfcGx1Z2luX2lkX3QgaWQsDQorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcWVtdV9wbHVnaW5fdmNwdV9p
bnRfY2JfdCBjYik7DQorDQogdHlwZWRlZiB2b2lkDQogKCpxZW11X3BsdWdpbl92Y3B1X3N5c2Nh
bGxfY2JfdCkocWVtdV9wbHVnaW5faWRfdCBpZCwgdW5zaWduZWQgaW50IHZjcHVfaW5kZXgsDQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50NjRfdCBudW0sIHVpbnQ2NF90IGEx
LCB1aW50NjRfdCBhMiwNCmRpZmYgLS1naXQgYS9wbHVnaW5zL2NvcmUuYyBiL3BsdWdpbnMvY29y
ZS5jDQppbmRleCBlYjkyODFmZTU0Li5iNmZiZmUyMGU5IDEwMDY0NA0KLS0tIGEvcGx1Z2lucy9j
b3JlLmMNCisrKyBiL3BsdWdpbnMvY29yZS5jDQpAQCAtNTM5LDYgKzUzOSwyMyBAQCB2b2lkIHFl
bXVfcGx1Z2luX3ZjcHVfcmVzdW1lX2NiKENQVVN0YXRlICpjcHUpDQogICAgIH0NCiB9DQoNCisv
Kg0KKyAqIERpc2FibGUgQ0ZJIGNoZWNrcy4NCisgKiBUaGUgY2FsbGJhY2sgZnVuY3Rpb24gaGFz
IGJlZW4gbG9hZGVkIGZyb20gYW4gZXh0ZXJuYWwgbGlicmFyeSBzbyB3ZSBkbyBub3QNCisgKiBo
YXZlIHR5cGUgaW5mb3JtYXRpb24NCisgKi8NCitRRU1VX0RJU0FCTEVfQ0ZJDQordm9pZCBxZW11
X3BsdWdpbl92Y3B1X2ludF9jYihDUFVTdGF0ZSAqY3B1LCBpbnQgaW50ZXJydXB0X3JlcXVlc3Qp
DQorew0KKyAgICBzdHJ1Y3QgcWVtdV9wbHVnaW5fY2IgKmNiLCAqbmV4dDsNCisgICAgZW51bSBx
ZW11X3BsdWdpbl9ldmVudCBldiA9IFFFTVVfUExVR0lOX0VWX1ZDUFVfSU5UOw0KKw0KKyAgICBR
TElTVF9GT1JFQUNIX1NBRkVfUkNVKGNiLCAmcGx1Z2luLmNiX2xpc3RzW2V2XSwgZW50cnksIG5l
eHQpIHsNCisgICAgICAgIHFlbXVfcGx1Z2luX3ZjcHVfaW50X2NiX3QgZnVuYyA9IGNiLT5mLnZj
cHVfaGFyZGludDsNCisgICAgICAgIGZ1bmMoY2ItPmN0eC0+aWQsIGNwdS0+Y3B1X2luZGV4LCBp
bnRlcnJ1cHRfcmVxdWVzdCk7DQorICAgIH0NCit9DQorDQogdm9pZCBxZW11X3BsdWdpbl9yZWdp
c3Rlcl92Y3B1X2lkbGVfY2IocWVtdV9wbHVnaW5faWRfdCBpZCwNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBxZW11X3BsdWdpbl92Y3B1X3NpbXBsZV9jYl90IGNiKQ0K
IHsNCkBAIC01NTEsNiArNTY4LDEyIEBAIHZvaWQgcWVtdV9wbHVnaW5fcmVnaXN0ZXJfdmNwdV9y
ZXN1bWVfY2IocWVtdV9wbHVnaW5faWRfdCBpZCwNCiAgICAgcGx1Z2luX3JlZ2lzdGVyX2NiKGlk
LCBRRU1VX1BMVUdJTl9FVl9WQ1BVX1JFU1VNRSwgY2IpOw0KIH0NCg0KK3ZvaWQgcWVtdV9wbHVn
aW5fcmVnaXN0ZXJfdmNwdV9pbnRfY2IocWVtdV9wbHVnaW5faWRfdCBpZCwNCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBxZW11X3BsdWdpbl92Y3B1X2ludF9jYl90
IGNiKQ0KK3sNCisgICAgcGx1Z2luX3JlZ2lzdGVyX2NiKGlkLCBRRU1VX1BMVUdJTl9FVl9WQ1BV
X0lOVCwgY2IpOw0KK30NCisNCiB2b2lkIHFlbXVfcGx1Z2luX3JlZ2lzdGVyX2ZsdXNoX2NiKHFl
bXVfcGx1Z2luX2lkX3QgaWQsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBx
ZW11X3BsdWdpbl9zaW1wbGVfY2JfdCBjYikNCiB7DQotLQ0KMi4zOS41DQoNCg0KDQo=

--_000_ME3P282MB27933F3CA48FA7C7EB0BCBBFA692AME3P282MB2793AUSP_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<pre class=3D"elementToProof"><div class=3D"elementToProof" style=3D"line-h=
eight: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, A=
ptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color:=
 rgb(0, 0, 0);">Implemented the `qemu_plugin_vcpu_int_cb` callback to allow=
 plugins to observe hardware and architecture-specific interrupts. Modified=
 `cpu-exec.c` to invoke the callback on hard interrupts, and added a test p=
lugin (`countint`) to demonstrate its functionality. A similar approach was=
 previously proposed (https://lists.gnu.org/archive/html/qemu-devel/2023-10=
/msg07359.html) but was not merged.</div><div class=3D"elementToProof" styl=
e=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);"><br></div><div class=3D"elementToProof" style=3D=
"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_Embedded=
Font, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">Signed-off-by: marko1616 &lt;marko1616@outlook.com&g=
t;</div><div class=3D"elementToProof" style=3D"line-height: 19px; white-spa=
ce: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Ca=
libri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"><b>---=
</b></div><div class=3D"elementToProof" style=3D"line-height: 19px; white-s=
pace: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">&nbs=
p;accel/tcg/cpu-exec.c &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp;9 ++++</div><div =
class=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; f=
ont-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvet=
ica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">&nbsp;contrib/plugi=
ns/countint.c &nbsp;| 90 +++++++++++++++++++++++++++++++++++++</div><div cl=
ass=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; fon=
t-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetic=
a, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">&nbsp;contrib/plugins=
/meson.build | &nbsp;2 +-</div><div class=3D"elementToProof" style=3D"line-=
height: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, =
Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color=
: rgb(0, 0, 0);">&nbsp;include/qemu/plugin-event.h | &nbsp;1 +</div><div cl=
ass=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; fon=
t-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetic=
a, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">&nbsp;include/qemu/pl=
ugin.h &nbsp; &nbsp; &nbsp; | &nbsp;5 +++</div><div class=3D"elementToProof=
" style=3D"line-height: 19px; white-space: normal; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">&nbsp;include/qemu/qemu-plugin.h &nbsp;| 1=
7 +++++++</div><div class=3D"elementToProof" style=3D"line-height: 19px; wh=
ite-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServ=
ice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"=
>&nbsp;plugins/core.c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| 23 =
++++++++++</div><div class=3D"elementToProof" style=3D"line-height: 19px; w=
hite-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">&nbsp;7 files changed, 146 insertions(+), 1 deletion(-)</div><div class=
=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; font-f=
amily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">&nbsp;create mode 100644=
 contrib/plugins/countint.c</div><div class=3D"elementToProof" style=3D"lin=
e-height: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont=
, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; col=
or: rgb(0, 0, 0);"><br></div><div class=3D"elementToProof" style=3D"line-he=
ight: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Ap=
tos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: =
rgb(0, 0, 0);">diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c</di=
v><div class=3D"elementToProof" style=3D"line-height: 19px; white-space: no=
rmal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri,=
 Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">index cc5f36=
2305..829f4c26f0 100644</div><div class=3D"elementToProof" style=3D"line-he=
ight: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Ap=
tos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: =
rgb(0, 0, 0);">---&nbsp;a/accel/tcg/cpu-exec.c</div><div class=3D"elementTo=
Proof" style=3D"line-height: 19px; white-space: normal; font-family: Aptos,=
 Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; f=
ont-size: 12pt; color: rgb(0, 0, 0);">+++&nbsp;b/accel/tcg/cpu-exec.c</div>=
<div class=3D"elementToProof" style=3D"line-height: 19px; white-space: norm=
al; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">@@&nbsp;-34,6 =
+34,9 @@</div><div class=3D"elementToProof" style=3D"line-height: 19px; whi=
te-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">=
&nbsp;#include &quot;tcg/tcg.h&quot;</div><div class=3D"elementToProof" sty=
le=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_Emb=
eddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">&nbsp;#include &quot;qemu/atomic.h&quot;</div><=
div class=3D"elementToProof" style=3D"line-height: 19px; white-space: norma=
l; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">&nbsp;#include =
&quot;qemu/rcu.h&quot;</div><div class=3D"elementToProof" style=3D"line-hei=
ght: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Apt=
os_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: r=
gb(0, 0, 0);">+#ifdef CONFIG_PLUGIN</div><div class=3D"elementToProof" styl=
e=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">+#include &quot;qemu/plugin.h&quot;</div><div cl=
ass=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; fon=
t-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetic=
a, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+#endif</div><div cla=
ss=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; font=
-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica=
, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">&nbsp;#include &quot;e=
xec/log.h&quot;</div><div class=3D"elementToProof" style=3D"line-height: 19=
px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFo=
ntService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0=
, 0);">&nbsp;#include &quot;qemu/main-loop.h&quot;</div><div class=3D"eleme=
ntToProof" style=3D"line-height: 19px; white-space: normal; font-family: Ap=
tos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);">&nbsp;#include &quot;exec/icount.=
h&quot;</div><div class=3D"elementToProof" style=3D"line-height: 19px; whit=
e-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServic=
e, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">@=
@&nbsp;-818,7 +821,13 @@&nbsp;static inline bool cpu_handle_interrupt(CPUSt=
ate *cpu,</div><div class=3D"elementToProof" style=3D"line-height: 19px; wh=
ite-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServ=
ice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"=
>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * True when it is, and we=
 should restart on a new TB,</div><div class=3D"elementToProof" style=3D"li=
ne-height: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFon=
t, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * and =
via longjmp via cpu_loop_exit.</div><div class=3D"elementToProof" style=3D"=
line-height: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedF=
ont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; =
color: rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; */</=
div><div class=3D"elementToProof" style=3D"line-height: 19px; white-space: =
normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibr=
i, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;const int prev_interrupt_request =3D =
interrupt_request;</div><div class=3D"elementToProof" style=3D"line-height:=
 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_M=
SFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (tcg_ops-&gt;c=
pu_exec_interrupt(cpu, interrupt_request)) {</div><div class=3D"elementToPr=
oof" style=3D"line-height: 19px; white-space: normal; font-family: Aptos, A=
ptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fon=
t-size: 12pt; color: rgb(0, 0, 0);">+#ifdef CONFIG_PLUGIN</div><div class=
=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; font-f=
amily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (interrupt_request &amp; CPU_INTER=
RUPT_HARD) {</div><div class=3D"elementToProof" style=3D"line-height: 19px;=
 white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontS=
ervice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0=
);">+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;qemu_plugin_vcpu_int_cb(cpu, prev_interrupt_request);</div><div class=
=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; font-f=
amily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}</div><div class=3D"elementToProof" =
style=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0);">+#endif /* CONFIG_PLUGIN */</div><div class=
=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; font-f=
amily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!tcg_ops-&gt;need_replay_interrup=
t ||</div><div class=3D"elementToProof" style=3D"line-height: 19px; white-s=
pace: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">&nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;tcg=
_ops-&gt;need_replay_interrupt(interrupt_request)) {</div><div class=3D"ele=
mentToProof" style=3D"line-height: 19px; white-space: normal; font-family: =
Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;replay_interrupt();</div><div =
class=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; f=
ont-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvet=
ica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">diff --git a/contri=
b/plugins/countint.c b/contrib/plugins/countint.c</div><div class=3D"elemen=
tToProof" style=3D"line-height: 19px; white-space: normal; font-family: Apt=
os, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif=
; font-size: 12pt; color: rgb(0, 0, 0);">new file mode 100644</div><div cla=
ss=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; font=
-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica=
, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">index 0000000000..601b=
7f30d5</div><div class=3D"elementToProof" style=3D"line-height: 19px; white=
-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">--=
-&nbsp;/dev/null</div><div class=3D"elementToProof" style=3D"line-height: 1=
9px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSF=
ontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, =
0, 0);">+++&nbsp;b/contrib/plugins/countint.c</div><div class=3D"elementToP=
roof" style=3D"line-height: 19px; white-space: normal; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">@@&nbsp;-0,0 +1,90 @@</div><div class=
=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; font-f=
amily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+/*</div><div class=3D"e=
lementToProof" style=3D"line-height: 19px; white-space: normal; font-family=
: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;* Copyright (c) 2025 m=
arko1616</div><div class=3D"elementToProof" style=3D"line-height: 19px; whi=
te-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">=
+&nbsp;*</div><div class=3D"elementToProof" style=3D"line-height: 19px; whi=
te-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">=
+&nbsp;* SPDX-License-Identifier: GPL-2.0-or-later</div><div class=3D"eleme=
ntToProof" style=3D"line-height: 19px; white-space: normal; font-family: Ap=
tos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;*/</div><div class=3D"elem=
entToProof" style=3D"line-height: 19px; white-space: normal; font-family: A=
ptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-ser=
if; font-size: 12pt; color: rgb(0, 0, 0);">+</div><div class=3D"elementToPr=
oof" style=3D"line-height: 19px; white-space: normal; font-family: Aptos, A=
ptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fon=
t-size: 12pt; color: rgb(0, 0, 0);">+#include &lt;stdio.h&gt;</div><div cla=
ss=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; font=
-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica=
, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+#include &lt;glib.h&g=
t;</div><div class=3D"elementToProof" style=3D"line-height: 19px; white-spa=
ce: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Ca=
libri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+</div=
><div class=3D"elementToProof" style=3D"line-height: 19px; white-space: nor=
mal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, =
Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+#include &lt=
;qemu-plugin.h&gt;</div><div class=3D"elementToProof" style=3D"line-height:=
 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_M=
SFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">+</div><div class=3D"elementToProof" style=3D"line-height: 19px; =
white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSe=
rvice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;">+QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;</di=
v><div class=3D"elementToProof" style=3D"line-height: 19px; white-space: no=
rmal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri,=
 Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+</div><div =
class=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; f=
ont-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvet=
ica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+typedef struct {</=
div><div class=3D"elementToProof" style=3D"line-height: 19px; white-space: =
normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibr=
i, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nb=
sp; &nbsp;unsigned int vcpu_index;</div><div class=3D"elementToProof" style=
=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_Embed=
dedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12=
pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp;struct qemu_plugin_scoreboard=
 *int_count;</div><div class=3D"elementToProof" style=3D"line-height: 19px;=
 white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontS=
ervice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0=
);">+} IntStat;</div><div class=3D"elementToProof" style=3D"line-height: 19=
px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFo=
ntService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0=
, 0);">+</div><div class=3D"elementToProof" style=3D"line-height: 19px; whi=
te-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">=
+static GHashTable *vcpu_int_table;</div><div class=3D"elementToProof" styl=
e=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">+static GMutex lock;</div><div class=3D"elementT=
oProof" style=3D"line-height: 19px; white-space: normal; font-family: Aptos=
, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">+</div><div class=3D"elementToProof"=
 style=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos=
_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-si=
ze: 12pt; color: rgb(0, 0, 0);">+static guint intstat_hash(gconstpointer ke=
y)</div><div class=3D"elementToProof" style=3D"line-height: 19px; white-spa=
ce: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Ca=
libri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+{</di=
v><div class=3D"elementToProof" style=3D"line-height: 19px; white-space: no=
rmal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri,=
 Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp=
; &nbsp;const IntStat *s =3D key;</div><div class=3D"elementToProof" style=
=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_Embed=
dedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12=
pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp;return s-&gt;vcpu_index;</div=
><div class=3D"elementToProof" style=3D"line-height: 19px; white-space: nor=
mal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, =
Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+}</div><div =
class=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; f=
ont-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvet=
ica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+</div><div class=
=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; font-f=
amily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+static gboolean intstat=
_equal(gconstpointer a, gconstpointer b)</div><div class=3D"elementToProof"=
 style=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos=
_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-si=
ze: 12pt; color: rgb(0, 0, 0);">+{</div><div class=3D"elementToProof" style=
=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_Embed=
dedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12=
pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp;return ((IntStat *)a)-&gt;vcp=
u_index =3D=3D ((IntStat *)b)-&gt;vcpu_index;</div><div class=3D"elementToP=
roof" style=3D"line-height: 19px; white-space: normal; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">+}</div><div class=3D"elementToProof" =
style=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0);">+</div><div class=3D"elementToProof" style=
=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_Embed=
dedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12=
pt; color: rgb(0, 0, 0);">+static void intstat_free(gpointer key, gpointer =
value, gpointer user_data)</div><div class=3D"elementToProof" style=3D"line=
-height: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont,=
 Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; colo=
r: rgb(0, 0, 0);">+{</div><div class=3D"elementToProof" style=3D"line-heigh=
t: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb=
(0, 0, 0);">+&nbsp;&nbsp; &nbsp;IntStat *s =3D value;</div><div class=3D"el=
ementToProof" style=3D"line-height: 19px; white-space: normal; font-family:=
 Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp;qemu_plugi=
n_scoreboard_free(s-&gt;int_count);</div><div class=3D"elementToProof" styl=
e=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp;g_free(s);</div><div class=
=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; font-f=
amily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+}</div><div class=3D"el=
ementToProof" style=3D"line-height: 19px; white-space: normal; font-family:=
 Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">+</div><div class=3D"elementTo=
Proof" style=3D"line-height: 19px; white-space: normal; font-family: Aptos,=
 Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; f=
ont-size: 12pt; color: rgb(0, 0, 0);">+static void vcpu_hardint(qemu_plugin=
_id_t id,</div><div class=3D"elementToProof" style=3D"line-height: 19px; wh=
ite-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServ=
ice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"=
>+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; unsigned int vcpu_index,</div><div class=3D"elementToProof=
" style=3D"line-height: 19px; white-space: normal; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; uint32_t int_req)</div><di=
v class=3D"elementToProof" style=3D"line-height: 19px; white-space: normal;=
 font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+{</div><div clas=
s=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; font-=
family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica,=
 sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp;Int=
Stat *stat =3D NULL;</div><div class=3D"elementToProof" style=3D"line-heigh=
t: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb=
(0, 0, 0);">+</div><div class=3D"elementToProof" style=3D"line-height: 19px=
; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFont=
Service, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, =
0);">+&nbsp;&nbsp; &nbsp;g_mutex_lock(&amp;lock);</div><div class=3D"elemen=
tToProof" style=3D"line-height: 19px; white-space: normal; font-family: Apt=
os, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif=
; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp;{</div><div cl=
ass=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; fon=
t-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetic=
a, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp; =
&nbsp; &nbsp;IntStat key =3D { .vcpu_index =3D vcpu_index };</div><div clas=
s=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; font-=
family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica,=
 sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp; &n=
bsp; &nbsp;stat =3D g_hash_table_lookup(vcpu_int_table, &amp;key);</div><di=
v class=3D"elementToProof" style=3D"line-height: 19px; white-space: normal;=
 font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+</div><div class=
=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; font-f=
amily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp; &nb=
sp; &nbsp;if (!stat) {</div><div class=3D"elementToProof" style=3D"line-hei=
ght: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Apt=
os_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: r=
gb(0, 0, 0);">+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;stat =3D g_ne=
w0(IntStat, 1);</div><div class=3D"elementToProof" style=3D"line-height: 19=
px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFo=
ntService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0=
, 0);">+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;stat-&gt;vcpu_index =
=3D vcpu_index;</div><div class=3D"elementToProof" style=3D"line-height: 19=
px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFo=
ntService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0=
, 0);">+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;stat-&gt;int_count =
=3D qemu_plugin_scoreboard_new(sizeof(uint64_t));</div><div class=3D"elemen=
tToProof" style=3D"line-height: 19px; white-space: normal; font-family: Apt=
os, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif=
; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp;g_hash_table_insert(vcpu_int_table, stat, stat);</div><div cl=
ass=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; fon=
t-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetic=
a, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp; =
&nbsp; &nbsp;}</div><div class=3D"elementToProof" style=3D"line-height: 19p=
x; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFon=
tService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0,=
 0);">+&nbsp;&nbsp; &nbsp;}</div><div class=3D"elementToProof" style=3D"lin=
e-height: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont=
, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; col=
or: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp;g_mutex_unlock(&amp;lock);</div><div=
 class=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; =
font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+</div><div class=
=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; font-f=
amily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp;qemu=
_plugin_u64_add(</div><div class=3D"elementToProof" style=3D"line-height: 1=
9px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSF=
ontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, =
0, 0);">+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;qemu_plugin_scoreboard_u64(stat-&=
gt;int_count),</div><div class=3D"elementToProof" style=3D"line-height: 19p=
x; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFon=
tService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0,=
 0);">+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;vcpu_index,</div><div class=3D"elem=
entToProof" style=3D"line-height: 19px; white-space: normal; font-family: A=
ptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-ser=
if; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp; &nbsp; &nbs=
p;1</div><div class=3D"elementToProof" style=3D"line-height: 19px; white-sp=
ace: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+&nbs=
p;&nbsp; &nbsp;);</div><div class=3D"elementToProof" style=3D"line-height: =
19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MS=
FontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">+}</div><div class=3D"elementToProof" style=3D"line-height: 19px; =
white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSe=
rvice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;">+</div><div class=3D"elementToProof" style=3D"line-height: 19px; white-s=
pace: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+sta=
tic void plugin_exit(qemu_plugin_id_t id, void *p)</div><div class=3D"eleme=
ntToProof" style=3D"line-height: 19px; white-space: normal; font-family: Ap=
tos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);">+{</div><div class=3D"elementToPr=
oof" style=3D"line-height: 19px; white-space: normal; font-family: Aptos, A=
ptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fon=
t-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp;GList *stats =3D g_=
hash_table_get_values(vcpu_int_table);</div><div class=3D"elementToProof" s=
tyle=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_E=
mbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp;for (GList *it =3D stats;=
 it !=3D NULL; it =3D it-&gt;next) {</div><div class=3D"elementToProof" sty=
le=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_Emb=
eddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;IntStat *stat=
 =3D (IntStat *)it-&gt;data;</div><div class=3D"elementToProof" style=3D"li=
ne-height: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFon=
t, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;uint64_t count =3D qe=
mu_plugin_u64_sum(</div><div class=3D"elementToProof" style=3D"line-height:=
 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_M=
SFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;qemu_plugin_score=
board_u64(stat-&gt;int_count)</div><div class=3D"elementToProof" style=3D"l=
ine-height: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;);</div><div class=
=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; font-f=
amily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp; &nb=
sp; &nbsp;printf(&quot;vCPU %u: %&quot; PRIu64 &quot; interrupts\n&quot;, s=
tat-&gt;vcpu_index, count);</div><div class=3D"elementToProof" style=3D"lin=
e-height: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont=
, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; col=
or: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp;}</div><div class=3D"elementToProof"=
 style=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos=
_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-si=
ze: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp;g_list_free(stats);</di=
v><div class=3D"elementToProof" style=3D"line-height: 19px; white-space: no=
rmal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri,=
 Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp=
; &nbsp;g_hash_table_foreach(vcpu_int_table, intstat_free, NULL);</div><div=
 class=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; =
font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbs=
p;g_hash_table_destroy(vcpu_int_table);</div><div class=3D"elementToProof" =
style=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0);">+}</div><div class=3D"elementToProof" style=
=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_Embed=
dedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12=
pt; color: rgb(0, 0, 0);">+</div><div class=3D"elementToProof" style=3D"lin=
e-height: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont=
, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; col=
or: rgb(0, 0, 0);">+QEMU_PLUGIN_EXPORT</div><div class=3D"elementToProof" s=
tyle=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_E=
mbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">+int qemu_plugin_install(qemu_plugin_id_t id,=
 const qemu_info_t *info,</div><div class=3D"elementToProof" style=3D"line-=
height: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, =
Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color=
: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp;int argc, char **argv)</div><div class=3D"e=
lementToProof" style=3D"line-height: 19px; white-space: normal; font-family=
: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">+{</div><div class=3D"element=
ToProof" style=3D"line-height: 19px; white-space: normal; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp;vcpu_int_table =
=3D g_hash_table_new(intstat_hash, intstat_equal);</div><div class=3D"eleme=
ntToProof" style=3D"line-height: 19px; white-space: normal; font-family: Ap=
tos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp;qemu_plugin_r=
egister_vcpu_int_cb(id, vcpu_hardint);</div><div class=3D"elementToProof" s=
tyle=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_E=
mbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp;qemu_plugin_register_atex=
it_cb(id, plugin_exit, NULL);</div><div class=3D"elementToProof" style=3D"l=
ine-height: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp;return 0;</div><div class=3D"eleme=
ntToProof" style=3D"line-height: 19px; white-space: normal; font-family: Ap=
tos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);">+}</div><div class=3D"elementToPr=
oof" style=3D"line-height: 19px; white-space: normal; font-family: Aptos, A=
ptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fon=
t-size: 12pt; color: rgb(0, 0, 0);">diff --git a/contrib/plugins/meson.buil=
d b/contrib/plugins/meson.build</div><div class=3D"elementToProof" style=3D=
"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_Embedded=
Font, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">index fa8a426c8b..17e3b0ec27 100644</div><div class=
=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; font-f=
amily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">---&nbsp;a/contrib/plugi=
ns/meson.build</div><div class=3D"elementToProof" style=3D"line-height: 19p=
x; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFon=
tService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0,=
 0);">+++&nbsp;b/contrib/plugins/meson.build</div><div class=3D"elementToPr=
oof" style=3D"line-height: 19px; white-space: normal; font-family: Aptos, A=
ptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fon=
t-size: 12pt; color: rgb(0, 0, 0);">@@&nbsp;-1,4 +1,4 @@</div><div class=3D=
"elementToProof" style=3D"line-height: 19px; white-space: normal; font-fami=
ly: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">-contrib_plugins =3D ['bbv'=
, 'cache', 'cflow', 'drcov', 'execlog', 'hotblocks',</div><div class=3D"ele=
mentToProof" style=3D"line-height: 19px; white-space: normal; font-family: =
Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">+contrib_plugins =3D ['bbv', 'c=
ache', 'cflow', 'drcov', 'execlog', 'countint', 'hotblocks',</div><div clas=
s=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; font-=
family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica,=
 sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 'hotpages', 'howvec', 'hwpro=
file', 'ips', 'stoptrigger']</div><div class=3D"elementToProof" style=3D"li=
ne-height: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFon=
t, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);">&nbsp;if host_os !=3D 'windows'</div><div class=3D"elem=
entToProof" style=3D"line-height: 19px; white-space: normal; font-family: A=
ptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-ser=
if; font-size: 12pt; color: rgb(0, 0, 0);">&nbsp; &nbsp;# lockstep uses soc=
ket.h</div><div class=3D"elementToProof" style=3D"line-height: 19px; white-=
space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">dif=
f --git a/include/qemu/plugin-event.h b/include/qemu/plugin-event.h</div><d=
iv class=3D"elementToProof" style=3D"line-height: 19px; white-space: normal=
; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Hel=
vetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">index 7056d8427b=
..cd9f9eb25b 100644</div><div class=3D"elementToProof" style=3D"line-height=
: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_=
MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(=
0, 0, 0);">---&nbsp;a/include/qemu/plugin-event.h</div><div class=3D"elemen=
tToProof" style=3D"line-height: 19px; white-space: normal; font-family: Apt=
os, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif=
; font-size: 12pt; color: rgb(0, 0, 0);">+++&nbsp;b/include/qemu/plugin-eve=
nt.h</div><div class=3D"elementToProof" style=3D"line-height: 19px; white-s=
pace: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">@@&n=
bsp;-16,6 +16,7 @@&nbsp;enum qemu_plugin_event {</div><div class=3D"element=
ToProof" style=3D"line-height: 19px; white-space: normal; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp;QEMU_PLUGIN_EV_=
VCPU_TB_TRANS,</div><div class=3D"elementToProof" style=3D"line-height: 19p=
x; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFon=
tService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0,=
 0);">&nbsp; &nbsp; &nbsp;QEMU_PLUGIN_EV_VCPU_IDLE,</div><div class=3D"elem=
entToProof" style=3D"line-height: 19px; white-space: normal; font-family: A=
ptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-ser=
if; font-size: 12pt; color: rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp;QEMU_PLUGIN_=
EV_VCPU_RESUME,</div><div class=3D"elementToProof" style=3D"line-height: 19=
px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFo=
ntService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0=
, 0);">+&nbsp;&nbsp; &nbsp;QEMU_PLUGIN_EV_VCPU_INT,</div><div class=3D"elem=
entToProof" style=3D"line-height: 19px; white-space: normal; font-family: A=
ptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-ser=
if; font-size: 12pt; color: rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp;QEMU_PLUGIN_=
EV_VCPU_SYSCALL,</div><div class=3D"elementToProof" style=3D"line-height: 1=
9px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSF=
ontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, =
0, 0);">&nbsp; &nbsp; &nbsp;QEMU_PLUGIN_EV_VCPU_SYSCALL_RET,</div><div clas=
s=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; font-=
family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica,=
 sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp;QEM=
U_PLUGIN_EV_FLUSH,</div><div class=3D"elementToProof" style=3D"line-height:=
 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_M=
SFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h</div><=
div class=3D"elementToProof" style=3D"line-height: 19px; white-space: norma=
l; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">index 9726a9ebf=
3..f1d5d91141 100644</div><div class=3D"elementToProof" style=3D"line-heigh=
t: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb=
(0, 0, 0);">---&nbsp;a/include/qemu/plugin.h</div><div class=3D"elementToPr=
oof" style=3D"line-height: 19px; white-space: normal; font-family: Aptos, A=
ptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fon=
t-size: 12pt; color: rgb(0, 0, 0);">+++&nbsp;b/include/qemu/plugin.h</div><=
div class=3D"elementToProof" style=3D"line-height: 19px; white-space: norma=
l; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">@@&nbsp;-61,6 +=
61,7 @@&nbsp;union qemu_plugin_cb_sig {</div><div class=3D"elementToProof" =
style=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp;qemu_plugin_vcpu_udata_c=
b_t &nbsp; &nbsp; &nbsp;vcpu_udata;</div><div class=3D"elementToProof" styl=
e=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp;qemu_plugin_vcpu_tb_trans_cb=
_t &nbsp; vcpu_tb_trans;</div><div class=3D"elementToProof" style=3D"line-h=
eight: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, A=
ptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color:=
 rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp;qemu_plugin_vcpu_mem_cb_t &nbsp; &nbsp;=
 &nbsp; &nbsp;vcpu_mem;</div><div class=3D"elementToProof" style=3D"line-he=
ight: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Ap=
tos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: =
rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp;qemu_plugin_vcpu_int_cb_t &nbsp; &nbsp;v=
cpu_hardint;</div><div class=3D"elementToProof" style=3D"line-height: 19px;=
 white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontS=
ervice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0=
);">&nbsp; &nbsp; &nbsp;qemu_plugin_vcpu_syscall_cb_t &nbsp; &nbsp;vcpu_sys=
call;</div><div class=3D"elementToProof" style=3D"line-height: 19px; white-=
space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">&nb=
sp; &nbsp; &nbsp;qemu_plugin_vcpu_syscall_ret_cb_t vcpu_syscall_ret;</div><=
div class=3D"elementToProof" style=3D"line-height: 19px; white-space: norma=
l; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">&nbsp; &nbsp; &=
nbsp;void *generic;</div><div class=3D"elementToProof" style=3D"line-height=
: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_=
MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(=
0, 0, 0);">@@&nbsp;-160,6 +161,7 @@&nbsp;void qemu_plugin_vcpu_exit_hook(CP=
UState *cpu);</div><div class=3D"elementToProof" style=3D"line-height: 19px=
; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFont=
Service, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, =
0);">&nbsp;void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_t=
b *tb);</div><div class=3D"elementToProof" style=3D"line-height: 19px; whit=
e-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServic=
e, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">&=
nbsp;void qemu_plugin_vcpu_idle_cb(CPUState *cpu);</div><div class=3D"eleme=
ntToProof" style=3D"line-height: 19px; white-space: normal; font-family: Ap=
tos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);">&nbsp;void qemu_plugin_vcpu_resum=
e_cb(CPUState *cpu);</div><div class=3D"elementToProof" style=3D"line-heigh=
t: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb=
(0, 0, 0);">+void qemu_plugin_vcpu_int_cb(CPUState *cpu, int interrupt_requ=
est);</div><div class=3D"elementToProof" style=3D"line-height: 19px; white-=
space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">&nb=
sp;void</div><div class=3D"elementToProof" style=3D"line-height: 19px; whit=
e-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServic=
e, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">&=
nbsp;qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1,</div=
><div class=3D"elementToProof" style=3D"line-height: 19px; white-space: nor=
mal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, =
Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">&nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; uint64_t a2, uint64_t a3, uint64_t a4, uint64_t a5,</div><div class=3D"e=
lementToProof" style=3D"line-height: 19px; white-space: normal; font-family=
: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">@@&nbsp;-242,6 +244,9 @@&nbsp=
;static inline void qemu_plugin_vcpu_idle_cb(CPUState *cpu)</div><div class=
=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; font-f=
amily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">&nbsp;static inline void=
 qemu_plugin_vcpu_resume_cb(CPUState *cpu)</div><div class=3D"elementToProo=
f" style=3D"line-height: 19px; white-space: normal; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">&nbsp;{ }</div><div class=3D"elementToPro=
of" style=3D"line-height: 19px; white-space: normal; font-family: Aptos, Ap=
tos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">&nbsp;</div><div class=3D"elementToProof=
" style=3D"line-height: 19px; white-space: normal; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">+static inline void qemu_plugin_vcpu_int_c=
b(CPUState *cpu, int interrupt_request)</div><div class=3D"elementToProof" =
style=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0);">+{ }</div><div class=3D"elementToProof" styl=
e=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">+</div><div class=3D"elementToProof" style=3D"li=
ne-height: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFon=
t, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);">&nbsp;static inline void</div><div class=3D"elementToPr=
oof" style=3D"line-height: 19px; white-space: normal; font-family: Aptos, A=
ptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fon=
t-size: 12pt; color: rgb(0, 0, 0);">&nbsp;qemu_plugin_vcpu_syscall(CPUState=
 *cpu, int64_t num, uint64_t a1, uint64_t a2,</div><div class=3D"elementToP=
roof" style=3D"line-height: 19px; white-space: normal; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; uint64_t a3, uint64_t =
a4, uint64_t a5, uint64_t a6,</div><div class=3D"elementToProof" style=3D"l=
ine-height: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">diff --git a/include/qemu/qemu-plugin.h b/include/qemu=
/qemu-plugin.h</div><div class=3D"elementToProof" style=3D"line-height: 19p=
x; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFon=
tService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0,=
 0);">index 3a850aa216..65096c4c64 100644</div><div class=3D"elementToProof=
" style=3D"line-height: 19px; white-space: normal; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">---&nbsp;a/include/qemu/qemu-plugin.h</div=
><div class=3D"elementToProof" style=3D"line-height: 19px; white-space: nor=
mal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, =
Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+++&nbsp;b/in=
clude/qemu/qemu-plugin.h</div><div class=3D"elementToProof" style=3D"line-h=
eight: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, A=
ptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color:=
 rgb(0, 0, 0);">@@&nbsp;-728,6 +728,23 @@&nbsp;const void *qemu_plugin_requ=
est_time_control(void);</div><div class=3D"elementToProof" style=3D"line-he=
ight: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Ap=
tos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: =
rgb(0, 0, 0);">&nbsp;QEMU_PLUGIN_API</div><div class=3D"elementToProof" sty=
le=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_Emb=
eddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">&nbsp;void qemu_plugin_update_ns(const void *ha=
ndle, int64_t time);</div><div class=3D"elementToProof" style=3D"line-heigh=
t: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb=
(0, 0, 0);">&nbsp;</div><div class=3D"elementToProof" style=3D"line-height:=
 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_M=
SFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">+typedef void</div><div class=3D"elementToProof" style=3D"line-he=
ight: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Ap=
tos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: =
rgb(0, 0, 0);">+(*qemu_plugin_vcpu_int_cb_t)(qemu_plugin_id_t id,</div><div=
 class=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; =
font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; unsigned int vcpu_index,</div><div class=3D"eleme=
ntToProof" style=3D"line-height: 19px; white-space: normal; font-family: Ap=
tos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; uint32_t interrupt_request);</div><div class=3D"elementToProof" =
style=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0);">+</div><div class=3D"elementToProof" style=
=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_Embed=
dedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12=
pt; color: rgb(0, 0, 0);">+/**</div><div class=3D"elementToProof" style=3D"=
line-height: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedF=
ont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; =
color: rgb(0, 0, 0);">+&nbsp;* qemu_plugin_register_vcpu_int_cb() -</div><d=
iv class=3D"elementToProof" style=3D"line-height: 19px; white-space: normal=
; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Hel=
vetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;* &nbsp; =
register a vCPU hardware interruption callback</div><div class=3D"elementTo=
Proof" style=3D"line-height: 19px; white-space: normal; font-family: Aptos,=
 Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; f=
ont-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;* @id: plugin ID</div><div cla=
ss=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; font=
-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica=
, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;* @cb: callback=
 function</div><div class=3D"elementToProof" style=3D"line-height: 19px; wh=
ite-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServ=
ice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"=
>+&nbsp;*</div><div class=3D"elementToProof" style=3D"line-height: 19px; wh=
ite-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServ=
ice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"=
>+&nbsp;* The @cb function is called every time a vCPU gets hardware interr=
uption.</div><div class=3D"elementToProof" style=3D"line-height: 19px; whit=
e-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServic=
e, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+=
&nbsp;*/</div><div class=3D"elementToProof" style=3D"line-height: 19px; whi=
te-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">=
+QEMU_PLUGIN_API</div><div class=3D"elementToProof" style=3D"line-height: 1=
9px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSF=
ontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, =
0, 0);">+void qemu_plugin_register_vcpu_int_cb(qemu_plugin_id_t id,</div><d=
iv class=3D"elementToProof" style=3D"line-height: 19px; white-space: normal=
; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Hel=
vetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;qemu_plugin_v=
cpu_int_cb_t cb);</div><div class=3D"elementToProof" style=3D"line-height: =
19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MS=
FontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">+</div><div class=3D"elementToProof" style=3D"line-height: 19px; w=
hite-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">&nbsp;typedef void</div><div class=3D"elementToProof" style=3D"line-heigh=
t: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb=
(0, 0, 0);">&nbsp;(*qemu_plugin_vcpu_syscall_cb_t)(qemu_plugin_id_t id, uns=
igned int vcpu_index,</div><div class=3D"elementToProof" style=3D"line-heig=
ht: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Apto=
s_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rg=
b(0, 0, 0);">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; int64_t num, uint6=
4_t a1, uint64_t a2,</div><div class=3D"elementToProof" style=3D"line-heigh=
t: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb=
(0, 0, 0);">diff --git a/plugins/core.c b/plugins/core.c</div><div class=3D=
"elementToProof" style=3D"line-height: 19px; white-space: normal; font-fami=
ly: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">index eb9281fe54..b6fbfe20e=
9 100644</div><div class=3D"elementToProof" style=3D"line-height: 19px; whi=
te-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">=
---&nbsp;a/plugins/core.c</div><div class=3D"elementToProof" style=3D"line-=
height: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, =
Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color=
: rgb(0, 0, 0);">+++&nbsp;b/plugins/core.c</div><div class=3D"elementToProo=
f" style=3D"line-height: 19px; white-space: normal; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">@@&nbsp;-539,6 +539,23 @@&nbsp;void qemu_=
plugin_vcpu_resume_cb(CPUState *cpu)</div><div class=3D"elementToProof" sty=
le=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_Emb=
eddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp;}</div><div class=3D"elemen=
tToProof" style=3D"line-height: 19px; white-space: normal; font-family: Apt=
os, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif=
; font-size: 12pt; color: rgb(0, 0, 0);">&nbsp;}</div><div class=3D"element=
ToProof" style=3D"line-height: 19px; white-space: normal; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">&nbsp;</div><div class=3D"elementTo=
Proof" style=3D"line-height: 19px; white-space: normal; font-family: Aptos,=
 Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; f=
ont-size: 12pt; color: rgb(0, 0, 0);">+/*</div><div class=3D"elementToProof=
" style=3D"line-height: 19px; white-space: normal; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">+&nbsp;* Disable CFI checks.</div><div cla=
ss=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; font=
-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica=
, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;* The callback =
function has been loaded from an external library so we do not</div><div cl=
ass=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; fon=
t-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetic=
a, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;* have type in=
formation</div><div class=3D"elementToProof" style=3D"line-height: 19px; wh=
ite-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServ=
ice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"=
>+&nbsp;*/</div><div class=3D"elementToProof" style=3D"line-height: 19px; w=
hite-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">+QEMU_DISABLE_CFI</div><div class=3D"elementToProof" style=3D"line-height=
: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_=
MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(=
0, 0, 0);">+void qemu_plugin_vcpu_int_cb(CPUState *cpu, int interrupt_reque=
st)</div><div class=3D"elementToProof" style=3D"line-height: 19px; white-sp=
ace: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+{</d=
iv><div class=3D"elementToProof" style=3D"line-height: 19px; white-space: n=
ormal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri=
, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbs=
p; &nbsp;struct qemu_plugin_cb *cb, *next;</div><div class=3D"elementToProo=
f" style=3D"line-height: 19px; white-space: normal; font-family: Aptos, Apt=
os_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-=
size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp;enum qemu_plugin_even=
t ev =3D QEMU_PLUGIN_EV_VCPU_INT;</div><div class=3D"elementToProof" style=
=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_Embed=
dedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12=
pt; color: rgb(0, 0, 0);">+</div><div class=3D"elementToProof" style=3D"lin=
e-height: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont=
, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; col=
or: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp;QLIST_FOREACH_SAFE_RCU(cb, &amp;plug=
in.cb_lists[ev], entry, next) {</div><div class=3D"elementToProof" style=3D=
"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_Embedded=
Font, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;qemu_plugin_vcpu_i=
nt_cb_t func =3D cb-&gt;f.vcpu_hardint;</div><div class=3D"elementToProof" =
style=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;func(cb-&g=
t;ctx-&gt;id, cpu-&gt;cpu_index, interrupt_request);</div><div class=3D"ele=
mentToProof" style=3D"line-height: 19px; white-space: normal; font-family: =
Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp;}</div><div=
 class=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; =
font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+}</div><div class=
=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; font-f=
amily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">+</div><div class=3D"ele=
mentToProof" style=3D"line-height: 19px; white-space: normal; font-family: =
Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">&nbsp;void qemu_plugin_register=
_vcpu_idle_cb(qemu_plugin_id_t id,</div><div class=3D"elementToProof" style=
=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_Embed=
dedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12=
pt; color: rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; qemu_plugin_vcpu_simple_cb_t cb)</div><div class=3D"element=
ToProof" style=3D"line-height: 19px; white-space: normal; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">&nbsp;{</div><div class=3D"elementT=
oProof" style=3D"line-height: 19px; white-space: normal; font-family: Aptos=
, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">@@&nbsp;-551,6 +568,12 @@&nbsp;void =
qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,</div><div class=3D=
"elementToProof" style=3D"line-height: 19px; white-space: normal; font-fami=
ly: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp;plugin_=
register_cb(id, QEMU_PLUGIN_EV_VCPU_RESUME, cb);</div><div class=3D"element=
ToProof" style=3D"line-height: 19px; white-space: normal; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">&nbsp;}</div><div class=3D"elementT=
oProof" style=3D"line-height: 19px; white-space: normal; font-family: Aptos=
, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">&nbsp;</div><div class=3D"elementToP=
roof" style=3D"line-height: 19px; white-space: normal; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">+void qemu_plugin_register_vcpu_int_cb=
(qemu_plugin_id_t id,</div><div class=3D"elementToProof" style=3D"line-heig=
ht: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Apto=
s_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rg=
b(0, 0, 0);">+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp;qemu_plugin_vcpu_int_cb_t cb)</div><div class=3D"elementToP=
roof" style=3D"line-height: 19px; white-space: normal; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">+{</div><div class=3D"elementToProof" =
style=3D"line-height: 19px; white-space: normal; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0);">+&nbsp;&nbsp; &nbsp;plugin_register_cb(id, Q=
EMU_PLUGIN_EV_VCPU_INT, cb);</div><div class=3D"elementToProof" style=3D"li=
ne-height: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFon=
t, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);">+}</div><div class=3D"elementToProof" style=3D"line-hei=
ght: 19px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Apt=
os_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: r=
gb(0, 0, 0);">+</div><div class=3D"elementToProof" style=3D"line-height: 19=
px; white-space: normal; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFo=
ntService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0=
, 0);">&nbsp;void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,</div><=
div class=3D"elementToProof" style=3D"line-height: 19px; white-space: norma=
l; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">&nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; qemu_plugin_simple_cb_t cb)</div><div c=
lass=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; fo=
nt-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">&nbsp;{</div><div cl=
ass=3D"elementToProof" style=3D"line-height: 19px; white-space: normal; fon=
t-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetic=
a, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">--</div><div class=3D=
"elementToProof" style=3D"line-height: 19px; white-space: normal; font-fami=
ly: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">2.39.5</div><div class=3D"e=
lementToProof" style=3D"line-height: 19px; white-space: normal; font-family=
: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);"><br><br></div><div class=3D"e=
lementToProof" style=3D"white-space: normal; font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);"><br></div></pre>
</body>
</html>

--_000_ME3P282MB27933F3CA48FA7C7EB0BCBBFA692AME3P282MB2793AUSP_--

