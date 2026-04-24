Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FD6FB44C8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBXv-0005DH-2Z; Fri, 24 Apr 2026 04:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXm-00055M-Ij; Fri, 24 Apr 2026 04:05:47 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXi-0001GV-3h; Fri, 24 Apr 2026 04:05:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnuGLXr58QZdkj5/j8rCk1FsVHp4EYyDTG3AE2wZY0CIe1GeggobqfOg5tqE1Wi5FhmvQZL71Oyh+P9KSSg9MSipBvzT0vhvjL82mrvLonLb0aykoO0YApkRsgEljis0qpo1e6tEIQmmTU4dj8OhQOHqDnof8rKjaDpm4Eb56/I0/qM9flanFt0DkrgXrLW9YBOTJu/flN4p2+kDKf6GS9PfPYxJCf+kUt9QgpQx7yO+LPHN2eMYMQdFvcyCOe9YA8qQqgO3oLTA8m3y9c1KszFXv5n3zQlk6OR+5aEM2W/WUdtvE88I/uwIFAWb49RKIrRKr5rUzCVImUxDezY9rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdCqqwgGyyJ6ZpatzPh1q47FdstaGy6eGso1RaGeAJ8=;
 b=hoPkrUhHpbT+FV7z7schptVJYFna9BzM2Q6TXRIk/g4YOdU6ADH5sKrFWdX8hPrCdzMYRu/L/2QYqbdzlmoLOxdwdB4ot492plEB7l56KnAiQahohZnGYfbOihFBc+W9mdb3bEmhDqtnu2xujn4eMudVgDLe+T2MhMXLj7vB8XvCI/sfLkSVFRCihpPNI0CoLL3cbN/Amm2N7e2pfAhaJhYO2iesVm4B8H9xyZASPr6Nqn63jhwYKE2W58FnDRpJl2q3Y5ZbMu5aR2RP4zjTiN49rtTUH/AjV8Y8I+vcrSW70q4TAX5FN366HDIgT86nqYN9cuB1A2KKjxLJFKoowQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdCqqwgGyyJ6ZpatzPh1q47FdstaGy6eGso1RaGeAJ8=;
 b=UFjn81ZzU7o4++bL7yhnDU+VtJr/05ykdVf5plUnt6p2Hb97FDT4DfO1ZhocPjgLKiibyAPmKfW4XRsC7SsgBCPCH4gof7yJoI5kBUi0vI+gd9hZaPHK5tyYZCopPrSjDEqRqDLSZnjNM75V9rraD/XKhgn0TCWlSIeKXpKQiFbLTdxZU74zaAEq2ho54rXQhL9b/mQC10xSPvLZg6Iay1nfdAEaPfyA0C3TOuGbdzQB4WIxOaqVRZaeFyT+iLvcBnhPpsXV3nGyslnx9r4CzO6eXn3HakEPwSqKJUNExdAFSMbwieayOTgbQMB4lVWkTya7xyEF3Bosjws88Z4r+A==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5856.apcprd06.prod.outlook.com (2603:1096:101:9e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Fri, 24 Apr
 2026 08:05:27 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 08:05:27 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "peterx@redhat.com" <peterx@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>,
 "open list:S390 Virtio-ccw" <qemu-s390x@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v5 13/18] hw/usb/hcd-ehci: Implement 64-bit iTD descriptor
 addressing
Thread-Topic: [PATCH v5 13/18] hw/usb/hcd-ehci: Implement 64-bit iTD
 descriptor addressing
