Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC8EC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 04:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPE78-0006O5-Ql; Thu, 04 Jul 2024 00:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPE72-0006Lj-6F
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 00:30:31 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPE6z-00088F-K0
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 00:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720067425; x=1751603425;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=rBnLqsdEUQVURjroq53xWgUx8QD8hDAFurkGMHRfPoU=;
 b=DmJ7ueAAMUgJ9xSfCDRcdSnFx2/o/Jd1FAuqRpI5PA6lZobtaDP8+97D
 jXZI1+xARZ/40CPn55ArSNjWmLim1MJEHQv/z2XzxD5608AHqzr1Z1Tfw
 8zVABu8tvB0A7gNVrhTeIctiTWHF3w0mOwXCpuoiKigLSAUFgJ/8ugLp2
 OnAhhkrCH7fGh34XD8AUoDGppcMcCf5tzf3w3iHXx1KJQEngV68k/1hN+
 HbUS+SUBfhDJTYWxOiFWrARG6uX3W0FKUJCVxJQ09cqnWnLPTSSFkG8S9
 UVGAqn3YWeVLE496AASmuxWLxmbPtLjdzZU4gAcolOCGhxQQ+s+ZDndUR g==;
X-IronPort-AV: E=Sophos;i="6.09,183,1716242400"; d="scan'208";a="15866369"
X-MGA-submission: =?us-ascii?q?MDGJLKZRZDfxEHBVcrUket9dqoSyAjQhER6woi?=
 =?us-ascii?q?GjmNH+VL6izXOKRDPdIyui1ZkLGU4gYohUzN4Gw5D2uChPr8M3JMzpLf?=
 =?us-ascii?q?XYQoEUGauq3aoMAQg5cZwShK0a8rw5+Ny1boww046SRJ8OUgq3pgRUv3?=
 =?us-ascii?q?VX5OG9z9+LCYmnUi3poOJ9hw=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 06:30:23 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRPlVoXYUmXJtIvqYhlphePN5gM0BtMwDf1p6dQYq3mmdJJ9WJ1YkFxZlEw6ToNO5Xv0lOTFZOPaosLNFVhxweBLQ9Pv07tdXQkFl58yop/1hFbGQLTsG72tkgEgVlPy1PzEREirVDFInuhnhuPv30yF+qCZsCNldKUbUMbGCtbNIhgaEUwCnfy9WWzrX5lIjuStYqnj7RKc9ALmOmsalUt9aIgNBDiMBF3QMO4lR7znL5Z05MhF+4VQ06P/V66msTsX9O/Wv5jTNqMLk6N8KSYuesi+j/wlYsSwx02yolkCgiEp/0005N8om31K2ADU2CyVAASm/uYZFBwnx+UZAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBnLqsdEUQVURjroq53xWgUx8QD8hDAFurkGMHRfPoU=;
 b=mWPicUH05OBKmEJgGv55jP8azlXCi9LSJ4UJR4ZUNkkEApJ2Xp9gJbdCRzHQEcVBTvBS57DemxrRGZxNPP9M64wZOibdsQZM+/9bJ4ycyy5TBJuorvqzoqrL4mVXF3FdN+UNlc+FLnPi6lHld0bxktnptKDTwVf9rnQDdqAvcNsf65oEoMiUdOHhKi/hGIYwnCHsO+Af86OEYBmH8wTi/z8W6XeZBVAZ9xVR/btP4WGXGuVxvqb8lFdWhDXXTr5RinX4R01im5IZrVg2IHHOU6HCj+rxWDJotb5ZKPJa2nl6ub/owPgN0Wil0Za74A1boMHuB6O8BRz6qt+gDCBfPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBnLqsdEUQVURjroq53xWgUx8QD8hDAFurkGMHRfPoU=;
 b=Z9z7wAfw1eEWM8Z58SgLUlMF9qAMaLzQK3m916GL+eJCsbVBeoMTv8U431Llu4tOCxi8XbrE4y9+qmKymOQP13Dz5OOMxTyvsesnBk9aJCdYu67EUHL1vmcJIz2mRLSHyQLBTLXavtX8h7OUSF8Jg0UgPjqmpJ/kwXYuPMXjIxug20QpcZvwAJBTe7ONmPpEeStsiHk/gWEhbR1ZysODLekLLJmmImSaCvzw9s6+LaBrhljrzb82z7giA+rd0Pyf5fB5kUpfMzy9DyT2JGY+xQAmVzxkI5mCe/eHktwZMill0hfFHHz3hLwotxdqR5KGL9340vf3YHD/S7oPBy/KVw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6494.eurprd07.prod.outlook.com (2603:10a6:800:18d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 04:30:19 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 04:30:19 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Yi Liu <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH ats_vtd v5 19/22] memory: add an API for ATS support
