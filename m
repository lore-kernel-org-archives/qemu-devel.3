Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BB9C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 13:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYltZ-0005Mu-Up; Mon, 07 Jul 2025 09:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uYlfK-0001QX-J6
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 09:13:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uYlfF-0000li-VP
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 09:13:50 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567DBwYL006198;
 Mon, 7 Jul 2025 13:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Gl/+bB87YhindILx2VDVL7No2+XkHqtmMsN5dE1p3bg=; b=
 l41H+9lrVJ04qtlooROGjRwwqNhtiqcofdodfqH9gXo/GdfMYh13VqJRDo6eXVA6
 ge+PXiHab7hUQawyoAEdfp+rmS0IE0TIbpE/Q03Ohqcq9pjaMp9Y6YQC3VQotgn9
 1CzJFOxISTpCKH/r1tDZ0VxfkNIhJV7oIcs39JILKb3yHv4mCmTwT+88XKnjE2eM
 DcZrip9BXdXPTxYm2+Ufrrzlyd4fOcGLXx+nh/aFBjDhdWLMIlMWgY0Lldg+FOSE
 lUqMiO1HR246WU3/kc2zEQ5GTfjpmOS/arIu5PyBCCskZ26fYrYLE9PZ/K++f/wn
 IA9x8WqexOdqlsDFFwmXZw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47rewhg034-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Jul 2025 13:13:41 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 567BFp7s021609; Mon, 7 Jul 2025 13:13:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ptg87jvq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Jul 2025 13:13:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiwshAE5nEye5Fjrf4zxnXzyEahRww8073vyOefLXn5NZrOZI5xscv7YUGSn0MMJ6tu0/F9CnMj/f5lxz5HSFkhaD3M5epcLmTyShFpN229fB4sFvFdWRmvRVTkNgs66s+yZjuzLGEWTWPaXh+KZseWSztrglyHDtILsBXYMoUnawAcFQC94DosDP4QOHLYoG0nHGxvodvhlDeO2+R+eeuu331IaLLsG3GbMPBZgTLEYnb9rn5kXyItxtDR2mpqhe6lCYh7QYQEMT0IS+uWLJm+VEHDEl3Vbsoth3EZ/y4cxcmIZaPehlN3lbsmmu8sVAVMZkhPayAri3G9Mj8dAhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gl/+bB87YhindILx2VDVL7No2+XkHqtmMsN5dE1p3bg=;
 b=ccTUqR8Zbwc8CG6g8uNY+RYE+1aV6iDQjP7Iwx+4eTTB3dnCYT7i3hotTwIf/SouzX//EJIuGdBYGrJBtJFvekMUPeH6NKKNEBgDUrdYCR3BeKJBssG4xWbICKfVgpLW6eLPeT6UW0dyDcIUKvks9kv8F5rxPp+L3RtArNUbN7FsH0qjqIWWyrIULYkEy8Pxk58v5w4hBXFYHnI427JrUhPeMuBpEpJOUhOxMYeg89Kuwh1VE+rKfxZGC5wBObFWe6zBV2Mqt8OqWMcCukVo9bTDm0cfq7m+rD6AMwpuGyYpYgZ/QuPwFe9bWgdYO/Lyb/FHKDnbE6Og92I2XjIG7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gl/+bB87YhindILx2VDVL7No2+XkHqtmMsN5dE1p3bg=;
 b=jEMCpn/IX6aKyzKtoLuf8GwdPxRdXj+NgLs+ygKVAWByp6lCkEk0eHkX2WPLhctP2pjPsqNQCSmTOUt82UvimrBwP2bmkynJM43JKfVeoDzBHUnnDgOfeijVS5lzWDthIfDWtMLKhdgdboYvT/hvOELKj00E0nblSUexmLDL3fw=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CO6PR10MB5650.namprd10.prod.outlook.com (2603:10b6:303:14f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 13:13:35 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 13:13:35 +0000
Message-ID: <1ad4730d-5fc0-41fb-beb6-6ddcefda910d@oracle.com>
Date: Mon, 7 Jul 2025 09:13:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 20/38] migration: close kvm after cpr
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-21-git-send-email-steven.sistare@oracle.com>
 <9dfc0dae-f048-4d41-9b6e-02b6e7dbc215@oracle.com> <aGVYD1GkOC-LuI1T@x1.local>
 <a0487a01-41de-4997-860c-bc555a295643@oracle.com> <aGbd0IgvtiR4EkoH@x1.local>
 <d588c137-423a-4609-b5b5-66f6f135b12a@redhat.com> <aGb87SVQE6OzQMoT@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aGb87SVQE6OzQMoT@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR17CA0043.namprd17.prod.outlook.com
 (2603:10b6:510:323::9) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CO6PR10MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e8b5f6-bb66-4995-aae2-08ddbd58141b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1dqdU5jNTFOTEVtVVZ1ZjJFbmQ2L3BSUGN6djBaR1h4M2luS0hCU21xcWdF?=
 =?utf-8?B?cWwyb0tGNUhjbmJjcnc2UXNlcW5TdWpaM0NwUHZzRHZTeitTWWY3czJBWnYx?=
 =?utf-8?B?TGtlSUJhSkk0b3F2aUxwWVZMK1d2VlJvbFhnWUh1TnlKQU1VRVpsMWkya05v?=
 =?utf-8?B?NU1QKzB6Wk41ODBlbG1nSE9ZQmo4TlRYT25LYnlIaUVwci9oTWxMazR0a0R4?=
 =?utf-8?B?MkRtcDlHQ0hEb0hwSnpqdEM5R0xiUUYrRXNobUE4QkNlVmpwT2RibEQ3R3Jm?=
 =?utf-8?B?QnBLL2xqd2NnWVgzVWRjajJHeXRCVmtieTU5bTNFMDJvZlB4emJ4aDQvazA2?=
 =?utf-8?B?eWZoMVRza3lRbExhUzlydHdjOWp1Q2tPZ0t3aGFWZkE2R00rT2xwNUwyV3Ar?=
 =?utf-8?B?RzFQNko5UWFDejB4NHkvc0lTc05PNXROd29EcVg4YzB1aVVmY0dTVFNvWjJP?=
 =?utf-8?B?RlN0R3pkaFBTZkxRWUhZSWtMc1A2WFNwellHN2FsMG5jZzdIaCt0WS9TdFR3?=
 =?utf-8?B?WDZrdEFVdjNEaFROc29ZOGExM2xuYXJYelc0ZEcwMXdrNENBUytvVnUrQVVI?=
 =?utf-8?B?QTVvc0t3eURlUVNlTDZJeHUrUld0K0lWYTFsVHlMcXBycVZkandHbEVLNXRF?=
 =?utf-8?B?aktFVEVCamJYTWRPNDlZNE1YeHBwVkZLcWVpbWV4RWlHeHlRZS9Cek1STnFt?=
 =?utf-8?B?QlR1bVU4VmEvS213c2xSVFNVOVZKV2pUMDVIbmwyaUlFWjJCOEZINUNnNlFi?=
 =?utf-8?B?eHp2ZUJ0Rzd1WHNwUE9Id3huanF0YTI4N0d0SWhUUXlSY2M5b2dHZEErbmtP?=
 =?utf-8?B?Q2dmenM5TE1CaW9KZzVxa20vWDhHeEM0cStub1l3ZmVBRWVlWGRrU0w0cXk1?=
 =?utf-8?B?ditiZU84NER6QSt1bTVkenQ1Qk11aXBmZHViRzVBSHpLRTlwYkhHbXRjd2l6?=
 =?utf-8?B?bms5ejQ0NFFOUTlyK0JBNTdCczJ4Mm0wUXNPYnJKak9aTjNGSlAwVU5McGNX?=
 =?utf-8?B?d2dQdDlTWHoxa0Zxa3dIaEZhTzErWkc5cVNYblNyQUN3UDVBdGN3ME9rWUtj?=
 =?utf-8?B?MzNGZXNOSWpmVVhybXpJMSs0TEpYakJINTlIT2lmbWs2RDNJN1hRUzUwcWFE?=
 =?utf-8?B?eXgyTDVySDZrL25JS1FKbStPUDNSTUZNZ1JvZGVSWUluRXFqcDdDbDh1Mm1Y?=
 =?utf-8?B?cUIzZDBvazVlU05wZENiQjRRcTIxZGR6ZU1WOGxNMFBMaTFZdnAyem5OcHNP?=
 =?utf-8?B?NkUyamIrTjNlS0VseGNydWRZeE43S2VLSzdYQW5vR20rSHpXSGg0THBscGJI?=
 =?utf-8?B?MEpRNGc3S0VpcjNmUXhPZDRmeG5SRXVDUWFKUGJhZjcyVC9ySlZnclN5SE51?=
 =?utf-8?B?OEMwRUlqNjFyd3A0NGVjSjA2L2hvUDgrQnRVa3oyK0FFWkdwakxGQnU1c0Zs?=
 =?utf-8?B?WHJvcDJocTAzRnVzMlduNEtBckx4VFNNNHo3eWRyL1hoVUpSYVZRTjF1MWxC?=
 =?utf-8?B?enNSYmVvSkprVUllL1MvMHl4WHZiaGNlZkRqTlhUTjVSWmlyS05pdHQvWlA1?=
 =?utf-8?B?b0lyUkxWNW1zQllDdUlPdlVFKzJVRnZXKzJMc3E5YzVQeDdOMHR0V0J3TU8v?=
 =?utf-8?B?L2YyVWg5M1UvNVQ2NElkQWp0eVc5ZHFVYTNRdTZYcDd4TWl0ZTI0UTJYY3h2?=
 =?utf-8?B?VlZsUXBMaFJmYk1UN09pbk9SdkRtMUZIR1dQenowVXMyUGdpWklIcjBPNC9T?=
 =?utf-8?B?NGYvVnNKUkN6M2FJcENDM0pXVWpYQnRYZEx0YW9yR3dTNER6TmVFa1drQUJt?=
 =?utf-8?B?am9YV2VHZGx6Z2VBeE1aUVN6VEdSU2lYdUEyQXhaWFI0a21ERThqell2UGFl?=
 =?utf-8?B?VU1mdGJlUnJZVml3ai9uMGM4OXpPdk50ZnNsT1lyQzVaekxoMHR6RURmek9J?=
 =?utf-8?Q?nAt8u5nYkG8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTFLUW1TU3NldzhDVnlMc2tuRVZDRFp2dWZzbGRrdHdmRTJ4N1daWFdYYyt1?=
 =?utf-8?B?NmpPaHBxaStESFJBVTR6cmpwSE96a29WbGpjdWNsNXN6enNiSFlWbkVicGdq?=
 =?utf-8?B?R08waE1FZGJZSGE1NE4rYytLU3BHeUlMVlNTdmVHL2E5NkMrR2NtVmtFYTZH?=
 =?utf-8?B?azVrTEVHakJ1d2RacjcvM0xHZExySW5PZXlsQjd5NnhFQm03aytCV1drVC9j?=
 =?utf-8?B?amZqT3h6TnhnY2g5MWNoa3hGS1BTVU5ORHR5R3c5Q2lVdGxVUmNHMXlGV2U1?=
 =?utf-8?B?K241N3ZnakJwWWZ4UUtGZllWMjhTeEVxZStQU21lRWhVUXV5dTYvbHpvUWJh?=
 =?utf-8?B?L3RGQzZxMjl4b2QzbnNreVpjM015UzQ2Rjc4T3EzZldyZGZaK1c4aUY1N2N1?=
 =?utf-8?B?UEIzM2xRNy9EcTdZSTFTeHBNQ1kzVHZCcjV2K3R3VTFaZDVWaEx1Y2VTU0Er?=
 =?utf-8?B?L3BGcWFNcUNmU0R0MDM2WFFNak5QQWxGRTJ0blhWeFl5ekVldEZlZE5hNEFH?=
 =?utf-8?B?Q1E3Ylo5bGVqK2lLZjVMYzBCS080MmUyRWtFcHZGNFRaZHNuaVBCUUlHcGRm?=
 =?utf-8?B?Rzk0OFZnQ3MyZW9pZTR5VzU1Rm9NdUVRWFRyNWtyNjlieGxmK2pubkNRbEVX?=
 =?utf-8?B?YnYxS3FXaGpQeHRZcWNoUG1yZHBtdzhpd0M5cFhjN2JjOHZpSXUyL1NwRFd4?=
 =?utf-8?B?Ym9PdC9tTUpXRk5aaHV6K01LcVZCK3A2eGd2VWVyME1mYVlwS2tkKzdtVWhJ?=
 =?utf-8?B?SUsycjJUdVp2UjhJZzhKbzJObjg5Z29Kb0cwNTZXOG03OGdmTVdpU3hBdFZq?=
 =?utf-8?B?SkJKcXlmajBoTlQrZkxwcUZoQzBkZEQyZHZmay94dFJoZS9rTkhqS01yWTRy?=
 =?utf-8?B?S2dUY2NjdUVOZXArZVlhMGVqUklrRjg4M3NsZ1RKSXF3SElQZER5WE9tWTBx?=
 =?utf-8?B?MUwwdnNYZ3l5K1RzKzZUTWwrYnJwSWFuSmI3WnNKZTVxS1cwRDN0NERPS09t?=
 =?utf-8?B?dG5lU3RxUmhpWDUyYkd6aVFrdVdlZjBtSkZXK1NsU2JQVmFTUGxjMTgrUS9T?=
 =?utf-8?B?ZkpPL05RNUJwNExTSnQyRnhoY2FaelNGckpaUC96dDgyU25kN1IwWHFjWHFF?=
 =?utf-8?B?ZWltbXM3eldJUTl3eEZwNXpSUzY0RlZBMWl4Q2ZTZjNjekRoT3NlWWNOVGZI?=
 =?utf-8?B?a095NTh0Y1IyVXVORmlYcStFVlBkOTBLNVZwS0lqYTFvSDIzMHdHNjlZSllF?=
 =?utf-8?B?a0xINEJsV05JU0RJR1FRVVNpNUhoWTJXK243ckM2dktER20xbnNEYTBWc3VQ?=
 =?utf-8?B?Wi9mQXAwWjk3bjFvNk1tOGx5L0wyK3hWSFMyZnBSa2ZzS2RkVU5XOTNxNVNw?=
 =?utf-8?B?eFZhN2hUNDQ0cE9oUCsweGU4NTB5TjlqaEVKN2RpUmRiRUJmc3lOeExzRGZa?=
 =?utf-8?B?cC92TmtubXFlSW1OeE5WU3hYc2lJYzkvQVRhR211RTdsSU1kTy95ZUpMMnAr?=
 =?utf-8?B?VXZJaFpPMUJOWm1zckRqRjJqOHhncHAwZC9IZUg3L0paWlg3YllLR1E1SnVo?=
 =?utf-8?B?MUdKemowVVIvUEt5VWppZFhmTTdPWFZObkI4RWJXS2RncVFSbEdnZERlUUV0?=
 =?utf-8?B?VGRzUW82ZTk4MDR3ZWFCQW0vZWxHZ0h4TkdDZjdsNTVweFdGbno5QVFUWk1O?=
 =?utf-8?B?RHVKOUNrUFhNaFV2b1ZsbzZ2QmNRd2tKaUFFaCtLVW53V040TGdRYXhMRC9F?=
 =?utf-8?B?bnpna1ZWRm1Zc3RTM3g4NWgvMUppbmpTTitTZ0FNQ3dHNVdVdlZYQ1VPWW9H?=
 =?utf-8?B?UEJOOStHYTBBVmZheC8ya0RGV0NMWVNKWkJMN3BRL21Qam42ZEhhNVkzdU5w?=
 =?utf-8?B?UVBjMWFienkyK0lCYmJZZTQ1VEdoV2FsQzZYZ1hQb0ZJNjExbTQ0dmVJazBY?=
 =?utf-8?B?WWd5MGJqdkNjSkY5dXZOUkxja245UENmOW1VenJnYnNUT2ZLZEo5SVZiNFVX?=
 =?utf-8?B?V1ZiYVo0WVcwRkRWRjJTalI3eG1mYXM3UTFOb3JBZmxHRnFmaWx5VEhrcVR6?=
 =?utf-8?B?WVU3ejlJY2ZyTmUyS0MxVzdyWGxLM21tWUROdzgxM09jNUZqd3hXVmVTR3Vl?=
 =?utf-8?B?Yll1dXlxcG9pNmMvREhtMDExVkp6M0h3bEZNVktlOGJTTFljTGZPN1liZGFL?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VDxefwk7O60gUB/lRrmxeQJxjfkY6SqPCbToiJwFyp/Z+N5GP0eqJK01JFbQINrYTAyZm8TgjJsSuednjHenHwnjhnCwe1mzART8DhemSmb0688/EsUA7SnpabqGUaOGtNOfpXK8zc8+7XBOhNSAkvwBC35mLl6QFcghKVWFTxxmacxhcLhKR6tFTvjX4X474/GJ8U+Bg5q9Oqf43PG2H239XTV4X962B5AuFGn7xoGOjsLRnr8GaFi+WcdcYBOqLXc3B1Xe7fkudGpTSCEy7+IYhd/tMZMFOBOxP/jJdsEjf5HXN7QDqUdJlHASRBLyX72+Vh/nu5YI8xzy1mp6YKdRUjxk6LZqULYOysCYIP2YnGqTQUKFNC/0JTdckkeSzqvPx+NyCDZLqNsGUGHIm/k2vl9DT7nbU3SwUE/UYyvsoHrf3/ioG1oMazSU6zsYxpbJqjSxuuiMCC1w/sUCjdMEGfVAScXgUm1G9qjl2FPXPAs/Zk3YOnrCQq8hk3DSgj8OVcJq93ZcWs3Tw61aqnMw+C1vGPNIXXyTgZj5xHOSu3kB8f1xbcxQMxRHIH4kTxnXAKj1MalVaeytoJj9z9mmAxb69kYqk3RuqQ6RKUI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e8b5f6-bb66-4995-aae2-08ddbd58141b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 13:13:35.1031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXCgztwqC2LPc4kHdW/CBWOsK9A6AYhfB369Hq0dItDUftOkuubbFDo3VX6TiaSAUEcKoEdi9ecyLQQIGNozc/Z7FI4bB0QSYjXvZsmcezE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5650
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA3NyBTYWx0ZWRfX3UsAPju7yMDl
 oyhqCsI2SIUKa1agGa20lYNRd73D60Ave/WnDPj6lsjqbPLzo7JGrMLUkPqKEmwjpU48M89iYIb
 3AEguZAZ1XwH1spK2pZv3KK8/5BVgEc8xoiT39sS+/3gfnovX3GSLGqtfF3amJPYnYSgoCPHsp6
 qzAIIRxskgp3269nWjYtWEVJIzbm0SKk/9I48ujBD+do7r3harsgBG7olX2oamUjfX9Ky7AHkFe
 BHvzNcafFNNvY2hj2dXKJe2fj+jkzE4Zn3FLEIavAyD2oZGO5wFFPwlqfG0jK4UiRSJ5fELk7yi
 imrNT8NNFVfBu7Y5NFobY3+L2qctJKv5E45lfEfn7HkCS5X2Wz824O4Vx7SH3M+YNzrxmkO8hwn
 aoQOTaRYX4CbrqYxu/FhFGy00aP2BEYe+BSoP4TqrRvnZca7OQgpVTEvuHR99fpoL3vAtuYE
