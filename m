Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7EA606A33E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d0k5iNsk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ3Qf-0003BV-4e; Tue, 20 Oct 2026 02:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ3QT-00039I-SO
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:34:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ3QS-0007yC-7E
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792478059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xBWbigaKrFJDigxgb0CWVg553C1J5UM2yWmP5W/hwgc=;
 b=d0k5iNsks4+lz+EciGxyBUPlkPS4mX2COVp6q9A6sou3sBpgnUkrtU2t8yFeq1YosWUmGX
 Mxuah1IgVdGv/o/70TnNizC/gOJxftNr7qK8hjSRB25PCmvxUL6tcw3VwOlWGPZVDw8sJj
 c3kB2wE7fxU5b5+t6nWkrrCPd6cV7vA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-eIon2wu3NGmqV9vHd4pZ8g-1; Tue,
 20 Oct 2026 06:34:16 +0000
X-MC-Unique: eIon2wu3NGmqV9vHd4pZ8g-1
X-Mimecast-MFC-AGG-ID: eIon2wu3NGmqV9vHd4pZ8g_1792478055
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FFA51800A34; Tue, 20 Oct 2026 06:34:15 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 40A3A5BC; Tue, 20 Oct 2026 06:34:13 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 43/65] qom: replace object_property_add_tm with
 StructTm QAPI type
From: marcandre.lureau@redhat.com
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 berrange@redhat.com, michael.roth@amd.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 kkostiuk@redhat.com, alistair.francis@wdc.com, amachhiw@linux.ibm.com
In-Reply-To: <20261019141929.1594337-44-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
 <20261019141929.1594337-44-armbru@redhat.com>
Date: Tue, 20 Oct 2026 10:33:32 +0400
Message-Id: <179247801298.2782576.4814080150282693277.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2555;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=qCLHGsfYYwcqCu4SE4csYvueGhLxtgyToQ2eiBayzHw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq1wtCC5pzmch2YO9bQLVmmpUKJCTqAz/1pC3dk
 Tb0dYDrCWGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatcLQgAKCRDa6OEJdZac
 5Sz8D/9LB/Zgq9uCMHZBq2IHitfHyPTlD8Ps1rs2JkDI09WIESNqHKTbF3R8W39CJ3pI5KKtmJZ
 Kved/FGLo8Bh7q2Po/54nRENZSxQxrbG7PiPO0kIL4KUn1U4iNzSJNLrjKQUH8c2YVhuERv5biU
 2KPwsGouFL/9MjL9hOCcmqJvj38YLsvu+ewm4P9TZ+GHY+CU1RVAJTz3lyWwaM+o2L5+NVBnTdZ
 eE74k3PCDmkUPsu6EpHchdvJBrTfBjAPApHc53t8mm1JYzQFrNHjDdBhrxs7nUfuoEvaFLbGUDw
 HalTwPfY6XAGA7Fr+3Ise4qldaQxjQIV8IkLbs+GW4I9K+buDXRHcStY0HbRpWsuV21NaKJBgdC
 qkkdAJ1pPCw7B53SwSYiDdG7pzvKQxXLy7G7vFySu8mLwzxp6Qhmdso8z1jP4Ptmuu8w5lSXMMt
 0tzw9mD/0D3ozppcte7gLvcssbv+EPw0UXvxMBfR+JxuJ80jGxYB2T+S6xOLwBjum58kr4daFsy
 EEpeRQvWwctxW88K2o8quh7Ek8ulpsvvcdYWVkN527kwOiiY74A9CVqOHtXj3+qWgHOoiSEZwpS
 /sHBRSV8FIzqzFr1EuJ1mT5JPPe6EvLePMjQS5/ncIar3YkkIQ/i2F/YbX1sCcuPUD8JwlQpL23
 cr4Jr1s3/pEEAiA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

> Define a StructTm QAPI struct in common.json matching the existing
> "struct tm" property wire format (tm_year, tm_mon, tm_mday, tm_hour,
> tm_min, tm_sec as int32).
> 
> Convert the two callers (mc146818rtc and spapr_rtc) to use
> object_property_add_qapi() with a standard ObjectPropertyAccessor
> that populates a StructTm and calls the generated visitor.
> 
> Remove object_property_add_tm(), object_class_property_add_tm(),
> the TMProperty type, and the property_get_tm() helper from
> qom/object.c, along with their declarations in object.h.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Message-ID: <20261019141929.1594337-44-armbru@redhat.com>
> ---
>  qapi/common.json     | 28 ++++++++++++++++++
>  qapi/pragma.json     |  1 +
>  include/qom/object.h | 29 -------------------
>  hw/ppc/spapr_rtc.c   | 18 ++++++++++--
>  hw/rtc/mc146818rtc.c | 16 ++++++++--
>  qom/object.c         | 69 --------------------------------------------
>  6 files changed, 57 insertions(+), 104 deletions(-)
>
> diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
> index 1f7d2d8f898b..a4a2b3237e26 100644
> --- a/hw/ppc/spapr_rtc.c
> +++ b/hw/ppc/spapr_rtc.c
> @@ -33,6 +33,9 @@
>  #include "migration/vmstate.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-events-misc.h"
> +#include "qapi/qapi-type-infos-common.h"
> +#include "qapi/qapi-visit-common.h"
> +#include "qapi/visitor.h"
>  #include "qemu/cutils.h"
>  #include "qemu/module.h"
>  
> @@ -131,9 +134,17 @@ static void rtas_set_time_of_day(PowerPCCPU *cpu, SpaprMachineState *spapr,
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
>  
> -static void spapr_rtc_qom_date(Object *obj, struct tm *current_tm, Error **errp)
> +static void spapr_rtc_qom_date(Object *obj, Visitor *v, const char *name,
> +                               void *opaque, Error **errp)
>  {
> -    spapr_rtc_read(SPAPR_RTC(obj), current_tm, NULL);
> +    struct tm value;
> +    StructTm tm, *tmp = &tm;
> +
> +    spapr_rtc_read(SPAPR_RTC(obj), &value, NULL);
> +
> +    tm = (StructTm) { value.tm_year, value.tm_mon, value.tm_mday,

Positional initialization relies on the QAPI field order matching
the struct tm field order here (and in mc146818rtc.c). Designated
initializers (.tm_year = value.tm_year, ...) would be robust against
a future reordering of either side.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


