Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F64C54E41
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 09:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh4Lj-0006d3-O7; Mon, 04 Mar 2024 04:11:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rh4Le-0006cU-BX
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 04:11:02 -0500
Received: from mail-dm6nam12on2048.outbound.protection.outlook.com
 ([40.107.243.48] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rh4LS-0002vh-Hg
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 04:11:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i85nl1yGvo3p3lLBK3vvpUcE0VI9atel41jIDLAnamBN9K61cykflEefk/rN6KvjPKM84weK0+sPulzc1wjiESG8TZMbjJ76xWk4F40ScjxX/GGC+UAsSFzaXgrs4nAGuKNFJ8al/ehBstmcwFdAbp+NW2+tsCx7RRLBEFlUkDBNE0hMZVpo5E+SrQnBVHhr/AkGHjC5AWWQ/iMbUrojl/BeLoBn7ti8bOvzvvlt/JJrOOmstjrdMoVKyO9bUuKq5zCDCEyatKs9GV4ZMVfSQBAqNWeBECBDLMQLhDmzGXVKBB5ZyiKB/BLejYXVA+SLmeF1aEti46nGb/5pwMrnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfQOnWT1IQhlu5jWl29F01/u6je3WgsPVUILW3NIjmY=;
 b=fUHwEaRhSRrwvT2NQQgx9XPRjn7mXtDFo4iTen2n+p1YNnlzDtUUtlcj6JR7TSNhELe+0a/P8dL0pEvd7vr7FykCUj/dvLHiIK1S4mZ8hiy9xKwNODlo1WJ/vMpnF8eH/sX/kiUr9r9PHdYrTYBMHsin5NlTBP5YWhLhwqFSCzD3BCU/rQO/bsHlHtsOeo74i+w+kX17Dg2PgSLotrwsdTBRKzNQagNAlz9Zd+tGu0WDS8+SdyvrBNV43sNfxCWW+7YCxi4cqnEjYkHmqsg5XR9HiELmecPk+N75kj8R46abHJHrISv7AOs7+6RUqkg9WADW66ZizAj0TiO8cI/rBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfQOnWT1IQhlu5jWl29F01/u6je3WgsPVUILW3NIjmY=;
 b=GtNDQ7fGomFa7o/l2ZKc6tm5XOZl5CAYPYmXhEXe+jUDvcSPOsToxJYMm35fL0tUyJU6rq5d8dCE8E+3f1H7xphSW/ixiAKXMa9TC5uEgi4DAbsGvJk1//Pu0lYJbyuGpydGmN1fYauA/Con3iMkW9BzoQ+h3698olADHsHKPDf3cRvp4sDS5OA7HaVjICCGbsfLfyY0CFa+hJRoXYBZXm037R9JhKH3eZSJilBoc16TcyHdTuLd7rh9fDqC+4vfRADQY5s4iTDw1Xg4KdgbZIup5idqNyLdHl3m0OqNCO8TJ3UJN2gfbNMdtbeuM1ZNeUOXyLxg1KFX3H0MwfRGfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DS0PR12MB8563.namprd12.prod.outlook.com (2603:10b6:8:165::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 09:05:38 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::9994:4366:f59c:c903]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::9994:4366:f59c:c903%5]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 09:05:38 +0000
Message-ID: <9dcfbafd-407f-4b23-a4ff-049c5bfcde65@nvidia.com>
Date: Mon, 4 Mar 2024 11:05:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/21] migration: Add documentation for SaveVMHandlers
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240227180345.548960-1-clg@redhat.com>
 <20240227180345.548960-4-clg@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240227180345.548960-4-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0326.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::19) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DS0PR12MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: 441ea52a-9987-441f-6bce-08dc3c2a42ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZwN1aD4ztUh80UFsis7AhCYdAt3+K2QqABXCgpJfK4kBjNxUijKaUj5PFIrSI2/huOPlP1JLMP5ciA57rChacAZ0RoqGczJChCOt4P80ra3nWdJx3mDKEIxrTa9A9+1SZKxHI8UNFiQ+rmf4nIGJZnkO3RVHNdRH28jWG6wDNM1aBdLnGiX8GY7exot8El2ILNxrtkSxnGcUBoPp5ow5ASL1Hva5RFhu/iB/x+ymsWQZLeQPxeFSoToebIXQEZdRi3IYblv/jgfwvyw3FrMPPkgu57tJXuejiA0AV/ggzc7aqqVqRO0UUyWWpT81JLeSwG/s2W6de6AdFPI6xlYqesrcjad/KymqVtamH5pUNg7bCnEOSmycWemcf2G3VUhSzBMoOdQ44AXCjqUcM1VlU92+YmcH7GZrED0r2PWPHRtyFHDzRgKTszH+/vE3ErHmHsjIGwtHQPomWkL5AxE0QACyLf6q6J/4mIeesBsMPYp2giXKR6Mw05IQjRITLudA8zmLEPPTH5qcvm/9eKXeX6FqZjkORzwaLn7PgNKCDppqq1ON6+jsQPpfzpJNonY3v8Bh6JkWo6PJslm95p2pRZ5m0KJSIoJ2pt3JnKvv3QsyDQf6CsVsj9m2LI/37A8NK+wN+ih+3K6DrwWTBp9B/jF6SHMWhZ/HrxSN8oluhKc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VitkMlhZZitwdWo2MkxlY0FHbk9WazRJWHRnRVBpTGY5Mjhpd3ZrRzhhU3Vn?=
 =?utf-8?B?eTFzQzAxSGdFdHJENEp6NlR3NDY2SlhrVHY0Um1pU0xyMzFmdElKRHV5eVJD?=
 =?utf-8?B?a1FNWmlBOE8wQkI5VkZBZjRxQU5zSTFxL1ZGZ0w0V1VJQW9HZ2RPaUlIcFl4?=
 =?utf-8?B?aXB6dUp6bldobFBRQU5hOGt1ZzVpZFQzM09rUTEvT1A1STAwUnRUVW1oNllT?=
 =?utf-8?B?MWY3VkVjY3NQZXdoRStTWDljVEN1Ym9wSFBiQUd1cXZOeU4yWmppS0psdkpi?=
 =?utf-8?B?c3BGN2ZEL2dUUVoyNjB4QlRGYTFHQkxjQmY3aEdCUWtRM3pQbDJWc0c3WnZH?=
 =?utf-8?B?ZmtXZ3Jib2MycjFWY2R1SzcwYjZhTGE2UFJvTmVOdXZDMXJuU1FsaHhNZGhE?=
 =?utf-8?B?TlpqTERoT2Fac25aMHFKaWd2UnBIa01UL3dqZTNIcldYdWVKcGNCcHFCd1Yr?=
 =?utf-8?B?WFJnampiTnlJYmFOTjdJTmlxYTF1RVROK04zSy9kVFI2WE5tWGFPMTVJUVNu?=
 =?utf-8?B?QkpjSW9UcWdxQ1ZqRWY5OGR3TVcwRmNldzdXMnpLU08rRVczYVQ4OEhlUnZF?=
 =?utf-8?B?ektGY1BhQ3d0YndHNlI0aHltZUdHR3RqRm5NOXVkU1NSakw0OTF4R3V1UGp2?=
 =?utf-8?B?dGU1aDlyWE9GeHlnUml2MFlDRGVNaFJuOTFxWXpvbFlEMElzUlQ5Z0l2VW45?=
 =?utf-8?B?NWcwa0FQZk1hU0wydXBrUi9HSHlDNDhOYnduQ3ZYdG5oeGRwalRPc0MvK0la?=
 =?utf-8?B?NGZQbUh3MWJpcEx2Y1QrbXJwRjBHWE96R3hYQ3dENUoxcDRxRU52RmM3OVZT?=
 =?utf-8?B?QkJKV2lYMjY3bUM5RzJYRE1BdGlvQjQ4bCtBVjNrT1M1OER0bEJXcit1NFNK?=
 =?utf-8?B?VVY4QmFBOVVKNjNLSkVWczRFQmlSMUJqR2xjNkg2Y3FaSHpLWnlUVTdTZWk2?=
 =?utf-8?B?ejZPT1RPN0Nnd3BzRWhwWEpPc1VCTTZRQ1I0emwwb3ZwWWtpcHNCQVc1REU2?=
 =?utf-8?B?RnZqd0szbHI0VllXZnhwS25YZnNXMFp3RkNtTHdQTXBVeEpIVm5kNExQckhy?=
 =?utf-8?B?ZnZNRGplWnZHd0orMlE5RC9BSEtQRUlubVdGRXBvOVBHQjJJZ0RWSDZna25Y?=
 =?utf-8?B?d0hjMFlOaEo3SXVCMnhtMnMzdG9VOEFoaFRtcWVsb1hJZU1uczNNR1hTYUg1?=
 =?utf-8?B?R3lpdTF0UVlwL2JEbkl6cDFPZHA2dDBlRTVOSENpdzdaV0lPTFpPZkZ0ckg0?=
 =?utf-8?B?Y3FIY2p5Q1B6UEpLOFFJc3ZROWpLZWRVUTJWM1lPdzIxaS9hUXVyOTJqVGpi?=
 =?utf-8?B?Ri8zdjh4MlpzZEt6YmNtMW9FVWhRTloyYWZqc2oyVmFjbm1RdFZQcTZLUy9C?=
 =?utf-8?B?Q1NUNlJTU3QrK0VCNEVPMGFjQWpRUHVFUDdxWFpQZjd3SWl3eUNheWJBQVA2?=
 =?utf-8?B?WWo0Y2s4SnNIRm5NazkwMWYvLzkrVTBIUFp5OUJJNHNYVXUvLzVRVFBrbDNX?=
 =?utf-8?B?QkdSaVl5Z3VibXhOUWNKN1dBSEdyNXlLSVJONFFBSzJNbkxvb1p2N20vMEda?=
 =?utf-8?B?NWp1U3o1QUFQYjhIMUgzNEx5aFZNQVFUK0ptYzJJQ0NYMjUwVmJoYWFOSmxW?=
 =?utf-8?B?cDd3bjA5NHdTRDNhSmZma3B6dlNnTUt3czdXODc3dHRzRkR2azN0L1ZiKzVr?=
 =?utf-8?B?MGVVS0VMaFhlRi9PUHVidVVVOVlEcytMSm54a0p2blBsakxnVDBIRlp4TEVj?=
 =?utf-8?B?WjNOek1nZmpaSTVUWUNiaDJJVWFKbzJOSGYvUlYzZzg5RWtUcDYrLzRBZ1Rr?=
 =?utf-8?B?aEF3S3NPandoZU1ZVklCdjBud0dmdWM0UDRwTEFYWjc3ekdiT0lxeEFhOTBV?=
 =?utf-8?B?R2ozbTVMTUd4R0lPM3ZsYjFXTFdHT0UvMS9ieGhKYzdjWklheVVUMlNuekhv?=
 =?utf-8?B?L1FkS1RLL3ZDSDRNRkNyUE5YNmhoZjJsemVlaGdBWWNDUWJhL0pGa050Zm1l?=
 =?utf-8?B?V2tNV2tYbU91cWVjZXFxaFNSM2c4WXdJcXJ4RGh2VVAzZTBuS3JKMTBMMUtU?=
 =?utf-8?B?dHdEWDQ1d3hjc2hyNGhjLzQ1eWw5Qm1kTnM4ekhScmZ4VEdJeHIxejNhdlZr?=
 =?utf-8?Q?HedZbVUNsI3CdcqTB+Fg09YOB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 441ea52a-9987-441f-6bce-08dc3c2a42ac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 09:05:38.6853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxLdvOuz+L9KHvql4pEX4yTYADXoH9aRC8hglpKZPy8jmM/6ay61Ssu+YuIRs6CKv+LjSHb/5N5MqmXLKmZOYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8563
