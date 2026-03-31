Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26435FF60D4
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 06:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Sub-0006pz-Jv; Tue, 31 Mar 2026 02:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1w7SuY-0006mJ-Mb
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:49:14 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1w7SuV-0008KU-3V
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1774939751; x=1806475751;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=uAPAMlIF7/XMaGK4lfCtAIwxXRaMnf0PYuLzXF/xuqU=;
 b=pxNPs6HUXFBKAhjxhO8Mh9p10Z61LgQf6z8/X8uOKuzZj9pqzm/CZdf9
 3zIAUAZTG/qP/MfNx9riti9N4EyYMwDHnpvEl35YizRm+vmpx6VdtlO8d
 Fb/m4Ow8D6HP+1wFCLfl7Ay6CmaEKpakgbKxxj1GKmGygn3rf3pAJNqNR
 L4k+8jJ5tjHQhXPZ/hh2uJzfJdY0gzufeuhfqDLkoBvk+8GiAKi8aUoL6
 YvR+YvMmiSZkCcAyfc1/O49K2dWGM5UNCRIKv1WkWkg9hFcI3aSzN288F
 JERB1mmJ7PxeVD/lu5z6ZnR0XqHg5e6W2cHe5/NTVod1wDV7cijec2YZA g==;
X-CSE-ConnectionGUID: TbesADEfQbOjhVqP9C42fw==
X-CSE-MsgGUID: +LgSKg/NQGKKvmBTZmwClQ==
IronPort-SDR: 69cb6e64_HQxGRdWeSsxgA/mtTRHKhjySwGk78zLGRK26fQjj54c8XV7
 33CY3XQpXCf0rILF7Ux/Hvkbf86tmLDI0ZKQPvQ==
X-IronPort-AV: E=Sophos;i="6.23,151,1770591600"; d="scan'208";a="47290856"
X-MGA-submission: =?us-ascii?q?MDHT7BbJ3sQ1CpwToSvE2QLt+NEV0+1csL+KHl?=
 =?us-ascii?q?0SudxoxcfjSZCe+V8CkNpIHjrgvMsNBYrKogX3w0Cvl/5jIV+bogk9el?=
 =?us-ascii?q?9EMCEw57du+sxdxkwcA/hNk41Nrm5y7lkPbN8uK1pAhk+v1owRJEwGwl?=
 =?us-ascii?q?Q8n+53rxkWHhi4lfUmuwEJnA=3D=3D?=
