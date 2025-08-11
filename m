Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9E4CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 18:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulX97-0004QE-0Y; Mon, 11 Aug 2025 14:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ulX93-0004ML-7A; Mon, 11 Aug 2025 14:21:17 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ulX8v-0007DK-Gb; Mon, 11 Aug 2025 14:21:16 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BFN34b013358;
 Mon, 11 Aug 2025 18:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=5Hp2GYwQEPETO9JYR3gaIwmGLC4JRQK1zLQiOldr65Y=; b=
 mjYYjINYKY+j82L6RdcDsJ5v8mgMFGzOhB6+dkKpnZzLnhULrsHZaTOHntaMJzaL
 pUxRcdYQqFS93nTyVaNI6VAUTowmlJ0TrOa37wHs0rLT/h/99gTypUA8oyZnTJ1P
 CnBprhP3n6BPbpEw0S8kUx2fgPwFL1FAHR09UBAWsIdGpgCYeN5dp+oCf9ja9XkC
 ggO24jK2yxmY3g2smGy3nS4dtbcSBFRw5HoMomKECJ51JkuioL5i9tuMnnuwL+gi
 Lmcyr0O3L/Uk/s9V/TGgpZdxB8WuyDuG1oKs5SpS1dVvczkYZTqs1Zbi1wGgXUX8
 RFZPeifHCSZgJ7MGsNJpmg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw44u7jy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Aug 2025 18:20:59 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57BHLVwK030063; Mon, 11 Aug 2025 18:20:51 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013011.outbound.protection.outlook.com
 [40.93.201.11])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48dvs8yp2h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Aug 2025 18:20:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZT7pTXnUvZ6MwVa8Hk/K2WZGoUaMeSs2VpKqUtDiyns4IUNl2fBsuxdOdSuMcpxma6MjY0rHwWwBDX5Qn8z8EU0kQKqOP4mnETBysYR3EEci+HFgIoib63DpH5frKxx2LxibkDy2dzB6Rm6/c/u26pV3hBuOJmpNPjv7IqMK+71FjdLjhnHrHKE4uoOPQwoyt8hqUfFjC/kfxtd6Ou82xhiWOHKWpBzh5kN4/ORUC4T+nEl9022f2f1+I6fVfx61DEP5eZcO3bJqRsXHkQYiYC2+2ITatK7cjmdp475yQjfmFfg4YrO8DgeUuhN6u1/j//rU0e3cv027di+s9XmokA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Hp2GYwQEPETO9JYR3gaIwmGLC4JRQK1zLQiOldr65Y=;
 b=R5Bb8AKAY9kj4hPMz72lbx9jcef/8Ma3TDb2Rvg0Es9CbCm0bSQgZ3rNyDlvEU19bhQejMR2YG3heTOkgUVoWZ1Q1rdJU/Hd5pA0Zl8gydryTZQZPYIDflr74BwgORXZihbY7CABQAfw02/IT2TEwnqy2DIy9vOhhSo6Hrn7txT3hvY9twXGmmoULispjtbsYWY5ObkdQNLQLXpG/SRKLBYtS8+ZPgcwGyml71eqrJlv3LdmzBptXa7BEgzsETkHiSpzr+8sIBa8DqmRUZF1rKDC8QhpN+dz9rdGsiQADsTW/CkScGKz3Xb0lFYeqL6gFtlx8O3oWW0GYAdaYGeaAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Hp2GYwQEPETO9JYR3gaIwmGLC4JRQK1zLQiOldr65Y=;
 b=AoEniploS4ku30GUp00t8BtGIzsShKX1ouK4fudSs0OfZeDWt7ia4wYSKESMRFYHpOhb1Ek8K9YLQQPzY+QAiED6F8dlw5FoQqdW/MQBor+BIuQyB1BGBFo8asuNb1yFvS5pzlFiHgZGg5ZzjmZ/BMvx4ZuTi7zYyFP+fy3mJQ8=
Received: from CH3PR10MB7436.namprd10.prod.outlook.com (2603:10b6:610:158::7)
 by BLAPR10MB4977.namprd10.prod.outlook.com (2603:10b6:208:306::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 18:20:49 +0000
Received: from CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54]) by CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54%4]) with mapi id 15.20.9009.021; Mon, 11 Aug 2025
 18:20:48 +0000
Message-ID: <7776e3ba-00ec-4ef1-b7aa-4cec1623d60e@oracle.com>
Date: Mon, 11 Aug 2025 14:20:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/1] hw/intc/arm_gicv3_kvm: preserve pending interrupts
 during cpr
