Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DAFE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 05:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPxo4-000606-O1; Tue, 24 Dec 2024 00:50:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tPxnq-0005uN-0e
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 00:49:58 -0500
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tPxnm-0006Vz-Cr
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 00:49:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1735019394; x=1766555394;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+hGZ/WtGadq+xQ7ScZhp/KQ2zXxOpXRWdoso4d+MzbY=;
 b=wjfsFqcT7bcHDQCcy4o5XLy6GpAGEYNI4aMgMPwSfWIyTSD7f7y7eBGR
 /E39rr2+CTwjLiP+SPpPv9jc5tcGtwvjvefNb+hmdqXbVG9D7qr40iMjP
 +VcnaKfB2vrhJJ8lG7mrHyqZBfF5i0/c7opXT67F2xetOWdazgfwARY0Q
 NXUtjcIlnN5LuQh4L49ti+TgQFEs/geq04JOY7qf8Ajp+ntR6bRXswaWp
 unAxUYCTj1yv6D9y5JXcOi3oF7rIySPkDExKNMuCREgbqn8lidIENcjU4
 hihq8cWOb39CxmzS2pibjUyTnOEPGodIAem+8b1BTLBDr7q8e5hF1BzIe w==;
X-IronPort-AV: E=Sophos;i="6.12,259,1728943200"; d="scan'208";a="27370853"
X-MGA-submission: =?us-ascii?q?MDEtDwM/Q4D6Yvlvdw3vrmQFHGGXmhzXP0+vSS?=
 =?us-ascii?q?CpeShfB6v6w9VHCIFFeeh9u9fPqFYTYRTp1WK0OHan3/+YZY8vUFa/uT?=
 =?us-ascii?q?d9ec4w5C0VZKdNi9PffyNFPrviyXdhm/ey+fkp/HDbVXb+hObpezE6kp?=
 =?us-ascii?q?ilA42hL3hcSThmzKsjNxKu0g=3D=3D?=
