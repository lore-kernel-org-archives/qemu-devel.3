Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929DCCAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 08:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0bun-0005JP-SN; Mon, 22 Sep 2025 04:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v0bul-0005Is-S4; Mon, 22 Sep 2025 04:28:51 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v0bue-0003FO-CF; Mon, 22 Sep 2025 04:28:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=en6StsNJlsrymbrJ/d6bnqSz8vJmtxZMfJB2RgH53Pre+FVofQDX/kw7A0N1l9fYNeGOxYGNovXTO2CXnztwgPNMNL9tHYGhBPjXoffbhO3cic7CEjYShC8H5sCYL0qBrKlkoond+Ls3HlcHXaTHYn1M5Cjies6EZrpdnS6zQaAtrn8CaQIiQmp60loUZc7rhA1Jm2A4fi4/ycWlO8GYJ+JIoZ/Ugg7t8hcAFd6XYIEtPrQNMA6P7A1Z/5f8vASYsd+oRapq0K4YMIHzJZUba2wzxSKuXIn7dViicNE/R2qlQ9d+psD+UDbOvVaBg/dC22YgB0Smq6joj6U3wDFfeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRJQws5dmgih4Nj9rG6Msnd1aDKCFRf3uUMgIUWnY50=;
 b=uXWeojSOLRyayi3hosNO45XYIwaAid2BM38fIcD8B4tgPaXQt/Rsn7iAlLshcGNmKWxGfpS8/uuqC6K4ORw9/uOmdz4F0WXKQ13OOPAjWVvUTXUPKg57xIg4A4p86rLnDy3pgSm6vFvJzQgNBSlJwgc/90e0NpV9be+2JfVyQyYtcCcVwknWdaC+Nj4UgKfc9JM9lI3pUjZ6LpO7uC/Uoow0dWRr4t22mLuJR55PvcE6bCAYx7/p/HCp5/QIGdtfG52eOKj/I6r1lIFGidTMRcK75XNQtOYiJ2kVRjg9pJen7Yykw0VBGttGppewX8FkHhuTaB/cvMu90M2qJf0pbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRJQws5dmgih4Nj9rG6Msnd1aDKCFRf3uUMgIUWnY50=;
 b=IGI2y/ARtPGoKz16DBvADTQzav1DNS9gkWDKJp/gWHjDWQQFeAUqlU1C0BVol0DUgxr+rtgkiWFUqECmmiUYzpR50BHviAPkfWYdQrFH9A/7mtz/cYXCEfsZRJ/nhNs4mlc17sZwgajoWbHKFWZ8qS9ANi2jVksO07/h3SuRKHz6Vt16LCJ2ChoJlbCXUuNMIzekAn7A+r4B0jxMw7IqmipaD7UppDQLez2qcAvfgAWO41ibVrsN+171U6H5lkLa/H3BKAW/9QTxzT6xmzPxBa/A0X/KJ05YkF7+u54Qga0lYfjFTXD2U3X4gPNA8iC+O8r9F741pURfHj53ZwQ3VA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA0PR12MB7723.namprd12.prod.outlook.com (2603:10b6:208:431::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 08:28:32 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 08:28:32 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: Nicolin Chen <nicolinc@nvidia.com>, Shameer Kolothum
 <shameerkolothum@gmail.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>
Subject: RE: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Topic: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Index: AQHcJvVSyZvN/mVpTUewNZT1jGrd9rSXuIGAgAABxLCAATN4wIAAk4AAgACX+rCAAfbiAIAC1Xig
Date: Mon, 22 Sep 2025 08:28:32 +0000
Message-ID: <CH3PR12MB7548E2D2DFB71EDE4702C9B4AB12A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
 <aJKn650gOGQh2whD@Asurada-Nvidia>
 <CAHy=t28z=wrXbXOJjD4sFw0RxJR3fccqF-EdaQDB_s_F6RC4FQ@mail.gmail.com>
 <aMsBvSSEzsgeMHkK@Asurada-Nvidia>
 <CH3PR12MB7548347E93651468E70B2470AB17A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <CH3PR12MB7548B6A98B640192579078EBAB16A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aMyA4AHf7pqnOzSV@Asurada-Nvidia>
 <CH3PR12MB7548BB774BB375D5056C062CAB11A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <CAFEAcA_MReA7Lx4Mm8x6mrO9rGaeH_zNYq+EWzS4Zh=j-h-23g@mail.gmail.com>
In-Reply-To: <CAFEAcA_MReA7Lx4Mm8x6mrO9rGaeH_zNYq+EWzS4Zh=j-h-23g@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA0PR12MB7723:EE_
x-ms-office365-filtering-correlation-id: 926c2c08-099d-46fc-c670-08ddf9b203f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?enZtem1DOGJNVDUzengvZU9kcUowdFZLejdxWXBiOCtiNEJ2LzA5cThjc01Z?=
 =?utf-8?B?cUgyVjZwMDFLVTVhRml6M003ZjIySzM3YjlPZ0RvdlVtaUxvd0ZkZVl5MzRy?=
 =?utf-8?B?MHM5bEg3U1J2d2pqd1hDM3lzZWFvRjUzT0xJcVNaZ0t4N3gxQTNGM0dlMm5B?=
 =?utf-8?B?TXo0K0NzL3g1N0oxdlpkeW9TaGlFbnNWc21USlhEQjB6dmJPaHVSZER1MlF2?=
 =?utf-8?B?ekk0VytnWTAvalRENlNiV2JhNWUrRGduTk5RbjkzUVZSa2tYbko5ek9nb1Ay?=
 =?utf-8?B?bGpBS29LMEQwU0tBeENhbnFqNDdZd0VuTjRaZ3JFckpYU2htWTJtVERCRk4w?=
 =?utf-8?B?ZEt3UmpTV3F4cnFYcm43SnU4TTM5WU0rbXRiNm4zKzR0OGIzVXBKRkN1YytD?=
 =?utf-8?B?TTQ4RU4wYk9sRG9meGJsRThmczhhZTRyK2JsRmdseG9LZ29lYzlyY0lNckZ1?=
 =?utf-8?B?M2lRV0hlWHN2TU9vMmc2eDBWMWZXd1NTOUhUc3lKSlozMlpGeXR5NW1NdXF4?=
 =?utf-8?B?bGxmc3FQSTdrNERPTGRjTWdzNTBNZzBsdU1WSDBBUU1KaWREb3UvMlk1RU14?=
 =?utf-8?B?Ulh1YVJKUzArR0kvdUwvajBsYSsyOEJNUG5FclJ5TWVtN1RJT2ZDbzVoc0gx?=
 =?utf-8?B?QW5xVDF1TTRXbk9wb2w4TFNLcnVTNndzRi9ZcHdUWmw5a1J1bUVxQmIzU1pI?=
 =?utf-8?B?dm8xSXVUempDSktLZjlGNEYwdnBFM2hHN01YMHJoT3hKcnVUU2VqTjdVdms1?=
 =?utf-8?B?VVVzaTFIOGh4cDV0WGtZMWpQOEE0Y1BlYjdoR1VTMVhLUEpLSzFGL1lWcFJr?=
 =?utf-8?B?UGcxM3dIQ25aeXlqdHlGK2FPb3F6elJNaXo2TnpxaUtTN2xiZXk1aUNmTytM?=
 =?utf-8?B?bngvRmhvS2dRRjhIZWszZFBIMUxJRGViWG9QSDkzN1FTMHZ6ZEJRRmZyaTgx?=
 =?utf-8?B?NWtvVEwxQmlBVityaDdlU2dham45QkdZdnlycFZjRzRLK1drQzcyMVRkMzFX?=
 =?utf-8?B?RVpIU0N6bU9xTk4yVUt5eVlGNmtuYld6UVN1RDkyY1MvaTNURDlDM2g0R3BD?=
 =?utf-8?B?cys5cFVITGpYZzAzY3lnZUZUQ2NjM3krS29LLytTNUNjOHZVUDRVYUJpYmlO?=
 =?utf-8?B?azNucVN6Q2RUZXpWY0FwUUxyVjhxTlMzZVFlQWZXbVl3L1k5MWRwcExUZTJu?=
 =?utf-8?B?UGV0aWJnT0gyeCtwK2xnZXg4VmVTQlcvVTkwNEhvSUhVemJaM25rc3BUSFpD?=
 =?utf-8?B?WTljMmplalBLc0k1bUszVk9heGs4dHJqanJoU1N1Z3JHZnZNL2o3TDVlUitp?=
 =?utf-8?B?WHhNSy9oRmFJOEJ4eVUyZEhPNCtXUWlRN1BtdmtSOVhSUit5YURjYVE3UUF3?=
 =?utf-8?B?NjNMako1bTRwd25zSHI2NVJ4eElGOVNJK1AwNElOMmtQLzAvZWx4ajdLT0oy?=
 =?utf-8?B?REVOd1dqRTRtR0txNU0zV29Ra1VrYmtOSG1TZ0NaQ3pPeFB6UCtYOHpyaUFk?=
 =?utf-8?B?SWozd0FUdlpHdmU0cllGZXBRdUFOUUdlb21sRnFsU0V3THZzVHhXOEpUWE8y?=
 =?utf-8?B?ak52NWtDOGFhVTBOYjQ3MUhNWnJjWmExRGpVcEF0TFB2NlNLajhmRVVrUC9E?=
 =?utf-8?B?eFFtUktMYk1hZHJBNDdpSjloRlZQeGV4Y2N3U3YwSkI3RXZLRG00K3ZoaVl3?=
 =?utf-8?B?MjMxQy9jcXVhWGNzd2tLT3BtdU5vdlRXaHJJd2t4QnNhS1JZZ1lrcW5XaXBC?=
 =?utf-8?B?N0lVZnJSVUlONFU0L1ZObmh0bzVkTlRCK3piZXhCaTBId1RYR2Z5cUNpTzJ4?=
 =?utf-8?B?WmpWUUR3UThyeFJDMnk1RitEQ3JwelA2N25OWmlUOFhJVlpIbFVZNDU2b2dz?=
 =?utf-8?B?R0dwUDkrNmZ3NjI4N1RVNkVMazZ0clErSi9oMXNpTVA3R1FTdmh1ODBkSUZL?=
 =?utf-8?B?K293dXFuTE1zSVV2Q0FldTVUeEc3cmJ5WDhFTFBNL0R5bU1DYWl3ek8wcjJF?=
 =?utf-8?Q?S56anXXtjBb51WMShVpPFge/ghTEPA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjBWSy9EbUFHNk5GSnVJZVNadTd6anVwTnUvNzBNYmdhbjJ6R081RmZjZmxj?=
 =?utf-8?B?QWNSVVlBbk9hMERkSW1VQis4cFhFTkYvcXNibFlseTRUeHBIV0xOMGp6b2VM?=
 =?utf-8?B?a0YvNkdkTUtweEg2aVdJZXZnRVRyREFzWm5RYjB5S3Z3RFF4QWZ4TXVpZVIv?=
 =?utf-8?B?ZWFKYTFTdkZzUEhGVlAxM1NlUEl0UkhDRzF0L3JvMmFJYTdEYWJmcndxSGlC?=
 =?utf-8?B?VDZiZ3lHaUdmTjRVcUhBYnhqeWdZeW5MK1J2NEFidE1pUm5qT1dMcGJNc25R?=
 =?utf-8?B?bFZVMEVxR0ZMeUlwMFVNV3ZBT05XbDMxYVpnNnF3R290eWtOeVl2S1pNN2pH?=
 =?utf-8?B?WE1Mc3BLa0E1aUorRjBXNEJzQitadXJUZmJJdm14eWRqYkw4N3BWN1VscmQy?=
 =?utf-8?B?K2duU1pERTRmTVl4azd0V2hhOXNEMzIxZFFVSDdXeC81QWR6OWkzMVE3UTl3?=
 =?utf-8?B?emNEYmFzL0I5Q2E5SXBxVkJlQTV2ZnVLQUJKU0x0cWcydDU1RWhpSFA5cWdO?=
 =?utf-8?B?SG5RT1hSWDY4Z3d5VFpJS1VRYVBlRXlLTjgvTkhmWHFhMUo3T0ZzVHhER09W?=
 =?utf-8?B?eTNxOG5HYW1saGV1QnFzeDNWRmN0ekQ2K2M2emNHU28wWStTMkx6eGJQWlBQ?=
 =?utf-8?B?aVZOS0MrYkxtc212VS8wNG4zMXFNdW1PaDFBWm4wTForVnJVNWI0c1FyVlE2?=
 =?utf-8?B?OFlPandHYzA2RU4vRDJZRU1NUnR2eGpZMm13ZlJTRnZub21rRG1WK3o3OXRW?=
 =?utf-8?B?TEd0UFlqWHRUdm5MTzdGZm1DOWIvczkzbDZWa0VuYmt0R0p4RTJSWThUZDVQ?=
 =?utf-8?B?ZXk4cC9tQ0U0ejhPOHk1SkhtQTR2Q3NNa3R3Z1d6S2wxNm9zTDR6SGlhNTZN?=
 =?utf-8?B?SklUbG5GNFN1S2RtVnRXa3M1dy9OVHZUWDl4aktMOFlSY1AwdGdLb2dUMnMw?=
 =?utf-8?B?YXN3NFQvR2RhMm5pNzFlQm5uSzNrWDkrTXUvcGVBT2tvdEl6OC9kdHpvWEg5?=
 =?utf-8?B?Qk5ORTFWb0RMOVZvZTF0MzBlYTJVMExKZTJKWU4ya3BIR0N1c21kdjBpWkJK?=
 =?utf-8?B?YTcwaFE3bWtBMEpMbXUvRUFIY05EWFFHRkJYdkk2b2l1SC92RWdJd1dHd05F?=
 =?utf-8?B?cjduZFVXUDZVeW9oWEZmU3FvVVExbzJHcXQ2MnVyUU1YRUVFOWhRTjYxa01V?=
 =?utf-8?B?L09nbVBMb2VLRzNzV2FzTE9WZUc5TjFLRWV2Nml4Y0tsVkNxem81YW9Wd0Fq?=
 =?utf-8?B?b3k2dVdRamE4N0ZGRVhNNHJidmRFc1FXcDZaNG1pSGZwOURMakZKaVRjNmlD?=
 =?utf-8?B?d0FXaC9TYjY2dTRUSDZXWi9PVWFHRVJFSWFpRnd2UkMzMFdCSnRYeTBWdFFY?=
 =?utf-8?B?UXU4RTBmSDlhdlpHakNBU2hoZ1hLcVRKcm1xMHFRTENvaWNENm9ySnFnd1A1?=
 =?utf-8?B?b2dIelkrRTduU2dnZWpDMXFwMEpXbFhaZnZQYVVxbWJVV3FNUHh3c3JxTVc2?=
 =?utf-8?B?K3lhQksvbGNrMVU4SzM4M0xVN3NBQ0pSQmZQZU1acDlFaTM5VDRndmFYZm1N?=
 =?utf-8?B?RzNKSWxOeUU1a1BhSDlxZnVhc1dEbW9uVFI5RmtackpPK3JhQmJkb3ZjU2xm?=
 =?utf-8?B?VEdRNmZUZ1U4V1kxbS9IbUMvWm4yQUlOb21DTEhKNjVvaFJjb0g1SnhxNzNP?=
 =?utf-8?B?ZEZxdEh6MXNaaU5uaVc1VXRFTk11blNvc0tsa3FEMzRZdW9xQlR1a0c0NzBH?=
 =?utf-8?B?MjNnd0lJSkM5ZlAxMFFEK1hVY01lVlRDSWEzV2poZ0RsbS9GdWU2TkxKUk9M?=
 =?utf-8?B?dHJ1RHFHREZCc2tUWWFzWncxWTBQbXdNK2ErY0YwUUNob1BnV3hqZDhNMTJ1?=
 =?utf-8?B?NTlCZlFLcU1XWGIxNkswMGpTODZKd29xVUI1NXdrbHhYdFRHcm1kcSttQUhT?=
 =?utf-8?B?ajlMM2xIbTBJcm54MnB6dXVZK0xQL3B6c29sR0RnZUdMenB2RlVra3gvYng2?=
 =?utf-8?B?VmtNOEZGUVJPVmYrZUNZMEpOUCtidFkvb2VONkN5cnBDbnlpU0xJNkNkdnZy?=
 =?utf-8?B?ZytVUmNjN0lrWnFnRmNERjgvZzlPVlBFbS90Y0xpSnMxTDd5K3djdFQ1eGdQ?=
 =?utf-8?Q?KQg7dz0IEToMQnAyqMeQLBNWO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926c2c08-099d-46fc-c670-08ddf9b203f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 08:28:32.2536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bxr4Lpjv6TVguRVUjUXvS3+qmcxUlXNTwjfhwLLn2wNj0MikksZBeuvTtqiwoW3OfkVHrUi9LPg/abkvcVYpog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7723
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=2.883, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMCBTZXB0ZW1iZXIgMjAyNSAxNDow
NA0KPiBUbzogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+DQo+IENj
OiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBTaGFtZWVyIEtvbG90aHVtDQo+
IDxzaGFtZWVya29sb3RodW1AZ21haWwuY29tPjsgcWVtdS1hcm1Abm9uZ251Lm9yZzsgcWVtdS0N
Cj4gZGV2ZWxAbm9uZ251Lm9yZzsgZXJpYy5hdWdlckByZWRoYXQuY29tOyBKYXNvbiBHdW50aG9y
cGUNCj4gPGpnZ0BudmlkaWEuY29tPjsgZGR1dGlsZUByZWRoYXQuY29tOyBiZXJyYW5nZUByZWRo
YXQuY29tOyBOYXRoYW4NCj4gQ2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPjsgTWF0dCBPY2hzIDxt
b2Noc0BudmlkaWEuY29tPjsNCj4gc21vc3RhZmFAZ29vZ2xlLmNvbTsgbGludXhhcm1AaHVhd2Vp
LmNvbTsgd2FuZ3pob3UxQGhpc2lsaWNvbi5jb207DQo+IGppYW5na3Vua3VuQGh1YXdlaS5jb207
IGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7
IHpoZW56aG9uZy5kdWFuQGludGVsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAw
Ni8xNV0gaHcvYXJtL3NtbXV2My1hY2NlbDogUmVzdHJpY3QgYWNjZWxlcmF0ZWQNCj4gU01NVXYz
IHRvIHZmaW8tcGNpIGVuZHBvaW50cyB3aXRoIGlvbW11ZmQNCj4gDQo+IEV4dGVybmFsIGVtYWls
OiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gT24g
RnJpLCAxOSBTZXB0IDIwMjUgYXQgMDg6MzgsIFNoYW1lZXIgS29sb3RodW0NCj4gPHNrb2xvdGh1
bXRob0BudmlkaWEuY29tPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRp
YS5jb20+DQo+ID4gPiBTZW50OiAxOCBTZXB0ZW1iZXIgMjAyNSAyMzowMA0KPiA+ID4gVG86IFNo
YW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiA+ID4gQ2M6IFNoYW1l
ZXIgS29sb3RodW0gPHNoYW1lZXJrb2xvdGh1bUBnbWFpbC5jb20+OyBxZW11LQ0KPiA+ID4gYXJt
QG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgZXJpYy5hdWdlckByZWRoYXQuY29t
Ow0KPiA+ID4gcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBKYXNvbiBHdW50aG9ycGUgPGpnZ0Bu
dmlkaWEuY29tPjsNCj4gPiA+IGRkdXRpbGVAcmVkaGF0LmNvbTsgYmVycmFuZ2VAcmVkaGF0LmNv
bTsgTmF0aGFuIENoZW4NCj4gPiA+IDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMgPG1v
Y2hzQG52aWRpYS5jb20+Ow0KPiA+ID4gc21vc3RhZmFAZ29vZ2xlLmNvbTsgbGludXhhcm1AaHVh
d2VpLmNvbTsNCj4gd2FuZ3pob3UxQGhpc2lsaWNvbi5jb207DQo+ID4gPiBqaWFuZ2t1bmt1bkBo
dWF3ZWkuY29tOyBqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb207DQo+ID4gPiB6aGFuZ2ZlaS5n
YW9AbGluYXJvLm9yZzsgemhlbnpob25nLmR1YW5AaW50ZWwuY29tDQo+ID4gPiBTdWJqZWN0OiBS
ZTogW1JGQyBQQVRDSCB2MyAwNi8xNV0gaHcvYXJtL3NtbXV2My1hY2NlbDogUmVzdHJpY3QNCj4g
PiA+IGFjY2VsZXJhdGVkIFNNTVV2MyB0byB2ZmlvLXBjaSBlbmRwb2ludHMgd2l0aCBpb21tdWZk
DQo+ID4gPg0KPiA+ID4gT24gVGh1LCBTZXAgMTgsIDIwMjUgYXQgMDY6MzE6NDNBTSAtMDcwMCwg
U2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPiA+ID4gPiA+ID4gQEAgLTM3LDcgKzM3LDYgQEAg
dHlwZWRlZiBzdHJ1Y3QgU01NVVMxSHdwdCB7DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+
ICB0eXBlZGVmIHN0cnVjdCBTTU1VdjNBY2NlbERldmljZSB7DQo+ID4gPiA+ID4gPiA+ICAgICAg
U01NVURldmljZSAgc2RldjsNCj4gPiA+ID4gPiA+ID4gLSAgICBBZGRyZXNzU3BhY2UgYXNfc3lz
bWVtOw0KPiA+ID4gPiA+ID4gPiAgICAgIEhvc3RJT01NVURldmljZUlPTU1VRkQgKmlkZXY7DQo+
ID4gPiA+ID4gPiA+ICAgICAgU01NVVMxSHdwdCAgKnMxX2h3cHQ7DQo+ID4gPiA+ID4gPiA+ICAg
ICAgU01NVVZpb21tdSAqdmlvbW11Ow0KPiA+ID4gPiA+ID4gPiBAQCAtNDgsNiArNDcsNyBAQCB0
eXBlZGVmIHN0cnVjdCBTTU1VdjNBY2NlbERldmljZSB7ICB0eXBlZGVmDQo+ID4gPiBzdHJ1Y3QN
Cj4gPiA+ID4gPiA+ID4gU01NVXYzQWNjZWxTdGF0ZSB7DQo+ID4gPiA+ID4gPiA+ICAgICAgTWVt
b3J5UmVnaW9uIHJvb3Q7DQo+ID4gPiA+ID4gPiA+ICAgICAgTWVtb3J5UmVnaW9uIHN5c21lbTsN
Cj4gPiA+ID4gPiA+ID4gKyAgICBBZGRyZXNzU3BhY2UgYXNfc3lzbWVtOw0KPiA+ID4gPiA+ID4g
PiAgICAgIFNNTVVWaW9tbXUgKnZpb21tdTsNCj4gPiA+ID4gPiA+ID4gICAgICBzdHJ1Y3QgaW9t
bXVfaHdfaW5mb19hcm1fc21tdXYzIGluZm87ICB9DQo+IFNNTVV2M0FjY2VsU3RhdGU7DQo+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gVGhhdCdzIGNoYW5naW5nIGZyb20gYW4gaW9hc19pZCBwZXIg
VkZJTyBkZXZpY2UgdG8gYW4gaW9hc19pZCBwZXINCj4gPiA+ID4gPiA+IHZTTU1VIGluc3RhbmNl
LCByaWdodD8gSSB0aGluayBpdCdzIHN0aWxsIG5vdCBlbm91Z2guDQo+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gQWxsIHZTTU1VIGluc3RhbmNlcyBjb3VsZCBzaGFyZSB0aGUgc2FtZSBpb2FzX2lk
LiBUaGF0IGlzIHdoeSBJIHB1dA0KPiBpbg0KPiA+ID4gPiA+ID4gdGhlIFNNTVVCYXNlQ2xhc3Mg
YXMgaXQncyBzaGFyZWQgc3RydWN0dXJlIGFjcm9zcyB2U01NVXMuDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiBBaC4ueW91IG1lYW4gaXQgaXMgYmFzaWNhbGx5IHBlciBWTSB0aGVuLiBHb3QgaXQuDQo+
ID4gPiA+DQo+ID4gPiA+IFJlZ2FyZGluZyB1c2luZyBTTU1VQmFzZUNsYXNzIGZvciB0aGlzLCBp
dCBsb29rcyBsaWtlIE9iamVjdENsYXNzDQo+IG5vcm1hbGx5DQo+ID4gPiBob2xkcw0KPiA+ID4g
PiBmdW5jdGlvbiBwb2ludGVycy4gRXJpYyBoYXMgbWFkZSBhIHNpbWlsYXIgb2JzZXJ2YXRpb24g
ZWxzZXdoZXJlIGluIHRoaXMNCj4gPiA+IHNlcmllcy4NCj4gPiA+ID4NCj4gPiA+ID4gIEBFcmlj
LCBhbnkgc3VnZ2VzdGlvbnM/DQo+ID4gPiA+DQo+ID4gPiA+IElzIHVzZSBvZiAmYWRkcmVzc19z
cGFjZV9tZW1vcnkgZGlyZWN0bHkgaW4NCj4gc21tdXYzX2FjY2VsX2ZpbmRfYWRkX2FzKCkNCj4g
PiA+IGEgY29tcGxldGUNCj4gPiA+ID4gbm8tZ28sIGdpdmVuIHdlIGFyZSB0YWxraW5nIGFib3V0
IGhhdmluZyB0aGUgc3lzdGVtIGFkZHJlc3Mgc3BhY2UgZm9yIGFsbA0KPiB0aGUNCj4gPiA+IFNN
TVV2Mw0KPiA+ID4gPiBhY2NlbGVyYXRlZCBkZXZpY2VzIGhlcmU/DQo+ID4gPg0KPiA+ID4gc21t
dXYzX2FjY2VsX2ZpbmRfYWRkX2FzKCkgaXMgcGVyIGluc3RhbmNlLiBTbywgaXQgd291bGRuJ3Qg
c2hhcmUuDQo+ID4NCj4gPiBNeSBzdWdnZXN0aW9uIHdhcy4uLg0KPiA+DQo+ID4gc3RhdGljIEFk
ZHJlc3NTcGFjZSAqc21tdXYzX2FjY2VsX2ZpbmRfYWRkX2FzKC4uKQ0KPiA+IHsNCj4gPiAuLi4N
Cj4gPiAgICAgaWYgKHZmaW9fcGNpKSB7DQo+ID4gICAgICAgICByZXR1cm4gJmFkZHJlc3Nfc3Bh
Y2VfbWVtb3J5Ow0KPiA+ICAgICB9IGVsc2Ugew0KPiA+ICAgICAgICAgcmV0dXJuICZzZGV2LT5h
czsNCj4gPiAgICAgfQ0KPiA+IH0NCj4gPg0KPiA+IGllLCB1c2UgdGhlIGdsb2JhbCB0byBzeXN0
ZW0gbWVtb3J5IGFkZHJlc3Mgc3BhY2UgaW5zdGVhZCBvZiBjcmVhdGluZyBhbg0KPiA+IGFsaWFz
IHRvIHRoZSBzeXN0ZW0gbWVtb3J5IGFuZCBhIGRpZmZlcmVudCBhZGRyZXNzIHNwYWNlLiBUaGlz
IHdpbGwgcHJvdmlkZQ0KPiA+IHRoZSBzYW1lIHBvaW50ZXIgdG8gVkZJTy9pb21tdWZkIGFuZCAg
aXQgY2FuIHRoZW4gcmV1c2UgdGhlIGlvYXNfaWQuDQo+ID4gSSBjYW4gc2VlIHRoYXQgUUVNVSB1
c2VzICImYWRkcmVzc19zcGFjZV9tZW1vcnkiIGRpcmVjdGx5IGluIG1hbnkNCj4gcGxhY2VzDQo+
ID4gKHBjaV9kZXZpY2VfaW9tbXVfYWRkcmVzc19zcGFjZSgpLCBldGMpLiBJIHRoaW5rIHRoZSBp
ZGVhIGJlaGluZCBhDQo+IHNlcGFyYXRlDQo+ID4gYWRkcmVzcyBzcGFjZSBpcyB0byBoYXZlIHBy
aXZhdGUgb3duZXJzaGlwIGFuZCBsaWZldGltZSBtYW5hZ2VtZW50DQo+IHByb2JhYmx5Lg0KPiA+
IE5vdCBzdXJlIHRoZXJlIGFyZSBhbnkgb3RoZXIgY29uY2VybnMgaGVyZS4gUGxlYXNlIGxldCBt
ZSBrbm93IGlmIHRoZXJlIGFyZQ0KPiA+IGFueS4NCj4gDQo+IEkgZG9uJ3Qga25vdyBhYm91dCB2
ZmlvLCBidXQgd2h5IGlzIGl0IHNwZWNpYWwgaGVyZT8gR2VuZXJhbGx5DQo+IGRpcmVjdGx5IGRv
aW5nIHN0dWZmIHdpdGggYWRkcmVzc19zcGFjZV9tZW1vcnkgaXMgbm90IGEgZ29vZA0KPiBpZGVh
IDogeW91IHNob3VsZCBiZSBkZWFsaW5nIHdpdGggd2hhdGV2ZXIgYWRkcmVzcyBzcGFjZSB0aGUN
Cj4gYm9hcmQgbW9kZWwgaGFuZGVkIHlvdSBhcyB3aGF0IHlvdSBkbyB0cmFuc2FjdGlvbnMgdG8u
IFdlDQo+IGhhdmUgYSBsb3Qgb2YgbGVnYWN5IGNvZGUgdGhhdCBhc3N1bWVzIGl0IGNhbiBkaXJl
Y3RseSB3b3JrDQo+IHdpdGggYWRkcmVzc19zcGFjZV9tZW1vcnksIGJ1dCB3ZSBzaG91bGQgdXN1
YWxseSB0cnkgdG8gYXZvaWQNCj4gYWRkaW5nIG5ldyBjb2RlIHRoYXQgZG9lcyB0aGF0Lg0KDQpU
aGUgZ29hbCBpcyB0byByZXR1cm4gdGhlIHNhbWUgc3lzdGVtIGFkZHJlc3Mgc3BhY2UgcG9pbnRl
ciBmb3IgYWxsIGRldmljZXMNCmJlaGluZCB0aGUgYWNjZWxlcmF0ZWQgU01NVXYzcyBpbiBhIFZN
LiBUaGF0IHdheSBWRklPL2lvbW11ZmQgY2FuDQpyZXVzZSBhIHNpbmdsZSBJT0FTIElEIGluIGlv
bW11ZmRfY2Rldl9hdHRhY2goKSwgYWxsb3dpbmcgdGhlIFN0YWdlLTIgcGFnZQ0KdGFibGVzIHRv
IGJlIHNoYXJlZCB3aXRoaW4gdGhlIFZNIGluc3RlYWQgb2YgZHVwbGljYXRpbmcgdGhlbSBmb3Ig
ZXZlcnkNClNNTVV2MyBpbnN0YW5jZS4NCg0KSWYgZGlyZWN0bHkgdXNpbmcgJmFkZHJlc3Nfc3Bh
Y2VfbWVtb3J5IGluIFNNTVV2MyBpcyBkaXNjb3VyYWdlZCwgdGhlDQpvdGhlciB0d28gb3B0aW9u
cyBjb25zaWRlcmVkIHNvIGZhciBhcmUsDQoNCiAtTWFrZSB1c2Ugb2YgU01NVXYzIE9iamVjdENs
YXNzIHRvIGNyZWF0ZSBhIHNlcGFyYXRlIEFkZHJlc3MgU3BhY2Ugc28gdGhhdA0KICBhbGwgaW5z
dGFuY2VzIGNhbiByZXR1cm4gdGhlIHNhbWUgcG9pbnRlci4gQnV0IGl0IGxvb2tzIGxpa2UgI09i
amVjdENsYXNzDQogIGlzIG1haW5seSB0byBob2xkIGZ1bmN0aW9uIHBvaW50ZXJzIGFuZCwgQUZB
SUNTLCBBZGRyZXNzU3BhY2UgaXMgbm90IGFuDQogIG9iamVjdCB0eXBlIG1ha2luZyBpdCBkaWZm
aWN1bHQgdG8gYXNzb2NpYXRlIHRoZSBwdHIgdXNpbmcNCiAgb2JqZWN0X2NsYXNzX3Byb3BlcnR5
X2FkZC9vYmplY3RfY2xhc3NfcHJvcGVydHlfbGluayBldGMuDQoNCiAtU2FtZSBwcm9ibGVtIGlm
IHdlIGRvIGl0IHdpdGhpbiB2aXJ0IGNvZGUuIEhvdyBjYW4gd2UgbGluayBpdCBpbiB2aXJ0IHdp
dGgNCiAgU01NVXYzIGRldiBzdGF0ZT8NCg0KUGxlYXNlIGxldCBtZSBrbm93IGlmIEkgYW0gbWlz
c2luZyBzb21ldGhpbmcgYW5kIHRoZXJlIGlzIGEgd2F5IGFyb3VuZCB0aGlzLg0KQW55IHBvaW50
ZXJzIGFwcHJlY2lhdGVkLg0KDQpUaGFua3MsDQpTaGFtZWVyDQo=

