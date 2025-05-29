Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0A1C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 07:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKYAF-0005JO-7g; Thu, 29 May 2025 03:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1uKY9x-0005Bx-Ba
 for qemu-devel@nongnu.org; Thu, 29 May 2025 03:58:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1uKY9a-0008Lr-8U
 for qemu-devel@nongnu.org; Thu, 29 May 2025 03:58:40 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54T7tv3b018206;
 Thu, 29 May 2025 07:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=lRGQngMfFXhVurtltkx15uCHbVmTLQG7q3Wua2sYVrY=; b=
 lOErZZ/hNxlkIz0TG6wXgT0a9F99Viiut6dKXnomhl5KFHfK3kqe1MBWbEkrXTSn
 RGIsSgttRga/b6kIYIMXsl03hFKu3iEPMzP/yiLbO028SI14KoTTGFZZLlZz826y
 x85coe1Eq+tHAm/Eeb6+b74YT9ydqYR8/SoKJTQRnH7MUAXj6k8nicJfyCBjTus9
 iouhpuaw4w8KvaOvwl0zqiTIUwrNuBqKLUUHIxMxxbYdm1GjMt4V5COLfOZlWRaj
 q2GS31RBbj0F0DHFAskPaA41pFfgm1MFZupo0AcGqlZ2uY/moQiGtuBKQqFH/k0+
 ahGRGkiMW1HPASDBwOVUEw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0ykyudn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 07:57:37 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54T7YACN022142; Thu, 29 May 2025 07:57:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jhwd8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 07:57:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnBE5yFayyPVmvNUdWLZbSrtpVNjayMZMhNNPC7YMTw+oTbmL4SkYmUq+ZJgLE1Rn40Mw2S13+aund70IzWlI/hQKRRh3zGVNirXzE/ag3N1Z0trEpB/IJvpar2P+A4XmQx6Iliye4ayGIWOeP4gfrN7FoF+I1TirRZUY5tDK7JmeSQcZtppwWEPw1uibm3i4e4zs7j73Kh47HXOzyrpVP5RCSeZZOGh3cONMk49NhAKx38VSr7+kQNVW0bZSZJJetiU5KrODAImdO0i7UVpmIkEaFiO71rtk6PoZOtApk1r9F0EkTsqrKwEncAIZ0sR0ko9DNe1JPatAERY22q9NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRGQngMfFXhVurtltkx15uCHbVmTLQG7q3Wua2sYVrY=;
 b=dwb77hpOx6M53pta4n2GVVaw47bKx14WiUli0eHliTUWXTtQN5uRVVbUDnvIiXFL/edM9CKeAceyM0rkAk7r659b9fRX8dEiORvqkXblPcEnqenF6n0BK2Cb8nLUg3aN3bF+i1LYRHQVikUVWAanh1kUks5yWM02+JFu3ST4qIrNp/t+yGhz4QGQFYNZ9eXLEOA9XxFKkUNMZXW4SclWYv6QuoiBF4syuRv3JKC3LaxV0DZFukBAO4qEOhcrpC/g4YOrJyrUMb/Ad4cyS1HPke+P9MwnoR4wX/MtTKkGDah8Ehzq11aqRihS83m//hs4mPSg17ahXH/JAVbfItOs2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRGQngMfFXhVurtltkx15uCHbVmTLQG7q3Wua2sYVrY=;
 b=Vt1AW9uyFk1iRzUS334L5wfCcqaz3argOysPq2CxN2WLKfLoJWmQ7Eeq2xmXVD5eftvvgg/wsvj8zvq5OkDcpfpgMsGMrQAOe7r9TJeVlrpWaO5uLhpojPPJaKNF864GzgwHeR+l4YYwXq0xjqDcpM9bnxf0aLMtOuVHPloVjTw=
