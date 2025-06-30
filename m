Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07143C83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 06:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW8GL-00060E-Ru; Mon, 30 Jun 2025 02:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tan@siewert.io>)
 id 1uW8GD-0005w1-NK; Mon, 30 Jun 2025 02:45:01 -0400
Received: from mail-germanynorthazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c20b::1] helo=BEUP281CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tan@siewert.io>)
 id 1uW8G9-0000Ql-Vr; Mon, 30 Jun 2025 02:45:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mhr6LKQJTg8jdYK0G9xnTUfgs4+LwbaBpGUmXdLHt43BAYungx2l0KB7ETQ6YTZ3pFpO+laZMKeCpD/ELjKCCWXsEsjpPvzBxODIs3MowVgU/zaUIgqbAwsCR+tUvio027qPlhp6b4QAbtuGQcA859H9Ie3ksHN5qmWqP7YM89em8vWNoaFiT090vgxcb305wwoQEDXtBjWiYMud3th+fMz+ges1oLKj8OVD8nQJZEiEMzayd3NlTK5L5naekWuXgAf+4uwEqZ/uozHDcCAODZmTQ08nZ4k2qDSRJJsfCvR8B2GO+Gf1hS2DpEtUmBK5DAiAgPnp8uUxW4kWEqzIJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nC2EtOhTiSH8TR2YgYxdEJfln68vjbk1IZK5qOcws0=;
 b=cA+1pq+bhHk/W5gWHAxzUxC/FgAV11wtsqXpeshGFseYi7ckJnwSPaojMgiSwEBEdID+fG/U8J2Sp0wFB90tTdMyxO4Z2MuSvF58nKlhxL3+PYbdFZqh8C07Z5asOr2/hXDgCAev/5Dv96wxO57ScdD7d+mvuu1duWTvp8igTEvifY+JQ1vy+tUOjwoDaLVaR/hphRv4tlhKiiPNzStuOVcGeF2Dlu6ZZT5QO83oMhaYn5oPAZqyuSPGA/IPqKF2j+ksJvIYQfr1v3ntI2BdoICtan59uoDm5SYwVlIVScqORZMfYX83gF4DQf3pjAaUPfeTloudlNEfEUDDgUxwmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from BE1PPF7DB70B163.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b18::65f)
 by BE1PPFAB05DADC8.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b18::68a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Mon, 30 Jun
 2025 06:44:50 +0000
