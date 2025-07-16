Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104BBC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 15:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc3kv-0001pr-4L; Wed, 16 Jul 2025 11:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan.milon@eviden.com>)
 id 1uc3Si-00046E-U3
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 10:50:30 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan.milon@eviden.com>)
 id 1uc3Sc-0005PD-5x
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 10:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1752677417; x=1784213417;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=c+nxjIVxv9SejWByjIC24vI2sbHOEEG8d9G2pLDfIbc=;
 b=MrI9JIqVjUBnEMqim2pI9AXIbUHgtf9Cd8K5tt9zCUSqyJUh0VoB3NFl
 jztLn4nQ91OfjIXcJmOe2ZLmYhD4ojcz3MR1H8Y1D5DA39pXrgr2sTO2F
 I0XZnZGv3PxxEpxbn1eddaWh69RaOZ0uugdXTQQvbeShD6mvVd3YOicry
 HtEhgxhxaO4EbHg4R0Xb0M/5KgXvG4TEcUxOsE8aHWoa64XeBGuk8tStq
 yE/NXIF4sNGm9fWGhiN4cfxnrW7U1y+4LaEd3I1IIDUsIYZytU4c3eWSD
 JNMBbqRYqgwTqKkW4YaukHtODVok5lfe7bH1fkRowDV1jLxPjM1+JueK/ g==;
X-CSE-ConnectionGUID: vqtlslK6Ru+qAxOlGMg+qw==
X-CSE-MsgGUID: 92lE43GpTwOZswJmaJoEgQ==
X-IronPort-AV: E=Sophos;i="6.16,316,1744063200"; d="scan'208";a="40415829"
X-MGA-submission: =?us-ascii?q?MDF6ei2dxT6GRSe0p8IaSW5gg1OenUYTS+GMg/?=
 =?us-ascii?q?Lp/3Frkt9GY8Ax/ZPmSlzNeFe7/aSmlqowSEXxWEka/tPPB4ImMf0drl?=
 =?us-ascii?q?vIAyViRdo92Pe47yTCXb7+o61GmCmG4ckP0WW5sfLNETonnZAc062eEa?=
 =?us-ascii?q?l9kNa0PTB2e6vZ4g2duIvmXw=3D=3D?=
Received: from mail-francecentralazon11013050.outbound.protection.outlook.com
 (HELO PA4PR04CU001.outbound.protection.outlook.com) ([40.107.162.50])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 16 Jul 2025 16:50:10 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpjXGnWkjMrouooXdOJ9o9VUHK0oghg9h+JQoh66H+rFrpXywk6em3Wyl8USMrl58RU19YL3QT20IkY+w23qpoB/VY2mcfDufXws/gHOtSrknhjH7mLfNAofhC1n3R+Hj7GgGd3qpOb/K1oMq86FHkWTIytH/TWSv0tyQoV3Tw95lQ67EzzVIgELVYEfIkefNOIs88OKRPKuplG5sVqyS+v5YGbHEXxvHCR5fbAG5qKTZljBQFJ1QXZ3QZOa3bj85vN1Dp/DU/jgmynQraQBIWCZM02eKYv0zNIIDLQT26ZORvyPIIxeEtwgGvNW6Vn9IS4Kz8EdL33FiUe+rS9qug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+nxjIVxv9SejWByjIC24vI2sbHOEEG8d9G2pLDfIbc=;
 b=YlTPj6XXNpy54ijlzpPy+7D00cfbmkw97lUsJLd6/FJXm9UBt32SKHp+vgTUpn2PSYk0NDmc/ZKEIGthMZusUF+3yidQLrYTrBjcs1AyJwCL33QjjdN9xFTNTn1vX1BDAjcsehGlf6qxvUfZZEfEmpcwehHLb7uUhveZLRu0fKLbesmhkBdwKwtAusnsQ9EEqLDbSQbivcze8ovnO07Qg16FgDRk5wiyvD1Kcr2mONt6edZR1Rpjhp+WaWjx/4eSH6D1VAoUIB6P92ntLupEntEwl3ANadEtaNxGbzWjciOjZR+GQolQh4by2e/QPsut8PN7kyf58a9afTqiVbqeTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+nxjIVxv9SejWByjIC24vI2sbHOEEG8d9G2pLDfIbc=;
 b=NFdbHRURTPC5b7J4IbwPv6SrZOc42RR9lkkxRjrfrZQUQJuQfdj5ecr1G6eUBd/Ewkvin/fly0j0lYJYj0O/kA+PsbgjZsSTMGgocJEDTv0Qu3KE/low9ZZXs1RNTBWjDjFqQlWr5rNAXWLmlQkAzlxxVyc3+v+VamGxCytGnIwPF9oOuWM0T+fPBOlLfkNNpiLPmGGKGU8FzmXQ8fyaBPbbKaOQTugQ4xChvSRj25YUOkqZ0Kd08pzsRwVXZltG2FF2yusshjsISl7dhz1roDL5n7ugt21fklB2p8lkyAdRXrWVbxAYfs8XqRIMoWVgtsEk+BinknqpAoZrtVzTuQ==
