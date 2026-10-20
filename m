Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF6F606A326
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VybvtUni
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ3Qi-0003Bt-4w; Tue, 20 Oct 2026 02:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ3Qd-0003Ap-Ln
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:34:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ3Qb-0007yv-KN
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792478069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bAlsLbYw8Kvn3pl7lR0bgEHXvxS8cFRUWceZrHE770U=;
 b=VybvtUnip6qrxhDINg4LF8NaMfpbvvGDXumoOs67FawY78x0Udjjw+MVloXDu7bYBKuodV
 Xcc81dv4zyeuDu39VFszPG7n3vkflYyDsrcwj374zRVegyVxoS9jOreyE0vps+npPobEw1
 el4r8N2qz/p1Pnql1lnnXkNTvIymd5M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-aHiyk8QLNke4o-h3dHbx8g-1; Tue,
 20 Oct 2026 06:34:20 +0000
X-MC-Unique: aHiyk8QLNke4o-h3dHbx8g-1
X-Mimecast-MFC-AGG-ID: aHiyk8QLNke4o-h3dHbx8g_1792478059
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC5E91800A30; Tue, 20 Oct 2026 06:34:18 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CAFE61803A55; Tue, 20 Oct 2026 06:34:17 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 50/65] hw/gpio/pca955x: convert pin/led property to
 QAPI-aware enum
From: marcandre.lureau@redhat.com
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 berrange@redhat.com, michael.roth@amd.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 kkostiuk@redhat.com, alistair.francis@wdc.com, amachhiw@linux.ibm.com
In-Reply-To: <20261019141929.1594337-51-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
 <20261019141929.1594337-51-armbru@redhat.com>
Date: Tue, 20 Oct 2026 10:33:32 +0400
Message-Id: <179247801299.2782576.13259519199396813507.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=10422;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=qhnvZ66lk5/RSdiiBr3csqbHF6H44OZo2HtEoBsdvko=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq1wtCrMslE4X71pmBLVr+UELjO2zQoO2eYSSQf
 yVKvHdEsMSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatcLQgAKCRDa6OEJdZac
 5QBDD/9TqSFmNtJpwLpdZrFXmTkLO4NukRvHV8Kt5y8qtvxnzLdM+4g1d5S59zhIuaRYChyEdh1
 +WuUfZO8OWrV3ZmZDQ0kEm7eThXjKCS27sig9U8V3mg+muI+spwlhUFW6xr3+rr1rtCTAXF3djS
 8FeTwZtiLWVotLU5kZMZDJ9ZUrghb1i/2gek7PwbRYvpRyvThP2HfEAsmujDaTAKWKhLABcxfFa
 UH5YXqU/DDvTTQsVvGuv8b7VIs2/DzRH/Mc6EOnyrYfMfEmEhOquWrXavvh+PZ+gA686h+ubJeX
 Ho8mZG6nolay0bAWHv8GEI72Zjnsay47USC17JyT7UIWGxZ/dAerSWRop0fYiceQBOZ3FlrV93A
 BEEGBsRzd/HXVaIKT6mMrPulCdZF7x6hHY0qymHQkCQIQ50xHutMiN3DJCtblB7oGclBSGJdVXh
 iLIvRt+kmrQYfxgcvOeY5npGQ0V45bMJbhCZUQYhhHxcioJCXqAy0hQaF6YcSqFNQzkCbnDVlGg
 aIXHX0vLb7rlsPD7xJ3FbyQ3MAVye8c9xAfW7SD7v1CGB7L9K+GWv5+sUphaGxFbVC9KRv+rAva
 v495R1xGG4Gdo3s/S+nWGTK4JvHxmhAEPdSixaFCyEYtQKtEKBWaO4lIPCQtjDj3LoRjLVsVjrl
 GKQnzV5DdfC5aJA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Replaces the runtime-parsed visitor-based QOM property accessors with
