Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E1BC44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfYzE-0007Py-Sy; Fri, 03 Jul 2026 04:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wfYzD-0007Pb-BY
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:10:59 -0400
Received: from mail-southcentralusazon11011023.outbound.protection.outlook.com
 ([40.93.194.23] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wfYz9-0004yM-Oz
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:10:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+xC4xxPq4DUUUzGPtz/VKvvF5Nv4EKcKNqLJwuX/kJNdCbi+RRav0xaFeKfs0kGzrJ9BN+awMPtZ3SKgb747XboF4+KSJFCHXZVgkIN3OguDHeRu/vf1H7wW0GFZhM7CKaaOIdSnlFDSmhcxhqB0/Bxnh2DhrtRm1uSh2Ki5rU1O7E3GLnnniat+aeo/4tebe+JSsJkCHUDRwz0CNZu+yn2vi3aW/gYgI+6vEOMq+ga/1dgnZVHMICRcQneDjpmUGxXXdrY0ly/rgqzILkccnkJZq41Hn2JBH8I8CgDJUi9aWo1/hyl+D2Q4gyUMDsJthpa6rkVYqUqkeLPjJtWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhx7AHgQ0wyc/r6ti6VpGkomvsrZGQ1TdnJideWBxSg=;
 b=u1mbbJ/8WMNnZQ9NZxGoEQqoHYg10zI/injo8ojG1R01b9/LpHDAipgfqAyWNvy14+fG2GVZc1TmfC3FAo5tkhulaQS0I4efPL915SIL+2CzTjwE4jt3NHPZCKWoTxsGEE1o0zr8wnnhCMhVmB5EqWFuYisLruq7nK24ZP25alZOkVE5CCFwexdQ+GTjgeqFqKG8Xayjk0NP6FtGPFSnkmq3wUDzTvyGT1/i9LSyCptDrtP43s09LiIMyqd9EoTLFDWdSRSDPEFJnunpH8zdvspYpex43nnq5Fzl/IO0zMfbi2Ftq0ITBNFTIVQZ6B6A6rkyKRYPjsEWrOt0FKs6ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhx7AHgQ0wyc/r6ti6VpGkomvsrZGQ1TdnJideWBxSg=;
 b=iVFC31WEATUodRNxzGEDhjMJWz8gG6Hzj+J9uVUs9KYo3YdzDKAmFGbVfRmqpDfBUNtveM+w4KekEGgivEUDmL/01yjbkmWp0oxnBol9kzY0z60z3B4vGZ5BnkY3aUFBw0jrZqtBXtsy0kdEscrQIB957YEkmabfzhmtROey9rDMym8roGwJYb8LieD/EZF3goZ/BTyj3TmJ4P3qyd6E8hz+E2pmzH52F8RUJ3I8I0dYH4yWJ0B1cZtwMb1o2ydrfKjnCYHlOu71WaJ35taCOOY5km4bKHSRhBAq8PAipBcNSYQ5aBZHX7uamLssDhUVbI/6LheNbBkUS3FkxgnJYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5119.namprd12.prod.outlook.com (2603:10b6:5:392::10)
 by CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 08:05:45 +0000
Received: from DM4PR12MB5119.namprd12.prod.outlook.com
 ([fe80::261:eff5:d149:2d56]) by DM4PR12MB5119.namprd12.prod.outlook.com
 ([fe80::261:eff5:d149:2d56%6]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 08:05:45 +0000
Message-ID: <a82ece02-d9fd-4ea4-b934-a9bc5abde663@nvidia.com>
Date: Fri, 3 Jul 2026 11:05:39 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 08/23] migration: Run final save_query_pending at switchover
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, "Jason J. Herne" <jjhern@linux.ibm.com>,
 Lukas Straub <lukasstraub2@web.de>
References: <20260630043107.1511076-1-clg@redhat.com>
 <20260630043107.1511076-9-clg@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20260630043107.1511076-9-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0189.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::12) To DM4PR12MB5119.namprd12.prod.outlook.com
 (2603:10b6:5:392::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5119:EE_|CY5PR12MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: 4703de54-b808-4e62-8509-08ded8d9e244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|4143699003|5023799004|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: t9mZekIttqsptwtu3Pm7DQ4jKw09Kvuk7QF0xrDR/5rasrl/3DyGBwc7g3ENfScvY3w/wmekij1Cdz9ApYBW+KxTO8S3X7FN5pWRs7JHuMhzoMf5CndyOfBAAuOLfgkOadDo5LHEem/2gmpcfzkpVJ4/XBSeKSbDu+9KGupjdWHnxcNlXmGiLW31uMFV0mzbamuXb7Qf8uJodaELPOm6cYXVVG3N5RwRXJuM5R5eSCsfgXLOm//X5S9ZHO/nkZTDuyEe1GuZ7AxYNUa4iiI1mXlsdJVFHwhTsvzacJy8/1oYrDRSZqP4N6CdCIbBsnpxgegzdFJOgmYLJlXc/oU/LMMoYbNP5RTlzrwrox42miBxIzhDxxeQsud4g1aJpQiJwkbMdSRHqt1qmD6I3VF3hknLOshRpFL8kpkonVQOMWPNszXHRJSMoWVQ8s3jUDszt4x831qPBmIGk/YA2uM63xX5H5OgN3ysaYIMZIEvcsdZLhcEQrYWU+VL+gSX5mLvpKsyAv1pyx85HPNF96+LpoK/cscrciO5HHU3BxS1Q86zQcWm8YXTe198T0fwWBJzKM7lVLp9d4IYTUDQE+U489Ejs+ca6MGAQnVOKuVaTxVJQ4Tlc565u5IW+QrBi8Epx1VYwHFQbm5SjTAQHFU5IA6woUFIRrToCCRzW7LYuy4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5119.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(5023799004)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDR2MDEyb0JiT3ZQYlFkZGZUVmRJdE10OWg1bm4xSFVGcWh5M3VBTzFxL3lV?=
 =?utf-8?B?NFJJbkQwY25XTDR4clY4dktrVGNHNXY4Rm54ZFZCUzRMQlVCSGwzTGhmMTFu?=
 =?utf-8?B?SVpoOGt5WThGZ09qVmJiU2U4NW1Fb2JKRGFqUm9nWEVpL2RrR2lhZUkyU3Vu?=
 =?utf-8?B?MnFnTjUrdmkyRk1ORTNBMWo0ZkJHUHowM2hxZkZQVUM4M2VuUDhRNXpCQ0dI?=
 =?utf-8?B?YlUyWFF1OVl5U2E5alVJRzU0THlrK0t3VGxjcGxGV2lrbFh2ZEFCQ2p0MDJz?=
 =?utf-8?B?WlRJQ3RObkNaYmVUSGwyT1dHRmdqTlF2WmJMcVVDVEN0Z0I2M2lPUDVROTVT?=
 =?utf-8?B?RDJvNTl2cEZOeGxsSDl1cHpBMTR5Y2JqV0pIaDBmM2ZYWjhsTFFxU2FoUFVz?=
 =?utf-8?B?ZFpZcWczeGhNU1FMYjBSbXlqV0ViNER1MnN4VjJnUTVtSTBTUXcydERXKzBZ?=
 =?utf-8?B?aDJuKy92WVNqSU9CNXBibytkYWRYMlViU0xQc0xwV3NvT0d2S0J2b01YZXBm?=
 =?utf-8?B?UmF3d2w4UlVVVGhENHdMQ2VkRUtFeHpVV0MvQ241WXVIQzJhMXRzaVltYWhq?=
 =?utf-8?B?dnhPdVA0WXRZaFVSeCtaWkRrbHg5UjRwOWo3dWlad2twaTFPSEFUNXY0SHNQ?=
 =?utf-8?B?bnMvdWFZajUxeTVUZnB2VlQvcXFydHAwc3VCMGJKbTV4TEhtbWNNenp6eEJD?=
 =?utf-8?B?d0ZRRExIblhhU25QMUVwd08wWFMwMGVKVVB1Z1RGdHZBd1FTbzcxNVFtU0Iz?=
 =?utf-8?B?OHM3dkR2RHJTWTc0YUNUOWdyYXY4UmMwaEJHODVxUUZxVVN6WUhkZ2w4OXB2?=
 =?utf-8?B?N25PK0VTeGRWMDRjUU53UWNKeG1rQ25EcCtFNXhBTTA5WWNGWXNPSjBXZGF3?=
 =?utf-8?B?Q0JJZVNKNnZlb08rRjA0T2dnT3U1Uk0zNGlRZ3RBMkFkN04rYk9VUExZR1hF?=
 =?utf-8?B?QklaTlFHeDBINm9BWUt3VHJ1bnBsdmlrTWgvczBZODU4R0ZodktFOExPY242?=
 =?utf-8?B?M09YK1V6ZDdyR3lIb3pOM3piQWh6UjVwWlRFNDNkVk1VOU0rMzZYVDROQ3da?=
 =?utf-8?B?QU1DanNEbm1qTGdnbW93MjM4R1I3Q3FMWDZFRWdUemNVWTkxa1BOWXM4QUJV?=
 =?utf-8?B?Szd6YnpMZW5Kb2I4dUpwQjBtamdvZmhqM2xSQUNWeVI3U1R4T2VCaVF6V3BH?=
 =?utf-8?B?alVBZnpRTkhIb21hT1YrdWFhVHZaM0hETzRubTM3MjV0dS9JRXRPSkt1aVpV?=
 =?utf-8?B?R2xLN1dxUmhQNU5lUkt2N284cHFKMnFTV09MTG1rNGYyenRmc3AvY3V6Q2lj?=
 =?utf-8?B?UkVsakRiS0F3TlpSK1lOWTJycHM5T2JTYTNlMFVaNURMSzBPcWkvcHNUanEw?=
 =?utf-8?B?cFFLWEF4VkpEc1UxcjhnWThmRDFzUGtQQ01iSTJraTlqU1E1aXZQK05GN09m?=
 =?utf-8?B?RnhPU1JiNUJTMHFDZWs0WC9meGJkbkZ1QjUxQkg0VXo2MFhNemhoeTIzL0Nq?=
 =?utf-8?B?QnJENDBic1lYMGE0eWpaWDZJam9qYXJobzg0Y1BSa1lvTmlocUlNMEtGdEg4?=
 =?utf-8?B?a20vWFY4Zm1sR1NYRnp2WkZGS1ZOaUY4anlJNnY5OFlrenV4MkpGcmt3MXU5?=
 =?utf-8?B?MTZWVWx6T0h5ZkRlSWxmTEd0blZseHBCc0NxMGJMMERDMkZTa3l6anFQT0ZR?=
 =?utf-8?B?MXZ6b1RpQk13R09zRUhQWk5DQ0J2blNHSXlNUmQ5M1MrUCt4Q3hLT3dPdnBs?=
 =?utf-8?B?OWN2Z0ZCTWo3dVlzZmVWU0JKbjNXYzcvUzErYnFETnIwY3hpMnpBRGRvUldv?=
 =?utf-8?B?aUV1SjV6MFZIbzBmL0d5WmhRV3ViNk5VWEx1L0NCWmFuWE40MGZEdkdWOTA2?=
 =?utf-8?B?b1ovWjQ1azhpTnFkTU5DNEdmMmpUQ1czQkhPL2NycUdHNG13OWRwNFRQSkhY?=
 =?utf-8?B?TmJyS1BvQWVaSzB0ZDFpanRJaG92UmNKMUNYTklBWHR6T29oNXJLait1eFN5?=
 =?utf-8?B?bDhOTUlKem8vYXdwVmtMR2JrS3lrNitDSUYwSUc3bzJPMTBrdWcxUUZzL041?=
 =?utf-8?B?UFhqaGp3OTJHdGZYZTJYYmJYOFZwU0hDSzhqVERLK1hqZzVzdVpYdWp3Mkhq?=
 =?utf-8?B?MkJ2VnRhUmZYMkp3M2VZZVdRWC9NdnB2bDJjeGh3VXcrdVNlZE1xb256clBK?=
 =?utf-8?B?dG5hMGtoZkhLNnVKRVV6TU9PQ0NkY2o2T2Q0Y1dxV3luMDlFR3h0VmNXdmVY?=
 =?utf-8?B?UHUxMURDeUY0clprVDlKaEJSR0U2d1dKc0w1Tzd1NXZFYXIzRi9OR0dLNitq?=
 =?utf-8?B?Y09xaHgzRXZJR3ZKM2RUcDBvaDYxZDlvSmtsMGRBaXV2bVdOLzJRUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4703de54-b808-4e62-8509-08ded8d9e244
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5119.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 08:05:45.0826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJqgvGiQ2oa7syntAtpZRgjBC9GJliEc4+1vWzsHWo8kj2QRl+2XJmao7mHXuiXzHAl2y8AsI4PY22Yzri1hxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478
Received-SPF: permerror client-ip=40.93.194.23;
 envelope-from=avihaih@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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


On 6/30/2026 7:30 AM, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> From: Avihai Horon <avihaih@nvidia.com>
>
> Before switchover, the source needs one last exact pending query so
> modules can flush dirty state. This is currently done ad hoc in modules
> handlers. For example, RAM syncs its dirty bitmap in its save_complete
> handler.
>
> This should be a general concept relevant for any module, so extract it
> to migration core instead by running a final save_query_pending before
> switchover.
>
> The final query requires special handling by modules (e.g., it's called
> with BQL locked, during VM stop), so extend save_query_pending
> SaveVMHandlers callback and qemu_savevm_query_pending() with a "final"
> flag so migration modules can tell the last pending query during
> switchover from periodic iteration queries.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Reviewed-by: Jason J. Herne <jjhern@linux.ibm.com>
> Link: https://lore.kernel.org/qemu-devel/20260622101214.25770-4-avihaih@nvidia.com
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/migration/register.h   | 41 ++++++++++++++++++----------------
>   migration/savevm.h             |  3 ++-
>   hw/s390x/s390-stattrib.c       |  2 +-
>   hw/vfio/migration.c            | 11 ++++++---
>   migration/block-dirty-bitmap.c | 11 ++++++---
>   migration/migration.c          | 14 ++++++++++--
>   migration/ram.c                | 40 +++++++++++++++++++--------------
>   migration/savevm.c             | 20 +++++++++++++----
>   hw/vfio/trace-events           |  2 +-
>   migration/trace-events         |  2 +-
>   10 files changed, 94 insertions(+), 52 deletions(-)
>
> diff --git a/include/migration/register.h b/include/migration/register.h
> index 5e5e0ee432e537781ce78e84b2ff2d81c33e8f37..6f632123f1d0710de0556e68ba53e068a1e02640 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -171,6 +171,28 @@ typedef struct SaveVMHandlers {
>        */
>       bool (*is_active_iterate)(void *opaque);
>
> +    /**
> +     * @save_query_pending
> +     *
> +     * This estimates the remaining data to transfer on the source side.
> +     *
> +     * When @exact is true, a module must report accurate results.  When
> +     * @exact is false, a module may report estimates.
> +     *
> +     * It's highly recommended that modules implement a faster version of
> +     * the query path (for example, by proper caching on the counters) if
> +     * an accurate query will be time-consuming.
> +     *
> +     * @opaque: data pointer passed to register_savevm_live()
> +     * @pending: pointer to a MigPendingData struct
> +     * @exact: set to true for an accurate (slow) query
> +     * @final: set to true for the final query during switchover. When final is
> +     * true, the query is called with BQL locked. Otherwise, it's called with
> +     * BQL unlocked.
> +     */
> +    void (*save_query_pending)(void *opaque, MigPendingData *pending,
> +                               bool exact, bool final);
> +
>       /* This runs outside the BQL in the migration case, and
>        * within the lock in the savevm case.  The callback had better only
>        * use data that is local to the migration thread or protected
> @@ -210,25 +232,6 @@ typedef struct SaveVMHandlers {
>        */
>       bool (*save_postcopy_prepare)(QEMUFile *f, void *opaque, Error **errp);
>
> -    /**
> -     * @save_query_pending
> -     *
> -     * This estimates the remaining data to transfer on the source side.
> -     *
> -     * When @exact is true, a module must report accurate results.  When
> -     * @exact is false, a module may report estimates.
> -     *
> -     * It's highly recommended that modules implement a faster version of
> -     * the query path (for example, by proper caching on the counters) if
> -     * an accurate query will be time-consuming.
> -     *
> -     * @opaque: data pointer passed to register_savevm_live()
> -     * @pending: pointer to a MigPendingData struct
> -     * @exact: set to true for an accurate (slow) query
> -     */
> -    void (*save_query_pending)(void *opaque, MigPendingData *pending,
> -                               bool exact);
> -
>       /**
>        * @load_state
>        *
> diff --git a/migration/savevm.h b/migration/savevm.h
> index b6bb4fa977fae84ed121b0668cdefdf49e3d9c67..81abd96dda94c6c95cc40b3c188df23d11c19463 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -45,7 +45,8 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
>   void qemu_savevm_state_cleanup(void);
>   void qemu_savevm_state_complete_postcopy(QEMUFile *f);
>   int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp);
> -void qemu_savevm_query_pending(MigPendingData *pending, bool exact);
> +void qemu_savevm_query_pending_iter(MigPendingData *pending, bool exact);
> +void qemu_savevm_query_pending_final(MigPendingData *pending);
>   int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
>   bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
>   void qemu_savevm_state_end(QEMUFile *f);
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index c334714b31ab4313e26c0cf57091a8cb21e55306..b0f04eb30c7f73e5dd91b1345d71a14cb404a4eb 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -190,7 +190,7 @@ static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
>   }
>
>   static void cmma_state_pending(void *opaque, MigPendingData *pending,
> -                               bool exact)
> +                               bool exact, bool final)
>   {
>       S390StAttribState *sas = S390_STATTRIB(opaque);
>       S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index fb12b9717f773fdde657911517de9d74c1eb3931..195498845ed95d6a55cf68537a100b4e83221fb0 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -622,13 +622,18 @@ static void vfio_state_pending_sync(VFIODevice *vbasedev)
>   }
>
>   static void vfio_state_pending(void *opaque, MigPendingData *pending,
> -                               bool exact)
> +                               bool exact, bool final)
>   {
>       VFIODevice *vbasedev = opaque;
>       VFIOMigration *migration = vbasedev->migration;
>       uint64_t precopy_size, stopcopy_size;
>
> -    if (exact) {
> +    /*
> +     * The final pending query runs during switchover downtime. VFIO does not
> +     * need a fresh device pending-data query then to get the latest dirty
> +     * data, so avoid the extra work and report the cached counters below.
> +     */
> +    if (exact && !final) {
>           vfio_state_pending_sync(vbasedev);
>       }
>
> @@ -646,7 +651,7 @@ static void vfio_state_pending(void *opaque, MigPendingData *pending,
>
>       trace_vfio_state_pending(vbasedev->name, migration->stopcopy_size,
>                                migration->precopy_init_size,
> -                             migration->precopy_dirty_size, exact);
> +                             migration->precopy_dirty_size, exact, final);
>   }
>
>   static bool vfio_is_active_iterate(void *opaque)
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 7ef3759e5348a6907c0fb3773e2c6cbb0850632e..cba54e25cd50da924e1958bdfc23ce060784b0ac 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -767,13 +767,16 @@ static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
>   }
>
>   static void dirty_bitmap_state_pending(void *opaque, MigPendingData *data,
> -                                       bool exact)
> +                                       bool exact, bool final)
>   {
>       DBMSaveState *s = &((DBMState *)opaque)->save;
>       SaveBitmapState *dbms;
>       uint64_t pending = 0;
>
> -    bql_lock();
> +    /* Final pending query is called with BQL locked */
> +    if (!final) {
> +        bql_lock();
> +    }
>
>       QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
>           uint64_t gran = bdrv_dirty_bitmap_granularity(dbms->bitmap);
> @@ -783,7 +786,9 @@ static void dirty_bitmap_state_pending(void *opaque, MigPendingData *data,
>           pending += DIV_ROUND_UP(sectors * BDRV_SECTOR_SIZE, gran);
>       }
>
> -    bql_unlock();
> +    if (!final) {
> +        bql_unlock();
> +    }
>
>       trace_dirty_bitmap_state_pending(pending);
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 0f9e891cf85c8e5074f7f9800515e244fa413fa2..ea0b236597087cc005541e1916ceabb229afab4b 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2787,12 +2787,22 @@ static bool migration_switchover_prepare(MigrationState *s)
>   static bool migration_switchover_start(MigrationState *s, Error **errp)
>   {
>       ERRP_GUARD();
> +    MigPendingData pending = {};
>
>       if (!migration_switchover_prepare(s)) {
>           error_setg(errp, "Switchover is interrupted");
>           return false;
>       }
>
> +    /*
> +     * The final query to the whole system on dirty data to make sure we
> +     * collect the latest status of the VM.  For precopy, source QEMU will
> +     * dump all the dirty data during switchover.  For postcopy, this will
> +     * properly update all the dirty bitmaps to finally generate the
> +     * correct discard bitmaps; see ram_postcopy_send_discard_bitmap().
> +     */
> +    qemu_savevm_query_pending_final(&pending);
> +
>       /* Inactivate disks except in COLO */
>       if (!migrate_colo()) {
>           /*
> @@ -3285,7 +3295,7 @@ static void migration_iteration_go_next(MigPendingData *pending)
>       /*
>        * Do a slow sync first before boosting the iteration count.
>        */
> -    qemu_savevm_query_pending(pending, true);
> +    qemu_savevm_query_pending_iter(pending, true);
>
>       /*
>        * Update the dirty information for the whole system for this
> @@ -3336,7 +3346,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>       bool complete_ready;
>
>       /* Fast path - get the estimated amount of pending data */
> -    qemu_savevm_query_pending(&pending, false);
> +    qemu_savevm_query_pending_iter(&pending, false);
>
>       if (in_postcopy) {
>           /*
> diff --git a/migration/ram.c b/migration/ram.c
> index 55aa9b47dc8ab8463fd1aeba19726a493b81b070..8918b2f03b6fbcc98532bb45ab905f9bac59384c 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2686,9 +2686,6 @@ void ram_postcopy_send_discard_bitmap(MigrationState *ms)
>
>       RCU_READ_LOCK_GUARD();
>
> -    /* This should be our last sync, the src is now paused */
> -    migration_bitmap_sync_precopy(true);
> -
>       /* Easiest way to make sure we don't resume in the middle of a host-page */
>       rs->pss[RAM_CHANNEL_PRECOPY].last_sent_block = NULL;
>       rs->last_seen_block = NULL;
> @@ -3376,10 +3373,6 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>       rs->last_stage = !migration_in_colo_state();
>
>       WITH_RCU_READ_LOCK_GUARD() {
> -        if (!migration_in_postcopy()) {
> -            migration_bitmap_sync_precopy(true);
> -        }
> -

(Got some technical issues receiving QEMU ML mails that I'm not CCed to, 
so replying here for Stefan's mail [1])

Seems like this patch overlooked the COLO case which calls 
ram_save_complete() on each checkpoint and expects the RAM complete 
handler to sync RAM dirty bitmap.
This patch moved this dirty sync from ram_save_complete() (the removed 
lines above) into a qemu_savevm_query_pending_final() called only once 
at migration_switchover_start().

I believe this is the root cause for the CI failure reported by Stefan, 
since I was able to repro this locally [2] and the diff below [3] fixed 
the issue [4].

I have zero knowledge in COLO so would really appreciate some feedback 
from Peter/COLO folks if that's a valid fix.

Thanks.

[1] 
https://lore.kernel.org/qemu-devel/CAJSP0QX-8L2CSX5q95Md5V6NTE_4p+K8Kr-QGbqKm2BBMtdh5Q@mail.gmail.com/

[2]

QTEST_QEMU_BINARY=./qemu-system-x86_64  ./tests/qtest/migration-test -k 
--full -r /x86_64/migration/colo
[...]
# Running /x86_64/migration/colo/plain/secondary_failover
# Using machine type: pc-q35-11.1
# starting QEMU: exec ./qemu-system-x86_64 -qtest 
unix:/tmp/qtest-1415533.sock -qtest-log /dev/null -chardev 
socket,path=/tmp/qtest-1415533.qmp,id=char0 -mon 
chardev=char0,mode=control -display none -audio
none -run-with exit-with-parent=on -accel kvm -accel tcg -machine 
pc-q35-11.1, -name source,debug-threads=on -machine 
memory-backend=mig.mem -object 
memory-backend-ram,id=mig.mem,size=150M,share=off -serial
  file:/tmp/migration-test-GF36R3/src_serial -drive 
if=none,id=d0,file=/tmp/migration-test-GF36R3/bootsect,format=raw 
-device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot 2>/dev/null  
-accel qtest
# starting QEMU: exec ./qemu-system-x86_64 -qtest 
unix:/tmp/qtest-1415533.sock -qtest-log /dev/null -chardev 
socket,path=/tmp/qtest-1415533.qmp,id=char0 -mon 
chardev=char0,mode=control -display none -audio
none -run-with exit-with-parent=on -accel kvm -accel tcg -machine 
pc-q35-11.1, -name target,debug-threads=on -machine 
memory-backend=mig.mem -object 
memory-backend-ram,id=mig.mem,size=150M,share=off -serial
  file:/tmp/migration-test-GF36R3/dest_serial -incoming defer -drive 
if=none,id=d0,file=/tmp/migration-test-GF36R3/bootsect,format=raw 
-device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot 2>/dev/null  -a
ccel qtest
Memory content inconsistency at ea2000 first_byte = 53 last_byte = 53 
current = 54 hit_edge = 0
Memory content inconsistency at ea3000 first_byte = 53 last_byte = 53 
current = 54 hit_edge = 0
Memory content inconsistency at ea4000 first_byte = 53 last_byte = 53 
current = 54 hit_edge = 0
Memory content inconsistency at ea5000 first_byte = 53 last_byte = 53 
current = 54 hit_edge = 0
Memory content inconsistency at ea6000 first_byte = 53 last_byte = 53 
current = 54 hit_edge = 0
Memory content inconsistency at ea7000 first_byte = 53 last_byte = 53 
current = 54 hit_edge = 0
Memory content inconsistency at ea8000 first_byte = 53 last_byte = 53 
current = 54 hit_edge = 0
Memory content inconsistency at ea9000 first_byte = 53 last_byte = 53 
current = 54 hit_edge = 0
Memory content inconsistency at eaa000 first_byte = 53 last_byte = 53 
current = 54 hit_edge = 0
Memory content inconsistency at eab000 first_byte = 53 last_byte = 53 
current = 54 hit_edge = 0
and in another 13488 pages**
ERROR:../tests/qtest/migration/framework.c:190:check_guests_ram: 
assertion failed: (bad == 0)
not ok /x86_64/migration/colo/plain/secondary_failover - 
ERROR:../tests/qtest/migration/framework.c:190:check_guests_ram: 
assertion failed: (bad == 0)
Bail out!

[3]

diff --git a/migration/colo.c b/migration/colo.c
index 2d36f933cf..5c486c09ef 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -409,6 +409,7 @@ static int 
colo_do_checkpoint_transaction(MigrationState *s,
                                            QEMUFile *fb)
  {
      Error *local_err = NULL;
+    MigPendingData pending = {};
      int ret = -1;

      colo_send_message(s->to_dst_file, COLO_MESSAGE_CHECKPOINT_REQUEST,
@@ -465,6 +466,18 @@ static int 
colo_do_checkpoint_transaction(MigrationState *s,
      if (migrate_auto_converge()) {
          mig_throttle_counter_reset();
      }
+
+    /*
+     * Run the final pending query so migration modules can flush their 
dirty
+     * state (e.g., RAM syncs its dirty bitmap) before this 
checkpoint's live
+     * state is saved. Unlike a regular switchover, COLO reaches completion
+     * repeatedly for every checkpoint, so this must be done on each one.
+     */
+    if (!qemu_savevm_query_pending_final(s, &pending, &local_err)) {
+        bql_unlock();
+        goto out;
+    }
+
      /*
       * Only save VM's live state, which not including device state.
       * TODO: We may need a timeout mechanism to prevent COLO process

[4]

QTEST_QEMU_BINARY=./qemu-system-x86_64  ./tests/qtest/migration-test -k 
--full -r /x86_64/migration/colo
[...]
# Running /x86_64/migration/colo/plain/secondary_failover
# Using machine type: pc-q35-11.1
# starting QEMU: exec ./qemu-system-x86_64 -qtest 
unix:/tmp/qtest-1417324.sock -qtest-log /dev/null -chardev 
socket,path=/tmp/qtest-1417324.qmp,id=char0 -mon 
chardev=char0,mode=control -display none -audio
none -run-with exit-with-parent=on -accel kvm -accel tcg -machine 
pc-q35-11.1, -name source,debug-threads=on -machine 
memory-backend=mig.mem -object 
memory-backend-ram,id=mig.mem,size=150M,share=off -serial
  file:/tmp/migration-test-0TMNR3/src_serial -drive 
if=none,id=d0,file=/tmp/migration-test-0TMNR3/bootsect,format=raw 
-device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot 2>/dev/null  
-accel qtest
# starting QEMU: exec ./qemu-system-x86_64 -qtest 
unix:/tmp/qtest-1417324.sock -qtest-log /dev/null -chardev 
socket,path=/tmp/qtest-1417324.qmp,id=char0 -mon 
chardev=char0,mode=control -display none -audio
none -run-with exit-with-parent=on -accel kvm -accel tcg -machine 
pc-q35-11.1, -name target,debug-threads=on -machine 
memory-backend=mig.mem -object 
memory-backend-ram,id=mig.mem,size=150M,share=off -serial
  file:/tmp/migration-test-0TMNR3/dest_serial -incoming defer -drive 
if=none,id=d0,file=/tmp/migration-test-0TMNR3/bootsect,format=raw 
-device ide-hd,drive=d0,secs=1,cyls=1,heads=1 -snapshot 2>/dev/null  -a
ccel qtest
ok 2 /x86_64/migration/colo/plain/secondary_failover

>           ret = rdma_registration_start(f, RAM_CONTROL_FINISH);
>           if (ret < 0) {
>               qemu_file_set_error(f, ret);
> @@ -3442,25 +3435,38 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>       return qemu_fflush(f);
>   }
>
> -static void ram_state_pending(void *opaque, MigPendingData *pending,
> -                              bool exact)
> +static void ram_state_pending_sync(bool exact, bool final)
>   {
> -    RAMState **temp = opaque;
> -    RAMState *rs = *temp;
> -    uint64_t remaining_size;
> -
>       /*
>        * Sync is not needed either with: (1) a fast query, or (2) after
>        * postcopy has started (no new dirty will generate anymore).
>        */
> -    if (exact && !migration_in_postcopy()) {
> +    if (!exact || migration_in_postcopy()) {
> +        return;
> +    }
> +
> +    /* Final pending query is called with BQL locked */
> +    if (!final) {
>           bql_lock();
> -        WITH_RCU_READ_LOCK_GUARD() {
> -            migration_bitmap_sync_precopy(false);
> -        }
> +    }
> +
> +    WITH_RCU_READ_LOCK_GUARD() {
> +        migration_bitmap_sync_precopy(final);
> +    }
> +
> +    if (!final) {
>           bql_unlock();
>       }
> +}
> +
> +static void ram_state_pending(void *opaque, MigPendingData *pending,
> +                              bool exact, bool final)
> +{
> +    RAMState **temp = opaque;
> +    RAMState *rs = *temp;
> +    uint64_t remaining_size;
>
> +    ram_state_pending_sync(exact, final);
>       remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
>
>       if (migrate_postcopy_ram()) {
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 7e2a0c2b4a7470d9c2159eac1d18ae891740fe3e..74d622583e345bdc96b9189aad0c8f6bad41964d 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1801,7 +1801,8 @@ int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp)
>       return 0;
>   }
>
> -void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
> +static void qemu_savevm_query_pending(MigPendingData *pending, bool exact,
> +                                      bool final)
>   {
>       SaveStateEntry *se;
>
> @@ -1814,7 +1815,7 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
>           if (!qemu_savevm_state_active(se)) {
>               continue;
>           }
> -        se->ops->save_query_pending(se->opaque, pending, exact);
> +        se->ops->save_query_pending(se->opaque, pending, exact, final);
>       }
>
>       pending->total_bytes = pending->precopy_bytes +
> @@ -1826,13 +1827,24 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
>        * close to reality when this got invoked frequently while iterating.
>        */
>       mig_stats.dirty_bytes_total = pending->total_bytes;
> -
> -    trace_qemu_savevm_query_pending(exact, pending->precopy_bytes,
> +    trace_qemu_savevm_query_pending(exact, final, pending->precopy_bytes,
>                                       pending->stopcopy_bytes,
>                                       pending->postcopy_bytes,
>                                       pending->total_bytes);
>   }
>
> +void qemu_savevm_query_pending_iter(MigPendingData *pending, bool exact)
> +{
> +    qemu_savevm_query_pending(pending, exact, false);
> +}
> +
> +void qemu_savevm_query_pending_final(MigPendingData *pending)
> +{
> +    g_assert(bql_locked());
> +
> +    qemu_savevm_query_pending(pending, true, true);
> +}
> +
>   void qemu_savevm_state_cleanup(void)
>   {
>       SaveStateEntry *se;
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 4c28b3291cc687c06490bdd090f393b67c9c4d88..fa2204f002970c31eb987ae13113a9a5edb3e172 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -176,7 +176,7 @@ vfio_save_device_config_state(const char *name) " (%s)"
>   vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size %"PRIu64" precopy dirty size %"PRIu64
>   vfio_save_iterate_start(const char *name) " (%s)"
>   vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
> -vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact) " (%s) stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64 " exact %d"
> +vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact, bool final) " (%s) stopcopy size %"PRIu64", precopy initial size %"PRIu64", precopy dirty size %"PRIu64", exact %d, final %d"
>   vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
>   vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
>
> diff --git a/migration/trace-events b/migration/trace-events
> index de99d976abc637e9361f8467daacf3cc8787976f..1c9212d3e20555902f008e4c999f32642cc8fa48 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -7,7 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
>   qemu_loadvm_state_post_main(int ret) "%d"
>   qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
>   qemu_savevm_send_packaged(void) ""
> -qemu_savevm_query_pending(bool exact, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy, uint64_t total) "exact=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64", total=%"PRIu64
> +qemu_savevm_query_pending(bool exact, bool final, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy, uint64_t total) "exact=%d, final=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64", total=%"PRIu64
>   loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
>   loadvm_state_setup(void) ""
>   loadvm_state_cleanup(void) ""
> --
> 2.54.0
>

