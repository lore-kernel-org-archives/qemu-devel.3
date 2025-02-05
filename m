Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0AFC02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 19:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tflQs-0001bm-KM; Wed, 05 Feb 2025 14:51:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <webczat@outlook.com>)
 id 1tflQq-0001bW-9g; Wed, 05 Feb 2025 14:51:32 -0500
Received: from mail-mw2nam12olkn2081a.outbound.protection.outlook.com
 ([2a01:111:f403:2805::81a]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <webczat@outlook.com>)
 id 1tflQo-0006lh-Aa; Wed, 05 Feb 2025 14:51:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhsjqRwq0HVVhgZ+zb6Cu57YdUUYcVi/IPLMAh7b9CMDkV/6IVXfgaswq0WIu6WEHcZhOEoiFDt4Rlkga9uvAhh6N97TuxLLkcoaAlXWINoNRGbUxgFLLrr1q2Fg76VWFv7JodBMK0kLOfbd4HH7bl2vv6M9stwHxmJuvECvcxk6zgR7H2DNkGRXgkeoUVRMLQ30hF5Sld7ed/n47PjWqCM+TCS+8ghAWOKy+xnFMaDMjnbsmqiHYRcK+7vT7C2VikqOBU6Sw1VA8vN7wqXqssIWQdEp+Bk/AU2h8aGAXVdmwA01RB4usJSU6AyUM8jwbJpS72b+GzADJHcnfQNYtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sh7EhosyagOAYRmZyO5oxdCLJ+kWdbva+dqpGoOVwDc=;
 b=fkfrDgHmCktJpppEg+HUnJZJinCLPPrdULv94QBt+CeUiIwp3VHFQ4xnq4voD2pOKss91qLgP4++6NWm7lcETnK3gKk031+5dkph4nEAKd4TjQqSOqkOtoSBgxefvFLGzasOctjWMsAcq73lsSX64j4QdxK117XhbBEf/rj9jV0mJ8a7YqVCf0eAywZRVj4hjOfxq/DWn2NqIRN/4VoFvkwf3G5ug0eoH4+q3swKlQDC0Rs0vPmIESBndtgmgAMXZQPy4TtiKWjeis8+cyep6aFI/nicF8GpeHtYcli3qGka5tODNsJmm+LTqRhZg/KjqCsxgeBzHpBqgupQ6T/nCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sh7EhosyagOAYRmZyO5oxdCLJ+kWdbva+dqpGoOVwDc=;
 b=q58WKM5ekYyk9/pnm+igW9GTqiKwSqAYMtBu47YXZ4hks/inDav1sYIE/mZW1hFwAH48s5iNbSDQIea0KDkspBp87wXouVbU2jrFwYflhD66G6hlj1EI2NKZbunwUKySpujrNNGOO8m8nYg05JKjllxy1xZb+OxzuhI4tbnUEr/4RAyHnUdlUwWzmyUQHmUpEPMarcCp0RHDp7sZ2khFJyR8uBuLzqqIyeI6yFKgpdMeR8AowI3ynlT+iwOdQfBtfRpWrsfzVe8oAZ+h00dRQSUiOnGu9fVji0iZOM8I0P2clYBi6W/kkxfjo6uFl2nYSXm3sP484N8MRUgmHfCi1g==
Received: from SJ2P220MB1449.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:58c::10)
 by DM8P220MB0344.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:28::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.11; Wed, 5 Feb 2025 19:51:25 +0000
Received: from SJ2P220MB1449.NAMP220.PROD.OUTLOOK.COM
 ([fe80::e65:388e:1733:8f8a]) by SJ2P220MB1449.NAMP220.PROD.OUTLOOK.COM
 ([fe80::e65:388e:1733:8f8a%7]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 19:51:25 +0000
Message-ID: <SJ2P220MB1449F7D60C04216CBC838DA3A0F72@SJ2P220MB1449.NAMP220.PROD.OUTLOOK.COM>
Date: Wed, 5 Feb 2025 20:51:21 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org, qemu-discuss@nongnu.org
From: =?UTF-8?Q?Micha=C5=82_Zegan?= <webczat@outlook.com>
Subject: intel i915 sriov and display
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0013.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::8)
 To SJ2P220MB1449.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:58c::10)
