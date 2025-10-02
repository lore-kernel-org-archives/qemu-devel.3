Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CEFCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 07:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Dvf-0002o8-Sx; Thu, 02 Oct 2025 03:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v4DvO-0002Ut-Pj; Thu, 02 Oct 2025 03:40:28 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v4DvD-0000e5-3Y; Thu, 02 Oct 2025 03:40:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCNbd6QsQpaHkoRWOZwDOKU0eYpRDjIDzfmeONx193AWYygXjCC8HwiKYxB9k+SPUQpE+JhElQmV0mjowy/iHneNItwgq8HwFWpPPxWJtMBYK2sjOAxMqzW9oYBPVLqSYo4KC8YwJ/PARr0tVI/rHzC3U51iSsnwI9LxaSZY1aVc2VkWVUuglnUtuvLfST52D0bWcMAuDnA2CJbXSoCLlVCxA4EejpdCTN21XVY/VWlteu4I/WGdFoqRibBrRkfCW8j9+6Bg8+Gz1qYynN7P7VitPzVQhYWBEMMtYLbChHEa7JzCL7JBB+FYxV7uRNhKUsxy0CCDRGHtX0JyxgteIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Au6l8E/c3FdKxaTTJ9laVqFRd5l2MPxo8khlq1sKXQ=;
 b=aJhLwL47A2oFGCO+Nv9wdzggZeeVxcmg72SebcTdYNJPMZj6nn7vTP9FwTwV/dq3F/VXeF07VoXhaeJTcsd5BO7Wlz+FdamLVau8Y3e4fat0qBlZpxNv0kUfleB351P4z73h/9Snsf9b71yISuJaQdCGP0YXmW0bdvx/sBxgwwXQlqnfmFsRUQDJFJ5gt9yiu8liYFsTp6NJLtBtOD0HPhaN3WxktHQpY/eWOtlAVuiqCO3IKNMUmRUSCLMBPzBC0OVlCH1Fe2d2SioclSEQ6F/pXUowS7gHskf58J/owiUzT6ugWOAF8sz8iLuaVq9tFggsVo6wBL2x4yUnvYCoqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Au6l8E/c3FdKxaTTJ9laVqFRd5l2MPxo8khlq1sKXQ=;
 b=Q7eZEMb0owHZXzYZRw7rGYTMPVIdKb7X5o3Da8L3V4W7/K1BwQ2Nmbj9ryf/zu/LhxIFAX5wKmU2ewFKMEQjT/bOC/Cv4MLMNSLsQfDB+BBQqMLtyT+YDjAocsUaXmf2n+i7Ajjj91okk74d7PK3GvXV1cvRnFm6cNIGUXu9MJd1IejTH9/YH4qOIcD1+ubvCLwAHTTcsT1KRQ7IbxgwjHH18WDuXNjKNnXD6zIVvEL9u94zBmDeGJ+jrNsCdQNshkl7deY/r5Zt6SJHuhiBVHxLSYOj7ku0pLJ4GeYezHT7Q7jCR/GZ5dJKGRFVkusJGDctA57bHcSnt1B7S0cw5w==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 07:39:41 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 07:39:41 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 15/27] acpi/gpex: Fix PCI Express Slot Information
 function 0 returned value
Thread-Topic: [PATCH v4 15/27] acpi/gpex: Fix PCI Express Slot Information
 function 0 returned value
Thread-Index: AQHcMtMvUnkOqXC0F0ywUc7Zcjm+DrSueXVQ
Date: Thu, 2 Oct 2025 07:39:41 +0000
Message-ID: <CH3PR12MB75487EF7D053F7DBF65D75C8ABE7A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-16-skolothumtho@nvidia.com>
 <20251001135902.00004abd@huawei.com>
