Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FFCCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 05:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0ZBP-0005xa-4e; Mon, 22 Sep 2025 01:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1v0ZBO-0005xO-2G
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 01:33:50 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1v0ZBL-0003l2-7o
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 01:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1758519227; x=1790055227;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=bhhy0Ja0wODXsuciEHWYS/ka50ToGSWO4TC2X+TqUsU=;
 b=adlge/gH1RlgGz9K+Wdf/wjN+j+w7xVng42o8u4Q9uyChjbhidxyHhLv
 lBGF3FZfmFLK1lv+wqjCFvMgFss7MkmG4aHoFKVUl/SkQEv+MKNldNxqW
 wnGmSkTwOOZt6IzXDeLxV2V8Zv3RYJ2lkCCqlbOYACtzlnV0D0ElDWIV0
 gooG+5RBIWqBaMF429hKekYv4mb94Q3JFokbBM/FXZ2dvBIRH2LeQeqR0
 g0XGhUUWRYHI753lLe8RhZvym3ZaDrWQHsLHcWxZ0AsPfGXAFvjU60W7R
 JOziGlol/pSx2Dn5H2a2om2SCdasiGfTg3BsUsetyOmq+gehHUzhXH1O3 g==;
X-CSE-ConnectionGUID: kUDC8U43SMaqLuo0dXkuzA==
X-CSE-MsgGUID: AwI0EDG1Tt6oASOQyHHzCg==
X-IronPort-AV: E=Sophos;i="6.18,284,1751234400"; d="scan'208";a="43190833"
X-MGA-submission: =?us-ascii?q?MDEwb/CmF6tDkLRatSayeFGc+cqbXKmjLP2kJe?=
 =?us-ascii?q?bj39jUIKFJwIDhm2Vs4+6h7v4w5+tm/QEIpyD1Of4kKihHCaH7y//aHe?=
 =?us-ascii?q?yU0kV51Cot3VXriNBLyrbwnHZtAwZ8jQEBj+/jgRNL80LgPJyPzMV/ax?=
 =?us-ascii?q?QwmV3bd2mgm8X/B2WaWEHsqQ=3D=3D?=
Received: from mail-northeuropeazon11012060.outbound.protection.outlook.com
 (HELO DUZPR83CU001.outbound.protection.outlook.com) ([52.101.66.60])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 22 Sep 2025 07:33:41 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avHp4iaJUhOEzT0Z7gHPXHB/HyLYsZZGxZl1Vngez6iIRLQG9+KIrOfHB6Mz5rnv/NRhG7a7sJrwpGiUtbWEkfacGSLDevrOJWnHHvIPCLqXeJmx6HLn/7+1AKGEU7EKiUk1D8jF1uJt/sUoLvuLtft5BghpDZViUQ4qS3Vh99pjPY8Cq+S0zlpYUuzG58IVGvobxg2CW2VxtvqMwD4T55TZ10EznqivqOEU7KliDFx6DCbGVhgDWMEP9Z+roMsinmlE07ahIbFMyGLEz0R0YjnUuNLg7dokDvwSwL21QZYnzxBLCzUkG2XLZgw3hbTTlG9mj4oiozeeq8VudMVMcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhhy0Ja0wODXsuciEHWYS/ka50ToGSWO4TC2X+TqUsU=;
 b=gUXH2J+06zaV3yh8kwZU7h3YTsvwznl2EH/zpNi1IM8W3JkyoE4hjMNstSBYJ5Ri+q6x+onMt0/uWzhXP+Iqv+0jKrt4FckhLRFocZFv8rn0RE0V3FnH9AMb42BRCzrrFS3JNYHuog+LcFmlYwYq023m3rgBb0x81wN0uCj1PQ1/hVh3Udp6S+dvNOPaMpjgiPUdujE2c/MipZRLHW4F/N5ONgxlg94+CX9z1/I41GdqcsORYaN6dKqldKF4oRYZG2ef6vjF/w+NzGQ902JqBLsp7/yWrpZDhfgQ+p2I1g6d70gSCvcOmWuyLSt4HvdTIth6HP+r0HZ0hdXSgBJFlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhhy0Ja0wODXsuciEHWYS/ka50ToGSWO4TC2X+TqUsU=;
 b=LTxcfYC9EWr8VG5S1dlRjhOZfDUMLJQ9S5p5ER6UYGMNmR79KlXHtFePcvJOwJkEiphcSGvy3uKbRk4eGhXX6kT0Z8CIFiZHdOfVJjKjan05MVeQO5a0o8YjXnZbS+D2phllhDq6Gqz//MSk9MHog0bvJskQkI2ccUrj4d96HmRk1tKJUr51YDpz8BboUai1tE9lIyNwBOj06NPdsZRcVZdVwtYaSYTUyM5N5jAP92JM9BHIakn2VzjuO/3D8NIg7q1Vh63QmCJZbkYQPt0oWUYJ+SBsrZPaWvvnQ4o22tD/3mQM3FK4v61gXC2zQ2P1avk4VSsaHYUwWsULkBEldg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI0PR07MB11492.eurprd07.prod.outlook.com (2603:10a6:800:31e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Mon, 22 Sep
 2025 05:33:36 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%5]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 05:33:36 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "eduardo@habkost.net" <eduardo@habkost.net>,
 "peterx@redhat.com" <peterx@redhat.com>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "anisinha@redhat.com"
 <anisinha@redhat.com>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "santosh.shukla@amd.com" <santosh.shukla@amd.com>, "sarunkod@amd.com"
 <sarunkod@amd.com>, "Wei.Huang2@amd.com" <Wei.Huang2@amd.com>,
 "Ankit.Soni@amd.com" <Ankit.Soni@amd.com>, Ethan MILON
 <pre_ethan.milon@eviden.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "boris.ostrovsky@oracle.com"
 <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v3 21/22] i386/intel-iommu: Move dma_translation to
 x86-iommu
