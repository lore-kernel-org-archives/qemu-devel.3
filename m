Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F18C103A9BD
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 14:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5P1R-0000Qr-2s; Wed, 25 Mar 2026 10:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1w5P1D-0000Na-Vc
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 10:15:46 -0400
Received: from mail-centralusazon11010065.outbound.protection.outlook.com
 ([52.101.61.65] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1w5P1B-0006T4-FQ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 10:15:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwORGffdbpyduIiFra7kqzp3gM2Bbgv9kGlEoH0gRq6kS5f0OanNHgcK1Ckk3biYucU+xJVbC+XJI1jyx/12eXqHuXAVWNUMUEvEZZ/Sdn+kDhK4zGncicvW0bj4f7fTMovkHR+4NJ8jczAH3rhwMKY58ovaNhdwLSXtShPz9ENhocZIloK4T/sve0iWT55VoNU0pDdFltC/2YxarqMiYBA5kH/RDfwrianaYdxd4ag2qotG0CQBNIoo7XXXEaRyxC6M0MRlF9f8UIsD/6+uG3qMI9LBgc951xb6WseGjk4l/yKvLZhBI8BIsdQcM0rUl7qw4nbNiSOX4SUTLjEcWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIrkk4vSGE/daPZbyz2jGBIhKLsJrMO3S1WkvRbrwhM=;
 b=TsuwpaOV76NBHB4ih97Bj86aVBHjBuVet4ahgiVb1kC/+BDkOiHkXhS48NBkKSLWo5eWI3UxKOtnIthZCbXD8PtJhihKdwWU35Akpx3bpc+EGj9PUa69aYYmx5WhiOm38J1Go4mXOhSzCxpk2peWhVV6be+BNywVbDFOhX+GkBY2YxeIhc9UCqGE71JS1AkN9nNhBRFsOqHp15piU7suJtcJ9MeH2/AUERQpXT+ZbEyt9JhMjyNEb3mdHE3faNZDFwl4Q0y1PhzoSaebxytGb2cuTa51bddBdQKhxuLj5zJuJLDSeUwUNr+C2EBrSkwyyik9jSZIQAJptEnTIVmZLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIrkk4vSGE/daPZbyz2jGBIhKLsJrMO3S1WkvRbrwhM=;
 b=djTPw6DgX7mym1ELq7d64lVh0v3JoVkMFGBjBElRT/pIQ9IGrMMuxCHsJXhJYEtIVZ3os63oIhTO23NklXhmBAzYDfkWhRbxh3PFTZuAWOkNcSNA9p54pdj2kHwgJRPhifwT9J4dvuvhlkL0Tlben7Tk+7pbGsp8A0DWjkLWqJLiwYaFS08mSQYMpLUkghoCrYc9Y62PlaXw3jtuDvgVFVaX6Urz7Wh+4Nd1HrkJnUIaMuCXKzvFF0Qt1nq1bB8j3Ui/YvSCgt5gqR9TFCkMEOFtBlnE9Vjx+ga2Ux2P0ky0fJF6azzLRyJNksYhiUHrQCkaAyq4iPMNHEH5f7hCQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Wed, 25 Mar
 2026 14:10:20 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%5]) with mapi id 15.20.9769.004; Wed, 25 Mar 2026
 14:10:20 +0000
