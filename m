Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2309F606CA38
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nx6Rf0BM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOj6t-00071t-PC; Wed, 04 Nov 2026 17:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xOj6r-00071D-SE; Wed, 04 Nov 2026 17:05:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xOj6q-00085G-6i; Wed, 04 Nov 2026 17:05:33 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4FiANt3987271; Wed, 4 Nov 2026 22:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=nfbE5fj1YAXTJxW+eGWGUCFZjm5nADrpQAg01ndWF9k=; b=nx6Rf0BMznwQ
 4pQateF5+Vr60jYCS/o5GOFOHXNoKcjfRN/UhWZEgAlLpG415bgeqrKFKJWrtTwt
 74hZCLG8n003fgtmK6whL3qCDCoVMwIxZFn8JAuUsxjTBfdaYbZ2MykGppwio+qc
 /FyttybE1LL8UBPfHzgitcTd2e6fOZ2Lc5HodCBKhnTr8ugVB+tKal5d9H+Tzs8L
 mJ4ls7BFy6kL76XYK0RMwurj/px5niP+Cc3izhEsx6ecSpNUfDvJSkB2elqoNdpc
 Om8rDJwlcezC6m9IwFqJub+VHAAAIj4SzBrxXSZWnLLf4YsG+/KrBeOScvtECQaq
 limIgIagLg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rdea3c-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2026 22:05:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4LubsW232294; Wed, 4 Nov 2026 22:05:28 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnv5h271g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2026 22:05:28 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A4M5Soh24052454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Nov 2026 22:05:28 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2006758050;
 Wed,  4 Nov 2026 22:05:28 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7629C58045;
 Wed,  4 Nov 2026 22:05:27 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Nov 2026 22:05:27 +0000 (GMT)
Message-ID: <8b8286e41db8e6e75b42ecdb2ca83895d773c11b.camel@linux.ibm.com>
Subject: Re: [PATCH 2/4] hw/gpio/pca9552: Fix @type of pca9552 property led<N>
From: Miles Glenn <milesg@linux.ibm.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org
Date: Wed, 04 Nov 2026 16:05:27 -0600
In-Reply-To: <20261104064552.959862-3-armbru@redhat.com>
References: <20261104064552.959862-1-armbru@redhat.com>
 <20261104064552.959862-3-armbru@redhat.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rWoZjpUiE-6ktCtHRyK2DXIUgIzEKoyS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA4NiBTYWx0ZWRfX4EE7oCqzHJU1
 jVow3pR4mVSzAkqyybR3wvFRMxny4IJ4XULV3o9Z05jzo5WRWKmJbneiaSeotSqoNyb4HBYM6e1
 Tlt7rFWLb7M/uNMlao43+dsC3JhYii8Qbsp/iGz7XWfujX/P+ycivAFieXL4w6Vtk15C1UaU6J0
 RqmkjpaWh1Ug+e6eytOusdvnbtO/fri33fTxqZQhYCd1fc/JbTdy3+f6/11+yulKrpUIXxwd6tE
 jrhyOK0xFr2jJFcPHwBGc+ZdBztqAN2zz5lnwbn9wyKh+V3xobyI9K/FaCDzs4uGeCYl/yqQ5ac
 xgWUq42yj5V7MQAQcQDwNM+RY8fRhmKk8hQ43Uvk9CgONdQ8T6y6uW+yYYbY5m508TODxsIykMK
 WT/kJgY7xwuu5XLzmInyf0BE3bEPeuloPEHpp3lOFXQgE3EHFqTmo8Yqz5lKr4qnHxpajMGPVrx
 GxhJAFKhWMfTXVQ9Fcw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA4NiBTYWx0ZWRfX/pY1RUU8qBMz
 4haGIZnvUI9qFFVh/jB4UCBv4q3NeAjw24WZ/s4TZa2ayCggCyHZTJ2l+nK1KKVj15Uypcmk06A
 QDW5RHMbKy46l1w+P425L2FI2vihCA4=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6aebac28 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=IO1wbr4ZDdvbECwytdIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rWoZjpUiE-6ktCtHRyK2DXIUgIzEKoyS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040086
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

On Wed, 2026-11-04 at 07:45 +0100, Markus Armbruster wrote:
> pca955x_initfn() passes @type "bool" to object_property_add().  The
> properties are actually string-typed: pca955x_get_led() and
> pca955x_set_led() use visit_type_str().  Pass "str" instead.
> 
> Fixes: a90d8f84674d ("misc/pca9552: Add qom set and get")
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/gpio/pca9552.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index 7e5fda4980..07ef0fb20b 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -567,7 +567,7 @@ static void pca955x_initfn(Object *obj)
>          if (k->has_led_support) {
>              /* LED variant: expose the LED selector state as led%d. */
>              name = g_strdup_printf("led%d", ix);
> -            object_property_add(obj, name, "bool", NULL,
> +            object_property_add(obj, name, "str", NULL,
>                                  pca955x_get_led, pca955x_set_led, NULL, NULL);
>          } else {
>              /* GPIO variant: expose the pin logic level as pin%d. */


