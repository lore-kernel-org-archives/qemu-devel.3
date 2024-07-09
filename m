Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40FEC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 06:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR4BH-000101-7N; Tue, 09 Jul 2024 02:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sR4BE-0000uD-P8
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:18:24 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sR4BD-00080Y-1E
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720505901; x=1752041901;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=DyEyFJrO9lIOagX6ucF6+QC5h8iiBFYHP6dorlEqKw4=;
 b=nGmanSTIquY+HgDXraMykscT9F+Kpdu8rbRZ48K4ZwAP4Zie0qtXYp5k
 8+gY5Gu/RQPg8M3u4/PavgUwNdMYmjOm6UAnVEm0D8uU6AlqqtXNJ/XV2
 mM3PfO39dc+3rz6+t+IgABumKbAkjiYRzvMYxUzQ6SkVMkIZrLSKYQS/t
 VJqoeHjnPJ1tihjg3Jn3IHI/Gzh9naF0IQzquQ2oTzVIVzqErCRrcnM1z
 Tevkc2vR2ie1DOQArfPD6/Dvdls7iaMLUkOgUQkHrUAHeEdsuWmJtGBZS
 1OHIPDeX1e95hcSPNqpIBgEi+f4xVecyhGt5jBOrgnyWgovyrznFxzGFp A==;
