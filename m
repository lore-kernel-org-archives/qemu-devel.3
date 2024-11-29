Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D597D6EBE7
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 07:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGvfl-00083J-6e; Fri, 29 Nov 2024 02:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfh-00080x-PU
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:44:13 -0500
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvff-0002nD-0p
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:44:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1732866251; x=1764402251;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=s5ra5nffzHwWucxF5rmuojk/qIU0y66Gpw4WdaZBVd0=;
 b=X/Uh2yzSLFN3G4pG4cWPzOl6nDUeTnd2gFq7R7lANGwS6AzfCQhZ5N0o
 LOozQf5DTq2mBRmxbX8v4Ed9z/9S8RZmzDLgdZZPm3bzS56A6loNeVX6e
 vVjh8lukKU5Vas69Pj2IYCqUnNz3PlLOu15Ye3D2Kv4JDaKzPyXD5+1fq
 fQ5lDqwR7/z7FF3jK0NyaPkhbmx28ZEHsNAla03+Zuu6yNlmxIhaO6MVY
 g/vbcnQqoTlpKlVgakQx8r0W7eoJ0O5CyZ9TVcrCHuq2CCV8QUnBL+VNA
 0H3bdkNnFtx9OL1C9aBCm5X3dclXDD13nzEguK+hra0Sm+HkxJp2a39O0 w==;
X-IronPort-AV: E=Sophos;i="6.12,194,1728943200"; d="scan'208";a="25670819"
X-MGA-submission: =?us-ascii?q?MDFBYtm2nTryqGVqbqEqJ+4E61ZhYjamntoaGs?=
 =?us-ascii?q?4GtZndf1fO+3g1tWDPSFycxJfeLKhYoMFOIiptmek6CMKlquTGhMV54g?=
 =?us-ascii?q?PKdaA8mKysGxcwz00bUt/3LK25fPI3vcY774INHmFBpLKD3F/oYJuzl/?=
 =?us-ascii?q?iww3YsB4QqJjpNFqGgxkcq1A=3D=3D?=
Received: from mail-norwayeastazlp17013077.outbound.protection.outlook.com
 (HELO OSPPR02CU001.outbound.protection.outlook.com) ([40.93.81.77])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2024 08:44:06 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hidjWI2pFU2D8aENcoH/HfQ8RX0gNhBjj/QPigMBOKzMl8/FbRYxPBZq7PT+mehEe0jIqE5xY08g79+4WJHVYw47ODd68lteBAgXkUMeZj/AdZl0siB71Wv5rWjZl78BR5SXbPEmrT6nhQJVC88xqJzDeWHmux00xHDzuSTA1aH7N8PcVnm1DgtpHTDfct8OgC4p+ib8YlO/dPYhQV3fCeB0aNU6ec8iuKd5DnHWv8XvLHrTWr2ALM9ymRwsELN+mgAiw0xIfEMWkroOo5FzhoOWZ3+gJ9d1YTl4oa/9mcg4JyyCeK/4ErLVmIJxBlJzAncVO0QjDMPS2p0TC8oNHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5ra5nffzHwWucxF5rmuojk/qIU0y66Gpw4WdaZBVd0=;
 b=eszkPwTs3OUJ2av9kYv090608XM/Dw86AzrVu71aZbZBJoLfBtcBZtczwNq5mqnIz1KoYqdqedjrJV6aDahTPmFmOc2ecG3/babKFckOw28kbYSouPLPl5RFDjwajK522HQyk4MqGRc/XX3vR++962XvVJ8csQkyHfSUBmML1+H+gnLrR2IxQVoKnLkV4IqXWUl6YMs3i3Oi6RigUNTCFQsf+1SIEF4Sg8G8eNXDt+rEdUx5XmMCAfeJTy+/pcU0+OvipihTl1xSH/7r3rm+YokbADde04eVuqCXXwJdyxDz0E9xeYZrQUZvklA15TwVs5J4voJOXAFZ09P74/1yvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5ra5nffzHwWucxF5rmuojk/qIU0y66Gpw4WdaZBVd0=;
 b=I5QiU/wGBIn3gIXhHjEYMgn3HSSikylXgceWqe0QbMP75ot949FVWMyMLmXH0WyJcBUnRqMO+kavRWddV3HR3E9iPU5+Ibpx/VeGkbtMEq4P7RRx9VHR5g4ildhoQtpETRbbfIqVySJl2AtW7qk9i5uEGx334ZREnalkWkR9BWmHTQwNrjvrE/hKOjJokUCktmuv56n/mOpsHA9pfzUjNPjxqj6OojbbAXI/Ou6pA66axl84fhgHjLHttYLhqK0EgtdD8dKQL/J+Jga1EtQ2MyYmUxyveiIsWe+0j+RIoL57K1Mc+VbFMxWREk8YNF103pWxPb1v8+je4KgG7jR6Ng==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6414.eurprd07.prod.outlook.com (2603:10a6:800:139::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 07:44:04 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 07:44:04 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v1 18/19] intel_iommu: Return page walk level even when the
 translation fails
