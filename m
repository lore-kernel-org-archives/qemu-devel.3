Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42BFC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 17:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdCxw-00072m-FB; Thu, 22 Feb 2024 12:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdCxq-000722-Sb
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:34:33 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdCxa-0004Nn-0L
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:34:30 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41MH95TT014861; Thu, 22 Feb 2024 17:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=UHsu3z9g92CMQ4MNNqyHWkzndo/j/MsxXqM0rZfOO6U=;
 b=NgYJhuBDQqtadWG/zmueMpp4hy+3yCn520A4krptj2078nWyl4qT+C/BTUZKrwbNkICE
 ANuBPeB5OEccL90DLyoXtRgyKbFRihfl3HDZaawqiEzBX3oH+wUyLUtuaIjnIUvmgSRP
 aYzJUSQBJc8A6ZBQMKWvFIqFEWJYO4H/qj9mpS9KUJOeZHbp0IGNPJH13neHzLMrKPAu
 Rq3AnUySlf5NaWINiM6bL6Da1P7zYyRecy+nANWaG3JyEsEzeIKxLYR0ZtH+FLYQ8EUn
 Vp3zyl3kaiospG3KsuzvDNOdZsBZ6PdQgT9gKtnMjtzGLPCVelU/pCCoTJ15Jkx0EL5n Dw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamdu58vw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 17:34:10 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41MHGUgZ012875; Thu, 22 Feb 2024 17:34:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak8bcukc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 17:34:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSLh6+APYl3hbz7i6meDzs6SYErhIkmKY8cLu9NZFBZIystVLZewwVdm8szrFBTBnOhDNP5z3NWlw5GV5IGalkBFDuz0lJNbaOukTMuUJN0f53wve8EHSerZSaIR4JUe5qpvMc8OryyMB2W23s6vZc8HvhF4+jM80qSyuYdH+1KISa5YwPWOb3f7uXVvcoMV3Mi0a9BOzt/5Xwv32Q47S11B+IFsW3G95V7BG9f0ugQOj9dbW1z41pjJx+jlRB2Ie8dgRXA8/+CWur1QBv8IINdDDGoZ+g2DPowsV/M9hdyXD6bFY50u7n8NtrwOTj2mUUJGguCRWaMzWxRUtwrFaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHsu3z9g92CMQ4MNNqyHWkzndo/j/MsxXqM0rZfOO6U=;
 b=Zz9UOuvUwlurDsbk6ybyrsaBHk9SfL/wqKzaCN/YZF8/wk8fkCa9mJyWBMwfemIvWS6ee10ZzAMwUF6Ec7NISHl2PiTgCmE+99yOaVM1alK9bPx+uDXXWiquhOOenR0uJgrgRVBgTJJ3KJSMTGlm9xQzXUl3QV9jE48pm7VLZnmIx1AUZuL6O5MmxGzKJR9BUVfm21YmxY4GSTfRY51dQp7yuLvhGEoL5h2b7P7XKXIkDVY2/vf/1lULBWLTXbYWQzQs6/tQyQ8sJlWUJc8h9/CesoYBp2d/rqHGvXzvDzscstngxh1SN2BOasUvbCCVQLqAxzcjR3fFgaR3N1thew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHsu3z9g92CMQ4MNNqyHWkzndo/j/MsxXqM0rZfOO6U=;
 b=vapQqxuiMfb2mmuIjUBUUcsa40XrVSN0qYzi2S2CKEFCMKV1q652B+GzRrrOjuyDGWLYDd1gENBaMu1jeiK5M+BeHnZ96cZxnoYAW7UnmakiKEzEeOxC7K14kQ13KnRF6QWB4Dzb9iW9aerYCpNXgplkUGNivlxBm4eCPdfZ5rY=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by IA1PR10MB7333.namprd10.prod.outlook.com (2603:10b6:208:3fa::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 22 Feb
 2024 17:34:06 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 17:34:06 +0000
Message-ID: <c95b3c15-0154-438c-baa0-98f4c539355a@oracle.com>
Date: Thu, 22 Feb 2024 12:33:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 00/14] allow cpr-reboot for vfio
Content-Language: en-US
To: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Cedric Le Goater <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0035.prod.exchangelabs.com (2603:10b6:a02:80::48)
 To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|IA1PR10MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d17eae4-fc84-48f8-1a47-08dc33cc7859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DbU8/eA8JJTY9jnB72ZTvU6QjuZSfqhzrOcOk56BayamN+NmYcfsUulKZIyFLYUA4umZu74h5Av8NcJtDPt3OihCMjvO8Lf+oR6ac4zlr3VAYLdIaunBPF+qzGSH0Roy6vbgqBW3p1zW+hpnrUU+7BebyQAssMw46rfjLoXvz0sYxc5n4nr/vYdWH+O56MOm14rxaY2WCnwH6m7p73tOdKxneG75v4Zme2g+vTiATIgxFCvocn16VKsu8bajY+2Rrwy0rKiVN1+nrHUCKyhZ7eBJcM7rLovnFWqKIdlAhgh2C5KNAPO7/2yTL3LZPnW2QqdYKbhquCB/EtS2dnWcYVY5RlVwmeShLag+UoDEnXIG3o8s2MW/LegdUhXSmSdUUDhzUS/6UNXvfoF00LqTVHcJxOLlZ5iC2um5BBXw+1IMxFKUVKGpD1IKcqq7RPZEWmXAjqG4Z7kCKRHXZQyrPg0QdDCjoMSG8LiysqWhG0JtFKj/5BdejPHYAu23mQO18d36BiCHVCNCJsftkLezYoQ68AKzjh2qyOXB5YyJo5o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTRKTWEzcTZyUU5VT1E3LzlnZXA1dlRxUVFiZHpQKy9ySEEvcEpPQTVaWXR6?=
 =?utf-8?B?WGdvNFpvelpzZ05GSnYvSUNFWExpRnpUQnNZWXRCWjZNcTQ1U0lGZDc4UnJj?=
 =?utf-8?B?RUhRVVJuZW05Q2xwRVdOOXlYZnV4eGlzZzlXbDdhR0tuYnU3TUt0SVUvOEMz?=
 =?utf-8?B?VVIrVkQ1U3JDaHpEM2xtcjhBZlJYd3FPRnVVemN4cm44U1lLMGQxL0tiMk5Y?=
 =?utf-8?B?QkpyZzQ0RksxZzRzVjVaL05hSlpzb3lyTitxemJXd0Z5WkVETGl2S0VSaHBn?=
 =?utf-8?B?aUdRTVFlSXRmbXhSQjFiZlAvKzlKOTJMTDNYalViOVpOUkVLbG5QRzNPRW1M?=
 =?utf-8?B?dE9nRTFBZzZFZnJEOGJ2L1hsSWVkQU1zQ0I3aGE3UVNjdFFyT0FWRDVUL2tW?=
 =?utf-8?B?R0w3Rk9PemI2Vlc4MWhuY0tsdXpJaEJHaC9mdU56Qy9Zdm9MOEpVb2JmTEdr?=
 =?utf-8?B?c3YwZytzd3ZrNWtwUnVtZnBVa2YrSy9hVkNRTHZJSHZxdHdlYWVpMHJ5Z2J6?=
 =?utf-8?B?azhzRWNnYTd3WkQyeCs2Y29ITUxvdWFvenl4YlUrcHA5bkZhNnFHVzRwL0lT?=
 =?utf-8?B?blFMUW5SeUo2Tjg4UkRzS2ZmbWFRZ2Jjd0ZTeUxPdno5OFdoSWc5Yi9wVzVQ?=
 =?utf-8?B?dWF6WldaVUFyajNXQWgwejlrck10NVRtTjBHVFNUQzVYZnhLUzdxckdPRnVm?=
 =?utf-8?B?bXl1cmNiZGloaUlQOStxSUV2MnNaM3poL28reEVZa3pNWU5JVUlFdnF2ZnYy?=
 =?utf-8?B?ZWZHeTl4ckxqbUxvRENJRk44L244TG5WQlFZdmt3bk9GRzlSYXRDS1FhTVd2?=
 =?utf-8?B?dTA0dkkrcnNuZDM1d2xUWFJ4b0NJY213RjZBWStjSGNpNUxxZXVHWVFtWHNN?=
 =?utf-8?B?UlFXV0dZc2xRQnRXU2haVEtHeWZqVExZVkxPM2FGckg2QnR6MkJzbDl1ZS9L?=
 =?utf-8?B?SGxtMnJCQTEzSTBrVEFEMkxJT3dwV296TnJDYXZrRXlJZTJoZVlOM0tQMGdD?=
 =?utf-8?B?cjdjV2l1bUtUbU5Wa3g3Y0w0Rm5QRW80WitrTGplSjVxRnhrTDhoTTB0TFJ4?=
 =?utf-8?B?akgrNVlLdDZRVnZreDVjOEVJM3RWOFFsczhzdS9ySWJSMEFidncwdk1LenJP?=
 =?utf-8?B?OFRtcmtKcEFTTy8xMG91aFdPLzVLaHRqL05KRmxXQTJBVmpjLzBLOUJaanRK?=
 =?utf-8?B?VkFTc21kcEVvMWdnQjhIeTlzS1lEUnVNNVlTNXZoSzBoZkRSZURHRDd4VlZE?=
 =?utf-8?B?cm03QnNUUnFydmdhL0ZtWGl6NHhKbDluTDk5a1hiUGcwZng4eUdrZmdpTDJF?=
 =?utf-8?B?a1ZmLzBKc2JwUVE2S0lVRkNtbE1vSWM0VkRxNmxuVmRRcXpQMkhOZFFYUG9h?=
 =?utf-8?B?TzdpakRibXJoWnMvbVJYUmcwcDBWNkZTc3Jhbi9UNlFrdUkvMTE2NW1nR2Rm?=
 =?utf-8?B?WnlqQjV5QW8xWVVycHZ2SHNjdUM5ZHltc2lwSXJ5UEdpRW5TTnVjZGhEcVFi?=
 =?utf-8?B?a3VvM08zMjVISlk3akl2V3N5WHBZd2F1TEdQdFRWbzhWQmN4VFBCQWs3SGVT?=
 =?utf-8?B?cTNWeTd2ZnMwRUk0T2NzZG1NbWZjZWRodmp0eGZmT3RGOERIdW1oWEVsaXdI?=
 =?utf-8?B?ekFoNEszb1cydU55RnI0cktGY0p4K24yM3NEd2x6TVB0L1hHcW1QOEkrYmlX?=
 =?utf-8?B?NHhBWlg4ZHJ5SkxvRXA3RXZyYUJ6TS9Bd3o2MC9PMktsMFVRandRRStLcVJt?=
 =?utf-8?B?dlNXaUplZjNURnlpMGN2S3NGZjJrbGRUL29hQTF4UmhzbkJrUDdDQ2R3NzBt?=
 =?utf-8?B?Ry81dG40eXQ3ODlGWTdyeTZWcXAvY0tLUTJwOElRWk5USTEzRVlHcmVwb1lk?=
 =?utf-8?B?NFF5SC9EL1RnbFgwZkt5WFhpS1RpZkhtbk1qdEdQY21Hc2hzYnZsR0pwYlpR?=
 =?utf-8?B?bVNhUSs5Nkp4VkllUzJDTlNkUzJnQ1dyVkROQlhNci94d3VlbytaNEN4R3pB?=
 =?utf-8?B?S0dsYi8zR29JWVJ2VXFaeDFoM20yaEl4d1hvcHYxREtiMFFZdmNJK1NFNGpT?=
 =?utf-8?B?WTNlc21MSHRNeFBYTVdISGN3WEZoR0tpMU10NHUwNVJQYmtobW5vZ2VPVFRF?=
 =?utf-8?B?cy9JK0tQdUtTOWFTWmxBS2syYXhwdGIvaXhiTzNRbDd3RHdhUFUzSXJCSFhG?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /6JA+sAlD7RMIsxcVN7Hsq30iWkxciIqdHp973dr4u6AH+gR5a0Boo5TVXcluYTuveOE+0nTl98HEUmnDZNnxpygynHFJxIMipltX97QLriW2XzC5m9LdAsg6rBqP7enSWXyDM7KoSCPOhYH8NETtCZPbzqr4NNUTA9Px25rtA5L8qznqyMhus5/n5TBaHS7phhoZUhX8MlCO1FL4drFxktM/URtmxAiHpimhLWc8I919IyqADgkogcOkv7zANl8u7UZMIeb8GQXwjkf8UyNuJnvFsRVuWKZJh8KJsMRp2ElyvWosJHDO0RRZYZX4otpeyP6TKM/COwKGyWyKejvGsvesVn6aDQmoXyo6pd97OSO6A57IK9HnWxCqbkZDVi2n9C786uienrdZMIeSSi31p4hjjgurcdPEkWi4pghTAjyDjnoO9Gx6lY0TLzSL8ojJbTIjFHE+oojnIWAvBj/3q3aAYTTMpPLsr4s1dRjTwcXe+gn1MGBtR2Z6AexfxvZIKde7vcm0Op+gLxmZfefj2n5UD94OvXgvbE+wvy0zqc8V3XnVVAdcYdWPeJs/W72nIWivihMpcsWJ/Ubk/swxC0nJzKm1k5zDZWuUQk0KrY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d17eae4-fc84-48f8-1a47-08dc33cc7859
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 17:34:06.6337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQJ13Tn+FFHI52d2MXyD2T60TiO2kVdkKuXmtfLkMB7FGcpveP3EweDj1a72Ld5dW8H2RhBHSDInFMdZQ3uO/cinRXwb84/r1SCFVA3XRfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7333
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_13,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 adultscore=0
 mlxlogscore=942 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402220138
