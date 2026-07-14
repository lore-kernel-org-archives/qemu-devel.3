Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD166C44508
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 07:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjXaE-0005tj-Ud; Tue, 14 Jul 2026 03:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXaA-0005sE-8p; Tue, 14 Jul 2026 03:29:34 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXa8-0006VZ-Qp; Tue, 14 Jul 2026 03:29:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEt6On1AluUl4ZN/XTyYbMShTHFMvM01aYCN3lzOGqBAOWKnr81IcfjZjdbxzNood9j3IdDcBS82fKZwPYFC/pQai5YerMGWphUSPov+lBq0V4MNQyutSXzEAj22zYUlnD0RXyQvHnnPFoTSW9lauA3hslxUY8OxrvFFf8MK1a+83gK/13YCcn9xHGNuCMNSADR+Vnt51E0N4+boyfnOR8eiMnQendrhMQ19UN2URWDSJs2NYQN7KgcYviPR2ZJmNYGtuO96vGz7gXFgZHLCSa31GZM0V+7XzcY189Mg8nweZeOAUmtTexOnnxOmamWVmdfJ44t5qZ5M6UoEaL9fpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsaTGdeLZyrnDY0LG0GjDf9ChfpUTk1BUXSvdxJ8Lxc=;
 b=IKnxu4TbQi6rml/e59U3vsJW20PW2Y0TlX58QRaTySztxn3IoZVqlLQ21E8xpkXkiiRlde/fld/b07OPtNp7B6bbSW6t+7HPmkh7fYpNjc7mlPdgmq1/G+ZkkUGBtjbG6zqN2P+6F6a6KAt1sf8kdoanXB3v4q+q15U5ovfQ9+8rDv7O+c5Ilt4JLl3zulHv+u537MHFv+fr7FdvYOaWLkJqtDijcmQxaUIFk5SYcsOs+gfatbxYkl1NPe8NAtCA2yboWpOUZ4dUiEjq6ofx/dP2T6b7G9jgg351MBK3gEZ9mp/tA1DecLOc6vQqh5XIJ0guqlRch3sUicdD8KoR/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsaTGdeLZyrnDY0LG0GjDf9ChfpUTk1BUXSvdxJ8Lxc=;
 b=Qz8zkRgt+Pd5wQ/yf0Yq7i6TWc+VJ/9r/z4FQKBUiXmTA0dr8KpuvHTcsgG8grj95Rb2ezjoCdNfdZV3V53bELHYsGiNgRKdUfyZiEjSyM3j7cEMoF9+DzB8f3vsoxwpLH7w325yX8ZUsJcJ22MHoHBf0fh1xpZ+6F2yRs67esMlJT9WidqJWacmelRVWFEblPgzIWs9V+0x5lx3lyqwGiN5CK7a07lxUHVGYzsS6kIVfuNS2iIHBFfipe+rn2N7GxC8gTDF+N7NcI/dhcIBBroZ8LwHWzpmcTEk4EZKX0oCOzY1HJsInYjD5Dq8D9R+l6CWvuDRYtuNDgxQdzXE7w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB6117.apcprd06.prod.outlook.com (2603:1096:101:f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:29:21 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 07:29:21 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 13/15] hw/misc/aspeed_hace: Enable the crypto command on
 the AST2700
Thread-Topic: [PATCH v1 13/15] hw/misc/aspeed_hace: Enable the crypto command
 on the AST2700
