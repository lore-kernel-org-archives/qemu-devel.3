Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFE4C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYSQ-0000VY-Ok; Tue, 20 Feb 2024 17:19:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rcYSP-0000VM-BC
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:19:21 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rcYSM-0002N1-QJ
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:19:21 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41KLgX2o005528; Tue, 20 Feb 2024 22:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=vQONtpXeN3+HLJXDeYINbvXkj960iumyPa2QDJ1UFbA=;
 b=JLZNYdopVCeDh9+2lvhOpcg3LGg076nTGxtLZNOL3Hkz4yLeeVXVqbzX2myYkAuM26Xf
 I49WZTMUHGwfebrDBmTdgM1clGxZAHVXm2gy0I6/xGckYgIkd/fYhkCr1s4C97b6IUB7
 xztAj68W/lJ4l3OVaxqiQqjR8DnQVxJCAvlA2VL8j5400GzPjjJwag+2K8CFDOtWvY2D
 y290iTeGAOA12bCivetMxeZsH2nRdQLMlrRUFbyWZPNc3/6/jetJHxNgUbrtF+jfaD5P
 pigbhXZet+hZxfmA+p0CdgujMwoZX5/XveVZfjpUHyCAENrs5bwzijTvbbVk+t38ALi1 3w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakk40ass-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 22:19:16 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41KLnu4Q039716; Tue, 20 Feb 2024 22:19:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak881mqq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 22:19:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfE1At5VVOnZtEfkITiNlflgY7Ud0FJQxWY6sskX/+BL1rmutxCKAgvp9b1yWBJUfNo0B4oxFwJ31Wfs+Jv9x4Gi0ZlfWA7DzK5EsqVcQSSppxgdr/HXdEwJ4M3GfXlkpToAeqOCb1dDKnI7C2w2Rjmc4GW05YaFqvlgpIKgnGUHb/8eokuywPI7hldegZOjcCoDMzH8xr3PJlpyQd79JWqaXBs0a7t1JiKaRMuCUtdT9crDJjZ2lJSvcMNgZNqcx9Eoa5M35fFqZvcZdMhcuPkT0id23CJ92l5/dF+VnPRtB/TxwMeRjAe9YqEPSKAEIlUJDJEAHzmAQppoHdXz9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQONtpXeN3+HLJXDeYINbvXkj960iumyPa2QDJ1UFbA=;
 b=DjWpIoT7z4xF+k5+wTvzr0M3r6ZfbcGDU3htNwTe/2gq1RKSyrNTRboiclng+o526yTyMSqK3tSDlOM4dcOReeIuHHoVWj4GNtyVbq6LDHHqMU2PveIL3TN278JdDfrIUeyU9tmY976QNg1WVDmwtPNSlxz3Qx0fzR3B8hjCtVmXWG9KWt94ttrbyAoBK7k6lhTK8LmfXN4wKuOmAiWt4hxogU0SI4F7Gj8IUSXsBhc+CnVW+qhz6wxl4sYvmX+M8x3mG6x0wURCgz2bedVbRr48rOuaY3jd5+eoqomVWpGlhADrnsHDyzue+xD66f4B98d0ubLrOgKjC5O6T2MSFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQONtpXeN3+HLJXDeYINbvXkj960iumyPa2QDJ1UFbA=;
 b=BjTLC4cxtSCNsKE8jqoA8CZenL+GcwOSKqyVUtHFCpanzuOeG2CEGUZymnioKhLkhfB4ONT+JFkCdBIDaDs04XdM0v1MUzaYiP5AsXmsu5SbcDRZOZ4ReybtBy2CAd0KMBmU5HWvpQoBiFNjPM4oEpzdcjs7IjaPZJA4b19cX9U=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DS7PR10MB5005.namprd10.prod.outlook.com (2603:10b6:5:3ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 22:19:13 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 22:19:12 +0000
Message-ID: <238ef383-a94c-44b8-b142-a95f7b57632f@oracle.com>
Date: Tue, 20 Feb 2024 17:19:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 10/13] migration: stop vm for cpr
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
 <1707418446-134863-11-git-send-email-steven.sistare@oracle.com>
 <ZdRVz7gvh-qGNxXZ@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZdRVz7gvh-qGNxXZ@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0037.namprd20.prod.outlook.com
 (2603:10b6:208:235::6) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DS7PR10MB5005:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2c0547-225e-4b67-ff72-08dc3261f796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: miM+pfwop7tf36TJstw5IC6LbbyNSL2ePiQFaY09i6aXn63mwWrC2zw9CVRYD2xslN1lnlucC0UKNDG9sIVjQWL7oSDZDr4cmhJzDXsSTQf3SJKQLF9RIuohNXs4oenlvUhbcFH4Wle6LSnWiUi7RcTVxCTPbwY3ozjMlpURX6mKIKWmSoANiXuIRyG6pZAfrGTg52LaaP0akA/eyccXiun2JZP1w4Y5aW9teHkgX5kHOTsGywt/vxokizKlOOoPOQe+lfivqEwEMcelt+ZZrizeF81ZZKBGkmzOhbipoh11hPhOZ1c1+tJ5dUO95fvRZReBUXufgKherEBI4uzBmCVBuiOGbQMeFxj55mWlXEVu/KX34ylRDBNF+DQ9/0rzbh4vyfN1ihxkuXgPjeBQf985XZsVvG5HW9B5IH2nlKvexEfSlCqYh0ZkBfFYsvFhuvG5FkMMOcz1BKjmXid9tC1ZAsXwIUc1cLNuaplkenWUSL483xLLdBsNP2Ls4tHNaOmBV4eU4PhhKc2pJddS9hRgPsrq50ti8VNDdSQ9z3g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnBWMFZDV1ZGL2lBOWNXZVQrWnRXK1NKVXA1MjNIQldBVFZlcW44dUxOb21s?=
 =?utf-8?B?TFpTcnlEb0xTZ2R4dGtxR1hYYUc5dWp4NVIvYUVDT3RXbVNSWW9lMmtnOFZy?=
 =?utf-8?B?ZXVOQ2pPckxHeWpCS3NFTDBseGdsUU10ZEpEKy8vWCtLbUpJa0dlVFBUSTRV?=
 =?utf-8?B?LzNBaDE1WDBqR2o5cEM2cjh1dWtHN1lEUDVzdk1jZzgzLytPeDd1WVcvc2xK?=
 =?utf-8?B?QWNTVkZwOHo0aDNReU83RytMaVovZlpnTjR2Ly9hREpFb3IzbVl6NUVLdWMx?=
 =?utf-8?B?OGhoUlMzZjI4WlIzSSs0SjdINDhuWnB1eno0QjA3ZzJFOGRyTklpREFjR2pQ?=
 =?utf-8?B?V3Bob2RpVGJ4SGkwMEFpUk53UEtUT0NBRGRhbkYxVXpRaUpjV05LbjZGTEhY?=
 =?utf-8?B?V05DVVIyTTRCSjBXNmM5Z1ZTdW4za3o3SHAreXNiNkNnNWJOZ25rWGVYemFk?=
 =?utf-8?B?NnZrK1BOcmtkU0tLdTE4VGVTYWk0dmVoVXZTU1hTSGFrWmZaSmFKNTViaklI?=
 =?utf-8?B?aUNRdlJlUDFjbEZFTEZFVG0zVkFKRFg0b0MvdkgxclVvNTkySHU4ODlwQ0kz?=
 =?utf-8?B?dDMrQm5pYlpsbGtFWFBES2gwYlBrUDA2MXVnWDNsVERSU1BTcmpGcnVxTlFk?=
 =?utf-8?B?YnJHWXBFTnV0RndXbHcvSFNDWjFBSzQvcEV5Q2lONTF4cHNNWm1GY2oxN1BL?=
 =?utf-8?B?a0J0TE52c2ZHb0VNS2I4bDc3REVseHNIRjBNR0xVTVRJSGpKa1ErUkxGNTR6?=
 =?utf-8?B?MnNIbHhVZThSc0JDRzBNLy9aL2lXcU9SbFFLMWhNS3VRWFNnVUFWdmx4eXBK?=
 =?utf-8?B?MlVvZ3ZBTUsxUTNvQVNrbTVpYWRZVTJaVW1sL09EcFl3U0JXZFd0Wld5M0h1?=
 =?utf-8?B?TklXaXoxU2I2Y00wNEFzakhKTllmMXBaQS82b0t2c2dRc1pOb3pYcVF1NWV5?=
 =?utf-8?B?bmxOZzN5T2FSMjVBMzFrRXV5cnNORmZ3UkpVNWJLRk5wUGc5c0N3ZTBzbGZE?=
 =?utf-8?B?K1JEVlRvdGtJM1FFcitMaERHOW5yblcxcGhaOXFpaUlTMTFncWVzdis2SlUy?=
 =?utf-8?B?R3pBMWViRjVtN2ZNaUFMd0JzWEJVOFB5VlZSa2Q3U1BlS1o5WDExQlVKNGZS?=
 =?utf-8?B?VFFyTEV0WW9sMFV3QzFmRWYxM0NHQ0dTM2N0ek8wbW0xTFNvNlR4K1E0a2VD?=
 =?utf-8?B?dVRPKzZKb3I0SWN5RFN5TExETksrc1hjQlEzdmR1K2FSK3BRUUNwMjhaZGEx?=
 =?utf-8?B?UGkzNG55ejB2aWZSeVZqbVN6QVZHaEhweXBsSlkxRVg1STVrZzZBNUVMRmo2?=
 =?utf-8?B?cVphdStRa3l4cXN1RXQwZTUxY0VzdnNrSmVQL1JtV0NiMXFkUExzZ3BHNHNP?=
 =?utf-8?B?anJ1OHBZWkVpUHREd211d3VmdW9aUmdXeDI0bE4ycjQyMStvZ2xONk4rRWJX?=
 =?utf-8?B?U2lobGNhMmRhTnRqOXNJV3JmL04xQXRYRVp5d1BZcTl0Vis2TFpUd0RxTktu?=
 =?utf-8?B?RDlIZktyZUtQWTNlT2kxSW14N0l4OTdNTlpTK0VFd1FYYkVwS0pHZkVvMTVW?=
 =?utf-8?B?NklzcUJaWGQ0cFZtS0V5VUZSSWFpMzdUV3QrVTJUVmlwd2hFT0tleFJtNWd0?=
 =?utf-8?B?Tlk4dFVDRUpTWno3VlVDMmlSZW85YXBMMDRuQzV2K1N6U3FjSm9YS0FEVGhu?=
 =?utf-8?B?UVBqZVZSWm9DSWQ5ZVRqd0lrc0FORUVzemkxcFZlNkpVSFRxSVZzWmQyNDBx?=
 =?utf-8?B?bjN5YWxBVFdnakxqeGtBSHF1dVczUzFTdUpTUytTS3JxQlM0RS93OVUzWGZr?=
 =?utf-8?B?SGRsaDRveHluVlJhZFpmMXcycWEvZXUyeXdRcThwVktEc21Sek04UTgzREJI?=
 =?utf-8?B?UVdQTzFMaWQrZFp3V3hyQzBYMVFkYUFIQ1FDaTJPVEMxR002UHM2SnpXVGk0?=
 =?utf-8?B?QjB4aUxSZnZjU054alFDVmJjSmtUL3VMUXRqL2pkT3JHb21VZGF0RVZGUGF3?=
 =?utf-8?B?TUt2N3hwQ3RGdW5ROWFhbkJYTTIxVzdSVjZMNVN1RWpCb2poQkU5dTBzc0ky?=
 =?utf-8?B?eUZaRVM1WTMrY1o2Wjd5QTZISnRTcU52ZVl2aU1zb1lydmlNdkxVbUZscTZ1?=
 =?utf-8?B?MzFtcmJsK3dwMVZlZWVUZzdHTFBHUlU0R0lyUWljZ1oraE5GanVmbThCek9K?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: o2Wm61VABoNvSHC5z4+Yznqj2KxuAvx1Zt4Sp+WOt9HmxWxNi8tLxWvEMEvO3yl+bry3D3hQCXDvRAFgF9pyxCIIN8BRgtT3w+OibFbK75W0asAN34C8OQoGB5UQWSEhSuzQUXtDH+DpRF3fDKW2o/JSkvghZMfBsr8YGp1nZIvBuCr1Sn6WeyxEM/6l7pwvujz/N5JkU4QcsU1eyS3AIijtT7tT7zCVjNWUVfyt4lLkyweLOLvH/Hej1R9dN28ptV/YOg4F/AGVYK9GFQasCZA5JPhuhZ0dxeI+KMJvIBi10OQRGWjuubfxKOis37ZBoRjeTloGOGWymCpzx921j5RMRmOEfuFdTJZcws7Hak0gji4WFlFt9ZPXZjpZx8ARUaA7sPo9WexMuAQTcQ//1atkH1sRGU7ZhMpcl1n8iEsE5XKYKZGQVdMuoDqiq8W5z0cFP85TQha7yXf1Y5DItKS+Tx2JrKp5bYFUAE5UuPpZpgD53viDB0VzOV5GzaLPkiMp2eCqxQ41ROLUs9ejEp4MejTWlSCF0Yo1jyxkdZoXVO5G2JXJr8cOro2+6gd6Z6/6Fo3sJUp1xEzKl1GgZC25yfIJEVgUvnzPGMjgpR4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2c0547-225e-4b67-ff72-08dc3261f796
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 22:19:12.8518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uucdy+yTCAcPwgRyCNdsvheC32sz+MhSziom/RruJskUTmdr/tGT34BHg+OmBqXTBppirpkJObfYoL/wuLZ+5ixrd5ME3jtibiclOBfwWAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200161
X-Proofpoint-ORIG-GUID: zfPT71IJjjNKTgoXBSRKpKYf2VPGJu7v
X-Proofpoint-GUID: zfPT71IJjjNKTgoXBSRKpKYf2VPGJu7v
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/20/2024 2:33 AM, Peter Xu wrote:
> On Thu, Feb 08, 2024 at 10:54:03AM -0800, Steve Sistare wrote:
>> When migration for cpr is initiated, stop the vm and set state
>> RUN_STATE_FINISH_MIGRATE before ram is saved.  This eliminates the
>> possibility of ram and device state being out of sync, and guarantees
>> that a guest in the suspended state remains suspended, because qmp_cont
>> rejects a cont command in the RUN_STATE_FINISH_MIGRATE state.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  include/migration/misc.h |  1 +
>>  migration/migration.c    | 32 +++++++++++++++++++++++++-------
>>  2 files changed, 26 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>> index 6dc234b..54c99a3 100644
>> --- a/include/migration/misc.h
>> +++ b/include/migration/misc.h
>> @@ -60,6 +60,7 @@ void migration_object_init(void);
>>  void migration_shutdown(void);
>>  bool migration_is_idle(void);
>>  bool migration_is_active(MigrationState *);
>> +bool migrate_mode_is_cpr(MigrationState *);
>>  
>>  typedef enum MigrationEventType {
>>      MIG_EVENT_PRECOPY_SETUP,
>> diff --git a/migration/migration.c b/migration/migration.c
>> index d1fce9e..fc5c587 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1603,6 +1603,11 @@ bool migration_is_active(MigrationState *s)
>>              s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
>>  }
>>  
>> +bool migrate_mode_is_cpr(MigrationState *s)
>> +{
>> +    return s->parameters.mode == MIG_MODE_CPR_REBOOT;
>> +}
>> +
>>  int migrate_init(MigrationState *s, Error **errp)
>>  {
>>      int ret;
>> @@ -2651,13 +2656,14 @@ static int migration_completion_precopy(MigrationState *s,
>>      bql_lock();
>>      migration_downtime_start(s);
>>  
>> -    s->vm_old_state = runstate_get();
>> -    global_state_store();
>> -
>> -    ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
>> -    trace_migration_completion_vm_stop(ret);
>> -    if (ret < 0) {
>> -        goto out_unlock;
>> +    if (!migrate_mode_is_cpr(s)) {
>> +        s->vm_old_state = runstate_get();
>> +        global_state_store();
>> +        ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
>> +        trace_migration_completion_vm_stop(ret);
>> +        if (ret < 0) {
>> +            goto out_unlock;
>> +        }
>>      }
>>  
>>      ret = migration_maybe_pause(s, current_active_state,
>> @@ -3576,6 +3582,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>      Error *local_err = NULL;
>>      uint64_t rate_limit;
>>      bool resume = s->state == MIGRATION_STATUS_POSTCOPY_PAUSED;
>> +    int ret;
>>  
>>      /*
>>       * If there's a previous error, free it and prepare for another one.
>> @@ -3651,6 +3658,17 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>          goto fail;
>>      }
>>  
>> +    if (migrate_mode_is_cpr(s)) {
>> +        s->vm_old_state = runstate_get();
>> +        global_state_store();
>> +        ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
>> +        trace_migration_completion_vm_stop(ret);
>> +        if (ret < 0) {
>> +            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
>> +            goto fail;
>> +        }
>> +    }
> 
> Could we have a helper function for the shared codes?

Will do.

> How about postcopy?  I know it's nonsense to enable postcopy for cpr.. but
> iiuc we don't yet forbid an user doing so.  Maybe we should?

I will assert that mode != cpr in the postcopy path instead, to prevent any nonsense.

- Steve

>> +
>>      if (migrate_background_snapshot()) {
>>          qemu_thread_create(&s->thread, "bg_snapshot",
>>                  bg_migration_thread, s, QEMU_THREAD_JOINABLE);
>> -- 
>> 1.8.3.1
>>
> 

