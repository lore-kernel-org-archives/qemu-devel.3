Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A0BF54ACE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53eD-0005mN-Ki; Tue, 24 Mar 2026 11:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w53eC-0005mD-Nw
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:26:24 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w53eA-0008NJ-6d
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:26:24 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OCCE5f1157363; Tue, 24 Mar 2026 15:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=NRT1OXfMWi6ukJbb9JuuhCu7p6MmkkxI9+agKNDWReQ=; b=
 pFbZ9lgUfKc7LEc3H0dJRIYKp+RcttzfUuyZMUz69glHLi04CpjFeCKlOUBQkVEy
 S1VKb0fL7eDqvrjlGn/c78KYM7kaTLQ8/pc3i69bxntxRutxqP6om/QGI+RxETam
 TExU8BCqpMYn/ylDunvefte1jYXT/3FqxEf7hsaOSBWZxI8ef1GTQ4Maq456frME
 1K6Tq2Qaux78NAuURvmvT8KQC0J90RY+Wwy2MVw8bg+ebptVR1KYF22/xKJsZtt5
 6ilZJNQm1DYmJNjY7gGSiLVwy692BxK2S7zEl7rDyFrZqV3rbpZnvdj72QQuMYn1
 pqNBPP1CW/DILb88sV325Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kgfmfj6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 15:26:07 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62OE1pd6028920; Tue, 24 Mar 2026 15:26:06 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4d1hsa2p9t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 15:26:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+6dbPi2xwe0jiFirYzA3JH/aZIy4AYBLqNjms/sB8t3uTCk/hL6CmKRw3YneK7gULtrPcuuExkML2gU0QwBWYzCarbn9DjD4gBMXEDUBtTmvQyLYYEBSnN7ffq40YdpsgA8yObzMVBfFDEd3LuXMtoNCMdrgHzUrXfXcqIW5edBiYW1I6xY/JcO7AzrObTDnjtsoPfXk7E/+vu/0GZ32DTZGE/+z013J0vR49R81s7D5LMkPTmHNzQhXIkK3/CbXHEebKen0DodcTGdEocACq9cFD9qn6Bd2szYBc6oRKi6kvyOmPU0zsdpZBqHz7Rdiao79GFSWG7gw1kXFIR/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRT1OXfMWi6ukJbb9JuuhCu7p6MmkkxI9+agKNDWReQ=;
 b=hsje3ZiFomq8nE8NjP+2S+3/BYEXeOlkckcjFyhviq4QxxSswYyTX2kWC2oFeEyln4HXlnJ9I90LqEknGjo87+fJqgU42n4XIJrLzDOgex+Ibojk4fGA7sjAQRao1pyMbdmPnhltJsj/M2SM3ERA4REqEPh9zGt92KFaxNK8fOpdJmXHyt8lgkLfcQ/KvjxqtmZigkV6dPbF0XDvgY5cHupBYGp6MfJuwOBc7viqHIJNusv2in9DYAML04c5X3XyiMxfklXXvyllqqxH7/1pg1F+8C+PAYYqdpI9VyrDOwquF7iBhIcyXgZZm4xBlqUPG1r9QilxMfboa2ZPiaLbTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRT1OXfMWi6ukJbb9JuuhCu7p6MmkkxI9+agKNDWReQ=;
 b=GB9SiH2cesixXaPZeG7f7il/Aw/ws2e2PqGbCVy5c/KmpSaako6Mmwl2tF8Z2giXGI5QLhUx1x4Tgd82wgfRZqcc9EV868gvw1FgTF6MVxCnaqMvAwAujAcXwEkkmpvZ6plN29daUcVXwBwoMskIqPxT7lI/8e/wsnORPitB58o=