Thread-Index: AQHc08EcF0LpWa9940qoIDvEhKbrDg==
Date: Fri, 24 Apr 2026 08:05:27 +0000
Message-ID: <20260424080508.53992-14-jamin_lin@aspeedtech.com>
References: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5856:EE_
x-ms-office365-filtering-correlation-id: ea9ca9df-e575-4842-134a-08dea1d83ecd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: R46INCzcGzhteCnyVzCMNe9gUMGUxTGl6wAMr/FetdbzStsENjRWObMhbvDaUn/C7Mra1fiifF3Riq/OSgYXMjJYLL8PkyukgwcBCkTWxhsyF+T4eB8BvcfjHK+7KOo3YJrPuBLRjpKA3We8fM4AEQ7QXKnXeqA8jM/YNhNrgFVo9bzLxLX5A6pJcfTi7TULfS0+rpchMEE7+J+G/9hnGr4NG/FFCvOm1CBLRkX12tF8zMIri1NG7mQNat6VZxV90IqDAUS+m31wIljQ5CImBkYdVqM1VmBoAipQHOOZN5quEreGOpQ1r/f2096rvVtAnfJncRS7nG1S/36n2ljT95zFBNFoXQ5xSx3SqhW25en/tfMpaDEUKJeomh1V3HFK+rnkMT1Jja/P+dedMevCZw/zW5PL16qwZpLzIxJqo9SJMFnS/QbJ17cKAw1UwLBGcPJe5nDqhb9zZ+jbsOwDCJry3LxW+cHfRbyMrxLDQFfM2bxJj4KI1uHAnnl2IHMnIQZwilSz8aGHhfIkLNH4lLxPh6LD1PjoGQjOMtZkT3nEA46XLSwX9F1KfRgKUPuvCK0ho02WUoOGohUZn+4/L0J9UYD0kBuJcabHS5NLdwMLRuBcoml4eDqtcSgMeRUmRfj+YcvfX1etiE/AWB+DNitr9DSH4wNefkWbQwtet5eNdQ/NdxfBTl8jMhGHEguCgdJf4VacyCoQWmTRhwSF2owMmxYNN57yJwkuG0P0VVZYhIgWfHmoorHZ6YYbZ5uFop52dMS+nMa9lBvUJyIMI+VZICogfCZqLYsX2fZs0e3c48zBmvnfu833jVnbdk87
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8GKOsNJfqBjqtWrk1TU2uTz78xsHdbc8t1QuNl2sEhGzTEWYLE3gGgFA9F?=
 =?iso-8859-1?Q?WjxcO7J8zLOUcCOfSXq0zqdSRUn9Kxjm5aQYxaryxmBpEqLisdPs+roprf?=
 =?iso-8859-1?Q?i2GCtPUHcfNDiSm4t1xjtuz5SOdcJQ/Boa9UpSOsY9laP48uV3mpSpqluk?=
 =?iso-8859-1?Q?2x5IOhGMZzaGQQYXqQbJkTQRkcxN50r1yv++LmwzaessVy0yTZ65Tq8o6E?=
 =?iso-8859-1?Q?S53ihMNEU414NoWYS0UVB6ptWzosJYMX5s4WXA+avMRyvFIAL+TCbf96oI?=
 =?iso-8859-1?Q?8rebY8V/WaDGXkzW0q0+oRoe62mcNEZUk54x3xVox/EtImSIdYOCMRq8dD?=
 =?iso-8859-1?Q?8xdAYkMNLuaxk9/7J/WZEmxxjH80xuUCR8Rzv/Mdn19j5CmlojQWcaC8q7?=
 =?iso-8859-1?Q?7FGzA2k8nS7kodMHf0eK4mOp7C1jOCGFH4J48mt3D4AZ5wQxeSd5ptHKMg?=
 =?iso-8859-1?Q?WFNlWxAQa6qNsl0jMG4I68lSwRj6qcg5nKUG2iaU7uCHku6Z9E4eVjGNDC?=
 =?iso-8859-1?Q?u/f+wuANL+GN6TXv33jDEMtVr1P1EqPPpefjLlLFfyCdV4zYOjNbdBRj4P?=
 =?iso-8859-1?Q?zZkCxbOLMwsa9JD+UZOM1xJzPUbvrn/YgLaDYNXZJp9DLJ6OVcv028jBQ+?=
 =?iso-8859-1?Q?3I3bT9Mc+wQvHJwS6ZwWeUT4yLdHmgjjk7ptWgKUdJNG/vZSrXDsj0BOkw?=
 =?iso-8859-1?Q?Gn2jS7Uq25YBMRy8ZC7SxIVcsWAlgZ8NS9CVFgwEItbSDnQ0KXAZv1EfFb?=
 =?iso-8859-1?Q?J4OHccl14bEQLga5+07LI/sh55ZZ1vosJ+N8h/SUSAaqdqRh4bASGPIxVR?=
 =?iso-8859-1?Q?/evpzB5RzfZPCCJhenCqhS6xDd9a9WudDztF6/s3jWZ7bdX/LAZFB4F6Wb?=
 =?iso-8859-1?Q?Xdraf4iXQtquV9JtqW3sx1wj6Ek+icx13ply0G3EYi5zv+LgdK17tdWHnP?=
 =?iso-8859-1?Q?Y76y2eN1IOf/j70Wzfo8ZrYOz6UHnxj9KOIQ8tvtnrRmSnQ8M4bB/w9dYc?=
 =?iso-8859-1?Q?S/wsj0ZeFXG2uLSbiDRUyHXwYBJHDGSiqe8QHMcDbhCKo6VaTWaW88Uasn?=
 =?iso-8859-1?Q?6N+ADKIv2yNPri3ppFGthRRl7jHURv/neP8nBK1f+sI1pKPtZcMB9Olz3b?=
 =?iso-8859-1?Q?iP8LJAwS3TRsQ1LcNNDkftdNyyGpKsOXfpB6lG6QdhIq/4Q0sp4gC6CLdE?=
 =?iso-8859-1?Q?rOCetecQcoGNBNW7FAk+KWNxCpQMcxWVHc8S5QYhje6VORlKGQVy87mJgK?=
 =?iso-8859-1?Q?+EFtcsSBfOHMIgnchwm3JM3u1JaopI0Us0c9olc7kAlps98S4JeUxWzsXN?=
 =?iso-8859-1?Q?mRFhHG41ITE7JpBMGHnSovYCtVpI1WQmUzseFKN87qmkr0BuWGsf1/SC0o?=
 =?iso-8859-1?Q?d0kGU50o2Lld/xTWl9v3h6ojIWFZfdhl02ms2zXN/Nx7Td1pqFDG1UpbhT?=
 =?iso-8859-1?Q?qCKSzXcwWwkAkg7dry1VS+Le2PzMT/ux23bPbNlG7eAxRhiwGeS13BEGM0?=
 =?iso-8859-1?Q?0YLVMWaibTUB7/fhmK5hCtOp7FvJcZ2rbnY0CgDx0+gX8AK5L7eM/FpF+w?=
 =?iso-8859-1?Q?+g0lxzoldePEnR5LUTa/1+04kZluow1tE3/cTSaCEf+Lu284QZMWc4mfao?=
 =?iso-8859-1?Q?HVX1QTdI3R8z6yEZPQVyzT18fEUUd3bAtPSc28EQnn/XsoeYMNKPXnkRDM?=
 =?iso-8859-1?Q?gMJCpIel9qIpqolPqpEhVKqwkAinFlGz1r3Fe/vd5hm6sUyrLY2HsRkujP?=
 =?iso-8859-1?Q?T0YZt4RpT/swkzVpU3H9EGgmnLDaR0/zT/kozDpGZOB382rzoQzJ6G0cUQ?=
 =?iso-8859-1?Q?03YCcDZE9g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hoZ699vrHd64UxKaRPkEqYKgInxNfqI82VivjpqmT+JdNk9FP67kN1lgeSpB8YLMuJq0Z1vWGsUT+QNOkKUo2BqNGjtkP+cuOKVui1Y/4qip5jubEjQqD6rdfAIu92LmFVv7TGjS2THcNwZg+0yAEKEIcsHGIYiqbob1kYEFtexV7o1l0sWjoFPvMMw3i+121LXTS/ZKJWclOGRrGdbfG60vg58OcJ1tN3oJnAKSrtrvEOoIhow83GL4UykmWst1u1gOI0/IeYH/VA/09w1OAvlPWjtKZbFcxkLT2ZEBgN6hWzTbwNMl279ZZmv/pq6BKdRnkDlZNLxgO9rdsO80jw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9ca9df-e575-4842-134a-08dea1d83ecd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 08:05:27.1585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /pyUCQHypZdAp/9MXOR9TxuJSWGtcy8Z8LwCdqV5EHh/aJQNfX9ZwzgTwNaR1bXTU9fKClf8J3p54utOMuIGfdsyT10s3F2iUAynUeKe8+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5856
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

