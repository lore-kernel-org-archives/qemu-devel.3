Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E01C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 09:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru7KA-00041y-QY; Tue, 09 Apr 2024 04:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ru7K8-00041b-S6
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 04:59:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ru7K0-00006T-Ti
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 04:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712653155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XM97d+kawLtfFHkl+aUWftvUsjrldwSUxY1vF1OzX3s=;
 b=NRpEBKrZE4OhxtFnAOoX+cK0099L8k944DFYOMJMhVtnOdlfJ9eq+xnhPozKqL+fohVeyb
 rSTtIfeXlO5bD8JC8wvTvd+oQU9mIkxqkUvcYDS+9EwFTpi5jxDm1HOwvFQBQ7S1z48OPK
 rzfqKKWjaOzCepFLQp2d/ZSKQEB9ZOY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-_ATcR2YkOqmPfFr2h8rKCQ-1; Tue, 09 Apr 2024 04:59:12 -0400
X-MC-Unique: _ATcR2YkOqmPfFr2h8rKCQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-343e54fc19bso2533885f8f.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 01:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712653151; x=1713257951;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XM97d+kawLtfFHkl+aUWftvUsjrldwSUxY1vF1OzX3s=;
 b=sD199G3iuldrwiqNTI/DcqVg6pKGNhIrcguebdOnjRea8zSIzcJ7Mw1dL/14wpuVp4
 R7GUisl3NUPjDh8XmPNUf6u/zehr1yRWnhN1eqkV1Nbjmo32N0WEgeJ2cQeAq6CDC62+
 zlsv7gAEoFhSIuMgugzUKbCCK1NT+lD7zT6XeCOKNaPabQvLkdHBrWUjCD+5HMspGzPu
 5fQnJlHvhAI1blY862XMWxTNKcr8eqyA5VCZGQgc8xJLTuPR5UPP2TmWpk9sxpaLFzsb
 Uxp8eKML+aXVbG49Gtbk5xIo7Rsdg5iCKFtzH/sYUvfDjXLS0TJHF1E4QP+hXgY5Zbm3
 NzrQ==
X-Gm-Message-State: AOJu0YxcHTgBhNIl7Ps42n4QW0+kQYvrKOXglMndM28bdlZQ8dorViY8
 kiSprPFh/UibEi82MwuULrw6CnkWsomvvRc3M221z6TtGi/cxWW3kTbrF8x19TsjM7lLGUk/yTu
 cd+Au+tXnozJ094UcwfktQPmcU4itOcVm0bN/XQehfXuyjSqWJ4fFEcB8T1Bob6Xd5Bh5atzpbJ
 X4HcXbULZ3tp0rh+EugnlTFUmHMEQ=
X-Received: by 2002:a5d:618c:0:b0:343:7b6b:dcc6 with SMTP id
 j12-20020a5d618c000000b003437b6bdcc6mr8048974wru.30.1712653150799; 
 Tue, 09 Apr 2024 01:59:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGHCpiPDxQAr3J+Dko/H1boWb2QmppmzEUM9ChWgSS/IE61gKGqB2W4Ge+6a2ll0tApd649dKeXDDOjkkGfjQ=
X-Received: by 2002:a5d:618c:0:b0:343:7b6b:dcc6 with SMTP id
 j12-20020a5d618c000000b003437b6bdcc6mr8048949wru.30.1712653150004; Tue, 09
 Apr 2024 01:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240408213339.83149-1-philmd@linaro.org>
 <20240408213339.83149-4-philmd@linaro.org>
In-Reply-To: <20240408213339.83149-4-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 9 Apr 2024 10:58:57 +0200
Message-ID: <CABgObfaRtv3WwhYzUKSCpee3UQFuwAzUEstX0uFGdRFOV6j4_Q@mail.gmail.com>
Subject: Re: [RFC PATCH-for-9.1 3/4] hw/i2c: Convert to spec v7 terminology
 (automatically)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Corey Minyard <cminyard@mvista.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: multipart/alternative; boundary="000000000000a13c9e0615a622bf"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000a13c9e0615a622bf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 8 apr 2024, 23:34 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> ha
scritto:

> Note, the QOM type definition is not modified, TYPE_I2C_TARGET
> remains defined as "i2c-slave".
>

Is this actually necessary? The only thing that could break is -global but
I don't think it matters really.

Paolo


> [*] https://github.com/conscious-lang/conscious-lang-docs/blob/main/faq.m=
d
>
> Inspired-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/hw/display/i2c-ddc.h     |   2 +-
>  include/hw/gpio/pca9552.h        |   2 +-
>  include/hw/gpio/pca9554.h        |   2 +-
>  include/hw/i2c/aspeed_i2c.h      |   4 +-
>  include/hw/i2c/i2c.h             |  66 ++++-----
>  include/hw/i2c/i2c_mux_pca954x.h |   2 +-
>  include/hw/i2c/smbus_slave.h     |   4 +-
>  include/hw/nvram/eeprom_at24c.h  |   4 +-
>  include/hw/sensor/tmp105.h       |   2 +-
>  hw/arm/aspeed.c                  | 232 +++++++++++++++----------------
>  hw/arm/bananapi_m2u.c            |   2 +-
>  hw/arm/cubieboard.c              |   2 +-
>  hw/arm/musicpal.c                |   6 +-
>  hw/arm/npcm7xx_boards.c          |  44 +++---
>  hw/arm/nseries.c                 |   6 +-
>  hw/arm/pxa2xx.c                  |  36 ++---
>  hw/arm/realview.c                |   2 +-
>  hw/arm/spitz.c                   |  12 +-
>  hw/arm/stellaris.c               |   2 +-
>  hw/arm/tosa.c                    |  14 +-
>  hw/arm/versatilepb.c             |   2 +-
>  hw/arm/vexpress.c                |   2 +-
>  hw/arm/z2.c                      |  20 +--
>  hw/audio/wm8750.c                |  18 +--
>  hw/display/ati.c                 |   4 +-
>  hw/display/i2c-ddc.c             |  10 +-
>  hw/display/sii9022.c             |  16 +--
>  hw/display/sm501.c               |   2 +-
>  hw/display/ssd0303.c             |  14 +-
>  hw/display/xlnx_dp.c             |   2 +-
>  hw/gpio/max7310.c                |  14 +-
>  hw/gpio/pca9552.c                |  14 +-
>  hw/gpio/pca9554.c                |  14 +-
>  hw/gpio/pcf8574.c                |  12 +-
>  hw/i2c/aspeed_i2c.c              |  16 +--
>  hw/i2c/core.c                    |  88 ++++++------
>  hw/i2c/i2c_mux_pca954x.c         |   6 +-
>  hw/i2c/imx_i2c.c                 |   2 +-
>  hw/i2c/smbus_slave.c             |  12 +-
>  hw/input/lm832x.c                |  14 +-
>  hw/misc/axp2xx.c                 |  14 +-
>  hw/misc/i2c-echo.c               |  14 +-
>  hw/nvram/eeprom_at24c.c          |  22 +--
>  hw/ppc/e500.c                    |   2 +-
>  hw/ppc/pnv.c                     |   4 +-
>  hw/ppc/sam460ex.c                |   2 +-
>  hw/rtc/ds1338.c                  |  14 +-
>  hw/rtc/m41t80.c                  |  12 +-
>  hw/rtc/twl92230.c                |  16 +--
>  hw/sensor/dps310.c               |  14 +-
>  hw/sensor/emc141x.c              |  16 +--
>  hw/sensor/lsm303dlhc_mag.c       |  16 +--
>  hw/sensor/tmp105.c               |  16 +--
>  hw/sensor/tmp421.c               |  20 +--
>  hw/tpm/tpm_tis_i2c.c             |  12 +-
>  55 files changed, 461 insertions(+), 461 deletions(-)
>
> diff --git a/include/hw/display/i2c-ddc.h b/include/hw/display/i2c-ddc.h
> index 94b5880587..faf3cd84fa 100644
> --- a/include/hw/display/i2c-ddc.h
> +++ b/include/hw/display/i2c-ddc.h
> @@ -26,7 +26,7 @@
>  /* A simple I2C slave which just returns the contents of its EDID blob. =
*/
>  struct I2CDDCState {
>      /*< private >*/
> -    I2CSlave i2c;
> +    I2CTarget i2c;
>      /*< public >*/
>      bool firstbyte;
>      uint8_t reg;
> diff --git a/include/hw/gpio/pca9552.h b/include/hw/gpio/pca9552.h
> index c36525f0c3..d7f07a44e0 100644
> --- a/include/hw/gpio/pca9552.h
> +++ b/include/hw/gpio/pca9552.h
> @@ -23,7 +23,7 @@ DECLARE_INSTANCE_CHECKER(PCA955xState, PCA955X,
>
>  struct PCA955xState {
>      /*< private >*/
> -    I2CSlave i2c;
> +    I2CTarget i2c;
>      /*< public >*/
>
>      uint8_t len;
> diff --git a/include/hw/gpio/pca9554.h b/include/hw/gpio/pca9554.h
> index 54bfc4c4c7..0b528a0033 100644
> --- a/include/hw/gpio/pca9554.h
> +++ b/include/hw/gpio/pca9554.h
> @@ -21,7 +21,7 @@ DECLARE_INSTANCE_CHECKER(PCA9554State, PCA9554,
>
>  struct PCA9554State {
>      /*< private >*/
> -    I2CSlave i2c;
> +    I2CTarget i2c;
>      /*< public >*/
>
>      uint8_t len;
> diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
> index a064479e59..d8fd179a69 100644
> --- a/include/hw/i2c/aspeed_i2c.h
> +++ b/include/hw/i2c/aspeed_i2c.h
> @@ -236,7 +236,7 @@ struct AspeedI2CBus {
>      struct AspeedI2CState *controller;
>
>      /* slave mode */
> -    I2CSlave *slave;
> +    I2CTarget *slave;
>
>      MemoryRegion mr;
>
> @@ -267,7 +267,7 @@ struct AspeedI2CState {
>  #define TYPE_ASPEED_I2C_BUS_SLAVE "aspeed.i2c.slave"
>  OBJECT_DECLARE_SIMPLE_TYPE(AspeedI2CBusSlave, ASPEED_I2C_BUS_SLAVE)
>  struct AspeedI2CBusSlave {
> -    I2CSlave i2c;
> +    I2CTarget i2c;
>  };
>
>  struct AspeedI2CClass {
> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> index a1b3f4d179..fa00098477 100644
> --- a/include/hw/i2c/i2c.h
> +++ b/include/hw/i2c/i2c.h
> @@ -21,34 +21,34 @@ enum i2c_event {
>
>  typedef struct I2CNodeList I2CNodeList;
>
> -#define TYPE_I2C_SLAVE "i2c-slave"
> -OBJECT_DECLARE_TYPE(I2CSlave, I2CSlaveClass,
> -                    I2C_SLAVE)
> +#define TYPE_I2C_TARGET "i2c-slave"
> +OBJECT_DECLARE_TYPE(I2CTarget, I2CTargetClass,
> +                    I2C_TARGET)
>
> -struct I2CSlaveClass {
> +struct I2CTargetClass {
>      DeviceClass parent_class;
>
>      /* Master to slave. Returns non-zero for a NAK, 0 for success. */
> -    int (*send)(I2CSlave *s, uint8_t data);
> +    int (*send)(I2CTarget *s, uint8_t data);
>
>      /*
>       * Master to slave (asynchronous).
>       * Receiving slave must call i2c_ack().
>       */
> -    void (*send_async)(I2CSlave *s, uint8_t data);
> +    void (*send_async)(I2CTarget *s, uint8_t data);
>
>      /*
>       * Slave to master.  This cannot fail, the device should always
>       * return something here.
>       */
> -    uint8_t (*recv)(I2CSlave *s);
> +    uint8_t (*recv)(I2CTarget *s);
>
>      /*
>       * Notify the slave of a bus state change.  For start event,
>       * returns non-zero to NAK an operation.  For other events the
>       * return code is not used and should be zero.
>       */
> -    int (*event)(I2CSlave *s, enum i2c_event event);
> +    int (*event)(I2CTarget *s, enum i2c_event event);
>
>      /*
>       * Check if this device matches the address provided.  Returns bool =
of
> @@ -57,11 +57,11 @@ struct I2CSlaveClass {
>       *
>       * If broadcast is true, match should add the device and return true=
.
>       */
> -    bool (*match_and_add)(I2CSlave *candidate, uint8_t address, bool
> broadcast,
> +    bool (*match_and_add)(I2CTarget *candidate, uint8_t address, bool
> broadcast,
>                            I2CNodeList *current_devs);
>  };
>
> -struct I2CSlave {
> +struct I2CTarget {
>      DeviceState qdev;
>
>      /* Remaining fields for internal use by the I2C code.  */
> @@ -74,25 +74,25 @@ OBJECT_DECLARE_SIMPLE_TYPE(I2CBus, I2C_BUS)
>  typedef struct I2CNode I2CNode;
>
>  struct I2CNode {
> -    I2CSlave *elt;
> +    I2CTarget *elt;
>      QLIST_ENTRY(I2CNode) next;
>  };
>
> -typedef struct I2CPendingMaster I2CPendingMaster;
> +typedef struct I2CPendingController I2CPendingController;
>
> -struct I2CPendingMaster {
> +struct I2CPendingController {
>      QEMUBH *bh;
> -    QSIMPLEQ_ENTRY(I2CPendingMaster) entry;
> +    QSIMPLEQ_ENTRY(I2CPendingController) entry;
>  };
>
>  typedef QLIST_HEAD(I2CNodeList, I2CNode) I2CNodeList;
> -typedef QSIMPLEQ_HEAD(I2CPendingMasters, I2CPendingMaster)
> -            I2CPendingMasters;
> +typedef QSIMPLEQ_HEAD(I2CPendingControllers, I2CPendingController)
> +            I2CPendingControllers;
>
>  struct I2CBus {
>      BusState qbus;
>      I2CNodeList current_devs;
> -    I2CPendingMasters pending_masters;
> +    I2CPendingControllers pending_controllers;
>      uint8_t saved_address;
>      bool broadcast;
>
> @@ -147,12 +147,12 @@ int i2c_start_send(I2CBus *bus, uint8_t address);
>   */
>  int i2c_start_send_async(I2CBus *bus, uint8_t address);
>
> -void i2c_schedule_pending_master(I2CBus *bus);
> +void i2c_schedule_pending_controller(I2CBus *bus);
>
>  void i2c_end_transfer(I2CBus *bus);
>  void i2c_nack(I2CBus *bus);
>  void i2c_ack(I2CBus *bus);
> -void i2c_bus_master(I2CBus *bus, QEMUBH *bh);
> +void i2c_bus_controller(I2CBus *bus, QEMUBH *bh);
>  void i2c_bus_release(I2CBus *bus);
>  int i2c_send(I2CBus *bus, uint8_t data);
>  int i2c_send_async(I2CBus *bus, uint8_t data);
> @@ -169,7 +169,7 @@ bool i2c_scan_bus(I2CBus *bus, uint8_t address, bool
> broadcast,
>   * properties to be set. Type @name must exist. The device still
>   * needs to be realized. See qdev-core.h.
>   */
> -I2CSlave *i2c_slave_new(const char *name, uint8_t addr);
> +I2CTarget *i2c_target_new(const char *name, uint8_t addr);
>
>  /**
>   * Create and realize an I2C slave device on the heap.
> @@ -180,8 +180,8 @@ I2CSlave *i2c_slave_new(const char *name, uint8_t
> addr);
>   * Create the device state structure, initialize it, put it on the
>   * specified @bus, and drop the reference to it (the device is realized)=
.
>   */
> -I2CSlave *i2c_slave_create_simple(I2CBus *bus,
> -                                  const char *name, uint8_t addr);
> +I2CTarget *i2c_target_create_simple(I2CBus *bus,
> +                                    const char *name, uint8_t addr);
>
>  /**
>   * Realize and drop a reference an I2C slave device
> @@ -196,10 +196,10 @@ I2CSlave *i2c_slave_create_simple(I2CBus *bus,
>   * reference to it.
>   *
>   * This function is useful if you have created @dev via qdev_new(),
> - * i2c_slave_new() or i2c_slave_try_new() (which take a reference to
> + * i2c_target_new() or i2c_slave_try_new() (which take a reference to
>   * the device it returns to you), so that you can set properties on it
>   * before realizing it. If you don't need to set properties then
> - * i2c_slave_create_simple() is probably better (as it does the create,
> + * i2c_target_create_simple() is probably better (as it does the create,
>   * init and realize in one step).
>   *
>   * If you are embedding the I2C slave into another QOM device and
> @@ -211,23 +211,23 @@ I2CSlave *i2c_slave_create_simple(I2CBus *bus,
>   * which doesn't currently exist but would be trivial to create if we
>   * had any code that wanted it.)
>   */
> -bool i2c_slave_realize_and_unref(I2CSlave *dev, I2CBus *bus, Error
> **errp);
> +bool i2c_target_realize_and_unref(I2CTarget *dev, I2CBus *bus, Error
> **errp);
>
>  /**
>   * Set the I2C bus address of a slave device
>   * @dev: I2C slave device
>   * @address: I2C address of the slave when put on a bus
>   */
> -void i2c_slave_set_address(I2CSlave *dev, uint8_t address);
> +void i2c_target_set_address(I2CTarget *dev, uint8_t address);
>
> -extern const VMStateDescription vmstate_i2c_slave;
> +extern const VMStateDescription vmstate_i2c_target;
>
> -#define VMSTATE_I2C_SLAVE(_field, _state) {                          \
> -    .name       =3D (stringify(_field)),                               \
> -    .size       =3D sizeof(I2CSlave),                                  \
> -    .vmsd       =3D &vmstate_i2c_slave,                                \
> -    .flags      =3D VMS_STRUCT,                                        \
> -    .offset     =3D vmstate_offset_value(_state, _field, I2CSlave),    \
> +#define VMSTATE_I2C_TARGET(_field, _state) {                          \
> +    .name       =3D (stringify(_field)),                                =
\
> +    .size       =3D sizeof(I2CTarget),                                  =
\
> +    .vmsd       =3D &vmstate_i2c_target,                                =
\
> +    .flags      =3D VMS_STRUCT,                                         =
\
> +    .offset     =3D vmstate_offset_value(_state, _field, I2CTarget),    =
\
>  }
>
>  #endif
> diff --git a/include/hw/i2c/i2c_mux_pca954x.h
> b/include/hw/i2c/i2c_mux_pca954x.h
> index 3dd25ec983..89f6179dd2 100644
> --- a/include/hw/i2c/i2c_mux_pca954x.h
> +++ b/include/hw/i2c/i2c_mux_pca954x.h
> @@ -14,6 +14,6 @@
>   *
>   * Returns: a pointer to the associated i2c bus.
>   */
> -I2CBus *pca954x_i2c_get_bus(I2CSlave *mux, uint8_t channel);
> +I2CBus *pca954x_i2c_get_bus(I2CTarget *mux, uint8_t channel);
>
>  #endif
> diff --git a/include/hw/i2c/smbus_slave.h b/include/hw/i2c/smbus_slave.h
> index 86bfe0a79e..04f4dc4f22 100644
> --- a/include/hw/i2c/smbus_slave.h
> +++ b/include/hw/i2c/smbus_slave.h
> @@ -34,7 +34,7 @@ OBJECT_DECLARE_TYPE(SMBusDevice, SMBusDeviceClass,
>
>
>  struct SMBusDeviceClass {
> -    I2CSlaveClass parent_class;
> +    I2CTargetClass parent_class;
>
>      /*
>       * An operation with no data, special in SMBus.
> @@ -68,7 +68,7 @@ struct SMBusDeviceClass {
>
>  struct SMBusDevice {
>      /* The SMBus protocol is implemented on top of I2C.  */
> -    I2CSlave i2c;
> +    I2CTarget i2c;
>
>      /* Remaining fields for internal use only.  */
>      int32_t mode;
> diff --git a/include/hw/nvram/eeprom_at24c.h
> b/include/hw/nvram/eeprom_at24c.h
> index 9d29f0a69a..caf06e52c7 100644
> --- a/include/hw/nvram/eeprom_at24c.h
> +++ b/include/hw/nvram/eeprom_at24c.h
> @@ -18,7 +18,7 @@
>   * Create the device state structure, initialize it, put it on the
> specified
>   * @bus, and drop the reference to it (the device is realized).
>   */
> -I2CSlave *at24c_eeprom_init(I2CBus *bus, uint8_t address, uint32_t
> rom_size);
> +I2CTarget *at24c_eeprom_init(I2CBus *bus, uint8_t address, uint32_t
> rom_size);
>
>
>  /*
> @@ -33,7 +33,7 @@ I2CSlave *at24c_eeprom_init(I2CBus *bus, uint8_t
> address, uint32_t rom_size);
>   * @bus, and drop the reference to it (the device is realized). Copies
> the data
>   * from @init_rom to the beginning of the EEPROM memory buffer.
>   */
> -I2CSlave *at24c_eeprom_init_rom(I2CBus *bus,
> +I2CTarget *at24c_eeprom_init_rom(I2CBus *bus,
>                                  uint8_t address, uint32_t rom_size,
>                                  const uint8_t *init_rom,
>                                  uint32_t init_rom_size);
> diff --git a/include/hw/sensor/tmp105.h b/include/hw/sensor/tmp105.h
> index 244e2989fe..6034671fc4 100644
> --- a/include/hw/sensor/tmp105.h
> +++ b/include/hw/sensor/tmp105.h
> @@ -30,7 +30,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(TMP105State, TMP105)
>   */
>  struct TMP105State {
>      /*< private >*/
> -    I2CSlave i2c;
> +    I2CTarget i2c;
>      /*< public >*/
>
>      uint8_t len;
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 8279ad748a..d95d310b1a 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -459,13 +459,13 @@ static void palmetto_bmc_i2c_init(AspeedMachineStat=
e
> *bmc)
>
>      /* The palmetto platform expects a ds3231 RTC but a ds1338 is
>       * enough to provide basic RTC features. Alarms will be missing */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338",
> 0x68);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338",
> 0x68);
>
>      smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
>                            eeprom_buf);
>
>      /* add a TMP423 temperature sensor */
> -    dev =3D DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c,=
 2),
> +    dev =3D DEVICE(i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c=
,
> 2),
>                                           "tmp423", 0x4c));
>      object_property_set_int(OBJECT(dev), "temperature0", 31000,
> &error_abort);
>      object_property_set_int(OBJECT(dev), "temperature1", 28000,
> &error_abort);
> @@ -481,21 +481,21 @@ static void
> quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
>       * The quanta-q71l platform expects tmp75s which are compatible with
>       * tmp105s.
>       */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105",
> 0x4c);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105",
> 0x4e);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105",
> 0x4f);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105",
> 0x4c);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105",
> 0x4e);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105",
> 0x4f);
>
>      /* TODO: i2c-1: Add baseboard FRU eeprom@54 24c64 */
>      /* TODO: i2c-1: Add Frontpanel FRU eeprom@57 24c64 */
>      /* TODO: Add Memory Riser i2c mux and eeproms. */
>
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9546",
> 0x74);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9548",
> 0x77);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9546"=
,
> 0x74);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9548"=
,
> 0x77);
>
>      /* TODO: i2c-3: Add BIOS FRU eeprom@56 24c64 */
>
>      /* i2c-7 */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), "pca9546",
> 0x70);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), "pca9546"=
,
> 0x70);
>      /*        - i2c@0: pmbus@59 */
>      /*        - i2c@1: pmbus@58 */
>      /*        - i2c@2: pmbus@58 */
> @@ -514,7 +514,7 @@ static void ast2500_evb_i2c_init(AspeedMachineState
> *bmc)
>                            eeprom_buf);
>
>      /* The AST2500 EVB expects a LM75 but a TMP105 is compatible */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
>                       TYPE_TMP105, 0x4d);
>  }
>
> @@ -527,7 +527,7 @@ static void ast2600_evb_i2c_init(AspeedMachineState
> *bmc)
>                            eeprom_buf);
>
>      /* LM75 is compatible with TMP105 driver */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
>                       TYPE_TMP105, 0x4d);
>  }
>
> @@ -539,9 +539,9 @@ static void yosemitev2_bmc_i2c_init(AspeedMachineStat=
e
> *bmc)
>      at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x51, 128 *
> KiB,
>                            yosemitev2_bmc_fruid, yosemitev2_bmc_fruid_len=
);
>      /* TMP421 */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "tmp421",
> 0x1f);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp421",
> 0x4e);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp421",
> 0x4f);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "tmp421"=
,
> 0x1f);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp421",
> 0x4e);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp421",
> 0x4f);
>
>  }
>
> @@ -551,7 +551,7 @@ static void romulus_bmc_i2c_init(AspeedMachineState
> *bmc)
>
>      /* The romulus board expects Epson RX8900 I2C RTC but a ds1338 is
>       * good enough */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338",
> 0x32);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338"=
,
> 0x32);
>  }
>
>  static void tiogapass_bmc_i2c_init(AspeedMachineState *bmc)
> @@ -562,14 +562,14 @@ static void
> tiogapass_bmc_i2c_init(AspeedMachineState *bmc)
>      at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 6), 0x54, 128 *
> KiB,
>                            tiogapass_bmc_fruid, tiogapass_bmc_fruid_len);
>      /* TMP421 */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8), "tmp421",
> 0x1f);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp421",
> 0x4f);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp421",
> 0x4e);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8), "tmp421",
> 0x1f);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp421",
> 0x4f);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp421",
> 0x4e);
>  }
>
>  static void create_pca9552(AspeedSoCState *soc, int bus_id, int addr)
>  {
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, bus_id),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, bus_id),
>                              TYPE_PCA9552, addr);
>  }
>
> @@ -578,8 +578,8 @@ static void sonorapass_bmc_i2c_init(AspeedMachineStat=
e
> *bmc)
>      AspeedSoCState *soc =3D bmc->soc;
>
>      /* bus 2 : */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "tmp105",
> 0x48);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "tmp105",
> 0x49);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "tmp105",
> 0x48);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "tmp105",
> 0x49);
>      /* bus 2 : pca9546 @ 0x73 */
>
>      /* bus 3 : pca9548 @ 0x70 */
> @@ -594,8 +594,8 @@ static void sonorapass_bmc_i2c_init(AspeedMachineStat=
e
> *bmc)
>      create_pca9552(soc, 4, 0x77);
>
>      /* bus 6 : */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp105",
> 0x48);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp105",
> 0x49);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp105",
> 0x48);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp105",
> 0x49);
>      /* bus 6 : pca9546 @ 0x73 */
>
>      /* bus 8 : */
> @@ -635,9 +635,9 @@ static void
> witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
>      LEDState *led;
>
>      /* Bus 3: TODO bmp280@77 */
> -    dev =3D DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));
> +    dev =3D DEVICE(i2c_target_new(TYPE_PCA9552, 0x60));
>      qdev_prop_set_string(dev, "description", "pca1");
> -    i2c_slave_realize_and_unref(I2C_SLAVE(dev),
> +    i2c_target_realize_and_unref(I2C_SLAVE(dev),
>                                  aspeed_i2c_get_bus(&soc->i2c, 3),
>                                  &error_fatal);
>
> @@ -649,29 +649,29 @@ static void
> witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
>          qdev_connect_gpio_out(dev, pca1_leds[i].gpio_id,
>                                qdev_get_gpio_in(DEVICE(led), 0));
>      }
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3),
>                              "dps310", 0x76);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3),
>                              "max31785", 0x52);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
>                              "tmp423", 0x4c);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
>                              "tmp423", 0x4c);
>
>      /* The Witherspoon expects a TMP275 but a TMP105 is compatible */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
>                              TYPE_TMP105, 0x4a);
>
>      /* The witherspoon board expects Epson RX8900 I2C RTC but a ds1338 i=
s
>       * good enough */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
>                              "ds1338", 0x32);
>
>      smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 11), 0x51,
>                            eeprom_buf);
> -    dev =3D DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));
> +    dev =3D DEVICE(i2c_target_new(TYPE_PCA9552, 0x60));
>      qdev_prop_set_string(dev, "description", "pca0");
> -    i2c_slave_realize_and_unref(I2C_SLAVE(dev),
> +    i2c_target_realize_and_unref(I2C_SLAVE(dev),
>                                  aspeed_i2c_get_bus(&soc->i2c, 11),
>                                  &error_fatal);
>      /* Bus 11: TODO ucd90160@64 */
> @@ -682,19 +682,19 @@ static void g220a_bmc_i2c_init(AspeedMachineState
> *bmc)
>      AspeedSoCState *soc =3D bmc->soc;
>      DeviceState *dev;
>
> -    dev =3D DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c,=
 3),
