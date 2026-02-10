Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B699EA3F2A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjls-0001QB-8L; Tue, 10 Feb 2026 04:11:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjll-0001FF-Hn; Tue, 10 Feb 2026 04:10:55 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjli-0004kR-7q; Tue, 10 Feb 2026 04:10:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXVH4zlH1mb6soh/jYcyA27/TlIE5ztgePCtkwhFk0+JUFIO1kagiENsfOLSk9Hk8d2o915wfJHIIcXHOItwNLWCGLWMaBudlppSw8E2ZaIJLPBCoLT1oaTPJEy/Ypx84iGf1pptkUSndddPrRJspLLcelkhzs2xhexE5EnKOSVfYRA52Gv0lYGglTmy77Ui5X9LUSeewvw0boQ1pah0DR+3hnPiv7m9GaCdFpiwel+S6MfDgGND1nKTF1ohJcq7X9X0oPHN1Uv/izHg5Wo8wQM4/5Rm71TvGRbh/Yz7yVCvtyvibX+jVPd8rOxH9oEeiqbnSN2fvnPaLdDQdmc+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/AYuRkWP6BeUepikGanog70cRJ8IwLDIUKHi20W3No=;
 b=UsP57w/PfAm3sheq55YuWrZ1zMk1cIBS/7YgMOcyp8W2Kz98lxi0Htu/Zkl/TWKzb6NcP/Jo6ZuERlmhP/c03jgDw1ET2Pk6ulvq6uLAkDEqsRFsxyCBN+bCF+oyCAufbJ0SufL7a9WtJetygIeb93X1cDlnbhp8buyQBMlggmYAc4qLNyY+khbDaL00uFQFUlVC5+Rj7kz1pUkFwNP0PCMUjicOh2Q1AHcxTOpnmlEZjqDK36U/lyQrUSnz6jthoh60Dxrz0EmdHz7YSDa8LnlHVaaBKS+xNJ9cTEZMO6aNto+uh90I1Iccf8HGLvZFRYNDal5C/LIeQ5JARp2z7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/AYuRkWP6BeUepikGanog70cRJ8IwLDIUKHi20W3No=;
 b=flp7K/BkuAlWQ2XP3nY393NzJR01z/fWODNGdd5K3HrsfPVBzV1Kew8WyfYxjV12hgrg79eefMxsWVIxjp8rH7DIIJ/AVZqBL4ULfGxPkoz1HJii/MJym5GeWfVtqcmtn9bn741be4Ez86ei3/kwzENhH2b0dPaJuvdFOP2PsjAHrt1tTTbnzCYHGMRHdC7NaeTePvLA4MD/YhCLW6wDlSu5nOx5/UxfTJP4qAGUbRTURZoDcL5XfKmZl3PflW06E6fo1kyYYj1aUzeB2PMJqVZc9/dQlLdG0ZUgPuuB7wPlHwrO1xiaqbEdPVRj+D2iaPxrn9qUqcshyIrB0/keTg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8268.apcprd06.prod.outlook.com (2603:1096:d10:62::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 09:10:32 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 09:10:32 +0000
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
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>, Patrick Venture
 <venture@google.com>
Subject: [PATCH v5 09/21] hw/i3c/dw-i3c: Add register RO field masks
Thread-Topic: [PATCH v5 09/21] hw/i3c/dw-i3c: Add register RO field masks
Thread-Index: AQHcmm0cNdB3bq9V3EGUdM69KPICKA==
Date: Tue, 10 Feb 2026 09:10:32 +0000
Message-ID: <20260210091018.1553489-10-jamin_lin@aspeedtech.com>
References: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUZPR06MB8268:EE_
x-ms-office365-filtering-correlation-id: 428e480d-67fa-4256-9ded-08de68843e8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?dqmUZNxQ1pF4cHh9n2RQJgrmR6zc0r1LOeeAWmobgbJfi14K4L9XoWW7ys?=
 =?iso-8859-1?Q?JD2hclaXFHwFLoxAAxjQgV2SxuVIB/duDQ30cdtgDwTvHaXbF8hprHlBhM?=
 =?iso-8859-1?Q?AFTtD0Qsn7laP1qhE9Za/rh+HNs3epwPrpwKQRLtd92I2sYoKbBMHo5obs?=
 =?iso-8859-1?Q?/A4LLfqiMamnoU0/m98CWvn3zoANKXOZeMDfIvrsIG2K/ULcG44mGnQZis?=
 =?iso-8859-1?Q?R84Dj/1dF3EEQKcg0/vhHUUIjZ+0j+iFYnjrLMcz7TaJFp+5/T+PtxhItB?=
 =?iso-8859-1?Q?KglmAsKlKsHba6rOGS2kfa6UAo+6rDAysgYNzQdWijorb4hdjwz7wpxeHy?=
 =?iso-8859-1?Q?lfR/jKnLe2ixEXOtTfR6/+ghl8BNBK3OasCpYowfXE+kgGYC5dsEAqqvM+?=
 =?iso-8859-1?Q?fQ8VmYGiPzPZ46t2C07azU3zfvmI1vmopekfRA3EBTivJF3mVbbBv0tquU?=
 =?iso-8859-1?Q?N5M0Kee1gaRGLa96UHYkM7b7QdR/OR+WeT4FS2Ju3zcaU8PI7xYjVYrI9H?=
 =?iso-8859-1?Q?HRFFoXzlZmtl01dAe9rEtnpbLvxWlue4n/E51Ga3vcPlegkpjIgol5IHU7?=
 =?iso-8859-1?Q?mfMcq++Xo9CRcKXRYjypUoykCNCNpPbDl7QJl2OU50DnmkEQxQ4zZp+hUI?=
 =?iso-8859-1?Q?T4yi9BiSRDnRdw5EVOkMNTVBf+SeXEh8/kIpRTD34TU3AYTqGqGfhymmCB?=
 =?iso-8859-1?Q?/q142amv3OGmYM+NgvzM/P+4s/8sIZFAa+O61ak5CbVS1+nja7PSkC/AB8?=
 =?iso-8859-1?Q?fbiaU8m/9LrQ6Z2uChYrZL4OT3VoF9yZwOOmJplB27ZG+HerH09Rt4ljER?=
 =?iso-8859-1?Q?3RcLKZirA5Jn/b3OlqyX0Hi5hh+TuVIDYs3SndQB3yfhzpzlf9Opa8+wXC?=
 =?iso-8859-1?Q?vHt64Tbe+pfHnz8bIkQZqp/4airFi5w72KU9CH2nW43uAXSt5mUhii6qQP?=
 =?iso-8859-1?Q?mepqjIdDc1pwTjAS5noJByafTU6etSxGnCxDemze4bBd4V0wIWtJc0UyPL?=
 =?iso-8859-1?Q?rHgbFuHgYsZfOD1gdQXI/4CI3MunE/eOrnL+On5M/tNMbI1SeFy3VssOZ7?=
 =?iso-8859-1?Q?Gwuw2ExMIE4CCitBUheZA5ZDdDlVlmu2VZf7yCRhAM0Hmko6pcDb8vUuCb?=
 =?iso-8859-1?Q?hmvtCY3a+Cvo142GzrlZYdvZR21krKerMsI9rLS7HzkyQl21Q1vbfMuPWH?=
 =?iso-8859-1?Q?xxYUuhGDFqAMzdfHaZZXQUf3MPcuMXh7FBNBvzx1YgD7k7ZAlASsKqQFXs?=
 =?iso-8859-1?Q?upOSYpBTk92XJtDwa2qQSAhTfeBe/qkIeuLtpzEE2E5/GZJ7UEduXlQtNF?=
 =?iso-8859-1?Q?D8HLXASyrxjeQsyJk5lC7GbgMzJ5/SL1xCpquLrJfsnMYpYKWgRx2y9hcO?=
 =?iso-8859-1?Q?JkAl+MfEienkkvinCOE6M7I9rmvYT/GUkH5KLko4q9N/M6BSHsdalvPwsG?=
 =?iso-8859-1?Q?4sGzeMRstPYPWQvkt984oVOjIH1w1rAQ/1/wBZLjUXMqKDFQTRDFRe3mfz?=
 =?iso-8859-1?Q?54MJW+Fsyp790f1cUDMO3J4dWBwLdI/gyPBtlnz6yG3DdcVzjv4TDNJ6W+?=
 =?iso-8859-1?Q?i5h5VfkRTdoIEUzwjGZ0Epj/ajh/E2i8NBwZRLcCuYXMaDkoBQ5CmQegD4?=
 =?iso-8859-1?Q?7D1/wD8oQ0rluv+GpionVb36xav63HlU9ou0LLAVcguoEQpFGAz5ATor62?=
 =?iso-8859-1?Q?mZcWwacoWMGtSlYS63v60uhrgV0dibyEpoxq1lt7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iQNALKvntQziU7qj88k491eXypV1eYHOYj+pk3d/bAKOz6P1k7UfdGm6mz?=
 =?iso-8859-1?Q?5zmuXMxkkI0D2DXcpUfc3yrov4kk11NxF1RBSR3r8V5PPPNSNj5hGxTdzs?=
 =?iso-8859-1?Q?Jw+w1/hlBZsvD2VJDlyeD2QYRj8VKX2o0jHl98L5Ly+N4T1Wi0z8J/JR+g?=
 =?iso-8859-1?Q?GsDNQ5uYp1H5RM+OVkMTA/P5xah2ibg30U6jhbqYx8zbsQWCrfCK1NaT7L?=
 =?iso-8859-1?Q?BaYcKkDecxWEpXCalIvMtb99WereXj9KLOPQsw4r32FsggtkbLOCkt9qcJ?=
 =?iso-8859-1?Q?6kb5LAFaHopQ4kjyGc9cnk08c8dr8MD8sCicsBfUT9DyWLbYOUe+D1qxWG?=
 =?iso-8859-1?Q?ERnQv5yrBOb7YRB12q7cq53C7FqYSq8Cr1TwktyKysz2/ky2Mi95AZ3E1m?=
 =?iso-8859-1?Q?LJhm7pToRs01OYsVfa9lSVT2nmdlR50Xtin47SUpolZrvxv3myUlH0EJpg?=
 =?iso-8859-1?Q?JhYMvJUelv2xiULN7yIosbHikSOyM0hlYoRosW1OBKlBr54t/t0A3yGyf9?=
 =?iso-8859-1?Q?WEs4LHDdC2YEIoG4u5tfh7/nm6hx+j4sih/t9y+iKkJE/DszBwToRvq21N?=
 =?iso-8859-1?Q?ckPVj654k0jVAdB2YD0AT4fEPNrLeyiwKjoLjWqeJ9KETUPto6nTrBZZqX?=
 =?iso-8859-1?Q?jXgFxU1EJzOQxA3bP5JxJ+jydyd5etZ2HWI+Ua/CsQt1IN7i5OD1qdX5PM?=
 =?iso-8859-1?Q?sxVy3Mb2DvEI+H8K24TZuOrpajYo3hPfGNZtg3YpVqonRLhHQSFsiVHOtd?=
 =?iso-8859-1?Q?qqOTZodQop15goysnxjATVvBecj82PztrraWZT0XVjWZ07kHh9CS9pdNev?=
 =?iso-8859-1?Q?/fbRAqwjgLwg+gcvQNuTuBYSgnUSscbf8Qnjtn0cXWKhY1VVyKdF2bIvSb?=
 =?iso-8859-1?Q?aYslC67v+7WK+Ff6P9SiXJWGcVqb4pBkSDT8KppK7ChJ0QAL+na4TcAu0d?=
 =?iso-8859-1?Q?+li8IZB4x7kDne/LQiFbB0ZwYRP98PlER9cnGvY4dKtHvk6RbUI8IPcx7F?=
 =?iso-8859-1?Q?YHQX0o+4t+yq6TksbYdg+HsZyE5u7JKMe3kEcWXM7fj6L3HjrQ0gDcEkUZ?=
 =?iso-8859-1?Q?nvpzRCMJfYh7gaEnyEA3Ng6e/nYPsalF+6f+k5vFq/9RycJ3KVXE4lS939?=
 =?iso-8859-1?Q?NvFWisu6egFk7QelJV+u13RQkTPJPnt1uRZkDOlK29dSfcu2wQYbOKxrf5?=
 =?iso-8859-1?Q?Mxjtq9U5r7zMhSmwK/85CrR3vygT0Tn7FupgktGcaakB9JxtTkEhZ0QsaG?=
 =?iso-8859-1?Q?p8dOGOyBTEvnisIvILPOLtsT2uBbvPCbCuKv+ZNNxRXPxGy62htY/m0EEn?=
 =?iso-8859-1?Q?IlV1oTrWvl4kMDxO97hmFn+uBz4zMxKvVSoOjUxL4wWSkADQkKty3rxL37?=
 =?iso-8859-1?Q?sSvq3IZyui9yjZN1LI+qAPMOvX5li+oo5sfqK+3x7V6uWEU6LVOPKa1R8J?=
 =?iso-8859-1?Q?MN0t8/i5SIX89lJMochatkOQwRfnQM1WOpT5Os4hvWOlqEhMibpYmurSdb?=
 =?iso-8859-1?Q?gyhDJ9FgCmmQ3Iq2suC5DcWXeQN2cvap1ruCMf4p4a58z338ojCKkFIRzH?=
 =?iso-8859-1?Q?H94MiI6cYRyZ1kXilnFpy5H0jMRt4ne1RyzAixtLdWGYQzjME5r45dcJvW?=
 =?iso-8859-1?Q?miUvkEZEDKwIec0+Pf6pUzJ5xSVnY+rgwnr54w17wb4/5VXsWok/2ZQm0G?=
 =?iso-8859-1?Q?hD3KzWrE6JJIzyrSYnkpoZSfUXvaQadFAPelUinKNLxZ5zHaDL3ou0q26C?=
 =?iso-8859-1?Q?Y3r7PIRArrKYatA8S/z8jAB2w0bCIEx+/fnlGpEKhfZS86cgu83p+pWyAx?=
 =?iso-8859-1?Q?UK2BokqVog=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 428e480d-67fa-4256-9ded-08de68843e8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 09:10:32.7191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tPfEPLMTLHsIR8Z6+UTZfQiR5s/T+wbahwiz4jg7pO8OQ5urdlY14cNI6dmzkuQftgH+CBcWGJqu6vyocWieOrp/Osr60/1MjcMQh8XfNoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8268
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

Adds read-only register masks for the DwC I3C controller.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 40 ++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 40 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 28da6016a1..87c8f63da9 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -296,6 +296,45 @@ static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] =
=3D {=0A=
     [R_SLAVE_CONFIG]                =3D 0x00000023,=0A=
 };=0A=
 =0A=
