Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF6ECCA472
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 16:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3dOg-0002RJ-6W; Tue, 30 Sep 2025 12:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3dOc-0002O2-3V
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 12:40:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3dOT-0001w8-R1
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 12:40:09 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UFo21T027260;
 Tue, 30 Sep 2025 16:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=9M4xXZ8xxtjp49X2Pkp7keUhLEp3DZe0SnzfQ2NtgMI=; b=
 kZJoUCmiuDfioAnRoUZcfPIgDatXiRtR9HBm+/ksw14dFg/KM0LPeee+5NsIjZgd
 RnVJVvMBSrPt+7f5qoBQL11+BnY47QBI0wwo8OhzFbq6Rtau/glswi4KnMUepIj4
 7xVmTWFL40/YeprDPSywFUUeEL2Pf2qTce9onlNtS4ZX6RWGniu8ydthtJw8aoqL
 RrSZL5jnIjO381V/aT9r5XlvFw5La9WEF3fo9tP8A21hwuJ/QR9bZQYY3WlduC3f
 14zk+c6Le1ZrTqgglUIOZx2/SToHuOlRc8Q/AObP/dxbbiBFkcfaGjKPl5rp+IMq
 jrxRhfJkF3tha6ctvuERYg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gj6dg48t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 16:39:58 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58UFpwbh001439; Tue, 30 Sep 2025 16:39:58 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6c83ktv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 16:39:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxgar5aZVNmWlg+47C8v4IvC2Fy7qc3+B6l0B4gfAJdvKhNyOkwYJzW2dMkZznkif7l7SJ6PZgi18ZSCJKIhzu2GcF2nlLZ+j/JnwMp5jqyQkxQSPLtMJyfmmakX4PluYk6VubDe6aoRkoOGXOqoFMOpYkIZLpHld9vJynv3hF+4nDZ0N7fiWYlAmtZ946FgYriJmu3p9nb3mVSrx9b7Dp95+aYMULFMbDYKroXolt1QFAAtVBXHA009mWOR990Dspt2nen2kmAVVMd6+icb2IN/BI0Wo72e0i1vGzUvzGaY9iJOPZKYwDPAL4UkUyw+oXs7pcI0fwp4a6X9wzvWPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9M4xXZ8xxtjp49X2Pkp7keUhLEp3DZe0SnzfQ2NtgMI=;
 b=r5wsr9wZUZHewzdW068/3TWs9aqXKg95X2PfHwXawR2svdhCSHFJ7+YfWnh1G3cqwIIg66llhrMZ+lc0p9IzVPZGDe6GsrlxmT5oJLxoBXSNfkbmFthuLo8Q3/5OuaPVxrN8cQ4acveWOW1LX2pYfeT+xGNMMQhQjanBOuhm5gseEf3+GImmPxhKFpxz8lUt/CmsuKZYm5FUhTVwQO1HAA9vTYnqXwk/z8uJKNEO/CAbalk0pjG7sxnu57ZJ0pPqhveHQdPQLlrsvyirpD7tta3AOtVo1WbU7ppBoHOsssIw4Nx09dc+Vwv/fcypkuwEm+zVLqf2i2sj5xChX+4H3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9M4xXZ8xxtjp49X2Pkp7keUhLEp3DZe0SnzfQ2NtgMI=;
 b=Q9tWvM3I+2s/Hpt8Cbw9qAB/xZC6IR52JFqJvm8NLWhw7DdcQYzganF65Z47fTz3rgWejQKnonFiAcWaTV2n0VEyNuA1EW8TbJo7eWCBKvgRcoco0cMcbPgD0QYKLnAyo2PD5n6uMa+PQbJOzrB0o8NAB/i2VO03/O1AXP5i7BU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB5922.namprd10.prod.outlook.com (2603:10b6:208:3d6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 16:39:54 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 16:39:54 +0000
Message-ID: <5e08de11-7bc7-40a9-871f-c14af71c0410@oracle.com>
Date: Tue, 30 Sep 2025 12:39:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 5/8] migration: cpr-exec save and load
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
 <1758548985-354793-6-git-send-email-steven.sistare@oracle.com>
 <15399e70-fa4b-4792-9881-9dec59f0c832@redhat.com>
 <e8766c16-5f8e-4b3d-8808-42158d28b549@oracle.com>
 <6d5b95e4-1d50-4b70-8d40-9031f3735d56@redhat.com> <aNwDGpxZMFWj-ELW@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aNwDGpxZMFWj-ELW@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH5P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::13) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 129f3cde-0309-448f-9bac-08de003ffc0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2IwOXpaMVg1WExTeUlpNDU2bFRPblViamdiNTFmQVZKNnczU2lGOGppaisr?=
 =?utf-8?B?NWVYRlB5cnBpblJTVE5XMDZkN2hRMGJJWXJtR1A0cjNGVkRZVE4wL1dieEd2?=
 =?utf-8?B?dk9qKysvaHRJSnRlQ2Ziblhia0hPeHhWTm04R1FoWXRCU1JVdkFKbHlVbTls?=
 =?utf-8?B?a1RJQ1ZKRnY5R1NkN2ViSWV0MzYyTk8xb25PaXMrbjE3SXpiUWNKYVlpRWtS?=
 =?utf-8?B?Nk1sOGtwTHVqQlhmZ3p0KzdGYVRXMGFuTVJyQ1lzalhLeDZzSjlvcDVmQjN0?=
 =?utf-8?B?eXpvUnlCVUNiSzZNRWJ2eVZQb2JqZllIQ2NIcWRYZ1hUVkk2enVpM0lVMzhz?=
 =?utf-8?B?a1VhV3dVZ1hTc1dRSE1xZ3VnL2swdTZONTUxOUtQb3NicnVteGlSd1pzL2F2?=
 =?utf-8?B?aWhaNjk1VEx0T0NSdnorZkx3T0YwMHhWRGNheTMxU1NIVFJnWXg0WmZORXZ3?=
 =?utf-8?B?S1dOMmRDclBEMDNtTmtOY25jZEVWNDkwUFUxYmRsR0ZER0pjRmRtQlBSRWxG?=
 =?utf-8?B?RVBpZ1lyZWFENFRMcDR2cFlZWDdNb3gxZGxvdEd1eUIvUmZEeU9IYnR0UThk?=
 =?utf-8?B?WjdQTC9hZER1NDQ1VGZNRVNEMDViS01oelZteE9lVmROQ1ZtYjZWVlRLREJG?=
 =?utf-8?B?WnF6bmxONHpkVGdmZUFTeTNjcjFsWGZNbFVmZWpZTmpYVStPNTN3dDk0SmNG?=
 =?utf-8?B?WUY5cVV2Y2tvOUplNGpMUE5UQTRSbk5GWTRpVHJMNTM4Y0wzRHJuV3BXVHk4?=
 =?utf-8?B?SVFwZkJFZHhqbWhyM25QVmsrbi9yVWcwZzUrdm1Sbk41MklaZXNsUVkyZnk3?=
 =?utf-8?B?cHJkaWlLejFBMFBPeXZQQThzRVpsVnoraTk0dnRKQlRrZzlUNXI5aHZNcmcv?=
 =?utf-8?B?L3FCc05GMFRKNkZMN3NzQllXZnVDazdhL1lQbmNZQnZKZ1R0UEtzZnIvZ0dW?=
 =?utf-8?B?aEt5d0o2K1FWTi91bCtQOHlPTTdxeHFrOW1SL0JjVXRzVWE1TVhWWkNJS3o5?=
 =?utf-8?B?aFF3b2tIRlg4T1prV0hlY2E1L1FVVFdoZ2VUZzYvbnhDOGg5NDBlYWE5Zklq?=
 =?utf-8?B?aUY5aitzN29iNVI4RmRhVTUwamhGVlNXUURRVmNic01IVktqQXg1NlZBY3BM?=
 =?utf-8?B?clA5Sm90WjNCbVh6MWhBNXhGL2lENnZZQ2JzMlcxRmV1RmR5NE5JdjVZcHJv?=
 =?utf-8?B?OE5lZHdxL3ZjOG82RklOaUFCWDJGTmg0WjJDVW1IWDMwbEEyU3NpZ2ZvRnA0?=
 =?utf-8?B?UmJTc29LajhtRzQ4TW10VXI4QXhoQlYxUXJnZXdPd0ZSbFUvNEtPaENHWUls?=
 =?utf-8?B?YTNSVEo3cDh4Ym0vTE1GRGRSbEYzcUJSR0gxc2hqbk14MHJVY3dMVklwbGEx?=
 =?utf-8?B?S0pzTHNrOWVWWjE4Mk01Z011ZkNtdGZIQnBqMzhqd2NUZmNjczJtZkxZTGdn?=
 =?utf-8?B?NllkUGt1a2dvWkJ6Z3hQWlI4em82MVFMN040Snl5RjBKcFdhNVNLaWNBblV2?=
 =?utf-8?B?RUFJNUFYdXY1Smpqa0F5OGhmRTN1WFYrQnpTT1N5bkxNNXBMUC9uRFBKWkVp?=
 =?utf-8?B?UXY2OUtjM0hCY1lpWVB4eUZDMWRkeXFTV3luVmJ3L2JkbmpWMWhoVVpnTVZu?=
 =?utf-8?B?RFozR243c3ltVWdqUmgzUHIvTkJtY2NURFdicnJ3eHZtc2xQMGhtWlNBci9Y?=
 =?utf-8?B?VGFhcE5pSUxaUGhqU285WkF5Zk5IN2J1Qnp6aDFsQUUzamVFeE1lbC84Y205?=
 =?utf-8?B?Z0VXMTdoYTlPdmNiOElVRTRnWDNlamphNkZTdWV6NTJuODNzSXRXYi9LdUJ5?=
 =?utf-8?B?S1pmM3NBU3Q5MnpSdXVEbGxUN0RLdGk5YjdRTWU1NUoyejQ4eFE3N3FhS3pw?=
 =?utf-8?B?Y21nUk1INnUyaXdZWjVZMzk2VysxU1J3UjFac3VpTWQ1RHhuMFdERDIwNFZD?=
 =?utf-8?Q?ZWdKefb6KPe0km+EdLxy2x/lNuUEDkuv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2xmQjh5N2JHTjRoanlsL3VILzkvTFpYK1RES0NqOTF0allNWFFuWGpOaGMz?=
 =?utf-8?B?UHFQN2o0ZUNCelhIT0xBSkx5NTFjRGhiSHQxM0VJSHpEaTVMTm1TRUVIZXdT?=
 =?utf-8?B?UngyU3JnZ04wRUxPNEc4Y1ZQS3hMWFArOHNMQndBS1J1Y2k1THBtNjJ2Z2VS?=
 =?utf-8?B?TkxkY01UeDcrcUlTdjBsSGJQODNvay9tM0ZpRjNGMzhUajNJT0VrZVlBT0c0?=
 =?utf-8?B?NC9OdVU3ZGpTZGE3WXRreVNCSTQ2Yk90R2c4NUxlc2lvS1lxd3ZGRW1yamVG?=
 =?utf-8?B?SEVwd2M4RWE5aElxeXdHamlDVFVweXNtR3pyWW4xcVNGMFZFeThVeXUxa01C?=
 =?utf-8?B?Y3BwcmpmNUxUUE56aW4ydHM3NEFwUFFLdmtlQzlRRytNV283K1poUTl3VzBv?=
 =?utf-8?B?SFhOYkF4M0R6NjZYQ2tyZFhEK0tOcjVyTVBoTWJHNjRWLzZaS3VOT1J0dVNm?=
 =?utf-8?B?dGl0KzhHeFJJMVhTc3BUako1UXpHNXFReWYxZE9TbzdwQi9NaTAxa3RMSmFq?=
 =?utf-8?B?SDlWUk9OV280WTBra0hoTEhPOGsrZWl0R2tlYkpEL1dJTWNmYm5obllDT2RE?=
 =?utf-8?B?SkNJS2ZPWHErU0xhdENKYlJLck1WY2ViMWtNRWNQWXk2V3lUeVlpR3VxcjJU?=
 =?utf-8?B?d3JHbmNCenptYkNLRWQvR0xEeU9iMVZPTXR5Y0V1VmU3aXVzTkptK0RwUnB3?=
 =?utf-8?B?TWExelFYODcyY0tuV0Q4dUpRWjlheEVoR0FMNytzb0thWUtyZk8xbVRWMXdI?=
 =?utf-8?B?RmxGTi9yaTg2MlRrRHU0d2Fmcm0vNktLMnhOKzdjZ1JjYUNib3hqb0dZc3FG?=
 =?utf-8?B?aTllYzdFSnBHK2NjemRlYk9HazVnZXFhQWNCemRJY1pEZkQ5dGVZTktFbjJI?=
 =?utf-8?B?bnd6TXkxNFN3M1NORG5ralJSdkM5WTNFRnYzM0xwL1FuamQwM2VKS2ZwMDNq?=
 =?utf-8?B?ajBBRHpsWi83VlNPRXA1U2tkTERhL2R5MXEwQThFZmc4em5yRUdXdWZhZjF6?=
 =?utf-8?B?WG9OZ2xIMUcxSzFpbzNKYU03QzhBaVRKTnpmZ0t1YnVXTUgvYU1Cd3Z3YzJo?=
 =?utf-8?B?Q3hTMnZhMVNVZjVzNlpWRndkRFNlWGJ0MjZyUytkQ0piUUtsWDRmOHdTVkRB?=
 =?utf-8?B?VDdZSXlYVlpjM0VCYW5LNUpuSk9nTk04Mlp1aHVLdnJBSXc5V3BoeTNPZEtz?=
 =?utf-8?B?TGkxamQrU3RKY2RZd281ZUg1T2k5bURWNzBxT2MyN01iLy9maC9ucVBEclR6?=
 =?utf-8?B?Z2lWRk9NNWE3ZW5KQ1pQWmUvMFlGM1IrQTRWQTVwMlVBL1BSUDZiWWkzZlI2?=
 =?utf-8?B?YkdtNGt0d3kwUHRQQTlwQnZlNW1zVlZkd2dJTmRlYjhsNCtGOXBxY2QxN0pi?=
 =?utf-8?B?Qi8yR1N5Nm5YYloxWnRMdFB3ZWx6SjV1MkJoZFpXc0xKRUxjN2Q3c1pVNXVB?=
 =?utf-8?B?SVBUQWZmUE84WkFUQ1Z5YjhBWlY0YUZRdldJYnJGd0tsRkhrWi9xcThwaFJR?=
 =?utf-8?B?YlJqUWVOUXg5TGdwNmJNdExrNlJyeThsank1a2FpZEYrcG9wKzNRcnkvSTls?=
 =?utf-8?B?TTcwWmZLeDlyeHdLY3ZIN2drVlh3UGJkbEZzRVc0NUVGQm1HR1pIY2hwUUx1?=
 =?utf-8?B?a1NJeVFtbFYxeFM4bUEzbUF4M1kvOXkrdUR6YXZMV2dzRWVvN0lIZS9zamhN?=
 =?utf-8?B?djZOSlZWWVZDRjJMbHRPUXBpMFhsTUhjUnhGUU56NmZ0OEdYVnR5czZkR3JD?=
 =?utf-8?B?WUVRWHBpNXo4aUVOSXZiZkJUUEVGM3UrdzU2MitDdkh6OGgwSU9jczVsK01r?=
 =?utf-8?B?RmdCdlhjRTVmRlNaK2Rpc0hPM1k1YUI3am5hcUM1Tmx4aEJKTlE5b3BWRDlw?=
 =?utf-8?B?TlByNU9XMkhGdWdGR1VpZVFoRDB0TVRoSEk4TVpsZ2dzQjBKNGFNUWxieDlZ?=
 =?utf-8?B?dm9aakZPRTRrdUdFWTBONU1XcHBlOCt3Ti9ndDJlbk1tQ09QNTArWUtOVEcw?=
 =?utf-8?B?Vyt2N2k1Y2IydGRTbFo2KzZOTW1LaC9qWm81SzJ3VWJrejlDZWJZSVRzVUkw?=
 =?utf-8?B?UVRteG4zWUFTOVdMSnNRZVpuVERUZS9TdDAyNVBkWXprb3VFbTdOL0NGeDFX?=
 =?utf-8?B?U2NhTDZMaHU4bWhzc3NVMjlmOWpzeEZrTTRXL29weXRiSEx3L0FTV0djaGcx?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +3PnldwjDOl9kJBX5y/UCdrdu+kyduFifJaYP5ufy8x4pA+PeECc0Y/2Ul5ryNmobjatkFvjSjeNfIJUgXmZ35SzPElPefq1YamA82pP4qSpV9eutWq9mTaUDxSuIMdyaSitNACGsWeXk7aBwuVxKZshwAsP8HKgygzwjx3hfQaq9naMwkF4ynEdZklJTmJ5pF+acdAGUSthQWNLVAlYPMfz1vF8CCyFX4AA6uuSJMFqkWK/41RFtlfcI6YNcHjJgDJd1LS5/xsy9y9dg25wxjO60nJ9IlbMSDDWSb14hQtFrBOMDMh6DD41JOp5/Cw+klJdFVTJOYDHXzMFcvv38AbsP71zxKxpENEFtm05PdamO+8lM7waiU8QaIYezqvOqD87W8FpJ1W3ZGjZCLU08zwnXqalDnVaa6qZ88nP+RmrKUyid31GUPJtmbPPjrkTenWod6PXW8sDQ04aZO1gZMMttQIcv6boGxY6DXyPTVD45t0w5De1OwrCBqIykF7i/+fP3cnRsTIoS9nfaNeOEETMQHDE7igBdA+L9oWRDD0zQu9sBPStSVrjtqlfL7yba8RFy50ckSmrQcdjdYGMpYIQyz5JHTJw83B2+U+O13k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 129f3cde-0309-448f-9bac-08de003ffc0a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 16:39:54.6808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skUrzMmzlIkRjg5VT0dsHwGNzWijpPFX5w3ZyG2a3T4E02DVuJB5ge74dteIK8CtHuHMQkoz8xtswiCq/btMDJbp3uNkemcvpb0lAZ1oUEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5922
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300150
X-Proofpoint-GUID: -7FdJ49scIRyxiZ2zxgU0tyU8GaaMdGd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE0MiBTYWx0ZWRfX8GThK1lzLvb/
 jjlBn/Eo/TgTxNKPM+7pytGIhjRoMhlqaFaDZY2rjrDa3C+HrCNxUsBjBrMpWb97Ud+xYgrBiy8
 YyxiT2CwWYU6C49qaIdicrLEEOuZn3NdwfM/Gzbg5ysukZO+qXOZszs4Kiz6i1CQOrZDVNbm/Id
 x3y5z1cbJvqIYxZUrUY+7BNMh4QJ706INGEwVfYGBt5ko/AXly4I+k29zZEZTDudEXtdkbkBmSq
 Re5e4DSxtX3Zhn8lkI2BbNXubqEL9akhWiH10ciC8a8lndzJcIZtRnzOYWSXHduSkT/Iu4pkg4p
 K34FsFo+ev+9Lp+Wyn3/sn8XGWjbIii/cwdIPXLNqNal5sbok4eVugIHW/nikc3A4iA9rPfM3EE
 5xROdleIayNX2diJDAgVrGJCWFZk9L5/ae4brHkDQnktqMo5eko=
