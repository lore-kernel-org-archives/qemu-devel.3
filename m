Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8CF606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kA/rvBXk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPQRe-0002Bt-Qz; Fri, 06 Nov 2026 15:21:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xPQRd-0002BU-3F; Fri, 06 Nov 2026 15:21:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xPQRb-0006j0-AA; Fri, 06 Nov 2026 15:21:52 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6Jf7oM3108649; Fri, 6 Nov 2026 20:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=LG1kySKTFxMhFk6IMykvGfTEp+xNXOqoDlESPumxO9U=; b=kA/rvBXknyx6
 o/BiiLhqHoyav4lXW7TrP/urtIL2oZrX3iUFWfDxJoLbIvNiIQQmHoYxrju7B7A1
 wa+NClxo6MzZKn7eab4qZ+wGSr3DHnc1hjq1k2F282c+qQo0mh65MR/aFtMePWkN
 j1wqq14hsaI6prgcqgXHFHN6Xcfz6l63SaPUYT3y51pVN0gsupUJWTXmtuHT7vJ4
 UDOtwzjNAOG823wokgUr0uYYAWVVPcUidco+BGkxj1CRP0kQI6bo4VN+Wqbpnvv7
 w2fCQVMwkOlvdxUYOm4ziSsxxkJB7yGZkHSXNc2OxalOMk/dEM5t4Hw/sDBn/6+n
 PG3fCa1HTQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rc7v01-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2026 20:21:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6JphFH3846117; Fri, 6 Nov 2026 20:21:48 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrka74cd5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2026 20:21:48 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A6KKwf625690624
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Nov 2026 20:20:59 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D5B658050;
 Fri,  6 Nov 2026 20:21:48 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 748E758052;
 Fri,  6 Nov 2026 20:21:47 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Nov 2026 20:21:47 +0000 (GMT)
Message-ID: <83e1e0ffe5e9fc53d1105a55b9da47d54e271295.camel@linux.ibm.com>
Subject: Re: [PATCH 8/8] hw/gpio/pca955x: Simplify pin and led getters and
 setters
From: Miles Glenn <milesg@linux.ibm.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 mark.caveayland@nutanix.com
Date: Fri, 06 Nov 2026 14:21:47 -0600
In-Reply-To: <20261106110440.3552588-9-armbru@redhat.com>
References: <20261106110440.3552588-1-armbru@redhat.com>
 <20261106110440.3552588-9-armbru@redhat.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA4MCBTYWx0ZWRfX8tF6SSOhTPve
 UsNTzNU2y4kWl8X2Tt5HgFHrbRfNiuuq4KoJfsXdfnlpkEf1KlsofrjrHFM2VZf8nPyybkERSxo
 1BL66IzGJZbmfo/t0fQdjH4g2fB3jy0=
X-Proofpoint-GUID: hwsY96jTW3TUeYxE-jKLhp6Eli8w9uSi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA4MCBTYWx0ZWRfX74NL593rv8/P
 tSuZdULzP1hRCWLbNkuigJ0S/3Xc/HAAC4bI4oU0msq51GE1Cq7CbfS0EelbOOcbywvW/bOEkVi
 tT6+OFF4u7JaWuB0nw3GmxGxhAgZbojb2x8+2WmQeqSPtAB4t7q+ZYbGFekbOINzgy3qLmRAfsi
 sAkvU44aXUhqkSptn2SlpJc2gItVxWvNrkAL7+uTG+k4tZBB3tjdIKsun24ZrK/Nv70HQJ8uXMr
 uqWWuSr4gLGBw6zmq7kg0WfBTFQFiFEimRLv1LMZwfC+F/G+aCBSEB8x8Rya6dg6Wf/p+LBINqJ
 60SE4/Z5TzusF/6YbKkjJqlznd7B97lwSmblHpVzKPwBZc5UVEcfokXls8HXCiyudVjCEx58BQ8
 YRxhQuaD+zO2rHcPs+XMLzCidVelQepphqq8/zVEH0fchaPai6DE0sD1q5kLiuoQ+cPEFw8bAQI
 4+Pv7YZJ1KWlvGaaeyQ==