Message-ID: <d075580a-ad4f-4047-b012-e5d9e4d6bc80@nvidia.com>
Date: Wed, 25 Mar 2026 16:10:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/12] vfio/migration: Throttle vfio_save_block() on
 data size to read
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, Alex Williamson
 <alex@shazbot.org>, Yishai Hadas <yishaih@nvidia.com>,
 Fabiano Rosas <farosas@suse.de>, Pranav Tyagi <prtyagi@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-4-peterx@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20260319231302.123135-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::15) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|DM6PR12MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: d291cbf2-ca93-47a7-29ac-08de8a783f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: KxDZJ1YlTPY8id68QQoIAKmjqyKxplTKIhoX2NImfgd2yp1gnnzja3ZeZJ9ckODqpL7HbnqKXG40/eChvyOWhFmcjySrjLCVk2svFnPjXLsm/VOg2OvJHNqXEtavzPWBhs6kCEbfSDGSwXG5ehQrhxCfhoTDIGy15GIOF/D7i2b8exRC/+OWtair/0+u4fPzuDG8+nRGE63I4H7rkWGCcdPXuXeyeXV3rjTD+kl+7juWcTGsNxqcRUD/DcBN0ZN+cTIsHelofcUExRgKoOkiA1fXzC0Bdys0BjJqjrbF4GZMf0k3QbzHk1y0Sj7X4Mu2ciXFWEFow71ts4pgCDC7ILNSwFZe/3h5QOroVUBufOi7q5gXfU+LMGLY4c1yKuTC4kBNZFqM70kqN7pVmT7mF4LB/H12IcHfryYIKSoOxgBYQ2cR7kg5yFdEaGZ93xl7/81jaycN9NspkYtv8q9Pc7CnBe9h8hwRW4lLuV3xjowogOMhzJ1zjxEP1gJGbG1SUBzTNBqhBmKDYJkL5p79TOjpi9jGIfH3fcWmbP/BIK4lwxPgijkkYnfdl9lro+PxKMI4363S0TdzOm/wdr1ksCKu4COcm/tDfAVjFGOhoE8YYvPE7Gmn8TDDmayYDpKTg5Njeg7DOpyNMG9xRu5nZ3SF5kQ8DAmRY7nHP1VL6D09l40q7gXaVkAYJU0ybay+riCGpU4Cm3dH7RlYvU/KLWEwnxQbcWHFTPvTbpxakh8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sjd3RyszN1E5K01QaFVUWHZSL1J4VjY5MDlSSHZXQ0RsVTN4SGJraUVEbjJk?=
 =?utf-8?B?V2x0MjB4aEhIaGVaWHpYa2tGMVdLaFEybW5scjNvWTBZYW9tNVdvSFVzbmZx?=
 =?utf-8?B?RS9ENVlaNWZleVZNUkx1a2RqaHUrL09DWHRvd1BmbU85QnhNQU5zSEJIcVdD?=
 =?utf-8?B?ZDBBRnEvbXpRcWw2Z2t1VVFpV2o5NkRDakdQdmZtNERrS2NVYnNkUXFBWVRG?=
 =?utf-8?B?Sm5UdXczUndTVjNuQTZDR2t3ck1EQ1JINjE0bHRnYlN2ZjVhQm4xTDVucUx0?=
 =?utf-8?B?VTdCeHJYd0c5RXdrU01PdHBYbngyUGVuUDVoMDM3d0NWQUxyb2lJVDBiNHdH?=
 =?utf-8?B?S25FNTNXRVBxdGtDc1BVRXlaemFvMTR4TEtmSVd6SmpNN2RkWEx0MEJoM1Jh?=
 =?utf-8?B?bXF6cmxqUHU5eElVRW5IdFgrSk9xdG00N0ZMQ1g2QkJvRnIybmlxcGd5czVK?=
 =?utf-8?B?RnlTN1NLVW9sVDNzalFnKzMzellKU0NRK2xqdnYwTnBSeVQwVFJ0d0lqUU9Q?=
 =?utf-8?B?OHVicWNxMWxXcXlWWDJqK1ZtV1lRL2tRdzduSitmaEdMRmM4d21zdDR2NjY0?=
 =?utf-8?B?aWE4MXgxaVdUY3NaRWxrVGtjRy8xdHpDT2ZiR0NDd1R4VDEwY0U5VDY2Y1dO?=
 =?utf-8?B?N25YZTZzV1MvVWpsU0J3NlgrcjJ5SkF3WVVtb1RwTlRKQTlLOVNUa2FPMzQ4?=
 =?utf-8?B?dzBiZDlBYlVaZThqSXM4ZVEwbzY3L1lIZ0ROUHJKMUJqdHk1eXZZK0tiZDIv?=
 =?utf-8?B?MjF1cTV2eitKUDZsbHY1SEg5OW9VcHdQVXVUeFVZZlJzM1BndHZaVDVPUGZs?=
 =?utf-8?B?WG5YaGJQKzVEd3NUcDl4QlVXYU4ySW12TTRuVFRCdkVyb3QvMnJadWE1Um9n?=
 =?utf-8?B?K1AvT2FuMTUzU2xLK0xKQ29HcWt4bHhEcGZtNVYzek5jd2dVbUM5b0tPcnRF?=
 =?utf-8?B?MWVlR1FCNlYzU1dYZmdxbzk1dS9PQkptV0p2MDR4eHFKQlRlRytQYUc4dVBt?=
 =?utf-8?B?amdENEJtcFdZMUkyUUhvOTE5bzUweXVKQ3Y5R1dDUHJIT2wxWExWZEVQWEhz?=
 =?utf-8?B?Rm4xMHRJOW9GMG1VMGNxbEN2cUc2VEc2Z3hYVkZENENyNHpPYytibVlnZXJM?=
 =?utf-8?B?ZXB3UWVEOWJGWG0ybkJ4dlpuWG83TnJVdjg1ZWxXR1VDZ2JKa0hINjM0b1Uv?=
 =?utf-8?B?bDFsVWRlYXJBRnFFQkxIU2oxWk9PTllYbDVySmpsUUFrOTBWRXMzNENESHY4?=
 =?utf-8?B?LzlPQm1zVDdTdVlidmJxcHh1OXUwWFFxQ2NKVmRKY1UxODU5T1NzTEU2L0Vj?=
 =?utf-8?B?Nm9pYVUya2RMZSszWG5SMzBicTArUmRNU1p1MzJ0YjcxOGdUZFJXVVJwK1ND?=
 =?utf-8?B?L25Hc3VwbkhnT2FCSTJvR1c5UTNIN0lNM3FOMnk0eU43RGxISVBsYnB1Ukt6?=
 =?utf-8?B?cjh4aFhCV0VkUmFBOHQ0Q3U2VEVPdU5WY21Ja1FkVEN1WTcraDdGMXBiZ1J3?=
 =?utf-8?B?NWdrZ3pLNDJETDJkUENWRHF4KzY5cmdqdWF3Rnl2cHkvSHBaa001UUJOa2xr?=
 =?utf-8?B?ZHZlK3Q4djFFY0lmZTJlekZ1R2Y1cGpFNGk4OWIxcVlDNGd0TGxPcFc0bzVu?=
 =?utf-8?B?UDVFWGdXVFUzekpHS0NFNmF4OWN4cWZmQndRYmVqTW8yWERkZXVzSjRtd2w2?=
 =?utf-8?B?MGxZSXRyd2RzNDNUUzBrVDhQMTQ3eFZuSTRhYy9IZW8vdks3UEZMMVo5ak1u?=
 =?utf-8?B?emhYbVZJeDFESWNWYXBLc210OTRPWlR6U1BDbzN6ZVJ6Tk5YUkxnR2xpREMz?=
 =?utf-8?B?ZldRT3FLREJsVjROMUllSjA1dGxMUGFQS0VPOWJWbnZ1UFNPd05kL0paUFZ6?=
 =?utf-8?B?SUZNK0EzbnNUMGRSYXBDN2FDV2kvbnpGZnZFdVVmNDFSNDNxQldrNk9tR3JN?=
 =?utf-8?B?bTIwSHNKdlo4Qi9RNHNqYzVwNjM4NUxGUS9mVGorVWZqVEJCcFo4alllYkU4?=
 =?utf-8?B?ckwvOUtVQWZ3aWFzTmRoOWFEZ3d3SGhuY0JLQXBGV2QxZmtpb2lCRFlUYkpk?=
 =?utf-8?B?aDVHRllSUFQreHhETUhKY2ZMWDc1YXdLZlh6U3V0a0pyQjcrRGZFTmtpUE9x?=
 =?utf-8?B?dUFNbEEwL2JHYUhjejZvc1dnOWx0N3drM3V5K3BvTURGWGhHSkdzZXJ4azlE?=
 =?utf-8?B?cWJZRU1WdnF0Vm0xZUFJbGEzaFZmTFdVY2hiMmxxOGpkVXVGcUhvWGNlNlRP?=
 =?utf-8?B?S3kzV3lZMkRPYmZHd0JEbVgzMVdYWFZRK3UyaFoyL09tR1lJckh0Y1ZYWThJ?=
 =?utf-8?B?aHRicktUOXdkRzArYU5rOW1lM0RoM1hVU1hyU0ZHNGxnYTQ1Z2xyZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d291cbf2-ca93-47a7-29ac-08de8a783f58
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 14:10:19.9630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7Q89TvA4aUb+nuE75r5PwO6kMtDchRarlvBuOMhZxg3cO2p9DQ2EuSdLLZOj70Xx2eP4Dd7xRbTbGOmejxhtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
Received-SPF: permerror client-ip=52.101.61.65;
 envelope-from=avihaih@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Peter,

