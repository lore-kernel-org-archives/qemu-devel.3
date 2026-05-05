Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830EFCD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 13:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKG9t-0007cw-M4; Tue, 05 May 2026 09:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wKG9r-0007cT-1U; Tue, 05 May 2026 09:49:55 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wKG9p-0007VI-1g; Tue, 05 May 2026 09:49:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jiq/wonAOJetecjU8MKyGUq1GuwREI6zWokJ0BM5oH+qUzpTVKPuyFCAcJ72Iq3Map6IJFBbLnOotEW5HCwPwj293hwjZ8PDh4XmPWbwMc3r1EVH1tZL567DyNxV5ioFGQXDDEz4XS11mXEly40mpbWXCL7ZoG306iKI39hlBvJALhAv2HgWo0tWLOI7GsgVVsQRmGjpP7JUDmWGJDdoe223KCMtok+UcJv6ZZK230PdGeG/UIpOg82U71cTM3IB/XoTylfspQfjMGigSt6DNS0tVGHhhPDETl2FUFJHFllnDlnau1GZELfTSy7F746W4rHrvywOkPyEFJ9uZ5kmtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzOFCeHpz8vYaY9TC4SW2MFvIzzj0Ur5cnEN+gnAv/E=;
 b=pbcqjkmoHI0yBL1OI6Mo1+K+UqH+hwOk5Rb+CZ334evfyU7svaOEot9J4aJAuK8OKoUCFZrnhMho701Fsl/AzvAdaSP1RMh0VLVWdEM6PFcGKLY23wVT5rUITqzDvMHtfE6AWN0dcNEPRdSXsfvqu7x14Uj5dszIVjqcw0Dz7bIvIGfvoSuV/nJAq5DYryft0er526Iz+Zf5UKBzIzK2AZvPKSD0TuQYOhkXhtfbBeqEg70lH0v/KHfBUNY+XD1LsoiknllVpxttVeelaRcAgZ2Lj1JthR3PEkBAPtpTM77i3QY8XDtS1dcjKmZI3ZQprFjg9YEFgBx397mjgn8Z4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzOFCeHpz8vYaY9TC4SW2MFvIzzj0Ur5cnEN+gnAv/E=;
 b=rgmHCdnJXIadn9xPrXwrD9w8fcFRWJKndpp6nvp4kt3vqr+qmpeWAg0NzPbMsvCWEiAg+9qQ2S91ZBw2xuFxDdEO3XmdQYyBkWhkxZSvgTu8N5Z9TXENOU4baaDIhQsKA0qN1Yk/WoI7Yc2YKcVZdywonJL/WmEUNVDhpvG9rEh08FqdCPAGqULeHtTcA+YfgIJzoFnwmyGyRlqz8hr/1O5dIjRFmQeoBQVrb0DVVhEah5NbwY7hot+RcymXj2jubKdOkC65sRHAhjbvdbG2QBeeCXMHypcvCJKY0/Gzlb+qYQDRgR0neAVnSU5Kd5cA9v0HT7fnojr4CFK9k+C4PQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BN7PPFD91879A44.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Tue, 5 May
 2026 13:49:45 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 13:49:45 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>,
 "phrdina@redhat.com" <phrdina@redhat.com>
Subject: RE: [PATCH v4 16/31] hw/arm/tegra241-cmdqv: Emulate VCMDQ register
 writes
Thread-Topic: [PATCH v4 16/31] hw/arm/tegra241-cmdqv: Emulate VCMDQ register
 writes
Thread-Index: AQHczMa2FmOcjS77tkaQEDo91xKCpLX/XlOAgAAzyoA=
Date: Tue, 5 May 2026 13:49:45 +0000
Message-ID: <CH3PR12MB7548E9F5656F1338F77BAACEAB3E2@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-17-skolothumtho@nvidia.com>
 <abd9298d-1c3c-4f0c-8aab-ca03edb6b230@redhat.com>
