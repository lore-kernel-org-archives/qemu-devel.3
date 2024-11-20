Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62898D6E2BF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 06:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDduP-0007hL-9t; Wed, 20 Nov 2024 01:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tDduM-0007gx-H3
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 01:09:47 -0500
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tDduK-00009e-4B
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 01:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1732082984; x=1763618984;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=8ECMz4ceTl01pOb8/wwKAXNQTWH+/TlefELnpWvPmdE=;
 b=UjGSrbk377ek4OrG3ZQLdap33dCgfPRrm13veX5A10qGnsQYQ4wADU2V
 byEEWNUfwKpVPmqEaFXWXBI9dqkWjm8Ta4yOLQg5NyUFMyjDbKVcIAcbY
 syR5hjTFI32HzjY+Dmgkmoqb15Pb3ECMvul6gpjHnM/+ilY6UGdeGzINV
 9DfsYHZ8KhUxOxdaxecpjKSixT5Undssw7looTU68V/LXFyjuLXqMpWO3
 N96XRUwnUoPvTaOycWvi8azFNHNCowfMgZ1GE8YnOXKlf8gaUAlSzvqu+
 i6Luo4sroJE51L9MFtbGtGm19R2tmZOv+MLqUN+qEQx8u24inn/X/I2do w==;
X-IronPort-AV: E=Sophos;i="6.12,168,1728943200"; d="scan'208";a="25006897"
X-MGA-submission: =?us-ascii?q?MDGgeY703gad8BIpPRvVTJVYqyDxg9lu78dpl6?=
 =?us-ascii?q?2gffnrvufnKEArMeOm+V1qVjGtsvk6995kXnXmzps9yhw5ewDs9x+RLw?=
 =?us-ascii?q?Y74H47cV+P0G3gZtgyfu8mamrnOwwglG8U8JVta5ciUTwL+1zDjBAw8T?=
 =?us-ascii?q?/vySRJbu3ZggsP/4fotARrmA=3D=3D?=
Received: from mail-dbaeur03lp2174.outbound.protection.outlook.com (HELO
 EUR03-DBA-obe.outbound.protection.outlook.com) ([104.47.51.174])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2024 07:09:38 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfMFpOY13PuE0fePEUXoDFOqXBYmDChlSXbmpLB90GJPkZd0Pllst1io6lG1S2itoW3m++5v8qGHj2y0LS30odz1ZA2zmfoKFR+eSJgJv+LF8kczbef0ZauUppcjSqwL7xrefqb9DSkh4DRJN20d8p448V0fvNb2bsQ1rTzvG1caI0A/H2oTlX7VywSF/K0sinbwJ9MGiVqmZKS0S1S92f4ecugvh7oMTf5+pPg285ycsJ+6Gubp4H5OeejJflop7+ODi8sBe6mPcDgjIx6ibLe1ezFXJ9HpsHM3Qcmc0Of4aUohG8TpX2DHsWiFYksA2Zt1tw0HRqs9OMMW/Ga9pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ECMz4ceTl01pOb8/wwKAXNQTWH+/TlefELnpWvPmdE=;
 b=XnaPOM9eHPwr7wYk7f+E2EBZU0Yj2H61PnGcyEWDRa2TpgJS8F5y62ie8WVEx7H4ozIcvHXYhdzhRhHbM4UaBr0ViS3v5N7QazIzEajWWx+ZVS90ptz9diJw5LVuJoR6QUD4WOIO7y9EwEFZ+Vg8XI/4FqaXIut7EKFV+okXy3cd0gnbNrUDX94a3Q0llP8j9xs/f4wcUBt98F+3pMLjwZ0KgGEwK5tLc+Lje3bp0zwlUi+q/FXCUBiKEJuf1MdBOgLerQOC7qmUyZzhIG0XjgImfLJocCFle4sx6YnCswaVGmVBdZqMe7TG0UXMCneKL9EtbXZhtH1a4t8W0qTVYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ECMz4ceTl01pOb8/wwKAXNQTWH+/TlefELnpWvPmdE=;
 b=WOCVckOpwAh3THmRg6PgZqbZGVgCetAapjsNVgQZfPt99L98ZRbs504Wnu2b2fQpyuTKPoQLFDZ3i4ytaTfHM5nIUZBTdXkQCVGrDwFmuscND1HzQLHb7UR6IxDYO1J2oZsNJPrkwTHkArjhm7iDewaSvpkkG6WzTcj1o/S/8MD/i8fdHLjsRbRTjqr6kWqE/fQySr7tsuRD0hN6UlMztFtqbIjH4o9kUyHBXrOGZmoctNfHXHc5pmkAhEIHL6GJAcJgP/PTEyQkNgwR7WdKWgGAqFqFZqyK5309vlp1ib6leXBBF0m0utXQSpQ9x0H6dFVS0Rz0OAdTUU3z2MQhxQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM9PR07MB7089.eurprd07.prod.outlook.com (2603:10a6:20b:2d3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 06:09:35 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 06:09:35 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Igor Mammedov <imammedo@redhat.com>, Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH v5 15/20] tests/acpi: q35: allow DMAR acpi table changes
