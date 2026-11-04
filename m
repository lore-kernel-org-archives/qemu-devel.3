Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C293606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 05:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=ilUkv8Fq;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=lIC2PpxY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOTFs-0001s7-IL; Wed, 04 Nov 2026 00:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=761a35039=Alistair.Francis@wdc.com>)
 id 1xOTFO-0001Wz-M2; Wed, 04 Nov 2026 00:09:21 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=761a35039=Alistair.Francis@wdc.com>)
 id 1xOTFM-0002VF-IG; Wed, 04 Nov 2026 00:09:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1793768957; x=1825304957;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=J8AAtg36MB5YNsF7uO+rzec4QyPEzzLL/QrwuLfl928=;
 b=ilUkv8FqaKfOnG0Hbwb1/iK2MHZwmoTE1ufLMZP20CEzv4ZhE69nAJ7/
 0Ed6sya6pNVVUgUwj7t3PlkR7mpS3Z17EBw+2WJe26O0yojH2p8RM6ByM
 lqSeVEjxw4CBM4CZ5txYWN8DIvr1fcD0tVA+m8FGmxAIn/vPhVVVaL9I1
 PvwyrzUSBNCk3p9um0n2KipWG/9bsb1xgO6wFwWJbQfXUK/VJfd8Sbb21
 kS42j9Cxh8/qzR0Mn8vdNF8JQhOouzr4k0wXvPxoxLd0t3y6R3GfPd+ms
 shQFshUohxwpUwzAq9d2atD7U7TU4xzWd9u0xqPT/10jJUTV13HOMcTYk A==;
X-CSE-ConnectionGUID: XCtMbPSXT6eAIrX6yZiWkw==
X-CSE-MsgGUID: 40xMYTSuRyyCt3vCKUG8AA==
X-IronPort-AV: E=Sophos;i="6.27,194,1786982400"; d="scan'208";a="159772543"
Received: from mail-westus2azon11012005.outbound.protection.outlook.com (HELO
 MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.5])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 04 Nov 2026 13:09:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gg4V8laVSIsggVvQAu32keZKlpb4iZLRTmnqOTapMED7i6oe1vUJ6Yf/Bfy4oCwYki6jAHParp7McMCIvI2STyUC3aKuHCqDw34bdX+GuYY8hXgv3IJrlW47vBPsUTJYHuzs+TZmVJiHZz8uoGXMyq2GsT94h7Z3AOoVAPbmTbk1Me90eLI5H2oUb/hjt0FLfuHaz09AgQovaLGYLGR6j4AIY0yGEGXgJ2SRt4nwKx/matl5583t9mnbeYjTI2RgcDyxW4xjCLwThdzJsyrBKlcJCFy4XnOEHElvf7yJ5JTNLzUVa6pl7iB8Nj7gtsrQxvPuyVe5GXsLeSM6ZmzpRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8AAtg36MB5YNsF7uO+rzec4QyPEzzLL/QrwuLfl928=;
 b=CbdL2oIS1B4f5YMXkYRA9farIcBEt0UQe/LGY3wxh6qKOQsbbBJiaN5dlU/GZfEB5Nup2IOcQRaxAtpMGdK9u8BU8zpMFOT0ug33Sdudb/XCpvron6kowtbXpkyY978gYZVAYboXs4BHYpb3O9tDRUWl67Jc4ybgQAYQYjDbnF+ed1Z/rlsGRvUQV7NG014pKnhrGjhM91l0QftJj9PGnFYGzH20NqkG9IuymCF5Dr6KglFysqj21HgdqXPd21UfU9E8J+h0ORvVGzSnb9BUA+M42/4q12aSMwCilWPvNA/AtTT+QT1nHaoNB5xi1KB5FhteGVzkIqA/qGGjS7cLwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8AAtg36MB5YNsF7uO+rzec4QyPEzzLL/QrwuLfl928=;
 b=lIC2PpxYg15YOWLFLUf0EinnM9k2IGnLNxc9U6l9FX8E+MA7jf9Rf0J+KGd9ykKbjVwaU77um6fGYocTm+cbQYgFLhEfsq4+AKlQgWgOVmtirsuk3xjVoebVxTndQwlyMKzbSO2FSpvuAea9j4WhYBe7ZdijDTWWmQ51Bdx04hY=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by DM8PR04MB8005.namprd04.prod.outlook.com (2603:10b6:8:f::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.12; Wed, 4 Nov 2026 05:09:11 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 05:09:10 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "tanchi25@mails.ucas.ac.cn" <tanchi25@mails.ucas.ac.cn>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 4/5] hw/riscv: Pass socket topology to KVM AIA
