Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D3EC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0jn-0006of-BT; Mon, 03 Jun 2024 02:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0ji-0006kP-1C
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:00:03 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0je-00072M-OW
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717394399; x=1748930399;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+TK6Zle7ulmJBALlSA1cDnHgI2mELoDDS5fd5A1y8gs=;
 b=JNyOITLC0bZ+QTJ+l03gofKKYHBCA/Tjvgsykmvwwc/dYKZcn9xLxSZo
 5zJrplUU3+qs/zuOTHyqQyiVxUmt9EvKrYkESxN3ps2IIc62eVKNjAXYQ
 lnLoq0jHUNb4kwGB1Z9nFAHVGD8G0CYqNKMVj1HbQIH1OwG6kxxvbMtNm
 EJkupvf/Nrlm7LxILB8TavGo9E50g+Vns4NxsTSiTlPRUiDUE10OM+t+Y
 I/MNPUNxuPNjdx7EEsXiXNjvR5XqA4+dRfvCG3By2jIYvm5nsLSS1k4TS
 sMRMASv7hhZjhKugUDcK8bIw9O+Xf6RzATONMguMQwRG/Gups3AlqOQ0N Q==;
X-IronPort-AV: E=Sophos;i="6.08,210,1712613600"; d="scan'208";a="13763250"
X-MGA-submission: =?us-ascii?q?MDGgMixguMerjGSqACX2X+IceTYMDiJGIqif+Q?=
 =?us-ascii?q?3u+lMLNyNRURuoF0d1J5IbktCy2nxRfZXjBCqODzQB1+/9d8VRgbrEw+?=
 =?us-ascii?q?1Y56/b8BzJBuXTCFEIvpLiGfyLymiIhjkZuwNjIK9APNX6zm0qmCtpeo?=
 =?us-ascii?q?c68rZHSvFDVhMGzl2nxnNbOQ=3D=3D?=
Received: from mail-he1eur01lp2051.outbound.protection.outlook.com (HELO
 EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.51])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 07:59:54 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtJlj6X3Kj7KHifMbMtP+ngMwfpLuf+ZtOiB5wnVemqXqudE0pp0JE0pCFkI6vF1f/61RdDmqYjwPGnBaJsy96klGspqf1cmEJZTLQmLoL0lLOx1z4I1hM+DLIevEoESmD+5Re7JCoSB3YCrlZ3dtIpeGCOef8/dz7/DNKNB9rVPoPNuACOtBW4jVtvhLObmO8K+HjZ9Wag0kotu+9ii8LYWZuyHcZiHBoDEP00gdJcN2dc5l1M1K6cWsEquWDxnigO3irE4Pw79YRH91yJISlz15khmtFL58JncY1nbR+2hRUCdXVye6Ski96xEhGs6qLFfE9WKObTSs0o/GOI2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TK6Zle7ulmJBALlSA1cDnHgI2mELoDDS5fd5A1y8gs=;
 b=T0d77YRi/PJJVvcWxfo2jGOlAYp0edqVlh7D3M3rJPgni1WUzUgMZLxVoEGeqwupSG/6gFNxnlynizSJk6wM/UQfqO2RzqsHmqTApzMcomFb2IdFzDhrypKRRNozKvDQGzH68J0UNXF+Gv9lG3rcaT7YgeZ7tlbcp/QIovfbttai2clUuJMQk86uBetsxGcL637eC6uc1ZYv+8edFiKCoWxoOZZqcGB5agrLYrKVI3MdLpLh756si2T6NfW8rxGvwMs9tXMO0v5bsEAbfxSjf71b4LNHbxNDNkwJSPdf4UpWxK/l8XkzAorXDpxu37kNnD6bZr3MVDmoTX8kLnO7LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TK6Zle7ulmJBALlSA1cDnHgI2mELoDDS5fd5A1y8gs=;
 b=QA+t+cJcWJbTgvjg+FWc9Z821Td57b0LO2kXL76pbzO97ybXKT8jOQE8Pt0/+RzV2KtNaI3+jxYR1uX0ZsnKLOKpsrmveX5ishqjDZ7TCdFtFb5NlT/sFmibUuxYaBYB4SZvyM9G4lU7cKe0jL86eW59GkEVkb1PwOroAwyGy/3PbHNWfqbjvpVlpKeyYZB+F453sGzWvnRO2G4FdRS+pTRpnUNyCV+AJjGeEGVkTkLrgCMude9JOG3oefUPoO7BTyb6Kvs9CNUHmhcs3+RB2C5xFQeeO8MDxp6wUK9mP9DXPrsbxv7Zq0ZQoQbYDKd5gzHWpazXqyq8uPpaH78vbA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6238.eurprd07.prod.outlook.com (2603:10a6:800:136::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 05:59:51 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 05:59:51 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 16/22] intel_iommu: fill the PASID field when
 creating an instance of IOMMUTLBEntry