X-IronPort-AV: E=Sophos;i="6.09,194,1716242400"; d="scan'208";a="16131807"
X-MGA-submission: =?us-ascii?q?MDHOC8HKFkZaFW9W3CvsYY44beo3RaMb5aF3jv?=
 =?us-ascii?q?ywPKbHCqUptO4+LpUuQxJvT2koVGpecNZKW2IX7ovQNfwtF/bL0vkcvv?=
 =?us-ascii?q?rrOqACiFmTpJ6Gc4Vs4rex3JlJlmDEPmFfHbasw48IrxSQLZD/Yohsaz?=
 =?us-ascii?q?c1m8gidrc23/VhPJgVSdHiCg=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 08:18:08 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHgMR27dUVp6cnBvEI8vPh+NNEIspQtnvOrGUWOAAIZrLLKWkN5u50OOOp1hCQLJtVHEP+58PCO77Y3+nqYIMJ8yyOURSaFQzF77Ab6mB4O23ATU16Evylny8XnHIQ/+HqzAsHVVJRJY0AVd5C4+OWyFnR6qLVxq2bwyt7BQ6O4P4jRezFNAElmRztw8RH8y1+PMaS81GrPuycLh6K/+Yi+ACpXnAWewxOhwGmBzQvo4+TckcA6uQn373Ls0k4ZKzF4GVjXR2UI7XcYfA82K8WQqVeZyXBvzJ6+xUXJTMHnWIVjLci9uz8OUVUYyxWrzO/pRopOJnBZhdEoc6rjpnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyEyFJrO9lIOagX6ucF6+QC5h8iiBFYHP6dorlEqKw4=;
 b=ZKWhoAYXjLF0ESBW9ihEgHihAzWToktrrs7wJbmWMsvWRlGWmh86RqAnsPOlkxFml+PlnFGX1ufKla5r56nXlbj7lt3l4yinpvq1DHvSWv/0B6+AS2NNuJCqHsUuMthydta7hQfhqV7PU241g1wcGs/sMj2EdEAKVFll8cHSZyKZf4HEIkBi6Mq4SgQ0bVfu7x7Rm428DT5Edu5Ahj3fI9Q2/QCoQv53duyw3NJNvz0uIaxAR0eaHq5sxjS3nj6rgNyRhuNetSgnSn7hLKzdImhAmXYJmYn3mJDqy1i5x7Q/TlCXagna2CDfyyi6e0zASrUdpBCSAiaIKL0Kk9G9aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyEyFJrO9lIOagX6ucF6+QC5h8iiBFYHP6dorlEqKw4=;
 b=VtKmnwTeXkKhobDSevVHcOH9C7Gl15p9W8sY0x0GW6yf3GdTggY9FUZeOmDJ0XZU5JiRHVFmKYXYTcApnBzoqFet/3z2LD7fqK3WtWRXuZgFyjHdvE+2oPUGpD28wRX1DBKJGIX5Z2N3ftK3rdPq0hcoKWAfzrMM6ZHTuE2Jx4mCkwIjjNx1W0Dau/Fck9urmidO2tuTC2ceRfP0f/PYIgZ4uGuZaYK0WiHfl6ubop48nPAGlI51mTMKz4i9MdPSMw0ITTUUydH8ox5pqSHpQcdyTPA+75OkZV92UTnyrl0vTMdkPxETKcaZbEo0iXqpJM6EY1wOr7tKZRtIZykbOA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU0PR07MB8466.eurprd07.prod.outlook.com (2603:10a6:10:355::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 06:18:08 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 06:18:08 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>, Minwoo Im <minwoo.im@samsung.com>
Subject: [PATCH v6 2/4] intel_iommu: move VTD_FRCD_PV and VTD_FRCD_PP
 declarations
Thread-Topic: [PATCH v6 2/4] intel_iommu: move VTD_FRCD_PV and VTD_FRCD_PP
 declarations
Thread-Index: AQHa0cfEhe7Ej2szhUytlU9cUcJt7Q==
Date: Tue, 9 Jul 2024 06:18:07 +0000
Message-ID: <20240709061756.56347-3-clement.mathieu--drif@eviden.com>
References: <20240709061756.56347-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240709061756.56347-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU0PR07MB8466:EE_
x-ms-office365-filtering-correlation-id: 7d1c782e-b4f5-4236-11a8-08dc9fdee69d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RHNERjV5QkFVbjhlQnpHcWorcmRNdHdDblhyZ1hVRDR0OXAwd2FLMTdHY2NM?=
 =?utf-8?B?TDdlR2dKaUpNMHZ5SUM0TmkyWWphUEdNdVZ5dytmR21pUlRGcFJDR05DM2cr?=
 =?utf-8?B?T2dLQU5Rd202OHlOVE1uUXp0R3FsOGFrcmJDc0huMmlSR3FtOTIxR0w4ZnNq?=
 =?utf-8?B?SzFPSC9IUnlQc1k3UWIxU1R4ZUFra1Z5emVwVEphSjdDS0VDVXdoSEhrc1Jw?=
 =?utf-8?B?aHdXUEdVRG4zUXNiTjk0UnBSQ2dxa2dqSjNpSEUzZ0RKRkl6SitUZGQrVHZY?=
 =?utf-8?B?d1RzemhKdFFPY0pBZjQ3WEZWY1ZTTXV2d0pTVDJ4UG1yZk94UDczUDMvRHVP?=
 =?utf-8?B?cVQ0MnVmajFMcU50dm5wQU9yTElmZ3dVeDd5RUJNSnF2YmZtR3ZGZGhpcEMx?=
 =?utf-8?B?YjNkRENUUzJEZkEvNVdCRE1tQVAyL0pXWlo2QnpUV1pmQ1lhVnI0M2FnMG00?=
 =?utf-8?B?YXhXcWlTYjZDUWc3a21HTHJocldkTWRqZ3l1VC9xU3ZYTlNjWG4yZUttK1cv?=
 =?utf-8?B?QjYzR0ZBSkJVeHl4SUpRVkRmOUljZCtqOU82UTdyWVBUU0dBTnZhQ3NFdHBq?=
 =?utf-8?B?cDFqbVlKamhuL3BaRmFpOHpuN3U3RzVRZGNCUHVWLzBqaGJTVVlQNTQrbHZi?=
 =?utf-8?B?SFJBS3ZIZE5ja1Rwa1RUZU1qMEp5T2UzVFJoZHphb2p0RDdqTHR4WmN5cWI3?=
 =?utf-8?B?MVFBczltdWY2VDdMbWpzTVRRNnNTcXNQUGxRZitTOWIweDloaUg0dnJXR1NI?=
 =?utf-8?B?dlEwQnpyZ1o3QlhWNjgwczhoRjZLMTZMY3BqYmJLL0FhY2FDQWNIU1FZU2cv?=
 =?utf-8?B?R25VOEt2TkUyQldTbURtNW50RzdSTzhZdkNzSnl2T1FkYjVJZ3ZuV1hvRjRh?=
 =?utf-8?B?L3IyUEI2MU8vZG93bHl2eXpyVGlaMWF0YXd6Zi8raDJNZlpUZFBLTzBSRXpL?=
 =?utf-8?B?dEJBRVk5cmJlUnhwcFpNc3E0MWxhY0tqTVBZSWJSM3VVTDlWbXV0RjRRakFI?=
 =?utf-8?B?RE5TWUVSY0wyQm1lQmJOcEpCNU95cFA3bWd6emxxMG5ScUluajY5Y01mN2FC?=
 =?utf-8?B?YkVHdmV5MDFWQXQ4VS9wMHRORzc2SWhJWXRUeEJqT1JQM29Ba2pWbFp3Zkhm?=
 =?utf-8?B?dDdncktHa2JRUWFwQk5iSThha3ZWTDkvZ0hmalBwclhxNVJIQmFrM0dEeW9E?=
 =?utf-8?B?RlJiTExOZ254TG1EK250U3haNWlTUHhwZlJvemFpMGh0TWttWm5JdzdVK01X?=
 =?utf-8?B?MTRGK2dEVFIvM2ZsUGk3ZnBWZ3dZOTR6RFdQcVlsZXpxa3IxMTdsT1JybHBt?=
 =?utf-8?B?TEZ6UFlsNnZPZ0ZocEUxbnBaZUQ1KzQrOU4xVU5hcU5wZ09aN0xmbVlYcmhk?=
 =?utf-8?B?c3UrUEtidFc0encvVjZ3ZG12MlM5TU1zNkRPUjlBWk5odTlraWFZNGRsOTlE?=
 =?utf-8?B?VkxkUmdiNkNMWEw5b3p2dFZ2NHJDbVNudGRlbEVUeDlYcitmNkYwWVN6NlZu?=
 =?utf-8?B?c2UvdTNFVHRkS1UwRFg2WDVKK09SUERMWkIvODFxZG93cXhvUWZEcHhpSHNN?=
 =?utf-8?B?MnY0K2o3aWNkOTJBa0xFZDdSQVNXZTdmS2c2UGpidDZJalcvRTFsMC9SWDZW?=
 =?utf-8?B?eTZjVFJySCtpbGJyanRJUDhhMXdSVm1rY2FINjN1MVpLMENFNE8zNHVBOWt6?=
 =?utf-8?B?UlUzSm9FWmJldFRFd09seXpCaGJpVDVpTGRVcWJzYTVNbGZ5R0VZR0ZCODA2?=
 =?utf-8?B?WHBuVmdMUVIvNEpuTk1BU2VWU3ZnNVA1dXJUZkNrTHVmeUdJNDY3dmIwNlpN?=
 =?utf-8?B?dU9MdW9GeHVzdUVuM0NRUGhzR3cydjBrdXBDejBMZmZYcm9lblhrZWRBVWxv?=
 =?utf-8?B?aFk4dG95L2JwUUhpWHQyMWlVWGpQejVxeFZ1N1A4U3BpQVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djJocE1PVExHQ29vUlB3aFhlc0U4bFUxZ3NISVlobmNweVhUb0ZWbE5HdDIz?=
 =?utf-8?B?ZEZQN2IxcnduNjVjYyttVk1XNy9YWUl6Y3hKcWVzaElNRTNyeE9IRGNxSVJr?=
 =?utf-8?B?TjJpblhISmlNdUlxamlOamFWMWlCdTJEUzdUL0Y5dVB0REd0Y1FQdWRpMWU3?=
 =?utf-8?B?VVJvanJiekJEM0ZyWmNmU1NrdGt0WFBVc3FSd21ndWxYc2hFR2NXOTRRRHpY?=
 =?utf-8?B?aFMwWlJqbFRKQkMwOTNhSDNXZUlsVWsyZEQ0MWFjd1ZMdjNsQ0MwLytvTXFE?=
 =?utf-8?B?TVFDSUkzZXBkdGN2c05GQUp5QXhZWDl2VUdnTFdzTFFnSFZVZ2JRUnJFYmxE?=
 =?utf-8?B?cnpvK3Vob3B4cWNhYm8vbDAxTlI4QWNRNUJmMkVjRnVKdlFrdFpvalVWS1U4?=
 =?utf-8?B?cVE5QkJhOVRiVWl2ZXZRZ3ExbjErQi9CQnF2MVFha3JkSysxMUh2RXhpQXBm?=
 =?utf-8?B?ZFh6eGpPNERLMjdSMU1iQUFxZm95aVVRbnhIc1NtM2ZTZ0NCNE5NYzRVT0Uw?=
 =?utf-8?B?L3pUV1VxRm5CMXJ3emJxL3JHcE5POXZkYXZ3Wk41Wlp2c0hNSEduWUgvMEpx?=
 =?utf-8?B?ZW9OOHBiVG1OcC8xanZTNHlEUldsUjMvMEdSUDRjYVlJS29UcDNjVmdYQXN4?=
 =?utf-8?B?WUdvT2FpbWYyanQ0bVhZa29CREZXNFRRZmtjKzMwNTRaWVZML0hRTmQxd0VN?=
 =?utf-8?B?VVU5R3R2THVBWmsvdm4wVVl5QlZZT2t5MjdFNHAxd3V5NmZaRS8vbDBrQU11?=
 =?utf-8?B?T1RFZ2JMdng1b25Qa1l4RU93Q3pNejdYcllyK21rK0orb2I1MXRBU2JBaW4v?=
 =?utf-8?B?Nlk5M1hzUWRMbGExOXRlcFNxQTY5T1dEQTdMOWhJWEdnSWhmRXNIM3R3cU8z?=
 =?utf-8?B?UnZvTkxzZ2xkTExkQmZnVmwrajNBTUdjcXZHSVArU2ZQWEZmdHltWDVGd1cw?=
 =?utf-8?B?dFNzMmNnc1pJamFJT25kcm9adUNhYmg4ZENJTi9PVDZJSXY2dHRKL1R6V1JV?=
 =?utf-8?B?UWVPWW1nd3BwcHRERUJKVWZwZWg0T0h5SDlaNHBJa3JzNUNnYU55NklwTGVt?=
 =?utf-8?B?dDhCVWpNelZBd2dwZHRDSU9DenVvYVdMUGlobGlaWHVkUVZwdC9ET0N0c0F6?=
 =?utf-8?B?MzFseS9CQ3pRWlZqc3RqQTJpaE1CYjd4QSs4c0s5WTlTK0tlWDBZVmpXczFh?=
 =?utf-8?B?NDJ5Qkg0V3hXcURoMkNXUVR4K0NMZ1FQN0dYdkExNUs2MDJ2WER3Mm1RYUds?=
 =?utf-8?B?U0dibTd3a0lUaFlFT29sSVE1UFJibmJCZ0hvVUZZM3pjcXNRbEYvZzJNdng2?=
 =?utf-8?B?QnBjZ0pvU0hnejRuQ0RkYlVEREtFQXNpTVhBNmQ2cFpnbnFXeUhlNkhNRU9T?=
 =?utf-8?B?cnMvalJ1RnZGcHQ1bzFzR0FMSUxjZ1dDMng3ZHl1emFiMy9SUHM5S1NMWVVk?=
 =?utf-8?B?bXVJVmJKYmFTUHRWYzlYekZFYjkrb3Z3aDArNk4xMW9TdUNWNURZTDJSUitt?=
 =?utf-8?B?dVlzR1FFeE91dER0QUpyK0ZpQ08rY2FTbDN5ajQxV1MwT3RrWU8zRE52THds?=
 =?utf-8?B?REJCYVZXVWJGVTFUeVIzcUplNVZabm01U1JmeExrMWcxeVB0d3RRb01aVjM2?=
 =?utf-8?B?WGpEbHZ1ZmZVQlRQS1pXa0hHckdlUU9hUHV5ajhwcEtCVFQ5Q2gvTXpQVnFz?=
 =?utf-8?B?c1VIOHBKUjRDYTRLd3p4V0ZGSEJaekxrTXhRQnp5Y3hOOG5CcW11eVg2bVQ0?=
 =?utf-8?B?YnN4NVRWSTVobUxUMitPWTVjeWJqT3E0VHVvNSt4QUVELzBRekZBeElyME5U?=
 =?utf-8?B?RDZZVXpSSGJ4MktBQVdGK05JOUdybjBFYndUSjd3N2tzVUtHaFdZZCswcVZF?=
 =?utf-8?B?dVVWQTR6VkN6YytJZHFoUko0NER1Q1dlMWdreS9uVjVmeEljRVNjYVU1cUxu?=
 =?utf-8?B?Tnc0YjArUDgwSmhsc0JSNU8zYXg3ZUJGV0VDSUsrWnpNaFpYQXlEV01RTnZk?=
 =?utf-8?B?aDROVnVsS29qQ0xoRmF2Z05HbVNaSzdud0tTNFR3NU9kVnovNVhxaitoR1pQ?=
 =?utf-8?B?UE52YXRBdGhNVnQyVkJmSk5RZ1RLb0hqZlNDT2QzbzRFdGVGb0JwbndaRXhV?=
 =?utf-8?B?OHQ0Rk1DRnUyOHNZT3lMZTBkTUx3eGxTWTlOa2F5UHgxSSsxKzVNdXVGVk9P?=
 =?utf-8?Q?xsY+9biFIv/4TTwGSGCnIKU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DDA7387EB6BCC4AAB7D7B3D52AA116D@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1c782e-b4f5-4236-11a8-08dc9fdee69d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 06:18:07.9971 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sUnFlVozi5rQl+Hem5AquM0chwdq417ie8vPnSqMqZ7B/Wui8vCeRCqyFOPhcnEvIz/kR2RuH2VY9qUQrsAmD03jGZXh8JY5+FDd7hUNv4gHZt9DD1b2Rq3qvlxMwY/U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8466
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
bi5jb20+DQoNClRoZXNlIDIgbWFjcm9zIGFyZSBmb3IgaGlnaCA2NC1iaXQgb2YgdGhlIEZSQ0Qg
cmVnaXN0ZXJzLg0KRGVjbGFyYXRpb25zIGhhdmUgdG8gYmUgbW92ZWQgYWNjb3JkaW5nbHkuDQoN
ClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0t
ZHJpZkBldmlkZW4uY29tPg0KUmV2aWV3ZWQtYnk6IE1pbndvbyBJbSA8bWlud29vLmltQHNhbXN1
bmcuY29tPg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgNCArKy0tDQog
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxfaW9t
bXVfaW50ZXJuYWwuaA0KaW5kZXggY2JjNDAzMDAzMS4uZmFlYTIzZThkNiAxMDA2NDQNCi0tLSBh
L2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oDQpAQCAtMjY0LDEwICsyNjQsMTAgQEANCiAjZGVmaW5lIFZURF9GUkNEX0ZS
KHZhbCkgICAgICAgICgoKHZhbCkgJiAweGZmVUxMKSA8PCAzMikNCiAjZGVmaW5lIFZURF9GUkNE
X1NJRF9NQVNLICAgICAgIDB4ZmZmZlVMTA0KICNkZWZpbmUgVlREX0ZSQ0RfU0lEKHZhbCkgICAg
ICAgKCh2YWwpICYgVlREX0ZSQ0RfU0lEX01BU0spDQotLyogRm9yIHRoZSBsb3cgNjQtYml0IG9m
IDEyOC1iaXQgKi8NCi0jZGVmaW5lIFZURF9GUkNEX0ZJKHZhbCkgICAgICAgICgodmFsKSAmIH4w
eGZmZlVMTCkNCiAjZGVmaW5lIFZURF9GUkNEX1BWKHZhbCkgICAgICAgICgoKHZhbCkgJiAweGZm
ZmZVTEwpIDw8IDQwKQ0KICNkZWZpbmUgVlREX0ZSQ0RfUFAodmFsKSAgICAgICAgKCgodmFsKSAm
IDB4MVVMTCkgPDwgMzEpDQorLyogRm9yIHRoZSBsb3cgNjQtYml0IG9mIDEyOC1iaXQgKi8NCisj
ZGVmaW5lIFZURF9GUkNEX0ZJKHZhbCkgICAgICAgICgodmFsKSAmIH4weGZmZlVMTCkNCiAjZGVm
aW5lIFZURF9GUkNEX0lSX0lEWCh2YWwpICAgICgoKHZhbCkgJiAweGZmZmZVTEwpIDw8IDQ4KQ0K
IA0KIC8qIERNQSBSZW1hcHBpbmcgRmF1bHQgQ29uZGl0aW9ucyAqLw0KLS0gDQoyLjQ1LjINCg==

