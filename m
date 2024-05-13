Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B61C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 13:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6W5i-00067w-9R; Mon, 13 May 2024 09:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s6W5Y-00062V-Ag
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:51:37 -0400
Received: from mail-co1nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2416::600]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s6W5U-0002Fu-3R
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:51:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIruGNj/oZmS5gOFEVE8qbapwOYc7GhixSvuSgVodV9I9KOVF+fTk4SxU66ZnGTU0+3kfO5vnBMr6wZECRHDHZxpY0PmQQlroUwIX04SP+q6Wz2y4v51QzjGMtYOqgDsJBl+gJPtgL33F1hQn5K5eQIK4fYbUC7SZcIrF28dnRRbIJ38dUPrJWtlLE+Fc0HbQScrAh820PX2rSRI+YtnG3Gl7LLvhsW0+tY+Jdl09hF7ZKhMqSY7BWfnVgw9SY8Gr2Ps8tpUsUITfmIlFXLyEkbXTmrspE1pIGg0qhsUFyvhn2g6CYzW/ighU6Uidah/jc1sGTSvrrlPfwcleiqYaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05TO3T/1HMOHWL5bJg7Oq6ZkYsk0pcbvrVzGAeNVssk=;
 b=PbqBo2uaAYTtkiJGcn8XTjYpb/Zq0SaPXznM0EfS2h3KW/yjV0ktW65YNadCrsEfY06GibmifeyLJ/waWRsJdh8ldDPRrKzCvK7NAHpCetwf3iBYSAMuZ+7vRBfrtRsJK2rhMcPVSztxf83KhGJly28RboXtyXW8eDk42QNkByhEDZO3LJXBIu2J6GGRLL6dGLfpMPslwb+tya3iwIdY3n7VRIKFca7AZaERwQgSiPcNK5JLsMOnwRSGVv6hFBzVmWr6iRvNdQnTzB3ICeISj5fBYho1Cx+G5p/tSZ55AmE7vsm5lA1X+SFSG7STf7/zDjmqg+P78AZMabv2piU1hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05TO3T/1HMOHWL5bJg7Oq6ZkYsk0pcbvrVzGAeNVssk=;
 b=WvIExdwz+6aHdPJGH4K2fHvegMdCbxODnHXZv8XazI7H8mvlps1amg5szJMZU0txM3aML3MNOIR8hpXxAzPUrUyRwU3w51bdxefiXuLNMlg5uaSi2Qhiz2cmIhX5NwHT/JuNBaFcdFRKbndfKTk04X5o8p6a5kPbNi0d/KZu7b9ARGumAiSiL8iUpKT5gATMiBbuTgdeZgVn6xkpL9vKTWbPC6nf+nTBy79k8wOX8Tz/h68sNSD/59bSYF3tAR1rZr9EYTYOIviu9vx5Gf+RG2Lbq4lN3XSqCTg0XZZL/8K9g+6quIU0IlFZwJhutWPNHmWL+k+92k788Yy4JMxWlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 13:51:24 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 13:51:24 +0000
