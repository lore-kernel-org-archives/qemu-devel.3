Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B089EC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WCy-0007qv-Vs; Wed, 23 Apr 2025 05:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u7WCn-0007oF-6W
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:15:45 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u7WCk-0005eI-C3
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1745399743; x=1776935743;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=9Azk/2tG51m7EzmCx0R+bil78NvkI+E8sY92lRbOnEw=;
 b=xIRP5i9s9rImy9N0PxOqThAzCISrX/d/MVHHY5IhBDRmS2QU9gtgaCai
 p8u7JZHQIv1gGQD3Eauo6E+iICmQ/dqBr74sVpbC2a1ZnSe6pbSH7KPoN
 Oa033kcdSdBg458ctRVHsY8H83bYyxQderxeQzcLkYjb6QLk5ON+3vY9z
 2kLenhfqtplXDPhXTRJJAM+BnmapgELlc3FcjVHiWis9nVVQ/EoYao9vA
 Ayn+6MDdnHRcLtxAS9NvsLPYBzpWmehzBawp+zOaQzYtxJHSQcrLA2Zbm
 lldDYPEqvP+86JFeZlLlkEoXG1JRUsokYLpxdBBueYG1Z4nLmom0cqCms g==;
X-CSE-ConnectionGUID: kd8Hw7RcSl2EOOd1VuLG+A==
X-CSE-MsgGUID: wLaDAHnjQ6eDqJ3gLt5+Kg==
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; d="scan'208";a="37632957"
X-MGA-submission: =?us-ascii?q?MDHfBSqU9FgdkPo8jKK8VV0WvaUlifQkNiVXHH?=
 =?us-ascii?q?UkVthaP2tvQ1xkwY1RW6M8UL3PIApr1sj8i2H0f2+pn88UnuHFPxFSAA?=
 =?us-ascii?q?TY4M54tRXdeIwIiZelfoJo8rceErxLgKWSUTa7mkDU8EDRDEkKYlERrk?=
 =?us-ascii?q?TlwM/Mw3c2Y034qGGFxIL+3w=3D=3D?=
Received: from mail-northeuropeazlp17011021.outbound.protection.outlook.com
 (HELO DB3PR0202CU003.outbound.protection.outlook.com) ([40.93.64.21])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 23 Apr 2025 11:15:39 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhvPXy0peGiYHDz59QwNQZWA+QE/pK8TwGjxwIhk34ZXVmdI4DNoX32h65vicZDOR5s7Ws+SRtUngKT7lLJhYDA4S8PhbxJoLFbtFLoQnqXaTKfKnFD/5TjpTGcq/Xi5D5GX2JhYbnopGqQslvoIYrVfl/Z3o8Q2LDIssAiTt+Tli2r99h4mgGX/yEX6o4cejHclkA0e0o8VjrhvmTnh8bklcdg34/RkqdbLH5IXE/k6pr79Rmq0OhADW9O20v6DuOqEwlZyjN2ICDR2RXsca1UHFkTCXhQWUWsd0n8MaUFX3Nbb1kG1mruSoESbdbDDecCP7kstqZ6+ae2aJ0rc3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Azk/2tG51m7EzmCx0R+bil78NvkI+E8sY92lRbOnEw=;
 b=vDohSXaGXEzbcMP4cqr5s4a4uesOuGiMhT19Ii8onj4RDCWiMNATbX3B54JRHdV8pLJpkjXjTENvia1OcE1TDP66WKfU9WngTmGhwqnTJa9wY5VLzjBTzEscG1O/usuiXk0j/xksintkuTfYni3CeN5OetU0liQan3K1P5jIAzBUos5PD6sApm2BdBVCuvshDGb/JadCZk2DFnaBzjtbOJIj+xVhpaOW0oftDXkfQQOz2edceb10FRKhCzH0VSVoHHpFCOs14y+S5ojHSCn95Sxi/iJF9lriC/F8LYtC1eMLwv1yJ6KL7YpVaMxysHTDRVP9vO/73e7wgGmXnkCReg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Azk/2tG51m7EzmCx0R+bil78NvkI+E8sY92lRbOnEw=;
 b=jK46NRTBD0CozqzxkuivEcCF6H2hGMqx9847NC2fqHNABuZmZcu1OFEnez6MJUral5yQYrra1MLjzIHYQzzpEBdaonURTWh2QuDonvOs+Mbd6ACmfwZpzZcVaYnLP8uNR/lqII3Yt9r/uo31K9OP5f0UmZeI0JZHkaJGIyEnUdGvjzmiPzP91kT4ATA5v1XnqQOoNanZe5z9Ek1E0K6kbAjQ0smFTvISfTyKmMzRnwjFgpXmuXRdskABBT0nttxwLlFfRUB4Z5LSG77uX2yh8ocsW0Z452ce9QGetNTncfaczRxtqyVjx6+VBo2IqON1BbxsDWrzAu7JqMai2rix4Q==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB9461.eurprd07.prod.outlook.com (2603:10a6:20b:632::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 09:15:37 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 09:15:36 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, 
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH v3 1/2] intel_iommu: Take the bql before registering a new
 address space
