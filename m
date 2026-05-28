Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4A2CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 09:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSWqB-0000Jd-Jw; Thu, 28 May 2026 05:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wSWq9-0000JQ-Tx
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:15:46 -0400
Received: from mail-westus3azon11012024.outbound.protection.outlook.com
 ([40.107.209.24] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wSWq8-00015F-5N
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:15:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wL2GwfyTu68Ax+MXpDV46O2OKY6V+qWp2iud2kDXulLfAdLpZBhQrYtUrd4BLtrF9npFYYV+C/uAzFpKGKtXwhqyMAlKWQ3wy/M5VOt1IFE3EjU9zzcEOJRdp59alyNowRurT1v3/rvE+9k7zVVvZOk+Gsb9Qv1quP774ADY8NU/T2s8JtY5uJ4VabR36FDOkZ9SSk46UC4AHSFaDK/2e8r9XZJJqIjlAhUHbs9dT7JI+ACjCh3s+LFJZR+vDx0yCvqXpZsK+e+Hb8q0wdiaPQ88DE6TU7sH3xNXSD4qgfZDG8e4jQOTBLLJH5bl/rZmJV2uzP4T6rcCeRZ+O4UfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sm/tSw1FdxHWbR1a1H/eL7UdJViEd2dsmH9nBXzLfCg=;
 b=wvAZ5FIqXjc8ctjYs1keDRsDgIbape0uMO4iaPR5xnauyZQMlcJnKttEF47yQyW6MmT67rYEsgCbQHZfgXeZ+xD+QsrU3IYmDpIG02v51ptu+iBOI/CLGSLM6XZuFDD0stDiI6WKNDavX3E/Bc9DDrG5nfxSA/L4pv/nlt4Fztpzm0kZn8Jeoqi2kyOpB1emGLvGoffblidzLg1wxyEm3tMEaov/m18iVEcxTbjiZeAKIncTCslqOLiUnF4yfkaTkXhA2JCCfXHj42EHOu0t/qSbfzHY9v4oMI5StzR9lVpGgxgWfffQvPISHAboeBY8vcrNy43NVZ6mpILAGTE46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sm/tSw1FdxHWbR1a1H/eL7UdJViEd2dsmH9nBXzLfCg=;
 b=T8VXmTbp+v2ZwezMp9BAUnFaCVjS04zAuyViodSuQpoWPH0/5FFEWatyCzc9PBl9y4v+xcUj/+jfrvV5JWpPAfmDVEBCXQ9HFs9nvaem31Sh/RGPMEi7m6ZDDcA6/8W0dFECaNwNmjphyypA5ESMb1XJukDbuSwBIiifRhs4QmawFrgCQXkTauikhRHLooeNpzI1fUylLTopz2Z0nyMQtAlCwM3MV2aCC4MmmK6lsre4NX6C0BwQe/xWmKvSAbg23lb8a21bZUdBEjS8K0B2CZTgEWXr5772yp02pG42aNmvrx7PGccbCzLLVXqp4BtsD69SRrBzMi5idNIh+9vN3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH0PR12MB5059.namprd12.prod.outlook.com (2603:10b6:610:e2::6)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Thu, 28 May
 2026 09:10:36 +0000
Received: from CH0PR12MB5059.namprd12.prod.outlook.com
 ([fe80::c8c9:7981:418:63b]) by CH0PR12MB5059.namprd12.prod.outlook.com
 ([fe80::c8c9:7981:418:63b%4]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 09:10:36 +0000
Message-ID: <ac47e206-5832-449a-b46c-0e07527abf22@nvidia.com>
Date: Thu, 28 May 2026 12:10:28 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] migration: Make switchover-ack re-usable
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-8-avihaih@nvidia.com> <agy-q-MTVboGUY_G@x1.local>
 <9631bd0e-5c56-490d-a341-4ad4d5ae91a6@nvidia.com> <ag8cqIGtAfe80lKW@x1.local>
 <53cca60e-67b0-4ed2-bdae-6ddbaefc1390@nvidia.com> <ahRkT19AVwi4SQA9@x1.local>
 <f2c43343-d286-47a7-9596-8de2d5a6e5c5@nvidia.com> <ahXJD6QkXccf60Cn@x1.local>
 <c450e363-22f5-4bf8-9c04-896ccb02938b@nvidia.com> <ahcP9dtUqSAc-LAq@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ahcP9dtUqSAc-LAq@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0395.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::19) To CH0PR12MB5059.namprd12.prod.outlook.com
 (2603:10b6:610:e2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5059:EE_|CH2PR12MB4311:EE_
X-MS-Office365-Filtering-Correlation-Id: c5dcf791-d9d1-4ec1-2d62-08debc98faa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|56012099006|6133799003|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: PFFfFtk6XR4jdUeekzqcTYjKZq44BuiND91Ocelu6VNa8KsgJil1WDCjHESPAtixd1UfSw1/8mE7moRKDKmlZOn+d4fTkOCXVgs3AYH53hukdFx9EDJ8Bu+9ktmk9akeWm7vXfKk7kDqk6npnqiEsKIq1RR/NMROvESeJE9Mktg71/HUXrEbi2k0mRJPRnMMq5DW6DynW8XQ+TwayrEmrh6epxb0MAfBPhPQI/gpbLxKDlA+im/dqqGKHDn9eG8J5F1pRPX4WDJgIi9+ptxQHKvw+as7kcYL4SoRf0yQt9dfQsdXz99qO13vFuSvd4AnQqaAX3VWXphZ0mGqSidb3uXLwJc3esw8kdpa5l9e61nChqxtejrMAOOy+OfJVXlZXMWC5L2+rXoA1lhpGTPeN6a1QCEya0D0mj5/CZFQHdu+OPTJilbgOR5CAwV2uAo7PSVf9nM3VTfIqEYw0TmN05QZo16DSWSR1SZtkpSPsB7l5jcoPjrlbr5SzsZUGB8AxJKBNxL2wgxiU6afpzYzmOIDD2WKTzVAzbjzVRDJpzwtlcinuCoec1xjTJYnItkUoW1d54xU66QXJYKtH1cRY5OaAydlwLm40ir6wP7shGoueHuWRi6Za6ReTuTIKUOAIS3lbprFXq9HgMJkh2FuXkJhVE6L7AwuN28jmvQgHeJnunnuDiee9shkJ7cuWgtC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5059.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099006)(6133799003)(5023799004)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUZPMWJzZXBEUElrZlNhWG9oUXEyaXdGVGlPdU53VzB3V2h3ZTRDVWFwVW5Q?=
 =?utf-8?B?aVQxZ29mekdDbmZUcmRkSjhrMXZxanVjL3MzZEpZV0dJTnpxU0xDYzNQS2sx?=
 =?utf-8?B?dUdBQS9BSjFEelhubTFtR2t2eTNHRDBGQW1DNlJqN0RINXdEUkJqeGttSVRn?=
 =?utf-8?B?TTlXUXdWWGZ6bTJJQ0d3MTVzME5ydGwvTVlIWWJkT3VWa2VkcXAxTTZVdUxG?=
 =?utf-8?B?blFaVkh5dlc4Q3M5U2M2NmU5T1cxZ2pUQTVQM0FGZno3bFQyUEtDWUdXUEEw?=
 =?utf-8?B?SzEwY3lQRVNad3B5RGJNSENXdi8zUWpkNEFZZjRmTzlHRVlwZEJuQit3cXk4?=
 =?utf-8?B?alYvcXJUVk11aldVbk81LzkvTWcrM0NoM2craHNaNDNXNnZ3UWw1NVRYVWpy?=
 =?utf-8?B?bDlWNVJObXBQak9PT0hhSXRNMzR5VDgwRXpwT20rRGpNaDJoY1htUXA0ZWc5?=
 =?utf-8?B?S3Q4bG9sNHd5UWQvRWkrdHpxN3NrUUYvOTlacUFyVDl0TU5DdkFxVXUrOUNI?=
 =?utf-8?B?VVQwMGpha0s4eXYva1c5a2p4RldNVG42MTdYak9MLy80d1Q5OXBCTHQvNXdR?=
 =?utf-8?B?akVaYzl1di9oVSs2cUZKQzFBWFZYbFpSVDhtdWtiVTlkak8vZlNRdGNiV0oz?=
 =?utf-8?B?bDFGMFdLYjh4OUt2SnNRMG5SRCswcEg3VUhKV3lYLzc3T0xrNjdrSjJlRlo4?=
 =?utf-8?B?UVNkd1FXbnRScGVvNGtrRDZlc3JuUE9aSjNYWk1BMHBwRkFNUWlLRnZVZk50?=
 =?utf-8?B?NEJZQ3daUUtzWXV3Q3lCcDNKK0lTbmV6ZGI2dm52ZTVBZW8rbm9rUlhSTll3?=
 =?utf-8?B?cWkyclJ3U2xnM2UyeTdFQjd3cGxqTlpqWWxNRVJKQmtPaXoyZU0xb3RkWVo3?=
 =?utf-8?B?RWh6Y3lUUUtadTlweEZzZHhIRG5qZ0FGcXlaTmNwWkQ1N0pXeTZVMGVMRXd0?=
 =?utf-8?B?S0l6S0MzWkE2R29NNk45L2xtOWVmNWViMnpsOFdZS0dMRzh6Y295cno0STBV?=
 =?utf-8?B?Q2hYVUJuRDA5SEFuY2FOM2ZTVEo1SzdydVMyNjNTcXVnMUN6ZnA3bkpMSEJL?=
 =?utf-8?B?b0hYWEZ0bEdIUXNtL29BMWxrQktnTTFFakxwM3FUVjRKaUF0dk5VOER0Rlds?=
 =?utf-8?B?aUJxbUJSODQwR1ozUDBCcTJ3OW5jVUttY3QrbDBMY3l1Z1pCQ1N4ZktLdWkz?=
 =?utf-8?B?ZkVrRDJhUSttbHVBWEFHQUpjODI1YWRpWXdvMENxaDhtOXg5dVdQWS9CVUVQ?=
 =?utf-8?B?RHNBUVQ4UkFOS2pzSjVVdWdKQUdQalVUR0Y0aVQ3eUxBa0lubXpMejlGMERF?=
 =?utf-8?B?WDhQbGlNejNneElFQ05rNE5lb3pQK1FXNTQ0Y1lxeFVFaDVYNjRuVVQ1cFhI?=
 =?utf-8?B?R0puMjhHUm9TM3pxS1VXUkJlWndjVHdndXQ5NlFhUEFoZDJOVWVCOWVOQjM1?=
 =?utf-8?B?V05sTW1DK05TY2YwWVg1d3VKWCtRUkRiZnJWbFZOMWlGemlxbC9EbHE1SGUv?=
 =?utf-8?B?L3d3d2ZlOEg0dFdQUFFhYStZbDFYNVZPdURlZkluZ2hTcFhRNS8zdmtkSldr?=
 =?utf-8?B?bTN3V3Z2eTBOOU5MdFZ4emgwWC9tM0pYVDB3a3l2UXBaSDI4M3ZqL0lDbytm?=
 =?utf-8?B?cFlxSnY4a2JsZW8yNFI1ZmNZUW5jR1JhSG50b3hhOG40RktqNmpTdkVqb0ZC?=
 =?utf-8?B?U3dZdnc4d3JXdVUxR2RmUlljekxhbmJ1VmhTcm1yc2wzcDg0a3Z3UDFmdkQ2?=
 =?utf-8?B?ZlhqdGpVZzVGWGFTRmlNOXJrVVFZL1YzRFZvd1NqcXhXVnlGMzA1YlJsREJq?=
 =?utf-8?B?VmxvUHhWVnNLSFdpRXlqTi91bk14Rk1nMGVTTVJSeDFiOVF2ZVJ3OHFFSFlv?=
 =?utf-8?B?dXVMMjNtLzlEYnN5bVZ3bS85U1BPaTBydXRBV1BZVWszajFNenVyVWJtZFkz?=
 =?utf-8?B?MEpJZkdWbHpUWjFnSDRIVEhqcW02eldwYXdPcUx5WXE1dmNXaWZMc1lkemIx?=
 =?utf-8?B?TC9nV3licEUzS3dmVWFRT21URjFXb3cyN29UZWRsTXVYdzQ3TkJoR29yVDMv?=
 =?utf-8?B?UEFhaVVGN3kwRlYvSG82WGVWRlJvU3U3bzQxcVJTdUp4RzhTanZvK00zNExY?=
 =?utf-8?B?KzlRakdoVVZnYTVTTUNJTC9Xamc0c1paNVQwMWUrUVRRdlpUTFVsdDBZWTdt?=
 =?utf-8?B?b3RZbmFKVVFkZjl1alpHcU5BR2EwVEsrNGtCM2RQQ05PMlh4UU9jNDlpNzRG?=
 =?utf-8?B?aUhWL0dkbngxc3R5SHVHMkk0U3RPWjhYTkVWSHArNnplNVdzelI1aCtFQlJI?=
 =?utf-8?B?aHBENy9JaHE1MW1SMHlvTERBVXoyblJabTFvSWlqTG5CU2NCaGRCQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5dcf791-d9d1-4ec1-2d62-08debc98faa2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 09:10:36.3221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbcN1TEB2qbJ9yU6eVC9Iztugg0NAK7fhu2zrs4Rj4Fjrtj/bKAHCfPr0qkhMd/aVRLACRz4olzFvL5Qc/1hLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311
