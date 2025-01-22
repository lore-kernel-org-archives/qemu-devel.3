Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D26DC02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 19:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tagZo-0007E0-KH; Wed, 22 Jan 2025 14:39:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1tagZn-0007Dq-0Z
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 14:39:47 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1tagZk-0005wX-M6
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 14:39:46 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MJYcRK012484;
 Wed, 22 Jan 2025 19:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=OTEcikZdOhHjT0tyCL2wky9yONQEvQ0+fkYoYcX2RiM=; b=
 LJLDU6cVwqiOTtIXrq+6nU1EdFWJ3N/V9ZbxZ2kj3Nk9Avw9k26jeGVXel29DQcj
 cGql1PjHDeHWLySxRe+keIynWt0DdUlfSltDqRVgyzA65QcOHjX+kV8NXNjNu+oA
 e6yf0cI9vuyIIV1FrZr2V16Erc4aMuloSW1r5mr99zydX1Xugzz4RgMdwtZ8BvQU
 WmpCSI/3JIejMjrCUnxiWqoqV962kJQ/40Y4RyqA5SsWWpSuItywYhAlljFUC3on
 2MAJcVJfnXdEo9SSUorvcKSccygF9TVMS3r+9RkyoypjLsTgPc7mUmdxZCnmb7AH
 74lvMT3ixCqfhqpLsc7nDQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awyh1723-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Jan 2025 19:39:40 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50MI0cDD030280; Wed, 22 Jan 2025 19:39:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4491fkk7p9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Jan 2025 19:39:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ow4pjUWbJW7HoLp7LeLzdvAWsSEikGLzfnwZ4mQ5mOYhgLAUwmGfT8mcaIR8MKOU/AYAzRcBNR1c63SK4upAOP5ZLfckVkPbjXXtFh7S+keYPTzyzFVbi9SBJlHu03yQHHwW2+T6ftKyQxVO6HrF5BaXgEnKG1flWm3ww3X2q6imhmIM4CiNSXIO09N8sgOY/HfWPjsjiKIBApKQ0Rnt6u7Azlv/MmxKdQqVQq/ARpFauSU7fQiSwpn7uqHOLVNDvsmZ4X5oD39lEg5og5lxEgayBJLrdm3iETPvTzArmb51UjDavxHe03JAHu1VJXFc+e2CXdv6gmI4QT9vSIriNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTEcikZdOhHjT0tyCL2wky9yONQEvQ0+fkYoYcX2RiM=;
 b=bODZSPgKdJtl8tvL0s2Kht2JtT68TAb9FiXHZPLTReydaAUR5h3MVVF3z5aUTARqJSc/HfLhyJfnMEeLt3LH3udau/ZjGMioVFUzCc4cPxOOs1iZzXA7YeEB/Ys0wz38v7ppUWeADFf1XWylvWk/yihT1k+nZNTFZACNvJW8VY4Ah6RurwxbGNm2QuoRLylh6ESf5Hda9Rf5PUwjOJAehrm9jit8JU67sA5fnmgnHvjT4PhktpgBGONSUdP0WC5YM7F222DEEfcnPrBTk81Q7kU5wRhL+76VXc2MMDJ6FIHU6gtupnFh7HGCktrZSFE6dwpY1V3gkUa9cKbTjUCEVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTEcikZdOhHjT0tyCL2wky9yONQEvQ0+fkYoYcX2RiM=;
 b=u1XC3oRE79se3HvGfpKf0HieNwJ4VuAc/d1TjPb0SEdnGGV7Vru1wN/0bkgO1yRFzWqt4dGjPHThmFg7BtkMh8GwHVXWxHkJBVqAd6sIrjyN/Kh+MH/z6CJn9/5D45xMLbeG0pOdEicWw9vjqKvug2bzzLfF3tp9qUyYaYHRpWU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM4PR10MB6157.namprd10.prod.outlook.com (2603:10b6:8:b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 19:39:36 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 19:39:36 +0000
Message-ID: <a1bebaa5-a6ad-42d6-b16e-653deb3c358e@oracle.com>
Date: Wed, 22 Jan 2025 20:39:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] system/physmem: take into account fd_offset for
 file fallocate
