Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855CEC41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOWRk-00083P-Vc; Tue, 02 Jul 2024 01:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRf-00081F-4F
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:51 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRc-0006V4-P1
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719899569; x=1751435569;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=/O+mtv7iGC4Iped3cO7OznRrUDiVe9yyGqDmP9G6CCM=;
 b=XyQziFCtIoMuuuUpCeTJRM0yT+jqKhFl8rVt+ben/u7F2AZzvOOsZtr/
 Jk/4Tn5lNLewMGBrJs42Zb9seuCe6JoLBHZ9XRn36thuwaiEMaTK9krm2
 6iYa3f5xfHH81D7hv0tnNPMifx3QjYw3/Lp3Fl8EBlrY91WVYQQotNG5v
 rt12wxRWtJ3gx+P/46pViJnXVRrEZ8GAqgT9edPWv5//yL1ZkT1y67Xy6
 jtejyEHr20sHCqTi9Q7OWrHTagKDgB6hhfqbdQd3lOezKwzK0JxEQp2tW
 jucGvh6rXafXHi9OCZ55sp3xyNKYEMSBXelj+zrgk2Uo7Uq2QT9gwgbaH A==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208";a="15721603"
X-MGA-submission: =?us-ascii?q?MDEVTH79yo0QbUiM7sydyK2Ls+JqGG2Ug+2kDW?=
 =?us-ascii?q?hAJouLMHpZcfDZkhTVgv70m5tcGaTZbmUcOa8L2bEyTy2QHK6A/FnzsF?=
 =?us-ascii?q?35FMJnyXTml1yJAwj4zzbczbB+7q46dZGc0vej0nDC5fvwuR5gJSdWlC?=
 =?us-ascii?q?p5imytcGYEmD/KmPYn27vK/Q=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 07:52:47 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWqf1KMjqZK9C69zre3tfDqx5PTtQdZ8c/6L5xtphyAJ2XtpnaBA8TuTSYZ92zRQXcRrFxyS9lOw9LkLQbxegGSjoIFRzFxxZ2xPWgpxk0L0mT2kGUROxfIYx10/HA31Key4vqrRbSdG4/2TIH2bRN9VTMfqv6T16ZK2ncx0Flyal0Z4/orMyJun5cQDZxOqbdGJfXhCgOo2bQfNacu5XlCFTAzWwxOO7HWtW64DLla4Gytx3qEIcJ8me7njkimuumBoP3fAEF8XR47D41q4wqf0oRMRCN4DjvCbbgM66T2rWQNP/Cg87IH9exte/h7XuLSzkucpfPikTPDj0yJDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/O+mtv7iGC4Iped3cO7OznRrUDiVe9yyGqDmP9G6CCM=;
 b=JbBiyQvMUy+tBbiv88MosOV6XeR+CTBEvG4AzqHvrHks1FyUYxfdZzv3BTvK4IUmiRnBHUvdHTK1HPRQNjr81pKpf5iUFbUZONjdUiYQGNJsaJULZ/lt9+YOoqLA/aBBOZGogQ5STAqjs88OD7U2c3IPkh/Fk4+rmA+V6kKh0ka8jFVR5X92gJ3NxmwNFpzqf0s0H4N//UhpdhNVhFRJVZFzsalBjKY/HsWnJPfLKxXTws9i5SORSxaZIpzpHDxIeDe19pcoCgnQkw32rsaUgEO7rJme7gjbmdHzQAS4u3TaBTgdQdnTmpsqNcQ+LYpNKDdo6HF3KBwa1LoWxatIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/O+mtv7iGC4Iped3cO7OznRrUDiVe9yyGqDmP9G6CCM=;
 b=qvKBsZcMQKzEoQLQqA+ba24aJADKcvDPQNXtUN5KNhqvVitX7SEUDFGl+aOLVe9vCE3FG/nL1fvgNU/5/Xn6P3S2I0NIXVMPU6fOBOp2EPL2HMWg4jGXQKmmNVW7G1yAVD75q3rs98RCHXImpch6zfbPEd2gDStdElPHYdt3KFbiXbeDB3SgEfZ+8YIse0QHQqz0BhQX0bW2V/f/KzTtE0mzJhYp3MOJ/nSw6BYcsN5fPPhxBco83M0V8FiaJ1KBs/hW7EKSFQR/q74xYXStkRKzt2fKhJ0ZLnN4J7tIFqUYv7A9tRQQA3xY7GXhmDgR7lbJ/N8Ncv7b+fqWNqfLIA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM7PR07MB6215.eurprd07.prod.outlook.com (2603:10a6:20b:13d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.21; Tue, 2 Jul
 2024 05:52:45 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 05:52:45 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 20/22] pci: add a pci-level API for ATS
