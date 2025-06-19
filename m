Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39EB7C7115E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 08:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSAie-0000lT-9K; Thu, 19 Jun 2025 04:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1uSAib-0000l1-33; Thu, 19 Jun 2025 04:33:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1uSAiY-0008RO-2N; Thu, 19 Jun 2025 04:33:56 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J0hKcX022644;
 Thu, 19 Jun 2025 08:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2025-04-25; bh=iuX8ycbGqWEcoUvCIT
 0PRkqOi+qcoT9xWqd3Ql+96NY=; b=oYmHm6EjuT2Ck5SJ1LMI+mnK6mXJSk2qZG
 e8GvP5C0Ifz0RDztqcXWCckYmG98o2hlgb6Ogwe9eSlfevTGrk2BrxR8NCZvabFI
 cfU1lunRYJmNralruHkE2nUywnqAuoWXyR3DZBFhw4BS6ebheGZmNzP6aevePKOH
 7AHuO9bFo9JGp9Q8vVAHophu/1fgqxXRrh0N6pJVHo6v6EQnOBUNERIppCnLx9I6
 FkGPWFTG5xeDeEK3ALM0+mBuzrA789Eu5MrDYVb7hCNF6ZEqMk8yQTF65Th/G2oU
 tl4202OhkfqFsAzQIQvg8qURmxt1drXbqb7laxmLgUOchVl01+AQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 478yv59e78-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Jun 2025 08:33:43 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55J7hKtd026041; Thu, 19 Jun 2025 08:33:43 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013025.outbound.protection.outlook.com
 [40.107.201.25])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 478yhhwxev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Jun 2025 08:33:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBwa8AE1AnXvJG9HE54bFgiTFwswJzbUn9Y3PG2mZCkBeSwYELFfKUJBMfYL+JCb+yDERExpqOEFPAgdnJQwKRK5htw1xAYygb/XbqW563qeEZrAdiCHf6i7Jf8yLbQ8UrKpLkzi81j0FgKrLjN3pJLZiabzryL2DDx93AXsSywqyc2UKmNHFIKf6rBlYWjHZtIiRu8FP96cq2emsjoUATK/uLBU/jAt7KDWyJWCXdLtlN6jXqo0V3dtF3chfSMcTUhXw7qbbPT4dHu267VSZVckVS+9XmDS8E1Ay7yNnxaSUGDocxvuOxbIS8wzQQ5tfI7UfB67rEVhxJ2Tsx0U+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iuX8ycbGqWEcoUvCIT0PRkqOi+qcoT9xWqd3Ql+96NY=;
 b=ldp70pm6W50SSyZ6pIaxlilIaBLgpbOYxTmjIUr2HeN2y5Hs7GP4UFpqQEosVCdMKZDhMsWUg0xfeGEDWreUskWRu5ZbbHbswcjiOo2HUa8XCqr64YRrYb3Zgv56WsZfMPHr1nSUt+rz/KPfbGUbWnchssazk1aj6P0gwFyNdCoaXZ8wg4uf1TSfCuFVfxzp+pQL/nor3xOBMYwWhPOXbK35kxY/V5IBYo/Z6t/Bsml2XpVb2c59ph3lAxQJr7uMi4LF7aCoKHw0z4HevagjKbqi8lzaqrwoEfmq4eOXkDWWxXHmAY4EQgfL7lBLYRizBCBf0XU1GJzEDSNuvgNF1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuX8ycbGqWEcoUvCIT0PRkqOi+qcoT9xWqd3Ql+96NY=;
 b=P4g8HhueMZzfG3t2M/i1/WlxkKftKyzs0QyhJj0ja/4DUfSPJ2ArwHXx6cyXo/g7I4zDA2Vs/TbO2cje3k7u6I3z+P0Ft1r4Ycuvo+WxcX6srxneHv4YYfP30i4rGnzORkhTxswEZeks5k6yCQiD3fD3XPxTPKabnVQrl/dlUS0=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by DS4PPF742908B79.namprd10.prod.outlook.com (2603:10b6:f:fc00::d2b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Thu, 19 Jun
 2025 08:33:39 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%7]) with mapi id 15.20.8857.019; Thu, 19 Jun 2025
 08:33:39 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Marc Zyngier
 <maz@kernel.org>
