Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0FEC25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2024 08:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8bot-0003oJ-4V; Sun, 19 May 2024 04:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s8bop-0003nr-Rt
 for qemu-devel@nongnu.org; Sun, 19 May 2024 04:22:59 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s8bon-000056-Cx
 for qemu-devel@nongnu.org; Sun, 19 May 2024 04:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716106977; x=1747642977;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=U48vezoo4w+bjqGuSCnAZA+yAjAqXtezjwEU0mmds1k=;
 b=VexXQ6B9nTLg+SU9XwdF5A4qjDhLvXOjCQSFIU37lq0tJ7KBQcfXLqj9
 EeVP4kQtvFnqlkcX2BqtHrcrDh+m0mEmNzJ8FfW0IvJYW4vcs87KxJbAd
 C4y6v5/BGm1ZnuAQo1Q29Fal9ixUjH1lR41Wo7PZe+nahfWbqfNezVbEC
 5+V1S4qxFJgeYTH3pUfMGRO1eaNmOfany0MSJaTRDn/ILbQtBDS5ZFbOT
 917UP0p1N5/nYqhCAGCkiGqvnyaDZ17jGGLIQ0oVuefd/YoxtzeLgJqXV
 3y+TgjFmTlMcAm5lxDrbGPDCNykc9miALPOJoZ3X3eIOgkaCJBA9xZWAe w==;
X-IronPort-AV: E=Sophos;i="6.08,172,1712613600"; d="scan'208,217";a="12871092"
X-MGA-submission: =?us-ascii?q?MDF8GITlmfE4MpUHt3oUwtYBhJUfk8O8mTwD9A?=
 =?us-ascii?q?7HbSeihFatBDh5FlYKIEwjVp3dxGWDF/25WGd+dlKomCoGq29ytkOmUn?=
 =?us-ascii?q?CVR/23ItduF6ohFf2qgNnfU7k79cC2CtCsKkJOlfyJHTb+zsEQ82cQ4B?=
 =?us-ascii?q?hDAq/DrHYwobW9bZa9ahvVoQ=3D=3D?=
