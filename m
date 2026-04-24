Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A0FFB44C8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBY0-0005Jx-2L; Fri, 24 Apr 2026 04:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXe-000528-73; Fri, 24 Apr 2026 04:05:41 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXc-0001Fe-KW; Fri, 24 Apr 2026 04:05:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/doCS2YXm4fSS0g5Xf8Gxas0kEg0zxwsZCiq1HuBb7mO8qe8N6ars1MsS666IbsikYrM6kaJL58YNmmgAeG/u5GeqphRBE5h4FeC5X19KUi8+GCBnTj64uxTDXeC1oqRGaXIqS3kxEwf1sYdjyZPhM09XjMYYMg1R9k4nXYS0gT1WVSUAizDx3Cn8C471GlPiRSJyHIBj1UttIPQefwm+aqNb/y5rTCySq4lyd1taAddvm0La0ZI66G+X0WcS2npju69gRWwSGA2n4+huzFOkRbQrSbc0BR5usYVl+GRarsu6WXj7WQzKzwVUUiNIF168G4IVatiNRvxmqZY41Mvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSSfOUtpTaUIDGIST6WnKPs9DfsxmQ5yxdMVXnjA+Rg=;
 b=ov/mJtT96Be08R4qm+/EZJKhSvxXt2vYtzM0IUcCVE5ou3ajxg0Jq+MaWqxPA9mQAUdls2fuejB7IAoj/081cK9n9skXjvJNZHQ4Ef4YALSkJ4OZJG7h7OO7a9kKwLFiM2YyHRIRfBNd0ZN6e0xdWTnAPhvp8i12sIZet97WanmDQyAmjITj7fQK4ZseYP6YGHC+FiaOlp1IIGZQH9H4x73gGoWSocUYRO2h/voYc1Utz5uX9EqxrerAtgaUo3iKvCMO73ZRpbb3jCXI/IfACBU9oBok67RmscA5f/wRxGm1VbDBVRbwLohShnkFTOmc20ToA2isqgx7AV/0MNpgqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSSfOUtpTaUIDGIST6WnKPs9DfsxmQ5yxdMVXnjA+Rg=;
 b=B2/uJE2QlIIDj3OJG4AQETFQTA35xmb5KsGdKoX0iUY55kjtWbZEgniThFCMTvMFZZiDN8eUSh1cZFX3SRpZCbSSadARK71UGBwcSevh9e6DAcNodfGlY7aB/M8ciRTbzjTXgZoV63RxcWRX+qYDiUIqphmVIPd9v8yoXWF5J0GPnHiWuFx2PDFWgc8+iS2t5lXxyQSLrrXl/9RehXNK4vDbGZpPWhreJjG2tVltBDh1Y/KTlj9ELbP3rcokfS/mIz6weqymSAjGKSQ+cWsb0wUuYFDPAULG1ZSEAeS5mmdlQsA06sp/0LhBEegW1MrDODlOhQCgZvPApGxknjsG2g==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB5790.apcprd06.prod.outlook.com (2603:1096:101:b9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 08:05:19 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 08:05:18 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "peterx@redhat.com" <peterx@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, David
 Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>, Eric
 Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Halil
 Pasic <pasic@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>, "open list:sPAPR
 pseries" <qemu-ppc@nongnu.org>, "open list:S390 TCG CPUs"
 <qemu-s390x@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v5 07/18] hw/usb/hcd-ehci: Introduce common properties macro
 for sysbus and pci
Thread-Topic: [PATCH v5 07/18] hw/usb/hcd-ehci: Introduce common properties
 macro for sysbus and pci
