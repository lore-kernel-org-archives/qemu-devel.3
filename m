Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37104CCF9EC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDLqG-0002Sb-LO; Mon, 27 Oct 2025 07:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vDLq7-0002Qb-Cu; Mon, 27 Oct 2025 07:56:46 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vDLq3-0008Ft-JH; Mon, 27 Oct 2025 07:56:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wolnMIuR8GLeVYzY+p8RZ9U9lHHV1qY8Fla1wy4di3i9nNRMOnas5DwAmJTNKZJPCfdgtZNvAWH/7vO1C/YceJjrPfK+gqbKOS0irYmJq1qvty2KJBvkCngKaTFzTk1m4vKqfuBA3cEM3xMkpJ4GSQIdBATLTKQ0i2XEpe7OkW0jYhNJStDTOgVcivRvC2c3hLwa/mxmbsAY/B0AoL9oRjz5wreL55moQefhVW/tvRcZZQtm3sGa4sbwUJoyRa3hzhzH8YBKdwtC7XONQAaCEahWdZqjar0qODPpfOBkxiQKEcFSGGeaCBHw5zNQBsIcMrxbYnS8L2UhA6VVEl6hJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNzsYFblf+EijZhQD8vOZ6whEagBNbh5DQ3rFOn+YVk=;
 b=e0A0kM1GvEITo3bOQeV802VoDLFBkPFtc2BDN+JzM1l1xwRUEh8ymKelhRG0Jp0Q0ElaJr/j04Wx1jQ7Aiu68C7IBZLF9GxGytYYyxDJsIMWVQdcFr6FLzfQf5Esj5dL//BjKLBOd2mabctIzeIp+aWHneR0K6ftiACEUKYpxTExjnWrdzIKFvvZm7MOEVJ31FFZCZJaTtS+jS4i1TnaNTqL8HbHIzToZoFpwtClPlXlRnC6CgrD+m5mHBQZRbp85pwm96j/8Omvr6OxTI0m8tIsrdgr6I1O23bxKSED0Q9C5ehwV18B0DDY2XaNqB6o7PohBuIjm/91a3I7uwbo7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNzsYFblf+EijZhQD8vOZ6whEagBNbh5DQ3rFOn+YVk=;
 b=c58JqbmVvr3M35VJkb6HD6yO1Pk24ATKXHY5IR38h4gyinSij7c6tMiP92wdDTYn5/ncg8ROlDmUvMHhiXohsn/Ce6m776lZMvUVINl1s/x/PpgScDQz/iV6gkTlp/OBVwfueRpjw8v+XtxaMgosEjI2RQiodZHIkOhYI0M6WH0Nr6sDcOOigW9/JVu9cJNgGYC7nHA3JFI1DTJdZ8F2P6gxZ+17wsTnjh8Sq9uDApz8NOjSQsIeKnAdIrHvocrbZb2vXRhVc534XoJ14XQg6SDdD/26Ebm/wsoD0USTmzd+LMRa8M8g1f/SNmz8LexMlJKXwJPlouqaZrrRUGNSJg==
Received: from IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 by SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 11:56:24 +0000
Received: from IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::963e:9c86:4830:2ebd]) by IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::963e:9c86:4830:2ebd%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 11:56:24 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com"
 <jiangkunkun@huawei.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 08/27] hw/arm/smmuv3-accel: Add set/unset_iommu_device
 callback
Thread-Topic: [PATCH v4 08/27] hw/arm/smmuv3-accel: Add set/unset_iommu_device
 callback
Thread-Index: AQHcM2kvQ/UaXF0y/0CBTpFuWL1mf7SuspowgABeKgCAJuc18A==
Date: Mon, 27 Oct 2025 11:56:23 +0000
Message-ID: <IA0PR12MB7555B6D390BC37EE85BF6D42ABFCA@IA0PR12MB7555.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-9-skolothumtho@nvidia.com>
 <7167d287-f0d0-4bb8-8750-e38e9e31df10@redhat.com>
 <CH3PR12MB7548C5CB7B9BE18AAE5492BEABE7A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aN6r4n2F1s2ZLm9d@Asurada-Nvidia>