Message-ID: <6f7766e0-2f50-4ef5-90e1-46bd7c5e4892@nvidia.com>
Date: Mon, 13 May 2024 16:51:18 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/10] vfio: Add Error** argument to
 .get_dirty_bitmap() handler
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240506092053.388578-1-clg@redhat.com>
 <20240506092053.388578-9-clg@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240506092053.388578-9-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::9) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|MN2PR12MB4303:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4927e9-37e3-46a6-e517-08dc7353c74c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUwvM3lBSloxNjl6amZvdTkwVUVZdkZYWjd0L2pLUEFaaVhWUHdLS2g5RFNk?=
 =?utf-8?B?L1crQ3pTV2xBZlNaMHA0ZlM4c2dwSUJuVmFQblZvQUV5OWg5TXZ1YnRUNll3?=
 =?utf-8?B?RnR1NHpRZU5LN2R0U2F2UUxQWEgrVnJXSFJmRTN1TlJ1SWNvVmpOM0dtWWpk?=
 =?utf-8?B?M2g5dHRhN3dndlhYeWhSenB1cG1KeHp2Z29zTVg3WmI5OFpkZTNmYnYxSmpl?=
 =?utf-8?B?NDd2NWV1dC9PTnJpcFU2OVArbEVTSVlhVWxUZkF0aTMzWnNkV0hrbkx6M0xs?=
 =?utf-8?B?Skcremg4ZUxBZ3NSdXpva20wUmpZaVRhRGkzNmVQNzlIZlhadGdUVnBwamVD?=
 =?utf-8?B?VzlTVWJwSEU1OGFJbFpJWXlyRWNhME5RTy9UNmhYOXhEM29RN2R6aUZuazJU?=
 =?utf-8?B?eDlDN0N1cCtDR1YyOXMxNzFPaTBNcDdWUGVIM0wzeUxQbXRUSjlhQStNbEtW?=
 =?utf-8?B?SXNSZFM3R0taOWlKL015WE0xaFZoM21ZVDE4YS9DcTk3VThaUjZFWHo2UTNB?=
 =?utf-8?B?Q256OUUzVWg2TkRUL0tXS01zWml4VVNRY3VuU1M4TlZGV3BIUnM5Nm5xc2ZO?=
 =?utf-8?B?dm9IWHYweXloSEt3bmhJWnB3RjhUVVZwWXRaS1VGdno5SExuUWFGSTd0TXl4?=
 =?utf-8?B?a0tyN1Q4T2QvZTY5Wm9mQW8vTmtqdHN6eDVnZzdsREpGMm9OQlc4ZWFtMkFl?=
 =?utf-8?B?NW91UjR6OG4xblBRc0hSdXl2SWYvbzhMenVTSzdZVmRKSmRSZkw5ZmdDcFkw?=
 =?utf-8?B?ZDNNYTdjQktpWHFkbk1qZ0Y0ejZvbzd1V0FwVlhJM1FSbzJNSkxHc3U4U2xa?=
 =?utf-8?B?MGJlM04yeGVWb1FkNWtCQmgxS0JWbHdON0l0VnBScXR6eldOT1l2YThlaFlo?=
 =?utf-8?B?RE1mMlByUnBUUHZRY1poZWlrUFZXNzFpb2tNRzVOQjhOMXhJTlp0Qk40c016?=
 =?utf-8?B?aUJhY2s2NVF5WlRoSTJLM3FiQzdRU3JBZFNvUktPY012dzZORXlnZjlvaFpS?=
 =?utf-8?B?cWJPdlJNTW0wT1VzOUtzZFNVWlIyYXFveWRnSlgvbnFMdFVMKzg3WlVTRlFk?=
 =?utf-8?B?V2l3TmxZbERMQVlMQmpLQmZhMC9UWDZHd1F6UDhNUmxNLzM0TGE2dGhNR29Y?=
 =?utf-8?B?VE9nWDdFL3FqSDRGZTNtNzR2Z2w3dnhDTnkra0VCUFY1RXJvRTlXWW0rTi8r?=
 =?utf-8?B?Y2pSVVduUmJEVTdPYWhJVUFrQkNyOVpDdk5VNkJRZVpwTGdZbFFJNlcrdWF2?=
 =?utf-8?B?bVpBQ1N1RzdwenMyTHc0RDRnQTRraHVTT05yOEFqZTJwZUlNYjNkYytHK3JC?=
 =?utf-8?B?WGxOZ3I4WEs5akprWW9mZVUwZDZucS9sOFlBNU1oK3VvaHg2d05qMzBqdUhs?=
 =?utf-8?B?SXdYNTByeExCQmRRL0VoQXF0UE5jNnN2S1JITUdJOG5PZU05RDk3U3Q3RXdr?=
 =?utf-8?B?YkhJV0htSktKM1I5SGliVXBWd0pDYkkzZlVYRVgyZmVNOTBJNFhYVHI4QVBX?=
 =?utf-8?B?Zi8ycitiSjFJdFFYaWZJdXl5YmpQbTdPL3ZVcmY1Rk1kaWIxOWpFV3lXaHg0?=
 =?utf-8?B?eGxCem9BNUw2dmI4d2JhL2cvTldVZTRRTDN2bzhZMmpxeUtFUTNSRHBQcGFD?=
 =?utf-8?B?RUZ4TzFVc25yNEU2WElLWmVoSVNUQU9KYkZGaS9qTzdyaU5XYjJlVkpubUFJ?=
 =?utf-8?B?M3Y5NTkvK1lKRzlkUnMra2RHWkw3VXZwaG9hM1kxZUs0TU50aGYrR0xRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUNHblZ5VWlqTTJpMUQ3TTFMeTNuRllZeFZhVHppQW0rS3hZVUxNRDhkS2wv?=
 =?utf-8?B?TDJzMk96WkRHaVJVczBjT3VHcC9BRU81ZWJoQWJTeHlERXY1b2tKR2JpOTRn?=
 =?utf-8?B?ek5YOEtCelhJeEtDalFjeVhuVFBnUkh0WUM2R3dIdTEvRThKQXdyUTNTNmJu?=
 =?utf-8?B?V0Z1V1V5TldjaHlZempZOU5SZ3h4WVVpeldNUTVGdkhjVE1RU01UTVdWN25q?=
 =?utf-8?B?ZTM4S3k4OHJtakJlenRHTy9hN3Z4bjZLVEFGbFJ0THZ5L2EzQ1BadHllcnRD?=
 =?utf-8?B?Q2hWOGFpT1hGUzMxdkxtYjM3bml0RUcrWXpjMS9YanpUeWlUeWt0YXFyQmVO?=
 =?utf-8?B?MnU1V05rVG9sNzdiTE1uaHlMSExTYzFlT2twd2MzWjJOMUJwUHhnenV6Z1VQ?=
 =?utf-8?B?cXhTamlNNjA5U3ZZaUp5c1V1aCs3NGlJaGVvdWp0ZnlnOUxhRnFOY0NobFR4?=
 =?utf-8?B?dStNZFdpdTNidURFSjFrbTdvVlJDYUlmMUhGOHRCSWF6cVBFS2d0SDZoYUYy?=
 =?utf-8?B?MFZIMU5icXlQQjA4QUE0SE9COGNxVGJuMWtwUFZEODh1V0RXTCtwS1pyeVov?=
 =?utf-8?B?TjFCcFMyK051aHgwSThibE1GZ09BNW9Gbjk2RmtJd3RFQjNncTRTUkkrUXNv?=
 =?utf-8?B?R2dFYmFiL0ZTbnVIWEF5NU40eE1rd3dyMEJoeHRqc3kxd21Eb3hGNUJzcEty?=
 =?utf-8?B?aTBIU2lRQ1RTOERFczM2VTlsVUpxazVsZGs1SGdwMHNyUmpkMTBaTkFxdXRI?=
 =?utf-8?B?cGY3dExXcmVGRkZkUXBjNnd3THVMQXdMYUhEREMzWHZ0S3lUUGJGQTFTaHpI?=
 =?utf-8?B?Q3FhTGpnc1gxZHZZTkpUZGpkOFl4eVppMGNOTGx3Tzc2ekw5K251QldnUk9I?=
 =?utf-8?B?NUw2VEdyU29BRnpvZnIzNk03OXhOeVdxUGhZS09DVDRzSGtZd3JOVUc4dVUw?=
 =?utf-8?B?Z0w0b2hGVVB6bGprVGdFOGsvTHBnejZxVUpTUFZYaVBDN3ozRW45bEUrcEp2?=
 =?utf-8?B?bEJJUSsycXRsSGt2ZVNXYTJtbTI4ZlM2T2I5c2lwaG5BRTZheDZ0MitZY3lJ?=
 =?utf-8?B?Z2MwcGdWR1czY0c0QjVXN3pJdUM3c0YyQnIwV1VjUTd4ZGJ6dUtrNTd2K3F1?=
 =?utf-8?B?Tk1nckxNV3FGeXJiLzV0cFZicFg0cXpMRXR3VEdEOFR4T1cydXczM3VGa0RY?=
 =?utf-8?B?WjhnRnJiMmZ2RlpUYVlIamhvUnNwcVVidTdzVFVYSnBpVnVRNThjZzN4VkNa?=
 =?utf-8?B?OG1OUC9DVGRaQkFQOWg3TmVxclk4VXhDeWN1OU5nckcwbFg3V2RNdXRGY2F0?=
 =?utf-8?B?a28vUFVyR25iS25jbHdxcVRNdnZKaWdKcWZ2Q3dZbldidGF4MnovSEZPMkhP?=
 =?utf-8?B?Vzk0UlZXckZGWXF6UG1yWENwZTk1WVlCbmtOeGNkNzJNL3VVenBtZ2dRdmlj?=
 =?utf-8?B?VXNFL2lWZGdENzhWK09kQ1dhOGRSVC83R1QzQitYVHk4N0pXa1FaMEtuSHFY?=
 =?utf-8?B?TklibUxwSjd0ZkI0WUNKckRoVkxIRkZKMEhxQWRWQ3NIYlNObWJMVEdKU1pP?=
 =?utf-8?B?alU1b0pqT2h4YjNzNVc5NjBwck1hUHFyZTVRbHFlTVJaNWFBSnpYZzl6Mk9O?=
 =?utf-8?B?V0JxSUtPeEV2SXFldnltMmJFMjlreDdlbUp2RmRFR0NOUHB3S0hPUUpPZjZr?=
 =?utf-8?B?NGE3LzgzRDYwUUVqQy9aVnQ5S1V4bHh2TmNDaEo3RUloSS9wVG9RM2pHakdC?=
 =?utf-8?B?SkVyZHcyZWY3SDFER1hTUlhiUENGelF3c3A0RUh1aDhiU1BGT3dRdWs3L3Ri?=
 =?utf-8?B?YmF5Vm9Gbk1jcHVmN2lkcVJ0N3pHdWIzUzZLc2U5eWNUMG1KSXNkTSt2RU5M?=
 =?utf-8?B?U2tzNllnZUlKOVplKzR6YXBxM0U1c1pQNE4xeDhNSWVyVzJvTDYwaSs2L3dl?=
 =?utf-8?B?WHpkWUhWWldlWmE4NnVXd1hzTWZwTjB3TktvT3U3Z2kwYnAxV1lpeDZXRnZp?=
 =?utf-8?B?aUJUdy94aHRmU2llZDVmd051Z1dtb2hId0s0d05CTXM0NDNoWUtiR3VzRUhQ?=
 =?utf-8?B?eHNMV3NDWkVLYURobnE1S3ZPNng4enVCU28zMWovaUZHaERNR001a2tVK3Yw?=
 =?utf-8?Q?vmTMzJ47RPwTYPYZ04l6I9lmh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4927e9-37e3-46a6-e517-08dc7353c74c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 13:51:24.4143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJiZQ5XvgRS9YLhEoWubCyyet9ZWcwPhOyqgpogj+zr8PT8oJB0HReUKFA/Z/GoUaNcbtu4/UET1puu1VZYgjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303
