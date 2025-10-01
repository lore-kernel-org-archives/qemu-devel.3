Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AE0CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 06:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3qax-0003FD-4M; Wed, 01 Oct 2025 02:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1v3qae-0003Al-Ct
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 02:45:29 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1v3qaW-0003QI-AK
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 02:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1759301120; x=1790837120;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=xL2BQawjhV+MtDQ/pcS0jQTgF8a9wACR1i3unRSBQXw=;
 b=tSvsnudMytrlXPvZQe6UndYvmysDKv3amboJju2xk9+CNY/wbIOLjpmZ
 ypBChQGZt7JKxLi3hAP6ocxXx6NCWQsujXJvZ3+RnzUJkOZ0VHfkL1mEy
 M7xHXKc+wsgkbMdv/jT+Y2cZZ4zb6a1iHKiNbEju+lVBCudBLuHiNHYtf
 vH+3CCZFP4Vnyv1PXVFomgyrejvr7bx8vi2gCbM1X9WqiVbwlJWbwBkZr
 byOY8k9Bec1Lup7IFsRthz3dugDDJq1xZE0Tcrs8zfFfM3E92zGQVE1fA
 D9PqIJUNN4iBbRP+gULsyLwzsEJt9jRIbOuiSQ6wNq9y1wQyiHjYVexLr Q==;
X-CSE-ConnectionGUID: VX3sCXBuTwiMSpT8aKgQiQ==
X-CSE-MsgGUID: HKhQi7pcTRGmbvuF5dZLFw==
X-IronPort-AV: E=Sophos;i="6.18,306,1751234400"; d="scan'208";a="43443685"
X-MGA-submission: =?us-ascii?q?MDGvGBRXq7XkiaoLKKu58yx40Jys0aMest1B+F?=
 =?us-ascii?q?8pUTAzJH32oTUQOgkfYxPnAlLAkYwmjez2BBBt/OMcfOQ6i5Yb5Qb1Wk?=
 =?us-ascii?q?CIYLUsnznwcUV8TovUF+zgrpiIYNqMGR4IXWQ6Wc0K25O817gFdUgDuG?=
 =?us-ascii?q?eEQrhB11Lb3YP2FR6NEwqg4w=3D=3D?=
Received: from mail-westeuropeazon11011048.outbound.protection.outlook.com
 (HELO AS8PR04CU009.outbound.protection.outlook.com) ([52.101.70.48])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 01 Oct 2025 08:45:12 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhhiXmO73F7f2hfRl3VU7aIAOuaJ/hnX/F9KsJLtS5oerRi1DVr+49Pttc+ajI4bawsEWwhA20fVpyL/kEAUW0eQHNF7QDEGmbEH/jFfxfhoNNTnNfxXS0CxGSkxeONXH80KNXMXRfTATbQ2vjnRQMNz+Z2+IQXx1MIMmLp4K38AMuj9gCNhPgzQlQ4wifH1w85oKdhjHMEJrQkuLVlwXooovYRXo3ohO+QHLXo6X2yZ4PpvvtdK+PdWCon92cTip2SOv4GNaR6d3Z+GU0jM0vzp4cZIAvVfeQ0lkzf3ELR0WcMHNjOXsR3xvDBzc2oq7AuHlBgEbmXE563UgEV5rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xL2BQawjhV+MtDQ/pcS0jQTgF8a9wACR1i3unRSBQXw=;
 b=ul90YiTMRuUUyWeMOURy0Kw16YOBIlfJU4DfL9t/qD92LI/Xn358ol+gRs/lgtKHW4lmIJSxkT+OiaOvlTMNVwwP8bP0/EdZ/qBI76Bpzw+I0R7FC4RnrmizW+9FgW+ap5MLZwcV+6veNx8FvTxpGanYNnkkWm3paTGYWI/eR9szFdpSerSrxYynUUporf53ibcTX1lm17EO2dr1FIial3KyJjySrBKENWPty9KCUxpJvSOVHgzp1Xf6aoAIPGVFWJUNhFj80ULxm1sNbQ84p4fwzby0aE0QNmZ6u/EUoPcRF1xndHuKxd6cHeb7hUCj/7kNrRuFwBybTIDnbL4uhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xL2BQawjhV+MtDQ/pcS0jQTgF8a9wACR1i3unRSBQXw=;
 b=I5piytaMPh4YSPV4T9RCsjaMy3YpIMjpxwXrwE2zxNsFHhdhxxmpTgeUe6338+VnVsVhbT7dL01DuqG8YODULyYpjAT9p83ScLgie1FEfjpx8GFO1vWVkfdEZfOQOKKEBiveplfyvkZH5Ym+gThzC9FqK8mF2wSsQTuc703oIP4Q5uAJ1YYFJT0kCx6CzV4+VGXqVOAEPW2PvrFKWgAqsH9wWu+hLxx2G3cFgRTYE9YMyTwXaJpP/uQRlav9UUVFFuau7UGtgrudSCnrigNsG0YFxbc9pokQwdfZ0yFyYTmLVwaR1VlZHpj2JiLOBZiH52FzQSrJAtXZGnVexP2w9w==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PA4PR07MB7182.eurprd07.prod.outlook.com (2603:10a6:102:fc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 06:45:10 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%5]) with mapi id 15.20.9160.014; Wed, 1 Oct 2025
 06:45:10 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 3/3] pci: Fix wrong parameter passing to
 pci_device_get_iommu_bus_devfn()