Thread-Topic: [PATCH ats_vtd v5 19/22] memory: add an API for ATS support
Thread-Index: AQHazEQPuEYX/3NIkkWJkupwBDAHerHk7J+AgAEQmAA=
Date: Thu, 4 Jul 2024 04:30:19 +0000
Message-ID: <4ba9b7bc-b965-4a24-88aa-ec1010d60189@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
 <20240702055221.1337035-20-clement.mathieu--drif@eviden.com>
 <ca43f372-413e-4e3f-b4d9-26164f5cb7db@intel.com>
In-Reply-To: <ca43f372-413e-4e3f-b4d9-26164f5cb7db@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6494:EE_
x-ms-office365-filtering-correlation-id: 8629ebd6-658d-4e0d-2cb1-08dc9be202d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NlFZSHk3Y3lJam42Q2dHWG5MRFdsclBNdlFmVzVaQlBLblNYNkxCK2ZPQlVW?=
 =?utf-8?B?NTJuZTV5YjBDM1VScUJvUmJDR1hEaDR3WU1teDZsblMvckY2Vjl5ZGxLZWF4?=
 =?utf-8?B?Nks3cFZWb0thYlRiY0lBQXVTYjVXMmU0Q0pCWG9ndDZyQ09WYmlZQUVUWkJJ?=
 =?utf-8?B?ZDFwVzlrRVNiaDVZM1dUc0ttcCtRTERuWGdNam94dEx3TWpaeXNlZVdGQmN6?=
 =?utf-8?B?UDJXRDBjTEZXejA2aDVDbkt0WVdCM1c5eXdZRFZaQU9WcUNicUpQWU5xS1dI?=
 =?utf-8?B?ODNRdnlNQWk5bmhDOGxVT0wwYWdmeGxZU3VzbHdzcFJVSXRvN0daSjNrbUZ6?=
 =?utf-8?B?UGw0ck9qN0F2ZDJaVWtOWXhsNE1VSW00MVZlMmFjWWFaZGgvS244SUltV1Zu?=
 =?utf-8?B?SWhMaWRtOG14YkVnUWVRYlAza2EvMHcxM29IMTJiTTQ5bGNJSWVrT2hldUow?=
 =?utf-8?B?YU1sd1lyaVdudUVQbDBiMTV0cHRaL3E2K0RaV0ljQUJIdktUYy9nTnNHR2lY?=
 =?utf-8?B?dmRqZE9IMnk1TFovM1hZSFU5MndWWGp2VGNGZEVIRk9RVUpMMFVNdGt3QzRD?=
 =?utf-8?B?RDh0M2NNRGl0WjJDSUhIVUNTbEZ2QWltaDNaZkpRcmRvZkJLQS9NVnNERlJr?=
 =?utf-8?B?UnFZQlBiaHRzUGxsZEZ6UEFOSlc2cnhyY2FISjROU2NxRTFiQS9EeVRyQWUw?=
 =?utf-8?B?VXU4ekE3UUtTV202YUtpcFYxOFNSZXljcE5xV3RyY0ZaM0hFczFqeEJieUd3?=
 =?utf-8?B?L0ZRb1BUZFQ1bkIzS05ncC9yWGZGMnEyS1djMG9FY0RiUk5udlZLWE91eDNY?=
 =?utf-8?B?eGRJUk5RYlBhMjAyTmtyT2pweEV5TURLTGFqdG8reWN1WmNCNjVlc1NRdmtM?=
 =?utf-8?B?dVJ4TWp1M2lQK3F6d1MyMGZnTVJWSWNXeGVmNFhTd0ZlOUU5ZUZUci8xWnpL?=
 =?utf-8?B?NnoyWUxidkZ4Yi9aMnkxc2dvNkYwcUJPaXFZV3lyUFJnL1RaZ25aNXBMNzdV?=
 =?utf-8?B?ZVZRT1JOcXZxZFA0bkozckY1b2lPRHhyVzdWeFRML1V0Z0FuQllDSlhDRGxK?=
 =?utf-8?B?RVo5SjA0N3o2U3BCWXZML08xVlZFbzhLcjNLcG1GVlFBa2xTQ1hkYmorME9D?=
 =?utf-8?B?V0NVS0xMSUE3VGVCL0tuQy9GUDF1U1IyRWE1b1NMSEVIVzRkNEQyaWNzMEdy?=
 =?utf-8?B?NTUrWDhaa1hXM3RiUnQxUTVYVzhZalpLM0xFODlsdHgwVWRkRjJkNmtNcXRT?=
 =?utf-8?B?eWpxWTNub2Z4dEdEWUpVNUxMUW0zQ2lycGg5RUowMEtZZi9SaVFEek5JR3Zk?=
 =?utf-8?B?ME5wekRTSU5PK1V4bmZrQXlrRDlkSldnRHdmdHpyTlNSRnVvT0NMY2VkTTc5?=
 =?utf-8?B?Q1dLaTVUNkFtOGkzN3BWUmN2YUF3QzlhcVZrZDBkaGlvWGUxTG5GMzJIUG90?=
 =?utf-8?B?dzAwMDFEUXhlMUttQUxHVEFiNkhNMG5Mc2Irdkw4QTQyYnYvaDlVcWpvWmRW?=
 =?utf-8?B?UWZ2eGlreWlLd3NTZ3daeWhuUXl5NmxwOUs1U1hPK2JtMytoSnBISjVmUzZm?=
 =?utf-8?B?ZThSL2xwVFZOVnVnTnVLRzNPUFdDcHdaUVlLbU1acXRETTFsQkQ2QmJHMkNF?=
 =?utf-8?B?eVFUL25uSitzNFc5UmpneHA0Q21UOFcwZTRzcFJUTEhkS1NoRVJubEJ0bk9t?=
 =?utf-8?B?SGcyMXhLdml0M1p6QXJWNzI1LzR5eThhZGJ4d3hmUHVlbnA2RlpxZ0Z6elJF?=
 =?utf-8?B?cThoNGhlS2kxQ1VJZjdoanptL3FHWkRpU2xSWkNnZE5YWFNuVzM3NnlzZFBJ?=
 =?utf-8?B?K2QzbnRlODRNVkZmQllJYko5Nng2eFBPZEYxMWVEMnd6dnRlSzdmMk9uUFZx?=
 =?utf-8?B?RWc4MXM3ai8wWE5uQVRpZDFkclVLd3NkK0NyL1RQay9JYXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGo4RGVTYytvY1lzc1VwOGlsMzR6QWpoSjZuQzVVUzcwU2ZKK0s2SFVKZ3g2?=
 =?utf-8?B?QVVBVFJ0RGQ5ZFpxUERXdG9FalpVNzduTjVnbFdqRFovTXJQaXl3U1FZUEhX?=
 =?utf-8?B?Qms1QUQ0UHFteE9UQzlkaENVWk5GbStUbVVNdzZrVlNJWkliR1JDbjQ4a1ha?=
 =?utf-8?B?VjJtK3FZRXJmSkZiVUx5VmRzMXNsNTNVVU5OYXJrL200K3lrWGhKRHZMUEZF?=
 =?utf-8?B?MWJJejRMa0VIVWtQcnZXQ0w0dit6Y3R2dzlJUC9GdVIyWHBGV2ZVWklDb1NW?=
 =?utf-8?B?SDRFL2lEK0VmOE9EaHFtSkNiRUpSQnRwcldPeXhrSHQxQTZJOUpmNEJiWi9J?=
 =?utf-8?B?RVl1bzhPK0xLc3FXcFNML0V5L2RFZWpjTURMN016YlVVbDRNNEw0TzQ4YVdh?=
 =?utf-8?B?UmZpTTFYb3Q4OFZGWjdFam9SQ1l1NnJHa0FjdXMvaStha2xXbXh0bDhZMUlT?=
 =?utf-8?B?SXhJRFhnUCtCSjMwTnRXUDBYRnZ5Q2t0bXlXVnBhNHVFSjBVK0lINFIrZG1x?=
 =?utf-8?B?QWhHbFdMOWk1bnFwQmZOVU5EYnJ1Q1hVSFRSM1pyVmgxQ2ZSK3BBQXkwNHVT?=
 =?utf-8?B?bUJKYlkzZzA1UENUcWlnUXlrWW9sQ0FIMmZYbWhqVzVhTitjMDJ5aEQ4Z2I4?=
 =?utf-8?B?WGRmZUdhcytIMzdHUE00ZExqcnpjY1FuanpZUjZUR0ZjNDk1MzlKenN0KzRq?=
 =?utf-8?B?RDYzb2lVa0xJcHRWaDFpZFFkMDdjSjg3SG1zSkNETWRDZDZIMEVrN1RBT3ht?=
 =?utf-8?B?RWJmMEpyMDlDa0pSMDFvUXRER2RIM2JVU1J0U0FqMGhWVUltMkhDcSt5SlBn?=
 =?utf-8?B?WDkvS2p0WHR4WGtrY0dTY01iemNaNlhmbmRnYzhWUlZFV1dXUHRCYWJIbXRl?=
 =?utf-8?B?NVpQUCtTVnBNVVZwcWxXWnJWZjlleEwrQ1B3dzN6WUNzR2RQMnF2THlCOUtj?=
 =?utf-8?B?YjZFS1VtR2pBOUpKbEdzT3pSbVQ3NWtKZndRYmRlWGxKWEdWRWlxbmkxc2pT?=
 =?utf-8?B?eFcyQ3NZZFVlQUUza3R4UElnc2p3YjBOZW5YN2ltVnlKWkxNTzFIdmtPUWZI?=
 =?utf-8?B?VlJoSTUyVUFCTHc5a3BaaUVQUGJCRkNZUzR2WmpMbE1INFczV0xUK3dvUllu?=
 =?utf-8?B?NVI3Y0xuNExTSi9Tb2Y0c0tzL2o1NzEybmQ3ODlBVVlPVkd4OTBSUWRjVjZu?=
 =?utf-8?B?bldFL1NqSUYzd3JTYy96amgzV0dLMzJWMnFKWVpHczlocC9UT1FxcUpkSGJQ?=
 =?utf-8?B?RU9NbngvNWw2ajk0VGtURG5qZ0Q0VGhTbCtaVGZ4aUpiTGprSS9CdzVEbEFo?=
 =?utf-8?B?UWJBSys0d25aRGkxZm9TZzB5bTBCalpBaEUzVnQ0OUYwOStrZUp5eDRxeXBJ?=
 =?utf-8?B?MmNrZ2d3T0FDM2RsVE1RaFVRLzNqaC9MSzI2TDBGRVBtN3MzTnBTaERzYXYz?=
 =?utf-8?B?QTYyQWpvVTgySVIySldPOUZmTDQyK2crWlRIMS9NcWtYY3ZKLzhDSjRBMGJS?=
 =?utf-8?B?UUhYUjFyVkc0YktYS0I5NC9jMHZETTNoV3MrOUpGT21HTUV3V1ZGUUdidTZp?=
 =?utf-8?B?bG9NdmFicUI4Z1p0VGx4YkZobm0xM0Q1OEtNWUtVZy9nUGh1TEg1enVWUVZF?=
 =?utf-8?B?ZDlTWnJ5VUdNQVQzRC8rTm9sUTV0ZGJhblV0eVFWcEZ5YzhFTm51U0dxMmpo?=
 =?utf-8?B?cE04V3RqdEFwSHZuSVFiZ0lWLzdRRXFtbElWZTVPRkhDbTFqVHI3SjFpWWlu?=
 =?utf-8?B?bXJ6VEY3ay9aTlNpNy91WjBxY3Y5d1NhSFNZdzJvbk5ZUXpXYmhDZm5BS0V6?=
 =?utf-8?B?OHQwU2lHWmt6VGxDTFU2RXVxVDJQZ0lqOFFqQitrNTFtSGh4ZHJueURmQS9T?=
 =?utf-8?B?cnFRd1BrTjdWVXU1NUdUZlQ3SDhVbXliUHhoZkdqc0NRbmltQUR2WjE1aG9j?=
 =?utf-8?B?eEZ0Q2hiMUZwSWw3Ly9DNHFFdUJZSlZOS3hLa0J1UFh2WURGVlViMDNRbFdB?=
 =?utf-8?B?OFhxVTdYRXEyNHYrNzMwRHhtRGtLWTJ1L2pyY0FiRElWNVh2K00vUS8rQklH?=
 =?utf-8?B?RUpGZk80b0RsOEEyRFBRQzNVNXN0ajdjK2Q2eEhaaE1PUlBTdjhKNFdyOXUr?=
 =?utf-8?B?WXpYM3dJSGs1S292TU56WUNla0czcEI3SThPU3Mwd2x3ZHFWdG5leHBKZ2hi?=
 =?utf-8?Q?xhkKyV+a+lgn4+jiO8Oy9xQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E2AB1FE54C21843BAA3AD9523785D4D@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8629ebd6-658d-4e0d-2cb1-08dc9be202d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 04:30:19.1412 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tV0JKE+rW6cZlrj38mTIWIJE514O31aenVxqCsO23Z9KKuIU6GvPT2TDQrknvCTvXoQ4Ga26ufgYLQ/b35xWb1rGgpNdM4Gkpk3EUGJ0x72d1yUqAzGVqEi5pbHf1MCp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6494
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

