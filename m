Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A528606A329
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iUAdktoj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPQPY-0007zV-Ae; Fri, 06 Nov 2026 15:19:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xPQPW-0007uF-IB; Fri, 06 Nov 2026 15:19:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xPQPT-0006NN-Hq; Fri, 06 Nov 2026 15:19:42 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6IE4cl1545776; Fri, 6 Nov 2026 20:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=wPOdYM0jNzL9UsJgEYHLkTqPm4r9E/G6u5rl0AbzMh4=; b=iUAdktojJVcy
 9jw9w8jFad7juM20YOFbr8VUrnr/Xzw3cFNZgTqg0HygL6tcBWHiFk1oNFLgTpDT
 m3PJnS9Ji682JjqiM12kDwpVsBqx33xPf1doghiNsuEcR2p6kbSNYtKxv8L9ZTk+
 4jW3n0SLini+b2WzlgnAO5uMAdu2UB9RlfI6GM1oExzfzcpYRH5oQkygCVKStaeK
 OqllUfZpapH6ECToIbfqylsSNMYkZqvQlIthynX0DV41jar9yooU9AsZhUNVvbrD
 ZAfkcTdH0Ua+vjcSy4+HFDQD4GstEYgcnkq6Xu7mW0zKtZsdjTEQT0jfTkQ8FLP2
 MpUUg5l9zQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rayy9b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2026 20:19:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6Jsp513878334; Fri, 6 Nov 2026 20:19:36 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrdd7wtpn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2026 20:19:36 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A6KJZce26739320
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Nov 2026 20:19:35 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95B1458063;
 Fri,  6 Nov 2026 20:19:35 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48FB658052;
 Fri,  6 Nov 2026 20:19:35 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Nov 2026 20:19:35 +0000 (GMT)
Message-ID: <1ab5cf21bb22c18d91f62c1ab361fd3222e0b763.camel@linux.ibm.com>
Subject: Re: [PATCH 4/8] hw/gpio/pca9554: New abstract base "pca9554-base"
From: Miles Glenn <milesg@linux.ibm.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 mark.caveayland@nutanix.com
Date: Fri, 06 Nov 2026 14:19:34 -0600
In-Reply-To: <20261106110440.3552588-5-armbru@redhat.com>
References: <20261106110440.3552588-1-armbru@redhat.com>
 <20261106110440.3552588-5-armbru@redhat.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QYDzLcbv c=1 sm=1 tr=0 ts=6aee3659 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=z9yYHbguEQJqE2gG_dcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZHlNWKWVmcUog8Fhpe42NXEe08GRVnCo