Received: from mail-vi1eur05lp2173.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.173])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Dec 2024 06:49:48 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMU2gFsl7pMi+vy1wQ6UvUUK5HRVYOqZaXDiHbusojS3MCbGlOmyRwI3zf3f7EAif5PxvgCKIUzVO8phF7e0qK4jPMe8jdCAwVO4zsFrBv3QtZTtmWnRGgYfNcNMD5RJEv8z0N4s2Cuw1mMa9bGT5Fbu+IUIiOIYHHy2viSTpq+UtJaiZImuBl7rtuJZQ6x7u6aaf2Zv75DkMXUOtrAoNH8NLL45NOguMnHsxLBx0ITU4oJkCQA8omRMgYJAdKUASM0A945/iqTBmctWFc2luKccQutoGdeBhaR+/EhX0JxMqEsfZq1BRugzFwDwZvyyjNieAUMs841ZMaUf/dOxqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hGZ/WtGadq+xQ7ScZhp/KQ2zXxOpXRWdoso4d+MzbY=;
 b=lXX6azADvKH3c32gwbqq8ju38+KTaTkCn1KX8sPJIazfaHaAYS4FhMWo6EdAUPLL/KPVljrJyzJYpMyOup5V9NFU28CqlXsm2MPjuwYon1VjshZZ0bPi1XFklfJokzXbPvhBdo+VSbvx+LnFLSCK8D1TXQc7sywmsUB717x/aHaI26RCfcEQykWfbqkHUqrjsYk/igtf6+Fo4JJv7Qs3xgux1vTpEH2xPbuMAp9bB0lmRTPQFxNdazbSXSPK7+Pe9PaRq+NOvbQlo+8PuEcgj5rpQCi3iAlenw+iUAcNz3mnNNdesgNblcZrwK6lPoruhV80lX4G876hziaNHjUP+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hGZ/WtGadq+xQ7ScZhp/KQ2zXxOpXRWdoso4d+MzbY=;
 b=FI6ZdF+R9Mhmzuvf4hArW3nDfzhZ5+0mIaunvYg+jrvo88iGvUd/b/dy+Nm0+6rdkuChOi5vjRi/TNykzJGHbQzrNCza5TPIA8lAc23YZmaf/15q6WggNT1Bgy1x8/Hcbnr/wJrz2ojsUk++XKA07YCWZN4ktPLrtqpWo3Q39ppKFeEng0WF0wbpZt+kUwrjmuXZLhJHverZw1ekupbE6YR+MLZZTnxjpj3bPxEGkCDkC8hkj+geJMAy0k33iXdaUg8EUEVjncfzxm7TrmmjsC72UpcCKawZLiMALxKJBCAbYFY5/pAE8dIQoWJUPSxXPoASQqlfSFk38EJTdZ9RYg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU2PR07MB9436.eurprd07.prod.outlook.com (2603:10a6:10:497::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Tue, 24 Dec
 2024 05:49:38 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 05:49:37 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "tjeznach@rivosinc.com" <tjeznach@rivosinc.com>, "minwoo.im@samsung.com"
 <minwoo.im@samsung.com>
Subject: Re: [PATCH v1 04/19] intel_iommu: Fill the PASID field when creating
 an IOMMUTLBEntry
Thread-Topic: [PATCH v1 04/19] intel_iommu: Fill the PASID field when creating
 an IOMMUTLBEntry
Thread-Index: AQHbQjJvXDmiXC52f0OTAvckNfcVmbLzXN1wgAGt6gA=
Date: Tue, 24 Dec 2024 05:49:37 +0000
Message-ID: <1a343d39-6e08-465a-9172-914c8e52a400@eviden.com>
References: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
 <20241129074332.87535-5-clement.mathieu--drif@eviden.com>
 <SJ0PR11MB6744CEB446CE24277E7CA2BA92022@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744CEB446CE24277E7CA2BA92022@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU2PR07MB9436:EE_
x-ms-office365-filtering-correlation-id: 839a8086-5d98-4c64-06e5-08dd23dec0a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?aVVNa2FmOFNabGFsVkN1UEJtMzNwSGdZRGlPTE91Znl3TVhGTnhxdWgzdU1C?=
 =?utf-8?B?SEZOTmlHclFlWXE4aXd5RUdNU0hOZmNwcXNvaWFWNkVhMFFjdHVHSlQ0K3RL?=
 =?utf-8?B?WnExQklTYnJmNXZIbi8wZzJmeVd4Qzl3K3V2aTJXa0pzYjdmVWFNT0t2ckZI?=
 =?utf-8?B?QnJzUE9zMHJFN1BKcHdQQkxMaCtjbFBlMHV4eVFqdDlKdDE0TWpNVnFpQW9S?=
 =?utf-8?B?NFAxSXJiQllTMkhxdHdrSG9TRXJwSjdmWkdxK2Z1ZXBXeXA5dUtqMGprbXZ3?=
 =?utf-8?B?OFh1RUFGYks4bGtxMFNlTkJldllKdnpzd1phR2ZoRmQzU1RoalRCYTJPYVND?=
 =?utf-8?B?WFpITlFzUjZ3T283K2RTQiswUTZsKzNZU2NNanMrNTd6d1V1ckFzTXhhcy9z?=
 =?utf-8?B?MUthc0l5dTdDa2NYSnJoTFZZNDNKU2VrdGVvb2JYV1g1N1RPTkZJRjVtRWZI?=
 =?utf-8?B?TThVRXMrcE1hM0RXNE81YmMzaVpsUTFhMHMvY3ZLaG55R3ErSjNwU2d3RUJT?=
 =?utf-8?B?ZHB3RTdJMXNvT1BYQk1oM1RHcG42SkNCMkg4YWF6UmsyTFpwUUxQMWR1Qkdl?=
 =?utf-8?B?RGd3V2xBT014eTdpWDBpTFoxVXpqRkdONFRzNzJMTjhPNk1pZTdaOE9UTDFP?=
 =?utf-8?B?ZlhHcklISFc0ZHA0aUd0dXhvRWR6U2FyRkRweExJUWczbm83UUgxaWdBQjla?=
 =?utf-8?B?ck42U2pNbDdlTnhKalkrL0JmNGoxdUQzdWljYTAzZTl4Qk92UGhJRW1FUDA2?=
 =?utf-8?B?MDhmQ3NBQkcwaS91RzMwOUJ2R0dnWWFlN0dkOGoyNS9TdVJkajlxNHhwZ3lP?=
 =?utf-8?B?SE52UCtpNHE2RjRXWHNzbFVXUWdXTnVOR0kzR1JPb25HQ2w4cFRibkwyU0Zz?=
 =?utf-8?B?bVdOMVBmdjNQbzY1WmUyNjhEZDNiTDg1ZVRCWmUrWEM1dzM0aExqQ0VjV0hO?=
 =?utf-8?B?dWdyTEtscVU0cnZoYkJmVmRNdjdoSE5Kb3h1aWJOa0ZNOVBvL2MxaTNkdDBt?=
 =?utf-8?B?RjhGRHQzT0x0V3BtdHcrd1puV2plWXd3ei8ycXRuenFFaC9OUnVyWHNwejlQ?=
 =?utf-8?B?RW84czZiZXFHWko0Z0hydEtKV05hcWtobDkrd25rczBCK2FiODdrWlU4c1lU?=
 =?utf-8?B?YkVTVitaMUErNk1TS0ppdWZ3Z2tsTVpYUkdlZGdZOFlhNTlNckNRQm9uT3dF?=
 =?utf-8?B?Slg0NlB1aUJhazdELzN5YXo5cXJ0KzNTTTZHN0c2Wm8xeWhtOXZtODdqUDZn?=
 =?utf-8?B?NnZPdTl5U0h2OUFGNVVDbmErSHllM3ViNXZDb1VVZkV5cENBTEFBZGFsZmht?=
 =?utf-8?B?VXNaNWp0WXdIczRsRXJaRFRrR2ZUOGErNTdadnlEUStYNHRKZ1pmazIxWE93?=
 =?utf-8?B?ZUJ4KzN5NXpNeVUwZnRuSDlIY1hyY0VjaUdZUkFKRXBYNXBHbWMzVEQzeGRR?=
 =?utf-8?B?djNlVVdUK01tWTZzTHJBdzdSZzlYNGpkNGRSQnh1eTBRNEtvUE4wcmtMemJT?=
 =?utf-8?B?S2N2VmNpeGNqb2R1RnAvL2EreUVBREtlZDJRTldOZlpJak5rUDNoZXhJQUZW?=
 =?utf-8?B?UUxrNGdiZVJFS0tXYVcxdGZzUUJUZ0xnWHJsWW5TQkJEZ1BMb25aVUxXektP?=
 =?utf-8?B?RzFFdzA3KzZtS201eTE3V2FwU3R1V0tvUjFPQzQvelpKU29kaDJRYUJvK1R5?=
 =?utf-8?B?U0JXQmdORmJEeUlOK2JZVlNGK2ZrTk1oTXZ3Y3VESGV2L3dUeUh3YktUeWd6?=
 =?utf-8?B?QmdYQXMwa2xlWHpmSy9ReUdNZXA4K2FQMDlHMkVRNTY3OE5Xb0pGTU5qaGZT?=
 =?utf-8?B?U2ZxTkdhMURENHY2ZVpOZDVZWlcxb2lZeHcvQ2FxZm45QzQ1MGhDbG5WeU5B?=
 =?utf-8?B?b21mVTdSTFlWWkRrTGorSHFMNFRQWHFtMit5WnFDWitaTjBkclVZZHZwc3Ex?=
 =?utf-8?Q?8W75VZmkro1TvPbSqUQlYfWbdHeEBoN/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0xKaVNNZS9GNmxSTURxOHU3VC9PTzNuaTZvd25UcUU4UldNa3F6dGdoQVlV?=
 =?utf-8?B?NCtxUDNEK0FZNXlvcGJhOGVzQ2pwSHJOdnlHWW9tSi9yaDdxL2pLTXQ5R1F5?=
 =?utf-8?B?bVBac1NWdG85eXVVSzdUOHdESWk0YUNMazF0TE5xTThGaEZPYXVzZDdsOUJU?=
 =?utf-8?B?TG9PdzY4aWRBcEs5QThjVVlrek5SQm16UW41UzViRW5aMWxXL3JJLzFUNTlh?=
 =?utf-8?B?bVp2aXFmWVFxRTV6RmdZMGFhUW5DRTBNek90TDQ0Y0FJVUlvK3p4akpmeDA5?=
 =?utf-8?B?azBnSXo1OWw3TWh5RDVGTFZpRTJxckIrd2lSdDZ6Q0wvc1V1UUUrUGwrUHBQ?=
 =?utf-8?B?bktrYUd3Z3NqRlQwdDVPdSt0ZkhEMlZiTnplU0NPcUQ5RHVCS21iYkZmL1Rx?=
 =?utf-8?B?MlEwN3lpalVML29qWGZWN3hNdWN3UDFZTk0xNUFrWjZHMnUwSUJvNkNlZ0E2?=
 =?utf-8?B?cjRnK0xVR2ExWnVXR2NzUmJmSlJodW9wYXpJdTZ5YXFsTFE4YUVZRFZ3QmRt?=
 =?utf-8?B?RWs2VGR5Mmw1WXF5UllubnZpMmRtaWV1WVJkNkNneG1rWVJ1bGJmUjB1SVVQ?=
 =?utf-8?B?MUF5cGwwK3c5OC9VdXVXd21XTmZQM2x0NVBHSDR4RTNOcXV2bm91cHdaSDdo?=
 =?utf-8?B?VTdOb2gyUWwzZVhYczVBV2YwQ3ZxQUh1N1NScHl5ajlaOWVsTU1jOVlWRlp0?=
 =?utf-8?B?NUZNeXV0MDkvbVZFL0RiTWNKYWhpVUFocFF6ZGRaMWVmVUs3OXFjRGg0MGNw?=
 =?utf-8?B?cTZiTmMzTERtM0lsNkRURmlGMWNPMzZ1b1lDQzlnajlhSk4vZFNzTWdLbzhQ?=
 =?utf-8?B?TmFaTCtSWFRqVE5tcldLcWFLRXBMU3VtbGh2UWRoSVp1aFk3UHlGcjVreGtG?=
 =?utf-8?B?ZXpSaGlKMkVtQ0N4VjhKZlVLbDhXM2p5RG5Vbm5ycjR2dzUvV3d0Zng1UitD?=
 =?utf-8?B?bS9wUEhJaXlVaWFHcTErNVVjbk1lZUhTdC9Za1lhQVA0RUlxK1dXVG9iVVRs?=
 =?utf-8?B?bmlvU3Y1cXBzOVB3S1JqanNNMkY5aU5XNDhrWWd0Ykl3SXlkd0M2T0swUFhj?=
 =?utf-8?B?Vk5qTkN3WUVTbUMzdUVkMHV5dXdIdWVybitTNEdHWEJHNUVDSTlDSnlQMVhq?=
 =?utf-8?B?L1dGYlZJb2ZVT2dsQXlRb3h4SXA1OS9kajdMNHFJNGpTUVpaamtzYThFU2t1?=
 =?utf-8?B?LzhyRDRMRnVXb3lvUGkxTlpYaGFTYUc3UkNHZkVFTGRYeFBDNllNa29iMG5T?=
 =?utf-8?B?Q1hIdm85WElMRzNMT1BLVkhJNlRFMTU3eTQ4VDMvZzZXL01OMXd1V3g3UzZV?=
 =?utf-8?B?VExDSHpGcFV0ZVdKTzQzTVE1YWxnSFROZzZKQUhPckErOUZ4bXZ4dXFLZWl0?=
 =?utf-8?B?NXhWcVJTSlplOGF2SVZWUmNxdDAyeFRublpwODRMTjJYQzFLRDA5cnFwOFNO?=
 =?utf-8?B?dklZNHN4RzFOQVZjbDdKVXNZZzlUaEZwTDdrcEt5MWFBUHFLdUJtTGh1ZkpK?=
 =?utf-8?B?QzZBa1ZaRlhKdjYxK25MYlY2Zk5QSTFEVzZ3WTlmNDBtR0RuYjk2Y2FtaGh0?=
 =?utf-8?B?QzZGeksycHVPRC9KMU00dWIwdTdQSlRLV3o5WDkzTXNpM2RLZ3N4ZlFIZXRm?=
 =?utf-8?B?eEpKd1lEUE1oanF1dDRIcmk4NjhteDlCRnM2MkE4cmVFbnRiNndhcWVneDA3?=
 =?utf-8?B?bWZqcnNydjZ0TS95ZTUyWFdFSzhkbEhPNkFVSjE2cTM1VG15SjZSM0Z1Nm1y?=
 =?utf-8?B?ZHkxK0VIV0FucUNzZjJJK3dnajZJTFJVZ3JyejRaMFp1TXRXVnplYk9Yb210?=
 =?utf-8?B?dmVxMDVvclhmdU1xNDMwQWZ6S0E3ZzdHQmNmSUsySlJaMFpjalEwVVdsb1pl?=
 =?utf-8?B?cHpPdUNBdmpqMzFsVHlhcnlSOEhCY1cvcVRBUmRoeXpBMHZtMVAzeVJiSHdv?=
 =?utf-8?B?bnlwUXNOUXZrUDFab2pFczk3TG5XNDA2cXpzMVdodW5oMmRnaEZRWFJ5T0NH?=
 =?utf-8?B?d3RxZ1FlbTN4ZE5nZFBKSm1ySERyVnFNWGZERDVOakRpWG15V042NThjM0pR?=
 =?utf-8?B?RDhnMS9qaVA5YUNLdHp6N3o5VFNEWDZPbVZxb2txK3pvU1BxTjczblcvUmN4?=
 =?utf-8?B?VDBSd1l2VERzMnd0VzdxbUFtbTBGMkY5MU85TDdabVhodEMwZER0T3lUZ3ZL?=
 =?utf-8?Q?VdprYsTC+rktHNJfwAGnYvo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CA03BA6E787CD46B59492F2E9B144EC@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839a8086-5d98-4c64-06e5-08dd23dec0a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2024 05:49:37.8110 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jPUpAtC5OGvUyhDwWTaf2RlT98+NByxjD4xsXfByjb59IWtxHrw8yw4DjrcPogMlobxpVggfxyU2a25cSs3OO5QDk30AvL6fTbPhN4zct735UoKUxPpPRD7jUwHV5q8e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB9436
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

SGkgemhlbnpob25nLA0KDQoNCk9uIDIzLzEyLzIwMjQgMDY6NTAsIER1YW4sIFpoZW56aG9uZyB3
cm90ZToNCj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRz
IG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2Vu
ZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPiBIaSBDbGVtZW50
LA0KPg0KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+IEZyb206IENMRU1FTlQgTUFU
SElFVS0tRFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+PiBTdWJqZWN0
OiBbUEFUQ0ggdjEgMDQvMTldIGludGVsX2lvbW11OiBGaWxsIHRoZSBQQVNJRCBmaWVsZCB3aGVu
IGNyZWF0aW5nIGFuDQo+PiBJT01NVVRMQkVudHJ5DQo+Pg0KPj4gRnJvbTogQ2zDqW1lbnQgTWF0
aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+Pg0KPj4gUEFT
SUQgdmFsdWUgbXVzdCBiZSB1c2VkIGJ5IGRldmljZXMgYXMgYSBrZXkgKG9yIHBhcnQgb2YgYSBr
ZXkpDQo+PiB3aGVuIHBvcHVsYXRpbmcgdGhlaXIgQVRDIHdpdGggdGhlIElPVExCIGVudHJpZXMg
cmV0dXJuZWQgYnkgdGhlIElPTU1VLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1h
dGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPj4gLS0tDQo+
PiBody9pMzg2L2ludGVsX2lvbW11LmMgfCA5ICsrKysrKysrKw0KPj4gMSBmaWxlIGNoYW5nZWQs
IDkgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11
LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IGluZGV4IGFhZDEzMmUzNjcuLmE5MmVmOWZl
NzQgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTIxMTksNiArMjExOSw5IEBAIHN0YXRpYyBib29sIHZ0
ZF9kb19pb21tdV90cmFuc2xhdGUoVlREQWRkcmVzc1NwYWNlDQo+PiAqdnRkX2FzLCBQQ0lCdXMg
KmJ1cywNCj4+DQo+PiAgICAgIHZ0ZF9pb21tdV9sb2NrKHMpOw0KPj4NCj4+ICsgICAgLyogZmls
bCB0aGUgcGFzaWQgYmVmb3JlIGdldHRpbmcgcmlkMnBhc2lkICovDQo+PiArICAgIGVudHJ5LT5w
YXNpZCA9IHBhc2lkOw0KPiBTZWVtcyB1bm5lY2Vzc2FyeSBiZWNhdXNlIHZ0ZF9pb21tdV90cmFu
c2xhdGUoKSBhbHJlYWR5IGFzc2lnbmVkIGl0Lg0KDQpZb3UgYXJlIHJpZ2h0DQoNCj4NCj4+ICsN
Cj4+ICAgICAgY2NfZW50cnkgPSAmdnRkX2FzLT5jb250ZXh0X2NhY2hlX2VudHJ5Ow0KPj4NCj4+
ICAgICAgLyogVHJ5IHRvIGZldGNoIHB0ZSBmcm9tIElPVExCLCB3ZSBkb24ndCBuZWVkIFJJRDJQ
QVNJRCBsb2dpYyAqLw0KPj4gQEAgLTIyNjAsNiArMjI2Myw3IEBAIG91dDoNCj4+ICAgICAgZW50
cnktPnRyYW5zbGF0ZWRfYWRkciA9IHZ0ZF9nZXRfcHRlX2FkZHIocHRlLCBzLT5hd19iaXRzKSAm
IHBhZ2VfbWFzazsNCj4+ICAgICAgZW50cnktPmFkZHJfbWFzayA9IH5wYWdlX21hc2s7DQo+PiAg
ICAgIGVudHJ5LT5wZXJtID0gYWNjZXNzX2ZsYWdzOw0KPj4gKyAgICAvKiBwYXNpZCBhbHJlYWR5
IHNldCAqLw0KPj4gICAgICByZXR1cm4gdHJ1ZTsNCj4+DQo+PiBlcnJvcjoNCj4+IEBAIC0yMjY4
LDYgKzIyNzIsNyBAQCBlcnJvcjoNCj4+ICAgICAgZW50cnktPnRyYW5zbGF0ZWRfYWRkciA9IDA7
DQo+PiAgICAgIGVudHJ5LT5hZGRyX21hc2sgPSAwOw0KPj4gICAgICBlbnRyeS0+cGVybSA9IElP
TU1VX05PTkU7DQo+PiArICAgIGVudHJ5LT5wYXNpZCA9IFBDSV9OT19QQVNJRDsNCj4gU2hvdWxk
bid0IHdlIGtlZXAgb3JpZ2luYWwgcGFzaWQgdmFsdWU/DQoNCndpbGwgZG8NCg0KPg0KPj4gICAg
ICByZXR1cm4gZmFsc2U7DQo+PiB9DQo+Pg0KPj4gQEAgLTI1MTEsNiArMjUxNiw3IEBAIHN0YXRp
YyB2b2lkDQo+PiB2dGRfaW90bGJfcGFnZV9pbnZhbGlkYXRlX25vdGlmeShJbnRlbElPTU1VU3Rh
dGUgKnMsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgLnRyYW5zbGF0ZWRfYWRkciA9IDAs
DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgLmFkZHJfbWFzayA9IHNpemUgLSAxLA0KPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgIC5wZXJtID0gSU9NTVVfTk9ORSwNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAucGFzaWQgPSBwYXNpZCwNCj4gU2hvdWxkbid0IHdlIGFzc2lnbiB2
dGRfZGV2X2FzLT5wYXNpZD8NCg0Kd2lsbCBkbw0KDQo+DQo+PiAgICAgICAgICAgICAgICAgICAg
ICB9LA0KPj4gICAgICAgICAgICAgICAgICB9Ow0KPj4gICAgICAgICAgICAgICAgICBtZW1vcnlf
cmVnaW9uX25vdGlmeV9pb21tdSgmdnRkX2FzLT5pb21tdSwgMCwgZXZlbnQpOw0KPj4gQEAgLTMw
OTgsNiArMzEwNCw3IEBAIHN0YXRpYyB2b2lkIGRvX2ludmFsaWRhdGVfZGV2aWNlX3RsYihWVERB
ZGRyZXNzU3BhY2UNCj4+ICp2dGRfZGV2X2FzLA0KPj4gICAgICBldmVudC5lbnRyeS5pb3ZhID0g
YWRkcjsNCj4+ICAgICAgZXZlbnQuZW50cnkucGVybSA9IElPTU1VX05PTkU7DQo+PiAgICAgIGV2
ZW50LmVudHJ5LnRyYW5zbGF0ZWRfYWRkciA9IDA7DQo+PiArICAgIGV2ZW50LmVudHJ5LnBhc2lk
ID0gdnRkX2Rldl9hcy0+cGFzaWQ7DQo+PiAgICAgIG1lbW9yeV9yZWdpb25fbm90aWZ5X2lvbW11
KCZ2dGRfZGV2X2FzLT5pb21tdSwgMCwgZXZlbnQpOw0KPj4gfQ0KPj4NCj4+IEBAIC0zNjgwLDYg
KzM2ODcsNyBAQCBzdGF0aWMgSU9NTVVUTEJFbnRyeQ0KPj4gdnRkX2lvbW11X3RyYW5zbGF0ZShJ
T01NVU1lbW9yeVJlZ2lvbiAqaW9tbXUsIGh3YWRkciBhZGRyLA0KPj4gICAgICBJT01NVVRMQkVu
dHJ5IGlvdGxiID0gew0KPj4gICAgICAgICAgLyogV2UnbGwgZmlsbCBpbiB0aGUgcmVzdCBsYXRl
ci4gKi8NCj4+ICAgICAgICAgIC50YXJnZXRfYXMgPSAmYWRkcmVzc19zcGFjZV9tZW1vcnksDQo+
PiArICAgICAgICAucGFzaWQgPSB2dGRfYXMtPnBhc2lkLA0KPj4gICAgICB9Ow0KPj4gICAgICBi
b29sIHN1Y2Nlc3M7DQo+Pg0KPj4gQEAgLTM2OTIsNiArMzcwMCw3IEBAIHN0YXRpYyBJT01NVVRM
QkVudHJ5DQo+PiB2dGRfaW9tbXVfdHJhbnNsYXRlKElPTU1VTWVtb3J5UmVnaW9uICppb21tdSwg
aHdhZGRyIGFkZHIsDQo+PiAgICAgICAgICBpb3RsYi50cmFuc2xhdGVkX2FkZHIgPSBhZGRyICYg
VlREX1BBR0VfTUFTS180SzsNCj4+ICAgICAgICAgIGlvdGxiLmFkZHJfbWFzayA9IH5WVERfUEFH
RV9NQVNLXzRLOw0KPj4gICAgICAgICAgaW90bGIucGVybSA9IElPTU1VX1JXOw0KPj4gKyAgICAg
ICAgaW90bGIucGFzaWQgPSBQQ0lfTk9fUEFTSUQ7DQo+IFNob3VsZG4ndCB3ZSBrZWVwIGVhcmxp
ZXIgYXNzaWduZWQgcGFzaWQgdmFsdWUgYXMgYWJvdmU/DQoNCndpbGwgZG8NCg0KDQo+DQo+IFRo
YW5rcw0KPiBaaGVuemhvbmcNCg0KSSdsbCB3YWl0IGZvciBtb3JlIHJldmlld3MgYmVmb3JlIHNl
bmRpbmcgYSB2Mg0KDQpUaGFua3MNCmNtZA0KDQo=

