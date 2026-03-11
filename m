Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FC1112584E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0M1y-00012T-Gl; Wed, 11 Mar 2026 12:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1w0M0X-0000Mn-G4; Wed, 11 Mar 2026 12:02:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1w0M0U-0003XC-TG; Wed, 11 Mar 2026 12:02:01 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62BDMmnY1915974; Wed, 11 Mar 2026 16:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Jb8eG9W6yAlRUBz/uy20j7Uv3atQc0EZRg558yDIO40=; b=
 megQdVih3QWVu9fUUq1EWeR0kutgYUhgNNxZA1Vo+e1Rk5sCLXfdgW+6sdZKIx4/
 +sI5vdRvQsD3VhHkosGCGXqBNFuTvPKIQ9po4Q5OqMx0i4F8GmJBk0JFdFBGtNGt
 f+tv0Q1w9Z4ev+F5YRuxRD8Qt50luipTYBpMErOspC7B2KGgYp23vRAG6z+XvknN
 TExrjbWBl4S5+3g4hrNUngL5mmRKz1LbS34aoUOoVrA3Ld16x1gd4GX+NqEamAA5
 sX3mWT2rP6dEl1JVGYTQjYI1QqbcoYTyAj0+9E4QAk2qjxDZQQsoxmEsGI2YAYBR
 XD1nB0rQ1mrNm45LaTWH7A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cu4strrqk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2026 16:01:51 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62BF8Eqa039581; Wed, 11 Mar 2026 16:01:50 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011057.outbound.protection.outlook.com [40.107.208.57])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4crafbstv5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2026 16:01:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U48Tc7605hYHhTdqzA+ple05seQQVFmhFlZzzEs/Xao4Y4LTEQZQ57A27wb5SJwH0THeZFkzOh0PwwmLMsP1LQTU2VKRnrnpmxzkRYR0S7dvCipc7wf/aaYG1OWPlMP53AHlcPwi0kkaE+DTVSiYwsPPQrhmfOtQQ3CIxuc90M9WDytoMwCtEszEVj5V19g4mfX7ADysxsEH9uU8ZkzuDoxfIQSP3gM2S8Yj3Yztt9D3KmJk/7qGPLtsYQks77ZVauXfvTcwWZTc1po/G14kDhTrNQCsEICFVU17fjeumkUghm0cJy7hfEQteF9D8K+8eA+JMBhNIYOmal9nGJbk5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jb8eG9W6yAlRUBz/uy20j7Uv3atQc0EZRg558yDIO40=;
 b=JdqMPVQQuB/Bfvgo8oDbXVtxNPDzcfD31fgQ8sgpI+tKSJb6BqfaFZ8LadHoMrd7pOybas9nxdq/9Dj28zzTBeUFb6wWLkhxUHDqbJp8f9eM1HeqIn4D4xLdBfNmcLkVlLH9OTnCte8BP4vAqp8dEtH9SS72Cx6TtZlvOIgq79MyDMmHgT+uAIfDczk8WJRpR3hiWGvvdFvUUQIObkkXK7czrIbgGqHo/MZJjN2TAN0O/ASpVeBCBts+9aqoL0eQ0RPHW62fmxi1W9qiazEocHq5HgkCypr+aOWA3JMDzu5XlZjZSL39hTie7RcP7B7JVX+veFIcoB8uY3zqRUxyaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jb8eG9W6yAlRUBz/uy20j7Uv3atQc0EZRg558yDIO40=;
 b=vGERvj/dzFsN/LMrns2FTPlp32TMJIuUFRCTXrkQBjA1vZyod1iIJM5df5vhQbmAt2vZIrvT/aRIItHJnSueP+b/6nZxbDJdUep5ZfsxDaTHUvVZWPN9jq9bD1oNvBkt7+wWlrfTtMfY3MzQsJNsXFGDe1z43wDytg7vbh1xP/4=
Received: from IA4PR10MB8301.namprd10.prod.outlook.com (2603:10b6:208:55e::6)
 by LV3PR10MB7961.namprd10.prod.outlook.com (2603:10b6:408:21d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 16:01:42 +0000
Received: from IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0]) by IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 16:01:41 +0000
From: Jag Raman <jag.raman@oracle.com>
To: Trieu Huynh <vikingtc4@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Maciej Szmigiero
 <maciej.szmigiero@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Thomas Huth <thuth@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Jason Herne
 <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefano
 Garzarella <sgarzare@redhat.com>, "qemu-s390x@nongnu.org"
 <qemu-s390x@nongnu.org>
Subject: Re: [PATCH 3/4] util/event_notifier: fix error handling for
 event_notifier_init callers
Thread-Topic: [PATCH 3/4] util/event_notifier: fix error handling for
 event_notifier_init callers
