Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB1DD6EBE2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 07:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGvfk-000827-0K; Fri, 29 Nov 2024 02:44:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfb-0007z9-FS
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:44:09 -0500
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfT-0002iu-JD
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1732866239; x=1764402239;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=dSbec9u073dxNs0vgQ5NpjaCt5YwLh5q+Zos3VDB6P0=;
 b=MqBf2sbe5a50fkmMwswahGEaO8nGKhYqnuEwGnESK2b9e008b8mLCXos
 PSuuPTlJ3hkJf4kOuR/+PVi+2OPhbOcRnBdjcW14fc9+a2D1RSXuG04Uv
 vSPThX2Til5Ppf3KzMJIRABkXP3vFc4FOuIVBNCSLKDVDSWPvUI7IXlpV
 k+BwXDqC4KG3F3scLMfnN/WnZiY94bAykXpHo23BgHWO70REKcTewVXCa
 NgvQGax7XfdfPUTLhRsqcasS5Wk+EkPCsYD5GVegsnyJhWBX5qxrcenRC
 nMNGKJrgZ/wuh1Vckv53HVcqad3fmN7P2oZocHJC2UTljSavQrBsiZVHG g==;
X-IronPort-AV: E=Sophos;i="6.12,194,1728943200"; d="scan'208";a="25663422"
X-MGA-submission: =?us-ascii?q?MDHdK7Kwv4sPI/A4mSEm5AOL3xkbWZby6lGG21?=
 =?us-ascii?q?BA0zYRys2IS5w7jmaFe1UP8LzbhDdTHPTaBr/Jh4ErKOnnczdO3B0tnB?=
 =?us-ascii?q?nYbZJ0mAH8/91067LeCsLr+FnABOVzCqEoN4EvYnpo6ckp9wU18z4UyN?=
 =?us-ascii?q?uk5WskkHlfx7nYhqCDFlH8Xg=3D=3D?=
Received: from mail-am6eur05lp2107.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.107])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2024 08:43:54 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wi/K6EKjfOPp+1LZwpKzLbo23IS74cb1Q3QYpjNsmrPMlJQU7HYp72TIMMYG87TmpKvOU16+sqEOUj5VnVe8DOyzoXLoPsCzmFGGwvAlc+nYtdflE/PpJAxj3OoQqwn+e1nPOXRgkHwcM0s4hXmfmk06VU1OheJmCW2gJeJBlWYJ30oSO4a03wXM4nbCgO6IezXzNvNeQQSLmG5Nwb2W3pFpOamtcfRKHXE82ZG+C6uKnnF3k9EmpAX7cJD+WU3NMhdiy0xcSrEXfgC3X5w+83VeWq7stn1bsNZ4YXRtcknecd/dmBWTUbXVpK+yMkR1XXJZUwyx7PAYtqCHCRqzCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSbec9u073dxNs0vgQ5NpjaCt5YwLh5q+Zos3VDB6P0=;
 b=y1o5PlrvByXi9PxtMGVGF9xfXkzIz7kzo1xmIl5cLbP1qo0yV9B1zw7KAxMGqGnpB0qc7A80zpghMcNSdXtar2Z3B4qzN2aeVyrrkMeBnlRns+mYkk6rj9rsN9LmF9tPC6j4ZPGK69IAtSSa9nt8dApjH5WuJiev6VaAHPbcFgasYv1B9YeWpHb1qvto2LD1JLBjmfyJAMpHEM6futpA0eaee6doyAwhWCStFApsAkCsuUXkbVgZf0vc+PBy58zPCH63GzQPcaelo6QlKXJVisd38wcaz5VNPRYr8qzfmGsC7sWQYLB+8+xnI8spGKkgdgfGvVQx/QAkoLxnl54kVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSbec9u073dxNs0vgQ5NpjaCt5YwLh5q+Zos3VDB6P0=;
 b=PDagTgmSS7us4b1h1/PBZ55h4i9/O+xNyCOs/Dk7fNSMaXRveXXdcmwsCiX+poE9uge+SHAVqdfPOSZxsk+GD9BOCjOg1SxWipiNnfVGQmlCrQ0z4jnCK5lGFU7q93C4Qtv2Bg1Z43mmTUZPuhQgVtWj3cbi52E5XR0UtZ/OWm/Ji7XHjZi8wVF7RpHVqKboz/V94YkSobchttpSPQGWHcEZ5349bdAeiEGosnQB+ow5Uu2PjvxVj8yR01PIIODkMHq23vVDLoW4LGBBgU4mW6jZbHRi6RL/yBSB7bcncWmmz09PadN4t9EEh0Fx9Vg15jDf1Wk4G6B88I5BUeUAUQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7847.eurprd07.prod.outlook.com (2603:10a6:20b:39e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 07:43:53 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 07:43:53 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v1 06/19] pcie: Helper functions to check if PASID is enabled
