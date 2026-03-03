Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4469AE67A6B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 06:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxJQ7-0004wy-R4; Tue, 03 Mar 2026 01:39:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxJQ2-0004vs-PV; Tue, 03 Mar 2026 01:39:46 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxJQ1-0005qP-3O; Tue, 03 Mar 2026 01:39:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6a7ioL0wzWRlCQ0VBggJFnmHdlAJTvyCnBQcEWh+Mh7MwKaCPfFGKVcvn7NWb05wNx7qYksJn4vV80UfL9ldPRrgdOM7RCXr2W31KWgSVmWccHwNkNGaFJZpyOfPIyRRuSbFnWyyzCXHHhTXMYBryrri4UjFuw7AGuJLQUN5GSISoveXvIYd0lABCGKG7PwSSQNOyzeQo2AiQ7L0sJ0zAT4R8N3ucEqWmo7lyqCveg8bg+P5e6dNhiQ/O2UIhAVIq9BXGAT/fkvbJkLOs6kaQx0BmTt/C9TbCoXJGSMqJAK4jHNWj4Yl9e55XTcU+KJaG+duZWbrj27e6SR5IpwAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTJvJ+wOxOBqUQ9X6N40AJPmKD3JWmKlvDU9E14Yr84=;
 b=BWBphHzu0YIA0lRdKGG6xDhyXt8mxPTDivUIgU425f/jtcIeejGqU+qmwQVR67rKX02QFh/246Z9UPET6QFVEseoESPtUcmIl1y1XMy7RiFfZe6qUsnopWPSPqazyud69OHqPI2/udwqXp/8NknpFmkChnEuA1eGjS7HMqG6baKI5/nOaEdF9mbSZGSFnWdwgkeWJDXjL/bhEkpcz1ugQpjYqx82ydD33+wjhWshQQ/uvl/QvxKMcrNUJvD/DziicBSpZKNHiRGI4+XJyLWk9Nxcq7LDTJRDqlETHIaL8ximvO5q+rKZvK+nvUNbvNSTulgzzCEETTEfcFdBBJmVbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTJvJ+wOxOBqUQ9X6N40AJPmKD3JWmKlvDU9E14Yr84=;
 b=ZRsiamG0667eBdCD3kLanC0+XynMaDYDBdXKDZFNA5PS6vJx/UWa1VLlxidBFj9eBHwlEUVZv0W0dTUA40y2FZJh+FY4iUc36afxADypfP7R+cKCg4d8RLuEOD3nodEbdEOX7TdHHrU8qxyeK13AMEX/YUpRBE+v9RZdM+QIHfjfl7lwIq7Tk4ddUUi5gLR5Xtpmc6blpLYrfeRF0ZhxEBDjO51iIH4A4BgD+eymQF0tT92PrsP5Q1IPD3TgEc9n1YweJi4AafKhyzop5lu1/9yBEedgGTDpD+fMHmYJBBrP9ApulBBsQmGZbD/XWbHyFQOoW0otmpa8dRCQDv0/ow==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY0PR06MB5459.apcprd06.prod.outlook.com (2603:1096:400:31f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 06:39:37 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 06:39:37 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 03/10] tests/functional/arm/test_aspeed_ast2500_sdk: Update
 test ASPEED OpenBMC SDK v11.01
Thread-Topic: [PATCH v2 03/10] tests/functional/arm/test_aspeed_ast2500_sdk:
 Update test ASPEED OpenBMC SDK v11.01
