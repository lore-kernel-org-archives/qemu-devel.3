Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E2DD29C40
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 16:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhrk5-0000Q8-MN; Mon, 19 Jan 2026 11:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vhrje-0000He-JO; Mon, 19 Jan 2026 11:04:13 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vhrja-0008Lu-GU; Mon, 19 Jan 2026 11:04:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=caQ/HTLp4fFXUSSAEc3NO3oRMUL1oZHCRl+1b0NcUifAR5fDNBnUWNdzSPCiMp1/4mK0qT7tYHTqNGOSWZp3f6tPzEb3ySwRzOaXSo3IEkE4SHosnOAmlvdcH/3ZjVsUh2R/o7WzWVe0TF/y5dfMjN13txbSquKTQo5IVU2y2Obq1Bnh2Z5/YbqCmHRbPvMNUzzVsrFu6FrG3MbXQEVc2eEXjaF+5o9Mbz9uwhOvANBbZWtXQKuXLMZozyvFlJFmj2zsxIhMRNBZ3mGONym9axRfcIy5Dt+LHfXIdN/zXUcETDAoJerU7Ww4CdFimMhESba2rNftm0hK4wNsEGu3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukUzW5XsIO7b9lOxw5HsShIgTlSfULpRI2qDrF1qKgo=;
 b=sGylfRndvt2VdWJUKrWsOjt3LW2UPekRPlrGLbveoFC0hdSZxHlE0Ren0v9rW32UoSRxJYKq1MqzDWo5aLHAQJujsBCjufYbwd1oo4+QSkU7rItRFlg77jkT9SY6N84EYrN9+t8y/k7+iLM8p2b27Hb6AJ8ek9X37mR8yW5OlCKHmHcl5kIB6qK7AqCqaOA+QhI4IWxiNOn1llUHBfheuPgWndY03xpWvEOdW4gdnVubfWLEmeN6y2shTVtT2/0Wbcosokh22Kzj39Tt0618VlOXEQhF5SzydjD1iKs4a8bqXP3PYheztILNMVwAwU/GJ+AieO0UZ1RUxuDwQ524JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukUzW5XsIO7b9lOxw5HsShIgTlSfULpRI2qDrF1qKgo=;
 b=SuLRFgjJVGCA3kRbki4xCgpBTMj5aql/ZfrL6R4v2DbuO1WT7hLLi1ox5/KBW7QJJ5hHd5e/gnqBJEHuHxQMWvudUwbV2LYA0gptEakTvIBm4VGYtCur94uG3SOL8j6qe3tdxkfl4cYv0st8UWv7YBIPX3hmRCHglQVR97GeIeNLsfM7H2prCvUSdu2o4sTfHCkTRdNwTxAb1VWONyTYGItcimCwEh2BkmjNB7XcGouv2KHB2scsvrQSyHsnmpoTd97xzyg6CsXBiP56mTCTYaMCBijU/cJHglSCleN0OgYYYkkMzfRtjj5OyBYfUofzCLd2gP/4f0hNgpWiBuPtWQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 16:03:59 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 16:03:59 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Zhangfei Gao
 <zhangfei.gao@linaro.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>, "Michael S .
 Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH v7 33/36] hw/pci: Add helper to insert PCIe extended
 capability at a fixed offset
Thread-Topic: [PATCH v7 33/36] hw/pci: Add helper to insert PCIe extended
 capability at a fixed offset
Thread-Index: AQHchQzQWMpnqnwbYUGleR31M25t67VRdhUwgAg5ggCAAABrMA==
Date: Mon, 19 Jan 2026 16:03:58 +0000
Message-ID: <CH3PR12MB7548736318E8C31AEC63D43CAB88A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
 <20260111195508.106943-34-skolothumtho@nvidia.com>
 <CABQgh9FwSTB8Cp8f1POSBti376ZH3B0e0mLu9FU==p1wVwquGg@mail.gmail.com>
 <CH3PR12MB7548626563C6E67FB802D850AB8FA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <c796d5e8-6859-41e6-87f9-b1195dddeb1a@redhat.com>
