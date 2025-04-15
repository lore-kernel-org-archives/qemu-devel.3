Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D432C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 14:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4h3t-0004Qs-9f; Tue, 15 Apr 2025 10:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u4h3J-0004Ix-Ua
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 10:14:24 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u4h3F-0004QC-RA
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 10:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1744726454; x=1776262454;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=a2oyQHN5XBUXr+Yxzh74od4SU9UPCwddeUrLazXKa6Y=;
 b=EB6ChPJdK+tGdE2F12wCJlSLuB0fmxn0746XywaCER7lwtjFjQQfu1w7
 fWMBIisYp6oZuEtXciJzTN3kXTuEQjZu5DayebwDzLNZWeuA3S6ntc65x
 w4moFfJ+F6ljlUxHVE/wqyebmxQ631zncLZNkEOcTJ/HkViL+wbBX9vbz
 tjbmCdZ/f/0apVzRgtI+ZjE646f/hl+DaJZJRgQkRhSjKtgPI+vrPYPOA
 WLZsT4Q0j5hBhPkX9zsn34WMLdVsndkdw8ctUgcHHrIfqgt+aF9/X+zeg
 0/56AubUk7vVzEbW+/aowsBF9AEE47e9nru/oLw7/qVD9uqRArEvomNql g==;
X-CSE-ConnectionGUID: kH9ixthQSxKkxE0cqRQpuA==
X-CSE-MsgGUID: PWHviqYaRhe0ZzsnmUAt1Q==
X-IronPort-AV: E=Sophos;i="6.15,213,1739833200"; d="scan'208";a="37083666"
X-MGA-submission: =?us-ascii?q?MDGaa/wpQOflGQi8JNi1yQZ74bsgp3s/xg5Phf?=
 =?us-ascii?q?KUG/64xioW+AXgOiD6YyV7XBdWeM839XYgiz6oGn9PVCswpM/R57JgXO?=
 =?us-ascii?q?FewQ66lBxlcuWdqY3HrPkzpqfQL6E/+uQHMGA8QxwvFRmLZk3hBXGUk2?=
 =?us-ascii?q?7ln0Yn78/7SHpaNq91DPzcvw=3D=3D?=
Received: from mail-am6eur05lp2107.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.107])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 15 Apr 2025 16:14:10 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ru3OD1XiKEfKR/cQz0+aTO+lT5vBKcI348wzI20e9q9ZDy1/Lj2xZ5qXlW56FCtPPsJIgugMzLm1nL0FrcQkL+0SHB4M4JzYBxlELsQOCKlP4MXfFgur+7hIt9bngS/Sy/XbN2pVxRr1LiFFpV1J0hpTIQZsLb2k6X55Y14l0/AF/0X/vNIuy2CBOMUj3YGAFH7TOPOV0gNABqdHpK0lKZjOrKiUMnA7TZMxwL9Fpxj1c/sQPEBnNMcymBqKjw0boEvi4gTqgK+vXeUpWKv/qryhKJdfGi+6hfCwIgm+LX2TOxGhhV9wEg3S6Di+y+MnKccr0EWGbkgMXixZpC3OwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2oyQHN5XBUXr+Yxzh74od4SU9UPCwddeUrLazXKa6Y=;
 b=Wcz3JsOPWmm7g5ZVux8o2nVzRC60NMSFcXYasHYJgVCF+Dopx3LlBrCP8emjJkBHQBCSC5V4Hr8pWyHJg5ktK1QRcVTHFI/zdCNYs3ut8vXO3J5Vh5VcuFkleecN2LmV/bkCAb3jXpon3eFBd8xjF43tazIofRBWYGa+RMSDUFcX5mmjo3EZIDzKk3p+iymsjtKfVXfFOXf/ctKKf7U2RHWh/ARyIqSQ1l9OgbwV26oNcJKQ8Rp40esLWqviRHWMvIA/q/yfmgi9uHygWEtVrrtQwQEyboGvzcFFSN2dJ2Kn/agOISduFBUeqC/8g5Ie+2cOorEcJ/WxteE9A6WYIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2oyQHN5XBUXr+Yxzh74od4SU9UPCwddeUrLazXKa6Y=;
 b=QaXMnJLywnpnnZeMjaDlSKxsB7OEEpFmg7XxqgqDnyuaHjg6IvOIfNQYhkDzOOe+u+5k2Cn/CAwdotIpBImmlxJu1+XU3mhhUS7ACaQZKdR/Nxk8U12JGzmNtk4vBz2rwoOJz/rv+hesq/92q6HCdb5TMs+slBcYzGNJUmFjaPbfTwx4xYRV06Sah7CojqWYHPCMmr7YUXiQ4bwG+6Ez6+lowS8WnEzANgfFPWR56c5eWkHUYwdbFrOxAzCUmyV5lvB7t5cnkETeyM84iE+KiQiHJZCHGpKJyIngGRrcZwRSCKBSiAEwPghoSWA5YnQuElJC/PyizQvzBq9cFBdJ2Q==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM7PR07MB6785.eurprd07.prod.outlook.com (2603:10a6:20b:1c2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 14:14:09 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 14:14:08 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, 
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH] intel_iommu: Take the bql before registering a new
 address space