Received: from mail-westeuropeazon11010035.outbound.protection.outlook.com
 (HELO AM0PR83CU005.outbound.protection.outlook.com) ([52.101.69.35])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 31 Mar 2026 08:49:07 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4MNhTokpQCPTFkGVaJwNXL5194pRTk8c3IlUtGx7ljn+wxSPAjcMsHX055GxPFnPGdXjRXNk+/B1ff7DnPK4rOEb2d0eiFscjJXs9fQYCR+A82xuVT9ZKzxxP9PvydpOqMvJXNN6qOdT1Zh2Ahtc18oFae5kyEzC3xxspnq8hg9igSIBCcgd2X7yfutaILCicXx3JqlO3ULNi2nVknX2KbLAElMNgPj/8YLznNh1HdWOhRFcV+4B1GNmzx0m7KmllES85ffTngH1fUBhTQhmM/h3oxGJZ56BYmqnPDzteKDfuxl1Q8JIprXvhQakHcN5LJQL4Q7CRDnYPqhv5CzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAPAMlIF7/XMaGK4lfCtAIwxXRaMnf0PYuLzXF/xuqU=;
 b=VUV5a5CWG3chA5N+rxs/JjZDJMnuWpTLz6dymhBS5r8aXaqa6I4xJIptbYi7BV2L/WeRkJvnhU+Jl3UIQL27iaPjWiB23MgAIcXj+XLiJbNPjl5oKEhnXF4u2RPLw0y3enVXSXP5ArkfYKl3tbwTEo2BlE3SWI0DQ9MnMkTq+z+/9uXpNI5TQrHfJ9EEEFkv5+YBjJGLwCgo4f3jpvGcdw2Y2Hd5aWc+/qGzaoz81HkfkruC+y65WLaCwASwOA81WZ5vV+nSuCy5oySWBeeHH252tca4krqrBTsE6/vQdSVVqzgWduQo0o4/KlUQd49vEIlj1oUQycHkrcZiTUfkeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS4PR07MB8557.eurprd07.prod.outlook.com (2603:10a6:20b:4f8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 06:49:04 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 06:49:04 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@bull.com>, "kevin.tian@intel.com"
 <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "xudong.hao@intel.com" <xudong.hao@intel.com>
Subject: Re: [PATCH v2 09/14] intel_iommu_accel: Bypass PASID entry addition
 for just deleted entry
Thread-Topic: [PATCH v2 09/14] intel_iommu_accel: Bypass PASID entry addition
 for just deleted entry
Thread-Index: AQHcvQCl+gw7brnbdkGKBEBkm13uRrXIOsSA
Date: Tue, 31 Mar 2026 06:49:04 +0000
Message-ID: <6d905f2a79b7a4904659db14d05311784a790a7e.camel@eviden.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-10-zhenzhong.duan@intel.com>
In-Reply-To: <20260326091130.321483-10-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS4PR07MB8557:EE_
x-ms-office365-filtering-correlation-id: 49896b7f-a7ca-4503-5f18-08de8ef19969
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: W+U+8U0tLxWh622ZS9h1pO6a5m4JU59K/QABle6OsAXtZ+MOUpSmy0Mq3Xv/QVPAdI0NXHdGoGVZmg+vnhuyJNhRdFHm7VElH/+vkbETfUVEHq7ZF/brLN3Y3y8d3kyuKhEDc6pPPRd6GeEB6a2LmBw+xN508FEmviPTIsu86BVhlB/kDsxX5CgEFhVhezLsj4rCA9xmA8DKN6X3zy+7SOVE2niOn2ul5XKOQZZ3oAR1q39fxMXSm1GnblFncGTk9nfufyastvrxYxWWM2fmp7dRs/mFIO56a0O65xtXy7OSNXLuekmYaJIQmJcQox9Xu1axsAb1t2A8++6C7OuIhJyFCp2XwSWUpGKLf6pjnrknzv17dVyVg9FETdo9XorBTAv60v7VYOxZbOMqSw08Sxgba0T+7TXpuqahRbD4p2nuo7oppVnQDJgrwZ4u9ykISt+2u/4/zOK0wSyeK0OgRx8TTvC5SNvy39hqfrj9DOuAMfsKa3KxXtq74Ra37iQbhywyXiUuQcsNPbpbFQemOpUoZZoDbmFwMC97mgHqkPey5gpEzlG9WvysQ/tuO2mjWdRF38dzJTene4NbzzNW95OP4Ef4Uha6Xfmvs8/mc5Q7DQGUGCeE7o03SrN0G5HQXKW1S7dQoGjaBcjV45cfYJ1yC76oIvPgk3x4VTqzFOad90hYtPVf1+U6ZAr10LM5m4tsIy9HaNZEUCsAHnqx/pLyZ3/rLN4ZPtXLvPJD9IuCBB1kYtZCjiZiUF0Tg8hvdNzXBq7aGE8vj7DTb7ltVAoCQq3YAEGxX5sHNotz5Ek=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3lSQjd4SVJvNlczOWExR2EwbE8wd2tiL1hXTWRkRG9XMlZaV1FRcmM2TXh4?=
 =?utf-8?B?NFltYy9qVThldmJDUlV3TzYrSzVOMGl0SmlhVWszQlJiWDk1QjgyVkZZMjhX?=
 =?utf-8?B?VStpeFM2bCtBMXdpMnc2Skc3SjhGU0RYVmxVNDFOZ2JQRFdnY28vVWtGR2tP?=
 =?utf-8?B?ejJBbm5nVGxIYmU4UlRGaUkxNVVtc2pETUhTeTlKUGlaQm1OZURoR25xR1VQ?=
 =?utf-8?B?dkl1Ti9WSUZHWTk3c0Z3dVVIanBHNTFTRjJDc0pYa3VTcDdGK0ViTzA3VXRQ?=
 =?utf-8?B?SzZLV29NSFJRVTU4U2hBaWF2YzVTN0hGSTRDQnQzbkJYU0t0aXNIelh1Mzlx?=
 =?utf-8?B?cEtKMlU4cVhqdWttTFBkV2lOYXVSQ0NiclhWWkZ3cm5ZZkRGQUVQYnNvSC85?=
 =?utf-8?B?L1MrUTUySmVvOEFqUXNwRS9YK0FRUHh6c1JUWi9oaWYvdUE0UGZpZ1lBRzVs?=
 =?utf-8?B?OVRtV2lBaHlWck5qTHJONlU0OVg1c0hVWWx5WDNsOEZEekFoUHdCNVljcGg3?=
 =?utf-8?B?eGdyMUR6MlFmWko5aTJNS2hSTDFHMVRiQkc3eGNpZVFnOWVlc2xNZEtjMmNS?=
 =?utf-8?B?MUliZTF6aWRxa2N3VU9Va0lmVm9xWDdWWTA4M1Evbm9CemJMNUNvVWQ5OEgv?=
 =?utf-8?B?bnBGeGxBV09qaCszYnVuVDhhaDc0UFZmUEg1WmlXVnZrS0lUUk9ONTBYZEJB?=
 =?utf-8?B?akt4UWxEeDlKTFV3d21QTTEzMlJEckR6ajF4dUNxU25Eei9iZjdpT0RNdmNH?=
 =?utf-8?B?OFRQSkdMcVNQNlpMc3AwcUlET1JRWnBnWDYwcHAyZVJQbkJsQVBqdGdKeXV4?=
 =?utf-8?B?WDVyb2ZCelU5QmRmdWJuL3puSjlZeG1LNWZuR1pMZHpzSHF0azloWVRBbktN?=
 =?utf-8?B?S3l0R05yTDdlWEkrZmtZeWkzQzBPdXczK29ML20xeVlTV05qTHF2eXpSemhS?=
 =?utf-8?B?SlhPNUpCU044YTFaVXZ4dVlGZWJRMldWeWZFejg2ZTd3MFcyYS8vYkRRc1Bq?=
 =?utf-8?B?NzBLc2pTbmhyOFdUUVBkY25vV1ZPa1FaM1Iyc2dGaVo2NHV3NTVHS2ZXUGpE?=
 =?utf-8?B?M1d3TzRxTWx4SDRnaWdsbElndUMrbTFCWVBsQjJheUNHTFNJcEJvWGdxZlMz?=
 =?utf-8?B?dmQ0OXRabTlnNWdXMnpKUkdPSEt5VXNQdjdEK2sybGROTHFhOTJFYnk0eWU1?=
 =?utf-8?B?a1Y2SndtTnFHVzVPRWtUQ0lIQklIQW81ZE5yUlFGTjE3RndqeXJmZExYdzZv?=
 =?utf-8?B?dmJyM0ZuODdDRUs2NUswbHFTSDQ1SVdVb3ZhaGlObEdXSDk4K3YxQVFlM0FD?=
 =?utf-8?B?S0xvSVpzMm9pYnVJZ1c0QTBVeGREN1NCbHl1dTl3WFVsZklFWEQrTStscm92?=
 =?utf-8?B?eno1QXJDcFR6eXBJcHBoUXl1R1VQYmNOY2NmWFQ2bjY1eUJrL3ZrY0lIa3Bz?=
 =?utf-8?B?MWdxeFJxZDlhbVlWMnBpTUFvYkdBUXRQTFFVVXR6YkVpUldHdHJ1RGU3V0I4?=
 =?utf-8?B?eTFMTlBGZmdFZlNLbmxIMFpFanV0S3JpRTZ3MVRQNVlMNThqdUlBZEtuNmhl?=
 =?utf-8?B?OG9GT0R4dndlSVZRNDZWcEs1TndaSTViZ0V0bTVMZDIwaldUQ2o0aG5RL0Zl?=
 =?utf-8?B?MUowcGtUaXpqMnhEYXV4TzM1NHIyWmlDcjRHRFRzcTBVZC9OdndHU3VWNjkr?=
 =?utf-8?B?eVlOd0VHY1pFa0lxOGZxS3ZTS2hQMCtzWWM3ZlZYTmpXTDNxWjhzQnRIN1hr?=
 =?utf-8?B?T29rRFhaa3htWjZ0VHpQdGtOWTdERGJ6RGdkYytGdkx1aHdBSkRVRUVqRnRm?=
 =?utf-8?B?Z2ZnZENlb2wzYm1VeXVNcXZvM3BXSlh2eE9wYnVPb2NSUnNjVEhERUMxQm9Y?=
 =?utf-8?B?bW1rMnFVVzg3djZRYmZlWGJZZ0JnOStyTW9RZUkzeitMMkZsRGh6MUxFeU8r?=
 =?utf-8?B?bXl2azFXY0pMNDF1TlRERlRGb3crNFY0VUlGTEFHeng3ODRrcmZIMkdSWjdt?=
 =?utf-8?B?MTJmTHk2NVFLbitPNVFyVjJWbmlrOFh5Y0dUU3lQdzVDUGxHUjFSR2ZMSVRq?=
 =?utf-8?B?RHpubm1PQjM2UlZzbTZTeHg1WHQ5cnZpdTFMUDJXZVJ6NnVFRzVWQVQyeGNx?=
 =?utf-8?B?OGdFN1Rnb1g1ODBIa1R3aUNWUDJMWVJpZ1JiZU9NRU1tR213TXNBVU80UTcy?=
 =?utf-8?B?TFlNZ2lydExySlluREpjNlREeTJJc0pBTHdocEhMOW9QeTdTV1cwQkkzOENw?=
 =?utf-8?B?UWVxSTZodVBKT3ZSaC95Y3hXTzdoQkY1L0pkT3NHM25raEw4bXp1bGEwN2pE?=
 =?utf-8?B?Mm9rZzhBaFNIZTN3ZUQrWWNnSUVUYjZ0OGgybVlUYTBaWGFQOTFoLzlFYnJU?=
 =?utf-8?Q?ZI6UYpWFVjqDcLNKdbpSFR8tp3EIuEITvChLs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12D2BF2947EC53449F4A4B318D40D613@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: anbUHWr9PMV4bNW45GeKWiyx0pwTeh7DP0l/WgyT3wpd+SCA0pea4VqWcuqiuqLl7usKGgnXYvGrOc+XpWerj8HcwcPU1Z73LmeEWy9Qg0dk447svLE2/b54B5HEwcA7k90/TpeMo4saFmXvaDPkNFhhsuq5b1QhJaSSLBgdEGk5EVrbkiV9nuc7w6BiXMwdinLCFddSjXlyZlEOfE+ret52v4HdS/Vls43URadIYWMR1rSSfNO4e501KFZ5uVR3RRp9kkKjaorCNIVffX3e3OWGqcWGJFuW9mMOl+E/7zmRs1Iglw/c3HH1w16IFh1hEarbyQPX2+JNX1HALHYQZA==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49896b7f-a7ca-4503-5f18-08de8ef19969
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 06:49:04.4720 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ekMzAigGs8IsTCyVqWloH7wr+3Opa3Z/rNJmdVejRII2fKPPLRFmmiOrx4ni5pl1X87tC+1v56CxuRM8Bi0AgNWfx6A8CAUVSK+mCTUBhNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8557
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost1.eviden.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

DQpPbiBUaHUsIDIwMjYtMDMtMjYgYXQgMDU6MTEgLTA0MDAsIFpoZW56aG9uZyBEdWFuIHdyb3Rl
Og0KPiBGb3IgVlREX0lOVl9ERVNDX1BBU0lEQ19HX1BBU0lEX1NJIHR5cGVkIHBjX2ludl9kc2Mg
aW52YWxpZGF0aW9uLCBpZiBhbiAgDQo+IHBhc2lkIGVudHJ5IGlzIGp1c3QgcmVtb3ZlZCwgaXQg
Y2FuIG5ldmVyIGJlIGEgbmV3IGVudHJ5IHRvIGFkZC4gU28gIA0KPiBjYWxsaW5nIHZ0ZF9yZXBs
YXlfcGFzaWRfYmluZF9mb3JfZGV2KCkgaXMgdW5uZWNlc3NhcnkuDQo+IA0KPiBJbnRyb2R1Y2Ug
YSBuZXcgZmllbGQgYWNjZWxfcGNlX2RlbGV0ZWQgaW4gVlREUEFTSURDYWNoZUluZm8gdG8gbWFy
ayAgDQo+IHRoaXMgY2FzZSBhbmQgdG8gZG8gdGhlIGJ5cGFzc2luZy4NCj4gDQo+IFN1Z2dlc3Rl
ZC1ieTogWWkgTGl1IDxbeWkubC5saXVAaW50ZWwuY29tXShtYWlsdG86eWkubC5saXVAaW50ZWwu
Y29tKT4gIA0KPiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8W3poZW56aG9uZy5kdWFu
QGludGVsLmNvbV0obWFpbHRvOnpoZW56aG9uZy5kdWFuQGludGVsLmNvbSk+ICANCj4gLS0tICAN
Cj4gwqBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfMKgIDEgKyAgDQo+IMKgaHcvaTM4
Ni9pbnRlbF9pb21tdV9hY2NlbC5jwqDCoMKgIHwgMTEgKysrKysrKysrKy0gIA0KPiDCoDIgZmls
ZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxfaW9t
bXVfaW50ZXJuYWwuaCAgDQo+IGluZGV4IGQ1ZjIxMmRlZDkuLmYzY2I2Y2ZmMWMgMTAwNjQ0ICAN
Cj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oICANCj4gKysrIGIvaHcvaTM4
Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oICANCj4gQEAgLTYzMSw2ICs2MzEsNyBAQCB0eXBlZGVm
IHN0cnVjdCBWVERQQVNJRENhY2hlSW5mbyB7ICANCj4gwqDCoMKgwqAgdWludDhfdCB0eXBlOyAg
DQo+IMKgwqDCoMKgIHVpbnQxNl90IGRpZDsgIA0KPiDCoMKgwqDCoCB1aW50MzJfdCBwYXNpZDsg
IA0KPiArwqDCoMKgIGJvb2wgYWNjZWxfcGNlX2RlbGV0ZWQ7ICANCj4gwqB9IFZURFBBU0lEQ2Fj
aGVJbmZvOyAgDQo+IMKgICANCj4gwqB0eXBlZGVmIHN0cnVjdCBWVERQSU9UTEJJbnZJbmZvIHsg
IA0KPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jIGIvaHcvaTM4Ni9p
bnRlbF9pb21tdV9hY2NlbC5jICANCj4gaW5kZXggYzEyODVjZTMzMS4uMWUyN2MwZmViOCAxMDA2
NDQgIA0KPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMgIA0KPiArKysgYi9ody9p
Mzg2L2ludGVsX2lvbW11X2FjY2VsLmMgIA0KPiBAQCAtMzExLDYgKzMxMSwxMCBAQCBzdGF0aWMg
dm9pZCB2dGRfcGFzaWRfY2FjaGVfaW52YWxpZGF0ZV9vbmUoVlREQWNjZWxQQVNJRENhY2hlRW50
cnkgKnZ0ZF9wY2UsICANCj4gwqDCoMKgwqDCoMKgwqDCoMKgICovICANCj4gwqDCoMKgwqDCoMKg
wqDCoCBRTElTVF9SRU1PVkUodnRkX3BjZSwgbmV4dCk7ICANCj4gwqDCoMKgwqDCoMKgwqDCoCBn
X2ZyZWUodnRkX3BjZSk7ICANCj4gKyAgDQo+ICvCoMKgwqDCoMKgwqDCoCBpZiAocGNfaW5mby0+
dHlwZSA9PSBWVERfSU5WX0RFU0NfUEFTSURDX0dfUEFTSURfU0kpIHsgIA0KPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBwY19pbmZvLT5hY2NlbF9wY2VfZGVsZXRlZCA9IHRydWU7ICANCj4gK8Kg
wqDCoMKgwqDCoMKgIH0gIA0KPiDCoMKgwqDCoCB9ICANCj4gwqB9ICANCj4gwqAgIA0KPiBAQCAt
NDk4LDcgKzUwMiwxMiBAQCB2b2lkIHZ0ZF9wYXNpZF9jYWNoZV9zeW5jX2FjY2VsKEludGVsSU9N
TVVTdGF0ZSAqcywgVlREUEFTSURDYWNoZUluZm8gKnBjX2luZm8pICANCj4gwqDCoMKgwqDCoMKg
wqDCoMKgICogcmVtb3ZlZC4gIA0KPiDCoMKgwqDCoMKgwqDCoMKgwqAgKi8gIA0KPiDCoMKgwqDC
oMKgwqDCoMKgIHZ0ZF9wYXNpZF9jYWNoZV9pbnZhbGlkYXRlKHZ0ZF9oaW9kLCBwY19pbmZvKTsg
IA0KPiAtwqDCoMKgwqDCoMKgwqAgdnRkX3JlcGxheV9wYXNpZF9iaW5kX2Zvcl9kZXYodnRkX2hp
b2QsIHN0YXJ0LCBlbmQsIHBjX2luZm8pOyAgDQo+ICsgIA0KPiArwqDCoMKgwqDCoMKgwqAgaWYg
KHBjX2luZm8tPmFjY2VsX3BjZV9kZWxldGVkKSB7ICANCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcGNfaW5mby0+YWNjZWxfcGNlX2RlbGV0ZWQgPSBmYWxzZTsgIA0KDQpBcmUgd2UgZG9pbmcg
dGhpcyB0byBtYWtlIHN1cmUgdGhhdCBub2JvZHkgY2FuIHNlZSB0aGUgc2lkZSBlZmZlY3QgZnJv
bSBvdXRzaWRlIHRoZSBmdW5jdGlvbj8NCg0KPiArwqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsgIA0K
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2dGRfcmVwbGF5X3Bhc2lkX2JpbmRfZm9yX2Rldih2
dGRfaGlvZCwgc3RhcnQsIGVuZCwgcGNfaW5mbyk7ICANCj4gK8KgwqDCoMKgwqDCoMKgIH0gIA0K
PiDCoMKgwqDCoCB9ICANCj4gwqB9ICANCj4gwqA=