Received: from VI0PR07MB10776.eurprd07.prod.outlook.com
 (2603:10a6:800:2b4::11) by AS2PR07MB9207.eurprd07.prod.outlook.com
 (2603:10a6:20b:5e9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Wed, 16 Jul
 2025 14:50:07 +0000
Received: from VI0PR07MB10776.eurprd07.prod.outlook.com
 ([fe80::9c6d:5ed3:42c0:6e5]) by VI0PR07MB10776.eurprd07.prod.outlook.com
 ([fe80::9c6d:5ed3:42c0:6e5%4]) with mapi id 15.20.8901.033; Wed, 16 Jul 2025
 14:50:07 +0000
From: Ethan MILON <ethan.milon@eviden.com>
To: Sairaj Kodilkar <sarunkod@amd.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "alejandro.j.jimenez@oracle.com"
 <alejandro.j.jimenez@oracle.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH 5/7] hw/i386/amd_iommu: Fix event log generation
Thread-Topic: [PATCH 5/7] hw/i386/amd_iommu: Fix event log generation
Thread-Index: AQHb9iQrK7htWwmeQEaQp9edVQlkc7Q01Y0A
Date: Wed, 16 Jul 2025 14:50:07 +0000
Message-ID: <82390341-1f20-4154-bff5-2e56b555a934@eviden.com>
References: <20250716073145.915-1-sarunkod@amd.com>
 <20250716073145.915-6-sarunkod@amd.com>
