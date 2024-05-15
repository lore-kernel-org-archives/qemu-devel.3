Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238D5C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78rQ-0005FV-1t; Wed, 15 May 2024 03:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qs-0004no-RD
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:15:03 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qo-0000oW-JK
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715757298; x=1747293298;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=QViL57WcqcSq2IAMyDPaufeO5kwcbqR2b6u/ZIg+Ojg=;
 b=mY+FZGiaq4dAPaewGmSfzSqzNcrrq3xtd/Ty10wTfqYMAlP+ORTAZ+xx
 gsymXyWmX+MpZKmpyDWonPoRC9ELvfwvoSCsY29fHSwcu7kZe46prlAw3
 fPb1pAnfuMeqHKBvL47HGUTvLPCVJeyZy/jt+hY4z/zHKvDeeWnwHs2jT
 NMyNFd1i5qgSfeuyVizyy28Jsuyjp103aw5t2nMAfQCpSQi5hvh1bDqNt
 Rns7iZqbW/Bi689J2bktJsA8giyl4s4ycS08LewFaaN2Geb9lM05VT8gz
 iQ43FasUBwknsGbrylwKQgJAJq+/RMz+Kni16xpc4UYZq33cbE0n2qhUa A==;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; d="scan'208";a="12581809"
X-MGA-submission: =?us-ascii?q?MDEIjOj9D+TJEPC2Z9nPKwpjWohIQg+KbHBuXQ?=
 =?us-ascii?q?pqOaU+Y9iqVNVh95XxX+fHsknkNp0AQgUVKZ329q6sMv93wyUUGYGH2Z?=
 =?us-ascii?q?914zBq5IrPCD1rgCa+kYicJT9hQbYuK5njjO5ygnPiBEBNfxwiURhCRk?=
 =?us-ascii?q?meNGYHUhOFZUnXmurTsBcdZQ=3D=3D?=
Received: from mail-vi1eur04lp2050.outbound.protection.outlook.com (HELO
 EUR04-VI1-obe.outbound.protection.outlook.com) ([104.47.14.50])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 09:14:22 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3oMg3fyu+NO9FJuWLwt82Q29aOKRcpjC/sSkJK0gaI68ZfC1prsGPMTd9fjluN+YfjSILi4fCqRC3Rbf8HQQ1QF511nL0LdSPv8GBc2zk/BXcFNi05TpF9BPMGLrIh3F7p0aPt+euy8FTPleg4FXQWpoWhUk3oGYmtrL4qlgQyo+SlrZG7Q0MZfVSnEyTdo85IOMT76naVVcWYjLbMn1QeX1h9w+vHm5XQpwH/ww/AZBvYojFTdYNT0QWgNrXIuZnrUxj7F5a66/EUen94nc6OJNCBJWwFp6zsxXStE8gOzm9OeOkNG75rq4M7CWpCgNQ+d6By33cObbJ48rBcbXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QViL57WcqcSq2IAMyDPaufeO5kwcbqR2b6u/ZIg+Ojg=;
 b=aV7EJiQmQ97Ij8pvQ4YLRUEUkINsyjyUZhWiKKzzWYyY2LckMXpGEXK2FCVn/eMNrrm1QC8uxgiOqBoBW38I09duRNXlsKrymU3veqYiFVXIiVW3bRn4+wOigJMXObXMuHZc3u032afDPA9GPcj2om5hlEleEuQE5Lk/TyUZblhZPlLsG3oqHvxSAP8xLOUoNRxkwWF2uZBNkocttB4CADcwoa3745vTcrj//8lL9m02WrTVDnIfNCCC/aVD/dfBHHeElnkgEeBQNr92UV6TF01Ebf40EDmebFIBYwIouA9jimjqaW2m7MUxv69HIWKbuabOQO0YndDLDUEhKv79uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6718.eurprd07.prod.outlook.com (2603:10a6:800:18f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 07:14:21 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.056; Wed, 15 May 2024
 07:14:21 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v2 22/25] memory: add an API for ATS support
