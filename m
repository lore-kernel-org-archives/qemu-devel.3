Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853D5C282C1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 17:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to3rV-0005oQ-8t; Fri, 28 Feb 2025 12:09:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1to3rT-0005jY-Pc; Fri, 28 Feb 2025 12:09:19 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1to3rM-0000Ju-Sr; Fri, 28 Feb 2025 12:09:19 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SEGbVd023520;
 Fri, 28 Feb 2025 17:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=gsrLFm1oJXJH5RmI0H2bSyg9R/U6/1iU28Vy64QqWHk=; b=
 JjC5UHpCBEqAXQc+F/JY+Z+jlQ1l/2asXDFSow2uBvL64HzrwzY3sAum34z0S3qK
 sDijnft2l2F2D/77o+50hQxUieozRW3DDIb8AunC+w8fN00ivPLwYMkUR492Okis
 miKBO91MDkeTim4WO1ahV98XCFJiFIn+GCLQ4fTF4TCYy9Mw8Kqhr8qzNS+sl90o
 TOePRlpUvj74RlMWkjvA56rbgdWiOQoCvNPlBPcRnwGrVBV5Lbzjyn/+RutjoLCq
 2Gi9XtLON+dRvveozcYFxiqQqTlLS70G9kcWHDex/JtqLvTLm0MZfOJmPPWzbfev
 bN5OSkvFMyGZERjpy3KhEg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psee0e3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Feb 2025 17:09:06 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51SGiuM7013138; Fri, 28 Feb 2025 17:09:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4530jx4gjf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Feb 2025 17:09:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJhFzkVfkKVZsAxav2kXomi2MjgI1iOwGBm/nHjSI8RhRFu1AteJgGyU1+lR4PEttXtkdVaeu/2pDcohLtmD6tndDzRf1NzwgEJXOKmrMADRwYUwmcUCrSyH3T4TRghpvkTEcShWQK1mCT1KHoEiEmHf1CN2PNAPu2DifYliwMiCcoVFTt4SPN87PNb9vD5WRHygfAVeSh8LSN/dmObc0dajo1yZ78ODsRqyF+7lmWl5cyzCpH1XG6awLTXuwu/6GhBLOvcWz35eUuP7KQ+O/1nxGkE6DWBB5uPVT9+QXRifPcLPDfOa7W+c9hMwHs1sNny1ae/4nFEaIIFkheuKxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsrLFm1oJXJH5RmI0H2bSyg9R/U6/1iU28Vy64QqWHk=;
 b=GtxIxinTSaU2N3cY4NPe1xYxFole1jTjgzaES6Rkx6LWIKbFgdrNJImeoLFzq+KZaoyYBxgok0gM6lpBXQ4y/e54f62i6XZQmjXyflgZic1G02eXOXENFfVEgpnv4vglNAsCGjEOp/5/sL1wgL9xDjcvs4djQ/kQkpyqa3xejxIGaiZ5/QCIPYTtmEP/elOmODeCli0XUrVk1cx9hrCakanS/erlEHVjAdzPqKhD2S0Pt8Kk+uRs+1zHRKqP/ac833VYnAKxPKNgEdNFmWxo5s2A60sK+uq6ja6iruNq6K9njcl5vSfRVD1gfTGmmTIWbWmbKbot9gS9Srq5L58X9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsrLFm1oJXJH5RmI0H2bSyg9R/U6/1iU28Vy64QqWHk=;
 b=LeMW+DfyxMD0OlY45WzSm7VU9Ykie5/5FaPJkepMGQWNmBH4rrk5MnuZcg+0HcER7LIgSsBfPySfI3cpCKxV/b+akbktWqQxRG1uwhA5ErQBbUJU7m9oxd9VqMv46OS3ppuQR8BW4J4e8kQGq243WSIWMNCtCkgP4nNRLbZr0p8=
