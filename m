Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAADECD6D6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 18:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqFBI-00063a-BZ; Wed, 11 Feb 2026 13:43:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqFBE-00063E-66; Wed, 11 Feb 2026 13:43:17 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqFBC-0003jS-Fl; Wed, 11 Feb 2026 13:43:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNAIxNFbVogBI4jnRZT40rv9EBhiF1NWfkkoUicfJFXB3RW0UXkM6I6Jhate1a0nA0923S9RwfcAOkWf39fpiB/cUTP7qXcEXvl8snhP0MFiZFfTGQTugFbb4nEmfh8dHbxQReMXrxmNZqHJALDTYmkXKhZVy1nEuSpgW/m2NJhkSEFqB9lXRIH03n2PyddSgouxkSUREyCjZsqWI/rAaxfcTPoZdyKD0W/7MUMpiAIt+GJG5VAXFeynbGCuQ9z8eo0DiBZSVMBlUZxraRYZio2kr+SwqqmMbqm/ddZV5MpSvHSB31e/m/k/fcaOmf5gYhaqSTshDx4gkFWa3s5C4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZLV9De6z3Ep8Apb4PaVEXM/Zuw+QjYIx68r/GIhgmk=;
 b=OTqz4rU8W+WMbfRegIyCfSJrQ2JUW9bHGvc7APiSC3LeTFlXA1B3DnENETrKn4n4f4trT58ejKO52HWXzVPUp8JfVCLdGjXYYT1QMNEUM3MdWDPAo+xQRolQm8eNGXzRpqA0x3LYA18qiCO1qfceE+BKfcOXh8nQtgEcXR1oVaUgaPsh3qaosq9904Zgr7LBjwHdGU/L38OCsAonMjF/U5dIFq4/5+jTIaJy0wf4eip4wiBYSGRScJwwYtUaEf/MzQkPhLSc9PNtdC5poh+YNdPjf/f9hLwjWD5LJGu6H12vNo+XgM21mJJNKz+b8v57rYoshFC9qWz9KwdqKqWTTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZLV9De6z3Ep8Apb4PaVEXM/Zuw+QjYIx68r/GIhgmk=;
 b=m8VSg52449bJYdUZGq9/2AzxNnoV8bp+sE+OInm8h9VZwG0RDshokIqPbF07rPDBlb9O8M84H9DnE5hRhHTHxk143T6kmVjktAkLSDhmy9erd3Oj584ndT8X/Xras5cD2o0dURt3JCN/Va9EXqDpGKzHgWUlWo9Py+D3tF3XiFQRy+2d3KCTG3jUy8xDnNrQ14D20cv1ZtC55jQcDP3qB+CZtPZiQAO0lh0Y65YXGZIlYQZRu0Hs34ZsJdFVuo2wYpkpPEsipni7s+SfIOCbcUEdPaQ7V8+8lBhpMKdswUdfQH255p40bWsAyN9iby6hfBq+VI1cK49NSnVz5vH+ZA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH3PR12MB8852.namprd12.prod.outlook.com (2603:10b6:610:17d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 18:43:05 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 18:43:04 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v5 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Thread-Topic: [PATCH v5 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Thread-Index: AQHcmzFk1Etk+2u8DkWzxKPQ5vkZXLV9zEoAgAAB5gCAAALtAIAAA6kQ
Date: Wed, 11 Feb 2026 18:43:04 +0000
Message-ID: <CH3PR12MB754855AE35A087B900B0C311AB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260211083415.133534-1-skolothumtho@nvidia.com>
 <20260211083415.133534-4-skolothumtho@nvidia.com>
 <aYzFeMh1szhJlJJk@Asurada-Nvidia>
 <e66e82d6-0953-49f0-9d84-bf2776e8f3ce@redhat.com>
 <aYzJhEFg/zxtrJ8z@Asurada-Nvidia>
In-Reply-To: <aYzJhEFg/zxtrJ8z@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CH3PR12MB8852:EE_
x-ms-office365-filtering-correlation-id: e512f210-c20f-4109-591a-08de699d6457
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?I/I9AyUu/nm9zw/HhxDuvddNBZy51qSsGPlG8NF42ZI1Z/ftvc3zWfjp/OTB?=
 =?us-ascii?Q?fCrCn1Ljl4Q4UR1zeMxUj/6eyqL0q2L05sH32U8oXk7LiNbbPi4e6egG8Z5o?=
 =?us-ascii?Q?MHTWQVJxmbTr7KVlmqPPmXTAIYK/7I7M9I1OJe0E8V8fpokGiktY761/WsPC?=
 =?us-ascii?Q?QRAIHSYOrycBr8jYz2AGQq0GQVbR0x9RB/3lg5O2tR0Bva3UBbmW0+132JMH?=
 =?us-ascii?Q?i91HzYCwQX7QCAgepXv3miy4+eCNawnMpX9H4ra0OT7lS/BgktP5glM/aLvz?=
 =?us-ascii?Q?X10le8m6scwlVQSG3nVeftD8lkWZio/Iy+5J0Ag9+fZzDgDt3DnobOX427mi?=
 =?us-ascii?Q?e2Cgql8bM25SSRuuInkbITUoMFb5LXHdnnTCqm5jit8AJSIFhrjNHapTQNdY?=
 =?us-ascii?Q?OQzXa6i49xxOYyPdh7ZqSdtyc62A239V66DDe6zEY9J+eHmojs4B8Nt94FHQ?=
 =?us-ascii?Q?bjn25ID0U/+GsFs1twoaGS+h2ZG0wpoQBHG7LxeAtVAAqmOcO29/I59Vsg2Q?=
 =?us-ascii?Q?id8HNn/mmerr3VGT4S2Uy6rC/jl0OwwBCG0OWQy+xbOCqpaadDxf8gKf88U5?=
 =?us-ascii?Q?pBAobewHrxUgvE7WhAIXE9EObmXDJPiijHExY7XUzUrTP0OXet3P8lgRm9ks?=
 =?us-ascii?Q?CXOMS2dnL/YhPdFCV9M24hY9C26Wg4+CRUiN1PXpkxVsOHdIbbcv7JWMD+yS?=
 =?us-ascii?Q?3wZxvqJQGFX3HpB4C0qs0QWxqomvXh0/q08NmUb6hftOi7p+m8JbYbqFIu8t?=
 =?us-ascii?Q?cSDl1NbNkiisadXHt0K6WNxlxucPY5fZxf+wxZSNBQ8L5Hk7R72dC/aDXPAT?=
 =?us-ascii?Q?LYMfOFg+ZfElt2wwqRR6DZT6rRJaohThb9yw0NXaPUzC1Fp57PIBqjlhuJ6r?=
 =?us-ascii?Q?7CorMJfHQ6Hfbx4xYiLEawIrK7HOQ2jOLRyRGjlNWDxRMfIryAvmVl9wPFr0?=
 =?us-ascii?Q?UHW+rNFyFfnQJVx8tuTgAyrbPBD1+2Y9R7sk4gvy1myGqw7V2AGPIaYUBbU1?=
 =?us-ascii?Q?Il2bGueOsnskrtJfUiOB45WaLMg6wjIXuoWBqJNnUX1CYr908xfC3o2ac9LQ?=
 =?us-ascii?Q?+Nyp/Q/mYPZ+wu+L5mbXX44x3QWK0OPSSauGId9S3hgfoW/oVTsEpH0+Hadl?=
 =?us-ascii?Q?QVSgmjSrnihqQDtLc89OYduxVA395dqNgWMe3rppmmoHGQC/UB+Hbf1NOhVO?=
 =?us-ascii?Q?LPdJsCUAy8onqCZPuYAFHs2BNu3avjlRDfJYY3R6whIemID84+88n19Sx6Cf?=
 =?us-ascii?Q?jIcEq0tWP6fw5nNmJGTT2ejt/mlPoiF43zk5ysWTlnRoT1bWAWHV3NZP/lEp?=
 =?us-ascii?Q?cniBNs0XZ17/zBAl9yczT/yeG6ICLSFLl/dkcinbuZc+dRpgavvGVKl4brXR?=
 =?us-ascii?Q?VxSqrmBai5xoiy9i9RmtSG+SqH6zAGTGmjAvqJHsAw6PRfZm+od+h6opo7oR?=
 =?us-ascii?Q?pX0DrgJI8rA8Obgkoi1/ErpEJkuU2FU5PperJLyupTmlzOZ+oBtcIirI7+30?=
 =?us-ascii?Q?6DZ/wSWOJtytuUSmWXltTR9TzhyaQx027dzCik53xFUIXoDCmBj3Vr6+x3aH?=
 =?us-ascii?Q?fOJeHXEiAF87CSUaIX/pe1azJ1OVkipEQ03+zAwkY8WJWOMpp2Ih4WdvS57T?=
 =?us-ascii?Q?49DmqvjiyqJW1u23/9xj/PI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?huT4x1ivCYfY6iveX8zK1YEzhaDS126mFvUwtLrBDR60JjrPOWRU1ixyFsHJ?=
 =?us-ascii?Q?hSc6QSzoCWm0v49Hgb3VHyVM6SEVveC1BOGX2yUhpLsGNEHZfod9arm5qF/n?=
 =?us-ascii?Q?c261JJzNYMThQHIoL0apoALA4OhwRZ7WyvMQyh4pytMH9T0xdmNu9zLHS/Tx?=
 =?us-ascii?Q?nE7N7kiP4vpyvGAADEeFIdDgDfPB87vwqDj9ty+r0eCOK5OaM/7BHuTLY7XI?=
 =?us-ascii?Q?NcMDe+10eh0zDf1Xj6+1bjuOg5zNSHN1bFDg7PlkRP4h3LpxlB7Q/SD2b9JQ?=
 =?us-ascii?Q?u/uYxhThXSEeZsFqcFH3QAadXVahixev5oFWVDl4BaFw76A72ySvzlcaDUOc?=
 =?us-ascii?Q?9xb4VwIrFRNSn8MuVlgNvnn+2bX8dcK+kD2zlXC8g2sWAwIyU+dMlioeorQV?=
 =?us-ascii?Q?Thg1tQ5KLL0DAuBlNWkxsfpNMOrKgsWtYaGAczG9oc5prxrnufLeY5qgub2u?=
 =?us-ascii?Q?hXYC7iFqbcccare50JkdUXcpkY5IL3T71aghKM4ZFyZ9hPBpBNDQK1tC9wk3?=
 =?us-ascii?Q?iscEGXeeARu7Cuk7c3cHtX5s9i/5rUAF0frIsSHX3GmxiquqIT7DK//E+sNP?=
 =?us-ascii?Q?kw8IHCz7N9+BHMrYfqKxWZeyjZ3YVoYOShva5+QRYcETKOIe6OMHtjXGl/QE?=
 =?us-ascii?Q?mx6H/oc2tZHKiN9bdbv55OZkLWGqmkI9ldCJjtSoRFBPr71+2sDQhGvTVZ9a?=
 =?us-ascii?Q?Ala2wsNsKO7JHaUXVQm/qJpYVtdx6UKGERIC673o0eNTMPDHLiahc3wgrpNW?=
 =?us-ascii?Q?Kr5pSzjWjoIIBkHs5CbRO6QojgLBgGexpYrIgoRM662/DRkB2+na3dyIiBAf?=
 =?us-ascii?Q?E3/YLsh+fmSR61mCOI1MfSXDxG+0CsxCNBdeAlcVuhN2EA5hR4iEmAD8ZKzp?=
 =?us-ascii?Q?aJDujWfhqeHeV+HpPFuC5gpxKTaFAblNIBCAw3IohDXdacnTW1FULBw3z2x2?=
 =?us-ascii?Q?ME02SuvIU4qGJjmingDaCqgx508y7gZZ7yljGxmslsPwEhwPqYnHFFxlsPJX?=
 =?us-ascii?Q?iXUZq572ubv1kTuhIGfRB8+oo0BUMcf3HI5ee96Q0hc4qxsyrWd8mRn2fWoE?=
 =?us-ascii?Q?17ikr+vCGJ7qTPLzPS7Pypy/x5P7OEkmPVpKkgwGvYKAVvBJKagXeHGO8vZi?=
 =?us-ascii?Q?1wT3RZHmEXpNtGnxL5aMpDF328RUv5N2pIuP60hbkAkaJC2nvMBWjyQujGNW?=
 =?us-ascii?Q?DrurXNyu4SU7zuAYXc50YbBLvNgsXrb3lT3XDPYLqXDD2g+pyV4j/idL2Cpa?=
 =?us-ascii?Q?7NUwZxxrRYzOuoANtNY8JDOK9CJwdWr+OSg/+26cYSV91OASV6EKhwyAQskb?=
 =?us-ascii?Q?WoaX6ScFXDTSVOPCpDX8GGA48C0neGkqAT3bbyhf3OPyMmA+Oiond5hu/9Vp?=
 =?us-ascii?Q?6MZ76RWL885CRvo4ulhsJni5kB6LdeNIQeE8N+KgugvE7hlHxLsQnnHr/BEm?=
 =?us-ascii?Q?HWsmYMgfdybqE/RuwPbmN5Ihj9LA/L1yU9GEV2tc4eS9DeZYUDkNbxr8GNj6?=
 =?us-ascii?Q?bT/XTrJhsVRHM1CceYxYJKf4vfgiAOq7D/6R65uLCnsFQx6qfsERYJ23wBQl?=
 =?us-ascii?Q?disD+lH9xPliar2MOLfNX/jwPkIJ9XFjPHU3y/SEFBMc8Zx/g5tFb3ugY8jl?=
 =?us-ascii?Q?ZD7cBn0I35gBmevyPg5hQ2jRUWGdm30ETckxSSCdVXgt66jy1rrmNV+E9r3Q?=
 =?us-ascii?Q?TC5tEv1CQpZTr9UFx6xdn5Rho2vA9pcQ7/wdQaa4sp6IbvpdRUqcp6aL/srR?=
 =?us-ascii?Q?D4zdFeNe0A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e512f210-c20f-4109-591a-08de699d6457
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 18:43:04.6692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Jc+zDeFTe7E/LDOoNYkzyxFZKCOAhXNhKvD3FBxAiczMjKjEHNnrYJ9s7GsSOGqwTF/f3I++OIig+IFDSnq2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8852
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 11 February 2026 18:25
> To: Eric Auger <eric.auger@redhat.com>
> Cc: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
> arm@nongnu.org; qemu-devel@nongnu.org; peter.maydell@linaro.org;
> Nathan Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> Jiandi An <jan@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>;
> jonathan.cameron@huawei.com; zhangfei.gao@linaro.org;
> zhenzhong.duan@intel.com; Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH v5 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
> accelerated SMMUv3 devices
>=20
> On Wed, Feb 11, 2026 at 07:14:40PM +0100, Eric Auger wrote:
> > On 2/11/26 7:07 PM, Nicolin Chen wrote:
> > > On Wed, Feb 11, 2026 at 08:34:13AM +0000, Shameer Kolothum wrote:
> > >> For cold-plugged devices using SMMUv3 acceleration, the vIOMMU is
> > >> created before the guest boots. In this case, the vEVENTQ is
> > >> allocated when the guest writes to SMMU_CR0 and sets EVENTQEN =3D 1.
> > > [...]
> > >> @@ -1605,6 +1605,10 @@ static MemTxResult
> smmu_writel(SMMUv3State *s, hwaddr offset,
> > >>          s->cr0ack =3D data & ~SMMU_CR0_RESERVED;
> > >>          /* in case the command queue has been enabled */
> > >>          smmuv3_cmdq_consume(s, &local_err);
> > >> +        /* Allocate vEVENTQ if EventQ is enabled and a vIOMMU is
> > >> + available */
> > > Nit: though it is just following smmuv3_cmdq_consume(), it'd be
> > > likely clearer to verify the EVENTQEN in the callers.
> > >
> > >> +        if (local_err =3D=3D NULL) {
> > > Does eventq need to rely on !local_err from cmdq?
>=20
> > if local_err is NULL we can safely use it, no? Or maybe I miss your
> > point. maybe test !local_err directly?
>=20
> Point is: if local_err isn't NULL, why can't we allocate vEVENTQ?

Technically nothing prevents that I guess.

The only thing is we have to call error_report_err() if local_err !=3D NULL
and then set local_err =3D=3D NULL before calling  alloc_veventq().

Thanks,
Shameer


