Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418ECCAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 15:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzd2Q-0005FH-DK; Fri, 19 Sep 2025 11:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzd2O-0005De-6a
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 11:28:41 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzd2L-00025a-3x
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 11:28:39 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDunO4010150;
 Fri, 19 Sep 2025 15:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=G5h9iuFyveKBekUYFVKM+VO1CWEfGD0jy5JbVWFpGsk=; b=
 b2R1KlqwP006GAmgPbgJiiYFCjKWB1eTJl9M4bBKCBBgOyDcwZ+jhuWqvQsPsTZg
 wfcEp4m4ZUNagZNfzCJsBk84Z+yyycD6+ibQglx95IelkY9irbukplOJg9dWcUNX
 oG2o8HHOCm6wfBkOM8fr6Sna0VdqymV5u+/MvhUXtqlDRzTlEBCOgpv9DcZZCVWD
 GktgMu2x2/h1eyEqc26hF4uyGxfx250O7zi7yFOLpZX0uyBMNpuAxlxMHbgAMiG5
 n5sGSU2g7V9cgLsNBRhfSBrpkq5u4CE8Xz44vjUs8t34yOv9H1VmsorSXHtuBtCz
 ax4Pqdsexei7FTur0NAIeA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxb5t17-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 15:28:32 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JFNEGB027293; Fri, 19 Sep 2025 15:28:30 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013042.outbound.protection.outlook.com
 [40.93.201.42])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2pw1pw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 15:28:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNaeNDZU2ImaQCPUiVbqwvwgS5kPqV6l7IUAubC1l6q/JJGCsoIhCtUzhc+2AtRkf+ApyMzlvTTX2prW/ih46ZNpKc7Roqu1Kfi2OxdmJdc6GEbkJtbZIdtwkfd2rYVBArks1HGwQUJrx6T+tuvLukJ9n9rTqgsmmSGzlqf8xFKvCK0+hBLH+NMR8BtGkH6YXssxrrJFk4eJu4wZ+4N5/kT/mry6+ua+35AVv3Y4pLmsZTeP+ht2k/Hv4wHyFRc2Txs4MzEPBTyF1sbkVAFWi8vInnnhkG0bfnrDCVgp7sRyBGHp7VovH63rFwXu353zrcUMd5D8SYLBTlwa1fWZ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5h9iuFyveKBekUYFVKM+VO1CWEfGD0jy5JbVWFpGsk=;
 b=RZhn6eTEuXww3gxXxYvQNMSWBEgfJhu1Di0R+mvMHNx56BUNrWseJTOlljlP/TP8zMvmYllbcciVZZIRv3kheu8oEroUlvX7ywfcS/AcTAdjjqAr/OmgaY2+3z9pms0ZGnxLCvypfej/yPv3SYQbc1YTTD+fwPYSMrp6eYylrIkdWdblNTmMxedRM0o/P+2bvKgoUtw8aehR204WKrDBmdF/ZIcD4v2nLtt9+dsJpnRCe639UV0jPqHwyrilrTx2jDioueEgDH8JULSzoamoWQ4OFe3ZNb4sKGZZl6O8DOo9ouaVLqCSTnyw6w8Jb1SrasHsRaAeN9tABczdErdP8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5h9iuFyveKBekUYFVKM+VO1CWEfGD0jy5JbVWFpGsk=;
 b=dte2/kRSpwdM7zXuFev1yaci7214X7yuqBYe3DSMD1GmmlKkSmURzBweptkd7sEPSOgFinUSOA9vl5qtE38h4SuWlRjZZxLs+r2eC6ggFfsaYZuMMk599qPti2fyuc3qdQsG5btWFXX0PVjn6Agyg95K7Fqo44HhYTala9mAmsg=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA3PR10MB8640.namprd10.prod.outlook.com (2603:10b6:208:583::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Fri, 19 Sep
 2025 15:28:06 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 15:28:06 +0000
Message-ID: <8ac0a4fe-a1e3-4cc4-93e0-fc37406e918d@oracle.com>
Date: Fri, 19 Sep 2025 11:28:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 8/9] migration: cpr-exec docs
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <1755191843-283480-9-git-send-email-steven.sistare@oracle.com>
 <87h5x3sba1.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87h5x3sba1.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH3PEPF000040A4.namprd05.prod.outlook.com
 (2603:10b6:518:1::53) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA3PR10MB8640:EE_