Thread-Topic: [PATCH v3 1/2] intel_iommu: Take the bql before registering a
 new address space
Thread-Index: AQHbtBHswoqaONJjl0KQ7HZVe2CuOrOwwdeAgAA2iQA=
Date: Wed, 23 Apr 2025 09:15:36 +0000
Message-ID: <b848eddb-8c5c-4e25-a88c-36583a485d31@eviden.com>
References: <20250423053742.65401-1-clement.mathieu--drif@eviden.com>
 <20250423015815-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250423015815-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB9461:EE_
x-ms-office365-filtering-correlation-id: 969da3ca-9fa5-46f6-7fd1-08dd82476885
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q1JOQ1RIRlJUd3pTQkRUcElScCt6dnZ6aHpDWVUxS1JxUlBjMXJDM2Voem9E?=
 =?utf-8?B?K0tzZHIwaXE3NWNmczVQRFhRd0w4NWh4a3ZBZHhrNkxLVWN3Vi9xRjVLVHdh?=
 =?utf-8?B?bkJFMC9GUjdRbGZGc0ZQdkJOK1Y4M2pzOG93TmpBMkpzcDI0cDJkeGUzRjdl?=
 =?utf-8?B?YkFycjY1ckpQcnYrUE5sWWw0UGRpN0xqb3hZMzBSQ3ZUTlBsMGd5QnB5K2Y5?=
 =?utf-8?B?UEhzY2cxRDZRc2gyWWhKRzYrenVQaGdOSDlXMnVOTnlUaTRKeGJtbHFnSEk3?=
 =?utf-8?B?QitPSmxLL200QkJxR2Z4WXBKNEMrVnFWaThzTSsyU2FtV2JSaXBrdzRUVm9i?=
 =?utf-8?B?R3ppTEpNcll6ZHJ5TWtvZHVrNHhzV2I2NERQSStCQ3JWa3hDd1pWaTljcVlx?=
 =?utf-8?B?QXhzMlVSWS85VjhSakswOFZwOWtObUdaYUpielI3TzQ5NUlMS3cwbmp1VmFM?=
 =?utf-8?B?V1o3aXZiOVlJVk9jbWdXeWJkU1RGYXIzbkVJMGNsZGZjeW9jT0ExV0l0bnRj?=
 =?utf-8?B?ZC9LU2dXSGtGN0ZhemMzckl2a21Ic2dzOGd1cmtWNlZzTHhTUjNWcytEVDlv?=
 =?utf-8?B?YUNQNlZ6dzJjSHRUNEVzd2FvUW0xTkV5eFpmT1pNWDM3enR3bGlkOHhRQXBu?=
 =?utf-8?B?K1hwbW41ZVVSZGtsWWJtQTJYZHNoaWJEYjZ0bjhtbzJQdXNSb0g0UFFJTVI1?=
 =?utf-8?B?Vi9vbGI2dWIvazBKWGdBUCttSGVKTjZyUVJKMkF1b2lXKzVWWWhyRS9KOUJC?=
 =?utf-8?B?YUE5Z2tVelFOc1UxNUVRMVpMZ3V6Uy9NSS9PeTc5OXJ2aldGcEZlL05lcU9C?=
 =?utf-8?B?VUZYcUd3MktWS3dVOXA3S0ptUnExTE4ySWhwSU1OY1Bld3JVMm9OK3JiNWR1?=
 =?utf-8?B?ZW9vdFZNY0xaLzkxUlBrdzU2cW8vd1diZXZiTTdUdDhCSkV1bHQ5dUlJZElQ?=
 =?utf-8?B?WCtwMHh0WUhVMFJDNGhFOTFla2p3TlF4NzB4UmlLL0N4eWExUUhGSXkrc1lz?=
 =?utf-8?B?OW1TdmVFaWpDb1QxK1Z4K3ltNnZucHV4MkdYRkVIKzdvRFAvVXZxbVhUZG5N?=
 =?utf-8?B?cmorb29kU3VMV29VVlRRWFlxQllPUzdZQy90UXIvS2k0cDc0RExyR1N2cFNi?=
 =?utf-8?B?bTNPVVpLSFBlS3lwajliTE5hRzdEWFM2VG1EaFlCZkh1cHUvRDJKVVp5THVn?=
 =?utf-8?B?bUhyUXhBaWpObDNXa2FXbmRRcGZ5SXNlYTJhcVFFN29CUmZqTkJJdlZGakpK?=
 =?utf-8?B?RG00N0lyWWlFaFNjSHBTZ0tERGJKVFM2WTRjU2ZFUlp0Vk5hR0pQVjNnVUpI?=
 =?utf-8?B?T0N3STdpYVQ4U3hqbUdkWHYyVGVTNmhYa0hHRUhZckFoYjZGQ1oxa3lKckMr?=
 =?utf-8?B?M1FrUUoxbExweldKWkNtWVlIWU5UYVFDSU02WitMVm9BSE5Fd21GSGlGS0l3?=
 =?utf-8?B?WUhZeGxOQVdveC9ZNSsrMVQ4cFdGMWhFYzloN2hOZWZaK1pyZ21YTUFFWkk5?=
 =?utf-8?B?Q3hxVXBrNllkd2cvTG1Rb0R0b01mZEd3V1JIbkw0RStyZWRreFhFRHVOcHdj?=
 =?utf-8?B?a0tXTEVSTlNlbk5BQ0hVYzJvMVBYdmM1VERMT1pId1o2dnZsU0VzSWtyYXNT?=
 =?utf-8?B?bVJGN0hpNVRkc29RMWdrQUlTK0FMZWZPUkxyaE1vYXl0YUJxdDl1WFdSYWZw?=
 =?utf-8?B?Z210cDhQWnp2aGVWUVpEeHFpZ1M3ZU56U3FNYTl0VHFUR2tZYldyclNsMmtK?=
 =?utf-8?B?eGs1TmNOems0RDdKMXYwV0NkZm5RTTdlMjZ0NWVMM1QvdXFBZGpmbWFHVHNW?=
 =?utf-8?B?UHVuYTJTWDVtUHF0cTcweGdrR3F6TGFicDR1ci9CYkdXWWJ6dVRKZ1NmMi9J?=
 =?utf-8?B?S2ZaakJrYm95M1dzdGVwS2lRWkJVRHlJSk1FZmxaWVpMTjhNVDZBN0FNK2hY?=
 =?utf-8?B?a3o2SmdYREt2UUZvNlBrVHdTT2RMbmxCcnM3dTZKaDMwY3hYV2J0Rm53MXR1?=
 =?utf-8?Q?75CNVi3SvB403m1JH9Ivwvql3+BdzY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHZhZzcrSHRENmFCUk0yd3ZTclpGRDg3ZURZTkNiSDduTFJIOFBPaGp6eXZr?=
 =?utf-8?B?dWRoN1RyN1Nscmt1cmd2TzdvVEhlUHUvdVFGcEJlL2JGdzRnd2MxYjYwNXFl?=
 =?utf-8?B?VzluaXVES3FTdFdxN0l4TEhIcUNwYjZTMmxsZ3hGNFEzV3lodHhSeVA0Z3BS?=
 =?utf-8?B?VmhNRnpFR2RCakxReUFkaUVITGp2Vy9NZFlJVUVaWWptVk9qWU4yYkJMTjl0?=
 =?utf-8?B?K09oTXFDR1V0Y3BSQit4V0ExUHlndlNQWFZYc0FhTWJMWFlLK0ZDRDhhQURF?=
 =?utf-8?B?K3lJWmo5dEE2TnlLUXJjMFBsNjRUdUxma0FBR0VoRGl1cUNQTmhJa0FMMVpF?=
 =?utf-8?B?YVB5cWt0TEZKNTFyc0xUMUlKbm1WR09BeWoydVAwekw1Q2pWZ2h5MzYxT1N0?=
 =?utf-8?B?NHlzWHhWYWlJcjFxbC9OS2ZmM1RpRkpUY01XRHp6REY5WlBvR1BnRm1tR0Zw?=
 =?utf-8?B?SGRjcmgwYVRQSll2NHdlVmFEblFRdDIxdXB6L0J3MmlxR21ObG9RNFNDclU4?=
 =?utf-8?B?NTlKQ1MzQVAwWUJGVjAyTVZKNWtKTHZNRE44WUIwcVB3S1UybHNyaWh6OHlT?=
 =?utf-8?B?VzVqN05adjVvU2hXS01jTFBMSWxZNXhUcm9GYWo0MGFUSVY5VUg3YTM2My9a?=
 =?utf-8?B?WUtwYkw3aldWNEVDZWdqUHRtMWR6U2Q2NTBWcUU5VDR2MXhQM3lweVc3OG5x?=
 =?utf-8?B?b1ozRThSQjhyeXNtd1BqdUVzR1VzZzNaVjdFOEhsMTBRN3MwUzdieWhsVzFD?=
 =?utf-8?B?YjdCOVd1Tjl4NE5nVXFvZzBCdEVwWUoza2h1d0NHcGd4QVdJOEhrN3RRbUVV?=
 =?utf-8?B?bStLVnVyaHloejNIOG4vWDA4TnV5SXQ4dUhFdHRPMGZVMzdVODdrZERpY1lt?=
 =?utf-8?B?N3M4dFE4RHNrQmNWSjZkSi9lYWhSOXBOejVHNGgyQUZwQm9DT1J3aHZVUVhr?=
 =?utf-8?B?VmZ2c1p3L21oRDlEaXRDc3U1akZTOG1QLzhvd01lT3N4dHVOdWdtd2plZDFM?=
 =?utf-8?B?OEtRNmR3Yys1cFQwa1F3ODUyUEdrV0NlbmQxZFJ5TlVYQXRoUU5PaVJzakta?=
 =?utf-8?B?TGF1VnJ5MDR1OFdBTXdoQkJjeWZsallYdUJvelBVbnVLd1ZKSGIyNFl1WkQw?=
 =?utf-8?B?dTdKdS84TUk5RjRKUnFOVDhSaWpZZGt6TUpmeUpCMFV5TmF1S0FsTitiRmZs?=
 =?utf-8?B?NXRVVHZBakFCbHVJZUJDd1J5d3RuVjJwOTJHNStabVpSMzlZT1VDSStYYld5?=
 =?utf-8?B?WGNTa2wyUThqc2g2Wkpzd2ZiSjk4aUM3L2JWZVhTOW9aVjJveEl6TDdkQ2dK?=
 =?utf-8?B?S1VwaUxybUt1S1dBWU8yckJHVEdVZWZQcHc5SkJsZnZKMHZzRFgxMWdjd0s0?=
 =?utf-8?B?YTRqTmNocThrdldEQWRyU01LNjRzMUl3eGREaGlXZUtyTkpNcXNieHkxaUF5?=
 =?utf-8?B?b3FTNkorcU90YlRQMjN5bGNia0tRY0s5UVdnRXRCWTRJczkrR2oweXg4SXI1?=
 =?utf-8?B?WUR3QVE5cWtkNXJrakhUTkN0Kzl3akhZWVpodTQ2d213R1Z6ZE1LdVZOT3ha?=
 =?utf-8?B?VTJaUkhqWGtGd2JEUDRGbnNwN1BLNzVzRXE1TFAzL2lYbk5wcUNQaWV1T0Rt?=
 =?utf-8?B?QUo0b2pmRFVUYTBMalZGMXhVaFBpNnJGOGdkTytVdXZiRHRWMEpST1AvS1Nn?=
 =?utf-8?B?MTdxckJiNnZTc3NxaVllSTB0Tlp2d0IwYjBwb3ZFL0FFcXcrVE1BWDYzSTlV?=
 =?utf-8?B?MHJWQUV3RDhkcFlwaUxFdk9CdUphU2NnalJFZDFSUjZNTTlXRjgwSVJObkJn?=
 =?utf-8?B?Q1BJa1hXTjdqVHpMZGlCQWYrTTNrejFpdmtEWUxuRHIwNGlseVRmd0ExQldM?=
 =?utf-8?B?dlBuUG5FTmp4emtUdENKdDBGbGhrSWZhbW1tVW9aUjFtVVd1bFM4UEg4SE9H?=
 =?utf-8?B?bXdTUGdqczhnM3FPMTVrVDBWN2RkT2lXN0hQVjJJOXVEWU9VcklVWWF4M21m?=
 =?utf-8?B?bjVRSlA5ZmRxTkJnUjRDcmU0cVFsVHpWcGNHVnltQXdyem5DR05GL3pDeUkv?=
 =?utf-8?B?Q1ZMek9YR1kwRytvdjE4RGhFQmN2SmxaeHBicG1KakxOVGI4QjgvbncvZnBv?=
 =?utf-8?B?UU0wa2c0RlpXK2xPS2tKUjhhdjY0QUhLbWtOWXZYbUYzb2ZUYmcwWHJIUlpj?=
 =?utf-8?Q?mTxDDw803dkD7vUM/a/o4UI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEFFFA251FE7C34FA46A0A96DBE35904@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 969da3ca-9fa5-46f6-7fd1-08dd82476885
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 09:15:36.3781 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oXupHwYG9ijdzC8SI1ecvoOsCp0m+LLsbMmEfrXv3+yrPa0MckxVu4PJ+kkeE+xDeHvYo8Zp6QyuS2l3pF47A7bod5LUvVXa9fblYpbnipo9ZkCni+scWevfCv9xnTGP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9461
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