Received-SPF: permerror client-ip=40.107.209.24;
 envelope-from=avihaih@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
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


On 5/27/2026 6:38 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, May 27, 2026 at 11:17:45AM +0300, Avihai Horon wrote:
>> On 5/26/2026 7:23 PM, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Tue, May 26, 2026 at 12:08:34PM +0300, Avihai Horon wrote:
>>>> On 5/25/2026 6:01 PM, Peter Xu wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On Sun, May 24, 2026 at 09:34:48AM +0300, Avihai Horon wrote:
>>>>>> Yes I think so.
>>>>>>
>>>>>> We just need to indicate modules that it’s the last query during switchover
>>>>>> so they can handle it properly.
>>>>>> Do you think it would be reasonable to add a "bool final" param to
>>>>>> save_query_pending handler?
>>>>>>
>>>>>> For RAM it will be used to indicate we are running under the BQL (since
>>>>>> currently save_query_pending runs only outside BQL) and to pass the proper
>>>>>> last_stage param into migration_bitmap_sync_precopy().
>>>>>> For VFIO it will indicate we should not do a query precopy info ioctl (which
>>>>>> is only valid in VFIO precopy states, not while VM is stopped).
>>>>> Yes, a final boolean sounds reasonable, implying both (1) last sync before
>>>>> switchover, VM stopped, (2) BQL held.
>>>>>
>>>>> For VFIO, I double checked the complete() that does not depend on the
>>>>> precopy_bytes fetched, then it should be fine indeed,
>>>>>
>>>>> vfio_save_complete_precopy():
>>>>>        do {
>>>>>            data_size = vfio_save_block(f, vbasedev->migration);
>>>>>            if (data_size < 0) {
>>>>>                return data_size;
>>>>>            }
>>>>>        } while (data_size);
>>>>>
>>>>> It's just werid to see that it doesn't depend on either precopy_bytes or
>>>>> initial_bytes, even if logically it should.. this will be confusing to
>>>>> whoever start reading this code.. but I understand not much we can do with
>>>>> the current kernel API.
>>>>>
>>>>> Side note: should we still better update these fields to make sure they'll
>>>>> be zero after migration? That means vfio_update_estimated_pending_data() in
>>>>> vfio_save_complete_precopy() too, with/without further sanity checks.  That
>>>>> seems to be missing right now.  I'm not sure if it's intentional.
>>>> Yes, it's intentional, since we don't use these values after calling
>>>> vfio_save_complete_precopy() -- they are only used for downtime estimation
>>>> prior switchover.
>>>> Precopy_init/dirty sizes are zeroed in vfio_save_cleanup() though, but not
>>>> stopcopy_size (however, that's benign, since upon new migration it will be
>>>> reset before used).
>>>>
>>>> So calling vfio_update_estimated_pending_data() here seems redundant to me.
>>> Logically migration can still fail during complete():
>>>
>>> qemu_savevm_state_complete_precopy():
>>>       ret = qemu_savevm_state_complete_precopy_iterable(f, false);
>>>       if (ret) {
>>>           return ret;
>>>       }
>>>
>>> If vfio_update_estimated_pending_data() has the safe guard for any form of
>>> overflow, then IMHO we should try to maintain those counters if possible.
>> Yes, we can call vfio_update_estimated_pending_data() in
>> vfio_save_complete_precopy(), but I am not sure I see what's the benefit of
>> it?
>>
>> If it's to ensure these counters are zero post of migration, then even if
>> migration fails the .save_cleanup handler will be called and zero them (I
>> can add a patch that zeroes stopcopy_size as well).
> Nothing critical indeed.
>
> I only wished save_complete() should look almost what save_live_iterate()
> looks like.  Because they should really do similar things dumping iterable
> data.. with some nuances only.
>
> Ideally, if we can add vfio_update_estimated_pending_data() into vfio's
> complete() it reduces that gap.
>
> That, including the other thing you plan to do by moving the slow sync out
> of RAM's complete(): both of them try to also make complete() look more
> like save_live_iterate().
>
> If one day we want to remove save_complete(), it'll also be easier.  And
> IMO we should consider removing it at some point, passing another "bool
> final" to save_live_iterate().
>
> If we see some other save_complete() hooks: htab_save_complete() is almost
> a dup of htab_save_iterate() with trivial diff, cmma_save_complete() is
> literally cmma_save_iterate() with passing "final" to cmma_save(), etc.
>
> So that's only about making VFIO less special in complete() only.  If you
> think that's a good future approach we can do that in this series together,
> but we can also leave it for later.  No strong feelings.

I understand.
This could be a good direction, however, I'd still prefer to leave this 
for later to not mix things up, if that's fine.

Thanks.


