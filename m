Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0596CD6E6D
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 15:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV9ia-0007lq-7Z; Thu, 04 Jun 2026 11:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wV9iW-0007hv-0y
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 11:10:46 -0400
Received: from mail-westus3azon11011060.outbound.protection.outlook.com
 ([40.107.208.60] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wV9iT-0004ja-Va
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 11:10:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=So1RR8OnfcpJY6JNxloCvkXcsf67svG5babYFUqT3nPDJVwEnzkErr01JOANIJG+q9POwSI//zpZJHDFkz0siaZhOMVXo58si6yIImZ4jryJb/Za1yaRVseTb05qI76eaH6o983X4c5IqYWpE6JsqHtTmyqOFYr5NErbLrZ9xrWH2Ee/lUiE4CEfPF4SrNz6uY4vq+5Vqcp6gP27cxEDcLI+O/T1EMoKvxFKK1+3w4F9hIlYHUQwarl72+EAuNqzrnNMhCpRVvm1geRC5l6+YipgmWOcfN/EY8pb3TzbNpN+70XpxBWBg7pY/W6KzYYjDL6Z9PehKzSQ3lHZO7caFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UA2G3rN5lonCBBrdHqWnmYG+9/K7+LBGaSKPR4IMw7Y=;
 b=xNqx5ayI4wxHY/ZEKpxBsOiEXl03d6HXve0yo4rS5N1yVKn3MX07EuczZf9A/JCLyVBSsWivgEJ1RLtuyoc0Gs6eyPIZ+ewxp0SFVJVrTGffk9/lWfQo3Mn6XIbb/bqoxsQFQnMB6EJRa7m8udO3SwJ9VloVKZPeHMxykXsWUq5fkoh5Qi7dAPKEFrbjppdrLM/G2JchhN69G3Wf3Vn/isRHa22A+YveqFNHiASeAN8FqMLSxX3a+0JIfWVRIwsbpvpRvzcAbiuNUPkknmUQI6+MtDL9lruPa0cGqsWxlN4K4lm+rHsufq8qDaAduAPBYXZRbj7CcWMtPAdwz/X/Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UA2G3rN5lonCBBrdHqWnmYG+9/K7+LBGaSKPR4IMw7Y=;
 b=RGgw8pb3HCijwAaKxam1u9SHKPLd+CStZZisLVZXVFlZy/hXDEQfkgPwh8SKQ2NeUveSalYTjflJWeJGpGfNxWUogwtjrklWtCf8bgis5HJHsjnbhOkTBBRzVpZne1xpk+TRnSTFYnP5I1YISG68hfMgaEgDvqYc3UDDOPVQ20qO1Dlnv6DlS5LNbdRLuSQ+zRiyTlG+ZzZdZlzUybOmsW/uvwZFO+EDMSAAuHgOy95YBJkOu2hZaNQYqwt4EFgfuAy7StuRV9PXCkkgEAceuC2tDY2t5rk3z7CtxUBXtc+GyJPySITor3EaecAzHYy5Asno0HDxHSG9CmcyFBOWjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by DS0PR12MB8501.namprd12.prod.outlook.com (2603:10b6:8:15d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 4 Jun 2026
 15:05:29 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 15:05:28 +0000
Message-ID: <f3434226-237b-40e4-9b55-3e79a0656705@nvidia.com>
Date: Thu, 4 Jun 2026 18:05:20 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] migration: Make switchover-ack re-usable
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Maor Gottlieb <maorg@nvidia.com>
References: <20260602092621.382-1-avihaih@nvidia.com>
 <20260602092621.382-7-avihaih@nvidia.com> <877bogdrdn.fsf@pond.sub.org>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <877bogdrdn.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::17) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|DS0PR12MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf68bc7-575b-4622-7f3b-08dec24ab6be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|11063799006|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: R6mMftGJOmc+uuFSqz3GZT4iiJsZ6j2ZCG6aG187AH0U5FsB9AfXPAlCT63XWW535TWrfhyhGtbPYMNZ7VrrBm4H9PZd1wqUnqayN/E1jVTLQWmNjKTHl1/CYl9lih2rbSD7W0ls+LiM8ONmO1wtGoI4Yd6zw6+zp7thsqvRNWHpQlFcehFjaf5uJ46WpnL96BhgCw611wAFWtmFVnjBelH26PZE4yQk28yG5xG3R8m4z5WwqexnVVh0Zrj5escfNhF77BHbIijvg/KhHjZV6rQPfVb/Iocn0NkqesMMTw0LOZCiDTC35NOrwojubein3JE5+UZ4kwfeuPfV87Vgk9nVC5BG72s7EB4PvCnJgPvZxGeB8Y4dZvXiSzn3+W4htUV+dtFvJh0RS/t5rf6rUm9bRj25H1oGsWRtIA2JLHa1buc5Y7SyCWoAJ9rHqfXq+hM6OzaGkAGCgBqJ8SbNSPYnkpCfMbzlX6QSXp7VsHdx0sEkrd4fvhlT5bNXzieSwyNdAKuKTuzCSWNCdqAkuN2eVfiG/julJydKldJg1lnrnxUrEN+pD799Xey+G6PdnaXFvrQt666gQN4/268wkQ9xclZX+v4PmXVaXBSejuSofZSG4UNCYIuHbaSusuMF/lT4sXN0adX+cdHaBLHBzLtkFd+zHwhxk++0iPYN2xdhFdWRWDIz9nQZYxkfmv/4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(11063799006)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2E2NUI5MG1WSkJJTnhublZZNEFuOW9LSGpaWG5ETEZIVGJhSDBhTkxVNUg0?=
 =?utf-8?B?VzVDMVl4ZmtRZkRRbCszRnNVN0N1aU1TcTVMc0hUVHFFR1FESXFHeTErMHVx?=
 =?utf-8?B?V3J5RWFzUjBuOGdvZG52bSsvNWVsTUEwbDJUUXIrcXV0L1JTWlVWcHRrMXJR?=
 =?utf-8?B?ZjRGYVd2N3hWR3FFc3ZpTHFhZHFxcnM4WUsrd21mbTMwaFNHM3liNjltS2gy?=
 =?utf-8?B?NGM0SS9XblR2SHVtSitzOXJ3bkZGaldPaWxzeFJnQzBTa3VxZmtCUlV0MmRm?=
 =?utf-8?B?ZkNJYXBKNzJjcEcwdmRIeW42eGJtLy9vSHAxakhpNWh6K1hiTGlOSko1cHJO?=
 =?utf-8?B?eE5ER0xZbU5reHRyUXp2ejV6YVV3OUxaUWtBVjJzSDBMdCszeXc2UHQxYlZz?=
 =?utf-8?B?S3B3cjJXQUZ5YklZcHc5V1MwTjJheEdaS0N4NzVQR3E4LzZuSUdWRE1acS8z?=
 =?utf-8?B?RUtyeU9jd1BUUXJRbFNaOFhqVjdpcm9yZFFEVTJqbXd6RzRydnhxNm5VVHhR?=
 =?utf-8?B?QXZKUHFUeFlNVWdGaFVyUi83L1ArVkhrK3Z4SGhyeFNJSHVHZ0lKK3M1Ly96?=
 =?utf-8?B?WWdjdmZDeXFCS05IV2w1Q3VtQkxZWUkrWUQrNEo4eENSNlBXNFV2TUt4dExy?=
 =?utf-8?B?NmgvMHNyYm81Um1MWHNoZE83YWxJZ0ltMDRWV3d1eUJCaVNHclMwTVlPSHJz?=
 =?utf-8?B?c2ZwaVR2OWFoTkpTbDAvditCWmpwbTNRNzFLTDdXYW5QU05zV0VBRThySU96?=
 =?utf-8?B?RXpuOW91SVlMR1A5Mk9QRk95V0dFSW54UDJId0FZR092M2JSNUlCQW54NXBI?=
 =?utf-8?B?Rng2ZCt2aUdON2tiZ05KVlVJSkxkcWtrdFdUS2VMMTM3amhDVTJ4QmhTTFpj?=
 =?utf-8?B?V2xaM0lvdjFyRCsyRi9jazNWNkRpM0NMOEgrVU1iZktBeUlFUE1iOWZHTlJQ?=
 =?utf-8?B?TTRQanY2SG04SU5MNTJvckNwMk53bmRIbkRqUmpJMlpHKzJJSVJDUFFRWVFJ?=
 =?utf-8?B?WGNrOUo1U2tiTkw4SGgzNkZ2dEcxSUhQMnlBV2hNdURybCtLZ3A0a3ZCdjdQ?=
 =?utf-8?B?QXF3SUpPbTdRdkxsSnZ4bnhqWG9aVU9SWXpXWVNIa1prdnYxUlpMUEQvckgw?=
 =?utf-8?B?aEp6UHFDenBFUXAwR1ZFKzNMN2F1V25hc1UvT3JibFZScXNCeGE2WWM0Z0gy?=
 =?utf-8?B?eC94TklrcmZFZkxvUUpML2Y3Nlk3MGhMZ1dpMndUMFQxM1U5S1p3M2IzY1FL?=
 =?utf-8?B?NmdQSnNzaDlrMlFJM2xmbklPalQwaGk4azFiYXpmUjY0a01xajAxN3pIeGM2?=
 =?utf-8?B?MldtOE1VOTRTcHllKzZvQVBkUDhoVjkwWUo3a3puUXd4TWRjSzkwZWlQUkFE?=
 =?utf-8?B?dUxrc3ltN1RaN1I1MlYzcnpTYmhUTzFHbDFocnUrcHZHV3NYMGhqNFFCZHlw?=
 =?utf-8?B?ZHNsRm1nMmlLM2VESG00aS91K3NEUU55clh3aG5Uc1dEcDdTeHgvamxFd3Fn?=
 =?utf-8?B?Tnp4L0t5LzBzcUhwTWMraC83bHIrN0ZualR4NWcyVVVoOFRHSFBPamZEd1F2?=
 =?utf-8?B?dVBZeG9uWCt3VnJnR2ZvNnkyZlRDZDVOQ0RVTWRqNDVtY0paSjFEQUV3NG1N?=
 =?utf-8?B?eVJvVm1SQ0V4Rnhad1EyaE1yT1IxTmczam95anZHZnc2K2dLNW9TbEs1TGdE?=
 =?utf-8?B?QTBaa1pXZzZ1Q3hqNTEzWGExaWVWL0tkVlhzenhUVWRRN1JpL1JPSWhsU1Fp?=
 =?utf-8?B?K2pvamhOUEJoeVJwV2ZSYWlhaXBjelRRU3JJU1VKeEhrL25xQS96SUQ2aHFC?=
 =?utf-8?B?ZHluSE9pYXlzRjJvWVd6YVc1cVYzd0I5TDZTN3BKYUtLQTAzVElTeUVPY2JT?=
 =?utf-8?B?cjJITFJDelJWb2JvR3huYmFYU1hRSjRPZ2VJNHFIOWMwa2ZrRHhNUGx0ZkxE?=
 =?utf-8?B?QlR6NXlYL25QMlc3UmpjSW1JV0JvTGN2dFBNUEZIckJnT3QvSktGUk9IMk9i?=
 =?utf-8?B?OTErU1JOTUxHTHJqZm9md1Z3OUlrRFF3MW5ReHBLMFExNkxtSmpVY0hkcW9C?=
 =?utf-8?B?bUQ1N1p0cXF4YzZmS1NkWUI2N3N3SzJTVkRsSlp1OFZGZDQyekpjNi80SmlJ?=
 =?utf-8?B?NFVXOEtaRGhic0x0WEtYNHc1UVZoWUcwTXd0UjFkSUZDL0tQZjdDQjI4WDZl?=
 =?utf-8?B?ZHRUbWNpZTE0WmhhVzFnUGNoZ3M4VXg1OEZRV01VSlNEK3NJeURtQU5NeVFz?=
 =?utf-8?B?RFRITk5XODlVMXNNSGhsWi83aDhHZXNBRGhNUUtqWERpS2NtaytYSndLaStr?=
 =?utf-8?B?czZlRy9kMmYvVXVTV3B3VVYrWU0zVzc0UUdXL0lrd1I2MDRyR0pzZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf68bc7-575b-4622-7f3b-08dec24ab6be
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 15:05:28.7908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmbkB3DOsYVQSemEG6+xgHTnW4u14AARsE/1jtKYJqg2kKXa0eg7krfAgOMjHTLZHDDkeJ2ooV5ebhBuugheBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8501
Received-SPF: permerror client-ip=40.107.208.60;
 envelope-from=avihaih@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 6/3/2026 10:17 AM, Markus Armbruster wrote:
