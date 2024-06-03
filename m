Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B879C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0jf-0006hF-34; Mon, 03 Jun 2024 01:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0je-0006gC-6o
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:59:58 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jW-00070x-Ck
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717394390; x=1748930390;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=9V+ITKOwivB3WpSM4vWz06iTWbCEdI4Pz9nZEsLjbws=;
 b=fQyUQHs6lHUEv6MAlu7eA3GtqLvBzOu0ul5NTTJreL2DMCq9wkO1vCb8
 RVFcTKgIkst14uvL9HHwYcbf6AmvQ/ngXCB5+WeyrGQpSPF2oOOXcBqld
 dlG5mXP9k4ShSe5JttdWOFx7wTvTNWVCldT6Q0eR0qEYOw7c8pbFLD24y
 YCzSXn8dRxS/m6QCJPJIY4bKzxWcUQzfu/DnbOt/N89fZ7uaHckj5N5Mp
 KCH4uYquaCEusHbDvCKSCTDSNbrtXoGAtSMohUzWTh7tdWamilfjshgxD
 +6JFEVTJGIjCu8Sdd6kyVtPQbII0bI+ZNNqOLwNBEDe8rL0jzd2wOxA1a Q==;
X-IronPort-AV: E=Sophos;i="6.08,210,1712613600"; d="scan'208";a="13815874"
X-MGA-submission: =?us-ascii?q?MDELUMXNaR2qJvNM0/e37gNaiSptRUUWZN0GwV?=
 =?us-ascii?q?CrHdFUcuzEt0oR83a8u63WxHV7QipxBHPBGxaBiy6dSDD3gmIgj0TdP2?=
 =?us-ascii?q?IBzZqWV8MmA7PGUg8/AF1tHlpjIEPiOBkgcmuEH21RjX9MgL65q1vCCG?=
 =?us-ascii?q?ZrCmzsGXxUs73LCOOXxzodXA=3D=3D?=
Received: from mail-he1eur01lp2050.outbound.protection.outlook.com (HELO
 EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.50])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 07:59:46 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giQ5aXmPZbSAoSVQrSL5TVHWLBVWW6fw55foRzab4T/jABOCFCkIpQCokSXNwq+LB3P1nezsKyNIrgD+RGIkArM8rtW3qDCu9PLr2kEQO/DGnHoom+aUQHDKVrMSgXiglqnAZWxmzBpVtKDT9IKZVd6uuq2mqdh+lnqgGqtWrIMFY/qPXAGQXeFvBTvpy1/ZAfbsL6BBsXdSbirdn9AFu23qHdM3sYThF2cmbyVTzw8m3dZxUgD0HwVBaCBVrTZCC/v1aYkxF9LiG/JAmeBH7l59OZu8b6vVPrFMO3QRxcWRhDP1qEPVDqVHVNbsfGhVF+FucJlBjgC1pAX5f17J+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9V+ITKOwivB3WpSM4vWz06iTWbCEdI4Pz9nZEsLjbws=;
 b=MrVqWE52W6ZZx11tEuNsUcc3SIk+mIquKqoSZXsX+BmoCIb26ESnjQDffxStIEh33CG42/+FhZctaIWvAxidifjb7R9N0/dd53w3eXPp1eO7T+IM7j5t7tqcga2HO43A9Q5F9ayPx2ZJUAtVKI77OyWEtEaXzSZVDqgLnxTIdNm2QVGyQRauvBENDbJxtx41B3wQ/UEodYGCMykPJke3yNjKqgh0HoLogjU2b0o8v1gjyaJQcWcN+S9MBOAEA9aHvN9ZAoQcu9cM/3v94+m/PvlJVRWub6Zjnj37Ldsn9HPKFtUSaHORhtd04TpDF2FprlnETzmDELtKoSDD9uRQ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9V+ITKOwivB3WpSM4vWz06iTWbCEdI4Pz9nZEsLjbws=;
 b=FfZQrfF6M20UpTIoWpeKY7Eif9AeRxWiX2TM9mrv5n3ODp8TEjOI17DOq+1YjcdPPxiO9QHmiuP2Jq+tJmZB7q5NeYWBeR9Wk9haeSe0C/+6ipksLESsMTOiEg4ArRcC0uknW+w3Kfkt3W6xQk4Wzc3jLucuZSGoSpgSJZ+IQPeZ4btMtpmDd53f72YtTay1qcznJsU/jsOVzCof87DEehfnjcvDkLl/6uxfpjuqDXsikYPEs39o97NApJjalFBsmaex/czB4qwt22mAjiBw/WfgP413tiM+R2gbiZ6nQQyF+9Ss/NaCHyF0BXJYOF4hR7NvLdAF8kAg+3vMzgaAsA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6238.eurprd07.prod.outlook.com (2603:10a6:800:136::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 05:59:43 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 05:59:43 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 04/22] intel_iommu: do not consider wait_desc as an
 invalid descriptor
