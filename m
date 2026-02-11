Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBA4ECD6CD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 17:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqEHh-0001ya-Ps; Wed, 11 Feb 2026 12:45:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vqEHe-0001yO-TE
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 12:45:50 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vqEHc-0005Kn-RP
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 12:45:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYopf3zdiIkQdFEeXb1JNXYc3148kfGkz+IaEdNim2IRV9QQ3ji/RG0ojwoMR2JJ7NXJ3czIoE14XdjFLD6VE3RRqoYsBHM5qfje9CvaAurrBJpEguMXxLyzUNG75ld9qdh0SQOLgnD4xD3gBT0MS9wjbsNscSO9mc5mj0wIL4167DTjlVArCPMI9IhsXt/M0ngZvC/JGZNgtEtTHCXdh7AuJofE20YFDhIU40px9YCAmTGHGkAlcjFoF3Mq/ShIoekkW14S1RCFMwl5wquLMxZDmJlXPyQyCnucyI6liVZvPYWxYg+CEMwn57Fm5ZpoBpuzVDpvIgdPY3NYKwQ4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAzrazdpOZUo9RRP/V1GsrxfUeY7i1LegbsK1SGjszY=;
 b=f3CVBelT0fdWmctMU+L1BB7phej8ut/1r1u6yW/E/jRc4S7UwhKPA9uizavD8AlKH6QJBD2IcIzrQS+cj5Ma1RuWOvIyBc+CBraA+NOCAHyGLWmJY2R/dYxrupz3dLkMTGEhjL7yB7pCnkp9KbAE+1cVDt3nnZKjbimSFqdPyRLte1uzigjDAIc2z6VMThb67yz8Y+9DUkZHIBXoVa4ThiZsPN+6J4W/mLlacfQHm0VE5NOAUertZDRPXAD8plpWO8wued6lE794YqoTyNQDxIHujS9h3hlBx1CYKsXcNfWdlbSBVbC55tR70N1OpgG8XHFDGCVv4if8ZWvpxvi5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAzrazdpOZUo9RRP/V1GsrxfUeY7i1LegbsK1SGjszY=;
 b=mhPgyDUSxxyiLBIRdig5nx45j45gcnx24/ydcqMUnm1IFc36n5iRi45SxK9YN5h+CLjrwAxc5cWR5NpOfuJlKTCgAxvtiEwxvXJkohXaNiXT2321ZGEHGw245BIAfSHbjJjxP4MJRHyhPKj2bpfXruwcDcOXj3/qFflH8NwyosZHf+uWL5haayXwhUX0wAHjh0c/8dijCm4xSfyxmo086cZiq0+/B9cOVdH2uv3FkSG5EbPGOFX4pLGWTXZZf18xevg7ROlVHuYp6MX1ctmTSEZKGTLIv/vOY/H6Uu/LPcnayPT5GqkAYF1hsbU83w9jjp2J8hZFuAGRrcReQ0Z76w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by DM4PR12MB8570.namprd12.prod.outlook.com (2603:10b6:8:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Wed, 11 Feb
 2026 17:45:43 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%5]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 17:45:43 +0000
