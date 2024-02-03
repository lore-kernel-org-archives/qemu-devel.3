Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D15CC4828D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 22:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWOjq-0004bv-CW; Sat, 03 Feb 2024 17:43:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1rWOjo-0004bc-LW
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 17:43:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1rWOjl-0003w2-Vt
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 17:43:52 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 413LSuR2000377; Sat, 3 Feb 2024 22:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=xCTvHMbx/KpC6Q6YxJigo4Neke7o0mU4jejU7+U6Tmg=;
 b=CpSr0B5vHuIbP0KgI9XRrgwfYRQVTHfjUNMkIhv5Bd8PmKGTMxlwYPIBIWEosRv4W1fL
 vAsAtWWfyYFh2+0qm/SyWX3e52JgHcWcRmkyRCiITS3SmrlSl20mSs416pdrft9YYPZs
 Jssqo56GoBEU0cAaUhwd+yTp/NNzV0NXQ0XgnTZGi8tdc0GigTyMc4VW2lIa9xAwjXOi
 5X3+Qu9gJOU9UUv8w6Z4Nz69H6fg0p9CrlvNG+3wgcYdMnAGafgj7tBr9t1NeEiY+DGa
 R/kNp3uob1YQLJPbkv4ai1LyNBJTWhWvIu6/LfkEe0bvR1heag0tUS8oV7VQRdp882vs kA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1bweh92a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 03 Feb 2024 22:43:46 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 413L3VBm019855; Sat, 3 Feb 2024 22:43:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w1bxab8ym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 03 Feb 2024 22:43:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sqsgq1IRlhDSTvrDx6hq8g5gzGDYR8Br81QMVe7pK+k/CFIvqAxw8KEqsNvI2ilFSeMjknu8BADVBuIb4ukvjX3IctKx0qgzqpcH5NexYFx2dJVxmEE5E18s3W1uzaFG8lkj1vC5nXZ/wkxRQ05mzqaw9812vRkpOcu6FJablUnMgv+dR+5TLzbbelHkuRa1GspzzASGUyc7JW8IOIuaKyQXBXsmek2s45CsGMhm0mkb/Up1zbG+jvFlg8kMs2cu2BgluTe0hzSsux22vMJq5xSYkkQnIFyo39lTaQUKO4JQrW405OHaMawQKpSr/ww2XFNLh/VMVALTq0QisB/AzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCTvHMbx/KpC6Q6YxJigo4Neke7o0mU4jejU7+U6Tmg=;
 b=CrldyUbyel3wx7tjbvupgb7XdH9Q7kjfiJGD3zMm9+S4C9mwwa4ujUe/xzOSO8rQTkkUxqfFCZRYGtX6zrP0Hr+u/8RkP28I0a0Rcbh2qfW9vlJtkAPlr2km4vdUubqzAT9sobQCN+PMJKOCd6acyCJs1+TyMaXpDEGMWbL9hyJdYBKRAuiwIBsm5sP1vUE1BWtor8suB5vDGp6ADYvyd+CEJ+8jUl+jSrbQI5t/kq2nBBgVlgu5OCQKi+EZWhWin7d1Lki+gKEZNsjea0PCL3YsCH6PK+Ubkei/S8SHNjVuzjdCY4o5cZ9WBnbWiSIt17oapp37c6hsdNI3QcgMAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCTvHMbx/KpC6Q6YxJigo4Neke7o0mU4jejU7+U6Tmg=;
 b=FjqS38wfICcqoBoMphgLlwzqf3jiCiFs+jYjpzU/p2c1+9uY4dtb5ASCRlvRmiPaH6H92Kvfb/AuhP/S6bWBGsK+ghjyw4aiW0s3oEh0Ria8T/bntTRH0sNZnsM9d90Py48vQcflPhvbA6efew/qpPlehkkjPROoOAnvViHEp48=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by MN6PR10MB7492.namprd10.prod.outlook.com (2603:10b6:208:471::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31; Sat, 3 Feb
 2024 22:43:43 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::a1c5:b1ad:2955:e7a6]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::a1c5:b1ad:2955:e7a6%5]) with mapi id 15.20.7249.032; Sat, 3 Feb 2024
 22:43:41 +0000
