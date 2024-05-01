Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD9FC4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 23:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2JBF-0001lZ-Ho; Wed, 01 May 2024 19:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1s2JBC-0001kD-CT
 for qemu-devel@nongnu.org; Wed, 01 May 2024 19:16:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1s2JB8-0000kV-Jb
 for qemu-devel@nongnu.org; Wed, 01 May 2024 19:16:02 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 441MIkAS010470; Wed, 1 May 2024 23:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=NRxWaBsYq3cmbd2xnGtq6KZmyI9OodZx+9kRo8G8Tf4=;
 b=MKbu5Ghp44+gL4Y3HhygIPnjn6sE7CKynrs9BLImf9VgJmfs3xpGQ0skUk2VSB2UqG1D
 svMQVyxNWLUaBnhLQ+4dD4lnnCuioa43QvmbXvqUpTonqtdc6y1+Etz2rhtd33WWzPKL
 +fKzXisw1yfVpJU66cjiEEbZa3B33NqKPgvazEDh6U5oP9mN6KiwuEaYFwg7jRf3/+5v
 S0by0MRcbRzvZRMcnTA0Si+E8Kvguur/IyIgNa/z9N/92xMg3eunM9cQrzK8+F2Vqu60
 QZN5ECG9dSnftZFSYlPttFF/xNIDBQeJSj6rdV9WYFonJm82QhE5OMnGRDbyCuWqIHEI kg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsdet9y5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 May 2024 23:15:49 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 441M8j1M011365; Wed, 1 May 2024 23:14:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqta3695-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 May 2024 23:13:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxdfGou5n/c2M2UpZtzcDRk0Mm9TAc/2sPn54WM1TjNd7uOoxK8x3kmRWVYhM4sRB7in5L0R26nwPAxHiDbTVoHH8oCpcxfLcf1nKRD+Tlj0xmkOXsActlKK+1nKVLkAyIF5WyjLl/GdKqwqe2AjBPjB/YDJrtN5gr5Syfts2VS9NzaEXUK9J3HSirbZSWqgTS1qja2F2zUd03oQqwlvwrfxZUdrgt7WSZ7LYqZlRwp1PhJOOuJj0azRgDtWSQZWrRFWvrTRHjvj1cwboFMMxgp+wx4a/uO1q75SeanRYnDX2arxyxHoBicUuu7PkzPP7Lsp1EgaVC1wXmFaZqg1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRxWaBsYq3cmbd2xnGtq6KZmyI9OodZx+9kRo8G8Tf4=;
 b=jclhL45BdP4v0KNG2suMQAZPFClujAetAwLZC13XR6JSIeSJQDg4Z195qpCG6Z3IL9q950NokW4Fvrof0fN35B72z1dIFOCqMISGnO1YTFFwsNpOCdu+0Qd66pRYng/9RxRtMGR6avoAQdYdSG8+b0jUjScfnd5FM3+K8y4ikts/Rfs82vFzhOaLDswAtwMqALLc0wu5owfobs4dyMpfwN9HZ4LE8GLppjophipeIOZp9DK13I6kCjt1xJ7B7fOA2Ku01ZH7vRsbCSjdbZOKYowDhZTVgqd6wqkLEv5xf/ZndXupO1k7+PfIpLig7kfIzp/+FFGyGHzm3Mi8hXHXCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRxWaBsYq3cmbd2xnGtq6KZmyI9OodZx+9kRo8G8Tf4=;
 b=zcakG0Gwqp/efFGCtagXHQvffjO2tuXItKsLI0CHNuBpJKk2gfMYe6rQmHZmJYZmpE1CKQV4FQ299hxeJngEE4foV1KmTybwu9t0V4OsKwjmp3h9TtuywvuJjOLvEVV5BrrowWupyZKab9+9NPv2HUelhZzh1hJYpFrGgHMpLj8=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by MN0PR10MB5935.namprd10.prod.outlook.com (2603:10b6:208:3cd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 1 May
 2024 23:13:56 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::b34a:bd2b:445e:1b74]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::b34a:bd2b:445e:1b74%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 23:13:56 +0000