Thread-Topic: [PATCH ats_vtd v2 22/25] memory: add an API for ATS support
Thread-Index: AQHappeBZRL0InTYXUqH9Y6yKo3H3w==
Date: Wed, 15 May 2024 07:14:21 +0000
Message-ID: <20240515071057.33990-23-clement.mathieu--drif@eviden.com>
References: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6718:EE_
x-ms-office365-filtering-correlation-id: c74efd5a-7d38-4920-2efb-08dc74aea46a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?UUFYMWRJOWpUOXlSTVRlYnRRdk9DU0hsUzNWbTZqeU9qQ0ZNaGRsUnR6QzRP?=
 =?utf-8?B?MXpjVDUreG1HeEdvQjlxNUZVa1E0dW9EV0lyempCZ3JUMUo1VFRwQWxVNTc1?=
 =?utf-8?B?WU55NEw0UEY0ejBTK0lMOUhGQll1djRjTEpaV0FUdnplOVpEQUM4VkZMNy8x?=
 =?utf-8?B?ZU51TXlUWHI2dWVFMjRMc0Z3a2lPL1BKTWVDOHJHNlZDQjdRanplMDUzQ2xK?=
 =?utf-8?B?STFWQUZKRG52T20rWWtna2Q3RGRNekRjQ3VibmtVRVJ6anhBM2xFOVk1OURZ?=
 =?utf-8?B?NnBPSUFOQXl0UWVBbVBXSFd4VXRKdDRTU1dKaGpKUGJ1V3Y5UTYxaS91WmJE?=
 =?utf-8?B?VUFkRys0MTA1cnRkaUpieE1hQnJVaUpOcjhQeE9Zd1lnUGpjaWYwcWpUVmlG?=
 =?utf-8?B?M0d5a3NTcnorbitqS0Iwb0FvY2grdnVMWGRTd0FvYmRyaFI5RHZ5SmkzT09i?=
 =?utf-8?B?SzRkT3JHdkozZ0lxdzBkQWVJWXFoR2pEM3lsdmVuWmRvYmUxOEpZRGlqYTk1?=
 =?utf-8?B?Q1B5cVdCMTcrTzIxR1RlSnBTNG9Zc0svVGp6OVFLekJxQVJGeUNqeXhqaUtk?=
 =?utf-8?B?WE5jRmRwc1R6dUZUWHJjNHgxeGY5TmtaNHpETmdNdHFBZFJkOE9WR0ZxVHVt?=
 =?utf-8?B?djBPbEJ6RTNKRWRJQ1Y4VTdXOVNUQUhFd201NFE0MHlzck5hdWQwZ20rRksr?=
 =?utf-8?B?c1RiRWtSNm9vSHp2a1lNVnRDME85ZkorWjVKWTFtdnA1L1J2cFovTU9TWjIz?=
 =?utf-8?B?UCsrM3pxRm1seWptdWNaYVF4ZmR0MGZGUWh4bWZZREJWME1URTBHOE1VWHdO?=
 =?utf-8?B?WWw2akhOK1I2SHZqYmlYdnlwMTg4N2Z4WjVCQTNyNHo0USt0OGpHKzJ2czIy?=
 =?utf-8?B?RDV4ZVJXZzYzSVo4cmdsaC9na01OeE5UQzZUSW9oWVRDZmpGSGVlbmZzUnhP?=
 =?utf-8?B?cUplemFFZXBXVTJlay9JNUdBTm14cktVb2FOQVd1V3lnKzRFNDJyRWJId2pl?=
 =?utf-8?B?eEV4dE1mUWIzWWVLMlVUKzF0cXpFR0UxeFlCWUZteW85TWRENjNVT3FNUVZk?=
 =?utf-8?B?RUhrSDdNV2VzbXdjV29tNUpBV3lsY1B1akh2RnZWd3VFdXU3WStoYStqOG8z?=
 =?utf-8?B?VkhVdmtmQm5oc0FvTzNKbC9xMW1EbjUxMExlMEtCcEhjQ0RmUWh5KzFTSlhC?=
 =?utf-8?B?dnJCcFUxNitPUmhQcmRneHFOZXdJUFJ6QjlnY2NwWThWOG5kOUthYi90N24z?=
 =?utf-8?B?eGFDeFRTWjY1Zlc5NU5keUUyRGRGcDFwamY2NXAxajdYSWF4RHBpNjdPMHhO?=
 =?utf-8?B?WnNhTEc0YzhMdFhPbktXRDdVbVZRUmRXb3Q3YlZQK1ZmZjJ3WE5TelIrOVMr?=
 =?utf-8?B?RVpLdk5HZzFIMGZjN2FXWFR5cVlzZ1J1THBLekJxdTBPVHhXdGZ1ZjIrRUF4?=
 =?utf-8?B?WGYwZkpIeTdYLzY0WGZTN1BlVEs4Y2xZaHNlZTdmSUY3RGFRa3lZdi9QMkRB?=
 =?utf-8?B?bW1jbEVQZHZNZE42cCs1OXNSclRCZVhEZHAydS94RXdpUXJla3lsRGZBd0tp?=
 =?utf-8?B?VG5iblRQZWM4eE1IdmpqUVBHQkZxcFRXOTdlVHlLSkhSSUZvdzlhWmp2cDUx?=
 =?utf-8?B?c05xUmlkTDFlRjRKQ2QrYXgzemlZQ1hCMGZGa1djc3RhaGpHTmg2b3lxMTl2?=
 =?utf-8?B?VVVkTEtCUXNCY2Z1NmRtRGlMWFFkKzlQczBOcko5K3YwbFVRanlMVnNDQkl2?=
 =?utf-8?B?SmZ3THZjUnpLWFI3RXl4WHZsYjJ4cmkvTVA0R3doN3BxRXU2SUpZYWlSdFor?=
 =?utf-8?B?VUhtM29VN2tIVUVnUnN4Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTRaTGEyUjEwR2ZmWXQwYlNMcFg5TmRnZW85ZHR6UUJ1bm5WY3hld2x2Vldk?=
 =?utf-8?B?eW8vRlN3aVRZU2FXTFpaYUtySXFsMFY3UVh3TmVvMEZ3TDVvMWRqMEQ5ZUVL?=
 =?utf-8?B?WDNMbnhMQjBDZlR0V3FKQi8yeXYvalpTZEVVYjUyVEhuTTZlV2pkbjdLV25T?=
 =?utf-8?B?QzA5UkpGNTg1eXY0RnF1WVFZTnorVnRYTVFmZ1pSNlVmSmlKZU5vSG9nLyt6?=
 =?utf-8?B?ZE9kNUpHdytwOC93L25MMUZscHVNWXlJT253WlVsNlRMM2NJTWIrQzJwYU53?=
 =?utf-8?B?dit6MzZ0blBIKy9ib1NsQUJ2KzBPUWlJRTJ6YWh0Ky82T0RzZTJBZFhNcnNY?=
 =?utf-8?B?ZzVCT2VaM0JuT0dHeVdvdzA0SWg3UEs3YTU5dzRuc0pDZ3lvZ0o1THJvOURE?=
 =?utf-8?B?THdsQXloTzlNTzdCZVpyNGdWdWRoMElzRmdIamU1bVNPU2psblI2dVlOTi9X?=
 =?utf-8?B?U0lEYkh0aGdvb2IvRnp1cUNpWnJzY1FHVnNjVk1kVHVWQTNGNXV4ZDRUaklu?=
 =?utf-8?B?dmdHV2Raem43VFpyUEtySlR1MENxZjA5OVhwaUMxS3VCSnRGOW0rRnpaUDBU?=
 =?utf-8?B?dExmU1ZFRURCR05CenhRelQ5SzFrWFBCKytQcmRqSzFGMEZpYitseXpFcUVr?=
 =?utf-8?B?V2EvNE1zN0tkYkRwR1FUcFJQZlAvNlF6UHFhc1YrRnVPVVpxNmxPYnFka1E1?=
 =?utf-8?B?QnFDcWZMZ0lxakVyL2Rhc1dLZmtIRlovdU9wMDB3MjVNOXNkRUhkbDgycXps?=
 =?utf-8?B?aExtOHhWM01nTEJxVm1ZVXN0QW5UdklpRld4VUJTbDgrdjVwRUc4TkcyNDhp?=
 =?utf-8?B?Z1dwMisrNmJkVTFXaGltbFNmWDA4YWxaY1o3S2FCWnJzc1Y0c3BTdTkxMmRH?=
 =?utf-8?B?VGdlcHlGM2hLeGZLSHRwQVJGNERQdTEzdTNUSTVtb2w2M1FScGVrc3hTRDVI?=
 =?utf-8?B?L3Q3bmZOd2xnOFQxYVhNdDYzQWN4a1AyRi90Vk5uay9nN1hCbHJIZWtubDNH?=
 =?utf-8?B?eWxuZHdGTEtJZXVHaHNmNFRSTlpVWWJJK1hxRmVjODgvSlNnMnhLdEJaY1RO?=
 =?utf-8?B?Sm1WL1hmQ1J1NzRiNXdBQ0hyajZWZlZmaXFUKy9laFlmYmRPUWc1Wmg3MDlE?=
 =?utf-8?B?MXk0czRrY3BYQVV0WnJHVkw2b1JlOGcveGdIdCttK0EyV3pONkVlQkYrY3ZL?=
 =?utf-8?B?NWVPdkRlaVA4eXBhZWtscGh3UksycVVnWUlTd1hweVB6VVFib3ZzZ1Rib1ZO?=
 =?utf-8?B?RDZva245L3h2dVlsTmNwVXBxUHBuZ2JqRVRrdjMzR0RYZUtMRmFidythb05x?=
 =?utf-8?B?Tzh2RDBjVTZoMWJlYVZwNUNsK1dveGhtSUY2SFFQTDRZYUgvNTVtdnY2c2Zh?=
 =?utf-8?B?enBsV0Yvd09RbHJKUzZhK1d2WVBodld1Rmo1VTEwb3U4cExRVlQyeDE3dEQ3?=
 =?utf-8?B?VE0wOFM4MHhWZmZVL2tEbkpLYTRjc3FMNC9vM0pvTFhqczRvcFE0VVJRTDB2?=
 =?utf-8?B?SE1OQVFESWJTTmdLWitDNW5MelAwR2FSN3FGekZPWWxmYVpaNnUrMTl1SThF?=
 =?utf-8?B?cEc1elBwSzYwMFJ6NmRLSXFpdEhtNjN1eG84b3I2TGVmbEJaUjY5NHJLMHE3?=
 =?utf-8?B?UlRhVlB6UXRRN04wUGF6aXlqaGoxUjlrTGdJMy9VWnB1KzZqQmlLMXhkUEJm?=
 =?utf-8?B?VnRHMy9Ka3lSb0kvK2orUzNrS1lwYnlydXd2UzA5a28vM2tXZDFwZzlTTUVx?=
 =?utf-8?B?S1VKN0RVdlAzZG8vRU8wTGNoejVIa2lFR0tXcEtGb1IrTWcwaGR5RFVRSVdZ?=
 =?utf-8?B?Q01qWEhXRFF5cUVzY0Q3alNnTVFUc1F5c1M1aFZ6THJOTWlXbElLbXlpNTA4?=
 =?utf-8?B?V3dWWUtkb2xsOFgzS1drTUdrSGxHQlM3N1RHKzRydTZ3cW5IVmpxd0ZWdUlV?=
 =?utf-8?B?TUVEV2xMd1JQYW11b1lGTEY0RjcvWmVlUVk4cXlLcGN1N01UR0RyS1hXWnNq?=
 =?utf-8?B?c1JZZnpodHgvdnJJRUl3aS9LNFpDaXVVcDZKM0FiS2M5SkJ1MGo5NHprNGNt?=
 =?utf-8?B?Q08wZ2cwSzhzR3RHblE3cHZwNE9peVgrTkU0TDAwVkFic0xRQ1JSdnF2dVEz?=
 =?utf-8?B?RlM5Umx1cGswMTNuNkhiUjlHNmV0bEhxdDJxTytwTjdOS1dIQU85NkdnMVRx?=
 =?utf-8?Q?GbDhjCvVWCJKYDCtEHCVNfg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C19B5F59DDF897458BC900A478DB6C9C@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74efd5a-7d38-4920-2efb-08dc74aea46a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:14:21.0731 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7A6C/3ujJFloHWaiH5DXwHLgpxu4qDow5S3AtpDeFgpuJnixaCPzbaJetmot896wltA+m+KP5WEhYPEb5q0WxvzxbOXNBvPOoBjhD2MeSCcZ/gwe3wlfMSPbPd72YGGd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6718
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

