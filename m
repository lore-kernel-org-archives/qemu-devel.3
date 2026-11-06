Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B23F606A32E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jMe9WB1r
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPQOQ-00079K-OS; Fri, 06 Nov 2026 15:18:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xPQOP-00078W-6d; Fri, 06 Nov 2026 15:18:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xPQON-0006JN-Ef; Fri, 06 Nov 2026 15:18:32 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6IE5m51545873; Fri, 6 Nov 2026 20:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=PNgMVurBtGCkCl5DAi3n9fiQSAmMNWdEHcrZ3xRPNe4=; b=jMe9WB1ro6FI
 q2TXWscnHPfnen/Wgjv3vGEXlnTMHWCCGpmvgz9njKZU43UamZC5caOk/FoeDfaH
 +kXe+liCrK6jTOB14wvn/HzeIAx40D0ggDzQVQAKrzWpfNEYT6DjvzTUcD4Wlu9r
 oY41veXJUXr3zy/AfJngVGNwAHujdabiA5Z412crZYFVGmE9YZaCQkUyUG0fysuY
 oamp0yGhtm0FtVIufjaxoPOMaue7axeBRZIJNg/HfhV/nRCyQ8/A75zxaLLQaoaX
 yY1DHhMX1znXN4N7sRzymrYMY71OWjW8c56mwtTrFxygaGiQUEMXpg0cEikwmZQK
 KyzubOl9gw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rayy06-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2026 20:18:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6JpYKp3846090; Fri, 6 Nov 2026 20:18:28 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrka74bp9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2026 20:18:28 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A6KIRor4719198
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Nov 2026 20:18:27 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 698FF58056;
 Fri,  6 Nov 2026 20:18:27 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 129DC58052;
 Fri,  6 Nov 2026 20:18:27 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Nov 2026 20:18:26 +0000 (GMT)
Message-ID: <478f5bc59e949621d3d357a7aa1f7339f9d5d1f7.camel@linux.ibm.com>
Subject: Re: [PATCH 2/8] hw/gpio/pca9554: Move most code from .h to .c
From: Miles Glenn <milesg@linux.ibm.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 mark.caveayland@nutanix.com
Date: Fri, 06 Nov 2026 14:18:26 -0600
In-Reply-To: <20261106110440.3552588-3-armbru@redhat.com>
References: <20261106110440.3552588-1-armbru@redhat.com>
 <20261106110440.3552588-3-armbru@redhat.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QYDzLcbv c=1 sm=1 tr=0 ts=6aee3615 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=sWN3zfszUj_efFXM9Y4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ahcI7npfMc1SuLJb8X5lMPGmlH04rBAO
X-Proofpoint-ORIG-GUID: ahcI7npfMc1SuLJb8X5lMPGmlH04rBAO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA4MCBTYWx0ZWRfX7OSP0+Mu05/H
 qCkYz5nxEae7mA9/GgyAG0s9JPQc7YOtg09QywkQmugwYvtXPi4hBiKiwRCpEZti3CWUtvjX+de
 9pMWPGzyjT1pJrtiac7Li6oJRM5ExUU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA4MCBTYWx0ZWRfXxgz8Mfvx2YHS
 njkZ6n0aXCzZIKfAduWqW0/JsJakfOynl0b+q3avH0130uSjz0qlRcSP2aVV53z6cUuqKnSFBDn
 jJ5YpIrNzBiJggQ31qul8wP9SB9YHfzOdSVieO/RXG6npfM9dYhA86OcTvHmQ62Irid6Y0nBRUg
 eSvSQ3rbL8kt/v5q8K8Z5+cADxi+nIDwZsGV1buVMvoIxHVILM/XbiZ8gDG3hkxDld15AEFPn+u
 jxqa06Aee4KuQD4Sk5z++CfWRs0aDMo/OxEGoH87IiZ9yk7/9yLlz6tG2mmn0LStquc8xtGUixK
 0lY1MglAtZTXF8BS/pg9XFGyNhrDAoPxmSOksx3UzbUSoHzA6UcM46oPt2hU0npt/p7jeNO76uz
 RP2PBUMhmZEGwitK36+TXUNdlgKZV42HJ8WSDutv0lkeS2sDAhfPYl1xXwX97xDg6v7TrSXnaYf
 EEuPX4XJsyC3BA4dJsA==
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
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/hw/gpio/pca9554.h | 25 -------------------------
>  hw/gpio/pca9554.c         | 24 ++++++++++++++++++++++++
>  2 files changed, 24 insertions(+), 25 deletions(-)
> 
> diff --git a/include/hw/gpio/pca9554.h b/include/hw/gpio/pca9554.h
> index ac835371aa..1b33a8a752 100644
> --- a/include/hw/gpio/pca9554.h
> +++ b/include/hw/gpio/pca9554.h
> @@ -8,32 +8,7 @@
>  #ifndef PCA9554_H
>  #define PCA9554_H
>  
> -#include "hw/i2c/i2c.h"
> -#include "qom/object.h"
> -
>  #define TYPE_PCA9554 "pca9554"
>  #define TYPE_PCA9536 "pca9536"
> -typedef struct PCA9554State PCA9554State;
> -DECLARE_INSTANCE_CHECKER(PCA9554State, PCA9554,
> -                         TYPE_PCA9554)
> -
> -#define PCA9554_NR_REGS 4
> -#define PCA9554_PIN_COUNT 8
> -#define PCA9536_PIN_COUNT 4
> -
> -struct PCA9554State {
> -    /*< private >*/
> -    I2CSlave i2c;
> -    /*< public >*/
> -
> -    uint8_t len;
> -    uint8_t pointer;
> -
> -    uint8_t regs[PCA9554_NR_REGS];
> -    qemu_irq gpio_out[PCA9554_PIN_COUNT];
> -    uint8_t ext_state[PCA9554_PIN_COUNT];
> -    char *description; /* For debugging purpose only */
> -    bool hw_dir; /* Honor pin direction */
> -};
>  
>  #endif
> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
> index 07bb00babf..e5a1932c89 100644
> --- a/hw/gpio/pca9554.c
> +++ b/hw/gpio/pca9554.c
> @@ -13,6 +13,7 @@
>  #include "hw/core/qdev-properties.h"
>  #include "hw/gpio/pca9554.h"
>  #include "hw/gpio/pca9554_regs.h"
> +#include "hw/i2c/i2c.h"
>  #include "hw/core/irq.h"
>  #include "migration/vmstate.h"
>  #include "qapi/error.h"
> @@ -21,6 +22,29 @@
>  #include "trace.h"
>  #include "qom/object.h"
>  
> +typedef struct PCA9554State PCA9554State;
> +DECLARE_INSTANCE_CHECKER(PCA9554State, PCA9554,
> +                         TYPE_PCA9554)
> +
> +#define PCA9554_NR_REGS 4
> +#define PCA9554_PIN_COUNT 8
> +#define PCA9536_PIN_COUNT 4
> +
> +struct PCA9554State {
> +    /*< private >*/
> +    I2CSlave i2c;
> +    /*< public >*/
> +
> +    uint8_t len;
> +    uint8_t pointer;
> +
> +    uint8_t regs[PCA9554_NR_REGS];
> +    qemu_irq gpio_out[PCA9554_PIN_COUNT];
> +    uint8_t ext_state[PCA9554_PIN_COUNT];
> +    char *description; /* For debugging purpose only */
> +    bool hw_dir; /* Honor pin direction */
> +};
> +
>  struct PCA9554Class {
>      /*< private >*/
>      I2CSlaveClass parent_class;