> +    dev =3D DEVICE(i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c=
,
> 3),
>                                           "emc1413", 0x4c));
>      object_property_set_int(OBJECT(dev), "temperature0", 31000,
> &error_abort);
>      object_property_set_int(OBJECT(dev), "temperature1", 28000,
> &error_abort);
>      object_property_set_int(OBJECT(dev), "temperature2", 20000,
> &error_abort);
>
> -    dev =3D DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c,
> 12),
> +    dev =3D DEVICE(i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c=
,
> 12),
>                                           "emc1413", 0x4c));
>      object_property_set_int(OBJECT(dev), "temperature0", 31000,
> &error_abort);
>      object_property_set_int(OBJECT(dev), "temperature1", 28000,
> &error_abort);
>      object_property_set_int(OBJECT(dev), "temperature2", 20000,
> &error_abort);
>
> -    dev =3D DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c,
> 13),
> +    dev =3D DEVICE(i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c=
,
> 13),
>                                           "emc1413", 0x4c));
>      object_property_set_int(OBJECT(dev), "temperature0", 31000,
> &error_abort);
>      object_property_set_int(OBJECT(dev), "temperature1", 28000,
> &error_abort);
> @@ -716,25 +716,25 @@ static void g220a_bmc_i2c_init(AspeedMachineState
> *bmc)
>  static void fp5280g2_bmc_i2c_init(AspeedMachineState *bmc)
>  {
>      AspeedSoCState *soc =3D bmc->soc;
> -    I2CSlave *i2c_mux;
> +    I2CTarget *i2c_mux;
>
>      /* The at24c256 */
>      at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 1), 0x50, 32768);
>
>      /* The fp5280g2 expects a TMP112 but a TMP105 is compatible */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
>                              TYPE_TMP105, 0x48);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
>                              TYPE_TMP105, 0x49);
>
> -    i2c_mux =3D i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2)=
,
> +    i2c_mux =3D i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2=
),
>                       "pca9546", 0x70);
>      /* It expects a TMP112 but a TMP105 is compatible */
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
> +    i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
>                              TYPE_TMP105, 0x4a);
>
>      /* It expects a ds3232 but a ds1338 is good enough */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
>                              "ds1338", 0x68);
>
>      /* It expects a pca9555 but a pca9552 is compatible */
> @@ -744,44 +744,44 @@ static void fp5280g2_bmc_i2c_init(AspeedMachineStat=
e
> *bmc)
>  static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
>  {
>      AspeedSoCState *soc =3D bmc->soc;
> -    I2CSlave *i2c_mux;
> +    I2CTarget *i2c_mux;
>
>      at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 0), 0x51, 32 * KiB);
>
>      create_pca9552(soc, 3, 0x61);
>
>      /* The rainier expects a TMP275 but a TMP105 is compatible */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
>                              TYPE_TMP105, 0x48);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
>                              TYPE_TMP105, 0x49);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
>                              TYPE_TMP105, 0x4a);
> -    i2c_mux =3D i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4)=
,
> +    i2c_mux =3D i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4=
),
>                                        "pca9546", 0x70);
>      at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
>      at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
>      at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 2), 0x52, 64 * KiB);
>      create_pca9552(soc, 4, 0x60);
>
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
>                              TYPE_TMP105, 0x48);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
>                              TYPE_TMP105, 0x49);
>      create_pca9552(soc, 5, 0x60);
>      create_pca9552(soc, 5, 0x61);
> -    i2c_mux =3D i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5)=
,
> +    i2c_mux =3D i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5=
),
>                                        "pca9546", 0x70);
>      at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
>      at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
>
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
>                              TYPE_TMP105, 0x48);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
>                              TYPE_TMP105, 0x4a);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
>                              TYPE_TMP105, 0x4b);
> -    i2c_mux =3D i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6)=
,
> +    i2c_mux =3D i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6=
),
>                                        "pca9546", 0x70);
>      at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
>      at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
> @@ -794,19 +794,19 @@ static void rainier_bmc_i2c_init(AspeedMachineState
> *bmc)
>      create_pca9552(soc, 7, 0x33);
>      create_pca9552(soc, 7, 0x60);
>      create_pca9552(soc, 7, 0x61);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
>                              "dps310", 0x76);
>      /* Bus 7: TODO si7021-a20@20 */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
>                              TYPE_TMP105, 0x48);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
>                              "max31785", 0x52);
>      at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 7), 0x50, 64 * KiB);
>      at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 7), 0x51, 64 * KiB);
>
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
>                              TYPE_TMP105, 0x48);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
>                              TYPE_TMP105, 0x4a);
>      at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x50,
>                            64 * KiB, rainier_bb_fruid,
> rainier_bb_fruid_len);
> @@ -818,23 +818,23 @@ static void rainier_bmc_i2c_init(AspeedMachineState
> *bmc)
>      /* Bus 8: ucd90320@b */
>      /* Bus 8: ucd90320@c */
>
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
>                              "tmp423", 0x4c);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
>                              "tmp423", 0x4d);
>      at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 9), 0x50, 128 * KiB)=
;
>
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10),
>                              "tmp423", 0x4c);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10),
>                              "tmp423", 0x4d);
>      at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 10), 0x50, 128 * KiB=
);
>
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
>                              TYPE_TMP105, 0x48);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
>                              TYPE_TMP105, 0x49);
> -    i2c_mux =3D i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11=
),
> +    i2c_mux =3D i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1=
1),
>                                        "pca9546", 0x70);
>      at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
>      at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
> @@ -854,7 +854,7 @@ static void rainier_bmc_i2c_init(AspeedMachineState
> *bmc)
>  static void get_pca9548_channels(I2CBus *bus, uint8_t mux_addr,
>                                   I2CBus **channels)
>  {
> -    I2CSlave *mux =3D i2c_slave_create_simple(bus, "pca9548", mux_addr);
> +    I2CTarget *mux =3D i2c_target_create_simple(bus, "pca9548", mux_addr=
);
>      for (int i =3D 0; i < 8; i++) {
>          channels[i] =3D pca954x_i2c_get_bus(mux, i);
>      }
> @@ -888,8 +888,8 @@ static void fuji_bmc_i2c_init(AspeedMachineState *bmc=
)
>          get_pca9548_channels(i2c[40 + i], 0x76, &i2c[80 + i * 8]);
>      }
>
> -    i2c_slave_create_simple(i2c[17], TYPE_LM75, 0x4c);
> -    i2c_slave_create_simple(i2c[17], TYPE_LM75, 0x4d);
> +    i2c_target_create_simple(i2c[17], TYPE_LM75, 0x4c);
> +    i2c_target_create_simple(i2c[17], TYPE_LM75, 0x4d);
>
>      /*
>       * EEPROM 24c64 size is 64Kbits or 8 Kbytes
> @@ -899,33 +899,33 @@ static void fuji_bmc_i2c_init(AspeedMachineState
> *bmc)
>      at24c_eeprom_init(i2c[20], 0x50, 256);
>      at24c_eeprom_init(i2c[22], 0x52, 256);
>
> -    i2c_slave_create_simple(i2c[3], TYPE_LM75, 0x48);
> -    i2c_slave_create_simple(i2c[3], TYPE_LM75, 0x49);
> -    i2c_slave_create_simple(i2c[3], TYPE_LM75, 0x4a);
> -    i2c_slave_create_simple(i2c[3], TYPE_TMP422, 0x4c);
> +    i2c_target_create_simple(i2c[3], TYPE_LM75, 0x48);
> +    i2c_target_create_simple(i2c[3], TYPE_LM75, 0x49);
> +    i2c_target_create_simple(i2c[3], TYPE_LM75, 0x4a);
> +    i2c_target_create_simple(i2c[3], TYPE_TMP422, 0x4c);
>
>      at24c_eeprom_init(i2c[8], 0x51, 8 * KiB);
> -    i2c_slave_create_simple(i2c[8], TYPE_LM75, 0x4a);
> +    i2c_target_create_simple(i2c[8], TYPE_LM75, 0x4a);
>
> -    i2c_slave_create_simple(i2c[50], TYPE_LM75, 0x4c);
> +    i2c_target_create_simple(i2c[50], TYPE_LM75, 0x4c);
>      at24c_eeprom_init(i2c[50], 0x52, 8 * KiB);
> -    i2c_slave_create_simple(i2c[51], TYPE_TMP75, 0x48);
> -    i2c_slave_create_simple(i2c[52], TYPE_TMP75, 0x49);
> +    i2c_target_create_simple(i2c[51], TYPE_TMP75, 0x48);
> +    i2c_target_create_simple(i2c[52], TYPE_TMP75, 0x49);
>
> -    i2c_slave_create_simple(i2c[59], TYPE_TMP75, 0x48);
> -    i2c_slave_create_simple(i2c[60], TYPE_TMP75, 0x49);
> +    i2c_target_create_simple(i2c[59], TYPE_TMP75, 0x48);
> +    i2c_target_create_simple(i2c[60], TYPE_TMP75, 0x49);
>
>      at24c_eeprom_init(i2c[65], 0x53, 8 * KiB);
> -    i2c_slave_create_simple(i2c[66], TYPE_TMP75, 0x49);
> -    i2c_slave_create_simple(i2c[66], TYPE_TMP75, 0x48);
> +    i2c_target_create_simple(i2c[66], TYPE_TMP75, 0x49);
> +    i2c_target_create_simple(i2c[66], TYPE_TMP75, 0x48);
>      at24c_eeprom_init(i2c[68], 0x52, 8 * KiB);
>      at24c_eeprom_init(i2c[69], 0x52, 8 * KiB);
>      at24c_eeprom_init(i2c[70], 0x52, 8 * KiB);
>      at24c_eeprom_init(i2c[71], 0x52, 8 * KiB);
>
>      at24c_eeprom_init(i2c[73], 0x53, 8 * KiB);
> -    i2c_slave_create_simple(i2c[74], TYPE_TMP75, 0x49);
> -    i2c_slave_create_simple(i2c[74], TYPE_TMP75, 0x48);
> +    i2c_target_create_simple(i2c[74], TYPE_TMP75, 0x49);
> +    i2c_target_create_simple(i2c[74], TYPE_TMP75, 0x48);
>      at24c_eeprom_init(i2c[76], 0x52, 8 * KiB);
>      at24c_eeprom_init(i2c[77], 0x52, 8 * KiB);
>      at24c_eeprom_init(i2c[78], 0x52, 8 * KiB);
> @@ -934,9 +934,9 @@ static void fuji_bmc_i2c_init(AspeedMachineState *bmc=
)
>
>      for (int i =3D 0; i < 8; i++) {
>          at24c_eeprom_init(i2c[81 + i * 8], 0x56, 64 * KiB);
> -        i2c_slave_create_simple(i2c[82 + i * 8], TYPE_TMP75, 0x48);
> -        i2c_slave_create_simple(i2c[83 + i * 8], TYPE_TMP75, 0x4b);
> -        i2c_slave_create_simple(i2c[84 + i * 8], TYPE_TMP75, 0x4a);
> +        i2c_target_create_simple(i2c[82 + i * 8], TYPE_TMP75, 0x48);
> +        i2c_target_create_simple(i2c[83 + i * 8], TYPE_TMP75, 0x4b);
> +        i2c_target_create_simple(i2c[84 + i * 8], TYPE_TMP75, 0x4a);
>      }
>  }
>
> @@ -957,35 +957,35 @@ static void
> bletchley_bmc_i2c_init(AspeedMachineState *bmc)
>      for (int i =3D 0; i < 6; i++) {
>          /* Missing model: ti,ina230 @ 0x45 */
>          /* Missing model: mps,mp5023 @ 0x40 */
> -        i2c_slave_create_simple(i2c[i], TYPE_TMP421, 0x4f);
> +        i2c_target_create_simple(i2c[i], TYPE_TMP421, 0x4f);
>          /* Missing model: nxp,pca9539 @ 0x76, but PCA9552 works enough *=
/
> -        i2c_slave_create_simple(i2c[i], TYPE_PCA9552, 0x76);
> -        i2c_slave_create_simple(i2c[i], TYPE_PCA9552, 0x67);
> +        i2c_target_create_simple(i2c[i], TYPE_PCA9552, 0x76);
> +        i2c_target_create_simple(i2c[i], TYPE_PCA9552, 0x67);
>          /* Missing model: fsc,fusb302 @ 0x22 */
>      }
>
>      /* Bus 6 */
>      at24c_eeprom_init(i2c[6], 0x56, 65536);
>      /* Missing model: nxp,pcf85263 @ 0x51 , but ds1338 works enough */
> -    i2c_slave_create_simple(i2c[6], "ds1338", 0x51);
> +    i2c_target_create_simple(i2c[6], "ds1338", 0x51);
>
>
>      /* Bus 7 */
>      at24c_eeprom_init(i2c[7], 0x54, 65536);
>
>      /* Bus 9 */
> -    i2c_slave_create_simple(i2c[9], TYPE_TMP421, 0x4f);
> +    i2c_target_create_simple(i2c[9], TYPE_TMP421, 0x4f);
>
>      /* Bus 10 */
> -    i2c_slave_create_simple(i2c[10], TYPE_TMP421, 0x4f);
> +    i2c_target_create_simple(i2c[10], TYPE_TMP421, 0x4f);
>      /* Missing model: ti,hdc1080 @ 0x40 */
> -    i2c_slave_create_simple(i2c[10], TYPE_PCA9552, 0x67);
> +    i2c_target_create_simple(i2c[10], TYPE_PCA9552, 0x67);
>
>      /* Bus 12 */
>      /* Missing model: adi,adm1278 @ 0x11 */
> -    i2c_slave_create_simple(i2c[12], TYPE_TMP421, 0x4c);
> -    i2c_slave_create_simple(i2c[12], TYPE_TMP421, 0x4d);
> -    i2c_slave_create_simple(i2c[12], TYPE_PCA9552, 0x67);
> +    i2c_target_create_simple(i2c[12], TYPE_TMP421, 0x4c);
> +    i2c_target_create_simple(i2c[12], TYPE_TMP421, 0x4d);
> +    i2c_target_create_simple(i2c[12], TYPE_PCA9552, 0x67);
>  }
>
>  static void fby35_i2c_init(AspeedMachineState *bmc)
> @@ -997,12 +997,12 @@ static void fby35_i2c_init(AspeedMachineState *bmc)
>          i2c[i] =3D aspeed_i2c_get_bus(&soc->i2c, i);
>      }
>
> -    i2c_slave_create_simple(i2c[2], TYPE_LM75, 0x4f);
> -    i2c_slave_create_simple(i2c[8], TYPE_TMP421, 0x1f);
> +    i2c_target_create_simple(i2c[2], TYPE_LM75, 0x4f);
> +    i2c_target_create_simple(i2c[8], TYPE_TMP421, 0x1f);
>      /* Hotswap controller is actually supposed to be mp5920 or ltc4282. =
*/
> -    i2c_slave_create_simple(i2c[11], "adm1272", 0x44);
> -    i2c_slave_create_simple(i2c[12], TYPE_LM75, 0x4e);
> -    i2c_slave_create_simple(i2c[12], TYPE_LM75, 0x4f);
> +    i2c_target_create_simple(i2c[11], "adm1272", 0x44);
> +    i2c_target_create_simple(i2c[12], TYPE_LM75, 0x4e);
> +    i2c_target_create_simple(i2c[12], TYPE_LM75, 0x4f);
>
>      at24c_eeprom_init(i2c[4], 0x51, 128 * KiB);
>      at24c_eeprom_init(i2c[6], 0x51, 128 * KiB);
> @@ -1024,14 +1024,14 @@ static void
> qcom_dc_scm_bmc_i2c_init(AspeedMachineState *bmc)
>  {
>      AspeedSoCState *soc =3D bmc->soc;
>
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 15),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 15),
>                              "tmp105", 0x4d);
>  }
>
>  static void qcom_dc_scm_firework_i2c_init(AspeedMachineState *bmc)
>  {
>      AspeedSoCState *soc =3D bmc->soc;
> -    I2CSlave *therm_mux, *cpuvr_mux;
> +    I2CTarget *therm_mux, *cpuvr_mux;
>
>      /* Create the generic DC-SCM hardware */
>      qcom_dc_scm_bmc_i2c_init(bmc);
> @@ -1039,35 +1039,35 @@ static void
> qcom_dc_scm_firework_i2c_init(AspeedMachineState *bmc)
>      /* Now create the Firework specific hardware */
>
>      /* I2C7 CPUVR MUX */
> -    cpuvr_mux =3D i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, =
7),
> +    cpuvr_mux =3D i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c,=
 7),
>                                          "pca9546", 0x70);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 0),
> +    i2c_target_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 0),
>                              "pca9548", 0x72);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 1),
> +    i2c_target_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 1),
>                              "pca9548", 0x72);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 2),
> +    i2c_target_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 2),
>                              "pca9548", 0x72);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 3),
> +    i2c_target_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 3),
>                              "pca9548", 0x72);
>
>      /* I2C8 Thermal Diodes*/
> -    therm_mux =3D i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, =
8),
> +    therm_mux =3D i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c,=
 8),
