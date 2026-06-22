Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CD5CDB466
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 20:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wblSK-0001L4-0K; Mon, 22 Jun 2026 16:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wblSH-0001Ks-Jf
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 16:41:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wblSF-00048c-KD
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 16:41:17 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MEKJ9d1845773; Mon, 22 Jun 2026 20:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=pMcHvZCz5dnAmKAYyj6Re0gvFJ1SNSU0iLxHMyoTnUU=; b=
 LokOy1QExYofoxNBcY2Pk7wJafEzdmaBRVEd4/5bC20gdBQwvwXgMHpbFRGWDUIY
 py7KDvD+g87A+2Dgtl8Unr6ROuwldWSEVb+LqP4D0yY6phTnAE47p/IOD45S+RFM
 BuNWIShftyRluabirqg28z2HG8LMva/zJsEdUQJqGzQKU7LiQObaJqWpJC0/tviY
 7muUqFPCFoa1GQ4tGR+RDlg1lwkqpPhCw8KlwAkg8gBI0rI7hJUhKqb+omvSugw6
 eNfkLLc5+SzPDKrpsTfsg2pbBVvdp05wpP2XFIZnuNHRR02F0o94ie4DsNKlA8wS
 /x+bexCk/xcwHJDEJCIcjQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewjr7jq2t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jun 2026 20:41:10 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 65MKXpcq031858; Mon, 22 Jun 2026 20:41:09 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011028.outbound.protection.outlook.com
 [40.93.194.28])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4ewhap69p3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jun 2026 20:41:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GS1Q6IKtLH/JcKaWjlaalafRQzGi5viNNwepvgVjNFl/j1Dl8WDYMmO3nnqauwF1XBTvV27dq05rKaoz+E9E63swuCOMrBdDSXIVpu2m/8h4yXDqMsINJQJBBoe7eJTEoSmQBnGY54ir1v1rTMv79upj32xBqhibXF4e7fpgcVZbxCRhIl+FZKdYrXHmd222zKg4SdaMV3Phwh/rgfQJBtnKkaaVWnToUdK6ekvPgrAYixjTVQ+e2uWoLPNPT30NdqGSPTPzZvaQiSmyGr388s1uvmy3Rbj4pQjBR7qleyzTTo8FESztpA4FcPaIo0aKTOa79EVNOIclkRQ/QSbhng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMcHvZCz5dnAmKAYyj6Re0gvFJ1SNSU0iLxHMyoTnUU=;
 b=TPcm7buevIeR6X3jvPymKCnjYOXJ1Ncn3zoixTtgp3DRKbbMvCGRWho+OgU52P8oWrk9AaBsfRkK7enFR9qEvdJQMcu7sMWdqRdZN+BW0Ku6Rxwbtfs8LjRhlqdqRx679JCiBt+X7Lk1xNEtRcFLbEq8yU4RxOACGU/4IeHnxiBzks9Lo8TFZahD9uQ0ao2BYQUR/erCfKIOAUymsEpTlucDJAZuytPdaVuhXevt7cUm5/kV+4QIQ5BYJhBr2lH4oKdYgD3RSU3B3j4gMNxo6exhTurf9WI2Hb7Lr8euEhqYFejTc5zFMPn3cFAY0jl9iLwppTF/c5W9jrpgFIr+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMcHvZCz5dnAmKAYyj6Re0gvFJ1SNSU0iLxHMyoTnUU=;
 b=ONfzaHxTUmcIcCrhuysB8pDoLjaUijs9cuKxnKcqIWO2aa+xI7aV8DsVnKKVnETJhbH4xr8HKLoqW0uHctZojRUZNcoPS/h7/uJ4nhrlcgTKnh/dMxTumhu+MwHzHwls/oOBSIUyXo3hBnPmC7pBzu+YBVsrFKMIUQ5z672cXQ4=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by SA2PR10MB4761.namprd10.prod.outlook.com (2603:10b6:806:112::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 20:41:04 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 20:41:04 +0000
Message-ID: <6c776aa4-cf3d-4afc-9b06-51a0d6eac78a@oracle.com>
Date: Mon, 22 Jun 2026 16:41:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 081/106] amd_iommu: Generate XT interrupts when xt support
 is enabled
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Sairaj Kodilkar <sarunkod@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <cover.1781463125.git.mst@redhat.com>
 <cf0210df65aa4f582e444b910c950e2b4a80b194.1781463125.git.mst@redhat.com>
 <CAFEAcA8sZSNr5N8ri6SCok2aWLED9+OGvy0qA7A83SuwXg9xKA@mail.gmail.com>
 <20260622155957-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20260622155957-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::8) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|SA2PR10MB4761:EE_
