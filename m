Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD49C25B7B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 13:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9PHy-00088u-BA; Tue, 21 May 2024 09:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHZ-0007kU-GT
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:58 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHW-0001ak-Kb
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716297114; x=1747833114;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=zje3qgi6Yo6QpMtuPRNjzGkwSFQAkaBm8X4sadei1l4=;
 b=wiH1yt/bcydUvs+3iuGVwdHGJht3bmR6BNYZXn5QqctJEwwNCCd09RSG
 4rweeq5+peKpVzKFQ0EUiX6VDzmw97bpHa8ZfO/525QirK2NS4PkqCCYr
 gCCYW2H5pe7/eE/5JfP+6K0AOvUeOZ+m12wejC/w+BHlK0h3aYHETagNS
 4QnQn6aZizsyC0gbP1TKLkcCmgb1PW/8cJroETrPI/WmGfJJvOp6SnjVH
 p0CTB1636q+VsXrBhfpi15oTU1BudRAa9cCGn+mAmUdpD4fOHp0KRWeh5
 OvO6iHImmFwg87GUyV1maL1hUchTgbwZGdCVuv7oMU4eoVl85ipPFhrNA Q==;
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; d="scan'208";a="13008002"
X-MGA-submission: =?us-ascii?q?MDFN3VJJOqos4i/DrDa0vLOV3S/kmO2g+FDchi?=
 =?us-ascii?q?lXi3GiuMsCSxJgGnTLb9ywL77YqkfUt1lPipkm08DFbuAgWpgqBUccWO?=
 =?us-ascii?q?OJrRpONozWf5la8VNtHkzH+KR31FDXQK65ZWPeR8s2oG8cWTjmZ/iL5I?=
 =?us-ascii?q?gUKGJHwkwMMk2KqmyWxfac8Q=3D=3D?=
Received: from mail-dbaeur03lp2169.outbound.protection.outlook.com (HELO
 EUR03-DBA-obe.outbound.protection.outlook.com) ([104.47.51.169])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 15:11:48 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIRB6lewgG2xjCPnfv/ZsxZpu3+rkahZV5MSvIF5w2W9CLs1myzd9XKqhS9xFyT4+aUyT5hiIw5WguQnvoDWv+pOUq83HM40WyWhStG7m7nGgChhYZ24GPj8fcfF9G66Rph4utYeYIEU8Qpop+imDzejdY8y/0wCizRtnUaKTDSXyOpknOGQZ1CH7BljUeVuMvfCqrneZ41vz4DP5iHNcMFE1Al83oN+gaWMGNq8YV2Il3bThDiU3Tl6QZ51oc4TXm3xczOj80C8VowDjJPVM47Vi2hD0e+OUxxk2Hmf4DfGROrBwo9TQNsjrh9n6xKN/pXaB07x1jewLSUtJlUtug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zje3qgi6Yo6QpMtuPRNjzGkwSFQAkaBm8X4sadei1l4=;
 b=fF6zhbFaWy8z4mOXJsOGkKkuPZr+e6rasUtTa2YsrwUKUA3hRYvbXeXSlwRuD6NZdEQwWSYX4L+iP3xNUOBMqT17QA0DYPTd1rnaRhS17vhuNbHMcYIWx27VGDNzbiMG0avYdULnZqYv0iisLToEVTUcSL5sh2RpWs7TRKxWCetFpPiKBTtYQBLXeI6WRXCccczvlzA/GwNTovCdt4Qv0MMS7tZuk8Tw1RIDLxysbtTBn1Pf+oTaTAUkksU/4yhWQ0Rkx3wJ53bGay4GO6/qI1M85KhuHHMjPqeyvNR2JWi1i/hgLGSlFxkLjXka5/UrP1jMkNfTTh0HpUCIrwgwvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB8PR07MB6249.eurprd07.prod.outlook.com (2603:10a6:10:140::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Tue, 21 May
 2024 13:11:47 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 13:11:47 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd 13/22] intel_iommu: implement the
 get_address_space_pasid iommu operation
Thread-Topic: [PATCH ats_vtd 13/22] intel_iommu: implement the
 get_address_space_pasid iommu operation
