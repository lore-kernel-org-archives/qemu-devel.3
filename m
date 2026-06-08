Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5C7CD8CA8
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 12:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWZQC-0007Z1-AR; Mon, 08 Jun 2026 08:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWZQ4-0007Y2-TZ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 08:49:34 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWZQ2-00066g-JH
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 08:49:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohsJIeVKl9QqXo9cJeyf8sG7I5bYznSA3c4Tbl+6vx9VTN3kunPNujmQq1LZ93tZrIM9wFdq226/a4MNqaUju+HFMQNIybiimOtolAhGBsF1Y8EdRPClpkyImT+qhQft1/qSwtX25fZ7u1aYVEeBscGNxsmcF0jz51JalN9w2mgzNV4yzdgGKDR/m3ebfO5SDrb9lAX4bpq2M2SxgqBPGnO1zmgKL/Fx5iYfbflV1FNmgUifDIh1BQf0vPexFkp8RMqW3lgJExrNYOupv4wes7fEblm2JBSGE4EQvDg18BTUYUEoDtC3pEn8O1ZJZ94LnBA6Kme3jSmtOjJF4cFmUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgOUOi50txq8X8w2nxXfj+2DBS571NJLBz0EP0AiKY0=;
 b=Wn76yIVjWjJiudVqtZWjRQs7HWj9b08Eh0/XGKMuH6fA/Qxd1cCt+uL7HOazs3+7uC58aPjf0ZlqVJ4okKZV5UsQaPRVQj3fjVOekrGj49u0p6wSoGU4dAr9I4y+6ADiOr/odbKmBDjurrYAsQ4IUhnr41pWwePfJSyn9yWN4y+qwwmPB3P2sYpkSV8jQftyZxWkIf1CdjdMynMAMFjtfnkxHck4v6G8f+th4B94k6cmaPMKyh7PeGEOi6E6TeIkxc5XwmvTByiGxKRwfu0+mbZnsA6ax4TcrEZZOQi9hQkwJ9V49Pa3geqjqGu0YDIkN6pDn/hmJWw8Gwe1aekNgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgOUOi50txq8X8w2nxXfj+2DBS571NJLBz0EP0AiKY0=;
 b=oNSP7k2So2rB+Kjwti2UEUNQ5uvfCQKeu1DMLAsiYGO9qXt7mdt9swkC2PqBMWNWy4oezGtF0gvbkiLTdJPDOxMIe3rTheNnZC5b922PlXK7JwuA2lvJw9u2I1Wpq8FBRMp6SoHZxZRuIyoaQaTpaa+Ys9UDDeyv6CDlrFuuTUNiavfGhXa4lm5kN5CpRds3eqgEPQZRyqtRPYt6cUQsCDkIGaNUTypmogZzFVQ+EsEtDnDF2RSRVHOLE4JUTQt9Vq6tLlE/AGIcUjVecmltNAUI3BL9sylsD92rUtJK3wA5paaSPjIYYwjZyeTEPdqXcOs944h5RWUNY0T3ILOZXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 12:49:22 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 12:49:22 +0000
