Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D882E1098796
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3bVG-0006iR-3U; Fri, 20 Mar 2026 11:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w3bVE-0006i0-KY; Fri, 20 Mar 2026 11:11:08 -0400
Received: from mail-norwayeastazon11023108.outbound.protection.outlook.com
 ([40.107.159.108] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w3bVC-0004lN-Ko; Fri, 20 Mar 2026 11:11:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yyY4lVV76L1Zu8sicFriZDpJLG1UBvq/9onamQMjzSQXQzHjbeSHm9SZrwrG07b3/hj+pCL4uZt+w8gwG40PlP48b0TfsbPJtefhLObemprC01hKdGu6eUUpjHsc11ehMLBcgg5oayVNxbj1NsfW+uTYaj/zO1Fdqyfuqb4uxpkrI7pjjAMtpeVilqEz4mb88tvDBObmbJmlaRVl4nYppSJuQYytzGlqO3Bu+7r/TTr22EtJygc6Z7Nt+Os0eFj2iKYmwZ9Fcr6OiWZOrf3uH1fv0aKgR8lngqNFZaoGxs6rbKPjp6TjPa9psWHwIw7CLBXvCvZcaUodFtmGdnY2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6hz2d6WLpWvMb08JxmjqPWm3/hrE8NHchSoeJuXX7k=;
 b=J7B91TeaUTxCGi06BlZcmZT6eLU9OBnNc34LU4nwd6WUYW7mWNh2tJpbMh/Re11EtCJz7STFSXr7g5dPKSiOk/QtmN3xQE1WwvZEfCOL2iHFYcEvbRs5HQ42jQE1stviL/1qm0qIvHq7AcWoRztVHtFMIYbep8hSA+bXsTtB1cIV6Bbvn7L7U0CkMFy4yKDTvtRYGOpzUbWeqLG4JDBKKlf2hEPCBqk/dgAm8AWOIQyrgLDW/QV2gXgruDL6pMWsp1bDkT8HqkGZZ5R5P/pm/1feSEFYjC9ovlS1k43RP8h+/QRPMt448ufML34nYZjDRcG1DvQ8zX+0i3Y2LVdCDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6hz2d6WLpWvMb08JxmjqPWm3/hrE8NHchSoeJuXX7k=;
 b=rB1APdMRc/l2tv5QahAS95O228U/anDuI4jfPwyTMCK56qQjna2YlvClsFyQNseZJrx6v/PeU+Swwhv5DsnlhtQuxgHBupxuvXEXeLNzZA4KJwQ+ZhIgswXfNvt58hhq7QZEJo48zZ+gi70eiSK644QE6C7T+vtMp6YzZVAl2MuAdKNSwUH7sFTFUloOAsVIgL0Jmd1cCQs34Ht73jqj1SjfLVPflKrOv2OLatMlrqFsnGUb+1GO3KRG8Hn7JuMgSkfFRWdRPuSRCRDl0s3GYHYRK6fakEycETcD7+4Ea0BSZXm2m+NoXnFZzZEduVNIOM/mkzLqzrgw6XgEVVDptA==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by PA2PR09MB7446.eurprd09.prod.outlook.com (2603:10a6:102:40f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 15:05:58 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 15:05:58 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v4 0/7] Add RISC-V big-endian target support
Thread-Topic: [PATCH v4 0/7] Add RISC-V big-endian target support
Thread-Index: AQHcuHsONWCZgaGM6k+qSwCYf+rthg==
Date: Fri, 20 Mar 2026 15:05:58 +0000
Message-ID: <20260320150552.169480-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|PA2PR09MB7446:EE_
x-ms-office365-filtering-correlation-id: 3b62e5ae-ff33-4901-67b4-08de86923123
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|38070700021; 
x-microsoft-antispam-message-info: vl2xwOFkbgyFpDAsCtlGswILIlq3D+YxXuZPdNy/UNv5JjWUNOCdwjE6h90hCx88hsdG7MHYbS71YOuav3543hTfpExi5S4M15vJPsZdYDeBCvPcFq58ef/Rz0rgN/UZ5W1+OfOEwZO+fihlnPmkiAOARRQlaSp6ZbjWQjj5WU6n8v/ffFPz/Zq11J8Rhb/RSl9PM/W7SDpmilRP5F7HFNC9laXHf/9LgLf6oNyRJEaHR00+ChYueWik3EPDlh2rvZwciMXFA2BdztjwEpj/rCOnHaBXY07vo8JnBrOnwz5ZVxshceDeaa2oS5mIG17U75rquGwS/lbJAUl+d8GD0TrYgx2VYj/m8NiWqsWgrFCKfJ/f/h7rrcRNBls0Nt1WFj3HgU5tyfGEXCF3X8lQoNTJGXqPnDS5kRocFpsdDs9GzWLixlZo9iqmdLqelrP2RWmcLEQDoXL1e9nlv2TnAA8bGA9GXM+JLXw16AGcwmuYZnFre/WTAxvc+MEa7XyELS81AcBzQZ21Yi2F83ntfQQ/cdzIkl80paaJniVz4jL42/0GPOAex+XDGGWCyJXnWMvnQGHl1ugcXI82Iowy378FKz3iBiqhPYfDEsKDKgo+CKRI530Zpjtu7E6JACvLYwmoCWCa/6bgki4ciu8rf2NWmCiGrE2YfrUiLRQ1ZkHQ0bU7O5IyA736vx/kKLFTVxtFMnfmhKfK75OAMCNgm+Q6SmQ5ylq+o5VPCNHJhbKAFfqC17D6UQvfAZXtN4Q0hvTgkJPqIeHp/kwPsAEwi2TH9addnz0YnYxyAFvRFHc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVVUV1N4UzBGSTU1bVJHN1pRN0JqVGRMa3F6dFdBTkdqVE9saldkTDdaN0hQ?=
 =?utf-8?B?bEFvazZEb2NPTFpNdjVPL015ZFFhQ21hVS9BSVM3Rk1SNzhScVF6Q3NPRmRi?=
 =?utf-8?B?Ny9icGJ3WkEwemV3Y0lyd2lDUTdjYk1PVVNObjlBaXVqWWREQ0dXY3p5NXlm?=
 =?utf-8?B?VXhFN3ZBNjJucTVBdEN1YUcvb2Y1QVF3aGw1T1ZROEFUbk9CeG1sS1hKTUk0?=
 =?utf-8?B?UVZoTG1wb28xUUw3cTc4TGowYTJ4MU9YVlBMTW9wWS9rbFZUWnJ6ZnJLQkhY?=
 =?utf-8?B?THFoMkt1aHlRYy96OGtOd08xdURNY25VT1FUZXpMenhLSWFSazhUTjZHSUlS?=
 =?utf-8?B?YVRoRlVhcDMybUdEQU1FNTA5WFBRZ1E3N1lBYWxsdmFYTUlBRnJ1cFJaU3dj?=
 =?utf-8?B?aWwxaFdIQmlHODBwcmdOY29sN2xyR3dVc3kvOVRkOWpTNmFuNkpnMFhWd0Z0?=
 =?utf-8?B?OWdvL1k3MHcwZzB0RXp0RUhQQ0NuVVhrOEtQVFVxUGdxa2ROYUF6Y0xvRTdH?=
 =?utf-8?B?cktDajIxZ2dJbklOVXowcUszSEp2VDNkVUd5UjNyc0o0MWZVS1l3cFZxbWlR?=
 =?utf-8?B?YWVpMmRmMkVyNlNjeUF1d29TL1Q2U2x2N2tzUEw1VGJNMEZMN2JDbElMY3hW?=
 =?utf-8?B?UE1mRHRTYVFtVGt2OEphcW1RaFlBd29yaU9NRkN3S01mbGFQNjlEd0hTdVgv?=
 =?utf-8?B?WHZZWmRUeEdQUWhmbEE1K0g2SjJEUzYwMHZVVk9YZkZTY3loajY3cWhDTTQ3?=
 =?utf-8?B?M2Y4eG41NjhHQWJ3YjFoUENVRlZRUGlTM2htRUhidjlic21mc3VPeXNyRTBi?=
 =?utf-8?B?RG9iWWlEOWNqUy8rMWVaaklTYnRxazhNVzRCTkV2SUZFL05jZ1dWTWhkTnZ5?=
 =?utf-8?B?WnhpNmtvZUZwZGRMU3N3Rys4WFJWOXZyYjlNVEEwUHFtellUTXdQYlJQMHFp?=
 =?utf-8?B?em9nRk1DSmpXLzB2YjlLTE1mRXlWL1hSWXZGOTUxVEZiT2pkT0VYeDVDTVE3?=
 =?utf-8?B?Umtra1hMN0g2cEdSRkN0RzlNRW5GT0tFTVZXMnFIdDFRSmF1bDlxb3VHNkgw?=
 =?utf-8?B?QkNzZEM1RGQzSFFpeUxIb09PV3hOelpJdWF6NWZXSHZveE1kV1RBNC8vVDhm?=
 =?utf-8?B?MElBT2drZElmeFoxWE1SckRkYXBZVEtaeDVPWGhHWGV4bEhndnRBV2ZQaXhu?=
 =?utf-8?B?Yjh2WVFBN3VNNDRjU1JoK21xaThuTi9YRlFUVlljc1haSUd6MjIyZ2ZLQ3c0?=
 =?utf-8?B?VUN6cE82Z1l0amVSQk5PQVlIRU5Ta2loaU1kS29ZQ3laZ2VJd0hmN0hBcGRi?=
 =?utf-8?B?WWI2Tm1jYzBqWWdObks4dzV3Q0NSaEw5NGs5K2s1VFdldW9La1JDamhjS1Z2?=
 =?utf-8?B?U2d4cG9ORjV4dDNXU2liS1QrR1JwM0VuYjl1OWpadVN0SC9SZXQvQWpkWDNF?=
 =?utf-8?B?ZGxJM2lEMkUyOStNdjZrNy9Zd1ovb0RNbWZ4N3JHdnVlcy9oUVhVQVM1WWlU?=
 =?utf-8?B?a25qVENTT20wMEl1dXFPNkhBWDNGN0lXd0dQQXVZazlyUElHVDhXTTA5NHRy?=
 =?utf-8?B?cUFDeld3QjIwWlUrTGRCblZvMXdYYnRkVDZjWXF6a09WbGx3ZmN1SmpTRTZi?=
 =?utf-8?B?UzBrUVJRcUdYMGRSU1R6ajVIQ2JiVTg1cm1rakd6ellFRG93eGNrZ3EzazhC?=
 =?utf-8?B?WFJzQ1cwWkNjR29VZUZwNGEzN0ZHY0QxV3ViSm5rOFFzTm1GMkppZ1ovT1RK?=
 =?utf-8?B?UGhING5CRXpDS0pIOWhkUzArNE5UdWJLTEplYXdUSE8xblo0WXRDWG96TnBS?=
 =?utf-8?B?ZGFLbUh5czJaSjVqem1pS21jNmMxbXlST0hoYjQvbFQ3VTZ3aUx0eWlTSGNj?=
 =?utf-8?B?dXFhQ2ZQWm1NN2dFRTFIZmpEMW5ITk1SVm5ZVGRzK2Z6SHdCdUxjMDl1bW93?=
 =?utf-8?B?V0xNMExDSDBIS0FtazdpZ0RpSDdjQzdtSG5xSS8xd3g2UEFTbWJxcjI4ZFlT?=
 =?utf-8?B?MWZFZ1pOdGNuSEdUREVHWm55dkV5MmMrRGtuS0ZJNTRaU2wyV2xpc1BmZHBn?=
 =?utf-8?B?ZjZSRUlsZGlPS2NpQzA0dnRTY3I1aXZwbWVmWFdod0d6NWl5VW5zR25GdXBL?=
 =?utf-8?B?ZHZEUWRkcDB0b3N1czErcUdZWXgyL1JwR0lyV3NUdDYxRDFXM3lWVnIzb0gr?=
 =?utf-8?B?THFCWERCdVIzd0FmTWRWS0NhYmZIWkd1dEJOMW5GRms3d0JSZkN6SW1QNjh5?=
 =?utf-8?B?aUF4OVFYWGhEWlBZeW9Na1lJYWtuaHVYL3dUZEdNTjJWU3J4bFBzUm9ic01R?=
 =?utf-8?B?T09oWUpBckw1WnFKYnFkQlVZaVFpM016ZmY3WWROY1U3M1MwY3kyMXBMNm5V?=
 =?utf-8?Q?YE1XGviG0jQNEzq1FPkWE2qXUBDbq91X7ivd0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0423D8D93E8F0428341CB302873A9C9@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b62e5ae-ff33-4901-67b4-08de86923123
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 15:05:58.0491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wWSBPGV0ver9DEBvt8Y3mLPK+AmgHUL7dJCC/77hYwAO+hZSMRMhemW6hboDQJQxdN3VjXl9YwI30E+5lIFXXkSjtKkU8vd+eRK5WtQ2yD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR09MB7446
Received-SPF: pass client-ip=40.107.159.108;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

LSBBZGRyZXNzZWQgY29tbWVudHMgZnJvbSB2Mw0KLSBSZWJhc2VkIG9uIHRvcCBvZiBtYXN0ZXIN
Ci0gVGhlbiByZWJhc2VkIG9uIHRvcCBvZiBwYXRjaCBzZXQgYnkgUGhpbGlwcGUNCiAgInRhcmdl
dC9yaXNjdjogRm9yYmlkIHRvIHVzZSBsZWdhY3kgbmF0aXZlIGVuZGlhbm5lc3MgQVBJIg0KDQpE
am9yZGplIFRvZG9yb3ZpYyAoNyk6DQogIHRhcmdldC9yaXNjdjogRGVmaW5lIE1TVEFUVVNfU0JF
IGFuZCBNU1RBVFVTX01CRSBiaXQgbWFza3MNCiAgdGFyZ2V0L3Jpc2N2OiBBZGQgYmlnLWVuZGlh
biBDUFUgcHJvcGVydHkNCiAgdGFyZ2V0L3Jpc2N2OiBTZXQgZW5kaWFubmVzcyBNU1RBVFVTIGJp
dHMgYXQgQ1BVIHJlc2V0DQogIHRhcmdldC9yaXNjdjogSW1wbGVtZW50IHJ1bnRpbWUgZGF0YSBl
bmRpYW5uZXNzIHZpYSBNU1RBVFVTIGJpdHMNCiAgaHcvcmlzY3Y6IE1ha2UgYm9vdCBjb2RlIGVu
ZGlhbm5lc3MtYXdhcmUgYXQgcnVudGltZQ0KICB0YXJnZXQvcmlzY3Y6IEZpeCBwYWdlIHRhYmxl
IHdhbGsgZW5kaWFubmVzcyBmb3IgYmlnLWVuZGlhbiBoYXJ0cw0KICB0YXJnZXQvcmlzY3Y6IFN1
cHBvcnQgcnVudGltZSBlbmRpYW5uZXNzIGluIHZpcnRpbyB2aWEgc3lzZW11IGNhbGxiYWNrDQoN
CiBody9yaXNjdi9ib290LmMgICAgICAgICAgICAgICAgICAgfCA4MyArKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tDQogaW5jbHVkZS9ody9yaXNjdi9ib290LmggICAgICAgICAgIHwgIDIg
Kw0KIHRhcmdldC9yaXNjdi9jcHUuYyAgICAgICAgICAgICAgICB8IDIyICsrKysrKy0tDQogdGFy
Z2V0L3Jpc2N2L2NwdS5oICAgICAgICAgICAgICAgIHwgMjggKysrKysrKysrKysNCiB0YXJnZXQv
cmlzY3YvY3B1X2JpdHMuaCAgICAgICAgICAgfCAgMiArDQogdGFyZ2V0L3Jpc2N2L2NwdV9jZmdf
ZmllbGRzLmguaW5jIHwgIDEgKw0KIHRhcmdldC9yaXNjdi9jcHVfaGVscGVyLmMgICAgICAgICB8
IDI4ICsrKysrKysrLS0tDQogdGFyZ2V0L3Jpc2N2L2ludGVybmFscy5oICAgICAgICAgIHwgIDkg
Ky0tLQ0KIHRhcmdldC9yaXNjdi90Y2cvdGNnLWNwdS5jICAgICAgICB8ICA5ICsrKy0NCiB0YXJn
ZXQvcmlzY3YvdHJhbnNsYXRlLmMgICAgICAgICAgfCAxMiArKy0tLQ0KIDEwIGZpbGVzIGNoYW5n
ZWQsIDE1NiBpbnNlcnRpb25zKCspLCA0MCBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjM0LjENCg==

