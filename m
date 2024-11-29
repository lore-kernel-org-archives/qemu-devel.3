Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21963D6EBE5
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 07:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGvfh-00080y-Tk; Fri, 29 Nov 2024 02:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfe-0007zW-Mh
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:44:11 -0500
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfd-0002nD-0n
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1732866249; x=1764402249;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=E6spcd+vgURo5mrvsgn1W+za75oPRJn3obf1Yvr5WBA=;
 b=thavWXlzJuTQ/WMynyMUpuC3sh/sqStWRjDcfdUotjPdkCZ3xzk8Hpko
 PkWOsHdiW7roW54c43jeNjzn26ySUDwH9PhSo5eUEg/EXW/ca0NY6thz7
 yk3f5DjLex47SgGc8ciSlwn2hWOD4jqb4wWL3etdKqV5R5nSJ0GLpE29A
 i5J5XhNrl8zc+hXVtnhMIKuZiLVV3PFD7mdZ36L7keiq3xkIsBoJ/C6cb
 SsmYUd6eIZNOEsmcGARcwUuamQ+OVtoW3asax6Lmni+S12WaiJ6Vne6O+
 1R/X6J9E+AUgIy8kr656SRb/ZgpLRzIo4aMr6R6iLWl6Iq2+fSPJ4Jor5 g==;
X-IronPort-AV: E=Sophos;i="6.12,194,1728943200"; d="scan'208";a="25670815"
X-MGA-submission: =?us-ascii?q?MDGfQXAr6yW+NrNSpnBFW0COyFjWbOwHAxxUiI?=
 =?us-ascii?q?I5auO3aaaXIIx9v8gZpde3M3rHc8g5EtbHswtM3kDZJ8/v8qxjW4CDW+?=
 =?us-ascii?q?hV3lCa7hnmy3AV/a11jirMDLQjaHRYDUnAc7eKxxxdCi2n5gkhmpyMz9?=
 =?us-ascii?q?pGYZbdYYbK68EpUV30yu163Q=3D=3D?=
Received: from mail-norwayeastazlp17013077.outbound.protection.outlook.com
 (HELO OSPPR02CU001.outbound.protection.outlook.com) ([40.93.81.77])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2024 08:44:03 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Meji/nqoMiq6j8/s1TA2dtibPXoi8gY2Su6WbFX/uzoWd8TSEwAVKGMk2WhArMJkk1UckO1MUqTgSikR/TlLPbahOdvNCGCeLNdFbI9F7FuN94rCJx6LN8HAlenrzE7XOK0hjHPFZwdVoGGbsAP9FzKOzIFGFzRcJCpx6VcUAzj8FsMsFHYQQ2PsInZOraV43bu4hgCol7Kn8PHa2DLir1VDl0aoIml2geHP4DFA0SSH+7hfo10Tjf8KpO6eTGD4hX2GOWvHYAKLa2uZBFoLkfdjvNnoA1UX8RzE4GSCQeSQHA5Gu6dhCJ+7dDu86sCSJLyy3GytknMWbnlKhTbbXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6spcd+vgURo5mrvsgn1W+za75oPRJn3obf1Yvr5WBA=;
 b=sdWHKJutLyUlJse/Iao6fBGRZpzV0bMuTTWHVa1nNYy3hM08GaN16kdqaQhRcaD1TV9FkaNEWs+ayIdudBsgthH7v8NdD5Z/39HZicato64n8UvA+g0rjNmYEYl4fQq7oN2VZ6TukGWmFAUvhp4Z0AQlH9GcrhoeJyMkYasR7cJGB5miPxFY8afHcqGff7mXcgxCkRhK5B5yv0ZJTPEx3ZusDFDiGLA3hVJ/pCTvnswrQsVNuoqu+P0JPs8wMNIUdwTl6uGHp6kNj5n/xcYurY+08qEdPtJCN19W6hG3JPgdnePfjRxqaGDc50keZ0QiN6nTxXm9JW8MSVhHfoxp8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6spcd+vgURo5mrvsgn1W+za75oPRJn3obf1Yvr5WBA=;
 b=XPYqO/n1M0PD7T12y6NomIw4gtNCZXpFqkD8x1UTZ3MGJmOG356hdBQU8PZDORELB8cZr0K4XEJt+dDk0il7UgOjDFbpHSvH3X+Ht6TotRzXA0J2Dox+GQuT+iizKFUGeAP8/pL8d/Q87xPnwKcuNFvdl8SecOaiZr3uLohm9dA+OwpojW7yseVM/P1/ZpmPqY5thBUiRk9svHCU09q1DtsjLKHxUchzXss1oPfmQXC1rxOI3D/63mnE5KsWigI9NsgWI2SzTmLV0NW5K6t0jkEIDDclVEsbKvbEDeWnIpjRHperfs/DborvRsnrYo0B9f5JNRNjBO7DfQ4aHWn6dA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6414.eurprd07.prod.outlook.com (2603:10a6:800:139::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 07:44:00 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 07:44:00 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v1 15/19] memory: Add an API for ATS support