EHCI supports 64-bit control data structure addressing when the=0A=
64-bit Addressing Capability bit in HCCPARAMS is set. In that mode,=0A=
the CTRLDSSEGMENT register provides the upper 32 bits that are=0A=
concatenated with 32-bit link pointer values to form full 64-bit=0A=
descriptor addresses (EHCI 1.0, section 2.3.5 and Appendix B).=0A=
=0A=
iTD link pointers are stored as 32-bit values and must be expanded=0A=
to full 64-bit descriptor addresses when 64-bit mode is enabled.=0A=
Update the iTD traversal path to use ehci_get_desc_addr() when=0A=
following link pointers.=0A=
=0A=
Appendix B also defines high dword fields for iTD buffer pointers.=0A=
Add bufptr_hi[7] to EHCIitd and use ehci_get_buf_addr() to construct=0A=
full 64-bit buffer addresses from bufptr[] and bufptr_hi[] fields=0A=
when processing isochronous transfers. This allows buffers above=0A=
4GB to be handled correctly.=0A=
=0A=
When 64-bit capability is disabled, descriptor and buffer addresses=0A=
remain 32-bit and existing behaviour is unchanged.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/usb/hcd-ehci.h | 1 +=0A=
 hw/usb/hcd-ehci.c | 9 ++++++---=0A=
 2 files changed, 7 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index fc66aacd9f..8e6a8cdfb0 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -63,6 +63,7 @@ typedef struct EHCIitd {=0A=
 #define ITD_BUFPTR_MAXPKT_SH     0=0A=
 #define ITD_BUFPTR_MULT_MASK     0x00000003=0A=
 #define ITD_BUFPTR_MULT_SH       0=0A=
+    uint32_t bufptr_hi[7];=0A=
 } EHCIitd;=0A=
 =0A=
 /*=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index e82e0f625c..43a01a796f 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1464,7 +1464,8 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
                 return -1;=0A=
             }=0A=
 =0A=
-            ptr1 =3D (itd->bufptr[pg] & ITD_BUFPTR_MASK);=0A=
+            ptr1 =3D ehci_get_buf_addr(ehci, itd->bufptr_hi[pg],=0A=
+                                     itd->bufptr[pg], ITD_BUFPTR_MASK);=0A=
             qemu_sglist_init(&ehci->isgl, ehci->device, 2, ehci->as);=0A=
             if (off + len > 4096) {=0A=
                 /* transfer crosses page border */=0A=
