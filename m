Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D992CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 09:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYhKC-0005FD-G2; Sun, 14 Jun 2026 05:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wYhKA-0005Ea-FQ
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 05:40:14 -0400
Received: from mail-eastus2azon11010022.outbound.protection.outlook.com
 ([52.101.56.22] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wYhK8-00055y-H3
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 05:40:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiM11e/09c3M/xaPMONAP6GGz0NwLG3Hd3op4O6VfHQ+FcNsSc35ABhI/1RDne1CRAcopqsutmPArq5BjK/silsw7hgTw6/265Mlk78HRVoikzDtpuZvWhKT9g39KQ5NMgADOe5Gxx5Ra/L0Xdhck6qLfR8aEnzNuPzw1buybAxCgD1BCCMhucZvmkpNizPlhUxPMqjgD6/y+EjvY1kGSIW5hw6iFBjBKYrhPLoaov/Co19sdA37ddlU+i4YBdIqArv99DsHJStl9FfxWewzZT++NoFaAwsnN3c8k7gx3/S86ZZyhW47hVRxBJhCxNe5pULIZYJ+X33w/FU3Vu2N3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UBsnl24QEJ65jaku9wZtc4UaDimy3bxuO03RDPf3eU=;
 b=uBRTl/XI8KcoWAl3ut6eBNjMEYb4ezVFOKJu9ZDNZHleJ2KzOQ8obMyV7RamaIF34dTr8o8XOCCwS4/w7PxrpRDncBV94VlVXRIZkuH9F4gXuiak+599ATs74DxK6r8GIkNwaenw561j1uQYnmTyBYU1lTdiGA5AF/2oNbAnJ3a5t68Gi4ojYpz9RK55uXg2n8g9a0GAUMUng8iy+c9ivsv/K6kaI8acwIZMlB5r+7ur04Px29p4KBVEI3wn8FJIoFtS2xVMgea6cJq7Wqq1uEWziWyAocw6owFnxQSueH9B5Rqr67VQCM6TQ7MxF8N+mILNpPbDrdwj3eITHRXqYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UBsnl24QEJ65jaku9wZtc4UaDimy3bxuO03RDPf3eU=;
 b=ozKaNNIQ5DO/L9pJ5qvOzlCdPXgLRXzLFLM9cws7GEkt0mzMrgUnAaAUlM8Wjzp3h2Ff9w/08hnpPp7b+8u4ZMngXmNVb1nEyNWcaO8oIM/nMf/B8AOiyAlSMHtviZR7v/cZhyS/87Vge9fz94TEJ5eFodp8hBoyKb+VYlxEjHCIpoV5/cna0WuAkrDbn+eLDlUCMmKlewEF54+MiH3TLkJ9SeUY4Au7M5VpCBLrnMnfv83fIVdl2P78XK2eC9NqD4JjSsQEJ0DQBnO+ho27YP4hcMUqEj0iENAXzJLzS/olwUqFK5OSiwvXHCmdyPz0yOaoo17mxTKnuSnYduRFyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by SA5PPFCAFD069B8.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sun, 14 Jun
 2026 09:35:04 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 09:35:04 +0000
Message-ID: <543a27b4-be17-4c1b-a662-375a8bb0a2fe@nvidia.com>
Date: Sun, 14 Jun 2026 12:34:55 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] migration: Propagate errors in
 migration_completion_precopy()
