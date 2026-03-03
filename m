Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995DAEC0487
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 10:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxMYd-0005RI-Vh; Tue, 03 Mar 2026 05:00:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vxMYR-0005Os-Bb
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:00:40 -0500
Received: from mail-westcentralusazon11013020.outbound.protection.outlook.com
 ([40.93.201.20] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vxMYK-0003It-Bb
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:00:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktUNSXQuvatx97vXRPF/IsLg96lT51m7a8xcfNHHPBzs2V2m9GfSQ72ruk2WrhbdBVvvmREA4tV7jssUz4wTKVlXEWlNxQmBzy3bDGX/A4nY+18jDNpvkEepUPKL/AIP6LqEUh+r27xcjvZYgN3Ym7xkkvM4PhqwpLzkTFstnJ9KutHyTcNPhz6Rnzbw8lSkhqrn060akhRfKamW+Bx1CePcWezhADfwHj12joytsk+tXdCxsCytDtx/Vvp5iVKIwVwU5lPrdnC1sZOLABnmqP2DS1yVHXi+n/z3XdSuYvakP6KXqP0UHSGZYlQwGas92LGSxTk3xFzC4dtHAYKKxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npZzrvEqZLHam54g1pR6zkxw7/ZPztu6pmeHPjvMQ8o=;
 b=iE/y2jfeRXCMujbpXZxhKGI9YpYnThm/XYpxMJxVgDxbE087bgLpBvv4TCSe7oB/KlN/Bm818iYZ2qTINdRmczw+sYiIS9+zj7Z3E6kbplYTl7MroPmXKU5af8LFFelJDkLREIo5P5oPoeiVqvNi2uFWqSQORug0zzPSyv6CHkuGUteYNsgnvy+cWCRke1zXrYMAqojaHU87nNhS2vqCwMbR0QqHBVUMqAiSVHfAFzbRa+iisGRtSFE3lnpA+f3fekwa3LbetuzZlYyik4IJp9iIK8g32LVx1tAX1DJvz4CsMEDXmJIbwHAcQnf7vQmrQMFeWv4UUJv/4iMFwKlM0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npZzrvEqZLHam54g1pR6zkxw7/ZPztu6pmeHPjvMQ8o=;
 b=aLX4E3QgdIa+0i+6nU9vQud58ustWWQ82LDlqz96E8gAiFqKUV9QxIJh9vNaN+NkvViD3GoLfoC59yNAkbo4ACcLoVA4pAWjxZwdVLyOopVzk3jWAmxho1fYvPms077JJBYfVzgdEPnK0u2meoPMf+HEOYuu/TGbOhYu2Ki5nfc=
Received: from BYAPR01CA0053.prod.exchangelabs.com (2603:10b6:a03:94::30) by
 SA1PR12MB7125.namprd12.prod.outlook.com (2603:10b6:806:29f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Tue, 3 Mar
 2026 09:55:24 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::b1) by BYAPR01CA0053.outlook.office365.com
 (2603:10b6:a03:94::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 09:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 09:55:23 +0000
Received: from [10.143.206.15] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Mar
 2026 03:55:20 -0600
Message-ID: <6bb7196c-3f0e-4164-ae3b-fd780c40c933@amd.com>
Date: Tue, 3 Mar 2026 15:25:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <eduardo@habkost.net>, 
 <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <clement.mathieu--drif@eviden.com>
Subject: Re: [PATCH v3 3/3] amd_iommu: Generate XT interrupts when xt support
 is enabled
Content-Language: en-US
To: Vasant Hegde <vasant.hegde@amd.com>, <qemu-devel@nongnu.org>
References: <20260302115130.5903-1-sarunkod@amd.com>
 <20260302115130.5903-4-sarunkod@amd.com>
 <2c022a3c-f0e0-42be-a946-760a6e938de5@amd.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <2c022a3c-f0e0-42be-a946-760a6e938de5@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|SA1PR12MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c8c8c3d-2a8c-4b31-b73e-08de790afd54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: p93KW5ppaj4iJvEH3CeuaeZ9JEuK8CelLiIfiUs2s2NPvL6XIwDbcGRbVlZXtu6A1ysbzZLXCBNHMSnYrVION3YJm1nDb0ukgKB8y/dOJ2TRXETTznPNeg0hB6CdtAvh7zUaCEPiXw5ahwhcpbzFjx/Ef0+C7bY66Sl0tLhtZSb+TQOcudmFtafSTGEdZYKdOjlYGJaKrBf2b7ILMQzio9WDgXqCu89T1RMBfLIbcMaZoCsOQQdA4EZWigeDJ9s0+T0hraw1rQSp+wIvLhmmDUhHN+qiXD8pHw7m1fgBB5L3iXNlPZQBgRf3qYdqBLj3bvUME1jIPQ8GKo6lsp4ykgMfcTNtHOnZ6FDkmkvm1h5OQr2oI88mGMZFaRGptr+cva2FUwvPPR9pRdzivjjodzxUV8zYTXiGeNRFHmNA19D4GfYsMZM/887mzv+pEbbPs6DZxiYe2JBA7QeQiYUKigwoRloMWNJH3kl9lOUK1OBPbJ6Yq0OxE9iTamH4EEi6t2kAvZzjmHG/CWXqIgXOJ4ZNAnQLRI5odSeddM2DLMPee8w9QVCUKo/q/jsrNyaeE9Sh4Y/OYiy13lsZNzJUQW32cJuuRy7MdvWa649fIAYDgHIvYYMG3XGTFOmYum5//PzvYFlKMGUzOfRg5pRfH7Cj5AeSNzJS4JKylOIXsDCiQiuEJTkkDfiVHNFd5ptVoelH2jzyYu56fPLmgYo7h0Kzc5zdDMB2w3piWO/J+az97ejR0FaquClCKy3J/DElIqYG7THlEiWm5j2ka4sh9hVtCy63aB0+zdYhdXayZ0kkhkraOIj/VOOE0bWjSzyQx+LTJl9bvC18gY20tJVydA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kPLAy8ZQAYUFHdITmkenu1+/HMGhI8/pVKDf3m5V8gyxqIPaGAkD1KcOhtPMW66UQvbcIaA5tMUSYxTK+Rhr90Xw/Vo5gtmijjGk6H+YKhCD/VCOs+bRDPjKtCcv1vPt0zr30zJhqoTLtpOY+IEa/6hO1lNcrt1+5EsSlgOedfJlo+B5W6KAqule6OwTt+ovEJrtgxjh+ruWZ404QNsQ9ryhgEZXZuPIHb8I1VQ+H07IMG1+sZdYWfGU3tlJ4bUWE8nseSqZyrqknaLRyAmsVz8M18/S7EDFabP1MlPIPClOaRgKMOVKzDZjPXcnWUhGUMvOR1Cn4oqZVbicegO2CaopjcVMMCc7dsM8dm1puhXu2gWrHZi1YxQP/bLSAblhRazimoX4pJ3Q2bR7HCboZmOL3NXtdb+CElaabf454H+wZeChvPQxAPAM1RJOt4UI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:55:23.8763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8c8c3d-2a8c-4b31-b73e-08de790afd54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7125
Received-SPF: permerror client-ip=40.93.201.20;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/3/2026 3:17 PM, Vasant Hegde wrote:
>
> On 3/2/2026 5:21 PM, Sairaj Kodilkar wrote:
>> When MMIO 0x18[IntCapXTEn]=1, interrupts originating from the IOMMU itself are
>> sent based on the programming in XT IOMMU Interrupt Control Registers in MMIO
>> 0x170-0x180 instead of the programming in the IOMMU's MSI capability registers.
>> The guest programs these registers with appropriate vector and destination
>> ID instead of writing to PCI MSI capability.
>>
>> Current AMD vIOMMU is capable of generating interrupts only through PCI
>> MSI capability and does not care about xt mode. Because of this AMD
>> vIOMMU cannot generate event log interrupts when the guest has enabled
>> xt mode.
>>
>> Introduce a new flag "intcapxten" which is set when guest writes control
>> register [IntCapXTEn] (bit 51) and use vector and destination field in
>> the XT MMIO register (0x170) to support XT mode.
>>
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>> Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> ---
>>   hw/i386/amd_iommu.c  | 47 ++++++++++++++++++++++++++++++++++++++------
>>   hw/i386/amd_iommu.h  | 17 ++++++++++++++++
>>   hw/i386/trace-events |  1 +
>>   3 files changed, 59 insertions(+), 6 deletions(-)
>>
> .../...
>
>>   
>>       /* update the flags depending on the control register */
>>       if (s->cmdbuf_enabled) {
>> @@ -1732,6 +1762,9 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
>>       case AMDVI_MMIO_STATUS:
>>           amdvi_mmio_reg_write(s, size, val, addr);
>>           break;
>> +    case AMDVI_MMIO_XT_GEN_INTR:
>> +        amdvi_mmio_reg_write(s, size, val, addr);
>> +        break;
>>       }
>>   }
>>   
>> @@ -2382,6 +2415,7 @@ static void amdvi_init(AMDVIState *s)
>>       s->enabled = false;
>>       s->cmdbuf_enabled = false;
>>       s->xten = false;
>> +    s->intcapxten = false;
>>   
>>       /* reset MMIO */
>>       memset(s->mmior, 0, AMDVI_MMIO_SIZE);
>> @@ -2452,6 +2486,7 @@ static const VMStateDescription vmstate_xt = {
>>          .minimum_version_id = 1,
>>          .fields = (VMStateField[]) {
>>              VMSTATE_BOOL(xten, AMDVIState),
>> +           VMSTATE_BOOL(intcapxten, AMDVIState),
> Do we need to increase the version no?

No, because we have introduced a separate subsection, the older and newer
qemu are compatible.

Thanks
Sairaj

