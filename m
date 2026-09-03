Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F24CC624D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x21mZ-0003Qs-57; Thu, 03 Sep 2026 03:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x21mR-0003Pz-RU
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 03:22:40 -0400
Received: from smtpout3.mo539.mail-out.ovh.net ([51.210.91.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x21mP-00010Z-Pd
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 03:22:39 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [79.137.60.226])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4hb9zF3PFBz4Dp9;
 Thu,  3 Sep 2026 07:22:32 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu,  3 Sep 2026 07:22:32 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.118.229])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hb9zD4ZjHz46ZG; Thu,  3 Sep 2026 07:22:32 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 4F98E941BEB; 
 Thu,  3 Sep 2026 07:22:31 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002b6e9ac08-c596-4efb-84a0-63af66bb26f1,
 D9A964E3C5AFBF6BD84231720E0C998EB3D97DAC) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <4fcbb217-596f-4a9a-8b2a-ca7fb1de7743@kaod.org>
Date: Thu, 3 Sep 2026 09:22:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] hw/misc/aspeed_sbc: Derive ABR state from OTP
 config straps
To: Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260831053658.462203-1-kane_chen@aspeedtech.com>
 <20260831053658.462203-2-kane_chen@aspeedtech.com>
 <f60d0cb7-5981-4dd5-b65b-4a6e9b8a30ed@kaod.org>
 <SI6PR06MB76318928B02F6147B1DEC82DF7A82@SI6PR06MB7631.apcprd06.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SI6PR06MB76318928B02F6147B1DEC82DF7A82@SI6PR06MB7631.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 2321605612161313803
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFfluqgSc70uqitsI4yzvKoqtEdPHbiUfiQ1xvrlhFonPipcqgRHmGAg0K3qK6R6vdo3ops2zfZ/TIXOgy6SOgHkcCuZ54yHCT/xLS78p2I8fH5DP02dh+j+srHiMIUIBo9g4AyC1ax/fFu2vWmfrVgR9VftObQtBDReqPt5WOm682+nBAq3whWcS3wjhUel2qnw+XUnYPFJPFnP0LCIe9p/ENzzyLDX96ECulZL9mQ86/LvgxDrqyhJvaecWuCrd59T5gBtXCe6m8+J+ddLUxBVk3OY5ep4mAf4Jjqhmb8K7M3E7pJCUG7HV4edJ4PLYvwGXiDfzWUgHCWdIkS2vmKm0SJSrMZ1UY0gCjUrTrs++WlzNs9qEYzqQaeC3ipQS976+UiZ5Rt0gast/YQ0a3FwoKzibYAnqIE99kPaI+8s9QdCuv/wWGbo7+YEd/GjYhRkDqLyjuY1msAJ7d7oueLjM+mTqv+LNOdOzFp6hkNOWeVC+v0DXHLO8fNt6xubBWQtSWNgL9U6ECGLnkmeLbdalVmkh2heDrjfElYM28CexQ5EeBllpq0W3kmUisA1pmS1xkNagLkF/L2tzQtZ4SmbPtrjNnaUR7+xv1x+4uvAwEAj6PEgxFfadNkE7oHs6926WJgUrnaoIPoNgBp9oryDrv2+00addEgFEMkK9ypow
DKIM-Signature: a=rsa-sha256; bh=ocAN+nzWjBjK08uE4Q77kg7YOp9W1PlvHgbbk8zYS0g=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788420154; v=1;
 b=WULsvMnxabQvq+vSgdn0lKe0it9WmRHUYovxSlk/t5CQWgQf5muoBgIEAWtDbIE3qJhY547F
 Aes5/bKy2K6DmhB6M+lfTlRKasQpmhWbqabyQisVJM7iM8dYdIdr4MGRK098p1TUZcoNmabbDM7
 IKuklijEcR7ddDy+IDKfDv9JDVXLQAD+k+3VXvkYiEXbbOTTwI7FoLOlQvwG2wfr9ouoPrW96uA
 qaWz2dMrvvMxM4FJG1s8OTZDUB5ZgIrLHdGTX0yJ74xeoGF/BM2MdOtsqvJxemxMG6O+CX/qJ9F
 Sisle8FUDf5Vn1u2zwx63MRU45+Tjkg/IcvpKhttU3SZA==
Received-SPF: pass client-ip=51.210.91.42; envelope-from=clg@kaod.org;
 helo=smtpout3.mo539.mail-out.ovh.net
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

Hello,

> However, the OTP configuration can also be programmed at runtime.
> Therefore, reading the OTP configuration only once at realize/reset time
> may leave the SBC STATUS register out of sync if the OTP
> configuration is changed afterward.
> 
> I see two possible approaches to keep the SBC STATUS register
> synchronized with the OTP configuration:
> 
> Update the SBC STATUS register at reset and whenever the relevant
> OTP configuration is programmed. This would keep the cached STATUS
> value synchronized with the latest OTP configuration.

Caching values is always a problem. Unless performance is impacted,
computing is better.

> Derive the relevant SBC STATUS bits directly from the OTP
> configuration whenever the STATUS register is read. This avoids
> maintaining a cached copy of the OTP-derived state.

yes something like :

   static uint32_t aspeed_otp_read_cfg0(AspeedSBCState *s)
  {
@@ -110,6 +111,23 @@ static uint64_t aspeed_sbc_read(void *op
      }
  
      switch (addr) {
+    case R_STATUS: {
+        uint32_t val = s->regs[R_STATUS];
+
+        if (aspeed_get_abr_state(s)) {
+            val |= ABR_EN;
+        } else {
+            val &= ~ABR_EN;
+        }

is better IMO. The SBC status register is a reflection of the OTP
fuse state. You could ask he HW designers for info on how the state
is maintained.

Thanks,

C.