X-MS-Office365-Filtering-Correlation-Id: fdbb602a-9b76-4767-e8e1-08ddf791219c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVorWGM4ZkNJbnZ1eFBOQ1JqWTFqSUl5YzkxUWJ1RXhVOEhSd0Fta3czcG9N?=
 =?utf-8?B?U29wSXJOdHk0VHdmQXBZVDFOV1QyWlVnb3V1N0tmMEtLOTFJUkV0dWt1d09B?=
 =?utf-8?B?TVAvU29SME0yZjBWMVJYemRnTlRUY0h2b3N6YzFqQndYME55ODNhRDhmWnRk?=
 =?utf-8?B?eG1Dd0o1aFdFdVNFbm5mZ3JDWE1PbC92cS9IaFJ5NDJrL0FudUdLL3Zza3hx?=
 =?utf-8?B?UkdNS0VWS29naU85MW5yeG41cExxUytpc2w4cDdVZ2drRFBDRFRYd0dlWGRR?=
 =?utf-8?B?dm1SOFdXRUZRd3U4UzJ0cGZxOGorN1JNTXJ3VUlVTExJVnlYSkdva25UTXFr?=
 =?utf-8?B?SzhaMjVrd3RYYndVdlpHdUZDM29QSWJoM2l1VmQrekJqc0tIT2N4SnUzdFNo?=
 =?utf-8?B?QjhqZVZaa1lZalpXTC9sVUNNaXF3OWJDUGE3YWJPemtWSjJVNDc0S0JSSXVu?=
 =?utf-8?B?Wng1VXNrTWd3NkQxQlRnZXdSek9VRXUxUm15NGtseFV1ZXRTdytnMUFuZmVy?=
 =?utf-8?B?RHJHVWpFOWxKLzhzbE9mc0wycmhvcmpsbEhWUEYxMWc1M2JzZHlRWnE3dWQv?=
 =?utf-8?B?TDZCN2dHcXR5NXFRdGxvRTlWdkJQTlAyMFllMFptQ2NCWjNZRkdiQkRyYlE4?=
 =?utf-8?B?bHkyWS9WYnFCRERoRkswc3ZRcFUyMXdvRzNNZFdhUHVpK0JHWVBPZGFScG9s?=
 =?utf-8?B?Q2RCK3gzeEpmdnR5aWFaRXh6dVY2cWh5dXE2a0VIWG50RVRReGVjVFBJLzRY?=
 =?utf-8?B?SjZkalBaQ1NiWUQyVnNJNnJ5MzlWVEVPNEVuQ3puUmQzRWN3TUQwS1Bud29y?=
 =?utf-8?B?NGVEdkpEZ0hzczhXUkdXWFk2b3haN1lOUzE3SnJvdWY3YXRyRWhqSVNrLy92?=
 =?utf-8?B?V3NaV2dUN2RneC81NW5nR1ErNnVvYi94OTJvcU1rYkxVMngzSy9jNlA3QXQ0?=
 =?utf-8?B?ckFKZTByKzZjNmtWOHhDRDVVRFNaVUhWU1VseUFEREJ0eWlKM3o4aFgzcG1E?=
 =?utf-8?B?QWxXK29ZNS9tTTdVZVpHT29yNmx0TjBqZ3pKZnpjSGRmOExZbEtsTnRNWXN0?=
 =?utf-8?B?aE9TY3lnVEVmR0Z3eS8wMGFaNXZHd2xNSFdabEhUQlZkczhnZWVOWDAwMUpO?=
 =?utf-8?B?SUhDNlRtc2d2V3lKOUF4WGpFNmZMY1V0RUUwWitSemtDeDcwYWV2L3JPVWlz?=
 =?utf-8?B?N2UvcTFiQVc3bnN5R1hPdnYwNHZZcWdTM0puU0dRWnExUmFsdThUZitzRkt1?=
 =?utf-8?B?N2RNK1IxUStNSjlYTXNHek1LVGFuREU0emxmMUk1N1pMY1hPNXJlazg0NXc0?=
 =?utf-8?B?STNJSkxxbmF3Rm00eWlHN3RsVUJGUzRkQlFVcEdiNUxaTW5sWUlxM0dFRTR4?=
 =?utf-8?B?UTY1VlBPYU11SFRUNDRqVlo1bUJ0VDM2bEJGMUNndGdrekFDTHVBMEN1dHYw?=
 =?utf-8?B?elFuYTlDYXNsQVBsYzBmblA4Z1VjemZvZis4cjYvRUVybURZMGFleUQvSFM4?=
 =?utf-8?B?cWhlcXF0YlRrSmdlckJNdHR1RUJ4QzJSKy8xdkNTZW0rRVBXSko4WHlHNWtL?=
 =?utf-8?B?REk0YStWZDY5TjhFbTd3bnJLUmZCWko3Z0JEcHVWSVpDYS9yNnhCTGI4SUVJ?=
 =?utf-8?B?NU5GYmRwNkErSk93bkc4eS9WUjMxL2Y2ZG1XUnB3L3Jla3g2RTFXMXFTdjN0?=
 =?utf-8?B?OC9KREh3SEllNnc2ZzNrWjJ3b0Z5aUR1MGFzOUo4QVV2R3BGNXBDTGVFdkFT?=
 =?utf-8?B?S09IdWwwZmpHU0dzSGRYazh4cVUwLy9pM2JJQlBwVmFXb3lhNGNGbXB3SkdF?=
 =?utf-8?B?L0VoUmJxZmdGdUJsUFl1eHlibWhIc3ZBZmY5YVI0ZTFVWFdHdWpsK1J6dHFY?=
 =?utf-8?B?aExLTUtNVlFvRCsyeWpiUWZvZkVUU2hzUHZ0YkRhSm9xS0VvSWVpQjFqQ21P?=
 =?utf-8?Q?RoVy8Stwp6g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDFTQWM4Tm9KYXFGVFdyN1FCNzgrSmNkS2lOcUdZb2NoT1VKUnFrQlZWMlNG?=
 =?utf-8?B?N0lTTkJyeS9uWHVDaDRNZGhYS1hOa2hZcFMyaTlVaUdpQ0kzaWQySkx5N3Jq?=
 =?utf-8?B?VFVhUnVzZU1xYXFtM2ZtcURvRDhjU3NSdFVmU2xickR0ZmhxcXhpVUJzMFg5?=
 =?utf-8?B?N0hDVldSem1USHprcXVvUThqSk9mZnFpY1ROZitJcDJKcnNMSExRMGdKNVJl?=
 =?utf-8?B?Q3cxSmF2WmxGVW5JZ3d6OTg2NWxZck81TTErcGhoWHZyOUd3VGhCMG96RjI0?=
 =?utf-8?B?WC9Ba2psWVVyNmhyOEgwNjM5S3VhT2I0UnF5Qml3ZWdkdDgrdkt3ajIySll6?=
 =?utf-8?B?T3NyMWR6ZFd3RjJqMythWHdMRGljQXlVRStsNDd3b1Z1YXFPVlpPSWE0U1ow?=
 =?utf-8?B?M21sZEJjdy9yODcrd0hKN2FrcTNiY2JXbS9KekJWazROZG5Gb1JoKyswL2Jr?=
 =?utf-8?B?KzFidkxJTmNaZzBKWHhEalc2NWZVd0ZZYm5KNVBEbUdrSFF5ZEdRelNodWZi?=
 =?utf-8?B?cU14WkxvcHBiVmFZa05RMHl2d0N5c0ZsZ1J2M0hlSGdKaEZLS2NFWmxESHI1?=
 =?utf-8?B?emcvUHkzK2NyZEJVcHZYcnZUZFFnRXAzOVlVQmVzUDR1cU9CSVROb21FY01B?=
 =?utf-8?B?U3k2M3BUTTdPeG1pOU5xZ0ttZFRBa2ZuN0ZOSGgvUmd3YnpxRkJKNUowTVZw?=
 =?utf-8?B?czdWbmhTR2FSd0FJTjVzNStPbUsvclFIUG9lV1VYNFdRbndGMjNtT0pqTW5n?=
 =?utf-8?B?MXA0ZGMxMndURkY0M0VrUnMrc01jOGExQUd1M1MvcHFFQlNHNXk5dnhzRjBp?=
 =?utf-8?B?bThxU0RxQUE2d1pHMm9pSTVySm9NQ3FCbXNMV2RFODBBU01YOTlyL0RCVmtu?=
 =?utf-8?B?aXNNL2RNWjY5SDFqNG5PdWlwaDlWV0lZT3U1Nk1LVEdVeFhkT1JOR3kxaGZr?=
 =?utf-8?B?dTNNUndvQkFXNzNVVmRlRlBsdFhrMlZLZUV3OS9YdHk2ZVd6Nk1DNXhQYTFu?=
 =?utf-8?B?SHRsWFRJTFB2ejlwSFg5cTEzRG1MMENoN3BKanFRMWIwWkZTTk4zQkJVamM5?=
 =?utf-8?B?R3BxMGMyNGZ0TnpHYmVGdmdvRkhJY3Q3L2xZMmR4MkRNSG5PMlB5QkRxdGZF?=
 =?utf-8?B?OW95VWtaZ1dxeU16OFBaMmUrMkxETXRXNmhrWEgvZVMvL3hrRmNuZmdCL0lC?=
 =?utf-8?B?bng3d29pa3RicGlvVmtjTXdWeWExUWtYRFh0TlpsaUxlKy91WVhheW9MVWVQ?=
 =?utf-8?B?ZTM3ME0xR2xnYitmd3R2QXAwVCsyaTNvaWNUYVpkK2JRQUJjY0ZHdVZ6STlR?=
 =?utf-8?B?YlFNMlQ1VUZHQ29hUlpmVE95V2x3a0FadzF5V2lRdG1xb0UyYXlTREU3OUlP?=
 =?utf-8?B?bnZEV0RKRWZ5TUd0eEVkS2hHRlpWZityblBFM0o0eGNEMWNSUlkvalhFSytm?=
 =?utf-8?B?WGM2ekl0YjB4UWdkQTFDT0lFRm1ZMXlhc1NTQURZdXNHSWtkRFFsSVZNY1Jo?=
 =?utf-8?B?WjJnQ0NxRllaV0RUMFUrUlM5c3c1cWJoa1JrUVRxTWYzeVNLVTQ2cVJ4TUxh?=
 =?utf-8?B?STR5ZkFBa2hXMHVRUmxDZ0krc2xwVWhxOXlJNjdsVlhUMjY3dmNRaGVUTklL?=
 =?utf-8?B?S3hyZ1loejdFejIyY2JTS3RiZWZNc1l3VEhWbEpINDNNall0MzZUTlovdVht?=
 =?utf-8?B?OER4cUhEVytNRnhlWGxqOW93aUZCTXRxU3d1ZVorZGFtVkR0T205Ynp4cWRZ?=
 =?utf-8?B?YlY2a1VGY0F2OE96aWs2QUNIS2Q4d2JHN2xNbmpPdzRTRC9IWHBWTlBXV002?=
 =?utf-8?B?aDBrSy9ldG9kYUI1b1FGc1N6cFJjUVVSaXVLcmhlZHRtV2IveG45RmxzYkNO?=
 =?utf-8?B?NXdjRFdiQUpYSFBnd29vUFFFUXJXbkowSnJkQVZNMmhYQjBCem5heVgvSHd0?=
 =?utf-8?B?UGs0S01pQkhIa2IrUFNwTWVrblRBeUo0d0I3R3BkNEZ5dmhXek9WM1NWOGJM?=
 =?utf-8?B?emgvZEVLOEI2YVpHRnVHSEtzQjNJZmFhZ2JsY2hmNUdvOFpuZUt3Mks4dDFt?=
 =?utf-8?B?QkZtVjQ0M2VHY2RkbytVbldIN05HejZGSHp2a041Rk0vS09LMmVuNFZlVDQx?=
 =?utf-8?B?UDJiWW9NQ1pxL0RFcGhBWHFQbnVVVG12ZCt2dkVSejdqc2VldEtUVmJTVyti?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: c9l6i9l2tvYfqZH3a+QwxB969oqjTS1tEA2rNfF8JJN74XXpZ/wupaS9/Z9xiH3e8IGHXTrWC5nJl9EAGi+GsH7/FJNV2u6j+K0VFJ4bynv8IN2ShS1B9VhgDJIt8uZyntPkZuev9xeiQbvyRy45nqmynfmHHW5D2XqoCh4C+rm6BHMJbAIEisYTjEi/lmaUqpdxh778twTF86hVpoT8zGXPu/SmRWsGEOrWcl4aX8Jio2vEcI9MPy4aP7ld1s9b30NxExDGPV4sBxMRtkA2ltfuynJ1OWtPCg3k9jdehABShJZ/Mza+YgZMLYk8wYnj17yg9DZzY996PoJOMH8SZVH+PJPUC7sSN7K8erHZYz7SwxjrteYDosTtFEkyB1CMpKd07wkHON9z2CyJsMEd4U7yW8T5htVomLEVaBZN70oReToXu1JU2lbaMuZX9L+5C4otebI7RXA7y46kAiulTVrkLNU+izkF2tgfEClDWTCLK3+LTjnIWnC7hb8LJrBBkgbud5vrTo6fPZ/zIEbEX6ngPYadsjCa9PdE86iJihVHhSDh4qF7HP0KyKfPqThNvcFRWkoQAspe3hJdCJG7ZoytAbstioA4q5JA4XE458Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbb602a-9b76-4767-e8e1-08ddf791219c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 15:28:06.4100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: de8gIgPb/C6+sLb2KXrh9mjlWVgUW57MrwuO5FJ3WilO3P6RQfQhg5D6IlTQd5UfNio1odBsDYCQZpUmxto1ld4TMgqvy1qmnz8byesN/7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509190145
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXymlPyhTg+N/I
 9tO3Z3NC4D/JWRlRaDdfjRarCl6HTIR/6uBT+GtdABsBBUDGZGi+kJVl7uOtr7lJ/P9IXHmGVjT
 s6Txd52hVz6yLI20vnqKhDH1+wjixURa1AiFidzDw/+p+XhxXlV7qAbQdUeXtyfT6SppASy40jF
 Qn1g9XF8ZTNW05W0Z9qhctqP2Orwq8g88Mnroj1K8zCPku7prjC5JTmw9/3nPDh+xj/5ypC4QQP
 /jqez8mIdVXsCewXb2kV6Jg7cwQzj2ToMldogtN3Lc0aWQo6PkfaL0HIxeZI9DFC3wp6xIx6Zrj
 soqRAENI7xCXyaPfnn/ZDAq6zf2fr1P44xqpmOUFxQ0t6LWxNEKhNoLDk7NSOw2FwipCyWQTyL0
 c5UouEdUNXEqZwFO5fxX6OGc4atpgw==