Thread-Topic: [PATCH] intel_iommu: Take the bql before registering a new
 address space
Thread-Index: AQHbrc4nGIHWbw444Um4nXxoEvkhVrOkT3gAgABaGwCAABwagA==
Date: Tue, 15 Apr 2025 14:14:08 +0000
Message-ID: <5cb4ac03-c45d-4534-93b9-2723fac030c1@eviden.com>
References: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
 <20250415030653-mutt-send-email-mst@kernel.org>
 <20250415123330.GB270228@fedora>
In-Reply-To: <20250415123330.GB270228@fedora>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM7PR07MB6785:EE_
x-ms-office365-filtering-correlation-id: cf37edc3-0ebc-4121-c085-08dd7c27c9d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Nkw2bjFQTDJYYW9OSXBsN1dwSTdVdkJIQmcvVkdoVVJBL3FNamV6VWg4TW4r?=
 =?utf-8?B?QTFTMGV3c0VNV3gyYUhKTTRVdTRWU0Fzbm84M0E3VlM1Nm5LaWlJdWFXckhj?=
 =?utf-8?B?dXJhZlB1Q25xK210amdWS2EzbFJNczhlV1hlV000dEVxSkxHQjRJL2NUSjFE?=
 =?utf-8?B?eUcveDdjVUJMT2hhZzRmUWc5RStJWUphZ2E3dzFLY3pjRXhYQ2dnSWVqRHY0?=
 =?utf-8?B?NzdBZzAzaXFTMHM5cTFhWnFBNzJwc2dUVE05L0lDd1BCNkhZL0d5Z2VnbFFr?=
 =?utf-8?B?ZWNZMElFOFdvYTBQYmlwQVhJdjRyL0ZVVVoxNjkxZXc4QjVzOXNwckdybSt0?=
 =?utf-8?B?VHNyZll3TjZ1T0toZ2J0YXhhcVk3TTdrZktVNTZiQjJtejcvdVJZME0wSkgx?=
 =?utf-8?B?M1E5ajdaSSs3MUxmdWgvMHJMN09rYWVVUUJxM3dITENSMEZTa1BQRkh6YTda?=
 =?utf-8?B?d0grK0xZdzZiNzdXQmNyRUxWSHJaZ2c0UHRkZWs2YnppUGNxZTZrMlpvQmdi?=
 =?utf-8?B?VGp3M2N3UXpGNVMwVzVPK25mcVRMOENEdzRzUjRqZVJVdzR5U2RpSG9qZFh3?=
 =?utf-8?B?dHg5dGJRQVl4ZFI1d2htd1NWeFk0TG01Y1Y3MFprNG1hR2N1azdIeGNyRzI3?=
 =?utf-8?B?M0pVV0xXZ3d2cEpGQlR0UEttbXhjOVRTN014WjcrYVZldmhWYUZWTTZiNi8r?=
 =?utf-8?B?SU9KV0RGcXFjaTVZcmtmV0lFd0lWWjV5U1h4MnZndGxXdUxkNUlqbUZQT29y?=
 =?utf-8?B?c1dxUFBDakRkcXZ0Ylg5eWxsS1B5VVlYV0ZZakNGSDMzVWkrMVhFcCtzWW0y?=
 =?utf-8?B?VnBkdndydzhkMm1UMmhvaHh6UTcxSVI1cFdBVE1VSjhWbnp1TUFUQ3BSdmJS?=
 =?utf-8?B?WGw3R2hKVDZoSlJtZlU3QnNBVWdydGFVbnlTNEVERGh4VjVqb1MwODR5eXFS?=
 =?utf-8?B?UnZocWFoTlhWMGp0amRBeFB6bXkyK0tEeUtMZnpPVlFHTkt5dWZQaDYxcDFG?=
 =?utf-8?B?L0tnNExjbUdLaEZtVkRab0Ewem4yMzEvbGpCemlHSXJ4RXpBSjg0MEpucVZE?=
 =?utf-8?B?UW5jTlQrcTUydUoyTXQrOEFhQ1BteGJoRHlZZEdEN1dyT1VjUzVLT0l1YUxN?=
 =?utf-8?B?N2pGZWs2enYxN3FEV0FZeStrdW5Xb3pGZTB1MUJlall2aHdYSkhaYk8vSkk0?=
 =?utf-8?B?N0ZUV2sxUGhSdzR1c2dKeFJzakJCNGI5WGwwWjk3dXdTRjZEclFmd3FGTzZ5?=
 =?utf-8?B?QVF3VGFqWHRhSDhzM0MzOVZjRThXeWFFdnE3T1BVRERTaTVTSndwN2FvUWpD?=
 =?utf-8?B?ZTRURDhZUzFsTUdrNndKMWE5ZU1HT3dRODQ0ajY3SC9RbjF1ZERNUXR1ZzNY?=
 =?utf-8?B?VFFtUW96RHg4Z1dKSC9UKzdWYzhQU2lUTlpET2dlRVJCcTFKNkpaUGQ5Yzcx?=
 =?utf-8?B?dUZwN05Zd1Jia0xnVGJQOGM5UngwUDFOMGp1ZGRNWmtYSHJOVXVDMko3TVVj?=
 =?utf-8?B?Slo3a09iQlRhRFI1K2hHWU5OREkyODZuOW9IZkpraVR5bE9tdVZTTkRndTVH?=
 =?utf-8?B?K0YzRk1Ed29ZV09IWWlhY1JMK3E1dnU1S3kvdi9RdEd1NFRVR0s2VXFxL1I2?=
 =?utf-8?B?UzRTQW1UUXFBNkV3T0I0VUlvVFdScG9XU09ia3hZd3B5bGM4WDdTTWU3R0Rj?=
 =?utf-8?B?OGUvZk4xalEyclVwVHpJd1QrdkFYdEJmc1UxUklFTFAwb21kalNOUnhPSE1P?=
 =?utf-8?B?MzNyUEFNMUtjdUV1ejQwaUhONnFPOFRyWDZRK3Q4YjV6bStKczF3bmNJVDNB?=
 =?utf-8?B?SjB4Y25CZGo3R3lFZ2pHWmpsQ0ZiczVvVVRkYXJ0Rmo0elByRVJlQVFjMkc5?=
 =?utf-8?B?eTJUY0RsQ05nenhyeURuU0cyNDVjVFY5amtCajN0SnUwV0tpZFV0S2lwd3k0?=
 =?utf-8?B?bXRyVXFZUnRsSmMwZWxYQ1RYaUt5czBJM3NscHkxVlVGaHdiYmJwTFFzREJH?=
 =?utf-8?Q?Ew+XFAgWt7GsMiC+yoX9pKhW0Vf/KI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MSs3SU8yUlNzZ0dRemR2eVlCbGdmMldpdnl0RUZQdWVSRkkwdVhySVNhaWNJ?=
 =?utf-8?B?RFdrMFN1empWbTh3QjdDcnpxbnJ3YVc0UTZwRWs0d3VUYkwvajN0YjhQbTBX?=
 =?utf-8?B?aGhyd1BUQTViTTFRNVlYR2c0NVNraXJUZjN6L2NGSERzc3cycFJoSnA5WHFh?=
 =?utf-8?B?UlVJdGYyeEtuODVRMjlhN2ZQUjJnRGV3eU9ZbjRWK3dUWnBaUUFzWit2Nlg1?=
 =?utf-8?B?MnYxWHBqV04yZVBzWU1RN3R2VUxVbzJwNE1Ta2dqKzNkSWd0UEc3STJnTlhq?=
 =?utf-8?B?OTYyQXh4VmVkd3pFc0xVdk9BSmZtNU54U0V1R05mSERCelgxVnZtdFhaaDBa?=
 =?utf-8?B?RU5BSkVkdnNzYWNPVE5TVDRjUnVDaEszVEZrWHVqY2d3VExwUzZDRFVtd2dC?=
 =?utf-8?B?SVZDZm1IdDBTV3BVNndKeUhNUDlIVjNZV3R2SU11SmFMd0oxWG1HREVQM1Zq?=
 =?utf-8?B?TFlnVWluM0N4VGdjbit1R2NQdk5qbDh0NjlHTEZOYW5EQ2lYSi8xTHc3Z0Qv?=
 =?utf-8?B?eERHL2RVVW9mZ09keHhNeEgzYU1ETXo0R2xNTDBLZm9VRTBXbG9LQkYveVYw?=
 =?utf-8?B?M2loWjUyR1UyeE5wVExZQjBFZWduNmVNQVg0OSs1V0p6RUVqWk9lZk1KYTMz?=
 =?utf-8?B?aW16NFExeGowL09LNzFxM2FiajJJeklwMVpBYktVV3VwTm5ZWEZuUnN1ZkVF?=
 =?utf-8?B?N3NHd3F0MzltZjNCWWU4Q2Q0R0Z0N0NBamppd2ZJbVZFK0N3RjRYZ0hHYXYx?=
 =?utf-8?B?RGFUUG1PbjFoYm5TNlFzM0NoTWJEanBUZktVT25KdXpJM2M3eDUrak53WUw5?=
 =?utf-8?B?R0QzcnR3NUNtR2lEb1pwaUVOdmxpZlc0Lzl1QU1ocXFGb29pUW9za3hUSXlI?=
 =?utf-8?B?bTVyajFjRHRLcnpaVVVaZDQ5bVZMeURxL1pCZ1MwS0VtYlNydXl4WFl6Um1l?=
 =?utf-8?B?WkNVZVNEZ3UveG92UTNwWFV1R1B2WC9WQjR2eDljclAzbHhTUVBDYkp2cmVa?=
 =?utf-8?B?T0M0a3lUZDJCQzQ3b0haR2VXdS9KT1ltSWxPKzRNbXloZ09VMFBleEhka25x?=
 =?utf-8?B?Q2pZWC9YaFVjVmszMW5adnF2RnpEMmZiSVA1Z0srR2pLNjZsZTcvMVRwRmp5?=
 =?utf-8?B?NkJKcXZGMFJDbkloamQ4V2ZBSWdwaFo2MTUxL0k4MFl0L2JHWWUvV1Y5U1pK?=
 =?utf-8?B?dk1MVm85SS9hQ0lJeW05OWNLRkZ1Sjk0R3dpZDl1ODJBZThJdDJLdkNiVERR?=
 =?utf-8?B?ckZ3MEtvd1JSY2krdndoWjg5cmRqYS8vSE1yejJMQTI1ZFdMakQxekVra3Jt?=
 =?utf-8?B?VmN0eXhiTWV1SWlzQUtvZDRERzBlRVhHWks4U2tDOFJZMWVoOUU3MUwwdTlV?=
 =?utf-8?B?QWJMeUNwMjlZTmQxb01kdE1RQzR2VUVKWVJYb0x6d0VmSEs5aW5DQ0VRQlFh?=
 =?utf-8?B?bTl4aTlsdkJoOVZjWXk5Z3FWdDZFdnJ5ZUtUVkNYOEh4YjJ2cjFUMlpWZHE1?=
 =?utf-8?B?Qi93cktER1pGQ2ZnRUcvNTBNV29WV0R1NmtkMDFvZUw3bklsVjRuZEE0SGht?=
 =?utf-8?B?cW5ZaWdwamQ2bU90VlRHZUk2QUhnVkd3VkpMWWpXbEx3KzBpSlRsdHdoVXNs?=
 =?utf-8?B?SjgreTllWW1jMzBVb2dqOER0cHJNaGhrV3ZuNHFHdFc1MEY3ckNkWFJKS1Ja?=
 =?utf-8?B?Zm5xSENISEx2a0laMVp3aHFiaFI2bmpLSnB3UkMvNTJIYjRlY05kWExSZFJy?=
 =?utf-8?B?Q3o1eDBnZVFyM1EyaW5ldWUzamdSYVczcnNvRi84Z2JoZW1VL29OOWNFRDE5?=
 =?utf-8?B?eFgyeG9yM0RvT3R6eHlyOHFySUUwcmxFa1FTUTJsZzZxRWZlKzlsU2dQVnVV?=
 =?utf-8?B?YzFYRVBjaVlWclZHMEJMbUR0NDJoUGd5dTNoVGVqdklEam93VElJUGViVnZI?=
 =?utf-8?B?czJQaGtxKzlkUTF2ekpyRUlrbVpxYWphZHRxblhGRkc5NzNUUnR3bkZRZ0hq?=
 =?utf-8?B?elZGQTB2UjlHc2E3ZEZKaDJIaGNtTTZIdWsrVVVZQk03WXVsVnoyNGpadWd1?=
 =?utf-8?B?V05lVUZhejdtaytEbWN4dW5kY05kbGZicmcyTXJ2NnpXNXpNbW1CcGYwSlVE?=
 =?utf-8?B?ZXg0QmxBU3hSZDU1bXQ4dTZ2ZU1ic1ZJZ3ZjNHp4MDFWNUloMlB5eUtESXpC?=
 =?utf-8?Q?S75s3tWylHZKXfJpagFhYxc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <621455EB6F963345A14577E78C29067E@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf37edc3-0ebc-4121-c085-08dd7c27c9d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 14:14:08.7983 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hbtTOS0c365egp9w33m7t7Pi7UV0EzD2oIRIdSXZzAY5sgh4B66y/7iH6Z8e+YbICTfxt1tOZKYkM/RDer5LoS2pSlJPLgHxndOKKyBlLpu4qzxPkL1fLMPKlIOQgX83
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6785
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