To: David Hildenbrand <david@redhat.com>, peterx@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@linaro.org
References: <20250121225426.3043160-1-william.roche@oracle.com>
 <20250121225426.3043160-2-william.roche@oracle.com>
 <4f40dace-0f06-4e15-9cf1-d191621d080f@redhat.com>
Content-Language: en-US, fr
From: William Roche <william.roche@oracle.com>
In-Reply-To: <4f40dace-0f06-4e15-9cf1-d191621d080f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0023.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM4PR10MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f4dba35-d306-4b28-208c-08dd3b1c80b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1Uxd3p5dm4yRVI4NE1FdVhyU0x2UFhGQm15bU5sNEVpTThhM29TOG40WDlT?=
 =?utf-8?B?ZmZNVFFIK0tSV08xWlFLZnhFc3NNalFUWUl1VWsreVRwaUVWTE8rS2YxTXBa?=
 =?utf-8?B?RE5vd0VZdmlEMDVlYW5tcEZNaTNITUNzbE9ybnczbitmeGdOdlhPaENvd1pC?=
 =?utf-8?B?dkR0Ty9vNDdwNnhGcnJPY2EwZ20ybmlLcW9BWkdpakovdDRaR0RNVXczaGdw?=
 =?utf-8?B?anZuSHBZQUplZE5qdGRnbnRlVTkvS3duQ0NGekdTL0M1clk5NXVQdU52T0ZM?=
 =?utf-8?B?ajhJS2Q2OW9OdktnWDd1bzF0REVSKzhLclE4REpUMXR2c1R4QmRCMFQrV2Js?=
 =?utf-8?B?djdCSnVFQmpGTlhxM2VFaXF2aCt3NFhTcWQwb3hxbGtkZDVyMDdiRkdsY0xu?=
 =?utf-8?B?OEUyVHlFeGU5bUVuSUJjcXprYTY4T2MrV0oyR0VQUHZlYjlyUnlhZ1N3bi9M?=
 =?utf-8?B?WDcyaVRWbTJHZG1aSGIwcHFydy9KWU1IbzRFSXd2TTNJYUY2b3BHQXVvcS9H?=
 =?utf-8?B?YnB2RmdIakxKMEFYc3I3MGFMUm83VGFyaFpGaW5EYlJkeVdzVVRZeXNsTGJm?=
 =?utf-8?B?S0U0L1ltSDRyelB3b05mZnVqVUl4dVFyMmg4dlB2UWZURWMweE9TQkVML2VJ?=
 =?utf-8?B?K0RuWGNpcysxbUJ4Z2tSQ204ZFlldmJRUml2REthbkhzOFdaS1pydHNuV0R3?=
 =?utf-8?B?NW9RbTdOcndrbXlid0RudnN5TGhZcDQ4eHVGNjNFZCt6VTlhOVMwbEVHSDM3?=
 =?utf-8?B?SVpHL1VYQXhpMU9DUDVDem4xbFUydFAvRndxblk3czhVKzRSS0wyTzJCdzZS?=
 =?utf-8?B?cUJaNllVS2lxZU1vYlJHR2xEbEZYQk5HQm1QR1V5bTFKQ21teUFUMmhVTVNS?=
 =?utf-8?B?TDRzNWxuaC9IdGV3QUZCWXEyMC8zdVFMWk15Rnc2MkJYUVdCK2hwWU9DRDl3?=
 =?utf-8?B?Y1lEemRYMzVwWWhaZGFidkxTTk9LTTFjem5veXRVVEtzY1ViaDl0dFhBMVNE?=
 =?utf-8?B?N2F6SnJjUWwvS1FBVWRqZjNXdXdxcWpKTGhVVDZmNGRzNEZiVDBHRURFWTFu?=
 =?utf-8?B?K0ZtUjU1OHM4VnZucE0yWkJnUlNaaG5CRHdTdTdva3FpT1B6N0NNeVNYSjZR?=
 =?utf-8?B?bkZSNmw2c1VXeEE4WFJReXBDMXlUdWdrMnNtSTY0d2R3K2RMeUV1MXZiMFVv?=
 =?utf-8?B?cDBEUXA2ak11Wm9oWmxpcmhWL0ZucEswWTZEaUlySjRRVE9iRXpVVUUrOWFw?=
 =?utf-8?B?b1dXcmh6UThIM1VFaEhQQ0pIZTI2UWxJVkk5WHlHc2F2dm0wVXpmbGltM090?=
 =?utf-8?B?VzFsTUVnMVl2N0xGMTkrdUNUSlVyaG9SN3JVWU02Nm94QkpPTTJHNGg2TVRv?=
 =?utf-8?B?djF3d3JtUWxpYVloN0lXNklySzBiditUZmtWa1VuVkpJNkM3dEtxN2pwd3hP?=
 =?utf-8?B?RXFBVk91ZExZYWZvY21tb0d1SGxQK2dyMWJRcG84RUlHNlRnOGJpOTlXWDZG?=
 =?utf-8?B?NmlCZjdPRDA0REliSVZtUGwrY3AyUzhKMUExS1Fja2R1OHFSZXRhak05UWlP?=
 =?utf-8?B?VDlHNmdOaXhoT1VObE9BVnYyWjNTRVBSNUpnZElISnNIK1FFN01OWTd5RlM5?=
 =?utf-8?B?QTByS21pdWo5bTFDQWdBcUF1bzlBOUR5eHh5VW9ROVBQZlNwd1dMSnU3cDds?=
 =?utf-8?B?VEk0Vk0wQ1NFS2wyS203VUt1Qy9JaWdLdHQwUkpGbUZLcFNWZHlHWTE0M0FD?=
 =?utf-8?B?OEUxejlqTUUvUnAvRGVQcWc2K0xDUkVFQ1UrdEFYYkRkYXU5L29qWExQWU4y?=
 =?utf-8?B?a2lOWTlkUUJoVDFIQ2l4dlB4MGFNdExQazduWTdjSkk3S1psbW5nNnNlWk1J?=
 =?utf-8?Q?0a/mhdMSWqA6R?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1BsU0d1Q25DcEVScDhBSGxhMTNlNEt4bTk5ZU1jYjNQUXYrbHQ5ZEdSR0Zy?=
 =?utf-8?B?d0ZlZlN0cVpncFFEa0RLWndDUWszQ0I1bHNDdnFHVjhZakdScWh4K2c4ZXFt?=
 =?utf-8?B?V2dsL3F0bk5DVm5VNWt5NUFWcXAyVjNXT2I1OXkzYVZCTTdRZHZkZTNzdFVO?=
 =?utf-8?B?TThpcFJkWVRBa25vS2lOU25iMndYbTBRTThGamVyaGdRTzU2YU9RcW10TDVR?=
 =?utf-8?B?a2hFYkVwcnBBVHB6RDJyc3lEbkpiNm13MS9odzkzUExaYVpOWTRROWR6QmQr?=
 =?utf-8?B?MDlPd2czOTg1ZjFzRkFsZzYyR3c5eG1RbncyMXlWMUFkUU5hTWtVQUFVQW5j?=
 =?utf-8?B?bURoUEF1NUoveEVkYzVoSE55cDBXTkloUXRySVJDa044UDdPV3poN3Jvb3Jk?=
 =?utf-8?B?RFB6bXhaYkxuS29WclVvclVaY2QrYi9nQ2w5aGtiUTQ0VHAxVTBVLytxN1hv?=
 =?utf-8?B?Y3ZoTFBIbWR6Vi9kU09CV2NaLzA1dFBrSHNRR0N0cFd1N28yMk5RN253UjUz?=
 =?utf-8?B?ckovV0M1TnBENDBDcFFLSER5ZlFWNStGbkllSFdnNXU4dXI2Rk1zVU9UUE9a?=
 =?utf-8?B?eVBJT2xsSjFTQUUycnBKenVYTUY2Z1Q4SmRhQWRCQXZWWEhtYXRHRlpBdlB3?=
 =?utf-8?B?THdsVW9EZ2o4RFFvOWxUbEp0N1FLOXBERjFRMnRKa2lCcTVQTW4wZzFCVUFB?=
 =?utf-8?B?Z0ZDeEtOeTFkOWFUM1Z4S3RtUFV2MlpVUUowZTdydUZkUG5ZZFEyZTBNcDAx?=
 =?utf-8?B?b0gyVURuV3ZuRWRjQ2hBYXJiV0pVenpMME1YQlFkTlNNcDRaN01pQVI4bDRp?=
 =?utf-8?B?MEx3UjgvUnRuNGswUmxJanZZWTBoaFRIcUtQL1kyNC9GeUxjeGxZSE9ialIx?=
 =?utf-8?B?M1NXUk5FN2k5QkQ1Z0dMckhDQ0JQaEc4a1c3cTcxbTQwdWM1UWdpb3paQjlT?=
 =?utf-8?B?dlpYMHp3c2hxTC9xbXNVK0k2b21KZDlGd1FsQTVRWGtCc0tQeWZrVXFIRTRz?=
 =?utf-8?B?UnBMR29YdWF2dzFidWVBOTJmYmV3TUVUSEE4RnI4MHhWZ1JqeERHS2Q4enFS?=
 =?utf-8?B?SjRjWUFtR00zRGZhbWxEcFRZVm5WSXFGdmo1dkY3VFh3M200S1FmK2d1YnBk?=
 =?utf-8?B?Wk9zRzRYaEM3MTlQVzZRQ2xZQXhPSEVyZGVhZ211V29HY2czZ0dBclpZZnZF?=
 =?utf-8?B?U29qRWxUSFc5UlU0dkRHbzVsSEhLOUhwTzdaS2x3SFhKTDI2NGNIWVNoblFB?=
 =?utf-8?B?NWRPemRha2NiTWp4RUczUHRmTlhjQis3MjlBcmNVNWhQeEovUzM4Y1EzK0tD?=
 =?utf-8?B?ZDQvQmlvakU2cCt0akFxMktuYnJFOVFGNC80aHc0NFk2Yi9wTFNjQ2I3cVZr?=
 =?utf-8?B?MjUzMXJ1bW1sbFJpTW9iR2xiWnV1Rld2dVg1QWdySGJ4WktzV1BqTENZYURL?=
 =?utf-8?B?U3J4c2lCaitjNEdaYms1UEU3SElnS2pWN3o3SXpJZzIxRDBKSkx6dGJqcTZk?=
 =?utf-8?B?WW5UMUU0d2ZFb29KODV5bzBoaSt6bzl1bzM0eDdiTG1yUCtSR2cvNUlvUG52?=
 =?utf-8?B?bFRlbXh1ZFROMlRSd1lCOVl5dkY5WmxJbjAzQ0lXRno2L1VRaCtYR1h1WURj?=
 =?utf-8?B?WTJScWx3bTBZbTdJR01lMDdNSkN1SjhUdVJDL1B3ZmlsN3hBQTE4VUJoNG1i?=
 =?utf-8?B?ZjlDMlcrUlpMZzlzV1dZaGlFenVwYWwzSnAzZFRFTnpFeHdOZnR5eVBWbTF2?=
 =?utf-8?B?a0x2cytRNzFsSVpjaE9QcUpFMTlxaE1RR3BhaFMrdlA3S3VQOXJObWNuRlh3?=
 =?utf-8?B?MTN0WDdXZ2wzc2ZEOWlRd204OUd4ZXlmWVAyd21mU2RyTzVidldSbnFIODlF?=
 =?utf-8?B?bmU1alNmZlliOHE5Mng2TUk0ZFNxY2w4Q2hxSnJTZDM1cVpONE5jQWorc0VB?=
 =?utf-8?B?YjluUXF5a1l6ZXcwSCtLV2VzVk93ZDlvU1RWKzFGQUZ4azRQTUJoV0xyZFV6?=
 =?utf-8?B?OE1KYW1sTTN1UUNyOGZqVlV4K0FlV2VtQ1JKRjFMbXZ0V3BnMWxLU1lKbTBm?=
 =?utf-8?B?ejY2ZW4ra2NhUjRlS2Q2eExZNGNHSUM4RmI3UkxpalQyUzNyWnd2aDZuZ05m?=
 =?utf-8?B?UTB1TnlVTXNOWXRsbjZzL0JNcUNNUW1scFp2UTdCSFhEVGs1eXFhSVVlOFdj?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pWohyYhtHcEGZ3th6HOFPOxF/J8jwMcO7zvpwvuzab90ogldyWHvsWS/3HSpyrYfy6IwuQPTsjpxhF2BF46LHizKrXEBXCWWPUPZjQ9Qz+PZqn4otogGWbZaxH4vdDtdxLF4MCgil+CbKecGctb8RBWy0uRyRqUlcXjQiLfL5heKaqCLxbNQFunbLfR/om7dSnk161kDseo7qVpXUDly3eTLnoZH9+IBWyTKwV72MmNANWhSLxI9LZ4q9wCcVvayDQEtP1U2qcZBf48SLoNE6Yi5r6WywfiIGXKn1fEdGDxyEbD8JRFx6m90sjYuMc28q6GsxFI8AkzP/Ve5yoC09p0XCosd8qKdierjK+WWkgpO2pLPuoZ3j22Vmv8pC+iWP43G3TSuoub+Eg/le4PfX3OJD1HmXTsoka324HQD+rKJ422YG9I+mHVUCtw9NgBg9wFliN20tGpaYZn/92ET+zXNfdhkAgsperdIxD2z+l7DOHGF8VhUYaHwIu2FBGp+pjiOsvcM9eYso0qlcb8ntBPxJSzz5kmnBwKasDjAMmuyoW1HzAqTRlqSNcqlmP6KaGJfQRtF+BtwA8bJmFpDPD4mra5YDuwJ1vOmza5pXtQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4dba35-d306-4b28-208c-08dd3b1c80b1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 19:39:36.2925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CEFQdgiy/CFak4pbFiLhOM6DEwbrN+zqGguJvlSLR5FzCPVrwEnzS0MYdX3LeAw2IhNmxaNysPEvAX4Tavbg1X+oTrXOcfPmyFmWSUnQ4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_08,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501220143