Received: from BE1PPF7DB70B163.DEUP281.PROD.OUTLOOK.COM
 ([fe80::5c4:893c:2523:a442]) by BE1PPF7DB70B163.DEUP281.PROD.OUTLOOK.COM
 ([fe80::5c4:893c:2523:a442%3]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 06:44:49 +0000
Message-ID: <2b9f9020-743c-43b3-8cb5-ff7b16ebe431@siewert.io>
Date: Mon, 30 Jun 2025 08:44:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: Add test for ASPEED SCU
Content-Language: en-GB
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250629135405.73117-1-tan@siewert.io>
 <54aa55bf-376b-4eda-8a78-b6d20e1cf8aa@kaod.org>
From: Tan Siewert <tan@siewert.io>
In-Reply-To: <54aa55bf-376b-4eda-8a78-b6d20e1cf8aa@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::15) To BE1PPF7DB70B163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b18::65f)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1PPF7DB70B163:EE_|BE1PPFAB05DADC8:EE_
X-MS-Office365-Filtering-Correlation-Id: 78159ec5-7802-4b3d-558b-08ddb7a19c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlRSa1RJb1ZqdlhSS1VpSXdQUm9nbHVvaUsvVGlHNExSbUgzSWtCQng2UXlF?=
 =?utf-8?B?MTNMOWRmckQ1Rk1vV3B5KzFDTHdjTkhKUzZVK1BCeFBjdE5MV3lBTW84dDdH?=
 =?utf-8?B?WWdiRThBTS9zVFIwMFJHZzBYWXRTOVFmUnlCenF0MXpNTkt2Q2orVDBDQ0Ix?=
 =?utf-8?B?cVV5YjBWSmZoWDdid0VIaUQzbU9ML0FadGhxYk5lVjNKM05raHFiLy9SeGVj?=
 =?utf-8?B?TVZZTGxCMWxZOHFzM05NWGY2eVoyOW1mYzVveE1WdmpCL2xrN3NrUlF6Z0g2?=
 =?utf-8?B?VnIyajZ3RjhYc3l5eEE0S3pOV1RoN0RwVzlCVUJ1cTBmNDNtSlBKZW9xd1RM?=
 =?utf-8?B?ak8rUElKVy9OYlA3RkZuQXZRUjBhVHREbFlKRWMzZlF0RGdONHVMMHBRSlNm?=
 =?utf-8?B?QVlYcWsxZHJlaGs0ZHQ5ZkE0dnBHT3Q1OEpTMTlMMW9YMTVrWndQcGlxcHoz?=
 =?utf-8?B?enQvYnlTRVlWVzg3ZzVtTnhrQm5TSFpVeC9ZT2pLQ0RIMUI3bHdMWUxwbmRr?=
 =?utf-8?B?eWFHZmxZV2FVZHpiMHNJakFpbmlsdlcwQk1udmZUOWE4SDdyZmdYV0VyTmVH?=
 =?utf-8?B?Vko2VjZFN0J0eStKUm5wTDlkZ1ZuM21pZEgzais1NHh2aTV3TFRHb2Vtemk3?=
 =?utf-8?B?Q2VwMWtIY0lUTS9XWVduZHQ2NForZDVFS0RubTlWTWxkR2J6MSttQ3VmSy91?=
 =?utf-8?B?dWJUcHJ4UWlsRjBQMzYwczkwaXdSdmRHRDUzQTY0VXRpc3o4SUFqbTlacWQr?=
 =?utf-8?B?M2dnWDVwZy9iNkU5ZDdzbUFyWHZJSXBMYU9lczVUaERzbjJQWVNpMllIT0VC?=
 =?utf-8?B?VzhDWVpLY2tWcDVOMXJKcktDdXdlRGVNZjBrMkFCd2dCZEZxQ1F6Wnc2N2lL?=
 =?utf-8?B?b0dNZVlnNmlkTzVLdHlQamR3VHBkOS9lcjhlZTh5VDN4bEFwa0w0LzdYME9r?=
 =?utf-8?B?b2xjWEk3cmFETE4rWXViSE0zL0tkWnpCeHNYVzNQSGp0VDl3RW5RNURJTUgz?=
 =?utf-8?B?OU55WFlIVTBQdWpPN0c3OE1uWUU5a0VjZFlsb1B0L3AxN0RQYU8ycTg3RGEx?=
 =?utf-8?B?Ri9VYzlKZ21ocnRVSzBPaW5Tcmxtd0NjRjJaVnVDTURscE5CbjZKY1dNRGZs?=
 =?utf-8?B?dGt3TStYQWMrUmdSZVIyYlpwVS9YQ2lUeFNRVlRlbHU1OFRnV0pTYmFnN1Ni?=
 =?utf-8?B?ejNXZUV3d2U1djR1UTRIVkxWTVlSQTArY0I5dnF2S2o0TnFRTkZsdFVUaTF2?=
 =?utf-8?B?MHpoeXBZYWdCZ0pQbkNSRktqM3E2ZlB6T3MxakV0QWs3N0p6VmZLd00vWHVy?=
 =?utf-8?B?d1pJUnhBMko0NElqMEJpU1J2R2JXZmRXemF3Z09MKzF6ZDhHWTBUOXNCUUdL?=
 =?utf-8?B?dUpFaG9YZmFFaFpBbi9mc2JwMUQ1TVR1dCtXdktTNS9TZjBEL3RQSExaRVZz?=
 =?utf-8?B?YzEvNW1pczhYQ2VlS2tWZSt6cURhU3N1QUxaemlDalh0Q1NqckN2ZStvSEQz?=
 =?utf-8?B?b3ZWdWdER3Nhc0xtaGpaY2hlbE9GL2Zwd3g5SkhiTVRCeG0zKzQ4QTJNbUtj?=
 =?utf-8?B?Yk1pUHdXV1RoSmdyTWYvRnBEbmtBWWpwK2s0NDhNdWVFL1liL092ZFl5V0lB?=
 =?utf-8?B?U1RJNDlTb2NvUDM4blF1ZE5NUmNpWVlLblZXR2hTSk82UTNZeFlrOEwyOTVm?=
 =?utf-8?B?VWx5dzB2NjJsSVNRNFRPQ1hHcjdEMjZBekk1OU5nOEpvb08wSG9JWnM3Ym5H?=
 =?utf-8?B?SFdRNURFYm1TVUJsUEVYZGplbXFJYXlRSVcyLzU0TnNTMWdlQWlsK2gzTC9C?=
 =?utf-8?B?UHZWZXNvR1lQcG11NUZscjB3aW5lSXUzdjNvcnJ1NzJpZDBhQTZBQkJiYklB?=
 =?utf-8?B?S0RZcERoTFNiZXMwNFV1czF3Wk5Nemo1ZjdWVnQvcVZabUY3dWNRZ3lNYUZJ?=
 =?utf-8?B?OHViZ05pa3hzaHRiY3NyMlFuUklRS1RoVVFFQjQ1VmtnMjdsZ2RWbEhacFRu?=
 =?utf-8?B?N3lUZjYxRllRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BE1PPF7DB70B163.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020); DIR:OUT; SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3I2QVB3NzBUaDhINE9kU2hiT2JTamVCYlhPZDBqYUFSaDkvSDYwS2hPdVRT?=
 =?utf-8?B?NFpVYkVkakV2NnAzY3RMeHAxc0JPUVVqN205ZzlEUyswYTZlZDQ0S0sybnNI?=
 =?utf-8?B?SjNLbnVqbDJxMmpPaGNQdXZTcHhaTFBOc3E2aFk4Y2hXeWdVVmJtTmNBaVhD?=
 =?utf-8?B?Sy9Kc3BaK0JpSTM2UUkway94aFl0ZFp2NzM1dDBsbjFRVWhUT0cxaXBiMjhF?=
 =?utf-8?B?Z0hMV3JYcnRhakRPU0tLcDUxQkJlWjV0dnRQS0VtQ2ZFV1BaR3M3SDVOM2lF?=
 =?utf-8?B?WmcralZVM2NrL1BPNkQ1N2NlWjVJdmJDNjMrbmJzTnZHcU01eE1qUHQxeDNq?=
 =?utf-8?B?K3psNmNHcHJTbDQ4WlNYTExBT05kUlNmQ2dreHdENzg1RnJxNEtIRk9WelZB?=
 =?utf-8?B?N3J4OTkzSlRybm9tb3d2K09maDJLT2lCeWZWSVUvcFdVdVR1NlNrcjdrUzBG?=
 =?utf-8?B?dGhweFFKSzBrQUN4RGVxNUhWUFdiOUdQTmVBSGQzRTY1cVFXMlFoZWFRcldi?=
 =?utf-8?B?UFdidzZrYy91SFJOdU1idFZjVitSSTNKenRMK24velZSR3owN1BNZnJvVEhK?=
 =?utf-8?B?dmpZNWMwcXZlbFBCWHRIWklXUG8wT3NrRVM0STFMMTZ1SHdMWExBSFNPaGVr?=
 =?utf-8?B?UlNnWmlRWGp0MTFwWGZpK1kvUWNKNjZTNUUxdlN4bkhad3ZxZnVPVHBLQlpz?=
 =?utf-8?B?UEt2Sjk1Mm5STXUreWtTZHpPcmw0d3NvQ0ZYOGxQZHF2cko1STJQK1VRU2Ro?=
 =?utf-8?B?dTZaTTIyZFM3NEZYQkw4SzdhZzF4d3JXbnUzS1E2eHRHdS9PdFp1eHM1WHZp?=
 =?utf-8?B?dlJ0RXErbkQ1TGVDZnFvMWJuc1RlRHRHcVJWdS9xNjNpTmxRVWR5bmtabkZ0?=
 =?utf-8?B?UnBTSFNXb28vQ3ZpWk95NSsvS0lCZ0pObW9sS1VVWkdqaXltdmZhZDM2blNa?=
 =?utf-8?B?K2VncGxjVWJSWE8vbHlEaExjdDByMGdtT2xpMnFuT1BIMDlkZzZVNnp1NlZQ?=
 =?utf-8?B?R3FXRnhrOStMOEZDUVBCc000QjFJKzY0b3RkV0RjQXdwejZlVjFneDRkWlIx?=
 =?utf-8?B?bmwrTFlBOGpNOUp5Y1Jhc2Vtc2wvWHhQL1JwbEFzUjhMRU9PeVFqOHk4bWU5?=
 =?utf-8?B?eEpZdVhtZGRzaERXZjdwRFZ6UkNXVGtzWGVRUkpZRmtucU84QWsxcE9xUUNK?=
 =?utf-8?B?cHNTczJyaW1KYWJmMFN0S2E1dzN3L3lrSGJXQVBwcDRGTlFHaUpMNFlSY1F5?=
 =?utf-8?B?dWZFTG9oWVJkS3liVlBpNXY0cWt5cWR0eGJ4MWdKQjlXcllCZzZlRW40VE5i?=
 =?utf-8?B?OURTeERnS2lQVDJTZmlmTm4wdjZEdm9Qcm9qR25ISGtOcWVjRWQzaTR1WE9W?=
 =?utf-8?B?Q2ZKdTV5RHhIWGs5bkhFR2hRVDVha01Ka2h4aVdJV1ZmbEtUdTdqZDZqcktB?=
 =?utf-8?B?TEE1RlN5ZGJadU1IVnRrQVhhZ2g1SnhKQkwyOWp3dVV4bDZKR0dMZHcwdHhN?=
 =?utf-8?B?M2NmOTZKMDhpVXNoSWlnNVpLN2w3WGJxN1FoeDJaaUxWKysvbjhhZ2NvZ1lQ?=
 =?utf-8?B?SERHaytxRmVGd285RDN3WlpGNm4xSHRFYUVlYTc4bXpZWlIvZ1huclBWR24x?=
 =?utf-8?B?ZG1BZm5WVVM1Ylc5NmFnRUorSUdPMHNmQ0I4UjUxRDZnWmErSmpNM3VjR3VY?=
 =?utf-8?B?N1l0MTlremcwR0ZYKzErbFVmWEduZzdrNjZJSnNJTDdLa0ZzQTcxNEhNTGJx?=
 =?utf-8?B?aGJ3bkNVZkYvRzJPK0c0QUtBZTRWbTZvOWVzUThKMVFSb2FpWTRCbk9hNUx2?=
 =?utf-8?B?amFNTk1ndTFzak5XM01xZWhMUVRkT00vVXdFc3ZVRU0yV1hFRHE3Zk13L3NX?=
 =?utf-8?B?Y2JKejJIU3NKYS92VUYwemlFbVNNV0E0RWg5TUM5MHBxUVRQUkg0bUtDMmFh?=
 =?utf-8?B?VTluamplN1dFUW5hNUhiWkJudjV0dXY2TlB0cjFTR3FxVjRvVlNPMHpVVzJQ?=
 =?utf-8?B?UG5JYUNrN0kxUklsTmdlV3JsYTFVTVdLTjZkVmZsNnVQa09CUERRN21iN3Uv?=
 =?utf-8?B?ZEFoZ1JzVk5PZ0cvZXNGeFZxcmIxWUI1Q3ZVQzJvd2EwU1BHOHBHaEFnZTRy?=
 =?utf-8?Q?3/II=3D?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 78159ec5-7802-4b3d-558b-08ddb7a19c2b
