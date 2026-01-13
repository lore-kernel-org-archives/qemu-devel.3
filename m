Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067FAD29DE6
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 07:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfZ84-000197-Kz; Tue, 13 Jan 2026 02:47:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfZ83-000177-22; Tue, 13 Jan 2026 02:47:51 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfZ81-0000qQ-4j; Tue, 13 Jan 2026 02:47:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHrIsjUm7NRzkHJM7Lex7/3UxoLxoZ4jjlk3SmicpJ/J5zF8klNqZnp7P67p0GgFF+ulXLg6zD+mR62dM82Oa3g9ueaZic/MpiTJ+sJg4NvLPtuMW3xhQmCQ/sJQxU/4Cvnoa0EZvY4ofihMpyr3VJ5AJ5BtK8Y95HTV0pHDqckF26xOe0wAhEWtquu+jKMFNXObMriLP4RIqcKS7CF14yXxO/gSFp+SPcamEFZydxqbHGKNdwa48H4q+4PztY+vsWRSoMsvu2/z7VjB8W9R0Bfdp4eBIhYqQIK7oFq3gkHrc7Rrmh6qGt1dC+yYihDx39drfzfbkSQ50vqfqbpEKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbTcz+mFKIQeXNiOushUeCTqegIQyvBvo4qMSStE6+8=;
 b=Wc8KPlfCHeqEgg9O4o+DxtDlKMTyzHZXvWSGYuvnsL52dzdbeYurBe0k6Em02BCE1odHAYvIpAVOEiyPWYPeHPiU0nMu18wfgjgZrlsovWmsdZ/6e9BQIfV8AsObOFlNhetOGGWr5o73+cJqvc0W6hZ9ix3wI2o6r+vTfNT7qZAqy7/IQR/a6mBhzzBZ/EEg4HEDmE7DM5YXghzVaduUkEmM1XBTjOmh7qHlo3kksCUel7GJ1d7oGB4t2zGiIRZW2AKpqQHkRStkbDtfFFNY/Sws6rAEkK+az6N+GSooHScSr4PC1JoZARUZ9sZniWtf4rtUto2tJuz4dcLHti1NXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbTcz+mFKIQeXNiOushUeCTqegIQyvBvo4qMSStE6+8=;
 b=lJuLkqm+ANpVHyjEQc3JiEaK0fTssrTfFxfqXJ7kInKEJoUYh88zMGHIC/pVAfDMmRztpyUk3Fte06Kg0p+UBvcjb8tAVqBL+OzKEYe1dXmUzBco0EVRhZZ6VQBoz2dmjuo6K7s0lF2R3M4toBogcakDFxCwvuR2nG6ZVepFbdpyP4kRwZsdyrOfeHxDd1agCU/bP/OtNNpOg8FVRx2eLOOGp9gFsSG/Vu3eVCGcXrf2pJJUxdmS9cQMfmiRQny3jXFCMw16pn8xT659sGIZ8EUwIf1GNPhSi5mCTP9OOoV5Z+unOT7T6psBwNnnEhkLxQ0PrvggU2plKVf/15LxGQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 07:47:44 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 07:47:44 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "cohuck@redhat.com" <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt
 Ochs <mochs@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
Thread-Topic: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
Thread-Index: AQHcc0r/PShlE7i9HkafE8JAYPcnrrVOYYGAgAFwNhA=
Date: Tue, 13 Jan 2026 07:47:44 +0000
Message-ID: <CH3PR12MB7548771111FF5AC450CB8721AB8EA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251222135357.143339-1-skolothumtho@nvidia.com>
 <20251222135357.143339-4-skolothumtho@nvidia.com>
 <af8904cf-cce9-476f-be8a-34a85668cdb3@redhat.com>