DQpPbiAwMy8wNy8yMDI0IDE0OjE0LCBZaSBMaXUgd3JvdGU6DQo+IENhdXRpb246IEV4dGVybmFs
IGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgDQo+IHVubGVz
cyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBj
b250ZW50IA0KPiBpcyBzYWZlLg0KPg0KPg0KPiBPbiAyMDI0LzcvMiAxMzo1MiwgQ0xFTUVOVCBN
QVRISUVVLS1EUklGIHdyb3RlOg0KPj4gRnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xl
bWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+Pg0KPj4gSU9NTVUgaGF2ZSB0byBpbXBs
ZW1lbnQgaW9tbXVfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb24gdG8gc3VwcG9ydCBBVFMuDQo+Pg0K
Pj4gRGV2aWNlcyBjYW4gdXNlIElPTU1VX1RMQl9FTlRSWV9UUkFOU0xBVElPTl9FUlJPUiB0byBj
aGVjayB0aGUgdGxiDQo+PiBlbnRyaWVzIHJldHVybmVkIGJ5IGEgdHJhbnNsYXRpb24gcmVxdWVz
dC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50
Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4+IC0tLQ0KPj4gwqAgaW5jbHVkZS9leGVjL21l
bW9yeS5oIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+IMKgIHN5c3RlbS9tZW1v
cnkuY8KgwqDCoMKgwqDCoCB8IDIwICsrKysrKysrKysrKysrKysrKysrDQo+PiDCoCAyIGZpbGVz
IGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9l
eGVjL21lbW9yeS5oIGIvaW5jbHVkZS9leGVjL21lbW9yeS5oDQo+PiBpbmRleCAwMDNlZTA2NjEw
Li40ODU1NWM4N2M2IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9leGVjL21lbW9yeS5oDQo+PiAr
KysgYi9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgNCj4+IEBAIC0xNDgsNiArMTQ4LDEwIEBAIHN0cnVj
dCBJT01NVVRMQkVudHJ5IHsNCj4+IMKgwqDCoMKgwqAgdWludDMyX3TCoMKgwqDCoMKgwqDCoMKg
IHBhc2lkOw0KPj4gwqAgfTsNCj4+DQo+PiArLyogQ2hlY2sgaWYgYW4gSU9NTVUgVExCIGVudHJ5
IGluZGljYXRlcyBhIHRyYW5zbGF0aW9uIGVycm9yICovDQo+PiArI2RlZmluZSBJT01NVV9UTEJf
RU5UUllfVFJBTlNMQVRJT05fRVJST1IoZW50cnkpICgoKChlbnRyeSktPnBlcm0pICYgDQo+PiBJ
T01NVV9SVykgXA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCA9PSBJT01NVV9OT05FKQ0KPj4gKw0KPj4gwqAgLyoNCj4+IMKgwqAgKiBCaXRtYXAgZm9y
IGRpZmZlcmVudCBJT01NVU5vdGlmaWVyIGNhcGFiaWxpdGllcy4gRWFjaCBub3RpZmllciBjYW4N
Cj4+IMKgwqAgKiByZWdpc3RlciB3aXRoIG9uZSBvciBtdWx0aXBsZSBJT01NVSBOb3RpZmllciBj
YXBhYmlsaXR5IGJpdChzKS4NCj4+IEBAIC01NzEsNiArNTc1LDIwIEBAIHN0cnVjdCBJT01NVU1l
bW9yeVJlZ2lvbkNsYXNzIHsNCj4+IMKgwqDCoMKgwqDCoCBpbnQgKCppb21tdV9zZXRfaW92YV9y
YW5nZXMpKElPTU1VTWVtb3J5UmVnaW9uICppb21tdSwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgR0xpc3Qg
KmlvdmFfcmFuZ2VzLA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBFcnJvciAqKmVycnApOw0KPj4gKw0KPj4g
K8KgwqDCoCAvKioNCj4+ICvCoMKgwqDCoCAqIEBpb21tdV9hdHNfcmVxdWVzdF90cmFuc2xhdGlv
bjoNCj4+ICvCoMKgwqDCoCAqIFRoaXMgbWV0aG9kIG11c3QgYmUgaW1wbGVtZW50ZWQgaWYgdGhl
IElPTU1VIGhhcyBBVFMgZW5hYmxlZA0KPj4gK8KgwqDCoMKgICoNCj4+ICvCoMKgwqDCoCAqIEBz
ZWUgcGNpX2F0c19yZXF1ZXN0X3RyYW5zbGF0aW9uX3Bhc2lkDQo+PiArwqDCoMKgwqAgKi8NCj4+
ICvCoMKgwqAgc3NpemVfdCAoKmlvbW11X2F0c19yZXF1ZXN0X3RyYW5zbGF0aW9uKShJT01NVU1l
bW9yeVJlZ2lvbiAqaW9tbXUsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBi
b29sIHByaXZfcmVxLCBib29sIA0KPj4gZXhlY19yZXEsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBod2FkZHIgYWRkciwgc2l6ZV90IA0KPj4gbGVuZ3RoLA0KPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYm9vbCBub193cml0ZSwNCj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIElPTU1VVExCRW50cnkgKnJlc3VsdCwNCj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemVfdCByZXN1bHRfbGVuZ3RoLA0KPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3QgKmVycl9jb3VudCk7DQo+PiDCoCB9
Ow0KPj4NCj4NCj4gSSdtIG5vdCBxdWl0ZSB1bmRlcnN0YW5kaW5nIHdoeSB0aGUgZXhpc3Rpbmcg
dHJhbnNsYXRlKCkgZG9lcyBub3Qgd29yay4NCj4gQ291bGQgeW91IGVsYWJvcmF0ZT8NCldlIG5l
ZWQgbW9yZSBwYXJhbWV0ZXJzIHRoYW4gd2hhdCB0aGUgZXhpc3RpbmcgdHJhbnNsYXRpb24gZnVu
Y3Rpb24gaGFzLg0KVGhpcyBvbmUgaXMgZGVzaWduZWQgdG8gZ2V0IHRyYW5zbGF0aW9ucyBmb3Ig
YSByYW5nZSBpbnN0ZWFkIG9mIGp1c3QgYSANCnNpbmdsZSBhZGRyZXNzLg0KVGhlIG1haW4gcHVy
cG9zZSBpcyB0byBleHBvc2UgYW4gQVBJIHRoYXQgaGFzIHRoZSBzYW1lIHBhcmFtZXRlcnMgYXMg
YSANClBDSWUgdHJhbnNsYXRpb24gcmVxdWVzdCBtZXNzYWdlDQphbmQgdG8gZ2l2ZSBhbGwgdGhl
IGluZm9ybWF0aW9uIHRoZSBJT01NVSBuZWVkcyB0byBwcm9jZXNzIHRoZSByZXF1ZXN0Lg0KPg0K
Pj4gwqAgdHlwZWRlZiBzdHJ1Y3QgUmFtRGlzY2FyZExpc3RlbmVyIFJhbURpc2NhcmRMaXN0ZW5l
cjsNCj4+IEBAIC0xOTI2LDYgKzE5NDQsMTQgQEAgdm9pZCANCj4+IG1lbW9yeV9yZWdpb25faW9t
bXVfcmVwbGF5KElPTU1VTWVtb3J5UmVnaW9uICppb21tdV9tciwgSU9NTVVOb3RpZmllciANCj4+
ICpuKTsNCj4+IMKgIHZvaWQgbWVtb3J5X3JlZ2lvbl91bnJlZ2lzdGVyX2lvbW11X25vdGlmaWVy
KE1lbW9yeVJlZ2lvbiAqbXIsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBJT01NVU5vdGlmaWVyICpuKTsNCj4+DQo+PiArc3NpemVfdCANCj4+IG1lbW9yeV9yZWdpb25f
aW9tbXVfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb24oSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11X21y
LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYm9vbCBwcml2X3Jl
cSwgYm9vbCANCj4+IGV4ZWNfcmVxLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaHdhZGRyIGFkZHIsIHNpemVfdCANCj4+IGxlbmd0aCwNCj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJvb2wgbm9fd3JpdGUsDQo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJT01NVVRMQkVudHJ5ICpyZXN1bHQsDQo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplX3QgcmVzdWx0X2xlbmd0
aCwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90ICpl
cnJfY291bnQpOw0KPj4gKw0KPj4gwqAgLyoqDQo+PiDCoMKgICogbWVtb3J5X3JlZ2lvbl9pb21t
dV9nZXRfYXR0cjogcmV0dXJuIGFuIElPTU1VIGF0dHIgaWYgZ2V0X2F0dHIoKSBpcw0KPj4gwqDC
oCAqIGRlZmluZWQgb24gdGhlIElPTU1VLg0KPj4gZGlmZiAtLWdpdCBhL3N5c3RlbS9tZW1vcnku
YyBiL3N5c3RlbS9tZW1vcnkuYw0KPj4gaW5kZXggNzRjZDczZWJjNy4uODI2OGRmN2JmNSAxMDA2
NDQNCj4+IC0tLSBhL3N5c3RlbS9tZW1vcnkuYw0KPj4gKysrIGIvc3lzdGVtL21lbW9yeS5jDQo+
PiBAQCAtMjAwNSw2ICsyMDA1LDI2IEBAIHZvaWQgDQo+PiBtZW1vcnlfcmVnaW9uX3VucmVnaXN0
ZXJfaW9tbXVfbm90aWZpZXIoTWVtb3J5UmVnaW9uICptciwNCj4+IMKgwqDCoMKgwqAgbWVtb3J5
X3JlZ2lvbl91cGRhdGVfaW9tbXVfbm90aWZ5X2ZsYWdzKGlvbW11X21yLCBOVUxMKTsNCj4+IMKg
IH0NCj4+DQo+PiArc3NpemVfdCANCj4+IG1lbW9yeV9yZWdpb25faW9tbXVfYXRzX3JlcXVlc3Rf
dHJhbnNsYXRpb24oSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11X21yLA0KPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBib29sIHByaXZfcmVxLA0KPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBib29sIGV4ZWNfcmVx
LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBod2Fk
ZHIgYWRkciwgDQo+PiBzaXplX3QgbGVuZ3RoLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBib29sIG5vX3dyaXRlLA0KPj4gKyBJT01NVVRMQkVudHJ5
ICpyZXN1bHQsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHNpemVfdCANCj4+IHJlc3VsdF9sZW5ndGgsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IA0KPj4gKmVycl9jb3VudCkNCj4+ICt7
DQo+PiArwqDCoMKgIElPTU1VTWVtb3J5UmVnaW9uQ2xhc3MgKmltcmMgPSANCj4+IG1lbW9yeV9y
ZWdpb25fZ2V0X2lvbW11X2NsYXNzX25vY2hlY2soaW9tbXVfbXIpOw0KPj4gKw0KPj4gK8KgwqDC
oCBpZiAoIWltcmMtPmlvbW11X2F0c19yZXF1ZXN0X3RyYW5zbGF0aW9uKSB7DQo+PiArwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIC1FTk9ERVY7DQo+PiArwqDCoMKgIH0NCj4+ICsNCj4+ICvCoMKgwqAg
cmV0dXJuIGltcmMtPmlvbW11X2F0c19yZXF1ZXN0X3RyYW5zbGF0aW9uKGlvbW11X21yLCBwcml2
X3JlcSwgDQo+PiBleGVjX3JlcSwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBhZGRyLCBsZW5ndGgsIA0KPj4gbm9fd3JpdGUsIHJlc3VsdCwNCj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXN1bHRfbGVuZ3RoLCANCj4+IGVycl9jb3VudCk7
DQo+PiArfQ0KPj4gKw0KPj4gwqAgdm9pZCBtZW1vcnlfcmVnaW9uX25vdGlmeV9pb21tdV9vbmUo
SU9NTVVOb3RpZmllciAqbm90aWZpZXIsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJT01NVVRMQkV2
ZW50ICpldmVudCkNCj4+IMKgIHsNCj4NCj4gLS0gDQo+IFJlZ2FyZHMsDQo+IFlpIExpdQ==

