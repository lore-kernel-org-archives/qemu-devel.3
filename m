Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BF5606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fNlNCsU+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM8ui-0006sN-S1; Wed, 28 Oct 2026 15:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xM8uL-0006qE-W4; Wed, 28 Oct 2026 15:02:00 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xM8uJ-0003ux-6F; Wed, 28 Oct 2026 15:01:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0BFSubvDn3VW+58KA7fbYE035QmWBAWxZFu4MjpjyrrzNxFwF9+d6OHlttYPVM56O+WCqw2tkf2DXABC5tky2/WqTAbasifhRT4BBNm6guAFsW3ZTTa/C/XWlvpdyNmJr13lpl6cLerhoz4xOSMo0uB+XOyt0MkPyBp7+jPLez+a4uZjYqurW/1VVfrgwWh+xDGuKnr5EgNvKEDSvTPWwwW55XGBgxVRwNy+MM5Z3qljMQacZRc8379s/z5x44niqSLJUz9+PCN53LqiAOIi6xjSuI2gAWr9d1auDf0kzu8gLoHF6UkSWR4CDZp1W5yMSm+FboHjcCTQys+eU/G8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2Fel6HaTursNic4Ph67PkNQV4E0iqCe88Fj6SvLrbI=;
 b=Z6MfAFOlGZXz50s8jHtarFsPR94LG+WKT6o9vrzZHg6jA22TBIJwyZnNJFnJLC7tI6stCh0VXfc6RCPgbwjn7WGZsbkLWlCLe5WgaBsqiru8FsJ0aFYEY8ZUusAmbbJE15meo4I6JHZ6MCBLVk7TGxg4gpENZpFMNcVzk8YswzmhJfp6ABqLZQrMqesf1e3+NCCKK4oWWMghe5QsBrCCna44lag8vJUyK4/CXWHLp8JSvdNEvJiNQdfy1rzZQwLrLOR5mTQEMRLbW3VRC2a0YKbcQkqvoTWjjswJ25EzPmPvTT53w8wmPAtluB6sB4bTC8xT50IsSPk1gOkoDzet/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2Fel6HaTursNic4Ph67PkNQV4E0iqCe88Fj6SvLrbI=;
 b=fNlNCsU+2K6tYXoN5R8eWrjX8L4X9F7WiEtlczMDKOdxh5r+XCqjOWqZ8tT4eY7ncw02VFpRnEdvVRe8EK2bCWPOgeNZllT7june9vYui6gpwCmtgTwLhWrC/z5gtespoCWhWwR8WfbwJH31L3+u5lUJentr3WEPNCEs1WpyZ3+AlFYqv7aemk7Sp9obVTCpv+MrqJ83xsOPrgalppkQV5yDdtE5KsuUNwER8ikRfrFFFXT/8LXe/qZKkmTNoNtOtN9IN6BC3g0WwIYc6TB630X8ASi5CV6uK0wx1+SKHhMigx5A1usIH6OGpzIMEuNYG/HKMytwLAEaFjSVJwT8Mg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by CH2PR12MB9542.namprd12.prod.outlook.com
 (2603:10b6:610:27d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 19:01:46 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 19:01:46 +0000
Message-ID: <f20d4a6b-09a4-4464-8d5d-3e35d4f147c2@nvidia.com>
Date: Wed, 28 Oct 2026 14:01:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw/pci: introduce PCI fixed BAR properties
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>, "marcel@redhat.com" <marcel@redhat.com>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>,
 Alex Williamson <alwilliamson@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20260916185554.917526-1-tdave@nvidia.com>
 <20260916185554.917526-2-tdave@nvidia.com>
 <SJ0PR12MB861469AD6121282858D853C0AB602@SJ0PR12MB8614.namprd12.prod.outlook.com>
From: Tushar Dave <tdave@nvidia.com>
Content-Language: en-US
In-Reply-To: <SJ0PR12MB861469AD6121282858D853C0AB602@SJ0PR12MB8614.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::6) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|CH2PR12MB9542:EE_
X-MS-Office365-Filtering-Correlation-Id: 7843f8ad-f0d6-475e-e48b-08df3525e99e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|18002099003|22082099003|10067099003|261028144727099003|261026140227099003|11063799006|56012099006|4143699003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: 84YBi+3VT94LE37yPStH2ww74D+o5WECC4EHXZ5V906HEA3lwz4SvPGIvh2PuR4rARZubXcaeP4/p4Xph7QUuyMt5zA2Ge3MqQiULeCrTFfWhlN4y2HJDVWosycp3EQe2CDBQOMvw1uG1m8jqAKBbns3da/jTdnYllSPFk4Uspn99WUw3j6r+Mn37LULMFvPZLb27pjgfFrl3vphanDm7NDahroJRyUk5YgBljB6Of4aBffqQ+x04npR9SaUJjzuTtMw+3f07qCEsBHWXJdHjlfqSGthjz3kFpBTQkOpedU3tBpl8OTvItNmdXoZoH13HpPco6sodMRAatrqVTzrO+N6PLvDnfxG2ndo8ctUNnl0HlI6w0+QHTPbCJhYzeueEQmN7HhG85WZ4qr/JlBseCl6YN2j9Nawkhh8mF7A7iWQOZjXho1D5vqAxsyhLpn2ZRV6dVY5EiLgkNbkrKJAp+srT8BtGI9XZyT2yW8WBxwIDRHfQKj82AFGdxgYDgaGnPt6cDaDxO+oD3kJPx5vkuWcjMDEaDUHMxIVw4LCJ9gSJ5kFD9u5aBOV64UFUUdHmx1IZAHxT+LqWQGQxRi9wDQbXS5fBOJwwIZfcUHbmlg7XJACyEzx1WQm7ytZzEvURiAU4VT0oMJsRIazsqUj8scTIm/Mne7BnMIu4gaQ4hQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(261028144727099003)(261026140227099003)(11063799006)(56012099006)(4143699003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(261009223027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zy9mYktsZ2RvR1JMUi9IY1o0U2NEZnppZThUMjBNNTB3WForRFhwQVpCZFgw?=
 =?utf-8?B?TjV6WXYxRUlPVDlsdFQzeE15ZUU2NnNadW9yMlNZVTR4WXM2c1hDT3V3MVVZ?=
 =?utf-8?B?MkNZbDgzRmZVQUwxRExzblF1THpPVkp5MXRIUkY2NWNoMHhpNEpyLzF1ZElz?=
 =?utf-8?B?MURmTTFDVlF4dW1BTU9PNmRHek9MMXp2UkRTMFNvMllPNFNPMkFBWVEwUVp1?=
 =?utf-8?B?b0FmRkpsMkFiR3FhbU53MTJ1NVcyTjFROEdvYjNxaDNBL0duTVduQWtDbSt4?=
 =?utf-8?B?ZERoR3YwNWErei9DeDZpOWp3U3pBWGdISE52ZTBzQUdNN3FONFR2b2RoWUFi?=
 =?utf-8?B?czlUMnNNeHc2UW1UK0F0bDdaeFlSeU9ENVEzK013OC96aW1VYXdITStySWNT?=
 =?utf-8?B?ZjExUC80WTgzZzFISEZMVUtudkhBdGJRdlZRM3MzTUczbENUSWorK0R1Tm9V?=
 =?utf-8?B?V0NCL1lNVXFHbGluY3g1ZjRxWkpad3hXelhKcEFGNktSK1d6cEM2eWdoNGtP?=
 =?utf-8?B?QWV6ZnZlbnVIZ0dCd0lqaGdlZnFkMG5VY2thcHJ4SVRTbi9zOWUrZmNnZmEx?=
 =?utf-8?B?a2dldStVYnVTVXVFRW9IcExmTnpBSGUwQWtkR1hBU056eHZZeVhwNVZkMXlB?=
 =?utf-8?B?VHZoSXN3YVhycVloVjFSRUVWK0ZoallOUUZaTTExanZUZWpNTXhudkFXNWUy?=
 =?utf-8?B?ZnBXVUZCV3ZXMmtkRW44RUZLNWFKd2lhSjBRQ0xid2ZIL0M5elZoZnpLSVVp?=
 =?utf-8?B?Wmt3Y2NBTTRhYnpKOXJ3MERDQWtHT1lvcVUveUpzTmk2ejBSSy9zLzVWUUJs?=
 =?utf-8?B?M21NZ3RQZjNPdmlEaFRhNjc2ZVk4TzNPbFd0eFBPc1hRRnorZGVjbDd0MlRY?=
 =?utf-8?B?QTQxNHdBQXVremJaM0IzZmxyejVZWDJZSEp5QStaMjh3ajVhZkJOSW16eVBk?=
 =?utf-8?B?ZXdXdFAwNC96dEFQR3UyeFVVZTdIdmRtbWpaalprY0JaZ3Y3UkEyYzJFM0Uw?=
 =?utf-8?B?SzVtY28raml5TFhyeFdJbFUvTmZVNkoyd3hlV2ZRUTlmT3NFZGdTaG9kV0dw?=
 =?utf-8?B?K3N5QVdxYkhKdnFZNGdva0c4R292UDNVaytFYjVuaEttTXMrUlhEbVdzaUl1?=
 =?utf-8?B?ZWFQWDAwdzY2c1lNbFJjdUFYZzhpa09XVnp1aWVwTFFqWDNFaUtOdFZpMlhm?=
 =?utf-8?B?bjdKb0x2OHVBRzk4OGs0WmJzSEpDbXhBRG9qaGpoc1JLbUdEdUJTaFBjcmxE?=
 =?utf-8?B?YmZXVGFabG12MFFCMm82Q0QzRkVJZldtKzI5elMrVFpkVjlwRGdWZlZTWGk2?=
 =?utf-8?B?dVYvU0Z0ZWRrdTc2OXY2ek5CVFVXUGdNOEVFc3d0R2oxVXhUVmx1SVNFVkYr?=
 =?utf-8?B?T1Zwb2haOVhTT0dCTlgySG5BQlgzVk1GaXgrdDZML202NlV2NnFrQ2xMVGRT?=
 =?utf-8?B?THY5emJxWXNiR2FWUmJxdFg5a2RKNFB6S05LRU85dnVkY2NmMFo1UUxJVFlm?=
 =?utf-8?B?WmY2bUZ1K0pvSHZQelhyaWdvMTJhVWNxbTdodU0xSmI5RVhpTnZkc0hFa1Vr?=
 =?utf-8?B?bHhidG9mTFBuNFlydVJNcGl3QUQ3R3lLV2RLcjNJWWovY2szL252NElrRlBz?=
 =?utf-8?B?UGJjVWU0ejVnM3BRZk05Q0JGcXlQQjM5REo2N3dIbG1vd0tQRXVxTWl2bWE2?=
 =?utf-8?B?OCtmYi81LzZCcDFSUUhjS2ZSQ045Qm9taEpOcDNOMUc1ZmZFTHAzTVFMWG80?=
 =?utf-8?B?bW9KdFM2R2E5QWtRamtGNTEwMmcrOUhzTU9Ed1pNZFNCRG1BSjdTOXZPdVBT?=
 =?utf-8?B?UU5BaGtiL1NJczkzUFNRNEprdytseGJsR0ZoNU54Q0UweUVPUG9odjArc0Q0?=
 =?utf-8?B?RkRBZmk5Yms2TUlsVm8rQlY0UlFabFlXRks0ellwTEZKdVRRbU5USWVkVUYw?=
 =?utf-8?B?bEtkNUZ2S2ozWGdMSU4wWkJTN0RJdGRITWFzd2hPeldUZXQ0R0tOeXZ1TFZ1?=
 =?utf-8?B?NnFkcVVwQ1JEbGtYL2pCb1V0RGxrWEJqQ0J4c2x4alVHajhwT0pGV2pYb0M1?=
 =?utf-8?B?YWJrOEVDRXhpbHBzWWwxVTFTaTIzSjQ1QUlTbkxiUGhDWU55WitGUURhclpC?=
 =?utf-8?B?Slg2c2EvTGkxM3VuY0ZPdkdpbzhCTm1FcE9hOTBFbVZMT3ZGRVliWDVJOFY2?=
 =?utf-8?B?MGpQcDBvUXlyZG56MUp3WEJRNjVFc1Q1VXVpcVZOVmI5bm5ycDhIbW9hRjV2?=
 =?utf-8?B?NnJWaEt1RDVmNnI1bVY1RTArRXVLcjhFcjlrQlpmRHVWYXRUb25QK1VTM0Zn?=
 =?utf-8?B?YlFtdnJTc3ByS29obG9GU0wrcnlhZjhaQWpTalBMRUlmMEgwSlR6dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7843f8ad-f0d6-475e-e48b-08df3525e99e
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 19:01:46.1392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yJ8frZjRvaSvxTPEFmDv0F81/mm/pZWh7j0ryBmaS6ZV6RFInyAP9RXziHBktDOi0HeJBCnUxaZ3dtGd3EcRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9542
Received-SPF: pass client-ip=2a01:111:f403:c10c::1;
 envelope-from=tdave@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/27/2026 9:43 AM, Shameer Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Tushar Dave <tdave@nvidia.com>
>> Sent: 16 September 2026 19:56
>> To: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.org; peter.maydell@linaro.org; mst@redhat.com;
>> marcel@redhat.com; devel@edk2.groups.io; Alex Williamson
>> <alwilliamson@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>; Shameer
>> Kolothum Thodi <skolothumtho@nvidia.com>
>> Subject: [PATCH 1/5] hw/pci: introduce PCI fixed BAR properties
>>
>> Add fixed-bar-N properties to PCIDevice to allow the guest address
>> of an individual PCI BAR to be explicitly specified. The properties
>> are available for PCI BARs 0 through 5 and accept QEMU size
>> values, for example fixed-bar-0=0x40000000 or fixed-bar-0=64G.
>>
>> e.g.
>> -device some-device,fixed-bar-0=<addr>[,fixed-bar-1=<addr>]...
>>
>> During realize, validate that each specified BAR exists and is a
>> memory BAR, and reject fixed BAR configuration for hot-plugged
>> devices.
>>
>> Signed-off-by: Tushar Dave <tdave@nvidia.com>
>> ---
>>  hw/pci/pci.c                | 43 +++++++++++++++++++++++++++++++++++++
>>  include/hw/pci/pci_device.h |  7 ++++++
>>  2 files changed, 50 insertions(+)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index 0efb4eb4bb..775fef1beb 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -89,6 +89,12 @@ static const Property pci_props[] = {
>>      DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
>>      DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, UINT32_MAX),
>>      DEFINE_PROP_INT32("rombar",  PCIDevice, rom_bar, -1),
>> +    DEFINE_PROP_SIZE("fixed-bar-0", PCIDevice, fixed_bar_addr[0],
>> PCI_BAR_UNMAPPED),
>> +    DEFINE_PROP_SIZE("fixed-bar-1", PCIDevice, fixed_bar_addr[1],
>> PCI_BAR_UNMAPPED),
>> +    DEFINE_PROP_SIZE("fixed-bar-2", PCIDevice, fixed_bar_addr[2],
>> PCI_BAR_UNMAPPED),
>> +    DEFINE_PROP_SIZE("fixed-bar-3", PCIDevice, fixed_bar_addr[3],
>> PCI_BAR_UNMAPPED),
>> +    DEFINE_PROP_SIZE("fixed-bar-4", PCIDevice, fixed_bar_addr[4],
>> PCI_BAR_UNMAPPED),
>> +    DEFINE_PROP_SIZE("fixed-bar-5", PCIDevice, fixed_bar_addr[5],
>> PCI_BAR_UNMAPPED),
> 

Thank you for the review.

> These properties are exposed on all PCI devices, but only virt wires up
> the validation and fw_cfg export in this series. On other machines, a
> valid request would be accepted without placing the BAR, right?

Yes.
> 
> I think it is better we add a mechanism(MachineClass flag ?) and check
> that.

Sure, I will add a MachineClass flag 'bool pci_fixed_bar_supported'

-Tushar
> 
> Thanks,
> Shameer
> 
>>      DEFINE_PROP_BIT("multifunction", PCIDevice, cap_present,
>>                      QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
>>      DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,
>> @@ -228,6 +234,36 @@ static void pci_bus_unrealize(BusState *qbus)
>>      vmstate_unregister(NULL, &vmstate_pcibus, bus);
>>  }
>>
>> +static void pci_check_fixed_bars(PCIDevice *pci_dev, Error **errp)
>> +{
>> +    PCIIORegion *r;
>> +    int i;
>> +
>> +    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
>> +        if (pci_dev->fixed_bar_addr[i] == PCI_BAR_UNMAPPED) {
>> +            continue;
>> +        }
>> +
>> +        if (DEVICE(pci_dev)->hotplugged) {
>> +            error_setg(errp, "fixed-bar-%d is not supported on "
>> +                       "hot-plugged devices", i);
>> +            return;
>> +        }
>> +
>> +        r = &pci_dev->io_regions[i];
>> +        if (!r->size) {
>> +            error_setg(errp, "fixed-bar-%d: bar%d does not exist on %s",
>> +                       i, i, pci_dev->name);
>> +            return;
>> +        }
>> +        if (r->type & PCI_BASE_ADDRESS_SPACE_IO) {
>> +            error_setg(errp, "fixed-bar-%d: bar%d on %s is an I/O BAR, "
>> +                       "not a memory BAR", i, i, pci_dev->name);
>> +            return;
>> +        }
>> +    }
>> +}
>> +
>>  static int pcibus_num(PCIBus *bus)
>>  {
>>      if (pci_bus_is_root(bus)) {
>> @@ -2393,6 +2429,13 @@ static void pci_qdev_realize(DeviceState *qdev,
>> Error **errp)
>>          is_default_rom = true;
>>      }
>>
>> +    pci_check_fixed_bars(pci_dev, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        pci_qdev_unrealize(DEVICE(pci_dev));
>> +        return;
>> +    }
>> +
>>      pci_add_option_rom(pci_dev, is_default_rom, &local_err);
>>      if (local_err) {
>>          error_propagate(errp, local_err);
>> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
>> index 5cac6e1688..fc5f50a1c4 100644
>> --- a/include/hw/pci/pci_device.h
>> +++ b/include/hw/pci/pci_device.h
>> @@ -187,6 +187,13 @@ struct PCIDevice {
>>      uint32_t max_bounce_buffer_size;
>>
>>      char *sriov_pf;
>> +
>> +    /*
>> +     * fixed_bar_addr[N] holds the guest address configured via the
>> +     * fixed-bar-N property for memory BAR N. PCI_BAR_UNMAPPED means
>> +     * the BAR's address is not fixed.
>> +     */
>> +    uint64_t  fixed_bar_addr[PCI_NUM_REGIONS - 1];
>>  };
>>
>>  static inline int pci_intx(PCIDevice *pci_dev)
>> --
>> 2.34.1
> 