>                                          "pca9548", 0x70);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 0),
> +    i2c_target_create_simple(pca954x_i2c_get_bus(therm_mux, 0),
>                              TYPE_LM75, 0x4C);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 1),
> +    i2c_target_create_simple(pca954x_i2c_get_bus(therm_mux, 1),
>                              TYPE_LM75, 0x4C);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 2),
> +    i2c_target_create_simple(pca954x_i2c_get_bus(therm_mux, 2),
>                              TYPE_LM75, 0x48);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 3),
> +    i2c_target_create_simple(pca954x_i2c_get_bus(therm_mux, 3),
>                              TYPE_LM75, 0x48);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 4),
> +    i2c_target_create_simple(pca954x_i2c_get_bus(therm_mux, 4),
>                              TYPE_LM75, 0x48);
>
>      /* I2C9 Fan Controller (MAX31785) */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
>                              "max31785", 0x52);
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9),
>                              "max31785", 0x54);
>  }
>
> @@ -1589,7 +1589,7 @@ static void ast1030_evb_i2c_init(AspeedMachineState
> *bmc)
>      smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
> eeprom_buf);
>
>      /* U11 LM75 connects to SDA/SCL Group 2 by default */
> -    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105",
> 0x4d);
> +    i2c_target_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105",
> 0x4d);
>  }
>
>  static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *o=
c,
> diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
> index 0a4b6f29b1..e53ba57d3f 100644
> --- a/hw/arm/bananapi_m2u.c
> +++ b/hw/arm/bananapi_m2u.c
> @@ -113,7 +113,7 @@ static void bpim2u_init(MachineState *machine)
>
>      /* Connect AXP221 */
>      i2c =3D I2C_BUS(qdev_get_child_bus(DEVICE(&r40->i2c0), "i2c"));
> -    i2c_slave_create_simple(i2c, "axp221_pmu", 0x34);
> +    i2c_target_create_simple(i2c, "axp221_pmu", 0x34);
>
>      /* SDRAM */
>      memory_region_add_subregion(get_system_memory(),
> diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
> index b976727eef..82a2e2642b 100644
> --- a/hw/arm/cubieboard.c
> +++ b/hw/arm/cubieboard.c
> @@ -80,7 +80,7 @@ static void cubieboard_init(MachineState *machine)
>
>      /* Connect AXP 209 */
>      i2c =3D I2C_BUS(qdev_get_child_bus(DEVICE(&a10->i2c0), "i2c"));
> -    i2c_slave_create_simple(i2c, "axp209_pmu", 0x34);
> +    i2c_target_create_simple(i2c, "axp209_pmu", 0x34);
>
>      /* Retrieve SD bus */
>      di =3D drive_get(IF_SD, 0, 0);
> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
> index 2020f73a57..54e2385d96 100644
> --- a/hw/arm/musicpal.c
> +++ b/hw/arm/musicpal.c
> @@ -1203,7 +1203,7 @@ static void musicpal_init(MachineState *machine)
>      DeviceState *i2c_dev;
>      DeviceState *lcd_dev;
>      DeviceState *key_dev;
> -    I2CSlave *wm8750_dev;
> +    I2CTarget *wm8750_dev;
>      SysBusDevice *s;
>      I2CBus *i2c;
>      int i;
> @@ -1316,11 +1316,11 @@ static void musicpal_init(MachineState *machine)
>          qdev_connect_gpio_out(key_dev, i, qdev_get_gpio_in(dev, i + 15))=
;
>      }
>
> -    wm8750_dev =3D i2c_slave_new(TYPE_WM8750, MP_WM_ADDR);
> +    wm8750_dev =3D i2c_target_new(TYPE_WM8750, MP_WM_ADDR);
>      if (machine->audiodev) {
>          qdev_prop_set_string(DEVICE(wm8750_dev), "audiodev",
> machine->audiodev);
>      }
> -    i2c_slave_realize_and_unref(wm8750_dev, i2c, &error_abort);
> +    i2c_target_realize_and_unref(wm8750_dev, i2c, &error_abort);
>
>      dev =3D qdev_new(TYPE_MV88W8618_AUDIO);
>      s =3D SYS_BUS_DEVICE(dev);
> diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
> index e229efb447..27fd8afa66 100644
> --- a/hw/arm/npcm7xx_boards.c
> +++ b/hw/arm/npcm7xx_boards.c
> @@ -197,13 +197,13 @@ static void npcm7xx_connect_pwm_fan(NPCM7xxState
> *soc, SplitIRQ *splitter,
>  static void npcm750_evb_i2c_init(NPCM7xxState *soc)
>  {
>      /* lm75 temperature sensor on SVB, tmp105 is compatible */
> -    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 0), "tmp105", 0x48)=
;
> +    i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 0), "tmp105", 0x48=
);
>      /* lm75 temperature sensor on EB, tmp105 is compatible */
> -    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 1), "tmp105", 0x48)=
;
> +    i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 1), "tmp105", 0x48=
);
>      /* tmp100 temperature sensor on EB, tmp105 is compatible */
> -    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 2), "tmp105", 0x48)=
;
> +    i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 2), "tmp105", 0x48=
);
>      /* tmp100 temperature sensor on SVB, tmp105 is compatible */
> -    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 6), "tmp105", 0x48)=
;
> +    i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 6), "tmp105", 0x48=
);
>  }
>
>  static void npcm750_evb_fan_init(NPCM7xxMachine *machine, NPCM7xxState
> *soc)
> @@ -233,10 +233,10 @@ static void npcm750_evb_fan_init(NPCM7xxMachine
> *machine, NPCM7xxState *soc)
>  static void quanta_gsj_i2c_init(NPCM7xxState *soc)
>  {
>      /* GSJ machine have 4 max31725 temperature sensors, tmp105 is
> compatible. */
> -    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 1), "tmp105", 0x5c)=
;
> -    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 2), "tmp105", 0x5c)=
;
> -    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 3), "tmp105", 0x5c)=
;
> -    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 4), "tmp105", 0x5c)=
;
> +    i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 1), "tmp105", 0x5c=
);
> +    i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 2), "tmp105", 0x5c=
);
> +    i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 3), "tmp105", 0x5c=
);
> +    i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 4), "tmp105", 0x5c=
);
>
>      at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 9), 0x55, 8192);
>      at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 10), 0x55, 8192);
> @@ -252,7 +252,7 @@ static void quanta_gsj_i2c_init(NPCM7xxState *soc)
>       * - ucd90160@6b
>       */
>
> -    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 15), "pca9548",
> 0x75);
> +    i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 15), "pca9548",
> 0x75);
>  }
>
>  static void quanta_gsj_fan_init(NPCM7xxMachine *machine, NPCM7xxState
> *soc)
> @@ -330,31 +330,31 @@ static void quanta_gbs_i2c_init(NPCM7xxState *soc)
>
>  static void kudo_bmc_i2c_init(NPCM7xxState *soc)
>  {
> -    I2CSlave *i2c_mux;
> +    I2CTarget *i2c_mux;
>
> -    i2c_mux =3D i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 1),
> +    i2c_mux =3D i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 1),
>                                        TYPE_PCA9548, 0x75);
>
>      /* tmp105 is compatible with the lm75 */
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 4), "tmp105",
> 0x5c);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5), "tmp105",
> 0x5c);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6), "tmp105",
> 0x5c);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 7), "tmp105",
> 0x5c);
> +    i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 4), "tmp105",
> 0x5c);
> +    i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 5), "tmp105",
> 0x5c);
> +    i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 6), "tmp105",
> 0x5c);
> +    i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 7), "tmp105",
> 0x5c);
>
> -    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 1), TYPE_PCA9548,
> 0x77);
> +    i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 1), TYPE_PCA9548,
> 0x77);
>
> -    i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 4), TYPE_PCA9548,
> 0x77);
> +    i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 4), TYPE_PCA9548,
> 0x77);
>
>      at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 4), 0x50, 8192); /* mbfru
> */
>
> -    i2c_mux =3D i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 13),
> +    i2c_mux =3D i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 13),
>                                        TYPE_PCA9548, 0x77);
>
>      /* tmp105 is compatible with the lm75 */
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 2), "tmp105",
> 0x48);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 3), "tmp105",
> 0x49);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 4), "tmp105",
> 0x48);
> -    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5), "tmp105",
> 0x49);
> +    i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 2), "tmp105",
> 0x48);
> +    i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 3), "tmp105",
> 0x49);
> +    i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 4), "tmp105",
> 0x48);
> +    i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 5), "tmp105",
> 0x49);
>
>      at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 14), 0x55, 8192); /*
> bmcfru */
>
> diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
> index 35364312c7..0f10bb5ade 100644
> --- a/hw/arm/nseries.c
> +++ b/hw/arm/nseries.c
> @@ -218,7 +218,7 @@ static void n8x0_i2c_setup(struct n800_s *s)
>      I2CBus *i2c =3D omap_i2c_bus(s->mpu->i2c[0]);
>
>      /* Attach a menelaus PM chip */
> -    dev =3D DEVICE(i2c_slave_create_simple(i2c, "twl92230",
> N8X0_MENELAUS_ADDR));
> +    dev =3D DEVICE(i2c_target_create_simple(i2c, "twl92230",
> N8X0_MENELAUS_ADDR));
>      qdev_connect_gpio_out(dev, 3,
>                            qdev_get_gpio_in(s->mpu->ih[0],
>                                             OMAP_INT_24XX_SYS_NIRQ));
> @@ -227,7 +227,7 @@ static void n8x0_i2c_setup(struct n800_s *s)
>      qemu_register_powerdown_notifier(&n8x0_system_powerdown_notifier);
>
>      /* Attach a TMP105 PM chip (A0 wired to ground) */
> -    dev =3D DEVICE(i2c_slave_create_simple(i2c, TYPE_TMP105,
> N8X0_TMP105_ADDR));
> +    dev =3D DEVICE(i2c_target_create_simple(i2c, TYPE_TMP105,
> N8X0_TMP105_ADDR));
>      qdev_connect_gpio_out(dev, 0, tmp_irq);
>  }
>
> @@ -419,7 +419,7 @@ static void n810_kbd_setup(struct n800_s *s)
>
>      /* Attach the LM8322 keyboard to the I2C bus,
>       * should happen in n8x0_i2c_setup and s->kbd be initialised here.  =
*/
> -    s->kbd =3D DEVICE(i2c_slave_create_simple(omap_i2c_bus(s->mpu->i2c[0=
]),
> +    s->kbd =3D DEVICE(i2c_target_create_simple(omap_i2c_bus(s->mpu->i2c[=
0]),
>                                              TYPE_LM8323,
> N810_LM8323_ADDR));
>      qdev_connect_gpio_out(s->kbd, 0, kbd_irq);
>  }
> diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
> index 6b2e54473b..3b658680ac 100644
> --- a/hw/arm/pxa2xx.c
> +++ b/hw/arm/pxa2xx.c
> @@ -1243,10 +1243,10 @@ static const TypeInfo pxa2xx_rtc_sysbus_info =3D =
{
>  /* I2C Interface */
>
>  #define TYPE_PXA2XX_I2C_SLAVE "pxa2xx-i2c-slave"
> -OBJECT_DECLARE_SIMPLE_TYPE(PXA2xxI2CSlaveState, PXA2XX_I2C_SLAVE)
> +OBJECT_DECLARE_SIMPLE_TYPE(PXA2xxI2CTargetState, PXA2XX_I2C_SLAVE)
>
> -struct PXA2xxI2CSlaveState {
> -    I2CSlave parent_obj;
> +struct PXA2xxI2CTargetState {
> +    I2CTarget parent_obj;
>
>      PXA2xxI2CState *host;
>  };
> @@ -1257,7 +1257,7 @@ struct PXA2xxI2CState {
>      /*< public >*/
>
>      MemoryRegion iomem;
> -    PXA2xxI2CSlaveState *slave;
> +    PXA2xxI2CTargetState *slave;
>      I2CBus *bus;
>      qemu_irq irq;
>      uint32_t offset;
> @@ -1286,9 +1286,9 @@ static void pxa2xx_i2c_update(PXA2xxI2CState *s)
>  }
>
>  /* These are only stubs now.  */
> -static int pxa2xx_i2c_event(I2CSlave *i2c, enum i2c_event event)
> +static int pxa2xx_i2c_event(I2CTarget *i2c, enum i2c_event event)
>  {
> -    PXA2xxI2CSlaveState *slave =3D PXA2XX_I2C_SLAVE(i2c);
> +    PXA2xxI2CTargetState *slave =3D PXA2XX_I2C_SLAVE(i2c);
>      PXA2xxI2CState *s =3D slave->host;
>
>      switch (event) {
> @@ -1314,9 +1314,9 @@ static int pxa2xx_i2c_event(I2CSlave *i2c, enum
> i2c_event event)
>      return 0;
>  }
>
> -static uint8_t pxa2xx_i2c_rx(I2CSlave *i2c)
> +static uint8_t pxa2xx_i2c_rx(I2CTarget *i2c)
>  {
> -    PXA2xxI2CSlaveState *slave =3D PXA2XX_I2C_SLAVE(i2c);
> +    PXA2xxI2CTargetState *slave =3D PXA2XX_I2C_SLAVE(i2c);
>      PXA2xxI2CState *s =3D slave->host;
>
>      if ((s->control & (1 << 14)) || !(s->control & (1 << 6))) {
> @@ -1331,9 +1331,9 @@ static uint8_t pxa2xx_i2c_rx(I2CSlave *i2c)
>      return s->data;
>  }
>
> -static int pxa2xx_i2c_tx(I2CSlave *i2c, uint8_t data)
> +static int pxa2xx_i2c_tx(I2CTarget *i2c, uint8_t data)
>  {
> -    PXA2xxI2CSlaveState *slave =3D PXA2XX_I2C_SLAVE(i2c);
> +    PXA2xxI2CTargetState *slave =3D PXA2XX_I2C_SLAVE(i2c);
>      PXA2xxI2CState *s =3D slave->host;
>
>      if ((s->control & (1 << 14)) || !(s->control & (1 << 6))) {
> @@ -1353,7 +1353,7 @@ static uint64_t pxa2xx_i2c_read(void *opaque, hwadd=
r
> addr,
>                                  unsigned size)
>  {
>      PXA2xxI2CState *s =3D (PXA2xxI2CState *) opaque;
> -    I2CSlave *slave;
> +    I2CTarget *slave;
>
>      addr -=3D s->offset;
>      switch (addr) {
> @@ -1440,7 +1440,7 @@ static void pxa2xx_i2c_write(void *opaque, hwaddr
> addr,
>          break;
>
>      case ISAR:
> -        i2c_slave_set_address(I2C_SLAVE(s->slave), value & 0x7f);
> +        i2c_target_set_address(I2C_SLAVE(s->slave), value & 0x7f);
>          break;
>
>      case IDBR:
> @@ -1465,7 +1465,7 @@ static const VMStateDescription
> vmstate_pxa2xx_i2c_slave =3D {
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
>      .fields =3D (const VMStateField[]) {
> -        VMSTATE_I2C_SLAVE(parent_obj, PXA2xxI2CSlaveState),
> +        VMSTATE_I2C_TARGET(parent_obj, PXA2xxI2CTargetState),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -1480,14 +1480,14 @@ static const VMStateDescription vmstate_pxa2xx_i2=
c
> =3D {
>          VMSTATE_UINT8(ibmr, PXA2xxI2CState),
>          VMSTATE_UINT8(data, PXA2xxI2CState),
>          VMSTATE_STRUCT_POINTER(slave, PXA2xxI2CState,
> -                               vmstate_pxa2xx_i2c_slave,
> PXA2xxI2CSlaveState),
> +                               vmstate_pxa2xx_i2c_slave,
> PXA2xxI2CTargetState),
>          VMSTATE_END_OF_LIST()
>      }
>  };
>
>  static void pxa2xx_i2c_slave_class_init(ObjectClass *klass, void *data)
>  {
> -    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k =3D I2C_TARGET_CLASS(klass);
>
>      k->event =3D pxa2xx_i2c_event;
>      k->recv =3D pxa2xx_i2c_rx;
> @@ -1496,8 +1496,8 @@ static void pxa2xx_i2c_slave_class_init(ObjectClass
> *klass, void *data)
>
>  static const TypeInfo pxa2xx_i2c_slave_info =3D {
>      .name          =3D TYPE_PXA2XX_I2C_SLAVE,
> -    .parent        =3D TYPE_I2C_SLAVE,
> -    .instance_size =3D sizeof(PXA2xxI2CSlaveState),
> +    .parent        =3D TYPE_I2C_TARGET,
> +    .instance_size =3D sizeof(PXA2xxI2CTargetState),
>      .class_init    =3D pxa2xx_i2c_slave_class_init,
>  };
>
> @@ -1522,7 +1522,7 @@ PXA2xxI2CState *pxa2xx_i2c_init(hwaddr base,
>      sysbus_connect_irq(i2c_dev, 0, irq);
>
>      s =3D PXA2XX_I2C(i2c_dev);
> -    s->slave =3D PXA2XX_I2C_SLAVE(i2c_slave_create_simple(i2cbus,
> +    s->slave =3D PXA2XX_I2C_SLAVE(i2c_target_create_simple(i2cbus,
>
>  TYPE_PXA2XX_I2C_SLAVE,
>                                                          0));
>      s->slave->host =3D s;
> diff --git a/hw/arm/realview.c b/hw/arm/realview.c
> index b186f965c6..dc18ce8d23 100644
> --- a/hw/arm/realview.c
> +++ b/hw/arm/realview.c
> @@ -314,7 +314,7 @@ static void realview_init(MachineState *machine,
>
>      dev =3D sysbus_create_simple(TYPE_ARM_SBCON_I2C, 0x10002000, NULL);
>      i2c =3D (I2CBus *)qdev_get_child_bus(dev, "i2c");
> -    i2c_slave_create_simple(i2c, "ds1338", 0x68);
> +    i2c_target_create_simple(i2c, "ds1338", 0x68);
>
>      /* Memory map for RealView Emulation Baseboard:  */
>      /* 0x10000000 System registers.  */
> diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
> index 62cd55ba91..1fe466bab9 100644
> --- a/hw/arm/spitz.c
> +++ b/hw/arm/spitz.c
> @@ -767,11 +767,11 @@ static void spitz_microdrive_attach(PXA2xxState
> *cpu, int slot)
>
>  static void spitz_wm8750_addr(void *opaque, int line, int level)
>  {
> -    I2CSlave *wm =3D (I2CSlave *) opaque;
> +    I2CTarget *wm =3D (I2CTarget *) opaque;
>      if (level)
> -        i2c_slave_set_address(wm, SPITZ_WM_ADDRH);
> +        i2c_target_set_address(wm, SPITZ_WM_ADDRH);
>      else
> -        i2c_slave_set_address(wm, SPITZ_WM_ADDRL);
> +        i2c_target_set_address(wm, SPITZ_WM_ADDRL);
>  }
>
>  static void spitz_i2c_setup(MachineState *machine, PXA2xxState *cpu)
> @@ -780,13 +780,13 @@ static void spitz_i2c_setup(MachineState *machine,
> PXA2xxState *cpu)
>      I2CBus *bus =3D pxa2xx_i2c_bus(cpu->i2c[0]);
>
>      /* Attach a WM8750 to the bus */
> -    I2CSlave *i2c_dev =3D i2c_slave_new(TYPE_WM8750, 0);
> +    I2CTarget *i2c_dev =3D i2c_target_new(TYPE_WM8750, 0);
>      DeviceState *wm =3D DEVICE(i2c_dev);
>
>      if (machine->audiodev) {
>          qdev_prop_set_string(wm, "audiodev", machine->audiodev);
>      }
> -    i2c_slave_realize_and_unref(i2c_dev, bus, &error_abort);
> +    i2c_target_realize_and_unref(i2c_dev, bus, &error_abort);
>
>      spitz_wm8750_addr(wm, 0, 0);
>      qdev_connect_gpio_out(cpu->gpio, SPITZ_GPIO_WM,
> @@ -801,7 +801,7 @@ static void spitz_i2c_setup(MachineState *machine,
> PXA2xxState *cpu)
>  static void spitz_akita_i2c_setup(PXA2xxState *cpu)
>  {
>      /* Attach a Max7310 to Akita I2C bus.  */
> -    i2c_slave_create_simple(pxa2xx_i2c_bus(cpu->i2c[0]), "max7310",
> +    i2c_target_create_simple(pxa2xx_i2c_bus(cpu->i2c[0]), "max7310",
>                       AKITA_MAX_ADDR);
>  }
>
> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> index a2f998bf9e..7246bcc560 100644
> --- a/hw/arm/stellaris.c
> +++ b/hw/arm/stellaris.c
> @@ -1176,7 +1176,7 @@ static void stellaris_init(MachineState *ms,
> stellaris_board_info *board)
>                                     qdev_get_gpio_in(nvic, 8));
>          i2c =3D (I2CBus *)qdev_get_child_bus(dev, "i2c");
>          if (board->peripherals & BP_OLED_I2C) {
> -            i2c_slave_create_simple(i2c, "ssd0303", 0x3d);
> +            i2c_target_create_simple(i2c, "ssd0303", 0x3d);
>          }
>      }
>
> diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
> index 5891f6064f..8529a57ef7 100644
> --- a/hw/arm/tosa.c
> +++ b/hw/arm/tosa.c
> @@ -163,13 +163,13 @@ static void tosa_ssp_realize(SSIPeripheral *dev,
> Error **errp)
>  OBJECT_DECLARE_SIMPLE_TYPE(TosaDACState, TOSA_DAC)
>
>  struct TosaDACState {
> -    I2CSlave parent_obj;
> +    I2CTarget parent_obj;
>
>      int len;
>      char buf[3];
>  };
>
> -static int tosa_dac_send(I2CSlave *i2c, uint8_t data)
> +static int tosa_dac_send(I2CTarget *i2c, uint8_t data)
>  {
>      TosaDACState *s =3D TOSA_DAC(i2c);
>
> @@ -189,7 +189,7 @@ static int tosa_dac_send(I2CSlave *i2c, uint8_t data)
>      return 0;
>  }
>
> -static int tosa_dac_event(I2CSlave *i2c, enum i2c_event event)
> +static int tosa_dac_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      TosaDACState *s =3D TOSA_DAC(i2c);
>
> @@ -215,7 +215,7 @@ static int tosa_dac_event(I2CSlave *i2c, enum
> i2c_event event)
>      return 0;
>  }
>
> -static uint8_t tosa_dac_recv(I2CSlave *s)
> +static uint8_t tosa_dac_recv(I2CTarget *s)
>  {
>      printf("%s: recv not supported!!!\n", __func__);
>      return 0xff;
> @@ -224,7 +224,7 @@ static uint8_t tosa_dac_recv(I2CSlave *s)
>  static void tosa_tg_init(PXA2xxState *cpu)
>  {
>      I2CBus *bus =3D pxa2xx_i2c_bus(cpu->i2c[0]);
> -    i2c_slave_create_simple(bus, TYPE_TOSA_DAC, DAC_BASE);
> +    i2c_target_create_simple(bus, TYPE_TOSA_DAC, DAC_BASE);
>      ssi_create_peripheral(cpu->ssp[1], "tosa-ssp");
>  }
>
> @@ -277,7 +277,7 @@ DEFINE_MACHINE("tosa", tosapda_machine_init)
>
>  static void tosa_dac_class_init(ObjectClass *klass, void *data)
>  {
> -    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k =3D I2C_TARGET_CLASS(klass);
>
>      k->event =3D tosa_dac_event;
>      k->recv =3D tosa_dac_recv;
> @@ -286,7 +286,7 @@ static void tosa_dac_class_init(ObjectClass *klass,
> void *data)
>
>  static const TypeInfo tosa_dac_info =3D {
>      .name          =3D TYPE_TOSA_DAC,
> -    .parent        =3D TYPE_I2C_SLAVE,
> +    .parent        =3D TYPE_I2C_TARGET,
>      .instance_size =3D sizeof(TosaDACState),
>      .class_init    =3D tosa_dac_class_init,
>  };
> diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
> index d48235453e..73d8047ca8 100644
> --- a/hw/arm/versatilepb.c
> +++ b/hw/arm/versatilepb.c
> @@ -338,7 +338,7 @@ static void versatile_init(MachineState *machine, int
> board_id)
>
>      dev =3D sysbus_create_simple(TYPE_ARM_SBCON_I2C, 0x10002000, NULL);
>      i2c =3D (I2CBus *)qdev_get_child_bus(dev, "i2c");
> -    i2c_slave_create_simple(i2c, "ds1338", 0x68);
> +    i2c_target_create_simple(i2c, "ds1338", 0x68);
>
>      /* Add PL041 AACI Interface to the LM4549 codec */
>      pl041 =3D qdev_new("pl041");
> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
> index de815d84cc..355905e0b7 100644
> --- a/hw/arm/vexpress.c
> +++ b/hw/arm/vexpress.c
> @@ -650,7 +650,7 @@ static void vexpress_common_init(MachineState *machin=
e)
>
>      dev =3D sysbus_create_simple(TYPE_ARM_SBCON_I2C, map[VE_SERIALDVI],
> NULL);
>      i2c =3D (I2CBus *)qdev_get_child_bus(dev, "i2c");
> -    i2c_slave_create_simple(i2c, "sii9022", 0x39);
> +    i2c_target_create_simple(i2c, "sii9022", 0x39);
>
>      sysbus_create_simple("pl031", map[VE_RTC], pic[4]); /* RTC */
>
> diff --git a/hw/arm/z2.c b/hw/arm/z2.c
> index fc5672e7ab..24bc303f06 100644
> --- a/hw/arm/z2.c
> +++ b/hw/arm/z2.c
> @@ -192,13 +192,13 @@ static const TypeInfo zipit_lcd_info =3D {
>  OBJECT_DECLARE_SIMPLE_TYPE(AER915State, AER915)
>
>  struct AER915State {
> -    I2CSlave parent_obj;
> +    I2CTarget parent_obj;
>
>      int len;
>      uint8_t buf[3];
>  };
>
> -static int aer915_send(I2CSlave *i2c, uint8_t data)
> +static int aer915_send(I2CTarget *i2c, uint8_t data)
>  {
>      AER915State *s =3D AER915(i2c);
>
> @@ -215,7 +215,7 @@ static int aer915_send(I2CSlave *i2c, uint8_t data)
>      return 0;
>  }
>
> -static int aer915_event(I2CSlave *i2c, enum i2c_event event)
> +static int aer915_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      AER915State *s =3D AER915(i2c);
>
> @@ -235,7 +235,7 @@ static int aer915_event(I2CSlave *i2c, enum i2c_event
> event)
>      return 0;
>  }
>
> -static uint8_t aer915_recv(I2CSlave *slave)
> +static uint8_t aer915_recv(I2CTarget *slave)
>  {
>      AER915State *s =3D AER915(slave);
>      int retval =3D 0x00;
> @@ -272,7 +272,7 @@ static const VMStateDescription vmstate_aer915_state =
=3D
> {
>  static void aer915_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k =3D I2C_TARGET_CLASS(klass);
>
>      k->event =3D aer915_event;
>      k->recv =3D aer915_recv;
> @@ -282,7 +282,7 @@ static void aer915_class_init(ObjectClass *klass, voi=
d
> *data)
>
>  static const TypeInfo aer915_info =3D {
>      .name          =3D TYPE_AER915,
> -    .parent        =3D TYPE_I2C_SLAVE,
> +    .parent        =3D TYPE_I2C_TARGET,
>      .instance_size =3D sizeof(AER915State),
>      .class_init    =3D aer915_class_init,
>  };
> @@ -296,7 +296,7 @@ static void z2_init(MachineState *machine)
>      void *z2_lcd;
>      I2CBus *bus;
>      DeviceState *wm;
> -    I2CSlave *i2c_dev;
> +    I2CTarget *i2c_dev;
>
>      /* Setup CPU & memory */
>      mpu =3D pxa270_init(z2_binfo.ram_size, machine->cpu_type);
> @@ -319,15 +319,15 @@ static void z2_init(MachineState *machine)
>      z2_lcd =3D ssi_create_peripheral(mpu->ssp[1], TYPE_ZIPIT_LCD);
>      bus =3D pxa2xx_i2c_bus(mpu->i2c[0]);
>
> -    i2c_slave_create_simple(bus, TYPE_AER915, 0x55);
> +    i2c_target_create_simple(bus, TYPE_AER915, 0x55);
>
> -    i2c_dev =3D i2c_slave_new(TYPE_WM8750, 0x1b);
> +    i2c_dev =3D i2c_target_new(TYPE_WM8750, 0x1b);
>      wm =3D DEVICE(i2c_dev);
>
>      if (machine->audiodev) {
>          qdev_prop_set_string(wm, "audiodev", machine->audiodev);
>      }
> -    i2c_slave_realize_and_unref(i2c_dev, bus, &error_abort);
> +    i2c_target_realize_and_unref(i2c_dev, bus, &error_abort);
>
>      mpu->i2s->opaque =3D wm;
>      mpu->i2s->codec_out =3D wm8750_dac_dat;
> diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
> index ec2c4e1374..6e2da41419 100644
> --- a/hw/audio/wm8750.c
> +++ b/hw/audio/wm8750.c
> @@ -30,7 +30,7 @@ typedef struct {
>  OBJECT_DECLARE_SIMPLE_TYPE(WM8750State, WM8750)
>
>  struct WM8750State {
> -    I2CSlave parent_obj;
> +    I2CTarget parent_obj;
>
>      uint8_t i2c_data[2];
>      int i2c_len;
> @@ -261,7 +261,7 @@ static void wm8750_clk_update(WM8750State *s, int ext=
)
>      }
>  }
>
> -static void wm8750_reset(I2CSlave *i2c)
> +static void wm8750_reset(I2CTarget *i2c)
>  {
>      WM8750State *s =3D WM8750(i2c);
>
> @@ -305,7 +305,7 @@ static void wm8750_reset(I2CSlave *i2c)
>      s->i2c_len =3D 0;
>  }
>
> -static int wm8750_event(I2CSlave *i2c, enum i2c_event event)
> +static int wm8750_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      WM8750State *s =3D WM8750(i2c);
>
> @@ -364,7 +364,7 @@ static int wm8750_event(I2CSlave *i2c, enum i2c_event
> event)
>  #define WM8750_ROUT2V  0x29
>  #define WM8750_MOUTV   0x2a
>
> -static int wm8750_tx(I2CSlave *i2c, uint8_t data)
> +static int wm8750_tx(I2CTarget *i2c, uint8_t data)
>  {
>      WM8750State *s =3D WM8750(i2c);
>      uint8_t cmd;
> @@ -564,7 +564,7 @@ static int wm8750_tx(I2CSlave *i2c, uint8_t data)
>      return 0;
>  }
>
> -static uint8_t wm8750_rx(I2CSlave *i2c)
> +static uint8_t wm8750_rx(I2CTarget *i2c)
>  {
>      return 0x00;
>  }
> @@ -615,7 +615,7 @@ static const VMStateDescription vmstate_wm8750 =3D {
>          VMSTATE_UINT8(format, WM8750State),
>          VMSTATE_UINT8(power, WM8750State),
>          VMSTATE_UINT8(rate_vmstate, WM8750State),
> -        VMSTATE_I2C_SLAVE(parent_obj, WM8750State),
> +        VMSTATE_I2C_TARGET(parent_obj, WM8750State),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -632,7 +632,7 @@ static void wm8750_realize(DeviceState *dev, Error
> **errp)
>  }
>
>  #if 0
> -static void wm8750_fini(I2CSlave *i2c)
> +static void wm8750_fini(I2CTarget *i2c)
>  {
>      WM8750State *s =3D WM8750(i2c);
>
> @@ -714,7 +714,7 @@ static Property wm8750_properties[] =3D {
>  static void wm8750_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    I2CSlaveClass *sc =3D I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *sc =3D I2C_TARGET_CLASS(klass);
>
>      dc->realize =3D wm8750_realize;
>      sc->event =3D wm8750_event;
> @@ -726,7 +726,7 @@ static void wm8750_class_init(ObjectClass *klass, voi=
d
> *data)
>
>  static const TypeInfo wm8750_info =3D {
>      .name          =3D TYPE_WM8750,
> -    .parent        =3D TYPE_I2C_SLAVE,
> +    .parent        =3D TYPE_I2C_TARGET,
>      .instance_size =3D sizeof(WM8750State),
>      .class_init    =3D wm8750_class_init,
>  };
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 8d2501bd82..3341ef7800 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -1000,8 +1000,8 @@ static void ati_vga_realize(PCIDevice *dev, Error
> **errp)
>      /* ddc, edid */
>      I2CBus *i2cbus =3D i2c_init_bus(DEVICE(s), "ati-vga.ddc");
>      bitbang_i2c_init(&s->bbi2c, i2cbus);
> -    I2CSlave *i2cddc =3D I2C_SLAVE(qdev_new(TYPE_I2CDDC));
> -    i2c_slave_set_address(i2cddc, 0x50);
> +    I2CTarget *i2cddc =3D I2C_SLAVE(qdev_new(TYPE_I2CDDC));
> +    i2c_target_set_address(i2cddc, 0x50);
>      qdev_realize_and_unref(DEVICE(i2cddc), BUS(i2cbus), &error_abort);
>
>      /* mmio register space */
> diff --git a/hw/display/i2c-ddc.c b/hw/display/i2c-ddc.c
> index 3f9d1e1f6f..66107b5b31 100644
> --- a/hw/display/i2c-ddc.c
> +++ b/hw/display/i2c-ddc.c
> @@ -42,7 +42,7 @@ static void i2c_ddc_reset(DeviceState *ds)
>      s->reg =3D 0;
>  }
>
> -static int i2c_ddc_event(I2CSlave *i2c, enum i2c_event event)
> +static int i2c_ddc_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      I2CDDCState *s =3D I2CDDC(i2c);
>
> @@ -53,7 +53,7 @@ static int i2c_ddc_event(I2CSlave *i2c, enum i2c_event
> event)
>      return 0;
>  }
>
> -static uint8_t i2c_ddc_rx(I2CSlave *i2c)
> +static uint8_t i2c_ddc_rx(I2CTarget *i2c)
>  {
>      I2CDDCState *s =3D I2CDDC(i2c);
>
> @@ -63,7 +63,7 @@ static uint8_t i2c_ddc_rx(I2CSlave *i2c)
>      return value;
>  }
>
> -static int i2c_ddc_tx(I2CSlave *i2c, uint8_t data)
> +static int i2c_ddc_tx(I2CTarget *i2c, uint8_t data)
>  {
>      I2CDDCState *s =3D I2CDDC(i2c);
>      if (s->firstbyte) {
> @@ -103,7 +103,7 @@ static Property i2c_ddc_properties[] =3D {
>  static void i2c_ddc_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(oc);
> -    I2CSlaveClass *isc =3D I2C_SLAVE_CLASS(oc);
> +    I2CTargetClass *isc =3D I2C_TARGET_CLASS(oc);
>
>      dc->reset =3D i2c_ddc_reset;
>      dc->vmsd =3D &vmstate_i2c_ddc;
> @@ -115,7 +115,7 @@ static void i2c_ddc_class_init(ObjectClass *oc, void
> *data)
>
>  static const TypeInfo i2c_ddc_info =3D {
>      .name =3D TYPE_I2CDDC,
> -    .parent =3D TYPE_I2C_SLAVE,
> +    .parent =3D TYPE_I2C_TARGET,
>      .instance_size =3D sizeof(I2CDDCState),
>      .instance_init =3D i2c_ddc_init,
>      .class_init =3D i2c_ddc_class_init
> diff --git a/hw/display/sii9022.c b/hw/display/sii9022.c
> index 60c3f78549..095fd862dd 100644
> --- a/hw/display/sii9022.c
> +++ b/hw/display/sii9022.c
> @@ -39,7 +39,7 @@
>  OBJECT_DECLARE_SIMPLE_TYPE(sii9022_state, SII9022)
>
>  struct sii9022_state {
> -    I2CSlave parent_obj;
> +    I2CTarget parent_obj;
>      uint8_t ptr;
>      bool addr_byte;
>      bool ddc_req;
> @@ -52,7 +52,7 @@ static const VMStateDescription vmstate_sii9022 =3D {
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
>      .fields =3D (const VMStateField[]) {
> -        VMSTATE_I2C_SLAVE(parent_obj, sii9022_state),
> +        VMSTATE_I2C_TARGET(parent_obj, sii9022_state),
>          VMSTATE_UINT8(ptr, sii9022_state),
>          VMSTATE_BOOL(addr_byte, sii9022_state),
>          VMSTATE_BOOL(ddc_req, sii9022_state),
> @@ -62,7 +62,7 @@ static const VMStateDescription vmstate_sii9022 =3D {
>      }
>  };
>
> -static int sii9022_event(I2CSlave *i2c, enum i2c_event event)
> +static int sii9022_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      sii9022_state *s =3D SII9022(i2c);
>
> @@ -83,7 +83,7 @@ static int sii9022_event(I2CSlave *i2c, enum i2c_event
> event)
>      return 0;
>  }
>
> -static uint8_t sii9022_rx(I2CSlave *i2c)
> +static uint8_t sii9022_rx(I2CTarget *i2c)
>  {
>      sii9022_state *s =3D SII9022(i2c);
>      uint8_t res =3D 0x00;
> @@ -112,7 +112,7 @@ static uint8_t sii9022_rx(I2CSlave *i2c)
>      return res;
>  }
>
> -static int sii9022_tx(I2CSlave *i2c, uint8_t data)
> +static int sii9022_tx(I2CTarget *i2c, uint8_t data)
>  {
>      sii9022_state *s =3D SII9022(i2c);
>
> @@ -164,13 +164,13 @@ static void sii9022_realize(DeviceState *dev, Error
> **errp)
>      I2CBus *bus;
>
>      bus =3D I2C_BUS(qdev_get_parent_bus(dev));
> -    i2c_slave_create_simple(bus, TYPE_I2CDDC, 0x50);
> +    i2c_target_create_simple(bus, TYPE_I2CDDC, 0x50);
>  }
>
>  static void sii9022_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k =3D I2C_TARGET_CLASS(klass);
>
>      k->event =3D sii9022_event;
>      k->recv =3D sii9022_rx;
> @@ -182,7 +182,7 @@ static void sii9022_class_init(ObjectClass *klass,
> void *data)
>
>  static const TypeInfo sii9022_info =3D {
>      .name          =3D TYPE_SII9022,
> -    .parent        =3D TYPE_I2C_SLAVE,
> +    .parent        =3D TYPE_I2C_TARGET,
>      .instance_size =3D sizeof(sii9022_state),
>      .class_init    =3D sii9022_class_init,
>  };
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 26dc8170d8..a549c9149f 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -1908,7 +1908,7 @@ static void sm501_init(SM501State *s, DeviceState
> *dev,
>      s->i2c_bus =3D i2c_init_bus(dev, "sm501.i2c");
>      /* ddc */
>      I2CDDCState *ddc =3D I2CDDC(qdev_new(TYPE_I2CDDC));
> -    i2c_slave_set_address(I2C_SLAVE(ddc), 0x50);
> +    i2c_target_set_address(I2C_SLAVE(ddc), 0x50);
>      qdev_realize_and_unref(DEVICE(ddc), BUS(s->i2c_bus), &error_abort);
>
>      /* mmio */
> diff --git a/hw/display/ssd0303.c b/hw/display/ssd0303.c
> index e292cff44e..45d789d23e 100644
> --- a/hw/display/ssd0303.c
> +++ b/hw/display/ssd0303.c
> @@ -50,7 +50,7 @@ enum ssd0303_cmd {
>  OBJECT_DECLARE_SIMPLE_TYPE(ssd0303_state, SSD0303)
>
>  struct ssd0303_state {
> -    I2CSlave parent_obj;
> +    I2CTarget parent_obj;
>
>      QemuConsole *con;
>      int row;
> @@ -66,13 +66,13 @@ struct ssd0303_state {
>      uint8_t framebuffer[132*8];
>  };
>
> -static uint8_t ssd0303_recv(I2CSlave *i2c)
> +static uint8_t ssd0303_recv(I2CTarget *i2c)
>  {
>      BADF("Reads not implemented\n");
>      return 0xff;
>  }
>
> -static int ssd0303_send(I2CSlave *i2c, uint8_t data)
> +static int ssd0303_send(I2CTarget *i2c, uint8_t data)
>  {
>      ssd0303_state *s =3D SSD0303(i2c);
>      enum ssd0303_cmd old_cmd_state;
> @@ -183,7 +183,7 @@ static int ssd0303_send(I2CSlave *i2c, uint8_t data)
>      return 0;
>  }
>
> -static int ssd0303_event(I2CSlave *i2c, enum i2c_event event)
> +static int ssd0303_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      ssd0303_state *s =3D SSD0303(i2c);
>
> @@ -293,7 +293,7 @@ static const VMStateDescription vmstate_ssd0303 =3D {
>          VMSTATE_UINT32(mode, ssd0303_state),
>          VMSTATE_UINT32(cmd_state, ssd0303_state),
>          VMSTATE_BUFFER(framebuffer, ssd0303_state),
> -        VMSTATE_I2C_SLAVE(parent_obj, ssd0303_state),
> +        VMSTATE_I2C_TARGET(parent_obj, ssd0303_state),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -314,7 +314,7 @@ static void ssd0303_realize(DeviceState *dev, Error
> **errp)
>  static void ssd0303_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k =3D I2C_TARGET_CLASS(klass);
>
>      dc->realize =3D ssd0303_realize;
>      k->event =3D ssd0303_event;
> @@ -325,7 +325,7 @@ static void ssd0303_class_init(ObjectClass *klass,
> void *data)
>
>  static const TypeInfo ssd0303_info =3D {
>      .name          =3D TYPE_SSD0303,
> -    .parent        =3D TYPE_I2C_SLAVE,
> +    .parent        =3D TYPE_I2C_TARGET,
>      .instance_size =3D sizeof(ssd0303_state),
>      .class_init    =3D ssd0303_class_init,
>  };
> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> index c42fc388dc..fd1cc371d3 100644
> --- a/hw/display/xlnx_dp.c
> +++ b/hw/display/xlnx_dp.c
> @@ -1273,7 +1273,7 @@ static void xlnx_dp_init(Object *obj)
>      object_property_add_child(OBJECT(s), "dpcd", OBJECT(s->dpcd));
>
>      s->edid =3D I2CDDC(qdev_new("i2c-ddc"));
> -    i2c_slave_set_address(I2C_SLAVE(s->edid), 0x50);
> +    i2c_target_set_address(I2C_SLAVE(s->edid), 0x50);
>      object_property_add_child(OBJECT(s), "edid", OBJECT(s->edid));
>
>      fifo8_create(&s->rx_fifo, 16);
> diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c
> index 86315714fb..e911647812 100644
> --- a/hw/gpio/max7310.c
> +++ b/hw/gpio/max7310.c
> @@ -19,7 +19,7 @@
>  OBJECT_DECLARE_SIMPLE_TYPE(MAX7310State, MAX7310)
>
>  struct MAX7310State {
> -    I2CSlave parent_obj;
> +    I2CTarget parent_obj;
>
>      int i2c_command_byte;
>      int len;
> @@ -44,7 +44,7 @@ static void max7310_reset(DeviceState *dev)
>      s->command =3D 0x00;
>  }
>
> -static uint8_t max7310_rx(I2CSlave *i2c)
> +static uint8_t max7310_rx(I2CTarget *i2c)
>  {
>      MAX7310State *s =3D MAX7310(i2c);
>
> @@ -75,7 +75,7 @@ static uint8_t max7310_rx(I2CSlave *i2c)
>      return 0xff;
>  }
>
> -static int max7310_tx(I2CSlave *i2c, uint8_t data)
> +static int max7310_tx(I2CTarget *i2c, uint8_t data)
>  {
>      MAX7310State *s =3D MAX7310(i2c);
>      uint8_t diff;
> @@ -129,7 +129,7 @@ static int max7310_tx(I2CSlave *i2c, uint8_t data)
>      return 0;
>  }
>
> -static int max7310_event(I2CSlave *i2c, enum i2c_event event)
> +static int max7310_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      MAX7310State *s =3D MAX7310(i2c);
>      s->len =3D 0;
> @@ -163,7 +163,7 @@ static const VMStateDescription vmstate_max7310 =3D {
>          VMSTATE_UINT8(polarity, MAX7310State),
>          VMSTATE_UINT8(status, MAX7310State),
>          VMSTATE_UINT8(command, MAX7310State),
> -        VMSTATE_I2C_SLAVE(parent_obj, MAX7310State),
> +        VMSTATE_I2C_TARGET(parent_obj, MAX7310State),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -192,7 +192,7 @@ static void max7310_realize(DeviceState *dev, Error
> **errp)
>  static void max7310_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k =3D I2C_TARGET_CLASS(klass);
>
>      dc->realize =3D max7310_realize;
>      k->event =3D max7310_event;
> @@ -204,7 +204,7 @@ static void max7310_class_init(ObjectClass *klass,
> void *data)
>
>  static const TypeInfo max7310_info =3D {
>      .name          =3D TYPE_MAX7310,
> -    .parent        =3D TYPE_I2C_SLAVE,
> +    .parent        =3D TYPE_I2C_TARGET,
>      .instance_size =3D sizeof(MAX7310State),
>      .class_init    =3D max7310_class_init,
>  };
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index 27d4db0680..8c691b805a 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -26,7 +26,7 @@
>
>  struct PCA955xClass {
>      /*< private >*/
> -    I2CSlaveClass parent_class;
> +    I2CTargetClass parent_class;
>      /*< public >*/
>
>      uint8_t pin_count;
> @@ -217,7 +217,7 @@ static void pca955x_autoinc(PCA955xState *s)
>      }
>  }
>
> -static uint8_t pca955x_recv(I2CSlave *i2c)
> +static uint8_t pca955x_recv(I2CTarget *i2c)
>  {
>      PCA955xState *s =3D PCA955X(i2c);
>      uint8_t ret;
> @@ -245,7 +245,7 @@ static uint8_t pca955x_recv(I2CSlave *i2c)
>      return ret;
>  }
>
> -static int pca955x_send(I2CSlave *i2c, uint8_t data)
> +static int pca955x_send(I2CTarget *i2c, uint8_t data)
>  {
>      PCA955xState *s =3D PCA955X(i2c);
>
> @@ -262,7 +262,7 @@ static int pca955x_send(I2CSlave *i2c, uint8_t data)
>      return 0;
>  }
>
> -static int pca955x_event(I2CSlave *i2c, enum i2c_event event)
> +static int pca955x_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      PCA955xState *s =3D PCA955X(i2c);
>
> @@ -354,7 +354,7 @@ static const VMStateDescription pca9552_vmstate =3D {
>          VMSTATE_UINT8(pointer, PCA955xState),
>          VMSTATE_UINT8_ARRAY(regs, PCA955xState, PCA955X_NR_REGS),
>          VMSTATE_UINT8_ARRAY(ext_state, PCA955xState,
> PCA955X_PIN_COUNT_MAX),
> -        VMSTATE_I2C_SLAVE(i2c, PCA955xState),
> +        VMSTATE_I2C_TARGET(i2c, PCA955xState),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -436,7 +436,7 @@ static Property pca955x_properties[] =3D {
>  static void pca955x_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k =3D I2C_TARGET_CLASS(klass);
>
>      k->event =3D pca955x_event;
>      k->recv =3D pca955x_recv;
> @@ -447,7 +447,7 @@ static void pca955x_class_init(ObjectClass *klass,
> void *data)
>
>  static const TypeInfo pca955x_info =3D {
>      .name          =3D TYPE_PCA955X,
> -    .parent        =3D TYPE_I2C_SLAVE,
> +    .parent        =3D TYPE_I2C_TARGET,
>      .instance_init =3D pca955x_initfn,
>      .instance_size =3D sizeof(PCA955xState),
>      .class_init    =3D pca955x_class_init,
> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
> index 7d10a64ba7..7bd0a29c66 100644
> --- a/hw/gpio/pca9554.c
> +++ b/hw/gpio/pca9554.c
> @@ -22,7 +22,7 @@
>
>  struct PCA9554Class {
>      /*< private >*/
> -    I2CSlaveClass parent_class;
> +    I2CTargetClass parent_class;
>      /*< public >*/
>  };
>  typedef struct PCA9554Class PCA9554Class;
> @@ -115,7 +115,7 @@ static void pca9554_write(PCA9554State *s, uint8_t
> reg, uint8_t data)
>      }
>  }
>
> -static uint8_t pca9554_recv(I2CSlave *i2c)
> +static uint8_t pca9554_recv(I2CTarget *i2c)
>  {
>      PCA9554State *s =3D PCA9554(i2c);
>      uint8_t ret;
> @@ -125,7 +125,7 @@ static uint8_t pca9554_recv(I2CSlave *i2c)
>      return ret;
>  }
>
> -static int pca9554_send(I2CSlave *i2c, uint8_t data)
> +static int pca9554_send(I2CTarget *i2c, uint8_t data)
>  {
>      PCA9554State *s =3D PCA9554(i2c);
>
> @@ -140,7 +140,7 @@ static int pca9554_send(I2CSlave *i2c, uint8_t data)
>      return 0;
>  }
>
> -static int pca9554_event(I2CSlave *i2c, enum i2c_event event)
> +static int pca9554_event(I2CTarget *i2c, enum i2c_event event)
>  {
>      PCA9554State *s =3D PCA9554(i2c);
>
> @@ -227,7 +227,7 @@ static const VMStateDescription pca9554_vmstate =3D {
>          VMSTATE_UINT8(pointer, PCA9554State),
>          VMSTATE_UINT8_ARRAY(regs, PCA9554State, PCA9554_NR_REGS),
>          VMSTATE_UINT8_ARRAY(ext_state, PCA9554State, PCA9554_PIN_COUNT),
> -        VMSTATE_I2C_SLAVE(i2c, PCA9554State),
> +        VMSTATE_I2C_TARGET(i2c, PCA9554State),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -299,7 +299,7 @@ static Property pca9554_properties[] =3D {
>  static void pca9554_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k =3D I2C_TARGET_CLASS(klass);
>
>      k->event =3D pca9554_event;
>      k->recv =3D pca9554_recv;
> @@ -312,7 +312,7 @@ static void pca9554_class_init(ObjectClass *klass,
> void *data)
>
>  static const TypeInfo pca9554_info =3D {
>      .name          =3D TYPE_PCA9554,
> -    .parent        =3D TYPE_I2C_SLAVE,
> +    .parent        =3D TYPE_I2C_TARGET,
>      .instance_init =3D pca9554_initfn,
>      .instance_size =3D sizeof(PCA9554State),
>      .class_init    =3D pca9554_class_init,
> diff --git a/hw/gpio/pcf8574.c b/hw/gpio/pcf8574.c
> index d37909e2ad..460023ceb3 100644
> --- a/hw/gpio/pcf8574.c
> +++ b/hw/gpio/pcf8574.c
> @@ -39,7 +39,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PCF8574State, PCF8574)
>  #define PORTS_COUNT (8)
>
>  struct PCF8574State {
> -    I2CSlave parent_obj;
> +    I2CTarget parent_obj;
>      uint8_t  lastrq;     /* Last requested state. If changed - assert ir=
q
> */
>      uint8_t  input;      /* external electrical line state */
>      uint8_t  output;     /* Pull-up (1) or drive low (0) on bit */
> @@ -61,7 +61,7 @@ static inline uint8_t pcf8574_line_state(PCF8574State *=
s)
>      return s->input & s->output;
>  }
>
> -static uint8_t pcf8574_rx(I2CSlave *i2c)
> +static uint8_t pcf8574_rx(I2CTarget *i2c)
>  {
>      PCF8574State *s =3D PCF8574(i2c);
>      uint8_t linestate =3D pcf8574_line_state(s);
> @@ -74,7 +74,7 @@ static uint8_t pcf8574_rx(I2CSlave *i2c)
>      return linestate;
>  }
>
> -static int pcf8574_tx(I2CSlave *i2c, uint8_t data)
> +static int pcf8574_tx(I2CTarget *i2c, uint8_t data)
>  {
>      PCF8574State *s =3D PCF8574(i2c);
>      uint8_t prev;
> @@ -105,7 +105,7 @@ static const VMStateDescription vmstate_pcf8574 =3D {
>      .version_id         =3D 0,
>      .minimum_version_id =3D 0,
>      .fields =3D (VMStateField[]) {
> -        VMSTATE_I2C_SLAVE(parent_obj, PCF8574State),
> +        VMSTATE_I2C_TARGET(parent_obj, PCF8574State),
>          VMSTATE_UINT8(lastrq, PCF8574State),
>          VMSTATE_UINT8(input,  PCF8574State),
>          VMSTATE_UINT8(output, PCF8574State),
> @@ -141,7 +141,7 @@ static void pcf8574_realize(DeviceState *dev, Error
> **errp)
>  static void pcf8574_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass   *dc =3D DEVICE_CLASS(klass);
> -    I2CSlaveClass *k  =3D I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *k  =3D I2C_TARGET_CLASS(klass);
>
>      k->recv     =3D pcf8574_rx;
>      k->send     =3D pcf8574_tx;
> @@ -153,7 +153,7 @@ static void pcf8574_class_init(ObjectClass *klass,
> void *data)
>  static const TypeInfo pcf8574_infos[] =3D {
>      {
>          .name          =3D TYPE_PCF8574,
> -        .parent        =3D TYPE_I2C_SLAVE,
> +        .parent        =3D TYPE_I2C_TARGET,
>          .instance_size =3D sizeof(PCF8574State),
>          .class_init    =3D pcf8574_class_init,
>      }
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index b43afd250d..8ed67d5f0c 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -536,7 +536,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus
> *bus, uint64_t value)
>          SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, M_STOP_CMD, 0);
>          aspeed_i2c_set_state(bus, I2CD_IDLE);
>
> -        i2c_schedule_pending_master(bus->bus);
> +        i2c_schedule_pending_controller(bus->bus);
>      }
>
>      if (aspeed_i2c_bus_pkt_mode_en(bus)) {
> @@ -693,7 +693,7 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus
> *bus, hwaddr offset,
>          } else {
>              bus->regs[R_I2CS_CMD] =3D value;
>          }
> -        i2c_slave_set_address(bus->slave, bus->regs[R_I2CS_DEV_ADDR]);
> +        i2c_target_set_address(bus->slave, bus->regs[R_I2CS_DEV_ADDR]);
>          break;
>      case A_I2CS_INTR_CTRL:
>          bus->regs[R_I2CS_INTR_CTRL] =3D value;
> @@ -738,7 +738,7 @@ static void aspeed_i2c_bus_old_write(AspeedI2CBus
> *bus, hwaddr offset,
>      switch (offset) {
>      case A_I2CD_FUN_CTRL:
>          if (SHARED_FIELD_EX32(value, SLAVE_EN)) {
> -            i2c_slave_set_address(bus->slave, bus->regs[R_I2CD_DEV_ADDR]=
);
> +            i2c_target_set_address(bus->slave,
> bus->regs[R_I2CD_DEV_ADDR]);
>          }
>          bus->regs[R_I2CD_FUN_CTRL] =3D value & 0x0071C3FF;
>          break;
> @@ -1112,7 +1112,7 @@ static int
> aspeed_i2c_bus_new_slave_event(AspeedI2CBus *bus,
>      return 0;
>  }
>
> -static int aspeed_i2c_bus_slave_event(I2CSlave *slave, enum i2c_event
> event)
> +static int aspeed_i2c_bus_slave_event(I2CTarget *slave, enum i2c_event
> event)
>  {
>      BusState *qbus =3D qdev_get_parent_bus(DEVICE(slave));
>      AspeedI2CBus *bus =3D ASPEED_I2C_BUS(qbus->parent);
> @@ -1167,7 +1167,7 @@ static void
> aspeed_i2c_bus_new_slave_send_async(AspeedI2CBus *bus, uint8_t data)
>      i2c_ack(bus->bus);
>  }
>
> -static void aspeed_i2c_bus_slave_send_async(I2CSlave *slave, uint8_t dat=
a)
> +static void aspeed_i2c_bus_slave_send_async(I2CTarget *slave, uint8_t
> data)
>  {
>      BusState *qbus =3D qdev_get_parent_bus(DEVICE(slave));
>      AspeedI2CBus *bus =3D ASPEED_I2C_BUS(qbus->parent);
> @@ -1187,7 +1187,7 @@ static void aspeed_i2c_bus_slave_send_async(I2CSlav=
e
> *slave, uint8_t data)
>  static void aspeed_i2c_bus_slave_class_init(ObjectClass *klass, void
> *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    I2CSlaveClass *sc =3D I2C_SLAVE_CLASS(klass);
> +    I2CTargetClass *sc =3D I2C_TARGET_CLASS(klass);
>
>      dc->desc =3D "Aspeed I2C Bus Slave";
>
> @@ -1197,7 +1197,7 @@ static void
> aspeed_i2c_bus_slave_class_init(ObjectClass *klass, void *data)
>
>  static const TypeInfo aspeed_i2c_bus_slave_info =3D {
>      .name           =3D TYPE_ASPEED_I2C_BUS_SLAVE,
> -    .parent         =3D TYPE_I2C_SLAVE,
> +    .parent         =3D TYPE_I2C_TARGET,
>      .instance_size  =3D sizeof(AspeedI2CBusSlave),
>      .class_init     =3D aspeed_i2c_bus_slave_class_init,
>  };
> @@ -1226,7 +1226,7 @@ static void aspeed_i2c_bus_realize(DeviceState *dev=
,
> Error **errp)
>      sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
>
>      s->bus =3D i2c_init_bus(dev, name);
> -    s->slave =3D i2c_slave_create_simple(s->bus, TYPE_ASPEED_I2C_BUS_SLA=
VE,
> +    s->slave =3D i2c_target_create_simple(s->bus, TYPE_ASPEED_I2C_BUS_SL=
AVE,
>                                         0xff);
>
>      memory_region_init_io(&s->mr, OBJECT(s), &aspeed_i2c_bus_ops,
> diff --git a/hw/i2c/core.c b/hw/i2c/core.c
> index 4cf30b2c86..fd34a6bc83 100644
> --- a/hw/i2c/core.c
> +++ b/hw/i2c/core.c
> @@ -19,7 +19,7 @@
>  #define I2C_BROADCAST 0x00
>
>  static Property i2c_props[] =3D {
> -    DEFINE_PROP_UINT8("address", struct I2CSlave, address, 0),
> +    DEFINE_PROP_UINT8("address", struct I2CTarget, address, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> @@ -63,12 +63,12 @@ I2CBus *i2c_init_bus(DeviceState *parent, const char
> *name)
>
>      bus =3D I2C_BUS(qbus_new(TYPE_I2C_BUS, parent, name));
>      QLIST_INIT(&bus->current_devs);
> -    QSIMPLEQ_INIT(&bus->pending_masters);
> +    QSIMPLEQ_INIT(&bus->pending_controllers);
>      vmstate_register_any(NULL, &vmstate_i2c_bus, bus);
>      return bus;
>  }
>
> -void i2c_slave_set_address(I2CSlave *dev, uint8_t address)
> +void i2c_target_set_address(I2CTarget *dev, uint8_t address)
>  {
>      dev->address =3D address;
>  }
> @@ -86,8 +86,8 @@ bool i2c_scan_bus(I2CBus *bus, uint8_t address, bool
> broadcast,
>
>      QTAILQ_FOREACH(kid, &bus->qbus.children, sibling) {
>          D

--000000000000a13c9e0615a622bf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 8 apr 2024, 23:34 Philippe Mathieu-Daud=C3=A9 &=
lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; ha scritt=
o:</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">
Note, the QOM type definition is not modified, TYPE_I2C_TARGET<br>
remains defined as &quot;i2c-slave&quot;.<br></blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Is this actually necessary? The on=
ly thing that could break is -global but I don&#39;t think it matters reall=
y.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
<br>
[*] <a href=3D"https://github.com/conscious-lang/conscious-lang-docs/blob/m=
ain/faq.md" rel=3D"noreferrer noreferrer" target=3D"_blank">https://github.=
com/conscious-lang/conscious-lang-docs/blob/main/faq.md</a><br>
<br>
Inspired-by: Wolfram Sang &lt;<a href=3D"mailto:wsa%2Brenesas@sang-engineer=
ing.com" target=3D"_blank" rel=3D"noreferrer">wsa+renesas@sang-engineering.=
com</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank" rel=3D"noreferrer">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0include/hw/display/i2c-ddc.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br=
>
=C2=A0include/hw/gpio/pca9552.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 =
+-<br>
=C2=A0include/hw/gpio/pca9554.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 =
+-<br>
=C2=A0include/hw/i2c/aspeed_i2c.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br=
>
=C2=A0include/hw/i2c/i2c.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 66 ++++-----<br>
=C2=A0include/hw/i2c/i2c_mux_pca954x.h |=C2=A0 =C2=A02 +-<br>
=C2=A0include/hw/i2c/smbus_slave.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br=
>
=C2=A0include/hw/nvram/eeprom_at24c.h=C2=A0 |=C2=A0 =C2=A04 +-<br>
=C2=A0include/hw/sensor/tmp105.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 =
+-<br>
=C2=A0hw/arm/aspeed.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 232 +++++++++++++++----------------<br>
=C2=A0hw/arm/bananapi_m2u.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A02 +-<br>
=C2=A0hw/arm/cubieboard.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A02 +-<br>
=C2=A0hw/arm/musicpal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A06 +-<br>
=C2=A0hw/arm/npcm7xx_boards.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 44 =
+++---<br>
=C2=A0hw/arm/nseries.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A06 +-<br>
=C2=A0hw/arm/pxa2xx.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 36 ++---<br>
=C2=A0hw/arm/realview.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0hw/arm/spitz.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 12 +-<br>
=C2=A0hw/arm/stellaris.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0hw/arm/tosa.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 14 +-<br>
=C2=A0hw/arm/versatilepb.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A02 +-<br>
=C2=A0hw/arm/vexpress.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0hw/arm/z2.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 20 +--<br>
=C2=A0hw/audio/wm8750.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 18 +--<br>
=C2=A0hw/display/ati.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
=C2=A0hw/display/i2c-ddc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 10 +-<br>
=C2=A0hw/display/sii9022.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 16 +--<br>
=C2=A0hw/display/sm501.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0hw/display/ssd0303.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 14 +-<br>
=C2=A0hw/display/xlnx_dp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A02 +-<br>
=C2=A0hw/gpio/max7310.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 14 +-<br>
=C2=A0hw/gpio/pca9552.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 14 +-<br>
=C2=A0hw/gpio/pca9554.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 14 +-<br>
=C2=A0hw/gpio/pcf8574.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 12 +-<br>
=C2=A0hw/i2c/aspeed_i2c.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 16 +--<br>
=C2=A0hw/i2c/core.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 88 ++++++------<br>
=C2=A0hw/i2c/i2c_mux_pca954x.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A06 +-<br>
=C2=A0hw/i2c/imx_i2c.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0hw/i2c/smbus_slave.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 12 +-<br>
=C2=A0hw/input/lm832x.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 14 +-<br>
=C2=A0hw/misc/axp2xx.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 14 +-<br>
=C2=A0hw/misc/i2c-echo.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 14 +-<br>
=C2=A0hw/nvram/eeprom_at24c.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 22 =
+--<br>
=C2=A0hw/ppc/e500.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0hw/ppc/pnv.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
=C2=A0hw/ppc/sam460ex.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0hw/rtc/ds1338.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 14 +-<br>
=C2=A0hw/rtc/m41t80.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 12 +-<br>
=C2=A0hw/rtc/twl92230.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 16 +--<br>
=C2=A0hw/sensor/dps310.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 14 +-<br>
=C2=A0hw/sensor/emc141x.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 16 +--<br>
=C2=A0hw/sensor/lsm303dlhc_mag.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 16 +--<b=
r>
=C2=A0hw/sensor/tmp105.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 16 +--<br>
=C2=A0hw/sensor/tmp421.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 20 +--<br>
=C2=A0hw/tpm/tpm_tis_i2c.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 12 +-<br>
=C2=A055 files changed, 461 insertions(+), 461 deletions(-)<br>
<br>
diff --git a/include/hw/display/i2c-ddc.h b/include/hw/display/i2c-ddc.h<br=
>
index 94b5880587..faf3cd84fa 100644<br>
--- a/include/hw/display/i2c-ddc.h<br>
+++ b/include/hw/display/i2c-ddc.h<br>
@@ -26,7 +26,7 @@<br>
=C2=A0/* A simple I2C slave which just returns the contents of its EDID blo=
b. */<br>
=C2=A0struct I2CDDCState {<br>
=C2=A0 =C2=A0 =C2=A0/*&lt; private &gt;*/<br>
-=C2=A0 =C2=A0 I2CSlave i2c;<br>
+=C2=A0 =C2=A0 I2CTarget i2c;<br>
=C2=A0 =C2=A0 =C2=A0/*&lt; public &gt;*/<br>
=C2=A0 =C2=A0 =C2=A0bool firstbyte;<br>
=C2=A0 =C2=A0 =C2=A0uint8_t reg;<br>
diff --git a/include/hw/gpio/pca9552.h b/include/hw/gpio/pca9552.h<br>
index c36525f0c3..d7f07a44e0 100644<br>
--- a/include/hw/gpio/pca9552.h<br>
+++ b/include/hw/gpio/pca9552.h<br>
@@ -23,7 +23,7 @@ DECLARE_INSTANCE_CHECKER(PCA955xState, PCA955X,<br>
<br>
=C2=A0struct PCA955xState {<br>
=C2=A0 =C2=A0 =C2=A0/*&lt; private &gt;*/<br>
-=C2=A0 =C2=A0 I2CSlave i2c;<br>
+=C2=A0 =C2=A0 I2CTarget i2c;<br>
=C2=A0 =C2=A0 =C2=A0/*&lt; public &gt;*/<br>
<br>
=C2=A0 =C2=A0 =C2=A0uint8_t len;<br>
diff --git a/include/hw/gpio/pca9554.h b/include/hw/gpio/pca9554.h<br>
index 54bfc4c4c7..0b528a0033 100644<br>
--- a/include/hw/gpio/pca9554.h<br>
+++ b/include/hw/gpio/pca9554.h<br>
@@ -21,7 +21,7 @@ DECLARE_INSTANCE_CHECKER(PCA9554State, PCA9554,<br>
<br>
=C2=A0struct PCA9554State {<br>
=C2=A0 =C2=A0 =C2=A0/*&lt; private &gt;*/<br>
-=C2=A0 =C2=A0 I2CSlave i2c;<br>
+=C2=A0 =C2=A0 I2CTarget i2c;<br>
=C2=A0 =C2=A0 =C2=A0/*&lt; public &gt;*/<br>
<br>
=C2=A0 =C2=A0 =C2=A0uint8_t len;<br>
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h<br>
index a064479e59..d8fd179a69 100644<br>
--- a/include/hw/i2c/aspeed_i2c.h<br>
+++ b/include/hw/i2c/aspeed_i2c.h<br>
@@ -236,7 +236,7 @@ struct AspeedI2CBus {<br>
=C2=A0 =C2=A0 =C2=A0struct AspeedI2CState *controller;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* slave mode */<br>
-=C2=A0 =C2=A0 I2CSlave *slave;<br>
+=C2=A0 =C2=A0 I2CTarget *slave;<br>
<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion mr;<br>
<br>
@@ -267,7 +267,7 @@ struct AspeedI2CState {<br>
=C2=A0#define TYPE_ASPEED_I2C_BUS_SLAVE &quot;aspeed.i2c.slave&quot;<br>
=C2=A0OBJECT_DECLARE_SIMPLE_TYPE(AspeedI2CBusSlave, ASPEED_I2C_BUS_SLAVE)<b=
r>
=C2=A0struct AspeedI2CBusSlave {<br>
-=C2=A0 =C2=A0 I2CSlave i2c;<br>
+=C2=A0 =C2=A0 I2CTarget i2c;<br>
=C2=A0};<br>
<br>
=C2=A0struct AspeedI2CClass {<br>
diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h<br>
index a1b3f4d179..fa00098477 100644<br>
--- a/include/hw/i2c/i2c.h<br>
+++ b/include/hw/i2c/i2c.h<br>
@@ -21,34 +21,34 @@ enum i2c_event {<br>
<br>
=C2=A0typedef struct I2CNodeList I2CNodeList;<br>
<br>
-#define TYPE_I2C_SLAVE &quot;i2c-slave&quot;<br>
-OBJECT_DECLARE_TYPE(I2CSlave, I2CSlaveClass,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I2C_=
SLAVE)<br>
+#define TYPE_I2C_TARGET &quot;i2c-slave&quot;<br>
+OBJECT_DECLARE_TYPE(I2CTarget, I2CTargetClass,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I2C_=
TARGET)<br>
<br>
-struct I2CSlaveClass {<br>
+struct I2CTargetClass {<br>
=C2=A0 =C2=A0 =C2=A0DeviceClass parent_class;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Master to slave. Returns non-zero for a NAK, 0 for s=
uccess. */<br>
-=C2=A0 =C2=A0 int (*send)(I2CSlave *s, uint8_t data);<br>
+=C2=A0 =C2=A0 int (*send)(I2CTarget *s, uint8_t data);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * Master to slave (asynchronous).<br>
=C2=A0 =C2=A0 =C2=A0 * Receiving slave must call i2c_ack().<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 void (*send_async)(I2CSlave *s, uint8_t data);<br>
+=C2=A0 =C2=A0 void (*send_async)(I2CTarget *s, uint8_t data);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * Slave to master.=C2=A0 This cannot fail, the device =
should always<br>
=C2=A0 =C2=A0 =C2=A0 * return something here.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 uint8_t (*recv)(I2CSlave *s);<br>
+=C2=A0 =C2=A0 uint8_t (*recv)(I2CTarget *s);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * Notify the slave of a bus state change.=C2=A0 For st=
art event,<br>
=C2=A0 =C2=A0 =C2=A0 * returns non-zero to NAK an operation.=C2=A0 For othe=
r events the<br>
=C2=A0 =C2=A0 =C2=A0 * return code is not used and should be zero.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 int (*event)(I2CSlave *s, enum i2c_event event);<br>
+=C2=A0 =C2=A0 int (*event)(I2CTarget *s, enum i2c_event event);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * Check if this device matches the address provided.=
=C2=A0 Returns bool of<br>
@@ -57,11 +57,11 @@ struct I2CSlaveClass {<br>
=C2=A0 =C2=A0 =C2=A0 *<br>
=C2=A0 =C2=A0 =C2=A0 * If broadcast is true, match should add the device an=
d return true.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 bool (*match_and_add)(I2CSlave *candidate, uint8_t address, =
bool broadcast,<br>
+=C2=A0 =C2=A0 bool (*match_and_add)(I2CTarget *candidate, uint8_t address,=
 bool broadcast,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0I2CNodeList *current_devs);<br>
=C2=A0};<br>
<br>
-struct I2CSlave {<br>
+struct I2CTarget {<br>
=C2=A0 =C2=A0 =C2=A0DeviceState qdev;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Remaining fields for internal use by the I2C code.=
=C2=A0 */<br>
@@ -74,25 +74,25 @@ OBJECT_DECLARE_SIMPLE_TYPE(I2CBus, I2C_BUS)<br>
=C2=A0typedef struct I2CNode I2CNode;<br>
<br>
=C2=A0struct I2CNode {<br>
-=C2=A0 =C2=A0 I2CSlave *elt;<br>
+=C2=A0 =C2=A0 I2CTarget *elt;<br>
=C2=A0 =C2=A0 =C2=A0QLIST_ENTRY(I2CNode) next;<br>
=C2=A0};<br>
<br>
-typedef struct I2CPendingMaster I2CPendingMaster;<br>
+typedef struct I2CPendingController I2CPendingController;<br>
<br>
-struct I2CPendingMaster {<br>
+struct I2CPendingController {<br>
=C2=A0 =C2=A0 =C2=A0QEMUBH *bh;<br>
-=C2=A0 =C2=A0 QSIMPLEQ_ENTRY(I2CPendingMaster) entry;<br>
+=C2=A0 =C2=A0 QSIMPLEQ_ENTRY(I2CPendingController) entry;<br>
=C2=A0};<br>
<br>
=C2=A0typedef QLIST_HEAD(I2CNodeList, I2CNode) I2CNodeList;<br>
-typedef QSIMPLEQ_HEAD(I2CPendingMasters, I2CPendingMaster)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I2CPendingMasters;<br>
+typedef QSIMPLEQ_HEAD(I2CPendingControllers, I2CPendingController)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I2CPendingControllers;<br>
<br>
=C2=A0struct I2CBus {<br>
=C2=A0 =C2=A0 =C2=A0BusState qbus;<br>
=C2=A0 =C2=A0 =C2=A0I2CNodeList current_devs;<br>
-=C2=A0 =C2=A0 I2CPendingMasters pending_masters;<br>
+=C2=A0 =C2=A0 I2CPendingControllers pending_controllers;<br>
=C2=A0 =C2=A0 =C2=A0uint8_t saved_address;<br>
=C2=A0 =C2=A0 =C2=A0bool broadcast;<br>
<br>
@@ -147,12 +147,12 @@ int i2c_start_send(I2CBus *bus, uint8_t address);<br>
=C2=A0 */<br>
=C2=A0int i2c_start_send_async(I2CBus *bus, uint8_t address);<br>
<br>
-void i2c_schedule_pending_master(I2CBus *bus);<br>
+void i2c_schedule_pending_controller(I2CBus *bus);<br>
<br>
=C2=A0void i2c_end_transfer(I2CBus *bus);<br>
=C2=A0void i2c_nack(I2CBus *bus);<br>
=C2=A0void i2c_ack(I2CBus *bus);<br>
-void i2c_bus_master(I2CBus *bus, QEMUBH *bh);<br>
+void i2c_bus_controller(I2CBus *bus, QEMUBH *bh);<br>
=C2=A0void i2c_bus_release(I2CBus *bus);<br>
=C2=A0int i2c_send(I2CBus *bus, uint8_t data);<br>
=C2=A0int i2c_send_async(I2CBus *bus, uint8_t data);<br>
@@ -169,7 +169,7 @@ bool i2c_scan_bus(I2CBus *bus, uint8_t address, bool br=
oadcast,<br>
=C2=A0 * properties to be set. Type @name must exist. The device still<br>
=C2=A0 * needs to be realized. See qdev-core.h.<br>
=C2=A0 */<br>
-I2CSlave *i2c_slave_new(const char *name, uint8_t addr);<br>
+I2CTarget *i2c_target_new(const char *name, uint8_t addr);<br>
<br>
=C2=A0/**<br>
=C2=A0 * Create and realize an I2C slave device on the heap.<br>
@@ -180,8 +180,8 @@ I2CSlave *i2c_slave_new(const char *name, uint8_t addr)=
;<br>
=C2=A0 * Create the device state structure, initialize it, put it on the<br=
>
=C2=A0 * specified @bus, and drop the reference to it (the device is realiz=
ed).<br>
=C2=A0 */<br>
-I2CSlave *i2c_slave_create_simple(I2CBus *bus,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *name, uint8_t add=
r);<br>
+I2CTarget *i2c_target_create_simple(I2CBus *bus,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *name, uint=
8_t addr);<br>
<br>
=C2=A0/**<br>
=C2=A0 * Realize and drop a reference an I2C slave device<br>
@@ -196,10 +196,10 @@ I2CSlave *i2c_slave_create_simple(I2CBus *bus,<br>
=C2=A0 * reference to it.<br>
=C2=A0 *<br>
=C2=A0 * This function is useful if you have created @dev via qdev_new(),<b=
r>
- * i2c_slave_new() or i2c_slave_try_new() (which take a reference to<br>
+ * i2c_target_new() or i2c_slave_try_new() (which take a reference to<br>
=C2=A0 * the device it returns to you), so that you can set properties on i=
t<br>
=C2=A0 * before realizing it. If you don&#39;t need to set properties then<=
br>
- * i2c_slave_create_simple() is probably better (as it does the create,<br=
>
+ * i2c_target_create_simple() is probably better (as it does the create,<b=
r>
=C2=A0 * init and realize in one step).<br>
=C2=A0 *<br>
=C2=A0 * If you are embedding the I2C slave into another QOM device and<br>
@@ -211,23 +211,23 @@ I2CSlave *i2c_slave_create_simple(I2CBus *bus,<br>
=C2=A0 * which doesn&#39;t currently exist but would be trivial to create i=
f we<br>
=C2=A0 * had any code that wanted it.)<br>
=C2=A0 */<br>
-bool i2c_slave_realize_and_unref(I2CSlave *dev, I2CBus *bus, Error **errp)=
;<br>
+bool i2c_target_realize_and_unref(I2CTarget *dev, I2CBus *bus, Error **err=
p);<br>
<br>
=C2=A0/**<br>
=C2=A0 * Set the I2C bus address of a slave device<br>
=C2=A0 * @dev: I2C slave device<br>
=C2=A0 * @address: I2C address of the slave when put on a bus<br>
=C2=A0 */<br>
-void i2c_slave_set_address(I2CSlave *dev, uint8_t address);<br>
+void i2c_target_set_address(I2CTarget *dev, uint8_t address);<br>
<br>
-extern const VMStateDescription vmstate_i2c_slave;<br>
+extern const VMStateDescription vmstate_i2c_target;<br>
<br>
-#define VMSTATE_I2C_SLAVE(_field, _state) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D (stringify(_field)),=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 .size=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D sizeof(I2CSlave),=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 .vmsd=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &amp;vmstate_i2c_slave,=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 .flags=C2=A0 =C2=A0 =C2=A0 =3D VMS_STRUCT,=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 .offset=C2=A0 =C2=A0 =C2=A0=3D vmstate_offset_value(_state, =
_field, I2CSlave),=C2=A0 =C2=A0 \<br>
+#define VMSTATE_I2C_TARGET(_field, _state) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D (stringify(_field)),=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 .size=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D sizeof(I2CTarget),=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 .vmsd=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &amp;vmstate_i2c_target,=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 .flags=C2=A0 =C2=A0 =C2=A0 =3D VMS_STRUCT,=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 .offset=C2=A0 =C2=A0 =C2=A0=3D vmstate_offset_value(_state, =
_field, I2CTarget),=C2=A0 =C2=A0 \<br>
=C2=A0}<br>
<br>
=C2=A0#endif<br>
diff --git a/include/hw/i2c/i2c_mux_pca954x.h b/include/hw/i2c/i2c_mux_pca9=
54x.h<br>
index 3dd25ec983..89f6179dd2 100644<br>
--- a/include/hw/i2c/i2c_mux_pca954x.h<br>
+++ b/include/hw/i2c/i2c_mux_pca954x.h<br>
@@ -14,6 +14,6 @@<br>
=C2=A0 *<br>
=C2=A0 * Returns: a pointer to the associated i2c bus.<br>
=C2=A0 */<br>
-I2CBus *pca954x_i2c_get_bus(I2CSlave *mux, uint8_t channel);<br>
+I2CBus *pca954x_i2c_get_bus(I2CTarget *mux, uint8_t channel);<br>
<br>
=C2=A0#endif<br>
diff --git a/include/hw/i2c/smbus_slave.h b/include/hw/i2c/smbus_slave.h<br=
>
index 86bfe0a79e..04f4dc4f22 100644<br>
--- a/include/hw/i2c/smbus_slave.h<br>
+++ b/include/hw/i2c/smbus_slave.h<br>
@@ -34,7 +34,7 @@ OBJECT_DECLARE_TYPE(SMBusDevice, SMBusDeviceClass,<br>
<br>
<br>
=C2=A0struct SMBusDeviceClass {<br>
-=C2=A0 =C2=A0 I2CSlaveClass parent_class;<br>
+=C2=A0 =C2=A0 I2CTargetClass parent_class;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * An operation with no data, special in SMBus.<br>
@@ -68,7 +68,7 @@ struct SMBusDeviceClass {<br>
<br>
=C2=A0struct SMBusDevice {<br>
=C2=A0 =C2=A0 =C2=A0/* The SMBus protocol is implemented on top of I2C.=C2=
=A0 */<br>
-=C2=A0 =C2=A0 I2CSlave i2c;<br>
+=C2=A0 =C2=A0 I2CTarget i2c;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Remaining fields for internal use only.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0int32_t mode;<br>
diff --git a/include/hw/nvram/eeprom_at24c.h b/include/hw/nvram/eeprom_at24=
c.h<br>
index 9d29f0a69a..caf06e52c7 100644<br>
--- a/include/hw/nvram/eeprom_at24c.h<br>
+++ b/include/hw/nvram/eeprom_at24c.h<br>
@@ -18,7 +18,7 @@<br>
=C2=A0 * Create the device state structure, initialize it, put it on the sp=
ecified<br>
=C2=A0 * @bus, and drop the reference to it (the device is realized).<br>
=C2=A0 */<br>
-I2CSlave *at24c_eeprom_init(I2CBus *bus, uint8_t address, uint32_t rom_siz=
e);<br>
+I2CTarget *at24c_eeprom_init(I2CBus *bus, uint8_t address, uint32_t rom_si=
ze);<br>
<br>
<br>
=C2=A0/*<br>
@@ -33,7 +33,7 @@ I2CSlave *at24c_eeprom_init(I2CBus *bus, uint8_t address,=
 uint32_t rom_size);<br>
=C2=A0 * @bus, and drop the reference to it (the device is realized). Copie=
s the data<br>
=C2=A0 * from @init_rom to the beginning of the EEPROM memory buffer.<br>
=C2=A0 */<br>
-I2CSlave *at24c_eeprom_init_rom(I2CBus *bus,<br>
+I2CTarget *at24c_eeprom_init_rom(I2CBus *bus,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t address, uint32_t rom_=
size,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const uint8_t *init_rom,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t init_rom_size);<br>
diff --git a/include/hw/sensor/tmp105.h b/include/hw/sensor/tmp105.h<br>
index 244e2989fe..6034671fc4 100644<br>
--- a/include/hw/sensor/tmp105.h<br>
+++ b/include/hw/sensor/tmp105.h<br>
@@ -30,7 +30,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(TMP105State, TMP105)<br>
=C2=A0 */<br>
=C2=A0struct TMP105State {<br>
=C2=A0 =C2=A0 =C2=A0/*&lt; private &gt;*/<br>
-=C2=A0 =C2=A0 I2CSlave i2c;<br>
+=C2=A0 =C2=A0 I2CTarget i2c;<br>
=C2=A0 =C2=A0 =C2=A0/*&lt; public &gt;*/<br>
<br>
=C2=A0 =C2=A0 =C2=A0uint8_t len;<br>
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c<br>
index 8279ad748a..d95d310b1a 100644<br>
--- a/hw/arm/aspeed.c<br>
+++ b/hw/arm/aspeed.c<br>
@@ -459,13 +459,13 @@ static void palmetto_bmc_i2c_init(AspeedMachineState =
*bmc)<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* The palmetto platform expects a ds3231 RTC but a ds1=
338 is<br>
=C2=A0 =C2=A0 =C2=A0 * enough to provide basic RTC features. Alarms will be=
 missing */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 0), &quot;ds1338&quot;, 0x68);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 0), &quot;ds1338&quot;, 0x68);<br>
<br>
=C2=A0 =C2=A0 =C2=A0smbus_eeprom_init_one(aspeed_i2c_get_bus(&amp;soc-&gt;i=
2c, 0), 0x50,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0eeprom_buf);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* add a TMP423 temperature sensor */<br>
-=C2=A0 =C2=A0 dev =3D DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&a=
mp;soc-&gt;i2c, 2),<br>
+=C2=A0 =C2=A0 dev =3D DEVICE(i2c_target_create_simple(aspeed_i2c_get_bus(&=
amp;soc-&gt;i2c, 2),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
quot;tmp423&quot;, 0x4c));<br>
=C2=A0 =C2=A0 =C2=A0object_property_set_int(OBJECT(dev), &quot;temperature0=
&quot;, 31000, &amp;error_abort);<br>
=C2=A0 =C2=A0 =C2=A0object_property_set_int(OBJECT(dev), &quot;temperature1=
&quot;, 28000, &amp;error_abort);<br>
@@ -481,21 +481,21 @@ static void quanta_q71l_bmc_i2c_init(AspeedMachineSta=
te *bmc)<br>
=C2=A0 =C2=A0 =C2=A0 * The quanta-q71l platform expects tmp75s which are co=
mpatible with<br>
=C2=A0 =C2=A0 =C2=A0 * tmp105s.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 1), &quot;tmp105&quot;, 0x4c);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 1), &quot;tmp105&quot;, 0x4e);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 1), &quot;tmp105&quot;, 0x4f);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 1), &quot;tmp105&quot;, 0x4c);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 1), &quot;tmp105&quot;, 0x4e);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 1), &quot;tmp105&quot;, 0x4f);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* TODO: i2c-1: Add baseboard FRU eeprom@54 24c64 */<br=
>
=C2=A0 =C2=A0 =C2=A0/* TODO: i2c-1: Add Frontpanel FRU eeprom@57 24c64 */<b=
r>
=C2=A0 =C2=A0 =C2=A0/* TODO: Add Memory Riser i2c mux and eeproms. */<br>
<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 2), &quot;pca9546&quot;, 0x74);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 2), &quot;pca9548&quot;, 0x77);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 2), &quot;pca9546&quot;, 0x74);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 2), &quot;pca9548&quot;, 0x77);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* TODO: i2c-3: Add BIOS FRU eeprom@56 24c64 */<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* i2c-7 */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 7), &quot;pca9546&quot;, 0x70);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 7), &quot;pca9546&quot;, 0x70);<br>
=C2=A0 =C2=A0 =C2=A0/*=C2=A0 =C2=A0 =C2=A0 =C2=A0 - i2c@0: pmbus@59 */<br>
=C2=A0 =C2=A0 =C2=A0/*=C2=A0 =C2=A0 =C2=A0 =C2=A0 - i2c@1: pmbus@58 */<br>
=C2=A0 =C2=A0 =C2=A0/*=C2=A0 =C2=A0 =C2=A0 =C2=A0 - i2c@2: pmbus@58 */<br>
@@ -514,7 +514,7 @@ static void ast2500_evb_i2c_init(AspeedMachineState *bm=
c)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0eeprom_buf);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* The AST2500 EVB expects a LM75 but a TMP105 is compa=
tible */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 7),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 7),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 TYPE_TMP105, 0x4d);<br>
=C2=A0}<br>
<br>
@@ -527,7 +527,7 @@ static void ast2600_evb_i2c_init(AspeedMachineState *bm=
c)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0eeprom_buf);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* LM75 is compatible with TMP105 driver */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 8),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 8),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 TYPE_TMP105, 0x4d);<br>
=C2=A0}<br>
<br>
@@ -539,9 +539,9 @@ static void yosemitev2_bmc_i2c_init(AspeedMachineState =
*bmc)<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init_rom(aspeed_i2c_get_bus(&amp;soc-&gt;i=
2c, 8), 0x51, 128 * KiB,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0yosemitev2_bmc_fruid, yosemitev2_bmc_fruid_len);<br=
>
=C2=A0 =C2=A0 =C2=A0/* TMP421 */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 11), &quot;tmp421&quot;, 0x1f);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 9), &quot;tmp421&quot;, 0x4e);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 9), &quot;tmp421&quot;, 0x4f);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 11), &quot;tmp421&quot;, 0x1f);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 9), &quot;tmp421&quot;, 0x4e);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 9), &quot;tmp421&quot;, 0x4f);<br>
<br>
=C2=A0}<br>
<br>
@@ -551,7 +551,7 @@ static void romulus_bmc_i2c_init(AspeedMachineState *bm=
c)<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* The romulus board expects Epson RX8900 I2C RTC but a=
 ds1338 is<br>
=C2=A0 =C2=A0 =C2=A0 * good enough */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 11), &quot;ds1338&quot;, 0x32);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 11), &quot;ds1338&quot;, 0x32);<br>
=C2=A0}<br>
<br>
=C2=A0static void tiogapass_bmc_i2c_init(AspeedMachineState *bmc)<br>
@@ -562,14 +562,14 @@ static void tiogapass_bmc_i2c_init(AspeedMachineState=
 *bmc)<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init_rom(aspeed_i2c_get_bus(&amp;soc-&gt;i=
2c, 6), 0x54, 128 * KiB,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0tiogapass_bmc_fruid, tiogapass_bmc_fruid_len);<br>
=C2=A0 =C2=A0 =C2=A0/* TMP421 */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 8), &quot;tmp421&quot;, 0x1f);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 6), &quot;tmp421&quot;, 0x4f);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 6), &quot;tmp421&quot;, 0x4e);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 8), &quot;tmp421&quot;, 0x1f);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 6), &quot;tmp421&quot;, 0x4f);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 6), &quot;tmp421&quot;, 0x4e);<br>
=C2=A0}<br>
<br>
=C2=A0static void create_pca9552(AspeedSoCState *soc, int bus_id, int addr)=
<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 bus_id),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, bus_id),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_PCA9552, addr);<br>
=C2=A0}<br>
<br>
@@ -578,8 +578,8 @@ static void sonorapass_bmc_i2c_init(AspeedMachineState =
*bmc)<br>
=C2=A0 =C2=A0 =C2=A0AspeedSoCState *soc =3D bmc-&gt;soc;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* bus 2 : */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 2), &quot;tmp105&quot;, 0x48);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 2), &quot;tmp105&quot;, 0x49);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 2), &quot;tmp105&quot;, 0x48);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 2), &quot;tmp105&quot;, 0x49);<br>
=C2=A0 =C2=A0 =C2=A0/* bus 2 : pca9546 @ 0x73 */<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* bus 3 : pca9548 @ 0x70 */<br>
@@ -594,8 +594,8 @@ static void sonorapass_bmc_i2c_init(AspeedMachineState =
*bmc)<br>
=C2=A0 =C2=A0 =C2=A0create_pca9552(soc, 4, 0x77);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* bus 6 : */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 6), &quot;tmp105&quot;, 0x48);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 6), &quot;tmp105&quot;, 0x49);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 6), &quot;tmp105&quot;, 0x48);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 6), &quot;tmp105&quot;, 0x49);<br>
=C2=A0 =C2=A0 =C2=A0/* bus 6 : pca9546 @ 0x73 */<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* bus 8 : */<br>
@@ -635,9 +635,9 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState=
 *bmc)<br>