In-Reply-To: <af8904cf-cce9-476f-be8a-34a85668cdb3@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA1PR12MB6460:EE_
x-ms-office365-filtering-correlation-id: d3cfed7a-e977-403b-5877-08de52780977
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RDBvQU9FdURkOENLTEMvSkFKeTFxWWcyMnpldlpFMzRvdnQ2dlhrQXdxL0Y4?=
 =?utf-8?B?SFFFNG5uK2tBbFBheFpLSU5PTGxEZ1lFZDVTRnVJTEpRb0M4eXNKamxzSHRv?=
 =?utf-8?B?T0lJS25mN1ZNNCtCNm5JSWcreFBUR2l6amM5Z0g2L3paRWt5YnJaVzRpY3JD?=
 =?utf-8?B?TnVlSGNpWFpaTXkwTmNFTW5mZGkyL2hTWjhRZ0JjVWlLOHRib2lJV0JIcUdk?=
 =?utf-8?B?SGhxNCtGZ05haFBjcXg2MTh3cytSOTdNTEZpNXQ0VUR2RFpkRmxOeEZGdytV?=
 =?utf-8?B?QUhPNU1IaERSWGdwQTJsNDRYazdzVm0rVzV6MXcrSXRVdkQreXB0SURDV1dG?=
 =?utf-8?B?OE1oM1ExanVxNTc0c21jUTcxUW9kSFRQdjdaZ084TmFqT2JmVHIxWWtSRk5m?=
 =?utf-8?B?RElnRy82dHk2TjVTd1psNnNtb2RCeVFJZ0pCK0M4Y3ZzNFJMRVhWeDFpNHRz?=
 =?utf-8?B?dnJ6MGhaanFvWC9MR0dycVczS3VvN0tpUjI3b1BDaDZqcW44VGxQYXhXc2xt?=
 =?utf-8?B?WmYvWnhuUTgwcnQwemNua2dCNnI0WWk3ME44d0RZSTBybW5LUE14a0FlZXBp?=
 =?utf-8?B?YlRJK01qdlUwNXdZMktKS0JQWWQ2dEpXRG9HK2lOdi8zWnRzbVRKRG1tWGln?=
 =?utf-8?B?bnFRNUd3U2NxMjc0T3k3NzU4RzZMLzVyblRMMmFITU40T3g4ckx6NE5uUk9K?=
 =?utf-8?B?VVd3dmdzZ0doemNxQm5DMEo2LzlaTnZ0Zml2TzVPZVM4cVl6ZHBjdzVLSXZV?=
 =?utf-8?B?TGQ5OGtVNWZCdU0yLzFCM21SNjM5V1JxeWNxa0NTdmR3N2xqUXlCSEVYdGI3?=
 =?utf-8?B?THMxb0ZNSFd4b1pRN21UNHN3Z3FRYzRoZXludGoxaHpxeWpNK2M4dmZKQk9J?=
 =?utf-8?B?bERROUJKMmhUemNxVHVLVGJGNUovczZ3ODhwaWhkUmJOS2ZQYnJJOTdNemJt?=
 =?utf-8?B?TjVTc285bVpjdythbEljRU5OTUpZbjEySkF0ZER0RzJtL3gyMDBwdXAxSXQ5?=
 =?utf-8?B?REFVVHVwdUM5VnEwak9RQ1JiS0RLbkoyUFF0ckZJaWtiVTc1aDJIaEp3OXI2?=
 =?utf-8?B?UlpSYmxLSHVnb1AxOHlyeGhFQ0NiVDcyQ3lmQ0c3VllxMmhhelNqRjA4Mk54?=
 =?utf-8?B?bnRNU3FtUnpUNmxaZXhpR0NUU0pPMEJjekk0bmpzRFdwK1VCL292OXMwZTJj?=
 =?utf-8?B?Z0txMkRsdmVLcjVQNEpBYkJjZUk4bVY0Zkhqc3Q1eXpBZnVXRW54dW9wTmZP?=
 =?utf-8?B?NTlFUWhJYnU3MXd6YU5JMXRCamwwMkkwSjI4T1RCM0VxREdrclhPcHJMZVdj?=
 =?utf-8?B?YWgvWGkxdnVEQVg2NHAwemx6MFoyL2dVVW9mR0FyTWNoeGhtZXZrdDVnRXlI?=
 =?utf-8?B?OXE2M20zOXk5Q2hndFEzNGEyenpBeTV0ZmpRSko5ZHl2U256Wjdac3FrYVhr?=
 =?utf-8?B?bEE1Yk8rZi9iMFVQenZCdlcyVktkYXQ0dEl5bW5iM3JTTDA3UkswUGtMV3hy?=
 =?utf-8?B?STZOaCtGbmNwdkJsbTNaYjlWbmxxWGRqVFpLcVRpU2tpK3B5cXRVbEFPOWM1?=
 =?utf-8?B?cS9lRDRYM09IS1gxVVpkeW5rVDJsU0tHd2MxMUpaR2lDUzhadlBRRnozdG5j?=
 =?utf-8?B?Qk93U29aUVFyWmJ5NUtXWk5uYm9QN21VNWJCSWVyYUhpL2JRSjBFMitwR1N4?=
 =?utf-8?B?c0NEK2cyS1pCOTZZNGZpM1hHdUZXNS9PSDZ2Snh1QWFITm1WeFFQTTlRb1J4?=
 =?utf-8?B?akEydFQrNmlpbytUaEcvZU1kV0JTL3JUVmNxMFBUNC9pSUxleGFuWVFOMzRM?=
 =?utf-8?B?WnQrWEpHYmEyckFyZlJsT1d2Z1BWU1U3dUkrODJNczN1U05pNjh5OXhFa1JL?=
 =?utf-8?B?Z0hFQkxBbGNaNzVoZnNyUmVLdFlHZHdqRE9GQWhJcWU1YnFkdG1vbWhpeHJh?=
 =?utf-8?B?cm51WHlCUG1qM2FRa0gwWXRtelF1ZS9qSmp5Wkpqd0UyOVF6aVVobk5zY21H?=
 =?utf-8?B?V1ZBa2pPcmJMemJoNXllZHMyV09JcXorUGR0VmZMTVFRbkRob002WmptRUtq?=
 =?utf-8?Q?xbccOC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmNwUStaeW9KeDl0OUFydHFKa1huMDRrcjlka2dVK2xUTW9zTTdKS1Z6ZSts?=
 =?utf-8?B?RWFZNjYrOFNwUXM0RmRVUnBrZFJiZnpzOWRENWdFb3kwSitnWXA0aEJOMVp2?=
 =?utf-8?B?dWVxWnc0WWhhNzZ3ZXBSYnR6TXg3T3I2MHoxL2Y4WjdudkdLV2tRUWpNakZ0?=
 =?utf-8?B?bVVTT1kyVUhUSzNCOEY3UFJ5a0RQWlAxcG15M0hCcWdSNEZ3THMrVzZTYk9v?=
 =?utf-8?B?OE1FLzZ1elg0SUxXSE5UTnBsTjRjNVVKM1V6VUNTWFcyV0JOdlkyYmoveUVW?=
 =?utf-8?B?SlkzVWlnMmxjdElHQU50Z01UOTRaUmNPY2RXRCtJMjRMZCttYlc2LzhnWEts?=
 =?utf-8?B?SXVMdE1lbVdKMUM2dUdoczEweWs4RDJjcnVBQWZDTjVvTVFJNVk1TkV5bkZ5?=
 =?utf-8?B?amJJUXNWUmJHMG9wcC9tdmh0WkNyVEQ0V2Z4Wkp1UnpYUEplcngxQlNIMFFM?=
 =?utf-8?B?RFl0bWNpTHNmU0pQY0hrdEdTVlVYYnN3ZEtmM2swUmlhVWJCeGxVVElCZUNE?=
 =?utf-8?B?Y0F3allGVDdPSmo3SkozVE9zTmlxdm9UK05FcnU3L2dGenJHb0UvcU5kVVFN?=
 =?utf-8?B?cnp4MFpITlJQamNZdzk0M1RBc1pFYW5vV0NpYlRselZ5NWR3UkJQVHRHOUhG?=
 =?utf-8?B?QmlIUFdXdy85QU5haGhPdElsRmU5UTJXYldIbURRdm4yaU1QNjFrbGRaZW5W?=
 =?utf-8?B?b25jYkVLRjBvSm05cFJxYXFwK1NCRUREam5aQys3Yk1HbEtxRVhNSEtDTmkx?=
 =?utf-8?B?amtiOEZLQ1V6eVR4cHJQUDdyZzdIZ3JwMkR0ZDBCWFAvZkdmUHY1SXNXaVNX?=
 =?utf-8?B?aFBkbGpTYko5dGNPUWJaanZnYTdpNjArV2o5OUF0UWFuSlY0Z3ZmVmNVVmRK?=
 =?utf-8?B?MWsvZjljbjhiQVVaREN3RjQ3Z29MaW9RUWVzeEFHOG02V0JhZ3M1Nk40eUZV?=
 =?utf-8?B?NlZXb2VJQ1FlNkI4ZFhLUFpORDhWV1ordjl0bGZVelNSZW1kK3ZnRFpsV2ly?=
 =?utf-8?B?MEMyWktMYW9PaExUanlIWkEwb0xQcVhxaXRnOVhMQ0RielM3Tnd2KzlVcE14?=
 =?utf-8?B?TzZ2RldpNG5qTXNjSUpLaC9BUm9GMEkrZnFla3YraVRiS3VwQkl6cTlnSFhj?=
 =?utf-8?B?NzhXYXVYakpDRGdVaGdraFRHVDBqa2x6SGV0ZE5tb0ZWYVZkVGU0alVoZEZr?=
 =?utf-8?B?Nm54QW5CWDFPSU1MR1pRRGxoUGlZQmRJeEN5MVBJY2NndERoNDNNdGgyK2tH?=
 =?utf-8?B?eHp4UThEeDdhTGtJaVlBQkRHd3d5Rmk0K0tOUkFNUnNXbTlsWVRaMGgvVmlT?=
 =?utf-8?B?cTkyL21iak5kMHBJWVUvSnJpaXpsVFRBMENlR2p4VFpwTzljT3ZnaDhmTi96?=
 =?utf-8?B?SUpUTXlCZHFWcWVSQVpRUG1jb0srVEZ6UWFqOXFrV2ExN2RZc1Y4UldKWi9O?=
 =?utf-8?B?amcrdnc5V01tRjlla3pmS21GR2dKdkJHNDBQakRYVGphMTIwbjdiYUFyRU9i?=
 =?utf-8?B?WmRjZ1IwQ3NTcHVFYlVhVCtqd29abHgyZlhZM2FoVTdNT0FaeDZBMGdLUk5z?=
 =?utf-8?B?MUlKQXlRb2lVZVA4aTdsWE9iUXc1anQ3N1J4YSsvdmxnWkhXRlB0UkliRlA3?=
 =?utf-8?B?TnRVSG0wd2IwVWV1ZXg1OWt6azEyQVNyanFURmt2YVBuSXpYdXJRU1FBaGcy?=
 =?utf-8?B?K0hOa01aM3E1YjVVVEtKcVJQVWNObitGY3hsZ01rNFZwWWlQQ1FaQ3gxZ2lt?=
 =?utf-8?B?U3hiL3hyVkV0MFZCbUhxdngyWjREcGNrcDRTL3dmanRiSGVpaDNUTDBoYmM5?=
 =?utf-8?B?d2ZHclBXTGV5ajJoNnBYYjVuKzdBZVN3dEtpcW04YUVVc055M1JwRVlnbk5q?=
 =?utf-8?B?MHoyRUxTb05peHYyTmJvTXBuSDM2dWdNUkx6bnBoTlVSQ1pEUWtWR3kxQlAr?=
 =?utf-8?B?ZGRtUzV6Y2JicEpvSG4wSWozV0Z1elErUEhwNVh5bktjdGR4UXdOYlVveTIy?=
 =?utf-8?B?Y05vSW9LRWlkTHRXQ0dwTmUzV3dCQnFXWE55cWJKY2tvbWtuVFBjTnBBNWtC?=
 =?utf-8?B?b1NyRStQdTIrSUdkNUY3OFdZNldFTkhBaHlXRDFUWldIdnpYdGVxYTNnRHY1?=
 =?utf-8?B?ai8wUGNwOEVNN1p2YkFYeTR3ZGJuUldPaEx5d3NkTGZZbnQzc1l4UDdOSGhk?=
 =?utf-8?B?WFhQVTMxTkRha1dEQ2pqc2dCVmN2b0FPRXNLdzI1SG9WZlZXNENxSENyeU5P?=
 =?utf-8?B?Mzh3bDhabXB0TCtCdVVaalpsMFIvcy91UXRGQ1QzVXBuNzg2WmRZUGdHeXNr?=
 =?utf-8?B?UXVGSzdxRmpuZWpGbEsyVGNvSU1wa2Ziam5Mb0lkSHFjNmRrZ3piZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3cfed7a-e977-403b-5877-08de52780977
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 07:47:44.1417 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T6uIxBJ57Bf1S46PPwNIPMSB1yNf0X1iTwEEgTV44t7ACKTHBL3GJLmIdd78TYw6o289HSf2UVjNJU5fgp/wdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6460
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDEyIEphbnVhcnkgMjAyNiAwOTox
Ng0KPiBUbzogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11
LQ0KPiBhcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBhbGV4QHNo
YXpib3Qub3JnOyBjbGdAcmVkaGF0LmNvbTsgY29odWNrQHJlZGhhdC5jb207DQo+IG1zdEByZWRo
YXQuY29tOyBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4gQ2hlbg0K
PiA8bmF0aGFuY0BudmlkaWEuY29tPjsgTWF0dCBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsgSmFz
b24gR3VudGhvcnBlDQo+IDxqZ2dAbnZpZGlhLmNvbT47IEtyaXNobmFrYW50IEphanUgPGtqYWp1
QG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8zXSBody92ZmlvL3JlZ2lvbjog
Q3JlYXRlIGRtYWJ1ZiBmb3IgUENJIEJBUiBwZXINCj4gcmVnaW9uDQo+IA0KPiBFeHRlcm5hbCBl
bWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+
IEhpIFNoYW1lZXIsDQo+IA0KPiBPbiAxMi8yMi8yNSAyOjUzIFBNLCBTaGFtZWVyIEtvbG90aHVt
IHdyb3RlOg0KPiA+IEZyb206IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4g
Pg0KPiA+IExpbnV4IG5vdyBwcm92aWRlcyBhIFZGSU8gZG1hYnVmIGV4cG9ydGVyIHRvIGV4cG9z
ZSBQQ0kgQkFSIG1lbW9yeSBmb3INCj4gUDJQDQo+ID4gdXNlIGNhc2VzLiBDcmVhdGUgYSBkbWFi
dWYgZm9yIGVhY2ggbWFwcGVkIEJBUiByZWdpb24gYWZ0ZXIgdGhlIG1tYXAgaXMNCj4gc2V0DQo+
ID4gdXAsIGFuZCBzdG9yZSB0aGUgcmV0dXJuZWQgZmQgaW4gdGhlIHJlZ2lvbuKAmXMgUkFNQmxv
Y2suIFRoaXMgYWxsb3dzIFFFTVUNCj4gdG8NCj4gPiBwYXNzIHRoZSBmZCB0byBkbWFfbWFwX2Zp
bGUoKSwgZW5hYmxpbmcgaW9tbXVmZCB0byBpbXBvcnQgdGhlIGRtYWJ1Zg0KPiBhbmQgbWFwDQo+
ID4gdGhlIEJBUiBjb3JyZWN0bHkgaW4gdGhlIGhvc3QgSU9NTVUgcGFnZSB0YWJsZS4NCj4gDQo+
IEkgdGVzdGVkIHRoZSBzZXJpZXMgd2l0aCB1cHN0cmVhbSBrZXJuZWwgYW5kIHlvdXINCj4gbWFz
dGVyLXNtbXV2My1hY2NlbC12Ni12ZXZlbnRxLXYyLXZjbWRxLXJmY3YxLWRtYWJ1Zi12MSBicmFu
Y2gNCj4gDQo+IEl0IHdvcmtzIGZpbmUgd2l0aCBHcmFjZSBIb3BwZXIgR1BVIHBhc3N0aHJvdWdo
LCB3aXRob3V0IGNtZHF2LiBIb3dldmVyDQo+IHdpdGggY21kcXYsIEkgZ2V0DQo+IA0KPiBxZW11
LXN5c3RlbS1hYXJjaDY0OiB3YXJuaW5nOiBJT01NVV9JT0FTX01BUCBmYWlsZWQ6IEJhZCBhZGRy
ZXNzLCBQQ0kNCj4gQkFSPw0KPiBxZW11LXN5c3RlbS1hYXJjaDY0OiB3YXJuaW5nOiB2ZmlvX2Nv
bnRhaW5lcl9kbWFfbWFwKDB4YWFhZWE2ODQ3MWIwLA0KPiAweGMwOTAwMDAsIDB4MTAwMDAsIDB4
ZmZmZmI1YzkwMDAwKSA9IC0xNCAoQmFkIGFkZHJlc3MpDQo+IHFlbXUtc3lzdGVtLWFhcmNoNjQ6
IHdhcm5pbmc6IElPTU1VX0lPQVNfTUFQIGZhaWxlZDogQmFkIGFkZHJlc3MsIFBDSQ0KPiBCQVI/
DQo+IA0KPiBNYXliZSB0aGlzIGlzIHVucmVsYXRlZCB0byB0aGlzIHNlcmllcyBhbmQgcmF0aGVy
IHJlbGF0ZXMgdG8gdGhlIGNtZHF2IG9uZS4NCj4gDQo+IFdvbmRlciBpZiB5b3UgZ2V0IHRoZSBz
YW1lIHdhcm5pbmcsIGFuZCBpbiB0aGUgcG9zaXRpdmUsIGlmIHRoZSByb290DQo+IGNhdXNlIGlz
IHVuZGVyc3Rvb2QgYW5kIG1heWJlIGZpeGVkIGVsc2V3aGVyZS4NCg0KWWVzLiBJIGNhbiByZXBy
b2R1Y2UgdGhpcyB3aXRoIGNtZHF2IGVuYWJsZWQuIFRoaXMgaXMgdHJpZ2dlcmVkIA0KZHVyaW5n
IHRlZ3JhMjQxX2NtZHF2X2luaXRfdmNtZHFfcGFnZTAoKSwgd2hlbiBRRU1VIHNldHMNCnVwIHRo
ZSBWSU5URiAvIHZDTURRIHBhZ2UwIG1hcHBpbmdzLg0KDQpJSVVDLCB0aGlzIGlzIG5vdCBndWVz
dCBSQU0gYW5kIHRoZXJlIGlzIGFsc28gbm8gZG1hYnVmIHN1cHBvcnQgZm9yIHRoaXMNCm1lbW9y
eSBpbiB0aGUga2VybmVsLCB3aGljaCBsZWFkcyB0byB0aGUgSU9NTVVfSU9BU19NQVAgZmFpbHVy
ZS4NCkFGQUlDUywgdGhpcyBtZW1vcnkgcmVnaW9uIGRvZXMgbm90IHBhcnRpY2lwYXRlIGluIGRl
dmljZSBETUEgYW5kIGRvZXMNCm5vdCByZXF1aXJlIGFueSBJT01NVSBtYXBwaW5ncy4gSGVuY2Us
IHdlIGNhbiBpZ25vcmUgdGhpcyB3YXJuaW5nIGZvciBub3cuDQoNCkkgd2lsbCBsb29rIGludG8g
dGhpcyBpbiBtb3JlIGRldGFpbCBkdXJpbmcgdGhlIG5leHQgdkNNRFEgcmVzcGluIHRvIHNlZQ0K
d2hldGhlciB3ZSBjYW4gYXZvaWQgdHJpZ2dlcmluZyB0aGlzIHdhcm5pbmcuDQoNClRoYW5rcywN
ClNoYW1lZXINCg0KPiBUaGFuayB5b3UgaW4gYWR2YW5jZQ0KPiANCj4gRXJpYw0KPiANCj4gDQo+
IA0KPiA+DQo+ID4gSWYgdGhlIGtlcm5lbCBsYWNrcyBzdXBwb3J0IG9yIGRtYWJ1ZiBzZXR1cCBm
YWlscywgUUVNVSBza2lwcyB0aGUgc2V0dXANCj4gPiBhbmQgY29udGludWVzIHdpdGggbm9ybWFs
IG1tYXAgaGFuZGxpbmcuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOaWNvbGluIENoZW4gPG5p
Y29saW5jQG52aWRpYS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bSA8
c2tvbG90aHVtdGhvQG52aWRpYS5jb20+DQo+ID4gLS0tDQo+ID4gIGh3L3ZmaW8vcmVnaW9uLmMg
ICAgIHwgNTcNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0N
Cj4gPiAgaHcvdmZpby90cmFjZS1ldmVudHMgfCAgMSArDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwg
NTcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3
L3ZmaW8vcmVnaW9uLmMgYi9ody92ZmlvL3JlZ2lvbi5jDQo+ID4gaW5kZXggYjE2NWFiMGI5My4u
Njk0OWY2Nzc5YyAxMDA2NDQNCj4gPiAtLS0gYS9ody92ZmlvL3JlZ2lvbi5jDQo+ID4gKysrIGIv
aHcvdmZpby9yZWdpb24uYw0KPiA+IEBAIC0yOSw2ICsyOSw3IEBADQo+ID4gICNpbmNsdWRlICJx
ZW11L2Vycm9yLXJlcG9ydC5oIg0KPiA+ICAjaW5jbHVkZSAicWVtdS91bml0cy5oIg0KPiA+ICAj
aW5jbHVkZSAibW9uaXRvci9tb25pdG9yLmgiDQo+ID4gKyNpbmNsdWRlICJzeXN0ZW0vcmFtYmxv
Y2suaCINCj4gPiAgI2luY2x1ZGUgInZmaW8taGVscGVycy5oIg0KPiA+DQo+ID4gIC8qDQo+ID4g
QEAgLTIzOCwxMyArMjM5LDUyIEBAIHN0YXRpYyB2b2lkIHZmaW9fc3VicmVnaW9uX3VubWFwKFZG
SU9SZWdpb24NCj4gKnJlZ2lvbiwgaW50IGluZGV4KQ0KPiA+ICAgICAgcmVnaW9uLT5tbWFwc1tp
bmRleF0ubW1hcCA9IE5VTEw7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW50IHZmaW9fcmVn
aW9uX2NyZWF0ZV9kbWFfYnVmKFZGSU9SZWdpb24gKnJlZ2lvbikNCj4gPiArew0KPiA+ICsgICAg
Z19hdXRvZnJlZSBzdHJ1Y3QgdmZpb19kZXZpY2VfZmVhdHVyZSAqZmVhdHVyZSA9IE5VTEw7DQo+
ID4gKyAgICBWRklPRGV2aWNlICp2YmFzZWRldiA9IHJlZ2lvbi0+dmJhc2VkZXY7DQo+ID4gKyAg
ICBzdHJ1Y3QgdmZpb19kZXZpY2VfZmVhdHVyZV9kbWFfYnVmICpkbWFfYnVmOw0KPiA+ICsgICAg
c2l6ZV90IHRvdGFsX3NpemU7DQo+ID4gKyAgICBpbnQgaSwgcmV0Ow0KPiA+ICsNCj4gPiArICAg
IGdfYXNzZXJ0KHJlZ2lvbi0+bnJfbW1hcHMpOw0KPiA+ICsNCj4gPiArICAgIHRvdGFsX3NpemUg
PSBzaXplb2YoKmZlYXR1cmUpICsgc2l6ZW9mKCpkbWFfYnVmKSArDQo+ID4gKyAgICAgICAgICAg
ICAgICAgc2l6ZW9mKHN0cnVjdCB2ZmlvX3JlZ2lvbl9kbWFfcmFuZ2UpICogcmVnaW9uLT5ucl9t
bWFwczsNCj4gPiArICAgIGZlYXR1cmUgPSBnX21hbGxvYzAodG90YWxfc2l6ZSk7DQo+ID4gKyAg
ICAqZmVhdHVyZSA9IChzdHJ1Y3QgdmZpb19kZXZpY2VfZmVhdHVyZSkgew0KPiA+ICsgICAgICAg
IC5hcmdzeiA9IHRvdGFsX3NpemUsDQo+ID4gKyAgICAgICAgLmZsYWdzID0gVkZJT19ERVZJQ0Vf
RkVBVFVSRV9HRVQgfA0KPiBWRklPX0RFVklDRV9GRUFUVVJFX0RNQV9CVUYsDQo+ID4gKyAgICB9
Ow0KPiA+ICsNCj4gPiArICAgIGRtYV9idWYgPSAodm9pZCAqKWZlYXR1cmUtPmRhdGE7DQo+ID4g
KyAgICAqZG1hX2J1ZiA9IChzdHJ1Y3QgdmZpb19kZXZpY2VfZmVhdHVyZV9kbWFfYnVmKSB7DQo+
ID4gKyAgICAgICAgLnJlZ2lvbl9pbmRleCA9IHJlZ2lvbi0+bnIsDQo+ID4gKyAgICAgICAgLm9w
ZW5fZmxhZ3MgPSBPX1JEV1IsDQo+ID4gKyAgICAgICAgLm5yX3JhbmdlcyA9IHJlZ2lvbi0+bnJf
bW1hcHMsDQo+ID4gKyAgICB9Ow0KPiA+ICsNCj4gPiArICAgIGZvciAoaSA9IDA7IGkgPCByZWdp
b24tPm5yX21tYXBzOyBpKyspIHsNCj4gPiArICAgICAgICBkbWFfYnVmLT5kbWFfcmFuZ2VzW2ld
Lm9mZnNldCA9IHJlZ2lvbi0+bW1hcHNbaV0ub2Zmc2V0Ow0KPiA+ICsgICAgICAgIGRtYV9idWYt
PmRtYV9yYW5nZXNbaV0ubGVuZ3RoID0gcmVnaW9uLT5tbWFwc1tpXS5zaXplOw0KPiA+ICsgICAg
fQ0KPiA+ICsNCj4gPiArICAgIHJldCA9IHZiYXNlZGV2LT5pb19vcHMtPmRldmljZV9mZWF0dXJl
KHZiYXNlZGV2LCBmZWF0dXJlKTsNCj4gPiArICAgIGZvciAoaSA9IDA7IGkgPCByZWdpb24tPm5y
X21tYXBzOyBpKyspIHsNCj4gPiArICAgICAgICB0cmFjZV92ZmlvX3JlZ2lvbl9kbWFidWYocmVn
aW9uLT52YmFzZWRldi0+bmFtZSwgcmV0LCByZWdpb24tPm5yLA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICByZWdpb24tPm1lbS0+bmFtZSwgcmVnaW9uLT5tbWFwc1tpXS5v
ZmZzZXQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZ2lvbi0+bW1h
cHNbaV0uc2l6ZSk7DQo+ID4gKyAgICB9DQo+ID4gKyAgICByZXR1cm4gcmV0Ow0KPiA+ICt9DQo+
ID4gKw0KPiA+ICBpbnQgdmZpb19yZWdpb25fbW1hcChWRklPUmVnaW9uICpyZWdpb24pDQo+ID4g
IHsNCj4gPiAgICAgIGludCBpLCByZXQsIHByb3QgPSAwOw0KPiA+ICAgICAgY2hhciAqbmFtZTsN
Cj4gPiAgICAgIGludCBmZDsNCj4gPg0KPiA+IC0gICAgaWYgKCFyZWdpb24tPm1lbSkgew0KPiA+
ICsgICAgaWYgKCFyZWdpb24tPm1lbSB8fCAhcmVnaW9uLT5ucl9tbWFwcykgew0KPiA+ICAgICAg
ICAgIHJldHVybiAwOw0KPiA+ICAgICAgfQ0KPiA+DQo+ID4gQEAgLTMwNSw2ICszNDUsMjEgQEAg
aW50IHZmaW9fcmVnaW9uX21tYXAoVkZJT1JlZ2lvbiAqcmVnaW9uKQ0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcmVnaW9uLT5tbWFwc1tpXS5zaXplIC0gMSk7DQo+ID4gICAg
ICB9DQo+ID4NCj4gPiArICAgIHJldCA9IHZmaW9fcmVnaW9uX2NyZWF0ZV9kbWFfYnVmKHJlZ2lv
bik7DQo+ID4gKyAgICBpZiAocmV0IDwgMCkgew0KPiA+ICsgICAgICAgIGlmIChyZXQgPT0gLUVO
T1RUWSkgew0KPiA+ICsgICAgICAgICAgICB3YXJuX3JlcG9ydF9vbmNlKCJWRklPIGRtYWJ1ZiBu
b3Qgc3VwcG9ydGVkIGluIGtlcm5lbCIpOw0KPiA+ICsgICAgICAgIH0gZWxzZSB7DQo+ID4gKyAg
ICAgICAgICAgIGVycm9yX3JlcG9ydCgiJXM6IGZhaWxlZCB0byBjcmVhdGUgZG1hYnVmOiAlcyIs
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICBtZW1vcnlfcmVnaW9uX25hbWUocmVnaW9u
LT5tZW0pLCBzdHJlcnJvcihlcnJubykpOw0KPiA+ICsgICAgICAgIH0NCj4gPiArICAgIH0gZWxz
ZSB7DQo+ID4gKyAgICAgICAgTWVtb3J5UmVnaW9uICptciA9ICZyZWdpb24tPm1tYXBzWzBdLm1l
bTsNCj4gPiArICAgICAgICBSQU1CbG9jayAqcmFtX2Jsb2NrID0gbXItPnJhbV9ibG9jazsNCj4g
PiArDQo+ID4gKyAgICAgICAgcmFtX2Jsb2NrLT5mZCA9IHJldDsNCj4gPiArICAgIH0NCj4gPiAr
DQo+ID4gICAgICByZXR1cm4gMDsNCj4gPg0KPiA+ICBub19tbWFwOg0KPiA+IGRpZmYgLS1naXQg
YS9ody92ZmlvL3RyYWNlLWV2ZW50cyBiL2h3L3ZmaW8vdHJhY2UtZXZlbnRzDQo+ID4gaW5kZXgg
MWU4OTU0NDhjZC4uNTkyYTAzNDlkNCAxMDA2NDQNCj4gPiAtLS0gYS9ody92ZmlvL3RyYWNlLWV2
ZW50cw0KPiA+ICsrKyBiL2h3L3ZmaW8vdHJhY2UtZXZlbnRzDQo+ID4gQEAgLTExNyw2ICsxMTcs
NyBAQCB2ZmlvX2RldmljZV9wdXQoaW50IGZkKSAiY2xvc2UgdmRldi0+ZmQ9JWQiDQo+ID4gIHZm
aW9fcmVnaW9uX3dyaXRlKGNvbnN0IGNoYXIgKm5hbWUsIGludCBpbmRleCwgdWludDY0X3QgYWRk
ciwgdWludDY0X3QgZGF0YSwNCj4gdW5zaWduZWQgc2l6ZSkgIiAoJXM6cmVnaW9uJWQrMHglIlBS
SXg2NCIsIDB4JSJQUkl4NjQgIiwgJWQpIg0KPiA+ICB2ZmlvX3JlZ2lvbl9yZWFkKGNoYXIgKm5h
bWUsIGludCBpbmRleCwgdWludDY0X3QgYWRkciwgdW5zaWduZWQgc2l6ZSwNCj4gdWludDY0X3Qg
ZGF0YSkgIiAoJXM6cmVnaW9uJWQrMHglIlBSSXg2NCIsICVkKSA9IDB4JSJQUkl4NjQNCj4gPiAg
dmZpb19yZWdpb25fc2V0dXAoY29uc3QgY2hhciAqZGV2LCBpbnQgaW5kZXgsIGNvbnN0IGNoYXIg
Km5hbWUsIHVuc2lnbmVkDQo+IGxvbmcgZmxhZ3MsIHVuc2lnbmVkIGxvbmcgb2Zmc2V0LCB1bnNp
Z25lZCBsb25nIHNpemUpICJEZXZpY2UgJXMsIHJlZ2lvbiAlZA0KPiBcIiVzXCIsIGZsYWdzOiAw
eCVseCwgb2Zmc2V0OiAweCVseCwgc2l6ZTogMHglbHgiDQo+ID4gK3ZmaW9fcmVnaW9uX2RtYWJ1
Zihjb25zdCBjaGFyICpkZXYsIGludCBmZCwgaW50IGluZGV4LCAgY29uc3QgY2hhciAqbmFtZSwN
Cj4gdW5zaWduZWQgbG9uZyBvZmZzZXQsIHVuc2lnbmVkIGxvbmcgc2l6ZSkgIkRldmljZSAlcywg
ZG1hYnVmIGZkICVkIHJlZ2lvbiAlZA0KPiBcIiVzXCIsIG9mZnNldDogMHglbHgsIHNpemU6IDB4
JWx4Ig0KPiA+ICB2ZmlvX3JlZ2lvbl9tbWFwX2ZhdWx0KGNvbnN0IGNoYXIgKm5hbWUsIGludCBp
bmRleCwgdW5zaWduZWQgbG9uZyBvZmZzZXQsDQo+IHVuc2lnbmVkIGxvbmcgc2l6ZSwgaW50IGZh
dWx0KSAiUmVnaW9uICVzIG1tYXBzWyVkXSwgWzB4JWx4IC0gMHglbHhdLCBmYXVsdDoNCj4gJWQi
DQo+ID4gIHZmaW9fcmVnaW9uX21tYXAoY29uc3QgY2hhciAqbmFtZSwgdW5zaWduZWQgbG9uZyBv
ZmZzZXQsIHVuc2lnbmVkIGxvbmcNCj4gZW5kKSAiUmVnaW9uICVzIFsweCVseCAtIDB4JWx4XSIN
Cj4gPiAgdmZpb19yZWdpb25fZXhpdChjb25zdCBjaGFyICpuYW1lLCBpbnQgaW5kZXgpICJEZXZp
Y2UgJXMsIHJlZ2lvbiAlZCINCg0K