Received: from mail-am7eur03lp2232.outbound.protection.outlook.com (HELO
 EUR03-AM7-obe.outbound.protection.outlook.com) ([104.47.51.232])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2024 10:22:53 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqlh2auXet8amDKf0QUrXP/ZTOG1LUHD1td7b7hdKWct1zKMLPVoXm7GNKMOvxnrSJ4qmTRDao7YSk94p9n/LoBW/Hq/SwORmQBvbkXFMBQkJnSxqtt46CiBMsHBOQzWW/VrsDvKETWgx+p3jPyWQ/kM6iKLGcOFsMJ9dvK4rKBGx+hcRtHLcHJ6L9ouT/FaPCqk5F3Sqofn51NOeSVHqyDu+4kFRiTalyeLJh99TLWCbgw8Y9mKHQKjb+m369S8fowrreWGgg+sdK4fFln4KFirQwaSrVjsK6Bzdntlz0hnNxf3oel6AUtJ/l5pPaCoHa71feZwjJaTZz//E42QGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QGkXp47g7Z8kLJmAnn7BOuKKzE8iuLNzTYtn/G+Alo=;
 b=n9FPs13kUPfjKQN9bDHeXjZLxoxqmmbw0DaySDnnF4fkd82zMscPzmRlTuLDyRK8+1GEPDDMl3isNYE9sCn3mPc4FiEj/V2vwaO2s0CGt4uUomv7GlVeXDKfmbEyoGD6o8ComG4Ca84DKTHfHiCi+03qLEAf2FT42ULiWFA07yJh+vFQJDOs8s1MMVMEKG7XgvABUGDRiCEO3rvZ4ixW/CijS264atUCZ5RxmLItCWh2agnbwsaEBSt606SeB71sCccu+Ng5ilNirAc+QUV7XlAgSVADgF+c94d2pHQy8t0h/Q/rspBL/oPV9qaUkQwmY8KumuJLGGEuC2Yzsqvnqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM7PR07MB6563.eurprd07.prod.outlook.com (2603:10a6:20b:1ac::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34; Sun, 19 May
 2024 08:21:55 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7587.030; Sun, 19 May 2024
 08:21:55 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "Duan, Zhenzhong"
 <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "Peng, Chao P" <chao.p.peng@intel.com>, Yu Zhang
 <yu.c.zhang@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Thread-Topic: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Thread-Index: AQHaqETF994sGJc2f06J4v32nB22BLGbZ2IAgAKdIYCAADXnjg==
Date: Sun, 19 May 2024 08:21:54 +0000
Message-ID: <AM8PR07MB7602C1E7400DEE2E35AB4A5886E82@AM8PR07MB7602.eurprd07.prod.outlook.com>
References: <20240517102334.81943-1-zhenzhong.duan@intel.com>
 <02ee8c65-54a8-4ce4-a4a0-351f29f3eea6@eviden.com>
 <DS0PR11MB75299A30E22AE7CC768CEB64C3E82@DS0PR11MB7529.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB75299A30E22AE7CC768CEB64C3E82@DS0PR11MB7529.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Enabled=True;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SiteId=7d1c7785-2d8a-437d-b842-1ed5d8fbe00a;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SetDate=2024-05-19T08:21:54.732Z;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Name=Eviden
 For Internal Use - All
 Employees; MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_ContentBits=0;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM7PR07MB6563:EE_
x-ms-office365-filtering-correlation-id: 1350ab1f-70e3-4844-4a3c-08dc77dcbe60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|7416005|1800799015|376005|38070700009; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?SNe5h0mpLn4y3cW7HerO4zrhIAz5baEri+Z5sA4qqKlB0Vw0aW06kJ7dWz?=
 =?iso-8859-1?Q?L/TJzgEPTW/Kcr4zjKTyNdxjwM94eUIt05oUWxScJz+AMcJiD/44ASG9RC?=
 =?iso-8859-1?Q?nORQ9tk41ckEZzYcvGtZhCEeKrb9Arz9jPih9oAOkWkUAYkTr9U9XCZkYP?=
 =?iso-8859-1?Q?OG/gI3wcLx2tR3TVf4edV3gBWP0HbUNQardCu7K+9fZGCxlVr7oszZD7jU?=
 =?iso-8859-1?Q?BHCPo1Ort/4tBsGUN0ppsdcrj0XBTKBEDIiiAveoKdi/9+UHoQd8KqvLhx?=
 =?iso-8859-1?Q?sTL/E1Y89YkGUEAghS8Doub5CCKEVMcyT0mGI5M2+QanT4MFm6H0zZOaY3?=
 =?iso-8859-1?Q?COyxF0Zwi/bpCAyHnD6b26JHdMnO+V79wVaX8M/HIQHFJOR4fq6aQLrFRq?=
 =?iso-8859-1?Q?m8Hcrsav+qP6a68nwE+owuqM05wZF00LPUDuXER9jNqMSIJGKSN1icLmiQ?=
 =?iso-8859-1?Q?MS5zrx0SGZmm4oVLmHATcAKgrDf4AQESctQO3/dd79J6NcK3LlTvEkyxI5?=
 =?iso-8859-1?Q?mxt8TlFfdGAlSwxzEAeQVWIsCOWs8qTO+MLRq+vgWWXOE9GzoqjjpAdQ8c?=
 =?iso-8859-1?Q?KJLSVz6oNfIIA+/p8d1PVa1CiSn8tyEp9RvB70+Hy8lJKLRwss9NpL0Ecr?=
 =?iso-8859-1?Q?3apUhAigSNDb+IGnslbgNTG6odhiLKEfTdgS3cSXfOU4zJrjNWwwUWmBEA?=
 =?iso-8859-1?Q?1D3l79kAxUx+7d1WAG/pEYwVR2zREzKsbNy48CToekiwRcplzqUCl6RBL+?=
 =?iso-8859-1?Q?yrDFHlg++NoKm5KXXcsEQWTYK/dWRmivgKLAT8gsAUaTS4I0+dJ/d+m2sY?=
 =?iso-8859-1?Q?XQ+DEuvytyclba274nNbbciZpsVRtqJbQx7aYUAWhwmKPK+eeiRQ3rj91u?=
 =?iso-8859-1?Q?oaB/fh6GclAj5LZSQ/3y14ACG8B26m2x4jY0eEg0rDYy6WKFOk+XtTRlnQ?=
 =?iso-8859-1?Q?yKLnfmixfbZ+aioZS+X0MfbF8pUAGBrGd0pQiRSQrw/qObk2PL5G8Qm15l?=
 =?iso-8859-1?Q?U5gGT31/EPV5Tdidd/fgjmifOEcMDRqJwS+Ip1cu0LKgp1hMr1JVS3esai?=
 =?iso-8859-1?Q?lotnVfX30gbNCTYecZVb8+Vk1ddHqpYT5F+sXw4xomnMJr4W5aeeDBYOGd?=
 =?iso-8859-1?Q?8l0hmel1zpX5dIUOv98cI0YtBCD8176mGYf5gVEgtUgIjDlbSYCk08ViEO?=
 =?iso-8859-1?Q?hkIZ8b1VC/PUkLjuUoHJNhN/guF2oitwhMZZNl0AllxkaI7VOt24cntF2k?=
 =?iso-8859-1?Q?UxtCVZVhDz7uMcjbrkYp8FuXTnIByMCMmPdScyST4Ba23AS7Cc50kC8FRL?=
 =?iso-8859-1?Q?kHiDT1A1u4BmDOcUdOKtZr9++gwkqeYxv6+A6YY7Bon/aF3oR7nGkNvsjA?=
 =?iso-8859-1?Q?oVb6yVl3rCU2jXWkhJ6ttcIX9VpAIn8Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SG+A2bhswatv4dHV3N86e4Sjf2rmbzeVluYVVdg61bEhbG9B2i8/9A0rsN?=
 =?iso-8859-1?Q?klgqF0Uc1+KHFEjWHE93N6rqAV86RYV2SLxKEySwQ3Ddc4BAgq/0hh+r9T?=
 =?iso-8859-1?Q?ktRvfyLBlDb9h1+J6BDfsMtgjXJ7uVXm/2748TOjkDmBYbTVjG5RhAJpVc?=
 =?iso-8859-1?Q?tW8xTJ2CYyzlP+xDy/3iZZ4yuisw12rDTFuXIwvC7jxLhCxvGXiSOfkWB4?=
 =?iso-8859-1?Q?V9MgjeASN4gsquTZwuFEm8/5bkmpL6wjR5jyYW6FEXMbdm2u9XkvO1SeCc?=
 =?iso-8859-1?Q?5Qgx2iomRV/nc63v0LVjh8UgPdOh+W2WNLAN6wOdSMYmwM8Pw/0K8r4vHM?=
 =?iso-8859-1?Q?VH7jWSygfbxJrKy9bu0MCltoAr8GYyuUpDbHx7kR8Tb4pgnM9m1zt0199e?=
 =?iso-8859-1?Q?mO0sMo0OZpzJHmxgl89Oin9gRR/VDQY1G3T03p9PG1jY92w1pC76J/x3eu?=
 =?iso-8859-1?Q?5Uo4XE6twZ7E80XpfXYh/9yOaNdWY4UUvsomoPRNtAsQA4XCjezmC6gCRs?=
 =?iso-8859-1?Q?cV3h3w8y8kXUuB/5IqaaYEGWFj3+DW5KeTa8gvhErGT6t3/3Wo4K+FVsF+?=
 =?iso-8859-1?Q?DmAMP2VAHitCT8CLLT1GvoCIcKCT2HchOLZN+wQVmCRQPvKMssekhSsPLg?=
 =?iso-8859-1?Q?sRf2GseaztZ/ijZ41GFZaNgHsdBeuGey9YBpwq7YLPgDLDdt+b64w7eORP?=
 =?iso-8859-1?Q?wGbe+VutdCiuC1CwXT7kH/5oW5/Otohj8VBZxd7BpTlHu2uRXYEB0MbkQo?=
 =?iso-8859-1?Q?vK45qHitnVR5T7brKdJyIV3xTw7ZUj0hsB+uDZI76GHINfw5SgElbGvn3J?=
 =?iso-8859-1?Q?g7ULpSJkmxVDM5LpeUI1HL3LvlguseZiq4pJKfMOF02zadVNv9iHAQZ8dI?=
 =?iso-8859-1?Q?a6pTYACxz0HWfPhCGNd+hW65Js9doiL76GzQ96ITFezaVAwEc0ERnaBIqu?=
 =?iso-8859-1?Q?WbJs7tyyIQvR4lYfou7RaUV/l9ssXVtpLkdwGu1vT7sVIo8mOYhrsP/Qxl?=
 =?iso-8859-1?Q?P335zSObBV5xKD+jTZ4queUVI0/0gCoU9Qx1+pzdrqs5ZkpsnLaFGlgAG/?=
 =?iso-8859-1?Q?ZrWftFi+MBSmqAxuQgrSWnDT7oX0PvVFRMFk0ozlnUNBuPtfITFIKf6oWp?=
 =?iso-8859-1?Q?5uyZwzWBOWArWPRjHlxfdRWm0mQmEpVJ59ifQuw37Vh3ZjfKbuM23L3Xi9?=
 =?iso-8859-1?Q?dtqsKa9nWp53iuozce1T3CMr5kr3EC/3a4GYntkmqAaKdjgv/KYcT6TY5O?=
 =?iso-8859-1?Q?BAiP9uVXnwnF/nbjDJOGKn/IaQ1y2DJSCs7laZtv41GKE3yslN16L0HLNY?=
 =?iso-8859-1?Q?iImKBP/1KiPlB8v+jRHpGDlsYbCJGFT68Vv/CPIX+czvEMfh96/1I/zL/u?=
 =?iso-8859-1?Q?/QLjxvX6tJAKqqFYTIbEC5pb99vBcJc38Rbx5BzbtxCn3Zq1FwhPTfMKBS?=
 =?iso-8859-1?Q?FtwRZU5L2jqN8zNwVvt0LK1ox1Mm66gbqPLV/r8oxStbmR+epcsqniZd+T?=
 =?iso-8859-1?Q?r914NpvrSIxSsmPgTX5xUECuqGE6Qvi/BloDV/iBRJZlpva3H5I6HHW4+u?=
 =?iso-8859-1?Q?2+OSocMpCo2Zcx9ifsxdAAKoCu37QeUHxaxwQEryrVN3UzPBmbs8clSLs1?=
 =?iso-8859-1?Q?xwKEfOP+u0oCjp6J2KjliBCgeT68xXdNZrqu76aQSLNxP1NXsrGg1BZDtz?=
 =?iso-8859-1?Q?zq4pQZLVgVkTd+eg+QwuOc6DPlBg8YvWq4tFaYwrycOEXiRQqfGX/cc5yX?=
 =?iso-8859-1?Q?uioQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_AM8PR07MB7602C1E7400DEE2E35AB4A5886E82AM8PR07MB7602eurp_"
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1350ab1f-70e3-4844-4a3c-08dc77dcbe60
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2024 08:21:54.9856 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tpbnmdZLHFKDRUF3/sGibwS9wo0nFcb6+Bu/jxItXV+qPXpO3cLGzYvS1SqxEL0bYAC70WY/TOX6PX8k45/ZAuekUfBan+u9UIk4ivnxnMQnX684S9u+Vb9s87gQx70Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6563
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--_000_AM8PR07MB7602C1E7400DEE2E35AB4A5886E82AM8PR07MB7602eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
> Sent: Friday, May 17, 2024 9:13 PM
>
> Hi Zhenzhong
>
> On 17/05/2024 12:23, Zhenzhong Duan wrote:
> > Caution: External email. Do not open attachments or click links, unless=
 this email
> comes from a known sender and you know the content is safe.
> >
> >
> > From: Yu Zhang <yu.c.zhang@linux.intel.com>
> >
> > Currently we use only VTD_FR_PASID_TABLE_INV as fault reason.
> > Update with more detailed fault reasons listed in VT-d spec 7.2.3.
> >
> > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> > ---
> >   hw/i386/intel_iommu_internal.h |  8 +++++++-
> >   hw/i386/intel_iommu.c          | 25 ++++++++++++++++---------
> >   2 files changed, 23 insertions(+), 10 deletions(-)
> >
> > diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_inter=
nal.h
> > index f8cf99bddf..666e2cf2ce 100644
> > --- a/hw/i386/intel_iommu_internal.h
> > +++ b/hw/i386/intel_iommu_internal.h
> > @@ -311,7 +311,13 @@ typedef enum VTDFaultReason {
> >                                     * request while disabled */
> >       VTD_FR_IR_SID_ERR =3D 0x26,   /* Invalid Source-ID */
> >
> > -    VTD_FR_PASID_TABLE_INV =3D 0x58,  /*Invalid PASID table entry */
> > +    /* PASID directory entry access failure */
> > +    VTD_FR_PASID_DIR_ACCESS_ERR =3D 0x50,
> > +    /* The Present(P) field of pasid directory entry is 0 */
> > +    VTD_FR_PASID_DIR_ENTRY_P =3D 0x51,
> > +    VTD_FR_PASID_TABLE_ACCESS_ERR =3D 0x58, /* PASID table entry acces=
s failure */
> > +    VTD_FR_PASID_ENTRY_P =3D 0x59, /* The Present(P) field of pasidt-e=
ntry is 0 */
> s/pasidt/pasid

Per spec, it is pasid table entry. So Zhenzhong may need to use the same wo=
rd
With the line below. E.g. PASID Table entry.

Regards,
Yi Liu


Ok fine

regards,
>cmd


> > +    VTD_FR_PASID_TABLE_ENTRY_INV =3D 0x5b,  /*Invalid PASID table entr=
y */
> >
> >       /* Output address in the interrupt address range for scalable mod=
e */
> >       VTD_FR_SM_INTERRUPT_ADDR =3D 0x87,
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index cc8e59674e..0951ebb71d 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -771,7 +771,7 @@ static int vtd_get_pdire_from_pdir_table(dma_addr_t
> pasid_dir_base,
> >       addr =3D pasid_dir_base + index * entry_size;
> >       if (dma_memory_read(&address_space_memory, addr,
> >                           pdire, entry_size, MEMTXATTRS_UNSPECIFIED)) {
> > -        return -VTD_FR_PASID_TABLE_INV;
> > +        return -VTD_FR_PASID_DIR_ACCESS_ERR;
> >       }
> >
> >       pdire->val =3D le64_to_cpu(pdire->val);
> > @@ -789,6 +789,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMM=
UState
> *s,
> >                                             dma_addr_t addr,
> >                                             VTDPASIDEntry *pe)
> >   {
> > +    uint8_t pgtt;
> >       uint32_t index;
> >       dma_addr_t entry_size;
> >       X86IOMMUState *x86_iommu =3D X86_IOMMU_DEVICE(s);
> > @@ -798,7 +799,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMM=
UState
> *s,
> >       addr =3D addr + index * entry_size;
> >       if (dma_memory_read(&address_space_memory, addr,
> >                           pe, entry_size, MEMTXATTRS_UNSPECIFIED)) {
> > -        return -VTD_FR_PASID_TABLE_INV;
> > +        return -VTD_FR_PASID_TABLE_ACCESS_ERR;
> >       }
> >       for (size_t i =3D 0; i < ARRAY_SIZE(pe->val); i++) {
> >           pe->val[i] =3D le64_to_cpu(pe->val[i]);
> > @@ -806,11 +807,13 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIO=
MMUState
> *s,
> >
> >       /* Do translation type check */
> >       if (!vtd_pe_type_check(x86_iommu, pe)) {
> > -        return -VTD_FR_PASID_TABLE_INV;
> > +        return -VTD_FR_PASID_TABLE_ENTRY_INV;
> >       }
> >
> > -    if (!vtd_is_level_supported(s, VTD_PE_GET_LEVEL(pe))) {
> > -        return -VTD_FR_PASID_TABLE_INV;
> > +    pgtt =3D VTD_PE_GET_TYPE(pe);
> > +    if (pgtt =3D=3D VTD_SM_PASID_ENTRY_SLT &&
> > +        !vtd_is_level_supported(s, VTD_PE_GET_LEVEL(pe))) {
> > +            return -VTD_FR_PASID_TABLE_ENTRY_INV;
> >       }
> >
> >       return 0;
> > @@ -851,7 +854,7 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUSt=
ate *s,
> >       }
> >
> >       if (!vtd_pdire_present(&pdire)) {
> > -        return -VTD_FR_PASID_TABLE_INV;
> > +        return -VTD_FR_PASID_DIR_ENTRY_P;
> >       }
> >
> >       ret =3D vtd_get_pe_from_pdire(s, pasid, &pdire, pe);
> > @@ -860,7 +863,7 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUSt=
ate *s,
> >       }
> >
> >       if (!vtd_pe_present(pe)) {
> > -        return -VTD_FR_PASID_TABLE_INV;
> > +        return -VTD_FR_PASID_ENTRY_P;
> >       }
> >
> >       return 0;
> > @@ -913,7 +916,7 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
> >       }
> >
> >       if (!vtd_pdire_present(&pdire)) {
> > -        return -VTD_FR_PASID_TABLE_INV;
> > +        return -VTD_FR_PASID_DIR_ENTRY_P;
> >       }
> >
> >       /*
> > @@ -1770,7 +1773,11 @@ static const bool vtd_qualified_faults[] =3D {
> >       [VTD_FR_ROOT_ENTRY_RSVD] =3D false,
> >       [VTD_FR_PAGING_ENTRY_RSVD] =3D true,
> >       [VTD_FR_CONTEXT_ENTRY_TT] =3D true,
> > -    [VTD_FR_PASID_TABLE_INV] =3D false,
> > +    [VTD_FR_PASID_DIR_ACCESS_ERR] =3D false,
> > +    [VTD_FR_PASID_DIR_ENTRY_P] =3D true,
> > +    [VTD_FR_PASID_TABLE_ACCESS_ERR] =3D false,
> > +    [VTD_FR_PASID_ENTRY_P] =3D true,
> > +    [VTD_FR_PASID_TABLE_ENTRY_INV] =3D true,
> >       [VTD_FR_SM_INTERRUPT_ADDR] =3D true,
> >       [VTD_FR_MAX] =3D false,
> >   };
> > --
> > 2.34.1
> >
> >
> lgtm

--_000_AM8PR07MB7602C1E7400DEE2E35AB4A5886E82AM8PR07MB7602eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div id=3D"appendonsend" class=3D"elementToProof">
<div style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&gt; From: CLEMENT MATHIEU--DRIF &lt;clement.mathieu--drif@eviden.com&gt;<b=
r>
&gt; Sent: Friday, May 17, 2024 9:13 PM<br>
&gt;<br>
&gt; Hi Zhenzhong<br>
&gt;<br>
&gt; On 17/05/2024 12:23, Zhenzhong Duan wrote:<br>
&gt; &gt; Caution: External email. Do not open attachments or click links, =
unless this email<br>
&gt; comes from a known sender and you know the content is safe.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; From: Yu Zhang &lt;yu.c.zhang@linux.intel.com&gt;<br>
&gt; &gt;<br>
&gt; &gt; Currently we use only VTD_FR_PASID_TABLE_INV as fault reason.<br>
&gt; &gt; Update with more detailed fault reasons listed in VT-d spec 7.2.3=
.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Yu Zhang &lt;yu.c.zhang@linux.intel.com&gt;<br>
&gt; &gt; Signed-off-by: Zhenzhong Duan &lt;zhenzhong.duan@intel.com&gt;<br=
>
&gt; &gt; ---<br>
&gt; &gt;&nbsp;&nbsp; hw/i386/intel_iommu_internal.h |&nbsp; 8 +++++++-<br>
&gt; &gt;&nbsp;&nbsp; hw/i386/intel_iommu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; | 25 ++++++++++++++++---------<br>
&gt; &gt;&nbsp;&nbsp; 2 files changed, 23 insertions(+), 10 deletions(-)<br=
>
&gt; &gt;<br>
&gt; &gt; diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu=
_internal.h<br>
&gt; &gt; index f8cf99bddf..666e2cf2ce 100644<br>
&gt; &gt; --- a/hw/i386/intel_iommu_internal.h<br>
&gt; &gt; +++ b/hw/i386/intel_iommu_internal.h<br>
&gt; &gt; @@ -311,7 +311,13 @@ typedef enum VTDFaultReason {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 * request while disabled */<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VTD_FR_IR_SID_ERR =3D 0x26,&n=
bsp;&nbsp; /* Invalid Source-ID */<br>
&gt; &gt;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp; VTD_FR_PASID_TABLE_INV =3D 0x58,&nbsp; /*Inva=
lid PASID table entry */<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; /* PASID directory entry access failure */<br=
>
&gt; &gt; +&nbsp;&nbsp;&nbsp; VTD_FR_PASID_DIR_ACCESS_ERR =3D 0x50,<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; /* The Present(P) field of pasid directory en=
try is 0 */<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; VTD_FR_PASID_DIR_ENTRY_P =3D 0x51,<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; VTD_FR_PASID_TABLE_ACCESS_ERR =3D 0x58, /* PA=
SID table entry access failure */<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; VTD_FR_PASID_ENTRY_P =3D 0x59, /* The Present=
(P) field of pasidt-entry is 0 */<br>
&gt; s/pasidt/pasid<br>
<br>
Per spec, it is pasid table entry. So Zhenzhong may need to use the same wo=
rd<br>
With the line below. E.g. PASID Table entry.</div>
<div style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Regards,<br>
Yi Liu</div>
<div style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Ok fine</div>
<div style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
regards,</div>
<div style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
&gt;cmd</div>
<div style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; VTD_FR_PASID_TABLE_ENTRY_INV =3D 0x5b,&nbsp; =
/*Invalid PASID table entry */<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Output address in the inte=
rrupt address range for scalable mode */<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VTD_FR_SM_INTERRUPT_ADDR =3D =
0x87,<br>
&gt; &gt; diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c<br>
&gt; &gt; index cc8e59674e..0951ebb71d 100644<br>
&gt; &gt; --- a/hw/i386/intel_iommu.c<br>
&gt; &gt; +++ b/hw/i386/intel_iommu.c<br>
&gt; &gt; @@ -771,7 +771,7 @@ static int vtd_get_pdire_from_pdir_table(dma_=
addr_t<br>
&gt; pasid_dir_base,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr =3D pasid_dir_base + ind=
ex * entry_size;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dma_memory_read(&amp;addr=
ess_space_memory, addr,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pdire, entry_size, MEMTXATTRS_UNSPECIFIED)) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -VTD_FR_PASID_=
TABLE_INV;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -VTD_FR_PASID_=
DIR_ACCESS_ERR;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdire-&gt;val =3D le64_to_cpu=
(pdire-&gt;val);<br>
&gt; &gt; @@ -789,6 +789,7 @@ static int vtd_get_pe_in_pasid_leaf_table(Int=
elIOMMUState<br>
&gt; *s,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t addr,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VTDPASIDEntry *pe)<br>
&gt; &gt;&nbsp;&nbsp; {<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; uint8_t pgtt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t index;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t entry_size;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; X86IOMMUState *x86_iommu =3D =
X86_IOMMU_DEVICE(s);<br>
&gt; &gt; @@ -798,7 +799,7 @@ static int vtd_get_pe_in_pasid_leaf_table(Int=
elIOMMUState<br>
&gt; *s,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr =3D addr + index * entry=
_size;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dma_memory_read(&amp;addr=
ess_space_memory, addr,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pe, entry_size, MEMTXATTRS_UNSPECIFIED)) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -VTD_FR_PASID_=
TABLE_INV;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -VTD_FR_PASID_=
TABLE_ACCESS_ERR;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (size_t i =3D 0; i &lt; A=
RRAY_SIZE(pe-&gt;val); i++) {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pe-&g=
t;val[i] =3D le64_to_cpu(pe-&gt;val[i]);<br>
&gt; &gt; @@ -806,11 +807,13 @@ static int vtd_get_pe_in_pasid_leaf_table(I=
ntelIOMMUState<br>
&gt; *s,<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Do translation type check =
*/<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vtd_pe_type_check(x86_io=
mmu, pe)) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -VTD_FR_PASID_=
TABLE_INV;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -VTD_FR_PASID_=
TABLE_ENTRY_INV;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp; if (!vtd_is_level_supported(s, VTD_PE_GET_LEV=
EL(pe))) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -VTD_FR_PASID_=
TABLE_INV;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; pgtt =3D VTD_PE_GET_TYPE(pe);<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; if (pgtt =3D=3D VTD_SM_PASID_ENTRY_SLT &amp;&=
amp;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !vtd_is_level_support=
ed(s, VTD_PE_GET_LEVEL(pe))) {<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -VTD_FR_PASID_TABLE_ENTRY_INV;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; @@ -851,7 +854,7 @@ static int vtd_get_pe_from_pasid_table(IntelI=
OMMUState *s,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vtd_pdire_present(&amp;p=
dire)) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -VTD_FR_PASID_=
TABLE_INV;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -VTD_FR_PASID_=
DIR_ENTRY_P;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vtd_get_pe_from_pdire=
(s, pasid, &amp;pdire, pe);<br>
&gt; &gt; @@ -860,7 +863,7 @@ static int vtd_get_pe_from_pasid_table(IntelI=
OMMUState *s,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vtd_pe_present(pe)) {<br=
>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -VTD_FR_PASID_=
TABLE_INV;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -VTD_FR_PASID_=
ENTRY_P;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; @@ -913,7 +916,7 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUSta=
te *s,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vtd_pdire_present(&amp;p=
dire)) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -VTD_FR_PASID_=
TABLE_INV;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -VTD_FR_PASID_=
DIR_ENTRY_P;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; &gt; @@ -1770,7 +1773,11 @@ static const bool vtd_qualified_faults[] =
=3D {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [VTD_FR_ROOT_ENTRY_RSVD] =3D =
false,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [VTD_FR_PAGING_ENTRY_RSVD] =
=3D true,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [VTD_FR_CONTEXT_ENTRY_TT] =3D=
 true,<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp; [VTD_FR_PASID_TABLE_INV] =3D false,<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; [VTD_FR_PASID_DIR_ACCESS_ERR] =3D false,<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; [VTD_FR_PASID_DIR_ENTRY_P] =3D true,<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; [VTD_FR_PASID_TABLE_ACCESS_ERR] =3D false,<br=
>
&gt; &gt; +&nbsp;&nbsp;&nbsp; [VTD_FR_PASID_ENTRY_P] =3D true,<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; [VTD_FR_PASID_TABLE_ENTRY_INV] =3D true,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [VTD_FR_SM_INTERRUPT_ADDR] =
=3D true,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [VTD_FR_MAX] =3D false,<br>
&gt; &gt;&nbsp;&nbsp; };<br>
&gt; &gt; --<br>
&gt; &gt; 2.34.1<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; lgtm</div>
</div>
</body>
</html>

--_000_AM8PR07MB7602C1E7400DEE2E35AB4A5886E82AM8PR07MB7602eurp_--

