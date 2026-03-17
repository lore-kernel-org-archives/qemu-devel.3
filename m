Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729E0F33806
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 07:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2OSM-0002ad-EW; Tue, 17 Mar 2026 03:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1w2OSG-0002Zx-Fk; Tue, 17 Mar 2026 03:03:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1w2OSB-0000sM-13; Tue, 17 Mar 2026 03:03:01 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GF7YwU625911; Tue, 17 Mar 2026 07:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=hQRIGR
 WM3iEDLkgDp45jhH32QDCAPTU9hhg3CRLiF/g=; b=bxJxE4pMy/x3iwkhlaaKt8
 upNdlwg9rQ+jTLIFTlypP5U/Z/B5QH9F5aobyxStyHOIqOJZ6dEf4K/TR6J02zKc
 ne84onnN8R8XGFq/i/g5YOBfoT/+niMRp6m7FrCJdiJhMQN9//ume83KHbfhbqhd
 zgFopyvnTuOcwxZWFv0Gy/ak+SLQLWf+/c0GhReianRgIGBfO9YJ5A3GWZYY8Hdp
 BytOMTZt0z69qxM3u9Oq8Rv8aarcSt/kcsnuNv2uPCEgwyWIufKBsfnwuqb18i+v
 stEOJAY5K2kZfnWCFtgzrL/eDTYsaFgw/5vabTzLP2VXdoEzGx6Op+VcpbN2n61A
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3hu6xs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 07:02:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62H24hIn032327;
 Tue, 17 Mar 2026 07:02:52 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jqv03-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 07:02:52 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62H72REi20841044
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2026 07:02:28 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B291458051;
 Tue, 17 Mar 2026 07:02:50 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F9BD58062;
 Tue, 17 Mar 2026 07:02:49 +0000 (GMT)
Received: from [9.67.86.225] (unknown [9.67.86.225])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 17 Mar 2026 07:02:49 +0000 (GMT)
Message-ID: <9fd8ab48-0266-40e3-a6db-120f4e9f753a@linux.ibm.com>
Date: Tue, 17 Mar 2026 03:02:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 25/30] pc-bios/s390-ccw: Handle true secure IPL mode
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 jdaley@linux.ibm.com
References: <20260305224146.664053-1-zycai@linux.ibm.com>
 <20260305224146.664053-26-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20260305224146.664053-26-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FqYM8jPsWTQo89eQf-wfLhzk1zqkNQjx