Thread-Index: AQHdE2J8KmqrMPA/pUu7UAK+W1OBag==
Date: Tue, 14 Jul 2026 07:29:20 +0000
Message-ID: <20260714072900.3023742-14-jamin_lin@aspeedtech.com>
References: <20260714072900.3023742-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260714072900.3023742-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEZPR06MB6117:EE_
x-ms-office365-filtering-correlation-id: ad5c58b7-1c87-4338-faa6-08dee1799f64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|921020|38070700021|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: iuOD1QwQ+4rHNw+rhqDQfvnXPs1YpWoToWrVpt5rXPNIcgziTmrN0NY62+c0CkhLUdmauZGfOjZ3MoTqDuaauQrOasVXSGvDjzlrzYylQ+i0aI+cgwGNB5kf4nybRTOqD0BaPa4F1QjwUtYK5HTmffgivHxYk9oWeOo02swlgM3z9FFZMTND100+p5Wo7FjX3YTD8l73xoIh2nC7XEzgV14Rn9Y936PqbiUYlxMbdZ8icETVU3/ja/3Sbjw4esS1BfG7MUxZjo7SDvyOoBwY+VZ0DFdIkcTxYFFCRl9Zhkomp1hlqq2GeoFrqgYBc/pjCzR5QK/XgCGFt3KFuAPXu3gPV3Zt40BdruRLiAUY3P2itC9+WiCBCMYH4k6VpPblRVDggt83glmoME7v2w2U3cD7D3KyW+CqEKGq6yY7MIxyuUOWN88g1IpsitPix9DDJs/8aqY4adEj5vwsWAN9EVMvorBVtLF4TbP4oZVHIgCbpje861F6EaPIPFYHLsMPR7P5c/6RaQcP3FMgTE5AxANTEwZU8E/NzGW95dyANIcqCS/riXM40vHGY2eQ6w5Ub2zVM6aurw8511SGW4j0UM11K9ZV2El5LHeEyweITXkfB4soWzirwvaeDhbEjbdT+0j8VF1oP+QAqJyryL7i3VWk/NRJ8iUbVf9A1pbeTvdjLfHIyND74bmSAgRo7W6fRTf2Z33cUefWh/1PIAKoYoLTQqbwR8OjVZNuRfvWhq3oa7YiQdudtJe4FH02KsQ/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(921020)(38070700021)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SNDwZ5rNFfF3fdqz9czR7tDTGXI69ee1YDtZObWIODIXdET67M8NSEI5ML?=
 =?iso-8859-1?Q?WbGudxZgCflyMi64+ndeMeONog8lKnuGg82TT/E0kt6es3fs+EcPwLxaE3?=
 =?iso-8859-1?Q?2HQMEt1XpF/RJPNcKgiCTPg2w1Fb3P+eejwwHcFaw9BPYMMEC/SQnkbLZI?=
 =?iso-8859-1?Q?Z5zKuxIjw0WjSs0C07fYWx77ns7DKq5Yb95NeSH+4IOZ57qF48naeSR1N8?=
 =?iso-8859-1?Q?C5ix35mk4joeIIfbEjfJy6G1RNk6ioMJNMtl2thnjIy2k954KK+vjMN3dx?=
 =?iso-8859-1?Q?kKt9Df4Ecqb3MwuKiQKYOlVfjrvesR9p+4UKPvgPvgmH/f7g+PBl9jCEyp?=
 =?iso-8859-1?Q?qBFeiwMAhwePoa53hf1zJIrfq9J8lLJjXY8DAGz+pyk4E9CNHTYqZKmCQU?=
 =?iso-8859-1?Q?ghM1olPzK3haqd6OSExT/HkpHwRMVjC6Cu/CwyktdrIGqQEO3Zjf/j2QqU?=
 =?iso-8859-1?Q?Q0LEm27wPAP89oiBxEfN47gmU67qxB5SBxEswiNAHc25QQgqz+GBtmhrrs?=
 =?iso-8859-1?Q?seBbxhETHAjkEfZyCf/wMLmmh+XgaQ77RsEZSWcKjuIkSR9a+MuVF3H7Z1?=
 =?iso-8859-1?Q?XBhq2457Vk9nNu35hAwhaiTdC8gybgCWO9dRYbqQNw3NS4lxOCdqg9kt6Z?=
 =?iso-8859-1?Q?8G5rnSAc3shX0Mh1dFsHS4lax9U08x/H9kotDd9KGoWKchNDltqPlZaBX9?=
 =?iso-8859-1?Q?W3aP3Wt1tYEgOvMRXCKqZ9rtnVdYLd4CitrVCW3hbirT9gXC7PcAsZhvPu?=
 =?iso-8859-1?Q?c1GjvnhiiGMyWwyij6dwRSYYHbb7UMfKtv5Bl+qBYmzsL7aIsy/sCro1+z?=
 =?iso-8859-1?Q?u0vL2qiDdAjrZuvrGwb8x3eqj++UERIdupH2x8M4GQJHmYFBs2VxoQXGgB?=
 =?iso-8859-1?Q?I0eMlA6VU/leWEuJFbmleP893mz99rfOA15jjk8q7tdgD94pBrWapRYHyK?=
 =?iso-8859-1?Q?idMKxmQanxXSBxb3k/MbCQGy5rFWyZUD/MOFTMQDjeFviCIXt4sU3n26gZ?=
 =?iso-8859-1?Q?27UgnWc5UhoCngaGuLq/SGcHLo7I2rnhHnjASolHaqQRGqeG5jiYIJyQJk?=
 =?iso-8859-1?Q?JpkRRZW0KczvnkR+I+SHJY7lCmWqbioiHOwyTnBSE1SoWPR4WHi9i21k24?=
 =?iso-8859-1?Q?ox9IaydpT3yx/e+uQUG3CXuVm8+7MAxvzgHrFec1iz3SvGcgiSSBbw3v53?=
 =?iso-8859-1?Q?5HmAbqpS/u1GKN6UAGAKZVZYba7YeisPiC1gKWle1TOzeyI5ycFuYBlsvS?=
 =?iso-8859-1?Q?7q78dC4q6mGTzyAE7I0Y7BK7ktt8rnK23gikddXfNnGu57MHRsY6kVR/Id?=
 =?iso-8859-1?Q?k7dfDFEh9q97q1tD3Q52FrNE81ucoX6n+hi1SFkcLkDs1ZWTvrHM8qvZcQ?=
 =?iso-8859-1?Q?+HeODhEvsrmq4HJHh1IxbGHIBqpE9vqZfrP2lNF+x9PRncvqeNOfTykiKC?=
 =?iso-8859-1?Q?aZWgQ6Cef4f16tLf3OBVibceou4it1NSuxgGRHEz1HD+d4+pSzcIk4dYA3?=
 =?iso-8859-1?Q?4d1K2JQ5shUU3xGt60Ivw3dPJICPeuWBz+PgS1nPn3jUKfdyLRoI7MGyLY?=
 =?iso-8859-1?Q?MaNvd219jZsa70noIxpb/CFzejcyDBRcnxZWeMRrtY33kWJnByvKVPdhZ8?=
 =?iso-8859-1?Q?ZoBzWvRfhMPVGolRI5v8z3g66KccHgzqD3qL5nsPKsVTTk8SR62ws5kaQz?=
 =?iso-8859-1?Q?t+f08y6QpN7ZKJKmFsZ94PdanoX8KKxDse4FsV3KBTU47sYdz3WbEdAKlh?=
 =?iso-8859-1?Q?siESy9IiJ6OnXXyq+Z/NJObE9tur71QkspPB+SVpXKownp0eoUYQTmTKB3?=
 =?iso-8859-1?Q?6UDojTeY3Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fsE9rjlt8UQjqeCSsfa+emDSDCgYgMBEvImJYQKIgASUBkumd+ZIOwNpwq5lclh65Q6FldRyUk2c6fAXeIT7177JTqXDfWfqrrzW2rzXKJr5+YDXXsj3RQ7QNIb2MHiCT5330mS1M4xb7MULu4nGJQrCftdn7gHKEX3CyjyIFuMmq42layonY/Yn+3HgerKMYt55W0MF03Jc4tMvjEqMtMkceATxxcUdXJTkW4vdPRswmX1zo2FhTq9tgHRs2WmMv3x4/AQ557dXCburNWjY1FmEqdfZMVsntfa7wB3kV73y5bx8kVSOCBbI7kcXcSKrUCw+1rwpJlxTikuD7S0mQQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5c58b7-1c87-4338-faa6-08dee1799f64
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 07:29:21.0501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XWSheJpEiYa6lFgvJGaZ2WwAU1PLywz1/6InUibFcATJQynTJH7/Qt4+C3TpYMnFebHfPPv4OvrxgXfjRGQ964ezuMY0gKDT4kSFSDivuc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6117
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

