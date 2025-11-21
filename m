Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8FDCFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 01:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMchg-0007d8-MO; Fri, 21 Nov 2025 20:46:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konrad.schwarz@siemens.com>)
 id 1vMbOv-0003w6-1T
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:22:54 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konrad.schwarz@siemens.com>)
 id 1vMbOj-0002MS-32
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:22:49 -0500
Received: from GVXPR10MB8827.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1de::7)
 by GVXPR10MB8455.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 21:03:29 +0000
Received: from DU4PR10MB9022.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:564::9)
 by GVXPR10MB8827.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 18:08:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZ2nNhkZMpirq+WlQQD3M211KhRttZcoYNw+4cLWagDE58M4XLDMoI9eQm6qL6A9aWFxtXN/hrQ/cykreEwhGiA92yikG4pl379XVBVjAxFcomo1uCcIlm0nWdIuXjh8UyrBEOrMF0JIKd/FNEA6FdGPqHtbdCmXqJS6cJ1Z0BD8NguBFivGxrbqnhGYvm28dP5Xm/+rsDZq9Nzm9S8pP48IY/aVkc2uaPjfnpENLAVfSSj064QVAxkvZLSOL4raqb61vgQ7S5CAc1zR1nYhT5QhaBzl5RgyTPh0zxTlVs6UN4u29HHj9pXucpAgItEu/znZfMZHMWW6ydI9PxGIbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPXQJEEWnGsCybIyOMu2KdBTU2rQu2FrDUzLsdj5wyY=;
 b=ZRXbPbaG5vOyhbUsaG0WduHA9Pt2yAl72hQdqK1JQybxtNItu9l4Sib/O0wT7iBGtrUzKbZ9qAFya2cPLGbCM16sh682SMgqpOoGtO2qoYfQBfi1Rs+hC0RiVk4XjzVzcGJWHqFgs6b01mn13EDyKad0gL0rJct7TYCnsuZnJXinqKzHWP+23p/nUQshOptz6S520OvZuOImIzE7qAqrUcRt1se0dhqmaDonWai3vH00JmjXfURpfPQdE8njNwcbe8aSCLYDut/TP0HCS+xS17Ijk6m+6GVJHAmp4P75GQNGhV1FAVATBWKssdSCUdoDpEBO/PWFT7O/5sCcc6z58w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPXQJEEWnGsCybIyOMu2KdBTU2rQu2FrDUzLsdj5wyY=;
 b=nUmnMdGJyoLfxF5XXwQM3qXTibqpX6cN0+t14T3os645mtn25P8KCJVzvTZX1I0G3LQjmVW9bLBlbI4RYmet4y15wELQuAi6c0WEywFqo/ZDDw83VQAKdyaF9uFlSlnPA4s2WYYPgOvlAs93Vn8zCTpT6EAcZ9zj9WPTnS3CvMixFD7aN0Udexvf5Nv7imPegFWuxSF6nrQN6ZhhfVkQOo0+mq9I0NuhjZpVm7StUKk9F1XHOgtPBEvipSPpOKXQkI0XF5yaMXkJyhZ2RX9yngmvuEOO7KqCjlHg0s7M28+fivIH9D4L5xNDfk9YBTR1Iw1F2OUnThL5M6FanuPa7A==
Received: from AS8PR10MB4680.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:33c::13)
 by DU4PR10MB9022.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:564::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 14:07:37 +0000
Received: from AS8PR10MB4680.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::214b:9b1d:acac:e64b]) by AS8PR10MB4680.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::214b:9b1d:acac:e64b%4]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 14:07:37 +0000
From: "Schwarz, Konrad" <konrad.schwarz@siemens.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "konrad.schwarz@gmail.com" <konrad.schwarz@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "philmd@linaro.org"
 <philmd@linaro.org>
Subject: RE: [PATCH 1/1] scripts: Changed potential O(n) file size calculation
 to O(1)
Thread-Topic: [PATCH 1/1] scripts: Changed potential O(n) file size
 calculation to O(1)
