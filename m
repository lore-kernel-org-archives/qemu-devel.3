Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0392DEDF14D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqqF5-0003hO-Iu; Fri, 13 Feb 2026 05:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqqEz-0003dQ-Az
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:17:40 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqqEt-0004L1-9o
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:17:36 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D56gNS3415852; Fri, 13 Feb 2026 02:17:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=QlCJZ2YW0VRaJS67IJ/2duFyKc2y65pqTxRu6Cl5n
 Q4=; b=FtFTUo0hE7FT9VQv3qLNqa8/n4l5fjfbhJ43d5nrtJKc09L0vqEJVy9rw
 feN6gZAsqH0Rvd6HF7XjHGEeyolkaiRJAdn6zmKqJd2h7c4vvoqS41zcUu2nelKR
 nA/vdU2Div1j0ptnpDXKbF4ZLACe66Br8WokXGbnys9P5ESLxplM1aYph++ImS0U
 1w8rFgRzpP54mpKUY5TQR5eYFTGsn3XYb0wDdbWSDVuptaRjGUgJW2I0pl4qiwxu
 mBWQBy1Aac2Ab6fvkf8YqlELHrCZbndgrnsOLfHo95VBflouDO+AuNh+FugLxyLG
 2xXEETRZ6q2kvRFlg6Ohkk/CcP+4g==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020116.outbound.protection.outlook.com
 [40.93.198.116])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c9jp9t77x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 02:17:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TS4TB4mb2iifVcea86x5dezmesnZWy+NBlXT2E1Qw9hd8dyqyq1lVI0NyVkJ3vX9aFjMhoFeSSBgY9eemPOBUBIto0ejhs/8Ao39gweIeCirzu0A8H0IZMhYi/1nxAwmaTZCzOSLQlyOwDtbrjt4EyudDrJ07ho5AwdZfB4YjBRwY3n3yXdm6QiRheTNMacFvDjdnRZj1OTmORQf7QCORiQoySYJAf2zO4j2vxyKXVfIOJReqZmqHS5MgoBO1qRXrDv8HrJTmH4ioF4bTKhlpvyCxU3/I71NjCoxdOeLhv8NsH+5xj6osl75/I2UopBIOQnDLaOplRztc/LZNs9S5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlCJZ2YW0VRaJS67IJ/2duFyKc2y65pqTxRu6Cl5nQ4=;
 b=P2sMyedxoaffzWaBk/3R7hOI0D2c1FRJjAT6382BfJD5Ho0d4jjhxir/ffttl+KvqCJn1uD4ueFzdtBZRBm4Y/ctUTnSh+8813/ueM8EjRj8y56qw72hM6BNasUNQNKRQbjN5ZIWv4mywrsI6pJh+Em/qD6f23aeJO5zSvq423D4Q8eKhGYJjyz6ORXO4/hDhp9YBwHjO5ReR+n2Kk3mFzO2+a2T2kSF+Nnqe4MSGUJoW5z9e7JHWKGkBMmxfWhML1QJIxuagT2sWM36F/yixABtapZ40wiXYM6Bk+e0+Swk/ZuMHMPa7r/lNDHwvFj/Q5jdJjiO29kLWi/9eYebsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlCJZ2YW0VRaJS67IJ/2duFyKc2y65pqTxRu6Cl5nQ4=;
 b=FEtsyBE4hFbFSkN0MMQllPgakKx1KX0YMp8CcMj5+H9bKoICnWEOWvcpt7+f3xYTwHW+c6mgQEkxF23rP471Z8i6t5rtCVFji5GwV5hReCQqqBS8IZDjpqd7LRWsRCjfVzuX+BWNLe1qKCfB3mMLmDE6Koc7xHKkAKY0ko9w6dWFptxndoJy6UcF6viFPlLge6Y3vrSQgywP2ZhPd43neViPcMJ/rU8q6vfpsHBrsQKPnV3Ev90/g7dVshcFFM5r2hqivbN7RlBwkJEVfJWpDFmE9Rk4ND6c2Wub7Va1TNY4OMbsCRMUJmwOzTdWJ3nNAnb7WY/jBstxdHiGBeZ/MQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL0PR02MB6548.namprd02.prod.outlook.com (2603:10b6:208:1c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 10:17:26 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 10:17:26 +0000
Message-ID: <1e10cb81-5168-4907-8bc5-4223f1494bc8@nutanix.com>
Date: Fri, 13 Feb 2026 10:17:21 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/43] audio/pw: convert to QOM lifecycle methods
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-10-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-10-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0099.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL0PR02MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c8e566-6acf-424f-5b58-08de6ae91575
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cC95TVJkVDNNemtEaENkNDdRUTNBdkNjQmRBYUZVa0w0eWtDRXNjQjB3ckRE?=
 =?utf-8?B?Y1JwZ2VMWm5FbHJuZFJZZ3gyaUFTVS9BMlc4TW5ORUpybVYrVjIwZjRzdVRo?=
 =?utf-8?B?cTEvc2puWllieXUybktDWmdtL3JxMGVTT2JvdGZwWWIrVWtjLzJQcURCZWtP?=
 =?utf-8?B?YVVSRkl2cThiWFdFaUMxU1lIc1RlSHdidTd3cjBFcm5OeHY3VXR5Z0RTRXA4?=
 =?utf-8?B?dVQzYnBmKzBVbnhiWmlOSEJuL0oyL3BaZFFWZUpFVkhjVUFkbG95d25Gak9m?=
 =?utf-8?B?Y3AxeUNNNE84dDNPRFJ4K0ptY3haamwyUTdXQXdqMThFaVNpWTVJMmpnNkFB?=
 =?utf-8?B?anIxWUs0N3pnOHZGRGRWc25kTmNjZ01DNng2SDBKeXlDNVpoeVZqdGxwaGJP?=
 =?utf-8?B?RG1LYTlYQkdFcEVVdUxGSXVLWm9ucTI5TlFtTElDOVAyL096UUxuZlhlU1NN?=
 =?utf-8?B?VU01Zm1tL1dKS0p3eGZlSkh4R050RGd1UC9oQTIyL1AyQy93b1NMV3NoN1Ns?=
 =?utf-8?B?RlZOSWRLTnZqTDNsWm4wUUZVcnBTWXU3dkRNM2lsaGlnZ2lXNE1JRGJvUGJC?=
 =?utf-8?B?SnNrbnRDeHpncndkSjZDU3NpNjJsRElRcldyT2w4cXFvYnRKWmVsOXhOMG54?=
 =?utf-8?B?Wk5wcmxma1JMSVh0V3J2S0diK29sVmgwWlo5d1ZwN1pKTnFZUHFlS2xHbngz?=
 =?utf-8?B?QjM0ckpBYXBCWUhXZldRcTROSFhQaFFJdzdoajBLb2x3TUkwR1VwbzBhVlpL?=
 =?utf-8?B?TjliSDdBZzRobEUrYW9SRm9nZXY1YjluQU5UU29GNktKRUFHU1VzV281Tmwz?=
 =?utf-8?B?K2lhc3NSWk9pNHArS3JQeHZPMklYQmFRUU9YMmE2Vm5IVlV6NHlpRzRlaFhw?=
 =?utf-8?B?eXJmcXVERDhiS2NadU1YV3NFMmkveG53dW9ZZGoxaWM1Y2RSMmJxZFlJR0V2?=
 =?utf-8?B?QlFnVmlpZi8xZ21LS3pNYllkOCtqTUJSWVBZQ3RBWC9ocURNa3B2YVpqMHpJ?=
 =?utf-8?B?QzUwVUo3RFUySDRxaXJiUTk4NmZmeHpqMFpVKzFiSFVuL01pZE1YQWxTcUJi?=
 =?utf-8?B?bFMvZXY3MTJQdXlBTXBDR09HVEEvVzliV0R3UEFDVE80VXJqblNDTmErQnB0?=
 =?utf-8?B?YXB4bjFOL0tOVjFjTWN4Z2ZrWjRGSTVxK0JlRVRmMHI5TVNmczludG5xa2Ew?=
 =?utf-8?B?RFNYN0o0aG40M1NVTUVxZXA3WWVvMVoxZVlMa1RuNWdSMGxTcXdnYjEvT0hT?=
 =?utf-8?B?TllraU10K2xBWUhVRS9NZnV4cURuTmIxNVpFanRZUGp4TCtkVThNaVJvU1cx?=
 =?utf-8?B?V0xaUCtpa056L2pad1BwM1V1cVVlL0RqRFd4Vjg1cTRyZmhYTVBkNWNjVy9Y?=
 =?utf-8?B?bDN2UlNXanFmNVhKeVlkbFRsa0JJWGRYekE0ajdKd1RHUUx6bWRUTXQ0MkFu?=
 =?utf-8?B?ZE5mbzFrbzl2cTBjQzFEMHBFRmtOL2hTcnU0TWpYSlRtU3RlQXBYVnBRd2NS?=
 =?utf-8?B?Z2tBMHQ2ZWY3RUtibTV6RExHdXVDOHlwOEpOV05yaVRyL1c3WDNsbVhFb01K?=
 =?utf-8?B?RFB2cW1JQXJjaXlCRDlaaTJiQUJ4ZktvVTdEdG50Ny83cjJCbDJVVWl3TEZu?=
 =?utf-8?B?bU5MYjdFSDhyNE9qY0M0M2dhb0NqSnBpdy9mcWRmekNIYU9lV0JrR093SVk3?=
 =?utf-8?B?QTRkSXlWNHdWY3JoTnhpeENMMnl0RHRNTXdUL3RSbDRsK0xWQzBkaUZBS1hj?=
 =?utf-8?B?K3J2YmFXRW16WGRhZnFqSmJKNTE0REZxbGNMbkdwZFBOTXB6ZEV1bU5Ya3BS?=
 =?utf-8?B?dVkyQmNqYzBQeFlHaEVmNTJiOW0yVEY1MHR3WEdVVkZ1eExDV3NaNHpvVmR4?=
 =?utf-8?B?WjEvVnVmVThXT3hUUHYzZkZNZ1AyNTZuOXRuTWdOa0p0VWVSODBhcmhIS2tp?=
 =?utf-8?B?dmF5RjhGclNsUGxiUWpVRmVFT1k1S1FueDNyL2NlWUpaWkdqcTJ1L1QvSnhM?=
 =?utf-8?B?US9UODV6T3J3UFJ0MndLWEwrK0NqY2hkMkxQY1JxSHlVVW13V3hsL3EvdFRS?=
 =?utf-8?B?c1FXa0hrREdTREZvdlVNWWlXaDhXKy9Rdmtxa2dZLzU3bi95TlFocjdYL3FO?=
 =?utf-8?Q?TDN0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE5iWVNoWC9mdlhkcnExanZpM2lPUXc1SjQybG5NMUMvOFVhTFEwc0xtZlBW?=
 =?utf-8?B?R0ZNWkNjR3VPaTZia3hrVVZDdFNwSVVRWklnUWJPTSt5Rm1sZ0JzcUNrSU9y?=
 =?utf-8?B?SnNTU3VlajFUSC9JdDVWUTh0dko4N3FPUnRmUS9HUmVhOGtSaDRzVGxXWWh4?=
 =?utf-8?B?L0R4TWNMMEpCa1MxcnpiNlpVZGRXV2txaUx1THJnM3dBZkpIOElsRVJseWxw?=
 =?utf-8?B?V29RVDMwYnZVNWJzOUcydU16cW8xSWs2eVJNVnRnMTZmM0Q4WElmUXVUSUYy?=
 =?utf-8?B?U2Zla2lsL2tPNi9WT0h0YXVuL1REMm9MRHc5U0hQR1B1eWUxb21LTngvc0p5?=
 =?utf-8?B?c3BoeGF3MGx0WW4zdFVzYWJmZ2hZZ3RMS2N6eXY3ZWtRQ21YRGxZd1U5bUVM?=
 =?utf-8?B?UWs2TVQ4Y0NMZVBuanNJWXVqeWtHNjRSMlMxV1lpUXo2WVhkWlZaU095QVBM?=
 =?utf-8?B?VFFoMEppWE1uai9VcFlwNjIwdVRkMXZlTCsxUmZ5NVZHMFAwejVrdGgvK01R?=
 =?utf-8?B?aWZMVVRhNitTZ0MvRVVVYjd0cEZCdnB5L1B3WTZrcGNjMEMrK0RNVTdhMnFZ?=
 =?utf-8?B?ZUpCMmV2QnFlNFBNc0Zlazd5SENLeGx0VElpeEVSZkhJem04ZEUrR2VsUnEw?=
 =?utf-8?B?d2VNVmVwK1JSMzRnWDFNb1JuNjlhbTJqRmdTSExRakpXQXM3L2pEWFhFWlFC?=
 =?utf-8?B?NEJEbUFqdmJZUC95NUg1UnRSMFB6emFkTUxReG1TYTFRd3VHYUlrU1A2eGNk?=
 =?utf-8?B?bTdNa0VFemtYT1hJM2htUmswWUtjS3BJeURsb1NsNy91SE9taFdnQklFeCtJ?=
 =?utf-8?B?am1aRTdsaUZxTkcxQXA4Y1lWOVR1WlBOeEVYeTFyc3ZnWUZwRUJlb3FNRUFX?=
 =?utf-8?B?Q0xSS2dYT0RucE8zQlJlUjM3Um5QWjlJSElUMmcrb283SmZSdC9QTTlEVWgz?=
 =?utf-8?B?eWlabmpHdk9QRUd5YSs2L2ZZeTMya0JjRnJycFlKRCtJdXMxMWMxRUNSNHJK?=
 =?utf-8?B?bStWVEFNNDJETUFDbVhvUERkWWRGUVI4NVdhNkp3b1R5NGxMTHZITjZ2dFln?=
 =?utf-8?B?U1B6cWd0K3lBVGlPRXNJeS96Sk43R2tZc2xqUzkzUUU5OWYycmZqM0VTbUcw?=
 =?utf-8?B?YzY0eVp1U1VQQ3JqbmtwZ3pMbGNMWnZRejN4NWt6WC9qa2lrK0dWMVhZQ0du?=
 =?utf-8?B?ajhvK2I2VEpNbmprZzFmMDBFbmlMRVYwS1NjbUxiNStVV1NkdHFnSXBDWW1n?=
 =?utf-8?B?VThpYXovY0FXZzVIWGxwdE04VWdua2lnYVIyTkJSU2tOSkRnbkVMVHJRRWZN?=
 =?utf-8?B?Q3B0T2xveHR6Mnc5OE05RHpWcFI0OVpsMzJyczkyeElNblMzWHJROXhDY1h1?=
 =?utf-8?B?bnhTNE9DeW5ScEhXbGtIVDRMcFRlNTF0ZUVrUzYxSy91THg2dnlPOEo0bXB2?=
 =?utf-8?B?K2kxTFJkVU1RNWRPWHRkQXUvVlN3TTJVaWloL0o5OHhCaVJBZk93bzV3UHBM?=
 =?utf-8?B?VnBHd0ZEM0Z4dzVXL0JaU1k1Nm5XUW9aSUczTmREWHRlNFRjNjJFeTFlMzdF?=
 =?utf-8?B?cWNxU0tXQjRVaFBkVDB1cjByWklWZmpWa1BWMVRNeGo0Mms3MlQrUUJGMkdN?=
 =?utf-8?B?bVp1TGk4SGl3Nlo2M0h0MXdwd0VKcTJwY2JLeng2TkRoSUkwNWpXai9NUlpr?=
 =?utf-8?B?a2MxR0swS1lhd2d3RGp0dUlHZTBjZDdMVEZYbFJ2dnJaZjZNVXhpZTBnZTRB?=
 =?utf-8?B?clNuZ2hFK1RiRjJNUjlIdUtpZzlVRTFXNlRQYzJhWllrS1dmckRjbE8zZXQz?=
 =?utf-8?B?Ri9VZGxwK0FyamZlWmlYbWtvNjM5Ky8rVUNuVEVYenVULzdMMWVDemVMTTJ0?=
 =?utf-8?B?RXVLN3ZEZ2p1ZEc0RnR0WndQaW5nWXlzcGp5d3Mzdkt4VW1LdDErd3VRSWJL?=
 =?utf-8?B?ZDQ4c0F0dkUzMFMvWDVkQXRhK0YrQ2NjWFluWUhHaVZWTmF1ZU1LazZVR21E?=
 =?utf-8?B?UHdIem04dFRubWpOT2t0bHRuU2tQMlFqcjJrYXU4VDVlajZwMGQ0MS9RQXJr?=
 =?utf-8?B?MWliSlA2L2VBcDM0cGZSZWJlSnpiVVI1cmpwanQ0ZUZLL0UzMFdOT3F6cXl1?=
 =?utf-8?B?bkNxY3E3WkZ4WGdNclpZUVQwRDZaOHFlWU44Z0ZKYk9VMmNSRmxRVnFSNjV3?=
 =?utf-8?B?YUdHZXFPM3IwQjZQbzNZWVdzNDZGdVZERE5DMkdJR01LRG5zeko1cWQzM0F4?=
 =?utf-8?B?a29TU2FoY2RlRno1OVdqelRCQzNFVEVSazl0ei93d2gzUnZYNC9PNDBpbmtr?=
 =?utf-8?B?aGYxUWpMSjBnY25IN1ZaZGhObGJBenVpbkdJY3NDQjU2QUlQQlBPdy9wWUE0?=
 =?utf-8?Q?RaCR24QwHQS/dTIw=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c8e566-6acf-424f-5b58-08de6ae91575
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 10:17:26.0751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lV9W/1nQrLfHKp78Zw51wOkkVYNt3RrSjn7m5tDUck8GDm04aleEFOPH3Kf3NsztMs+oEE/RrfbX2+lGgUetFx1AW6/khIGNIeTd3SiuvFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6548
X-Proofpoint-ORIG-GUID: Uj21pQLe-epQuf_iYMplulVWJs-LVSod
X-Proofpoint-GUID: Uj21pQLe-epQuf_iYMplulVWJs-LVSod
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA3OSBTYWx0ZWRfX2Ec/gvrDsgk5
 QEbQeGGoqlkXBkcfdPSzCFge4S6RfmRbwwzRwSCvoMSwOCKhN5rXNeSt0RnPazUKIOBmA0KQZ4Y
 DQAtVo51euSBAmJ+ErQFiUrYDqjN6slqUAqdqfIXZ8tLg2qdo+F7qZnE/G+rR56bFW73aU37qP9
 13Os0mlBXMP7ZnSzcrd+UPJPGgoVuqIOhEGUPmuksgvoLzo4Wvy8Ml46ASe1GKokqWyxQJxTlqd
 Id2U6sNEJgGsRja7VHHeiXg+ClWwDcXJQGyDFIvmmgF5u+TGEpjZnN95Q6Eaomjm9dIMfkYOAWu
 CeZzC1ldHaFsIGXlKHCaB4HvN6SZOBUT8KPbDkBA4++gYPiwY2nbc4Z/B3j/VwlI2B+R71FedWr
 wy2sle7jVlLMDLpxI713m0Qv0L+tor8KVlQGjHJH/VeYMzkONlOwf6xISbrM3i8Y8mvdD537IIm
 sdBikFV+q3QxaCeZW5w==
