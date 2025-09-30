Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28D7CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 19:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3fh9-0007mq-3Y; Tue, 30 Sep 2025 15:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3fh6-0007go-9w
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 15:07:24 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3fgx-0001kO-PD
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 15:07:23 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UIOVIw012236;
 Tue, 30 Sep 2025 19:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=QE6tPPLMG5hO9BvOdWCuvMC0idHtNOZnevuVr6lKdkk=; b=
 Z9e2Puj0P4CAAW+mvD1fxgHngq6zxbZOA3v/fWLRor+FwM3Lkag2oJ77MoeWCgED
 Qb0U6FVAGmB9R3sy92hlxRBx9nUO+6L3vg5s9CpaZosmvJagSMpaG98ga82Zqipx
 5UuJMVbANyKe7qQvBu2FsjIUcH7W12jZfWnpgo82ZgTnz3jc42pgM59tPaZRNtgq
 wsIXwlMXliw4CqHZwloTqRwqCFBZewuNWHAyy8VW+Fu1Godmuwzky5VO9HOhg/I5
 ECRKfFumLhRWtY/l6as6qYj6qsJaNv0x+sDhEAS248rOYHB58/wczgwz7JSa9u3l
 7PWegQgcp6FBTKDOVvOweA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmf1r2cs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 19:07:10 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58UHofM5007188; Tue, 30 Sep 2025 19:07:09 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6c98uea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 19:07:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHqKPRb89P3K9lJWSu5F73BvqgYhYhj74OshfZHq8uF7vNyCzlzbojBI6ZC1lqdJVoNZJ/s3xZjOxj22qbo8f+P+iT3XmO0oGkiSrxjEK374HstL8gTgsXUHc3vK/W51T3A09LZeQNyC2YDqd4P2zThjVCX5IDd3vMkt1HmzJxEq5NABVOZDzRn+RKTT8fZeeQB55+ScSA9afVHmJV/qASL4mMFQ0lbdTlkPzaxavoJHLG78THJjGWiqqb/iekVWLOd2kOLd/yY3UNmqCHz47K3yxmyZKFJ2sWAg4UqvEjGxdBxUrea9xvjNa95H1LQ7ea7tCAZeqELZlEcCAowKsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QE6tPPLMG5hO9BvOdWCuvMC0idHtNOZnevuVr6lKdkk=;
 b=fFe3NNf3iR4kVGnc3pJZHfm0a9TzF/sWo4AWXRWb5/JnMaU12/6gw+/bi9dPQKioFQoKBFh2qpaC6JULLmv7+rAFB11i3KVm79T3VAPjgBYj8SP7M8L9rdQxpwXbeEJGabPQiHECsfeBlfw/3GLomnS41m0unN3V76v18cQRVRJXY6UwmZWJ8gowHeQvYxNDM3hsM/ZfhocABOvLkeIs9R5QgF2HzYHeDjeProF+P/8nn1yJ+1i7qklMCT+FEo2Oms/lz2Lsc2/CodAgClJF0OVcA+zSd2tX3dbDwWGlf+VGMjqzyOU3xAcscvcirrNyzOC4E6L0VwKN3c5386x1rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QE6tPPLMG5hO9BvOdWCuvMC0idHtNOZnevuVr6lKdkk=;
 b=KrMd7kx6KWDA3CJnWQ+RIYbvNA4TeBmG6wNhxre1U/sMjOtjKRCXd3WdCfhrCppQT51Ksg4AsiQHrSTXZi2Rop/fH43SAVg9qkQIXnz1zISjA9qOuao3ugklK1lGcUbEKzr/bo2QMvHbo0A90TcSJJrrp69kAOfRn9Vok74olqM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA1PR10MB6613.namprd10.prod.outlook.com (2603:10b6:806:2be::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 19:07:06 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 19:07:06 +0000
Message-ID: <0e3da940-8849-407c-a299-7e1c4e920033@oracle.com>
Date: Tue, 30 Sep 2025 15:07:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 11/11] migration-test: test cpr-exec
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <1758291153-349744-1-git-send-email-steven.sistare@oracle.com>
 <1758291153-349744-12-git-send-email-steven.sistare@oracle.com>
 <aNwOeCkXZpPtmPTF@x1.local> <c9a32330-56f7-4940-bdd4-9c87f24a0a2e@oracle.com>
 <aNwpYiUpFwtTKcVi@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aNwpYiUpFwtTKcVi@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0017.namprd16.prod.outlook.com
 (2603:10b6:208:134::30) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA1PR10MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cbdc2b4-8c7b-4464-b40d-08de00548c35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0xCQzNsK0lYL0pYMGg5Z0dWd2ZEZ0d1dlZOdEgzM0JjSjJXY3QvY3daMG9k?=
 =?utf-8?B?M0N3eklieGdYdHF1aDRycFFYYUhPZlJqZ2hDYW9ZeE9PdzF6Q3JLUFBkcVo3?=
 =?utf-8?B?NTBEd2RmZVhnbGo5bEt2S25OL0JTckw3YXRDaTFJSWJyOUhkOStJcGkrVi9s?=
 =?utf-8?B?bEdNbHVuUDlTYXZ3d0hBWndwYjY1blQ5RURzS2FEQTcrdjJ4djB3VUx1Y0pC?=
 =?utf-8?B?QlN4VlpRNXg0M1hZaHFWNjZRZzZzYXp4YnFXeXhWNFZORFlaQTZuNStyejVN?=
 =?utf-8?B?dlloWDJPdHNEWHFyL2ZWL3d2bEdkVVRobXVDZzhuK0k2Y0ZHZUlaa3lqL000?=
 =?utf-8?B?Q1J4L1BHbTl6L0Z6RFQ3RkUyU0x6NmFCcDE1VUhrV2FlSnl0Y0hEeHV4YSsv?=
 =?utf-8?B?cE1KSEE1am83ZjMzUEdxa1RwQ2hJTm9yY2c5RjJUdDVUZG5CK1ZpYnFSd3Zn?=
 =?utf-8?B?azZya1gzQUkwMW1aUVNaTlc2YlMwK3BUWUJMSDlaWlpKNzdpV2tZazZxdDRV?=
 =?utf-8?B?cTBzWm8xRDFMRGsyZTJTd3ZyVEdZbmVtZ0ZtbGFWWEloSFlVRzc3YzBqTFRP?=
 =?utf-8?B?dHNZVEk5ajNYa2RYVlpiK2wrL2tBV1pVOCtvc04zRDE1SWZEZkhVVERTaStR?=
 =?utf-8?B?NEFzVVVIOExGaUdFQXh3cTl1d1lQRjh0M1BGVUVBaVZoV2NnWmtta3hnZmxl?=
 =?utf-8?B?MDhHWmpEaW5RL2dreEpJSUpYRWd5ckk5RUJKSmxvamVqVHVMZHl5MTRVSWoz?=
 =?utf-8?B?bC9GSlRZZW5mRjZlanBtOVdTOWN4bFByWVJkWUZuaktVUzVQVzZmclVmTUw1?=
 =?utf-8?B?SUltRzRhaHNSZTNrQlo2R0QvZ1dtOGR6TW16SnJLSnpZeG1BUHQzSnJneDho?=
 =?utf-8?B?aHVvcVM4cm5hSGNNK3BhYUZNblF6Q0M2aFRsZW9FeDRsbi8vZExRVzNpc3pV?=
 =?utf-8?B?NlU2NWZBN1NOR0p2WTZhanU2T1ZZYUpueG1zdlFCR0p2aG5kVEI2eVZ3M2hk?=
 =?utf-8?B?VlAwa2lpdElpOVBFM2lSWW1YU2tNRnlBWmJ3N0ZSSHdLVjhnUndHWTk3V0kz?=
 =?utf-8?B?S1Y2endWYThtUlNkUUk2RTRPbGcrQW5lQVZWSE5JRnY4RmNXNGxzdnNTYjhw?=
 =?utf-8?B?N0VlQjZ2NGxTQzA5NnV6S0pEMjVxaEhlWkZGTU11bUt2SXBXUnA1SmtubUg4?=
 =?utf-8?B?dGxoRXpmQmM3ZFAzZ0hzNjZHeDNWSkNtcVVUVHdFNExhd08zRGhUcm9WMW9B?=
 =?utf-8?B?dFg3WGgyOWlQd0xnaVpTS0JWN1krK29jQ2s1ZlVVS21ueGI5NkMvN2wxYzJP?=
 =?utf-8?B?WnlWbGgzenB2TGF1cFQvR2h4MWxWZjk5YUZOUFcvcnNCcmMxTW5PRWFLbW85?=
 =?utf-8?B?d1Z6THQ2NTl0UTdFbHFrOHU3ZkN5RFRpNXFha3lFeW9mN2lMUHQ5UUVRYTAz?=
 =?utf-8?B?V0lwYWVxL2gzQkwyOEtFWUExcXNrVWtRZ0NBMVZkVFEvOHVIVXl4M3FMcTZF?=
 =?utf-8?B?dGVzUkN5YUJaS2pWbDRkNlMxQzJzNm9OYnFQVDFLNVRmVkVhWVNjQjJpVGpH?=
 =?utf-8?B?RXpwNVVuZGpSWGRKWkhYSkJBYzlhZ0k2SFB0dnlZS2tHNlFVaVNBOThTTktP?=
 =?utf-8?B?OVgvUFhoZnF0NGpVaTdXWC8wZEYvb1NvV1crcVAxNWRWN0pJeUNTWGw0M2VN?=
 =?utf-8?B?U0wvRWxwMDJ1SSt1NVVPOGpCWkorcWliSkFtK3hiS1NiQ2paYTVnUm9FT29r?=
 =?utf-8?B?dCsyVXJLWmlMbGdYTlMycFVQUHp1S0VDU2hRYVY0OWlKTTB5YXJCbXp3Vmxm?=
 =?utf-8?B?K2hmMlhVUW91SzZ3MzhHSjhndnlYZUFZaGZ3bTBRd0YyNkU4bllYK0lseEtI?=
 =?utf-8?B?aDY0OGhVVUpGMFhVMCtrbnUydGthaTluR0Rzc1JQU2creVZLV1VndGd2dFVH?=
 =?utf-8?Q?GKNclkPHrlG83Tx6BVakFRyOkoR9WvL/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHJwQ05IdXIwNm11eEdoVDNwa2l4TlRUWUlVZDhkMDd0aTJYSGxHWlBLcXU4?=
 =?utf-8?B?SjAzd0lmQ1owTmwrL2NYZFc0S1FpS3dyK3hxQVNadGgyN3lvdlhvK2V4Q1dR?=
 =?utf-8?B?b0IyVUU4MGtwaHdVbm9NOWIxL2x2M1BDd0EwMzlaeWNVMlpoK0lMRHMxbVhs?=
 =?utf-8?B?Y0g3ZE1KMzRnbmtPKzREckIrMkZaTXFTV1lmVTlTZFNNRElROVV2ZjBXRE96?=
 =?utf-8?B?TldKbzZKc2hENkVSWGJyZFRmamY5SzNYUDZNZElVQTFJVkdIWkJIejlOZTlN?=
 =?utf-8?B?Ujhhc1F6RXlBY0V3TVJsdG1FVVFWdHJNT2owQ1RnU1VITk5aVmF5VlVYN01Q?=
 =?utf-8?B?S0hTQWw0cFh1bTV4cFpsTlRObGc1Z0lDdlMzZnZUMWdnbDVwdnZPY0lIdzN3?=
 =?utf-8?B?N0lha0JXSkxvSmVQN1N5aEY3U2N5QU13U3ZXRHBTQ3ZXL01wMXd5a0t2dlho?=
 =?utf-8?B?SEhvQitVOGZXRCtxRDR2MlE2bHVoOThkRnR4UkJRSXlZWk10ODd0d0FObHV3?=
 =?utf-8?B?by8rV1JDYWN6akt4V09QdTBIZXJkcHB2bWdzSlpVMEhQaVU5TVB3T09HQ05G?=
 =?utf-8?B?UG5JRHNsZXZGd0wxWVIvZWEvbDlmdmRtVnduV1l5K0xTZlFOMCtOWTZ3NU5y?=
 =?utf-8?B?dVZ0UHl1Q1NPVzJ6dTR1dGprcWdwN1k1QlJGc1NWRzZoTVg2SFZVemR0OE5M?=
 =?utf-8?B?N2I5aC9uWXBWdFZzOHFSZHJ5M0dKaHQ2K0orb2t4UzJpZTNrUHVydmd3UzVZ?=
 =?utf-8?B?cmtPSjJQV3JaL1pBY2gzNkg1djRtelBZY0tWaHV0ZmZZQklveWk4c2ZtZUtM?=
 =?utf-8?B?MUg1bVlBMFg1WGp2TWJFSjk3QnlFZFNMcS92NGZEU1VYRGNUcUFaa1NZQzBQ?=
 =?utf-8?B?dk12cXBSU1FybGFkTWY2Q243Tyt1TnREcTZZaHVjeThzNlo3cjRBVmdUcFN2?=
 =?utf-8?B?cTlObjlZQi96NEtDTEFzOXk1dmhlQWNOSzkreWQ0bVFvYnJIdlZ4VnFDU0tC?=
 =?utf-8?B?cHpHK241eEcxSVlpdHVDVHNFWFNXOEdQTUdLQzBFdXhGVWEyS1J5YUR2ampS?=
 =?utf-8?B?Vm9sUDRsbWFwVHZwcHdmNVdndUZRa2R5V1pQK3hScm90S1JXM0tzZTVRSzNw?=
 =?utf-8?B?dW5aMk43dlJuQmFIdS8vUE0yVnJVTEFpKy9jeDBYeXVIeDFxSXJSYU9xWUJF?=
 =?utf-8?B?LzNWWnZEbzF5UUMzSWFWaGRrVDJKUUk5ZGJhaW9mNmZJR0ozbmU2OFlIU3Qz?=
 =?utf-8?B?WjMwV1Y1Wk92R3gxNlFzcjZiQWdvbEFwQ25tZEVHTXRkU1R0eFEzQWZGeThU?=
 =?utf-8?B?aHl2NGl2b1phSUVxaXRkODFsM2RuZktycTBVazJ3eVdzUmFEMFV0MGhnek1Z?=
 =?utf-8?B?VWtOVitQVGU2SVNudHFRdzJ5NVhrdWZyY05Dbm1MZWk4NHlBYXBRRVlvRlk0?=
 =?utf-8?B?MHBrc2RmTklONElSYk1ack5lNWNQa1JCNjJ6cTR2VjJMdTJmVWNXOWM1M2dM?=
 =?utf-8?B?VTlaMnU0K1lucC85SXZDVHgvYmZpRldQR0FWOXNPb3VmcmcrZTE2T2Y0MzhV?=
 =?utf-8?B?ZWd1NjNDRGljbHpNTS9maDhPa1Mwb1hsUXdFQUFkeVAzdFpLNU5yclVPZ0Vl?=
 =?utf-8?B?YkpXUG5CaHZYVStkQklveDY5WjVkeG52dEZEQ3RKNVlUMlBMSGFrYTVDTVdh?=
 =?utf-8?B?S09sWUQzeUZkQ3Npc3NteVNDWDFuU0tEdnFVU0JxNnZZeG1IMFJZTW01TGRM?=
 =?utf-8?B?czV6cDhLS0NQL3ZFbDFjK2s2N0FCOHBuSUVJSXFVSi8wQ2lWTUxmWlFOdllZ?=
 =?utf-8?B?cTNZRzB5dU9kbmprUTl5R1FFclZDQ1Rub0VJSkhicVVUbkxqM2ZVMUVmdGVI?=
 =?utf-8?B?SW5WeHc2QzV0Sk1yRm9Ydm5nVGUyWkNHYjFMYThGQ3dha25HL0Nqa2V0UDN5?=
 =?utf-8?B?VldPMlVvQVkxU0gvVEVUNGR2dUxEWjVCc2l4Q2lJOGVvc0dFOE1ITGgyYkdP?=
 =?utf-8?B?eVEwTmw0Zm9qTTd3YnJMcmc5WW9ucldYaEtpbmt2cG0xbkRwWjZTS0wvNmUr?=
 =?utf-8?B?NzdnTTZIdHpBN0lLSEY5T2IzVnhLRlM0WkVhNUJpbjlab05qd3V4bjJ2VllQ?=
 =?utf-8?B?bXNmU3dSVG9MR0hYUi9UTmlqMDZpS2FnankvUFY5SmNIeXFrbDV3bEkyZ1VV?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7/4k1WrB5aYl8FDWJxLJtMe3pa/uz8STmOX3pc005JtkQVDqpljup677D2T+6w96Bs24G74QUkGlBh+mYhKgpLDOGD9izVGybE4hjG7aWdLrF0c5YUre9S7oX/vGUDxcPZjH56lmOmjbCp8w43o7Km8addf05gSM5aspwWylr9WXPgq/iRtU5R/AKxQVUDCOXiF2V81gdpD7vHaVHQlhq/gJx+ER3NSGIJzWIuyDbTbDca2fq2tDT2RmijPtyuPZgPoteeuLF0xRpvQ4La+Vb2ERWiyZwek0h4Fd2o/DQjRvYqE1NV3jvr84eQwYc2jtIXY2o6GFPZsyMv/w3oYLY7h75ZqdMJeMzi8/F7vVzEjThJRoevLtoMCLA7qbTZ0TGiosDjXUrJKupkq+DW0n0b5tU7I+kyEdVFA47DuDUa8SpDdjxhHDULy75PdgcKJ9DxGpHstC1Ab4oLCV72u5Sgg1VOx9GSKZOi3/nyybrbeZiyfm6upoiRt//b998pIShBbR4vhWzX5xIDr5bbPIv+SjM77DiC14w17QqNq+FFbpzqDPDXFUZ2K4YxpW/+VhlmqCwO8vv+dR3VBblVdpZpgvEU7GLr7b87LndipYKkE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbdc2b4-8c7b-4464-b40d-08de00548c35
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 19:07:06.4163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BR58GSEreYtlH1uNNKdNgJjUa3Y8YMiNJNpsfGGxjol4vBycRGnO1MBYly//j5g5fo4L5AEZQ7MDOd13IBhO7I2RvxZNBT1ZXIF+9dkrZcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300173
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2NyBTYWx0ZWRfX7qGJ5ytsz48r
 FxHwOaIyuLnJphTtNEyGZCKSnbXLTgrpEPnu8oYj1FwJ1UE+Zr6Xmo+u2hduYWGTQGA6+MK7/Ys
 bhh03nbiMO29eqxouYn6XISTJT/LPCOEsKmIEzJjgsG7m78lA9XjNmxV1JFW7p8nsf+tdkXwx3Q
 4M276ju6IOtvQ41uYUmkJpXLYbaAiwDndE/oFjkACWF6/ZRWx0FHGGoNmKbcy8jhBDbRmUIuqK6
 g3dXOq2hUQlgiCs6z1xZnFSVmgTwkpPGT0MM5E0MFYCrZLT4Skt0pN+IsOqm0FZKzS4ankVHpd9
 Amxt8bGmAlJxIR8TpgwHIkC7YcoOSzqmgYjTZeVDuACgYxbtbitC5omT9tGD3qju8xU6LhJNj2C
 yHEeILLc/FFWz1KtCT0vbMZLAIpO7g==
