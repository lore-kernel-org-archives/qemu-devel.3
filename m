Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91187E7717D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 01:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKoxT-0002W5-Q6; Mon, 09 Dec 2024 20:22:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.mackay@oracle.com>)
 id 1tKoxQ-0002Vs-MK
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 20:22:37 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.mackay@oracle.com>)
 id 1tKoxN-0007xE-Rv
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 20:22:36 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA1BrK8015774;
 Tue, 10 Dec 2024 01:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2023-11-20; bh=rB3YOaB106EuZoFZNO
 6Nog6SaYuCOAsUMPaP//aUsqA=; b=SDdBBAFRC7gMNkz8h7v9+NPbRiLHMnLAdc
 +ecVZ+/DXJc9p1WFkwyOn6PYT3IgcE7AYw/ROWkxcszkPVmf3+jY537c51HspkTQ
 XHTeERDf7K4R46cYPc2oublUd3xge5jKSFkeDrYaiP7C6O7Cf/uvJE32WkiwOdEw
 5GY8uFa8lTzsalJi0K/BkCFAzhdrqs2qZGOC9xroXJnXcTGoO+qyty0Lkri7gERh
 CsW7iU0/obh9J6BaEar4tCdNj2IoEhW7eU6zABlnAs0DBHnrtYBzL2QnpjbVVpmm
 m7GKe+NYXqKKN6FrKc2AkRn14g69OHoFeiDCBQVHyDTJzrjk3dJA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cedc4nv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Dec 2024 01:22:29 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BA18xWj008582; Tue, 10 Dec 2024 01:22:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43cct7smnt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Dec 2024 01:22:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+6w4Tt3Cq02e6+/tgI5umYlYlfYxeOXeLT1Y0JlZnUPpEWERfkWYN1VEvWLw8gntnw5oSCli/BRZCHFaQ8Ziu//A9WVSITGT50QfOX7YX0WB8Pg1VQAECS1qtwfzD4iE4fXjmddgasfuLGG7cRUI7CoSwfxlTDiOqWd8mIPtDi4JaIaNGZFK2hHkG/1kaT7QSem2QJyCqzou6dAGoq4wDtMVfMhIYkntRm8rJOBCh8zRv5geRQifmWv3e/S8idpUrqcKUOm7re79eOcIPB4abFe/6IkzNStxMX7ywOskSlC3w4u6EY2BPQ3GGTO51eSSSUXPz7eTg6DzDiXap37UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rB3YOaB106EuZoFZNO6Nog6SaYuCOAsUMPaP//aUsqA=;
 b=lkGhdcXVOCsjnffzNfR87Cwfgxu+NYTemjFlP1n3qUOnZqSLztPXV1Mu9BoT4QHuG4nKzLBclzfa0VBlRfwYfaY4ct1i80ej/CRdjT/03b4cklgpxuZHom98QsvHUn/fRbRkAugvc5OeWE0IHLJz2vLotIrHGyCvrodsf49bJ0FppSZ4aUY5lEkq84fHeibbOjmgSeHf4GSg8KvU4zK1vY2SLZ5eMD9JjuK2mlxzfi8tn+c20RHVEMxD/YkIonFDiCIuxyqraeTic+vvP2pcfM5moyRuHri9vqL1PQhvsWmN5Qlw0DgRaxAn4Dfn92HD8bMDLTXTBjOQgFiya/sQwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rB3YOaB106EuZoFZNO6Nog6SaYuCOAsUMPaP//aUsqA=;
 b=h2MOvXaIZ305CzfiQqkLXkEy2NcJDrk01S8A/75d/5yzsZOW9B33vneq0qUB4EW0Dx7pDNFGzYGl7k37T+ebyVKcrASgtmhMlnsIZKyxj3cK8EAQuucUXFItqIdC1H57M1ZTdYeQXJVoqrxR/11eN4HNxyERJJWbwQ5Jea9GnTg=
Received: from MN2PR10MB4269.namprd10.prod.outlook.com (2603:10b6:208:1d1::8)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Tue, 10 Dec
 2024 01:22:24 +0000
