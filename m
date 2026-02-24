Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AE2EFB800
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vul6D-0001f2-Do; Tue, 24 Feb 2026 00:36:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul67-0001bn-Ty; Tue, 24 Feb 2026 00:36:41 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul64-0001H5-5F; Tue, 24 Feb 2026 00:36:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVAMJ3jFUaNwJQyaq5jbaGrXyMGU7LA8hccis04FzW3x81EE3n4QxTkmIMLDgRRH3cc8s5iFHY3E/cLcNWhzWObdSDVDpAY8CvxUkTwI/pBd/cKdLNE9hgDILk2ekjfv1vNR76XcP3sahdHz035iQ4DIlFMyGVKe/d/29abw6iWFT6TWDXVvSQYLz8tAAubwksVv+V4wVVfBRhCngOICoj6cU97Wsg9W64OhvBdRt8pC0zugOb5YndjQX62YiFgFhtAqMSBtcCPNamYVue3kJ7FYGhPP25W7HDaELA76aaFf4vzAZZPzjhgnO5cJ9JePK2OertwfyebaYugJXX7AXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AfGtPMk2GdcOR/dNWkYdXVyFTbKcXQekwWg2uyyeg0=;
 b=B5Vm3XOzBq0S1W6mACYaM7hnKKKLVuPQLWVGTv5pAT/SZVxMTkE8QHjz9wvTpV9+MGlpS12rxOj+Eu0dNiDlXnX/ETxtqXz/pcfrDLOAovqS+56zWqCQFvR8g6gPo4Jrb8n41tUUQ+pcoWCcrNyXei502/loMu14/ZVnM7DfCITzfdrqXcT0BeonQXV8Qhr3LAHWN03P7+gri1ifGaWpH+NfRBGGh2RSUUCNCk559nfCockoBEYnusROSAaLTUJ0A5YbkTIEJ8m5JoPJF7MbYNgls8liPIVvQK0qx4GiMDBj11oaOP6sra06Qm5JA+VcVaNd2EWbh6XsUGROpbPt6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AfGtPMk2GdcOR/dNWkYdXVyFTbKcXQekwWg2uyyeg0=;
 b=AhVGbBanGj4ZGYJm8JY5/RwNnikQKY/EqYaFhZE2GNkeFNzxK8rG3byJMt14BOblN3RUVyAWnRCTvOHg9L+0WMCVVIbECXffsiAQget1zrnwNLwtaxrNFTIAQbhOqgp6EuXhwPbVK0qGRjftltu94XOuMrftHYhrf/tAthnJdl3jcoASt5iM4tUr/5gTXe/PrUHYkTNE7Z549lZOfwCJ+8rVXTtz2aoFulHHAr6IpLrtnMkpgUwnPeICRQcS2GykcGfPE3jC7h9XhK1mmGl1aRcnycAiC7c0fUbK4oFhBmd1rXBtHf4BLJvDUQ+0dsS5+OjP4wMwbJkxxMn6FkO2wQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5179.apcprd06.prod.outlook.com (2603:1096:400:1f8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 05:36:22 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 05:36:22 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, Patrick
 Venture <venture@google.com>
Subject: [PATCH v6 05/22] hw/i3c/dw-i3c: Add more register fields
Thread-Topic: [PATCH v6 05/22] hw/i3c/dw-i3c: Add more register fields
Thread-Index: AQHcpU+CGIYWNTjWMky0jYVz5U/7bg==
Date: Tue, 24 Feb 2026 05:36:22 +0000
Message-ID: <20260224053613.589102-6-jamin_lin@aspeedtech.com>
References: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5179:EE_
x-ms-office365-filtering-correlation-id: 8cfc767c-86d2-4a4f-d258-08de7366a4f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?CeFZqbwMsyG1iJXlodNhyvXJTumlk14pDRuik39f8GVSC6EwF8jgoyl6cM?=
 =?iso-8859-1?Q?MOjW6XWVXu/PgBzHUjGLHIdN/8XOqvhADFxMIgOS8YlV5hwhdTfhT/FxwL?=
 =?iso-8859-1?Q?nzcotQr1hzuHmMlH1nz2ed/8REKXgAEk7Ej53RXL8KqHb4NaRouL5yG371?=
 =?iso-8859-1?Q?X7qiJjtQY3cQqkK9ZfiIPWqAhRdqrQ8nWcgOwYWYTlGKqeR/wl0/zH0f+B?=
 =?iso-8859-1?Q?En1wvLLTqWqeWg6llGwApYVymtngBGG56vCu/dshOUyOhTlvksi8qDeLTQ?=
 =?iso-8859-1?Q?Ow2oyhyS8BqT25fnVpynYWmAgOGVYxf93zCYjvo+3BoVsh8A01ap7x0gKF?=
 =?iso-8859-1?Q?DPrdJlHG8jhFyRPiqtKFXvLe3TZ81fd7wbITSU1QhHO/XuCrmuXou2qoMA?=
 =?iso-8859-1?Q?W103wOW6Y+dJyDOFkL2H8xrVk0GSXM/sc/XYDlyCQhvQTgOxx+xvL4Jjwa?=
 =?iso-8859-1?Q?xC1b8yESnE/im6U7REpgdx/FC2WPIMnY0SAa4zHKA7ssZJ4urWWdJ4vQy8?=
 =?iso-8859-1?Q?bPnlktxCsizRxKg0eh6xG1u3kiA1KjgN67+KzDDHwwlxOUqZBZrB+74kZ5?=
 =?iso-8859-1?Q?oerp3LJ6nOtye7VRbQBInZzh08ozPmCWpuxBLGxriw3lZUH0c+oOeioKdD?=
 =?iso-8859-1?Q?v1dvpThgdbn2n+LhF7Fo7Lm0IiLP9p/pn44Oskr1kb+wVuNNeHIUuCj3Ch?=
 =?iso-8859-1?Q?0NyT6r2Q9ES4cjQrvPpTrRUfUWzk1RnbgLu1IaDuiGJhzJiUqzSz8JVBOu?=
 =?iso-8859-1?Q?Hb3bnj5axC5Udzm87acN9z/8HPWN+aV9A0EqpqtghiqHoUz5JS3vBIEoba?=
 =?iso-8859-1?Q?GjYQqIcmaZPPMevorK5JT6q57Z7JtnAof5rhuwbmuiXt/2ZwklNjvYkoUo?=
 =?iso-8859-1?Q?oHmcRxOf1LhsTLzhXfpimkrPPs9vN4pWkSLOhyYulJlfJfOFCGwbRg/rh1?=
 =?iso-8859-1?Q?9Ld0JZWCvl94Jn/TW6unh0MO5hcRzaOl/8myeQh84urmfA6hKXV560pOQg?=
 =?iso-8859-1?Q?ZSvVimX1Zcu+TMNPvyW7o15BBoCaiVlEPmhgbDZial42QjFxI3b/wu8Q/Q?=
 =?iso-8859-1?Q?S0+jKV5qRbcZmbX4fnetS/hqzPSZkYQMi7r4vsIhnWOUHGf8RdMRQ7QO9d?=
 =?iso-8859-1?Q?ACtUmJmXrskJwG+mP2h77i1JdcmsQzzFE+ahLN33w4Wdi1pEgP66JdPaI5?=
 =?iso-8859-1?Q?Jwvhdy51njZ6UOZunEfcRMp2UrA9jBQVYG4CR1LmdVlTKfBTF1TjXFqE19?=
 =?iso-8859-1?Q?Qhlc80bdEvdWfeJXkk7Rvf2NN52mwhwmQdHXzK8HOy1r7u65Xhen1C9aor?=
 =?iso-8859-1?Q?eCYpKdBSIxPn0GaSM941rHQUQbC/wBiXzVVqKx/m/KuemFvOZu4cdGsZlW?=
 =?iso-8859-1?Q?dpHBhYk7OGjjO+eLGVsUK7evzFgU0QESOma2LOIlOxSuLepemAPsmIfXzD?=
 =?iso-8859-1?Q?P8C6S+wOKDv67Xg1TEV+yltSLXjFXkYwto4b0XrL3j/gbk4aXiTPpqwAxF?=
 =?iso-8859-1?Q?kZPpk8f77h90tftNceGtw+rgLl+CzIuK9PZO8gjGa00dHPo5Woxj5kdx0O?=
 =?iso-8859-1?Q?HH0EINCKYxjOZ527S6RciE147cimyUoUSJe0yYUuDbzEZ8kSJwHXEmUc5e?=
 =?iso-8859-1?Q?R94kvJjt7HrSjFj1trau3mvvdXd5g43d6i96aMxhGBGe7Hx6pnmS80wY6R?=
 =?iso-8859-1?Q?lXBgrPzPR/XthOOvW2menp0mefmb3u5Fk1rZA6xS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?B2MUA6h4ROS9li9TwlEZdzWHa4nd9c1I37VlP31nLbzdtZs+R1GvQnp1cP?=
 =?iso-8859-1?Q?I5z8vtDMGajTxxZztX8YgCI/UVnLZfdKKUfAfIe4TShdCCcxQI0foXYEAy?=
 =?iso-8859-1?Q?pmYL5yQ8+No7Qzh3AB8mdGtK+npju0PctCEl+r0vRcHYaiW1EqczMN9uEj?=
 =?iso-8859-1?Q?m5pci12vg0VeZIPvK/ar4N5/0IGSSkH6JfDFLtoMY2EsBhr7tFsDQOuFFa?=
 =?iso-8859-1?Q?ZCNnG8PMCTVEfXk3NGv5y+rd7ikArPd+FGCyP9hIMagu35ULdkL1LWUBpe?=
 =?iso-8859-1?Q?/gvTvYIpu+3zg2geHsj+cGDJ85gbR4XzFIwMXnY20DrcP0tdpMKI+2f/6G?=
 =?iso-8859-1?Q?nsvAj5tHZr9IiHvSlSdH6PQQ6jHzjbcG1RiHUL1PFP2zgu2bL+iNbu8wtL?=
 =?iso-8859-1?Q?Z9SMRc9aYANBhb3SSZgBLngGYaGo7vmBv9XqV0p/6tDZx97yWeGKmFG7T/?=
 =?iso-8859-1?Q?OjQl2aPNEjgvPGX33kMEg5g2VbF8hEdzRgvItecEm51DKuOtsuKx20Y8Y+?=
 =?iso-8859-1?Q?H53NGzIZywIDTlEOzMOKyW2aPtWbxwA6c5SVnfBtNQ8wcBwv0+E/IhzQFX?=
 =?iso-8859-1?Q?g6XjQ3nvtfceBLMGWnJ4wH8BK9dMSTDDvxdOcm+ecieAw+X8PuFdnp5Tat?=
 =?iso-8859-1?Q?O3dtRE9fq19d1CheXP5/xPNN4nC2g5+9M1QcSPOkYKFylNXCF4MVpX/KqR?=
 =?iso-8859-1?Q?OlxpGFHMczbASnTJUDUZfSnmjhI07x0emQhnvrChdm5IRoek0CNspGiPoB?=
 =?iso-8859-1?Q?lcZEUWue0EMsHvuIBOPVF4003G3yW2r2fHSc2kGXDuCr67SbrNsdDvG9BS?=
 =?iso-8859-1?Q?pp6Alj7X/djbo4yEtrNEu0mKj/zl2GrCSgOqHz+BuHK742pHc8V6FtaLpx?=
 =?iso-8859-1?Q?xm63oQSt2Ijtumb7eMBKIefNZFCaAqQZXN65RYwW0gDXgIJ3oUvTLzPGCs?=
 =?iso-8859-1?Q?XNalDMGNChCJh0/tcbAoYsODPt+GKQpe0eMsZCehZ3CCWn9J0Hm4CU64s/?=
 =?iso-8859-1?Q?1sY01kapeY/3nNzlsedIVlJWFc0cEi3tJuIYYmj3QlDLJVKdQfNBsbSGtH?=
 =?iso-8859-1?Q?E1ehwNOtZj5nx9QaqR53rQtp4SRuyB+Vbd2PuwzEddkp41ROTdJ6q321PZ?=
 =?iso-8859-1?Q?4cpjnX7yUV+Wsu2vkgzqCRcWKeCeegvb2V2C09qk7njNDzTWOX7WwR4tBa?=
 =?iso-8859-1?Q?xAdnBqyIa4kr9yMWrrsO9xAdAys+n44BGrkG3uHxIOx6MVb4Uszmcmvn7x?=
 =?iso-8859-1?Q?yF0bi91+qBLFkjiCN+SFNHSnb59Lz9i9dQ05JPTgpEd2YLNjZxKB+1rxUH?=
 =?iso-8859-1?Q?dEnKcoelN5zJFzNk1Q1A/1WBnlQGR5LaFMGkQWtez82od4e50Pi6UF9W8Y?=
 =?iso-8859-1?Q?enji9G3wLDCKoLFQYsFpY18LN+OLsrfn69+8WjgGnOk2wuTQCwlOzn1AS5?=
 =?iso-8859-1?Q?hS6q3lTaYeJ0l8RPPaM86KBWT3PPqBHSA7TFhxN+Ypsb+D+VsYN3DNriTb?=
 =?iso-8859-1?Q?Yczs1oTrpM4QsU+LBxWG8XOGJEWAOvZBdz0gpz91T0xZHMWYC5y6hiBj+Y?=
 =?iso-8859-1?Q?y3gSM3maOwcR+SNKTQPENAiQYwXxuwtIdJLRFIk4Ud+nExjo9xRU2Y+M6n?=
 =?iso-8859-1?Q?hGrNQxtOQHwl6E+aGV39/5+cdo378egBhGd9sybzIf0/UuApVB7WN7STAi?=
 =?iso-8859-1?Q?UDxiER3O1OhfQDJBUA3TZsaEJT+hJYYcz/e8yPfwfZzKKuj02LxtA20on5?=
 =?iso-8859-1?Q?PrShGp/IUelOn3gBUqE3lPoHJ/YQopVElIHI+J3zEXMb/oz//4BfN8HPul?=
 =?iso-8859-1?Q?g2Gi1piXnA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfc767c-86d2-4a4f-d258-08de7366a4f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 05:36:22.3582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pg9Mcdm02c8Jky5GP97h12H0wxj2L+pMtA5IdR+quCGmIew+mIlNzMTYJhzqNq6o7v9qwoUM7hCCRBdg5Fxj5Ph3C+0kxIawr8inYYM6J1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5179
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UPPERCASE_75_100=0.001 autolearn=no autolearn_force=no
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

Adds the rest of the Designware register fields.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 199 ++++++++++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 199 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 6cadc59191..48dde008de 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -19,54 +19,253 @@=0A=
 #include "trace.h"=0A=
 =0A=
 REG32(DEVICE_CTRL,                  0x00)=0A=
+    FIELD(DEVICE_CTRL, I3C_BROADCAST_ADDR_INC,    0, 1)=0A=
+    FIELD(DEVICE_CTRL, I2C_SLAVE_PRESENT,         7, 1)=0A=
+    FIELD(DEVICE_CTRL, HOT_JOIN_ACK_NACK_CTRL,    8, 1)=0A=
+    FIELD(DEVICE_CTRL, IDLE_CNT_MULTIPLIER,       24, 2)=0A=
+    FIELD(DEVICE_CTRL, SLV_ADAPT_TO_I2C_I3C_MODE, 27, 1)=0A=
+    FIELD(DEVICE_CTRL, DMA_HANDSHAKE_EN,          28, 1)=0A=
+    FIELD(DEVICE_CTRL, I3C_ABORT,                 29, 1)=0A=
+    FIELD(DEVICE_CTRL, I3C_RESUME,                30, 1)=0A=
+    FIELD(DEVICE_CTRL, I3C_EN,                    31, 1)=0A=
 REG32(DEVICE_ADDR,                  0x04)=0A=
+    FIELD(DEVICE_ADDR, STATIC_ADDR,         0, 7)=0A=
+    FIELD(DEVICE_ADDR, STATIC_ADDR_VALID,   15, 1)=0A=
+    FIELD(DEVICE_ADDR, DYNAMIC_ADDR,        16, 7)=0A=
+    FIELD(DEVICE_ADDR, DYNAMIC_ADDR_VALID,  31, 1)=0A=
 REG32(HW_CAPABILITY,                0x08)=0A=
+    FIELD(HW_CAPABILITY, DEVICE_ROLE_CONFIG,  0, 3)=0A=
+    FIELD(HW_CAPABILITY, HDR_DDR, 3, 1)=0A=
+    FIELD(HW_CAPABILITY, HDR_TS,  4, 1)=0A=
 REG32(COMMAND_QUEUE_PORT,           0x0c)=0A=
+    FIELD(COMMAND_QUEUE_PORT, CMD_ATTR, 0, 3)=0A=
+    /* Transfer command structure */=0A=
+    FIELD(COMMAND_QUEUE_PORT, TID, 3, 4)=0A=
+    FIELD(COMMAND_QUEUE_PORT, CMD, 7, 8)=0A=
+    FIELD(COMMAND_QUEUE_PORT, CP, 15, 1)=0A=
+    FIELD(COMMAND_QUEUE_PORT, DEV_INDEX, 16, 5)=0A=
+    FIELD(COMMAND_QUEUE_PORT, SPEED, 21, 3)=0A=
+    FIELD(COMMAND_QUEUE_PORT, ROC, 26, 1)=0A=
+    FIELD(COMMAND_QUEUE_PORT, SDAP, 27, 1)=0A=
+    FIELD(COMMAND_QUEUE_PORT, RNW, 28, 1)=0A=
+    FIELD(COMMAND_QUEUE_PORT, TOC, 30, 1)=0A=
+    FIELD(COMMAND_QUEUE_PORT, PEC, 31, 1)=0A=
+    /* Transfer argument data structure */=0A=
+    FIELD(COMMAND_QUEUE_PORT, DB, 8, 8)=0A=
+    FIELD(COMMAND_QUEUE_PORT, DL, 16, 16)=0A=
+    /* Short data argument data structure */=0A=
+    FIELD(COMMAND_QUEUE_PORT, BYTE_STRB, 3, 3)=0A=
+    FIELD(COMMAND_QUEUE_PORT, BYTE0, 8, 8)=0A=
+    FIELD(COMMAND_QUEUE_PORT, BYTE1, 16, 8)=0A=
+    FIELD(COMMAND_QUEUE_PORT, BYTE2, 24, 8)=0A=
+    /* Address assignment command structure */=0A=
+    /*=0A=
+     * bits 3..21 and 26..31 are the same as the transfer command structur=
e, or=0A=
+     * marked as reserved.=0A=
+     */=0A=
+    FIELD(COMMAND_QUEUE_PORT, DEV_COUNT, 21, 3)=0A=
 REG32(RESPONSE_QUEUE_PORT,          0x10)=0A=
+    FIELD(RESPONSE_QUEUE_PORT, DL, 0, 16)=0A=
+    FIELD(RESPONSE_QUEUE_PORT, CCCT, 16, 8)=0A=
+    FIELD(RESPONSE_QUEUE_PORT, TID, 24, 3)=0A=
+    FIELD(RESPONSE_QUEUE_PORT, ERR_STATUS, 28, 4)=0A=
 REG32(RX_TX_DATA_PORT,              0x14)=0A=
 REG32(IBI_QUEUE_STATUS,             0x18)=0A=
+    FIELD(IBI_QUEUE_STATUS, IBI_DATA_LEN,   0, 8)=0A=
+    FIELD(IBI_QUEUE_STATUS, IBI_ID,         8, 8)=0A=
+    FIELD(IBI_QUEUE_STATUS, LAST_STATUS,    24, 1)=0A=
+    FIELD(IBI_QUEUE_STATUS, ERROR,          30, 1)=0A=
+    FIELD(IBI_QUEUE_STATUS, IBI_STATUS,     31, 1)=0A=
 REG32(IBI_QUEUE_DATA,               0x18)=0A=
 REG32(QUEUE_THLD_CTRL,              0x1c)=0A=
+    FIELD(QUEUE_THLD_CTRL, CMD_BUF_EMPTY_THLD,  0, 8);=0A=
+    FIELD(QUEUE_THLD_CTRL, RESP_BUF_THLD, 8, 8);=0A=
+    FIELD(QUEUE_THLD_CTRL, IBI_DATA_THLD, 16, 5);=0A=
+    FIELD(QUEUE_THLD_CTRL, IBI_STATUS_THLD,     24, 8);=0A=
 REG32(DATA_BUFFER_THLD_CTRL,        0x20)=0A=
+    FIELD(DATA_BUFFER_THLD_CTRL, TX_BUF_THLD,   0, 3)=0A=
+    FIELD(DATA_BUFFER_THLD_CTRL, RX_BUF_THLD,   8, 3)=0A=
+    FIELD(DATA_BUFFER_THLD_CTRL, TX_START_THLD, 16, 3)=0A=
+    FIELD(DATA_BUFFER_THLD_CTRL, RX_START_THLD, 24, 3)=0A=
 REG32(IBI_QUEUE_CTRL,               0x24)=0A=
+    FIELD(IBI_QUEUE_CTRL, NOTIFY_REJECTED_HOT_JOIN,   0, 1)=0A=
+    FIELD(IBI_QUEUE_CTRL, NOTIFY_REJECTED_MASTER_REQ, 1, 1)=0A=
+    FIELD(IBI_QUEUE_CTRL, NOTIFY_REJECTED_SLAVE_IRQ,  3, 1)=0A=
 REG32(IBI_MR_REQ_REJECT,            0x2c)=0A=
 REG32(IBI_SIR_REQ_REJECT,           0x30)=0A=
 REG32(RESET_CTRL,                   0x34)=0A=
+    FIELD(RESET_CTRL, CORE_RESET,       0, 1)=0A=
+    FIELD(RESET_CTRL, CMD_QUEUE_RESET,  1, 1)=0A=
+    FIELD(RESET_CTRL, RESP_QUEUE_RESET, 2, 1)=0A=
+    FIELD(RESET_CTRL, TX_BUF_RESET,     3, 1)=0A=
+    FIELD(RESET_CTRL, RX_BUF_RESET,     4, 1)=0A=
+    FIELD(RESET_CTRL, IBI_QUEUE_RESET,  5, 1)=0A=
 REG32(SLV_EVENT_CTRL,               0x38)=0A=
+    FIELD(SLV_EVENT_CTRL, SLV_INTERRUPT,      0, 1)=0A=
+    FIELD(SLV_EVENT_CTRL, MASTER_INTERRUPT,   1, 1)=0A=
+    FIELD(SLV_EVENT_CTRL, HOT_JOIN_INTERRUPT, 3, 1)=0A=
+    FIELD(SLV_EVENT_CTRL, ACTIVITY_STATE,     4, 2)=0A=
+    FIELD(SLV_EVENT_CTRL, MRL_UPDATED,        6, 1)=0A=
+    FIELD(SLV_EVENT_CTRL, MWL_UPDATED,        7, 1)=0A=
 REG32(INTR_STATUS,                  0x3c)=0A=
+    FIELD(INTR_STATUS, TX_THLD,           0, 1)=0A=
+    FIELD(INTR_STATUS, RX_THLD,           1, 1)=0A=
+    FIELD(INTR_STATUS, IBI_THLD,          2, 1)=0A=
+    FIELD(INTR_STATUS, CMD_QUEUE_RDY,     3, 1)=0A=
+    FIELD(INTR_STATUS, RESP_RDY,          4, 1)=0A=
+    FIELD(INTR_STATUS, TRANSFER_ABORT,    5, 1)=0A=
+    FIELD(INTR_STATUS, CCC_UPDATED,       6, 1)=0A=
+    FIELD(INTR_STATUS, DYN_ADDR_ASSGN,    8, 1)=0A=
+    FIELD(INTR_STATUS, TRANSFER_ERR,      9, 1)=0A=
+    FIELD(INTR_STATUS, DEFSLV,            10, 1)=0A=
+    FIELD(INTR_STATUS, READ_REQ_RECV,     11, 1)=0A=
+    FIELD(INTR_STATUS, IBI_UPDATED,       12, 1)=0A=
+    FIELD(INTR_STATUS, BUSOWNER_UPDATED,  13, 1)=0A=
 REG32(INTR_STATUS_EN,               0x40)=0A=
+    FIELD(INTR_STATUS_EN, TX_THLD,          0, 1)=0A=
+    FIELD(INTR_STATUS_EN, RX_THLD,          1, 1)=0A=
+    FIELD(INTR_STATUS_EN, IBI_THLD,         2, 1)=0A=
+    FIELD(INTR_STATUS_EN, CMD_QUEUE_RDY,    3, 1)=0A=
+    FIELD(INTR_STATUS_EN, RESP_RDY,         4, 1)=0A=
+    FIELD(INTR_STATUS_EN, TRANSFER_ABORT,   5, 1)=0A=
+    FIELD(INTR_STATUS_EN, CCC_UPDATED,      6, 1)=0A=
+    FIELD(INTR_STATUS_EN, DYN_ADDR_ASSGN,   8, 1)=0A=
+    FIELD(INTR_STATUS_EN, TRANSFER_ERR,     9, 1)=0A=
+    FIELD(INTR_STATUS_EN, DEFSLV,           10, 1)=0A=
+    FIELD(INTR_STATUS_EN, READ_REQ_RECV,    11, 1)=0A=
+    FIELD(INTR_STATUS_EN, IBI_UPDATED,      12, 1)=0A=
+    FIELD(INTR_STATUS_EN, BUSOWNER_UPDATED, 13, 1)=0A=
 REG32(INTR_SIGNAL_EN,               0x44)=0A=
+    FIELD(INTR_SIGNAL_EN, TX_THLD,          0, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, RX_THLD,          1, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, IBI_THLD,         2, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, CMD_QUEUE_RDY,    3, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, RESP_RDY,         4, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, TRANSFER_ABORT,   5, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, CCC_UPDATED,      6, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, DYN_ADDR_ASSGN,   8, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, TRANSFER_ERR,     9, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, DEFSLV,           10, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, READ_REQ_RECV,    11, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, IBI_UPDATED,      12, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, BUSOWNER_UPDATED, 13, 1)=0A=
 REG32(INTR_FORCE,                   0x48)=0A=
+    FIELD(INTR_FORCE, TX_THLD,          0, 1)=0A=
+    FIELD(INTR_FORCE, RX_THLD,          1, 1)=0A=
+    FIELD(INTR_FORCE, IBI_THLD,         2, 1)=0A=
+    FIELD(INTR_FORCE, CMD_QUEUE_RDY,    3, 1)=0A=
+    FIELD(INTR_FORCE, RESP_RDY,         4, 1)=0A=
+    FIELD(INTR_FORCE, TRANSFER_ABORT,   5, 1)=0A=
+    FIELD(INTR_FORCE, CCC_UPDATED,      6, 1)=0A=
+    FIELD(INTR_FORCE, DYN_ADDR_ASSGN,   8, 1)=0A=
+    FIELD(INTR_FORCE, TRANSFER_ERR,     9, 1)=0A=
+    FIELD(INTR_FORCE, DEFSLV,           10, 1)=0A=
+    FIELD(INTR_FORCE, READ_REQ_RECV,    11, 1)=0A=
+    FIELD(INTR_FORCE, IBI_UPDATED,      12, 1)=0A=
+    FIELD(INTR_FORCE, BUSOWNER_UPDATED, 13, 1)=0A=
 REG32(QUEUE_STATUS_LEVEL,           0x4c)=0A=
+    FIELD(QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,  0, 8)=0A=
+    FIELD(QUEUE_STATUS_LEVEL, RESP_BUF_BLR,         8, 8)=0A=
+    FIELD(QUEUE_STATUS_LEVEL, IBI_BUF_BLR,          16, 8)=0A=
+    FIELD(QUEUE_STATUS_LEVEL, IBI_STATUS_CNT,       24, 5)=0A=
 REG32(DATA_BUFFER_STATUS_LEVEL,     0x50)=0A=
+    FIELD(DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC, 0, 8)=0A=
+    FIELD(DATA_BUFFER_STATUS_LEVEL, RX_BUF_BLR,       16, 8)=0A=
 REG32(PRESENT_STATE,                0x54)=0A=
+    FIELD(PRESENT_STATE, SCL_LINE_SIGNAL_LEVEL, 0, 1)=0A=
+    FIELD(PRESENT_STATE, SDA_LINE_SIGNAL_LEVEL, 1, 1)=0A=
+    FIELD(PRESENT_STATE, CURRENT_MASTER,        2, 1)=0A=
+    FIELD(PRESENT_STATE, CM_TFR_STATUS,         8, 6)=0A=
+    FIELD(PRESENT_STATE, CM_TFR_ST_STATUS,      16, 6)=0A=
+    FIELD(PRESENT_STATE, CMD_TID,               24, 4)=0A=
 REG32(CCC_DEVICE_STATUS,            0x58)=0A=
+    FIELD(CCC_DEVICE_STATUS, PENDING_INTR,      0, 4)=0A=
+    FIELD(CCC_DEVICE_STATUS, PROTOCOL_ERR,      5, 1)=0A=
+    FIELD(CCC_DEVICE_STATUS, ACTIVITY_MODE,     6, 2)=0A=
+    FIELD(CCC_DEVICE_STATUS, UNDER_ERR,         8, 1)=0A=
+    FIELD(CCC_DEVICE_STATUS, SLV_BUSY,          9, 1)=0A=
+    FIELD(CCC_DEVICE_STATUS, OVERFLOW_ERR,      10, 1)=0A=
+    FIELD(CCC_DEVICE_STATUS, DATA_NOT_READY,    11, 1)=0A=
+    FIELD(CCC_DEVICE_STATUS, BUFFER_NOT_AVAIL,  12, 1)=0A=
 REG32(DEVICE_ADDR_TABLE_POINTER,    0x5c)=0A=
     FIELD(DEVICE_ADDR_TABLE_POINTER, DEPTH, 16, 16)=0A=
     FIELD(DEVICE_ADDR_TABLE_POINTER, ADDR,  0,  16)=0A=
 REG32(DEV_CHAR_TABLE_POINTER,       0x60)=0A=
+    FIELD(DEV_CHAR_TABLE_POINTER, P_DEV_CHAR_TABLE_START_ADDR,  0, 12)=0A=
+    FIELD(DEV_CHAR_TABLE_POINTER, DEV_CHAR_TABLE_DEPTH,         12, 7)=0A=
+    FIELD(DEV_CHAR_TABLE_POINTER, PRESENT_DEV_CHAR_TABLE_INDEX, 19, 3)=0A=
 REG32(VENDOR_SPECIFIC_REG_POINTER,  0x6c)=0A=
+    FIELD(VENDOR_SPECIFIC_REG_POINTER, P_VENDOR_REG_START_ADDR, 0, 16)=0A=
 REG32(SLV_MIPI_PID_VALUE,           0x70)=0A=
 REG32(SLV_PID_VALUE,                0x74)=0A=
+    FIELD(SLV_PID_VALUE, SLV_PID_DCR, 0, 12)=0A=
+    FIELD(SLV_PID_VALUE, SLV_INST_ID, 12, 4)=0A=
+    FIELD(SLV_PID_VALUE, SLV_PART_ID, 16, 16)=0A=
 REG32(SLV_CHAR_CTRL,                0x78)=0A=
+    FIELD(SLV_CHAR_CTRL, BCR,     0, 8)=0A=
+    FIELD(SLV_CHAR_CTRL, DCR,     8, 8)=0A=
+    FIELD(SLV_CHAR_CTRL, HDR_CAP, 16, 8)=0A=
 REG32(SLV_MAX_LEN,                  0x7c)=0A=
+    FIELD(SLV_MAX_LEN, MWL, 0, 16)=0A=
+    FIELD(SLV_MAX_LEN, MRL, 16, 16)=0A=
 REG32(MAX_READ_TURNAROUND,          0x80)=0A=
 REG32(MAX_DATA_SPEED,               0x84)=0A=
 REG32(SLV_DEBUG_STATUS,             0x88)=0A=
 REG32(SLV_INTR_REQ,                 0x8c)=0A=
+    FIELD(SLV_INTR_REQ, SIR,          0, 1)=0A=
+    FIELD(SLV_INTR_REQ, SIR_CTRL,     1, 2)=0A=
+    FIELD(SLV_INTR_REQ, MIR,          3, 1)=0A=
+    FIELD(SLV_INTR_REQ, TS,           4, 1)=0A=
+    FIELD(SLV_INTR_REQ, IBI_STS,      8, 2)=0A=
+REG32(SLV_TSX_SYMBL_TIMING,         0x90)=0A=
+    FIELD(SLV_TSX_SYMBL_TIMING, SLV_TSX_SYMBL_CNT, 0, 6)=0A=
 REG32(DEVICE_CTRL_EXTENDED,         0xb0)=0A=
+    FIELD(DEVICE_CTRL_EXTENDED, MODE, 0, 2)=0A=
+    FIELD(DEVICE_CTRL_EXTENDED, REQMST_ACK_CTRL, 3, 1)=0A=
 REG32(SCL_I3C_OD_TIMING,            0xb4)=0A=
+    FIELD(SCL_I3C_OD_TIMING, I3C_OD_LCNT, 0, 8)=0A=
+    FIELD(SCL_I3C_OD_TIMING, I3C_OD_HCNT, 16, 8)=0A=
 REG32(SCL_I3C_PP_TIMING,            0xb8)=0A=
+    FIELD(SCL_I3C_PP_TIMING, I3C_PP_LCNT, 0, 8)=0A=
+    FIELD(SCL_I3C_PP_TIMING, I3C_PP_HCNT, 16, 8)=0A=
 REG32(SCL_I2C_FM_TIMING,            0xbc)=0A=
 REG32(SCL_I2C_FMP_TIMING,           0xc0)=0A=
+    FIELD(SCL_I2C_FMP_TIMING, I2C_FMP_LCNT, 0, 16)=0A=
+    FIELD(SCL_I2C_FMP_TIMING, I2C_FMP_HCNT, 16, 8)=0A=
 REG32(SCL_EXT_LCNT_TIMING,          0xc8)=0A=
 REG32(SCL_EXT_TERMN_LCNT_TIMING,    0xcc)=0A=
 REG32(BUS_FREE_TIMING,              0xd4)=0A=
 REG32(BUS_IDLE_TIMING,              0xd8)=0A=
+    FIELD(BUS_IDLE_TIMING, BUS_IDLE_TIME, 0, 20)=0A=
 REG32(I3C_VER_ID,                   0xe0)=0A=
 REG32(I3C_VER_TYPE,                 0xe4)=0A=
 REG32(EXTENDED_CAPABILITY,          0xe8)=0A=
 REG32(SLAVE_CONFIG,                 0xec)=0A=
+/* Device characteristic table fields */=0A=
+REG32(DEVICE_CHARACTERISTIC_TABLE_LOC1, 0x200)=0A=
+REG32(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, 0x200)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, DYNAMIC_ADDR, 0, 8)=
=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, DCR, 8, 8)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, BCR, 16, 8)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, STATIC_ADDR, 24, 8)=
=0A=
+REG32(DEVICE_CHARACTERISTIC_TABLE_LOC2, 0x204)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC2, MSB_PID, 0, 16)=0A=
+REG32(DEVICE_CHARACTERISTIC_TABLE_LOC3, 0x208)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC3, DCR, 0, 8)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC3, BCR, 8, 8)=0A=
+REG32(DEVICE_CHARACTERISTIC_TABLE_LOC4, 0x20c)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC4, DEV_DYNAMIC_ADDR, 0, 8)=0A=
+/* Dev addr table fields */=0A=
+REG32(DEVICE_ADDR_TABLE_LOC1, 0x280)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, DEV_STATIC_ADDR, 0, 7)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, IBI_PEC_EN, 11, 1)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, IBI_WITH_DATA, 12, 1)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, SIR_REJECT, 13, 1)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, MR_REJECT, 14, 1)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, DEV_DYNAMIC_ADDR, 16, 8)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, IBI_ADDR_MASK, 24, 2)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, DEV_NACK_RETRY_CNT, 29, 2)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, LEGACY_I2C_DEVICE, 31, 1)=0A=
 =0A=
 static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] =3D {=0A=
     [R_HW_CAPABILITY]               =3D 0x000e00bf,=0A=
-- =0A=
2.43.0=0A=

