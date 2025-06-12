Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47685C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 08:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPdIK-00083F-G6; Thu, 12 Jun 2025 04:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan.milon@eviden.com>)
 id 1uPdII-0007zB-HT
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 04:28:18 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan.milon@eviden.com>)
 id 1uPdIE-0004FS-HY
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 04:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1749716894; x=1781252894;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=zakrR4JqSPWHOnt54y9JfyHB4VRlEXRHpZi9ornklv8=;
 b=OgeW1omvC4DnsNWatLJPrzXcPdNxrj821BO4HriwGxDqqpGXX74Te1xN
 Zn10G4WADjbS8N5wcBCX8ERr4RRmCIf7wCMVPR+ReBcY4gumQ1odj/YyQ
 60FeColA+vZMvs/IYj8PvtephDdXd8iB+o18WbF+hiI9J8SGXA8+EZBWx
 g8b5LGxtBeQbbeVLSFGWyfwFLrTcQxIe824UV3NtCTkpGh2cF8DF/h6W3
 HtdoMODBA6BuPdiMd9y7SnJ2kT+xDrbBu2FIUQF+VpYdGVPp9jEkhKbpM
 1yOXyY9tP1AwnEp4JxS0Ns5Uv99WLoH4n4Y4vVfxhBStofHkt4V/nClm1 g==;
X-CSE-ConnectionGUID: L1in+C7DTda+vtB88tWTEg==
X-CSE-MsgGUID: sKVxCFpBRvy3h+YrmveuZw==
X-IronPort-AV: E=Sophos;i="6.16,230,1744063200"; d="scan'208";a="38606832"
X-MGA-submission: =?us-ascii?q?MDGfwgSvPE8pN0J2frqpn370ICspTFf8E16rBy?=
 =?us-ascii?q?q5ZFlEQ7cKzo/3yBWrvEYtVudoFyi3AAmSnP4xQhp9pw0sm82Piu0BmJ?=
 =?us-ascii?q?2xE5QLMhCBhpPEXsBtOrQYbhuCHldZA4di2crysU05O2RgG7Nx2TUYNW?=
 =?us-ascii?q?jSIJwFi89zN16d2LLunayDjw=3D=3D?=
Received: from mail-francecentralazon11013047.outbound.protection.outlook.com
 (HELO PA4PR04CU001.outbound.protection.outlook.com) ([40.107.162.47])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 12 Jun 2025 10:28:00 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCuI0xH5dgol1iIu1vrciNlxZGpMCcveQQtT3aojF5ABBRu+BnndUvJyE8Klga73UTXY7mDLEGYRj2VEXl1uU8L3/ssgQHGTehAHlkHEE4s9xTNNt7tRhmYzKZoALAUjThLSbH17s4MOcgrn9e6rtNoElIzF6S6n8nkyGNZgd5hPKJlDdnU18W1RaLLEFTNyL9ZnsyejsTrN0Nft4GYkDsJMyXZhf8XjxCWsSo1Z2/+3Wn6b0VlrboLv9e+biTalFABCcLadrEegflannf+FYurLm49xdLSOFy04g/3vZPygVI2RZmtOXGV+BA48BLSoMkj6eiLmqJz+afNQHN8Rhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zakrR4JqSPWHOnt54y9JfyHB4VRlEXRHpZi9ornklv8=;
 b=EvjCv2mv7eExiHSsiNMBAqefVgkoTG7vmfquo4I/l/k2xRyehVdMVm/bw+e+TphVFvc8EuZ6CgNk831sQDXfNtvNFLatU1yE8E2aE1jCC1lAQNVNeinBzHEVmpVGLmWHlK7Y17+oP9i4GaFqjcV665ppxQeHCz8f126pGPaO8zL6163Xio6IlBaZ0JUAddKIUYChDWul8j7YwcUqpiznuYzz+Nbx0bPcP685lVYV/sZN9egMzqW13gA/nbBYjUCWTnVJ70tnK7VgH2cbfMPNr86ER3cridLQMGAs2QykGzHne1shM9hmK3+8BQ+FPejcrI8okX5C572Qhi0mgbM6cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zakrR4JqSPWHOnt54y9JfyHB4VRlEXRHpZi9ornklv8=;
 b=ZS9j/ckG0ksL4E33xjDuMWjqDCC5tQI0KGCcUo/Esj6VkynTTNiflhqHRwTS1jNty3f01Yq3Qig41MfzIwIOX7ycjpjT1TJijHkLTsd+XAHYFz7Bx+oEK5njM97pyYC7uRwj+QrpUTMR9Opdq164P6c3MzdQ4XGwbLPoXaNFXefHxq3cMYwGf4oGJycpA9fMZYiVRsbSGsy87jKcahQiWGsRTdDlVwbAT9TfjwPbPtChIDRHSsY7wJCH+WOIKBMzSBfCNey4YUUkcrq7+3WST4Rt0Luxd3VvjA0kQxcqL5BmPBTsnv5hzPCkQoaCiKZUnSXT1RtxozA3JaPkg6eMcw==