X-Proofpoint-ORIG-GUID: hwsY96jTW3TUeYxE-jKLhp6Eli8w9uSi
X-Authority-Analysis: v=2.4 cv=CY+dd7rl c=1 sm=1 tr=0 ts=6aee36dd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=qoX-1xD-VHzSJV1cSEAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060080
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
> Pass the index via object_class_property_add() parameter @opaque
> instead extracting it from the property name.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/gpio/pca9552.c | 60 ++++++++++++++---------------------------------
>  hw/gpio/pca9554.c | 30 +++++++-----------------
>  2 files changed, 25 insertions(+), 65 deletions(-)
> 
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index f97ad6d083..c8d0e9a16d 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -360,18 +360,12 @@ static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
>  {
>      PCA955xClass *k = PCA955X_GET_CLASS(obj);
>      PCA955xState *s = PCA955X(obj);
> -    int led, rc, reg;
> +    uintptr_t led = (uintptr_t)opaque;
> +    int reg;
>      Pca9552LedState state;
>  
> -    rc = sscanf(name, "led%2d", &led);
> -    if (rc != 1) {
> -        error_setg(errp, "%s: error reading %s", __func__, name);
> -        return;
> -    }
> -    if (led < 0 || led >= k->pin_count) {
> -        error_setg(errp, "%s: invalid led %s", __func__, name);
> -        return;
> -    }
> +    assert(led < k->pin_count);
> +
>      /*
>       * Get the LSx register as the qom interface should expose the device
>       * state, not the modeled 'input line' behaviour which would come from
> @@ -397,21 +391,15 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
>  {
>      PCA955xClass *k = PCA955X_GET_CLASS(obj);
>      PCA955xState *s = PCA955X(obj);
> -    int led, rc, reg, val;
> +    uintptr_t led = (uintptr_t)opaque;
> +    int reg, val;
>      Pca9552LedState state;
>  
> +    assert(led < k->pin_count);
> +
>      if (!visit_type_Pca9552LedState(v, name, &state, errp)) {
>          return;
>      }
> -    rc = sscanf(name, "led%2d", &led);
> -    if (rc != 1) {
> -        error_setg(errp, "%s: error reading %s", __func__, name);
> -        return;
> -    }
> -    if (led < 0 || led >= k->pin_count) {
> -        error_setg(errp, "%s: invalid led %s", __func__, name);
> -        return;
> -    }
>  
>      reg = PCA9552_LS0 + led / 4;
>      val = pca955x_read(s, reg);
> @@ -426,19 +414,11 @@ static void pca955x_get_pin(Object *obj, Visitor *v, const char *name,
>  {
>      PCA955xClass *k = PCA955X_GET_CLASS(obj);
>      PCA955xState *s = PCA955X(obj);
> -    int pin, rc;
> +    uintptr_t pin = (uintptr_t)opaque;
>      uint8_t input_reg;
>      GpioPinState state;
>  
> -    rc = sscanf(name, "pin%2d", &pin);
> -    if (rc != 1) {
> -        error_setg(errp, "%s: error reading %s", __func__, name);
> -        return;
> -    }
> -    if (pin < 0 || pin >= k->pin_count) {
> -        error_setg(errp, "%s invalid pin %s", __func__, name);
> -        return;
> -    }
> +    assert(pin < k->pin_count);
>  
>      /*
>       * Report the raw pin logic level; polarity inversion is a read-time
> @@ -454,28 +434,22 @@ static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
>  {
>      PCA955xClass *k = PCA955X_GET_CLASS(obj);
>      PCA955xState *s = PCA955X(obj);
> -    int pin, rc;
> +    uintptr_t pin = (uintptr_t)opaque;
>      GpioPinState state;
>      uint8_t config_reg;
>  
> +    assert(pin < k->pin_count);
> +
>      if (!visit_type_GpioPinState(v, name, &state, errp)) {
>          return;
>      }
> -    rc = sscanf(name, "pin%2d", &pin);
> -    if (rc != 1) {
> -        error_setg(errp, "%s: error reading %s", __func__, name);
> -        return;
> -    }
> -    if (pin < 0 || pin >= k->pin_count) {
> -        error_setg(errp, "%s invalid pin %s", __func__, name);
> -        return;
> -    }
>  
>      /* Only input-configured pins can be driven by an external device. */
>      config_reg = PCA9535_CONFIG0 + (pin / 8);
>      if (!((s->regs[config_reg] >> (pin % 8)) & 0x1)) {
>          qemu_log_mask(LOG_UNIMP,
> -                      "%s: pin %d is configured as output, ignoring set\n",
> +                      "%s: pin %" PRIdPTR " is configured as output, "
> +                      "ignoring set\n",
>                        s->description, pin);
>          return;
>      }
> @@ -549,14 +523,14 @@ static void pca955x_pin_init(PCA955xClass *k)
>              object_class_property_add(OBJECT_CLASS(k), name,
>                                        "str", &Pca9552LedState_type_info,
>                                        pca955x_get_led, pca955x_set_led,
> -                                      NULL, NULL);
> +                                      NULL, (void *)(uintptr_t)ix);
>          } else {
>              /* GPIO variant: expose the pin logic level as pin%d. */
>              name = g_strdup_printf("pin%d", ix);
>              object_class_property_add(OBJECT_CLASS(k), name,
>                                        "str", &GpioPinState_type_info,
>                                        pca955x_get_pin, pca955x_set_pin,
> -                                      NULL, NULL);
> +                                      NULL, (void *)(uintptr_t)ix);
>          }
>          g_free(name);
>      }
> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
> index e2d481866f..d987b16cd0 100644
> --- a/hw/gpio/pca9554.c
> +++ b/hw/gpio/pca9554.c
> @@ -173,18 +173,10 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
>                              void *opaque, Error **errp)
>  {
>      PCA9554State *s = PCA9554_BASE(obj);
> -    int pin, rc;
> +    uintptr_t pin = (uintptr_t)opaque;
>      GpioPinState state;
>  
> -    rc = sscanf(name, "pin%2d", &pin);
> -    if (rc != 1) {
> -        error_setg(errp, "%s: error reading %s", __func__, name);
> -        return;
> -    }
> -    if (pin < 0 || pin >= PCA9554_BASE_GET_CLASS(s)->pin_count) {
> -        error_setg(errp, "%s invalid pin %s", __func__, name);
> -        return;
> -    }
> +    assert(pin < PCA9554_BASE_GET_CLASS(s)->pin_count);
>  
>      /*
>       * Report the physical pin level. The input register is kept in sync by
> @@ -200,28 +192,22 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
>                              void *opaque, Error **errp)
>  {
>      PCA9554State *s = PCA9554_BASE(obj);
> -    int pin, rc, val;
> +    uintptr_t pin = (uintptr_t)opaque;
> +    int val;
>      uint8_t mask;
>      GpioPinState state;
>  
> +    assert(pin < PCA9554_BASE_GET_CLASS(s)->pin_count);
> +
>      if (!visit_type_GpioPinState(v, name, &state, errp)) {
>          return;
>      }
> -    rc = sscanf(name, "pin%2d", &pin);
> -    if (rc != 1) {
> -        error_setg(errp, "%s: error reading %s", __func__, name);
> -        return;
> -    }
> -    if (pin < 0 || pin >= PCA9554_BASE_GET_CLASS(s)->pin_count) {
> -        error_setg(errp, "%s invalid pin %s", __func__, name);
> -        return;
> -    }
>  
>      if (s->hw_dir) {
>          /* Warn and ignore if the guest has configured this pin as output */
>          if (!((s->regs[PCA9554_CONFIG] >> pin) & 0x1)) {
>              qemu_log_mask(LOG_UNIMP,
> -                          "%s: pin %d is configured as output, "
> +                          "%s: pin %" PRIdPTR " is configured as output, "
>                            "ignoring external set\n",
>                            s->description, pin);
>              return;
> @@ -290,7 +276,7 @@ static void pca9554_pin_init(PCA9554Class *pc)
>          object_class_property_add(OBJECT_CLASS(pc), name,
>                                    "str", &GpioPinState_type_info,
>                                    pca9554_get_pin, pca9554_set_pin,
> -                                  NULL, NULL);
> +                                  NULL, (void *)(uintptr_t)pin);
>          g_free(name);
>      }
>  }


