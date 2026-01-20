Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9506D2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 09:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi8Oz-0005s5-8P; Tue, 20 Jan 2026 04:51:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@hotmail.com>)
 id 1vi8Ox-0005qE-EK
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 04:51:55 -0500
Received: from mail-japaneastazolkn19013083.outbound.protection.outlook.com
 ([52.103.43.83] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@hotmail.com>)
 id 1vi8Ov-0000R0-RZ
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 04:51:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2ltGJcMbtIjsBvu9RkboM/2kpFAWRkiSa4s7fxS35bXFhag20MkQF2DQkwU7G31nCxJpAayUGpdW8+Bckp8S6bQT9jaFdh8oWUtQIReb3Isb8kUdg9i+4HfgCcK8fHVtuEXykYl3k3w0L/wz3l2k3v3KIj8AsLSMyd26zB3MueFNi/ONLPdWSd/bo9R8d5CIm/AQeGeGo4mPw8q3GjOAFixQ9DClm+jbgcInHS/Ioiy9yUc9mrSNASiowcZGtjRtEJMi/U0LPoI/rAma6Bu9/S7OZfyFIzDqF1UoOi/fkQB75nVS3ipTfQeLf68q4GYFeXLJiw9kVgrhckS2h0qRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JI/WL3g8fnpzcEJVAJziCplDsxPX0bygUM2BXJ5C4fc=;
 b=giUF3fwmgXCO4bW4G1Xo27UEZOdPPJWPaVfCoZYaNTl9DwSmC0VM5WDh+Wsuv0WOFQsoUs8f++vPgHfKW18xa4Dvi6eF8VrhD1+sT0kAYVzFTqGCx/zS1vp4GYxk6tDtqgIZUOqE1i+/XZdE1F/P4QN+6pDzuvoGPjdbcG8KJCkJ0ecz9JCZqnZ7PP25LCCNLliqvXt7vpWYrANb0lgZaXr1Z9vtRaYl+12fiSKYB85D7Ec5I+WNveIYhtgVMBrDqW0Nwimm0VgqRyEuOMKgjzrvjeL/BegnrIseUEYRAYitld4Kr08fsLfV6OFRPH16TK6dz5Hm72YByYqC9+qeKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JI/WL3g8fnpzcEJVAJziCplDsxPX0bygUM2BXJ5C4fc=;
 b=VVrmqR1ezI5sO2B/I3B057bRybybbKqB1YUGqVcrq5HRhQTMn8OrAnD8WwHgnDwXFtXZXW5Kip+eTP9FNl5uhyGAs9l65L7aXbt//9RnIvzWxGoLR0UeFeDMuA1UvtTA3fFLpy8D85mulFWlPmC5MmVKTupGR4cQ+QN4bbbbGVejW5mYOGbAw/3DdmPahUl3I+LBBMntzNGFeWidfPlMZiwAa9QI3Id1mF6mwIBiDuaLoVuEKERhw06G4W0ygf7WIk6IA/B6IPhU+LhSCxDIF9Sf2hsKDCNBkktuoA1jMQFIc007TqgTzLDuYFvNFp5sXSPw7xEw99ynilnu+O3ZEw==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEYPR01MB4559.apcprd01.prod.exchangelabs.com
 (2603:1096:101:82::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 09:46:46 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 09:46:46 +0000
Message-ID: <SI2PR01MB43934DBDFC848805DF657064DC89A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Tue, 20 Jan 2026 17:46:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/i386: Reserve 0x8000001D and 0x8000001E if
 !CPUID_EXT3_TOPOEXT
To: eduardo@habkost.net, pbonzini@redhat.com, qemu-devel@nongnu.org
References: <SI2PR01MB4393C152E5D8E3E964AA9E02DC87A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <SI2PR01MB4393C152E5D8E3E964AA9E02DC87A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SL2P216CA0138.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1::17) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID: <a42f139d-9d16-46ee-8017-097c26e5adc4@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEYPR01MB4559:EE_
X-MS-Office365-Filtering-Correlation-Id: a4511fda-baa7-4889-622c-08de5808d2ab
X-MS-Exchange-SLBlob-MailProps: laRBL560oLS7IWERjHonlu/qsKr3Bu1ZEhpxW2zYnY+DDzCVOfjk1sf/rGTgb3a5x8Qj14WTtsks29uqpsB81ic5SXqhBN+uedASVUhzBgsd9GSgKqg7VkWfu0OhvKtKQFx7JFx1Wp+uxpzdQ21R2HlI+7MV2EhqFye1toh/WV2onC+y4G/DBRRi3FGceNqA9cfvEXTofPiKaN1TauIL6LuN4aUVV1z+VZzb0z5qhs9p7M7KVHiFfF5kyuQ+4FssnCNcnDcVnUJaxCc9DYCbzWfED0zJhog5SCAJ/3Oh6kOLsjpJxsyRswd5kfw8TZ1sdhovaYxsOqAlvAJpVhbqIYcO6HAI4dj9uIpMUyX6x+MbwEcT3zgEdwhIa8cFo8UFHh69KQg3CfqwGtDP7V5q9HB2MDVGGDT1y24qAfJcrC2AKrkN0InfkqCn3BOOhvTtTch6fPBQkY1Yj3h+eCzUinnBT4fYmMaPdfaVaOzzSXcOS8L1fV5MonP4SucuvQ+UU93N+kvJCn7nO7Cp9VqPkUmFO5P1FjVvJVGmrXzGup90lTVz1uVGraAnxx46A677LTtFIgg/aD1L118IHu2F/Pdzcbf86Zv0GbfXeNAcFOHa8Z/6kpYxUm1GocCIslgip1IBaocsfO1JeI7WkMPrhb8mxBjV33pr5mImxao7kBZMXxQe6wg9pXbd3f6tIhqXTb+qmVsYxGAR6Sk2WI15OMdLRbIG+FNO2y0kMEJ8leB+xWnxZqeqveXP5NiKuwhwSNLeHzewiJbguWV3IJhGt3h076cFbZPQ
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5072599009|41001999006|461199028|6090799003|37102599003|23021999003|19110799012|8060799015|15080799012|51005399006|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEp3SmtiQnBCM1AzV05icUdZOWxORDZQMHh6TkdjdGR6VEN5OVR2aXVJL212?=
 =?utf-8?B?V2pabFpRcGlQSEZ5cm5GN1o1Z0Rsc2x4T21zdTF2cUFwVjZ5RUtYcElJTjR2?=
 =?utf-8?B?YS9QVnZHYjA4emszbWtQRWxuSmdqNmQ1M2wxcmVxV3ZYNE5JWThQaFEreDJx?=
 =?utf-8?B?UzNiVWFrWkNpdE1qbWJBMzJteGg2dXh0TnVlYytEY2RWb01Xd29KVCt6T2sw?=
 =?utf-8?B?d3l6R2QrNGRqT0hFWmxCb2dLN0dYK1pWWStPcHRPckNmU1ptdXBRbDRMbXFx?=
 =?utf-8?B?WVVQR3pQMERHeGhkUDFwUHU4d1ZiTFBGS1g4OXJncU9tU0VDdThHcTlUc2Zm?=
 =?utf-8?B?dWJpUjVhbSt0cm1LMGprc21MMGdyVGQwRStwdlFrTzBVSXVRcDBDWTM3dDQr?=
 =?utf-8?B?VzBuek9sS09kaFNwVEVUSE00ZWxsdVZpTE5ySXpWZ0tGZzJuNGJFeVdQcUxy?=
 =?utf-8?B?bzZCNllxMmNNMEdQNUhSZkM0WFI4MU1CUi9USEJwS1A4TWV1bzE0bXltUUdt?=
 =?utf-8?B?OG1hd1NsUHlRMlRDTWJ5ZjM0ZHlJQnliQzFDMVhxVzVUem1HOWdNY2p3RG5m?=
 =?utf-8?B?THJDQThLaThaOXNCZDI4cEdnWU1SdVBRZlc4b2wxc0xiejBIZ2tTNmRxR1Fk?=
 =?utf-8?B?YWdoWnQ5ZW1HTFBSVTl3bWFncmdCa2s4V3ZBSWZGTWtoZ0tLRXY0MU5EeVUr?=
 =?utf-8?B?OFh1YmxCMkJXY1NabFBVRDh6bWJXQ0JlbDh0N1hKd3ZlL201Z1R2c0h0TmZE?=
 =?utf-8?B?T0R0Rnl4Wm04bVVRKzVKWVNsTTRPbUNCbVluaTFpU2ZXcXhqMEZYT3VyYUJz?=
 =?utf-8?B?RGhQSkdrempHc2dQOGxXU1I2UEZqVmtjQU1PUDlDajRYMnpGeDZ3VVJSVGh5?=
 =?utf-8?B?OVdUUEFRbnNmRDhBQTZHSjF1L2gvVTdNK0EzSGNHYmdxcmppRUl0UUc1YWdz?=
 =?utf-8?B?c2dUWFhUY2Yrck1KaGNwMTliN3NnM1F0aG9URmxjVSt4OWJyK21iclZ2U1V2?=
 =?utf-8?B?YlhZMUFGSzE0eXhuZEFQMGx0U2lTOFNjN2l2K0R6SE1lcEc0eVgxTFdMdnNO?=
 =?utf-8?B?aDBWVjNDcWx2MGRQT2Jybm1STWtwZ3FtSVloOE1xeXlwcEhXaElDUmVlSy8y?=
 =?utf-8?B?ZnV5MHVub24wMVc3V1Zod1RnYXVRWnNoTW5FMi94ek9yVHlpQkVaUU5VSkt4?=
 =?utf-8?B?VjN0VE1hcFpVVXFuODZZRkZQNm1pQ0RzejRzZW5JSmFVOS9XcTJib3BoMmhl?=
 =?utf-8?B?MFFETzlLbzI5RC83R09TelJKSEZyK2tHVXFiNC8yY0lCeDEyZ29EdE92bDlq?=
 =?utf-8?B?STFmT1JobHNSQkkzbmVrNS9Xa1VldnNkZXZVbUdHWDVKM2pMNXVtSUdld0Mw?=
 =?utf-8?B?SVJJa1BCSDhXL1N5bWhCZ1RUb2dQek9kRkFBVEMwWElMb2UxeGQ3bjI2WXEw?=
 =?utf-8?B?a0Z5VExhTzAvY1BtcEdBUVJjNU9tNisxVExxbXAyVk5yZzNPeWlWa3ZLZmo0?=
 =?utf-8?B?MGdLQ1RraW5ndDRpdjNhcHpWRCtTUVB1WWRiREYyLy9DM1JNQ0tMTWc2dVFv?=
 =?utf-8?B?dUNMVkFOTDkxTXBsTUJ1V3oxZ0VGZUc5WUZOR2VOU0NwMnB0OENBWC9DMTEv?=
 =?utf-8?B?SmVweEpPbHNKV3NWcU15NWNTa21EdCtEVHZ3L3hCaXZFS05jL3djYk5XRmRt?=
 =?utf-8?B?Sm5vRzY5OXF5elBUSUsvcW01Y2Z5VndUUzh0R2RlRk8wTW9yWldHWVd3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWVONjFRakNrMUxndWdjcWFYTTA3TFlLNGg4cVF2ODZLY2dJeFN5WmFOWm5L?=
 =?utf-8?B?dENlRlNwb3duWFBYN1FpVVZsT3FOY2NiQ0FJc0l2SDBqR1dqdTFWY250amZH?=
 =?utf-8?B?ZXlNSFo0d0dMck5lZG9ZRW44NHNUUWR3UGNHR2xHUDhkbUY4TGdLM0EvLzkv?=
 =?utf-8?B?NHlCeWhEUGQrcGp6UVoyeENtTitQSm1WcjNWVWdWZTFZNVM3dVpWaVhyb21h?=
 =?utf-8?B?MjI2Mit0ay9oR083eGc5S1RsK0xxRnNNT2lPUzk2NXJKOXpobHlGUE5Va0lu?=
 =?utf-8?B?dEN2R2FEZHpGdE9ZTC8wS3cxODQxQWJQdUxvOHlJT1hiTUo5dmZIemZ3NnFV?=
 =?utf-8?B?OVNhaFY4UzhMdmRlV05LRXRXWVphaEFQUjZsSlJyVHJZenhFSEIxNGxqVjZ4?=
 =?utf-8?B?NkMrUElyOGpXT2lRR2pBMTU4QS81SjFZVmFMd2QxVWl0YlJKWHNrOFlVT2Z2?=
 =?utf-8?B?Z1Y0UnFoZm1kUzQveTRBOWJkN1V5MXpDWUM5ZTdMdDdmNmdhY1NRVzNKMlYx?=
 =?utf-8?B?OERtNFNMMXdUZHJXelJPTnJERmdMUTc4bUJaWEVNL0paVFo0QnE4c3VVUUlK?=
 =?utf-8?B?aVNzSmtCM25zRnhXVWV5enlFNmRqTEdPZmtKTWZnU2RoQjNXOFRhWjMwRDhp?=
 =?utf-8?B?QjQ5Z1dJb3Roc090K0Flc1MvZGhodDN4bXd4akNJL2ZxdjV0U1NMRzZkOFY1?=
 =?utf-8?B?SCtvREo3SDJnVTI1aDRYcEVWM1RwQmNraDU4US9QU2VaaU9ENEtKNW9DVmdp?=
 =?utf-8?B?KzRqODhoNWdpQkdsRmVMMkxPbGsrQTFKSkR0eVBuNkkxTlFkdzBRS21xQjgr?=
 =?utf-8?B?NlNDT0VoYzB0VnQwTlRYekJ2ZDFHbUFySVY3QVF4dVNUL2ZPQnU0VTJhYlAw?=
 =?utf-8?B?c00vOW84K2FKYWx6RkhTZVBwa21xNWtQWjVrSithQm9GazRLV2Z0WVJOa0RQ?=
 =?utf-8?B?bHpzV2haZFI3aFU1Z3NkclRpd0c2eSttdDlmbTR4Tk02SWltWUQ0OEJ0amUy?=
 =?utf-8?B?SzNXUGZUdXpsUHI2SzhyQWtERE91RXQxUE5yYlplRWN2cEJjN2xldFlRRkQy?=
 =?utf-8?B?YW9UN2FzRHRQa1c3ak5mcUllVUs4Zitoc0V4eHFIbHVwcW9yMVBDU3RZMHpM?=
 =?utf-8?B?SGN1azRMVCtoZ3FmL2doVzd3emNlOEphL1lRS08yNkc1VTFkRHNBQjRNRjNj?=
 =?utf-8?B?RFRPOVBMc1RhcStNYTJhT2cvNkN6MmJTOEVoZ1hJZDN3bEhFRG9vTVB1dmE1?=
 =?utf-8?B?VCtwS3FKa3l5U0NHSnREN2pEWW03Z1hrclkwSFFQMmxKTThHRklEcTduSlRP?=
 =?utf-8?B?aUdEb1YvSXdXZWlpVEJqNmVEVXVMckMrSzNRL3VjZm16NWViNU8rV1RkK3dH?=
 =?utf-8?B?aXlaU2kxb1l6QlVFckdvdHZHRWU3U1RzMGdWYUgyL3VqNU54M2N4OFRLdXQv?=
 =?utf-8?B?dFcxbEhra3JIUkk5dzhKNGdkdWFYV2VpMFk2cTJ4L3pGMll2d0x4YWVmbXpB?=
 =?utf-8?B?Q2I1MFk4SHR2TXYyYjRGTm1KT1BZYkF4WlRxL05hMHFnc2NYWEFTcWhaeEJn?=
 =?utf-8?B?Tk9RQXE3NzZ2ZGVWTW1oK3hvVE0zS1FNT0lSS2VmYjZ4SjFta1p0YzNNRldC?=
 =?utf-8?B?WmFwRGVQTEtVUVVFTUlBRSt0eVE4Y3pUSXRwb2tnN0JVYW5qTFFEVDg5V1Y2?=
 =?utf-8?B?dTVCaEM3OTkydlVrVVJZa00xRjkwTTc0YjQ5enVmTmltbFFUOVFzek5mbHRv?=
 =?utf-8?B?bEtxOVVWR0xqaXBUcnNtYzZEdGEzSGNSTzZQeTdjVGhLUU9tN3FEODRJUW85?=
 =?utf-8?B?NlFMRlYvaGVMTHRXZnRsY0Y5aVpLZXk2c1A1OVR0Y0hadHZseFl1UEJSN0xL?=
 =?utf-8?Q?BzPb16Au39vKP?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a4511fda-baa7-4889-622c-08de5808d2ab
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 09:46:46.2345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4559
Received-SPF: pass client-ip=52.103.43.83; envelope-from=wei.w.wang@hotmail.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 1/6/26 3:19 AM, Wei Wang wrote:
> The AMD APM states that if CPUID 0x80000001.ECX[TopologyExtensions] = 0,
> then CPUID 0x8000001D and 0x8000001E are reserved. To comply with this,
> ensure that EAX, EBX, ECX, and EDX for the two leaves return zero when
> CPUID_EXT3_TOPOEXT is not enabled.
> 
> To test, launch a VM with CPUID_EXT3_TOPOEXT disabled using "-cpu host" or
> "-cpu EPYC-Genoa,-topoext" on a Zen-based machine.
> 
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> ---
>   target/i386/cpu.c     | 7 ++++++-
>   target/i386/kvm/kvm.c | 1 +
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 6417775786..437da88b4a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -8489,6 +8489,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           break;
>       case 0x8000001D:
>           *eax = 0;
> +        /* 0x8000001D leaf is reserved if CPUID_EXT3_TOPOEXT is not set */
> +        if (!(env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT)) {
> +            break;
> +        }
>           if (cpu->cache_info_passthrough) {
>               x86_cpu_get_cache_cpuid(index, count, eax, ebx, ecx, edx);
>               break;
> @@ -8519,7 +8523,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           }
>           break;
>       case 0x8000001E:
> -        if (cpu->core_id <= 255) {
> +        if ((env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
> +            cpu->core_id <= 255) {
>               encode_topo_cpuid8000001e(cpu, topo_info, eax, ebx, ecx, edx);
>           } else {
>               *eax = 0;
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 60c7981138..c988358548 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2029,6 +2029,7 @@ uint32_t kvm_x86_build_cpuid(CPUX86State *env, struct kvm_cpuid_entry2 *entries,
>                   cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
>   
>                   if (c->eax == 0) {
> +                    cpuid_i--;
>                       break;
>                   }
>                   if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {

Gentle ping — any thoughts on this patch?

