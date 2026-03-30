Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A478FF495E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 13:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Csa-0002dX-1y; Mon, 30 Mar 2026 09:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w7CsT-0002ci-6P
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 09:42:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w7CsH-00024F-UA
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 09:42:00 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UDE3GH2002110; Mon, 30 Mar 2026 13:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=oB4Kthf48QrFIiS7Tr/TLwRE3cNDw8bjBrCrpsSaMsg=; b=
 pschn+zjxQHYuPUqTcFFrcvn6mn8Oq/HmLGs8tutLlUdtUzYhWtOmi21ZUgFtiK4
 fZi6WxFUS6aPXhm+Ub2VisV6is473a9GdNFeFPky205N4tmAxIZUI/DUrUAEsVME
 AS587lsN5aBEZLqlD4xuFAi1v5Lc6pzLJ5lO+bRDY0gnCCUs9n1NKEevj/INvRbl
 qfomlSBt01dEC6W/p8WV3+FAdY08h9CeeII9Tb6g+y1pBE9hV7RUtpHRDNEqPUP3
 r480ZMOPjWV43nG7DYnbVv5su1byT5QPtwsIaT79Ec0zkEdv0wHmhCcKHnGRWfBG
 TS6l8bEjLe3I6742lTnO8g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d65jwa968-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Mar 2026 13:41:36 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62UCek2c036587; Mon, 30 Mar 2026 13:41:35 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012047.outbound.protection.outlook.com
 [40.93.195.47])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4d65ef3781-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Mar 2026 13:41:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KpmcTL6Y/zKUOHskjEK+72/NKe8gaZVkaAn045ydfV4eQGfOO8/Hp+UIo9lysLzflcu45I74tpHqeZiobkBw5XFaTUaw2cLp7GhL1C2N7by1NZRTfmQhGWeXeOVb5suZPLmS5esiv0P2Btu+p32XOI5LGXVM03PvpzmJVBw6OL3UlH7V96Uw9kodg3du8Vfqdx2BYH5O9xgI+CshmllY8YfmwEN8EhofU8U1XUzD/jZTjOKMPSjq9D8HROJhMQ04f7vNlddkfZ+3bvpL/zAR/6Q06XRhVBnPV9HibUMznYMdab3BtcNQ2YB849TRkfrxiIE9yg2uLFHFrJi8ludEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oB4Kthf48QrFIiS7Tr/TLwRE3cNDw8bjBrCrpsSaMsg=;
 b=pthx7rXqBO33YKbOF8V5/5FtZ2JAOg8R0y1E7pxvNyJQLo9YXeP0AHyxGwpV3MmsDZ3oPSedzr+EW6Dbg6JuEm/zJspaNOURG0LnNsqks8jKJuBS8GcAqE41ZD19IF48BNP01eYccpdgz17j3Xd/8OJCabHxBVdO6S8ncVo+2HTTeYAJd6xwUENfBcYjZmkS4AXwiZEwE/rJ9StqUaYcKc6msoJB39YBEmqJf4MpPUqaXJi3SwBtd4TFzgLBwc328TS+Xt6W6qBoKZm0V4CwoHCWpCJ11R/IQI69i14f82FWeA9XYPtOEZ0A1CBMPhQgI8fV4EJffR5JASHKuVpLCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oB4Kthf48QrFIiS7Tr/TLwRE3cNDw8bjBrCrpsSaMsg=;
 b=RCJM+FrgnXz6yqESLsTL4xoEttTS4gavp6eoQlOnEikBp+TFM9gc1YFNxqxvbpsLmBjk9EaYPfdYxSmB3uV3U89fx6Cg9fwvAWwfQ2+ZFH6U5iXTNfXOCRZ4kHx5QKs8D1WSrdkWXhORZEBrqk/3Mt8590In15VFUG/OZWQInpI=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by SJ0PR10MB5614.namprd10.prod.outlook.com (2603:10b6:a03:3d7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 13:41:26 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::90f9:3960:8442:de85]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::90f9:3960:8442:de85%7]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 13:41:26 +0000
