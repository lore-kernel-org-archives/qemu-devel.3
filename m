Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C41AC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 18:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7fVz-0004Nf-Q5; Thu, 16 May 2024 14:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s7fVx-0004N3-OD
 for qemu-devel@nongnu.org; Thu, 16 May 2024 14:07:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s7fVv-0003Hi-3a
 for qemu-devel@nongnu.org; Thu, 16 May 2024 14:07:37 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44GGecBR009926; Thu, 16 May 2024 18:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=iXY51QOzD+uw53OcHm+otLX1Z9l9SFA7w0VAS9n5nNs=;
 b=A+9+v57PZ35bqF9NEJTGS1jw0ADwuKlmruR/Kmq4jBHlnPpmKXvWCvBjuoV3VLnkMQYk
 wQgaFErGjq9h0giq7f+DohVOSVOctuF6vQ7CrEgCqoZAGDaUFdj2G1WPVSLZxclKCw2C
 D+e1UsdvxYpcNVECdT1rVbXP2rtJFkcbARnIb0pOSL3Q6w7Stbn7TR8+riizDnQBm/Tv
 DLGjYkRLQUkNSmW1ffHw6Vk7uruMwFK8+Pwone7qUpfjCQDwKyYCpmsPi1sVq2Ix2vZt
 V80rJbdl82snq5T7eFs2cHkpEl36MC2IbN5PL/Ho2/QleyJMr32ksKqnb3UHtm0aey8r gA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3tx8p0g1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 May 2024 18:07:27 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44GI35mH018894; Thu, 16 May 2024 18:07:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3y1y4axrm0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 May 2024 18:07:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGEC0FJ6HywDUriVgnjCuoFrNwecn/jTWfZyl3cdgwJ+TrhHi1lhpHOICZcMC1+KOrOgSfRUD2hxGbAI7ODB6aFVGdNuFExrohNYzeW6Img+yuRumHPgwG9Zkt3OI1IOatg/8Q07+PdYXyrST4sXS9Bif+TWY6wbHkdAmvcPrvZfxrG2G+yMc/A3QZ5DYzbRtQYSU2K2vn+D4NiP/SIwIANtchp9F/hVIGNreBHI1fy9F9zLpTvz7VLvIFxjAAZZeNZVvJiRri/d144utJBB80vuC376gAy2wZkwMJplzDbRcOi3FT90B16ca6SHn8Z1aa58smCwiSPpiOSbEB6CLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXY51QOzD+uw53OcHm+otLX1Z9l9SFA7w0VAS9n5nNs=;
 b=P3e9fDugilx9mqt53watKeK3qLFreuv3k2zrfwRyu81UDFlQBR1XJORtRQqGPGX7QmpUCC6OkbQO+TGbxXNVpBT7EDBM2WAQB0IU4xt4JqeT7yskaUTwjjIrhfGYlKIYG75pz2sGPCCqv9OzvL3dcFxv4DJjDZi2VZ5fkq/PCH5rRf4S+qX1HnJzMDXG3rtJTVnODeUhnzoOp3DjBJb9Z6bB5IFK56eNVc7QYn6TXNtthbpMUEq48YnPwfUWwGAxzi9/1bw8/UShlNfWV+6GHS9LGXogeV7a8f/zuEyB/12Hjx5mCgCEEPhyyVe4W2CFushG6JDd0IvhN9ZKtjdaiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXY51QOzD+uw53OcHm+otLX1Z9l9SFA7w0VAS9n5nNs=;
 b=SuZs8QgTY7PyTyvQ162vcvJuJeBasuyDgd/A8xmFOQ2z1dDE0UkWdFi1SZUZ38pQMSsb+BrLAXv96MjB+kIX1gWykZhrmqWwhc03Gq21mMWL7p8B20Xd6/MMRh156oDQ1IVF5ku322/qXREQWkYZOwXIP6CuH5nQHgBEfmuj6bw=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by PH0PR10MB4551.namprd10.prod.outlook.com (2603:10b6:510:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Thu, 16 May
 2024 18:07:24 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%4]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 18:07:24 +0000
Message-ID: <f6e52844-d886-437c-94b4-22ad6c290532@oracle.com>
Date: Thu, 16 May 2024 14:07:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: CPR/liveupdate: test results using prior bug fix
To: Michael Galaxy <mgalaxy@akamai.com>, Michael Tokarev <mjt@tls.msk.ru>,
 peterx@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Hunt, Joshua" <johunt@akamai.com>