Message-ID: <8bec3d5c-03a2-02bc-ffff-4b46beeb206d@oracle.com>
Date: Sat, 3 Feb 2024 14:43:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 1/1] oslib-posix: initialize backend memory objects in
 parallel
To: Mark Kanda <mark.kanda@oracle.com>, qemu-devel@nongnu.org
Cc: david@redhat.com, pbonzini@redhat.com, berrange@redhat.com
References: <20240131165327.3154970-1-mark.kanda@oracle.com>
 <20240131165327.3154970-2-mark.kanda@oracle.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20240131165327.3154970-2-mark.kanda@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::38) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|MN6PR10MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: fdeb81cc-b610-4348-45a3-08dc250991c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VDT1SULabA/InVYIIXFbFHMGO0Cksdj2E9b5cbpg7YtIc5FLe+d2dkKpjwu6NrCVJh2LJDy4DmSP5BZo7hLpVNS4uacU/FuQgNFfW8bAwGJdblOKAdjuO5FETULwAlc+LBDr8i/23bdXMiLSDtRKu1yFE+LPiFTtVhLqDvkV465N0IR/oDuXj5aHmHlPRsPTNN1Wh8H0RxXMmpas4Q5Q6KoX6e1uvSjjrdag8zmRuO13GIIwmVHeFRt+O8Z2prIMZdH86p68bdd5WxsZ81ncebRJL3ddyHm/kdwPdvCZP3897McMvQFUQ4CsHqmfRl5OMMG9iXf1Uxc854ziQw/c255RMqEu2gAhcN1EymiNUsP5fWx/pUXdNosVufuYqdc0Eb2lfc2ivXjR7e46NQUqZyrn4GpOqvaet2iSvkV3hlqCa8355JGcrqb0ImZJPY+39OgCh5haC0fM/z2CfkdaSDiaobXg+27Hg+1hwb9x4rXawELKRFo4uXqH0DyObRGOi2NbobJDHyXfSAe5IRTLB73w4T/rWkPlqW+SQKQLD7e9fPG8u9IXNDXYTkY+4DREeD5zJFfbL2a8IL/2OUuyGRav29LRIHU4ZGndUNpbraOEkvDSSkHQ7uG4hTEuewPPsGd0ep1DJSUR2u5qzj+PsQDJxICcpyAVmObExHvdM58=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2663.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39860400002)(230922051799003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(2616005)(6512007)(26005)(41300700001)(83380400001)(31696002)(478600001)(6486002)(6506007)(53546011)(86362001)(6666004)(36756003)(38100700002)(44832011)(8936002)(8676002)(4326008)(31686004)(5660300002)(30864003)(2906002)(316002)(66946007)(66476007)(66556008)(21314003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE05dWJydkgxa3VCelBhbEVQd2NGSGo2b0hyNHpOek5NeVFXQXpRck9KVmRI?=
 =?utf-8?B?Z0sxMDV4MWthRjhvdDJOVm9XeWRCUWw2N1ZpS0w0bkh0SmY0ZWNKT2pSQ2tH?=
 =?utf-8?B?STFLUWhPM0pDc2JKUjFXNnduZ2h2QTVpanN5TVBCRytwZjlTcUJVcnFuQ01j?=
 =?utf-8?B?NVQ0c0c0M3ZJSXBYWVFQVVZ5Mnd5SmY0dENSemV4bkFVSStDTjVuRWU0VFJw?=
 =?utf-8?B?VVFENnFXYVRvcExURlRETWh0YXUvMit3NHZNQ3Mzd3NGVUJsQWUxWG80cXZG?=
 =?utf-8?B?ZXB6MEcvMjBSUklJSUd2UTZQOUhoc2E4UUMzUmIwdnhwc1hVMlJCK05qRWFQ?=
 =?utf-8?B?UVdPZEt4VWxjTnZGUitDQ2pyR1dXOFR6ajFwKytsUnI1UzNIRytzaEpiUzRz?=
 =?utf-8?B?RU5ZejBwU0hQcVl1Tm5aQnUwdndzSkFaYjJSMkh5Tm5wVEJKY3hUSXo5Z09L?=
 =?utf-8?B?UjhTaUFaRFE1cFR5OUZWUDRFenk1MGtDWnoxaUEzQUQwbExuTG9WVFFqZmxi?=
 =?utf-8?B?WmkrR3lzRnpGaFBJcXpoSFc5dWhGZVRvNVRQY3c0ZnQ1VXA1ZVF4ZTR5UTA4?=
 =?utf-8?B?Wi8rYnpHU3dtdWpxdEFKUHMxUmZMWStCNVNoYTdsK25NZjErbW5FeUplVWIv?=
 =?utf-8?B?WndvemhremJER2IzWjVqT0FaN2VPZ1RMelF2SVZLbFNLVWlsVjl6bTdxOXNv?=
 =?utf-8?B?QlZ4ZXhCNTZFVDNJN2kzdVJWVjluMFdrQUZNSXFHU1h3QlZ2YjNvdjYwVHhj?=
 =?utf-8?B?ZVZmSGpaZjUveVFoc0hDK2kxTmZzd2xQYzZQUzJQeXVkVmY3VWVZd2tkdlUr?=
 =?utf-8?B?T0V5Wlh4MENNWkZtbEViS2NQQzNIYjJwVmZyRUxnMUsvTHFubzhscG9WV3hW?=
 =?utf-8?B?YzIrZ3hjbFBZelBsK0g5bE5pcUpnbGpZUmI1Z3hLYW5RMDZrSERMREhKamVl?=
 =?utf-8?B?RWsyaFRxRXB3MWxxQ2FWM0VOUStiNXhNYTBkL0xRRUhrek9rQjU3VzVTQTJw?=
 =?utf-8?B?ZXZOWEJvNWRpbjJOcFBSL3JWVkllMmJwQWF2aUpSdk5JV3JIcHBiaTJLUFcv?=
 =?utf-8?B?NVBldU44ZXFRU2c2TFJ4SllndzNwSU9XWGdUVkpZQ1VlUGg4YjN1cUhiVjVX?=
 =?utf-8?B?MWVnalJnTFJsRVFtbHhZZVFUZnpCekJaVlhpV0I4Y0xlQTNOZzlNektzRFcw?=
 =?utf-8?B?L2VDVTNRVVAwNUlVOWdabFNCUlZQREFQQlU0c2RVQWpsVXdZNGRUUzVUVEJO?=
 =?utf-8?B?NFU5S2t4OHF1NnlnRFFmZFIxZzIxalU0Ly82RlFCKzYvTUl1WjRnUVFIaGJj?=
 =?utf-8?B?bWNiQmlrNXoxN3dOSDNJeU9ybDliLzBFYnJuNXBwc2lCRDVTY0E2MU96dXlJ?=
 =?utf-8?B?U2FrQmszbFFuWUlXWTB3RkIyTVVxV29sVFVtS1FBdTN6M2JEckkxVXUwMi9H?=
 =?utf-8?B?Q0hxclYvTGc4N0Z0Y0NUYmZLMEZGZ3FNU09ENm9Nd2tvWUVLblhVV04wSjIy?=
 =?utf-8?B?NVdjMW5Zb1FlUDlOejczVGdxYlJwSEFMcEJ3czNuclB3bE9tUWNoQlpSMUJk?=
 =?utf-8?B?bmNvbE04OWZDcnFTYUpKYzU1SkNNeTRzNUVGSVhkSXlxNUgrMi9VS0lqSk55?=
 =?utf-8?B?OGl0TVJtek9wZVZva1ZVa3ludk94bFp6K1hnVUV6T1VhWVVBK1I4UDRLTlFn?=
 =?utf-8?B?dUpZYzEzWGdqcmw3RE1IcXYwT1dlRUhOdDlqaXNtSkJJellubHJhRnB1SUQy?=
 =?utf-8?B?VXlBSDlmNmhyVGdnUnYyOVY0bkQ1cTl4MHB5RWVHalh1Ung1UFI4TkNFVkxB?=
 =?utf-8?B?QUdrZXZ5ZjAydDFhVUpKMlRvYXBIQjNjdUJRY0lhTTZsNWNmYkJRZEJLdjQw?=
 =?utf-8?B?c2s4a0NQRXAyZmV1ZTYxMmZSU2pSTHpVemJ6ZlAraWxlb2xFSmhJUDZOS0JJ?=
 =?utf-8?B?OTZjZ2I2cSt4RXZaQ2VUd1FSTFJDdFFxeEI0akEzZllmRE9pQU55SFNHTlhh?=
 =?utf-8?B?a05VdGhzaG5PakZvaHFsMFpaUmFuOGtuNDJVcTRLYU8vTVkxMVhhTWtYQTNB?=
 =?utf-8?B?bmV4bEJhMU03b2dpa3BIMjBZakRTM3BpVWJVY1VCcVR0Q2RROG05eEJmOGMx?=
 =?utf-8?Q?/U1ekJpi2S0ma72kXO/HfVYXL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Bj0qxI6/PBKPcZFc3t26lD6u6AFMyjjXGB+yvv+/2nkbyBGE6q273fcgCCj39r5sdL/YBd50ZPXAEdXqcvh3p8ByOF9qYa/+k2ceqqPwGgzGAErT3feXbaTk0oOIUwHM7hlz41yZITNSjw2/AakYrHKgTqghy3cJ9pVWIOewXAai0FOcpP9gGX5hIa2x2b3UFvR1H3Az/CifkkUAehl4BLqIP1Djw2H4LeOTepa4zgj/df+UKwQqkVxxwct4F6m5ucidF9wpP/GTKDYr6NddaYJnizOgcECDa9S8Vqi1CGGii/IQugywAIwrnhK4xusOnxKPCKKUELuc0FN4e5kyHvdG6vcuI1LqZnU9kGjlJzK8OZf07lsPP2P9U/CcMSxGy7eI7YOOoPZN2KhNLbeBO4hAvMDF1RtZOnx7aND+8WU7HbpO3yA4PNienvt045Cs/wdhoYsZPIgqBU3Sr6zHDLBliGtjH5xnNfalR1eMrdGllnQQyvo27Tj/DlQCg6tU7Qox0m5cVYIgI41DXzRttojiWuNOcO/s7isNZrsBR38nR6IT0BK8oQfLHvH4G4wLDbkwkEjyBT+eTMpzjSCqcect2/JB1QyO8z178qRyQb4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdeb81cc-b610-4348-45a3-08dc250991c9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2024 22:43:41.3141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kGWfeltxg53pb5qHz/IQhR0C5Zdw/i7DeqmzOmk3W0JlGfDrQr76AnXttrzxZbbEVH6W6p3FYdMiUSzjY1anJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7492
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-03_17,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402030171
X-Proofpoint-ORIG-GUID: qB8WNtcwTX6oUlFaw1dj3JIVAT67UWVr
X-Proofpoint-GUID: qB8WNtcwTX6oUlFaw1dj3JIVAT67UWVr
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.509,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 1/31/24 08:53, Mark Kanda wrote:
> QEMU initializes preallocated backend memory as the objects are parsed from
> the command line. This is not optimal in some cases (e.g. memory spanning
> multiple NUMA nodes) because the memory objects are initialized in series.
> 
> Allow the initialization to occur in parallel (asynchronously). In order to
> ensure optimal thread placement, asynchronous initialization requires prealloc
> context threads to be in use.
> 
> Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  backends/hostmem.c     |   7 ++-
>  hw/virtio/virtio-mem.c |   4 +-
>  include/hw/qdev-core.h |   5 ++
>  include/qemu/osdep.h   |  18 +++++-
>  system/vl.c            |   9 +++
>  util/oslib-posix.c     | 131 +++++++++++++++++++++++++++++++----------
>  util/oslib-win32.c     |   8 ++-
>  7 files changed, 145 insertions(+), 37 deletions(-)
> 
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 30f69b2cb5..17221e422a 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -20,6 +20,7 @@
>  #include "qom/object_interfaces.h"
>  #include "qemu/mmap-alloc.h"
>  #include "qemu/madvise.h"
> +#include "hw/qdev-core.h"
>  
>  #ifdef CONFIG_NUMA
>  #include <numaif.h>
> @@ -237,7 +238,7 @@ static void host_memory_backend_set_prealloc(Object *obj, bool value,
>          uint64_t sz = memory_region_size(&backend->mr);
>  
>          if (!qemu_prealloc_mem(fd, ptr, sz, backend->prealloc_threads,
> -                               backend->prealloc_context, errp)) {
> +                               backend->prealloc_context, false, errp)) {
>              return;
>          }
>          backend->prealloc = true;
> @@ -323,6 +324,7 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
>      HostMemoryBackendClass *bc = MEMORY_BACKEND_GET_CLASS(uc);
>      void *ptr;
>      uint64_t sz;
> +    bool async = !phase_check(PHASE_LATE_BACKENDS_CREATED);
>  
>      if (!bc->alloc) {
>          return;
> @@ -398,7 +400,8 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
>      if (backend->prealloc && !qemu_prealloc_mem(memory_region_get_fd(&backend->mr),
>                                                  ptr, sz,
>                                                  backend->prealloc_threads,
> -                                                backend->prealloc_context, errp)) {
> +                                                backend->prealloc_context,
> +                                                async, errp)) {
>          return;
>      }
>  }
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 99ab989852..ffd119ebac 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -605,7 +605,7 @@ static int virtio_mem_set_block_state(VirtIOMEM *vmem, uint64_t start_gpa,
>          int fd = memory_region_get_fd(&vmem->memdev->mr);
>          Error *local_err = NULL;
>  
> -        if (!qemu_prealloc_mem(fd, area, size, 1, NULL, &local_err)) {
> +        if (!qemu_prealloc_mem(fd, area, size, 1, NULL, false, &local_err)) {
>              static bool warned;
>  
>              /*
> @@ -1248,7 +1248,7 @@ static int virtio_mem_prealloc_range_cb(VirtIOMEM *vmem, void *arg,
>      int fd = memory_region_get_fd(&vmem->memdev->mr);
>      Error *local_err = NULL;
>  
> -    if (!qemu_prealloc_mem(fd, area, size, 1, NULL, &local_err)) {
> +    if (!qemu_prealloc_mem(fd, area, size, 1, NULL, false, &local_err)) {
>          error_report_err(local_err);
>          return -ENOMEM;
>      }
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 151d968238..83dd9e2485 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -1071,6 +1071,11 @@ typedef enum MachineInitPhase {
>       */
>      PHASE_ACCEL_CREATED,
>  
> +    /*
> +     * Late backend objects have been created and initialized.
> +     */
> +    PHASE_LATE_BACKENDS_CREATED,
> +
>      /*
>       * machine_class->init has been called, thus creating any embedded
>       * devices and validating machine properties.  Devices created at
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index c9692cc314..7d359dabc4 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -680,6 +680,8 @@ typedef struct ThreadContext ThreadContext;
>   * @area: start address of the are to preallocate
>   * @sz: the size of the area to preallocate
>   * @max_threads: maximum number of threads to use
> + * @tc: prealloc context threads pointer, NULL if not in use
> + * @async: request asynchronous preallocation, requires @tc
>   * @errp: returns an error if this function fails
>   *
>   * Preallocate memory (populate/prefault page tables writable) for the virtual
> @@ -687,10 +689,24 @@ typedef struct ThreadContext ThreadContext;
>   * each page in the area was faulted in writable at least once, for example,
>   * after allocating file blocks for mapped files.
>   *
> + * When setting @async, allocation might be performed asynchronously.
> + * qemu_finish_async_prealloc_mem() must be called to finish any asynchronous
> + * preallocation.
> + *
>   * Return: true on success, else false setting @errp with error.
>   */
>  bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
> -                       ThreadContext *tc, Error **errp);
> +                       ThreadContext *tc, bool async, Error **errp);
> +
> +/**
> + * qemu_finish_async_prealloc_mem:
> + * @errp: returns an error if this function fails
> + *
> + * Finish all outstanding asynchronous memory preallocation.
> + *
> + * Return: true on success, else false setting @errp with error.
> + */
> +bool qemu_finish_async_prealloc_mem(Error **errp);
>  
>  /**
>   * qemu_get_pid_name:
> diff --git a/system/vl.c b/system/vl.c
> index 788d88ea03..e6bc5d9dd9 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2009,6 +2009,14 @@ static void qemu_create_late_backends(void)
>  
>      object_option_foreach_add(object_create_late);
>  
> +    /*
> +     * Wait for any outstanding memory prealloc from created memory
> +     * backends to complete.
> +     */
> +    if (!qemu_finish_async_prealloc_mem(&error_fatal)) {
> +        exit(1);
> +    }
> +
>      if (tpm_init() < 0) {
>          exit(1);
>      }
> @@ -3695,6 +3703,7 @@ void qemu_init(int argc, char **argv)
>       * over memory-backend-file objects).
>       */
>      qemu_create_late_backends();
> +    phase_advance(PHASE_LATE_BACKENDS_CREATED);
>  
>      /*
>       * Note: creates a QOM object, must run only after global and
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 7c297003b9..dada4722f6 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -42,6 +42,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/units.h"
>  #include "qemu/thread-context.h"
> +#include "qemu/main-loop.h"
>  
>  #ifdef CONFIG_LINUX
>  #include <sys/syscall.h>
> @@ -63,11 +64,15 @@
>  
>  struct MemsetThread;
>  
> +static QLIST_HEAD(, MemsetContext) memset_contexts =
> +    QLIST_HEAD_INITIALIZER(memset_contexts);
> +
>  typedef struct MemsetContext {
>      bool all_threads_created;
>      bool any_thread_failed;
>      struct MemsetThread *threads;
>      int num_threads;
> +    QLIST_ENTRY(MemsetContext) next;
>  } MemsetContext;
>  
>  struct MemsetThread {
> @@ -412,19 +417,44 @@ static inline int get_memset_num_threads(size_t hpagesize, size_t numpages,
>      return ret;
>  }
>  
> +static int wait_and_free_mem_prealloc_context(MemsetContext *context)
> +{
> +    int i, ret = 0, tmp;
> +
> +    for (i = 0; i < context->num_threads; i++) {
> +        tmp = (uintptr_t)qemu_thread_join(&context->threads[i].pgthread);
> +
> +        if (tmp) {
> +            ret = tmp;
> +        }
> +    }
> +    g_free(context->threads);
> +    g_free(context);
> +    return ret;
> +}
> +
>  static int touch_all_pages(char *area, size_t hpagesize, size_t numpages,
> -                           int max_threads, ThreadContext *tc,
> +                           int max_threads, ThreadContext *tc, bool async,
>                             bool use_madv_populate_write)
>  {
>      static gsize initialized = 0;
> -    MemsetContext context = {
> -        .num_threads = get_memset_num_threads(hpagesize, numpages, max_threads),
> -    };
> +    MemsetContext *context = g_malloc0(sizeof(MemsetContext));
>      size_t numpages_per_thread, leftover;
>      void *(*touch_fn)(void *);
> -    int ret = 0, i = 0;
> +    int ret, i = 0;
>      char *addr = area;
>  
> +    /*
> +     * Asynchronous preallocation is only allowed when using MADV_POPULATE_WRITE
> +     * and prealloc context for thread placement.
> +     */
> +    if (!use_madv_populate_write || !tc) {
> +        async = false;
> +    }
> +
> +    context->num_threads =
> +        get_memset_num_threads(hpagesize, numpages, max_threads);
> +
>      if (g_once_init_enter(&initialized)) {
>          qemu_mutex_init(&page_mutex);
>          qemu_cond_init(&page_cond);
> @@ -432,8 +462,11 @@ static int touch_all_pages(char *area, size_t hpagesize, size_t numpages,
>      }
>  
>      if (use_madv_populate_write) {
> -        /* Avoid creating a single thread for MADV_POPULATE_WRITE */
> -        if (context.num_threads == 1) {
> +        /*
> +         * Avoid creating a single thread for MADV_POPULATE_WRITE when
> +         * preallocating synchronously.
> +         */
> +        if (context->num_threads == 1 && !async) {
>              if (qemu_madvise(area, hpagesize * numpages,
>                               QEMU_MADV_POPULATE_WRITE)) {
>                  return -errno;
> @@ -445,50 +478,86 @@ static int touch_all_pages(char *area, size_t hpagesize, size_t numpages,
>          touch_fn = do_touch_pages;
>      }
>  
> -    context.threads = g_new0(MemsetThread, context.num_threads);
> -    numpages_per_thread = numpages / context.num_threads;
> -    leftover = numpages % context.num_threads;
> -    for (i = 0; i < context.num_threads; i++) {
> -        context.threads[i].addr = addr;
> -        context.threads[i].numpages = numpages_per_thread + (i < leftover);
> -        context.threads[i].hpagesize = hpagesize;
> -        context.threads[i].context = &context;
> +    context->threads = g_new0(MemsetThread, context->num_threads);
> +    numpages_per_thread = numpages / context->num_threads;
> +    leftover = numpages % context->num_threads;
> +    for (i = 0; i < context->num_threads; i++) {
> +        context->threads[i].addr = addr;
> +        context->threads[i].numpages = numpages_per_thread + (i < leftover);
> +        context->threads[i].hpagesize = hpagesize;
> +        context->threads[i].context = context;
>          if (tc) {
> -            thread_context_create_thread(tc, &context.threads[i].pgthread,
> +            thread_context_create_thread(tc, &context->threads[i].pgthread,
>                                           "touch_pages",
> -                                         touch_fn, &context.threads[i],
> +                                         touch_fn, &context->threads[i],
>                                           QEMU_THREAD_JOINABLE);
>          } else {
> -            qemu_thread_create(&context.threads[i].pgthread, "touch_pages",
> -                               touch_fn, &context.threads[i],
> +            qemu_thread_create(&context->threads[i].pgthread, "touch_pages",
> +                               touch_fn, &context->threads[i],
>                                 QEMU_THREAD_JOINABLE);
>          }
> -        addr += context.threads[i].numpages * hpagesize;
> +        addr += context->threads[i].numpages * hpagesize;
> +    }
> +
> +    if (async) {
> +        /*
> +         * async requests currently require the BQL. Add it to the list and kick
> +         * preallocation off during qemu_finish_async_prealloc_mem().
> +         */
> +        assert(bql_locked());
> +        QLIST_INSERT_HEAD(&memset_contexts, context, next);
> +        return 0;
>      }
>  
>      if (!use_madv_populate_write) {
> -        sigbus_memset_context = &context;
> +        sigbus_memset_context = context;
>      }
>  
>      qemu_mutex_lock(&page_mutex);
> -    context.all_threads_created = true;
> +    context->all_threads_created = true;
>      qemu_cond_broadcast(&page_cond);
>      qemu_mutex_unlock(&page_mutex);
>  
> -    for (i = 0; i < context.num_threads; i++) {
> -        int tmp = (uintptr_t)qemu_thread_join(&context.threads[i].pgthread);
> +    ret = wait_and_free_mem_prealloc_context(context);
>  
> +    if (!use_madv_populate_write) {
> +        sigbus_memset_context = NULL;
> +    }
> +    return ret;
> +}
> +
> +bool qemu_finish_async_prealloc_mem(Error **errp)
> +{
> +    int ret, tmp;

The above should be initialized?

I did a build test and encounter:

In file included from ../util/oslib-posix.c:36:
../util/oslib-posix.c: In function ‘qemu_finish_async_prealloc_mem’:
/home/libvirt/vm/software/qemu/include/qapi/error.h:334:5: error: ‘ret’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  334 |     error_setg_errno_internal((errp), __FILE__, __LINE__, __func__,     \
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~
../util/oslib-posix.c:531:9: note: ‘ret’ was declared here
  531 |     int ret, tmp;
      |         ^~~
cc1: all warnings being treated as errors
ninja: build stopped: subcommand failed.
make: *** [Makefile:162: run-ninja] Error 1

Thank you very much!

Dongli Zhang

> +    MemsetContext *context, *next_context;
> +
> +    /* Waiting for preallocation requires the BQL. */
> +    assert(bql_locked());
> +    if (QLIST_EMPTY(&memset_contexts)) {
> +        return true;
> +    }
> +
> +    qemu_mutex_lock(&page_mutex);
> +    QLIST_FOREACH(context, &memset_contexts, next) {
> +        context->all_threads_created = true;
> +    }
> +    qemu_cond_broadcast(&page_cond);
> +    qemu_mutex_unlock(&page_mutex);
> +
> +    QLIST_FOREACH_SAFE(context, &memset_contexts, next, next_context) {
> +        QLIST_REMOVE(context, next);
> +        tmp = wait_and_free_mem_prealloc_context(context);
>          if (tmp) {
>              ret = tmp;
>          }
>      }
>  
> -    if (!use_madv_populate_write) {
> -        sigbus_memset_context = NULL;
> +    if (ret) {
> +        error_setg_errno(errp, -ret,
> +                         "qemu_prealloc_mem: preallocating memory failed");
> +        return false;
>      }
> -    g_free(context.threads);
> -
> -    return ret;
> +    return true;
>  }
>  
>  static bool madv_populate_write_possible(char *area, size_t pagesize)
> @@ -498,7 +567,7 @@ static bool madv_populate_write_possible(char *area, size_t pagesize)
>  }
>  
>  bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
> -                       ThreadContext *tc, Error **errp)
> +                       ThreadContext *tc, bool async, Error **errp)
>  {
>      static gsize initialized;
>      int ret;
> @@ -540,7 +609,7 @@ bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
>      }
>  
>      /* touch pages simultaneously */
> -    ret = touch_all_pages(area, hpagesize, numpages, max_threads, tc,
> +    ret = touch_all_pages(area, hpagesize, numpages, max_threads, tc, async,
>                            use_madv_populate_write);
>      if (ret) {
>          error_setg_errno(errp, -ret,
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index c4a5f05a49..b623830d62 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -265,7 +265,7 @@ int getpagesize(void)
>  }
>  
>  bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
> -                       ThreadContext *tc, Error **errp)
> +                       ThreadContext *tc, bool async, Error **errp)
>  {
>      int i;
>      size_t pagesize = qemu_real_host_page_size();
> @@ -278,6 +278,12 @@ bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
>      return true;
>  }
>  
> +bool qemu_finish_async_prealloc_mem(Error **errp)
> +{
> +    /* async prealloc not supported, there is nothing to finish */
> +    return true;
> +}
> +
>  char *qemu_get_pid_name(pid_t pid)
>  {
>      /* XXX Implement me */

