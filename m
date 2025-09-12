Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3EFCAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 15:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux5eI-000084-NM; Fri, 12 Sep 2025 11:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ux5eF-00007J-VK; Fri, 12 Sep 2025 11:25:16 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ux5eC-0004rD-4t; Fri, 12 Sep 2025 11:25:15 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CEdiPp009572;
 Fri, 12 Sep 2025 15:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2025-04-25; bh=CEnSPwa7fcxVIXAqSK
 OWyIQQfCZkDDwGYaymY4Jng7c=; b=Am8FF8MtAZzznN11m6ucYl7HVWnXJZyksb
 AqBZ3STDI+pMBg5nVnY8ehWvMpRtihGLVvW7vzoJmFeskD2OzL0OU1ZadZ2LytWA
 dC4frtSPgswk8AD6p7+QLY1leNgdS+ogzA05bmqhUL5tEyJtuZmUXEkvSQ7i/dMM
 UCBNrQz7xWf7DKqAlX4d6QqLPvOmk++SKqJ3nsV0avYd9ih19HuJxTZ/qYOfgkW6
 SGCvdTPylbN/dYeyow7KvKTt7qgQChzus0c3HZVtDEPrmq/vcobrdTpZ9CguYebm
 hJJwI1mGCk0RcuJZ7mgtA9eRfhTxDXzR0n6qcCP8NEd2uJPMb3JA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921m30dyd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Sep 2025 15:25:06 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58CFIbpN030644; Fri, 12 Sep 2025 15:25:06 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012060.outbound.protection.outlook.com
 [40.93.195.60])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 490bddy9kf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Sep 2025 15:25:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mt4fwoudadI0Jkn3DoVQST1giIPKOcqSMd0InviZPrv4qs+3Q1nxxAGdJ2Ol+JDtmrxcmvh5xzO7VhcqFmkFlVzJQuQCuT6p4r9JNIghWsmrd7oezTCbJEgJWumgpjM3qKD5HM3fL87XDyYTX6oSfacrOQToFg1HlIZDj32DiaR+3pxRMoSB9TBuIrJKZA2Tl9hmEGS++bHj1pBav1uHzTMSXLws2OTNHHcbf4YawNjyBLnYwpN7CxHQB14jC9SZH+gdUPP0/JNQiEzAbtTwbXEyWwGV/3BbwMY7VowAGE1s15l2Ja5eBwSmVEzVapO8TLV1XvxR7C3Hoips2DTgnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEnSPwa7fcxVIXAqSKOWyIQQfCZkDDwGYaymY4Jng7c=;
 b=OZi8Na8zICE0e5NWxPOvZdgxdwai00NxO6ZVWqxjcev4iET+X+bWPPk7qTw6fmTdBZIWDG+jggyZcWljEySzMHuyZucSpTAsMUgCNbsIPZR2OdATcIHvP5peBlj3kBBbchj0c+QN+UcrAGLOwzbQqDBH2JYek9xpTD4EcVAC8tu6Qads/WrNsYngLZPJizqzGHgVmbkE6NLKpw+4rT4EGb9XcSFjtB0hjvHnhecDPt32VRY0lDV/LRO1yIUzSqY+Rqv5MQD9BQD0EBAf9Wm0/Njr7ZwgLITu/72cmi7bkfU9gONe0VMwb8U5j6YUBSzdaSOGwUvRESeBI2mimB4sZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEnSPwa7fcxVIXAqSKOWyIQQfCZkDDwGYaymY4Jng7c=;
 b=F+391/265bd1RdeQbDONeE2IK93xUmUHnpEBRxQip6Va+WTi6o+jKyBgZHQFJ3JG5CwRPgLrN6HH7e4K0+GVEZwfGr3rD/ZeM++DU3PeCciGiBM0Dh/WS9AYjWRNsstYiuV/7IuxDKzctuwkxRHLIYE5ZpQlPEBx9aaViV6cnkc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY5PR10MB6168.namprd10.prod.outlook.com (2603:10b6:930:30::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 15:25:02 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 15:25:01 +0000
Content-Type: multipart/mixed; boundary="------------EYRkVIiTMXkIkus5Dn450Y3A"
Message-ID: <1227d603-dde3-403b-aa79-3f22b43d12fb@oracle.com>
Date: Fri, 12 Sep 2025 11:24:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/33] chardev-add: support local migration
To: Markus Armbruster <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 den-plotnikov@yandex-team.ru, Laurent Vivier <lvivier@redhat.com>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-25-vsementsov@yandex-team.ru>
 <87wm634t3v.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87wm634t3v.fsf@pond.sub.org>
