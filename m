Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF99CC87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 12:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugjfz-0007gX-IO; Tue, 29 Jul 2025 08:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ugjfV-0007DY-7W
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 08:43:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ugjfO-0003pJ-Kb
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 08:42:54 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T7g2Na029568;
 Tue, 29 Jul 2025 12:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=idgoHtWj8ch+kGvr6BXpPDkz5t8b5NA0alkgI4ijcik=; b=
 ZTF/3eAi1iVpn2e3O8DMopm4nzwDKm66HUbgOHk/S+CLYnxq8xyi67ggjAImzGCz
 JiuEBreSxbfPNPEAzcoGaLHi3jYEHrYaJQA8xJgVxfrOVQQw2YnFrVrd+J8Mkk6D
 4lHHhfBJ97CUfUQIJm/sAZbejGrHp9Um7yKg8Syo+YOKYUv8KdjeUvt09jeErgUb
 4J4N3ugGr2lrJvpCwI61qWyr1VPQ5lW68wDvwQpNl8j5RYs1xqO2de4oi2lwtWgg
 PTdIMb0zwlVekeqRWsp0uP28X2nmf77WnxQn2o2ObOjJengCmap5iAQ3wCd/sf4k
 qq7+/OHoGW02IPqDiWEgdA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q29qnha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Jul 2025 12:42:03 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56TCGYY9003128; Tue, 29 Jul 2025 12:42:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 484nf9vfge-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Jul 2025 12:42:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eiKnhLAhtSgtSpaknc/p+f4VdZ9v+WevhgfXGH07uw5YRtb3DYkCjH1Y6PzT/P6xgWP+ZRlSyeIoXyBoWAnRD9YMtzN9vLyn9pQUplnRVj1EwiArWyMYsjQjmFp/DTYrjdZsv1s+zFmmYNKJmW2gzsMh1YF2aePDYWQPE/cPYNrK/fTyZCl/+333A7TGmZ6IfFMfEc87wwrwR2XQ6KSq4Qqr7YNpsnulTS5Zb1S9eFd0rhZK/WfD7FMB1lIsFmuVHmSn3Cdzgq6JZkgLHpu4P8QKKdJZ1pWcg+w3Nf+InKlwnCvc9IC10D29MikHLsjW5RC1PQCtpeKMfwTWBZeJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idgoHtWj8ch+kGvr6BXpPDkz5t8b5NA0alkgI4ijcik=;
 b=neb2Bd2SU8YAWMU2lumg7ma31+CSVBVtKejwUR+KvV1PZ9juF7fupoaX0l41oGgqIIWYeXuxuO0oxyVC8sKJfX05GWzfgqc8adX4wx0UklVbvwcBGBZG/Dlfk0UO/WuSwL+jIzgw3rQvFfoqOkIuerWNyiGbxoHVAuqdnhHMy/X3BAnNpkaWYnguK8M3/vX5fxVMIHdbnEfWXPr88sbWLIWYe3KKzFDgrWiZ3zIEh6z8f33q+iU/zwkA+A0RwWG06P7jkTxUYLZUJgGUTk3tDb5i7H01uQAsf63YEZBlYlEzS/fd7hmH4CfujkNi5KHpzGxoz1wevhnBJUYAu1CRjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idgoHtWj8ch+kGvr6BXpPDkz5t8b5NA0alkgI4ijcik=;
 b=sNEbpk+fQrCkOqoshRfN/dZV58fPgMi/hiiQZ+QOanEE+FsH+B6r3Rcy7KHOebAKuWhMsJ72NCwpPgPcc1h8oXl/KXpCq3v9muxNi13wmJeRXto4FNH0bZDuXvVzgPO7cZAZKbmvBIOcTnfXSf43nCDANp2BivxpsNxxT1vNFC8=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by MN2PR10MB4350.namprd10.prod.outlook.com (2603:10b6:208:1da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 12:42:00 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6%7]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 12:41:59 +0000
