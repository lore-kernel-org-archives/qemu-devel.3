Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584BCC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 18:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raK0p-0002SB-Ce; Wed, 14 Feb 2024 13:29:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raK0o-0002Rw-JV
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 13:29:38 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raK0m-00060R-FG
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 13:29:38 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41EIK8HK031319; Wed, 14 Feb 2024 18:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=G+lgVZYnKViGrjlRDmzmxbesO58U66FJ1rPpFPiy1lA=;
 b=Qlu/E8uOi3zHGOmZ2SVqp0BNwBQCJo+vOLqC/jI8n16b4/uuSy5C0WKViEYQ9gxi8Ypj
 FqHUZX4PiDvM0jaiEEjz0uHi+K5F/zyIeVLYP7X2Cv8KlheDlRLHjqcwm2PVCcRNNzj8
 5gxz+X7c6BPbdN8D4VmTbqCyUHNNn7YFv2fH09gJL8nWT4ZBCWDyXEgRMMLCJX0y37Uq
 894f0GuGy0zBJVvM/mTqJnQmgljgvgTIkGZgjg5gxfXSKHl04erIGn5DUNfyRibcJ+5G
 ONTNNsvsC/OHGSeFHpGH3dq60JefixmDHz7Z+/EFR6lnGPvyaHydmsYc5PePNkhy1fnC tw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92ppg0ru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Feb 2024 18:29:30 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41EH7DCr031528; Wed, 14 Feb 2024 18:29:28 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w5yk9b378-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Feb 2024 18:29:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0eT5znS309PqL+bQWe2UDGAoYmzHLqpZ2vk6m2UKGrkNiZobYkmdqYQKflItc0H3VVyzz27/ArHjUO886mEQ1ykqCLIWD8rDPKPfH5ZKUYlhCSbIDVGVAMSLQFqtnUhkcxIP18Tzh4Cu4o53JBKWAP9bjnZycPKpM2E1f+KIPwfCfJVA618BYDNrulayWH4QMTF+Ecr+hs5jvqdrZgU23spbKciF6vVZ2lKbF2vbDXx/9/L9bMq8ZTaOX2NzDVUXQP7oILZeqeaTtSYWuYD+Fj8rc8fIvqQ3FpC2eCUwEHE6I4LeZa2v8ZX74zAfg9RBlzIiL6tDQShrkoAnwPdiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+lgVZYnKViGrjlRDmzmxbesO58U66FJ1rPpFPiy1lA=;
 b=CuNtIVLrBeOH49jXl32yI8M8DDODCHIpeDBkHGsRP9lYPMx3Kw0GwQEcwv7zm46002c+fPtQZNe8FkxpnVD9EcJhBI1b6U79NdSgoL0OVulPmm0Y2nsRyB8K9Mq9vvFFY0ayoJOmJCp/tZVyvTBNiPHUM4k0HSYLJ86150q59oOajqaxZvku38O/+7t6ZleTFjh/KKDm194FLZm1njNVQHlKu825YVzHXsLgnySoD4mHc4WciTUBDE+Cqid2603Xcr64gqTQy8swIrrENM3g3reHZd1FkUWHBZieD0juZUDM3tgJf++cAMMC0unS3+6fGDPgYJmpN6PWGf23tv58mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+lgVZYnKViGrjlRDmzmxbesO58U66FJ1rPpFPiy1lA=;
 b=TKEXIliCGEER8Crt5VIncPjoyvrEH9Azs999z5dSLcfGxB2Pyp9a2XRNwXLAkHk/1947yMw9nl2NZElcXW7ziubCEuoJmn51mT+8JJ6BImvof2mqBHG4YVBR/at+l6jYqUkNOqKfpnd/NuQye7/iyFkYdb257yvCsN0Iz/xlMro=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by MW5PR10MB5873.namprd10.prod.outlook.com (2603:10b6:303:19b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.41; Wed, 14 Feb
 2024 18:29:27 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::7368:33a0:2dc8:38c6]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::7368:33a0:2dc8:38c6%3]) with mapi id 15.20.7292.027; Wed, 14 Feb 2024
 18:29:26 +0000