To: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Cedric Le Goater <clg@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Alex Williamson <alex.williamson@redhat.com>
References: <1752689274-233526-1-git-send-email-steven.sistare@oracle.com>
 <CAFEAcA8P4H7n=uXe3qredxVMwB4QtDfZtVyuuTWBLwa6enGR3g@mail.gmail.com>
 <63d52f3e-5d29-45be-986c-3827a5c0cb5c@oracle.com>
 <CAFEAcA-TsQdFt7S=qyd14gxW095t=Nx2skaxnmxtGUhR9pubtA@mail.gmail.com>
 <4c6c57c6-fe7d-44a4-a875-3ede9e0aba58@oracle.com> <87ms8e3on5.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87ms8e3on5.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0186.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::11) To CH3PR10MB7436.namprd10.prod.outlook.com
 (2603:10b6:610:158::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7436:EE_|BLAPR10MB4977:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f7b9f2-8667-4fd5-53b2-08ddd903cbe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0VGdkdjTXpjVE1HblVYeG9VMWNVSUVDOE5QT1EyK1JjTTdaM3hScUVOU0hP?=
 =?utf-8?B?SUNsWXRJRlVNVkd0TTRYUWFNTG5wTVY5YTA1YThWTFBLc2FEKzdMcU93Yy8w?=
 =?utf-8?B?VGFXMGhPMGd3L2QwVHZlZnlxTVJmTVdiOWtIV0U2LzMyMkFYVVN6dkdocG1B?=
 =?utf-8?B?YS9tQk90UndGUTN0VUp3TFhpWm9pRmlZd1F0MnlyLzVtVXBJRXJWTWpJcnBL?=
 =?utf-8?B?SHVxbEx4U0hVLzZ2Qm9GMUcwTXA2bDIrWCtaSkpWQUtNeitydFRmNHNLenAx?=
 =?utf-8?B?OG5yZHhFNTNrdUNoSEluZnFGQXNDcjF4aXBqdW0rbExVbS9OeDQzbEJXMmlH?=
 =?utf-8?B?c0ZSMHhKNk1KQW5KRDlITDhtTEUybDNyTFAzRUYvUTR1Tlo4SFpUeDZWOWpL?=
 =?utf-8?B?dEhyZFV1R2FMcTVtb002aS96MVBZZWw0V0VCYldNbTh6TmhWWkhHRWdhdGJQ?=
 =?utf-8?B?YXFDVjdLWGlOZU9vUmJaMFo1SzZLZXZDR1hpVnFvR0kzRDd5SnBSazNrc1pa?=
 =?utf-8?B?bys5dGcyY3dsQnlraVpVQUtZcmNzU0hiQm5WVXBJWjRYVlZMdzdsYThBOC8z?=
 =?utf-8?B?bW5hU0ZpRUVTY0UxUzlMdVV6d2dGZnp3b2VjMW1jZ2dmUnRkQlBlekRUZ1dr?=
 =?utf-8?B?c3B6SjFVWW1salRJTEhvS1dXdmJPN2xsZFdCYUY5dmVOeE9xb0cwemtycnBh?=
 =?utf-8?B?NkZYTWY1amtGcGoyWUduaCt5Nk5CVFljRlVJWGVOVldraHBBL0FGTmtKSnk3?=
 =?utf-8?B?Mm1sNDdxZ2hvckM3ZERmVG41SWw0eHlISllxMG5lMGE3Z0swR3Nwb1g3ZlZM?=
 =?utf-8?B?UDhIb3ZXWldVOG1scUhrbUIyNVNTdjhoSHFFVzRSTTBYKysxSmRCL2JCNWtw?=
 =?utf-8?B?TGZOZlh4eHh1K1BFcEh1R0tLeUtDMXUzM2J3V2ZYY0hic2taQ1ZCVGNwQk94?=
 =?utf-8?B?ZUtjczIrcCt1enU1R2pFcThkSXFEZFBCNmdxWVF5eW13U2tJT3lkVmJ2VHRT?=
 =?utf-8?B?aGprMHRjTmNBa01Ud2Vwcm15NmJrcUppOGE2eE9paHFvaTNpTW0xZDNGei82?=
 =?utf-8?B?blVzQ0dKUytqWEVtMHBTMUFFdTRWQk5RRFNvdTVmZFhuV3NpZUZjRFp0bTFu?=
 =?utf-8?B?cXlPLzN4bldzeE9zTklyUUNUVjkvVkJWWDMvRzhWTHdqZEdVVXRMVnQvVHNx?=
 =?utf-8?B?Z0RDZlo4MVpRb3RjKzlYQVhod0JVek1admRYV1JMRzVVVm9RVWhIZUN1NTZO?=
 =?utf-8?B?SkhsY2xxZUpNQTVwMWxZSVRNMWphZHdtRy83R0toTXBHU05MOWdTd25OY2NN?=
 =?utf-8?B?cjNLQk54Zngxc2FsQTJsTkdLV0M3ZEZ2enpXdENIZDlkd1AxeUpHdkRrdU9l?=
 =?utf-8?B?MjM3bklxQnpiQytoWjV1OEhONXNnd3QwelhEd1FiSjY1Ri9naTExK2U4SFdw?=
 =?utf-8?B?OUROaGpsVW5KV3NiR0NQSk92M1hOUG1INDFrZnhVemtyVEYxbkxydFhsN1Ry?=
 =?utf-8?B?K01xQlRKdy83am1rdWIvam52RS9YK2dCSFRnSmxSSlU1aXU2Yy9kbEpMRFBW?=
 =?utf-8?B?bGhENGZLVGk2NzdGR2Vib1dTUWRTQjAxeTBORGpFMm5oSzZ6UlZWSmM1WnJp?=
 =?utf-8?B?dDdwRldCNVQvckhES3RRbWRlb3c4VW5ZRFY4UWZwNDFDbXZsQkFDQUZTRXc0?=
 =?utf-8?B?aEJoOW5qVURWcXVpYy9wTjFzbmk5cGRCcTJ0U1dyblE5RGhvdzhHSVp4M3lT?=
 =?utf-8?B?UTdMdmE1NTBNTk5iM2h0eUc1czZYaTJXUE9MYzB4T1F1S1Y5MzZ3ZzVGWjdz?=
 =?utf-8?B?bmNJcVN6TzZNc2ovMHN3SXhMWVJnYkZ5azhtZ0FYYlQwZmJJV3Y0RnhyTk9V?=
 =?utf-8?B?bUg3Qjc0Z1VVZjhvVEh3cmhqL3M4MjJ6TnV0SmVWVjZaV2pJVndVVDhEeFhF?=
 =?utf-8?Q?GgHiv26bYCo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7436.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEVtNWFLK1JMUzBzbStPWHlUbkNTQ3RndWFQc3p6aHJIUmVmWGozeTFBeTlL?=
 =?utf-8?B?SER5NlVTMVpjNUt1UXR6Y1VaWkl3dUY2ZXZ6WHhMaS8rSUVURmc0WVJTb1F3?=
 =?utf-8?B?WUdZVkszUkMvbzhWbFYvdzVzNkVEZVVoRjgzUGx0YkMyVlY5MGlTaW5ETm1z?=
 =?utf-8?B?Rk9pK242bGJBZ1Z1QjRvQ1pFNllPckZqYkRBaFhqdE9Kc242SUlLOXlwT0Fj?=
 =?utf-8?B?QmZOVytTOGhRRzVwZnNQeXZwYk4yMnZUdE1KWlhVZ2xtQkZHdzBwWDUrUkNO?=
 =?utf-8?B?alh1d0dKRkFyK3NtWVI3M2lmQWpCOTFyUy8vdGx0YjBiQmtBb1RJbXJYVGl0?=
 =?utf-8?B?WXpaOEVaZXJqMUJmaTVQUnBZTWRWbUk0YjlKNEJBSFFOSzhBOURodHhwYS9E?=
 =?utf-8?B?a3hkOUpJa21tbXJFSTVXV3Z6UWdjbXVDRGc5bCs5QTdWYjJRa0hjQzlFZ2Ir?=
 =?utf-8?B?citCUSttcG1qK1k2Ulp1MGlzR2V4dDdTYk9PZ2xpaHRocXlDeHNXK1hJVTIx?=
 =?utf-8?B?b0dVUmFqRmNNU3lQZm84L2VQcDhiZXZEdWRDOTBVNVd4aE0wcGNvVS93MGdx?=
 =?utf-8?B?UWZUNU5jaTJIWmFPTVQzbVdQeXB3cGcvYk4yemZzbmFIRHlaOGUrMlJGQ08z?=
 =?utf-8?B?YjZLMUU2VzI4ZUd2a1ZVS1N1dWhxYmVTdS9HUzFEcng4dm8xSGFzTEhZOVh4?=
 =?utf-8?B?OWJmS04rZlhuM3pJUjV1NVdFK1hZZ3ZpZEUrMk4xWFBCcmJpSWpGYitnMnN0?=
 =?utf-8?B?NFZudzlWS0JFS25ldlNPdnVRaXlUNi9CaDByNHRJNkJKT2Rmb0wrc200Z1N2?=
 =?utf-8?B?ZExHR0NiTjRqMUd4VW5UUmJmYnNHVCtQajl5SkVPZFVPQmJCSVZ5V0dOaUl5?=
 =?utf-8?B?QmJDdEExRzAwT0R3Z25JdHMzVmI5STlabStWQUdsWjM5ODYremRVb1pXQldr?=
 =?utf-8?B?ZnVleWhsbzlKRnI5Ri8vekpqK0hybEtEUlpYd3Z5VjRoak1VOEVaZ0VwTEtB?=
 =?utf-8?B?bGlHMzZzZTAwLzMvS29jdlM0dUNvaDQrMHo2bU5nVXA0V0tkQjA2cXdMU09V?=
 =?utf-8?B?ZlgwTGhZaXFCMGJGcDE4MDBOK2l1SDQ4Q1FtRW9zOWQvQno5UnphbWdYWmc3?=
 =?utf-8?B?VDg0U1NtYi9tenR3aC9TQmJhM1RiY0ZUL1JmcktjUzdoMEJIZzZZNjBFQXQz?=
 =?utf-8?B?RDNTdndZS1A1SGo5Q2JKdEdPQ0I3NUlvMnp3dkt0bWlMS2lmSkR3ZStaREw3?=
 =?utf-8?B?ZVpXeExNRkJidngwK3NPZjlqdWFnMEk5QXFVZWtRbnFnLzMwV2NRdVV3VjJU?=
 =?utf-8?B?aXd3cmI2dzdLNnl2TXlsWmk5Smk4aFNMMVdYSjk0amVlQm1Ld2V0Qys4eEtj?=
 =?utf-8?B?K3RTSlJVRXV0Smdsdld4Ui9US0dNZ2pqSS9EeHhhRS90QjZKREZyRE12SDZB?=
 =?utf-8?B?aHBoYVJVQ3FjSlc0RHY0TDBaanM1NTg2QURQUkFNOUZyVDNaeDV5ZnlPQWdi?=
 =?utf-8?B?VFNiREgrbjNmKytINUJpbCt3d3NSL3ROQS9pUlF3cEhjK0Q3QkYra1l0ZEI0?=
 =?utf-8?B?TGswT243MUdxZEV4RmI1TFRQRlNpeUlSSWRsZ21EdDZnRjFtcWhXVWxZUm5n?=
 =?utf-8?B?UHg2Ukl2ZGlJT1RwNkZaZDNHVjRpVUdVSXdnOFY0OS9qZ3A0eHdVZGVsa2c0?=
 =?utf-8?B?M3ZKcmh4NTdKbk43dy9vRnhISjF5KzBGeThBd0tXQkFJcHBVc0pSM3FhNnE5?=
 =?utf-8?B?enpoa0RQTFZOSHRGd05keFI4bGtsVmhGZ1pSMjdqcUloK1dnajYrVTE2Y2xt?=
 =?utf-8?B?TDlveFQ2eHkwNnp0WFRrUlJHcXprZWNPZjUrNTlzdXVPY1VzU3graWM0QURo?=
 =?utf-8?B?TVFjZVpDUXNmWTQ1cG1pUDUxNy9KWmhUZ0h4QkwvWGg2R05qS09BN1doWVYr?=
 =?utf-8?B?S0dxMGZxcjRSTzA5WWZzaWwrUXNDSlR6L3hydnZtSGhyQm5UN3lCa1ZSSVo0?=
 =?utf-8?B?WldvY0Q1M0hRK0V1ZERYY2pqb1Zhd21jMTR5MUplRTdMdmZ4UnNnK1J2aXgw?=
 =?utf-8?B?SVJlcEtoQUp4VHBXRyswUm9GQ3UxdVBZRXkrT1FiYVZNWkkwa3lnSVp4K3Jy?=
 =?utf-8?B?TmMyMkJweUs1bklyWUtvRW9nUm9hcjBtUHBvQzdzR2FVbExiKzdoQjR1Nlgx?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AUeI7uopre27WlGpzLXaopRb/0HkMGLlYeIj7UbiAAQZufpdEKc33YztZoB1aTDaCiq9fNxgJi/fmlihMudc6R3g5k74kElDlMxVyBfDa6EZo8Chd77PcySGeEb2GF+eYE1YjZLQJwkT+iPeAHr1e9M1JETEH1Tfh8bsXij6tL3zgXerPjsBhA4nmqO1yxs1lSRbtZ4RKY/2YjC2ZxrwEKEy3Bd4fFNdsHB++QtzLJIrxJH0VRycKrUtrsZsq8U3ZfFXP9yHmrt8PN5C/9OQLCy1tsamwjy0BYxHz83GSVAM5roCSl6R2Hn9wOcPustO6n89biN8VMa/bIcTkSyGlwcfOWQWh5Fs1Yi06IfB0PGbl5GGOIbQgO/fx1TFgnyGFGONlmtjYyXojrJ3c+oG7QR5t7cV8JT5CvXMTQUi6n2sT85UHwoEP0B9KaHjZJ5NCMi1XaoY6Sw60fMqBnBG+OChBQPa2Y2R9E3280XB9fBWKP2bj3o0rHSgSuxQSkENhhE8I8SgMNaIaaRw/rOKPdIsh/K1URN12zIGJMniVkMCvJ73aM4bAtvsiYuIVrteYbBDgdAAJtxRLrlbHRz5m8l1G/KeH4RF52lddKSznLU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f7b9f2-8667-4fd5-53b2-08ddd903cbe9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7436.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 18:20:48.8171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzJLxHzDojnjB1Ln1wb6oevaN+db+jmHq398dMhYcktdy8hBQfTasc/trXoUUoWNGQ47M2TY3yyegZaQKxlHyfxLSgkNZOmmn3fR1w7gres=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4977
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_03,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508110120
X-Proofpoint-ORIG-GUID: 6jNqhitOzfNq-2qqkJWgRUbN5zyuIPrP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEyMSBTYWx0ZWRfX6n/G8Mj5MuSw
 5qMBk3GlSfPf3TUegFeYpsWbxJAC2iU7aBC7Ni2Dgcc3V+ZceC1JPC0UxQFPFJz0niesdrQU2s3
 ncazF3VC3hC9Yz+scLQG6fg7+WNMJfO/0CBJbuvECZN/0u8wIgMmeUN73DdjwP7dQ1KS+Y5wEe1
 njqYrZbt9jzKCMd8QfmPKvky8gpVWVKKvjkd9Q0rfU6foXjk8HDt68jtmNQK/uGkgRoc8C8UvgP
 G38wscM8fKORusrTu/9eDclCnDPNh0mpJWwm8K1gCOA7p6Y8Nc6Lfchj6Hqkr0V646fGZiRBciQ
 bm67fY3szz9knDQjvhg/xqQv76Ls7cP1xe5jbGaSTTUHGme993Fdn8sML9tncR4RlianJGhXXyF
 mVmnpwR736nB7nxfUUpQeYviDOnrXdLw7vtq/HBIjAH+swgLhohG4qLZNR+REGks5pkP9VDI
X-Authority-Analysis: v=2.4 cv=X9FSKHTe c=1 sm=1 tr=0 ts=689a348b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=W6bTi99XKwtoqWk7k1EA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6jNqhitOzfNq-2qqkJWgRUbN5zyuIPrP
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 8/4/2025 2:52 PM, Fabiano Rosas wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
> 
>> On 8/4/2025 10:47 AM, Peter Maydell wrote:
>>> On Mon, 4 Aug 2025 at 15:23, Steven Sistare <steven.sistare@oracle.com> wrote:
>>>>
>>>> Fabiano, could you sanity check this patch? Thanks!
>>>>
>>>> Peter, more below:
>>>>
>>>> On 7/21/2025 6:24 AM, Peter Maydell wrote:
>>>>>> @@ -883,13 +895,17 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>>>>>>                                    GICD_CTLR)) {
>>>>>>             error_setg(&s->migration_blocker, "This operating system kernel does "
>>>>>>                                               "not support vGICv3 migration");
>>>>>> -        if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
>>>>>> +        if (migrate_add_blocker_modes(&s->migration_blocker, MIG_MODE_NORMAL,
>>>>>> +                                      MIG_MODE_CPR_TRANSFER, errp) < 0) {
>>>>>
>>>>> Why did you change this? It's the general "if no support, can't
>>>>> migrate at all" check, which seems unrelated to cpr-transfer.
>>>>
>>>> "If no support", then cpr-transfer should also be blocked.
>>>
>>> But migrate_add_blocker() is a wrapper for
>>> migrate_add_blocker_modes(..., MIG_MODE_ALL). So doesn't
>>> this change go from "block migration for normal, and cpr-transfer,
>>> and everything else" to "block migration for normal and
>>> cpr-transfer but let the rest through"?
>>>
>>> That doesn't seem like the right thing; if it *is* the right
>>> thing then it should be a separate patch with a commit message
>>> that explains why we do it; and we would probably want to
>>> audit all the other uses of plain migrate_add_blocker() and/or
>>> change that function's name or API...
>>
>> Yup, my bad. I will revert this hunk.
> 
> With that,
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

I just sent V3.  The only change is the revert.

- Steve



