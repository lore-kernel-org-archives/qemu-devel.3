Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D9DC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 19:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMXEZ-0003Oa-LI; Tue, 03 Jun 2025 15:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uMXEW-0003NO-4V
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 15:23:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uMXEN-0002Qf-Ma
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 15:23:35 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553HY2ij025747;
 Tue, 3 Jun 2025 19:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=GcZAHq77Ew/S23H85XrH/fdyUBWZXlLvVvNrJRbr2Vw=; b=
 bccnQny0aRnuUEfwXmDiTSyUVFuEftiVv5GiwbIO/zmilhLsb/eJuNY6vfWfK3m+
 5TxQE1UutiMJgDYjLCwWaLXAjUocRafk5NxJwtcP9ux9QFFXGPZzZZrMzOvSMlss
 qQ5EVYofvoWp9ocYAwbr5cT0wTz3fvgD+zLOSbmm9Qqwhz5QD9Ub7mrj5dDaBOhE
 XqRC0Ivv7u2XuPBer9IH4HPD58n9wht7/ptMiY5iPsnVKxqbguHlgZVjFGEnyPy9
 v3akbLKDB03Sg+EE8LOpqip58sKQPYBVgXzI3nmvtde/nqWiN6NDkIIbv47FxxHf
 x7EUBpX+cIyF6qcOY5GWtw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471gwhafxu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Jun 2025 19:23:16 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 553IvDRq040095; Tue, 3 Jun 2025 19:23:15 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46yr7a36jg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Jun 2025 19:23:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/hmwY1cUkW0tyP8++bORiA5UtPpedcB9dZCIKFOsGO9bociM0Fa/Fa6PPEjZkLfvB9GFl+C4HMtCL7pyN4ZY5UWq657xZiSA0bgXqK+Nrq3s4OZD750K6sX+ey9heImsbKIBLICdVnYbXlhqwD8zR7jJ5NI63VBA7e6KJuLXieLkgduvjxg9mfqQaFwBSdOQbcRNKCuzINmpgMNlan9X+Wcm6NlG8JnFmOu9GISzMxVcKIdCOXTRMI3cVN/gu0NcFG68ivgJ+BIGKiX+RDEO0QTNs1cKpJbN3lW1fqjKC5qPh7lDAog13bar9GDWtsgZ98wT0RP/V/tNyI1iMnH1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcZAHq77Ew/S23H85XrH/fdyUBWZXlLvVvNrJRbr2Vw=;
 b=Gwe8stEBaoGpaKiDei9OSskPTTQSLVCEmncL3alqVzp1FD4CvrCqFIPsyv6SxHoGITxAKT5oyEMEu9pS9pbit87rL6qFaoDHcO5RGh/8tL7FSwNrdNK6p9WIn1b6lINT1wDWVYqZN+NqRrXapCWWIs/mKsxPjzRpCuyL/q21L0QaDCKjMHucph6Z9lD9G6w9b75jXWiNPk8paRCNZGVBTfwnIirSU+YsiLm9fhH5rLAz3MHJoAQgVSpRfAe9xfRd00AL0JP7Xn7dsfM2kK0BIWP9WADc0xUUI53gTrsv4bS7mjTeImkDpqDWKGMQSJrZC/qnTKlh/MAFXS1NqNrBVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcZAHq77Ew/S23H85XrH/fdyUBWZXlLvVvNrJRbr2Vw=;
 b=pwd9PYa+QCZ0YG1ICsTjYBDdES1LgultlVnclUbo40t0vpWlFr2WVRUkBNf3UE9aGgJ5aXlEyGOggYHU0LmCnb5h1ZXpsFr/ufvx/49HW8HmC4gaPhdNH0OCKAWwu5KdKVw4IQFMDJydesyi7g6PTuwKU2hic7OrbWGIVdhdv2Q=
Received: from CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11)
 by IA4PR10MB8254.namprd10.prod.outlook.com (2603:10b6:208:568::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Tue, 3 Jun
 2025 19:23:12 +0000
Received: from CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc]) by CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc%4]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 19:23:12 +0000
Message-ID: <c75f4413-f7d1-448a-8b17-5caed88197ce@oracle.com>
Date: Tue, 3 Jun 2025 15:23:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] Support ACPI Control Method Sleep button
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, mst@redhat.com,
 anisinha@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, slp@redhat.com,
 eblake@redhat.com, armbru@redhat.com, miguel.luis@oracle.com
