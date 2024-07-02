Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47D3C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 15:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOfBk-0004dY-Pz; Tue, 02 Jul 2024 11:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOfBj-0004bo-N3
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:12:59 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOfBh-0007C6-F7
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719933177; x=1751469177;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Fa0py6I8Nur3s81TBVxVLyoeYs9jePC/dJapbBXCrP0=;
 b=XSOxNIsZunilPAW7KZz3RwzPMoGJ272gkLWHEcXbnryI0eZyiRkAgEkH
 T9+pk6wFXurBUhEA9jb4XmaeSQufUzTq9/86Qnk3YTTDBBYj2MizUbCpw
 ahugb4+irGBWlhR8qFMZ31i0/0znR+0FWLdqY/0HLDKLpzQlTZLsTYmXf
 JnNiC68jkWqGj5z1juTp6jQ2k+6AjZlJwSNBVOcMKFbBlDPwJ35VKnT00
 jJaDhyMmK6zOOIc1jm163EKfoRPQ2XV4ycpIPLT1wVQUAeXUfjyzzkvGb
 ToQ3JZxnZunRIYUGGBPCbyQqiw8JVzCu5wjewCakbIwhuTSiMK8Xf2vNu Q==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208";a="15860276"
X-MGA-submission: =?us-ascii?q?MDGdkm7DhHizsmqCIemS+MYX7vbOwkxQ/REDLb?=
 =?us-ascii?q?nxEftoxgF3+s2O37JbzkmSzOe1yHIZmCJINFMrPgXxS3ZAhNMb6pAVvy?=
 =?us-ascii?q?SZLP0StJzNItoIk/L68M+mIqj//YYNZmQ8dTHb3QLtfBqq/iMsNbAHDd?=
 =?us-ascii?q?GzDPq+H1Q0rmvhfzfWnlkhJw=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 17:12:54 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJ3JQ238dfR4RbBKGlLBNH1V8GjaVQq3u3XGnNuTgDVleZWM3cLQu+yWFd0A0WMAoCcjJmQip9fK0tp7kw4qxWbwH6OPgDcCo1mf6moGHoNIHpLlteFKtBelG1c5IMuCprgU0mqeCT+nG8rTTqYO3ZwenheSoBh/72Q4hOIoFYj0pqG+k3np9LpVNErm2HneEEP7jQb3DJLnnXmAkma8npYhYeTzvTr+pBY3sXXkmj/sitpQ+jiBXPtNWHL9Shmloj4NlTzY9Ram5kj7JAuB0B06f4F0ipgzRkOCEE8UvKC35TC7D5QynZVZg7beUDk0ifKWbVc3/tAbtHM8hXsM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fa0py6I8Nur3s81TBVxVLyoeYs9jePC/dJapbBXCrP0=;
 b=bv6wShHeS7b+hOpKmxf/w7vQ2IJ23YFvB1fbfUUFqCjkB+WodPCe/ZFer7gGGkNSZNkp0Noqz0iE1XQ2yL+PpQed2e5O3MEsKEyAH3blhiM7ixkFWdPo1a+w+3hcSw8cdQmAn9/ozWBac5BSKq8w7UUK/b/Mn2Y4G33hd8RjPWxFQdtgqFD0W0MlMph99+THdGbSBJblokkKmuiVNdHSSxt5oj8rKGYKpMAArs9WPSTk245AVW3nQaXvXLsORe3tLfsEfzN0u1iF8BzeVZEmDFV6ACE4pTXXxxhAKDldxqV/MBMyyN11zGZOL8UvEg87Wv6BCr+zvwJqs+SUTcTM/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fa0py6I8Nur3s81TBVxVLyoeYs9jePC/dJapbBXCrP0=;
 b=GjRHIWPWLflQO61WNnUYv31WVlf6i7RdCEpTwx68FcOLxIu8+cP0wrkFe3VdCHUNG87KWNyP4Dq2pGW2eBvQ+1HLXd94RCqwjO2W8qfwXYswG+uLq/uyzXPuZnK7iK1ddaQBcFiPq03DFLgbEy3H7sgaGTXKB4B36Pmzl58j7K1ZRyMoFXZkuJE4xUE+ty1MKd9+Q9t3hAASu2U5VapMRjmSDytvQoSnNM8uzclnzhnnRVAVpHjYH0mnIytkKa11hoXvNLm0YZsyAJvWMknWflnek49JvgmQPlBxEhJwI1XQbMr2UL7Ri8LKqFtJVVxzxs5AncgIgOF0pc+kvZZZDA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB9406.eurprd07.prod.outlook.com (2603:10a6:800:1c0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Tue, 2 Jul
 2024 15:12:52 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 15:12:52 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Yi Liu <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Clement Mathieu--Drif
 <cmdetu@gmail.com>
Subject: Re: [PATCH ats_vtd v5 00/22] ATS support for VT-d
Thread-Topic: [PATCH ats_vtd v5 00/22] ATS support for VT-d
Thread-Index: AQHazEQGTuJM3iTlWUqCZ55Q529ilrHjc08AgAAYxgA=
Date: Tue, 2 Jul 2024 15:12:52 +0000
Message-ID: <b5f8a2fc-5f62-4c3a-a5a6-ef1476da3e4b@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
 <9b17bedc-b55b-4293-a1ff-4120296dc83d@intel.com>
In-Reply-To: <9b17bedc-b55b-4293-a1ff-4120296dc83d@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB9406:EE_
x-ms-office365-filtering-correlation-id: 99f42452-3f8e-4a15-9556-08dc9aa9716f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TjhUeWJhREM5SWl0WTMzWDZSRFl0YVlqbXM1VE8rS05kZDY3dXVVb05XZE1i?=
 =?utf-8?B?elZ0NjhZSVlCMXNKTE9Eb3RlRHkyUE93ZDZnUmg1N1NQdzRmUkt1U2U3YVNO?=
 =?utf-8?B?OUV0Sng1eFRacE55ODhlMTFFR0NKbmVMYW85UjNzMlkrQUdTT1h0ek5JbHpn?=
 =?utf-8?B?YnovVk1YK3dGRzdnenNXMUU5UjNnZm51VkQxcGRZa2orTDdjRnUxSEVudXRG?=
 =?utf-8?B?TndDbmRhYTFLejdpaGxpaUJpMWhQYWFNWElrc09kdHZJRTBKSjA0SjJlOXhs?=
 =?utf-8?B?S0Z3aXVFeEM2T0lGa1NRUnNyZVczd1NMMEM1VU4xb0lMN0xmK3B4Um1XVk5k?=
 =?utf-8?B?a1RnbHBxM0gzR1V1aUFaYTdyZENVRHBIcFdpaHUxa1VIRE9qanY4RWhCSGhM?=
 =?utf-8?B?UnY5M2MzS3k5cVRZd2h0UTRwZnFqM3BBVHJXZkhVVFIxaTFqRW5nNkljZ3FE?=
 =?utf-8?B?SkJteUdXbWpwMERVeHpETlU4dWpsbmZZL3BNVlh6NE1VZXRWT3RQWE84cDlN?=
 =?utf-8?B?akFFSHlWRGlhYmg0a2pMUWptZ0w0akU5c1l4bDZDTi9tclk0VXl4b1ZHZ0RQ?=
 =?utf-8?B?ci9lY1NHa3NvUG1vYWFLUTMzODh5SmFlUGoxRHVGZTU1TlNUeEZScTlmRE44?=
 =?utf-8?B?Z2pKTnBCS1RWRWlFK2MwNW1VcEFGcEFPZXBWbVNaQVo1bUJKSUgvOUx0ZCty?=
 =?utf-8?B?Q3VUY1NwemYzUGNMR2N2U0UrMzBxRzA1YWN0OVExZnA4S1hQSU9neUQ3MDBH?=
 =?utf-8?B?R0R0eVNKQWNzbWdWNnJPb0FPYnhENUd4ZHlwVHYrVWpDZGRoS0Npa25YUmxV?=
 =?utf-8?B?SThHVEhqTlZaTWlNMjk3K3d1TE9NMVJYVE1RTUhEbE1RcXlYZHNqSW5XNVZB?=
 =?utf-8?B?cWxBbUIxT2FzQUY4STE2U28xYWVrZGZhRlp4ZytNampCVHNuL3Zmcy9xSXFG?=
 =?utf-8?B?djB5UU5UOEwrc3JFNXRHTnlOVTVQTC9hdmxSR1Z5MERCT2p3RmJmbi9pQlAz?=
 =?utf-8?B?QlprUlQ0QlV4aGgzcTlCQktGS1J4VkRPcnlBcWFOcUJxZWVld1hqQ1p4NitV?=
 =?utf-8?B?eVRqM2IyS1NxUmxDTUlyQWtsK0tRRHJOSFdSQzFISncxY0xOUnJscDB1Ulc5?=
 =?utf-8?B?TGpWU2E3NXRwUGcveHFtL0QraGpWQmQwVjRXVmFqaE5DOGszR21TMW1yK1RY?=
 =?utf-8?B?bWllWEVtang4cXo0WE9jNHJWTVJGMEhZWkYycG5vcmpHNE9uamVNQmpycXMz?=
 =?utf-8?B?VmpBV0VrNWpvckhKU0pOL3VpSGhDQmwvSWR2UkoxMHBRd2FhcEg4RFBJbHZB?=
 =?utf-8?B?VTZnNGMwUWo3WTRieG51TC94WWRJNzM1djQyZ0RNL1hYbENSMHlWTE80bGlS?=
 =?utf-8?B?bW4rL0JxSHEweGJjcXpLMkRlbmhCZUY3cGNwYjZkeDZZTThnUEdYZ1lDZDRy?=
 =?utf-8?B?WjQ4blpXWnZTaTdXT2srNHRWUVBEOG5jcGsweU96eXFjbWZWTjFQTkZNSjFn?=
 =?utf-8?B?KzVTSHVINExHN29GcXJLbUVEbWNGNVJtbTI3aFA3cllQVnB3Y1Fsck1BN1d3?=
 =?utf-8?B?aHhlUUJNajc5Q3Z1Q0FuZjJBSGRZd1VScVhYR1JwVDI4TUFTL0dmOWFQM2tW?=
 =?utf-8?B?bzlNdXZvMEZvcE9tbUw0ZlJXNExKRGx2Y0N6Umk2RlNHa2NoSks5blZzY2Vj?=
 =?utf-8?B?U3dMdG9tVk1sc25hcytxMXI2R1ZaNCtUVjBpNTk4WURXZWNVS1JrTzhRVDRm?=
 =?utf-8?B?WU5INjdZaU5rWWN4S1NicGZ6RlR5clBrVTUwU0xWNjhIOVNMMzVkN3pxQ2RX?=
 =?utf-8?Q?MN6WXbz2GvDC8rZQ7UhfIzHu3gxuyJoakBFLA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHE3eUZSZ0lKd0Z3b3lJQUI5ZzJWc2JuYy9QcGZrODNaNVFiWkVuV0gzVFgv?=
 =?utf-8?B?cHgrK0E5R3FLYmdTNUwzQ21zbDJBVk1Tb1lSMncyMGhQZ2dKdEVOUHRGWWph?=
 =?utf-8?B?aGdxbG9XU01abWF2Y2xVQzlWekdQb1lDN3I4WXFGL0NmZFNiazNNRngrdFRx?=
 =?utf-8?B?UnJGSjZYeFFFV1BCNTZSUTRHb3A2dmNzSjhNaVZWSDd1QVBFb3VTSzNibU9u?=
 =?utf-8?B?dTl2ZVpaQ3oweE1vMEh0ZGlXRlhzZGNIY00wWENnbm1rSXhJcWM1akNSRHp0?=
 =?utf-8?B?eUVLdGFzeUtrMnluZU9lalNKK0xRUGlmYmJQMHVlcVVzRnBydFNMcThpTmtn?=
 =?utf-8?B?dGFIa3ZEaDJuOENWTlpmSzVMQ3ZXcnhZT1prVno0cElTYkdGbG1UaHBuMC9s?=
 =?utf-8?B?cnIwTlpFTkRGenpzY29XYlM1VTRkODJNZFZ5S1djN3FSZW1rOTdyMnNIZEpX?=
 =?utf-8?B?ckdwWkRuZVFnWVQzQUp2VzJBMFQ0MmFiVzNYV3BpdjV3VWwyRDZPTldvZllx?=
 =?utf-8?B?TllxQW4rNm41d2k4TllVUjdrb0tDUFdHaGg3QXJ6Uy9TeGdjcm4xU3FUNEV0?=
 =?utf-8?B?TTFFUUJYU3Z6VFh4NHhLeU41OStmVWE1Y200aDdHSzJQZE9hbTFGWlYwbFhL?=
 =?utf-8?B?N1VnVTNvNG9IMVBWM3lBb0ZCNGtNaCt0dU8xZHVnaTZwQmtwZnd5TmhNK2R4?=
 =?utf-8?B?enArZGhBZTJod3BBZzdhTUJiTzdORnpWQ2RVRHhJKy8vM3RDeER2TWxSWDA4?=
 =?utf-8?B?RVpHSlcrQU9QaFZLbmpJZU84WjIrRGR4MU1PdHlhdmg1cHpWQU0xRDdaUmFz?=
 =?utf-8?B?TDFpSk1jMW5Nemd0R0tjWHVhVE54MEttRERBWUozUUlFSVpidlNjc3NhYVJ5?=
 =?utf-8?B?ZkxGYS9NQlR4cEpEdzBKYkxHTE5TKyt3Q3h4bEZHbzhoVXpZUnVENnNIYkYw?=
 =?utf-8?B?ZFdBdHl4VG4zb2dTRFVXNE82cmUyTnMxTy9taHBCMVJRZU5kY3FQVGxQY3Q3?=
 =?utf-8?B?VHRaQVZVcnkrVGM2YUx6aXpZSjVYRk1xdFNwN0VUV2dKOHRrZE9NVlEwd1o3?=
 =?utf-8?B?OFh2WkprYzZVMC9aUExvMUZsTTQ4eHBOKzYxV0cvcmRuMWJwYVB1TGNydWwz?=
 =?utf-8?B?aDFESm1iME9OaGoxVlYra1RwSDE3VjdYWHVXUjJuOVhzbGxCcXdkTGJ1ODNH?=
 =?utf-8?B?S2ZUWkdUdWlhUHJKOXVRc1VldWI2dEswejdOUGJSdDc1SS9nYTRYKzRCaW84?=
 =?utf-8?B?bWlKTmtETVgrOHRFWDVxeHY0QVBKR0tUSmhsSEhialZWUWRqZzVoQWFSWXQw?=
 =?utf-8?B?SXFTQlBHcGM3YXlhUmdhZ09kWmdTa29pblJvVmNZTUpQZGU4WitwS1k4RmZU?=
 =?utf-8?B?QkxZMzJMaTVVcjRvYnFRZFY5Tm8zdWFPSnVuNmJQZ1NQenZxZnBwNmlBelpi?=
 =?utf-8?B?YW03WUlBTlpIbzBQRmtkbjZXZmVrWndyUEIrSiszVy9kV25NNlFDRjBqTFl1?=
 =?utf-8?B?UWEwRlRmM2VtWFFrZVFRb1pQaGJHaTA4RWFjWUJUYVpNalVhSG0rZDFSSjNH?=
 =?utf-8?B?amc1bk5KQ2VlbkVMSzZTS1g2MTIya2ozSkhiSVd1S3JaUlR1eGp1anRBbEx3?=
 =?utf-8?B?ZVluczFsSVZEQ3RSVWtkRVNITk1qeGhjNWZpZWk1Z3B0R1FXLzRpbzNNb1JE?=
 =?utf-8?B?YWZ4OGZVd0RWZHVBUTBLYUhHMUZQN0hYL1dIRzdWNGxOR1ByOWU3VmhDOXhO?=
 =?utf-8?B?c3FSblMyYmRDWEdtdDlMQm14WkVsNmhGVWhmQnZwNDczbytSSEhwbVp6QUg3?=
 =?utf-8?B?cm5CVFNKTnFTZ0xBQnlSWlQ4MWNsOEhrTW5QZzBzT2haYTBrWGVVTSs4WFFa?=
 =?utf-8?B?STdjZVhFRGh3WVNJTlBiZW9QS1lGMWNMc2twWU1pVmtqZko0cWNyeUFqSWc1?=
 =?utf-8?B?R3BMV1B6TFo5S2RUaFMyS2MvMm4waVNUaWNmc001SHNEalVrbkt1bWtNZC9y?=
 =?utf-8?B?c01uVkl0WEVySHVTY0xZSjdWVElqRWUxME1MZXJrUnZhM1RwdTNnb0t6azFz?=
 =?utf-8?B?MkJNbWQ3bVdCYzRuWUNSb0ZjRmQweWRGcDVSMm9KdmJLcmhKTjloUFdDYXR3?=
 =?utf-8?B?NkV2MlNHZDVZZ1prTTlQVDZkWmkvRnpwL1BWNmtsUzJHL0RkcFV1SWFkT1Jz?=
 =?utf-8?Q?CCG8Xq3H8IxvH1ZIlXJ3lek=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE31E109DB04244DA0E9B6E1A65B5BA8@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f42452-3f8e-4a15-9556-08dc9aa9716f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 15:12:52.2879 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 30B/cXPJJexzC6yaOWH140v6ZBOXo+dVvtsJdCiDzzy7WOKCl4aIzNomhICGq1ncQ9e5qRHgZui9Wn7lJDFu+B7u3NqMLi/eAEbrMkfVTJxr3KHr3pC8kHkTcjuwrLze
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9406
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

DQpPbiAwMi8wNy8yMDI0IDE1OjQ0LCBZaSBMaXUgd3JvdGU6DQo+IENhdXRpb246IEV4dGVybmFs
IGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywNCj4gdW5sZXNz
IHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNv
bnRlbnQNCj4gaXMgc2FmZS4NCj4NCj4NCj4gT24gMjAyNC83LzIgMTM6NTIsIENMRU1FTlQgTUFU
SElFVS0tRFJJRiB3cm90ZToNCj4+IEZyb206IENsZW1lbnQgTWF0aGlldS0tRHJpZiA8Y21kZXR1
QGdtYWlsLmNvbT4NCj4+DQo+PiBUaGlzIHNlcmllcyBiZWxvbmdzIHRvIGEgbGlzdCBvZiBzZXJp
ZXMgdGhhdCBhZGQgU1ZNIHN1cHBvcnQgZm9yIFZULWQuDQo+Pg0KPj4gQXMgYSBzdGFydGluZyBw
b2ludCwgd2UgdXNlIHRoZSBzZXJpZXMgY2FsbGVkICdpbnRlbF9pb21tdTogRW5hYmxlDQo+PiBz
dGFnZS0xIHRyYW5zbGF0aW9uJyAocmZjMikgYnkgWmhlbnpob25nIER1YW4gYW5kIFlpIExpdS4N
Cj4+DQo+PiBIZXJlIHdlIGZvY3VzIG9uIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiBBVFMgc3VwcG9y
dCBpbiB0aGUgSU9NTVUgYW5kDQo+PiBvbiBhIFBDSS1sZXZlbA0KPj4gQVBJIGZvciBBVFMgdG8g
YmUgdXNlZCBieSB2aXJ0dWFsIGRldmljZXMuDQo+Pg0KPj4gVGhpcyB3b3JrIGlzIGJhc2VkIG9u
IHRoZSBWVC1kIHNwZWNpZmljYXRpb24gdmVyc2lvbiA0LjEgKE1hcmNoIDIwMjMpLg0KPj4gSGVy
ZSBpcyBhIGxpbmsgdG8gYSBHaXRIdWIgcmVwb3NpdG9yeSB3aGVyZSB5b3UgY2FuIGZpbmQgdGhl
DQo+PiBmb2xsb3dpbmcgZWxlbWVudHMgOg0KPj4gICAgICAtIFFlbXUgd2l0aCBhbGwgdGhlIHBh
dGNoZXMgZm9yIFNWTQ0KPj4gICAgICAgICAgLSBBVFMNCj4+ICAgICAgICAgIC0gUFJJDQo+PiAg
ICAgICAgICAtIERldmljZSBJT1RMQiBpbnZhbGlkYXRpb25zDQo+PiAgICAgICAgICAtIFJlcXVl
c3RzIHdpdGggYWxyZWFkeSB0cmFuc2xhdGVkIGFkZHJlc3Nlcw0KPj4gICAgICAtIEEgZGVtbyBk
ZXZpY2UNCj4+ICAgICAgLSBBIHNpbXBsZSBkcml2ZXIgZm9yIHRoZSBkZW1vIGRldmljZQ0KPj4g
ICAgICAtIEEgdXNlcnNwYWNlIHByb2dyYW0gKGZvciB0ZXN0aW5nIGFuZCBkZW1vbnN0cmF0aW9u
IHB1cnBvc2VzKQ0KPj4NCj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9CdWxsU2VxdWFuYS9RZW11LWlu
LWd1ZXN0LVNWTS1kZW1vDQo+Pg0KPj4NCj4+IHYyDQo+PiAgICAgIC0gaGFuZGxlIGh1Z2UgcGFn
ZXMgYmV0dGVyIGJ5IGRldGVjdGluZyB0aGUgcGFnZSB0YWJsZSBsZXZlbCBhdA0KPj4gd2hpY2gg
dGhlIHRyYW5zbGF0aW9uIGVycm9ycyBvY2N1cg0KPj4gICAgICAtIENoYW5nZXMgYWZ0ZXIgcmV2
aWV3IGJ5IFpoZW5aaG9uZyBEdWFuIDoNCj4+ICAgICAgIC0gU2V0IHRoZSBhY2Nlc3MgYml0IGFm
dGVyIGNoZWNraW5nIHBlcm1pc3Npb25zDQo+PiAgICAgICAtIGhlbHBlciBmb3IgUEFTSUQgYW5k
IEFUUyA6IG1ha2UgdGhlIGNvbW1pdCBtZXNzYWdlIG1vcmUNCj4+IGFjY3VyYXRlICgncHJlc2Vu
dCcgcmVwbGFjZWQgd2l0aCAnZW5hYmxlZCcpDQo+PiAgICAgICAtIHBjaWVfcGFzaWRfaW5pdDog
YWRkIFBDSV9QQVNJRF9DQVBfV0lEVEhfU0hJRlQgYW5kIHVzZSBpdA0KPj4gaW5zdGVhZCBvZiBQ
Q0lfRVhUX0NBUF9QQVNJRF9TSVpFT0YgZm9yIHNoaWZ0aW5nIHRoZSBwYXNpZCB3aWR0aCB3aGVu
DQo+PiBwcmVwYXJpbmcgdGhlIGNhcGFiaWxpdHkgcmVnaXN0ZXINCj4+ICAgICAgIC0gcGNpOiBk
byBub3QgY2hlY2sgcGNpX2J1c19ieXBhc3NfaW9tbXUgYWZ0ZXIgY2FsbGluZw0KPj4gcGNpX2Rl
dmljZV9nZXRfaW9tbXVfYnVzX2RldmZuDQo+PiAgICAgICAtIGRvIG5vdCBhbHRlciBmb3JtYXR0
aW5nIG9mIElPTU1VVExCRW50cnkgZGVjbGFyYXRpb24NCj4+ICAgICAgIC0gdnRkX2lvdmFfZmxf
Y2hlY2tfY2Fub25pY2FsIDogZGlyZWN0bHkgdXNlIHMtPmF3X2JpdHMgaW5zdGVhZA0KPj4gb2Yg
YXcgZm9yIHRoZSBzYWtlIG9mIGNsYXJpdHkNCj4+DQo+PiB2Mw0KPj4gICAgICAtIHJlYmFzZSBv
biBuZXcgdmVyc2lvbiBvZiBaaGVuemhvbmcncyBmbHRzIGltcGxlbWVudGF0aW9uDQo+PiAgICAg
IC0gZml4IHRoZSBhdGMgbG9va3VwIG9wZXJhdGlvbiAoY2hlY2sgdGhlIG1hc2sgYmVmb3JlIHJl
dHVybmluZw0KPj4gYW4gZW50cnkpDQo+PiAgICAgIC0gYWRkIGEgdW5pdCB0ZXN0IGZvciB0aGUg
QVRDDQo+PiAgICAgIC0gc3RvcmUgYSB1c2VyIHBvaW50ZXIgaW4gdGhlIGlvbW11IG5vdGlmaWVy
cyB0byBzaW1wbGlmeSB0aGUNCj4+IGltcGxlbWVudGF0aW9uIG9mIHN2bSBkZXZpY2VzDQo+PiAg
ICAgIENoYW5nZXMgYWZ0ZXIgcmV2aWV3IGJ5IFpoZW56aG9uZyA6DQo+PiAgICAgICAtIHN0b3Jl
IHRoZSBpbnB1dCBwYXNpZCBpbnN0ZWFkIG9mIHJpZDJwYXNpZCB3aGVuIHJldHVybmluZyBhbg0K
Pj4gZW50cnkgYWZ0ZXIgYSB0cmFuc2xhdGlvbg0KPj4gICAgICAgLSBzcGxpdCB0aGUgQVRDIGlt
cGxlbWVudGF0aW9uIGFuZCBpdHMgdW5pdCB0ZXN0cw0KPj4NCj4+IHY0DQo+PiAgICAgIENoYW5n
ZXMgYWZ0ZXIgaW50ZXJuYWwgcmV2aWV3DQo+PiAgICAgICAtIEZpeCB0aGUgbm93cml0ZSBvcHRp
bWl6YXRpb24sIGFuIEFUUyB0cmFuc2xhdGlvbiB3aXRob3V0IHRoZQ0KPj4gbm93cml0ZSBmbGFn
IHNob3VsZCBub3QgZmFpbCB3aGVuIHRoZSB3cml0ZSBwZXJtaXNzaW9uIGlzIG5vdCBzZXQNCj4+
DQo+PiB2NQ0KPj4gICAgICBDaGFuZ2VzIGFmdGVyIHJldmlldyBieSBQaGlsaXBwZSA6DQo+PiAg
ICAgICAtIGNoYW5nZSB0aGUgdHlwZSBvZiAnbGV2ZWwnIHRvIHVuc2lnbmVkIGluIHZ0ZF9sb29r
dXBfaW90bGINCj4NCj4gSGkgQ01ELA0KPg0KPiBJIHNhdyB0d28gdjUgaW4gbXkgaW5ib3gsIGFy
ZSB0aGV5IHRoZSBzYW1lPyA6KQ0KDQpIaSwNCg0KTm8sIGl0J3MgYSByZXNlbmQgZm9sbG93aW5n
IGEgcmVxdWVzdCBieSBNaWNoYWVsLCBzb3JyeSBmb3IgdGhhdA0KDQo+DQo+PiBDbMOpbWVudCBN
YXRoaWV1LS1EcmlmICgyMik6DQo+PiAgICBpbnRlbF9pb21tdTogZml4IEZSQ0QgY29uc3RydWN0
aW9uIG1hY3JvLg0KPj4gICAgaW50ZWxfaW9tbXU6IG1ha2UgdHlwZXMgbWF0Y2gNCj4+ICAgIGlu
dGVsX2lvbW11OiByZXR1cm4gcGFnZSB3YWxrIGxldmVsIGV2ZW4gd2hlbiB0aGUgdHJhbnNsYXRp
b24gZmFpbHMNCj4+ICAgIGludGVsX2lvbW11OiBkbyBub3QgY29uc2lkZXIgd2FpdF9kZXNjIGFz
IGFuIGludmFsaWQgZGVzY3JpcHRvcg0KPj4gICAgbWVtb3J5OiBhZGQgcGVybWlzc2lvbnMgaW4g
SU9NTVVBY2Nlc3NGbGFncw0KPj4gICAgcGNpZTogYWRkIGhlbHBlciB0byBkZWNsYXJlIFBBU0lE
IGNhcGFiaWxpdHkgZm9yIGEgcGNpZSBkZXZpY2UNCj4+ICAgIHBjaWU6IGhlbHBlciBmdW5jdGlv
bnMgdG8gY2hlY2sgaWYgUEFTSUQgYW5kIEFUUyBhcmUgZW5hYmxlZA0KPj4gICAgaW50ZWxfaW9t
bXU6IGRlY2xhcmUgc3VwcG9ydGVkIFBBU0lEIHNpemUNCj4+ICAgIHBjaTogY2FjaGUgdGhlIGJ1
cyBtYXN0ZXJpbmcgc3RhdHVzIGluIHRoZSBkZXZpY2UNCj4+ICAgIHBjaTogYWRkIElPTU1VIG9w
ZXJhdGlvbnMgdG8gZ2V0IGFkZHJlc3Mgc3BhY2VzIGFuZCBtZW1vcnkgcmVnaW9ucw0KPj4gICAg
ICB3aXRoIFBBU0lEDQo+PiAgICBtZW1vcnk6IHN0b3JlIHVzZXIgZGF0YSBwb2ludGVyIGluIHRo
ZSBJT01NVSBub3RpZmllcnMNCj4+ICAgIHBjaTogYWRkIGEgcGNpLWxldmVsIGluaXRpYWxpemF0
aW9uIGZ1bmN0aW9uIGZvciBpb21tdSBub3RpZmllcnMNCj4+ICAgIGludGVsX2lvbW11OiBpbXBs
ZW1lbnQgdGhlIGdldF9hZGRyZXNzX3NwYWNlX3Bhc2lkIGlvbW11IG9wZXJhdGlvbg0KPj4gICAg
aW50ZWxfaW9tbXU6IGltcGxlbWVudCB0aGUgZ2V0X21lbW9yeV9yZWdpb25fcGFzaWQgaW9tbXUg
b3BlcmF0aW9uDQo+PiAgICBtZW1vcnk6IEFsbG93IHRvIHN0b3JlIHRoZSBQQVNJRCBpbiBJT01N
VVRMQkVudHJ5DQo+PiAgICBpbnRlbF9pb21tdTogZmlsbCB0aGUgUEFTSUQgZmllbGQgd2hlbiBj
cmVhdGluZyBhbiBpbnN0YW5jZSBvZg0KPj4gICAgICBJT01NVVRMQkVudHJ5DQo+PiAgICBhdGM6
IGdlbmVyaWMgQVRDIHRoYXQgY2FuIGJlIHVzZWQgYnkgUENJZSBkZXZpY2VzIHRoYXQgc3VwcG9y
dCBTVk0NCj4+ICAgIGF0YzogYWRkIHVuaXQgdGVzdHMNCj4+ICAgIG1lbW9yeTogYWRkIGFuIEFQ
SSBmb3IgQVRTIHN1cHBvcnQNCj4+ICAgIHBjaTogYWRkIGEgcGNpLWxldmVsIEFQSSBmb3IgQVRT
DQo+PiAgICBpbnRlbF9pb21tdTogc2V0IHRoZSBhZGRyZXNzIG1hc2sgZXZlbiB3aGVuIGEgdHJh
bnNsYXRpb24gZmFpbHMNCj4+ICAgIGludGVsX2lvbW11OiBhZGQgc3VwcG9ydCBmb3IgQVRTDQo+
Pg0KPj4gICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgICAgICAgICAgICB8IDE0NiAr
KysrKy0NCj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oICAgICAgICAgICAgfCAg
IDYgKy0NCj4+ICAgaHcvcGNpL3BjaS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAx
MjcgKysrKystDQo+PiAgIGh3L3BjaS9wY2llLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDQyICsrDQo+PiAgIGluY2x1ZGUvZXhlYy9tZW1vcnkuaCAgICAgICAgICAgICAgICAgICAg
IHwgIDUxICsrLQ0KPj4gICBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCAgICAgICAgICAg
ICB8ICAgMiArLQ0KPj4gICBpbmNsdWRlL2h3L3BjaS9wY2kuaCAgICAgICAgICAgICAgICAgICAg
ICB8IDEwMSArKysrKw0KPj4gICBpbmNsdWRlL2h3L3BjaS9wY2lfZGV2aWNlLmggICAgICAgICAg
ICAgICB8ICAgMSArDQo+PiAgIGluY2x1ZGUvaHcvcGNpL3BjaWUuaCAgICAgICAgICAgICAgICAg
ICAgIHwgICA5ICstDQo+PiAgIGluY2x1ZGUvaHcvcGNpL3BjaWVfcmVncy5oICAgICAgICAgICAg
ICAgIHwgICAzICsNCj4+ICAgaW5jbHVkZS9zdGFuZGFyZC1oZWFkZXJzL2xpbnV4L3BjaV9yZWdz
LmggfCAgIDEgKw0KPj4gICBzeXN0ZW0vbWVtb3J5LmMgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAyMCArDQo+PiAgIHRlc3RzL3VuaXQvbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAg
IHwgICAxICsNCj4+ICAgdGVzdHMvdW5pdC90ZXN0LWF0Yy5jICAgICAgICAgICAgICAgICAgICAg
fCA1MjcgKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICB1dGlsL2F0Yy5jICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8IDIxMSArKysrKysrKysNCj4+ICAgdXRpbC9hdGMuaCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMTcgKysrKysNCj4+ICAgdXRpbC9tZXNvbi5i
dWlsZCAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPj4gICAxNyBmaWxlcyBjaGFu
Z2VkLCAxMzMyIGluc2VydGlvbnMoKyksIDM0IGRlbGV0aW9ucygtKQ0KPj4gICBjcmVhdGUgbW9k
ZSAxMDA2NDQgdGVzdHMvdW5pdC90ZXN0LWF0Yy5jDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB1
dGlsL2F0Yy5jDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB1dGlsL2F0Yy5oDQo+Pg0KPg0KPiAt
LQ0KPiBSZWdhcmRzLA0KPiBZaSBMaXUNCg==

