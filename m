Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB0DC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOWRX-0007uj-FD; Tue, 02 Jul 2024 01:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRU-0007ts-NI
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:40 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRR-0006TL-TM
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719899559; x=1751435559;
 h=from:to:cc:subject:date:message-id:content-id:
 content-transfer-encoding:mime-version;
 bh=WA4JmnFO6quJgJjuMmHqYZlma04wF7aXCgGdNhPC1xo=;
 b=epY4995ciGUCqvHEYKpKMoMsK5w5kwyUXSidJPXavUHZnt4HsYOJBD24
 OEI1zUAiq6wG1W/3Bu9ea2aDJiL7H57nVY+m3E6b/EsD0OkPBkNc2ziE6
 jeVhXBkgJ+VMd+5izWhLqy3FHTa2Ji9aoiRbinbKUvn7ALaEru2DKz/ZC
 UISjqcA8mna15EJQt/bZ5mTybbE5caAduPV3o4bZCV3DhIs5pm9i+VWOM
 m4Agciti67QjdYIUq1db1UDaDTYiS5qBVlhYrlK59G3txfxHfnEFGPSZr
 bQlQDIEhALCub2UxlOaCtw1mZUKH1Ny/Qo7g7g9SeYmAJMb1klaayz+Xg Q==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208";a="15715665"
X-MGA-submission: =?us-ascii?q?MDH7J+G00Vc8OnHMOHsR0T63+Nmlr0nA7a2GgF?=
 =?us-ascii?q?LUCbWcL09pKTTjd8e4Iyq8clSTPoXSx8bQMk7aEkosgTBIByhsRkbVjx?=
 =?us-ascii?q?KDj+5punL2xQ7UZONt1PKFET/0emEfCs5eL/lE5DM3GzR3StPTzJaOML?=
 =?us-ascii?q?ReDJnF4JVr818QsnF8ePBMUQ=3D=3D?=