Message-ID: <96ea2b5b-9449-43d8-a6e5-1e6819d717ed@oracle.com>
Date: Mon, 30 Mar 2026 09:41:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 04/14] virtio-net: detect VirtIODevice status
 mid-migration change
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com,
 leiyang@redhat.com, si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com, Juraj Marcin <jmarcin@redhat.com>
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
 <20260320142015.3856652-5-jonah.palmer@oracle.com>
 <CAJaqyWfkLCu2RRGaJZdcqG0c3uZH0jWmmTmN23F=Bz-Hfm4KOg@mail.gmail.com>
 <654f2356-9c78-45df-95ff-de103557948b@oracle.com>
 <CAJaqyWdN7AYQnugLjwRr4sWDj_dGNg8JpmgBXprgLej_UD8ZUg@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWdN7AYQnugLjwRr4sWDj_dGNg8JpmgBXprgLej_UD8ZUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYZPR11CA0001.namprd11.prod.outlook.com
 (2603:10b6:930:8d::28) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|SJ0PR10MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e469ca7-8c4c-4f69-e8b8-08de8e620a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: YUceeX8m4H/TuscuYrEKRfzm+63ikba0fCl9erK9PTqN9nqiVINgqbTxFJBMfs2Yc+qFFJZDjhWtYsWdg1khY9fl9hfxaqxfE6Qz/x4qnm2r5y2+F4kSsDEZK+AbXF7b7JGVurcjBFXiDXb+Nvi5yFqGcZ70UcopHG2+dEath2CleuWKr1AyibjeVOFLxTW74FYdPxIa6njrDFsZjTcevr5InAD8NIA01cFzR7IQw5SBYy7RHFTR5OpE1Shup2y0LndqqlHKkwEc+aMAVpNXE+Cu5+P8okTXoWFnOKP16+VtPYhpd1tTHzkEQqMBxYZqZb4gbKoX2BpWZHFzDTW4LF2R8P83V8uazCxJ4aYC9mRXON/CYjvpPND0/IRjnUKdchbk8sEL1THuQ9goMwtJbayri8qbFUjw8gKESGb8yuyz3GEhlntfbUSSTPaw4UI+xkHr9BW+62d4G7K0BSpj1+KcXLCruUy0PCgNpBpZbyNDfuigu/I/CWcsFr2MBxouWRDi0Mq728rrig3WzWA3vM8kOt+jRB310XelZYWKd+oXSdh0/xQaj++RpX952fvh1RTot2XH2oM+7OfdEDNvgMrrn2UoqTIycmvLOz4lHCG8Wn3joKMjmMx4gvqNXXI+rcFBrrUfvJXQcLjUdrnfGngBTQOcGJcJXZKpdqSOjbjxHKKO5+w1nttIGwFXaJjNKnUGsNgdfV5zX/XyxUzXYIA8gzXEQmPIvDhVZj75oiA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU1SRC9mU3BUTkJPY0NqUDh6elp1SE5WUEVqbUszcVgxY1hHdEZZNDB2U1VW?=
 =?utf-8?B?L0pmOHVSZDJCSkNkWjdiQ0w2Q2gxRW94REE4clZOOTVDV29xdi9Ed2dpSWsz?=
 =?utf-8?B?VlJyYisvcDY1L0JEUkxxMC9LMk5hTERuSTZYakFydzMybnh0NmdLV1N1eFkr?=
 =?utf-8?B?Z0MyVndvb2huczlyNkJYTW5mamEvMVhrSHVSL25JaGtRSEdHWldxSW9TL2Iw?=
 =?utf-8?B?VEt1Q1dEdjFpL0xPek14NHU5OVRyTzR4MnBBZUtDQjdFUnhxZVEyY0hMdFBX?=
 =?utf-8?B?cEc3OWYyVjIxZHdmVlpUMkZZaytLTXpGc3BYRzV0R2pKLytxRllIYXl0eXZj?=
 =?utf-8?B?ZkwxREtPYTdpQTIzT0JMcEtXNk5NT0hFbWx3VlpOMVdRczhlVFdyUUJjYWlG?=
 =?utf-8?B?TUJMaTJnOW1YVWo1KzIxcmpZbjkyQUExWlloRFJRUWJBMm8yZ2FvMmI1NDZI?=
 =?utf-8?B?ay9QRzBOWHRnRllMZDNRbmd6OFJzU2cyVDBZYUp3UzlaRXpxKzdhNkwzVlNR?=
 =?utf-8?B?MnRoclc0SEFBeDVrWXRSRHJKejBLMWEzV0JyVDQ1UWlScW9kekxWMkF3Vks0?=
 =?utf-8?B?UndHR1V3VnNPL0JOaCtpd3E0Unozclk5SktHbVdKSWEyODFrZ1hhM2JySUhW?=
 =?utf-8?B?emZlOGVqZStDZFh1ajNpYVVyU3FQMytsQnN1ZThxSlpiMi9uTHJRTHRKdElD?=
 =?utf-8?B?d1lqVGNKU0NpUURTQ081ZldVeXYyS3pOZzl3VTQxbmQyZXorVC9vVm5BSlEr?=
 =?utf-8?B?ZU9aaDJWSWY0YXFOSkV3ZncxV1p5ZzcrVU9PYTFLY2hHcGxjdWhOWWJQK3lk?=
 =?utf-8?B?MXZYYmNPZzBQQ1ovTEpkdDBZZVV1UTc5emd6cjN4MG1iL3pyZXozV1RGVnMz?=
 =?utf-8?B?Mmoyd29FQ2lFdnFjcFc3NnFaNCtuN2dKOEI1clZzL2FKdC9VWExoZ2NPTXEw?=
 =?utf-8?B?amZqQkkzWTJ6WktPVitkNENmdENHY1VXdWtHcnhNVDBWcGNFTHNZQ2NZMk4r?=
 =?utf-8?B?dnVaNFZsRDg1NTBnNjlsdEQwb2loZC84RHRHK0F0Q1pGUGRkQVhiTU9LYXhM?=
 =?utf-8?B?eU5SeEozSW0zNGlHZUdFaEY4QjJjT2FUWnBuK3crb0ZMRHZNWDI0bGRRSFpY?=
 =?utf-8?B?S2IvaVljcnNJMVc2OUFrZ3JwNUFKeGcyL3E4cjhONll1MHpudGZlQU5lU3l0?=
 =?utf-8?B?aEJ1ZGFSQ0w1dEJURytoM2ZxVGFjWVJDeUFNZUdEM0VHYkZjU1RRZTBQblQv?=
 =?utf-8?B?dGViSFZKQWJqYjlKUjc2OTFLVmpETVN3WU9HWDcxL1lnckxvQWNoQjVuNllj?=
 =?utf-8?B?T1hic2gzSEVCVFMxY283aFkzeEpMVDJJQmRIdGtkM3I5eWhsSnhqcnNSVVJR?=
 =?utf-8?B?Y1FCMHdUV3oveFFVYzVPTzJIeThlUjg2VjZ1czdyQ3pnL0NWS04vN3h1eGdi?=
 =?utf-8?B?SFZMeXo4YkZLY3QzbDdRY1JFcmE2MWY5NnBZM3dUZkhrSk9tblpwc3ZkSVlM?=
 =?utf-8?B?b0pQNndUSkdGQ0xvSDNiV0NOVGtybDNiUXhBQ2ZyNVF5NU1HOERkdU9NVmdU?=
 =?utf-8?B?ZDljdCtyYjNmYlV2OElFMGpOWmYvVTZ4ZTVwSzU5VDBoY0FZTTlEMVBnSTBV?=
 =?utf-8?B?WFJrdGxrVzVWNjlTRmo4Nk5PUVdQVjBDSXY0Q20zTWJxVkpZWEVZWVZJQ1dv?=
 =?utf-8?B?aVdxRXp3bUNIMzM0Y0FyZXhsWUZod21FZysxS3cxcWVsN25TMkF2aWQxa0RB?=
 =?utf-8?B?bXhDZHhEYkhQbXhoZmZsV1UxQllhWUhRVFVCNVVRYlZmbkhiQ3lYeFZJUFM0?=
 =?utf-8?B?c0RKTWQvVkgvWVJUaVkvUHNiNktqZnJ0MmZPZXFoWGhkMkpjSlBFZWhGb21G?=
 =?utf-8?B?bFFYOFVSazJyWjZ5c2gzK3lBY284dkkwcnlybk5nYys4M2IvKzRETFhRdWM5?=
 =?utf-8?B?aGFiL1BzMnM2Z05wVXoxYW9PMTBBQmNwb2NwQWJ3NTcyZGc3RDZZQmw0OEto?=
 =?utf-8?B?ajNXTitGTEFOMFdpSCtvcjNWblpva0wyc1NIZmlQZFYvVFkyYzNUR3lweU5Z?=
 =?utf-8?B?c1QxdDV2bzFDMW4xOXY4S2NSbWpFRStnY0IrTDh2S3hkVXNYcU5ueEU3MFlQ?=
 =?utf-8?B?eDNpVmJwYlRqc2NQZUVMNDJpeEFGQTVsVnJrZ1ArUG4vTU5wVTRHWllGZTg2?=
 =?utf-8?B?Z29kNXlKTml5WGt5ZThPWCtoZ295K1Blc3BuQitoS21tME42a3h6bVJiQkIz?=
 =?utf-8?B?aGxScHZhOU9DUFVDRGFWTnVERlVyT05BSDlHQXNOZXoyWE5KS1ZMd1JqVHFp?=
 =?utf-8?B?UlZKWTdha2hGVkRDRldSU0NWV0ZTNXdWRmtiSHZYZEU3aS9SaUE5Q3lhNlNw?=
 =?utf-8?Q?EU0Zgu/qNCfpY724=3D?=
