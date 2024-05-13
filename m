Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8466BC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 19:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6bkR-0001sg-Aw; Mon, 13 May 2024 15:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s6bkP-0001sW-Eq
 for qemu-devel@nongnu.org; Mon, 13 May 2024 15:54:09 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s6bkN-0004hE-2A
 for qemu-devel@nongnu.org; Mon, 13 May 2024 15:54:09 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44DJHYix020652; Mon, 13 May 2024 19:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=4iuJmrWDFrtPRzWZe3HC/1v67em3ROBzmZO15agL7Zw=;
 b=gMPlKXlMYjzx+exBameQ+XrlzDL1S1STIgBwsd8XEWCjt5Ijp4ZjTsiEtRaRE27nCEUC
 vEROnVTeEecBQSFJFsT6584DQkW6Z6VM2SxdFwWrp5Y84Qj4deEHNQNxlmVYSbCl2tpE
 bINybeTjaG/ZDxUM/kyse27KJsysUnKymZp5eL4GVc4dwpBLG74Z1zZdbSK0LBQimTIM
 fz/Q1WSIjt2acrjxzQDiXpL6+ojKnqIwIP9uQVYBN9tJnevgl1IP9qpP+L4KkHh5yVWJ
 pBptBZTDaA08caY1QPlJX42X6I3S+IPxawfyNWKBF1URBXd8jyKG37dMxYnKa5/ceJk+ Tg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3rh7861a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 May 2024 19:54:03 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44DISSBU005992; Mon, 13 May 2024 19:49:01 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3y1y4693d4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 May 2024 19:49:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJXIGtWN4hg3gKSELFVRJM7oGNOJqbgCAgpQnn5QJ18s8uYfHyLW6bHAKbC/E9BUYAUfwalWm7CT22s897kj+ArKAyBWf/g5WxvJRdF3TRodHRc1hrlwhCFz+UR7rJZo4VScEHUINPWzFmb03IH8VKhtRgXItrv9wTCYtzUu69yNrPX+QWB4iu7PXzd1zWT+bVtQVyZxOkPJVT29YwayI5SYEPRdhWbJyaI/yYVxtZWh0jOo17TOrIAkcfqE8Hfgc8gsYx2saRMgZYYog/rR6uTGrtzhTZr1/LneHqTpRVldoPO992J+1YJdESn2waaj3MDzEWGSbXhdQgJoyLmZkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iuJmrWDFrtPRzWZe3HC/1v67em3ROBzmZO15agL7Zw=;
 b=IIx5PKUxhiVzjn1BZhEDBxbbig3rGRcEt+LnW4QdrdRyaL90T9nTfqr4uenRzD8VqH9QVpn2GJgQ1xOMVb0957ZjpHnsTaWmolf8a6ckPnF9zGPxDXOLOld2xXnNoOfB/dmyQfMEzaww21t/QsPy8tqIm1ar5LqWWaaFXqSWCijVL0yj1iKiAtUAXWPaJl2zyo0TDgpXp1ptBm23+KW21B+17llonOi/rgwNvAUpz/UFW4RxcvQB2VkjCd+/0Dx4ApwDliKcrwiWifqu38WK5yONeNafwoTTZHloBgIzPIC+e7D528tVEvpCXTvBzwTul9olnRi69I6nz5ltD2W3Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iuJmrWDFrtPRzWZe3HC/1v67em3ROBzmZO15agL7Zw=;
 b=AybgAtXV9+8CZU4Zi42yhtQYA1jT/HReOqBRzlzGJkggPIDdow0bGWI7WGJFnrysmWlUVANl1u30E3Xhrmws+qC4rNY2bxuhW114j1ieFdA8XXQwS+OTtwdKakYzoScYJaarM7uwVkSzIueVgDwEdvn5u5bogFo//pmVSBC0prQ=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ0PR10MB6301.namprd10.prod.outlook.com (2603:10b6:a03:44d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 19:48:58 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 19:48:58 +0000