With direct/scatter-gather access, 64-bit DMA and AES-GCM all in place,=0A=
the AST2700 crypto engine is now fully modelled. Drop its temporary=0A=
interrupt-only workaround so the crypto command runs for real, like the=0A=
other HACE variants.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_hace.h |  1 -=0A=
 hw/misc/aspeed_hace.c         | 15 +--------------=0A=
 2 files changed, 1 insertion(+), 15 deletions(-)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_hace.h b/include/hw/misc/aspeed_hace.h=
=0A=
index b5416b0cb5..9b0e7683fa 100644=0A=
--- a/include/hw/misc/aspeed_hace.h=0A=
+++ b/include/hw/misc/aspeed_hace.h=0A=
@@ -49,7 +49,6 @@ struct AspeedHACEClass {=0A=
     uint32_t key_mask;=0A=
     uint32_t hash_mask;=0A=
     uint64_t nr_regs;=0A=
-    bool raise_crypt_interrupt_workaround;=0A=
     uint32_t src_hi_mask;=0A=
     uint32_t dest_hi_mask;=0A=
     uint32_t key_hi_mask;=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index b84f83c0d3..33b6861523 100644=0A=
--- a/hw/misc/aspeed_hace.c=0A=
+++ b/hw/misc/aspeed_hace.c=0A=
@@ -998,14 +998,7 @@ static void aspeed_hace_write(void *opaque, hwaddr add=
r, uint64_t data,=0A=
         break;=0A=
     }=0A=
     case R_CRYPT_CMD:=0A=
-        /*=0A=
-         * The AST2700 crypto engine needs 64-bit DMA and AES-GCM, which a=
re=0A=
-         * added later; until then it keeps the temporary workaround of on=
ly=0A=
-         * raising the completion interrupt without running the command.=
=0A=
-         */=0A=
-        if (!ahc->raise_crypt_interrupt_workaround) {=0A=
-            do_crypt_operation(s, data);=0A=
-        }=0A=
+        do_crypt_operation(s, data);=0A=
 =0A=
         /* Hardware raises the crypt interrupt once the command finishes. =
*/=0A=
         s->regs[R_STATUS] |=3D CRYPT_IRQ;=0A=
@@ -1209,12 +1202,6 @@ static void aspeed_ast2700_hace_class_init(ObjectCla=
ss *klass, const void *data)=0A=
     ahc->dest_hi_mask =3D 0x00000003;=0A=
     ahc->key_hi_mask =3D 0x00000003;=0A=
 =0A=
-    /*=0A=
-     * Currently, it does not support the CRYPT command. Instead, it only=
=0A=
-     * sends an interrupt to notify the firmware that the crypt command=0A=
-     * has completed. It is a temporary workaround.=0A=
-     */=0A=
-    ahc->raise_crypt_interrupt_workaround =3D true;=0A=
     ahc->has_dma64 =3D true;=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

