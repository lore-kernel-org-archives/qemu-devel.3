Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08306D29FE6
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 10:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfyF7-00027O-RC; Wed, 14 Jan 2026 05:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfyF1-00026G-4b; Wed, 14 Jan 2026 05:36:43 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfyEw-0006ql-F5; Wed, 14 Jan 2026 05:36:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=woqXv/MRbLtm3Ts+1BJ8uHlOAnmxIgYpNnOviaUyqKbDfawOAmg1lRvGSKlMQh+DgVOwxxVZ8ZyN3NwL2PLUCTPzMYBGKjHHLjRtw4MaGjY6EhnuBaWuf5if8WnhRkVAJ5aqBUMBZP29h46HmCu9upsK/fP3agSkMHK9WE/edV0GNsDVwXATxqqdDJJUEhogHxlLxmlFWkcT9kxXAraAjFetVlJcRU2oLrPY9affp19RvhxPLfxlFUvV/2i7+AizFWQzPaZuiOZBLicXAMkviDKU+yMs2AtQRJmP6JwSFdBtWXQfI0SwNMFtVEgXlk7Xg/6K3s3He1ujy8bNpukkqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yk6lU33DeEzsAxyItzZswo2GfsjHxUy0QkXC19Ek3CU=;
 b=WnoAKe+cb8sRMNVFDMWEvdSxdUtG3vDGEGyHnU5kCLzWL2YkBkE7vp3ShXvLMr/c1nn5+2bJi2Gu7/QWGkaHzuhm33EcsaWeAjJW4/8UK+pDv28/zp8+nv7tybG+0Y5CYPHBxHwe4e44FQXDNMUuNO7vRnIW3s5xMzyn7ikSgEfManEbfP4pHIiCygn1whKB+BpxFAnf2ArWWS3c3NpQUHAxQVGkf6ieVnVe3Fa+/lvgLyotxJxFTqyrtaGPoUexVDoLbXaRsT3zebhD/5ba5Myfu0LEc6BaihKgf8Es8CQhAcryfcKbDcSOtJb6J8lpnDhBovh9BJ32Bi0l90ANbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yk6lU33DeEzsAxyItzZswo2GfsjHxUy0QkXC19Ek3CU=;
 b=kzZdSq/Rw83JUQ0xIfgL1vYvOXvMRA2vx4SkE6+dxX/5Ea4AddiHh/smGq8VUCBMx0l3Go23ZTglCcqjxcxuWiW6fL9x00F8ofyboN8NtvfUnYXjs4k1zKlGb+AWEhy95AhqCNgY4KwTTJ9xWiTh6V1WgLulfspgZeLKfGl4VyXsjRIbrhNOu5RLst/9mb0IwZN2KUflx6F9OKzWGMkiVfOjrRAa3AcbB1DO6+3CkMuMSd9hEFtWAgo/wzYVJWABuzwJRdB33jovwGlkttKOEbtUdJOO9RXsOjUUFA3w59ioNvJFAg/eftCIVmZnFFUOXScmx8qrGJtorq9gqEIQTw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ2PR12MB8944.namprd12.prod.outlook.com (2603:10b6:a03:53e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 10:36:30 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 10:36:30 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>, "Michael S .
 Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH v7 33/36] hw/pci: Add helper to insert PCIe extended
 capability at a fixed offset
Thread-Topic: [PATCH v7 33/36] hw/pci: Add helper to insert PCIe extended
 capability at a fixed offset
Thread-Index: AQHchQzQWMpnqnwbYUGleR31M25t67VRdhUw
Date: Wed, 14 Jan 2026 10:36:30 +0000
Message-ID: <CH3PR12MB7548626563C6E67FB802D850AB8FA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
 <20260111195508.106943-34-skolothumtho@nvidia.com>
 <CABQgh9FwSTB8Cp8f1POSBti376ZH3B0e0mLu9FU==p1wVwquGg@mail.gmail.com>
