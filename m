Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D503C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YNO-0003iY-9r; Thu, 02 May 2024 11:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNL-0003h0-Gi
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:35 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNH-0005yz-KA
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1714663772; x=1746199772;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=GhKk+A6NwQ+38r5/YF5BJggGjMk6pSdKGBywgZ7mQgs=;
 b=F6y7/u3Cl8SJvN10qOl/SLgIxU/MTnQad9gtttIRhAG18rrkkKsb9ST/
 quCt+UJGt8OUkJ0cUuMokBCk+4TSyXw+fv9hG4MAH4/Eesfwbpvfpx3bX
 eHpiWoyTcygswEQLCvy03jQFsC1aOKVCdo/zcSbX7W5vFW+bz0lPIQ12t
 qo7iXupcgBk3WZX+EapMrE2fMLMu5yDI24t6MLLoyGnok682HN9OvnV+x
 P7Qsyzj0h1qnbbXBTYbV9KKDHqtyn3L9oVA4KsP2vRjwjN//7tyMZ/J62
 4dlZHNzDGKkpQkxSZSAUsojbtVHQRvz/pzTCqz+P61dJy6ugWi8fIIZzT A==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; d="scan'208";a="11730669"
X-MGA-submission: =?us-ascii?q?MDFhSrC/IQCPdwO2SHbYWZIfcT5m7kD/g96Qnj?=
 =?us-ascii?q?cSF2hSa+XS89Y9GUx22a47+pGwJHxnzFWyf+dDx9ZBUPalD65FPUNBs5?=
 =?us-ascii?q?Bci7aCt8COs7xUR87mLVa+PZ6Fb4zLSf8pa+Q8QEY7uYyW5i8WX8CgPG?=
 =?us-ascii?q?fH/yA0lRB8V+hyXBR6gAPZ8A=3D=3D?=
Received: from mail-am6eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.104])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 17:29:22 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQcIdsJs3+ka+N9LHFiKevuuuhfPudlRP4SkwqZOkHvQMq6XWCpq+otF9fvMFRUWCCA08gCNuOTpHcg3FjskOQZAvO5AGhl1BHojwkaZU3lbbPgkT/rkNbMovrQS0Ph8lFL6FyIHpUMMBhErJKEfHmdZoecNRNy9Gx5WJRmI1n8cfrGh6zpAr9FMLdU81qXFcW63+ASNTCKhl/0slEUl8qKP7mnjF7vhTvC9ynAUbOBVBLVJ53CB5vX2tEfWA2cfE+IPz7knERaVGiz8dEu+77Rivfew0LFPsNfk/uWhuL7BvfvnMamHf1+yZRskZlx+XkIr5MoDs5kUtKxLmp00Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhKk+A6NwQ+38r5/YF5BJggGjMk6pSdKGBywgZ7mQgs=;
 b=iqALBWJ1R6KCU5ijyJBReE2zJusHfb6ufSGK+inEj881BS7GOqXzLR68dF1cbBsrkyLoJsoZs7suAZ/qONoJllx4x7kt9dH4nTEz+lGtCwseXqOyt67kJRiRJbKA3E1l1vzFa8vKGCRumfEvbtRLaE+juc4tC+4knG1VhPYt6ax+lRMWgkB+kWzFpvM7ABsg5AemLvPJqjSI1ZDeerPlXuiSvMgCfDwtf4DH8kk2j1uW9r08erppVQ4zM5Ly8HOXyLxoxmWnr8a4KWjTU8I3iWx+njW5UG82Zg84xQZDTTe8P2/RMWGgUbwMPxJ9VskdiNVdyIhws79WyrIJ2E//1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7768.eurprd07.prod.outlook.com (2603:10a6:20b:351::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 15:29:20 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 15:29:20 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v1 18/24] memory: Allow to store the PASID in
 IOMMUTLBEntry
Thread-Topic: [PATCH ats_vtd v1 18/24] memory: Allow to store the PASID in
 IOMMUTLBEntry