Received: from VI1PR0701MB6847.eurprd07.prod.outlook.com
 (2603:10a6:800:190::13) by DBAPR07MB7045.eurprd07.prod.outlook.com
 (2603:10a6:10:17e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 08:27:58 +0000
Received: from VI1PR0701MB6847.eurprd07.prod.outlook.com
 ([fe80::5a47:474b:4132:d07e]) by VI1PR0701MB6847.eurprd07.prod.outlook.com
 ([fe80::5a47:474b:4132:d07e%7]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 08:27:57 +0000
From: Ethan MILON <ethan.milon@eviden.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "santosh.shukla@amd.com" <santosh.shukla@amd.com>, "sarunkod@amd.com"
 <sarunkod@amd.com>, "Wei.Huang2@amd.com" <Wei.Huang2@amd.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "boris.ostrovsky@oracle.com"
 <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v2 18/20] amd_iommu: Toggle address translation mode on
 devtab entry invalidation
Thread-Topic: [PATCH v2 18/20] amd_iommu: Toggle address translation mode on
 devtab entry invalidation
Thread-Index: AQHbuwg8dG4yhzee90WftiXaN+VP3bP/cbgA
Date: Thu, 12 Jun 2025 08:27:57 +0000
Message-ID: <5fedf606-dd01-4a0a-af67-077e9ef9d0fd@eviden.com>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250502021605.1795985-19-alejandro.j.jimenez@oracle.com>
In-Reply-To: <20250502021605.1795985-19-alejandro.j.jimenez@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR0701MB6847:EE_|DBAPR07MB7045:EE_
x-ms-office365-filtering-correlation-id: 8401d899-834f-46f4-b965-08dda98b0934
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?cWwzSkcrV2o2RFNKUmhDdytrWCtBSFFDRXlvN3RXVnA0NXg3T3JBK2J6clVS?=
 =?utf-8?B?YWpMTW5XQWpKNk5DNStEYnZHb0R4N0hGSlJTUGcvdXVjM2lEdjI1c1pnZ0l2?=
 =?utf-8?B?K1ZZYlByWXp2cDBTVHRkclc0QlB6N3UrTDQrUXVtNTBLN2psWkZVV0Y1RGd1?=
 =?utf-8?B?SEVYVlovVnFtb1ViK0FrWjlBY2tQV1p4dVJlRTJuT3E3NGxpaStaU0tLSzVJ?=
 =?utf-8?B?VmVnMDBHVis2Sis4NDF1Wkd1VjNGbnRpeUdUajZnc1VNd1lvcmdndXRmUU9D?=
 =?utf-8?B?Q043ZjFjNDhFajNhdTFTc3JOZkJzblZ1dFJZTmNjVEJPNnhnTmtOVEpaOUhy?=
 =?utf-8?B?TUlqU3U4cVlyNUZ0RDROWHBYeTdZcVc3TmRpUVlSclMwczJRMzBSOHRJSmRS?=
 =?utf-8?B?WUhxSW1HY2MrUTlMMHU5RGtTTmRCeWl6RE1vb2x3Z0QvWEJRR0lTRVBUK1NX?=
 =?utf-8?B?R3cyWUFSLzkzT09RdXNJTDVBSFpPNnlUQzB2dXdONjl5aEF3MHBGS2x6NkRZ?=
 =?utf-8?B?aXJzWVRaM0lzRlA5VE50MkEvZ2kyTmNEN1pWU29HbjJvMmFncUxRTXBjcThQ?=
 =?utf-8?B?dGdLWUM2MkxiU3NFbzV0TVo2YVFvT0tGd1orR3Y2UHdFVXcrM1U4STZLZHVy?=
 =?utf-8?B?NDBoKzJKNFV0cEFsTGw1UGZ6bGVmSW83V3U2bGdGVFZsS1lDMDZOUXVvU2lw?=
 =?utf-8?B?b3lGeXRRTFBHaEZwU1RlaGM2YU9oMEVWdlpQRXZmSlBFK2dEamZhaWtHaitU?=
 =?utf-8?B?a293SUxBUFhVbFhFTVgyVS9mbWhrVkhGa0orN204SndvVi96RzNkV1dDT2tP?=
 =?utf-8?B?RFlUMmdiQ3BwQmlzZWltTmxaYTFpdnlEYUMzR0Vvamx3VVdBaE16TnZCSWVq?=
 =?utf-8?B?LzNKSldxK0FNbUJDZ2R2dzlLbWg2RWdjMlg3L2pqTldxSDNiT2NVSGRsWitM?=
 =?utf-8?B?eUNUbUZONE9SNTZlTUV5bG9lbFN2MnhWRElIV0RkVkpzT2xjelNvTEt6ZEla?=
 =?utf-8?B?QituMVBmVlU2Tk9yeWdBNHFnM2pwQ2ZwK2VrVk5iWnQvdW1WYkVtMzRQVFdR?=
 =?utf-8?B?djRaZHJlSzFoeHR1KzhjcmpDWGNoZVdPbytkNHgybmh6MWdTZHd0M2U3MFFx?=
 =?utf-8?B?RGpPdnFuaERvcjA0RUdEbDdaMWRhMC9DOTI3ZER2Y2dsS2psTzRucDEwSzVQ?=
 =?utf-8?B?aVc2bVNpMS9GbzQ3SHNoWW5Ccjg5RzdxREVGZTJQbDlZeUZNNTdoMlgzY3hT?=
 =?utf-8?B?RG11VVZjeEVzZitoVU82N21aOUZBenZhZmJHU2lOMmRVZlkvQ21DZHJoQXRU?=
 =?utf-8?B?aEVxMnFkMFB3MUM1THJmUUFYOXRSUFhoT0hZWU81UVpoQmx0TEJkR0N1U3pz?=
 =?utf-8?B?SHluK3Ywb25IMzIrczNrY1QwSExQT1Z1M0ZHam5yaW1jVDgrRnBlZkU0Skdk?=
 =?utf-8?B?NlRreDJ0ZHYwU0orVUhZYm0zZVJNRHRNUHBGc054Ly9nQlMxbjc5VUloRU1H?=
 =?utf-8?B?U3F1MmJLcVBIZEUwTUNVUnF6YU9jL0RvZWdNQWNtYzJLeU5YWDZ6eW1WM1po?=
 =?utf-8?B?ek5BK2VQSzBUQWtjMi82YW1sMlI3NDNBZ2JRREZWU2pZamFLTTVuS3pXaDZ2?=
 =?utf-8?B?NCtLT0dwQ0RLcWVuaHRnRWhCMllVQ3FmdjZtM3JpenBhYmdEeEFFOWlHa0Zj?=
 =?utf-8?B?VDVKTDZLTmdkNFRrTjVkaENzT08wNE1DenJ1Yy9ka3dUdHVyaVh0cW5ONUZP?=
 =?utf-8?B?OG9QSkswWlJ2bzZCOGhUOFZxWXF4V0lRUW8yYTRLaGdqN2FLZ1NWZkVSOTls?=
 =?utf-8?B?b2QxNnExNStZUFJrYzc5d0pkZVd2bjFCUWRqTFRrNEwzaUw1N080V0M0LzY0?=
 =?utf-8?B?cWl5MU1yNHhoQUZPMVlEcXpuNTlUQ3hTbWJqaVRnY3VCOEl4QlVmR3VrWUFV?=
 =?utf-8?B?eGJTdDlIZkszVmRWTE5EWTBBS1dVUFpuS3ZPVDR6RHRHSStxajVIUnZrNmtC?=
 =?utf-8?B?ZEozNTk0enlBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR0701MB6847.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXgxSGJUT3Z5VWlpeDBpd2pDVGw1KzNQY0JyeUUwQ3ZSTG8rMzBacWtuamcv?=
 =?utf-8?B?WjJZclpJMEtOdGw0UFNXd0RsMGRhV0oyaXRtakkzZmk2ZVR5aFNxMTFtbUJi?=
 =?utf-8?B?QWl1NDBZN0VMTE0zM0tJM3p2YTh0bVkxTFllT21NNG9GZDh5ZUpPeUtpUUc3?=
 =?utf-8?B?SWRJcjRrcmZ4STJZRzkvd2xEcFIrY2hRK3JQNmNYa2NTQTcvQ0tlR2RESDIz?=
 =?utf-8?B?WG5uTGY3TFlyOFFnN2pjdDlVSFp3YnlzZm1OeUNxaDVvdm5OR1R2TWdjeGVS?=
 =?utf-8?B?UU1CNDlGTFh6MHZwZk9NRmVlUm5ZTU9PSFh6a2YrRG42ZEt6V0x1T0kydWVQ?=
 =?utf-8?B?UGNmNmR6MHFWRlIyM1FRaVcrUThXamNSYjVic1lIMGMxcUlvRFowTjc1Z0FB?=
 =?utf-8?B?cHBYaS96c0Vudk1FNnBhd3g0MENza3AvZjdhdDVMQlVmWVBzL29uc3FGSWtB?=
 =?utf-8?B?MWhPRzFpNkVDaDV3dFBMNHZ4QVNlZWRLQkg0a3lyOEhYWGpQL09NcGdEaER1?=
 =?utf-8?B?NlNOaGpIbm9hZ2pycWh6VDRDZXFpVkVJZ2hUYVRLSExHZ0NXRjBLc1FISWE2?=
 =?utf-8?B?d1JQbXRCYWRsaDlINEJXTFNWRXJEV0x6Ynd6L1kvZ00vSWxQMFdwRVhlWHB4?=
 =?utf-8?B?YlZiY2k4WnhnQUFEQ0dFcmJ3VEthclhXc3lOdzR1aFNTU0RCTW93b0tmdnpl?=
 =?utf-8?B?L0tWTVViL2ZFbG1velE0ME43VC9YcHBWaGJkeXZtTTFpWW5BaWlrTFczU0VS?=
 =?utf-8?B?YncwaGRXczFGcmpzZ3E0ZVZuUzhGTXAzUWp6bVo2YjJ5eVBzY3duSUYvdnBj?=
 =?utf-8?B?a0lHd3dtYjJWVURDVURUOGEzWC9ZN0k3UWFlR3RraFhmMU1jMzZYaE5tOW1o?=
 =?utf-8?B?MkdGN0dWbzIwKzdmSlZ2bkt2TTVFRmZsUDFFYnJOeFpNM09ESE10aC9KTDE4?=
 =?utf-8?B?NFdUQ25qRjZPRk5hUWhPL1pseDVSQU9Jb1ZnTzJxNzYvaEw0ZTlsRkZJU3E2?=
 =?utf-8?B?N1BiZE9UWjU1ZVB5TDBlQVQzTm9tZ2FIWk9vMGNkM0IvTG1FWkhnS0hRRE5M?=
 =?utf-8?B?TlBVK1RzTEl4Ykt0OVJvV3NrcEJUZHkrVXlkVUF5YW9ncklzRFJQSU02ZUhk?=
 =?utf-8?B?Nm5iRWxSRzBSSno0YkE0ZXQzUEdxdVI2bTR3MERYYmhrdmJvcG91Z2FOSlRH?=
 =?utf-8?B?Yjg4OUJidG91MXZBamc1bE0rbVU5c0Q5Rk1CUkdpRXVQZ0d0aGgwRzYyS2th?=
 =?utf-8?B?a0FJRHF0cm1aWllCYlNIcGZSbGpsN1laSGJOdmdHaXhsN0FxSFpOUEdEb0ht?=
 =?utf-8?B?b0tzb1RPbDhIM0N2cGtocFZ6YlVWS2ZtQ0xKYUVSVWU1S1ViMnMzQ3NDaTdU?=
 =?utf-8?B?M0dYVktnYzMzRXYwODJTeXhPd254U05QOXg4ZmNrLzhIRStyVThDck82OU5G?=
 =?utf-8?B?NGR5NEJ6cHF6Unp5bG1BSWpWOGdRNmQrZmlGZmtnRWN3dmJVVnhQaXpScW5P?=
 =?utf-8?B?RisyS3ZhMGlQT0NQMFBxUTBtOVFuU0JFY3FCU0N5dU9XdlV5QVIzU3JTRFBt?=
 =?utf-8?B?L0U2emw3MDB4VnJqZGM5aWN4REpiQncvc3FRZW9wcThoZlp4ejhWaUdrbjcr?=
 =?utf-8?B?SG8zV21LMVdYeDdrR29TcGgrVjMwQ053Mm5pQVJnL0U3alFMSmU1R2ppM0xW?=
 =?utf-8?B?dW5NT0NGbTd0anNPM1k5WGgvaG5YTkllbnMwTUc1RUZhbVNwZVg5MjdONUlH?=
 =?utf-8?B?bTBINFRQTjlSWWZsTVlGaGhBYXRlMEJuUFBZd01lNGkyRFZlTGpTVGdnYWFk?=
 =?utf-8?B?M3FmU1p6UEZYMXl3TTNpTlN3SjRnRmxISHhQbU5JVERoTTFrZUgrWDVNeWdU?=
 =?utf-8?B?OXFwUWZnVjFLVGVULzVVTHpYNkRJeUNhSkYveGQvallqSUU1ajd3K1ZBRDVm?=
 =?utf-8?B?QWR6TkVYbWhScjVXemRVbFpkcnV6UHlta0dNRWUwa3l5SGdYNERjZEhzT1Ax?=
 =?utf-8?B?YU0va0lWQkpWZlRpTHVNWWNJZjZISmtxVFBFL1NqaTBUMHQwRVJybHFleFow?=
 =?utf-8?B?Q1IyZEVWdGVUZXVNMVltajkxaEFLU05DTTZDR0p2Q2ZQOUhWTm55YTFIMUNr?=
 =?utf-8?B?UnBVNThROHpyRkMwMHJGUlRPSWViaDNpbU5hNzlhZDlSeXBPcUlYTmFqajFQ?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D19EDCDCDD97624E93FB9ABF3C98A608@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0701MB6847.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8401d899-834f-46f4-b965-08dda98b0934
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 08:27:57.6406 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZHENERA2HDIsTx9nHjsIoMGtV0ZC9V5I7oJyS7pvZfPlc+pga1qE7h03ZD3M9s5xPfYeWs5xQEZloVbEJDn4rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB7045
Received-SPF: pass client-ip=80.78.11.83; envelope-from=ethan.milon@eviden.com;
 helo=smarthost2.eviden.com
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

SGksDQoNCk9uIDUvMi8yNSA0OjE2IEFNLCBBbGVqYW5kcm8gSmltZW5leiB3cm90ZToNCj4gQ2F1
dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxp
bmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IEEgZ3Vlc3QgbXVzdCBpc3N1ZSBh
biBJTlZBTElEQVRFX0RFVlRBQl9FTlRSWSBjb21tYW5kIGFmdGVyIGNoYW5naW5nIGENCj4gRGV2
aWNlIFRhYmxlIGVudHJ5IChEVEUpIGUuZy4gYWZ0ZXIgYXR0YWNoaW5nIGEgZGV2aWNlIGFuZCBz
ZXR0aW5nIHVwIGl0cw0KPiBEVEUuIFdoZW4gaW50ZXJjZXB0aW5nIHRoaXMgZXZlbnQsIGRldGVy
bWluZSBpZiB0aGUgRFRFIGhhcyBiZWVuIGNvbmZpZ3VyZWQNCj4gZm9yIHBhZ2luZyBvciBub3Qs
IGFuZCB0b2dnbGUgdGhlIGFwcHJvcHJpYXRlIG1lbW9yeSByZWdpb25zIHRvIGFsbG93IERNQQ0K
PiBhZGRyZXNzIHRyYW5zbGF0aW9uIGZvciB0aGUgYWRkcmVzcyBzcGFjZSBpZiBuZWVkZWQuIFJl
cXVpcmVzIGRtYS1yZW1hcD1vbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZWphbmRybyBKaW1l
bmV6IDxhbGVqYW5kcm8uai5qaW1lbmV6QG9yYWNsZS5jb20+DQo+IC0tLQ0KPiAgaHcvaTM4Ni9h
bWRfaW9tbXUuYyB8IDc4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDc2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9hbWRfaW9tbXUuYyBiL2h3L2kzODYvYW1kX2lv
bW11LmMNCj4gaW5kZXggYTJkZjczMDYyYmY3Li43NWE5MjA2N2YzNWYgMTAwNjQ0DQo+IC0tLSBh
L2h3L2kzODYvYW1kX2lvbW11LmMNCj4gKysrIGIvaHcvaTM4Ni9hbWRfaW9tbXUuYw0KPiBAQCAt
OTkxLDE4ICs5OTEsOTIgQEAgc3RhdGljIHZvaWQgYW1kdmlfc3dpdGNoX2FkZHJlc3Nfc3BhY2Vf
YWxsKEFNRFZJU3RhdGUgKnMpDQo+ICAgICAgfQ0KPiAgfQ0KPiANCj4gKy8qDQo+ICsgKiBBIGd1
ZXN0IGRyaXZlciBtdXN0IGlzc3VlIHRoZSBJTlZBTElEQVRFX0RFVlRBQl9FTlRSWSBjb21tYW5k
IHRvIHRoZSBJT01NVQ0KPiArICogYWZ0ZXIgY2hhbmdpbmcgYSBEZXZpY2UgVGFibGUgZW50cnku
IFdlIGNhbiB1c2UgdGhpcyBmYWN0IHRvIGRldGVjdCB3aGVuIGENCj4gKyAqIERldmljZSBUYWJs
ZSBlbnRyeSBpcyBjcmVhdGVkIGZvciBhIGRldmljZSBhdHRhY2hlZCB0byBhIHBhZ2luZyBkb21h
aW4gYW5kDQo+ICsgKiBlbmFibGUgdGhlIGNvcnJlc3BvbmRpbmcgSU9NTVUgbWVtb3J5IHJlZ2lv
biB0byBhbGxvdyBmb3IgRE1BIHRyYW5zbGF0aW9uIGlmDQo+ICsgKiBhcHByb3ByaWF0ZS4NCj4g
KyAqLw0KPiArc3RhdGljIHZvaWQgYW1kdmlfdXBkYXRlX2FkZHJfdHJhbnNsYXRpb25fbW9kZShB
TURWSVN0YXRlICpzLCB1aW50MTZfdCBkZXZpZCkNCj4gK3sNCj4gKyAgICB1aW50OF90IGJ1c19u
dW0sIGRldmZuLCBkdGVfbW9kZTsNCj4gKyAgICBBTURWSUFkZHJlc3NTcGFjZSAqYXM7DQo+ICsg
ICAgdWludDY0X3QgZHRlWzRdID0geyAwIH07DQo+ICsgICAgSU9NTVVOb3RpZmllciAqbjsNCj4g
KyAgICBpbnQgcmV0Ow0KPiArDQo+ICsgICAgLyoNCj4gKyAgICAgKiBDb252ZXJ0IHRoZSBkZXZp
ZCBlbmNvZGVkIGluIHRoZSBjb21tYW5kIHRvIGEgYnVzIGFuZCBkZXZmbiBpbg0KPiArICAgICAq
IG9yZGVyIHRvIHJldHJpZXZlIHRoZSBjb3JyZXNwb25kaW5nIGFkZHJlc3Mgc3BhY2UuDQo+ICsg
ICAgICovDQo+ICsgICAgYnVzX251bSA9IFBDSV9CVVNfTlVNKGRldmlkKTsNCj4gKyAgICBkZXZm
biA9IGRldmlkICYgMHhmZjsNCj4gKw0KPiArICAgIC8qDQo+ICsgICAgICogVGhlIG1haW4gYnVm
ZmVyIG9mIHNpemUgKEFNRFZJQWRkcmVzc1NwYWNlICopICogKFBDSV9CVVNfTUFYKSBoYXMgYWxy
ZWFkeQ0KPiArICAgICAqIGJlZW4gYWxsb2NhdGVkIHdpdGhpbiBBTURWSVN0YXRlLCBidXQgbXVz
dCBiZSBjYXJlZnVsIHRvIG5vdCBhY2Nlc3MNCj4gKyAgICAgKiB1bmFsbG9jYXRlZCBkZXZmbi4N
Cj4gKyAgICAgKi8NCj4gKyAgICBpZiAoIXMtPmFkZHJlc3Nfc3BhY2VzW2J1c19udW1dIHx8ICFz
LT5hZGRyZXNzX3NwYWNlc1tidXNfbnVtXVtkZXZmbl0pIHsNCj4gKyAgICAgICAgcmV0dXJuOw0K
PiArICAgIH0NCj4gKyAgICBhcyA9IHMtPmFkZHJlc3Nfc3BhY2VzW2J1c19udW1dW2RldmZuXTsN
Cj4gKw0KPiArICAgIHJldCA9IGFtZHZpX2FzX3RvX2R0ZShhcywgZHRlKTsNCj4gKw0KPiArICAg
IGlmICghcmV0KSB7DQo+ICsgICAgICAgIGR0ZV9tb2RlID0gKGR0ZVswXSA+PiBBTURWSV9ERVZf
TU9ERV9SU0hJRlQpICYgQU1EVklfREVWX01PREVfTUFTSzsNCj4gKyAgICB9DQo+ICsNCj4gKyAg
ICBpZiAoKHJldCA8IDApIHx8ICghcmV0ICYmICFkdGVfbW9kZSkpIHsNCj4gKyAgICAgICAgLyoN
Cj4gKyAgICAgICAgICogVGhlIERURSBjb3VsZCBub3QgYmUgcmV0cmlldmVkLCBpdCBpcyBub3Qg
dmFsaWQsIG9yIGl0IGlzIG5vdCBzZXR1cA0KPiArICAgICAgICAgKiBmb3IgcGFnaW5nLiBJbiBl
aXRoZXIgY2FzZSwgZW5zdXJlIHRoYXQgaWYgcGFnaW5nIHdhcyBwcmV2aW91c2x5IGluDQo+ICsg
ICAgICAgICAqIHVzZSB0aGVuIGludmFsaWRhdGUgYWxsIGV4aXN0aW5nIG1hcHBpbmdzIGFuZCB0
aGVuIHN3aXRjaCB0byB1c2UgdGhlDQo+ICsgICAgICAgICAqIG5vX2RtYSBtZW1vcnkgcmVnaW9u
Lg0KPiArICAgICAgICAgKi8NCg0KSWYgdGhlIERURSBpcyBtYWxmb3JtZWQgb3IgY291bGQgbm90
IGJlIHJldHJpZXZlZCwgd291bGRuJ3QgaXQgYmUgc2FmZXINCnRvIGRlZmF1bHQgdG8gdGhlIERN
QSByZWdpb24gcmF0aGVyIHRoYW4gZmFsbGluZyBiYWNrIHRvIGRpcmVjdCBhY2Nlc3M/DQpPciBh
bSBJIG1pc3Npbmcgc29tZXRoaW5nPw0KDQpUaGFua3MsDQoNCkV0aGFuDQoNCj4gKyAgICAgICAg
aWYgKGFzLT5hZGRyX3RyYW5zbGF0aW9uKSB7DQo+ICsgICAgICAgICAgICBhcy0+YWRkcl90cmFu
c2xhdGlvbiA9IGZhbHNlOw0KPiArDQo+ICsgICAgICAgICAgICBJT01NVV9OT1RJRklFUl9GT1JF
QUNIKG4sICZhcy0+aW9tbXUpIHsNCj4gKyAgICAgICAgICAgICAgICBhbWR2aV9hZGRyZXNzX3Nw
YWNlX3VubWFwKGFzLCBuKTsNCj4gKyAgICAgICAgICAgIH0NCj4gKyAgICAgICAgICAgIGFtZHZp
X3N3aXRjaF9hZGRyZXNzX3NwYWNlKGFzKTsNCj4gKyAgICAgICAgfQ0KPiArICAgIH0gZWxzZSBp
ZiAoIWFzLT5hZGRyX3RyYW5zbGF0aW9uKSB7DQo+ICsgICAgICAgIC8qDQo+ICsgICAgICAgICAq
IEluc3RhbGxpbmcgYSBEVEUgdGhhdCBlbmFibGVzIHRyYW5zbGF0aW9uIHdoZXJlIGl0IHdhc24n
dCBwcmV2aW91c2x5DQo+ICsgICAgICAgICAqIGFjdGl2ZS4gQWN0aXZhdGUgdGhlIERNQSBtZW1v
cnkgcmVnaW9uLg0KPiArICAgICAgICAgKi8NCj4gKyAgICAgICAgYXMtPmFkZHJfdHJhbnNsYXRp
b24gPSB0cnVlOw0KPiArICAgICAgICBhbWR2aV9zd2l0Y2hfYWRkcmVzc19zcGFjZShhcyk7DQo+
ICsgICAgICAgIGFtZHZpX2FkZHJlc3Nfc3BhY2Vfc3luYyhhcyk7DQo+ICsgICAgfQ0KPiArfQ0K
PiArDQo+ICAvKiBsb2cgZXJyb3Igd2l0aG91dCBhYm9ydGluZyBzaW5jZSBsaW51eCBzZWVtcyB0
byBiZSB1c2luZyByZXNlcnZlZCBiaXRzICovDQo+ICBzdGF0aWMgdm9pZCBhbWR2aV9pbnZhbF9k
ZXZ0YWJfZW50cnkoQU1EVklTdGF0ZSAqcywgdWludDY0X3QgKmNtZCkNCj4gIHsNCj4gICAgICB1
aW50MTZfdCBkZXZpZCA9IGNwdV90b19sZTE2KCh1aW50MTZfdClleHRyYWN0NjQoY21kWzBdLCAw
LCAxNikpOw0KPiANCj4gKyAgICB0cmFjZV9hbWR2aV9kZXZ0YWJfaW52YWwoUENJX0JVU19OVU0o
ZGV2aWQpLCBQQ0lfU0xPVChkZXZpZCksDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFBDSV9GVU5DKGRldmlkKSk7DQo+ICsNCj4gICAgICAvKiBUaGlzIGNvbW1hbmQgc2hvdWxkIGlu
dmFsaWRhdGUgaW50ZXJuYWwgY2FjaGVzIG9mIHdoaWNoIHRoZXJlIGlzbid0ICovDQo+ICAgICAg
aWYgKGV4dHJhY3Q2NChjbWRbMF0sIDE2LCA0NCkgfHwgY21kWzFdKSB7DQo+ICAgICAgICAgIGFt
ZHZpX2xvZ19pbGxlZ2FsY29tX2Vycm9yKHMsIGV4dHJhY3Q2NChjbWRbMF0sIDYwLCA0KSwNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcy0+Y21kYnVmICsgcy0+Y21kYnVm
X2hlYWQpOw0KPiArICAgICAgICByZXR1cm47DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgLyoNCj4g
KyAgICAgKiBXaGVuIERNQSByZW1hcHBpbmcgY2FwYWJpbGl0eSBpcyBlbmFibGVkLCBjaGVjayBp
ZiB1cGRhdGVkIERURSBpcyBzZXR1cA0KPiArICAgICAqIGZvciBwYWdpbmcgb3Igbm90LCBhbmQg
Y29uZmlndXJlIHRoZSBjb3JyZXNwb25kaW5nIG1lbW9yeSByZWdpb25zLg0KPiArICAgICAqLw0K
PiArICAgIGlmIChzLT5kbWFfcmVtYXApIHsNCj4gKyAgICAgICAgYW1kdmlfdXBkYXRlX2FkZHJf
dHJhbnNsYXRpb25fbW9kZShzLCBkZXZpZCk7DQo+ICAgICAgfQ0KPiAtICAgIHRyYWNlX2FtZHZp
X2RldnRhYl9pbnZhbChQQ0lfQlVTX05VTShkZXZpZCksIFBDSV9TTE9UKGRldmlkKSwNCj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgUENJX0ZVTkMoZGV2aWQpKTsNCj4gIH0NCj4gDQo+
ICBzdGF0aWMgdm9pZCBhbWR2aV9jb21wbGV0ZV9wcHIoQU1EVklTdGF0ZSAqcywgdWludDY0X3Qg
KmNtZCkNCj4gLS0NCj4gMi40My41DQo+IA0K

