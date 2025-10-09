Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA3DCCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rhW-00032l-RD; Thu, 09 Oct 2025 10:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v6rhS-00031p-3Q
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:32:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v6rhK-00036l-6j
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:32:57 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599EV0nb006348;
 Thu, 9 Oct 2025 14:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=UBwfNrVNOC1Y8paMSV2td+CMUiwbgGZI5gKlW7GhJvQ=; b=
 cOMMru8tn+ceCFxQylQHHXaPWU2SCT7reuXO9PSpLjqnvSndohYji1OmaSLqoV+a
 YDfSUiGVY3/5VV3EZwsFGepDOq5qppEYK9sa/l4SRKRlfE5ZcVdroHb6HgZJ9+fH
 h2CtzWb0yUOzbsg5glrC6+dsvDOV9JlKaeIH1T4efAJ+7nS1TXcb2VGf7MwOQeAy
 NAn2DJ0xqM7sOJ/MCcKiYkrxoPxNWG2reQ9cLXLpp3YAlgZ0CJOkyKOUjWOHBBlU
 x4DwhpN1ix0NrbwrW3HWZ4o6YZhAfP8jJRxY08GynVAl++arhfcgXwj9WO+omRZ1
 7yvmJSjn72VxU0pWu5v2xg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6d1ruj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Oct 2025 14:32:43 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 599EKRsD010279; Thu, 9 Oct 2025 14:32:42 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010034.outbound.protection.outlook.com
 [52.101.193.34])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49nv6705bw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Oct 2025 14:32:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sW7FTlKX13Zww4QDUAvYLHzH1LEtxIq8BoSgk1L9QeK2W3hWEbEDvuVVGg3HZRfKCUJgZZtPW/CU5LAeM1Fnikm012eTjGj/Usi3tMUHhR81RfIA9l1gr2+CfJiPiG+/m1+Lv8sPeVXhiClxH0fBDgTjbu4Ecwmbbt66NQYH/CvYX505F5xjaesx1i+u+1THnE69dChnGS3H37O19FEGRwGW3PR2qPMjYMNx71dq5xtN6NDEptnmcTSQtCkvWfem50Igdi3iExBwgO0qAjWmu6TBfmqoWWrNX+sEKkN1cr8VdOvJXiDbHL6nNERwprXcGspwyngGtzLN7n+20yVcMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBwfNrVNOC1Y8paMSV2td+CMUiwbgGZI5gKlW7GhJvQ=;
 b=HmxZBNcPeXbid7gTDH/kVnKZzsKFiHODKrCoMoV/v8kXm385a3lPwbAzd6inU2CjD5o8HPb4jYoRr5rXIhdUhh9F5Zw4PuJh/uPNWOQaNcTAnjGRhw+1/vnFMswjmLSrDY3Z/l6GDDpBOalC97yRQF0roS4MxWYtbjbqtsS/2e9DqI4BzDq7ROg+OaHHHDrEZMDUtQ56sVb6rxHDC8BAUi41pPGrLeEZc/GtRL3WyrzQcm065Ly/fXlvpTKINEp9RUKSKUQ5F/W1/tiA1pvsDEOT2HTI3RGBjSzYPULI8S+IQUdXB0XBPsTXjjCGqnbZ/eT/37/GM8PS0aSEMu7Bfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBwfNrVNOC1Y8paMSV2td+CMUiwbgGZI5gKlW7GhJvQ=;
 b=Ab77lR2wdww40nLJSXcAQQDS8LIr65Q7rX7bRI5OjS6K4Z6zw3duGyjwZ9+pRhPxaXDPNZ5IlHnh4tM1CQfy/7XTM1DRfXecrFcmPzk7iTUkZP4dOHcfb3phI62lGR3yD+1v9kfJPvjt8kEachhOWGBSSqUZ8Edv9U3KEg18AiA=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH3PR10MB7330.namprd10.prod.outlook.com (2603:10b6:610:12f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 14:32:38 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 14:32:38 +0000
Message-ID: <2ac44a27-d4f2-4191-a9c3-513af25925b0@oracle.com>
Date: Thu, 9 Oct 2025 10:32:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
 "query-balloon" after CPR transfer
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20250928085432.40107-1-zhenzhong.duan@intel.com>
 <20250928085432.40107-7-zhenzhong.duan@intel.com>
 <1ba0dbca-08b2-4f80-ba12-01884a25ef0d@oracle.com>
 <IA3PR11MB913635F06F6522102D8FC15D921AA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <78df77e2-43a6-48d6-b09e-fcc61a662b6e@oracle.com>
 <IA3PR11MB9136EF2C01DAB2C2EA261CC092E1A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <ab688cce-283d-4541-b7ca-be651085979e@oracle.com>
 <aOfEiogVQiAhBqMG@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aOfEiogVQiAhBqMG@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR20CA0020.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::33) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH3PR10MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: 999cc731-6ff9-4c61-18e9-08de0740b273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1MzeHFhTm83cDRUV3VaeE9DT1JFT1R5QkFRQXFCankxTkJwR2o0MEVvaEdE?=
 =?utf-8?B?K3BmdG1taDZWNmZDNXRRM1VrTU9SM0pFMko1NlF4ZFNRRnQyOEx5S2VqcytS?=
 =?utf-8?B?ZDdUTHZtZWhhbHpKd3JsNGxNcGhwR0k1TW9hVUp3VWhUT0NPVHF2RHhLUkxS?=
 =?utf-8?B?L0J6U0VxRW9oMkZybXByL3ZyOU9GdjNvWjROcUVxQ1ZtdmZsak05U21ROU1v?=
 =?utf-8?B?Q25LQ25rZ2RyS1l0U3pIRC9ON1BINFZPUksvcC9YVkVhUTlGR2xWU1g4MURk?=
 =?utf-8?B?Q0VqVStCSkhNM0NCNjFzWm54OG83WGNIUUIzNi9uMlBQRGUrYnhSVnFLREhQ?=
 =?utf-8?B?QTZ4WSs3S1JLMlBxQm5RaE53R2Mvblpac1VDMDFSQlJIcWpHSVV2TWY4Qmhn?=
 =?utf-8?B?RXp1cVdnS2hjeEpDMnQ1SkhaS2xNYU0rSXVIVDFXNk9OV3NEc2pJbXhpdDI5?=
 =?utf-8?B?K2E2bGdLUHZTYzl5OFJPZFZiQVBLa2Z3ZDJPQ1U4Qlo1ZU1sNitOb1QwczBV?=
 =?utf-8?B?RE8rdlZWbDRoRXBTTk9aMFFsWUE4N2hmQ1pabElaU290VkN0c0ZLdmRzblpN?=
 =?utf-8?B?eXMrcmUzWFRuWGxmUFNYd0hXZnRoNzEwK3d4S2kwYXYwZnBSckhhQzN6TjlU?=
 =?utf-8?B?M3dqeEJMQS9CcFZxUGR2aXhKUTNTT3FtZUhjOWJsTWhONmxmMEtTemlDa0VD?=
 =?utf-8?B?eHJBUVI3NEk5N01ncE5YYjlHMVo1dlVUZHBUSjdvRUVpZE5sbVNVRThHS3BK?=
 =?utf-8?B?ME9za1BnblkzNVQwTldab1hQQ0g2b3NzN3NnU0l2RnpZZGtUQU1rTnlIVjVh?=
 =?utf-8?B?NUNWL3JuRU1NMGg1Ri96UjlBNXRyWE5hQUxzMDdMYTFrRHdNeWRZbENtQmhs?=
 =?utf-8?B?ZWg1RnZQbndmdWlGTzFrNThuRk9kYW1mWWdYYUZwTlU0UHI5Uy9PcjBrNFRM?=
 =?utf-8?B?YTBYb1VSZ0NpVmtKbjVtU1lFNlNxU05yMEpSV3dKVUhidUthNUFwdEtJWkZ0?=
 =?utf-8?B?dlN1b0twZDd1cGZJTm5EdjQvUHJQT09wY3FWOUJaZDhPeG9uZWNVbTVEQlI1?=
 =?utf-8?B?ajB4U203UkNOSGtYTE9qYVNHOHRMOE5wWDEzZFg5QWhSYTZOOVZuWndiMWUw?=
 =?utf-8?B?TTdZaXphMGFVMUt5dFRJT2ROTElRMkJqRDhDUyt6NDZ0MjBmMmdUc1VmRmxz?=
 =?utf-8?B?elN3WTc4RkprdkdTMlhyMllqZlRaZVNUV2dTZlV1TVMzdUh2bHExUXFUY3M0?=
 =?utf-8?B?OG4zRFZtYUxTRkQ3dzkzUk1DTkhkcWJLZmJBYnZMdnpKeXUxR1BuKytITGwv?=
 =?utf-8?B?M1dJN09KZC91ZlpXMi9jYitjdkJ6WVhjOHJvVHRrUUtwTnZBaVV1UUFrUHNr?=
 =?utf-8?B?VXhhbTl0VjR1Mm13UUFaYU5RODFNNktDaTBtTGg2d3NjNmNkcjc3M0J5SkpB?=
 =?utf-8?B?ak54Nlh0VGtUMzh4OEY2OTI1azF6WHRNWWRLU0JRLzZCNGVYa08vUHpFaDJ3?=
 =?utf-8?B?bzhaYkdiei9rNHRMbTBWc21NYk4xb1hXZkNKeGhaSzdJQnJHbjBlTEhlTTY2?=
 =?utf-8?B?YlA1WjdHRFYrSURDdmU2eE1aNzgwWUNXSlZ6aG8zbFZjVlhhMFBxMFM1UjQ1?=
 =?utf-8?B?ckh1Q2x0S2VaaU5KQ21wdHlLYUtPWU4zY1Nac0ZROEZueDVXdUNuTVBySDI3?=
 =?utf-8?B?ckF0aVRJOHljUkVoeGtwVlFCRmo2TzhjdEwxLzMwRHRjbGZwSUx4TXJqdmdV?=
 =?utf-8?B?MDY2WDJseUF0c21XTkd1S3dpeGdmS1FSV05sMGRhdnRPU0NMRlFsbSswbGdI?=
 =?utf-8?B?WmY3VVk5alBsTE4yK0cwaGxHSG9wVE1SWGNTK29BVnpFY0c4dFp0L2FSakQ4?=
 =?utf-8?B?WmtuajdqVVFWaFFOZ0xNQWdIUTN4K1BBbFEybEw1OUFkYlVZU0Zrb0EvbW10?=
 =?utf-8?Q?gvk9Lr0V+C3aypraBtcxCdUGW5cYKlHh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2RZTkZJL3dCQmxFRWJ5cXYzaFlpRFZ5UVQ0NWxjYnBKTXEwQTB5cCt2WXV4?=
 =?utf-8?B?c0ZNdXVpRzJ1Y0lPNE0zbFBqUkt5a0Rza21WaFhtUWcrLzg3enN3a3d3SmZ2?=
 =?utf-8?B?b1hXTGlQNktXRHZ5VHE5emY1NGJjTitZSjdCR2tzNWlzcW1RUDdCRUtMZzI2?=
 =?utf-8?B?Vk9LNTlHcUNFL0xnQytYYmhVTktxV2hHUnFhcUdMV2l1NHIzd0xTcjhGUlBB?=
 =?utf-8?B?UzZHdldjWmNHVVUwUVEvWjhYNWMrZ3NpemFxQ3hVcUIwTk5jWmltRlBTaHQ3?=
 =?utf-8?B?aXBNcVpsVjFXRyt0SGxOSG1sUHFDaVRFTTk4WWNCUlVHbGMvc1UvbFEyUzBL?=
 =?utf-8?B?aURBaC90aDJSbVFXR0FpTmd4NWtORDVaV0Nyb1JBRFBNelcrRndDNzAwc2Fk?=
 =?utf-8?B?ZUN4WWxINm9ZT09ORjF2eEFSMUIrK21ZR2NYeFFTUEs2eVFtNyt3QURXTjJH?=
 =?utf-8?B?WUNHZWM2cHFVTzQvbUErc2ZlUGU3UEhXdFlmRUo2Qk04QU8wNmV5ajZ3VjZM?=
 =?utf-8?B?VkFYaEJPcTVqT2kwUlpqMEFEMjlLM1U4S2JGRXNiVHhLaHBhaDhJTXFFaUhS?=
 =?utf-8?B?Uk1aSUxaRXhIckVGTWRna2FYdCtodkl2T2VsdEpBVUhCekk2dXRTRm92bll2?=
 =?utf-8?B?SERGSmkwUE4zQ2xwU1pQSGdDcHZLRzdUMGY5TGJjajRPUGZCeXkyaDBRWU5y?=
 =?utf-8?B?MXZMOEdPb2l3T0ttbXA5NWl0ZTVUWVM3R1dIZnNVSjBrTnlGOVlVYStqaTEw?=
 =?utf-8?B?bGpxYlFwL0tpdXgrWnRDN2RvZWVSam0vU1lxR2FhbW11amVzZnhLVGZNR3cr?=
 =?utf-8?B?T2lzalpRSjl0ZGFuZnBmcFNhWTA5ZXNWckZXS1p6S1lyNzJEWFNhaHM4NG1N?=
 =?utf-8?B?QWZjR21OSm41QVd2YnF1NGFHeXFNNFhPT2FlWkhkcmgxU0VObXkzdEdUT3Ry?=
 =?utf-8?B?SGpIYnpZMHlLSEt6MWRIaFJPL00yNm1CRDhqOHp2SEQ3cTIxZGtIT2dCaGY4?=
 =?utf-8?B?a282Z2Myc01NSlE0SCtZWi9WVkI3UUhOYWNiM0NMUGpzUDkxekppMXBkbGtJ?=
 =?utf-8?B?enRIZ0J6azNpQ3hBNEdrY3JKMVp0UFd2MEpmSWUzZDVGdWlWalZ4bzRzZzF2?=
 =?utf-8?B?RlRlb0lZYk9zV0JXc0RQRHFBcGVYbGVTdTY4aHpYa0lnOVdlN2NwYXZ0dTNw?=
 =?utf-8?B?ZzFkUXNPYnNYd1RxUFJMaTVTTllRTzdRSnIzN29BR3pjcGRYTm5CTDR2NW5V?=
 =?utf-8?B?cDZVN2pBZk9JZXU0Q0t5WjBacXdHcks5YlVaZGhCVzVBTWdwMWRuNUhmYXpt?=
 =?utf-8?B?TFVFeDl0WUpLN2NaRnpIbEVLN1BTei9yTENlR1BnQTcycVlFMHVCVGxPTTJP?=
 =?utf-8?B?RktDOTIzL3N2QzN2WGR2eGRMMG1NSDM4NU1kcU16Q2JxWWlmaTVXOTVkcHhq?=
 =?utf-8?B?SVdkR2hjRGFPbDRxcFA1R2IrbFVLbi9xeEtTWkJKV3l1U2t6dVZNMjJEaVN3?=
 =?utf-8?B?WTgzWE83NE5uekVCUzEvRDYrU0JnMWhEVVlSNWpYdURBeXZFMEt0bXZPSy9v?=
 =?utf-8?B?ME8rSVdVZ2hpaGxGdFVhdUNVZGI4RW16dlJlMlpNSVlrUTNDTG8wdG5melo3?=
 =?utf-8?B?ZldkaHhSM3RIc1ZRUTdWQ2hQRiszeTBTSTRYY0tLSVVKT1JBWTVKWmJXcDM3?=
 =?utf-8?B?SW5pMHFFVU80S04zbklHUGdaTWxlU0pyeWc2dTFLUXVsaFhlY2lZcm9rZTlt?=
 =?utf-8?B?ckJLSnNDM1dZYlRtN2pEUjBiN0o1NmtoS3Rla1NVWVNxSTlTVUMzaExsajl0?=
 =?utf-8?B?bjBHNFJuK2FZV3hTUE50WUhralBjR1dlYnN0UnNveStOWGIxOUJqWDdTYWxC?=
 =?utf-8?B?UkFnbi8yNmNBVEl5aFhTRGQ2VWRkVCtobFpMSC9GMDNmSkx0S2RvU3djV3Y2?=
 =?utf-8?B?M2RrSGkwV1NjYjlOSHJlSzR3TEhweVBZRGdxZ3U1dnF3UWdDNC84bVZoL0RR?=
 =?utf-8?B?N0YrK25vVFY4NDlRQ2hIUkZZT2hsdGpEeTVUdFpnZkRPWXBzeDl0L1F1c2du?=
 =?utf-8?B?c1BZVjA0bXR1NVNTM3dxa0Y0bHJjMGdEbmNKbVFFWDBOZEQwaHVxNG9SN0xL?=
 =?utf-8?B?cFRpejloemNtQldFM1JMTzF5d0pCQ3c0SUpsNkpxS0JxMmdYWGE1Tk5XYmRP?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mpCDNWKeBuF1oCpBjt/A3C92z7LhJCpyeIjPFMWR3bOOUTeh0St2mcmu7BGTA7H09jv+DPpUwhlN9vSkKWMfQloE9fN2SasTDv9ORF88uFXcJpqeXsjEy+3GqjVSIbXT798qyHX1/HFVQnlwyAaH4itKPZO++ZC87jKmipX+YHPqz3zPm/8CYsFGED+D7iJMdidy1RyFpbDNNvbm1e3qNW6oVOGIS2ru6IRw/iySGx0q5Yt65D+z/mQapD+QNlAeWbdSCAJdwcbCxBOQLU4MVVSTq56cHH1/Yjg1YCZNU0fZDtoEyhrtTMYUA4B+W7ugZQadzm+CxoQXYoMaKFryznvhk+qrnGkM10lhGkBEdP7ID1bF165oNiekTR1+oYDeNDj23swuJi52mBYE3s7x6sE1dKeLaP7c6F0azCGuzwikOrEn8bFV8qCp5NVm3LRekfhDlhXrmoWhTaylFKZcrvfjrAtSqLWcSBjZc3sKSkoWWhWbdCbQQuFrFxEKcE4QtU9JkjWGjf070ejwiyEperwlJUdQwmJw8TRh6Od8fX0GmTMDMNBOQ1URQnxfOIavfnxNpTmaOuL01cZEDhGK/VMAi26FGieWoEe2itiRgQg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 999cc731-6ff9-4c61-18e9-08de0740b273
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 14:32:38.8035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BBA2LtganDimIgje5ocsvBMg19XQQF6Uu4d342FPlp2+DnPbL94UZ/Tw3zL484PsPGLuKmYTlnTgpDBbF5iVcKDlVZ2/YzARq4zb0fzXh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7330
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510090087
X-Proofpoint-ORIG-GUID: 3t80iNYSn7v980q_wtanPERf9PhRsvxF
X-Authority-Analysis: v=2.4 cv=bK4b4f+Z c=1 sm=1 tr=0 ts=68e7c78b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=TYmR4lEJv4xYLONoMH0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 3t80iNYSn7v980q_wtanPERf9PhRsvxF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX1AOWhRk/tgF4
 QXIOKBm7warGaMHbldAqJON2wxjYZ0WSYXERYvt1lyKnTNu1ZP9pd2GI/21JC/Q0l3RodRHV9Os
 H7n0NrdGpqSWaCDtk9zCYsS/qsLoILxVi0beD1sT9IPe+uoAag5aANI3drlSg55Pm3ebDvMNXss
 k3gmsa6huhoRuZaD2oT6tSv9884hYrzimI4C8/tI9m28lhVl+iPGply90+xmNQjp+drRmUMrF+i
 rksGbBZgFUEhzG3ldbb74JbKVC+88gFW2l6R7fVIxJN5EBs0vfOaIVU7rGF2eqahGuL3TxWbpZt
 tp1HPC3u6lyMyx96KYhlGwhZX79C/LKlLWx0hyQ1AZ0+E02a7sa5FYYHYLzHQWQtOHVOufg8ZdO
 eu6LyOhPwPKFQM7Z05zi78fMRwZByA==
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 10/9/2025 10:19 AM, Daniel P. Berrangé wrote:
> On Thu, Oct 09, 2025 at 10:11:17AM -0400, Steven Sistare wrote:
>> On 10/8/2025 6:22 AM, Duan, Zhenzhong wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Steven Sistare <steven.sistare@oracle.com>
>>>> Subject: Re: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
>>>> "query-balloon" after CPR transfer
>>>>
>>>> On 9/30/2025 2:00 AM, Duan, Zhenzhong wrote:
>>>>>> -----Original Message-----
>>>>>> From: Steven Sistare <steven.sistare@oracle.com>
>>>>>> Subject: Re: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
>>>>>> "query-balloon" after CPR transfer
>>>>>>
>>>>>> On 9/28/2025 4:54 AM, Zhenzhong Duan wrote:
>>>>>>> After CPR transfer, source QEMU closes kvm fd and sets kvm_state to
>>>>>> NULL,
>>>>>>> "query-balloon" will check kvm_state->sync_mmu and trigger NULL
>>>> pointer
>>>>>>> reference.
>>>>>>>
>>>>>>> We don't need to NULL kvm_state as all states in kvm_state aren't
>>>> released
>>>>>>> actually. Just closing kvm fd is enough so we could still query states
>>>>>>> through "query_*" qmp command.
>>>>>>
>>>>>> IMO this does not make sense.  Much of the state in kvm_state was
>>>> derived
>>>>> >from ioctl's on the descriptors, and closing them invalidates it.  Asking
>>>>>> historical questions about what used to be makes no sense.
>>>>>
>>>>> You also have your valid point.
>>>>>
>>>>>>
>>>>>> Clearing kvm_state and setting kvm_allowed=false would be a safer fix.
>>>>
>>>> Setting kvm_allowed=false causes kvm_enabled() to return false which should
>>>> prevent kvm_state from being dereferenced anywhere:
>>>>
>>>>       #define kvm_enabled()           (kvm_allowed)
>>>>
>>>>     Eg for the balloon:
>>>>
>>>>       static bool have_balloon(Error **errp)
>>>>       {
>>>>           if (kvm_enabled() && !kvm_has_sync_mmu()) {
>>>
>>> OK, will do, clearing kvm_allowed is a good idea.
>>>
>>> Currently there are two qmp commands "query-balloon" and "query-cpu-definitions"
>>> causing SIGSEGV after CPR-transfer, clearing kvm_allowed helps for both.
>>> But clearing both kvm_allowed and kvm_state cause SIGSEGV on "query-cpu-definitions".
>>>
>>> I'll send a patch to clearing only kvm_allowed if you are fine with it.
>>
>> I still don't love the idea.  kvm_state is no longer valid.
>>
>> It sounds like "query-cpu-definitions" is missing a check for kvm_enabled().
> 
> This patch  / bug feels like it is side-stepping a general conceptual
> question.  After cpr-transfer is complete what QMP commands are still
> valid to call in general ? This thread mentions two which have caused
> bugs, but beyond that it feels like a large subset of QMP comamnds
> are conceptually invalid to use.

Agreed. I don't see why these commands should be issued to the dead instance.
How about migration status, quit, and nothing else?
Half serious.

- Steve