Received: from DS4PPF18D5A7206.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d0d) by DM4PR10MB6109.namprd10.prod.outlook.com
 (2603:10b6:8:b5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.36; Thu, 29 May
 2025 07:57:33 +0000
Received: from DS4PPF18D5A7206.namprd10.prod.outlook.com
 ([fe80::87f4:5f1f:bb55:aab7]) by DS4PPF18D5A7206.namprd10.prod.outlook.com
 ([fe80::87f4:5f1f:bb55:aab7%5]) with mapi id 15.20.8746.032; Thu, 29 May 2025
 07:57:33 +0000
Message-ID: <dcbf9e2e-9442-4439-8593-dff036a4d781@oracle.com>
Date: Thu, 29 May 2025 00:57:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Move memory listener register to vhost_vdpa_init
To: Markus Armbruster <armbru@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Jonah Palmer <jonah.palmer@oracle.com>, 
 qemu-devel@nongnu.org, eperezma@redhat.com, peterx@redhat.com,
 mst@redhat.com, lvivier@redhat.com, dtatulea@nvidia.com,
 leiyang@redhat.com, parav@mellanox.com, sgarzare@redhat.com,
 lingshan.zhu@intel.com, boris.ostrovsky@oracle.com
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <CACGkMEuD7n8QVpgBvHSXJv7kN-hn4cpXX9J8UO8GUCzB0Ssqaw@mail.gmail.com>
 <87plg9ukgq.fsf@pond.sub.org>
 <50a648fa-76ab-47bf-9f6e-c07da913cb52@oracle.com>
 <87frgr7mvk.fsf@pond.sub.org>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87frgr7mvk.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:40::15) To DS4PPF18D5A7206.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d0d)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF18D5A7206:EE_|DM4PR10MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0ec5e8-dab0-4014-141d-08dd9e8677d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXBOcGVSdnlFaFc0OURBbUtYS1BZN1pFK3lKRXZZQldNWFZLTTE1bVJhRll3?=
 =?utf-8?B?V2cwaGs0K1BGODhVZXk1N2tpMUxXLzcyWjFsWlJHb2syRXBDVzlOTFoxM2NI?=
 =?utf-8?B?UkpDVmg3T0ZsNVhwTnRUWEJESGNhL0JKYmlMdGtIZHRZejFiREhiY0xuczZU?=
 =?utf-8?B?UkdsYWdTZUJ3MEUxTlFzUm5LNG5CWVd2a3FHN1llZy9IYTdXYmlqdHc4dGdG?=
 =?utf-8?B?ckVaaU1ydk1vajIrc2R0WkpCYWVCK1BnMEM4T29WU2Nrbk44R21nUXFKR0Zj?=
 =?utf-8?B?d042YUhOTUdIM1NCcForRnh3Z3c0aGhhSFRyYm5TdDdMazgvOUQ5RGdYeGww?=
 =?utf-8?B?TkkxS29sWURiTFA1OWlMTUFxaUw5M3k1NjZDc0NFMThMRkxvM0JCc3lRU3lK?=
 =?utf-8?B?aGhNNlVDa2xIMzJkYW8wZjRmeXlaUkMrdjd5b2twaTlNTlNxSzJjRkViWnJr?=
 =?utf-8?B?dnlKRys3cjIwRGdJQ1duTmVTR3dsTzZidHlUNldEeit6Y2NpRS9OR25YRFJa?=
 =?utf-8?B?UjA0ODYybDNkdnVKRFR6bTJDT2RYc2lZVThrSWwwT1lFTTZtenRockYxK2Nh?=
 =?utf-8?B?ZmIyQ1ZteFlGQUZiZEVMckFBbmw5MWltdXZoZVpvOWZvMDF0SzNiTHJRQXdw?=
 =?utf-8?B?UDJDLzliRG16MDR6a1JxejdQMHZyVDE1K2JqQ3YvQmVXeUVYeU45eERubHRV?=
 =?utf-8?B?dHBLZ0xjcXUwUmI3K3pPZUpnalBpZkhDbCtnYm5rQ3lpZEF0c1Y2RVFrcEky?=
 =?utf-8?B?RzNrSXQwUzErTnFRWGdBTU0wNXJqTzFoMzBnSVpSakMxVkR4cWF6UEpUYmZh?=
 =?utf-8?B?YmZWQWkwWjhNOU1pb2ovdUJqVklCcFRZWGRTelFTbzZseHgwYzUyWWduZVBW?=
 =?utf-8?B?RXlWVElObGV1MXJnU1MrOVN1SmkrU3g0MWxkME5oNGlwajlLSzJFZDNXWmhB?=
 =?utf-8?B?L3FSd0Zld25IbkpjZFpxd3hCa0dmSW5JbkVpc0NFWXBNSW5nYTFCb2xQWGpy?=
 =?utf-8?B?cnF2aU4xcWllRURSZ2NOSVc1SkhlZzR2WlU1WllMbVRqU0lwR0tTdzlmS2o0?=
 =?utf-8?B?TGNMZ3VoRHhhQk1jOGx3dklnV01JUndlKys1bDJJdi95SkRkeEoyTzlFcXpZ?=
 =?utf-8?B?bXdTdWEyQUNEZ1lPN3A5czhTcTdzS2hmTWRrR2IzaHg4bHhUcUdsUFRoUU9E?=
 =?utf-8?B?R3VjeEExL2o5cnVabFVWLzdWY3gvYm9zQ2l5N0JSRy9Ka2txajJtLzUyUUpi?=
 =?utf-8?B?R2xtYjZDSFU5YytUVDRxQ1NzVFlqM3VWeHNNZHRUeFVFMnVyQ2pYdkp1UGdR?=
 =?utf-8?B?cmFwY3ZQaEtYY2MxSzhwZmI5UVEyaWtMOHpjV2g2SHYxVERtbXFPd3dWY2VW?=
 =?utf-8?B?R2NwaGwwK3llYjZVcDlPazhqTjF1c3BqcWtYdU5RRkZJOWlFa2FDZmV1TU1P?=
 =?utf-8?B?WkpsbE9XWEpYSmhyY1dmWUJ1a29weS9qTzQwMDNYS3V2NGZ4K0lUenlvYzJs?=
 =?utf-8?B?d2tVV2h5R0ZTeGlZUG0wRUZ1TnBCYUVjMkFBd1MrODFRYlFHOTAxdlpYTGFC?=
 =?utf-8?B?OXZDWm92MXY1NTM1YWdLY0JHUExYdFBvVzJEcmcwNnkrL01oZ3V0a2taUEcw?=
 =?utf-8?B?MFR5dUVpZmxIT2FVeHRBN3kzNDEwUjBtUzdoWmlxK2g3U25xKzNrNkFuMWlQ?=
 =?utf-8?B?K2pORVkzTDBndjIyZlp2dFkvTW03cXpsOGh4dGxMM2ZuUTFYcnpiZGVkVWZ5?=
 =?utf-8?B?Y2Q5VXlra3p0b2w3TWJYK0FveVB2VDZaZjcraXJ4VlZjbWJwM2lEc2ZvQmoy?=
 =?utf-8?B?QUpJQzcwcmdFbmFiQkc5WE9paVpONGtwcmp6Wk5ucmRoNFlkOGl1VzNMQ3g3?=
 =?utf-8?B?WVRDd0ZqRnB6Qy83MGplUmFNcTIzY3pjOUlNMTkxNEtZTU9VRmRlWkIvM3B0?=
 =?utf-8?Q?RRVl/ZlMINW4k1zUYNkuqcKkqcntbTN9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF18D5A7206.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nzk5ckpxTjcvY3hTNklRK0xzMkNyZXRzVm5TdFJ4N3RoMmJNWExUK3UrNGNI?=
 =?utf-8?B?aldYVy85eTJvVVJ5bTJXVVNXSjJ1S1kwNUVFRm9obzJzeFl1QlZZR09VL09N?=
 =?utf-8?B?UnlDcVZ5YS9MV1Z0NTlrSGI2aVUyK2I1UTZabWcrcHZFb2tkYVBybUl0K3pL?=
 =?utf-8?B?ZlVmdStaZmVsYWZGOTVQcmEzeWJRaW9mcTBGc2dXTEZZd1I5cmxuMU5GWHpr?=
 =?utf-8?B?ZC9hRnJDOUJTRjFUK0o1R1JhbkFkVjJpTHJIaEJMR3hCMkJYYzRvNm9xSmtl?=
 =?utf-8?B?VXJ1ZVkyVVBTNFk2TXA1MVhPcjdmNFZBMmNBeWoxZGROZ0V3cnh5SER4YkFC?=
 =?utf-8?B?TlF4N1NPZzdqeG9VdUl1c1pEUVhBc0FFY25lZFkveUN5Yi9NYmNPQnc1Tnhm?=
 =?utf-8?B?cXdwYzVWM1JnSXg1SFRTL2F1ZVNXUGpBbzU5N3pqR0ZCSmU4d2hFeXd0UU9n?=
 =?utf-8?B?MzJ0b1FQNmhNWkpYaTNPdDdLSXVlM1VqazJEUStVcERoVFIweWkwMDlLbFFB?=
 =?utf-8?B?MFVhZDZ5NUNhTC9VK0hRckxKdDE4OC92MnRIb2VQcGthK3VIbFhDUXVPRS9k?=
 =?utf-8?B?QVFCWGNXazJxVlNnekhpd1d4MnJkNVdETlFMamlxS29JcjZZNzdUeDNNUkFQ?=
 =?utf-8?B?UXRoZmRFMmhpSGhtTjBSNGlXOGxERytWQmRBTkR4L2lVTVBoV1lGS3ZTU0JN?=
 =?utf-8?B?TnBXempqdnVTVk15MEhOYW03ZzNqL3RYZWFxRmRXMHdNdnYxZWkzbFBhaVhZ?=
 =?utf-8?B?ZmxaS0ZBWWlqd01HSWN0TGEybXhVQThQc2ZnaEEyL1RScTA0SjZEejRPaHIx?=
 =?utf-8?B?QzZZYVpldGsxQ0tUM1QycktMNVcwMHVVY01xb1lqa0M1Yi9ZMnRUcU13SU0r?=
 =?utf-8?B?MjlralMzaXRoOHJIYmY2Rk5nWUdQU213emdmZ2NIR0JTUWlORGh0WW5Ka2pq?=
 =?utf-8?B?S09MUjdpaUV5alFuY0ZNdlY5NURkRHJwMDJTWVZiMGRWb010UmQ5WkdvdVBa?=
 =?utf-8?B?c3loMXV6Q3JSN0tXUmxUb3NyV3YyVFQvaXRSUnN1TDB2OWhuVTJGSzNDb3hV?=
 =?utf-8?B?aTNXeis1YzFUUDlXZGtvNE1HUEk1SHljNUdoS3F4S1l6cjlUK1pNZkhNWGh0?=
 =?utf-8?B?ZDhwUTA4MnFKc1dpMWVWM1ZlRmVMRCt0SlkzaTd3bXJBaDN0cWZlRlBOb09B?=
 =?utf-8?B?UnU3dUd5R0xYZzk1QnYza0NHZU15aEtHQlJ6YjdFYjg0K1AzMXkzemtHamRV?=
 =?utf-8?B?U05wMFMyYkJ3LzFjOGE5TWlUVmRYemk4cGlUblQxNzY5dklBWU5hZlJjbDgw?=
 =?utf-8?B?SlhhMmg5dGJBUnZqbFhCeE9IeG1DOENMSDFrSENZZlBvSWVwdlFDdUt4cnZE?=
 =?utf-8?B?ODdCbmNncG9pTVFjdnhPaGhzSWJMTGtiR0R1MnFSZ3RkdlVrYXB2bStMZDJV?=
 =?utf-8?B?ZjV6SC9jUWVJT2Fac1dZcTRVWVBXbVZaclcwUDI0a1UzVzZSdVVKSlF4T2I2?=
 =?utf-8?B?Qjl0UDZRZlI2RTVDdUtJWTI4NE1QWmcvMFZHbHdKVVNhYWxrUG9lNUpvRUFm?=
 =?utf-8?B?K3ZocW5rcWNjb3pTZmVXL1RVZkdncDB6SkhZMGNGQ2dCLzhvS2FNb3FWWlRD?=
 =?utf-8?B?cFdCNzZCcUJzd1luTVNqQ016bTJwRUdEUFVEeCs2Q2tNaGVBdjdyVFkxMlNo?=
 =?utf-8?B?VzdDTHM5MXNDMG5XbENpdm1nTWZsbjFyNjBDTjRzSEhWckxnZjlPRTl2VG54?=
 =?utf-8?B?ejFXdk1iVmU5RGNxeGZOUGlSaTFFWVJzdXdobTdidUdqQnVnUG5oWVIra056?=
 =?utf-8?B?YzUwMlgyTWVZZHpiSmUwaW9qMTk4eS9ZK0RXR090bm9vckRNL3Fmc0FJS1py?=
 =?utf-8?B?QnBQZ2pVQU1kUzRYWGFrZDQ2YXFlYXJGMzUzSjVNTnQ0c0NnSzNDMUxLUFd1?=
 =?utf-8?B?UE5aOFkwTGZmUzlhbGE5VzhkTThVMUE4d3h1cXlvQ3NBdTkzTUtPaFhXQ1F5?=
 =?utf-8?B?WkFWR01JY3RtYnJTMzRYTituT0RvVkJ6emNuMXljU1h3d0gvMSs4eEdyQUlh?=
 =?utf-8?B?QlJlWmhUd045Mk1DWHoxMlFISDhCR0VOTXlRYUFER3BkZjJRUmRMazRVczBH?=
 =?utf-8?Q?fDFAEJ26bk7IN46aHIqEXiRej?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4zwPQ0UY+EuaY/PU+732ui3LVMItDmSNZiG/WIwqOP+xexhbR1+8FxvP0jqbWmxtN+uzILkpO7aMt1nwczL7j6qxbSoI18Eso25XIc95UuHBafsHQdyHs+GRltDSoHEll1U13LzRAIbHFxZTu9AiwOFBZqW33YytM5o8NNEEs94yIyf4DMMW9/Pbt+/2VtXPN+FUYtfae2Xptzkc6WI7NEOi7diX9kzn5tEVZh7FVVVYV41CdhreWs5i8Apc2gV95Gp9qNEt8gqJ2V+4D8/zHY9HgJt/EY6uqb5o4yyK1tygXAJC21VH5Kn5P+5+YySXtc9zqfrU4713UvopwVs74s/L14JnkGWOnorQ2aHzT8WknUzags+31bcKaEh0HwJC8BhDNbvgWNnW/jvql8jT7rvVrwd7b8tTQ8OtaH9Wr7Dhwf1NAahDvw4lA5LOtaGn/iqFN36X7yNIWhbJjJMMNfXJ4OEraI/HvTmyPFAnCSvrF2iw8gt3wl71V/90RwbXKGTb2BGBEfAguCB2QP2AtRxcpVNxX+AXRVXogOOYBnpO5A/TVGeSFys79xgCbOzvymMqAz87ErJ+32JFsESCzmCsQXw6kYWpR2xDqGJbP64=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0ec5e8-dab0-4014-141d-08dd9e8677d5
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF18D5A7206.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 07:57:33.2709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IzQBjhiuKk3bfP80HJqU0LwOvusHKjtP12NEXlHGcIWHgqFGkvFeBVkDhPhruNHTA7s4iB9NDH4NbmGugbvpXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6109
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_04,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290077
X-Proofpoint-GUID: cQivE576ijbcYjB-5Q-jCG7H892sGcL_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDA3NyBTYWx0ZWRfX/UVEv7tkmZZL
 CF+GJ9mFCm/UxPJ0gCmXlQQczvPRV8OZ3EIr72EZ6/IFXdj4GQaPKdDJ1obx6Fcz1xGSjFm+fBo
 zDr2CwoNFOUyWOlbvz+xqDbqMufD3a4UtOCdX3r38qD6EBSzvcvwHwYfavl63oeNT85Fxt+vslo
 m8UDML+c2yCwOI+HR/LDSvSLUKl6eKoOi7eV1bMFUftLXs08jq3TOrHq+gGqxuRJMyzGpUAhGQo
 Yt8JlVrOSxWG+HHFUV/aE8kjFszJtmw08NoHAJnplyUuTqjp7FH0O4J2KacJQ8/DsOLuVsT2/Rp
 2sESwFxR+knvACbvJ6dkzsHpebi2s8Rwtj43CLB45IVANVxOe4lnIn4+Gke5SzZRE4Ygphwz5YY
 wKTquW/mRenw/eZ/XgIoTRtczHhxjDyETKS9dxHYhXN/1uyMPj8YUmhh9WjtIickwz8ceIaI