In-Reply-To: <20250716073145.915-6-sarunkod@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR07MB10776:EE_|AS2PR07MB9207:EE_
x-ms-office365-filtering-correlation-id: 5f6d78af-a9bd-461d-3090-08ddc4780ea8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dVlhNm1zTVNMSWFENHlzWUE5R3dMRjlEQU1Tb21JQnFLMUcrUjY0KzVDbjJN?=
 =?utf-8?B?azRzV0R3K0F0WUJoQWVvTm5iNXUvNmo0QmJvQXNzcElrZVRHWWFYazdQa1Jt?=
 =?utf-8?B?L1hYdndkRi9OUXZOVkFqUFJOcElnYkFEVlpHNVQ4RTl3ZW5tWHBZMUtXV01u?=
 =?utf-8?B?UDhxMFdidnpGNS9xNFNzOXlTT2ZHNUUzakFGU1Y5VE03eTltRklhMTM1enJX?=
 =?utf-8?B?bGVjaE5zM0ZaL3Rzek1VRkk2T0MwTGRSeHMrdS9mZEtEcjlTSXd4L2dnTzlm?=
 =?utf-8?B?ZTJLL0Y4WGMyUU9aTGp4QmRhSUNhcW1oeU5OTHlsU2haL1hZTlA1K2g2dWlV?=
 =?utf-8?B?VkJNL01KVEg5OTNTbVFMOUJ0OEVTbFZIcVloSjdib05EMHZrSkJmZVQzakho?=
 =?utf-8?B?S0RSZFZxNkZUU3UxbG1Ib0hBaHlVYjRDajFyMjJWYlhlQlRZKzF2T2o1RzZI?=
 =?utf-8?B?azNxeE9ja3FzU3kzVHhvaktIWDVMdTI3MWNUVmZQRlpTR1FhZVBISmhUZHU3?=
 =?utf-8?B?NkorT0MyVUozbTMzSk5Ob0Yvb3NReTVveWJoMGs0MVB3ZEtaMitPTmRWNWFo?=
 =?utf-8?B?WUZCOUh2eTlJKzl4OWdITzl1QWZPckVHcVBQeHdKdEN5S3hsUEJESVZjU3Nz?=
 =?utf-8?B?a2NpSEhhUW1XT2RyK0JBZFVEMHMyTnhYSnpsaWN5S05DeWlmSjEvUXRTNzln?=
 =?utf-8?B?cDFZTVFlRDNlVExEcHhBTFg5TXR5NWxCa3JUUUNQR1pTMXlqcm5PQmRSc3dn?=
 =?utf-8?B?S3RCNmdSUFp6dFdKcStVNzhVb0owT0lJNnIreUZSTWljNlZ2OS9jSXBtbWVB?=
 =?utf-8?B?Nm92N2pPcTh3eHM3K0Z3dDROaUV0SHdETmx3dDZjK0d0NkNRTk5JUjR6Q0x6?=
 =?utf-8?B?WGcvUTZVaUJrK1VMUlhTRC8wQjVRRjQ0dEJIdFZpb3dBN3RhUzFpekVTT2I4?=
 =?utf-8?B?amVkQ2pVOXh3N1FDR3ZZOXZoY05DcE1ORkUwdllFcVorZUxZZW02Q3dkb21Y?=
 =?utf-8?B?RkVmWmdObSt0c2pzVGpqWFM4WERyR2R5WHNWR1Y1dXNPdzhiZzZ0Wng4dUJS?=
 =?utf-8?B?MXQwbDNabWdUeWtmRGxKa2U4d2I5Z3kxSXRvOUhzMGRiT1lWT0QyVlFvMEhM?=
 =?utf-8?B?RFVFQlowRG90disxZ3JZcHlmelpwVDNpQzZiS0VYOWkza0xrTzFOWUJqWU9o?=
 =?utf-8?B?UzRCYVFoYXM1N2RKNG9Wd0dYUytHL3FDUFNnaU1EM0ZXa3YzWG9GdUJHZGNr?=
 =?utf-8?B?dVpFaFFIMXdMMDdlMjgyUDUzcW0wL3hLcC9id2c2UHFidTlEQ3d1Ym9nQ2xi?=
 =?utf-8?B?anE1QlcxOGdQVEFpT2RFak03NjRDdEhNL3BCSUwwY1Y2SHBYdlZWdUdGRjNk?=
 =?utf-8?B?L1lBcHpROW5qUWxUSTBseGg0eHZ0cGlJT3lnUC8xNy9zN2hZaTcwZFhROUVQ?=
 =?utf-8?B?VlRCZG9ZUWp1SlBua3ZHekJjNUt2ZG0rVmgxS1pOankwc2tjMG94ZEFZTEx2?=
 =?utf-8?B?WGwrZDd1VkZaUVZkdm1iaHlRWm4wT0VYakNOajBOL29FeEhubCtwRmxySG9y?=
 =?utf-8?B?c0xDMllPaXd0R0trWGJ5NzVuOGNyNnJiNHhCQmZoZmZaNk0zVWlOTTB4TXJG?=
 =?utf-8?B?TWIyZXZ4Y2Zydnppb3hyRkFyUm5VdXJWQWtQVjRlYURYU0RCcGJxd2wwTkNk?=
 =?utf-8?B?Q3pYSVhNVFF1YWJNamZFb1pmMGdJNmtZK2FmQW5md3paWTUxMHlvSFN0eDRj?=
 =?utf-8?B?TGJyNWdRL0VpU1l6UGhDazVrV2V5dVM3TnE2enNRZGpLWkY4eUhGT0tweW8y?=
 =?utf-8?B?UC9sSEJMMFc1UnZyT3BGKzlsdng1cFVBQ3JzQ1NoeEoyUTBOcitSZVBUK0Fs?=
 =?utf-8?B?SnFRcUN4bHZMd3lYZk1SVXRPVzF0UEpoLzJLN2FaSWdNWHgwc21TeWRpV0R6?=
 =?utf-8?B?Qy9Tc0pIK1FrQUVUVmpEbndyUXRzdE83M0tYYlFXd1JkZkRHcUtMSEFPRC9J?=
 =?utf-8?B?MUU0SEtRY1BnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR07MB10776.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2l2MTUxaFMyNnIyQmZkMk13dW82amtnMEg5Rzl5OUFEVE5manNWUXRXRUd1?=
 =?utf-8?B?bTQ0bmF5UGZleTYyWGJiUWtyZmwyeFdIZXF5UG9EeHp3Q2F4STNSNkZORFhv?=
 =?utf-8?B?ODdqSTl2Qzk4KzFKZ0Z4eS9wSzBEbWdaVGt4Q0RDOWZpZE4vL2NjSExmSnpl?=
 =?utf-8?B?Q2dYN3FIeFQrblNOUmV3TU9KSG1adDJxNkdYcVV1YU42cUdBbDNTT08vTkVB?=
 =?utf-8?B?aUttcllTUE5Udk05UFRZcStqOGhqVUNMMU0zSHpRSDlDR2lFRG5VektseEVG?=
 =?utf-8?B?SFptdXhOZ21qUXpKeHRMNVpCeW9zZXRMalpKbXNnbER6TUJqN1BGTWNZbFNX?=
 =?utf-8?B?c3krSDkrcUM0dy9FWXo4anJ5a1JLcDNGUW5sTUtOSXBvWHNDb1BQNzN6TmVu?=
 =?utf-8?B?NHZqVzNxWHRFdnRsTU5vODVFazNTL1NUdlRTc01rQzBOazNnTUhoc3NINVp6?=
 =?utf-8?B?bStQOVlvWG9zUEJSQ255b3FWeTg5V1NNNDVpaGpIMVpJRUJsalpMYWZwRkQy?=
 =?utf-8?B?RG9EK3Z3d0dRTjJ0QTgzOWlITGlEOHBuRGxXRmlPaUg3VGRBNnN0Q2tFYUlx?=
 =?utf-8?B?SWp5MHBpOG5nNjFTdnFON1lwdThNaTQ1ajlnanRNNHk0YWk5VGFRNmV2c3V1?=
 =?utf-8?B?bldiVkNJZmhVelBKVWFwNmo3MnVZZHFFbTF4Z0FvbXJoT2gxbzhVbmdwb0Fl?=
 =?utf-8?B?UUpucENaVEo2bXptKzNhSUsrWEJ5K1ZPZkU4VE9ja21NNlEzbjFiSUNZbnRR?=
 =?utf-8?B?ZFNySGM4YnBrT2tpVTBBVlpGeUs3NXhKZXk5aFZweDlyajZOY05uczJxamJP?=
 =?utf-8?B?TXV2dXJPRkNJQ1p4cktKTTdsYndrdHNZRkdzWG9OWDVtU25jYXJERGU0dnEr?=
 =?utf-8?B?WExpUXlHNFZRc2Z4MFI3d2J5dlhHSzFlSkdkK1AwNGRQZDUwRVFjY1pINkhx?=
 =?utf-8?B?MUx3bCtrMGtCN3VUOTd2S2VWNG0vQ3RuMGNLeTl0c3BYajFBUFlNR2RBMTA3?=
 =?utf-8?B?RFJjcEtEWWJLb05LV3RVTlRmbGhzZFpBTzlPRjkxRjJrMUtQWFBld1RWZmN6?=
 =?utf-8?B?dFVPdVFKdDZQcytjU09JbHpGV1NrM0czR1U1MmNRNXRDZ213d2RyMndRZGVK?=
 =?utf-8?B?YVdUNm5VWmZwRG4wNnJxOC9YWVJPOTVqODBtcHFvdWhVWFJzZ2lYcUI1VndT?=
 =?utf-8?B?dE1HL2h1eHdiTi9OakNnRGtZRitPdnBwMDlkNVRoNWZXQklJSUlVN0lEVDlj?=
 =?utf-8?B?cDZuSDB2dHp1ekVOUzZwb2Jtand2OGxBOVp1bVphbWRhWmlXaU0yZkRaeG5m?=
 =?utf-8?B?TGRldnQrQjdQRE9RNG9KanFUL3RYdEtCVUdoWnV1dGZFR0wzQkhXa0J1MHps?=
 =?utf-8?B?Vm4xd1lyNkdCa2graHI0SW41RFFndC9pWUQzL1pvdGVRUmpJNUxZWW8yS0c0?=
 =?utf-8?B?ZGY3cXJiMjB5T2QyVVAybUcvSk5hVlc2ZHVCSUtwbExCaUNFSXgxZ1YzMldD?=
 =?utf-8?B?ZC9lWEpWYTJkZmJHR0lUUlVxakZBSm8ySXlyTXZLb1J6dlJaTDFjV2ZuZEJh?=
 =?utf-8?B?QlZrdGtOQ1hQblhoeXNSNzlRK290ZEtncjNiMW43WFlrcDdvRlliQkdyNmds?=
 =?utf-8?B?czlEckQ0dzVZNWhoTWhBUStweFVrYmxqUHlvWDAzQkNWRUhMTzVZd2s4WC9U?=
 =?utf-8?B?WGZrVmkrYkhtNGtlSC9YRlRLVzFKc3BhTDVPNTJTM241V21iUWFRckxFQVM3?=
 =?utf-8?B?L2h6ZlBKQktzaW5pL1V0NldsUThFdXdIZGNYM0tDT1JvVzJSNEhrN2lqU1pz?=
 =?utf-8?B?aVVscDMvVmlPVWFQUnR2TmRvYUlsVU5QRVJ3UnBRVlkrc1N1UEpQRWlGUFVl?=
 =?utf-8?B?VDB5d2UzZGNhdXUwRlo1djcySFhmS1Y0Nkl6RW5YRktlb3B3NGoxYXhFR1JM?=
 =?utf-8?B?eTdZbXhWLzk0aFdvd2Q4Uk5TMEcyV2daRisrUzFlMXhaa05hZ0lkVUR3STVW?=
 =?utf-8?B?NXl0b3dCNHowbFRXM2NRVVlIMFplM3l1cmdNTVJzelU3Vzk1TW9NWHBDM1Vz?=
 =?utf-8?B?S252Q2ZnNGZXb1dmK1VVVmFENDBSM1AvWS9VSkZQVWtTcDNEZzJqM0huOGJR?=
 =?utf-8?B?LzVkQ2tkcEVzRXQvNHRWSWJOandKUWtKb2M1M2dIS290ekxLSUpkcXRyT25M?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86931122F18E3C4FAA782D6915625D02@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR07MB10776.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6d78af-a9bd-461d-3090-08ddc4780ea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 14:50:07.7340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /aBLcQiMeX5VUUsomGWCYvpcyKLZfSDNqWFPDryvjFWJkw2A0RTGXeUAniptcOJdngJu+0ota/vCzTvQEmAttw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9207