X-MS-Exchange-CrossTenant-AuthSource: BE1PPF7DB70B163.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 06:44:49.6305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQxfEBxyNq3lutLhYXv/QpAO2TfFHzcC65giNDV+vAUxGUb2T+1VmnxdFPLMnYv0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1PPFAB05DADC8
Received-SPF: pass client-ip=2a01:111:f403:c20b::1;
 envelope-from=tan@siewert.io;
 helo=BEUP281CU002.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

Hi Jamin,

On 30.06.25 08:37, Cédric Le Goater wrote:
> Hello Tan,
> 
> On 6/29/25 15:54, Tan Siewert wrote:
>> This adds basic tests for the ASPEED System Control Unit (SCU) and its
>> protection mechanism on the AST2500 and AST2600 platforms.
>>
>> The tests verify:
>>    - That SCU protection registers can be unlocked and locked again
>>    - That modifying the primary protection register on AST2600 also
>>      affects the secondary one
>>    - That writes to protected SCU registers are blocked unless
>>      protection registers are unlocked explicitly
>>
>> These tests ensure proper emulation of hardware locking behaviour
>> and help catch regressions in SCU access logic.
>>
>> Signed-off-by: Tan Siewert <tan@siewert.io>
>> ---
>>   tests/qtest/aspeed-scu-utils.c |  22 ++++
>>   tests/qtest/aspeed-scu-utils.h |  38 +++++++
> 
> I think adding these two files is a bit over engineered.

