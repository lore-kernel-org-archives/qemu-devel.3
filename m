Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016C3CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 09:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKYxL-0000ZE-3M; Wed, 06 May 2026 05:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wKYxC-0000Yu-EI; Wed, 06 May 2026 05:54:08 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wKYx9-0002MS-Kz; Wed, 06 May 2026 05:54:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQlrCkUpXEgyD3X4tIXL51XG8dGLtB9T/r/c+0IIjmJVaWhiv/4S36gwvf5oTZs7EnkY9tm4ixSvu8hlkh0kwg+6CXZJ3TmLRpoU2paZdEiZLlPQMN3ZYojMEV5G2aem0hKRlSidzmcRxEJ4uWFu/+phY1/ZnVKd9WxWhBhAciGjsS0/69gLUsV23NFVEsUUUQPaPEXUGri2syS4bqIrBjcyzdhDUge9diNKNk9jfyzGkRLvODJzrg/UBT9Zgpx7knaGDw8YLkTymW0xR0ghWdIPXZnwcTcHS7jgy4K/PxjeVRJ6aq3ULTlS0e5e9DtC4tKipjoUiaw4OynTlz9H2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfjQw6G6FI+jzgdr89JFJ7BQBTHkFeDhcV1kIeafRYA=;
 b=euHxSqA0SJZ9a/iN+lAFg9xc3Ev7EjphdnBE6NSrHGLRLiMFKMRbTUVSZ7PFnLmxoqqaBMXtgn95lbPf/gTo9iwzx7eZyxmdpwQoG/MsoiNsmQXCvkDFlKCMpVmCZW9n726F2+wuNDiEwI83d+rc5LcvU0JpQ+Fuqc0IgrmxqnKrjlU0KHFkQ2jeYLiCE7U4t+BzTRrKb8twc45Sj+AnKn20xoZd0GcYk+tUYT5w/z7mlKLQr/UaC3ihvVk5auqmVlxINNkcHgBnZpxwS0PSbQXEI4KWTjCp80ywOf90LHMx9k7VzPBiLESisPNik3wF7lWEa5g48Rv+swT/bwM2Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfjQw6G6FI+jzgdr89JFJ7BQBTHkFeDhcV1kIeafRYA=;
 b=AadBNeHdgbcovSTYDGXyKLfDqC9ZwG3kwBGDv2EfdpsAtNHO3A3OF7O6+dYodQjKhPwOj9lEAgk42ql3k+TRnqaXZ2JrhGqWQ3T64upIqHMvl7pCmnM+7u+0MgQi2V6dj00b+v3aZWIs/27st1tMjRD1LELeDuIpqjCpR4WC6QduJnth46BtL7EFh35u9rvefsCEX55e5c4+zKYElw5t5MT0QayS9xwuioEJsdkmqcl24hrXFfF+IvzZZCsIZVZ1erey7gCNI5xV9bCCfpQV17XAb8VlJ6BqoTCvfqzwoENNZUPo7VMKXf+mb097lAowg4Waa///JSbbRZ2vYEsHUw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TY0PR06MB5778.apcprd06.prod.outlook.com (2603:1096:400:27d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 09:53:54 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 09:53:53 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>