SU9NTVUgaGF2ZSB0byBpbXBsZW1lbnQgaW9tbXVfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb24gdG8g
c3VwcG9ydCBBVFMuDQoNCkRldmljZXMgY2FuIHVzZSBJT01NVV9UTEJfRU5UUllfVFJBTlNMQVRJ
T05fRVJST1IgdG8gY2hlY2sgdGhlIHRsYg0KZW50cmllcyByZXR1cm5lZCBieSBhIHRyYW5zbGF0
aW9uIHJlcXVlc3QuDQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNs
ZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaW5jbHVkZS9leGVjL21lbW9y
eS5oIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKysrKysNCiBzeXN0ZW0vbWVtb3J5LmMgICAg
ICAgfCAyMCArKysrKysrKysrKysrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgNDYgaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9leGVjL21lbW9yeS5oIGIvaW5jbHVkZS9l
eGVjL21lbW9yeS5oDQppbmRleCAxOThiNzFlOWFmLi45OGIwMmI5NDJjIDEwMDY0NA0KLS0tIGEv
aW5jbHVkZS9leGVjL21lbW9yeS5oDQorKysgYi9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgNCkBAIC0x
NDgsNiArMTQ4LDEwIEBAIHN0cnVjdCBJT01NVVRMQkVudHJ5IHsNCiAgICAgdWludDMyX3QgICAg
ICAgICBwYXNpZDsNCiB9Ow0KIA0KKy8qIENoZWNrIGlmIGFuIElPTU1VIFRMQiBlbnRyeSBpbmRp
Y2F0ZXMgYSB0cmFuc2xhdGlvbiBlcnJvciAqLw0KKyNkZWZpbmUgSU9NTVVfVExCX0VOVFJZX1RS
QU5TTEFUSU9OX0VSUk9SKGVudHJ5KSAoKCgoZW50cnkpLT5wZXJtKSAmIElPTU1VX1JXKSBcDQor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID09IElP
TU1VX05PTkUpDQorDQogLyoNCiAgKiBCaXRtYXAgZm9yIGRpZmZlcmVudCBJT01NVU5vdGlmaWVy
IGNhcGFiaWxpdGllcy4gRWFjaCBub3RpZmllciBjYW4NCiAgKiByZWdpc3RlciB3aXRoIG9uZSBv
ciBtdWx0aXBsZSBJT01NVSBOb3RpZmllciBjYXBhYmlsaXR5IGJpdChzKS4NCkBAIC01NjcsNiAr
NTcxLDIwIEBAIHN0cnVjdCBJT01NVU1lbW9yeVJlZ2lvbkNsYXNzIHsNCiAgICAgIGludCAoKmlv
bW11X3NldF9pb3ZhX3JhbmdlcykoSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11LA0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBHTGlzdCAqaW92YV9yYW5nZXMsDQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCk7DQorDQorICAgIC8qKg0KKyAg
ICAgKiBAaW9tbXVfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb246DQorICAgICAqIFRoaXMgbWV0aG9k
IG11c3QgYmUgaW1wbGVtZW50ZWQgaWYgdGhlIElPTU1VIGhhcyBBVFMgZW5hYmxlZA0KKyAgICAg
Kg0KKyAgICAgKiBAc2VlIHBjaV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbl9wYXNpZA0KKyAgICAg
Ki8NCisgICAgc3NpemVfdCAoKmlvbW11X2F0c19yZXF1ZXN0X3RyYW5zbGF0aW9uKShJT01NVU1l
bW9yeVJlZ2lvbiAqaW9tbXUsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgYm9vbCBwcml2X3JlcSwgYm9vbCBleGVjX3JlcSwNCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBod2FkZHIgYWRkciwgc2l6ZV90IGxlbmd0aCwN
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIG5vX3dy
aXRlLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIElPTU1V
VExCRW50cnkgKnJlc3VsdCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzaXplX3QgcmVzdWx0X2xlbmd0aCwNCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCAqZXJyX2NvdW50KTsNCiB9Ow0KIA0KIHR5cGVk
ZWYgc3RydWN0IFJhbURpc2NhcmRMaXN0ZW5lciBSYW1EaXNjYXJkTGlzdGVuZXI7DQpAQCAtMTg3
MCw2ICsxODg4LDE0IEBAIHZvaWQgbWVtb3J5X3JlZ2lvbl9pb21tdV9yZXBsYXkoSU9NTVVNZW1v
cnlSZWdpb24gKmlvbW11X21yLCBJT01NVU5vdGlmaWVyICpuKTsNCiB2b2lkIG1lbW9yeV9yZWdp
b25fdW5yZWdpc3Rlcl9pb21tdV9ub3RpZmllcihNZW1vcnlSZWdpb24gKm1yLA0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIElPTU1VTm90aWZpZXIgKm4pOw0K
IA0KK3NzaXplX3QgbWVtb3J5X3JlZ2lvbl9pb21tdV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbihJ
T01NVU1lbW9yeVJlZ2lvbiAqaW9tbXVfbXIsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgYm9vbCBwcml2X3JlcSwgYm9vbCBleGVjX3JlcSwNCisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBod2FkZHIgYWRkciwg
c2l6ZV90IGxlbmd0aCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBib29sIG5vX3dyaXRlLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIElPTU1VVExCRW50cnkgKnJlc3VsdCwNCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplX3QgcmVzdWx0X2xlbmd0aCwNCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCAq
ZXJyX2NvdW50KTsNCisNCiAvKioNCiAgKiBtZW1vcnlfcmVnaW9uX2lvbW11X2dldF9hdHRyOiBy
ZXR1cm4gYW4gSU9NTVUgYXR0ciBpZiBnZXRfYXR0cigpIGlzDQogICogZGVmaW5lZCBvbiB0aGUg
SU9NTVUuDQpkaWZmIC0tZ2l0IGEvc3lzdGVtL21lbW9yeS5jIGIvc3lzdGVtL21lbW9yeS5jDQpp
bmRleCBhMjI5YTc5OTg4Li45Yzk0MThjNWVlIDEwMDY0NA0KLS0tIGEvc3lzdGVtL21lbW9yeS5j
DQorKysgYi9zeXN0ZW0vbWVtb3J5LmMNCkBAIC0yMDAwLDYgKzIwMDAsMjYgQEAgdm9pZCBtZW1v
cnlfcmVnaW9uX3VucmVnaXN0ZXJfaW9tbXVfbm90aWZpZXIoTWVtb3J5UmVnaW9uICptciwNCiAg
ICAgbWVtb3J5X3JlZ2lvbl91cGRhdGVfaW9tbXVfbm90aWZ5X2ZsYWdzKGlvbW11X21yLCBOVUxM
KTsNCiB9DQogDQorc3NpemVfdCBtZW1vcnlfcmVnaW9uX2lvbW11X2F0c19yZXF1ZXN0X3RyYW5z
bGF0aW9uKElPTU1VTWVtb3J5UmVnaW9uICppb21tdV9tciwNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBwcml2X3JlcSwNCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBleGVjX3Jl
cSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
aHdhZGRyIGFkZHIsIHNpemVfdCBsZW5ndGgsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgbm9fd3JpdGUsDQorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIElPTU1VVExCRW50cnkgKnJlc3Vs
dCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c2l6ZV90IHJlc3VsdF9sZW5ndGgsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVpbnQzMl90ICplcnJfY291bnQpDQorew0KKyAgICBJT01NVU1l
bW9yeVJlZ2lvbkNsYXNzICppbXJjID0gbWVtb3J5X3JlZ2lvbl9nZXRfaW9tbXVfY2xhc3Nfbm9j
aGVjayhpb21tdV9tcik7DQorDQorICAgIGlmICghaW1yYy0+aW9tbXVfYXRzX3JlcXVlc3RfdHJh
bnNsYXRpb24pIHsNCisgICAgICAgIHJldHVybiAtRU5PREVWOw0KKyAgICB9DQorDQorICAgIHJl
dHVybiBpbXJjLT5pb21tdV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbihpb21tdV9tciwgcHJpdl9y
ZXEsIGV4ZWNfcmVxLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYWRkciwgbGVuZ3RoLCBub193cml0ZSwgcmVzdWx0LA0KKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVzdWx0X2xlbmd0aCwgZXJyX2NvdW50KTsN
Cit9DQorDQogdm9pZCBtZW1vcnlfcmVnaW9uX25vdGlmeV9pb21tdV9vbmUoSU9NTVVOb3RpZmll
ciAqbm90aWZpZXIsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVU
TEJFdmVudCAqZXZlbnQpDQogew0KLS0gDQoyLjQ0LjANCg==