Thread-Topic: [PATCH ats_vtd v5 20/22] pci: add a pci-level API for ATS
Thread-Index: AQHazEQPZma3+RPBzE6mhYIQQIOAhw==
Date: Tue, 2 Jul 2024 05:52:45 +0000
Message-ID: <20240702055221.1337035-21-clement.mathieu--drif@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM7PR07MB6215:EE_
x-ms-office365-filtering-correlation-id: f8881609-e551-4e79-32c4-08dc9a5b322b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|4022899009|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?aEF6VDc0ZHBFVFE2WmlMRVpOQ284UEw3ancvUU9VZ3pxOHg2Q0Y0UHJLSXdJ?=
 =?utf-8?B?L01RalAxZXlsd3FPdisvazI2bTVCZXFrbWRzZE1VWUdSVUJwS1BKUVFsTHRk?=
 =?utf-8?B?ZndCMVhKWkx4Z1hybmJYVEtIYWpnbUlFNld6L0ZqdmR3NUNxN0xWOU5PWHVD?=
 =?utf-8?B?MGhyRVZDT2RVMFZyeHQ0amVGL0Fla2NtVU5QOTgxTU12MFQ0RCs1MGltUzdm?=
 =?utf-8?B?NHBRL1RtRzVPZ3VycVY3NXpWSGJsbk9xN21JUzBSRkhRR0dQUGNzMVRqMnhk?=
 =?utf-8?B?ejMzOFpqVDlJR0JzdjQwVzJPeTFGdlVuUGlibDNpN043cyt3d2pWMFUrUXNX?=
 =?utf-8?B?NEQ3YlBiUzM5TFlNNHIvNFBGSTJ4NTVyQlNETlk5L0pKbEUra0xqR0NtZ3k3?=
 =?utf-8?B?RFpaVWFjMjNSOUdHZGZmcllIQno3a2k1aWtTbGRMYnpoMW53UmI0T1dBcWVB?=
 =?utf-8?B?NXRXRGZlRTJsSi9ESFh4d0g0L0lLaUVJQlh6cVhXQmdycm40c2FsZ29UTzRp?=
 =?utf-8?B?QXpyZW5taUJNdFVHclRuZHhMaXUzZUVuOXVFanhwcTdqZ2R5UXNFZ0MvU1Jz?=
 =?utf-8?B?MCtIUjMzRXFPcWJVVFh4T2ZsRTZYdFNWT1o4RjVJQ1l5czU1dmtQZTdhWk1D?=
 =?utf-8?B?QjdzZzE3TEVnaXdXZWlPL2VFdE0yR29oQjc4d3laOFR5OVdveFBxNGU3MmFk?=
 =?utf-8?B?d2c4R284RE56bEhQbFZVK0tPNDFhak5wcmhXY0N0ZGFyUTBpcEdGQzAyL2JI?=
 =?utf-8?B?WXdrZStzSkZvR09SUTZ2aGRjRVNJYzhYK3ZtN1VaKzhHbzljYjU4T0NvMExS?=
 =?utf-8?B?Z3dtaU4ya292TU5pay9hL0hnVVFhMTR5VVVTUzB2RFI0Rnd4cXN6MDM4QnJ4?=
 =?utf-8?B?ZTlvUzhzRnR0ZVpCVXpSQVFLdG1QVmg0d0pLSklwM01pKzFyTitzbitXaXJX?=
 =?utf-8?B?ZWVpdzJWdFNwTDBwS2V5MEk3RlBCZTZXVGY2UnlsZytWaE90RDRvb0RESlpL?=
 =?utf-8?B?S1BXQlFmY0tOV0ZvRmhKVHlMWjJKRmNyNmNjTmZxSHYzNWoxY3NZcFd4eVY4?=
 =?utf-8?B?OGk0WDR1a3NROXhvYjhxNVRLdWdWVmdBeGRTcThMbVh4VEhhMHFYMTgrSDUy?=
 =?utf-8?B?UVpNbG9HcEljS25uK09GcDdlVUI1NjBDLzNmak0vd3g2NXNxKzlIY2QyVDM1?=
 =?utf-8?B?Q2szc2tDVlRKNFNlMUxjWEdIY3FQYjBKNTR4bmhpVFFHS2UzbERrejFJOXh4?=
 =?utf-8?B?VDg1bWlhOFR5czk5eWZxSGtxR09SVDh0d1B5OE9tNkJWaG1KSnM3R3c5M3Rl?=
 =?utf-8?B?Z3VlV1p1OWtuOEpDQUZPcFFpemZtY3lYMEdkRkl4OUxhbmxzQ1RIZVc0Vjh4?=
 =?utf-8?B?T2c0NUt1eTdEVWVNMjNMWkZOWXp1Sy93NHpYdC9qWGFXV3ZDMUgyU2psN1BP?=
 =?utf-8?B?K0tHYThHWitiNHJ6UEZaMHAyZEJoQWw0blFpdldKUGx5VzBEaTc3d2VZbjF3?=
 =?utf-8?B?QkczUGFnaGtOeFVkRUs3M1Rrd0ZiemF3S1NuaFMvNUdzbmx2MnBxbkFrZkFi?=
 =?utf-8?B?QXVQOWlmVFdaMVFNSEJnWkF5R3Z6bmlpZkpGdTJGUFM3RFFhS3pYNEttQ0hq?=
 =?utf-8?B?eFB3YmRqNUk0Y3MxT2VkR0ZrNHI2dStkRW1oazY5VDVjNXMwSmwxcW4wT0l2?=
 =?utf-8?B?YmdsaUZPV0dQNmFwMVFHWkIzWTlQcCtmVWI1dHRoclRBQVkxaDZiR3VqVWRh?=
 =?utf-8?B?WHduR2tMcUFxVDEydUoyK3pOR1RkWHpSYjdpRUIrRkFKUHFtbzRCSUJTeFht?=
 =?utf-8?B?dWxPWTR1VTE5RlQ2NW92Tm80VStjaUltY3BiVktqNkJ6aEdweG5rR0owLzRq?=
 =?utf-8?B?L01xNGp5S1lib1FySmtma3A1R3JRRnM2ZjJZODVqd0Z3RkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(4022899009)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTdnbG1NWXA3SWtwR1JlZDgxR0ZtYk5BOXJXTWswRzRNY1VpeGF3N050Umlr?=
 =?utf-8?B?Z2UwWi9SR0VUY2NZOHJ5WXlKcksrOUh0eFRCY0pvL0dGRFVVNWY2dWN1bWlO?=
 =?utf-8?B?OVIrTU01dytsVThhTmRzWTBxY1lYRW81Sk1KTHRLTi9abmw5NW1lQ3JIaFhT?=
 =?utf-8?B?V2JIN1I2VHNuQzMwVTdQUWg0aDA2TjJVeW9jMVkrY1lubkpEN0FNdHFxa2t1?=
 =?utf-8?B?NnVCeDc4T0hWT1Y0ZWd2Qmg4ZStPQ1JuaFNTZGNMYzhHQVRMQnB5VWVGRlNZ?=
 =?utf-8?B?Z1RySktzNVV2R2pheGZ5WWRyam5mUXh0c1hPMEROdHBIc1IwWHM1Q3BYVlly?=
 =?utf-8?B?QTJnTHFxU1E1WFNVdGlmenp5bzI1Qkl4UzJoRkt1MnhaQlBkRFpVVVNodU5h?=
 =?utf-8?B?cWpzcXR5d1RDbzlUVnlIWTUvdERxd2tXMVNzbHV3a09oRnFQRXYwN281djZn?=
 =?utf-8?B?S3dON3JEOTI1ODVFb3FQanJUTGZ2cERrc1NkdUNOS2Q5bGxHaFB4alRyUWNy?=
 =?utf-8?B?UU41b1BUS21EMFVTZ0xLWCt3N0VpV201bUI4M0VEN3NQWVJ2WlJQYU03WitN?=
 =?utf-8?B?MEtRamkyVllWMDB6Ym5tMko4bXBNd1lwUVNxSTAvV05YcldjSVBUdEpkejdR?=
 =?utf-8?B?ZC81TVFpcUJTbDhBSVdTdW9nYytuNGVoQWkraDBHQW5EeXdVYzJyb2xQeFZ4?=
 =?utf-8?B?cXJrdTZaWGJFSEo4aTUzVldua0VZbURWZnQ1a3ZEUzRHdWt2eWFRNWoxVG54?=
 =?utf-8?B?LzJQcjR3WGI5cTJnOXFLMUVzV2tSZCsxRVdOSVNwakJyQVlaeW42ZlBHU1Nu?=
 =?utf-8?B?Y0I4UjNpTUlydW0yR3RrTUZHZlNjTERwVFRHc3VQNFc5djNwT2NoZlVRWGtV?=
 =?utf-8?B?aEt5bTJ3MDVJT1o5cDkybkdvTUQxQmRxOWszdDJaWFhod2tZR1pxcTJudVls?=
 =?utf-8?B?cWhuaFFGNjhtdTNvQnBLTjhFNzMzbVZDV2FGWEExajIxTnRJaTdoYnhLSHhv?=
 =?utf-8?B?T2RPWURNcDRCalArcDFxeUE0OG03S1NlRmllM3ZvcnoydkxzUWtiWnRzZm9C?=
 =?utf-8?B?U2w1QnpHeFcwUnczNitXcFN0SlFYSnhjQ0s5TFM0cXoxTnNzcXZYWUpybDRN?=
 =?utf-8?B?Q1RzYi9hS1QvKzFnKzg0U3hmUktjT0tpVGJjM1ZTWHYxNlhvYmFLQWVTcllV?=
 =?utf-8?B?aVA4K0l5bDdIYTdLTDUyQkoyMEpPYVRkbXExWkdadnFoOVZUZytvVzdIMFJr?=
 =?utf-8?B?VVg5bmVyMFVNM0pPYUd2T2FBT2lpd1gwbGRCeW4vencxdnYrZ04rcDlCMS9Z?=
 =?utf-8?B?UG51aTB4ZG42L08vb3VTOWpYdlZHQXJVZ29oMWliMUEyNlR4eXZNbUllU0lG?=
 =?utf-8?B?bk5tVGg2S2psL0Zlck1aL2hUdko3K09tVG56czY2SG9XLzJ6NGVUL2hlWWJO?=
 =?utf-8?B?T2lwOUF5ZWExZGZEenRNUWtzTDFzYTVCOUNOSGJvTTVtK3ZBQnJneWRFb0NQ?=
 =?utf-8?B?NCtjVE1MNW1GanJBSktzNGtVMTZ2VVViazdLeWtIQ1BSQWNtQnI1bUp6bU9h?=
 =?utf-8?B?c0JrUjE2NjArVDIyUFF6OUJFYk5HZmdBUVA0Q2lIV25haVJhbU1VVjhaYTBk?=
 =?utf-8?B?Uyt3L1lMTFpsZHN4WjQ0d1MyQm5wQnNsM1JXci9Zdy9Cb0xOaFQ5ZkJmSklB?=
 =?utf-8?B?cW9CdGhNQ21vNThjdVVvSWc3a2hPUmVud2diMjI4emNxUTVwM21iQ1dxZ0ts?=
 =?utf-8?B?SjBYK2tySGJnem1kZTI2Q1g1Q1FBaFZ6WjBmYTBabmtmVCszbDdleGs0Q25X?=
 =?utf-8?B?VkN0UU53bFNPcEFHd2ExQTlHOHF0cnFVR1dZSVZSWE00T0Z6ZXladEtGd3BI?=
 =?utf-8?B?KzVrSW03dWNFTnJOZlRJUXZWbTVXanlSQ0llZHIxcXdHQzd2MVBpeWVyRmtv?=
 =?utf-8?B?Q1NRc0lFNDFPTnBpNkJscGxJRWhDSUd5TkgyMXlnQ1lOYkVvbDA1VFBjcmx0?=
 =?utf-8?B?KytGbWErV21oREdURUJxbVVFZmJyOThXNEo2RlpvT0RjeWNVbDRtTitnbWRV?=
 =?utf-8?B?WXZsMGpab0xqUmtvWUd3YlhDSUdNYkRranVYcU9ITm51RERmck83VGpxeDNY?=
 =?utf-8?B?UlhwTEJBMUNEVVRCUmU1NVZ3ZStoOXNWYzY4dm5ZK3VJUW9adnlXVkNlalgr?=
 =?utf-8?Q?jDH/mkTZHjTOIWwTstgKIyI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F75A87E24A24243A16D9647F6509AFB@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8881609-e551-4e79-32c4-08dc9a5b322b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 05:52:45.3700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: azTOQJaY9WjExLgKCkjLxUCQZWCn/g3FEgTCbaG32Jfv5WfJeuc4vN4hX7zRgpaaiXhh3N2baN4aAY34Mvnh6h7P5DtBcRmNzBpmsvaZBGQUQ69SsNwGOuU987vPtesU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6215
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNCkRldmljZXMgaW1wbGVtZW50aW5nIEFUUyBjYW4gc2VuZCB0cmFuc2xhdGlvbiBy
ZXF1ZXN0cyB1c2luZw0KcGNpX2F0c19yZXF1ZXN0X3RyYW5zbGF0aW9uX3Bhc2lkLg0KDQpUaGUg
aW52YWxpZGF0aW9uIGV2ZW50cyBhcmUgc2VudCBiYWNrIHRvIHRoZSBkZXZpY2UgdXNpbmcgdGhl
IGlvbW11DQpub3RpZmllciBtYW5hZ2VkIHdpdGggcGNpX3JlZ2lzdGVyX2lvbW11X3RsYl9ldmVu
dF9ub3RpZmllciBhbmQNCnBjaV91bnJlZ2lzdGVyX2lvbW11X3RsYl9ldmVudF9ub3RpZmllcg0K
DQpTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUt
LWRyaWZAZXZpZGVuLmNvbT4NCi0tLQ0KIGh3L3BjaS9wY2kuYyAgICAgICAgIHwgNDQgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIGluY2x1ZGUvaHcvcGNpL3BjaS5oIHwg
NTIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAyIGZpbGVz
IGNoYW5nZWQsIDk2IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2h3L3BjaS9wY2kuYyBi
L2h3L3BjaS9wY2kuYw0KaW5kZXggN2E0ODNkZDA1ZC4uOTNiODE2YWZmMiAxMDA2NDQNCi0tLSBh
L2h3L3BjaS9wY2kuYw0KKysrIGIvaHcvcGNpL3BjaS5jDQpAQCAtMjgzMyw2ICsyODMzLDUwIEBA
IHZvaWQgcGNpX2RldmljZV91bnNldF9pb21tdV9kZXZpY2UoUENJRGV2aWNlICpkZXYpDQogICAg
IH0NCiB9DQogDQorc3NpemVfdCBwY2lfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb25fcGFzaWQoUENJ
RGV2aWNlICpkZXYsIHVpbnQzMl90IHBhc2lkLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGJvb2wgcHJpdl9yZXEsIGJvb2wgZXhlY19yZXEsDQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHdhZGRyIGFkZHIsIHNpemVfdCBsZW5n
dGgsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBub193
cml0ZSwgSU9NTVVUTEJFbnRyeSAqcmVzdWx0LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHNpemVfdCByZXN1bHRfbGVuZ3RoLA0KKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90ICplcnJfY291bnQpDQorew0KKyAgICBh
c3NlcnQocmVzdWx0X2xlbmd0aCk7DQorICAgIElPTU1VTWVtb3J5UmVnaW9uICppb21tdV9tciA9
IHBjaV9kZXZpY2VfaW9tbXVfbWVtb3J5X3JlZ2lvbl9wYXNpZChkZXYsDQorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcGFzaWQpOw0KKyAgICBpZiAoIWlvbW11X21yIHx8ICFwY2llX2F0c19lbmFibGVkKGRldikp
IHsNCisgICAgICAgIHJldHVybiAtRVBFUk07DQorICAgIH0NCisgICAgcmV0dXJuIG1lbW9yeV9y
ZWdpb25faW9tbXVfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb24oaW9tbXVfbXIsIHByaXZfcmVxLA0K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBl
eGVjX3JlcSwgYWRkciwgbGVuZ3RoLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBub193cml0ZSwgcmVzdWx0LA0KKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXN1bHRfbGVuZ3RoLA0K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBl
cnJfY291bnQpOw0KK30NCisNCitpbnQgcGNpX3JlZ2lzdGVyX2lvbW11X3RsYl9ldmVudF9ub3Rp
ZmllcihQQ0lEZXZpY2UgKmRldiwgdWludDMyX3QgcGFzaWQsDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVOb3RpZmllciAqbikNCit7DQorICAgIElPTU1V
TWVtb3J5UmVnaW9uICppb21tdV9tciA9IHBjaV9kZXZpY2VfaW9tbXVfbWVtb3J5X3JlZ2lvbl9w
YXNpZChkZXYsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcGFzaWQpOw0KKyAgICBpZiAoIWlvbW11X21yKSB7
DQorICAgICAgICByZXR1cm4gLUVQRVJNOw0KKyAgICB9DQorICAgIHJldHVybiBtZW1vcnlfcmVn
aW9uX3JlZ2lzdGVyX2lvbW11X25vdGlmaWVyKE1FTU9SWV9SRUdJT04oaW9tbXVfbXIpLCBuLA0K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmZXJyb3Jf
ZmF0YWwpOw0KK30NCisNCitpbnQgcGNpX3VucmVnaXN0ZXJfaW9tbXVfdGxiX2V2ZW50X25vdGlm
aWVyKFBDSURldmljZSAqZGV2LCB1aW50MzJfdCBwYXNpZCwNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVU5vdGlmaWVyICpuKQ0KK3sNCisgICAgSU9N
TVVNZW1vcnlSZWdpb24gKmlvbW11X21yID0gcGNpX2RldmljZV9pb21tdV9tZW1vcnlfcmVnaW9u
X3Bhc2lkKGRldiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwYXNpZCk7DQorICAgIGlmICghaW9tbXVfbXIp
IHsNCisgICAgICAgIHJldHVybiAtRVBFUk07DQorICAgIH0NCisgICAgbWVtb3J5X3JlZ2lvbl91
bnJlZ2lzdGVyX2lvbW11X25vdGlmaWVyKE1FTU9SWV9SRUdJT04oaW9tbXVfbXIpLCBuKTsNCisg
ICAgcmV0dXJuIDA7DQorfQ0KKw0KIHZvaWQgcGNpX3NldHVwX2lvbW11KFBDSUJ1cyAqYnVzLCBj
b25zdCBQQ0lJT01NVU9wcyAqb3BzLCB2b2lkICpvcGFxdWUpDQogew0KICAgICAvKg0KZGlmZiAt
LWdpdCBhL2luY2x1ZGUvaHcvcGNpL3BjaS5oIGIvaW5jbHVkZS9ody9wY2kvcGNpLmgNCmluZGV4
IGIyYTllZDc3ODIuLmQ2NTZmMjY1NmEgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2h3L3BjaS9wY2ku
aA0KKysrIGIvaW5jbHVkZS9ody9wY2kvcGNpLmgNCkBAIC00NzMsNiArNDczLDU4IEBAIGJvb2wg
cGNpX2lvbW11X2luaXRfaW90bGJfbm90aWZpZXIoUENJRGV2aWNlICpkZXYsIHVpbnQzMl90IHBh
c2lkLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVOb3RpZmllciAq
biwgSU9NTVVOb3RpZnkgZm4sDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2
b2lkICpvcGFxdWUpOw0KIA0KKy8qKg0KKyAqIHBjaV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbl9w
YXNpZDogcGVyZm9ybSBhbiBBVFMgcmVxdWVzdA0KKyAqDQorICogUmV0dXJuIHRoZSBudW1iZXIg
b2YgdHJhbnNsYXRpb25zIHN0b3JlZCBpbiBAcmVzdWx0IGluIGNhc2Ugb2Ygc3VjY2VzcywNCisg
KiBhIG5lZ2F0aXZlIGVycm9yIGNvZGUgb3RoZXJ3aXNlLg0KKyAqIC1FTk9NRU0gaXMgcmV0dXJu
ZWQgd2hlbiB0aGUgcmVzdWx0IGJ1ZmZlciBpcyBub3QgbGFyZ2UgZW5vdWdoIHRvIHN0b3JlDQor
ICogYWxsIHRoZSB0cmFuc2xhdGlvbnMNCisgKg0KKyAqIEBkZXY6IHRoZSBBVFMtY2FwYWJsZSBQ
Q0kgZGV2aWNlDQorICogQHBhc2lkOiB0aGUgcGFzaWQgb2YgdGhlIGFkZHJlc3Mgc3BhY2UgaW4g
d2hpY2ggdGhlIHRyYW5zbGF0aW9uIHdpbGwgYmUgbWFkZQ0KKyAqIEBwcml2X3JlcTogcHJpdmls
ZWdlZCBtb2RlIGJpdCAoUEFTSUQgVExQKQ0KKyAqIEBleGVjX3JlcTogZXhlY3V0ZSByZXF1ZXN0
IGJpdCAoUEFTSUQgVExQKQ0KKyAqIEBhZGRyOiBzdGFydCBhZGRyZXNzIG9mIHRoZSBtZW1vcnkg
cmFuZ2UgdG8gYmUgdHJhbnNsYXRlZA0KKyAqIEBsZW5ndGg6IGxlbmd0aCBvZiB0aGUgbWVtb3J5
IHJhbmdlIGluIGJ5dGVzDQorICogQG5vX3dyaXRlOiByZXF1ZXN0IGEgcmVhZC1vbmx5IGFjY2Vz
cyB0cmFuc2xhdGlvbiAoaWYgc3VwcG9ydGVkIGJ5IHRoZSBJT01NVSkNCisgKiBAcmVzdWx0OiBi
dWZmZXIgaW4gd2hpY2ggdGhlIFRMQiBlbnRyaWVzIHdpbGwgYmUgc3RvcmVkDQorICogQHJlc3Vs
dF9sZW5ndGg6IHJlc3VsdCBidWZmZXIgbGVuZ3RoDQorICogQGVycl9jb3VudDogbnVtYmVyIG9m
IHVudHJhbnNsYXRlZCBzdWJyZWdpb25zDQorICovDQorc3NpemVfdCBwY2lfYXRzX3JlcXVlc3Rf
dHJhbnNsYXRpb25fcGFzaWQoUENJRGV2aWNlICpkZXYsIHVpbnQzMl90IHBhc2lkLA0KKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgcHJpdl9yZXEsIGJvb2wg
ZXhlY19yZXEsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHdh
ZGRyIGFkZHIsIHNpemVfdCBsZW5ndGgsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgYm9vbCBub193cml0ZSwgSU9NTVVUTEJFbnRyeSAqcmVzdWx0LA0KKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVfdCByZXN1bHRfbGVuZ3Ro
LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90ICpl
cnJfY291bnQpOw0KKw0KKy8qKg0KKyAqIHBjaV9yZWdpc3Rlcl9pb21tdV90bGJfZXZlbnRfbm90
aWZpZXI6IHJlZ2lzdGVyIGEgbm90aWZpZXIgZm9yIGNoYW5nZXMgdG8NCisgKiBJT01NVSB0cmFu
c2xhdGlvbiBlbnRyaWVzIGluIGEgc3BlY2lmaWMgYWRkcmVzcyBzcGFjZS4NCisgKg0KKyAqIFJl
dHVybnMgMCBvbiBzdWNjZXNzLCBvciBhIG5lZ2F0aXZlIGVycm5vIG90aGVyd2lzZS4NCisgKg0K
KyAqIEBkZXY6IHRoZSBkZXZpY2UgdGhhdCB3YW50cyB0byBnZXQgbm90aWZpZWQNCisgKiBAcGFz
aWQ6IHRoZSBwYXNpZCBvZiB0aGUgYWRkcmVzcyBzcGFjZSB0byB0cmFjaw0KKyAqIEBuOiB0aGUg
bm90aWZpZXIgdG8gcmVnaXN0ZXINCisgKi8NCitpbnQgcGNpX3JlZ2lzdGVyX2lvbW11X3RsYl9l
dmVudF9ub3RpZmllcihQQ0lEZXZpY2UgKmRldiwgdWludDMyX3QgcGFzaWQsDQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVOb3RpZmllciAqbik7DQorDQor
LyoqDQorICogcGNpX3VucmVnaXN0ZXJfaW9tbXVfdGxiX2V2ZW50X25vdGlmaWVyOiB1bnJlZ2lz
dGVyIGEgbm90aWZpZXIgdGhhdCBoYXMgYmVlbg0KKyAqIHJlZ2lzdGVyZCB3aXRoIHBjaV9yZWdp
c3Rlcl9pb21tdV90bGJfZXZlbnRfbm90aWZpZXINCisgKg0KKyAqIFJldHVybnMgMCBvbiBzdWNj
ZXNzLCBvciBhIG5lZ2F0aXZlIGVycm5vIG90aGVyd2lzZS4NCisgKg0KKyAqIEBkZXY6IHRoZSBk
ZXZpY2UgdGhhdCB3YW50cyB0byB1bnN1YnNjcmliZQ0KKyAqIEBwYXNpZDogdGhlIHBhc2lkIG9m
IHRoZSBhZGRyZXNzIHNwYWNlIHRvIGJlIHVudHJhY2tlZA0KKyAqIEBuOiB0aGUgbm90aWZpZXIg
dG8gdW5yZWdpc3Rlcg0KKyAqLw0KK2ludCBwY2lfdW5yZWdpc3Rlcl9pb21tdV90bGJfZXZlbnRf
bm90aWZpZXIoUENJRGV2aWNlICpkZXYsIHVpbnQzMl90IHBhc2lkLA0KKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVOb3RpZmllciAqbik7DQorDQogLyoq
DQogICogcGNpX3NldHVwX2lvbW11OiBJbml0aWFsaXplIHNwZWNpZmljIElPTU1VIGhhbmRsZXJz
IGZvciBhIFBDSUJ1cw0KICAqDQotLSANCjIuNDUuMg==