Thread-Index: AQHaq4BvlzjFaZHZg0mSYIg84+qjww==
Date: Tue, 21 May 2024 13:11:46 +0000
Message-ID: <20240521130946.117849-14-clement.mathieu--drif@eviden.com>
References: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB8PR07MB6249:EE_
x-ms-office365-filtering-correlation-id: f6245577-7219-43db-1069-08dc7997919e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?RlU3Wm1vZnV6YlNoVEVJS281ZWN2Zy9lRVMzYUpwdXQzTnJQTGRGOGZTS2tP?=
 =?utf-8?B?eVJ1dVR1azFoWFlXMHZzczNKNmt2am9aLzQ0ZUl3TkYxOWJ0YjJDaHdwUVlr?=
 =?utf-8?B?MUtoZU1FYnlSMklJM25tK3ErUGxZWmdLcmc2ckZWd1UzU1J5MkZPQTh2SUo1?=
 =?utf-8?B?ZE5MbG1KemxYZDhuZ2F3dDRGNkwxSHVFZjRwRHBlek5pVDY4c1BmcTNRWEd2?=
 =?utf-8?B?cnNKWE4xWFNOQ09ucDhZR2xiQ3kzdnJvZTBDT3E5aXZjZFFmbjlCb25GaC9V?=
 =?utf-8?B?cUZsNnd3c2FxUnc0ekxsUnZXckNKNmwxSk1Hd2pjRUo4MmlMZ25IdStuVHJJ?=
 =?utf-8?B?cVpmZjFOdlArbUQxYUJNVUlGU2M2MUtXalcvKzVJeGVjcUFSaDloRzgzdXZR?=
 =?utf-8?B?WDRWNWZYY3NRZ2Z0VlkyY3JLMXU2d0FSNDdQYVdDZG9HUi92OUpwQklWUThk?=
 =?utf-8?B?NjNMSTlDc29ibzVPTmJtcnlaR1QwTzc3cnBnMTArZEF5Mktudk9tV3E3Tm9N?=
 =?utf-8?B?Zk1POTZ5NkwycnR2QzdtWXd3TUp4SU1zZm45ZmdIVzQ4d0c3VzhLSHZsSXRI?=
 =?utf-8?B?ZFRLMkx6SzM0Wkt2OGZENEtNVjNDSVhKd2pFYkg5VzdPMFlCSEVrQkhhWWxq?=
 =?utf-8?B?VktLRzBPRys0c2pDbmJSL0gwR0V6UGhZU2VHcXpwWm1YVHMxSG5NQlU1OFhT?=
 =?utf-8?B?NzV2RWFkMStqSnowVGc0YzY3OWpvNWZ4dXN4RUpGTnFLU1U5eHd0QWp3eVhu?=
 =?utf-8?B?b3FMRGN2WlFodGVkam1YRFBmZ1ZId0psa2FPS0lIMU1ncXMzcnVCS1lETmNG?=
 =?utf-8?B?R3k3MTNKSGtyVng4ajN1SmZPakRnKzhzQWIrQ0I1NGRsQWNJUFpMeVhGWURO?=
 =?utf-8?B?SmJsNVI4VFk1NmNPU1BaRzlRZlkycWFxQTR5cCtYM2VDa21OYXJKdlBnVUYz?=
 =?utf-8?B?TTI0YW44dmNlYUEzN0dtQ3pBa3dPb29TVzloWHVENUFJYXVBN3ZaTTNOdVp5?=
 =?utf-8?B?aUw5ZW9VcTdFZkIwTVpNcmhxNzhGY1F5aHk5U2tRL1BpcWR5NmhKT294eWlP?=
 =?utf-8?B?M0tKVEU5WFc2L0p4VHJKdWlCWmh1ZG44SFdZdVpRZmdzQ0lUMVJMNnlhb3Iz?=
 =?utf-8?B?R2RuM3VjTGVlaktKeWhEdk1vaW11bTcweVpQV0VwU2x4ZVFlOXk4YlFCN3Bj?=
 =?utf-8?B?TU9OdThoWXo1ZzJFNUxiRkYyR2EvNS9tTW1BQmJxV0NHWFpQb3doSGxoblh1?=
 =?utf-8?B?QjNvQmtRNStpQ242NmtGQVROazE4TnQwS2NsNldiMDhWN3R5cnh2aVpld0Z5?=
 =?utf-8?B?NVJqVVZsaDhQdWNJa0ZMUU91SkpyKzFLVXdXN2NWZngvOE5rZ3JtOHByZWY2?=
 =?utf-8?B?QXRoNUt3MnRTdFR2YkNYVWFrc2NCb1ZPYkx3YkFhQ1FhTUwrUDlNY3FhNlh6?=
 =?utf-8?B?V29zbHNMaE5JdURiVVpIbHF0WWFzQjEyLzRrZ1FsZmhWLzZTS3JheHZUbEp1?=
 =?utf-8?B?cTdGYlg2VTJONmdnS0lwczhNckQ4RnJrVGpIWWJET2RZY2pzajZ6K3RqSVpI?=
 =?utf-8?B?clYzdnRUeTg4THhTeWhNZmpvMEozbnVHc3pLa0ZQcW1VT3dUWEpKZGJvUzRY?=
 =?utf-8?B?d0JoMjRXWVR5R3J5dy9aMXlRRlhwQVZJeXduTDhOYWpib1g4OEtqMFR2Zjdy?=
 =?utf-8?B?dEcrRVpicVA4OXRzbmxTSHozTENaK3Voam15VHYydnpFVlZsODlDSGFuTFlJ?=
 =?utf-8?B?RmZ6VFhmWGxiSmJHWk9GVlZxM1NmNHVrNWJ6elN5MUkxSUMvTG9pVG1jKzl5?=
 =?utf-8?B?c3RMSTVKVndLWkVHQ3h2dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEErZFdzZ1V0QkN4b1NKUzhUVHI4ZkVtbGZRYndBcVZGL0dNRTlvZi9OKzVU?=
 =?utf-8?B?dU5lWmFmbXh3a3EzS1dIZ1RadnZKUDFLbGtvR1ZCTW8xakh5aUhNSTBvSWhS?=
 =?utf-8?B?Wkc1cGZkTzBhNjhicEtxL0RDMXcvSUoxeUF3YUVLKzlGUzQ5VncycEgrNXFE?=
 =?utf-8?B?cG91VEl5eFVzWjRFRGZIdE13MEZZQzBPd3I4N2ZzMmx3UzNDV3RyWVZoemor?=
 =?utf-8?B?bkJLbUd1c0dNWmVSR3gycVFjR0dCTFlYOCtPRGN4bVowajlUSlVZQk5LcTdI?=
 =?utf-8?B?NVQ5Y1BieXg1UnZpZVoxODc0d3lJVVN6cHk2TGk5ZXVoTFppWndIZlJpZUE0?=
 =?utf-8?B?L1lCNS8vUGVxSDVtOVByR1JjZWxJV0J5S0swTmcrWlViVjF1ZXFyTFhyaHZz?=
 =?utf-8?B?WFhldi9PcGRuZTBPRytidGFKRCtUUXNadE9VNHQvWTJ1aHlSM3JXWm02RjBL?=
 =?utf-8?B?Yk5QVk1kb3ppNkZpQjFhTklmYVlCWDRkaGQ2azFaY2c3SkMzODd5VUh2Tkw1?=
 =?utf-8?B?QnJERStYTHZDQmp1RElQOGNvb2JxTWc2U0ZsdVo2WkNEMUtnUFB5WGI1d1Zz?=
 =?utf-8?B?Z05IK1hIVXJGZFBuNkRJbkdGdTJiNjd3bzdZeVluZDFQSHJYTWttTFJXMmZx?=
 =?utf-8?B?bUZaK1hqZG1GOGpwSGZiVFo2NkRPSmVjVjcrUURuOHpDTlU3L0p6MHVwdU02?=
 =?utf-8?B?Tm9peUFsQUJmMUVRKzFpNlRRSUwvTGpvaEFRc3RJODY4UVV6eTB6eE9TcXhZ?=
 =?utf-8?B?cTJRdEN4NUVIU2pCT0dzWXo1LzYrZWpSRzNxbmxRT2xmdTlqUW41WVczZnZt?=
 =?utf-8?B?cHB0b0ZJTjV3SjhWSlVEeFBJelFKT1hLTVhEbTlmK3pNNTFWNDJwM2FtQW1S?=
 =?utf-8?B?YzNsNkFlcDlmQzVmbmpLaDQ0UEdCdnlKTDZqaHFsdlhobzhMbSt0dHhEZk9X?=
 =?utf-8?B?NXE1T0M3RkRtTmgyTlZEVGNPVjhHeUJsSDI2NVlGalY4aEx1RGZQSk9HYkpZ?=
 =?utf-8?B?Q0ViMktRZDJnR3BTbDhUSTdPRmp1SmsvVURDSjZjZkhpOFV3eXhVWnkzOVE3?=
 =?utf-8?B?S0RrbWdSSFJYMmhkOExLUEt4ckk2VnRaZnlialpLb1JmTVdwQ3g1VnppbEcy?=
 =?utf-8?B?d21xTTVUdUt4cjh2Ukp6MUFCSE4wT05vcnNaSzRxWGZzM0lUY2ZtbWFLMzlH?=
 =?utf-8?B?TU1oK1loT1ZwbjB0c1dXS3c0Y3B6SUI1RFN3ZElYdjVKN09uei9tWjgrakY0?=
 =?utf-8?B?YUg2UXg4M3ZsUFhWUmZZTDMvYnVVU2hQQ1l4OG9IN3I2OU5jMDdJYzBsSC9Y?=
 =?utf-8?B?NUFKMUdCNmpJM3huOE5PL0tJOG9USS9SQjd3TTZOMzdsajE2bkoxekcyVUxJ?=
 =?utf-8?B?dWVEY2F4bVJTRCtKdFllNWlOR0RzRGhmK0dDN1NUUDNGMTBFTFh3MWlPaVdE?=
 =?utf-8?B?UzJFOG9jSVRuVldYZFRBM1EweExyTXRwdFNhWVRxcmc2WEJQQ0sxWVRFaW9Z?=
 =?utf-8?B?djBaZGZaYXkwOUNuMlU0TCtwaTZpZnlTc2tFbEUxbUJzRExJZ3cyaXdRT1k5?=
 =?utf-8?B?UHhJOFZab25WRHdDUHFTV09zZnVtVXA0MkFKd1pnSkJ4UnBiY0lmc0J4SzlG?=
 =?utf-8?B?eWhGbjBIVC9Gd3dhU0pic0EyZHE3VzhpTm1SN2NGbFZUVFNoeWlCekxVY1Q3?=
 =?utf-8?B?aEVQSGpBSEZNMlRLaE9EbDd5TGY2YnY1cXpNTW43RlR0V0RVRUpTaDJ2MjdD?=
 =?utf-8?B?b3JlZWkvVmtJTFE5eVdMK3k1Y1l0YnBBQTZJbGphRnlNNUR3OStLSGNQaWd2?=
 =?utf-8?B?eWpDdXNxcUpIY043SUhxMWdVY0ZVZkF5NFhIM2lvUzc0Yi9VS2ZHb0tpSXFU?=
 =?utf-8?B?SVRzcU5xN0grWFVGYlRMN0x3R3d0WUpsckRFTnd0aE5xNEZwVWNaMTRGNC9v?=
 =?utf-8?B?VlBNQ2JFeno0aHkvVWpUVGFkNm8zZlc4RHVoVjNnVkRsQmFQM092N3M3RFBy?=
 =?utf-8?B?cnhDbWpJMURONUVWRXdMT0oyZHd4cTZPZXZWa1JwMTV4Y0Q4ZUI5dVErYUVl?=
 =?utf-8?B?cmcyNFlDVFM4TFhYOGZkK3dHZXNDakxubkdFc2w5Q3FFQ2pobHN6VDJYU2Ja?=
 =?utf-8?B?SnZQQWE2dlphTlRVQzNJc3BDV0hVU21PRjNZRFhDdHN1SkpPZVUrSGdQVVo1?=
 =?utf-8?Q?uK6xxqOdPy5O4UqMF8xjYvI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F408462E35F078488E5C61E700D02C0D@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6245577-7219-43db-1069-08dc7997919e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 13:11:46.9229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQC8hmJ9uahFtBG116D3VJaTh5Oihlrrspz1KryuPKSdz5pIWTtiUeK7JNuedfGM0Xu11ysYnFoqy8efFZ1qYYyvFmPJgm/ROQENnthyIJyErlwakQioQTdpY5wO/lC2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6249
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICB8IDEz
ICsrKysrKysrKystLS0NCiBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCB8ICAyICstDQog
MiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQpp
bmRleCA3ZDg2YTMxYmVhLi5lODM5ODVmMmY3IDEwMDY0NA0KLS0tIGEvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jDQorKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCkBAIC01NDE0LDcgKzU0MTQsNyBA
QCBzdGF0aWMgY29uc3QgTWVtb3J5UmVnaW9uT3BzIHZ0ZF9tZW1faXJfZmF1bHRfb3BzID0gew0K
IH07DQogDQogVlREQWRkcmVzc1NwYWNlICp2dGRfZmluZF9hZGRfYXMoSW50ZWxJT01NVVN0YXRl
ICpzLCBQQ0lCdXMgKmJ1cywNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQg
ZGV2Zm4sIHVuc2lnbmVkIGludCBwYXNpZCkNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpbnQgZGV2Zm4sIHVpbnQzMl90IHBhc2lkKQ0KIHsNCiAgICAgLyoNCiAgICAgICogV2Ug
Y2FuJ3Qgc2ltcGx5IHVzZSBzaWQgaGVyZSBzaW5jZSB0aGUgYnVzIG51bWJlciBtaWdodCBub3Qg
YmUNCkBAIC01OTU4LDE5ICs1OTU4LDI2IEBAIHN0YXRpYyB2b2lkIHZ0ZF9yZXNldChEZXZpY2VT
dGF0ZSAqZGV2KQ0KICAgICB2dGRfcmVmcmVzaF9wYXNpZF9iaW5kKHMpOw0KIH0NCiANCi1zdGF0
aWMgQWRkcmVzc1NwYWNlICp2dGRfaG9zdF9kbWFfaW9tbXUoUENJQnVzICpidXMsIHZvaWQgKm9w
YXF1ZSwgaW50IGRldmZuKQ0KK3N0YXRpYyBBZGRyZXNzU3BhY2UgKnZ0ZF9ob3N0X2RtYV9pb21t
dV9wYXNpZChQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLA0KKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgZGV2Zm4sIHVpbnQzMl90IHBhc2lkKQ0KIHsN
CiAgICAgSW50ZWxJT01NVVN0YXRlICpzID0gb3BhcXVlOw0KICAgICBWVERBZGRyZXNzU3BhY2Ug
KnZ0ZF9hczsNCiANCiAgICAgYXNzZXJ0KDAgPD0gZGV2Zm4gJiYgZGV2Zm4gPCBQQ0lfREVWRk5f
TUFYKTsNCiANCi0gICAgdnRkX2FzID0gdnRkX2ZpbmRfYWRkX2FzKHMsIGJ1cywgZGV2Zm4sIFBD
SV9OT19QQVNJRCk7DQorICAgIHZ0ZF9hcyA9IHZ0ZF9maW5kX2FkZF9hcyhzLCBidXMsIGRldmZu
LCBwYXNpZCk7DQogICAgIHJldHVybiAmdnRkX2FzLT5hczsNCiB9DQogDQorc3RhdGljIEFkZHJl
c3NTcGFjZSAqdnRkX2hvc3RfZG1hX2lvbW11KFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGlu
dCBkZXZmbikNCit7DQorICAgIHJldHVybiB2dGRfaG9zdF9kbWFfaW9tbXVfcGFzaWQoYnVzLCBv
cGFxdWUsIGRldmZuLCBQQ0lfTk9fUEFTSUQpOw0KK30NCisNCiBzdGF0aWMgUENJSU9NTVVPcHMg
dnRkX2lvbW11X29wcyA9IHsNCiAgICAgLmdldF9hZGRyZXNzX3NwYWNlID0gdnRkX2hvc3RfZG1h
X2lvbW11LA0KKyAgICAuZ2V0X2FkZHJlc3Nfc3BhY2VfcGFzaWQgPSB2dGRfaG9zdF9kbWFfaW9t
bXVfcGFzaWQsDQogICAgIC5zZXRfaW9tbXVfZGV2aWNlID0gdnRkX2Rldl9zZXRfaW9tbXVfZGV2
aWNlLA0KICAgICAudW5zZXRfaW9tbXVfZGV2aWNlID0gdnRkX2Rldl91bnNldF9pb21tdV9kZXZp
Y2UsDQogfTsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCBiL2lu
Y2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQppbmRleCAwZDViOTMzMTU5Li5iYWM0MGU0ZDQw
IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCisrKyBiL2luY2x1
ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQpAQCAtMzI1LDYgKzMyNSw2IEBAIHN0cnVjdCBJbnRl
bElPTU1VU3RhdGUgew0KICAqIGNyZWF0ZSBhIG5ldyBvbmUgaWYgbm9uZSBleGlzdHMNCiAgKi8N
CiBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9maW5kX2FkZF9hcyhJbnRlbElPTU1VU3RhdGUgKnMsIFBD
SUJ1cyAqYnVzLA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBkZXZmbiwg
dW5zaWduZWQgaW50IHBhc2lkKTsNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBp
bnQgZGV2Zm4sIHVpbnQzMl90IHBhc2lkKTsNCiANCiAjZW5kaWYNCi0tIA0KMi40NC4wDQo=

