Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1746ECA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 12:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uohqF-0005f8-7H; Wed, 20 Aug 2025 08:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uohqA-0005eF-6F
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 08:22:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uohq7-0001w3-Ai
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 08:22:53 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KC1JOg000837;
 Wed, 20 Aug 2025 12:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=n++KV7gusmIuc4C9PAjytHG4kLddjE3FXLEYKrNEk4s=; b=
 HjRF842FMIS6dvRl9v61zJy8Ce94H3yweOdBsAD63DLsJLlpjXE/SvOZIb0PKR36
 MqEJuTpL/T9ZTJ57M66KrTFfqcjxDgbgaUMbGLKGFIua+rp+iDduHnJP5Xv7ntPi
 T5tFhK0MYfoaULLVv3cMFi1OVQo0PftICdnyY/KzBfvySdQ6njDHc2LSPTOOTFcn
 iC5RnqIJuJzdPdvO01/nDCDfvuxZjwQTSy9qgXU8f2C0DWZ/jy21sZYTsTykroqb
 4pWUJiVTfh6O5GmC/gsSPsrodx5Y3jvFyIuM/VK7G8HuBcWtuIrlfpO3zOWTaUKf
 xYdXbZeNa25sGi3/OT+rjg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tt14ux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Aug 2025 12:22:43 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57KB9JMg001674; Wed, 20 Aug 2025 12:22:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48my406rgs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Aug 2025 12:22:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQjUgxTYonqfXVOaSC7Zme5iFs8/2c5XyhhKzASJ7gE4Yi53d2PyFAal3M0fCZK4Nfv5cShF8i6XESGUW1ypDFcAZEJDnQKkwgv1rp/AeaRGqrAHBrhRWzHw5a1uRX+kAcxA4wggO130aMqj4uwjLfgJ9ZhPpO8TRXjdhMzGsGk9r9iCTSAXVX44dOBEQ0B7GdT6yoXiBIUbtWIxcGqJbrIXlMIUAF/++mq8O6LRcqxfXxwH1ToZ0yivI87WhIPjjckjL5CFNyNdTErrWzMP3RvP3LkdZYSfwwtN5/dE+bO6B/RZ5u3El6F4BfJgWa0zj+J0fzhnCjdXDkRRxWXMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n++KV7gusmIuc4C9PAjytHG4kLddjE3FXLEYKrNEk4s=;
 b=DDBQ9UAOxO4G8JIcoRwj4m2VGC76LtYMePlPMWajBN02SxSatfgt3QHWJ/aKZMFzk6sn2L2zFva3CEuBSLHkq7sQgJi8i/oh7IHwGGDO+B8wO9Y670/RfDjTnxQCKLLbP6z7KOJ/y4YsvNT8IILp4Fhs8XV+lZojwVpOk6T8MYVkke3t1lYpktx7siMW3EuI3MeGJj0kwoJsXt8ZXDaSslC9+DzvS9oHQz/5pZcbWg9By/5aX7jPexGZ/z1Wj7A5zPl1CFumCjbD2XoczHWFkAS5X8Rl/+NoOg3KuG1hKc0SBO+qWLvI+NSmKZtBzICz7J+r7/7ImpquAIp2hQa+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n++KV7gusmIuc4C9PAjytHG4kLddjE3FXLEYKrNEk4s=;
 b=C2QltK35+jDRFqY6zcCL+5qfRG1504E8TM/xjth+ExmmUdgD9PVKR9lFU6zdw/cJIPP6IZdLRPNq4shqeLuwMcw05ddSHwbn8Guf3hIdz5URBsvVndQ7TWOlS0RNDfvdoe0OJ4RIg42IsmAn672mJJQDbWF+usWatSbjKkaKNeg=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by DM3PPFB0C5EC304.namprd10.prod.outlook.com (2603:10b6:f:fc00::c43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 12:22:38 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6%7]) with mapi id 15.20.8989.018; Wed, 20 Aug 2025
 12:22:38 +0000
