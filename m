Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EF6CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 16:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFx6p-0005Cv-Qp; Mon, 03 Nov 2025 11:08:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vFx6a-00058z-9K; Mon, 03 Nov 2025 11:08:28 -0500
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vFx6T-0000dl-IX; Mon, 03 Nov 2025 11:08:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAHoOcCjUVQcUivHaXD9P5ysLn6n4OXHm3JbTOupHPU0TCDMue3rRW4HWWRyYvQQG1RpY/peEVSlN+JAD5dTphagg8vgPhGbOChGHpmh1CdBb9+wq1m5IrCxfWRufx8piRqdA+sU7mcJHGY6T1eHCaE2a34GClai6LdT/zWuTsciToLP0qG+0ypSZEqtCFvFgpJUvGcvPEdQp7l+gxzun9Y1/DwsRqLmqg6SitEUBNzkZF8q3usyfXySHALgdK+56ylXtfDsG8WqltZLMjZZUYujVKwJtMEI0J0fGpwrb+0uhAGFhgcbn8QyEE6vYPj/j4rj9/VDJsQuODbU8R46sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVzlXiW8cHUYxjSj9jafU5P5oB/4PVypTGuElxAKJU8=;
 b=o2AQo/dlcqpDwUxRoaZC6c6lg0DT3061vjw5tNgXNOsGFFBPii5diAwzxxgwHaYjYbbL+jn4koRk8YFWbajuRnfw5UKupdS3jzAA3oBgR5euqN1tbVnxUD/vR0n40vYW7S5U+56g+TMCtMRQisShqchS5W09Yxl1x0iBybq+gH0gsLuasfR/VRajH6pPIoVikpULolso16nHlJPnef00N1vwvTsDcwjLe9ujKIatMYn9ELiAHFBQHY4O/7mt5lCjj4fTJFggdm7JptMmd84OVbOILklNTvacIOyKgnzSRUIngQge6xOyYMn4P+xm6M+J4LZrzP0jNgGCzLxoT1eIEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVzlXiW8cHUYxjSj9jafU5P5oB/4PVypTGuElxAKJU8=;
 b=JFxx018DVG5ECjBH9+vCNNbIBo/rmyK2F1EMoIYwmeXvGZ1MKOi0I6sNVMYlli2plBI6oAbancM235LL3X7Cne3Yh/0K8kCNjccpt/hS+hgWg2BlkoP4V2Wkz6Xb6xSk9BTJOEGFd9plkgZF8Y5K7+YRJsb5G/rcX19UMr7Qj/ITWWug/RDeuyWHceyvUuTPP7BdFthlJY1CtNRNHvdNUcE77dGYvDqmlQDsAWDP+TufD1BsqtZklxU6DZNPE+FkKLTDvnn0oWtWDds3LOkK86XDRPPTxivYYcjPD981/jSyDh1vm3qQsSyFr6leYbDXtIDIjCgaaWF/CYnksyx74w==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH3PR12MB7545.namprd12.prod.outlook.com (2603:10b6:610:146::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 16:08:06 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 16:08:06 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v5 26/32] hw/arm/smmuv3-accel: Add a property to specify
 RIL support
Thread-Topic: [PATCH v5 26/32] hw/arm/smmuv3-accel: Add a property to specify
 RIL support
Thread-Index: AQHcTNOLiavZ9UoVTEW/OfUpbLSEXrThHLrw
Date: Mon, 3 Nov 2025 16:08:06 +0000
Message-ID: <CH3PR12MB754840F7A332AE3A6ED3648AABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-27-skolothumtho@nvidia.com>
 <2e8bd9fe-2434-443e-ae4e-e15352ff112a@redhat.com>
