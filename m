Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273BB606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MnYx1yF5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTZBR-0000OD-JY; Wed, 18 Nov 2026 01:30:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xTZBO-0000No-5x
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 01:30:14 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xTZBL-0001Xd-Rh
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 01:30:13 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-677d35fd1d2so484407d50.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 22:30:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794983410; cv=none;
 d=google.com; s=arc-20260327;
 b=D9QGyhXzEdLMCi05pn7ocTe2lYXYS/dMRUHVKJ/0AGFqnQPW+/W9vfsQP7yZL0x209
 WjGmD0Eb8pPCI57bX4WLFa2aS7cx5H8awVAcr5DvSqbyAtydPzUlj1V+V3Im1towPTJN
 7/ewMVmHISKeutwPdaJnD6GKfSEcw/17wDkRhDN6OCK3Ttr+6UBc4WG7H2fpwZssTdtG
 F+nXqMWgMhgetrIs5CFbvrm9VzQnbjWin8jGHoqWBXdmwpfsA/Lo3i/DDaQ77ENbLV0S
 r55ul/bIdJwj7lkk1lP9egjLv/jAwCiGAuX8tBtDb1iNoUxkvWDZBJ2a+bnLE4GWa4MY
 aI3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dObmHyx/Pv5Xr/xtWtOqclRbq9XnNGQPsMJISpGNgsE=;
 fh=jwd8Kg8x2PO3Eu42MYnB70N06QiQCVKHANXuWKaU4x0=;
 b=lVP86aOk0QDeDFyXxvZ2O4BTfvlUbRX3tiJutIIxPpCX31sgfoHd986NolHCSbhTqR
 mFJW8ebgZgA+i4kIBp4rSr0bHVFLbjA46+olleeWTUh2v35i0BR6cA8dbt+vUhoFJlAB
 ibu57QbuLy/VRLSJESREWQTtIiJZnYPC8EAwxh3vy+c9CDm5sY/hxZaGKWGmYR5vvqgC
 jfWjEOdT+Q3ta7dRjYmSshVyKj/PE6bJPxquGJuldQs5TXCdMdA7FxSpyhu46VsxjIvk
 imWY82VMEkkgMay5K5OSsvTbsXBLIyEk98IFerL9f2xETqI2cuFGBGW8ZE6cFjijjB3k
 oX+w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794983410; x=1795588210; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dObmHyx/Pv5Xr/xtWtOqclRbq9XnNGQPsMJISpGNgsE=;
 b=MnYx1yF5JhaVrsdUD+9aML05ojB/s20AxeSLt0oKjFVw7GeIscRh746RP/lNt9FTgr
 GIZAwj1GlgQN4fuq4Bg6Y+EavSn6Muc2zQbi56Ov2mYIsjtoOKWVVzobKoMQ4xVioAeU
 ICEjJpVCrXo1sJ1VozABxIJu+XTKg0nE42LCsucyp26s6mcgr+9VI+YbDoDwMQ9IDBd7
 92IPKJ2vL/ycUOcqQ5lcARFMfa7d9I0TbqdwrDTzr86uBrwMLaeH+ga9ih14cFx0DCwp
 nFT39yxvkjwRRFO5Tt0ioM11OpvB9Hd/PioIb71ZpThNOEzKyMOJ7ClDVl/DIbn/Cfhm
 FOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794983410; x=1795588210;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dObmHyx/Pv5Xr/xtWtOqclRbq9XnNGQPsMJISpGNgsE=;
 b=bRXW9+oaENDwxfAgJZV74X+ViJHu7cYkIIze0Wie2P7x9pm7Hoe7QLRCAWZwQ8Mqqc
 2yM5MzWP73dcqDke/YP7nJHUwvhTxh6HunI6qmxrJJeZThjliBL6vIFvFxg/W6183nkl
 A/aWSyOEeryNpZ30W6qYtOmaZKJasABCJGXd5ezfGIwZdvwAbZWgAiTBZUMQjhGZ+irt
 4axv/T4U0BzrBhBgQPVCUMLfHgWo3tcA5xIodLEugc/rRcqJwGRactJFUWbNvVgmXzVX
 APawWueq5qrlnTvcrdUK9q5kYh8eegECjto5sO22bZT5dQW8GrOGWBQvgP8kiepkI1fm
 fqDw==
