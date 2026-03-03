Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6D7EB364A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 01:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxEdl-0003UL-OO; Mon, 02 Mar 2026 20:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxEdh-0003Tk-Vm
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:33:35 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxEdg-0002EW-LP
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:33:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlINJEduh0jEmneTvsnJBAzM34zyK2D5hLjGrWhuD/uy3HSb1qf8FrlcRkTI4TQ+qAa/GwYZUNRKlv2ACuLXxkceKrEcDykxr2+m+YfqufOjWEm00nRBTBs6KlPowuWuN1B5AXZlWKAGRhggGxFdQz400sfOltWe0crL4k5fLHs0Ex4vAmrE7NJfdbTOGrrzWRUba+1goNy2VPF+GRvckPAqN2/uSkVnUwp+tRv50oOloIRr0oiP9b5XiwNTpOQQJyegBftjN72/0R05KTRg//A+TOvE9rRTC+YD9z9LyhVYjZQwJqkm+keE5Cc/t6W8523eQxW5S/jSfhOOLUQT2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+GR2S7YkbEsBdgqc3Yoq/8fBKVYEvLAthdvH9b2SwQ=;
 b=N37Pglh8NwX18KLWT8DhNQemCuZvql3i+axqAWQrPnTwA0d4df3RMfwfSu2QvEkHYdQq3hmDrBigS32QBaT4bG28G50ucP8l3EIJnhCUUUr3wKx8np9pPYCJpD71ufHBQth8b0l03WAoi2aPIpnOk2Vb3sA360LkRBkly46iYUyh1DTcP7ebSnb5/+nvvJP1tKYHb/RVp188MHDcEhEmtWeJGupJhmpyXHG1mPI8fhrn066j/JG4VNWhyA4TDpgTL7IllcSWMTkIUNAVRNVMZsao3a8Qi9tZNs5TKjuSnrnViNRVJMxqZttoOlsr31XoTkAQehh+XrfjY/+mR3eETQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+GR2S7YkbEsBdgqc3Yoq/8fBKVYEvLAthdvH9b2SwQ=;
 b=MV3uX+/i+N3OmugehZ2CptsgnErHT30UTf4DrKxlTcRRfww7+fDgAv8htv1/WSzmt4w7djxRX6227CKnu2yARzycjBbF6oCMRZ8w4+gIL1wSPW/MygnHWlhOfj7DSA0ePFPu8tXZQ05mVRPYCwRpZsbCQ73oLFkv5Fismjxt1STDDpKR7L8RBA1pZFnDc//RG2Cf6CoiJrlzJLgU4UeALU/3Df8swL6pXI8BsUdUo1l9HRKP2pMjmCY+mViEKIPAIdQfZy8Y6BFmzzbbE30skkWyTdZHnCBgsEhD151QNPVaXoLlR4P1v3qUnGE5TudowWxwzy8t/iPk7IcRMn8OFw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by OSQPR06MB7973.apcprd06.prod.outlook.com (2603:1096:604:429::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 01:33:25 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 01:33:25 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, "jithu.joseph@oss.qualcomm.com"
 <jithu.joseph@oss.qualcomm.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>
Subject: [PATCH v2 1/4] hw/i3c/dw-i3c: Use ROUND_UP() for RX buffer allocation
 alignment
Thread-Topic: [PATCH v2 1/4] hw/i3c/dw-i3c: Use ROUND_UP() for RX buffer
 allocation alignment