In-Reply-To: <20251001135902.00004abd@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|LV2PR12MB5726:EE_
x-ms-office365-filtering-correlation-id: 158e6967-7cd3-43fb-bcba-08de0186d8fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?rKKRgFw0O5NuKmy8xqGNGRZkn4v86+5lzoAfFd64W4+nETfyxIee5nuQpwwu?=
 =?us-ascii?Q?Au5GpTDRz7R+CISapx/ww7L1t7OXn9+JFOTpTugv1Wr1SUepqnDVT0x2V9kt?=
 =?us-ascii?Q?bwNMReg8FyMRVB5GBT4EYIvtBTymfiACc70lGvJG3lrCOWSOOrv9blFndUx9?=
 =?us-ascii?Q?VZJ/farUOxk2MWZP/H1VWE5l5o5JmNP9J1qPcloy8Ib8osZpCjNS2BCDO4er?=
 =?us-ascii?Q?Din+O3ty3hcXxcRmn96q+7dov7OjqT0uQn09GpDZGrILDx1hTX3TENB+4zoc?=
 =?us-ascii?Q?AH1+7bz2zWtLEi8PpuptUBMrbU6cPt3S30dKTK/rLcVKK+ieDIThcuuePBEh?=
 =?us-ascii?Q?qUydYE4UT5anrvpRqv7SnbPfRrAZYTj1uUjSuSzDE1MdEjNwmrxrlTEUmS6O?=
 =?us-ascii?Q?41RMMhJgzgPRVm17xP3t2hsJuJfZ6gXBb0ao+KsjNP/dzn6JWborYdw2s/i0?=
 =?us-ascii?Q?POwW+JJU8F7pwLcHWOL2/W7ydgThRHdXvXR+ZihO3E9PRtqRKK3PmYu/zBXg?=
 =?us-ascii?Q?tNTwBH/7kfVvd0BeG0E+VysvHmO3tbPGgF8dxZd3DrIunNGnpfm1YGHDDDuz?=
 =?us-ascii?Q?5/d48a3SEgYtwq5zqiQBDdQr5M4KwsJ4CXwgNG+bj00/ZEwDM01u+I/8g0D5?=
 =?us-ascii?Q?/c/OTHcDOy4XjZRNmPpCLsu7/T/49UPxI4DPvgtr9u0sLq/Iy9zY5bMY0Ffr?=
 =?us-ascii?Q?tHFLl1RF+V+SvVgddr6o67w7/rOUDLhRIWiQfFnwVGKS5MR1lCxSqDX2LMCa?=
 =?us-ascii?Q?8BTmefK9IMaxhxc6ki1mE/L5bAfbYidK4WMU80td9SMHNoK5jCH7TffqWm+5?=
 =?us-ascii?Q?9vCZei1bOhV8Sot2BHBsD1AaWS6E1yvGphAUX8cjDyZdvsAr2e+P/SVQycnr?=
 =?us-ascii?Q?+xByVpRo11ykknJ1OzqBElFTJW/50B7QNtP2SMPFOoiOG68G4xY/UMfNJnsl?=
 =?us-ascii?Q?I9RZIu64hxF+XpedXV5qNiERDirGmAob55OBvveOiiebP3ESHZFMUX2A25n/?=
 =?us-ascii?Q?rfVs4Kz58sH5qpnRLt4LNmcPYmvBzX6aNhrrbuDKoC1QhEruZV3SeigWPE7u?=
 =?us-ascii?Q?7iVbvjKiGOaTQyhG4/1sdzXYLEToQW1SGZRLoRkUPowX1qmcsc/tCk+LalWQ?=
 =?us-ascii?Q?ZlqjkcLU9DsDLXg/woj6zYogp1TMyd3hKM+UZbNReTUyLnD7yYL8+wvAmwEl?=
 =?us-ascii?Q?RMaRNu+wVXut2ezYthoz7NCIuhHXGZxZMl9EAi/IX4YCtYJFCwOEOmduLv5s?=
 =?us-ascii?Q?IEnOIVTa18nNVvunSXhpmoOj8qe/KRGvpAUkEwRt+/QwrqLQjeyjI+QbxAp7?=
 =?us-ascii?Q?ECqFPt8N1Rr+QF+5lztcr9iPhY08zHNMV88uKpr7kAbTjMaub/B+ymru6DI/?=
 =?us-ascii?Q?krqO4VUzZ4WLLBo+q4G+JnwXPXfUBrpvcJAJmOpueNwzRMYj+++Pk+afB4xJ?=
 =?us-ascii?Q?xZQe1dSK3PXASinh/OLVEZMowgDrxQRzsYQwc+oeaJlpj7h7K3zwFXqOr7K5?=
 =?us-ascii?Q?4UYQ43hAEb/HfvmHp2zHTzO0R/JDbpXgIXsD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OnVzpTdLqfMb+i/zjydZqUhdl+/3Ux7OUwKn8zo/nq7HAI4ACh2Dc49JDsfr?=
 =?us-ascii?Q?kzhOPlTS7CV3yW3DVafXeernAP0h6pFwg91OkgwjucA/BR3FroEB61YRM6JY?=
 =?us-ascii?Q?jKELZLWMcL81RgdhR7qQlUZOYZgGBTZ69iY/kXZ/sq5mQW0BwU2hxHiFGmEk?=
 =?us-ascii?Q?tbGeBCfAPEuAGDMdaD30XuDOVTij5QwxCXhFTyWTj2MtAdNNvmDyTXQchD2e?=
 =?us-ascii?Q?ZDDvejQLNZkfIiFmHT1sVVglG+831HcdJS8KjLjY3RK6X2l2AMXkWR7MK8vK?=
 =?us-ascii?Q?u6HAZz2m1ZJWuaxp99hqLXVedItrtJwd0w4w5nNlTGCkM4STIXoLVSGvTuan?=
 =?us-ascii?Q?Y67VjUQimzy95pJksJcIG5YE8oQ679dvmxaPafrmaE9RrASmcKfRhz3755OY?=
 =?us-ascii?Q?v4kOJ8i1buZyTWe1JDaRVZw/WSTWzay0VyMXZaz0kx4NiUaPcOJKe0uMmHzz?=
 =?us-ascii?Q?WGnt0vAnYij+7Is2zATBLRQ6Qnvi6blnr5xPbEDd6kHghy98WDl/w6+Cg7+j?=
 =?us-ascii?Q?m5LW5ObiMPOQ337UxtJR+GBnxi9RxS3xbHr8hVQeyR259TtJO6N3TYsmQaDY?=
 =?us-ascii?Q?TfejLVR54FF9EBIh6Aw8rm2oU30wVX/xNxCxjV1QE6kWKkOvRFy+7wVLqsFs?=
 =?us-ascii?Q?XoEpZOLPRvrn6TrvtTsgWdIguEbDaji6ihssoIjO+AmCdMBXF7XBJuUoVak5?=
 =?us-ascii?Q?6TAAS/kT8IeguHbyBnbnlSHEnivm12IVJzuoKYbINBuqKD7AUMWdKnvZFuUH?=
 =?us-ascii?Q?KSIM2jVzRmXeTCeqkE+pzm+3JJsHXWf74TgL5iAxNCZlJ3C1V5gBIAMVskoH?=
 =?us-ascii?Q?nJOipBl5kn+qi4ytino/OKXmobJLFY0OrRqUo4URqdRwklXVyExemtZUcSsH?=
 =?us-ascii?Q?JdXNMG219yYStMW9NByXt6ItLnXccBNZnQhcgB+pwqoIZV3LSzuHHQ+szf0q?=
 =?us-ascii?Q?WRBiegZVHF2w+IwoblEq12O8auwTtf0F9SnOXeapYAS3b23enYmyYAV70Clt?=
 =?us-ascii?Q?oD2QsR4GkmfYg8R2/zDeQpGbCUpjWmYnnCFkR748JO3lQMG6kpoJuRgRTDhs?=
 =?us-ascii?Q?v9HN2EEYeYw1rmnTxjjbqJcLjL5ts2FgJ8OX10Me6Kunoa6YSnwfUlO5anqx?=
 =?us-ascii?Q?bPjSIPmxDDUvbVyCtMTfT4MEfYBNaLyDhOGpqoiXoMrLYp9YsIWDt2sCcCVb?=
 =?us-ascii?Q?x65gDHriGjWSeYhfDrSykR1g/CoNkW3v2N6KTuOPWK+Pwxg+/bmeZoQ6kbFC?=
 =?us-ascii?Q?OHW688/SjVqDwfIVz05mUr+xEHsasav8u3nN7N/q/5bCfSUNMvkLS+Zfn7pg?=
 =?us-ascii?Q?xv2k5p+cYgVDjp44OHzx0uxEDM5jKqcxCg4mF0jHwfUAEAVBSLUplyQJ/WRF?=
 =?us-ascii?Q?dGx1ElAzUTTnbabrFCRjGCu5I7oejhprg9VDV//ZFYwG0420BD3rPNaG3+4t?=
 =?us-ascii?Q?K7zCAm3lmLdtlZexZ3mQDy/gLOZBDiVJnyBIKJIII6UZljqJg8XZFGu7pexM?=
 =?us-ascii?Q?DUSyqpqSbSOsc65CiddthLzzEX+FVcrkBEV4pTqNNIEEnhgNmfrrb5uJJi1j?=
 =?us-ascii?Q?ezB3vk2YXV3drpNwruwY1G5A6jx4suJjZPkRRH6X?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158e6967-7cd3-43fb-bcba-08de0186d8fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 07:39:41.0279 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xeBkNl30dpLcufuetHiqMayvtgXIYLtrcPX20WR8zrkVuReeP0TaS8Itd6umWOdP2KEV1+KbzRbQM3MiR6d/rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



