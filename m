Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37D7CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 18:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzJ9X-0001dE-7h; Thu, 18 Sep 2025 14:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uzJ9P-0001cD-GQ; Thu, 18 Sep 2025 14:14:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uzJ9L-00039x-Qj; Thu, 18 Sep 2025 14:14:33 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IFHHAG011504;
 Thu, 18 Sep 2025 18:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=WNjXLs
 Kvwrk8hg9Nrs9OIDhwpPzdubxb3rsey88yHgk=; b=oHqN3VCp38DCbPUh3YZdmR
 ydbgkJy+4RWW7kWGGOd7/Ir7Wjczllsvb8H39VurJjDwB9IlF5c4aZi48eIzZGmT
 ZheX2wR6ekjw3jMUBVa8akEv58WcpYLvkjCL1u3mdbm4bgQxKr1L+YXWDxzqtxvE
 OkKAve8rVOAw77D+0KkIwGEU24JRpKVyuzjMHfsdeD+Pr1QaeAPxTmVTovrsuEXK
 s5YQtiKRz4pY06Fg0iE+V+Ay9+KknTpfCDEpyGyvMPodcATX8xX8RQwnPzo373cf
 cmSAfeBg86CTPObu/n6+b5orXmXJBPaOzqCky2bA0RaU5GjFAQrQgFqDImxmiGMw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4jc3p1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 18:14:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58IICVe6009395;
 Thu, 18 Sep 2025 18:14:25 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 495nn3qt7e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 18:14:25 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58IIEDA72032374
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Sep 2025 18:14:13 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 534B358053;
 Thu, 18 Sep 2025 18:14:23 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF1BF58059;
 Thu, 18 Sep 2025 18:14:21 +0000 (GMT)
Received: from [9.61.248.192] (unknown [9.61.248.192])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Sep 2025 18:14:21 +0000 (GMT)
Message-ID: <adf0c9b9-d023-4b65-8c44-a50769978e26@linux.ibm.com>
Date: Thu, 18 Sep 2025 11:14:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/28] crypto/x509-utils: Refactor with GNUTLS fallback
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-3-zycai@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20250917232131.495848-3-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Qf5mvtbv c=1 sm=1 tr=0 ts=68cc4c02 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=8efJLzWtkbXhKAT8rVIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JMvmlOwSQcfZ4nTxBHA8b6isTMeXtwVI
X-Proofpoint-GUID: JMvmlOwSQcfZ4nTxBHA8b6isTMeXtwVI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX+YPEYK7q+Wky
 NCFP3vxbZGQbde23oPNS/ohl1Nw8//81DUnChRrsTZlBBWe16cJdDv8oeZv6kKGr07JoxosQl2v
 hLV9UuKlqH7lVbZJ+GuMWuWQuIwqmFFUglrfsXy9Y1ajAvopcjf7EDAvndW75NFJw/BxFXwIbU5
 OCjTDMRUanukSE3HfcIHC5+9SRHfYHypbvWI3TJx4+YuglOsrjNdRXXid/TAROV96fGzL/myF+o
 8Er5hIge8chZVszmlYXmWfuat7iWJVqSYkuIgv8R1+wV87kS/SosWU5H3D6q8Tk1DFEGCKBtLxE
 V4XllbsMSGk0Z/dg7y6H+Gzx6JlDdk++GKApuJkkF7xA9d8++IdFRbocFyqP4uGpVSY2YaYootv
 NwHj9gQD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

On 9/17/2025 4:21 PM, Zhuoying Cai wrote:
> Always compile x509-utils.c and add a fallback when GNUTLS is
> unavailable.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   crypto/meson.build  |  5 +----
>   crypto/x509-utils.c | 16 ++++++++++++++++
>   2 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/crypto/meson.build b/crypto/meson.build
> index 735635de1f..0614bfa914 100644
> --- a/crypto/meson.build
> +++ b/crypto/meson.build
> @@ -22,12 +22,9 @@ crypto_ss.add(files(
>     'tlscredsx509.c',
>     'tlssession.c',
>     'rsakey.c',
> +  'x509-utils.c',
>   ))
>   
> -if gnutls.found()
> -  crypto_ss.add(files('x509-utils.c'))
> -endif
> -
>   if nettle.found()
>     crypto_ss.add(nettle, files('hash-nettle.c', 'hmac-nettle.c', 'pbkdf-nettle.c'))
>     if hogweed.found()
> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index 39bb6d4d8c..6176a88653 100644
> --- a/crypto/x509-utils.c
> +++ b/crypto/x509-utils.c
> @@ -11,6 +11,8 @@
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
>   #include "crypto/x509-utils.h"
> +
> +#ifdef CONFIG_GNUTLS
>   #include <gnutls/gnutls.h>
>   #include <gnutls/crypto.h>
>   #include <gnutls/x509.h>
> @@ -78,3 +80,17 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>       gnutls_x509_crt_deinit(crt);
>       return ret;
>   }
> +
> +#else /* ! CONFIG_GNUTLS */
> +
> +int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
> +                                      QCryptoHashAlgo hash,
> +                                      uint8_t *result,
> +                                      size_t *resultlen,
> +                                      Error **errp)
> +{
> +    error_setg(errp, "GNUTLS is required to get fingerprint");
> +    return -1;
> +}
> +
> +#endif /* ! CONFIG_GNUTLS */