Received: from DS7PR10MB5008.namprd10.prod.outlook.com (2603:10b6:5:3b1::19)
 by DS7PR10MB7190.namprd10.prod.outlook.com (2603:10b6:8:db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Fri, 28 Feb
 2025 17:09:00 +0000
Received: from DS7PR10MB5008.namprd10.prod.outlook.com
 ([fe80::3190:3396:d0a1:a69]) by DS7PR10MB5008.namprd10.prod.outlook.com
 ([fe80::3190:3396:d0a1:a69%5]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 17:09:00 +0000
From: Jag Raman <jag.raman@oracle.com>
To: John Levon <john.levon@nutanix.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Jason Herne
 <jjherne@linux.ibm.com>, Thanos Makatos <thanos.makatos@nutanix.com>, Halil
 Pasic <pasic@linux.ibm.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, Eric Farman <farman@linux.ibm.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Stefano
 Garzarella <sgarzare@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v8 00/28] vfio-user client
Thread-Topic: [PATCH v8 00/28] vfio-user client
Thread-Index: AQHbgt5sJDavtdYLtka7uQ8Ih/RY5LNdASGA
Date: Fri, 28 Feb 2025 17:09:00 +0000
Message-ID: <C8153041-CC4A-4C3A-A11B-8F8F6401857E@oracle.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
In-Reply-To: <20250219144858.266455-1-john.levon@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.400.131.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR10MB5008:EE_|DS7PR10MB7190:EE_
x-ms-office365-filtering-correlation-id: bcca7552-5697-45c9-f65a-08dd581a982f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?eEkxZy83T0p1QkxkdmFkaU8rVlI5aDM2SDBoTGNGTkpXSGN3UnNvRURYSHox?=
 =?utf-8?B?UWtIYmxZV1NRVUl5ZEh0eGFLbjNzUmtUbXFRTmp2ckhPQTBueWZRNGFCMWVW?=
 =?utf-8?B?aDJBbENaK21RK2NHK2YwcG5TQS8zU2k3MjIvTnBkTVFmRDY1TkJEcG5VaTEv?=
 =?utf-8?B?NVE1dFA0c2p2dWRXM1dUUmZSdW9OaVEyV1JBUWNqbThWcmxlUFkrd09rMjlK?=
 =?utf-8?B?MENBazd2czlTSks2UjhEblZPWStkSjNGUzVJazBPaUxUTXhUT2tNT2Mvb1BE?=
 =?utf-8?B?ZTVQT2xqZy9jc25VRCtDTld0elFoV2xFSUhQVEx2L1ZrQmRyalQ2Y0Q5a1Q0?=
 =?utf-8?B?ZHZmQ09YNWszaXZWSFB6czhqSjJmdHoxVWFqSE12TERSVUdiblptZU4zSm44?=
 =?utf-8?B?Um42bDFMc2ZTUTFHbW1peG5ZVmJvazErWFdOeHRXWVpYRXdBaGhNdG8yQ0F2?=
 =?utf-8?B?MFQrSVZGdGhSMkdTZUxkR3ZaQUw4N3ZnUnV4em1yVWo0RjZrd3JZNjMwL3BR?=
 =?utf-8?B?eHhlb2xiUnE0d1FubEtoeHdxdmtUd1RrNDhyVyt0eVFKTmRlS2JNTGVxSXRL?=
 =?utf-8?B?L0JyajlqaGRML0NSaDMrSk1ieUQ4YTZXQ2RTZVNGeXRMNTBDVkMxRHlqVnRP?=
 =?utf-8?B?KzNMSG5aUTltMHpCbGhzOEpCN1R3bkl5TWUxemw1UjJSYit0UjlzTk5ZMjg5?=
 =?utf-8?B?RVBnaFJCdEdXdHQ5VmY0aWRrdDlZWk1Ia0RucHdZdUE3Z21ZckhWa3hGYXlq?=
 =?utf-8?B?K0E0NHhad0NDRUthSTE4Z0dsd3hZaXVhcTU2UUt0L3lqYldMbHNuZ2tILzlX?=
 =?utf-8?B?VXBlQ3lCdEhuRlBFUWd3aUMvZ1AzaTZOcXZma0trVUFiTCtzTjh2REZsY3E4?=
 =?utf-8?B?RjVnRVg3ZTBnSVQzRGhRckxpT095WDg0ZExYRG5VaElzZDBvaWNWbWsyUENI?=
 =?utf-8?B?WURadWhGSWwrWG0zTm5QT2YveGl6OXhITXhibnplRmNRWnhoYVY2SG5wQThh?=
 =?utf-8?B?dmlRYW9BclEyeDR0NXRpa3VSNDVheGxHVzZSRWtXOWE2K2lTT3Z5TlNwclBE?=
 =?utf-8?B?aVFEOERiYXR3RGFZWW9ha1Q0V0NZbytoQmk2b0FlSUdWdmFsSEdqWTFROVFH?=
 =?utf-8?B?eVRaSFc1ZVR1UEw5VmJIaHpiWDhWd1JxMmF3UHNwaTlMOXRNV3gyODkvcDh5?=
 =?utf-8?B?N3FJaDFrYnJnYjNxT2o0Z05NNm1tSVlhUE1hbWRSeWxUWW9RbnFTaFJhaThQ?=
 =?utf-8?B?VzkvM2dzZFJtZkt2YVlsU0FtV2hTOThSbXh6dUZ6ZzFDRlNzK1J3MXlBNlQv?=
 =?utf-8?B?aEVISDJ2K1BLcU5hcitYY1lGUkNQRlJrQ1UxSm9KRHdIKzBUeU5wSFRaclM0?=
 =?utf-8?B?ZWhiSkNva2xCRnNNOThaQVRXU2d5NWhKd1l0c0RnVkY0S0MzQ1NWMm41aXU2?=
 =?utf-8?B?N2JGUjRCNzlFRjA1N0QzV2ZjWnBFcERSVEZ1RHlzYmVEKytQVzVGUzJ4RjdF?=
 =?utf-8?B?T3hzaTI1Yk16UkErSE1CZ0JreEhwTVFuWmdhb2drWTZWbTFyaEZrSzlTanVX?=
 =?utf-8?B?LzRJT1puUXVwR3M2QW1TdjR5cEZVTGdMM0hNVjA2RDRHcnZqZkpvdkNGZ2F2?=
 =?utf-8?B?REphTUJYaXAxQjRsbXhnNDVCRy96dXlYT1lpVTl5b2c3eTlmKzlocmZpSFlT?=
 =?utf-8?B?RDFVN3lRZVdZUWI2bXFxRkgwaG1Sd2JkUHZidnZjcFJMREFkL01tVm41bHhU?=
 =?utf-8?B?eHMxb3E2R0E1ZnI4OXJENHNhNGhEdkg5eUVFd091SlgzWWRoRGxVbkl3NWxl?=
 =?utf-8?B?VVlEalcvWmNnSmwyeEtCM3pScWY5eFZPbjBOWGFMYXU5TUlZR3FINGhxRjl2?=
 =?utf-8?B?Y2ZWYXVwcVV3WjZVbGxLRzJQMWMvMW5QYmxqVDZseVhRVTBMWVdpN0hZc2Vv?=
 =?utf-8?Q?Cso7Zk3+BW1CRoeIW8lAgnQVND2CE7Yf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5008.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFo4WnNCLzFlTlhSNFkyWXdXcmIxU2s2UVRKUHdTa2U4ZU14NmgwRFVWeGpD?=
 =?utf-8?B?UjZmYnAxUkpCVW1PTVRPSzMyTzNHV0RYSm5RaFlHVW4xRlpVeWpFNmY3UEM3?=
 =?utf-8?B?OEVGMExYdmJSQWNEb2tyK3hEVlVyc3JtekJ0SSsrd0c0dmxBZGVCR2xlNEwx?=
 =?utf-8?B?RXMwNlNHZ20zK0MraXBVbmkwN2l2Q2g4N2NBQU9jbnRRcGR1TlZSVXMwZXpP?=
 =?utf-8?B?RGRnT1JvMGJvSHB1emwwckM0bzl4QUZpRGFVY0hDOFB4U1R0WUZFeHB4VTAv?=
 =?utf-8?B?OG41OFEzT3pQNHpZaWtnTWNXdllNZVVOdk4zRFlYRWdmdTB5dHFYOEpTVTZY?=
 =?utf-8?B?VWl3YytiL1Y5TzNVVytjZ3NKeVpXU2pDQUMrVS93M3VMdnVxMjJRNFJsdlRF?=
 =?utf-8?B?U0xTUytBSExhR3FIVFZqZkdqUysrTFNaUHZBTGNKajg5SXJVVWFqc2VUeDJB?=
 =?utf-8?B?VlFvR1ByaWdDSkFaaFdwWUpjazB3Rk5WNFVpVkllREZqMFE0OUpvR3p6ZndK?=
 =?utf-8?B?ei9LMHU0UkdQaEVRR1dRZXloYkw3RWVSb1VkM1RzUm4xTldxd0RYRmx4alRj?=
 =?utf-8?B?WkYzWEN0OW8rcTN5MmJ5OHhFRzRVNm5wa2ttKzBmcnRuMWhmd3oyQkVmT2F0?=
 =?utf-8?B?bHZ5eEJDMDBjQTJhM3pIWHJzTVpUVkc5NGRDM29MemNqcFFyQ1cxaUZZbHZK?=
 =?utf-8?B?MFNTS0JuRWJFZzdqTkNxNWdVOEZ6Yjl6U1p0V2I5R2lmVkJDNXJmM1drVEIx?=
 =?utf-8?B?OHIzaElMWGFMb1dTVENpbFJBS0FNN2taNWs0VkFxZXNwVVNXdy9GbmUzeXpu?=
 =?utf-8?B?T1M4cFVGNDNhZ0ZGOHBHZFJ0VjZZcjIzN1ZOWnlDK0UzQmdPRzZieGsxM21l?=
 =?utf-8?B?cUQ5ZjdHWkNkZ09DOXV4akFnTWwvOEg4UDJrVTdxNW1sUy9keFpDUm5TUkZT?=
 =?utf-8?B?Q050RHQ2TFNiSmN4aDFBdW82SEMyemlNRXUzK09HVVZHSUwrUHViZVhBWVZo?=
 =?utf-8?B?SGJvdUVwK3k1SllEOEZNNUkwM2JrOFduMTNrZjlOM1ZxQkNXUDhOVktxZVBn?=
 =?utf-8?B?K3FrZnVRRVN1QnEzNTNLNWV4U0xUZnhnTkowMGExdTc2VXNQaW9lUFF1cVRB?=
 =?utf-8?B?RDN4amZzb0NiMmJuWjY3eGJqdmZBTXR2dER4N0lCYTU1TWFBdEhVK1NQUkhK?=
 =?utf-8?B?MUxuNnVxaXNNSmcwOHhHRDY3L0I4ZDg4VnVzOWNidHUvYVpTa0xoWFQ3cVo4?=
 =?utf-8?B?eWc5VmNxYnFhRWp0dzJrbHFocDVFQjZzdTNBby85YTQ4S2tTQkwzWGFYZGdI?=
 =?utf-8?B?MHpuVm16cEc2Q01qZERXT1IwNG91bGc2WG1GZ1hRSjVhQzFnUnNMLzREQmRm?=
 =?utf-8?B?NXJ4REwybUxGa1greVFYbnk2cktja2NlcmpXcWFIbWNqUkxLQzZONHYrUkdy?=
 =?utf-8?B?Y21oa0hXTGJFdytsYlN5cytHNEVneHIzZW5VVGwvREdYeW5KWWdadG5ZSzhx?=
 =?utf-8?B?TUZsRU1vZzhXV2RabkVpK2NkWUdTMzF5SEZaa3NDSXl2ckVVc1hvY2U1TTlw?=
 =?utf-8?B?NnRqOTE0eGRjbnVrdEpPc1ZwaURuMUFCT2NUWXk3QVR0UzlnSFdmcU9aOUtp?=
 =?utf-8?B?b01naU9zSWErSjBuRXQzTkpxalMvUG50ZkpIUHdjalkzdHFjQlg4ZmNCTjYv?=
 =?utf-8?B?QjN6SEoxeHp5Yjk1dHNYSklNWm9KVlQ0YnpPeEZWQ0pyNkdIakZrbkM2VkZB?=
 =?utf-8?B?eDRvZlN6WDFrazgveXhYSSszekx1TG94M0RORTJQemNqWCtXR3Iybk1XSVFm?=
 =?utf-8?B?cXltU2svOU55c09ZOW4vRXYzSEw1c3YrTytLeU9vVG9laWFyQ0F1eFFNVm5x?=
 =?utf-8?B?Ky9sVnVlbFliY20wNms0N2NjbVM2dmFkV0UrSnJUa1lURW1UTzFRNnZObTRS?=
 =?utf-8?B?ckZQY3NHSlNaRFhvblkzeU0vaWV2TEJiU3llTU5nVlA0cTd6N2FuYjBjekd2?=
 =?utf-8?B?cm1ZQ1JDV2FNVzZzNXZwOVVkNnlSZ2dLc3BIVWt5QytpVEI2aHY3V0FzdG5Q?=
 =?utf-8?B?NWUza2h1VDRRRWxTNHpSRWVRenJGZlEvR0NyUjdTYkxaeWdxb09Gb2JQbjdT?=
 =?utf-8?Q?z7MoRV9RdJ+6qQREA5MbLcDIB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B39D16BD45E1644AB10E6C6DB743870D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ed4sqjSpQ5q2qw0TWDKFMhdxq1kZSmYbHef4oxRAT/tiTtPQNvlyOtbR1G+91RfFLzmK9pHWc2kL5yjrRv+jZPM+1w4UDsda+FLXUosFi0/rlP2G5aeTitsV4Zcz00Enn5DIxExG+PrRlZHYWfRJR4FiMYMsjSnmhOf3iEhHG0jHQotU97T86kbGMoeezk7XnfVrJy07dDr5WqQPkmarnoRp5QG0CPaEp7F8HnsXfS4zCSpcmNmAqQffl03w8j4TLYpLjUP93qOM6pK4jsjiQ9dwGCrGbRvQop7m73hN0+pIm1D2wbPgNPaJA9gUVc3O1XGJlHSBLNTfZmXZVVS4aI+ILBHyU+mM4USSPf0EyPg26pw5m8f7KNGgcsYCxJ9UyY2iGUhgV9KHxi7vBXZr4u7wbz8bRXpSSnGkBICNlE4IunF+CX9D/MMzjyCYb5M20mPD6TY/nHPwlEwtFqm3S9M9RnaiqwAQvDQgsLxlmr9URbu3bppzMaDncHstgNSCjFlEGqkU3sBVrdJyESibVhxCWEgJuH7kBNw+Xc5ccYv2h3ufF8GPPMO/h/JU46M+IwWItRY1eUe4ZCmMSW/iEO7IyDsdBZvRnLXdWiJURFQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5008.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcca7552-5697-45c9-f65a-08dd581a982f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 17:09:00.1949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uC/hvTXGWWZ06hFZaLAeg83kk+WtEzfEW4XA3v0nfR/pE3qNFmE422DVP260dCgYZQU/U+cPv6sUVieQKhhKug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7190
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_05,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502280125
X-Proofpoint-GUID: YsHtnupldeb-_2T9Lh_kAxki9hTjJ-VN
X-Proofpoint-ORIG-GUID: YsHtnupldeb-_2T9Lh_kAxki9hTjJ-VN
Received-SPF: pass client-ip=205.220.165.32; envelope-from=jag.raman@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SSBhcHByZWNpYXRlIHlvdSBwb3N0aW5nIHRoZSBwYXRjaGVzLiBJIGRpZG4ndCBhdXRob3IgdGhl
IHBhdGNoZXMsIGFjdHVhbGx5OyBKb2huIEpvaG5zb24gZGlkIGl0Lg0KDQpZb3UgY291bGQgdXNl
IHlvdXIgbmFtZSBhcyB0aGUgYXV0aG9yIHNpbmNlIHlvdSBzaG91bGQgYmUgZmFtaWxpYXIgd2l0
aCBpdCBub3csIGFuZCBJIGNhbiByZXZpZXcgdGhlIHBhdGNoZXMuDQoNClBsZWFzZSBhZGQgdGhl
IGZvbGxvd2luZyB0byBlYWNoIHBhdGNoIHNvIGl0IHJlY29nbml6ZXMgT3JhY2xlJ3MgY29udHJp
YnV0aW9uOg0KQ28tYXV0aG9yZWQtYnk6IEpvaG4gSm9obnNvbiA8am9obi5nLmpvaG5zb25Ab3Jh
Y2xlLmNvbT4NCg0KVGhhbmsgeW91IHNvIG11Y2ghDQoNCj4gT24gRmViIDE5LCAyMDI1LCBhdCA5
OjQ44oCvQU0sIEpvaG4gTGV2b24gPGpvaG4ubGV2b25AbnV0YW5peC5jb20+IHdyb3RlOg0KPiAN
Cj4gVGhpcyBpcyB0aGUgOHRoIHJldmlzaW9uIG9mIHRoZSB2ZmlvLXVzZXIgY2xpZW50IGltcGxl
bWVudGF0aW9uLiBUaGUgdmZpby11c2VyDQo+IHByb3RvY29sIGFsbG93cyBmb3IgaW1wbGVtZW50
aW5nIChQQ0kpIGRldmljZXMgaW4gYW5vdGhlciB1c2Vyc3BhY2UgcHJvY2VzczsNCj4gU1BESyBp
cyBvbmUgZXhhbXBsZSwgd2hpY2ggaW5jbHVkZXMgYSB2aXJ0dWFsIE5WTWUgaW1wbGVtZW50YXRp
b24uDQo+IA0KPiBUaGUgdmZpby11c2VyIGZyYW1ld29yayBjb25zaXN0cyBvZiAzIHBhcnRzOg0K
PiAxKSBUaGUgVkZJTyB1c2VyIHByb3RvY29sIHNwZWNpZmljYXRpb24uDQo+IDIpIEEgY2xpZW50
IC0gdGhlIFZGSU8gZGV2aWNlIGluIFFFTVUgdGhhdCBlbmNhcHN1bGF0ZXMgVkZJTyBtZXNzYWdl
cw0KPiAgICBhbmQgc2VuZHMgdGhlbSB0byB0aGUgc2VydmVyLg0KPiAzKSBBIHNlcnZlciAtIGEg
cmVtb3RlIHByb2Nlc3MgdGhhdCBlbXVsYXRlcyBhIGRldmljZS4NCj4gDQo+IFRoaXMgcGF0Y2hz
ZXQgaW1wbGVtZW50cyBwYXJ0cyAxIGFuZCAyLg0KPiANCj4gSXQgaGFzIGJlZW4gdGVzdGVkIGFn
YWluc3QgbGlidmZpby11c2VyIHRlc3Qgc2VydmVycyBhcyB3ZWxsIGFzIFNQREsuDQo+IA0KPiBU
aGFua3MgZm9yIHByZXZpb3VzIHJldmlld3MgJiBjb21tZW50cy4NCj4gDQo+IENoYW5nZXMgc2lu
Y2Ugdjc6DQo+IA0KPiAtIHNwbGl0IHVwIHBjaSBwYXRjaGVzIGZvciBlYXNpZXIgcmV2aWV3aW5n
DQo+IC0gZml4ZWQgbG90cyBvZiBkZXZpY2Ugb3BzIGVycm9yIGhhbmRsaW5nDQo+IC0gdmZpby11
c2VyIGNvZGUgbm93IGluIGh3L3ZmaW8tdXNlcg0KPiAtIGltcHJvdmVkIGNvbW1pdCBtZXNzYWdl
cw0KPiAtIHZhcmlvdXMgb3RoZXIgc21hbGwgY2xlYW51cHMNCj4gDQo+IEphZ2FubmF0aGFuIFJh
bWFuICgyMCk6DQo+ICB2ZmlvL2NvbnRhaW5lcjogcGFzcyBNZW1vcnlSZWdpb24gdG8gRE1BIG9w
ZXJhdGlvbnMNCj4gIHZmaW86IGFkZCByZWdpb24gY2FjaGUNCj4gIHZmaW86IHNwbGl0IG91dCBW
RklPS2VybmVsUENJRGV2aWNlDQo+ICB2ZmlvOiBhZGQgZGV2aWNlIElPIG9wcyB2ZWN0b3INCj4g
IHZmaW8tdXNlcjogYWRkIHZmaW8tdXNlciBjbGFzcyBhbmQgY29udGFpbmVyDQo+ICB2ZmlvLXVz
ZXI6IGNvbm5lY3QgdmZpbyBwcm94eSB0byByZW1vdGUgc2VydmVyDQo+ICB2ZmlvLXVzZXI6IGlt
cGxlbWVudCBtZXNzYWdlIHJlY2VpdmUgaW5mcmFzdHJ1Y3R1cmUNCj4gIHZmaW8tdXNlcjogaW1w
bGVtZW50IG1lc3NhZ2Ugc2VuZCBpbmZyYXN0cnVjdHVyZQ0KPiAgdmZpby11c2VyOiBpbXBsZW1l
bnQgVkZJT19VU0VSX0RFVklDRV9HRVRfSU5GTw0KPiAgdmZpby11c2VyOiBpbXBsZW1lbnQgVkZJ
T19VU0VSX0RFVklDRV9HRVRfUkVHSU9OX0lORk8NCj4gIHZmaW8tdXNlcjogaW1wbGVtZW50IFZG
SU9fVVNFUl9SRUdJT05fUkVBRC9XUklURQ0KPiAgdmZpby11c2VyOiBzZXQgdXAgUENJIGluIHZm
aW9fdXNlcl9wY2lfcmVhbGl6ZSgpDQo+ICB2ZmlvLXVzZXI6IGltcGxlbWVudCBWRklPX1VTRVJf
REVWSUNFX0dFVC9TRVRfSVJRKg0KPiAgdmZpby11c2VyOiBmb3J3YXJkIE1TSS1YIFBCQSBCQVIg
YWNjZXNzZXMgdG8gc2VydmVyDQo+ICB2ZmlvLXVzZXI6IHNldCB1cCBjb250YWluZXIgYWNjZXNz
IHRvIHRoZSBwcm94eQ0KPiAgdmZpby11c2VyOiBpbXBsZW1lbnQgVkZJT19VU0VSX0RFVklDRV9S
RVNFVA0KPiAgdmZpby11c2VyOiBpbXBsZW1lbnQgVkZJT19VU0VSX0RNQV9SRUFEL1dSSVRFDQo+
ICB2ZmlvLXVzZXI6IGFkZCAnbm8tZGlyZWN0LWRtYScgb3B0aW9uDQo+ICB2ZmlvLXVzZXI6IGFk
ZCAneC1tc2ctdGltZW91dCcgb3B0aW9uDQo+ICB2ZmlvLXVzZXI6IGFkZCBjb2FsZXNjZWQgcG9z
dGVkIHdyaXRlcw0KPiANCj4gSm9obiBMZXZvbiAoNyk6DQo+ICB2ZmlvL2NvbnRhaW5lcjogcGFz
cyBsaXN0ZW5lcl9iZWdpbi9jb21taXQgY2FsbGJhY2tzDQo+ICB2ZmlvL2NvbnRhaW5lcjogc3Vw
cG9ydCBWRklPX0RNQV9VTk1BUF9GTEFHX0FMTA0KPiAgdmZpbzogYWRkIHZmaW9fYXR0YWNoX2Rl
dmljZV9ieV9pb21tdV90eXBlKCkNCj4gIHZmaW86IGFkZCB2ZmlvX3ByZXBhcmVfZGV2aWNlKCkN
Cj4gIHZmaW86IHJlZmFjdG9yIG91dCB2ZmlvX2ludGVycnVwdF9zZXR1cCgpDQo+ICB2ZmlvOiBy
ZWZhY3RvciBvdXQgdmZpb19wY2lfY29uZmlnX3NldHVwKCkNCj4gIHZmaW8tdXNlcjogaW1wbGVt
ZW50IFZGSU9fVVNFUl9ETUFfTUFQL1VOTUFQDQo+IA0KPiBUaGFub3MgTWFrYXRvcyAoMSk6DQo+
ICB2ZmlvLXVzZXI6IGludHJvZHVjZSB2ZmlvLXVzZXIgcHJvdG9jb2wgc3BlY2lmaWNhdGlvbg0K
PiANCj4gTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMTAgKy0NCj4g
ZG9jcy9kZXZlbC9pbmRleC1pbnRlcm5hbHMucnN0ICAgICAgICB8ICAgIDEgKw0KPiBkb2NzL2Rl
dmVsL3ZmaW8tdXNlci5yc3QgICAgICAgICAgICAgIHwgMTUyMiArKysrKysrKysrKysrKysrKysr
KysrDQo+IGh3L21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAxICsNCj4g
aHcvdmZpby11c2VyL2NvbW1vbi5jICAgICAgICAgICAgICAgICB8IDE3MDIgKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiBody92ZmlvLXVzZXIvY29tbW9uLmggICAgICAgICAgICAgICAgIHwg
IDEyMyArKw0KPiBody92ZmlvLXVzZXIvY29udGFpbmVyLmMgICAgICAgICAgICAgIHwgIDM1OCAr
KysrKysNCj4gaHcvdmZpby11c2VyL2NvbnRhaW5lci5oICAgICAgICAgICAgICB8ICAgMjQgKw0K
PiBody92ZmlvLXVzZXIvbWVzb24uYnVpbGQgICAgICAgICAgICAgIHwgICAxMCArDQo+IGh3L3Zm
aW8tdXNlci9wY2kuYyAgICAgICAgICAgICAgICAgICAgfCAgNDQzICsrKysrKysNCj4gaHcvdmZp
by11c2VyL3Byb3RvY29sLmggICAgICAgICAgICAgICB8ICAyNDMgKysrKw0KPiBody92ZmlvLXVz
ZXIvdHJhY2UtZXZlbnRzICAgICAgICAgICAgIHwgICAxOCArDQo+IGh3L3ZmaW8tdXNlci90cmFj
ZS5oICAgICAgICAgICAgICAgICAgfCAgICAxICsNCj4gaHcvdmZpby9hcC5jICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgIDQgKy0NCj4gaHcvdmZpby9jY3cuYyAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgIDkgKy0NCj4gaHcvdmZpby9jb21tb24uYyAgICAgICAgICAgICAgICAgICAg
ICB8ICAxMzcgKy0NCj4gaHcvdmZpby9jb250YWluZXItYmFzZS5jICAgICAgICAgICAgICB8ICAg
IDggKy0NCj4gaHcvdmZpby9jb250YWluZXIuYyAgICAgICAgICAgICAgICAgICB8ICAgNzggKy0N
Cj4gaHcvdmZpby9oZWxwZXJzLmMgICAgICAgICAgICAgICAgICAgICB8ICAxODUgKystDQo+IGh3
L3ZmaW8vaWdkLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICA4ICstDQo+IGh3L3ZmaW8v
aW9tbXVmZC5jICAgICAgICAgICAgICAgICAgICAgfCAgIDMxICstDQo+IGh3L3ZmaW8vcGNpLmMg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgNTkxICsrKysrLS0tLQ0KPiBody92ZmlvL3BjaS5o
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAzNCArLQ0KPiBody92ZmlvL3BsYXRmb3JtLmMg
ICAgICAgICAgICAgICAgICAgIHwgICAgNCArLQ0KPiBody92aXJ0aW8vdmhvc3QtdmRwYS5jICAg
ICAgICAgICAgICAgIHwgICAgMiArLQ0KPiBpbmNsdWRlL2V4ZWMvbWVtb3J5LmggICAgICAgICAg
ICAgICAgIHwgICAgNCArLQ0KPiBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaCAgICAgICAg
IHwgICA0NSArLQ0KPiBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5oIHwgICAx
MSArLQ0KPiBtZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMSArDQo+
IG1lc29uX29wdGlvbnMudHh0ICAgICAgICAgICAgICAgICAgICAgfCAgICAyICsNCj4gc2NyaXB0
cy9tZXNvbi1idWlsZG9wdGlvbnMuc2ggICAgICAgICB8ICAgIDQgKw0KPiBzeXN0ZW0vbWVtb3J5
LmMgICAgICAgICAgICAgICAgICAgICAgIHwgICAgNyArLQ0KPiAzMiBmaWxlcyBjaGFuZ2VkLCA1
MjgxIGluc2VydGlvbnMoKyksIDM0MCBkZWxldGlvbnMoLSkNCj4gY3JlYXRlIG1vZGUgMTAwNjQ0
IGRvY3MvZGV2ZWwvdmZpby11c2VyLnJzdA0KPiBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvdmZpby11
c2VyL2NvbW1vbi5jDQo+IGNyZWF0ZSBtb2RlIDEwMDY0NCBody92ZmlvLXVzZXIvY29tbW9uLmgN
Cj4gY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L3ZmaW8tdXNlci9jb250YWluZXIuYw0KPiBjcmVhdGUg
bW9kZSAxMDA2NDQgaHcvdmZpby11c2VyL2NvbnRhaW5lci5oDQo+IGNyZWF0ZSBtb2RlIDEwMDY0
NCBody92ZmlvLXVzZXIvbWVzb24uYnVpbGQNCj4gY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L3ZmaW8t
dXNlci9wY2kuYw0KPiBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvdmZpby11c2VyL3Byb3RvY29sLmgN
Cj4gY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L3ZmaW8tdXNlci90cmFjZS1ldmVudHMNCj4gY3JlYXRl
IG1vZGUgMTAwNjQ0IGh3L3ZmaW8tdXNlci90cmFjZS5oDQo+IA0KPiAtLSANCj4gMi4zNC4xDQo+
IA0KPiANCg0K