CC: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "gkulkarni@amperecomputing.com" <gkulkarni@amperecomputing.com>,
 "gankulkarni@os.amperecomputing.com" <gankulkarni@os.amperecomputing.com>
Subject: Re: [PATCH v5 0/5] ARM Nested Virt Support
Thread-Topic: [PATCH v5 0/5] ARM Nested Virt Support
Thread-Index: AQHbztA2f3Tkb/6RVECgRowZ7mB7d7PmF3GAgCQwr4CAAAOp0g==
Date: Thu, 19 Jun 2025 08:33:39 +0000
Message-ID: <PH0PR10MB543377F7B913909029199966917DA@PH0PR10MB5433.namprd10.prod.outlook.com>
References: <20250527062534.1186004-1-eric.auger@redhat.com>
 <86msayec3a.wl-maz@kernel.org>
 <5813ae16-c898-4620-9622-3c12e8a7b22e@redhat.com>
In-Reply-To: <5813ae16-c898-4620-9622-3c12e8a7b22e@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|DS4PPF742908B79:EE_
x-ms-office365-filtering-correlation-id: 1688695e-c577-4955-fc22-08ddaf0bfdf1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?uZU6z1o52IDTlW75IauJ7mrv7vTRK2wifGphNhvh3Zw8UT9o17q1u6TWsV?=
 =?iso-8859-1?Q?bT6T6L8/hi82imYQEk/eHNhfI9xlHwk540V2vuGlh3Twi6KfcFz9vqscE9?=
 =?iso-8859-1?Q?vLRmZcS3rsG9rLN0DelvBl3qDd3amtKnhkbSxUB52DdJFs514MjBhRct7r?=
 =?iso-8859-1?Q?VHerWHeEnBnpedtRIs+oZ+JovOflHBKMie9/QYsrigvpmqNmU4V7N0CKY8?=
 =?iso-8859-1?Q?229Kv44CNwAZg8m0wmRmybqYTxa8QtFAqJqsQeCHJfW2Duh8DEs5LY+VIO?=
 =?iso-8859-1?Q?finqbSPI+fWl54NJRvbkkIKUotod65VGGE+GXa0dpYlUV9tBGRSHJRrHP6?=
 =?iso-8859-1?Q?7eEnwfYHkJ4Oo1l84lxGBejzIt5apP20PU7xjvw2KK5qfY6j8Mwl0h5OAl?=
 =?iso-8859-1?Q?1/9KlTmraH2pnqMKguwmS13J5eWmnmZJYzAGBtiZtO+1A5PpmJEydnbztX?=
 =?iso-8859-1?Q?11geQWrcOb3z9jiAYuZoD5aCK4MypJV6nsA18JWTGOgcfMLvybJ+X0oYcS?=
 =?iso-8859-1?Q?pjUfYK4PeB9gQ4AuG5kPGZaIDu7jhkBBRPbN1q+LQSHP8ptWOQSAiA1Bwk?=
 =?iso-8859-1?Q?pJ6Q9uTSJQ6Kj87tr1y2wXancHE/AKOrwk0K514pch7sNRZYwbFvJpzZZv?=
 =?iso-8859-1?Q?9vAd5/jA/yYdTffzOCrbbeBfu5dhg/IjkfHycWTyEaRikxzh3Xvk5D5/rU?=
 =?iso-8859-1?Q?fQTA26GElHQxz6VW0qXYlyWPby2jVRS/tU4bTpxcmvszRf0rLVw/meU7fF?=
 =?iso-8859-1?Q?i6wwXGILmd4ZoXswr3Klw0DZFjOTtvOzGWNH+mxFPGS/QwPI303anyM+Ya?=
 =?iso-8859-1?Q?wenZH+tdR8A2aOWn/oi+VUFWyOyhBQfuEQj85m5/ulEyl5TUlIty+H5wJU?=
 =?iso-8859-1?Q?Czz1EkUU2s7d5qMAwTn1bydQp2C3g4c5hAkxLzJrRl2Wz+6buuy/LET4IW?=
 =?iso-8859-1?Q?7k0g4ZgBJf1NY6gr4xCmV+OjLuIWnDeat3NjhshSQJo3F+zn0eTBKQjuKN?=
 =?iso-8859-1?Q?07dZ0O3ZoPfOX8t+TVeDtAWA9k3CWTEqgSLcUO+XQSDM7cRKApnAmAVUUX?=
 =?iso-8859-1?Q?cNbuVr07puQy2JzEzhvnvRxo64qDmUJmG7McMWgx5DWfauLDNcSuvHSiPP?=
 =?iso-8859-1?Q?NLPv2EGwrox2vtMBQ+t890qwcJoewe8B+4270JnOv1smK9EwRQVqmw0SRT?=
 =?iso-8859-1?Q?UF3Knw8Db1hJx7NFRnbXi+Vrrir/IrrWPvtbNhpQrYyMh2yaimUNX+HvOd?=
 =?iso-8859-1?Q?c4I5ddywsmx1zDFtXbymGYcf2Z/CQjDBh/b7SBx8HZO0t76q41S/X70/oC?=
 =?iso-8859-1?Q?ZPc4tyKTv5/pH7BP8oG/Rt+3OE+8hLQxL0lrA3CNVA6v9QkTyWwhdzFxKL?=
 =?iso-8859-1?Q?sZARZx2WlVHUl5USpRNNMFSECV/LitibFXOLupEyFeQu2lLKBVlMjAhbPc?=
 =?iso-8859-1?Q?KclRCzqB2W87fFv3+gtb11wpV1NBFlmF0lJuWPJDd+BCPFIs5Wen6oI0Oq?=
 =?iso-8859-1?Q?AVFQE0zNguv9inm8Bjk77iRPbYq0J9y65LgmSnhCkhFNeDoUNJbv0Y2tFq?=
 =?iso-8859-1?Q?JoJrdB0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5433.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?inqDXtfY3gfY4kBw5vQLT9XQSLmgI5Irvwuzv8V3BXXqzWg92B06vMfYg9?=
 =?iso-8859-1?Q?H5Tl8OSgoBYBDbI41YTJOrgKinUB7KN5xy1Vo9XquNwaIjRJN8TtOZEuok?=
 =?iso-8859-1?Q?enPBlUV3G2LmY0MUMW66vtkSqT9lZx60YHEsCaB5wzz25fSHl7F8BtwoBO?=
 =?iso-8859-1?Q?jlYZCKRAwbva2ATpZTAwGDn6CL55tlFjnYfJyC+/j+6fdx0jZu1DnifeMA?=
 =?iso-8859-1?Q?hJJoUwlishIUYXf+wu7jE9v8pB6jZe04N0kp//6iuNQqrGIe5olSxH+dwc?=
 =?iso-8859-1?Q?3idykUy1h/Ct0AB8nHoZ12C+yXI8Zr3JENbUc3SfYP5Uozt+nSDSzwJ/5q?=
 =?iso-8859-1?Q?Knf1JFcyX5qH84Q8mUJhMtuidUkZCEN00ynii385nb33MHq2fOBZWw5jhf?=
 =?iso-8859-1?Q?KuVeD7oXu32xuyk5m0PKWMhJ08RG3gG+5jwvWaE7BD1+MQl4Llx5/ztxRY?=
 =?iso-8859-1?Q?Er4C8mBPXoRlx5oVgyR8JuoK6R+4FMdJ4jlaHyYLy+/o6KQwsaAz4W1Wln?=
 =?iso-8859-1?Q?GHh+jToeW4OwJN40YcNbwSK2IzqGABKc9mxKPvtptbRHSm8celXAvfCzFG?=
 =?iso-8859-1?Q?jqbP8RFmI3/FU6fEK0o9ArB3ZSJezomn3/4BgqSLGqkcAKA5sqWO1fQHFV?=
 =?iso-8859-1?Q?nAs/OWw80So8T7RJsPinvHOvrVazfFEWFCx4laQhJLLmDoCvpe4Ni0qbj1?=
 =?iso-8859-1?Q?JPDKhcvKnSPgM6dV1luahY/KSFUPv+siCt/EhOoaSCnFgx48U0wC7eR6yu?=
 =?iso-8859-1?Q?g+DAtEceGqJNsI+v1D3trV8fQmR9H8EBjemtcDYUY8KIfrCJLquaINm/DA?=
 =?iso-8859-1?Q?WRh6kYkkdZNC1LdF4MNvVxeLJBXz/Wey7+P3o+DPTHuSxhXVO1R41SOhpU?=
 =?iso-8859-1?Q?8s+SHGVljFCoVQmDtbcsV2+RO13Gca/KiiituGw2R2ePgt2bjw8umdV41Q?=
 =?iso-8859-1?Q?m+qtjmscOIEHDq++6gi/jSAJ4XVTnDGZN+4RubEteKALBU4z3BAYPQJJTr?=
 =?iso-8859-1?Q?Mbv3tR2Q73x6P6OZwwyIT07/tn/1xSJjqnoda+trYaK2yl4FM4PET10CXR?=
 =?iso-8859-1?Q?S1nwG1OlBKpOCFVlBAkbS2p89ITTbcQWZL88IfbhFtNkVCevgfyukGCZm1?=
 =?iso-8859-1?Q?bC0jRgfkfym60q/h7XhVDzmJjlJBQlCL8iHygUyuo0ymB+qvatHL+f6Rj/?=
 =?iso-8859-1?Q?luDsdATc4vrjtv6GpiiK4PxaLb15A9kYWj3twkbgCIS2NkZv5/UczCAM27?=
 =?iso-8859-1?Q?Oi0HW7Pke3TVfBiqy0HcU1KqW/YNH7cCF8YksXLyUkqnvYCkZ7xrETjS6Z?=
 =?iso-8859-1?Q?Qjz74LNn5z5/yu1QVnW6syRjqensQmC0dITjPztPVkO8kkWmLodM2s23/0?=
 =?iso-8859-1?Q?H0mEyRVD9CunZOrdL3nd2THBoJ8wcd2FxaAGBv/XvIVw5209mF0G3vttFL?=
 =?iso-8859-1?Q?194w8UDuzQEXUsvIoTK1vN2SnMzn88vNxhrUr+lp/QLp8alAXgNVZwwl9w?=
 =?iso-8859-1?Q?rjLFe6lMtvWjNQHjeZes09HeVETKWmJozjddpA1yaKAiOolKNhL8BeJNv4?=
 =?iso-8859-1?Q?+nTWQm1fA3uroPAfqra5oqXuVGnz6MwVdhrRXF/4c0cvZzz697AAn8HWWQ?=
 =?iso-8859-1?Q?h+GuZjlEd+xuJ3Y9g8PPaORSJiDoETK0gXRRM4ubXzl+wyO83z5QACyw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH0PR10MB543377F7B913909029199966917DAPH0PR10MB5433namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 84u4DkJjX9oQR+au778LX2rfq7FZA0AsqFhxnMeE8lDuoxRiZWy9ErK5Nub86Wpv8EgvQzHrMWf9+Ni67B4ktDEc0CwW4lu9DliQYNipogwqI8vVc1RrSUgtkqzj2it9fKlbgg2nzpUHELzjilMJMSBM5T5xefMr3kxA0XA1T1uDA+Y+q3HUCcq1pFYg81hCiFn5Sl9IcEusAVviC0E3/M7KZVSgNxPma6XFvqKQwNx9Y438Rumk7nufBsRzrzkNej0B94idX3Z2lvFedPDDtWwEx8oG+BMIn4UMTCYfGLOWOl+ecpudh/INCwCrRpsLWfde27xCXuMpzDvmY9ahEZgpFB1aPwluhKhc539FPThMnSbuRejoA3gVg30F9Obd6AjyN1pN6e5HOFxpHoJFnaa7jU/Noz20JmFlfXDSK1WOpQNjAuDHHkRD0EcoOQAfKKs2Hg5Zfw/HzMmjzrPDRbP/tt6wog7RdPphCMP/VMay2eNd+7sezQsTNyZvTFXHWktWt0UYXs3eCmXJ6EUger6kbvLaieNl1RMKR1R8yFEw3nEEXaEz2iZ8TQF4/MaXCotoFX3ia9vWF20A8fyKB3EEOCX/dROQ24OdBD2XW+w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1688695e-c577-4955-fc22-08ddaf0bfdf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 08:33:39.6005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9zXQXayqjKw5hzWUd8ND/8O3wOZvIbogXtzD7GncN6ib860ShcJZO2Kswb49ZUjiD44//5KsxOVkMpWHfhQogg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF742908B79
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_03,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506190072
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDA3MiBTYWx0ZWRfXwTNu/jzNcc3U
 NiN5bjPdfi2bYqRybHwfQvtPqs2bmmSjA27yHOOL+qLleKeoxmWmC5DEogREfsiCdQfFB7ilAwn
 FIigeh+bi5ls60xIDmKGlZynVmb8UCFN2OzYAyIzYZ70GNp6TjRo6ekbcNuVXHlgOH4oyIgQ1J2
 VkT/R3+9qAC2C98XJue3R7QRLu7plTK/03xK6akLFXdyHbBBvC0AO+8qN1obdX5ogWpo2XoxvCk
 9xRYB/oAHvpQSuuVLvpEPRIzOCDAsBzzkMkP+Y5DwX3wc6PPrbqa7faF0sCGbDrR6J2dBaMRMOV
 fy5rtyiitMmVEuv1Fl1Ns11glh2hjloxNAax4TwoQp/q+iYwh0tydggdHtTzjTgzKUHSJ+hw6Kj
 jVPfwjYOw1/wf+igVW1EQsx42w2A4RoUB/En4No6BIKacOijRL/gjVtOw+wRx2FLuwukCEgh