=C2=A0 =C2=A0 =C2=A0LEDState *led;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Bus 3: TODO bmp280@77 */<br>
-=C2=A0 =C2=A0 dev =3D DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));<br>
+=C2=A0 =C2=A0 dev =3D DEVICE(i2c_target_new(TYPE_PCA9552, 0x60));<br>
=C2=A0 =C2=A0 =C2=A0qdev_prop_set_string(dev, &quot;description&quot;, &quo=
t;pca1&quot;);<br>
-=C2=A0 =C2=A0 i2c_slave_realize_and_unref(I2C_SLAVE(dev),<br>
+=C2=A0 =C2=A0 i2c_target_realize_and_unref(I2C_SLAVE(dev),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aspeed_i2c_get_bus(&amp;soc-&g=
t;i2c, 3),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_fatal);<br>
<br>
@@ -649,29 +649,29 @@ static void witherspoon_bmc_i2c_init(AspeedMachineSta=
te *bmc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_connect_gpio_out(dev, pca1_leds[i].g=
pio_id,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(led), 0));<br=
>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 3),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 3),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;dps310&quot;, 0x76);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 3),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 3),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;max31785&quot;, 0x52);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 4),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 4),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;tmp423&quot;, 0x4c);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 5),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 5),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;tmp423&quot;, 0x4c);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* The Witherspoon expects a TMP275 but a TMP105 is com=
patible */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 9),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 9),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_TMP105, 0x4a);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* The witherspoon board expects Epson RX8900 I2C RTC b=
ut a ds1338 is<br>
=C2=A0 =C2=A0 =C2=A0 * good enough */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 11),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 11),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;ds1338&quot;, 0x32);<br>
<br>
=C2=A0 =C2=A0 =C2=A0smbus_eeprom_init_one(aspeed_i2c_get_bus(&amp;soc-&gt;i=
2c, 11), 0x51,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0eeprom_buf);<br>
-=C2=A0 =C2=A0 dev =3D DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));<br>
+=C2=A0 =C2=A0 dev =3D DEVICE(i2c_target_new(TYPE_PCA9552, 0x60));<br>
=C2=A0 =C2=A0 =C2=A0qdev_prop_set_string(dev, &quot;description&quot;, &quo=
t;pca0&quot;);<br>
-=C2=A0 =C2=A0 i2c_slave_realize_and_unref(I2C_SLAVE(dev),<br>
+=C2=A0 =C2=A0 i2c_target_realize_and_unref(I2C_SLAVE(dev),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aspeed_i2c_get_bus(&amp;soc-&g=
t;i2c, 11),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_fatal);<br>
=C2=A0 =C2=A0 =C2=A0/* Bus 11: TODO ucd90160@64 */<br>
@@ -682,19 +682,19 @@ static void g220a_bmc_i2c_init(AspeedMachineState *bm=
c)<br>
=C2=A0 =C2=A0 =C2=A0AspeedSoCState *soc =3D bmc-&gt;soc;<br>
=C2=A0 =C2=A0 =C2=A0DeviceState *dev;<br>
<br>
-=C2=A0 =C2=A0 dev =3D DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&a=
mp;soc-&gt;i2c, 3),<br>
+=C2=A0 =C2=A0 dev =3D DEVICE(i2c_target_create_simple(aspeed_i2c_get_bus(&=
amp;soc-&gt;i2c, 3),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
quot;emc1413&quot;, 0x4c));<br>
=C2=A0 =C2=A0 =C2=A0object_property_set_int(OBJECT(dev), &quot;temperature0=
&quot;, 31000, &amp;error_abort);<br>
=C2=A0 =C2=A0 =C2=A0object_property_set_int(OBJECT(dev), &quot;temperature1=
&quot;, 28000, &amp;error_abort);<br>
=C2=A0 =C2=A0 =C2=A0object_property_set_int(OBJECT(dev), &quot;temperature2=
&quot;, 20000, &amp;error_abort);<br>
<br>
-=C2=A0 =C2=A0 dev =3D DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&a=
mp;soc-&gt;i2c, 12),<br>
+=C2=A0 =C2=A0 dev =3D DEVICE(i2c_target_create_simple(aspeed_i2c_get_bus(&=
amp;soc-&gt;i2c, 12),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
quot;emc1413&quot;, 0x4c));<br>
=C2=A0 =C2=A0 =C2=A0object_property_set_int(OBJECT(dev), &quot;temperature0=
&quot;, 31000, &amp;error_abort);<br>
=C2=A0 =C2=A0 =C2=A0object_property_set_int(OBJECT(dev), &quot;temperature1=
&quot;, 28000, &amp;error_abort);<br>
=C2=A0 =C2=A0 =C2=A0object_property_set_int(OBJECT(dev), &quot;temperature2=
&quot;, 20000, &amp;error_abort);<br>
<br>
-=C2=A0 =C2=A0 dev =3D DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&a=
mp;soc-&gt;i2c, 13),<br>
+=C2=A0 =C2=A0 dev =3D DEVICE(i2c_target_create_simple(aspeed_i2c_get_bus(&=
amp;soc-&gt;i2c, 13),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
quot;emc1413&quot;, 0x4c));<br>
=C2=A0 =C2=A0 =C2=A0object_property_set_int(OBJECT(dev), &quot;temperature0=
&quot;, 31000, &amp;error_abort);<br>
=C2=A0 =C2=A0 =C2=A0object_property_set_int(OBJECT(dev), &quot;temperature1=
&quot;, 28000, &amp;error_abort);<br>
@@ -716,25 +716,25 @@ static void g220a_bmc_i2c_init(AspeedMachineState *bm=
c)<br>
=C2=A0static void fp5280g2_bmc_i2c_init(AspeedMachineState *bmc)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0AspeedSoCState *soc =3D bmc-&gt;soc;<br>
-=C2=A0 =C2=A0 I2CSlave *i2c_mux;<br>
+=C2=A0 =C2=A0 I2CTarget *i2c_mux;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* The at24c256 */<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(aspeed_i2c_get_bus(&amp;soc-&gt;i2c, =
1), 0x50, 32768);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* The fp5280g2 expects a TMP112 but a TMP105 is compat=
ible */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 2),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 2),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_TMP105, 0x48);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 2),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 2),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_TMP105, 0x49);<br>
<br>
-=C2=A0 =C2=A0 i2c_mux =3D i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;=
soc-&gt;i2c, 2),<br>
+=C2=A0 =C2=A0 i2c_mux =3D i2c_target_create_simple(aspeed_i2c_get_bus(&amp=
;soc-&gt;i2c, 2),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;pca9546&quot;, 0x70);<br>
=C2=A0 =C2=A0 =C2=A0/* It expects a TMP112 but a TMP105 is compatible */<br=
>
-=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_TMP105, 0x4a);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* It expects a ds3232 but a ds1338 is good enough */<b=
r>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 4),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 4),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;ds1338&quot;, 0x68);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* It expects a pca9555 but a pca9552 is compatible */<=
br>
@@ -744,44 +744,44 @@ static void fp5280g2_bmc_i2c_init(AspeedMachineState =
*bmc)<br>
=C2=A0static void rainier_bmc_i2c_init(AspeedMachineState *bmc)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0AspeedSoCState *soc =3D bmc-&gt;soc;<br>
-=C2=A0 =C2=A0 I2CSlave *i2c_mux;<br>
+=C2=A0 =C2=A0 I2CTarget *i2c_mux;<br>
<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(aspeed_i2c_get_bus(&amp;soc-&gt;i2c, =
0), 0x51, 32 * KiB);<br>
<br>
=C2=A0 =C2=A0 =C2=A0create_pca9552(soc, 3, 0x61);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* The rainier expects a TMP275 but a TMP105 is compati=
ble */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 4),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 4),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_TMP105, 0x48);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 4),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 4),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_TMP105, 0x49);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 4),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 4),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_TMP105, 0x4a);<br>
-=C2=A0 =C2=A0 i2c_mux =3D i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;=
soc-&gt;i2c, 4),<br>
+=C2=A0 =C2=A0 i2c_mux =3D i2c_target_create_simple(aspeed_i2c_get_bus(&amp=
;soc-&gt;i2c, 4),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;pca=
9546&quot;, 0x70);<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50=
, 64 * KiB);<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51=
, 64 * KiB);<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 2), 0x52=
, 64 * KiB);<br>
=C2=A0 =C2=A0 =C2=A0create_pca9552(soc, 4, 0x60);<br>
<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 5),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 5),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_TMP105, 0x48);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 5),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 5),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_TMP105, 0x49);<br>
=C2=A0 =C2=A0 =C2=A0create_pca9552(soc, 5, 0x60);<br>
=C2=A0 =C2=A0 =C2=A0create_pca9552(soc, 5, 0x61);<br>
-=C2=A0 =C2=A0 i2c_mux =3D i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;=
soc-&gt;i2c, 5),<br>
+=C2=A0 =C2=A0 i2c_mux =3D i2c_target_create_simple(aspeed_i2c_get_bus(&amp=
;soc-&gt;i2c, 5),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;pca=
9546&quot;, 0x70);<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50=
, 64 * KiB);<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51=
, 64 * KiB);<br>
<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 6),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 6),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_TMP105, 0x48);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 6),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 6),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_TMP105, 0x4a);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 6),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 6),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_TMP105, 0x4b);<br>
-=C2=A0 =C2=A0 i2c_mux =3D i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;=
soc-&gt;i2c, 6),<br>
+=C2=A0 =C2=A0 i2c_mux =3D i2c_target_create_simple(aspeed_i2c_get_bus(&amp=
;soc-&gt;i2c, 6),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;pca=
9546&quot;, 0x70);<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50=
, 64 * KiB);<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51=
, 64 * KiB);<br>
@@ -794,19 +794,19 @@ static void rainier_bmc_i2c_init(AspeedMachineState *=
bmc)<br>
=C2=A0 =C2=A0 =C2=A0create_pca9552(soc, 7, 0x33);<br>
=C2=A0 =C2=A0 =C2=A0create_pca9552(soc, 7, 0x60);<br>
=C2=A0 =C2=A0 =C2=A0create_pca9552(soc, 7, 0x61);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 7),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 7),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;dps310&quot;, 0x76);<br>
=C2=A0 =C2=A0 =C2=A0/* Bus 7: TODO si7021-a20@20 */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 7),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 7),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_TMP105, 0x48);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 7),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 7),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;max31785&quot;, 0x52);<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(aspeed_i2c_get_bus(&amp;soc-&gt;i2c, =
7), 0x50, 64 * KiB);<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(aspeed_i2c_get_bus(&amp;soc-&gt;i2c, =
7), 0x51, 64 * KiB);<br>
<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 8),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 8),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_TMP105, 0x48);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 8),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 8),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_TMP105, 0x4a);<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init_rom(aspeed_i2c_get_bus(&amp;soc-&gt;i=
2c, 8), 0x50,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A064 * KiB, rainier_bb_fruid, rainier_bb_fruid_len);<=
br>
@@ -818,23 +818,23 @@ static void rainier_bmc_i2c_init(AspeedMachineState *=
bmc)<br>
=C2=A0 =C2=A0 =C2=A0/* Bus 8: ucd90320@b */<br>
=C2=A0 =C2=A0 =C2=A0/* Bus 8: ucd90320@c */<br>
<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 9),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 9),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;tmp423&quot;, 0x4c);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 9),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 9),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;tmp423&quot;, 0x4d);<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(aspeed_i2c_get_bus(&amp;soc-&gt;i2c, =
9), 0x50, 128 * KiB);<br>
<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 10),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 10),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;tmp423&quot;, 0x4c);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 10),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 10),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;tmp423&quot;, 0x4d);<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(aspeed_i2c_get_bus(&amp;soc-&gt;i2c, =
10), 0x50, 128 * KiB);<br>
<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 11),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 11),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_TMP105, 0x48);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 11),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 11),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_TMP105, 0x49);<br>
-=C2=A0 =C2=A0 i2c_mux =3D i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;=
soc-&gt;i2c, 11),<br>
+=C2=A0 =C2=A0 i2c_mux =3D i2c_target_create_simple(aspeed_i2c_get_bus(&amp=
;soc-&gt;i2c, 11),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;pca=
9546&quot;, 0x70);<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50=
, 64 * KiB);<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51=
, 64 * KiB);<br>
@@ -854,7 +854,7 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bm=
c)<br>
=C2=A0static void get_pca9548_channels(I2CBus *bus, uint8_t mux_addr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I2CBus **channels)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 I2CSlave *mux =3D i2c_slave_create_simple(bus, &quot;pca9548=
&quot;, mux_addr);<br>
+=C2=A0 =C2=A0 I2CTarget *mux =3D i2c_target_create_simple(bus, &quot;pca95=
48&quot;, mux_addr);<br>
=C2=A0 =C2=A0 =C2=A0for (int i =3D 0; i &lt; 8; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0channels[i] =3D pca954x_i2c_get_bus(mux, =
i);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -888,8 +888,8 @@ static void fuji_bmc_i2c_init(AspeedMachineState *bmc)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0get_pca9548_channels(i2c[40 + i], 0x76, &=
amp;i2c[80 + i * 8]);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[17], TYPE_LM75, 0x4c);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[17], TYPE_LM75, 0x4d);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[17], TYPE_LM75, 0x4c);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[17], TYPE_LM75, 0x4d);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * EEPROM 24c64 size is 64Kbits or 8 Kbytes<br>
@@ -899,33 +899,33 @@ static void fuji_bmc_i2c_init(AspeedMachineState *bmc=
)<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(i2c[20], 0x50, 256);<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(i2c[22], 0x52, 256);<br>
<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[3], TYPE_LM75, 0x48);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[3], TYPE_LM75, 0x49);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[3], TYPE_LM75, 0x4a);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[3], TYPE_TMP422, 0x4c);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[3], TYPE_LM75, 0x48);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[3], TYPE_LM75, 0x49);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[3], TYPE_LM75, 0x4a);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[3], TYPE_TMP422, 0x4c);<br>
<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(i2c[8], 0x51, 8 * KiB);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[8], TYPE_LM75, 0x4a);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[8], TYPE_LM75, 0x4a);<br>
<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[50], TYPE_LM75, 0x4c);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[50], TYPE_LM75, 0x4c);<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(i2c[50], 0x52, 8 * KiB);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[51], TYPE_TMP75, 0x48);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[52], TYPE_TMP75, 0x49);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[51], TYPE_TMP75, 0x48);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[52], TYPE_TMP75, 0x49);<br>
<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[59], TYPE_TMP75, 0x48);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[60], TYPE_TMP75, 0x49);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[59], TYPE_TMP75, 0x48);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[60], TYPE_TMP75, 0x49);<br>
<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(i2c[65], 0x53, 8 * KiB);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[66], TYPE_TMP75, 0x49);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[66], TYPE_TMP75, 0x48);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[66], TYPE_TMP75, 0x49);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[66], TYPE_TMP75, 0x48);<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(i2c[68], 0x52, 8 * KiB);<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(i2c[69], 0x52, 8 * KiB);<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(i2c[70], 0x52, 8 * KiB);<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(i2c[71], 0x52, 8 * KiB);<br>
<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(i2c[73], 0x53, 8 * KiB);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[74], TYPE_TMP75, 0x49);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[74], TYPE_TMP75, 0x48);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[74], TYPE_TMP75, 0x49);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[74], TYPE_TMP75, 0x48);<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(i2c[76], 0x52, 8 * KiB);<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(i2c[77], 0x52, 8 * KiB);<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(i2c[78], 0x52, 8 * KiB);<br>
@@ -934,9 +934,9 @@ static void fuji_bmc_i2c_init(AspeedMachineState *bmc)<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0for (int i =3D 0; i &lt; 8; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(i2c[81 + i * 8], 0x56, =
64 * KiB);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_slave_create_simple(i2c[82 + i * 8], TYPE_=
TMP75, 0x48);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_slave_create_simple(i2c[83 + i * 8], TYPE_=
TMP75, 0x4b);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_slave_create_simple(i2c[84 + i * 8], TYPE_=
TMP75, 0x4a);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_target_create_simple(i2c[82 + i * 8], TYPE=
_TMP75, 0x48);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_target_create_simple(i2c[83 + i * 8], TYPE=
_TMP75, 0x4b);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_target_create_simple(i2c[84 + i * 8], TYPE=
_TMP75, 0x4a);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
@@ -957,35 +957,35 @@ static void bletchley_bmc_i2c_init(AspeedMachineState=
 *bmc)<br>
=C2=A0 =C2=A0 =C2=A0for (int i =3D 0; i &lt; 6; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Missing model: ti,ina230 @ 0x45 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Missing model: mps,mp5023 @ 0x40 */<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_slave_create_simple(i2c[i], TYPE_TMP421, 0=
x4f);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_target_create_simple(i2c[i], TYPE_TMP421, =
0x4f);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Missing model: nxp,pca9539 @ 0x76, but=
 PCA9552 works enough */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_slave_create_simple(i2c[i], TYPE_PCA9552, =
0x76);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_slave_create_simple(i2c[i], TYPE_PCA9552, =
0x67);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_target_create_simple(i2c[i], TYPE_PCA9552,=
 0x76);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_target_create_simple(i2c[i], TYPE_PCA9552,=
 0x67);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Missing model: fsc,fusb302 @ 0x22 */<b=
r>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Bus 6 */<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(i2c[6], 0x56, 65536);<br>
=C2=A0 =C2=A0 =C2=A0/* Missing model: nxp,pcf85263 @ 0x51 , but ds1338 work=
s enough */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[6], &quot;ds1338&quot;, 0x51);<b=
r>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[6], &quot;ds1338&quot;, 0x51);<=
br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Bus 7 */<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(i2c[7], 0x54, 65536);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Bus 9 */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[9], TYPE_TMP421, 0x4f);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[9], TYPE_TMP421, 0x4f);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Bus 10 */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[10], TYPE_TMP421, 0x4f);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[10], TYPE_TMP421, 0x4f);<br>
=C2=A0 =C2=A0 =C2=A0/* Missing model: ti,hdc1080 @ 0x40 */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[10], TYPE_PCA9552, 0x67);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[10], TYPE_PCA9552, 0x67);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Bus 12 */<br>
=C2=A0 =C2=A0 =C2=A0/* Missing model: adi,adm1278 @ 0x11 */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[12], TYPE_TMP421, 0x4c);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[12], TYPE_TMP421, 0x4d);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[12], TYPE_PCA9552, 0x67);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[12], TYPE_TMP421, 0x4c);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[12], TYPE_TMP421, 0x4d);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[12], TYPE_PCA9552, 0x67);<br>
=C2=A0}<br>
<br>
=C2=A0static void fby35_i2c_init(AspeedMachineState *bmc)<br>
@@ -997,12 +997,12 @@ static void fby35_i2c_init(AspeedMachineState *bmc)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c[i] =3D aspeed_i2c_get_bus(&amp;soc-&g=
t;i2c, i);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[2], TYPE_LM75, 0x4f);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[8], TYPE_TMP421, 0x1f);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[2], TYPE_LM75, 0x4f);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[8], TYPE_TMP421, 0x1f);<br>
=C2=A0 =C2=A0 =C2=A0/* Hotswap controller is actually supposed to be mp5920=
 or ltc4282. */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[11], &quot;adm1272&quot;, 0x44);=