X-Microsoft-Original-Message-ID: <3d594175-4fda-49fc-8c07-a39b57c668c7@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2P220MB1449:EE_|DM8P220MB0344:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2d347a-2da2-4fd4-10a2-08dd461e791a
X-MS-Exchange-SLBlob-MailProps: Jl2hv6oEcgNKS1o+o3A6IaEVUN/ew+dF/RF6Hn/8NsWksyjxyWKs+DNYmfNOb9yEFkIfIEGkul5is5imtqEEoZg2UZuzhsZpt4ZJ/iuMehgm2TRJQHSuoG4ECCKzBiD0f+mDB2rKUD6pVFYNtl2iidFg+3mKHQC16xTcWq4r/VkPxWdqZc4EZvkEpcRo4L+kzqEBY59QG69mAt/nAsvIrNnyjC+RJlmaDRNqAjYv9vcG59r5a7GDm1wZt1gqqDLbhhNPwMB+ZoqdeHUC6Io6tOEKvpxoCYK5Kt44+OAWgzdGjwkM6vm/nO7FzA/H7/P4lNxTtKjLOWuTkB/gr2toi7oRsHJOZ6ACS3pP+oRfrpzr01yppPG6Go+s/mvBOgzwRLtRnmYeaEZQC5KVogR+vXaY1TMVCnQmcD7iosy5xqHkfETcvHzI8TUOBkhpb3uVdfh2vOhxO1ccJuikvQj3MtIEa2vqqroep7SluLCSn8aGqagaRW0tT48jzZa933tCX/3yFtAtjLmfJTlY4RexsWPJK2wk43M0goXJWRP7D2UcccF/dT4fAj1eGR9JDlMvuO9T2A48V3I=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|15080799006|7092599003|6090799003|5072599009|8060799006|19110799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmxWbHlGOFZBUFJIV2JVS0J0UXhxU3ZWV2JkWXgrM2VYZjNHdUJKVVZWTk11?=
 =?utf-8?B?WUtmcjdCSmFKV01yMGpsVUJTdUh1SHh6SmxUay9JOGdjYjRDSlRMTU5TMGpF?=
 =?utf-8?B?SkR5RnRRN1VYM1grWjcvdnJ4UUwybTNUYmVEWFI2QllFNEUwV0F5NEs2NThG?=
 =?utf-8?B?eXJWUi91MWxBRWpzeDJXVkd0V2Z5M2dGNzdNZml2ZWhOUklvd1JZbm1qRmdI?=
 =?utf-8?B?bG5qNFlaMGloTWRPSjF2SEpvZWI3TlBWekFvcnRLMUczeExSMk4rcEY4MWNl?=
 =?utf-8?B?NjhNME50RW1vSFVwdm8rb3lCU1lnY2VWMjBhTy9GTW8ralJ2dFQxSEVTWGlU?=
 =?utf-8?B?Y2pXVUh1YzFEVHBFU0JPZ3BNQTVTYXpVUDFzNmxsMDhtQ1QxZjBOY0J1bjF6?=
 =?utf-8?B?QWFYZk9nZnJUbXRROG1ISXNLbUN3Ylp5WFF6R0JtTHRwaHc3dndzYVhJRlRy?=
 =?utf-8?B?RnVIblRiOEZNTDQyY05rLzZVSkJNYVFNQ3RiTUxzMlR5WHJzVWExNm9oRjR2?=
 =?utf-8?B?MUFSZDBWaUZVYVA5cmwrQkhTWm9GZlAwREQ1QnNDSkgrMC8xTnJldC94Z29W?=
 =?utf-8?B?dllIemdzM1hVWTgyNnBWczZNOTlJeUhQMjhjcnZRSGY5ZWp6Y0hHdU5vYzF2?=
 =?utf-8?B?b3ZQQ0t6WVRndFpMWHhQcGg1UWNVUm1MZ0RxSURzUS90UWNuU0dWdWJPb2Zj?=
 =?utf-8?B?Qi9PbVZSMEM0Z2ppSThSM3ZLMXl2enRGV3FFVldEa2NzcUF1anpuVWRjcXVi?=
 =?utf-8?B?cDJod3orYVkyYjRLUnpOMnBEZm5TOGZCcGRzME5MQklSeDBHN0xnNlNmRmtD?=
 =?utf-8?B?ZDBoelNzRkxOOTk5cVBHRFUzb2lyMVFDOEZFZnNpRXdlQVM3WXdORGlTY0dI?=
 =?utf-8?B?dFFRV2FJQlNsK2JTYU9jU3JFdDdoWWZhQnNrRytYUE9kcW9SN2JjdGNXVVdt?=
 =?utf-8?B?cmx5YmhoSEo5bG0xQktMYUZJYXM5cGpFK2s5eGRBZWFiNVFUeGFGN09KcTh3?=
 =?utf-8?B?MWZpa3lVUUFhdnpEM1RUNlZFQzdBVTM1K0pWM2ordkJua01yZG42MlhJQ0hq?=
 =?utf-8?B?OG5YUDhkYVlPT3BONm1ONURScWs5cDFrV0xzNmxNN1ZqSGw2cUZWckMyaVBZ?=
 =?utf-8?B?OGkzLys5ZXFyV2hZSG9SWXJwbmQ0L3RFODQzMlVEZnB4SnZzSFp2SDAxYkRx?=
 =?utf-8?B?TkNkQVFySVZIMHZnVTZnWTVzZFNOV2xySU1iYUJlbU5xa29rL3NDTmUwd2h5?=
 =?utf-8?B?VTNuZEJSTFRaZzZ2cjRPcmVXR3dsOElqL2o1ODJ0eDMza1pnSmFlNnowVnhD?=
 =?utf-8?B?bGJ1MFVpYVFXSTcrSFJaTUJyazVKeVRpakdYL0N5ZTY2VUZyTHM3OUpub04z?=
 =?utf-8?B?TDcvcEdQZlFhMjNDNmp0K2V3aG1EdVY1bXJkSVVLUWhsSjd0d1JxaXdpb3po?=
 =?utf-8?B?NnNqYXVqU0tsbjVIN1J4SVhHL0ZjZmFyKzZOejVoY1p2eGZJWDBaUGtqTGov?=
 =?utf-8?Q?/0hIuI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU1nc1hqaVY3YlQ0Snh4ZDFMZ3BhY25qTFYrLzBobCtYR1ZLbVlsanpOSnlP?=
 =?utf-8?B?T2hHZkdFMVpIeXVtOTZFY0Ztck5WYktQZEpMR0pyZ1Zhd0t2M3AzdTFNcHhD?=
 =?utf-8?B?YzVyM1owNmsvN2dwTUkxbGI1VS9KS0VRRWZETlR0SG82V2hZeWVRbjM4eG9T?=
 =?utf-8?B?bStwQmtlektJYmJtb2ZlU0NzVVp1Q1p0N2JJejNpZkpFQS9NMWEzb09PbWlB?=
 =?utf-8?B?RDlwYjU1bmJNMHB4L1R0QWNRL3Q0QkRBTVl4L3VJYmh2Uk1GdlI4ZlRqL2lh?=
 =?utf-8?B?SzhHSzZzZEFDYWVteHNldUNhSklCQTZvNWk2ay8rdVhTRzBOMjdxNUFmcEJ3?=
 =?utf-8?B?QmtIdjRuakEwd2JnbDFCS0xmQXMwdnk1TEw2MVZtQ3cwVXNialQ0ZnA4ZmNM?=
 =?utf-8?B?aFBKUVFCV2ViQWhHdDNCRXRuM2hSb2ZKa0J2VXNyYVVIU1RaK0srNnRmZVF0?=
 =?utf-8?B?SFpkQnJ0VUtNSGRwc04vaGFXaENoRkVOYlEzMlZjOU5MVWF0ZUkyQmpzV2l5?=
 =?utf-8?B?Mjd0TSt3VlZTU0JPSXpWcFY2TzY2NStGUkFzNTFiTHltUUhrYTZGTDNXWWlp?=
 =?utf-8?B?aXovZ3d3WUYxTnFjRkpjcEpERlFIVHZXOXUxVkltZ3liclRJSXloWW11VWkz?=
 =?utf-8?B?TC9Ubk9UWUtsVTlsc1NwZ1M4bmJPcUFzRzFDY1U4aGNTTm5RZjlOa1pOajRm?=
 =?utf-8?B?S0FIL1IrQUJWY1lBTDk4S21IdlVNeVR3K2J5cGRCL3liS2dHa0t2N1VMRmNE?=
 =?utf-8?B?QVNJL21nNWcxd2RicjZvbWdXN0pQSDJzRE9ycjFKQkthcGpWMzJSSEt3WFNG?=
 =?utf-8?B?NFpacFo5SkRGUFlwd1gzTVhKSEJIaGkvQWR5Z0VuRUl1WkpmejRDTVVIblN4?=
 =?utf-8?B?ZzZXVzIxMDB0WWZwRXlFQVc5NDBFdkJKS3NXZmJ6UkZOY2hGWnJNa09rV1JX?=
 =?utf-8?B?blIrbXZ0cWZWclJhWUxodVhiOGpqQTlxd0NDUExXVjduVjBVa0lDZVVnNWJz?=
 =?utf-8?B?a3l0SVE4Q2ZhY0d3ZXBnUFZRU2t4a0ZteldaYnpVTDk1RGVMSXEwVnAvSGtz?=
 =?utf-8?B?dU1uMndaOE5jRUFaRjlrTGMvMDk1L2RDZTl4bFRQd3ZSZkp4Y0JpWVc4U0wx?=
 =?utf-8?B?dlhUTHNHQy9HQ1dqSDRiRW5FaktXSUFFUXRtcUFZYWNrcVFlcmo4QkZzUTlu?=
 =?utf-8?B?S3VWSzlHOHhYNWdtcnVCTHpGTFhOMStESGRBUEJiMmdob2s0ejBDRGw3bUdH?=
 =?utf-8?B?dmpEOVVIZDRZSGNxVEJWK3ZzdFhWcnZxOHg5VVhmbnFzaCtGY2Q4b3hHb0lj?=
 =?utf-8?B?T1YvYmRscndlRjRoMmdmVWpXUzRSTmV6ZHhRQmlmbk1WQUw1dDlUaVVEcEFr?=
 =?utf-8?B?Vmx5dzNDK1JlSnU1NE5ESnpNbjlEUjZFaTlhNVMyNHVLa2l2bG1yemhoZ0lB?=
 =?utf-8?B?cWZlck9VdkVnNG5EZnJ3VDk2OXlZYWo4Z2NGUGpYTmE1eWdmVWVSV0tMYkhK?=
 =?utf-8?B?ZGJxTjBaQ0dnWGNCK1NmUWxjUGp4eDRlNUt4QU5JVlFkSG9BU2QrOUxnQU92?=
 =?utf-8?B?aHJsU3VYT2FLa29Qb0dxK25nZXJ5Qkw3a3hpZmVVUnZMMENrZlh5NFg2VUVV?=
 =?utf-8?Q?qv3X0ERV69PmFRtPk0PkKf+q6uV9mf7U/Nl8Ti1dTVSA=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2d347a-2da2-4fd4-10a2-08dd461e791a
X-MS-Exchange-CrossTenant-AuthSource: SJ2P220MB1449.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 19:51:25.6888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8P220MB0344
Received-SPF: pass client-ip=2a01:111:f403:2805::81a;
 envelope-from=webczat@outlook.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hello,

I don't currently have a working i915 driver with sriov support, waiting 
for xe to support it, but pretty sure some of you might answer my 
question because a dkms version of i915 is floating around somewhere for 
some time...

Assuming I have the 12-gen core i7 cpu, When I set video to none, 
passthrough my virtual gpu (after I make it) and set it as the display 
device, is spice going to work? or I will be unable to use spice from 
that point on?

Also, will ovmf be able to display anything on the screen? does anyone 
have any clue?


