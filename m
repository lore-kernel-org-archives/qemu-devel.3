Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2928EC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYLj-00077O-5w; Tue, 20 Feb 2024 17:12:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rcYLh-00076D-J8
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:12:25 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rcYLf-0001co-Bw
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:12:25 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41KKSoDe029395; Tue, 20 Feb 2024 22:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=J5i7iQV7oXA5ep61kWsVjutL+7mw/7UT5EVYpGUUSI8=;
 b=TsmwGUEnI2FAtT4zOhkzuAt2lNLhsgEkwuRKH60SgLMhYBldS1PASyV34uovE4zNtZsG
 7UmYER2ky/3PKTIPaVkTuRHayJV+bGQ+qjD5RiFK5HqrcHKTVRavZDQZh41pcXrLo1J4
 /WL3OpInPkfPHJr9zq2X5JDmZMvfaKHRlgWvD6v/tb9exXLEhO3yXFF/80fDkjs7kw18
 e3fz+t86CK8wRNvfegsl/Sr38RvvEK+VrrGKRqV4dnGUFSLuQjgXuy5tLfU+KuFiOkVi
 pOA4AyheWbR4z8P098ZykOr+tUKvjj00u1znPGiBvOun4MflouvEdIgMCEJCbMTQ4eX/ HA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamud08y0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 22:12:19 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41KLIigt021103; Tue, 20 Feb 2024 22:12:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak888w0h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 22:12:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKasg5TcZRtKnCXP3Yc/BXR8nYaGwvx7fML56bcdJi6biH1lf3tl1DyeY/70RiMt6XTcnRjDvwMud3Ga4gk/n6RDLe3SG3MfRmnoC9rzWhJFqYJCXCsLqpkqCr2cycoeVpCRzJdqIiuOcsC7JIQSx6N5kPrfEezjD6QEvcK18ZgJr59WJMSGRUdjDuksU+cNNTeD6uIYrQ5wFHGOTniwmY7gm2OlPEk3Zv6zDzpMC5ebGhIGYByhWaSzZZj1iPChB6Mnf4SMJXBsh0wRuPs2zqEA5OR81Wtli2D4S7Mn7W7qJyuO1U1C27gYAE3vA9sxpT1/cn+abpwiS4OUCI0w+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5i7iQV7oXA5ep61kWsVjutL+7mw/7UT5EVYpGUUSI8=;
 b=I4tBJyj5Z2xkEicmpdxgDpXK85hX/h0nq4ICcQqt1eDzCY384uDz+4287yAp7yoRvqTAzkh1rYW9BhlpxE/z8CMiyR1VGhNq0ykvsfGKXqRv0yBX1GmmNVAxq2k5sIPDeNJ4HK7SzDWzL6M962aA9WV/4GSj/ESGzJBxKkKqgH1k6gTjNm94e6xXL5kn59BR+iBNd+yUhYxVqHN+0IA/6xDjKfugUCRq+D5RkWPPw48LW88cUig9TAO6Hw326yzv22QXY4YqNdlZ17e3cUu1lYV+EUy0Q8QQxmU9bADwlMZ/BLDJlsIJb8TtVLINvTn7f2j6lX+nf0vZA+9/kr4sgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5i7iQV7oXA5ep61kWsVjutL+7mw/7UT5EVYpGUUSI8=;
 b=Px40lWPQWMU5jJ1KZ9X9WmgbhmSfaeHD+EU85gnaaYgB2/NLrMzWpPFeCaukLdAbYUohoZfD0+r6/sMvJpbhRmD6tX/0lDaPvXRqJjsWeeWU/Mcqg4/Rf6iuavlG+g0eT5+P5cqFmtnwAIvybaipGtPENW1MVaLaWHc+0fTMMKc=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CH0PR10MB5067.namprd10.prod.outlook.com (2603:10b6:610:da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Tue, 20 Feb
 2024 22:12:16 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 22:12:16 +0000
Message-ID: <f604468d-2e0a-4381-8dab-913afaa5b04d@oracle.com>
Date: Tue, 20 Feb 2024 17:12:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 09/13] migration: notifier error checking
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
 <1707418446-134863-10-git-send-email-steven.sistare@oracle.com>
 <ZdRQ35ygQU4rUgnD@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZdRQ35ygQU4rUgnD@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0118.namprd07.prod.outlook.com
 (2603:10b6:510:4::33) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CH0PR10MB5067:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e1f6ed6-fccb-45ea-4030-08dc3260ff65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPz7h0bbDdZEq5Dfe5MFKiA/EBZhpMOhx45s+S2sR2b/IYX098Oks7rZZ74TcK1bL57nWqcw/Fo09+6vhujLv8UyqDW/KISMjhWhQMIFw9Wp10KF5epgR292rG12i5PGYUc6FIYdMlZhyT5GuIYbbyHyw3jANweqv6v/olvdR9q7KjS+mxbHqJKcLa+SEuqkrKhxlvz1cdflyfeFP3hRcsFdk9Sj42X0q2EskP3DNNL8tPE2eRJd0lHkIIaVrsvEE/xcEpCx8hw7xu8QT2YU2WfjTBt5KtlLUp1wdqzivjAVBM/VRv2ZDh7SmhLS9KYYt/JHKjEgfOW4E1x+WxSAToprvMI2wi/iHUer+Jau7sgHIOM/wQ3HXuinFgpzZSAedQ4l87zKD6hd72sMeNohUs+VEbTv0ib98TlqzMwmri3ZFeuWJ9UkCT7BUWUaoPNRrKdyu7YRCJmQiZ+aqgpORpcKYQvTNv8c7xlxtGbuq0glrtj2oMJ1izYLLnLxZ65KH041n2KVRRe5Gu6On4M2JlUr4cxjs8t6Ov3kIWXaSYg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjlHTnEyVEZweEZEMnU4RXpYaVNvZGhZR0NaUVdxaE5ydDZDYWQ3R0dUL3Nu?=
 =?utf-8?B?NFllK1BNZDJkOC8zUlpQNzlaWXJlU1gwa0VMOEttSWt5dUJlc1pNRTJ3RmNw?=
 =?utf-8?B?TTZOa2s3K0ZmTnhSTC82ZmJzN3hsWk0rT25CNitSU0tJbkZpbU9HUzhDUlRz?=
 =?utf-8?B?ek5jajVYelVua05Qd3ZaSjd1QnZLSS9jVmVaOERRZllDOFFtUmRyWElRbjVo?=
 =?utf-8?B?bVFIcGpnblJaeE5NNlVXSHlMZVZ3aHZpYlFBYnNBcTlvV21wUlRjNzBSenBT?=
 =?utf-8?B?ekhsQURTcUM0UUZRK0svejJLQmo4VnJnOHpCY2ZjTFFOODR0dnFSWW9UY3hB?=
 =?utf-8?B?OHFFMWdSVkc3ZkpvSmtyN1NUam9LdkNQeVk4Ky9MMTlZOXMrV21NU0p1ckxY?=
 =?utf-8?B?c3NxVittUS82SnFTeVFid21oazBIRzE0N2t4NEM1S3dsZW9HNVA5RS8rVWcv?=
 =?utf-8?B?Q05WUGp4azVGWGtTMk1pOG1kbS91TEY2L3d1QjZpWUFsb3gvYjlxR2RPUjVP?=
 =?utf-8?B?SHkyVnptR09EWndtT08xRFpWKytUQ1FVUGhPVGJJbXRVRy9GUkFVckoyUWtI?=
 =?utf-8?B?dDFJUlI0QkxYQmpIcE8yWkFOM0hhcnpqZHg5aHBMUUw0bDlvMmlJQ3IwdXov?=
 =?utf-8?B?WGFSUFdOQW5TbWN2ZEpGUllLbXlZeDI2ellFL1hiM2R3ZS9ETHlhRFg3QTBt?=
 =?utf-8?B?MHlNM1ZiNjRYWEtLSytwRFpHQTVyVCtwSGlVb3c0MHVLaUZpbEZWR1pNY05a?=
 =?utf-8?B?STV2TkoySGRxcUNFT1hrK3BJeEkwQ2VkVlN3NjB4a3g5K0JvT0h2NEE5Yksv?=
 =?utf-8?B?bE9oM0IxSE9zeTZxMTA0dndIQWpxZTdXWnAvUEtYVHB6d282enFvUW9EUzI0?=
 =?utf-8?B?WjFZR2lUbHRwUWRBVTI1cmJ3TnBBem40cmVUU1dQOVRrdnh0aGtZSjdIZTNI?=
 =?utf-8?B?NHlrUktObTVuRmV4R0VEbEhhbHoxWldtTzJ4ZnBIZ0pOWTFWOTRxVGNXTFF0?=
 =?utf-8?B?clQzMHIyZDRmckVHeE5hL2UxUWJhZVhEVHVhREpPS3ZjRmYzNmZVMHNFVE5z?=
 =?utf-8?B?S3c1UktTVzBLeUg4TjJIVVlkcDZMZk82R2lUdnh5REZpdCtNMmZQeGRWYVZY?=
 =?utf-8?B?WkxTanJKVFF0cGQyQVZsZkpzcnk5NXJoL3c2MXJsQ1hOZUh6bllDSTFxWXFI?=
 =?utf-8?B?TWJHVUJHWk5hYlJ0cXRqU0FUWklxSWI1V1RzMXh0ZnY4VjF1V3hnVjE4UE95?=
 =?utf-8?B?WHZlYUJ6cHFtU1R6TmtsUGlRSmJkSzdDd2N1d3dtL2k5Zm1BMlNrZ2F4TXFx?=
 =?utf-8?B?Y1duSDlqZnpidjVmL3JrdUJ0WCt5YlBmWUl5UGdzQzdRUXU0a2RuVjJEbmtP?=
 =?utf-8?B?WjJoUFBObVJsNVBVUkpodXppY0VmTjF3SFJXSSt0TngvazZpRzd3VXRWRUhs?=
 =?utf-8?B?UmpXYzBzVFNObmY3dDYyNGVGdHg2SVB2dmhWRUtIRmdXRVh3ek14QVhmRkJx?=
 =?utf-8?B?ZHp6Nkw0YVI0c2VIY2hJWW9rNWhtK1dKQ1VtNmErOGhwZkJERWxEdDdaZFk2?=
 =?utf-8?B?SDUwVXB5U2RNNU5KK3dGQWQ0QU8rRG44Sm45eldMa3BCL0xQNkNCakJsNDVI?=
 =?utf-8?B?RDlDQ1MxUDJpb3JncmVXK1BlSTdXaGVkTnhBbys4clFyaDcxNlJYNnN3ZzlO?=
 =?utf-8?B?bE16SURLRk8rTDAxOXhteTNpeHczajVwQXpBc0dBS3hhU1FvRlhIYXBNcExH?=
 =?utf-8?B?VStsdmtLem51cCt1MmpKcVBDWEpZT2lWOTAvVVZuMi9ON1gzNjBQNmlaUU9C?=
 =?utf-8?B?UG13K3V1ZW54STVwU3VBODJ1TWJ1T1k1OE5Oa2lOdWFQUkVLMUlreWw0YlE5?=
 =?utf-8?B?RnZqY0t2V2tDZ1dFU1dqYjA0TnpwZDUxTmcrYTl1OTZXcDU4dDZmN1F1NzJG?=
 =?utf-8?B?OFo4L1VPMEpFZmVQZWhYYnNFaUdoeUFUSFBWczgyWFcvUEE1MUlWNTRLbW9Z?=
 =?utf-8?B?TVh2U25VMmI5U3ZRTWc0d0pMZkhSS21OYzlFSXdKSlFqU29NejJzQXJiU0Nw?=
 =?utf-8?B?ZjFBSnV1dUxBQ0FkelRadk9hTUl2VjN5WHhKR25rLzBaS3lCMTE1WWFXS3FI?=
 =?utf-8?B?VTBFbkdVNlVYYkJXYVlPRW5pTHRQR3poODJ0d2lnQ0ppSlJrYWpqUDFUT2pH?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /iPVQTIPCduk9nDsLC8s2fUyhkDowDoRuwBx5EhWTmzUZP+9FQ2IZPjPB8Jwv8zKTolY9MOZ7VPDxDfzFyIGWn4QYNahbowM5DI/DCzYvpjd61i+js0tZ3JoP7IIQlcji8dCwPeANhGmeCn5g88LJuxx+IGZYEisMorizpIv8zhOw4dqiBjx1+Q6iD7r4ugLgaHUsd351w/M/hVOYHqeJmg7aPLadhsEwRdGtxPWLM5jS2VWlPMcz06SpNxTuJCUNA67Scl5E/hv83bpCRR3ZrmgJPs7A43m5KqtqatNsbkA3obmo21/KCiAZwJu+IDpg/vqGv7++tMxSq3H6KEtrEwvmNKqJlV7Ylgha9HdbXNL1mV6fBwuXtbcJpy7nmMgnvFKdEh1av0U0DNoP63egii7iFq4Mzw5fiYYSVHipbdRJv14VWTONO8az5Axt8GXlNNaOQtPcPTxx2Tvi1AxlodPeKctipX1xV8bspzfJaHcrzqnao1Gz79cuk2OAar/xUESNQHn+1iqRLr0KsX97WqagvZbopAil+kZIpsANF2ntjB5abA49yNeuyFZG21jF0aMSeRAw7vCJSGCi3K16fim92Ev1AItPqnIVdDfcu8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1f6ed6-fccb-45ea-4030-08dc3260ff65
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 22:12:16.3988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzaoWSb4sgl1sjtEsHaNs0+bS60E/NjDtNKNsEb5OCnsfeY5Cda6EL+aB/OvwyMN1oDw2sxW8Muq85EDt1DaX5nS0vcH997Vn31YEfeaw7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5067
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402200159
X-Proofpoint-GUID: oivEC3NXAlp7EMpMWjFbMp63ePkcw-Xs
X-Proofpoint-ORIG-GUID: oivEC3NXAlp7EMpMWjFbMp63ePkcw-Xs
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