Thread-Index: AQHcsLw1M+XbAilAIkGf9q6kilLxS7Wpfy6A
Date: Wed, 11 Mar 2026 16:01:41 +0000
Message-ID: <E1A0FC83-8A41-4ACF-A786-CDBCBF314F68@oracle.com>
References: <20260310182801.196443-1-viking4@gmail.com>
 <20260310182801.196443-4-viking4@gmail.com>
In-Reply-To: <20260310182801.196443-4-viking4@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR10MB8301:EE_|LV3PR10MB7961:EE_
x-ms-office365-filtering-correlation-id: 41e56cef-0cee-496c-c70a-08de7f877c70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: Px5qZb9A+XQ1MoYY4yAxxFJ+QGswk5AlBk25/Ye39lsh269WLqRjylsCVSLsxIK6UKqzEI8ki2pnDaMxXe/1el1kKmH3E7iCbfPZrXe3fp4YBy6m4GLzF6G1MS43nZXugvrxxk9ghAuK/BLXXQa6BeYVZvS34JrBEXJGUAii9QlTE2dUL0/eqUa5mFT6JUIDVq/ooXOij1p72fPN2w55JL02I47IdbfVVvdlt/p8yRPdDoJqDMfsaRyoYp/Wep41GEjQmB9d/zFccxTCWW6L+nss+5DjzWgK8M3Y4UxDpxUXsebqNNg/J7pQi/8Nb0uFo8elmNFOUFp+4eMfTKE9kTYCje9jTfNEac8t9rUF+cmpgEvk2k0vB1SUCWvttU9+WQLtuVXjZxnDbvJ8HMyMsr+FeTlYavEzFq9j3ucgS8W6WMDB8DSUI4v7iygq5nmo2huB6cJLbSsJgnYjTIg89It2ebigiBfP0uCa0zBYT5ReRui5DprMj+0Wf0bBhsqmzEIByp8oUZCITOWwP2GcHi3CipJEsZ3RrwpktWHbc8Wivqbt0fYLXOQqXngWdGb3TIfDMY8PdcMAKjj7JXGOv2Xg1Xffc+3zw4YGtkZiSGjWk6bunH5iSNKTuTtZldWEenW8rCyIPAAM9/izN6FHgm9+7wOMAg1bmUtITZYMD/9ZHSkwh/heWULodOyUgK6T+CE/0y8Ta22qEH0QmmaRYVR5gxPXQCGo35Uztf9KqEbf9wqsfuBtsFSbDlE9wRKv38muggteV/MPNBzz6AAxm9olaDu89mhyK+/ipvB7lTM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR10MB8301.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGJPb2VNMTFkT0xHOU1yR1U0MGZwSXZoNmt2b0dhcU5LS3E2UHRLWWtKbmlv?=
 =?utf-8?B?UDk0ZVQxOHBsWUFqbzY2S1ZZRUd0bVU4U1Q5TFdrdlJ5bzl6QlU4WUE1ZlNX?=
 =?utf-8?B?VGpMOC9sMXpRZmdmMDlaRFFzeks0WlhPb3BhMS9QcEpBZmxBNUhIcWhPNG1X?=
 =?utf-8?B?dmdlQ2lLVFdtNG1RRU1LSjFibjZxWCtZUVJUY0wzNmFaVmJvOGN2dmZuc0F1?=
 =?utf-8?B?aHRqZkhOdjBLSndWM3hTaHhld3dvY1h5WWkrcWI2dkF5M2lJZlN4S0FZR3VN?=
 =?utf-8?B?ZEh4ekdzSkN6UkJwTGY3dS9md3pOQ3psdWhQRTVDcUxmTzI0MGpRUFFLNGx4?=
 =?utf-8?B?dFpmOHhOVlp6V1h2Qlc2aWR5aTVuQ0Jjc2puMXJpSzJ0Z0tCZUl5TWpKS3ph?=
 =?utf-8?B?T2E4ZXo3Nk5GbDJRZUd0dWpONVNHY2R3dTVzUHV6WDRpc2ZWbzBYanJia052?=
 =?utf-8?B?Vk83NnQvY2NQZ3Ntdlpkd0VKVk9HdVh3d0VUaXJWV09zOUc1TExURXo4YytF?=
 =?utf-8?B?SXlsK3ZjOGp6MERPT1ltdXhEQUNLU2F1V24rS291N0JkZkZIb0d5SXh3cGRN?=
 =?utf-8?B?eFpvNkovSGFlQW10Zk9sSFNMdEI1eEdUTXpybHVCbm9hUTc1Y1ptSTViQU5V?=
 =?utf-8?B?VnhFZmFwcUEzUXo1cllXWVA4cG5aemN4NnZBQzQ4aEZiT0ZISGwydlVGYXNX?=
 =?utf-8?B?anFvTDZFWTIyREE5WDl6cVJXYjJUQVJtOVpNU0QwWTFWdkhIQ281cno0MUJy?=
 =?utf-8?B?VG1ETTNKbW5kWG9VSmQwVjhnZk5Ud1I0RHI4MEszcGdNTWlMV1NOb2s0VlBF?=
 =?utf-8?B?dEJXSmJ6TW0xV0EwNDA4VTIvWmtBL1I2SkJ2ZExzYVNBZkVMYTN0eU1RTFp2?=
 =?utf-8?B?VXR3a1dBYlpnMUQ0bks3WjNNdnVDa0kwTi92MEthTjVjRHpodlp6Z3BSZkNq?=
 =?utf-8?B?akhwYnU5ZVRIMVl0TFRhNEZJSFc4TFNkU3VRMytwMExrWlZCRjlLUDJlNmZa?=
 =?utf-8?B?MCsyUkMwRWpvdE84TWYxVzFoSzB4V1V5a0NleHlEZHZsUG1EV1kya2c4bk95?=
 =?utf-8?B?aGNITVZxdXIyeVc3ZWd3YndCeDI5dzRWZW5sNlJDM1gvMm1acmd5bCtkSzdC?=
 =?utf-8?B?UUdrZlQrSldTcVVIanJBQVdhWDR5REwya1lEWGhLalpaTWVDSFFmekRLamJC?=
 =?utf-8?B?WnJ5UXRVc3JCWldNb1Brd005cTQ0SWJSWE1wR3hJVXhVOEFUMmNsRGFJVEZs?=
 =?utf-8?B?NU9DN1ZtVmF1Z1NxYUovM1ZWUlQzSEM1dW4weFlaYkUybTBvSFZtSlgva24y?=
 =?utf-8?B?Rkp3YlJnT0MwVEY4aC9jdytia3JtZTJ4eERUcmlsZktxdnJaNFlQaGZOWUtC?=
 =?utf-8?B?ejNMNmx2empIc1FtYWpFQ0RFNFo5eWF4bFVXblQ4a2F3ZXloVFp0NytXSDkx?=
 =?utf-8?B?eG1VbVU1VGJZVlgyTGFsVlFmU2J5cXhRNnhzSkZueVIrQ2NWUXQ0T3JnbXZJ?=
 =?utf-8?B?dTZrUkUwd21SeTRrNkJobzZZdHFQZTYwK1VCWUR5bUNHaFZ4RExXQUV6a1FP?=
 =?utf-8?B?K3FFVmVsWmt3RTNHcU04dXBSaWJHTHdocGovTlNqTVBkaGVCSnBINSthZnln?=
 =?utf-8?B?Mk1OVloxL1lvN1E3a3FYNTA4T2U1ZXZ4VzQ2bmx5V010eU5IeFg2TVFIZ3Rs?=
 =?utf-8?B?MHFnM0c0UmdFYkZQTlF5Nks4cENtc2M4eHhtSzhqbml5NnIvU3B3eUpkcStu?=
 =?utf-8?B?RDdtWDgwUGxmcUo5aWEyWCtnT1FvcnNsQmdWYzRGYWU0UlpBUGZKUGk0ajNU?=
 =?utf-8?B?N1dZZGVJQVJib1BpYUR2clN0NmpYbXpOTGJPY28xRjNaem95c2lySEtJSTVQ?=
 =?utf-8?B?QXIrWWMzYjJobDJ5Z3JiRUIvYi9CVzJmOFlHOElIUWFhZnBXdVRFRC9EbEtJ?=
 =?utf-8?B?b2tmZkVKcDE2ZHNPYUJ6VGxUZEtxM0NiYWR4TnJhcjA3alUyVlpic25SbnU5?=
 =?utf-8?B?RmZ6bnFHenBYeTNxRHk2L2tiVlpJN3FjRUhSbEpWR09vWTRzNHhUdCs5dHEx?=
 =?utf-8?B?a2Q2UTErV1IrSTljeFJjQ0RpVjF3b3JpMkpDeVNkZ1d1WFdhVkNQTmprSmky?=
 =?utf-8?B?eE9OTFpqbzlyeVgxd1MxRVB3TFdrQWJiRTA0c01RclZ3QzlxYklFNXRnTVVy?=
 =?utf-8?B?SUFwQUVJRXh4NTZGcndjT2w5bFNDeGpoa21KdEZOTU9zSTAyQ2FlZGhpS2Fr?=
 =?utf-8?B?YUp4UjkyVXdZbWthUnFoYzVjemNrbE56bkc4RlpaZ3g4bzRTVTFaRTdCMG1X?=
 =?utf-8?B?dVZUallwUG5wclBjd3lCVzR4cWdLWnQ5UVdnMmJOdGJkZjBEUDMrUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1923F2750CE6BF4994945635D38CA308@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YhgNS5sCpDOVhMabv54/CbQvPHoG6/ZVjilme/Rzeg5n9iFaqEugEtB6K6hFCcz5UopL7nLEZ/6usrB71Q6Vkr9ln2ascORXs9pHo1Gru0OuNhvbpgbqzxDWfjvxHledFJXLHY/GswS9mFfA+NF28gCI518clQnLtrwWuXdnYmsNPh9yEh2zBWikpy22Q+JAfqC8ygVByqSVEmy8kCo5M8WCDPVDNNIKgbpe6yJfU2oAdvyrzrq7ulyFbxCDVCftlASKVdAie4pexYeSby/+7HbXQPmgHXQXB2suFVlA4GBzAO48b66+W75utsCPbAg3+ygvjq7YuM36lZuGEFefqw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: n10TXbbjbO7jSbSovMEYA9otfnCy7YERH2FWExIGpPbkeMceoSQsY6zEXRxZYEv9ndbb+J7uUxS8Y9ceUz+uLNohepd/vmPNB12uXskkOvvjBos0Y+bMlwTIH+KjKN5N0gK3Z1+DbwZxL9aBHiy3p8t3A1dJPbng36BFlFRHBXTmhZQ45xSRPUfJHtD/CSXUvq3OuNem1pe74Tg2CLuiT1Kn04XUO5r+OsUjkcNDbhyop76+6uUtzFh1XtDxkxr7I+VdiRqoXmNcsC9v5T3rtuTrQyU6fANDCVxA62GTAIYDbkLe1vXvqQ89SqtEyiSIaxeyH275nZu3xlq9aJF/yr3roNpjyW0yHTpOvueQ82IpnIhhxTDWQ3bdryODl01G/VzK5Yvyi8dxuCb6XN7lIgOC1w6FOYzbcIF4VgnsnaW7lJb6fGYCX5b2Q3YoWoIc7FyJ6KaDFjoSChAW9gqfFcWsdo4hR25T5hZhjn1KAdQb78vnH9uhYCocXgOgTIclFh9a76DRlfLGuweeeKi2neD0npKTIXLtKiJjzxOcB2RBYe4bVk9AntSCAATHYQPRGGFhqUIj3psN/WcqGGPQUAb4cTk1MJXVOCtEy8gswKI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8301.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e56cef-0cee-496c-c70a-08de7f877c70
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 16:01:41.7554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nTy71Jr55yaKF6sZjLE4TvmONxTXFVDo2yCrKhJJwoWk3mdPqT+q+DUfEP5h4ivOIum+QQHZbwcJLtlfbKwzyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7961
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603110135
X-Authority-Analysis: v=2.4 cv=Fv8IPmrq c=1 sm=1 tr=0 ts=69b191ef cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=KWPmIMzmm8yx06jGBKgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 830vCX1ohdpEJF64VUL5BDudeBEDcC8T
X-Proofpoint-ORIG-GUID: 830vCX1ohdpEJF64VUL5BDudeBEDcC8T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEzNiBTYWx0ZWRfX20i/qBE7EmYQ
 Xom4oGijWXhN2Tts1GIevjPTrzS2wk4XecfC7UAryYSMQIVIXVZte18EQFgEQUaRXTIIdBBjuoc
 +wzw2r3VJWh7v4SDk2bekbPLsqb7WbtpkMTaDEDR+/EM+38zHsyx+2nHF6GPlwccUXOYBirq8uM
 M8HBQXFvG5x4IbQWBqmqnc6TRKN/UbWAvaSFOajAPTQAG2QRk5RRbLhspifXe3YJPu6H/nH7uqw
 jqv183M7ihGQSlPW7ApTdUVxCDLHYdc41C1KV9Gv5ip+4kzVtE2OaywjXKpJkIp403GHMCNc879
 djjupnijmbpAvALD6ZNnydAWpMlYsTSlCbKrQDhGlnSxTCSJqNVAKkxi5FjLo6YfBlEbrhqlm6W
 VqM2QAmPjtj1LJXsdPd7/klXMLF0zGAEAZkx+Aa7HpHBFu7ur/Q0iY49zAKCxxmHS1tQZDm03r4
 9Ft5renkoR3DViDSUdQ==