X-Authority-Analysis: v=2.4 cv=KOJaDEFo c=1 sm=1 tr=0 ts=68cd76a0 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=t84Nf0WuRMJ0dF9eTmsA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12083
X-Proofpoint-GUID: Ci0l_rZi-oLoGpxz4rfPdCCEDn-wyfLb
X-Proofpoint-ORIG-GUID: Ci0l_rZi-oLoGpxz4rfPdCCEDn-wyfLb
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 9/15/2025 4:36 PM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Update developer documentation for cpr-exec mode.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> 
> Just a typo below.

Thanks.
I will also fix: cpr-exec-args should be cpr-exec-command.

- Steve

>> ---
>>   docs/devel/migration/CPR.rst | 103 ++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 102 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
>> index 0a0fd4f..abc9a90 100644
>> --- a/docs/devel/migration/CPR.rst
>> +++ b/docs/devel/migration/CPR.rst
>> @@ -5,7 +5,7 @@ CPR is the umbrella name for a set of migration modes in which the
>>   VM is migrated to a new QEMU instance on the same host.  It is
>>   intended for use when the goal is to update host software components
>>   that run the VM, such as QEMU or even the host kernel.  At this time,
>> -the cpr-reboot and cpr-transfer modes are available.
>> +the cpr-reboot, cpr-transfer, and cpr-exec modes are available.
>>   
>>   Because QEMU is restarted on the same host, with access to the same
>>   local devices, CPR is allowed in certain cases where normal migration
>> @@ -324,3 +324,104 @@ descriptors from old to new QEMU.  In the future, descriptors for
>>   vhost, and char devices could be transferred,
>>   preserving those devices and their kernel state without interruption,
>>   even if they do not explicitly support live migration.
>> +
>> +cpr-exec mode
>> +-------------
>> +
>> +In this mode, QEMU stops the VM, writes VM state to the migration
>> +URI, and directly exec's a new version of QEMU on the same host,
>> +replacing the original process while retaining its PID.  Guest RAM is
>> +preserved in place, albeit with new virtual addresses.  The user
>> +completes the migration by specifying the ``-incoming`` option, and
>> +by issuing the ``migrate-incoming`` command if necessary; see details
>> +below.
>> +
>> +This mode supports VFIO/IOMMUFD devices by preserving device descriptors
>> +and hence kernel state across the exec, even for devices that do not
>> +support live migration.
>> +
>> +Because the old and new QEMU instances are not active concurrently,
>> +the URI cannot be a type that streams data from one instance to the
>> +other.
>> +
>> +Usage
>> +^^^^^
>> +
>> +Arguments for the new QEMU process are taken from the
>> +@cpr-exec-args parameter.  The first argument should be the
>> +path of a new QEMU binary, or a prefix command that exec's the
>> +new QEMU binary, and the arguments should include the ''-incoming''
>> +option.
>> +
>> +Memory backend objects must have the ``share=on`` attribute.
>> +The VM must be started with the ``-machine aux-ram-share=on`` option.
>> +
>> +Outgoing:
>> +  * Set the migration mode parameter to ``cpr-exec``.
>> +  * Set the ``cpr-exec-args`` parameter.
>> +  * Issue the ``migrate`` command.  It is recommended the the URI be
> 
> s/the the/that the/
> 
>> +    a ``file`` type, but one can use other types such as ``exec``,
>> +    provided the command captures all the data from the outgoing side,
>> +    and provides all the data to the incoming side.
>> +
>> +Incoming:
>> +  * You do not need to explicitly start new QEMU.  It is started as
>> +    a side effect of the migrate command above.
>> +  * If the VM was running when the outgoing ``migrate`` command was
>> +    issued, then QEMU automatically resumes VM execution.
>> +
>> +Example 1: incoming URI
>> +^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +In these examples, we simply restart the same version of QEMU, but in
>> +a real scenario one would set a new QEMU binary path in cpr-exec-args.
>> +
>> +::
>> +
>> +  # qemu-kvm -monitor stdio
>> +  -object memory-backend-memfd,id=ram0,size=4G
>> +  -machine memory-backend=ram0
>> +  -machine aux-ram-share=on
>> +  ...
>> +
>> +  QEMU 10.2.50 monitor - type 'help' for more information
>> +  (qemu) info status
>> +  VM status: running
>> +  (qemu) migrate_set_parameter mode cpr-exec
>> +  (qemu) migrate_set_parameter cpr-exec-args qemu-kvm ... -incoming file:vm.state
>> +  (qemu) migrate -d file:vm.state
>> +  (qemu) QEMU 10.2.50 monitor - type 'help' for more information
>> +  (qemu) info status
>> +  VM status: running
>> +
>> +Example 2: incoming defer
>> +^^^^^^^^^^^^^^^^^^^^^^^^^
>> +::
>> +
>> +  # qemu-kvm -monitor stdio
>> +  -object memory-backend-memfd,id=ram0,size=4G
>> +  -machine memory-backend=ram0
>> +  -machine aux-ram-share=on
>> +  ...
>> +
>> +  QEMU 10.2.50 monitor - type 'help' for more information
>> +  (qemu) info status
>> +  VM status: running
>> +  (qemu) migrate_set_parameter mode cpr-exec
>> +  (qemu) migrate_set_parameter cpr-exec-args qemu-kvm ... -incoming defer
>> +  (qemu) migrate -d file:vm.state
>> +  (qemu) QEMU 10.2.50 monitor - type 'help' for more information
>> +  (qemu) info status
>> +  status: paused (inmigrate)
>> +  (qemu) migrate_incoming file:vm.state
>> +  (qemu) info status
>> +  VM status: running
>> +
>> +Caveats
>> +^^^^^^^
>> +
>> +cpr-exec mode may not be used with postcopy, background-snapshot,
>> +or COLO.
>> +
>> +cpr-exec mode requires permission to use the exec system call, which
>> +is denied by certain sandbox options, such as spawn.