Thread-Index: AQHcWXoCyaQlcz8AKEufgNoVu9G9F7T87MOAgAAOy4CAADEsMA==
Date: Fri, 21 Nov 2025 14:07:37 +0000
Message-ID: <AS8PR10MB4680196D449C8FE8C12710A88AD5A@AS8PR10MB4680.EURPRD10.PROD.OUTLOOK.COM>
References: <CA+kmUXafV4PPo2t+P23g9QRXHjaH_XBke3DjzbvciqBtw+i-OA@mail.gmail.com>
 <dee22f22-c2e5-4154-99a7-525bfeb965af@siemens.com>
 <aSBIUz8PxYZHncVN@redhat.com>
In-Reply-To: <aSBIUz8PxYZHncVN@redhat.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=a9cecca8-a0f1-464c-a845-db932b21261d;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-11-21T14:05:06Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB4680:EE_|DU4PR10MB9022:EE_|GVXPR10MB8827:EE_|GVXPR10MB8455:EE_
x-ms-office365-filtering-correlation-id: 4a70e522-413a-4e8a-29d1-08de2907537f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?QmpDTmRQeVhMM0NaOHhBaVgzeVorY1dpdUVkWXNmU1E2MjdESDM1eUxLMFdm?=
 =?utf-8?B?WlBTajVBa1RLL0swZ1Y3Y2c3UzB0SkhmVVJ6SzVFZjg5d3N4bStMaU4rbHlp?=
 =?utf-8?B?UnBlc0xPR3NpN1dNbUVmSVRESStBQXZicGZnak1PdkhGaW9WaHpleCtPU29G?=
 =?utf-8?B?MlhYbUU1OHQzMmM0dmhGME5HWnlGWWFyTkdkRHUrQ1U3SFVIN2dndmtKU0Zm?=
 =?utf-8?B?bE1lNWhYMXlQWEdDZ0NjUFc0Z0Jva2FDbWNJUHF5MXFQYytRS05IOGdMdWdv?=
 =?utf-8?B?VjY2RDlMY0gwMlpsdksrQTBwTUlqdHJCOERaUVRYMEh2dDZ3STA1TzFHVThu?=
 =?utf-8?B?S2QvWW5YVmx5MEJiSEJUNFVwRWFoaGM2Y3p1dEtHQXJpbmxWVnVKZ3Znc3hH?=
 =?utf-8?B?ejRuOU9Vd2xNNEZqbW1OcnVKcHZPalkralR3YkxqaTJ4RlRwVzVhNjV6V1NL?=
 =?utf-8?B?Q21TTzFudDM4NlZZNUh2aUJhN2VIU25LdnNGTzYwSGM2ZzEyc3dZLzgyNUQ5?=
 =?utf-8?B?NTQ2dHNMVzk1aHZ4aS9xMmhRRE0wVUw3OFA5ZjVRb3oxbmxHTHhnTEhyREZs?=
 =?utf-8?B?VGQxanorUFBIVFR6TFlSMnVWQ2VCN004Y1kxdmtmOUtUQXVPYUp0MjEwc3d6?=
 =?utf-8?B?R1VHbENLSmlzNVpMN1g0NjNvZENZc3dqckUxRXMwUmk0Y1R0bVFoWFBxWUVF?=
 =?utf-8?B?eTdyZE52akd5bjI1MG1xMldhSEdXak9IRzFDYUlrOXd0WU9PdHBLSkFGRnZo?=
 =?utf-8?B?OXpncEg5N0t5djMxTzBkSjhkZkJtMjd6S09qRGE2a3dKaitkS1J2bWlGVmkz?=
 =?utf-8?B?ck8xYmw5ZlhNYjhKT2F0ZmNiQ3NSZEJ2dGlNV1Q1M0FpNHE5aDRaekZYc3Jw?=
 =?utf-8?B?OFNhcnE1bEJrUDE3cTNkTVlkU2FKSTlKUVE5NHU2ZXd4YWlvdW9TWkVLTWNl?=
 =?utf-8?B?bWJBa3plWkl1QnBTWFhKd0lBYUorWlUvSlkyZ3I0RG5HZW9YZTNNc0tXWEd5?=
 =?utf-8?B?WlFMVXBUMklsLzhkSTN5V3Bkd2NMZFhqdXJNSFBESDRiM1lrdy83QXVWODZr?=
 =?utf-8?B?a3NKaER5OENTT0NCRGhlK0xRN2Q4bzk4SkdPMXNWZlFkYWp0eml6M253Rnc1?=
 =?utf-8?B?cExQalZtVTVkVWdJSFVRTGRCbFgwRFNURkVwaVYyb280eVBOMTk1cTFtdHVQ?=
 =?utf-8?B?TUhCZ3BOUUU3VnNmRG9oWXBkUlZSZFlxakZhdzdVelJ3QmY1VDc3bDZNTHZ4?=
 =?utf-8?B?aThvVzMzVjNLL0VJSS9BRUlpNUhnL1NndHNxbHloQlk1cTFvajMxdnFHVENF?=
 =?utf-8?B?bjRNOUMrVUtBTHdNQU8zYlNBb2F5aEdYOVV6RHhpVmRHbVloeEwyRm9XMG5E?=
 =?utf-8?B?bmE1a29NSmVXTzJkY2JnYVZ1TlZyb1dOdjVMVVVOcjhJTzhJeUw0U1hzbGVR?=
 =?utf-8?B?QytuMHVscnBxcllDbEZsMUd2dnAxMCt0MS9sbDJsb0x1NUFtUGVnbWxsVUNx?=
 =?utf-8?B?Ym04aFQ5Q3JJekpqOENKdUNQM0tYUmM1aUowQytMWnRJQkg2MTdJYWdSTWM4?=
 =?utf-8?B?T3p0SWZzck90NTltei9lWmlKYWJEWlR3d1VTZ3RLSkRpTU15RWplbjRUSFp2?=
 =?utf-8?B?N1JLVmEwTXB6d3JsUi8xZjlFUFlSVm83Q0x2UlFVMHVUQTJoUld1ajJwbW85?=
 =?utf-8?B?eUVQSFlJalFZZ0RwZWFGdUJLQlRlWVVjOExzbE1IR0U5TDFqS3BJbk1QTjFH?=
 =?utf-8?B?RjZXbjNQUFErempNUm52akFRU0htcGU2WkdLc0ZHeUhLTDZQZzBGMjA4bnBR?=
 =?utf-8?B?ODd2TU41a2c0OVpnQWd3R2svWTAxOWoxa1NNWDVMUEdYMlBmNEU2eUtSbms1?=
 =?utf-8?B?eFhpV25QV2JzVURPaVhiUWJ0elpPSlNjWGk0S04zeVJ4Wi92aHVkOEJGbFB4?=
 =?utf-8?B?MnlaME9uc1diZ2htR1JHZFhxZDNaL0RseG9vVnYzRWFwTEVKY3VGN2dHaHlG?=
 =?utf-8?B?c3llV1lBWThYTi9saWNLbCtVZXNsSzFqZTBrWEZkZGRTMjk0OU5KWGlqdnc2?=
 =?utf-8?Q?iJdIQM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB4680.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFNFOTlzZmE3R1lGbnZ3UVVsbTlCL1RNZWdmN0hoTHhGYjdlSjhZVjRBeXh1?=
 =?utf-8?B?SUVxQ1V5Z0h1TDE5NFNSNmErRzhiTEc2VE5KbUNNNVhqSHFhblp0djVxTUoy?=
 =?utf-8?B?SldTWXhubUpZSmNDUjRpVmFMVWR6Vk0xdi9FQS9adDJ6QVRScHp4Ykd1cnhj?=
 =?utf-8?B?d2VmN0RsbjVpL0xEUllvMHoyRlZNcWhndmo4Z0VRNmFDeE9ySVZnMlZmdlE2?=
 =?utf-8?B?Q2NIai9HdDBuTVRVWGY1aTBndWY2anhmWExwdk5aTVlCU2d5MVEwTnpnUkMv?=
 =?utf-8?B?cW9PZGpYNTFJQXU1SnNVQ25hR0FNWkxjT2JnT3M1enpmd0lvTTVzMlZMUUl5?=
 =?utf-8?B?eE1SalVsSDNXRWEzMUJqZkZBYXY0VHp5dFBzZWlYTVFvdU9KMHBKeWR2MXc0?=
 =?utf-8?B?TTZZdGZ2M01oNDY3NElzSnFWQXc2VkI3LzZva1JUdnJPeTN2TE8yWlNKRWFV?=
 =?utf-8?B?YzdPS3VHQjZZTitndHY5ZzBEUkFORkpxdDUydlkwOTIyMk5IU3FxRXZwU3pQ?=
 =?utf-8?B?Z3lVSFh0bHh6RVVrekZ2SXBOL3ZxamlzM05iMm04aVp1ZU5oeDArNFlBdTg3?=
 =?utf-8?B?enNZU0xrSHR1MmhXb1NKMGJ6WGVDUVBnU0RhUlRpa0RCZzVRWGxpTDhwM2Z6?=
 =?utf-8?B?SzNqTGhkSWRnTmhhT1VYYzBWK0JpZFgvbXBpSndKOWJ4Vmw4d05DZzVyVXht?=
 =?utf-8?B?TWthbFpseXkxK3NYSDM0TjZRWXRaN2JzQ21tblRieUxRaG84QTJFdTN2OXVR?=
 =?utf-8?B?a1NOYncvVG10VktWTUpiVDdJV3ZoT05kNmZVbUh4ZFRyRVBIM09FdDJ1K1BG?=
 =?utf-8?B?SkQrdS9XNzJBTzY4dFpYWFdYNzVNN3VCZ3VjZUhlMGs3eCtvZ3BWOFoxK2h0?=
 =?utf-8?B?TlNHMVRFcDE2K2d3MFlLUnRRYnF1bnEybDk3WStwR2luL2VUTUw3Y3htSTg0?=
 =?utf-8?B?RWFSVmFIUHM3NTNGQ2VqVUphMlpoTnlpVzk3czdON1VObUI3bVN3TElYZi9Q?=
 =?utf-8?B?ZDd0MlRsSW1kdmJodHJUVTdWUUV2NTN4bXRGSlZoQWczOU9mekpPQmFYTnBW?=
 =?utf-8?B?Qko4ZHdEV2hvdGpERmN6L1V6aTBmcERWQUJyY3FXM3dvNXZ3NHlMSjlsSzBq?=
 =?utf-8?B?RVRpVHVsVGdhOXY4QVFMUS9ZVEdYZmpSTTZ5QkRUNFlrbUIzOEtQTDdPLzAy?=
 =?utf-8?B?emV5Q0MzK3JrRFFnc2hhaDdkdnpOeFp4VFR3dTVQbFFBbFVIVEoyRlE0M2dY?=
 =?utf-8?B?QnBNcHVYTWZRWkEvb2FLRlVYR3NBQWNKUU13QnNSTTFDbFhWLzl2NTZJYjkx?=
 =?utf-8?B?L2ZrVXVmdWg3cGpQaXNxZVV2K3VSaVBKaUcwbXV2NGFpdnV6djRyRVZlT1RI?=
 =?utf-8?B?dVNmdWQ4WmtGaDF4N0NhUThRZ0lGQjdaNEtrZ2tsb3lGVDZ4M1BFQnF2Wm9D?=
 =?utf-8?B?L1pwUWxrTE14S1RHVkdIM1ZnMWxVdXQzM2c5N0dMS2YyZDFhS3ZybHVYbWc2?=
 =?utf-8?B?UkxOSWo3SXloVnZ1Vkc4M09PNmlBTG5UeHBkUkxhdk5VY3YwekphRzFxR2hu?=
 =?utf-8?B?bmwzZi9wU1lYaENrTVhOc0dTK3NuR0VIVTRpRUFobllGQVI2bDRLdWNPVU5m?=
 =?utf-8?B?N1RYUVp0QzVyODF2cUdxR01IaTUxdDRKei8zVHBaczI1eEtPYVYzT1hXV1pr?=
 =?utf-8?B?eXJJTTlRZE15Mll4ZTNPOVpzOVFDVlU5Sm9tVDZmQk1mcFdPODBIQUEza1N3?=
 =?utf-8?B?UkRtbFcxOXhBN3dOWmd4VnlycVRYcXVFU0QyaTJTNTRqc3MrbnpUV2lRalJP?=
 =?utf-8?B?SEVFMU9xV0JsL0xVendLN3ZQSVU4MTRmcTFKclZvc041RWxuZ0tCOUtaZmt5?=
 =?utf-8?B?dUIrTWExYmxiS21FUFBYVHZYK0lWellleUhvdm4rOUVWMnpaR2krekhyOTdB?=
 =?utf-8?B?bXBYNG1vK041a1dkSWJvQUVaWVhJVHV5Y1A3aVl1MXNEcG5qcTVMMXg5UXBh?=
 =?utf-8?B?ZmpaRFlkQSs4cnI2UGJ5VFgzcllXZHpWWExXTEwwMGZqcVl0OHdvN0toQ3RK?=
 =?utf-8?B?QUJReUxZKzAvVHljRThjakNWaW9LQmtLcGc4TWhPUnBrRnV5TVh3YnR0M1ZD?=
 =?utf-8?B?MmJDLzlPVE9XS0xyV2xZMm5KOTlpalI1ck8reEZPaE9FNkdyVmN0ZWJibmsv?=
 =?utf-8?B?UVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB4680.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a70e522-413a-4e8a-29d1-08de2907537f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 14:07:37.4949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6+E9MzYkLCssMEupIt7fd2C2tPotoV8PVmiohMc3ysbZfF+MfYwWIZChOPtGu4FTNH+m4GqTyubscTnrxuc3XL6qNWxzfsdf4+TSitQEuuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9022
