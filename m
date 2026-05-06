Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27658CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKdB1-0003dR-D2; Wed, 06 May 2026 10:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wKdAz-0003cc-KF; Wed, 06 May 2026 10:24:37 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wKdAx-0005EY-NA; Wed, 06 May 2026 10:24:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2WEjlqotss4XFhl4t+fswO21MhXkA83dv/oJV6zr6X+zjJ+SLHCa/bP9hcCzZlIVhHvP2gXsu3GMYWFdchJ4PJhYXNvrlz4fZf+LGFraweUpthWBlqKld3q3+cYf+sXvyCcN8OC2kxDMhmG9r828Dov+nhj3fPLtsa/n8iS+rJHzUYP2+YVm9v6gPsBoL3jmvG7vDhTkPWPd/wvHEQpZk4GY3+136QMd6g4W2eokg1w1oH8LzF2FHXPyHa6QRR85YH0oGvmUewVDzlroNBdW50Bo+mpf630TALiHxevc1SeF87AQkn/ADFi9Rax8930oD4bvZNhcUs4Adrs5TPcvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXDTUtjOA3h0gy9e7fMgmeLQ6JZhXVHo/zYvOUhs0GM=;
 b=XJ01z4QTVykkLNIT5jToKuyjTydS9arFAccKrItNx0yTqML1elhoKCbssKvqF57UONuBNDm0qz36Dr884BUaqyYwHRXey9HjBIzpXazArUOIk2s96s3iN8iNy1AraVO4/NKZ232aWsePfNA8qGAkj4tTodoGe9BlUK6m3UAFTx7k0YUmQJ3dO28F5Q+wRvPK4IDFTlrg/h5lV0Xwuq/07zlsfQYtdCk7JYT+bShQYszTFWPl0xiPG5Td8zEKezrHQM+4tR/hVVdVcnkbP4tbWXIVgO44kmUpuz4xvHsBSd/zRn2Ek5VXELTL3bZq0PMUKBeaiCkUPP6q2yCNdQf7Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXDTUtjOA3h0gy9e7fMgmeLQ6JZhXVHo/zYvOUhs0GM=;
 b=U0A5HRMKogofrLTXoYqmBMZyaeUq8RsY3vEhCQnnzOJ8u/qhXzkDkMlc66aqGseMKw7TgoneOBH7//4IXunCxDIE5bH6jTMGbrxgPlT+lXaYfsLjCKH44akdK0slSGI0/Y8EPJxVbGswERim5iPXYIXNubgA6tzZOkjI4xCTunnsXrGTBrf/YPLPEWw3Q+FIXZrwxY5eoKW5GH9lc3Isufh8l23IeBNwmfNdze9ZU5avjpCaD/+vvveEdThGTnSgMYmCxmY+FPM/pbFIRrX3ZTN0G1+b3bGRoacy544Vc5J1YvaLCYxXe6bJZ36n+t60nDb/7LpDn+atCJ+YVzz8lA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by EAYPR12MB999133.namprd12.prod.outlook.com (2603:10b6:303:2c1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 14:24:27 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 14:24:27 +0000
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
Subject: RE: [PATCH v4 22/31] hw/arm/tegra241-cmdqv: Map VINTF page0 into
 guest MMIO space
Thread-Topic: [PATCH v4 22/31] hw/arm/tegra241-cmdqv: Map VINTF page0 into
 guest MMIO space
Thread-Index: AQHczMbEqU/zgTI+9ka08AG/nQw53LYBErsAgAAZPMA=
Date: Wed, 6 May 2026 14:24:27 +0000
Message-ID: <CH3PR12MB75486E45A43C6CD5A203D03BAB3F2@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-23-skolothumtho@nvidia.com>
 <4918654a-7c79-474b-9ede-5418460a5a76@redhat.com>