On 2/20/2024 2:12 AM, Peter Xu wrote:
> On Thu, Feb 08, 2024 at 10:54:02AM -0800, Steve Sistare wrote:
>> Check the status returned by migration notifiers and report errors.
>> If notifiers fail, call the notifiers again so they can clean up.
>> None of the notifiers return an error status at this time.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  include/migration/misc.h |  3 ++-
>>  migration/migration.c    | 40 +++++++++++++++++++++++++++++-----------
>>  2 files changed, 31 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>> index 0ea1902..6dc234b 100644
>> --- a/include/migration/misc.h
>> +++ b/include/migration/misc.h
>> @@ -82,7 +82,8 @@ void migration_add_notifier(NotifierWithReturn *notify,
>>  void migration_add_notifier_mode(NotifierWithReturn *notify,
>>                                   MigrationNotifyFunc func, MigMode mode);
>>  void migration_remove_notifier(NotifierWithReturn *notify);
>> -void migration_call_notifiers(MigrationState *s, MigrationEventType type);
>> +int migration_call_notifiers(MigrationState *s, MigrationEventType type,
>> +                             Error **errp);
>>  bool migration_in_setup(MigrationState *);
>>  bool migration_has_finished(MigrationState *);
>>  bool migration_has_failed(MigrationState *);
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 01d8867..d1fce9e 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1318,6 +1318,8 @@ void migrate_set_state(int *state, int old_state, int new_state)
>>  
>>  static void migrate_fd_cleanup(MigrationState *s)
>>  {
>> +    Error *local_err = NULL;
>> +
>>      g_free(s->hostname);
>>      s->hostname = NULL;
>>      json_writer_free(s->vmdesc);
>> @@ -1362,13 +1364,23 @@ static void migrate_fd_cleanup(MigrationState *s)
>>                            MIGRATION_STATUS_CANCELLED);
>>      }
>>  
>> +    if (!migration_has_failed(s) &&
>> +        migration_call_notifiers(s, MIG_EVENT_PRECOPY_DONE, &local_err)) {
>> +
>> +        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
>> +        migrate_set_error(s, local_err);
>> +        error_free(local_err);
>> +    }
>> +
>>      if (s->error) {
>>          /* It is used on info migrate.  We can't free it */
>>          error_report_err(error_copy(s->error));
>>      }
>> -    migration_call_notifiers(s, s->state == MIGRATION_STATUS_COMPLETED ?
>> -                             MIG_EVENT_PRECOPY_DONE :
>> -                             MIG_EVENT_PRECOPY_FAILED);
>> +
>> +    if (migration_has_failed(s)) {
>> +        migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
>> +    }
> 
> AFAIU, the whole point of such split is, allowing DONE notifies to fail too
> and then if that happens we can invoke FAIL notifiers again.

