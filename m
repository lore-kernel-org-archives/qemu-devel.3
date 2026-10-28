Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09E9606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=WD8y+6Wq;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=rPqNCCxd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM0Cc-0000bA-EA; Wed, 28 Oct 2026 05:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=75473350e=Alistair.Francis@wdc.com>)
 id 1xM0Bw-0007oH-7l; Wed, 28 Oct 2026 05:43:35 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=75473350e=Alistair.Francis@wdc.com>)
 id 1xM0Bu-00008S-7d; Wed, 28 Oct 2026 05:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1793180610; x=1824716610;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=kngTj2opgxC3swonAoqcm2BJkwbc1TvA7LGHftXoOp8=;
 b=WD8y+6WqL7eEaYhHmSQK7VnToo+4mSpxOfJUkLAokxj/wspr8VONE5jN
 2MPVuJkRvUWFiKtzraiai066K+d9ZUgFh/CJcIcNeZZSRzGrWGrGy9euq
 E6OQjBtdrHNaaVZShcrNAi4bRlqsiX/uX8Or0gB15zJh7JD+oMmEgkoVG
 7AEkVzIoGveAmux0ONz42GRM6rtj2wAwSZHYnB9jOq85HOznhdTxOwgxu
 4+bZxavgofu1X2JBm9RvqqOpREmnF3C0y2m+IJdlejNOnuFQHzoLQFR8W
 /UlAaWNtWwE8o6obfQoYAqmSqAsvG1bS/hKdpwrkheW60hotE/9l9Ah4/ w==;
