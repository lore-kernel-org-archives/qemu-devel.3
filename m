Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FEBD44C57
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 14:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgOPc-0001Ij-KS; Thu, 15 Jan 2026 09:33:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vgOPO-0001AK-SA; Thu, 15 Jan 2026 09:33:11 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vgOPL-0006Ip-DH; Thu, 15 Jan 2026 09:33:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZ430lrVXqSZzhSOoZyqtAPJJTwcrLNIq9Gdzod45jUh4RZ8j0GbBpHR8Eas/F+RbbcG/7vNB8LmkADyIpFhok8hcKu1H1icbCnkVV3WhrRshikOCgHi+7CGh2zL7vDpXrsMzTV1aNB0JDbxWa+22mLTdjgKAqiswKZ/MxKeiDL+5Id5+JCuLwdSySe3sAvOTLF6ElX3DTX09P+QnbCS4CfV9y1jjZUreGrot6bYgLZSn1W5SvOEvAAZAq4yZg9xbFvQ67cm4oMSitX3K3T3X/rlEUCJER5WD3ylF70B7KHw7QLIatWkdRjTYWfViI6V6h2icIh+dDwPKTjOqeIEBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXkYlhXiPqP51ycMr+XsUH804dPkzhmsnA8IAbws4fs=;
 b=V9UUxXQACFJQc/A1A2/hAkTZKZqb6ZLnp/mDfqiQqI9YYHFfvrC9+cd6ai4q+2KgxzTiX59qZvQggwOdH9c9f7v/uXd/2o33+dJXv1puBQjcb3EcZkwlIXVp8GcZ+9KH8tyTX5AaM8rmplgfPQ+KrW5JiLPt8kqq5AGHDUMqV5DaMHFzDf56pnouWha/1HRjXusNbADhhtpBqV6micaZtBgUja1uCjryupmkIVStnw0YBL7udSMYYmIdAb//BkGo6PfXcnPqnNOw+g96sJ7X1AznFx483PzExfKcH1gsQ1f0AedjVjRA+4DDXBiovf7s4lNvnmupvS7nnDOnSGDNiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXkYlhXiPqP51ycMr+XsUH804dPkzhmsnA8IAbws4fs=;
 b=SUwK4J12XQVu6A/T1O06tayJTemzhDOvH72crjcO2HFFrzuDw8pHdT1tT2GxYmDmEl7nlYpXyPyRC8bEJGSVraaQEXdX8R0hz/kXsjjR/LcN6oSlba0ozc9eEkV7NOnkBMpgnxooIcs65OiFNDlMHbPqtA4cyLUZhT/C48ozbV6+yI/P2mjesznbgTrynaPyo7zYisuzezlBO36ZIspD1xRf1sP9ck4N5LGr6AGLxtC3ETUMUnl/3QExRe3UTYC7icmF1soIDvdENgpl3YreiVL+/k/kOZcB/tFg+KBobY6Ozp3pFp75EUIx0ygO6/Fvn927HgklGNkgORnHcevhZA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY8PR12MB7492.namprd12.prod.outlook.com (2603:10b6:930:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 14:32:58 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 14:32:58 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, "Duan, Zhenzhong"
 <zhenzhong.duan@intel.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "alex@shazbot.org"
 <alex@shazbot.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v2 4/4] hw/vfio/region: Create dmabuf for PCI BAR per
 region
Thread-Topic: [PATCH v2 4/4] hw/vfio/region: Create dmabuf for PCI BAR per
 region
Thread-Index: AQHchTZ4zPDOtOOOF0CM3m1uwmwnmLVTMKWAgAAbqTA=
Date: Thu, 15 Jan 2026 14:32:58 +0000
Message-ID: <CH3PR12MB75486D6FA0CC1E5BC6A6F4A7AB8CA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260113113754.1189-1-skolothumtho@nvidia.com>
 <20260113113754.1189-5-skolothumtho@nvidia.com>
 <2fc6c3fe-68d9-47b9-9336-8086b372eb9d@intel.com>
 <13a2c58b-e0c8-40cf-a3e1-6f8ac3d0540e@redhat.com>