X-Proofpoint-ORIG-GUID: FqYM8jPsWTQo89eQf-wfLhzk1zqkNQjx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA1NyBTYWx0ZWRfX0ZGyg7fPgPjz
 i8gYZVT8pFTtGVKksCKZLZKaZ6rYzC/S3fyMWLQxzS1pPWpVnCLHqpp7KblDoWr5+Q48fdVKrME
 kpWl2RAXE9fvyWFQ3tsaZektz6GHMIbTYcpDAjY6BcVscnyYcNkj9NPtJbcdfWUymgwqggdaeUG
 V5w9qRmt2TqA+RdzbRilk5qQoBg61SAca9ZlqcZwtbC8Zt836RtDWPFtr6PbD72BEYH9yB9GfOV
 zeC5BC7xNaZ37RqCE9VJw/9WgTXHy6fIHxOA2AcdL8SQb3HFIaqXUIazThsvOmGr13F6WH2PkVm
 95/DBz3FrJ6ZISuTl+tEY9DIdUCb3ZUANY8kLcOPw+4UMM+geWQvvIm3gxLUVArNOmx3R56BMOm
 vL9sC9Q7r8y7mRZmg/FKppn8vp8mKd+/PI3OcpaDRsSfa62JzuoK1/8FJxyGnjxM439q+VQxGZm
 M2PDtxwTE5M3CfcQ1eA==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69b8fc9d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=wOYf68yBnzOzyWPg3mEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170057
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/5/26 17:41, Zhuoying Cai wrote:
> When secure boot is enabled (-secure-boot on) and certificate(s) are
> provided, the boot operates in True Secure IPL mode.
> 
> Any verification error during True Secure IPL mode will cause the
> entire boot process to terminate.
> 
> Secure IPL in audit mode requires at least one certificate provided in
> the key store along with necessary facilities. If secure boot is enabled
> but no certificate is provided, the boot process will also terminate, as
> this is not a valid secure boot configuration.
> 
> Note: True Secure IPL mode is implemented for the SCSI scheme of
> virtio-blk/virtio-scsi devices.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  docs/system/s390x/secure-ipl.rst | 13 +++++++++++++
>  pc-bios/s390-ccw/bootmap.c       |  8 ++++++++
>  pc-bios/s390-ccw/main.c          |  3 +++
>  pc-bios/s390-ccw/s390-ccw.h      |  2 ++
>  pc-bios/s390-ccw/secure-ipl.c    |  4 ++++
>  pc-bios/s390-ccw/secure-ipl.h    |  3 +++
>  6 files changed, 33 insertions(+)
> 
> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
> index 2465f8b26d..e0af086c38 100644
> --- a/docs/system/s390x/secure-ipl.rst
> +++ b/docs/system/s390x/secure-ipl.rst
> @@ -65,3 +65,16 @@ Configuration:
>  .. code-block:: shell
>  
>      qemu-system-s390x -machine s390-ccw-virtio,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
> +
> +Secure Mode
> +-----------
> +
> +When the ``secure-boot=on`` option is set and certificates are provided,
> +a secure boot is performed with error reporting enabled. The boot process aborts
> +if any error occurs.
> +
> +Configuration:
> +
> +.. code-block:: shell
> +
> +    qemu-system-s390x -machine s390-ccw-virtio,secure-boot=on,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 43a661325f..9a61e989e0 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -738,6 +738,7 @@ static int zipl_run(ScsiBlockPtr *pte)
>      entry = (ComponentEntry *)(&header[1]);
>  
>      switch (boot_mode) {
> +    case ZIPL_BOOT_MODE_SECURE:
>      case ZIPL_BOOT_MODE_SECURE_AUDIT:
>          rc = zipl_run_secure(&entry, tmp_sec);
>          break;
> @@ -1120,9 +1121,16 @@ ZiplBootMode get_boot_mode(uint8_t hdr_flags)
>  {
>      bool sipl_set = hdr_flags & DIAG308_IPIB_FLAGS_SIPL;
>      bool iplir_set = hdr_flags & DIAG308_IPIB_FLAGS_IPLIR;
> +    VCStorageSizeBlock *vcssb;
>  
>      if (!sipl_set && iplir_set) {
>          return ZIPL_BOOT_MODE_SECURE_AUDIT;
> +    } else if (sipl_set && iplir_set) {
> +        vcssb = zipl_secure_get_vcssb();
> +        if (vcssb == NULL || vcssb->length == VCSSB_NO_VC) {
> +            return ZIPL_BOOT_MODE_INVALID;

Is an INVALID mode necessary, especially if the error is going to be
reported immediately after when the function exits?  Might as well just
put the `panic()` here instead.

Otherwise, patch LGTM:

Reviewed-by: Collin Walling <walling@linux.ibm.com>

> +        }
> +        return ZIPL_BOOT_MODE_SECURE;
>      }
>  
>      return ZIPL_BOOT_MODE_NORMAL;
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 106cdf9dec..1678ede8fb 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -329,6 +329,9 @@ void main(void)
>      }
>  
>      boot_mode = get_boot_mode(iplb->hdr_flags);
> +    if (boot_mode == ZIPL_BOOT_MODE_INVALID) {
> +        panic("Need at least one certificate for secure boot!");
> +    }
>  
>      while (have_iplb) {
>          boot_setup();
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 7d1a9d4acc..7092942280 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -96,8 +96,10 @@ int virtio_read(unsigned long sector, void *load_addr);
>  void zipl_load(void);
>  
>  typedef enum ZiplBootMode {
> +    ZIPL_BOOT_MODE_INVALID = -1,
>      ZIPL_BOOT_MODE_NORMAL = 0,
>      ZIPL_BOOT_MODE_SECURE_AUDIT = 1,
> +    ZIPL_BOOT_MODE_SECURE = 2,
>  } ZiplBootMode;
>  
>  extern ZiplBootMode boot_mode;
> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
> index 840b88a699..76b72fc8f4 100644
> --- a/pc-bios/s390-ccw/secure-ipl.c
> +++ b/pc-bios/s390-ccw/secure-ipl.c
> @@ -288,6 +288,10 @@ static bool check_sclab_presence(uint8_t *sclab_magic,
>      }
>  
>      /* a missing SCLAB will not be reported in audit mode */
> +    if (boot_mode == ZIPL_BOOT_MODE_SECURE) {
> +        zipl_secure_handle("Magic does not match. SCLAB does not exist");
> +    }
> +
>      return false;
>  }
>  
> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
> index 4e9f4f08b9..1e736d53fe 100644
> --- a/pc-bios/s390-ccw/secure-ipl.h
> +++ b/pc-bios/s390-ccw/secure-ipl.h
> @@ -60,6 +60,9 @@ static inline void zipl_secure_handle(const char *message)
>      case ZIPL_BOOT_MODE_SECURE_AUDIT:
>          IPL_check(false, message);
>          break;
> +    case ZIPL_BOOT_MODE_SECURE:
> +        panic(message);
> +        break;
>      default:
>          break;
>      }
-- 
Regards,
  Collin

