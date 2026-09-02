Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9278C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 13:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1kaF-0000Pm-Eg; Wed, 02 Sep 2026 09:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1x1ka8-0000NY-UA
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 09:00:50 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1x1ka4-0003ou-6g
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 09:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1788354044; x=1819890044;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=eg1QH6ToaMYgXqb6ag5FDyj4xv+G6W+oYb1Zw7Kzkh0=;
 b=rE8prUvVWDSfTxpvaKEgrACDfLIaJ/1liT608HEHO4NCN/t9aqxHjRyo
 2l6vzT/ax5Qx/xR5N0Gd+GBR0qvmgVMM30S0P7/kjIN5EFYOIGhDn3uIW
 65ASutNaunzynrr5CiaR4XCOFhNeNVjd5Bq4Rk4jxM03dENDKijLrDW+7
 NXRooTF2kxpy+3MJbsRgAkD9Sr0Xtv/87zVLeo5QBnjvnJVcEnpmTmiS8
 PcJ6wS+l0iIb/ZbdtKSX6K5g1tkDlwevWdCs0B3llPzgJyVPQnuMTFTWw
 BmosEZplbr+FBzZFhSRSswR+aFxLLqRDSZQF0POBSXW+Md1mRzJmLc6o4 Q==;
X-CSE-ConnectionGUID: tX6ODGYiQ/K7Kst8PYMCLg==
X-CSE-MsgGUID: Bh3H9FDCQ+KTJqAlBgPRaQ==
IronPort-SDR: 6a981df4_Aopw2sLPmdYuVNUmedhmxj6asulPMhGV8tOwOXSXYmocdyy
 e5gBzQa8CB2TZte+L8rGH2gPyR3IAVSxcm62JHA==
X-IronPort-AV: E=Sophos;i="6.25,257,1779141600"; d="scan'208";a="48697757"
X-MGA-submission: =?us-ascii?q?MDEdLMg6aaSY3/hWG7+U4HK1Wyde3b8IpqOqhZ?=
 =?us-ascii?q?NHBDbUmPt2dJxIj/+QXSaw6lmbjmbL+4ANnHEeAMeRuNQ1WWLfrY14RF?=
 =?us-ascii?q?JW9mU9Y1/sQyzhivNNMbAVFcEZKbXi6qI8X5xtAUQQzi+zCVqwa8xLAP?=
 =?us-ascii?q?sA3NwQGsA1+72fFYRhWQ3K/Q=3D=3D?=