<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[12], TYPE_LM75, 0x4e);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[12], TYPE_LM75, 0x4f);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[11], &quot;adm1272&quot;, 0x44)=
;<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[12], TYPE_LM75, 0x4e);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c[12], TYPE_LM75, 0x4f);<br>
<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(i2c[4], 0x51, 128 * KiB);<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(i2c[6], 0x51, 128 * KiB);<br>
@@ -1024,14 +1024,14 @@ static void qcom_dc_scm_bmc_i2c_init(AspeedMachineS=
tate *bmc)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0AspeedSoCState *soc =3D bmc-&gt;soc;<br>
<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 15),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 15),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;tmp105&quot;, 0x4d);<br>
=C2=A0}<br>
<br>
=C2=A0static void qcom_dc_scm_firework_i2c_init(AspeedMachineState *bmc)<br=
>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0AspeedSoCState *soc =3D bmc-&gt;soc;<br>
-=C2=A0 =C2=A0 I2CSlave *therm_mux, *cpuvr_mux;<br>
+=C2=A0 =C2=A0 I2CTarget *therm_mux, *cpuvr_mux;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Create the generic DC-SCM hardware */<br>
=C2=A0 =C2=A0 =C2=A0qcom_dc_scm_bmc_i2c_init(bmc);<br>
@@ -1039,35 +1039,35 @@ static void qcom_dc_scm_firework_i2c_init(AspeedMac=
hineState *bmc)<br>
=C2=A0 =C2=A0 =C2=A0/* Now create the Firework specific hardware */<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* I2C7 CPUVR MUX */<br>
-=C2=A0 =C2=A0 cpuvr_mux =3D i2c_slave_create_simple(aspeed_i2c_get_bus(&am=
p;soc-&gt;i2c, 7),<br>
+=C2=A0 =C2=A0 cpuvr_mux =3D i2c_target_create_simple(aspeed_i2c_get_bus(&a=
mp;soc-&gt;i2c, 7),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&q=
uot;pca9546&quot;, 0x70);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 0),<b=
r>
+=C2=A0 =C2=A0 i2c_target_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 0),<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;pca9548&quot;, 0x72);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 1),<b=
r>
+=C2=A0 =C2=A0 i2c_target_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 1),<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;pca9548&quot;, 0x72);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 2),<b=
r>
+=C2=A0 =C2=A0 i2c_target_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 2),<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;pca9548&quot;, 0x72);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 3),<b=
r>
+=C2=A0 =C2=A0 i2c_target_create_simple(pca954x_i2c_get_bus(cpuvr_mux, 3),<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;pca9548&quot;, 0x72);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* I2C8 Thermal Diodes*/<br>
-=C2=A0 =C2=A0 therm_mux =3D i2c_slave_create_simple(aspeed_i2c_get_bus(&am=
p;soc-&gt;i2c, 8),<br>
+=C2=A0 =C2=A0 therm_mux =3D i2c_target_create_simple(aspeed_i2c_get_bus(&a=
mp;soc-&gt;i2c, 8),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&q=
uot;pca9548&quot;, 0x70);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 0),<b=
r>
+=C2=A0 =C2=A0 i2c_target_create_simple(pca954x_i2c_get_bus(therm_mux, 0),<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_LM75, 0x4C);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 1),<b=
r>
+=C2=A0 =C2=A0 i2c_target_create_simple(pca954x_i2c_get_bus(therm_mux, 1),<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_LM75, 0x4C);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 2),<b=
r>
+=C2=A0 =C2=A0 i2c_target_create_simple(pca954x_i2c_get_bus(therm_mux, 2),<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_LM75, 0x48);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 3),<b=
r>
+=C2=A0 =C2=A0 i2c_target_create_simple(pca954x_i2c_get_bus(therm_mux, 3),<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_LM75, 0x48);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(therm_mux, 4),<b=
r>
+=C2=A0 =C2=A0 i2c_target_create_simple(pca954x_i2c_get_bus(therm_mux, 4),<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_LM75, 0x48);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* I2C9 Fan Controller (MAX31785) */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 9),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 9),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;max31785&quot;, 0x52);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 9),<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 9),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;max31785&quot;, 0x54);<br>
=C2=A0}<br>
<br>
@@ -1589,7 +1589,7 @@ static void ast1030_evb_i2c_init(AspeedMachineState *=
bmc)<br>
=C2=A0 =C2=A0 =C2=A0smbus_eeprom_init_one(aspeed_i2c_get_bus(&amp;soc-&gt;i=
2c, 0), 0x50, eeprom_buf);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* U11 LM75 connects to SDA/SCL Group 2 by default */<b=
r>
-=C2=A0 =C2=A0 i2c_slave_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c,=
 1), &quot;tmp105&quot;, 0x4d);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, 1), &quot;tmp105&quot;, 0x4d);<br>