To: Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260609075812.32067-1-avihaih@nvidia.com>
 <20260609075812.32067-2-avihaih@nvidia.com>
 <775738ae-3a47-4ee6-900c-56ba77b4185e@oss.qualcomm.com>
 <aiwt2_I2wK6FBJnO@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <aiwt2_I2wK6FBJnO@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0351.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::14) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|SA5PPFCAFD069B8:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c08d9b-738a-4312-05cb-08dec9f8364c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: uJ8BAWuX/tiSqQ3ObQNc20G4IWpHN2gfihj7Wk8pmYLI+RyYjmbR+e/yyNa+9oZSg7+XNcT+bntrJOOdMwQLDR6/OWONEvtdk2tE0XVgFPlR4kLYWb6Df4PDEazM3OVd8kAr1HHeJoXhHknc2poemZENGKzyDq2s1754R+iALAUKeBku/bKFoy/HcZNJUoykSFQOzAJUQJfTKTWKnCOaIxW5yY9olJsat4D9TlZ3dHvaqPb+D1gMq3BvZLsyyVDrX4RLtCO0bpf+xZW3G3loePGDw7jTvO45i7/loy0du36LfWcznKTK33UllK56momvniO4HHyt7xZBTzRbAxuZBKsJanxvaqlf3/8hYqqay1H8bIpBSA4svkp1/opG7p8ExmXcrJhmOT5ePwbgQr8T57WR9NVie1hhI+rXq+ypoJ/AlBVkghQBpQspJPu693OXTphrMly7Yg/qmzKi547CA3KVJUysTcwEjX9bSjbJuFKwDh4YeT4K4tgKmu7p0qF7MSr6hyBM3SfNeB4QJ3mFMPLZw7jW5qdYr16fUxtDudhwWHP87CybzZigk33fEACR6/v+6/Qtdd8ezkrpo/W9YKBfPob6dBakMvoeA/qo62febPDid/Ch7d4Ppc+Tq7ukWLVSjHiuH50N51rVyDVac9tc2CP1Pg6QzAskZ6tmxI9dSmQiRV0jCa1Ro5w+k1Be
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVQyQndkOXdneExncjRqN0RISm9JdHM1MDhCcmcwN3VlaURuWTdLcnh3VHBp?=
 =?utf-8?B?c0Evdjg5VHo2cUNFcWhtTjU1V3FxdUM3ZlNxeGZLRWRQZ3ZQRlZkemxLL3JU?=
 =?utf-8?B?YUVMTlNyOW0wTDJRMnZVRWt1NTdjWHdrcm91Y3IrTUZXcDdkMmZPcnBnQWkx?=
 =?utf-8?B?MFVKcDZmL3ZjWDN3ZkF1YysvYlIrREFOMkRaUkU2MmVPMDFDenNEeDFGZUs5?=
 =?utf-8?B?dGY2ZjZaUElpY3NENm91STFLZndoTkVBdk1IRlRvMkdDek96MnZ1WTJWU2xZ?=
 =?utf-8?B?dWh2R0cyNVFBdDhBL2pHa1dIeERuV3lhL3F5MnhzQWZFbCtva3h5TVZJK0Zx?=
 =?utf-8?B?ejN5a1ZsalExdWhWY3BON1M3L2NMYlFBUVFiOTVTNUcwdUNKUGxYOVJjSjdl?=
 =?utf-8?B?TElES1dwYUp2YlQxMVJXSWhxb3lsZ3dtMmJlSnpmR0x6WXVOcGE4UXkwZFM4?=
 =?utf-8?B?U3F0M2ZiNlptZ0lzRkJrWGlFY2c3WkR5MUlORWpFSVVvY2U4bmJlZXhja1hj?=
 =?utf-8?B?SXNRSGtvWDNrTnc0Q0tGUTcwcGxDemNQYzFEQytHZUMwUVo0ZHA3VGN2dVdJ?=
 =?utf-8?B?Zk9LSTA5K0JaOEdzMWdjYWorOUNqL1lvSG42dTZxTnZHM1IyeWQrR3lXMGRY?=
 =?utf-8?B?SFBEZGx0NXpkNXNPUEhLU3dVWmdTQkRJdjd5R0gxRTE3THpFUGJ3ZmdIY3M2?=
 =?utf-8?B?c1o2eXVyaFdkcDlxVitIVVBjY01GUnk1UFQ2WUdVWjlzNVVuSWU1YXdrYSs1?=
 =?utf-8?B?RFlIOWVVMXQvYllyRTlZY2hqU1BBSzdGNzBWY3BXUjBHTk5YaDQzQnRobGZj?=
 =?utf-8?B?VXF5anJKQUM0aXRUM0F5dlNva01RdmZ4R1NWZ3NhdytER3ZQN2tIaXNmZHB2?=
 =?utf-8?B?SlZMTXFzSWFDeUV4d2txR1dFamIxSG8wMDBmcHp5bWRVTGRDQytVOHlCMlVp?=
 =?utf-8?B?NkdEZTNoeHZrczNRZ1hKWWFQbUVwZ09nclRYeGJHVy9GWTN5NXRvZWdoemRt?=
 =?utf-8?B?Nk5jRSsrVGxsT2YvOU1KLzZaOHFTRFJwNm1CeVd2ZjRiclhxZDlnclI5MXhu?=
 =?utf-8?B?bHQ4T0tTcHpTcnhnd1ROMTZyc2NJYW5tMUFGWU51RWlQbloxSnNEdyt4bC9z?=
 =?utf-8?B?elBmcXZ1a3dOQUVTUWtrdkF4QjZWNTZpcm9vbnUwR3ZvY29sTEkwSUcxTG1T?=
 =?utf-8?B?VUNDWVQ0ZzN1eUY3Ykl1eGhwL2pHcHgwQWZMampNMDNZSEZwY0Fmdk9zNk8v?=
 =?utf-8?B?cmZaZERzQzdCcDdaRXU4aDhZT21ETE1JczFiQXVONmRNQndkc1YxYkdOV0wr?=
 =?utf-8?B?Rks2OXZKUEVMUmtnNDk1QzVtQmQ5UngvT2dNZ2RjbitpQURLQ1Y0UDRmZDdW?=
 =?utf-8?B?RHZuS3YwazJqTTZ2NlJ2QWtzMC9Zd3g2N1ZHZzN1Smd0dUxGcUdSdlNoems3?=
 =?utf-8?B?WnI1eXI0K0wxZ2xJN1FRSllDUWlGa2RtWWVZRGVRRWtWYitEWTJrZ2pnU3k2?=
 =?utf-8?B?YW9sZEc2UXo4RGd5RzlaSVlja0owUXRUWEdoaHVxWGwzT3hNeDhRaGJIMjBF?=
 =?utf-8?B?TURqVzlZd0NWTHVkV0s2UlhhZ3YvV3BXZThaVlBCWUl3cWhDVFlYV3VMSFMv?=
 =?utf-8?B?L3ZXSFVSVDhiRDRZdXFOM0lJTmdjWklkR0VCa1prbnQvbTY1QTlwdHkrbU16?=
 =?utf-8?B?UHZBeCsvTnNVM1U0ZkRqM3N0OC94TUppVklDaXJrRHJLQ0tDRzVCR2N3d1l2?=
 =?utf-8?B?VEljY05GSHA0dm1TM3pKMU1qbi9ZUHhNdlB0VmFNNUVwdm9ZbDRoTXBFVktW?=
 =?utf-8?B?dkFwbHBtZHUxdTFIWlpYT1M5VGI0Q0N3bGI0M2YvSVp0ZzFFYi9MTk5OSkMw?=
 =?utf-8?B?RGZtc055U29zTDhxV290V0ZUU0pyYXY5M2JtcExkQlpxeUJVSUlsUmtDTXN6?=
 =?utf-8?B?aXNQc2RUSlNVRWZEQi9NWWxPK0pvSlZKRGJMenFJbDVwL3NsQWJrWHhyREcz?=
 =?utf-8?B?Z213ZnFkaEtrSXJMbWJ1ME9QZzZxRlA4UW45VGpsQWpxODNRZzBnRXVsYWk2?=
 =?utf-8?B?T3lzM1ErbXQ4dWdJOGVQMk54eFVneDJZZy9WSDQyWGJTc2xMN3FMVE9GRDlF?=
 =?utf-8?B?dzRVamU0R3RUeEdtdmVUTXpCYnBOTGhOMzlHOVRrN3ZUOVpVbFJBVkwrc3lB?=
 =?utf-8?B?SmdaK04rRTZ0VDJWdDFyaWpiWjNsUTYyWlRkNWtQRTU2L0JtYWRMcTFsOEoz?=
 =?utf-8?B?UkZKMEcxNmpOZW1QZ3lMUVlVWXdEbWk3aEhaL3Yvbm85c1ArNDN1Z2VMNEJX?=
 =?utf-8?B?SEhXTlhNQXZvZU1rWkJkTWpsMStjTEpKWEpoaGx2S2h0NFp6L3BkZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c08d9b-738a-4312-05cb-08dec9f8364c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 09:35:04.1526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1VFVaMMk3FxUxNgHPvKF7XInQQ4wyfs5cxh6eDO7rwLy8KkHPhm9Ls7EIWWsPggUAyA0pqTCktuShQRMu8vxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCAFD069B8