X-Authority-Analysis: v=2.4 cv=Fs4F/3rq c=1 sm=1 tr=0 ts=686bc805 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=BhmlwwOmEUXf5EYeX6UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9vKdKeL0uAR9k1D8BTxlkOelnNFaAMgI
X-Proofpoint-ORIG-GUID: 9vKdKeL0uAR9k1D8BTxlkOelnNFaAMgI
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 7/3/2025 5:58 PM, Peter Xu wrote:
> On Thu, Jul 03, 2025 at 11:21:38PM +0200, Cédric Le Goater wrote:
>> On 7/3/25 21:45, Peter Xu wrote:
>>> On Wed, Jul 02, 2025 at 03:41:08PM -0400, Steven Sistare wrote:
>>>> The irq producer is not closed, but it is detached from the kvm consumer.
>>>> It's eventfd is preserved in new QEMU, and interrupts that arrive during
>>>> transition are pended there.
>>>
>>> Ah I see, looks reasonable.
>>>
>>> So can I understand the core issue here is about the irq consumer /
>>> provider updates are atomic, meanwhile there's always the fallback paths
>>> ready, so before / after the update the irq won't get lost?
>>>
>>> E.g. in Post-Interrupt context of Intel's, the irte will be updated
>>> atomically for these VFIO irqs, so that either it'll keep using the fast
>>> path (provided by the irqbypass mechanism), or slow path (eventfd_signal),
>>> so it's free of any kind of race that irq could trigger?
>>>
>>> I saw that there's already a new version and Cedric queued it.  If possible
>>> add some explanation into commit message, either when repost, or when
>>> merge, would be nice, on explaning irq won't get lost.
>> yes.
>>
>> Steve, just resend the patch. I will update the vfio queue.
>> Or we can address that with a follow up patch before QEMU 10.1
>> is released.
> 
> I've just noticed maybe I was wrong that slow path was always present.
> We've closed the kvm so likely the slow path is gone..
> 
> So I think I misunderstood, and Steve likely meant the irq will be
> persisted in eventfd, which is still true if the irq eventfds are persisted
> and passed over (I didn't check the patchset, but I'm assuming this is the
> case).
> 
> Then I found, yes, indeed when irqfd is re-established on dest qemu, we
> have such tricky code:
> 
> kvm_irqfd_assign():
> 
> 	/*
> 	 * Check if there was an event already pending on the eventfd
> 	 * before we registered, and trigger it as if we didn't miss it.
> 	 */
> 	events = vfs_poll(fd_file(f), &irqfd->pt);
> 
> 	if (events & EPOLLIN)
> 		schedule_work(&irqfd->inject);
> 
> I've no idea whether it was intended to do this as the code was there since
> 2009, maybe this chunk of code is the core of why irq won't get lost for
> CPR.  But in all cases, it can be a pretty tricky spot to prove that cpr
> works and looks important piece of info.

Yes, this is the mechanism I rely on to preserve an interrupt pended to
the vfio eventfd.

- Steve

> Personally I'm ok doing it on top of what's queued.  Maybe such explanation
> on how it works should be put directly into docs/../cpr.rst?
> 
> Thanks,
> 