Thread-Index: AQHcqtiBuReSII8XOE6XQb9jAYEPOQ==
Date: Tue, 3 Mar 2026 06:39:36 +0000
Message-ID: <20260303063930.2878300-4-jamin_lin@aspeedtech.com>
References: <20260303063930.2878300-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260303063930.2878300-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY0PR06MB5459:EE_
x-ms-office365-filtering-correlation-id: 33484c5c-e04b-4949-c6ee-08de78efa38b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 9gTukF9I1u2DrvQdys9TbqcLO84fE/qiQ1qSKpWFN2A2soOjE6qd5aCEloGmMYdIT3VpthxAegpNUjFdZ+pN1NPfZqRpnaKfEvOl4gna8Xi4q5CdVRZ8eNi83e7zQ9Z0XN6wE6CjKvKWARKopSjurjv+GxmkmapeNXO2tTAF5RzzwES+72h7ozmZduTff3/Z+6feCdn+fV80UZcY4HeCjYeBYmQcLp+yYWYJG1Fdzr4Kodesg5kS/CrVgB8/cMOnHLZShVfks6Et7SaMFxnIvLNiOGlmJOi1vAql5+6ZPzmnRw26IINDIkq91RZyZ7zpmWo1irKH06myaPSi7x+VebE1v6gmogQMY7qOnT5aMbG3pjUbWKY3fsFpyzjOhPYIB8NQbK2gwmIekbNGk+HbH7IyeQa29MWWHzjlfPa+tBJB2/eAabL/0xZu4oi4pAs44dA/it5mDWHZkVMXmtcngpqWsUJKkneAKtETEjYv8wYpM43MmFB5ocM6ckBIt62zT8V+hMQv8z6L6BVeSWHDIVFWwCsRFi6NkgWGUdZRzs2/CBYrF8KtUEi0TApMsJRPqVHnwexe+kWYBCgphUD2vfCF/F/K8cPXCrGzVo6k+dFLTcPo4aniSVPbLIZGQPMJmqcprhvRPLqgWxUfDNpSAlXT7IgshJeERcOby/CD6dLFoFC344mIeKuhcKu6X95nGxPeR8NieB8PsVhUbX1U5sfoN25w4KqJ67rkU3kzKy06n3eZW1poaStD9GOVpr7j
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lPTEp7rG/2pLL/B9W5ccIdJ9SYUgjTWPTV+x94njxCEHypZYZpoA3GbjKQ?=
 =?iso-8859-1?Q?H+WCr10qlhbXk6gL/tzgf8tmD3lM4TPCDhwtN8+E1iISFlR15HavKpTUb6?=
 =?iso-8859-1?Q?SB6Gj/A8RzG2SLPE2da8Q4JlEmmLLQbauz+4+Z1cEpPY/XK87dWgL0ElEU?=
 =?iso-8859-1?Q?sLfzSfEtv3BVvCk10L+sOOavmqYtilOnm0TFdSdwjzlW3X5xge9Q1pgEMw?=
 =?iso-8859-1?Q?LBh7lkX2T4RjF7XlppFu8ha4XioEYV/bpqy1iIW0eX9W5O5nOnTes3QorO?=
 =?iso-8859-1?Q?KTwLaAvvHHAi90JWICA8YuQi6yOBd4SYJbILifnDBkpAuEWB+PCRKODHPz?=
 =?iso-8859-1?Q?udno+ZY7V5m1yJNJOybIxMdX4mB58pTqQqqPJGo6Z1tK65ITc3bpjqSCpJ?=
 =?iso-8859-1?Q?Mz9K0WRapR7iDff9UUE1Q4qtqiWG9cdRHHhYmfC+/dRaoM6VFSfFv6C9jJ?=
 =?iso-8859-1?Q?YFS7+cRl26v1RsmBhXaqxLUh8Mw0z/KB8TIurRHtfANIRLkUa2/7egKXwl?=
 =?iso-8859-1?Q?3gBeXcbd9kyETU2YeZTLxHyJ8kVXQ/9HIVwfiSUXIRLAb1mzOupKUIoosX?=
 =?iso-8859-1?Q?2czR6w5QKGcJEOPkubPVo9fwqkN+tK8U1lFgko21I/VPCj4+OqzVEaJPPQ?=
 =?iso-8859-1?Q?Kpbx4bMBrZUSO0tPMtzoMVF9wU/vU8a1lEOB5M0Yti8uUTooiNwvSfs22+?=
 =?iso-8859-1?Q?U25xZPfVeY6FaRE0X1KJwbdmObZtvOszwOQwANqqR3fQ0LW50mYVqkmzUQ?=
 =?iso-8859-1?Q?MR32QU/DzGjhHlJks/obhq4iyzgUaaCT5WXvSd1MBDwJZYgiQhp4acBa2r?=
 =?iso-8859-1?Q?x4eAGuTVxb31GbGmwhZve+hhBxEvyPqpJZpKrrjE6vobKFyXgCvSHpsPEd?=
 =?iso-8859-1?Q?fTzFjWD2nyCTGuLFQJurgWUOjDV2Wu6cl/QF4eMZdSa4S/EbrLBpll51a1?=
 =?iso-8859-1?Q?XtIhl8hJvBqcXisS2QY10dLUfyEKHlNs0BNTC2i6jT8AMUpoUq1RMtSg05?=
 =?iso-8859-1?Q?ovaC2OIL7fLW9YbQH0lo9gVV5MVxfr113VsUgSv/rmAddbZJF1MzeC2+Bt?=
 =?iso-8859-1?Q?H6kWbFbQzXXv2qCgckzdgdcjYsEe6uFN0Ue2jB0SIKbjYBNchPie2O6IhR?=
 =?iso-8859-1?Q?/53ngMQGlLgS2tAi/ZqhNr8rp6heRORN1OhwIEstK4SC3Rut31XRawKbDr?=
 =?iso-8859-1?Q?vUZfuVzJxgGa7bNixKwsuQHZmn9hpTtAQEed1UylTxVeK+7WdNuDOLdwX4?=
 =?iso-8859-1?Q?4lSlIV1jD+YHJxq6yN42DDZNggc2RmqOXhSYYeYjs/RY4JVo3GDf8YjExB?=
 =?iso-8859-1?Q?Ubgl//l/DP0v8UzQpImHNCoKstI2SWMtNr4lUcLv3BhNhaP4w6RmBC9k9k?=
 =?iso-8859-1?Q?d77MXxauuSHhzZTgKXHb7Fr2aLBE/nxlRk57gnANntbXptAvtLUkn0TTdl?=
 =?iso-8859-1?Q?f5M94J2zW3pit5xJh9jww2/QFnAjTpFlyvOrxGCQyw00qt2EwWHeDKQ10G?=
 =?iso-8859-1?Q?EUbHpAFrylbbu0wuXOTeU+hPACUeIrISqhmLxXlVuzittf9X/nygR5eKxr?=
 =?iso-8859-1?Q?AYK7ZIG0hpsopkq2oFkUe/dUsk5xoiJbkfZhjQ3C+pvNqMOhrsgUSZTAe1?=
 =?iso-8859-1?Q?E5TDHf8Rw9/NKBjUMsTkPs2+v3UOW5pDVReBCunBViDYTg3JMSNhu9tPLv?=
 =?iso-8859-1?Q?Gu153oQ1JYoOMccjDn9gu2GdMn4nVQvsjhnAyh7iDNtAUSjqvevs/rPd4R?=
 =?iso-8859-1?Q?L03NdgrMSrtIOeBMtaHXdW038UOt674kayd7FDlGPWHlMHyhb5Cfv7KnOl?=
 =?iso-8859-1?Q?Fgy/B5Vbxg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33484c5c-e04b-4949-c6ee-08de78efa38b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 06:39:36.9413 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z0oRRoFBPw053mAGc3v8AV4AdkNz+6nTrU28aJIbFlC0ggj/OUEh10sYWNmZzMity6Nv7y6RyrmyQNOP0wHp9BPHKZMVrHBT+Triy8L8KXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5459
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/arm/test_aspeed_ast2500_sdk.py | 8 ++++----=0A=
 1 file changed, 4 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast2500_sdk.py b/tests/functi=