Received-SPF: permerror client-ip=52.101.56.22;
 envelope-from=avihaih@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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


On 6/12/2026 7:03 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, Jun 09, 2026 at 02:11:00PM +0200, Philippe Mathieu-Daudé wrote:
>> On 9/6/26 09:57, Avihai Horon wrote:
>>> migration_completion_precopy() doesn't propagate errors to migration
>>> core which leads to error information loss. Fix that.
>>>
>>> This prepares for a follow-up where migration_switchover_start() can
>>> fail on switchover-ack and still report a useful error.
>>>
>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>> ---
>>>    migration/savevm.h    |  2 +-
>>>    migration/migration.c | 13 ++++++++-----
>>>    migration/savevm.c    | 29 +++++++++++++++++------------
>>>    3 files changed, 26 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/migration/savevm.h b/migration/savevm.h
>>> index 96fdf96d4e..b6bb4fa977 100644
>>> --- a/migration/savevm.h
>>> +++ b/migration/savevm.h
>>> @@ -44,7 +44,7 @@ void qemu_savevm_state_header(QEMUFile *f);
>>>    int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
>>>    void qemu_savevm_state_cleanup(void);
>>>    void qemu_savevm_state_complete_postcopy(QEMUFile *f);
>>> -int qemu_savevm_state_complete_precopy(MigrationState *s);
>>> +int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp);
>>>    void qemu_savevm_query_pending(MigPendingData *pending, bool exact);
>>>    int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
>>>    bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index 074d3f2c69..aad23f3228 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -2814,7 +2814,7 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
>>>        return true;
>>>    }
>>> -static int migration_completion_precopy(MigrationState *s)
>>> +static int migration_completion_precopy(MigrationState *s, Error **errp)
>>>    {
>>>        int ret;
>>> @@ -2823,16 +2823,17 @@ static int migration_completion_precopy(MigrationState *s)
>>>        if (!migrate_mode_is_cpr()) {
>>>            ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
>>>            if (ret < 0) {
>>> +            error_setg_errno(errp, -ret, "Failed to stop the VM");
>>>                goto out_unlock;
>>>            }
>>>        }
>>> -    if (!migration_switchover_start(s, NULL)) {
>>> +    if (!migration_switchover_start(s, errp)) {
>>>            ret = -EFAULT;
>> This function should now returns a boolean IMHO.
>>
>>>            goto out_unlock;
>>>        }
>>> -    ret = qemu_savevm_state_complete_precopy(s);
>>> +    ret = qemu_savevm_state_complete_precopy(s, errp);
>>>    out_unlock:
>>>        bql_unlock();
>>>        return ret;
>>> @@ -2869,7 +2870,7 @@ static void migration_completion(MigrationState *s)
>>>        Error *local_err = NULL;
>>>        if (s->state == MIGRATION_STATUS_ACTIVE) {
>>> -        ret = migration_completion_precopy(s);
>>> +        ret = migration_completion_precopy(s, &local_err);
>>>        } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
>>>            migration_completion_postcopy(s);
>>>        } else {
>>> @@ -2900,7 +2901,9 @@ static void migration_completion(MigrationState *s)
>>>        return;
>>>    fail:
>>> -    if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
>>> +    if (local_err) {
>>> +        migrate_error_propagate(s, local_err);
>>> +    } else if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
>>    if (local_err
>>        || qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
>>
>>>            migrate_error_propagate(s, local_err);
>>>        } else if (ret) {
>>>            error_setg_errno(&local_err, -ret, "Error in migration completion");
>>> diff --git a/migration/savevm.c b/migration/savevm.c
>>> index 23adaf9dd9..9d1d58c8f4 100644
>>> --- a/migration/savevm.c
>>> +++ b/migration/savevm.c
>>> @@ -1771,28 +1771,34 @@ int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp)
>>>        return 0;
>>>    }
>>> -int qemu_savevm_state_complete_precopy(MigrationState *s)
>>> +int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp)
>>>    {
>>> +    ERRP_GUARD();
>>>        QEMUFile *f = s->to_dst_file;
>>> -    Error *local_err = NULL;
>>>        int ret;
>>>        ret = qemu_savevm_state_complete_precopy_iterable(f, false);
>>>        if (ret) {
>>> +        qemu_file_get_error_obj(f, errp);
>>> +        error_prepend(errp, "Failed to save iterable device state: ");
>>>            return ret;
>>>        }
>>> -    /* TODO: pass error upper */
>>> -    ret = qemu_savevm_state_non_iterable(f, &local_err);
>>> +    ret = qemu_savevm_state_non_iterable(f, errp);
>>>        if (ret) {
>>> -        migrate_error_propagate(s, error_copy(local_err));
>>> -        error_report_err(local_err);
>>>            return ret;
>>>        }
>>>        qemu_savevm_state_end_precopy(s, f);
>>> -    return qemu_fflush(f);
>>> +    ret = qemu_fflush(f);
>>> +    if (ret) {
>>> +        qemu_file_get_error_obj(f, errp);
>>> +        error_prepend(errp, "%s: Failed to flush QEMUFile", __func__);
>> Ditto, directly return boolean.
>>
>> Anyway can be done on top, so:
> Agreed, I didn't mention this because I know touching the retval needs
> further touch callers.  Can be done on top.

Sure, I can send a patch for that later.

Thanks.

>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> --
> Peter Xu
>