X-Proofpoint-GUID: rnRJ9RcwFAa9RbQosJ073-GyGt3yYlj7
X-Proofpoint-ORIG-GUID: rnRJ9RcwFAa9RbQosJ073-GyGt3yYlj7
X-Authority-Analysis: v=2.4 cv=W9c4VQWk c=1 sm=1 tr=0 ts=6853cb67 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=yPCof4ZbAAAA:8
 a=KKAkSRfTAAAA:8 a=vzhER2c_AAAA:8 a=9fjt9Anoo4Szz2tk6DIA:9 a=wPNLvfGTeEIA:10
 a=XSHmh91Bc4dkiI52WEEA:9
 a=rRsnvsVERtt1ZG5Q:21 a=_W_S_7VecoQA:10 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22 a=0YTRHmU2iG2pZC6F1fw2:22 cc=ntf awl=host:13207
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--_000_PH0PR10MB543377F7B913909029199966917DAPH0PR10MB5433namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



________________________________
De: Eric Auger <eric.auger@redhat.com>
Enviado: quinta-feira, junho 19, 2025 8:19:47 da manh=E3
Para: Marc Zyngier <maz@kernel.org>
Cc: eric.auger.pro@gmail.com <eric.auger.pro@gmail.com>; qemu-devel@nongnu.=
org <qemu-devel@nongnu.org>; qemu-arm@nongnu.org <qemu-arm@nongnu.org>; Mig=
uel Luis <miguel.luis@oracle.com>; peter.maydell@linaro.org <peter.maydell@=
linaro.org>; richard.henderson@linaro.org <richard.henderson@linaro.org>; g=
kulkarni@amperecomputing.com <gkulkarni@amperecomputing.com>; gankulkarni@o=
s.amperecomputing.com <gankulkarni@os.amperecomputing.com>
Assunto: Re: [PATCH v5 0/5] ARM Nested Virt Support

