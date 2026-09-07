Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFB8C79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 21:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3gYb-00086m-JG; Mon, 07 Sep 2026 17:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1x3gYa-00086X-C2; Mon, 07 Sep 2026 17:07:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1x3gYW-0007y4-W4; Mon, 07 Sep 2026 17:07:12 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687DKLEl1981575; Mon, 7 Sep 2026 21:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=AqmjaxDO2DAKhVCifJPQSLqdgXkmYjqs6jRh6BnFATU=; b=
 caHkL8QlUKhZujtY4BO+uqz63mz030uAJFTwYlUhkYF6cq+sXDFQaYn3oKuDWP+b
 1sU+/LGrlMxs+SVyYzcWmJs8KvxKyriurY9dXlN6c3/I0OYWtRqC4/QhR/K0tEYE
 kXkfX/o4dOjy8MwGKc5cAIP6vChUGzrGvtZsZzomhuJOZUe8qUxwlf4FliMyQ5K3
 hOgSoCiCMKJLdTvPsicnuz+BTkaFuO2js15FUOAodcmHKGjFUdRIGwJMpvuWpZx2
 /opj6St2kDfr6s86FVSO4DaDGLav444IOaxWbQa1/DKKGFjmT7pLEvb6MSeVmAiG
 RBeK54lGucnpW+dKboYXUg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ggbd3tanp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Sep 2026 21:06:39 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 687L5Sp9009266; Mon, 7 Sep 2026 21:06:38 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012005.outbound.protection.outlook.com
 [40.93.195.5])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4gh753nqhs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 07 Sep 2026 21:06:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDiWkKBYLhymkc3gYj5VgdJ7/3GAdjQzNE0swWgTWh2yHwFsBhA/7p9e/3vNYz3DtPQlhFOmi03Cfwu/UddwB+0ahlbGulCJYg2Au0FsLHCOXQJt/fZC9UA1uqWk1EQ+pV2F3MozuNUjAfuGj6hPB5vOm6pWzBcoHNRvdqC465bTU9cx9zLHLPObkyOFaOKtjYqhXNYSBOkJ06zpbrt6Gty7ZB8TgdWdkKUWbUSeJa6jU6mJls2KFpmPk/jT/fGfveTaN/DO7QnjL1UqiRjVkAo7Mk7HVFzemDS42xHjmeg7B5uXw5TqxMxKFTX05S0sd1x7ZPL/YstS5/g9odS0BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqmjaxDO2DAKhVCifJPQSLqdgXkmYjqs6jRh6BnFATU=;
 b=nxHVpxT1Xwv6QUnTb9WCG6/qeccM3Z/P1pgA12xdqHo7HRu1by5MRsXD5xFqKQeG5PmE0gaJHPRVr8T7GChwFXXbAe2tw1lWLyrw48RsHECIZ+Rr3L3GGgyzIaog20Bm8thIES7CizRAQa/CMB+OeZ2RvRgAT+iDHUXD1CgsAiWWqgYgsx5QNc0VGIfrGu8pFxAxwZyXhhf6OYe7REXgQXUrS0Yijnz8L2KLUIxQmQia7dAX1/EDKkCxiMX8Blg0Z5CAOi6ubOchlCYI3siNx/QZAlx9ExKu/PMCE+3fc3ocPR0KG7c3ZyAl3a3hS2pbNgPnhoViDG6URqJJzCykJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqmjaxDO2DAKhVCifJPQSLqdgXkmYjqs6jRh6BnFATU=;
 b=XB1nI16FNhKGaI0Thw9GeGSMpSoNRaeZGqByMTOQanCG9y+R5/g7S4Dassw9F019XOEGDlW82GyniN19ae8Pls8ARAKt8rxV09Bg+F1WM1ObHY58JV0oZLdnBvJVdX+IQ6e0EL5QXTpuck8jbYiBFqYWWxi0tgFbCaHSXT7QXBw=