Thread-Topic: [PATCH v1 15/19] memory: Add an API for ATS support
Thread-Index: AQHbQjJ0k0DlGQgy0Eihqb6cUgrbzw==
Date: Fri, 29 Nov 2024 07:44:00 +0000
Message-ID: <20241129074332.87535-16-clement.mathieu--drif@eviden.com>
References: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6414:EE_
x-ms-office365-filtering-correlation-id: f20bae39-f0af-4179-1a2a-08dd104996d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?alJJWWdZV3FSMXFqa3Z0d3cyUXN6bnFBcTdUNTdKMFg4Qk0zUXI2WHQ2V1o3?=
 =?utf-8?B?VVZHYTNYbzBKaDc4TnVHY01uZTk3M2Q4YTNEcXVjd2xObngxNTFmVEU0U0Qz?=
 =?utf-8?B?ZHRtbmpZSEx5NThHbk9XYm4xTEhlejZkRWxOUDBRcEFETWRXazVnYzBTUjc1?=
 =?utf-8?B?ei9BZldiNml0OVdOVnJ4QzhxV25nVnMwenlWQ0lsY2h0K3ZCZEQrWmdtNk41?=
 =?utf-8?B?ZWwySzlTbUJ5Syt6a1gwSU1NUlVtalFUUGg3UG9OS3JzRnNqdzdtT0ZETHc2?=
 =?utf-8?B?U0VtbzE0eHdyZnZlUENhM0NKcHB4aS95SWFzV1RsemtlYTVTc2diZnQwR0lh?=
 =?utf-8?B?UmFBaHlOWWlEYjN6ZSsxc3lqcmlNMzBwMituQWs1WGlUZHJITElyczhxWndF?=
 =?utf-8?B?Y3l6QjJNb2s1OWZDWlpXN0pKY2JIK2l4bnJHVGRkdGJDU3NHell1bU9Cajg0?=
 =?utf-8?B?SVhNdVNKdnhid2ZMYXBIVnhjQlBaUjRERDdheUlhcUFZY3p5VDVaQkhKclFx?=
 =?utf-8?B?L3Z6STRVTGRydnYyUS96UVZFZUZ5YUVlT1N6NStObnVxOHNSdEkzaVJPTGlL?=
 =?utf-8?B?bUZkY09OR0M4RDdjRFY0d0VpMGtQM0x5SUhRWkV2MnRIZ212ZW5wcXJZTUZs?=
 =?utf-8?B?eU1rZHRWUXJaNFFPTW5qSmhTdEwvblY3WHhueG1zam1xalA2RThkT1Fjdmcx?=
 =?utf-8?B?QU8zUURid3dRRUVOWDRSM0FlcGdCQXk5clUzUjNVZEFIaWM4UGc5dUxFZEVn?=
 =?utf-8?B?ZWtvcVg1em9MOVFFRE9OcnVieUNMUzB3cVR6ZG5Bc1hTUHJhQnk5RHNvcnZ1?=
 =?utf-8?B?enp0Zm9tREN2L2lpS0ZIcUJyL3dDazVzS1QvTzEwSzY2VDlLKzZYdkUzWGdZ?=
 =?utf-8?B?emtRcVN1a0FseElsN2c0MmpnQnZObG1rZHZ2NU1yeUhJRE5sYnhVNnBORWZT?=
 =?utf-8?B?N0o3TGpDWmtuQmlEOXplVzlQdjBwVjZhZnhudnVmODFGaGNGb0NLVzlOTTdL?=
 =?utf-8?B?VisvM2NpcjBlbXVqOHZTVnNNTHFYaUpoOWR2eU9hT3FkOHkzY2JYL1V3Y0Jy?=
 =?utf-8?B?M2FBbFYvaHhUUzN1dDBHUndIS1hmUjZtQzBWalVpQjdnNzBpSVRMMzIvcDRZ?=
 =?utf-8?B?L0Nnbyt2OGRqUEI4MW9IM2F1MEVOMmtkVzNROE5NcDEwUEt2bjFXREY1T2tm?=
 =?utf-8?B?SGUwc09CUGxtbTlhaUNZWTRHSnMzUEI0MkxQcDE5ZEp0Q241SUY5UDdCeHFH?=
 =?utf-8?B?T2dRREVIdVpqZDZrb2FrYWxaQmh3Wm9BTlJucUdwQUpwbndyUGh1Z08zYkg5?=
 =?utf-8?B?UUJYVjlvUXZ5ZytRdkRyNWsrZjFsS2o2SXJ1eHJRYnloa0NGbkUyWmlHWjlW?=
 =?utf-8?B?dU04V1VCakgxd3hJVlhoT3A0QWNPTklUTk16VVQxS3lGeXk4bXRNMXNoclJF?=
 =?utf-8?B?dXFOZzJLdUEra2loUDYwblkxcUh1dituUVYvWThUWEtxMW8xR3grNENPQndw?=
 =?utf-8?B?Qlg4QVVWOGVvejlpZm5lRkd2QWdQWHdxWEhCUkhRVUhLMmxlOEdQQ3p1S2M5?=
 =?utf-8?B?VllMejJpRHo4QjlvbldLUXNsVHB1VmtwbGFLNjlJNThQcmpHQi95bW9mdVBo?=
 =?utf-8?B?Wi9HQnpkdU9SN2tuS0w0K3p4OXEvZHc3S3BOU1JPTnNTTHpCSWhjRlpGQ1F2?=
 =?utf-8?B?TUFGanpnYUZObXBVU1lxaVVuaXl3UFRrUjBYMzN2WkxMdUwwVkEzZnZFRUNL?=
 =?utf-8?B?TXczb0ZNai9qNlFYRXpSVXBNa0dGNkZPM1lpYXBtMS9FUHhLcWxtVTFMKy9O?=
 =?utf-8?B?MUtnOEdyeTdCR2dnaW8zYURQaFJsWkZVMXVyQjFPVVZCVFNOaXhUejRoZlQw?=
 =?utf-8?B?bXNoZmE0TXhsRVNxeXFmb0JDZTZCM3ZOWFBBbmR3QkFianc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVNqLy9tdGZ1eUdCY1Q4cG5WVWd1TEdKekd6UkdZSFA0NjBJcTF0K3A0QVJK?=
 =?utf-8?B?cHMwYVE1bG9tYlJmYk5rNUw5Nm1JSzlxVmtGd1FjQnZMU1l0VHladW5CU3ln?=
 =?utf-8?B?Y2VaNnRxRGo0TTRHbjlQWlg2VWxNWUxTdXA1Z2didnpka3hnMEVkVWNVY0li?=
 =?utf-8?B?M0dPTnpDSWxLelZDaUU0WGRhK1crc3pnRXRQN1ZrM1BydWRlb2J3OGt5VFA2?=
 =?utf-8?B?T2Jsbnl2TS9lZWNpR0N6TkdzSmpuOG1PZFpJa0Z2Y0pSd1V4dC9kdGcxOGJ3?=
 =?utf-8?B?cGlGVFM3MWd0RnZkUFllM2oybE1HV1lWVWZteUJITUI1NjZUTE93bStYOVZv?=
 =?utf-8?B?TnJEUHNpOGNpK0gzYlJ0U1VHbVVvcHU5Q1NSOU4yc1UrM1lKWUpkblFBUHZZ?=
 =?utf-8?B?aHBiODE1NHdleEROaGR5NlQ5c0YyZFpJSmM5clJobjRQdnR5dC93dE16RXRj?=
 =?utf-8?B?YUY5TUtpQVhwN1RGRmhzYVp1dVRneGFFTmFleFgweTljVUM1UVF5QXp0NjQ0?=
 =?utf-8?B?S1dScWI1cktDY1k5S0dVVzUyNmlSMEVSQjR4czFLaHdnRVdYSmFKaEVDVW91?=
 =?utf-8?B?R2JXLzU3RzBUOFBlRWR3SnhjT0l2OHN1K2QxSkZ5Q1FYdEs1L25SdEZLaHU5?=
 =?utf-8?B?NXVISFlZQ2gyWXVrQzgwTFZFRytFSExsQTV1T2xpdDVlNkxRVUVvWkRiZ2FL?=
 =?utf-8?B?bzRjaVd6RXpQamhnV0ZRdSs2M0RuSGtvbHlmTlVpT3JyVlBsSU1ZRlk5bVlX?=
 =?utf-8?B?WSs2RFowWVY0T1VpbXBVVERWMEpsbEM4RnAvZW5pMGhYSkpMbS9KK2Y0T2tW?=
 =?utf-8?B?cnNDOVIrWUtQZUNOM3o0YlhUUHp2SU0rQmNycXhUS1ZDcC9IM1NPUC9PSjF3?=
 =?utf-8?B?ZEw3WGs1RkUzdHR6bU93MmZaYWRlWW9ZOXdRaGQwLzV3TDZaV3B3dGs2V1Z4?=
 =?utf-8?B?L25jdVA0MGNjMlRPL2FKNFo4bGVsYmZsa2hGTTBzOWFZZGRvNEZnMnEwcnpp?=
 =?utf-8?B?Z0pqQmNEWHRUUGtOdHIyVStNWHlZZmo5ejdHRUhmUWJNOUZZRTZtVzBvbDh4?=
 =?utf-8?B?elVLalhnYjZ0dVM0T2x4UVFsZ3Vld2E3dExMWGw5Z2ZDVEt1ZjJudE1WQkxr?=
 =?utf-8?B?MjcrN25YSXREMWFreXBNdENmd3I3Mk9MZCt5a3cwMUQxMGdxZXkvVmgzbklV?=
 =?utf-8?B?akV3UTZ5czczYk1SSHlxQ0VNL2RzRjBpYmwxc0R6dEhSZm5XajBjY1pxV1NY?=
 =?utf-8?B?TXJCRmFwV2xUTHhRdDYvbFFzVi94dnJqODdLVGM4eXQwK3NTaEErYUhOUXY2?=
 =?utf-8?B?YjZDM1F6aFNKZ0VnLzk4OVNYaTVaeGsxb3BaQm1SWWF2YXE2d0NFOXE2Z2RQ?=
 =?utf-8?B?SkY5TXlUcGJIalVRSEVKMnBUQ2Q1WWNlOHRIM1krRkUycU1LOUV4UTBhSktM?=
 =?utf-8?B?Y1NNU2dvNkxmTFlxMTBLc0JRdlg5S2tDektmYnd3Y1pEbURsYVNnbmg1WTVI?=
 =?utf-8?B?T0hPMEViOHVsaEM4M1g5S0U1NUtGOTJBQVo3bGJGS0ZtejUrUUpSdFlReW1q?=
 =?utf-8?B?Z2pOUzR3ZG5yNE9RdU5EZTJPZzNmVkJUNWFtcHRyK3Q3YzQ5QUlJQ09pYzEx?=
 =?utf-8?B?SzZ4b0xlYWNndGsxUEhsQzNDaEgvaVNHV2hFUVhGMGlwdE5GQTVYVDMyemsv?=
 =?utf-8?B?a013ZnFWSm50UGhQUlRycHB6NTNEZUpFOThtUjdORGRKNFlQYk9oU2kyZlMx?=
 =?utf-8?B?bmplTDhrUDdCNzI0L0tJSmJ6WmRlV3NkSmd1b0pIbTN6aVczd0dydEc1S0ds?=
 =?utf-8?B?QUJ2Vk5qdENJVVlrVnRFZnpobzF5TUx6S2ptMTFGT09kQUYvd1BDMFZhT0xr?=
 =?utf-8?B?dVRsZWF1MURjbTNBUGEzWDhoN1BqMDJwZmx3YXI3eXZJK1V6Ylc3Q0N0RGhj?=
 =?utf-8?B?WlM1S1FjUElTdjV6c3VzOEM5cElFcWFTZWVGOHJ4ZUFuNUNZbUlWOERhc0VH?=
 =?utf-8?B?dEpsdlR3ajFJbjVscUxsUlIyRVVOTm40VjRzM3VyUU1IQmVqMlIwcE4zSysy?=
 =?utf-8?B?MW1PTHBLdy85RU1rejZUbG81aUJJVUJJUkNuTy84bS9WSExqNnI0WUF2cjIx?=
 =?utf-8?B?bURwaTFJSTV4TWhtc3ZsZnlNY25lMU1mTisrVHZtUG14SDNKanhlY0tINHpy?=
 =?utf-8?Q?r3y1riLUEWqweeIQ8a+yyIA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <778FE744520ED44CA741A72C8B1A86E6@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20bae39-f0af-4179-1a2a-08dd104996d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 07:44:00.5066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qkVIpoKT0EY4qhPbT2F/6hlTN4jEToZYdbL8BiJL8/MlzXa/2rf0JksC9Z63bSOPi6psiHOIJ6NxJJaVQW9iVjmhGBDQ8w9lLSaI7rOEDly75GreMRo8wDisqxhW7PlO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6414
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNCklPTU1VIGhhdmUgdG8gaW1wbGVtZW50IGlvbW11X2F0c19yZXF1ZXN0X3RyYW5z
bGF0aW9uIHRvIHN1cHBvcnQgQVRTLg0KDQpEZXZpY2VzIGNhbiB1c2UgSU9NTVVfVExCX0VOVFJZ
X1RSQU5TTEFUSU9OX0VSUk9SIHRvIGNoZWNrIHRoZSB0bGINCmVudHJpZXMgcmV0dXJuZWQgYnkg
YSB0cmFuc2xhdGlvbiByZXF1ZXN0Lg0KDQpXZSBkZWNpZGVkIG5vdCB0byB1c2UgdGhlIGV4aXN0
aW5nIHRyYW5zbGF0aW9uIG9wZXJhdGlvbiBmb3IgMiByZWFzb25zLg0KRmlyc3QsIEFUUyBpcyBk
ZXNpZ25lZCB0byB0cmFuc2xhdGUgcmFuZ2VzIGFuZCBub3QgaXNvbGF0ZWQgYWRkcmVzc2VzLg0K
U2Vjb25kLCB3ZSBuZWVkIEFUUy1zcGVjaWZpYyBwYXJhbWV0ZXJzLg0KDQpTaWduZWQtb2ZmLWJ5
OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNv
bT4NCi0tLQ0KIGluY2x1ZGUvZXhlYy9tZW1vcnkuaCB8IDI2ICsrKysrKysrKysrKysrKysrKysr
KysrKysrDQogc3lzdGVtL21lbW9yeS5jICAgICAgIHwgMjAgKysrKysrKysrKysrKysrKysrKysN
CiAyIGZpbGVzIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2luY2x1
ZGUvZXhlYy9tZW1vcnkuaCBiL2luY2x1ZGUvZXhlYy9tZW1vcnkuaA0KaW5kZXggYzBkMDY0ZGJk
OC4uMTQxNjZlMjg3NCAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvZXhlYy9tZW1vcnkuaA0KKysrIGIv
aW5jbHVkZS9leGVjL21lbW9yeS5oDQpAQCAtMTQ4LDYgKzE0OCwxMCBAQCBzdHJ1Y3QgSU9NTVVU
TEJFbnRyeSB7DQogICAgIHVpbnQzMl90ICAgICAgICAgcGFzaWQ7DQogfTsNCiANCisvKiBDaGVj
ayBpZiBhbiBJT01NVSBUTEIgZW50cnkgaW5kaWNhdGVzIGEgdHJhbnNsYXRpb24gZXJyb3IgKi8N
CisjZGVmaW5lIElPTU1VX1RMQl9FTlRSWV9UUkFOU0xBVElPTl9FUlJPUihlbnRyeSkgKCgoKGVu
dHJ5KS0+cGVybSkgJiBJT01NVV9SVykgXA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICA9PSBJT01NVV9OT05FKQ0KKw0KIC8qDQogICogQml0bWFw
IGZvciBkaWZmZXJlbnQgSU9NTVVOb3RpZmllciBjYXBhYmlsaXRpZXMuIEVhY2ggbm90aWZpZXIg
Y2FuDQogICogcmVnaXN0ZXIgd2l0aCBvbmUgb3IgbXVsdGlwbGUgSU9NTVUgTm90aWZpZXIgY2Fw
YWJpbGl0eSBiaXQocykuDQpAQCAtNTI1LDYgKzUyOSwyMCBAQCBzdHJ1Y3QgSU9NTVVNZW1vcnlS
ZWdpb25DbGFzcyB7DQogICAgICAqIEBpb21tdTogdGhlIElPTU1VTWVtb3J5UmVnaW9uDQogICAg
ICAqLw0KICAgICBpbnQgKCpudW1faW5kZXhlcykoSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11KTsN
CisNCisgICAgLyoqDQorICAgICAqIEBpb21tdV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbjoNCisg
ICAgICogVGhpcyBtZXRob2QgbXVzdCBiZSBpbXBsZW1lbnRlZCBpZiB0aGUgSU9NTVUgaGFzIEFU
UyBlbmFibGVkDQorICAgICAqDQorICAgICAqIEBzZWUgcGNpX2F0c19yZXF1ZXN0X3RyYW5zbGF0
aW9uX3Bhc2lkDQorICAgICAqLw0KKyAgICBzc2l6ZV90ICgqaW9tbXVfYXRzX3JlcXVlc3RfdHJh
bnNsYXRpb24pKElPTU1VTWVtb3J5UmVnaW9uICppb21tdSwNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIHByaXZfcmVxLCBib29sIGV4ZWNfcmVxLA0K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGh3YWRkciBhZGRy
LCBzaXplX3QgbGVuZ3RoLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGJvb2wgbm9fd3JpdGUsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgSU9NTVVUTEJFbnRyeSAqcmVzdWx0LA0KKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVfdCByZXN1bHRfbGVuZ3RoLA0KKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90ICplcnJfY291bnQp
Ow0KIH07DQogDQogdHlwZWRlZiBzdHJ1Y3QgUmFtRGlzY2FyZExpc3RlbmVyIFJhbURpc2NhcmRM
aXN0ZW5lcjsNCkBAIC0xODgzLDYgKzE5MDEsMTQgQEAgdm9pZCBtZW1vcnlfcmVnaW9uX2lvbW11
X3JlcGxheShJT01NVU1lbW9yeVJlZ2lvbiAqaW9tbXVfbXIsIElPTU1VTm90aWZpZXIgKm4pOw0K
IHZvaWQgbWVtb3J5X3JlZ2lvbl91bnJlZ2lzdGVyX2lvbW11X25vdGlmaWVyKE1lbW9yeVJlZ2lv
biAqbXIsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9N
TVVOb3RpZmllciAqbik7DQogDQorc3NpemVfdCBtZW1vcnlfcmVnaW9uX2lvbW11X2F0c19yZXF1
ZXN0X3RyYW5zbGF0aW9uKElPTU1VTWVtb3J5UmVnaW9uICppb21tdV9tciwNCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIHByaXZfcmVxLCBib29s
IGV4ZWNfcmVxLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGh3YWRkciBhZGRyLCBzaXplX3QgbGVuZ3RoLA0KKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgbm9fd3JpdGUsDQorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVUTEJFbnRyeSAqcmVzdWx0LA0K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVfdCBy
ZXN1bHRfbGVuZ3RoLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQzMl90ICplcnJfY291bnQpOw0KKw0KIC8qKg0KICAqIG1lbW9yeV9yZWdpb25f
aW9tbXVfZ2V0X2F0dHI6IHJldHVybiBhbiBJT01NVSBhdHRyIGlmIGdldF9hdHRyKCkgaXMNCiAg
KiBkZWZpbmVkIG9uIHRoZSBJT01NVS4NCmRpZmYgLS1naXQgYS9zeXN0ZW0vbWVtb3J5LmMgYi9z
eXN0ZW0vbWVtb3J5LmMNCmluZGV4IDg1ZjY4MzRjYjMuLjdmNmYzNzk4ZTYgMTAwNjQ0DQotLS0g
YS9zeXN0ZW0vbWVtb3J5LmMNCisrKyBiL3N5c3RlbS9tZW1vcnkuYw0KQEAgLTIwMTEsNiArMjAx
MSwyNiBAQCB2b2lkIG1lbW9yeV9yZWdpb25fdW5yZWdpc3Rlcl9pb21tdV9ub3RpZmllcihNZW1v
cnlSZWdpb24gKm1yLA0KICAgICBtZW1vcnlfcmVnaW9uX3VwZGF0ZV9pb21tdV9ub3RpZnlfZmxh
Z3MoaW9tbXVfbXIsIE5VTEwpOw0KIH0NCiANCitzc2l6ZV90IG1lbW9yeV9yZWdpb25faW9tbXVf
YXRzX3JlcXVlc3RfdHJhbnNsYXRpb24oSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11X21yLA0KKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIHBy
aXZfcmVxLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBib29sIGV4ZWNfcmVxLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBod2FkZHIgYWRkciwgc2l6ZV90IGxlbmd0aCwNCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBub193cml0ZSwN
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9N
TVVUTEJFbnRyeSAqcmVzdWx0LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzaXplX3QgcmVzdWx0X2xlbmd0aCwNCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgKmVycl9jb3VudCkN
Cit7DQorICAgIElPTU1VTWVtb3J5UmVnaW9uQ2xhc3MgKmltcmMgPSBtZW1vcnlfcmVnaW9uX2dl
dF9pb21tdV9jbGFzc19ub2NoZWNrKGlvbW11X21yKTsNCisNCisgICAgaWYgKCFpbXJjLT5pb21t
dV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbikgew0KKyAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQor
ICAgIH0NCisNCisgICAgcmV0dXJuIGltcmMtPmlvbW11X2F0c19yZXF1ZXN0X3RyYW5zbGF0aW9u
KGlvbW11X21yLCBwcml2X3JlcSwgZXhlY19yZXEsDQorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBhZGRyLCBsZW5ndGgsIG5vX3dyaXRlLCByZXN1bHQsDQor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXN1bHRfbGVu
Z3RoLCBlcnJfY291bnQpOw0KK30NCisNCiB2b2lkIG1lbW9yeV9yZWdpb25fbm90aWZ5X2lvbW11
X29uZShJT01NVU5vdGlmaWVyICpub3RpZmllciwNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBjb25zdCBJT01NVVRMQkV2ZW50ICpldmVudCkNCiB7DQotLSANCjIuNDcuMA0K

