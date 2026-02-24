Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5595F3C9AD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuuxH-0006Hb-Qa; Tue, 24 Feb 2026 11:08:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1vuuxG-0006Gu-6p
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:08:10 -0500
Received: from mail-out-4.itc.rwth-aachen.de ([2a00:8a60:1:e501::5:49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <martin.kroening@eonerc.rwth-aachen.de>)
 id 1vuuxC-0003NE-3j
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=rwth-aachen.de; i=@rwth-aachen.de; q=dns/txt;
 s=20240516-RWTH; t=1771949286; x=1803485286;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=PenoZdx/HCxH5AsmN6UKCMHkT6Iq51scdFJ4PVr3Ouo=;
 b=QoO7NcXRmrwp0I4bq/8efry1qeDyvXgBbQUr10qeAS5iotwpAImBUl23
 AICuipOalxHx9JmE7Kp7hZbP0zEgNBZ049isY1k29puNkwIQbOk5zFqQP
 ZJOkakyoMYU4xp8wKh3ipw4Dzqp2W06rwMUuk5G7kdtFX4pGtGh7WhlJT
 YAZxQmlrdo5xARxeRbDx0bbolqlLvEOfDJLHgdhqMha2WVcM9MRu/LvBl
 b9aIyNk5R52ZZVspAhuN4INdAtC0PPZpNvBtq4fJWMUYiUqosSYS5Dk1z
 MWxzGCW5a4zUgY1uRcXg6h/YvEAHCbXrOs2m8ee+4JqUa9CB938hq46dg Q==;
X-CSE-ConnectionGUID: 7PTn8QQzQCqMuOS8KF0ntA==
X-CSE-MsgGUID: gMKmDn6pSFikaNz4TevnUg==
X-IPAS-Result: =?us-ascii?q?A2D1AAA0y51p/58agoZaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBghCDeIFXAQGEOJF0A6AZDwEBAQEBAQEBAQQEAVEEAQGFBwKNH?=
 =?us-ascii?q?yg4EwECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQYBAQEBAQEGBYEhhglThloBA?=
 =?us-ascii?q?QEBAgEjVgULAgEIGCoCAgIvJQIEDhOCdAGCTBMUqRl6gTKBAd8CgRoSFYE4A?=
 =?us-ascii?q?YFXhnwBgV0Tgw13hHqCDEOBFScODYJoPoQaQINEOoIvBIIigQ6BEohjgg9dh?=
 =?us-ascii?q?lRSgXAsAVUTFwsHBYEjQwOBBiNLBS0dgSMhHRcUH1gbBwUSISoHYQICBIITe?=
 =?us-ascii?q?4IBD4ZseQMuYRoOIgI+XFAFPgtfBXsDC209NxQbjGwQIQ2FQUKBCklCWJMfk?=
 =?us-ascii?q?C6jLweCOF2BCoZdgzOXYgQvl2CTCy6YWKkWAgQCBAUCGIF/gX5xeQGCPVEXA?=
 =?us-ascii?q?g+OLRbGCIE0AgcBCgEBAwmCOY8xYAGBHAEB?=
IronPort-Data: A9a23:+u5jb6sUyVF71JO4a1UIUMaF3OfnVHBfMUV32f8akzHdYApBsoF/q
 tZmKTiBa6yLMTP0fNl0bIW3oEMDuMDdztdqSgA++yk0E3kagMeUXt7xwmUcns+xBpCZEBg3v
 512hv3odp1coqr0/0/1WlTZhSAik/nOHfykVLKs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82AyaDt8B56r8ks14qyo4m9A5zTSWNgS1LPgvyhNZH4gDfzpR5fIatE8NvK3Q
 e/F0Ia48gvxlz8xCsmom6rMaUYDRLjfJ2Cm0hK6jID733CuDgRrukoKHKJ0hXV/0l1lrPgto
 Dl5jqFcfC9yVkH6sLlHD0MIQ3kW0Zpuo9crKVDn2SCaItavn3HEm52CB2luVWEUF3oe7Wxmr
 ZQlxD4xgh+r2NqKxuKCc/tVrd0GMe7QbKAx4nd85GSMZRomacirr6Ti/8BE3Dogw98UWPyYf
 dUFaX9mYFLMbnWjOH9OU854xbzwwCOhNWQF+Tp5poJui4TX5Al4yqTsNpzWYNuHQ8RTkW6Vo
 WTL5W+/GA4GNJmWwDGF/3TqiuKncSbTAthJTOzirK4CbFu7yUkwDTEQC0OAj/i6g2isB+5SN
 Uop9X97xUQ13AnxJjXnZDWgrWKJpFgZUstcHuk+wAWMzKPO5ECeHGdsZiZBadgjuOcyRDojz
 FjPmMnmbRR2vbiIDH6Q6LqQhTW1PycTMCkFfyBsZQIB7smlqow1iB/CZtJiFqeviZvyAz6Y/
 tyRhDIhm7UenYsUjeCxu0rYnzLpr5SPQgNdChjrY19JJzhRPOaND7FEI3CChRqcBO51lmW8g
 UU=
IronPort-HdrOrdr: A9a23:CZjTdK/F9KMZOWDibJpuk+DsI+orL9Y04lQ7vn2ZKCY0TiX8ra
 vFoB1173LJYVoqNE3I4OrwXpVoGEmsjKKdgrNxAV7BZmbbUQKTRelfBeGL+UyZJ8SUzIBgPM
 lbAstD4NGZNykZsS72iDPIdOrJyrG8gcWVbei39QYIcT1X
X-Talos-CUID: =?us-ascii?q?9a23=3ArLQZB2hAb1S3/niez2o9nzp7pjJuLUXhyifpGl2?=
 =?us-ascii?q?BIn9MVZquGXy+oKV4up87?=
X-Talos-MUID: =?us-ascii?q?9a23=3A2kbvmg3DROItLVBTuh6ONy6/TDUj7IGNDWwLz40?=
 =?us-ascii?q?9lciHPApiZwuQkjKKTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,308,1763420400"; 
 d="p7s'346?scan'346,208,346";a="22309228"
Attachment: smime.p7s
Received: from rwthex-w2-b.rwth-ad.de ([134.130.26.159])
 by mail-in-4.itc.rwth-aachen.de with ESMTP; 24 Feb 2026 17:07:59 +0100
Received: from rwthex-s2-a.rwth-ad.de (134.130.26.154) by
 rwthex-w2-b.rwth-ad.de (134.130.26.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Feb 2026 17:07:58 +0100
Received: from rwthex-s2-a.rwth-ad.de ([fe80::9e0:8e94:8a31:2f0b]) by
 rwthex-s2-a.rwth-ad.de ([fe80::9e0:8e94:8a31:2f0b%4]) with mapi id
 15.02.2562.037; Tue, 24 Feb 2026 17:07:58 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] include/exec: Provide the cpu_tswap() functions
Thread-Topic: [PATCH 1/2] include/exec: Provide the cpu_tswap() functions
Thread-Index: AQHcfxJpX9kd3Z45hkeo12U1CBikfbVYdTOAgADUOID///aMgIAFBHUAgDQM1IA=
Date: Tue, 24 Feb 2026 16:07:58 +0000
Message-ID: <0DF0CF94-9EA0-4AE7-A0BD-49D4217C6837@eonerc.rwth-aachen.de>
References: <20260106-semihosting-cpu-tswap-v1-0-646576c25f56@eonerc.rwth-aachen.de>
 <20260106-semihosting-cpu-tswap-v1-1-646576c25f56@eonerc.rwth-aachen.de>
 <ee9a0216-0a1a-46ec-b647-64045c892af3@linaro.org>
 <FDDAA4F9-C389-4E63-8DEB-B0FBE38FE5CE@eonerc.rwth-aachen.de>
 <CAFEAcA-P2xqNO21rMyt2VA_tRf9yzWh8qtJFggGr4Mn-AWjj5g@mail.gmail.com>
 <00BB587B-792D-4725-A42C-AE87A201C2E2@eonerc.rwth-aachen.de>
In-Reply-To: <00BB587B-792D-4725-A42C-AE87A201C2E2@eonerc.rwth-aachen.de>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.106.26021521
x-originating-ip: [137.226.255.149]
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha256; boundary="B_3854797678_3841526206"
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:8a60:1:e501::5:49;
 envelope-from=martin.kroening@eonerc.rwth-aachen.de;
 helo=mail-out-4.itc.rwth-aachen.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  =?utf-8?B?S3LDtm5pbmcsIE1hcnRpbg==?=
 <martin.kroening@eonerc.rwth-aachen.de>
From: martin.kroening--- via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--B_3854797678_3841526206
Content-type: text/plain;
	charset="UTF-8"
Content-transfer-encoding: quoted-printable

> On 22.01.26, 14:16, Martin Kr=C3=B6ning wrote:
>=20
> On 19.01.26, 10:39, Peter Maydell wrote:
>=20
> > On (2):
> >=20
> > > Alex was worried about expanding the use of `virtio_is_big_endian`:
> > >
> > > > Hmm looking at the description:
> > > >
> > > > /**
> > > > * @virtio_is_big_endian: Callback to return %true if a CPU which su=
pports
> > > > * runtime configurable endianness is currently big-endian.
> > > > * Non-configurable CPUs can use the default implementation of this =
method.
> > > > * This method should not be used by any callers other than the pre-=
1.0
> > > > * virtio devices.
> > > > */
> > > > bool (*virtio_is_big_endian)(CPUState *cpu);
> > > >
> > > > I'm not sure if we want to expand the usage of this hack. I think
> > > > Philippe is hoping to get rid of these warts eventually. Of course =
we
> > > > could rename the method and just provide a way to get the current
> > > > systems endianess.
> > >
> > > While not being very familiar with QEMU's source code, something like=
 this
> > > seems necessary to me. I can rename `virtio_is_big_endian` to `is_big=
_endian`
> > > and `cpu_virtio_is_big_endian` to `cpu_is_big_endian` if you prefer t=
hat.
> >=20
> > The reason for naming these functions the way we have now is
> > that we really didn't want them to be a "this looks like the
> > right function to use for my purpose" general name like
> > "is_big_endian". Almost nothing in QEMU outside the CPU itself
> > should need to know about the data endianness of the CPU,
> > because in real hardware the devices can't tell what the CPU
> > is set up as, they just get/send data. The exceptions are
> > legacy virtio (which is a mistake that was made because nobody
> > was thinking about it in the original virtio device design)
> > and some oddball interfaces like semihosting. So the name is
> > intended to push people away from using it (and towards e.g.
> > target_big_endian()).
>=20
> That makes sense. How about something like `internal_is_big_endian` and=20
> `cpu_internal_is_big_endian`, then? I am just making things up, though.
> Given my limited experience with QEMU internals, I am not really qualifie=
d
> to choose any name.

Is there anything I can do to help move this forward?
Should I send a new series that also changes the names to `internal_is_big_=
endian`?
To me it sounded like the technical details are fine to all of you.
If this needs further internal discussions, though, I am happy to wait, of =
course.

Cheers,
Martin

--B_3854797678_3841526206
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIWHQYJKoZIhvcNAQcCoIIWDjCCFgoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0B
BwGgghLUMIIG2jCCBUKgAwIBAgIQIzxeR1DfkY/t9Cm+VVHL6zANBgkqhkiG9w0BAQsFADBj
MQswCQYDVQQGEwJHUjE3MDUGA1UECgwuSGVsbGVuaWMgQWNhZGVtaWMgYW5kIFJlc2VhcmNo
IEluc3RpdHV0aW9ucyBDQTEbMBkGA1UEAwwSR0VBTlQgUy9NSU1FIFJTQSAxMB4XDTI1MTEx
MTE1Mjk0NloXDTI3MTExMTE1Mjk0NlowgdMxCzAJBgNVBAYTAkRFMRwwGgYDVQQIDBNOb3Jk
cmhlaW4tV2VzdGZhbGVuMR8wHQYDVQQKDBZSV1RIIEFhY2hlbiBVbml2ZXJzaXR5MREwDwYD
VQRhDAhHT1ZERStOVzERMA8GA1UEBAwIS3JvZW5pbmcxDzANBgNVBCoMBk1hcnRpbjEYMBYG
A1UEAwwPTWFydGluIEtyb2VuaW5nMTQwMgYJKoZIhvcNAQkBFiVtYXJ0aW4ua3JvZW5pbmdA
ZW9uZXJjLnJ3dGgtYWFjaGVuLmRlMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA
scbe0MnfYWYhL3iklcUn43k7e4DJycolxDWXiOSghpE4NbV4obfamUtkigolqpVwkwAywxLM
B/RZkmg4NwK9eNklZlqvMbcL4N/A66LANFoFOBnEljtlBm89LlCTHPDsdtRrsfyQWXzo6fgH
SDMDYNWR4ejhKMJT83ZBHfTfNPsNtJqJ/lxR2jbiOEXGu8SQjuk5/ydV29N8i9a1dpHBFKWv
YSw16+4ii0O2p31oDiJYaggfAeN4PF1C7ZVH3gFKghwwFxUgvZmz04SEfJXBdh3zDQJn7DyJ
uw1myBMUXATwxN50PAZirIWm88iWh88z9rOpYhwGBFxw+YIcyAXjzZCGn51WKxWICLeSBrJJ
oJmFGlyJ+lehfh3t+O3iLtfsG3hmtF0ulXMRxECkS9rGC8WeMHLUJKhugBAQHGhDTyCbsxZW
y6EKgyMKA8zltWrOzD4107euoyuB+wl+54eXzbwMzbANfpMmGusW+EJh1OfGBaPVrU7mWIUq
sSU3KkRbEqfXNNSyEFvhMza5pfc+XvetNEI9tCGAuN1tY5PI0Akf+E0PARJ5WZl93s+3VOWB
eghS2N7qTiyyGNdSH5FlwYDIy3lTPan7WKA1dquBYoVf5srxjmdWVxTNLOlKMIMuhY6yfB+Z
iyDaoNjL3Xp5my/FE4TMHW6Xg/u9nNm/P1cCAwEAAaOCAZcwggGTMB8GA1UdIwQYMBaAFOuy
Lzv9rgLMKkQGXSXNHRIiaLBHMEoGCCsGAQUFBwEBBD4wPDA6BggrBgEFBQcwAoYuaHR0cDov
L2NydC5oYXJpY2EuZ3IvSEFSSUNBLUdFQU5ULVNNSU1FLVIxLmNlcjAwBgNVHREEKTAngSVt
YXJ0aW4ua3JvZW5pbmdAZW9uZXJjLnJ3dGgtYWFjaGVuLmRlMGMGA1UdIARcMFowCQYHZ4EM
AQUDAjAIBgYEAI96AQMwQwYNKwYBBAGBzxEBAQIEAjAyMDAGCCsGAQUFBwIBFiRodHRwczov
L3JlcG8uaGFyaWNhLmdyL2RvY3VtZW50cy9DUFMwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsG
AQUFBwMEMD8GA1UdHwQ4MDYwNKAyoDCGLmh0dHA6Ly9jcmwuaGFyaWNhLmdyL0hBUklDQS1H
RUFOVC1TTUlNRS1SMS5jcmwwHQYDVR0OBBYEFBZ6nr2j7nTiNEpysS4Q1LWfhajdMA4GA1Ud
DwEB/wQEAwIFoDANBgkqhkiG9w0BAQsFAAOCAYEASrEZ/VGpM+lPpNUZcqFCkF6bvVO7pAVG
iODiSZ5AZ6p0Tzj4R2/05ZcJja1cT7A9V+afh1lSQR+ZrEGmq5CUwrKCWQ5Clq1bbE4Owp0u
QcF3R7d1IWZmK16ukCk4hRHR93DJ81omdO5HRPh8mFKmLpn/bq+TP+Djm5qzM9S3w/Wgr+KJ
pUd6WkYAs1M17cypnn98r9LNAmmLEgN2P4rvuSGEwVW1gzOFPQeYi8vFRAgffdfuBAq0G8Jc
FJ3OTETxtoH3C1X7/CfcPkbnFLfB7lXXv3CuzD0Q2kHuWkzkSzVKG5yQSqEU57CLLgjNUnb2
Bw/lbfKW25IW3YApX5JhuQE/1Kmr6NSVV0Hkb5Hwrc7WZAmdNcvsyBKgQwEHa/pUSkLyuACy
ipgx8wv8ts+YGsQ5gKXKtw34PGEyIsUe7KuDTI5tS094yenQiN58UGkcBgD++wtswxpPv1ln
slpFh+4cEoEx81hdpcwSMIqUlBaDZGOrrseFwRDv5Nkdb9KgMIIGRDCCBCygAwIBAgIQFfmu
bKqNLtTTb3h/Htx7ATANBgkqhkiG9w0BAQsFADBvMQswCQYDVQQGEwJHUjE3MDUGA1UECgwu
SGVsbGVuaWMgQWNhZGVtaWMgYW5kIFJlc2VhcmNoIEluc3RpdHV0aW9ucyBDQTEnMCUGA1UE
AwweSEFSSUNBIENsaWVudCBSU0EgUm9vdCBDQSAyMDIxMB4XDTI1MDEwMzExMTMwOFoXDTM5
MTIzMTExMTMwN1owYzELMAkGA1UEBhMCR1IxNzA1BgNVBAoMLkhlbGxlbmljIEFjYWRlbWlj
IGFuZCBSZXNlYXJjaCBJbnN0aXR1dGlvbnMgQ0ExGzAZBgNVBAMMEkdFQU5UIFMvTUlNRSBS
U0EgMTCCAaIwDQYJKoZIhvcNAQEBBQADggGPADCCAYoCggGBAKu4bq/+byKjHo25Xz32YBmO
+Wrkmc+UmfcdXSCI7yawwU9JSMEHAAKAASaJpLr9JAyt+tlB/rn/SaznSwY4ipBIffR0D5k/
ndfiI553dWgI4i/tkOGlNej/7JyE2CS9kTlOOs6pg5HaDpwqjAhCkje+IByg5gKWH6lzvMJo
5jQOtsGB2q6e5cYKwa9LJOAcR8iquds9LFssbHSMuVdSuTjpAjcGLqWfW++C0YXpWD+UonjQ
6lNEuiKUDmrFc+SEtLw56lYtp4uuxm4LW/HQSsx+oGwMBqaR6HhBQ3LydONjsbcbegRqJZFJ
oLsnwIHorEag44UIvjXzYJAx/NTiwVdHldO7cEvWscDbyQLR9koBoliq2HrgYFQs7NQxU+7M
LNSh8i6znWVNISUEg36M//I8BZl4VqD70ELlhKKN7rx+i7BwKOd2gxdWgFJhkPyQu9o+82R9
epXiRblo/rdkyv+2BFR7VpbgPUzncdi8/0h4dP/qQFYnA+Df0FFj7gYczwIDAQABo4IBZjCC
AWIwEgYDVR0TAQH/BAgwBgEB/wIBADAfBgNVHSMEGDAWgBSg1gc9XiT3e6BELiRSDRmqKwSR
pzBQBggrBgEFBQcBAQREMEIwQAYIKwYBBQUHMAKGNGh0dHA6Ly9jcnQuaGFyaWNhLmdyL0hB
UklDQS1DbGllbnQtUm9vdC0yMDIxLVJTQS5jZXIwRAYDVR0gBD0wOzA5BgRVHSAAMDEwLwYI
KwYBBQUHAgEWI2h0dHA6Ly9yZXBvLmhhcmljYS5nci9kb2N1bWVudHMvQ1BTMB0GA1UdJQQW
MBQGCCsGAQUFBwMCBggrBgEFBQcDBDBFBgNVHR8EPjA8MDqgOKA2hjRodHRwOi8vY3JsLmhh
cmljYS5nci9IQVJJQ0EtQ2xpZW50LVJvb3QtMjAyMS1SU0EuY3JsMB0GA1UdDgQWBBTrsi87
/a4CzCpEBl0lzR0SImiwRzAOBgNVHQ8BAf8EBAMCAYYwDQYJKoZIhvcNAQELBQADggIBADve
uEX23DwrkygKtsF7DmcTGmi8SE20jmJLe0TMT8Nws1NqppE0ACym1agtY1IjUFm5MWabG/Ic
vRTh8sB9cRZgDQMqZLNCLofqL4aj/dKBXH4bwH2MVdjNHBoGvZkyhRz/kBE+x1vaWXclhWQM
OX5nVvRMfiEJiYotMP7KM88IaVZ9DkGJJEVftsnUWuvCWUtjagD6XWlqLHjNl+LufiZ/h9lD
vaWqG1/obfdStgofMc30RL+ES6gYKRwZpCA1coFzXV7Cnwx8toTl8bReqCNXexKzxlqAcRXP
OmlKkJQuqRI297oNuMPnoNZCY+yLnxyd4kZuu0XcOTNTpVjM8bvg8ACqhSYanrNDi/zTiTk7
gwm9GyH1X45fFNGNEFgpIaApjT2UELukDOmP18ZwC4EQeHawPJIqffMEmUJm6qbRPKGnNmcy
ygh4iZU3QbkRLLp3Z6QV3WoTEqyf5mL9qTGS6WJG65L8oaKw1Xh/bdGuVIDyBahpfP2c2pCd
0UH6+x73Rrq9GFlOijVr2OQSvKhzETNG917SvcURCBhMnIQFUXqHQyIY60eH1po6WtNOq/1K
5kpOG6Sq1RVc02LEit48uK4tRMVUKekSOjruGXW38DmAriPcMHjI6VQbqjc0Sq1VPz76ee4F
M5uLviSUZHYqDDqMWa8LFImK9iiKI8E3MIIFqjCCA5KgAwIBAgIQVVL4HtsbJCyeu5YYzQIo
PjANBgkqhkiG9w0BAQsFADBvMQswCQYDVQQGEwJHUjE3MDUGA1UECgwuSGVsbGVuaWMgQWNh
ZGVtaWMgYW5kIFJlc2VhcmNoIEluc3RpdHV0aW9ucyBDQTEnMCUGA1UEAwweSEFSSUNBIENs
aWVudCBSU0EgUm9vdCBDQSAyMDIxMB4XDTIxMDIxOTEwNTg0NloXDTQ1MDIxMzEwNTg0NVow
bzELMAkGA1UEBhMCR1IxNzA1BgNVBAoMLkhlbGxlbmljIEFjYWRlbWljIGFuZCBSZXNlYXJj
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

--B_3854797678_3841526206--