X-MS-Office365-Filtering-Correlation-Id: 856b476d-e702-42d8-bc33-08ded09e941e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|56012099006|3023799007|5023799004|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /I+/UZDKfUyRLEHXXrALkHz5JsVDjhoIutMosUkO6OYssn9Limcq4izO4BlgZwOClFC5coxVjuqqUsGYR6lFaA/WjnW/9yOnHC43P/bYgTAJEyaN2KRTjHTwKQhsdLnRj9ZSxEkLHGli2leUfluxFdTtPoNJDr/UCWsydbPkH/HH7tZ+4brtL7ruJ9eQTlRhYLZNouapBMtaOfZS26lHOWFeHplk2lyliy5mz0qHfJPx6fH9KbE6tSMnmwlJIpE1eJuW0a71SU1odFEcm7C/2a5Bj7zr0td4wrfSdeZ4dQMpX83UQ854a4eDIomC0PlULX5hLPUk5NEda5LRUmK8T4cY1aX4/fz/m1J8zrsCiJDCDpDg3UhZzBAPec+CNybylf+9fHwZ+sHiTZ62yhYJbd5aXRq/2fVAwe2bLR+sW/jTpACCwRnpuKxBP4bX4+HbreEoelzs0OsT9FbiUohsXKkytklRUR7BKizmXB7NJHMKh5/HDhmNe1rFA2klwaHGVZlIBMlnzI5fLSr/kfrqRz2BpCBlTFDRIyCEik+qdEJkBsam+eTYOz7WxWAkLNs1PEXC5PnU8quha8FaDcUC6pdxJcuXOWFf++CYVS3RzVWHnINdgRIBSUey187qmmh1Vzzs6Y0gt7MW8OLr7I3IhYuo0RX7PSgwTW634QON5tY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(56012099006)(3023799007)(5023799004)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG00RTZXSlJERzJTNXNodjF0Y0lqV0FSK2MwL1dnRnZmL2FPOU9vaDN1Z3hO?=
 =?utf-8?B?M2tKY0ZJcEJkTlk2dmlyL3E5cnFURzFERkx3VnQzN0lOMGdyS1ptb1BjY3dG?=
 =?utf-8?B?L2lJMTJEL25Tdk4yeHN1NThrcXRlRGY2cU1kOW52RlNFcjUvN1gvanJRYklJ?=
 =?utf-8?B?cnNwRVZtM0hmOEw5d2pkU0p5M3FrQkRyYmF0R09PMGJ5Zk5qNjJWQnowQzRL?=
 =?utf-8?B?QUpvM0VjQUFNdmljMVN3RUtld1A5L3VkRHh6SjZLdEVkcVNpRDRiUUxoMFlH?=
 =?utf-8?B?eDdqek9jK2pDUEpMSnVtMC8vLzRRbENET0dMWjhmRTlQekx2TnBKMGZaa2lv?=
 =?utf-8?B?VmVYOFV5UGZ1d0dqVjJHN2twRlNCcStEdUlzSVNVb09yNktiYUpMeU5yYjRM?=
 =?utf-8?B?UGVNME9jNllLaVhFcTJUUFYxUGtNSTlqYlFSNkVWZVcvUkdReGpPS3NNMnVt?=
 =?utf-8?B?eklRWDdiVEJNOCt5Z2JOWldiUjVuZU84WkNDVEVZUW5xQUxwb0lwYVpCWi9Q?=
 =?utf-8?B?S2M3OWlJWGtkdWRRRjAweHpCRnBxQzFYWnhTSFRqZjZTOW1zUUtHR1psUE9J?=
 =?utf-8?B?SDlmekd6REFVclg4Y21Gc2xJUjc3YmFnd1JaSHAvSmZFNHVzVllyMnFOcjVN?=
 =?utf-8?B?RkFxS1QxQ3VoZkFHdXdnbXZEWkx5VnA0OHN0ZzJ2NS9QbXVrNTVrZXRpV1dI?=
 =?utf-8?B?VnFyd1o0L0JDTG5hdkZTV0tmSENwSFc2eDFBUmd5OE5LUSt6cy9TVE52dWJp?=
 =?utf-8?B?OURjRTZHYlZFeWFKdi8zS0htcVVFczJXQUF3bXJoR2JZT3hRWGUzUkNrUE9p?=
 =?utf-8?B?UXJvR0NSVHFkYm9rMGI2QVRxUXRqUlpQQVpZczQwaUNvMDFDQ2NUVGEweTdF?=
 =?utf-8?B?Q05kclpRQW9BQzJFVkQwMmtxdTljVFE3U3FxM0gremxSaVgxNlNMSEk4R1JF?=
 =?utf-8?B?ekEyMnpUcStUUGpFRzdaQmRNaXA5ZTVXQjErZnByYTVUN1JPYi95Z1hRUTlu?=
 =?utf-8?B?WFlIR1N1OEpSVEpTMEdvQWNLQXhZRWV1Z3d0UnlIRFQxVVlMTzVaNWkvMlZG?=
 =?utf-8?B?cUY2WDBiQnBnSFdDNG1XUy9Nekt4dVh2OVRhNGlOekxqeThrOU5YaXhTcjkr?=
 =?utf-8?B?ZGpwR295ODVUYW1tNmU3aHlSODl4VWdXMGJOWjgxQjVYT3lETWoyQ1g4UEFM?=
 =?utf-8?B?VnJ4S1BsUm5NRHlQcDJ3L2l0aGtvS05CTkJkdklBRlFTdW1QVnZqMWY4aDJ0?=
 =?utf-8?B?aC9SMldEcERhSnVuVFZ4T1EwTXBUZTlNYTRKRkZyUW9URkdVMW9pUVVMZ3VY?=
 =?utf-8?B?b2wwR253anlwVE83MDg0Rzl4WWlLbE15MlhRZUl2dERLNmF0QUU1YTdGUjh1?=
 =?utf-8?B?ekpSTGpDODlVa25oQzVzR050QUZWMEQ5R3d6OXo2ZFZROWEvM281YUZYa0xk?=
 =?utf-8?B?KzZUWFJMYmhLNElibHhIVUIzUTRUb3E4c1g1bGJsUjJZaGhTTUl4aFlXRjBJ?=
 =?utf-8?B?UGtGUXJWKzNveWR2c3dRUGNtQ1dCSlM1ZkRPUXNXaDFDK045bnVscHlodHB2?=
 =?utf-8?B?ZGJUdm1NNWkxbzZFYjlmT1AxdTJkN0JMU0N2a0RJWFVIMi9iYXE3WVJHd1Bq?=
 =?utf-8?B?NlJGa2ZIMmhpaUxmVVh6dHZmZzdvOWwzb0Y4VjhNTlJ2bUxHQzZ5aGpDbUFi?=
 =?utf-8?B?bzdPTlUwajRFSUVWWTQwdkxhRzV6YnFUQStsY0w5YmxUODJTMFQwa2t4ekdG?=
 =?utf-8?B?dXZIWTg4dlNIVTJGcktnSVZJcUpscVl6c2VPa0YzOEY2NCtTRC8xNzc5YlFI?=
 =?utf-8?B?ZE9ERXdLa0F6b3pBYWhBempjWldGdDU5OTdkQ3BFRHIxRGVMVEpBZnpnWUd6?=
 =?utf-8?B?bjM4bFB2L1NBVGVtKzB6Vy9FYnE2aEcwOStmaEF3ODVvWTllbzdic012b3RZ?=
 =?utf-8?B?cUVrVWVyOXk4ZktRNU95OHZWNzN4aldjQnNuUGpXSEFXKzB5Q29oT3g1ZFZ3?=
 =?utf-8?B?dFV4MHlpeXBrUXZUR2pXME5KaWw5ZUdna21ORE8rT29zdGt1TzVIL3ljOU5z?=
 =?utf-8?B?aDhnZnZVWUI2VXZtVmtTQURzZ1NTZys2Q3BTbE5wTWpSNXdNODdhVG9rMWMw?=
 =?utf-8?B?NDJVK2lNSEFvaklFRHJvamhRT3A2YTRXWnhlVmVDbGxBYndnY0EySXhKTnVi?=
 =?utf-8?B?YUJURFFzMXRxbzdpSmhJZWsvUlQ4RHF5b29QcElIWHl3Z0pqbUwvZ0V2b0VB?=
 =?utf-8?B?VFBXZkVjRVRPUmJXeHFqbFF6ZG9Qc0NCNnJoQnRINWZPU0w4ZXAxMUMrR3J5?=
 =?utf-8?B?aDdJTFQ3ZWRyU0dNbTJXeDRYNGErL1l0elB6VGRaMnJSemhWMVQrbUtUb3Bv?=
 =?utf-8?Q?c0aFEEMo1wRGZklQ=3D?=