DQoNCk9uIDE1LzA0LzIwMjUgMjozMyBwbSwgU3RlZmFuIEhham5vY3ppIHdyb3RlOg0KPiBPbiBU
dWUsIEFwciAxNSwgMjAyNSBhdCAwMzoxMTowMEFNIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4g
d3JvdGU6DQo+PiBPbiBUdWUsIEFwciAxNSwgMjAyNSBhdCAwNjoxODowOEFNICswMDAwLCBDTEVN
RU5UIE1BVEhJRVUtLURSSUYgd3JvdGU6DQo+Pj4gQWRkcmVzcyBzcGFjZSBjcmVhdGlvbiBtaWdo
dCBlbmQgdXAgYmVpbmcgY2FsbGVkIHdpdGhvdXQgaG9sZGluZyB0aGUNCj4+PiBicWwgYXMgaXQg
aXMgZXhwb3NlZCB0aHJvdWdoIHRoZSBJT01NVSBvcHMuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5
OiBDbGVtZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29t
Pg0KPj4NCj4+DQo+PiBSZXZpZXdlZC1ieTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0
LmNvbT4NCj4+DQo+PiBTdGVmYW4sIHdhbnQgdG8gcGljayB0aGlzIG9uZSB1cCwgdG9vPw0KPiAN
Cj4gTm90IHlldCwgaXQgbWF5IG5lZWQgdG8gd2FpdCB1bnRpbCBhZnRlciB0aGUgcmVsZWFzZToN
Cj4gLSBEaXNjdXNzaW9uIGlzIHN0aWxsIG9uZ29pbmcuDQo+IC0gSXMgdGhpcyBhIHJlZ3Jlc3Np
b24gaW4gMTAuMCBvciBhIGxvbmctc3RhbmRpbmcgaXNzdWU/DQoNCkl0J3MgYSBsb25nIHN0YW5k
aW5nIGlzc3VlDQoNCj4gLSBXaG8gaXMgYWZmZWN0ZWQgYW5kIHdoYXQgaXMgdGhlIGltcGFjdD8N
Cj4gDQo+IFRoZXJlIGFyZSBzdGlsbCBhIGZldyBob3VycyBsZWZ0IGJlZm9yZSAtcmM0IGlzIHRh
Z2dlZC4gSSB3aWxsIG1lcmdlIGl0DQo+IGlmIGNvbnNlbnN1cyBpcyByZWFjaGVkIGFuZCB0aGUg
bWlzc2luZyBpbmZvcm1hdGlvbiBiZWNvbWVzIGNsZWFyLg0KPiANCj4gVGhhbmtzLA0KPiBTdGVm
YW4NCj4gDQo+Pg0KPj4NCj4+PiAtLS0NCj4+PiAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyB8IDEw
ICsrKysrKysrKysNCj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+Pj4N
Cj4+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jDQo+Pj4gaW5kZXggZGZmZDdlZTg4NS4uZmVhMjIyMDAxMyAxMDA2NDQNCj4+PiAtLS0g
YS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMN
Cj4+PiBAQCAtNDIxNiw2ICs0MjE2LDcgQEAgVlREQWRkcmVzc1NwYWNlICp2dGRfZmluZF9hZGRf
YXMoSW50ZWxJT01NVVN0YXRlICpzLCBQQ0lCdXMgKmJ1cywNCj4+PiAgICAgICB2dGRfZGV2X2Fz
ID0gZ19oYXNoX3RhYmxlX2xvb2t1cChzLT52dGRfYWRkcmVzc19zcGFjZXMsICZrZXkpOw0KPj4+
ICAgICAgIGlmICghdnRkX2Rldl9hcykgew0KPj4+ICAgICAgICAgICBzdHJ1Y3QgdnRkX2FzX2tl
eSAqbmV3X2tleSA9IGdfbWFsbG9jKHNpemVvZigqbmV3X2tleSkpOw0KPj4+ICsgICAgICAgIGJv
b2wgdGFrZV9icWwgPSAhYnFsX2xvY2tlZCgpOw0KPj4+ICAgDQo+Pj4gICAgICAgICAgIG5ld19r
ZXktPmJ1cyA9IGJ1czsNCj4+PiAgICAgICAgICAgbmV3X2tleS0+ZGV2Zm4gPSBkZXZmbjsNCj4+
PiBAQCAtNDIzOCw2ICs0MjM5LDExIEBAIFZUREFkZHJlc3NTcGFjZSAqdnRkX2ZpbmRfYWRkX2Fz
KEludGVsSU9NTVVTdGF0ZSAqcywgUENJQnVzICpidXMsDQo+Pj4gICAgICAgICAgIHZ0ZF9kZXZf
YXMtPmNvbnRleHRfY2FjaGVfZW50cnkuY29udGV4dF9jYWNoZV9nZW4gPSAwOw0KPj4+ICAgICAg
ICAgICB2dGRfZGV2X2FzLT5pb3ZhX3RyZWUgPSBpb3ZhX3RyZWVfbmV3KCk7DQo+Pj4gICANCj4+
PiArICAgICAgICAvKiBTb21lIGZ1bmN0aW9ucyBpbiB0aGlzIGJyYW5jaCByZXF1aXJlIHRoZSBi
cWwsIG1ha2Ugc3VyZSB3ZSBvd24gaXQgKi8NCj4+PiArICAgICAgICBpZiAodGFrZV9icWwpIHsN
Cj4+PiArICAgICAgICAgICAgYnFsX2xvY2soKTsNCj4+PiArICAgICAgICB9DQo+Pj4gKw0KPj4+
ICAgICAgICAgICBtZW1vcnlfcmVnaW9uX2luaXQoJnZ0ZF9kZXZfYXMtPnJvb3QsIE9CSkVDVChz
KSwgbmFtZSwgVUlOVDY0X01BWCk7DQo+Pj4gICAgICAgICAgIGFkZHJlc3Nfc3BhY2VfaW5pdCgm
dnRkX2Rldl9hcy0+YXMsICZ2dGRfZGV2X2FzLT5yb290LCAidnRkLXJvb3QiKTsNCj4+PiAgIA0K
Pj4+IEBAIC00MzA1LDYgKzQzMTEsMTAgQEAgVlREQWRkcmVzc1NwYWNlICp2dGRfZmluZF9hZGRf
YXMoSW50ZWxJT01NVVN0YXRlICpzLCBQQ0lCdXMgKmJ1cywNCj4+PiAgIA0KPj4+ICAgICAgICAg
ICB2dGRfc3dpdGNoX2FkZHJlc3Nfc3BhY2UodnRkX2Rldl9hcyk7DQo+Pj4gICANCj4+PiArICAg
ICAgICBpZiAodGFrZV9icWwpIHsNCj4+PiArICAgICAgICAgICAgYnFsX3VubG9jaygpOw0KPj4+
ICsgICAgICAgIH0NCj4+PiArDQo+Pj4gICAgICAgICAgIGdfaGFzaF90YWJsZV9pbnNlcnQocy0+
dnRkX2FkZHJlc3Nfc3BhY2VzLCBuZXdfa2V5LCB2dGRfZGV2X2FzKTsNCj4+PiAgICAgICB9DQo+
Pj4gICAgICAgcmV0dXJuIHZ0ZF9kZXZfYXM7DQo+Pj4gLS0gDQo+Pj4gMi40OS4wDQo+Pg0K