Received-SPF: softfail client-ip=2a01:111:f403:2416::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 06/05/2024 12:20, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> Let the callers do the error reporting. Add documentation while at it.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>
>   Changes in v5:
>
>   - Replaced error_setg() by error_setg_errno() in
>     vfio_devices_query_dirty_bitmap() and vfio_legacy_query_dirty_bitmap()
>   - ':' -> '-' in vfio_iommu_map_dirty_notify()
>
>   include/hw/vfio/vfio-common.h         |  4 +-
>   include/hw/vfio/vfio-container-base.h | 17 +++++++-
>   hw/vfio/common.c                      | 59 ++++++++++++++++++---------
>   hw/vfio/container-base.c              |  5 ++-
>   hw/vfio/container.c                   | 14 ++++---
>   5 files changed, 68 insertions(+), 31 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 46f88493634b5634a9c14a5caa33a463fbf2c50d..68911d36676667352e94a97895828aff4b194b57 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -274,9 +274,9 @@ bool
>   vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
>   int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                       VFIOBitmap *vbmap, hwaddr iova,
> -                                    hwaddr size);
> +                                    hwaddr size, Error **errp);

Nit: while at it, can we fix the line wrap here?

>   int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
> -                          uint64_t size, ram_addr_t ram_addr);
> +                          uint64_t size, ram_addr_t ram_addr, Error **errp);
>
>   /* Returns 0 on success, or a negative errno. */
>   int vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 326ceea52a2030eec9dad289a9845866c4a8c090..48c92e186231c2c2b548abed08800faff3f430a7 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -85,7 +85,7 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>                                              bool start, Error **errp);
>   int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                         VFIOBitmap *vbmap,
> -                                      hwaddr iova, hwaddr size);
> +                                      hwaddr iova, hwaddr size, Error **errp);