Received-SPF: pass client-ip=80.78.11.83; envelope-from=ethan.milon@eviden.com;
 helo=smarthost2.eviden.com
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

T24gNy8xNi8yNSAwOTozMSwgU2FpcmFqIEtvZGlsa2FyIHdyb3RlOg0KPiBDdXJyZW50IGV2ZW50
IGxvZ2dpbmcgY29kZSBpcyBicm9rZW4sIGJlY2F1c2Ugb2YgZm9sbG93aW5nIGlzc3Vlcw0KPiAN
Cj4gMS4gVGhlIGNvZGUgdXNlcyAnfCcgaW5zdGVhZCBvZiAnJicgdG8gdGVzdCB0aGUgYml0IGZp
ZWxkLCB3aGljaCBjYXVzZXMNCj4gICAgdklPTU1VIHRvIGdlbmVyYXRlIG92ZXJmbG93IGludGVy
cnVwdCBmb3IgZXZlcnkgbG9nIGVudHJ5Lg0KPiAyLiBDb2RlIGRvZXMgbm90IHVwZGF0ZSB0aGUg
ZXZlbnRsb2cgdGFpbCBNTUlPIHJlZ2lzdGVyIGFmdGVyIGFkZGluZyBhbg0KPiAgICBlbnRyeSB0
byB0aGUgYnVmZmVyLCBiZWNhdXNlIG9mIHdoaWNoIGd1ZXN0IGNhbm5vdCBwcm9jZXNzIG5ldw0K
PiAgICBlbnRyaWVzIChhcyBoZWFkID09IHRhaWwgbWVhbnMgYnVmZmVyIGlzIGVtcHR5KS4NCj4g
My4gQ29tcGFyZXMgZXZlbnRsb2cgdGFpbCAod2hpY2ggaXMgYnl0ZSBvZmZzZXQgaW4gdGhlIGJ1
ZmZlcikgdG8NCj4gICAgZXZlbnRsb2cgbGVuZ3RoICh3aGljaCBpcyBudW1iZXIgb2YgbWF4aW11
bSBlbnRyaWVzIGluIHRoZSBidWZmZXIpLg0KPiAgICBUaGlzIGNhdXNlcyB2SU9NTVUgdG8gZ2Vu
ZXJhdGUgb25seSBmaXggbnVtYmVyIG9mIGV2ZW50IGxvZ3MsIGFmdGVyDQo+ICAgIHdoaWNoIGl0
IGtlZXBzIG9uIGdlbmVyYXRpbmcgb3ZlcmZsb3cgaW50ZXJydXB0cywgd2l0aG91dA0KPiAgICBh
Y3R1YWxseSByZXNldHRpbmcgdGhlIGxvZyBidWZmZXIuDQo+IDQuIFVwZGF0ZXMgQ29tV2FpdElu
dCBpbnN0ZWFkIG9mIEV2ZW50TG9nSW50IGJpdGZpZWxkIGluIFN0YXR1cw0KPiAgICByZWdpc3Rl
ci4gR3Vlc3QgY2hlY2tzIHRoaXMgZmllbGQgdG8gc2VlIGlmIHRoZXJlIGFyZSBuZXcgZXZlbnQg
bG9nDQo+ICAgIGVudHJpZXMgaW4gdGhlIGJ1ZmZlci4NCg0KWW91IG1pc3NlZCBvbmUgaXNzdWUs
IHRoZSBoZWFkIGFuZCB0YWlsIHNob3VsZCBiZSByZXNldCB3aGVuIHVwZGF0aW5nDQp0aGUgYmFz
ZSBwb2ludGVyLg0KDQpAQCAtNzA3LDYgKzcxMSwxMCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgYW1k
dmlfaGFuZGxlX2V2dGJhc2Vfd3JpdGUoQU1EVklTdGF0ZSAqcykNCiAgICAgcy0+ZXZ0bG9nID0g
dmFsICYgQU1EVklfTU1JT19FVlRMT0dfQkFTRV9NQVNLOw0KICAgICBzLT5ldnRsb2dfbGVuID0g
MVVMIDw8IChhbWR2aV9yZWFkcShzLCBBTURWSV9NTUlPX0VWVExPR19TSVpFX0JZVEUpDQogICAg
ICAgICAgICAgICAgICAgICAmIEFNRFZJX01NSU9fRVZUTE9HX1NJWkVfTUFTSyk7DQorICAgIC8q
IGNsZWFyIHRhaWwgYW5kIGhlYWQgcG9pbnRlciB0byAwIHdoZW4gZXZlbnQgYmFzZSBpcyB1cGRh
dGVkICovDQorICAgIHMtPmV2dGxvZ190YWlsID0gcy0+ZXZ0bG9nX2hlYWQgPSAwOw0KKyAgICBh
bWR2aV93cml0ZXFfcmF3KHMsIEFNRFZJX01NSU9fRVZFTlRfVEFJTCwgcy0+ZXZ0bG9nX3RhaWwp
Ow0KKyAgICBhbWR2aV93cml0ZXFfcmF3KHMsIEFNRFZJX01NSU9fRVZFTlRfSEVBRCwgcy0+ZXZ0
bG9nX2hlYWQpOw0KIH0NCg0KIHN0YXRpYyBpbmxpbmUgdm9pZCBhbWR2aV9oYW5kbGVfZXZ0dGFp
bF93cml0ZShBTURWSVN0YXRlICpzKQ0KDQpNb3Jlb3ZlciBpbiB0aGUgc3BlYyBhdCAyLjUuMSBF
dmVudCBMb2cgUmVzdGFydCBQcm9jZWR1cmUsIGl0IGlzIA0Kd3JpdHRlbiAiVGhlIElPTU1VIGV2
ZW50IGxvZ2dpbmcgaXMgZGlzYWJsZWQgYWZ0ZXIgc3lzdGVtIHJlc2V0IA0KYW5kIHdoZW4gdGhl
IGV2ZW50IGxvZyBvdmVyZmxvd3MuIg0KU2hvdWxkIHdlIGltcGxlbWVudCB0aGlzIGJlaGF2aW9y
IG9yIHRoZSBvdmVyZmxvdyBmbGFnIGlzIGVub3VnaCA/DQoNCj4gDQo+IEZpeCBhYm92ZSBpc3N1
ZXMsIHNvIHRoYXQgZ3Vlc3QgY2FuIHByb2Nlc3MgZXZlbnQgbG9nIGVudHJpZXMuDQo+IA0KPiBG
aXhlczogZDI5YTA5Y2E2ODQyOCAoImh3L2kzODY6IEludHJvZHVjZSBBTUQgSU9NTVUiKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBTYWlyYWogS29kaWxrYXIgPHNhcnVua29kQGFtZC5jb20+DQo+IFJldmll
d2VkLWJ5OiBWYXNhbnQgSGVnZGUgPHZhc2FudC5oZWdkZUBhbWQuY29tPg0KPiAtLS0NCj4gIGh3
L2kzODYvYW1kX2lvbW11LmMgfCAyMCArKysrKysrKysrKysrKysrLS0tLQ0KPiAgaHcvaTM4Ni9h
bWRfaW9tbXUuaCB8ICAxICsNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2FtZF9pb21tdS5jIGIv
aHcvaTM4Ni9hbWRfaW9tbXUuYw0KPiBpbmRleCBlMGY0MjIwYjhmMjUuLmEzNDA2MjE1MzE5NCAx
MDA2NDQNCj4gLS0tIGEvaHcvaTM4Ni9hbWRfaW9tbXUuYw0KPiArKysgYi9ody9pMzg2L2FtZF9p
b21tdS5jDQo+IEBAIC0xNzIsNyArMTcyLDcgQEAgc3RhdGljIHZvaWQgYW1kdmlfd3JpdGVxKEFN
RFZJU3RhdGUgKnMsIGh3YWRkciBhZGRyLCB1aW50NjRfdCB2YWwpDQo+ICAvKiBPUiBhIDY0LWJp
dCByZWdpc3RlciB3aXRoIGEgNjQtYml0IHZhbHVlICovDQoNCnMvT1IvQU5EDQoNCj4gIHN0YXRp
YyBib29sIGFtZHZpX3Rlc3RfbWFzayhBTURWSVN0YXRlICpzLCBod2FkZHIgYWRkciwgdWludDY0
X3QgdmFsKQ0KPiAgew0KPiAtICAgIHJldHVybiBhbWR2aV9yZWFkcShzLCBhZGRyKSB8IHZhbDsN
Cj4gKyAgICByZXR1cm4gYW1kdmlfcmVhZHEocywgYWRkcikgJiB2YWw7DQo+ICB9DQo+IA0KPiAg
LyogT1IgYSA2NC1iaXQgcmVnaXN0ZXIgd2l0aCBhIDY0LWJpdCB2YWx1ZSBzdG9yaW5nIHJlc3Vs
dCBpbiB0aGUgcmVnaXN0ZXIgKi8NCj4gQEAgLTIwMSwxNiArMjAxLDI2IEBAIHN0YXRpYyB2b2lk
IGFtZHZpX2dlbmVyYXRlX21zaV9pbnRlcnJ1cHQoQU1EVklTdGF0ZSAqcykNCj4gICAgICB9DQo+
ICB9DQo+IA0KPiArc3RhdGljIHVpbnQzMl90IGdldF9uZXh0X2V2ZW50bG9nX2VudHJ5KEFNRFZJ
U3RhdGUgKnMpDQo+ICt7DQo+ICsgICAgdWludDMyX3QgZXZ0bG9nX3NpemUgPSBzLT5ldnRsb2df
bGVuICogQU1EVklfRVZFTlRfTEVOOw0KPiArICAgIHJldHVybiAocy0+ZXZ0bG9nX3RhaWwgKyBB
TURWSV9FVkVOVF9MRU4pICUgZXZ0bG9nX3NpemU7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyB2b2lk
IGFtZHZpX2xvZ19ldmVudChBTURWSVN0YXRlICpzLCB1aW50NjRfdCAqZXZ0KQ0KPiAgew0KPiAr
ICAgIHVpbnQzMl90IGV2dGxvZ190YWlsX25leHQ7DQo+ICsNCj4gICAgICAvKiBldmVudCBsb2dn
aW5nIG5vdCBlbmFibGVkICovDQo+ICAgICAgaWYgKCFzLT5ldnRsb2dfZW5hYmxlZCB8fCBhbWR2
aV90ZXN0X21hc2socywgQU1EVklfTU1JT19TVEFUVVMsDQo+ICAgICAgICAgIEFNRFZJX01NSU9f
U1RBVFVTX0VWVF9PVkYpKSB7DQo+ICAgICAgICAgIHJldHVybjsNCj4gICAgICB9DQo+IA0KPiAr
ICAgIGV2dGxvZ190YWlsX25leHQgPSBnZXRfbmV4dF9ldmVudGxvZ19lbnRyeShzKTsNCj4gKw0K
PiAgICAgIC8qIGV2ZW50IGxvZyBidWZmZXIgZnVsbCAqLw0KPiAtICAgIGlmIChzLT5ldnRsb2df
dGFpbCA+PSBzLT5ldnRsb2dfbGVuKSB7DQo+ICsgICAgaWYgKGV2dGxvZ190YWlsX25leHQgPT0g
cy0+ZXZ0bG9nX2hlYWQpIHsNCj4gICAgICAgICAgYW1kdmlfYXNzaWduX29ycShzLCBBTURWSV9N
TUlPX1NUQVRVUywgQU1EVklfTU1JT19TVEFUVVNfRVZUX09WRik7DQo+ICAgICAgICAgIC8qIGdl
bmVyYXRlIGludGVycnVwdCAqLw0KPiAgICAgICAgICBhbWR2aV9nZW5lcmF0ZV9tc2lfaW50ZXJy
dXB0KHMpOw0KPiBAQCAtMjIyLDggKzIzMiwxMCBAQCBzdGF0aWMgdm9pZCBhbWR2aV9sb2dfZXZl
bnQoQU1EVklTdGF0ZSAqcywgdWludDY0X3QgKmV2dCkNCj4gICAgICAgICAgdHJhY2VfYW1kdmlf
ZXZudGxvZ19mYWlsKHMtPmV2dGxvZywgcy0+ZXZ0bG9nX3RhaWwpOw0KPiAgICAgIH0NCj4gDQo+
IC0gICAgcy0+ZXZ0bG9nX3RhaWwgKz0gQU1EVklfRVZFTlRfTEVOOw0KPiAtICAgIGFtZHZpX2Fz
c2lnbl9vcnEocywgQU1EVklfTU1JT19TVEFUVVMsIEFNRFZJX01NSU9fU1RBVFVTX0NPTVBfSU5U
KTsNCj4gKyAgICBzLT5ldnRsb2dfdGFpbCA9IGV2dGxvZ190YWlsX25leHQ7DQo+ICsgICAgYW1k
dmlfd3JpdGVxKHMsIEFNRFZJX01NSU9fRVZFTlRfVEFJTCwgcy0+ZXZ0bG9nX3RhaWwpOw0KPiAr
DQo+ICsgICAgYW1kdmlfYXNzaWduX29ycShzLCBBTURWSV9NTUlPX1NUQVRVUywgQU1EVklfTU1J
T19TVEFUVVNfRVZFTlRfSU5UKTsNCj4gICAgICBhbWR2aV9nZW5lcmF0ZV9tc2lfaW50ZXJydXB0
KHMpOw0KDQpXZSBzaG91bGQgdGFrZSBpbnRvIGFjY291bnQgdGhlIHMtPmV2dGxvZ19pbnRyIGZs
YWcgYmVmb3JlIGdlbmVyYXRpbmcNCnRoZSBpbnRlcnJ1cHQuDQoNCkFuZCBJIHRoaW5rIHdlIGNv
dWxkIHJlZmFjdG9yIGFtZHZpX2Fzc2lnbl9vcnEgaW5zaWRlDQphbWR2aV9nZW5lcmF0ZV9tc2lf
aW50ZXJydXB0LCBzbyB3ZSBjb3VsZCBkbzoNCmFtZHZpX2dlbmVyYXRlX21zaV9pbnRlcnJ1cHQo
cywgQU1EVklfTU1JT19TVEFUVVNfRVZFTlRfSU5UKTsgZm9yDQpleGFtcGxlLg0KDQpUaGFua3Ms
DQpFdGhhbg0KDQo+ICB9DQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9hbWRfaW9tbXUuaCBi
L2h3L2kzODYvYW1kX2lvbW11LmgNCj4gaW5kZXggNjI2NDFiNzc5Y2EzLi4zZGQ0ZTdlM2U4Yjgg
MTAwNjQ0DQo+IC0tLSBhL2h3L2kzODYvYW1kX2lvbW11LmgNCj4gKysrIGIvaHcvaTM4Ni9hbWRf
aW9tbXUuaA0KPiBAQCAtMTExLDYgKzExMSw3IEBADQo+ICAjZGVmaW5lIEFNRFZJX01NSU9fU1RB
VFVTX0NNREJVRl9SVU4gICgxIDw8IDQpDQo+ICAjZGVmaW5lIEFNRFZJX01NSU9fU1RBVFVTX0VW
VF9SVU4gICAgICgxIDw8IDMpDQo+ICAjZGVmaW5lIEFNRFZJX01NSU9fU1RBVFVTX0NPTVBfSU5U
ICAgICgxIDw8IDIpDQo+ICsjZGVmaW5lIEFNRFZJX01NSU9fU1RBVFVTX0VWRU5UX0lOVCAgICgx
IDw8IDEpDQo+ICAjZGVmaW5lIEFNRFZJX01NSU9fU1RBVFVTX0VWVF9PVkYgICAgICgxIDw8IDAp
DQo+IA0KPiAgI2RlZmluZSBBTURWSV9DTURCVUZfSURfQllURSAgICAgICAgICAgICAgMHgwNw0K
PiAtLQ0KPiAyLjM0LjENCj4gDQo+IA0K

