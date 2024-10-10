Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B98CF11F8
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 14:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sytxl-0004Ce-Gf; Thu, 10 Oct 2024 10:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1sytxi-0004Bp-U1; Thu, 10 Oct 2024 10:16:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1sytxg-0006pi-Jt; Thu, 10 Oct 2024 10:16:18 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ABMemU021818;
 Thu, 10 Oct 2024 14:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=2rUN9v+GgO2KVJmI92YQFhU0Mm+STFgroaQydCnsMh0=; b=
 ORL6f3rgugomuuZ5WvGd1By0Un17LhbwTwUEhaSSoQQSPisENZvNf+yZVl65z/tV
 JttMMWqjYmK+c+FZ3EGBq41JZIv8mUITwgB00LD7SHS3h6iuJe8xWAAWIKQ3Igl2
 nzSf1h2gRDpoLrR/gQdrOVpR9m484U0hZbCMdJYvohOg06ZmEhtC0VmMjwn7ofRO
 CyDMyQLzHJGGWRqfsxAUp2zppYtA42S0wxMxlNMn99raaNkma9r/MFoAuiCOKT2a
 WXHDLdGtsbrQbpbaTalpfwIpCVb1jt5ZkWNm0Z3YQZflobxGrGUJ7NWD/hRtvIhY
 bYFw59gFFCCPdPTCOOQc0Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302pjpyf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 14:15:32 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49AEBIVw019235; Thu, 10 Oct 2024 14:15:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 422uwgd2tj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 14:15:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFy0KDhvcsHJSz6SgjbK3kA56ysGH8AY9pkJpfFY4GmYz/rzesWmznP5U77WRxHvihARITdx+wFrdcicULCjNSp37leC38jhB2uuZ7tQiXPJKpSJAn5cjFGC4GnRNmJagUu3ua5pRPbg06Em0t5IoYjA/M+N4r7XgHPew7lXOR0h5CS0AQZwh3HhBAfo4xnelR54AK/7KWnu2dc1uNI1k8l8GpQMAfx1hdZtsWgfqwDRI8jzSiTc0sri1owcMbDEPt5A8uCSyopHquMTqtSr8Z8fBCOUfaW4ZvCEM5xXYQ+3dKFdYN9ds/OvLbSafJrQAYc1wXDc5KRGvAOk6Bvm+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rUN9v+GgO2KVJmI92YQFhU0Mm+STFgroaQydCnsMh0=;
 b=S9AvBEAfHoj3WLo6R8RD7PfE5xPDxI6MrVqoYsRGbzGvk7Bk/5DnXPT4b6k1G94v6I3iTyhk9OnaBSepQNI0JUK6STGu/h4YeDLAZcPTkG5ACD1rjQQWJlbssPBzlPaLVXkE3jBBheDEU8hUEWN3yrSqB32Vpcae5UNoEG5YWnzh1X5Xhgx3JlOXPCYA5RZnnvnViMz8QBILAGybrrpsNjDudBam9fPc6UgtbstkSvsqXeOZjn2yola0pBhZ+MNL1Zw6QZHh74k7JYa1YYpa1DWsJRpLghkFbl0shDG3cgJAntCfywRh34MfJFdaybsCeWJJNv4RmNO5ZGtW5OIt5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rUN9v+GgO2KVJmI92YQFhU0Mm+STFgroaQydCnsMh0=;
 b=a7RrlcncEGcYwAMvCpnpT8JpBdh3YJTHue7CJoMCfcVfOLVJIKXDqXShZ6Jl0W4qNaG6YkOmr3Pj+xT0+gCpclhMqqg5FuLu8MjZsCo4BuDNJJsdXy88A6HnvhgP1smCt5XB6E9vQS6U9SiLSxbfSB8eo28cAVGUQvQf8weiUWw=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by BL3PR10MB6188.namprd10.prod.outlook.com (2603:10b6:208:3bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 14:15:27 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%6]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 14:15:27 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Salil Mehta <salil.mehta@huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>, Marc Zyngier
 <maz@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, Richard
 Henderson <richard.henderson@linaro.org>, Igor Mammedov
 <imammedo@redhat.com>, "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Eric Auger
 <eric.auger@redhat.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel
 <ardb@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "gshan@redhat.com"
 <gshan@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "npiggin@gmail.com"
 <npiggin@gmail.com>, "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 Karl Heubaum <karl.heubaum@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 "zhukeqian1@huawei.com" <zhukeqian1@huawei.com>,
 "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>,
 "wangyanan55@huawei.com" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>, "lixianglai@loongson.cn"
 <lixianglai@loongson.cn>, "shahuang@redhat.com" <shahuang@redhat.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>, "linuxarm@huawei.com"
 <linuxarm@huawei.com>, "gustavo.romero@linaro.org"
 <gustavo.romero@linaro.org>