X-Proofpoint-ORIG-GUID: cQivE576ijbcYjB-5Q-jCG7H892sGcL_
X-Authority-Analysis: v=2.4 cv=N7MpF39B c=1 sm=1 tr=0 ts=68381371 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=20KFwNOVAAAA:8 a=mKTdQVznOeRpaCLaiJ4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13207
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 5/26/2025 2:16 AM, Markus Armbruster wrote:
> Si-Wei Liu <si-wei.liu@oracle.com> writes:
>
>> On 5/15/2025 11:40 PM, Markus Armbruster wrote:
>>> Jason Wang <jasowang@redhat.com> writes:
>>>
>>>> On Thu, May 8, 2025 at 2:47 AM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>> Current memory operations like pinning may take a lot of time at the
>>>>> destination.  Currently they are done after the source of the migration is
>>>>> stopped, and before the workload is resumed at the destination.  This is a
>>>>> period where neigher traffic can flow, nor the VM workload can continue
>>>>> (downtime).
>>>>>
>>>>> We can do better as we know the memory layout of the guest RAM at the
>>>>> destination from the moment that all devices are initializaed.  So
>>>>> moving that operation allows QEMU to communicate the kernel the maps
>>>>> while the workload is still running in the source, so Linux can start
>>>>> mapping them.
>>>>>
>>>>> As a small drawback, there is a time in the initialization where QEMU
>>>>> cannot respond to QMP etc.  By some testing, this time is about
>>>>> 0.2seconds.
>>>> Adding Markus to see if this is a real problem or not.
>>> I guess the answer is "depends", and to get a more useful one, we need
>>> more information.
>>>
>>> When all you care is time from executing qemu-system-FOO to guest
>>> finish booting, and the guest takes 10s to boot, then an extra 0.2s
>>> won't matter much.
>> There's no such delay of an extra 0.2s or higher per se, it's just shifting around the page pinning hiccup, no matter it is 0.2s or something else, from the time of guest booting up to before guest is booted. This saves back guest boot time or start up delay, but in turn the same delay effectively will be charged to VM launch time. We follow the same model with VFIO, which would see the same hiccup during launch (at an early stage where no real mgmt software would care about).
>>
>>> When a management application runs qemu-system-FOO several times to
>>> probe its capabilities via QMP, then even milliseconds can hurt.
>>>
>> Not something like that, this page pinning hiccup is one time only that occurs in the very early stage when launching QEMU, i.e. there's no consistent delay every time when QMP is called. The delay in QMP response at that very point depends on how much memory the VM has, but this is just specif to VM with VFIO or vDPA devices that have to pin memory for DMA. Having said, there's no extra delay at all if QEMU args has no vDPA device assignment, on the other hand, there's same delay or QMP hiccup when VFIO is around in QEMU args.
>>
>>> In what scenarios exactly is QMP delayed?
>> Having said, this is not a new problem to QEMU in particular, this QMP delay is not peculiar, it's existent on VFIO as well.
> In what scenarios exactly is QMP delayed compared to before the patch?
The page pinning process now runs in a pretty early phase at qemu_init() 
e.g. machine_run_board_init(), before any QMP command can be serviced, 
the latter of which typically would be able to get run from 
qemu_main_loop() until the AIO gets chance to be started to get polled 
and dispatched to bh. Technically it's not a real delay for specific QMP 
command, but rather an extended span of initialization process may take 
place before the very first QMP request, usually qmp_capabilities, will 
be serviced. It's natural for mgmt software to expect initialization 
delay for the first qmp_capabilities response if it has to immediately 
issue one after launching qemu, especially when you have a large guest 
with hundred GBs of memory and with passthrough device that has to pin 
memory for DMA e.g. VFIO, the delayed effect from the QEMU 
initialization process is very visible too. On the other hand, before 
the patch, if memory happens to be in the middle of being pinned, any 
ongoing QMP can't be serviced by the QEMU main loop, either.