Thread-Index: AQHc08EXAHMS24YnyU+bs2M8szypWA==
Date: Fri, 24 Apr 2026 08:05:18 +0000
Message-ID: <20260424080508.53992-8-jamin_lin@aspeedtech.com>
References: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB5790:EE_
x-ms-office365-filtering-correlation-id: 06768145-c300-47ea-ff2c-08dea1d839dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: gPmsErdN4DCkeJPJa75C8MbjUdbpKFBQ5JuPmU7jg2ofmpk1ZLHVN14rwhuweKJTtnvKc6rcPZ0UohspJteV//SkcNcCEeGdVU2dEspDc49xBHcEawkwTVV1m5oZuCXvnSVRgENQBvLAl81RCwwhiozulyxSsQbRyMxudxMr7uGlR8x/Bj6DtwBJBiGakTxXi9RADLKIoK+pboFDRxRHcUrqD/42MRmQtFBwCGKKKeeZpM1cAE8kBI1bh9Cfv2S2jT4dvbCW5x2HC3umopD4IlSdEo6B5fcSkcL/My2hqhQhwMyqp0W49RwJ8/ZVu9H2XIo8S7JnThKW2ZgYUSK3QJmUStV9Em1rXDZIbSFrBja/e/eSxPJ142clJnM6YPgfalhDfFbeKa9y++XGb78dT4b2ppD4l0Soc/Eqnl/ooHL3KJ2avAuEDyYI4JQ9albA991ZQMK5FqWFWuQK+/j2phOtKDxZRmAcBpDRDdGuOucVcgMCb48Pmfj2L6gQtg+7tQCbq4AT/vBL4vsG+4Y3JiQj8aQQKCl0pQQHiQz3GQwilY8m99veD/w246mxA5/29DaKWdcS7UfCA0N1O55lBsd0gZ9vNNeU/xjnYAHSGpqhIyxPKcQJkBySwPOq3DcUTm6RMC1EaX2zEP0c0lOl5Rzb70UCx4DeBwqE9zU3FVSG0GlrZdRoOwjZPp4sb7Bhx2jGhEy++hq1Xb5br80LovD2FkbALtBjupk0NmuqdaP7HVqb2bednDfa/GU+lb0xxycrBS4A8LIKopCGpKSGjFJdkqrsmdkYnmgv6FDHoRxUXqGi58qZw5LBWZcJDTs1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Do+G3caasxYacZGMADOdmt1mS2ys6e/IoxQHlB/0ExYghP9PIiypyaIy8+?=
 =?iso-8859-1?Q?Z2pMjVMqxvleyeLUW2VacIZe1Xicsj45NI7j5BCaxgnnGbBDzpsUovqBw8?=
 =?iso-8859-1?Q?Hwgze6ufBpC8ADTxX5cEHMOoV0bBQtTIBOLi88ZFGfr8HEe9+O7jRYbl1n?=
 =?iso-8859-1?Q?8IBHXMQ+UELFKsEZhuKKngi5DIfFiciKNCllBdHxSPwgTMHjM/FEXi6aXD?=
 =?iso-8859-1?Q?zcI3hWCxRXeHmQHGTMtJEKQTwO10vgYZzgQ/sbHvET0wdD/SBScBMY1zjW?=
 =?iso-8859-1?Q?1jpTRuvu66wzBUWTvBhvoorIZUFV+v/0ZdYkKCDM5LPM1KRzvyhgfG9kzj?=
 =?iso-8859-1?Q?hLOMfHYe6STREq9H5pqoeCIJSbAyN+Rcue6vAq2dUIlX1gmLz9Ow3Z+fvs?=
 =?iso-8859-1?Q?uGrmEq70qN+NIfCgSZisIR7nn7cCqyAJkelBxSyN+bF7HiDZLz74dH3K9l?=
 =?iso-8859-1?Q?LJO2F1NVYHoaBmPKT0D5XNl7LAGBwgYXYKV1lo7iD5x6HwZOpjqNWQbszm?=
 =?iso-8859-1?Q?U1MBM1w69VOel4fMkz6tYFUAe1NXeoqpViJe6CXpLViCMzSu+rs8vN9eo7?=
 =?iso-8859-1?Q?vsuIlgYp6HWjN3XV30TuEwqKLOKxeQlcPm1AvJSvO9nE12b56mok6jLjgG?=
 =?iso-8859-1?Q?cdBawk4tI4ZN/XRUcIcHg/fpT285JM9w50IvJI33PW7Nk3o5cRdX00DKbg?=
 =?iso-8859-1?Q?/UujqKTHi8py9xpYL9VLfe3k53nNh3B8b6sf521MTQLzeEl+5ImfEUaPhS?=
 =?iso-8859-1?Q?QLOxPwuKIQMALrVrVUNWp+n2ce5cpI4YpR06dOJjgliJW+FqtEWv/WmEZl?=
 =?iso-8859-1?Q?JRb4iPstb+5HtYxy+kGEAJpnX8f0QBxkZ8M6Ju5fgRjgkT5jnlcOGQZK9m?=
 =?iso-8859-1?Q?E5GgyF9EV+72ql9J/QKY4lCnaS94KAH/ilVu66JIyKGLt7L5e/rSDVUM+u?=
 =?iso-8859-1?Q?5kGqpNpaSRpW5iWq8NJxwY7ZEDFd1MnkH5GdW1sAWwkO7TgxUNJ8giXeKI?=
 =?iso-8859-1?Q?SLXxxE992hkhlBPWwMa5VV79Gpfcs1r2JTFwrdaQjUuZJHIYeYAXaISGiv?=
 =?iso-8859-1?Q?GyGpDX/0WDYHRNjjAOMOg1qWXRAwBcYcwHUWTUURM+c7IDaFiCndcJ4egP?=
 =?iso-8859-1?Q?znOj6gtdwJlYrKfrZekWIW+qDYfCppmjEOd6nE4KhA5RRkMOGt4Fw+4iJT?=
 =?iso-8859-1?Q?x/FfUwAELb5tvde9GX3HRRvm5IRSK85calH2iuJICSSBIfPu/QaqtONh57?=
 =?iso-8859-1?Q?e5SviEaM9M3ceXi8wOhQZZqr9zYXvMz2ZWpGU6rGtLnzCfMDJoVHzFXkSf?=
 =?iso-8859-1?Q?7G2tzPfOomvMdmJiR/Ogfc8kyeK/dcwHkOuhnEHuSaj3KixzXjmyz0lybu?=
 =?iso-8859-1?Q?CFRbQlsKEm/0TOlWlgBsdwesit4KSLJpZ+2ijQzpSMSXy3zwb4R9tFyvdM?=
 =?iso-8859-1?Q?Fz8Rj1YThzJKtZIGSOzh/7kmvzGdjCTKA1kfm3NQGQjgVw0kfBsQSUV7uS?=
 =?iso-8859-1?Q?PbXrqHLXQTjQtB6nWBwjQ77XzmO+/IhAAfFNDD9GLtKQhVlG9sPrlhiaPE?=
 =?iso-8859-1?Q?dV/+zjLiFyfZ4QaxxSH4VBViXM7DMqpazD0zjmiJjHiQclRTn7ycq68SnC?=
 =?iso-8859-1?Q?N8fD2mv+1t52u2eql7rE7JpDeIyFTDhOvT9h/2Bg099cbgKPfttU0/m6Ui?=
 =?iso-8859-1?Q?ptqhITuFquB85Rh5J8hTGgJ5EdwXvvSpur0Bj1HpC6byB/VBoKmecLyNdW?=
 =?iso-8859-1?Q?7Dh5+8Q4VevIJAC0C0n9uuiq8gqZUbEO4cqEZZ/kgGDj5I7udBQzj1ASs3?=
 =?iso-8859-1?Q?sqO4X7G+TA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ARqtc6RBIks7b9hpGWuhiyVqfiKp4ypJzjipWbO0xD0kRGtxWTSfZUAmIshxJrIcuspE0BzoS0vUPHq3jnlPV2UjB5fjaqg5OEOgc1rH2xcpYETo2Gv70GINNVAV1luGIwHsgpc87oQOaxQWQUMCkgMtQWW3OTO/1bzNc3bLBW6fUiTbxnSrFT+9coNt/+2lFIXVhefkPuPa3UUozJLpfY+gXHbVOsEeklY9HOsCWGKMvtHkPOFrDKTfIYW9bVfPjBo4qe6ij6ivcJ3DOlVh5PXUfMAlt3XzihgvpvFYbs5SpTAy1n0CTZO8zORRpbNWT7GLG102RCnTBcG9PpXpZw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06768145-c300-47ea-ff2c-08dea1d839dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 08:05:18.8967 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e0X1hQw+1nRBrpVmziouMvQxGpimsoy49bT52poMmjjZikGnKnjRKPHlZOF0IfTBq2AeJVR0yaABQ06bS8t81Xbpz0KhLAahIEQ6k7aY/48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5790
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