Message-ID: <b5a3a9b6-c8ae-490e-8727-27138830ffd2@oracle.com>
Date: Wed, 20 Aug 2025 08:22:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/5] net: move backend cleanup to NIC cleanup
To: Eugenio Perez Martin <eperezma@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Lei Yang <leiyang@redhat.com>
References: <20250310122240.2908-1-jasowang@redhat.com>
 <20250310122240.2908-3-jasowang@redhat.com>
 <29e31b2d06036441ede4ccb2d2bd22a6c1ba33ae.camel@infradead.org>
 <CACGkMEsuE8HC=s2HTWj+p=T8haOxHPhSj6w4==k-pvzKjwrKqw@mail.gmail.com>
 <c9524ced9c39e688372c332f909d84c6853e1983.camel@infradead.org>
 <CAJaqyWe0dawXryB+B8HYuQJ9mcDhCT_3H8vkJMwZyjKnLHQouw@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWe0dawXryB+B8HYuQJ9mcDhCT_3H8vkJMwZyjKnLHQouw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:208:36e::16) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|DM3PPFB0C5EC304:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d71e209-33eb-4a26-4740-08dddfe43fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekpvTFFZTXNIbzk1WGU2bW50WHFwL2cvYmhFSjFCUHBGeGp6YjJGaW81UlpV?=
 =?utf-8?B?OC9zMzByODB2ZC9rM3RBd3duV3Jva2piUkM0Rzk0bXZ2Q2FwOVNWUjR6aERD?=
 =?utf-8?B?S0Rsa0U3dTNhYmJ2M0t1Q0lMNkhKTEhSQ2lGR25CSElDSExrTGwxTW9OSkNO?=
 =?utf-8?B?VjErb0ZkUTE0aW5kcFozZGlTNklkTmxNeXI2bXgveHZ0eTBSbk9hZ29RYmFG?=
 =?utf-8?B?ZVB1eEl1RGhjY3FWL1pMWnpXT1cxYUUxU0dHc1dNRUhPQzZReGJ4cHpSc0d4?=
 =?utf-8?B?ZUxMQk03OG5uRTF1Skl2QVFLRXd0WWR2R0ppN2ZMRHFGSUVJcVY0bVVLMEpx?=
 =?utf-8?B?M3lheGJtcjZBZFBjQ3UwYnhyRlk5eUxUQlVoQ3lBcXc0aHUrdTVaOWpQWFFI?=
 =?utf-8?B?Q0tHQkQ4Q1BDTGlnZ2dFTWpmcStuWGVTVkJTZlJnKzNkZ1hRdlZvK2NNaTMv?=
 =?utf-8?B?dTZxWGhITzNrdGR0aWxMRGp6ZFlkQUY0Nk1tL29nUHVHMVJ6MG5NeTMyZlhO?=
 =?utf-8?B?S3hsQVRybTk0MTZGS2JCTXBPOGt6ZFlGUVZiTEhUOVJwNlRnQWRCWGFmQisr?=
 =?utf-8?B?MDFXUnlGVDl4VUl4ZXRLYVlNVmZXTUZpc0s3bFZKaXozS1BNdTJqQTRoZnZP?=
 =?utf-8?B?eVd2N3RWdVlkdnBQcXE5ZkxkN2MrMkM2NTBWOExTR2g4T2FiT0xQTXhzM3RN?=
 =?utf-8?B?ZFFRTURWMGNvbUFrMUNYRWtCYmQyNWN4ODNvWnVodG5Xbko0MlZiRHF0Y3Uz?=
 =?utf-8?B?K1hOR2RvaXBxU3RqcUhSZkErOUF1WXNSaEVISEl6ZEVvZ1Q1NjV0OUdmMDRy?=
 =?utf-8?B?Z1hzSEI5Y0ZVM2lCckIvc0t6cERXdEswNG9pWWZPWXhsalNBSjlTbzhNaGRa?=
 =?utf-8?B?LzFyY2k3Rm5IZi80M0t2QUlZK1JZMFFYUlU5dEIzZUU4TkRoV25ENDliOWxR?=
 =?utf-8?B?cC9ISEtRamNGL3ljNGlBQStTTm1kckowWHVEWTRZa2ZoNkNXMXkzNmhMTFNu?=
 =?utf-8?B?cFhqVFRDbS9PUUJUNjA3Vm1PL2FpdjFwVXpQUWVIVGNvSml0RFl1ejg0K204?=
 =?utf-8?B?R3hoSkFRQ1lCNGprdEhmSEZGT3hCVVVxeG10Nk9SamJ5NE9pcFIwbE9KMjZ5?=
 =?utf-8?B?TThFa2JYbEI5UUd2eEhicWV6c0NFbjZlZ3pUNS9veis5UForVHp0V0N5VXJq?=
 =?utf-8?B?UndqakhsMjZxR1MvSmJZV3lSa1QrUkl3Q2dTODlJSkViL0YvbnRidjMwU3dW?=
 =?utf-8?B?VmlBNDhxbzNtUUtUMUVKc3RvZ1JqQ1p6ek51b0hid2Fla3c3Zjg5WTRPZFpo?=
 =?utf-8?B?NXI4SktndDgwbjNhUERtVWl4dDFZTnduVTFDdUlESFNmQWM2cmw4NnozTXE0?=
 =?utf-8?B?d3h1OWxLTS9LMURFbHliTFZoVGdIQnZHdkMvUFpiVkpYWXZqdE93UVRrbkJz?=
 =?utf-8?B?YWF1S3Z4ZFFxaktJWHFReE9hNjRzc3RVVmRzSzZtNkJ4eFFxU0RxK01HWUFn?=
 =?utf-8?B?WmNLdVA1VjZWUW05V3dFQ0R1a3lPM0VjY1E2WUdvOVUybjVtUzlIejdKdzZo?=
 =?utf-8?B?aU05K3dPdm9aUGFzSy92ZjlYZlRDVTJ0Vy8xWi9qMXBxcmxmdzFYNkFCblRK?=
 =?utf-8?B?UTJ5cVo5a2tuTjVBdWR4UzkrU0R5ZXEvWVUxbyt6N2szckt0RXI0YW5Pc2ow?=
 =?utf-8?B?THdNV2JNSVo1UFo1cmxoMUtEenNqWkFQc3VPWXhsYU8wN0pobU8vUTlpK3Aw?=
 =?utf-8?B?LzVwYkY4RFhreDdpOXVLYkZCNHppVUxLNXp6L2RzNFhFVWdhYWdWVk40MmNn?=
 =?utf-8?B?UEZkQ0k0NlJJSTdneEdvWHRGZjBZVllrR3k4aHlCUzR2RDZrOVI2cTZDUHMz?=
 =?utf-8?B?bytVcFNjZ2kxOGcyU2RaRTZ3TmZic3hVK0ZxVDBLSW5HSDQ5Z0trSWRuWWJX?=
 =?utf-8?Q?A8p5vCfJZgM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KytMck5OSDA5YUdUZDdmZGMwWk03c2p5ZkVBeWsvRWdYMUpLT01HdFR3bWdF?=
 =?utf-8?B?a2JqeC9jNW9NTklFUlZTeVVNaVViY0lEdDRCcGdyNVJ0K1lLNzlicmR3dk42?=
 =?utf-8?B?RE5iekJKdEViKzZac2ErVzNqQWJkRW82Qml0NkxNUGE5dVdnYmZZeXJEd24r?=
 =?utf-8?B?a09SZnFicWJtcFJtS1hocXJrZWIydEYwSFplOFhjM3J5cERoUmtlNFJySGtM?=
 =?utf-8?B?djQ0VzIxU0RVT0NLY09IUHZ5ZGtCZlFxYjRUbkZka0NUSVMwUXhINGU3WlNQ?=
 =?utf-8?B?dEdNVUlrRVhxbjMzbHFWUUlobmVNR25HMW1GdWJRTW05QUtCTmlFWDd2MEQx?=
 =?utf-8?B?MDk1OG9yTXpxVGNIZXhOY0xveUlHM0M1Ky82blR2NFptYmtjRWM4VlJVT2pJ?=
 =?utf-8?B?aDNwTndkWEJXSnU4U2R1cExXeW1EUWRudm1heGllcXJGbW0wWk5UWGNGdlVx?=
 =?utf-8?B?Z2VndGtmelNoRDQ5d2pmbGpZYjhqV1VRaEZkMXR4Z1kyMFhaWUMvcHNOT2dM?=
 =?utf-8?B?ekVMNlFGYWdHcTdaemo2dCtDZEJVYXV3Zm1jTVJNQWNLQnNmc1hya1RQOG0y?=
 =?utf-8?B?ajgxQkx1NWhCSGRVRjhEQ2Qrb0VtR3dOUi9aRmJNTGRDU2JsYkx3c0RVZklB?=
 =?utf-8?B?a1paam9vQ3VLM0k4TXh1OVFrd21BS2hqMGRmcjQ1Z052Y3phSW1IQlN5TEV3?=
 =?utf-8?B?K3doOGdXRS9PQTNrcnMvbzF4QTVXMnFDT2NRaThFNUFITUVmYzY0bW5zTDJE?=
 =?utf-8?B?a0s5ajA4MTdyeThNVVNRNDBJQXNxMjRNc2xUK2xTUDkrNUJBUC9Cb3R3OHNh?=
 =?utf-8?B?YXhlZ3ZUODltYUp1Ymd6Y1VjUG1ZWEtxWGErWWYvWkQvSnhqWWx0QjJKamlP?=
 =?utf-8?B?Nkp2K29uQTE2eEc1RFRIeVpmV0NhYnorQlRkTThvTXh4RVBPZDBjaGRHOWI0?=
 =?utf-8?B?b01lN3pVclBzbDlVS0lOTXFrMXhwbTk4TStBUm1oeGF6VUcxWkFETXBMbUZn?=
 =?utf-8?B?VEYxRDArbWV4U0k0cjVEaG05SUZ5TmIzUk5FUVVNY3YyVzFpd0MxMWpjVnZI?=
 =?utf-8?B?VFUxQ08vTmlwNFI2VyszR0xBME5OMHpPcHRiaXh6dUxKRTk3cHpMOThXdXB1?=
 =?utf-8?B?UW16TVpYd080U3lzM1pKdTB5OG0rbjlkOHJUVy85ZnhMcnQ1Skg2T3VGNnhT?=
 =?utf-8?B?aTJaQlE3RElYUnZ4Q0t5dzFFNW1YRFYyQTFkakwvK0ZKMHd4eFJ6eHVIZlRw?=
 =?utf-8?B?d2pHS0p1dVRvUnpTbEdINHBiZmJKbmp6NnFESU0wVmxDb2xZRGV4NlZPUXox?=
 =?utf-8?B?Q05OMUNyek8rOFVqbEczYXUzYWFmY3NCaU9lWXBTN2NaTkdHTUpqT0NGck5s?=
 =?utf-8?B?enNpRktqOGlIVHdSVEdUa0c1QmkxTXN5dTJSaEJLR1JsTVY3N3Q5eUJtYUNK?=
 =?utf-8?B?Zjlqd1BtZ1VoRVF2MjFxeWJHQlFnaTh2R3NZd3J5YmZ5N0lxNXl5UUJxbEVs?=
 =?utf-8?B?OTg4WHkzS0tyMldNWHYrMkxLRHVGbzN1VjhuTVRiWEx5MjloUjA3Z0RIcVp5?=
 =?utf-8?B?MFI0T2QzZ3M5K0QydnFHWU1tbnlNT0FTK1VPMEp2TVo1RkJoRGd5UURPOVlS?=
 =?utf-8?B?YTJEYWdkZnBTRTc5MzM0SHhDREVxUVUvOWdWQWw2MU5IMlZZVExNS0hxSzBP?=
 =?utf-8?B?RXRYcmxaN3VvQmRzbnBZYm1VNHJHZ1VNYy9xdDhGRDRzS2t6NXI3WWZOZVhB?=
 =?utf-8?B?OGhBK2tHVldUSFRtbnhiUloySkpOOVZxOC9oYnRxZ2NWRDVrUW1hMVJpVURE?=
 =?utf-8?B?M0hTSmw0bkdXSmw0M2twQSs0UEdob0JGcWlXMWhGbC9mUnJ5YkhrU3FWN1py?=
 =?utf-8?B?SUtqWDJQb2pnVXViZ2pyRGlBeTUrTTJkRGw5RDczMWtuejd2cTZJRU9MU3V3?=
 =?utf-8?B?bDliMzJDckJUV0FDN2FWbThSTU9mWnIwVGdSTDhGSHpmZHRJWGo4YVZlazlU?=
 =?utf-8?B?dnlHMDlWc0Z2d09aekY2ZHZSellJb2RKOXBkc3REZmdodHhIMWRDM2prU0w5?=
 =?utf-8?B?R05DdG1hWjJrenJRMHh3dE1HRkhqemJGd3crNzVPVGdsSjExOHlmN3RlZFl1?=
 =?utf-8?B?Q1lxYTc1bGtjcVVIbnBVTnVtRXlkQ08xcnJqZU8xQmF1dDRIM1JtYkkwdkdU?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: b26PHb9/urHgBEe7BpjBdxhaozP76vOHb6CnDe8O/78g2NUomFyZiXRjiBfMcmyAi+pffXRS6apk0woGTzkSlXCfqGSFPSwHhauX68Cbny5t2S9sKeMyX2Ze2lswthCYTjqym/eduH9rFTuI5MFEkBWIZQX8Tm9s5UBKnkCFsGgK6TJREnsAfc90iVt15S45gFGCRjla29qH2IfjR3sRyMpk77WrT3WwhQM+0xe5soCVe9wdebIIbvgCZAO5F2q7te5Z2kIu1dXPqePCrV15oc89aU6hvbwFegqpacZZiPeuogW488lBjb0VZVlMONrp3QYNtgdfz0PUnCbb8FYD1PMWk/LIoH8Wc4FWDSDG4cW+FLySiAxNLRfO6bC5tc2o1+K1cDkbyum/o3bWXofJzCpV8D6yioAU/IUsmYqEqYt3N8S1Bg+lt59svRy/8h49neokCanRYpM6KYZ9hrubT9id4Wq+3/44jWFsqeYNdwjKn5BH1H1tV7YS85u2yuJhPpCvaJmrFMHal2Qh4zW6ac6j9XOVjipzNrlJfTTsgqRbYySQc81t77GwFzUqAhuJJwlPUFGeXlufp5RwlnppH9UOgcrppkl7GXwuttoWsg0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d71e209-33eb-4a26-4740-08dddfe43fa4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:22:37.9236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+LcXxDT4mj8Wj8098k0pOiIesulRPCj3fSuiFkpQEXn3oZ1Qv1Zp/0ksyl+Ty9c0ZcVQbacUBe20jpoorMSGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFB0C5EC304
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508200108
X-Authority-Analysis: v=2.4 cv=YvRWh4YX c=1 sm=1 tr=0 ts=68a5be13 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=xqkbMLqQyqFJyl-dBkQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12069
X-Proofpoint-GUID: 9MoeESwAaHG5app-ItqgGgcZIy-nFCmG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NiBTYWx0ZWRfX+sQb6vKRBYpq
 UR+mfR8VQLJ1+NvbI6a5XF7sDF7bJOrwITH33BsIX8Igq4FzGKiwkLCSrvip1cu4IvuOkZzmFDl
 t66zvx2pJakk7VEJPu/ljDh1h7yc8pH9mfQcQ8V45xVNE3FQHxr4tlsa8sNuUIVTb/xAQL3mvY0
 MxDWYq5r2GJEpXLVuaJkVvCzBMRSVVSmq0PwOTRoXRcIE6lpYaC/LT1YViMaAel8GsNhcYM1bfT
 FZysSPfRDUlXiKT9W0h8BSaTjyCBFkfh3vGTnK8SIVLgoU/oHKR4W4C7HEpyTEvhHzPvcR5gMwO
 c+XRc8oATWOi+oJ35IqLE8N7LXUNZTksVxgdsyeVwvB5APWIQKBNwY03smySmp3hWz0X0qaa7gK
 T2GUuHka/BrfTaKDGwx1FhuWekcO+sjwQbsCcbE5vDtWiqoUTN8=