Received-SPF: softfail client-ip=40.107.243.48;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Cedric,

A few nits below.

On 27/02/2024 20:03, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> The SaveVMHandlers structure is still in use for complex subsystems
> and devices. Document the handlers since we are going to modify a few
> later.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/migration/register.h | 257 +++++++++++++++++++++++++++++++----
>   1 file changed, 231 insertions(+), 26 deletions(-)
>
> diff --git a/include/migration/register.h b/include/migration/register.h
> index 2e6a7d766e62f64940086b7b511249c9ff21fa62..2cc71ec45f65bf2884c9e7a823d2968752f15c20 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -16,30 +16,129 @@
>
>   #include "hw/vmstate-if.h"
>
> +/**
> + * struct SaveVMHandlers: handler structure to finely control
> + * migration of complex subsystems and devices, such as RAM, block and
> + * VFIO.
> + */
>   typedef struct SaveVMHandlers {
> -    /* This runs inside the BQL.  */
> +
> +    /* The following handlers runs inside the BQL. */

s/runs/run

> +
> +    /**
> +     * @save_state
> +     *
> +     * Saves state section on the source using the latest state format
> +     * version.
> +     *
> +     * Legacy method. Should be deprecated when all users are ported
> +     * to VMState.
> +     *
> +     * @f: QEMUFile where to send the data
> +     * @opaque: data pointer passed to register_savevm_live()
> +     */
>       void (*save_state)(QEMUFile *f, void *opaque);
>
> -    /*
> -     * save_prepare is called early, even before migration starts, and can be
> -     * used to perform early checks.
> +    /**
> +     * @save_prepare
> +     *
> +     * Called early, even before migration starts, and can be used to
> +     * perform early checks.
> +     *
> +     * @opaque: data pointer passed to register_savevm_live()
> +     * @errp: pointer to Error*, to store an error if it happens.
> +     *
> +     * Returns zero to indicate success and negative for error
>        */
>       int (*save_prepare)(void *opaque, Error **errp);
> +
> +    /**
> +     * @save_setup
> +     *
> +     * Initializes the data structures on the source and transmits
> +     * first section containing information on the device
> +     *
> +     * @f: QEMUFile where to send the data
> +     * @opaque: data pointer passed to register_savevm_live()
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>       int (*save_setup)(QEMUFile *f, void *opaque);
> +
> +    /**
> +     * @save_cleanup
> +     *
> +     * Performs save related cleanup

Use save_setup phrasing?
Uninitializes the data structures on the source.

> +     *
> +     * @opaque: data pointer passed to register_savevm_live()
> +     *
> +     * Returns zero to indicate success and negative for error

This can be dropped as it's a void function.

> +     */
>       void (*save_cleanup)(void *opaque);
> +
> +    /**
> +     * @save_live_complete_postcopy
> +     *
> +     * Called at the end of postcopy for all postcopyiable devices.

s/postcopyiable/postcopyable

> +     *
> +     * @f: QEMUFile where to send the data
> +     * @opaque: data pointer passed to register_savevm_live()
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>       int (*save_live_complete_postcopy)(QEMUFile *f, void *opaque);
> +
> +    /**
> +     * @save_live_complete_precopy
> +     *
> +     * Transmits the last section for the device containing any
> +     * remaining data.
> +     *
> +     * @f: QEMUFile where to send the data
> +     * @opaque: data pointer passed to register_savevm_live()
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>       int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
>
>       /* This runs both outside and inside the BQL.  */
> +
> +    /**
> +     * @is_active
> +     *
> +     * Will skip a state section if not active
> +     *
> +     * @opaque: data pointer passed to register_savevm_live()
> +     *
> +     * Returns true if state section is active else false
> +     */
>       bool (*is_active)(void *opaque);
> +
> +    /**
> +     * @has_postcopy
> +     *
> +     * checks if a device supports postcopy

s/checks/Checks

> +     *
> +     * @opaque: data pointer passed to register_savevm_live()
> +     *
> +     * Returns true for postcopy support else false
> +     */
>       bool (*has_postcopy)(void *opaque);
>
> -    /* is_active_iterate
> -     * If it is not NULL then qemu_savevm_state_iterate will skip iteration if
> -     * it returns false. For example, it is needed for only-postcopy-states,
> -     * which needs to be handled by qemu_savevm_state_setup and
> -     * qemu_savevm_state_pending, but do not need iterations until not in
> -     * postcopy stage.
> +    /**
> +     * @is_active_iterate
> +     *
> +     * As #SaveVMHandlers.is_active(), will skip an inactive state
> +     * section in qemu_savevm_state_iterate.
> +     *
> +     * For example, it is needed for only-postcopy-states, which needs
> +     * to be handled by qemu_savevm_state_setup() and
> +     * qemu_savevm_state_pending(), but do not need iterations until
> +     * not in postcopy stage.
> +     *
> +     * @opaque: data pointer passed to register_savevm_live()
> +     *
> +     * Returns true if state section is active else false
>        */
>       bool (*is_active_iterate)(void *opaque);
>
> @@ -48,44 +147,150 @@ typedef struct SaveVMHandlers {
>        * use data that is local to the migration thread or protected
>        * by other locks.
>        */
> +
> +    /**
> +     * @save_live_iterate
> +     *
> +     * Should send a chunk of data until the point that stream
> +     * bandwidth limits tell it to stop. Each call generates one
> +     * section.
> +     *
> +     * @f: QEMUFile where to send the data
> +     * @opaque: data pointer passed to register_savevm_live()
> +     *
> +     * Returns zero to indicate success and negative for error

0 indicates that there is still more data to send, 1 indicates that 
there is no more data to send and negative indicates error.

> +     */
>       int (*save_live_iterate)(QEMUFile *f, void *opaque);
>
>       /* This runs outside the BQL!  */
> -    /* Note for save_live_pending:
> -     * must_precopy:
> -     * - must be migrated in precopy or in stopped state
> -     * - i.e. must be migrated before target start
> -     *
> -     * can_postcopy:
> -     * - can migrate in postcopy or in stopped state
> -     * - i.e. can migrate after target start
> -     * - some can also be migrated during precopy (RAM)
> -     * - some must be migrated after source stops (block-dirty-bitmap)
> -     *
> -     * Sum of can_postcopy and must_postcopy is the whole amount of
> +
> +    /**
> +     * @state_pending_estimate
> +     *
> +     * This estimates the remaining data to transfer
> +     *
> +     * Sum of @can_postcopy and @must_postcopy is the whole amount of
>        * pending data.
> +     *
> +     * @opaque: data pointer passed to register_savevm_live()
> +     * @must_precopy: amount of data that must be migrated in precopy
> +     *                or in stopped state, i.e. that must be migrated
> +     *                before target start.
> +     * @can_postcopy: amount of data that can be migrated in postcopy
> +     *                or in stopped state, i.e. after target start.
> +     *                Some can also be migrated during precopy (RAM).
> +     *                Some must be migrated after source stops
> +     *                (block-dirty-bitmap)
>        */
> -    /* This estimates the remaining data to transfer */
>       void (*state_pending_estimate)(void *opaque, uint64_t *must_precopy,
>                                      uint64_t *can_postcopy);
> -    /* This calculate the exact remaining data to transfer */
> +
> +    /**
> +     * @state_pending_exact
> +     *
> +     * This calculate the exact remaining data to transfer

s/calculate/calculates

> +     *
> +     * Sum of @can_postcopy and @must_postcopy is the whole amount of
> +     * pending data.
> +     *
> +     * @opaque: data pointer passed to register_savevm_live()
> +     * @must_precopy: amount of data that must be migrated in precopy
> +     *                or in stopped state, i.e. that must be migrated
> +     *                before target start.
> +     * @can_postcopy: amount of data that can be migrated in postcopy
> +     *                or in stopped state, i.e. after target start.
> +     *                Some can also be migrated during precopy (RAM).
> +     *                Some must be migrated after source stops
> +     *                (block-dirty-bitmap)
> +     */
>       void (*state_pending_exact)(void *opaque, uint64_t *must_precopy,
>                                   uint64_t *can_postcopy);
> +
> +    /**
> +     * @load_state
> +     *
> +     * Load sections generated by any of the save functions that
> +     * generate sections.
> +     *
> +     * Legacy method. Should be deprecated when all users are ported
> +     * to VMState.
> +     *
> +     * @f: QEMUFile where to receive the data
> +     * @opaque: data pointer passed to register_savevm_live()
> +     * @version_id: the maximum version_id supported
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>       int (*load_state)(QEMUFile *f, void *opaque, int version_id);
> +
> +    /**
> +     * @load_setup
> +     *
> +     * Initializes the data structures on the destination.
> +     *
> +     * @f: QEMUFile where to receive the data
> +     * @opaque: data pointer passed to register_savevm_live()
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>       int (*load_setup)(QEMUFile *f, void *opaque);
> +
> +    /**
> +     * @load_cleanup
> +     *
> +     * Performs cleanup of load data structures

Use load_setup phrasing?
Uninitializes the data structures on the destination.

> +     *
> +     * @opaque: data pointer passed to register_savevm_live()
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>       int (*load_cleanup)(void *opaque);
> -    /* Called when postcopy migration wants to resume from failure */
> +
> +    /**
> +     * @resume_prepare
> +     *
> +     * Called when postcopy migration wants to resume from failure
> +     *
> +     * @s: Current migration state
> +     * @opaque: data pointer passed to register_savevm_live()
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>       int (*resume_prepare)(MigrationState *s, void *opaque);
> -    /* Checks if switchover ack should be used. Called only in dest */
> +
> +    /**
> +     * @switchover_ack_needed
> +     *
> +     * Checks if switchover ack should be used. Called only on
> +     * destination.
> +     *
> +     * @opaque: data pointer passed to register_savevm_live()

Add:
Returns true if switchover ack should be used and false otherwise

> +     */
>       bool (*switchover_ack_needed)(void *opaque);
>   } SaveVMHandlers;
>
> +/**
> + * register_savevm_live: Register a set of custom migration handlers
> + *
> + * @idstr: state section identifier
> + * @instance_id: instance id
> + * @version_id: version id supported
> + * @ops: SaveVMHandlers structurex

s/structurex/structure

> + * @opaque: data pointer passed SaveVMHandlers handlers

s/passed SaveVMHandlers/passed to SaveVMHandlers

Thanks.

> + */
>   int register_savevm_live(const char *idstr,
>                            uint32_t instance_id,
>                            int version_id,
>                            const SaveVMHandlers *ops,
>                            void *opaque);
>
> +/**
> + * unregister_savevm: Unregister custom migration handlers
> + *
> + * @obj: object associated with state section
> + * @idstr:  state section identifier
> + * @opaque: data pointer passed to register_savevm_live()
> + */
>   void unregister_savevm(VMStateIf *obj, const char *idstr, void *opaque);
>
>   #endif
> --
> 2.43.2
>