X-Proofpoint-ORIG-GUID: s9BHm7NA8-C4-dSwGS2qaimYmUprF71N
X-Proofpoint-GUID: s9BHm7NA8-C4-dSwGS2qaimYmUprF71N
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.043,
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

On 1/22/25 09:01, David Hildenbrand wrote:
> On 21.01.25 23:54, “William Roche wrote:
>> From: William Roche <william.roche@oracle.com>
>> [...]
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -3655,6 +3655,7 @@ int ram_block_discard_range(RAMBlock *rb, 
>> uint64_t start, size_t length)
>>           need_madvise = (rb->page_size == qemu_real_host_page_size());
>>           need_fallocate = rb->fd != -1;
>>           if (need_fallocate) {
>> +            uint64_t file_offset = start + rb->fd_offset;
> 
> Taking another closer look ...
> 
> Could likely be "off_t".

Right.


>>               /* For a file, this causes the area of the file to be 
>> zero'd
>>                * if read, and for hugetlbfs also causes it to be unmapped
>>                * so a userfault will trigger.
>> @@ -3689,18 +3690,18 @@ int ram_block_discard_range(RAMBlock *rb, 
>> uint64_t start, size_t length)
>>               }
>>               ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
>> -                            start, length);
>> +                            file_offset, length);
>>               if (ret) {
>>                   ret = -errno;
>>                   error_report("%s: Failed to fallocate %s:%" PRIx64 " +%zx (%d)",
>> -                             __func__, rb->idstr, start, length, ret);
>> +                             __func__, rb->idstr, file_offset, length, ret);
>>                   goto err;
>>               }
>>   #else
>>               ret = -ENOSYS;
>>               error_report("%s: fallocate not available/file"
>>                            "%s:%" PRIx64 " +%zx (%d)",
>> -                         __func__, rb->idstr, start, length, ret);
>> +                         __func__, rb->idstr, file_offset, length, ret);
>>               goto err;
>>   #endif
> 
> Thinking again, both error_report() should likely not have the offset 
> replaced?
> 
> We are printing essentially the parameters to ram_block_discard_range() 
> -- range in the ramblock -- just like in the "Failed to discard range" 
> range.
> 
> So maybe just leave it like is or print the file offset additionally? 
> (which might only make sense in the "Failed to fallocate" case).

I understand that the start value may be clearer to read than the global 
file_offset. So I'm slightly modifying the error message to show 
<start>+<fd_offset> (without space) which would usually be <start>+0

For example:
  ram_block_discard_range: Failed to fallocate ram-node1:f2db000+0 +1000 
(-5)

instead of:
  ram_block_discard_range: Failed to fallocate ram-node1:f2db000 +1000 (-5)

The length notation isn't changing, coming afterwards with a space -- so 
that it continues to match all the other similar range error messages in 
system/physmem.c.

I also align the "fallocate not available/file" message to show the 
extra +<fd_offset> after the <start>.


I'm sending a v3 version now.

William.


