Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7F6C3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 04:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPE19-0002xg-Ds; Thu, 04 Jul 2024 00:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPE13-0002xI-Gf
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 00:24:18 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPE0o-0000R0-Uk
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 00:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720067043; x=1751603043;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=KLTheIc6NFmvX+2FHQrO5HxG/cEc/abgtl1Sb6ybfQA=;
 b=kZKbePtHiSsrgvfHP2R5TO4eyIQvJmfSe3T+vJ4bCrlm73xB63oNrZ9r
 ZnH1NdH82ywOI/t9MQmBZtjV3e8UAtfkYDbz/0M2q3MrO7GCJskBRMIzd
 Cx8uL+pgaIBpWjvyvdTiHxEnFvo3FtfIT+ubu/LgyvISkmX9SPE+f+5pe
 XPdcxIRov6D/PbfXDxJQ1n1W1wXDwcPusH2LHvUB0b5OPVaq1CV5w1FJX
 ttRnBqpp8EXw/RZM6c7Tv2uCJ7avKXaT+je0yp4d/NrtBa1H0bdujoraG
 7DD8vn6+E5pKJZsWfedPWD8CyWesCtlx7aWpVn/rNBTJquGtfs9ssdwXy w==;
X-IronPort-AV: E=Sophos;i="6.09,183,1716242400"; d="scan'208";a="15857812"
X-MGA-submission: =?us-ascii?q?MDHSh02XMd+hTNJqrNa1UImiz2kZ9ogZ4eCVPJ?=
 =?us-ascii?q?OL6VbIV2KVwUWjPQidlDwvvfr39gI9Fmnwf7lfa4zEzO5I026FWi7bch?=
 =?us-ascii?q?ejXZbV/W+NjQJFLSaq2tT8GIJCRbIXxs0jkCadVWn5Qvs3o9iLoUlpvF?=
 =?us-ascii?q?rCmwqqBZEjiAvoDy0GaUlL1A=3D=3D?=
Received: from mail-vi1eur02lp2040.outbound.protection.outlook.com (HELO
 EUR02-VI1-obe.outbound.protection.outlook.com) ([104.47.11.40])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 06:23:58 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PS2L43yOXqjCfqZl0zEv5HmYzy5V2octaqeK8jr5v4Okp9FJ/lsrKvtFfulwZLsuu2dGgLAZyETSuJ3MsacOEFVRCWrUeRhKjMZXsesOkI2aabd3EvjTwg2vId3fsqCLYunH7Iqmw6ZopvjskzkszwuV8rroxyH25UkCLPKUgzX+1g3J1O65PGO+12bUj2UR+C2eshz19GK9uHQaxRFN6UrpD+ej+0ZWdRQUA55oHlZdKXorTJ6vacf5EtN1zVve5WgpaTexgJKjE9abJTSi4t8R7aovL45cyiy2YQxO4gxqtnfeppfXBTVOSwoHqZpAaZ7BYL5Z0YktSVlDGdZxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLTheIc6NFmvX+2FHQrO5HxG/cEc/abgtl1Sb6ybfQA=;
 b=c34eJoLUWqX/sYtXmI2pRL6zalM6cR9yzdjQdF1JKrVHCD/qQyLFZAyIBCAHE1TqYCcL0GOQIJFPAEJNkLX2mafeYMAKyrDtX2d3MXWppJMBhMcZS6na4wAyujX+le+HWfAfqpZ/Rzm0PAW2zA80fM5u3ZYCqgAVxRr5Jmz7s2CV9nVeA4xx79ORx4eOTZEAvJAwNnJuzi0Sl6rD/AzVJ288ZYhwfBHealaj0iTlLEroc2lpnWjrwVpN+K/9bKdAsr3pwyhbU0j2fhOBJJkvWGckrmw3v4K7meBElmXm7XHzOrUn+2Z4n452KQaQuPOhMMPxdnrJ1+bUZDlgLB4+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLTheIc6NFmvX+2FHQrO5HxG/cEc/abgtl1Sb6ybfQA=;
 b=D+crtDt8hirTygTi6kfmyp9OgdFC7jvybks9DZsWR0ArI3V9dGMO3odXCNti6uQpzP5n0uBvEb8/+nIzTUTDWw86PWaPGgXm7kZkW3UIrDqIJAJCPpYSvUeP1/L7SVWWqMNGRGsE5Yc8njPd13bxj0R/dJF57RswBDv0W7btthmIufvH03MlrkFCzI5tqsA/kgyej6Wam7wUpB14GKj4XFMnXFddfW24DS2N/1uYJeO3zR/hL8mUFK2XilvliXF/yXIuc2aw9+ooQ43qDf3mCedm0Ne+DpDNtJr5qDgzDM8lqQfXcBzksRoABKKB0tpFpQUM9o+y72g5d1mUg8rrLw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB9PR07MB8636.eurprd07.prod.outlook.com (2603:10a6:10:30b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 04:23:57 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 04:23:57 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Yi Liu <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH ats_vtd v5 04/22] intel_iommu: do not consider wait_desc
 as an invalid descriptor