In-Reply-To: <aN6r4n2F1s2ZLm9d@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7555:EE_|SJ2PR12MB9085:EE_
x-ms-office365-filtering-correlation-id: 956b2578-5be0-459f-c04e-08de154fda10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?N1pNTVY2cHVoTUt0U0ZseXhYbm90b0dITzk2Nk9LSEprMS9WR3pLa1Nma2Rv?=
 =?utf-8?B?ZDFBZFVEbWlsb0Qyb3V1R0JHRlZPNGx4VWhpaG0rUEZ0dlB4MkNJZFd5cmJR?=
 =?utf-8?B?aUxhbHJkbUNVS3JpaGplWmo1QmpZdU42TTYrbHZZclFWV1JuT1llVkNtdlNR?=
 =?utf-8?B?NUEyMlNvMmVVYWFobjhidjZhUlZiWVFmcG4vQkI0OFE0WUIyekRJTXZMZ2Er?=
 =?utf-8?B?NnFCTGdQOUszc015TWNxM0tlczZqVWw4aU9uNUZTRHJpdk0yRzdqRXlsTHF4?=
 =?utf-8?B?V2UwVkFtdTF0c2pGbmhEQjd2TkI5L04veTYzZjJldGNVQktEWTZVSXYxaFdq?=
 =?utf-8?B?dUlacHRLclk1V3RBd0tMLzZJNWtxTHBlODlKTWtjL2VKckdYbmIyMzNtSnpB?=
 =?utf-8?B?Uy9sbnZWZWFtc0tLSlpNQTBOQnI1OVEwOWRmc2t3NXhDaDJkYjhjQkRjbE5R?=
 =?utf-8?B?OFU5aTFoc2ZCKzhZMW1uR3cwZUxhV05sS3poYjU2ZkxTTWQ0bmlSaEpUSjdK?=
 =?utf-8?B?VUxRWFRuQ3ZLMWcwL0NwRWsrR09KaTNVMnBoczF4Z0lMdnJTSnNFL0hlZWt2?=
 =?utf-8?B?d0Q1WkZqQXdQbEVWUStBNDBVQ2crcDJxM1EwVmVVKzc1WnV2MW5NQUUwa3NG?=
 =?utf-8?B?TUI3VVdOYmJIT3hJdXdhaGsxVjdxdnV2NWNXREhIaENCUmhHSGszRlZlckU1?=
 =?utf-8?B?dmNYc294V05oS0tIZ1cvNzJ2bzZXR3FZL2k1Y0h0TXpkTklsOUFpTEVISXNV?=
 =?utf-8?B?MjFjVkUyT0w0ZDBWNEtMMXNmM0U5eW9oTFVLazNpbmlkVmlsckZ4S0grazRh?=
 =?utf-8?B?UHc2QjM1VlptaW8xYi9zVDBGVkg1TTNYRmdIUnF3TjFCQmx6a2tJRzJzb2hm?=
 =?utf-8?B?dHlaeXEydUZENis4OVJnYWsyelY4RmdHaThjN3hUVjBrSWM1NkhUWDZPbmdj?=
 =?utf-8?B?RXB5NDBBc0dkbVdXbjNOamsxakxtTU5MdE5ZL3ZYbHRYclFuOXA3S1lGTTcy?=
 =?utf-8?B?c1lNWG9QUDRZZnRET2tPVmNFOUxtMmRnY3FYWWVXRVVCSEdhWVJWYWlIRzZJ?=
 =?utf-8?B?QXJ3ZFpOazRPS0ZmTXNKTUVTZ3hnTTZ3dmVzMzBqcjZjYVphRTdONWw0a1Rr?=
 =?utf-8?B?U0hud3dKNER1UTFWNnhEWWliZko2TWMzNE81MFdRVmJVMWp6eURQdlFkOUJM?=
 =?utf-8?B?dFdjWEsxQ1grVTdLbGFGM2N5S2RzTGRYbTBUdHRQTlEyTWJGN3VyV2dGajhN?=
 =?utf-8?B?ZjEvZmxRREpoMDNaSWtmdVh5bFhKVnZsWjJYcStyQ3Jqcm9mQis3ak5JQTBx?=
 =?utf-8?B?bk9MZ0UrV2hwTk8yYjhRcXFrdDlXa1F4Smg2b1c5QWxFUTl5Y2ZROFBhNkcr?=
 =?utf-8?B?SHhMYi9ud2orWXo5b0d4d05USHRXYmxsQVNYY1hMS211c2RQRnpicHROYjlS?=
 =?utf-8?B?RmtqazRUcm9OYWlZRkJnMDErZWJUazNHMGFibVVTaC95TXpPRkIwb3l3cm9C?=
 =?utf-8?B?TXZkT0tKVzNUeGJjTHVkeVJucTNGMGFMSEg3VzNYMG95YURkQnpSZ2hXblQr?=
 =?utf-8?B?RHdLRFZpeFZZNlNZQkhVRFNZR1QwTDJqbWJLZHFwZXNGd04xSDdhL2pHS1dX?=
 =?utf-8?B?MisvYVFtUzFoZE10T1IzaTJKZktYRURKUk1kcTdhZHpNTEN3SWFEZXNrSTRl?=
 =?utf-8?B?cGx1cDh5VHh6UzBIb1pLMCsvc3JXeUd4dEZjblJWdEJrZ016Y0ZHeU91ZUdE?=
 =?utf-8?B?eVJBc2pmZy82SitZQ2ptOWQvSGp2Z2ZyL3EvOEJUaXovWnRvclVLOWNZajZ3?=
 =?utf-8?B?K0NpQjlWY1J6NFdiZXlIZEJRRWx4OEtTU3R6TFNWVkc0eWc3TTRxU29nMlpt?=
 =?utf-8?B?UThYZjhtVzc0Vk44TkFIQkU0WHBpZHFqbE5aMTdCL0x4V05WNThkeldFZk5y?=
 =?utf-8?B?eVF3ZHkySmZYSVVObklQQ3prbHFtcE5BTW9MY0lBQnRISnhUY3Q3SGhLWGxS?=
 =?utf-8?B?R3ArUFZ4ZVRRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUQyWXE2YmNtWXBKbHZnSzk1UGtYUEJJc1dZSmRBWnlkQVBmMk50UlVUYS9s?=
 =?utf-8?B?Rm9TZW4rWVNEdXpkbnRXakVWTVdiOWNFT1ZCVjVYMko3RUIycHpNd2dsNjJY?=
 =?utf-8?B?azVaa3Vra0hHc0ZXaVdYdU5reHF3azJJUVdrb2ljMFVWSktXdTNBQlB5L3Jy?=
 =?utf-8?B?U01tODk3UnZLZkVMaW1GTFpLZWxxelIyUWNnWU5PNUJmVnJQeWlkNE9SZG9j?=
 =?utf-8?B?Mkpla3NIbDl0dE1kK0kveGFPMVVRUEZWclJZWjA4cUhVN013bU9zTUVST1I4?=
 =?utf-8?B?N0ZTcjFKWWtWVVoyelZWNnBIWWJwTGZ2WFVHaTZ3dzdRN0ZHU2FkQU55WWp5?=
 =?utf-8?B?ZERSS3NtRXVXMWVlWnQxRTBrVzlzZ2hQbDJ0L01IeDZWTk5RTW5OUXlsZjlu?=
 =?utf-8?B?eEdUWUdJV2szU0FndE00RUpEOTF4UUo4QTNIWlY1Mks4KzJOdlVkbU1mUWFy?=
 =?utf-8?B?dHFHSHhKUkRNeCtuV2tWdUhjL0JRK2RZUHg1U0lwUVJiajQzQncyajBneWxr?=
 =?utf-8?B?MEtGdWgyWmhGeS9Hb0ZuQmhpTkdoUXNTS1JUb1BiTE1rQXowQXZjY0diWkNV?=
 =?utf-8?B?OEpDZi91bE9yTDJvRE1YZGNreUcyRngvVWtUS0RJQXhxOUg4NzVQYVZ1ZUt0?=
 =?utf-8?B?NFp3dXM3N1lrcVcvYUFTYWpCOWFTVDZXSmlaNVBXZFJaMllZV0xyV3MxVnFk?=
 =?utf-8?B?Q3QyaHdhcFRaL1Y2NFNjYmFrZ0dTNkJ0dTBLNXQ2UWlmMkdHRS9TQXM2Zkpy?=
 =?utf-8?B?MG51ZjZOVDBxa08wSlY2NGlid05pSllEQjNxTGN1QnJRdjVja2ZmQjRMYUpI?=
 =?utf-8?B?c2FLL3NZK1lWNW9yaC9seDdETWlERUR5WlFxQ2dnT2FPUlgxVGpzK1BQcCs2?=
 =?utf-8?B?SE52RnhVcXVOVUxzUWFEdllEbWxrSVZ2U3Y0SndmcjhnSXZ2QVNGZ3ozNkFz?=
 =?utf-8?B?V2I0eTZTMVZNRWVQeXJsM1N0QWxHMDczU1p6TGNuMFpUVVJzVElCVnJ4Lzg2?=
 =?utf-8?B?c0IrN3JiOTlIZjJISzJpSlJDTnZGRGxvTzlVSXBrYjlyZEJMUVBGcFhvMGNW?=
 =?utf-8?B?Vi9CMXV3eU9kbEJ4MTdSQ0xFQnFyMCtNTmZCMEtWUXlNOHRzdE5HMGZGQUlY?=
 =?utf-8?B?TGhCYUp4TUdZd0RQT2JJS09EZG9FZGdBSEFhNnQzMmJLMHcrQmc4cjg0WmR5?=
 =?utf-8?B?RXM3MU9JNHhNcnVxV2RpVDMwRUZSUWh3dWFVTUFXZzh1YTRuQWxMTytSZkVj?=
 =?utf-8?B?VE5PQ0s0L3E5SmI1R1ZtK05RSUgrNzZyMGcwSjZudzh5VFM1L01ZNmIwZkdY?=
 =?utf-8?B?aVR3QlUyWkNZNTBHdk9jbkVpRFBqZHNrKzVXTVg4ZklKa0RycGozaHBTUlMr?=
 =?utf-8?B?WklRdTU3R29LUERjSFJNb2pSRnRvMDcrZCttemI1b2wwNS9keStzVlJuWmVr?=
 =?utf-8?B?U1N5bVMzNHYzWFNCRnNGNTdJNGNLS0ZiU0FwTjlJYnF1aHoyZ2I3R1h1RjJL?=
 =?utf-8?B?SzZPQ3pUKzFSMGVrN2NGL000WERqc2xBSnkxVS9odmZsN0IyUDcwd0JiMU1p?=
 =?utf-8?B?bllQa0hOMTVyM0V4bGxQTzZKaTZSRWZ4S1krUncrYU54Q0VkbUw0aENlZlZz?=
 =?utf-8?B?U29VdlRoV3JraTVBK2JpcmgxOGU0Nm5RNGNRMCtFK2xIQ0xYclJIbHFVTm1Z?=
 =?utf-8?B?Mi9aSkZCRWliWmRaalhoMWIwRVdWVmJmdy9Sc29CR05lZGsrY2M1NnF5QlV6?=
 =?utf-8?B?MGZjZzdaNnQ5bTgxdDdGb1E4L3RKZm45aEpFZEtYZkl4MWdnQ0Z2dkppSkx1?=
 =?utf-8?B?YXl3d3NkWndJbVBuM1VsSHpueURodHJKNjRGYVpsRUUrVzNFL2ZvVGl1QXBu?=
 =?utf-8?B?a1hweEN2bzdTZS8yNmFOSjdsZW1pSzZEMzl4U2dZMTNvMXA2TEhYNlNCTDUw?=
 =?utf-8?B?UzFXR1RqRTRkZmQ1VUtRMTZ2aUY4dnVqQ290eVZnUEJjcUw2UmpsV25OMkRv?=
 =?utf-8?B?Y2M3SHhiYTRqOHhoVm1uWmYxbmxWVGZUUk0ybEwvYlVJTTRtUGc3cGtRanlB?=
 =?utf-8?B?TkhoNHZmL0xZcXJ0UXdneEVuWmZld3hGRWN1dkNoZWV3Sk5XbDNxQnlMN2hJ?=
 =?utf-8?Q?lnBBOo/+Y102OqYTDgH6TKZE6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 956b2578-5be0-459f-c04e-08de154fda10
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 11:56:23.7842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 31X3UJ+/qlLWQda7239Sk/WxMz6S18wo+APaSgTaaP0juvMXnJNrrIN+O02IL6NHYParD/dBSLYUYxAqT6C1yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

