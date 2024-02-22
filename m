Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DF0C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 13:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd99C-0003B0-SG; Thu, 22 Feb 2024 08:29:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rd99A-0003AH-FE
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 08:29:56 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rd98v-0003YT-NK
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 08:29:56 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41MBmff5028012; Thu, 22 Feb 2024 13:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=FQi5GyZDsacjT9fjcMx+nLl3pL9+kJomdV3olT+dcFM=;
 b=IbwfcpM8mExq/tY99if/jk+plobPahM30839EX5K+UOkaUe5pYjZAq9vKH4ZokKT5nv5
 5sRZ2rbEa92HHoU3PcdlO6UvzN4GvRJqKr1NRT9i3jw8mLQydj+zA1+7Skq7QOdFE3Ra
 esMreDq/L5bDQDqDsHoiR/5L0fxNDTaCU6Ykzxeq10oLJDJCOivsHULxMLwJkiSZRP1P
 4AUixDw6OChIGxZmCldjUfgP3/GRndRHaqhqZkkpB6zxBNuxS5ufu4Gli6wOj1Awautj
 FuUOJq3sYIuNHYsGxTraBHO0hQmtDcpFiUoH7KKOmddbSxyVxLn8NyRli0jEmlDj2nF6 ng== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakk44qn3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 13:29:38 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41MD8bIT022479; Thu, 22 Feb 2024 13:29:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak8ak6ew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 13:29:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOF/xcAE+OfLkNrC/UsFInyNOtsNH0bjAEkPae6i8a5hJ+XmgHH51yLF3586k0XuKuiHTqHMAr3CTYXNyC5t14P/KMXJYVS9qQTAUDSQEfcsmfpu11Kgxlo61TA312v+dlbNZR5QmwM7hR74KA5t9JxvMsmxfd152tQBEbCh7d5JeFMTmueeEg6XwH92BKV9KFyEpy+lR8PvYMVcwv9GtE3tzPG/QoyDqrVPdoCSi6hNlTDsR3MOYygw0Ik1zijVqywJ8tIxZOtVujb6dcdxGwaDg2TSbSVmuVIZ00G9zRIbrAv5H5lXiHn76huqGWzZy6F15BNO73ypcu1eDwUkJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQi5GyZDsacjT9fjcMx+nLl3pL9+kJomdV3olT+dcFM=;
 b=leVcVrum31XJFwB94v9vUD9cWyYPIjk5POxKanOiFhSk1ceDBpeMtO7OXtS0xfO3uTfm805i0Zm9cFgqT5jzIats0N/zEyOrcfurMrXEq374iqKVYLyunqYdF9YAfjagTz2yvlBkqiTlAUQBwdJhHPmFwK8HHcj+ua0lrtvJxHWZCGi+bzl7vqCnnxYmLWdZB6f74CbVJLTDzjRCuvO1Gz8t8zRJHCdtwyze9etcKJlbGx/qc7nELYiJdNx3T3C2qCTC9qqpL2PaTIoJHWUAp8JC3oTYIDYatwWT/AAQWbUQMY/5lATj95WKQViUq3Fdr5v3MhWriv+PIm3cUSWB2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQi5GyZDsacjT9fjcMx+nLl3pL9+kJomdV3olT+dcFM=;
 b=Bqn/fvCr8UyAZNZKQ9q/wJZnHR8A4WKKskjw7s/rWv+Bo0rDJHj+bY12C7fxefOf/nU1d+rzFAE+A7X4+H75vwOa37kbYe0Od9QG4u3+4QyOWLI///QHoLg+scSvnshphv2Nr8z9BBfYQRTb5OE9cE+gXqFwmqM+Gnfs5bCXka4=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ0PR10MB6432.namprd10.prod.outlook.com (2603:10b6:a03:486::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.23; Thu, 22 Feb
 2024 13:29:25 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 13:29:24 +0000