Thread-Topic: [PATCH v5 15/20] tests/acpi: q35: allow DMAR acpi table changes
Thread-Index: AQHbNBUxFsc+nH9Qp0eiAUj543MGCrK/vVsA
Date: Wed, 20 Nov 2024 06:09:35 +0000
Message-ID: <68a6eeae-b671-4d01-b263-bd5da5801b71@eviden.com>
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
 <20241111083457.2090664-16-zhenzhong.duan@intel.com>
In-Reply-To: <20241111083457.2090664-16-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM9PR07MB7089:EE_
x-ms-office365-filtering-correlation-id: cfc965c8-935c-4128-6403-08dd0929e87b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?cCtsWnl0RkdiOFVMVElNbVZEZXBHN01KMmZZdWRnZE92ZFRaTndua3NFL3p1?=
 =?utf-8?B?enhTa0hGbDY5YkUyT3dtUTNIYUFLSWJ1UXNieXJTTFBERnBLcjlqOEl1S1ZE?=
 =?utf-8?B?ekRKWmJtNFpYNlVtR2JWY29XaDdmK0I4YXdHZTZzMXlMSzdUc3NmRG1Ib2hT?=
 =?utf-8?B?eGJRRDkxaHFMYVN4eWdBM2gxWGJoRE1mYWpnQmZRYUtIaEVtSTJRdm84SGxm?=
 =?utf-8?B?b2F5Vk5kUW92QXNTU1diNHIvMUpYTVp5Tzg1Wi81R1BZSzAyTVNyL01RQnI4?=
 =?utf-8?B?Y04vM3IzSmo1VkhOZFF1UW9BaklaRTUxcnJyY1l5YzMyUlRJczN4YUhRY1l1?=
 =?utf-8?B?V3FOQ2lUYVRMc241MkZUZ1hYakVLVUxZdVJzUXFUWExEN0x2cjNEMjFEOWdS?=
 =?utf-8?B?bk9tV1B4L0hzMi9KbGF1MjcvL1FSLzhycGJUUzlQd3huWkpBUzB6T1dFWmpw?=
 =?utf-8?B?MjNQN1U1T1d1N0FHeXEvV3d6b3N1YzFSMk42N21iOVZwYXM1SjFBWXBIU25H?=
 =?utf-8?B?ZUY1Rk4zdlowYmI3SGdtdEpjM2RHOC93NmJrcEl5dTRhYzFLQ2s2RWh4b25j?=
 =?utf-8?B?UXdCNHhlNVNJUlpnbERlUGlscHNVMmhqUmw2cVExU0JQZWxsem53NjlIeGxT?=
 =?utf-8?B?VENqbVp6M0J4ZmlWTU5rbDVKMmt5TUhwY3h2b0VldFNuS0R5NzRxK0p5aTZH?=
 =?utf-8?B?OHBPWFNqMVNDMkZuT2M0a0Ryc1JGVFNYSkJHc2ZvZDhxR2V3ZHpJTVFjdWhN?=
 =?utf-8?B?V0hyMXU4SUIzMFRqdUdVaUtDRjNmUlRFV0tLalpDaHRlRDJiTGlZQWxINWZC?=
 =?utf-8?B?bzdUdndTUVNOb0JCVTQ2aFVxMDg3VzhKcFBmd0ZoNHIyZ0dubG5XbEs0dmpy?=
 =?utf-8?B?V2dxcDF1MW1XR0lxLzJsQ2VsWXFsbDhFOW5xbTVCZTdiZUlXMEZzYVZXUkU1?=
 =?utf-8?B?VnBTTW9lQ2ZDS2FFWUlMWTRCTHF2bE5IYjd5VkNMOUx0MExtZCs4c0pwUWVY?=
 =?utf-8?B?MjRaRDhZT3RIbFlQUUpldEV4WGl3ZDlPNHRReFFHYXVyV2JheTkyQmRody8x?=
 =?utf-8?B?V0UrVE9PaU9na1JyNWxrYk9tb0RLamErdXBwM0JSVTZuY1pFUnhvdFFKQzRy?=
 =?utf-8?B?ZUZZZzJVTFlaTUdrTTVQT3YwUk43NGpWNzdoWUVlL2FGNlhzZURTNHN4UXBr?=
 =?utf-8?B?VnZDbmJ5OWFaaXYvRlI2d1BCajh1UGU4ZkNzdWxrbFdyWWRGSldmNGcyQU0x?=
 =?utf-8?B?QTRpYkczTGVyaFJXc1hDT2I3eXBHOHlmaDh3OUQ2UkZuTnNmVFZmejhnR1Bm?=
 =?utf-8?B?UHZZbXhISFhtV1JNNjhzQmo3clRDREp6QUt2V3N5c2MrVkx3TGtzWHpxYmFz?=
 =?utf-8?B?bEFZS2R2dFNORld5d3lwV00rZ1E1RisvdlQ3cDcrQklXN2xRT1RtNFJ4VVlS?=
 =?utf-8?B?QmV3Z2NaNHEvUlNDaDJIbElhczdidG5ncjR3UEFzWE5MdUVTTWVlTks5ZjdQ?=
 =?utf-8?B?ODhKUStrbWhsSmVrV3NhTDhNcTR3OWNoeTF0NFVVKzZJcUZkT01Xek9NYW5k?=
 =?utf-8?B?NHpvK0hoRnpJcU52OE1iQVJNM3dUankyTEUzb2NTZW9rcGdPUWdraklKY0xX?=
 =?utf-8?B?VW5CMWlOZlowcEp1UHM4c01GMkNmUWZLNUVid1I4c1drZFVCT0ZKNk5kZXNp?=
 =?utf-8?B?Vmp2VTBZNDRVOEZERTJjWGtVVndRWGFpQWxySWZVb2piRTZ3UzVHQjMrTGkv?=
 =?utf-8?B?cVRvQmlFcnZYbUZxdDhzVG9TMlJwVFNTbkE2MmRib01Ha0NwdlRHdXo3T3N3?=
 =?utf-8?Q?asAUHqAky/z//XJFJRqahHAG2hZylkVCrMk1o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTRIYTUwd0tZV2NGYUJjZVE1TVhxOEtMZHhQTHpacVQ3UW1hbmNIcVRiRVZT?=
 =?utf-8?B?M2xiY2dTSzRTcXp6dFdKL3hEK3JhK1l0QmZ3cklrbzhQT3h2YVZtQjMyYVhl?=
 =?utf-8?B?RkI0cHRXclZWaWtpc1BxZ3hHdkUyREE4TEpvSWMzWTRmOTBwRjJiYVk1QjBm?=
 =?utf-8?B?UWk5dytvWTBldkhwRE92eGxUOEtQb0VVWUh4VjdxQ09wcDc4NlJPWTNmck9T?=
 =?utf-8?B?alQyblFDeVdhSWVFV2JydGpITE15UUIrckN1dGxzTkx0akpsRzA4UStvS1Nr?=
 =?utf-8?B?WFdoMURhNEFIbVV4b1BVK1cxcmMzck81RkNKdGw0ZW9RZ3BuQmNrTWU3aWE1?=
 =?utf-8?B?TWdyUUIrOExPbXovOVV2RURpc0JKWFIvSzhod3lEM3ZJbXdzMTI5RjJ3U1hu?=
 =?utf-8?B?M2Rabk50YXlyelAvME5sZmZqUVlHdTJRQnhjMlhaMXpieVhtV1E2SkErZFdJ?=
 =?utf-8?B?M05oS0I0eC9xWDhPU29nY1g4QUFoT1krVU1QdjN0KytreXZqYzVlVHRKbnNZ?=
 =?utf-8?B?UjVPSTBqYTBsczZONWdKM3pKMG5jdGd2czdoY25iNENSMGh0M2k5U05QZloz?=
 =?utf-8?B?TkcwTk1tWWx6WWtLbnBhbmxvbGtxL2s0SEpjRWQ2RWFqUVNQa2F3dzVuWVpV?=
 =?utf-8?B?MDdKNXNjNEgvY0dJK2ZyOW8xVU1rb3UzenNwTS9tRmxnUklhb2EzUjB3K2h3?=
 =?utf-8?B?bE5zaFNWdnZFdE9sQjRuZ3ZuTlY4eks4OHZUZjhmeWJYZUJpamJsWXpya0VI?=
 =?utf-8?B?cVMyaTlxWmJaVUd0UUdBUTNUbC9BTlJtNXNMWXZjOVJuSGlWenQzTWdqOE9X?=
 =?utf-8?B?RXVGUVlaejRGekhmWENBeGxIWExuR1pnQ0lRZElyejZJeSt6S3RFR0NncXBn?=
 =?utf-8?B?TzJLdGl5SEQ5N3gvM0ZiNGNFL2M2WGxoZUtrdXVuQU9ZdXE2YmN0WUdiNlZD?=
 =?utf-8?B?cUEwRkFhMCtwYzlnejIzTFpGWjV2enhyYk9VNERmN2EzWklSdjhFcTA4Zm1H?=
 =?utf-8?B?RFFSZlRHTERSL3JLSVo1RVV2YWVpNE8wQjN0MW9sb3kreE1lRmZvWHJST1BY?=
 =?utf-8?B?L2dlVVNTcUxIa0pUMmRhcFVjWkVQcVhyMzlEeC84RTlKbDc4eXlzVDIvNWtT?=
 =?utf-8?B?SC9uZGtON3VvbE5qMGtKUWZ4THB6VEgrOXZjQTB5dHAxR2tWNzZ3RXozM1R1?=
 =?utf-8?B?S3hZS1JNZkUzcGNCQzN0TzhLaTF5RjBCUnc0WUIvVW5YUDVzMndFWXd0Ti9W?=
 =?utf-8?B?d1hCZVcrZ1oxNHdiZkc0SDUyUjUrczdHZGpxOWUzSjJzSXg3VmxFYWYvOUtS?=
 =?utf-8?B?UkNFRWw3UlIrLzQ0VkpjVGg0bm5FRVZjdm5hTEFKalJlU3puSzE5OVFNVHZV?=
 =?utf-8?B?Vk45eHJYU3dBQW84UFNTc2gzclFvVEdoVlRLMW9jNnhabDZnMUhKSzBYWVAw?=
 =?utf-8?B?UjdPenZJZUdsR0c3Z3lNVjNBL2gvK1dlNzBMTjZPS0FEQXp6aW55RjBwT2xo?=
 =?utf-8?B?T3h6dWJPTEZrZGJvSWFhdCs2UldGa0dYZ0dCU1dIREVNUzFjaVd6UktmbmQx?=
 =?utf-8?B?bThseEVveGRzR2o3ZUFDWEExSWlsQXhPRERCbTdpbm9PM1Y4cDVqSVpiWG1T?=
 =?utf-8?B?VWo5TkM4T1R0VUIxR0IwNUtlc2ZOdWtrWXFkMnRHU2FJSzVBOTdOWDlEN3cr?=
 =?utf-8?B?azlsZVRlS2N2RnZJeWlTbkNpR2Jiek9HSHRwYkZkMkNmM21KYlErMjVielZ1?=
 =?utf-8?B?bFhvS2k3bXJtT2lLWkVtV1dpZ3RSRmN1ZDZqd25aWEo5QmRjMGZ4V0p4N1Iy?=
 =?utf-8?B?WkV5ckY2SDE5UDhPQjRCY21aWlhiVlk1SW1QQTk5UElJdDE2QXA2eGlwN2xy?=
 =?utf-8?B?ZEhBY0IxNWk3dHhBVHlxYTJzbnNkanJjbWNKd1BKWENpL01IVk5FRzN4STYv?=
 =?utf-8?B?TEhTRFVTZTRybGR1ZXlLcFY4SitnaEJoMk02ZWNMVUQvdG9PQnN2dlJscVo2?=
 =?utf-8?B?aWJFZTgvem9tb1NBeWNvZE1yYTFnZGttTDlWSUdhYk9Iek1iOEdQeVoyOGhQ?=
 =?utf-8?B?VlRaQk1LTHlNVFVjRE5zR2RoNlFURlZnc05qL3loNEUrUDBkWU5MOWZNamR2?=
 =?utf-8?B?cFIxTk85TW00R2hyejFvaldDN3RpdXdkWmJBZzJ4RSsrMjNRbzByWGpidGpB?=
 =?utf-8?Q?+tqU9jRYU8vF5GIETkmoa9k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AC3047C85DD8A40A403011E6299C556@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc965c8-935c-4128-6403-08dd0929e87b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 06:09:35.4557 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hhDc/WZoBlA34HMnmGh4urnBUOJmSrPfNudC4Zqrn/64FVI1sNr2RT7l6KGyeHgwpunoa9w4vCMYGuLBe2/4/tHt1gZiMd0IXfRHENJmTGuRzzzIMzZ6zRtG2oELeViP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7089
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

