Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E5FF45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 20:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBID3-0007nk-U4; Fri, 10 Apr 2026 16:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wBICy-0007mx-Ca; Fri, 10 Apr 2026 16:12:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wBICu-00022n-H7; Fri, 10 Apr 2026 16:12:04 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63ADkaIA2314886; Fri, 10 Apr 2026 20:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=XTXSXr
 Q4zxiObiKDgWegla9Bbf9dVD6ThUCpYafc1jM=; b=PtrIm7FwchWwdrd/9QF9bF
 XPLNcaBEegs04xLTUW6dDARGEBNZtGW4FP6za5nApVikis/x64ZV4WbrEl1eRQAB
 W8IwpKkbXreIUZeNy7oF7IdDBJF3+1CnRk83IjEZ+9VjPE0ucPp4a6t0h33AiPlJ
 n0PKP8TeAKCGdnCmZArmydYDWZpUfPHUcToBA2FwEIGKmmzMWLPhYjliqHADnEyC
 R+TxhnY4JIUgyMetOJn2Y1oJRFtwvCuAyUDHR09nQu6ZaJyvEIvhEK/HIjdWcQgI
 s4QP8Ss2nTZsuahvql0S1LD9WeYSTe4e7qmg/WVSQL+bJRAE699UCB7sHzJBOobA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2gbyus-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 20:11:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63AK7IvQ013902;
 Fri, 10 Apr 2026 20:11:47 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf4hvc8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 20:11:47 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63AKBkNL32375428
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Apr 2026 20:11:46 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 440A75805A;
 Fri, 10 Apr 2026 20:11:46 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FEBD58051;
 Fri, 10 Apr 2026 20:11:45 +0000 (GMT)
Received: from [9.67.17.158] (unknown [9.67.17.158])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 10 Apr 2026 20:11:45 +0000 (GMT)
Message-ID: <69556fbe-9cb6-4f55-adac-5eedeafc2e55@linux.ibm.com>
Date: Fri, 10 Apr 2026 16:11:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 25/30] pc-bios/s390-ccw: Handle true secure IPL mode
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 jdaley@linux.ibm.com
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
 <20260402221453.1602899-26-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20260402221453.1602899-26-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FKArAeos c=1 sm=1 tr=0 ts=69d95984 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=5vYjyxcIyidLnK8Zd2IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: cjzNTSArTUWB32XJSHQx5Rr2iDTP6g3O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE4NSBTYWx0ZWRfX5hISbfz6GtTj
 YQUlAk7eVoAtlvlYqfMrK2gIJoeOzXPZvSYHxW/upPWMjG8nWWxpOE0NxchHS88+6XMs222/LqU
 ppj35FOnipN7MXNqPJayEPkpb+WDD05V/22TSiIN96CVnzT7XT9GO9l3R9qi0W+Q0tAqeIdj5rv
 bHyTNvLFYSzbGC69thDbD4GNdxaSo6AgeHYaf2WNTBDOBiDRciQY/DxJAYrAvxOGlW/oqWXvJ42
 R9o9HVGZHF+Q0NOj/b8XC6WaBLMD3VdiRc66Pox8Kt3wzwyVwZU7XSg/0hfx2psMM4pBcR5iiag
 3TzNeU6c31XLTSK7oGN0vfY5S/HGohy6NBaHTuz4cji1Cer3A5+P9yaDI04Wo1rZ5w3Am0ndrqL
 R+idu7FRlQbSmpVZED+ezia4CAEG8GMhxyXa5tenOAnveb07fHTOa4Rw2J/1+xcIWuafLcVzBZt
 oDh205A9E4zEkXx7ryQ==
X-Proofpoint-GUID: cjzNTSArTUWB32XJSHQx5Rr2iDTP6g3O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100185
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/2/26 18:14, Zhuoying Cai wrote:
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
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> ---
>  docs/system/s390x/secure-ipl.rst | 13 +++++++++++++
>  pc-bios/s390-ccw/bootmap.c       |  8 ++++++++
>  pc-bios/s390-ccw/s390-ccw.h      |  1 +
>  pc-bios/s390-ccw/secure-ipl.c    |  4 ++++
>  pc-bios/s390-ccw/secure-ipl.h    |  3 +++
>  5 files changed, 29 insertions(+)
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
> index 1873a35511..bf8eee5ae0 100644
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
> +            panic("Need at least one certificate for secure boot!");
> +        }
> +        return ZIPL_BOOT_MODE_SECURE;
>      }
>  
>      return ZIPL_BOOT_MODE_NORMAL;
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index e1a8097c95..8538663bd5 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -91,6 +91,7 @@ void zipl_load(void);
>  typedef enum ZiplBootMode {
>      ZIPL_BOOT_MODE_NORMAL = 0,
>      ZIPL_BOOT_MODE_SECURE_AUDIT = 1,
> +    ZIPL_BOOT_MODE_SECURE = 2,
>  } ZiplBootMode;
>  
>  extern ZiplBootMode boot_mode;
> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
> index d4e455ed0c..0befa6a8b3 100644
> --- a/pc-bios/s390-ccw/secure-ipl.c
> +++ b/pc-bios/s390-ccw/secure-ipl.c
> @@ -280,6 +280,10 @@ static bool check_sclab_presence(uint8_t *sclab_magic, uint32_t *cei_flags)
>      *cei_flags |= S390_CEI_INVALID_SCLAB;
>  
>      /* a missing SCLAB will not be reported in audit mode */
> +    if (boot_mode == ZIPL_BOOT_MODE_SECURE) {
> +        zipl_secure_handle("Magic does not match. SCLAB does not exist");
> +    }
> +

Hmm I know I already gave my r-b, but I don't recall the boot_mode check
here.  Is there anything inherently wrong with reporting a missing
SCLAB, even if it's not present for audit mode?  The whole point of
audit is to just do everything secure IPL does, but report warnings
instead of terminating.

>      return false;
>  }
>  
> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
> index 75d1c8e046..039fcec516 100644
> --- a/pc-bios/s390-ccw/secure-ipl.h
> +++ b/pc-bios/s390-ccw/secure-ipl.h
> @@ -82,6 +82,9 @@ static inline void zipl_secure_handle(const char *message)
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