Received: from mail-am6eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.105])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 07:52:32 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZrL5kBs38kYzameSwerqVEWO+OdPNE82F5aTFBFrfCU696WxL+B0iW5+g7Dk1W4Txmy2iHtWBvl4KwcNFVYckIpMnGWy4kGA2+9AW8F5X1D2qEB9zd44cyPqwUIHGgf4GY4tnI/gHoBZu83QusD9qYV9CZRpfA+2mCsjMldX3z23fv1bf35sHlc11fN/7oeeDYApw4sm0IdXHhbzzxtgQ9A9r5zGGYNNMKtmXlL4eQaxZEoELEvKbAeyy2qH/HFAEYfijs56djuAxqSz+rMqwI2YpG9QYbh8B5EXAlzfvVpH/7DCVVV2m5fVwGHyC3JwuM7oMS8Lmw2MEwSg/YB5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WA4JmnFO6quJgJjuMmHqYZlma04wF7aXCgGdNhPC1xo=;
 b=Pw8jsaO49wo3ek0gnt6aSt4nVOObSDhhLW8gQoHXi/zSNInL3gO7WbdmJeryfZT4NMSzBsWjIXrNx03UEehnFdUcoyPtm1ifoktMd44L7KN4Pvjtf96smXWt9808QzCkKwRJoSKvv9AXquLJz3RROGo2/RQBlO4csU+vXKc2cWY7tTpcj5q+37uWpfcCbcnyfcUxywIAFzsQqFfrTIe5dQdleA6mJl0g30iEgXMwU67ZLrMgKavoYfVTNhJr88t4YZBOg3SW1ECMOLdMqiGtW+Z8HSGKGdtuNjnQFKDF4AXGTFy4E6cFdI1ffF4bzJOqD68LujLAOE1bUSicxakqAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WA4JmnFO6quJgJjuMmHqYZlma04wF7aXCgGdNhPC1xo=;
 b=PsklfqbPhhDYoSr53oSDIZ7dqqExQNpfxUjQSriLByxSlKb0+qlJUPVCwHdsWbXFVcoaG4UWDFSWD8gcqtFm4eKny6q98X01+aoW1Bf56U8uBzmR60n5oh29reDNKw/4w7vEJGkFxWAtlG5aL77hOeuzsCj32hIBjfd8UPu8gPHJcisDC+zGYniCzTJGcWsVESCf2Mb/F9A2adyv0Jt+3C2tlyRNnHM/vq/bSEk6L8ZI2oG64pI3p5tvMOy076hqXw/pakVlIvnp29S5CbGPIeFCndALFmyxal9hXHes6UQ7LVXkQJ6y/7uZz8sYb4FTugkmFp8l/Fa4gjpnKIAvTg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7080.eurprd07.prod.outlook.com (2603:10a6:20b:239::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.21; Tue, 2 Jul
 2024 05:52:29 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 05:52:29 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, Clement Mathieu--Drif <cmdetu@gmail.com>
Subject: [PATCH ats_vtd v5 00/22] ATS support for VT-d 
Thread-Topic: [PATCH ats_vtd v5 00/22] ATS support for VT-d 
Thread-Index: AQHazEQGTuJM3iTlWUqCZ55Q529ilg==
Date: Tue, 2 Jul 2024 05:52:29 +0000
Message-ID: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7080:EE_
x-ms-office365-filtering-correlation-id: 3cc2560f-7eec-47c1-1c87-08dc9a5b28d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T2xoT1VaQlBNZFowTDdYc2d6RlV4R3draFpFYWNCRURJZC9zYnZ0citwRFlu?=
 =?utf-8?B?enZrT2ZXanZ6N2dScml5alVKU3IvUGxyZFBJMWgva1RCaCsydVA5Yjk4Zm5j?=
 =?utf-8?B?TlduS296VFZDTy9xMVBsSzVUekRod21xdHFOWjRqVGFjRzhaY3RHZHhrZllm?=
 =?utf-8?B?T200MDhUZUprUmpDSDlPemFMYWdMd2FIUFFDS2VmMk54UFByVDlUVWNuWEhz?=
 =?utf-8?B?MnlNb0xVTHVNMVpxdTQ1ZVR2akptRXlqTThHWHJVRFBjRVkzbDBaWU5DSThX?=
 =?utf-8?B?UkE5VGpxa1VaMmFZdXh2NGp4ckFoOGZUYTIwZlYxUHpoek9SQWJZakZ4VGYv?=
 =?utf-8?B?WjgvTWUyYlpXNTRrblFtVG82Yk5PL0tQcWpGVWV2aWVmZ2tRdnBBbDNneDBE?=
 =?utf-8?B?MU9JcVl1akRpNkNYWDhrYTBmYVNsR0t4T1lkM0lTb0ZVeEYrWEw5WFdOa0tv?=
 =?utf-8?B?c3VJL1o1ZkQrTzZCdVpMUGNTdEQ2VkZQWU1zeG16TUViSnlzd0dYbHFFWW5V?=
 =?utf-8?B?TXNvd1NjNVRHRkYraVhBcVIwTW1YWTNwR2NBYlJHdTFwM1A1YmZva3ZmK3JH?=
 =?utf-8?B?a2lpV3ZjQm1MN0tEY2NEWnFFZTVzcWFLaFdkWDhycXU3Z2pSMmZaQWtYUnVO?=
 =?utf-8?B?dzN3NmlDclNlamZmWjVvMGg1UWhxZXVoNVdlRGlEZmFnMnFmLzh2V0pjNVE5?=
 =?utf-8?B?NC9qWnQyWHZCeUtWKy9qNWlOSXdJNW1KempQajFkNjRPOVBrOVA1bW1DVGFX?=
 =?utf-8?B?UzNsZkNHMExFTUFueVdzelkrdmFkWEJFempiSmJod3Z0TnB4ZWxKc29odkdJ?=
 =?utf-8?B?Y1NuU2ozT2tvV1BkbGVUOVJmSXo4eFB2bU8xY0F5elBkNkRWNjQya0xLZUVK?=
 =?utf-8?B?VENUdEpwOTRtRE80Wkc3VkQrUk4xbjBOdEQxVFhDQVJkSThRd3YvYklkTDZ5?=
 =?utf-8?B?MXpyWW5pb05nVkw0bXZqUW1SM1Y5amhRYkdIK0lIcURwVHR3bjlmQjgxblh6?=
 =?utf-8?B?dWY5aTNIS2JScDh0eTFBcVNhNVBBVXZ5bVZvVGl1NGVrMitYNTllTlRJZTFZ?=
 =?utf-8?B?Z3Y3cXNIZ093NER2K2xIRUU1ZlJWZFJobEk1UFdMdHhGY0xsZ3FJVG9KZ2I0?=
 =?utf-8?B?Y3ZYSWdIZURlV2VBQ3lTWGtsZnBxTmRxMHd6Uy9pTThsZkNQbk1mc1BqUUVl?=
 =?utf-8?B?UG5MVXluNkY5QW9ZOVlzdDN4dTArS1JOeUtKR1drRWk0Y2NCVTlvU2xYN01i?=
 =?utf-8?B?TjBRa2RLeUg4V3lDbXZhMDMrYmdSSFdTZVk0alJodUhlWS9CU1NQODBqSmpt?=
 =?utf-8?B?N3Y0clY3NlJ6TGZucmZwUldhVHRNdkUxRFJtS1l4Q2UvK0JpM3hzMHJ5MFV3?=
 =?utf-8?B?TXNUenFzemhRaXdsUTNiZWxLSHlLUStFdjg3NG5Sb1Fva081dTFFbTJFdHNi?=
 =?utf-8?B?cTVrcVc1ZlhyQjB4RlFFbDBIbWlzcEdKTUIxWUpyeXZMSGdPUEJrQ2oyS0ZQ?=
 =?utf-8?B?bXI5aXBscGVHeUhnUkJEUTRQUW9wYUdxVzhTSEhqdVZCaUg0SndtYVpiUW80?=
 =?utf-8?B?QWg2NDFXYzI0a1JLcFJCOVJGZUo0RjRMUGY3MFJtOG9meHYzd3Z1QXQzSklh?=
 =?utf-8?B?MHJMWlVlMDYvcXRXS29CQlg0bWQwbEVZVWhvZXJTRldzQlVYdSttK3pvVzlZ?=
 =?utf-8?B?MDNIVDF6Z1JGTGttcmU4VGlaSldLQXZWc24zcWlYZ0tNTjRVZktwSjNuZWl1?=
 =?utf-8?B?R2VhR0FMajJnWk9udHluL2dkNHU2ZlJSR3lJc0dYL24vZTN3WCs5blo3b2xW?=
 =?utf-8?Q?bkJUZrtZm9jOIfkK3pHEBdBSQhfx11GNzJ/4w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWlkVVVQRmJQOXdiNkk2QUpSeGw3YkJraldQbVJTRDNuRVF2cTQ3Mjlpemdp?=
 =?utf-8?B?d2F6MFFoMUt0empJMTFHWU91dXJxQnlGdm1sd2lPZ1dwV3I5OVZudFdUcXAz?=
 =?utf-8?B?UW4reVVVaWQwMmJHekhxb2RGWGg2QWdSa3lmS3NuZmloYlhGVjNrazE0MlI5?=
 =?utf-8?B?bU5XTHQzQkp0VmJMR3YwZk9vWkJvQ3BQQnNLb3BtOXNNREFNblJnZDg4bXdr?=
 =?utf-8?B?WW1MMDRTYVRxOFhmSEFyMTNKTTh1OVZ3OFE1aHQ3Zk5xZ3FqakVoSFdtZElT?=
 =?utf-8?B?T2RUL0RqZCtUcFlad0RSMVBwL3p6QmlJakZhcjN4N1VjcE43Uk9GbXk5cXQ1?=
 =?utf-8?B?b0crYXVCUEl0NzFyTzFoR0R1Zm5xclJhWitaVDlaZlFjVEE1VHlOcWZONzVr?=
 =?utf-8?B?VHUxREY5dTc3WEVZSVdPaDZkQ0w5eDZxUnBiRXdxbzhLem1JMVIvOFNrcFNp?=
 =?utf-8?B?RE1DUG9IQmpzaitVNUJZTlpZRkttOE11Nk9IWTlCbmZvTEN4T0VjWDZSOTRX?=
 =?utf-8?B?a00yakdnWmQ2cFU2aWxWOHpKTTA5Z2F2QUdKRndZcm95VGJTSkt5Yyt0RjY3?=
 =?utf-8?B?dkVZMmZPemV0SlhQbWxudUNLZTV3WGVUemVtOHRWQXJyV1JMenVxSFpHYysv?=
 =?utf-8?B?enJ2THZ1T3FDUWp0NEY1dHJEdjloSm1OZCs4NmI5Q1h1T0NSV3J2Y3A3NXBW?=
 =?utf-8?B?WjF0SXhhMjhhVnAxVmMzM2lnc2FPUEZqRExFaEVZZ2xSZEtveWZMN29zQmo2?=
 =?utf-8?B?UWZQUXJIeUJEV0FXL1lyZExoNit0Z01McDVvNXN6SUh3ZTFCaFd5Kzh0SVBa?=
 =?utf-8?B?eXU0czh6V0RrMDNyMjRWTmhLUjU2K0Y0dnBKNkwxWTlsMXdwZ1dtVzg0TVBX?=
 =?utf-8?B?bXBvVG9yZGlnYUY5TjZTbWQreEQ4TUNlNjRsUHhUTVJnME5yRnIvTFdaUkhB?=
 =?utf-8?B?U1BCdnArdm1Va1lNTll5ZHJkTzJVNnlMUW1kSUI0azQ0bUsrTDhpblhXTEhr?=
 =?utf-8?B?SzNGSTRXNFo5U28rNUpRSzBTYkYvdis0R29yWXYyOWtPOExOWktOaUxhUDRE?=
 =?utf-8?B?S1ZiWld1KzdZaGE1VGxXSXBYWmkwd2RsMzlsbnVQTEVIOS9Ec0NpSnBINzBi?=
 =?utf-8?B?K1VIWlFkM3ltcUdGckV3N2krdmtnTEdhcm1WZmxTWS9VT0U0NlM2THduWDZI?=
 =?utf-8?B?cEc5eTlBbTlhcFZXQmMvM21VNVE1WTBheXJCQmIraHdnbWhSTUwxZS92ODBt?=
 =?utf-8?B?MkFsVjFXUWpIOUpnbXRLaU40R1Fydm1zZlRkSk5FU1o3TWpSeFVhdmNIUGlM?=
 =?utf-8?B?MEJqOS8wQU9sbW41RFdDeDV6WUlVY0EzeTVtenYweVZTbFlCY1JkWDJiSVRV?=
 =?utf-8?B?OTEyb0cwcDYrWXRMakJTN05yd0pUOW5kb0tLRVcrRWpUS2oxWERmLzIxWmNk?=
 =?utf-8?B?WENpaTJlaEVqbjh3bFRZZC8rLytWQnYrWjA2dzI5SUc0ZC9Fd2xXQVcyN0cw?=
 =?utf-8?B?cW9jSWgzcE9ybnhJT0dRS211S1Y0T01vQnRMVFREUlBPYk5CZEVTZ3N6WFZ0?=
 =?utf-8?B?YVNZUVhGY3RBWkFaSzE5R2plR1pmN1JYT1BhK3ZxTnlFTEJYaUYxNTVxMFkv?=
 =?utf-8?B?MUNGajFPODlPaE15NHNCZ3E0ckhsdkhvcC9iVEdrVStwSW9kUDgzRThaMzJw?=
 =?utf-8?B?QXY5dmhZajFXNEZ6cExHNmRpT0JKRWJHUW1tbTRCWklpMk10YXFtYkJjRTB4?=
 =?utf-8?B?NmFpMzVRUjZaWVZGWW9mZWpTL3JqRElvbENPbnFkRGJJS215N0UxaHIzL3VV?=
 =?utf-8?B?RDM0K24ySWxZcGtDWkU0dWpzV25haHJnOTg5cExHaVFFaWhoNWpXODlXZDJr?=
 =?utf-8?B?VXZSaE5sNG8xNnpkR3JBUnI4L2E1Vng2QnlTQWxpclhVREt3RVhXbElWTVB1?=
 =?utf-8?B?YlgvZEhuc2V5Zmw1bFlPS2x2NXE1eVM5VGdPS2U3UHlsbldYZzhlRFkxbTVG?=
 =?utf-8?B?ZnVYWlRFcXlDc210VVlRQ1pLd1l0QjRGZ2xZT29aWHY0MHBZNndHRHB5cE9Q?=
 =?utf-8?B?YXFWK2o2UWZmY2JEamlWTTJMM1N3ZVk4MGdlT3JiSHpTTE1HdFF0VTRYWnhP?=
 =?utf-8?B?QWZldVlMVXJSbER4b0RQNU0xN3N6SWdoQWlpd2xhcjJqUW12RlZXY1p6MUpy?=
 =?utf-8?Q?+GDWxLDSMPsk7dlaKBkf8Qs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99A8722FDD8E6B45B2092387C17A64A4@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc2560f-7eec-47c1-1c87-08dc9a5b28d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 05:52:29.7070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iiOPYtbtI99hLZ1tEGoCXH9s3nx2wKvz7Wp/t3cC9c7BHaSWFKylLA8V8v/HrtIryUvoQ/7dsy9FfdPq41bfdlcBGnjVLJgpCrWuNwcY5I7Wtp8SykimgBxGEGqZ1tjH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7080
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

RnJvbTogQ2xlbWVudCBNYXRoaWV1LS1EcmlmIDxjbWRldHVAZ21haWwuY29tPg0KDQpUaGlzIHNl
cmllcyBiZWxvbmdzIHRvIGEgbGlzdCBvZiBzZXJpZXMgdGhhdCBhZGQgU1ZNIHN1cHBvcnQgZm9y
IFZULWQuDQoNCkFzIGEgc3RhcnRpbmcgcG9pbnQsIHdlIHVzZSB0aGUgc2VyaWVzIGNhbGxlZCAn
aW50ZWxfaW9tbXU6IEVuYWJsZSBzdGFnZS0xIHRyYW5zbGF0aW9uJyAocmZjMikgYnkgWmhlbnpo
b25nIER1YW4gYW5kIFlpIExpdS4NCg0KSGVyZSB3ZSBmb2N1cyBvbiB0aGUgaW1wbGVtZW50YXRp
b24gb2YgQVRTIHN1cHBvcnQgaW4gdGhlIElPTU1VIGFuZCBvbiBhIFBDSS1sZXZlbA0KQVBJIGZv
ciBBVFMgdG8gYmUgdXNlZCBieSB2aXJ0dWFsIGRldmljZXMuDQoNClRoaXMgd29yayBpcyBiYXNl
ZCBvbiB0aGUgVlQtZCBzcGVjaWZpY2F0aW9uIHZlcnNpb24gNC4xIChNYXJjaCAyMDIzKS4NCkhl
cmUgaXMgYSBsaW5rIHRvIGEgR2l0SHViIHJlcG9zaXRvcnkgd2hlcmUgeW91IGNhbiBmaW5kIHRo
ZSBmb2xsb3dpbmcgZWxlbWVudHMgOg0KICAgIC0gUWVtdSB3aXRoIGFsbCB0aGUgcGF0Y2hlcyBm
b3IgU1ZNDQogICAgICAgIC0gQVRTDQogICAgICAgIC0gUFJJDQogICAgICAgIC0gRGV2aWNlIElP
VExCIGludmFsaWRhdGlvbnMNCiAgICAgICAgLSBSZXF1ZXN0cyB3aXRoIGFscmVhZHkgdHJhbnNs
YXRlZCBhZGRyZXNzZXMNCiAgICAtIEEgZGVtbyBkZXZpY2UNCiAgICAtIEEgc2ltcGxlIGRyaXZl
ciBmb3IgdGhlIGRlbW8gZGV2aWNlDQogICAgLSBBIHVzZXJzcGFjZSBwcm9ncmFtIChmb3IgdGVz
dGluZyBhbmQgZGVtb25zdHJhdGlvbiBwdXJwb3NlcykNCg0KaHR0cHM6Ly9naXRodWIuY29tL0J1
bGxTZXF1YW5hL1FlbXUtaW4tZ3Vlc3QtU1ZNLWRlbW8NCg0KdjINCiAgICAtIGhhbmRsZSBodWdl
IHBhZ2VzIGJldHRlciBieSBkZXRlY3RpbmcgdGhlIHBhZ2UgdGFibGUgbGV2ZWwgYXQgd2hpY2gg
dGhlIHRyYW5zbGF0aW9uIGVycm9ycyBvY2N1cg0KICAgIC0gQ2hhbmdlcyBhZnRlciByZXZpZXcg
YnkgWmhlblpob25nIER1YW4gOg0KICAgIAktIFNldCB0aGUgYWNjZXNzIGJpdCBhZnRlciBjaGVj
a2luZyBwZXJtaXNzaW9ucw0KICAgIAktIGhlbHBlciBmb3IgUEFTSUQgYW5kIEFUUyA6IG1ha2Ug
dGhlIGNvbW1pdCBtZXNzYWdlIG1vcmUgYWNjdXJhdGUgKCdwcmVzZW50JyByZXBsYWNlZCB3aXRo
ICdlbmFibGVkJykNCiAgICAJLSBwY2llX3Bhc2lkX2luaXQ6IGFkZCBQQ0lfUEFTSURfQ0FQX1dJ
RFRIX1NISUZUIGFuZCB1c2UgaXQgaW5zdGVhZCBvZiBQQ0lfRVhUX0NBUF9QQVNJRF9TSVpFT0Yg
Zm9yIHNoaWZ0aW5nIHRoZSBwYXNpZCB3aWR0aCB3aGVuIHByZXBhcmluZyB0aGUgY2FwYWJpbGl0
eSByZWdpc3Rlcg0KICAgIAktIHBjaTogZG8gbm90IGNoZWNrIHBjaV9idXNfYnlwYXNzX2lvbW11
IGFmdGVyIGNhbGxpbmcgcGNpX2RldmljZV9nZXRfaW9tbXVfYnVzX2RldmZuDQogICAgCS0gZG8g
bm90IGFsdGVyIGZvcm1hdHRpbmcgb2YgSU9NTVVUTEJFbnRyeSBkZWNsYXJhdGlvbg0KICAgIAkt
IHZ0ZF9pb3ZhX2ZsX2NoZWNrX2Nhbm9uaWNhbCA6IGRpcmVjdGx5IHVzZSBzLT5hd19iaXRzIGlu
c3RlYWQgb2YgYXcgZm9yIHRoZSBzYWtlIG9mIGNsYXJpdHkNCg0KdjMNCiAgICAtIHJlYmFzZSBv
biBuZXcgdmVyc2lvbiBvZiBaaGVuemhvbmcncyBmbHRzIGltcGxlbWVudGF0aW9uDQogICAgLSBm
aXggdGhlIGF0YyBsb29rdXAgb3BlcmF0aW9uIChjaGVjayB0aGUgbWFzayBiZWZvcmUgcmV0dXJu
aW5nIGFuIGVudHJ5KQ0KICAgIC0gYWRkIGEgdW5pdCB0ZXN0IGZvciB0aGUgQVRDDQogICAgLSBz
dG9yZSBhIHVzZXIgcG9pbnRlciBpbiB0aGUgaW9tbXUgbm90aWZpZXJzIHRvIHNpbXBsaWZ5IHRo
ZSBpbXBsZW1lbnRhdGlvbiBvZiBzdm0gZGV2aWNlcw0KICAgIENoYW5nZXMgYWZ0ZXIgcmV2aWV3
IGJ5IFpoZW56aG9uZyA6DQogICAgCS0gc3RvcmUgdGhlIGlucHV0IHBhc2lkIGluc3RlYWQgb2Yg
cmlkMnBhc2lkIHdoZW4gcmV0dXJuaW5nIGFuIGVudHJ5IGFmdGVyIGEgdHJhbnNsYXRpb24NCiAg
ICAJLSBzcGxpdCB0aGUgQVRDIGltcGxlbWVudGF0aW9uIGFuZCBpdHMgdW5pdCB0ZXN0cw0KDQp2
NA0KICAgIENoYW5nZXMgYWZ0ZXIgaW50ZXJuYWwgcmV2aWV3DQogICAgCS0gRml4IHRoZSBub3dy
aXRlIG9wdGltaXphdGlvbiwgYW4gQVRTIHRyYW5zbGF0aW9uIHdpdGhvdXQgdGhlIG5vd3JpdGUg
ZmxhZyBzaG91bGQgbm90IGZhaWwgd2hlbiB0aGUgd3JpdGUgcGVybWlzc2lvbiBpcyBub3Qgc2V0
DQoNCnY1DQogICAgQ2hhbmdlcyBhZnRlciByZXZpZXcgYnkgUGhpbGlwcGUgOg0KICAgIAktIGNo
YW5nZSB0aGUgdHlwZSBvZiAnbGV2ZWwnIHRvIHVuc2lnbmVkIGluIHZ0ZF9sb29rdXBfaW90bGIN
Cg0KQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiAoMjIpOg0KICBpbnRlbF9pb21tdTogZml4IEZSQ0Qg
Y29uc3RydWN0aW9uIG1hY3JvLg0KICBpbnRlbF9pb21tdTogbWFrZSB0eXBlcyBtYXRjaA0KICBp
bnRlbF9pb21tdTogcmV0dXJuIHBhZ2Ugd2FsayBsZXZlbCBldmVuIHdoZW4gdGhlIHRyYW5zbGF0
aW9uIGZhaWxzDQogIGludGVsX2lvbW11OiBkbyBub3QgY29uc2lkZXIgd2FpdF9kZXNjIGFzIGFu
IGludmFsaWQgZGVzY3JpcHRvcg0KICBtZW1vcnk6IGFkZCBwZXJtaXNzaW9ucyBpbiBJT01NVUFj
Y2Vzc0ZsYWdzDQogIHBjaWU6IGFkZCBoZWxwZXIgdG8gZGVjbGFyZSBQQVNJRCBjYXBhYmlsaXR5
IGZvciBhIHBjaWUgZGV2aWNlDQogIHBjaWU6IGhlbHBlciBmdW5jdGlvbnMgdG8gY2hlY2sgaWYg
UEFTSUQgYW5kIEFUUyBhcmUgZW5hYmxlZA0KICBpbnRlbF9pb21tdTogZGVjbGFyZSBzdXBwb3J0
ZWQgUEFTSUQgc2l6ZQ0KICBwY2k6IGNhY2hlIHRoZSBidXMgbWFzdGVyaW5nIHN0YXR1cyBpbiB0
aGUgZGV2aWNlDQogIHBjaTogYWRkIElPTU1VIG9wZXJhdGlvbnMgdG8gZ2V0IGFkZHJlc3Mgc3Bh
Y2VzIGFuZCBtZW1vcnkgcmVnaW9ucw0KICAgIHdpdGggUEFTSUQNCiAgbWVtb3J5OiBzdG9yZSB1
c2VyIGRhdGEgcG9pbnRlciBpbiB0aGUgSU9NTVUgbm90aWZpZXJzDQogIHBjaTogYWRkIGEgcGNp
LWxldmVsIGluaXRpYWxpemF0aW9uIGZ1bmN0aW9uIGZvciBpb21tdSBub3RpZmllcnMNCiAgaW50
ZWxfaW9tbXU6IGltcGxlbWVudCB0aGUgZ2V0X2FkZHJlc3Nfc3BhY2VfcGFzaWQgaW9tbXUgb3Bl
cmF0aW9uDQogIGludGVsX2lvbW11OiBpbXBsZW1lbnQgdGhlIGdldF9tZW1vcnlfcmVnaW9uX3Bh
c2lkIGlvbW11IG9wZXJhdGlvbg0KICBtZW1vcnk6IEFsbG93IHRvIHN0b3JlIHRoZSBQQVNJRCBp
biBJT01NVVRMQkVudHJ5DQogIGludGVsX2lvbW11OiBmaWxsIHRoZSBQQVNJRCBmaWVsZCB3aGVu
IGNyZWF0aW5nIGFuIGluc3RhbmNlIG9mDQogICAgSU9NTVVUTEJFbnRyeQ0KICBhdGM6IGdlbmVy
aWMgQVRDIHRoYXQgY2FuIGJlIHVzZWQgYnkgUENJZSBkZXZpY2VzIHRoYXQgc3VwcG9ydCBTVk0N
CiAgYXRjOiBhZGQgdW5pdCB0ZXN0cw0KICBtZW1vcnk6IGFkZCBhbiBBUEkgZm9yIEFUUyBzdXBw
b3J0DQogIHBjaTogYWRkIGEgcGNpLWxldmVsIEFQSSBmb3IgQVRTDQogIGludGVsX2lvbW11OiBz
ZXQgdGhlIGFkZHJlc3MgbWFzayBldmVuIHdoZW4gYSB0cmFuc2xhdGlvbiBmYWlscw0KICBpbnRl
bF9pb21tdTogYWRkIHN1cHBvcnQgZm9yIEFUUw0KDQogaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAg
ICAgICAgICAgICAgICAgICAgfCAxNDYgKysrKystDQogaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRl
cm5hbC5oICAgICAgICAgICAgfCAgIDYgKy0NCiBody9wY2kvcGNpLmMgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8IDEyNyArKysrKy0NCiBody9wY2kvcGNpZS5jICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICA0MiArKw0KIGluY2x1ZGUvZXhlYy9tZW1vcnkuaCAgICAgICAgICAg
ICAgICAgICAgIHwgIDUxICsrLQ0KIGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oICAgICAg
ICAgICAgIHwgICAyICstDQogaW5jbHVkZS9ody9wY2kvcGNpLmggICAgICAgICAgICAgICAgICAg
ICAgfCAxMDEgKysrKysNCiBpbmNsdWRlL2h3L3BjaS9wY2lfZGV2aWNlLmggICAgICAgICAgICAg
ICB8ICAgMSArDQogaW5jbHVkZS9ody9wY2kvcGNpZS5oICAgICAgICAgICAgICAgICAgICAgfCAg
IDkgKy0NCiBpbmNsdWRlL2h3L3BjaS9wY2llX3JlZ3MuaCAgICAgICAgICAgICAgICB8ICAgMyAr
DQogaW5jbHVkZS9zdGFuZGFyZC1oZWFkZXJzL2xpbnV4L3BjaV9yZWdzLmggfCAgIDEgKw0KIHN5
c3RlbS9tZW1vcnkuYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIwICsNCiB0ZXN0cy91
bml0L21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQogdGVzdHMvdW5pdC90
ZXN0LWF0Yy5jICAgICAgICAgICAgICAgICAgICAgfCA1MjcgKysrKysrKysrKysrKysrKysrKysr
Kw0KIHV0aWwvYXRjLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMjExICsrKysr
KysrKw0KIHV0aWwvYXRjLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTE3ICsr
KysrDQogdXRpbC9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0K
IDE3IGZpbGVzIGNoYW5nZWQsIDEzMzIgaW5zZXJ0aW9ucygrKSwgMzQgZGVsZXRpb25zKC0pDQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3VuaXQvdGVzdC1hdGMuYw0KIGNyZWF0ZSBtb2RlIDEw
MDY0NCB1dGlsL2F0Yy5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IHV0aWwvYXRjLmgNCg0KLS0gDQoy
LjQ1LjI=

