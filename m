Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D1CC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoU6-0000ys-Jx; Wed, 21 Feb 2024 10:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rcoMP-0000wC-It
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:18:14 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rcl0k-0007Za-8z
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 06:43:46 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41L9iGPH021488; Wed, 21 Feb 2024 11:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=QUhJ/NFYNAAXdeXUVN1+sGjWk5iH/spMqFYFWLwphOw=;
 b=IpeaFLKAMtOvcOg+OkqID9yYdrE8gZaMN3ZMFS88C8OH8G2RQX4eEEyMbYzs5hKF5b8U
 vmd5lSFnem3MiSa6SM6jioL3MNqtn7rGHAfDgsD3syTIp1VQWwsDJwpl5PIU2kgSLdcM
 TbQf3YiS9ESbAUay33t0kKspoRnvaPNpBNzmRZI6nu5U0ZnV/wj2Cq1qBqv4imw3Mw5C
 xioVZHQSkfQBEeHZXm0ry5/LvyVoegbfcX8n1sU1hG8bv4PmTybyShX9fxirGZRkvuID
 diRAWZ7PqXUbdji8nczRPeeVU0EMhTwsOjBKgyYKZ6B/D9eKjWitU6SOuleFq+lg13Rv Zg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakqc9gtv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Feb 2024 11:43:29 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41LA26Oo020995; Wed, 21 Feb 2024 11:43:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak8962ef-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Feb 2024 11:43:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mt26Zngy82uiJaHa3ehRVWP5fP89m3xf1Gk+1gPKri4ZufBqMljkWQXUcaYIW1LQW9d65NPAgLfa7EmoVey12PfrvJ33hMbWYP8Pqn/qUvFTQI1JorOgnjvZObsfCic2psOEXLnvwihrEonhbUa/RnAVDa3laxOFPHFFBKqRaVneqh+uSItIlJlyT9RKVTmXVemVlApptpFt1yy4lyhMsWljfNWpCES4QO5ErlpeOsAzTv3VtsarwEZOM9QFGBm5iYVAqzvX/xsqZnlmg8rdMV2L3MFGp/kufojJnaSdaGnjsLAOVKibi77yu6TypVR2jXduyaN6lcYZN31KNlw7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUhJ/NFYNAAXdeXUVN1+sGjWk5iH/spMqFYFWLwphOw=;
 b=RNuKjUfJfl8TpcK3EVeRjeqXmGfWjPmaJC41NSQso2vUZOv2OCsYCY9edaOWIYJmgk61Qbt/XQLh+oGWCqDw35lUOtBpUrXuzieWpogpX5QUvyG7ayhziljq0qn1ZvuUunUKsvlJ1kQhRYcjw9kX6pfaSuLbyMyHW6OP3Ex8lQkDp61LbFprmeuDgqBejUvjSM530FXB70qU2J7i2FoPdDKX/eIXwQTLCpUym+ITP/3SyZaqB3zWXfYJ2YQ4VHDINDV5bSr+4JYyXgd1T4HUK9nTrbKVwV9A6TObVxfpqUcXomc6IYhYnssjZ8REhEA8iO//PXXEo2eoLqcQC2JcIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUhJ/NFYNAAXdeXUVN1+sGjWk5iH/spMqFYFWLwphOw=;
 b=Mc8E0GO4GeX8LLTbZrsDBmYWSh29m/u9BljaRyQqn2IBE8eiJgLLWDv2Ewsxwrpt0BKNVsdBkiv4OTK59jIUCOXK84LzUokfhW8uqc1yKXS7n9hQ1gU2QPzcTFtswDJ3ZtA1KncsEzYR6ZvAYOst2MC/Lz39QQzFyqfsYpYK9yk=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by DS7PR10MB5197.namprd10.prod.outlook.com (2603:10b6:5:3ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 11:42:58 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3%4]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 11:42:58 +0000
Message-ID: <178d53f9-26bf-4e78-b670-223c30be7b14@oracle.com>
Date: Wed, 21 Feb 2024 11:42:51 +0000
Subject: Re: [PATCH v4 0/3] Fix MCE handling on AMD hosts
Content-Language: en-US
To: John Allen <john.allen@amd.com>, pbonzini@redhat.com
Cc: william.roche@oracle.com, yazen.ghannam@amd.com, michael.roth@amd.com,
 babu.moger@amd.com, richard.henderson@linaro.org, eduardo@habkost.net,
 qemu-devel@nongnu.org, "peterx@redhat.com" <peterx@redhat.com>