X-Gm-Message-State: APuU4Z9VlbCRNN1s8NnzXHtSFvsOu6hqu6AwWWObcYyChhy8kFnrZMHC
 V4V0aE9qrhuLJPJ1TjxGoQV50AkBQszUBoW3oP9Q+1MyJ52nZ4nPu1GD82XvfYc+uDT/x5p5CJj
 9SX+5k3BR4esV0QSV9BN859ITCOdnV/c=
X-Gm-Gg: AZFdTZfoaZ/40qcclSewSciiUlFc5HH+nhgZy1wUIxVRmShulqviWrSU7TqfZCvRqBK
 q9n336oP/AHWdwtqmAuWU4FshmTlVgR3llL/Jsvdsw/DYyYhQ2agYsEuqE4+dAopixOFpP6L19g
 eQnk76YdbZPHsgwdRW1Wji1+89Fdxk8rNz/A4myUo+Jj/Eshs4jDUZF+/mc4VqSp4dazcYncbnJ
 pY1ub/ncqI/CLHPFyknW2dTHxDG2IeIWuGx4XZjebRSvRLA7pySrlAfaw9eBZhxy+PdGc+X8IKl
 l24B3hnE/jBnhEDu/nDBfrBMPnC8wwIVRbGH1c7pZ0GUFjoyZCc3I/0tUG8L1Fhao1QJaYbs1P5
 RAdEhRkpl1l1BkusiJn0xrLbNJ4KdHV2QJ2WG/3QPM5JjmhiQ0xlyKPaNTK9NCEiloSwCQGxwoW
 /U
X-Received: by 2002:a05:690e:4087:b0:67d:a224:6c0c with SMTP id
 956f58d0204a3-67dd3cf952cmr821917d50.12.1794983409894; Tue, 17 Nov 2026
 22:30:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <179449578952.8382.2790865629085512841-0@git.sr.ht>
 <179449578952.8382.2790865629085512841-1@git.sr.ht>
In-Reply-To: <179449578952.8382.2790865629085512841-1@git.sr.ht>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 18 Nov 2026 14:29:57 +0800
X-Gm-Features: AclHuK84G1KFQKzG3XiXmkJBaMvkT6mwhzvQz7CaC8Mnwco4M3w0NKWlKjaQaKw
Message-ID: <CAEUhbmXsaOhFCK07NTm2Q1DTmF923npUfsqSz3b1q+px1DFBWw@mail.gmail.com>
Subject: Re: [PATCH qemu 1/3] hw/block: Add Macronix MX25R6435F flash
To: "~mohammadodeh" <Mohammad.Odeh@exalt.ps>
Cc: qemu-devel@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Samuel Tardieu <sam@rfc1149.net>, Alistair Francis <alistair@alistair23.me>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Bernhard Beschow <shentey@gmail.com>, Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 Jan Kiszka <jan.kiszka@web.de>, Bin Meng <bin.meng@processmission.com>, 
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 11:52=E2=80=AFPM ~mohammadodeh <mohammadodeh@git.sr=
.ht> wrote:
>
> From: Mohammad Odeh <mohammad.odeh@exalt.ps>
>
> Add the 64-Mbit Macronix MX25R6435F serial NOR flash model, its
> SFDP data, and the 1-4-4 quad page-program command used by the
> device.
>
> Signed-off-by: Mohammad Odeh <zephyr@exalt.ps>

Two different email addresses being used here. They should be fixed to
use the same one.

