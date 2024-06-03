Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B96C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0jq-0006qj-QM; Mon, 03 Jun 2024 02:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jn-0006oq-LI
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:00:09 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0ji-00071B-DE
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717394402; x=1748930402;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=4eokjYkt7nIttPX3M6XueVLBousvJ2ZkPb0CEz6nEXc=;
 b=sa7h+GYSzQcpRashY1+231sKn3MT9hqdcq4lcrWYtvzEv0PNLznlyE8E
 NxVk0GIiz1Eh3s3d13j3ylqvvelFaDZeEljLYWzbjlpyrUbMHT9VcmHgU
 15aoicW2K3p4N7/btplpiNnW1Mz72L+LxcTowOO/tJOI6eTVn9tepoR2g
 3dzVvyNWkbzUjigHB1lWrJsPlVd/T4PE4Wz7LnlQ7DP4FxcNV6M9q7Q/1
 TyMiWoq4nM+FVGFTyr4q0sqHECPnHxqUquG/dDimkdXLeZ08Klio3bvlT
 pP6k8nH2skDg7qhRY4+3ESYMRblAKUJU6hh4GGKySCAFF/EPIQKu+8WUJ Q==;
X-IronPort-AV: E=Sophos;i="6.08,210,1712613600"; d="scan'208";a="13815890"
X-MGA-submission: =?us-ascii?q?MDG+EJthOwb2PohCC+um530FvvMiF5mgbkxk0f?=
 =?us-ascii?q?ie/XrQhZQNUGCCzLKwh4OYzC8jYf9+xCa+anXeeSsQ51sVHBX10Fk+yp?=
 =?us-ascii?q?trDLVmjmm0kjjovVJFEkQn3MS2pdv2i0Q3rM+GqGh3EQEWmCEqRgr38d?=
 =?us-ascii?q?oNGQxHZjHp/co65zyneX4kuA=3D=3D?=
Received: from mail-vi1eur02lp2041.outbound.protection.outlook.com (HELO
 EUR02-VI1-obe.outbound.protection.outlook.com) ([104.47.11.41])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 07:59:55 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKDbkDko1A2bzBomWKQl7LyAIOjXyV4zI9weQ4Q2MoMVuVW7JBsklgEHelF3wUXu6ojzHNHFNSPFHfFK/qkcn5rmhv+2OC50oOhbaFMYPif63qqBydcHAxNGFL2SN8PD2iHZdimi3P6Al0CPMk62C8EYgmZ0hXdSK6Nnajuy7Lin4n/K6Prym0k72KK+65zL4aywPBbQkcW9y+P8gDp5iXj1rT9GB2Hc/gnr/Wp3rADdAXb1VTWFyBvZUe7d3ny8AsEICfJ6nsXaHwN9Ah+ut/joQr0dHE2Gh+0OzZOtlCeUIvvWC7WVQPt3PenilenQ18vPk4xEHAk1JKHXAxAOMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eokjYkt7nIttPX3M6XueVLBousvJ2ZkPb0CEz6nEXc=;
 b=baJBP7cfPGt3bM4L5sGMirw8bpR1SZYm75mGK+MXxyvt7G0nz1MeqgrzBVVQYECB3Q9fyoUwtdSPaQa2OJzV/jAgT/ffoGobPZE6bhjQuJaJRjUde5cfm+iPEFpUwNh5F4zcJwS+SSQ3D7KM3M4C+grIWRnwWBbUk9SbXaQNIasf9Azv4QeafWltBKoGZmDC+HZpNu7qxRwPwEZ3fjdcytpfbz79raVCRGOGt3N+L9EV40p1iyR+4wZv5VeHRFvjH72WF6PT4QxNgK4zinBlmZ0plD9Yl0tg+k+XHGsuL9l03yc3s+LO7WOB61Y3PWEsHHUVnuC231vOGQ7k62itbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eokjYkt7nIttPX3M6XueVLBousvJ2ZkPb0CEz6nEXc=;
 b=ItikILNt/r0S+WZ+q+S/SSoH3Ot+16jj0XcvflnEwVWVHYvCBgE7g6oKdms68Xbd6kQNdSye9XIDkXBvNOmigdqfoogdvNw0k5HVEkLAFX4iVxWlk7FJEGOfYflHuTNGIgZJBUFpbomIgAdp2ikJ63gXZ+iux5+AaFF7BwE0AB54OgL4p3oGgCutTdzzbNtAYH1i6LFq8d/Vv6AYbPHbFz0Rb09BAxersmH3MQfI4oYbMIZLgZa/SqFGBLHgkIJWffylr2d+x0MVJvXDrtuCAIyGyaxwAELytDE+03tIQqGyfHtunrZMahriouuwGslcThdxx9bIH1JB8eLDNtQ2Zw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM8PR07MB8192.eurprd07.prod.outlook.com (2603:10a6:20b:323::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 05:59:53 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 05:59:53 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 20/22] pci: add a pci-level API for ATS