Received: from CH2PR10MB4360.namprd10.prod.outlook.com (2603:10b6:610:ac::7)
 by BL3PR10MB6164.namprd10.prod.outlook.com (2603:10b6:208:3bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 15:25:58 +0000
Received: from CH2PR10MB4360.namprd10.prod.outlook.com
 ([fe80::2317:1df9:9fcb:284f]) by CH2PR10MB4360.namprd10.prod.outlook.com
 ([fe80::2317:1df9:9fcb:284f%4]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 15:25:58 +0000
Message-ID: <7fc80296-acf4-467a-b37c-ef390448c068@oracle.com>
Date: Tue, 24 Mar 2026 11:25:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 05/14] virtio-net: detect VirtIODevice config buffer
 mid-migration change
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com,
 leiyang@redhat.com, si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
 <20260320142015.3856652-6-jonah.palmer@oracle.com>
 <CAJaqyWfNABTMcg8UUS5GaSs9C3uUMWC17auV76dAYeK8fEWxcA@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWfNABTMcg8UUS5GaSs9C3uUMWC17auV76dAYeK8fEWxcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0108.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::27) To CH2PR10MB4360.namprd10.prod.outlook.com
 (2603:10b6:610:ac::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4360:EE_|BL3PR10MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: 0896f2d6-6107-4398-0197-08de89b9a630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: yQqe3GAEyfqG6+Cdr7/OPb0gave9DxBQbpC0wMMo1PXsXZ4TlHHg5g23aHroVycpTD0riBmGP3qe4ARY/fgLjq+DINeha2uq5j23a3LoGFJI0KnJeyEfHahkljQc/Yma56bjLeHEv6fnLmLQgQPrYQAafUDAoFRLessaftHnj8i9tXDkUsxbNtXb2fVtr8xggb92Uf2HMAl5AACrNIjhLBhyAdeZ2LYjJBwuUW01Ube6ZrTWPD5kjphDUgfCjYns4QpxLcG14CJdHGFuovbn9Y9Eg7e/SiKLs+ZbSBN8bIZdD66yikJy2zLKtbkEzOUumAKrGZbBhTea9kvmce49z9Vd61ZtfadGKqViyoI8Pt6pI5wjciy8Vl6kyrIE0ughKc62RI7CoZQzALQ3WdscC18zRjFQF8r6MZjpO8wBd/KnB5ZY3uowoxQaVJJB6oC4FcdrslJgSWaNrIJsIF3urnaPQxDONV/FHa4GqR5ms5uK82WTc/NSPLIBHMTviWYsfk/iEwRo9fGEu3n7bNHLyK8/d+DF7pTDZxHlO+2WoCoWnAMn7p7e68VGRQrL1xZ746W6n9LUI0OTf+3wX6mEuuNadJAp2BlsTaa/520DincVkiq+nv5F5dpIsYwBmuwaqI5lk1tVgG2RXVemIBrAlE193PLk78xk5Y/8m24X/XSDihzA57Zb6DOjmDpLF8AMm76pVvoSVIrEsvuIbqkn56g9obtxQGwEr6jrJpCHohA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR10MB4360.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnhpck53YjlvMWZxeDBHTkQ0cGxBK1pXd1FUZjZmQ3dJMXRLWEZUSm1KczFv?=
 =?utf-8?B?ektUUFNEMUtma0EybmxUVVJ5eVNPcG5pNnlZK0t6ejBLclJ4UWRUUG13YWhT?=
 =?utf-8?B?R21BNlFkaHhsc2ZQQlUwYVVubUs0UTlmUDdSaGlrNSs4dWxxMEdVSjlPTzFX?=
 =?utf-8?B?M2o2UkZuQm5EMVRaTlBXemFIdUNOZVdUU1huZW1xTFNwd3AzREx4SlVkQnhE?=
 =?utf-8?B?N1NPK2REYzBHQTdhaUQ2eWFDT25nak1HZGdjOWpyQWlPeUs1K3hHZ3liTWM4?=
 =?utf-8?B?ZStXcXdST000L1ozN1E3QXVVRnNxR2RSTVBhNmZUUnc5cWNZdklpc0pCVDVs?=
 =?utf-8?B?am9MOWRQUm5QOFJaVlRDUHJPRXo2d0RzZXNiZ0lwRS9qWEFBU0lnbjV6WVlV?=
 =?utf-8?B?Smw4TTl6SUZqWFlhUk9QWmZvYnhpQXJOTDZSY09wbExEbWFmTzFFVVB3Y2l0?=
 =?utf-8?B?TEJsSmhiOWVlRUZ6SWwxNDdKZ0ZyTDduVjJOazMwNW5ZSTZhZFo3d0Z5R0p4?=
 =?utf-8?B?ajMwZ05ldDNRLy9MOUtNYWovQkx6MW5ZQ3dTVkp6NzVMeCtaaVowRHlYWXhq?=
 =?utf-8?B?VWw2MXp3dlZUU3d1eE9zSUY2K0x5ZXZva1RURTBnVEhtMVhKSVk5b05WdmlP?=
 =?utf-8?B?cVhmZVdQRTh1UjJSdGloL013Y2tNWTdrTEhNd2N3TEVjZnRCdS9LQktsZEpM?=
 =?utf-8?B?YkVOYS84RnR3dGd6N0xhV3BGY21nOWxmcHpMSDZEeTBUTDlXN21sZXFOMjhl?=
 =?utf-8?B?Z0JsbXcxaGxIMjcxMjdRR2UyY1NXdm9HM0ZrV3Y0dGt2VjEyUy9zYmRQb2cw?=
 =?utf-8?B?M3R0aWROdE05Q2pCYzlqcEZBYUZhdEVxQVd6eGkwSlNYazQ2Q0lFcDNEOFE3?=
 =?utf-8?B?WmlYaUREbjRCeVFKeVhrOG56U2NKbW9ObW9EcHNETW9TeDF0MURFbGVKdGM4?=
 =?utf-8?B?c1owMFhlNEpJWm9kWkpEQUtLZkJEZkd4Nm53dTlIWVd0QnY5RzBUNnpQTFVX?=
 =?utf-8?B?N245eVBlL1c5TUZNLzBPY3ZCN2crdENwRWJIZFE0bHV5QU81dmp1K29GdFBw?=
 =?utf-8?B?VVdUeGpxRG5Wam5ZZmo1RTVWb0JheENta0pCU0tPOWJNc2VhaVY2NnNaWTBn?=
 =?utf-8?B?R2hZSXo1bHZrRWd1RUxuWDdRbTZGR2xaWGF4b0ZyeXlYN2drWXBIbG51Mmp5?=
 =?utf-8?B?dmY3UTBUaGg4ci9BWlpXZ2twMDlSRnRHYUN0OFRHS1NKR2RsM3hQTXZidkVF?=
 =?utf-8?B?N1dMNnNlL1VBc1hYY1h0S1YxNlp4eVZ5NGYrM2dKL1ZKekZNbTkyWjB6TThV?=
 =?utf-8?B?cFcxM0VBY2pCdFpXNjlCVVJsTC9CdkhUek95U3R3UjRlYWZvVDZuTUFqSzcr?=
 =?utf-8?B?ZEdrR1poQnJJd1d0bGZlY0tHbGlYM2xMUnpSQlVudG5JeU55cFBuTkFFVERO?=
 =?utf-8?B?eElxaVBSUVhmMFVEK0YxZEhXYkY3QXYxbnFHZ3NxMkhTQzlOeWMwMTRMallP?=
 =?utf-8?B?K1dEa2VsS0FFWk9QRFl2M1FEWE9KSjJuM1hOWCtINGNnenROL1hIWmFXejdv?=
 =?utf-8?B?a1loMlUydTlOVWVGKzVha2lFMXM3SldsTkp1Q3lhM0cwd3BPRUtlTEpYTWFU?=
 =?utf-8?B?bFFJdmdFQzlqcUNWV3ZCM0g3U3BKQ0RJN2dsMHludzJJNCt2cWtSekxJbHJX?=
 =?utf-8?B?YmRMZklkNUVodmd5UHUwWWtYSzdlR3V3OFN1N2puYzhOaU14NXNCdVducUcr?=
 =?utf-8?B?aHloczV5WUpMSDJMU2M0d2xwRGc3SDJ6L05tNW85SGd0ekp4Y3ZIUEtBb2ZV?=
 =?utf-8?B?S08vcHlDMWpBQWhmMExWdmc0bnMwZWZmSldZMis0SnJNWTNva0ZQOFZLeVVp?=
 =?utf-8?B?VUVhdWc0K0VBVS91TkYvaU5oelJGVXFwazluUnA0WjBQQlpPYzN0cjFQMlhh?=
 =?utf-8?B?c1JXRjRGU1k5TDlBSHF5RUdqQ1VaRWtoZWJpNCsza09XekdlQWk4N2dINU9V?=
 =?utf-8?B?a3FUWllsbG9OVENvT21DeDh0NkdHUktHNjJXbFc1M3ZUalJjZHVWM3JNVVJq?=
 =?utf-8?B?bUdZMU1LQ1pRLzFURHN5SEpXc29sT1NSWlhKaFhuTFpTeWhsTWtLVk94TXND?=
 =?utf-8?B?TDRMaER5UkltdG1XVkFNRDhsclF5MjhjMTlMWllYQ1NOTUlOdlRKMlV0UzQ1?=
 =?utf-8?B?RnBFWHhnMy9wQ25XS1FzTHp3c1E3Z3VMU25SU3J5akVUbmN1SHVYMFNRdTJl?=
 =?utf-8?B?MGg1U0R6dVZQY3FzK2tLN3JZWWRCdUtONkN0WVphUjJUaW1yZ2diNzNQZ2NL?=
 =?utf-8?B?TG1kTHd1QTh5cHNkTDd1c2Q3Y3BiUEIxZDNlMmtMNWlIUURhL0t5QT09?=
X-Exchange-RoutingPolicyChecked: wsjZoX26JAnVCzrc9Ad517tzzwEtflEm1d1z39ssO/kHk9s7Gee70TfOeKEqy27e4jg8nhZTavvYhY0XMI11LhfQzaqnC1bXKz6kiy6mxG0EmYbdLLBxHDbEggFNudEOs+DtDL9seVehI3r2OFqHSLSJ7+58dWT0J/AwEkgi5i1mFOOH6XL02RklHlu4ULT1n3LpUoIsD5L6zcucSU125eEyRCohfZoLKGSMNawzai884XCd1gIE5r2MiCTClXGhHBfBeEc9rLQvssq+NmJ4+hrThuZnUSY0zqWmbW7Y6z8QOQWHMinws5Le/zRfFktR3VpZ5BoLLgbzoFCytGc7CA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BXxiEZC0XHXHJH58nzuBTht2uimD3Mmgxc6ZiZwctPFaECCbriHWTULHUzj2+/guxs2nwshzAmVJ5f6PIbLVh6bVD+EjGj39mfViFksCVaALuHtF096AI38CF1Egxrkg7A3gLCfkijAGe9uUKWVxDimfsJTRnmbhO8hpYGgNKg3EIS168gGvJ3mjsD6IUTskRnD81V9gIZfAmsbCyX7FqBaKZdOvLvsL64hyzNtwa9NJ6GasdM+MXMbru3AQn64YeYb5GASFMmtaWbI0WAKvD/Ad2wL8Z6jflthBMGRZmnb5mSHS2CWrwgHkQQ+8cnEjge4ol2dIYr7hNVQlrNnwFvL4jQj12fUI7CBEW1B6wuRZQVdsp9CJ8OiGDtmPF3X/H3HQzxkWzXnQw42gBEeKOAYVdDO06IoOt3YBp3wdrIkGqJXHtmzK26H8OAl4vYWEy4fzhATyj3vMocCBciJWgEkfOj8aNFkiQ1iHgz0qx/nm22elsMZq6GOS8DXLw1q3NZZ5apw/DGwW4pSY+K35qXh6SH9mETv2YccCSslUdHL6Thva+BnUJTi7wvrnmIHRKWS0vQPgnUhwB8zfeMVvq+ZTHx6AyKK7pO/OlS0tS74=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0896f2d6-6107-4398-0197-08de89b9a630
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4360.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 15:25:58.5895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYnMP5FDFvoIpG4neZtN5jadWTA2ru4+iREs+YJWnGs9djQpMbXFGMz/HaQoaWZ13jV7Sz0KpkY5MLXGLLkj5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603240120
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEyMCBTYWx0ZWRfX+2jpl1cARpz8
 UZ7ypIPQFaeprNOte3iJwNFV7pyrqSybE6HE5W2wGKycPQcrQ9Vy0gPPpp5WiT5EHEhp2B3BPyg
 8Xi1OduMecdnkbf18gDB9QzHdzBGhb6UGbSPZSSFaR5nopyb4YNDeAKUpvUjZFh0Fde0yK/TXa0
 SEMmt/YNNespz5pkdmint0axRWcnNX8ba335ksQg84RmSWIJGuzvro2NpwRST/K1wGU786wSVfE
 sZYedK2+5U0CrL3JCdotlMTyVFpR9TD5UtP2Jr9zv/A8v8BWkGBHE42S+lJO622v7phYYCF7Y1y
 2hxADKUj5N7on0VJBqErQOgqo3lgPUGdojb8KPYHdIij0IldOM79z6LbZOI5co2sOk+6Q1kHWLl
 5irYmqwadF42MXnye3tXDApX4f4TGer4gXjBiQZ71p5vo0gLg7OEAcNVvD9EexTUMbI7dW4RoJ6
 6ICAdh8ZU7Rae0GsgGw==
X-Authority-Analysis: v=2.4 cv=aq+/yCZV c=1 sm=1 tr=0 ts=69c2ad0f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8
 a=XV2TXmOlWpr9IWbESFwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: M83pawH_0s4iA5KKl_vx2smIT1k6V_Ia
X-Proofpoint-GUID: M83pawH_0s4iA5KKl_vx2smIT1k6V_Ia
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 3/24/26 6:48 AM, Eugenio Perez Martin wrote:
> On Fri, Mar 20, 2026 at 3:21 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>> This patch saves the config buffer and its length of a virtio-net
>> device's VirtIODevice to compare with later during the stop-and-copy
>> phase.
>>
>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>> ---
>>   hw/net/virtio-net.c        | 21 +++++++++++++++++++++
>>   include/hw/virtio/virtio.h |  4 ++++
>>   2 files changed, 25 insertions(+)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 2733e0130c..ca4385df1a 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -3871,6 +3871,15 @@ static int virtio_net_early_pre_save(void *opaque)
>>       VirtIODevMigration *vdev_mig = vdev->migration;
>>
>>       vdev_mig->status_early = vdev->status;
>> +
>> +    /* VirtIODevice config buffer snapshot */
>> +    g_free(vdev_mig->config_early);
>> +    vdev_mig->config_len_early = vdev->config_len;
>> +    if (vdev->config_len) {
>> +        vdev_mig->config_early = g_memdup2(vdev->config, vdev->config_len);
>> +    } else {
>> +        vdev_mig->config_early = NULL;
>> +    }
>>       return 0;
>>   }
>>
>> @@ -4150,6 +4159,9 @@ static void virtio_net_device_unrealize(DeviceState *dev)
>>       virtio_cleanup(vdev);
>>
>>       if (n->early_mig) {
>> +        g_free(vdev->migration->config_early);
>> +        vdev->migration->config_early = NULL;
>> +
>>           g_free(vdev->migration);
>>           vdev->migration = NULL;
>>
>> @@ -4251,6 +4263,15 @@ static bool virtio_net_has_delta(VirtIONet *n, VirtIODevice *vdev)
>>           return true;
>>       }
>>
>> +    /* Has the VirtIODevice's config buffer changed? */
>> +    if (vdev->config_len != vdev_mig->config_len_early) {
>> +        return true;
>> +    }
>> +    if (vdev->config_len && memcmp(vdev->config, vdev_mig->config_early,
>> +                                   vdev->config_len) != 0) {
> 
> I'm happy with this but maybe a comparison to the config generation is enough?
> 

A change in vdev->generation would only tell us that 
virtio_notify_config ran. It wouldn't tell us which field changed or 
what exactly needs to be updated.

And although this RFC series currently just aims to detect a change and, 
if found, signal for a full reload, an actual follow-up PATCH series for 
this will handle sending the required change to the destination instead 
of doing this full reload. For that, we'll need actual per-field deltas.

>> +        return true;
>> +    }
>> +
>>       /*
>>        * Always return true for now until we're able to detect all possible
>>        * changes to a VirtIONet device.
>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>> index 752c46ce53..9949b94b64 100644
>> --- a/include/hw/virtio/virtio.h
>> +++ b/include/hw/virtio/virtio.h
>> @@ -103,10 +103,14 @@ enum virtio_device_endian {
>>    * struct VirtIODevMigration - Common VirtIODevice migration structure
>>    * @early_load: Flag to indicate an early virtio_load for the device.
>>    * @status_early: Device status at the time it was sent early.
>> + * @config_len_early: Length of the config buffer at the time it was sent early.
>> + * @config_early: Config buffer at the time it was sent early.
>>    */
>>   typedef struct VirtIODevMigration {
>>       bool early_load;
>>       uint8_t status_early;
>> +    size_t config_len_early;
>> +    uint8_t *config_early;
>>   } VirtIODevMigration;
>>
>>   /**
>> --
>> 2.51.0
>>
> 