X-CSE-ConnectionGUID: 9qgt3YspRTqoK4/MkCQ69Q==
X-CSE-MsgGUID: LSooeay7SL2M1+GxnPX3Jg==
X-IronPort-AV: E=Sophos;i="6.27,182,1786982400"; d="scan'208";a="157587172"
Received: from mail-southcentralusazon11012057.outbound.protection.outlook.com
 (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.57])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Oct 2026 17:43:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oO6tRtHb6G4qJU1N1XEd6P2WqjWpF5Z1dri8uAs0XQXZ63jVFIe+QcWvy8BL8rP6FCyGpsOG1N4HP0a8Q5cuDr2hosGOCgybuiJYhjR3Ozaaz4u7xXUAwoyeghuE2ZHux5/M2zM7yU+lv5jBN2sEkgRZCCKaBHs8y0n4T1e2AIiz5c7FWnGyIBVN/4pfgP06jBSvNqnXFZsu6u94YB2pGAw9+hn5xlSmtv8/UNfd8ggaip0DQSw934XtdxX6OGYVQdO9Nd6snzqKtcBJ3UCAxxzksbesZRgMVyQWdGeVn9jmqdtIiNMyo1rxMXF2BPruhCnzELjydb+UycXBJRjcJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kngTj2opgxC3swonAoqcm2BJkwbc1TvA7LGHftXoOp8=;
 b=fIvLo9WvgmGBRB0e8mieI9cBsB0nucXS7PsfrQG8v5ITYcar5jl2HvS0I0QxP1yBsbKueg+ymiNjxQFfIJjhSzGRkL24YJUoHQWLwg8JhiZW+CcTBSSBsIn8IaKXHDHRemvcCpLVk8hitM8r+2p+oL3/PGcw+JXvYKhkcFw2JaS2jv+0+sxE8ZQAjLYUV4DAWWJRK7XmRhHyHeb/wHhqtJGF2/yXjLoNatHG966geZvrM3HMVI1ytsNtC/7soBurrQ5hPmw+ujNrN4G7RmEWVbiG/xYq7/TXkurVq4Cu+onzOEAVRMMsxtKk24RbUOZncgfIQAi+IyRZBh8X0+kc5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kngTj2opgxC3swonAoqcm2BJkwbc1TvA7LGHftXoOp8=;
 b=rPqNCCxdUMsDpmTMW+xXSQsnfAR9u707cWP72Gpq1wYwO0AUAW4lux2cIAqqOJZw6d8CRdT1z2rR01LVPZbyJZ3CgjuDvYrLrLeEjCGzNXEJ9LArQadcpcpQlfl7830z4CXTaP1HulbvMbPOMXDlhl7Qo2U67kbkYpehdYx597U=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by DM8PR04MB7768.namprd04.prod.outlook.com (2603:10b6:8:37::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 09:43:25 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0546.024; Wed, 28 Oct 2026
 09:43:25 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "portias@oss.tenstorrent.com" <portias@oss.tenstorrent.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mpe@kernel.org"
 <mpe@kernel.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "npiggin@gmail.com" <npiggin@gmail.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "asrinivasan@oss.tenstorrent.com"
 <asrinivasan@oss.tenstorrent.com>, "zhao1.liu@intel.com"
 <zhao1.liu@intel.com>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>, "joel@jms.id.au"
 <joel@jms.id.au>
Subject: Re: [PATCH v2 10/10] docs/atlantis: Update Atlantis documentation to
 include the RCPU
Thread-Topic: [PATCH v2 10/10] docs/atlantis: Update Atlantis documentation to
 include the RCPU
Thread-Index: AQHdZpVU/X0rDrDraEicRJ3IEgiH/LcStGGA
Date: Wed, 28 Oct 2026 09:43:25 +0000
Message-ID: <99e643a68322b54f809850202102166b259ff0b3.camel@wdc.com>
References: <20261028043059.600498-1-portias@oss.tenstorrent.com>
 <20261028043059.600498-11-portias@oss.tenstorrent.com>
In-Reply-To: <20261028043059.600498-11-portias@oss.tenstorrent.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|DM8PR04MB7768:EE_
x-ms-office365-filtering-correlation-id: 6078b2c9-0e4c-461e-707e-08df34d7e9ae
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|19092799006|1800799024|366016|23010399003|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006|261022105027099003|261022075727099003|261026121527099003|261026140227099003|10067099003|261021123027099003|261021121427099003|261009223027099003|38070700021|260925022911599003|260925021911599003|260925021311599003;
x-microsoft-antispam-message-info: jw2u13h5+5Ox4wyxDaM74L2Hd0LJTbVO/hz6hioFuHMI9Q5rGtMlp3yYH/L4RwW1YLy6C9FTddxLjqes7Y4toHwtYQW+afUy66xjotzX7gYnNllrwQcg46gTZI5j14qpbnyj6nB2ks5yk6/XrzkDDxYe9vNfDYKILF0Y+LokKeetU6CIKcQ58lswR19FgrSRV+9LOE6j58zGj0oNaTgEKR1gg8rit9DQWg3EmCRVE3Wetbtg2rdPDx2bYPGixMOhpa8178cvy9FC3/6Zy5fQiVWzzKJ3ebP1c6kbe1wbNac/dXwkHBb6i4xlnP4wf8zKn2Z8i0+R2TxdCA7GHBK7Q6IB2ml4ovkbSlxY8Az4+71pt3C5v43FUM2mus0YKcpXJ1T9B2mp4leHLoCe9rr2PmFj56JdjG9+rAdnUWBs/G/6NwqUM5Nn5Y0AzlBqYrkUagSIVJQvPhtyHJMgCkNIlvgzUSkYzMiV8p+Jc5jlrhqj1sqYixg71IJvtfZRi6nJPD6SoSH/dVM8U/DXKmhboCO8KyIAHO/03PYmHJhdHBlCTK09rwQuDvw9FwEBQZGIY/DR1k0zzhfYsHmV8GMdF827jmcSqNok4ZTAHEKCmtfMc/EfisfdhalrGAx7wN5NZBxN/LrR7TM65ucP1lk7MuSdfS2N6T92EwT5duDEVU5f1WWy6MRkE39ENh+Bc5cZC5NOf5rneoKLJcNtKoS6XCRO9OInTBVhF0BhZQKZlWE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(19092799006)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(10067099003)(261021123027099003)(261021121427099003)(261009223027099003)(38070700021)(260925022911599003)(260925021911599003)(260925021311599003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGxZemN6NnI1ODlTZmt2cnN3eHdxTlUxTWsyUDlITHpPU0s3SjVWQnd6enky?=
 =?utf-8?B?TTd0cFRjVUpFQklrZ01KdElLakMxUEpBWWtwdlZnTkw5emlCdTJMUzB4NFpa?=
 =?utf-8?B?UXdveUlwdzl4VzJMV0VMcy9kazJlbkVGcWM2bGJZOVpaZzlhZ1l4MkJVVmVJ?=
 =?utf-8?B?dHFVV3Z5Y1pybG5vNDVhMjZNSjJQRVFBV1V2VENTTHdDUjZDRi9kK3JGR0NR?=
 =?utf-8?B?R3dkdkFpbXNENEtmY2VaWEk1M2JqdHNNQTl5ZC9xSU56eXNwZE95ekJlRmJr?=
 =?utf-8?B?NnZoeVFoQWxseDFBdnZhL0JvWFhsZHB6UEUyTXRHRmJrZ2haNG5hSEVJcTlt?=
 =?utf-8?B?WGY0K2lmWmtPQVpSVTZBTjl5LzNqZGJJM0xNbWwxaUhnTDhGc2hlbjhSOVNB?=
 =?utf-8?B?WVo0MFFjLzhLWW1RU1BJNUw5bUtESnpqU1BGL21MNGlZYVlOVzlMaWdudHFF?=
 =?utf-8?B?NEdSdEZTRldVUUFUQjE5Q1E1V1NCa2l1KzN5RkJXbER3ZUt2L1RLRktoQzlF?=
 =?utf-8?B?TG9rQ0lVSVIvZHZkUjdxQ0hpYXl6WitFQStPVGVtd0U0OVcwbzdPK3pYYWhp?=
 =?utf-8?B?VjExd2VOcUtMdmU4ajhNd2kzMWtkQ3FZTkVTYVNmdThxVnk4UFNocit2RFBs?=
 =?utf-8?B?ZHZteERqUFlsUncyOGU3K2FkRTBRaWlvVlF3aytyWjF4amMwZmx2SjJIUDZR?=
 =?utf-8?B?cFdpc2xaK2VIRlhjOForNEFPSndQdjR0YjJQR09YaTJkZXNsb3NYR2lkZklQ?=
 =?utf-8?B?MmlWYUdtYjRjU2JLQVlkeU02WUVQNlVFTHNxTGt3YU9nWGFEMkJud3pVR08v?=
 =?utf-8?B?eVNVQksxdkxuZVhrL1hxa0hMcm5wYUlsWG5tUHRRTWtRR3JjaEVEenFndFFG?=
 =?utf-8?B?U3hJMG1pQ3NOQmZPM2xNdWI5ZGpqeWZzM2pYVittVHArTnBNcFpLc0VxbEhi?=
 =?utf-8?B?RWlRQjlXcFMyZnE2VkxFVDRNcFMzOUljcEQwTlpZVUhXOFRXV01oUXBWWWNj?=
 =?utf-8?B?RU5TNGNuQkUyRiswSERrd3RVc01yZ0trTjdmVXE1d0RLTm1vT0RRQkRYMnVG?=
 =?utf-8?B?OERFRXlrTnhYNWoyeDdvSXN4REZoVEpBYWUrUE1QMTlpejQybjRGSkt0SDNy?=
 =?utf-8?B?eXFxamtkTE5hN3VoVHR6NjdBWEtCVzdCRzN3dG9QaE40Vlk0ZTA3cmZvN3lj?=
 =?utf-8?B?b1JuMVc2ZnFVUm5laG1GRkx6TytOdjJuMkcvT2xnWWlwdEJrN0VxNHowbXFz?=
 =?utf-8?B?cjBTbHJvT0taZjZIeEM0aVgxenQxWFpxU3FQSFJnMnEwc3RZdUJTZkxiL0dT?=
 =?utf-8?B?QkY4REx6dEtYTWJzaTlVQ3JCU24xS3kwYWN4amVaMTZmbmhTbytjSy9Rc3BP?=
 =?utf-8?B?ajB2dUdDNXJkZGo0WTJHbnhVRXVRdGYwUklHaWExS21FOGJVQmNjQ1UxRm1x?=
 =?utf-8?B?ZHM4emNIbXhrbXVrbVQvRUZETmZ2bVZpSkFmZi9IaHhFUkhhTmxJNmxnZ1hl?=
 =?utf-8?B?UUhVZ3NKaE94eEtJZHJBTnNnU1VnYmhhRGtudEZqb1VtcWRnc3EyYWxwT29v?=
 =?utf-8?B?RXQ4eWNmYkZGY0tTVHNpTU1GemZ3STJiR3ZaVy9yblBoMStxVmMvQmZFRHY2?=
 =?utf-8?B?b1JuYk1KMGJmdWZmUmRMV2orUUxNNGFNQ2dWVkV0aVM4Wm9pK3k2emJLU21V?=
 =?utf-8?B?MUthUHZYQk1vN2ptRDkyQzNycFhuZ0NxRG5sTnNERmFnVThFZjIvSVg0VVpp?=
 =?utf-8?B?N295d0dWKzNHNDhKdnA0NDBIZkkwYjJDV3NmeUxaWFlMVk9pZTZQOUFnTWZa?=
 =?utf-8?B?QXh4dE9EZVZVc3lmUmN0T0xrTFo1N00zTUlKcTg1TUFZMFNXZ2xadUpGUDlm?=
 =?utf-8?B?N0xCKzRQVytENEh4eWg3d001RVFEMGoxNnYyU2xCb3FaeEU2L0lrUXpUY1c5?=
 =?utf-8?B?anpJRm5SZEhZbmU5WjNVMkV3Vy90cDJiSTQxTEFKZjJBVGY2bUFTZzhLcWlH?=
 =?utf-8?B?anBwQTVyd05YeUFpbWNvajI4RnlYTjV1QVZIbk4yRml3N0p1MHJ3dnJUN0xk?=
 =?utf-8?B?SVJmM01Pc1A4V2NUcmphL2RsK294VW5sRVF3QXpXWVROb2l5c0V2YzVoV0c2?=
 =?utf-8?B?YSsvMWIvMitpc0RsamhHM2FKbUwxZG52eUdFVTMwM3JmTjE1QlE1eVVPUTQ5?=
 =?utf-8?B?c0JXOFZqTzdRRjdNeVhkZVBRNHd3TnJKS0V5elZpVlBMNGg0SDJCVmYvczQ5?=
 =?utf-8?B?S0luZ2ordENUa1JOSU1FZGE1cUZQVDRVTW1Ia3A5bWhCTUJrOHpBWVhzUmFm?=
 =?utf-8?B?cE15c3N1UWFrd0JWVmdyNWcyWGNad2p2OEVrSk9SYTVkMmhwRHVsUUoxU3VN?=
 =?utf-8?Q?KWzHnExVXt1lWmMCPDZEdmOGftEgu7tKO6xqmKKC9I38M?=
x-ms-exchange-antispam-messagedata-1: v1R/oKCHsoL5vXepRPbSXjIJr2JqdxIpiNI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C37033D7A61A14289C7F2BD0B397A62@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kL6uRQdL65XTe+gEylxo3F3EBP9oU54SGjSVLvw5RA7egiY8RtemwyEYNj+vJmHTkVLVVw9+OsckG5TT6/ExPsoodG6YdlDIaY71Zyzoj2FBKyBMceVBNpzuUIYryB19r2eyCXsA88WR/baThAPr4bXHexQSARrQ2tRiVo4xSkf17PFDqB85qy7WDUf6Umt6InK75w+vEONKXehMp/+nhHHs/NKIGwn6Jzm9mQWXhji0mdl0jCmhwCbg1iJAIisxaiVXEvfrhXSN6mWsgzEdBllT0yQq7Zu541WkCd077U9VThu3kruovfZGR2oP99FlwUzTPzcMlQ4eljIrrHqZ0Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: u9uqz4eLuH3C3pZH7sjL83YHVhGUDrpYfDp0tEF78C+Nim/rbaQaZNsY1aBkM0xNiDC+oMkFAcq//9tyk5ZPYhkJhPsE+6Cf35mr9BuXUrUDlzujtUlnyYtnGuxYujvbIEbMmJFtS7FVgZmSUuZu6xQufh62198wY74cypKKOw1Xz0mvYB1LIlYsRl0k3HiWe+6QOgBx7BXp9qiEVJ1mO7zN5d7YSJPVqeccuQS2QYHn5PHf8+CMB8C3rYwOlmUzPsOXAhofDWadbXmMxZR3yXI6HeeX1ggwgLpS8+F9uflq70ibA5fksnf48AULlNRgcG6NrKDofbHv0tOo6UJ2qHSLJquMxAABG6alQNvW6VvFiN4MU3/ALGqQYvk9MY9D6zDswCWP2g2Kp53nCobgvgV8EUzZ/CPTu1sKAon8mZcZNZW1aMvU2Xz3RV2oAQ77y9YHVmHhec0wajwwjAC5VUfXKRsoueSSTr4zV3xPLvVl8T1g3zF2JIBHVxugoAjI6qmOvy2QzGnBoYRvS4KX/Qpflt1tdHtNzLYQWxmzlu6uhxlXKJGH8pwByiDpmqrC110jS6dg+wraHrEBGYN/jk6sp1MCvHE75Dxz/LFRLCOs63bbiaWzqKOE1DDgjQLn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6078b2c9-0e4c-461e-707e-08df34d7e9ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 09:43:25.2446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j1p93LrGq+bUU0yJggV9RIqrPLirJlFLunOxkP8rPlBRG+DUcS30qmkDkuo/pLn1coP3ejnKCR+79GdJfRPuKSUksNwguNgA6kGn4kVvOzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7768
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=75473350e=Alistair.Francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gV2VkLCAyMDI2LTEwLTI4IGF0IDE0OjMwICsxMDAwLCBQb3J0aWEgU3RlcGhlbnMgd3JvdGU6
DQo+IFRoaXMgdXBkYXRlcyB0aGUgQXRsYW50aXMgZG9jdW1lbnRhdGlvbiB0byBpbmNsdWRlIG5l
dyBtYWNoaW5lDQo+IHByb3BlcnRpZXMgZm9yIHJ1bm5pbmcgdGhlIFJDUFUuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBQb3J0aWEgU3RlcGhlbnMgPHBvcnRpYXNAb3NzLnRlbnN0b3JyZW50LmNvbT4N
Cg0KLSBbTE9XXSBkb2NzL3N5c3RlbS9yaXNjdi90dF9hdGxhbnRpcy5yc3Q6IHRoZSBuZXcgQm9v
dCBvcHRpb25zIHRleHQNCnNheXMNCiAgVUFSVDAgaXMgbWFwcGVkIHRvIHRoZSBzZWNvbmQgLXNl
cmlhbCB3aGVuIHJjcHU9b24gKHRoZSBkZWZhdWx0KSwgYnV0DQp0aGUNCiAgS25vd24gbGltaXRh
dGlvbnMgYnVsbGV0IHN0aWxsIGNsYWltcyBvbmx5IFVBUlQxIGlzIGV4cG9zZWQgb24gdGhlDQog
IGNvbW1hbmQgbGluZSBzZXJpYWwgaW50ZXJmYWNlOyB0dF9hdGxhbnRpc19zb2NfcmVhbGl6ZSBp
bg0KICBody9yaXNjdi90dF9hdGxhbnRpcy5jIHdpcmVzIFVBUlQwIHRvIHNlcmlhbF9oZCgxKSB3
aGVuZXZlciB0aGUgUkNQVQ0KaXMNCiAgcHJlc2VudC4gVXBkYXRlIHRoZSBsaW1pdGF0aW9ucyBi
dWxsZXQgc28gdGhlIHBhZ2UgZG9lcyBub3QNCmNvbnRyYWRpY3QNCiAgaXRzZWxmLg0KDQotIFtM
T1ddIGRvY3Mvc3lzdGVtL3Jpc2N2L3R0X2F0bGFudGlzLnJzdCAoQm9vdCBvcHRpb25zLCBzbXAg
YnVsbGV0KToNCnRoZQ0KICBvcHRpb24gbmFtZSBpcyB0cmFuc3Bvc2VkIGFzIHNtcCAtY3B1cyAo
c2hvdWxkIGJlIC1zbXAgY3B1cz0pIGFuZCB0aGUNCiAgYnVsbGV0IGVuZHMgd2l0aCB0aGUgZnJh
Z21lbnQgIlRvIHJ1biB3aXRoIG9ubHkgb25lIEFzY2Fsb24gaGFydCBhbmQNCm5vDQogIFJDUFUu
IiBmb2xsb3dlZCBpbW1lZGlhdGVseSBieSB0aGUgZXhhbXBsZSBibG9jazsgZW5kIGl0IHdpdGgg
YSBjb2xvbg0KICBsaWtlIHRoZSBwYXJhbGxlbCBidWxsZXQgYWJvdmUuDQoNCi0gW0xPV10gZG9j
cy9zeXN0ZW0vcmlzY3YvdHRfYXRsYW50aXMucnN0IChEZWJ1Z2dpbmcpOiB0eXBvIGdiZCBmb3Ig
Z2RiDQppbg0KICB0aGUgbGVhZC1pbiBzZW50ZW5jZSB0ZWxsaW5nIHVzZXJzIGhvdyB0byBkZWJ1
ZyB0aGUgbWFjaGluZS4NCnMvZ2JkL2dkYi8NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gwqBkb2Nz
L3N5c3RlbS9nZGIucnN0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArKw0KPiDC
oGRvY3Mvc3lzdGVtL3Jpc2N2L3R0X2F0bGFudGlzLnJzdCB8IDQwDQo+ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kb2NzL3N5c3RlbS9nZGIucnN0IGIvZG9jcy9zeXN0ZW0vZ2Ri
LnJzdA0KPiBpbmRleCBiNmQ4ZjhlNzdkLi4zNzc3NjMwMzM3IDEwMDY0NA0KPiAtLS0gYS9kb2Nz
L3N5c3RlbS9nZGIucnN0DQo+ICsrKyBiL2RvY3Mvc3lzdGVtL2dkYi5yc3QNCj4gQEAgLTc5LDYg
Kzc5LDggQEAgZGVidWcgc29tZSBpbnRlcmFjdGlvbiBiZXR3ZWVuIGtlcm5lbCBhbmQgdXNlci0N
Cj4gc3BhY2UgeW91IGFyZSBiZXR0ZXINCj4gwqBvZmYgcnVubmluZyB5b3VyIGd1ZXN0IHByb2dy
YW0gd2l0aCBnZGIgZWl0aGVyIGluIHRoZSBndWVzdCBvciB1c2luZw0KPiDCoGEgZ2Ric2VydmVy
IGV4cG9zZWQgdmlhIGEgcG9ydCB0byB0aGUgb3V0c2lkZSB3b3JsZC4NCj4gwqANCj4gKy4uIF9H
REIgbXVsdGljb3JlOg0KPiArDQo+IMKgRGVidWdnaW5nIG11bHRpY29yZSBtYWNoaW5lcw0KPiDC
oD09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gwqANCj4gZGlmZiAtLWdpdCBhL2RvY3Mv
c3lzdGVtL3Jpc2N2L3R0X2F0bGFudGlzLnJzdA0KPiBiL2RvY3Mvc3lzdGVtL3Jpc2N2L3R0X2F0
bGFudGlzLnJzdA0KPiBpbmRleCBkOTRkMDY0ZjRmLi43N2RmYWNmZjNjIDEwMDY0NA0KPiAtLS0g
YS9kb2NzL3N5c3RlbS9yaXNjdi90dF9hdGxhbnRpcy5yc3QNCj4gKysrIGIvZG9jcy9zeXN0ZW0v
cmlzY3YvdHRfYXRsYW50aXMucnN0DQo+IEBAIC0xMiwxMCArMTIsMzcgQEAgdHQtYXRsYW50aXMg
UUVNVSBtb2RlbCBmZWF0dXJlcw0KPiDCoC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4gwqANCj4gwqAqIDgtY29yZSBBc2NhbG9uLVggQ1BVIENsdXN0ZXINCj4gKyogUlYzMiBSZWFs
LXRpbWUgQ1BVIChSQ1BVKQ0KPiDCoCogUklTQy1WIGNvbXBsaWFudCBBZHZhbmNlZCBJbnRlcnJ1
cHQgQXJjaGl0ZWN0dXJlDQo+IMKgKiBEVzgyNTAgY29tcGF0aWJsZSBVQVJUIHg1DQo+IMKgKiA0
IFBSQ01zIChDbG9jayBhbmQgUmVzZXQgQ29udHJvbGxlcnMpDQo+IMKgDQo+ICtCb290IG9wdGlv
bnMNCj4gKy0tLS0tLS0tLS0tLQ0KPiArDQo+ICsgKiBgYHJjcHVgYCBlbmFibGVzIHRoZSBSQ1BV
IG1vZGVsIHRvIHJ1biBhbG9uZ3NpZGUgdGhlIEFzY2Fsb24NCj4gY2x1c3RlciBhbmQgaXMNCj4g
K8KgwqAgZW5hYmxlZCBieSBkZWZhdWx0LiBXaGVuIHRoZSBSQ1BVIGlzIGVuYWJsZWQsIGBgVUFS
VDBgYCwgdGhlDQo+IFJDUFUncyBjb25zb2xlLA0KPiArwqDCoCB3aWxsIGJlIG1hcHBlZCB0byB0
aGUgc2Vjb25kIC1zZXJpYWwgb24gdGhlIGNvbW1hbmQgbGluZS4NCj4gKyAqIGBgYm9vdHJvbWBg
IGJpbmFyeSB0byBiZSBsb2FkZWQgaW50byBtYXNrIFJPTSBhbmQgcnVuIGJ5IHRoZSBSQ1BVDQo+
IChubyBlZmZlY3QgaWYgdGhlDQo+ICvCoMKgIHJjcHUgaXMgbm90IGVuYWJsZWQpDQo+ICsNCj4g
K1RvIGVuYWJsZSB0aGUgUkNQVSBtb2RlbCB3aXRoIGEgY3VzdG9tIGJpbmFyeSBhbmQgdGhlIFJD
UFUgY29uc29sZQ0KPiBvbiBzdGRpbzoNCj4gKw0KPiArLi4gY29kZS1ibG9jazo6IGJhc2gNCj4g
Kw0KPiArwqAgLU0gdHQtYXRsYW50aXMscmNwdT1vbixib290cm9tPS4uL3BhdGgvdG8vYmluYXJ5
LmJpbiAtc2VyaWFsIG51bGwNCj4gLXNlcmlhbCBzdGRpbw0KPiArDQo+ICsgKiBgYHNtcCAtY3B1
c2BgIFRoZSBzbXAgY3B1IGZpZWxkIGluY2x1ZGVzIHRoZSBSQ1BVIGNvdW50LiBXaGVuDQo+IHJj
cHU9b24sIHRoZQ0KPiArwqDCoCBudW1iZXIgb2YgQXNjYWxvbiBoYXJ0cyBjcmVhdGVkIGlzIHNt
cC5jcHVzIC0gMS7CoCBXaGVuIHJjcHU9b2ZmLA0KPiB0aGUgbnVtYmVyDQo+ICvCoMKgIG9mIEFz
Y2Fsb24gaGFydHMgY3JlYXRlZCBpcyBzbXAuY3B1cy4gVG8gcnVuIHdpdGggb25seSBvbmUNCj4g
QXNjYWxvbiBoYXJ0IGFuZA0KPiArwqDCoCBubyBSQ1BVLg0KPiArDQo+ICsuLiBjb2RlLWJsb2Nr
OjogYmFzaA0KPiArDQo+ICvCoCAtTSB0dC1hdGxhbnRpcyxyY3B1PW9mZiAtc21wIGNwdXM9MQ0K
PiArDQo+ICsNCj4gKw0KPiDCoEtub3duIGxpbWl0YXRpb25zDQo+IMKgLS0tLS0tLS0tLS0tLS0t
LS0NCj4gwqANCj4gQEAgLTM5LDMgKzY2LDE2IEBAIGFuZCBMaW51eCB3aXRoIGRlZmF1bHQgY29u
ZmlndXJhdGlvbnMuDQo+IMKgVGhlIGRldmVsb3BtZW50IGJvYXJkIGhhcmR3YXJlIHdpbGwgcmVx
dWlyZSBzb21lIGltcGxlbWVudGF0aW9uDQo+IMKgc3BlY2lmaWMgc2V0dXAgaW4gZmlybXdhcmUg
d2hpY2ggaXMgYmVpbmcgZGV2ZWxvcGVkIGFuZCBtYXkNCj4gwqBiZWNvbWUgYSByZXF1aXJlbWVu
dCBvciBvcHRpb24gZm9yIHRoZSB0dC1hdGxhbnRpcyBtYWNoaW5lLg0KPiArDQo+ICtEZWJ1Z2dp
bmcNCj4gKy0tLS0tLS0tLS0NCj4gKw0KPiArQXNjYWxvbiBhbmQgUkNQVSBhcmUgb24gc2VwYXJh
dGUgQ1BVQ2x1c3RlcnMgd2hpY2ggYWxsb3dzIGdkYiB0byBwdXQNCj4gQXNjYWxvbg0KPiArYW5k
IFJDUFUgb24gc2VwYXJhdGUgaW5mZXJpb3JzLiBUaGlzIHByZXZlbnRzIGlzc3VlcyB3aXRoIHN3
aXRjaGluZw0KPiBiZXR3ZWVuDQo+ICtSVjMyIChSQ1BVKSBhbmQgUlY2NCAoQXNjYWxvbikgdGFy
Z2V0cy4NCj4gKw0KPiArQnkgZGVmYXVsdCwgZ2RiIHdpbGwgY29ubmVjdCB0byBpbmZlcmlvciAx
LCB0aGUgQXNjYWxvbiBjbHVzdGVyIGFuZA0KPiB0aGUgUkNQVQ0KPiArd2lsbCBiZSBvbiBpbmZl
cmlvciAyLg0KPiArDQo+ICtnYmQgZG9lcyBub3QgaGFuZGxlIG11bHRpcGxlIGluZmVyaW9ycyBi
eSBkZWZhdWx0LCBzZWUgOnJlZjpgZ2RiDQo+IG11bHRpY29yZWANCj4gK2ZvciBob3cgdG8gY29u
bmVjdCB0byBpbmZlcmlvciAyLg0K