Message-ID: <c45af489-0f0a-4fc7-ad03-4a513f8b338d@oracle.com>
Date: Wed, 14 Feb 2024 10:29:21 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] vdpa: move iova_tree allocation to
 net_vhost_vdpa_init
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Lei Yang <leiyang@redhat.com>,
 Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>
References: <20240201180924.487579-1-eperezma@redhat.com>
 <20240201180924.487579-7-eperezma@redhat.com>
 <9a919f49-cf88-4c72-92ff-f0c18a5593f1@oracle.com>
 <20240213052102-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240213052102-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0PR07CA0105.namprd07.prod.outlook.com
 (2603:10b6:510:4::20) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|MW5PR10MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c39bf4-8ca5-403e-091b-08dc2d8ae00e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wh6NCvaY6KB73L+gbLbRZea1euWVU5G8goKV8Y/xvKcliv915hhKPkTK0juRIqoRBYE0ho34+DwILachvQf53ein2K8g0X5YykQ0vWO8aWrMYyICCkoC+F/XQZ+bnqqzNwF8oJNiQw+4drB2iPXrJEc9qXzl4Vx+lBkDsXYYWns/8LqvJx82D3tUlVsXua2XXcpX93LR9wZLqBo87KGEAKYZ5q0QqvaX3RM472F1Calva6ZCBRaEusTE8ebZBMOAQzpqx0pB3TQnA2Anv6mJGYZ+BXIYC1DDiakzl1BlaPLA/pL5Z0Ypy7EvR6po6rnA/p8XYHUG02B91khF2nAFT65DwWm2RBqY6D8aLgKXmtpC3R+B97cH2+Hzl0NmGx8Xt8aIXzT0hmMwo/S2miSCf+N5QJwdWefV0k9GzK3vfFeKa8MCTqZdUuINA/YW5IOoV8Z7kP9MUl0mn9RgwiYwTz6wLQG6fKKSE3VwObQNSLR1K7d4k/XDJ1nsCdLIta1iGp1AbY3Ye3tVSdQ6zmqBydF8SAX6rWEt2wGj8Siuqnu9PXeYosVJIrdkSzNnmV6H
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(396003)(366004)(136003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(31686004)(2906002)(7416002)(5660300002)(41300700001)(2616005)(8676002)(53546011)(66476007)(6512007)(4326008)(66556008)(6506007)(6486002)(66946007)(8936002)(83380400001)(6916009)(26005)(86362001)(54906003)(36916002)(316002)(478600001)(6666004)(31696002)(36756003)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzRtbnNON25jRHFMb0IwMHVPMXZlQWpxeEpmZTZKdHc2OWdyMnp0V01RZmwz?=
 =?utf-8?B?WElIZGNVWkJRSXpjK2o2ZnNodnUrVWZEbzJyQTF0bmdFTVByMzQzVHBJMCtX?=
 =?utf-8?B?VVZ0TENka2NSZmNiREJKMEpJSnZuYTh3cm0rSVhsZWwwcXFUMHJEaG1Hbi8w?=
 =?utf-8?B?M0FTTitYYUkzdnhSSGlzSkN4TUFiM09LU2ZPOU9VL3pDTGc4emJaR3pDcjNn?=
 =?utf-8?B?VkhMOGVpNm1sVHFMWC83dk5Td3F5ZnJmNWZvUVppN3ZFeDhmUW5OUHM1bFlx?=
 =?utf-8?B?eG1vQi9HV3U0bnFaaGFPeXArU1l2Zm9QZkx0SHl5SFpLTGgySkoyYk8wNFlZ?=
 =?utf-8?B?TjJFYW5KZnN0dHgzSkJHdXY1ak5uR1BuZUxKTFNmZytkUGk5aXQ0S0Y1ampN?=
 =?utf-8?B?QWk1eDBjK092dEtOaEdDaGNWc2kxRUpwZHBGSW9ZMjBLSzkxVTBGVDFhSUFR?=
 =?utf-8?B?NHhaT1RSTGJNMnQ4elhxcXVRNExaaUlCN2RRM3VOUE44VVJ6NzJOc1krL1BU?=
 =?utf-8?B?WG5UVEhnaVJGbEM5YjUrcHRjTUtocUZSdkxwOUkyTUZIbWt0T2ZON0hKakZI?=
 =?utf-8?B?WkpVa29MWXl1NnlqU3FNbnV5SllJVkZ2WGtvYVZheERUNktGaUdibDhkRlJE?=
 =?utf-8?B?ZWU3YUgwRTNkeFRIa2FsdksxVFdPcVQvcGdmUzVma1h1QTkwejh2OUswS0Rm?=
 =?utf-8?B?eHpJSkVXNEhNbGdTcHlyeWRJZi9ybE10R2hQYy9rWG9XMDc1QWdjK1h3c0xn?=
 =?utf-8?B?MkRMbkZxR1paczNBbWh2M3FWR0JTZG5ISFo5dDgycnoxaTg5TURRVTZwRm1u?=
 =?utf-8?B?ZVUrS1MxTUl6Q3FqckM1dThNcXhucHFaVHNTTEEyRWhqWlVsRFk5RW5uSHRX?=
 =?utf-8?B?Yk1aNDNDUTBlRVJyazVWL3daSWdtOEZYY0UxcGhoUFFMS0lyVGtnKzdlMlUv?=
 =?utf-8?B?amhsTlJQTHlTRWp2c1V0ZW9xOWpSVUFjRnRSWnp0ZFk4QUpkQ0ppZVphb3dL?=
 =?utf-8?B?ZXhRSTVZSUtNa0J0ckxOd0ZHQzc4N1pxZ1RiU0c0QWtjRUtNQVdwQi8xZGlB?=
 =?utf-8?B?cFFjZzY5RVdyNm41a2pUUURNNEZUcDhVWmdRRGR0ODUyV2d1UlVYRk45ZFJx?=
 =?utf-8?B?bk85SDkrOUlST1BaVm5ldGV3WHF5a0o3OWhtZCt4ekQ3K3A2RFVyY2hDdVZs?=
 =?utf-8?B?QmVQQ2pxSERwM2ZkMmJLTHFpL3dZZXRSU3NqTkpRVUtUT1dWOHkwUXcwZis0?=
 =?utf-8?B?Zyt3a3JwSnZadmtJMzlNdGs2ZmgxWWZTRm1wV1doeHBabG05QlNMTk1RNzBG?=
 =?utf-8?B?VGNFUDFhTW5BQkp2V0p1OWlGTDcwUFdzU2ZrSXJZSDc0UXU0K1FoN3N3VHY5?=
 =?utf-8?B?WE1mQm9NTW9DTDY2WWVreFVXQmNLYkdzZEhPYXUwYkhQbDNRVEdWelEyU1RG?=
 =?utf-8?B?RHBLOUtaMFJnaGJXMWhlb04vSXB0Z1VqRHUwbm85QVRHOFpOM3lGYzJJTUxr?=
 =?utf-8?B?ME5Zc00xZWpyak44eTVxQzh1ODJXd21MalNSWWpCanU4cEVCMXgyUWZSUTJS?=
 =?utf-8?B?MU4xMGVhcXBOVXlZSEpkQW4wVk5ZanZkUFd3UkIzamg0eGpRTTg2NHl1eU1l?=
 =?utf-8?B?VXdOUHJMSmxqZHBYZmZMdm10a1EvYVo1dW85ZWs1VUZ0M1dYdnpvdEtPUXgz?=
 =?utf-8?B?c1F3ZmZDeHE4NmdyMGJsZkJaT2ZTZ3cwMzNwaHRpSzRic3Z1QjQzRW1lRkRQ?=
 =?utf-8?B?RnJPMTVQNE1xZXAyZkZKYWdqUEZaRzBmaFRJZDhRWE5JMXkrQ2tnL1QrSmox?=
 =?utf-8?B?L3NLY3ZSa0FTdnZWUkhBT3pTd0g3bUpvclhGSG1WWmFmTmk3Q3d1WWxMa3BR?=
 =?utf-8?B?WW5FdXl5UGxpODZDYmlhK1pKOFpqdXdDYlZJZzJWemFRa09GUUtEeFdjbXFD?=
 =?utf-8?B?OU9MZFhlUXBpTm5EMkNlaDE0TXdrMFNPdi9QaUl1QlI1U0ZjTFQ5c1JrZVlD?=
 =?utf-8?B?Sk9PK2poSUNJRWxOZ0VzTlVPWUNjcW5MK0ZvSFcrQVFHMnhtRTcvZmZHdWx2?=
 =?utf-8?B?SmN4UnB4RzVHcUlWeU4yWU5NcjNmOCtqek11TUIxM0V5NGx6U3JFLzZyWlMy?=
 =?utf-8?Q?WnpNAcV6ua1ejOEmDVFJM0FlV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: plA5zV/VKHnzCPtD5xeeLhwZTUnEMEIuNFSUeSwKSmXBxBP5YQr8NwuRscT1XPUhZ6MGd1nciRHVIXY9NeFxKZ4EYQSF7nKu5aTNytMaKaSNXZ5L/sRYov5eo4DRadhIn0zVRuwIlp6IUdNA2G5tLrBSY4xGU7FGtPhkigdN/o2yCJd+aRI3stwQS/HcIq5Ad8LlCjGW6y4s4dTCqkBjR06K824nLnxZ5h1EqpVp6viIiDMMFCO03SntYCYJOgbuXA10aW9Bl+JNl4oJpc2idbCfzJVi5+Yu48any+NNRsynOgUY91japbkY+rd1TLI+PmUIwTrOrzWox/iIxkiKmOHOJlqvHeU/HbamXp3VIyaose8ISHwrt1xDNSw5jDcw/yGq8ScsNt/W5tVy3Yk96RWENAx92T7ztggDVSmt8FrbXz1GxB13N057nwHXSPaKX+3UCh5bIt8i94W574Bo3wgnZ6e8JIGsxx3fEaWOCpNmBdj2GJCxf5JxSlRc6fblnHqjY24xuGRObkwHBE11mspwpJL7RZ/tPbNpuIETNPF9GJuzT+dE5wR3nwAkYEB16UBTzgdV5qbJYAf36dket9bQgBRg18YObJZJPpUbOaw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c39bf4-8ca5-403e-091b-08dc2d8ae00e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:29:26.8720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAIgkoLFMKfQyhl5+rtxL9Hr5DHXR17+5rwCKg8GgIy+XUJg2Xc8dGl+0TTwvPW7sogE+yNu8ygq74lWHdzkRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5873
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_10,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140144
X-Proofpoint-ORIG-GUID: W90UbTM6IHeWUlYYCJNPGlMxATSiNggj
X-Proofpoint-GUID: W90UbTM6IHeWUlYYCJNPGlMxATSiNggj
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Michael,

On 2/13/2024 2:22 AM, Michael S. Tsirkin wrote:
> On Mon, Feb 05, 2024 at 05:10:36PM -0800, Si-Wei Liu wrote:
>> Hi Eugenio,
>>
>> I thought this new code looks good to me and the original issue I saw with
>> x-svq=on should be gone. However, after rebase my tree on top of this,
>> there's a new failure I found around setting up guest mappings at early
>> boot, please see attached the specific QEMU config and corresponding event
>> traces. Haven't checked into the detail yet, thinking you would need to be
>> aware of ahead.
>>
>> Regards,
>> -Siwei
> Eugenio were you able to reproduce? Siwei did you have time to
> look into this?
Didn't get a chance to look into the detail yet in the past week, but 
thought it may have something to do with the (internals of) iova tree 
range allocation and the lookup routine. It started to fall apart at the 
first vhost_vdpa_dma_unmap call showing up in the trace events, where it 
should've gotten IOVA=0x2000001000,  but an incorrect IOVA address 
0x1000 was ended up returning from the iova tree lookup routine.

HVA                    GPA                IOVA
-------------------------------------------------------------------------------------------------------------------------
Map
[0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) [0x1000, 0x80000000)
[0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x2080000000) 
[0x80001000, 0x2000001000)
[0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000) 
[0x2000001000, 0x2000021000)

Unmap
[0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000) [0x1000, 
0x20000) ???
                                     shouldn't it be [0x2000001000, 
0x2000021000) ???

PS, I will be taking off from today and for the next two weeks. Will try 
to help out looking more closely after I get back.

-Siwei
>   Can't merge patches which are known to break things ...