> External email: Use caution opening links or attachments
>
>
> Avihai Horon <avihaih@nvidia.com> writes:
>
>> Switchover-ack is a mechanism to synchronize between source and
>> destination QEMU during migration to prevent the source from switching
>> over prematurely.
>>
>> VFIO uses switchover-ack to ensure switchover happens only after
>> destination side has loaded the precopy initial bytes. This is important
>> for VFIO, as otherwise downtime could be impacted and be higher.
>>
>> In its current state, switchover-ack is a one-time mechanism, meaning
>> that switchover is acked only once and past that another ACK cannot be
>> requested again. This was sufficient until now, as VFIO precopy initial
>> bytes was defined to be monotonically decreasing. Thus, when precopy
>> initial bytes reached zero for all VFIO devices, a single ACK would be
>> sent and its validity would hold.
>>
>> However, now the new VFIO_PRECOPY_INFO_REINIT feature allows precopy
>> initial bytes to be re-initialized during precopy. Specifically, it
>> means that initial bytes can grow after reaching zero, which would
>> invalidate a previously sent switchover ACK.
>>
>> To solve this, make switchover-ack reusable and allow devices to request
>> switchover ACKs when needed via the save_query_pending SaveVMHandler.
>>
>> Since now switchover ACK can be requested for a specific device and in
>> different times, make switchover ACK per-device (instead of a single ACK
>> for all devices) and let source side do the pending ACKs accounting.
>>
>> Keep the legacy switchover-ack mechanism for backward compatibility and
>> turn it on by a compatibility property for older machines. Enable the
>> property until VFIO implements the new switchover-ack.
> I figure this is about the transmission of ACKs via the return path.  If
> both source and destination understand the new per-device ACK, they use
> it.  Else, they use old one.  Correct?

