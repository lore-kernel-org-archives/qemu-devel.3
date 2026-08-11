Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D32C5AD55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 03:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtctB-0003lZ-Ll; Mon, 10 Aug 2026 23:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtctA-0003kn-5G; Mon, 10 Aug 2026 23:10:52 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtct8-0004L5-6g; Mon, 10 Aug 2026 23:10:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNhMbth2VQzlx9QJu3UglnTuUEwTfEyCwLG6r3D/fXjcqJ4J37M2JnmEi7N5JNLk2W5dbEJkK2ExRa3DDODIvmzLg7s76INKyiCfCTlslWrk0GKzVFJjiPj4+1e4kHI2BCj0BhcdE6XV/6TYjYC5fgGP3tsR/OdCyTfGNxfTTFeP3bQDcxHARfqBBMYcBz/xxr1HBt/e+dpej9xJnR69GwNlW7sYXt8qlXOrWP0+wP2nOekXfI2qAsiMTRfCDNtgmvpXofE+rYOxQ9mwSHZxDU4SXC6JqP4AI1TUTz1L8rrS5De96DB9kzeuuQucpcErT/AjhUiL2XK7f0ctWObg5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MExgluedEg6+JvI+ulgp6DQLZn4mSeKDSDWwe/C/N/Y=;
 b=keXBF2pMxkYuiw3NJBPNzFOmyj9DgyispO2BQO9OuOyicQw40M5ZCta8uimpA8vtiF9bzwf01mEij4zntHabzzNtPgP2oysgkkT0iHnGq50qZwtlX9G93yLYZJAvZ9LKEi9XAJ1Hb2d30C/EibYbgwQsoCreGvDPA+67ORefVpLxwS/9eg3i6chvLevEQXWSoILb3QYS04DkN3y62vjpLOzaG+zyiilaaNtqQDpKGAkUlH3PPkxeMncUoZfxZ6GPX+sQjjGSHUi3D27qDBT88lVVh6GUdw8f02gVmOCQCCQiTSn8mFdjRs/P0bNxINqhje5fRtUVoXqVmCGE9DNvVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MExgluedEg6+JvI+ulgp6DQLZn4mSeKDSDWwe/C/N/Y=;
 b=TN17pIRW+TNC9HcGMCkBkjyH1SNfm/6oWpqat1eHucx7q3rlVTtF09kN+JGdzA6AMLHLcroDohC8bAd9aOBaM6wwqudDV0CgAx7skFndILlX26siT73zo0Fgq3buV5ig/uzmFuBB/aHGrgpBREEtA5V0fN2tVQPcFeAwD+T37j38wQOOXhjDbHr6QfaBXVeKXFkwuIZqTFI/M8v/+5hg4RQpgMTpVwVF9s+NrwHPCmtR1XLtV8i2lPriag1kjH2+0Lk0lsDR4TZSBwln7HDk4kjynS3vZhKjGHTDKO2GR9i3pBPReCN6YzxzlqsyBKbZdiETpnZaySYSCAu4/KlpRw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5808.apcprd06.prod.outlook.com (2603:1096:400:26a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 03:10:38 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 03:10:38 +0000
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
Subject: [PATCH v3 09/16] crypto/cipher-gcrypt: Implement AES-GCM
Thread-Topic: [PATCH v3 09/16] crypto/cipher-gcrypt: Implement AES-GCM
Thread-Index: AQHdKT78VSSvmFTfqUGAlnSDnrDr8Q==
Date: Tue, 11 Aug 2026 03:10:38 +0000
Message-ID: <20260811031025.2784489-10-jamin_lin@aspeedtech.com>
References: <20260811031025.2784489-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260811031025.2784489-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB5808:EE_
x-ms-office365-filtering-correlation-id: b2150a7a-d132-4103-cd0c-08def7561ea5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|22082099003|56012099006|18002099003|38070700021|10067099003|921020|6133799003;
x-microsoft-antispam-message-info: sknqEfVhTFKFtGRnLFWzVAYg5LgwH47HixY4C/AHZusUHIHfSYU+/SDjgN1iyrBNO4AjNc6vhMZdbnkaPcp1/01hfODz+U3EbgepFB0nw5vyQypirHoAec1MN7DEF38X16+Qgw9OzyAXZCfLsd580S6At2fYmpPA9/UfqjNB3ksyRku9wE1AA99skip2TBPzuqRkjcnkWy/n4POTBsZSEhM/8+hpTaIXR43VDELVZg9HQBNEGlYVcp0uL9eDLGCzs0hOGzQ95ZKYcbDFRdz5rMU4vcW6W8/FK9RbK6MZZW/V7M0FY8U2P1b4AkpzxT4seZYDSdktHYh1qGEBJjop+6zGWfduYkwGanpVtnpYsX/LlhpEGnmkHSBZ6p5BsK/L6ekswSuzu6SDt9oBxat3l39WYtHGE1h3+8/MvaDug13nLfJ2UKG7+PvlEMThbiHNn/svca5ywqwVMRftkjAc0QB/jYqi6PyxLQFaZZZ5CjLm75NQkMLH9rGgoysqZ7jaf0Gdpxocez8vM4fea/rUFRSrGUxhu9/OSqrXWi5UNfCzhw11rPUxZ49CXP0v7fb44sAmqqsiMTwAhNkJVoS4Nz0wdB18UdlfUERUZcp0QhunJdoDjhTqcFKCTMr8Bri1XHImGI8LMJ/ryeQ1TrKna8ET6mK+pqDMjj7oMBnUf/3RTvkEMjtmtsCZvqWXc5hn2phraiJfSlt91NEYSSu+tZlhWgOF6pTe7crhCvODheWtpRe8i4g1hhsg1ET6KOBw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(22082099003)(56012099006)(18002099003)(38070700021)(10067099003)(921020)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AoKXPenjdwrtRsLLzFkoqUfTJTu690wsvkjfz8zHhUTy3AfDHUrfNQjaYx?=
 =?iso-8859-1?Q?BhwnVCcGIhb3jHKOdB7iopRhJPS9L8aTgtUnqpqYNcd/OsremZfSLUJNH2?=
 =?iso-8859-1?Q?sy7cTRRIWMciJaCYHeAyXCao1+DFL7SDURnDWYkxCm+Q0qXi2i7QA7d44y?=
 =?iso-8859-1?Q?JxR2S9Oh6GtgiNs3n2WWwgijpni7WfNGOcu0vk5ligEF0bcIUDcsl59N1c?=
 =?iso-8859-1?Q?2nCNwnNcy0qamLPrjin8UqHH8ur2YTiuiuq3AIxFQttbHqRbIqh3GUpaKD?=
 =?iso-8859-1?Q?AYKKiEGRoXTaBL0Xz/3JpgsEczIf1oJL4pEShZDKyxCcda4/WpGIvCiVIL?=
 =?iso-8859-1?Q?FKPfhhe4TfkAmFxm4xTJDkmSSP+o0XAg61/GeLfDqBWV8Za0BlTUGRptkY?=
 =?iso-8859-1?Q?phHy/AOzCbJ/tXeieVj8RrH2w+ogLEUjaHktXEetw/7TAIa0imtt5ce08f?=
 =?iso-8859-1?Q?k8Km7598hnJzUf9yf/HuTY4O3YAYKZJqmuKT5FllfjMiusW70+nTTHmqLZ?=
 =?iso-8859-1?Q?vsMhVubmrnol4StLB0jfqnk2kl7PH6eeVqczJ6JGGlsjB6jnPd6YG471v9?=
 =?iso-8859-1?Q?kjU7euf8AxeJD4hDL4Q2AWwBEE7KyCyWb4ugWjbs4vi4T7rxjTOyN34AbL?=
 =?iso-8859-1?Q?sq8BkgetBcxsEoHBQjP3nirnlllqUgu8zj535DQV5tzlWmR+rrFxXu1bK3?=
 =?iso-8859-1?Q?sKr47UfMzCQKGfCdAu+kViFYGQd7jFs6GU9cbB8c8U03mR1B0MgtkQp8jR?=
 =?iso-8859-1?Q?filVOuVo2bTuUiXaIZGJuVfRbbyzrYRow2KaQOwN0+G8f8on8SIhDnjdO7?=
 =?iso-8859-1?Q?kx5+uHCK1cmhYENGeGF2jU8UA5gLGJoVw9qnAEzpOnAAtqIm2EaBWv4maW?=
 =?iso-8859-1?Q?3H+r9aF8RZjFihYMrNQWLlfpRhn1NWfHHjInAKDrQ3m7RPLAFfm/5ZMGwG?=
 =?iso-8859-1?Q?KivMyMQ+p9ds8VE4hJabccqeu6o2JyYF7JkDJd7bZQsTnsbAc6/1/xYlnE?=
 =?iso-8859-1?Q?0wNqJona12Edf16XAQeZ+a4aXSZB0c7Zf8XmFXea92hpHxYSYl4RrwH0Sa?=
 =?iso-8859-1?Q?91qsX2wB7m6XHR4x+ZsPIbA+FUp9QXs15iZyIC/x9/cGueERjWz++eDlxf?=
 =?iso-8859-1?Q?S/PRLNXswjmtz4ZYP9wtaCV+zP1/eCfw5+iPLoLLUVNCeBndzALq0Z4pDR?=
 =?iso-8859-1?Q?CTWWl6apCKgFXjeMRR5FQ3gQ9crmGm9PCbaFMB3F7jifApDIQKCrBQ2cbU?=
 =?iso-8859-1?Q?LOMMfB3rsDH/bMpFN/+yG1qzmCmKpbdvJQcv4QJcF2CbMnn7jCdEiwMNG9?=
 =?iso-8859-1?Q?ySvvf/2L1WdLoj0S+qy73KbxLBC3qUTjp/+G6FMu3ZR8qbTcL6yj/qpA0u?=
 =?iso-8859-1?Q?1x3kUUW1i23NqFc952o91BfrA4li+OebaE5HdjNYgdqHYXNMxAjAOEt2gt?=
 =?iso-8859-1?Q?ewngQKZ/BwAMX1wsQU0L9M+n+QQKt7+7SGvLs+peJThEE0hNxsxzdI8PV/?=
 =?iso-8859-1?Q?NYSd3VdDRkfDRUfvgA/VgICBNWFCErouLR50Zatr7sUW70U57NwhqZuO42?=
 =?iso-8859-1?Q?QrKx7D4wsjj7eHH9aqNjjuSGaI0wn7B4c/5NzvEgx5ic4JHyyS7xZBYcpO?=
 =?iso-8859-1?Q?3nRq+UtyvNQ17Z6nWN9H+fcjJFMCYlqeibsTxOdZG5ei8rqQdFy9wf1wCZ?=
 =?iso-8859-1?Q?mYiP7WMkyPEerfmXsWxggNe0FLWLCNlf1075+6gLF1iJ/WZ9vLe9yHwVEA?=
 =?iso-8859-1?Q?dQYUNDZirj07V/+upvACnWdpuwrN8CdCTQd+vB66Nbvr2OCApQGaKDvJGG?=
 =?iso-8859-1?Q?AUOYAlSA5A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SqdzIxhH+U8liPcmNZU/tGv4Y0XbZK5XJnGLm3Hw674ndEIYPVj5KntimjskJ9555IfCeLQOYp6sWvZYQznUQoKW3aUBRCXJ3YoHkkXEy/a37MrPXay7NH6SsxEn0oB5pVEStCZ8nGMPTjYg5/Tr/j0qWrgrAikXl7U/DZrC5zN0ki+1bcTaGghEUMi+Xs9/frLnr1bov15wQ9GTc0r+4vC3TC04VLfi7RuGv4qpYeEylj9Aq6gJ36oSn+jmj+BHe7sWIH6V+T6blrXPb4KwtS4yQUuhXXmN1yqLENlPpWhEZLqxywgc4YTVnqpHheETw4UB0LbC+r2eNJr4ygDS/A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2150a7a-d132-4103-cd0c-08def7561ea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 03:10:38.6369 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1cbqIJI6vwgzbeP2m1+PhdjwtD+awuHzfbgmGtpbx9RPM1wE6egTG01CmtQXdGIFOxYhf5FFG62CpAzMzHmKY31cqiXwuCAAN+SdFZVqbDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5808
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

Map QCRYPTO_CIPHER_MODE_GCM to GCRY_CIPHER_MODE_GCM and advertise it in=0A=
qcrypto_cipher_supports() for 128-bit block ciphers. Add a GCM driver=0A=
whose setiv accepts the (typically 96-bit) nonce, whose encrypt/decrypt=0A=
do not require block-aligned lengths, and which implements setaad via=0A=
gcry_cipher_authenticate() and gettag via gcry_cipher_gettag().=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>=0A=
Acked-by: Daniel P. Berrang=E9 <berrange@redhat.com>=0A=
---=0A=
 crypto/cipher-gcrypt.c.inc | 101 +++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 101 insertions(+)=0A=
=0A=
diff --git a/crypto/cipher-gcrypt.c.inc b/crypto/cipher-gcrypt.c.inc=0A=
index 12eb9ddb5a..fce09a3c77 100644=0A=
--- a/crypto/cipher-gcrypt.c.inc=0A=
+++ b/crypto/cipher-gcrypt.c.inc=0A=
@@ -65,6 +65,8 @@ static int qcrypto_cipher_mode_to_gcry_mode(QCryptoCipher=
Mode mode)=0A=
         return GCRY_CIPHER_MODE_CBC;=0A=
     case QCRYPTO_CIPHER_MODE_CTR:=0A=
         return GCRY_CIPHER_MODE_CTR;=0A=
+    case QCRYPTO_CIPHER_MODE_GCM:=0A=
+        return GCRY_CIPHER_MODE_GCM;=0A=
     default:=0A=
         return GCRY_CIPHER_MODE_NONE;=0A=
     }=0A=