Thread-Index: AQHanKWAt2VhTY/OvE2prqz0y3GhlA==
Date: Thu, 2 May 2024 15:29:20 +0000
Message-ID: <20240502152810.187492-19-clement.mathieu--drif@eviden.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7768:EE_
x-ms-office365-filtering-correlation-id: b6b52596-5daa-48f3-80a3-08dc6abca37b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?TGt1alhpZ2x2RnJuNXNBR1RVaGFEVCtKL3EyT1EyS1BVbmQyY1pJcDIwbjFJ?=
 =?utf-8?B?cmlwU0pzRjVaN0EzWFRoSUF6YzR4Z1JlbnFOZ3Y1Nkp0bXEzbDQ2eEZlaWRB?=
 =?utf-8?B?bFlONnZNc3QwUEx3azhYZC90SHVJUU1VS3JkaHJpTTVEOWlDSXYreko5eGZG?=
 =?utf-8?B?SklOby9DeDNzYndrMDVYU3Y4VHRXaWZyZ20zejYzV2RUNmNGcm13WC9IZnpv?=
 =?utf-8?B?ck1BWVY1d05hWVU1bEIrU1MzRnN5YS9wYjk0Q00rcUg3ZkJieVc2UnRiamZ1?=
 =?utf-8?B?WXE0UStmUEk3NGcyck9RV3VMMmgxMDF2MHRLa3FaRGNKSmovL3NCVGJJRitk?=
 =?utf-8?B?WktnazRNNlJxL0FTRmdnMFlST2FlZ25pMlY4ZHpTY3lxcGZyVTcrU1pvb04y?=
 =?utf-8?B?U1F0b3Y2TzBhRXdvK29QeXdzWFFFeHB1R1pYbHRNL3BiSVVmZFg3bHVBajYz?=
 =?utf-8?B?dmx0eFN0M280UTM4L0dMbyt4NFZDMjh0Q1UwMWVtVEVINVlPUFVqY2VKRDRP?=
 =?utf-8?B?dW9qcG42bC9Zc256clR1RVJ4MnFjK3dJVnl4NEZmdDZpOVFSQ2dJM09HRC9W?=
 =?utf-8?B?TkdTT3B0cStseWVHaWJPcEx5SW1FVW11ZEJLRWlIdGwwVTNRWlR6YW1UR2RH?=
 =?utf-8?B?U2FmN1I4aGZiSm1UWENjV2VJb0Mrb01EYVFKSmxJQ21yQ0V0Mk5KYUJpbTRH?=
 =?utf-8?B?N0JGMFRqV2czWVRIay9HZ1d0TG41bGRmVjVsVjc2dUVDUjgxbEVsRWxEMHlO?=
 =?utf-8?B?NDlNZkhxVVR0ckJWYTBSaUI5Q3Zhb0I2MmI3UlV0eTMvb1BCNkJIVGpXZU44?=
 =?utf-8?B?R09xT1BJaUlSU2ljamF0Yk1VbjVwYi9iM1JWZ2M1R3N0cnhKemFhbnVpK0Yy?=
 =?utf-8?B?amtyc1dITEhueDE4ejhETWlvaVFJMEo3MnV2Y1hUWUl1eHd6cjViQ3kvMDBI?=
 =?utf-8?B?cEJjM01Xa2YzbmI1SGt1eU5WdTRTc0xuZDhieGV4S3NNWW9UL1ZkYjdnTWJi?=
 =?utf-8?B?VmlJd01RZUNDNHlHdFE0Y2ovWGFLTmI2QzhLU0JBYThTZktOMEtZV1A3cTE4?=
 =?utf-8?B?YytWbjVXM0hlcUFHb1UrZ1JsUVpyMC9rOU5mS1d3Wncxam0vczQ0UDArRWZ4?=
 =?utf-8?B?QTBGOTI1TjFUYllIcloyZGhqZjQxbGZJeTBlb2MzaUl3ZFRSdVVRbnlBWStL?=
 =?utf-8?B?WGVYaGdUZ2FMYWFaeHVCdDdMWGw3OUxMVmRuVW9lRmZDR3ltNytxVGUvSDNL?=
 =?utf-8?B?ZG1XMDlsR1lvZHUxd3pVSkJhbGh4dDU1T05CeTVoL25NTWoxamd4cFV0Vk9W?=
 =?utf-8?B?OFhEMHUzL21SUnlGVWRxZWlPcndYQjZheHNMOEVZL3pibk9OMU45b01KVGZU?=
 =?utf-8?B?aUVHYzVHSWJic3Q3aTREMTA1amhhWnovZUVoV3dYNDU2UEc3SG9UVzdZUThI?=
 =?utf-8?B?SUYrLzVKMXR3cEhkZkk3VFh4emZTSEVWN0NjOElQQXhBbUdRVXJBOUhNL011?=
 =?utf-8?B?cDdock1tcFRKb3hsOE0zZWF0ZDdUbGVvVlJVeThEcWJIQjlHaFdldmhVdzVx?=
 =?utf-8?B?cGZ4R1lQUmJKK2xVeUkreTlPK0grTkVlZ3VEQStqcFhpZlhMekwvZW1hMFMv?=
 =?utf-8?B?SytCUnpvNndxTTY3WlZZZE1GQnNMVy9uZDJKVTArZzdNNjJDNDI0T2x1cWxY?=
 =?utf-8?B?VHdSM2Z2c0VTblhLVjNsT0xaNVhQZVpSVjRTbTY5T0l5aEkxWjhOVDRJUjZG?=
 =?utf-8?B?aEc1YytYS1dXbjJnVDRrRitSQU1JNTlycDRaVmE5WkZBUDBEK3MzWWptaVB4?=
 =?utf-8?B?dXNmaEZWRTZwbHNQY2dvdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WCtXVFVMalRCZWV3T3FLTTVyY3lZZjd6eFdEdHlvc0pLTjh5U1pwaG9xd29G?=
 =?utf-8?B?eXVnMUNIQmtIbWtna3ZWWGtSSVNnbFY4NFVzcVJ3RXl1ZVB3R1lZSUdQVlJa?=
 =?utf-8?B?NitwNG14SFNwZGhCdnJrSzR0VUpIZEdveFNxS2NxQWkxYXdHRzZTb0R6OEhs?=
 =?utf-8?B?ZThqbVhjcGFQdnBUZDJzVFJFTlY4NEthcWZxN0RaV2JlWmtwNnJSWEpITW1i?=
 =?utf-8?B?SXVuMFcwOU13cTlpbUZvQ0tuYVkxekoxT0tqeTVjWTZESXJ4R3NZcTBocjJQ?=
 =?utf-8?B?bExDUmh3cmNUZCtGdzB3Z0pONElCL2dFaFdNTzVFWkEweXI5SGZUWldIZmdC?=
 =?utf-8?B?d0ZGbGNqdGs5SXczTjFCMVl4ZEJHMldxRGg2dFhLZHNrYTYrVEZMRXdNUkNz?=
 =?utf-8?B?L1dhYU1kV2RXTzNEblVKV3NuYTI1OFVTcW1sbU5zQm1RdXhjN3UraWw1OENS?=
 =?utf-8?B?Vmx5U2h5MjlHMzhPUEsrRUFkUWZPM3FoR0ZWV3JnN0xheFgxdnhldXljcWxj?=
 =?utf-8?B?ekRMT0dNRHBrdVkxRHE1TitVNHVZbStCTUxQY2h0YlJ6L3l3MUh4Z3ljL0xY?=
 =?utf-8?B?Z0pSMUV3QzlQYkUrWTQzeFRxLzFGM1g5TFZ6WU1kSGwrTXBqQ2RlTWJhcWdO?=
 =?utf-8?B?L0FnRGZoc2lFRmpmUC90ckRCR3BnaExJaXlmLzJFMldpcFZHZ3I4Zmc5NTNT?=
 =?utf-8?B?SW1XN1VYS2FYU1E0Rk1jeWYxcGtCYXVTRFNCcGhmWmtEWi9PWDhVNDVJWW5B?=
 =?utf-8?B?emJJeklWd3lhcE1SdW1oUkFreXozdU14MmZHS3JaTGM2Z1g4dm0rRnl0eWxl?=
 =?utf-8?B?Zk5ESHBJMkZadnB2OGZvZDk0UGFJbTZ0L3JnZkJSRmtoTGJvR1JRc2JMU1dz?=
 =?utf-8?B?bDdiTmxOaFVwWGl5RVo5UmgzSlRtZFJDWFIzaEF6RGlGbmVJaG14ZCt1Uzhu?=
 =?utf-8?B?ZkladzJ4cnNiSkE1NTBzNHozV2F6NGFUbHYzeVM3QjBGUlIycXhhdkx6KzBv?=
 =?utf-8?B?dWFtYkF6dDJ1Njh1ZHlnd2dSUzVBTkdXUXJ2SGM3OFFxdXN1MEd3TWhTZG91?=
 =?utf-8?B?WjVhRFdsNHc4VXY3eGtWRElZdXFZL3FpV3ZXdk5vY0VyMk05UldsZHdtZUQ4?=
 =?utf-8?B?aWRodHIwTjNKeWNsTzM3dnUrcHArc2tGQkVOR1dGZ1Q2RzBqR0ZrcUgxQ0V5?=
 =?utf-8?B?d2pOWFRyS0RWOGVOMVNyNUV1eXcrRmR5U0h4RlBodFY3eURKbVpDSng4a2Rs?=
 =?utf-8?B?cXVvY09SWERnK2lDcnJDRTEyOTRDTUtkWU5SdkEzL3ZIcU9JNW0wVVJWSWdu?=
 =?utf-8?B?S2RrT0o3TzludmFTZ1IrTkliUlVMZEpuYVc0dTEvVFBmcjVBTFhHUkFGZjVM?=
 =?utf-8?B?emtsNnZkZGhJYzk2cml3SmZiKy9RWU00RDdYemNRYWw5QjFCWmRqbnJsK3hI?=
 =?utf-8?B?K2V2ZkRhelBUbTFSeFh5SkFPTy9wS2dmc1Qrekx3OVQxSmJYYytlcHBlZS8x?=
 =?utf-8?B?UlIydzVaZnpIb1pRL0s3NjF0MG1Pa1FEMUpQVHBITnhOK2VQN2JHRFk3YzJy?=
 =?utf-8?B?aUxvSEVQQmw5REtkYjc3QUd4WWhrTHZESXVHSzdEWEJwcEppaTJVL1hLVzk3?=
 =?utf-8?B?VGsyTHdwaWE2blBneHJzRlBCbkZEL0JwbVFxN3YxY2tPb2NHTWhGR2prdWlo?=
 =?utf-8?B?blAwejRvRGs5WStWbVNYUzVsa1c2YkpkdHJFTllzYlAvQ3Q4KzI5ZEVKVXFr?=
 =?utf-8?B?YWhVbG4rQ3FBdmhaMEVEOFc5eGoycEE5VHJFYWZUVWlvUWRxckRuc2FhYmRG?=
 =?utf-8?B?clA0NHR0K3BvU3o2RDdVWG9hWm1LeDNKb1BLdkx4WDJGemtybWkxS2ppRzQ0?=
 =?utf-8?B?UnREaWxqRG1HQ28yaUVpWHgvbE5MdThCS3UzVCtTckZLaXJrMDJhVUFsYStt?=
 =?utf-8?B?Ym9mTGhybnBjTEp2QWsvcmlRTXNHWjQ3aHEwTnhaeXN2M2VVY1ErNVF3a0ZT?=
 =?utf-8?B?Yzl0RGlBMVdOeStYWjdiOVpZWWVXdFdLeHhEUFJTK0h2WFF1NlVZQnVvNUcv?=
 =?utf-8?B?dTZzaTFqUUt4dUEyaXJwZk1idVZUNDFHQ1AwVVhUeGFjOEJWdnJ2cUR0SGhZ?=
 =?utf-8?B?eEl5VFlSRVNFbys5aVg4RkZBaHlkNXczSFQ0WURIcWdTMW9Hek9oRWNmNXlB?=
 =?utf-8?Q?CUf+DAKnup8CeZH+CYfGXNs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA0CB16EE3824A4280FB86DAEA4C11BC@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b52596-5daa-48f3-80a3-08dc6abca37b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 15:29:20.8572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ooHJ2pYVP/m+F3Tv4SXrwO1PmMSCOu4aExpmSezWRQ987tf5RhWDXnMZvTZPlpJFyENf0uaHQArIusO0L6G/4VvWujrBAjO60NDxFxH4DlLiHaRO8PFhvGrVY67KytpH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7768
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

