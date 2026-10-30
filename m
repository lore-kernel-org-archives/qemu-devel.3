Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A769606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 02:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=jTs4DqdP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMbwR-00066N-Av; Thu, 29 Oct 2026 22:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xMbwO-00063j-27; Thu, 29 Oct 2026 22:02:00 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xMbwL-0002fD-6F; Thu, 29 Oct 2026 22:01:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrDaxSbbGipkN8ZtT50wD5QEVIlK5PKD1eRIygBRaTSJSCJL3jPAQT7q8SUv78b19n6tK1JUQoJz7D3Tqw/qqVCxVocHYEBNPBNb433FfXMjTT7CJqk0O/6ri3LXPspPClPCXOBE9BpjLEGr+x5cylfcdx8kHaJsRMptyadElm33gpacjqLEPtCe3tNONqtFb+YmzowEjGSHnS7IK7p6nuSkEaireFmRkTC02sp9WhNBSJpfQVCPpKuV3J866sysh90IO2uMIjLZcwS1Jw5Wox6jTXBB0VwfiAmUsIlN6ZU1fP7Qwnx9yO12QJdfqZG4PILqfiGuVZPTRMSRcZQhfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoBjLWxzpnbg4UhqPhSIW9qKhBPfnzBn2k5ioIjZPLs=;
 b=VMg9N03DryWIa554qPBwqvLLyfJ4Ks9WBqFDDwX5xFIQv6Lhd6Q+8k/NzMysTagumFWqBuOTbv1mOiLw19DcBxvBbVmeTW/blRkp3k1vIPIJWkOjGb/YDpAKFPhIE/AC2xZRZHRaFQFXQYMSVG/8HHTBKyJpICYWuvvBcXHbnLjMugjzvx6h1qbfglMVPmxFd0/W+5w5ya1s31DthOcQSgVW7aviNY1qzyafARPj5vhfPbbTNbU4+cl+ZXr/Q6GD9krKo3rB6ivaLrabKPxyuSM9w2o5Q7xCgk5rRO4SznoAKEmuB6LlNftFCqFqoutJlTAqJv3S0AFCgoJtAwkyMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoBjLWxzpnbg4UhqPhSIW9qKhBPfnzBn2k5ioIjZPLs=;
 b=jTs4DqdPjvzUT/xvNr1vpdQeYvBtyPSSgRHtXLYyZOxexDSM3UscvW9mBQZiG4ctIpZQsnjAIBpJvA3bU+ZJIZZ9xt3bVAwhW3CtfOBR8ooe+ej9ispqW5Aes8bUwwSD4iLaGG/DX6Wb1zcMsvu0M0mXjLCfhKLV4fzJGpcijFPHT78cU1QIXsofATR4HoTXrbUV+e1fS9qOG4KtcbcAQcIyowEmsMbnPI10vlOxoJJ5i9YbJ9wUmD6VSiQVuNUh8fjopvzaYItghdALByaHkzTvlTGXS6kChsAsy/erG3NIdF2saQ1bwOEDOcq7/EMIeIcRY4ri1ToKl12nhv42sw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI4PR06MB8351.apcprd06.prod.outlook.com (2603:1096:4:29a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.4; Fri, 30 Oct
 2026 02:01:46 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.003; Fri, 30 Oct 2026
 02:01:45 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Junjie Cao <junjie.cao@linux.dev>, "kraxel@redhat.com"
 <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>
CC: "clg@kaod.org" <clg@kaod.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Troy Lee
 <troy_lee@aspeedtech.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "junjie.cao@intel.com"
 <junjie.cao@intel.com>
Subject: RE: [PATCH v7 6/8] hw/usb/redirect-server: Implement bulk and
 interrupt transfers
Thread-Topic: [PATCH v7 6/8] hw/usb/redirect-server: Implement bulk and
 interrupt transfers
Thread-Index: AQHdZo5CCWAyOFUsKE2rVSZb021dPrcUTh4AgAEIL8A=
Date: Fri, 30 Oct 2026 02:01:45 +0000
Message-ID: <SEZPR06MB7362042E9D31CDC1D8EABBB4FC6D2@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261028034140.367393-1-jamin_lin@aspeedtech.com>
 <20261028034140.367393-7-jamin_lin@aspeedtech.com>
 <20261029100942.894066-3-junjie.cao@linux.dev>
In-Reply-To: <20261029100942.894066-3-junjie.cao@linux.dev>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI4PR06MB8351:EE_
x-ms-office365-filtering-correlation-id: 14343f61-64b7-4cdf-03f2-08df3629bff1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|4143699003|56012099006|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|10067099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: gCFhYnzxBkbRcFxx86flsJSRkWOqnsrVOrrIlwXszUzkW205GVx+wogmJ4wWIupedfDhEUgDMf9QW91QjqCxFgj9uqgIbf3vbUdM8ENPZua91GeoiqX8C1dyYkMK7coL6YU+mLT2nMyzVETuuxLXTcCSyzwrMIhCiQ9HcA34utZ42T4QxsMTghEojAk9dPB7HBkZ+SKu4TnMtVtpCzjjxKXSB8Zpfo/9D8mSj865DmzEZP384KdczWMGWo1pfoksGifnANndg1rnHhaHGuJGzpWkvxJPClZqtIzofWJhRn40Kfmfbh+GBIVDeyrsLJgEJDOPMdJKBaRVKsABntQcxC+grZZzatFnAP3VF9jWGKCyQSCsFvNUk8SKiuT2WmGptNLIScqyfevX+twojL87C0hrsVOxv1kRKVVy0CVLU6xu48XaDU5uLRKqbSGzL52aFvekRWZdtEk2EeGV9pAbL/fcX5yPx8tiSBkhXKHH4F5JE1N3mmfU3LK5M5s/EBg8hddUJeNJkKpWZ5vtFVXe+72xSMSSKcxanfJDTUWpBbUdXMJM8O163HXsJmfRCmR9VSaUz+RLrQlvLMZ0U7w3vvmZGLUyns8K7mWczCsgmGqfJUqBRsKagp7j4y7w4eJcoTLZhN1kWobrheaYqAUL+lMLC3e+vAI93fID4Cv/pSebbRHnVhbz7Fm4yD/JfN2jg0QtDlTr6zJ+jsDeFKYJlRvUSfuIsBE5lP5eSqg7Ph4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(4143699003)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rpiXzxPMDXZIs6hjTHPRQoQLTUbSFLhRHfwPEKJytzYdWJ/C7zz2GcAdznN1?=
 =?us-ascii?Q?EKoMpurwGFuxhGceOXXdrwF8IU2Cw8+5JPyFPX+3gD4mtw7LRho142PBLoGA?=
 =?us-ascii?Q?4i0IRBTDIoaGj1J4brv/7YnczLAwk0zt1cp+wp8oAtDqSuzZdqkuNbWtCb6e?=
 =?us-ascii?Q?58iKz1cp/YBCloXHeMkIo5ZMnNKX1037TXuZOuTJXSdileqVjiRGxaxllSJn?=
 =?us-ascii?Q?i3LKqdOn/V/2HkeJ4+4OmplaynCuSGE/4ddAj7cIVLJBjGrxk9KgGy2ZZmsi?=
 =?us-ascii?Q?Vs1sCtwUsFf4wwcfSzpOZ3eXtlBM035UqsNX+i7CWMCG4FHB0uJg+3J/flj9?=
 =?us-ascii?Q?OEjbwkDTbBjI6RFmxzp5a9Il3rZT5zwt4HNGC7VU1qlQG7dQ3+/gprKfJEfI?=
 =?us-ascii?Q?qm/ow9hm3LdDwjv9PiNPFYcH8XuBzXqa3kk0rfzCin9SmBu9EqkWN5Bxo/PU?=
 =?us-ascii?Q?wrg8q5mn5ZuMMECHehJhHJTDF93wQFB5Js76JNt+FMm14wbXlCKnW05uei7I?=
 =?us-ascii?Q?f1bCUeW4uvzcz+GE1UJtEkT9u2xRB4HT8B2ABaLJmr+Hr/b5HD6a0ytyRHMt?=
 =?us-ascii?Q?A4qk6EpneKpa/pWwallmXgjZQxRKgy1AmSmiK4gglAWGjOdTULr87whbjqSB?=
 =?us-ascii?Q?M+cqt53QL0Ohk7vbMIl1OHaOOcL46uKUtzATqYHJg3jUME43wNWX3lFG7edn?=
 =?us-ascii?Q?23/nkUTdyHa7DXo4kbCZRxQAFPG/DzAUTdyZvquF/6d+9YFpPLYkiIFexWBt?=
 =?us-ascii?Q?iFJk3a8lVezopV0mi4u/M7Oa6zinSZfn6UHD9PYJz0+Uo6KOhmNBaCRBEQvg?=
 =?us-ascii?Q?CFPBoXF9iE0/ArsjbuSWYhXLoKdmCZXxICWuC7K7dMTUyR1w9+IuY6auAthx?=
 =?us-ascii?Q?uG2viV+Mra5l6xi00rr07bfmWD9OopJnUyaqCXBU56QOE41fpRif16uVIckf?=
 =?us-ascii?Q?EkmCdyV6Hlty1+OwaESTHI32GHLTAkndAc9SPt833R/9KSqEQhiWgwx0BlaI?=
 =?us-ascii?Q?+aMGZnZbmwYX2o+8Uww9Qoh1NLKkLH2uttXTjbjD/BoSC6Tema932g9XaaMZ?=
 =?us-ascii?Q?M2FQIyiqP7e0PNblr3CsYSmensO4y+v+aX0X4SjepBmeexbXIswsIqbQ3/p5?=
 =?us-ascii?Q?riRu/rXrJ1E9srerTxe1Vzu/eZqox4TgsOW2bKV/6zbnAhmNV682iTOOw6xS?=
 =?us-ascii?Q?PmuexocaLe12P36GhSvnce7RlqeXdJmrUN+w+orPLnaX6EbwOA8nSwhaxm0o?=
 =?us-ascii?Q?67kft8P6scilT2Tw2QznxK5K2nPDT/Oa+M1jsYwfjdk6TtoHarNH3fMMUNK6?=
 =?us-ascii?Q?jCBV3a/aDRltbhpkV0slWXrWbXoPN1f8Cf4zdaKbqGhKa7ldBgQBatoPrP6+?=
 =?us-ascii?Q?zzjIMImgy1XPFq16D1spI5/iYlTctS0DZAhHdKJm7Xre1GkY3JH7AsspN+ku?=
 =?us-ascii?Q?QHMMac4Q/o2a/glU+kkt5tcG/WiSGB+McWj7efaq54KsETWvbrwVxoKmN6Zz?=
 =?us-ascii?Q?Wk9TDl2N+oc51GZ2p4A+/boPGcO26BxIwvXz/2Xk9MMTQUicD/MUNYbUzOiK?=
 =?us-ascii?Q?LpK1UsVMiUAXhqBqYb6cqxhUVhdCXgoJcETftCKPyC61LY3v/smGvBfB4ERg?=
 =?us-ascii?Q?262L2dc4Y49eINDRr/ZpmwlWQfZ8R/MnNQmfRqTpZlGtLnCpkvLwnK85ml1p?=
 =?us-ascii?Q?ozBSgb3+3sLqzuWPrpZSJmuvQg56diVyF2Hvg/yRb7LFF/yqccRwZbW0kYta?=
 =?us-ascii?Q?VHJRVHkUVQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14343f61-64b7-4cdf-03f2-08df3629bff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2026 02:01:45.1525 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9cZq3YR78rhL/n4W/uqYbwEsnz68nkeZUylYAB8SST6yFPD1STEk7uXVZh9NwGhBucI10tlzkJpmMLiB+9NoRysECMH1WE2fa9uhCNr6sU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR06MB8351
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Junjie

> Subject: Re: [PATCH v7 6/8] hw/usb/redirect-server: Implement bulk and
> interrupt transfers
>=20
> Hi Jamin,
>=20
> On Wed, Oct 28, 2026 at 03:41:48AM +0000, Jamin Lin wrote:
> > +    int actual =3D rp->pkt.actual_length;
> > +    /* Only an IN transfer carries data back. */
> > +    int len =3D is_in ? actual : 0;
>=20
> For OUT this also zeroes the length in the reply header, and redirect.c c=
opies
> that length into p->actual_length.
>=20
> With usb-storage exported and qemu-xhci on the client side, the device
> enumerates, but the Debian guest keeps resetting it and no sda shows up. =
A
> usb-ehci client works, because EHCI ignores the OUT length.
>=20
> Keeping actual in the header and sending no payload for OUT, as usbredirh=
ost
> does, fixes it here: sda appears on xHCI and a 1 MiB write/read compares
> equal. The control and interrupt OUT replies drop the length the same way=
.
>=20
> The endpoint checks from v6 work now, including start_interrupt_receiving=
 on
> a bulk endpoint, thanks.
>=20
> Junjie

Thanks for the review and suggestion.

I only tested with EHCI on AST2700, so I did not notice this issue.
After testing with xHCI on the Q35 machine, I was able to reproduce this is=
sue.
The usb-storage SCSI probe failed and no /dev/sdX device appear in the gues=
t
I will fix it.

Thanks,
Jamin