Hi Marc, Miguel,

On 5/27/25 9:39 AM, Marc Zyngier wrote:
> Hi Eric,
>
> On Tue, 27 May 2025 07:24:32 +0100,
> Eric Auger <eric.auger@redhat.com> wrote:
>> Now that ARM nested virt has landed in kvm/next, let's turn the series
>> into a PATCH series. The linux header update was made against kvm/next.
>>
>> For gaining virt functionality in KVM accelerated L1, The host needs to
>> be booted with "kvm-arm.mode=3Dnested" option and qemu needs to be invok=
ed
>> with: -machine virt,virtualization=3Don.
> Thanks for respinning this series.
>
> Do you have any plan to support the non-VHE version of the NV support
> (as advertised by KVM_CAP_ARM_EL2_E2H0)? It would allow running lesser
> hypervisors (such as *cough* Xen *cough*), which completely rely on
> HCR_EL2.E2H being 0?
While respinning I'd rather not support KVM_ARM_VCPU_HAS_EL2_E2H0 in
next respin. The code is mostly reviewed and I would rather add support
for this in a separate series. It will most probably rely on a change of
the virtualization property type to support a "restricted" enum value.

Ack!
Thank you.

Miguel


Thanks

Eric
>
>
> Thanks,
>
>        M.
>