@@ -1472,7 +1473,9 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
                     qemu_sglist_destroy(&ehci->isgl);=0A=
                     return -1;  /* avoid page pg + 1 */=0A=
                 }=0A=
-                ptr2 =3D (itd->bufptr[pg + 1] & ITD_BUFPTR_MASK);=0A=
+                ptr2 =3D ehci_get_buf_addr(ehci, itd->bufptr_hi[pg + 1],=
=0A=
+                                         itd->bufptr[pg + 1],=0A=
+                                         ITD_BUFPTR_MASK);=0A=
                 uint32_t len2 =3D off + len - 4096;=0A=
                 uint32_t len1 =3D len - len2;=0A=
                 qemu_sglist_add(&ehci->isgl, ptr1 + off, len1);=0A=
@@ -1762,7 +1765,7 @@ static int ehci_state_fetchitd(EHCIState *ehci, int a=
sync)=0A=
 =0A=
     put_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &itd,=0A=
                sizeof(EHCIitd) >> 2);=0A=
-    ehci_set_fetch_addr(ehci, async, itd.next);=0A=
+    ehci_set_fetch_addr(ehci, async, ehci_get_desc_addr(ehci, itd.next));=
=0A=
     ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
 =0A=
     return 1;=0A=
-- =0A=
2.43.0=0A=

