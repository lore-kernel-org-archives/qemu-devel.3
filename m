Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F7AC3DA47
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 14:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRBns-00087m-D4; Tue, 09 Jul 2024 10:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sRBnd-00073q-FM
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:26:34 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sRBnM-0002lO-Ob
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720535176; x=1752071176;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=rMSbcG3FjkA/956ne7dFU6tsNnbwdrHjNAv6+ySCMSM=;
 b=IMOIJMgVK3v5OI1V1nOJWtUKCpNfMV6NXQ2s7FxsQmfyI20IbjM25PIo
 K0feHUM3VKy7uHinWQ10Cq7IfVNE+gvXo9kF7lDYSGrYzKh2nZACT5ZrW
 W7OOhbi5ATg/Qy5C0au/sLrte79r0bzLeGSLBiow8KZBToZbt37BkZRfQ
 hwtfv9GW2N2JxS4hUXtVQNU4VpbmtwoHe7n5XEUXsSikPnUS2oXQgiuQc
 vrGV0mu7Bajxs3eEUCryCg9mf748Q7vLH/kMcgbmOyxEyTqPsmBLkyWbL
 ns4dNtRi4f+JIfa0Yv+SQXGyQx4HuE2Zr8/khiSH/voOMia7phHTNDDe2 g==;
X-IronPort-AV: E=Sophos;i="6.09,195,1716242400"; d="scan'208";a="16172661"
X-MGA-submission: =?us-ascii?q?MDGeFlJoZcif0Gxd9c5oju/xlyOa1hR8axmOdN?=
 =?us-ascii?q?rwpFNW/Yn3HMQlpKb5W5oHK4i16K/VbjFazZoMoZNwF/xwxH5jyJPJ4u?=
 =?us-ascii?q?Yaeg7T1RJnoudnUont48OzKVWRIOQAY+9dH92xagBXE/VJuvMJaUebSN?=
 =?us-ascii?q?UU1VzxsJyL61KwOBiFX6BCWw=3D=3D?=