Message-ID: <a389b7e4-7435-4512-8ad5-f58fae60b2b0@oracle.com>
Date: Tue, 29 Jul 2025 08:41:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/6] virtio-net: initial iterative live migration support
To: Jason Wang <jasowang@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com, si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <CACGkMEvrgAqSr9sgvq6F4oKBitZncqhsB_MEsbaNB7p0ZN5fEA@mail.gmail.com>
 <0f5b804d-3852-4159-b151-308a57f1ec74@oracle.com>
 <20250725053122-mutt-send-email-mst@kernel.org>
 <CACGkMEvTgCAbBG20iLB1m_WfYzMZA7FYZ2FuL6To4EV86PXZbA@mail.gmail.com>
 <CACGkMEtCiqq0P_7aB-d5CrQraHL2xky5Qa+9LyZce4hk+wvvYQ@mail.gmail.com>
 <CAJaqyWeJVjG+FbXvYZOu7fXXg-U5vSmt8_+YDw_t7hKv5DH8ew@mail.gmail.com>
 <CACGkMEvq0zX+HQJSpjOVB_0_5R=N8_xe2Eb5g4SA1HqeiNHGmw@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CACGkMEvq0zX+HQJSpjOVB_0_5R=N8_xe2Eb5g4SA1HqeiNHGmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:208:32e::19) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|MN2PR10MB4350:EE_
