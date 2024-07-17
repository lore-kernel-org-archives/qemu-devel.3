Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD74C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 16:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU7vM-0007su-MA; Wed, 17 Jul 2024 12:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU7vG-0007sC-W9
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 12:54:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU7vB-0004w1-1K
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 12:54:32 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HGqlYd002987;
 Wed, 17 Jul 2024 16:54:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=FwS29ABTQ+tAl/UZ1p7+F8jtPvR/MXxw2T/BdLRyydk=; b=
 Yxy5xYKekxslLUg9tgsd435AGY/uj+CZP+oplYmBYDKVm+OUgjTrPy7bXgqmT3oG
 IKuZcuYgc42CLlGSOIjVAyQZrOp8TCOT8KXMCXeinvRODSsUybLUPyVtoc0N/PQF
 PaT6WDMHoDPIPh2NTw0kY+Ceyb6EDvO7YDDNxSpo0wk7Ky78paso+uhMur54LBD5
 LuLkyJmT/8r9dZ6cRuDb5/WN7zXp4xHayrix0YtNmwLjmrVj2By1zGPGfx1ZVO7v
 310H9+P4Am6PF/T2qlobE9O13/raBQ74uNMCq4txm08w4SJ0bw9C8kXki5P8/+AL
 o667PX7QKC/BI9GKsRTSZQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40ehtw80dc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 16:54:24 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46HFuBVJ039531; Wed, 17 Jul 2024 16:54:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwev9t3k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 16:54:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spopaNuMvl0RwhKysO5MwdU2Xkwovd+iHi0dO4rGFNrCheMSz/bTruYKAy0oGzCI7+YVtyXVHLGpOkr7MRhRr82vaTcjxAF6mPRMd/vhM8pwmni8r9szLgz/nlesjIyjhMDZruNmKzsFYPVgnOPd645hKlKsFRndEi5dpaMXZ3gQV1I94P69/umn1Hot7uZKDzA4bTT172ePj+HR9Q38kfs8/mO1f91W9UNbnEe37+LObjNef6IDiEuDk3AEF7NuU3IfY81tTT0ut3L/j8k0r9dc+My74ULg73XvQ/F0GKy2HANt3kE7sbtdltlxlmWSZDaDfHacnSwlCeD5+5hozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwS29ABTQ+tAl/UZ1p7+F8jtPvR/MXxw2T/BdLRyydk=;
 b=V02gabXyGcdH/SXg5wQ5SzR2RGAoP7E2uvMt49EwfAgUM91QYAX7+ZmGqMlDWAAfo+yc4rfjbEqbVrOaqt+0Pz/82AERTEdbya21pjnqa3zzmuxcq0+3PRRxw0WmoZd2ozEZAM32RmMwhNWTE3j0odGa92jJZCN4YHt+mXUwrwQ15VKC38RBGOJzjtvQFWtgEhb9Uc8HtX962HLLURVlQLm9YWC4YtYB6gtVPAo+oSEv5K3QEw0B6UygwYKnGVbjFPyBaIBSfqc6ua69Y3wYbhHu7dgOoXJnm+TGmlUCG+GpxBC8J9BXJ1YZ7j/inlrqSN4WmoeDIemE+hGTOXHXgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwS29ABTQ+tAl/UZ1p7+F8jtPvR/MXxw2T/BdLRyydk=;
 b=c0BgNn7P71b5uWeXZS+QxOfVC3rpcx3ysSz0IHOnNepJi7F1SpZ/nNJaaSyA19M0Tm3tquRQLhaXzw9fzCXoa4/dghzL4dNnjdCy+vvaGOzO/F+7uby2KNbQhfYhu1vx3ApgZ4OYqHhnEf7ok+Y/IdZDw4iIQX+T/GsCuKxZRuQ=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CH3PR10MB7306.namprd10.prod.outlook.com (2603:10b6:610:12c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 16:54:20 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Wed, 17 Jul 2024
 16:54:16 +0000
Message-ID: <d12f1ba0-67da-4d4c-b8a4-0861ac9073fd@oracle.com>
Date: Wed, 17 Jul 2024 17:54:06 +0100
Subject: Re: [PATCH v4 11/12] vfio/migration: Don't block migration device
 dirty tracking is unsupported
From: Joao Martins <joao.m.martins@oracle.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-12-joao.m.martins@oracle.com>
 <SJ0PR11MB674456F8871EAC781732D0CD92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <da65c43a-ddca-4d47-bfbf-274e8062c56b@oracle.com>
 <4e69e717-04a6-482e-9cf6-da23a9dc80a4@oracle.com>
 <6f3ee3e3-8930-4677-9efa-462e2889fbf8@oracle.com>
Content-Language: en-US
In-Reply-To: <6f3ee3e3-8930-4677-9efa-462e2889fbf8@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0143.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::10) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CH3PR10MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e73819a-8797-4ef9-3760-08dca6811822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnFpcXczckNuV3hkNWxyMGpZMm5OeEw4K3hDQlRXTHptSG5OUjR5UGxkSXBL?=
 =?utf-8?B?NGNBNDVMUmVSN3NXMlZNYUFHdEgxMDNNbkFISUlXMllySnl0YXgyMThrbVIw?=
 =?utf-8?B?TWVuZHVZYVZSTnM2U3VpR1dMK0tVSVhiRDFzR0U5M2pKTThLbWM0cmJoL0RY?=
 =?utf-8?B?L3BPUEcvNE1MRkRYUGtoSjVjN0h4UlZlRGUya0taeXMrbmhscFJJK2N5QzF1?=
 =?utf-8?B?SC9Id3pEYVFVOHV5OGpESXNEdzJTSWZWaTZWOE1VRlJaMjZVbW9uRmpmQkxU?=
 =?utf-8?B?UTArSEh0NzVMYnJicDZ2VncxU015RGJpTTlUaXp6WFRCekR4RnVpK1dFN3lw?=
 =?utf-8?B?empjODljZC9rYzFjL0V3c202Rkx3dTFCQmYrMWlEcUlVQXFnZDdiUkl3OWw3?=
 =?utf-8?B?anZVcjkrYWc2Q2xrRm9DcmNFS0dwL3Zqc1dhclVvQ1N6ZVFnWDFoakJwNGdj?=
 =?utf-8?B?UUl5NStpMmV3dk5YOFhhUEFqRUlmU2NaUk5Ca0VaeUlRbHlXS3YyMUFpaWVm?=
 =?utf-8?B?ZFdOOUJMMWdSSVZwNTVRNTBESGFoVThjaTdOL2hUUHFSckJEYlF6dy9KL3Z6?=
 =?utf-8?B?dU0wVFI1NEl1T2tXRlFNTGVJZ01qSHdUaUJvbk1yTWtneWZnTjlrWDIvSDdX?=
 =?utf-8?B?bTFabnR0QUJURVd4dTBoR2I4MENTWGdnRE5Qb2ZPVjdiUm52TzlGbGhoK05r?=
 =?utf-8?B?dnlIN291WStwZzZGN3Njc0txdVFvMjJqazFlNHR5VUFNSTE1VVNFNlNjTDRo?=
 =?utf-8?B?Smt0Um5BNFJuTU5qZ3l0bndxNk84VEJaOENTdjIzMmgwakRNRFZVVFhkRmVN?=
 =?utf-8?B?bFhZY2NlZ1htQUkrOW5pNnlFOUptcGYzNWlVWXZhVDJqNC9xOFZKUlk4bnNZ?=
 =?utf-8?B?cW9JcVlRTmF4RjU2SlJ1cWt6MjhSS3ZpRWNVNlNzVlVoVzJzL01YaFF6TjVv?=
 =?utf-8?B?TkhubUNSNlMrcUhTWm0yNzBhUU45ekZZb3gwTGNLT09ZVXRCSmsySk9ESDR0?=
 =?utf-8?B?bnYySjFUeFJVTWpOWkFJSDNRNENLMHIzREJPbUozVWI2TzBzTDZpMDRzMWVD?=
 =?utf-8?B?U3pjL0tHVDk4czV3WlZSVVBkdUJWVytVbXRBUk9iQmpDVGNrclNLRm5kd29N?=
 =?utf-8?B?OGlmUzZuL0dHNlFhZ2dpMlgzREZqRUdMcHJUdlRQQVR3b0taVjlnQndSa1B5?=
 =?utf-8?B?SXhDWDREWWhsME1ReWZxYWNoSFVMZkV2UXZFWW1EQzR0bTRYN1hOS29Cdlhz?=
 =?utf-8?B?MENVYTZKVUpXYmxhTlZwbGlLSVJ5S3BGWjJmQ2FWNk11MlBhQmJvZ0ZpUXBF?=
 =?utf-8?B?OWM2RzI3WlNwTUNiWGc4M0tQd2ZHTHhTUmJQdEpIY1ZmbWxyai9KWXZtM0h0?=
 =?utf-8?B?dHR0a2lTQ0trZXNHQ3VaekRzZjNVaFFHaXVyVkNtSk52U01hMTk4YWoxc0Jv?=
 =?utf-8?B?K3UvWnFST1pialdUMG04UmF1K0FacDBPWTBSUnRCSXVnRWtlOThEdDlXbW1i?=
 =?utf-8?B?eFpEalYyQXJ1Nkk0WWgzdlE0bGFVRzNVUjJyMjBhaGJPL2dtN1R5VGU3S1Rs?=
 =?utf-8?B?c1Rha2FRdG1mL1RtYWhXSWs1WWtjU3Rqcm5XQkN6UXlyQ1hJckt1SCt3S3BP?=
 =?utf-8?B?ZlFTaWpRTHZ6cXJidHNwamVoS2trZUpUWVFRNGtyYzlUU1NSZFY3VkFJbmlQ?=
 =?utf-8?B?aG14YWYvVGt5ZXFibjdaNjQ3SVpYcXFVY3J5bHJjUFJMMVNVQXVHbyt5aWhM?=
 =?utf-8?B?WGYrYWtHcVA5NTUxRzZYKzMwUGR4SnZKQXJJMVQvS3BwUWtQdmlrZ1NRcUJy?=
 =?utf-8?B?Sk90aDljcElZdTgramo2dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWg1ZFRuVGpWVG93ZVZNTlJtSGJZTFB3VzZ6OWRxZzUzYXZ0cFM4MGcya1p2?=
 =?utf-8?B?NjhoZkdaNitONUovRjU4TlpPRGZiRkNhUzlndDlDMGd5OTRFUEJ1Tko2SVZO?=
 =?utf-8?B?aE9URmxYK2o4VjV2WWdUaXorVjBnSUlvUmh1dm5id0Z4SmdObkcvRUZnbE1i?=
 =?utf-8?B?VGdCajI4ck9qR0ZaSm5hQWJNUGcxMlN3YzdkZnJPdTI0VFNtNlNkT1l1cG0y?=
 =?utf-8?B?MlhvdzYvOVJhOE9ib2N2SXkyTU1CSkRLTHgyUFlVcHhwemVFaG51eTNRb1dL?=
 =?utf-8?B?OHg2bks0ajVhb3lHek9HM2tEU04wQ1FjVmhQK3M5SjFGcTJWZ2ZSdGdORzFM?=
 =?utf-8?B?SmltMUxQTFhDM09EZElGeXQ4VFlyODdSOTJWeGxsQjZqRWQySkl3MVYzSzhE?=
 =?utf-8?B?TTJjNlhXdDZJUkhCSmZXSEo3b3U0ZDBWcllaT1JxaHhuY2xsOG9BRWxQRmk4?=
 =?utf-8?B?cmNsRVB6OGV1emorc3lWSHNKMFhtTzd5bmZVQ2c1ZjBpUzRTb2t3QmRkWEpX?=
 =?utf-8?B?TFpSWmlqVkI1Nlo1WGZWYmhiOStEZG1iNWFxb0JkL1BvNmlyRVVPaFpUZlVO?=
 =?utf-8?B?VXBKR2c1d3ByTngvVXc1OExSeEgwL0psMjIwcXU3eXAvbURsZEZKRWFSWUVo?=
 =?utf-8?B?aUR0bStxdTk5TnExZDZWS3p2ZTlOU3daTlR1anU5ZWNIb0ZOczcxZ2U0TjVU?=
 =?utf-8?B?YkhWV1dvNEtLUGIySU85Rm91ckJFQWlIRUpFS0RUVE1HYkI3Unh2OHhDdm5S?=
 =?utf-8?B?UEJDLzQrVFRFc2trMFR1T1pXZmptS1dycHBtMjBzdDU0VVNmOUsvY0ZWdU9E?=
 =?utf-8?B?VldlcmFsNWlQZlNrSVRTcldScmUrMlIvUFplQ3ZMOEtEaVUwZ2Y5cUJkWmdz?=
 =?utf-8?B?MFZURmEvcGlTdWt5eUs1d1gwOG1TQ2NkZXplNERoem1ML1dvY3F0TkRDRi9C?=
 =?utf-8?B?aUNQd2JMeU9FK0UyU0xqY2lBaEZzTzIvVklJNWVHbUMwakxzTnBYSlRoelVM?=
 =?utf-8?B?UVlrWnFLVnkvdE9saGV4ZlBZODJaQlZkdDNmNHZOZXBTMUY1VTdMb3pObkU1?=
 =?utf-8?B?OW53d2dIVTZ0OVRhY1dJNFRqYWViL2RYN1FmVThJcTBYTEU3UXlnZ1NFTVND?=
 =?utf-8?B?c0VObHh2bENBTlBHRXRRQ0w0M3N1RThvYTV0RFBwb0VjeFhmcnc1YkVnN2Ja?=
 =?utf-8?B?Z0RrZG9Qc3MrYmdIYTJCeU5nQUhFdk9QNnZ2Qm9QbWdHdkpVTWlpMS9uWG1C?=
 =?utf-8?B?NWNCRUYvVEpLcDhmTnM3aUVybStvTitpREdlRWl2Vk9WcTNmRHZpQnAvYWdq?=
 =?utf-8?B?Q0Y4SFR2TXlVVzYvTWc4UFIza01mNUVDdGRwNU4wUG9CQ05lcUdhRDJSYW81?=
 =?utf-8?B?R281cm9laXhpSGtIZGw5dHBuTWc5STh0TW90Nk9neVkwRHRVeW1rU1M0Vm1r?=
 =?utf-8?B?YzJTODFOZEpjeG9vQWJzM0ZoQ2EybHZ1OXQ0bUNUZ0ZUTzRBb2YzdXZ1d1Bw?=
 =?utf-8?B?UEFZckRJdlpacXNMSGI4b2psa2lBZUkwZGVTb2U3NkFLa2hFSFpGWm1oWURG?=
 =?utf-8?B?RHZ4MGV0azN2ekNGTnROaEdHSXNYNnhvV2VQUWVqVTRHd2dPTHNYM2NEZ2s3?=
 =?utf-8?B?S3ZKcHVCY1B1L20rdVhIR0oyQXh6WGVIazlMSDhDd1U0eHJhRS94cXphYkxG?=
 =?utf-8?B?KzZXeTJrQitWeWVXNUxZVDZ1K3Y4bkdDdkdwelgzcGtOUnFjR2V2Z2xmYVRn?=
 =?utf-8?B?UzhHd2Z3TkU4RVZZa2JzSnMzNkdjVGxlZjNRRDA5YjJmWUtTK2JnakdoeXhR?=
 =?utf-8?B?dVVnSVhsNEI3c2hrQzZIcmo4OElHczBiUHlKTGJHcGRwKzRUMkpWdzFNcy9Z?=
 =?utf-8?B?SXZmN1lQM3R4bXJnTVZSajhua3JmK2FCYTJxVnAvOFZjU3VLSXIveE15YUZs?=
 =?utf-8?B?eVh2UjhuUlU2a0dDN2U3SmpWb0xaUW9XNXV3WWxjMGxGcGIrY0tTUUU2OEc2?=
 =?utf-8?B?dS9TWVZZZTN3RW9QbWs3Sk1UOHY0WkxkSHpzbURGK1RXNG02NXNCMXk0ZndB?=
 =?utf-8?B?OW1HeU1iR3NCWVZCbzRlSDVFN0RuNlQ3ZnBXMW04U0RKd3ZiclY4dkdITXpP?=
 =?utf-8?B?MEEwNlhmalpmOE1KN0w3VnRmdmMzTDJ6Zm1jd2NVVUpGN0lmSjZwODlhM3Yx?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sTg23vxa5cJuwLpRYR9nDaV6QN8W/WGdzuoXxiCB1hCiVZsPiSw2M7Hd3b6zJIpl5Fp/4lDw1HudMHYFiNmbllz/PeCOSs8mdwQ32mjXAZIm/1TfZNLJ66Nq3fhpFRfE+5KAwcTymmuoK42zpx1cz73irmP9gWvuPhEfLvYewNTuWzmDcDoUmogbALExTobO66G3rpGWPISv5HpSstgQ8GwBTiLTe3o7nupKp47I5WBAf45OLswPwgbo3YC+SI0Whj3R6xDtkd7QD/GeB8bN3hmW7eoRqoxYG9vHXZxZs7cGf7kKK7odL2rdi0XoZmM+2heBnpVdYHbpxnk1fEz4pCJDxqq8uX6mU5+ZMVAyikcg6W1xvHL4x/X4sTzlKsaWdy7F/onzCuWKH7FmneTNIuR2bdd7+qmbdxppJ37woCWCTWodBAp/8UIo0B9htKncdS4zNcIFlkeZZIO4pWwpQ7AqXsghaYh9PEriOEL7SCheCanI6ojYyqua95LBgeFKRWB/nSoOLaNYv7u3koEX8ND0I1606258C1kkDP1FBgNcVH/eoz44LbEPP/wy8Crr5UOyeMU18hx1YZTlci8QVpN+2XAt+OUTY/KBDpQSPf4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e73819a-8797-4ef9-3760-08dca6811822
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 16:54:16.8727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oe2jY2ssXS81HanpD9OgqllQ+h5PAg3GrPAzM3EVsCa3Vex/OAQED4J8Wwg6XSxkLXW5rzWvWcsKUfyq8yHp2xCxFjQiYWUK7dwlzk5qrx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7306
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_13,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407170129
X-Proofpoint-GUID: nDtMgYbhyPK5Y363zLIGMvx3QAPrBYo7
X-Proofpoint-ORIG-GUID: nDtMgYbhyPK5Y363zLIGMvx3QAPrBYo7
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 17/07/2024 17:02, Joao Martins wrote:
> On 17/07/2024 16:35, Joao Martins wrote:
>> On 17/07/2024 10:20, Joao Martins wrote:
>>> On 17/07/2024 03:38, Duan, Zhenzhong wrote:
>>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>>> index 34d4be2ce1b1..ce3d1b6e9a25 100644
>>>>> --- a/hw/vfio/migration.c
>>>>> +++ b/hw/vfio/migration.c
>>>>> @@ -1036,7 +1036,8 @@ bool vfio_migration_realize(VFIODevice
>>>>> *vbasedev, Error **errp)
>>>>>         return !vfio_block_migration(vbasedev, err, errp);
>>>>>     }
>>>>>
>>>>> -    if (!vbasedev->dirty_pages_supported) {
>>>>> +    if (!vbasedev->dirty_pages_supported &&
>>>>> +        !vbasedev->bcontainer->dirty_pages_supported) {
>>>>>         if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
>>>>>             error_setg(&err,
>>>>>                        "%s: VFIO device doesn't support device dirty tracking",
>>>>
>>>> I'm not sure if this message needs to be updated, " VFIO device doesn't support device and IOMMU dirty tracking"
>>>>
>>>> Same for the below:
>>>>
>>>> warn_report("%s: VFIO device doesn't support device dirty tracking"
>>>
>>>
>>> Ah yes, good catch. Additionally I think I should check device hwpt rather than
>>> container::dirty_pages_supported i.e.
>>>
>>> if (!vbasedev->dirty_pages_supported &&
>>>     (vbasedev->hwpt && !iommufd_hwpt_dirty_tracking(vbasedev->hwpt)))
>>>
>>> This makes sure that migration is blocked with more accuracy
>>
>> I retract this comment as I think it can all be easily detected by not OR-ing
>> the setting of vbasedev->bcontainer->dirty_pages_supported. I should put a
>> warn_report_once() there.
> 
> Something like this below.
> 
> To be clear: this is mostly a safe guard against a theoretic case that we don't
> know it exists. For example on x86, this is homogeneous and I suspect server ARM
> to be the case too. embedded ARM might be different as there's so many
> incantations of it.
> 

Except that it won't work with hotplug :( so the previous snip was actually a
bit better.

> @@ -267,6 +282,13 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>      vbasedev->hwpt = hwpt;
>      QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>      QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
> +
> +    if (container->bcontainer.dirty_pages_supported &&
> +        !iommufd_hwpt_dirty_tracking(hwpt)) {
> +        warn_report("%s: IOMMU dirty tracking not supported\n", vbasedev->name);
> +    }
> +    container->bcontainer.dirty_pages_supported =
> +                              iommufd_hwpt_dirty_tracking(hwpt);
>      return true;
>  }
> 
> 