Received: from CO1PR10MB5506.namprd10.prod.outlook.com (2603:10b6:303:161::7)
 by IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 7 Sep 2026
 21:06:34 +0000
Received: from CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4]) by CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4%6]) with mapi id 15.21.0382.007; Mon, 7 Sep 2026
 21:06:34 +0000
Message-ID: <296a04a7-f917-4abd-b564-4a6b8fc6aace@oracle.com>
Date: Mon, 7 Sep 2026 14:06:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Force detach PCI devices for ACPI-based and PCIe
 native hot-unplug
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org, dave@treblig.org, anisinha@redhat.com,
 philmd@mailo.com, aurelien@aurel32.net, mjrosato@linux.ibm.com,
 alifm@linux.ibm.com, farman@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, cohuck@redhat.com,
 alex@shazbot.org, clg@redhat.com, akrowiak@linux.ibm.com,
 jjherne@linux.ibm.com, sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, joe.jin@oracle.com
References: <20260824011420.752806-1-dongli.zhang@oracle.com>
 <aoxY4Rxst2qAyn5z@redhat.com>
 <01ee4841-76d8-4749-a80e-eb945ab8799a@oracle.com>
 <20260903172835.0e253a25@imammedo>
 <6154b857-16b3-476b-a2cb-8837464dd4cb@oracle.com>
 <20260907044608-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20260907044608-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0383.namprd03.prod.outlook.com
 (2603:10b6:610:119::18) To CO1PR10MB5506.namprd10.prod.outlook.com
 (2603:10b6:303:161::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB5506:EE_|IA1PR10MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: 6936be15-463b-4771-cd33-08df0d23e5f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|6133799003|10067099003|18002099003|4143699003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: we0aapbxGdSsA2BqMVmpSMp1XGXzIuABomJv9arPV3oLT9z3pY1W8Ht3nJdiln4zR2LPOp34vlRDnoRGdmyb7SD2G9LjKgZOi6F/iMG4R0EYeNpakDi3I8PA6NeOxJ8nG6Wl62xT/5BlEXbjJoXclBuIs2Pcf5eTphKDrutX8+ukiA3jNw/5+9/eSvrn1xFaW7kCtNVwMNQjXfcQLurKwN908iS1zCsp99Bce7orG8NSew5qGp3fi5LpWuKLw1D00lwQpbV1veBn4eJeGg/3GiHwzo0ARRMxcW8DdOoqO5rSJX2s3C0Hjde8SC+aNrEqkMbi6IH/G73GCOlQOSskUqAZ97joXIsTYLfu7kLM1NphsUWZ9hmdCGEiaGx8toDWWDAWfum382Y0Z1yXeZm/+dBfuOR3p1uQK3q9f2+VJkcxyLdIr2QJz9wpjO9hEGlsEpxwa0bg8eDdoagCOi6kmVbRjGhRJ6ZuxwttrpQUSREOMsi/05+Hv8+VnTdCFUWN2THtw25nGZJTSnz2ovNNr2qBMbwWwrpsT6PNekzYyVPJykwctwEFOgQupno8weT/XnQaHpXGzSOL2Y53Cncpx4IHTwKRrplCB/hWnhvslxV1Wn05SfpK9hLsZQi08AhHPW7vaPqPVQFvTlVZS/nS5Zmwl5MgvInrOL2N1AQh4Do=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR10MB5506.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(6133799003)(10067099003)(18002099003)(4143699003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGF2Q3NOL0R6WEpFZHJMMjA4VXVKSDVoNEJYM2ViODJSZDNZTXdjVUJNdm40?=
 =?utf-8?B?b1BYTVNmNWJiNnc2VlNmUSs2c3AxbVZjWStoOVhsU1F0TjJYNGxxTTFkK3hQ?=
 =?utf-8?B?dlVJT3NDZmFEaUpxNnJqWWpOZlNGWm9zS3pTa1VXZ2x3OGo4a3ppSzVwZS9R?=
 =?utf-8?B?SW5xd3ZRUjd1ZWUxYSs5WVlnaVo3TEhIQ2VaeGRZcTVJYWtmTEtCMTNaeDUv?=
 =?utf-8?B?ZkNoQUpzZjEvbmpDQU9mVFRzQktCZTJHM3o5dnIxYWMrcU1kUDY5REVYNEs1?=
 =?utf-8?B?eExIdW1lTGVmY0xyazdZSjFjS1hGZUpoQmxxYkdKSlZLZ20rVTZCN0tCTFd5?=
 =?utf-8?B?SmRFb2VLM1lzcW5BdktVb1dqNXVvL2JzZzlWOU5yQlNzd1ozR3NmVVhObjc3?=
 =?utf-8?B?VTkrSGQvc0t0TVZPdm9OSnJGdkVUQllvN2x2aDRuUms5QzgyV21wejdqdGN5?=
 =?utf-8?B?WmxMVFcwem0zZXRJTTJnME9wdUJQbVAxb0JhUk41RGM1VXROb1hQZUdrNXZq?=
 =?utf-8?B?bGVKekJVQWZ4SVNMKzJYaWFFRUNGQTRkcHlZNWErMWxYV3F3WHZBNTUzVDI2?=
 =?utf-8?B?TWlhd0hnTGdmdXpHbXlweElhcUtFTmt5UlFpUlpCMy9KTVRzUkRSKzJ0ZFRX?=
 =?utf-8?B?VlowUGdMYlZPUkl5RExhVUxYSDNvdjl3dkcvS0Jydnp1QVIyNUszbnl6WUFO?=
 =?utf-8?B?c1dPNFlJMk1NUjFSU2wxYkNna0Q2Q0RwTzRlclF3dmk3eHRiYW5HMEdRRWlq?=
 =?utf-8?B?RWRQcWRMZElMaEE5UzlpM0oxTVB2RnpQdnNkNTJ0VzRRTTJaeFVHOCt0bWZo?=
 =?utf-8?B?NElHMXJFc0xCZ2xvQi9lMkMxMzlDNHA0azZxZjdmeVJud08wT2Fiekx1alV4?=
 =?utf-8?B?L25abUFjVUxQZjVTa1R3VFlhWXRBVFJjQnEvY0lEYzlieVVlZlJtUGJkeWEx?=
 =?utf-8?B?K1F6Q1BtbUFDanBUN0FiSkVjeGNnb2hyS0YyK0RJZTErOUZjbFkxUDd2OElZ?=
 =?utf-8?B?UjhXTTBoR3ppa3lzYWpSM2JNR0IwOThNRGZBWjB2Q2VOVEhhbkJpYVpZSi9B?=
 =?utf-8?B?MVZheEpaa21sTzZXdEg4dW5XdHFxU3hEWkU4Wlo4aTFlbkROZXZJQVZ6UlFB?=
 =?utf-8?B?enozMWNocWFYTW5mUnFFRGdHaGJCZm9lRmN4NEdRMzJZNCt6OC9GZHVwSTF4?=
 =?utf-8?B?QnFTckNXdW5FU2tVWlZCcEVTTENjcUhCa1JYU2FBajY1czVEcFZDdzJ1NVpM?=
 =?utf-8?B?QzFxeDZBODNTSnM2cE9kRUxkOGFUVUxRSTRGcmN6aldLa3VEUUZMVWVSSXY4?=
 =?utf-8?B?eTFLZUxGN1IxK3JWYzNqbTZlQyt5ZkJXRlZSOU5pZm9rZVJ2Qjc2NWFxaW1H?=
 =?utf-8?B?TUZTckFMZVJoQnFDcllzdTlnNmZLSXpwWEF6UC9TNUZVUkF3eUNtTXNBTi84?=
 =?utf-8?B?OCtldmluclgyeHMvbEhjS1owOThZTmRLMzJKZCt6NnBtaG5UN0hmdUQrT3Rm?=
 =?utf-8?B?WTVQeWxaWGxZZitPL3V0L213dElLOUpLVFRLclpqV0NBMFN1cGkzUi8rU1hV?=
 =?utf-8?B?bFlsTzNpOFhBQk9kYUliRUd0TmtqY2RhbDRmd0NsY1VYeGNCYW1JYTd2TjA2?=
 =?utf-8?B?ajRaOFpIb0tFWTdjM3pFTFk2MThRa3ZkbHA2WnVkZDBEcXhoRUVQVzZuYUZO?=
 =?utf-8?B?NEEvRGlocWU4Y0pnbExuUkVpeThPclNWM3hSeEpvbFQ3b2d3YmVWOUVZOFR1?=
 =?utf-8?B?WFN6OS9qMWxjY2lXWENHYjl6dmhldVhIa3J5MDRaTkdiVUdIaFc5QmhVL3cy?=
 =?utf-8?B?RDYrbzZVSEJHRUo5bW8xSy8zVEkyU3AyNWlMdkR5V3NyZHFwclkvaGZuMUM1?=
 =?utf-8?B?VkNpaEpvNmVxeVk3UWh1UElBazVpOXNYUElFbERtN3YzaVIvMmQ4aDFmV2t3?=
 =?utf-8?B?TVZiNm4vM2h4b2ZxcXlVMXMzYWZiMldhUTBnNDEyUXVJN0ZQc2RVQXZraTlo?=
 =?utf-8?B?UnowaUUzeGZYRlpEN2NjL0JEY2Y1QjRyNHg0bkFrN2ZoMmxZWVZUZk5FRlpq?=
 =?utf-8?B?OUtQRkRjaVN4Wm4wVll1Rmc4REcySWdvaFdIQnRjZEVXTjZ6dmVsMUpMVU93?=
 =?utf-8?B?RElranR2c1NmcEhrWTEzV0MzWWtjclRmN0FzcnVFSlBpVXYrclgydkE5cHVJ?=
 =?utf-8?B?UktzUUJCQ1pIbUFHZTJ2UC9ySGIxRUNvRmNVUW0yek0vRTVmZSs5aGpSRGRZ?=
 =?utf-8?B?KzJoLzZ4NWRyK0FLbTFhS2d5QnE1OEkvM2FuazMvdEtYS2FyRmJnSDJsUk1W?=
 =?utf-8?B?NHNSdG1nOFlTMEZ2T0gyQjBLa2lxeVpGY1M5ODdlb3dVdSt0R01KUT09?=
X-Exchange-RoutingPolicyChecked: frAODmUJamSYFLDlgog3i7JWVjspfyAnMELa6UcZ9myh37UoPmcf9wrjnGXkeDYZsdN2XXbv/CIUswYFwGC9haHUqgRLvotzkkmBycs94JcZetwnPZV4xbvD+iL/zhrspEm8RKe57hi1S1Tjd0oNuuZfGDz7sGw6/SFGQtUVCyUDGjzTkGrM9g0JBI/EiSIQrlolBVTlCPy8IltuHBdFbjK90IKlAmXXzJl8xP12cfItEc0/RaJbH9JdPNXdfK/Gc2vqtfQ/GcPg8FxoQ5mB4Mdz2is0Ts4eXpllxFIA8WzrM4rgJsQ45uFZVd/UBO73JHZ/AYGMo0+6XXHHppaDvg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CguOmCVy7x1zTABQjWU9ZPmVdgblEUH7SmzwQzGWp9IH966cSvGrHwZPfHGnJLf/v629czoJYOOLhuVGYMCrivOeyGsnVNORWnV4oeOk9rYiIz1P/w6bL6eSBcKB14R7x3iRaILEKbFB1mye2Wl7ivmKYWuyx02oF6EzP87UnIVUufSpnOctXvd8+AdGkEoUTw8ggxdZd1kGZ7vG25uDrhoTEgJalkv1WEr5605HPCePIuxl8HahPpRAdyd2hYiOaGuwmw4WEbz6YHwEiVtL2hFlMseV7HqsN40AtLDM/VyJkbCdJZ5c6eU7Z972bUmUToyFPp9JfdpOs48emqj2e0NW/kB1tAmVAM0OYH+EWKTv+A4dfHvPOhUk0padYCoC+2Q0uBW4RlUWnXd0Tiye5Ngdi6/s0DXvhPHR7MCkdyoLfuXcn/0xY/ZXqPTe4OW7sZ0LKWK4uBgUabyfFGj8YYxLxhYfSkmEzIW7SQoOenLg8DTBxnc1MToVpM33zCYdqsdvqUDKhFLmIL1SjGiqv6qLiCM1vFzzOwKyY5CQcT36Fv8xrqqAli5JERoPHwEnL/3EeaYrYltCN6MrsJhIvqR5QVbJs/Sh73amygNyPTw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6936be15-463b-4771-cd33-08df0d23e5f9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB5506.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 21:06:34.4333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ki0vWwGa7IisJmwdwxFtczCikiPysoW7Cho2gAK1kg4eod3A9dOHyk5hrab7ItIbLCNTpmvLodPhUU4FSxT7Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7309
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_06,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2609070232
X-Authority-Analysis: v=2.4 cv=EuDiaycA c=1 sm=1 tr=0 ts=6a9f275f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8
 a=BbSywiCuCK1ZzUgePn0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12108
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDIzMiBTYWx0ZWRfXxtDgp7iXrev0
 Bp+dk5kCJJa9QY8R2u/IlEqSkHLsyqU95ZKDPKfqitdIV0K8u9LcwQbgFIT/TI3XyHZuVJvqLV2
 o2+8h2+fz56K0WxSLye2fn3Xi56W1dzIgBTqcd1PXXsiG6np0xD+
X-Proofpoint-GUID: ODkSNkRfWVZJdKO88-9-rFmAYcg7BJxx
X-Proofpoint-ORIG-GUID: ODkSNkRfWVZJdKO88-9-rFmAYcg7BJxx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDIzMiBTYWx0ZWRfX3WqEBjIybOIV
 Ls7eO2FzKaX/TZlj6zddIENWKcsdSkGVTp0Ns1k0opoeE8e3bao963nLuSFJUz3MgIpR0pf1t23
 OCdGQrINsoJrsN8QlYu/pOFpDgOipH5lzBG9E2W5DBHG4TbXlNzWmgUmPeAM77NrDS1NIw9uZbr
 EVvYIIekBZPBoaiLJzEkE6QEsWuezjbhd9GaUExVZF3NAfUSmK6ZfsyOSpLjGjli5xSmu+emTY+
 kUl+vLG+2CEOYfAwzaYV1IfFVrpywZxtn0Bga+/1hi0kGA8/tknen8zBrgkDvMHUVimwK6A7h7W
 J0K0e4fjptVQOmjR8yTzs3sJ2tAfg9mWs07GvHppwarQgeLQIiSopBZmVSu0Y1IDg4pqtqyoOHI
 9dP1QWZiioFOFJ37lCyV5cGlt8nJLrllWOwjDD/051xVgKXJaKzpG07Kpu0ax6K9av/vcsxCXMm
 kEdlUV3HGxmnrdD6X9UmOGt9NR0JxBQcdCAksBR0=
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On Mon, Sep 7, 2026 1:55:42AM -0700, Michael S. Tsirkin wrote:
> On Mon, Sep 07, 2026 at 01:26:57AM -0700, Dongli Zhang wrote:
>> 
>> 
>> On Thu, Sep 3, 2026 8:28:35AM -0700, Igor Mammedov wrote:
>> > On Wed, 26 Aug 2026 09:15:47 -0700
>> > Dongli Zhang <dongli.zhang@oracle.com> wrote:
>> > 
>> >> On Mon, Aug 24, 2026 7:44:49AM -0700, Daniel P. Berrangé wrote:
>> >> > On Sun, Aug 23, 2026 at 06:13:30PM -0700, Dongli Zhang wrote:  
>> >> >> Hot-unplugging a PCI device can require cooperation from the guest. For
>> >> >> ACPI PCI hotplug, QEMU notifies the guest through ACPI and the guest
>> >> >> eventually writes the ACPI PCI eject register. For PCIe native hotplug,
>> >> >> QEMU notifies the guest through the PCIe hotplug mechanism and waits for
>> >> >> the slot unplug flow to complete. Only after that completion does QEMU
>> >> >> unrealize the device and emit DEVICE_DELETED.
>> >> >> 
>> >> >> This can leave a device stuck in the unplug pending state when the guest
>> >> >> does not cooperate. Examples include:
>> >> >> 
>> >> >> 1. The guest has panicked, or the relevant ACPI/PCI hotplug driver is
>> >> >> unavailable.
>> >> >> 
>> >> >> 2. The guest is stalled and cannot handle the hot-unplug event. For
>> >> >> example, stalling the Linux [irq/9-acpi] kernel thread can reproduce this
>> >> >> for ACPI-based hot-unplug.
>> >> >> 
>> >> >> 3. The device was attached to a slot that the guest cannot use. For
>> >> >> example, a pcie-root-port only supports slot 0. If a device is added to a
>> >> >> non-zero slot below a pcie-root-port, the guest may never discover the
>> >> >> device and therefore may never complete the unplug request.
>> > 
>> > all of above is actually expected, no (functioning) driver => no hotplug/unplug.
>> > it's the guest problem. Once device it exposed to guest its life-cycle
>> > not longer owned by QEMU.
>> > 
>> > That's what one would see in real hw as well, you press eject button
>> > but it will not do anything if OS doesn't process it.
>> > also see comment at the end.
>> 
>> Users are generally more tolerant of issues with real hardware.
>> 
>> In virtualization and cloud environments, PCI hotplug is more commonly used for
>> NICs and storage devices. Users are less tolerant of disruption or unexpected
>> failures.
> 
> 
> Simply put, surprise removal exists in the hardware.  Emulating that
> makes sense, at a high level. Nor is it too hard.
> However, guests, especially Linux, do not
> handle it all that well generally. Exactly because users
> would tend to impatiently reach for that tool, then
> blame QEMU after a crash, we avoided emulating that.
> 
> 
> I'd expect much more in the way of research into how guests behave,
> perhaps some ways to limit it to devices that work well, and
> likely some linux patches to make it work better, before we commit to
> supporting such interfaces.

Here is my summary of the current situation and plan:

1. Folks are not against adding an option to force-detach a PCI device. It
should emulate surprise removal, which exists in real hardware. This requires
adding the emulation to QEMU.

2. However, the more important issue is ensuring that surprise removal works
well in guest operating systems, such as Linux and Windows, and for a defined
subset of devices, including virtio devices, VFIO-assigned devices, Intel,
Mellanox, and Broadcom NICs, and NVMe devices.

From QEMU’s perspective, it is preferable not to expose an interface that may
cause a guest crash and lead users to blame QEMU for a guest-side limitation.

3. More research and development work is required to support surprise removal in
both QEMU and guest operating systems, especially the Linux kernel.

4. So far, from QEMU's perspective, everyone suggest rebooting the guest VM for
many of the use cases I mentioned

5. By instrumenting QEMU code and possibly adding additional metadata, we can
track whether a PCI device has been accessed by the guest VM, especially during
PCI hotplug. If the device has never been used by the guest VM, it may be safer
to force-detach it.

> 
> 
>> > 
>> >> >> 
>> >> >> The non-zero slot case has also been discussed in:
>> >> >> 
>> 
>> [snip]
>> 
>> >> >   
>> >> 
>> >> Thank you very much!
>> >> 
>> >> I see that the issue has been fixed. The ticket mentions the following.
>> >> 
>> >> "What I am observing is that it seems when the slot ID != 0, the guest OS seems
>> >> to ignore this and we never seem to hit ich9_pm_device_unplug_cb()."
>> >> 
>> >> Based on my experience and evaluation, ACPI-based hotplug is more likely to
>> >> encounter an issue where the guest VM does not respond to an unplug operation.
>> > 
>> > I'm not sure it's a good idea to delete device when guest still thinks it's there
>> > (you can make guesses on QEMU side if it's in use, how useful those are is questionable).
>> 
>> By instrumenting the QEMU functions related to device hotplug and PCI
>> initialization, we may be able to make informed assumptions.
> 
> So try. But just know that pci initialization is commonly done by firmware, not
> the driver.

Thank you very much for the confirmation. This also provides users with
telemetry to narrow down the potential reasons why QEMU does not send the
DEVICE_DELETED QMP event.

> 
>> > 
>> > as far as I know, ACPI hotplug has no notion of surprise removal (pls educate me if it's not the case),
>> > so I wouldn't do what you are proposing here at all, it's basically asking for disaster to happen.
>> > And all this is basically for dealing with abused qemu flexibility.
>> > 
>> > Please (re)formulate usecase and make it more clear as what is eludes me
>> > no matter how many times i've read this cover letter.
>> 
>> Here are some use cases in virtualization and cloud environments:
>> 
>> 1. Suppose there is a QEMU user configuration error and a PCI device is attached
>> to slot 1 of a pcie-root-port that uses ACPI-based hotplug. The device may not
>> be detected or ejected. As a result, there is no way to detach it from the
>> user's QEMU instance until the guest VM reboots.
> 
> sounds vague. if users can not configure qemu what are the chances
> they will use force detach responsibly?

I should have clarified the difference between the QEMU user and the VM owner.
The QEMU user is the software that manages VMs, such as libvirt or any other
software that communicates with QEMU through QMP. The VM owner does not have
access to QEMU.

However, any mistake made by the QEMU user can affect the VM owner. For example,
if the QEMU user mistakenly adds a PCI device to slot 1 of a pcie-root-port, the
VM owner cannot detach the device from the QEMU instance until the guest reboots.

In this case, the QEMU user is at fault, but the VM owner is affected.

A force or surprise removal option helps the QEMU user recover from a
configuration error without requiring action from the VM owner.

> 
>> 2. For an unknown reason in the customer's guest kernel (Linux, Windows, or
>> BSD), a PCI device may still be referenced by the guest kernel or its services.
>> As a result, the guest never writes the eject register for ACPI-based hotplug,
>> and QEMU cannot detach the device. The customer may blame QEMU for not removing
>> it. A force-detach option could provide an escape hatch, with a warning that it
>> may make the VM unstable or insecure.
> 
> So just reboot the guest.

I agree.

Sometimes, the VM owner blames QEMU for not detaching a PCI device, even though
QEMU is technically waiting for the guest VM to write to the EJ register :(

> 
>> 3. Suppose a VM is stuck because of a guest kernel bug, such as a Linux kernel
>> panic without a kdump kernel being triggered. The guest kernel is unresponsive.
>> Force detach could allow the block device to be temporarily attached to another
>> VM without resetting the currently panicked VM.
> 
> So just reboot the guest.

I agree.

Sometimes, the VM owner blames QEMU for not detaching a PCI device, even though
QEMU is technically waiting for the guest VM to write to the EJ register :(

> 
>> 4. Provide a mechanism to demonstrate that force detach is unsafe. Otherwise,
>> users may repeatedly attempt it and mistakenly conclude that QEMU is at fault :)
> 
> We have that - we don't support unsafe detach.

Thank you very much!

Dongli Zhang