X-Exchange-RoutingPolicyChecked: v9PPk/XuPNy41sze5kRTXCaPhgrlrkhlf774HiAhoC+J8BhvKOyIz4khx08Rz4LMe4/Gq1NH1z9U76S3L6PVc2Kv5dWCa6xHEJztCx0NyRB3Ch6JBfOBPBfKRJKqDBoFwEZ8cjvt98WRpDzJ2IunxZBU4ZdRY15RVHyYdIBgOOQe58iYd/qezEb55HhwzL+xQGW+KQ5R3DnvpN97F4+q/mxZiplQm1POfdjp/JclRiqUNA8x8kRGJd3UygdRryz5Tf+SA7tkoaJLSePqupesNJfqLWynWa32mDSPsj+Kl41v1Xd871IoPnaE9G5AwsUFanaiMUETM+Nr5OqzB5VjGQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 64JsXDpPT0oQia6iOF1oqo/muhx1UaOSiAyfSf8FK6Ra0XB6SOoF9dquZlcS0InFtgpE3S1fVPQZRsJhodJVYFM/t80KuJ5eJFGn1BvMvFjAvgPRp1IngflvdF2I4aG6oZemRUDwcCX/d4w2PPJVPU8fKoRtQKmChpE4UOQLlIGPh1vZv+bx2SHEE1m7PcN65FpmjgBT64m9E7IzMfSF2xm5bixIfjce1J+epXD1kDXVC3Z2Bln36seQR4iKVXzRjx3s6GfjaqGCAcrr743O2T2G1FSLrd7HZH/6OUd0rYRBhQ/0omAhAZQTPGk7X2jZd/30vwFOVQJWqcWtFbnkcSZN6w0/ZQESYvVIs9L30W4gXUkkge40zvfvT80Xs5Des9glB9iBlzAe3NlOauEbd+lR/wsgOCOwaGAuAxUhlKoyUm8+AhVJeHxhOKSNTuKbFmBD5lT2NvLYQYG6r6E3p1W4umHzWeUPwbMLJ+73kjsDxBS6CZ/QkvtxHTto5iExn3tokI1vDN70Wj7i6VyFcy7S+BNMK54PYHiQ1TaKazK9POc4R/rHtEr/mqXgaDHdDV4LPMxwXsuN1YTSuJuYZzrwWeu5lQNVoTtrXM+ktcs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e469ca7-8c4c-4f69-e8b8-08de8e620a4d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 13:41:26.5947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ls14rftyb++TikqMw0kyhmwSJ9Uf1WHssonVsLgPcqVpH0+3PR2BemuV1JFKIVHoW62S4ARbIxhTblkfxKazg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5614
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603300106
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDEwNiBTYWx0ZWRfX6kuXoT5KDR1e
 5wfp87Zlyno0tacZlxf4Q7L2cH+/I742VElbNudXJ0+9bgjWXVZucFbd4DgmkIQAVHk14Nkbt6X
 5btsLScARWW4Exis7ELY5cu6APErLrfdEQ9AirOOaOIgFCWTEydMF8hGg7LQON7aP5zR1ArZKg7
 MFQDtK3u27vQwyCRULixTKFHxoB2X/GEQ9U8wxNEh1PEgMljRbhkLjBjZYFYj3o0hWPMZQqdwlP
 UKU8KHb25YvY5Ol6seTV5jH/9/22vmAx/FS6avGuRrPVSloreuL759TQ+c3H+4/9/JN7HfWewvZ
 F3I+0oEOktbnEU4r5qCcQtJBr9OpABTLc++igjb/ct953pw8n4zOowBjlM57RA3R9jUCYarKFDi
 AWPs2soKwUAwYwDgPuMx5XyWKsd2DORWOfXFmh4biOHGVDIYGKwVMVBxITXZHRiXrMMtX0DXfh9
 3ZzoEMrEX6qlMJqtdHNRLozAFwWkbCxCbT7tWZAM=
