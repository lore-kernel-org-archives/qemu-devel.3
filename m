Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B478CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 05:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPCnA-0003VD-5K; Tue, 19 May 2026 01:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wPCn8-0003UO-0s; Tue, 19 May 2026 01:14:54 -0400
Received: from 8.mo533.mail-out.ovh.net ([54.36.140.183])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wPCn5-0005My-AM; Tue, 19 May 2026 01:14:53 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4gKNCC6Pnfz5yTH;
 Tue, 19 May 2026 05:14:47 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue, 19 May 2026 05:14:47 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.58.70])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gKNCC5G3lz7tgx; Tue, 19 May 2026 05:14:47 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 6445E2403B51; Tue, 19 May 2026 05:14:46 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R00480f438ca-2e93-4add-993c-e16ff15c0633,
 A1C5BDF50025601E7F63D663DE463AD2E6007479) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <bee4fcd0-58dd-4d00-8b54-867a3e29d6b2@kaod.org>
Date: Tue, 19 May 2026 07:14:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/arm/aspeed: anacapa: add FRU EEPROM data
To: William de Abreu Pinho <williamdapinho@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org
References: <20260515-add-anacapa-machine-v1-0-9765ce0b9426@gmail.com>
 <20260515-add-anacapa-machine-v1-2-9765ce0b9426@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260515-add-anacapa-machine-v1-2-9765ce0b9426@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 17421893684702063627
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFPLp0QfKnZnP+xenkCU0jrZThuyWQi9EIc4aHbcPOBktRJ2b71381SNklaLlTcFjkHI4/RhRYvraesWPII07l1TNX89w5siRd/q4cWmQ7qILYmd+0X++tZIFYky2aLyqZVwRBMA6p2vffI+MRcp2Npe/kg+Ux3Ezen0e/cr4RvjUOAtgnM3zMbNuN5sJfSybyocz5UtG7fhMzWedgvW+VXo5iVH2BKFHLaH3l5gQ9jtKtf0bF8gx2WUQ+s2W8lMrooPNq775lua8rXzCrA0VbiyI4IrX3ez9gnxPz6FikRPEvkVXNY+aEoUaY2GZeBGtZ7s033A56aqDir41E0vNvrQM5M8J2fBDyaDU5674enfpoSNR1kk2uBao9g4Pe+voqzx/u+mFbgyLMYtTCSSd9d99g4kJhosSGW/Frgjw8E0/4LlwVXmhAgk3gYKdh6qJtpFH3tv7ctn5RTwEgkOfnmzdvD6g+4YLx6TxYplVUN4yQkXiONsil1OVPimMBj7Br9w6MtOBhPqTrqr7B2NfR/3dAtPRsYk74f15PXrayep+y671fGR6mpWCJvpyxk33xlXjXuyvZpTNF8n26t5C2XBv9DFD5qwWoD/ZWvubaUnU9oK9YfSS7dO0cUshlz7EONsQNtjqFtwg56p+1F6AL6qjvswQziyhMjbTOWVFj7tA
DKIM-Signature: a=rsa-sha256; bh=/an95xeUpL3AZYCzjGQvJom6HO3vhe1olq4/eyFUPDY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1779167688; v=1;
 b=PdRPjjNyIv0gS9od+KKDUJq8q2a+QNlT+NaVeOKWJWDj6Rw1vjNiieNgY1MZ144OCYPa9LMJ
 o7pPcanrToPyHYgqCAuYINbpRZUjKqLB/ORLN7c8m6zJg/0/1f0eZeUCT0pMuzmAFrOtnV18cY6
 U1qvioprOyf3rPc3QrdO0mljEmZl1CWWLnrbUyC+XRLBJghJ+gaE9UifXsZb5M0J/tuvumJy10O
 mDL5+RgoKytTDQaW/s1nP1QLvGcwx1sEnDA7unCVKuhTDMpDabM+Awy6zfVrXGeuKbpigE6Tp//
 hCQi+YbjB2M2Qxqi0weMSG3+RVTl5EGeBnKTupbF5Cq0Q==