Thread-Topic: [PATCH v1 06/19] pcie: Helper functions to check if PASID is
 enabled
Thread-Index: AQHbQjJwXoyduQYO3UOuG9p1h7xK9g==
Date: Fri, 29 Nov 2024 07:43:53 +0000
Message-ID: <20241129074332.87535-7-clement.mathieu--drif@eviden.com>
References: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7847:EE_
x-ms-office365-filtering-correlation-id: 34b96ed7-9690-4bfc-84aa-08dd10499293
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?S3Q2TUkxQ292TUxVLy9GTzA3aHBSR3FKeXlZRFpxa0tjb3ErTldQYlJGKytR?=
 =?utf-8?B?OVk3TEtQdi9IS1ZDckhBYWx5VEdicnE3b1F2aXJkb0RxbTJTYU8zNkp5RW1R?=
 =?utf-8?B?RU5Sb2R4WjdKYyswc0hXNFluRVJiUEZUdTBUSlRUOU9zMlNqSDJZMHpmMTNQ?=
 =?utf-8?B?dmNkQTJkaGg5aTVjMFVmVXE1TDZmdFl3dnlPdnNNQ1o2VjNnaTVhYndsWEha?=
 =?utf-8?B?d1UzV1BKV3FSSDM0SHFSaTQyZXlWR1UxWVNuVVRNNDhpdzBwSDJsdE1oRU9O?=
 =?utf-8?B?K0ErbVQzUVVqaG9OL2dKYU1PNUMzR1c0cENHQThxbjNrYUhtbzdlS3N4aWRC?=
 =?utf-8?B?VllDblBiQjg2K2ZVeXllN2NoWmVlTkpFU3ltbUtvUkxFMmJucHVmUjBXa2h4?=
 =?utf-8?B?RDJ1YnBpanVJQmVxUVRJRHlxUnFqTWZSS05LSFdlT2Vud21qbnFNbHYvbzJY?=
 =?utf-8?B?ZWo5NGVYZVZGd2xjVDBuVWZZcytWbTdEMTV5WnM2QkhIQk1MYXdRalA4MjZz?=
 =?utf-8?B?WkswMVpQMmVQdjBSUkFoS3M3Mmx5VXgvRjFuQUpaUWdSZVZVVFdEZE1teVdZ?=
 =?utf-8?B?ZDJNZSsvUjFQUnFZL213dFdSYVVBTnQxVkl6QWFxYWR3SW9NZjNvdzRMOUFJ?=
 =?utf-8?B?cExHU21BSk9mejd2WGRkcmdhbG9WQitHK1hkVDNyZ214K2wvc2k4UXBKTDRn?=
 =?utf-8?B?QkJvSHgvS0ZGaGxadEFOQ0ZEbjJXcFZhYTIxN2RtRmlvbk1oN0xuQUx4cUNt?=
 =?utf-8?B?b3RmUjF2QjhaZENGQk9aT3dPVVdTcEhWWnA2NkhhWnQrZm1walJaRmppVnds?=
 =?utf-8?B?aHB3bS9sakkvaHlZNXU3Zlhtdzg4OFNPTWdSSWNnT25UeS9qOWJIYjFVKzhm?=
 =?utf-8?B?VktEemFnNDZZZGZzSEh3VjZEeUZDaHQ5NU42VEZNeVhjTm85bVNXUm1uNWY3?=
 =?utf-8?B?ZTFGTVVXUjRVeVJBQ0d3S3ViNDJ6L1I3YXBsYzFVRG1rWjZVTmdtRXVETDJp?=
 =?utf-8?B?VGlSejZzczBGV1RpYjNDWmFzS0xEbktLRkhzbUU5YndqMFFOY2ZKRXRBNEp6?=
 =?utf-8?B?MWovMVhhZjd6cVJwaXpOZVZLc2Y5eExkVC9jQkJxeGVmMmJEd1UrNkhSZGpr?=
 =?utf-8?B?NW9TM3phTjRMWWE1cWJoV09kSEl5dmFRWjNJakhqcTRncnFXMEZEUlZvWmdU?=
 =?utf-8?B?NkJ3eENnVCtFajJ2SzdwOWNZODFmb1BwSzVSM1ovcGJlNER1eHNYRnJ3eTNv?=
 =?utf-8?B?cCtJbDVONmJuUkloRHYySGNrZ3NWV3NlN2ZpbFQxY0FIblZZZEZEYTUyc0VB?=
 =?utf-8?B?RlNNbmRCUElYbkE4WFFlc015WlV3UDVyR2o2T3NmVXUyaTRUTjl5UkhQVzFv?=
 =?utf-8?B?ZnRmTkYzRXJGdXN2QWt6c1pXVU84R05PanQ3R3R4R3pKQjhjdFFjelR4U3FV?=
 =?utf-8?B?T3ZYU2pVMHlscWZKaDZ2V0pBTmJyYzJ5MllsWFZjVSt3UjdVVEtqTzVmVHVV?=
 =?utf-8?B?TXhrbTkyalNUU0ZCRDF4ZVR6ZzhkVEE3cGppZFZHTWxLUk81TXZ0Z0NFZHVo?=
 =?utf-8?B?ZFNtSTAyMXhsaXZpWHFvWlB5MjFyVGlKc29xRzFTNVZGWW5CWEQ2Q244UWJU?=
 =?utf-8?B?OVFUT1hpRHgvTkZsNlZNaUxjaEpZZm5GNXkyaEZCZzV1dlU1M3REVnBZNVRR?=
 =?utf-8?B?MGY2dFVhR3dXcEF4Z05NT2c3cFVldFZMcGJ4bG5lRjJqZVBWVVhoTVRKNktD?=
 =?utf-8?B?TVJvbTNDNU16eDUwQ2RzMEFQRlJWSHpkWVBHajk4YzErMVh1STYxVzNmMmVY?=
 =?utf-8?B?emJobEJhT0I1MmtnWXZrQ0RSQ2JVeWx2ckpiR3FGTzFDdkJUWmhML0xBZWg4?=
 =?utf-8?B?bFdxK1ZTb2RNdU0vM01STGw4bEs4dVFuL09kS3dqVHNOd1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlVRemQ2cWJSU3c1bCtxRGlRSDdKbnNsTmZ0WlFYZ29oNG9xTWRpSGZRN3oz?=
 =?utf-8?B?Nkh6WkFLUS9MVmZFSG42bG1mSDR2bWphY3JPUVFWK1BhQWtOL0RGckRCd0ND?=
 =?utf-8?B?SCtPNVlqV3JlbmFRMWFlVW4yTE54dHowdnBScWtTZUNHQ21EMzh5ZkZxTllT?=
 =?utf-8?B?L3N2K2txZEJpbTNHbUR6OHBIbTBuKzFGUSs1MUd4aURkREo0U21XaXpVMXdM?=
 =?utf-8?B?NU5tdGNyMXc2bFdnczhOQ2VlVGo3VGM1QmNWYmhVQkJlU3NHSDlWRzJ3Qko1?=
 =?utf-8?B?N2lRQTNFdGRXY3V1cldiSjRYeHdlSTg3dHFxSHNrVnZOQVJvWTZvL01zbDBR?=
 =?utf-8?B?Q1BwbjlTS0J1bHBHNll2RjVmZG9zWU1QemF1dkMrY3pndXpMNkpqVjFLV1Bu?=
 =?utf-8?B?OGNwUEdmd3NnWnBUK2w1UGI5VXBVcTNLakU3MUEvVnRPRDNaS01RNWZ1N1hX?=
 =?utf-8?B?OVlVSjZTc0xPSU1RWTdoeGtackozcEU4S0t5N0tjd1p6UlR3cnV4bGxrZkEr?=
 =?utf-8?B?cnhOWjUzQlVaZHYvT2RCQUkwVStDZHUyaXZYN3p3N3pJSDJVOXEzM01qNW1i?=
 =?utf-8?B?NjJlY0YwbXk0OXAzMy82M1ZyQjVmQXdJVHd1eVpYbStjTmJQVndKUE9HTmph?=
 =?utf-8?B?MUdzRXNaaEU2QjhNUzQ4YUFwTWJPRzBNTnB3c2k3Z3I4UGdCellOcUJuSzZQ?=
 =?utf-8?B?dGJ0ZGpuajliZzIvVFlLeUVicmN5V2dDK3R5OFZnUDYzaW1QcWJxUStycmMy?=
 =?utf-8?B?ZUZJNWt2cENpQ1dsa3lheGlGekh6R0JyUStsOFBZdVEzY1VlYTZwa0hZSTA1?=
 =?utf-8?B?U0lhdVpPT05iZE9NUmJkVkVpWGVmcmZmeVNTMjgzZXdLcGFGUjFuM1NQd09Z?=
 =?utf-8?B?ODhDTjVnZjZmNTROT0xpTFMxUFRiSnFxV1pyRFQ4cE5vdVc1OFJGVXlJbEcz?=
 =?utf-8?B?NmZ1VVNkMC83QkpNQmtLYlpFb0RvbkNTWFpNRGtXbHo2Qnh3dGZpMDk5SWhh?=
 =?utf-8?B?eEpVOFJzNm5XQ3hFT0UvWUhRK3dNd3JGT1JyNG0yKzN2SlVDMzFuQVVLNzhW?=
 =?utf-8?B?aTRNREhnQXV0ZnkrSStXb1BjRnlralU1dFROcXlzVTJxdXFtTUUrNkZZemVn?=
 =?utf-8?B?QUxFQ3JMRytDWHdOcUx1L3p0S0dDaTBEcDBkRXBWVGkvZWh5UDNRcjRuMGp4?=
 =?utf-8?B?UmdydmVkdXpRdE02MXFTZHI5MzNWTCtZM3lTMHgwWlphd1ZZMDBRV0FsWjZx?=
 =?utf-8?B?dVp0bE9PbkVhTm1oeWRETll1OXFERjdabTVFaFc1aW5DNmdVVlV5dHJxMjUv?=
 =?utf-8?B?WkZEZm9LVzZEOHFrU3QveE80cjhhVmRna1FvUTl5NFd0SUFpM2N4VExaRXdW?=
 =?utf-8?B?RUUzczJOeFJUTU1YbUJWOE11eTRSRXhmNlZPY01ZNSsxOGgvSThJNXR1RXdV?=
 =?utf-8?B?c1hqRnBweG9tMFVLa3J2SEhDdVhkRFF6ZlJDSTFheDZIeVMzeU1xQjF2bWJI?=
 =?utf-8?B?Ny9wMHh2ZDJXZlZrazU3VkZrNGh6RkNLK0VjcWNianl3YTdpZFpqUzR6Wk82?=
 =?utf-8?B?cHFoTjN5cEZWT04xQ1QwRktuSnJkbGc3aUNsNzhqSjF2QVhqMm93eWU3Q0NI?=
 =?utf-8?B?Ry94UGFzdWIxS3pKTVVhVU9LMWNoUVB6YXJyUVlHbjFucTZyT2JLYUROV3FN?=
 =?utf-8?B?OXRsZUk3ZlF6T2trbEVERVVQdHJZL1E0OFRXN25JK0s0N0poY1RNd1R0Z3Jt?=
 =?utf-8?B?THFzT05vdTd2bks1SHlpblNISXgrY2xxTnVOWTN1RFRVeFI1SFpiNzhtOVY1?=
 =?utf-8?B?Q0lzV0FrMllodmdraElaajg4dlB4Zk9RN3RoMElNTXVnWlp5RmNjN3pZaTZ6?=
 =?utf-8?B?Y0JCcmVqQjIrU1NITHkxWVU0SGhaQXBMN2xVUE51SVhpRUpCTjNJcnEyaTJl?=
 =?utf-8?B?RlJNVUs1K1NkcGNVRzNqbU13T2EwNk9mQWJKSmU2eC9BWjdVd1JyWXdCaWNJ?=
 =?utf-8?B?ZEhqMlRsZC90dm1HSGpIRTNNQ2FTNmRPSnZLZmMrU0FjMjF0UHpiV1A4WW5v?=
 =?utf-8?B?cDd3aUJNTzJBcGNZRlRJTXZYZkxvcS9KRE5kazF0MXNFdXpCWWhWRnpiWkJk?=
 =?utf-8?B?Ykh1QzNPaUVWRnRmNndOeVBQR2F2bUhHcGk1dHBtQnk4TkgrYWtJTmJwSVFC?=
 =?utf-8?Q?8JQ8vit89tE9ZXG05i+ArAc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC9D357E79CFBD419D843D5D4F1DF293@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b96ed7-9690-4bfc-84aa-08dd10499293
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 07:43:53.3763 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 821KS86VsF6wrb+D+z6VIN79YkA33cBwZ9aDZnkD3ytqjiOq/G0sl4KQcJXMyV5h531n8JaodAxWqwsQUI6Pe6NeJtIAA6ZIgx8tMBPG3RBL9UEqV+1saYg2PeW5NWQ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7847
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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
bi5jb20+DQoNCnBhc2lkX2VuYWJsZWQgY2hlY2tzIHdoZXRoZXIgdGhlIGNhcGFiaWxpdHkgaXMN
CnByZXNlbnQgb3Igbm90LiBJZiBzbywgd2UgcmVhZCB0aGUgY29uZmlndXJhdGlvbiBzcGFjZSB0
byBnZXQNCnRoZSBzdGF0dXMgb2YgdGhlIGZlYXR1cmUgKGVuYWJsZWQgb3Igbm90KS4NCg0KU2ln
bmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQotLS0NCiBody9wY2kvcGNpZS5jICAgICAgICAgfCA5ICsrKysrKysrKw0K
IGluY2x1ZGUvaHcvcGNpL3BjaWUuaCB8IDIgKysNCiAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2Vy
dGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2h3L3BjaS9wY2llLmMgYi9ody9wY2kvcGNpZS5jDQpp
bmRleCA1Yjg5NjQ5NmFlLi5iNmU4NGFjYzkzIDEwMDY0NA0KLS0tIGEvaHcvcGNpL3BjaWUuYw0K
KysrIGIvaHcvcGNpL3BjaWUuYw0KQEAgLTEyMzQsMyArMTIzNCwxMiBAQCB2b2lkIHBjaWVfcGFz
aWRfaW5pdChQQ0lEZXZpY2UgKmRldiwgdWludDE2X3Qgb2Zmc2V0LCB1aW50OF90IHBhc2lkX3dp
ZHRoLA0KIA0KICAgICBkZXYtPmV4cC5wYXNpZF9jYXAgPSBvZmZzZXQ7DQogfQ0KKw0KK2Jvb2wg
cGNpZV9wYXNpZF9lbmFibGVkKGNvbnN0IFBDSURldmljZSAqZGV2KQ0KK3sNCisgICAgaWYgKCFw
Y2lfaXNfZXhwcmVzcyhkZXYpIHx8ICFkZXYtPmV4cC5wYXNpZF9jYXApIHsNCisgICAgICAgIHJl
dHVybiBmYWxzZTsNCisgICAgfQ0KKyAgICByZXR1cm4gKHBjaV9nZXRfd29yZChkZXYtPmNvbmZp
ZyArIGRldi0+ZXhwLnBhc2lkX2NhcCArIFBDSV9QQVNJRF9DVFJMKSAmDQorICAgICAgICAgICAg
ICAgIFBDSV9QQVNJRF9DVFJMX0VOQUJMRSkgIT0gMDsNCit9DQpkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9ody9wY2kvcGNpZS5oIGIvaW5jbHVkZS9ody9wY2kvcGNpZS5oDQppbmRleCBhYTA0MGMzZTk3
Li42MzYwNGNjYzZlIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9ody9wY2kvcGNpZS5oDQorKysgYi9p
bmNsdWRlL2h3L3BjaS9wY2llLmgNCkBAIC0xNTYsNCArMTU2LDYgQEAgdm9pZCBwY2llX2NhcF9z
bG90X3VucGx1Z19yZXF1ZXN0X2NiKEhvdHBsdWdIYW5kbGVyICpob3RwbHVnX2RldiwNCiANCiB2
b2lkIHBjaWVfcGFzaWRfaW5pdChQQ0lEZXZpY2UgKmRldiwgdWludDE2X3Qgb2Zmc2V0LCB1aW50
OF90IHBhc2lkX3dpZHRoLA0KICAgICAgICAgICAgICAgICAgICAgIGJvb2wgZXhlY19wZXJtLCBi
b29sIHByaXZfbW9kKTsNCisNCitib29sIHBjaWVfcGFzaWRfZW5hYmxlZChjb25zdCBQQ0lEZXZp
Y2UgKmRldik7DQogI2VuZGlmIC8qIFFFTVVfUENJRV9IICovDQotLSANCjIuNDcuMA0K