X-Authority-Analysis: v=2.4 cv=SKJPlevH c=1 sm=1 tr=0 ts=698efa38 cx=c_pps
 a=r0Opn4K694hZap5IejKoFw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=KkJ2CCz0rFe7aWyIeEUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Migrate the PipeWire audio backend from the legacy driver init/fini
> callbacks to proper QOM realize and finalize methods.
> 
> The pwaudio struct fields are now embedded directly in the AudioPw
> QOM object instead of being allocated separately as drv_opaque. This
> allows accessing the backend state through proper QOM type casting
> with AUDIO_PW() rather than casting drv_opaque pointers.
> 
> The PipeWire thread loop and context are now managed through the QOM
> lifecycle, with initialization in realize and cleanup in finalize.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/pwaudio.c | 119 +++++++++++++++++++++++-------------------------
>   1 file changed, 58 insertions(+), 61 deletions(-)
> 
> diff --git a/audio/pwaudio.c b/audio/pwaudio.c
> index ed48a9754fe..ddf5f2c70f7 100644
> --- a/audio/pwaudio.c
> +++ b/audio/pwaudio.c
> @@ -31,36 +31,27 @@
>   #define TYPE_AUDIO_PW "audio-pipewire"
>   OBJECT_DECLARE_SIMPLE_TYPE(AudioPw, AUDIO_PW)
>   
> +static AudioBackendClass *audio_pw_parent_class;
> +
>   struct AudioPw {
>       AudioMixengBackend parent;
> -};
>   
> -static struct audio_driver pw_audio_driver;
> +    struct pw_thread_loop *thread_loop;
> +    struct pw_context *context;
>   
> -static void audio_pw_class_init(ObjectClass *klass, const void *data)
> -{
> -    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +    struct pw_core *core;
> +    struct spa_hook core_listener;
> +    int last_seq, pending_seq, error;
> +};
>   
> -    k->driver = &pw_audio_driver;
> -}
> +static struct audio_driver pw_audio_driver;
>   
>   typedef struct pwvolume {
>       uint32_t channels;
>       float values[SPA_AUDIO_MAX_CHANNELS];
>   } pwvolume;
>   
> -typedef struct pwaudio {
> -    Audiodev *dev;
> -    struct pw_thread_loop *thread_loop;
> -    struct pw_context *context;
> -
> -    struct pw_core *core;
> -    struct spa_hook core_listener;
> -    int last_seq, pending_seq, error;
> -} pwaudio;
> -
>   typedef struct PWVoice {
> -    pwaudio *g;
>       struct pw_stream *stream;
>       struct spa_hook stream_listener;
>       struct spa_audio_info_raw info;
> @@ -236,9 +227,9 @@ static const struct pw_stream_events playback_stream_events = {
>   static size_t
>   qpw_read(HWVoiceIn *hw, void *data, size_t len)
>   {
> +    AudioPw *c = AUDIO_PW(hw->s);
>       PWVoiceIn *pw = (PWVoiceIn *) hw;
>       PWVoice *v = &pw->v;
> -    pwaudio *c = v->g;
>       const char *error = NULL;
>       size_t l;
>       int32_t avail;
> @@ -273,9 +264,9 @@ done_unlock:
>   
>   static size_t qpw_buffer_get_free(HWVoiceOut *hw)
>   {
> +    AudioPw *c = AUDIO_PW(hw->s);
>       PWVoiceOut *pw = (PWVoiceOut *)hw;
>       PWVoice *v = &pw->v;
> -    pwaudio *c = v->g;
>       const char *error = NULL;
>       int32_t filled, avail;
>       uint32_t index;
> @@ -298,9 +289,9 @@ done_unlock:
>   static size_t
>   qpw_write(HWVoiceOut *hw, void *data, size_t len)
>   {
> +    AudioPw *c = AUDIO_PW(hw->s);
>       PWVoiceOut *pw = (PWVoiceOut *) hw;
>       PWVoice *v = &pw->v;
> -    pwaudio *c = v->g;
>       const char *error = NULL;
>       int32_t filled, avail;
>       uint32_t index;
> @@ -434,7 +425,7 @@ pw_to_audfmt(enum spa_audio_format fmt, int *endianness,
>   }
>   
>   static int
> -qpw_stream_new(pwaudio *c, PWVoice *v, const char *stream_name,
> +qpw_stream_new(AudioPw *c, PWVoice *v, const char *stream_name,
>                  const char *name, enum spa_direction dir)
>   {
>       int res;
> @@ -452,8 +443,8 @@ qpw_stream_new(pwaudio *c, PWVoice *v, const char *stream_name,
>       }
>   
>       /* 75% of the timer period for faster updates */
> -    buf_samples = (uint64_t)v->g->dev->timer_period * v->info.rate
> -                    * 3 / 4 / 1000000;
> +    buf_samples = (uint64_t)AUDIO_MIXENG_BACKEND(c)->dev->timer_period
> +        * v->info.rate * 3 / 4 / 1000000;
>       pw_properties_setf(props, PW_KEY_NODE_LATENCY, "%" PRIu64 "/%u",
>                          buf_samples, v->info.rate);
>   
> @@ -535,11 +526,11 @@ qpw_set_position(uint32_t channels, uint32_t position[SPA_AUDIO_MAX_CHANNELS])
>   static int
>   qpw_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
>   {
> +    AudioPw *c = AUDIO_PW(hw->s);
>       PWVoiceOut *pw = (PWVoiceOut *) hw;
>       PWVoice *v = &pw->v;
>       struct audsettings obt_as = *as;
> -    pwaudio *c = v->g = drv_opaque;
> -    AudiodevPipewireOptions *popts = &c->dev->u.pipewire;
> +    AudiodevPipewireOptions *popts = &AUDIO_MIXENG_BACKEND(c)->dev->u.pipewire;
>       AudiodevPipewirePerDirectionOptions *ppdo = popts->out;
>       int r;
>   
> @@ -554,11 +545,11 @@ qpw_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
>           pw_to_audfmt(v->info.format, &obt_as.endianness, &v->frame_size);
>       v->frame_size *= as->nchannels;
>   
> -    v->req = (uint64_t)c->dev->timer_period * v->info.rate
> +    v->req = (uint64_t)AUDIO_MIXENG_BACKEND(c)->dev->timer_period * v->info.rate
>           * 1 / 2 / 1000000 * v->frame_size;
>   
>       /* call the function that creates a new stream for playback */
> -    r = qpw_stream_new(c, v, ppdo->stream_name ? : c->dev->id,
> +    r = qpw_stream_new(c, v, ppdo->stream_name ?: AUDIO_MIXENG_BACKEND(c)->dev->id,
>                          ppdo->name, SPA_DIRECTION_OUTPUT);
>       if (r < 0) {
>           pw_thread_loop_unlock(c->thread_loop);
> @@ -582,11 +573,11 @@ qpw_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
>   static int
>   qpw_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
>   {
> +    AudioPw *c = AUDIO_PW(hw->s);
>       PWVoiceIn *pw = (PWVoiceIn *) hw;
>       PWVoice *v = &pw->v;
>       struct audsettings obt_as = *as;
> -    pwaudio *c = v->g = drv_opaque;
> -    AudiodevPipewireOptions *popts = &c->dev->u.pipewire;
> +    AudiodevPipewireOptions *popts = &AUDIO_MIXENG_BACKEND(c)->dev->u.pipewire;
>       AudiodevPipewirePerDirectionOptions *ppdo = popts->in;
>       int r;
>   
> @@ -602,7 +593,7 @@ qpw_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
>       v->frame_size *= as->nchannels;
>   
>       /* call the function that creates a new stream for recording */
> -    r = qpw_stream_new(c, v, ppdo->stream_name ? : c->dev->id,
> +    r = qpw_stream_new(c, v, ppdo->stream_name ? : AUDIO_MIXENG_BACKEND(c)->dev->id,
>                          ppdo->name, SPA_DIRECTION_INPUT);
>       if (r < 0) {
>           pw_thread_loop_unlock(c->thread_loop);
> @@ -621,10 +612,8 @@ qpw_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
>   }
>   
>   static void
> -qpw_voice_fini(PWVoice *v)
> +qpw_voice_fini(AudioPw *c, PWVoice *v)
>   {
> -    pwaudio *c = v->g;
> -
>       if (!v->stream) {
>           return;
>       }
> @@ -637,19 +626,18 @@ qpw_voice_fini(PWVoice *v)
>   static void
>   qpw_fini_out(HWVoiceOut *hw)
>   {
> -    qpw_voice_fini(&PW_VOICE_OUT(hw)->v);
> +    qpw_voice_fini(AUDIO_PW(hw->s), &PW_VOICE_OUT(hw)->v);
>   }
>   
>   static void
>   qpw_fini_in(HWVoiceIn *hw)
>   {
> -    qpw_voice_fini(&PW_VOICE_IN(hw)->v);
> +    qpw_voice_fini(AUDIO_PW(hw->s), &PW_VOICE_IN(hw)->v);
>   }
>   
>   static void
> -qpw_voice_set_enabled(PWVoice *v, bool enable)
> +qpw_voice_set_enabled(AudioPw *c, PWVoice *v, bool enable)
>   {
> -    pwaudio *c = v->g;
>       pw_thread_loop_lock(c->thread_loop);
>       pw_stream_set_active(v->stream, enable);
>       pw_thread_loop_unlock(c->thread_loop);
> @@ -658,19 +646,18 @@ qpw_voice_set_enabled(PWVoice *v, bool enable)
>   static void
>   qpw_enable_out(HWVoiceOut *hw, bool enable)
>   {
> -    qpw_voice_set_enabled(&PW_VOICE_OUT(hw)->v, enable);
> +    qpw_voice_set_enabled(AUDIO_PW(hw->s), &PW_VOICE_OUT(hw)->v, enable);
>   }
>   
>   static void
>   qpw_enable_in(HWVoiceIn *hw, bool enable)
>   {
> -    qpw_voice_set_enabled(&PW_VOICE_IN(hw)->v, enable);
> +    qpw_voice_set_enabled(AUDIO_PW(hw->s), &PW_VOICE_IN(hw)->v, enable);
>   }
>   
>   static void
> -qpw_voice_set_volume(PWVoice *v, Volume *vol)
> +qpw_voice_set_volume(AudioPw *c, PWVoice *v, Volume *vol)
>   {
> -    pwaudio *c = v->g;
>       int i, ret;
>   
>       pw_thread_loop_lock(c->thread_loop);
> @@ -693,16 +680,16 @@ qpw_voice_set_volume(PWVoice *v, Volume *vol)
>   static void
>   qpw_volume_out(HWVoiceOut *hw, Volume *vol)
>   {
> -    qpw_voice_set_volume(&PW_VOICE_OUT(hw)->v, vol);
> +    qpw_voice_set_volume(AUDIO_PW(hw->s), &PW_VOICE_OUT(hw)->v, vol);
>   }
>   
>   static void
>   qpw_volume_in(HWVoiceIn *hw, Volume *vol)
>   {
> -    qpw_voice_set_volume(&PW_VOICE_IN(hw)->v, vol);
> +    qpw_voice_set_volume(AUDIO_PW(hw->s), &PW_VOICE_IN(hw)->v, vol);
>   }
>   
> -static int wait_resync(pwaudio *pw)
> +static int wait_resync(AudioPw *pw)
>   {
>       int res;
>       pw->pending_seq = pw_core_sync(pw->core, PW_ID_CORE, pw->pending_seq);
> @@ -725,7 +712,7 @@ static int wait_resync(pwaudio *pw)
>   static void
>   on_core_error(void *data, uint32_t id, int seq, int res, const char *message)
>   {
> -    pwaudio *pw = data;
> +    AudioPw *pw = data;
>   
>       error_report("error id:%u seq:%d res:%d (%s): %s",
>                   id, seq, res, spa_strerror(res), message);
> @@ -737,7 +724,7 @@ on_core_error(void *data, uint32_t id, int seq, int res, const char *message)
>   static void
>   on_core_done(void *data, uint32_t id, int seq)
>   {
> -    pwaudio *pw = data;
> +    AudioPw *pw = data;
>       assert(id == PW_ID_CORE);
>       pw->last_seq = seq;
>       if (pw->pending_seq == seq) {
> @@ -752,17 +739,20 @@ static const struct pw_core_events core_events = {
>       .error = on_core_error,
>   };
>   
> -static void *
> -qpw_audio_init(Audiodev *dev, Error **errp)
> +static bool
> +audio_pw_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
>   {
> -    g_autofree pwaudio *pw = g_new0(pwaudio, 1);
> +    AudioPw *pw = AUDIO_PW(abe);
>   
>       assert(dev->driver == AUDIODEV_DRIVER_PIPEWIRE);
>       trace_pw_audio_init();
>   
> +    if (!audio_pw_parent_class->realize(abe, dev, errp)) {
> +        return false;
> +    }
> +
>       pw_init(NULL, NULL);
>   
> -    pw->dev = dev;
>       pw->thread_loop = pw_thread_loop_new("PipeWire thread loop", NULL);
>       if (pw->thread_loop == NULL) {
>           error_setg_errno(errp, errno, "Could not create PipeWire loop");
> @@ -801,8 +791,7 @@ qpw_audio_init(Audiodev *dev, Error **errp)
>       }
>   
>       pw_thread_loop_unlock(pw->thread_loop);
> -
> -    return g_steal_pointer(&pw);
> +    return true;

Unrelated to this patch directly, however when viewing the file at this 
commit I see the end of audio_pw_realize() looks like this:

     if (wait_resync(pw) < 0) {
         pw_thread_loop_unlock(pw->thread_loop);
     }

     pw_thread_loop_unlock(pw->thread_loop);
     return true;

If pw_thread_loop_unlock() is always called regardless, why do we need 
the wait_resync() logic? Is there a refcounted mutex involved?

>   fail:
>       if (pw->thread_loop) {
> @@ -810,13 +799,13 @@ fail:
>       }
>       g_clear_pointer(&pw->context, pw_context_destroy);
>       g_clear_pointer(&pw->thread_loop, pw_thread_loop_destroy);
> -    return NULL;
> +    return false;
>   }
>   
>   static void
> -qpw_audio_fini(void *opaque)
> +audio_pw_finalize(Object *obj)
>   {
> -    pwaudio *pw = opaque;
> +    AudioPw *pw = AUDIO_PW(obj);
>   
>       if (pw->thread_loop) {
>           pw_thread_loop_stop(pw->thread_loop);
> @@ -831,9 +820,7 @@ qpw_audio_fini(void *opaque)
>       if (pw->context) {
>           pw_context_destroy(pw->context);
>       }
> -    pw_thread_loop_destroy(pw->thread_loop);
> -
> -    g_free(pw);
> +    g_clear_pointer(&pw->thread_loop, pw_thread_loop_destroy);
>   }

Is there any way that pw->thread_loop can be locked when _finalize() is 
invoked given that there is no explicit unlock here? Or is this done by 
one of the other functions?

>   static struct audio_pcm_ops qpw_pcm_ops = {
> @@ -855,8 +842,6 @@ static struct audio_pcm_ops qpw_pcm_ops = {
>   
>   static struct audio_driver pw_audio_driver = {
>       .name = "pipewire",
> -    .init = qpw_audio_init,
> -    .fini = qpw_audio_fini,
>       .pcm_ops = &qpw_pcm_ops,
>       .max_voices_out = INT_MAX,
>       .max_voices_in = INT_MAX,
> @@ -864,11 +849,23 @@ static struct audio_driver pw_audio_driver = {
>       .voice_size_in = sizeof(PWVoiceIn),
>   };
>   
> +static void audio_pw_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    audio_pw_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
> +
> +    b->realize = audio_pw_realize;
> +    k->driver = &pw_audio_driver;
> +}
> +
>   static const TypeInfo audio_pw_info = {
>       .name = TYPE_AUDIO_PW,
>       .parent = TYPE_AUDIO_MIXENG_BACKEND,
>       .instance_size = sizeof(AudioPw),
>       .class_init = audio_pw_class_init,
> +    .instance_finalize = audio_pw_finalize,
>   };
>   
>   static void

Regardless:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


