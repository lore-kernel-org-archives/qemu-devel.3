Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5983F606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 19:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bpIfYwti
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQrIg-00074Y-Ne; Tue, 10 Nov 2026 14:14:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xQrIc-000743-Nq; Tue, 10 Nov 2026 14:14:31 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xQrIa-0007qE-Aj; Tue, 10 Nov 2026 14:14:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pu6yteo4jFH2sdOkbOkqmKT6OBH76Vc0B1jmyjGKueG3EF/yNxySP5YxQmT2wOoe+6TxZ+NIFORX4J7KdPqq9XCZ3aHK8PqCmxGKW4WTS1KXuXOdWe4Z6jW0vbTNsjxKVbkz4vcl2g6PhlGGDTTIliqcW9MpYYFE38X4ZEfk90JavtcdJLkKK92xxj85qtRCOT+ovuReVbw4RN2wFSu69BtoMiyuwkB5CJETYTTZ//25YEHwpYQ9nYFkOj2o4m4U7F8cCGIGHJRkisDu4J4awCUgEvtthIUVTmLrHY0s//Rh0DhcpXlxwNiM7Qy+/kWvO5o5q4jzViL+AN+6yloXpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MK9icqgmeRzCd8eAzmiUFMw40wuQSjrya36nAkdasco=;
 b=l/wW1A+OmN67EYYq8z92Yvx8DxPxpgn87bwbasA/AjIYKylhqcZANpdorua/V6AuZsyJl09BwDQPlCZbf1Yf36Bdh7UUOWxk6LMy3QwO+/DeShDv3dITP7IyN7HwMoWS4haUMFAzpy4goZNkjlBW2F8D8p4gWUkOcRcQLZn3+NMMtwtym/9dQNFkTErrtBxVKz5rGg89fUVbWmKHp9ItXcaMrTXjcIf4VFPls+1CK4dm5ZhPoGv5OJ5EDe3iRMGBjQylWEHTCWk2CHnpMK5yrg6NnHtMEOCIoQZioeWSjdC89NBdTeTyzkWhY7cDpLGpWIj8DEbwUIOfsdwxBYGnyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MK9icqgmeRzCd8eAzmiUFMw40wuQSjrya36nAkdasco=;
 b=bpIfYwti4GlzTKYxHvmvmlHm97FLG7PK/yMaoBtuqXP2dS0HlOUCZH9PaBB304HTsISai+dZYS3zwZKJ3IRnN946EoKM0HKAWn9POKeceIaFagiILr3pUkLmRxKAnmmThG77+8I9sKzz8/3ajJZI+9WQL9tMf2wtlSt1eXqWSXfNLLA3rPVqQzAn1jQMZ6lgRGlSuEiQ2KZ/pDhKCIUvODaNhSUDAkk0rUxMZPDzXb7tsGlQhkJRHy9nPu0uGAUaiblRHL+rYsz8jGTDHekFtGWnlHcYJGoBJtEYpRX7i81S1o3to5df9rKiqGrwb1RtQICrZbxckqDId+vidxnp4w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS6PR12MB186998.namprd12.prod.outlook.com (2603:10b6:8:52a::8)
 by MN0PR12MB6001.namprd12.prod.outlook.com (2603:10b6:208:37d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 19:14:15 +0000
Received: from DS6PR12MB186998.namprd12.prod.outlook.com
 ([fe80::995c:d8bb:2171:d829]) by DS6PR12MB186998.namprd12.prod.outlook.com
 ([fe80::995c:d8bb:2171:d829%5]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 19:14:14 +0000
Message-ID: <c92a3d27-599c-486d-9470-2cf3af6cf6d7@nvidia.com>
Date: Tue, 10 Nov 2026 13:14:11 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] hw/pci: add fixed BAR fw_cfg blob export
To: "Michael S. Tsirkin" <mst@redhat.com>, Ard Biesheuvel <ardb@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 marcel@redhat.com, "devel@edk2.groups.io" <devel@edk2.groups.io>,
 alwilliamson@nvidia.com, Jason Gunthorpe <jgg@nvidia.com>,
 Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20261102181241.3077981-1-tdave@nvidia.com>
 <20261102181241.3077981-4-tdave@nvidia.com>
 <f46e21c2-a0f3-460a-a7a3-eabf19b7d9cb@app.fastmail.com>
 <20261104071037-mutt-send-email-mst@kernel.org>
From: Tushar Dave <tdave@nvidia.com>
Content-Language: en-US
In-Reply-To: <20261104071037-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::17) To DS6PR12MB186998.namprd12.prod.outlook.com
 (2603:10b6:8:52a::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS6PR12MB186998:EE_|MN0PR12MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ed1f74-ecdc-48dc-eca3-08df3f5ecf4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|6133799003|3023799007|56012099006|4143699003|11063799006|261022105027099003|261026140227099003|261028144727099003|261026121527099003|261022075727099003|261102123227099003|261021135927099003|261021121427099003|261009223027099003|261102130727099003|260925021911599003|260925022911599003|10067099003|260925021311599003;
X-Microsoft-Antispam-Message-Info: 9ELJKRKhCIZ7SCf0ItabYoVy0pJENDHJObAC87gwpFXHrNmFVArQ3r5ObY2G9VLfeWHiTtm9Bm5zyoNLDIu8TiWTi3sEMoyxfKzvvzKODIXYzjpsu44JiDYJPo0Tiw9av56I+Q0KO5YXEqgefHLMqpqNeL7jEYdKiCa28qwOOLS280ORm7hRxU2kE7CKYOJ0D0smk6fiiILZ7TXlHTDYDPjnMW6OS4QWxZzxXDs4JYM7pBFE8igKA/qB96C0pRXotx/PIpGdFJHutnWBc8Eb7xtpJUdHRZysf9V6pmDA2CqkPFiiXAUmeRl7PUpF5He8cc7PmtctbcsUyOcGxnuj8ci4iYSpfR3CIkFuoJpKeiJe+99iitTNQqunk4WXlyp1nKSXUnk3NNpOwv/kcXb/AU+jwnSvpr5sXVdP7jamiQCl9kKU7vpOWnB23Ti/w8USj/ofosZtK/Aj1v/Y1MGUzV6k0OBAB1ZCSSkuCldRQ04BZ5GgnaWrGOKPO+hfSL9Ek+RJL9OJ0tN/NHYvsc2hdWH/dlFdLY5GoLZFX3Angrk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS6PR12MB186998.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(6133799003)(3023799007)(56012099006)(4143699003)(11063799006)(261022105027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022075727099003)(261102123227099003)(261021135927099003)(261021121427099003)(261009223027099003)(261102130727099003)(260925021911599003)(260925022911599003)(10067099003)(260925021311599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3E5VzlaNkFUVzBuWGFTN3ZSMU1CSnRoVTh6QWwxVTU5Y1ExMC9WQVIwVmw5?=
 =?utf-8?B?OVAvZ2NzcWpQakY3Zm1RSk92TmNXQ2kyVndOZkJ1L3VIaTJHZElnYmgwbWtu?=
 =?utf-8?B?eUM0RmZwSFR6N2dmSlBONlJjMFZKOWFBSHpJeXlpSzlLdmg0MDJLbDVBU3Y2?=
 =?utf-8?B?TWhaOVZLNER5MHptSmZGaTNTSHZBbko5bU1wTkZhblhkUVNrQm1QYzE5RWVv?=
 =?utf-8?B?TWNZZ0wwdnREN1M2TU1SMUNyM2JBWFo1Ylk1ZjhLK2JqSDUwR1orNWhobURU?=
 =?utf-8?B?ajhJYkQ5N1pWWWtUVElvU2ZqU2Y3S01LZ3J6SGl3VExYM0FwNlJoYUR1MEcx?=
 =?utf-8?B?cVdTR0UzdlBQQlhzWnpIWXV2Uk11SjVMeVBQbVFVZitxT0k3VGRpL2crVTA3?=
 =?utf-8?B?OFVjVFM0ZmVOMW9yN2x5ZWhVY0dJY3VVMUZkeGJQRlBHSTk1WHhKR2UwSk95?=
 =?utf-8?B?dHZkUUdXSVBuRHJHK2hMYmRZMHR5U1ZyZW0xZFRwcW9jQk1sdDl1UUZJSTA0?=
 =?utf-8?B?QzZ5UUx3Nld3c3d3NVZYRjVGMFExeTB1Z1BkWTd6UHF6MUlndEJLZ1F4M2Zr?=
 =?utf-8?B?ZjRjbllUUGFoKzNvYUZ6OUcvUDY0eldFb2xqVU1SWE42TWM0R3VBVk0rUkRP?=
 =?utf-8?B?MlpreTVHZWs0bk4vemh0M2pjY1NNZTJJNVZRZ2d4eFk2eWNHeG1BczBUcnZk?=
 =?utf-8?B?L2NNL2N0c04zbEQvR3hGN2g0ckpHWEJQOHRJWDNrZ2NZREF3OUdnNFhSK0gv?=
 =?utf-8?B?ZEF3aEMwaERpNUtPclRyeWppL21CejluUVVWQzhmU3J0MXQreUpBcFNSY0Nz?=
 =?utf-8?B?VE83eHdMaGozc1NVMlZmamd5c2dJWlpLQWloQUtqajVXUHBhZjM1SDdremR0?=
 =?utf-8?B?SCtmSVlhaFVFSzdxcDFGbjRVWHNBWENQS3lXUVpMdkU1Sis4Zm0vYTNBLzg3?=
 =?utf-8?B?QmhqNUNxRENxaVhwYnRwOElsd3JaZENIczJXOVJWUkxObzEzWDM3YWlGdWpw?=
 =?utf-8?B?MEp5MWVjY2k4ODFPZ0FZbXVaZ1hDc3M1Vng0Tm5iTEdBMktXM3QxNlZ4QVdS?=
 =?utf-8?B?cjU4bnJkei9YV2pzVWRWdkJTR3N5TVZwWjhsbXJHMHZXWVpPUE41bi9jTCth?=
 =?utf-8?B?RzZFcVZZUlB0Nm9qSnpLODlCaGpSSTBpQ2JEMXF6ZkRVSmpTTlExN0wxNWsz?=
 =?utf-8?B?d2grY1JXNUF3dmx4UTU3LzVxNzhCQmJBTWY4MHdwOVVabkNLbWhXVmk3QzBa?=
 =?utf-8?B?aWJ6RXltY0pzVXZjdUxoKzRVaGwvS1RJeVdJYVUzOVpoSFZGcER2eTVFMDlv?=
 =?utf-8?B?a2RmM2RvZm5sZm1DSi9QcWJraFU1K0drR3lRNk5nU01pUDZKK1F0NU5zbnlO?=
 =?utf-8?B?SXJOMlFyUzhaVzNlRUJWUXR0UytzbEtQWVhqRjBRdDlZaUtHZ29iN2swTHJI?=
 =?utf-8?B?MXVqV2ExVWFGeC93U1hCb3Y4YmkrNU5TRjQvamk2SndpZy9IR3BSTVhUbGtQ?=
 =?utf-8?B?WWdjNk9xRXREdTQ3TnJiM3g4a09kRzcvY25BdS9FMms3Y0l6ak9zZVFEL2p6?=
 =?utf-8?B?YkJyVlhUMmR1OUl2OGZ4c1pvb3J5UWcyUnVLSHU3Z3ZhbC9DTzNaaE05Nkx1?=
 =?utf-8?B?bWVidW5hczdQV2FCbHpidWFDbHdvbmNBbmV5eXFYQ24zWjJKMUl0L085Slpj?=
 =?utf-8?B?UlBSTTNON1ppZm41aEhPSFVRUHNmSXExclZHay9pOTZBUm1Xa1pGMkdmS2dl?=
 =?utf-8?B?VkZ4N2hjTTFtdXVFZk5vOGpRVjdpUUQva3gvenBxNHUzWEVYdExsQmNqNDRq?=
 =?utf-8?B?QWlqbXgrZnpLK09aMUdLYnJzRGdVVEMwd0hxbXMxNThKczBKSFBET0xSR1Yr?=
 =?utf-8?B?cWV3d21jZHkydHpudW1aQm5qbFR1SXpXZnVnN3RFZHBXSWtLUkpkejJkdlR0?=
 =?utf-8?B?L3YzOUNRNXFSUHJoMGxHZ0h6YjZEVlhUTTcxRm9UdTI1Ym5rY0xnbStuSEZ2?=
 =?utf-8?B?K29HeHp2V1F1cUNhK3FBRjJ3VVJ3dURnNDZZL1ZYUk9QeHBXcUpwR0xFRkdm?=
 =?utf-8?B?citnb0R1azVHUUlkRkFWM2hFUHFWM1p1Tmp6ZUI2dXN5ajJTNjd2N1lxbEpV?=
 =?utf-8?B?ZnFmUmlObzBqZ3p4VjJRR0I0Um5KcGdBWXNqSTNMR1lJZGJVRGI0MlNWY1Zs?=
 =?utf-8?B?THEzZkliamNTRER3U3AxNjhTMUN4SFQwMEFpc2lmT2VHUWpOMzhKYUxDWjJK?=
 =?utf-8?B?ZmxONURVYUZUOTRpMHFzL205MDE0a0FoVHlGZTlyU3BVNEtBSm1FUW1CTi9v?=
 =?utf-8?B?NUhHN3J0djRJejM4bUEwd2RDYkh6TnRJVmJFTy81TStxZHNRSDFvdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ed1f74-ecdc-48dc-eca3-08df3f5ecf4a
X-MS-Exchange-CrossTenant-AuthSource: DS6PR12MB186998.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 19:14:14.8375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWzwh87d2OnciidCSExIWYpcX8VMPgmKkm4WYrUhzy5q7bD/j/e0q/qbRofbcSK/eN8wEsvPWq5+n6cNZMNsjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6001
Received-SPF: pass client-ip=2a01:111:f403:c107::1;
 envelope-from=tdave@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



On 11/4/2026 6:11 AM, Michael S. Tsirkin wrote:
> On Wed, Nov 04, 2026 at 10:59:47AM +0100, Ard Biesheuvel wrote:
>>
>>
>> On Mon, 2 Nov 2026, at 19:12, Tushar Dave wrote:
>>> Introduce a fixed BAR fw_cfg blob exporter that serializes PCI
>>> device and BAR information into the "etc/fixed-bars" fw_cfg file.
>>>
>>> The blob contains an entry for every PCI function with memory BARs.
>>> Each entry carries the device's vendor and device ID, whether it
>>> has a fixed BAR configuration, and its firmware device path. Fixed
>>> BAR entries also include the configured BAR address, size, and type
>>> information for each BAR.
>>>
>>> Document the format in docs/specs/pci-fixed-bars.rst.
>>>
>>> Signed-off-by: Tushar Dave <tdave@nvidia.com>
>>> ---
>>>  docs/specs/index.rst           |   1 +
>>>  docs/specs/pci-fixed-bars.rst  |  75 ++++++++
>>>  hw/pci/meson.build             |   1 +
>>>  hw/pci/pci-fixed-bar-blob.c    | 308 +++++++++++++++++++++++++++++++++
>>>  include/hw/pci/pci-fixed-bar.h |  63 +++++++
>>>  5 files changed, 448 insertions(+)
>>>  create mode 100644 docs/specs/pci-fixed-bars.rst
>>>  create mode 100644 hw/pci/pci-fixed-bar-blob.c
>>>  create mode 100644 include/hw/pci/pci-fixed-bar.h
>>>
>> ...
>>> diff --git a/hw/pci/pci-fixed-bar-blob.c b/hw/pci/pci-fixed-bar-blob.c
>>> new file mode 100644
>>> index 0000000000..dc94debfad
>>> --- /dev/null
>>> +++ b/hw/pci/pci-fixed-bar-blob.c
>> ...
>>> +/*
>>> + * EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL's CheckDevice interface
>>> + * (UEFI PI Spec 1.2 Vol 5) only passes VendorId/DeviceId/RevisionId/
>>> + * SubsystemVendorId/SubsystemDeviceId, no BDF — so in EDK2 we can't
>>> + * match a blob entry to a specific device directly using BDF. To work
>>> + * around that, we prepare the blob entries in the same order PciBusDxe
>>> + * discovers devices, so matching by VID:DID inherently works.
>>
>> This sounds rather fragile.
>>
>> Could you elaborate on what order this is, and why it is reasonable to
>> rely on that approach being stable?
>>
>>
> 
> Also, bus numbers can be changed by guest, and I don't get why
> would you want to report devices without a fixed bar.


The bus number is not needed in the blob. It is included only for
debugging and is not used for any functionality. The firmware matches
blob entries by vendor/device ID and discovery order, as described in
my earlier reply to Ard. I can drop 'rp_bus' from the blob.

Devices without fixed BARs are kept in the blob to preserve discovery
order for matching. For example, if two identical NICs are present and
only the second has a fixed BAR, including only the second NIC's entry
would cause its fixed BAR address to be assigned to the first NIC,
which is discovered first. Including both entries ensures the first
NIC is skipped (each blob entry carries a flag indicating whether the
device has fixed BARs) and the second NIC gets its own fixed BAR address.

-Tushar


