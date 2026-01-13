Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DD1D29DE0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 08:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfZOS-0003Y5-K6; Tue, 13 Jan 2026 03:04:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfZOR-0003Ww-6N; Tue, 13 Jan 2026 03:04:47 -0500
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfZOP-0002pW-4B; Tue, 13 Jan 2026 03:04:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFsbca5wyfE7Q5iIneT2dsRPbbbH/942TJt3Gcl+ByQVVErLrz0ZAnUbEXy6fS1RWGXoL0opNA7v+g0h0K6e7ENSrUUmES22NTilwfFFyBxBt9XKNtuh3n1MyjjZg36TI1dQIsImHCp8D+TsuKchyOaBjWdD6dNMDmUw2CbVA0NuyJmvRjHSLdERh02fRn6G/j9pU7UopsmBvAgCHRbxdfPBXqjlSI3ZE0+w9FMGcKDKsGgg1sDV/co3rypOTdYZQnk0jvja4j+BEu8R9tybCrrP4jm/WEvBewQrKTVyGExrHQRxlaXnZBG34CrypBKCW4fZRSQp/Kj6kXOk9Niw2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ju+Pq+L/pJOggRdP812e6Y4aqEUAoz7WWV7h1sA+yY=;
 b=M2vH+EKfLajGhTFftS5r7qihzstNT1MoPnY9QVjBKQY4UaaaQqePN1d86bqEpI3F69ByybREIvmq7RW6a+3J6QtfB8/rk2/KVUP1lLtbGlz+BsZl0H+19I9K1qDXESW4WJR8c4qext3FJiqNPXiCbbAx6MYnoridPLaAvwwEGTnKuWl95ygidygxxabAg65FBRdyEDLD0kfPsVlmceZj/DtaqI6AtgJooYL2xLFLM4iq0U7gRCXghwT0KLc8RKbrukpCAUuN3jofKW5cTGy9JtQeLoi5775/EwWc6YOG+siA8Gk1IQpjgXqd6FpqEFUJvVjhCjpefIk70H/edrra6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ju+Pq+L/pJOggRdP812e6Y4aqEUAoz7WWV7h1sA+yY=;
 b=nTsU/Bh6DTPVe/2bmaIb2Ahv+GU6+AIEVNTiasCnSnp7Ml8Z/ZF8tdsb4j7pJ42wijyUAsv/dN2lXEcbyeCgqn4dkvgtkh8bR4STdWQ/BvGoPIGSg8b2WXsR1b5dWpNM4CANejROK9T72rWLxpTNjPfuXPzL2sT3tkeonVHcTgmtMYPo4efpiO8p2bCZJQx7dlJsJ1dwF2LHRdEsFek0IliXMFu8YgWrGBhOD1GixhbEeUOD0FNdhsJ4tjzKjkCu95kVbSmNNiYzCFUsHEnuHu+OlnDZcgZiQx0ZOXdVby4FeeEbYSFJTQ6PfYbGb0cETNSd5zYC5eST1wDeVOfCTQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 08:04:41 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 08:04:41 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, "Duan, Zhenzhong"
 <zhenzhong.duan@intel.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "alex@shazbot.org"
 <alex@shazbot.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
Thread-Topic: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
Thread-Index: AQHcc0r/PShlE7i9HkafE8JAYPcnrrVIH1QAgAAPWOCAAf8BgIAEp0AAgAAn3ICAAN+TAA==
Date: Tue, 13 Jan 2026 08:04:41 +0000
Message-ID: <CH3PR12MB7548437FEF80853F821AB0C5AB8EA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251222135357.143339-1-skolothumtho@nvidia.com>
 <20251222135357.143339-4-skolothumtho@nvidia.com>
 <d043f6e1-8fa4-4215-95ed-7570ae002e11@intel.com>
 <CH3PR12MB75485C401917E76FF22E0122AB85A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <d40cc8da-4003-4a40-b0de-32c79cbe6faa@redhat.com>
 <CH3PR12MB75482D2914436617438F2522AB81A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <cdc371ba-d347-44f9-ab38-1f60f8f88ad6@redhat.com>