Thread-Topic: [PATCH 4/5] hw/riscv: Pass socket topology to KVM AIA
Thread-Index: AQHdaa9fP8AapgYNPEuksM2yY8cP5rcdYeCA
Date: Wed, 4 Nov 2026 05:09:10 +0000
Message-ID: <266617b3e0327be945658feb91059cdf6993676c.camel@wdc.com>
References: <20261101031547.125591-1-tanchi25@mails.ucas.ac.cn>
 <20261101031547.125591-5-tanchi25@mails.ucas.ac.cn>
In-Reply-To: <20261101031547.125591-5-tanchi25@mails.ucas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|DM8PR04MB8005:EE_
x-ms-office365-filtering-correlation-id: 6bb5c5bf-18f4-4aae-ac23-08df3a31c2f8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|10070799003|366016|19092799006|261026140227099003|38070700021|4143699003|56012099006|11063799006|261009223027099003|261028144727099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|10067099003|18002099003|261102123227099003|22082099003|6133799003;
x-microsoft-antispam-message-info: M97OJKvgu0f/aNBb84ELimgM5jidwvd92D4SKckL7nFmp7yCdK23sMxytDIa4wpGJFEirnXSCXm/NWhqfxNKvjMRwRDXLETILwHDWecMP5x1Rq+2R4LEzytFgHnNhJrH3/nmdXwGTWSAqOxp+L1Je2Hn580gkL7d42UyuoQU4RtRMP1ChTE1vYlTCwzqoZ/wFffHbRsC/fCol+cAeMStts5KUMcPZiHZyzqrCExveUOo8WiV77omP/hWHKMUn8ly2Sa2Sz8lbgKHu7lIKGxXN/0OOrdMTTgpqe/bCS04+OEI2AkXW5BtDZ+MDY9BepOhB9+ine/IBI+Leq0+6BmDQ3PMXialLKTq5YUFHyTedEK1qtR1d3fPiidHt84GVvXCTpYFYQPvOwpn+5REWQSKwIUQgqOc/RNEeJuwwwB314S2c9GNVjNGGnSlVpymH6wL91dFyDvaIJVJdtMeQkRQ9sJHaI+M+NO4wZRp49pcOsF+7QXwS8Pgd+tHvplp35CkYw6n8d6TMjo8SB70aN2Vd/bkdA63+0kLtr5+Rh/syVG8HNW36yhWTXVXtcp4XfNPDjbHoIr4vVL6tKNLskph6DBGJ4Z82vyKwh+Cg6CKqrM1qXBiYzlm8HbYdwwIYdfumd4na/SqYRizXIyt9lgk9BbVorTmicqp9cetZ2ChxFATYwur14qWvzEfSfs9TINO5JvP4XyZ9JvSzBRDE8RZsNt2cY0lTiIIeh5MDLSq3Kk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(10070799003)(366016)(19092799006)(261026140227099003)(38070700021)(4143699003)(56012099006)(11063799006)(261009223027099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(10067099003)(18002099003)(261102123227099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N050OUFRdTgvVUkrNmE1bUZETGhycG5JczlSR094OUdiOTNJNTM3byt6cVJw?=
 =?utf-8?B?RzVwT1VwR09SMHlaMUdhQWxxTUpxYzRFN3JiM0dsS0dwb2hyMUYvcDV1bkZ0?=
 =?utf-8?B?UGVObmUxZ1dUNm1LVEw3SkdvZUhZMld2ZVY3WHEyYXZnNXhLOEFDYlVzV3Fh?=
 =?utf-8?B?dHo5WDRSTVduT29CYmJrUThiLzBoWjVqbFB6emZibEpxRUZpenFzWXBwKzZj?=
 =?utf-8?B?YmVGMldUVWNXb0lOK2NHWGl1TnV3MEc4bGIvNEZ3ajFiTTRCTnVjRC9mVVAy?=
 =?utf-8?B?UWM0WGlLWngxbTJlVDM3cy9kUmNvUktBUUhuL29xT0kxSFdmUmU1TytzS1Ny?=
 =?utf-8?B?T2JaSHdOdCtkOG52YkFuRlREU2VmMTVCUytPRFRCamlodTFRWndFNEZZOEIv?=
 =?utf-8?B?cmx4akJoSys1T2VWVUJBWURmSVlXWUV4SVZTM0k5dDVjbThmUkZORVAvci9J?=
 =?utf-8?B?d2FSRy9sMVloTkJ6UUNYS3A0VVVVTEcrYVg3aTdiVTlOWG82YXBQTzNRWmJt?=
 =?utf-8?B?ODJZMlVtQVVGd1ZtOVQyeWM1UTBEZlVlOElKY1JmZWhsenlKM3pOT1c0aG5S?=
 =?utf-8?B?R0NBYjJHTVpSSHFPcXc2ODBTV0RwRDRWNjQ3bkwxYU9KcDFXaGxFOWlJSktM?=
 =?utf-8?B?TlRUN1U4TTJXRkFNMktMdDJiYkV5VTcwNENwMWNLUUp4TVR0c2E5a0JZZFE0?=
 =?utf-8?B?SFdJVTd4RlUrL1NEZWMzWnF6SDVVOE5uckxkcG12c1prQUJmaFlpR0dObWlT?=
 =?utf-8?B?RzVJd2l1TC90UnBVQ24waUlld2taM2ZBYkhlTUJRL0FKRXdWOW1uSDZZV2hH?=
 =?utf-8?B?ZFlZeHBlSEgyREVia1drRExwVXZOMTFqV0k2MnNsUUhoVGFzNkR2b0J0MTln?=
 =?utf-8?B?cmdrWlBlSEN3UzBBWSt6T082TE9qZ0FmVVpWWU9wbExSdTIwK2dhZ1dzYmh1?=
 =?utf-8?B?TmdhRDFqY2NURGlvZE53dUxlVkNJVStjdm54Vlc5WEJwS0kvNWU1ZVRtUDYv?=
 =?utf-8?B?UCtVazV4Ykp6ZE53bGNudW9SajRuUHk0czkwODFKbGhXMTJ6WUxOSHJBOFlC?=
 =?utf-8?B?R1JXMU1NMzR4MnNLY1BuRUNVajRPNHRWL3dTYSs5SEY4NnZtdzlEditFOFht?=
 =?utf-8?B?a3M3RXhRaERlUitWUzFNVTR0d2NuWEJVaHI0YTJxek9tTTN5ckdXV0owbnpI?=
 =?utf-8?B?Ni9RdENlQ1BqUlJkQ0hzMjRxdktXQkMyem9WVEl0TWF3cDJsMVRDckNRdUZ5?=
 =?utf-8?B?d1JNS3M3RFlhTzB3S0V3RUtaejFLQktmOGRPTHByQ1NRTE84TnRnUDFwYkN5?=
 =?utf-8?B?ZE01UnpvTU9kNDdTMk53Z0hXOUUweHpYRTZqTVEyc1VtMTF6SUVMZStpV1Fo?=
 =?utf-8?B?L29Mc0k4WGhlUkloOTNzWE8xMHA3b2duTTlnNFQrY0dkdE5aKzNhYnJNR0Rt?=
 =?utf-8?B?M3dnUFZVNm9GdTV5M0pkSWJCVUgvQVVlQ094aEQ0T05KelVhSUhKN1FTWTVO?=
 =?utf-8?B?RG45ZlpyVzRDaWZXTEgva0xBS2NDR1o1UFBrWm5ZUkc1QytjSW5LY2VFWWtZ?=
 =?utf-8?B?emtQMjhySnVuaTdSSmpLYi83R1pmSFRVbHZOLzFyaDMwZ3BPNUFsZ2NhL09o?=
 =?utf-8?B?eU14UGVEMHF4REIvODhOcHRUaUlOa2xFNFhZSDA0KzExTVd5ejAwcHBlcnc0?=
 =?utf-8?B?ME5lc3o5R1pMMlVBZWF0TWtoUWtXaVFGbkg2TUp0TExjWjEwU25vRFhNMG01?=
 =?utf-8?B?OVlDeWRSWXhrQjRnQzBCTWJXZjNtMFEyeGZ4Q0pMbitVZEYwTzdySUJ6cGIr?=
 =?utf-8?B?RlRwOTAwYTBGRUFxcTRXbmVLU3V4c0E2RjBWeWMxdkpjM3R4WlBSNTA4cE1F?=
 =?utf-8?B?eWlUeldTYjI1Z0w5QWxxdHdIRGRQbXd6Yi9kMUhTOURWalBKQlhKZHRVbjVr?=
 =?utf-8?B?S1g1Q0tCRm1yWWYzemdONU54VlJMWGJqTjg0dVdrTVphZXNZL1EzaFJ1OWpC?=
 =?utf-8?B?NmFJV0pKZ003VS9KdFJ3VEQxT0RONE8xNGF6cjRLTUZOT0xFTlRhVitFalpF?=
 =?utf-8?B?OTNRMkl6OEFRSDdkK1NOSzJXanMzU3I2K2RIS056MUUzdTRkc2Rrenh3eW9q?=
 =?utf-8?B?OUxwYTFCOExNK2NoRFg3OHlTdVZGWnZQSFo4Y1NmQ3BLN2ZPOWxWNzdrd0w2?=
 =?utf-8?B?V3dpMjV6MmpJRXEydytjN29kd085NmdXaXl2VmxpOHBsTW1pZSsraWt6bTBL?=
 =?utf-8?B?bmhsd0JEWndHY3ptRDAwSmVxeUo2WHBZdThZNGx5SzZPM3h0UEFNQTZwOEhR?=
 =?utf-8?B?UGdPWjNhQkpVYmhYOUF2TUFQWGJYeXhkalpjY0F0d0dJc1JXNXdNTFNUbEFu?=
 =?utf-8?Q?URT9LByi0a13OX7PNnoxI5F+/vGeY93ap/8R/7F5TUBqS?=
x-ms-exchange-antispam-messagedata-1: 2y57+O6aMpY1bhPvyH+Lfh7W9tAjwbNjAeA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2C28D137AD3624E9DBF27A8A740FB5B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ABMrUdYNrwThYAmp7fgidhw8FLwPNcheN/vshlmTU8trroNcXBtJaWPN6qJoAA5noxuFoQ3hHJYAzWclVXU4UCDIFsV3vZEcR6RuUz4Cn88Ab0yVecLQ9e+ycKNzaxTFNokQdOrHgXZkHsXtMUy1BbMwGcRNwK56McNDU15L2z/bnLchCWZrJ1jr6Gn6PisYEubKX2fC8aTGqReZ3upvW0tPhu8FXDAw4ymJG6OH8osu0sA7NAoTgLRs+vCib/CZY6+u6mhnoADN8IM5jPofO4gQddgu2ftO/dCrnOdBG5809OYCw3HjLIu4Hnuoh+S1Rt6cvP1imafeRWA2e3704g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: avqgo5BixMBNSw2VtC8uhiRZrzFPlow71QA2SvkJif7y0dTZXF8pYiBshZKEr44d5jXYd52CB8trvMVR9uuwZzywwgwlw2saAOAFaOS+rFWOGhLvGT271pEl1GsCI+ANMMkpmnjQFZOue/KRaGXdlc2c6V0xrnLommtD3WVjloiPZIQqAsfqDtM0zzo8ADO0Qe1jK+CBQh68N6TcYRTqK1g3gnxYeB58bdE8uvsbuAga3WAKix9uZEBzRg7+Kl9Y63U+LBZKNXukUWIu0nXE6r1tMmDUwWWq4uVvvoNJXzpvrk/T/XWllrT4CxgCpLJK+Z51xL4gmaAutUEfW/pPOqnZXzbvCLCLBQ1zMNyjiPsXBjqMkeIv9hhzFkJ699FRq7Jb74VAdd83+em5s7nb5IgKIvWROjewEicp1yobVvZaUuSuLMMHmUWUl0iM2jh25eLUEeH5cIocde2U+d5AqTjmEhrReYkGZ95MW6Gia2DDyKvG/DJRXfVpVU5rbCksljN0KozDkVjKNcIevjXdqjqNFy0T7Tl49Boj7LhuYpH6qnM0YrVd8Gs01aDIYUyyvxIoYjm724KAxDKKKXtrEPRqOlq9EpKYDDarX1fHeT3DWEXxF5QxWBqNzmq+8Jwi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb5c5bf-18f4-4aae-ac23-08df3a31c2f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 05:09:10.8303 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UjGnvAMq7AA+dzxnHtlaCQ7MV6xYec8HJAj8ifZ/ti+LKjMMavHXcniBaXHdTjB+Fmy5XNd/zhNuZDcp36b9gTypSnkJDJ5bT72X31AeRMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8005
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=761a35039=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
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

T24gU3VuLCAyMDI2LTExLTAxIGF0IDExOjE1ICswODAwLCBUYW4gQ2hpIHdyb3RlOgo+IEtWTSBB
SUEgaW5pdGlhbGl6YXRpb24gdXNlcyB0aGUgUklTQy1WIE5VTUEgaGVscGVycyB0byBxdWVyeQo+
IHRoZSBzb2NrZXQgY291bnQgYW5kIHBlci1zb2NrZXQgaGFydCB0b3BvbG9neS4KPiAKPiBIb3dl
dmVyLCBLVk0gc3VwcG9ydCBjYW4gYmUgZW5hYmxlZCB3aXRob3V0IENPTkZJR19SSVNDVl9OVU1B
Lgo+IEluIHRoaXMgY29uZmlndXJhdGlvbiwga3ZtLWNwdS5jIGlzIGJ1aWx0IHdoaWxlIG51bWEu
YyBpcyBub3QsCj4gcmVzdWx0aW5nIGluIHVuZGVmaW5lZCByZWZlcmVuY2VzIHRvIHJpc2N2X3Nv
Y2tldF9jb3VudCgpLAo+IHJpc2N2X3NvY2tldF9oYXJ0X2NvdW50KCkgYW5kIHJpc2N2X3NvY2tl
dF9maXJzdF9oYXJ0aWQoKS4KPiAKPiBUaGUgdmlydCBtYWNoaW5lIGFscmVhZHkgZGV0ZXJtaW5l
cyB0aGUgaGFydCB0b3BvbG9neSB3aGVuCj4gaW5pdGlhbGl6aW5nIGl0cyBoYXJ0IGFycmF5cy4g
UGFzcyB0aGUgc29ja2V0IHRvcG9sb2d5IGRpcmVjdGx5Cj4gdG8gS1ZNIEFJQSBpbnN0ZWFkIG9m
IHF1ZXJ5aW5nIHRoZSBOVU1BIGhlbHBlcnMgYWdhaW4uCj4gCj4gVGhpcyByZW1vdmVzIHRoZSBi
dWlsZC10aW1lIGRlcGVuZGVuY3kgb24gQ09ORklHX1JJU0NWX05VTUEKPiB3aXRob3V0IGNoYW5n
aW5nIHRoZSBJTVNJQyBhZGRyZXNzIGNvbmZpZ3VyYXRpb24uCj4gCj4gU2lnbmVkLW9mZi1ieTog
VGFuIENoaSA8dGFuY2hpMjVAbWFpbHMudWNhcy5hYy5jbj4KClJldmlld2VkLWJ5OiBBbGlzdGFp
ciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+CgpBbGlzdGFpcgoKPiAtLS0KPiDC
oGh3L3Jpc2N2L2FpYS5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNSArKysrKwo+
IMKgaHcvcmlzY3YvdmlydC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMCArKysrKysr
KystCj4gwqB0YXJnZXQvcmlzY3Yva3ZtL2t2bS1jcHUuY8KgwqAgfCAxMCArKysrKy0tLS0tCj4g
wqB0YXJnZXQvcmlzY3Yva3ZtL2t2bS1zdHViLmPCoCB8wqAgMyArKy0KPiDCoHRhcmdldC9yaXNj
di9rdm0va3ZtX3Jpc2N2LmggfMKgIDUgKysrKy0KPiDCoDUgZmlsZXMgY2hhbmdlZCwgMjUgaW5z
ZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvaHcvcmlzY3YvYWlh
LmggYi9ody9yaXNjdi9haWEuaAo+IGluZGV4IGU0ZGNjNWFhZTAuLmVkOWI2MTNmM2MgMTAwNjQ0
Cj4gLS0tIGEvaHcvcmlzY3YvYWlhLmgKPiArKysgYi9ody9yaXNjdi9haWEuaAo+IEBAIC0xMiw2
ICsxMiwxMSBAQAo+IMKgI2luY2x1ZGUgImV4ZWMvaHdhZGRyLmgiCj4gwqAjaW5jbHVkZSAicWVt
dS9iaXRvcHMuaCIKPiDCoAo+ICt0eXBlZGVmIHN0cnVjdCBSSVNDVkFJQVNvY2tldCB7Cj4gK8Kg
wqDCoCB1aW50MzJfdCBoYXJ0aWRfYmFzZTsKPiArwqDCoMKgIHVpbnQzMl90IG51bV9oYXJ0czsK
PiArfSBSSVNDVkFJQVNvY2tldDsKPiArCj4gwqBzdGF0aWMgaW5saW5lIHVpbnQzMl90IGltc2lj
X251bV9iaXRzKHVpbnQzMl90IGNvdW50KQo+IMKgewo+IMKgwqDCoMKgIHVpbnQzMl90IHJldCA9
IDA7Cj4gZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L3ZpcnQuYyBiL2h3L3Jpc2N2L3ZpcnQuYwo+IGlu
ZGV4IDdlYzc1OTZiMjQuLmYxYjEzNTM2NDcgMTAwNjQ0Cj4gLS0tIGEvaHcvcmlzY3YvdmlydC5j
Cj4gKysrIGIvaHcvcmlzY3YvdmlydC5jCj4gQEAgLTg1Myw3ICs4NTMsMTUgQEAgc3RhdGljIHZv
aWQgdmlydF9tYWNoaW5lX2luaXQoTWFjaGluZVN0YXRlCj4gKm1hY2hpbmUpCj4gwqDCoMKgwqAg
fQo+IMKgCj4gwqDCoMKgwqAgaWYgKGt2bV9lbmFibGVkKCkgJiYgdmlydF91c2Vfa3ZtX2FpYV9h
cGxpY19pbXNpYyhzLT5haWFfdHlwZSkpCj4gewo+IC3CoMKgwqDCoMKgwqDCoCBrdm1fcmlzY3Zf
YWlhX2NyZWF0ZShtYWNoaW5lLCBJTVNJQ19NTUlPX0dST1VQX01JTl9TSElGVCwKPiArwqDCoMKg
wqDCoMKgwqAgZ19hdXRvZnJlZSBSSVNDVkFJQVNvY2tldCAqYWlhX3NvY2tldHMgPQo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ19uZXcoUklTQ1ZBSUFTb2NrZXQsIHNvY2tldF9j
b3VudCk7Cj4gK8KgwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBzb2NrZXRfY291bnQ7IGkr
Kykgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFpYV9zb2NrZXRzW2ldLmhhcnRpZF9iYXNl
ID0gcy0+c29jW2ldLmhhcnRpZF9iYXNlOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFpYV9z
b2NrZXRzW2ldLm51bV9oYXJ0cyA9IHMtPnNvY1tpXS5udW1faGFydHM7Cj4gK8KgwqDCoMKgwqDC
oMKgIH0KPiArCj4gK8KgwqDCoMKgwqDCoMKgIGt2bV9yaXNjdl9haWFfY3JlYXRlKGFpYV9zb2Nr
ZXRzLCBzb2NrZXRfY291bnQsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIElNU0lDX01NSU9fR1JPVVBfTUlOX1NISUZULAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVklS
VF9JUlFDSElQX05VTV9TT1VSQ0VTLAo+IFZJUlRfSVJRQ0hJUF9OVU1fTVNJUywKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMtPm1l
bW1hcFtWSVJUX0FQTElDX1NdLmJhc2UsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLT5tZW1tYXBbVklSVF9JTVNJQ19TXS5iYXNl
LAo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3Yva3ZtL2t2bS1jcHUuYyBiL3RhcmdldC9yaXNj
di9rdm0va3ZtLWNwdS5jCj4gaW5kZXggNDVhZDVlMTUyNS4uMWE3NGI5YTM3ZSAxMDA2NDQKPiAt
LS0gYS90YXJnZXQvcmlzY3Yva3ZtL2t2bS1jcHUuYwo+ICsrKyBiL3RhcmdldC9yaXNjdi9rdm0v
a3ZtLWNwdS5jCj4gQEAgLTQ2LDcgKzQ2LDcgQEAKPiDCoCNpbmNsdWRlICJzYmlfZWNhbGxfaW50
ZXJmYWNlLmgiCj4gwqAjaW5jbHVkZSAiY2hhcmRldi9jaGFyLWZlLmgiCj4gwqAjaW5jbHVkZSAi
c3lzdGVtL3J1bnN0YXRlLmgiCj4gLSNpbmNsdWRlICJody9yaXNjdi9udW1hLmgiCj4gKyNpbmNs
dWRlICJody9yaXNjdi9haWEuaCIKPiDCoAo+IMKgI2RlZmluZSBQUl9SSVNDVl9WX1NFVF9DT05U
Uk9MwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA2OQo+IMKgI2RlZmluZSBQUl9SSVNDVl9WX1ZTVEFU
RV9DVFJMX09OwqDCoMKgwqDCoMKgwqDCoMKgIDIKPiBAQCAtMTg5Nyw3ICsxODk3LDggQEAgdm9p
ZCBrdm1fYXJjaF9hY2NlbF9jbGFzc19pbml0KE9iamVjdENsYXNzICpvYykKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgImF1dG8iKTsKPiDCoH0KPiDCoAo+IC12b2lkIGt2bV9yaXNjdl9haWFfY3JlYXRlKE1h
Y2hpbmVTdGF0ZSAqbWFjaGluZSwgdWludDY0X3QKPiBncm91cF9zaGlmdCwKPiArdm9pZCBrdm1f
cmlzY3ZfYWlhX2NyZWF0ZShjb25zdCBSSVNDVkFJQVNvY2tldCAqc29ja2V0cywKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3Qgc29j
a2V0X2NvdW50LCB1aW50NjRfdAo+IGdyb3VwX3NoaWZ0LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDY0X3QgYWlhX2lycV9udW0sIHVp
bnQ2NF90Cj4gYWlhX21zaV9udW0sCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50NjRfdCBhcGxpY19iYXNlLCB1aW50NjRfdCBpbXNpY19i
YXNlLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdWludDY0X3QgZ3Vlc3RfbnVtKQo+IEBAIC0xOTA1LDcgKzE5MDYsNiBAQCB2b2lkIGt2bV9y
aXNjdl9haWFfY3JlYXRlKE1hY2hpbmVTdGF0ZQo+ICptYWNoaW5lLCB1aW50NjRfdCBncm91cF9z
aGlmdCwKPiDCoMKgwqDCoCBpbnQgcmV0LCBpOwo+IMKgwqDCoMKgIGludCBhaWFfZmQgPSAtMTsK
PiDCoMKgwqDCoCB1aW50NjRfdCBkZWZhdWx0X2FpYV9tb2RlOwo+IC3CoMKgwqAgdWludDY0X3Qg
c29ja2V0X2NvdW50ID0gcmlzY3Zfc29ja2V0X2NvdW50KG1hY2hpbmUpOwo+IMKgwqDCoMKgIHVp
bnQ2NF90IG1heF9oYXJ0X3Blcl9zb2NrZXQgPSAwOwo+IMKgwqDCoMKgIHVpbnQ2NF90IHNvY2tl
dCwgYmFzZV9oYXJ0LCBoYXJ0X2NvdW50LCBzb2NrZXRfaW1zaWNfYmFzZSwKPiBpbXNpY19hZGRy
Owo+IMKgwqDCoMKgIHVpbnQ2NF90IHNvY2tldF9iaXRzLCBoYXJ0X2JpdHMsIGd1ZXN0X2JpdHM7
Cj4gQEAgLTIwMDYsOCArMjAwNiw4IEBAIHZvaWQga3ZtX3Jpc2N2X2FpYV9jcmVhdGUoTWFjaGlu
ZVN0YXRlCj4gKm1hY2hpbmUsIHVpbnQ2NF90IGdyb3VwX3NoaWZ0LAo+IMKgCj4gwqDCoMKgwqAg
Zm9yIChzb2NrZXQgPSAwOyBzb2NrZXQgPCBzb2NrZXRfY291bnQ7IHNvY2tldCsrKSB7Cj4gwqDC
oMKgwqDCoMKgwqDCoCBzb2NrZXRfaW1zaWNfYmFzZSA9IGltc2ljX2Jhc2UgKyBzb2NrZXQgKiAo
MVUgPDwKPiBncm91cF9zaGlmdCk7Cj4gLcKgwqDCoMKgwqDCoMKgIGhhcnRfY291bnQgPSByaXNj
dl9zb2NrZXRfaGFydF9jb3VudChtYWNoaW5lLCBzb2NrZXQpOwo+IC3CoMKgwqDCoMKgwqDCoCBi
YXNlX2hhcnQgPSByaXNjdl9zb2NrZXRfZmlyc3RfaGFydGlkKG1hY2hpbmUsIHNvY2tldCk7Cj4g
K8KgwqDCoMKgwqDCoMKgIGhhcnRfY291bnQgPSBzb2NrZXRzW3NvY2tldF0ubnVtX2hhcnRzOwo+
ICvCoMKgwqDCoMKgwqDCoCBiYXNlX2hhcnQgPSBzb2NrZXRzW3NvY2tldF0uaGFydGlkX2Jhc2U7
Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgIGlmIChtYXhfaGFydF9wZXJfc29ja2V0IDwgaGFydF9j
b3VudCkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtYXhfaGFydF9wZXJfc29ja2V0ID0g
aGFydF9jb3VudDsKPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2t2bS9rdm0tc3R1Yi5jIGIv
dGFyZ2V0L3Jpc2N2L2t2bS9rdm0tCj4gc3R1Yi5jCj4gaW5kZXggNjRlMzljOTZkOC4uZjkyOTE2
MTYyOCAxMDA2NDQKPiAtLS0gYS90YXJnZXQvcmlzY3Yva3ZtL2t2bS1zdHViLmMKPiArKysgYi90
YXJnZXQvcmlzY3Yva3ZtL2t2bS1zdHViLmMKPiBAQCAtOSw3ICs5LDggQEAKPiDCoCNpbmNsdWRl
ICJxZW11L29zZGVwLmgiCj4gwqAjaW5jbHVkZSAidGFyZ2V0L3Jpc2N2L2t2bS9rdm1fcmlzY3Yu
aCIKPiDCoAo+IC12b2lkIGt2bV9yaXNjdl9haWFfY3JlYXRlKE1hY2hpbmVTdGF0ZSAqbWFjaGlu
ZSwgdWludDY0X3QKPiBncm91cF9zaGlmdCwKPiArdm9pZCBrdm1fcmlzY3ZfYWlhX2NyZWF0ZShj
b25zdCBSSVNDVkFJQVNvY2tldCAqc29ja2V0cywKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3Qgc29ja2V0X2NvdW50LCB1aW50NjRf
dAo+IGdyb3VwX3NoaWZ0LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdWludDY0X3QgYWlhX2lycV9udW0sIHVpbnQ2NF90Cj4gYWlhX21zaV9u
dW0sCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB1aW50NjRfdCBhcGxpY19iYXNlLCB1aW50NjRfdCBpbXNpY19iYXNlLAo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDY0X3QgZ3Vlc3Rf
bnVtKQo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3Yva3ZtL2t2bV9yaXNjdi5oCj4gYi90YXJn
ZXQvcmlzY3Yva3ZtL2t2bV9yaXNjdi5oCj4gaW5kZXggYWVmNjgxZjBhMi4uYmFkNzhlMjhmNCAx
MDA2NDQKPiAtLS0gYS90YXJnZXQvcmlzY3Yva3ZtL2t2bV9yaXNjdi5oCj4gKysrIGIvdGFyZ2V0
L3Jpc2N2L2t2bS9rdm1fcmlzY3YuaAo+IEBAIC0yMSw2ICsyMSw4IEBACj4gwqAKPiDCoCNpbmNs
dWRlICJ0YXJnZXQvcmlzY3YvY3B1LXFvbS5oIgo+IMKgCj4gK3R5cGVkZWYgc3RydWN0IFJJU0NW
QUlBU29ja2V0IFJJU0NWQUlBU29ja2V0Owo+ICsKPiDCoHZvaWQga3ZtX3Jpc2N2X3Jlc2V0X3Zj
cHUoUklTQ1ZDUFUgKmNwdSk7Cj4gwqAvKioKPiDCoCAqIGt2bV9yaXNjdl9zZXRfaXJxOgo+IEBA
IC0yOSw3ICszMSw4IEBAIHZvaWQga3ZtX3Jpc2N2X3Jlc2V0X3ZjcHUoUklTQ1ZDUFUgKmNwdSk7
Cj4gwqAgKiBAbGV2ZWw6ICUwIHRvIGNsZWFyIHRoZSBpbnRlcnJ1cHQsIG5vbi16ZXJvIHRvIHNl
dCBpdC4KPiDCoCAqLwo+IMKgdm9pZCBrdm1fcmlzY3Zfc2V0X2lycShSSVNDVkNQVSAqY3B1LCBp
bnQgaXJxLCBpbnQgbGV2ZWwpOwo+IC12b2lkIGt2bV9yaXNjdl9haWFfY3JlYXRlKE1hY2hpbmVT
dGF0ZSAqbWFjaGluZSwgdWludDY0X3QKPiBncm91cF9zaGlmdCwKPiArdm9pZCBrdm1fcmlzY3Zf
YWlhX2NyZWF0ZShjb25zdCBSSVNDVkFJQVNvY2tldCAqc29ja2V0cywKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3Qgc29ja2V0X2Nv
dW50LCB1aW50NjRfdAo+IGdyb3VwX3NoaWZ0LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDY0X3QgYWlhX2lycV9udW0sIHVpbnQ2NF90
Cj4gYWlhX21zaV9udW0sCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB1aW50NjRfdCBhcGxpY19iYXNlLCB1aW50NjRfdCBpbXNpY19iYXNlLAo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWlu
dDY0X3QgZ3Vlc3RfbnVtKTsK