Correct.

>
> This is not visible to the management application.  It may use migration
> capability @switchover-ack to enable just as before.  Correct?

Correct.

>
> Can you think of a reason why management applications might need to know
> whether a certain qemu-system-FOO supports per-device ACKs?

Not that I can think of. It should be an implementation detail internal 
to QEMU.

>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   qapi/migration.json                | 16 ++++-----
>>   include/migration/client-options.h |  1 +
>>   include/migration/register.h       |  2 ++
>>   migration/migration.h              | 32 ++++++++++++++++--
>>   migration/savevm.h                 |  6 ++--
>>   hw/core/machine.c                  |  1 +
>>   migration/migration.c              | 37 ++++++++++++++-------
>>   migration/options.c                | 10 ++++++
>>   migration/savevm.c                 | 53 +++++++++++++++++++++++-------
>>   migration/trace-events             |  5 +--
>>   10 files changed, 125 insertions(+), 38 deletions(-)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 27a7970556..550cb77762 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -507,15 +507,13 @@
>>   #     and should not affect the correctness of postcopy migration.
>>   #     (since 7.1)
>>   #
>> -# @switchover-ack: If enabled, migration will not stop the source VM
>> -#     and complete the migration until an ACK is received from the
>> -#     destination that it's OK to do so.  Exactly when this ACK is
>> -#     sent depends on the migrated devices that use this feature.  For
>> -#     example, a device can use it to make sure some of its data is
>> -#     sent and loaded in the destination before doing switchover.
>> -#     This can reduce downtime if devices that support this capability
>> -#     are present.  'return-path' capability must be enabled to use
>> -#     it.  (since 8.1)
>> +# @switchover-ack: If enabled, migration will rely on destination side
>> +#     to acknowledge the source's switchover decision.  The
>> +#     acknowledgement may depend, for example, on some device's data
>> +#     being loaded in the destination before doing switchover.  This
>> +#     can reduce downtime if devices that support this capability are
>> +#     present.  'return-path' capability must be enabled to use it.
> Please use the opportunity to fix markup: @return-path.
> docs/devel/qapi-code-gen.rst:
>
>      Use @foo to reference a member description within the current
>      definition.  This is an rST extension.  It is currently rendered the
>      same way as ````foo````, but carries additional meaning.
>
> Suggest "Capability @return-path must be ..."

Sure, will change it.

>
> The old text is concrete: "will not stop the source VM ... until".  The
> new text is vague "will rely on destination side to acknowledge".  What
> does that mean exactly?  How does it impact behavior the user /
> management application cares about?

How about the suggestion below? It's both concrete and doesn't mention 
the number of ACKs (as requested by Peter).

# @switchover-ack: If enabled, migration will not stop the source VM
#     and complete the migration until the destination has acknowledged
#     that switchover is safe.  The acknowledgement may depend...

Thanks.

>
>> +#     (since 8.1)
>>   #
>>   # @dirty-limit: If enabled, migration will throttle vCPUs as needed to
>>   #     keep their dirty page rate within @vcpu-dirty-limit.  This can
> [...]
>