Thread-Topic: [PATCH ats_vtd v5 20/22] pci: add a pci-level API for ATS
Thread-Index: AQHatXtBWfzK4X3MW0619Cac8t7GQQ==
Date: Mon, 3 Jun 2024 05:59:53 +0000
Message-ID: <20240603055917.18735-21-clement.mathieu--drif@eviden.com>
References: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM8PR07MB8192:EE_
x-ms-office365-filtering-correlation-id: dc3b9bbd-e9a1-4fb1-addd-08dc8392638d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?M1cvY3ZRRFdhSi9VODFiaDNpSldLbmlybHIya0ZCbHRvTHZJMHN3eGlLbVdI?=
 =?utf-8?B?Qy85K1RFUWhFbktXMDVKUlZLbGN5YTd6NXZLTS9CT2Q4RG9IU3ZJVlFIcVV0?=
 =?utf-8?B?S25JRm44SG1wU2hvSWg5MTBsd0dEYk5NMVlxQU9waGh2OGRzNG9XcXlsaXBW?=
 =?utf-8?B?THllNmluQjY0bFFwNTMxYkdzem5RZVFwNFk3dHdpSzdRL3Y0bU5sTVNYUkph?=
 =?utf-8?B?N0RzMUNoZlU1bFl3UzB0Mnpqdkk3alFndlFrVm1zQ2U5OWxnYktURlRWZHpS?=
 =?utf-8?B?MHBiQURBWmdkSDVncDhuV0Q3aW9lQjAvM09IYTN0cTdicmQxVDhaRTZtR3Yz?=
 =?utf-8?B?RGh0ZEoyR1hMVUNRSGw0RG1HUXNva09MbFpHNHA0Z3A2c2FsblB0SHBrMXF5?=
 =?utf-8?B?UnhHMHFVUzRNZ3RFZEFQTmc4V3Rjc1RvSWU2MndpUjlzeUF2K0h4MzJtOXZI?=
 =?utf-8?B?VTJWbk5MSVlRMTc1ZEEzbXB3VlI2cVhDQldweW00VzlwZUd0dVBTYmNYK21B?=
 =?utf-8?B?VU1pbHVPaVIwNENhUDNUTUhUdDlEU0N4MHltckRGaTRPVlJSNEJNMmZudzZ6?=
 =?utf-8?B?MjMwRTV5N2pSay9KeTZ5eUpNd0hzcUI5RTlBbnhMbjFKdFc1VW10b21ZZFNN?=
 =?utf-8?B?cnZwRld6dzljdm1jMzAvV1l5TzZ5Ky9SNnJOSm5IK04vc1FtTllpc2ppMGF4?=
 =?utf-8?B?NjNxK01xN3I5SFNudjZhclluY3R4WjhSWi9XM2J5ZkhaZnN4VCtEeWNPSzFZ?=
 =?utf-8?B?SWNWMVNrdXgwRnYrRWhPUEFkNnlhRUdPNG5uVEM3OXBaUTJyYUhQd1BHWHdY?=
 =?utf-8?B?WEtDOEVOS1oxVFo3ZzdUMndGdFFhN3k3bWVNUWxLZVFXK3ErVndjSUxOenMw?=
 =?utf-8?B?RS84TTFEOGYzQWlTUUhQK2tnWVVJS2R1dE9lZm9vbU5qMm9tREVHUXJVbnQ3?=
 =?utf-8?B?RUZQaHZ1RGJBMzRaS0dOZi9LWTRMdG1CM1Zjdm42emsyMnVucUQwYlc1UGIy?=
 =?utf-8?B?Ulh0RnJtNGVQNjRGUTd0YkVKd1Y3dG9VbDk0azZWYjFGblBraGx6NWgyZStP?=
 =?utf-8?B?bUx3SitoNjFuQ2syU2t4OE1DWFhLcFhmSm1xZGdvalRTQ002T25qL0FSOEds?=
 =?utf-8?B?MnVkU25ESFZWMXVLQ3hFZjArLzcxSHN5clJxc1E3cXJ1ODZSMlI5ZDU4MURu?=
 =?utf-8?B?Z280TUNTVEtKZ1creGhJZ0pFdUp2dmdzYktjTm44dUVlM2VGYzZ6cEsxQWVx?=
 =?utf-8?B?UkRxMWVaVW1Ib2dFcGpNRzZ6ZFFLVTI3LzFoM29Ga2ZvRnk2ZnNwaC9tT1Bs?=
 =?utf-8?B?aWMwbHY4UGNtVktRYmU2QzJFcW5PZTBlNm1RMkpJMUh4b0hZM0ROU0JTbzlV?=
 =?utf-8?B?L3JOOTdwU29jWEJEVjJ3UW9Ta0IxQU1TREo1S2t0amtBMjhLNjQ2dGJMNWpq?=
 =?utf-8?B?endkNzRnQkRzY0p2a1hSUW10OWZRRlFjY05oblFBZTBsK0l4SlFGbUVSaDBV?=
 =?utf-8?B?M0tWcmNNbmM3WlI4WGFUZWdjeDR2L0xqaXRwQm5CMWVLWk83TWpzbDFwaE5J?=
 =?utf-8?B?Z3I5cy9MN3NYczgwQnd2MlpxQzZJNFFObWhGVnNkd2RsMlgybEkrUkFTNThx?=
 =?utf-8?B?dWRMc0ZiK0FHUCtJRVlOWE94c1dLby8wOWVqenE2V0xVNzN0K2t3bFFRWTNi?=
 =?utf-8?B?aGlYSVAxYTc0TmpUZGxQeVhhSUYvZlplVzFIS2h2alhYdlgxOVltUFVFUW5p?=
 =?utf-8?B?OHVNdDNWOUFSaGl4TXBqaU9kNjFuRWIxUjBKOTc1Z0s3dllodFlCd2ZoNWUx?=
 =?utf-8?B?WXI5QlFHaERidFZ1NURDZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RS9nTllEN2hPRGRMcEtBWURPYUpmMXpacWExYUl2UjA3WUNXQjhHckFaZ1FU?=
 =?utf-8?B?aHBmZ1JGdkJBZ2tJYlZheVZZc0JmS3hRWURac1VQODVrTjh3YkF4OFBkZk5w?=
 =?utf-8?B?QWNGa29vZkVIaUtURHVVR3EvOHVYeGMxaUdOWmp6R0FBNWRHZTBZaDYzelRp?=
 =?utf-8?B?Tk5JdkMxTGhpZTZkcWc0dll3TnE5WGFKdUZHN0oyVzdNRS8vTnR6Qk9WRVVL?=
 =?utf-8?B?M25QVkVKakYzZ1FJRExwMzFvUGhLcmRNR29WVkl5OGQwcjg2TTdRZmlOYkZD?=
 =?utf-8?B?UFlYd2xHR1EzVXBiNDFiTXR6Rld3bWRzNzZ2SEthaW9WQnl6M1ZZM25UYXox?=
 =?utf-8?B?N0tGQS9teExZZ1RaNVlEYTlTY0Rid2F3Z3ZkMW1OcjBEMUdEcjFjTWxPUmJz?=
 =?utf-8?B?U0hOcDIwSmhDWUQrODVIVDExVXdUWkZvZ25WakR5QmV3akFtZzdtWk1FeVlM?=
 =?utf-8?B?OXV1Y3gyaTlNYzdXYmhRZjAyNC80cFpNb3FEMStMbklQT2J2YmVidk8rc3pT?=
 =?utf-8?B?aWVJazhtL1YyWW9vSU83N1NEVlowaE1YUHBOd3ZZYnFxNFA0NnVqNU41Q3h4?=
 =?utf-8?B?RlVxd0RWL1RYUnhOZTJKTW0xdDVNZEVqMWNqQmo3VElmU2ZOeUVSQzhFdWJZ?=
 =?utf-8?B?bEdNd2pKWVJaTFBpZ0gyWXJTNmgyZzZOckM1UEg0bm9ZRmJNcms3cDBOT2Jq?=
 =?utf-8?B?eUhFL0JMNDQzUHpyU0pxZ2NPQlR6eUJTdDdyaWR1ejBPT08vMzA0dDVKRndK?=
 =?utf-8?B?Sk1BZUMyTlNzdGlKbDMvdGhqTWVxNDVYQlU4L3NBaGhqOUZ1U0lZci9TbGJV?=
 =?utf-8?B?MEZyb2o3RDRsaE1sQlg3UzF1Ni9LdmZtazJqS0E4NHFaSm5MSStTNE45ZlZo?=
 =?utf-8?B?SEtTZitXajhrYjRScjdSUHY4eEhtWVFrRVpVVFhwZ0VRRnJodlErRzBwR1FN?=
 =?utf-8?B?VmhrQ0ppaXJaUUd3UWF3MmVBRzZKdlhiazJaOEZHQ2RFalVSd0JuVHdZVkFx?=
 =?utf-8?B?WVo1eXdEd0VmK2NlZDU5eTVtRVhzcStuWlQwYXNhcWdYOXJpNFB1M1F1L2I3?=
 =?utf-8?B?dUxOenZLbjRDL3RDWFAvQWtMZVNhMDQ0L0lKZE1XVDZkWmtMQU5uZHFlZ3Ir?=
 =?utf-8?B?UnFYaXNleW9JVlYzTUszRC9VSU02VEI4dmxlSCt2VzgzT25mOWZkQTA4enVz?=
 =?utf-8?B?MVNlWmVaSDV2MjBocmRTSlhMenVzNXNHWjhtTDZaRm16a1dFV2NpZFl4Vk41?=
 =?utf-8?B?clJ1RmdiaVNuRXk3RUZqbjc1UlBJc3JsMEpwMW1UT0ZUK09tUXhKSkovZ1hp?=
 =?utf-8?B?SWF1N0NTcDBmZFpaODgrN24wZ0Z2cjZob1hVbjhrRjAvWFFVR0pHWUJwR3VV?=
 =?utf-8?B?bDdCRlFlR0E5SHRiT3h4Um4rRnBTYldFVklRa2RWKzY2K3J0RmFzV3JZcTJu?=
 =?utf-8?B?SUZYZVVnUE4yb3FJdUk2MThmdEhFSDBVdnJ0amorWnp4ZE9ZZTBESlB2Q2h6?=
 =?utf-8?B?ejA3eWcrWmYwRnIrd3h4VDRWaFF2eGxrS1FjdlBZQy8wTW1MeFZNeXU0TGdP?=
 =?utf-8?B?Q2tYMGlMVkRoSnkxRm81UkhxQklFT1JCVlo1bGRPWGwvUnZycDdiclBwdGE5?=
 =?utf-8?B?dXhPc3ZIbThDcVVYWXIyZHRpRFJkQjVrbnFTVTJpN2Fqek1ENlBOYXM4RlJ2?=
 =?utf-8?B?TzVOWFFjQXZCVEwyNkNhZ1NHdXNsRzlMc00ybm5BRTFYQ1I5bVh1VkwrN3Jz?=
 =?utf-8?B?OVlSdVd2Q25hNmlMcXN2dHZzOVZoVEd5eDJXa0VhQzNjUk11VmErM2ZEazdW?=
 =?utf-8?B?WnFmVVVKNGdWTzFBbXVMODVabXBIZ1ZhcU5FN0VYSWJwRG9oSkoxeUdKQnV4?=
 =?utf-8?B?VnZlS3hraFE3cmRMd3F3M0dIYzB1elZKL0UwbVUwT3M1TXBhT0RIVDdEZlQ4?=
 =?utf-8?B?SjB0UkRrM1E5eXdMQlkrdTEvWmtqcXVmTmk0YVIxa3UrZ2diRTNHNzJ4SStG?=
 =?utf-8?B?SkN3alVQNS9FN24wN1RtUFM2VWlTczgwVGU5YVlyTXg5YWxUbWxmK2R3NDl1?=
 =?utf-8?B?VGpGL3YzMllQY2FOdThCN1ZrZjFvUGcrU2pYL0ZHVWdMT0w3ZzdTelVRdXdH?=
 =?utf-8?B?NURTbjZTQXFwOWZ3T0h5M2w2UWdFbEtwTkZVZllaR09DRmtJcXlKR2FhS01z?=
 =?utf-8?Q?v9QoEBHKIDM1f+rVvGxI1WQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AD7886A24DF7B4BA0ED300DEC7558B0@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3b9bbd-e9a1-4fb1-addd-08dc8392638d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 05:59:53.7936 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Da1YmndRksTMrJicfV5wVD31Ew6SC6+u+WTRCfFyT2Msbbyq1uGfWKVEU0zP3dIKPkMb1Ag1fRQ1bI8VH5sh/gniaIYxHjF4sH2qvz0bWM1Unu7bYqp7d286gFARHxw0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8192
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNCkRldmljZXMgaW1wbGVtZW50aW5nIEFUUyBjYW4gc2VuZCB0cmFuc2xhdGlvbiBy
ZXF1ZXN0cyB1c2luZw0KcGNpX2F0c19yZXF1ZXN0X3RyYW5zbGF0aW9uX3Bhc2lkLg0KDQpUaGUg
aW52YWxpZGF0aW9uIGV2ZW50cyBhcmUgc2VudCBiYWNrIHRvIHRoZSBkZXZpY2UgdXNpbmcgdGhl
IGlvbW11DQpub3RpZmllciBtYW5hZ2VkIHdpdGggcGNpX3JlZ2lzdGVyX2lvbW11X3RsYl9ldmVu
dF9ub3RpZmllciBhbmQNCnBjaV91bnJlZ2lzdGVyX2lvbW11X3RsYl9ldmVudF9ub3RpZmllcg0K
DQpTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUt
LWRyaWZAZXZpZGVuLmNvbT4NCi0tLQ0KIGh3L3BjaS9wY2kuYyAgICAgICAgIHwgNDQgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIGluY2x1ZGUvaHcvcGNpL3BjaS5oIHwg
NTIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAyIGZpbGVz
IGNoYW5nZWQsIDk2IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2h3L3BjaS9wY2kuYyBi
L2h3L3BjaS9wY2kuYw0KaW5kZXggMGUxNGVmNGFiMi4uMTBiMDcwODEzMCAxMDA2NDQNCi0tLSBh
L2h3L3BjaS9wY2kuYw0KKysrIGIvaHcvcGNpL3BjaS5jDQpAQCAtMjgzMyw2ICsyODMzLDUwIEBA
IHZvaWQgcGNpX2RldmljZV91bnNldF9pb21tdV9kZXZpY2UoUENJRGV2aWNlICpkZXYpDQogICAg
IH0NCiB9DQogDQorc3NpemVfdCBwY2lfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb25fcGFzaWQoUENJ
RGV2aWNlICpkZXYsIHVpbnQzMl90IHBhc2lkLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGJvb2wgcHJpdl9yZXEsIGJvb2wgZXhlY19yZXEsIGh3YWRkciBhZGRy
LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVfdCBsZW5n
dGgsIGJvb2wgbm9fd3JpdGUsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgSU9NTVVUTEJFbnRyeSAqcmVzdWx0LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHNpemVfdCByZXN1bHRfbGVuZ3RoLA0KKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90ICplcnJfY291bnQpDQorew0KKyAgICBh
c3NlcnQocmVzdWx0X2xlbmd0aCk7DQorICAgIElPTU1VTWVtb3J5UmVnaW9uICppb21tdV9tciA9
IHBjaV9kZXZpY2VfaW9tbXVfbWVtb3J5X3JlZ2lvbl9wYXNpZChkZXYsDQorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcGFzaWQpOw0KKyAgICBpZiAoIWlvbW11X21yIHx8ICFwY2llX2F0c19lbmFibGVkKGRldikp
IHsNCisgICAgICAgIHJldHVybiAtRVBFUk07DQorICAgIH0NCisgICAgcmV0dXJuIG1lbW9yeV9y
ZWdpb25faW9tbXVfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb24oaW9tbXVfbXIsIHByaXZfcmVxLA0K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBl
eGVjX3JlcSwgYWRkciwgbGVuZ3RoLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBub193cml0ZSwgcmVzdWx0LA0KKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXN1bHRfbGVuZ3RoLA0K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBl
cnJfY291bnQpOw0KK30NCisNCitpbnQgcGNpX3JlZ2lzdGVyX2lvbW11X3RsYl9ldmVudF9ub3Rp
ZmllcihQQ0lEZXZpY2UgKmRldiwgdWludDMyX3QgcGFzaWQsDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVOb3RpZmllciAqbikNCit7DQorICAgIElPTU1V
TWVtb3J5UmVnaW9uICppb21tdV9tciA9IHBjaV9kZXZpY2VfaW9tbXVfbWVtb3J5X3JlZ2lvbl9w
YXNpZChkZXYsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcGFzaWQpOw0KKyAgICBpZiAoIWlvbW11X21yKSB7
DQorICAgICAgICByZXR1cm4gLUVQRVJNOw0KKyAgICB9DQorICAgIHJldHVybiBtZW1vcnlfcmVn
aW9uX3JlZ2lzdGVyX2lvbW11X25vdGlmaWVyKE1FTU9SWV9SRUdJT04oaW9tbXVfbXIpLCBuLA0K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmZXJyb3Jf
ZmF0YWwpOw0KK30NCisNCitpbnQgcGNpX3VucmVnaXN0ZXJfaW9tbXVfdGxiX2V2ZW50X25vdGlm
aWVyKFBDSURldmljZSAqZGV2LCB1aW50MzJfdCBwYXNpZCwNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVU5vdGlmaWVyICpuKQ0KK3sNCisgICAgSU9N
TVVNZW1vcnlSZWdpb24gKmlvbW11X21yID0gcGNpX2RldmljZV9pb21tdV9tZW1vcnlfcmVnaW9u
X3Bhc2lkKGRldiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwYXNpZCk7DQorICAgIGlmICghaW9tbXVfbXIp
IHsNCisgICAgICAgIHJldHVybiAtRVBFUk07DQorICAgIH0NCisgICAgbWVtb3J5X3JlZ2lvbl91
bnJlZ2lzdGVyX2lvbW11X25vdGlmaWVyKE1FTU9SWV9SRUdJT04oaW9tbXVfbXIpLCBuKTsNCisg
ICAgcmV0dXJuIDA7DQorfQ0KKw0KIHZvaWQgcGNpX3NldHVwX2lvbW11KFBDSUJ1cyAqYnVzLCBj
b25zdCBQQ0lJT01NVU9wcyAqb3BzLCB2b2lkICpvcGFxdWUpDQogew0KICAgICAvKg0KZGlmZiAt
LWdpdCBhL2luY2x1ZGUvaHcvcGNpL3BjaS5oIGIvaW5jbHVkZS9ody9wY2kvcGNpLmgNCmluZGV4
IDIxNDc5ODE0MjMuLjhhZGJhNmFmOTcgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2h3L3BjaS9wY2ku
aA0KKysrIGIvaW5jbHVkZS9ody9wY2kvcGNpLmgNCkBAIC00NzMsNiArNDczLDU4IEBAIGJvb2wg
cGNpX2lvbW11X2luaXRfaW90bGJfbm90aWZpZXIoUENJRGV2aWNlICpkZXYsIHVpbnQzMl90IHBh
c2lkLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVOb3RpZmllciAq
biwgSU9NTVVOb3RpZnkgZm4sDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2
b2lkKiBvcGFxdWUpOw0KIA0KKy8qKg0KKyAqIHBjaV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbl9w
YXNpZDogcGVyZm9ybSBhbiBBVFMgcmVxdWVzdA0KKyAqDQorICogUmV0dXJuIHRoZSBudW1iZXIg
b2YgdHJhbnNsYXRpb25zIHN0b3JlZCBpbiBAcmVzdWx0IGluIGNhc2Ugb2Ygc3VjY2VzcywNCisg
KiBhIG5lZ2F0aXZlIGVycm9yIGNvZGUgb3RoZXJ3aXNlLg0KKyAqIC1FTk9NRU0gaXMgcmV0dXJu
ZWQgd2hlbiB0aGUgcmVzdWx0IGJ1ZmZlciBpcyBub3QgbGFyZ2UgZW5vdWdoIHRvIHN0b3JlDQor
ICogYWxsIHRoZSB0cmFuc2xhdGlvbnMNCisgKg0KKyAqIEBkZXY6IHRoZSBBVFMtY2FwYWJsZSBQ
Q0kgZGV2aWNlDQorICogQHBhc2lkOiB0aGUgcGFzaWQgb2YgdGhlIGFkZHJlc3Mgc3BhY2UgaW4g
d2hpY2ggdGhlIHRyYW5zbGF0aW9uIHdpbGwgYmUgbWFkZQ0KKyAqIEBwcml2X3JlcTogcHJpdmls
ZWdlZCBtb2RlIGJpdCAoUEFTSUQgVExQKQ0KKyAqIEBleGVjX3JlcTogZXhlY3V0ZSByZXF1ZXN0
IGJpdCAoUEFTSUQgVExQKQ0KKyAqIEBhZGRyOiBzdGFydCBhZGRyZXNzIG9mIHRoZSBtZW1vcnkg
cmFuZ2UgdG8gYmUgdHJhbnNsYXRlZA0KKyAqIEBsZW5ndGg6IGxlbmd0aCBvZiB0aGUgbWVtb3J5
IHJhbmdlIGluIGJ5dGVzDQorICogQG5vX3dyaXRlOiByZXF1ZXN0IGEgcmVhZC1vbmx5IGFjY2Vz
cyB0cmFuc2xhdGlvbiAoaWYgc3VwcG9ydGVkIGJ5IHRoZSBJT01NVSkNCisgKiBAcmVzdWx0OiBi
dWZmZXIgaW4gd2hpY2ggdGhlIFRMQiBlbnRyaWVzIHdpbGwgYmUgc3RvcmVkDQorICogQHJlc3Vs
dF9sZW5ndGg6IHJlc3VsdCBidWZmZXIgbGVuZ3RoDQorICogQGVycl9jb3VudDogbnVtYmVyIG9m
IHVudHJhbnNsYXRlZCBzdWJyZWdpb25zDQorICovDQorc3NpemVfdCBwY2lfYXRzX3JlcXVlc3Rf
dHJhbnNsYXRpb25fcGFzaWQoUENJRGV2aWNlICpkZXYsIHVpbnQzMl90IHBhc2lkLA0KKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgcHJpdl9yZXEsIGJvb2wg
ZXhlY19yZXEsIGh3YWRkciBhZGRyLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHNpemVfdCBsZW5ndGgsIGJvb2wgbm9fd3JpdGUsDQorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVUTEJFbnRyeSAqcmVzdWx0LA0KKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVfdCByZXN1bHRfbGVuZ3Ro
LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90ICpl
cnJfY291bnQpOw0KKw0KKy8qKg0KKyAqIHBjaV9yZWdpc3Rlcl9pb21tdV90bGJfZXZlbnRfbm90
aWZpZXI6IHJlZ2lzdGVyIGEgbm90aWZpZXIgZm9yIGNoYW5nZXMgdG8NCisgKiBJT01NVSB0cmFu
c2xhdGlvbiBlbnRyaWVzIGluIGEgc3BlY2lmaWMgYWRkcmVzcyBzcGFjZS4NCisgKg0KKyAqIFJl
dHVybnMgMCBvbiBzdWNjZXNzLCBvciBhIG5lZ2F0aXZlIGVycm5vIG90aGVyd2lzZS4NCisgKg0K
KyAqIEBkZXY6IHRoZSBkZXZpY2UgdGhhdCB3YW50cyB0byBnZXQgbm90aWZpZWQNCisgKiBAcGFz
aWQ6IHRoZSBwYXNpZCBvZiB0aGUgYWRkcmVzcyBzcGFjZSB0byB0cmFjaw0KKyAqIEBuOiB0aGUg
bm90aWZpZXIgdG8gcmVnaXN0ZXINCisgKi8NCitpbnQgcGNpX3JlZ2lzdGVyX2lvbW11X3RsYl9l
dmVudF9ub3RpZmllcihQQ0lEZXZpY2UgKmRldiwgdWludDMyX3QgcGFzaWQsDQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVOb3RpZmllciAqbik7DQorDQor
LyoqDQorICogcGNpX3VucmVnaXN0ZXJfaW9tbXVfdGxiX2V2ZW50X25vdGlmaWVyOiB1bnJlZ2lz
dGVyIGEgbm90aWZpZXIgdGhhdCBoYXMgYmVlbg0KKyAqIHJlZ2lzdGVyZCB3aXRoIHBjaV9yZWdp
c3Rlcl9pb21tdV90bGJfZXZlbnRfbm90aWZpZXINCisgKg0KKyAqIFJldHVybnMgMCBvbiBzdWNj
ZXNzLCBvciBhIG5lZ2F0aXZlIGVycm5vIG90aGVyd2lzZS4NCisgKg0KKyAqIEBkZXY6IHRoZSBk
ZXZpY2UgdGhhdCB3YW50cyB0byB1bnN1YnNjcmliZQ0KKyAqIEBwYXNpZDogdGhlIHBhc2lkIG9m
IHRoZSBhZGRyZXNzIHNwYWNlIHRvIGJlIHVudHJhY2tlZA0KKyAqIEBuOiB0aGUgbm90aWZpZXIg
dG8gdW5yZWdpc3Rlcg0KKyAqLw0KK2ludCBwY2lfdW5yZWdpc3Rlcl9pb21tdV90bGJfZXZlbnRf
bm90aWZpZXIoUENJRGV2aWNlICpkZXYsIHVpbnQzMl90IHBhc2lkLA0KKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVOb3RpZmllciAqbik7DQorDQogLyoq
DQogICogcGNpX3NldHVwX2lvbW11OiBJbml0aWFsaXplIHNwZWNpZmljIElPTU1VIGhhbmRsZXJz
IGZvciBhIFBDSUJ1cw0KICAqDQotLSANCjIuNDUuMQ0K

