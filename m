Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA5F606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mWQ+kM4S
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPQQp-0000XV-E8; Fri, 06 Nov 2026 15:21:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xPQQh-0000RF-Jl; Fri, 06 Nov 2026 15:20:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xPQQd-0006ey-R9; Fri, 06 Nov 2026 15:20:54 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6IE3Me3163556; Fri, 6 Nov 2026 20:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=FEISDRryYb8TeaGPVAArTDQfdqP26bb6k+dAVwYE0Jk=; b=mWQ+kM4SBto3
 G/1x2cfI39e1jrtuFGtKhQoa09T113sj+kMRRfH2W2TTPKfONJcNZ3AZeps9F48t
 YADTuhiGyJLfkFbFaZsK3cdpzcU6zTzp5GWassPcu3HINy/YEhccqCWNQvgDVjOj
 D20iXtHaZVjetApoGD9+ErDbBhzj5VM0CWYtyIZNmXdyZ4rIYNANsQ558oZBGPm+
 tiS8u1O1bBZPGOV1dkuAdSUkAl7jP/YZSBpussxFwHP7LPOqLESzo+mvs5s9Zrh2
 SG6OySLKeglSwP675QT/4AipCL32yxIxuqwl/Qt2Tl8ZCn5w+JSsxqQ2aYYBpL+/
 4uV6vHZIcA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3r97xvh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2026 20:20:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6Jtgjk3846094; Fri, 6 Nov 2026 20:20:49 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrka74c8h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2026 20:20:49 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A6KKmFj25887234
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Nov 2026 20:20:48 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D2F858052;
 Fri,  6 Nov 2026 20:20:48 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B642658050;
 Fri,  6 Nov 2026 20:20:47 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Nov 2026 20:20:47 +0000 (GMT)
Message-ID: <fc3a07e4cb5c3ca3cb9b938a12d6f3d090d17c70.camel@linux.ibm.com>
Subject: Re: [PATCH 6/8] hw/gpio/pca955x: use QAPI enums for led and pin
 properties
From: Miles Glenn <milesg@linux.ibm.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 mark.caveayland@nutanix.com
Date: Fri, 06 Nov 2026 14:20:47 -0600
In-Reply-To: <20261106110440.3552588-7-armbru@redhat.com>
References: <20261106110440.3552588-1-armbru@redhat.com>
 <20261106110440.3552588-7-armbru@redhat.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=O86sLx9W c=1 sm=1 tr=0 ts=6aee36a1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=Raa5M48fUtmArTz79JIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3p6t_DI9OjuprH8icP52HCluiLwsPxbE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA4MCBTYWx0ZWRfXxV/Y5aI2UH1j
 3FzKadMRJ9zJ4Hnj+2JK1kjmCyrTMGWeQiCiqzX90fZdNw2rLJ6ksoxFTPfFivAtaH1q/F8aEDi
 JhCPn1e52s795O7hc89Ud9+LxE5IruB7UPseT8pu+HtQXr6D1cCJY+OTFcdG1cY6rp5ADBVrEk9
 zNtDok9LO5+jLrCo2M5obGmtnP074M7QzWcMr34AVsckTHsrKxzthHHuynUKu80bQL2z4rCc3OT
 XPQlBRsNRuvk1lvalyu+U64h7sBUfGEpdJos/mwovf16CYPo4/EBOoZwyoZ67zrezZikOOggWBa
 PU10GEl7LqvreC0K5PwaRhxYWanlPTdZXZlTxOeTtPrlV1VwPLDfCRTPyNf4RBRI369HIyS6NyR
 qAhqP+EOtkOUf/ciy1/39G9onI6Ap1nOhEz8/sDMR/HZLnFA/WYCkjIK/ZAkA7LHNHuZywLMlnt
 IyKReB/WZcZ/hxXy+Hg==