Thread-Topic: [PATCH v1 18/19] intel_iommu: Return page walk level even when
 the translation fails
Thread-Index: AQHbQjJ2eyRaO/QBnEG/q4DtvF0FWQ==
Date: Fri, 29 Nov 2024 07:44:04 +0000
Message-ID: <20241129074332.87535-19-clement.mathieu--drif@eviden.com>
References: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6414:EE_
x-ms-office365-filtering-correlation-id: d5e78ae4-1e45-484e-3194-08dd104998ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?a0dlTFVzRGVHeWJqcWdmc2xzdm9yVm1WVW8rU3d5V0Y1eWF4V25LZWZHYmJY?=
 =?utf-8?B?VXByUXhsUDVTd2pBeEN1N0ZhOWVQTm9TMGU1akFMMzIxM0VrS0xLNUxoMTAz?=
 =?utf-8?B?U0x0NEJ2dTlCTldWV2paZkl5N1lpbjhSQTF2ODdYc3h0TWtoYUU2a1pYcXY4?=
 =?utf-8?B?VjNJR3NCYktzMGQrQnkvVC9iU1VzRUZaMFpPbERlQ25tRjN0emQwSTBOeURh?=
 =?utf-8?B?eGdIZkxFL1BDbmU5bmxHclJQZFRPNU5NNGsrMzdTUTVUNFdQT25sQVMvdkhq?=
 =?utf-8?B?cnA3ZVpPZCtFZ3llWFZNQTJ3WDlKbFNkK25ZbHJyd2R3Q1B5LzFFUzAxYXVN?=
 =?utf-8?B?QnRwUnRsT2ZTMG9OV3J3V3RzcWFld3dERktadG53VzI4dWx1b0RrUDdJTVBz?=
 =?utf-8?B?bUllQ2xzaFdpRFcyRkFkTHFCdmYwNWgwUmNoTE9DVmpjUUJoWm13N1owSlht?=
 =?utf-8?B?eGQ5RXMvQnhiT1VZZDVUK0hXMzBHNDdJZ1JJNkdjQ2ZwdEU0ZE16eERQbUdv?=
 =?utf-8?B?bW9UVE1tbWRiN2xQb212RHNiTXpZclNaOEZ3dmQzWHlhU3d6TXFqZjIzNVRu?=
 =?utf-8?B?Mys0dWZMU0JWYlM3RGs5djR2ajdVSmhqRzdyTU1pUUZSbmt6VlorV1NRRThM?=
 =?utf-8?B?TUVHZXErOWhkekdpeG9pa2VUaENQTlg2S0JmM01wc2Uycm05aW96Z1pTVjI2?=
 =?utf-8?B?dStzck1ZVmVGQ2RMOXMwSzB5VkpuUzgyQ09lVTVNM01PL05xdWNsTVFFNGNB?=
 =?utf-8?B?bUMzQ3MwUW9jZXQ1cFpLck56YWpUSlRldERiZ3FjM2VFTFhXeWdYNmZMQW9y?=
 =?utf-8?B?cGVrNmQxdHd5aHpOc3ppYXpoUmRSRGwwWVEyZ1F1Zk1GM0ZvYVFQWUo0VG5I?=
 =?utf-8?B?MEswVzhMNXh4RVFod0tFekhtenRjS0dUUS9LRmQ3ak53SXNVcmxwZUg5N0hk?=
 =?utf-8?B?bFVyZWpTbGNzYUdpY2xzcFhmSmcvSnpIenF4NHdQNm1PNjN1NTNlMkszZGhV?=
 =?utf-8?B?bUFZWUJlTVlkV0tXV0tnWDR5QVcvWTdFL0NwcmZnYUJyT0h2UHl4L3pKR0dV?=
 =?utf-8?B?WmFId2xXL1FQclZmZlplT1ZNZTFMb1QwaDFXREV2TDlYdnE4T3lCRGRoeGd0?=
 =?utf-8?B?dlV0bUw4bUwvUjRSdHZGNjJrMndtNENuYmNWRTMxSnIwdStncjduMUFwdFh3?=
 =?utf-8?B?SHM1T0RZR1FaVGl6VUlkTlRlTk85L2pDKzBJS3ZFaUROemg2UHlBSDE5YkUz?=
 =?utf-8?B?WDFtZTFydFJ1QXlJdU9zajNHR1FkZk1TMHpKVVV4ZUhMOFJoMGR0SjJqU042?=
 =?utf-8?B?dURvZTN1ejIrMzBQancxMktKSFRBQlVyN2RhYitvWmRzdTMvTVpjMVN1OTAx?=
 =?utf-8?B?d3dUNjVhRERGV0FqSVRNK0VZd1FRRU5WTEJqTWdua1Rqb010eDdJOHB4MUx0?=
 =?utf-8?B?WWZlQ2FEdjFKMHZPTGxic3F4bE5oYkx6Z1NUUTV3cUpwWlA1bnZIY1JXci9T?=
 =?utf-8?B?c1pBUG84QU1ML1gvNnZZKzlsZjlrVm5xa3VwNmVxSGtVNEJEVVhzd2NBM3Vs?=
 =?utf-8?B?WWprbHNlYVFvYk9ZOTJPYnpqZlBiVm5FUDN4ZTV2b3A2Tzk0MlFwVkFZM21H?=
 =?utf-8?B?NytrbHlCVmFWVklZVDhBQjJCYXlVRHM3aDY5Q2JjZ0l6MWpWWVEyV3FQMlhU?=
 =?utf-8?B?K1RhRWhTNTB3L2pyVmhBTCtoNW5YN0xSb2dHdnNNdnBLV1RyQ1l5cFBLS0V0?=
 =?utf-8?B?ZXFiamwzdTI1T2VEODBnZHh0aXhncHFBQjFKeHR4eXBtZjJqVDk5UytoT01v?=
 =?utf-8?B?Wkw0Qi8zZnFmbTV3Rmh0bkhIWVlhZDQ0OWFoVFg4dUdpbkYvV0J5WEtVOGYr?=
 =?utf-8?B?QkVVY1BTUVdqazNQQzFWVHliOStwOWYyckdvb0hxQTNJZHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1FoQ3REMk1MUXRvNzYrZWorQWkrNERFcmJqOXdwcWh2V2dkYzB3UmwrZ2hZ?=
 =?utf-8?B?Mkw4ZGRmdXR3N21leDhHTFZjWVVKZ3ZFUUdsZ1htR09WVWd3RGRoUG5tTGo3?=
 =?utf-8?B?Q2tTR2o2bDFwWDg5NUJ1WmNoN3JXM0gwcWR5c2h0eHp2UVVIeWQyQW8rMFZu?=
 =?utf-8?B?VDUwTGFpVStWVG1jbkJGT0JCTnpBRkxxck82YVM5SE16dHpPdW1RT3dGbXNn?=
 =?utf-8?B?dTg2bTVvVlg5YS9taFhNTEdjR1VYWlkxajJBUklraUtpTUpyVDh0cmlucjRR?=
 =?utf-8?B?dkNFaEEyVm9XZWN5MlptTEdxUGJyQzVEM0pNT05WQkk1L01VbVV4N3JKNndh?=
 =?utf-8?B?OE0rL1RjY0F3cndZeUxnRFJnSzAxb1RiUU9MZXFHenhzeStpRGtHMHhWZGJE?=
 =?utf-8?B?dG1DZnByQjdRL01hNDUwSlAxdVZud3ROcTEzY0JyUWdoaXkrdUJQeWFzWE1a?=
 =?utf-8?B?elloTmdELythQjk4bDkraFZURGx5eTFmNGxaUGpYcENGUzBHTXJhSEl4c0kz?=
 =?utf-8?B?YWIyQ3p4bEZGeXM3VGRPOGhNQUZ3eUo4TmMwQ2wxNXhaVWdiVnFPM2FNbCsv?=
 =?utf-8?B?dGgrWEpWM1Nuc1NmNGhHeEw4c0EyUS84VEdBdGpxeXRBcGlkVndqT2hYMUFJ?=
 =?utf-8?B?TjN6Tno3VkFVN0NaUTcwMDRmT01mZUhsTnJwbFptZ3d1NHBVUGphSEhaNlhI?=
 =?utf-8?B?TmZFYi84QkhPNkQ3dDNQSnZsT2F4K3BlUUFvajNtc01qRVF3VklNREdGeWxa?=
 =?utf-8?B?ZGxtb0FraGtjTlBQY3oxZXdSbEVYU2ZJMUhFQVJvc1dtZ3E4WlJHVUdxZEFS?=
 =?utf-8?B?REdCR3o2RVpHSVR6SVdkTTNUeThtVi9naWoxanFQL2JMK3JndzhKMk1HcEI0?=
 =?utf-8?B?NEw5cjNOVDFuVWVjdjZ2RXUybHVaRDN4OHl4UGRrWDlWakxSSUdjSUxXMUE4?=
 =?utf-8?B?TFBqNDlDZy9oSDRRTlNESHhIS1ZrM29Ubk5FTEJmaW9pSlZ6K0xBQSswL0RI?=
 =?utf-8?B?dTB2dzZVc0t1bFU3ekQrTFErSTAvVEJMa2VabTVIVzZiWnJqSHp5ZjZXQllN?=
 =?utf-8?B?bXdhSE50dlc3ZGxWYjg1eUJhT3NlRFpMc3BDcERsR1pnTmxwUDFieTVGWlJ4?=
 =?utf-8?B?dTR2RnI2QjgxbWtNTDN4QnhucTBkSjlwRUVsM1NOUnNtZEhBZE9kekNkanV6?=
 =?utf-8?B?eFJCMUlaTmNYTzRkUGpxYjlWUkpWdVUvWEt6TEUvbjlMZ0ZUKzU4VU9ZZHJt?=
 =?utf-8?B?ZjlZNjF2VDhYay9kVUk5V3h2Y0tUc2YwaHZnb29IM3hPbEx2d1NUa3doSitB?=
 =?utf-8?B?bjFMVnlEWlV2SUk3OVF0Ty9yQndnNGdHVHV0TEhaYkZvSTh2WGRBTTBuL3hn?=
 =?utf-8?B?dXVrekpWOWFPdEIvaVJ6enV5QUZXcXBTcHZEY2VQekFVWW9BZWpkK1FBeDhW?=
 =?utf-8?B?MGlNN3Vob2lEZHU2bW1IRTB0OEVRRFFJdWpSalFFdjBpZGNIRXlWK2kzNmIw?=
 =?utf-8?B?b29RZ0FaMnR5aHZBd05jZWllaDJldkVjb2k5eENMZ3krV1ZXK0NBeERPVTZs?=
 =?utf-8?B?TXNXS2V5SGNDeW85NzJRdFJPWHRDUG1KT0JWQnA3REdDK3M4ZGsvOWoxSnN0?=
 =?utf-8?B?Q1JDbkpxaGVNWUxSQzB6RDBjRGhUUXdaVjhjSmJpelZQcmRwUGU3NVJtb3FY?=
 =?utf-8?B?aWpZQ1RHR2lUYUVZVTBGZ0F5Zy9tWXhKT3c1emx0d1RacHA0Y0I4ZjJ1VW5k?=
 =?utf-8?B?UTlaR3dXbThQUXZmTytGQWdheTNGL3Y3L1F0QnVydStOb1d2djM1MnpsRkd1?=
 =?utf-8?B?OWNWNUU0Qm1uTnoxbVk4VGM5V3ozRGlld0tPbHNmNVVOTmRWb3ArVXU3UWRM?=
 =?utf-8?B?R0pkaUthM0ZoMy9iLzdOQUdmamZDQXhzcmlrYnFaT0ZtWktZNTZvdUN1ZUVo?=
 =?utf-8?B?YVlOZGQxcmt5aGYyWE5ZVWYycWtQZjNKVmIyUVNWVWEyWmkwcHNsZjBDMjBs?=
 =?utf-8?B?ckxPa21rSU1HZUUxUXNoRlMwV1F3VlpmcVVHNk1aSTIzeFc4TngxSjV5bG9B?=
 =?utf-8?B?RDIycE9pVEZBT28yUnRqZTBFQWRVTVdvS1RpZWVHQnY1NHNweXlHUXVXZXJW?=
 =?utf-8?B?RWJtWkFrWXJKTWR2Ui9tY2dWWHVta0s4L0I4RjNScVd5WXJOeXVzVk9tNGh0?=
 =?utf-8?Q?qpaEsoL8p0f7z19Q0I5BzCY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9237B26B234F9A468753FFD2D0F00C43@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e78ae4-1e45-484e-3194-08dd104998ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 07:44:04.0518 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y1khjslCVar7Y3q2qTY+Y89L+XeMPUoNPgRh2JdXzH3MRK7wn4BBHAhAXZ1PDal2T+MkomVYHB+g3P2iya/4LxFwe8QUnG7KI7lFS0LZRCQS3a6plBAdFh67XjmOnfiB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6414
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNCldlIHVzZSB0aGlzIGluZm9ybWF0aW9uIGluIHZ0ZF9kb19pb21tdV90cmFuc2xh
dGUgdG8gcG9wdWxhdGUgdGhlDQpJT01NVVRMQkVudHJ5IGFuZCBpbmRpY2F0ZSB0aGUgY29ycmVj
dCBwYWdlIG1hc2suIFRoaXMgcHJldmVudHMgQVRTDQpkZXZpY2VzIGZyb20gc2VuZGluZyBtYW55
IHVzZWxlc3MgdHJhbnNsYXRpb24gcmVxdWVzdHMgd2hlbiBhIG1lZ2FwYWdlDQpvciBnaWdhcGFn
ZSBpb3ZhIGlzIG5vdCBtYXBwZWQgdG8gYSBwaHlzaWNhbCBhZGRyZXNzLg0KDQpTaWduZWQtb2Zm
LWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVu
LmNvbT4NCi0tLQ0KIGh3L2kzODYvaW50ZWxfaW9tbXUuYyB8IDE3ICsrKysrKysrLS0tLS0tLS0t
DQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0K
aW5kZXggMDYzNzQzNzU1Mi4uYTNlOTcyYWY3NSAxMDA2NDQNCi0tLSBhL2h3L2kzODYvaW50ZWxf
aW9tbXUuYw0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQpAQCAtMTk5NSw5ICsxOTk1LDkg
QEAgc3RhdGljIGludCB2dGRfaW92YV90b19mbHB0ZShJbnRlbElPTU1VU3RhdGUgKnMsIFZURENv
bnRleHRFbnRyeSAqY2UsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBw
YXNpZCkNCiB7DQogICAgIGRtYV9hZGRyX3QgYWRkciA9IHZ0ZF9nZXRfaW92YV9wZ3RibF9iYXNl
KHMsIGNlLCBwYXNpZCk7DQotICAgIHVpbnQzMl90IGxldmVsID0gdnRkX2dldF9pb3ZhX2xldmVs
KHMsIGNlLCBwYXNpZCk7DQogICAgIHVpbnQzMl90IG9mZnNldDsNCiAgICAgdWludDY0X3QgZmxw
dGUsIGZsYWdfYWQgPSBWVERfRkxfQTsNCisgICAgKmZscHRlX2xldmVsID0gdnRkX2dldF9pb3Zh
X2xldmVsKHMsIGNlLCBwYXNpZCk7DQogDQogICAgIGlmICghdnRkX2lvdmFfZmxfY2hlY2tfY2Fu
b25pY2FsKHMsIGlvdmEsIGNlLCBwYXNpZCkpIHsNCiAgICAgICAgIGVycm9yX3JlcG9ydF9vbmNl
KCIlczogZGV0ZWN0ZWQgbm9uIGNhbm9uaWNhbCBJT1ZBIChpb3ZhPTB4JSIgUFJJeDY0ICIsIg0K
QEAgLTIwMDYsMTEgKzIwMDYsMTEgQEAgc3RhdGljIGludCB2dGRfaW92YV90b19mbHB0ZShJbnRl
bElPTU1VU3RhdGUgKnMsIFZURENvbnRleHRFbnRyeSAqY2UsDQogICAgIH0NCiANCiAgICAgd2hp
bGUgKHRydWUpIHsNCi0gICAgICAgIG9mZnNldCA9IHZ0ZF9pb3ZhX2xldmVsX29mZnNldChpb3Zh
LCBsZXZlbCk7DQorICAgICAgICBvZmZzZXQgPSB2dGRfaW92YV9sZXZlbF9vZmZzZXQoaW92YSwg
KmZscHRlX2xldmVsKTsNCiAgICAgICAgIGZscHRlID0gdnRkX2dldF9wdGUoYWRkciwgb2Zmc2V0
KTsNCiANCiAgICAgICAgIGlmIChmbHB0ZSA9PSAodWludDY0X3QpLTEpIHsNCi0gICAgICAgICAg
ICBpZiAobGV2ZWwgPT0gdnRkX2dldF9pb3ZhX2xldmVsKHMsIGNlLCBwYXNpZCkpIHsNCisgICAg
ICAgICAgICBpZiAoKmZscHRlX2xldmVsID09IHZ0ZF9nZXRfaW92YV9sZXZlbChzLCBjZSwgcGFz
aWQpKSB7DQogICAgICAgICAgICAgICAgIC8qIEludmFsaWQgcHJvZ3JhbW1pbmcgb2YgcGFzaWQt
ZW50cnkgKi8NCiAgICAgICAgICAgICAgICAgcmV0dXJuIC1WVERfRlJfUEFTSURfRU5UUllfRlNQ
VFBUUl9JTlY7DQogICAgICAgICAgICAgfSBlbHNlIHsNCkBAIC0yMDM2LDE1ICsyMDM2LDE1IEBA
IHN0YXRpYyBpbnQgdnRkX2lvdmFfdG9fZmxwdGUoSW50ZWxJT01NVVN0YXRlICpzLCBWVERDb250
ZXh0RW50cnkgKmNlLA0KICAgICAgICAgaWYgKGlzX3dyaXRlICYmICEoZmxwdGUgJiBWVERfRkxf
UlcpKSB7DQogICAgICAgICAgICAgcmV0dXJuIC1WVERfRlJfU01fV1JJVEU7DQogICAgICAgICB9
DQotICAgICAgICBpZiAodnRkX2ZscHRlX25vbnplcm9fcnN2ZChmbHB0ZSwgbGV2ZWwpKSB7DQor
ICAgICAgICBpZiAodnRkX2ZscHRlX25vbnplcm9fcnN2ZChmbHB0ZSwgKmZscHRlX2xldmVsKSkg
ew0KICAgICAgICAgICAgIGVycm9yX3JlcG9ydF9vbmNlKCIlczogZGV0ZWN0ZWQgZmxwdGUgcmVz
ZXJ2ZWQgbm9uLXplcm8gIg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJpb3ZhPTB4
JSIgUFJJeDY0ICIsIGxldmVsPTB4JSIgUFJJeDMyDQogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgImZscHRlPTB4JSIgUFJJeDY0ICIsIHBhc2lkPTB4JSIgUFJJWDMyICIpIiwNCi0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgaW92YSwgbGV2ZWwsIGZscHRlLCBw
YXNpZCk7DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18sIGlvdmEsICpm
bHB0ZV9sZXZlbCwgZmxwdGUsIHBhc2lkKTsNCiAgICAgICAgICAgICByZXR1cm4gLVZURF9GUl9G
U19QQUdJTkdfRU5UUllfUlNWRDsNCiAgICAgICAgIH0NCiANCi0gICAgICAgIGlmICh2dGRfaXNf
bGFzdF9wdGUoZmxwdGUsIGxldmVsKSAmJiBpc193cml0ZSkgew0KKyAgICAgICAgaWYgKHZ0ZF9p
c19sYXN0X3B0ZShmbHB0ZSwgKmZscHRlX2xldmVsKSAmJiBpc193cml0ZSkgew0KICAgICAgICAg
ICAgIGZsYWdfYWQgfD0gVlREX0ZMX0Q7DQogICAgICAgICB9DQogDQpAQCAtMjA1MiwxNCArMjA1
MiwxMyBAQCBzdGF0aWMgaW50IHZ0ZF9pb3ZhX3RvX2ZscHRlKEludGVsSU9NTVVTdGF0ZSAqcywg
VlREQ29udGV4dEVudHJ5ICpjZSwNCiAgICAgICAgICAgICByZXR1cm4gLVZURF9GUl9GU19CSVRf
VVBEQVRFX0ZBSUxFRDsNCiAgICAgICAgIH0NCiANCi0gICAgICAgIGlmICh2dGRfaXNfbGFzdF9w
dGUoZmxwdGUsIGxldmVsKSkgew0KKyAgICAgICAgaWYgKHZ0ZF9pc19sYXN0X3B0ZShmbHB0ZSwg
KmZscHRlX2xldmVsKSkgew0KICAgICAgICAgICAgICpmbHB0ZXAgPSBmbHB0ZTsNCi0gICAgICAg
ICAgICAqZmxwdGVfbGV2ZWwgPSBsZXZlbDsNCiAgICAgICAgICAgICByZXR1cm4gMDsNCiAgICAg
ICAgIH0NCiANCiAgICAgICAgIGFkZHIgPSB2dGRfZ2V0X3B0ZV9hZGRyKGZscHRlLCBhd19iaXRz
KTsNCi0gICAgICAgIGxldmVsLS07DQorICAgICAgICAoKmZscHRlX2xldmVsKS0tOw0KICAgICB9
DQogfQ0KIA0KLS0gDQoyLjQ3LjANCg==