Thanks for sending this series.

On 3/20/2026 1:12 AM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> During precopy phase, VFIO maintains two counters for init/dirty data
> tracking for query estimations.
>
> VFIO fetches data during precopy by reading from the VFIO fd, after
> fetching it'll deduct the read size.
>
> Here since the fd's size can dynamically change, I think it means VFIO may
> read more than what it "thought" were there for fetching.
>
> I highly suspect it's also relevant to a weird case in the function of
> vfio_update_estimated_pending_data(), where when VFIO reads 0 from the FD
> it will _reset_ the two counters, instead of asserting both of them being
> zeros, which looks pretty hackish.
>
> Just guarantee it from userspace level that VFIO won't read more than what
> it expects for now.

The VFIO_MIG_GET_PRECOPY_INFO ioctl returns an estimation of the data 
size currently available for reading. So, even if the ioctl returns X 
bytes, it may be that there are more than X bytes to read or less than X 
bytes.
The code was written in a flexible way to handle such discrepancies.

Because we are dealing with an estimation, I don't think we can assert 
that the counters are zero, and I don't think reading only up to the 
cached size gives us any benefit:
If the estimation is lower than actual available data, we are just 
deferring sending of the remaining data to a later stage.
If the estimation is higher than actual available data, we may still 
read() zero when the cached values are not zero.