References: <20240228051315.400759-1-peterx@redhat.com>
 <20240228051315.400759-21-peterx@redhat.com>
 <f855963e-b7dd-4ce8-89dc-dfaa87e896c4@akamai.com>
 <82c69792-061d-460f-9db6-88fc8f9df5af@oracle.com>
 <d6176480-d87c-492b-8a0c-04bf81a4f59a@akamai.com>
 <59ad1f18-682b-46fc-a902-884ca6150c7d@akamai.com>
 <fadc022e-7cfd-4201-90e5-0193ce6220bc@tls.msk.ru>
 <916bca57-6bf9-48ea-82b7-c528660c6c4c@akamai.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <916bca57-6bf9-48ea-82b7-c528660c6c4c@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:a03:338::9) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|PH0PR10MB4551:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f188d8d-eb44-4e83-2d1b-08dc75d309ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXhpakJPa3piMnpsR3N3YVJVS1JMNUwxY2tqdUZ5S1FBUzVJSm1USXFSYVhP?=
 =?utf-8?B?UEVGQzZxZmR6VnU0cWZ5U3U3T0k2ZCtHcEZWdGR4b1RYaW5uM1AxNnVnaEJT?=
 =?utf-8?B?dkVlUVJwa1ZyT1M4SytPZm52THRSM1RJVTdaRVJOWU1ZT0h6YTlxUnZSeXVn?=
 =?utf-8?B?T2V6T0lsa0RHTFZicmhoa3FVaWx4OWJ0a1JsRFZScC9zb3ZadWhOM2hFVkdI?=
 =?utf-8?B?QmVjUVMxNHlsKytPM3NPTmU3aE95UElNeHlRUHBGbjNXYkR1UTdjMkJvRGh2?=
 =?utf-8?B?dE9hcVJBR0liU3A4RGFZMFlsSUFOL2VwNWsvQjRxTlU1b1lXVXdXYW5RTXVi?=
 =?utf-8?B?UG5xK0J5VzM1eHpUblVhU01BWEl0dlM4a3VVOWwzNENHZ2RMSC9GbmdvRWJt?=
 =?utf-8?B?MjVYczhpRDVpY2lzTzBZRW5CK2lwa2lsbFZqMVQ5MXIvY1ozbHd3Z2tiQmIr?=
 =?utf-8?B?WVhBWmRUVmZVS2tyZXR4dmhkWmtKc3grM3EyUTV0eTRsa2hGNlRORjJDZzZM?=
 =?utf-8?B?ZkZoTnZ3ZUtWOTZwYWgvWGRRdTRXL0pNRzZZRHNraGtTckZZYk85Y1Z1eGNS?=
 =?utf-8?B?QkRjdXhDRjlDNlppdm9adG1zeUhiemlzOGV1cmpFcmpodFAvVlZ1Ri9jTkkz?=
 =?utf-8?B?WlhlWHpmUzVhWWRrT2RqQTV2blc2UkV4ZWlYTFNQTWlVd1BFUjZudFhkT0dS?=
 =?utf-8?B?cFlLUFFRTzhKTUlheU5PRmVmODZaM2c4cUZXZGlvTFIrbTBRV2Q3MVFHcks3?=
 =?utf-8?B?QndmRDgyczlqUEs1Q1o3bTFuaDlkSmpWR2JrMzBYcHRNeUZkU0ViakxKSlhm?=
 =?utf-8?B?M2l0RklYM2hYQzNjN1plZHh2TWF4Z3dmcmpWc1pVa0pqK1dJOTF3UFlucEZP?=
 =?utf-8?B?emxlckw1Z3VJUXlwT1NVTUprK21ZcFNlSE1lbEYzR3R6Q3k5N2RabVgvWFAx?=
 =?utf-8?B?WHlObzg5V1QwL3hhVnA0UzRVNDRzbVVvNC9tN2krU0ZzNWdCd2pLNGh0dUU0?=
 =?utf-8?B?ak9XWXNEenFMWHBpQXV2ZW5SdHdmTGw2WDVXbk92a25Ja2hXTDdnTDNkUlZm?=
 =?utf-8?B?OVV6bjA0OGNnVUovSFMxU3ZIUWkyZ2tJVFJQbDlkUUJxU1k1cFZXVHlMWDdY?=
 =?utf-8?B?RmxsWVlVTHRDQ2pNNHN4V2Y4MlNLZVdlMHl2V0NFUmRON3dOcjcvVXQrcVV1?=
 =?utf-8?B?SmI3RnlySUhiSTJma2txM0lrMTZiOXdEZlZkYVZpRVdFekhCU01DeHR2ZklR?=
 =?utf-8?B?RE9sQTRiTmdmL282YmliRk94TG9acWJOK25zRFZDMUdOVFlvOGsybDJRTXZW?=
 =?utf-8?B?RytJdEwyYkNpZHZPakczQ1lQajJJNVVHeUdNNFIvSnNOS0ptc2VxRFBDM2hj?=
 =?utf-8?B?OXpKU2JVcTAvWmZhbEh3VmJZaU5nZ2dlUnI4YUNxQURyc3pKT25wTVYyQzlo?=
 =?utf-8?B?TldTUXJ0Rk05RlBJekZwRkt2azd0T3JWT0RBdmNSeEhLYXdvNmpGZ2ZselBF?=
 =?utf-8?B?clBkM0ZEeENPY1BEWFNkVXVOUzA3TjY5cEYrZzIxWmYxU3oveEhQOXJHUUsr?=
 =?utf-8?B?S1hIYjRYV0IweS9XU20xb2tUWG9wNUxXMmVDVnhabHdVVnM0MXV5NWpJampE?=
 =?utf-8?B?OG9aK1EybkpwV1ltem9qOCtISFd2QnJlZVFDS1pNRjg4Z2M3TlNmTkFTcHMv?=
 =?utf-8?B?QUNKWnVPNmRobFRXOTNlODkwMVUwZnBBNWx1V2IvN21PYkM3azMvUGd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aldVTTlDaTMyQmlHNUxNVVdVeHBhbXVxZmFyLzlyeG9SZnF4M3h1OEpiMmtR?=
 =?utf-8?B?QnJOVmFDMDBQTEIxcXlUY2N2UjFpR1pGRm1MRllQRE05K01iWFR0M0puZXJQ?=
 =?utf-8?B?OEgxSEV3V2NFSXdZMXMwTG9JMjAzejNlZFdZQVY3Skt2Vzc5dFQrOGlxTEFv?=
 =?utf-8?B?RkpNVVAwcDBWMSs4TXdKTWZONUNYQUoxTXllRFJIQ2J3SzNOMFlKYTJtM2NK?=
 =?utf-8?B?bVJhaWRBN2dvRTNuWE1DOWMydXAzUktPY0NLRTEyZ2hraXlkSm42VXlLdGk2?=
 =?utf-8?B?QWpSS2V1SEJRWDRrVmlKbkJQRm5LTjF3MEI1bDFlc1JVVjAvTS9KcnpoVGtp?=
 =?utf-8?B?YldkMTFwUStYb2JzdUJPTzYzVlBndENZSUxPZHN3TnIrWk41M2luTXhQTEdF?=
 =?utf-8?B?enhqWlhlSEVJUG5pOENUb2RoUHNsaS9wM01tdXJZNVlLcm9KZi9XY1lqN2JI?=
 =?utf-8?B?c3BabmF6R0IxZkJ2bUJDcHFneVJqNVIrcW1QcHZ5c1M3KzlUOFVVL2NWWC9G?=
 =?utf-8?B?NE90RjFJb1kySG02NDNwaFp0ZVA0ZmVUVzdqTG8wc3EzNGxDNGYySU1WOHlC?=
 =?utf-8?B?a1BFd3JDWHVPUENERkh4WlVBcVd0VHRuQ09FUXVpMSs4TVkySFh5OEdnWmRw?=
 =?utf-8?B?Z3A5WGx1aElqRnpHM0E3UEMxam1qd0RUeDdVeDFhZ1dwekk4c0FocysveXds?=
 =?utf-8?B?SG1CZVRMY1NZSTZyUXVIVGhGMUllelVBaHdHYWMzYjNRVzNRN0tKS095dHkv?=
 =?utf-8?B?SmRkeWZ4bHNxVERxbnM2VXc0WHF3TitQcXZTUjhGSlhDUGpDNjRBN1VvdWFW?=
 =?utf-8?B?MnRycExOYzZwMWZQZDU4YWFrbDB2UXY1MEl4VVZ3UDhKV1BsYXVWV2o1MWtQ?=
 =?utf-8?B?YU5sWEdpVE0ydTBSdVZrOXhRbGkydEtpS2Uvd21BYUtDYW5FMTZ3c2I4amJ5?=
 =?utf-8?B?T0ViNEEwTHgwTFJGNEczLzV3c0ZPTUVQQyszTFNzbDNJWWRPVDEzRlJQVTdm?=
 =?utf-8?B?Vjd3anduVjVpM2hnbVlYdVlMalFNam44R1puanlGclpkQmJJSUdtd2ZyTnFu?=
 =?utf-8?B?S1hsNERPdVIxd0VKOGtIeGtKc0tIT284dXZtZHoraVhNUkRWQ3h0NTRtbEda?=
 =?utf-8?B?ZEgxSFF5K1oxdThqQWdZSy9KMGFLZjBzZ3dFSnhJUGVCdC83VkFvaHNLeno4?=
 =?utf-8?B?ekV3MUxnVGxnM1k0WjZMSVFQdHdrY211MmRiMkNpcjlRdWloMFFEdE5nL2sz?=
 =?utf-8?B?UmhVWkxSRGIrUGltYTgyeWZMc1QrZGx6dnVIV1Qyd0pZd3VvUVpkM2JuZDRS?=
 =?utf-8?B?Zkp1NzVxbWdLSTVuWVV3VkNjL05WZjFiZFp5eVk5UCtudXFiTnc3d2dCV0Vs?=
 =?utf-8?B?VWs0R0dMM1BYVE9VUmhjeFRhbHptYjJJT2VLdFJwMlNiZStqOVA5Ym5VeHBi?=
 =?utf-8?B?Vmsyc3doamlxM2JhQ1ZaTzF0UUVqU1JHVm0zZlVvTjkwNlNKMDQxbG1BQjV0?=
 =?utf-8?B?bjRzeXdaUFFISDhaMWhJT2JGWFhVSnplUHhtVDdjQ3k2L2hBNDlWT2tkS1BR?=
 =?utf-8?B?dEFLaTA4d2owNG1GTXF2TVdrMUplN01jcUI1cTQrWUdFWGJXZ1FOaWZtWGF3?=
 =?utf-8?B?dFVubk8vL3hteXNiN2ZydURpeGlpK09vN2dhTHJSQzRON2Z6amdJM1hEZ2Ni?=
 =?utf-8?B?TWJJRm53TU9VZW1USlRRZzRVZS9TZlRLTG5rVUtxYjZGVk1uZ0VDL1RBakR3?=
 =?utf-8?B?RlhjeTV5cmtyNDdjckk3NFVRYkxzM2VmcWRoN05OVGN1OWVyVUc0MGdtQUF1?=
 =?utf-8?B?aElJYk5NZjJ0dWpqUEN2RlltSnZQU3VUZ2dkRUlsYjlRNU5LRnpaTEh2eG1L?=
 =?utf-8?B?WFNIcDdEeVB0dU9CTysvVm5MYWNLM2dTY2JQRzhsWnA4RUhxMDhYTnVpaW04?=
 =?utf-8?B?K2FNV1lsOHJQbUJDTmh6aUtTeWxHS01FY29nREFmNEswSk03WUhWSGZ4NDlO?=
 =?utf-8?B?bVlnL2FSZzVoUG14bHJ3YzlpZWxTUHc2ekw3dnh5VjhmNS9ybTFYekgvQTUv?=
 =?utf-8?B?bVR6dFZqU3A2OXJMNldURFNVKytFcnRNNnpYbkppQ3I3dGZKaTJ2cVhtcGxy?=
 =?utf-8?B?L0lOT3IzL0wzZFhVZ3B3bU1KMHNqc0dQbkJrU2oyMVc3MnNSei9LZ29GV2Z3?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: e/G1p+uk+ZJpXcMhBcn3ji2GE0OhL0U7QbkRApyzhwHvi78hut8XNU7hgf5+tcIR7WBIcFQhm6EGTbS2RBFrAu8qWMFD8BlcWfdy82OfU8JavFdQsQ2JYSIUihdjScs08i8ekaahWe4xikuck28rhtbQ5CEYPJyL4eEPQvlDQ1XZWaykWX0JIm6444dvwh0mGzgsuBzndOJ/VcWrTNMTvszYcGwQEC5U8mGLQgsk5mX3kh/bfjcHPpJ9sILn2kkCbuYhFncbGMI0yEPSwNwSs7nbktrZPA2/ftACORqTyvFCexbC9AoUkucTLFh/5X5+FMbGRBwsiGSY9jD937lvRpSPfEPOVjwbgx7G6x//Epzvgyoa36rrSfs0BKdVeimNlFhYFKIfRPqPUSSNWqEFaylNM/9w8AFf207vsRvGy/anLB69ZL3++L57wZM1tAx74eW0KLRCUdJ9pFCyNwZ7VHzPP9Py+N04C/PurgkvXrKdKeawvidDi0q3CrrxUrCoy8DDFiLV1fiCwWRS1hq1kVcuHR08k9NJ3QxDPdGQeGGhdFzLKGkUAanvfTeBOvfh/XOGB5HE7Ze6In0Q7xW24dTv4fGxXxrOVTetVdEhTS8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f188d8d-eb44-4e83-2d1b-08dc75d309ca
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 18:07:24.8637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlmD633shaWcy4Msb0EGln/9+e9F41bxzOaS/lZns8VyYXKp1KL7t1phJWVy11ZC14jW6I1UJ05BZ7jC1xaG0MVOezG9mAgAnEl95O2KAZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4551
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405160130
X-Proofpoint-GUID: hoK4lpc4E-dE9gtcMMVowZ2n3EdyF-e0
X-Proofpoint-ORIG-GUID: hoK4lpc4E-dE9gtcMMVowZ2n3EdyF-e0
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 5/16/2024 1:24 PM, Michael Galaxy wrote:
> On 5/14/24 08:54, Michael Tokarev wrote:
>> On 5/14/24 16:39, Michael Galaxy wrote:
>>> Steve,
>>>
>>> OK, so it does not look like this bugfix you wrote was included in 8.2.4 
>>> (which was released yesterday). Unfortunately, that means that anyone using 
>>> CPR in that release will still (eventually) encounter the bug like I did.
>>
>> 8.2.4 is basically a "bugfix" release for 8.2.3 which I somewhat
>> screwed up (in a minor way), plus a few currently (at the time)
>> queued up changes.   8.2.3 was a big release though.
>>
>>> I would recommend that y'all consider cherry-picking, perhaps, the relevant 
>>> commits for a possible 8.2.5 ?
>>
>> Please Cc changes which are relevant for -stable to, well,
>> qemu-stable@nongnu.org :)
>>
>> Which changes needs to be picked up?
>>
> Steve, can you comment here, please? At a minimum, we have this one: [PULL 
> 20/25] migration: stop vm for cpr
> 
> But that pull came with a handful of other changes that are also not in QEMU v8, 
> so I suspect I'm missing some other important changes that might be important 
> for a stable release?
> 
> - Michael