X-Proofpoint-ORIG-GUID: 9MoeESwAaHG5app-ItqgGgcZIy-nFCmG
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 8/20/25 3:14 AM, Eugenio Perez Martin wrote:
> On Wed, Aug 20, 2025 at 8:47 AM David Woodhouse <dwmw2@infradead.org> wrote:
>>
>> On Wed, 2025-08-20 at 10:34 +0800, Jason Wang wrote:
>>> On Wed, Aug 20, 2025 at 12:13 AM David Woodhouse <dwmw2@infradead.org> wrote:
>>>>
>>>> On Mon, 2025-03-10 at 20:22 +0800, Jason Wang wrote:
>>>>> From: Eugenio Pérez <eperezma@redhat.com>
>>>>>
>>>>> Commit a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net
>>>>> structures if peer nic is present") effectively delayed the backend
>>>>> cleanup, allowing the frontend or the guest to access it resources as
>>>>> long as the frontend is still visible to the guest.
>>>>>
>>>>> However it does not clean up the resources until the qemu process is
>>>>> over.  This causes an effective leak if the device is deleted with
>>>>> device_del, as there is no way to close the vdpa device.  This makes
>>>>> impossible to re-add that device to this or other QEMU instances until
>>>>> the first instance of QEMU is finished.
>>>>>
>>>>> Move the cleanup from qemu_cleanup to the NIC deletion and to
>>>>> net_cleanup.
>>>>>
>>>>> Fixes: a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net structures if peer nic is present")
>>>>> Reported-by: Lei Yang <leiyang@redhat.com>
>>>>> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>>>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>>
>>>> This crashes QEMU when I launch an emulated Xen guest with a Xen PV
>>>> NIC, and quit (using Ctrl-A x on the monitor).
>>>
>>> Eugenio and Jonah, any thoughts on this? It looks like the code
>>> doesn't deal with hub correctly.
>>
>> The interesting part about Xen netback is that it does its own teardown
>> from xen_device_unrealize() because in the case of running under true
>> Xen, it needs to clean up XenStore nodes which are externally visible.
>> It doesn't all just go away when QEMU exits.
>>
>> We fixed a potentially similar issue in commit 84f85eb95f14a ("net: do
>> not delete nics in net_cleanup()")?
>>
> 
> I was not aware of that code to be honest :(.
> 
> Jonah, could you take a look at this? It should be a matter of
> replicating what the series does in the list on NICs, in this linked
> list.
> 
> Thanks!
> 

Sure, I'll see what I can do here.