I think we should keep the code as is.

Does that make sense?

Thanks.

>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/vfio/migration.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 83327b6573..851ea783f3 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -357,12 +357,18 @@ static int vfio_query_precopy_size(VFIOMigration *migration)
>   }
>
>   /* Returns the size of saved data on success and -errno on error */
> -static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
> +static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration,
> +                               bool precopy)
>   {
> -    ssize_t data_size;
> +    ssize_t data_size = migration->data_buffer_size;
> +
> +    if (precopy) {
> +        /* Limit the buffer size to make sure cached stats don't overflow */
> +        data_size = MIN(data_size, migration->precopy_init_size +
> +                        migration->precopy_dirty_size);
> +    }
>
> -    data_size = read(migration->data_fd, migration->data_buffer,
> -                     migration->data_buffer_size);
> +    data_size = read(migration->data_fd, migration->data_buffer, data_size);
>       if (data_size < 0) {
>           /*
>            * Pre-copy emptied all the device state for now. For more information,
> @@ -623,7 +629,7 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
>           migration->event_save_iterate_started = true;
>       }
>
> -    data_size = vfio_save_block(f, migration);
> +    data_size = vfio_save_block(f, migration, true);
>       if (data_size < 0) {
>           return data_size;
>       }
> @@ -667,7 +673,7 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>       }
>
>       do {
> -        data_size = vfio_save_block(f, vbasedev->migration);
> +        data_size = vfio_save_block(f, vbasedev->migration, false);
>           if (data_size < 0) {
>               return data_size;
>           }
> --
> 2.50.1
>