Nit: while at it, can we fix the line wrap here?

>
>   void vfio_container_init(VFIOContainerBase *bcontainer,
>                            VFIOAddressSpace *space,
> @@ -138,9 +138,22 @@ struct VFIOIOMMUClass {
>        */
>       int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
>                                      bool start, Error **errp);
> +    /**
> +     * @query_dirty_bitmap
> +     *
> +     * Get list of dirty pages from container

s/list/bitmap?

> +     *
> +     * @bcontainer: #VFIOContainerBase from which to get dirty pages
> +     * @vbmap: #VFIOBitmap internal bitmap structure
> +     * @iova: iova base address
> +     * @size: size of iova range
> +     * @errp: pointer to Error*, to store an error if it happens.
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>       int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
>                                 VFIOBitmap *vbmap,
> -                              hwaddr iova, hwaddr size);
> +                              hwaddr iova, hwaddr size, Error **errp);
>       /* PCI specific */
>       int (*pci_hot_reset)(VFIODevice *vbasedev, bool single);
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index da748563eb33843e93631a5240759964f33162f2..c3d82a9d6e434e33f361e4b96157bf912d5c3a2f 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1141,7 +1141,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
>
>   int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                       VFIOBitmap *vbmap, hwaddr iova,
> -                                    hwaddr size)
> +                                    hwaddr size, Error **errp)

