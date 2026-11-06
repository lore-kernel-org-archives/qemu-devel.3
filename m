Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8920606A32D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=USjrd4bc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPQP1-0007ZZ-CH; Fri, 06 Nov 2026 15:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xPQOx-0007W0-Aw; Fri, 06 Nov 2026 15:19:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xPQOv-0006LP-TL; Fri, 06 Nov 2026 15:19:07 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6K5tNR1546034; Fri, 6 Nov 2026 20:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=OV9Ye79eiY62vBIrnoxGblWBI+KK2MT35tPp8EYYMFY=; b=USjrd4bccfry
 OG6FxxncX7qbhKRzc/K0JB9jGiYVf9WtPnPp/ryOjDoxh12Mh692mp5W/dpq0e9a
 3PF8WQ+wPfEo9Ll74gGm+lLCXmHN8XScFo+M19ZsTNDpPPJReRJRz6pvN82w1ai0
 rtj9w9bksTg9KGc9Vq+E2b6vEUmCECa3YwcoG9xyDFmOuspf8JWYJVB4W/+UuK7U
 Wmxf2ghNO5SDxYUOYNK42RvAJqVQHKPC89KjNaXSGUMlMcfn2KumXtaCiLfKDbkd
 FevJaTBhABMH5UJGs0J7Yh++JlZmeV+IGPdAx5wNddMHuCtWuk0eTPjRWgn2D8eL
 Mf97QPNjFg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rayy4s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2026 20:19:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6Jo1P73799442; Fri, 6 Nov 2026 20:19:02 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrk9mvbx4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2026 20:19:02 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A6KJ23v33948286
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Nov 2026 20:19:02 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 39DC058059;
 Fri,  6 Nov 2026 20:19:02 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D894258060;
 Fri,  6 Nov 2026 20:19:01 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Nov 2026 20:19:01 +0000 (GMT)
Message-ID: <344af6fee49dd412be035412e6d65cf75fe08dff.camel@linux.ibm.com>
Subject: Re: [PATCH 3/8] hw/gpio/pca9554: Simplify QOM type creation
From: Miles Glenn <milesg@linux.ibm.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 mark.caveayland@nutanix.com
Date: Fri, 06 Nov 2026 14:19:01 -0600
In-Reply-To: <20261106110440.3552588-4-armbru@redhat.com>
References: <20261106110440.3552588-1-armbru@redhat.com>
 <20261106110440.3552588-4-armbru@redhat.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QYDzLcbv c=1 sm=1 tr=0 ts=6aee3637 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=qHkmPDIAQHMGhC3DbKkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: k2-U7qGcgy-iTosAgu-xa403MzMMRlMM
X-Proofpoint-ORIG-GUID: k2-U7qGcgy-iTosAgu-xa403MzMMRlMM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA4MCBTYWx0ZWRfX4UZXoHLLK4qG
 N1XqUsCT9B4evtwwEeEbwzXE5GaIdbk2R/2Tf3zQl38bnmVjOBpudyJ8VrwGMSkllR5hFmiBsId
 kYwrBlp+ayWCxbR60O8k2Q4Gdytsvg8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA4MCBTYWx0ZWRfXyzIfbNHorNmn
 PTcXPitUxPg8mvvDmJ/9s3QzcrqGH3wMoPlY8Ji5G7Nc8XNcv22jQeFc9jTp38O8FrDwzmStG7o
 KYBK8HC8tER2drBbj4ZAGh0jQHon78jcRGz/ZmF/DeUvLP52L2OYRNk4gjvLgeZWCIKQALuvKQ0
 m5REfrShoK+5dYnOHUGpg27BAjamWeHWCIpQm7k8B+BKKy8pZZMyCPmC/EKamoYJC+t0fd3YAyz
 T21Wp5N659oOsYLyq7MAV667YzKzGOYKxjlNyRGDhesjkWY/7o4nTYuOVgkes8XA/s1HBdTEZmH
 sl9z5250izZVtABggmaHaqi8ldKg9WLFgLATPTmIC+qebXNY7OfCHDh55a+1VOGfIJ7w1LbZmB4
 YB+PsRQfrTaVUC+veqqZUNm048mIa0eR2QlCH3hxugUxVEHphUnGzt/DsFvjLHrUu2bZ6kcRjV1
 kbdhDnPkOkEmJFgAPQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
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
> According to object.h, direct usage of DECLARE_INSTANCE_CHECKERS()
> should be avoided, and the complete OBJECT_DECLARE_TYPE macro is
> recommended instead.  So use that.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/gpio/pca9554.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
> index e5a1932c89..caa73f63c9 100644
> --- a/hw/gpio/pca9554.c
> +++ b/hw/gpio/pca9554.c
> @@ -22,14 +22,12 @@
>  #include "trace.h"
>  #include "qom/object.h"
>  
> -typedef struct PCA9554State PCA9554State;
> -DECLARE_INSTANCE_CHECKER(PCA9554State, PCA9554,
> -                         TYPE_PCA9554)
> -
>  #define PCA9554_NR_REGS 4
>  #define PCA9554_PIN_COUNT 8
>  #define PCA9536_PIN_COUNT 4
>  
> +OBJECT_DECLARE_TYPE(PCA9554State, PCA9554Class, PCA9554)
> +
>  struct PCA9554State {
>      /*< private >*/
>      I2CSlave i2c;
> @@ -52,10 +50,6 @@ struct PCA9554Class {
>  
>      uint8_t pin_count;
>  };
> -typedef struct PCA9554Class PCA9554Class;
> -
> -DECLARE_CLASS_CHECKERS(PCA9554Class, PCA9554,
> -                       TYPE_PCA9554)
>  
>  #define PCA9554_PIN_LOW  0x0
>  #define PCA9554_PIN_HIZ  0x1