onal/arm/test_aspeed_ast2500_sdk.py=0A=
index 2c9211aedd..5ab36b99ab 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast2500_sdk.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast2500_sdk.py=0A=
@@ -10,14 +10,14 @@=0A=
 =0A=
 class AST2500Machine(AspeedTest):=0A=
 =0A=
-    ASSET_SDK_V1000_AST2500 =3D Asset(=0A=
-        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v10.0=
0/ast2500-default-obmc.tar.gz',=0A=
-        '7d71a3f71d5f4d9f3451f59a73bf9baf8fd9f6a24107eb504a3216151a8b2b5b'=
)=0A=
+    ASSET_SDK_V1101_AST2500 =3D Asset(=0A=
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.0=
1/ast2500-default-obmc.tar.gz',=0A=
+        '3faa1188198da2216837be4b53861c483a58c3ad63784089720bf8421e157da1'=
)=0A=
 =0A=
     def test_arm_ast2500_evb_sdk(self):=0A=
         self.set_machine('ast2500-evb')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1000_AST2500)=0A=
+        self.archive_extract(self.ASSET_SDK_V1101_AST2500)=0A=
 =0A=
         self.do_test_arm_aspeed_sdk_start(=0A=
             self.scratch_file("ast2500-default", "image-bmc"))=0A=
-- =0A=
2.43.0=0A=