Received: from mail-db5eur02lp2104.outbound.protection.outlook.com (HELO
 EUR02-DB5-obe.outbound.protection.outlook.com) ([104.47.11.104])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 16:26:13 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rD1ryXXgg+SbImK77vPKOjbwkzevnw/vOWuCaNf/s7VTKChaHJTmRbydDIbaEUqFMNnGLR+rom39Y7uc2Iudf8Mfsi3RljB7qycCC94IQy/td3ZmkcyEB9ORe1QL58EefvMjvo63e29KvVM1mGLeaL5V6FTnIlIZCtC1FzdC6BIDic+gitKWgdnuC6q8V15zEnTYeZ4v4twTqDi2huSRywYMww0GeVT7RzMy5s1b2KlFD2e1X4SWGNvUklcKomiuaAglUtMsStwB+piJzRBc/gGJ1kcVWswQlfS6Q+Fbbqdb9HJlJZHpkusgVxNG03XPrOehEiZKd1KtYteatKbo4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMSbcG3FjkA/956ne7dFU6tsNnbwdrHjNAv6+ySCMSM=;
 b=pf39+yrCaTEOlm+uZkBxUd9Pylkd6UQwaO1hRd14YMv4AKFcZUFARgGOVcTr5OqPBvFabla2lM9tVGdVkn9HNbteRZs6q9tXAG9l1JIAz519HqPyV69/qvtJm6RJ2PzsKXlP7ASwLlDMsGnTmImwEMQcNT1KOqASDtnzarz1L1wQazJu4kH43LOe+Aakw/x0NBjYSmpo3QaDMMvkNa9unG08Gck/qSHKCGk84Rc+Y4kqm/I5y98lfDAZvELrkI+diiaxWZcrfGqR9bSb+kX5LIyERUsMpCgOayFhwsB5Nlo8xhBzlVFuke+yXnJDyQqg3dLvu04N//DwHijDfeh9aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMSbcG3FjkA/956ne7dFU6tsNnbwdrHjNAv6+ySCMSM=;
 b=jHaa4e6RHNBnkd5leIvT0xDE+P8HFLc0ORw/z+lFLpE6jYrOoLHjzZHd8yMhc58o5Dugz1EwM9/a9MUCcB0JgJUAS7URB57r907KzDU+InUVXB3fV1QX8hqF+L7kiXrG1KRkgpRvk9tBHol3PjRHHpw6w5l87y8NCBv7zQ0sC96LjkdnnrgAMftR0mLVEZpO0mlFSFoaphayXvFFSeJkY19s/Tu5aMLleoOXf1ZFMPk2umIr+wnyYSMPu0VIiNM5kkF0C3j5zTrOMWvWaH1RJSnqfUrQV6yVf5VYeoiC6ZW3ifEqPU0OuObGVu+afZYdi31HkYF/GvaG05rxKEDgEQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS4PR07MB8459.eurprd07.prod.outlook.com (2603:10a6:20b:4e6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 14:26:09 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 14:26:09 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>, Minwoo Im <minwoo.im@samsung.com>
Subject: [PATCH v7 2/4] intel_iommu: move VTD_FRCD_PV and VTD_FRCD_PP
 declarations
Thread-Topic: [PATCH v7 2/4] intel_iommu: move VTD_FRCD_PV and VTD_FRCD_PP
 declarations
Thread-Index: AQHa0gvxlNSFVDQ4xEy/j0fpVYVa5A==
Date: Tue, 9 Jul 2024 14:26:09 +0000
Message-ID: <20240709142557.317271-3-clement.mathieu--drif@eviden.com>
References: <20240709142557.317271-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240709142557.317271-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS4PR07MB8459:EE_
x-ms-office365-filtering-correlation-id: 4bc7f8e3-c624-4409-c3e6-08dca02313a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UVhNQk45VWpWb1RCMGR5UGdwVllVaXpRQUdieEJFQ0tDWGxxNE5xaFNQY2tp?=
 =?utf-8?B?TTNMbGFBNWp2WDZiSXhtakRaY2VDb1YyRE1DUnVtcVpud215MnBST2JVK0FJ?=
 =?utf-8?B?eEExNzF0UmdQZXdjeDBlNU1ONEc0bWc5d2tVWFN3T0tXc0w3NXFmV2kzRjRu?=
 =?utf-8?B?SlJxN2t3QUV6MjgrTUx6dGh4Z3Bwem5yL3ZiVkI5Vmp6eHRTQ203NzJKbXM3?=
 =?utf-8?B?RHA1K2pBTnBhd3VHaXBIT3RTcFRVZ2Z4Z1JtVlU2aFp0QUl2bVZMQjNIS0ps?=
 =?utf-8?B?RUNQeFlmcVBERmJzV005dWxzYVpTbVVWMDVLdS9UaUt3WDJxQVE1ZTF0TFNW?=
 =?utf-8?B?OGJHNm14SkgrSkFESnlJYVozQ1U1bmNzU2k3Kzh2MVNXUE1seFBtN2JkWDYy?=
 =?utf-8?B?RmR6UWtvNUZwV3E5N0NMaDdkMzl0U0ZmbkxWR2Z0TXRkQ3VLRUNmZG9YWXM3?=
 =?utf-8?B?YkFXYi9wbzZZcFBPVE52a3V2VG1zZXFDdWM1b25IWTF6Mkk5cXNXQ04xdHZ2?=
 =?utf-8?B?TDZObzZsLytaSFZ4OGd4QW5NZUsxbGI5eFNLYXUyazlBNmFmcDBvRmhnb2pV?=
 =?utf-8?B?bTljVk9RUDQ2VXMwWWdNMXIxWFl2a1lQc2FxWDh2aW5IUE5td04zUXh5U0Ru?=
 =?utf-8?B?bDRyTmNNakFZQXVHWm1nMDc2Z0VHTXF2cHBvNzJXYXg4NUQ1a2ROUFczTHVK?=
 =?utf-8?B?SG16amsydElYenFEU2c5ZkM2Wm1HOUUycFA4TmtqSCtoRWI4K2JDUFhTa216?=
 =?utf-8?B?bXZDN2hDM2RycFJvT2Y5RlJaVGRGTVdVelpvbVRMMFEyUHAzRmZWUDQrS3BC?=
 =?utf-8?B?ZGRtbVd3T25KbTlOeTZCYXAwdjgrVzdXbDNOR2lSeEV3d2NyRk9uUW5aZEQ3?=
 =?utf-8?B?SDBNclhxamxpMDZuRzgrL3RTY1B1a0ZGZ29ZN3d5YzE1WStKL1g4eEMzUzV4?=
 =?utf-8?B?YjlDdVRMbnNFYnlwWVg4NTF5d3dkSkZOK1FIanJVd3U2eTRxYkVPaC9CSE1P?=
 =?utf-8?B?QkY5b1pGMStJcWRGNXRtOW1OSmg1WTJGVWtNSys5bHY3Z2NJbE80SkVWVUVt?=
 =?utf-8?B?d2EwV0twOTd2Q0lSdWZuSTZZeUhXc1h5Wmk4MEFubmgwUWhUZ1hhYnV3NlFS?=
 =?utf-8?B?ZU9ycVhBUkttSVBsU042dVBvMDlRZHBWbjBwNi9lNTFNZlN6c1JJRDBFZXYv?=
 =?utf-8?B?WG5kWUFxc0V0c2kyaUR3SnRrMW1MOFhaSmlha0lKRFZWQ0F5ZVVsZ2UyYmRJ?=
 =?utf-8?B?aWVkb1dVYjRtMklHS0RvRVJzdHhpY2p0VnVadU5UamY4eGNNV2ZVeTFmS0VS?=
 =?utf-8?B?SkwwTUpScDBNckJrLzQzS0ZlVnM1STNzUXVDZmZJREF6cFJuWmxFVkxuUEtK?=
 =?utf-8?B?TEV6T3BLVDZiYW9PQnk5cnJ1WFRwTnZSU1h4UFRlYTlLZnkyaURlQUVrYTBm?=
 =?utf-8?B?NHZ6blF2M2w0OVNiTUVTbDZrZENMd0dSSUhOV25nZHMwa0NyR29hRnNxNlBt?=
 =?utf-8?B?KzBsN05pNHNVS2FhNEZNOHRUU3dFZHdOc244cUxYSjc2YUtic0NkRWg2ZFVH?=
 =?utf-8?B?WUhvNEZjb2x0Yk5URWJKbklVb2JNdDZEZllsQXlyZXZlNDYxNDhISms3cENX?=
 =?utf-8?B?anRzbkk0dTR6VEFEbG1sWjdUakxxNUw2RFpaTUxUZXNpVXJyVFVEdlpiNEJU?=
 =?utf-8?B?QWlOaTFDK1Z6WStzMkdmbFBXdEZuWTIyTDRJRjJHY0MrRUhrV2RzUVNteFJY?=
 =?utf-8?B?SG9sc2tkWXY5OTZUZ3NNN09HWitZa1d2aUkyeUNNemJ4OUJkdWEyM2lINTVM?=
 =?utf-8?B?dWhweWUxZUdobzNzY1IxeXF4Ync2S3diSGYwK3VFR1VFUlk3bldjbFhCNGFk?=
 =?utf-8?B?MVRnZHE2dmxvWjlGWFRFd2lha3lRVnpYb1o5eDlmL3gxQ0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjJ1SEM3NEw1OHJ0RHhUV3RDU3UrNU5LOXlKZnJCY3k1TEo3V1AxNWNseXJC?=
 =?utf-8?B?SElKbFU0NU1Yd094VnJsaElGUXY2U3FGNFVzTWxjbi93M0Z2R0Q2b3FJcGdE?=
 =?utf-8?B?N1FTS21adzF6c2paWWtGRVl2YUpjRTFzUDN1RkI2a29pbThCNW15Q0hpSTRi?=
 =?utf-8?B?SlBoVXI1WjI2R3BvK0tFT2x3cXZWZWYzTkFmN3lRR01scmQ3aDdIRGx4bVJx?=
 =?utf-8?B?YU1aTVdMZWJaK0VhZjJRUzZMYldWbnpibXVtazk2OWxLb2ozQ2hNWkZ6czVT?=
 =?utf-8?B?S2lNQ1FhaUhKejFrQ29EaVVmcHk4Z2EzZlNBVjBHc1dCSmNCaWs5aHVId2dF?=
 =?utf-8?B?SnpoVVBYemFrMzlBZ0Qyb1FrT0QrQlhKTFJ0YUZFd1U4ZUorR0VGOVB5NHJC?=
 =?utf-8?B?bXNkbWlZaXhSWkdNZjgzd2NsYWtaZ004T000cmY5SXUxS2VBbEgwNWJwODha?=
 =?utf-8?B?eE1reHFpSkFVZDBxMVQ3MXkrcWdXUWlPS1BlSjZRclNmQzdpUm4veDNaY3k3?=
 =?utf-8?B?eUdHTWNCWjZEM3l0NmRucnVOaEhGQjJFeVFLZ3QxelQvQlRHdy9lL2tMQ3Fn?=
 =?utf-8?B?R3haYk5wWFB4Rmc3aHIyUU9YS3E0NjdrWVpwcVpQREF2MVVUVndSY2dUYndx?=
 =?utf-8?B?T0tLMEZYeDQ4eGg3d3dKdlR6T1NVZlhqUFpBVit2UEJDNjVwSmorUjdpYlpD?=
 =?utf-8?B?Yi9FQUxIOHpkNDlHU3NKZmF1VlhFeHNQYUk1em55QnpkUTVEZ29weUhaYTk3?=
 =?utf-8?B?YmRkM0RLTjBvcUQzRjdSTnp3c1hMSGs0VHFxT0ZTUVRYbktjZzFSdmc5b3RN?=
 =?utf-8?B?M2tzM1NnZUtUOS9VaFNuRjVIKy9TTUw3V01DcXREUTNSZWJPaHZvR3Z6aGt6?=
 =?utf-8?B?Uk0vNHl1Q21YM1dnSm1rL2JxbUE3Q2Q0QlFCM1NLdC94UFdpYkNQOHAxRzZW?=
 =?utf-8?B?WmJkd2dUeWlxTHVDSWtXeWFtazU2d2tHNlVOSitSSUtkWEhuaEJGZnowNnN3?=
 =?utf-8?B?NlZUSStWMlA3NU5uaXIzQTJLLzBqQW5tdDRwVXlpRzloam1WbW96d3U2eVlC?=
 =?utf-8?B?OU8zSHVGekQzSWdkdnZOZlk2bEFwL3Q0NC9uVjc0Vktmek5zcEsyakN6eW1z?=
 =?utf-8?B?WDIrZ0ZZSjNmd1FDNFg1ck1DTmFySHcyd3Z5NWV1VGpzZTZQdlhha09TT0ZJ?=
 =?utf-8?B?eUZmQTFSalUvQ2ZGSmtPanF2VmMwNlRWQ0FwRVdRRitQS3pMZVJ6S2hQc1hl?=
 =?utf-8?B?a1pVT3RlUUh0b0t3TjFxTUZQZzJxaDYycTdBY1RjMnhVdklEYTY4UlNLZDFy?=
 =?utf-8?B?WjdGSVlYY0NxaDZoazU3ZXhLcFY4dlFGZzE5YkpqVmR2QmdOUVFHaGllTVdz?=
 =?utf-8?B?NytoVWRYMy9iNG44Ky83cVBLbExsYzQvbk1NRnJOVXdOODFOMEJNTnA5ZFhE?=
 =?utf-8?B?NXVPWERJVnk4SXM2UjlEVHBUZllkMG5HUUVCeHVsV09iejFJeEFXd0VMMDJu?=
 =?utf-8?B?Z3NJYTBRcXFMS3kwNVRmdGdRY3JMQ1lHYjl6SHgrb0Vzbm13Y09PV3V4S3Z6?=
 =?utf-8?B?YXlBam1GT1hhamIrYkNoWlQ4UkQ3R0t3Y3ZlUVlSNGdSRFZYbVYyaW8wdjIz?=
 =?utf-8?B?aUFKdUs0Ymc0R011SitCSVRtUkltQlhOaUxpbWV6Z1d4WW9JU0FwWUxRZTlq?=
 =?utf-8?B?MCtUbGRGbDBIcmE1bnJPamhQdWtBNFlpd1Nqd3FVNlRCQ0RRbUJZNjlRNUtI?=
 =?utf-8?B?K3BDZ1ZSNGg0c0ZiOElwMVphNTJNQlZ6eC9Cb2RQSkttL01VdVRqNGV0Njdv?=
 =?utf-8?B?aG9Gckp6a1R6dGR1RzBnS04vOUlHZkgweUJzQ3VUK1JUTHErMjZJcTF2NmVq?=
 =?utf-8?B?a3VYUnljSHJnMWZFWDhqb0ZhdjMwbEpJWDBGT1plRjlDQXBOOENvUTV3RFM2?=
 =?utf-8?B?M2ZGVUMvaXlqL3VudDk4U1pKVDR3NFBsVytEd3czZm5EdWMxSS9YYkI0MVVR?=
 =?utf-8?B?YTZXZUYybkcwZncwNWlWOXh4YUxyVUVia1FjcEI0QklRVnJMazZtNHlMSW51?=
 =?utf-8?B?TUtrNmJDNkRycloyQU5tbHBsbkVmemlubXZqOWJkcTJFa2diK2VrWmZUY1F0?=
 =?utf-8?B?bUhQcndCU0p2WTRUaXB3VlcwTUJsaEg5N3hkTkt0R3czRVMveU5TYzk5Vy94?=
 =?utf-8?Q?cWrJYXWEQqpeSJ94v265ykA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC6B376BE3A9A341AD12DA0533A3144C@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc7f8e3-c624-4409-c3e6-08dca02313a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 14:26:09.3614 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NWFPlI0Z8AFEtvMNCIlxkSFTzFXcVKFJY0ThdIyqxEyIsDn48vS04ehHeJZ6JOR1g7cP14/RptyjN/G08+i2TtLmNeBar5niTOfVgY6IVkVAm2FDzDRPXJDOEIXal0Bq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8459
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
bi5jb20+DQoNClRoZXNlIDIgbWFjcm9zIGFyZSBmb3IgaGlnaCA2NC1iaXQgb2YgdGhlIEZSQ0Qg
cmVnaXN0ZXJzLg0KRGVjbGFyYXRpb25zIGhhdmUgdG8gYmUgbW92ZWQgYWNjb3JkaW5nbHkuDQoN
ClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0t
ZHJpZkBldmlkZW4uY29tPg0KUmV2aWV3ZWQtYnk6IE1pbndvbyBJbSA8bWlud29vLmltQHNhbXN1
bmcuY29tPg0KUmV2aWV3ZWQtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KLS0tDQog
aHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgNCArKy0tDQogMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2h3L2kzODYv
aW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0K
aW5kZXggY2JjNDAzMDAzMS4uZmFlYTIzZThkNiAxMDA2NDQNCi0tLSBhL2h3L2kzODYvaW50ZWxf
aW9tbXVfaW50ZXJuYWwuaA0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQpA
QCAtMjY0LDEwICsyNjQsMTAgQEANCiAjZGVmaW5lIFZURF9GUkNEX0ZSKHZhbCkgICAgICAgICgo
KHZhbCkgJiAweGZmVUxMKSA8PCAzMikNCiAjZGVmaW5lIFZURF9GUkNEX1NJRF9NQVNLICAgICAg
IDB4ZmZmZlVMTA0KICNkZWZpbmUgVlREX0ZSQ0RfU0lEKHZhbCkgICAgICAgKCh2YWwpICYgVlRE
X0ZSQ0RfU0lEX01BU0spDQotLyogRm9yIHRoZSBsb3cgNjQtYml0IG9mIDEyOC1iaXQgKi8NCi0j
ZGVmaW5lIFZURF9GUkNEX0ZJKHZhbCkgICAgICAgICgodmFsKSAmIH4weGZmZlVMTCkNCiAjZGVm
aW5lIFZURF9GUkNEX1BWKHZhbCkgICAgICAgICgoKHZhbCkgJiAweGZmZmZVTEwpIDw8IDQwKQ0K
ICNkZWZpbmUgVlREX0ZSQ0RfUFAodmFsKSAgICAgICAgKCgodmFsKSAmIDB4MVVMTCkgPDwgMzEp
DQorLyogRm9yIHRoZSBsb3cgNjQtYml0IG9mIDEyOC1iaXQgKi8NCisjZGVmaW5lIFZURF9GUkNE
X0ZJKHZhbCkgICAgICAgICgodmFsKSAmIH4weGZmZlVMTCkNCiAjZGVmaW5lIFZURF9GUkNEX0lS
X0lEWCh2YWwpICAgICgoKHZhbCkgJiAweGZmZmZVTEwpIDw8IDQ4KQ0KIA0KIC8qIERNQSBSZW1h
cHBpbmcgRmF1bHQgQ29uZGl0aW9ucyAqLw0KLS0gDQoyLjQ1LjINCg==