In-Reply-To: <c796d5e8-6859-41e6-87f9-b1195dddeb1a@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|MW5PR12MB5598:EE_
x-ms-office365-filtering-correlation-id: 56656cf0-cbc7-42fd-0a31-08de57745b24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?QkhRaU5aRFpOWm1EdXUxdVFBU2RqVHQwL2hEdnNrVGdLUkFTcmhMNDlyY1ps?=
 =?utf-8?B?TlJJc2Q3UGF6TVZhd0hUTVl4NkFTdFVvTFpyUWoxMGY5T0dHWWRMbFZvdDZV?=
 =?utf-8?B?WUxNNXpsTGxldENxWEZRMGpGWENoV3hoS1lqWWN6TTREejZhNW9IYzhkcFBh?=
 =?utf-8?B?aGgyVmd1SE1FbWQ0eEluU0h4bGhqcHQrQVVwdFdDbDE3VTYvZFFVZEdiK2xk?=
 =?utf-8?B?VHpFUGNvTFlnQlpqMml0UDgzYVZzSGZHbmM3cElBblVOd1dmRkk1S2pSOTNB?=
 =?utf-8?B?N2dqUGEwK040UzVxazJJZmRIV3lQYnU5SGZ1UDh5ZFN0Nk5uUkk5WXdpVlJQ?=
 =?utf-8?B?eUNvTFZHaHBLck0xajNDV002aWJhamZSUHdYRmdJVUNhQTdKWXRXcUFQcFB5?=
 =?utf-8?B?V1ZkdHpwL213aWxPbTBwajd5NVVEamVESXEyVFZrOGZ2aW5pUXc0SUVXMFY3?=
 =?utf-8?B?TUFCU1JrM0txOFVvTTJSdVJQWWVIT3pBQ3BrbWs4bE05Y1JMbGlRUEEzYTlE?=
 =?utf-8?B?TWZVR2FVaDlVWmN0OXhQc0VGYmM5NDk3ckV1dWdQM2tFbUt5bFZTcVVUUk1O?=
 =?utf-8?B?cm9jVTRGNHZzZHlTOEdsN2lockFQVkY0MUt5N244K0p5TVd5bEZSMHVxVEVJ?=
 =?utf-8?B?WHZqVnBGNWdzSkM4Q2NqVktvYU83K2pveVNnQkQxcW1wNkZyU05aRit1RkRY?=
 =?utf-8?B?azVOclM0UEErU1JjaTlCRlFROVJSQ3RrdHRrSmp4ZFBLaTRwYkNPdnpTZW1t?=
 =?utf-8?B?d1BVMjFvb3NGc3BGZHZiam5KOWhQZWdqWmFTUDNJZG93TDVJYUcvKzN3b0NX?=
 =?utf-8?B?QTVpeGtHaWVVeURxVVFyc2hVOXVUY21tUzhka2huSDlWUWJId0ZuOXk2bUV0?=
 =?utf-8?B?eU1LQzduRXZ0bzYrbG96MmUxM1BvM1FLMGEwZmlMSXNPeHE4a3NmWmZuRzVh?=
 =?utf-8?B?QUgxalI2SXIrTTJQcW93RFc3cW03SnVBMWRYTk5ZTjNkNFV0Nk9UdTdpWHgw?=
 =?utf-8?B?QnhpN2JERzhabjZnK2VWNG91TjVVbGwzRWRMUm9ZUG9GenVtbm5ZWnFZMnlI?=
 =?utf-8?B?dWpDRm1PNlhUV1RkV2cwMUVTamk4Z0FoencvVHREYVRjcWVGQnpLQXd6RWE2?=
 =?utf-8?B?dC9sWlp0T3N4MXJ4Uis0U1kwWDJmOU9pVFRyamx2S1RvdklpMDRBRUFWWGcw?=
 =?utf-8?B?cVVJWVY1SXdJUGV4RVFKL211Rm1sWUR3KzB2TjJtQWgvUDVXWldtYkhmc1Ux?=
 =?utf-8?B?NHlnc1RNVUU4QjlCM0lFNFpyazQ4MVZ3MmszMjJpV1k4b2NtNlI2RGJOc0Ja?=
 =?utf-8?B?T3dyNE5ScWJkei9BcDhsR0llRTRpN1ZtMFpvbkJjMnpXZ0creXVyV2pBR2cw?=
 =?utf-8?B?RzR3L051dlE4MEFiQXVvdFRQSDJjcFlCUXBuSERQZkdPOHEwL2hEYllVTU9t?=
 =?utf-8?B?SlRuSHk2NlAwWEhzelI0NXAvRHg5anExejZibkZBaGJuME5kT3g0ZnNGY0Y5?=
 =?utf-8?B?QktPTk1NZVZKZTBGLzAvd2F2cGtVOWE0dkE4NDh3RE1HeDZWd1dVRnM5TVZG?=
 =?utf-8?B?NVRCSElTWjkxOTlzUDlXK1UwbGpuSFB1UlVKK25FWUhDM0Exb0twMStXd2VX?=
 =?utf-8?B?T3RaY0M4TlJCREd4S0RaZUtsRVBEdlJpQlRPWHFOd3pqQjh6STV3THpMU2VP?=
 =?utf-8?B?OXY3V1FrZ1BIVTgwT0t0MU5MWm1oOE5ORng5SkpLUFB2UWVHbDRsV3QwMEQ5?=
 =?utf-8?B?bW9qbytLbzJDZEhYMVVJMm9jb0N5cDVYTnhnODRlRFZ6Y1NPZmd0R0huYmR5?=
 =?utf-8?B?YVNWem5RKy9Mc0RBc3BEbzJ0d2oyQnBmWWUxcURkZ0JVZ09VYzhLWXF0Titv?=
 =?utf-8?B?eDR1aHN2V0IzVTIrTkV6VnNVNVlpaGlYc3FQVytISk1UTVdjVXJSM3VkRjhj?=
 =?utf-8?B?RjNmQjVZOUl1d2RsczhlQ0hFQ2JLMjkxY3ptaXNQNldEM0xTUG8xZU1LdXRh?=
 =?utf-8?B?SXI2bTRvMllsbHY4WjFwYzdFK1NwOTdxRGxjR0c2dUZCbDRzdk9nSUIrcjh3?=
 =?utf-8?B?VzZnM01wSk9iamg1SmlIcnFBNHJ4QzB2Szh3c1RGNjdzVjh0dDZlRlk4bUFN?=
 =?utf-8?B?U2VZbGxnWWxKeHVFeTJQR3dXVHZoZTZTVjF3Tjd4aHlEelFLMjd4MmVOM2lW?=
 =?utf-8?Q?yJHy9TZ/FW3NG33eIJRnCas=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkxkSFU5SWtjZ0VaNGl4Y1JrdC9HZTJHRE9PdUt3QVVSVWRDYXRTcFNxVXlL?=
 =?utf-8?B?bG5rYzUxd0ZLOXlzdG93N3FpdEpETndLQjc5eFA5cGFuK2NUQ0V3QjRRMnh4?=
 =?utf-8?B?dFMxWk5ZUE13Q1E5bi9QVTFUbktjOHVZaktCT0Q2RDZmOHZnTzhseU91M1dR?=
 =?utf-8?B?WjFLcGt3Vk1TRUJoRGFQeUg2WXptM1AyVDNnQi8xVGd2MExiUmVFS3ExcnRN?=
 =?utf-8?B?S3JIT3ZENnNJUmlZc0owaWpVKzdXWkZOVkV3M3BxQzZONiswUlVabmNMSEtp?=
 =?utf-8?B?bGtEWVFhdXlpODY4Qm1VRHN1akpGUmpEOW1tOUNGTUZzUnVpanVmd0pzRk1G?=
 =?utf-8?B?VVU4N09ESUNGZXlGdUwvOTdoK0JrK2dxVDU2ZCtsTSsxL2h5dDlQejVkc0I4?=
 =?utf-8?B?NDdmNi9EbFFLTVNmRkpybDh0VzBhNVg2QjVWcUNQUDRnNVZ6eFRMSzQzOENU?=
 =?utf-8?B?NkxTcmJaQkJmc2ZVK0NhVWRSam11UFB4enNQZ0sxSlVxMnI2N2ovQnB4b054?=
 =?utf-8?B?emRlNG5VWmNuR3MzL0dBaHJLdVdwT0hUeVhnWXRkRDBkM2Y3YTJ3cDkwcHpO?=
 =?utf-8?B?M2I4YUFrZjY2akRYRDd5bWxhd2duMzl6YWZONjQyTUVuUmg5TW9UdlczZVAx?=
 =?utf-8?B?czNXb1Z6YmdnSFE5QUpSbmtRU2N5aWNoU1RSTDhmaEhuVnRrM09lckZxaFBj?=
 =?utf-8?B?REZBQXR5SWlHR29wQ01iZk1zbjNXS2hQeGw3Tm5QdmtqM2dybVI4YjQ4d0E0?=
 =?utf-8?B?V3o1d1NhVHdmZGVWbnU5WW5LZ3N5Q0xyY2cxZEErbGk4U29MSXdlTjBRaDdR?=
 =?utf-8?B?ZGxTSDV4NDgvRVdqMDBraXFRODhzQW0xVWRTZGQ2QUVVSzRyb3NSYW9GVjBZ?=
 =?utf-8?B?N1JCa0VRNzlOSVl2enU3eWNTTTRWMDlJUGNkU3hPakFkWm03S29ERCtzT0FJ?=
 =?utf-8?B?TndsZmtWQjJaSVgvWTcwR3IyR1ZtemV4eWZRM1FMbFhHL0hhQmU4TUY0RzVL?=
 =?utf-8?B?b1NoUlFWejRLTmlnUmtzc0xZZkdmc2g2c1hPd0Y5cHNyczVSRk9JZVluSzFq?=
 =?utf-8?B?Tm1SSlVkM2FEek5NRUVROXQ5cmlQdDJCQWVKR2pyeDlUcm0wTEt0MDVvb1Fp?=
 =?utf-8?B?MEV0RUwrRVhiZXlJamQvNHgyenAzVndEOUdQUlpWaTBlOTFPRTROTExISldj?=
 =?utf-8?B?bGxrbWZhQVNHZVoyNm4vNFFrVTVOcyt5Y1UvelMrS0ZTNUhQTEE0bnJBK0hB?=
 =?utf-8?B?VXVTakkvVGt0c1FpS1cvMG5jcjVtTjBlMytsSjhMT1hhYnlyeDJseENXclR3?=
 =?utf-8?B?Wm9XZ3BxYzk0aUF2OFQ5UDRNWjdBa005MFB1Q3RicElvZi9XTjNYc3V1UHJX?=
 =?utf-8?B?ZjRMdXJYWlR1VWltWVYyVm5HOUYwZDBpTzdJWm4wenNDMFhWeEVsR0M4bUhq?=
 =?utf-8?B?WFU2am9JZWFPNnJMUUJIMUVmMFhqYVY1U1VsWTYrNXVnbzZrVlZYNU5Tc2Jk?=
 =?utf-8?B?RjZZa3h2bDFRaWNCd210Q1JxbXErdXhuaW9NalJ1TW9DeFVPL1lnSzVHenkw?=
 =?utf-8?B?TDNRaUxSWlJzRHRkQThJRU01NWcxMGtaek5HMWp6Y1JrLzFZREVSeVgxSllx?=
 =?utf-8?B?NUFaN3hxRFhadVBweWNjNDlLVW9JR3d3TlFvZjZDRys4c2VmWVVFNDZQZkxC?=
 =?utf-8?B?YXRMYjJVWGJVRFQ5bXltb0VHOEZkZ2lvS1psUXJveWZrd3hvbzRkTmUxeGlu?=
 =?utf-8?B?TVgwa1UxT1VTZUxPenlxU3lkT0MwclV1UDFUZzg0NlA0T0RUNXN5ZncrYUZp?=
 =?utf-8?B?eDlpcDdPTFhYanRxa1phOFgrNTdNaHk1M1VYL25yQ2gyNTNhVzdvTVA2d0Z3?=
 =?utf-8?B?RS9ZdDdnbVVSOU9rVVZyVzJTazdCMWZaOFpKS0g3N21WWjRvd28yT3lFZ3l1?=
 =?utf-8?B?MkNqUm5OOCs2U1ozUStHZUIvZExOaXhIaHJUemk5WlhtRmh2cnU4cVh0YnN5?=
 =?utf-8?B?bGZtYUxjM1VhWlFHWlpyS2cvNHJNaEV6MGVrQ2RaTXlNdWRQSXhtVmgzeWRY?=
 =?utf-8?B?aDc3eFNCaGpBQTVhUlBCc1NMQkUwcE9XWFZlQUJCbS9GWDlHZzBQbi9sZkNt?=
 =?utf-8?B?d1NaK0JWYnNJbTBJUW9rUUVZZTZGRUE0cUpQKzJOZnVhZ29MSmJJcVBtK3Iz?=
 =?utf-8?B?c29oTlN4cTNINVJQUkJrQnMrZytCcnYwNHpyVUxReXZwZlpLNXZJZDl2U0hq?=
 =?utf-8?B?ZXQvUm1rS1NkUnRFd0Vnb0JIUVUyUVp5QjJlb2wxVEVmSTgzNWdPeGFmUkhE?=
 =?utf-8?B?cE5VU3NSNm5qL2dXR3FmaTlCUUw2bHlpenh3T0NUMk1tNkJiOGRjZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56656cf0-cbc7-42fd-0a31-08de57745b24
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 16:03:58.9842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CcOEVBJVzvP4yOylDbbhoWxy/SLh8XKQo/lcsKbx2z/ngEz/rRJTczRQD8wxRqBnlTg5SN7zc2OFRzzwXnYS7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5598
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAxOSBKYW51YXJ5IDIwMjYgMTY6MDENCj4gVG86
IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsgWmhhbmdmZWkgR2Fv
DQo+IDx6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZz4NCj4gQ2M6IHFlbXUtYXJtQG5vbmdudS5vcmc7
IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBKYXNv
biBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgTmljb2xpbiBDaGVuDQo+IDxuaWNvbGluY0Bu
dmlkaWEuY29tPjsgZGR1dGlsZUByZWRoYXQuY29tOyBiZXJyYW5nZUByZWRoYXQuY29tOw0KPiBj
bGdAcmVkaGF0LmNvbTsgYWxleEBzaGF6Ym90Lm9yZzsgTmF0aGFuIENoZW4gPG5hdGhhbmNAbnZp
ZGlhLmNvbT47DQo+IE1hdHQgT2NocyA8bW9jaHNAbnZpZGlhLmNvbT47IHNtb3N0YWZhQGdvb2ds
ZS5jb207DQo+IHdhbmd6aG91MUBoaXNpbGljb24uY29tOyBqaWFuZ2t1bmt1bkBodWF3ZWkuY29t
Ow0KPiBqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb207IHpoZW56aG9uZy5kdWFuQGludGVsLmNv
bTsNCj4geWkubC5saXVAaW50ZWwuY29tOyBLcmlzaG5ha2FudCBKYWp1IDxramFqdUBudmlkaWEu
Y29tPjsgTWljaGFlbCBTIC4gVHNpcmtpbg0KPiA8bXN0QHJlZGhhdC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjcgMzMvMzZdIGh3L3BjaTogQWRkIGhlbHBlciB0byBpbnNlcnQgUENJZSBl
eHRlbmRlZA0KPiBjYXBhYmlsaXR5IGF0IGEgZml4ZWQgb2Zmc2V0DQo+IA0KPiBFeHRlcm5hbCBl
bWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+
IE9uIDEvMTQvMjYgMTE6MzYgQU0sIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4gSGkgWmhh
bmdmZWksDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTog
WmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZz4NCj4gPj4gU2VudDogMTQgSmFu
dWFyeSAyMDI2IDA0OjE4DQo+ID4+IFRvOiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9A
bnZpZGlhLmNvbT4NCj4gPj4gQ2M6IHFlbXUtYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZzsNCj4gPj4gZXJpYy5hdWdlckByZWRoYXQuY29tOyBwZXRlci5tYXlkZWxsQGxpbmFy
by5vcmc7IEphc29uIEd1bnRob3JwZQ0KPiA+PiA8amdnQG52aWRpYS5jb20+OyBOaWNvbGluIENo
ZW4gPG5pY29saW5jQG52aWRpYS5jb20+Ow0KPiBkZHV0aWxlQHJlZGhhdC5jb207DQo+ID4+IGJl
cnJhbmdlQHJlZGhhdC5jb207IGNsZ0ByZWRoYXQuY29tOyBhbGV4QHNoYXpib3Qub3JnOyBOYXRo
YW4gQ2hlbg0KPiA+PiA8bmF0aGFuY0BudmlkaWEuY29tPjsgTWF0dCBPY2hzIDxtb2Noc0Budmlk
aWEuY29tPjsNCj4gPj4gc21vc3RhZmFAZ29vZ2xlLmNvbTsgd2FuZ3pob3UxQGhpc2lsaWNvbi5j
b207DQo+ID4+IGppYW5na3Vua3VuQGh1YXdlaS5jb207IGpvbmF0aGFuLmNhbWVyb25AaHVhd2Vp
LmNvbTsNCj4gPj4gemhlbnpob25nLmR1YW5AaW50ZWwuY29tOyB5aS5sLmxpdUBpbnRlbC5jb207
IEtyaXNobmFrYW50IEphanUNCj4gPj4gPGtqYWp1QG52aWRpYS5jb20+OyBNaWNoYWVsIFMgLiBU
c2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAzMy8z
Nl0gaHcvcGNpOiBBZGQgaGVscGVyIHRvIGluc2VydCBQQ0llIGV4dGVuZGVkDQo+ID4+IGNhcGFi
aWxpdHkgYXQgYSBmaXhlZCBvZmZzZXQNCj4gPj4NCj4gPj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBj
YXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gPj4NCj4gPj4NCj4gPj4gSGks
IFNoYW1lZXINCj4gPj4NCj4gPj4gT24gTW9uLCAxMiBKYW4gMjAyNiBhdCAwMzo1OCwgU2hhbWVl
ciBLb2xvdGh1bQ0KPiA+PiA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+IHdyb3RlOg0KPiA+Pj4g
QWRkIHBjaWVfaW5zZXJ0X2NhcGFiaWxpdHkoKSwgYSBoZWxwZXIgdG8gaW5zZXJ0IGEgUENJZSBl
eHRlbmRlZA0KPiA+Pj4gY2FwYWJpbGl0eSBpbnRvIGFuIGV4aXN0aW5nIGV4dGVuZGVkIGNhcGFi
aWxpdHkgbGlzdCBhdCBhDQo+ID4+PiBjYWxsZXItc3BlY2lmaWVkIG9mZnNldC4NCj4gPj4+DQo+
ID4+PiBVbmxpa2UgcGNpZV9hZGRfY2FwYWJpbGl0eSgpLCB3aGljaCBhbHdheXMgYXBwZW5kcyBh
IGNhcGFiaWxpdHkgdG8gdGhlDQo+ID4+PiBlbmQgb2YgdGhlIGxpc3QsIHRoaXMgaGVscGVyIHBy
ZXNlcnZlcyB0aGUgZXhpc3RpbmcgbGlzdCBvcmRlcmluZw0KPiA+Pj4gd2hpbGUgYWxsb3dpbmcg
aW5zZXJ0aW9uIGF0IGFuIGFyYml0cmFyeSBvZmZzZXQuDQo+ID4+Pg0KPiA+Pj4gVGhlIGhlbHBl
ciBvbmx5IHZhbGlkYXRlcyB0aGF0IHRoZSBpbnNlcnRpb24gZG9lcyBub3Qgb3ZlcndyaXRlIGFu
DQo+ID4+PiBleGlzdGluZyBQQ0llIGV4dGVuZGVkIGNhcGFiaWxpdHkgaGVhZGVyLCBzaW5jZSBj
b3JydXB0aW5nIGEgaGVhZGVyDQo+ID4+PiB3b3VsZCBicmVhayB0aGUgZXh0ZW5kZWQgY2FwYWJp
bGl0eSBsaW5rZWQgbGlzdC4gVmFsaWRhdGlvbiBvZg0KPiA+Pj4gb3ZlcmxhcHMgd2l0aCBvdGhl
ciBjb25maWd1cmF0aW9uIHNwYWNlIHJlZ2lzdGVycyBvcg0KPiA+Pj4gY2FwYWJpbGl0eS1zcGVj
aWZpYyByZWdpc3RlciBibG9ja3MgaXMgbGVmdCB0byB0aGUgY2FsbGVyLg0KPiA+Pj4NCj4gPj4+
IENjOiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPg0KPiA+Pj4gU2lnbmVkLW9m
Zi1ieTogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+DQo+ID4+IFRo
ZSBndWVzdCBrZXJuZWwgZmFpbHMgdG8gYm9vdCB3aXRoIHBhcmEgInNzaWRzaXplPTE2IiB3aXRo
IHY3IHNlcmllcy4NCj4gPj4gV2l0aG91dCBzc2lkc2l6ZSwgZ3Vlc3Qga2VybmVsIGNhbiBib290
IG5vIHByb2JsZW0uDQo+ID4gVGhhbmtzIGZvciBnaXZpbmcgdGhpcyBhIHNwaW4uDQo+ID4NCj4g
Pj4gSG93ZXZlciwgcGFzaWQgZmVhdHVyZSByZXF1aXJlcyBzc2lkc2l6ZS4NCj4gPj4gc21tdXYz
X2FjY2VsX2dldF92aW9tbXVfZmxhZ3MNCj4gPj4gaWYgKHMtPnNzaWRzaXplKSB7DQo+ID4+IGZs
YWdzIHw9IFZJT01NVV9GTEFHX1BBU0lEX1NVUFBPUlRFRDsNCj4gPj4NCj4gPj4gdjYgZG9lcyBu
b3QgaGFzIHN1Y2ggaXNzdWUsIGFuZCBkb2VzIG5vdCByZXF1aXJlcyBzc2lkc2l6ZSBwYXJhbS4N
Cj4gPiBBcyBtZW50aW9uZWQgaW4gY292ZXIgbGV0dGVyIHRoaXMgc2VyaWVzIGhhcyBjaGFuZ2Vk
IHRoZSB3YXkgdGhlIG92ZXJhbGwNCj4gPiBQQVNJRCBpcyBlbmFibGVkLiBJdCBub3cgYWxsb3dz
IHVzZXIgdG8gc3BlY2lmeSBhbiBvZmZzZXQgdG8gcGxhY2UgdGhlDQo+ID4gUEFTSUQgQ0FQIGZv
ciB2ZmlvLXBjaSBkZXZpY2VzLA0KPiA+DQo+ID4gLWRldmljZSB2ZmlvLXBjaSxob3N0PTAwMTg6
MDY6MDAuMCwuLix4LXZwYXNpZC1jYXAtb2Zmc2V0PXh4eA0KPiA+DQo+ID4gSWYgbm9uZSBpcyBz
cGVjaWZpZWQgaXQgd2lsbCBwbGFjZSBpdCBhdCB0aGUgbGFzdCBvZmZzZXQgYXMgZGVmYXVsdC4N
Cj4gPg0KPiA+IEFuZCB5b3UgbmVlZCAic3NpZHNpemUiIHRvIHNwZWNpZnkgdGhlIFNNTVV2MyBz
dWIgc3RyZWFtIElkIGJpdHMuDQo+ID4NCj4gPj4gbG9nOg0KPiA+PiBBU1NFUlRfRUZJX0VSUk9S
IChTdGF0dXMgPSBJbnZhbGlkIFBhcmFtZXRlcikgQVNTRVJUIFtQY2lCdXNEeGVdDQo+ID4+DQo+
IC9ob21lL2xpbmFyby93b3JrL2VkazIvTWRlTW9kdWxlUGtnL0J1cy9QY2kvUGNpQnVzRHhlL1Bj
aUxpYi5jKDYyNik6DQo+ID4+ICEoKChJTlROKShSRVRVUk5fU1RBVFVTKShTdGF0dXMpKSA8IDAp
DQo+ID4gSXQgY291bGQgYmUgdGhhdCB0aGUgcGNpZV9pbnNlcnRfY2FwYWJpbGl0eSgpIGhlbHBl
ciBhZGRlZCBoZXJlIGlzIGNvcnJ1cHRpbmcNCj4gPiB0aGUgY29uZmlnIHNwYWNlLiBMb29raW5n
IGF0IGl0IGFnYWluLCBJIGNhbiBzZWUgdGhhdCBpdCBpcyBub3QgaGFuZGxpbmcgYSBmZXcNCj4g
PiBjb3JuZXIgY2FzZXMuICBDb3VsZCB5b3UgcGxlYXNlIHJlcGxhY2UgdGhlIHBjaWVfaW5zZXJ0
X2NhcGFiaWxpdHkoKSB3aXRoDQo+ID4gdGhlIGJlbG93IGFuZCByZXRlc3QuDQo+ID4NCj4gPiBU
aGFua3MsDQo+ID4gU2hhbWVlcg0KPiA+DQo+ID4gLi4uDQo+ID4NCj4gPiBib29sIHBjaWVfaW5z
ZXJ0X2NhcGFiaWxpdHkoUENJRGV2aWNlICpkZXYsIHVpbnQxNl90IGNhcF9pZCwgdWludDhfdCBj
YXBfdmVyLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MTZfdCBvZmZzZXQs
IHVpbnQxNl90IHNpemUpDQo+ID4gew0KPiA+ICAgICB1aW50MTZfdCBwb3MgPSBQQ0lfQ09ORklH
X1NQQUNFX1NJWkUsIHByZXYgPSAwOw0KPiA+ICAgICB1aW50MzJfdCBoZWFkZXI7DQo+ID4NCj4g
PiAgICAgYXNzZXJ0KG9mZnNldCA+PSBQQ0lfQ09ORklHX1NQQUNFX1NJWkUpOw0KPiA+ICAgICBh
c3NlcnQob2Zmc2V0IDwgKHVpbnQxNl90KShvZmZzZXQgKyBzaXplKSk7DQo+ID4gICAgIGFzc2Vy
dCgodWludDE2X3QpKG9mZnNldCArIHNpemUpIDw9IFBDSUVfQ09ORklHX1NQQUNFX1NJWkUpOw0K
PiA+ICAgICBhc3NlcnQoc2l6ZSA+PSA4KTsNCj4gPiAgICAgYXNzZXJ0KHBjaV9pc19leHByZXNz
KGRldikpOw0KPiA+DQo+ID4gICAgIGhlYWRlciA9IHBjaV9nZXRfbG9uZyhkZXYtPmNvbmZpZyAr
IHBvcyk7DQo+ID4gICAgIGlmICghaGVhZGVyKSB7DQo+ID4gICAgICAgICAvKiBObyBleHRlbmRl
ZCBjYXBhYmlsaXR5LCBjaGVjayByZXF1ZXN0ZWQgb2Zmc2V0IGlzIGF0DQo+IFBDSV9DT05GSUdf
U1BBQ0VfU0laRSovDQo+ID4gICAgICAgICBpZiAob2Zmc2V0ICE9IHBvcykgew0KPiA+ICAgICAg
ICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiAgICAgICAgIH0NCj4gPiAgICAgICAgIHBjaV9zZXRf
bG9uZyhkZXYtPmNvbmZpZyArIHBvcywgUENJX0VYVF9DQVAoY2FwX2lkLCBjYXBfdmVyLCAwKSk7
DQo+ID4gICAgICAgICBnb3RvIG91dDsNCj4gPiAgICAgfQ0KPiA+DQo+ID4gICAgIHdoaWxlICho
ZWFkZXIgJiYgcG9zICYmIG9mZnNldCA+PSBwb3MpIHsNCj4gPiAgICAgICAgIHVpbnQxNl90IG5l
eHQgPSBQQ0lfRVhUX0NBUF9ORVhUKGhlYWRlcik7DQo+ID4NCj4gPiAgICAgICAgIC8qIFJlamVj
dCBpbnNlcnRpb24gaW5zaWRlIGFuIGV4aXN0aW5nIEVDQVAgaGVhZGVyICg0IGJ5dGVzKSAqLw0K
PiBJZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5IHlvdSBkb24ndCBjaGVjayB0aGUgd2hvbGUgRVhU
IENBUCBzaXplIGJ1dA0KPiBqdXN0IHRoZSBoZWFkZXIsIGNvcnJlY3Q/DQoNClllcy4gVGhhdOKA
mXMgY29ycmVjdC4gDQoNCj4gPiAgICAgICAgIGlmIChvZmZzZXQgPCBwb3MgKyBQQ0lfRVhUX0NB
UF9BTElHTikgew0KPiA+ICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiAgICAgICAgIH0N
Cj4gPg0KPiA+ICAgICAgICAgcHJldiA9IHBvczsNCj4gPiAgICAgICAgIHBvcyA9IG5leHQ7DQo+
ID4gICAgICAgICBoZWFkZXIgPSBwb3MgPyBwY2lfZ2V0X2xvbmcoZGV2LT5jb25maWcgKyBwb3Mp
IDogMDsNCj4gPiAgICAgfQ0KPiA+DQo+ID4gICAgIHBjaV9zZXRfbG9uZyhkZXYtPmNvbmZpZyAr
IG9mZnNldCwgUENJX0VYVF9DQVAoY2FwX2lkLCBjYXBfdmVyLCBwb3MpKTsNCj4gPiAgICAgaWYg
KHByZXYpIHsNCj4gPiAgICAgICAgIHBjaWVfZXh0X2NhcF9zZXRfbmV4dChkZXYsIHByZXYsIG9m
ZnNldCk7DQo+ID4gICAgIH0NCj4gPg0KPiA+IG91dDoNCj4gPiAgICAgLyogTWFrZSBjYXBhYmls
aXR5IHJlYWQtb25seSBieSBkZWZhdWx0ICovDQo+ID4gICAgIG1lbXNldChkZXYtPndtYXNrICsg
b2Zmc2V0LCAwLCBzaXplKTsNCj4gPiAgICAgbWVtc2V0KGRldi0+dzFjbWFzayArIG9mZnNldCwg
MCwgc2l6ZSk7DQo+ID4gICAgIC8qIENoZWNrIGNhcGFiaWxpdHkgYnkgZGVmYXVsdCAqLw0KPiA+
ICAgICBtZW1zZXQoZGV2LT5jbWFzayArIG9mZnNldCwgMHhGRiwgc2l6ZSk7DQo+ID4gICAgIHJl
dHVybiB0cnVlOw0KPiA+IH0NCj4gQmVzaWRlcw0KPiANCj4gUmV2aWV3ZWQtYnk6IEVyaWMgQXVn
ZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCg0KVGhhbmtzLA0KU2hhbWVlcg0K