SGkgRXJpYywNCg0KQmFzZWQgb24gZnVydGhlciBvZmYtbGlzdCBkaXNjdXNzaW9ucywgdGhpcyBu
ZWVkcyBzb21lIGNsYXJpZmljYXRpb24uDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiBTZW50OiAwMiBP
Y3RvYmVyIDIwMjUgMTc6NDQNCj4gVG86IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0Bu
dmlkaWEuY29tPg0KPiBDYzogZXJpYy5hdWdlckByZWRoYXQuY29tOyBxZW11LWFybUBub25nbnUu
b3JnOyBxZW11LQ0KPiBkZXZlbEBub25nbnUub3JnOyBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7
IEphc29uIEd1bnRob3JwZQ0KPiA8amdnQG52aWRpYS5jb20+OyBkZHV0aWxlQHJlZGhhdC5jb207
IGJlcnJhbmdlQHJlZGhhdC5jb207IE5hdGhhbg0KPiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+
OyBNYXR0IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+Ow0KPiBzbW9zdGFmYUBnb29nbGUuY29tOyB3
YW5nemhvdTFAaGlzaWxpY29uLmNvbTsNCj4gamlhbmdrdW5rdW5AaHVhd2VpLmNvbTsgam9uYXRo
YW4uY2FtZXJvbkBodWF3ZWkuY29tOw0KPiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsgemhlbnpo
b25nLmR1YW5AaW50ZWwuY29tOyB5aS5sLmxpdUBpbnRlbC5jb207DQo+IHNoYW1lZXJrb2xvdGh1
bUBnbWFpbC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwOC8yN10gaHcvYXJtL3NtbXV2
My1hY2NlbDogQWRkDQo+IHNldC91bnNldF9pb21tdV9kZXZpY2UgY2FsbGJhY2sNCg0KWy4uXQ0K
DQo+IFRoZXJlIGFyZSBhIGNvdXBsZSBvZiB0aGluZ3MgZ29pbmcgb24gaGVyZToNCj4gMSkgV2Ug
c2hvdWxkIG5vdCBhdHRhY2ggZGlyZWN0bHkgdG8gdGhlIFMyIEhXUFQgdGhhdCBldmVudHVhbGx5
DQo+ICAgIHdpbGwgYmUgc2hhcmVkIGFjcm9zcyB2U01NVSBpbnN0YW5jZXMuIEluIG90aGVyIHdv
cmQsIGFuIFMyDQo+ICAgIEhXUFQgd2lsbCBub3QgYmUgYXR0YWNoYWJsZSBmb3IgbGFja2luZyBv
ZiBpdHMgdGllIHRvIGFuIFNNTVUNCj4gICAgaW5zdGFuY2UgYW5kIG5vdCBoYXZpbmcgYSBWTUlE
IGF0IGFsbC4gSW5zdGVhZCwgZWFjaCB2SU9NTVUNCj4gICAgb2JqZWN0IGFsbG9jYXRlZCB1c2lu
ZyB0aGlzIFMyIEhXUFQgd2lsbCBob2xkIHRoZSBWTUlELg0KDQpUaGUgYWJvdmUgc3RhdGVtZW50
IGlzIG5vdCAxMDAlIGNvcnJlY3QgYXMgcGVyIHRoZSBjdXJyZW50IGtlcm5lbA0KYW5kIFFFTVUg
aW1wbGVtZW50YXRpb24uIEF0IHByZXNlbnQsIFZGSU8gY29yZSBhbGxvY2F0ZXMgYW4gczINCkhX
UFQgd2hlbiBJT01NVV9IV1BUX0FMTE9DX05FU1RfUEFSRU5UIGZsYWcgaXMgc2V0IGFuZA0KYXR0
YWNoZXMgdG8gaXQuIA0KDQpJbiB0aGUgc2V0X2lvbW11X2RldmljZSAoKSBwYXRoLCB3ZSB1c2Ug
dGhpcyBzMiBIV1BUIGlkIHRvIGNyZWF0ZSBhIA0KdklPTU1VIGFuZCBwcmUtYWxsb2NhdGUgYnlw
YXNzIGFuZCBhYm9ydCBJT01NVV9ET01BSU5fTkVTVEVEDQpIV1BUcywgd2hpY2ggYXJlIHJlYWR5
IHRvIGJlIGF0dGFjaGVkIGlmIHJlcXVpcmVkLg0KDQpPbiB1bnNldF9pb21tdV9kZXZpY2UoKSBw
YXRoLCB3ZSBhdHRhY2ggYmFjayB0byB0aGUgczIgSFdQVCBhcyBpdA0KZG9lcyB0b2RheS4NCiAN
Cj4gMikgQSBkZXZpY2UgY2Fubm90IGF0dGFjaCB0byBhIHZJT01NVSBkaXJlY3RseSBidXQgaGFz
IHRvIGF0dGFjaA0KPiAgICB0aHJvdWdoIGEgcHJveHkgbmVzdGVkIEhXUFQgKElPTU1VX0RPTUFJ
Tl9ORVNURUQpLiBUbyBhdHRhY2gNCj4gICAgdG8gYW4gSU9NTVVfRE9NQUlOX05FU1RFRCwgYSB2
REVWSUNFIG11c3QgYmUgYWxsb2NhdGVkIHdpdGggYQ0KPiAgICBnaXZlbiB2U0lELg0KDQpBbHNv
LCBpdCBiZWNhbWUgY2xlYXIgdGhhdCB3ZSBuZWVkIHRvIHJlbGF4IHRoZSBhYm92ZSByZXN0cmlj
dGlvbiBhbmQgYWxsb3cNCmF0dGFjaGluZyBwcm94eSBuZXN0ZWQgSFdQVHMgd2l0aG91dCByZXF1
aXJpbmcgYSB2REVWSUNFLiBUaGlzIGlzIG5lY2Vzc2FyeQ0KdG8gaGFuZGxlIGNhc2VzIHdoZXJl
IHRoZSBTTU1VdjMgb3BlcmF0ZXMgaW4gZ2xvYmFsIGJ5cGFzcyBvciBhYm9ydCBtb2RlcywNCmFz
IGNvbnRyb2xsZWQgYnkgdGhlIEdCUEEgcmVnaXN0ZXIsIHdoaWNoIGRvIG5vdCBoYXZlIGFueSBh
c3NvY2lhdGVkIGRldmljZXMuDQoNClBsZWFzZSBzZWUgTmljb2xpbuKAmXMga2VybmVsIHBhdGNo
IFswXSB0aGF0IGludHJvZHVjZXMgdGhpcyByZWxheGF0aW9uLg0KDQpJ4oCZdmUgdXBkYXRlZCB0
aGlzIFFFTVUgc2VyaWVzIGFjY29yZGluZ2x5LiBTTU1VdjMgR0JQQSBiYXNlZCBIV1BUIHdpbGwN
Cm5vdyBiZSBhdHRhY2hlZCBkdXJpbmcgYm90aCByZXNldCgpIGFuZCBHQlBBIHVwZGF0ZSBwYXRo
cy4NCg0KVGhlIGNvbW1pdCBsb2cgYW5kIGRvY3VtZW50YXRpb24gd2lsbCBhbHNvIGJlIHVwZGF0
ZWQgdG8gcmVmbGVjdCBhYm92ZQ0KY2hhbmdlLg0KDQpUaGFua3MsDQpTaGFtZWVyDQpbMF0gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW9tbXUvMjAyNTEwMjQwNDA1NTEuMTcxMTI4MS0x
LW5pY29saW5jQG52aWRpYS5jb20vDQo=