In-Reply-To: <cdc371ba-d347-44f9-ab38-1f60f8f88ad6@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|LV9PR12MB9829:EE_
x-ms-office365-filtering-correlation-id: bd3ef8c1-4ba8-4f94-acb4-08de527a67a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?QmhZcmVibW9vcWlmMVJ4Rlc0MUNCNGVNSytXSmpnVTFoL0lpL2kwRXNKWm0r?=
 =?utf-8?B?OWVzQ1FrQU9LUExjVVJMTmNKQ1BCV1lSMmRtYTVqdFNYYUVzdXJ6WnFBUkp1?=
 =?utf-8?B?NE92NzVFOWM2MWlyN2pMbks3VmFQZHJ1MDQ5WDYzdVlucU0yQUttanYrbENE?=
 =?utf-8?B?Z2sxMkZ4OHVwd1NmQVRkRk9rL1pzMjQ2b0JZaTRrNS8xQ3RDTjI3UlQxZXJs?=
 =?utf-8?B?ZVptbGJPV0E0RFNhdFN2NGExeXhlT1V3NFJUNlpvRjZlNDhDM1R6ajNwQVB2?=
 =?utf-8?B?dnR0UFVwd1hhRW9OWG9LRmJrNDV1dy85NzFGSFQ4cmFFTTlQVU0wcnp6a2Fw?=
 =?utf-8?B?V1pzRXk3ZnFNMFE1MDl2MXU0cXQzbzZkb0hoaVlJSVNReUsreVZoUTZlUXhM?=
 =?utf-8?B?OGJ3dGJOc00rangwNlppMUlFdEFpZzFyMlB6MlNpTlZUVmNrOTFTTGQxb0Vn?=
 =?utf-8?B?dXNTTmptSitscmNxUTc2UjVZTjJWVDZuczJ0QktMSWJsOXNrZ0ZVZk1RUldT?=
 =?utf-8?B?Q2NtK21KNCtKK2dqWDA0QjF3Q3ZBZFdhUitybFZ1U3JqQmhTWitVSTZXak9C?=
 =?utf-8?B?SElXVUhGNWVWeldvRHJJRVgvbC9ZeDRUaUlHUDRjMzYycXRCWUxIVG5vL1FZ?=
 =?utf-8?B?emhkSUlBSmJoUjc1RHVLazBnWUVrbHkzcXRUUmVsSy9Ha1ZXTDRkTGkrR2xI?=
 =?utf-8?B?amp0eDBreXQ5cHNkcE5XK1dnWTNxanB0V3poU0tlcCtlWFdWWnRLVWhFcFhi?=
 =?utf-8?B?R0VDcW5GRXl4RW0zYUl4aGMrSVR2SWRLcnR0MXhNZGxTZXFmeDZienVXMVpM?=
 =?utf-8?B?bGM3Rmp2c3RGaVhRNXBnV1dmcXFQNVpTcnZIdWlpTWdSSVJWZTNnVDN1dDZC?=
 =?utf-8?B?UEZtL3dKaGYwNExUek5kVHlEVHZQZHdLRGk4VGsreC80YUlvU3lSSVA3aXpT?=
 =?utf-8?B?WnFCNk94Rk1uQ1VvbDk0b0wxOEViK3B1VWFMeGxsUTIrWXgzWnpOOStwQzVj?=
 =?utf-8?B?QzlZZ3FORWh2ZDE2cVhEU0UvMGhIRkc0Z1NPYVVya0NtbnBoQ09palgzc2VE?=
 =?utf-8?B?dDNiYVdlOEt1SHpxcTFlY1BTWllpd3FvMmdqR09lWW5lMzgrditraC9Jb1pr?=
 =?utf-8?B?VVM4Z1dWYW0zS0hyY1BlUmRwZmY3SjJya09ndmJzNDVCMlVPdXhzTzBEOVY5?=
 =?utf-8?B?RkdwOFg1dEdCU3FaNG4zLzNLbWxFTVFqTTM4bDdib2N1cENXRHIwelhhck9V?=
 =?utf-8?B?SWRUUFJJVWpaU1ZzY2J2ZnVjY08xRllZYUVWR3N4Tm9NY2IyeEZ2TExETFh2?=
 =?utf-8?B?YTRMenA1dkxGM1psLzErWHVnSE8xQlVEUVRzdlJZQlZueWFzVWZpc00yMW1w?=
 =?utf-8?B?dVBwNy84ejZzNXRDcWVycTM0SFlPUnZ4cXRsVHJkR09vZS9yN2pEdDZXSTFY?=
 =?utf-8?B?c29nU05Mb3JLTi9JQ1FoVWkxUEZ4Q1l6T21hRm1JQkdmRm1iQmYrNW5zczNZ?=
 =?utf-8?B?SlJ0TXliSXBuM3pQYURnZm5Ldi90bHA0OHpRd2hnSHAyZjFCUjBQQ0lzekJB?=
 =?utf-8?B?S3lKSXpEWlZ2Q1JIQjhCOW40Q0R0VUViRC8zd01zRTBqUWR2aVdyMjRzMU45?=
 =?utf-8?B?LzlrdTAxNHkyQ0JMQlVYR2xVdWpnL2E1TGtiTTc4NmRVaTNaN0R6MWJmVzg2?=
 =?utf-8?B?Y3NCN2dJR1I0Mm1TV2J3Z0paU1FtUjRvUUZJUFYzd21wREdaREhwUHhLWUtY?=
 =?utf-8?B?RHpkYllVeTFyeWU5V1RucFVlNFZ3S0xDajgybXUxY2hlbEJkdzBEdjZ3QmVF?=
 =?utf-8?B?ZFJNMENIdmxlQmNaY1E1UHhYN0Fxb0RXREEzdkdEdGxnWXRlRm02V1BvUmNY?=
 =?utf-8?B?UXJ0elhaREg4L0lNK1lqYWlTSTNFcXhZazZ1dWNhb0ljZXk1UlFFTEg4NHkz?=
 =?utf-8?B?VWg4dmt1a2JOUFVleStmSHZMQUFCWFJDVldITEpmdzdyUUNaUHQ3a2p5ZElq?=
 =?utf-8?B?eUFiK0huVGE3ZWliWml1NjZQMU1BMmVoU1hBeEZvU3lEckFrUE8vVmQ3bkl3?=
 =?utf-8?Q?tnZlXL?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUlnbTFsOTZQNWZkYkxEWURCZXVKQUlqVEZHK2NrOVQrdEI0QVNhWWhWSnFj?=
 =?utf-8?B?WXUwSGYzQ0hiMWx5bC80WVRZRCtwMURRcW9HRG5NT2VXcE5tZ1ZGNWNDcE9N?=
 =?utf-8?B?UEgvbGR0YnNEYlFvenNoWnd0ZU5DekxtMEZFdjkrYXBwWWp1VDl5d3ZCMTQ5?=
 =?utf-8?B?VDg3NThhL3IvSDJObmJ0S2Q2K2lMN3ZrL1BDaVc4OGk4RVpnZk53enBQbjRM?=
 =?utf-8?B?a2RSU0ladHJaL3lCejJISTdHNjJmeFBkaURJL25DL2cwUEFiSXdBamhabFpm?=
 =?utf-8?B?SCtaWUhzV2taSFkzRVdWNDk2d3J5Z3AzUFdYZlM5REgranowMU5ibUw0QVVo?=
 =?utf-8?B?eVpUSEMya29zOE9FbTdSQUxROWRSVGFUMUg0TEtWUHZrK2FPa0JHSEE3anZJ?=
 =?utf-8?B?SVRETnhUZkhXVy9SSlhNUVh1dUhCaytabXVKYXpORmZFNXNNM3RxU3FIa3Fv?=
 =?utf-8?B?ZklYZEM2Y0tGbDAvZTRZT0hRcCtBTVhuRFVRRWUzK0R2UUh0aDB3TzZuTElZ?=
 =?utf-8?B?M085MnI5MUJVNFgwMDk3WXBPZklha0lzdlVmbkZ4bXdaakpGQ0JldEdOVVRL?=
 =?utf-8?B?YklyeUV4U2xMVzROaWI3MmFENEtEa2twWEF1anRYWXRhTGUwZjFwdHlNWWZq?=
 =?utf-8?B?Rk1oUzQyMndTZ0RYeGl5MXpxQU9UR0JQZCtWeHdjSnVnUkZkM0NDQTFld2sw?=
 =?utf-8?B?VkpnU0hpQy9idTZkeEVnUU1uc2VudElud0lhcHE5cENkVTZud29BNWh1VC9n?=
 =?utf-8?B?UmdaUzAwcEFQdnVyWklFZVIwVUQ3QnJrQlphSHd3aktuZ2c2Nk9TYngxY1ZL?=
 =?utf-8?B?RlIydjlVaVNZcUZHVFJBbDhRa0l6WmpvbFk0UFFpdFQrZlhSdytNN2I0bXFZ?=
 =?utf-8?B?bGVWWVRCakJyUkhFU1BSZHJlZm5EL2xicXVGRlZZNTRaM2tRSXNWNzY2Y0pD?=
 =?utf-8?B?cG1ZWVg1Njh1WkZIcHlSYThrcmovcXF4SDBmazRFWVhNWW9FMmxtWWFUQnlJ?=
 =?utf-8?B?ZitYZWdKQm5aRUZ4QThQRFNIUWtTcEl1QUdCcTdsK2VkdXRGSUk1bHAxc3VN?=
 =?utf-8?B?M2s4VWltNTJzZ3BJY0dNVFppVXc3MXFxN000L1BZRnFNSDA3Tjd3ckgvUEFJ?=
 =?utf-8?B?TnlKMkVqY0pkb1g1YU1TclpKUVFhc3U1OENhb3lDZVljc1N5RGdzZFVxcXhn?=
 =?utf-8?B?U01xdFVrOFpFZ3VSRVZWbjZkUGYwSzBoaXpDMkZMQ3hRVHpYOUR4NmtzK3RJ?=
 =?utf-8?B?SDBlUGJUZmlCb0h4eTJvNktoMytHT2dRNFVVMEE3KzZyaGwza3FnOG54YVFp?=
 =?utf-8?B?MW9qSjFIajZ3MEV4NnIxNEc3S3B1NFZGZ3N6cmZ2NGVuQWdXVjR2c0RkNFdv?=
 =?utf-8?B?akw3MFg0amFkSXJSWGI2RE44Ty9nTlQwTCs5bVRhTlZyYitKclI0RDlzeURU?=
 =?utf-8?B?eGd4c2VTN2JZNnFGbVBkM2d3YmxoWWVRTEJkSmJzTFBOckNtNXhhV2x2K3NU?=
 =?utf-8?B?SzVFczFXcGJVQmdGTktJRmp5T09YQXdzWXF3alNacUZFVTRNK0E3elBhVXNa?=
 =?utf-8?B?RnNjRnV6OGlqVFlxaDR6THFUYzNDMzhWOFZJMFh3QTZZUFFFY20wc0ZQSGpG?=
 =?utf-8?B?Skh4RTRqTjBLZDJNajZIbndHeHFTeXRPM1FEVGI5VHJyeEpuWjQ0QWhWQ3F3?=
 =?utf-8?B?YWJrMm0wRDYrTm1sK1o2bG1tNUtmd280dTQ4VFovV3RSK2MxaDhxSVo0YXdO?=
 =?utf-8?B?c0dWdFRLQnlCTGNLTTFzV3A2dUltVi95YnlmTDJQT2NYdExxYkhLZm94SlFB?=
 =?utf-8?B?ci92ZXc5U0tjSkhBdjFITDNCSVo3VFNCZmk1NFQ3NUxDVTJ5d3VBVUJZd1NY?=
 =?utf-8?B?a0NONzNJWExwVVdjUldFdVZNQ0hpQlpSenFsOUtubmFTdHhhME1IQTBnUUZW?=
 =?utf-8?B?aG56NkgwSHoycytXUXNsSlhyM1FjQU5KbkFWZEJpK2FOWUUyeEZRUjlETHk1?=
 =?utf-8?B?MEJGUFpPVTNNWFNiVkJQdnJ1MjdHOW9xVCtCVW1vYzdIZU9NNm9Rajd3Ulh6?=
 =?utf-8?B?N0kxS1RZclpBR0t4WmZZZWlncG51NU0wTmpoZEhlV3VCbEhFVU1za3k5dTBX?=
 =?utf-8?B?MnRiaDl4ZElvTzdsbEUwUW1tYVQrZFZUVUIrejBtZ2JJUnVxTkR6U0ZzTEQ1?=
 =?utf-8?B?S1FLeUg5R3lYS1EvV1NVSlRxOEx6bTN4WkpqUDZvZ1pVbUdHU05qZnZqYy9o?=
 =?utf-8?B?QktFVS8zNGU3WXE5RHZ6MVhHL0NoNHZnWmxQdlNxOWRDTkNmM2tEQlJmdlNX?=
 =?utf-8?B?YWRIZDM3NldLNG9QYU1WbkxVMHFJendhUjNXTndDQlB5VkpVS3BRUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3ef8c1-4ba8-4f94-acb4-08de527a67a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 08:04:41.1256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DTR+pQe5+rNpV5NQtoMlCAgk4H9TcV3YPJZTJn+B32fD9cC1bVSnhoC0thoa57X6FzZRE8Q1HrS6cJYFBYIdpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9829
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
ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiBTZW50OiAxMiBKYW51YXJ5IDIwMjYgMTg6MzINCj4gVG86
IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsgRHVhbiwgWmhlbnpo
b25nDQo+IDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+OyBxZW11LWFybUBub25nbnUub3JnOyBx
ZW11LQ0KPiBkZXZlbEBub25nbnUub3JnDQo+IENjOiBlcmljLmF1Z2VyQHJlZGhhdC5jb207IGFs
ZXhAc2hhemJvdC5vcmc7IGNvaHVja0ByZWRoYXQuY29tOw0KPiBtc3RAcmVkaGF0LmNvbTsgTmlj
b2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsgTmF0aGFuIENoZW4NCj4gPG5hdGhhbmNA
bnZpZGlhLmNvbT47IE1hdHQgT2NocyA8bW9jaHNAbnZpZGlhLmNvbT47IEphc29uIEd1bnRob3Jw
ZQ0KPiA8amdnQG52aWRpYS5jb20+OyBLcmlzaG5ha2FudCBKYWp1IDxramFqdUBudmlkaWEuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDMvM10gaHcvdmZpby9yZWdpb246IENyZWF0ZSBkbWFi
dWYgZm9yIFBDSSBCQVIgcGVyDQo+IHJlZ2lvbg0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBj
YXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBPbiAxLzEyLzI2
IDE3OjE2LCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+IEhpIEPDqWRyaWMsDQo+ID4NCj4g
Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0
ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiA+PiBTZW50OiAwOSBKYW51YXJ5IDIwMjYgMTc6MDUNCj4g
Pj4gVG86IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsgRHVhbiwg
Wmhlbnpob25nDQo+ID4+IDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+OyBxZW11LWFybUBub25n
bnUub3JnOyBxZW11LQ0KPiA+PiBkZXZlbEBub25nbnUub3JnDQo+ID4+IENjOiBlcmljLmF1Z2Vy
QHJlZGhhdC5jb207IGFsZXhAc2hhemJvdC5vcmc7IGNvaHVja0ByZWRoYXQuY29tOw0KPiA+PiBt
c3RAcmVkaGF0LmNvbTsgTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsgTmF0aGFu
IENoZW4NCj4gPj4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQgT2NocyA8bW9jaHNAbnZpZGlh
LmNvbT47IEphc29uDQo+IEd1bnRob3JwZQ0KPiA+PiA8amdnQG52aWRpYS5jb20+OyBLcmlzaG5h
a2FudCBKYWp1IDxramFqdUBudmlkaWEuY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIDMv
M10gaHcvdmZpby9yZWdpb246IENyZWF0ZSBkbWFidWYgZm9yIFBDSSBCQVIgcGVyDQo+ID4+IHJl
Z2lvbg0KPiA+Pg0KPiA+PiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5r
cyBvciBhdHRhY2htZW50cw0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiAxLzgvMjYgMTI6MDQsIFNoYW1l
ZXIgS29sb3RodW0gd3JvdGU6DQo+ID4+Pg0KPiA+Pj4NCj4gPj4+PiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+Pj4+IEZyb206IER1YW4sIFpoZW56aG9uZyA8emhlbnpob25nLmR1YW5A
aW50ZWwuY29tPg0KPiA+Pj4+IFNlbnQ6IDA4IEphbnVhcnkgMjAyNiAwOTo0MQ0KPiA+Pj4+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUtDQo+ID4+
IGFybUBub25nbnUub3JnOw0KPiA+Pj4+IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiA+Pj4+IENj
OiBlcmljLmF1Z2VyQHJlZGhhdC5jb207IGFsZXhAc2hhemJvdC5vcmc7IGNsZ0ByZWRoYXQuY29t
Ow0KPiA+Pj4+IGNvaHVja0ByZWRoYXQuY29tOyBtc3RAcmVkaGF0LmNvbTsgTmljb2xpbiBDaGVu
DQo+ID4+Pj4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0Budmlk
aWEuY29tPjsgTWF0dCBPY2hzDQo+ID4+Pj4gPG1vY2hzQG52aWRpYS5jb20+OyBKYXNvbiBHdW50
aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgS3Jpc2huYWthbnQNCj4gPj4+PiBKYWp1IDxramFqdUBu
dmlkaWEuY29tPg0KPiA+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8zXSBody92ZmlvL3JlZ2lv
bjogQ3JlYXRlIGRtYWJ1ZiBmb3IgUENJIEJBUg0KPiA+Pj4+IHBlciByZWdpb24NCj4gPj4+Pg0K
PiA+Pj4+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFj
aG1lbnRzDQo+ID4+Pj4NCj4gPj4+Pg0KPiA+Pj4+IE9uIDEyLzIyLzIwMjUgOTo1MyBQTSwgU2hh
bWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPj4+Pj4gRnJvbTogTmljb2xpbiBDaGVuIDxuaWNvbGlu
Y0BudmlkaWEuY29tPg0KPiA+Pj4+Pg0KPiA+Pj4+PiBMaW51eCBub3cgcHJvdmlkZXMgYSBWRklP
IGRtYWJ1ZiBleHBvcnRlciB0byBleHBvc2UgUENJIEJBUiBtZW1vcnkNCj4gPj4+Pj4gZm9yIFAy
UCB1c2UgY2FzZXMuIENyZWF0ZSBhIGRtYWJ1ZiBmb3IgZWFjaCBtYXBwZWQgQkFSIHJlZ2lvbiBh
ZnRlcg0KPiA+Pj4+PiB0aGUgbW1hcCBpcyBzZXQgdXAsIGFuZCBzdG9yZSB0aGUgcmV0dXJuZWQg
ZmQgaW4gdGhlIHJlZ2lvbuKAmXMgUkFNQmxvY2suDQo+ID4+Pj4+IFRoaXMgYWxsb3dzIFFFTVUg
dG8gcGFzcyB0aGUgZmQgdG8gZG1hX21hcF9maWxlKCksIGVuYWJsaW5nIGlvbW11ZmQNCj4gPj4+
Pj4gdG8gaW1wb3J0IHRoZSBkbWFidWYgYW5kIG1hcCB0aGUgQkFSIGNvcnJlY3RseSBpbiB0aGUg
aG9zdCBJT01NVQ0KPiA+Pj4+PiBwYWdlDQo+ID4+Pj4gdGFibGUuDQo+ID4+Pj4+DQo+ID4+Pj4+
IElmIHRoZSBrZXJuZWwgbGFja3Mgc3VwcG9ydCBvciBkbWFidWYgc2V0dXAgZmFpbHMsIFFFTVUg
c2tpcHMgdGhlDQo+ID4+Pj4+IHNldHVwIGFuZCBjb250aW51ZXMgd2l0aCBub3JtYWwgbW1hcCBo
YW5kbGluZy4NCj4gPj4+Pj4NCj4gPj4+Pj4gU2lnbmVkLW9mZi1ieTogTmljb2xpbiBDaGVuIDxu
aWNvbGluY0BudmlkaWEuY29tPg0KPiA+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90
aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gPj4+Pj4gLS0tDQo+ID4+Pj4+ICAgICBo
dy92ZmlvL3JlZ2lvbi5jICAgICB8IDU3DQo+ID4+Pj4gKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0NCj4gPj4+Pj4gICAgIGh3L3ZmaW8vdHJhY2UtZXZlbnRzIHwg
IDEgKw0KPiA+Pj4+PiAgICAgMiBmaWxlcyBjaGFuZ2VkLCA1NyBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+ID4+Pj4+DQo+ID4+Pj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL3JlZ2lvbi5j
IGIvaHcvdmZpby9yZWdpb24uYyBpbmRleA0KPiA+Pj4+PiBiMTY1YWIwYjkzLi42OTQ5ZjY3Nzlj
IDEwMDY0NA0KPiA+Pj4+PiAtLS0gYS9ody92ZmlvL3JlZ2lvbi5jDQo+ID4+Pj4+ICsrKyBiL2h3
L3ZmaW8vcmVnaW9uLmMNCj4gPj4+Pj4gQEAgLTI5LDYgKzI5LDcgQEANCj4gPj4+Pj4gICAgICNp
bmNsdWRlICJxZW11L2Vycm9yLXJlcG9ydC5oIg0KPiA+Pj4+PiAgICAgI2luY2x1ZGUgInFlbXUv
dW5pdHMuaCINCj4gPj4+Pj4gICAgICNpbmNsdWRlICJtb25pdG9yL21vbml0b3IuaCINCj4gPj4+
Pj4gKyNpbmNsdWRlICJzeXN0ZW0vcmFtYmxvY2suaCINCj4gPj4+Pj4gICAgICNpbmNsdWRlICJ2
ZmlvLWhlbHBlcnMuaCINCj4gPj4+Pj4NCj4gPj4+Pj4gICAgIC8qDQo+ID4+Pj4+IEBAIC0yMzgs
MTMgKzIzOSw1MiBAQCBzdGF0aWMgdm9pZA0KPiB2ZmlvX3N1YnJlZ2lvbl91bm1hcChWRklPUmVn
aW9uDQo+ID4+Pj4gKnJlZ2lvbiwgaW50IGluZGV4KQ0KPiA+Pj4+PiAgICAgICAgIHJlZ2lvbi0+
bW1hcHNbaW5kZXhdLm1tYXAgPSBOVUxMOw0KPiA+Pj4+PiAgICAgfQ0KPiA+Pj4+Pg0KPiA+Pj4+
PiArc3RhdGljIGludCB2ZmlvX3JlZ2lvbl9jcmVhdGVfZG1hX2J1ZihWRklPUmVnaW9uICpyZWdp
b24pIHsNCj4gPj4+Pj4gKyAgICBnX2F1dG9mcmVlIHN0cnVjdCB2ZmlvX2RldmljZV9mZWF0dXJl
ICpmZWF0dXJlID0gTlVMTDsNCj4gPj4+Pj4gKyAgICBWRklPRGV2aWNlICp2YmFzZWRldiA9IHJl
Z2lvbi0+dmJhc2VkZXY7DQo+ID4+Pj4+ICsgICAgc3RydWN0IHZmaW9fZGV2aWNlX2ZlYXR1cmVf
ZG1hX2J1ZiAqZG1hX2J1ZjsNCj4gPj4+Pj4gKyAgICBzaXplX3QgdG90YWxfc2l6ZTsNCj4gPj4+
Pj4gKyAgICBpbnQgaSwgcmV0Ow0KPiA+Pj4+PiArDQo+ID4+Pj4+ICsgICAgZ19hc3NlcnQocmVn
aW9uLT5ucl9tbWFwcyk7DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gKyAgICB0b3RhbF9zaXplID0gc2l6
ZW9mKCpmZWF0dXJlKSArIHNpemVvZigqZG1hX2J1ZikgKw0KPiA+Pj4+PiArICAgICAgICAgICAg
ICAgICBzaXplb2Yoc3RydWN0IHZmaW9fcmVnaW9uX2RtYV9yYW5nZSkgKiByZWdpb24tPm5yX21t
YXBzOw0KPiA+Pj4+PiArICAgIGZlYXR1cmUgPSBnX21hbGxvYzAodG90YWxfc2l6ZSk7DQo+ID4+
Pj4+ICsgICAgKmZlYXR1cmUgPSAoc3RydWN0IHZmaW9fZGV2aWNlX2ZlYXR1cmUpIHsNCj4gPj4+
Pj4gKyAgICAgICAgLmFyZ3N6ID0gdG90YWxfc2l6ZSwNCj4gPj4+Pj4gKyAgICAgICAgLmZsYWdz
ID0gVkZJT19ERVZJQ0VfRkVBVFVSRV9HRVQgfA0KPiA+Pj4+IFZGSU9fREVWSUNFX0ZFQVRVUkVf
RE1BX0JVRiwNCj4gPj4+Pj4gKyAgICB9Ow0KPiA+Pj4+PiArDQo+ID4+Pj4+ICsgICAgZG1hX2J1
ZiA9ICh2b2lkICopZmVhdHVyZS0+ZGF0YTsNCj4gPj4+Pj4gKyAgICAqZG1hX2J1ZiA9IChzdHJ1
Y3QgdmZpb19kZXZpY2VfZmVhdHVyZV9kbWFfYnVmKSB7DQo+ID4+Pj4+ICsgICAgICAgIC5yZWdp
b25faW5kZXggPSByZWdpb24tPm5yLA0KPiA+Pj4+PiArICAgICAgICAub3Blbl9mbGFncyA9IE9f
UkRXUiwNCj4gPj4+Pj4gKyAgICAgICAgLm5yX3JhbmdlcyA9IHJlZ2lvbi0+bnJfbW1hcHMsDQo+
ID4+Pj4+ICsgICAgfTsNCj4gPj4+Pj4gKw0KPiA+Pj4+PiArICAgIGZvciAoaSA9IDA7IGkgPCBy
ZWdpb24tPm5yX21tYXBzOyBpKyspIHsNCj4gPj4+Pj4gKyAgICAgICAgZG1hX2J1Zi0+ZG1hX3Jh
bmdlc1tpXS5vZmZzZXQgPSByZWdpb24tPm1tYXBzW2ldLm9mZnNldDsNCj4gPj4+Pj4gKyAgICAg
ICAgZG1hX2J1Zi0+ZG1hX3Jhbmdlc1tpXS5sZW5ndGggPSByZWdpb24tPm1tYXBzW2ldLnNpemU7
DQo+ID4+Pj4+ICsgICAgfQ0KPiA+Pj4+PiArDQo+ID4+Pj4+ICsgICAgcmV0ID0gdmJhc2VkZXYt
PmlvX29wcy0+ZGV2aWNlX2ZlYXR1cmUodmJhc2VkZXYsIGZlYXR1cmUpOw0KPiA+Pj4+DQo+ID4+
Pj4gdmJhc2VkZXYtPmlvX29wcy0+ZGV2aWNlX2ZlYXR1cmUgbWF5IGJlIE5VTEwgZm9yIG90aGVy
IGJhY2tlbmQgbGlrZQ0KPiA+Pj4+IHZiYXNlZGV2LT52ZmlvLQ0KPiA+Pj4+IHVzZXIuDQo+ID4+
Pg0KPiA+Pj4gQWguLk9rLiBJIHdpbGwgYWRkIGEgY2hlY2suDQo+ID4+DQo+ID4+IENvdWxkIHlv
dSBwbGVhc2UgYWRkIGEgZ2xvYmFsIHJvdXRpbmUgOg0KPiA+Pg0KPiA+PiAgICAgaW50IHZmaW9f
ZGV2aWNlX2dldF9mZWF0dXJlKFZGSU9EZXZpY2UgKnZiYXNlZGV2LCBzdHJ1Y3QNCj4gPj4gdmZp
b19kZXZpY2VfZmVhdHVyZSAqZmVhdHVyZSkNCj4gPg0KPiA+IE9rLg0KPiA+DQo+ID4+DQo+ID4+
DQo+ID4+Pg0KPiA+Pj4+DQo+ID4+Pj4+ICsgICAgZm9yIChpID0gMDsgaSA8IHJlZ2lvbi0+bnJf
bW1hcHM7IGkrKykgew0KPiA+Pj4+PiArICAgICAgICB0cmFjZV92ZmlvX3JlZ2lvbl9kbWFidWYo
cmVnaW9uLT52YmFzZWRldi0+bmFtZSwgcmV0LCByZWdpb24tDQo+ID5uciwNCj4gPj4+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZ2lvbi0+bWVtLT5uYW1lLCByZWdpb24t
Pm1tYXBzW2ldLm9mZnNldCwNCj4gPj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHJlZ2lvbi0+bW1hcHNbaV0uc2l6ZSk7DQo+ID4+Pj4+ICsgICAgfQ0KPiA+Pj4+PiArICAg
IHJldHVybiByZXQ7DQo+ID4+Pj4+ICt9DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gICAgIGludCB2Zmlv
X3JlZ2lvbl9tbWFwKFZGSU9SZWdpb24gKnJlZ2lvbikNCj4gPj4+Pj4gICAgIHsNCj4gPj4+Pj4g
ICAgICAgICBpbnQgaSwgcmV0LCBwcm90ID0gMDsNCj4gPj4+Pj4gICAgICAgICBjaGFyICpuYW1l
Ow0KPiA+Pj4+PiAgICAgICAgIGludCBmZDsNCj4gPj4+Pj4NCj4gPj4+Pj4gLSAgICBpZiAoIXJl
Z2lvbi0+bWVtKSB7DQo+ID4+Pj4+ICsgICAgaWYgKCFyZWdpb24tPm1lbSB8fCAhcmVnaW9uLT5u
cl9tbWFwcykgew0KPiA+Pj4+DQo+ID4+Pj4gSnVzdCBjdXJpb3VzLCB3aGVuIHdpbGwgYWJvdmUg
Y2hlY2sgcmV0dXJuIHRydWU/DQo+ID4+PiBJIHRoaW5rIGAhcmVnaW9uLT5tZW1gIGNvdmVycyBj
YXNlcyB3aGVyZSBubyBNZW1vcnlSZWdpb24gd2FzIGNyZWF0ZWQNCj4gPj4+IChlLmcuIHplcm8g
c2l6ZWQgcmVnaW9ucykuICBBbmQgbnJfbW1hcHMgY2hlY2tzIHJlZ2lvbnMgd2l0aCBtbWFwDQo+
ID4+PiBzdXBwb3J0IGV4aXN0cyAoVkZJT19SRUdJT05fSU5GT19GTEFHX01NQVAvDQo+IF9DQVBf
U1BBUlNFX01NQVApLg0KPiA+Pj4NCj4gPj4+Pg0KPiA+Pj4+PiAgICAgICAgICAgICByZXR1cm4g
MDsNCj4gPj4+Pj4gICAgICAgICB9DQo+ID4+Pj4+DQo+ID4+Pj4+IEBAIC0zMDUsNiArMzQ1LDIx
IEBAIGludCB2ZmlvX3JlZ2lvbl9tbWFwKFZGSU9SZWdpb24gKnJlZ2lvbikNCj4gPj4+Pj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWdpb24tPm1tYXBzW2ldLnNpemUgLSAx
KTsNCj4gPj4+Pj4gICAgICAgICB9DQo+ID4+Pj4+DQo+ID4+Pj4+ICsgICAgcmV0ID0gdmZpb19y
ZWdpb25fY3JlYXRlX2RtYV9idWYocmVnaW9uKTsNCj4gPj4+Pj4gKyAgICBpZiAocmV0IDwgMCkg
ew0KPiA+Pj4+PiArICAgICAgICBpZiAocmV0ID09IC1FTk9UVFkpIHsNCj4gPj4+Pj4gKyAgICAg
ICAgICAgIHdhcm5fcmVwb3J0X29uY2UoIlZGSU8gZG1hYnVmIG5vdCBzdXBwb3J0ZWQgaW4ga2Vy
bmVsIik7DQo+ID4+Pj4+ICsgICAgICAgIH0gZWxzZSB7DQo+ID4+Pj4+ICsgICAgICAgICAgICBl
cnJvcl9yZXBvcnQoIiVzOiBmYWlsZWQgdG8gY3JlYXRlIGRtYWJ1ZjogJXMiLA0KPiA+Pj4+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgIG1lbW9yeV9yZWdpb25fbmFtZShyZWdpb24tPm1lbSks
DQo+ID4+Pj4+ICsgc3RyZXJyb3IoZXJybm8pKTsNCj4gPj4NCj4gPj4gU2hvdWxkbid0IHdlIHJl
dHVybiAncmV0JyBpbiB0aGlzIGNhc2UgPw0KPiA+DQo+ID4gVGhhdCB3b3VsZCByZXN1bHQgaW46
DQo+ID4NCj4gPiBGYWlsZWQgdG8gbW1hcCAwMDE4OjA2OjAwLjAgQkFSIDAuIFBlcmZvcm1hbmNl
IG1heSBiZSBzbG93DQo+ID4NCj4gPiBOb3Qgc3VyZSB0aGF0IGVycm9yIG1zZyBpcyBjb3JyZWN0
IGluIHRoaXMgY29udGV4dC4NCj4gDQo+IEFncmVlLiBJdCB3b3VsZCBiZSBhIHN0ZXAgYmFja3dh
cmRzIGZyb20gdGhlIGN1cnJlbnQgc2l0dWF0aW9uLg0KPiANCj4gPiBJZiB3ZSBkb24ndCByZXR1
cm4gJ3JldCcgaGVyZQ0KPiA+IHZmaW9fY29udGFpbmVyX2RtYV9tYXAoKSB3aWxsIGV2ZW50dWFs
bHkgcmVwb3J0IHRoZSB3YXJuaW5nOg0KPiA+DQo+ID4gcWVtdS1zeXN0ZW0tYWFyY2g2NDogd2Fy
bmluZzoNCj4gdmZpb19jb250YWluZXJfZG1hX21hcCgweGFhYWFmZjY3YWQ0MCwgMHg1ODAwMDAw
MDAwMCwgMHhiOTAwMDAsDQo+IDB4ZmZmZjY0MDAwMDAwKSA9IC0xNCAoQmFkIGFkZHJlc3MpDQo+
ID4gMDAxODowNjowMC4wOiBQQ0kgcGVlci10by1wZWVyIHRyYW5zYWN0aW9ucyBvbiBCQVJzIGFy
ZSBub3Qgc3VwcG9ydGVkLg0KPiA+IHFlbXUtc3lzdGVtLWFhcmNoNjQ6IHdhcm5pbmc6IElPTU1V
X0lPQVNfTUFQIGZhaWxlZDogQmFkIGFkZHJlc3MsDQo+IFBDSSBCQVI/DQo+IA0KPiBZZXMgdGhh
dCdzIHdoYXQgd2UgaGF2ZSB0b2RheS4NCj4gDQo+ID4gSSB0aGluayB0aGUgYWJvdmUgaXMgZ29v
ZCBlbm91Z2ggZm9yIHRoaXMuIFBsZWFzZSBsZXQgbWUga25vdy4NCj4gDQo+IEdpdmVuIHRoYXQs
IHdpdGggdGhpcyBjaGFuZ2UsIFFFTVUgd2lsbCBub3cgYWx3YXlzIHJlcXVlc3QgYQ0KPiBETUFC
VUYgZmQsIHRoZSBxdWVzdGlvbiBpcyB0byB3aGF0IGV4dGVudCBhIGZhaWx1cmUgc2hvdWxkDQo+
IGJlIGNvbnNpZGVyZWQgY3JpdGljYWwuDQo+IA0KPiBXb3VsZCB0aGVyZSBiZSByZWFzb25zIHRv
IGZhaWwgdG8gcmVhbGl6ZSB0aGUgdmZpby1wY2kgZGV2aWNlDQo+IGFuZCBzdG9wIHRoZSBtYWNo
aW5lID8NCg0KSG1tLi4uSSBkb27igJl0IHRoaW5rIHNvLiBUaGlzIG1haW5seSBtYXR0ZXJzIGZv
ciBkZXZpY2VzIHRoYXQgbWFrZSB1c2Ugb2YgUDJQIERNQQ0Kb3IgZXhwb3NlIGRldmljZSBtZW1v
cnksIHN1Y2ggYXMgR3JhY2UgR1BVcy4gQWxzbywgUUVNVSBjdXJyZW50bHkgZG9lcyBub3QNCnRy
ZWF0IHZmaW9fY29udGFpbmVyX2RtYV9tYXAoKSBmYWlsdXJlcyBhcyBmYXRhbCBlaXRoZXIuDQoN
CkZvciB2MiwgSSB3aWxsIGtlZXAgdGhlIGV4aXN0aW5nIGJlaGF2aW91ci4gV2UgY2FuIGNvbnNp
ZGVyIHRpZ2h0ZW5pbmcgdGhpcyANCmxhdGVyIGlmIHRoZXJlIGlzIGEgY29uY3JldGUgcmVxdWly
ZW1lbnQgdG8gZmFpbCBkZXZpY2UgcmVhbGl6YXRpb24gaW4gc3VjaCBjYXNlcy4NCg0KSG9wZSwg
dGhhdCBpcyByZWFzb25hYmxlIGZvciBub3cuDQoNCg0KVGhhbmtzLA0KU2hhbWVlciANCg==