In-Reply-To: <CABQgh9FwSTB8Cp8f1POSBti376ZH3B0e0mLu9FU==p1wVwquGg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SJ2PR12MB8944:EE_
x-ms-office365-filtering-correlation-id: d818a82c-42e1-4368-e968-08de5358c794
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?WXFHblZneGkrRFFERlEvbkhVL1ZNSEg4Q0VUeHpxdkVMNjVwMlFpWWpLTnJX?=
 =?utf-8?B?RTBXSDFlMWVtV2s4TUhLY1lUeVJ5SkhnSFVFWVlMajloK1FIczNrSUl4dVAv?=
 =?utf-8?B?S2JJVk5oUEdTbkk4M2JsOElBYUNZa3VOUWVnR0o2SVo5QU4xV2RKSTMxcjJ6?=
 =?utf-8?B?Y0dZV1VBNlFScmhnVlNJRDVYbDRxV201enlNOE1WRlV6ckRVdGtqdk8vaVFU?=
 =?utf-8?B?V2tOMStqR1ZQTE1sTndKYXBPaEwxZFFKd2RER0xIaEVoNHpxTENpR1ljNmFB?=
 =?utf-8?B?SWZkYjRtSS9IM2xoWDZkOHQ4c3hWVlJkWWxPc0Uwa29IZ1Q3SjlrR0lYbFRJ?=
 =?utf-8?B?WjcwRkxhVGNFMEZUKzZtUHBseVB5SkVqS2lHWkk1bERFRGNuUVByTjVRY243?=
 =?utf-8?B?Y25OQ0krWklxcHoxMWZRN3JLMVNRZ25KclZ3eUVMRGNMSm9YRkxyRHQwdjJt?=
 =?utf-8?B?aVF2d3FBYXR3NGJOSDhKMFZSckNCVUZQVnIrRi9jWU5OQnAvK0tsNDJTaGw4?=
 =?utf-8?B?Z0ZLeEdKeVRMYzBLMXE2OVRvTTdqaHRnU25tNStlNTJrUkhZUmFieUx6RmNk?=
 =?utf-8?B?MWFZMjkvL241ZVhjR2JGUHpTVW9aTDVUNVQ2N0VGTzIvejMzbEY2RFYza05M?=
 =?utf-8?B?V3doUXZHNXpPdE9BVUNELzFCOE5BMjcydytSRElxbmxEbEJSSkNmak1pMU5X?=
 =?utf-8?B?Znk4RkhZZlhrWGFPbGRHemFYN1lleTFRZmh3QzdGQmZFU2V0S2NqTTdHdENy?=
 =?utf-8?B?MWFmTW9ZT0NLaEFMNGNsNVoxRTZQcnRLdy80QnArQ1pNcnE1R29jd2tTU1po?=
 =?utf-8?B?WHdtZVpWNFFjcmNjUHdoSGFaTUFpeWZHcmd0Wkd5ZWhwVk0vREhhRGNITmxI?=
 =?utf-8?B?anlkL0JVQWNuU3RWSEJETWY2RWVPV1c4b2pnbHRFbUZPUSt6OGVXKzZrR2Vp?=
 =?utf-8?B?czhFUHhsQnZUM3JqOWRnWWg0UW1RRFFPV2NDaDRCMFVvOE4yRXhUOSs0Nk1K?=
 =?utf-8?B?ajVMbWdsM3dFUEhjZW1uaGhjNEhGQWN5NHBhR0Jobk5tN0JERFNwZ2JKWVd4?=
 =?utf-8?B?RlBXTGJnNVFkVTBNbTNXdENSVCtzWExhekViQUtKTmMzbTJoMkFRLzdBaHFr?=
 =?utf-8?B?ZjY2VUZhczZkeVR5dGY4OVdCd0xhMFNBTzhpUksrdFhWdjdVUjdaYVlxdlFE?=
 =?utf-8?B?QXROUm1RczhWblkzTFVOYXR5NEVpNk9GYmkvaTFJTTJzSTNCZW5taWYrTFFH?=
 =?utf-8?B?d1FhOHdNZWMzZ25Kc2NEWHlXZW02c01hNHdqRFpRSEhDQ3hjby9OUUZOWXNB?=
 =?utf-8?B?ZDY3MDI1NUVmaTJHNEozbDVYNW9SOTA1ZlR5MnVCa2RaVjhjdmlESzdtMldo?=
 =?utf-8?B?b2Y5bTlUTE1pWkJUZnp2dW5VVDVtR1ZIZVY4RUppSllhbXRiMEZCelVwRTdr?=
 =?utf-8?B?aVI5Y0pUb0FqZWVKWXhGOGQ2LzFQMEdkdGEwZnhoWEVGeUxQUVRuVzZQNTEw?=
 =?utf-8?B?QWVRaGN0VUNYWi9Gc0VZbG52elAyYmF2WFlIZTJGVTN4bXRHYzFvbGwxU3N4?=
 =?utf-8?B?Y280MlBaVllIN1IyVDl2ekZucVJjWHpGNXVjYWlZUHhTZzNWeDZLT0xwenVT?=
 =?utf-8?B?YncrQi9sQlVnOWU5RFNtSVRueTgwVDNjT2JDcnRsaW9Va0JYWCsrRGdlSTQx?=
 =?utf-8?B?QzM2bGU1eFhLclVLbHo2RDhMSGhBQzE4UVdIeFBGLzVhdVppanIvbzNoRjhK?=
 =?utf-8?B?d2NQU1l5K3ZzNmtLVXArZGY1L0xwamFtdXZBanlnTFBJT1RhVHZ0NGZNcjBK?=
 =?utf-8?B?VGV6Q3I4TzNrRHVOV0k3bmVscHZHWEpLMWFIaExKbHczRnNCUDliYW1kNDUy?=
 =?utf-8?B?a1diTkN0d3d5bUVzTWRGU3kxdWlEQlVIa0M0YnQ2c2NyWFFlR2Z6RndtNXY2?=
 =?utf-8?B?cUhXSXhZeEJLY0tjUnBlV3NkUmh1Y2s0YWZxVFdlNXhhOHhzeUYzbUxUcHQy?=
 =?utf-8?B?S3dhc2xidWxrbDQ0YTZCZGpBMm5OOVdnTElKSGlpaS8xQzh6VVN2eGI5NXhL?=
 =?utf-8?B?RVJCM3RnRG43Vm8xQVhSbkU4UzlLTFFFV3ZOblBIYXo4bmVpWWdyNmVBd0Q2?=
 =?utf-8?B?cFR2WUhEbXVVTUk2NmlKWTRBU0NlMFUxVXpZNzZEWC9KRDEvTDlMLzNMNitU?=
 =?utf-8?Q?Uj4h3kKlaocA//YxqGDpTlY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmRiS2NjQnQ2ZUMwaGprd1R6a2xmN2IxMEhsZ3FiU2dSWUlLQW9IMjhNSm9I?=
 =?utf-8?B?TXk5VVlod0poR3dSbEdaVlRTYmtpZlZiU3hrcnJkSUJycng4KzFHYnNBdGJK?=
 =?utf-8?B?RmladXBKOEVDd1FQNTBkQndzUkFiNEw5cGYvQjM5QlEzT0Y3cGdubE9ocXBa?=
 =?utf-8?B?dnZJOTNOS2RrMzJpRmFPZXdMcmg0dWtUcnRSZmxHV3hOc3gxSXV4ZUNDL25O?=
 =?utf-8?B?bk1BSFB0WVFuY0d1ZmhXaTgxcE9MRkRha0hLbU1ISHBrU0twQ1V3SHhFQkVC?=
 =?utf-8?B?RnB0em82Nm52RXJsRElVTk9BVmFsNzlRUnhldmlOZjdpKzJIVFFZR1hXZzJt?=
 =?utf-8?B?THhPMk9SSWNkalFUYitVNm50UUEyY3V1N08xTGRXUWNmNFhFVHI2eWs2dVZw?=
 =?utf-8?B?TThNUWFoWjluV3JpbzlYTlRCcDBqZG5WMTQvVzAvN0tVYmd0OUFMUGdWUkNi?=
 =?utf-8?B?Qlk5UUsvRExYb2VBWmtub0EzZ1QyMUF4Szl4TFlPa1ZHVlpiWHBiMklpQXpk?=
 =?utf-8?B?NzQyQWhiSENjWjI2VXh4ZGJobVp0dnRzcW8zcTBGZHlFWWdjU0ZJMnE2TUtk?=
 =?utf-8?B?c0FzVWJXYVcvVGNLZE9NL0RTbnQ1S1BrUm9IK2VuazVsZ3oyRHlmYUpub3hn?=
 =?utf-8?B?V0NBZ0lNMUhKQ2JaRkZVc1RHK1h3TkpwNVBBZ2VxVHN5SjlMWEg0dTNFRmZY?=
 =?utf-8?B?YjkvMTJiUlZDcmRyT09CNWQ2cUduSGZIeXJ6dHR0K09GdFBmY1V0MmVRbUd0?=
 =?utf-8?B?UHFyQ1poK1Z0Q2htSDlDVGtMbE80RkFkVjhXbS9qNE9RVENhSUx2eDV5VFdJ?=
 =?utf-8?B?dVIxUWhtaUZmY3V0bkFqWkUzdFBydjRzbVcvRkdPSG9NV210emtGZzRSTnVu?=
 =?utf-8?B?MTYrQkpPbHBqQUR5SWdiRmNmWEtGVFhyeE1wY0xmYWNpbk9XVjhsODJsa1RH?=
 =?utf-8?B?YnhCZ3NWTHRxQ0lqTU1QUVR4c29JMFpzOWZJRmgvbXhGZXB3d2dGejNSLzBG?=
 =?utf-8?B?bWIwUlJaQnZ4dVd4aENPRUh3UzJRM09lWklvaHNraXFBK2dES1R4ZThYSFdU?=
 =?utf-8?B?RWwrVFVlL1VWMnVBTi8rVFRsWFJ6ZjNUbW1OYlAvSE9GUDlyL1licHRqei9t?=
 =?utf-8?B?OFZsMWNJWlRDYjlpcWdLdTczeXd5MDRKYWEwTTBHZXdpRWdXQTRmUlk2d3c0?=
 =?utf-8?B?QmVnQTNycU5kOXp0U2MrN2xMT3ErbitHR1h6dll0Z0kvVlZkdTFXMkIwT3NU?=
 =?utf-8?B?UDlyWk1WeXBqL3dGdEFEYUxiS0M2VzNweFpZTDNYcVFObE5MQ0ZZL3N4NzBv?=
 =?utf-8?B?OWY0TkR5SWwvOHJLMkpsNEpva1EvNXdXNVF5T0dTcFdLaWZIa01zQXQzUzhI?=
 =?utf-8?B?Unh5azVjSG1SMjQrSXhHQjU3REhESmxYbWQvOU5EOHRTTWtjZmVpTElMS21U?=
 =?utf-8?B?M2dXTVp0MVJWaVhmdndSamsvaXczNEY3U2NNZ2xmQlV5N1drUExYWFlzQjll?=
 =?utf-8?B?K2JFdE5mN1djUTBER0h3ampseHdYWW1rMDJ1YlpwOFgzOFJTWW05L3NEK2xM?=
 =?utf-8?B?blpJT3RCdWZPM2tvOVFmdXRxMmZ4QVRVb0VZVVpCSnI3VWQreVkzUkR6bUdv?=
 =?utf-8?B?eDhmR21zQk5SNURlcytzSjNwNFJsNDFyWnc1MUlMU3pOc3RmeUdZdzRKRzJ2?=
 =?utf-8?B?U1o4RHZSNHBDUzA5VVFic093Q2dPZElGT3FGOG1FdTJGQmJsdlBvMEFmUEdE?=
 =?utf-8?B?NXhLMnNJSys2UFZvMm9DUEljZVRPeVUrd2xwclJtMFRWVVQ5L05VQ0t0YnIw?=
 =?utf-8?B?MmNxM0NXcXpmOUhTWitxQVA4ODJSeUpJNkJ3MTVTK0ZXcjlEbkF3WmJGa3dQ?=
 =?utf-8?B?U2hWSnRwcjYyVDVWalN4TGpraHBlT0Uzc2NqbHZ6bzRCQ3htRzFOamYyVmJL?=
 =?utf-8?B?YldJd09DVm9hbkVuRUZMcFN6TSs1bVF1V1U4eHhVSjJPYUZNZVZYcmVMQ0F1?=
 =?utf-8?B?YUNsYUdSdFhDeVZCSnRMWjkzZTh4WmFsRnN6NVJGaTA2dDlqdWFsUFVmZVpW?=
 =?utf-8?B?Z3pvbHJ1V3NvMzRUbE96WTk0TlN1Tk9yMkVpbUtaQ3ZBQXRSWGxOanh1ZnZK?=
 =?utf-8?B?UUlKdXNkRi9sa1d5MTJBSndRRjVlZmpjcitWeHhuN1UrK2w3aXdPUW1mYzZz?=
 =?utf-8?B?SjgrTVpVUy95R2ViZE9pcWQyM1F0MklpY0lESjlYTEdYcENXdytFTS80S3VX?=
 =?utf-8?B?bS9vb0oxSVdEY0xrRXBoQzEzK255cEFUMmtFdk1wRHE4T1o4YTlFSk5hTC9J?=
 =?utf-8?B?ZCs1ZGthemNMS2Uyenlhck9wbEtiZlFoWVUrMnVrWHcrVXNzbHpqUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d818a82c-42e1-4368-e968-08de5358c794
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 10:36:30.3313 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zRrEa+3rCDavwly+vQ5Iny2sCvgY2cu0Rcq+LUCt2298uhjGtA4IU2gij2KEAdZX8DnGi/zLZg2HToJcHPKP+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8944
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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

SGkgWmhhbmdmZWksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmhh
bmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZz4NCj4gU2VudDogMTQgSmFudWFyeSAy
MDI2IDA0OjE4DQo+IFRvOiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNv
bT4NCj4gQ2M6IHFlbXUtYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4g
ZXJpYy5hdWdlckByZWRoYXQuY29tOyBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IEphc29uIEd1
bnRob3JwZQ0KPiA8amdnQG52aWRpYS5jb20+OyBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRp
YS5jb20+OyBkZHV0aWxlQHJlZGhhdC5jb207DQo+IGJlcnJhbmdlQHJlZGhhdC5jb207IGNsZ0By
ZWRoYXQuY29tOyBhbGV4QHNoYXpib3Qub3JnOyBOYXRoYW4gQ2hlbg0KPiA8bmF0aGFuY0Budmlk
aWEuY29tPjsgTWF0dCBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsNCj4gc21vc3RhZmFAZ29vZ2xl
LmNvbTsgd2FuZ3pob3UxQGhpc2lsaWNvbi5jb207DQo+IGppYW5na3Vua3VuQGh1YXdlaS5jb207
IGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhlbnpob25nLmR1YW5AaW50ZWwuY29t
OyB5aS5sLmxpdUBpbnRlbC5jb207IEtyaXNobmFrYW50IEphanUNCj4gPGtqYWp1QG52aWRpYS5j
b20+OyBNaWNoYWVsIFMgLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2NyAzMy8zNl0gaHcvcGNpOiBBZGQgaGVscGVyIHRvIGluc2VydCBQQ0llIGV4dGVu
ZGVkDQo+IGNhcGFiaWxpdHkgYXQgYSBmaXhlZCBvZmZzZXQNCj4gDQo+IEV4dGVybmFsIGVtYWls
OiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gSGks
IFNoYW1lZXINCj4gDQo+IE9uIE1vbiwgMTIgSmFuIDIwMjYgYXQgMDM6NTgsIFNoYW1lZXIgS29s
b3RodW0NCj4gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFkZCBw
Y2llX2luc2VydF9jYXBhYmlsaXR5KCksIGEgaGVscGVyIHRvIGluc2VydCBhIFBDSWUgZXh0ZW5k
ZWQNCj4gPiBjYXBhYmlsaXR5IGludG8gYW4gZXhpc3RpbmcgZXh0ZW5kZWQgY2FwYWJpbGl0eSBs
aXN0IGF0IGENCj4gPiBjYWxsZXItc3BlY2lmaWVkIG9mZnNldC4NCj4gPg0KPiA+IFVubGlrZSBw
Y2llX2FkZF9jYXBhYmlsaXR5KCksIHdoaWNoIGFsd2F5cyBhcHBlbmRzIGEgY2FwYWJpbGl0eSB0
byB0aGUNCj4gPiBlbmQgb2YgdGhlIGxpc3QsIHRoaXMgaGVscGVyIHByZXNlcnZlcyB0aGUgZXhp
c3RpbmcgbGlzdCBvcmRlcmluZw0KPiA+IHdoaWxlIGFsbG93aW5nIGluc2VydGlvbiBhdCBhbiBh
cmJpdHJhcnkgb2Zmc2V0Lg0KPiA+DQo+ID4gVGhlIGhlbHBlciBvbmx5IHZhbGlkYXRlcyB0aGF0
IHRoZSBpbnNlcnRpb24gZG9lcyBub3Qgb3ZlcndyaXRlIGFuDQo+ID4gZXhpc3RpbmcgUENJZSBl
eHRlbmRlZCBjYXBhYmlsaXR5IGhlYWRlciwgc2luY2UgY29ycnVwdGluZyBhIGhlYWRlcg0KPiA+
IHdvdWxkIGJyZWFrIHRoZSBleHRlbmRlZCBjYXBhYmlsaXR5IGxpbmtlZCBsaXN0LiBWYWxpZGF0
aW9uIG9mDQo+ID4gb3ZlcmxhcHMgd2l0aCBvdGhlciBjb25maWd1cmF0aW9uIHNwYWNlIHJlZ2lz
dGVycyBvcg0KPiA+IGNhcGFiaWxpdHktc3BlY2lmaWMgcmVnaXN0ZXIgYmxvY2tzIGlzIGxlZnQg
dG8gdGhlIGNhbGxlci4NCj4gPg0KPiA+IENjOiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRo
YXQuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRo
b0BudmlkaWEuY29tPg0KPiANCj4gVGhlIGd1ZXN0IGtlcm5lbCBmYWlscyB0byBib290IHdpdGgg
cGFyYSAic3NpZHNpemU9MTYiIHdpdGggdjcgc2VyaWVzLg0KPiBXaXRob3V0IHNzaWRzaXplLCBn
dWVzdCBrZXJuZWwgY2FuIGJvb3Qgbm8gcHJvYmxlbS4NCg0KVGhhbmtzIGZvciBnaXZpbmcgdGhp
cyBhIHNwaW4uIA0KDQo+IEhvd2V2ZXIsIHBhc2lkIGZlYXR1cmUgcmVxdWlyZXMgc3NpZHNpemUu
DQo+IHNtbXV2M19hY2NlbF9nZXRfdmlvbW11X2ZsYWdzDQo+IGlmIChzLT5zc2lkc2l6ZSkgew0K
PiBmbGFncyB8PSBWSU9NTVVfRkxBR19QQVNJRF9TVVBQT1JURUQ7DQo+IA0KPiB2NiBkb2VzIG5v
dCBoYXMgc3VjaCBpc3N1ZSwgYW5kIGRvZXMgbm90IHJlcXVpcmVzIHNzaWRzaXplIHBhcmFtLg0K
DQpBcyBtZW50aW9uZWQgaW4gY292ZXIgbGV0dGVyIHRoaXMgc2VyaWVzIGhhcyBjaGFuZ2VkIHRo
ZSB3YXkgdGhlIG92ZXJhbGwgDQpQQVNJRCBpcyBlbmFibGVkLiBJdCBub3cgYWxsb3dzIHVzZXIg
dG8gc3BlY2lmeSBhbiBvZmZzZXQgdG8gcGxhY2UgdGhlDQpQQVNJRCBDQVAgZm9yIHZmaW8tcGNp
IGRldmljZXMsDQoNCi1kZXZpY2UgdmZpby1wY2ksaG9zdD0wMDE4OjA2OjAwLjAsLi4seC12cGFz
aWQtY2FwLW9mZnNldD14eHgNCg0KSWYgbm9uZSBpcyBzcGVjaWZpZWQgaXQgd2lsbCBwbGFjZSBp
dCBhdCB0aGUgbGFzdCBvZmZzZXQgYXMgZGVmYXVsdC4NCg0KQW5kIHlvdSBuZWVkICJzc2lkc2l6
ZSIgdG8gc3BlY2lmeSB0aGUgU01NVXYzIHN1YiBzdHJlYW0gSWQgYml0cy4NCiANCj4gbG9nOg0K
PiBBU1NFUlRfRUZJX0VSUk9SIChTdGF0dXMgPSBJbnZhbGlkIFBhcmFtZXRlcikgQVNTRVJUIFtQ
Y2lCdXNEeGVdDQo+IC9ob21lL2xpbmFyby93b3JrL2VkazIvTWRlTW9kdWxlUGtnL0J1cy9QY2kv
UGNpQnVzRHhlL1BjaUxpYi5jKDYyNik6DQo+ICEoKChJTlROKShSRVRVUk5fU1RBVFVTKShTdGF0
dXMpKSA8IDApDQoNCkl0IGNvdWxkIGJlIHRoYXQgdGhlIHBjaWVfaW5zZXJ0X2NhcGFiaWxpdHko
KSBoZWxwZXIgYWRkZWQgaGVyZSBpcyBjb3JydXB0aW5nDQp0aGUgY29uZmlnIHNwYWNlLiBMb29r
aW5nIGF0IGl0IGFnYWluLCBJIGNhbiBzZWUgdGhhdCBpdCBpcyBub3QgaGFuZGxpbmcgYSBmZXcN
CmNvcm5lciBjYXNlcy4gIENvdWxkIHlvdSBwbGVhc2UgcmVwbGFjZSB0aGUgcGNpZV9pbnNlcnRf
Y2FwYWJpbGl0eSgpIHdpdGgNCnRoZSBiZWxvdyBhbmQgcmV0ZXN0LiANCg0KVGhhbmtzLA0KU2hh
bWVlcg0KDQouLi4NCg0KYm9vbCBwY2llX2luc2VydF9jYXBhYmlsaXR5KFBDSURldmljZSAqZGV2
LCB1aW50MTZfdCBjYXBfaWQsIHVpbnQ4X3QgY2FwX3ZlciwNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1aW50MTZfdCBvZmZzZXQsIHVpbnQxNl90IHNpemUpDQp7DQogICAgdWludDE2X3Qg
cG9zID0gUENJX0NPTkZJR19TUEFDRV9TSVpFLCBwcmV2ID0gMDsNCiAgICB1aW50MzJfdCBoZWFk
ZXI7DQoNCiAgICBhc3NlcnQob2Zmc2V0ID49IFBDSV9DT05GSUdfU1BBQ0VfU0laRSk7DQogICAg
YXNzZXJ0KG9mZnNldCA8ICh1aW50MTZfdCkob2Zmc2V0ICsgc2l6ZSkpOw0KICAgIGFzc2VydCgo
dWludDE2X3QpKG9mZnNldCArIHNpemUpIDw9IFBDSUVfQ09ORklHX1NQQUNFX1NJWkUpOw0KICAg
IGFzc2VydChzaXplID49IDgpOw0KICAgIGFzc2VydChwY2lfaXNfZXhwcmVzcyhkZXYpKTsNCg0K
ICAgIGhlYWRlciA9IHBjaV9nZXRfbG9uZyhkZXYtPmNvbmZpZyArIHBvcyk7DQogICAgaWYgKCFo
ZWFkZXIpIHsNCiAgICAgICAgLyogTm8gZXh0ZW5kZWQgY2FwYWJpbGl0eSwgY2hlY2sgcmVxdWVz
dGVkIG9mZnNldCBpcyBhdCBQQ0lfQ09ORklHX1NQQUNFX1NJWkUqLw0KICAgICAgICBpZiAob2Zm
c2V0ICE9IHBvcykgew0KICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KICAgICAgICB9DQogICAg
ICAgIHBjaV9zZXRfbG9uZyhkZXYtPmNvbmZpZyArIHBvcywgUENJX0VYVF9DQVAoY2FwX2lkLCBj
YXBfdmVyLCAwKSk7DQogICAgICAgIGdvdG8gb3V0Ow0KICAgIH0NCg0KICAgIHdoaWxlIChoZWFk
ZXIgJiYgcG9zICYmIG9mZnNldCA+PSBwb3MpIHsNCiAgICAgICAgdWludDE2X3QgbmV4dCA9IFBD
SV9FWFRfQ0FQX05FWFQoaGVhZGVyKTsNCg0KICAgICAgICAvKiBSZWplY3QgaW5zZXJ0aW9uIGlu
c2lkZSBhbiBleGlzdGluZyBFQ0FQIGhlYWRlciAoNCBieXRlcykgKi8NCiAgICAgICAgaWYgKG9m
ZnNldCA8IHBvcyArIFBDSV9FWFRfQ0FQX0FMSUdOKSB7DQogICAgICAgICAgICByZXR1cm4gZmFs
c2U7DQogICAgICAgIH0NCg0KICAgICAgICBwcmV2ID0gcG9zOw0KICAgICAgICBwb3MgPSBuZXh0
Ow0KICAgICAgICBoZWFkZXIgPSBwb3MgPyBwY2lfZ2V0X2xvbmcoZGV2LT5jb25maWcgKyBwb3Mp
IDogMDsNCiAgICB9DQoNCiAgICBwY2lfc2V0X2xvbmcoZGV2LT5jb25maWcgKyBvZmZzZXQsIFBD
SV9FWFRfQ0FQKGNhcF9pZCwgY2FwX3ZlciwgcG9zKSk7DQogICAgaWYgKHByZXYpIHsNCiAgICAg
ICAgcGNpZV9leHRfY2FwX3NldF9uZXh0KGRldiwgcHJldiwgb2Zmc2V0KTsNCiAgICB9DQoNCm91
dDoNCiAgICAvKiBNYWtlIGNhcGFiaWxpdHkgcmVhZC1vbmx5IGJ5IGRlZmF1bHQgKi8NCiAgICBt
ZW1zZXQoZGV2LT53bWFzayArIG9mZnNldCwgMCwgc2l6ZSk7DQogICAgbWVtc2V0KGRldi0+dzFj
bWFzayArIG9mZnNldCwgMCwgc2l6ZSk7DQogICAgLyogQ2hlY2sgY2FwYWJpbGl0eSBieSBkZWZh
dWx0ICovDQogICAgbWVtc2V0KGRldi0+Y21hc2sgKyBvZmZzZXQsIDB4RkYsIHNpemUpOw0KICAg
IHJldHVybiB0cnVlOw0KfQ0K