X-Exchange-RoutingPolicyChecked: QAAMaWONTXp15Ztc3gOY3kb4ke855tZpW9gUIxEyvqqSWr124esyiTvUZIAq+jhDxNlNRyIh8iLWKk2aY2b0L0Ljc5T2geHKh0zL6efBonLTE9N5V14nDuKv8kFrg+efbo1tJGS+kzdIEpTL0ccfpyzJhFQe/5esX65Ft0hzfg+wTi54/YopCLig51fue6kKlfQDXKHKNtKtSzFmsqchJjRe9i9vBIcUDzwv+HCc7CxDuS9UodFYH7G69qSeW9qx9yStAyZaojsZgdlMeJYAjoaREQ/613CY4OuFzlRNZnDZasp9HXqeAbSEHuhgr3IRmrLhqOJEJNbJ5QyKSRpxog==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DxDH7T1DXwccdrfyF+0yjqBbZBQxkqNvVYFhvk7aQ42O9tjZLZmjW6OGbI82J/rlhJm3W7flG8GhsVUl79PVkX48WgA0dvKQKKT62MZXQ2UHuT/LCs0qaRwuQqLlZhMsiGyQ4PXpHVrgtwoKykXDiEczRy/ywj6WYyXJLbIOem8lDQrMKwVRcM3EihVP790MiiS2X4LRSgNiKRfPXGDcZoiVT2wOQpDdXtPsHrTmIozIVJ9Fisosl8IFDSWV99FeRo8klObYyGZoJDcx6RXiUs398a6v+PdimkIOvpyZ7oUbDjWHvPz4idOPhR7IibOXIKI+eJGk3n/otyzIH/cYgiyYgFaum9VGTQW2+uEA+mQct5Mbxh4Q00VBoQV5PaukqRa6p5mqQIKy2qh2+H2dZiQpEauYq5EvkfpgYICsyYOpkydBQW8rCSVCNCWMKaXwW0kFFTav7Mru9A5wdQrmURs3nrelGl05s15vs8eK24RnnF1exk2ydvWp/XGigA/sdMNfcxtDhGk3pdgBAcyFH4Ghl1ZubWnCG8W8YmSqWjnHIznZyZB2RhcLFizd+gvGOduFCG8E+47IDyh8lUIWAjbr9TQ7yLPDrF4o/pnTmhk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856b476d-e702-42d8-bc33-08ded09e941e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 20:41:04.3257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGdAsOQ+Q+lU75V8FB/QvkAJxA3HF5lb1WKgrhdCryYkp2y3utJ22rlasqiGfEdnaKk8Z7j1s4pTTGCpuhu4kVM0cb7eGlmRGD9y+ucg+0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606220199
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIwMCBTYWx0ZWRfX896AdRZ/DK7I
 JWVcPZDPoNcHFnMqi5dpb1ONq8N6o+T+5uCZWyFBYHDE23kxCXL//TTL7av/pIEYMv5w3FrUmb3
 9gCD/0NY5LLklnL8pf1dPjQBUMBhjvi1xc8O3gMblQedKlpijOSw