X-OriginatorOrg: siemens.com
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=konrad.schwarz@siemens.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

PiBGcm9tOiBEYW5pZWwgUC4gQmVycmFuZ8OpIDxiZXJyYW5nZUByZWRoYXQuY29tPg0KPiBTZW50
OiBGcmlkYXksIE5vdmVtYmVyIDIxLCAyMDI1IDEyOjA5DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
MS8xXSBzY3JpcHRzOiBDaGFuZ2VkIHBvdGVudGlhbCBPKG4pIGZpbGUgc2l6ZSBjYWxjdWxhdGlv
biB0bw0KPiBPKDEpDQoNCj4gPiBsc19saW5lPSQobHMgLUhkb2cgIiQxIiAyPi9kZXYvbnVsbCkg
fHwgcmV0dXJuDQo+ID4NCj4gPiA+ICsgICBwcmludGYgJXNcXG4gIiRsc19saW5lIiB8IGN1dCAt
ZFwgIC1mMw0KPiA+ID4gKyAgIHVuc2V0IGxzX2xpbmUNCj4gDQo+IFRoaXMgcGFyc2luZyBvZiAn
bHMnIG91dHB1dCBjb3VsZCBiZSBzaW1wbGlmaWVkIGJ5IHVzaW5nIHRoZSAnc3RhdCcgY29tbWFu
ZA0KPiB3aXRoIGEgZm9ybWF0IHN0cmluZyB0byByZXF1ZXN0IG9ubHkgdGhlIGZpbGUgc2l6ZS4N
Cj4gDQo+ICAgICBzdGF0IC0tZm9ybWF0PSVzICIkMSINCg0KVGhlIHVzZSBvZiBgd2MnIHJlc3Vs
dHMgZnJvbSB0aGUgZmFjdCB0aGF0IGBzdGF0JyBpcyBub3QgYXZhaWxhYmxlIG9uIGFsbCBwbGF0
Zm9ybXMsDQppTWFjT1MgaW4gcGFydGljdWxhciwgdG8gbXkga25vd2xlZGdlLg0K