Message-ID: <9e5a8874-84c3-4c7b-aa0e-6d01ea6a63de@oracle.com>
Date: Mon, 13 May 2024 15:48:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 26/26] migration: only-migratable-modes
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-27-git-send-email-steven.sistare@oracle.com>
 <87ikzmkdaq.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87ikzmkdaq.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0198.namprd13.prod.outlook.com
 (2603:10b6:208:2be::23) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ0PR10MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: b72d1005-86d6-4880-726d-08dc7385bacc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVowWHJ0c1VMc1d2NFNFVlRGaE9rcVRyTG44SE9PQjV5a2lDYXl1dTd1dEJj?=
 =?utf-8?B?MlFnamhxV05XRmVvSFFFdW40MERqY21xcTJpdlpwUHo0Zmt2ZWZnbjgyVjQv?=
 =?utf-8?B?OUZjVEI4RFFPN1dlUDFXVDJUUFdDYjlyZGJOeFRLNDdjUFJ2UUlZSStoL3Yw?=
 =?utf-8?B?cVRxOFRyTDYxRzEyR2RlZkVMSGdmTlpSYlh2MnE3TlNYK0RIS3crRW1nRFF0?=
 =?utf-8?B?RVBhSWhQTnVIMCs5d3FkZFNmSlRGTU1Hd015RkFnQ0xyMS9Ma0Y3MlkvaWYw?=
 =?utf-8?B?MVAzaktzQlFRQUF2M0tSK0t5RStZNDhUWXhxQnRyS1hodGRkWlY2UXNYT3BZ?=
 =?utf-8?B?L05BS3o3NnJ1Uy9JR3R0SC80UU8wL1pRTmwvVE8vYjBSeEZNbEgzbTN0ZSsy?=
 =?utf-8?B?UC8rb3E3UTRWTEpiS0ZsTVFQY2dZNm5penpxTE9mZVdJQlhXOVdKakRpTmd2?=
 =?utf-8?B?VlpxdHRoT0F0bmtLMG9xV3BrV3J3L0VWU3ZzK2NiSUc3NmRzVXdlSWN6dFow?=
 =?utf-8?B?cTJJdDJKS3BOZHhSY0wwZDNoY0lKNkRYYndhem5LVk9HcnBSbXNmMWdkN3E0?=
 =?utf-8?B?Y2VhRXIwOHpIWHYvVzBlWnZEZGFjT3NsY1RwNGVVa0hEeW5idmVEelA2QnF3?=
 =?utf-8?B?SWRpSTlkU2ViVkFCc1dydktUaFpuZDR2MlZkQ05sNUdqdGFqQkVZLy9mVUJE?=
 =?utf-8?B?cVZqRFFDOFF5MWVaL2xqT1gwT1oyS3c1c2F5U1Vvb29rZjF5WGx6VXVFcjBB?=
 =?utf-8?B?a1JTZEFBMXVkZ0hVQnRKNkoxNkJ3d21oWVg0aVlEOHRZMUVUYjZJdmdnYm5F?=
 =?utf-8?B?RldNYSsrdFk4MTkxOFp6OEtKNWtJVlVTbTUzbWpjdnN4UU1NZUlEVy9CREx5?=
 =?utf-8?B?NDFYdVN5SS9OV09wdWNlZU9MZzNqNHpvYlRVbkV5S2YvV2k5YzlXT2RCZlht?=
 =?utf-8?B?RFB5a1RIK0RhRmpLa2lmNjZGRjRRVGxxWHAxQk00aFFRejBKbFhaMEFLZURy?=
 =?utf-8?B?enZUeFNnVlhmTVdNYVZKRlk0WjJISC8xNlQ1UzBZczJyR1NCbWV4eCtzRjh4?=
 =?utf-8?B?Vzh1ZS9YL2ZtY2t0b0prckFFdnVUMHJSSmlvMGNEYlVJT2EvclFBbnNFdW1Y?=
 =?utf-8?B?aXY4dC9Da3RqZnpxa1M0T1RvMlhxRjM1eldjRlZYbUZIRFFCWDAwL0lCaHVY?=
 =?utf-8?B?STNQLzNIOTEzUDcwNlhwQWgvNFY5N0FIM05iRGlTcDFnRlpqTTFRWFhPUGNa?=
 =?utf-8?B?Vk9YNGNrRFE0WDZmYXZyNUpEVnVlWmZvY0VJVWlDUkRwUjFnZ21Vdm1tMGcw?=
 =?utf-8?B?aVdvcnl3UkcwSjJrbzM4QVVTcjF0OCs2dGtLb1g3ZDczMnBFN3NvSS9sYjdh?=
 =?utf-8?B?bnFmWnM4a2ZmU0d3U2ovekJ6N3dzMkRtanVmNTFtUCsxd3E5UkdhblVVSmkw?=
 =?utf-8?B?cWEzKzJudk5yNmVNMDJEWm85QllHWlFvekxBRmxlS2ZpRmZTNi80cUdVSGQy?=
 =?utf-8?B?U0lTMGkvaklERWJicmZQMmQwQTh3M1BKSWtGckZPekNPd2VvbEduMm9oQVBz?=
 =?utf-8?B?OGFUU0JHMkloOWV1U2N6dkdHWVM3OFNBVHpNOXpDcFpBUlVMWUFKdzJhc2dn?=
 =?utf-8?B?dU05ODhXeThhMkZpMTIwenFqVHhzNmpUTTQwYXRYQ2V1QW1FajVmaHB0MTND?=
 =?utf-8?B?SDdXQzJNUk56VUxzOVlmOUdVUnA3M2pNSEU2VkF6bWlaSEtQVTJQeldBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(7416005)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUhHMGtTb0d0bzVVcy9raERmZGV6WTRSUThodC9YeDhURHJDU2UwTE9xNTJn?=
 =?utf-8?B?WXo0MFJDS0hXRXRicSt2azFLaHhXTmxNQVErUEtOZlp0WmVDV1hJMDBFenlm?=
 =?utf-8?B?RU5QZVVBM0dnOStKNlAyVm9vVStpamxERnNSMVU2ajlmNTNDSEJlUkFuZktV?=
 =?utf-8?B?QW9DMmRpRm5BeGRqMnRwd1dBQ0RKclVqaTJiYmZEbGdHK2M5amFTTGVYS2dz?=
 =?utf-8?B?NFVTd3pmWXJ0bDh5YzZuYkY0RWhNMkxxbDNnNWJvQ1dKUENZQm5KeElIcUs3?=
 =?utf-8?B?eUowTVlwSUZmS0t2RVpvWi92bnlEeVA4RElGM2QxS2F6Z3lDcWdYRHBwVzh6?=
 =?utf-8?B?RUxyT3dmQ0FqdkhJbzJTbkNmclFBS0NYTGpBWWxXY0t4WGNoKzZyNmxqMTBB?=
 =?utf-8?B?bTNIRU95ZDE4dVBCaHFDK2JnYVhnNkExL2tYWTF1ZHpLeEY0b0Y1dHJjSWhF?=
 =?utf-8?B?dHBYTU9kdWJFVXpWS1J1VEVSMEpvcUVURWRHWXJYaHE2YzQ3YkZPdHFhRkww?=
 =?utf-8?B?RmIzZzZjMFlNWnN6VDNISHF6M0wwcE12eVBmbVlMeURoNWVlTklkL0ZGdzVs?=
 =?utf-8?B?VXhsNWI4UG5INXQrNUZjTXltTjNYM09BeWtXdURYUUh4OUtkdWp6SWRBWlF4?=
 =?utf-8?B?V0d5ZjVOMFdZRkZTdVhjOFVoZDhQK1BUYTJveHpIT3I5U1VEdmJsL2Nudkow?=
 =?utf-8?B?dXpONmlBdGNubDVmT3hVbFVkcGdESmRORzVyMmNjZ0xENWE2TFZKRmRPMWhV?=
 =?utf-8?B?WE5MblJ0dGgvMk5peXJDeDFIUGhWdFhxMnNhMzU1RDFGSFZUdHNab3JGeDcz?=
 =?utf-8?B?clRXSEdMOVZuc29IWHkxT25MREhsTUFLUDcyckNWS3kzMy9zeWlORk81KzNH?=
 =?utf-8?B?WTJnRjBYbFV2My9hNjZZemNCUWJIbTc3ZU1hSlNCckdkVUhWaVdyeXhsWDlz?=
 =?utf-8?B?WWJFWjEwandhOTBXUi9JZW1CVU40eVBRWDZaem5MOVRHNktFOEwrcTRUdlZ3?=
 =?utf-8?B?bWFDRXZwQXJueW1QbjA3QmxFb0crbWZvcFRQUUhzMzU1Vk5YV2ZORFRZaEJu?=
 =?utf-8?B?U1lTVDlWcFUrTVFmSStQcDR0OTc5R0tqM1g1Z0x4elpuYnl4cmd0T1RXaEVU?=
 =?utf-8?B?dDFLc2w2SDlaNU56bnZMUitlUlFaMW9WMDA4OE8weHBXakl6MlI0VHJsRlZv?=
 =?utf-8?B?RkJQNXZiSUp6TEFlTlp1Y0QvVlhIVWpNeUlkaGJsejdSenpUUGNoeS9RK3Vq?=
 =?utf-8?B?L0xObmtFUm9CVDRWdTFNUVRvSVBxTEdhOEpha0Z6VHg0ZTVtNTEvZW91eFZU?=
 =?utf-8?B?US9wY0x4RzZxSmQ1NllMdjFyOWpzUTd2UXpoWUVadXUzL3NhYXdYcE5wN3JC?=
 =?utf-8?B?TnA2VlRCMzBaUW84V1dHQTZTdURqdEtKUnpyT1pkSDQyZzdsKzJoMUVCOXZ0?=
 =?utf-8?B?WDJMMGFVbDRmOTFLeXNqQUFCRzQvN0V4WFRyNWtoTStibFY5eldEUmszOU5o?=
 =?utf-8?B?dTBXbkY0TXJPaWRzTy9CWm9SeGovT3lxaWRlTXd5UWxmMkQ0WGdHY1dFT3RJ?=
 =?utf-8?B?N3AzTlJ3eGwrMGV4ZHp5dUlIVTdaSVd5dWJFaWtUMTNHUENxa1hRK0ZoR1dN?=
 =?utf-8?B?UGwxMGZUU0d1OW5nRVNKd0xyTUJVdDR5ZG9vcWsxWm1zNDBUdDhJQXVYTzRs?=
 =?utf-8?B?Qnl5cTNTZVRYRjVkMmFhSmJWbFV1d0hQMDh2MXFpd042MXZERU9Uenpadllh?=
 =?utf-8?B?cUF5am5aMjdkTDRETXRhVWFnUVhsRVRqRGpUN1k1UkNXRURYUDRKZ2FNejZy?=
 =?utf-8?B?U1N2V2UvR2FsOUxnTS8wV0xmYzdmMGZlL01LMk5XK0szN0c0cTBMbzl3cmhM?=
 =?utf-8?B?cm5jR1V5dUFKVlVKbGpSYVRoWjJ0OGdOdkxiVlErTWN4SmtYU2g0ODE1WHJT?=
 =?utf-8?B?Wm9KWUg4MXhySytLTTVwMFVRY1kvUCs4b2J5TGtZUjhjMjkyeE1XTXhNeER4?=
 =?utf-8?B?aTVDcDhzT2hlZ0M0bXhrWjdRV3NKRmwxM3c3eDBDK0IxcVN5Y2p4Y0RUTnBM?=
 =?utf-8?B?VDFWVVBETUJQWFRFY3lIVHo0QS9LN3l5cDNnV3grQ1V0bHJUdkVzdVhUMEdy?=
 =?utf-8?B?TVd2VzE0N04rMy9WWk5kR2N2T2dLWFpqM2tETWN3TlUrdzZnNFZXckJNdnFN?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eWSRKXreGNBKqxMsQoUl+fYc/q8cj+i7IePLGkA0AxEdWyOdX7i/az5uMftfIFBH6DC1//ICSUUdB4BTv/eF5pRps1dADr1PjRWdrrcg9XOozjbWaDLvxL06BesfjZDnIpLZwjrambhIUPpPdd/0GaW5I1i3ACB2kDm4SRp61LPZZ8++MyCKXxe0kk8C9Z6Mml35xlseDh+ay140VmOXwA7vJhLi9Az1a8RD0TJLEMXQERZWQsoT9wUE6FxVf/zPokDGPl9nc0aRc+UFVnyHDmwoTlqnUbW81tY48Tld51hnvRPkUjgBcVLy8TfSmRankuV/sTFUglourWoF+1+6g//++3ttdK+DFNoNPuzF3xKKO74F4QvzVP9K8lHWEAOxn8Oor6TKHTS4uAl8sDQWRRp+2LQxbFBGRuLWnqsl9/sZzuDK3RXEja2MkYiJ69/LfJyMbAVwyCkhvRmKW/uUmZq7sMzVnetpPQh+BWayh65btCYTd0iTxqUAxZnXaSIsn8JswUMB/CzB+fsMZLz0pNBo+YlYcyquhMRtZy7oF4cmmdnpSxLkXS9aGSvmM55mdvQ99Uc8CA6Pywk1ky2Ouldzm9+aLpalRrLn/A5p+KE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b72d1005-86d6-4880-726d-08dc7385bacc
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 19:48:58.2712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zS0X+bHoeeiwdjbM6EC3bQEIV1UeALJAXWIvzd88EblR2fVw+ztr0H8NyndIDb/dMHttZTykaum7I6ZHeAW2nCKZa+0QaZfmhQyONvOQVS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6301
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405130135
X-Proofpoint-ORIG-GUID: HwwUR3xnFjYeDcFPZQH2cDp0cTY6bBMs
X-Proofpoint-GUID: HwwUR3xnFjYeDcFPZQH2cDp0cTY6bBMs
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 5/9/2024 3:14 PM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Add the only-migratable-modes option as a generalization of only-migratable.
>> Only devices that support all requested modes are allowed.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   include/migration/misc.h       |  3 +++
>>   include/sysemu/sysemu.h        |  1 -
>>   migration/migration-hmp-cmds.c | 26 +++++++++++++++++++++++++-
>>   migration/migration.c          | 22 +++++++++++++++++-----
>>   migration/savevm.c             |  2 +-
>>   qemu-options.hx                | 16 ++++++++++++++--
>>   system/globals.c               |  1 -
>>   system/vl.c                    | 13 ++++++++++++-
>>   target/s390x/cpu_models.c      |  4 +++-
>>   9 files changed, 75 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>> index 5b963ba..3ad2cd9 100644
>> --- a/include/migration/misc.h
>> +++ b/include/migration/misc.h
>> @@ -119,6 +119,9 @@ bool migration_incoming_postcopy_advised(void);
>>   /* True if background snapshot is active */
>>   bool migration_in_bg_snapshot(void);
>>   
>> +void migration_set_required_mode(MigMode mode);
>> +bool migration_mode_required(MigMode mode);
>> +
>>   /* migration/block-dirty-bitmap.c */
>>   void dirty_bitmap_mig_init(void);
>>   
>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>> index 5b4397e..0a9c4b4 100644
>> --- a/include/sysemu/sysemu.h
>> +++ b/include/sysemu/sysemu.h
>> @@ -8,7 +8,6 @@
>>   
>>   /* vl.c */
>>   
>> -extern int only_migratable;
>>   extern const char *qemu_name;
>>   extern QemuUUID qemu_uuid;
>>   extern bool qemu_uuid_set;
>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>> index 414c7e8..ca913b7 100644
>> --- a/migration/migration-hmp-cmds.c
>> +++ b/migration/migration-hmp-cmds.c
>> @@ -16,6 +16,7 @@
>>   #include "qemu/osdep.h"
>>   #include "block/qapi.h"
>>   #include "migration/snapshot.h"
>> +#include "migration/misc.h"
>>   #include "monitor/hmp.h"
>>   #include "monitor/monitor.h"
>>   #include "qapi/error.h"
>> @@ -33,6 +34,28 @@
>>   #include "options.h"
>>   #include "migration.h"
>>   
>> +static void migration_dump_modes(Monitor *mon)
>> +{
>> +    int mode, n = 0;
>> +
>> +    monitor_printf(mon, "only-migratable-modes: ");
>> +
>> +    for (mode = 0; mode < MIG_MODE__MAX; mode++) {
>> +        if (migration_mode_required(mode)) {
>> +            if (n++) {
>> +                monitor_printf(mon, ",");
>> +            }
>> +            monitor_printf(mon, "%s", MigMode_str(mode));
>> +        }
>> +    }
>> +
>> +    if (!n) {
>> +        monitor_printf(mon, "none\n");
>> +    } else {
>> +        monitor_printf(mon, "\n");
>> +    }
>> +}
>> +
>>   static void migration_global_dump(Monitor *mon)
>>   {
>>       MigrationState *ms = migrate_get_current();
>> @@ -41,7 +64,7 @@ static void migration_global_dump(Monitor *mon)
>>       monitor_printf(mon, "store-global-state: %s\n",
>>                      ms->store_global_state ? "on" : "off");
>>       monitor_printf(mon, "only-migratable: %s\n",
>> -                   only_migratable ? "on" : "off");
>> +                   migration_mode_required(MIG_MODE_NORMAL) ? "on" : "off");
>>       monitor_printf(mon, "send-configuration: %s\n",
>>                      ms->send_configuration ? "on" : "off");
>>       monitor_printf(mon, "send-section-footer: %s\n",
>> @@ -50,6 +73,7 @@ static void migration_global_dump(Monitor *mon)
>>                      ms->decompress_error_check ? "on" : "off");
>>       monitor_printf(mon, "clear-bitmap-shift: %u\n",
>>                      ms->clear_bitmap_shift);
>> +    migration_dump_modes(mon);
>>   }
>>   
>>   void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 4984dee..5535b84 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1719,17 +1719,29 @@ static bool is_busy(Error **reasonp, Error **errp)
>>       return false;
>>   }
>>   
>> -static bool is_only_migratable(Error **reasonp, Error **errp, int modes)
>> +static int migration_modes_required;
>> +
>> +void migration_set_required_mode(MigMode mode)
>> +{
>> +    migration_modes_required |= BIT(mode);
>> +}
>> +
>> +bool migration_mode_required(MigMode mode)
>> +{
>> +    return !!(migration_modes_required & BIT(mode));
>> +}
>> +
>> +static bool modes_are_required(Error **reasonp, Error **errp, int modes)
>>   {
>>       ERRP_GUARD();
>>   
>> -    if (only_migratable && (modes & BIT(MIG_MODE_NORMAL))) {
>> +    if (migration_modes_required & modes) {
>>           error_propagate_prepend(errp, *reasonp,
>> -                                "disallowing migration blocker "
>> -                                "(--only-migratable) for: ");
>> +                                "-only-migratable{-modes}  specified, but: ");
> 
> extra space before 'specified'

Will fix, thanks.

>>           *reasonp = NULL;
>>           return true;
>>       }
>> +
>>       return false;
>>   }
>>   
>> @@ -1783,7 +1795,7 @@ int migrate_add_blocker_modes(Error **reasonp, Error **errp, MigMode mode, ...)
>>       modes = get_modes(mode, ap);
>>       va_end(ap);
>>   
>> -    if (is_only_migratable(reasonp, errp, modes)) {
>> +    if (modes_are_required(reasonp, errp, modes)) {
>>           return -EACCES;
>>       } else if (is_busy(reasonp, errp)) {
>>           return -EBUSY;
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 6087c3a..e53ac84 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -3585,7 +3585,7 @@ void vmstate_register_ram_global(MemoryRegion *mr)
>>   bool vmstate_check_only_migratable(const VMStateDescription *vmsd)
>>   {
>>       /* check needed if --only-migratable is specified */
>> -    if (!only_migratable) {
>> +    if (!migration_mode_required(MIG_MODE_NORMAL)) {
>>           return true;
>>       }
>>   
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index f0dfda5..946d731 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -4807,8 +4807,20 @@ DEF("only-migratable", 0, QEMU_OPTION_only_migratable, \
>>       "-only-migratable     allow only migratable devices\n", QEMU_ARCH_ALL)
>>   SRST
>>   ``-only-migratable``
>> -    Only allow migratable devices. Devices will not be allowed to enter
>> -    an unmigratable state.
>> +    Only allow devices that can migrate using normal mode. Devices will not
>> +    be allowed to enter an unmigratable state.
> 
> What's a "normal" mode is what people will ask. I don't think we need to
> expose this. This option never had anything to do with "modes" and I
> think we can keep it this way. See below...

We now have a mode parameter and enum MigMode which includes normal, and is
documented in qapi.

>> +ERST
>> +
>> +DEF("only-migratable-modes", HAS_ARG, QEMU_OPTION_only_migratable_modes, \
>> +    "-only-migratable-modes mode1[,...]\n"
>> +    "                allow only devices that are migratable using mode(s)\n",
>> +    QEMU_ARCH_ALL)
>> +SRST
>> +``-only-migratable-modes mode1[,...]``
>> +    Only allow devices which are migratable using all modes in the list,
>> +    which guarantees that migration will not fail due to a blocker.
>> +    If both only-migratable-modes and only-migratable are specified,
>> +    or are specified multiple times, then the required modes accumulate.
>>   ERST
>>   
>>   DEF("nodefaults", 0, QEMU_OPTION_nodefaults, \
>> diff --git a/system/globals.c b/system/globals.c
>> index e353584..fdc263e 100644
>> --- a/system/globals.c
>> +++ b/system/globals.c
>> @@ -48,7 +48,6 @@ const char *qemu_name;
>>   unsigned int nb_prom_envs;
>>   const char *prom_envs[MAX_PROM_ENVS];
>>   uint8_t *boot_splash_filedata;
>> -int only_migratable; /* turn it off unless user states otherwise */
>>   int icount_align_option;
>>   
>>   /* The bytes in qemu_uuid are in the order specified by RFC4122, _not_ in the
>> diff --git a/system/vl.c b/system/vl.c
>> index b76881e..7e73be9 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -3458,7 +3458,18 @@ void qemu_init(int argc, char **argv)
>>                   incoming = optarg;
>>                   break;
>>               case QEMU_OPTION_only_migratable:
>> -                only_migratable = 1;
>> +                migration_set_required_mode(MIG_MODE_NORMAL);
> 
> ...from the point of view of user intent, I think this should be
> MIG_MODE_ALL. 
If only-migratable applies to all modes, then:
If a user only intends to use mode A, then a blocker for mode B will terminate
qemu.  Not good.

Defining only-migratable to apply to normal mode is the backwards-compatible
solution.

- Steve

> If I have this option set I never want to see a blocker,
> period. That's not a change in behavior because the mode has to be
> explicitly selected anyway.
> 
>> +                break;
>> +            case QEMU_OPTION_only_migratable_modes:
>> +                {
>> +                    int i, mode;
>> +                    g_autofree char **words = g_strsplit(optarg, ",", -1);
>> +                    for (i = 0; words[i]; i++) {
>> +                        mode = qapi_enum_parse(&MigMode_lookup, words[i], -1,
>> +                                               &error_fatal);
>> +                        migration_set_required_mode(mode);
> 
> This option can be used to refine the modes being considered, it should
> take precedence if both are present.
> 
>> +                    }
>> +                }
>>                   break;
>>               case QEMU_OPTION_nodefaults:
>>                   has_defaults = 0;
>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>> index 8ed3bb6..42ad160 100644
>> --- a/target/s390x/cpu_models.c
>> +++ b/target/s390x/cpu_models.c
>> @@ -16,6 +16,7 @@
>>   #include "kvm/kvm_s390x.h"
>>   #include "sysemu/kvm.h"
>>   #include "sysemu/tcg.h"
>> +#include "migration/misc.h"
>>   #include "qapi/error.h"
>>   #include "qemu/error-report.h"
>>   #include "qapi/visitor.h"
>> @@ -526,7 +527,8 @@ static void check_compatibility(const S390CPUModel *max_model,
>>       }
>>   
>>   #ifndef CONFIG_USER_ONLY
>> -    if (only_migratable && test_bit(S390_FEAT_UNPACK, model->features)) {
>> +    if (migration_mode_required(MIG_MODE_NORMAL) &&
>> +        test_bit(S390_FEAT_UNPACK, model->features)) {
>>           error_setg(errp, "The unpack facility is not compatible with "
>>                      "the --only-migratable option. You must remove either "
>>                      "the 'unpack' facility or the --only-migratable option");