X-ClientProxiedBy: PH8P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::10) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY5PR10MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: 5092af50-9261-40d7-69e3-08ddf2108a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|4053099003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UU9MZndKYkxZQUZDN0IyZWxoT0F4RmRMemltQTN1d2hCRWNER0hxQnF2bXc2?=
 =?utf-8?B?T2ZCdUJpSDA1T0lVQTVYNkFjZFpXemVSMGNLVmN4L1ZSbFhEQ2ViRzBHS3p6?=
 =?utf-8?B?Zm1EK0tGMWF5blBhaHZMamRsUmQ1SGRHTkVlQlRxWlhLVUc5dXN1TmtUUTVD?=
 =?utf-8?B?anIwcmI4aXc1c2FmOHRnOHNVcERlbFNYMFgzMnpzaVZINFFXWHUzZnhPZklO?=
 =?utf-8?B?ZE1vZGFQbldTQTkrQi82NHc4WEFvajJJTHdhTUc3RFRVMkEyYWtKdUlhYkhV?=
 =?utf-8?B?SWxLcDhiTkdkcXMyQWRtNThwK3gzUUs3a1dYM0c0MFJCTkdBaXljTjdlUitY?=
 =?utf-8?B?aVErckduSWNjb2ErRnhvUWtkQUpIcG1FY2MrMVJLanVQQlRkckpyVnJZUkRy?=
 =?utf-8?B?bW1JMzVhNUsyWGFlZG91TlpHYnlhWHEzV1BVa3ZyWSsyQk1mQUVtUDVTVHhW?=
 =?utf-8?B?TzBoaExBb3JwSzBFYzJ0V2Z4TldvTVF0M1VIdmdRNUtaY3FsZklaSlhxMVZq?=
 =?utf-8?B?TFRoOHRSN0duM1RKcW5xY3l2UXNKWlVJTGtaTE01Nm1jcWNsSUJHcTk5VHlB?=
 =?utf-8?B?L21RQjBhQmw1UkF1U0g4NWdidFJrbENuaExuTW5vbmg2Ulc0ekpRblF5YllZ?=
 =?utf-8?B?UkVFZzBHQngySWdPdXNSWEJWamJkN0MxZXkzU3hoVVNFVzdUQTR6K2ptRkxi?=
 =?utf-8?B?NWxuZHhvakZDMWpwU0R0N2VTaE55UDgvRFFLeW5OVDNzNWxyWm9pdW9lK2Fo?=
 =?utf-8?B?SG5EUGxVMWhrRkJFK2xEQjk0emovWkFCYjJWeEp4NUZJWVpLTllqYUkvMThq?=
 =?utf-8?B?dW1WZWlEdW9WeFY3MHlnYzhsR0dIU0VCeVBaSTgxbDFRZy9VRE1uZDh4QmZ5?=
 =?utf-8?B?ZVJKc1gra2Nsd2hNN0x5WDI4dkJTaUJ4Ym44M3RwT3g2TldNRnY2b3oxVTd4?=
 =?utf-8?B?NVlyRmtSV1Y4cmY5V2Y0L2lzM2lIcXhQMjd4dVpndXR0YUo0UWNHZWdsanNq?=
 =?utf-8?B?aW5pU0gyelRpQXhpR3Q2NEE4aU5tUW1aNUJTRC9DWGtZWDVVWWMyaW1EYXRl?=
 =?utf-8?B?QS9LNWdWanJTNlVJL0FaYjlHUmtxTEJScnFub25EZzFVOUgwc1N6VVcvbnI1?=
 =?utf-8?B?NW9LSFB0TDZCSldIU282Nkg0bzVkWW5kby9MOWxzTzNzM2pGaW9EL1JhRXV2?=
 =?utf-8?B?TlZldXoweGkwUzNBeUhVYW41NHRtMWdNazd5UFNoL1VndXJ2YzhzVGU1dVkv?=
 =?utf-8?B?ZDFTc3VWbmtkREtCSGlzcVJKWXVoQzJyRGg2MW5JdFA0Z0ZEM0UyZEtBRW5Z?=
 =?utf-8?B?blJleFp2SS9NT2p6ZDJXYlFES3BLa1dyRU1ha3pKZzYwRWhOVy8vcmhEWERH?=
 =?utf-8?B?RzZmOGtGb2I4SStDQlBZUVd5NWZXL1NDUFNFUVdobk4yWDlxc3RVQlN6Rll1?=
 =?utf-8?B?djhpU3Q0TkJpbzcxM2VHaHoyWllxUmg5VFNQRUFVWlY4OG1mS0Jyd05GcVNx?=
 =?utf-8?B?aHlYUExtWlhja2wyV3ZpUjhKQ004TW1TL0pvSHNBZFB4OU85bk5INFVhRFN2?=
 =?utf-8?B?NkpUdHI5WVFmWnh0RFRnKzEwQVVzUFo2K1VLTWs2RVRrd3J5eUZ4bW9za2lK?=
 =?utf-8?B?Z1FFMVI2V3pLUGZuRmlBYXEyQ2FPQU5zTEFmK25iSUdHNC9rejNlU21qZTJN?=
 =?utf-8?B?RGNxVExxVlE2eGpRZS92cFpaMldWeHgzMkJzckNHeFNhS2xUQkpocm9jSEtU?=
 =?utf-8?B?cS9abzNFZDFENUdJSk5vbHEydWpmNDBGcmVQWXlWZ0lZenc0NFFHNGl2cVdo?=
 =?utf-8?B?aE9JWHkrNVN2NThHWHFuMnJlRkVmV0ozTGsxSnpCTHIrMC9SMVVSMnI5cEo3?=
 =?utf-8?Q?UCe+1TbSgy5HC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(4053099003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUZ2ZWpXK3RreEROdVBuaklQc0lkV3B1RlNieFpvcStYVDhUVy8xdVpYSWZU?=
 =?utf-8?B?N0EzMUZnYm0wQTVZQ2Z0cDUxUVpkZVd6T0NOTjlIVHltbWNCL1dacnZhVmtj?=
 =?utf-8?B?cDkxUi8xUkRSOWVjSCs0U1poV0JrVG92RHdkZitmU1VLemNsOUdOM2h0S0dT?=
 =?utf-8?B?ZVl4cnBrSTB4M0pIV0hTQXdQVXNsMmQwbDJDdkxPNlQ2TTlBeW1RZzJoWW9E?=
 =?utf-8?B?dlFkVjVvekc4UWlZUjNsUXdWZ3IxZ1BvTzZmaGs5c1NUUE9UcEZ1b1JuMm5B?=
 =?utf-8?B?N0FIRFp0UmVXN2ZWMnAxZkRCU1hRaWpZWWVHQWV0eTZHaVltV1dPU2owWUhU?=
 =?utf-8?B?K3I1RmdIcmEvcDN4RVc3R2hRRDVvbGRoR0FKVUdMcGd3RkxSak1pcjR5bkJT?=
 =?utf-8?B?QnJmM0lBckRDZFdFOFhvZE5yZnI5ZWJZQTkyTVBNQWg2bTc3R0d4eURWVVdU?=
 =?utf-8?B?SmN0a2t2UGY4VlpHN3VvTm9Xc09ZRnhJVmJzR0xadENGK1NWamFuQlZnbExj?=
 =?utf-8?B?eXdzU0JvRWpOMUpLUGlrVFlyd1dYaFJYT1UvL2doQUZIMjNiOWNoTTV0ZUFp?=
 =?utf-8?B?Q0ZjRFRZUThwOHlsMUNBQjlUR1d0blNnTCtQZzRleTFQc3c1bm95OFluWWow?=
 =?utf-8?B?cXZRWWRnbmtrMit2ZTNJTE5LYUhGb1ZXMlB4b0d3bUF6VkRSa3pxSDZDaVZh?=
 =?utf-8?B?R3JkWUVDN2pzbFRZZjZZZHpCaURrMTQyNnVNbU1lNEJlK1M3R3BNRnNoeXE1?=
 =?utf-8?B?UG84RXNpLy9QN2I0SVZQMWxJSmlhMExqOTVsMHFkTWU4U1Zodm5SelNCblVP?=
 =?utf-8?B?dk5JUmk3TzNQLzJSVnI4eUtFTXhYdTNTQXVmbndWM29rNzdPZjBnd0ZWajNk?=
 =?utf-8?B?VjNDbUZYSk9uOENHMys3ZEcwQXV2VWY0d0RRdzB4TXZRd3EvQnVSVW40TlU1?=
 =?utf-8?B?UlRPUDg0U3pJeEtUM3FwVEY0b0JQRklLdWJNa2NrTnpvZkJSUHJVZWFqd1dp?=
 =?utf-8?B?WHNyMVBUU0lwTWgxcEtWOTd5RHB5TzZRREVRc1U0T1FUaWlSUkk0TVFFTjJZ?=
 =?utf-8?B?MCtCNElnQklscHZ0Y1dkKzFMd3ZvTWN4RW5WOWtwOTBFb1IzOEdvV1VhNlFX?=
 =?utf-8?B?WEJJbk1NZVBCcjFRaVJwbkFDSHV3TDBpNmEyQ2txYmpsdDh6Z2pxYzBwcWZ1?=
 =?utf-8?B?d3NVcW1kMUhIRWhpMGF5cDBmUjcxcFB0UCtiUW5YR09oWmw4eXFYWDl5dW5Z?=
 =?utf-8?B?NDQwaUlpUGRnTkRsdW9aazVCNXBNNkVPQ3Njem1KWCttRDd1YlJCWTVnYmE5?=
 =?utf-8?B?NFdIZmkxL05RWlUzbjMvOGtTWm1TaVRXaFhKMktaOFdBK1p3cWNaVE9HSFNN?=
 =?utf-8?B?SWd5b3VKRDZsOE9BMlErTENPWkNnYVVYbjZFSnQzdm9vQWZUS0FsbUVMWGlG?=
 =?utf-8?B?cXEvb3ZWUzBBWTNldDI3TUxaRlpURHRvL3lXcmdkc1lMVlQ5dm8rK0tuUDFP?=
 =?utf-8?B?akU3ZVpVNXdORkxrZXdXbGw0a1NZd3BXZm9GbHk5Mld6a3FoVXVMMVk2OGw0?=
 =?utf-8?B?WTZ2UWpQTFh4WmE1TTV5SVp4MXppK2t2OVBmZmlDNmZrdGd2SytXV2FMaFo3?=
 =?utf-8?B?ODE1b2kxZ3VnM1ZqZmxEdy93RnRHR0d5QTJvWkZqdjRKKzdTOENRUVhlclJo?=
 =?utf-8?B?L3FaTU1lcFlDYTNFbUNCbGdaZk1DSlRVcHhUZVE5TVVSYkQ3VkJBMUZoemV1?=
 =?utf-8?B?Z2k4ajlhNzNQcGxNeno4UElrci9nNWw2emZENTA1K2F0MzA1T0Rlci9jTnZh?=
 =?utf-8?B?WmFiNmU5bWVsYXdSRGY1b1lOdjU2Tml3THhMbXNFcmJXbGQ5TUhjV0ZMKzBL?=
 =?utf-8?B?ZlplajNYYk1GbXgvMHhJS3hOMW9JTkgxTjFrKy9EWHdTL3NrUk4vaTlsK3Rk?=
 =?utf-8?B?cHp0akhoMDNBa2lRMEZGQnc2UXRzUFdvRVZ2dWZSRHdFVUxUdDczbGNtYk44?=
 =?utf-8?B?KzFlQzM0U2REdmljeHdEUnlZZXBXWUtnSG5vUzhlYTRFOXgwYnN3MUtlbEs4?=
 =?utf-8?B?TmxicTBqNlB6Z3gzUXA3WTRBNEdQdUVHdGV6aXN2WDZkWWhNWlIwMkxEQVlD?=
 =?utf-8?B?b3BMKzVNM3FPa1lMNjBkUjhreldDRHhibEFId1NMRmhqaXE0NXkxblgwR1dz?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tmdfVOJ8FFkeC6IMDb5lkgiolVXZnNh5B9ENsJZLTCMpJPU1EUPfIaPxNMeACD7d2YLIZY/27Z48ZQB9cVtX82vCsC+CuBUVnjGag+b4K2/ElBlUGiOEAzcy4HUAF3P/1mOo8Uzyl6aNviRv1TSa734Ka0p4pwzHnx7XU1GFNgZHAVXTzt5S2jaJmywl3RLvUNaMLLAhopUg/ME6Wj33J7j6LDCnnr5I7B2EhC+SuARLk6rBznNmHRxMZn8jrBAK0bMb3jecjxsim5PdlTs4Iu0JftDOvrlZfhaV1LrEkaTFpETwlfyc0Bo5NW8jikjDo39cnTvAYh0x1PchSC39cj8gnvk0nbUjzTZNytLVNgGmyIbK/J0lZWHmecdLO+477+RQoeUXo1RodHmiSbE9M3wY04JEI0CmhX35ZQnoIPeuRCwfxxQ6BfQg6nguK4fFdCgJY2qCkL5nw69P94xpDgnFSaXdSuJxgpJNxeqYNODGy8gZ8MGXCGgrM8k2+cEJjNEA861Nk05ml/tUF9h7+N4wvhDk/QOnlKOfXEZSbhfn7r5tont7CDYrJc8Qd+V8BHn6OdjZXChPSkQ40NY4jz+R3je0qe4loejI86rBcjQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5092af50-9261-40d7-69e3-08ddf2108a74
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 15:25:01.5337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nELAkO156wChWJ3CFOmHBkQdqpvBCLgLsL/dYGvg4rOwFcYxvY14fi+6pdUdJru1jGbaClDGv2AhRiho42PO6UV3mqrWG+a0FTX9/Mfmi0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6168
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509120143
X-Proofpoint-GUID: Hj_gCTbp82a1iRcj4vjz0GNh500jzN_c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MSBTYWx0ZWRfXwfqHoyRsUpmG
 38uk2XDO+GV1Vpgm1LAio4fGzNuyNDFaTfyeNV9bWN2N+59AewfVe3I6iLGGCsuRugvrCT3dT56
 IjbTq8IRnqZdziMXll4Cje1OWJOyUfaHnE6wZsl8fUB8UulNu2OvFP3VmXFvRZAQf2Lh7cT5Qfe
 KhThCPgQOw85nKLYYFbXM2VcS4uHW1GPcetQL2t0/cOGpkPvHpSiAJBtDbLMmY6Tl1ujP3QKjL+
 1Y6kL/2YM0xFaqdhuK+9XUeBAXiRI7dX5RMYr6f654a7t8sCRGUaZ4F9Ldw2P2VMbq0Mwy4oIp9
 BtQE8OSmlcXF8OwYWxuATyRalXuHVw+kXBQLMLXq/ovza3MWswmO/+cO6WCp7y9ld6KvzT1gUsl
 cJ5MK6Ib
X-Authority-Analysis: v=2.4 cv=Dp5W+H/+ c=1 sm=1 tr=0 ts=68c43b53 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=6R7veym_AAAA:8
 a=D79ZCMnwjrwhpQU4n4cA:9 a=QEXdDO2ut3YA:10 a=kGBboVoqsxyZm1hvX2wA:9
 a=B2y7HmGcmWMA:10 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-ORIG-GUID: Hj_gCTbp82a1iRcj4vjz0GNh500jzN_c
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--------------EYRkVIiTMXkIkus5Dn450Y3A
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/2025 10:56 AM, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> This commit introduces a possibility to migrate open chardev
>> socket fd through migration channel without reconnecting.
>>
>> For this, user should:
>>   - enable new migration capability local-char-socket
>>   - mark the socket by an option support-local-migration=true
>>   - on target add local-incoming=true option to the socket
>>
>> Motivation for the API:
>>
>> 1. We don't want to migrate all sockets. For example, QMP-connection is
>>     bad candidate, as it is separate on source and target. So, we need
>>     @support-local-migration option to mark sockets, which we want to
>>     migrate (after this series, we'll want to migrate chardev used to
>>     connect with vhost-user-server).
>>
>> 2. Still, for remote migration, we can't migrate any sockets, so, we
>>     need a capability, to enable/disable the whole feature.
>>
>> 3. And finally, we need a sign for the socket to not open a connection
>>     on initialization, but wait for incoming migration. We can't use
>>     @support-local-migration option for it, as it may be enabled, but we
>>     are in incoming-remote migration. Also, we can't rely on the
>>     migration capability, as user is free to setup capabilities before or
>>     after chardev creation, and it would be a bad precedent to create
>>     relations here.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> [...]
> 
>> diff --git a/qapi/char.json b/qapi/char.json
>> index f0a53f742c..5b535c196a 100644
>> --- a/qapi/char.json
>> +++ b/qapi/char.json
>> @@ -280,11 +280,23 @@
>>   #     mutually exclusive with @reconnect.
>>   #     (default: 0) (Since: 9.2)
>>   #
>> +# @support-local-migration: The socket open file descriptor will
>> +#     migrate if this field is true and local-char-socket migration
>> +#     capability enabled (default: false) (Since: 10.2)
>> +#
>> +# @local-incoming: Do load open file descriptor for the socket
>> +#     on incoming migration. May be used only if QEMU is started
>> +#     for incoming migration and only together with local-char-socket
>> +#     migration capability (default: false) (Since: 10.2)
>> +#
>>   # Features:
>>   #
>>   # @deprecated: Member @reconnect is deprecated.  Use @reconnect-ms
>>   #     instead.
>>   #
>> +# @unstable: Members @support-local-migration and @local-incoming
>> +#            are experimental
>> +#
>>   # Since: 1.4
>>   ##
>>   { 'struct': 'ChardevSocket',
>> @@ -298,7 +310,9 @@
>>               '*tn3270': 'bool',
>>               '*websocket': 'bool',
>>               '*reconnect': { 'type': 'int', 'features': [ 'deprecated' ] },
>> -            '*reconnect-ms': 'int' },
>> +            '*reconnect-ms': 'int',
>> +            '*support-local-migration': { 'type': 'bool', 'features': [ 'unstable' ] },
>> +            '*local-incoming': { 'type': 'bool', 'features': [ 'unstable' ] } },
>>     'base': 'ChardevCommon' }
>>   
>>   ##
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 2387c21e9c..4f282d168e 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -517,6 +517,11 @@
>>   #     each RAM page.  Requires a migration URI that supports seeking,
>>   #     such as a file.  (since 9.0)
>>   #
>> +# @local-char-socket: Migrate socket chardevs open file descriptors.
>> +#     Only may be used when migration channel is unix socket. Only
>> +#     involves socket chardevs with "support-local-migration" option
>> +#     enabled.  (since 10.2)
>> +#
>>   # Features:
>>   #
>>   # @unstable: Members @x-colo and @x-ignore-shared are experimental.
>> @@ -536,7 +541,8 @@
>>              { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>>              'validate-uuid', 'background-snapshot',
>>              'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
>> -           'dirty-limit', 'mapped-ram'] }
>> +           'dirty-limit', 'mapped-ram',
>> +           { 'name': 'local-char-socket', 'features': [ 'unstable' ] } ] }
>>   
>>   ##
>>   # @MigrationCapabilityStatus:
> 
> I understand why we need a knob to enable the feature.  A
> MigrationCapability looks fine to me.  We could perhaps come up with a
> better name, but let's leave that for later.
> 
> I'm unsure about making users mark the sockets (really: the sockets
> wrapped in a character device backend) to be migrated that way.
> 
> Which sockets are users supposed to mark, and how would they know?
> 
> What happens when a user marks the QMP socket?  You called that a "bad
> candidate".
> 
> Doesn't feel like good user interface design.
> 
> Could QEMU decide (in principle) which sockets are suitable for
> sending down the migration channel?
> 
> If yes, could we make it do the right thing automatically?  Or at least
> a check that stops the user from doing the wrong thing?
> 
> [...]