X-Proofpoint-ORIG-GUID: ZHlNWKWVmcUog8Fhpe42NXEe08GRVnCo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA4MCBTYWx0ZWRfX/92934bJbzEu
 lpVhsK3lPhxYVckbburPlIH3guP6zTuJAI+/zjttlLWshgEExYRyEjxL2uTivvEL40wMURyS2xd
 2gyDkGOzBLmLMOys7ERoXzWxicr3U5U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA4MCBTYWx0ZWRfXxbrO88JqEXQ8
 Ni9YTFYVtph5AKLAqoS3ipeX47nUVeuVwgdCrAtxGar/GabmLh2T1jOt4j5PZw8/zODn9q7DI27
 9BvXPD6VP8GnioJbKtopUcRlsFBpgnuJzDuRwh1HlvrBno74EkuxwJ2BJOiagOt0ZQYWorHIRgJ
 oxHy4UgpfrFmUP1Z9qz8PqsnQtoTySpaN4OGtB4ilJuzuuqjWmL4Q4DKyDVwO9ssf7JgxSoKTj2
 n6TEUsmgY00LqDov4MmgS4xrLuEOMdEfINAZaoGScBKnVwiOvuPEhUUEDlJa5Q+eCtggQkyJyOf
 TGetGE1S1dQiSkctlijF53OZaD392SO70Tcozxqe0Q59/AYdW+vfaKqS4We0wrb7wj6KO01iG70
 S5xnZj90DcnqNYoQuq0nD6njwoIfxlo8z0D/Tq1D1bSndMvq2oUSbPk6vMFBQbqlVd2lHTrNJvP
 UMUXpmZWCDejwC7/KYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060080
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
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Fri, 2026-11-06 at 12:04 +0100, Markus Armbruster wrote:
> Commit 5eceb48bbe86 (hw/gpio: pca9554: add PCA9536 support) made type
> "pca9535" a child of concrete type "pca9555".  This is inconvenient
> for the next commit.  Make them both children of new abstract type
> "pca9554-base".
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/hw/gpio/pca9554.h |  1 +
>  hw/gpio/pca9554.c         | 55 +++++++++++++++++++++++----------------
>  2 files changed, 33 insertions(+), 23 deletions(-)
> 
> diff --git a/include/hw/gpio/pca9554.h b/include/hw/gpio/pca9554.h
> index 1b33a8a752..0d841ff017 100644
> --- a/include/hw/gpio/pca9554.h
> +++ b/include/hw/gpio/pca9554.h
> @@ -8,6 +8,7 @@
>  #ifndef PCA9554_H
>  #define PCA9554_H
>  
> +#define TYPE_PCA9554_BASE "pca9554-base"
>  #define TYPE_PCA9554 "pca9554"
>  #define TYPE_PCA9536 "pca9536"
>  
> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
> index caa73f63c9..1362b605c2 100644
> --- a/hw/gpio/pca9554.c
> +++ b/hw/gpio/pca9554.c
> @@ -26,7 +26,7 @@
>  #define PCA9554_PIN_COUNT 8
>  #define PCA9536_PIN_COUNT 4
>  
> -OBJECT_DECLARE_TYPE(PCA9554State, PCA9554Class, PCA9554)
> +OBJECT_DECLARE_TYPE(PCA9554State, PCA9554Class, PCA9554_BASE)
>  
>  struct PCA9554State {
>      /*< private >*/
> @@ -58,7 +58,7 @@ static const char *pin_state[] = {"low", "high"};
>  
>  static void pca9554_update_pin_input(PCA9554State *s)
>  {
> -    PCA9554Class *pc = PCA9554_GET_CLASS(s);
> +    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(s);
>      int i;
>      uint8_t config = s->regs[PCA9554_CONFIG];
>      uint8_t output = s->regs[PCA9554_OUTPUT];
> @@ -110,7 +110,7 @@ static uint8_t pca9554_read(PCA9554State *s, uint8_t reg)
>  
>  static void pca9554_write(PCA9554State *s, uint8_t reg, uint8_t data)
>  {
> -    PCA9554Class *pc = PCA9554_GET_CLASS(s);
> +    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(s);
>      uint8_t pin_mask = (1 << pc->pin_count) - 1;
>  
>      /* Variants narrower than 8 bits ignore the unimplemented upper pins. */
> @@ -134,14 +134,14 @@ static void pca9554_write(PCA9554State *s, uint8_t reg, uint8_t data)
>  
>  static uint8_t pca9554_recv(I2CSlave *i2c)
>  {
> -    PCA9554State *s = PCA9554(i2c);
> +    PCA9554State *s = PCA9554_BASE(i2c);
>  
>      return pca9554_read(s, s->pointer & 0x3);
>  }
>  
>  static int pca9554_send(I2CSlave *i2c, uint8_t data)
>  {
> -    PCA9554State *s = PCA9554(i2c);
> +    PCA9554State *s = PCA9554_BASE(i2c);
>  
>      /* First byte sent by is the register address */
>      if (s->len == 0) {
> @@ -156,7 +156,7 @@ static int pca9554_send(I2CSlave *i2c, uint8_t data)
>  
>  static int pca9554_event(I2CSlave *i2c, enum i2c_event event)
>  {
> -    PCA9554State *s = PCA9554(i2c);
> +    PCA9554State *s = PCA9554_BASE(i2c);
>  
>      s->len = 0;
>      return 0;
> @@ -173,7 +173,7 @@ static void pca9554_set_ext_state(PCA9554State *s, int pin, int level)
>  static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
>                              void *opaque, Error **errp)
>  {
> -    PCA9554State *s = PCA9554(obj);
> +    PCA9554State *s = PCA9554_BASE(obj);
>      int pin, rc;
>      uint8_t state;
>  
> @@ -182,7 +182,7 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
>          error_setg(errp, "%s: error reading %s", __func__, name);
>          return;
>      }
> -    if (pin < 0 || pin >= PCA9554_GET_CLASS(s)->pin_count) {
> +    if (pin < 0 || pin >= PCA9554_BASE_GET_CLASS(s)->pin_count) {
>          error_setg(errp, "%s invalid pin %s", __func__, name);
>          return;
>      }
> @@ -200,7 +200,7 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
>  static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
>                              void *opaque, Error **errp)
>  {
> -    PCA9554State *s = PCA9554(obj);
> +    PCA9554State *s = PCA9554_BASE(obj);
>      int pin, rc, val;
>      uint8_t state, mask;
>      g_autofree char *state_str = NULL;
> @@ -213,7 +213,7 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
>          error_setg(errp, "%s: error reading %s", __func__, name);
>          return;
>      }
> -    if (pin < 0 || pin >= PCA9554_GET_CLASS(s)->pin_count) {
> +    if (pin < 0 || pin >= PCA9554_BASE_GET_CLASS(s)->pin_count) {
>          error_setg(errp, "%s invalid pin %s", __func__, name);
>          return;
>      }
> @@ -274,8 +274,8 @@ static const VMStateDescription pca9554_vmstate = {
>  
>  static void pca9554_reset(DeviceState *dev)
>  {
> -    PCA9554State *s = PCA9554(dev);
> -    PCA9554Class *pc = PCA9554_GET_CLASS(s);
> +    PCA9554State *s = PCA9554_BASE(dev);
> +    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(s);
>      uint8_t pin_mask = (1 << pc->pin_count) - 1;
>  
>      s->regs[PCA9554_INPUT] = pin_mask;
> @@ -292,7 +292,7 @@ static void pca9554_reset(DeviceState *dev)
>  
>  static void pca9554_initfn(Object *obj)
>  {
> -    PCA9554Class *pc = PCA9554_GET_CLASS(obj);
> +    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(obj);
>      int pin;
>  
>      for (pin = 0; pin < pc->pin_count; pin++) {
> @@ -308,8 +308,8 @@ static void pca9554_initfn(Object *obj)
>  
>  static void pca9554_gpio_in_handler(void *opaque, int pin, int level)
>  {
> -    PCA9554State *s = PCA9554(opaque);
> -    PCA9554Class *pc = PCA9554_GET_CLASS(s);
> +    PCA9554State *s = PCA9554_BASE(opaque);
> +    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(s);
>  
>      assert((pin >= 0) && (pin < pc->pin_count));
>      pca9554_set_ext_state(s, pin, level);
> @@ -317,8 +317,8 @@ static void pca9554_gpio_in_handler(void *opaque, int pin, int level)
>  
>  static void pca9554_realize(DeviceState *dev, Error **errp)
>  {
> -    PCA9554State *s = PCA9554(dev);
> -    PCA9554Class *pc = PCA9554_GET_CLASS(s);
> +    PCA9554State *s = PCA9554_BASE(dev);
> +    PCA9554Class *pc = PCA9554_BASE_GET_CLASS(s);
>  
>      if (!s->description) {
>          s->description = g_strdup(object_get_typename(OBJECT(dev)));
> @@ -333,11 +333,10 @@ static const Property pca9554_properties[] = {
>      DEFINE_PROP_BOOL("hw-dir", PCA9554State, hw_dir, false),
>  };
>  
> -static void pca9554_class_init(ObjectClass *klass, const void *data)
> +static void pca9554_base_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> -    PCA9554Class *pc = PCA9554_CLASS(klass);
>  
>      k->event = pca9554_event;
>      k->recv = pca9554_recv;
> @@ -346,26 +345,36 @@ static void pca9554_class_init(ObjectClass *klass, const void *data)
>      device_class_set_legacy_reset(dc, pca9554_reset);
>      dc->vmsd = &pca9554_vmstate;
>      device_class_set_props(dc, pca9554_properties);
> +}
> +
> +static void pca9554_class_init(ObjectClass *klass, const void *data)
> +{
> +    PCA9554Class *pc = PCA9554_BASE_CLASS(klass);
>  
>      pc->pin_count = PCA9554_PIN_COUNT;
>  }
>  
>  static void pca9536_class_init(ObjectClass *klass, const void *data)
>  {
> -    PCA9554Class *pc = PCA9554_CLASS(klass);
> +    PCA9554Class *pc = PCA9554_BASE_CLASS(klass);
>  
>      pc->pin_count = PCA9536_PIN_COUNT;
>  }
>  
>  static const TypeInfo pca9554_types[] = {
>      {
> -        .name          = TYPE_PCA9554,
> +        .name          = TYPE_PCA9554_BASE,
>          .parent        = TYPE_I2C_SLAVE,
>          .instance_init = pca9554_initfn,
>          .instance_size = sizeof(PCA9554State),
> -        .class_init    = pca9554_class_init,
> +        .class_init    = pca9554_base_class_init,
>          .class_size    = sizeof(PCA9554Class),
> -        .abstract      = false,
> +        .abstract      = true,
> +    },
> +    {
> +        .name          = TYPE_PCA9554,
> +        .parent        = TYPE_PCA9554_BASE,
> +        .class_init    = pca9554_class_init,
>      },
>      {
>          .name          = TYPE_PCA9536,