In-Reply-To: <4918654a-7c79-474b-9ede-5418460a5a76@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|EAYPR12MB999133:EE_
x-ms-office365-filtering-correlation-id: 19028413-88a1-492e-9327-08deab7b2e06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 4VdaYa/xXAkzbYC+58elLjH3vR061YEUjbfGxikNi809ibispItadmalMV9hglYY1ljFJRFuojfs4mzSjMgGzUI0O/JvRg3yx6Ia6X9b36jd8+teTi99WjeGhhh6rh3iuyPlyt5mcaF/LN3q2hKy1zDBGwIsxn1M5ANsBWvoSoBbagctyUtXjLQ0ouxKOGHuH9PMRYKLLA5cJBqr3vnQR3GIFlHlb0SJ9kUZhEJ+eMAXsQPlvTn5mfY9XwNMkhX2yG4/F/1xV7Gw891ldGOu8b+RCxUXD28ORBDDPv4Vy11Ye53TAWQoVt2UKdUVMhu3n9RMSoMS5NCZGYYvV/23Pc5+CbhDL6SK6MeDKeXjNN5zD8+U1NGgd2KFBl29T825NuCycEwkIQfzWUbcz03wIF1NNNYpAJJLASyiTSopTEfSZfhjG6OccB2T5f0slZD72Qa+fBjNfGHTvpI9xB9RKcA7517DbclmIZ4ow41ww+M0wrGUDOEo7qHCLm9hjYHqyIh7ST1U/0Sf5mMEfOY1x51fH/JWQ+eMneLG5ukmLCWlC+8k2rfABo/wIAsObg3a0tn9duSL3nZOVD8cLdzuf0M6cP6PTyGHwd7fkvHbZB90rcPoe75fD3kJ9WrQON037HRPuC8EJmB/DDu/outzrdVkZME3L0vtr/Q7NhdwvPxnaLtmppIq/oL1uWMA5qLY0XtxBdQaIjJ3Y042/igjbsASm3eP298NtztjWh88h/DuCMSdbW4sVdxwpk+w2XMB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmljdjV1alFLOXlGRG5FYnBTVFFuYzNxNHY0cmh4Rlp6VnlwMThnMFE1U2w5?=
 =?utf-8?B?WFZabzRKWmNMR1hPYmN3cnQyWmlKYURERDBaYlUzZlJOQW5KRFkzQTVYVVFU?=
 =?utf-8?B?MUFKWVN3Vk13MDR1YXVkcVZrVHEvY1daYUxkQ2VqWVdaV2lab0JQWjF4amtq?=
 =?utf-8?B?MUQ0WnNmV0lTdHNZY1FGRVlJMCtHcElrR0MzbjhiT0dpS3dkUVAzWmRPdmJN?=
 =?utf-8?B?UWlOMkJJTDFBYkNWZG9TQ0NNc21oV3JmVXNRMG1kUkxBOHBWaG5VVFJXb1B5?=
 =?utf-8?B?VjhRdzZ1WGg3bzA0VWRDUEVSNUF1dWJPbGNGU1ZCSjhKUS9ZU3hxZDlQa1Y1?=
 =?utf-8?B?cE5DTWpRb0Nwc0tvbklvVVEra1l5R1JoTmxvUmVZRW96MmMwbkx5UERrbWxP?=
 =?utf-8?B?TmQybFVRVithamFDcEJkQXZ1Q3FOdlQ5VTdJWHRhM3krV0w3c05iQmJNbHNJ?=
 =?utf-8?B?Z2s1clU0WjRtSXIwOXlVSDlUbVd3TXZOWmZrMVlGVUh4UnFVMGhRTW03Q0hK?=
 =?utf-8?B?S2RLVXZkWXRqL3Frd0lWNFQrR245UXhqS1dzcTBBUEUwZDlzblpEbHJ0QlRP?=
 =?utf-8?B?TmNzbmptOXVXRncyQ3NpR1IrS2Z2NTBEbGtxYjhacmYwMkJGejZNY0hNcEJq?=
 =?utf-8?B?ZjdXMi9TYnhBV05qclB2aE5YdXVUc1RIZXZ4WXJqU0tjaFFpUWpIcWRUVGRm?=
 =?utf-8?B?dmZLcjc5ZERBQXpLWUxwY0FISG1MeW94eVUwK0Q3ZVV3WkdDZ3dxbENQTXJV?=
 =?utf-8?B?dTcrcXg3VGZ3OUNmYjFva3JXWTgvRmVxcEJadW11ampOMVd1ZkhiOWE1VWoz?=
 =?utf-8?B?SDgvaXByQmxLQnhJZWYzNDNKNy83bXJwdHJ0dzZxUHoydytNMjFBbVg1UW82?=
 =?utf-8?B?UWQ0TGxabHNlbVVQME9USml5bWROcHN2c2lSLy9RdG12eHZXdU5hU0FhaWpa?=
 =?utf-8?B?ci9pREdieGxZclFDZUhpaE9oUkxRNWhqM2JGWXpSTnJqWWhJNks5aUtxaURz?=
 =?utf-8?B?SEovc2RneEhuNDBablFETFRIL2xiU1lTMUpUU3VLeldLOWZ0MDJVUDlNYUZZ?=
 =?utf-8?B?SklIb0lVUmtGeDRya3JSTUlQdjJXRUt5ZmUwM3plcXBRd2VwR2xLS2N1ZWVV?=
 =?utf-8?B?aHVmODJJQ0VESTJUVU82WkVXZUtMTjZkSnN6cWJMdHdnQWt0OGNSZEkxOFBw?=
 =?utf-8?B?VENaNjlKTG81TWJJL25ieUd1Nmp6SVNabWRuamp2TUVvUm5WT2g5VDZncUhh?=
 =?utf-8?B?aEZxckI2cmZhN25ZRk5wNFRZdWN3eDIxSTFMT0s3dnFtMnhMUHVLenN1dTdi?=
 =?utf-8?B?TWNTcWpKY2J6WUJRNHhWWHdIRytieG9ncGNCSGtKb1pSWTJPQzFpQ2dKYVh0?=
 =?utf-8?B?S0xXRFpnWDFCTjJmOU9Nc1c3S2FDUU9mR3RQOWFYc1U3Z2loT3pDQytIWHRY?=
 =?utf-8?B?ZHpmRG8rcVI2Z1hzdkdLLzk2TTJCRFFTaWdadzFwZDhGU2hxYkNlVHdXS2to?=
 =?utf-8?B?RFg0RDNyQ05CNmNRRzdEcHZhTW5hNllYVVoxem45QzBJNTBxUFZKVzlmZXRw?=
 =?utf-8?B?RForTlBtYUZGMDdFMlJOcUxaZ1pZbk5EbEZLemRoeGNjdEk0MzlrRWFEZWds?=
 =?utf-8?B?dnRQMUZVSkpHbE1FN1lmbTdwSnZDL3Bqa3RpNWJ6NFE1NmZRbUo1SmpQRmQy?=
 =?utf-8?B?MllQeHFGOWtUeG1HTFkxRlQyV0VJeGlxVXlML3FmanBHN2poeFYxL29yWWV2?=
 =?utf-8?B?d2tuNkh5TUt4RVlxNjJGSzVSUlRPZW5VaGhtaE9zWHgyN0xTVktsbDlLbXM4?=
 =?utf-8?B?Qk1LbWJhaWV6b0dxOWEwYkIzTThtd2srb3d1azZ4Q1ZiNXYwUTRvNGhMLysv?=
 =?utf-8?B?UEI1YlhlL0grazNTMEZPamhZbXdhZXM5MjhVM1hBM1ZjUndJWG13ZnlVMVMr?=
 =?utf-8?B?Z3pldE54WjJveWppRzcvK0NjYTV6elJJMlg5elZnTkRQZEt5NUpPMmVGTUZO?=
 =?utf-8?B?QWpUeW8wWVFTRjNGb1VwWUtoU0tEcGlSZnFKN0JUR3Eyb3N1eG10OVM1L2wr?=
 =?utf-8?B?TmttS1dEWWwvNmVLMGx5S3dxUkV1aTRXM1QxanlBT0RnMUxJTFpVTXlidTRz?=
 =?utf-8?B?ZndVcnNVMUkxR0wyTVhDR0t2SmRQdHlsN2laVmlUWDRZK2RiL0diQ0h5YndX?=
 =?utf-8?B?eDNKbExlUTNJTVlDMXhxNUZTUzhzYkhDRzZyWndxbHJDVXdhWXAzRHNNZzZ5?=
 =?utf-8?B?MHdvWHg0UnQvNWlWYUZROThRcDdHd2F6UzJmTGZpR0FlVjZmZjI2V01kd0xl?=
 =?utf-8?B?RGF4WHE1NmRvczRnRXVXUGVIb3QxcnZzcElRb01Qa1NPanU2YlljUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19028413-88a1-492e-9327-08deab7b2e06
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 14:24:27.4563 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MhhczOOlfYr9uE7W/PPhFNIIA2vrqsvd6ODyYww00oYcUCNjXl2IU5z2hBtIbDNuev+u7wF/W0xksYNuW3OyxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999133
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDA2IE1heSAyMDI2IDEzOjQ1DQo+
IFRvOiBTaGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFl
bXUtDQo+IGFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVy
Lm1heWRlbGxAbGluYXJvLm9yZzsgY2xnQHJlZGhhdC5jb207IGFsZXhAc2hhemJvdC5vcmc7IE5p
Y29saW4NCj4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IE5hdGhhbiBDaGVuIDxuYXRoYW5j
QG52aWRpYS5jb20+OyBNYXR0DQo+IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+OyBKaWFuZGkgQW4g
PGphbkBudmlkaWEuY29tPjsgSmFzb24gR3VudGhvcnBlDQo+IDxqZ2dAbnZpZGlhLmNvbT47IGpv
bmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhlbnpob25nLmR1YW5AaW50ZWwuY29tOyBL
cmlzaG5ha2FudCBKYWp1IDxramFqdUBudmlkaWEuY29tPjsNCj4gcGhyZGluYUByZWRoYXQuY29t
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMjIvMzFdIGh3L2FybS90ZWdyYTI0MS1jbWRxdjog
TWFwIFZJTlRGIHBhZ2UwDQo+IGludG8gZ3Vlc3QgTU1JTyBzcGFjZQ0KPiANCj4gRXh0ZXJuYWwg
ZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0K
PiBIaSBTaGFtZWVyLA0KPiANCj4gT24gNC8xNS8yNiAxMjo1NSBQTSwgU2hhbWVlciBLb2xvdGh1
bSB3cm90ZToNCj4gPiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+
ID4NCj4gPiBPbmNlIGEgVkNNRFEgaXMgYWxsb2NhdGVkLCBtYXAgdGhlIG1tYXAnZCB2aW50Zl9w
YWdlMCByZWdpb24gZGlyZWN0bHkNCj4gPiBpbnRvIHRoZSBndWVzdC12aXNpYmxlIE1NSU8gc3Bh
Y2UgYXQgb2Zmc2V0IDB4MzAwMDAgYXMgYSBSQU0tYmFja2VkDQo+ID4gTWVtb3J5UmVnaW9uLiBU
aGlzIGVsaW1pbmF0ZXMgUUVNVSB0cmFwcGluZyBmb3IgaG90LXBhdGggQ09OUy9QUk9EDQo+ID4g
aW5kZXggdXBkYXRlcy4NCj4gPg0KPiA+IEFmdGVyIHRoaXMgcGF0Y2gsIHRoZSB0d28gVkNNRFEg
YXBlcnR1cmVzIHVzZSBkaWZmZXJlbnQgYWNjZXNzIHBhdGhzOg0KPiA+IHRoZSBkaXJlY3QgYXBl
cnR1cmUgKDB4MTAwMDApIHJlbWFpbnMgUUVNVS10cmFwcGVkIGFuZCB3cml0ZXMgdmlhDQo+ID4g
dmludGZfcHRyLCB3aGlsZSB0aGUgVkkgYXBlcnR1cmUgKDB4MzAwMDApIGlzIGEgZGlyZWN0IGd1
ZXN0IFJBTQ0KPiA+IG1hcHBpbmcuIEJvdGggcGF0aHMgd3JpdGUgdG8gdGhlIHNhbWUgdW5kZXJs
eWluZyB2aW50Zl9wYWdlMCBtZW1vcnksDQo+ID4gc28gbm8gc3luY2hyb25pc2F0aW9uIGJldHdl
ZW4gdGhlIGFwZXJ0dXJlcyBpcyBuZWVkZWQuDQo+IA0KPiBJIGZhaWwgdG8gdW5kZXJzdGFuZCB3
aGVuIHRoZSBwcmV2aW91cyB0cmFwcGVkIHBhdGggdXNpbmcgcHRyIGluDQo+IHRlZ3JhMjQxX2Nt
ZHF2X3JlYWQvd3JpdGVfdmNtZHEgZ2V0cyB1c2VkIHZlcnN1cyB0aGF0IHBhdGguIElzIGl0DQo+
IGV2ZW50dWFsbHkgdXNlZD8NCg0KVGhlIHNwZWMgZG9lcyBub3QgcHJldmVudCBhIGd1ZXN0IGZy
b20gdXNpbmcgdGhlIDB4MTAwMDAgcGF0aCBmb3IgYWxsb2NhdGVkDQpWQ01EUXMsIHNvIHRoZSB0
cmFwIHBhdGggcmVtYWlucyB2YWxpZCBhbmQgUUVNVSBmb3J3YXJkcyB0aG9zZSBhY2Nlc3NlcyB0
bw0KdGhlIG1tYXAnZCB2aW50Zl9wYWdlMCB2aWEgdmludGZfcHRyLg0KDQpXZSBjYW5ub3QgbWFw
IDB4MTAwMDAgZGlyZWN0bHkgdG8gdGhlIGd1ZXN0IGFzIFJBTSBiZWNhdXNlIHRoZSBrZXJuZWwN
Cm1tYXAgb25seSBiYWNrcyBWQ01EUXMgYWN0dWFsbHkgYWxsb2NhdGVkIHZpYSBIV19RVUVVRSBp
b2N0bC4gSWYgdGhlDQpndWVzdCBhbGxvY2F0ZXMgb25seSAxIG9mIDIgVkNNRFFzLCBleHBvc2lu
ZyB0aGUgZnVsbCBkaXJlY3QgYXBlcnR1cmUgcGFnZTANCmFzIFJBTSB3b3VsZCBnaXZlIHRoZSBn
dWVzdCBhY2Nlc3MgdG8gdW5hbGxvY2F0ZWQgVkNNRFEgc2xvdHMuIEhlbmNlLCBpdA0KcmVtYWlu
cyB0cmFwcGVkIGFuZCBRRU1VIG9ubHkgZndkcyB0byB2aW50ZiBwYWdlMCBmb3IgYWxsb2NhdGVk
IHF1ZXVlcy4NCg0KVGhhbmtzLA0KU2hhbWVlcg0KDQo+ID4NCj4gPiBUaGUgbWFwcGluZyBpcyBp
bnN0YWxsZWQgbGF6aWx5IG9uIGZpcnN0IHN1Y2Nlc3NmdWwgVkNNRFEgaGFyZHdhcmUNCj4gPiBx
dWV1ZSBhbGxvY2F0aW9uIGFuZCByZW1vdmVkIHdoZW4gQ01EUVYgb3IgVklOVEYgaXMgZGlzYWJs
ZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRp
YS5jb20+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10
aG9AbnZpZGlhLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxza29s
b3RodW10aG9AbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAgaHcvYXJtL3RlZ3JhMjQxLWNtZHF2
LmggfCAgMSArDQo+ID4gIGh3L2FybS90ZWdyYTI0MS1jbWRxdi5jIHwgMzcNCj4gKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDM4IGlu
c2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vdGVncmEyNDEtY21kcXYu
aCBiL2h3L2FybS90ZWdyYTI0MS1jbWRxdi5oDQo+ID4gaW5kZXggMDM5ZDg2Mzc0Zi4uMmJlZmE2
MjA1ZSAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vdGVncmEyNDEtY21kcXYuaA0KPiA+ICsrKyBi
L2h3L2FybS90ZWdyYTI0MS1jbWRxdi5oDQo+ID4gQEAgLTQ2LDYgKzQ2LDcgQEAgdHlwZWRlZiBz
dHJ1Y3QgVGVncmEyNDFDTURRViB7DQo+ID4gICAgICBJT01NVUZEVmV2ZW50cSAqdmV2ZW50cTsN
Cj4gPiAgICAgIElPTU1VRkRIV3F1ZXVlICp2Y21kcVtURUdSQTI0MV9DTURRVl9NQVhfQ01EUV07
DQo+ID4gICAgICB2b2lkICp2aW50Zl9wYWdlMDsNCj4gPiArICAgIE1lbW9yeVJlZ2lvbiAqbXJf
dmludGZfcGFnZTA7DQo+ID4NCj4gPiAgICAgIC8qIFJlZ2lzdGVyIENhY2hlICovDQo+ID4gICAg
ICB1aW50MzJfdCBjb25maWc7DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2FybS90ZWdyYTI0MS1jbWRx
di5jIGIvaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmMNCj4gPiBpbmRleCBlYjYxOWUxMTM0Li5iZjk4
OWRkNTFmIDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS90ZWdyYTI0MS1jbWRxdi5jDQo+ID4gKysr
IGIvaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmMNCj4gPiBAQCAtMTUsNiArMTUsNDAgQEANCj4gPiAg
I2luY2x1ZGUgInRlZ3JhMjQxLWNtZHF2LmgiDQo+ID4gICNpbmNsdWRlICJ0cmFjZS5oIg0KPiA+
DQo+ID4gK3N0YXRpYyB2b2lkIHRlZ3JhMjQxX2NtZHF2X2d1ZXN0X3VubWFwX3ZpbnRmX3BhZ2Uw
KFRlZ3JhMjQxQ01EUVYNCj4gKmNtZHF2KQ0KPiA+ICt7DQo+ID4gKyAgICBpZiAoIWNtZHF2LT5t
cl92aW50Zl9wYWdlMCkgew0KPiA+ICsgICAgICAgIHJldHVybjsNCj4gPiArICAgIH0NCj4gPiAr
DQo+ID4gKyAgICBtZW1vcnlfcmVnaW9uX2RlbF9zdWJyZWdpb24oJmNtZHF2LT5tbWlvX2NtZHF2
LCBjbWRxdi0NCj4gPm1yX3ZpbnRmX3BhZ2UwKTsNCj4gPiArICAgIG9iamVjdF91bnBhcmVudChP
QkpFQ1QoY21kcXYtPm1yX3ZpbnRmX3BhZ2UwKSk7DQo+ID4gKyAgICBnX2ZyZWUoY21kcXYtPm1y
X3ZpbnRmX3BhZ2UwKTsNCj4gPiArICAgIGNtZHF2LT5tcl92aW50Zl9wYWdlMCA9IE5VTEw7DQo+
ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIHRlZ3JhMjQxX2NtZHF2X2d1ZXN0X21hcF92
aW50Zl9wYWdlMChUZWdyYTI0MUNNRFFWDQo+ICpjbWRxdikNCj4gPiArew0KPiA+ICsgICAgY2hh
ciAqbmFtZTsNCj4gPiArDQo+ID4gKyAgICBpZiAoY21kcXYtPm1yX3ZpbnRmX3BhZ2UwKSB7DQo+
ID4gKyAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIG5hbWUgPSBn
X3N0cmR1cF9wcmludGYoIiVzIHZpbnRmLXBhZ2UwIiwNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgbWVtb3J5X3JlZ2lvbl9uYW1lKCZjbWRxdi0+bW1pb19jbWRxdikpOw0KPiA+ICsg
ICAgY21kcXYtPm1yX3ZpbnRmX3BhZ2UwID0gZ19tYWxsb2MwKHNpemVvZigqY21kcXYtPm1yX3Zp
bnRmX3BhZ2UwKSk7DQo+ID4gKyAgICBtZW1vcnlfcmVnaW9uX2luaXRfcmFtX2RldmljZV9wdHIo
Y21kcXYtPm1yX3ZpbnRmX3BhZ2UwLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIG1lbW9yeV9yZWdpb25fb3duZXIoJmNtZHF2LT5tbWlvX2NtZHF2KSwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBuYW1lLCBWSU5URl9QQUdFX1NJ
WkUsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY21kcXYtPnZp
bnRmX3BhZ2UwKTsNCj4gPiArICAgIGNtZHF2LT5tcl92aW50Zl9wYWdlMC0+cmFtX2RldmljZV9z
a2lwX2lvbW11X21hcCA9IHRydWU7DQo+IEkgZ3Vlc3MgeW91IG5lZWQgYSBzZXR0ZXIsIGhlcmUg
dG8uDQo+ID4gKyAgICBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb25fb3ZlcmxhcCgmY21kcXYt
Pm1taW9fY21kcXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBDTURRVl9WSU5URl9QQUdFMF9CQVNFLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgY21kcXYtPm1yX3ZpbnRmX3BhZ2UwLCAxKTsNCj4gPiArICAgIGdfZnJl
ZShuYW1lKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIHZvaWQgdGVncmEyNDFfY21kcXZf
ZnJlZV92Y21kcShUZWdyYTI0MUNNRFFWICpjbWRxdiwgaW50DQo+IGluZGV4KQ0KPiA+ICB7DQo+
ID4gICAgICBJT01NVUZEVmlvbW11ICp2aW9tbXUgPSBjbWRxdi0+c19hY2NlbC0+dmlvbW11Ow0K
PiA+IEBAIC03Miw2ICsxMDYsNyBAQCBzdGF0aWMgYm9vbA0KPiB0ZWdyYTI0MV9jbWRxdl9zZXR1
cF92Y21kcShUZWdyYTI0MUNNRFFWICpjbWRxdiwgaW50IGluZGV4LA0KPiA+ICAgICAgaHdfcXVl
dWUtPnZpb21tdSA9IHZpb21tdTsNCj4gPiAgICAgIGNtZHF2LT52Y21kcVtpbmRleF0gPSBod19x
dWV1ZTsNCj4gPg0KPiA+ICsgICAgdGVncmEyNDFfY21kcXZfZ3Vlc3RfbWFwX3ZpbnRmX3BhZ2Uw
KGNtZHF2KTsNCj4gPiAgICAgIHJldHVybiB0cnVlOw0KPiA+ICB9DQo+ID4NCj4gPiBAQCAtMzEy
LDYgKzM0Nyw3IEBAIHN0YXRpYyB2b2lkDQo+IHRlZ3JhMjQxX2NtZHF2X2NvbmZpZ192aW50Zl93
cml0ZShUZWdyYTI0MUNNRFFWICpjbWRxdiwNCj4gPiAgICAgICAgICAgICAgICAgIGNtZHF2LT52
aW50Zl9zdGF0dXMgfD0gUl9WSU5URjBfU1RBVFVTX0VOQUJMRV9PS19NQVNLOw0KPiA+ICAgICAg
ICAgICAgICB9DQo+ID4gICAgICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgdGVncmEy
NDFfY21kcXZfZ3Vlc3RfdW5tYXBfdmludGZfcGFnZTAoY21kcXYpOw0KPiA+ICAgICAgICAgICAg
ICB0ZWdyYTI0MV9jbWRxdl9mcmVlX2FsbF92Y21kcShjbWRxdik7DQo+ID4gICAgICAgICAgICAg
IHRlZ3JhMjQxX2NtZHF2X211bm1hcF92aW50Zl9wYWdlMChjbWRxdiwgZXJycCk7DQo+ID4gICAg
ICAgICAgICAgIGNtZHF2LT52aW50Zl9zdGF0dXMgJj0gflJfVklOVEYwX1NUQVRVU19FTkFCTEVf
T0tfTUFTSzsNCj4gPiBAQCAtNDM4LDYgKzQ3NCw3IEBAIHN0YXRpYyB2b2lkIHRlZ3JhMjQxX2Nt
ZHF2X3dyaXRlX21taW8odm9pZA0KPiAqb3BhcXVlLCBod2FkZHIgb2Zmc2V0LA0KPiA+ICAgICAg
ICAgIGlmICh2YWx1ZSAmIFJfQ09ORklHX0NNRFFWX0VOX01BU0spIHsNCj4gPiAgICAgICAgICAg
ICAgY21kcXYtPnN0YXR1cyB8PSBSX1NUQVRVU19DTURRVl9FTkFCTEVEX01BU0s7DQo+ID4gICAg
ICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgdGVncmEyNDFfY21kcXZfZ3Vlc3RfdW5t
YXBfdmludGZfcGFnZTAoY21kcXYpOw0KPiA+ICAgICAgICAgICAgICB0ZWdyYTI0MV9jbWRxdl9m
cmVlX2FsbF92Y21kcShjbWRxdik7DQo+ID4gICAgICAgICAgICAgIGNtZHF2LT5zdGF0dXMgJj0g
flJfU1RBVFVTX0NNRFFWX0VOQUJMRURfTUFTSzsNCj4gPiAgICAgICAgICB9DQo+IFRoYW5rcw0K
PiANCj4gRXJpYw0KDQo=

