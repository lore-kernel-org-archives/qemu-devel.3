Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BE0C04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YNY-0003oF-Ar; Thu, 02 May 2024 11:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNW-0003n1-PW
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:46 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNU-0005ys-UQ
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1714663785; x=1746199785;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=9FxV2pX7chRK0bdJDSW+G+9YHH7CXug/vkDSNtE3+PE=;
 b=b16vJBOm5WRvRuG3FoKkAQBiRcdoQIORmpPJ4VkxQLSOlyJW0e9i1zLD
 Qap56Z7FwEaSJZJmVPcywKmOk2Lx9wuJJVSFLQ97wTXv949gFeJTl6hsu
 RU5iR4b35dCMHBRsZhYE7LsbK+WlK3OCl+4FHum18w95FGYgqEnUZZmVI
 UByBbv+Uk6FhmOU0RhscJvOkWq4WzFTR1iH/XLH/R71e48Jvl8JYVvovV
 TfYM/gp/ii5LGrz4daDxUyPnN+8OVbi+NSIsPbdOUNRtnpY80JIOtUx5M
 UnvIgyc9h5EVv7nbhJ/edwhqVuDBhEQGZfs9/V9cvmWp1KC5+cPDF+u1P w==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; d="scan'208";a="11785881"
X-MGA-submission: =?us-ascii?q?MDE4PCaUBIkpJLsr4UMsDamwzf9UlnKxuQ/fll?=
 =?us-ascii?q?2Wy2JUwWj2Vqroy4SHbVKDn3bqwBJWs9vQ1v1moN59drvqAQtyIkoi/P?=
 =?us-ascii?q?OQhLHJjWFlO1/hcne83scLVjihzayxK8EJTs1ZAHXLzH/ZnRC05NeeDw?=
 =?us-ascii?q?JrDUDq04nx0vMD+9Gd/X/oAw=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 17:29:21 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bn5vAuldfbP+LAIst3Z8c6bfATUo2NTQoVAjVWPItnfZMazQA+IWdQuBlV9I6bGSL1u4jh2z2HTszVmsajjy9hw3Kq4alHQ63WWzYnzhcBhTVn3IiDaCXNX/RWQE2RAu1rGi2F5fOmhbisKaVu619F1WCYszGtTzGk1h/Xi9mADXXnpjeoz3iSzdNllVnukg/+0sEfliD1lGIoTJMzLBveBN7dibRoNRYYkfOIoG6CUXB4bFFMZqYL/AeAk7U6HkB35rNCO6pFjq0GnJD42byXSx3w59MtrXRUCE8syGrTe3GMEhDInCKEj/SZuET1Bbk+qcE4X4dicQI6svkFgM1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FxV2pX7chRK0bdJDSW+G+9YHH7CXug/vkDSNtE3+PE=;
 b=ZbFmmZObTOlj69jZKyw0hPOzL568tBVOk23+vsKZsDHBKxO4/SRdN38fQZLXOX7ZKwnhNd1yoauPSTX1Xt8pRSIGhQlGEiRSGrC4LqNLUZdi9xATo9h4xdrClkxiCkQzLGasSPGPXtLlRTEZyQBLrw3Dwsu6lwNr4jFqQj0LBIX3Jlup7G3+aLUHgXeIcz2DgFoq/Xa1vBYUTQpzIaTCjbIwwRW2qD/t+7dxGtgi0bjHNB5mA5WKVLjU0WMWVZ82/WWPPp2y63ouFmSJwty6PPigtDq+QJqmhJRp+c8Ahd2eiIaQSxKfXQECkM8u1TD5xp5A1z0qT2be6pEcQUQSCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAWPR07MB9661.eurprd07.prod.outlook.com (2603:10a6:102:389::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 15:29:18 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 15:29:18 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v1 08/24] pcie: add helper to declare PASID capability
 for a pcie device
Thread-Topic: [PATCH ats_vtd v1 08/24] pcie: add helper to declare PASID
 capability for a pcie device