X-Authority-Analysis: v=2.4 cv=SOVPlevH c=1 sm=1 tr=0 ts=68dc07de b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=jWOjo-iB-sC1j25-9Z0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12090
X-Proofpoint-ORIG-GUID: -7FdJ49scIRyxiZ2zxgU0tyU8GaaMdGd
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/30/2025 12:19 PM, Peter Xu wrote:
> On Thu, Sep 25, 2025 at 09:11:33AM +0200, Cédric Le Goater wrote:
>>>> That's a short term hack right ? it's not even documented.
>>>
>>> It is an implementation detail, known only to the matched saving
>>> and loading functions inside qemu.  No one else needs to know, so
>>> no documentation.
>>
>> ok. Fair enough.
> 
> IMHO Cedric's ask is fair.  At least when people reading the doc may get
> confused of why cpr channel isn't needed for the exec mode in its API.
> 
> Could we still add one liner into the doc to describe it?  Something that
> would mention a temp memfd and passing it over using environment vars would
> help.

Sure.  I will add to CPR.rst:

This mode does not require a channel of type ``cpr``.  The information
that is passed over that channel for cpr-transfer mode is instead
serialized to a memfd, the number of the fd is saved in the
QEMU_CPR_EXEC_STATE environment variable during the exec of new QEMU.
and new QEMU mmaps the memfd.

- Steve