Message-ID: <1260f024-b22a-439b-a70a-ef5429162b3e@nvidia.com>
Date: Wed, 11 Feb 2026 19:45:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vfio/migration: Send VFIO_MIGRATION event before
 PRE_COPY_P2P transition
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Maor Gottlieb <maorg@nvidia.com>
References: <20260202173406.13979-1-avihaih@nvidia.com>
 <24ea8ccb-d904-49e4-bd27-5378aac4a56a@redhat.com> <aYIqDAdld4a41VDy@x1.local>
 <87cadb65-af45-4bb3-8090-8301a1e67103@nvidia.com>
 <a0dbd63d-30b9-4c83-851d-abaf50d4c9fc@nvidia.com>
 <aa18ad15-580e-483d-8e29-20c7e6ebb6fc@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <aa18ad15-580e-483d-8e29-20c7e6ebb6fc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::14) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|DM4PR12MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 424b55ac-1f6e-498e-7d69-08de6995605e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MU56UCtjWTZHS1l2aWQwZFBwamtBNjZ5Zk9KaWt4UU5PRFJBVFhwSzM4SFJZ?=
 =?utf-8?B?cmJlcTVVc1M5b1NscjBlRVRlcGsvdU4xT1JCdU9GMEpSZFc3Y3NEVnFQYk1F?=
 =?utf-8?B?dzJMcW1adWY4Y3BHM1ZzaWgzOTVkcEVURC8rU1VGZnZyZXpJYjBqSzdnMUVW?=
 =?utf-8?B?dFgwVXdKWUwxL2xqR2VVT0s3S3ZaSHlzQ0hjbFlwV0g1S0RabzRZV0VBZEE1?=
 =?utf-8?B?amV1MEw5MjRJQ1lUTm5wMG12RHkrdlZ4VVZPKzM4RjdNUHMwaUplK2hURzR3?=
 =?utf-8?B?TEpiRGVnQjdNL05YQ0x0bk5mTlVmTU5XMlJkMGhkNXJVQnJ2eUNDSlJFcHZI?=
 =?utf-8?B?Q1Jqb29ZQ2Fnb0xrb21SS2doWnR5L1N5Mnk5a0JBZHBsSkZ2ZDM3TWt4UUk2?=
 =?utf-8?B?VFdqWFZYbWhwenBXU2V2WGN3bG1PYWJIbzFOWnFlL0tOTWFTa0Zia1VFZy9H?=
 =?utf-8?B?bGlRbnZiQ0hoUjFOMTIzc2ZqK1NOSnF2ZGZvcCsvZlBwZ2hLUlZBdHN1U252?=
 =?utf-8?B?c1lhL3JCRGlkbVVTTXFYVXZvQzBvUWNFU2ZvM1Mrbk9RZDdydXMwSVhQS2p2?=
 =?utf-8?B?d0xSc1Ywci83WTZta3JySHk0T2hmTzUrUjJYYnh1YmhQZ0NXYUZycHR2NUlE?=
 =?utf-8?B?cVprUWQ0eUh0YkRXc3BMWTEyMXhLVk55MDBQQ255T2ZWWDdwQzZFeHZqYW04?=
 =?utf-8?B?VnQ4REcrM1pLUlUybldNMnJkUERBbmNjSGg3YzMybTVMQTlQeGduSEN2NDRX?=
 =?utf-8?B?UStxZVFiRWowRktmTE9wSDVneHVieER5MHdDVis5SUlQQkpXbGtSdFlPa0tT?=
 =?utf-8?B?WkxLNWsxVmdMYTVGYVNZazFaWVJHQXdKR0lPQ1hEaTNxNEdBUmozU0NvN1JF?=
 =?utf-8?B?WnZuZlNiWlhMeC8zVStKTmNPdXhUdjFBbTRzMDlqVFoxWWU3b0NlbnlpUmkr?=
 =?utf-8?B?aWovOXZBakhBNGtNb1E3bXF5Y1c4Wi9hVGt3T2xOajdoL0VRdXA3bXpzMmpZ?=
 =?utf-8?B?ZzdTSWZJbzBFZG10TlVFOHdIeiswd0NEbGpEdGFhME1KTnd5VXlOR2x0SzI3?=
 =?utf-8?B?bUdNRXlqRDJ1b0w3V0VMTklaSGN4UE10V2grN0JucDdIbUJhNXFtT281amRr?=
 =?utf-8?B?dFpNQUY1L1NFdEtDOVo2NDNQMVRnbm9kd2RYUGcvbjk4SXZYTlVuT0xnbGtD?=
 =?utf-8?B?QUxMZWNud2xQZHZYampvQ3pwMnhxOGdhS3MrTTdxNWFVR3dFQVF6MCtRa1I5?=
 =?utf-8?B?WDl0Qi80SWJyU0M4Nm0vdzdXd0lZcnVOcmFIYnlCMURUN0FnZkJYU1JqWW1S?=
 =?utf-8?B?Y0ZnaklUWGlwc0ZpQy8wc2tjemFubjkwejZTZS9QKzlVRWN4dmc4ckVlZnk0?=
 =?utf-8?B?TTl0c0RkR0FTcW1MWlprQ2lXcmptdHdaQWxhbGwvd2x1UXJLMnVXbUtybjlm?=
 =?utf-8?B?REtKZEtsSzFNTVlnWXZibHBFLzJESS95cy9nbVQ0T3BLejY0c1phTkpWWGxY?=
 =?utf-8?B?R0xnQ0dncGg3Y1Zob1htVldSbTRxVmQ5aFNpY3lMaHRneUU4YTFGazUxLzAx?=
 =?utf-8?B?SHBvc0xSTGdETjFBNll6cytCQWJuOVk0ZG9Rcml3c0dqWGF5SkFHQTA3bXd0?=
 =?utf-8?B?MHR5U3RIUXMzQytpa3hzVTlLVUVXL3JyNk1DeHVGUVQ0TzBaaENjai9pcCsw?=
 =?utf-8?B?dlhpY2J1Z1NLaWhpYkdtME05OG1uV0M0YTFraXBPcWFkb0VOSks5ZTBxR2wx?=
 =?utf-8?B?WHZRSFZWQzZGT1Y4WldLK3FTNnJ0SXd4K2FRdDg3Z25CaytyRGZOTnZDMnhD?=
 =?utf-8?B?VWhUTTExNUtvNlA3WUpoUmlBSmpjY3FWTzRYWDZZNU9WdjJxanlxdzJPOG1l?=
 =?utf-8?B?em5OM2NCYTNhZ1RzZCtGVmJldVRJWTBHa3g0ZVZnYW1vcTRxRXkvQnBJQU9r?=
 =?utf-8?B?VjdaTjg3UlZUdFNOQWxRalFTMTNIeDlQYUIzeTNIZkJWL3NvMGxRMGFGWjFv?=
 =?utf-8?B?RjhRbHYrQVFnK25CTkxFV1h5dDBwVmhVMk9XUTJMeksvWGNzd0JHbFR5RGlw?=
 =?utf-8?B?Y2dnM1ZMSER2MlJZaW5hamRJMVBqSWlnNmdKMVRpM2s1UVlNbUVLNzViQ1M2?=
 =?utf-8?Q?FOfA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzhKbHlFMTBDVVE4UytqamtEaVdKc2pSUmVKUzlTdHJWZGRYbXNsdTJObXhh?=
 =?utf-8?B?TnVFYXI4TXM3NTlzdVBaa0s0aUFUa25tcStKdlA2R1AwOG45QXdhVXliaEJN?=
 =?utf-8?B?T3ZRS2Z4Ukt3T0F5MFFEWHAreUdrM2dNZWp5V0VDSWw3ZGljY3BvV3BzbGVr?=
 =?utf-8?B?amtvSHkwbXNnUzJvUWc4QndCb2xrUFg1VGFqSUlmMHNZVEZtT0E3cndoMFVy?=
 =?utf-8?B?UlQwY3Z0cU5jbEZEVlNjSkxGamhYRzM5c2p0eHpwb1NWOXhyQzZTeWN1Wkpo?=
 =?utf-8?B?ODZBY2gxcHVQTWpaZnBvNWlmWU5MMnVJb25XTzJpUFBJd093R3EwVGw1T1JL?=
 =?utf-8?B?eTMrM1M2dVVHQUNjMlVCNHBQdkNjZHNqd3JKb3l0dExLMlpGcTlIQUdVeERw?=
 =?utf-8?B?NzlDRGxESlJmK05OTk9yb2Vnems4Z3p6OXd1TjNXc3pjVEpKM3JqS0s4YURI?=
 =?utf-8?B?NWdJanE5K2RzMjRUR3plN2JHc3IyS2hlTXJRWVVEZ1V3MW9KY0kycCszZ3l5?=
 =?utf-8?B?WHJvb2JOWDF4QTYrZlVucHMxZVZKM1Y1bjQ2cUN0UHRTTzdBVDlyMU4rckJC?=
 =?utf-8?B?dWkrOTgvcFp4c2hTcW1vVWhHT1ZSTlVKU09zQjN0KzRUcVdaR2huNVoxU25V?=
 =?utf-8?B?S082VmNIdVJZRi9Fb1F2WUkyOGFnYkpyU2k5bHBQSDNCclpIN2Fibk1DaExj?=
 =?utf-8?B?UG5PMkwyOEZMT3lhQnZJVzZpY0lOVDVGaVJZSnc1QnVtbUxYelZGaDJUbEVI?=
 =?utf-8?B?ZjBXVzM4Y2JGbTZxMHErT3QrbDcwWTg5RldzM2thcHlOcmlxa3NqYm9QbWpr?=
 =?utf-8?B?UXErUUZPTFRUa28yL3lWZGsrUGlYblNmUTZvZDNBQTZpYkVSMmU2NENNRWYx?=
 =?utf-8?B?NU1iNVJFTjh4YVBzcVlMZGpJTndYZk5RdTlRSEdXZnRBdENKUHlBSzQ5NVJ6?=
 =?utf-8?B?bXBYOHpybkFxMDdReW5RTmo3dmhic2dIUi95TVg1QklRTUZIUkszSDQ1MnRL?=
 =?utf-8?B?SEg2YThFVzE5bEdnNTQ0TDNQYldwUEcvSjRGUlZ5SXh1VWM1emdKZCt1ek94?=
 =?utf-8?B?WC9JZ2p4K2dvN3lwamg2akN0aTUrbFBhZitDZllBRytQTzVMYmdCZXIyKzlY?=
 =?utf-8?B?Vk8vZW04a2dWcGlWZ3ozOHhIS1IvTWxWRlg2QWtjUlA5bGg4N1JZQXZML2U0?=
 =?utf-8?B?ZWYxMlBidk5kRU4zSkVEai9icnlycXV2aDltY0RsRmtlenMxeFBMd2piU1da?=
 =?utf-8?B?SVVmMTc1ZTdsczNuVDFGNHFpRnpSMEtpTVU5Qlhnb0hodmJnZ3o3YkNoUjY4?=
 =?utf-8?B?YTZzK2JYSXRTak83QStOUmw2Mi9PNDJ1ZlNkQVdmTDVWOVBYWTBoNGZLeEN2?=
 =?utf-8?B?VVo2QVFMbVM1d1lTalRIOGIzV1o2Z044bStsR1JUQW81eEV6c1RjTFdmSzhp?=
 =?utf-8?B?THRPRVZvUXlEWnd1RHEvZjg1L3IwS3RCbVAyOHkwMFByVTd5ak04dDIxeGpw?=
 =?utf-8?B?cWxQVytLd0RURTZNdDk2dGttWm1iR0lPRHM3ZXAxQm96cExpYkdoTnlQeTFk?=
 =?utf-8?B?V2tMQUN1YVJhbWZLMlVRV0gybHRXK2RoNm1qQ2V6eFpXdHJUaUczSWQxVHBt?=
 =?utf-8?B?NS92OURoamJqTGViVEJuL213VDA4NkhLY2RsTVhQN2h2aGNaZ3praGZHM09p?=
 =?utf-8?B?V1Q1TDhqZG1UWElTTVNoenVaVW1wM0t3aE5NbzQva1p5ZUNFOEhZcmJoK1Zm?=
 =?utf-8?B?RDNDeUhVM0pKZmpKVWpSMnVFQWVPdk96cFZ4ODcrdm1BQXREVEpGRUtXSDhn?=
 =?utf-8?B?d0VJZTA1cWdhRG9Kb3BTMnQ3L3VtMUc3Qkg4aVpQd0tzT3lIeE9WQWh0SXhJ?=
 =?utf-8?B?RUdIbzVIOG10YytWV0hITnBjWnpqaG9IdzROTWJDMzhDUnpZKy8rYmJzd3J2?=
 =?utf-8?B?VkhWQzBScCs1dlQ0eE5GUDZsbHJLNllMTlhoRVJCWjZYY1hxQXpFay85ME1S?=
 =?utf-8?B?VXhDQXZKbU1hZ0d6S21wb0xndnBWbFpXSzdIV21oWHRQKzRUb2FoclhZY3pz?=
 =?utf-8?B?R0s5SHFwaWVGMzdTOWV2N0kxNUY5NjlYa2ZRQm1pelNxRWJ0T2luMFhreGR5?=
 =?utf-8?B?S1hoRDlkbloveE90MHhjTEFLNVVLZ3BYb2xjZjRWYXoyMW5qZEcrcSt6OWxJ?=
 =?utf-8?B?VWpXR3BYSjhQY1NiRFlmS2NIQndoRWVSaVZnaktGOHNYbWRUK3AxcDcrcS92?=
 =?utf-8?B?aDJiNFhQeWNkSjllU092VDJ4SjllSTU4c2xVN0dhOXhDbnU4YXJkWXJndGFu?=
 =?utf-8?B?YisrVmkzYm9nT0gyYzI2UlZYSy9Lek1BcjVra1FQVThrc0xKeG9vQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424b55ac-1f6e-498e-7d69-08de6995605e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 17:45:43.5899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lB24Tsv+oUH+0hYgsnFN1BDB13OuZf+weAQ9i8Z/UebAWxC/DGNCbmq9gimpv3icd9oStCRo1S68oliluTNtsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8570
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=avihaih@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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


