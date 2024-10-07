Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E246CFB456
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 19:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxtW5-0006w5-Ck; Mon, 07 Oct 2024 15:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1sxtW3-0006vo-HE; Mon, 07 Oct 2024 15:35:35 -0400
Received: from imap5.colo.codethink.co.uk ([78.40.148.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1sxtVy-0006dG-Vl; Mon, 07 Oct 2024 15:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
 Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
 MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TZCHaX+uyAvj0TstiAXXDtIRjTbgfJTH1d3AsR1Umgo=; b=hAC1XosDyJexJPtPSKmdKmccdu
 89NgJodX2ne/QT4P2RVl+d31KUNv/p72R7284ynyxWgaxzxM3V75R1knJaI2GdgPUT5DkduQGjBOQ
 K83BEIv+egWbtXulVPNUScOxo2HGP7hy42frc4lnHEb/fnUhCIfkJ7nuDPlfCezBKT/UdDJ3LKrr0
 pb92pUKNYY1w38X3iF4VZK9KQ7LnFgW33urf4BoVtpGkcTgzMUrPnOvgAlfr4D3blOzOBITcRRv1g
 rfEad7W93ofdbakDebtpRTMvGfUQi5VDK+a7E1hMsUsoafX5IdYbEuG7xwskgTx0aKyWEbULj8J6f
 i1rnqt/w==;
Received: from ipa12.colo.codethink.co.uk ([78.40.148.178]
 helo=webmail.codethink.co.uk)
 by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1sxtDj-00CCwR-6p; Mon, 07 Oct 2024 20:16:39 +0100
MIME-Version: 1.0
Date: Mon, 07 Oct 2024 20:16:39 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: Titus Rwantare <titusr@google.com>
Cc: peter.maydell@linaro.org, minyard@acm.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, venture@google.com, wuhaotsh@google.com
Subject: Re: [PATCH] hw/arm: add Quanta GSZ bmc machine
In-Reply-To: <20241007171700.1594342-1-titusr@google.com>
References: <20241007171700.1594342-1-titusr@google.com>
Message-ID: <5e176ecece460f8676184b51ef4b3227@codethink.co.uk>
X-Sender: ben.dooks@codethink.co.uk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=78.40.148.171;
 envelope-from=ben.dooks@codethink.co.uk; helo=imap5.colo.codethink.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2024-10-07 18:17, Titus Rwantare wrote:
> This patch adds the quanta-gsz-bmc target, a current Google machine of
> the day. This machine will be used as a platform to enable features 
> such
> as the PECI bmc interface, and Intel eSPI virtual wire interface in
> QEMU.
> 
> Signed-off-by: Titus Rwantare <titusr@google.com>
> ---
>  hw/arm/npcm7xx_boards.c | 140 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 140 insertions(+)
> 
> diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
> index e229efb447..e1ff5af756 100644
> --- a/hw/arm/npcm7xx_boards.c
> +++ b/hw/arm/npcm7xx_boards.c
> @@ -48,6 +48,8 @@
>  #define NPCM750_EVB_POWER_ON_STRAPS ( \
>          NPCM7XX_POWER_ON_STRAPS_DEFAULT & ~NPCM7XX_PWRON_STRAP_J2EN)
>  #define QUANTA_GSJ_POWER_ON_STRAPS NPCM7XX_POWER_ON_STRAPS_DEFAULT
> +#define QUANTA_GSZ_POWER_ON_STRAPS ( \
> +        NPCM7XX_POWER_ON_STRAPS_DEFAULT & ~NPCM7XX_PWRON_STRAP_SFAB)
>  #define QUANTA_GBS_POWER_ON_STRAPS ( \
>          NPCM7XX_POWER_ON_STRAPS_DEFAULT & ~NPCM7XX_PWRON_STRAP_SFAB)
>  #define KUDO_BMC_POWER_ON_STRAPS NPCM7XX_POWER_ON_STRAPS_DEFAULT
> @@ -269,6 +271,109 @@ static void quanta_gsj_fan_init(NPCM7xxMachine 
> *machine, NPCM7xxState *soc)
>      npcm7xx_connect_pwm_fan(soc, &splitter[2], 0x05, 1);
>  }
> 
> +static void quanta_gsz_i2c_init(NPCM7xxState *soc)
> +{
> +    I2CSlave *i2c_mux;
> +
> +    /* i2c1 */
> +    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 1), 
> TYPE_PCA9548,
> +                                      0x75);
> +    /* pca6416@0x20 */
> +
> +    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 1),
> +                                      TYPE_PCA9548, 0x77);
> +
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0), 
> "raa229004", 0x72);
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1), 
> "raa229004", 0x72);
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 2), 
> "isl69260", 0x72);
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 3), 
> "isl69260", 0x72);
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 4), 
> "isl69260", 0x72);
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5), 
> "isl69260", 0x72);
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6), 
> "adm1272", 0x1f);
> +
> +    /* i2c2 */
> +    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 2),
> +                                      TYPE_PCA9548, 0x77);
> +    /*         - channel 0: tps546d24 @25
> +     *         - channel 1: delta,dps800 @69
> +     */
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 1), 
> "raa228000", 0x68);
> +    /*          - channel 2: delta,dps800 @68 */
> +    /* max31725 is compatible with tmp105. */
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 4), "tmp105", 
> 0x5c);
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5), "tmp105", 
> 0x5c);
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6), "tmp105", 
> 0x5c);
> +
> +    /* i2c3 */
> +    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 3), 
> TYPE_PCA9548,
> +                                      0x77);
> +
> +    /* i2c4 */
> +    /* mobo_fru_1 */
> +    at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 4), 0x50, 8192);
> +    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 4),
> +                                      TYPE_PCA9548, 0x77);
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0), 
> "max34451", 0x59);
> +    /* mobo_fru_2 */
> +    at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 2), 0x55, 32768);
> +
> +    /* pca6416@0x20 */
> +    /* pca6416@0x20 */
> +
> +    /* pdb_fru */
> +    at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 6), 0x55, 8192);
> +
> +    /* i2c5 */
> +    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 5), 
> TYPE_PCA9548,
> +                                      0x77);
> +
> +    /* i2c6 */
> +    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 6), 
> TYPE_PCA9548,
> +                                      0x77);
> +
> +    /* i2c7 */
> +    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 7), 
> TYPE_PCA9548,
> +                                      0x77);
> +
> +    /* i2c8 */
> +    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 8), 
> TYPE_PCA9548,
> +                                      0x77);
> +
> +    /* i2c9 */
> +    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 9), 
> TYPE_PCA9548,
> +                                      0x77);
> +
> +    /* i2c10 */
> +    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 10),
> +                                      TYPE_PCA9548, 0x77);
> +
> +    /* i2c11 */
> +    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 11),
> +                                      TYPE_PCA9548, 0x77);
> +
> +    /* i2c12 */
> +

A for () loop to create these devices would be good.

> +    /* i2c13 */
> +    /* pca9555@22 */
> +
> +    /* i2c14 */
> +    /* LEDs and PE Resets */
> +    /* pca6416@0x20 */
> +
> +    /* bmc_fru_1 */
> +    at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 14), 0x55, 8192);
> +
> +    i2c_mux = i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 14),
> +                                      TYPE_PCA9548, 0x77);
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0), 
> "max34451", 0x59);
> +
> +    /* max31725 is compatible with tmp105 */
> +    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 4), "tmp105", 
> 0x5c);
> +
> +    /* i2c15 */
> +    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 15), 
> TYPE_PCA9546, 0x75);
> +}
> +
>  static void quanta_gbs_i2c_init(NPCM7xxState *soc)
>  {
>      /*
> @@ -392,6 +497,25 @@ static void quanta_gsj_init(MachineState *machine)
>      npcm7xx_load_kernel(machine, soc);
> 