Received: from MN2PR10MB4269.namprd10.prod.outlook.com
 ([fe80::f430:b41f:d4c4:9f9]) by MN2PR10MB4269.namprd10.prod.outlook.com
 ([fe80::f430:b41f:d4c4:9f9%7]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 01:22:24 +0000
From: Eric Mackay <eric.mackay@oracle.com>
To: Igor Mammedov <imammedo@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, "mst@redhat.com" <mst@redhat.com>,
 "anisinha@redhat.com" <anisinha@redhat.com>
Subject: Re: [External] : Re: [RFC PATCH 0/1] ACPI: Fix missing CPU
 hotplug/hotunplug events with > 255 vCPUs
Thread-Topic: [External] : Re: [RFC PATCH 0/1] ACPI: Fix missing CPU
 hotplug/hotunplug events with > 255 vCPUs
Thread-Index: AQHbRedjFqbaIK/AekyOjWX3+ou16bLeA40AgACqhKw=
Date: Tue, 10 Dec 2024 01:22:24 +0000
Message-ID: <MN2PR10MB42694AF9F93475A6391AAC248C3D2@MN2PR10MB4269.namprd10.prod.outlook.com>
References: <20241204005636.18705-1-eric.mackay@oracle.com>
 <20241209153606.49556593@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241209153606.49556593@imammedo.users.ipa.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR10MB4269:EE_|BY5PR10MB4129:EE_
x-ms-office365-filtering-correlation-id: 18a1a02c-add9-4358-376c-08dd18b91a65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?x0lupdj0auDdSnv0nuO6M7wvNa6Z8tmxjEZx9wSyVot2wy+CWw4+5tkDkP0C?=
 =?us-ascii?Q?Y5z3GWLSkmT7QOCUu6ibR5qaqtrIqGlrLK9XVyzTZYFwj/GAOikJ1bJmEwf/?=
 =?us-ascii?Q?uGcz75HsIK7wCM1nqvDr29bQeEifB62U8RnFLPbMYDANoI50g7Yg+hJTov0/?=
 =?us-ascii?Q?p4JbJphmsOIrkJCogywgWRUcVOg838HPzBm345WiaXiX4mmXd+XHwyr744ZX?=
 =?us-ascii?Q?DdEaN6xJn8RXJlDvEbghKmOBJ0M8ln84Dg6Rqm+TdLf753CcvUKH75yF7Tvm?=
 =?us-ascii?Q?5SfIHz7v3bQYfOstGaHIvZU5KsGwj3z8yaq3O+RJxqyPlLXZJ0Oe1+DcYl7A?=
 =?us-ascii?Q?oAU0cjpoF9D3bUyL2WOOxjiz7RiPunNtTaxWgOU4LKxWvJ/aW4dQGcnOLCvw?=
 =?us-ascii?Q?mUxsM+Mf1TWLEeEnC5nu1hKZ4BzQgfJtOwjvb5vRxlHgkSHSXQ+0S0Y2+BeW?=
 =?us-ascii?Q?lD7+N9if3DZJxtvOS+TlfJGfOBD95MaMUR3dPoIf+gSBkwSvApLbKzJNop1M?=
 =?us-ascii?Q?29JWsu7GpzfDMvvXVOJcJkr0CecYTvrnaFP5d8dSQlgABmBH7mzpzgBzDyBY?=
 =?us-ascii?Q?3QYaxJhXeJ7l0aKm2kKIwmI9cRYDqxcKPUbuhtsQ7hbB6LoG7XZUytd7GOLf?=
 =?us-ascii?Q?poanR5nO3J+G88aaXZOrYFI2SrmoeTDcoOrOatPoJDjoCw+eVrEJHFe+ZeQW?=
 =?us-ascii?Q?YdUwukemCQO9cgjonPcRbQlw5Aixwp352NW/plSedF9h6sdW1kUJCcbab+jv?=
 =?us-ascii?Q?fSIYPZAJC7KfEuDGpMmqaE+/65dQAI4UVDpDzddLaCFWE8deynfkvuiFyOIZ?=
 =?us-ascii?Q?7otawSjqQR4zaYLdVGvMA4NoxaqC1zDWHt+XahTOTLF404HAlnJT1uFvWtH8?=
 =?us-ascii?Q?JhcJBrImZ+D1LYoOWIOIkP1nD0eatILLGgo65hKJYR90NzANTZvKs18oFcxV?=
 =?us-ascii?Q?Cw3oVNYQzIZxr5i9YvThNkdCi6fGopgmz5xRx74126qCujxdWLWdtd6L9LFi?=
 =?us-ascii?Q?AphCr3LSrVlXwfnjlIc3KKgQNqNwUSQwSSlrovoFU9DBGmo8PPknp/Mx63l+?=
 =?us-ascii?Q?SgLl5lB/mJa2wvhtlK1dWU2XtvY9X/cYMQlaawMPET586xkYhkZFCQzHg1Yc?=
 =?us-ascii?Q?X//wFIAbx1HS+PVfwmrRtXUywK/6b84lKQpio8jFlUj80ruTleW+mZ8oPeKj?=
 =?us-ascii?Q?1R/SH4A8LrITGYAVm3uSEtfWX7LzTVSEfxpHhIQU52RVSOfMH1kRKZt0jg/z?=
 =?us-ascii?Q?++HOgmj2DgEP2IjOFma//c4GM2ZrRVyYnXwxxz2xCdSdmMFdoBDgrTd6BIS7?=
 =?us-ascii?Q?AMe9OAYsEMwOz3LMn9Xj4q1dgg7pmCtJpRxLKSgjKz3G7kg1YLqWk68mD6CO?=
 =?us-ascii?Q?rlzAuV2eWD/vD5bb26pe+qz5iPsdsayfPlhHfy2aa29xJA+g4Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR10MB4269.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GujibDXpg+HZSbLBqpoCo0Tsj71PCbJjvlHstKKlwF0nZq988nlmU3itVykh?=
 =?us-ascii?Q?d1L47lgGT8EHGcH7/DRIG1WtcFb3cSyGosuH4tOw4PbpqjmSCKx+J+/ee94d?=
 =?us-ascii?Q?mF+UDPjoBWjPKBDH51guKKxrCj/vYiKzCfWoc24tYOhxs3rJOku12SRWG6jK?=
 =?us-ascii?Q?AupCdGDUOIx7o5HjKzR7h1mUvAbu+v/IuF7osSY44BWnMlbsWzmSY3fFHBwM?=
 =?us-ascii?Q?qb/6OiIUP3K9ooUz83G9uhVlWrBcoRh/Ds3FCSOoGGtUu8bTTEH6saPCQ1jr?=
 =?us-ascii?Q?19MBn1o8pbOxrMhOdhl+P6PeEUhiqvQ+Tzb8u1TukrZUDTnbwB6oft4Q+H5E?=
 =?us-ascii?Q?sGrZTKKhxUKTfF0G8H3WJjX9sJRp3zfX5QY51g9n+EfTUP6GCGKserkZ2aJ9?=
 =?us-ascii?Q?5UHOFochbYcSa39QWG4Vy19TrYRos8Fcp0VsUWZRIVi5oBsM/uLrARj4u1c4?=
 =?us-ascii?Q?16aR6IFx74AeKmctUpcWZrDizSibtgHXiO8Fo1zF4efSrZdWvXx63E22ZhRX?=
 =?us-ascii?Q?MzZ4FiY3jjR+D9Wn6TXAMcnVjrxldvQspvp1imiK2wVybKqap89Uk4NFT5BE?=
 =?us-ascii?Q?jRlVEC5aZztAX5zyHqxaFpeh2bhqYJzH0RVNpeD7HQfvPicfxZKc/AwwofCl?=
 =?us-ascii?Q?+l2l2Y8Ynz63bMywRl58wKmuF8ScomV25pqoW+K8GK+koSFx4epZocxYh78f?=
 =?us-ascii?Q?wTxgcQ5ESBaOKkA2aQifSqGTadBljGtCrwx7I8znbBvEnn1VgzMTtX8ppYYq?=
 =?us-ascii?Q?i/pv2piD4jNxuRifZ1cjsnPUsqz5HIhdoB1r9w4Z9ZoFeZzBK/oLquLOupUC?=
 =?us-ascii?Q?agaVsmbtyZXmtbhYqlMzKU7CRc4uIU54lgqwXAPMHkOWMTYmVN3lmnXBJz5n?=
 =?us-ascii?Q?Xborvs0QfUeSQ7Ehhuoo6WwI5lKRwiqwYM0uXfNgcK+c0LqIf5w9MytXjI7x?=
 =?us-ascii?Q?35qEYbD5k9lCMa99cX20l+hIkI+I8cnpgY4p+vITwpPnzLfAejHod4jgMX5s?=
 =?us-ascii?Q?wag2Co6dXYWQ01lPM4yLAWbWYHOpl5fOvJI8TAwdEIAgMV4jmYoisAyrnGzU?=
 =?us-ascii?Q?puncd4XehXSligZtBYD6F2vgQQWkUZVqEoTvyv1yzNGTZ+62uAS3JrFIjGG4?=
 =?us-ascii?Q?PRkemYqlm7xDYy6G9lNTIzGYNj41n1VXZiYLkCR5old0LyjQmQNk3H1zfM/g?=
 =?us-ascii?Q?AhXW4alVhh1Cnpr6bn1TPlbVIrBBn1jTbANpbxyxWIhD1NMsDXvsFI2r4zSx?=
 =?us-ascii?Q?s5RcVXw66Ay42xeLhAP0iriJAjR1+BsxXi8N24vigxRp9LSWw8K6GEYnTzfW?=
 =?us-ascii?Q?5ZeWYDqOFmy0b3h6P5xRRWWAz+SV8J55FBY+QVHQdP1OeVv5upGF8Gf+GEHY?=
 =?us-ascii?Q?oZeXMxq60Hd6qgx4JxqfmvohN0Pnl+vzTcdSSAkmGXiNLhFpuX03uP8gBAyo?=
 =?us-ascii?Q?WlWXUMCgKhk6/0wZvuDcfIT0akTeDfMlgAsKH4HoBXyISCc6SlVdhObnGykr?=
 =?us-ascii?Q?t7MrQ44c8XT8Plg6+wira34Stau9XezroPECDOEhAEJHgq6n07Y6mxkG880A?=
 =?us-ascii?Q?hxQDEfapGM+X2wcCpaArav1Wcv1kDg+1HMj2zlqKJIgbS2pwycHO+orKDI8m?=
 =?us-ascii?Q?4g=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MN2PR10MB42694AF9F93475A6391AAC248C3D2MN2PR10MB4269namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /C0AT1EVLuUNdDx6rBYlLm3Mr5Gbdw7Oesx9JudI7OtGRXVzLbfxQBr73T6tO+t7xAeE8RLAYK1QOwe6aLEnBPilqiKTMOOTc3hLHnyLbyFJTVH5vnxsAUFpiypKD9jpATagIH9PGlitVQ9UUSkcykauDA7vKTwvDjjq4gA2vu5YsqhzfjkMWBcmYs74cR/UdKRJ1FvhaOYBm9Jx5yfxmGGYcbp+vJhNUC7D3AyGp1Lfwkz3wAjxI7NrhQLP8zXNjzvzIyNrnfmHut+2f3j8nExuNcYOYw0hePKmhMmQYzMGJjKz8rZin6tHd00PdFJfEALLkTQajQBGpSr/5T1JEzYtWem4THcJK9wpAKKqgO7WkT36kDmabv380HMiCEqj9xeyNdTFl0FQPtywtSvZ8Zhg4xzmatFe+6scKACbVBPjyCoAUyEmyB23h1mK30VEJNQKPT5pyAFg3Fxd/T9SNNgh4+s1294Lv7ZZTqv0o1mygC6EVXQDtXg8Ksy/6UEI18L3Nt/gqXMr9DCvV+B1bZSjLZPIelzD5CCM7asOpvdJIlpDB7eKeYQFUZfqprmX/CpizBXShy0XEm51lfWg3N/5x4+TTFDOCm8a18LJSEg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4269.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a1a02c-add9-4358-376c-08dd18b91a65
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 01:22:24.6754 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pLZVH0akXeMVba26Z345qaQJoDcmhSx7VvOIhs9M2ZKEOCTkrj1KWVDmDZmbWzZFPPhsqYe0RVytKT7lt83QGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_22,2024-12-09_05,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412100006
X-Proofpoint-ORIG-GUID: KtdB0tkSDLS09HLzBBFX8en0OxyQ5pE-
X-Proofpoint-GUID: KtdB0tkSDLS09HLzBBFX8en0OxyQ5pE-
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=eric.mackay@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--_000_MN2PR10MB42694AF9F93475A6391AAC248C3D2MN2PR10MB4269namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Mon,  9 Dec 2024 15:36:06 +0100
Igor Mammedov imammedo@redhat.com<mailto:imammedo@redhat.com> wrote:

> On Tue,  3 Dec 2024 16:56:35 -0800
> Eric Mackay eric.mackay@oracle.com<mailto:eric.mackay@oracle.com> wrote:
>
>> ACPI hotplug with 255 or less vCPUs can use the legacy CPU hotplug inter=
face, which does
>> not support hotunplug. If it's available, hotunplug will use the modern =
CPU hotplug interface.
>> This creates a situation where hotplug and hotunplug are using different=
 interfaces, but
>> the end result is still functional. CPUs can be hotplugged and hotunplug=
ged at will.
>
> only one kind of interface should be in use. And for quite a while firmwa=
re shipped
> with QEMU is using QEMU provided ACPI tables, which in turn switch interf=
ace to
> modern hotplug when guest OS loads ACPI tables, see:
>          if (opts.has_legacy_cphp) {
>             method =3D aml_method("_INI", 0, AML_SERIALIZED);
> or firmware does the switch (OVMF usecase) before guest OS.
>
> if any hotplug action happened before guest switched hotplug favour,
> it will trigger SCI, which guest OS should process it (incl. switching
> to modern interface and sending necessary device check/remove events)
> once ACPI tables are processed.
>
>> With > 255 vCPUs, both hotplug and hotunplug will use the modern ACPI in=
terface.
>> There is no priority or rules of mutual exclusion defined in this interf=
ace,
>> and the behavior in the guest is implementation-defined.
>>
>> Unfortunately, it is possible to have both a hotplug and hotunplug event=
 pending
>> for the same vCPU. When the guest processes its pending events, it may s=
ee the
>> hotplug but ignore the hotunplug.
>>
>> The most recent event is likely to reflect the desired state of the syst=
em, so
>> ignoring the hotunplug event in this scenario is unacceptable.
>
> QEMU has delivered both events as it was intended (and in order plug then=
 unplug).
> I'd say that ignoring events is a guest bug.
>
> With unplug, potentially if fixing guest is not an option
> one can try retry device_del to trigger unplug event again.
>
> PS:
> I vaguely recall linux kernel wiping GPE state on boot during
> initialization, but that is guest problem and should be fixed
> on guest side.
> (unexpectedly enough, Windows handles GPE state as expected)

Consider the scenario where a hotplug is requested, the hotplug bit is then=
 set.
ACPI event is sent to the guest. Before guest can act on it (either timing =
or
perhaps the guest is paused), unplug is requested for that same CPU, and th=
e
unplug bit is now set. ACPI event is sent to guest again. The guest now wak=
es
up or becomes able to perform work, sees there is a pending ACPI event. The
guest now requests to read ACPI_CPU_FLAGS_OFFSET_RW, and sees both plug and
unplug are set. How does it know which to do first?

>> Repro: This can be seen in practice when a q35 VM is started in qemu, wi=
th
>> maxcpus=3D260 or something above 255, and a few statically allocated CPU=
s.
>> Example smp line: "-smp 4,sockets=3D2,dies=3D1,cores=3D65,threads=3D2,ma=
xcpus=3D260"
>> Then use libvirt to add vCPUs up to the maximum before continuing the VM=
. After
>> the guest starts up, delete one of the vCPUs. 'lscpu' in the guest shoul=
d still
>> show 260.
>
> above should work especially with unplug event happening after guest OS h=
as booted.
> Lets simplify reproducer to QEMU only (i.e. getting rid of libvirt part) =
and see
> where it leads us.

The guest has not processed the hotplug events that took place before the g=
uest
OS booted. There is nothing to tell the guest OS that it needs to check ACP=
I
event flags, or to clear the hotplug bits since the CPUs are already presen=
t.
When the unplug comes, this is the first time the guest OS knows to check f=
or
hotplug/unplug events. When it reads ACPI_CPU_FLAGS_OFFSET_RW it will see t=
hat
hotplug is still set for all the CPUs that came online before it booted, an=
d it
will recognize they are already present. For the CPU that a unplug was
requested, the hotplug bit was never cleared prior, so the
ACPI_CPU_FLAGS_OFFSET_RW read will show both hotplug and unplug flags set. =
It's
now implementation-defined in the guest what it wants to do, or whether it
assigns priority to one event type or the other.

Agreed, the libvirt part shouldn't be important. I can come up with instruc=
tions for QEMU-only repro.

>> The proposed solution is to enforce mutual exclusion between the hotplug=
 and hotunplug
>> bits in the modern ACPI interface. Setting a new pending event will clea=
r a previously
>> pending event of the opposite type, thus preserving only the most recent=
ly requested
>> state.
>
> Once VM is in running state, clearing flags from QEMU side is not safe.
> Effectively it would introduce a race with guest code.

Yes, I see what you mean. Agreed this is not safe.

> Also I'm not sure that flags are the issue here,
> Capturing some CPUHP traces on QEMU side and logs from guest side
> might help to clarify what's going on.

Will work on providing those traces and logs

>> Eric Mackay (1):
>>   ACPI: Enforce mutual exclusion betwen CPU insertion and removal events
>>
>>  hw/acpi/cpu.c         | 36 ++++++++++++++++++++++++++++++++----
>>  include/hw/acpi/cpu.h |  4 ++++
>>  2 files changed, 36 insertions(+), 4 deletions(-)
>>

--_000_MN2PR10MB42694AF9F93475A6391AAC248C3D2MN2PR10MB4269namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<div id=3D"mail-editor-reference-message-container">
<div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">On Mon,&nbsp; 9 Dec=
 2024 15:36:06 +0100<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Igor Mammedov <a hr=
ef=3D"mailto:imammedo@redhat.com">
imammedo@redhat.com</a> wrote:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; On Tue,&nbsp; =
3 Dec 2024 16:56:35 -0800<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; Eric Mackay <a=
 href=3D"mailto:eric.mackay@oracle.com">
eric.mackay@oracle.com</a> wrote:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; <o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt; ACPI hotpl=
ug with 255 or less vCPUs can use the legacy CPU hotplug interface, which d=
oes<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt; not suppor=
t hotunplug. If it's available, hotunplug will use the modern CPU hotplug i=
nterface.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt; This creat=
es a situation where hotplug and hotunplug are using different interfaces, =
but<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt; the end re=
sult is still functional. CPUs can be hotplugged and hotunplugged at will.<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; <o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; only one kind =
of interface should be in use. And for quite a while firmware shipped<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; with QEMU is u=
sing QEMU provided ACPI tables, which in turn switch interface to<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; modern hotplug=
 when guest OS loads ACPI tables, see:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (opts.has_legacy_cphp) {&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; method =3D aml_me=
thod(&quot;_INI&quot;, 0, AML_SERIALIZED);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; or firmware do=
es the switch (OVMF usecase) before guest OS.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; <o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; if any hotplug=
 action happened before guest switched hotplug favour,<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; it will trigge=
r SCI, which guest OS should process it (incl. switching<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; to modern inte=
rface and sending necessary device check/remove events)<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; once ACPI tabl=
es are processed.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; <o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt; With &gt; =
255 vCPUs, both hotplug and hotunplug will use the modern ACPI interface.<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt; There is n=
o priority or rules of mutual exclusion defined in this interface,<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt; and the be=
havior in the guest is implementation-defined.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt;<o:p>&nbsp;=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt; Unfortunat=
ely, it is possible to have both a hotplug and hotunplug event pending<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt; for the sa=
me vCPU. When the guest processes its pending events, it may see the<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt; hotplug bu=
t ignore the hotunplug.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt;<o:p>&nbsp;=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt; The most r=
ecent event is likely to reflect the desired state of the system, so<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt; ignoring t=
he hotunplug event in this scenario is unacceptable.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; <o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; QEMU has deliv=
ered both events as it was intended (and in order plug then unplug).<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; I'd say that i=
gnoring events is a guest bug.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; <o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; With unplug, p=
otentially if fixing guest is not an option<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; one can try re=
try device_del to trigger unplug event again.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; <o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; PS:<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; I vaguely reca=
ll linux kernel wiping GPE state on boot during<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; initialization=
, but that is guest problem and should be fixed<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; on guest side.=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; (unexpectedly =
enough, Windows handles GPE state as expected)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Consider the scenar=
io where a hotplug is requested, the hotplug bit is then set.<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">ACPI event is sent =
to the guest. Before guest can act on it (either timing or<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">perhaps the guest i=
s paused), unplug is requested for that same CPU, and the<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">unplug bit is now s=
et. ACPI event is sent to guest again. The guest now wakes<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">up or becomes able =
to perform work, sees there is a pending ACPI event. The<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">guest now requests =
to read ACPI_CPU_FLAGS_OFFSET_RW, and sees both plug and<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">unplug are set. How=
 does it know which to do first?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt; Repro: Thi=
s can be seen in practice when a q35 VM is started in qemu, with<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt; maxcpus=3D=
260 or something above 255, and a few statically allocated CPUs.<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt; Example sm=
p line: &quot;-smp 4,sockets=3D2,dies=3D1,cores=3D65,threads=3D2,maxcpus=3D=
260&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt; Then use l=
ibvirt to add vCPUs up to the maximum before continuing the VM. After<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt; the guest =
starts up, delete one of the vCPUs. 'lscpu' in the guest should still<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt; show 260.<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; <o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; above should w=
ork especially with unplug event happening after guest OS has booted.<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; Lets simplify =
reproducer to QEMU only (i.e. getting rid of libvirt part) and see<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; where it leads=
 us.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">The guest has not p=
rocessed the hotplug events that took place before the guest<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">OS booted. There is=
 nothing to tell the guest OS that it needs to check ACPI<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">event flags, or to =
clear the hotplug bits since the CPUs are already present.<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">When the unplug com=
es, this is the first time the guest OS knows to check for<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">hotplug/unplug even=
ts. When it reads ACPI_CPU_FLAGS_OFFSET_RW it will see that<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">hotplug is still se=
t for all the CPUs that came online before it booted, and it<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">will recognize they=
 are already present. For the CPU that a unplug was<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">requested, the hotp=
lug bit was never cleared prior, so the<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">ACPI_CPU_FLAGS_OFFS=
ET_RW read will show both hotplug and unplug flags set. It's<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">now implementation-=
defined in the guest what it wants to do, or whether it<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">assigns priority to=
 one event type or the other.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Agreed, the libvirt=
 part shouldn't be important. I can come up with instructions for QEMU-only=
 repro.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt; The propos=
ed solution is to enforce mutual exclusion between the hotplug and hotunplu=
g<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt; bits in th=
e modern ACPI interface. Setting a new pending event will clear a previousl=
y<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt; pending ev=
ent of the opposite type, thus preserving only the most recently requested<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt; state.<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; <o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; Once VM is in =
running state, clearing flags from QEMU side is not safe.<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; Effectively it=
 would introduce a race with guest code.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Yes, I see what you=
 mean. Agreed this is not safe.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; Also I'm not s=
ure that flags are the issue here,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; Capturing some=
 CPUHP traces on QEMU side and logs from guest side<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt; might help to =
clarify what's going on.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Will work on provid=
ing those traces and logs<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt; Eric Macka=
y (1):<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt;&nbsp;&nbsp=
; ACPI: Enforce mutual exclusion betwen CPU insertion and removal events<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt;<o:p>&nbsp;=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt;&nbsp; hw/a=
cpi/cpu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 36 ++++++++++++=
++++++++++++++++++++----<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt;&nbsp; incl=
ude/hw/acpi/cpu.h |&nbsp; 4 ++++<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt;&nbsp; 2 fi=
les changed, 36 insertions(+), 4 deletions(-)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt;<o:p>&nbsp;=
</o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR10MB42694AF9F93475A6391AAC248C3D2MN2PR10MB4269namp_--