Thread-Index: AQHcqq26TxDo8hMDak+MUH+hFbYV5Q==
Date: Tue, 3 Mar 2026 01:33:24 +0000
Message-ID: <20260303013322.1297499-2-jamin_lin@aspeedtech.com>
References: <20260303013322.1297499-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260303013322.1297499-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|OSQPR06MB7973:EE_
x-ms-office365-filtering-correlation-id: 9951bcb3-befe-46c3-6193-08de78c4dcfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: ErQCeQzYpgEOvH3+EMPvEvTVnUAK0zHAjKebSR2HDJt2PSdjuHpj8T74mVG1Whfp3c6hvdd6DFSJoaI09XfLf9wbzsVlQR6GVbIx5aiAtOpJNZgCnK/+OaTqVDxnT4eN+KwEOQ6ZZkpp8448dyLPpIQi/EBE3bZe9F9o7eyiVGi1i52OFwHQd61nF9zMBLfSWf7Db596W7r3aiN1pLKaJMXmnzYOTiSxtLDWMY0X+VdcNkYwb8IV3XgU1N2mOFhB/xoQe50TVWhCidMTXryrYU8lly1IKw/iDvhO75MG1n9g7oi9+4RtPWklM5WWOOOya1mtpdBwJt56tOTam+gf7cS7Smm3QWqs2TFqaXVgqrtD6RGU2kSbTKvTdcorJUYfeeWQOkYfHS0MoSMFSGYtV/9wJXtlk7kUO4+4evxSmVGsc4sMgOj9BLlSQlPx36+NHVpfCUVUJKLrCkeVo8HY6GOa6aRYokM6mhYXmXXjggTfOlNdGSljRJJaPHtWumIfQs9cgT9eHV5OWvBCzQgWq68Q9HDrizfEL0DP8BVzI6TIyLy7Wnqb5GjmLFWY2xNY/CrlUSft/pEig4AaD2S3PDCMtYPERJmxgwIIcqgnDk0lwt1XbW/20BR1olqVJrlVX5p+Ovnp7Lbh4blaHHNMsfu8lK/t6f3+NxYio7QKInP+LmOYYp5OXoiLgjNxIK5LT7RUGYhooGAdQyjZw/kvU25fLc+vvUtsmroyIoJmglNN9gXg3f2/+P5SmrHemBETGb9KKVPjpswfWnYksdIYbJ5bc24f/Z6nF2OGnw9Jiso=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uVpWr8ujUGm8d/6fkp1XVV4Pcyh4m9HQya0pNZ8tP3B5TLH6+QACVc8Zsj2S?=
 =?us-ascii?Q?i7D9KKpyC3rMf57rCxyx4Zpl/RV6jQp5WlUaQnzxHB7KN8mSVCIH3wwYGSUM?=
 =?us-ascii?Q?NygmiidxOR5VA4RxcVaa2bUe3OFanH9ikWCKqKtcJZM+VbBFnxETfON2FLH6?=
 =?us-ascii?Q?fXvsV6kzrRridjsQ6koDIPJGoHMQBSNRTkiEvAQXEo1eisXL33t/38U6Vvyt?=
 =?us-ascii?Q?H5diQy5eqgSBZqUpmGPFvidaNshWnGLjxHq/PqafdRgwFp0dmYMLqZZ2lfW9?=
 =?us-ascii?Q?MlaAHrZpJibe2gyZ3SYltlnjxBajUEmx4si4DIkwtoUqH7vCm74zJ89oS0wA?=
 =?us-ascii?Q?oUeRMjfR1JVN4Ld4JXaNucL0xpp6HQMyf2cf8Hqy8UO73hUFaXAxiWLB6laO?=
 =?us-ascii?Q?ekOHxvp+HNFKWzzWwunODm7omcNaFHAkoHq8FLYuvN3XUoflRIwntKtvSP9y?=
 =?us-ascii?Q?FxVKjn45R9S9Rr73YrixsM4gGvxz9zBRv2mnv9C78YOCJ97X7a+7YH43Av5N?=
 =?us-ascii?Q?fxzHpl6UyTbLNZr957mN7eeH5SiiyRmjeOU3H76qrXwimbo2aq3PGqhrazyc?=
 =?us-ascii?Q?FVRXdq1FjiXQ014ykBTAAT09TLRGNkmzZtMTyOfwZSkiOcChagdQ2kPzm0Yw?=
 =?us-ascii?Q?5FLfrGxQjBsUPhpk/lj3twyGyUZxg+hQcAqU/n/CqLZkJct0g5yuDP8UnLP3?=
 =?us-ascii?Q?Xvy35Ar0v4HgSg/uzYdhmg7kBh3DW6kJIE8mO0SdPlBGrWXPvT1UzQWrOQd3?=
 =?us-ascii?Q?iVJok4NAXxIHG/PjyiiMv03vLPQNB8JIiZ0e7CpIn98TZ8ciqlxa0b9IAye2?=
 =?us-ascii?Q?IIByub3qJZ/EsD7s3xv2bbvAfc8eK8IqslZ9WV7eCz6D2ZhAXBkBGXbxMmHW?=
 =?us-ascii?Q?GqTVkOFjCyOMfCyAVykcYDVcP82K7LBly+4ZJbjt2RTvJU0ELzLxXd4XX1yj?=
 =?us-ascii?Q?wuGtsbeUK9tCMA2juWQhWm4aatEeRKTAZN9xdQLc1nwn9LJEa40Btz975aTR?=
 =?us-ascii?Q?BsPW40+10mZI04LUnlreuXoKklPegCsRexm8FLgMnzhxstYHMtH0kMnSHjQ1?=
 =?us-ascii?Q?SbKKXtQM8XeUAgT9Gr/WnGoE6iFu7D9nMt9RV94o34nDaUIJB0MTLzP5GepQ?=
 =?us-ascii?Q?rXWx0VGNC7T2CJmSe59pxJPnD/xDLHwTmqYJFLiJCcJamhaK0XtQVe1ASOhh?=
 =?us-ascii?Q?3EJ9Cd2IRM8V3JSlMjvKLi4TErrnQ3YJM9pSyvdfYLATIC1ldSuVRNbSIplH?=
 =?us-ascii?Q?qkcqmfLT+O5Th1lfIobzn+OrU89vwNX2wRmQmOBaKtCeibmh7lBBmhQN9ldd?=
 =?us-ascii?Q?hkkv9sZof3tau8LUdx2krBr9UgmcbFSDbn72DOz99YvSCPGZRd0MxccYrh6I?=
 =?us-ascii?Q?tfTa1HB2LZPHY9aehA0HNM4AvfLxPQd9342UVCej0L87w9+CCLS3RdBCrwo/?=
 =?us-ascii?Q?uFOfa5fmJ8IFJ/C+LrkhFaUZilAcnDtsj5i3ON9R3dO8POGMzW+kW8hmB5VN?=
 =?us-ascii?Q?E3EMMObz0cuP81MoNj9WRy0c44EvxQqZssBGyhRTq76fP7oG7uvzG6Jap4MH?=
 =?us-ascii?Q?ONhO33ffYmmUIocbUj2JKAqkgzrWClRYTAM5qYS4zZqJgPG/dTL3nNoxA7DM?=
 =?us-ascii?Q?C3GQAMp0b+cQTawR+nYpcgXAiHJnU5sMOOrVfHvO8ZnUN3ctUujfYrV9NrZZ?=
 =?us-ascii?Q?eDdzdJJrHs52ZFl+ovb4ZytUwlybegLAZStAdlHk/gIaB+68bNxRgB7IIHd7?=
 =?us-ascii?Q?DHNmbasHAA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9951bcb3-befe-46c3-6193-08de78c4dcfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 01:33:24.9657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wffh+Lor5OwP4v9+7nhSAjGWa+skgQm2jrLjnMPtzqYUogBnRQWlMCvkIFe8XjU9PjnlB8uCPeaGK83YSKPc7Iq0Vgk37z3D6k/ecUV6DrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7973
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

The RX temporary buffer allocation manually aligned the size using:=0A=
=0A=
    num + (4 - (num & 0x03))=0A=
=0A=
Replace this with ROUND_UP(num, 4) for better readability and=0A=
consistency with common QEMU coding style.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index d742458129..3d8b95a14c 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -1282,7 +1282,7 @@ static uint16_t dw_i3c_rx(DWI3C *s, uint16_t num, boo=
l is_i2c)=0A=
      * Allocate a temporary buffer to read data from the target.=0A=
      * Zero it and word-align it as well in case we're reading unaligned d=
ata.=0A=
      */=0A=
-    g_autofree uint8_t *data =3D g_new0(uint8_t, num + (4 - (num & 0x03)))=
;=0A=
+    g_autofree uint8_t *data =3D g_new0(uint8_t, ROUND_UP(num, 4));=0A=
     uint32_t *data32 =3D (uint32_t *)data;=0A=
     /*=0A=
      * 32-bits since the I3C API wants a 32-bit number, even though the=0A=
-- =0A=
2.43.0=0A=