EHCI properties are currently defined separately in both sysbus and=0A=
PCI implementations, leading to duplicated code for common fields=0A=
such as "maxframes".=0A=
=0A=
Introduce DEFINE_EHCI_COMMON_PROPERTIES() to consolidate shared=0A=
property definitions and reuse them across both EHCISysBusState=0A=
and EHCIPCIState.=0A=
=0A=
This reduces code duplication and keeps property definitions=0A=
consistent between different EHCI device variants.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h        | 3 +++=0A=
 hw/usb/hcd-ehci-pci.c    | 2 +-=0A=
 hw/usb/hcd-ehci-sysbus.c | 2 +-=0A=
 3 files changed, 5 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 4234591cb4..d038ee1e31 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -307,6 +307,9 @@ struct EHCIState {=0A=
     VMChangeStateEntry *vmstate;=0A=
 };=0A=
 =0A=
+#define DEFINE_EHCI_COMMON_PROPERTIES(_state) \=0A=
+    DEFINE_PROP_UINT32("maxframes", _state, ehci.maxframes, 128)=0A=
+=0A=
 extern const VMStateDescription vmstate_ehci;=0A=
 =0A=
 void usb_ehci_init(EHCIState *s, DeviceState *dev);=0A=
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c=0A=
index 9febcc1031..fd35d25340 100644=0A=
--- a/hw/usb/hcd-ehci-pci.c=0A=
+++ b/hw/usb/hcd-ehci-pci.c=0A=
@@ -136,7 +136,7 @@ static void usb_ehci_pci_write_config(PCIDevice *dev, u=
int32_t addr,=0A=
 }=0A=
 =0A=
 static const Property ehci_pci_properties[] =3D {=0A=
-    DEFINE_PROP_UINT32("maxframes", EHCIPCIState, ehci.maxframes, 128),=0A=
+    DEFINE_EHCI_COMMON_PROPERTIES(EHCIPCIState),=0A=
 };=0A=
 =0A=
 static const VMStateDescription vmstate_ehci_pci =3D {=0A=
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c=0A=
index b31032bbf3..7f7c7f8a2f 100644=0A=
--- a/hw/usb/hcd-ehci-sysbus.c=0A=
+++ b/hw/usb/hcd-ehci-sysbus.c=0A=
@@ -31,7 +31,7 @@ static const VMStateDescription vmstate_ehci_sysbus =3D {=
=0A=
 };=0A=
 =0A=
 static const Property ehci_sysbus_properties[] =3D {=0A=
-    DEFINE_PROP_UINT32("maxframes", EHCISysBusState, ehci.maxframes, 128),=
=0A=
+    DEFINE_EHCI_COMMON_PROPERTIES(EHCISysBusState),=0A=
     DEFINE_PROP_BOOL("companion-enable", EHCISysBusState, ehci.companion_e=
nable,=0A=
                      false),=0A=
 };=0A=
-- =0A=
2.43.0=0A=