Correct.

> 
> Perhaps we can avoid that complexity, but rather document only SETUP
> notifiers can fail?
> 
> The problem is that failing a notifier at this stage (if migration already
> finished) can already be too late; dest QEMU can already have started
> running, so no way to roll back.  We can document that, check and assert
> for !SETUP cases to make sure error is never hit?

Makes sense. I will modify the patch as you suggest.

- Steve

>> +
>>      block_cleanup_parameters();
>>      yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>>  }
>> @@ -1481,13 +1493,15 @@ void migration_remove_notifier(NotifierWithReturn *notify)
>>      }
>>  }
>>  
>> -void migration_call_notifiers(MigrationState *s, MigrationEventType type)
>> +int migration_call_notifiers(MigrationState *s, MigrationEventType type,
>> +                             Error **errp)
>>  {
>>      MigMode mode = s->parameters.mode;
>>      MigrationEvent e;
>>  
>>      e.type = type;
>> -    notifier_with_return_list_notify(&migration_state_notifiers[mode], &e, 0);
>> +    return notifier_with_return_list_notify(&migration_state_notifiers[mode],
>> +                                            &e, errp);
>>  }
>>  
>>  bool migration_in_setup(MigrationState *s)
>> @@ -2535,7 +2549,9 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>>       * at the transition to postcopy and after the device state; in particular
>>       * spice needs to trigger a transition now
>>       */
>> -    migration_call_notifiers(ms, MIG_EVENT_PRECOPY_DONE);
>> +    if (migration_call_notifiers(ms, MIG_EVENT_PRECOPY_DONE, errp)) {
>> +        goto fail;
>> +    }
>>  
>>      migration_downtime_end(ms);
>>  
>> @@ -2555,11 +2571,10 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>>  
>>      ret = qemu_file_get_error(ms->to_dst_file);
>>      if (ret) {
>> -        error_setg(errp, "postcopy_start: Migration stream errored");
>> -        migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
>> -                              MIGRATION_STATUS_FAILED);
>> +        error_setg_errno(errp, -ret, "postcopy_start: Migration stream error");
>> +        bql_lock();
>> +        goto fail;
>>      }
>> -
>>      trace_postcopy_preempt_enabled(migrate_postcopy_preempt());
>>  
>>      return ret;
>> @@ -2580,6 +2595,7 @@ fail:
>>              error_report_err(local_err);
>>          }
>>      }
>> +    migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
>>      bql_unlock();
>>      return -1;
>>  }
>> @@ -3594,7 +3610,9 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>          rate_limit = migrate_max_bandwidth();
>>  
>>          /* Notify before starting migration thread */
>> -        migration_call_notifiers(s, MIG_EVENT_PRECOPY_SETUP);
>> +        if (migration_call_notifiers(s, MIG_EVENT_PRECOPY_SETUP, &local_err)) {
>> +            goto fail;
>> +        }
>>      }
>>  
>>      migration_rate_set(rate_limit);
>> -- 
>> 1.8.3.1
>>
> 