@@ -104,6 +106,10 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgo alg,=0A=
     case QCRYPTO_CIPHER_MODE_XTS:=0A=
     case QCRYPTO_CIPHER_MODE_CTR:=0A=
         return true;=0A=
+    case QCRYPTO_CIPHER_MODE_GCM:=0A=
+        /* GCM requires a 128-bit block cipher. */=0A=
+        return gcry_cipher_get_algo_blklen(=0A=
+                   qcrypto_cipher_alg_to_gcry_alg(alg)) =3D=3D 16;=0A=
     default:=0A=
         return false;=0A=
     }=0A=
@@ -228,6 +234,99 @@ static const struct QCryptoCipherDriver qcrypto_gcrypt=
_ctr_driver =3D {=0A=
     .cipher_free =3D qcrypto_gcrypt_ctx_free,=0A=
 };=0A=
 =0A=
+/*=0A=
+ * GCM is an AEAD stream mode: the IV/nonce need not match the block size,=
=0A=
+ * the message length need not be a multiple of the block size, associated=
=0A=
+ * data is fed with gcry_cipher_authenticate() and the authentication tag =
is=0A=
+ * read back with gcry_cipher_gettag().=0A=
+ */=0A=
+static int qcrypto_gcrypt_gcm_setiv(QCryptoCipher *cipher,=0A=
+                                    const uint8_t *iv, size_t niv,=0A=
+                                    Error **errp)=0A=
+{=0A=
+    QCryptoCipherGcrypt *ctx =3D container_of(cipher, QCryptoCipherGcrypt,=
 base);=0A=
+    gcry_error_t err;=0A=
+=0A=
+    gcry_cipher_reset(ctx->handle);=0A=
+    err =3D gcry_cipher_setiv(ctx->handle, iv, niv);=0A=
+    if (err !=3D 0) {=0A=
+        error_setg(errp, "Cannot set IV: %s", gcry_strerror(err));=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int qcrypto_gcrypt_gcm_setaad(QCryptoCipher *cipher,=0A=
+                                     const uint8_t *aad, size_t len,=0A=
+                                     Error **errp)=0A=
+{=0A=
+    QCryptoCipherGcrypt *ctx =3D container_of(cipher, QCryptoCipherGcrypt,=
 base);=0A=
+    gcry_error_t err;=0A=
+=0A=
+    err =3D gcry_cipher_authenticate(ctx->handle, aad, len);=0A=
+    if (err !=3D 0) {=0A=
+        error_setg(errp, "Cannot set AAD: %s", gcry_strerror(err));=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int qcrypto_gcrypt_gcm_encrypt(QCryptoCipher *cipher, const void *i=
n,=0A=
+                                      void *out, size_t len, Error **errp)=
=0A=
+{=0A=
+    QCryptoCipherGcrypt *ctx =3D container_of(cipher, QCryptoCipherGcrypt,=
 base);=0A=
+    gcry_error_t err;=0A=
+=0A=
+    err =3D gcry_cipher_encrypt(ctx->handle, out, len, in, len);=0A=
+    if (err !=3D 0) {=0A=
+        error_setg(errp, "Cannot encrypt data: %s", gcry_strerror(err));=
=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int qcrypto_gcrypt_gcm_decrypt(QCryptoCipher *cipher, const void *i=
n,=0A=
+                                      void *out, size_t len, Error **errp)=
=0A=
+{=0A=
+    QCryptoCipherGcrypt *ctx =3D container_of(cipher, QCryptoCipherGcrypt,=
 base);=0A=
+    gcry_error_t err;=0A=
+=0A=
+    err =3D gcry_cipher_decrypt(ctx->handle, out, len, in, len);=0A=
+    if (err !=3D 0) {=0A=
+        error_setg(errp, "Cannot decrypt data: %s", gcry_strerror(err));=
=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int qcrypto_gcrypt_gcm_gettag(QCryptoCipher *cipher,=0A=
+                                     uint8_t *tag, size_t len, Error **err=
p)=0A=
+{=0A=
+    QCryptoCipherGcrypt *ctx =3D container_of(cipher, QCryptoCipherGcrypt,=
 base);=0A=
+    gcry_error_t err;=0A=
+=0A=
+    err =3D gcry_cipher_gettag(ctx->handle, tag, len);=0A=
+    if (err !=3D 0) {=0A=
+        error_setg(errp, "Cannot get tag: %s", gcry_strerror(err));=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static const struct QCryptoCipherDriver qcrypto_gcrypt_gcm_driver =3D {=0A=
+    .cipher_encrypt =3D qcrypto_gcrypt_gcm_encrypt,=0A=
+    .cipher_decrypt =3D qcrypto_gcrypt_gcm_decrypt,=0A=
+    .cipher_setiv =3D qcrypto_gcrypt_gcm_setiv,=0A=
+    .cipher_setaad =3D qcrypto_gcrypt_gcm_setaad,=0A=
+    .cipher_gettag =3D qcrypto_gcrypt_gcm_gettag,=0A=
+    .cipher_free =3D qcrypto_gcrypt_ctx_free,=0A=
+};=0A=
+=0A=
 static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgo alg,=0A=
                                              QCryptoCipherMode mode,=0A=
                                              const uint8_t *key,=0A=
@@ -259,6 +358,8 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCip=
herAlgo alg,=0A=
 =0A=
     if (mode =3D=3D QCRYPTO_CIPHER_MODE_CTR) {=0A=
         drv =3D &qcrypto_gcrypt_ctr_driver;=0A=
+    } else if (mode =3D=3D QCRYPTO_CIPHER_MODE_GCM) {=0A=
+        drv =3D &qcrypto_gcrypt_gcm_driver;=0A=
     } else {=0A=
         drv =3D &qcrypto_gcrypt_driver;=0A=
     }=0A=
-- =0A=
2.43.0=0A=