> ---
>  hw/block/m25p80.c      |  5 +++++
>  hw/block/m25p80_sfdp.c | 20 ++++++++++++++++++++
>  hw/block/m25p80_sfdp.h |  1 +
>  3 files changed, 26 insertions(+)
>
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index baf798c6b5..9b931f5861 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -243,6 +243,8 @@ static const FlashPartInfo known_devices[] =3D {
>      { INFO6("mx25l25635f", 0xc22019,     0xc22019,  64 << 10, 512,
>              ER_4K | ER_32K), .sfdp_read =3D m25p80_sfdp_mx25l25635f },
>      { INFO("mx25l25655e", 0xc22619,      0,  64 << 10, 512, 0) },
> +    { INFO("mx25r6435",   0xc22817,      0,  64 << 10, 128, ER_4K | ER_3=
2K),
> +      .sfdp_read =3D m25p80_sfdp_mx25r6435 },
>      { INFO("mx66l51235f", 0xc2201a,      0,  64 << 10, 1024, ER_4K | ER_=
32K) },
>      { INFO("mx66u51235f", 0xc2253a,      0,  64 << 10, 1024, ER_4K | ER_=
32K) },
>      { INFO("mx66u1g45g",  0xc2253b,      0,  64 << 10, 2048, ER_4K | ER_=
32K) },
> @@ -405,6 +407,7 @@ typedef enum {
>      PP =3D 0x02,
>      PP4 =3D 0x12,
>      PP4_4 =3D 0x3e,
> +    QPP_1_4_4 =3D 0x38,
>      DPP =3D 0xa2,
>      QPP =3D 0x32,
>      QPP_4 =3D 0x34,
> @@ -759,6 +762,7 @@ static void complete_collecting_data(Flash *s)
>
>      switch (s->cmd_in_progress) {
>      case DPP:
> +    case QPP_1_4_4:
>      case QPP:
>      case QPP_4:
>      case PP:
> @@ -1255,6 +1259,7 @@ static void decode_new_cmd(Flash *s, uint32_t value=
)
>                            "QIO mode\n", s->cmd_in_progress);
>          }
>          break;
> +    case QPP_1_4_4:
>      case QPP:
>      case QPP_4:
>      case PP4_4:
> diff --git a/hw/block/m25p80_sfdp.c b/hw/block/m25p80_sfdp.c
> index 8ac603e212..29fc6aa5af 100644
> --- a/hw/block/m25p80_sfdp.c
> +++ b/hw/block/m25p80_sfdp.c
> @@ -135,6 +135,26 @@ define_sfdp_read(mt35xu02g);
>   * Matronix
>   */
>
> +static const uint8_t sfdp_mx25r6435[] =3D {
> +    0x53, 0x46, 0x44, 0x50, 0x06, 0x01, 0x00, 0xff,
> +    0x00, 0x06, 0x01, 0x10, 0x10, 0x00, 0x00, 0xff,
> +    0xe5, 0x20, 0xf1, 0xff, 0xff, 0xff, 0xff, 0x03,
> +    0x44, 0xeb, 0x08, 0x6b, 0x08, 0x3b, 0x04, 0xbb,
> +    0xee, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0xff,
> +    0xff, 0xff, 0x00, 0xff, 0x0c, 0x20, 0x0f, 0x52,
> +    0x10, 0xd8, 0x00, 0xff, 0x23, 0x72, 0xf5, 0x00,
> +    0x82, 0xed, 0x04, 0xcc, 0x44, 0x83, 0x68, 0x44,
> +    0x30, 0xb0, 0x30, 0xb0, 0xf7, 0xc4, 0xd5, 0x5c,
> +    0x00, 0xbe, 0x29, 0xff, 0xf0, 0xd0, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +};
> +define_sfdp_read(mx25r6435)
> +
>  /* mx25l25635e. No 4B opcodes */
>  static const uint8_t sfdp_mx25l25635e[] =3D {
>      0x53, 0x46, 0x44, 0x50, 0x00, 0x01, 0x01, 0xff,
> diff --git a/hw/block/m25p80_sfdp.h b/hw/block/m25p80_sfdp.h
> index 61544fb7cc..da3e7d74bc 100644
> --- a/hw/block/m25p80_sfdp.h
> +++ b/hw/block/m25p80_sfdp.h
> @@ -19,6 +19,7 @@ uint8_t m25p80_sfdp_n25q256a(uint32_t addr);
>  uint8_t m25p80_sfdp_mt35xu01g(uint32_t addr);
>  uint8_t m25p80_sfdp_mt35xu02g(uint32_t addr);
>
> +uint8_t m25p80_sfdp_mx25r6435(uint32_t addr);
>  uint8_t m25p80_sfdp_mx25l25635e(uint32_t addr);
>  uint8_t m25p80_sfdp_mx25l25635f(uint32_t addr);
>  uint8_t m25p80_sfdp_mx66l1g45g(uint32_t addr);

Regards,
Bin