Nit: while at it, can we fix the line wrap here?

>   {
>       VFIODevice *vbasedev;
>       int ret;
> @@ -1150,10 +1150,10 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>           ret = vfio_device_dma_logging_report(vbasedev, iova, size,
>                                                vbmap->bitmap);
>           if (ret) {
> -            error_report("%s: Failed to get DMA logging report, iova: "
> -                         "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx
> -                         ", err: %d (%s)",
> -                         vbasedev->name, iova, size, ret, strerror(-ret));
> +            error_setg_errno(errp, -ret,
> +                             "%s: Failed to get DMA logging report, iova: "
> +                             "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx,
> +                             vbasedev->name, iova, size);
>
>               return ret;
>           }
> @@ -1163,7 +1163,7 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>   }
>
>   int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
> -                          uint64_t size, ram_addr_t ram_addr)
> +                          uint64_t size, ram_addr_t ram_addr, Error **errp)
>   {
>       bool all_device_dirty_tracking =
>           vfio_devices_all_device_dirty_tracking(bcontainer);
> @@ -1180,13 +1180,17 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>
>       ret = vfio_bitmap_alloc(&vbmap, size);
>       if (ret) {
> +        error_setg_errno(errp, -ret,
> +                         "Failed to allocate dirty tracking bitmap");
>           return ret;
>       }
>
>       if (all_device_dirty_tracking) {
> -        ret = vfio_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size);
> +        ret = vfio_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
> +                                              errp);
>       } else {
> -        ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova, size);
> +        ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
> +                                                errp);
>       }
>
>       if (ret) {
> @@ -1234,12 +1238,13 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       }
>
>       ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
> -                                translated_addr);
> +                                translated_addr, &local_err);
>       if (ret) {
> -        error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
> -                     "0x%"HWADDR_PRIx") = %d (%s)",
> -                     bcontainer, iova, iotlb->addr_mask + 1, ret,
> -                     strerror(-ret));
> +        error_prepend(&local_err,
> +                      "vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
> +                      "0x%"HWADDR_PRIx") failed - ", bcontainer, iova,
> +                      iotlb->addr_mask + 1);
> +        error_report_err(local_err);
>       }
>
>   out_lock:
> @@ -1259,12 +1264,19 @@ static int vfio_ram_discard_get_dirty_bitmap(MemoryRegionSection *section,
>       const ram_addr_t ram_addr = memory_region_get_ram_addr(section->mr) +
>                                   section->offset_within_region;
>       VFIORamDiscardListener *vrdl = opaque;
> +    Error *local_err = NULL;
> +    int ret;
>
>       /*
>        * Sync the whole mapped region (spanning multiple individual mappings)
>        * in one go.
>        */
> -    return vfio_get_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr);
> +    ret = vfio_get_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr,
> +                                &local_err);
> +    if (ret) {
> +        error_report_err(local_err);
> +    }
> +    return ret;
>   }
>
>   static int
> @@ -1296,7 +1308,7 @@ vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainerBase *bcontainer,
>   }
>
>   static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
> -                                  MemoryRegionSection *section)
> +                                  MemoryRegionSection *section, Error **errp)
>   {
>       ram_addr_t ram_addr;
>
> @@ -1327,7 +1339,14 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
>           }
>           return 0;
>       } else if (memory_region_has_ram_discard_manager(section->mr)) {
> -        return vfio_sync_ram_discard_listener_dirty_bitmap(bcontainer, section);
> +        int ret;
> +
> +        ret = vfio_sync_ram_discard_listener_dirty_bitmap(bcontainer, section);
> +        if (ret) {
> +            error_setg(errp,
> +                       "Failed to sync dirty bitmap with RAM discard listener");
> +            return ret;
> +        }
>       }
>
>       ram_addr = memory_region_get_ram_addr(section->mr) +
> @@ -1335,7 +1354,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
>
>       return vfio_get_dirty_bitmap(bcontainer,
>                      REAL_HOST_PAGE_ALIGN(section->offset_within_address_space),
> -                   int128_get64(section->size), ram_addr);
> +                                 int128_get64(section->size), ram_addr, errp);
>   }
>
>   static void vfio_listener_log_sync(MemoryListener *listener,
> @@ -1344,16 +1363,16 @@ static void vfio_listener_log_sync(MemoryListener *listener,
>       VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>                                                    listener);
>       int ret;
> +    Error *local_err = NULL;
>
>       if (vfio_listener_skipped_section(section)) {
>           return;
>       }
>
>       if (vfio_devices_all_dirty_tracking(bcontainer)) {
> -        ret = vfio_sync_dirty_bitmap(bcontainer, section);
> +        ret = vfio_sync_dirty_bitmap(bcontainer, section, &local_err);
>           if (ret) {
> -            error_report("vfio: Failed to sync dirty bitmap, err: %d (%s)", ret,
> -                         strerror(-ret));
> +            error_report_err(local_err);
>               vfio_set_migration_error(ret);
>           }
>       }
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 7c0764121d24b02b6c4e66e368d7dff78a6d65aa..8db59881873c3b1edee81104b966af737e5fa6f6 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -65,10 +65,11 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>
>   int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                         VFIOBitmap *vbmap,
> -                                      hwaddr iova, hwaddr size)
> +                                      hwaddr iova, hwaddr size, Error **errp)

