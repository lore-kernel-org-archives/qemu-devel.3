Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00A4C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 06:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tscKZ-0002Gx-BF; Thu, 13 Mar 2025 02:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tscKU-0002GC-0z
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:46:07 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tscKO-0004Lq-Qw
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1741848360; x=1773384360;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=xBt5qVDyVXBiDEisBqfwqQl0Z/8TXBFT9Kgq5eqv+Y8=;
 b=e7dUR1tTngjfUmgOye8ulMFltwXXxkHtGDewWgq+4NI/vXkLCTzNuvFA
 nGOG8mHjKg9eJzZ4lrs6X7y3WmIU1RODLQTzHywqoS0lrLdlohz7AE49d
 fNOMwLo49fZfybKkq/ERx9CWBpqDh2wEz8IYqxSRI3Prtv3ssMiJRPeiq
 tPEXKBAuFspACRigRgfLL3CPAiso9C1+RnbvhCa5400mC5aI3wZDtixby
 brQnQuZDh6ZnSTF8gKaWrWgWCMoS8jDg45XieaQSbTnOk170wOqLMibyF
 4JV3EUgx5vPZ3A4Tu1uqxBsVefEfWnMDoSfWgBOnQ9oj3JPwjoB4fpGyW Q==;
X-CSE-ConnectionGUID: NNIlfAyDRLSb7rqLqLUU+g==
X-CSE-MsgGUID: UzqLEV4uRbev/RA/HgQEbg==
X-IronPort-AV: E=Sophos;i="6.14,243,1736809200"; d="scan'208";a="32804326"
X-MGA-submission: =?us-ascii?q?MDGaDtGyTf8dS4Lj0huERrfBkQDt0q6alTaVl3?=
 =?us-ascii?q?SjYMZChFEfb13hPzENJ8y3O/SRRVTPWV7pmBJddso25p3lgkXtcgMGQG?=
 =?us-ascii?q?0v7cLLmUoiMf0L7H2AQiTHl0CFDbBj5wM+eRS0pg+OiLU5uY8P2FDpdM?=
 =?us-ascii?q?WAhQAj8T6cRXTaV2VuXn9UhA=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 13 Mar 2025 07:45:56 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qojkurvhOrxErUtf3hoB4uJPdH4UUHzXVtGmya2EQpZHBs6vlXuC4l5pAXWh5P51Ht4kvye2QUDgx8hzkLI8QqF3TREQy0NwSGdGooeJIFu1G+9SddVoMxuoi6omADsb1ycvNR6t56RdCz2Cr2UsmBkN9Cf4tuDnOmoeEu80Qc94pf5DhnQ/tj4T9VmHt5DOnrC4lY8325ARvVPOh4FKKTU8TfNdyoLjaZ/ccC1ED5tXjNBLvI7zmIgyF8R0Tg1BTidDUKls8GNS3RBzjjKIymk8Uw5ZEhdlDxnLt9B0/XE9DPwTLr++do6BTl0xaqg82PyAAP06PcvIi0PXeSJqbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBt5qVDyVXBiDEisBqfwqQl0Z/8TXBFT9Kgq5eqv+Y8=;
 b=nyAc+pQo5W+up412toZAyy3ySZkBiEDHu175BQxDhNWgHT07cnuFYGhHOANTdF97Ft1Tj2+cvl+21KtOz1LpmwUDtvicoDTl8ld+GcuX6HtJWoCavCOgPdrG108Bpc2vlzvfLC0fr1niN65ovDH5uRNo3astPWbYB6FsV6OP5g727Hd7xX+emDsfRVB9ZTmsmHAnCDiku5cl83nDBLc4jnj/SDMaTUZiHo9a6H7zp9TA8Afg57/dUh3INrV0/ORnjOv3dGarBarSu8Nz+FMYgWn80Y3flhYmLfMShqLNGFsnmC6mtBGGh7z+1ICI9itN4t/kfkfoLualjKcd34eABA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBt5qVDyVXBiDEisBqfwqQl0Z/8TXBFT9Kgq5eqv+Y8=;
 b=nvfkXkXoN0+3Z5aqhFL7NTHhZgcvQUkHcsYWJuWxuTQCS/ocAZhz1na9Iuosx+eKfYeE2SRN8/PBY7z264gyWiOHTKJ6UFv0VhiJAIani6lZN0mCb7gW8FV3/zbUmKoXHypEzXLpJ55+PVWpN9TZ5QTuoUG5IlI9bmZ3groYiNejtEuKYKrETP+19S57Weoz2vWAmkYtPmtn1UdwrFJIJ+HjDPWPskcztqlqv/zzYTja+cCGiiEO/rAU1c8+WZAuuL38NGIy/OgrMbFV0uXNi2scGQEpG1TH4eBnGv0AooZruoKbie593vlm8FixNqd7JGDRmBduW8vPIlWyl9UVkA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB9PR07MB9809.eurprd07.prod.outlook.com (2603:10a6:10:4ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 06:45:54 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 06:45:52 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Yi Liu <yi.l.liu@intel.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Akihiko Odaki <akihiko.odaki@daynix.com>, Bibo Mao <maobibo@loongson.cn>, 
 Peter Maydell <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: Re: Giving your own patches your Reviewed-by
Thread-Topic: Giving your own patches your Reviewed-by
Thread-Index: AQHbkzOkmMq4hxJr7UKsXV0iVGUberNvRXwAgAAv7ICAASsugA==
Date: Thu, 13 Mar 2025 06:45:52 +0000
Message-ID: <542252f1-d4f5-41a7-badd-c17acd94e8bf@eviden.com>
References: <878qpamvk6.fsf@pond.sub.org>
 <9329310c-bfad-44aa-a53a-87c1f39668a2@linaro.org>
 <ca6ab1ec-4f30-4da7-ac08-3a514d8b4a02@intel.com>
In-Reply-To: <ca6ab1ec-4f30-4da7-ac08-3a514d8b4a02@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB9PR07MB9809:EE_
x-ms-office365-filtering-correlation-id: 1b9dd402-32d3-4e63-5bd1-08dd61fab285
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T2V6eS9MN1ltNzhzcno4M1VvLytBY05RY3d2eXI2dThDb21ZWFEzL3VHVGdV?=
 =?utf-8?B?YmVQYlZnNzV6ZlErV1RkYXZKOE03YU94RXkvOVo4SEU2ZXp6bDNoY3FlNi9t?=
 =?utf-8?B?Q2hRLzA3WktuekJhVW4vcmlGR1NqNWhSUGtmU1V5cWtpemkwdTFLSmo3Sysy?=
 =?utf-8?B?VjIrYlNHQnl5bUNRUkdtM1R5V1dIbDFDSGIvVVQ3VlAvek9LbDNhaUNBYzA3?=
 =?utf-8?B?V0I4dkNoeU9FUEVCazBnK0ZMcCtHRFhaUllvZHJwdXU1bE1OOVJrMDVPeE1K?=
 =?utf-8?B?UGVlempFcHNCU1NOTElodXRHVGhDNXJJMjJIWUFBaTZYVzJEWnBsMFFRRFcx?=
 =?utf-8?B?cU5ZOG5RODRXOUMyNkJ4WlNPVmluSUpWZm05WGxlM2NFOXpzV2J4eTJLR1Vq?=
 =?utf-8?B?K0VEeUJoSXFpbzBkM2RqVGF1YXQ4dzJjYWJCaHdMNnYzRlF3cVlJOTFZTGNm?=
 =?utf-8?B?c0VKOUhqU1VFYlRLemZYUUFmeEdjSzFHUUhFaENPWmZMWUdENDQxdWo3SnAx?=
 =?utf-8?B?Um9DTGV3Uy9uNHdjRkpkV1pBcVhkQi92N24zRTFPZng5dEpxQ2tWcktyQ1pG?=
 =?utf-8?B?T2hyZXloQXozK08zUHc1dXV3YXh2c3BCazJpM1d0bEZpT3pTNmVrZjg0ZnZl?=
 =?utf-8?B?bHV5QThLL0R2WlJuc1kzNUt4eVFFRDFvUGl3SGpzelV2MTBoYTN0bFBXanRj?=
 =?utf-8?B?OVE2L3hrNlBSdlQ4d2tsUXdFQytLYkNqTE04RjN2Rk54OHVpamc5aUhPbUMz?=
 =?utf-8?B?ZHlYeGJQWFUwR1E4emRLd2VYeTYzSloxWWEzVytDd2lnTXRlTFlXbSt5eVB4?=
 =?utf-8?B?M0xzamxhVlFFRE9rL3FKb0g1L0pCWDdZbm05TDI0ZzFNV2NtblhWeU1Fbk0r?=
 =?utf-8?B?ZGp2Zi95Z3BWYXhwd0xaWldXbThUNFRLOG04RkhwMTZ2TkxJMVRHMWxvb1Z0?=
 =?utf-8?B?ZHVSeHlVS2RyQkVLbzA3aUtTWDJJNEZzd3gxSVpwVlNFcFFvclVBNFBRam5L?=
 =?utf-8?B?NXFyckJmYy9XcWJWckhoaEJCR3E4WjNKVWhkTU5XakU4OTh5WmN3VHV5ZWo4?=
 =?utf-8?B?akpwMUJnVjc1TVlqU0xQNjIxbXZOSi9MOG92OVlFcHRBWTI3VklXTjBFSlA5?=
 =?utf-8?B?S2xiNlRxamVjTW9YRTIyMzN6QzlHbjBKOW1rcCtSVlRNWkxHN0ZUZDdXeTBB?=
 =?utf-8?B?WTBaRGRXdndrZlRyd1FqL1JDdTBjNEN1azhNM25GbzdZY1BkYW5hSTBGMk9F?=
 =?utf-8?B?bHd3ckpnRVdzS1A0c043aGU2Y3VIZGNtNmR3SW5iNEVOWlkyckNvcXU4RFh3?=
 =?utf-8?B?c1ZVcXdkbXhyV0I2eDdBUEJhM04zbTBOWkxIU2FtOTlmNkZwWCtEb1orcXhk?=
 =?utf-8?B?VXZDRUczdHNBZWF6V3JJV2ZyRytIMGJwRG1LYVZCS3k2bDNTYmFmUktYMUdl?=
 =?utf-8?B?Um1YenhoR3Eya3FtTHNGYWpFNklweGVZRHNlZ2hpQ0JNZnpZTERLN01pRUJu?=
 =?utf-8?B?VlpmU25zYlRyMElKcWRSR2hBdDJRYldMaitoOFNrNnZSWldIOTVNRmx4cmpI?=
 =?utf-8?B?YVFoVTZkWDdyT05WeVg2L21hZUo0WDBmaE5BVVkrcHdCYzBBaU1WSUdFeThi?=
 =?utf-8?B?QlkyL1VHcmcwU1B4djdyR3RxK3VzQ3pJTjZ1YmxsUGU3Q3RMOUtRTDJTMVI5?=
 =?utf-8?B?cUtnSE0vcU9RSkJZWjVjZlFrNVptb2JqdEVLRXRVM1BWN3BMdFJnZkhDV1NR?=
 =?utf-8?B?blNwNnJVTW5mTlV6QmJvSFdKM0o4L0o3L3hIWDJITm1vdThsL3B4aGRHMU1K?=
 =?utf-8?B?ejVQY00xNTJVMXZqUkltSXI5aEpyVmwrd3lRUTBYUFRyd0xhTmpHZmVYelBJ?=
 =?utf-8?B?NTlUYnZ0cTZ1NnhGYmhuMDlIaTlPL3lxUExlaEE0ZWpwV2pjUU9jQnhuMk5n?=
 =?utf-8?Q?S1wM10FwkvVK9XNyqAP4G7Zx0R0oALYS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1ZaNHZuei82SndScGtySElWaDFsS09EeUphZ0F3elhmcnVSV0NZenZzMlZ4?=
 =?utf-8?B?dTh3ZGtjY2xmK3N1c1pvZDFSQXFEWXBkSWZtYTZhdUwyd29USGRqMmp5MHZP?=
 =?utf-8?B?OW9YNm15L0RsejhqNGhFNnNhQmJYaDRaaXdjVHBMMHdiZk9sYlI2dC92U3k0?=
 =?utf-8?B?ZG1ad3RzOTNXSk1RNmtJc1k0OE83TTNsV1NMWW5ZQTB2QnlvN3kvcm9DNVB0?=
 =?utf-8?B?OVg1ODd1MVd1NTZNd0ZwbGVPSmsvRGZZdnYwdjI0NWUvMGd3dmMrZnNHa043?=
 =?utf-8?B?SnpqenppN0YzRUdHYk5CZVZWRURIQkNQRGdTL0ZXZis4TS8zbEJ0OXNwcGp6?=
 =?utf-8?B?ajIveENaRUlQYzZMV0ZmQTYvYXpTMm1DRUxyb0ZwbTRGcG1SdDhmc0hjTzky?=
 =?utf-8?B?RmdkVE03RTNrWnFEbXJMelU3bitXZFhsR3dUVnRiTlI1VzNNcmV3bUZvblhm?=
 =?utf-8?B?b3ZlQS9MUWlNUjU5ZitadTZQaE1Yd0UrZy9LcnRUVU5MUitkYTB5K1oveWJZ?=
 =?utf-8?B?dHN0czFLUDVSMWhuWjZYaEVhd0pRbkV3Z2VORjBKeExic2Faci9ENlJGM2pR?=
 =?utf-8?B?TlF3QXQxUW11UnNsZVY2K1NNam5pbWdPQU1OeG53WHlkR3N2R01URjh6VjZi?=
 =?utf-8?B?VTMyQ2k5SXpaSS9EWnl6WjVnM0R4aXp1ckRSdDBSNXZiVEtEc0xTTGNhTzF6?=
 =?utf-8?B?ak82WFZCdk1QRVY5OUUwSlQ2RFk2L2ZtMTZuUWp4UDdzRXdvUW9QY2RIQ1F0?=
 =?utf-8?B?a1loNjQ4RVM5V2tHVnIwV0dlM3R2M3ZEakxuN0xSUEY3TVVFaVVkaUw1QVRh?=
 =?utf-8?B?Y2dLa0VPN0c0TXkzbC9MNU45T3NjT21Gd2UvQ0szQ2xUZ0lzNjF1V3JlOUJH?=
 =?utf-8?B?aUVWTmwwTDlMMnBGOFZsN3J3TFl1T3l1UkFHalE5TjlKeEZhWFpjVVhyTzRF?=
 =?utf-8?B?R1pXenh5Ujh0RElEOU91VnRQM1ZWVVU2Zm9jRThoVFpTSDc5QXJWSTFsckxn?=
 =?utf-8?B?UndtSFM5RGwyaU1OR1NBcHZneFRzUWloMXd0QjFPK0pWOCtiWnR6czRSYlBn?=
 =?utf-8?B?UEw4bW5JUmxVQzRUUmJnY0hoVGFhTG85MGJLQnNrYys1bVUwby9QWTM0UVVG?=
 =?utf-8?B?QjF6YWRRZHVJMHNhOFc1RThDeCtUYmx1YkVQVnhZWGl6bmM2Zk5nSHh1T3Jn?=
 =?utf-8?B?L2hicmhLV1BoV3pOSEE4QkJMV3FrQVB6VHVGaVZTK0h0Y0Z2eWh6WWxrSVZC?=
 =?utf-8?B?MVZRS1JQZXd5cjJpYVl1bE5WckR0UkJMTFhhNGsyY215aGp1ZUQ2M0Yrd2Yv?=
 =?utf-8?B?SmcxTU94bW11UnllNjVobVdDRDJoZ0wwRFQ2aCtYZlhkK1I4cDVwQ3NTbUlG?=
 =?utf-8?B?RXlWcVhGSVErOE54SGV3akRiemJ3am1oNDYzRWJNbXo1R3pUZy9LTUJ2WDVZ?=
 =?utf-8?B?dlNKVkY5WTR5M0JJNnZHSEVLY0wrdEZxZThsZUpyWjlJQU1yYUhTN2k5aEJZ?=
 =?utf-8?B?MEM0Y2ZqNEI4S1VpSHkxVWkvTkpLeEt1ZTMzMit3WDFyM2pTRGRHa3NNelZt?=
 =?utf-8?B?NGh4RHJSYnY2K0ZpQXJ6VGd1UUJzb1R0YzdxS2NvZDBoZzNMSk8zY01SQ3NV?=
 =?utf-8?B?dzkrY0t4YzFzaWlnNWlrTUlhR0dKNUFxWlBtMUNyVUdsbDkwc005KzhmSGhR?=
 =?utf-8?B?dEEwbWF0UWhDcnB4Qkc5K2drTnNxQWVvT2dKS1hFcllxaWhjN21tUFRxMFpa?=
 =?utf-8?B?R1hIcU9oUEZTeklLL0VaYWJXYzk2bXpuSUJpSmhKSk45eVl0bHRVd2NXYVht?=
 =?utf-8?B?emN0V3dwL2dwbTBLZHRoWlg2QUNjdGJZYXZlRFJmdU92QzRtMnU2RURKbDlx?=
 =?utf-8?B?TnZ1aWdaTWZNR2haYWF4WkY2L2c4dXhFN21LK2U4aU1oRnN0UkcvZVdRaDlk?=
 =?utf-8?B?ajZ6SU8vdlhoRGZiRW5hN2U5L0NWRWVaY3FtOVZYak1La0lBWmtVUWFhUWZi?=
 =?utf-8?B?dHh1RlRoY0pzQ21qaW4wMTRKemFwak9zQXJGTXV5cDZSUy9HTUp4bDhpaGQz?=
 =?utf-8?B?aW9GOC8rZXdvQUpuYUJpd1FBdTJOaWZkQ09UL2QyMlJNWXFQSlR0YlAvakRQ?=
 =?utf-8?B?K1JqUmg4VlNaMTVXb25nbHJxdGxHaXpoUG1UQnpxczdWSWVHYUhNT0NaZ3NW?=
 =?utf-8?Q?ZOzI0jgAF+vIaR4QwgKGyUs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AEBEFBF920EC547BFF65A71A73EE56C@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9dd402-32d3-4e63-5bd1-08dd61fab285
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 06:45:52.0664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zPukIDOa6z4biw5EBK64OOREebtnsxMyfQLfaZ7j51/mC1Mi0beA1OcI7PCFA5JAe5cpY5OPTHqGR7StzBw5sR0fS+NCu5dSuEiMS5OZ5JintsMO0na3iuY5vwMYB1CU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9809
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCk9uIDEyLzAzLzIwMjUgMTM6NTQsIFlpIExpdSB3cm90ZToNCj4gQ2F1dGlvbjogRXh0ZXJu
YWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxlc3Mg
DQo+IHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiBPbiAyMDI1LzMvMTIgMTg6MDMsIFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4gSGkgTWFya3VzLA0KPj4NCj4+IChDYydpbmcgWWks
IENsw6ltZW50IGFuZCBaaGVuemhvbmcgZm9yIGNvbW1pdCBlZGE0YzliNWIzYykNCj4+DQo+PiBP
biAxMi8zLzI1IDEwOjQ1LCBNYXJrdXMgQXJtYnJ1c3RlciB3cm90ZToNCj4+PiBJIHN0dW1ibGVk
IG92ZXIgY29tbWl0cyB0aGF0IGNhcnJ5IHRoZSBhdXRob3IncyBSZXZpZXdlZC1ieS4NCj4+Pg0K
Pj4+IFRoZXJlIG1heSBiZSBjYXNlcyB3aGVyZSB0aGUgcmVjb3JkZWQgYXV0aG9yIGlzbid0IHRo
ZSBsb25lIGF1dGhvciwgYW5kDQo+Pj4gdGhlIHJlY29yZGVkIGF1dGhvciBkaWQgc29tZSBtZWFu
aW5nZnVsIHJldmlldyBvZiB0aGUgcGF0Y2gncyBwYXJ0cyB0aGF0DQo+Pj4gYXJlIG5vdCB0aGVp
cnMuwqAgTWluZCB0aGF0IHdlIGRvIG5lZWQgYWxsIGF1dGhvcnMgdG8gcHJvdmlkZSB0aGVpcg0K
Pj4+IFNpZ25lZC1vZmYtYnkuDQo+Pj4NCj4+PiBXaGVuIHRoZSBvbmx5IFNpZ25lZC1vZmYtYnkg
aXMgZnJvbSB0aGUgcmVjb3JkZWQgYXV0aG9yLCBhbmQgdGhlcmUncw0KPj4+IGFsc28gdGhlaXIg
UmV2aWV3ZWQtYnksIHRoZSBSZXZpZXdlZC1ieSBpcyBhbG1vc3QgY2VydGFpbmx5IGJvZ3VzLg0K
PiANCj4geWVhaCwgdGhhdCBtaWdodCBiZSBzYWRseSBwb3NzaWJsZS4gOigNCj4gDQo+Pj4NCj4+
PiBOb3csIGFjY2lkZW50cyBoYXBwZW4sIG5vIGJpZyBkZWFsLCBldGMuLCBldGMuwqAgSSBwb3N0
IHRoaXMgdG8gaG9wZWZ1bGx5DQo+Pj4gaGVscCByZWR1Y2UgdGhlIGFjY2lkZW50IHJhdGUgOikN
Cj4gDQo+IGEgZHVtYiBxdWVzdGlvbi4gV2hlcmUgY2FuIEkgdmlldyB0aGlzIGlzc3VlPw0KPiAN
Cj4+Pg0KPj4+IEhlcmUncyBteSBxdWljayAmIHNsb3BweSBzZWFyY2ggZm9yIHBvdGVudGlhbGx5
IHByb2JsZW1hdGljIHVzZXMgb2YNCj4+PiBSZXZpZXdlZC1ieToNCj4+Pg0KPj4+ICQgZ2l0LWxv
ZyAtLXNpbmNlICd0d28geWVhcnMgYWdvJyB8IGF3ayAtRjogJy9eY29tbWl0IC8geyBjb21taXQ9
JDAgfQ0KPj4+IC9eQXV0aG9yOiAvIHsgZ3V5PSQyIH0gL17CoMKgwqAgUmV2aWV3ZWQtYnk6IC8g
eyBpZiAoJDIgPT0gZ3V5KSB7IHByaW50DQo+Pj4gY29tbWl0OyBwcmludCBndXkgfSB9Jw0KPj4N
Cj4+DQo+PiBFeHBsYWluaW5nIHNvbWUgY29tbWl0cyB3aGVyZSBJJ20gbWVudGlvbmVkOg0KPj4N
Cj4+IGNvbW1pdCAxZTBkNGViNGVlN2M5MDkzMjNiZmZjMzliYzM0OGViMzE3NGI0MjZiDQo+PiBB
dXRob3I6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4+IERh
dGU6wqDCoCBGcmkgQXByIDEyIDAwOjMzOjMwIDIwMjQgLTA3MDANCj4+DQo+PiDCoMKgwqDCoCBi
YWNrZW5kcy90cG06IFVzZSBxZW11X2hleGR1bXBfbGluZSgpIHRvIGF2b2lkIHNwcmludGYoKQ0K
Pj4NCj4+IMKgwqDCoMKgIHNwcmludGYoKSBpcyBkZXByZWNhdGVkIG9uIERhcndpbiBzaW5jZSBt
YWNPUyAxMy4wIC8gWENvZGUgMTQuMS4NCj4+IMKgwqDCoMKgIFVzaW5nIHFlbXVfaGV4ZHVtcF9s
aW5lKCkgYm90aCBmaXhlcyB0aGUgZGVwcmVjYXRpb24gd2FybmluZyBhbmQNCj4+IMKgwqDCoMKg
IHNpbXBsaWZpZXMgdGhlIGNvZGUgYmFzZS4NCj4+DQo+PiDCoMKgwqDCoCBTaWduZWQtb2ZmLWJ5
OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+PiDCoMKgwqDC
oCBSZXZpZXdlZC1ieTogU3RlZmFuIEJlcmdlciA8c3RlZmFuYkBsaW51eC5pYm0uY29tPg0KPj4g
wqDCoMKgwqAgW3J0aDogS2VlcCB0aGUgbGluZWJyZWFrcyBldmVyeSAxNiBieXRlc10NCj4+IMKg
wqDCoMKgIFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNv
bkBsaW5hcm8ub3JnPg0KPj4gwqDCoMKgwqAgUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4+IMKgwqDCoMKgIE1lc3NhZ2UtSUQ6IDwyMDI0
MDQxMjA3MzM0Ni40NTgxMTYtMTItcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4NCj4+IMKg
wqDCoMKgIFtQTUQ6IFJlYmFzZWRdDQo+Pg0KPj4NCj4+IEkgcG9zdGVkIGEgcGF0Y2ggd2l0aCBt
eSBTLW8tYjsgUmljaGFyZCB0b29rIGl0LCBpbXByb3ZlZCBhbmQgcmVwb3N0ZWQNCj4+IGl0IHdp
dGggaGlzIFMtby1iOyBJIHJldmlld2VkIFJpY2hhcmQncyBjaGFuZ2VzIChhbmQgZXZlbnR1YWxs
eSBtZXJnZWQpLg0KPj4NCj4+IGNvbW1pdCAwZmU0Y2FjNWRkYTEwMjhjMjJlYzNhNjk5N2UxYjkx
NTVhNzY4MDA0DQo+PiBBdXRob3I6IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJv
Lm9yZz4NCj4+IERhdGU6wqDCoCBNb24gSnVsIDE3IDE4OjI5OjQwIDIwMjMgKzAyMDANCj4+DQo+
PiDCoMKgwqDCoCB0YXJnZXQvbWlwczogQXZvaWQgc2hpZnQgYnkgbmVnYXRpdmUgbnVtYmVyIGlu
IA0KPj4gcGFnZV90YWJsZV93YWxrX3JlZmlsbCgpDQo+Pg0KPj4gwqDCoMKgwqAgQ292ZXJpdHkg
cG9pbnRzIG91dCB0aGF0IGluIHBhZ2VfdGFibGVfd2Fsa19yZWZpbGwoKSB3ZSBjYW4NCj4+IMKg
wqDCoMKgIHNoaWZ0IGJ5IGEgbmVnYXRpdmUgbnVtYmVyLCB3aGljaCBpcyB1bmRlZmluZWQgYmVo
YXZpb3VyDQo+PiDCoMKgwqDCoCAoQ0lEIDE0NTI5MTgsIDE0NTI5MjAsIDE0NTI5MjIpLsKgIFdl
IGFscmVhZHkgY2F0Y2ggdGhlDQo+PiDCoMKgwqDCoCBuZWdhdGl2ZSBkaXJlY3Rvcnlfc2hpZnQg
YW5kIGxlYWZfc2hpZnQgYXMgYmVpbmcgYSAiYmFpbA0KPj4gwqDCoMKgwqAgb3V0IGVhcmx5IiBj
YXNlLCBidXQgbm90IHVudGlsIHdlJ3ZlIGFscmVhZHkgdXNlZCB0aGVtIHRvDQo+PiDCoMKgwqDC
oCBjYWxjdWxhdGVkIHNvbWUgb2Zmc2V0IHZhbHVlcy4NCj4+DQo+PiDCoMKgwqDCoCBUaGUgc2hp
ZnRzIGNhbiBiZSBuZWdhdGl2ZSBvbmx5IGlmIHB0ZXcgPiAxLCBzbyBtYWtlIHRoZQ0KPj4gwqDC
oMKgwqAgYmFpbC1vdXQtZWFybHkgY2hlY2sgbG9vayBkaXJlY3RseSBhdCB0aGF0LCBhbmQgb25s
eQ0KPj4gwqDCoMKgwqAgY2FsY3VsYXRlIHRoZSBzaGlmdCBhbW91bnRzIGFuZCB0aGUgb2Zmc2V0
cyBiYXNlZCBvbiB0aGVtDQo+PiDCoMKgwqDCoCBhZnRlciB3ZSBoYXZlIGRvbmUgdGhhdCBjaGVj
ay4gVGhpcyBhbGxvd3MNCj4+IMKgwqDCoMKgIHVzIHRvIHNpbXBsaWZ5IHRoZSBleHByZXNzaW9u
cyB1c2VkIHRvIGNhbGN1bGF0ZSB0aGUNCj4+IMKgwqDCoMKgIHNoaWZ0IGFtb3VudHMsIHVzZSBh
biB1bnNpZ25lZCB0eXBlLCBhbmQgYXZvaWRzIHRoZQ0KPj4gwqDCoMKgwqAgdW5kZWZpbmVkIGJl
aGF2aW91ci4NCj4+DQo+PiDCoMKgwqDCoCBTaWduZWQtb2ZmLWJ5OiBQZXRlciBNYXlkZWxsIDxw
ZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+PiDCoMKgwqDCoCBbUE1EOiBDaGVjayBmb3IgcHRl
dyA+IDEsIHVzZSB1bnNpZ25lZCB0eXBlXQ0KPj4gwqDCoMKgwqAgU2lnbmVkLW9mZi1ieTogUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPj4gwqDCoMKgwqAgUmV2
aWV3ZWQtYnk6IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4NCj4+IMKg
wqDCoMKgIE1lc3NhZ2UtSWQ6IDwyMDIzMDcxNzIxMzUwNC4yNDc3Ny0zLXBoaWxtZEBsaW5hcm8u
b3JnPg0KPj4NCj4+IFBldGVyIHBvc3RlZCB0aGUgZmlyc3QgcGF0Y2gsIEkgcmV3b3JrZWQgaXQg
YW5kIHJlcG9zdGVkLA0KPj4gUGV0ZXIgcmV2aWV3ZWQgbXkgY2hhbmdlcy4NCj4+DQo+PiBjb21t
aXQgYzQzODBmN2JjZGNiNjhmZGZjYTg3NmRiMzY2NzgyYTgwN2ZhYjhmNw0KPj4gQXV0aG9yOiBS
aWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4NCj4+IERhdGU6
wqDCoCBUaHUgSmFuIDE4IDIxOjA2OjMwIDIwMjQgKzAxMDANCj4+DQo+PiDCoMKgwqDCoCB0YXJn
ZXQvYXJtOiBDcmVhdGUgYXJtX2NwdV9tcF9hZmZpbml0eQ0KPj4NCj4+IMKgwqDCoMKgIFdyYXBw
ZXIgdG8gcmV0dXJuIHRoZSBtcCBhZmZpbml0eSBiaXRzIGZyb20gdGhlIGNwdS4NCj4+DQo+PiDC
oMKgwqDCoCBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJz
b25AbGluYXJvLm9yZz4NCj4+IMKgwqDCoMKgIFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhp
ZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4+IMKgwqDCoMKgIFJldmlld2VkLWJ5OiBS
aWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4NCj4+IMKgwqDC
oMKgIE1lc3NhZ2UtaWQ6IDIwMjQwMTE4MjAwNjQzLjI5MDM3LTEwLXBoaWxtZEBsaW5hcm8ub3Jn
DQo+PiDCoMKgwqDCoCBTaWduZWQtb2ZmLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxs
QGxpbmFyby5vcmc+DQo+Pg0KPj4gSXMgdGhpcyB3b3JrZmxvdyBtYWtpbmcgc2Vuc2UgYW5kIGFj
Y2VwdGVkPyBPdGhlcndpc2Ugd2hhdCBzaG91bGQNCj4+IHdlIGNoYW5nZT8gTWF5YmUgY2xhcmlm
eSBhbG9uZyB3aXRoIHRoZSB0YWdzOyBvciBpbmNsdWRpbmcgYWxsDQo+PiBNZXNzYWdlLUlkIGNv
dWxkIG1ha2UgdGhpcyBlYXNpZXIgdG8gdHJhY2s/DQo+IA0KPiBDb21taXQgZWRhNGM5YjViM2Mg
aXMgdGhlIHNpbWlsYXIgY2FzZS4gWmhlbnpob25nIGFuZCBDbMOpbWVudCB0b29rDQo+IHRoZSBw
YXRjaCBmcm9tIG1lIGFuZCBJIHdhcyBjY2VkIHdoZW4gWmhlbnpob25nIHNlbnQgaXQgb3V0LiBJ
IGdhdmUNCj4gbXkgci1iIGFmdGVyIHJldmlld2luZyBpdC4NCg0KU29tZSBvdGhlciBjb21taXRz
IG9mIHRoZSBzYW1lIHNlcmllcyB3ZXJlIGluIGEgc2ltaWxhciBzaXR1YXRpb246IA0KaW5pdGlh
bGx5IHdyaXR0ZW4gYnkgbWUgYW5kIHNsaWdodGx5IGNoYW5nZWQgYnkgWmhlbnpob25nLg0KVGhl
c2UgYXJlIG5vdCBjYXVnaHQgYnkgb25lLWxpbmVyIGFib3ZlIGJlY2F1c2UgSSBkZWxpYmVyYXRl
bHkgZGlkbid0IA0KZ2l2ZSBhbiByYi4NCg0KQWNjb3JkaW5nIHRvIERhbmllbCBpdCBzZWVtcyB0
byBiZSBvayB0byByZXZpZXcgYSBjby1hdXRob3JlZCBwYXRjaCBidXQNCmlzIHRoaXMgY29uc2lk
ZXJlZCBhIGxhc3QgcmVzb3J0Pw0KDQo+IA0KPiAtLSANCj4gUmVnYXJkcywNCj4gWWkgTGl1DQo=