X-MS-Office365-Filtering-Correlation-Id: c256c51c-72d8-4541-76c9-08ddce9d4f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RldpYkJwQmd1QXVWa21Dak43TmJ0M1hPbjhxZTZ0SU9mdTlqUC9PZHZ4UjhZ?=
 =?utf-8?B?RjRsQ0JUK3ZNQ053bHVzQVVEbm1sdTFDNDg5NFNSR08zZVRzaC8wUGl0ZTJP?=
 =?utf-8?B?cjQ3eEZJRXA5cEZqb1c1YlVwL3NoQnJYVWQ4STJ0eVhxRzBLanE1cHBoTUg3?=
 =?utf-8?B?NGdpcUNWYUIvd0x2a01pN1JWSFlKdm1BdmRqOGFsRExiTVBvaVNQRk56WkpX?=
 =?utf-8?B?MklhTXNhK0VoejhaNDVvSWxlZkVzckcrMExNczhZSitQOHBhZ1BxV0RCVGhw?=
 =?utf-8?B?R3JyMTJ2amVBRGQ1SFNIbzdRbWlEdncvVllFUkJTbnlNVXd2ckJiQ2NWWFY5?=
 =?utf-8?B?SE54bW8xNDJBTDdOSndzckk5UXR3VlR2ZWQ5NWJjTG1IaTR1ZGNxWjhRQmdy?=
 =?utf-8?B?SUhuNlVqYXk4SzNlMVRBNVRFZnNjQW9zSW9zbzZmVHR5VEROWHlWbThqMGhj?=
 =?utf-8?B?YkJoZHMrS2RtZWhrVzNtbTBSMmtaV3lUcElta3hOVXZNZVBkVGNNbC95c0c5?=
 =?utf-8?B?aElCMS9wLzBpMDh5angzR0cxTVdPLzR3Q0dGUlRZWjlocnpHMXlpQ2h6SWhG?=
 =?utf-8?B?QU5HNzl1TWpIYkJPUW9CM05kMUVSRzZTajNVK2hZc3MvNmRpZkRWRGo0TURn?=
 =?utf-8?B?YlZYVjloektzYVoyeXFpSjl5NXpmeEFPMG44YzNKQWJwOUtvbGgxSXBLdCs3?=
 =?utf-8?B?ZldiODlOWHVBUVlOUUg5VkhGS1lIcmpZTW9LWTBLSGViejJGdi9tSENXQnZH?=
 =?utf-8?B?eDdVVXZMV2RZVy9jd1pKQ09VLzAybVlZSjcwc0pmR0pFejZEY1djcTRENTNk?=
 =?utf-8?B?aE9GbnpyREhOcHBUZDNha01VOENUa1NGQmZVWlByUzQ5bGlVVXI0YzhCR3ZF?=
 =?utf-8?B?b2FaTlNCQVdXOTlYelY1dHhsbk5mcWVoazZqSEZqdUxBb0gvZG5hazA5QVli?=
 =?utf-8?B?T3R0QmczNFZHRE5TL3d1YlAzc2JyczhBZFRmYklvTkQwWmd5MUNVNGdDazNR?=
 =?utf-8?B?S0Zyb1BoQlZENkd2UU1BYTNHbGJwR3BuOVdnbFdSbExyTE1wM0x5U1AwZ2xW?=
 =?utf-8?B?UXhpRXFFUVdPVE9yTjlHcGVES05PdUJXZ090S3ROMmQyay9JSGhOM2R4UzRN?=
 =?utf-8?B?NHRBKytsUW96OTVRQlFmTytHSDc5K043YnRHc2toWjJqR09QVkR4SGR3b2Q1?=
 =?utf-8?B?Y2NWV29MRTM1UUp6YjB1aFo0bEdITVJWbEd5YjN2anpMR1c1Ty90V3QxdEZX?=
 =?utf-8?B?NVd0WHBYMXM1aVFHNE11RFBwMXJEMzBkQ0JyVitINCtxL2NiWUd1bkwvLzlV?=
 =?utf-8?B?L3NiOUdZdGxtTVZFQXJ3dStxbmIwa3RjREdXakZBQmZPR0hMRVBsS3ZXYWFn?=
 =?utf-8?B?ZnBsa3ZJd2F1VWxWUmp0SEdRY2Z6Z1d1ejJZKzZFc2ZsWVFtQ1FUbElucTZo?=
 =?utf-8?B?Sm9kRm5DeXhsZmwrWSsyWVBXSG4xeFJnQUliNFJKeEloZFhuY3RwTXdmZXhz?=
 =?utf-8?B?NXoxemh3UDFYRGVQM1BielRvOE12bUJlYTl4a1c5cGRONWoxczhUMXQya2FP?=
 =?utf-8?B?RlN1Ny81V09ZTTBpcU81VG1wRzM5VENVQ2FtK3dDNTBrZzZxaFBoVGNtSzhX?=
 =?utf-8?B?MElvdWJiUHhVNnhmUktIYW9wcXJ0Sm9PTGdqY0lTdERGN3JNRklEODNOWGRa?=
 =?utf-8?B?ODFtWkZsQXNQb3N0RTBjUWFOKzZqV0FVak5RMXEwQ3lVSGxGTkNPM0hBME94?=
 =?utf-8?B?dmcramh6ZmtJenpaQW1qdDNjanFLZFlLekpDRFd1WXBNbzN4YTFaUGRqeVFi?=
 =?utf-8?B?T1A2c3pLdVROOWlGdm1XMkh2ZVBISU8vQnZtblFPdG8xWFFEVWJ6cURwWXZN?=
 =?utf-8?B?V1p1Q3AzTXh4VU5GSDA3ajFDVDI2bktONUxCb21IYm5hSVc3eEEzV1JIb0xr?=
 =?utf-8?Q?7dbh9m+3HIM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTFMQzhSanVLdWN1Vm1VNmFSTjVSOEtqTHppM2h0V1I5QzBFbjBWd1lMOFQz?=
 =?utf-8?B?RkNTMzRHbmlSNjllOW1QOXdYVXliQlJZQXJ3U1ZrWnpmUWF0NXgybk1UbXQ0?=
 =?utf-8?B?OUp6alFmbFlxcUlhTEtxdjZkODdGNEp5YUltT3ZzSDh6WWtoYm02b0JvaTMz?=
 =?utf-8?B?UmtQQXQ4K1JEL1RpTE0vOUN3TGhMYmxiVGdSM0dSZUVpYUNNbms0Y21WdHJl?=
 =?utf-8?B?TlhKTmZMM2dKbEx3cHFQUnJrQTQyUW13WXRXRjc3c2pjMHcrWThqd3UwRnEr?=
 =?utf-8?B?andvNG8rTk81Q1hNL0dnYzRFNzlINHNhYlZsY1BnWEFaNFl1dGNJQ0t0WWtH?=
 =?utf-8?B?cFVhVC8zNVkwNFNBN0pmRWQrYTdpMUVQQ2hDNFNyeTVhUVF1TVhYcjBJV0Zq?=
 =?utf-8?B?REwybW9vd0djSlZzNE9BQ0x1eXhlZXJjKzdLd0kwRmdxSUMxbitydU9aRmdi?=
 =?utf-8?B?eXE0aUh2Y0crQWhZY2pYYU10U2tsa2JjREV0Nm5uMlZhV2dJTW05elM5SjVr?=
 =?utf-8?B?UlVuUHdOK1ZSVEtHK0x0NmhZVUtPc2RZS3p6dnN6SnNsWVhvV0dqS2d1djRL?=
 =?utf-8?B?S3RRN0R2UnJ4MVhhakpQODdNTU9Td1dCSjZUMjE5N08wc3BQdW9wWkVRRTNz?=
 =?utf-8?B?bnU3VSsyeUxyNTR5bENZK1VBU1lRVlgvZWQrZHc3RGFhd0tzQjhDNGJEd3lh?=
 =?utf-8?B?a0RPMGxMZE83THp5QjdmU3Z3SHdEeGhoL2x2WHVET3NFeEN1UjlseWVFb1p0?=
 =?utf-8?B?WEh3a3VhT1dOb3BoekpONHhHQnVkaXQ1NVptUE1MM3JwM0JJUm0vQmNoWlRO?=
 =?utf-8?B?djZnZjlVa3BqRTNZdVdqaFZwYU5xMTRTVWFNeWpxZElOTHBNOVJOdWtxaXVB?=
 =?utf-8?B?WlQrNGIzODdCWUJqb1lBVkc0a3JLSXJ4ZFhEcE9RaHRGRHl3V25IeUk3Q1du?=
 =?utf-8?B?eG9tVUFnVm1KMTcrTk9iZ0xnNG96L0MrK1VlbTJsZ3FiMFF5SXdGTEJFK0ZW?=
 =?utf-8?B?ekhhb0U5Wk9Qck9IUStwTC9ZQVR3SWdjUjV6eXJUemhQNTNNbllJK0M5L3dj?=
 =?utf-8?B?eWM4d1Y0VW5hbWVuSlJzQSs1NHlKUmpQVU5kRXR1ekN4cUJ4QmRMS2hUcXNr?=
 =?utf-8?B?aEtXMlh3VzExaXN6VHFVSnRaREtFRzl3MHRxZk55SFUvaTYzTG9TaVdQVWNO?=
 =?utf-8?B?Z1VZWkR4cFRxMjF6cGFhV2VsY1VZOUpoU2g4QkZuTDN0WlJWSmc2dG1hbGh0?=
 =?utf-8?B?enhhMGwwekZ0WjlVeTlwOTZyb05lOWRtOEVKSE1tR29RZmVHVlk2Ynl1K3BY?=
 =?utf-8?B?WFdTMzVhUW1TY3ZFYkRScUF0OXdyUllQVWxrUFNmV0o5aUlWR2loM2lVcnhL?=
 =?utf-8?B?Mzl1dDJoUG9QTktrb2Q3VjZxUFMzTjMxNExyMDhUV00rWEZSSVNpR1EyeUpV?=
 =?utf-8?B?OVV6S2pFV1l6Q0hOOFg2WWFSbytGZUxGdjRmS2E0eHpDNERWbGZPblljYlB4?=
 =?utf-8?B?MXc0K2VqRVZlTTRhK1NIZlIzU1EzU0M1U21HTThkRFNaaVdIRmRlbkptWkZD?=
 =?utf-8?B?SFZKTG9QS3EwM2cwYy8rYnBqT0cwaDZCeUF2Q0N3RkFtNmc2N2ZNRFpRTkFH?=
 =?utf-8?B?RXFYYmd3ZEplOWRabFEwSDA4clVwUnE2YXdCdVhkVXlhTUhDd25nSm9OR203?=
 =?utf-8?B?azM1L2J4QTFzZ1Z0bUlISXNmZCt4L2NINC9adUIwSWM4WGtaYXpPSGdZbVJv?=
 =?utf-8?B?Zkg4bEVtQnZGZFB2UlFvU3BYRnRPVFJJSUJkdEM0SEJlRFpKMTNYcUpZS0dj?=
 =?utf-8?B?Ym1KS0wzSlAwREg3UEJwWFBIbDlXSjVmTkxLUlB4WS90ODhRVUdYTzdSL2Q0?=
 =?utf-8?B?TmhFMzNqSjRkREMvYnFUbVUwOUxieUZZbjJYZjVSL0lLTHEvNllGMHdCdFN2?=
 =?utf-8?B?VGZYYXI1SkpuZUhuN1BiV1ZQOHp1K0w4RzZZdDk2MFg5MXd5bFk0U0pObW12?=
 =?utf-8?B?YmsyOXp1MGxzeHJwTk5mOURuTFFtbmpwZmpDNlZUcW9OZkU5akxucGxKbWUr?=
 =?utf-8?B?emxJaWdXUVRQUlJYR3RJdzU1Q2ZGUXIybFpzUFZRbW9IU2RTUHdaQkJTbklQ?=
 =?utf-8?Q?FiHQpWuqHbs8dbLS3TR1M13rr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8NgtoP0+SGt6lUT2wNgHiq4DH0icvnbKNjWyc6s5TcPj3OW5JOlfC/KzZOj5Msd5dKr06i4CwEyLd35yLnh2fsOZrsYa4H3fpw7FUOp/fot+HPARaigMqtDbp09h+KJjtHqutixReCmav/yQXvoGkhB7BKSoxuMHL0Th28eexoLnYhhSiUqdGdZsHPO0H8ZyI8SAptQQ3arJ+STjKS9NzmFkBPbv7LcxsdhBdRHszE7lBtL5ACl/eVaBGe/7poTw59odj23zmuxz/hJuDXITQRdeHZb/Jk7HuacY6nwU3txmM9AZhYbrD6Im7JSSzj5tcQ0Fluz6tyT8QoSERbC3vdXkQyoN1WJ2MAAM8dGeMhEMKyX+ATnkjxKcKvYZomdmfz6FdvFHa9knTXpVCFbSD06DJfkst9EF+J7MxKiAUvrv1vjn+K37/EWZPxMMS3qdALY0iArk6MqXmN05IdBTD0wJULgopkBoF15TCvgh+KStGILpwi4XdcKS1jqYPgmU2SzQOX7LKW5n+MaMQKgiqR0kTn6swIBiPZm4dHHBqw1nNIpDqUJs0o4IIFZYE5PSre5N8mc0z5BNVVh4UunzCs6KpkaFfvREeyrlYWPGF/E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c256c51c-72d8-4541-76c9-08ddce9d4f35
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 12:41:59.4130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rJMwe7e3VIsJ6t9opkX4876zD+dHwXIYe0vD1yyXV1meUgcTO0QrVDlqgpdb5OXAWft1N3J4mS4sLqzAjQurw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4350
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507290098
X-Proofpoint-ORIG-GUID: LWHDpAh2XBpXoRQiI9im80eB7LGv9eHK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA5OSBTYWx0ZWRfX2ZTHivfyUDiv
 NL5bzRb9DX5Swq08uCPzbOz9Y2e0axtz715k5LpLa/Be4J2EfzLH3aROu65t7a/ZZPcBl8/ukGv
 T9obCNvEHCgzmvUNYqZXwjsPPRKufUrBA9I4Wmzw/an9uMyjk9uZPTllB6UTLANckthPdPiW1+3
 P4F+I4Z2Fq4tDaGoCvfxvg6ISelLYtUBRHW7PA9LYbYTcCrl/aAzKV7JZaEkp8f9CLUrWElxj/F
 hoZuiaibNYj6DJVcAE40+hB0H4RL0fmoKweIF6urvKB1aTmR9rCsjnbPLf+55XpNiDhMgnU5ciD
 8kRPiOx1bi34jbcsdUKcjScR32hqLIMW1mbrjnnVpoDIX4lH64lfPwKpxDv6PjeZqx0sJm4913B
 bHPZjdoqf7FyNnWmopVOr7rCdRmD3GmqDADbZBj3TFxWIumhDxWRuVfx9dOKzHKakk0m+D4I