References: <20230912211824.90952-1-john.allen@amd.com>
 <afc99063-1916-4a0c-a763-f515a4595e73@oracle.com>
 <ZdTg5y6P0iuNYzZZ@AUS-L1-JOHALLEN.amd.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <ZdTg5y6P0iuNYzZZ@AUS-L1-JOHALLEN.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0306.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::30) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|DS7PR10MB5197:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ddbdf2-bc35-406e-3c9a-08dc32d24047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SdV6yJFoLIqPTAePKv8X8wu9yh6OS8bY7vvhDNRARSXVQU98UhS6Zr06oHNU6KXD9y30TbJ1KcK3MaTrjvp7+ekdY91MqMn0Sx67spr6nUh4g7KIhZ8obmxvK3xMbnmbVTc7/xtKjXncYUho96tl13SCWlSTueoRv/VxT5u2EivN/jwwhKGmY4sBYhUEjQuOFFt2Xis4SKRvMV5Bteh64S/BUbIyPm0WciL36UXRk9DYYPsqD/8DObN3Q6H1bROHnrK4r4A8kfTqFdKf1Og7AdBYZZL4MAzVvJJEbpwQ0EJ7qug1Z8T5mwyvbpcODkn+pXiOao89XymNH5KoxzE1b/QzU3xXltkQ5Dv5mTqWi6LnN367Aj2E0b5Tsw5T5ZDoBBfqiPON8Tz5hUPGhaY9BO/fWZ8ga6FyMmT9Ibdkdvw0R8rArWsnSa7+lnxgbKDq40p9imQu/mfDCmnIxSCZzPePT4uSWWO2zTily/PEXxTVOIFoHiFPHbOc3LPeX00i8LN3gfVT9ATsknEwjs+smQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW1ZVitwb2ZDUnp2MEVqVktJRkRQcnRRNWVaNzNxRDNQRHBudHd5eUpCQVI2?=
 =?utf-8?B?QVdYYVA5M2N2TDc4NUZmWGg0Q25LNmY0MFFVU3BBODlpUkxuZ1RIaHFiVElD?=
 =?utf-8?B?azNYMDZKWmpMSDE0cjR3MlVrK1h6dC9lVWJJMUlmeGZHVEFHangvR3hJSWht?=
 =?utf-8?B?ZFp0T0l2NDlNZUlDZG5laWViNDNrMEdVa3Npb3J2UWxjZDRqSnVnRlVIRDBZ?=
 =?utf-8?B?SmJ2cm1UK25UUUZSQ0N3T0FIWmpJNG92dm93Q25oMHlZZkZOYlRKdzVCK05F?=
 =?utf-8?B?UUpmeW5BcmUvWHJ1NExEZXlGZFpBM3RhVk9nL3BBUjB0WHhYVUN4NVVjL0pa?=
 =?utf-8?B?SkJFMDRDTVVpZUprR2ZXenR5VzUySjRXR0YyaTQzamhjMDZaNHYrVEIrYVEv?=
 =?utf-8?B?dkVIZXh3bmp5OHFvT3B1NVkvbTlIU3EvSnVHNkJnbFIvMHMvVHpiR2grVHJH?=
 =?utf-8?B?QnR0ZFhvTDJSNlVCaGlxZFBuU1kxbEVOeGUwNWlKUXpXZTdKbENXVmJ5WU9Q?=
 =?utf-8?B?enVxeWhTYVhsd1NXcWJIdVYvaC9uajFocVYycUFYbnRNL0k2TWNiOXFxaGcv?=
 =?utf-8?B?dXFHZzlZek5YYU5obmJCMXFlTmtoRkxhTkNYaU5Ud0w3UU1TUWdOQTZubWRR?=
 =?utf-8?B?WW9HYUhQbkJUSk90T2Y3SnErODhvdk9BazRqeDd2ZytHSVJVTjUrenJkdWVG?=
 =?utf-8?B?bHM0NGNoSUQ0MFNBcmtpZGtIaWx2UWVLaDNMM0hIUHV0SWozTHRoc2FIVU9l?=
 =?utf-8?B?VEN0VVpwUHE5WUdVbGVDS1dpN0sxODUrcXdZNmVYRWhMVzFjcWpZcllxZzd2?=
 =?utf-8?B?RUtNSGZmUVR6Z2t1dTB1b0R0amZyM1RBYUFBbkVEc2owcUM3NjlQRUNpRHhO?=
 =?utf-8?B?d3RhWm1sbUd3SXRSbTh3a0U3Y1NST3JjdnZxOUdPaWF0TjhaKzJhN2xHL0Vl?=
 =?utf-8?B?S2VINU4zandYUWdRRlBtMkxrNXRmRTZLTnRZT1orWXc3U0JJeDB4RU5MYy9u?=
 =?utf-8?B?MjFkQ3d1enE4TjZTM1VjdHlrWkdZdWRJcjROQTJ0NGtMb05pcmo1amJvOTly?=
 =?utf-8?B?VGdsaG5veHc0WkQ5S1Awa1NyWjUrSnJSditxZ0RhdXF6NVBHdUtXbWhUaE03?=
 =?utf-8?B?SldVQXY3My9NV1MyWFNuUjdIZmJvVy9rZUlteWl5endxbEhianZoY2ZFYVcy?=
 =?utf-8?B?b0hVSSt3RFZQaVgrKytHd1p6aVNYSWtPZXY0TUZ6QzFsRHU1emJzdFJwbEpM?=
 =?utf-8?B?NFV2ZzQrYmdTc01YcktRdlFHUHVyRzViOVljb0pTbzZNeXpxQndHeHdEK2pv?=
 =?utf-8?B?VEJWaGVNT01vRytIZXgyNUdSMUxnN0Z0Q09hMWs3YlpCUjNnYnBBc2c2V0JX?=
 =?utf-8?B?aDhXV2Ric0RPaUs4TmJzMEt4amdvcXlqbFo2M2Rkb0F0Mnlyc1FJZkRhOGhv?=
 =?utf-8?B?cm11VlhXRVhEVklOQUxQb3AyOVhhOElSTmVJQWxBYUxmVGNzeXhjTU5jU3Rj?=
 =?utf-8?B?RUU0WEs2QmpQMmhkc0NxWWdKWkkzeXZJY0swTWRoaE5HNy9xL1RUNm9aTUhD?=
 =?utf-8?B?RkpqWU9PdCtFNHFjVE5mN2hTcHBNOGJtT1ZjWkJ6bXo2U3pOMkJhS0Vwck1I?=
 =?utf-8?B?ZDBweUxDVEhhdTErNVE1UCtnWVNUZHU0SGZ1TVg2Q2I5VHhmYi9Nd2tPcUFM?=
 =?utf-8?B?K0UyTmFZN2Qxc0ovMDFGa01Rc3UzOENidDdLZzN3Nnh6a0IxRFo5ZjFPZzJH?=
 =?utf-8?B?ZWx0Rm4wNXhEMDJyNkpzUnppZ1Q2dDhjK1AwY2IxaWZIU2cwYWZCY0pKWmFx?=
 =?utf-8?B?eXRXdUFIRlVSNlRxTEg0OEZMZWF4WnduZW9Tc1I1RzU4MStvcjA5clhpUGFV?=
 =?utf-8?B?dU9HMEYvaXAxNURvMGRNbnptaXhTMGpmald6MnlrTkNEcXg4RDUvLytLcVoz?=
 =?utf-8?B?a29XZDdPOW53WjRQZ2JFM2o3YTl0Q1RqbktUWlRZcVNkZisvRWk2Nmd0K1Fj?=
 =?utf-8?B?b2FKSU9aLzJpVFp2enBHV3FHU3J2Z2YyTnpUb3g1WGh5UFNFRjd1eThTYmc4?=
 =?utf-8?B?aVNVSkFrTy9KdWhCaWFzYWhEbVZES3k2VWwvQ0ZaQjVKYUR5cnFQMWRvZkNX?=
 =?utf-8?B?MDhCWC92SnpxbWE5bXAzVE4yK1E3SmUyZHF5U0g2MkVhZk8xd3Y0OVBLaXUv?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 45GfHsnAjTCHP/37EgFQitdCLPw7uiTjM44HyUm1IfKfff9AusyXfjhSa0nRLwhqzXBOPxGXpLbKD1+ij0iYW2mRkXIO/JwnhLHbuL0hzHgg4NiVP3yGEKKO2LOc33kWHBdV3qmpnjtATaksCuiz+A7iAMboPv4noRBaEXWiyKqXSKBCLwo8zXvEnYUf3WOVQg7Y7Avj3zLoY0fDTX+8tYpDJEUtl3CtrqzWaD97inrpHB6yQ8lFYSgRtpm/qypZn1coiDcUatWUfMd8DRaU9rbUvGAecp/vutK6mr4day2acgSYtGUPMap8tdUnHijO9W/U1cSxgwCoRdWppRrmtF4RYvRCwNBxCvLCMVZkJb7HBsj3G9Q+jE2hLKVYFJkhE8+LY/vF5/474sD7ehBQBiNABLy/p3vEDqqhIWsg/lE1aCQd8kUP6QsAcfzZBXZeeM7SSZmyWOTJsgUwhLnXHXz0ODFBWuVWdxQBr37oKuSlpcKT8/IyUPPKfZ/YzKSUWIHZgklwnwkJ7ZjfEjkJ+EETYIn7DJz8XhnQuNVHq5OR8LqHaAaBl0eso7xV1BZim4HWF8/VzPz6QjnOGWpLfo/QFL9Bo+VUAS42PnXS07Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ddbdf2-bc35-406e-3c9a-08dc32d24047
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 11:42:58.5146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/sFmwiN+jNXQT7JIPWx7lSzq9vORfNKfp5wUe1u65tIqRfuIgw+0BNHQnzEAH6uXN5SvEsI0Z8F9rjSCYwlj538FX1NDxzhAzINB3ox1Ys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5197
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402210091
X-Proofpoint-GUID: wGnT4J7MSxhn8a3EzU1UHPI-XeDrnXgg
X-Proofpoint-ORIG-GUID: wGnT4J7MSxhn8a3EzU1UHPI-XeDrnXgg
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 20/02/2024 17:27, John Allen wrote:
> On Wed, Feb 07, 2024 at 11:21:05AM +0000, Joao Martins wrote:
>> On 12/09/2023 22:18, John Allen wrote:
>>> In the event that a guest process attempts to access memory that has
>>> been poisoned in response to a deferred uncorrected MCE, an AMD system
>>> will currently generate a SIGBUS error which will result in the entire
>>> guest being shutdown. Ideally, we only want to kill the guest process
>>> that accessed poisoned memory in this case.
>>>
>>> This support has been included in qemu for Intel hosts for a long time,
>>> but there are a couple of changes needed for AMD hosts. First, we will
>>> need to expose the SUCCOR cpuid bit to guests. Second, we need to modify
>>> the MCE injection code to avoid Intel specific behavior when we are
>>> running on an AMD host.
>>>
>>
>> Is there any update with respect to this series?
>>
>> John's series should fix MCE injection on AMD; as today it is just crashing the
>> guest (sadly) when an MCE happens in the hypervisor.
>>
>> William, Paolo, I think the sort-of-dependency(?) of this where we block
>> migration if there was a poisoned page on is already in Peter's migration
>> tree[1] (CC'ed). So perhaps this series just needs John to resend it given that
>> it's been a couple months since v4?
> 
> It looks like this series still applies cleanly to latest qemu, but I
> can resend if needed.
> 
That's great I suppose.

I was hoping Paolo responds, to understand next steps.

There's also the other kernel patch that Paolo suggested[0], to declare the
SUCCOR bit in the kvm supported CPUID? Maybe it's being held up because of that?

[0]
https://lore.kernel.org/qemu-devel/d4c1bb9b-8438-ed00-c79d-e8ad2a7e4eed@redhat.com/

> Thanks,
> John
> 
>>
>> [1]
>> https://lore.kernel.org/qemu-devel/20240130190640.139364-2-william.roche@oracle.com/
>>
>>> v2:
>>>   - Add "succor" feature word.
>>>   - Add case to kvm_arch_get_supported_cpuid for the SUCCOR feature.
>>>
>>> v3:
>>>   - Reorder series. Only enable SUCCOR after bugs have been fixed.
>>>   - Introduce new patch ignoring AO errors.
>>>
>>> v4:
>>>   - Remove redundant check for AO errors.
>>>
>>> John Allen (2):
>>>   i386: Fix MCE support for AMD hosts
>>>   i386: Add support for SUCCOR feature
>>>
>>> William Roche (1):
>>>   i386: Explicitly ignore unsupported BUS_MCEERR_AO MCE on AMD guest
>>>
>>>  target/i386/cpu.c     | 18 +++++++++++++++++-
>>>  target/i386/cpu.h     |  4 ++++
>>>  target/i386/helper.c  |  4 ++++
>>>  target/i386/kvm/kvm.c | 28 ++++++++++++++++++++--------
>>>  4 files changed, 45 insertions(+), 9 deletions(-)
>>>
>>