Received-SPF: pass client-ip=205.220.165.32; envelope-from=jag.raman@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

DQoNCj4gT24gTWFyIDEwLCAyMDI2LCBhdCAyOjI34oCvUE0sIFRyaWV1IEh1eW5oIDx2aWtpbmd0
YzRAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IEZyb206IFRyaWV1IEh1eW5oIDx2aWtpbmd0YzRA
Z21haWwuY29tPg0KPiANCj4gQ2hlY2sgcmV0dXJuIHZhbHVlIG9mIGV2ZW50X25vdGlmaWVyX2lu
aXQoKSBhbmQgcmV0dXJuIGVhcmx5IG9uDQo+IGZhaWx1cmUgaW5zdGVhZCBvZiBjb250aW51aW5n
IHdpdGggaW52YWxpZCBzdGF0ZS4NCj4gLSBVc2UgcmV0IDwgMCB0byBoYW5kbGUgbmVnYXRpdmUg
cmV0dXJuIHZhbHVlLg0KPiAtIE5vIGZ1bmN0aW9uYWwgY2hhbmdlcy4NCj4gDQo+IFJlc29sdmVz
OiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS9pc3N1ZXMvNDEzDQo+IFNp
Z25lZC1vZmYtYnk6IFRyaWV1IEh1eW5oIDx2aWtpbmd0YzRAZ21haWwuY29tPg0KDQpMR1RNDQoN
ClJldmlld2VkLWJ5OiBKYWdhbm5hdGhhbiBSYW1hbiA8amFnLnJhbWFuQG9yYWNsZS5jb20+DQoN
ClBsZWFzZSBzZWUgbm90ZSBiZWxvdy4NCg0KPiAtLS0NCj4gaHcvaHlwZXJ2L2h5cGVydi5jICAg
ICB8ICA0ICsrLS0NCj4gaHcvaHlwZXJ2L3ZtYnVzLmMgICAgICB8ICA0ICsrLS0NCj4gaHcvcmVt
b3RlL3Byb3h5LmMgICAgICB8IDE1ICsrKysrKysrKysrKystLQ0KPiBody92ZmlvL2FwLmMgICAg
ICAgICAgIHwgIDIgKy0NCj4gaHcvdmZpby9jY3cuYyAgICAgICAgICB8ICAyICstDQo+IGh3L3Zm
aW8vcGNpLXF1aXJrcy5jICAgfCAgMiArLQ0KPiBody92ZmlvL3BjaS5jICAgICAgICAgIHwgIDIg
Ky0NCj4gaHcvdmlydGlvL3Zob3N0LXZkcGEuYyB8ICA0ICsrLS0NCj4gOCBmaWxlcyBjaGFuZ2Vk
LCAyMyBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9o
dy9oeXBlcnYvaHlwZXJ2LmMgYi9ody9oeXBlcnYvaHlwZXJ2LmMNCj4gaW5kZXggMjdlMzIzYTgx
OS4uYWEyNzhiMTc5ZSAxMDA2NDQNCj4gLS0tIGEvaHcvaHlwZXJ2L2h5cGVydi5jDQo+ICsrKyBi
L2h3L2h5cGVydi9oeXBlcnYuYw0KPiBAQCAtNDM5LDcgKzQzOSw3IEBAIEh2U2ludFJvdXRlICpo
eXBlcnZfc2ludF9yb3V0ZV9uZXcodWludDMyX3QgdnBfaW5kZXgsIHVpbnQzMl90IHNpbnQsDQo+
ICAgICAgICAgc2ludF9yb3V0ZS0+c3RhZ2VkX21zZy0+Y2JfZGF0YSA9IGNiX2RhdGE7DQo+IA0K
PiAgICAgICAgIHIgPSBldmVudF9ub3RpZmllcl9pbml0KGFja19ub3RpZmllciwgZmFsc2UpOw0K
PiAtICAgICAgICBpZiAocikgew0KPiArICAgICAgICBpZiAociA8IDApIHsNCj4gICAgICAgICAg
ICAgZ290byBjbGVhbnVwX2Vycl9zaW50Ow0KPiAgICAgICAgIH0NCj4gICAgICAgICBldmVudF9u
b3RpZmllcl9zZXRfaGFuZGxlcihhY2tfbm90aWZpZXIsIHNpbnRfYWNrX2hhbmRsZXIpOw0KPiBA
QCAtNDUzLDcgKzQ1Myw3IEBAIEh2U2ludFJvdXRlICpoeXBlcnZfc2ludF9yb3V0ZV9uZXcodWlu
dDMyX3QgdnBfaW5kZXgsIHVpbnQzMl90IHNpbnQsDQo+IA0KPiAgICAgLyogV2UgbmVlZCB0byBz
ZXR1cCBhIEdTSSBmb3IgdGhpcyBTaW50Um91dGUgKi8NCj4gICAgIHIgPSBldmVudF9ub3RpZmll
cl9pbml0KCZzaW50X3JvdXRlLT5zaW50X3NldF9ub3RpZmllciwgZmFsc2UpOw0KPiAtICAgIGlm
IChyKSB7DQo+ICsgICAgaWYgKHIgPCAwKSB7DQo+ICAgICAgICAgZ290byBjbGVhbnVwX2Vycl9z
aW50Ow0KPiAgICAgfQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L2h5cGVydi92bWJ1cy5jIGIvaHcv
aHlwZXJ2L3ZtYnVzLmMNCj4gaW5kZXggYzViYWI1ZDI0NS4uMmYwZDJhMDNkOCAxMDA2NDQNCj4g
LS0tIGEvaHcvaHlwZXJ2L3ZtYnVzLmMNCj4gKysrIGIvaHcvaHlwZXJ2L3ZtYnVzLmMNCj4gQEAg
LTE0MjUsNyArMTQyNSw3IEBAIHN0YXRpYyB2b2lkIG9wZW5fY2hhbm5lbChWTUJ1c0NoYW5uZWwg
KmNoYW4pDQo+ICAgICAgICAgZ290byBwdXRfZ3BhZGw7DQo+ICAgICB9DQo+IA0KPiAtICAgIGlm
IChldmVudF9ub3RpZmllcl9pbml0KCZjaGFuLT5ub3RpZmllciwgMCkpIHsNCj4gKyAgICBpZiAo
ZXZlbnRfbm90aWZpZXJfaW5pdCgmY2hhbi0+bm90aWZpZXIsIDApIDwgMCkgew0KPiAgICAgICAg
IGdvdG8gcHV0X2dwYWRsOw0KPiAgICAgfQ0KPiANCj4gQEAgLTI0MTYsNyArMjQxNiw3IEBAIHN0
YXRpYyB2b2lkIHZtYnVzX3JlYWxpemUoQnVzU3RhdGUgKmJ1cywgRXJyb3IgKiplcnJwKQ0KPiAg
ICAgfQ0KPiANCj4gICAgIHJldCA9IGV2ZW50X25vdGlmaWVyX2luaXQoJnZtYnVzLT5ub3RpZmll
ciwgMCk7DQo+IC0gICAgaWYgKHJldCAhPSAwKSB7DQo+ICsgICAgaWYgKHJldCA8IDApIHsNCj4g
ICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJldmVudCBub3RpZmllciBmYWlsZWQgdG8gaW5pdCB3
aXRoICVkIiwgcmV0KTsNCj4gICAgICAgICBnb3RvIHJlbW92ZV9tc2dfaGFuZGxlcjsNCj4gICAg
IH0NCj4gZGlmZiAtLWdpdCBhL2h3L3JlbW90ZS9wcm94eS5jIGIvaHcvcmVtb3RlL3Byb3h5LmMN
Cj4gaW5kZXggNTA4MWQ2N2U3Zi4uZTkxNTY2NTA5ZiAxMDA2NDQNCj4gLS0tIGEvaHcvcmVtb3Rl
L3Byb3h5LmMNCj4gKysrIGIvaHcvcmVtb3RlL3Byb3h5LmMNCj4gQEAgLTUyLDkgKzUyLDIwIEBA
IHN0YXRpYyB2b2lkIHNldHVwX2lycWZkKFBDSVByb3h5RGV2ICpkZXYpDQo+ICAgICBQQ0lEZXZp
Y2UgKnBjaV9kZXYgPSBQQ0lfREVWSUNFKGRldik7DQo+ICAgICBNUFFlbXVNc2cgbXNnOw0KPiAg
ICAgRXJyb3IgKmxvY2FsX2VyciA9IE5VTEw7DQo+ICsgICAgaW50IHJldCA9IDA7DQo+IA0KPiAt
ICAgIGV2ZW50X25vdGlmaWVyX2luaXQoJmRldi0+aW50ciwgMCk7DQo+IC0gICAgZXZlbnRfbm90
aWZpZXJfaW5pdCgmZGV2LT5yZXNhbXBsZSwgMCk7DQo+ICsgICAgcmV0ID0gZXZlbnRfbm90aWZp
ZXJfaW5pdCgmZGV2LT5pbnRyLCAwKTsNCj4gKyAgICBpZiAocmV0IDwgMCkgew0KPiArICAgICAg
ICBlcnJvcl9yZXBvcnQoIkZhaWxlZCB0byBpbml0IGludHIgbm90aWZpZXI6ICVzIiwgc3RyZXJy
b3IoLXJldCkpOw0KDQpzZXR1cF9pcnFmZCgpIHNob3VsZCBpZGVhbGx5IHByb3BhZ2F0ZSB0aGUg
ZXJyb3IgdXAgdGhlIHN0YWNrLg0KQnV0IGh3L3JlbW90ZS9wcm94eS5jIGlzIHBsYW5uZWQgZm9y
IHJlbW92YWwgYXMgaXQgaXMgc3VwZXJzZWRlZA0KYnkgdmZpby11c2VyLCBzbyB3ZSBkb27igJl0
IG5lZWQgdG8gZG8gaXQuDQoNClRoYW5rcywNCkphZw0KDQo+ICsgICAgICAgIHJldHVybjsNCj4g
KyAgICB9DQo+ICsNCj4gKyAgICByZXQgPSBldmVudF9ub3RpZmllcl9pbml0KCZkZXYtPnJlc2Ft
cGxlLCAwKTsNCj4gKyAgICBpZiAocmV0IDwgMCkgew0KPiArICAgICAgICBlcnJvcl9yZXBvcnQo
IkZhaWxlZCB0byBpbml0IHJlc2FtcGxlIG5vdGlmaWVyOiAlcyIsIHN0cmVycm9yKC1yZXQpKTsN
Cj4gKyAgICAgICAgZXZlbnRfbm90aWZpZXJfY2xlYW51cCgmZGV2LT5pbnRyKTsNCj4gKyAgICAg
ICAgcmV0dXJuOw0KPiArICAgIH0NCj4gDQo+ICAgICBtZW1zZXQoJm1zZywgMCwgc2l6ZW9mKE1Q
UWVtdU1zZykpOw0KPiAgICAgbXNnLmNtZCA9IE1QUUVNVV9DTURfU0VUX0lSUUZEOw0KPiBkaWZm
IC0tZ2l0IGEvaHcvdmZpby9hcC5jIGIvaHcvdmZpby9hcC5jDQo+IGluZGV4IGU1OGEwMTY5YWYu
LjVjOGYzMDU2NTMgMTAwNjQ0DQo+IC0tLSBhL2h3L3ZmaW8vYXAuYw0KPiArKysgYi9ody92Zmlv
L2FwLmMNCj4gQEAgLTE4MCw3ICsxODAsNyBAQCBzdGF0aWMgYm9vbCB2ZmlvX2FwX3JlZ2lzdGVy
X2lycV9ub3RpZmllcihWRklPQVBEZXZpY2UgKnZhcGRldiwNCj4gICAgICAgICByZXR1cm4gZmFs
c2U7DQo+ICAgICB9DQo+IA0KPiAtICAgIGlmIChldmVudF9ub3RpZmllcl9pbml0KG5vdGlmaWVy
LCAwKSkgew0KPiArICAgIGlmIChldmVudF9ub3RpZmllcl9pbml0KG5vdGlmaWVyLCAwKSA8IDAp
IHsNCj4gICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIGVycm5vLA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgInZmaW86IFVuYWJsZSB0byBpbml0IGV2ZW50IG5vdGlmaWVyIGZvciBp
cnEgKCVkKSIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBpcnEpOw0KPiBkaWZmIC0tZ2l0
IGEvaHcvdmZpby9jY3cuYyBiL2h3L3ZmaW8vY2N3LmMNCj4gaW5kZXggMjI1MWZhY2IzNS4uY2U5
YzAxNGU2YSAxMDA2NDQNCj4gLS0tIGEvaHcvdmZpby9jY3cuYw0KPiArKysgYi9ody92ZmlvL2Nj
dy5jDQo+IEBAIC00MTgsNyArNDE4LDcgQEAgc3RhdGljIGJvb2wgdmZpb19jY3dfcmVnaXN0ZXJf
aXJxX25vdGlmaWVyKFZGSU9DQ1dEZXZpY2UgKnZjZGV2LA0KPiAgICAgICAgIHJldHVybiBmYWxz
ZTsNCj4gICAgIH0NCj4gDQo+IC0gICAgaWYgKGV2ZW50X25vdGlmaWVyX2luaXQobm90aWZpZXIs
IDApKSB7DQo+ICsgICAgaWYgKGV2ZW50X25vdGlmaWVyX2luaXQobm90aWZpZXIsIDApIDwgMCkg
ew0KPiAgICAgICAgIGVycm9yX3NldGdfZXJybm8oZXJycCwgZXJybm8sDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAidmZpbzogVW5hYmxlIHRvIGluaXQgZXZlbnQgbm90aWZpZXIgZm9yIGly
cSAoJWQpIiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIGlycSk7DQo+IGRpZmYgLS1naXQg
YS9ody92ZmlvL3BjaS1xdWlya3MuYyBiL2h3L3ZmaW8vcGNpLXF1aXJrcy5jDQo+IGluZGV4IDdi
OTA3YjkzNjAuLjY2ZTAyYjE1YTQgMTAwNjQ0DQo+IC0tLSBhL2h3L3ZmaW8vcGNpLXF1aXJrcy5j
DQo+ICsrKyBiL2h3L3ZmaW8vcGNpLXF1aXJrcy5jDQo+IEBAIC0zMTgsNyArMzE4LDcgQEAgc3Rh
dGljIFZGSU9JT0V2ZW50RkQgKnZmaW9faW9ldmVudGZkX2luaXQoVkZJT1BDSURldmljZSAqdmRl
diwNCj4gDQo+ICAgICBpb2V2ZW50ZmQgPSBnX21hbGxvYzAoc2l6ZW9mKCppb2V2ZW50ZmQpKTsN
Cj4gDQo+IC0gICAgaWYgKGV2ZW50X25vdGlmaWVyX2luaXQoJmlvZXZlbnRmZC0+ZSwgMCkpIHsN
Cj4gKyAgICBpZiAoZXZlbnRfbm90aWZpZXJfaW5pdCgmaW9ldmVudGZkLT5lLCAwKSA8IDApIHsN
Cj4gICAgICAgICBnX2ZyZWUoaW9ldmVudGZkKTsNCj4gICAgICAgICByZXR1cm4gTlVMTDsNCj4g
ICAgIH0NCj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vcGNpLmMgYi9ody92ZmlvL3BjaS5jDQo+IGlu
ZGV4IGM4OWYzZmJlYTMuLjI5YmY2NTExYjMgMTAwNjQ0DQo+IC0tLSBhL2h3L3ZmaW8vcGNpLmMN
Cj4gKysrIGIvaHcvdmZpby9wY2kuYw0KPiBAQCAtNzAsNyArNzAsNyBAQCBzdGF0aWMgYm9vbCB2
ZmlvX25vdGlmaWVyX2luaXQoVkZJT1BDSURldmljZSAqdmRldiwgRXZlbnROb3RpZmllciAqZSwN
Cj4gICAgIH0NCj4gDQo+ICAgICByZXQgPSBldmVudF9ub3RpZmllcl9pbml0KGUsIDApOw0KPiAt
ICAgIGlmIChyZXQpIHsNCj4gKyAgICBpZiAocmV0IDwgMCkgew0KPiAgICAgICAgIGVycm9yX3Nl
dGdfZXJybm8oZXJycCwgLXJldCwgInZmaW9fbm90aWZpZXJfaW5pdCAlcyBmYWlsZWQiLCBuYW1l
KTsNCj4gICAgICAgICByZXR1cm4gZmFsc2U7DQo+ICAgICB9DQo+IGRpZmYgLS1naXQgYS9ody92
aXJ0aW8vdmhvc3QtdmRwYS5jIGIvaHcvdmlydGlvL3Zob3N0LXZkcGEuYw0KPiBpbmRleCAyZjhm
MTFkZjg2Li45Yzc2MzRlMjQzIDEwMDY0NA0KPiAtLS0gYS9ody92aXJ0aW8vdmhvc3QtdmRwYS5j
DQo+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMNCj4gQEAgLTEwNzUsMTMgKzEwNzUsMTMg
QEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3N2cV9zZXRfZmRzKHN0cnVjdCB2aG9zdF9kZXYgKmRl
diwNCj4gICAgIGludCByOw0KPiANCj4gICAgIHIgPSBldmVudF9ub3RpZmllcl9pbml0KCZzdnEt
PmhkZXZfa2ljaywgMCk7DQo+IC0gICAgaWYgKHIgIT0gMCkgew0KPiArICAgIGlmIChyIDwgMCkg
ew0KPiAgICAgICAgIGVycm9yX3NldGdfZXJybm8oZXJycCwgLXIsICJDb3VsZG4ndCBjcmVhdGUg
a2ljayBldmVudCBub3RpZmllciIpOw0KPiAgICAgICAgIGdvdG8gZXJyX2luaXRfaGRldl9raWNr
Ow0KPiAgICAgfQ0KPiANCj4gICAgIHIgPSBldmVudF9ub3RpZmllcl9pbml0KCZzdnEtPmhkZXZf
Y2FsbCwgMCk7DQo+IC0gICAgaWYgKHIgIT0gMCkgew0KPiArICAgIGlmIChyIDwgMCkgew0KPiAg
ICAgICAgIGVycm9yX3NldGdfZXJybm8oZXJycCwgLXIsICJDb3VsZG4ndCBjcmVhdGUgY2FsbCBl
dmVudCBub3RpZmllciIpOw0KPiAgICAgICAgIGdvdG8gZXJyX2luaXRfaGRldl9jYWxsOw0KPiAg
ICAgfQ0KPiAtLSANCj4gMi40My4wDQo+IA0KDQo=