Message-ID: <79545be1-43cc-4cf6-8553-ed69fbea9c4f@oracle.com>
Date: Thu, 22 Feb 2024 08:29:20 -0500
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
 <ZdRVz7gvh-qGNxXZ@x1n> <91c57365-a61d-4ae7-bc63-454a39c1a6ec@oracle.com>
 <ZdcQFbIJ46sSPf2i@x1n> <ZdcUODYUBm8sfnOq@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZdcUODYUBm8sfnOq@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0089.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::30) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ0PR10MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 474b9aab-8b70-4fd1-27b4-08dc33aa4966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f775Z9iD5ikGP8y/1H1S0leQ3Hix9kJpVKkKa4/DGXT0oZvOQbGoaXuviyEMjP2+XKNy6YKSPqfdmjT7DzP54P4eeex+u1g6oUdI/CqCr+YT9K/W6wuGrZgq7rl4/RiegGUOxpAS0Y1c3xL1VP1GfUVeg45av6SKpT2LsE1r/T8Brebu/pbS+bfC7Xii0VByIwYMXnGJRcRX7jRFtAA2/iVqy5eOpats3EtVBMUjkFFWAxmMPlOD7cLUzZqGHKhwqEhGw8LLtqj851QOEjcYUwy4Q0c1msJsMWanb9g9GygCJqIoKrrlc+zOkQwz4gAEhlKZ5fjDpHnWb0/wzmhyAgQK1+tKhlfnTYFO5gvDbUgjLrhBuv026RoXBzpTNvyVWFMFd8nJFdNw7APF96aovcPLDTYGUTDNM9CnpuGhWcvMO5Z7gMtykjIhP9kmrFcI69rFz2HZ4GumsH0sOtnHOmHwKA29gDEorgPrZXLZ5BMOACMYI9AOouIOjpMo50hebN6hRFFA8/3qztoyv5oGhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzlvSDF1Q01MT2xHWlZYbkNBR2ViZXU4YWxjNHNBOWhKUU16aG5lUmdiZ3gw?=
 =?utf-8?B?S2NJSzVGWjFCSm02OEJ4ZTlWMVNuTmpDa1g0K3lJUHI5T0g1WW4yVWJONVVN?=
 =?utf-8?B?Q2Jic0prcDdGKzkzdkR0OVZ0aGY2NXlXYjFHRWN5NkJlQ29nQUI2dnNtK3dF?=
 =?utf-8?B?clNoNzFBbGdGeWRSakc1eWVsckVMdXprdWxuRGdkNnZMUXBXV3ZnSVZjSWw4?=
 =?utf-8?B?blJ1Q2QrbmI5eE91TWF0Lzh1ZitFRm5IRVl1MkpzSDNUclBEYUhyMGlIMzJF?=
 =?utf-8?B?NkNDbWQwWjBWcWpGS1krY09hYTA5RTh4ejZWZWlUZWU0OENRQ29zRGpYQXJm?=
 =?utf-8?B?QUNlcHdDMHl3Mmh2eGFIaHVXdEI3aWlTcGxka295NE9VSVp3U2EraE9iS1Iz?=
 =?utf-8?B?VGxHQ1RLeHU4eGFwbnNGMmVtRUk2Uk5tV0YveUZFb25WYW0vbDBuUkI4dlBE?=
 =?utf-8?B?eERHNkJxdml4eHh3Yk0wM1E5K2dvRlBnZW1Cc21ORExEUmd0QnZKTzV1L0FP?=
 =?utf-8?B?UUVrbVkzOWdpVEFGWHZWVlg3d09zVW1sRGhxanNSSEt3L01kdXFMcVhjN1VF?=
 =?utf-8?B?RzlIUHNqdkY0cDgzczFTNllwWi9zZWdaNGJIVWJPd3ZoN0syQW14ZS8vSHR3?=
 =?utf-8?B?U3VWLy8rMDk3WCtKdWQvU0RIUCt5NGx2dG8vanFCYXErMVE0SW9YQlZhUEdt?=
 =?utf-8?B?WncycmZGeEo1aWs0dFV6YzVDWGYvVHN4akh3ZUt4eFVySFIrcStNZUF6SUpV?=
 =?utf-8?B?ak5OUm04WitRem9vVkVyYUc4MEpSVjVXR1BuK043NTU3STd1K0wzZG5RYURK?=
 =?utf-8?B?czZqNHUzZ214cWt2dFdJblQrcHdUa0IvNGFxZUFtQnJ1ZHd3aytBbGtFVXZG?=
 =?utf-8?B?TDdDUDhwSW55SXBnOUpsVzNoQ2ZBNmg4OHViQ1Rvcm9zSTllWGFNRTRJM3hm?=
 =?utf-8?B?c2Q5SHBLaUZmdUk0Y2lTYTY1ZG9Tc3hKZEkvTml6LzVnbzRIdC9oTGVMNDc3?=
 =?utf-8?B?QUY3T0F6R25scUdmRW51YnNKKzF3dGZIaXZldWVkU3ZlNjB5R0h4ak94Nkkr?=
 =?utf-8?B?ZFpCd3dIZktabloyNmlqSVNRbVJmeGJQMjQxMXVLeFgrMmZ2NjgwQmxJWHNX?=
 =?utf-8?B?cUl2VTZHLytmN0YzS2RSQ1NnSUJycVBSUXFRM0V0OWlJQVhzUWdKdEd4ejkr?=
 =?utf-8?B?bkVxYWthNFFpSjdRQWJrQXo0WjQxSFh6UG1UV2Q5VXZ0S01zVUx4bytGaW1p?=
 =?utf-8?B?SFZuL3J2VmlLU2hoQUYvMEJla2Q0UDZWcW93eGxyNnRibkVLK051OHd1eVFm?=
 =?utf-8?B?dnlGTEFjOGFFdHRIQ0ZFU0E1bGNyQU9MK3RPZlNkYlVqaDFOcU1mR290T010?=
 =?utf-8?B?Q2cwYXVRU0ZZQ0oyUnZmemRVcHU4dzR3cm5tWVhUVWpSUGEweGlmYU05K3NS?=
 =?utf-8?B?Z2poZGxHNElYVEFrM1pWOExRWm9YTy9QakhyaXVHLzJxcUNyeVFYUVYyd1A1?=
 =?utf-8?B?NHUxUTRQdlViV2tvTjRBQ2Jwa085SjdyN1NVNEU0ZjVUUFplRmgrVjEyRkJE?=
 =?utf-8?B?MTRmcDdzbHY5dlJhZE5sUTZkaEoxRS9EVm9qV0lSYVVlc2VKZ2l3U1hIREgz?=
 =?utf-8?B?d0Njb3c3NDU3ZGc1UUFJSFZFQ1dNYkJUQklYVW9DTWJERFdjT2FqOVpYN05O?=
 =?utf-8?B?aDhwR1BlRVZPK0tBVkRzVzZBVzFUaHNPN3FJcFdIdVE4OXZ0YXlvejlqUkEr?=
 =?utf-8?B?NFRtdFMwaGNXS3Y5TUwxbXhUNlZwbzZ2NXlwV25Kd0FSbzRkbHhtVURCT01N?=
 =?utf-8?B?NFBDQnJOQkdCM3BuODEvY09GaU5KZktoN1VHQ2NYalJ3blM4RGpSamc2VEFH?=
 =?utf-8?B?SUhCOE1GaU1tNmhsTHhxcTVPNlhJbjdMV2RwOWJDWnRtU1B1VHRJbzBwZkR0?=
 =?utf-8?B?bmoxMFFjS2R0bTZ0UUNoVHhNdkNNbENRc0I4WldQQlhKT0x0WjROMVJKR3VC?=
 =?utf-8?B?eWpKZXF1dERycUcydUVFdmpGdmlvVEFkaG1iSmdIaklPTklNRXp3b0ZzdTBI?=
 =?utf-8?B?alRsbGRKYTVVL25tbDlrM3prWHNpNDJmLzlqb3pvT0dYdUtleWp2cWhQOWR3?=
 =?utf-8?B?VndmUnhVdEkxYzFLUXJVdFFEbDEraVgvZlFuWGFQTlduQWZZeHBKanJVd2hG?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: F1RzJbfqONw2q1i4+JjxId0+E2sTBxkLdYBIvxGwVG7wy47JUum3rnaozWoSWmgxccY45ApZ/BMh7qSjdxdlpM7ej27tsPf7Ux24ZMx0GrRxEII32EkL4MuEEOY7x6Q0viHSR+fNlR5BLaZBsNsVGFm2qUo1rdjKVJ6sFzgqStPZUppSu0TxT/1RW3CYEwH9A/EiekCM45q/zGwahMTUQMx1m/QaRW0DcA3ZBDdpKlT23cjnWriXdFDQ8jooQhubvl85Isqww8+pRdcJhfZGlwCiKOo6VMDuiOwaL9d2BKZ8WXRcqArlqfbEszZvmi1+m2ONJpbZUws6O/HiveCXzxjwRONyqGpvtr1ewISmy2ecRpXrbxkkXnJjXTk/a8fmKrdotzTx9e6uXIizmcdOp8YfhxhstP7UJtJuhZGUjVAv2EzsHMUlsRKpETLnKirkPZ+CASuLHAqtK7CFveevs59W/H6BbIjZtwxcSOXAt79h6Ui7fxDPo/ZUNp8bEHKKbTTRCni7ASjUNe3O/sxryNVaElw2emaLFSVARFZIqNbP2/9WTy0jcOuqbmYV/kuDgfQyqOM1VL10eRljOm2D45jJ5u/lSZjyJV0tHIZ+7vY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474b9aab-8b70-4fd1-27b4-08dc33aa4966
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 13:29:24.9706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WakwrH+Nv+bHN8XWugkzD914GWlhZ5tyPxjju/k4yIhsuyevrJe0bVyHnlgpG9NjBTxM1/Lb/TJNNErYvBOESxLY2aADONVIGdjoih0m8ds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6432
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_10,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220107
X-Proofpoint-ORIG-GUID: erREzZNBKoilHg-erpdI9Ov_caQ2NPy5
X-Proofpoint-GUID: erREzZNBKoilHg-erpdI9Ov_caQ2NPy5
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 2/22/2024 4:30 AM, Peter Xu wrote:
> On Thu, Feb 22, 2024 at 05:12:53PM +0800, Peter Xu wrote:
>> On Wed, Feb 21, 2024 at 04:20:07PM -0500, Steven Sistare wrote:
>>> On 2/20/2024 2:33 AM, Peter Xu wrote:
>>>> On Thu, Feb 08, 2024 at 10:54:03AM -0800, Steve Sistare wrote:
>>>>> When migration for cpr is initiated, stop the vm and set state
>>>>> RUN_STATE_FINISH_MIGRATE before ram is saved.  This eliminates the
>>>>> possibility of ram and device state being out of sync, and guarantees
>>>>> that a guest in the suspended state remains suspended, because qmp_cont
>>>>> rejects a cont command in the RUN_STATE_FINISH_MIGRATE state.
>>>>>
>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>> ---
>>>>>  include/migration/misc.h |  1 +
>>>>>  migration/migration.c    | 32 +++++++++++++++++++++++++-------
>>>>>  2 files changed, 26 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>>>>> index 6dc234b..54c99a3 100644
>>>>> --- a/include/migration/misc.h
>>>>> +++ b/include/migration/misc.h
>>>>> @@ -60,6 +60,7 @@ void migration_object_init(void);
>>>>>  void migration_shutdown(void);
>>>>>  bool migration_is_idle(void);
>>>>>  bool migration_is_active(MigrationState *);
>>>>> +bool migrate_mode_is_cpr(MigrationState *);
>>>>>  
>>>>>  typedef enum MigrationEventType {
>>>>>      MIG_EVENT_PRECOPY_SETUP,
>>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>>> index d1fce9e..fc5c587 100644
>>>>> --- a/migration/migration.c
>>>>> +++ b/migration/migration.c
>>>>> @@ -1603,6 +1603,11 @@ bool migration_is_active(MigrationState *s)
>>>>>              s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
>>>>>  }
>>>>>  
>>>>> +bool migrate_mode_is_cpr(MigrationState *s)
>>>>> +{
>>>>> +    return s->parameters.mode == MIG_MODE_CPR_REBOOT;
>>>>> +}
>>>>> +
>>>>>  int migrate_init(MigrationState *s, Error **errp)
>>>>>  {
>>>>>      int ret;
>>>>> @@ -2651,13 +2656,14 @@ static int migration_completion_precopy(MigrationState *s,
>>>>>      bql_lock();
>>>>>      migration_downtime_start(s);
>>>>>  
>>>>> -    s->vm_old_state = runstate_get();
>>>>> -    global_state_store();
>>>>> -
>>>>> -    ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
>>>>> -    trace_migration_completion_vm_stop(ret);
>>>>> -    if (ret < 0) {
>>>>> -        goto out_unlock;
>>>>> +    if (!migrate_mode_is_cpr(s)) {
>>>>> +        s->vm_old_state = runstate_get();
>>>>> +        global_state_store();
>>>>> +        ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
>>>>> +        trace_migration_completion_vm_stop(ret);
>>>>> +        if (ret < 0) {
>>>>> +            goto out_unlock;
>>>>> +        }
>>>>>      }
>>>>>  
>>>>>      ret = migration_maybe_pause(s, current_active_state,
>>>>> @@ -3576,6 +3582,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>>>>      Error *local_err = NULL;
>>>>>      uint64_t rate_limit;
>>>>>      bool resume = s->state == MIGRATION_STATUS_POSTCOPY_PAUSED;
>>>>> +    int ret;
>>>>>  
>>>>>      /*
>>>>>       * If there's a previous error, free it and prepare for another one.
>>>>> @@ -3651,6 +3658,17 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>>>>          goto fail;
>>>>>      }
>>>>>  
>>>>> +    if (migrate_mode_is_cpr(s)) {
>>>>> +        s->vm_old_state = runstate_get();
>>>>> +        global_state_store();
>>>>> +        ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
>>>>> +        trace_migration_completion_vm_stop(ret);
>>>>> +        if (ret < 0) {
>>>>> +            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
>>>>> +            goto fail;
>>>>> +        }
>>>>> +    }
>>>>
>>>> Could we have a helper function for the shared codes?
>>>
>>> I propose to add code to migration_stop_vm to make it the helper.  Some call sites emit
>>> more traces (via migration_stop_vm) as a result of my refactoring,
>>
>> This should be fine.
>>
>>> and postcopy start sets 
>>> vm_old_state, which is not used thereafter in that path.  Those changes seem harmless to me.
>>
>> Not only harmless, I think it was a bug to not set vm_old_state in
>> postcopy_start()..  See:
>>
>> https://issues.redhat.com/browse/RHEL-18061
>>
>> I suspect that was the cause.
>>
>>> Tell me what you think:
>>
>> I'll have a closer look later, but so far it looks all good.
>>
>> Thanks,
>>
>>>
>>> -------------------------------------------------------
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index fc5c587..30d2b08 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -107,12 +107,6 @@ static int migration_maybe_pause(MigrationState *s,
>>>  static void migrate_fd_cancel(MigrationState *s);
>>>  static bool close_return_path_on_source(MigrationState *s);
>>>
>>> -static void migration_downtime_start(MigrationState *s)
>>> -{
>>> -    trace_vmstate_downtime_checkpoint("src-downtime-start");
>>> -    s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>>> -}
> 
> Ah.. one more thing: would you mind keep this helper even if it can be
> squashed when sending formal patch?  I want to keep downtime start/end
> super clear and paired as they're important hook points.  It should be
> inlined anyway by the compiler.

Will do - steve

>>> -
>>>  static void migration_downtime_end(MigrationState *s)
>>>  {
>>>      int64_t now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>>> @@ -161,11 +155,20 @@ static gint page_request_addr_cmp(gconstpointer ap, gconstpo
>>>      return (a > b) - (a < b);
>>>  }
>>>
>>> -int migration_stop_vm(RunState state)
>>> +static int migration_stop_vm(MigrationState *s, RunState state)
>>>  {
>>> -    int ret = vm_stop_force_state(state);
>>> +    int ret;
>>> +
>>> +    trace_vmstate_downtime_checkpoint("src-downtime-start");
>>> +    s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>>> +
>>> +    s->vm_old_state = runstate_get();
>>> +    global_state_store();
>>> +
>>> +    ret = vm_stop_force_state(state);
>>>
>>>      trace_vmstate_downtime_checkpoint("src-vm-stopped");
>>> +    trace_migration_completion_vm_stop(ret);
>>>
>>>      return ret;
>>>  }
>>> @@ -2454,10 +2457,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>>>      bql_lock();
>>>      trace_postcopy_start_set_run();
>>>
>>> -    migration_downtime_start(ms);
>>> -
>>> -    global_state_store();
>>> -    ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
>>> +    ret = migration_stop_vm(ms, RUN_STATE_FINISH_MIGRATE);
>>>      if (ret < 0) {
>>>          goto fail;
>>>      }
>>> @@ -2654,13 +2654,9 @@ static int migration_completion_precopy(MigrationState *s,
>>>      int ret;
>>>
>>>      bql_lock();
>>> -    migration_downtime_start(s);
>>>
>>>      if (!migrate_mode_is_cpr(s)) {
>>> -        s->vm_old_state = runstate_get();
>>> -        global_state_store();
>>> -        ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
>>> -        trace_migration_completion_vm_stop(ret);
>>> +        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
>>>          if (ret < 0) {
>>>              goto out_unlock;
>>>          }
>>> @@ -3498,15 +3494,10 @@ static void *bg_migration_thread(void *opaque)
>>>      s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
>>>
>>>      trace_migration_thread_setup_complete();
>>> -    migration_downtime_start(s);
>>>
>>>      bql_lock();
>>>
>>> -    s->vm_old_state = runstate_get();
>>> -
>>> -    global_state_store();
>>> -    /* Forcibly stop VM before saving state of vCPUs and devices */
>>> -    if (migration_stop_vm(RUN_STATE_PAUSED)) {
>>> +    if (migration_stop_vm(s, RUN_STATE_PAUSED)) {
>>>          goto fail;
>>>      }
>>>      /*
>>> @@ -3659,10 +3650,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>>      }
>>>
>>>      if (migrate_mode_is_cpr(s)) {
>>> -        s->vm_old_state = runstate_get();
>>> -        global_state_store();
>>> -        ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
>>> -        trace_migration_completion_vm_stop(ret);
>>> +        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
>>>          if (ret < 0) {
>>>              error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
>>>              goto fail;
>>> diff --git a/migration/migration.h b/migration/migration.h
>>> index aef8afb..65c0b61 100644
>>> --- a/migration/migration.h
>>> +++ b/migration/migration.h
>>> @@ -541,6 +541,4 @@ int migration_rp_wait(MigrationState *s);
>>>   */
>>>  void migration_rp_kick(MigrationState *s);
>>>
>>> -int migration_stop_vm(RunState state);
>>> -
>>>  #endif
>>> -------------------------------------------------------
>>>
>>> - Steve
>>>
>>
>> -- 
>> Peter Xu
> 