Agreed, I was a bit skeptical too if this may be too over engineered or not.

> Could resend a v2 without them ? Unless you have plans to extend them
> with AST2700 support for example ?

Due to missing datasheet for the AST2700, I can not implement proper 
tests for this platform yet.

I'll remove the `scu-utils` in v2.

Q: Are you more concerned about the helper methods or the separate 
`scu-utils` file? If the helper functions are fine, should they be 
marked as `static inline`?

Cheers,
Tan

> 
> Thanks,
> 
> C.
> 
> 
> 
>>   tests/qtest/aspeed_scu-test.c  | 197 +++++++++++++++++++++++++++++++++
>>   tests/qtest/meson.build        |   4 +-
>>   4 files changed, 260 insertions(+), 1 deletion(-)
>>   create mode 100644 tests/qtest/aspeed-scu-utils.c
>>   create mode 100644 tests/qtest/aspeed-scu-utils.h
>>   create mode 100644 tests/qtest/aspeed_scu-test.c
>>
>> diff --git a/tests/qtest/aspeed-scu-utils.c b/tests/qtest/aspeed-scu- 
>> utils.c
>> new file mode 100644
>> index 0000000000..9083827b98
>> --- /dev/null
>> +++ b/tests/qtest/aspeed-scu-utils.c
>> @@ -0,0 +1,22 @@
>> +/*
>> + * QTest testcase for the ASPEED AST2500 and AST2600 SCU.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + * Copyright (C) 2025 Tan Siewert
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "libqtest-single.h"
>> +#include "aspeed-scu-utils.h"
>> +
>> +void assert_register_eq(QTestState *s, uint32_t reg, uint32_t expected)
>> +{
>> +    uint32_t value = qtest_readl(s, reg);
>> +    g_assert_cmphex(value, ==, expected);
>> +}
>> +
>> +void assert_register_neq(QTestState *s, uint32_t reg, uint32_t 
>> not_expected)
>> +{
>> +    uint32_t value = qtest_readl(s, reg);
>> +    g_assert_cmphex(value, !=, not_expected);
>> +}
>> diff --git a/tests/qtest/aspeed-scu-utils.h b/tests/qtest/aspeed-scu- 
>> utils.h
>> new file mode 100644
>> index 0000000000..9cc7e3e113
>> --- /dev/null
>> +++ b/tests/qtest/aspeed-scu-utils.h
>> @@ -0,0 +1,38 @@
>> +/*
>> + * QTest testcase for the ASPEED AST2500 and AST2600 SCU.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + * Copyright (C) 2025 Tan Siewert
>> + */
>> +
>> +#ifndef TESTS_ASPEED_SCU_UTILS_H
>> +#define TESTS_ASPEED_SCU_UTILS_H
>> +
>> +#include "qemu/osdep.h"
>> +#include "libqtest-single.h"
>> +
>> +/**
>> + * Assert that a given register matches an expected value.
>> + *
>> + * Reads the register and checks if its value equals the expected value,
>> + * without requiring a temporary variable in the caller.
>> + *
>> + * @param *s - QTest machine state
>> + * @param reg - Address of the register to be checked
>> + * @param expected - Expected register value
>> + */
>> +void assert_register_eq(QTestState *s, uint32_t reg, uint32_t expected);
>> +
>> +/**
>> + * Assert that a given register does not match a specific value.
>> + *
>> + * Reads the register and checks that its value is not equal to the
>> + * provided value.
>> + *
>> + * @param *s - QTest machine state
>> + * @param reg - Address of the register to be checked
>> + * @param not_expected - Value the register must not contain
>> + */
>> +void assert_register_neq(QTestState *s, uint32_t reg, uint32_t 
>> not_expected);
>> +
>> +#endif /* TESTS_ASPEED_SCU_UTILS_H */
>> diff --git a/tests/qtest/aspeed_scu-test.c b/tests/qtest/aspeed_scu- 
>> test.c
>> new file mode 100644
>> index 0000000000..75d6a800a6
>> --- /dev/null
>> +++ b/tests/qtest/aspeed_scu-test.c
>> @@ -0,0 +1,197 @@
>> +/*
>> + * QTest testcase for the ASPEED AST2500 and AST2600 SCU.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + * Copyright (C) 2025 Tan Siewert
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "libqtest-single.h"
>> +#include "aspeed-scu-utils.h"
>> +
>> +/*
>> + * SCU base, as well as protection key are
>> + * the same on AST2500 and 2600.
>> + */
>> +#define AST_SCU_BASE                    0x1E6E2000
>> +#define AST_SCU_PROT_LOCK_STATE         0x0
>> +#define AST_SCU_PROT_LOCK_VALUE         0x2
>> +#define AST_SCU_PROT_UNLOCK_STATE       0x1
>> +#define AST_SCU_PROT_UNLOCK_VALUE       0x1688A8A8
>> +
>> +#define AST2500_MACHINE                 "-machine ast2500-evb"
>> +#define AST2500_SCU_PROT_REG            0x00
>> +#define AST2500_SCU_MISC_2_CONTROL_REG  0x4C
>> +
>> +#define AST2600_MACHINE                 "-machine ast2600-evb"
>> +/* AST2600 has two protection registers */
>> +#define AST2600_SCU_PROT_REG            0x000
>> +#define AST2600_SCU_PROT_REG2           0x010
>> +#define AST2600_SCU_MISC_2_CONTROL_REG  0x0C4
>> +
>> +#define TEST_LOCK_ARBITRARY_VALUE       0xABCDEFAB
>> +
>> +/**
>> + * Test whether the SCU can be locked and unlocked correctly.
>> + *
>> + * When testing multiple registers, this function assumes that writing
>> + * to the first register also affects the others. However, writing to
>> + * any other register only affects itself.
>> + *
>> + * @param *machine - input machine configuration, passed directly
>> + *                   to QTest
>> + * @param regs[] - List of registers to be checked
>> + * @param regc - amount of arguments for registers to be checked
>> + */
>> +static void test_protection_register(const char *machine,
>> +                                     const uint32_t regs[],
>> +                                     const int regc)
>> +{
>> +    QTestState *s = qtest_init(machine);
>> +
>> +    for (int i = 0; i < regc; i++) {
>> +        uint32_t reg = regs[i];
>> +
>> +        qtest_writel(s, reg, AST_SCU_PROT_UNLOCK_VALUE);
>> +        assert_register_eq(s, reg, AST_SCU_PROT_UNLOCK_STATE);
>> +
>> +        /**
>> +         * Check that other registers are unlocked too, if more
>> +         * than one is available.
>> +         */
>> +        if (regc > 1 && i == 0) {
>> +            /* Initialise at 1 instead of 0 to skip first */
>> +            for (int j = 1; j < regc; j++) {
>> +                uint32_t add_reg = regs[j];
>> +                assert_register_eq(s, add_reg, 
>> AST_SCU_PROT_UNLOCK_STATE);
>> +            }
>> +        }
>> +
>> +        /* Lock the register again */
>> +        qtest_writel(s, reg, AST_SCU_PROT_LOCK_VALUE);
>> +        assert_register_eq(s, reg, AST_SCU_PROT_LOCK_STATE);
>> +
>> +        /* And the same for locked state */
>> +        if (regc > 1 && i == 0) {
>> +            /* Initialise at 1 instead of 0 to skip first */
>> +            for (int j = 1; j < regc; j++) {
>> +                uint32_t add_reg = regs[j];
>> +                assert_register_eq(s, add_reg, AST_SCU_PROT_LOCK_STATE);
>> +            }
>> +        }
>> +    }
>> +
>> +    qtest_quit(s);
>> +}
>> +
>> +static void test_2500_protection_register(void)
>> +{
>> +    uint32_t regs[] = { AST_SCU_BASE + AST2500_SCU_PROT_REG };
>> +
>> +    test_protection_register(AST2500_MACHINE,
>> +                             regs,
>> +                             ARRAY_SIZE(regs));
>> +}
>> +
>> +static void test_2600_protection_register(void)
>> +{
>> +    /**
>> +     * The AST2600 has two protection registers, both
>> +     * being required to be unlocked to do any operation.
>> +     *
>> +     * Modifying SCU000 also modifies SCU010, but modifying
>> +     * SCU010 only will keep SCU000 untouched.
>> +     */
>> +    uint32_t regs[] = { AST_SCU_BASE + AST2600_SCU_PROT_REG,
>> +                        AST_SCU_BASE + AST2600_SCU_PROT_REG2 };
>> +
>> +    test_protection_register(AST2600_MACHINE,
>> +                             regs,
>> +                             ARRAY_SIZE(regs));
>> +}
>> +
>> +/**
>> + * Test if SCU register writes are correctly allowed or blocked
>> + * depending on the protection register state.
>> + *
>> + * The test first locks the protection register and verifies that
>> + * writes to the target SCU register are rejected. It then unlocks
>> + * the protection register and confirms that the written value is
>> + * retained when unlocked.
>> + *
>> + * @param *machine - input machine configuration, passed directly
>> + *                   to QTest
>> + * @param protection_register - first SCU protection key register
>> + *                              (only one for keeping it simple)
>> + * @param test_register - Register to be used for writing arbitrary
>> + *                        values
>> + */
>> +static void test_write_permission_lock_state(const char *machine,
>> +                                             const uint32_t 
>> protection_register,
>> +                                             const uint32_t 
>> test_register)
>> +{
>> +    QTestState *s = qtest_init(machine);
>> +
>> +    /* Arbitrary value to lock provided SCU protection register */
>> +    qtest_writel(s, protection_register, AST_SCU_PROT_LOCK_VALUE);
>> +
>> +    /* Ensure that the SCU is really locked */
>> +    assert_register_eq(s, protection_register, AST_SCU_PROT_LOCK_STATE);
>> +
>> +    /* Write a known arbitrary value to test that the write is 
>> blocked */
>> +    qtest_writel(s, test_register, TEST_LOCK_ARBITRARY_VALUE);
>> +
>> +    /* We do not want to have the written value to be saved */
>> +    assert_register_neq(s, test_register, TEST_LOCK_ARBITRARY_VALUE);
>> +
>> +    /**
>> +     * Unlock the SCU and verify that it can be written to.
>> +     * Assumes that the first SCU protection register is sufficient to
>> +     * unlock all protection registers, if multiple are present.
>> +     */
>> +    qtest_writel(s, protection_register, AST_SCU_PROT_UNLOCK_VALUE);
>> +    assert_register_eq(s, protection_register, 
>> AST_SCU_PROT_UNLOCK_STATE);
>> +
>> +    /* Write a known arbitrary value to test that the write works */
>> +    qtest_writel(s, test_register, TEST_LOCK_ARBITRARY_VALUE);
>> +
>> +    /* Ensure that the written value is retained */
>> +    assert_register_eq(s, test_register, TEST_LOCK_ARBITRARY_VALUE);
>> +
>> +    qtest_quit(s);
>> +}
>> +
>> +static void test_2500_write_permission_lock_state(void)
>> +{
>> +    test_write_permission_lock_state(
>> +            AST2500_MACHINE,
>> +            AST_SCU_BASE + AST2500_SCU_PROT_REG,
>> +            AST_SCU_BASE + AST2500_SCU_MISC_2_CONTROL_REG
>> +    );
>> +}
>> +
>> +static void test_2600_write_permission_lock_state(void)
>> +{
>> +    test_write_permission_lock_state(
>> +            AST2600_MACHINE,
>> +            AST_SCU_BASE + AST2600_SCU_PROT_REG,
>> +            AST_SCU_BASE + AST2600_SCU_MISC_2_CONTROL_REG
>> +    );
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +    g_test_init(&argc, &argv, NULL);
>> +
>> +    qtest_add_func("/ast2500/scu/protection_register",
>> +                   test_2500_protection_register);
>> +    qtest_add_func("/ast2600/scu/protection_register",
>> +                   test_2600_protection_register);
>> +
>> +    qtest_add_func("/ast2500/scu/write_permission_lock_state",
>> +                   test_2500_write_permission_lock_state);
>> +    qtest_add_func("/ast2600/scu/write_permission_lock_state",
>> +                   test_2600_write_permission_lock_state);
>> +
>> +    return g_test_run();
>> +}
>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> index 8ad849054f..7713fae885 100644
>> --- a/tests/qtest/meson.build
>> +++ b/tests/qtest/meson.build
>> @@ -215,7 +215,8 @@ qtests_npcm8xx = \
>>   qtests_aspeed = \
>>     ['aspeed_gpio-test',
>>      'aspeed_hace-test',
>> -   'aspeed_smc-test']
>> +   'aspeed_smc-test',
>> +   'aspeed_scu-test']
>>   qtests_aspeed64 = \
>>     ['ast2700-gpio-test',
>>      'ast2700-hace-test',
>> @@ -366,6 +367,7 @@ endif
>>   qtests = {
>>     'aspeed_hace-test': files('aspeed-hace-utils.c', 'aspeed_hace- 
>> test.c'),
>>     'aspeed_smc-test': files('aspeed-smc-utils.c', 'aspeed_smc-test.c'),
>> +  'aspeed_scu-test': files('aspeed-scu-utils.c', 'aspeed_scu-test.c'),
>>     'ast2700-hace-test': files('aspeed-hace-utils.c', 'ast2700-hace- 
>> test.c'),
>>     'ast2700-smc-test': files('aspeed-smc-utils.c', 'ast2700-smc- 
>> test.c'),
>>     'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm- 
>> emu.c'],
> 