References: <20250528163545.2143-1-annie.li@oracle.com>
 <20250603141850.27d2daf0@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Annie Li <annie.li@oracle.com>
In-Reply-To: <20250603141850.27d2daf0@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0066.namprd05.prod.outlook.com
 (2603:10b6:a03:74::43) To CY8PR10MB6851.namprd10.prod.outlook.com
 (2603:10b6:930:9f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6851:EE_|IA4PR10MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: dccfe718-0bd7-4ee8-3729-08dda2d41486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0hqR0wrRkx0bjNmUjUxcy9xTlJRZVNmL0ZTb2pXMFBuSDlNbUFNcENCbEtx?=
 =?utf-8?B?TmdZS3c3WU1iWldYai83MEh5RE9yUHBBakFHd2VnVUI3VjdWOXh4VHF3T1du?=
 =?utf-8?B?QVM5bmVmbzg0N0JLUStZYmQ4Qmp1eXdwU0VVSXJqcExJZEtRQllVMTFRV2tE?=
 =?utf-8?B?OWdKN1NHNFlFTVk5Y1RBMk9Ddk40ZU10RUkrSjVmbVMwKzhkS3Eyb3E1ckF6?=
 =?utf-8?B?bGpDZ0dOVUFtMGswUDgyNVZ3S2x4S1dyL3Fpc1lyMjB0ejFMM08xZHNOM09P?=
 =?utf-8?B?U0pyQkNKcmlnS25sLzcxQ2VZeHdSYmEyQTR6dlVYYnJVQkdNWVB1ekRPd2pr?=
 =?utf-8?B?ZXJFWW85aEo2ZDR1eFZ0alB0Q1ZyaXI4dm0vZ2NRalVKVElXL2xHU3ZBbEF3?=
 =?utf-8?B?SStzaStmVXYyd01Zb0htcjBUWEJ3NnB3elVDZWtYczNaYjA1TmJoQWViQ2Rw?=
 =?utf-8?B?MGt5bFFkSE4rMlBKNzAzdGM4SXR5K0M0WjRkMS9xcU5RYWVmdkcwYnZJaW51?=
 =?utf-8?B?RWxWUWY2SjdnK2dYM2pZWmZncnNtNzBvU2pSd2Y4eHpZQXBWTTMxUG5sUXU4?=
 =?utf-8?B?Tkt0ZGo3Nk1OR1l2bnU1MlNxY2kwL2RPWXV4U1Z6NWJ1cUYxeHN5UWg0bndW?=
 =?utf-8?B?ZnZHV1dwV3c3TFY4R2pZSElYUHFZV1dwZmpvU1MyRnovajB3SmNvL2JKakxj?=
 =?utf-8?B?RmlmMGl4YWFudmRHS0xOTHBkZFRHQlR0eU9yZWZpUFY1Tk9jKzVKL3laYmpZ?=
 =?utf-8?B?Q2liSjJXOEZtQzhHL1ljS2dJNUJzS3BRUFY2WmloQ25pSUVVVjJYUEpMeVc5?=
 =?utf-8?B?NUxXZGxCVDJmSm9Ed3hxVU1Mcnpvd01reTBEK1ZKWk92ZkZsSlphRHFYNDcv?=
 =?utf-8?B?WlZSOTVvbnA4NUpEL2ZaYkYrd3FzeE9WREhINHNJT2JqV0V0ZWRjaTBqOEJw?=
 =?utf-8?B?MVFBWGpTdlRMbm5nSkhOOUN0dW5tNDcweWRNVzA2U0JTZkZOUWp1ZFhCdGJE?=
 =?utf-8?B?cnBCMTgrNEhXZk5jNVNERmpWd2hjT2NjSU1zZU1uRm5MUWhCZkJuQXVNWXRX?=
 =?utf-8?B?eVZZazNmcndWeVlCZFg1aER1NVlrdUluditSM0lqeXU3cUZrU1M5QTc0OWov?=
 =?utf-8?B?V1pwZGpEZisvN2d5MldSOUFOSENsSFk4WFQ1ckdqN0JyVWdVUlNuUmttc2Jw?=
 =?utf-8?B?dHhFeDJqSm5RYnZVcHBIUzY5eFNPNEFSK2M1SWVIMmlxUFpVZUtQU1lGRkRT?=
 =?utf-8?B?amU3N1pjVCtaYlUwRWQwK1BXVGJITVBpK2lrYy9wYVZQT1BYcjJnMDQ4a3BP?=
 =?utf-8?B?cW1iUzdQMTZyd1R2WVVhSUVmZnlWQkRrTEkzcTRrSGpnQ3pwekJMRmxwWFVL?=
 =?utf-8?B?RFZVM1hBcmhSdnNvcFc5aTZDaktjczJWaDFQdnJPQ0JIQkR4NDV6N0tHQ3V4?=
 =?utf-8?B?NjltcG9URWptemxSNmtiZmpvZjRVeTNUdzZuUmxlU2xxREttcFQ0djBGQkdT?=
 =?utf-8?B?bElkTmR0TGZIMTluL3plL1hNNDNBaGxSNW9Rb1V6b2Q0VUtpb3YxQUNWZnl4?=
 =?utf-8?B?dnF4RGVwQTJ6c3YxOU9Wdmg4RW9OWTh6N1UxYWRTRnhWSUNLUm5vbXkvQmV4?=
 =?utf-8?B?cHpGM2hBa3g2M3M1QU43SEF5RXR4UFBNL0M5K2ZYKzJUZFU5M3QvWjVlaS9h?=
 =?utf-8?B?STExd3U1czlCdmRaV2w0L25mcFBvbUZrVVdtajBvRlR2NmpuNXI4T2Vhd3h2?=
 =?utf-8?B?TGw0dEFxOXRlZEg0T1pCSDBkYk9WV1FDMFM3YUx1U3JkMHZGMkhhWUF0b05F?=
 =?utf-8?B?cmcwWU1MYk8wM1pqQnFMdmhGYzRiVTNCOG1MRzhyL0ppTmJhbHd6dG5OTDJB?=
 =?utf-8?Q?yrSU/TPWE7Psn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB6851.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU54Nk5WaitTVGUxYmxoeTFYUFNRL2FKZ2dXQkRYYzFaYW9sYm1YUzBQSXRD?=
 =?utf-8?B?T2VPUUV3VXhuL1NtQ1NJMm1PNDNnS2xDREFGVDNzWjAwRW5uTGFyRFc1M1dR?=
 =?utf-8?B?WW5OM2xPRDFVcmMybHZOREpHVktVQ21FZERTUkVSbkg1N1pVREhHRnZ4Y00x?=
 =?utf-8?B?dnhCcWY3bXBTQmk2V2NORzE0OHp5SFFKbkY5WGhPNUhnVXg4dW9sc2dzUHVW?=
 =?utf-8?B?dVFCK1ZwdVJtczdxQVVVMkk0eGE5MUtHZUt4VEFhMVFhdlh0Y3JYM2lkVUJj?=
 =?utf-8?B?YytRRGlZcjF6emdIbnU2d1Z4L1ZhY2VZMHFVMm9EMGFRK0o0TGUzdVVyZVpD?=
 =?utf-8?B?NWNqN2lrK2JwU2tUekFyYjVaU0JmT25HMmY1UzcyakFpS0Vpa3kxUXc2ZWdM?=
 =?utf-8?B?bzJOZ2ZiRXc0WGszeWxRNkYrTnpYekpEdUFUTENXRTRkZ3pwZm8vNURoV3RR?=
 =?utf-8?B?cGNRUGs3emlSb096N202M080SmE0cDMzU1p4V3Y0UllrN1lJMi94OGdFL2FH?=
 =?utf-8?B?aUtheklLUS84WldXWXBneHlmV0N3Tng2K1poTUN4eXYwUjdJaFhQcWF0cEhx?=
 =?utf-8?B?UWVsck9tczBtV3pYWGRNRVNzeVR4d0VsVjBxdWoweTNTMVJYV3dvTVZxY0pC?=
 =?utf-8?B?aW11V3ZYZDZqREdOdTJtMWVXcXZMaExWUTY2YTlHZXZpaFRWMUd1cDFhVWFD?=
 =?utf-8?B?aUZUQ2x1MXkxdlJUcGQ0cXgyaGpXaTNNY0YwQlhsYWFKNW9EN3gwWTNxbjVs?=
 =?utf-8?B?RklTeXdKU2ZtWHlWOXphakxjdHVFbzgwQVN2QTROTVV3NWZncFR1TEk3TS9R?=
 =?utf-8?B?TWxwTnNyalVLSU84dTdHaTlJVEhqTGhOYjdYMnZ3L2tLQU5vVU0yd1VIeS93?=
 =?utf-8?B?Y2I1NE5ybnZ4V1Q2a05NU3Z4TldUd1hOa052NXpsRUF0eWxDVklWcGhaVVF0?=
 =?utf-8?B?c3FORlZKQnh5dHA3MjdkN1BCVFlXaGpId2V5TEE2ZktmU3l6c3Y2WEFXaWo4?=
 =?utf-8?B?ZS9yOUZ4LzVnOGpIcmZ6Uk1adEFBVXgvM1lLYjhSaXNjNHRZdHllWlZqN00v?=
 =?utf-8?B?WUJxRGVkOWZMSytHc0lmUE5iaG8vZXJmRjZIdWtSTkhUNnppOWdXQUVvMmRX?=
 =?utf-8?B?WDVYbFd1ZWYvYXZrdGUxa1VFSjdKYzIxelhGTHZyVmZ4V2lFWjJXNmxxcHY1?=
 =?utf-8?B?cm0xOVpOYkVxcHVPdEMzakx4Y3luWUdsTDZ6WndzLzV3ODFDamlOaDhheXY4?=
 =?utf-8?B?MmJWUExISlBtSzFpc1RJNWQ3cXNjd0t4dTBTZEY0TG5GZkw4cXhWQWJ0Y3Uz?=
 =?utf-8?B?NEdxanIzeVEvNEE4RnBSOXRweXFMeUNrNlVVeTUvd0wvL2NhYzROSzJNdjY5?=
 =?utf-8?B?T3Q5U1NZRGNiQjl2d2tuMTU3YnRFeEdBK0dxWEcrODBaa2thOGlUbExvMGN4?=
 =?utf-8?B?RFBUbW5TVExTM0l1VXp5NDNZZlcyMU9MTkIwL0s5MlZ2MzliMk1sK0hxMUl0?=
 =?utf-8?B?QWYrWENoWERLRUNwTHN2WC9wU3FzLzNrTTdPK0xkWWlmNFkrdE85enN3VEZa?=
 =?utf-8?B?V0NrVDZVOEpBQTFIdjcrRjVId1F1VzFnc3BSUnFnK3RTbzBYVE9aUDZvZkpK?=
 =?utf-8?B?RS85b0NqS0IrTkt2TzlzQzhNNm9OQ0cwV3JOWDl1b0hjSWJROUpUclQrUmpr?=
 =?utf-8?B?cmpTVUhFSHdzaEZOa0pCRG12OWJPMGlBb0ZYRDZGZmkvcHdlNEZXRlNqSStQ?=
 =?utf-8?B?MWVrZFdxa3hOTVlha0xQcW80dSthZTA5S1d4VHdZbS8wbU83dlFURjZPL2wy?=
 =?utf-8?B?Y0pGM3dkSU0vZDBmQ08xdW10WTZHalFhUnh6WTlVMGI0MHpFZ3UySnpwdEFm?=
 =?utf-8?B?U3JGTEc3MzZhazFJUUV4cGlvV0p1bFhmZU5YTkt3dFV5OGZWbGhoN1Y2a1ls?=
 =?utf-8?B?TzhIZXB3L3c1Qk1KbUdGSmw2LzFReTJQTXRGY01uQWhZK3RNbWFKR2gvdFVS?=
 =?utf-8?B?TnNabi96NlphQXIrR2xlRXp6blRWcEpPRk82bFRmRWh2Q2trTGVaRXMxd1ZY?=
 =?utf-8?B?MGNpM1dONVozSGNnOEpteFJ5MVJxcGdCU01NdWZuMmg4TGRCaEx0QngvTWpU?=
 =?utf-8?Q?nOMKthoWv33Fn3gT6d80VSorP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OjxllnEQtYlgWLAsjuBhvvz56vcTm0tciZZd+rRA/WGALmomOBwnuW/WWhycO04VHvr6vMGy4d6kW0tXMbMJohlxmDraAkOk/4gzRMiZUGtCAPC4RNmtMTwZ8N+tAy1chSmvmN3H38y04MvhENNG5no3YETQIb/gzAkMhJZIk2wicXhfqurTTxLYFHugZy6ohWMKKWHFG900YYu2E0onedU3FprMY9Nt0HgTsgjAgs8RZVKGJg7i7Dn2lTj4zh7mOOKEuHTxT3LNd2/60E9SQBNBK4VqumgGFe02qRhQ0oTZMM8YKLdqTLkEfYQt9+Mjs1NobtoCYxGnhwHwJpVb+Au7FeK9evwWTE7JXmXg5jNbtDbdH0e4rHZDGTAIokzMmbw18mCBcuRUAvcYD0PzgDPTXneljk/yW2m+tB/eWvaZCy688BaiNGUQIIfvSn9eEcuKxMJAo6MOM4OY7lazqRjnF0hne3tf7c03TjFxxKvwy5gEuZErBIXR7FdX1UpB+O36Lv2HIaH7zuHoa1X5ouLyA7Fx+UQzlSCggdAzOPq+JglK2olwIGwnxhgXixQZ5IMo1W48GPzXV3GGjFPGYDruAiXu6kkGfuOQc0YjNl4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dccfe718-0bd7-4ee8-3729-08dda2d41486
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 19:23:12.2200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwLXR+Jx/Sj2dEgBF0cN5ocpd5Y72cGT1JiqMMPBIiNIjWjC2LGxgA1fHJ24zYvlhqyziZ+JVQNZ2zve4ZkV9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8254
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_02,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506030168
X-Authority-Analysis: v=2.4 cv=Wu0rMcfv c=1 sm=1 tr=0 ts=683f4ba4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=mDV3o1hIAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=VkubL_mXK-bLHcqT-GEA:9 a=QEXdDO2ut3YA:10
 a=WPp7wK2zvv8A:10 cc=ntf awl=host:13206
X-Proofpoint-GUID: LkRmco9QEh95bmiurhkzbTLA5UqQmUke
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDE2NyBTYWx0ZWRfXyMrbh/RKEIcF
 Nr9SpIY4PeQi3Nthuwmt4cjcKE9+mrJdjG8g1gYNdBhDkD8e6ffF4JNO6iTrYJmeP77UM+7uKN0
 NoiA27ykhQL4/0sUP4hKqO7tUZpb3tf/dfq/L9ORk/4iTWymgji/GRWQZxPSJ4CwkrGL6Swstrv
 6Sw8RpdpeiTOmIkM6xD/6MRQWjtNetElzIBH1L0l/RcD468i9pq8QZ1GrJvuUaInxX58HhzkNJq
 ZPoUK+hM/vcnKhIv/+AqQ03IR+uom4z6mBqqojL0NDBH4wqz9Q3DDhX59cvZruqkcwrjr3QBSK6
 mzCbKAE3BhuXtfhi2BDErO8NratTmdJh3yt/U3u8dQX22bQl4lWo6XPQWrJJw6UDyB8otVZZDoG
 aGBK6IjmSRZgAsYLIwK7i7S0jQXfQVf2jeZ2wlYvayxg60mCJQYuAwD/z0Er5rIVjSm1x23Z
X-Proofpoint-ORIG-GUID: LkRmco9QEh95bmiurhkzbTLA5UqQmUke
Received-SPF: pass client-ip=205.220.165.32; envelope-from=annie.li@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Igor,

On 6/3/2025 8:18 AM, Igor Mammedov wrote:
> On Wed, 28 May 2025 12:35:45 -0400
> Annie Li <annie.li@oracle.com> wrote:
>
>> The ACPI sleep button can be implemented as a fixed hardware button
>> or Control Method Sleep button.
>>
>> The patch of implementing a fixed hardware sleep button was posted
>> here 1). More discussions can be found here 2). Essentially, the
>> discussion mainly focuses on whether the sleep button is implemented
>> as a fixed hardware button or Control Method Sleep button. The latter
>> benefits various architectures since the code can be shared among
>> them.
>>
>> This patch set implements Control Method Sleep button for both x86
>> and microvm. The RFC V1 patch set was posted previously here 3). We
>> rebase all the patches on QEMU9.1.0 and re-post RFC V2 here 4). The
>> RFC V3 patch is based on QEMU 10.0.0-rc3 at 5). This patch set here
>> is rebased on QEMU 10.0.1. The sleep button support for microvm is
>> added, however, its support for ARM platform in V2 is removed due to
>> lower interests of it and more efforts in the firmware.
> here we probably need a pointer to these efforts, or some kind of description
> about what's wrong with ARM/firmare
will add more details.
>
>> For x86, a sleep button GPE event handler is implemented, so a GPE
>> event is triggered to indicate the OSPM the sleep button is pressed.
>> Tests have been done for Linux guest, and Windows Server guest,
>> this sleep button works as expected.
>>
>> For microvm, a GED event is triggered to notify the OSPM. This GED
>> event is also applicable for ARM platform, as mentioned earlier, the
>> implementation for ARM platform has been removed since RFC V3 patch
>> set. Tests have been run for Linux microvm guests.
>
>> System_wakeup doesn't work for microvm for now due to the missing
>> support of it. This patch set only covers system_sleep, not the
>> wakeup part.
> ditto (aka what's wrong with wakeup)

See the details in patch 12.

Thanks

Annie

>
>> 1) https://urldefense.com/v3/__https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06478.html__;!!ACWV5N9M2RV99hQ!NOUIn6Z6j3yl9_QWhIIz2b2X6I8pLEHf1biRwOvcRv2_K6VTcVq2KGJmuUE7rcF1VuVjTtLPBvCHid0$
>> 2) https://urldefense.com/v3/__https://lore.kernel.org/all/20210920095316.2dd133be@redhat.com/T/*mfe24f89778020deeacfe45083f3eea3cf9f55961__;Iw!!ACWV5N9M2RV99hQ!NOUIn6Z6j3yl9_QWhIIz2b2X6I8pLEHf1biRwOvcRv2_K6VTcVq2KGJmuUE7rcF1VuVjTtLP4wjsOfs$
>> 3) https://urldefense.com/v3/__https://lore.kernel.org/all/20231205002143.562-1-annie.li@oracle.com/T/__;!!ACWV5N9M2RV99hQ!NOUIn6Z6j3yl9_QWhIIz2b2X6I8pLEHf1biRwOvcRv2_K6VTcVq2KGJmuUE7rcF1VuVjTtLPVmyXvjo$
>> 4) https://urldefense.com/v3/__https://patchwork.kernel.org/project/qemu-devel/cover/20240927183906.1248-1-annie.li@oracle.com/__;!!ACWV5N9M2RV99hQ!NOUIn6Z6j3yl9_QWhIIz2b2X6I8pLEHf1biRwOvcRv2_K6VTcVq2KGJmuUE7rcF1VuVjTtLPuuktbj8$
>> 5) https://urldefense.com/v3/__https://lore.kernel.org/all/20250411201912.2872-1-annie.li@oracle.com/__;!!ACWV5N9M2RV99hQ!NOUIn6Z6j3yl9_QWhIIz2b2X6I8pLEHf1biRwOvcRv2_K6VTcVq2KGJmuUE7rcF1VuVjTtLP7brAOZg$
>>
>> ----Changes from RFC V3----
>> Improve source code and comment based on comments on RFC V3
>> ---------------------------
>>
>> Annie Li (12):
>>    acpi: Implement control method sleep button
>>    test/acpi: allow DSDT table changes for x86 platform
>>    acpi: Support Control Method sleep button for x86
>>    tests/qtest/bios-table-tests: Update ACPI table binaries for x86
>>    acpi: Send the GPE event of sleep for x86
>>    test/acpi: allow DSDT table changes for microvm
>>    microvm: Add ACPI Control Method Sleep Button
>>    microvm: enable sleep GED event
>>    tests/qtest/bios-table-tests: Update ACPI table binaries for microvm
>>    microvm: suspend the system as requested
>>    microvm: enable suspend
>>    acpi: hmp/qmp: Add hmp/qmp support for system_sleep
>>
>> Miguel Luis (1):
>>    hw/acpi: Add ACPI GED support for the sleep event
>>
>>   hmp-commands.hx                               |  14 +++++++
>>   hw/acpi/control_method_device.c               |  38 ++++++++++++++++++
>>   hw/acpi/core.c                                |  12 ++++++
>>   hw/acpi/generic_event_device.c                |  12 ++++++
>>   hw/acpi/meson.build                           |   1 +
>>   hw/core/machine-hmp-cmds.c                    |   5 +++
>>   hw/core/machine-qmp-cmds.c                    |  11 +++++
>>   hw/i386/acpi-build.c                          |  24 ++++++++++-
>>   hw/i386/acpi-microvm.c                        |  13 +++++-
>>   hw/i386/microvm.c                             |   4 +-
>>   include/hw/acpi/acpi.h                        |   1 +
>>   include/hw/acpi/acpi_dev_interface.h          |   1 +
>>   include/hw/acpi/control_method_device.h       |  21 ++++++++++
>>   include/hw/acpi/generic_event_device.h        |   2 +
>>   include/monitor/hmp.h                         |   1 +
>>   qapi/machine.json                             |  20 +++++++++
>>   qapi/pragma.json                              |   1 +
>>   tests/data/acpi/x86/microvm/DSDT              | Bin 365 -> 442 bytes
>>   tests/data/acpi/x86/microvm/DSDT.ioapic2      | Bin 365 -> 442 bytes
>>   tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 3023 -> 3100 bytes
>>   tests/data/acpi/x86/microvm/DSDT.rtc          | Bin 404 -> 481 bytes
>>   tests/data/acpi/x86/microvm/DSDT.usb          | Bin 414 -> 491 bytes
>>   tests/data/acpi/x86/pc/DSDT                   | Bin 8611 -> 8721 bytes
>>   tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8522 -> 8632 bytes
>>   tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9936 -> 10046 bytes
>>   tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15482 -> 15592 bytes
>>   tests/data/acpi/x86/pc/DSDT.cphp              | Bin 9075 -> 9185 bytes
>>   tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10265 -> 10375 bytes
>>   tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8562 -> 8672 bytes
>>   tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5100 -> 5210 bytes
>>   tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8683 -> 8793 bytes
>>   tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9970 -> 10080 bytes
>>   tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8469 -> 8579 bytes
>>   tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8617 -> 8727 bytes
>>   tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12404 -> 12514 bytes
>>   tests/data/acpi/x86/q35/DSDT                  | Bin 8440 -> 8550 bytes
>>   tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8457 -> 8567 bytes
>>   tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9765 -> 9875 bytes
>>   .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 12650 -> 12760 bytes
>>   .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8719 -> 8829 bytes
>>   tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8486 -> 8596 bytes
>>   tests/data/acpi/x86/q35/DSDT.bridge           | Bin 12053 -> 12163 bytes
>>   tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12998 -> 13108 bytes
>>   tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33855 -> 33965 bytes
>>   tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8904 -> 9014 bytes
>>   tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13231 -> 13341 bytes
>>   tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10094 -> 10204 bytes
>>   tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8515 -> 8625 bytes
>>   tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8528 -> 8638 bytes
>>   tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8457 -> 8567 bytes
>>   tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9799 -> 9909 bytes
>>   tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9570 -> 9680 bytes
>>   tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13293 -> 13403 bytes
>>   tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8302 -> 8412 bytes
>>   tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8298 -> 8408 bytes
>>   tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8446 -> 8556 bytes
>>   tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8541 -> 8651 bytes
>>   tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12998 -> 13108 bytes
>>   tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33855 -> 33965 bytes
>>   tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 9046 -> 9156 bytes
>>   tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 9072 -> 9182 bytes
>>   tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18674 -> 18784 bytes
>>   tests/data/acpi/x86/q35/DSDT.viot             | Bin 14697 -> 14807 bytes
>>   tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35803 -> 35913 bytes
>>   64 files changed, 178 insertions(+), 3 deletions(-)
>>   create mode 100644 hw/acpi/control_method_device.c
>>   create mode 100644 include/hw/acpi/control_method_device.h
>>