X-Proofpoint-ORIG-GUID: lfeacYofwz-Rix0CiuAl3fc_u5k0hGGc
X-Proofpoint-GUID: lfeacYofwz-Rix0CiuAl3fc_u5k0hGGc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIwMCBTYWx0ZWRfXyPsKZdyGTG5Z
 7g4UsNwiFPxjL2Uc/fls6DuSnt+5iut4Tw4+Rp035Wei4MvWRBJfNohXeGf4F+mm29z1H7g5xBf
 4PcTOrWPOW6oxBwHv3IUp/gqvnV6lh2TZniBi8EfSFPsIyrngQW60YG/VCl9omlntZn6mMBVpXg
 8w4r6kf+TgH/A+h/WUw6rLVA68DRvujaflVXux8o0DjIcCLowIvmIoaDMSHyQCRBgf1ZE8VxS+c
 ztexQA2ShFP59cj8oPf40rL+0Vk362VhCxloOSgstvH6jcQzrSyo3hbLnSW4xFFvmITb4CgQous
 mOvrnvPOKoKbmjAkiSJ37CI6WlOoC9qc/G5VH5FS4qgcmCqjng14hRUopkQDjLUMrm/D8duhoL+
 0lz7Y7ZXE3LAUPXaygJzfQ6zge6ao1mKnA2xDYrWQ75vIciG7lSbl1G303hF3VGaDf00TLzuMqx
 YsnK1B5qIANFNr5oqR8r7Ev6CxRqbKr4Ta1g9iNA=