X-Proofpoint-GUID: 3p6t_DI9OjuprH8icP52HCluiLwsPxbE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA4MCBTYWx0ZWRfXxE5PCRfm34Kp
 ltzkdjcfYAoau0ixmr9qSxotGGXqIpMSeg2TzRRrqdTLe3fMk8twFwwq5e7zSAYmc6e5Ja4w2Jz
 sd93Wb9IWwnKrU/ub1AUQgbXh2wJIRI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060080
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: milesg@linux.ibm.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Fri, 2026-11-06 at 12:04 +0100, Markus Armbruster wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Replace hand-rolled string lookup tables with QAPI enums
> Pca9552LedState and GpioPinState for the led%d and pin%d QOM
> properties. This lets QAPI handle string-to-enum conversion in the
> visitor, removing the manual string matching in the setters.
> 
> Add QEMU_BUILD_BUG_ON guards to ensure the QAPI-generated enum values
> stay in sync with the hardware register encoding.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi/machine.json | 29 ++++++++++++++++++
>  hw/gpio/pca9552.c | 76 +++++++++++++++++------------------------------
>  hw/gpio/pca9554.c | 35 ++++++++--------------
>  3 files changed, 69 insertions(+), 71 deletions(-)
> 
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 18d9dce849..c4c8720909 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -416,6 +416,35 @@
>  { 'enum': 'LostTickPolicy',
>    'data': ['discard', 'delay', 'slew' ] }
>  
> +##
> +# @GpioPinState:
> +#
> +# @low: Pin low
> +#
> +# @high: Pin high
> +#
> +# Since: 12.0
> +##
> +{ 'enum': 'GpioPinState',
> +  'data': ['low', 'high'] }
> +
> +##
> +# @Pca9552LedState:
> +#     LED state for PCA9552.
> +#
> +# @on: LED on
> +#
> +# @off: LED off
> +#
> +# @pwm0: LED controlled by PWM0
> +#
> +# @pwm1: LED controlled by PWM1
> +#
> +# Since: 12.0
> +##
> +{ 'enum': 'Pca9552LedState',
> +  'data': ['on', 'off', 'pwm0', 'pwm1'] }
> +
>  ##
>  # @PCSouthBridgeOption:
>  #     South bridge chipset option for PC i440FX machines.
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index 65a718ef31..99c4e0c0e2 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -24,6 +24,7 @@
>  #include "migration/vmstate.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-builtin-type-infos.h"
> +#include "qapi/qapi-visit-machine.h"
>  #include "qapi/visitor.h"
>  #include "trace.h"
>  #include "qom/object.h"
> @@ -60,16 +61,15 @@ struct PCA955xClass {
>  /*
>   * Note:  The LED_ON and LED_OFF configuration values for the PCA955X
>   *        chips are the reverse of the PCA953X family of chips.
> + *
> + * The QAPI enums must match the hardware register values.
>   */
> -#define PCA9552_LED_ON   0x0
> -#define PCA9552_LED_OFF  0x1
> -#define PCA9552_LED_PWM0 0x2
> -#define PCA9552_LED_PWM1 0x3
> -#define PCA9552_PIN_LOW  0x0
> -#define PCA9552_PIN_HIZ  0x1
> -
> -static const char *led_state[] = {"on", "off", "pwm0", "pwm1"};
> -static const char *pin_state[] = {"low", "high"};
> +QEMU_BUILD_BUG_ON(PCA9552_LED_STATE_ON != 0x0);
> +QEMU_BUILD_BUG_ON(PCA9552_LED_STATE_OFF != 0x1);
> +QEMU_BUILD_BUG_ON(PCA9552_LED_STATE_PWM0 != 0x2);
> +QEMU_BUILD_BUG_ON(PCA9552_LED_STATE_PWM1 != 0x3);
> +QEMU_BUILD_BUG_ON(GPIO_PIN_STATE_LOW != 0x0);
> +QEMU_BUILD_BUG_ON(GPIO_PIN_STATE_HIGH != 0x1);
>  
>  static uint8_t pca955x_pin_get_config(PCA955xState *s, int pin)
>  {
> @@ -143,24 +143,24 @@ static void pca955x_update_pin_input(PCA955xState *s)
>              uint8_t config = pca955x_pin_get_config(s, i);
>  
>              switch (config) {
> -            case PCA9552_LED_ON:
> +            case PCA9552_LED_STATE_ON:
>                  /* Pin is set to 0V to turn on LED */
>                  s->regs[input_reg] &= ~bit_mask;
>                  break;
> -            case PCA9552_LED_OFF:
> +            case PCA9552_LED_STATE_OFF:
>                  /*
>                   * Pin is set to Hi-Z to turn off LED and
>                   * pullup sets it to a logical 1 unless
>                   * external device drives it low.
>                   */
> -                if (s->ext_state[i] == PCA9552_PIN_LOW) {
> +                if (s->ext_state[i] == GPIO_PIN_STATE_LOW) {
>                      s->regs[input_reg] &= ~bit_mask;
>                  } else {
>                      s->regs[input_reg] |=  bit_mask;
>                  }
>                  break;
> -            case PCA9552_LED_PWM0:
> -            case PCA9552_LED_PWM1:
> +            case PCA9552_LED_STATE_PWM0:
> +            case PCA9552_LED_STATE_PWM1:
>                  /* TODO */
>              default:
>                  break;
> @@ -177,7 +177,7 @@ static void pca955x_update_pin_input(PCA955xState *s)
>               */
>              if (s->regs[config_reg] & bit_mask) {
>                  /* Input mode - reflect external state */
> -                if (s->ext_state[i] == PCA9552_PIN_LOW) {
> +                if (s->ext_state[i] == GPIO_PIN_STATE_LOW) {
>                      s->regs[input_reg] &= ~bit_mask;
>                  } else {
>                      s->regs[input_reg] |= bit_mask;
> @@ -361,7 +361,7 @@ static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
>      PCA955xClass *k = PCA955X_GET_CLASS(obj);
>      PCA955xState *s = PCA955X(obj);
>      int led, rc, reg;
> -    uint8_t state;
> +    Pca9552LedState state;
>  
>      rc = sscanf(name, "led%2d", &led);
>      if (rc != 1) {
> @@ -379,7 +379,7 @@ static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
>       */
>      reg = PCA9552_LS0 + led / 4;
>      state = (pca955x_read(s, reg) >> ((led % 4) * 2)) & 0x3;
> -    visit_type_str(v, name, (char **)&led_state[state], errp);
> +    visit_type_Pca9552LedState(v, name, &state, errp);
>  }
>  
>  /*
> @@ -398,10 +398,9 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
>      PCA955xClass *k = PCA955X_GET_CLASS(obj);
>      PCA955xState *s = PCA955X(obj);
>      int led, rc, reg, val;
> -    uint8_t state;
> -    g_autofree char *state_str = NULL;
> +    Pca9552LedState state;
>  
> -    if (!visit_type_str(v, name, &state_str, errp)) {
> +    if (!visit_type_Pca9552LedState(v, name, &state, errp)) {
>          return;
>      }
>      rc = sscanf(name, "led%2d", &led);
> @@ -414,16 +413,6 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
>          return;
>      }
>  
> -    for (state = 0; state < ARRAY_SIZE(led_state); state++) {
> -        if (!strcmp(state_str, led_state[state])) {
> -            break;
> -        }
> -    }
> -    if (state >= ARRAY_SIZE(led_state)) {
> -        error_setg(errp, "%s invalid led state %s", __func__, state_str);
> -        return;
> -    }
> -
>      reg = PCA9552_LS0 + led / 4;
>      val = pca955x_read(s, reg);
>      val = pca955x_ledsel(val, led % 4, state);
> @@ -438,7 +427,8 @@ static void pca955x_get_pin(Object *obj, Visitor *v, const char *name,
>      PCA955xClass *k = PCA955X_GET_CLASS(obj);
>      PCA955xState *s = PCA955X(obj);
>      int pin, rc;
> -    uint8_t input_reg, state;
> +    uint8_t input_reg;
> +    GpioPinState state;
>  
>      rc = sscanf(name, "pin%2d", &pin);
>      if (rc != 1) {
> @@ -456,7 +446,7 @@ static void pca955x_get_pin(Object *obj, Visitor *v, const char *name,
>       */
>      input_reg = PCA9535_INPUT0 + (pin / 8);
>      state = (s->regs[input_reg] >> (pin % 8)) & 0x1;
> -    visit_type_str(v, name, (char **)&pin_state[state], errp);
> +    visit_type_GpioPinState(v, name, &state, errp);
>  }
>  
>  static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
> @@ -465,10 +455,10 @@ static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
>      PCA955xClass *k = PCA955X_GET_CLASS(obj);
>      PCA955xState *s = PCA955X(obj);
>      int pin, rc;
> -    uint8_t state, config_reg;
> -    g_autofree char *state_str = NULL;
> +    GpioPinState state;
> +    uint8_t config_reg;
>  
> -    if (!visit_type_str(v, name, &state_str, errp)) {
> +    if (!visit_type_GpioPinState(v, name, &state, errp)) {
>          return;
>      }
>      rc = sscanf(name, "pin%2d", &pin);
> @@ -481,16 +471,6 @@ static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
>          return;
>      }
>  
> -    for (state = 0; state < ARRAY_SIZE(pin_state); state++) {
> -        if (!strcmp(state_str, pin_state[state])) {
> -            break;
> -        }
> -    }
> -    if (state >= ARRAY_SIZE(pin_state)) {
> -        error_setg(errp, "%s invalid pin state %s", __func__, state_str);
> -        return;
> -    }
> -
>      /* Only input-configured pins can be driven by an external device. */
>      config_reg = PCA9535_CONFIG0 + (pin / 8);
>      if (!((s->regs[config_reg] >> (pin % 8)) & 0x1)) {
> @@ -500,7 +480,7 @@ static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
>          return;
>      }
>  
> -    pca955x_set_ext_state(s, pin, state != PCA9552_PIN_LOW);
> +    pca955x_set_ext_state(s, pin, state != GPIO_PIN_STATE_LOW);
>  }
>  
>  static const VMStateDescription pca9552_vmstate = {
> @@ -530,7 +510,7 @@ static void pca9552_reset_hold(Object *obj, ResetType type)
>      s->regs[PCA9552_LS2] = 0x55;
>      s->regs[PCA9552_LS3] = 0x55;
>  
> -    memset(s->ext_state, PCA9552_PIN_HIZ, PCA955X_PIN_COUNT_MAX);
> +    memset(s->ext_state, GPIO_PIN_STATE_HIGH, PCA955X_PIN_COUNT_MAX);
>      pca955x_update_pin_input(s);
>  
>      s->pointer = 0xFF;
> @@ -550,7 +530,7 @@ static void pca9535_reset_hold(Object *obj, ResetType type)
>      s->regs[PCA9535_CONFIG0] = 0xFF;  /* All pins as inputs */
>      s->regs[PCA9535_CONFIG1] = 0xFF;  /* All pins as inputs */
>  
> -    memset(s->ext_state, PCA9552_PIN_HIZ, PCA955X_PIN_COUNT_MAX);
> +    memset(s->ext_state, GPIO_PIN_STATE_HIGH, PCA955X_PIN_COUNT_MAX);
>      pca955x_update_pin_input(s);
>  
>      s->pointer = 0xFF;
> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
> index ed304e4639..7bbfd5ed5f 100644
> --- a/hw/gpio/pca9554.c
> +++ b/hw/gpio/pca9554.c
> @@ -18,6 +18,7 @@
>  #include "migration/vmstate.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-builtin-type-infos.h"
> +#include "qapi/qapi-visit-machine.h"
>  #include "qapi/visitor.h"
>  #include "trace.h"
>  #include "qom/object.h"
> @@ -51,10 +52,8 @@ struct PCA9554Class {
>      uint8_t pin_count;
>  };
>  
> -#define PCA9554_PIN_LOW  0x0
> -#define PCA9554_PIN_HIZ  0x1
> -
> -static const char *pin_state[] = {"low", "high"};
> +QEMU_BUILD_BUG_ON(GPIO_PIN_STATE_LOW != 0x0);
> +QEMU_BUILD_BUG_ON(GPIO_PIN_STATE_HIGH != 0x1);
>  
>  static void pca9554_update_pin_input(PCA9554State *s)
>  {
> @@ -73,7 +72,7 @@ static void pca9554_update_pin_input(PCA9554State *s)
>               * Input: the pin is Hi-Z with a pull-up, so it reads high
>               * unless an external device drives it low.
>               */
> -            if (s->ext_state[i] == PCA9554_PIN_LOW) {
> +            if (s->ext_state[i] == GPIO_PIN_STATE_LOW) {
>                  s->regs[PCA9554_INPUT] &= ~bit_mask;
>              } else {
>                  s->regs[PCA9554_INPUT] |= bit_mask;
> @@ -175,7 +174,7 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
>  {
>      PCA9554State *s = PCA9554_BASE(obj);
>      int pin, rc;
> -    uint8_t state;
> +    GpioPinState state;
>  
>      rc = sscanf(name, "pin%2d", &pin);
>      if (rc != 1) {
> @@ -194,7 +193,7 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
>       * holds the wire level regardless of the configured direction.
>       */
>      state = (s->regs[PCA9554_INPUT] >> pin) & 0x1;
> -    visit_type_str(v, name, (char **)&pin_state[state], errp);
> +    visit_type_GpioPinState(v, name, &state, errp);
>  }
>  
>  static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
> @@ -202,10 +201,10 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
>  {
>      PCA9554State *s = PCA9554_BASE(obj);
>      int pin, rc, val;
> -    uint8_t state, mask;
> -    g_autofree char *state_str = NULL;
> +    uint8_t mask;
> +    GpioPinState state;
>  
> -    if (!visit_type_str(v, name, &state_str, errp)) {
> +    if (!visit_type_GpioPinState(v, name, &state, errp)) {
>          return;
>      }
>      rc = sscanf(name, "pin%2d", &pin);
> @@ -218,16 +217,6 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
>          return;
>      }
>  
> -    for (state = 0; state < ARRAY_SIZE(pin_state); state++) {
> -        if (!strcmp(state_str, pin_state[state])) {
> -            break;
> -        }
> -    }
> -    if (state >= ARRAY_SIZE(pin_state)) {
> -        error_setg(errp, "%s invalid pin state %s", __func__, state_str);
> -        return;
> -    }
> -
>      if (s->hw_dir) {
>          /* Warn and ignore if the guest has configured this pin as output */
>          if (!((s->regs[PCA9554_CONFIG] >> pin) & 0x1)) {
> @@ -238,13 +227,13 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
>              return;
>          }
>          /* Drive the external input level */
> -        pca9554_set_ext_state(s, pin, state != PCA9554_PIN_LOW);
> +        pca9554_set_ext_state(s, pin, state != GPIO_PIN_STATE_LOW);
>      } else {
>          /* Legacy behavior: force output mode and drive */
>          /* First, modify the output register bit */
>          val = pca9554_read(s, PCA9554_OUTPUT);
>          mask = 0x1 << pin;
> -        if (state == PCA9554_PIN_LOW) {
> +        if (state == GPIO_PIN_STATE_LOW) {
>              val &= ~(mask);
>          } else {
>              val |= mask;
> @@ -283,7 +272,7 @@ static void pca9554_reset(DeviceState *dev)
>      s->regs[PCA9554_POLARITY] = 0x0; /* No pins are inverted */
>      s->regs[PCA9554_CONFIG] = pin_mask; /* All pins are inputs */
>  
> -    memset(s->ext_state, PCA9554_PIN_HIZ, pc->pin_count);
> +    memset(s->ext_state, GPIO_PIN_STATE_HIGH, pc->pin_count);
>      pca9554_update_pin_input(s);
>  
>      s->pointer = 0x0;