On 2/11/2026 3:16 PM, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> Hello,
>
> On 2/11/26 14:01, Avihai Horon wrote:
>>
>> On 2/3/2026 7:25 PM, Avihai Horon wrote:
>>>
>>> On 2/3/2026 7:02 PM, Peter Xu wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On Tue, Feb 03, 2026 at 05:48:11PM +0100, Cédric Le Goater wrote:
>>>>> Peter, Fabiano,
>>>>>
>>>>> Do you think it would be interesting to send VFIO migration events
>>>>> by default ?
>>>> No objection here.
>>>>
>>>> IIUC it's a matter of why it got introduced with default off in the 
>>>> middle
>>>> of 2024?  If it's about compatibility of any old mgmt which may be
>>>> surprised by these events, then we want to know if they're ready, 
>>>> and then
>>>> if we need a compat field for it in older machine types (or enable 
>>>> it even
>>>> with old machines).
>>>
>>> I disabled it by default back then because it was only needed for 
>>> the use case I mentioned here (specifically, it wasn't needed by 
>>> libvirt).
>>>
>>> I guess you can either leave it as is or enable it by default, it 
>>> won't matter.
>>>
>>> Thanks.
>>>
>> Hi Cedric,
>>
>> Are we good here?
> Yes. Sorry I should have said so. It's queued. I don't have much
> for a PR, so this will wait a bit.

Great thanks!

>
>
> As for enabling the VFIO migration events by default, I guess we
> all agree it could be done. We simply need a stakeholder to change
> the default behavior.

Ack.

Thanks.