Nit: while at it, can we fix the line wrap here?

Thanks.

>   {
>       g_assert(bcontainer->ops->query_dirty_bitmap);
> -    return bcontainer->ops->query_dirty_bitmap(bcontainer, vbmap, iova, size);
> +    return bcontainer->ops->query_dirty_bitmap(bcontainer, vbmap, iova, size,
> +                                               errp);
>   }
>
>   void vfio_container_init(VFIOContainerBase *bcontainer, VFIOAddressSpace *space,
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index c35221fbe7dc5453050f97cd186fc958e24f28f7..e00db6546c652c61a352f8e4cd65b212ecfb65bc 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -130,6 +130,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>       };
>       bool need_dirty_sync = false;
>       int ret;
> +    Error *local_err = NULL;
>
>       if (iotlb && vfio_devices_all_running_and_mig_active(bcontainer)) {
>           if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
> @@ -165,8 +166,9 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>
>       if (need_dirty_sync) {
>           ret = vfio_get_dirty_bitmap(bcontainer, iova, size,
> -                                    iotlb->translated_addr);
> +                                    iotlb->translated_addr, &local_err);
>           if (ret) {
> +            error_report_err(local_err);
>               return ret;
>           }
>       }
> @@ -236,7 +238,8 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
>
>   static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                             VFIOBitmap *vbmap,
> -                                          hwaddr iova, hwaddr size)
> +                                          hwaddr iova, hwaddr size,
> +                                          Error **errp)
>   {
>       const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>                                                     bcontainer);
> @@ -264,9 +267,10 @@ static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>       ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, dbitmap);
>       if (ret) {
>           ret = -errno;
> -        error_report("Failed to get dirty bitmap for iova: 0x%"PRIx64
> -                " size: 0x%"PRIx64" err: %d", (uint64_t)range->iova,
> -                (uint64_t)range->size, errno);
> +        error_setg_errno(errp, errno,
> +                         "Failed to get dirty bitmap for iova: 0x%"PRIx64
> +                         " size: 0x%"PRIx64, (uint64_t)range->iova,
> +                         (uint64_t)range->size);
>       }
>
>       g_free(dbitmap);
> --
> 2.45.0
>