Thread-Topic: [PATCH v2 3/3] pci: Fix wrong parameter passing to
 pci_device_get_iommu_bus_devfn()
Thread-Index: AQHcMPMoeRgQPN6eLkedf4ydsrvAu7Ss28QA
Date: Wed, 1 Oct 2025 06:45:10 +0000
Message-ID: <bee8c8fa1be343a09040cc876067756fcfc9f47e.camel@eviden.com>
References: <20250929034206.439266-1-zhenzhong.duan@intel.com>
 <20250929034206.439266-4-zhenzhong.duan@intel.com>
In-Reply-To: <20250929034206.439266-4-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PA4PR07MB7182:EE_
x-ms-office365-filtering-correlation-id: fc13141f-a408-4faf-9532-08de00b6115a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?QUZuQXJST3hrUE14UDlXblFxZXFuRlBzeXZ5dllHRyt0VVdJa2JGMS9PVXhP?=
 =?utf-8?B?MmpPRnFyeE5ESm9naVJsWlpUZzVzY3pnZm51SEwwL1lsSXB6UUtFaEMwUmFF?=
 =?utf-8?B?MWdzOEJLT3JyRDloS1JUVzdpTE8vZXEyNHZ3bGl0cUZFRmdZSVF6RlF3OWVm?=
 =?utf-8?B?WmxseEJndm02V3lkbUp0UU8zclB2KythbThjU2NRakQ4dHhQeEJ5UEVJbGhz?=
 =?utf-8?B?VGlISlRUYlZGWXVFdlRudUVPY0o5ZjlxOTQ3d09GbW1JbnhXUnVYYk9XVndJ?=
 =?utf-8?B?bnBPdnI1WmFZQ2pGd0ZTOHZzUEtBeTJMeU13VTA2c3pLcWRNR09CR2poaUxs?=
 =?utf-8?B?QWVUMk1YREZ1WnVqNUErRmpIQWRTWFVBSVA2M1l5ZzFoZ1ZnVVNDQkhKaHhI?=
 =?utf-8?B?cG9naFhzaGFKQlA2YmVpaklVWFNodDVGdm9XV056ZlNMM29pcTNSTGlFRG1x?=
 =?utf-8?B?OUpub0ZtOEFpc0w4dGpDWDBYYnIwNGtIY2kvbnhrVmtxOGNReGxDWXptMFd1?=
 =?utf-8?B?VHZkMlVualdQdVRWTVZnWmlnNHBFeXgxU3pEdlRHOWxnaUhJUVRSbUFybHZB?=
 =?utf-8?B?ZXN2SGp3U0xCNHdSRURPRkE0N3hVbUxZZzNRa0sxWXBFRE16RjZQenJCNHlC?=
 =?utf-8?B?WWpndnV0YVgzeTB4VEozSkpRV0VoaDVXMnkrK0tuOXRpNElqK3NrbzhkM3Nn?=
 =?utf-8?B?OTk0eEZEcDNodnBBT3BPU3RVU0kwNHNIc1lRdnJGVkd6cjljNHJsYVFKVm5G?=
 =?utf-8?B?OURvTFlFd3FzN094RCtDRC9XK1hucmxkbldwM0FRZjFYMTlOK2gzSTZTM0NT?=
 =?utf-8?B?MmJSbTlVaXkzR3FrL2hUclZXdmxZZTVJVEVZTzNWRHcwS1ZabmJpS3FXcndh?=
 =?utf-8?B?bkZDdDdEdHdMRE5qNnhlajZ0N2lvM0ZGUVcxOTc4RlZPK2tSM3JOM3pPN2pF?=
 =?utf-8?B?bW9yUGpoa3FkRjJzcnBpYm9IYjZNM3RhcHV5eWlhMU9NdmxKaG1OQW03OWNE?=
 =?utf-8?B?WE1Wek56Mzdqc1J5aU5sTHU3cVdBWTdDRDd5S2JyOS9SRUJMVjVmRVE1Qnhx?=
 =?utf-8?B?aVo2V3E3MzVXUjd4TUVqa1d3RTlhK2FGQ1RHTXlINzlDUEVLTlJXMStoNGJH?=
 =?utf-8?B?dnJzS0ZuN3hTdnk0MG15bGtiZjBhY3VFNXJod3VRN3ArTUo5UU8zc2FhaStu?=
 =?utf-8?B?ZzlEOUlrLzlYSWdNMzFWb1J0ckhUQ3BnU1JrT0s0clNnZXJ0VVVmNE1LV01X?=
 =?utf-8?B?dHkvWUZMVHl2RHdjNUx0bWg0VVQ5K2JVUTV2VDVObURBRCswSmRWVjAzR0k4?=
 =?utf-8?B?TDg5UU90MDc2SlhYU1NCUUwwbDdlbnlQekVjUUZmN3lrbXRJbHJ3b3Ayd1VN?=
 =?utf-8?B?dVpCRVVkM1RpTExkRDNPeS8rY2Z2TlQwVWRYZnZJcjJyY0JCZ1YybUNQbTl6?=
 =?utf-8?B?cHJxWVFDOHc4WTE2TW83bE1CcWtFMjNWV2s0Wm5PTW55YWZSSFMxcnZNejN2?=
 =?utf-8?B?WHdtYjZRdzRJUEpJdjJya3RlSW0xUWdoWmt5cklBZE5hdHI2NmdyRXoweStv?=
 =?utf-8?B?OVRreUcyNmZKQ1UvSVh5TVRXbUtMUS9oU3h3TzI1SDUzRmVUdDVZL005VHQy?=
 =?utf-8?B?WHZtNzhncS9icXc2V3U3VGd1ZmNFdGFmZHh6WGFYcGpXM3FwaU8xRE5KQSs1?=
 =?utf-8?B?QVBYUFBoMFpVeXhab3BNRlcydGtOZmtGejNoQW1SVEdPdUhmaWVQbVBySStV?=
 =?utf-8?B?ZXBKUnowWEJjTlRTbkZmcW9OKzI5eU1ja2FwTlR3bnJvb2R1K3MrVjRPUDEz?=
 =?utf-8?B?QisyVXRFbjNrc0hDVUNHSjk2dllCd1FtSGNBSGpvQ1FhZjMvVDNQWVFuV0k2?=
 =?utf-8?B?Q0k2cXdpSXVTRldoM0NIZXBsZTVzYVMzb3d1UUVCRC9UbzRmaDI2RzlEWHBB?=
 =?utf-8?B?TnR5N0ZVTVpDT3M2M25nT2pjMkV4Q2c1UlVNNE5YWE1sb1NmVUFzaTBLUlp2?=
 =?utf-8?B?bGJLOHB2MWpPYXk1djIzVjk0cHluTkNES0xzdkhmRU9abjNJOUwxOGV3T3Aw?=
 =?utf-8?Q?BHYLgy?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0dKZW4xUFpqWWorUy9uRlFoMnR1dVVqbFU5Tk02a0RSdGRicmRGL1B1bzVL?=
 =?utf-8?B?QzE2Vm5RMU5GZDdLUEJBY1o5a0ZGVWQvVzhsOU5qV08zdmN4ckk2Vi9wU045?=
 =?utf-8?B?OGNTbHJhczAzdzhrMnh1R2gyYkMvYnFzdi9PajJYYko0MzhlZFZOcDg5anJr?=
 =?utf-8?B?bW9VZGkyOXI0VmtkR0FtdWVSRGVYWitxdlNwVUlHa24vVGV1WTc3WmNQTVdu?=
 =?utf-8?B?aExuRlROTUpLbVE4SDBOOGdmcmUvbWJ2eHNMdFJYMnpZMTV4ZmhyZDUzZCs0?=
 =?utf-8?B?bmRtTWFUQnZzQlplS3hJMTluM2pkYmZCUkoycjNUdnFzODhReFNhdG03aEt2?=
 =?utf-8?B?OHNxWmR2ajN2L0w4Smt3dHhOSHhhQ0VCWWhKMkVqQUpVeitld0FVY0FYTWVU?=
 =?utf-8?B?MlhGYUcrODNFU2o3Q2VMQVZNQUNsUDJqVFRWbGpHTUQ5UHJVdjdxQy96VVNP?=
 =?utf-8?B?VDh0K2dmT1IzSmlwVnhGRnBQT0kxSWVTd2VZenJFWkVUbk1xUlpsZTdiMnBy?=
 =?utf-8?B?eFc5bG1Mc0I5ODZrdysrYWpHc0xNdFdRNHh5OEJmMThpcnZHRWRsdU12STA1?=
 =?utf-8?B?ZnYzaDAxRXp2aWFKV3h2cXlGUVArMmxmeVljQlpKSEFtdUtjcjNlRmMwaHlw?=
 =?utf-8?B?L09LdzlCYVVyVWhuajJXc21CUnpyaDdHcHI3dUdBRmlKSmZYalZURFBKbDZI?=
 =?utf-8?B?K2hDRFROOXdtYnNMMWNNV3hNV3lRVFRFb1Q1dU9LVEliWWZpMDVZd1RWK2U1?=
 =?utf-8?B?QXFFRFNTUVNaRkd5enBPWVdUeEYveUE2WFNFMDdHUm5xQncwbW1aUzZjWU53?=
 =?utf-8?B?MWU0NXhjckp0dUw0UFk5THZTa0Q2dTIzL0JaU3ZWdnlOOFlyc0FZaTV4U0hX?=
 =?utf-8?B?dUlsTzRwTzZWVCtraEtPWGwzdEhib0t5OVQrV2tHMXFqYnY5MHUvQjllTENE?=
 =?utf-8?B?Z3JaNWhGQVFEcmJ6NHFYKzdYenFWTlNpS0xhbUVLN0hocWYrNXBLZ0pUZVh1?=
 =?utf-8?B?YzZEaEY4c0p5SDlRSlFMTnlrckdZVys0Q3BFVHJuUGlVNTBzdUJJcVZ5eVF0?=
 =?utf-8?B?aGUzUFdjMEZzYzgycmhuaDRXdVR5cTdrQ1c3c2lCSXJ1eUR5SGE0MGdxQ1F0?=
 =?utf-8?B?cUJvUWl2SVFoMDJpWlNTdHdYY0ZPODE1dHQrSzBmZDRFQ1lNNms1YmF6MkJH?=
 =?utf-8?B?dDdPMEMwOUpucEFkNXpGUnBKQTY2OElBSGFDQ0twVVd4em5Od0dvYm1sRzBD?=
 =?utf-8?B?MmJiQnhuK0RrK1VFaUxmWEZ1azJxVGxaelFnWGJ0YjBGNDBlY3JMb05OWEdw?=
 =?utf-8?B?eldYdnhYczdpQjBDNkpzS1FiaG5Hakczbkk5endReUo1WCs0N09DdUFpYWpk?=
 =?utf-8?B?bjZWbjM1Wnp6VU9iK09Fb2kySyswNU8zckQ4UlNHdXpaMTFKbFVHOWFpdVJS?=
 =?utf-8?B?aDBPOWZIVFl5M3lNQ3ptMUIyeXBVYmhoaWVxRE1VVHdUMnhUb3c5bWZpbU5W?=
 =?utf-8?B?VjVTT3dtMjl5SXNLU3cxdnVPak0yc2ZxWTlBczNvVkNDRmdUYWdyclY1bzBS?=
 =?utf-8?B?TW1WOUQyWmZCcXFCd0RrbjlvSGc3Q3lJSm5qaGhBTGtiSmZRZDRxVmpoUHly?=
 =?utf-8?B?NE4vS2pFZlZoSFYySmVJbTRSbFdZelVaRmxvU1JIMmpTYWNQeHg0Wk5DOFl6?=
 =?utf-8?B?Q0IzLy9tUGNnWWVvWlh6Y3NKVTVtMUxCZXcyNmNrOUNwUWs5RVgwWHBIR1Az?=
 =?utf-8?B?cmg0NjdUdklnR05rSVN2eEgramdXbC9UUnFTcmtOaHdubFpSS2x4cDJCQWlI?=
 =?utf-8?B?QnhaMXpDKzMvSzkydFR6QlRqY0QyZGY2dVh5bXR5Y1E5V2wyOFhoZnFDemdI?=
 =?utf-8?B?NzFLOEh3eXpybHNjSGtiYlA1ZEFyQWxrTUU4S1dFYnlleTlLSGhac2NTYnBn?=
 =?utf-8?B?WjFwOHpwNVgvbmxWdEJKWWw4V0RON3hteXNDcVN2aWZuQTI2bDdQWk5vTWM1?=
 =?utf-8?B?T0swc3QvS2RLeXBlSnBQYzJKZG9FMG5YN210Q3ZiL0hmT1pLSENkQ3JXYWhU?=
 =?utf-8?B?OHlzWVRCdXEvRDVldzlydks3NnZ1cW9VVC91d3piOVZhYnVhU255VzR0Uksy?=
 =?utf-8?B?MVo0SUlocEpoYWZvVzdyM0dwci80bnF2c0lGd1pMZ1Z3b1VTWDRDSXdYeGIv?=
 =?utf-8?Q?Opgebxpe4jOa+HdVmbDr3XM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61EBF06D52C7AE4180338D8C90383A82@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc13141f-a408-4faf-9532-08de00b6115a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 06:45:10.8082 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gMZBBvCjvVFStstUkc/V/FB1znAT/EZj5j2P7ZmXVVJGCyFHhkzNLwbbOqCABNUcodY3EFrwekyTgg8UiWnol8k71N2ov4GrDzWY9qYQMc56ifcK8+IJtffs91f/ANiZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7182
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