Thread-Topic: [PATCH ats_vtd v5 04/22] intel_iommu: do not consider wait_desc
 as an invalid descriptor
Thread-Index: AQHazEQIBXXzL7bpek6rQxeDAgf6e7HjcFQAgAAgaoCAAQwzAIABXn2A
Date: Thu, 4 Jul 2024 04:23:57 +0000
Message-ID: <0a352d36-56d3-4958-98ee-101b0a1535b5@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
 <20240702055221.1337035-5-clement.mathieu--drif@eviden.com>
 <655835f4-dd39-4360-9868-57abb8f9a3a3@intel.com>
 <26c57107-3b75-46d0-9191-32bc7572fb26@eviden.com>
 <6f94f4da-27fb-4f8e-adba-33a2f4c20fe5@intel.com>
In-Reply-To: <6f94f4da-27fb-4f8e-adba-33a2f4c20fe5@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB9PR07MB8636:EE_
x-ms-office365-filtering-correlation-id: 0dc5c8af-5b7b-4aaf-e5b4-08dc9be11f11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d1FlbDM5K1JJZFA2RVNKc0JUV0szejY5N1ZyREJNMURRNHZTMGk3NExNQkg3?=
 =?utf-8?B?cWRtZ1dZRDN3ZkpIbmU3d2dIQ2ZMeUZjRVpvK3lIbWdEV1FQNlpTN2FvZWMv?=
 =?utf-8?B?S2ovUUlCWHpZTnFlQVFzMWFCbFhNc1hhOEdITEhiMFJRQkpDdDRENmFMNlJq?=
 =?utf-8?B?TzRiMmNWOXV4MFJaUDRpUzk1SE9hQk03R243dHJYbzBpVFdndC9FRndlekl2?=
 =?utf-8?B?cDRLNEVYREhsUmlZRzZWTmhvck9SRFgybTZZRm1GYlN5bmJkSkNjS0lxZDFE?=
 =?utf-8?B?enpmVkhYNTRGRnlIcFU1KzA4ZmRFQTNIdTRIMDVaRCtBdEw2WHVFSzNRS2Y0?=
 =?utf-8?B?TDR1UVgxdFZQbW9rQWdzQzNWYUlrZVlEWThvbUlVM3c1aVREVFVYemFKYlRE?=
 =?utf-8?B?ekdtVU51dThySGZmQm9qcitSbkxlZFEzKy8xKzZzWkVqN1Jsd1Z5dWQyeUJ4?=
 =?utf-8?B?VkxHMkloaU9qVHUybUdNZ2Z1ZWJ5elJGaFQ5dmZ4RUJaYmRDalJiQlUrK3Br?=
 =?utf-8?B?VUZVSTljYVNmUkhkSzRwMGM3THR1d0MzbTgwMDgvd0FVRTVpZlJKZU1sV0hP?=
 =?utf-8?B?SEZCc0lQdzMyMWtFZGZYUS9DVGduMGErdkMxajluQnpRdTVhNy9heEJULzd1?=
 =?utf-8?B?L2c5MEtjdmg3T0IrSlRvSFhKSDJSQzQ3cW9BQTJEUjRNSzNLNm5Dd3Jlcm5h?=
 =?utf-8?B?c043cFNkNFRoWllHVmtlL1dzQ0M5cUxpUVZSdVFibDlmVlNEZEdCa09ENGtp?=
 =?utf-8?B?ZWM2NE9xWURFUGFNQkU3NExRbGY5WkpwN0pzUGZoTXZPVnVlbUNINlVJVExr?=
 =?utf-8?B?MzVIbWxRa1RhNVZpbFBiZFlnUUJEY3ZwUTdUWnJIMHVJTzZjcWlYM2QyYkUr?=
 =?utf-8?B?bGlwTjVMMmVIYXdUanN4eStjNXNaTXMydnZ0bjUwdE9DS3RQV01taWN4ZnVE?=
 =?utf-8?B?VytwN0wvRW9MR3BGQTBFM0RTSENWSEVrZVd3aitnS29KWG9rc05mKzMxN2NT?=
 =?utf-8?B?ejE4eVJIVE8rUkNiNEhKbytUSmZuelhETVlZeERNcDgwMytXaHRtUWdDaTNL?=
 =?utf-8?B?RmFKa1FEektUak84cmdOZ1dNV0habHdpRkVzcHpFSUo2SHB6eTJmdzRtMXZX?=
 =?utf-8?B?Um10MGhRQkZveDJpLzBha3BSRGw0S3ZxZXp4MVE5Q2U4M2kveUN3NTI1UGF6?=
 =?utf-8?B?NERkQTB0akhJS25xZ1JOdXlxU2w3TkxKeUxYUXo5bVlmWnd6a29yQmZ3UXlC?=
 =?utf-8?B?YWc2Z0JyK1BwSDgwK2RlcmwzTzg1Y1ozNHB1Z3ZOUm5udXFlSXNmbkJadXk5?=
 =?utf-8?B?bjNubGJ2MVN4eU1CVXFXNmErSU8vYUVvVEp0dkhzRkRHTGtWWGg4K25LNjFn?=
 =?utf-8?B?NjdGY3hpK2tqdWNRSkJyVlVzQnJLVHhLY0pxT1JibXhVK2N4STBXOTZxM0JG?=
 =?utf-8?B?aWNhQkNIN3JrdFlJcmVaT3ZTSXkzNGEzYlZZQStSVHpPMittNkFwUmZxazZZ?=
 =?utf-8?B?YWhlNENxVFZad1hscVdmVDUvejlPQ0xwamFwWHBCcllDZE1GcmltZmpOaVBm?=
 =?utf-8?B?OFdUMkFwcDE2OTAvQnlMSHl6cWZZUUMxM2pjYThKTFJHMjV1NWE0dDZQRlZJ?=
 =?utf-8?B?eVBWTjlvdUswYjdlc0h3NVVGS3ZFaGxrbmd2RnBTS1RrSnovbFJpZUYrdDU1?=
 =?utf-8?B?V3pxSUY4TExTU0dGTUsxdDJ1ZEI5WnhsUVc1TnZIYmdWSnJvZUp6Nm9IK0NG?=
 =?utf-8?B?aWhCRExYck9ScXZqVzBiM0xFR1F1WHVqVDViNzJQL0RhcjA4cjZNL1dKZEYv?=
 =?utf-8?B?Y3ZrQlc4REpLdnkzVnJGYWZ3WHJCdG03Wlcvb1g0NUE1dU43cXVldVRVZ0hq?=
 =?utf-8?B?T3JkYm5Pd3Fvc0F5cFhQSFFKaGZ4a05DemVZQk1XUlhpcGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVlqRllqOU9WZ2lQQm04MEZHamI1VVRqU2xUbllIOU9xM29GOFhYWXBPVjQ4?=
 =?utf-8?B?SFpXa2t4RjZWeWkzR2x4WDlkYS9ORmIrS2liYnZWWHhtc3k4WXJ3QlQ2N0J5?=
 =?utf-8?B?c01rVmJLM3hFZnRIL2ZZOUVweEtuUDZIMDZTN0VZc2I2SElsTWtaUk9rSTBQ?=
 =?utf-8?B?ZmFDbXd3aFZiVlI1c1VVb3kyS2NvRS92eHBRaU9uNlU1djBLNlN3V2FIYVdz?=
 =?utf-8?B?WUZHUUpacHgwQUZMQmEvcldjdkVDM3FHUGhZdnNmU2dKRW81TGN5UkZMOTQ1?=
 =?utf-8?B?d0JMeTFEWU1jQU80d2VLdGFpdmxJOEpPNFlSSlBxdG9HSUQwc0U1ME9LNFY1?=
 =?utf-8?B?eVhMeU5kUUpNTllBczlRNE9YU3hoS1JyQ0Z6RG95QWVhMDdoa01jV0dSaHV0?=
 =?utf-8?B?S0I3V21veDFNOHlPa3g4MnFpcDNRT2hsUzA3UmlOc3BGQWZicWp6eHlLb3Ix?=
 =?utf-8?B?a1BEV0NmWExjSTkvanlXYkVFQkdjN1RLYkxxS1BEQTBSKytsTDJ3RGEyWGNK?=
 =?utf-8?B?clBjdHEwSVcxaGNXS215b3ZTUXBhU21seUpsVGMvY1RoR1ZuSGlOZmgwWXox?=
 =?utf-8?B?dzdyaDdCTUVaS3R6enlpMUpkRmRzbnF1Q3ZuNXNyQmUyNit0eFBGU0VGd2Vn?=
 =?utf-8?B?ZDRuVnFoT1FiVFh6dDB4blpRRzd0aThQRU5LSUYzc243MllRVlNmWllEZzNN?=
 =?utf-8?B?MnVjVWFpbURqQWNtMW9FTjhhakJVV2FzQkQvVkFCNDJqOHgwaE5FcUxrek1r?=
 =?utf-8?B?NjNMUmdzbWZYUk5CSno4cVoyb0dpWXdERnhTdkhreEg1L1VDeHQ1WkVzaWdy?=
 =?utf-8?B?MHIzcXBNbG5OeW5SYkZCN3poM0wyaCtCd3BFYjdCOW0zMEtjMjVCeGorZE8y?=
 =?utf-8?B?eHpBNHQ3cTI1RHRqRlYvY1piOXlTYmtaU3lHODFPR2lUalBidzZUNGpIR2lW?=
 =?utf-8?B?TjRoY2g1SGNjT2N0VElEL1JWc1MwaXRHN3ZEREhpdld3RlNLRDhTSFJrUkYx?=
 =?utf-8?B?Y01iQ0VMMi9XM1FwS1dCZ3F5c3hhT1BKV0s2d3c4MXU2dXVKZzFEcWtQOE4x?=
 =?utf-8?B?dEhKdVlOYmd0MDU2K1UzV290WkZWQUY3MjVmRHdQM0IzY2tqWDlrb0U5WXo2?=
 =?utf-8?B?ckdOWUc1c0QvZXE2OVpWMmQvL0QvWnc5S2N6a3ZlUHBDdHZWYzVSRTB5K3p1?=
 =?utf-8?B?aXkvUmUrY05GS2RncHMxc1NnN2xlM3NSdjhEd2cvb3ZNcDZHUmt4OHJCait6?=
 =?utf-8?B?ZlEwYnN2VlNteE5RdzNRRGJYMFhkYkp6WmQzTUU0elh2SmV0eGFReitiYVhk?=
 =?utf-8?B?U2diV0V4YkY2SDQyREpJVU1jS3ZkTG9qUTNuZUZSZERNZkRKNFZmNjNMdFBR?=
 =?utf-8?B?MVFQU3JLY3pRVk4vZldCK28xZXZBOER2Qys5TkJ0Rk1HMDBYRk5acWo0L3NQ?=
 =?utf-8?B?QW51V1dOWSswUC9yazlZNjlHb3JuRnl1anJEWUpmcHNLT2FQS1Y1L2lZUE5I?=
 =?utf-8?B?Z0ZEMVllcmpGOGZBRFpqeW5rK0xMTDU0WGJBOEltRmZVMUtPWXkvNS9DOWpU?=
 =?utf-8?B?YTlhcklEbDgyTzRxejVTRkRHOTFaaEthYkVmbHk5aUxFWGdUR2VQSkpJY2RN?=
 =?utf-8?B?Zkt2akhOYU1hNnhLYktPZDh3bkNKK0dCVEVYT09LWndRNVFwdjFJRU5iNDZ1?=
 =?utf-8?B?UXp5eVAvR0VveCt3YklNVW9FM2o3U3VWNzNFZHNzcFJERkFydGNlbUtPY1Fo?=
 =?utf-8?B?cUlOV1BWK3g3TUplSnBoVWsrbHhqYTR0NGpoT3V1ckRUL25LM3dRc0NzbTZP?=
 =?utf-8?B?Qnc4ZWREOVhRMGx4YWVJa0FySExYMVZCS3UzckJoMUZLTTJxNFhVNG85enNF?=
 =?utf-8?B?VVg3YTJLMEFwc1ZSODhKUUlXeDJ0YjhSMEMvWVpsZkRQWVliRnVjRlR1YkRR?=
 =?utf-8?B?eHVzeVJxeUZQdGUxdDlkdFhrLzhkOGQ3c05NRWtGMjkwNG1QdVRzY0JMbGtK?=
 =?utf-8?B?MDEwTTgweGR4bE5qeDVVV2xDU3pxb2lYZ3VDQlduTHVUUSsrem1pL2kvaFVQ?=
 =?utf-8?B?MFdxb3hqZEIzOUpnVWRQWTg5STNoWWtUbkxnRVhQQy9DVG9sU2dZYVVGcUt3?=
 =?utf-8?B?elUzZE9aV24vZVFSRFVySUhQRC9pZ0tVVGVwSDZoL3lFcE9Udll4SDRTS2hH?=
 =?utf-8?Q?R2d48icOC4IOcOZcltuKdLw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <654AD35CEB16CA4481ECE3BE19B581F2@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc5c8af-5b7b-4aaf-e5b4-08dc9be11f11
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 04:23:57.0925 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yDMOu71bBQkXOsRpkfR+hHmAwrTYjEJUjm+ZDUMwAVrfntVP+M6hAbz0qg75prez9aCs3hx3LtpowlNFjwRyyAc/JsikJyioClwVaJTfNN/7wJxGcWeRfvBMsOqnAYWv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8636
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQpPbiAwMy8wNy8yMDI0IDA5OjI5LCBZaSBMaXUgd3JvdGU6DQo+IENhdXRpb246IEV4dGVybmFs
IGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgDQo+IHVubGVz
cyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBj
b250ZW50IA0KPiBpcyBzYWZlLg0KPg0KPg0KPiBPbiAyMDI0LzcvMiAyMzoyOSwgQ0xFTUVOVCBN
QVRISUVVLS1EUklGIHdyb3RlOg0KPj4NCj4+IE9uIDAyLzA3LzIwMjQgMTU6MzMsIFlpIExpdSB3
cm90ZToNCj4+PiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVu
dHMgb3IgY2xpY2sgbGlua3MsDQo+Pj4gdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtu
b3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQNCj4+PiBpcyBzYWZlLg0KPj4+DQo+
Pj4NCj4+PiBPbiAyMDI0LzcvMiAxMzo1MiwgQ0xFTUVOVCBNQVRISUVVLS1EUklGIHdyb3RlOg0K
Pj4+PiBGcm9tOiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZA
ZXZpZGVuLmNvbT4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0t
RHJpZiANCj4+Pj4gPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPj4+PiBSZXZp
ZXdlZC1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+Pj4g
LS0tDQo+Pj4+IMKgwqAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwgNSArKysrKw0KPj4+PiDCoMKg
IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBh
L2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+PiBpbmRl
eCA5ODk5NmVkZWRjLi43MWNlYmUyZmQzIDEwMDY0NA0KPj4+PiAtLS0gYS9ody9pMzg2L2ludGVs
X2lvbW11LmMNCj4+Pj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4+IEBAIC0zNTAw
LDYgKzM1MDAsMTEgQEAgc3RhdGljIGJvb2wNCj4+Pj4gdnRkX3Byb2Nlc3Nfd2FpdF9kZXNjKElu
dGVsSU9NTVVTdGF0ZSAqcywgVlRESW52RGVzYyAqaW52X2Rlc2MpDQo+Pj4+IMKgwqDCoMKgwqDC
oCB9IGVsc2UgaWYgKGludl9kZXNjLT5sbyAmIFZURF9JTlZfREVTQ19XQUlUX0lGKSB7DQo+Pj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIEludGVycnVwdCBmbGFnICovDQo+Pj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHZ0ZF9nZW5lcmF0ZV9jb21wbGV0aW9uX2V2ZW50KHMpOw0KPj4+PiArwqDC
oMKgIH0gZWxzZSBpZiAoaW52X2Rlc2MtPmxvICYgVlREX0lOVl9ERVNDX1dBSVRfRk4pIHsNCj4+
Pj4gK8KgwqDCoMKgwqDCoMKgIC8qDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICogU1cgPSAwLCBJ
RiA9IDAsIEZOID0gMQ0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIE5vdGhpbmcgdG8gZG8gYXMg
d2UgcHJvY2VzcyB0aGUgZXZlbnRzIHNlcXVlbnRpYWxseQ0KPj4+PiArwqDCoMKgwqDCoMKgwqDC
oCAqLw0KPj4+DQo+Pj4gVGhpcyBjb2RlIGxvb2tzIGEgYml0IHdlaXJkLiBTVyBmaWVsZCBkb2Vz
IG5vdCBjby1leGlzdCB3aXRoIElGLiBCdXQNCj4+PiBlaXRoZXINCj4+PiBTVyBvciBJRiBjYW4g
Y28tZXhpc3Qgd2l0aCBGTiBmbGFnLiBJcyBpdD8gSGF2ZSB5b3UgYWxyZWFkeSBzZWVuIGEgd2Fp
dA0KPj4+IGRlc2NyaXB0b3IgdGhhdCBvbmx5IGhhcyBGTiBmbGFnIHNldCBidXQgbm8gU1cgbm9y
IElGIGZsYWc/DQo+PiBZZXMsIG15IHRlc3Qgc3VpdGUgdHJpZ2dlcnMgdGhhdCBjb25kaXRpb24N
Cj4NCj4gSSBzZWUuIFNwZWMgaW5kZWVkIGhhcyBzdWNoIHVzYWdlLiBQbGVhc2UgYWRkIGEgY29t
bWVudCBmb3IgaXQuDQo+IFNpbmNlIGl0IGRvZXMgbm90IG5lZWQgYSByZXNwb25zZSwgc28gUUVN
VSBjYW4ganVzdCBieXBhc3MgaXQuIEFsc28NCj4gcGxlYXNlIGFkanVzdCB0aGUgc3ViamVjdCBh
IGJpdC4gSXQncyBtaXNsZWFkaW5nLiBQZXJoYXBzDQo+DQo+ICJpbnRlbF9pb21tdTogQnlwYXNz
IGJhcnJpZXIgd2FpdCBkZXNjcmlwdG9yIg0KZ29vZCBpZGVhLCB3aWxsIGRvDQo+DQo+IFNwZWMg
Q0ggNy4xMA0KPiBhLiBTdWJtaXQgSW52YWxpZGF0aW9uIFdhaXQgRGVzY3JpcHRvciAoaW52X3dh
aXRfZHNjKSB3aXRoIEZlbmNlIGZsYWcNCj4gKEZOPTEpIFNldCB0byBJbnZhbGlkYXRpb24NCj4g
UXVldWUuIFRoaXMgZW5zdXJlcyB0aGF0IGFsbCByZXF1ZXN0cyBzdWJtaXR0ZWQgdG8gdGhlIElu
dmFsaWRhdGlvbiBRdWV1ZQ0KPiBhaGVhZCBvZiB0aGlzIHdhaXQNCj4gZGVzY3JpcHRvciBhcmUg
cHJvY2Vzc2VkIGFuZCBjb21wbGV0ZWQgYnkgcmVtYXBwaW5nIGhhcmR3YXJlIGJlZm9yZQ0KPiBw
cm9jZXNzaW5nIHJlcXVlc3RzDQo+IGFmdGVyIHRoZSBJbnZhbGlkYXRpb24gV2FpdCBEZXNjcmlw
dG9yLiBJdCBpcyBub3QgcmVxdWlyZWQgdG8gc3BlY2lmeSBTVw0KPiBmbGFnIChvciBJRiBmbGFn
KSBpbiB0aGlzDQo+IGRlc2NyaXB0b3Igb3IgZm9yIHNvZnR3YXJlIHRvIHdhaXQgb24gaXRzIGNv
bXBsZXRpb24sIGFzIGl0cyBmdW5jdGlvbiANCj4gaXMgdG8NCj4gb25seSBhY3QgYXMgYSBiYXJy
aWVyLg0KPg0KPj4+DQo+Pj4+IMKgwqDCoMKgwqDCoCB9IGVsc2Ugew0KPj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBlcnJvcl9yZXBvcnRfb25jZSgiJXM6IGludmFsaWQgd2FpdCBkZXNjOiBoaT0l
IlBSSXg2NCIsDQo+Pj4+IGxvPSUiUFJJeDY0DQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICIgKHVua25vd24gdHlwZSkiLCBfX2Z1
bmNfXywgDQo+Pj4+IGludl9kZXNjLT5oaSwNCj4+Pg0KPj4+IC0tIA0KPj4+IFJlZ2FyZHMsDQo+
Pj4gWWkgTGl1DQo+DQo+IC0tIA0KPiBSZWdhcmRzLA0KPiBZaSBMaXU=