VGhpcyB3aWxsIGJlIHVzZWZ1bCBmb3IgZGV2aWNlcyB0aGF0IHN1cHBvcnQgQVRTDQoNClNpZ25l
ZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBl
dmlkZW4uY29tPg0KLS0tDQogaW5jbHVkZS9leGVjL21lbW9yeS5oIHwgMSArDQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2V4ZWMvbWVtb3J5
LmggYi9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgNCmluZGV4IDMwNDUwNGRlMDIuLmY0YjMzNDE1ZDcg
MTAwNjQ0DQotLS0gYS9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgNCisrKyBiL2luY2x1ZGUvZXhlYy9t
ZW1vcnkuaA0KQEAgLTE0NSw2ICsxNDUsNyBAQCBzdHJ1Y3QgSU9NTVVUTEJFbnRyeSB7DQogICAg
IGh3YWRkciAgICAgICAgICAgICAgICAgIHRyYW5zbGF0ZWRfYWRkcjsNCiAgICAgaHdhZGRyICAg
ICAgICAgICAgICAgICAgYWRkcl9tYXNrOyAgLyogMHhmZmYgPSA0ayB0cmFuc2xhdGlvbiAqLw0K
ICAgICBJT01NVUFjY2Vzc0ZsYWdzICAgICAgICBwZXJtOw0KKyAgICB1aW50MzJfdCAgICAgICAg
ICAgICAgICBwYXNpZDsNCiB9Ow0KIA0KIC8qDQotLSANCjIuNDQuMA0K