Thread-Topic: [PATCH ats_vtd v5 04/22] intel_iommu: do not consider wait_desc
 as an invalid descriptor
Thread-Index: AQHatXs6STwkuNSoKUS08HQc0nMsEw==
Date: Mon, 3 Jun 2024 05:59:42 +0000
Message-ID: <20240603055917.18735-5-clement.mathieu--drif@eviden.com>
References: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6238:EE_
x-ms-office365-filtering-correlation-id: 9d9d7125-07c9-4199-9b58-08dc83925d14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VGxOUEVPbEZLSkZNKzh2a29EdU1hMnhidTlWQXNtU01FaTJZTTY3RTF6UkVJ?=
 =?utf-8?B?SEcwek91bnVyUWplRFRLOEVKSEZVc2MxSlhJWm5Yem5hVXdsNDFNNXl6VFQ5?=
 =?utf-8?B?TWdDNXFiWktwK1JjOHRPZDJXaFFndGdlVzJ2cnFOZXljMEZOcHBUR2NtQjRV?=
 =?utf-8?B?aWxka0dZMkppMUtmeW1lTTQrTDFDYy9qaHlxbjlYVDE0d3pSOS9jeGJxTW9E?=
 =?utf-8?B?Wjc0eDY2UDV5NHRPNGpYOUR4QjY4Z0VwVWVGYnMyUjJFOUQrTWIxeXByU3hr?=
 =?utf-8?B?a0Q1ZEljeUtKazU0VVhkZ08rZ3o0QkZyQThteFM4VXdjeTM3QTYwdzZaYmUz?=
 =?utf-8?B?c0J3QUd0UW80UHNjOUxXWnBRMEljb1l0TWpGeGlpR2xPZ1pGRHoxQ2xxMDBD?=
 =?utf-8?B?VDU5YnVTd0dGb3pnS00vd2RaQThRb041RWtUY0FmdnpObGVTOVVrd1RLRjJW?=
 =?utf-8?B?aC9ORmZ0dlZoMnNnRXVuaXJRZHBEUVNSaUc2TWdlZEJrUCt1YmVEL1E4Sm1S?=
 =?utf-8?B?VVh0RjV6Nk9kYS9VWW5wSXVXaDNZTTJPZG1ma29KU0NxeExIbFQwSEVELzJq?=
 =?utf-8?B?dnErRzd5SEsyR0dtUWVYVnZYUXZCOEFjYjZRY1NUcDRCVk5XU2plSHorbEJw?=
 =?utf-8?B?bnBnUGYzdm1pSG5NZE5aMjdyT0REZXVFdWczUHdBSHg5MXg2bXcwN1MzNUJQ?=
 =?utf-8?B?Q01TUXhYTlBzbGlnNURDbnd3NzhpUGlzM1NERk9ieVExMXlVRVRGc29nMk40?=
 =?utf-8?B?R2NZZGRGUnY1ZjFtZ2FqbFIvYVpCdUxlR0ZqZDBQMmVEWkIrOVYxVEtqcEdv?=
 =?utf-8?B?N1RHL3pTUCtsY2dDRFFTS05aQXVja2huQzZpcjJzanZZWEo3SGNMZThTWUpl?=
 =?utf-8?B?TmhVVHJCZ2ZCWTZkVFNDWDIxNFVoOXBTM1VHNmJRTHh6L25HY2h1ZE5IUVRl?=
 =?utf-8?B?TGczT2sycjFDakdYV0JVbklEV1BMVGR6bDZFc1Z5QUJIdUFoVFovdjhkSWVk?=
 =?utf-8?B?bjZRbzZjVmdVWmxEcy92WitJS0FJV2h0bkhENllCUkhJSXNVWTRWY2JFQnZG?=
 =?utf-8?B?VVFGeW9ZWjZPMEFjNXF4MUVKNnRZRks3UUxTSzZZWkp3dmF0TG56V3d4SXhQ?=
 =?utf-8?B?ZXRhN0NCeDVteExTbnRTOTZzNjNnVk50dXhsZGEwd1hEcThvb0ZIa29LRXhk?=
 =?utf-8?B?N3JXd0VyZjlkclIwK2RZcmpndThqZGliOFpCRDVET05vd1lYWmZEUnJHVHEr?=
 =?utf-8?B?aVY4My9tNHlaUk5QSmdVVzdBWFVuRGNXNE5NdGZVbm1ZQURjWkNHNTAvR2Zm?=
 =?utf-8?B?UnJQMmkvejdDQ0U5bDdwcHZhcXo5bm0waTNqRVBhRjZ4d29zUjYzVWFjS0lI?=
 =?utf-8?B?TStzNVp6MDhOUnRPOVMwN3IvY1E4OGV5UU1ySHNJN2lkeEI1SitzbFYxdmoy?=
 =?utf-8?B?SnJtME8wdDJxTTJlZllxZ24zUUdIWVVrTUQ4UmZuRytBZGhtRFV6UUI1aElN?=
 =?utf-8?B?NmJXQTFWZlYvTGU2YkhUN3Zhc1VEQm1ZWWxTZ1lmbHp5bFB2elp4QXJYUUE1?=
 =?utf-8?B?bXViKzZqbmx0WDNJY3NBSnY2R0N3WmxpcVAweTFGNXRteHBYZnpXQ2ZLL3Y1?=
 =?utf-8?B?VHZ0L0xyR3lrUG1DWXd4OVlHUHFyTVNjMFI2MUt6WndsanRqU1MwYVhzdVBR?=
 =?utf-8?B?RExtRE9tcFoyVStPUTQ0ajc1N3NsWEk0RWp3SU5yMk1KcFVSSWgxMzNiaUND?=
 =?utf-8?Q?zby14yz1p6pnobS+OquzSjYg6bGguH4VIC6fqkE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlN2VU8yVEZEZk5xa3dDOGFxNU8vQ2d0aTR2SzFyd3M0bDZrTkdXbDVGcytk?=
 =?utf-8?B?UWlLdDE1VHpuL2dkZk92c0N6ZVJ3My9TMUUrSnJVMk5TMVFDOG9xVmJJQTM0?=
 =?utf-8?B?aTJaMEt4VDg0Z000WmVDV3pQanY3d25yYjh0U3lZQVZIU3B2TUlCN0Q3UWNo?=
 =?utf-8?B?eksyTU9MUVA3cmZwVmx3enNjbVMvZWgzUDI3cUZYUkpaQlpOOERkSkZUN25r?=
 =?utf-8?B?Umtoby9DbEN1NWxEd0U4RzVuNG5kT3I3TlI5NHM1VE1VWnBJVXpMZnk5YnNs?=
 =?utf-8?B?QmhZK09lREF0WWx3SXhIODROQ1NRd0VDU3hoUW0zREdzWkthODN3SnZWQUxn?=
 =?utf-8?B?WGRFNlgxVENZbE1LR3J3dGJZckF5cWtPWjc3TVExZFo4eDNGWlBURVJWM2RS?=
 =?utf-8?B?Rm9NdE83bDE3OUZuVkJoYjFXeVkvakF2NklDN3FlOVFnL2gxWEFSc2tjdWNa?=
 =?utf-8?B?S0VqZHlhNDE3cFNVdzVWdmt1QWpQU2x3YndtMmoxWHd1dU1WODVzazlhNFVL?=
 =?utf-8?B?ZGRjQmRYVEVqN29QNU9UVUhMUmVBMkxWTGs4S3ZFZlJZOVo2NHdSVTNscFFv?=
 =?utf-8?B?L1FaT1ZZMnJpZVF5SkgweUJSMkZKYkY4ZW85SDFpM3hKNEhMaWFBRnk4a0Ev?=
 =?utf-8?B?VWxMVjBSWjJUU3VEL1BRdCtJV0ZBQStLemo3aVM2Z1JJNjloNHJuUVdtL0ty?=
 =?utf-8?B?R3B3UklHOUtGZUJrMlhCaDhkOVBTK2R3M0VLbUVCZ21GWUE1Ujc0RVhZQVlN?=
 =?utf-8?B?dm5xeDBuQ3pQTlREMVdKQ2VZOFlWa2JzRDFZWDRyZytWeDhJdlFma3dMS25P?=
 =?utf-8?B?MktpM0NDeGc3dGtLU212clBndHZhNTFzNGVNTEdoN1Z3d3UrVFNXSEhRa21U?=
 =?utf-8?B?YXJUUDcrRXdjUkZvV0FneTJKRDkrWkNjcEZMNHNrZ1FWTTJvOUd6a1Z5NG0y?=
 =?utf-8?B?eXhuUTJQQzhRZjdtcDFpUUNORlo2Lzd0MC8xRjFTY01jbTMvVWhCcVFVQTgx?=
 =?utf-8?B?SS91WnYxc0VNL0N5b3NSTVQwMitwY0cyc3c0UWhNeVdCcldYWk9KZ2d1ZVF5?=
 =?utf-8?B?cVRVSFZCZ293WTZTOXZXMFpNNGx4Y1cvYVpuNTVvdXgxN2NMZUtZa0s3TGFj?=
 =?utf-8?B?ZWtNMmc1R0ZaZHlHeEJUbGRmejA4ODdUdEVrc1czTk80TXg3OTJtVWxsY0hP?=
 =?utf-8?B?UkcrU1c2MktZTFYxOU53ZnJCS0tOV2FSZkcwY2Z5bUdPZ05qRzhKSTE3V1FD?=
 =?utf-8?B?dzNnQWxrb3NVRmx4UTRPWFhNUHZYOExRbUplZGxQcjd3aWRORWxsaDUzbWla?=
 =?utf-8?B?SkZBdlZxdWVhR2sxcTk1bHZ1MjJwS3JqZTR1OThJZENJVURPM3lXYWpmb3lv?=
 =?utf-8?B?aWYwWjJKRyt2NG1vSERaSldsWDJYL0tWZGhvdDNtcGxnajcvakNuSEtpeWUv?=
 =?utf-8?B?cXcydDg2RDdWT1J6bE11UVR0OGg3a2lwZC8ra0p3WEkrZkJyRVoxc2hqV0xW?=
 =?utf-8?B?NVJZMmVQVjBrNnZGWGlLVVQzVUdzYmlzQUEwd240M0c5VjBKUGJPbUJBdEcw?=
 =?utf-8?B?RXBUVStGK0pDRmxHdzd2RkJIcHV3OFpSZVpydGJuS0RyM2FoYklUdGZYb0pl?=
 =?utf-8?B?ZEgydElWdWFJZGgxV0JqVjVQTTNsV0I3aHgwY21FM0FmVHBYYkUwWUo3NEVx?=
 =?utf-8?B?ZzZabW9GYnlPaXJCd0xyZkNEMFdlc3VWNlc5bU5KSTVQWWZaTnBtTk1Rd1E1?=
 =?utf-8?B?VUZhTjh5cnlRVXQ3T1dSaW1IeEpSS29XNklPc0I4Y1VNOFpGK29IT2ZkVktw?=
 =?utf-8?B?V25SWVhzRnUzR3E4RWtnb3NXTkF6TjUrc1FrMWk1UitFQ0NjWjJiVGY4VE9I?=
 =?utf-8?B?YWhmbW9la0xtYkIrS0x2TzNxYnhJRHdhQUdreTNKaWV6cWVDR0RweDM4WFZB?=
 =?utf-8?B?WlJFOGJHTTNQbU5YaHNjSGdrNm5JOFA1bUJVWCtlNHhCL004dVVFcGs0dmJw?=
 =?utf-8?B?YVZrU0hiTXZldHV5R250UG1GQ1ZKNDlRcjNrSEd1dnNDM2l2c2VDSzZxWFZU?=
 =?utf-8?B?aVJaQmxrYldKbk5nN1JPZ1hucSs1R1VFd2ptWlJHY3k4Wkx0TEhNekF6cWJP?=
 =?utf-8?B?TE04VUsxM1Q0VlZycXhDQ05RSk04cFRLUDAwM2hGcUErTFdJU2t2R3dDTkM5?=
 =?utf-8?Q?XSBAIT7a61HHCrYKuGj+vLU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <769C54D3776AE84C8A333583ACA9E0FF@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9d7125-07c9-4199-9b58-08dc83925d14
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 05:59:42.9674 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4iEgP0XEJorF9sd5+TCKOKmVE1BN6QdfOQVChRXZe6Jq2pLsRqPVpaUEhPGQaCqqzBhxnmKhuzUoZcd4jGP/B4ln2jZOFWB8SYSaeIjfC0h8BbXwGktlFdgZzlLmwtfV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6238
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQu
bWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KUmV2aWV3ZWQtYnk6IFpoZW56aG9uZyBEdWFuIDx6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgfCA1
ICsrKysrDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEv
aHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQppbmRleCA3NzJi
MWNlYTg4Li43YjBjMjJmYzA3IDEwMDY0NA0KLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQor
KysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCkBAIC0zNDc2LDYgKzM0NzYsMTEgQEAgc3RhdGlj
IGJvb2wgdnRkX3Byb2Nlc3Nfd2FpdF9kZXNjKEludGVsSU9NTVVTdGF0ZSAqcywgVlRESW52RGVz
YyAqaW52X2Rlc2MpDQogICAgIH0gZWxzZSBpZiAoaW52X2Rlc2MtPmxvICYgVlREX0lOVl9ERVND
X1dBSVRfSUYpIHsNCiAgICAgICAgIC8qIEludGVycnVwdCBmbGFnICovDQogICAgICAgICB2dGRf
Z2VuZXJhdGVfY29tcGxldGlvbl9ldmVudChzKTsNCisgICAgfSBlbHNlIGlmIChpbnZfZGVzYy0+
bG8gJiBWVERfSU5WX0RFU0NfV0FJVF9GTikgew0KKyAgICAgICAgLyoNCisgICAgICAgICAqIFNX
ID0gMCwgSUYgPSAwLCBGTiA9IDENCisgICAgICAgICAqIE5vdGhpbmcgdG8gZG8gYXMgd2UgcHJv
Y2VzcyB0aGUgZXZlbnRzIHNlcXVlbnRpYWxseQ0KKyAgICAgICAgICovDQogICAgIH0gZWxzZSB7
DQogICAgICAgICBlcnJvcl9yZXBvcnRfb25jZSgiJXM6IGludmFsaWQgd2FpdCBkZXNjOiBoaT0l
IlBSSXg2NCIsIGxvPSUiUFJJeDY0DQogICAgICAgICAgICAgICAgICAgICAgICAgICAiICh1bmtu
b3duIHR5cGUpIiwgX19mdW5jX18sIGludl9kZXNjLT5oaSwNCi0tIA0KMi40NS4xDQo=