Thread-Topic: [PATCH ats_vtd v5 16/22] intel_iommu: fill the PASID field when
 creating an instance of IOMMUTLBEntry
Thread-Index: AQHatXs/2Kth/K+aAEGM/Noyd0IfWQ==
Date: Mon, 3 Jun 2024 05:59:50 +0000
Message-ID: <20240603055917.18735-17-clement.mathieu--drif@eviden.com>
References: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6238:EE_
x-ms-office365-filtering-correlation-id: 7fbee4b7-c0b5-4672-2239-08dc839261de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?YVp5YVNMUkNlMVVBOWhJTzh6bnUyMlU3Z0dsUzhXY3p4MTA4TWVvcy9xMWZ2?=
 =?utf-8?B?OVFXVFI1MGdnT2Vob25ydEs5YzlwZ0tQenZMcC9Bd3R3c2R5clpDT1dzQWZl?=
 =?utf-8?B?TUR4dEF3V1hQRGsrdkhDNTJQa1ZyWXZTK0ZNc25BNjZHNkQ5aDFRNUNYRHdM?=
 =?utf-8?B?ajRBbmNIOU5UZ3FVZ1AycWJIUUc2S1BxVThuT2Qrai9jOGljK2RHNTVXcEdy?=
 =?utf-8?B?SFovcUVaeC82Q3VjMXRQNzUwSUUrWVd2eU9zYkJYdG5pSDBtNDZqVDEyM1RW?=
 =?utf-8?B?MXhmSmdEVTU3WHlzeTE5MzFVR0dmSTlpUWJxR0hHamgvNEFaRlk3Y0FqY1hj?=
 =?utf-8?B?M3FwVGhiSjdMVUljZUVCaStPaGNubkxSb2J3amg0QmVBZUpNajRhVlJzaFND?=
 =?utf-8?B?T2dBUG94OFg4QjFvUVNESVlGd1pRclRQKytrMFYyV0VjcUIyaFJDVVlwc0Rh?=
 =?utf-8?B?bkpORll1My9wQ0pWTDFDd3g5bTR6c2w3UG45a1U1aGNUZ3paSEptOHU2TzJW?=
 =?utf-8?B?VkRWczJWU01wTWlNRDBtTjB5bXNaTGhUSzlSc0N0K3laWHhqa3ZKOUJmRXll?=
 =?utf-8?B?Z0NVRTltTlBmWEpjWExkc3hNaGZMMnFIdmdGeWIxRDlXd2tzd0dhTHhCSTdD?=
 =?utf-8?B?UVR4eTAvbHFLaEhXMDViZk16Z3VBN2pweVNiUHkveExORUtjd2xBOUNBQnYr?=
 =?utf-8?B?Y0ttNlhnczRHZ3VTQWI4MUJSdE5ZRFZ3aWZ3WW8wd2YzeEw5Q01tWXdJUGVX?=
 =?utf-8?B?Y21SSTdZV3ZZOFRzYWFJMS8yZWZQMGZIYjBROU9QS1l0MHFSS0k4Z1JickRF?=
 =?utf-8?B?MUhCRUFyOHpVajdoeGhGQ1QzSzlGTzRqSFFSSlljNjJsVFNvbktMRXh0clRU?=
 =?utf-8?B?NFhnWUlkOWMwSDVTRm5jd2U3dVJUajlqUG1HeHBtTS9yQmNqREdubDdUbFlP?=
 =?utf-8?B?THlWcGlQQVZCR3hmNXVBYUhscXh0REMxbS9kUVlidWk0WUM0YXVZYjBkcFIz?=
 =?utf-8?B?ZkxpZUVuNUtZcm5rbUN0LzdYR2R6aVlIbURiYi9jelhhYjVUME9wM1ZQbDU1?=
 =?utf-8?B?cUpJNGlEYWtySkZuWVJ0Ly9aUGcwVGd0cExEUGZXek90Vy9ycm1tamEyOWVy?=
 =?utf-8?B?V0RWQXNvUVlweThScnVBVmtmRVUrQ2ZITmlnK0Yvazh0YkhmL2N6NHhVU2Iy?=
 =?utf-8?B?UVNKQ0puOFR0V0NIZG1LYWluWStRTEZSUEtEbDZsanBFUlY1SU1XU3pXQ0Jm?=
 =?utf-8?B?MmY2UXFIc2Fnai92bnN1OXdzejhHM25qdW1aemdqQ2xoeGg3L1BDTjRGYmZW?=
 =?utf-8?B?ZGNlc0dyYzk2bzJGaTZSY2RzOE8xcE55SWs5eGRxVlByTCs2VlBHcnBJdmRy?=
 =?utf-8?B?cFc1ajlyZDh0YjRqM1lRenBJQ2ZzWjBnWWljT0h4VnF6eEtxYU5TUFRybDZV?=
 =?utf-8?B?dGFVL0RKMG1NV01OUURNS1M1VjhBVFV2WkozVVdQM1U5ZTlqc3RmZ2FkR3lJ?=
 =?utf-8?B?MjlKRmdOWmEzd3lVSXhOQzRBb0RFZzM0TVJtM0ZWUHFDR2ZCZGtnYmtoRm1C?=
 =?utf-8?B?bE5WcGFYbzFTS2tzRTdySkZkcjBQRXBiUERscDB4a1EwVEo2cGhOZDdWNXRn?=
 =?utf-8?B?WWRJdFl5N0t5eGpmd0pCRDlSbWpOTk1SSFNoMEVlVElhOU1Lbmo3OVQyMzRH?=
 =?utf-8?B?YVVNNE5CejJwazg3NkhLZXk4bmMvcGZDVzNScWNFQ3lqZlpLa1pMNjI4cmN1?=
 =?utf-8?B?dDlBT0RURXlFZXBscUZoMW1ZQU90MUt2RkdSTS95OVZ4QUsvb0FYaG1VRzNk?=
 =?utf-8?B?NFl0SUt2SDNlKzViY1dDZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkJEWGMxZWlUbnYxbzBYYmhTQkdObUp1UzFENXdmaEd3cWZma2F5YVpZdFkr?=
 =?utf-8?B?VndyditLbnlHbmhONlRjT2tiZVZXVmZFd1pDRlZTeWdLcjY1L3QxSGEreTVR?=
 =?utf-8?B?NDB4c2h0cTVXTkNKejBoR1lzK2d5d0R2ckZtSmFVVisvY2FGSVkzM2t5ZTli?=
 =?utf-8?B?YXp6ZThOYUhHZk5iQmZEYVNaZGdCNmNyMDMwaVVSVkdCZlhIWE85NnNEdGdM?=
 =?utf-8?B?ak0yQVFtQmladXZyblQ3VWpDVm1ldFRYMzZQYlpsTjNiSnVrdGgxMityd0E2?=
 =?utf-8?B?eEdSTDJQb2hkMDVaVmJMakFkdnh2MHdJdXNEU1NKTzNNMTF4WWlyMFN5VWc4?=
 =?utf-8?B?L20xeCtObEdiaGx4clMzMmt1ZkRzR2htb2NPU3hQNHpJcUphMGtlWDc0Zzd4?=
 =?utf-8?B?VzJ2NE14VzNacnRmaklzbTFwQ1k2bG5PTU9TR2RTVEhIaWRMTTFVcVZyeXpK?=
 =?utf-8?B?a0dLTUUwQlBIK284dzVsMlptNWxyUlQ2Sm9yQkdTT3hEUm5JTnhIKzNaVGxY?=
 =?utf-8?B?RGlyN0RPUFlkaTB5TjNsckw2bW43SGIrVHVUR2ZsRE5OcGM1d3N6OHpuWFFa?=
 =?utf-8?B?cjlheHNrQTBPQlRiT3RHKzlaSCtUTUxqSGpyL1huK0dKMHFCL3V0OWorYito?=
 =?utf-8?B?dGhYdTZhd1JQT1BJWks5WlF4YjM0azVKVlhLenBoWUU1MXhWMTNMU0owbnJk?=
 =?utf-8?B?em0wVE55c2xvby9Wam82VkFpbWhyVXBWQjNxV1BSUHVDSFNBMm5WVXBMb01p?=
 =?utf-8?B?RFZLejE2U3RKTmExRWM0Qk9jSzM3bEJEQ25PZUU4VmxiZVh4U0NmVFJsQm9a?=
 =?utf-8?B?MnVwVWgvZkprV2lZc2xBaUgwT2Q3aUZTTlhmVXpmRDg3ME5TSk9Tekc2anBL?=
 =?utf-8?B?em5rVUs0Si9FdWNBZm9NMDJHWGh6bHp3U05ZYWkrdXVlckxPNkNHTWF3UGIr?=
 =?utf-8?B?cENydWtBR3gwUjRpU3llSGJEUDZaSTVhOUtmK3hLWUJ4UExDOU5sWHo0RWZG?=
 =?utf-8?B?TnY2OGI4NVh2YWxrRlFnNUkwdTdzUER0SzBaamJ1cyt3azhTYUFBR0F1WmRT?=
 =?utf-8?B?cG1Sbi9mdmRCUEV4dlY5SFpWaU52UlZROXQxMUlTVFdYbHg4VFp1OGdGRC82?=
 =?utf-8?B?Qy9COEZQSldtdmZwNm1qYTdQZWtpVlZRZnp2NXZDWlE4ZGNJVG41QXJ4eGpt?=
 =?utf-8?B?RnNhYm5ZWHFIcCtZU3FQWTd3OVVnYlJtZXptMjl3RWZpYUxLcURucFoyWCsv?=
 =?utf-8?B?NFNuRWRSa1ZGN3hvelFzbDluUzhzZTAwMjU4bEkwenp6U2doeGpCMnQ0TFpz?=
 =?utf-8?B?NG02K2VGek80czdFT2xhOWRlcTBqTmRDYnhMUXh6UjQ4WWFFSUR4WVd3VC8y?=
 =?utf-8?B?bG5aemJyTHp1SUJXSDBsUzlTK1VaMUVlZVBHNUNrN0dkc3pFWXRKMGpvcFAz?=
 =?utf-8?B?ZWt6Y3U3UnlwWStPUHNFY0V5bUROajNRRE03WFVuZ3gwZ1lNem5XbWxGckxw?=
 =?utf-8?B?RTBoalJpc3huNG9DVFQvMGJCc0N2aVc5cmROWjh0bVV0TnFZS0h1bWZuL1ls?=
 =?utf-8?B?Q21pMFNnQVhvdCs1d0lBU0ZZNjVkYUFLa3pMOWpsODQ5ZTlYekZ3MGZlS095?=
 =?utf-8?B?S2FHVXd2UUxBRHBtWWN4MVhFTUdjaDVSQ0h0RGFVZjRFMWhuOGJsc010UTgr?=
 =?utf-8?B?ZWk3K1prbFZCMVdDU1EwMTdRZWhkVnZNSjRVZ012anFhN04zTDVmeGlDckZp?=
 =?utf-8?B?QUFJc2hwMFBzR0kwOWNCTXNLVkJkL2h1ZzZEelFQTE0zMk1nVGM5Zk1rdCtV?=
 =?utf-8?B?SDZ5OUNrTjgwTXQ5a3l3TDZVK1l3dXRaaDB1bkEzdElQcjhmMGEyQXpMVzYw?=
 =?utf-8?B?c3BpTkNSWER6U2hHbWlTa3FWbnRGeWJrajllN0haM245ejB6K3QydFpKeTQ1?=
 =?utf-8?B?QVltdEE4TjlLa2dLYm5zVmdRYnN6cWNTSWNXQ0lwVTMzdVRKQ2xQemxiSE13?=
 =?utf-8?B?NWcyUUs0S2hCRElHZkZJVytERC9DdDk1aEpoTml3c2wzWVFzVWtyOHpoemxD?=
 =?utf-8?B?S2dGRVV3VDFZaUxaV0IxU1FOdFBoT2tFZXhBb0lIWkhFSXRMSHV0OUxYWjF2?=
 =?utf-8?B?MUo4Q2lvSTNBK2RqM3VBTVVoR2xNMnpqRXplU1hpM1dUQVQ4WitJSzgxTHlJ?=
 =?utf-8?Q?ohDnubiTKYJ0VI0ma7CClWo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75FDCE7FCD68974EB147B07684E386D3@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fbee4b7-c0b5-4672-2239-08dc839261de
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 05:59:50.9736 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t34jhuhY3EBOzJzT+sibbaNyxgFyteWcy8wOzizkDvu49sKdCtPrZWQY9LKf48cCLrqNQbawJWQ6c4KZCODYhC+pksesYx+yWi85yt0WpHSBjaMRlwWSOmPXX3Goi+6I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6238
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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
bi5jb20+DQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQu
bWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwg
OSArKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1n
aXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCmluZGV4
IGQ2MDc1NjJkZTIuLjBmM2JkNTk3OGUgMTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11
LmMNCisrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KQEAgLTIxODcsNiArMjE4Nyw5IEBAIHN0
YXRpYyBib29sIHZ0ZF9kb19pb21tdV90cmFuc2xhdGUoVlREQWRkcmVzc1NwYWNlICp2dGRfYXMs
IFBDSUJ1cyAqYnVzLA0KIA0KICAgICB2dGRfaW9tbXVfbG9jayhzKTsNCiANCisgICAgLyogZmls
bCB0aGUgcGFzaWQgYmVmb3JlIGdldHRpbmcgcmlkMnBhc2lkICovDQorICAgIGVudHJ5LT5wYXNp
ZCA9IHBhc2lkOw0KKw0KICAgICBjY19lbnRyeSA9ICZ2dGRfYXMtPmNvbnRleHRfY2FjaGVfZW50
cnk7DQogDQogICAgIC8qIFRyeSB0byBmZXRjaCBwdGUgZm9ybSBJT1RMQiwgd2UgZG9uJ3QgbmVl
ZCBSSUQyUEFTSUQgbG9naWMgKi8NCkBAIC0yMzA0LDYgKzIzMDcsNyBAQCBvdXQ6DQogICAgIGVu
dHJ5LT50cmFuc2xhdGVkX2FkZHIgPSB2dGRfZ2V0X3B0ZV9hZGRyKHB0ZSwgcy0+YXdfYml0cykg
JiBwYWdlX21hc2s7DQogICAgIGVudHJ5LT5hZGRyX21hc2sgPSB+cGFnZV9tYXNrOw0KICAgICBl
bnRyeS0+cGVybSA9IGFjY2Vzc19mbGFnczsNCisgICAgLyogcGFzaWQgYWxyZWFkeSBzZXQgKi8N
CiAgICAgcmV0dXJuIHRydWU7DQogDQogZXJyb3I6DQpAQCAtMjMxMiw2ICsyMzE2LDcgQEAgZXJy
b3I6DQogICAgIGVudHJ5LT50cmFuc2xhdGVkX2FkZHIgPSAwOw0KICAgICBlbnRyeS0+YWRkcl9t
YXNrID0gMDsNCiAgICAgZW50cnktPnBlcm0gPSBJT01NVV9OT05FOw0KKyAgICBlbnRyeS0+cGFz
aWQgPSBQQ0lfTk9fUEFTSUQ7DQogICAgIHJldHVybiBmYWxzZTsNCiB9DQogDQpAQCAtMzY3Myw2
ICszNjc4LDcgQEAgc3RhdGljIHZvaWQgdnRkX3Bpb3RsYl9wYWdlX2ludmFsaWRhdGUoSW50ZWxJ
T01NVVN0YXRlICpzLCB1aW50MTZfdCBkb21haW5faWQsDQogICAgICAgICAgICAgZXZlbnQuZW50
cnkudGFyZ2V0X2FzID0gJmFkZHJlc3Nfc3BhY2VfbWVtb3J5Ow0KICAgICAgICAgICAgIGV2ZW50
LmVudHJ5LmlvdmEgPSBhZGRyOw0KICAgICAgICAgICAgIGV2ZW50LmVudHJ5LnBlcm0gPSBJT01N
VV9OT05FOw0KKyAgICAgICAgICAgIGV2ZW50LmVudHJ5LnBhc2lkID0gcGFzaWQ7DQogICAgICAg
ICAgICAgZXZlbnQuZW50cnkuYWRkcl9tYXNrID0gc2l6ZSAtIDE7DQogICAgICAgICAgICAgZXZl
bnQuZW50cnkudHJhbnNsYXRlZF9hZGRyID0gMDsNCiAgICAgICAgICAgICBtZW1vcnlfcmVnaW9u
X25vdGlmeV9pb21tdSgmdnRkX2FzLT5pb21tdSwgMCwgZXZlbnQpOw0KQEAgLTQzMjAsNiArNDMy
Niw3IEBAIHN0YXRpYyB2b2lkIGRvX2ludmFsaWRhdGVfZGV2aWNlX3RsYihWVERBZGRyZXNzU3Bh
Y2UgKnZ0ZF9kZXZfYXMsDQogICAgIGV2ZW50LmVudHJ5LmlvdmEgPSBhZGRyOw0KICAgICBldmVu
dC5lbnRyeS5wZXJtID0gSU9NTVVfTk9ORTsNCiAgICAgZXZlbnQuZW50cnkudHJhbnNsYXRlZF9h
ZGRyID0gMDsNCisgICAgZXZlbnQuZW50cnkucGFzaWQgPSB2dGRfZGV2X2FzLT5wYXNpZDsNCiAg
ICAgbWVtb3J5X3JlZ2lvbl9ub3RpZnlfaW9tbXUoJnZ0ZF9kZXZfYXMtPmlvbW11LCAwLCBldmVu
dCk7DQogfQ0KIA0KQEAgLTQ4OTYsNiArNDkwMyw3IEBAIHN0YXRpYyBJT01NVVRMQkVudHJ5IHZ0
ZF9pb21tdV90cmFuc2xhdGUoSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11LCBod2FkZHIgYWRkciwN
CiAgICAgSU9NTVVUTEJFbnRyeSBpb3RsYiA9IHsNCiAgICAgICAgIC8qIFdlJ2xsIGZpbGwgaW4g
dGhlIHJlc3QgbGF0ZXIuICovDQogICAgICAgICAudGFyZ2V0X2FzID0gJmFkZHJlc3Nfc3BhY2Vf
bWVtb3J5LA0KKyAgICAgICAgLnBhc2lkID0gdnRkX2FzLT5wYXNpZCwNCiAgICAgfTsNCiAgICAg
Ym9vbCBzdWNjZXNzOw0KIA0KQEAgLTQ5MDgsNiArNDkxNiw3IEBAIHN0YXRpYyBJT01NVVRMQkVu
dHJ5IHZ0ZF9pb21tdV90cmFuc2xhdGUoSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11LCBod2FkZHIg
YWRkciwNCiAgICAgICAgIGlvdGxiLnRyYW5zbGF0ZWRfYWRkciA9IGFkZHIgJiBWVERfUEFHRV9N
QVNLXzRLOw0KICAgICAgICAgaW90bGIuYWRkcl9tYXNrID0gflZURF9QQUdFX01BU0tfNEs7DQog
ICAgICAgICBpb3RsYi5wZXJtID0gSU9NTVVfUlc7DQorICAgICAgICBpb3RsYi5wYXNpZCA9IFBD
SV9OT19QQVNJRDsNCiAgICAgICAgIHN1Y2Nlc3MgPSB0cnVlOw0KICAgICB9DQogDQotLSANCjIu
NDUuMQ0K