+static const uint32_t dw_i3c_ro[DW_I3C_NR_REGS] =3D {=0A=
+    [R_DEVICE_CTRL]                 =3D 0x04fffe00,=0A=
+    [R_DEVICE_ADDR]                 =3D 0x7f807f80,=0A=
+    [R_HW_CAPABILITY]               =3D 0xffffffff,=0A=
+    [R_IBI_QUEUE_STATUS]            =3D 0xffffffff,=0A=
+    [R_DATA_BUFFER_THLD_CTRL]       =3D 0xf8f8f8f8,=0A=
+    [R_IBI_QUEUE_CTRL]              =3D 0xfffffff0,=0A=
+    [R_RESET_CTRL]                  =3D 0xffffffc0,=0A=
+    [R_SLV_EVENT_CTRL]              =3D 0xffffff3f,=0A=
+    [R_INTR_STATUS]                 =3D 0xffff809f,=0A=
+    [R_INTR_STATUS_EN]              =3D 0xffff8080,=0A=
+    [R_INTR_SIGNAL_EN]              =3D 0xffff8080,=0A=
+    [R_INTR_FORCE]                  =3D 0xffff8000,=0A=
+    [R_QUEUE_STATUS_LEVEL]          =3D 0xffffffff,=0A=
+    [R_DATA_BUFFER_STATUS_LEVEL]    =3D 0xffffffff,=0A=
+    [R_PRESENT_STATE]               =3D 0xffffffff,=0A=
+    [R_CCC_DEVICE_STATUS]           =3D 0xffffffff,=0A=
+    [R_I3C_VER_ID]                  =3D 0xffffffff,=0A=
+    [R_I3C_VER_TYPE]                =3D 0xffffffff,=0A=
+    [R_DEVICE_ADDR_TABLE_POINTER]   =3D 0xffffffff,=0A=
+    [R_DEV_CHAR_TABLE_POINTER]      =3D 0xffcbffff,=0A=
+    [R_SLV_PID_VALUE]               =3D 0xffff0fff,=0A=
+    [R_SLV_CHAR_CTRL]               =3D 0xffffffff,=0A=
+    [A_VENDOR_SPECIFIC_REG_POINTER] =3D 0xffffffff,=0A=
+    [R_SLV_MAX_LEN]                 =3D 0xffffffff,=0A=
+    [R_MAX_READ_TURNAROUND]         =3D 0xffffffff,=0A=
+    [R_MAX_DATA_SPEED]              =3D 0xffffffff,=0A=
+    [R_SLV_INTR_REQ]                =3D 0xfffffff0,=0A=
+    [R_SLV_TSX_SYMBL_TIMING]        =3D 0xffffffc0,=0A=
+    [R_DEVICE_CTRL_EXTENDED]        =3D 0xfffffff8,=0A=
+    [R_SCL_I3C_OD_TIMING]           =3D 0xff00ff00,=0A=
+    [R_SCL_I3C_PP_TIMING]           =3D 0xff00ff00,=0A=
+    [R_SCL_I2C_FMP_TIMING]          =3D 0xff000000,=0A=
+    [R_SCL_EXT_TERMN_LCNT_TIMING]   =3D 0x0000fff0,=0A=
+    [R_BUS_IDLE_TIMING]             =3D 0xfff00000,=0A=
+    [R_EXTENDED_CAPABILITY]         =3D 0xffffffff,=0A=
+    [R_SLAVE_CONFIG]                =3D 0xffffffff,=0A=
+};=0A=
+=0A=
 static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)=0A=
 {=0A=
     DWI3C *s =3D DW_I3C(opaque);=0A=
@@ -324,6 +363,7 @@ static void dw_i3c_write(void *opaque, hwaddr offset, u=
int64_t value,=0A=
 =0A=
     trace_dw_i3c_write(s->id, offset, value);=0A=
 =0A=
+    value &=3D ~dw_i3c_ro[addr];=0A=
     switch (addr) {=0A=
     case R_HW_CAPABILITY:=0A=
     case R_RESPONSE_QUEUE_PORT:=0A=
-- =0A=
2.43.0=0A=