In-Reply-To: <abd9298d-1c3c-4f0c-8aab-ca03edb6b230@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|BN7PPFD91879A44:EE_
x-ms-office365-filtering-correlation-id: 0077de2d-c208-4d5b-5b50-08deaaad2a6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: XN4OlSkFJU7xVgrjPvkUCvEcaFay/tpOpRpJqAli/3ua/m2sw+EshuALTCnHD2aBh+2aFnNHeJBFFyp+C8duVz/GFNbQiT6zu3h2Gk/xpqQuSdekYJp6bFMWpGTmJyKfi4ZVuMUHEIuiNkZ2Gks2WqWGIK8Fjet561aAaftNfr58DvsCPDFdjUfN77Tx2tDdNNIY1xGy6Hrp1uJ063HqgAR3+4rz9rWZqjO59rtfcAXuy+aL8jes/HvD7WY8ocG/LprYoLh8LM9tCsq5Mko9Zxzte3XQAYrlr7V5297CXSSeLB23TR/+6SkE1/ldrSYoSOql9cAfjXlkaY7h8dzvPd4ysz1WJoS/DrqaeVyiJ9YLwuwHns79M363dO5EIeQ8gxSrzUcWV0iNFH4tOqv3xuFssdSZoNr0tF7ehxqu2/BczcNBWBmnjKv0LYtcBxCIYu9l/7U2GfgceQJ8+4bnZPhwNP73JqYzWL0oy8o3AhZ13R7ruvfuuS1E8ZOoYz+fMkQQXiF9JR5aAelig+DflEMUIRutnfCIDLfK89B7HFNdwiCLAQ3LKdtXHbxqkWJLReIn+Klf35CJXtmQ/kBMynCxhTrM2S08bSJSKaoFq2JGZY7FQ0BJI1/RxcGKB6MjtP/1joGefUE5TYhgAfIw0MtWfn3F0DDvR9ZSIvDRIpZoo9ZWjCi629qTfvjDXU8Z0KYDY+6WkuyylsyGCQFTiKwyADjxi4G7rwRMuAYs0qnNYoI4V5d+3l/wHdz9uNEk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmEyQUZSTXpmOFlpZHVGRXlJQWd6dnpyWWZvSGFKL2YrWDlaWkFpbnhZWEdz?=
 =?utf-8?B?bnZSRytxR2NhNysrVGxGUWkvVTIzM2U4RHJwVzJtb2xLeHI3VWs3Ly85TDUx?=
 =?utf-8?B?cmgzSnZMdjlPa3FuaThsaXlaTkg1RUhBcEd6WGFTUExUdHN5YmN1NnZVLzZa?=
 =?utf-8?B?bS80MWQ5MWU3aTUzMjFvZU9MQU1KY3B4aEcvWGhnOU5PcEU1NzliTWFhWGFk?=
 =?utf-8?B?NzV4MFVoMFYwbDU5RVBPV0Z3V2hzNnp2b3BqZkR1T0luQnZJS3U1WE1uRFRt?=
 =?utf-8?B?Yk8vUHJBT08vRG5zcFBFSGVTT1gvWDVrY0ZMc3RtYWxXUWJMMjJpMHdid09T?=
 =?utf-8?B?aFFxalE1QVprZlNOTXVQVEcxUTkvb1B4QjJ5SDlkcjk2NGpVQWMzQnlFNW9l?=
 =?utf-8?B?ZjBNSFlWTE5hbXFaenhkV2IrY2xoQXM3U0hHOWEraWJrUlpjQ256aVFRd0M4?=
 =?utf-8?B?dXl5SXJ4bHVoSHZydXJQTGs1aDJkNkVWYUxySzQxcEdsbHhTa1BHL1J6SGRn?=
 =?utf-8?B?WDlYM1dyNUUydS9QZ24wUnphVkF3NWxnODR3QURmN2JOdGJxMVdiUGRHbE9M?=
 =?utf-8?B?b01IbVE1T3g4bEpoVTlNVnc1WlM3VVZaNEVpTjdnUkxaNFRLVXZrbmlScVZE?=
 =?utf-8?B?aWMxMUxxMWZPTmtyZGR6aUlSeFoxVlFqRHZnQWJ1R0I1MHNwVXNEZ1hBanpj?=
 =?utf-8?B?SU5vSlhGU2dsdTQ4cDZmWmU1eXRGNHJKaHN1bzYvdEVJM09yc3pQTUpVaUQ2?=
 =?utf-8?B?OWZTR24vaWJSQnhqVmtFS1N1NUNLMlVmblhuRUQwV1dPR1RXelZpRXdpVnJ2?=
 =?utf-8?B?WUc3Vy9FcnNlQ2M0bVJjU013WkNmOVJrQWs4NmZwZ0dIZUNzOE54eGNkZ0JC?=
 =?utf-8?B?QmVQZXZBdmV2MHVIclA0YU96aVo0cVF5RjEzS1FXeFZjQjRsbXhGVFo0cnlv?=
 =?utf-8?B?b2ViengzTWM0bHp3enlYVXc2NTV2TjdldHBnOXhycG9ubkIxVXEzT3Nsbmpt?=
 =?utf-8?B?a0h5RXkyeWZQTGZPbnNvQlRQVnF6cVJVbzZsV3B2b1R5L2NEZkhMSWZRamZV?=
 =?utf-8?B?RXc3UWlQTFZHbm40UmZKY3REOUxWWVZEWUlDdVhreXM4UWpMcHB0WTUvMklU?=
 =?utf-8?B?L29XMUxkNktnSEZYNXE4ZnZrR3N6L043TXRLV0V0a21PSnFicWlsN0tBQ3BC?=
 =?utf-8?B?aDQ4SGFqeCtocGRkdUdzU2xjT1J0UHFDQmtqNHBKMmNTNi9QYlFRdTBtK2M1?=
 =?utf-8?B?bk42bVg4RjZhQ2V2M2E5VHEyMGZJUGVNd2w1TVJwM20wK1g0YWhBaHJUZ1R0?=
 =?utf-8?B?ZG53azFIU29neThZK2hMZGJoZ1BPcjVqZkR5UGJvVmpMTnFpTW96SmJCSmdI?=
 =?utf-8?B?Q2FuUjMwbWlmeVVKT0VRZ1NmZG5TZHF6eXhDV3NpTTlPcEtaOHRCdFArNVdj?=
 =?utf-8?B?YVFmdGtEU2VqeWJETldtbTV5OVZXdTJFajF3NHdwczBvRDZmZk9iSlJQeDdK?=
 =?utf-8?B?WHExMFkzOWdEY0xvTFprUXRIYlhnRGY0QklYdmpRbHE2TnVCTi9mT0ZqVm1h?=
 =?utf-8?B?WExrTkdhZy80MTZLcDJ4RFllMzU0SzFmeHdjTVBCZE9GVDAvTEdKTXJnbk5t?=
 =?utf-8?B?aE9IaHN3NWlka3p5ZkphNzA2ekRoMXhESytzeGNCY1lVcmQ4MFhXbnNHUEVN?=
 =?utf-8?B?RXRWdlowU0J4M1B6T3JDS3ZLcnZLZmJ6Y3Z1TlcwK29ibTFneWhERk0rKzh4?=
 =?utf-8?B?eVZXNGx0em5saExCaUJxenF5VFdHd0ZoV0JMTWFBOUFadlJCQ25YV0krbHFQ?=
 =?utf-8?B?ekRBeS82T2k3d1gyRTdsZHBHSWVEMzd5cDJpRnhwUzZWN2hJOFBWRXE1eFVZ?=
 =?utf-8?B?b3kzUjBicXZkM2RIZW5YcU92dEZLTFN4ZHhLbzRGNGJjamozUFJ2dUUvUDh4?=
 =?utf-8?B?aW91TklmblV3K1Y0b2tYS1lQb1JxdWtObllxYzJ3YWQrRGpwQUJvb2QvZ3Mr?=
 =?utf-8?B?YVZHbkVHRUUvVE42NHZlb3QrMFFhczBHS1J3WStRaTA4S1dQRFdiaHh3T1M0?=
 =?utf-8?B?Z0tvdUlueFJaY2FkTUIxaVZHREF2aW5KVDJEUnJCbVlOOVg2dVJFOGY3cUlH?=
 =?utf-8?B?dTBkT1JHQ1BWYVhIL0h0NVNkc3owVDQ1eEM5b1RNUXVTeVo3YjhTdTJKaHZN?=
 =?utf-8?B?eFpHRjlYVC9BY1V3eDR3MmVoR1pzV3NSeTZxbG1xZkdOaEdJQjVTYlZ3SHBz?=
 =?utf-8?B?ZzdNNlMxMk8vZy9YVXNRajFPcVJsKzRRZ3JPSStKYmNOclM4NExLcW9IQ2hU?=
 =?utf-8?B?U1VZUjNiS0QxM0VEeTJyTmVnbnNtdFZDNDN3emk4R0Zab21aamcydz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0077de2d-c208-4d5b-5b50-08deaaad2a6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 13:49:45.0520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2KyRlGjt0uTDme2GvN7TUGp6B1/ACNhJYEno8k1lPDoHcDXOaaWtzvENumeUVkVaABWgcqY2Ymt8P1YJkGv28w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFD91879A44
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwNSBNYXkgMjAyNiAxMTo0Mw0KPiBUbzogU2hh
bWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11LQ0KPiBh
cm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxs
QGxpbmFyby5vcmc7IGNsZ0ByZWRoYXQuY29tOyBhbGV4QHNoYXpib3Qub3JnOyBOaWNvbGluDQo+
IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEu
Y29tPjsgTWF0dA0KPiBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsgSmlhbmRpIEFuIDxqYW5AbnZp
ZGlhLmNvbT47IEphc29uIEd1bnRob3JwZQ0KPiA8amdnQG52aWRpYS5jb20+OyBqb25hdGhhbi5j
YW1lcm9uQGh1YXdlaS5jb207DQo+IHpoZW56aG9uZy5kdWFuQGludGVsLmNvbTsgS3Jpc2huYWth
bnQgSmFqdSA8a2phanVAbnZpZGlhLmNvbT47DQo+IHBocmRpbmFAcmVkaGF0LmNvbQ0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHY0IDE2LzMxXSBody9hcm0vdGVncmEyNDEtY21kcXY6IEVtdWxhdGUg
VkNNRFENCj4gcmVnaXN0ZXIgd3JpdGVzDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRp
b24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IEhpLA0KPiBPbiA0LzE1
LzI2IDEyOjU1IFBNLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+IEZyb206IE5pY29saW4g
Q2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gPg0KPiA+IFRoaXMgaXMgdGhlIHdyaXRlIHNp
ZGUgY291bnRlcnBhcnQgb2YgdGhlIFZDTURRIHJlYWQgZW11bGF0aW9uLiBBZGQNCj4gPiB3cml0
ZSBoYW5kbGluZyBmb3IgYm90aCBDTURRVl9DTURRX0JBU0UgYW5kIENNRFFWX1ZJX0NNRFFfQkFT
RQ0KPiA+IGFwZXJ0dXJlcyB1c2luZyB0aGUgc2FtZSBpbmRleCBkZWNvZGluZyBhbmQgVklOVEYt
dG8tVkNNRFEgdHJhbnNsYXRpb24NCj4gPiBsb2dpYyBhcyB0aGUgcmVhZCBwYXRoLg0KPiA+DQo+
ID4gVklOVEYgYXBlcnR1cmUgd3JpdGVzIGFyZSB0cmFuc2xhdGVkIHRvIHRoZWlyIENNRFFWX0NN
RFFfQkFTRQ0KPiA+IGVxdWl2YWxlbnQgYW5kIHVwZGF0ZSB0aGUgc2FtZSBjYWNoZWQgc3RhdGUu
IFBhZ2UxIHJlZ2lzdGVycyAoQkFTRSwNCj4gPiBDT05TX0lORFhfQkFTRSkgYWx3YXlzIHVwZGF0
ZSB0aGUgY2FjaGUuIE9uY2UNCj4gSU9NTVVfSFdfUVVFVUVfQUxMT0MgYW5kDQo+ID4gdmlvbW11
X21tYXAgYXJlIHdpcmVkIHVwIGluIGEgc3Vic2VxdWVudCBwYXRjaCwgUGFnZTAgcmVnaXN0ZXIg
d3JpdGVzDQo+ID4gd2lsbCBiZSBmb3J3YXJkZWQgdG8gdGhlIGhhcmR3YXJlLWJhY2tlZCBtbWFw
J2QgcGFnZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5pY29saW4gQ2hlbiA8bmljb2xpbmNA
bnZpZGlhLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3Ro
dW10aG9AbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAgaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmMg
fCA5OQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCA5OSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
aHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmMgYi9ody9hcm0vdGVncmEyNDEtY21kcXYuYyBpbmRleA0K
PiA+IDM1ZTZmMGJiZDYuLmQ0YmEyYWRhOTIgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3RlZ3Jh
MjQxLWNtZHF2LmMNCj4gPiArKysgYi9ody9hcm0vdGVncmEyNDEtY21kcXYuYw0KPiA+IEBAIC01
NSw2ICs1NSw3MCBAQCBzdGF0aWMgdWludDY0X3QNCj4gdGVncmEyNDFfY21kcXZfcmVhZF92Y21k
cShUZWdyYTI0MUNNRFFWICpjbWRxdiwgaHdhZGRyIG9mZnNldDAsDQo+ID4gICAgICB9DQo+ID4g
IH0NCj4gPg0KPiA+ICsvKg0KPiA+ICsgKiBXcml0ZSBhIFZDTURRIHJlZ2lzdGVyIHVzaW5nIFZD
TURRMF8qIG9mZnNldHMuDQo+ID4gKyAqDQo+ID4gKyAqIFRoZSBjYWxsZXIgbm9ybWFsaXplcyB0
aGUgTU1JTyBvZmZzZXQgc3VjaCB0aGF0IEBvZmZzZXQwIGFsd2F5cw0KPiA+ICtyZWZlcnMNCj4g
PiArICogdG8gYSBWQ01EUTBfKiByZWdpc3Rlciwgd2hpbGUgQGluZGV4IHNlbGVjdHMgdGhlIFZD
TURRIGluc3RhbmNlLg0KPiA+ICsgKi8NCj4gPiArc3RhdGljIHZvaWQgdGVncmEyNDFfY21kcXZf
d3JpdGVfdmNtZHEoVGVncmEyNDFDTURRViAqY21kcXYsDQo+IGh3YWRkciBvZmZzZXQwLA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgaW5kZXgsIHVpbnQ2
NF90IHZhbHVlLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
bnNpZ25lZCBzaXplKSB7DQo+ID4gKyAgICBzd2l0Y2ggKG9mZnNldDApIHsNCj4gPiArICAgIGNh
c2UgQV9WQ01EUTBfQ09OU19JTkRYOg0KPiA+ICsgICAgICAgIGNtZHF2LT52Y21kcV9jb25zX2lu
ZHhbaW5kZXhdID0gKHVpbnQzMl90KXZhbHVlOw0KPiA+ICsgICAgICAgIHJldHVybjsNCj4gPiAr
ICAgIGNhc2UgQV9WQ01EUTBfUFJPRF9JTkRYOg0KPiA+ICsgICAgICAgIGNtZHF2LT52Y21kcV9w
cm9kX2luZHhbaW5kZXhdID0gKHVpbnQzMl90KXZhbHVlOw0KPiA+ICsgICAgICAgIHJldHVybjsN
Cj4gPiArICAgIGNhc2UgQV9WQ01EUTBfQ09ORklHOg0KPiA+ICsgICAgICAgIGlmICh2YWx1ZSAm
IFJfVkNNRFEwX0NPTkZJR19DTURRX0VOX01BU0spIHsNCj4gPiArICAgICAgICAgICAgY21kcXYt
PnZjbWRxX3N0YXR1c1tpbmRleF0gfD0NCj4gUl9WQ01EUTBfU1RBVFVTX0NNRFFfRU5fT0tfTUFT
SzsNCj4gPiArICAgICAgICB9IGVsc2Ugew0KPiA+ICsgICAgICAgICAgICBjbWRxdi0+dmNtZHFf
c3RhdHVzW2luZGV4XSAmPQ0KPiB+Ul9WQ01EUTBfU1RBVFVTX0NNRFFfRU5fT0tfTUFTSzsNCj4g
PiArICAgICAgICB9DQo+ID4gKyAgICAgICAgY21kcXYtPnZjbWRxX2NvbmZpZ1tpbmRleF0gPSAo
dWludDMyX3QpdmFsdWU7DQo+ID4gKyAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAgY2FzZSBBX1ZD
TURRMF9HRVJST1JOOg0KPiA+ICsgICAgICAgIGNtZHF2LT52Y21kcV9nZXJyb3JuW2luZGV4XSA9
ICh1aW50MzJfdCl2YWx1ZTsNCj4gPiArICAgICAgICByZXR1cm47DQo+ID4gKyAgICBjYXNlIEFf
VkNNRFEwX0JBU0VfTDoNCj4gPiArICAgICAgICBpZiAoc2l6ZSA9PSA4KSB7DQo+ID4gKyAgICAg
ICAgICAgIGNtZHF2LT52Y21kcV9iYXNlW2luZGV4XSA9IHZhbHVlOw0KPiA+ICsgICAgICAgIH0g
ZWxzZSB7DQo+ID4gKyAgICAgICAgICAgIGNtZHF2LT52Y21kcV9iYXNlW2luZGV4XSA9DQo+ID4g
KyAgICAgICAgICAgICAgICAoY21kcXYtPnZjbWRxX2Jhc2VbaW5kZXhdICYgMHhmZmZmZmZmZjAw
MDAwMDAwVUxMKSB8DQo+ID4gKyAgICAgICAgICAgICAgICAodmFsdWUgJiAweGZmZmZmZmZmVUxM
KTsNCj4gY2FuIHlvdSBleHBsYWluIHRoZSBhY2Nlc3MgcGF0dGVybj8NCj4gdGhpcyBkb2VzIG5v
dCBsb29rIGxpa2UgQV9TVFJUQUJfQkFTRSBzbW11djMgd3JpdGVzL3JlYWQNCg0KVGhlIHNpemUg
PT0gOCBicmFuY2ggd2FzIGFkZGVkIHRvIGhhbmRsZSBhIHBvdGVudGlhbCBzaW5nbGUgNjQtYml0
IHdyaXRlDQp0byBCQVNFLCBidXQgeW91J3JlIHJpZ2h0IHRoaXMgaXMgaW5jb25zaXN0ZW50IHdp
dGggdGhlIFNNTVV2MyBwYXR0ZXJuDQp3aGVyZSBzaXplIGRpc3BhdGNoIGhhcHBlbnMgYmVmb3Jl
IHRoZSBwZXIgcmVnaXN0ZXIgc3dpdGNoLCBub3QgaW5zaWRlIGl0Lg0KDQpBbHNvLCBtbWlvX2Nt
ZHF2X29wcyBpcyBtaXNzaW5nIC52YWxpZC8uaW1wbCBzaXplIGNvbnN0cmFpbnRzLiBJIHdpbGwg
dGFrZQ0KYSBsb29rIG9uIG5leHQgcmVzcGluIGFuZCB1cGRhdGUuDQoNClRoYW5rcywNClNoYW1l
ZXINCg==