In-Reply-To: <2e8bd9fe-2434-443e-ae4e-e15352ff112a@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CH3PR12MB7545:EE_
x-ms-office365-filtering-correlation-id: 2df68f04-5528-4fc9-7803-08de1af32cce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?Q2k4bFBjSjJGNER0M3BLVzJKRjdpN2NhMTZTd0lKMW5SYkdEWklTZ1FtN213?=
 =?utf-8?B?UW9KZmppZTZRQmM0VHNxa0gxa01oaHNreVg2Yy9QUTVHZ2RRUGI2aWFseXFi?=
 =?utf-8?B?cGRKS1ZZeWZOOG15N1h0RmtQZzZvTGhKWGJoNENvUVJkU0RPd0MvTm1YMFhp?=
 =?utf-8?B?dkUvbXFWZmJNcXFzLzVsdnl1YW5kV2FwcjRJTlZNODJxVDlXRnJyTWlqNWtO?=
 =?utf-8?B?QnVPT0xYS2lMNGs0b2ZBMEV5clV5Q0FlTkF4VnBId2dCS3VXWEIwTlIvWmRi?=
 =?utf-8?B?bS91VU8zbFhxNUxlb0YwdE5MYmNpaklVRVZxanVVN3BvOVVLVml0aUxId3dO?=
 =?utf-8?B?ekk3a0JCbGdQMFBWLzFoNlc0ckRjMDh3QWRwSnRtK0VYdW9PWXc4MEpXMm5i?=
 =?utf-8?B?VlNyeG9SdVhqeXhiVExXZ1NOUkFQZ08vd3dHR2VSa2RFdDkwWmRQc2Q1UEx5?=
 =?utf-8?B?Wll5VG1aSWdocnZEK1Naa0lBUkRKT1pjdFBXV1hiNkZBcVplZnBsSkVIK0xa?=
 =?utf-8?B?UmNWOVRGUmZFMVU3VksvVmpwSlZVb2NEWWdFc3RJWXhOaXE5Y0NpenR0b1hx?=
 =?utf-8?B?TDBqZ2JMMDZ6SFFpRkJzUzNLWkYxR2t4RmpTT3MwMUMwKzJRVmoxSmxJNmx5?=
 =?utf-8?B?QUtVRTJtQk9JSk1qNk9CS3lyQlNvUjIzZDl3WFVveVhibnlnemxhK2FDOVUr?=
 =?utf-8?B?enJJWWIrK0NBeG56SFM0cGZpS2FDWlF0MS9rKzNNZUJLZGd2MU0zMFM1TTN2?=
 =?utf-8?B?R05pL3NyMGNEcXZpUkpmK2hGazcwSXdyNExRUkQzamdZVEFRZnY4VkhhYm5s?=
 =?utf-8?B?ZXI1TXN0bVFUR3N5UjMvSnhjWE9WcFRTemczRU9wVjR6UURydEQwRmsrRmEv?=
 =?utf-8?B?R2Y1UE1RMFZvVDJZeEQzSGVGa2ZLYkRMSklaMW5EZzQvbWZVZ2s2RWk0ZzlN?=
 =?utf-8?B?VzBrYjJJak9XSkoreVBtWUpUMng3c3RaNDlsWncxQ25KTDZaQWg2cEI0RURx?=
 =?utf-8?B?c0FkQ3pXK3dKT2RNYjBEK3FaQnNxck1heE9Ic0tMYXlWWEhMK3ZWQUZFWVZB?=
 =?utf-8?B?bmFNcnRPR1NhUndXa3o0NVlQU3RIVVpLZno4ZW52UmtjTU5TbVpEcll3aDRY?=
 =?utf-8?B?WjhjZmJSTWVWMDBidGtvcGlVLzFwWklaV3pUcG5Qa2NHUU0xaXRHR1RKaGRU?=
 =?utf-8?B?QjNrREVTZEpQZ2g4UkRhMks3b0pscitIWitnTVowVWlzUG4rL0NBN0NMNjA1?=
 =?utf-8?B?MXBYUk1vNnBSWUlBak4zRnpxWGI2cnVoZC9mTW1rUXBRRVpHTHU1emVQOXFy?=
 =?utf-8?B?VlBsUnFkYXYxVnJETWxUWjZDWjdzL25xWE1lQno4TlZzQnNQK2k4anF0alhM?=
 =?utf-8?B?SjNJR3Ruc1RkamprdC9TTTRsTHpXNnZIdU5QNkdLMVB6WUxEWTU3STdKU2tr?=
 =?utf-8?B?ZHpIcXVzaDBickY5WEx6ZkkvZk9RdytEQ3BUZmJWZ3QxdVE5QU9BRG5LcWR4?=
 =?utf-8?B?Q29SUGdBWGtDSlZhWTJKWFgzaUY1MlNWWnRmVjdMNENjZEtkSmtVeEhDVWVx?=
 =?utf-8?B?eE1jcmZDcWVYV3pneTFSUkc1d1Z5YnlXeURwVjFNY25oa01DSlBUVnE2Y0FR?=
 =?utf-8?B?RmNlcEt3T2QzRFVHY25lT0NZU3hha29OL3NUSmxFeTVXLzVIVmthbGdEWDZK?=
 =?utf-8?B?VldiM1BTc2ZHcmRETERWZlRvYXFRTFJOaWtmdXU1MmxBRWtYUTNCb0JpYVhH?=
 =?utf-8?B?azJBTll3Nnk5ekNHZng2WXdxb21PdjZJUk5JazUxSjVMS3F5em1XY3c2TGN3?=
 =?utf-8?B?NE1OSUVuZzhSTDM0dlhJbkRnRkY1NGpaeGJhMUdPN21XQkRjdlB1ZUovV1pz?=
 =?utf-8?B?UGtpcjZIVDgrMTRObys0bWNOMU85L3h4d2thWGZHaEY1TUVBbkIrdlJFVXdO?=
 =?utf-8?B?ZldLK3pzNXF0ZUhWc1RJbW4yQUdENG9rcHU4ZklUZDFNaVNmcDJZaHlKQVhN?=
 =?utf-8?B?dEJHemRQUldXVFRRVUQ0VVdYZWk4U0FaQjZsWHBFdVllSXhRQmRhOFp4a0ZI?=
 =?utf-8?Q?K+ofwo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzRyQytyTEVZZ1BlLzFvUmx1aUdZb0NOdlllL1BJR0lBSStKaE9xVWlvL0hh?=
 =?utf-8?B?WlArdzBjN1JPRUZndGZOTUVUVEMyUm5vYkR2dXRLR09zUVNCT2VJYUQrd21K?=
 =?utf-8?B?M2ZZcHRXbU5ITFB2eTMzVDRvOVNhSUVUMS9pd0FCKytBWFB5VEFvSUltc3hw?=
 =?utf-8?B?dklnaVdlZ0dTbFVNSmljS0ZNcXB0eFc5dno1ajllbGdhV0ZDMmRnczFjZkVW?=
 =?utf-8?B?ajdpMHhTV1lpUzJqU1d5b2h5emZvaDdrQXdocVVsWjNrTjZpQTZiWFZoYS91?=
 =?utf-8?B?emNVNUlqeFhnK1hrUS9IRXBkeW1pNHM2UzhhUitjQzdoNEpnMTcrbFYzL3M4?=
 =?utf-8?B?VDRTMFREaS92WFl3Q0trbWVhMHVPUDI1ZDJ3K0srYmFMMS9FSmVLWDZPem9z?=
 =?utf-8?B?K3daU0ZOTVNyZWttNFdDeVgvMlU2TUtsbGZrVVVqbXRuaFo3ckdVYmZMWlB0?=
 =?utf-8?B?K1VHR29idXByVjVaUVBndllkMFVweE1TdTN3YVRCWlQrWE9FWllaVnhKcVVF?=
 =?utf-8?B?d3kvN2twUmJlY09JYjVuKzNMV0pDa2w0dkJCRTNYaTBXWWlYNUNjZVJGMXZ1?=
 =?utf-8?B?dW0vaGZ2SHBkVGJPUWpxdzZsVXlud2NMK2RIcUttRDdhZnRHRS81RlIvLzI0?=
 =?utf-8?B?UzY3Q2RPcS9NOWlSN1dJZUlHTVJoMTNUT1lMTHF1SHlLak0xR0V3YzRxUTM1?=
 =?utf-8?B?VFZDTHkwTVNIS0xqU0FEZjVtbTR2cDlVUVJMcGRqZmxvV2U5cGt3Rmd2dDYy?=
 =?utf-8?B?RlpQK092TVpCT3lJemwyeWVnWFlMNmprWi9pM3JEWU9XdEQweEw2SVJaUWtr?=
 =?utf-8?B?b0ZlbCt3blN4cTdISFJLb2xjWE1EVkNZQUg3elpNbDNrdThMMjBsNE1mRSt6?=
 =?utf-8?B?bkxCSWN1RkJUbGVoaXhyVHZpQzZXWDl5ekJXVHhwVFB2UERLVDZGUFBtZi9T?=
 =?utf-8?B?a21oNTFEZlJjOTJGS3FkSGZOUnVEbzVJNkp0Zm9oVTFzajVMNnA4WGNtWXk4?=
 =?utf-8?B?enZDU3liL09va1dmcEZPZjNhSjczQm9uZHkwRlBCcDV2QjNqdzdiQmFWRDVz?=
 =?utf-8?B?UURRWGtaQmVIMko3aDhqeXFPbzBDUWRMSVVMRk5VRTc4dTE1L2dTUC9pdm0z?=
 =?utf-8?B?SlBDTDd0dm9kb3NmdFJGVmV3Yk5wRW5malZZZ2haeXFVM3pKd0VrRExqVnVw?=
 =?utf-8?B?UnI0emFNdDFpeGFLdVYyTTk5MFROcmdzRnhGQXZneUxkMUZrSFdUbnBPWmlZ?=
 =?utf-8?B?UHFxY1UyNGdnT3hCS0RRVVF1M25GVjFWdmYyRVhad0NqUGlMMUhneFJ3Mi96?=
 =?utf-8?B?TE9LamtJTWcwdDJMY3VlNmxVK1JoSjEzZE5RRWdtWlFRR01JM0hWQ2kyRkgr?=
 =?utf-8?B?NVovMUNuQzhlaWd3RE9UbFMrYTUwTGwwd1cyMFRNMUR1azE3SzE0Skl1OWpF?=
 =?utf-8?B?VFJlVHdvWjNUOVpuNVdEelV1bzBWWkFSUmRmbzRET0kwUmVpMXBTcndSRnhE?=
 =?utf-8?B?RjlPMzRmN2hJdzBFS3BSclFHOGxTdVZoRE5POG9ldGlBcXJVYzI1UzBxZkdw?=
 =?utf-8?B?ZkRJMTJmdm1kbDJDdHlraXRseU5CUVVHejA3bkZxQzFyVzlGOTEyYUVLYXB3?=
 =?utf-8?B?NnUwZS9zZVlFZUUyK1hYSTZYamVWOVBnTnhpU3ppNE5COG1ZTnNXM0wrcG9N?=
 =?utf-8?B?ZnpzU0t0Y2JGVDVsUmFQdVFQLzYxQ2ljRnc2ZU5vdEVGdnNCc3l4UDQ1T2FB?=
 =?utf-8?B?aURoalB6N2w1WkdvYUVCT1JoT3dTOGdoQm54eGtaWGpEUjRTZHlnRXpZV1Rs?=
 =?utf-8?B?OTBNMUVvalVUMDJ0cWhyYUJ4Wk1YeVRKNklWMmhQVU95bXpaeFc1M0xSR3pB?=
 =?utf-8?B?M1cybHdxazZZK2ZLTUNuNU1MVENITHJneGt0VnFSR01pRTRoWUF1MWNaRGZY?=
 =?utf-8?B?ZVpuMER6RzBXKzBsSTlOYzc4R21KZm5SYVVUMFFMcG82MlpiN096RDFteFBz?=
 =?utf-8?B?VDY3T3lSMCtKdjlUM3RtaEh0N2JBRW81RzRpL3VidjhJb2JlMzBSdWFJcmRm?=
 =?utf-8?B?QVNyazNxYzAvUE1xMHZ4dURrRE9lQ0RIVXc1dldDaGVINzFwdmorR2lTTkR6?=
 =?utf-8?Q?OBcF/DxX8/o/Y0ytQYVnJegT2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df68f04-5528-4fc9-7803-08de1af32cce
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 16:08:06.3659 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/es2doPwEaPvYHGj4+RF61gLWbCILdzp9SSt4d/Wm4vU1y2pWq9LgRaYmppvHdjwdr02Ux1f2+0zyttLBpSYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7545
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDAzIE5vdmVtYmVyIDIwMjUgMTU6
MDcNCj4gVG86IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsgcWVt
dS0NCj4gYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGV0ZXIu
bWF5ZGVsbEBsaW5hcm8ub3JnOyBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgTmlj
b2xpbg0KPiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsgZGR1dGlsZUByZWRoYXQuY29tOyBi
ZXJyYW5nZUByZWRoYXQuY29tOw0KPiBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPjsg
TWF0dCBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsNCj4gc21vc3RhZmFAZ29vZ2xlLmNvbTsgd2Fu
Z3pob3UxQGhpc2lsaWNvbi5jb207DQo+IGppYW5na3Vua3VuQGh1YXdlaS5jb207IGpvbmF0aGFu
LmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56aG9u
Zy5kdWFuQGludGVsLmNvbTsgeWkubC5saXVAaW50ZWwuY29tOw0KPiBLcmlzaG5ha2FudCBKYWp1
IDxramFqdUBudmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDI2LzMyXSBody9h
cm0vc21tdXYzLWFjY2VsOiBBZGQgYSBwcm9wZXJ0eSB0bw0KPiBzcGVjaWZ5IFJJTCBzdXBwb3J0
DQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRh
Y2htZW50cw0KPiANCj4gDQo+IEhpIFNoYW1lZXIsDQo+IA0KPiBPbiAxMC8zMS8yNSAxMTo0OSBB
TSwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPiBDdXJyZW50bHkgUUVNVSBTTU1VdjMgaGFz
IFJJTCBzdXBwb3J0IGJ5IGRlZmF1bHQuIEJ1dCBpZiBhY2NlbGVyYXRlZA0KPiA+IG1vZGUgaXMg
ZW5hYmxlZCwgUklMIGhhcyB0byBiZSBjb21wYXRpYmxlIHdpdGggaG9zdCBTTU1VdjMgc3VwcG9y
dC4NCj4gPg0KPiA+IEFkZCBhIHByb3BlcnR5IHNvIHRoYXQgdGhlIHVzZXIgY2FuIHNwZWNpZnkg
dGhpcy4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxqb25hdGhhbi5j
YW1lcm9uQGh1YXdlaS5jb20+DQo+ID4gVGVzdGVkLWJ5OiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVp
Lmdhb0BsaW5hcm8ub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0gPHNr
b2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiANCj4gSSBoYXZlIG5vdCBzZWVuIGFueSByZXBseSBv
bg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvYjYxMDU1MzQtNGExNy00NzAwLWJiMGIt
DQo+IGU5NjFiYWJkMTBiYkByZWRoYXQuY29tLw0KDQpTb3JyeSwgbG9va3MgbGlrZSBJIG1pc3Nl
ZCB0byByZXBseS4NCiANCj4gSSBndWVzcyB5b3UgY2hvc2UgdG8gcmVzdHJpY3QgUklMIHRvIGFj
Y2VsIG9ubHkuDQoNClllcy4gSSBoYXZlIHVwZGF0ZWQgdGhlIGRlc2NyaXB0aW9uLiANCg0KIEFi
b3V0IEFJRFIgY29uc2lzdGVuY3kgY2hlY2ssDQo+IGRpZCB5b3UgaGF2ZSBhIGxvb2s/DQoNCkkg
aGF2ZSBhZGRlZCB0aGF0IGNoZWNrIGluIHBhdGNoICMxOS4gQnV0IFpoYW5nZmVpIGhhcyByZXBv
cnRlZCBhIHByb2JsZW0NCndpdGggdGhhdCBhcyBoaXMgaGFyZHdhcmUgcmVwb3J0cyBBSURSID0g
MC4gLiBQbGVhc2UgdGFrZSBhIGxvb2sgdGhhdA0KZGlzY3Vzc2lvbi4NCg0KVGhhbmtzLA0KU2hh
bWVlcg0KIA0K