Hi Michael, I sent the full list of commits to this distribution yesterday, and
I see it in my Sent email folder.  Copying verbatim:

----
Michael Galaxy, I'm afraid you are out of luck with respect to qemu 8.2.
It has some of the cpr reboot commits, but is missing the following:

87a2848 migration: massage cpr-reboot documentation
cbdafc1 migration: options incompatible with cpr
ce5db1c migration: update cpr-reboot description
9867d4d migration: stop vm for cpr
4af667f migration: notifier error checking
bf78a04 migration: refactor migrate_fd_connect failures
6835f5a migration: per-mode notifiers
5663dd3 migration: MigrationNotifyFunc
c763a23e migration: remove postcopy_after_devices
9d9babf migration: MigrationEvent for notifiers
3e77573 migration: convert to NotifierWithReturn
d91f33c migration: remove error from notifier data
be19d83 notify: pass error to notifier with return
b12635f migration: fix coverity migrate_mode finding
2b58a8b tests/qtest: postcopy migration with suspend
b1fdd21 tests/qtest: precopy migration with suspend
5014478 tests/qtest: option to suspend during migration
f064975 tests/qtest: migration events
49a5020 migration: preserve suspended for bg_migration
58b1057 migration: preserve suspended for snapshot
b4e9ddc migration: preserve suspended runstate
d3c86c99 migration: propagate suspended runstate
9ff5e79 cpus: vm_resume
0f1db06 cpus: check running not RUN_STATE_RUNNING
b9ae473 cpus: stop vm in suspended runstate
f06f316 cpus: vm_was_suspended

All of those landed in qemu 9.0.
---

- Steve