--_000_PH0PR10MB543377F7B913909029199966917DAPH0PR10MB5433namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
<div id=3D"ms-outlook-mobile-body-separator-line" dir=3D"auto"></div>
<div id=3D"ms-outlook-mobile-signature" style=3D"font-family: Aptos, Aptos_=
MSFontService, -apple-system, Roboto, Arial, Helvetica, sans-serif; font-si=
ze: 12pt;" dir=3D"auto">
</div>
<div dir=3D"auto" id=3D"mail-editor-reference-message-container"><br>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" style=3D"font-size: 11pt;" dir=3D"auto"><b>De:</b=
>&nbsp;Eric Auger &lt;eric.auger@redhat.com&gt;<br>
<b>Enviado:</b>&nbsp;quinta-feira, junho 19, 2025 8:19:47 da manh=E3<br>
<b>Para:</b>&nbsp;Marc Zyngier &lt;maz@kernel.org&gt;<br>
<b>Cc:</b>&nbsp;eric.auger.pro@gmail.com &lt;eric.auger.pro@gmail.com&gt;; =
qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; qemu-arm@nongnu.org &l=
t;qemu-arm@nongnu.org&gt;; Miguel Luis &lt;miguel.luis@oracle.com&gt;; pete=
r.maydell@linaro.org &lt;peter.maydell@linaro.org&gt;; richard.henderson@li=
naro.org
 &lt;richard.henderson@linaro.org&gt;; gkulkarni@amperecomputing.com &lt;gk=