In-Reply-To: <13a2c58b-e0c8-40cf-a3e1-6f8ac3d0540e@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CY8PR12MB7492:EE_
x-ms-office365-filtering-correlation-id: a1081812-4890-4b49-b272-08de5442fade
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NUo0eGlnSzF0ak4yN0dWY1JRY2d1NVFBcGplQlIwSFFFa29HNXNzN052ZjBT?=
 =?utf-8?B?eGZjZEI3YU1DdHRlTTRmSWRzMW1sMit4YVlhRHNXTFFPaEJJYlBaaG82Vyth?=
 =?utf-8?B?ZUFhekZ1a3V2bzc4c3lEK3poZGdYRlNZYkNqVHMvOWpTVDNzQjYzSzJibjBQ?=
 =?utf-8?B?dFlrbFkzRVlMNyszZzR3NXlNekxWWTh0UkhiVlR1QTlIeHV6RFlhVU92cTh4?=
 =?utf-8?B?VlRVb2NHL2VRYml1UVR2dUZrWHNuS3JGeGR5ZlNKQmlTSUFFaXBlSUFPYnRE?=
 =?utf-8?B?a09OZTFyWUpCVUpmcWIzdllvUHJvVFo5dVBQMVRKMmxJOFZVVjVPbnRBc1VX?=
 =?utf-8?B?Z0w0RTZEdEg1RGZvYVJMakVWWDNJNjBIWUdvekRUU0FtM0ZJT2hENzlTQ0xM?=
 =?utf-8?B?VFlNaDVLMmhFVExRVHZlZkhzOE50V3BJOGxGemVucmRKUVliNGpZdWp2SG03?=
 =?utf-8?B?Tm5zWE1aaFpKbzNrK2tLNzF0dXA4eUtaVDRGSHEyT0wwa3NUakFwZk9oSFdB?=
 =?utf-8?B?ZDJtSldYOGFYbUFLMmV4S0pkTFE2Wmk3OVUzNnlmWEZuSGJIWDBTSXpxaHNu?=
 =?utf-8?B?YzNCd20rb0hhOUhRNmxDRlFqakxvOFNlZGQyKytzc2kwSHNjYlJza1gzZzQ1?=
 =?utf-8?B?dlp0amtSamJ5ZzNQRExtc0lQdnRkK2VuVnFRNS9NT1oxQVU0d3NOQU96STVl?=
 =?utf-8?B?alpyZW9lMmZMWHB2NmNTMzlZOFhoeTB5OHdVNmpSYnpTUnh5eTNaV1pvWWNE?=
 =?utf-8?B?dndhS0VqeXBXSXd0eWRVdVRFQ1BhZU1VOXYxazhDeGZZaXRma01JMnFiamRG?=
 =?utf-8?B?S3hVSzJ2aWp0QnpwOGYyZkVzODRDZng0LzN5aStqT1BObk11Ykg3TkhxVVRz?=
 =?utf-8?B?akhLUjUzWmMxMzV0SFlXcjJQZjloZkVpV3NXdDhBZG5zVDBZenVsb3FCUFJH?=
 =?utf-8?B?NXhxbU1IRlVhZ3pyaFNNanI1R3BWUnB3UjViQi9Gak94RzRzdW1iSDgxOUFy?=
 =?utf-8?B?TUNLZVhoVkZ4b0ZBSEpaZXZpcFJBWlZyZHN3V0x4RnhtZ251YmhoZGRvZHQ4?=
 =?utf-8?B?U3Y0aGxORU5sNTNXUWtoakQ5TGZJY0srcmxIbUdXME9pa3ZqSTUvTGxEVnJF?=
 =?utf-8?B?RWN3L1BZditwWmY2OXNFK01iRVJ1dkN2Ky9OVkVGRjFGZVA2b3JEczBBMExR?=
 =?utf-8?B?QXlBa1U4cysxQ2lrWlp5a0VseVlEeXkwTEhIMXRaMEZSL1pyc2F5YW1Nazly?=
 =?utf-8?B?bS9sRzgvREVrSldxVzRJNEJFdHEzNkkvaVM1UU1TVXZjb3pJenBUeFAxTHdm?=
 =?utf-8?B?dGc0NEtMa0s1RWhNcnlmbExpajhPZENXRmhJQS9aRzNSMi9YeWppelpXQ1U5?=
 =?utf-8?B?eGhVTkN4OUQzWWRNVFBZbTRCdWNVVUdObjlFTXhPQXRFUVcyWEFzSEoxYW14?=
 =?utf-8?B?aDN6dC8vMlllQ0ttSWRyTWVWei9QQW1VeXoybWdOVW51NkZ0YmFjaEk2SmZ3?=
 =?utf-8?B?ajlwTE9IOENnVDF3NXo0U1p0SXRucGtCSEdqSER6NVdSYkRpNVZQSU1YNlhY?=
 =?utf-8?B?MDE4dlVYY29VRHcrREpMbnhYVktXMGcvQkRiZDBETG1aM0VXT3AwTGVJMG9Z?=
 =?utf-8?B?QWJ0TGlVbndqN253NmtILzdwK3hOUTVXcEhYSDlNa1Q5UXRPSWhWRXdLUlBD?=
 =?utf-8?B?K2ZtaFpRSXU5MkEvb3gyYmp2TkRmUG9Od2xnNm1WRTlCRUlTWkJCSUROc0JB?=
 =?utf-8?B?MU5mUXlPNWtWeVdMeXA0YTYzSEZoTXE5ZEFjSGhPT1BsVUxoOWZqbXVRcERO?=
 =?utf-8?B?am5xUEdvMFRkZ2xnYlpBL3lwSUFGZDNjN0lvaW84emdidGQrU0N6dUxRSk5S?=
 =?utf-8?B?MTd4VTZycmR2K28wb0tLL1dKQk5LanhTc09saHUwYUUrZlhWbUQyaDdkL3JW?=
 =?utf-8?B?QUlzM2k0bXBvdTVsdzZ4YTluY3pVczZ1akxEdVhtVkV5ZEtTMFF5V0tQOWc3?=
 =?utf-8?B?QkJxYTNIU2ZpSXl5TWVZeDVhMHNjdTJIVFVJNFdGT2dOcGtZQk1Gd2lyZ3J6?=
 =?utf-8?B?WXJ6MTZ4QWdkdmpZVENRNDA3QkpIa0pLYlhGcHR1VDE4ODRNbDNlUzBGZyti?=
 =?utf-8?B?UUxHT2diY0RQeCtuUmFDdk85Q3V4ckRicjc2MkFDUmUyYzFYQmRxNjA0QVpk?=
 =?utf-8?Q?fEKcfgvFk9YfYtRo5gw0JwQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjNDTmhVNTJNUG1TVy9jUDFwaFRoQndhZXF5V3JzRmgvNVpZZStsbUJUK2Ev?=
 =?utf-8?B?d3pQL2pFM0JLb2U0aVVRMGQ2dkxJZ05rWGlIREJ5ejRCSDI5VGpSTlo2dFFv?=
 =?utf-8?B?RWtsam5ZM2oyVkd3OXNXeVQxMFV6S204ODYzQjlhZXg3S2VtSUphSkpYcGdx?=
 =?utf-8?B?cmdUaXRHV2JjWkN2cEw5dTMrUy9PVGU3d29vbERhM2gvbmZFYkpKV3REdUp0?=
 =?utf-8?B?dGRBWFZUaC9XYnhqRW5XVVB3NkhMNmtJYnh5SUE3QmUwTVgwd3VNNHVleita?=
 =?utf-8?B?Zll0MVJJbTFubFNKT3lXNlY0ZloyWk1jelR1OTcwM3dpMnV2QVFjRG1XbnJz?=
 =?utf-8?B?bkQzL0pSd0YvS1BJaUVwSUZRbEI2RzhtSFI2MlgwSEVCY3ZTck51OHdmRmw3?=
 =?utf-8?B?SzJOSktiSDNkSnFZc3VIUzVOc21VOEF5TlZmOG1iZmk5NEVNT1pIUmEvS0tO?=
 =?utf-8?B?UFFQcHY1MlRXeldMVDFYeU5pVTBqckx5STRNL2N4bmx1WHdxTHB4ZGhDVzdh?=
 =?utf-8?B?VFErc3d0QmR6VmZIQ3dyQjJqUWF1dldocTQvNDhJMDNWazdoM1grNHdiWUVK?=
 =?utf-8?B?VUUxd2pPN3kzb0ZFRXRqdUhpZkU2SWpiUDJ4cEJSSU9pQTVVbE1PMjlwdFRk?=
 =?utf-8?B?VVlOQzl5WUFSMmdGaWFCdHlBSER5aFZ1S29CRkZ4WUUwT1FFMDFtbEtzQkEw?=
 =?utf-8?B?dG5SK0JGMTFqV0t3c29UWG5sS0dwd1pxWG4zNjdLS254ZHNYZitnWklBa3NY?=
 =?utf-8?B?Nyt6bVpBMnFHYjE5Uld4SzRSZEdwdU84K0VPNjYxOENFVzUrY3JMRW1rSEx4?=
 =?utf-8?B?eFVMb3hEcGlxRndzdTRQSHJxS3BZdEhBYy9kMk1ZVUF0SkRCMzlQcE9GUnh1?=
 =?utf-8?B?Myt3eFFkaDFNUno3OFphUlg3d0RMTVR2eElpWVpuV1hqRU5HdjFlNEdhTjgz?=
 =?utf-8?B?ZE1GSHIzL2hBTjFoNmpoblNlU0lQM2p5RXdqcVBRTHhyK3lmbldEL2RPekZy?=
 =?utf-8?B?enV0WFRnSFdsZkwwa1dTWWJvbnhIZ0RMd3AzTis3VGpuZjFLUzI5SFdvT3g5?=
 =?utf-8?B?OCtiNTVHK2tSSGszQVoycWhqcWQwY2VEODBFRFdiUUtWTTRWcjBocXFKWFdN?=
 =?utf-8?B?V0VUcFJEazZJNEFWMVJTZjBOQlRnWnNERTN3UVkxOHFvK1ZZRWY0R3d4amlq?=
 =?utf-8?B?V2MzOHdQL3dMd0gwWmpGOU01RTk5bEVWNEpqY2llcjNGZGVya204MUZKOFlD?=
 =?utf-8?B?eFBjREpHS2Y2LzV0MzBQUjRQeGpJdzM1cmhTbFlaTStMdEtuTGt3YWE1Z2V6?=
 =?utf-8?B?N1k4dXZUbmZTMDVZd0plc3U5Z1pwREVESmZWcUMrS3N2Tmx1SkxNcjR2RVdp?=
 =?utf-8?B?Z09EdlNpNGlnNWFXNURic1pIRjFTcTlaNFhxNHpHeUp5cVB3Mjd3Z3NleUF1?=
 =?utf-8?B?WnVpYy9QY25iN3pGckRGT2hTYlZidGFaOHJ0S1BkOXZrNzRFUE1zcE40bzBH?=
 =?utf-8?B?alNJOGZ2QXhMM2VOZ2N3Rk9HVE5uYUVWSWN1T0RTOGYzSVIzaE9scG9aalRQ?=
 =?utf-8?B?bkQrOGVaWXdMemxGdS9pUVJldmRPU09seU5RendDdUxSOFpnNTJ6SU5VN2Q2?=
 =?utf-8?B?S2lmdGtKWHErK2ExZHhOMFBrdkZWbnl1QXpOOW1NL2FhWDNxdWJaRG4rNHJ4?=
 =?utf-8?B?SW82cnZpSVkxUmxiZDdlSjdETklSOWcxd2dXdU1DM3lOMnUzeUFCbnZOU3B5?=
 =?utf-8?B?cm1iTWdENnk1ek5oenFUQ0xGVE5neU93dUdjUGtnVFdCZ3g2TXlETHlkbWRk?=
 =?utf-8?B?ZWIxOVEyT1ZnV3JuOWJ0VFRhWXI4N3BqOWZyYmtudzR3QUF5TklNTXBXZTQ3?=
 =?utf-8?B?akk0ZDQ5TFVzOVNiWlB6TmNYV21od2NXbWxFUHpXNnk1cUdENWZKQ2F1akRZ?=
 =?utf-8?B?UWRNOW9tTGYwV1BnRjJZUTdGVFlaTkpQUVZQNjVaYUhvQVc2NjhKaGVzeFJz?=
 =?utf-8?B?V0VBVVU5aHl4UmZsY3R6TlpNT2xtRERxUzJKaHZ1UlpNM0N1eEFhWXhZa1Ro?=
 =?utf-8?B?a0tUMDlJMGM5ajFETGs1SHZlYm41Q3cxOTRVbW9idnBRbUN1WTY4RldZdFlX?=
 =?utf-8?B?L1BReFlFS0hGM2FNYmwwaXZuYm9ZTlJkQWdaS3UwSDlWMVErYmZCb3VpTkp4?=
 =?utf-8?B?eDlRWVJnMVVWTG9FQS9JTzBwNURNRXRCSURuaS9PY1NoemhHWUk2NlZkVDRU?=
 =?utf-8?B?a2dTSitzWlZQNFp4eVo5V3lrdFg1RE5xL3NsOVpVQnZadjRXakxFWkVrVXNR?=
 =?utf-8?B?SEs1blc0Vm5zaVZRYWVvL2JaR1JoTVFaVDdQbnA2d0c5aXB6UFZkZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1081812-4890-4b49-b272-08de5442fade
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 14:32:58.6196 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7L/a5Ge/1mb2R+szbF+5Bo1wFlFCXw9wNaXGbv75S9bWpHK69p+Po9f065rTanRE2d8vWybPTxswjMcNgsjcsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7492
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0
ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiBTZW50OiAxNSBKYW51YXJ5IDIwMjYgMTI6NTENCj4gVG86
IER1YW4sIFpoZW56aG9uZyA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPjsgU2hhbWVlciBLb2xv
dGh1bQ0KPiA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11LWFybUBub25nbnUub3JnOyBx
ZW11LQ0KPiBkZXZlbEBub25nbnUub3JnDQo+IENjOiBlcmljLmF1Z2VyQHJlZGhhdC5jb207IGFs
ZXhAc2hhemJvdC5vcmc7IGNvaHVja0ByZWRoYXQuY29tOw0KPiBtc3RAcmVkaGF0LmNvbTsgTmlj
b2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsgTmF0aGFuIENoZW4NCj4gPG5hdGhhbmNA
bnZpZGlhLmNvbT47IE1hdHQgT2NocyA8bW9jaHNAbnZpZGlhLmNvbT47IEphc29uIEd1bnRob3Jw
ZQ0KPiA8amdnQG52aWRpYS5jb20+OyBLcmlzaG5ha2FudCBKYWp1IDxramFqdUBudmlkaWEuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDQvNF0gaHcvdmZpby9yZWdpb246IENyZWF0ZSBk
bWFidWYgZm9yIFBDSSBCQVIgcGVyDQo+IHJlZ2lvbg0KPiANCg0KWy4uLl0NCg0KPiA+IElmIHlv
dSBoYXZlIG5leHQgcmVzcGluLCBtYXliZSBjbGVhbmVyIHRvIG1vdmUgYWJvdmUgZG1hYnVmIHJl
bGF0ZWQgY29kZQ0KPiBpbnRvDQo+ID4NCj4gPiB2ZmlvX3JlZ2lvbl9jcmVhdGVfZG1hX2J1Zigp
Lg0KPiANCj4gSSBhZ3JlZS4gQ2FuIHlvdSBwbGVhc2UgcmVzcGluIGEgdjMgU2hhbWVlciA/DQoN
Ck9rLiBKdXN0IHRvIGNvbmZpcm0sIGRvZXMgYmVsb3cgbG9vayBnb29kOg0KDQpUaGFua3MsDQpT
aGFtZWVyDQoNCi4uLg0KZGlmZiAtLWdpdCBhL2h3L3ZmaW8vcmVnaW9uLmMgYi9ody92ZmlvL3Jl
Z2lvbi5jDQppbmRleCBjYTc1YWIxYmU0Li5mOTI3ZTY0MzY1IDEwMDY0NA0KLS0tIGEvaHcvdmZp
by9yZWdpb24uYw0KKysrIGIvaHcvdmZpby9yZWdpb24uYw0KQEAgLTI5LDYgKzI5LDcgQEANCiAj
aW5jbHVkZSAicWVtdS9lcnJvci1yZXBvcnQuaCINCiAjaW5jbHVkZSAicWVtdS91bml0cy5oIg0K
ICNpbmNsdWRlICJtb25pdG9yL21vbml0b3IuaCINCisjaW5jbHVkZSAic3lzdGVtL3JhbWJsb2Nr
LmgiDQogI2luY2x1ZGUgInZmaW8taGVscGVycy5oIg0KDQogLyoNCkBAIC0yMzgsMTMgKzIzOSw2
OSBAQCBzdGF0aWMgdm9pZCB2ZmlvX3N1YnJlZ2lvbl91bm1hcChWRklPUmVnaW9uICpyZWdpb24s
IGludCBpbmRleCkNCiAgICAgcmVnaW9uLT5tbWFwc1tpbmRleF0ubW1hcCA9IE5VTEw7DQogfQ0K
DQorc3RhdGljIHZvaWQgdmZpb19yZWdpb25fY3JlYXRlX2RtYV9idWYoVkZJT1JlZ2lvbiAqcmVn
aW9uKQ0KK3sNCisgICAgZ19hdXRvZnJlZSBzdHJ1Y3QgdmZpb19kZXZpY2VfZmVhdHVyZSAqZmVh
dHVyZSA9IE5VTEw7DQorICAgIFZGSU9EZXZpY2UgKnZiYXNlZGV2ID0gcmVnaW9uLT52YmFzZWRl
djsNCisgICAgc3RydWN0IHZmaW9fZGV2aWNlX2ZlYXR1cmVfZG1hX2J1ZiAqZG1hX2J1ZjsNCisg
ICAgc2l6ZV90IHRvdGFsX3NpemU7DQorICAgIGludCBpLCByZXQ7DQorDQorICAgIHRvdGFsX3Np
emUgPSBzaXplb2YoKmZlYXR1cmUpICsgc2l6ZW9mKCpkbWFfYnVmKSArDQorICAgICAgICAgICAg
ICAgICBzaXplb2Yoc3RydWN0IHZmaW9fcmVnaW9uX2RtYV9yYW5nZSkgKiByZWdpb24tPm5yX21t
YXBzOw0KKyAgICBmZWF0dXJlID0gZ19tYWxsb2MwKHRvdGFsX3NpemUpOw0KKyAgICAqZmVhdHVy
ZSA9IChzdHJ1Y3QgdmZpb19kZXZpY2VfZmVhdHVyZSkgew0KKyAgICAgICAgLmFyZ3N6ID0gdG90
YWxfc2l6ZSwNCisgICAgICAgIC5mbGFncyA9IFZGSU9fREVWSUNFX0ZFQVRVUkVfR0VUIHwgVkZJ
T19ERVZJQ0VfRkVBVFVSRV9ETUFfQlVGLA0KKyAgICB9Ow0KKw0KKyAgICBkbWFfYnVmID0gKHZv
aWQgKilmZWF0dXJlLT5kYXRhOw0KKyAgICAqZG1hX2J1ZiA9IChzdHJ1Y3QgdmZpb19kZXZpY2Vf
ZmVhdHVyZV9kbWFfYnVmKSB7DQorICAgICAgICAucmVnaW9uX2luZGV4ID0gcmVnaW9uLT5uciwN
CisgICAgICAgIC5vcGVuX2ZsYWdzID0gT19SRFdSLA0KKyAgICAgICAgLm5yX3JhbmdlcyA9IHJl
Z2lvbi0+bnJfbW1hcHMsDQorICAgIH07DQorDQorICAgIGZvciAoaSA9IDA7IGkgPCByZWdpb24t
Pm5yX21tYXBzOyBpKyspIHsNCisgICAgICAgIGRtYV9idWYtPmRtYV9yYW5nZXNbaV0ub2Zmc2V0
ID0gcmVnaW9uLT5tbWFwc1tpXS5vZmZzZXQ7DQorICAgICAgICBkbWFfYnVmLT5kbWFfcmFuZ2Vz
W2ldLmxlbmd0aCA9IHJlZ2lvbi0+bW1hcHNbaV0uc2l6ZTsNCisgICAgfQ0KKw0KKyAgICByZXQg
PSB2ZmlvX2RldmljZV9nZXRfZmVhdHVyZSh2YmFzZWRldiwgZmVhdHVyZSk7DQorICAgIGlmIChy
ZXQgPCAwKSB7DQorICAgICAgICBpZiAocmV0ID09IC1FTk9UVFkpIHsNCisgICAgICAgICAgICB3
YXJuX3JlcG9ydF9vbmNlKCJWRklPIGRtYS1idWYgbm90IHN1cHBvcnRlZCBpbiBrZXJuZWw6ICIN
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJQQ0kgQkFSIElPTU1VIG1hcHBpbmdzIG1h
eSBmYWlsIik7DQorICAgICAgICB9IGVsc2Ugew0KKyAgICAgICAgICAgIGVycm9yX3JlcG9ydCgi
JXM6IGZhaWxlZCB0byBjcmVhdGUgZG1hLWJ1ZiAoJXMpOiAiDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICJQQ0kgQkFSIElPTU1VIG1hcHBpbmdzIG1heSBmYWlsIiwNCisgICAgICAgICAgICAg
ICAgICAgICAgICAgbWVtb3J5X3JlZ2lvbl9uYW1lKHJlZ2lvbi0+bWVtKSwgc3RyZXJyb3IoZXJy
bm8pKTsNCisgICAgICAgIH0NCisgICAgICAgIC8qIFAyUCBETUEgb3IgZXhwb3NpbmcgZGV2aWNl
IG1lbW9yeSB1c2UgY2FzZXMgYXJlIG5vdCBzdXBwb3J0ZWQuICovDQorICAgICAgICByZXR1cm47
DQorICAgIH0NCisNCisgICAgLyogQXNzaWduIHRoZSBkbWFidWYgZmQgdG8gYXNzb2NpYXRlZCBS
QU1CbG9jayAqLw0KKyAgICBmb3IgKGkgPSAwOyBpIDwgcmVnaW9uLT5ucl9tbWFwczsgaSsrKSB7
DQorICAgICAgICBNZW1vcnlSZWdpb24gKm1yID0gJnJlZ2lvbi0+bW1hcHNbaV0ubWVtOw0KKyAg
ICAgICAgUkFNQmxvY2sgKnJhbV9ibG9jayA9IG1yLT5yYW1fYmxvY2s7DQorDQorICAgICAgICBy
YW1fYmxvY2stPmZkID0gcmV0Ow0KKyAgICAgICAgcmFtX2Jsb2NrLT5mZF9vZmZzZXQgPSByZWdp
b24tPm1tYXBzW2ldLm9mZnNldDsNCisgICAgICAgIHRyYWNlX3ZmaW9fcmVnaW9uX2RtYWJ1Zihy
ZWdpb24tPnZiYXNlZGV2LT5uYW1lLCByZXQsIHJlZ2lvbi0+bnIsDQorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgbWVtb3J5X3JlZ2lvbl9uYW1lKHJlZ2lvbi0+bWVtKSwNCisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWdpb24tPm1tYXBzW2ldLm9mZnNldCwNCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWdpb24tPm1tYXBzW2ldLnNpemUpOw0K
KyAgICB9DQorfQ0KKw0KIGludCB2ZmlvX3JlZ2lvbl9tbWFwKFZGSU9SZWdpb24gKnJlZ2lvbikN
CiB7DQogICAgIGludCBpLCByZXQsIHByb3QgPSAwOw0KICAgICBjaGFyICpuYW1lOw0KICAgICBp
bnQgZmQ7DQoNCi0gICAgaWYgKCFyZWdpb24tPm1lbSkgew0KKyAgICBpZiAoIXJlZ2lvbi0+bWVt
IHx8ICFyZWdpb24tPm5yX21tYXBzKSB7DQogICAgICAgICByZXR1cm4gMDsNCiAgICAgfQ0KDQpA
QCAtMzA1LDYgKzM2Miw4IEBAIGludCB2ZmlvX3JlZ2lvbl9tbWFwKFZGSU9SZWdpb24gKnJlZ2lv
bikNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnaW9uLT5tbWFwc1tpXS5zaXpl
IC0gMSk7DQogICAgIH0NCg0KKyAgICB2ZmlvX3JlZ2lvbl9jcmVhdGVfZG1hX2J1ZihyZWdpb24p
Ow0KKw0KICAgICByZXR1cm4gMDsNCg0KIG5vX21tYXA6DQpkaWZmIC0tZ2l0IGEvaHcvdmZpby90
cmFjZS1ldmVudHMgYi9ody92ZmlvL3RyYWNlLWV2ZW50cw0KaW5kZXggMTgwZTNkNTI2Yi4uNDY2
Njk1NTA3YiAxMDA2NDQNCi0tLSBhL2h3L3ZmaW8vdHJhY2UtZXZlbnRzDQorKysgYi9ody92Zmlv
L3RyYWNlLWV2ZW50cw0KQEAgLTExOCw2ICsxMTgsNyBAQCB2ZmlvX2RldmljZV9wdXQoaW50IGZk
KSAiY2xvc2UgdmRldi0+ZmQ9JWQiDQogdmZpb19yZWdpb25fd3JpdGUoY29uc3QgY2hhciAqbmFt
ZSwgaW50IGluZGV4LCB1aW50NjRfdCBhZGRyLCB1aW50NjRfdCBkYXRhLCB1bnNpZ25lZCBzaXpl
KSAiICglczpyZWdpb24lZCsweCUiUFJJeDY0IiwgMHglIlBSSXg2NCAiLCAlZCkiDQogdmZpb19y
ZWdpb25fcmVhZChjaGFyICpuYW1lLCBpbnQgaW5kZXgsIHVpbnQ2NF90IGFkZHIsIHVuc2lnbmVk
IHNpemUsIHVpbnQ2NF90IGRhdGEpICIgKCVzOnJlZ2lvbiVkKzB4JSJQUkl4NjQiLCAlZCkgPSAw
eCUiUFJJeDY0DQogdmZpb19yZWdpb25fc2V0dXAoY29uc3QgY2hhciAqZGV2LCBpbnQgaW5kZXgs
IGNvbnN0IGNoYXIgKm5hbWUsIHVuc2lnbmVkIGxvbmcgZmxhZ3MsIHVuc2lnbmVkIGxvbmcgb2Zm
c2V0LCB1bnNpZ25lZCBsb25nIHNpemUpICJEZXZpY2UgJXMsIHJlZ2lvbiAlZCBcIiVzXCIsIGZs
YWdzOiAweCVseCwgb2Zmc2V0OiAweCVseCwgc2l6ZTogMHglbHgiDQordmZpb19yZWdpb25fZG1h
YnVmKGNvbnN0IGNoYXIgKmRldiwgaW50IGZkLCBpbnQgaW5kZXgsICBjb25zdCBjaGFyICpuYW1l
LCB1bnNpZ25lZCBsb25nIG9mZnNldCwgdW5zaWduZWQgbG9uZyBzaXplKSAiRGV2aWNlICVzLCBk
bWFidWYgZmQgJWQgcmVnaW9uICVkIFwiJXNcIiwgb2Zmc2V0OiAweCVseCwgc2l6ZTogMHglbHgi
DQogdmZpb19yZWdpb25fbW1hcF9mYXVsdChjb25zdCBjaGFyICpuYW1lLCBpbnQgaW5kZXgsIHVu
c2lnbmVkIGxvbmcgb2Zmc2V0LCB1bnNpZ25lZCBsb25nIHNpemUsIGludCBmYXVsdCkgIlJlZ2lv
biAlcyBtbWFwc1slZF0sIFsweCVseCAtIDB4JWx4XSwgZmF1bHQ6ICVkIg0KIHZmaW9fcmVnaW9u
X21tYXAoY29uc3QgY2hhciAqbmFtZSwgdW5zaWduZWQgbG9uZyBvZmZzZXQsIHVuc2lnbmVkIGxv
bmcgZW5kKSAiUmVnaW9uICVzIFsweCVseCAtIDB4JWx4XSINCiB2ZmlvX3JlZ2lvbl9leGl0KGNv
bnN0IGNoYXIgKm5hbWUsIGludCBpbmRleCkgIkRldmljZSAlcywgcmVnaW9uICVkIg0KDQoNCg==

