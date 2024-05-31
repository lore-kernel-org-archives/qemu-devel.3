Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B352CC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 19:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD7zP-0002Pl-P5; Fri, 31 May 2024 15:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sD7zO-0002PI-5l
 for qemu-devel@nongnu.org; Fri, 31 May 2024 15:32:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sD7zA-0008QZ-BG
 for qemu-devel@nongnu.org; Fri, 31 May 2024 15:32:33 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44VI4hEt019209; Fri, 31 May 2024 19:32:13 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Doracle.com; _h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DlMn22MOW5NDUTm1SBuYc5bAe53Y5QlW3EUqBSjKvDfY=3D;_b?=
 =?UTF-8?Q?=3DNyl1IFm1NzBrs+1XHaOGEjgbTjNzQjam5iBIVi8IU0a1i2AeWqrFeaEauPR2?=
 =?UTF-8?Q?YGej3ELj_LIJRVmMcPt+AUu3Gz1JCGxeCBNEBDsXHYEm8zwjqKlwkCE3kJ5La8J?=
 =?UTF-8?Q?jEH5lzcdM0nr8z_qMb/0q8ZmqqYVFMWlyLWCUI/dianKynP+56QCFruk0swxrp5?=
 =?UTF-8?Q?pYfO2hWwNpSYj3CFD8S8_riWMWCSfGJaI09QNSi4JTjzcDuYKjyhuhXCcZ1ukD7?=
 =?UTF-8?Q?fymlUv07BUQq5tVw3Pr8T5t0Eh_lPkX8OOFn7kD/qc74XArR0QtFk4s6XMM3Kz6?=
 =?UTF-8?Q?XykSR9HWvQT+Lks2vA93WVIstnyMe9Hu_nw=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8fckw7j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 May 2024 19:32:13 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44VHkFwG026532; Fri, 31 May 2024 19:32:12 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3yc50a98q3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 May 2024 19:32:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pwwz/im4/f3v4EPbRMprIdXBAPS46fkZF5xNa9ZVRczusK1XMSCEoZKloFoblxRPXLfFDzt4t7A4WWCQDpZqIJmoaiMw+64omM2dtL7LYlbl4qRRmoQf56EvhwWKIaud+Wdn9avEs3465DvVctTlC4JP8up6i8ZoO/0PGZRzeMoqi39wn+rjXN6ICTfHwIcvd9wRiig5togD//4+swlsIDvVMC1ErE3xbe3tnXx2oMFnmdFFsCJ6FENY4+ckDBgvx/qk8WdAiHrfnxPhOYZqkhVvZHNCpZeg32ETL1fJxTW0hTxXNLSDA2H3jxy/Yx7wfXOCvelf1nkofBEJhXce9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMn22MOW5NDUTm1SBuYc5bAe53Y5QlW3EUqBSjKvDfY=;
 b=mfdWDf/pkF+PQGyq0SyuBNg2ngA1P4ilrn/9XKSZ01f3a8rn1xm0+o8G4lLoUeNQuTGyVU7t3aOStfC4bJzWlsLmxTJH2C4Qqo5xBxnAdWJ/8Ca7BXT/KrVpbO5PIL1mlMhL1Qx5mA1fFBb+Qpsbc2R5Cq6mIaSDBQ5faWRT7R+7lW+wry6xg3NjosnJCH5/AIkwLKGNvM95Rc+1927YS6WhMwVOtMpdbbhfoWgV0UQfa70jay/4dkeZa4uc0gYZNM3hajWbq5dR3sDLfhZA5/JkEjzdE/f9sD6g3Hq8efz+HHM+OfLyfxVhF2SVRqcfhby+L1PM17t2ZBwqqw+YuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMn22MOW5NDUTm1SBuYc5bAe53Y5QlW3EUqBSjKvDfY=;
 b=rv0TCh2Ftc1vzZSHS/nh5qIoyb8+NzpSM8VEqYtfBYioR1jyLzot/S9IOW5xhPNzCJasC4FtKRxBebzkexJsQR+yxnAP7Ezua5HcQy7Pc3At1GaTEuuwOCZkZ5v/ZK3vr2RvfV7xirnr22gfwCOszPms/FHrAKTAsg4JSthUbPM=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ0PR10MB5836.namprd10.prod.outlook.com (2603:10b6:a03:3ed::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Fri, 31 May
 2024 19:32:09 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%5]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 19:32:09 +0000