Message-ID: <607dc626-cdac-4925-b411-5b8c172145ed@nvidia.com>
Date: Mon, 8 Jun 2026 15:49:15 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] migration: Fail migration if switchover-ack is
 requested after switchover decision
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
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
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260602092621.382-1-avihaih@nvidia.com>
 <20260602092621.382-8-avihaih@nvidia.com> <aiCRwvoVl_Z7J3bL@x1.local>
 <a4e5178d-2102-48e8-861c-232266f8da9e@nvidia.com> <aiG6VJ632WGwBwWC@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <aiG6VJ632WGwBwWC@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::20) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: d41b0496-c30b-4b0c-4f0f-08dec55c5d22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: GNKo6vS0wAjvarljo01Y40MehElpdFhU4HJXnu6cUxpNB5xnSm++vhRAxSnhhtsMbFWQ99cfbfbZwS+jGotlJ5NWnRGwYTH5wH31tCkWzn1wsEEjdH6aIz4y/2PEsDxCEZYIeejVKX3P/8FL2Z/62vt7ReFYqClfrp1Kz5KH+MdH1yvn89nIOYAMLgwQtIxeoHgVNuR6b9P+f1TF+Y675kU5keFWADiPVEDfuRYpjtyyytqiZPXGuT55o0d6KQ2WXUa/XMbkn2qvaa+31abo46iQj9OSgmJ5O2stlh39oQRsZuyXBnYuMtQgagQ1XDXZvk495iOKEba1qLVL6nx4Os9NZEyJqdBoLT2jcZAHC3PR18N4++pHBbqTfjuaIJKRMnPVax72riv3Lez4G78Z1aCyNB2bKJdq+ORelJjzZoX8Px+LWBubJQtITxTQhz0anCwzL4yy8x6r7YktzApGwukTmFsaIp1uqyZ3PSWOhGilOIwRSxXtQbSz+WDCc8s898yodlR6iknGvzBsJuvZjr8PtiJSqIfKJhWE2wOy/9qy1jMurQ31YSK2OEeSnieM5YPFy9Vl+1a0y8G3AfslprVCcrjTZzGNAQ42v3+GG51pMC8rO4YpTHAozywxRzd/cTmIg1TT9BZmT0AxKTTzFdV+yVM4e4fMNCs0F7a4eHj4heU+ABcY7dA2KF6eovRY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFQ0elJVZWNta01jQnNBSEpBRzdxWWZzcFFPTXlRNU1oNmdCZ1gzekVYUWNn?=
 =?utf-8?B?V0tiUDhyc1NnSzBwMEhhSmhKWDhORFZaOEJvZE1hQ2tPSnR1eUxaT2ZVM1ZX?=
 =?utf-8?B?Z0ZiSTNLbGN1SGdIZ1VSOXZzaVJ3RS96MTdmS0llUk9INk85am4zWXJnMlVo?=
 =?utf-8?B?TFZpbGJNMnk0c0tLZkg3NjA3N3kxZUpVdE00a0RESU1FQ1oyTU1OR3Y2enE4?=
 =?utf-8?B?ekM1NHFQSzNIUGEzb0p6a2wwTFVFMGZUMUQ0YmRwVTR1M2Jzb244KzZSZG1n?=
 =?utf-8?B?aHg2bHM4U2xaQU8vTzVaNDNTNnB4Qkw2bTNid0xYKytsRmIrWjhXOG03U0li?=
 =?utf-8?B?UVltT1lLQ3MvT2h5Ujd3SGVlUXhBRE9XUHhOSFRxVlBJZ3huSU5lcGtwVHVF?=
 =?utf-8?B?amd4VEpBTzF2TWlrZjJ4WGp5N3lBbkJGdkdqby9YWFM3TmRuSnhueFFvQ1M3?=
 =?utf-8?B?akQ3Z2x3allCSzR4SFh1Q3F6dHNadVhvckgvUko5dCtNd2xqWHJnSFVuMVFx?=
 =?utf-8?B?dlFZNXh0Z2FObDJmUlNnalVOSHJMczFHVzROZERvWXFEcU1ZdlQ3U0U0TFBO?=
 =?utf-8?B?K3hFbS91M3EvTkVhYTVoMGNHbkh4YjNoUTh6a1hwRk9jYmdrbm5Ld2QvSllD?=
 =?utf-8?B?WEFVSEZHMTZXVHZHVGgwS1BkREkrZXphMjFVZ3A5WXpPVGlXVldkQUdrMFVN?=
 =?utf-8?B?Y05ydTZWc21ZYmtnY09ERk9JVmphaVV3dlRUa2hzM2JBeHpOUTJJWkJvK2d3?=
 =?utf-8?B?QmJySGV5V0lnREJaTDRocU94K0txL2tLcUR0TExvRisvaXZPdW5KU3BSNHRF?=
 =?utf-8?B?QTlHZGFnWUNFK3dUT1Z3a2tyVXVMZ3lhR2UzbTNKeGIzSklYeU51UjdEVVdr?=
 =?utf-8?B?SGFNanhDdjhMbnY4MCtJSTFCbnhieDRzM3BoeHA2dFg4cktianBTRGNZZnFq?=
 =?utf-8?B?eFlEVkpuK04wck5VSmlGK0tHNi94WE9ROG9HRDNydWVvd3puRTY5cS9RZmtn?=
 =?utf-8?B?QjFEaVJ2SkIvQ2hObUlRQ2MyUXQzY2FyR2p2Ym5ORkowWGxoRnl1ZkpwSGdo?=
 =?utf-8?B?QklVenZLVHp6VDFJbGllOTdQRXFMWGlQd2NYa1NLWXh0WWx4ZnlmQjlNV3lB?=
 =?utf-8?B?VWx4NEdyWXVWTGJWR0pOV0tpb01NbHc1RlJqUW01YkZSL1o3dmN6S2IwY29R?=
 =?utf-8?B?VFFaVWNZZ0NmT3ZxN2V1ZVVsdE5rY1N1ZzJvOFJwU2lCNVpKSWV2WVpwOUFw?=
 =?utf-8?B?bElSZkVJNUhKMHBwSUhQQk1LQUcyZ1RYcDZ4QlVGRU1HLzlPSGdCcDVQZ21t?=
 =?utf-8?B?WDlGS1REcnZOSVZZbWVabDBPbXBOOGNVMjQzREhHeTNJd3RMWHZZeXA3YUs3?=
 =?utf-8?B?MlZWT3VXQ0FKeFJseG1abVVHNk9PMkd5Z0JUeStVaU91ZkNHMTB4WFFId3p3?=
 =?utf-8?B?eEhqU2VibWhhV1pvdHNiTTFRSzhPd0xwWjgxcG9vSmVFaFV5QmtOZHl0dTN4?=
 =?utf-8?B?VUQ3ejNOdkJGRnlMdUhXczhMc0RES2xaUHpGSmZMUWtiNXJPaDNzb1ZsT1M1?=
 =?utf-8?B?M01HZ0h2NlVTbGlBK3ZCVW43K1BBKzc5S1ZaK2ZsMGxuT2FJZmkwcmpuWFdX?=
 =?utf-8?B?bHBPTFhSSnVsZUlmTUoxZWRkSDNYVWRxN0JpME5rYXZvRFo0N1BwOVg5Wnht?=
 =?utf-8?B?d3BEdExPMWdrdmpGQmhHTzB3bDQrcmlCZmhLZmJ1TEZZR2hVeTI5TGY0M0Jo?=
 =?utf-8?B?bXgwMnk4cW5KZy9meE1BY1lkUHFsZlY0NXM5bWRRMzU5TjlRcGM0bUR6VTUx?=
 =?utf-8?B?R0tPUUY5WFRtenk4WThsbURYZXFzYzVPWjJSSk0wQmpKNXJCUVRDZ01PZUpX?=
 =?utf-8?B?RjV4WEozb082VTd6eTE2Z1BIVVJSU2xaMlp2Q3pUc2ZETzFYVWFnTkRuZmtw?=
 =?utf-8?B?bmZRaGZ0R0dQMm0yNlpma1RyT2lhMVNabEJNbVlzbXdsdVlvQzNIL2x3Qzgz?=
 =?utf-8?B?RWFjSEQyNEs5RHRkRXlTeDRCLytuSE9RcDZUd0lJSjFEYVM5d2F1TjlBODdJ?=
 =?utf-8?B?a1U0dmJHU2xCd01Rbmp3cW9KRlEyYklxNjNoRW1JenVlaDFZSUdpUHcvQkd4?=
 =?utf-8?B?dGJXeEtvVXlWZHRwWDNwbzdobHVEMnh4SkF0enF1d0x1a1RLTlN5cjdMWmJa?=
 =?utf-8?B?WlJzc3E5cVZjbkVwK1hSaEsvSFhZVTFnSXlDOU1lc1hiRWZUWHgwOE0vSTBI?=
 =?utf-8?B?Y1NZdVVWbytKaWtRNTZ0Vk40bVZEQjh4TXU5ZmRKQ0pBakFDajA4L2tlODg0?=
 =?utf-8?B?K3dqTnN4OCswbkZYMnd5TzFsNGVUNVdpaDhnTEdia0tEYVlKUTBrZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41b0496-c30b-4b0c-4f0f-08dec55c5d22
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 12:49:22.5292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulJvterw28Rrmdl0bPp1AtKTLoRA8qrExkaA+yLYCL6sxhUOGwrKzSD9CIAe2YvAcRtM8BIxsMsS0oVd6XOInw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=avihaih@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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