Thread-Topic: [PATCH v3 21/22] i386/intel-iommu: Move dma_translation to
 x86-iommu
Thread-Index: AQHcKa1uS5aSDR0LIk+GdWCQYWRpx7SesUQA
Date: Mon, 22 Sep 2025 05:33:36 +0000
Message-ID: <f97bc435e8ed1c295919350d300068e45ab0bb67.camel@eviden.com>
References: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
 <20250919213515.917111-22-alejandro.j.jimenez@oracle.com>
In-Reply-To: <20250919213515.917111-22-alejandro.j.jimenez@oracle.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI0PR07MB11492:EE_
x-ms-office365-filtering-correlation-id: e0cbc19c-0256-4896-4036-08ddf9999412
x-ld-processed: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?dzhRRkMrUWgvRGV1dmRpbW9yNkFqcURTL2hvS0JGeTJBMHNrZ1NrWUEyRDV6?=
 =?utf-8?B?amxFYW1kZjZPYWFwRUNUWU5TWitEZ29xdmlDVDFTZlVEYUdQUVp1MjcwdkRB?=
 =?utf-8?B?azV3d3lYZWJiQzFYU3ZSd0ZHSkpYUjYvaEYwMUNReHdoOFA2T1J1TTg4Ylda?=
 =?utf-8?B?V3YwNEZJVUdyVlB5OVUzZnVTTU9UUWpYL2c5VWcvKzRRMy9nb0FaTytRYmFl?=
 =?utf-8?B?OU5VT3ZzK1U0T09GT3J4MHQ0OUZkUUtobXgyZ1BGNE55YXhBVWVOWnhpZnVz?=
 =?utf-8?B?b1BOTVZWNkg1cVZpNndGeWthY1R0K1JMOW0rbU5QK3VjYThIcUJvTloxVHd1?=
 =?utf-8?B?SnFxUjhSL3FUNUZoME5oTjJDSFFqdTEwTjFZZlRiM3JZRllxVkpZYk43SXlV?=
 =?utf-8?B?OThVdW9rUEEzeURLOURzZlExS0dSRHNLOC9SNUhFMHNYaVloMFdhWk1KQ1Fq?=
 =?utf-8?B?NWJUUUsyMUJWRUtGelMwRVJMVG1jUnZzYUR1WmVTWi9aRGxtU2x3NkNTOEZD?=
 =?utf-8?B?UkFjbm1mYmJVSnRsSTk5QS8rYnZ6Q0tQSFNWSmFEOG5VSXRscHYyQnduK1pq?=
 =?utf-8?B?a0hqbGh4aHZqMUZEYWtzUGVXNys5TGU0eXRPMnVOTlJTdUpGaXI1WlZGeDhJ?=
 =?utf-8?B?WEJLVGNIQWJoSGRNQzYxekRocFI4dEF2WFFWcDMxRy9VR1lRU0FhWEdGdUJk?=
 =?utf-8?B?RmNicGVOTlF4Wnp3dXR5UGhlMHF2K1doWHpRcFY2dkZaanBYb0RUK3drUC8y?=
 =?utf-8?B?RUZMTFBWVjZjMFVXOERwNVZjK0xhTjdUUHBvMDRpU3dSbGs3OUdKL3IraXly?=
 =?utf-8?B?QU54N0ZmYTVVOURxZG00c2FyeDBRNGVYU3MybDdPdVdOQVBHN2F0Z3RidTQ4?=
 =?utf-8?B?M3ZxU3J5R2g3TzMvcnNLMEY4WGo2ME83VDNlU3NVQmlTWWZsUTBzNWdDc3BU?=
 =?utf-8?B?UGhWL3ZiWGtoc0hFa2EyRjNRY21iTG5JdjdQRytjbXNTaVVra1ZFY1o0YkM2?=
 =?utf-8?B?bmR4b1BKWmVzdmFLUHpLR2o0NlhFamQwWVhoQzBRNW1lWVRQYjBXRW5ibHYx?=
 =?utf-8?B?a0tBT1JWeExSVkRTSkMvMmxvT2o4clpPRUdWOGRUUnBjNWhSWGkvRDNTTTRj?=
 =?utf-8?B?aVB4enhkUHFBUkN2Q2UwamlWZDVudUY3c1ZlZ1VWZDlGZVJWcFJES3pwU0Nh?=
 =?utf-8?B?RFViYkk3Wm5OMzNpT3ZMZFp4WjcycElLYWEvTDVTanNGc3V4SVRBQjlCMTVD?=
 =?utf-8?B?TSs1alBGak5kT0IyTy9WY3l5VkE1WFlyV3o0bU5BempVemFMMlZWVW9YU0M1?=
 =?utf-8?B?Q2NqaGEzYUU5UStiQVRiUTB1d1o5cTNzQ0h0MCs3S3U0V1Zkcm52bEN3TVBv?=
 =?utf-8?B?QXViaVVVdTBXMTh2RzkrRlVvNi90VFl0UlBzNy96L0NvZ2FyRTNTMSt0ekpt?=
 =?utf-8?B?aGowSkI1b3I5T24zV05FS2hid29TSG9BZXlrSnpFdGFYa2swdUFMNUlXRnNE?=
 =?utf-8?B?ZW50bGh0Z1ZWdEhwSEVESUE1MzErNWNzMjZDN1ZTZjRYWmMvUlAzQS96UXlY?=
 =?utf-8?B?b3BIQks2Um9KL01HT0I0U3oxWDQxUlJoaU5Mb3pSclJoWWRNeWprWnJVMVlM?=
 =?utf-8?B?T2thK3VEekRkU3UzcUZMSjFHTFNmNWJZTms4VFJScG9vcktrSCtpaU1pT1FK?=
 =?utf-8?B?M1BqczB5Tm0rb0F5bVZ6L1JmMWNPU05oK1JJSFVsWVVIeUdnRE5DTzdCbnlk?=
 =?utf-8?B?M3lhTHVyWVF2T2RtNFZqVWQvUHQrOVpBeVU2bFliajU5cEV0WGZ1eXJIN245?=
 =?utf-8?B?MnJ2QS9QRXVoODE1TU5CcVRhWnIrM21YMW14UnNsSUd6RSs3cmtSTXBtVmJZ?=
 =?utf-8?B?YlMxL0oySklpWjA5b3BZSkYzVkpPMG80bkpmUEZxM2hKSXpVYUtYZjJyTzE4?=
 =?utf-8?B?SFU2YWVYQjBadDA5TnVIbjgxYmd4MCtrQVFYRUc3SXBXMnROTlJjdEVMaFlz?=
 =?utf-8?Q?Q700p9RQEbAMBF/rOsrgXsW8rb6kyY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UE10S3l0bm9YcFU4bVFSbDBJeFM2anVzUFoyOHRpRjRBUzdRTDFGVENLZnA5?=
 =?utf-8?B?MzJTNU9LODNsNjYrSHhyYUJ2WGR1MmdUdnRvL1VUdDdkelFWaTNHajIwZC9R?=
 =?utf-8?B?cVgwcmlJajEvR1lRT0prZElEaWl6MmVEQ1BqZEw2d0h3a1pVUmhneTgwUTJR?=
 =?utf-8?B?Y0hEOXdrSXR2WXo5NEpPQjN4RXNIOU1ZdHlwckVTaHprcDViZkNjZThWVlhZ?=
 =?utf-8?B?eVppdFFPWWlSRHlWNi9UWG5teXZYNnAwdDQ5RUdnMVdRc3FNSlVSc2VMRzBL?=
 =?utf-8?B?ekMvQ2pqaG1EdzZvVVpJTmIxZFpocFRWNS9TR3dkKzMxL09lOU5kM3VkTkJB?=
 =?utf-8?B?SW0rcFlnZEFwWVBJRUFZamZJMWdsTzNSMXU2NFByVUhwQjlQWDFqR2ZTeDQ1?=
 =?utf-8?B?MjhkV2dtRG11YjJjRUFNVWc5c0pCRjRZWis1SzgwUVF1ZEJvaUxrM280YnE0?=
 =?utf-8?B?UEJjbmlOMTl6RXJac3VYaW5uektLT1l3YUt4ZnVQeHludS9ZMlh2bzQrMjhB?=
 =?utf-8?B?OWVIYlBabFdXdXFMS25EbVdrZCtPOUhhZGVtcWtBRTJTcmpHcTF1TGIwNWJa?=
 =?utf-8?B?TkMybjdCQTQvRVFTakxCWW9tZ00yZlZmbWxSeWEyMW9YTmtjTjdnNm1mUDBL?=
 =?utf-8?B?VWgvZzlyYWR6aWdOaWN4cDE3bUMzeXJnalNKblNUK0ZJeXRMRTJwQlhQaHVt?=
 =?utf-8?B?SzFyS25ZRDBGeFBBbjF3SENYdHFRZ1ZxdU9ScDlKOWMwSDVLeFRFMEpGUlFa?=
 =?utf-8?B?MkVhNGVnQ3NJbnBMYThUeURzajFpU24xbkxHdWRvcTYzQWFIdkVsRXU5SlBm?=
 =?utf-8?B?NDl2VmVMYmdzSnV3clpQNitDWllqN2VzSnd6L3dWdnkwWWVrSUZJZUZXVmFt?=
 =?utf-8?B?aW5PRFc2UFNFbWo4SDY1REhNUDk2dTYvWUJMekVRNjJZNzVic0tlVHplWFgw?=
 =?utf-8?B?SEVLWWE5clVJbmNGVVhUdVVOZWFDb3NyakFsRTVZOFpud2drdUhnWElYRHdI?=
 =?utf-8?B?Tm44U3N4QmNtRnF6RTVRWVZJNVVzaTh4ZzIwQ1ptbjB1RE9SelgwMXdFK3lM?=
 =?utf-8?B?dGp0VlhJdG9JbDRuK3hLeHFJS2tDSTJ3Zis3MnFzdGt3VFlTQmFmeVRoclhP?=
 =?utf-8?B?T3RscXA1L2V1d251NVk3UStONXB2RTFrVmZOaHVBc1VlQjNXWko2QnROT1Ax?=
 =?utf-8?B?Z3lCUnpOS1Q5SlllUm04MWJOZHpIY3R4REdkdy9wbGR2R3NxRlNEbjFxZHhJ?=
 =?utf-8?B?KzhRNUh6K2VTWU9OcDRqYUdTYktWSk9qOWg5b1pYdXRBMDkxa1JtL2htazNu?=
 =?utf-8?B?WjBhaSt6M2RITjQvOWF3aFZMRGRoejhmQzRCUWxybGIxK0RtTEJLbCt6VTRQ?=
 =?utf-8?B?dkpKdlB2anJrQkR4Wnk3U0Z1SjNSNHNIVEZ0SlRJdVMwYmhCQ2V4biswdmow?=
 =?utf-8?B?U0ZmQlVmVGZqdkxCOXpNSEZlTitzN3ZLdEhiclQwOVp1YXo0RFJ0TVVLMWY1?=
 =?utf-8?B?aE5YYjluUGxaY3pMd2d6R01ud0gzRUhRbTRkU3ZsSlVnczJoR2o3dTdGSldx?=
 =?utf-8?B?eHNIR3VzNDdoZVFudDBHbUVYQitSMFhhV2R4dUs5UUs3czZyWkk3b2Z1UjB5?=
 =?utf-8?B?Rlo5ell1T1pUcUp0ME1mSTZIekZpcjJ1N2x1OXh5SE9zbDJFSU1QNEh2RnR2?=
 =?utf-8?B?NW0zbmUxaThZeWNIOTVrWTZuaGV4cWd5VUxyek44R0ZIVGZWT1NPZWw3MWNq?=
 =?utf-8?B?MWU0WUJRUEpSWGdOTnZNbzNXUFdXUXppd1pNYVM4TzZhcmtTaVdhZjNpUkJ4?=
 =?utf-8?B?eWpRQ2NTMFhWTUE2VzN1U21TVU8vV1N1L3Z4NUVJUWdYenQwa21ady9LUy9N?=
 =?utf-8?B?R0M0NVdCVmtxdTZwNllRUzVYV2FZUUk3WnR4ZE93NzRTaVlMdVNQWFk4a0tt?=
 =?utf-8?B?N0w1dkhPQkFaZEhHZ2hYRWZWRHFxWXQvUi9CaktucHl2TTlGbDRHMDVPWkhK?=
 =?utf-8?B?eGtWdlhYcjRIcHZvTGdwQ21kd2I2YVF1Ny9BZWw1MDcxYmhzTkk0VEdLM0ph?=
 =?utf-8?B?RC9IWEVEVk9jeXlQand3MnlJZUdFVUVJSWJpWjRpQ05Ram5kdFZSNjQ4dEFM?=
 =?utf-8?B?SDQ5eDgwTTgzU3RUQzRXemNFMy9WMDhrNk8zb0ZnWGVibmYvdHl1WEVKTmRP?=
 =?utf-8?Q?ANs8ga1Unsb2IJVvoMg3FTw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BBEAE14650AF140BF2729FBF7FE6E0B@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cbc19c-0256-4896-4036-08ddf9999412
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 05:33:36.5792 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TktCKW8GzTOosAOQlyzginX5AtNK1UK8w8/BM2IrQtlp8r1zRfY4kkNKY5+EmuSyb0sbRd1Y0howxNQ5p+tIPvESafwvJqcYTpjKLXO+eCHpv4NCropBHkLXggSsh3fV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB11492
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