X-Authority-Analysis: v=2.4 cv=K/cv3iWI c=1 sm=1 tr=0 ts=68dc2a5e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=D9bOPsG5zkCFmefzaD0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: NK_wikK61iMdh6R9LZ28iKjffnYE46Re
X-Proofpoint-ORIG-GUID: NK_wikK61iMdh6R9LZ28iKjffnYE46Re
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

On 9/30/2025 3:02 PM, Peter Xu wrote:
> On Tue, Sep 30, 2025 at 02:23:49PM -0400, Steven Sistare wrote:
>> On 9/30/2025 1:08 PM, Peter Xu wrote:
>>> On Fri, Sep 19, 2025 at 07:12:33AM -0700, Steve Sistare wrote:
>>>> Add a test for the cpr-exec migration mode.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>
>>> Looks good, only some nitpicks or pure questions below.
>>>
>>>> ---
>>>>    tests/qtest/migration/cpr-tests.c | 120 ++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 120 insertions(+)
>>>>
>>>> diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
>>>> index 5e764a6..f33af76 100644
>>>> --- a/tests/qtest/migration/cpr-tests.c
>>>> +++ b/tests/qtest/migration/cpr-tests.c
>>>> @@ -110,6 +110,125 @@ static void test_mode_transfer_defer(void)
>>>>        test_mode_transfer_common(true);
>>>>    }
>>>> +static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
>>>> +{
>>>> +    g_autofree char *qtest_from_args = NULL;
>>>> +    g_autofree char *from_args = NULL;
>>>> +    g_autofree char *to_args = NULL;
>>>> +    g_autofree char *exec_args = NULL;
>>>> +    g_auto(GStrv) argv = NULL;
>>>> +    char *from_str, *src, *dst;
>>>> +
>>>> +    args->start.hide_stderr = false;    /* omit redirection word from args */
>>>
>>> It's default off, right?  Could I request for some more explanations?
>>
>> Yes, the default is false, so I will omit this line.  I will change it to
>> an assertion. (IIRC when I first wrote this code 1-2 years ago, the cpr-exec
>> test was a derivative of a precopy common test that set hide_stderr=true).
>>
>> hide_stderr must be false when deriving cpr-exec arguments because of
>> this code in framework.c:
>>
>>      if (!getenv("QTEST_LOG") && args->hide_stderr) {
>>          ignore_stderr = "2>/dev/null";
>>
>> ignore_stderr is appended to the command line.  For cpr-exec the command line
>> may not include redirection, because we pass it to execv(), not to the shell.
> 
> Please kindly add this rich comment above the assertion..

will do.

> 
>>
>>> Could we also set it in test_mode_exec() directly if needed?
>>
>> Yes, one can set hide_stderr when launching the source VM.
>>
>>>> +    migrate_args(&from_args, &to_args, args->listen_uri, &args->start);
>>>> +    qtest_from_args = qtest_qemu_args(from_args);
>>>> +
>>>> +    /* De-dup spaces so argv does not contain empty strings */
>>>> +    from_str = src = dst = g_strstrip(qtest_from_args);
>>>> +    do {
>>>> +        if (*src != ' ' || src[-1] != ' ') {
>>>> +            *dst++ = *src;
>>>> +        }
>>>> +    } while (*src++);
>>>
>>> Pure ask.. when will empty string be present?
>>
>> migrate_args() format strings "%s %s %s" produce "   " when the arguments
>> are empty strings.  Then g_strsplit("   ") would produce an array of 3
>> empty strings.
> 
> ... and here too.

will do.

- Steve