=C2=A0}<br>
<br>
=C2=A0static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass=
 *oc,<br>
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c<br>
index 0a4b6f29b1..e53ba57d3f 100644<br>
--- a/hw/arm/bananapi_m2u.c<br>
+++ b/hw/arm/bananapi_m2u.c<br>
@@ -113,7 +113,7 @@ static void bpim2u_init(MachineState *machine)<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Connect AXP221 */<br>
=C2=A0 =C2=A0 =C2=A0i2c =3D I2C_BUS(qdev_get_child_bus(DEVICE(&amp;r40-&gt;=
i2c0), &quot;i2c&quot;));<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c, &quot;axp221_pmu&quot;, 0x34);<=
br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c, &quot;axp221_pmu&quot;, 0x34);=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* SDRAM */<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(get_system_memory(),<br>
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c<br>
index b976727eef..82a2e2642b 100644<br>
--- a/hw/arm/cubieboard.c<br>
+++ b/hw/arm/cubieboard.c<br>
@@ -80,7 +80,7 @@ static void cubieboard_init(MachineState *machine)<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Connect AXP 209 */<br>
=C2=A0 =C2=A0 =C2=A0i2c =3D I2C_BUS(qdev_get_child_bus(DEVICE(&amp;a10-&gt;=
i2c0), &quot;i2c&quot;));<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c, &quot;axp209_pmu&quot;, 0x34);<=
br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c, &quot;axp209_pmu&quot;, 0x34);=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Retrieve SD bus */<br>
=C2=A0 =C2=A0 =C2=A0di =3D drive_get(IF_SD, 0, 0);<br>
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c<br>
index 2020f73a57..54e2385d96 100644<br>
--- a/hw/arm/musicpal.c<br>
+++ b/hw/arm/musicpal.c<br>
@@ -1203,7 +1203,7 @@ static void musicpal_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0DeviceState *i2c_dev;<br>
=C2=A0 =C2=A0 =C2=A0DeviceState *lcd_dev;<br>
=C2=A0 =C2=A0 =C2=A0DeviceState *key_dev;<br>
-=C2=A0 =C2=A0 I2CSlave *wm8750_dev;<br>
+=C2=A0 =C2=A0 I2CTarget *wm8750_dev;<br>
=C2=A0 =C2=A0 =C2=A0SysBusDevice *s;<br>
=C2=A0 =C2=A0 =C2=A0I2CBus *i2c;<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
@@ -1316,11 +1316,11 @@ static void musicpal_init(MachineState *machine)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_connect_gpio_out(key_dev, i, qdev_ge=
t_gpio_in(dev, i + 15));<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 wm8750_dev =3D i2c_slave_new(TYPE_WM8750, MP_WM_ADDR);<br>
+=C2=A0 =C2=A0 wm8750_dev =3D i2c_target_new(TYPE_WM8750, MP_WM_ADDR);<br>
=C2=A0 =C2=A0 =C2=A0if (machine-&gt;audiodev) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_prop_set_string(DEVICE(wm8750_dev), =
&quot;audiodev&quot;, machine-&gt;audiodev);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 i2c_slave_realize_and_unref(wm8750_dev, i2c, &amp;error_abor=
t);<br>
+=C2=A0 =C2=A0 i2c_target_realize_and_unref(wm8750_dev, i2c, &amp;error_abo=
rt);<br>
<br>
=C2=A0 =C2=A0 =C2=A0dev =3D qdev_new(TYPE_MV88W8618_AUDIO);<br>
=C2=A0 =C2=A0 =C2=A0s =3D SYS_BUS_DEVICE(dev);<br>
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c<br>
index e229efb447..27fd8afa66 100644<br>
--- a/hw/arm/npcm7xx_boards.c<br>
+++ b/hw/arm/npcm7xx_boards.c<br>
@@ -197,13 +197,13 @@ static void npcm7xx_connect_pwm_fan(NPCM7xxState *soc=
, SplitIRQ *splitter,<br>
=C2=A0static void npcm750_evb_i2c_init(NPCM7xxState *soc)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0/* lm75 temperature sensor on SVB, tmp105 is compatible=
 */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 0), &quot;t=
mp105&quot;, 0x48);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 0), &quot;=
tmp105&quot;, 0x48);<br>
=C2=A0 =C2=A0 =C2=A0/* lm75 temperature sensor on EB, tmp105 is compatible =
*/<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 1), &quot;t=
mp105&quot;, 0x48);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 1), &quot;=
tmp105&quot;, 0x48);<br>
=C2=A0 =C2=A0 =C2=A0/* tmp100 temperature sensor on EB, tmp105 is compatibl=
e */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 2), &quot;t=
mp105&quot;, 0x48);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 2), &quot;=
tmp105&quot;, 0x48);<br>
=C2=A0 =C2=A0 =C2=A0/* tmp100 temperature sensor on SVB, tmp105 is compatib=
le */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 6), &quot;t=
mp105&quot;, 0x48);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 6), &quot;=
tmp105&quot;, 0x48);<br>
=C2=A0}<br>
<br>
=C2=A0static void npcm750_evb_fan_init(NPCM7xxMachine *machine, NPCM7xxStat=
e *soc)<br>
@@ -233,10 +233,10 @@ static void npcm750_evb_fan_init(NPCM7xxMachine *mach=
ine, NPCM7xxState *soc)<br>
=C2=A0static void quanta_gsj_i2c_init(NPCM7xxState *soc)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0/* GSJ machine have 4 max31725 temperature sensors, tmp=
105 is compatible. */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 1), &quot;t=
mp105&quot;, 0x5c);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 2), &quot;t=
mp105&quot;, 0x5c);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 3), &quot;t=
mp105&quot;, 0x5c);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 4), &quot;t=
mp105&quot;, 0x5c);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 1), &quot;=
tmp105&quot;, 0x5c);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 2), &quot;=
tmp105&quot;, 0x5c);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 3), &quot;=
tmp105&quot;, 0x5c);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 4), &quot;=
tmp105&quot;, 0x5c);<br>
<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 9), 0x55, 81=
92);<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 10), 0x55, 8=
192);<br>
@@ -252,7 +252,7 @@ static void quanta_gsj_i2c_init(NPCM7xxState *soc)<br>
=C2=A0 =C2=A0 =C2=A0 * - ucd90160@6b<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 15), &quot;=
pca9548&quot;, 0x75);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 15), &quot=
;pca9548&quot;, 0x75);<br>
=C2=A0}<br>
<br>
=C2=A0static void quanta_gsj_fan_init(NPCM7xxMachine *machine, NPCM7xxState=
 *soc)<br>
@@ -330,31 +330,31 @@ static void quanta_gbs_i2c_init(NPCM7xxState *soc)<br=
>
<br>
=C2=A0static void kudo_bmc_i2c_init(NPCM7xxState *soc)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 I2CSlave *i2c_mux;<br>
+=C2=A0 =C2=A0 I2CTarget *i2c_mux;<br>
<br>
-=C2=A0 =C2=A0 i2c_mux =3D i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc,=
 1),<br>