X-Authority-Analysis: v=2.4 cv=CJEnnBrD c=1 sm=1 tr=0 ts=69ca7d90 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=T6cHWUA6s9FjYo-dvAoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12276
X-Proofpoint-ORIG-GUID: nTVXQvDW2PfsFOzCLRtkog8Hqb7iBIco
X-Proofpoint-GUID: nTVXQvDW2PfsFOzCLRtkog8Hqb7iBIco
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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



On 3/26/26 6:08 AM, Eugenio Perez Martin wrote:
> On Tue, Mar 24, 2026 at 4:02 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>>
>>
>> On 3/24/26 6:45 AM, Eugenio Perez Martin wrote:
>>> On Fri, Mar 20, 2026 at 3:20 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>
>>>> This patch introduces the mechanism in which this series will use to
>>>> detect VirtIODevice & VirtIONet state deltas, starting with the
>>>> VirtIODevice's 'status' member of a virtio-net device.
>>>>
>>>> Before we send the device's state early, we save each piece of its state
>>>> in a temporary structure via virtio_net_early_pre_save. Later, once the
>>>> source VM has been paused,
>>>
>>> While I ack this approach should cover 99% of cases—as I think it is
>>> unlikely the guest changes device properties during a live migration—I
>>> still believe these changes should be sent when the guest modifies the
>>> property, before it is paused. That way we shrink the downtime even
>>> more. This comparison fits naturally: Instead of sending one state and
>>> then the deltas at the switchover, we send the state and then the
>>> delta for every change.
>>>
>>> However, I'm happy enough with this approach because it is more
>>> self-contained within the migration code. It also reduces the state
>>> sent over the migration channel if the guest changes its device status
>>> many times.
>>>
>>> CCing Juraj as we discussed this at the virtio-net upstream meeting.
>>>
>>
>> Right. I agree it would be optimal that, for every change made during
>> live migration, the destination is updated with this change and it's not
>> left to be handled once the source has been paused, which would impact
>> guest-visible downtime (especially if it's an expensive change).
>>
>> However, the only way to handle mid-migration changes like this is via
>> the SaveVMHandlers framework. I did give a stab at this approach in my
>> v1 RFC series:
>> https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/20250722124127.2497406-1-jonah.palmer@oracle.com/__;!!ACWV5N9M2RV99hQ!PyNRmf036KN_mQbYDRqZ3R20poPNdyxA80Jf3K4CHxcB8GmtxokyYDr4FYWWZ-N1m1CbGYjcQjF6-XzoXW0$
>>
>> However, Peter believed that this early-migration work would be better
>> suited using the VMStateDescription framework instead. And the VMSD
>> framework does not support handling these mid-migration changes before
>> the stop-and-copy phase.
>>
> 
> Right. But we can extend the VMStateDescription framework to support
> asynchronous state sending as well. At first glance, it should just
> add a new VMStateDescription to the struct SaveStateEntry, let's call
> it live_vmsd, and call it at the same function that calls
> SaveVMHandlers->save_live_iterate, which is
> migration/savevm.c:qemu_savevm_state_iterate. The load version also
> needs to be called when .load_state is called.
> 
> While this extends the series, I think little code is needed and I
> believe it's the right long-term decision to avoid adding multiple
> ways to solve the same problem. Again, is this ".early" version is the
> best we can do, I'm pretty sure it solves most of the cases so, sure,
> I'm all in :).
> 

Oh, that is an interesting idea! Like a hybrid SaveStateEntry with 
SaveVMHandlers for lifecycle/iteration and VMSD for the actual payload. 
This is something that definitely could be explored.

However, I'm not sure if this kind of enhancement would be appropriate 
in this series specifically. It's a legitimate follow-up idea for sure, 
but probably not something that should be tied in to this series, right?

That said, if such an implementation were to be upstreamed, enabling it 
for virtio-net/vhost-net/vhost-vdpa should be relatively straightforward 
on top of this series.