Subject: RE: [PATCH 0/2] aspeed/hace: security fixes
Thread-Topic: [PATCH 0/2] aspeed/hace: security fixes
Thread-Index: AQHc3A3Oh7FlffJCMkWZCI7fMOfVtrYAmp0g
Date: Wed, 6 May 2026 09:53:53 +0000
Message-ID: <SI6PR06MB7631B46DF67C1532B154FFE1F73F2@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260504213421.710035-1-clg@redhat.com>
In-Reply-To: <20260504213421.710035-1-clg@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TY0PR06MB5778:EE_
x-ms-office365-filtering-correlation-id: bae6418c-7553-4978-a519-08deab5561f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: oW+uT9rNQNAmH73kfnAqsFmjg7oTko8qFa369W/oXFLSz0GgtkgPdnCdP1hjSBYda3scQLl/aBoDvg9Ltu1zE77pIF5OqR8aKXg8uHThCa1v7Xi8jUOBWBzHMFgnM+CPdH3MPupSVaf5q3wIBBpfVXEs8OJEbQUYfvFRDUQdZS9q5R8KRpRZvWC4qiGOmZprAAN6mIx3PcwxK6EQbndFt45SZLiNujjAAeuEtljk5IHU+bnC4ModEM3SHRNo2+UkRHX85So7aDHMKi7TjT+Uj2LbN3hKYJmg++6dgLusM60j4qJJGVMaYrWjoWMRFlG/hR2jk8OqUcRSEVOhqvJ2ATvh+GD/CFIvbqMShfUTuqtPNL1qPl7/Vri2Y5nbs79Pk06qqlPeKw7/S1ORLlx2/jRGQvtm42aioqdZb4s9HSGCP/WaET9wKauhv7gV4aBgkD2lMDAFw/hNFQ5tpoFwXUoSwKjiZbarmSNVgDEGFr0jAHu8+SiLbRn1+x2doKjM3XwrGpFmDH8gnv8iRrJRotxYpiYr8qQaxsX70gn7R7wrdfxdj/dS7Tiyu1++pzANerru95Z+wCpEAVYIW9jd/gcS3o/PwMLWocIe+JRNiBGHW/h3v6p16BL4WroLcgz46EnqVXrZoCL+7hdrR1Hx1owrV0tuwwN0ucjlwDqaP5ey3nr4HvauqSk1JPulj6LQc0qpmxexmf55OoTO1QeIc4MWqLzolBqy4ziS1pB1T0SrGGvCU0Lqd8JGfLOo1Swe
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1JLcytQeS9HU3MydkdzN0pSRTFacWt3RGlJdVNqTDl0VVgyd2NJZGQ2N25I?=
 =?utf-8?B?S2IweEdDdVVyNFNyMTlDOTJTcGlkV1R6UmZ0YnZudFovcVp1NWVqQlBnZTBH?=
 =?utf-8?B?eWdwV1ZWN0NPSjRRUmsrVHlMVmRlQ0VXZUxYRWw3YlV4YWdCZDloeGVxMmQy?=
 =?utf-8?B?dWhua1hEakZiVVoydW9ySURqQUtnbjdwMlRjUFptd1JwSithWkFaUjhGS2dL?=
 =?utf-8?B?UjNGZy9pU1pGRzJZZlIwcXpIVHhON3h4SzNNbWYweldFd1Y3TldhV2RMYUtE?=
 =?utf-8?B?czlINzd5Zk0yR1J2NFNHSnpzbDd0SjhqR3lRcHpWTTcwcjJVa3hMZk1SQUxP?=
 =?utf-8?B?cTVQZzdXdTZ2ZmhCNUVtSlpHbmV6ay9IOTNTaWsvOE1oMTdZWDRSeGhIeFpK?=
 =?utf-8?B?cVZEWm96VE9HQ3E5OUNmbTk0YjlKVTVnZnFYTFo3WHhlUDZOZ21LcHlsMUlq?=
 =?utf-8?B?eENLQkpiM1JIVEFtdENzVzNhbTcrRDRIZEFRSERNOENyckM3cEpVcFZRVjZW?=
 =?utf-8?B?N3ZJV3drMXgrY2tvQ1B4THFKNDNtdkZpdTRWM01nZWN4aHVFTXNyUUdTTXJE?=
 =?utf-8?B?Vi9zU042SXZjQ0RPVGFsb21wV2JWMURVaXFnd0QvaTNIeGlNZEZsMml5UjZU?=
 =?utf-8?B?NW9WSmtpVnlBOHMyN2U5Rll3USt0MVpXRktCQTI1dkRQc2ozUzhZMkVRWlZB?=
 =?utf-8?B?dlJEQkhUbk8wRjRYVHppaHk0NEJiM2dldVRuQnhCb2ViVTJKamJTa2FFR1B5?=
 =?utf-8?B?c0VSN3FIREhCcGh3RHRKZFFRRkxsTGZyWGNFQjNPK29Ja3BiRFVBNXM2NkY5?=
 =?utf-8?B?VU1ONS9LK0l5V1Zpc21FdzdCUWFVM2psbSt6MHVnRXhUVEJYRCtWaThuWGVv?=
 =?utf-8?B?QTdYZEpkbjNRK0hHcVpaL1pTRkcvVm4wcVlSeGd5ME9Dc1BjeFk4bktCemNu?=
 =?utf-8?B?OW8yK2JkNDhtNExKdWd4b2ErNE05SVlzbTFYU2loNFdyMy8rcFNLNldRR3ly?=
 =?utf-8?B?c3NtQldWdDI1b3dWWWt6OVI0VC9JbjFQRUpJdVdvMC9ac01QbWZ6QU5xTWRC?=
 =?utf-8?B?L0t1SGJLVVBZRkgrbnJZRmkzSlJMNEFpN1lKR1dJV0JpNWZ3RVVGMWNya3lr?=
 =?utf-8?B?MWNLRjBIRDR2UXZHcXdadVRqL3FiV2c3akZmV3ljRWowUGVSdEQ4amNzMjMv?=
 =?utf-8?B?Y2FnQnpDM2FRcXlXV08vdW11VDhXaGRIdGZRNzVKbUw5WVQrUTdEaU1kUkVi?=
 =?utf-8?B?anZIays2M0ZMUVZaYVNsOWtnMzdKVkxkaFlHeVE3RHZyZTh3ZGhLUE5MSDhF?=
 =?utf-8?B?Qk5iZU85cEtvZCtEWVFSYmFZTkFXckUzL1NqOE9YMFVreWhHUTlhdklzMm8y?=
 =?utf-8?B?MmlJZWVJSzlUcHVZYjZsREtud2RJVmZydS92cFhlNVVkRFFxZVpjT045M0RI?=
 =?utf-8?B?SDNPQ1hKMUUwcWp5OUlvdE9CdnJ6UUIrR3prUGc4ZytZdTJPc3ExN0hobmZQ?=
 =?utf-8?B?ODBnOXhCeEEwQUlJWEhBcTAzait4TGJvTk52TW5aUmE0Zld6SldpTFc1SUtT?=
 =?utf-8?B?dVJTTUlJMFg1cWIvOUVEbmRIbjQvUkxiZXM4NWx0c2wvTEFFSlJmZDJieG9H?=
 =?utf-8?B?SWZTRlpUMUpCVTllWlpzVjhLb3BmdTN1VHJCZTdabEd4cHhXbytkeGNnZVhZ?=
 =?utf-8?B?ck1OT0YyR0VEUk5PdURuNDBJc3hUbGNlSFF4OWxsS0JmNlhZODNud0V5dkht?=
 =?utf-8?B?UjBQZmJ1SWhXOXdKT2o0L3U0OEpCY3hQNmVSak9Sb0dyblBtKzkxNmE4ZzVw?=
 =?utf-8?B?MjVBc2xyS1lGdUFxOGpLamJxOGlqVDREbVdjOE96ditKaHUxZElsdURraTNM?=
 =?utf-8?B?ckpOQjZGcERzUldTMTNNbllPTisrRnVlRXVwZzRqYUxkSVF4cU9QRGdRL3J5?=
 =?utf-8?B?VjdHT3dUNEttSjRnY1IxRGRvTW9mNFBMdHpLZEhYNGM0UVZtUFNyUG1qeXhm?=
 =?utf-8?B?dW1lTEI4Z21iT0trdXA2ZHo4dHZEZjFZczZxVkV2NklqZ3VLOXV0YWxTb0wx?=
 =?utf-8?B?ZkFIbUFMMW12YnM4MzRlZDBLZUdxSEI0a1FEWEpuUXlta1crU0txVVJwdmRu?=
 =?utf-8?B?Sk82d2hsVUNhc2dYMGVTdTZ3SVZKYXUxVDNmQ3I0SGdLM21qdit2TXBoNmFy?=
 =?utf-8?B?MmpDVVkyZWFRbnlCbkk4aVVXMVZlU0l3ZGRmbUE5akdxTkpxSHZtL21JZ29s?=
 =?utf-8?B?djlYV2tzZjNGakRMbDdLOFJRaGllT2txSkxsdUJrOW5UNlNzN1l4U2I1Ukl1?=
 =?utf-8?B?bzc2WSt3WTB0aStYQkdSclBQV1dBbUgyZVY5S0RwcjBVNG9TckpCdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TZmFYL5mNZf9EabP/mw+qYrbRs4dYOx3M56cpY5pJLyNtI1lVtFcQ36IykkDm2Bhc181Vrt7xt3hLn7IGjQPGZGb4gR2Zk3Ht4MhFPAvC1r1wDepHMlzoa0SrsthF9x2K1jgQlBgwxuiBVJOd0biyL4I0hyW6E+/uqCStqz+ZiOndZeRCtbUH/LCPPp46vPv4ueIMd72yQ0yYP6FU6j35x6IDr0gLfP2t80wS8AQ4IWO67kzJK6sEssytTeiXllHR+GgY9PBXx9qqc6Zff5S5sAOCD0R13UBVkTSkV7KpmCCmQacyL6K+367iVZeSPv6uctZFyXi/fpho2710WEe2w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae6418c-7553-4978-a519-08deab5561f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 09:53:53.6588 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0syXIkRxJW+2mX75vZ3IAW0uQBxBzBsDpIMaYa0yN2Guvu8opfIIoF7ZxXJ/0hj3891DBhrCjnCla7cXRRmCHI1roOgdGgTD9uuizbcxZtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5778
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1heSA1LCAyMDI2IDU6MzQgQU0NCj4g
VG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgcWVtdS1hcm1Abm9uZ251Lm9yZw0KPiBDYzogUGV0
ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgU3RldmVuIExlZQ0KPiA8c3Rl
dmVuX2xlZUBhc3BlZWR0ZWNoLmNvbT47IFRyb3kgTGVlIDxsZWV0cm95QGdtYWlsLmNvbT47IEph
bWluIExpbg0KPiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgS2FuZSBDaGVuIDxrYW5lX2No
ZW5AYXNwZWVkdGVjaC5jb20+OyBDw6kNCj4gZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29t
Pg0KPiBTdWJqZWN0OiBbUEFUQ0ggMC8yXSBhc3BlZWQvaGFjZTogc2VjdXJpdHkgZml4ZXMNCj4g
DQo+IEhlbGxvLA0KPiANCj4gQSBjb3VwbGUgb2YgaXNzdWVzIGluIHRoZSBBc3BlZWQgSEFDRSBt
b2RlbCB3ZXJlIHJlcG9ydGVkIG9uIHRoZQ0KPiBxZW11LXNlY3VyaXR5IGxpc3QuIEhlcmUgYXJl
IGZpeGVzLg0KPiANCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQo+IEPDqWRyaWMgTGUgR29hdGVy
ICgyKToNCj4gICBhc3BlZWQvaGFjZTogRml4IG91dC1vZi1ib3VuZHMgcmVhZCBpbiBoYXNfcGFk
ZGluZygpDQo+ICAgYXNwZWVkL2hhY2U6IFByZXZlbnQgdG90YWxfcmVxX2xlbiBvdmVyZmxvdw0K
PiANCj4gIGh3L21pc2MvYXNwZWVkX2hhY2UuYyB8IDI5ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gDQo+IC0tDQo+IDIuNTQuMA0KDQpIaSBDw6lkcmljLA0KDQpUaGFuayB5b3UgZm9yIGZp
eGluZyB0aGUgZGVmZWN0cy4gVGhlc2UgY2hhbmdlcyBsb29rIGdvb2QuIEhvd2V2ZXIsDQpJIGhh
dmUgb25lIHF1ZXN0aW9uIHJlZ2FyZGluZyBhbm90aGVyIHBvdGVudGlhbCBpc3N1ZS4NCg0KSW4g
dGhlIGRvX2hhc2hfb3BlcmF0aW9uIGZ1bmN0aW9uLCBhZnRlciBjYWxsaW5nIGhhc2hfcHJlcGFy
ZV9zZ19pb3YNCmFuZCBoYXNoX3ByZXBhcmVfZGlyZWN0X2lvdiwgdGhlIGZ1bmN0aW9uIG1heSBy
ZXR1cm4gZWFybHkgaWYgaW92X2lkeA0KaXMgLTEuIEluIHRoaXMgY2FzZSwgdGhlIGNvZGUgZmxv
dyB3aWxsIG5vdCByZWFjaCBoYXNoX2V4ZWN1dGVfYWNjX21vZGUNCm9yIGhhc2hfZXhlY3V0ZV9u
b25fYWNjX21vZGUsIHdoaWNoIG1lYW5zIHRoZSBtYXBwZWQgYWRkcmVzcyBtYXkgbm90IGJlDQp1
bm1hcHBlZCBwcm9wZXJseS4NCg0KSSB0aGluayB3ZSBtYXkgYWxzbyBuZWVkIHRvIHVubWFwIHRo
ZSBhZGRyZXNzIHdoZW4gdGhpcyBlcnJvciBjb25kaXRpb24NCm9jY3Vycy4gRG8geW91IHRoaW5r
IHRoaXMgc2hvdWxkIGJlIGluY2x1ZGVkIGluIHRoaXMgcGF0Y2ggc2VyaWVzLCBvcg0Kd291bGQg
YSBzZXBhcmF0ZSBwYXRjaCBiZSBwcmVmZXJyZWQ/DQoNCklmIGEgc2VwYXJhdGUgcGF0Y2ggaXMg
cHJlZmVycmVkLCB0aGVuIGZvciB0aGlzIHBhdGNoIHNlcmllczoNClJldmlld2VkLWJ5OiBLYW5l
IENoZW4ga2FuZV9jaGVuQGFzcGVlZHRlY2guY29tDQoNCkJlc3QgUmVnYXJkcywNCkthbmUNCg==