X-Authority-Analysis: v=2.4 cv=av+CzyZV c=1 sm=1 tr=0 ts=6a399de6 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=20KFwNOVAAAA:8
 a=zd2uoN0lAAAA:8 a=Hkk0c2P3NTWwfpLoUxEA:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12313
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 6/22/26 4:00 PM, Michael S. Tsirkin wrote:
> On Mon, Jun 22, 2026 at 04:19:50PM +0100, Peter Maydell wrote:
>> On Sun, 14 Jun 2026 at 20:09, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>
>>> From: Sairaj Kodilkar <sarunkod@amd.com>
>>>
>>> When MMIO 0x18[IntCapXTEn]=1, interrupts originating from the IOMMU itself are
>>> sent based on the programming in XT IOMMU Interrupt Control Registers in MMIO
>>> 0x170-0x180 instead of the programming in the IOMMU's MSI capability registers.
>>> The guest programs these registers with appropriate vector and destination
>>> ID instead of writing to PCI MSI capability.
>>>
>>> Current AMD vIOMMU is capable of generating interrupts only through PCI
>>> MSI capability and does not care about xt mode. Because of this AMD
>>> vIOMMU cannot generate event log interrupts when the guest has enabled
>>> xt mode.
>>>
>>> Introduce a new flag "intcapxten" which is set when guest writes control
>>> register [IntCapXTEn] (bit 51) and use vector and destination field in
>>> the XT MMIO register (0x170) to support XT mode.
>>
>> Hi; Coverity points out a use of an uninitialized struct field here
>> (CID 1660056):
>>
>>> +static void amdvi_build_xt_msi_msg(AMDVIState *s, MSIMessage *msg)
>>> +{
>>> +    union mmio_xt_intr xt_reg;
>>> +    struct X86IOMMUIrq irq;
>>
>> Here we declare irq, without a struct initializer...
>>
>>> +
>>> +    xt_reg.val = amdvi_readq(s, AMDVI_MMIO_XT_GEN_INTR);
>>> +
>>> +    irq.vector = xt_reg.vector;
>>> +    irq.delivery_mode = xt_reg.delivery_mode;
>>> +    irq.dest_mode = xt_reg.destination_mode;
>>> +    irq.dest = (xt_reg.destination_hi << 24) | xt_reg.destination_lo;
>>> +    irq.trigger_mode = 0;
>>> +    irq.redir_hint = 0;
>>
>> ...and here we fill in some but not all of its fields...
>>
>>> +
>>> +    x86_iommu_irq_to_msi_message(&irq, msg);
>>
>> ...and here we call a function which (among other things) does this:
>>    msg.__not_used = irq->msi_addr_last_bits;
>>
>> which will read the uninitialized msi_addr_last_bits field.
>>
>> Bonus extra bug report:
>>
>> +union mmio_xt_intr {
>> +    uint64_t val;
>> +    struct {
>> +        uint64_t rsvd_1:2,
>> +                 destination_mode:1,
>> +                 rsvd_2:5,
>> +                 destination_lo:24,
>> +                 vector:8,
>> +                 delivery_mode:1,
>> +                 rsvd_3:15,
>> +                 destination_hi:8;
>> +    };
>> +};
>>
>> Please don't use bitfields like this -- this is not portable to big
>> endian hosts. Use the extract64() function instead, or the FIELD macros.
>>
>> I suggest something like (untested):
>>
>> (at top level in a source file or header; the numbers are
>> start-bit and length, check these as I may have made typos)
>>
>> FIELD(XT_GEN_INTR, DEST_MODE, 2, 1)
>> FIELD(XT_GEN_INTR, DEST_LO, 24, 8)
>> FIELD(XT_GEN_INTR, VECTOR, 32, 8)
>> FIELD(XT_GEN_INTR, DELIVERY_MODE, 33, 1)
>> FIELD(XT_GEN_INTR, DEST_HI, 49, 8)
>>
>> and then in the function you can do:
>>
>>    uint64_t xtreg = amdvi_readq(s, AMDVI_MMIO_XT_GEN_INTR);
>>    X86IOMMUIrq irq = {
>>        .vector = FIELD_EX64(xtreg, XT_GEN_INTR, VECTOR),
>>        .delivery_mode = FIELD_EX64(xtreg, XT_GEN_INTR, DELIVERY_MODE),
>>        .dest_mode = FIELD_EX64(xtreg, XT_GEN_INTR, DEST_MODE),
>>        .dest = (FIELD_X64(xtreg, XT_GEN_INTR, DEST_HI) << 24) |
>> FIELD_EX64(xtreg, XT_GEN_INTR, DEST_LO),
>>    };
>>
>> which gives you a struct initializer and you can rely on the
>> whole struct being initialized.
>>
>>> +}
>>
>> thanks
>> -- PMM
> 
> Indeed. Alejandro should we revert or fix up?
> 
I think the uninitialized struct issue can be quickly fixed using a
designated initializer, so that would directly address CID 1660056.

For the bitfield portability in big endian host problem, the changes are a
bit more involved since there are existing definitions using the same
pattern (dating back to 2018 when IR support was introduced). So to do it
right it involves more changes than just the code touched by the current patch.
It should be relatively straightforward though, so I will work on it and
will send a patch extended Peter's suggestion to all the cases. If run into
issues/time constraints, then by EOW I'll send a simple fix with the
designated initialized approach to fix the coverity report, while I
continue on the "bonus" case.

Does that work?

Alejandro