DQoNCk9uIDIzLzA0LzIwMjUgODowMCBhbSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOg0KPiBD
YXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sg
bGlua3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+IE9uIFdlZCwgQXByIDIzLCAyMDI1
IGF0IDA1OjM4OjIwQU0gKzAwMDAsIENMRU1FTlQgTUFUSElFVS0tRFJJRiB3cm90ZToNCj4+IEFk
ZHJlc3Mgc3BhY2UgY3JlYXRpb24gbWlnaHQgZW5kIHVwIGJlaW5nIGNhbGxlZCB3aXRob3V0IGhv
bGRpbmcgdGhlDQo+PiBicWwgYXMgaXQgaXMgZXhwb3NlZCB0aHJvdWdoIHRoZSBJT01NVSBvcHMu
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2xlbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1h
dGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4+IC0tLQ0KPj4gICBody9pMzg2L2ludGVsX2lvbW11
LmMgfCA2ICsrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9t
bXUuYw0KPj4gaW5kZXggZGZmZDdlZTg4NS4uY2M4Yzk4NTdlMSAxMDA2NDQNCj4+IC0tLSBhL2h3
L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBA
QCAtNDIzOCw2ICs0MjM4LDEyIEBAIFZUREFkZHJlc3NTcGFjZSAqdnRkX2ZpbmRfYWRkX2FzKElu
dGVsSU9NTVVTdGF0ZSAqcywgUENJQnVzICpidXMsDQo+PiAgICAgICAgICAgdnRkX2Rldl9hcy0+
Y29udGV4dF9jYWNoZV9lbnRyeS5jb250ZXh0X2NhY2hlX2dlbiA9IDA7DQo+PiAgICAgICAgICAg
dnRkX2Rldl9hcy0+aW92YV90cmVlID0gaW92YV90cmVlX25ldygpOw0KPj4NCj4+ICsgICAgICAg
IC8qDQo+PiArICAgICAgICAgKiBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb25fb3ZlcmxhcCBy
ZXF1aXJlcyB0aGUgYnFsLA0KPj4gKyAgICAgICAgICogbWFrZSBzdXJlIHdlIG93biBpdC4NCj4+
ICsgICAgICAgICAqLw0KPj4gKyAgICAgICAgQlFMX0xPQ0tfR1VBUkQoKTsNCj4+ICsNCj4+ICAg
ICAgICAgICBtZW1vcnlfcmVnaW9uX2luaXQoJnZ0ZF9kZXZfYXMtPnJvb3QsIE9CSkVDVChzKSwg
bmFtZSwgVUlOVDY0X01BWCk7DQo+PiAgICAgICAgICAgYWRkcmVzc19zcGFjZV9pbml0KCZ2dGRf
ZGV2X2FzLT5hcywgJnZ0ZF9kZXZfYXMtPnJvb3QsICJ2dGQtcm9vdCIpOw0KPg0KPiBEb2VzIG5v
dCBsb29rIGxpa2UgdGhpcyBhZGRyZXNzZXMgYWxsIHJhY2VzIGhlcmU6DQo+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC84MDYyZDg2OC00NjlmLTRjMWQtYTA3MS0wOTliOGUxODg1N2NAcmVk
aGF0LmNvbQ0KPg0KPg0KPiB3aGlsZSB0aGlzIGNhbiBiZSBhIHNlcGFyYXRlIHBhdGNoIG9uIHRv
cCwgSSdkIHJhdGhlciB3ZSBqdXN0DQo+IGFkZHJlc3MgZXZlcnl0aGluZyBpbiBhIHNpbmdsZSBw
YXRjaHNldC4NCg0KSGkgTWljaGFlbCwNCg0KV2Ugb25seSBhaW0gdG8gZml4IHRoZSBwb3RlbnRp
YWwgY3Jhc2ggaGVyZS4NCkkgc2F3IFBhb2xvJ3MgcmVzcG9uc2UgYW5kIEkga25vdyB0aGUgcmFj
ZSBleGlzdHMuIEkgd2lsbCBzZW5kIGEgcGF0Y2gNCnNldCB0byBmaXggaXQgc29vbiBidXQgYXJl
IHlvdSBzdXJlIGJvdGggZml4ZXMgbXVzdCBiZSBpbiB0aGUgc2FtZQ0Kc2VyaWVzPyBJIHRoaW5r
IHRoZSBuYXR1cmUgaXMgZGlmZmVyZW50Lg0KDQpjbWQNCg0KPg0KPg0KPj4gLS0NCj4+IDIuNDku
MA0KPg0K