> compile-time per-pin/per-LED accessor functions using QEMU_REPEAT.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Message-ID: <20261019141929.1594337-51-armbru@redhat.com>
> ---
>  hw/gpio/pca9552.c | 205 ++++++++++++++++++----------------------------
>  hw/gpio/pca9554.c | 136 ++++++++++++------------------
>  2 files changed, 131 insertions(+), 210 deletions(-)
>
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index 16741c22dea3..b743a30d80ff 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -25,6 +25,7 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-types-machine.h"
>  #include "qapi/qapi-visit-machine.h"
> +#include "qapi/qapi-type-infos-machine.h"
>  #include "trace.h"
>  #include "qom/object.h"
>  
> @@ -354,33 +355,6 @@ static int pca955x_event(I2CSlave *i2c, enum i2c_event event)
>      return 0;
>  }
>  
> -static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
> -                            void *opaque, Error **errp)
> -{
> -    PCA955xClass *k = PCA955X_GET_CLASS(obj);
> -    PCA955xState *s = PCA955X(obj);
> -    int led, rc, reg;
> -    Pca9552LedState state;
> -
> -    rc = sscanf(name, "led%2d", &led);
> -    if (rc != 1) {
> -        error_setg(errp, "%s: error reading %s", __func__, name);
> -        return;
> -    }
> -    if (led < 0 || led >= k->pin_count) {
> -        error_setg(errp, "%s: invalid led %s", __func__, name);
> -        return;
> -    }
> -    /*
> -     * Get the LSx register as the qom interface should expose the device
> -     * state, not the modeled 'input line' behaviour which would come from
> -     * reading the INPUTx reg
> -     */
> -    reg = PCA9552_LS0 + led / 4;
> -    state = (pca955x_read(s, reg) >> ((led % 4) * 2)) & 0x3;
> -    visit_type_Pca9552LedState(v, name, &state, errp);
> -}
> -
>  /*
>   * Return an LED selector register value based on an existing one, with
>   * the appropriate 2-bit state value set for the given LED number (0-3).
> @@ -391,97 +365,8 @@ static inline uint8_t pca955x_ledsel(uint8_t oldval, int led_num, int state)
>                  ((state & 0x3) << (led_num << 1));
>  }
>  
> -static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
> -                            void *opaque, Error **errp)
> -{
> -    PCA955xClass *k = PCA955X_GET_CLASS(obj);
> -    PCA955xState *s = PCA955X(obj);
> -    int led, rc, reg, val;
> -    Pca9552LedState state;
> -
> -    if (!visit_type_Pca9552LedState(v, name, &state, errp)) {
> -        return;
> -    }
> -    rc = sscanf(name, "led%2d", &led);
> -    if (rc != 1) {
> -        error_setg(errp, "%s: error reading %s", __func__, name);
> -        return;
> -    }
> -    if (led < 0 || led >= k->pin_count) {
> -        error_setg(errp, "%s: invalid led %s", __func__, name);
> -        return;
> -    }
> -
> -    reg = PCA9552_LS0 + led / 4;
> -    val = pca955x_read(s, reg);
> -    val = pca955x_ledsel(val, led % 4, state);
> -    pca955x_write(s, reg, val);
> -}
> -
>  static void pca955x_set_ext_state(PCA955xState *s, int pin, int level);
>  
> -static void pca955x_get_pin(Object *obj, Visitor *v, const char *name,
> -                            void *opaque, Error **errp)
> -{
> -    PCA955xClass *k = PCA955X_GET_CLASS(obj);
> -    PCA955xState *s = PCA955X(obj);
> -    int pin, rc;
> -    uint8_t input_reg;
> -    Pca9552PinState state;
> -
> -    rc = sscanf(name, "pin%2d", &pin);
> -    if (rc != 1) {
> -        error_setg(errp, "%s: error reading %s", __func__, name);
> -        return;
> -    }
> -    if (pin < 0 || pin >= k->pin_count) {
> -        error_setg(errp, "%s invalid pin %s", __func__, name);
> -        return;
> -    }
> -
> -    /*
> -     * Report the raw pin logic level; polarity inversion is a read-time
> -     * transform applied to the INPUT register, not to the pin state itself.
> -     */
> -    input_reg = PCA9535_INPUT0 + (pin / 8);
> -    state = (s->regs[input_reg] >> (pin % 8)) & 0x1;
> -    visit_type_Pca9552PinState(v, name, &state, errp);
> -}
> -
> -static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
> -                            void *opaque, Error **errp)
> -{
> -    PCA955xClass *k = PCA955X_GET_CLASS(obj);
> -    PCA955xState *s = PCA955X(obj);
> -    int pin, rc;
> -    Pca9552PinState state;
> -    uint8_t config_reg;
> -
> -    if (!visit_type_Pca9552PinState(v, name, &state, errp)) {
> -        return;
> -    }
> -    rc = sscanf(name, "pin%2d", &pin);
> -    if (rc != 1) {
> -        error_setg(errp, "%s: error reading %s", __func__, name);
> -        return;
> -    }
> -    if (pin < 0 || pin >= k->pin_count) {
> -        error_setg(errp, "%s invalid pin %s", __func__, name);
> -        return;
> -    }
> -
> -    /* Only input-configured pins can be driven by an external device. */
> -    config_reg = PCA9535_CONFIG0 + (pin / 8);
> -    if (!((s->regs[config_reg] >> (pin % 8)) & 0x1)) {
> -        qemu_log_mask(LOG_UNIMP,
> -                      "%s: pin %d is configured as output, ignoring set\n",
> -                      s->description, pin);
> -        return;
> -    }
> -
> -    pca955x_set_ext_state(s, pin, state != PCA9552_PIN_STATE_LOW);
> -}
> -
>  static const VMStateDescription pca9552_vmstate = {
>      .name = "PCA9552",
>      .version_id = 0,
> @@ -536,26 +421,92 @@ static void pca9535_reset_hold(Object *obj, ResetType type)
>      s->len = 0;
>  }
>  
> +/*
> + * Get the LSx register as the qom interface should expose the device
> + * state, not the modeled 'input line' behaviour which would come from
> + * reading the INPUTx reg
> + */
> +#define DEFINE_LED_ACCESSORS(n)                                              \
> +static int prop_get_led##n(Object *obj, Error **errp)                        \
> +{                                                                            \
> +    PCA955xState *s = PCA955X(obj);                                          \
> +    uint8_t reg = PCA9552_LS0 + (n) / 4;                                     \
> +    return (pca955x_read(s, reg) >> (((n) % 4) * 2)) & 0x3;                  \
> +}                                                                            \
> +static void prop_set_led##n(Object *obj, int val, Error **errp)              \
> +{                                                                            \
> +    PCA955xState *s = PCA955X(obj);                                          \
> +    uint8_t reg = PCA9552_LS0 + (n) / 4;                                     \
> +    uint8_t old = pca955x_read(s, reg);                                      \
> +    pca955x_write(s, reg, pca955x_ledsel(old, (n) % 4, val));                \
> +}
> +
> +QEMU_REPEAT(PCA955X_PIN_COUNT_MAX, DEFINE_LED_ACCESSORS)
> +
> +#define LED_ENUM_PROP(n) {                                              \
> +    .name = "led" #n,                                                   \
> +    .default_value = -1,                                                \
> +    .qapi_type = &Pca9552LedState_type_info,                            \
> +    .get = prop_get_led##n,                                             \
> +    .set = prop_set_led##n,                                             \
> +},
> +
> +static const QapiEnumProp led_enum_props[] = {
> +    QEMU_REPEAT(PCA955X_PIN_COUNT_MAX, LED_ENUM_PROP)
> +};
> +
> +/*
> + * Report the raw pin logic level; polarity inversion is a read-time
> + * transform applied to the INPUT register, not to the pin state
> + * itself.
> + */
> +#define DEFINE_PIN_ACCESSORS(n)                                              \
> +static int prop_get_pin##n(Object *obj, Error **errp)                        \
> +{                                                                            \
> +    PCA955xState *s = PCA955X(obj);                                          \
> +    uint8_t input_reg = PCA9535_INPUT0 + (n) / 8;                            \
> +    return (s->regs[input_reg] >> ((n) % 8)) & 0x1;                          \
> +}                                                                            \
> +static void prop_set_pin##n(Object *obj, int val, Error **errp)              \
> +{                                                                            \
> +    PCA955xState *s = PCA955X(obj);                                          \
> +    uint8_t config_reg = PCA9535_CONFIG0 + (n) / 8;                          \
> +    /* Only input-configured pins can be driven by an external device */     \
> +    if (!((s->regs[config_reg] >> ((n) % 8)) & 0x1)) {                       \
> +        qemu_log_mask(LOG_UNIMP,                                             \
> +                      "%s: pin %d configured as output, ignoring set\n",     \
> +                      s->description, (n));                                  \
> +        return;                                                              \
> +    }                                                                        \
> +    pca955x_set_ext_state(s, (n), val != PCA9552_PIN_STATE_LOW);             \
> +}
> +
> +QEMU_REPEAT(PCA955X_PIN_COUNT_MAX, DEFINE_PIN_ACCESSORS)
> +
> +#define PIN_ENUM_PROP(n) {                                              \
> +    .name = "pin" #n,                                                   \
> +    .default_value = -1,                                                \
> +    .qapi_type = &Pca9552PinState_type_info,                            \
> +    .get = prop_get_pin##n,                                             \
> +    .set = prop_set_pin##n,                                             \
> +},
> +
> +static const QapiEnumProp pin_enum_props[] = {
> +    QEMU_REPEAT(PCA955X_PIN_COUNT_MAX, PIN_ENUM_PROP)
> +};
> +
>  static void pca955x_initfn(Object *obj)
>  {
>      PCA955xClass *k = PCA955X_GET_CLASS(obj);
>  
>      assert(k->pin_count <= PCA955X_PIN_COUNT_MAX);
> +    /* use array/list instead of individual QAPI enum properties */

We could have an explicit TODO instead?

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