SGksDQoNCkBNaWNoYWVsLCBhcmUgdGhpcyBwYXRjaCBhbmQgcGF0Y2ggMTcvMjAgb2sgZm9yIHlv
dT8NCg0KVGhhbmtzLA0KY21kDQoNCg0KT24gMTEvMTEvMjAyNCAwOTozNCwgWmhlbnpob25nIER1
YW4gd3JvdGU6DQo+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2ht
ZW50cyBvciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3du
IHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4gU2lnbmVk
LW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4gLS0t
DQo+ICAgdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdC1hbGxvd2VkLWRpZmYuaCB8IDEgKw0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvdGVz
dHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdC1hbGxvd2VkLWRpZmYuaCBiL3Rlc3RzL3F0ZXN0L2Jp
b3MtdGFibGVzLXRlc3QtYWxsb3dlZC1kaWZmLmgNCj4gaW5kZXggZGZiODUyM2M4Yi4uNDZmODBi
ZTljYSAxMDA2NDQNCj4gLS0tIGEvdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdC1hbGxvd2Vk
LWRpZmYuaA0KPiArKysgYi90ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LWFsbG93ZWQtZGlm
Zi5oDQo+IEBAIC0xICsxLDIgQEANCj4gICAvKiBMaXN0IG9mIGNvbW1hLXNlcGFyYXRlZCBjaGFu
Z2VkIEFNTCBmaWxlcyB0byBpZ25vcmUgKi8NCj4gKyJ0ZXN0cy9kYXRhL2FjcGkveDg2L3EzNS9E
TUFSLmRtYXIiLA0KPiAtLQ0KPiAyLjM0LjENCj4NCg==