+=C2=A0 =C2=A0 i2c_mux =3D i2c_target_create_simple(npcm7xx_i2c_get_bus(soc=
, 1),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_PCA9=
548, 0x75);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* tmp105 is compatible with the lm75 */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 4), &qu=
ot;tmp105&quot;, 0x5c);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5), &qu=
ot;tmp105&quot;, 0x5c);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 6), &qu=
ot;tmp105&quot;, 0x5c);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 7), &qu=
ot;tmp105&quot;, 0x5c);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 4), &q=
uot;tmp105&quot;, 0x5c);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 5), &q=
uot;tmp105&quot;, 0x5c);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 6), &q=
uot;tmp105&quot;, 0x5c);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 7), &q=
uot;tmp105&quot;, 0x5c);<br>
<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 1), TYPE_PC=
A9548, 0x77);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 1), TYPE_P=
CA9548, 0x77);<br>
<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc, 4), TYPE_PC=
A9548, 0x77);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(npcm7xx_i2c_get_bus(soc, 4), TYPE_P=
CA9548, 0x77);<br>
<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 4), 0x50, 81=
92); /* mbfru */<br>
<br>
-=C2=A0 =C2=A0 i2c_mux =3D i2c_slave_create_simple(npcm7xx_i2c_get_bus(soc,=
 13),<br>
+=C2=A0 =C2=A0 i2c_mux =3D i2c_target_create_simple(npcm7xx_i2c_get_bus(soc=
, 13),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_PCA9=
548, 0x77);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* tmp105 is compatible with the lm75 */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 2), &qu=
ot;tmp105&quot;, 0x48);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 3), &qu=
ot;tmp105&quot;, 0x49);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 4), &qu=
ot;tmp105&quot;, 0x48);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 5), &qu=
ot;tmp105&quot;, 0x49);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 2), &q=
uot;tmp105&quot;, 0x48);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 3), &q=
uot;tmp105&quot;, 0x49);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 4), &q=
uot;tmp105&quot;, 0x48);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(pca954x_i2c_get_bus(i2c_mux, 5), &q=
uot;tmp105&quot;, 0x49);<br>
<br>
=C2=A0 =C2=A0 =C2=A0at24c_eeprom_init(npcm7xx_i2c_get_bus(soc, 14), 0x55, 8=
192); /* bmcfru */<br>
<br>
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c<br>
index 35364312c7..0f10bb5ade 100644<br>
--- a/hw/arm/nseries.c<br>
+++ b/hw/arm/nseries.c<br>
@@ -218,7 +218,7 @@ static void n8x0_i2c_setup(struct n800_s *s)<br>
=C2=A0 =C2=A0 =C2=A0I2CBus *i2c =3D omap_i2c_bus(s-&gt;mpu-&gt;i2c[0]);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Attach a menelaus PM chip */<br>
-=C2=A0 =C2=A0 dev =3D DEVICE(i2c_slave_create_simple(i2c, &quot;twl92230&q=
uot;, N8X0_MENELAUS_ADDR));<br>
+=C2=A0 =C2=A0 dev =3D DEVICE(i2c_target_create_simple(i2c, &quot;twl92230&=
quot;, N8X0_MENELAUS_ADDR));<br>
=C2=A0 =C2=A0 =C2=A0qdev_connect_gpio_out(dev, 3,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(s-&gt;mpu-&gt;ih[0],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 OMAP_INT_24XX_SYS_NIRQ));<br>
@@ -227,7 +227,7 @@ static void n8x0_i2c_setup(struct n800_s *s)<br>
=C2=A0 =C2=A0 =C2=A0qemu_register_powerdown_notifier(&amp;n8x0_system_power=
down_notifier);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Attach a TMP105 PM chip (A0 wired to ground) */<br>
-=C2=A0 =C2=A0 dev =3D DEVICE(i2c_slave_create_simple(i2c, TYPE_TMP105, N8X=
0_TMP105_ADDR));<br>
+=C2=A0 =C2=A0 dev =3D DEVICE(i2c_target_create_simple(i2c, TYPE_TMP105, N8=
X0_TMP105_ADDR));<br>
=C2=A0 =C2=A0 =C2=A0qdev_connect_gpio_out(dev, 0, tmp_irq);<br>
=C2=A0}<br>
<br>
@@ -419,7 +419,7 @@ static void n810_kbd_setup(struct n800_s *s)<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Attach the LM8322 keyboard to the I2C bus,<br>
=C2=A0 =C2=A0 =C2=A0 * should happen in n8x0_i2c_setup and s-&gt;kbd be ini=
tialised here.=C2=A0 */<br>
-=C2=A0 =C2=A0 s-&gt;kbd =3D DEVICE(i2c_slave_create_simple(omap_i2c_bus(s-=
&gt;mpu-&gt;i2c[0]),<br>
+=C2=A0 =C2=A0 s-&gt;kbd =3D DEVICE(i2c_target_create_simple(omap_i2c_bus(s=
-&gt;mpu-&gt;i2c[0]),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0TYPE_LM8323, N810_LM8323_ADDR));<br>
=C2=A0 =C2=A0 =C2=A0qdev_connect_gpio_out(s-&gt;kbd, 0, kbd_irq);<br>
=C2=A0}<br>
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c<br>
index 6b2e54473b..3b658680ac 100644<br>
--- a/hw/arm/pxa2xx.c<br>
+++ b/hw/arm/pxa2xx.c<br>
@@ -1243,10 +1243,10 @@ static const TypeInfo pxa2xx_rtc_sysbus_info =3D {<=
br>
=C2=A0/* I2C Interface */<br>
<br>
=C2=A0#define TYPE_PXA2XX_I2C_SLAVE &quot;pxa2xx-i2c-slave&quot;<br>
-OBJECT_DECLARE_SIMPLE_TYPE(PXA2xxI2CSlaveState, PXA2XX_I2C_SLAVE)<br>
+OBJECT_DECLARE_SIMPLE_TYPE(PXA2xxI2CTargetState, PXA2XX_I2C_SLAVE)<br>
<br>
-struct PXA2xxI2CSlaveState {<br>
-=C2=A0 =C2=A0 I2CSlave parent_obj;<br>
+struct PXA2xxI2CTargetState {<br>
+=C2=A0 =C2=A0 I2CTarget parent_obj;<br>
<br>
=C2=A0 =C2=A0 =C2=A0PXA2xxI2CState *host;<br>
=C2=A0};<br>
@@ -1257,7 +1257,7 @@ struct PXA2xxI2CState {<br>
=C2=A0 =C2=A0 =C2=A0/*&lt; public &gt;*/<br>
<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion iomem;<br>
-=C2=A0 =C2=A0 PXA2xxI2CSlaveState *slave;<br>
+=C2=A0 =C2=A0 PXA2xxI2CTargetState *slave;<br>
=C2=A0 =C2=A0 =C2=A0I2CBus *bus;<br>
=C2=A0 =C2=A0 =C2=A0qemu_irq irq;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t offset;<br>
@@ -1286,9 +1286,9 @@ static void pxa2xx_i2c_update(PXA2xxI2CState *s)<br>
=C2=A0}<br>
<br>
=C2=A0/* These are only stubs now.=C2=A0 */<br>
-static int pxa2xx_i2c_event(I2CSlave *i2c, enum i2c_event event)<br>
+static int pxa2xx_i2c_event(I2CTarget *i2c, enum i2c_event event)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 PXA2xxI2CSlaveState *slave =3D PXA2XX_I2C_SLAVE(i2c);<br>
+=C2=A0 =C2=A0 PXA2xxI2CTargetState *slave =3D PXA2XX_I2C_SLAVE(i2c);<br>
=C2=A0 =C2=A0 =C2=A0PXA2xxI2CState *s =3D slave-&gt;host;<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (event) {<br>
@@ -1314,9 +1314,9 @@ static int pxa2xx_i2c_event(I2CSlave *i2c, enum i2c_e=
vent event)<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-static uint8_t pxa2xx_i2c_rx(I2CSlave *i2c)<br>
+static uint8_t pxa2xx_i2c_rx(I2CTarget *i2c)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 PXA2xxI2CSlaveState *slave =3D PXA2XX_I2C_SLAVE(i2c);<br>
+=C2=A0 =C2=A0 PXA2xxI2CTargetState *slave =3D PXA2XX_I2C_SLAVE(i2c);<br>
=C2=A0 =C2=A0 =C2=A0PXA2xxI2CState *s =3D slave-&gt;host;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if ((s-&gt;control &amp; (1 &lt;&lt; 14)) || !(s-&gt;co=
ntrol &amp; (1 &lt;&lt; 6))) {<br>
@@ -1331,9 +1331,9 @@ static uint8_t pxa2xx_i2c_rx(I2CSlave *i2c)<br>
=C2=A0 =C2=A0 =C2=A0return s-&gt;data;<br>
=C2=A0}<br>
<br>
-static int pxa2xx_i2c_tx(I2CSlave *i2c, uint8_t data)<br>
+static int pxa2xx_i2c_tx(I2CTarget *i2c, uint8_t data)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 PXA2xxI2CSlaveState *slave =3D PXA2XX_I2C_SLAVE(i2c);<br>
+=C2=A0 =C2=A0 PXA2xxI2CTargetState *slave =3D PXA2XX_I2C_SLAVE(i2c);<br>
=C2=A0 =C2=A0 =C2=A0PXA2xxI2CState *s =3D slave-&gt;host;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if ((s-&gt;control &amp; (1 &lt;&lt; 14)) || !(s-&gt;co=
ntrol &amp; (1 &lt;&lt; 6))) {<br>
@@ -1353,7 +1353,7 @@ static uint64_t pxa2xx_i2c_read(void *opaque, hwaddr =
addr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned size)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0PXA2xxI2CState *s =3D (PXA2xxI2CState *) opaque;<br>
-=C2=A0 =C2=A0 I2CSlave *slave;<br>
+=C2=A0 =C2=A0 I2CTarget *slave;<br>
<br>
=C2=A0 =C2=A0 =C2=A0addr -=3D s-&gt;offset;<br>
=C2=A0 =C2=A0 =C2=A0switch (addr) {<br>
@@ -1440,7 +1440,7 @@ static void pxa2xx_i2c_write(void *opaque, hwaddr add=
r,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case ISAR:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_slave_set_address(I2C_SLAVE(s-&gt;slave), =
value &amp; 0x7f);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_target_set_address(I2C_SLAVE(s-&gt;slave),=
 value &amp; 0x7f);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case IDBR:<br>
@@ -1465,7 +1465,7 @@ static const VMStateDescription vmstate_pxa2xx_i2c_sl=
ave =3D {<br>
=C2=A0 =C2=A0 =C2=A0.version_id =3D 1,<br>
=C2=A0 =C2=A0 =C2=A0.minimum_version_id =3D 1,<br>
=C2=A0 =C2=A0 =C2=A0.fields =3D (const VMStateField[]) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_I2C_SLAVE(parent_obj, PXA2xxI2CSlaveSt=
ate),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_I2C_TARGET(parent_obj, PXA2xxI2CTarget=
State),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_END_OF_LIST()<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0};<br>
@@ -1480,14 +1480,14 @@ static const VMStateDescription vmstate_pxa2xx_i2c =
=3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT8(ibmr, PXA2xxI2CState),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT8(data, PXA2xxI2CState),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_STRUCT_POINTER(slave, PXA2xxI2CSt=
ate,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vmstate_pxa2xx_i2c_slave, PXA2xxI2CSl=
aveState),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vmstate_pxa2xx_i2c_slave, PXA2xxI2CTa=
rgetState),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_END_OF_LIST()<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0};<br>
<br>
=C2=A0static void pxa2xx_i2c_slave_class_init(ObjectClass *klass, void *dat=
a)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);<br>
+=C2=A0 =C2=A0 I2CTargetClass *k =3D I2C_TARGET_CLASS(klass);<br>
<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;event =3D pxa2xx_i2c_event;<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;recv =3D pxa2xx_i2c_rx;<br>
@@ -1496,8 +1496,8 @@ static void pxa2xx_i2c_slave_class_init(ObjectClass *=
klass, void *data)<br>
<br>
=C2=A0static const TypeInfo pxa2xx_i2c_slave_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_PXA2XX=
_I2C_SLAVE,<br>
-=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_I2C_SLAVE,<br>
-=C2=A0 =C2=A0 .instance_size =3D sizeof(PXA2xxI2CSlaveState),<br>
+=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_I2C_TARGET,<br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(PXA2xxI2CTargetState),<br>
=C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =3D pxa2xx_i2c_slave_class_ini=
t,<br>
=C2=A0};<br>
<br>
@@ -1522,7 +1522,7 @@ PXA2xxI2CState *pxa2xx_i2c_init(hwaddr base,<br>
=C2=A0 =C2=A0 =C2=A0sysbus_connect_irq(i2c_dev, 0, irq);<br>
<br>
=C2=A0 =C2=A0 =C2=A0s =3D PXA2XX_I2C(i2c_dev);<br>
-=C2=A0 =C2=A0 s-&gt;slave =3D PXA2XX_I2C_SLAVE(i2c_slave_create_simple(i2c=
bus,<br>
+=C2=A0 =C2=A0 s-&gt;slave =3D PXA2XX_I2C_SLAVE(i2c_target_create_simple(i2=
cbus,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_PXA2XX_I2C_SLAV=
E,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00));<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;slave-&gt;host =3D s;<br>
diff --git a/hw/arm/realview.c b/hw/arm/realview.c<br>
index b186f965c6..dc18ce8d23 100644<br>
--- a/hw/arm/realview.c<br>
+++ b/hw/arm/realview.c<br>
@@ -314,7 +314,7 @@ static void realview_init(MachineState *machine,<br>
<br>
=C2=A0 =C2=A0 =C2=A0dev =3D sysbus_create_simple(TYPE_ARM_SBCON_I2C, 0x1000=
2000, NULL);<br>
=C2=A0 =C2=A0 =C2=A0i2c =3D (I2CBus *)qdev_get_child_bus(dev, &quot;i2c&quo=
t;);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c, &quot;ds1338&quot;, 0x68);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c, &quot;ds1338&quot;, 0x68);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Memory map for RealView Emulation Baseboard:=C2=A0 *=
/<br>
=C2=A0 =C2=A0 =C2=A0/* 0x10000000 System registers.=C2=A0 */<br>
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c<br>
index 62cd55ba91..1fe466bab9 100644<br>
--- a/hw/arm/spitz.c<br>
+++ b/hw/arm/spitz.c<br>
@@ -767,11 +767,11 @@ static void spitz_microdrive_attach(PXA2xxState *cpu,=
 int slot)<br>
<br>
=C2=A0static void spitz_wm8750_addr(void *opaque, int line, int level)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 I2CSlave *wm =3D (I2CSlave *) opaque;<br>
+=C2=A0 =C2=A0 I2CTarget *wm =3D (I2CTarget *) opaque;<br>
=C2=A0 =C2=A0 =C2=A0if (level)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_slave_set_address(wm, SPITZ_WM_ADDRH);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_target_set_address(wm, SPITZ_WM_ADDRH);<br=
>
=C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_slave_set_address(wm, SPITZ_WM_ADDRL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_target_set_address(wm, SPITZ_WM_ADDRL);<br=
>
=C2=A0}<br>
<br>
=C2=A0static void spitz_i2c_setup(MachineState *machine, PXA2xxState *cpu)<=
br>
@@ -780,13 +780,13 @@ static void spitz_i2c_setup(MachineState *machine, PX=
A2xxState *cpu)<br>
=C2=A0 =C2=A0 =C2=A0I2CBus *bus =3D pxa2xx_i2c_bus(cpu-&gt;i2c[0]);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Attach a WM8750 to the bus */<br>
-=C2=A0 =C2=A0 I2CSlave *i2c_dev =3D i2c_slave_new(TYPE_WM8750, 0);<br>
+=C2=A0 =C2=A0 I2CTarget *i2c_dev =3D i2c_target_new(TYPE_WM8750, 0);<br>
=C2=A0 =C2=A0 =C2=A0DeviceState *wm =3D DEVICE(i2c_dev);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (machine-&gt;audiodev) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_prop_set_string(wm, &quot;audiodev&q=
uot;, machine-&gt;audiodev);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 i2c_slave_realize_and_unref(i2c_dev, bus, &amp;error_abort);=
<br>
+=C2=A0 =C2=A0 i2c_target_realize_and_unref(i2c_dev, bus, &amp;error_abort)=
;<br>
<br>
=C2=A0 =C2=A0 =C2=A0spitz_wm8750_addr(wm, 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0qdev_connect_gpio_out(cpu-&gt;gpio, SPITZ_GPIO_WM,<br>
@@ -801,7 +801,7 @@ static void spitz_i2c_setup(MachineState *machine, PXA2=
xxState *cpu)<br>
=C2=A0static void spitz_akita_i2c_setup(PXA2xxState *cpu)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0/* Attach a Max7310 to Akita I2C bus.=C2=A0 */<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(pxa2xx_i2c_bus(cpu-&gt;i2c[0]), &quo=
t;max7310&quot;,<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(pxa2xx_i2c_bus(cpu-&gt;i2c[0]), &qu=
ot;max7310&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 AKITA_MAX_ADDR);<br>
=C2=A0}<br>
<br>
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c<br>
index a2f998bf9e..7246bcc560 100644<br>
--- a/hw/arm/stellaris.c<br>
+++ b/hw/arm/stellaris.c<br>
@@ -1176,7 +1176,7 @@ static void stellaris_init(MachineState *ms, stellari=
s_board_info *board)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(nvic,=
 8));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c =3D (I2CBus *)qdev_get_child_bus(dev,=
 &quot;i2c&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (board-&gt;peripherals &amp; BP_OLED_I=
2C) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_slave_create_simple(i2c, &qu=
ot;ssd0303&quot;, 0x3d);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_target_create_simple(i2c, &q=
uot;ssd0303&quot;, 0x3d);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c<br>
index 5891f6064f..8529a57ef7 100644<br>
--- a/hw/arm/tosa.c<br>
+++ b/hw/arm/tosa.c<br>
@@ -163,13 +163,13 @@ static void tosa_ssp_realize(SSIPeripheral *dev, Erro=
r **errp)<br>
=C2=A0OBJECT_DECLARE_SIMPLE_TYPE(TosaDACState, TOSA_DAC)<br>
<br>
=C2=A0struct TosaDACState {<br>
-=C2=A0 =C2=A0 I2CSlave parent_obj;<br>
+=C2=A0 =C2=A0 I2CTarget parent_obj;<br>
<br>
=C2=A0 =C2=A0 =C2=A0int len;<br>
=C2=A0 =C2=A0 =C2=A0char buf[3];<br>
=C2=A0};<br>
<br>
-static int tosa_dac_send(I2CSlave *i2c, uint8_t data)<br>
+static int tosa_dac_send(I2CTarget *i2c, uint8_t data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0TosaDACState *s =3D TOSA_DAC(i2c);<br>
<br>
@@ -189,7 +189,7 @@ static int tosa_dac_send(I2CSlave *i2c, uint8_t data)<b=
r>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-static int tosa_dac_event(I2CSlave *i2c, enum i2c_event event)<br>
+static int tosa_dac_event(I2CTarget *i2c, enum i2c_event event)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0TosaDACState *s =3D TOSA_DAC(i2c);<br>
<br>
@@ -215,7 +215,7 @@ static int tosa_dac_event(I2CSlave *i2c, enum i2c_event=
 event)<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-static uint8_t tosa_dac_recv(I2CSlave *s)<br>
+static uint8_t tosa_dac_recv(I2CTarget *s)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0printf(&quot;%s: recv not supported!!!\n&quot;, __func_=
_);<br>
=C2=A0 =C2=A0 =C2=A0return 0xff;<br>
@@ -224,7 +224,7 @@ static uint8_t tosa_dac_recv(I2CSlave *s)<br>
=C2=A0static void tosa_tg_init(PXA2xxState *cpu)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0I2CBus *bus =3D pxa2xx_i2c_bus(cpu-&gt;i2c[0]);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(bus, TYPE_TOSA_DAC, DAC_BASE);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(bus, TYPE_TOSA_DAC, DAC_BASE);<br>
=C2=A0 =C2=A0 =C2=A0ssi_create_peripheral(cpu-&gt;ssp[1], &quot;tosa-ssp&qu=
ot;);<br>
=C2=A0}<br>
<br>
@@ -277,7 +277,7 @@ DEFINE_MACHINE(&quot;tosa&quot;, tosapda_machine_init)<=
br>
<br>
=C2=A0static void tosa_dac_class_init(ObjectClass *klass, void *data)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);<br>
+=C2=A0 =C2=A0 I2CTargetClass *k =3D I2C_TARGET_CLASS(klass);<br>
<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;event =3D tosa_dac_event;<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;recv =3D tosa_dac_recv;<br>
@@ -286,7 +286,7 @@ static void tosa_dac_class_init(ObjectClass *klass, voi=
d *data)<br>
<br>
=C2=A0static const TypeInfo tosa_dac_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_TOSA_D=
AC,<br>
-=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_I2C_SLAVE,<br>
+=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_I2C_TARGET,<br>
=C2=A0 =C2=A0 =C2=A0.instance_size =3D sizeof(TosaDACState),<br>
=C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =3D tosa_dac_class_init,<br>
=C2=A0};<br>
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c<br>
index d48235453e..73d8047ca8 100644<br>
--- a/hw/arm/versatilepb.c<br>
+++ b/hw/arm/versatilepb.c<br>
@@ -338,7 +338,7 @@ static void versatile_init(MachineState *machine, int b=
oard_id)<br>
<br>
=C2=A0 =C2=A0 =C2=A0dev =3D sysbus_create_simple(TYPE_ARM_SBCON_I2C, 0x1000=
2000, NULL);<br>
=C2=A0 =C2=A0 =C2=A0i2c =3D (I2CBus *)qdev_get_child_bus(dev, &quot;i2c&quo=
t;);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c, &quot;ds1338&quot;, 0x68);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c, &quot;ds1338&quot;, 0x68);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Add PL041 AACI Interface to the LM4549 codec */<br>
=C2=A0 =C2=A0 =C2=A0pl041 =3D qdev_new(&quot;pl041&quot;);<br>
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c<br>
index de815d84cc..355905e0b7 100644<br>
--- a/hw/arm/vexpress.c<br>
+++ b/hw/arm/vexpress.c<br>
@@ -650,7 +650,7 @@ static void vexpress_common_init(MachineState *machine)=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0dev =3D sysbus_create_simple(TYPE_ARM_SBCON_I2C, map[VE=
_SERIALDVI], NULL);<br>
=C2=A0 =C2=A0 =C2=A0i2c =3D (I2CBus *)qdev_get_child_bus(dev, &quot;i2c&quo=
t;);<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(i2c, &quot;sii9022&quot;, 0x39);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(i2c, &quot;sii9022&quot;, 0x39);<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0sysbus_create_simple(&quot;pl031&quot;, map[VE_RTC], pi=
c[4]); /* RTC */<br>
<br>
diff --git a/hw/arm/z2.c b/hw/arm/z2.c<br>
index fc5672e7ab..24bc303f06 100644<br>
--- a/hw/arm/z2.c<br>
+++ b/hw/arm/z2.c<br>
@@ -192,13 +192,13 @@ static const TypeInfo zipit_lcd_info =3D {<br>
=C2=A0OBJECT_DECLARE_SIMPLE_TYPE(AER915State, AER915)<br>
<br>
=C2=A0struct AER915State {<br>
-=C2=A0 =C2=A0 I2CSlave parent_obj;<br>
+=C2=A0 =C2=A0 I2CTarget parent_obj;<br>
<br>
=C2=A0 =C2=A0 =C2=A0int len;<br>
=C2=A0 =C2=A0 =C2=A0uint8_t buf[3];<br>
=C2=A0};<br>
<br>
-static int aer915_send(I2CSlave *i2c, uint8_t data)<br>
+static int aer915_send(I2CTarget *i2c, uint8_t data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0AER915State *s =3D AER915(i2c);<br>
<br>
@@ -215,7 +215,7 @@ static int aer915_send(I2CSlave *i2c, uint8_t data)<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-static int aer915_event(I2CSlave *i2c, enum i2c_event event)<br>
+static int aer915_event(I2CTarget *i2c, enum i2c_event event)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0AER915State *s =3D AER915(i2c);<br>
<br>
@@ -235,7 +235,7 @@ static int aer915_event(I2CSlave *i2c, enum i2c_event e=
vent)<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-static uint8_t aer915_recv(I2CSlave *slave)<br>
+static uint8_t aer915_recv(I2CTarget *slave)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0AER915State *s =3D AER915(slave);<br>
=C2=A0 =C2=A0 =C2=A0int retval =3D 0x00;<br>
@@ -272,7 +272,7 @@ static const VMStateDescription vmstate_aer915_state =
=3D {<br>
=C2=A0static void aer915_class_init(ObjectClass *klass, void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
-=C2=A0 =C2=A0 I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);<br>
+=C2=A0 =C2=A0 I2CTargetClass *k =3D I2C_TARGET_CLASS(klass);<br>
<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;event =3D aer915_event;<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;recv =3D aer915_recv;<br>
@@ -282,7 +282,7 @@ static void aer915_class_init(ObjectClass *klass, void =
*data)<br>
<br>
=C2=A0static const TypeInfo aer915_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AER915=
,<br>
-=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_I2C_SLAVE,<br>
+=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_I2C_TARGET,<br>
=C2=A0 =C2=A0 =C2=A0.instance_size =3D sizeof(AER915State),<br>
=C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =3D aer915_class_init,<br>
=C2=A0};<br>
@@ -296,7 +296,7 @@ static void z2_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0void *z2_lcd;<br>
=C2=A0 =C2=A0 =C2=A0I2CBus *bus;<br>
=C2=A0 =C2=A0 =C2=A0DeviceState *wm;<br>
-=C2=A0 =C2=A0 I2CSlave *i2c_dev;<br>
+=C2=A0 =C2=A0 I2CTarget *i2c_dev;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Setup CPU &amp; memory */<br>
=C2=A0 =C2=A0 =C2=A0mpu =3D pxa270_init(z2_binfo.ram_size, machine-&gt;cpu_=
type);<br>
@@ -319,15 +319,15 @@ static void z2_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0z2_lcd =3D ssi_create_peripheral(mpu-&gt;ssp[1], TYPE_Z=
IPIT_LCD);<br>
=C2=A0 =C2=A0 =C2=A0bus =3D pxa2xx_i2c_bus(mpu-&gt;i2c[0]);<br>
<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(bus, TYPE_AER915, 0x55);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(bus, TYPE_AER915, 0x55);<br>
<br>
-=C2=A0 =C2=A0 i2c_dev =3D i2c_slave_new(TYPE_WM8750, 0x1b);<br>
+=C2=A0 =C2=A0 i2c_dev =3D i2c_target_new(TYPE_WM8750, 0x1b);<br>
=C2=A0 =C2=A0 =C2=A0wm =3D DEVICE(i2c_dev);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (machine-&gt;audiodev) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_prop_set_string(wm, &quot;audiodev&q=
uot;, machine-&gt;audiodev);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 i2c_slave_realize_and_unref(i2c_dev, bus, &amp;error_abort);=
<br>
+=C2=A0 =C2=A0 i2c_target_realize_and_unref(i2c_dev, bus, &amp;error_abort)=
;<br>
<br>
=C2=A0 =C2=A0 =C2=A0mpu-&gt;i2s-&gt;opaque =3D wm;<br>
=C2=A0 =C2=A0 =C2=A0mpu-&gt;i2s-&gt;codec_out =3D wm8750_dac_dat;<br>
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c<br>
index ec2c4e1374..6e2da41419 100644<br>
--- a/hw/audio/wm8750.c<br>
+++ b/hw/audio/wm8750.c<br>
@@ -30,7 +30,7 @@ typedef struct {<br>
=C2=A0OBJECT_DECLARE_SIMPLE_TYPE(WM8750State, WM8750)<br>
<br>
=C2=A0struct WM8750State {<br>
-=C2=A0 =C2=A0 I2CSlave parent_obj;<br>
+=C2=A0 =C2=A0 I2CTarget parent_obj;<br>
<br>
=C2=A0 =C2=A0 =C2=A0uint8_t i2c_data[2];<br>
=C2=A0 =C2=A0 =C2=A0int i2c_len;<br>
@@ -261,7 +261,7 @@ static void wm8750_clk_update(WM8750State *s, int ext)<=
br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static void wm8750_reset(I2CSlave *i2c)<br>
+static void wm8750_reset(I2CTarget *i2c)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0WM8750State *s =3D WM8750(i2c);<br>
<br>
@@ -305,7 +305,7 @@ static void wm8750_reset(I2CSlave *i2c)<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;i2c_len =3D 0;<br>
=C2=A0}<br>
<br>
-static int wm8750_event(I2CSlave *i2c, enum i2c_event event)<br>
+static int wm8750_event(I2CTarget *i2c, enum i2c_event event)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0WM8750State *s =3D WM8750(i2c);<br>
<br>
@@ -364,7 +364,7 @@ static int wm8750_event(I2CSlave *i2c, enum i2c_event e=
vent)<br>
=C2=A0#define WM8750_ROUT2V=C2=A0 0x29<br>
=C2=A0#define WM8750_MOUTV=C2=A0 =C2=A00x2a<br>
<br>
-static int wm8750_tx(I2CSlave *i2c, uint8_t data)<br>
+static int wm8750_tx(I2CTarget *i2c, uint8_t data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0WM8750State *s =3D WM8750(i2c);<br>
=C2=A0 =C2=A0 =C2=A0uint8_t cmd;<br>
@@ -564,7 +564,7 @@ static int wm8750_tx(I2CSlave *i2c, uint8_t data)<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-static uint8_t wm8750_rx(I2CSlave *i2c)<br>
+static uint8_t wm8750_rx(I2CTarget *i2c)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0return 0x00;<br>
=C2=A0}<br>
@@ -615,7 +615,7 @@ static const VMStateDescription vmstate_wm8750 =3D {<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT8(format, WM8750State),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT8(power, WM8750State),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT8(rate_vmstate, WM8750State),=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_I2C_SLAVE(parent_obj, WM8750State),<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_I2C_TARGET(parent_obj, WM8750State),<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_END_OF_LIST()<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0};<br>
@@ -632,7 +632,7 @@ static void wm8750_realize(DeviceState *dev, Error **er=
rp)<br>
=C2=A0}<br>
<br>
=C2=A0#if 0<br>
-static void wm8750_fini(I2CSlave *i2c)<br>
+static void wm8750_fini(I2CTarget *i2c)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0WM8750State *s =3D WM8750(i2c);<br>
<br>
@@ -714,7 +714,7 @@ static Property wm8750_properties[] =3D {<br>
=C2=A0static void wm8750_class_init(ObjectClass *klass, void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
-=C2=A0 =C2=A0 I2CSlaveClass *sc =3D I2C_SLAVE_CLASS(klass);<br>
+=C2=A0 =C2=A0 I2CTargetClass *sc =3D I2C_TARGET_CLASS(klass);<br>
<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;realize =3D wm8750_realize;<br>
=C2=A0 =C2=A0 =C2=A0sc-&gt;event =3D wm8750_event;<br>
@@ -726,7 +726,7 @@ static void wm8750_class_init(ObjectClass *klass, void =
*data)<br>
<br>
=C2=A0static const TypeInfo wm8750_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_WM8750=
,<br>
-=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_I2C_SLAVE,<br>
+=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_I2C_TARGET,<br>
=C2=A0 =C2=A0 =C2=A0.instance_size =3D sizeof(WM8750State),<br>
=C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =3D wm8750_class_init,<br>
=C2=A0};<br>
diff --git a/hw/display/ati.c b/hw/display/ati.c<br>
index 8d2501bd82..3341ef7800 100644<br>
--- a/hw/display/ati.c<br>
+++ b/hw/display/ati.c<br>
@@ -1000,8 +1000,8 @@ static void ati_vga_realize(PCIDevice *dev, Error **e=
rrp)<br>
=C2=A0 =C2=A0 =C2=A0/* ddc, edid */<br>
=C2=A0 =C2=A0 =C2=A0I2CBus *i2cbus =3D i2c_init_bus(DEVICE(s), &quot;ati-vg=
a.ddc&quot;);<br>
=C2=A0 =C2=A0 =C2=A0bitbang_i2c_init(&amp;s-&gt;bbi2c, i2cbus);<br>
-=C2=A0 =C2=A0 I2CSlave *i2cddc =3D I2C_SLAVE(qdev_new(TYPE_I2CDDC));<br>
-=C2=A0 =C2=A0 i2c_slave_set_address(i2cddc, 0x50);<br>
+=C2=A0 =C2=A0 I2CTarget *i2cddc =3D I2C_SLAVE(qdev_new(TYPE_I2CDDC));<br>
+=C2=A0 =C2=A0 i2c_target_set_address(i2cddc, 0x50);<br>
=C2=A0 =C2=A0 =C2=A0qdev_realize_and_unref(DEVICE(i2cddc), BUS(i2cbus), &am=
p;error_abort);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* mmio register space */<br>
diff --git a/hw/display/i2c-ddc.c b/hw/display/i2c-ddc.c<br>
index 3f9d1e1f6f..66107b5b31 100644<br>
--- a/hw/display/i2c-ddc.c<br>
+++ b/hw/display/i2c-ddc.c<br>
@@ -42,7 +42,7 @@ static void i2c_ddc_reset(DeviceState *ds)<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;reg =3D 0;<br>
=C2=A0}<br>
<br>
-static int i2c_ddc_event(I2CSlave *i2c, enum i2c_event event)<br>
+static int i2c_ddc_event(I2CTarget *i2c, enum i2c_event event)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0I2CDDCState *s =3D I2CDDC(i2c);<br>
<br>
@@ -53,7 +53,7 @@ static int i2c_ddc_event(I2CSlave *i2c, enum i2c_event ev=
ent)<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-static uint8_t i2c_ddc_rx(I2CSlave *i2c)<br>
+static uint8_t i2c_ddc_rx(I2CTarget *i2c)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0I2CDDCState *s =3D I2CDDC(i2c);<br>
<br>
@@ -63,7 +63,7 @@ static uint8_t i2c_ddc_rx(I2CSlave *i2c)<br>
=C2=A0 =C2=A0 =C2=A0return value;<br>
=C2=A0}<br>
<br>
-static int i2c_ddc_tx(I2CSlave *i2c, uint8_t data)<br>
+static int i2c_ddc_tx(I2CTarget *i2c, uint8_t data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0I2CDDCState *s =3D I2CDDC(i2c);<br>
=C2=A0 =C2=A0 =C2=A0if (s-&gt;firstbyte) {<br>
@@ -103,7 +103,7 @@ static Property i2c_ddc_properties[] =3D {<br>
=C2=A0static void i2c_ddc_class_init(ObjectClass *oc, void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(oc);<br>
-=C2=A0 =C2=A0 I2CSlaveClass *isc =3D I2C_SLAVE_CLASS(oc);<br>
+=C2=A0 =C2=A0 I2CTargetClass *isc =3D I2C_TARGET_CLASS(oc);<br>
<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;reset =3D i2c_ddc_reset;<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;vmsd =3D &amp;vmstate_i2c_ddc;<br>
@@ -115,7 +115,7 @@ static void i2c_ddc_class_init(ObjectClass *oc, void *d=
ata)<br>
<br>
=C2=A0static const TypeInfo i2c_ddc_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name =3D TYPE_I2CDDC,<br>
-=C2=A0 =C2=A0 .parent =3D TYPE_I2C_SLAVE,<br>
+=C2=A0 =C2=A0 .parent =3D TYPE_I2C_TARGET,<br>
=C2=A0 =C2=A0 =C2=A0.instance_size =3D sizeof(I2CDDCState),<br>
=C2=A0 =C2=A0 =C2=A0.instance_init =3D i2c_ddc_init,<br>
=C2=A0 =C2=A0 =C2=A0.class_init =3D i2c_ddc_class_init<br>
diff --git a/hw/display/sii9022.c b/hw/display/sii9022.c<br>
index 60c3f78549..095fd862dd 100644<br>
--- a/hw/display/sii9022.c<br>
+++ b/hw/display/sii9022.c<br>
@@ -39,7 +39,7 @@<br>
=C2=A0OBJECT_DECLARE_SIMPLE_TYPE(sii9022_state, SII9022)<br>
<br>
=C2=A0struct sii9022_state {<br>
-=C2=A0 =C2=A0 I2CSlave parent_obj;<br>
+=C2=A0 =C2=A0 I2CTarget parent_obj;<br>
=C2=A0 =C2=A0 =C2=A0uint8_t ptr;<br>
=C2=A0 =C2=A0 =C2=A0bool addr_byte;<br>
=C2=A0 =C2=A0 =C2=A0bool ddc_req;<br>
@@ -52,7 +52,7 @@ static const VMStateDescription vmstate_sii9022 =3D {<br>
=C2=A0 =C2=A0 =C2=A0.version_id =3D 1,<br>
=C2=A0 =C2=A0 =C2=A0.minimum_version_id =3D 1,<br>
=C2=A0 =C2=A0 =C2=A0.fields =3D (const VMStateField[]) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_I2C_SLAVE(parent_obj, sii9022_state),<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_I2C_TARGET(parent_obj, sii9022_state),=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT8(ptr, sii9022_state),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_BOOL(addr_byte, sii9022_state),<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_BOOL(ddc_req, sii9022_state),<br>
@@ -62,7 +62,7 @@ static const VMStateDescription vmstate_sii9022 =3D {<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0};<br>
<br>
-static int sii9022_event(I2CSlave *i2c, enum i2c_event event)<br>
+static int sii9022_event(I2CTarget *i2c, enum i2c_event event)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0sii9022_state *s =3D SII9022(i2c);<br>
<br>
@@ -83,7 +83,7 @@ static int sii9022_event(I2CSlave *i2c, enum i2c_event ev=
ent)<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-static uint8_t sii9022_rx(I2CSlave *i2c)<br>
+static uint8_t sii9022_rx(I2CTarget *i2c)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0sii9022_state *s =3D SII9022(i2c);<br>
=C2=A0 =C2=A0 =C2=A0uint8_t res =3D 0x00;<br>
@@ -112,7 +112,7 @@ static uint8_t sii9022_rx(I2CSlave *i2c)<br>
=C2=A0 =C2=A0 =C2=A0return res;<br>
=C2=A0}<br>
<br>
-static int sii9022_tx(I2CSlave *i2c, uint8_t data)<br>
+static int sii9022_tx(I2CTarget *i2c, uint8_t data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0sii9022_state *s =3D SII9022(i2c);<br>
<br>
@@ -164,13 +164,13 @@ static void sii9022_realize(DeviceState *dev, Error *=
*errp)<br>
=C2=A0 =C2=A0 =C2=A0I2CBus *bus;<br>
<br>
=C2=A0 =C2=A0 =C2=A0bus =3D I2C_BUS(qdev_get_parent_bus(dev));<br>
-=C2=A0 =C2=A0 i2c_slave_create_simple(bus, TYPE_I2CDDC, 0x50);<br>
+=C2=A0 =C2=A0 i2c_target_create_simple(bus, TYPE_I2CDDC, 0x50);<br>
=C2=A0}<br>
<br>
=C2=A0static void sii9022_class_init(ObjectClass *klass, void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
-=C2=A0 =C2=A0 I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);<br>
+=C2=A0 =C2=A0 I2CTargetClass *k =3D I2C_TARGET_CLASS(klass);<br>
<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;event =3D sii9022_event;<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;recv =3D sii9022_rx;<br>
@@ -182,7 +182,7 @@ static void sii9022_class_init(ObjectClass *klass, void=
 *data)<br>
<br>
=C2=A0static const TypeInfo sii9022_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SII902=
2,<br>
-=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_I2C_SLAVE,<br>
+=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_I2C_TARGET,<br>
=C2=A0 =C2=A0 =C2=A0.instance_size =3D sizeof(sii9022_state),<br>
=C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =3D sii9022_class_init,<br>
=C2=A0};<br>
diff --git a/hw/display/sm501.c b/hw/display/sm501.c<br>
index 26dc8170d8..a549c9149f 100644<br>
--- a/hw/display/sm501.c<br>
+++ b/hw/display/sm501.c<br>
@@ -1908,7 +1908,7 @@ static void sm501_init(SM501State *s, DeviceState *de=
v,<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;i2c_bus =3D i2c_init_bus(dev, &quot;sm501.i2c&quo=
t;);<br>
=C2=A0 =C2=A0 =C2=A0/* ddc */<br>
=C2=A0 =C2=A0 =C2=A0I2CDDCState *ddc =3D I2CDDC(qdev_new(TYPE_I2CDDC));<br>
-=C2=A0 =C2=A0 i2c_slave_set_address(I2C_SLAVE(ddc), 0x50);<br>
+=C2=A0 =C2=A0 i2c_target_set_address(I2C_SLAVE(ddc), 0x50);<br>
=C2=A0 =C2=A0 =C2=A0qdev_realize_and_unref(DEVICE(ddc), BUS(s-&gt;i2c_bus),=
 &amp;error_abort);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* mmio */<br>
diff --git a/hw/display/ssd0303.c b/hw/display/ssd0303.c<br>
index e292cff44e..45d789d23e 100644<br>
--- a/hw/display/ssd0303.c<br>
+++ b/hw/display/ssd0303.c<br>
@@ -50,7 +50,7 @@ enum ssd0303_cmd {<br>
=C2=A0OBJECT_DECLARE_SIMPLE_TYPE(ssd0303_state, SSD0303)<br>
<br>
=C2=A0struct ssd0303_state {<br>
-=C2=A0 =C2=A0 I2CSlave parent_obj;<br>
+=C2=A0 =C2=A0 I2CTarget parent_obj;<br>
<br>
=C2=A0 =C2=A0 =C2=A0QemuConsole *con;<br>
=C2=A0 =C2=A0 =C2=A0int row;<br>
@@ -66,13 +66,13 @@ struct ssd0303_state {<br>
=C2=A0 =C2=A0 =C2=A0uint8_t framebuffer[132*8];<br>
=C2=A0};<br>
<br>
-static uint8_t ssd0303_recv(I2CSlave *i2c)<br>
+static uint8_t ssd0303_recv(I2CTarget *i2c)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0BADF(&quot;Reads not implemented\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0return 0xff;<br>
=C2=A0}<br>
<br>
-static int ssd0303_send(I2CSlave *i2c, uint8_t data)<br>
+static int ssd0303_send(I2CTarget *i2c, uint8_t data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ssd0303_state *s =3D SSD0303(i2c);<br>
=C2=A0 =C2=A0 =C2=A0enum ssd0303_cmd old_cmd_state;<br>
@@ -183,7 +183,7 @@ static int ssd0303_send(I2CSlave *i2c, uint8_t data)<br=
>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-static int ssd0303_event(I2CSlave *i2c, enum i2c_event event)<br>
+static int ssd0303_event(I2CTarget *i2c, enum i2c_event event)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ssd0303_state *s =3D SSD0303(i2c);<br>
<br>
@@ -293,7 +293,7 @@ static const VMStateDescription vmstate_ssd0303 =3D {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT32(mode, ssd0303_state),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT32(cmd_state, ssd0303_state),=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_BUFFER(framebuffer, ssd0303_state=
),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_I2C_SLAVE(parent_obj, ssd0303_state),<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_I2C_TARGET(parent_obj, ssd0303_state),=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_END_OF_LIST()<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0};<br>
@@ -314,7 +314,7 @@ static void ssd0303_realize(DeviceState *dev, Error **e=
rrp)<br>
=C2=A0static void ssd0303_class_init(ObjectClass *klass, void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
-=C2=A0 =C2=A0 I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);<br>
+=C2=A0 =C2=A0 I2CTargetClass *k =3D I2C_TARGET_CLASS(klass);<br>
<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;realize =3D ssd0303_realize;<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;event =3D ssd0303_event;<br>
@@ -325,7 +325,7 @@ static void ssd0303_class_init(ObjectClass *klass, void=
 *data)<br>
<br>
=C2=A0static const TypeInfo ssd0303_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SSD030=
3,<br>
-=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_I2C_SLAVE,<br>
+=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_I2C_TARGET,<br>
=C2=A0 =C2=A0 =C2=A0.instance_size =3D sizeof(ssd0303_state),<br>
=C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =3D ssd0303_class_init,<br>
=C2=A0};<br>
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c<br>
index c42fc388dc..fd1cc371d3 100644<br>
--- a/hw/display/xlnx_dp.c<br>
+++ b/hw/display/xlnx_dp.c<br>
@@ -1273,7 +1273,7 @@ static void xlnx_dp_init(Object *obj)<br>
=C2=A0 =C2=A0 =C2=A0object_property_add_child(OBJECT(s), &quot;dpcd&quot;, =
OBJECT(s-&gt;dpcd));<br>
<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;edid =3D I2CDDC(qdev_new(&quot;i2c-ddc&quot;));<b=
r>
-=C2=A0 =C2=A0 i2c_slave_set_address(I2C_SLAVE(s-&gt;edid), 0x50);<br>
+=C2=A0 =C2=A0 i2c_target_set_address(I2C_SLAVE(s-&gt;edid), 0x50);<br>
=C2=A0 =C2=A0 =C2=A0object_property_add_child(OBJECT(s), &quot;edid&quot;, =
OBJECT(s-&gt;edid));<br>
<br>
=C2=A0 =C2=A0 =C2=A0fifo8_create(&amp;s-&gt;rx_fifo, 16);<br>
diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c<br>
index 86315714fb..e911647812 100644<br>
--- a/hw/gpio/max7310.c<br>
+++ b/hw/gpio/max7310.c<br>
@@ -19,7 +19,7 @@<br>
=C2=A0OBJECT_DECLARE_SIMPLE_TYPE(MAX7310State, MAX7310)<br>
<br>
=C2=A0struct MAX7310State {<br>
-=C2=A0 =C2=A0 I2CSlave parent_obj;<br>
+=C2=A0 =C2=A0 I2CTarget parent_obj;<br>
<br>
=C2=A0 =C2=A0 =C2=A0int i2c_command_byte;<br>
=C2=A0 =C2=A0 =C2=A0int len;<br>
@@ -44,7 +44,7 @@ static void max7310_reset(DeviceState *dev)<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;command =3D 0x00;<br>
=C2=A0}<br>
<br>
-static uint8_t max7310_rx(I2CSlave *i2c)<br>
+static uint8_t max7310_rx(I2CTarget *i2c)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MAX7310State *s =3D MAX7310(i2c);<br>
<br>
@@ -75,7 +75,7 @@ static uint8_t max7310_rx(I2CSlave *i2c)<br>
=C2=A0 =C2=A0 =C2=A0return 0xff;<br>
=C2=A0}<br>
<br>
-static int max7310_tx(I2CSlave *i2c, uint8_t data)<br>
+static int max7310_tx(I2CTarget *i2c, uint8_t data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MAX7310State *s =3D MAX7310(i2c);<br>
=C2=A0 =C2=A0 =C2=A0uint8_t diff;<br>
@@ -129,7 +129,7 @@ static int max7310_tx(I2CSlave *i2c, uint8_t data)<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-static int max7310_event(I2CSlave *i2c, enum i2c_event event)<br>
+static int max7310_event(I2CTarget *i2c, enum i2c_event event)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MAX7310State *s =3D MAX7310(i2c);<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;len =3D 0;<br>
@@ -163,7 +163,7 @@ static const VMStateDescription vmstate_max7310 =3D {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT8(polarity, MAX7310State),<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT8(status, MAX7310State),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT8(command, MAX7310State),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_I2C_SLAVE(parent_obj, MAX7310State),<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_I2C_TARGET(parent_obj, MAX7310State),<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_END_OF_LIST()<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0};<br>
@@ -192,7 +192,7 @@ static void max7310_realize(DeviceState *dev, Error **e=
rrp)<br>
=C2=A0static void max7310_class_init(ObjectClass *klass, void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
-=C2=A0 =C2=A0 I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);<br>
+=C2=A0 =C2=A0 I2CTargetClass *k =3D I2C_TARGET_CLASS(klass);<br>
<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;realize =3D max7310_realize;<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;event =3D max7310_event;<br>
@@ -204,7 +204,7 @@ static void max7310_class_init(ObjectClass *klass, void=
 *data)<br>
<br>
=C2=A0static const TypeInfo max7310_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_MAX731=
0,<br>
-=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_I2C_SLAVE,<br>
+=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_I2C_TARGET,<br>
=C2=A0 =C2=A0 =C2=A0.instance_size =3D sizeof(MAX7310State),<br>
=C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =3D max7310_class_init,<br>
=C2=A0};<br>
diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c<br>
index 27d4db0680..8c691b805a 100644<br>
--- a/hw/gpio/pca9552.c<br>
+++ b/hw/gpio/pca9552.c<br>
@@ -26,7 +26,7 @@<br>
<br>
=C2=A0struct PCA955xClass {<br>
=C2=A0 =C2=A0 =C2=A0/*&lt; private &gt;*/<br>
-=C2=A0 =C2=A0 I2CSlaveClass parent_class;<br>
+=C2=A0 =C2=A0 I2CTargetClass parent_class;<br>
=C2=A0 =C2=A0 =C2=A0/*&lt; public &gt;*/<br>
<br>
=C2=A0 =C2=A0 =C2=A0uint8_t pin_count;<br>
@@ -217,7 +217,7 @@ static void pca955x_autoinc(PCA955xState *s)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static uint8_t pca955x_recv(I2CSlave *i2c)<br>
+static uint8_t pca955x_recv(I2CTarget *i2c)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0PCA955xState *s =3D PCA955X(i2c);<br>
=C2=A0 =C2=A0 =C2=A0uint8_t ret;<br>
@@ -245,7 +245,7 @@ static uint8_t pca955x_recv(I2CSlave *i2c)<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
-static int pca955x_send(I2CSlave *i2c, uint8_t data)<br>
+static int pca955x_send(I2CTarget *i2c, uint8_t data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0PCA955xState *s =3D PCA955X(i2c);<br>
<br>
@@ -262,7 +262,7 @@ static int pca955x_send(I2CSlave *i2c, uint8_t data)<br=
>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-static int pca955x_event(I2CSlave *i2c, enum i2c_event event)<br>
+static int pca955x_event(I2CTarget *i2c, enum i2c_event event)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0PCA955xState *s =3D PCA955X(i2c);<br>
<br>
@@ -354,7 +354,7 @@ static const VMStateDescription pca9552_vmstate =3D {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT8(pointer, PCA955xState),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT8_ARRAY(regs, PCA955xState, P=
CA955X_NR_REGS),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT8_ARRAY(ext_state, PCA955xSta=
te, PCA955X_PIN_COUNT_MAX),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_I2C_SLAVE(i2c, PCA955xState),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_I2C_TARGET(i2c, PCA955xState),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_END_OF_LIST()<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0};<br>
@@ -436,7 +436,7 @@ static Property pca955x_properties[] =3D {<br>
=C2=A0static void pca955x_class_init(ObjectClass *klass, void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
-=C2=A0 =C2=A0 I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);<br>
+=C2=A0 =C2=A0 I2CTargetClass *k =3D I2C_TARGET_CLASS(klass);<br>
<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;event =3D pca955x_event;<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;recv =3D pca955x_recv;<br>
@@ -447,7 +447,7 @@ static void pca955x_class_init(ObjectClass *klass, void=
 *data)<br>
<br>
=C2=A0static const TypeInfo pca955x_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_PCA955=
X,<br>
-=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_I2C_SLAVE,<br>
+=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_I2C_TARGET,<br>
=C2=A0 =C2=A0 =C2=A0.instance_init =3D pca955x_initfn,<br>
=C2=A0 =C2=A0 =C2=A0.instance_size =3D sizeof(PCA955xState),<br>
=C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =3D pca955x_class_init,<br>
diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c<br>
index 7d10a64ba7..7bd0a29c66 100644<br>
--- a/hw/gpio/pca9554.c<br>
+++ b/hw/gpio/pca9554.c<br>
@@ -22,7 +22,7 @@<br>
<br>
=C2=A0struct PCA9554Class {<br>
=C2=A0 =C2=A0 =C2=A0/*&lt; private &gt;*/<br>
-=C2=A0 =C2=A0 I2CSlaveClass parent_class;<br>
+=C2=A0 =C2=A0 I2CTargetClass parent_class;<br>
=C2=A0 =C2=A0 =C2=A0/*&lt; public &gt;*/<br>
=C2=A0};<br>
=C2=A0typedef struct PCA9554Class PCA9554Class;<br>
@@ -115,7 +115,7 @@ static void pca9554_write(PCA9554State *s, uint8_t reg,=
 uint8_t data)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static uint8_t pca9554_recv(I2CSlave *i2c)<br>
+static uint8_t pca9554_recv(I2CTarget *i2c)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0PCA9554State *s =3D PCA9554(i2c);<br>
=C2=A0 =C2=A0 =C2=A0uint8_t ret;<br>
@@ -125,7 +125,7 @@ static uint8_t pca9554_recv(I2CSlave *i2c)<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
-static int pca9554_send(I2CSlave *i2c, uint8_t data)<br>
+static int pca9554_send(I2CTarget *i2c, uint8_t data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0PCA9554State *s =3D PCA9554(i2c);<br>
<br>
@@ -140,7 +140,7 @@ static int pca9554_send(I2CSlave *i2c, uint8_t data)<br=
>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-static int pca9554_event(I2CSlave *i2c, enum i2c_event event)<br>
+static int pca9554_event(I2CTarget *i2c, enum i2c_event event)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0PCA9554State *s =3D PCA9554(i2c);<br>
<br>
@@ -227,7 +227,7 @@ static const VMStateDescription pca9554_vmstate =3D {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT8(pointer, PCA9554State),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT8_ARRAY(regs, PCA9554State, P=
CA9554_NR_REGS),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT8_ARRAY(ext_state, PCA9554Sta=
te, PCA9554_PIN_COUNT),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_I2C_SLAVE(i2c, PCA9554State),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_I2C_TARGET(i2c, PCA9554State),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_END_OF_LIST()<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0};<br>
@@ -299,7 +299,7 @@ static Property pca9554_properties[] =3D {<br>
=C2=A0static void pca9554_class_init(ObjectClass *klass, void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
-=C2=A0 =C2=A0 I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);<br>
+=C2=A0 =C2=A0 I2CTargetClass *k =3D I2C_TARGET_CLASS(klass);<br>
<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;event =3D pca9554_event;<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;recv =3D pca9554_recv;<br>
@@ -312,7 +312,7 @@ static void pca9554_class_init(ObjectClass *klass, void=
 *data)<br>
<br>
=C2=A0static const TypeInfo pca9554_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_PCA955=
4,<br>
-=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_I2C_SLAVE,<br>
+=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_I2C_TARGET,<br>
=C2=A0 =C2=A0 =C2=A0.instance_init =3D pca9554_initfn,<br>
=C2=A0 =C2=A0 =C2=A0.instance_size =3D sizeof(PCA9554State),<br>
=C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =3D pca9554_class_init,<br>
diff --git a/hw/gpio/pcf8574.c b/hw/gpio/pcf8574.c<br>
index d37909e2ad..460023ceb3 100644<br>
--- a/hw/gpio/pcf8574.c<br>
+++ b/hw/gpio/pcf8574.c<br>
@@ -39,7 +39,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PCF8574State, PCF8574)<br>
=C2=A0#define PORTS_COUNT (8)<br>
<br>
=C2=A0struct PCF8574State {<br>
-=C2=A0 =C2=A0 I2CSlave parent_obj;<br>
+=C2=A0 =C2=A0 I2CTarget parent_obj;<br>
=C2=A0 =C2=A0 =C2=A0uint8_t=C2=A0 lastrq;=C2=A0 =C2=A0 =C2=A0/* Last reques=
ted state. If changed - assert irq */<br>
=C2=A0 =C2=A0 =C2=A0uint8_t=C2=A0 input;=C2=A0 =C2=A0 =C2=A0 /* external el=
ectrical line state */<br>
=C2=A0 =C2=A0 =C2=A0uint8_t=C2=A0 output;=C2=A0 =C2=A0 =C2=A0/* Pull-up (1)=
 or drive low (0) on bit */<br>
@@ -61,7 +61,7 @@ static inline uint8_t pcf8574_line_state(PCF8574State *s)=
<br>
=C2=A0 =C2=A0 =C2=A0return s-&gt;input &amp; s-&gt;output;<br>
=C2=A0}<br>
<br>
-static uint8_t pcf8574_rx(I2CSlave *i2c)<br>
+static uint8_t pcf8574_rx(I2CTarget *i2c)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0PCF8574State *s =3D PCF8574(i2c);<br>
=C2=A0 =C2=A0 =C2=A0uint8_t linestate =3D pcf8574_line_state(s);<br>
@@ -74,7 +74,7 @@ static uint8_t pcf8574_rx(I2CSlave *i2c)<br>
=C2=A0 =C2=A0 =C2=A0return linestate;<br>
=C2=A0}<br>
<br>
-static int pcf8574_tx(I2CSlave *i2c, uint8_t data)<br>
+static int pcf8574_tx(I2CTarget *i2c, uint8_t data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0PCF8574State *s =3D PCF8574(i2c);<br>
=C2=A0 =C2=A0 =C2=A0uint8_t prev;<br>
@@ -105,7 +105,7 @@ static const VMStateDescription vmstate_pcf8574 =3D {<b=
r>
=C2=A0 =C2=A0 =C2=A0.version_id=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0,<br>
=C2=A0 =C2=A0 =C2=A0.minimum_version_id =3D 0,<br>
=C2=A0 =C2=A0 =C2=A0.fields =3D (VMStateField[]) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_I2C_SLAVE(parent_obj, PCF8574State),<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_I2C_TARGET(parent_obj, PCF8574State),<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT8(lastrq, PCF8574State),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT8(input,=C2=A0 PCF8574State),=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT8(output, PCF8574State),<br>
@@ -141,7 +141,7 @@ static void pcf8574_realize(DeviceState *dev, Error **e=
rrp)<br>
=C2=A0static void pcf8574_class_init(ObjectClass *klass, void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0DeviceClass=C2=A0 =C2=A0*dc =3D DEVICE_CLASS(klass);<br=
>
-=C2=A0 =C2=A0 I2CSlaveClass *k=C2=A0 =3D I2C_SLAVE_CLASS(klass);<br>
+=C2=A0 =C2=A0 I2CTargetClass *k=C2=A0 =3D I2C_TARGET_CLASS(klass);<br>
<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;recv=C2=A0 =C2=A0 =C2=A0=3D pcf8574_rx;<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;send=C2=A0 =C2=A0 =C2=A0=3D pcf8574_tx;<br>
@@ -153,7 +153,7 @@ static void pcf8574_class_init(ObjectClass *klass, void=
 *data)<br>
=C2=A0static const TypeInfo pcf8574_infos[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D TYPE_PCF8574,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_I2=
C_SLAVE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_I2=
C_TARGET,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.instance_size =3D sizeof(PCF8574State),<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =3D pcf8574_clas=
s_init,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c<br>
index b43afd250d..8ed67d5f0c 100644<br>
--- a/hw/i2c/aspeed_i2c.c<br>
+++ b/hw/i2c/aspeed_i2c.c<br>
@@ -536,7 +536,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus=
, uint64_t value)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SHARED_ARRAY_FIELD_DP32(bus-&gt;regs, reg=
_cmd, M_STOP_CMD, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aspeed_i2c_set_state(bus, I2CD_IDLE);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_schedule_pending_master(bus-&gt;bus);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_schedule_pending_controller(bus-&gt;bus);<=
br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (aspeed_i2c_bus_pkt_mode_en(bus)) {<br>
@@ -693,7 +693,7 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus,=
 hwaddr offset,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bus-&gt;regs[R_I2CS_CMD] =
=3D value;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_slave_set_address(bus-&gt;slave, bus-&gt;r=
egs[R_I2CS_DEV_ADDR]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_target_set_address(bus-&gt;slave, bus-&gt;=
regs[R_I2CS_DEV_ADDR]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case A_I2CS_INTR_CTRL:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bus-&gt;regs[R_I2CS_INTR_CTRL] =3D value;=
<br>
@@ -738,7 +738,7 @@ static void aspeed_i2c_bus_old_write(AspeedI2CBus *bus,=
 hwaddr offset,<br>
=C2=A0 =C2=A0 =C2=A0switch (offset) {<br>
=C2=A0 =C2=A0 =C2=A0case A_I2CD_FUN_CTRL:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (SHARED_FIELD_EX32(value, SLAVE_EN)) {=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_slave_set_address(bus-&gt;sl=
ave, bus-&gt;regs[R_I2CD_DEV_ADDR]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_target_set_address(bus-&gt;s=
lave, bus-&gt;regs[R_I2CD_DEV_ADDR]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bus-&gt;regs[R_I2CD_FUN_CTRL] =3D value &=
amp; 0x0071C3FF;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -1112,7 +1112,7 @@ static int aspeed_i2c_bus_new_slave_event(AspeedI2CBu=
s *bus,<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-static int aspeed_i2c_bus_slave_event(I2CSlave *slave, enum i2c_event even=
t)<br>
+static int aspeed_i2c_bus_slave_event(I2CTarget *slave, enum i2c_event eve=
nt)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0BusState *qbus =3D qdev_get_parent_bus(DEVICE(slave));<=
br>
=C2=A0 =C2=A0 =C2=A0AspeedI2CBus *bus =3D ASPEED_I2C_BUS(qbus-&gt;parent);<=
br>
@@ -1167,7 +1167,7 @@ static void aspeed_i2c_bus_new_slave_send_async(Aspee=
dI2CBus *bus, uint8_t data)<br>
=C2=A0 =C2=A0 =C2=A0i2c_ack(bus-&gt;bus);<br>
=C2=A0}<br>
<br>
-static void aspeed_i2c_bus_slave_send_async(I2CSlave *slave, uint8_t data)=
<br>
+static void aspeed_i2c_bus_slave_send_async(I2CTarget *slave, uint8_t data=
)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0BusState *qbus =3D qdev_get_parent_bus(DEVICE(slave));<=
br>
=C2=A0 =C2=A0 =C2=A0AspeedI2CBus *bus =3D ASPEED_I2C_BUS(qbus-&gt;parent);<=
br>
@@ -1187,7 +1187,7 @@ static void aspeed_i2c_bus_slave_send_async(I2CSlave =
*slave, uint8_t data)<br>
=C2=A0static void aspeed_i2c_bus_slave_class_init(ObjectClass *klass, void =
*data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
-=C2=A0 =C2=A0 I2CSlaveClass *sc =3D I2C_SLAVE_CLASS(klass);<br>
+=C2=A0 =C2=A0 I2CTargetClass *sc =3D I2C_TARGET_CLASS(klass);<br>
<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;desc =3D &quot;Aspeed I2C Bus Slave&quot;;<br>
<br>
@@ -1197,7 +1197,7 @@ static void aspeed_i2c_bus_slave_class_init(ObjectCla=
ss *klass, void *data)<br>
<br>
=C2=A0static const TypeInfo aspeed_i2c_bus_slave_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D TYPE_=
ASPEED_I2C_BUS_SLAVE,<br>
-=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D TYPE_I2C_SLAVE,=
<br>
+=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D TYPE_I2C_TARGET=
,<br>
=C2=A0 =C2=A0 =C2=A0.instance_size=C2=A0 =3D sizeof(AspeedI2CBusSlave),<br>
=C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =C2=A0=3D aspeed_i2c_bus_slave=
_class_init,<br>
=C2=A0};<br>
@@ -1226,7 +1226,7 @@ static void aspeed_i2c_bus_realize(DeviceState *dev, =
Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0sysbus_init_irq(SYS_BUS_DEVICE(dev), &amp;s-&gt;irq);<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;bus =3D i2c_init_bus(dev, name);<br>
-=C2=A0 =C2=A0 s-&gt;slave =3D i2c_slave_create_simple(s-&gt;bus, TYPE_ASPE=
ED_I2C_BUS_SLAVE,<br>
+=C2=A0 =C2=A0 s-&gt;slave =3D i2c_target_create_simple(s-&gt;bus, TYPE_ASP=
EED_I2C_BUS_SLAVE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xff);<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0memory_region_init_io(&amp;s-&gt;mr, OBJECT(s), &amp;as=
peed_i2c_bus_ops,<br>
diff --git a/hw/i2c/core.c b/hw/i2c/core.c<br>
index 4cf30b2c86..fd34a6bc83 100644<br>
--- a/hw/i2c/core.c<br>
+++ b/hw/i2c/core.c<br>
@@ -19,7 +19,7 @@<br>
=C2=A0#define I2C_BROADCAST 0x00<br>
<br>
=C2=A0static Property i2c_props[] =3D {<br>
-=C2=A0 =C2=A0 DEFINE_PROP_UINT8(&quot;address&quot;, struct I2CSlave, addr=
ess, 0),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_UINT8(&quot;address&quot;, struct I2CTarget, add=
ress, 0),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_END_OF_LIST(),<br>
=C2=A0};<br>
<br>
@@ -63,12 +63,12 @@ I2CBus *i2c_init_bus(DeviceState *parent, const char *n=
ame)<br>
<br>
=C2=A0 =C2=A0 =C2=A0bus =3D I2C_BUS(qbus_new(TYPE_I2C_BUS, parent, name));<=
br>
=C2=A0 =C2=A0 =C2=A0QLIST_INIT(&amp;bus-&gt;current_devs);<br>
-=C2=A0 =C2=A0 QSIMPLEQ_INIT(&amp;bus-&gt;pending_masters);<br>
+=C2=A0 =C2=A0 QSIMPLEQ_INIT(&amp;bus-&gt;pending_controllers);<br>
=C2=A0 =C2=A0 =C2=A0vmstate_register_any(NULL, &amp;vmstate_i2c_bus, bus);<=
br>
=C2=A0 =C2=A0 =C2=A0return bus;<br>
=C2=A0}<br>
<br>
-void i2c_slave_set_address(I2CSlave *dev, uint8_t address)<br>
+void i2c_target_set_address(I2CTarget *dev, uint8_t address)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0dev-&gt;address =3D address;<br>
=C2=A0}<br>
@@ -86,8 +86,8 @@ bool i2c_scan_bus(I2CBus *bus, uint8_t address, bool broa=
dcast,<br>
<br>
=C2=A0 =C2=A0 =C2=A0QTAILQ_FOREACH(kid, &amp;bus-&gt;qbus.children, sibling=
) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0D</blockquote></div></div></div>

--000000000000a13c9e0615a622bf--


