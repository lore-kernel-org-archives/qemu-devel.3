Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7742C71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 15:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRuo4-0006WJ-24; Wed, 18 Jun 2025 11:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uRunz-0006VU-RK; Wed, 18 Jun 2025 11:34:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uRunx-00012A-HE; Wed, 18 Jun 2025 11:34:27 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IDe1aN017016;
 Wed, 18 Jun 2025 15:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rxSzfV
 srOOzaFbFeddixYn1wB8XM3kQras9169WDHME=; b=L14uiZGnf6/dC1Ap4HMzLq
 0Tyt6oFiI9U17UtbR3Vyh9jZP9TYBx0BZqsfte5+chNpZfLBEnWxaQIaK+jCoTPa
 WAitnJeK+rUK3998eToaMgOLK8cW6CKs6isD07k+UZx4gmounYLYyIIcLa44wNOO
 0fdQTIUCnFwWhY5p5i9UtYCmjpTbPr3BKXo5GpJOlSBBXOScT5GJMkYfOWMYOgXc
 9IzsVSRvyiVaVEM1TTogv0rWoBeTqZtoc3Hn7CcJoi1yzjx/Nxboldub4JU+aqRF
 okcEJfjTHKLeqato/HFCd72LtF6GEAkSinnySjLfeMxA9NQXaIQ84ZxyWEQcmX5g
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790r277xe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 15:34:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55IC9pKd025763;
 Wed, 18 Jun 2025 15:34:19 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 479xy5yntu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 15:34:19 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55IFYIbx29950590
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Jun 2025 15:34:18 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C2F8758061;
 Wed, 18 Jun 2025 15:34:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D2FF758060;
 Wed, 18 Jun 2025 15:34:17 +0000 (GMT)
Received: from [9.61.89.155] (unknown [9.61.89.155])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 18 Jun 2025 15:34:17 +0000 (GMT)
Message-ID: <935581ef-1cb2-4e2f-9c3f-23203b556ca8@linux.ibm.com>
Date: Wed, 18 Jun 2025 11:34:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zhuoying Cai <zycai@linux.ibm.com>
Subject: Re: [PATCH v3 02/28] crypto/x509-utils: Add helper functions for
 certificate store
To: Markus Armbruster <armbru@redhat.com>
Cc: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com, walling@linux.ibm.com,
 jjherne@linux.ibm.com, jrossi@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250604215657.528142-1-zycai@linux.ibm.com>
 <20250604215657.528142-3-zycai@linux.ibm.com> <87sejyskgj.fsf@pond.sub.org>
 <41e788ad-77e2-46d2-a384-2c8f524391c2@linux.ibm.com>
 <87wm99r3rh.fsf@pond.sub.org>
Content-Language: en-US
In-Reply-To: <87wm99r3rh.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FB6GRy0doZHmncx-ePHInDVz3knmJlxB
X-Proofpoint-ORIG-GUID: FB6GRy0doZHmncx-ePHInDVz3knmJlxB
X-Authority-Analysis: v=2.4 cv=AqTu3P9P c=1 sm=1 tr=0 ts=6852dc7c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=NB_RxL-2x5hI3PK_8MMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDEyOSBTYWx0ZWRfX32l0g5sz5T6y
 GmumBHoKwRFEmFRM71bRhdVJIcsHOs4EWCwqqiQ5uYYX0c/ljgH/0BbrM+R1UurLEf8rlBaZDqY
 OeU04Uw437UfwLnUCosKHWwFf4iHNWPxXmviUQBwnbuA7ABkcpy0psfYoMauGLm//XZeRwWjhiX
 mMLxFgEXv5T1IcdMVvRGhkREzIFD06Wv2yvLvFHpWiLwubsnHyhGE5EOtZy4UNv3tjuVMI+/uQs
 o14gyCprRNN/clZEWSwATIBSpsHpj1LpWeTjrXkmCCCDg5cK9oMihum0WBfTWsK8AAMM4XNJ68k
 nhvJSOFH8+BGKwJcws1Ka7yxySOVb538XoTkwDfXme3PgDMGdLCWpi2+nyzwNbVrcAvWIXzqWs/
 XfgoLsffOnKNqRa4G0yDOy3+N+2bi7xlexMyDFopdoOyDzPpbdXakccGWLJ07KJUIXf4eqja
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=684 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180129
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/18/25 1:57 AM, Markus Armbruster wrote:
> Zhuoying Cai <zycai@linux.ibm.com> writes:
> 
>> On 6/17/25 6:58 AM, Markus Armbruster wrote:
>>> Zhuoying Cai <zycai@linux.ibm.com> writes:
>>>
>>>> Add helper functions for x509 certificate which will be used in the next
>>>> patch for the certificate store.
>>>>
>>>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> 
> [...]
> 
>>> Ignorant question: why are these QAPI enums?
>>>
>>> If they need to be QAPI enums, then I'll have some requests on the doc
>>> comments.
>>>
>>
>> Hi, thanks for the feedback.
>>
>> The helper functions in x509-utils.c either take QAPI enum values as
>> parameters or return them. These enums are used later within QEMU.
> 
> Let's look at the first one I found:
> 
>     int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
>                                     QCryptoCertFmt fmt, Error **errp)
>     {
>         int rc;
>         int ret = -1;
>         gnutls_x509_crt_t crt;
>         gnutls_datum_t datum = {.data = cert, .size = size};
> 
>         if (fmt >= G_N_ELEMENTS(qcrypto_to_gnutls_cert_fmt_map)) {
>             error_setg(errp, "Unknown certificate format");
>             return ret;
>         }
> 
>         if (gnutls_x509_crt_init(&crt) < 0) {
>             error_setg(errp, "Failed to initialize certificate");
>             return ret;
>         }
> 
>         rc = gnutls_x509_crt_import(crt, &datum, qcrypto_to_gnutls_cert_fmt_map[fmt]);
>         if (rc == GNUTLS_E_ASN1_TAG_ERROR) {
>             goto cleanup;
>         }
> 
>         ret = 0;
> 
>     cleanup:
>         gnutls_x509_crt_deinit(crt);
>         return ret;
>     }
> 
> All it does with its @fmt argument is map it to the matching
> GNUTLS_X509_FMT_*.
> 
> There's just one caller, init_cert_x509_der() in hw/s390x/cert-store.c:
> 
>     is_der = qcrypto_check_x509_cert_fmt((uint8_t *)raw, size,
>                                          QCRYPTO_CERT_FMT_DER, &err);
> 
> QCRYPTO_CERT_FMT_DER gets mapped to GNUTLS_X509_FMT_DER.  Why not pass
> that directly?  We don't need enum QCryptoCertFmt then.
> 

I received feedback on a previous patch series that directly using
GNUTLS in QEMU code is discouraged, except for under the crypto/
directory. Internal APIs should be defined to access GNUTLS
functionality instead.

> If we need enum QCryptoCertFmt for some reason I can't see, why does it
> have to be a QAPI type?  Why not a plain C enum?
> 

While implementing the new helper functions, I referred to
qcrypto_get_x509_cert_fingerprint() in crypto/x509-utils.c, which takes
QCryptoHashAlgo as a parameter. Following this, I added corresponding
QCRYPTO enums to map to GNUTLS enums.

If using plain C enums is preferred, I can update the code accordingly
in the next version.

> Similar questions for the other QAPI enums added in this series.
> 