T24gRnJpLCAyMDI1LTA5LTE5IGF0IDIxOjM1ICswMDAwLCBBbGVqYW5kcm8gSmltZW5leiB3cm90
ZToNCj4gRnJvbTogSm9hbyBNYXJ0aW5zIDxbam9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbV0obWFp
bHRvOmpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5jb20pPg0KPiANCj4gVG8gYmUgbGF0ZXIgcmV1c2Vk
IGJ5IEFNRCwgbm93IHRoYXQgaXQgc2hhcmVzIHNpbWlsYXIgcHJvcGVydHkuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBKb2FvIE1hcnRpbnMgPFtqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tXShtYWls
dG86am9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbSk+ICANCj4gU2lnbmVkLW9mZi1ieTogQWxlamFu
ZHJvIEppbWVuZXogPFthbGVqYW5kcm8uai5qaW1lbmV6QG9yYWNsZS5jb21dKG1haWx0bzphbGVq
YW5kcm8uai5qaW1lbmV6QG9yYWNsZS5jb20pPiAgDQoNCkhpIEFsZWphbmRybywNCg0KTW9zdCBj
b21taXRzIG1lc3NhZ2VzIGZvciB0aGUgSW50ZWwgSU9NTVUgYXJlIGZvcm1hdHRlZCBsaWtlICJp
bnRlbF9pb21tdTogWFlaIi4gIA0KV2Ugc2hvdWxkIHByb2JhYmx5IHN0aWNrIHRvIHRoYXQuDQoN
Ck90aGVyd2lzZSwgdGhlIGNoYW5nZSBsb29rcyBnb29kIHRvIG1lLg0KDQpUaGFua3MgIA0KY21k
DQoNCj4gLS0tICANCj4gwqBody9pMzg2L2ludGVsX2lvbW11LmPCoMKgwqDCoMKgwqAgfCA1ICsr
LS0tICANCj4gwqBody9pMzg2L3g4Ni1pb21tdS5jwqDCoMKgwqDCoMKgwqDCoCB8IDEgKyAgDQo+
IMKgaW5jbHVkZS9ody9pMzg2L3g4Ni1pb21tdS5oIHwgMSArICANCj4gwqAzIGZpbGVzIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9o
dy9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMgIA0KPiBpbmRleCA4
M2M1ZTQ0NDEzMWEzLi4yYjg0OGQwOTRjZmI3IDEwMDY0NCAgDQo+IC0tLSBhL2h3L2kzODYvaW50
ZWxfaW9tbXUuYyAgDQo+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYyAgDQo+IEBAIC0yNzAx
LDcgKzI3MDEsNyBAQCBzdGF0aWMgdm9pZCB2dGRfaGFuZGxlX2djbWRfd3JpdGUoSW50ZWxJT01N
VVN0YXRlICpzKSAgDQo+IMKgwqDCoMKgIHVpbnQzMl90IGNoYW5nZWQgPSBzdGF0dXMgXiB2YWw7
ICANCj4gwqAgIA0KPiDCoMKgwqDCoCB0cmFjZV92dGRfcmVnX3dyaXRlX2djbWQoc3RhdHVzLCB2
YWwpOyAgDQo+IC3CoMKgwqAgaWYgKChjaGFuZ2VkICYgVlREX0dDTURfVEUpICYmIHMtPmRtYV90
cmFuc2xhdGlvbikgeyAgDQo+ICvCoMKgwqAgaWYgKChjaGFuZ2VkICYgVlREX0dDTURfVEUpICYm
IHg4Nl9pb21tdS0+ZG1hX3RyYW5zbGF0aW9uKSB7ICANCj4gwqDCoMKgwqDCoMKgwqDCoCAvKiBU
cmFuc2xhdGlvbiBlbmFibGUvZGlzYWJsZSAqLyAgDQo+IMKgwqDCoMKgwqDCoMKgwqAgdnRkX2hh
bmRsZV9nY21kX3RlKHMsIHZhbCAmIFZURF9HQ01EX1RFKTsgIA0KPiDCoMKgwqDCoCB9ICANCj4g
QEAgLTM4MzUsNyArMzgzNSw2IEBAIHN0YXRpYyBjb25zdCBQcm9wZXJ0eSB2dGRfcHJvcGVydGll
c1tdID0geyAgDQo+IMKgwqDCoMKgIERFRklORV9QUk9QX0JPT0woInNub29wLWNvbnRyb2wiLCBJ
bnRlbElPTU1VU3RhdGUsIHNub29wX2NvbnRyb2wsIGZhbHNlKSwgIA0KPiDCoMKgwqDCoCBERUZJ
TkVfUFJPUF9CT09MKCJ4LXBhc2lkLW1vZGUiLCBJbnRlbElPTU1VU3RhdGUsIHBhc2lkLCBmYWxz
ZSksICANCj4gwqDCoMKgwqAgREVGSU5FX1BST1BfQk9PTCgiZG1hLWRyYWluIiwgSW50ZWxJT01N
VVN0YXRlLCBkbWFfZHJhaW4sIHRydWUpLCAgDQo+IC3CoMKgwqAgREVGSU5FX1BST1BfQk9PTCgi
ZG1hLXRyYW5zbGF0aW9uIiwgSW50ZWxJT01NVVN0YXRlLCBkbWFfdHJhbnNsYXRpb24sIHRydWUp
LCAgDQo+IMKgwqDCoMKgIERFRklORV9QUk9QX0JPT0woInN0YWxlLXRtIiwgSW50ZWxJT01NVVN0
YXRlLCBzdGFsZV90bSwgZmFsc2UpLCAgDQo+IMKgwqDCoMKgIERFRklORV9QUk9QX0JPT0woImZz
MWdwIiwgSW50ZWxJT01NVVN0YXRlLCBmczFncCwgdHJ1ZSksICANCj4gwqB9OyAgDQo+IEBAIC00
NTUzLDcgKzQ1NTIsNyBAQCBzdGF0aWMgdm9pZCB2dGRfY2FwX2luaXQoSW50ZWxJT01NVVN0YXRl
ICpzKSAgDQo+IMKgwqDCoMKgIGlmIChzLT5kbWFfZHJhaW4pIHsgIA0KPiDCoMKgwqDCoMKgwqDC
oMKgIHMtPmNhcCB8PSBWVERfQ0FQX0RSQUlOOyAgDQo+IMKgwqDCoMKgIH0gIA0KPiAtwqDCoMKg
IGlmIChzLT5kbWFfdHJhbnNsYXRpb24pIHsgIA0KPiArwqDCoMKgIGlmICh4ODZfaW9tbXUtPmRt
YV90cmFuc2xhdGlvbikgeyAgDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocy0+YXdf
Yml0cyA+PSBWVERfSE9TVF9BV18zOUJJVCkgeyAgDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcy0+Y2FwIHw9IFZURF9DQVBfU0FHQVdfMzliaXQ7ICANCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0gIA0KPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni94ODYtaW9t
bXUuYyBiL2h3L2kzODYveDg2LWlvbW11LmMgIA0KPiBpbmRleCBkMzRhNjg0OWY0YWU5Li5jMTI3
YTQ0YmI0YmM4IDEwMDY0NCAgDQo+IC0tLSBhL2h3L2kzODYveDg2LWlvbW11LmMgIA0KPiArKysg
Yi9ody9pMzg2L3g4Ni1pb21tdS5jICANCj4gQEAgLTEzMCw2ICsxMzAsNyBAQCBzdGF0aWMgY29u
c3QgUHJvcGVydHkgeDg2X2lvbW11X3Byb3BlcnRpZXNbXSA9IHsgIA0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnRyX3N1cHBvcnRl
ZCwgT05fT0ZGX0FVVE9fQVVUTyksICANCj4gwqDCoMKgwqAgREVGSU5FX1BST1BfQk9PTCgiZGV2
aWNlLWlvdGxiIiwgWDg2SU9NTVVTdGF0ZSwgZHRfc3VwcG9ydGVkLCBmYWxzZSksICANCj4gwqDC
oMKgwqAgREVGSU5FX1BST1BfQk9PTCgicHQiLCBYODZJT01NVVN0YXRlLCBwdF9zdXBwb3J0ZWQs
IHRydWUpLCAgDQo+ICvCoMKgwqAgREVGSU5FX1BST1BfQk9PTCgiZG1hLXRyYW5zbGF0aW9uIiwg
WDg2SU9NTVVTdGF0ZSwgZG1hX3RyYW5zbGF0aW9uLCB0cnVlKSwgIA0KPiDCoH07ICANCj4gwqAg
IA0KPiDCoHN0YXRpYyB2b2lkIHg4Nl9pb21tdV9jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFz
cywgY29uc3Qgdm9pZCAqZGF0YSkgIA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9pMzg2L3g4
Ni1pb21tdS5oIGIvaW5jbHVkZS9ody9pMzg2L3g4Ni1pb21tdS5oICANCj4gaW5kZXggYmZkMjE2
NDlkMDgzOC4uZTg5ZjU1YTVjMjE1YyAxMDA2NDQgIA0KPiAtLS0gYS9pbmNsdWRlL2h3L2kzODYv
eDg2LWlvbW11LmggIA0KPiArKysgYi9pbmNsdWRlL2h3L2kzODYveDg2LWlvbW11LmggIA0KPiBA
QCAtNjQsNiArNjQsNyBAQCBzdHJ1Y3QgWDg2SU9NTVVTdGF0ZSB7ICANCj4gwqDCoMKgwqAgT25P
ZmZBdXRvIGludHJfc3VwcG9ydGVkO8KgwqAgLyogV2hldGhlciB2SU9NTVUgc3VwcG9ydHMgSVIg
Ki8gIA0KPiDCoMKgwqDCoCBib29sIGR0X3N1cHBvcnRlZDvCoMKgwqDCoMKgwqDCoMKgwqAgLyog
V2hldGhlciB2SU9NTVUgc3VwcG9ydHMgRFQgKi8gIA0KPiDCoMKgwqDCoCBib29sIHB0X3N1cHBv
cnRlZDvCoMKgwqDCoMKgwqDCoMKgwqAgLyogV2hldGhlciB2SU9NTVUgc3VwcG9ydHMgcGFzcy10
aHJvdWdoICovICANCj4gK8KgwqDCoCBib29sIGRtYV90cmFuc2xhdGlvbjvCoMKgwqDCoMKgwqAg
LyogV2hldGhlciB2SU9NTVUgc3VwcG9ydHMgRE1BIHRyYW5zbGF0aW9uICovICANCj4gwqDCoMKg
wqAgUUxJU1RfSEVBRCgsIElFQ19Ob3RpZmllcikgaWVjX25vdGlmaWVyczsgLyogSUVDIG5vdGlm
eSBsaXN0ICovICANCj4gwqB9OyAgDQo+IMKg

