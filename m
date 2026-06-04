Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B60CD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 11:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV6Nk-0000eQ-Qy; Thu, 04 Jun 2026 07:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wV6NZ-0000Pv-0e; Thu, 04 Jun 2026 07:36:54 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wV6NV-0008Lo-IC; Thu, 04 Jun 2026 07:36:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyfZwfudCNDzX75gkJERl4YBaUWp+EX6/4bepae/Tk/RFO2VLJwf5Gzezh7cTBv40UIYcTg6yE/0VTtjzyem2zy3KUmOjJ3gXt0fQvEiJP66WONWDS36Yot7e7J/zI/yjIqOofxSzGv/MiSutXME4gsWvRMk4RIFAWjddk2k/O2d/9wXN9cxOEqlkUxDXTpCjif4fLQahWi0ieZUlocW3JWCwGzb84bAccmcqUB1iNW04Hicxge1G9sRh/0aqX4uAxNOIV9ciWqiIBeKRDxzDfn1rMOANp73Q6MHcHrO3dud1eeyKVbK59cxUt8NgiSzbMSPs1zauS7V7/K2ghXL+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rW9OyO66rt4j8g4uxrtm1Iqt0E3wj3mCjIiynj05HCg=;
 b=s+cC4DZucvKxtIyItUfjECPD7e1GmKz6gf0TIpe8BJKjyVTKAIb1/kx+xlIMhv1CvqCKNyP14YfcpTEGrZcy/BkQ7B40XLd9fOneTaY2KUOYlUngkc7OJiTxViiYPu8InNlMYA9neVviRr3fJdyAfoCriF57UiUEs5RUmBk0/ORGWPh46EOCE6J9NgtWuTLqmUH3lHreNzuW5jL7WJ/MWiRbxlH13GK2Lciud7x1XBmXmtUZzsyV9eHrQB4do2/jqMwg1lZOkGYUZlIC5yb82ftgSWcHMovCYZNv+dFUo24e5jRSw8TQqGUW6eCpCCn7V/cQCQx/GSG71xNUXZe06A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rW9OyO66rt4j8g4uxrtm1Iqt0E3wj3mCjIiynj05HCg=;
 b=lG6i4dx1cq+Bu3jHbn9UZ7JiZuytYj3RcZK0sCDL0vrsTzSxXmBkh7goBsiAqDQIiLqTGRcHrtAIh2G8zrmpNMONySJWW/mZdRBCJKHcaDOW56PZMGCB9XavUxRSPSF0xnrKZpcP0mgxQjqCW1GtDxDfjR+zXjQE9QZfH3R7Jn/mCKyNPDpwPR1IE1vOxWcLpX2ZOK0ql8JbppyO5fT1Pef0d+NipfJp8gpukyM7T9DJo6QWSsBWxTydPbM7uL6BKDc/9eo8S6sAbJ44oQnFznV1vkjIvn2FNmVK9PMzKd8pMXcDFVE+mP2rvuLS6oVzFRZtyaH8eP67v/IVR/M4uw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MW5PR12MB5682.namprd12.prod.outlook.com (2603:10b6:303:19f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Thu, 4 Jun 2026
 11:36:40 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 11:36:40 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>
Subject: RE: [PATCH v6 21/31] hw/arm/tegra241-cmdqv: Map VINTF page0 into
 guest MMIO space
Thread-Topic: [PATCH v6 21/31] hw/arm/tegra241-cmdqv: Map VINTF page0 into
 guest MMIO space
Thread-Index: AQHc8by9IT/rN4alm0uqryUeST9u2bYuMCkAgAAX/ZA=
Date: Thu, 4 Jun 2026 11:36:40 +0000
Message-ID: <CH3PR12MB7548A790EFEFF976D96F6E76AB102@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
 <20260601114221.457995-22-skolothumtho@nvidia.com>
 <aa1ce930-5ce9-48b5-9ece-6569b3d61f19@redhat.com>
In-Reply-To: <aa1ce930-5ce9-48b5-9ece-6569b3d61f19@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|MW5PR12MB5682:EE_
x-ms-office365-filtering-correlation-id: aad9ade2-fa9f-4556-aa28-08dec22d8b73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|4143699003|11063799006|5023799004|56012099006;
x-microsoft-antispam-message-info: MWVoZg1E5knLbar/osw5yAnLZLUNxwLoJuUnYE0hBUJm2p0+nQsQK7wjWcTMNTtb9oR4wuwWFmrMICwEUfY6dDjCarSjX4sUKF1e8VUrvJgZd8aFIKUaxBADiz96Ud7LIL/5tkeCMQsyeACWbjprpGSwaKUIYy6IH1bxVC0kZPUB/LsQBkWZqGq6jbc3sFQuO1PVjptHQfXzoVubebOKdY6LQ05j9DfV6m40n74EEOhxWQAczS24/W8Bwe3R17I8UuBqzxFJftBbg9WTlG6mMKvZZJ6Ic1Nfskd8uysS3hqPZseTpDjFugZgjYgbuE4KY4bop5+uRtzmTq0srG9Pzz75r1xCmCUGo0H5xxqttbOkskzEjkJY6WitV5XNxyVieBC0lzIYSHw0GwbrvELpM53iV/d8rLlx3Z+/huEGn3sEGTLa9zTqz67ntrcoqRmtBS9XQxaIxh5M8bDUWp16B8qvNSWOUtUt+YYrAmSpu8AiDq4tpU+fMQCmsl460gdIraiUD+p603Jjk1JsJkp+c4hyjE4fVWp4I80reDYq3rUGU2/cMtNYE3ad3h44RiDxw00JdvMz8Y7XqrDU53EWVHMUsZRPp/D3VPHE7WjDEUpQaqp4RVHhdk4ubbID8MRamld0ETPoO3LpQAf+rsPyle+xudLdIV/8Y/rVIZrSbTMUOYdwcFoAgPSTuhuIkYDDetiS42Uctpj1Y7F101ljXRzpyVqpInFgIHHZD/OxmMA+FPLejXi1TTqBcZicRGFn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(4143699003)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGxqZFNRWDRTT01IYUpkY25LNGcxLzNocm9CN0Eyai8ydFdCY1VYNERXWGRD?=
 =?utf-8?B?c2U0aFRwQUxJbTg0UmpNQ0ZlcHN3M0NhbFYrS3p0OWYvMHY4NnpUMDlPVC8y?=
 =?utf-8?B?c2o3Q1NwN3ljcmpVQkgwaTVQTmhnZjgzWmh2dFV5eDc1QjVsM0Y5RVY4Qk5x?=
 =?utf-8?B?L0I0SDI5RHFCOXJLQytaVFQwV1dCeW5qT2svK3ZlcWErUG4zc0NxcXpza1A2?=
 =?utf-8?B?VGtteVFqdURVbVFiWWpUd21nckk0em9lL1dPRUpOMHErNkdkaUFhRFZzaG04?=
 =?utf-8?B?SDJaYTlGeGtOR2EwNThKYVRENTEvK3pJa0lnQzJTMmMydC9PNGJHNDFBa0Ju?=
 =?utf-8?B?ZFRocFR4UjhuYldISXFXZFFjeWJ2aEFBZGUwSkExMzVRUFRGYW41K2dCanNm?=
 =?utf-8?B?U2pQd2xVNE4wdG4rMFU4eXI2MjU5TEVnTmcvd1d5aytXZzF0V2g1TUNHK0lF?=
 =?utf-8?B?aGl4QjVIdWVHenNCakVadmJtRUd0aXA1UC92SmN2eXRIZ2hzWEE4b2pEck5j?=
 =?utf-8?B?djVrblJ3NFZFY3pwci9jNXdHeWI4MkMzbndsNGZwRXpmcFdKN2Q3dnRmMWNs?=
 =?utf-8?B?VFAvSTZyaEhHNmJGcWNZUnVMb0ZaNkVOMVI2MXBoMVFWSHNlcFFZT2JMUzB0?=
 =?utf-8?B?RVIzWnFQVGd5YmtoNHlkTUZZeUkxOVdMQVRjUS85M2lPTHlncXZBa1BGS3Nk?=
 =?utf-8?B?WHpPQXFkOElLdTRYMVB2bitVVEtQOVJzWVBIcUx4bis0eEh1U01ja0FWSy9y?=
 =?utf-8?B?THJ6eElLV25FN0FJWFFNTmZ2bFdtVDNqRitVZGR3REdLMHlONHVnbytKanpK?=
 =?utf-8?B?SE9SY08vcmowbno0MmUwQ241K0xLT09qMWlRUTZ0YWlidXh0eDVkVEQ4WjRr?=
 =?utf-8?B?aFZFMEt3Z1JUdG14STBzMzNFWU1NbjNOdnlDMlFSTEZVSmVEeVpqTlh5aUEz?=
 =?utf-8?B?MkRLNDZaQURTS1VVWmdhREJ4RzRzZ1pnazM3REpKRTV6MTJGYnF4aGE3eHZI?=
 =?utf-8?B?eTBaMzBwdW9GdHVpWG4yWDA2SWJTUktzdVdGNW1OQWk4QjUrVC9RTUlaN1pi?=
 =?utf-8?B?bzNkSWhYZWVCTHZRbU4rbmRDc1JRemJ0WHZvYnh0c1oySWlEYTNJcHhKTUc4?=
 =?utf-8?B?cFlIQnhyeFYwRTdzU1RwbDhCOHUxenhXRk9PMy9TQ0lsWmN4Nlk4NzI3Uk9u?=
 =?utf-8?B?M1dEWUpJRVI0MlFzck1HOG4rOStFd3I5bzh4ZlB1dUZ0UGZQQTUzZllxc1pn?=
 =?utf-8?B?LzNDbGluRjBTNUo3R1BPL1BrR1hIem1QYm83QVVJZ0lmT2JZVlo5clNjdjVI?=
 =?utf-8?B?eHNJTEYyTVdqR2hhMjB1UllBeUJiRlFQUGoxRUVtVmFQbVN1UlVVYjVFZU1O?=
 =?utf-8?B?dVVQQTJZSGJRei8zaXF6alN6bnpNdHZET05GbXBUdThBcUtkQlNxL3grOUh1?=
 =?utf-8?B?WTI3MysyN1BmNnE4RHQyRDM1MnMzMEtDdDhHbG9JSGRydjdFQmw4eWRUOU1L?=
 =?utf-8?B?Y2xYV3RaRjdUN0tYUTN3blpOU05qVmhSOTRrWFIwV3hxOVZ1QVpQV2todUJJ?=
 =?utf-8?B?QmlyTFhvWWRYWW5XTlJKYVIrNDJWOW9wQTF0d0I3SHdNMC9MZXRXMllBN3hQ?=
 =?utf-8?B?OUNKemRiL0RzaE1GVXprWWphLzE3cWF1RFJ3ektNZE9GS05PNWFOTGhoaldI?=
 =?utf-8?B?K3h3ZUNwSUNaZXdYNkZMRjY4Rm8xOGVLYkhrZnRsUXVncTEwdmVGMkJhYkdt?=
 =?utf-8?B?enFxUjBhS083WEdlbUlxYkhhWnQrTXhpN2ErdTFHL2RYRUhoa0g5V2dRcW4y?=
 =?utf-8?B?ZmZKN2FEVkgvTGNxQXVTZGV4MGFNamVqM0Z5dFhETDM1QnRJN0dIMHZKRTdS?=
 =?utf-8?B?cU16K0FZVTlYZmlHOGZMaE04VGN4V2RBOFJjM0xIejNXRExTSTJHRUNPdnJV?=
 =?utf-8?B?MmxuYUh3cFRCaHFDZDIwSVlyaG83NUM4b1pueGZqQWhscW1uSy8zazFBdm9N?=
 =?utf-8?B?cHlJUGxPTng1Qm9Pb3d0VCtVYk9SbU42aUhlMW5SeTdDRGtCVlllYnB4M2s4?=
 =?utf-8?B?UkkzQU1JK04rcEFvRFBvWUx4MzErcTVxa2UzQVU4ZHRBOENlS3pXaElzaU1Z?=
 =?utf-8?B?Tm1hWEVEaXNzcWpYWHhIRXZ0aFlveG55ekxxWUtCQkhEVHNMcDhLQW4wSlh3?=
 =?utf-8?B?amFDeVdnajNzdXdPdjdzM1JPdWdaYjFKamNvOVowcmp1YXdlSkthVUlneU5C?=
 =?utf-8?B?VVAweGhZVHplNi94Z3dPbUtZODNucVh1NGUxL1hFUFhlN2JxeHZmR3hXajNj?=
 =?utf-8?B?UEZpMmh0NjA5aTQwQ1BrbmFMVDRTSFdROTFZYWh5bCtOL1BVb0pIZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad9ade2-fa9f-4556-aa28-08dec22d8b73
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 11:36:40.1811 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dld9hJppd5Pz4KXT/blzWV9AIXCtkgzVpeCXRn94Zv+Q6uh/Hw4GVweEhZi0/mwz/n/9CMH9677svrPDeitlCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5682
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwNCBKdW5lIDIwMjYgMTE6MDcNCj4gVG86IFNo
YW1lZXIgS29sb3RodW0gVGhvZGkgPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsgcWVtdS0NCj4g
YXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGV0ZXIubWF5ZGVs
bEBsaW5hcm8ub3JnOyBjbGdAcmVkaGF0LmNvbTsgYWxleEBzaGF6Ym90Lm9yZzsgTmljb2xpbg0K
PiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsgTmF0aGFuIENoZW4gPG5hdGhhbmNAbnZpZGlh
LmNvbT47IE1hdHQNCj4gT2NocyA8bW9jaHNAbnZpZGlhLmNvbT47IEppYW5kaSBBbiA8amFuQG52
aWRpYS5jb20+OyBKYXNvbiBHdW50aG9ycGUNCj4gPGpnZ0BudmlkaWEuY29tPjsgemhlbnpob25n
LmR1YW5AaW50ZWwuY29tOyBLcmlzaG5ha2FudCBKYWp1DQo+IDxramFqdUBudmlkaWEuY29tPjsg
cGhyZGluYUByZWRoYXQuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMjEvMzFdIGh3L2Fy
bS90ZWdyYTI0MS1jbWRxdjogTWFwIFZJTlRGIHBhZ2UwDQo+IGludG8gZ3Vlc3QgTU1JTyBzcGFj
ZQ0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0
YWNobWVudHMNCj4gDQo+IA0KPiBIaSBTaGFtbWVyLA0KPiANCj4gT24gNi8xLzI2IDE6NDIgUE0s
IFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4gRnJvbTogTmljb2xpbiBDaGVuIDxuaWNvbGlu
Y0BudmlkaWEuY29tPg0KPiBJIHdvdWxkIGRpc2FtYmlndWF0ZSB0aGUgdGl0bGUgYSBsaXR0bGUg
Yml0Og0KPiBVc2UgbW1hcCdkIGhvc3QgVklOVEYgcGFnZTAgZm9yIHZpcnR1YWwgVklOVEYgcGFn
ZTANCj4gDQo+IEFsc28gaW4gcHJldmlvdXMgcGF0Y2ggdGl0bGVzIHlvdSBjb3VsZCBlbXBoYXNl
IHRoZSBtbWFwJ2QgcGFnZSBpcyB0aGUgaG9zdA0KPiBvbmUgaW4gYSBzaW1pbGFyIHdheS4NCg0K
T2suDQoNCj4gPiBJbnN0YWxsIHRoZSBtbWFwJ2QgdmludGZfcGFnZTAgcmVnaW9uIGFzIGEgUkFN
LWRldmljZSBNZW1vcnlSZWdpb24gYXQNCj4gPiBndWVzdCBNTUlPIG9mZnNldCAweDMwMDAwICh0
aGUgVklOVEYgUGFnZSAwIGFwZXJ0dXJlKSB3aGVuIFZJTlRGIGlzDQo+ID4gZW5hYmxlZCwgYW5k
IHJlbW92ZSBpdCBvbiBWSU5URiBkaXNhYmxlLiBUaGlzIGVsaW1pbmF0ZXMgUUVNVSB0cmFwcGlu
Zw0KPiA+IGZvciBob3QtcGF0aCBDT05TL1BST0QgaW5kZXggdXBkYXRlcyB2aWEgdGhlIFZJTlRG
IGFwZXJ0dXJlLg0KPiA+DQo+ID4gQWZ0ZXIgdGhpcyBwYXRjaCwgdGhlIHR3byBWQ01EUSBQYWdl
IDAgYXBlcnR1cmVzIHVzZSBkaWZmZXJlbnQgYWNjZXNzDQo+ID4gcGF0aHM6IHRoZSBkaXJlY3Qg
YXBlcnR1cmUgKDB4MTAwMDApIHJlbWFpbnMgUUVNVS10cmFwcGVkLCB3aGlsZSB0aGUNCj4gPiBW
SU5URiBhcGVydHVyZSAoMHgzMDAwMCkgaXMgYSBndWVzdC1kaXJlY3QgUkFNIG1hcHBpbmcuDQo+
ID4NCj4gPiBUaGUgZGlyZWN0IGFwZXJ0dXJlIGlzIGludGVudGlvbmFsbHkga2VwdCB0cmFwcGVk
IChub3QgYWxpYXNlZCB0byB0aGUNCj4gPiBWSU5URiBtbWFwKSBzbyB0aGF0IHdyaXRlcyB0byBh
biB1bmFsbG9jYXRlZCBWQ01EUSByZW1haW4NCj4gPiB3ZWxsLWRlZmluZWQuIFRoZSBDTURRViBh
cmNoaXRlY3R1cmUgYWxsb3dzIHNvZnR3YXJlIHRvIHByb2dyYW0gYQ0KPiA+IFZDTURRIHRocm91
Z2ggdGhlIGRpcmVjdCBhcGVydHVyZSB3aXRob3V0IGZpcnN0IGFsbG9jYXRpbmcgaXQgdG8gYQ0K
PiA+IFZJTlRGOyBhbGlhc2luZyB3b3VsZCByb3V0ZSB0aG9zZSB3cml0ZXMgdG8gdW5hbGxvY2F0
ZWQgbG9naWNhbCBzbG90cw0KPiA+IGluIHRoZSBWSU5URiBwYWdlLCB3aGVyZSB0aGUgaGFyZHdh
cmUgc2lsZW50bHkgZHJvcHMgdGhlbS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5pY29saW4g
Q2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gPiBDby1kZXZlbG9wZWQtYnk6IFNoYW1lZXIg
S29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNo
YW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+ICBo
dy9hcm0vdGVncmEyNDEtY21kcXYuaCB8ICAxICsNCj4gPiAgaHcvYXJtL3RlZ3JhMjQxLWNtZHF2
LmMgfCAzNg0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMiBm
aWxlcyBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcv
YXJtL3RlZ3JhMjQxLWNtZHF2LmggYi9ody9hcm0vdGVncmEyNDEtY21kcXYuaCBpbmRleA0KPiA+
IDg0NDk5Yjg0MGQuLjAxY2Q2YWY5N2QgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3RlZ3JhMjQx
LWNtZHF2LmgNCj4gPiArKysgYi9ody9hcm0vdGVncmEyNDEtY21kcXYuaA0KPiA+IEBAIC00OSw2
ICs0OSw3IEBAIHR5cGVkZWYgc3RydWN0IFRlZ3JhMjQxQ01EUVYgew0KPiA+ICAgICAgSU9NTVVG
RFZldmVudHEgKnZldmVudHE7DQo+ID4gICAgICBJT01NVUZESFdxdWV1ZSAqdmNtZHFbVEVHUkEy
NDFfQ01EUVZfTUFYX0NNRFFdOw0KPiA+ICAgICAgdm9pZCAqdmludGZfcGFnZTA7DQo+ID4gKyAg
ICBNZW1vcnlSZWdpb24gKm1yX3ZpbnRmX3BhZ2UwOw0KPiA+DQo+ID4gICAgICAvKiBDTURRLVYg
Q29uZmlnIHBhZ2UgcmVnaXN0ZXIgY2FjaGUgKi8NCj4gPiAgICAgIHVpbnQzMl90IGNvbmZpZzsN
Cj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmMgYi9ody9hcm0vdGVncmEy
NDEtY21kcXYuYyBpbmRleA0KPiA+IGRjZTcwODk2OTcuLmNkZDRmYTRmMWEgMTAwNjQ0DQo+ID4g
LS0tIGEvaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmMNCj4gPiArKysgYi9ody9hcm0vdGVncmEyNDEt
Y21kcXYuYw0KPiA+IEBAIC0xOCw2ICsxOCw0MCBAQA0KPiA+ICAjaW5jbHVkZSAidGVncmEyNDEt
Y21kcXYuaCINCj4gPiAgI2luY2x1ZGUgInRyYWNlLmgiDQo+ID4NCj4gPiArc3RhdGljIHZvaWQg
dGVncmEyNDFfY21kcXZfZ3Vlc3RfdW5tYXBfdmludGZfcGFnZTAoVGVncmEyNDFDTURRVg0KPiA+
ICsqY21kcXYpIHsNCj4gPiArICAgIGlmICghY21kcXYtPm1yX3ZpbnRmX3BhZ2UwKSB7DQo+ID4g
KyAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIG1lbW9yeV9yZWdp
b25fZGVsX3N1YnJlZ2lvbigmY21kcXYtPm1taW9fY21kcXYsIGNtZHF2LQ0KPiA+bXJfdmludGZf
cGFnZTApOw0KPiA+ICsgICAgb2JqZWN0X3VucGFyZW50KE9CSkVDVChjbWRxdi0+bXJfdmludGZf
cGFnZTApKTsNCj4gPiArICAgIGdfZnJlZShjbWRxdi0+bXJfdmludGZfcGFnZTApOw0KPiA+ICsg
ICAgY21kcXYtPm1yX3ZpbnRmX3BhZ2UwID0gTlVMTDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3Rh
dGljIHZvaWQgdGVncmEyNDFfY21kcXZfZ3Vlc3RfbWFwX3ZpbnRmX3BhZ2UwKFRlZ3JhMjQxQ01E
UVYNCj4gPiArKmNtZHF2KSB7DQo+ID4gKyAgICBjaGFyICpuYW1lOw0KPiA+ICsNCj4gPiArICAg
IGlmIChjbWRxdi0+bXJfdmludGZfcGFnZTApIHsNCj4gPiArICAgICAgICByZXR1cm47DQo+ID4g
KyAgICB9DQo+ID4gKw0KPiA+ICsgICAgbmFtZSA9IGdfc3RyZHVwX3ByaW50ZigiJXMgdmludGYt
cGFnZTAiLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBtZW1vcnlfcmVnaW9uX25h
bWUoJmNtZHF2LT5tbWlvX2NtZHF2KSk7DQo+ID4gKyAgICBjbWRxdi0+bXJfdmludGZfcGFnZTAg
PSBnX21hbGxvYzAoc2l6ZW9mKCpjbWRxdi0+bXJfdmludGZfcGFnZTApKTsNCj4gPiArICAgIG1l
bW9yeV9yZWdpb25faW5pdF9yYW1fZGV2aWNlX3B0cihjbWRxdi0+bXJfdmludGZfcGFnZTAsDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVtb3J5X3JlZ2lvbl9v
d25lcigmY21kcXYtPm1taW9fY21kcXYpLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIG5hbWUsIFZJTlRGX1BBR0VfU0laRSwNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBjbWRxdi0+dmludGZfcGFnZTApOw0KPiA+ICsgICAgbWVt
b3J5X3JlZ2lvbl9zZXRfc2tpcF9pb21tdV9tYXAoY21kcXYtPm1yX3ZpbnRmX3BhZ2UwLCB0cnVl
KTsNCj4gPiArICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbl9vdmVybGFwKCZjbWRxdi0+
bW1pb19jbWRxdiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IENNRFFWX1ZJTlRGX1BBR0UwX0JBU0UsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBjbWRxdi0+bXJfdmludGZfcGFnZTAsIDEpOw0KPiA+ICsgICAgZ19mcmVl
KG5hbWUpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgdm9pZCB0ZWdyYTI0MV9jbWRxdl9m
cmVlX3ZjbWRxKFRlZ3JhMjQxQ01EUVYgKmNtZHF2LCBpbnQNCj4gPiBpbmRleCkgIHsNCj4gPiAg
ICAgIElPTU1VRkRWaW9tbXUgKnZpb21tdSA9IGNtZHF2LT5zX2FjY2VsLT52aW9tbXU7IEBAIC00
NDUsNg0KPiArNDc5LDcNCj4gPiBAQCBzdGF0aWMgdm9pZCB0ZWdyYTI0MV9jbWRxdl9jb25maWdf
dmludGZfd3JpdGUoVGVncmEyNDFDTURRVg0KPiAqY21kcXYsDQo+ID4gICAgICAgICAgaWYgKHZh
bHVlICYgUl9WSU5URjBfQ09ORklHX0VOQUJMRV9NQVNLKSB7DQo+ID4gICAgICAgICAgICAgIGlm
ICh0ZWdyYTI0MV9jbWRxdl9tbWFwX3ZpbnRmX3BhZ2UwKGNtZHF2LCBlcnJwKSkgew0KPiA+ICAg
ICAgICAgICAgICAgICAgY21kcXYtPnZpbnRmX3N0YXR1cyB8PQ0KPiA+IFJfVklOVEYwX1NUQVRV
U19FTkFCTEVfT0tfTUFTSzsNCj4gPiArICAgICAgICAgICAgICAgIHRlZ3JhMjQxX2NtZHF2X2d1
ZXN0X21hcF92aW50Zl9wYWdlMChjbWRxdik7DQo+IGRvbid0IHlvdSB3YW50IHRvIGRvIHRoYXQg
b25seSBhZnRlciB0aGUgdGVncmEyNDFfY21kcXZfc2V0dXBfYWxsX3ZjbWRxKCk/DQoNCkZ1bmN0
aW9uYWxseSBzYW1lLiBDb3VsZCBkbywgcmVhZHMgYmV0dGVyLCBJIHRoaW5rLg0KDQpUaGFua3Ms
DQpTaGFtZWVyDQoNCg==