X-Proofpoint-GUID: TwNVkpArOJRFDLmtHoM8iISiqqp5AEBo
X-Proofpoint-ORIG-GUID: TwNVkpArOJRFDLmtHoM8iISiqqp5AEBo
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

Peter (and David if interested): these patches still need RB:
  migration: notifier error checking
  migration: stop vm for cpr
  migration: update cpr-reboot description
  migration: options incompatible with cpr

Alex, these patches still need RB:
  vfio: register container for cpr
  vfio: allow cpr-reboot migration if suspended

Thanks!

- Steve

On 2/22/2024 12:28 PM, Steve Sistare wrote:
> Allow cpr-reboot for vfio if the guest is in the suspended runstate.  The
> guest drivers' suspend methods flush outstanding requests and re-initialize
> the devices, and thus there is no device state to save and restore.  The
> user is responsible for suspending the guest before initiating cpr, such as
> by issuing guest-suspend-ram to the qemu guest agent.
> 
> Most of the patches in this series enhance migration notifiers so they can
> return an error status and message.  The last few patches register a notifier
> for vfio that returns an error if the guest is not suspended.
> 
> Changes in V3:
>   * update to tip, add RB's
>   * replace MigrationStatus with new enum MigrationEventType
>   * simplify migrate_fd_connect error recovery
>   * support vfio iommufd containers
>   * add patches:
>       migration: stop vm for cpr
>       migration: update cpr-reboot description
> 
> Changes in V4:
>   * rebase to tip, add RB's
>   * add patch to prevent options such as precopy from being used with cpr.
>       migration: options incompatible with cpr
>   * refactor subroutines in "stop vm for cpr"
>   * simplify "notifier error checking" patch by restricting that only
>     notifiers for MIG_EVENT_PRECOPY_SETUP may return an error.
>   * doc that a fail event may be sent without a prior setup event
> 
> Steve Sistare (14):
>   notify: pass error to notifier with return
>   migration: remove error from notifier data
>   migration: convert to NotifierWithReturn
>   migration: MigrationEvent for notifiers
>   migration: remove postcopy_after_devices
>   migration: MigrationNotifyFunc
>   migration: per-mode notifiers
>   migration: refactor migrate_fd_connect failures
>   migration: notifier error checking
>   migration: stop vm for cpr
>   vfio: register container for cpr
>   vfio: allow cpr-reboot migration if suspended
>   migration: update cpr-reboot description
>   migration: options incompatible with cpr
> 
>  hw/net/virtio-net.c                   |  13 +--
>  hw/vfio/common.c                      |   2 +-
>  hw/vfio/container.c                   |  11 ++-
>  hw/vfio/cpr.c                         |  39 +++++++++
>  hw/vfio/iommufd.c                     |   6 ++
>  hw/vfio/meson.build                   |   1 +
>  hw/vfio/migration.c                   |  15 ++--
>  hw/vfio/trace-events                  |   2 +-
>  hw/virtio/vhost-user.c                |  10 +--
>  hw/virtio/virtio-balloon.c            |   3 +-
>  include/hw/vfio/vfio-common.h         |   5 +-
>  include/hw/vfio/vfio-container-base.h |   1 +
>  include/hw/virtio/virtio-net.h        |   2 +-
>  include/migration/misc.h              |  47 +++++++++--
>  include/qemu/notify.h                 |   8 +-
>  migration/migration.c                 | 148 +++++++++++++++++++++++-----------
>  migration/migration.h                 |   4 -
>  migration/postcopy-ram.c              |   3 +-
>  migration/postcopy-ram.h              |   1 -
>  migration/ram.c                       |   3 +-
>  net/vhost-vdpa.c                      |  14 ++--
>  qapi/migration.json                   |  37 ++++++---
>  roms/seabios-hppa                     |   2 +-
>  ui/spice-core.c                       |  17 ++--
>  util/notify.c                         |   5 +-
>  25 files changed, 275 insertions(+), 124 deletions(-)
>  create mode 100644 hw/vfio/cpr.c
> 