On 6/4/2026 8:48 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, Jun 04, 2026 at 06:36:14PM +0300, Avihai Horon wrote:
>> On 6/3/2026 11:42 PM, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Tue, Jun 02, 2026 at 12:26:15PM +0300, Avihai Horon wrote:
>>>> Switchover ACK is checked only during precopy while the guest is still
>>>> running. The last migration_can_switchover() decision and guest stop are
>>>> not atomic, so a device may want to request another switchover ACK in
>>>> the gap after switchover decision has been made but before the guest is
>>>> stopped. Migration would then miss that request, which can increase
>>>> downtime.
>>>>
>>>> Cover this case by failing the migration if a switchover-ack was
>>>> requested during that time.
>>>>
>>>> Ideally, precopy iterations should be resumed in this case, however,
>>>> VFIO doesn't support going back to precopy after being stopped, so
>>>> implementing such logic would require non-trivial changes to the guest
>>>> start/stop flow. Given the above and that this case should be rare,
>>>> failing the migration seems reasonable.
>>>>
>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>
>>> One nit:
>>>
>>>> ---
>>>>    migration/migration.c | 30 ++++++++++++++++++++++++++++++
>>>>    1 file changed, 30 insertions(+)
>>>>
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index 4bb649a467..6ee1c795ff 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -2810,6 +2810,27 @@ static bool migration_switchover_prepare(MigrationState *s)
>>>>        return s->state == MIGRATION_STATUS_DEVICE;
>>>>    }
>>>>
>>>> +static bool migration_switchover_check_switchover_ack_pending(MigrationState *s,
>>> The name is slightly confusing.  It says "check if there is pending ack"
>>> but then it returns true if there's no pending ACK..
>>>
>>> Maybe migration_switchover_is_acknowledged()?
>> Sure, or maybe migration_have_new_switchover_ack_pending()?
> Sure.
>
>> I just noticed that I overlooked one corner case:
>> If guest is stopped during precopy and source has pending acks > 0 (e.g.,
>> virsh migrate with --timeout param), then we will fail in this check and
>> unnecessarily abort migration.
>>
>> I thought about doing the change below. It's not as clean as I'd want it to
>> be, but I have no other ideas.
> Yes, it's not good to bleed switchover_ack_pending_num all over the
> places.. Maybe you can make qemu_savevm_query_pending_final() return an
> error when seeing any newly popped ack request while querying?  Then the
> new function is not needed.

Ah, I totally forgot that we have 
MigPendingData->switchover_ack_pending. So no need to check the 
global switchover_ack_pending_num counter at all.

I will move this check inside qemu_savevm_query_pending_final() and 
return error.

Thanks.

>
> Thanks,
>
>> ===========8<===========
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 6ee1c795ff..6054453b18 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -2810,37 +2810,47 @@ static bool
>> migration_switchover_prepare(MigrationState *s)
>>       return s->state == MIGRATION_STATUS_DEVICE;
>>   }
>>
>> -static bool
>> migration_switchover_check_switchover_ack_pending(MigrationState *s,
>> - Error **errp)
>> +static bool migration_have_new_switchover_ack_pending(
>> +    MigrationState *s, uint32_t old_switchover_ack_pending_num, Error
>> **errp)
>>   {
>>       uint32_t pending_num;
>>
>>       if (!migrate_switchover_ack() || migrate_switchover_ack_legacy()) {
>> -        return true;
>> +        return false;
>>       }
>>
>>       pending_num = qatomic_read(&s->switchover_ack_pending_num);
>> -    if (pending_num > 0) {
>> +    if (pending_num > old_switchover_ack_pending_num) {
>>           error_setg(errp,
>>                      "Switchover ACK was requested by %" PRIu32
>>                      " devices during switchover",
>> -                   pending_num);
>> -        return false;
>> +                   pending_num - old_switchover_ack_pending_num);
>> +        return true;
>>       }
>>
>> -    return true;
>> +    return false;
>>   }
>>
>>   static bool migration_switchover_start(MigrationState *s, Error **errp)
>>   {
>>       ERRP_GUARD();
>>       MigPendingData pending = {};
>> +    uint32_t old_switchover_ack_pending_num;
>>
>>       if (!migration_switchover_prepare(s)) {
>>           error_setg(errp, "Switchover is interrupted");
>>           return false;
>>       }
>>
>> +    /*
>> +     * If the guest was stopped during precopy (e.g., by management), we
>> may get
>> +     * here with switchover_ack_pending_num > 0. Store the current
>> +     * switchover_ack_pending_num value before the final pending query to
>> +     * distinguish between existing pending ACKs and new ones.
>> +     */
>> +    old_switchover_ack_pending_num =
>> +        qatomic_read(&s->switchover_ack_pending_num);
>> +
>>       qemu_savevm_query_pending_final(s, &pending);
>>
>>       /*
>> @@ -2848,7 +2858,8 @@ static bool migration_switchover_start(MigrationState
>> *s, Error **errp)
>>        * Fail the migration in this case since we currently don't support
>> going
>>        * back to precopy.
>>        */
>> -    if (!migration_switchover_check_switchover_ack_pending(s, errp)) {
>> +    if (migration_have_new_switchover_ack_pending(
>> +            s, old_switchover_ack_pending_num, errp)) {
>>           return false;
>>       }
>>
>> ===========8<===========
>>
>> Thanks.
>>
>>>> +                                                              Error **errp)
>>>> +{
>>>> +    uint32_t pending_num;
>>>> +
>>>> +    if (!migrate_switchover_ack() || migrate_switchover_ack_legacy()) {
>>>> +        return true;
>>>> +    }
>>>> +
>>>> +    pending_num = qatomic_read(&s->switchover_ack_pending_num);
>>>> +    if (pending_num > 0) {
>>>> +        error_setg(errp,
>>>> +                   "Switchover ACK was requested by %" PRIu32
>>>> +                   " devices during switchover",
>>>> +                   pending_num);
>>>> +        return false;
>>>> +    }
>>>> +
>>>> +    return true;
>>>> +}
>>>> +
>>>>    static bool migration_switchover_start(MigrationState *s, Error **errp)
>>>>    {
>>>>        ERRP_GUARD();
>>>> @@ -2822,6 +2843,15 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
>>>>
>>>>        qemu_savevm_query_pending_final(s, &pending);
>>>>
>>>> +    /*
>>>> +     * Switchover-ack requests done after switchover decision, are not allowed.
>>>> +     * Fail the migration in this case since we currently don't support going
>>>> +     * back to precopy.
>>>> +     */
>>>> +    if (!migration_switchover_check_switchover_ack_pending(s, errp)) {
>>>> +        return false;
>>>> +    }
>>>> +
>>>>        /* Inactivate disks except in COLO */
>>>>        if (!migrate_colo()) {
>>>>            /*
>>>> --
>>>> 2.40.1
>>>>
>>> --
>>> Peter Xu
>>>
> --
> Peter Xu
>