SGkgWmhlbnpob25nCgpVaCwgZ29vZCBjYXRjaCBPLm8KClJldmlld2VkLWJ5OiBDbMOpbWVudCBN
YXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4KCk9uIFN1biwg
MjAyNS0wOS0yOCBhdCAyMzo0MiAtMDQwMCwgWmhlbnpob25nIER1YW4gd3JvdGU6Cj4gVGhlIDJu
ZCBwYXJhbWV0ZXIgb2YgcGNpX2RldmljZV9nZXRfaW9tbXVfYnVzX2RldmZuKCkgYWJvdXQgcm9v
dCBQQ0lCdXMgIAo+IGJhY2tlZCBieSBhbiBJT01NVSBmb3IgdGhlIFBDSSBkZXZpY2UsIHRoZSAz
cmQgaXMgYWJvdXQgYWxpYXNlZCBQQ0lCdXMgIAo+IG9mIHRoZSBQQ0kgZGV2aWNlLgo+IAo+IE1l
YW53aGlsZSB0aGUgM3JkIGFuZCA0dGggcGFyYW1ldGVycyBhcmUgb3B0aW9uYWwsIHBhc3MgTlVM
TCBpZiB0aGV5ICAKPiBhcmUgbm90IG5lZWRlZC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhv
bmcgRHVhbiA8W3poZW56aG9uZy5kdWFuQGludGVsLmNvbV0obWFpbHRvOnpoZW56aG9uZy5kdWFu
QGludGVsLmNvbSk+ICAKPiAtLS0gIAo+IMKgaHcvcGNpL3BjaS5jIHwgMTggKysrKysrKystLS0t
LS0tLS0tICAKPiDCoDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9u
cygtKQo+IAo+IGRpZmYgLS1naXQgYS9ody9wY2kvcGNpLmMgYi9ody9wY2kvcGNpLmMgIAo+IGlu
ZGV4IGMzZGY5ZDY2NTYuLmQ1ZWQ4OWFhYjcgMTAwNjQ0ICAKPiAtLS0gYS9ody9wY2kvcGNpLmMg
IAo+ICsrKyBiL2h3L3BjaS9wY2kuYyAgCj4gQEAgLTI5NjcsNyArMjk2Nyw3IEBAIGludCBwY2lf
aW9tbXVfaW5pdF9pb3RsYl9ub3RpZmllcihQQ0lEZXZpY2UgKmRldiwgSU9NTVVOb3RpZmllciAq
biwgIAo+IMKgwqDCoMKgIFBDSUJ1cyAqaW9tbXVfYnVzOyAgCj4gwqDCoMKgwqAgaW50IGRldmZu
OyAgCj4gwqAgIAo+IC3CoMKgwqAgcGNpX2RldmljZV9nZXRfaW9tbXVfYnVzX2RldmZuKGRldiwg
JmJ1cywgJmlvbW11X2J1cywgJmRldmZuKTsgIAo+ICvCoMKgwqAgcGNpX2RldmljZV9nZXRfaW9t
bXVfYnVzX2RldmZuKGRldiwgJmlvbW11X2J1cywgJmJ1cywgJmRldmZuKTsgIAo+IMKgwqDCoMKg
IGlmIChpb21tdV9idXMgJiYgaW9tbXVfYnVzLT5pb21tdV9vcHMtPmluaXRfaW90bGJfbm90aWZp
ZXIpIHsgIAo+IMKgwqDCoMKgwqDCoMKgwqAgaW9tbXVfYnVzLT5pb21tdV9vcHMtPmluaXRfaW90
bGJfbm90aWZpZXIoYnVzLCBpb21tdV9idXMtPmlvbW11X29wYXF1ZSwgIAo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2Zm4sIG4sIGZuLCBvcGFxdWUpOyAg
Cj4gQEAgLTMwMjUsNyArMzAyNSw3IEBAIGludCBwY2lfcHJpX3JlcXVlc3RfcGFnZShQQ0lEZXZp
Y2UgKmRldiwgdWludDMyX3QgcGFzaWQsIGJvb2wgcHJpdl9yZXEsICAKPiDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiAtRVBFUk07ICAKPiDCoMKgwqDCoCB9ICAKPiDCoCAgCj4gLcKgwqDCoCBwY2lf
ZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4oZGV2LCAmYnVzLCAmaW9tbXVfYnVzLCAmZGV2Zm4p
OyAgCj4gK8KgwqDCoCBwY2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4oZGV2LCAmaW9tbXVf
YnVzLCAmYnVzLCAmZGV2Zm4pOyAgCj4gwqDCoMKgwqAgaWYgKGlvbW11X2J1cyAmJiBpb21tdV9i
dXMtPmlvbW11X29wcy0+cHJpX3JlcXVlc3RfcGFnZSkgeyAgCj4gwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gaW9tbXVfYnVzLT5pb21tdV9vcHMtPnByaV9yZXF1ZXN0X3BhZ2UoYnVzLCAgCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpb21tdV9idXMt
PmlvbW11X29wYXF1ZSwgIAo+IEBAIC0zMDQ5LDcgKzMwNDksNyBAQCBpbnQgcGNpX3ByaV9yZWdp
c3Rlcl9ub3RpZmllcihQQ0lEZXZpY2UgKmRldiwgdWludDMyX3QgcGFzaWQsICAKPiDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiAtRVBFUk07ICAKPiDCoMKgwqDCoCB9ICAKPiDCoCAgCj4gLcKgwqDC
oCBwY2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4oZGV2LCAmYnVzLCAmaW9tbXVfYnVzLCAm
ZGV2Zm4pOyAgCj4gK8KgwqDCoCBwY2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4oZGV2LCAm
aW9tbXVfYnVzLCAmYnVzLCAmZGV2Zm4pOyAgCj4gwqDCoMKgwqAgaWYgKGlvbW11X2J1cyAmJiBp
b21tdV9idXMtPmlvbW11X29wcy0+cHJpX3JlZ2lzdGVyX25vdGlmaWVyKSB7ICAKPiDCoMKgwqDC
oMKgwqDCoMKgIGlvbW11X2J1cy0+aW9tbXVfb3BzLT5wcmlfcmVnaXN0ZXJfbm90aWZpZXIoYnVz
LCAgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW9t
bXVfYnVzLT5pb21tdV9vcGFxdWUsICAKPiBAQCAtMzA2Niw3ICszMDY2LDcgQEAgdm9pZCBwY2lf
cHJpX3VucmVnaXN0ZXJfbm90aWZpZXIoUENJRGV2aWNlICpkZXYsIHVpbnQzMl90IHBhc2lkKSAg
Cj4gwqDCoMKgwqAgUENJQnVzICppb21tdV9idXM7ICAKPiDCoMKgwqDCoCBpbnQgZGV2Zm47ICAK
PiDCoCAgCj4gLcKgwqDCoCBwY2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4oZGV2LCAmYnVz
LCAmaW9tbXVfYnVzLCAmZGV2Zm4pOyAgCj4gK8KgwqDCoCBwY2lfZGV2aWNlX2dldF9pb21tdV9i
dXNfZGV2Zm4oZGV2LCAmaW9tbXVfYnVzLCAmYnVzLCAmZGV2Zm4pOyAgCj4gwqDCoMKgwqAgaWYg
KGlvbW11X2J1cyAmJiBpb21tdV9idXMtPmlvbW11X29wcy0+cHJpX3VucmVnaXN0ZXJfbm90aWZp
ZXIpIHsgIAo+IMKgwqDCoMKgwqDCoMKgwqAgaW9tbXVfYnVzLT5pb21tdV9vcHMtPnByaV91bnJl
Z2lzdGVyX25vdGlmaWVyKGJ1cywgIAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpb21tdV9idXMtPmlvbW11X29wYXF1ZSwgIAo+IEBAIC0zMDk4
LDcgKzMwOTgsNyBAQCBzc2l6ZV90IHBjaV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbihQQ0lEZXZp
Y2UgKmRldiwgdWludDMyX3QgcGFzaWQsICAKPiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRVBF
Uk07ICAKPiDCoMKgwqDCoCB9ICAKPiDCoCAgCj4gLcKgwqDCoCBwY2lfZGV2aWNlX2dldF9pb21t
dV9idXNfZGV2Zm4oZGV2LCAmYnVzLCAmaW9tbXVfYnVzLCAmZGV2Zm4pOyAgCj4gK8KgwqDCoCBw
Y2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4oZGV2LCAmaW9tbXVfYnVzLCAmYnVzLCAmZGV2
Zm4pOyAgCj4gwqDCoMKgwqAgaWYgKGlvbW11X2J1cyAmJiBpb21tdV9idXMtPmlvbW11X29wcy0+
YXRzX3JlcXVlc3RfdHJhbnNsYXRpb24pIHsgIAo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGlv
bW11X2J1cy0+aW9tbXVfb3BzLT5hdHNfcmVxdWVzdF90cmFuc2xhdGlvbihidXMsICAKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlvbW11X2J1cy0+
aW9tbXVfb3BhcXVlLCAgCj4gQEAgLTMxMjIsNyArMzEyMiw3IEBAIGludCBwY2lfaW9tbXVfcmVn
aXN0ZXJfaW90bGJfbm90aWZpZXIoUENJRGV2aWNlICpkZXYsIHVpbnQzMl90IHBhc2lkLCAgCj4g
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVQRVJNOyAgCj4gwqDCoMKgwqAgfSAgCj4gwqAgIAo+
IC3CoMKgwqAgcGNpX2RldmljZV9nZXRfaW9tbXVfYnVzX2RldmZuKGRldiwgJmJ1cywgJmlvbW11
X2J1cywgJmRldmZuKTsgIAo+ICvCoMKgwqAgcGNpX2RldmljZV9nZXRfaW9tbXVfYnVzX2RldmZu
KGRldiwgJmlvbW11X2J1cywgJmJ1cywgJmRldmZuKTsgIAo+IMKgwqDCoMKgIGlmIChpb21tdV9i
dXMgJiYgaW9tbXVfYnVzLT5pb21tdV9vcHMtPnJlZ2lzdGVyX2lvdGxiX25vdGlmaWVyKSB7ICAK
PiDCoMKgwqDCoMKgwqDCoMKgIGlvbW11X2J1cy0+aW9tbXVfb3BzLT5yZWdpc3Rlcl9pb3RsYl9u
b3RpZmllcihidXMsICAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpb21tdV9idXMt
PmlvbW11X29wYXF1ZSwgZGV2Zm4sICAKPiBAQCAtMzE0NCw3ICszMTQ0LDcgQEAgaW50IHBjaV9p
b21tdV91bnJlZ2lzdGVyX2lvdGxiX25vdGlmaWVyKFBDSURldmljZSAqZGV2LCB1aW50MzJfdCBw
YXNpZCwgIAo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FUEVSTTsgIAo+IMKgwqDCoMKgIH0g
IAo+IMKgICAKPiAtwqDCoMKgIHBjaV9kZXZpY2VfZ2V0X2lvbW11X2J1c19kZXZmbihkZXYsICZi
dXMsICZpb21tdV9idXMsICZkZXZmbik7ICAKPiArwqDCoMKgIHBjaV9kZXZpY2VfZ2V0X2lvbW11
X2J1c19kZXZmbihkZXYsICZpb21tdV9idXMsICZidXMsICZkZXZmbik7ICAKPiDCoMKgwqDCoCBp
ZiAoaW9tbXVfYnVzICYmIGlvbW11X2J1cy0+aW9tbXVfb3BzLT51bnJlZ2lzdGVyX2lvdGxiX25v
dGlmaWVyKSB7ICAKPiDCoMKgwqDCoMKgwqDCoMKgIGlvbW11X2J1cy0+aW9tbXVfb3BzLT51bnJl
Z2lzdGVyX2lvdGxiX25vdGlmaWVyKGJ1cywgIAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW9tbXVfYnVzLT5pb21tdV9vcGFxdWUsICAK
PiBAQCAtMzE1OCwxMSArMzE1OCw5IEBAIGludCBwY2lfaW9tbXVfdW5yZWdpc3Rlcl9pb3RsYl9u
b3RpZmllcihQQ0lEZXZpY2UgKmRldiwgdWludDMyX3QgcGFzaWQsICAKPiDCoGludCBwY2lfaW9t
bXVfZ2V0X2lvdGxiX2luZm8oUENJRGV2aWNlICpkZXYsIHVpbnQ4X3QgKmFkZHJfd2lkdGgsICAK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHVpbnQzMl90ICptaW5fcGFnZV9zaXplKSAgCj4gwqB7ICAKPiAtwqDCoMKgIFBDSUJ1cyAq
YnVzOyAgCj4gwqDCoMKgwqAgUENJQnVzICppb21tdV9idXM7ICAKPiAtwqDCoMKgIGludCBkZXZm
bjsgIAo+IMKgICAKPiAtwqDCoMKgIHBjaV9kZXZpY2VfZ2V0X2lvbW11X2J1c19kZXZmbihkZXYs
ICZidXMsICZpb21tdV9idXMsICZkZXZmbik7ICAKPiArwqDCoMKgIHBjaV9kZXZpY2VfZ2V0X2lv
bW11X2J1c19kZXZmbihkZXYsICZpb21tdV9idXMsIE5VTEwsIE5VTEwpOyAgCj4gwqDCoMKgwqAg
aWYgKGlvbW11X2J1cyAmJiBpb21tdV9idXMtPmlvbW11X29wcy0+Z2V0X2lvdGxiX2luZm8pIHsg
IAo+IMKgwqDCoMKgwqDCoMKgwqAgaW9tbXVfYnVzLT5pb21tdV9vcHMtPmdldF9pb3RsYl9pbmZv
KGlvbW11X2J1cy0+aW9tbXVfb3BhcXVlLCAgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGFkZHJfd2lkdGgsIG1pbl9wYWdlX3NpemUpOwo=