Message-ID: <e6d5f123-37ad-4d77-8536-f7f85213073d@oracle.com>
Date: Fri, 31 May 2024 15:32:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 17/26] machine: memfd-alloc option
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-18-git-send-email-steven.sistare@oracle.com>
 <ZlZIoiH5Dj4XBbLO@x1n> <79a8023d-2e19-4d80-821d-a03818a5372e@oracle.com>
 <Zld-iWfa3_yEWgn6@x1n> <ea8eb67e-583d-41cd-a545-ab18c032a99b@oracle.com>
 <ZljCHgwJhGcFiP1J@x1n>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <ZljCHgwJhGcFiP1J@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0168.namprd03.prod.outlook.com
 (2603:10b6:208:32f::6) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ0PR10MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ff0c35-1221-4949-310c-08dc81a85ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TG9POUMzaDd0cldRKzNtWUMzOElXaEpOR3JVRFB5bzQ1K0NzUXg5a3g5Ry83?=
 =?utf-8?B?UE1JaGNRSW5WVzZhY0FFazN0RXQzQ0hPWWliTzJLcElpWHdKSWhtWkdxOTRF?=
 =?utf-8?B?TlNDbjhIT1pDMlA2VnJybDNBYWdKaG4ycnZ3Ly81azQrT2YvNEYrVHh4c0Mw?=
 =?utf-8?B?M3kyZGpkWSt4Mlh1aDIvS3VLY2tRL05YOXJZOGhCL0JTK0JqTkh2VmNsZ3Np?=
 =?utf-8?B?NmpqdStFSXI4TmFMZ2xXbEhZK3Y1bjc3Mk5YT2tVa2MxK3ZlU3FrOGRQQURo?=
 =?utf-8?B?amxUY0dGWkZzcHEwWENMemg1R1hNYXNPMXpsZEZMM0lkZ3hLbkxjWnJPWEhM?=
 =?utf-8?B?Uml3VkpkUWZON1JqdW10L05aeHZKTjhPVXV0U1NrUW1mNHBKYm5yaXozTncx?=
 =?utf-8?B?elBtcWcxK2gxWnVaemUrWTc1OUlpVnhNL1YvR3dmd0JGMy9XVWo4WmtYeTJT?=
 =?utf-8?B?Qk9vWEdDYkM2K0VsYVRETEk3ZlF4RlY4cndKeGd1aU1kd2dXMktKOUJnUXB0?=
 =?utf-8?B?TDh6NWVqaStja2hma1dKY29GOEN1bHlEWE5WSjVxY2dkNVMxL3Z6TFoyUG1L?=
 =?utf-8?B?Q0lPR3lFR1E1Zjl3RmtKVzZWVVNnaVR6TTF4cS9aek5sejJNYjBuTEtuV2pn?=
 =?utf-8?B?TDhiZlhUc3FpYjBEb3ZhNnVVYnFXUVVwcXJCZ0s4dlM3WHQvTU45dm1qa0xI?=
 =?utf-8?B?YUp4TnhiKytyaFNPamdTR3FxNXc5cVU2TUNOc0lWNnUwK0M2Vm5Fc3NuMjR4?=
 =?utf-8?B?N2RDZnhPb0tvMnh2a3VYOERic1l4VW9PVDhJS3N0U0l4S2F0ekcxNFM1eHVt?=
 =?utf-8?B?elV1LzNYLzNLUXFUdzk0ZUlWcndlcUN4VTZLcXJDZnJkY1JGUzhBeitEUTVY?=
 =?utf-8?B?WXl0bEVOL1I2R2R3L2oyVFlCS3hrZ0hvQVdUVEVlOVpjcGhmLzRwZHpnVlBk?=
 =?utf-8?B?bXFydjNwdGdhVDl4RlFRL3B0M2N4THFhbXdDMU42bkRvakNhSjg1dFo0ZUE4?=
 =?utf-8?B?YnhnRWRMWnFTN0s2TFZNZnBWeG5yMm1MRFZSYlFPM2tFMFRDNmpBZDlWQmFO?=
 =?utf-8?B?ZS9iYzBaSzUrNjM4eDBOaDRJZGN2eUs2S2ZnUXFsb2puVjdlY1hJQjlMRHJT?=
 =?utf-8?B?d0NkZmM4bEZEZEUvUXZiS1hyU3pQdkp4ZGFSNW1vakk5M2Vtc1BhRlAvVk56?=
 =?utf-8?B?Rlk3TzZKZXNmMUo5WVZZM0EwV0hoTXBQd3RxNVdvMHdTenUwRGVCMHNtYUNx?=
 =?utf-8?B?aGErNnlQYmhaUi9qYjBSY094MTV5VHBjYm0zUmZxL0x2SXRqUk1zRTlXVTdi?=
 =?utf-8?B?d3lPSEY4Q0VZNjFSbUdMWXBEYWVEYy9MWnlsQXdudm5pb0Fkb3A4TDlPTVU0?=
 =?utf-8?B?YndkU3o3UDZlMGJuaWoyd0x0dTQ5c0xXamRNMFB5MDZ6dGg1UitOZjBDd05E?=
 =?utf-8?B?bXJ1WjZ4NW9CNUh4OFVnMXAvTU96a2FFZEN3dVdOUTVPdUh2b1ErVUVnTTBD?=
 =?utf-8?B?d01HeXBPd01lRjBaWWRMRU9pc3dqUVZvbm9FSWx0cUpieVgwWkdxV0UrQUFE?=
 =?utf-8?B?Z2pmK2VjQjdxaGVPa2FDN2pzenFYMUpLcTRHN09yRUtRUUVFMjJ3dy9LUXNQ?=
 =?utf-8?B?aHlwZVVhM0tSV1RIeDZHelUzYzFvYmdyOVFVZFN5VTVZb2p4c1pRcTNCUWlD?=
 =?utf-8?B?a3lrUlhJZVBNUU40UlJjMTJENFRaQmhNTERNdXpuOXFFMVpSTmR1M1RBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzlwMmU3NGpGbnA3S1V0Rk04ckloSUoyTGoxWUtERHJLc1lQNU9EVzFqbk54?=
 =?utf-8?B?U1BNTUYxb3JiVzdpM3I5T0RLSFd1amtkUHB6SE1YbDZZVTFOQnZZdlZIZmxs?=
 =?utf-8?B?UjlzZUFHK2RXRCtXc3g1bnVGdVRxbmRsM3JSRFViSFVlU1pMcGRvNXliZndQ?=
 =?utf-8?B?dTlYY0taaG9rZktJWjhHZFJLenVaYVBPNXBIb0h6eVFBRDNnUlY4cFpsYS9T?=
 =?utf-8?B?bmttRU9FUHpMWlpVOVlYYWFxcFdRTTlLZ3pIUExpOHFxNTNUa09PSVNZMUpI?=
 =?utf-8?B?b0xNenVlWGVVTUxYcmtwZnVVeElQMTlXeENja0I1M0RlRFpycmlVbXV5ZlVw?=
 =?utf-8?B?Rml1dzM2aTFHZ2p6eGtiV1hxYStqRzVMOWxKcHBoRExISVl0NGpVbGhva3BF?=
 =?utf-8?B?ZlNONlRKOXFQWUNSMjB6TnZ5QVVFVXFQVGNtK2dqUUhxdFFoZmFyR0FDQ3V0?=
 =?utf-8?B?cDdFVWdYaTVKQjl4NWdBdDZSSnVLR1RnTkxiTUJUWWNlQzFFM3ZNOUh2V3BF?=
 =?utf-8?B?N1ZrV3RtYVdINzkyd0VTc3Z3NzJFYVNRWXk3S3dVMnYrampaLzdUbjYrdlB6?=
 =?utf-8?B?bjYrWWlmYy9mb0RRZXZZcjdsZGYwMnBycStUc1FrU2ErU2lDR3ZMRENYOGR0?=
 =?utf-8?B?c1JidlErQ3VrTWRaYU1nSmM3b05OZXJMaDU4VjZRaHR4NHZYdG1sRFJsa2Fz?=
 =?utf-8?B?aElFc3ZIMkh1dlRmMnBEb2lHbGVXcEhiTnMyczJyOUpTMzNJWjByZjhnVDdG?=
 =?utf-8?B?YVhOclA2enFBdjNEdFoyeFREUXloQTJaMUZmTENDaXQ2bUltQ3BreFBhc3Zz?=
 =?utf-8?B?QjRQNVVoVXZNbzR0TnBjU1cxTGpiVFEyRDJobUNiQTZuUlhWa29nR0VZcFlU?=
 =?utf-8?B?dW01em9HaVVPTTloaTQyUlErZk1uUWNNeUJiRVJzOHNnZlFWQmxFS0xUTzhZ?=
 =?utf-8?B?NVV0amtYVHNTaWpNNUYrdStqdTA2QW1nc2c2MWozTWxoZXh1Vzg5cUxsZHRQ?=
 =?utf-8?B?L3cyeFdKdWVydnpxM3o3S1VNUnBTMHMxY0xhSThrdll1NG1VMURRQUJqcVFF?=
 =?utf-8?B?b3hrS2czbXZGM0tYOHJlR2ZZajhPejcxZ3BNV2hMK2ltQVNOY3ZSQUR1RVh5?=
 =?utf-8?B?dEdrcDRjL2FIU0U0eGgyZEdlZStjWndhRnorQjJWdkNxTkdUaEVveEFMOXJa?=
 =?utf-8?B?UGh4THp2VGxMbVc0NXU1RjVhQmFoOUkrNWtHSXFZMWJDaVlac3BBWGk0Rmo3?=
 =?utf-8?B?YW94MDNQMHh1TDFPL0N3UHM2VEtmSUk1QXJ1TEp3REo4WnhrZDhtc0VMaDFU?=
 =?utf-8?B?QXd5bEJta0QxejU2SkdUUUJGTnRuMU9HNVJtMlpXdXlDaE9iUFNJZjFZYWow?=
 =?utf-8?B?WUpjbDBPUENLTXl3YnE5TzNPWGIzQmFkTjVPWFU0QW95NUpaTHNmcDBydHFi?=
 =?utf-8?B?RHRON0x6OVM0ZGYvME9aS1U4ZkJ1bW1hVEZNQzVvUHBQakVvb1lSc1BZNS9M?=
 =?utf-8?B?dFFIRGJQcVdDK01UZVo3dnkvcVBpeHMxUVoyOFRZQ0xTM1BXSHhWTEdhL1VL?=
 =?utf-8?B?OXRoQ1ozYTdCb1drUmk0MWFUR1BwOFovZW5LQXgxeXJhbVFheWRyZGg0WFhI?=
 =?utf-8?B?S3d2d1RFNDZHdktIdyt5QUE3TExhcVFuMEpXOFpJWXRIMEdSN3QzTmpWamJO?=
 =?utf-8?B?VXU0Qlc3M2kyWUxEOFJ3MkY3RnNGSXpDMXZ6bnlFV2V6RUkyWkxKM21xUEFT?=
 =?utf-8?B?QVpQRlQwNEgyUVg4c2NhYUJQaHk0WDFJRm5CbFZZblM4OEpkK2hlUGFLVVVv?=
 =?utf-8?B?Y0FZbnFYSXVBTkFOTFdtZDl1YmlmdC9yZlFzRmFnZ3A0MThhcEdvYWJ3Uko0?=
 =?utf-8?B?Sko0ZzRmend1bFE3aUx0dUNYVEo1QVkvRGkzWlNrWkZPVlJsUjduQytKMEdo?=
 =?utf-8?B?NzRGeEs2V0NNUTRpR2xVK0RUWHNXeXhtU29rOUJFY1V4V0thZldiU1pocW5O?=
 =?utf-8?B?UzJQOFBlQVJkVHlJQ2ZjOWlnNENVdjU1U1p4WWtOMzZ0MUE5WHNaWnI0cGV1?=
 =?utf-8?B?YnAya0FqZzVQS2o4eUVlZ2FGOHdPY1A2bitOMVNhNjVCcGp5Q2IwUHY5aTdq?=
 =?utf-8?B?SXVIdHJLeW81Skg4R2pjQnEwRDJZUnNCakNrQkJKNTBJQU5xYmkvRE9rbzdr?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: usskWrrKMmv69n2EuGWJVRXMg5fu1Veo6h4H1ZntA6m+B+27MgbLXY8bLWvV5hJh7a3k9rmrwkOAvQ9TT0iW6dBtP47DpX/FskS2iFvev1+uk6YmMIeRgMaWoJzRycvspW8vea7lMmbMWBpFxdQvDUdVyjLd+G12l+37gDx1w3/kM1Qh2a//qDKTGkfiQHXzbW8RmJAiCiDdr9K6sz0DV+cUOt4m6Cx/s4XpV1C4MKPPHxq25pUm2QFIodU8ClPmafTMIupMROvEjZQDZeZga2v38imHzdeVIHb3VtFBK+ddbSuI0tTei990vaB42eVUQs1vv+ZPbf8ovGQhF8nc4y9R2uHSD3rfpN0NEVrKGp/4r2U7qSz9cqEJhRDri7oDtdUTVdaZogW+Ib5z3tdzW0eyJiJ2rC3guBr6Dln9u7whijaCCvls1wnwQutyAbuDWcV1TSLL7vBFU2vfaoe39jAB3er9dYhSrRZjKe1DZbyP6fHbYjZAGR2gM2S+aq323nyoZd67HhhugXZOc/Tw5aQvzOtNmrfd3vcB4SnNpctRYvbxvMn7c0sFZg/4unADiF3RZAPQ486tWgZS5IXXNtaWJVO93F/tD//TRgHZSU0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ff0c35-1221-4949-310c-08dc81a85ccc
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 19:32:09.2499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gBw3Oyoj/13Qy6fa7ukb5ECMFfgdjesXhBB5l8/lTCyGo0KsXw/iYHmvRNllRm83rBrHL+jUf3s92Cwpsq6OdlkkRoBSi/pdTJsKzUVHLRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5836
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310148
X-Proofpoint-GUID: UNFsiWSXLCCPibgpIRzbnpRqbRKTr62d
X-Proofpoint-ORIG-GUID: UNFsiWSXLCCPibgpIRzbnpRqbRKTr62d
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Steven Sistare <steven.sistare@oracle.com>
From:  Steven Sistare via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/30/2024 2:14 PM, Peter Xu wrote:
> On Thu, May 30, 2024 at 01:11:09PM -0400, Steven Sistare wrote:
>> On 5/29/2024 3:14 PM, Peter Xu wrote:
>>> On Wed, May 29, 2024 at 01:31:38PM -0400, Steven Sistare wrote:
>>>>>> diff --git a/system/memory.c b/system/memory.c
>>>>>> index 49f1cb2..ca04a0e 100644
>>>>>> --- a/system/memory.c
>>>>>> +++ b/system/memory.c
>>>>>> @@ -1552,8 +1552,9 @@ bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
>>>>>>                                           uint64_t size,
>>>>>>                                           Error **errp)
>>>>>>     {
>>>>>> +    uint32_t flags = current_machine->memfd_alloc ? RAM_SHARED : 0;
>>>>>
>>>>> If there's a machine option to "use memfd for allocations", then it's
>>>>> shared mem... Hmm..
>>>>>
>>>>> It is a bit confusing to me in quite a few levels:
>>>>>
>>>>>      - Why memory allocation method will be defined by a machine property,
>>>>>        even if we have memory-backend-* which should cover everything?
>>>>
>>>> Some memory regions are implicitly created, and have no explicit representation
>>>> on the qemu command line.  memfd-alloc affects those.
>>>>
>>>> More generally, memfd-alloc affects all ramblock allocations that are
>>>> not explicitly represented by memory-backend object.  Thus the simple
>>>> command line "qemu -m 1G" does not explicitly describe an object, so it
>>>> goes through the anonymous allocation path, and is affected by memfd-alloc.
>>>
>>> Can we simply now allow "qemu -m 1G" to work for cpr-exec?
>>
>> I assume you meant "simply not allow".
>>
>> Yes, I could do that, but I would need to explicitly add code to exclude this
>> case, and add a blocker.  Right now it "just works" for all paths that lead to
>> ram_block_alloc_host, without any special logic at the memory-backend level.
>> And, I'm not convinced that simplifies the docs, as now I would need to tell
>> the user that "-m 1G" and similar constructions do not work with cpr.
>>
>> I can try to clarify the doc for -memfd-alloc as currently defined.
> 
> Why do we need to keep cpr working for existing qemu cmdlines?  We'll
> already need to add more new cmdline options already anyway, right?
> 
> cpr-reboot wasn't doing it, and that made sense to me, so that new features
> will require the user to opt-in for it, starting with changing its
> cmdlines.

I agree.  We need a new option to opt-in to cpr-friendly memory allocation, and I
am proposing -machine memfd-alloc. I am simply saying that I can try to do a better
job explaining the functionality in my proposed text for memfd-alloc, instead of
changing the functionality to exclude "-m 1G".  I believe excluding "-m 1G" is the
wrong approach, for the reasons I stated - messier implementation *and* documentation.

I am open to different syntax for opting in.

>>> AFAIU that's
>>> what we do with cpr-reboot: we ask the user to specify the right things to
>>> make other thing work.  Otherwise it won't.
>>>
>>>>
>>>> Internally, create_default_memdev does create a memory-backend object.
>>>> That is what my doc comment above refers to:
>>>>     Any associated memory-backend objects are created with share=on
>>>>
>>>> An explicit "qemu -object memory-backend-*" is not affected by memfd-alloc.
>>>>
>>>> The qapi comments in patch "migration: cpr-exec mode" attempt to say all that:
>>>>
>>>> +#     Memory backend objects must have the share=on attribute, and
>>>> +#     must be mmap'able in the new QEMU process.  For example,
>>>> +#     memory-backend-file is acceptable, but memory-backend-ram is
>>>> +#     not.
>>>> +#
>>>> +#     The VM must be started with the '-machine memfd-alloc=on'
>>>> +#     option.  This causes implicit ram blocks -- those not explicitly
>>>> +#     described by a memory-backend object -- to be allocated by
>>>> +#     mmap'ing a memfd.  Examples include VGA, ROM, and even guest
>>>> +#     RAM when it is specified without a memory-backend object.
>>>
>>> VGA is IIRC 16MB chunk, ROM is even smaller.  If the user specifies -object
>>> memory-backend-file,share=on propertly, these should be the only outliers?
>>>
>>> Are these important enough for the downtime?  Can we put them into the
>>> migrated image alongside with the rest device states?
>>
>> It's not about downtime.  vfio, vdpa, and iommufd pin all guest pages.
>> The pages must remain pinned during CPR to support ongoing DMA activity
>> which could target those pages (which we do not quiesce), and the same
>> physical pages must be used for the ramblocks in the new qemu process.
> 
> Ah ok, yes DMA can happen on the fly.
> 
> Guest mem is definitely the major DMA target and that can be covered by
> -object memory-backend-*,shared=on cmdlines.
> 
> ROM is definitely not a DMA target.  So is VGA ram a target for, perhaps,
> an assigned vGPU device?  Do we have a list of things that will need that?
> Can we make them work somehow by sharing them like guest mem?

The pass-through devices map and pin all memory accessible to the guest.
We cannot make exceptions based on our intuition of how the memory will
and will not be used.

Also, we cannot simply abandon the old pinned ramblocks, owned by an mm_struct
that will become a zombie.  We would actually need to write additional code
to call device ioctls to unmap the oddball ramblocks.  It is far cleaner
and more correct to preserve them all.

> It'll be a complete tragedy if we introduced this whole thing only because
> of some minority.  I want to understand whether there's any generic way to
> solve this problem rather than this magical machine property.  IMHO it's
> very not trivial to maintain.

The machine property is the generic way.

A single opt-in option to call memfd_create() is an elegant and effective solution.
The code is small and not hard to maintain.  This is the option patch.  Most of it
is the boiler plate that any option has, and the single code location that formerly
called qemu_anon_ram_alloc now optionally calls qemu_memfd_create:

   machine: memfd-alloc option             25 insertions(+), 28 deletions(-)

These patches are simply stylistic and modularity improvements for ramblock,
valuable in their own right, which allows the previous patch to be small and clean.

   physmem: ram_block_create               29 insertions(+), 21 deletions(-)
   physmem: hoist guest_memfd creation     48 insertions(+), 37 deletions(-)
   physmem: hoist host memory allocation   36 insertions(+), 44 deletions(-)
   physmem: set ram block idstr earlier    25 insertions(+), 28 deletions(-)

>>>>>      - Even if we have such a machine property, why setting "memfd" will
>>>>>        always imply shared?  why not private?  After all it's not called
>>>>>        "memfd-shared-alloc", and we can create private mappings using
>>>>>        e.g. memory-backend-memfd,share=off.
>>>>
>>>> There is no use case for memfd-alloc with share=off, so no point IMO in
>>>> making the option more verbose.
>>>
>>> Unfortunately this fact doesn't make the property easier to understand. :-( >
>>>> For cpr, the mapping with all its modifications must be visible to new
>>>> qemu when qemu mmaps it.
>>>
>>> So this might be the important part - do you mean migrating
>>> VGA/ROM/... small ramblocks won't work (besides any performance concerns)?
>>> Could you elaborate?
>>
>> Pinning.
>>
>>> Cpr-reboot already introduced lots of tricky knobs to QEMU.  We may need to
>>> restrict that specialty to minimal, making the interfacing as clear as
>>> possible, or (at least migration) maintainers will start to be soon scared
>>> and running away, if such proposal was not shot down.
>>>
>>> In short, I hope when we introduce new knobs for cpr, we shouldn't always
>>> keep cpr-* modes in mind, but consider whenever the user can use it without
>>> cpr-*.  I'm not sure whether it'll be always possible, but we should try.
>>
>> I agree in principle.  FWIW, I have tried to generalize the functionality needed
>> by cpr so it can be used in other ways: per-mode blockers, per-mode notifiers,
>> precreate vmstate, factory objects; to base it on migration internals with
>> minimal change (vmstate); and to make minimal changes in the migration control
>> paths.
> 
> Thanks.
> 
> For this one I think reusing -object interface (hopefully without
> introducing a knob) would be a great step if that can fully describe what
> cpr-exec is looking for.  E.g., when cpr-exec mode enabled it can sanity
> check the memory backends making sure all things satisfy its need, and fail
> migration otherwise upfront.

For '-object memory-backend-*', I can tell whether cpr is allowed or not
without additional knobs.  See the blocker patches for examples where cpr
is blocked.

The problem is the implicit ramblocks that currently call qemu_ram_alloc_internal.

- Steve

