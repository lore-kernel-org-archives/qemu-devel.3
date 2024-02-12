Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A51C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 09:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZSRp-0007Q7-He; Mon, 12 Feb 2024 04:17:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rZSRn-0007Pv-GA
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:17:55 -0500
Received: from mail-dm3nam02on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2405::601]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rZSRl-0004ON-0A
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:17:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/uLo5iJrG1gw4xh/K/+aboGh81LUsdZujAmfxTBLYHekhic5KQK6M+ZXCy/ASoFcOaDJTWGw/jSz4T2bP552LdPYuenuL0+2Qiw6gFvArJqCHDOEDDsThqyROwVb6Ex+wFXQKKObMxH23JJs+OxzC0ini7+HVXwHIKKNtevaT3s+EPS6dmvUaVtZBnHOJvu88AtDc/9SFsZO1K0UGvOCEq34M1k1wv1hyMf8KPzMBuWBQCidqE03UwwKGo2/pb3AbfB3bkSbkbQN+AkJnRIYwfvxdM2We6Wh1gkoT6nvASIfxrRtbHD8c/9kz2zQ9wZBXFm6r8CtvZ6UNNPYbaZdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZBLwFkdEj9lzFhCk7WCiiibwrM6hJVgKJkI6aNtl68=;
 b=c92ptNxHbuGW7x5MGLndspqVFtRut0KHaFcOLtHhjKDqNKphD4H3FhvTnDV+Qx8bSWjEMjvvpUFFb+mQOQt2YWDDzrUMW+MzeNxTUUNOK6N3uCHhAuBhYv2zVy02pCVTq8gRhnx9il1l7lpkK2/7VZ9xSyfR8XyK5/qfT7QKY6kfj823Bm+PuPUW1taXCaCop55Yj/UhGY/h+aEzj443dTAugFdGCp4kANYhxgEF261PytrgmDYPONkHOskL1fbA2YpP3lp0tNGIXoKXbEPvuZjhUgxDin/sjjFlyMp16Uxa0x+4k1zUva+C6NPq48tClax3MoTHDYUlWrIZrGv3mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZBLwFkdEj9lzFhCk7WCiiibwrM6hJVgKJkI6aNtl68=;
 b=Pgn994MLeGQndpWtjcSKrKtMefYNsfNyNjJDoEjq7GHJ+NybCzsbqAcRSC6VjA2nuAFd4QAmj8wBkxBoON4xx+DFLUj10Cfh0bRNkHR1AM6vC07pfdha2P8kBphmKP3sWa9VLq92GbYoBH1T9vZxi6MxXbHPoDUhw7UBDqRF00XNIIoY/1OnOsqYHNQjpIWgcwIIRPD7BbemSmWgLeC7Wjk+ZocS3Q5FhESjJADJf8A5V4ZnJRviewNdf4wZ7La6dFdDLfOqls5XN9Py06Wu2LuvXCMYkZWn5VyNZyBZaUrQSn7iD6xRdC4kYOE6qyyYFvAKQhHvWJLsyFr0ly8D9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by PH0PR12MB7981.namprd12.prod.outlook.com (2603:10b6:510:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Mon, 12 Feb
 2024 09:17:45 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7292.022; Mon, 12 Feb 2024
 09:17:44 +0000
Message-ID: <589c8a79-4266-41c9-a019-ce1d55d7fab9@nvidia.com>
Date: Mon, 12 Feb 2024 11:17:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] vfio: Use new Error** argument in vfio_save_setup()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-9-clg@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240207133347.1115903-9-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0185.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::14) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|PH0PR12MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c9f2062-1205-479c-2fee-08dc2bab78cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9w1ndXiTvyaPhlPGQLQlIjb4aEd4AIKRJ6tKDL/Wzzjnkr5yH82xmpPPCfvjr8xtINUVeGpP7sDhxDnyHyHi9WhDqCoIaHPbs/JY8PizhVMytt1qMdkZZIH/YeiS6/tvmHmw8AApVRFSEqS0iEL6l+YgbHJtxBpyK3j9MRRj3uL6NCXzpz60otVXbEmT6DTfNN03felJfEYHpLn7OKo7jvN1kMNapOfsOKhnXlndusZzOvNHpdl27CR7wjUIYw0snxEpVrGZul4buryt3tVoGyE15duwbDV/b5XGQWXIGWre2b4jzite2A+UNHnOdu16RjC9Dkd5XcfQpVC7nj+Y9gwfdEW1xRq+RqQ/XUhsNJs1wNs2KLILFC3ln6a9gxDhejxiuSZCT5qcS8n95Zo/ealJlBrc0Oec6fIMagnyOlP4PMksf+LPBWmj2cwMFAk93GDbB+2btbF8vLpCXoRwpFczmrVUVYzXHnu79bt1P4F51pY5A8XpARWIbt5Qk5pkVl2/jeBPuDVhrrDjihseWEds9m/SuiWKT3G73HF/+k8MtgqmBH56q56u2lz/kKca
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(39860400002)(136003)(396003)(376002)(230273577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(6486002)(478600001)(6512007)(53546011)(31696002)(86362001)(83380400001)(36756003)(41300700001)(26005)(2616005)(38100700002)(5660300002)(66574015)(54906003)(66556008)(8676002)(2906002)(4326008)(316002)(66476007)(6506007)(6666004)(66946007)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cldKZDE1aTJWUFU1aFRFM0ZGMGNpbjFxTUJoNzJOOFVZWXo5K2w4Z04zQTJm?=
 =?utf-8?B?eFRWcTlQWUtIV3Bic1gzUm5XQmlheWs0eHpsTTVMSy94VXpod0RzOCtpbHB4?=
 =?utf-8?B?RHRLOWF1RmRQTkViNHdVMVc0a3B6UXJvbEM5clpVV09XUUtIalNOMUNaNnE1?=
 =?utf-8?B?MXV0TWF3djNqdFpjNEJqQ05sNU1lc2tidDZ1alRqSmg2M1JXanBsVHRWd042?=
 =?utf-8?B?L2JmNVp1SUxydDkwb1B6bUhUT2Y4YkozYkRWUjFtaW1PQWlaaWVmTGJsTExY?=
 =?utf-8?B?b0JiTlp1NmJFL3RpcUdNRDYxdkdRd21jYWIyTGR1S09xSko3c0YrMk1CTHg1?=
 =?utf-8?B?ajRoeWlKNUsxVU9xd1JYVmt4RThwaDE5NHZEQTIxeHIxelhuWFFlekN2Qk03?=
 =?utf-8?B?RzN0UFhKb2N6Z0ovTXhaSzZzRUQydFZsc0dpS3FRbFAzNS9ZSHdseDdlLzdh?=
 =?utf-8?B?Y01hQTNLbmxQMTRpL0hGOWcrMHRBQ1YxVzdIRE5zZkRzYmJnMGtUbllhbFRZ?=
 =?utf-8?B?NGJScTg5RXEwZUJOaTgxUTNzMjNxVWFiejJZL3dzTURvMFlJcDltVmRhS05V?=
 =?utf-8?B?VThEL3VCeHYycmJQY1FwVGZ2MGx1YWx0QjVibUdHNW82Qkx6NEYwRDBRQ2lx?=
 =?utf-8?B?L2FsNnNvcStodXh2dEsxRTdJUzUrQ3NHUDk0VWxhZjdpbXNWUjRBeGU3TnhD?=
 =?utf-8?B?MFlvRDlvMWE4ZWlpMnFROTRUQ1FCS0dTUnNKTCt5VzFTbEh0NldwQkpLOG1J?=
 =?utf-8?B?L2pmWWNqUk1mckxzVHlXejBzYzA1ckdTbk0wK2t3STJGVEJrSGFmMzJCbjh2?=
 =?utf-8?B?cjdOS0srWGlJdlpNcEhBQW0xd3lVTUJzK1NOT2ZZWlFFV3BLbUtGemZNWjFY?=
 =?utf-8?B?Z2FHZGw2UjZTRlhNcERjY3VUbGRVMzZtK2psZDhPMjBHOTFmNE9UTUtUbjNv?=
 =?utf-8?B?YWFjKzNLa3ZBOTBRbHBGb0NxeGpCNitpb1dNelNCenBNNTQxeXdJMkNPMGxI?=
 =?utf-8?B?VjJvSkdpNTc3dkl6U09zUnA5a1djY3YxYTRweWI4RWJoT0kzRm4yblZkczBZ?=
 =?utf-8?B?YzA2TFdVcUdjbFp6dm1jeU5HMDRmV0FQM2pLbnhYN3I1VXk3TCtTZ3BxaXJ1?=
 =?utf-8?B?dWZYeDgxOVVzVDU1VVB3VnJnbXBibHNMTDNsbmVzV2E2elI4SEJSWkkxbElu?=
 =?utf-8?B?YmZBbEZJa2IrcnhUYVk3U21tSWZzSXVTdDAyMXp2L2d5MFdrdDAvZTlKVkMv?=
 =?utf-8?B?c1VSUURrbG9aN2tLajhkRkJGYU1HdkRBWXp2V1RJeUZVc1VMQkhDUTg1WUcx?=
 =?utf-8?B?YTJTbmxYbG12c1pnUFZrbXhLaDJoT2xFSW12NmppWEx4dW10M1RaUDhud3BJ?=
 =?utf-8?B?WWpxOWl4MHFTdkpCdUpIaFlWdW52Qno4cVkrZE01dzNMeWtJSWtSOHRvVHov?=
 =?utf-8?B?aVRqK0puNjMwRUhOSHVyeVV0VmswNC9HdkhsMDdYMGFNc1FJWEVKUTYraGNS?=
 =?utf-8?B?YVExQW10Qk5WWjJZQ3N5RG1oQ1NFZzA3eEY0L252YlYzN2t5Y29DU2s4cklO?=
 =?utf-8?B?YUZFN2Q1ZjdxQ0xYSTY3S3BkU2N6M0lPTk84MU1CeG91VWp6N3RMaWh2S3N5?=
 =?utf-8?B?eUZRb3kvdFVCai90UStsaGlEWVNZRVRUNGV6RVFIZ0V4U1d2emhoQ1F2Z1gy?=
 =?utf-8?B?aElCd21HOGcydEo3WmhlZ1RKd0RlV3B3WVZlRS9HcVV4WW9jaGtURTFkMUc5?=
 =?utf-8?B?QjZYaEtQYnRvVFBzd2oxSUZYZXlYanp0L1dzSVNLVzk5NGRTZ3lCQ0JLT0FZ?=
 =?utf-8?B?Z3pQUkV0TUl0WXJxdU9Qd0ozaWFZbzhIaGFzbHRBWHIyWkhWM2NtN0lSR0VO?=
 =?utf-8?B?bCtqenB3MmdGQzlEWFdoWXVIMHo1LzZXUHljU3lSb0pmYVQ1b0E3OGxHQ1RJ?=
 =?utf-8?B?UWQzNkhQRlZ2VGpjR3laT1hYcHFiWE5xcUs4dVp2eXI2WDBoL1c0QVJKWG14?=
 =?utf-8?B?RlpHWjRMVFFHMHFYelNQSDdJVml0YkI0TEZOaytiUGs0R29MYno2NmJIM0NE?=
 =?utf-8?B?c1V4Y2ZGSEc2d3hWYmNGQjRNMkF6U0FVRnN5N1NUN1JoN2MxTDRnNGpnK2tX?=
 =?utf-8?Q?k+Tx0rc2BtDIa9F4P4JGaQXLa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9f2062-1205-479c-2fee-08dc2bab78cb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 09:17:44.7583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1y3HxAhUPrIjF1C2grxLHcf9AmYV9L2BMinKS6zhCs92Q3PR6YfymPviX6WXnmFFGbF0IAoRUVoovu0EaPAvEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7981
Received-SPF: softfail client-ip=2a01:111:f403:2405::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 07/02/2024 15:33, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> Add an Error** argument to vfio_migration_set_state() and adjust
> callers, including vfio_save_setup(). The error will be propagated up
> to qemu_savevm_state_setup() where the save_setup() handler is
> executed.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/migration.c | 62 +++++++++++++++++++++++++++++----------------
>   1 file changed, 40 insertions(+), 22 deletions(-)
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 2dfbe671f6f45aa530c7341177bb532d8292cecd..2e0a79967cc97f44d9be5575c3cfe18c9f349dab 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -84,7 +84,8 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
>
>   static int vfio_migration_set_state(VFIODevice *vbasedev,
>                                       enum vfio_device_mig_state new_state,
> -                                    enum vfio_device_mig_state recover_state)
> +                                    enum vfio_device_mig_state recover_state,
> +                                    Error **errp)
>   {
>       VFIOMigration *migration = vbasedev->migration;
>       uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
> @@ -104,15 +105,15 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>           ret = -errno;
>
>           if (recover_state == VFIO_DEVICE_STATE_ERROR) {
> -            error_report("%s: Failed setting device state to %s, err: %s. "
> -                         "Recover state is ERROR. Resetting device",
> -                         vbasedev->name, mig_state_to_str(new_state),
> -                         strerror(errno));
> +            error_setg(errp, "%s: Failed setting device state to %s, err: %s. "
> +                       "Recover state is ERROR. Resetting device",
> +                       vbasedev->name, mig_state_to_str(new_state),
> +                       strerror(errno));
>
>               goto reset_device;
>           }
>
> -        error_report(
> +        error_setg(errp,
>               "%s: Failed setting device state to %s, err: %s. Setting device in recover state %s",
>                        vbasedev->name, mig_state_to_str(new_state),
>                        strerror(errno), mig_state_to_str(recover_state));
> @@ -120,7 +121,7 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>           mig_state->device_state = recover_state;
>           if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
>               ret = -errno;
> -            error_report(
> +            error_setg(errp,
>                   "%s: Failed setting device in recover state, err: %s. Resetting device",
>                            vbasedev->name, strerror(errno));

I think here we will assert because errp is already set.

Adding an error_append() API would be useful here I guess.
Otherwise, we need to move the first error_setg() below, to before we 
return from a successful recover state change, and construct the error 
message differently (e.g., provide a full error message for the recover 
state fail case containing also the first error).

Do you have other ideas?

Thanks.

>
> @@ -139,7 +140,7 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>                * This can happen if the device is asynchronously reset and
>                * terminates a data transfer.
>                */
> -            error_report("%s: data_fd out of sync", vbasedev->name);
> +            error_setg(errp, "%s: data_fd out of sync", vbasedev->name);
>               close(mig_state->data_fd);
>
>               return -EBADF;
> @@ -170,10 +171,11 @@ reset_device:
>    */
>   static int
>   vfio_migration_set_state_or_reset(VFIODevice *vbasedev,
> -                                  enum vfio_device_mig_state new_state)
> +                                  enum vfio_device_mig_state new_state,
> +                                  Error **errp)
>   {
>       return vfio_migration_set_state(vbasedev, new_state,
> -                                    VFIO_DEVICE_STATE_ERROR);
> +                                    VFIO_DEVICE_STATE_ERROR, errp);
>   }
>
>   static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
> @@ -391,8 +393,8 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>                                         stop_copy_size);
>       migration->data_buffer = g_try_malloc0(migration->data_buffer_size);
>       if (!migration->data_buffer) {
> -        error_report("%s: Failed to allocate migration data buffer",
> -                     vbasedev->name);
> +        error_setg(errp, "%s: Failed to allocate migration data buffer",
> +                   vbasedev->name);
>           return -ENOMEM;
>       }
>
> @@ -402,7 +404,7 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>           switch (migration->device_state) {
>           case VFIO_DEVICE_STATE_RUNNING:
>               ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_PRE_COPY,
> -                                           VFIO_DEVICE_STATE_RUNNING);
> +                                           VFIO_DEVICE_STATE_RUNNING, errp);
>               if (ret) {
>                   return ret;
>               }
> @@ -429,13 +431,18 @@ static void vfio_save_cleanup(void *opaque)
>   {
>       VFIODevice *vbasedev = opaque;
>       VFIOMigration *migration = vbasedev->migration;
> +    Error *local_err = NULL;
>
>       /*
>        * Changing device state from STOP_COPY to STOP can take time. Do it here,
>        * after migration has completed, so it won't increase downtime.
>        */
>       if (migration->device_state == VFIO_DEVICE_STATE_STOP_COPY) {
> -        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_STOP);
> +        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_STOP,
> +                                          &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +        }
>       }
>
>       g_free(migration->data_buffer);
> @@ -541,11 +548,13 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>       VFIODevice *vbasedev = opaque;
>       ssize_t data_size;
>       int ret;
> +    Error *local_err = NULL;
>
>       /* We reach here with device state STOP or STOP_COPY only */
>       ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
> -                                   VFIO_DEVICE_STATE_STOP);
> -    if (ret) {
> +                                   VFIO_DEVICE_STATE_STOP, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
>           return ret;
>       }
>
> @@ -585,7 +594,7 @@ static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
>       VFIODevice *vbasedev = opaque;
>
>       return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
> -                                   vbasedev->migration->device_state);
> +                                    vbasedev->migration->device_state, errp);
>   }
>
>   static int vfio_load_cleanup(void *opaque)
> @@ -701,20 +710,22 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
>       VFIODevice *vbasedev = opaque;
>       VFIOMigration *migration = vbasedev->migration;
>       enum vfio_device_mig_state new_state;
> +    Error *local_err = NULL;
>       int ret;
>
>       new_state = migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ?
>                       VFIO_DEVICE_STATE_PRE_COPY_P2P :
>                       VFIO_DEVICE_STATE_RUNNING_P2P;
>
> -    ret = vfio_migration_set_state_or_reset(vbasedev, new_state);
> +    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
>       if (ret) {
>           /*
>            * Migration should be aborted in this case, but vm_state_notify()
>            * currently does not support reporting failures.
>            */
>           if (migrate_get_current()->to_dst_file) {
> -            qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
> +            qemu_file_set_error_obj(migrate_get_current()->to_dst_file, ret,
> +                                    local_err);
>           }
>       }
>
> @@ -727,6 +738,7 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>   {
>       VFIODevice *vbasedev = opaque;
>       enum vfio_device_mig_state new_state;
> +    Error *local_err = NULL;
>       int ret;
>
>       if (running) {
> @@ -739,14 +751,15 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>                   VFIO_DEVICE_STATE_STOP;
>       }
>
> -    ret = vfio_migration_set_state_or_reset(vbasedev, new_state);
> +    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
>       if (ret) {
>           /*
>            * Migration should be aborted in this case, but vm_state_notify()
>            * currently does not support reporting failures.
>            */
>           if (migrate_get_current()->to_dst_file) {
> -            qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
> +            qemu_file_set_error_obj(migrate_get_current()->to_dst_file, ret,
> +                                    local_err);
>           }
>       }
>
> @@ -760,6 +773,7 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
>       VFIOMigration *migration = container_of(notifier, VFIOMigration,
>                                               migration_state);
>       VFIODevice *vbasedev = migration->vbasedev;
> +    Error *local_err = NULL;
>
>       trace_vfio_migration_state_notifier(vbasedev->name,
>                                           MigrationStatus_str(s->state));
> @@ -768,7 +782,11 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
>       case MIGRATION_STATUS_CANCELLING:
>       case MIGRATION_STATUS_CANCELLED:
>       case MIGRATION_STATUS_FAILED:
> -        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_RUNNING);
> +        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_RUNNING,
> +                                          &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +        }
>       }
>   }
>
> --
> 2.43.0
>
>