ulkarni@amperecomputing.com&gt;; gankulkarni@os.amperecomputing.com &lt;gan=
kulkarni@os.amperecomputing.com&gt;<br>
<b>Assunto:</b>&nbsp;Re: [PATCH v5 0/5] ARM Nested Virt Support<br>
</div>
<br>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<div dir=3D"auto" class=3D"PlainText" style=3D"font-size: 11pt;">Hi Marc, M=
iguel,<br>
<br>
On 5/27/25 9:39 AM, Marc Zyngier wrote:<br>
&gt; Hi Eric,<br>
&gt;<br>
&gt; On Tue, 27 May 2025 07:24:32 +0100,<br>
&gt; Eric Auger &lt;eric.auger@redhat.com&gt; wrote:<br>
&gt;&gt; Now that ARM nested virt has landed in kvm/next, let's turn the se=
ries<br>
&gt;&gt; into a PATCH series. The linux header update was made against kvm/=
next.<br>
&gt;&gt;<br>
&gt;&gt; For gaining virt functionality in KVM accelerated L1, The host nee=
ds to<br>
&gt;&gt; be booted with &quot;kvm-arm.mode=3Dnested&quot; option and qemu n=
eeds to be invoked<br>
&gt;&gt; with: -machine virt,virtualization=3Don.<br>
&gt; Thanks for respinning this series.<br>
&gt;<br>
&gt; Do you have any plan to support the non-VHE version of the NV support<=
br>
&gt; (as advertised by KVM_CAP_ARM_EL2_E2H0)? It would allow running lesser=
<br>
&gt; hypervisors (such as *cough* Xen *cough*), which completely rely on<br=
>
&gt; HCR_EL2.E2H being 0?<br>
While respinning I'd rather not support KVM_ARM_VCPU_HAS_EL2_E2H0 in<br>
next respin. The code is mostly reviewed and I would rather add support<br>
for this in a separate series. It will most probably rely on a change of<br=
>
the virtualization property type to support a &quot;restricted&quot; enum v=
alue.<br>
<br>
Ack!</div>
<div dir=3D"auto" class=3D"PlainText" style=3D"font-size: 11pt;">Thank you.=
</div>
<div dir=3D"auto" class=3D"PlainText" style=3D"font-size: 11pt;"><br>
</div>
<div dir=3D"auto" class=3D"PlainText" style=3D"font-size: 11pt;">Miguel&nbs=
p;<br>
<br>
<br>
Thanks<br>
<br>
Eric<br>
&gt;<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; M.<br>
&gt;<br>
<br>
</div>
<br>
</div>
</body>
</html>

--_000_PH0PR10MB543377F7B913909029199966917DAPH0PR10MB5433namp_--