Subject: Re: [PATCH RFC V4 01/33] arm/virt,target/arm: Add new ARMCPU
 {socket,cluster,core,thread}-id property
Thread-Topic: [PATCH RFC V4 01/33] arm/virt,target/arm: Add new ARMCPU
 {socket,cluster,core,thread}-id property
Thread-Index: AQHbGfoiCZh8Z3+6bUKeWwVHtE8/wbKACbEA
Date: Thu, 10 Oct 2024 14:15:26 +0000
Message-ID: <48EA0F8D-442D-443B-883F-4455A52C181B@oracle.com>
References: <20241009031815.250096-1-salil.mehta@huawei.com>
 <20241009031815.250096-2-salil.mehta@huawei.com>
In-Reply-To: <20241009031815.250096-2-salil.mehta@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|BL3PR10MB6188:EE_
x-ms-office365-filtering-correlation-id: c37af169-a06c-4300-0a4f-08dce935fd36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|10070799003|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?gGhEOq4fSM6aYoc5+qddCg1ZXfH5VrGFu8bEUWUHVEfL5KOIh/6P6xzE3N?=
 =?iso-8859-1?Q?6YLIewfSSak52BiRR31dcVQv3STojl41sZiPq/GqHVc+DZKSxEOHnysRUJ?=
 =?iso-8859-1?Q?8EEiZ0Ijm8Df7t06+V8exIcu5qn49BHQyn9Dt072qokdvxOzKs8jmr6VYs?=
 =?iso-8859-1?Q?yJ4fGuhW6Sb3/oslgrS2/xlKAjjk8SqMWIHJQ2U/oI38djGCjJYjvNpDSr?=
 =?iso-8859-1?Q?OJBv9lUj300UfxbuMyrfbZtb9ii7P5KILkYtIVUi8RBxN4o5ZtyZ0GMfxw?=
 =?iso-8859-1?Q?WcMbK/OWiVdx5jZebaV7EC12Enu8kW3bT7Ln++tVJpsx6FFxqYyQpHXHwZ?=
 =?iso-8859-1?Q?PRlLikCaG1OgAGfjNFdZ8n0ygHrVAHciD+T3I4grFf50BIMP994dav/Aw0?=
 =?iso-8859-1?Q?V85JlsgLfRzlb55Z0587IvYVeV39c6yKpm6jVQhfuTgRscAIFaSEkRwSk/?=
 =?iso-8859-1?Q?5JSVqMj3Fn37PEfcuAnklRJvQipiULA3DorLt2EXz3oowbV6OZcOzHNRMq?=
 =?iso-8859-1?Q?b/PMhCVxc1WePt6jzbAaiYXzVirJNltF57Ufrt+rwAdT2mPSYae6Wy8qPN?=
 =?iso-8859-1?Q?usxBvq0vhE+v5LGEn7GoamAUrYA/HxSLrYoBsN+Nw+ugdGXSPEM632yk0a?=
 =?iso-8859-1?Q?NNpX+Rr1GAgJ8uR9hWR9YCBaOeb9itULY5DoP5RXm+bitHDelltyXwP4bX?=
 =?iso-8859-1?Q?H8KX0OlUFtGXV8h/RbPV9ZbQe+zeV5PhvKnT9se0QmFAPWnyMaAKvEwPzW?=
 =?iso-8859-1?Q?2uHtC9MUTute4bCS6ZKZqIk8rXB/vC8RyNDKxv7ax411taspIUeywQx3Bw?=
 =?iso-8859-1?Q?G2WxvVR4zJlYGzxtusutK4Rys9tsYOJcFbOXo7SDmQTs9YyDMyaeoHDfRf?=
 =?iso-8859-1?Q?thfuubEThItfZaTBU9jxG069oeKaxGvzfPwW4EoIJ2EIqJR3/JXdtC0zq7?=
 =?iso-8859-1?Q?iUu8bF8xjDIWx3++TPfFh0ZyslTCwWRc+n9MdZpvVhZJVc42za4iMKhahb?=
 =?iso-8859-1?Q?NabH0yXv7I4vW0l73BYajnkWHblzxQKR1IsogP2OTqqJx7wh1VvBWci342?=
 =?iso-8859-1?Q?k2hrBxI0Wm2fZA9hySwUPxhyUDVDY41b3LZjwuxSEGWeCSusLQsIXnlVNi?=
 =?iso-8859-1?Q?FahruvZ3Ar1EY+gxrO9qM09fQvuc1JCb96m/LE5LFDLwEM/eBfG4hMPF92?=
 =?iso-8859-1?Q?5e/UcqgM1ehx/5wHCngGkFrSqSpWuMQoX8TDuZTUH1VfmNfEFGBgHspRfi?=
 =?iso-8859-1?Q?sPws/DcS6yYWnHILW64ZP+yjE34T8sD6exJZ5dat40ivcxE/7huMXQG5K/?=
 =?iso-8859-1?Q?gepVfuU6McNiAWrNF2qTddK/Ckk67rmMV50X4G8DNVIgpS06KSLR9XS5Rg?=
 =?iso-8859-1?Q?O5+tjtSh4b/ilx4n/ubR1xfxm+JGs1Zg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5433.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tQyMl1CVDmW2h8lShHaVm47Yqz3s6jfsIeGH6Da/rAX5nUQ5SKj0JPpV0l?=
 =?iso-8859-1?Q?nLMH1aqjVWZTuigiDffEiSt+P2PBlX3mB8r9N17rXZVp9D2F4tKJQ61chW?=
 =?iso-8859-1?Q?T+29AaLE9DDKJ9on4Sgl2d05eGdH7TAQ/QPWg5l/V7iY/1XxEefoDxddJP?=
 =?iso-8859-1?Q?ht49C/HXD2vVz2/S45MkJjZxJ1Su5NP372qywBzknjS8vPunhIjJ1FixQS?=
 =?iso-8859-1?Q?fmj0utZtaDQJnvTh00kPltxJR4O1OxUNotp9eQM9tYggez86o/U3CxgdJ0?=
 =?iso-8859-1?Q?Un6z+56ZsruA8W8ecrlr4EZPyq1wPVikB0QhTnG0wcE5HQ4jbz3iPi4uB7?=
 =?iso-8859-1?Q?L3YGD/UnWwWnjEEP970HfJ87JzUwupfpFc/qkvYT1KxOQ4Q4hz/z9VHOMX?=
 =?iso-8859-1?Q?hPDWL/NHhMEmlfaFmvj8kucviKn1aq0uP7RbCUyRVqTC7QRdDK6hkAkLs9?=
 =?iso-8859-1?Q?gj2nJtKZJDwQnDYhTqrM4b4QraWEw0cbvh/TQ/iE5VU5Pukml7p6w5/+dO?=
 =?iso-8859-1?Q?lleQHe8YlpH9dWoSxRzUoqc8Ua0G7mN8Kw/BVCQNVqjp/svakklnesYUcl?=
 =?iso-8859-1?Q?bPLAC6ebtXeNe2yFmPB2tfdURhXGtl+kRfdn1jYVBFlHmb+/gIB5K8f2IH?=
 =?iso-8859-1?Q?bJI/iNoreGhfMVyU+LO865UepbOdWf3yClfV8bOni6bAHtWjiwHH5JvL7u?=
 =?iso-8859-1?Q?TdAfI2JWAJHU6IkAzzKK6l4IWS41CuQabu8OQlytSa41IqVXa27tDHMfMm?=
 =?iso-8859-1?Q?dxiW02SWcn6x6++fy13/uv7V1yOCh2KwzHM7jv/Yu3bdSAzN7NW2lMjqQH?=
 =?iso-8859-1?Q?XDvkkD98h2b4ZrimXcOArQz1vlweHR2zuCICymXmQlrCQjXL0zEk3RzD+w?=
 =?iso-8859-1?Q?fqG8o4jMd2ppC3a828iuGu+7S98hqSdekTg1OV3k8r0x3LvUCc7jcYF7RP?=
 =?iso-8859-1?Q?0rB6LGn83CruPKXYcdhEyAkeUUijt/1Fj2LJQperm/AlX5TRJoJsM9qnp9?=
 =?iso-8859-1?Q?EAOdJmMqgUip8QNWda9MdkkKXka4N046EDtM597PgW1mzImi4lXVvnzUu2?=
 =?iso-8859-1?Q?Lujk8goM+F2eJa6vBs8AKEzTjsagi3xV3niS4oZChSGJ25qIC35oHdCDce?=
 =?iso-8859-1?Q?EvoL37qYiOq1de/O84FDtzEtvWeqh/4rp1FFuUu8SFS58CI3prfZOjGhYj?=
 =?iso-8859-1?Q?ewfwD5U0Ipjk8dcugZDNFThv0mPcOWhsq46DjgsCwXpC/wtF69lnvy8oi+?=
 =?iso-8859-1?Q?LP+4pFyvTGKT9bLEwxglcaNpWSs4lMH6hVv1hBaOlkUzQv2zFDjAtuBwy0?=
 =?iso-8859-1?Q?KHp2wh8GwzhqX+TjIGNCZwl1A/B5+PARawb5mkm1tneiSdk1FzLmNyWXU3?=
 =?iso-8859-1?Q?i4cTxpqi6CiR6cE+ERe+EOewA02WLR53IXQYih+vB131mVZfNIaWNwlEIU?=
 =?iso-8859-1?Q?bS6io9v6Dg7O8In6g7h1YPtX3i5/tfy9/u6fxenieTjwykzGZf6m6PO9b7?=
 =?iso-8859-1?Q?kMZ4prCLNuojubCcx16m+2/yJq/nbhmcDG0ALyW7WM3wiWQtAoTDRtT8vZ?=
 =?iso-8859-1?Q?md9bvFLmxm0i4bZFhBWBFPjl5bjpicZh556sxqEITpSeJ843SYxTIepf48?=
 =?iso-8859-1?Q?mUv16Uw1E5Yl13Qrb3DerpLKf1Q3zcq1JpqidVglW0a3kdFxEw7Mr0TCGO?=
 =?iso-8859-1?Q?6Z+nKGzMN8e7p9Pf0Qk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <34E98ED130646D4890F71C0D4FF60EC6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kpXAcgrZntvNmRzIqD/KiRZlRGEmon+vGm8K6AEaKxDjBjLf0U29SmdXObbAlDXNHGJW93iTc7TxxOo23ws0aTAk0rSKkBfWIi0fR+c+yjbRWTcnPA9590XP97fOPW1qKugMQfbjt2ReW1Z3I6oOVOrBYN4Tvdz7iuYDiDoAzqYxH9Fu31OU2/F/uWrDHa84rz6dNhyFjD2UksTayh88+C880V40RXA8v8V0aEPg1esAP4f2/Fa/OJ3/YAxJLlF+vyhq7u9wiOce9/agf/7+xF7XS+aLfTccA3CMhRkELVifhw5AWDAvrwbDkax8yZrxe/MV01OX34JT+hKtAXfGYxzMgZa9wWMzZO/1KoLLFALUpvzY/Ep+K2T7ZklVlGXin9zwnefijxTJ71GwaRWWtjE3iWX8r8FpCtVM89NzIV4lEPFfWpd2TUlSmjOrZuF1qcdoik6PquSfQpW//RaMGRfaO89raNkMKSA3fl6sprwRjjplbCvH0XnmaOefCLtZRe3irTG17p9H0V2FKrFsa+p4WCB2inop5coldaDZjSNIZcU0SYLoerq4/a1Nmyh2a05U++gqyEBC6+lhDRr2zsjOuQVckTgFXePCB43F8g8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c37af169-a06c-4300-0a4f-08dce935fd36
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 14:15:26.9963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8DorPfAKCO3T6mS3tSoSQbl32xfgyy/98DolTy+O73EMUwDV1qh1tritYXz0bqlXE8f+VmYduWzsd5BWhE1iOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_11,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410100095
X-Proofpoint-ORIG-GUID: _RYyHvbPGAJz7ViifCaru1tPXXQFOdqJ
X-Proofpoint-GUID: _RYyHvbPGAJz7ViifCaru1tPXXQFOdqJ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 9 Oct 2024, at 03:17, Salil Mehta <salil.mehta@huawei.com> wrote:
>=20
> This shall be used to store user specified topology{socket,cluster,core,t=
hread}
> and shall be converted to a unique 'vcpu-id' which is used as slot-index =
during
> hot(un)plug of vCPU.
>=20
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
> hw/arm/virt.c         | 10 ++++++++++
> include/hw/arm/virt.h | 28 ++++++++++++++++++++++++++++
> target/arm/cpu.c      |  4 ++++
> target/arm/cpu.h      |  4 ++++
> 4 files changed, 46 insertions(+)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7934b23651..a0aeb263dc 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2240,6 +2240,14 @@ static void machvirt_init(MachineState *machine)
>                           &error_fatal);
>=20
>         aarch64 &=3D object_property_get_bool(cpuobj, "aarch64", NULL);
> +        object_property_set_int(cpuobj, "socket-id",
> +                                virt_get_socket_id(machine, n), NULL);
> +        object_property_set_int(cpuobj, "cluster-id",
> +                                virt_get_cluster_id(machine, n), NULL);
> +        object_property_set_int(cpuobj, "core-id",
> +                                virt_get_core_id(machine, n), NULL);
> +        object_property_set_int(cpuobj, "thread-id",
> +                                virt_get_thread_id(machine, n), NULL);
>=20
>         if (!vms->secure) {
>             object_property_set_bool(cpuobj, "has_el3", false, NULL);
> @@ -2763,6 +2771,7 @@ static const CPUArchIdList *virt_possible_cpu_arch_=
ids(MachineState *ms)
> {
>     int n;
>     unsigned int max_cpus =3D ms->smp.max_cpus;
> +    unsigned int smp_threads =3D ms->smp.threads;
>     VirtMachineState *vms =3D VIRT_MACHINE(ms);
>     MachineClass *mc =3D MACHINE_GET_CLASS(vms);
>=20
> @@ -2776,6 +2785,7 @@ static const CPUArchIdList *virt_possible_cpu_arch_=
ids(MachineState *ms)
>     ms->possible_cpus->len =3D max_cpus;
>     for (n =3D 0; n < ms->possible_cpus->len; n++) {
>         ms->possible_cpus->cpus[n].type =3D ms->cpu_type;
> +        ms->possible_cpus->cpus[n].vcpus_count =3D smp_threads;
>         ms->possible_cpus->cpus[n].arch_id =3D
>             virt_cpu_mp_affinity(vms, n);
>=20
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index aca4f8061b..db3e2aebb9 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -214,4 +214,32 @@ static inline int virt_gicv3_redist_region_count(Vir=
tMachineState *vms)
>             vms->highmem_redists) ? 2 : 1;
> }
>=20
> +static inline int virt_get_socket_id(const MachineState *ms, int cpu_ind=
ex)
> +{
> +    assert(cpu_index >=3D 0 && cpu_index < ms->possible_cpus->len);
> +
> +    return ms->possible_cpus->cpus[cpu_index].props.socket_id;
> +}
> +
> +static inline int virt_get_cluster_id(const MachineState *ms, int cpu_in=
dex)
> +{
> +    assert(cpu_index >=3D 0 && cpu_index < ms->possible_cpus->len);
> +
> +    return ms->possible_cpus->cpus[cpu_index].props.cluster_id;
> +}
> +
> +static inline int virt_get_core_id(const MachineState *ms, int cpu_index=
)
> +{
> +    assert(cpu_index >=3D 0 && cpu_index < ms->possible_cpus->len);
> +
> +    return ms->possible_cpus->cpus[cpu_index].props.core_id;
> +}
> +
> +static inline int virt_get_thread_id(const MachineState *ms, int cpu_ind=
ex)
> +{
> +    assert(cpu_index >=3D 0 && cpu_index < ms->possible_cpus->len);
> +
> +    return ms->possible_cpus->cpus[cpu_index].props.thread_id;
> +}
> +
> #endif /* QEMU_ARM_VIRT_H */
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 19191c2391..bda95366d1 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2622,6 +2622,10 @@ static Property arm_cpu_properties[] =3D {
>     DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
>                         mp_affinity, ARM64_AFFINITY_INVALID),
>     DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID)=
,
> +    DEFINE_PROP_INT32("socket-id", ARMCPU, socket_id, 0),
> +    DEFINE_PROP_INT32("cluster-id", ARMCPU, cluster_id, 0),
> +    DEFINE_PROP_INT32("core-id", ARMCPU, core_id, 0),
> +    DEFINE_PROP_INT32("thread-id", ARMCPU, thread_id, 0),
>     DEFINE_PROP_INT32("core-count", ARMCPU, core_count, -1),
>     /* True to default to the backward-compat old CNTFRQ rather than 1Ghz=
 */
>     DEFINE_PROP_BOOL("backcompat-cntfrq", ARMCPU, backcompat_cntfrq, fals=
e),
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index f065756c5c..1277a0ddfc 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1086,6 +1086,10 @@ struct ArchCPU {
>     QLIST_HEAD(, ARMELChangeHook) el_change_hooks;
>=20
>     int32_t node_id; /* NUMA node this CPU belongs to */
> +    int32_t socket_id;
> +    int32_t cluster_id;
> +    int32_t core_id;
> +    int32_t thread_id;
>=20

Reviewed-by: Miguel Luis <miguel.luis@oracle.com>

>     /* Used to synchronize KVM and QEMU in-kernel device levels */
>     uint8_t device_irq_level;
> --=20
> 2.34.1
>=20