Hi Vladimir, I did not notice this patch before.
I also submitted patches for preserving chardevs including sockets, here:
   https://lore.kernel.org/qemu-devel/1658851843-236870-40-git-send-email-steven.sistare@oracle.com
and have fixed more bugs since then. I have attached my latest unsubmitted version
from my workspace.

My interface for enabling it is here:
   https://lore.kernel.org/qemu-devel/1658851843-236870-37-git-send-email-steven.sistare@oracle.com/

I am not wedded to either the interface or my socket patch, but the capability
must be supported for CPR.  And an acknowledgement of the prior work would
be nice.

- Steve


--------------EYRkVIiTMXkIkus5Dn450Y3A
Content-Type: text/plain; charset=UTF-8;
 name="0001-chardev-cpr-for-sockets.patch"
Content-Disposition: attachment; filename="0001-chardev-cpr-for-sockets.patch"
Content-Transfer-Encoding: base64

RnJvbSAyNjJlZmY3NTZmNDI1ODYyYzRhZmJkNTIyMTI4ZTdiZjM4ZDUwMTE4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUu
Y29tPgpEYXRlOiBUdWUsIDIwIEZlYiAyMDI0IDA2OjI1OjU3IC0wODAwClN1YmplY3Q6IFtQQVRD
SF0gY2hhcmRldjogY3ByIGZvciBzb2NrZXRzCgpTYXZlIGFuIGFjY2VwdGVkIHNvY2tldCBhbmQg
cmVzdG9yZSBpdCBhZnRlciBjcHIuICBSZS1jcmVhdGUgdGhlCmNvcnJlc3BvbmRpbmcgbGlzdGVu
IHNvY2tldCwgYnV0IGRvIG5vdCBsaXN0ZW4gYWdhaW4gdW50aWwgdGhlIGFjY2VwdGVkCnNvY2tl
dCBpcyBjbG9zZWQuCgpTYXZlIGEgY29ubmVjdGVkIHNvY2tldCBhbmQgcmVzdG9yZSBpdCBhZnRl
ciBjcHIsIGFuZCBkbyBub3QgcmUtY29ubmVjdAp2aWEgcW1wX2NoYXJkZXZfb3Blbl9zb2NrZXRf
Y2xpZW50LiAgSG9pc3QgdGhlIHNldHRpbmcgb2YKcy0+cmVjb25uZWN0X3RpbWVfbXMgc28gd2Ug
c3RpbGwgcmVjb25uZWN0IHdoZW4gdGhlIHNvY2tldCBpcyBjbG9zZWQuCgpTaWduZWQtb2ZmLWJ5
OiBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPgotLS0KIGNoYXJkZXYv
Y2hhci1zb2NrZXQuYyAgICAgICAgIHwgODMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLQogaW5jbHVkZS9jaGFyZGV2L2NoYXItc29ja2V0LmggfCAgMSArCiAyIGZp
bGVzIGNoYW5nZWQsIDc4IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvY2hhcmRldi9jaGFyLXNvY2tldC5jIGIvY2hhcmRldi9jaGFyLXNvY2tldC5jCmluZGV4IDFl
ODMxMzkuLmY4M2YwNzggMTAwNjQ0Ci0tLSBhL2NoYXJkZXYvY2hhci1zb2NrZXQuYworKysgYi9j
aGFyZGV2L2NoYXItc29ja2V0LmMKQEAgLTI2LDYgKzI2LDcgQEAKICNpbmNsdWRlICJjaGFyZGV2
L2NoYXIuaCIKICNpbmNsdWRlICJpby9jaGFubmVsLXNvY2tldC5oIgogI2luY2x1ZGUgImlvL2No
YW5uZWwtd2Vic29jay5oIgorI2luY2x1ZGUgIm1pZ3JhdGlvbi9jcHIuaCIKICNpbmNsdWRlICJx
ZW11L2Vycm9yLXJlcG9ydC5oIgogI2luY2x1ZGUgInFlbXUvbW9kdWxlLmgiCiAjaW5jbHVkZSAi
cWVtdS9vcHRpb24uaCIKQEAgLTM2MCwxMSArMzYxLDUyIEBAIHN0YXRpYyB2b2lkIGNoYXJfc29j
a2V0X3lhbmtfaW9jaGFubmVsKHZvaWQgKm9wYXF1ZSkKICAgICBxaW9fY2hhbm5lbF9zaHV0ZG93
bihpb2MsIFFJT19DSEFOTkVMX1NIVVRET1dOX0JPVEgsIE5VTEwpOwogfQogCitzdGF0aWMgdm9p
ZCBjcHJfc2F2ZV9zb2NrZXQoQ2hhcmRldiAqY2hyLCBRSU9DaGFubmVsU29ja2V0ICpzaW9jKQor
eworICAgIFNvY2tldENoYXJkZXYgKnNvY2tjaGFyID0gU09DS0VUX0NIQVJERVYoY2hyKTsKKwor
ICAgIGlmIChzaW9jICYmIGNoci0+Y3ByX2VuYWJsZWQgJiYgIXNvY2tjaGFyLT5jcHJfcmV1c2Vk
KSB7CisgICAgICAgIGNwcl9zYXZlX2ZkKGNoci0+bGFiZWwsIDAsIHNpb2MtPmZkKTsKKyAgICB9
Cit9CisKKy8qCisgKiBSZXR1cm4gMCBpZiBmZCBpcyBmb3VuZCBhbmQgcmVzdG9yZWQsIC0xIGlm
IGZvdW5kIGJ1dCBhbiBlcnJvciBvY2N1cnJlZCwKKyAqIGFuZCAxIGlmIG5vIGZkIGZvdW5kLgor
ICovCitzdGF0aWMgaW50IGNwcl9sb2FkX3NvY2tldChDaGFyZGV2ICpjaHIsIEVycm9yICoqZXJy
cCkKK3sKKyAgICBFUlJQX0dVQVJEKCk7CisgICAgU29ja2V0Q2hhcmRldiAqc29ja2NoYXIgPSBT
T0NLRVRfQ0hBUkRFVihjaHIpOworICAgIFFJT0NoYW5uZWxTb2NrZXQgKnNpb2M7CisgICAgY29u
c3QgY2hhciAqbGFiZWwgPSBjaHItPmxhYmVsOworICAgIGludCBmZCA9IGNwcl9maW5kX2ZkKGxh
YmVsLCAwKTsKKworICAgIHNvY2tjaGFyLT5jcHJfcmV1c2VkID0gKGZkID49IDApOworICAgIGlm
IChmZCAhPSAtMSkgeworICAgICAgICBzb2NrY2hhciA9IFNPQ0tFVF9DSEFSREVWKGNocik7Cisg
ICAgICAgIHNpb2MgPSBxaW9fY2hhbm5lbF9zb2NrZXRfbmV3X2ZkKGZkLCBlcnJwKTsKKyAgICAg
ICAgaWYgKHNpb2MpIHsKKyAgICAgICAgICAgIHRjcF9jaHJfYWNjZXB0KHNvY2tjaGFyLT5saXN0
ZW5lciwgc2lvYywgY2hyKTsKKyAgICAgICAgICAgIG9iamVjdF91bnJlZihPQkpFQ1Qoc2lvYykp
OworICAgICAgICB9IGVsc2UgeworICAgICAgICAgICAgZXJyb3JfcHJlcGVuZChlcnJwLCAiY291
bGQgbm90IHJlc3RvcmUgc29ja2V0IGZvciAlcyIsIGxhYmVsKTsKKyAgICAgICAgICAgIHJldHVy
biAtMTsKKyAgICAgICAgfQorICAgICAgICByZXR1cm4gMDsKKyAgICB9CisgICAgcmV0dXJuIDE7
Cit9CisKIHN0YXRpYyB2b2lkIHRjcF9jaHJfZnJlZV9jb25uZWN0aW9uKENoYXJkZXYgKmNocikK
IHsKICAgICBTb2NrZXRDaGFyZGV2ICpzID0gU09DS0VUX0NIQVJERVYoY2hyKTsKICAgICBpbnQg
aTsKIAorICAgIGlmIChjaHItPmNwcl9lbmFibGVkKSB7CisgICAgICAgIGNwcl9kZWxldGVfZmQo
Y2hyLT5sYWJlbCwgMCk7CisgICAgfQorCiAgICAgaWYgKHMtPnJlYWRfbXNnZmRzX251bSkgewog
ICAgICAgICBmb3IgKGkgPSAwOyBpIDwgcy0+cmVhZF9tc2dmZHNfbnVtOyBpKyspIHsKICAgICAg
ICAgICAgIGNsb3NlKHMtPnJlYWRfbXNnZmRzW2ldKTsKQEAgLTkyMyw2ICs5NjUsOCBAQCBzdGF0
aWMgaW50IHRjcF9jaHJfbmV3X2NsaWVudChDaGFyZGV2ICpjaHIsIFFJT0NoYW5uZWxTb2NrZXQg
KnNpb2MpCiAgICAgICAgIHRjcF9jaHJfY29ubmVjdChjaHIpOwogICAgIH0KIAorICAgIGNwcl9z
YXZlX3NvY2tldChjaHIsIHNpb2MpOworCiAgICAgcmV0dXJuIDA7CiB9CiAKQEAgLTEyMjgsNiAr
MTI3Miw3IEBAIHN0YXRpYyBnYm9vbGVhbiBzb2NrZXRfcmVjb25uZWN0X3RpbWVvdXQoZ3BvaW50
ZXIgb3BhcXVlKQogc3RhdGljIGludCBxbXBfY2hhcmRldl9vcGVuX3NvY2tldF9zZXJ2ZXIoQ2hh
cmRldiAqY2hyLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9v
bCBpc190ZWxuZXQsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBi
b29sIGlzX3dhaXRjb25uZWN0LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYm9vbCBkb19saXN0ZW4sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBFcnJvciAqKmVycnApCiB7CiAgICAgU29ja2V0Q2hhcmRldiAqcyA9IFNPQ0tFVF9D
SEFSREVWKGNocik7CkBAIC0xMjU5LDExICsxMzA0LDE1IEBAIHNraXBfbGlzdGVuOgogCiAgICAg
aWYgKGlzX3dhaXRjb25uZWN0KSB7CiAgICAgICAgIHRjcF9jaHJfYWNjZXB0X3NlcnZlcl9zeW5j
KGNocik7Ci0gICAgfSBlbHNlIHsKKyAgICB9IGVsc2UgaWYgKGRvX2xpc3RlbikgewogICAgICAg
ICBxaW9fbmV0X2xpc3RlbmVyX3NldF9jbGllbnRfZnVuY19mdWxsKHMtPmxpc3RlbmVyLAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRjcF9jaHJfYWNjZXB0
LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNociwgTlVM
TCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjaHItPmdj
b250ZXh0KTsKKyAgICB9IGVsc2UgeworICAgICAgICBxaW9fbmV0X2xpc3RlbmVyX3NldF9jbGll
bnRfZnVuY19mdWxsKHMtPmxpc3RlbmVyLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIE5VTEwsIE5VTEwsIE5VTEwsCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgY2hyLT5nY29udGV4dCk7CiAgICAgfQogCiAgICAgcmV0
dXJuIDA7CkBAIC0xMjcxLDEzICsxMzIwLDExIEBAIHNraXBfbGlzdGVuOgogCiAKIHN0YXRpYyBp
bnQgcW1wX2NoYXJkZXZfb3Blbl9zb2NrZXRfY2xpZW50KENoYXJkZXYgKmNociwKLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludDY0X3QgcmVjb25uZWN0X21zLAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQog
ewogICAgIFNvY2tldENoYXJkZXYgKnMgPSBTT0NLRVRfQ0hBUkRFVihjaHIpOwogCi0gICAgaWYg
KHJlY29ubmVjdF9tcyA+IDApIHsKLSAgICAgICAgcy0+cmVjb25uZWN0X3RpbWVfbXMgPSByZWNv
bm5lY3RfbXM7CisgICAgaWYgKHMtPnJlY29ubmVjdF90aW1lX21zID4gMCkgewogICAgICAgICB0
Y3BfY2hyX2Nvbm5lY3RfY2xpZW50X2FzeW5jKGNocik7CiAgICAgICAgIHJldHVybiAwOwogICAg
IH0gZWxzZSB7CkBAIC0xMzgxLDggKzE0MjgsMTAgQEAgc3RhdGljIHZvaWQgcW1wX2NoYXJkZXZf
b3Blbl9zb2NrZXQoQ2hhcmRldiAqY2hyLAogICAgIGJvb2wgaXNfdG4zMjcwICAgICAgPSBzb2Nr
LT5oYXNfdG4zMjcwICA/IHNvY2stPnRuMzI3MCAgOiBmYWxzZTsKICAgICBib29sIGlzX3dhaXRj
b25uZWN0ID0gc29jay0+aGFzX3dhaXQgICAgPyBzb2NrLT53YWl0ICAgIDogZmFsc2U7CiAgICAg
Ym9vbCBpc193ZWJzb2NrICAgICA9IHNvY2stPmhhc193ZWJzb2NrZXQgPyBzb2NrLT53ZWJzb2Nr
ZXQgOiBmYWxzZTsKKyAgICBib29sIGRvX2xpc3RlbiAgICAgID0gaXNfbGlzdGVuOwogICAgIGlu
dDY0X3QgcmVjb25uZWN0X21zID0gMDsKICAgICBTb2NrZXRBZGRyZXNzICphZGRyOworICAgIGlu
dCByZXQ7CiAKICAgICBzLT5pc19saXN0ZW4gPSBpc19saXN0ZW47CiAgICAgcy0+aXNfdGVsbmV0
ID0gaXNfdGVsbmV0OwpAQCAtMTQ0MiwxNCArMTQ5MSwzMSBAQCBzdGF0aWMgdm9pZCBxbXBfY2hh
cmRldl9vcGVuX3NvY2tldChDaGFyZGV2ICpjaHIsCiAgICAgfQogICAgIHMtPnJlZ2lzdGVyZWRf
eWFuayA9IHRydWU7CiAKKyAgICBxZW11X2Nocl9zZXRfZmVhdHVyZShjaHIsIFFFTVVfQ0hBUl9G
RUFUVVJFX0NQUik7CisKICAgICAvKiBiZSBpc24ndCBvcGVuZWQgdW50aWwgd2UgZ2V0IGEgY29u
bmVjdGlvbiAqLwogICAgICpiZV9vcGVuZWQgPSBmYWxzZTsKIAogICAgIHVwZGF0ZV9kaXNjb25u
ZWN0ZWRfZmlsZW5hbWUocyk7CiAKICAgICBpZiAocy0+aXNfbGlzdGVuKSB7CisgICAgICAgIC8q
CisgICAgICAgICAqIElmIGFuIGFjY2VwdGVkIHNvY2tldCBoYXMgYmVlbiBwcmVzZXJ2ZWQsIHVz
ZSBpdC4gIEl0IG1heSBiZSBjbG9zZWQKKyAgICAgICAgICogbGF0ZXIsIHNvIHN0aWxsIHNldCB1
cCB0aGUgbGlzdGVuIHNvY2tldCBzbyBpdCBjYW4gYWNjZXB0IGFnYWluLAorICAgICAgICAgKiBi
dXQgZG8gbm90IHdhaXQsIGFuZCBkbyBub3QgbGlzdGVuIHlldC4KKyAgICAgICAgICovCisKKyAg
ICAgICAgcmV0ID0gY3ByX2xvYWRfc29ja2V0KGNociwgZXJycCk7CisgICAgICAgIGlmIChyZXQg
PCAwKSB7CisgICAgICAgICAgICByZXR1cm47CisgICAgICAgIH0gZWxzZSBpZiAocmV0ID09IDAp
IHsKKyAgICAgICAgICAgIGlzX3dhaXRjb25uZWN0ID0gZmFsc2U7CisgICAgICAgICAgICBkb19s
aXN0ZW4gPSBmYWxzZTsKKyAgICAgICAgfQorCiAgICAgICAgIGlmIChxbXBfY2hhcmRldl9vcGVu
X3NvY2tldF9zZXJ2ZXIoY2hyLCBpc190ZWxuZXQgfHwgaXNfdG4zMjcwLAotICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlzX3dhaXRjb25uZWN0LCBlcnJwKSA8IDAp
IHsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpc193YWl0Y29u
bmVjdCwgZG9fbGlzdGVuLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGVycnApIDwgMCkgewogICAgICAgICAgICAgcmV0dXJuOwogICAgICAgICB9CiAgICAgfSBl
bHNlIHsKQEAgLTE0NTgsOCArMTUyNCwxMyBAQCBzdGF0aWMgdm9pZCBxbXBfY2hhcmRldl9vcGVu
X3NvY2tldChDaGFyZGV2ICpjaHIsCiAgICAgICAgIH0gZWxzZSBpZiAoc29jay0+aGFzX3JlY29u
bmVjdF9tcykgewogICAgICAgICAgICAgcmVjb25uZWN0X21zID0gc29jay0+cmVjb25uZWN0X21z
OwogICAgICAgICB9CisgICAgICAgIHMtPnJlY29ubmVjdF90aW1lX21zID0gcmVjb25uZWN0X21z
OwogCi0gICAgICAgIGlmIChxbXBfY2hhcmRldl9vcGVuX3NvY2tldF9jbGllbnQoY2hyLCByZWNv
bm5lY3RfbXMsIGVycnApIDwgMCkgeworICAgICAgICAvKiBJZiBhIGNvbm5lY3RlZCBzb2NrZXQg
aGFzIGJlZW4gcHJlc2VydmVkLCB1c2UgaXQsIGVsc2UgY29ubmVjdC4gKi8KKyAgICAgICAgaWYg
KGNwcl9sb2FkX3NvY2tldChjaHIsIGVycnApIDw9IDApIHsKKyAgICAgICAgICAgIHJldHVybjsK
KyAgICAgICAgfQorICAgICAgICBpZiAocW1wX2NoYXJkZXZfb3Blbl9zb2NrZXRfY2xpZW50KGNo
ciwgZXJycCkgPCAwKSB7CiAgICAgICAgICAgICByZXR1cm47CiAgICAgICAgIH0KICAgICB9CmRp
ZmYgLS1naXQgYS9pbmNsdWRlL2NoYXJkZXYvY2hhci1zb2NrZXQuaCBiL2luY2x1ZGUvY2hhcmRl
di9jaGFyLXNvY2tldC5oCmluZGV4IGQ2ZDEzYWQuLjY0MGQwMzMgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUvY2hhcmRldi9jaGFyLXNvY2tldC5oCisrKyBiL2luY2x1ZGUvY2hhcmRldi9jaGFyLXNvY2tl
dC5oCkBAIC02Myw2ICs2Myw3IEBAIHN0cnVjdCBTb2NrZXRDaGFyZGV2IHsKICAgICBpbnQgKndy
aXRlX21zZ2ZkczsKICAgICBzaXplX3Qgd3JpdGVfbXNnZmRzX251bTsKICAgICBib29sIHJlZ2lz
dGVyZWRfeWFuazsKKyAgICBib29sIGNwcl9yZXVzZWQ7CiAKICAgICBTb2NrZXRBZGRyZXNzICph
ZGRyOwogICAgIGJvb2wgaXNfbGlzdGVuOwotLSAKMS44LjMuMQoK

--------------EYRkVIiTMXkIkus5Dn450Y3A--