Thread-Index: AQHanKV/ZpfW7p59SkGnAmV2rL6amQ==
Date: Thu, 2 May 2024 15:29:18 +0000
Message-ID: <20240502152810.187492-9-clement.mathieu--drif@eviden.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAWPR07MB9661:EE_
x-ms-office365-filtering-correlation-id: 7a3182d0-e6d5-48e2-f6c8-08dc6abca218
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZnlKVExLME9yNDJCSUpvTVJLK1VodnpRQkxldFJIcE96Z29WRXZFYTVzSERz?=
 =?utf-8?B?UlFvY3QvbnptVVFBWGo2bmM2bWV6bElhSkJBb1BOdmcxSFZuaFBCcEhRcFBO?=
 =?utf-8?B?TFVmeldCd2RNUkpKY1pPS1BFcWppYVRvTlNYb0FMb0Q3a3BOdEQ2YlpFOTV2?=
 =?utf-8?B?VFdvNlFscWloeFNpekY0bDI1M2toZTVQcW5qNzlmVTVjbXZ4UWZCZWhWdFpS?=
 =?utf-8?B?UTdPUzUrRTh4WUhkai9maDEvTFNZelZ4TTFITUVza2dIaGlTam56OEFvN2Vo?=
 =?utf-8?B?Q21DelVtS3hPWTlDZDVUMCtydFYwSUtlTzA5eVo0WU1DMWdOMHhrMk9WYnlQ?=
 =?utf-8?B?RFhzNEkrV2E0OHUydjJ6dGpjdHBRcnc4ak5lSlh5K3JqSzlxRmJSVHBQK2F3?=
 =?utf-8?B?VCtCNjM5LzlLSUJicFFRY0VHV0R2aTJybndnTllCMzJtamVzb3FtYTI0d1VU?=
 =?utf-8?B?VXFvTit4Ri9BbStVNnRTdzVzU0FaYnNiK1JkazN4SGF3bEc5cmI0dFE2dWRB?=
 =?utf-8?B?NHFFSW9wZHZSVUZPcUtsbC81M1ZGTmNnWmdackszdUtSc3NLcFJvZTAzOW42?=
 =?utf-8?B?TFRJcHBWOVpHTHI1ZjFoWXhkcmllU0k3aGVrQ29BemRUb24wV2dicy84TFdp?=
 =?utf-8?B?QXk3SlJMTHBaeCtSc2EzejgwaHhmL29kaXBLQ25NUGtBOWFXR1h0VkdhOHlR?=
 =?utf-8?B?MFhmSW9mdTQyWjMrN3lVeDRoUjFGdGRzNzB3aFJBN0NGdTMrLzlWbFBpbVJL?=
 =?utf-8?B?VjV6eEovZkxQS092c210ZmZwdFQ1RDltTVBoT1RKamh0SnB1Z2FzV1BVZllL?=
 =?utf-8?B?Z3RXN2VXYTY5ZG1mWlEwRFk3NHVkSURibnhZTndLaEdTbnBjSldzWkQ4aFMz?=
 =?utf-8?B?RWdEVzhJanNIZWcxWWc0b2V1YmUwUUNnQWNRZjI1Yy8rSWtoRnRmaEREYm1u?=
 =?utf-8?B?ZmgwMUh4cGM4eXNTNURQZUcycnVJWmdPa3JVOTZGKzVETy96YVA4UFQyTTlE?=
 =?utf-8?B?UHB2Yk41Y0FuTTFqejN1YnhKckk0dWU2VnorTlJQVlFNWm1XYjVJZHVyZ2Fm?=
 =?utf-8?B?RUJxZmFTeUpZVDdDNGlaaytFS1Uzc0VOZHVVSXEzN1NOY01wUzVEMlY3c1Mv?=
 =?utf-8?B?YXlCTitCZDBCd05wcENYVlNzR0hWZVJhTURldDhOcHY1czdmMS92QXEzWGQv?=
 =?utf-8?B?YkY1VEJ0ZmVlMW5GYThUb1c5VVhVZ1FKc29nVXY1RElLSUNoL3J0Z1NoZzBR?=
 =?utf-8?B?RVRRdGhxS0NTVWpLU1hjd0lnZnl5MmEwbFkrbDVEV25hZXdPWGNxVUV2OXFz?=
 =?utf-8?B?UWRveEEzN3k0Z0t2Myt4UHIyNzFkTzk2WmtCTmpubXlyU3J6RWQzVEFVcGsr?=
 =?utf-8?B?MkFmSjFwdTNTQTY3aWFGZXBPV3pibG5BZ3hKWDJ1UWVFd0VDMTUrZGFlNDRs?=
 =?utf-8?B?Z1h5Tk00M0J5T2RiQ1UzTjhSdHZQTzdRRmxkek1VUWxrREVJNUtPNGYzTGxR?=
 =?utf-8?B?d2lndkZTNGxremYxUzJHMTd0ZlNsSkw2aU5TUVZtMERhZWhlbHFiRWlVNXda?=
 =?utf-8?B?dzZSTU5IalNNNEFmSHNuVkFObG4xWjhTd1pLWlZSZ2hsQTJ6U3RscWRxTlAv?=
 =?utf-8?B?MmRVTm92bXN4VHl6d0xtSmFxbWlwRUFMbHBtUHZmRk5zV2haUUlITUF1TlpD?=
 =?utf-8?B?MTY3bXN1TGQvZEZhWmtCa2tReGFYZmRxbGI0dTBGejNZQVF2YUkzWE1JbVph?=
 =?utf-8?B?LzFFa3ZtK0NIRFhyWmxhZ01MQzllL2dSZnN3bmNDM3o4alBjSUYzekJTSS9R?=
 =?utf-8?B?cWovbFRPUGEweEVKbGtWZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uk5GUVpzRk95MUdWRW5MVW9MYzI0UEs3RVNPZ0dsMkMvNjduTmV6SHY3TFhi?=
 =?utf-8?B?b1pRUHppVS9RbEl4dnNjSnlSOUNmdmRvT2dIZFl3QkQ1dVRwUndWTWdaVlA0?=
 =?utf-8?B?Z0tidGlwdDlvN3Bsdk9NeTU0Mm9EU0NUemdaK2hqdk8zdFJ3QndtVDcyeVRF?=
 =?utf-8?B?S1JOT1JyaVNVL0hGM1hxVWtEYVgzWTN1RkFVUk1CdjBZMW44K1pGak94N0pP?=
 =?utf-8?B?L2VkOWFHd0xBNTNXSmIxakpqTmpkRUJZRE9SMkw5MUJFalVPZytZRjloMzFl?=
 =?utf-8?B?V28xbmhJZUZhZjVRUHJnMDdrYXVMU3lwU2lDTDluVTl6bWVvMDFvNXFUL3kv?=
 =?utf-8?B?ZjVNL2VUc2JHZ0lhSGY0RW1PQXl1bUtaVXM3WG4zTXFoaDV2cjZuTUZkQ3FP?=
 =?utf-8?B?OWxqU2E2WWxYbEZzSVk1c1FBY0tpajBIQzk1aDEwYnhhaU81dERqVU80ODJ0?=
 =?utf-8?B?dXFEOEdoeVRHMnB6OVZKdFdpcjlFOElKVUU0QU5ISm9LY2QvRzZQMnNCbE5P?=
 =?utf-8?B?eXVQVndCZkg0SFYrUVhxajdyNU5nVFNpT1VGQml5a1NhOUFRbHY0NWpRUEtX?=
 =?utf-8?B?Yml0L1ZrUnhETnc4cXNJTTVBeDdWTHpCQlNBdFpMR3I5NnVkcHdoaEVMZEVV?=
 =?utf-8?B?WThTS3NuMEs4aDFFRmdYakk5QURmN3Z2dFRyRm5zWFBiSFRYNjhJaWVsejVz?=
 =?utf-8?B?TUI2NHJsSEZjbEhIR2lCWnJNTVpacEFJZjJUdEpkRmZYa2Jwbi9aRGl0dVNM?=
 =?utf-8?B?YXBtSHErVWxqMDgvbXBUSVBYc2ZKL0tsYkoza0N5K3czTGVpMWxWM0xNOGNx?=
 =?utf-8?B?SlM5ZTh4T2l0YmJuNXBPdkMyaUdsTjlkMXAzUXJ2ZUgyZjRlTnlvblpheUxP?=
 =?utf-8?B?aTkwOTgzRStIMHNQYit4WCtiWXlLSjBmR1FOOWlYSUhrclBNYzRxUmhhVWVo?=
 =?utf-8?B?WTk5c1Z0eWVBYlJKNkhmaDBpWTBsMytBYlY2WkxGMnBsWnY4YVhwYUZTRnRK?=
 =?utf-8?B?SnlsU1ZsdW1pT0R3MXFOSTN1MDF0d0F6UmZvS1FISmZxQ0laUmxKbGpPclN2?=
 =?utf-8?B?K3JkTFY3WUZmWHZlNWxPQkxYeDEzQ3JZZU5JOUQ3Q3hGb1BiNFprN3EwV0xG?=
 =?utf-8?B?WEpmKzN0amp3SE55aGlYMW9iSjJYUkRGUDNrVTlqRXJVUE9XZmxLa3BvVG9s?=
 =?utf-8?B?dC9na1BYQmtmKytNdFd2OGIvVDZ0SjhUOXFVTXV1cjdYeSt1QWxzSlFYMGIy?=
 =?utf-8?B?UGVERWo2clU3Ti82MXc4MnQydy9sUHVGUFpoSFF0Zk1OS0F0UmhoVnBQcFM4?=
 =?utf-8?B?YWVlbGhYV1JIc3JVTkc0WXlyWm1pYlBXaGtURCswWGpuQ3k4cFovcmExY04w?=
 =?utf-8?B?dlJxRktkZ1Q2bnY2WUt4QUxSZkFoaExQbnJWdytYU2JMc0RLbW15VjdkV2o2?=
 =?utf-8?B?dnpkUXVvK1E2Z3NEZElPUHFHd2lqeTlUVENxUlBDRmgxVFNnUmQwTTFKY3hI?=
 =?utf-8?B?VE1EVXh1NUxXcE1vSENTdi83dDFVZEd0YW0vdHFvOGFVVGNiOGtlamNkZ2s2?=
 =?utf-8?B?a2xCQWdBKzZXOGtnM1VYYTNwTGZOYVEvNk1zbzJHb05JK2EzZTZlNzhQT2d6?=
 =?utf-8?B?RnUra2drZ2FQQ0dpT1V2VVhBOGZHbmp1NWt2Vmk5S21hWEdhMElzUERaZDF5?=
 =?utf-8?B?cUh0NmNKTm5Wd0JZTlhYbnNVNTI5UXpHendZMU1LOXBVeVhTbEt2THZtQ2kx?=
 =?utf-8?B?K0VOTG90L04xdHc4amlhYndkSVlCQ1N3S1JZT21tanBxaWt2ZFA3NytxSE03?=
 =?utf-8?B?RXNrN1NtWUN3d3dsdE5LLzZ6L2NqaG5PNmoxdUZhV1J2Zk1tN0hKM0VDR0xH?=
 =?utf-8?B?c2FKTDhaaHVBSlAweHdic0ZRV0RzcC9nVnNtQm4ydlgzbjFON240ZStzMXN6?=
 =?utf-8?B?VG1YaDhSb0JGazY5SE5Xc3p2SDZqU1prbUpWcHU1Y3pTUmEwT1JkN3Z5b1FB?=
 =?utf-8?B?MnZ0V3AxRFJaM3kxWVV4cVZuNzJtNWZaQWVjS2hpSUMrQk16Z2hoemdRdHFZ?=
 =?utf-8?B?OHQwNzFGUUtvSmJkRjh4UkxLQnNkNytoOVB1ejdJam94blRUQm44eXNQUWFI?=
 =?utf-8?B?ZGtHa2V4Z0duV1FrZy9qbXVPWHQyc091WTArUnQ0c0VZMzBqTWxNOEo2WHVX?=
 =?utf-8?Q?ZCiuqS/9QBLXMn31j6I3qfw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <750248B27314B54590BA69815BB74B75@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3182d0-e6d5-48e2-f6c8-08dc6abca218
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 15:29:18.5251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l2xVAx4F+S9BZz+OtF2ybYERV0A6uReOqjyYMkvf0jr2BMQKAQCkgbiq5MJ6ooEZBwHR5DUBppuWTfGvFok6XuSY6GiFIcYUFLIVfJHTOHiKq++fixVsiv/OYISc9p5M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9661
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9wY2kvcGNpZS5jICAgICAgICAgICAgICB8IDI0ICsr
KysrKysrKysrKysrKysrKysrKysrKw0KIGluY2x1ZGUvaHcvcGNpL3BjaWUuaCAgICAgIHwgIDYg
KysrKystDQogaW5jbHVkZS9ody9wY2kvcGNpZV9yZWdzLmggfCAgMyArKysNCiAzIGZpbGVzIGNo
YW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2h3
L3BjaS9wY2llLmMgYi9ody9wY2kvcGNpZS5jDQppbmRleCA0YjJmMDgwNWM2Li5jOGU5ZDRjMGY3
IDEwMDY0NA0KLS0tIGEvaHcvcGNpL3BjaWUuYw0KKysrIGIvaHcvcGNpL3BjaWUuYw0KQEAgLTEx
NzcsMyArMTE3NywyNyBAQCB2b2lkIHBjaWVfYWNzX3Jlc2V0KFBDSURldmljZSAqZGV2KQ0KICAg
ICAgICAgcGNpX3NldF93b3JkKGRldi0+Y29uZmlnICsgZGV2LT5leHAuYWNzX2NhcCArIFBDSV9B
Q1NfQ1RSTCwgMCk7DQogICAgIH0NCiB9DQorDQorLyogUEFTSUQgKi8NCit2b2lkIHBjaWVfcGFz
aWRfaW5pdChQQ0lEZXZpY2UgKmRldiwgdWludDE2X3Qgb2Zmc2V0LCB1aW50OF90IHBhc2lkX3dp
ZHRoLA0KKyAgICAgICAgICAgICAgICAgICAgIGJvb2wgZXhlY19wZXJtLCBib29sIHByaXZfbW9k
KQ0KK3sNCisgICAgYXNzZXJ0KHBhc2lkX3dpZHRoIDw9IFBDSV9FWFRfQ0FQX1BBU0lEX01BWF9X
SURUSCk7DQorICAgIHN0YXRpYyBjb25zdCB1aW50MTZfdCBjb250cm9sX3JlZ19yd19tYXNrID0g
MHgwNzsNCisgICAgdWludDE2X3QgY2FwYWJpbGl0eV9yZWcgPSBwYXNpZF93aWR0aDsNCisNCisg
ICAgcGNpZV9hZGRfY2FwYWJpbGl0eShkZXYsIFBDSV9FWFRfQ0FQX0lEX1BBU0lELCBQQ0lfUEFT
SURfVkVSLCBvZmZzZXQsDQorICAgICAgICAgICAgICAgICAgICAgICAgUENJX0VYVF9DQVBfUEFT
SURfU0laRU9GKTsNCisNCisgICAgY2FwYWJpbGl0eV9yZWcgPDw9IFBDSV9FWFRfQ0FQX1BBU0lE
X1NJWkVPRjsNCisgICAgY2FwYWJpbGl0eV9yZWcgfD0gZXhlY19wZXJtID8gUENJX1BBU0lEX0NB
UF9FWEVDIDogMDsNCisgICAgY2FwYWJpbGl0eV9yZWcgfD0gcHJpdl9tb2QgID8gUENJX1BBU0lE
X0NBUF9QUklWIDogMDsNCisgICAgcGNpX3NldF93b3JkKGRldi0+Y29uZmlnICsgb2Zmc2V0ICsg
UENJX1BBU0lEX0NBUCwgY2FwYWJpbGl0eV9yZWcpOw0KKw0KKyAgICAvKiBFdmVyeXRoaW5nIGlz
IGRpc2FibGVkIGJ5IGRlZmF1bHQgKi8NCisgICAgcGNpX3NldF93b3JkKGRldi0+Y29uZmlnICsg
b2Zmc2V0ICsgUENJX1BBU0lEX0NUUkwsIDApOw0KKw0KKyAgICBwY2lfc2V0X3dvcmQoZGV2LT53
bWFzayArIG9mZnNldCArIFBDSV9QQVNJRF9DVFJMLCBjb250cm9sX3JlZ19yd19tYXNrKTsNCisN
CisgICAgZGV2LT5leHAucGFzaWRfY2FwID0gb2Zmc2V0Ow0KK30NCmRpZmYgLS1naXQgYS9pbmNs
dWRlL2h3L3BjaS9wY2llLmggYi9pbmNsdWRlL2h3L3BjaS9wY2llLmgNCmluZGV4IDExZjVhOTFi
YmIuLmM1OTYyN2Q1NTYgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2h3L3BjaS9wY2llLmgNCisrKyBi
L2luY2x1ZGUvaHcvcGNpL3BjaWUuaA0KQEAgLTY5LDggKzY5LDkgQEAgc3RydWN0IFBDSUV4cHJl
c3NEZXZpY2Ugew0KICAgICB1aW50MTZfdCBhZXJfY2FwOw0KICAgICBQQ0lFQUVSTG9nIGFlcl9s
b2c7DQogDQotICAgIC8qIE9mZnNldCBvZiBBVFMgY2FwYWJpbGl0eSBpbiBjb25maWcgc3BhY2Ug
Ki8NCisgICAgLyogT2Zmc2V0IG9mIEFUUyBhbmQgUEFTSUQgY2FwYWJpbGl0aWVzIGluIGNvbmZp
ZyBzcGFjZSAqLw0KICAgICB1aW50MTZfdCBhdHNfY2FwOw0KKyAgICB1aW50MTZfdCBwYXNpZF9j
YXA7DQogDQogICAgIC8qIEFDUyAqLw0KICAgICB1aW50MTZfdCBhY3NfY2FwOw0KQEAgLTE0Nyw0
ICsxNDgsNyBAQCB2b2lkIHBjaWVfY2FwX3Nsb3RfdW5wbHVnX2NiKEhvdHBsdWdIYW5kbGVyICpo
b3RwbHVnX2RldiwgRGV2aWNlU3RhdGUgKmRldiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIEVycm9yICoqZXJycCk7DQogdm9pZCBwY2llX2NhcF9zbG90X3VucGx1Z19yZXF1ZXN0X2Ni
KEhvdHBsdWdIYW5kbGVyICpob3RwbHVnX2RldiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKTsNCisNCit2b2lkIHBj
aWVfcGFzaWRfaW5pdChQQ0lEZXZpY2UgKmRldiwgdWludDE2X3Qgb2Zmc2V0LCB1aW50OF90IHBh
c2lkX3dpZHRoLA0KKyAgICAgICAgICAgICAgICAgICAgIGJvb2wgZXhlY19wZXJtLCBib29sIHBy
aXZfbW9kKTsNCiAjZW5kaWYgLyogUUVNVV9QQ0lFX0ggKi8NCmRpZmYgLS1naXQgYS9pbmNsdWRl
L2h3L3BjaS9wY2llX3JlZ3MuaCBiL2luY2x1ZGUvaHcvcGNpL3BjaWVfcmVncy5oDQppbmRleCA5
ZDNiNjg2OGRjLi4wYTg2NTk4ZjgwIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9ody9wY2kvcGNpZV9y
ZWdzLmgNCisrKyBiL2luY2x1ZGUvaHcvcGNpL3BjaWVfcmVncy5oDQpAQCAtODYsNiArODYsOSBA
QCB0eXBlZGVmIGVudW0gUENJRXhwTGlua1dpZHRoIHsNCiAjZGVmaW5lIFBDSV9BUklfVkVSICAg
ICAgICAgICAgICAgICAgICAgMQ0KICNkZWZpbmUgUENJX0FSSV9TSVpFT0YgICAgICAgICAgICAg
ICAgICA4DQogDQorLyogUEFTSUQgKi8NCisjZGVmaW5lIFBDSV9QQVNJRF9WRVIgICAgICAgICAg
ICAgICAgICAgMQ0KKyNkZWZpbmUgUENJX0VYVF9DQVBfUEFTSURfTUFYX1dJRFRIICAgICAyMA0K
IC8qIEFFUiAqLw0KICNkZWZpbmUgUENJX0VSUl9WRVIgICAgICAgICAgICAgICAgICAgICAyDQog
I2RlZmluZSBQQ0lfRVJSX1NJWkVPRiAgICAgICAgICAgICAgICAgIDB4NDgNCi0tIA0KMi40NC4w
DQo=