> -----Original Message-----
> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> Sent: 01 October 2025 13:59
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; ddutile@redhat.com;
> berrange@redhat.com; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; zhangfei.gao@linaro.org;
> zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> shameerkolothum@gmail.com
> Subject: Re: [PATCH v4 15/27] acpi/gpex: Fix PCI Express Slot Information
> function 0 returned value
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Mon, 29 Sep 2025 14:36:31 +0100
> Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>=20
> > From: Eric Auger <eric.auger@redhat.com>
> >
> > At the moment we do not support other function than function 0. So
> according
> > to ACPI spec "_DSM (Device Specific Method)" description, bit 0 should
> rather
> > be 0, meaning no other function is supported than function 0.
> >
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Given description, why not yank this to the front and get it upstreamed
> quicker.
> Also, a fixes tag seems appropriate?
>=20
> Doesn't this show up in some of the tables tests?

Possibly. I will double check that.

>=20
> Please include relevant chunk of AML as well as qemu AML generation code
> isn't
> exactly easy to check against the spec.  Probably +CC at least Michael Ts=
rikin
> on next version of this patch.

Ok.

Thanks,
Shameer

=20
> J
>=20
> > ---
> >  hw/pci-host/gpex-acpi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> > index 952a0ace19..4587baeb78 100644
> > --- a/hw/pci-host/gpex-acpi.c
> > +++ b/hw/pci-host/gpex-acpi.c
> > @@ -64,7 +64,7 @@ static Aml *build_pci_host_bridge_dsm_method(void)
> >      UUID =3D aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D");
> >      ifctx =3D aml_if(aml_equal(aml_arg(0), UUID));
> >      ifctx1 =3D aml_if(aml_equal(aml_arg(2), aml_int(0)));
> > -    uint8_t byte_list[1] =3D {1};
> > +    uint8_t byte_list[1] =3D {0};
> >      buf =3D aml_buffer(1, byte_list);
> >      aml_append(ifctx1, aml_return(buf));
> >      aml_append(ifctx, ifctx1);