Message-ID: <86670db8-604c-4bad-9022-a59b8363e5ca@oracle.com>
Date: Wed, 1 May 2024 16:13:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] iova_tree: add an id member to DMAMap
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Peter Xu <peterx@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Jason Wang <jasowang@redhat.com>
References: <20240410100345.389462-1-eperezma@redhat.com>
 <20240410100345.389462-2-eperezma@redhat.com>
 <558124df-be44-47ae-85b9-0f282fc3889c@oracle.com>
 <CAJaqyWeE3kfgN5Y0=Kj6oCOFwg0H-gQEr4g3TM+3_+5N7mfd=A@mail.gmail.com>
 <450d0da1-3d11-428b-bd89-d09a2964cdb1@oracle.com>
 <CAJaqyWfXNQJQdTcJ9V-mSUrMs9up7rpAMwyK-qB3BuJwbUw+5w@mail.gmail.com>
 <f2dcbc76-f90f-4abe-b5c3-f159befd07bd@oracle.com>
 <CAJaqyWeSrwVt6imakpccieqN_3C85JcOZuj=FR+Xnmr7FKFaAw@mail.gmail.com>
 <9f347cd6-8c18-4253-8a5f-efae08230a62@oracle.com>
 <CAJaqyWeyfPp5bh9iZrkwZshoStEHZ85P6t4TcEdmR5sDYhG4ug@mail.gmail.com>
 <f6c63253-57bf-4e7a-8178-667a577784d5@oracle.com>
 <CAJaqyWdheH4MoHMOQjPmbOpODswE53w09LkfeaDNWdys3qUFLw@mail.gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWdheH4MoHMOQjPmbOpODswE53w09LkfeaDNWdys3qUFLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR14CA0006.namprd14.prod.outlook.com
 (2603:10b6:208:23e::11) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|MN0PR10MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf6971c-c7ff-4b00-8e7f-08dc6a346055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S09BcklNU0NsYk05eHNSZWFkMHhkR2dEYUdHVm5sSXZLVkhWNkRKTEUvNCtH?=
 =?utf-8?B?c0E2eEVZYmgycDdabFRMbXdBbS8rZDFuQjJFNld1Q1NLMDd4WXZicW0yY2pV?=
 =?utf-8?B?Vk4wallqK1lmSWYzZjFCb2dKSkk4SHM4ekJVRGlnWS94d0lEdWpGVmhtamNa?=
 =?utf-8?B?Y3hHSVF1UHNScm5tTmdiQ2dPdVR1Tk5naEl6d21pNzkzLy92RXhzTUEwa1d2?=
 =?utf-8?B?NWhtYmgzSUZYT1o3d0djb3EwYUZnSDJlcWFZbTFCVms1cnZLWnhScnlLVnkv?=
 =?utf-8?B?dG5QTVpzL05xa25ock5OUkVxcEhiL1NtdkpGYVhuSFpwK2Y0WSt0eWtZSndZ?=
 =?utf-8?B?NmZPSHA4bkNMU3lRVkdqVnZnKzJZYXAzSk5VeUxtM2pDK1kzQ1dHQzVTWEp0?=
 =?utf-8?B?Z0JyV2NOL01ZaVZZeXZ3MStxR0pQZlZ5TmUrbHYzYlQ3RnQ2d09vM3J5eHYy?=
 =?utf-8?B?QWZqNzVYU2FJVXRmSmhjQy9YSzljL1FZWWhhaTNSNkFudE9aa054ZVkrdWZ1?=
 =?utf-8?B?MWJxejF1M1E5dHlFb1VSak41YTZyQ3F5TDFzditVVXFiZ0E1L2dIdEdNS29I?=
 =?utf-8?B?WVJhRUxnQ2tsRU9QanR1aWQ3dEhVNWc5eWNuOENNTmdtNFVYd2VZWGN5R0xB?=
 =?utf-8?B?eVB5RkxNRWpKUkN4a1h0WTMxRi9wakpzRmlQeEdreVFNNk0zczNjN2RZTnhp?=
 =?utf-8?B?V2NoUCtQMitRWmJWMGF5SlQ2OVB1Y21NTmNPbkhMZDRaZjBkRXo2ZTF6bXN4?=
 =?utf-8?B?N1ptUC81U1AzenczYXpNc25zeSs2amVYT0tpb3dhbnRTQWg2RUFRYk9oVUR6?=
 =?utf-8?B?ODY5QnpyTjJCcEgyWHZETDlMMk9tdmFiTVR4UDFSV0tuQ1V4ZDFBUHU5U2Zv?=
 =?utf-8?B?d0l1cmM0SVI5NjVKZlN3Z2pkektTM3hnSG95VjlEOTIzVWFYRHd0MnJ4T0Jt?=
 =?utf-8?B?NExqREhMVkpZaXI3V0xnUWliVmI3c0NFV2F6eHZndnRybTdPV0pTYTVTRDdh?=
 =?utf-8?B?NGdZcW5vZzBtK01RcUl1U2VnQWxWanhrN2N4RUw1akFVTSt3Lzh6U1FhSUVm?=
 =?utf-8?B?V3I2SWwwMGdUdi9kYTdCZXA2U3hhZU5rUW1yc09YMmhYbGJYdStLdGh3dFhk?=
 =?utf-8?B?dHB5b0pxYUd6UlNwd0c2Ty90NGgyS1ZOL0dqdWowbGdGc21hSHczdGFJdVRZ?=
 =?utf-8?B?dmRZZmU0UDJCWVNkV1ErK1JTbUIxeTgvd0dsQm5wUHpERjNpc1hvMHVzcWd6?=
 =?utf-8?B?dDFlUzY4dWtPdUo3bWxqNkhLcU15SGJpZHNjOXpzN2liRDJTZ2tXVUg5UGlD?=
 =?utf-8?B?OGhac083UEgwMm5DOUtva09qVm5lWEdBOW4ycWhSeVRHZFg4N1NSamJWZnFF?=
 =?utf-8?B?NzBmR2xkcFR5S1A5TnAyZlhWVDdhUjRGRVZ4V3N2U1FGMzdKd1VRQURNSzNm?=
 =?utf-8?B?M2xoNytvZkRLWFRDeXZISmorNmp0ZFBaM3BHVGtOT2hjcWVEeGVPZXFVUW1m?=
 =?utf-8?B?UHJUaVFWbERzRWtuVjYvQnFuMmhYQVp5OHQzV3lPUEE5WU1MSE52NE5ZOFhu?=
 =?utf-8?B?bEtvc2N5UjBoajd1Y1VRdno5Kzc1Vjc1U0dudTJ5OTlTVGVqTTNUc1V3UkFN?=
 =?utf-8?Q?h5gwVHz7WMEi7tCATItzX/rhUiGxGu+wzd/R7BMPkwIk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE1QLy96RlNIRVN0MTVCbWxYWlNrUVpnM0EvMU8xcXNtZy9ZMG5oRlNDVnhj?=
 =?utf-8?B?VGwrNDN1elFBb0lVRGw0ZVBjOFlyTU0zdFA1enlSbFNmQ3ZXTzAxZEYrdHow?=
 =?utf-8?B?eTZmRHdKcWtmSkk1Rm12VTNqSUtxQm9uMUVuL25HbWdSU3Y2akdoSGJzZHli?=
 =?utf-8?B?SVNGOHZSd0ZvbkVBUFNkSGFSOVduR0ZaQmx2VFhlNnBySUgvajRPQVlDN2Jq?=
 =?utf-8?B?WUp3cnVlc1ArT2VKWUNIcU0xYU1DVmFHTHZIK1g2anNWM2gxM2dnR1pmblJH?=
 =?utf-8?B?R09pbjFqVjhEV2IrNkxQYkJUaDJEVGkwejA1bjJiT3gvd0RhUFBoUlBRc1JI?=
 =?utf-8?B?Qjc5QUFMd0VrT01JU1dtVEpVc0ZrRkFJRHhOUGNmb09FWXFRdDFmbWtkN0VR?=
 =?utf-8?B?OWtqd0haTTNMaHV4YlJKT05mN1NqTmJqVXhpRng0U21sa0VTMEhTeUQ1VVpO?=
 =?utf-8?B?OHh2VUhkMzlDbTJQcFVJY09lYlRwRllLV3dqeHYzdjAra3ZUUHF6dkxqZmJS?=
 =?utf-8?B?T0xpQ3pZcHBnVWp1b3VzL0JIZVpTV3MxcVAwbEV1SXk5MFFaSk9EckhOR21B?=
 =?utf-8?B?TFU4VlZmcE5zY25SUHpPdDhkMzVzWTlTbWZudERQeVFqRnhLQS9KVGtBQmwy?=
 =?utf-8?B?WEpsejdZRGZnRVgrUkRSMi9VTW4vbmROd0FneGd4d2R1RUVOazVNZVBGUHE4?=
 =?utf-8?B?cW9zU2hEK241WUJDWmR4bUZtbXg1dHhQMkVsdWRpYnl1OXBEd2hHT09Ra2Mr?=
 =?utf-8?B?M2VPSWRtOWZpeWJST3FGb0szbEpiOFhGRGNDVTJxeU9vY1RvdnB5WmlEYXUv?=
 =?utf-8?B?N3dDNVNRWHZZNm5rYWdZVDdzV2FudTJLcnZaQXo4bmxsWllMZ2RBQ0piUElz?=
 =?utf-8?B?NmhUUzJ6OWtEbjhMMFdPNlhMZ0dnejQ4VGJ3dnozZnNWRlQrTytZZ1FybGxi?=
 =?utf-8?B?NkxkQTVoMFdESUtrdDFndHhmU3RuK2Q3c1dBT3h5UTd1bU80bHBMc3dJNXh0?=
 =?utf-8?B?TlE3dlRXZ2poV3Z4RkJjZVozL0FOZzFUd2ZRelV3VlF6TDFSTWVEY3FKOVEy?=
 =?utf-8?B?L21FVytqdUZEamk3ZnFQRTdrMGFjU1JIeWJiZDVoSnQzKzFpWUtGWkhTbVdI?=
 =?utf-8?B?V0xOL0dwSmVrRXJpVVpwME8rbVZaRGFwNjg0VXhwaXI0Zlk2US8rcTVvQmtY?=
 =?utf-8?B?bTZWMkNYdDhJUjUyY1RsMXFhQWRjSkhiaHRPWTl4czR1MTd5Q1M0T3AzbEZG?=
 =?utf-8?B?Q3Q3YXV5TzJaTnpZZTBPUFV5aFp6dEoxcnlCMW4rZGFnUDR5MDdKQ0htS1NU?=
 =?utf-8?B?YUkxNEtyNjQrL0s4dFVvR3Z4OHBIejU5T0dSazhMd0EzWUtpNlljb0lsbExI?=
 =?utf-8?B?QlJ4dXkvTDYzNC92VHJqTjQ5RXFoM0xvYXFsVm5EMzh2L1hqSVF3ajJNU2lv?=
 =?utf-8?B?WVNwNTBaMHBXaXB0ekdkZ0cxbTFITDJUNDlVQU1KR054U2RTMkNjQ0R1WmhH?=
 =?utf-8?B?NDdUd1FQdW5Mbk5vVElwaUhQY2RYVkVLVTVOZmFsUGlkaVZIdzdLamZBUk53?=
 =?utf-8?B?RU9BbWVNckJKYytoa3lVSVlYRkczTmQxUktBTGNqSWtxRjNEdjRrQ0R5TXdO?=
 =?utf-8?B?ZWJSMlgwRklZYzJxbzN4VkYrSWNESkpkcmdGaGVYZit1TXJCWERMT3dZVVBu?=
 =?utf-8?B?MVlaSEJtbGJWYmgvelArYzhjR3dNNGwxUGdOSjVLc3BXbllXYzE4bzF6UXg3?=
 =?utf-8?B?WUJMdGFKbnVlK2xSeGxLeUFHbzUrVTQ5YVMxNU54QXE4bUxxSWRuRjN5TzhC?=
 =?utf-8?B?bll1TDJFYkNIMkN4NmJVT1o2dGNDUTByQnlkd2FnK1VlamlpamZmSjV6djlj?=
 =?utf-8?B?QzVubXdSWkNXcWR3RTFCYVdoTmIrTnRobW9KaENadVRBYkc4cEpPQUpTT0V0?=
 =?utf-8?B?clB4N25EMkZjU2lNYUxYamlwOEZoWTk1NG5tamdldklQcVBqNEYvc2ZPVGpU?=
 =?utf-8?B?RTlqSE8xOGQ3TUdiV0ZWaHB2SStZYmVwSWJyWDgxeGJ6WGJxQWEwTjZXVUxk?=
 =?utf-8?B?cFQrVmlHajZTelJtVVJ4MUg1VkhuTnZrWll3bVFnT04yR1d4MTJRQkZ3UWMz?=
 =?utf-8?Q?BIL/EMOSlDFHP908VJslVHIeN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HsmSQ976FtRWbDdkFDshoCmFABP4+ZeIwtRHTI6ZnZPnALVzuYRk/2j1QiCVMKtO+zwK/hMdyb7gg9VmN/DsI2YUbvOyNKHyhvCsiQOJLUl3rvX5yNsDDHON9sLEb+V7Ka5CI0eqU6IkpV0IraYJpPxf4AB0+LcsonST/kGiY1p3bCBOPrZqaY5zwbU7bN0JgNWYrViuY/rtRhwjAutdMP2kKrIBL67EyGhU0LH4DbsQRvdreXID1lK8Zcy3tJHncxcDrHVaCUgQJgUXuKXUT6XHoiTv/UzxYWHKjubetlOxZFTOMmFRQcOXHhLAs2zCWfssy2D9CqldLlqY8/7oOUNEG1gWL3Acp6IrdsLLtGu0zt5feIGvTfbFGr9zHd0xp/oUog+AE/WXKInEhgD0eodUlK8Ix0J4Q217CT7mfTDEdTGtIeJzHogeVhUJOdWwTEmq03pr1cj/F+0cxkZ/y26+pwMd9dMV74uJrQLO1k3tH0nIzp0MnrahrrxNuol4A/CQd8Te/eingRD/AB3xedhcFxTdAr5iJrgyPun8oOMOzHCIWFhA2V1H/7ghra8z2LssIeip4N0SD09v4utGspGbUeLJhivqGwxnfXJv/7c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf6971c-c7ff-4b00-8e7f-08dc6a346055
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 23:13:56.8341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWEAO7bIbTjcXSAf08PR9tcAtp/Nqj3j79rTCUCmpXw7OOipdPE0p1hKrZArTMUcnoUVURzgoXE84u/g36DwGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5935
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405010164
X-Proofpoint-GUID: iqbE-EM-ooMz-1-cmx-sfcVGgRIIKI5s
X-Proofpoint-ORIG-GUID: iqbE-EM-ooMz-1-cmx-sfcVGgRIIKI5s
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 4/30/2024 10:19 AM, Eugenio Perez Martin wrote:
> On Tue, Apr 30, 2024 at 7:55 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 4/29/2024 1:14 AM, Eugenio Perez Martin wrote:
>>> On Thu, Apr 25, 2024 at 7:44 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>> On 4/24/2024 12:33 AM, Eugenio Perez Martin wrote:
>>>>> On Wed, Apr 24, 2024 at 12:21 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>> On 4/22/2024 1:49 AM, Eugenio Perez Martin wrote:
>>>>>>> On Sat, Apr 20, 2024 at 1:50 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>>> On 4/19/2024 1:29 AM, Eugenio Perez Martin wrote:
>>>>>>>>> On Thu, Apr 18, 2024 at 10:46 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>>>>> On 4/10/2024 3:03 AM, Eugenio Pérez wrote:
>>>>>>>>>>> IOVA tree is also used to track the mappings of virtio-net shadow
>>>>>>>>>>> virtqueue.  This mappings may not match with the GPA->HVA ones.
>>>>>>>>>>>
>>>>>>>>>>> This causes a problem when overlapped regions (different GPA but same
>>>>>>>>>>> translated HVA) exists in the tree, as looking them by HVA will return
>>>>>>>>>>> them twice.  To solve this, create an id member so we can assign unique
>>>>>>>>>>> identifiers (GPA) to the maps.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>>>>>>>>>>> ---
>>>>>>>>>>>        include/qemu/iova-tree.h | 5 +++--
>>>>>>>>>>>        util/iova-tree.c         | 3 ++-
>>>>>>>>>>>        2 files changed, 5 insertions(+), 3 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
>>>>>>>>>>> index 2a10a7052e..34ee230e7d 100644
>>>>>>>>>>> --- a/include/qemu/iova-tree.h
>>>>>>>>>>> +++ b/include/qemu/iova-tree.h
>>>>>>>>>>> @@ -36,6 +36,7 @@ typedef struct DMAMap {
>>>>>>>>>>>            hwaddr iova;
>>>>>>>>>>>            hwaddr translated_addr;
>>>>>>>>>>>            hwaddr size;                /* Inclusive */
>>>>>>>>>>> +    uint64_t id;
>>>>>>>>>>>            IOMMUAccessFlags perm;
>>>>>>>>>>>        } QEMU_PACKED DMAMap;
>>>>>>>>>>>        typedef gboolean (*iova_tree_iterator)(DMAMap *map);
>>>>>>>>>>> @@ -100,8 +101,8 @@ const DMAMap *iova_tree_find(const IOVATree *tree, const DMAMap *map);
>>>>>>>>>>>         * @map: the mapping to search
>>>>>>>>>>>         *
>>>>>>>>>>>         * Search for a mapping in the iova tree that translated_addr overlaps with the
>>>>>>>>>>> - * mapping range specified.  Only the first found mapping will be
>>>>>>>>>>> - * returned.
>>>>>>>>>>> + * mapping range specified and map->id is equal.  Only the first found
>>>>>>>>>>> + * mapping will be returned.
>>>>>>>>>>>         *
>>>>>>>>>>>         * Return: DMAMap pointer if found, or NULL if not found.  Note that
>>>>>>>>>>>         * the returned DMAMap pointer is maintained internally.  User should
>>>>>>>>>>> diff --git a/util/iova-tree.c b/util/iova-tree.c
>>>>>>>>>>> index 536789797e..0863e0a3b8 100644
>>>>>>>>>>> --- a/util/iova-tree.c
>>>>>>>>>>> +++ b/util/iova-tree.c
>>>>>>>>>>> @@ -97,7 +97,8 @@ static gboolean iova_tree_find_address_iterator(gpointer key, gpointer value,
>>>>>>>>>>>
>>>>>>>>>>>            needle = args->needle;
>>>>>>>>>>>            if (map->translated_addr + map->size < needle->translated_addr ||
>>>>>>>>>>> -        needle->translated_addr + needle->size < map->translated_addr) {
>>>>>>>>>>> +        needle->translated_addr + needle->size < map->translated_addr ||
>>>>>>>>>>> +        needle->id != map->id) {
>>>>>>>>>> It looks this iterator can also be invoked by SVQ from
>>>>>>>>>> vhost_svq_translate_addr() -> iova_tree_find_iova(), where guest GPA
>>>>>>>>>> space will be searched on without passing in the ID (GPA), and exact
>>>>>>>>>> match for the same GPA range is not actually needed unlike the mapping
>>>>>>>>>> removal case. Could we create an API variant, for the SVQ lookup case
>>>>>>>>>> specifically? Or alternatively, add a special flag, say skip_id_match to
>>>>>>>>>> DMAMap, and the id match check may look like below:
>>>>>>>>>>
>>>>>>>>>> (!needle->skip_id_match && needle->id != map->id)
>>>>>>>>>>
>>>>>>>>>> I think vhost_svq_translate_addr() could just call the API variant or
>>>>>>>>>> pass DMAmap with skip_id_match set to true to svq_iova_tree_find_iova().
>>>>>>>>>>
>>>>>>>>> I think you're totally right. But I'd really like to not complicate
>>>>>>>>> the API of the iova_tree more.
>>>>>>>>>
>>>>>>>>> I think we can look for the hwaddr using memory_region_from_host and
>>>>>>>>> then get the hwaddr. It is another lookup though...
>>>>>>>> Yeah, that will be another means of doing translation without having to
>>>>>>>> complicate the API around iova_tree. I wonder how the lookup through
>>>>>>>> memory_region_from_host() may perform compared to the iova tree one, the
>>>>>>>> former looks to be an O(N) linear search on a linked list while the
>>>>>>>> latter would be roughly O(log N) on an AVL tree?
>>>>>>> Even worse, as the reverse lookup (from QEMU vaddr to SVQ IOVA) is
>>>>>>> linear too. It is not even ordered.
>>>>>> Oh Sorry, I misread the code and I should look for g_tree_foreach ()
>>>>>> instead of g_tree_search_node(). So the former is indeed linear
>>>>>> iteration, but it looks to be ordered?
>>>>>>
>>>>>> https://github.com/GNOME/glib/blob/main/glib/gtree.c#L1115
>>>>> The GPA / IOVA are ordered but we're looking by QEMU's vaddr.
>>>>>
>>>>> If we have these translations:
>>>>> [0x1000, 0x2000] -> [0x10000, 0x11000]
>>>>> [0x2000, 0x3000] -> [0x6000, 0x7000]
>>>>>
>>>>> We will see them in this order, so we cannot stop the search at the first node.
>>>> Yeah, reverse lookup is unordered indeed, anyway.
>>>>
>>>>>>> But apart from this detail you're right, I have the same concerns with
>>>>>>> this solution too. If we see a hard performance regression we could go
>>>>>>> to more complicated solutions, like maintaining a reverse IOVATree in
>>>>>>> vhost-iova-tree too. First RFCs of SVQ did that actually.
>>>>>> Agreed, yeap we can use memory_region_from_host for now.  Any reason why
>>>>>> reverse IOVATree was dropped, lack of users? But now we have one!
>>>>>>
>>>>> No, it is just simplicity. We already have an user in the hot patch in
>>>>> the master branch, vhost_svq_vring_write_descs. But I never profiled
>>>>> enough to find if it is a bottleneck or not to be honest.
>>>> Right, without vIOMMU or a lot of virtqueues / mappings, it's hard to
>>>> profile and see the difference.
>>>>> I'll send the new series by today, thank you for finding these issues!
>>>> Thanks! In case you don't have bandwidth to add back reverse IOVA tree,
>>>> Jonah (cc'ed) may have interest in looking into it.
>>>>
>>> Actually, yes. I've tried to solve it using:
>>> memory_region_get_ram_ptr -> It's hard to get this pointer to work
>>> without messing a lot with IOVATree.
>>> memory_region_find -> I'm totally unable to make it return sections
>>> that make sense
>>> flatview_for_each_range -> It does not return the same
>>> MemoryRegionsection as the listener, not sure why.
>> Ouch, thank you for the summary of attempts that were done earlier.
>>> The only advance I have is that memory_region_from_host is able to
>>> tell if the vaddr is from the guest or not.
>> Hmmm, then it won't be too useful without a direct means to identifying
>> the exact memory region associated with the iova that is being mapped.
>> And, this additional indirection seems introduce a tiny bit of more
>> latency in the reverse lookup routine (should not be a scalability issue
>> though if it's a linear search)?
>>
> I didn't measure, but I guess yes it might. OTOH these structs may be
> cached because virtqueue_pop just looked for them.
Oh, right, that's a good point.
>
>>> So I'm convinced there must be a way to do it with the memory
>>> subsystem, but I think the best way to do it ATM is to store a
>>> parallel tree with GPA-> SVQ IOVA translations. At removal time, if we
>>> find the entry in this new tree, we can directly remove it by GPA. If
>>> not, assume it is a host-only address like SVQ vrings, and remove by
>>> iterating on vaddr as we do now.
>> Yeah, this could work I think. On the other hand, given that we are now
>> trying to improve it, I wonder if possible to come up with a fast
>> version for the SVQ (host-only address) case without having to look up
>> twice? SVQ callers should be able to tell apart from the guest case
>> where GPA -> IOVA translation doesn't exist? Or just maintain a parallel
>> tree with HVA -> IOVA translations for SVQ reverse lookup only? I feel
>> SVQ mappings may be worth a separate fast lookup path - unlike guest
>> mappings, the insertion, lookup and removal for SVQ mappings seem
>> unavoidable during the migration downtime path.
>>
> I think the ideal order is the opposite actually. So:
> 1) Try for the NIC to support _F_VRING_ASID, no translation needed by QEMU
Right, that's the case for _F_VRING_ASID, which is simple and easy to 
deal with. Though I think this is an edge case across all vendor 
devices, as most likely only those no-chip IOMMU parents may support it. 
It's a luxury for normal device to steal another VF for this ASID feature...

> 2) Try reverse lookup from HVA to GPA. Since dataplane should fit
> this, we should test this first
So instead of a direct lookup from HVA to IOVA, the purpose of the extra 
reverse lookup from HVA to GPA is to verify the validity of GPA (avoid 
from being mistakenly picked from the overlapped region)? But this would 
seem require scanning the entire GPA space to identify possible GPA 
ranges that are potentially overlapped? I wonder if there exists 
possibility to simplify this assumption, could we go this extra layer of 
GPA wide scan and validation, *only* when overlap is indeed detected 
during memory listerner's region_add (say during which we try to insert 
a duplicate / overlapped HVA into the HVA -> IOVA tree)? Or simply put, 
the first match on the reverse lookup would mostly suffice, since we 
know virtio driver can't use guest memory from these overlapped regions? 
You may say this assumption is too bold, but do we have other means to 
guarantee the first match will always hit under SVQ lookup? Given that 
we don't receive an instance of issue report until we move the memory 
listener registration upfront to device initialization, I guess there 
should be some point or under certain condition that the non-overlapped 
1:1 translation and lookup can be satisfied. Don't you agree?

Thanks,
-Siwei
> 3) Look in SVQ host-only entries (SVQ, current shadow CVQ). It is the
> control VQ, speed is not so important.
>
> Overlapping regions may return the wrong SVQ IOVA though. We should
> take extra care to make sure these are correctly handled. I mean,
> there are valid translations in the tree unless the driver is buggy,
> just may need to span many translations.
>
>>>    It is guaranteed the guest does not
>>> translate to that vaddr and that that vaddr is unique in the tree
>>> anyway.
>>>
>>> Does it sound reasonable? Jonah, would you be interested in moving this forward?
>> My thought would be that the reverse IOVA tree stuff can be added as a
>> follow-up optimization right after for extended scalability, but for now
>> as the interim, we may still need some form of simple fix, so as to
>> quickly unblock the other dependent work built on top of this one and
>> the early pinning series [1]. With it said, I'm completely fine if
>> performing the reverse lookup through linear tree walk e.g.
>> g_tree_foreach(), that should suffice small VM configs with just a
>> couple of queues and limited number of memory regions. Going forward, to
>> address the scalability bottleneck, Jonah could just replace the
>> corresponding API call with the one built on top of reverse IOVA tree (I
>> presume the use of these iova tree APIs is kind of internal that only
>> limits to SVQ and vhost-vdpa subsystems) once he gets there, and then
>> eliminate the other API variants that will no longer be in use. What do
>> you think about this idea / plan?
>>
> Yeah it makes sense to me. Hopefully we can even get rid of the id member.
>
>> Thanks,
>> -Siwei
>>
>> [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-04/msg00079.html
>>
>>> Thanks!
>>>
>>>> -Siwei
>>>>
>>>>
>>>>>> Thanks,
>>>>>> -Siwei
>>>>>>> Thanks!
>>>>>>>
>>>>>>>> Of course,
>>>>>>>> memory_region_from_host() won't search out of the guest memory space for
>>>>>>>> sure. As this could be on the hot data path I have a little bit
>>>>>>>> hesitance over the potential cost or performance regression this change
>>>>>>>> could bring in, but maybe I'm overthinking it too much...
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> -Siwei
>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> -Siwei
>>>>>>>>>>>                return false;
>>>>>>>>>>>            }
>>>>>>>>>>>