X-Authority-Analysis: v=2.4 cv=FvIF/3rq c=1 sm=1 tr=0 ts=6888c19b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=ei5iHy8fIMy4hrMKJfYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: LWHDpAh2XBpXoRQiI9im80eB7LGv9eHK
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 7/28/25 10:38 PM, Jason Wang wrote:
> On Mon, Jul 28, 2025 at 10:51 PM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
>>
>> On Mon, Jul 28, 2025 at 9:36 AM Jason Wang <jasowang@redhat.com> wrote:
>>>
>>> On Mon, Jul 28, 2025 at 3:09 PM Jason Wang <jasowang@redhat.com> wrote:
>>>>
>>>> On Fri, Jul 25, 2025 at 5:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>>
>>>>> On Thu, Jul 24, 2025 at 05:59:20PM -0400, Jonah Palmer wrote:
>>>>>>
>>>>>>
>>>>>> On 7/23/25 1:51 AM, Jason Wang wrote:
>>>>>>> On Tue, Jul 22, 2025 at 8:41 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>>>>>
>>>>>>>> This series is an RFC initial implementation of iterative live
>>>>>>>> migration for virtio-net devices.
>>>>>>>>
>>>>>>>> The main motivation behind implementing iterative migration for
>>>>>>>> virtio-net devices is to start on heavy, time-consuming operations
>>>>>>>> for the destination while the source is still active (i.e. before
>>>>>>>> the stop-and-copy phase).
>>>>>>>
>>>>>>> It would be better to explain which kind of operations were heavy and
>>>>>>> time-consuming and how iterative migration help.
>>>>>>>
>>>>>>
>>>>>> You're right. Apologies for being vague here.
>>>>>>
>>>>>> I did do some profiling of the virtio_load call for virtio-net to try and
>>>>>> narrow down where exactly most of the downtime is coming from during the
>>>>>> stop-and-copy phase.
>>>>>>
>>>>>> Pretty much the entirety of the downtime comes from the vmstate_load_state
>>>>>> call for the vmstate_virtio's subsections:
>>>>>>
>>>>>> /* Subsections */
>>>>>> ret = vmstate_load_state(f, &vmstate_virtio, vdev, 1);
>>>>>> if (ret) {
>>>>>>      return ret;
>>>>>> }
>>>>>>
>>>>>> More specifically, the vmstate_virtio_virtqueues and
>>>>>> vmstate_virtio_extra_state subsections.
>>>>>>
>>>>>> For example, currently (with no iterative migration), for a virtio-net
>>>>>> device, the virtio_load call took 13.29ms to finish. 13.20ms of that time
>>>>>> was spent in vmstate_load_state(f, &vmstate_virtio, vdev, 1).
>>>>>>
>>>>>> Of that 13.21ms, ~6.83ms was spent migrating vmstate_virtio_virtqueues and
>>>>>> ~6.33ms was spent migrating the vmstate_virtio_extra_state subsections. And
>>>>>> I believe this is from walking VIRTIO_QUEUE_MAX virtqueues, twice.
>>>>>
>>>>> Can we optimize it simply by sending a bitmap of used vqs?
>>>>
>>>> +1.
>>>>
>>>> For example devices like virtio-net may know exactly the number of
>>>> virtqueues that will be used.
>>>
>>> Ok, I think it comes from the following subsections:
>>>
>>> static const VMStateDescription vmstate_virtio_virtqueues = {
>>>      .name = "virtio/virtqueues",
>>>      .version_id = 1,
>>>      .minimum_version_id = 1,
>>>      .needed = &virtio_virtqueue_needed,
>>>      .fields = (const VMStateField[]) {
>>>          VMSTATE_STRUCT_VARRAY_POINTER_KNOWN(vq, struct VirtIODevice,
>>>                        VIRTIO_QUEUE_MAX, 0, vmstate_virtqueue, VirtQueue),
>>>          VMSTATE_END_OF_LIST()
>>>      }
>>> };
>>>
>>> static const VMStateDescription vmstate_virtio_packed_virtqueues = {
>>>      .name = "virtio/packed_virtqueues",
>>>      .version_id = 1,
>>>      .minimum_version_id = 1,
>>>      .needed = &virtio_packed_virtqueue_needed,
>>>      .fields = (const VMStateField[]) {
>>>          VMSTATE_STRUCT_VARRAY_POINTER_KNOWN(vq, struct VirtIODevice,
>>>                        VIRTIO_QUEUE_MAX, 0, vmstate_packed_virtqueue, VirtQueue),
>>>          VMSTATE_END_OF_LIST()
>>>      }
>>> };
>>>
>>> A rough idea is to disable those subsections and use new subsections
>>> instead (and do the compatibility work) like virtio_save():
>>>
>>>      for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
>>>          if (vdev->vq[i].vring.num == 0)
>>>              break;
>>>      }
>>>
>>>      qemu_put_be32(f, i);
>>>      ....
>>>
>>
>> While I think this is a very good area to explore, I think we will get
>> more benefits by pre-warming vhost-vdpa devices, as they take one or
>> two orders of magnitude more than sending and processing the
>> virtio-net state (1s~10s vs 10~100ms).
> 
> Yes, but note that Jonah does the testing on a software virtio device.
> 
> Thanks
> 

All good. I also have MLX vDPA hardware for testing this on.

Jonah

>>
> 