Received-SPF: pass client-ip=54.36.140.183; envelope-from=clg@kaod.org;
 helo=8.mo533.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/15/26 18:55, William de Abreu Pinho wrote:
> Use frugen to generate FRU data for the following components: HPM MB,
> R-PDB, L-PDB, SCM, BSM, R Bridge Board, L Bridge Board, and HPM board
> ID.
> 
> Signed-off-by: William de Abreu Pinho <williamdapinho@gmail.com>
> ---
>   hw/arm/aspeed_ast2600_anacapa.c | 225 ++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 217 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast2600_anacapa.c b/hw/arm/aspeed_ast2600_anacapa.c
> index c24f00d44c..a1c8111a93 100644
> --- a/hw/arm/aspeed_ast2600_anacapa.c
> +++ b/hw/arm/aspeed_ast2600_anacapa.c
> @@ -20,6 +20,207 @@
>   #define ANACAPA_BMC_HW_STRAP2 0x00000000
>   #define ANACAPA_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
>   
> +/*
> + * "Anacapa HPM (MB)" FRU data. Generated with frugen.
> + *
> + *    {
> + *      "board": { "mfg": "Inventec", "pname": "Anacapa QEMU MB EVT2",
> + *                 "pn": "00000000000", "serial": "00000000000000" },
> + *      "product": { "mfg": "Inventec", "pname": "CI-Anacapa",
> + *                   "pn": "10000000001", "ver": "MP",
> + *                   "serial": "10000000000000", "atag": "QEMU" }
> + *    }
> + */
> +static const uint8_t hpm_eeprom[] = {
> +    0x01, 0x00, 0x00, 0x01, 0x08, 0x00, 0x00, 0xf6, 0x01, 0x07, 0x19, 0xb4,
> +    0xa4, 0xf2, 0xc8, 0x49, 0x6e, 0x76, 0x65, 0x6e, 0x74, 0x65, 0x63, 0xd4,
> +    0x41, 0x6e, 0x61, 0x63, 0x61, 0x70, 0x61, 0x20, 0x51, 0x45, 0x4d, 0x55,
> +    0x20, 0x4d, 0x42, 0x20, 0x45, 0x56, 0x54, 0x32, 0x47, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00, 0x46, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0a, 0xc0,
> +    0xc1, 0x00, 0x00, 0xb8, 0x01, 0x06, 0x19, 0xc8, 0x49, 0x6e, 0x76, 0x65,
> +    0x6e, 0x74, 0x65, 0x63, 0xca, 0x43, 0x49, 0x2d, 0x41, 0x6e, 0x61, 0x63,
> +    0x61, 0x70, 0x61, 0x46, 0x10, 0x00, 0x00, 0x00, 0x00, 0x1a, 0x82, 0x2d,
> +    0x0c, 0x47, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83, 0x71, 0xd9,
> +    0xd6, 0xc0, 0xc1, 0x0e
> +};
> +static const size_t hpm_eeprom_len = sizeof(hpm_eeprom);
> +
> +/*
> + * "Anacapa R-PDB" FRU data. Generated with frugen.
> + *
> + *    {
> + *      "board": { "mfg": "Inventec", "pname": "Anacapa QEMU RPDB",
> + *                 "pn": "00000000000", "serial": "00000000000000" },
> + *      "product": { "mfg": "Inventec", "pname": "CI-Anacapa",
> + *                   "pn": "10000000001", "ver": "MP",
> + *                   "serial": "10000000000000", "atag": "QEMU" }
> + *    }
> + */
> +static const uint8_t rpdb_eeprom[] = {
> +    0x01, 0x00, 0x00, 0x01, 0x08, 0x00, 0x00, 0xf6, 0x01, 0x07, 0x19, 0x41,
> +    0x2d, 0xf2, 0xc8, 0x49, 0x6e, 0x76, 0x65, 0x6e, 0x74, 0x65, 0x63, 0xd1,
> +    0x41, 0x6e, 0x61, 0x63, 0x61, 0x70, 0x61, 0x20, 0x51, 0x45, 0x4d, 0x55,
> +    0x20, 0x52, 0x50, 0x44, 0x42, 0x47, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +    0x00, 0x46, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0a, 0xc0, 0xc1, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x4d, 0x01, 0x06, 0x19, 0xc8, 0x49, 0x6e, 0x76, 0x65,
> +    0x6e, 0x74, 0x65, 0x63, 0xca, 0x43, 0x49, 0x2d, 0x41, 0x6e, 0x61, 0x63,
> +    0x61, 0x70, 0x61, 0x46, 0x10, 0x00, 0x00, 0x00, 0x00, 0x1a, 0x82, 0x2d,
> +    0x0c, 0x47, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83, 0x71, 0xd9,
> +    0xd6, 0xc0, 0xc1, 0x0e
> +};
> +static const size_t rpdb_eeprom_len = sizeof(rpdb_eeprom);
> +
> +/*
> + * "Anacapa L-PDB" FRU data. Generated with frugen.
> + *
> + *    {
> + *      "board": { "mfg": "Inventec", "pname": "Anacapa QEMU LPDB",
> + *                 "pn": "00000000000", "serial": "00000000000000" },
> + *      "product": { "mfg": "Inventec", "pname": "CI-Anacapa",
> + *                   "pn": "10000000001", "ver": "MP",
> + *                   "serial": "10000000000000", "atag": "QEMU" }
> + *    }
> + */
> +static const uint8_t lpdb_eeprom[] = {
> +    0x01, 0x00, 0x00, 0x01, 0x08, 0x00, 0x00, 0xf6, 0x01, 0x07, 0x19, 0x41,
> +    0x2d, 0xf2, 0xc8, 0x49, 0x6e, 0x76, 0x65, 0x6e, 0x74, 0x65, 0x63, 0xd1,
> +    0x41, 0x6e, 0x61, 0x63, 0x61, 0x70, 0x61, 0x20, 0x51, 0x45, 0x4d, 0x55,
> +    0x20, 0x4c, 0x50, 0x44, 0x42, 0x47, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +    0x00, 0x46, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0a, 0xc0, 0xc1, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x53, 0x01, 0x06, 0x19, 0xc8, 0x49, 0x6e, 0x76, 0x65,
> +    0x6e, 0x74, 0x65, 0x63, 0xca, 0x43, 0x49, 0x2d, 0x41, 0x6e, 0x61, 0x63,
> +    0x61, 0x70, 0x61, 0x46, 0x10, 0x00, 0x00, 0x00, 0x00, 0x1a, 0x82, 0x2d,
> +    0x0c, 0x47, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83, 0x71, 0xd9,
> +    0xd6, 0xc0, 0xc1, 0x0e
> +};
> +static const size_t lpdb_eeprom_len = sizeof(lpdb_eeprom);
> +
> +/*
> + * "Anacapa SCM" FRU data. Generated with frugen.
> + *
> + *    {
> + *      "board": { "mfg": "Quanta", "pname": "Anacapa SCM",
> + *                 "pn": "00000000000", "serial": "00000000000000" },
> + *      "product": { "mfg": "Quanta", "pname": "CI-Anacapa",
> + *                   "pn": "10000000001", "ver": "MP",
> + *                   "serial": "10000000000000", "atag": "QEMU" }
> + *    }
> + */
> +static const uint8_t scm_eeprom[] = {
> +    0x01, 0x00, 0x00, 0x01, 0x07, 0x00, 0x00, 0xf7, 0x01, 0x06, 0x19, 0x41,
> +    0x2d, 0xf2, 0xc6, 0x51, 0x75, 0x61, 0x6e, 0x74, 0x61, 0xcb, 0x41, 0x6e,
> +    0x61, 0x63, 0x61, 0x70, 0x61, 0x20, 0x53, 0x43, 0x4d, 0x47, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x46, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0a,
> +    0xc0, 0xc1, 0x00, 0x00, 0x00, 0x00, 0x00, 0xc5, 0x01, 0x06, 0x19, 0xc6,
> +    0x51, 0x75, 0x61, 0x6e, 0x74, 0x61, 0xca, 0x43, 0x49, 0x2d, 0x41, 0x6e,
> +    0x61, 0x63, 0x61, 0x70, 0x61, 0x46, 0x10, 0x00, 0x00, 0x00, 0x00, 0x1a,
> +    0x82, 0x2d, 0x0c, 0x47, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83,
> +    0x71, 0xd9, 0xd6, 0xc0, 0xc1, 0x00, 0x00, 0xe2
> +};
> +static const size_t scm_eeprom_len = sizeof(scm_eeprom);
> +
> +/*
> + * "Anacapa BMC Storage Module" FRU data. Generated with frugen.
> + *
> + *    {
> + *      "board": { "mfg": "Quanta", "pname": "Anacapa BMC Storage Module",
> + *                 "pn": "00000000000", "serial": "00000000000000" },
> + *      "product": { "mfg": "Quanta", "pname": "CI-Anacapa",
> + *                   "pn": "10000000001", "ver": "MP",
> + *                   "serial": "10000000000000", "atag": "QEMU" }
> + *    }
> + */
> +static const uint8_t bsm_eeprom[] = {
> +    0x01, 0x00, 0x00, 0x01, 0x0a, 0x00, 0x00, 0xf4, 0x01, 0x09, 0x00, 0x00,
> +    0x00, 0x00, 0xc6, 0x51, 0x75, 0x61, 0x6e, 0x74, 0x61, 0xda, 0x41, 0x6e,
> +    0x61, 0x63, 0x61, 0x70, 0x61, 0x20, 0x42, 0x4d, 0x43, 0x20, 0x53, 0x74,
> +    0x6f, 0x72, 0x61, 0x67, 0x65, 0x20, 0x4d, 0x6f, 0x64, 0x75, 0x6c, 0x65,
> +    0xce, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
> +    0x30, 0x30, 0x30, 0xcb, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
> +    0x30, 0x30, 0x30, 0xc0, 0xc1, 0x00, 0x00, 0x10, 0x01, 0x08, 0x00, 0xc6,
> +    0x51, 0x75, 0x61, 0x6e, 0x74, 0x61, 0xca, 0x43, 0x49, 0x2d, 0x41, 0x6e,
> +    0x61, 0x63, 0x61, 0x70, 0x61, 0xcb, 0x31, 0x30, 0x30, 0x30, 0x30, 0x30,
> +    0x30, 0x30, 0x30, 0x30, 0x31, 0xc2, 0x4d, 0x50, 0xce, 0x31, 0x30, 0x30,
> +    0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0xc4,
> +    0x51, 0x45, 0x4d, 0x55, 0xc0, 0xc1, 0x00, 0x00, 0x00, 0x00, 0x00, 0x77,
> +};
> +static const size_t bsm_eeprom_len = sizeof(bsm_eeprom);
> +
> +/*
> + * "Anacapa R Bridge Board" FRU data. Generated with frugen.
> + *
> + *    {
> + *      "board": { "mfg": "Inventec", "pname": "Anacapa QEMU RBB EVT2",
> + *                 "pn": "00000000000", "serial": "00000000000000" },
> + *      "product": { "mfg": "Inventec", "pname": "CI-Anacapa",
> + *                   "pn": "10000000001", "ver": "MP",
> + *                   "serial": "10000000000000", "atag": "QEMU" }
> + *    }
> + */
> +static const uint8_t rbb_eeprom[] = {
> +    0x01, 0x00, 0x00, 0x01, 0x08, 0x00, 0x00, 0xf6, 0x01, 0x07, 0x19, 0xb4,
> +    0xa4, 0xf2, 0xc8, 0x49, 0x6e, 0x76, 0x65, 0x6e, 0x74, 0x65, 0x63, 0xd5,
> +    0x41, 0x6e, 0x61, 0x63, 0x61, 0x70, 0x61, 0x20, 0x51, 0x45, 0x4d, 0x55,
> +    0x20, 0x52, 0x42, 0x42, 0x20, 0x45, 0x56, 0x54, 0x32, 0x47, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x46, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0a,
> +    0xc0, 0xc1, 0x00, 0x70, 0x01, 0x06, 0x19, 0xc8, 0x49, 0x6e, 0x76, 0x65,
> +    0x6e, 0x74, 0x65, 0x63, 0xca, 0x43, 0x49, 0x2d, 0x41, 0x6e, 0x61, 0x63,
> +    0x61, 0x70, 0x61, 0x46, 0x10, 0x00, 0x00, 0x00, 0x00, 0x1a, 0x82, 0x2d,
> +    0x0c, 0x47, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83, 0x71, 0xd9,
> +    0xd6, 0xc0, 0xc1, 0x0e
> +};
> +static const size_t rbb_eeprom_len = sizeof(rbb_eeprom);
> +
> +/*
> + * "Anacapa L Bridge Board" FRU data. Generated with frugen.
> + *
> + *    {
> + *      "board": { "mfg": "Inventec", "pname": "Anacapa QEMU LBB EVT2",
> + *                 "pn": "00000000000", "serial": "00000000000000" },
> + *      "product": { "mfg": "Inventec", "pname": "CI-Anacapa",
> + *                   "pn": "10000000001", "ver": "MP",
> + *                   "serial": "10000000000000", "atag": "QEMU" }
> + *    }
> + */
> +static const uint8_t lbb_eeprom[] = {
> +    0x01, 0x00, 0x00, 0x01, 0x08, 0x00, 0x00, 0xf6, 0x01, 0x07, 0x19, 0xb4,
> +    0xa4, 0xf2, 0xc8, 0x49, 0x6e, 0x76, 0x65, 0x6e, 0x74, 0x65, 0x63, 0xd5,
> +    0x41, 0x6e, 0x61, 0x63, 0x61, 0x70, 0x61, 0x20, 0x51, 0x45, 0x4d, 0x55,
> +    0x20, 0x4c, 0x42, 0x42, 0x20, 0x45, 0x56, 0x54, 0x32, 0x47, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x46, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0a,
> +    0xc0, 0xc1, 0x00, 0x76, 0x01, 0x06, 0x19, 0xc8, 0x49, 0x6e, 0x76, 0x65,
> +    0x6e, 0x74, 0x65, 0x63, 0xca, 0x43, 0x49, 0x2d, 0x41, 0x6e, 0x61, 0x63,
> +    0x61, 0x70, 0x61, 0x46, 0x10, 0x00, 0x00, 0x00, 0x00, 0x1a, 0x82, 0x2d,
> +    0x0c, 0x47, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83, 0x71, 0xd9,
> +    0xd6, 0xc0, 0xc1, 0x0e
> +};
> +static const size_t lbb_eeprom_len = sizeof(lbb_eeprom);
> +
> +/*
> + * "Anacapa HPM BRD ID" FRU data. Generated with frugen.
> + *
> + *    {
> + *      "board": { "mfg": "Inventec", "pname": "Anacapa HPM BRD ID",
> + *                 "pn": "00000000000", "serial": "00000000000000" },
> + *      "product": { "mfg": "Inventec", "pname": "CI-Anacapa",
> + *                   "pn": "10000000001", "ver": "MP",
> + *                   "serial": "10000000000000", "atag": "QEMU" }
> + *    }
> + */
> +static const uint8_t hpm_brd_id_eeprom[] = {
> +    0x01, 0x00, 0x00, 0x01, 0x08, 0x00, 0x00, 0xf6, 0x01, 0x07, 0x19, 0x41,
> +    0x2d, 0xf2, 0xc8, 0x49, 0x6e, 0x76, 0x65, 0x6e, 0x74, 0x65, 0x63, 0xd2,
> +    0x41, 0x6e, 0x61, 0x63, 0x61, 0x70, 0x61, 0x20, 0x48, 0x50, 0x4d, 0x20,
> +    0x42, 0x52, 0x44, 0x20, 0x49, 0x44, 0x47, 0x00, 0x00, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x46, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0a, 0xc0, 0xc1, 0x00,
> +    0x00, 0x00, 0x00, 0x42, 0x01, 0x06, 0x19, 0xc8, 0x49, 0x6e, 0x76, 0x65,
> +    0x6e, 0x74, 0x65, 0x63, 0xca, 0x43, 0x49, 0x2d, 0x41, 0x6e, 0x61, 0x63,
> +    0x61, 0x70, 0x61, 0x46, 0x10, 0x00, 0x00, 0x00, 0x00, 0x1a, 0x82, 0x2d,
> +    0x0c, 0x47, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83, 0x71, 0xd9,
> +    0xd6, 0xc0, 0xc1, 0x0e
> +};
> +static const size_t hpm_brd_id_eeprom_len = sizeof(hpm_brd_id_eeprom);
> +
>   static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
>   {
>       /* Reference: aspeed-bmc-facebook-anacapa.dts */
> @@ -50,7 +251,8 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
>   
>       /* &i2c6 */
>       /* eeprom@50 */
> -    at24c_eeprom_init(i2c[6], 0x50, 32 * KiB);
> +    at24c_eeprom_init_rom(i2c[6], 0x50, 32 * KiB,
> +                          hpm_eeprom, hpm_eeprom_len);
>   
>       /* &i2c8 */
>       /* i2c-mux@72 (PCA9546) */
> @@ -65,7 +267,8 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
>       i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
>                               TYPE_PCA9552, 0x24);
>       /* eeprom@50 */
> -    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 16 * KiB);
> +    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 16 * KiB,
> +                          rpdb_eeprom, rpdb_eeprom_len);
>   
>       /* i2c8mux ch1 */
>       /* pca9555@22 */
> @@ -75,13 +278,16 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
>       i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1),
>                               TYPE_PCA9552, 0x24);
>       /* eeprom@50 */
> -    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 16 * KiB);
> +    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 1), 0x50, 16 * KiB,
> +                          lpdb_eeprom, lpdb_eeprom_len);
>   
>       /* &i2c9 */
>       /* eeprom@50 */
> -    at24c_eeprom_init(i2c[9], 0x50, 16 * KiB);
> +    at24c_eeprom_init_rom(i2c[9], 0x50, 16 * KiB,
> +                          scm_eeprom, scm_eeprom_len);
>       /* eeprom@56 */
> -    at24c_eeprom_init(i2c[9], 0x56, 8 * KiB);
> +    at24c_eeprom_init_rom(i2c[9], 0x56, 8 * KiB,
> +                          bsm_eeprom, bsm_eeprom_len);
>   
>       /* &i2c10 */
>       /* i2c-mux@71 (PCA9548) */
> @@ -92,7 +298,8 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
>       i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5),
>                               TYPE_PCA9552, 0x22);
>       /* eeprom@52 */
> -    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 5), 0x52, 32 * KiB);
> +    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 5), 0x52, 32 * KiB,
> +                          rbb_eeprom, rbb_eeprom_len);
>   
>       /* &i2c11 */
>       /* i2c-mux@71 (PCA9548) */
> @@ -105,7 +312,8 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
>       i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5),
>                               TYPE_PCA9552, 0x22);
>       /* eeprom@52 */
> -    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 5), 0x52, 32 * KiB);
> +    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 5), 0x52, 32 * KiB,
> +                          lbb_eeprom, lbb_eeprom_len);
>   
>       /* &i2c13 */
>       /* i2c-mux@70 (PCA9548) */
> @@ -116,7 +324,8 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
>   
>       /* i2c13mux ch4 */
>       /* eeprom@51 */
> -    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 4), 0x51, 32 * KiB);
> +    at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 4), 0x51, 32 * KiB,
> +                          hpm_brd_id_eeprom, hpm_brd_id_eeprom_len);
>   
>       /* i2c13mux ch7 */
>       /* nfc@28 — no model */
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