I'd also like to highlight that without this patch, the pretty high 
delay due to page pinning is even visible to the guest in addition to 
just QMP delay, which largely affected guest boot time with vDPA device 
already. It is long standing, and every VM user with vDPA device would 
like to avoid such high delay for the first boot, which is not seen with 
similar device e.g. VFIO passthrough.

>
>> Thanks,
>> -Siwei
>>
>>> You told us an absolute delay you observed.  What's the relative delay,
>>> i.e. what's the delay with and without these patches?
> Can you answer this question?
I thought I already got that answered in earlier reply. The relative 
delay is subject to the size of memory. Usually mgmt software won't be 
able to notice, unless the guest has more than 100GB of THP memory to 
pin, for DMA or whatever reason.


>
>>> We need QMP to become available earlier in the startup sequence for
>>> other reasons.  Could we bypass the delay that way?  Please understand
>>> that this would likely be quite difficult: we know from experience that
>>> messing with the startup sequence is prone to introduce subtle
>>> compatility breaks and even bugs.
>>>
>>>> (I remember VFIO has some optimization in the speed of the pinning,
>>>> could vDPA do the same?)
>>> That's well outside my bailiwick :)

Please be understood that any possible optimization is out of scope of 
this patch series, while there's certainly way around that already and 
to be carry out in the future, as Peter alluded to in earlier discussion 
thread:

https://lore.kernel.org/qemu-devel/ZZT7wuq-_IhfN_wR@x1n/
https://lore.kernel.org/qemu-devel/ZZZUNsOVxxqr-H5S@x1n/

Thanks,
-Siwei

>>>
>>> [...]
>>>