Received: from mail-northeuropeazon11010046.outbound.protection.outlook.com
 (HELO DB3PR0202CU003.outbound.protection.outlook.com) ([52.101.84.46])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 02 Sep 2026 15:00:36 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h107Aps+iDMzjfhukxmnci3l5fzqCEFYu7TDG016MGhBEt8vFFjSvnxegnRT9eExCgOn8wQNEVyi0pLk4Zx3fjB7/n3N8UOTg3dP147lRwwnc+Y548kqjMIh1m4ZIAcg1sAhsoISIba8YdmpeMho6VcKfLgYSF1NbQq6qO5IOAy9MPn7bZyKwU02XKpbC1tS8pNBjsIo2rxC5j2l/8zLT5ZMSPkNH6jI6Emy+TRaIqgay2y3Tnp/sRGCgfcyJi/BKvkHAqbNOEtFByQcbEtRcHQf0wT97Afpn6BnVX5t1a+JnUFvJ3AkFQTyjEd1SsLaR/dbDeE8OJUp8noO2ei+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eg1QH6ToaMYgXqb6ag5FDyj4xv+G6W+oYb1Zw7Kzkh0=;
 b=uYTQEcpJdk49YRYprLkGWUBS6WHx516ucMRzZdmyMSz1QMf2tm9FSahqJ48+TLW9SJej9RgmZavLEgvg2xM2U3SeNw706FA9Ju9IqBLe7hW4Pc2Eht3FUdpNBdGl2cOsyy0KYw+DFQHsLpNLUidGd4E6MfalNqwc/3g10Npb0DzcE/6YUw4anfJPKPbO0v8yzrXUiRryUIO7Zsm1dKWLPi9zo+evtuOIVdTT8RwWO2Jxmrf+kpGpXC+Doon5r55QUGvyQfvZrNASM87v+XX6/rrY5ItRTT3f4f1fn2s995Uv1P2O0K0Rnn4Qz9kiW6E0SPAPehZf07xhEuVHsY78fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU2PR07MB8377.eurprd07.prod.outlook.com (2603:10a6:10:2f0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:00:30 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 13:00:29 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>
Subject: Re: [PATCH v5 0/6] intel_iommu: Enable PRQ support for passthrough
 device
Thread-Topic: [PATCH v5 0/6] intel_iommu: Enable PRQ support for passthrough
 device
Thread-Index: AQHdOS5rntgjwlviyUuK6BPF3jbdsra7Q7KA
Date: Wed, 2 Sep 2026 13:00:29 +0000
Message-ID: <2abd85d5052a681cd7fa9ce1806874878cee56a5.camel@bull.com>
References: <20260831095200.1279366-1-zhenzhong.duan@intel.com>
In-Reply-To: <20260831095200.1279366-1-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU2PR07MB8377:EE_
x-ms-office365-filtering-correlation-id: 47beacb8-12f8-4f86-0600-08df08f22a96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|7416014|18002099003|6133799003|22082099003|13003099007|3023799007|38070700021|56012099006|10067099003|11063799006;
x-microsoft-antispam-message-info: mjDp/OkgPrZ3dvBNLZrE5aCDdtXLLy8WypQjZwCDYceQWD8o2ilNZGrFG/60GkeWXOpsBp1GTEVFRpcDmzoOb3iMRB6XGoEGGqgVUyA7d125SL5W3GHicZTm6eYNSPwZnxUG7Uc4X1favysCvt252HsXJ/wH6EC/A/E1kp/zstFeoiYxr3+fEno/XGVE95rRxNIhT5r6Flmggk/mlZKW9TZVfb2726mFDqxCQZJBGKNvIngAtJLK0lG3dF+7Ugg9jj3rXwe00/P56Bnm7+G7mYfByViZOnKZ5iRI+IO7usTIvdrWWsfkJyly8kR2QV/Llp9YaUWOBE69AMFHmi35NtZtwDdTLENbyROLT+bNWy1zrYBABzCrDfM7NabpgD8nBLGvcCA6+ONomzR3DwGwuX24r/HVpZ9djAlxdj7u4Si+bQEMV6npAD8ESQV5y65UWMMqm7OyXZSSWJhqYOkaRRi9tIFOZBe0FRJxJFXcGhe4YWPvL/ov/SCkXTysoZAN6eG8JOq0T+OKA/8NJDIz1Ff+f3k3r45ebDV3Ekii6DHbPMT3NMYaPD2h+ZJSa4GGf3MvK8Go6DW+Wv4xhWaUH0XCgbV9I7lTPRNHFcXzL+WNjBmj7J4eOdgLy5FWbFa+xa0pxJzOcyu8JswcNjhc8o1JZis6Qm+/ebqyOlvvOzRFlIAZ/5E0m4L7Qr7X+X7GGwWOtX+jOWmsG2nsJNUlqHtGPWzY4E7Vk79fh4bn80s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(18002099003)(6133799003)(22082099003)(13003099007)(3023799007)(38070700021)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekxLY3ZuQk1Xd2szeURhZER0M1d0VXE0OXZVRkJnZ3NuS21LVTNjUTBrVklI?=
 =?utf-8?B?UlpxbGZPK3Y3N0l6MjhueThqaW16Z3N4TEpBbkdkbE9xL0hjYkM0NGZVRUxD?=
 =?utf-8?B?clZMR3hTUGZoNnZaWmpReUZJMzdKdnczREk5QStNeE53Sjc5aU1VNGorSi91?=
 =?utf-8?B?a09yZFQyNU4vZzgwaDV0THRLTDRCQWNkMWpUZzRmclkvelV6bUdQcUsxWGNn?=
 =?utf-8?B?UWtrNzJUZ0NqSSsvSEZoWGVBRUVDTU9JcW51UkZFLzNZejN2REZjTk5ZZDhw?=
 =?utf-8?B?MlpyNlZLSW43ZWRmYlROWjAxTXF6Z3VIWXpNYjRSYWo1bm9DYm9rS3NtbUlq?=
 =?utf-8?B?alV0VTJSSzR2bGl6cFRPdHlFSGJ3UW8vRkRnRTlXNldpMVNRdEM2WDhhbkNr?=
 =?utf-8?B?RFNMdGswYmliQ25mRWJyZklrVDdFNTZPNlZabnNFNzFadDlBREw0N3AyQlU2?=
 =?utf-8?B?ZDVVRVNZSnFGSG9WenVTZDAxbVJXeDNBL0VvSWJUNkEwTklWVXF1eUFIQ2dQ?=
 =?utf-8?B?Q0MvYWtjZHJNaWpUWTJMblVqaTR4MWhDb09PMjdPRHBMREN4eis1c24vL0w0?=
 =?utf-8?B?eFNnL0IySkpMOHlVUUozQ085TWVWbXQ0QTdQdkFrbmsxcjVLL1ZCeHE3WG9v?=
 =?utf-8?B?TUN6ejEzRytlUXJaazlzczJ0alhNc2dzVWd2Smx0NzNnZXlvV3REbi96ZnJL?=
 =?utf-8?B?ZVZ1dEFTRWxaRGpDWStyR2Q4aHllNGtnSlpOYlUyWi9SMmRXYnp5WjIyUXlS?=
 =?utf-8?B?bmYwNEoyUkFwbUw0WjE4Q3Y3WC81YXFIN1V3K1dvMW8yQy9xQUhLamhISTZK?=
 =?utf-8?B?UVl1ZFM4UEtrRDB6WnNOZ1pZZUFTVXlqeDdBSG0vWmN3U0hUMndRN01oaEJJ?=
 =?utf-8?B?TGhvUGJNZnFYZXNxdjU1ZUtGWHplUmZHTi96Ynpab1Q3cGgrR2M3aHBFWWxr?=
 =?utf-8?B?YjFNSnJjazZ6bThaSVdKOHBMZ1pFSk1vQU5aOU5weWxXV1NkMXR5SmxESVMz?=
 =?utf-8?B?TitGVFRQZ0JtNUhqT2J5Y2RGd0V1YSttamxCaWxWZkNhWjFkMGZWMGhQWGEw?=
 =?utf-8?B?REdFbmlsMlN3YlU3K0liVW9SR1pXSTU3QnBKbnBVSndCNHBueENTbUlZNDJO?=
 =?utf-8?B?Wnc2dVU4R1hwMXBhRFR5OWFqN28xQW5kcVF3cEh1MjUvQURBLzhneFpOTTUz?=
 =?utf-8?B?MEt1dzRoTTBSdllMbHFDaFI4bmVMRFBBU1B3ZnJlNlZ6TWkrTkxObzl1b2xC?=
 =?utf-8?B?SEgybEIycDZlcFFpT2dqbEZic1VrQ1lERnJsbUtIZ2cxL0t1MzVzOGp3S1BB?=
 =?utf-8?B?bEN6NkhhanFYWERmcWFZdnZLV2xzeWI5UVQ5UENsdXg1RkYxWkYyVjBlUmRt?=
 =?utf-8?B?QTNhdTMyMHFicUl4cDJNSE43Uk8zMTFaY214SndTbzRxMHlEWGtHVk12VGx1?=
 =?utf-8?B?S1RLUStyYkkvdFU5LzRJSStVNHRtL0t1NEF5d2gzNFh1Q0hwZDg0ZjJJclBt?=
 =?utf-8?B?S1NCVDNDQ1F1WXJTSWRwb2lEOE9DaFQxYWoxMjE4aWR6dXRZaTRQb3NWaUtw?=
 =?utf-8?B?ZjBaU3VFemhUNzlBdk5aemx5L3hJamRMdkdDc0huekhGem5BeUYxaXBIenU0?=
 =?utf-8?B?aDRMUDRKTDlIRm9hdmZTOEdNQ01pNzFHWW9VZUl5Z00yUW9GN1NHbmszeHhO?=
 =?utf-8?B?N0NOMzQzU2xMZzR1K0VWK0ZJQ0NWRE9KalFpbytzVUpmMU5EciszSzU1ZUtP?=
 =?utf-8?B?RG5XY3dZbm9Qc2xUWG1GcWFnZG92TU1JT1ROWkxIWkdKZU8vY1JHa0h4aWlN?=
 =?utf-8?B?WU1uenF6OExOS0F2dlR6V2ZaKzl4RUtKdnp3a2dsUEcwZEVrNVNJa2tLTTho?=
 =?utf-8?B?bUVqZVAzc1F1a0JyOWF5NzJaaHl4RHFNbVI0cVZUcy9GMnZjSWJlRDYySVRZ?=
 =?utf-8?B?UmREQTErSHVoalVuSVQrQVdOOEhjRHUwM3dUWWo1bkZuZDc3RXVLclVuSXUy?=
 =?utf-8?B?V3I0eVJPbDlaZzdkOXk0YWhhZmZXaUZFYnZvNStaektRVTlqcmovM3hwRmc5?=
 =?utf-8?B?MEFnOWhtOTBsTktkemw3M1NMUktpQWVJMVgrc2hQdDVlZUtuYlVwNFZMeUVL?=
 =?utf-8?B?SzlXbGF1V0ZvYlhKSnI3b0xZL1Q3ZFRqQjArVGdNdkNOYUR3aTBsR1lmWUYr?=
 =?utf-8?B?Q1A4Q0hWS3dkN0lVT0czLzE1TlVYaStVRnJNUnpCbnJyUnNDaDVjZzJ2V1Yw?=
 =?utf-8?B?ZExKZGFWK0pvR010ZGVKQUJJS1MyenRXK0l3Y2NWSGZOeTAyV1J3bXFvS25k?=
 =?utf-8?B?Mi9abnVlYnpLalJBUEdvUUZZd1NvV3YxTGRDYi9DU0M4dHFhWDU2czJIL1VR?=
 =?utf-8?Q?d++HcnCbrLbMtW3MbDT3lTgKwjX1NPtNAOfAn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6399FF3F104D0B42A5B5149EC250651E@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: J/0cJ8k5JMya5KIeehMOnbbQUaeIxoe39DmqyNmc6Acr3Y3XjveLNQNctL0hs1g7HrHO6V003sIS/oMCi13wyAl2umJwV2TV8C0+46KSOdM6X68Zr4OBOk05BKsJJEXx6FKLxl8Ayl40fk9jZr7UvObN3aUKr3pz0Mw/elSJSoOdr6OcfUpkdJQjCaKiLF/4du7ldoU8XEX914c8k/PmOCiVoSWTyTp1wLgSGnm8b0D44uKLNcwE2t2jFz3MzCiNuXiqkeUoxwKjBJr0WJ0ZA2UKyfHCPUxcgvegewgcKSBxxjaqKerZLnUSG2HkeNEXljU43xJpYIph4FWobQl9+A==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47beacb8-12f8-4f86-0600-08df08f22a96
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 13:00:29.9273 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GEkLI7OB6dbkBb/bR/MbyxhQfanPdX7cG6Ln48pwzaUtaJ9EMWRvIF5Exvvem5olXd/7tOVjw/PjxQhHAun0577X9Mkdw7rkY9uhjOxOoso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8377
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost1.eviden.com
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

SGkgWmhlbnpob25nLA0KDQpUaGFua3MgZm9yIHRoZSByZXNwaW4sIEkgd2lsbCB0cnkgdG8gcmV2
aWV3IGl0IGJ5IHRoZSBlbmQgb2YgdGhlIHdlZWsuDQoNCkkgd2lsbCBhbHNvIHNlbmQgYSBwYXRj
aCBzb29uIHRvIG1ha2UgUFJJIHRocmVhZCBzYWZlLg0KDQpjbWQNCg0KT24gTW9uLCAyMDI2LTA4
LTMxIGF0IDE3OjUxICswODAwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4gQ2F1dGlvbjogRXh0
ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxl
c3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IEhpLA0KPiANCj4gV2hlbiBzdm09b24scGFzaWQt
Yml0cz1OLGZzdHM9b24gaXMgY29uZmlndXJlZCBmb3IgdmlydHVhbCB2dGQsIHdlIGVuYWJsZSAg
DQo+IGd1ZXN0J3Mgc3VwcG9ydCBmb3IgdlNWTS4gSW4gdGhpcyBjYXNlLCB0aGUgaG9zdCBWVEQg
bWF5IGdlbmVyYXRlICANCj4gcmVjb3ZlcmFibGUgZmlyc3Qgc3RhZ2UgcGFnZSBmYXVsdCBldmVu
dCwgUUVNVSByZWFkIHRoZSBldmVudCBhbmQgaW5qZWN0ICANCj4gaXQgdG8gZ3Vlc3QuDQo+IA0K
PiBBZnRlciBndWVzdCBoYW5kbGVzIHRoZSBldmVudCwgaXQgc2VuZHMgYSBwYWdlIGdyb3VwIHJl
c3BvbnNlLCBRRU1VIGdldHMgIA0KPiB0aGUgcmVzcG9uc2UgYW5kIHBhc3MgaXQgdG8gaG9zdCBW
VEQuDQo+IA0KPiBUaGlzIHNlcmllcyBhZGRzIFFFTVUgc3VwcG9ydCBmb3IgcmVjZWl2aW5nIHN1
Y2ggaG9zdCBldmVudHMgdGhyb3VnaCB0aGUgIA0KPiBGQVVMVFEgaW50ZXJmYWNlIGFuZCBwcm9w
YWdhdGluZyB0aGVtIHRvIHRoZSBndWVzdCwgdGhlbiBjYXRjaGluZyBndWVzdCdzICANCj4gcmVz
cG9uc2VzIGFuZCBwcm9wYWdhdGluZyB0aGVtIHRvIGhvc3QuDQo+IA0KPiBHSVQgYnJhbmNoOiBb
aHR0cHM6Ly9naXRodWIuY29tL3lpbGl1MTc2NS9xZW11L3RyZWUvemhlbnpob25nL2lvbW11ZmRf
cHJxLnY1XShodHRwczovL2dpdGh1Yi5jb20veWlsaXUxNzY1L3FlbXUvdHJlZS96aGVuemhvbmcv
aW9tbXVmZF9wcnEudjUpDQo+IA0KPiBUZXN0czogIA0KPiBUZXN0ZWQgd2l0aCBEU0Egd3EgYXR0
YWNoZWQgdG8gYW4gdXNlciBBUFAgd2hpY2ggdHJpZ2dlcnMgSU8gcGFnZSBmYXVsdCBvbiAgDQo+
IHByb2Nlc3MgcGFnZSB0YWJsZSBkdXJnaW5nIERNQS4gIA0KPiBCdWlsZCB0ZXN0IHdpdGggd2lu
ZG93IGNyb3NzLWJ1aWxkLg0KPiANCj4gVGhhbmtzICANCj4gWmhlbnpob25nDQo+IA0KPiBDaGFu
Z2Vsb2c6ICANCj4gdjU6ICANCj4gLSBhZGQgY29tbWVudCAiQWNjZXB0IHRoZSBQQ0kgUEFTSUQg
YXMgaW5wdXQiIHRvIGRvY3N0cmluZyBvZiBmdW5jdGlvbiB2dGRfcHJpX3JlcXVlc3RfcGFnZSAo
Q2xlbWVudCkgIA0KPiAtIGNoYW5nZSB2dGRfcHJxX3JlcG9ydF9mYXVsdCgpIHBhcmFtZXRlciB0
eXBlICJpbnQgY250IiAtPiAidW5zaWduZWQgY250IiAoQ2xlbWVudCkgIA0KPiAtIGNoZWNrIHJl
dHVybiB2YWx1ZSBvZiB2dGRfcHJpX3JlcXVlc3RfcGFnZSgpIGFuZCBzZW5kIHJlc3BvbnNlIChD
bGVtZW50KSAgDQo+IC0gZnJlZSBhbGwgdnRkX3BycV9saXN0IGVudHJpZXMgd2hlbiBkZXRhY2hp
bmcgKENsZW1lbnQpDQo+IA0KPiB2NDogIA0KPiAtIGFkZCB0aGUgY29tbWVudCB0byB0aGUgZG9j
c3RyaW5nIG9mIHRoZSBmdW5jdGlvbiB2dGRfcHJxX3JlcG9ydF9mYXVsdCBpdHNlbGYgKENsZW1l
bnQpICANCj4gLSBhZGQgIm91dF8iIHByZWZpeCBmb3IgZmF1bHRfaWQgJiBmYXVsdF9mZCBvdXRw
dXQgcGFyYW1ldGVyIChDbGVtZW50KQ0KPiANCj4gdjM6ICANCj4gLSBjb252ZXJ0IHRvIFBDSSBw
YXNpZCBiZWZvcmUgcGFzc2luZyB0byB2dGRfcHJpX3JlcXVlc3RfcGFnZSAoQ2xlbWVudCkgIA0K
PiAtIGV4cG9zZSB2dGRfcHJpX3JlcXVlc3RfcGFnZSBhbmQgZHJvcCBhY2NlbF9vcHMgcG9pbnRl
ciAoQ2xlbWVudCkgIA0KPiAtIGFkZCBhIGNsZWFudXAgcGF0Y2ggImludGVsX2lvbW11X2FjY2Vs
OiBHdWFyZCBWVERBY2NlbFBBU0lEQ2FjaGVFbnRyeSBkZWZpbml0aW9uIiAoUGhpbGlwcGUpDQo+
IA0KPiB2MjogIA0KPiAtIGRlZmluZSBmYXVsdF9mZCBpbnQgdHlwZSAoTGl1eWkpICANCj4gLSB1
cGRhdGUgY29tbWVudHMgb24gRkFVTFRRX0JVRl9TSVpFIChMaXV5aSkgIA0KPiAtIGRyb3AgcGFy
YW0gdnRkX2hpb2QgaW4gdnRkX2Rlc3Ryb3lfb2xkX2ZzX2ZhdWx0cSgpIChMaXV5aSkgIA0KPiAt
IHMvdnRkX3Byb3BhZ2F0ZV9wYWdlX2dyb3VwX3Jlc3BvbnNlX2FjY2VsL3Z0ZF9hY2NlbF9wcm9w
YWdhdGVfcGFnZV9ncm91cF9yZXNwb25zZSAoTGl1eWkpICANCj4gLSBjYWxsIHZ0ZF9wcnFfcmVz
cG9uc2Vfbm90aWZ5KCkgZGlyZWN0bHkgaW5zdGVhZCBvZiB0aHJvdWdoIHByaV9ub3RpZmllciAo
TGl1eWkpICANCj4gLSByZXBsYWNlICJmYXVsdF9pZCAhPSAwIiBjaGVjayB3aXRoICJmYXVsdF9m
ZCA8IDAiIGNoZWNrIChMaXV5aSkNCj4gDQo+IA0KPiBaaGVuemhvbmcgRHVhbiAoNik6ICANCj4g
wqAgaW50ZWxfaW9tbXVfYWNjZWw6IEd1YXJkIFZUREFjY2VsUEFTSURDYWNoZUVudHJ5IGRlZmlu
aXRpb24gIA0KPiDCoCBiYWNrZW5kcy9pb21tdWZkOiBJbnRyb2R1Y2UgaW9tbXVmZF9iYWNrZW5k
X2FsbG9jX2ZhdWx0cSAgDQo+IMKgIGJhY2tlbmRzL2lvbW11ZmQ6IEV4dGVuZCBpb21tdWZkX2Jh
Y2tlbmRfYWxsb2NfaHdwdCgpIHdpdGggZmF1bHRfaWQgIA0KPiDCoCBpbnRlbF9pb21tdV9hY2Nl
bDogQWRkIFBSUSBpbmplY3Rpb24gZm9yIHBhc3N0aHJvdWdoIGRldmljZSAgDQo+IMKgIGludGVs
X2lvbW11X2FjY2VsOiBBY2NlcHQgUFJRIHJlc3BvbnNlIGZvciBwYXNzdGhyb3VnaCBkZXZpY2Ug
IA0KPiDCoCBpbnRlbF9pb21tdV9hY2NlbDogdGVhcmRvd24gRkFVTFRRIHJlc291cmNlcyBpbiBi
b3R0b20gaGFsZg0KPiANCj4gwqBody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmjCoMKgwqAgfMKg
IDE2ICstICANCj4gwqBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfMKgwqAgMyArICAN
Cj4gwqBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaMKgIHzCoMKgIDYgKyAgDQo+IMKgaW5j
bHVkZS9zeXN0ZW0vaW9tbXVmZC5owqDCoMKgwqDCoMKgIHzCoMKgIDcgKy0gIA0KPiDCoGJhY2tl
bmRzL2lvbW11ZmQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMjggKysrLSAgDQo+IMKg
aHcvYXJtL3NtbXV2My1hY2NlbC5jwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDYgKy0gIA0KPiDC
oGh3L2kzODYvaW50ZWxfaW9tbXUuY8KgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMTMgKy0gIA0KPiDC
oGh3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuY8KgwqDCoCB8IDI3OCArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0gIA0KPiDCoGh3L3ZmaW8vaW9tbXVmZC5jwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgwqAgMiArLSAgDQo+IMKgYmFja2VuZHMvdHJhY2UtZXZlbnRzwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoMKgIDMgKy0gIA0KPiDCoGh3L2kzODYvdHJhY2UtZXZlbnRzwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgwqAgMiArICANCj4gwqAxMSBmaWxlcyBjaGFuZ2VkLCAzNDIgaW5z
ZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pDQo+IA0KPiAtLSAgDQo+IDIuNTIuMA0KPiA=

