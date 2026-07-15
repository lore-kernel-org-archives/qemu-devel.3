Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73019C44507
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 20:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk6MH-0001ZB-NK; Wed, 15 Jul 2026 16:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wk6MG-0001Yc-4f; Wed, 15 Jul 2026 16:37:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wk6MC-0004j4-P9; Wed, 15 Jul 2026 16:37:31 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FHC8hg800325; Wed, 15 Jul 2026 20:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Q7hmRZ
 bRJHdunJDtd3tx+uDG6rhU/23yB/0+ORoQeaw=; b=dvdjYL3Ws2uAeU+QTkxQh5
 s87h/834qGi78IAAETOxDD5/ohextBo4KhNW2NZFzzzmGUwovNxRP493KBYmIUJh
 rE8OJRPSMAR4HmJT5DFf9900VOR5dw4S2RcEIlTavbmjMdz++Hvc1C/DRwvYvvsJ
 Baad1cTpqE1OFJZ6VcUzf2ntpC+b/0J2PyCHvMiXKKnbTKaAB6NDA6++Cds5HLk4
 bSo8XtsCJAicnZcpTri8SudvwXDPrnQtEpwf6jxUqD2KudL8uagWyIUA4bFv1Jx6
 2QKhe4QSIcKah44m71Bjhyn98YH+N/gfinVgOumVgZQ8J6tKBx/6yvDHqCdKEW2g
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegtdnb4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 20:37:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FKYuZb001211;
 Wed, 15 Jul 2026 20:37:22 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05qa44h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 20:37:22 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66FKajwJ7143984
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jul 2026 20:36:45 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BEED58062;
 Wed, 15 Jul 2026 20:37:20 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D26045805F;
 Wed, 15 Jul 2026 20:37:18 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 15 Jul 2026 20:37:18 +0000 (GMT)
Message-ID: <17778d69-9860-4713-9321-a1293064fc06@linux.ibm.com>
Date: Wed, 15 Jul 2026 16:37:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 23/33] pc-bios/s390-ccw: Add signature verification
 for secure IPL in audit mode
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260707231132.2492104-1-zycai@linux.ibm.com>
 <20260707234047.2499921-1-zycai@linux.ibm.com>
 <20260707234047.2499921-4-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20260707234047.2499921-4-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ft2wD-_A1Nrximc8Fpp7hDSxerxgeokq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDIwMSBTYWx0ZWRfX+CEus9Bt97qr
 uYB19ZkyeNOaHDUEeBuOLc9gHc+d8wMDg4gAPIQJd9XQfgKtLZg9q9IqPNZdqe2EbYB9EFKU0mO
 qAUSLtdGwittxbPWfqntFrko2d0xTEU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDIwMSBTYWx0ZWRfX7HGFcNUiOVfg
 EK0yEbWdoygC5mz8ZKRYoLD/jL/sLEGdocf1dNXtU8k6WHt+8PsVlZozmstxjlAIEMdlGVnWYSD
 gxvAmG4kpRRgiWbe92mh1fvGCUguchrZq2yZDNP3dHFiROQZF62cvkfRj202oH7x1v9GlPFJgQ6
 PFec2IkHaF9BDC+Xv7peAsoJrSBzf9Jt0URG6UmvLJNstmw+5qhCn+2yVXBmWS2J7VPQGv01K45
 +N19bCeV2GiXfnpbytCA7Kfe+ph9+Zt9nrTyuLRClwW90yRwUeDYB1umicicvOABBdcuhBwh9V1
 yCBDQSi/qQr+L9KwyvfC9HFsQKx+2bxTG4mfvAdnXfxzDMVookVwyp030x2bva3o+jP932zX2vc
 nPOmhyIrjdZnwzGZK03Dqaf3djrsTtmZFgOM5/R8byJ7Pu2NGdnKJJt9bNKrvMGOWQoNrTw8SKU
 WFYSj/qZRBxD0dlOwWw==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a57ef83 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=IS6b3r6a9NrpiuS5_00A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ft2wD-_A1Nrximc8Fpp7hDSxerxgeokq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150201
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/7/26 19:40, Zhuoying Cai wrote:
> Enable secure IPL in audit mode, which performs signature verification,
> but any error does not terminate the boot process. Only warnings will be
> logged to the console instead.
> 
> Secure IPL in audit mode requires at least one certificate provided in
> the key store along with necessary facilities (Secure IPL Facility,
> Certificate Store Facility and secure IPL extension support).
> 
> Note: Secure IPL in audit mode is implemented for the SCSI scheme of
> virtio-blk/virtio-scsi devices.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

Mostly a few nits below, but one important piece regarding the placement
of the update_iirb() call.

> ---
>  docs/system/s390x/secure-ipl.rst |  15 ++
>  hw/s390x/ipl.c                   |   9 +
>  pc-bios/s390-ccw/Makefile        |   2 +-
>  pc-bios/s390-ccw/bootmap.c       |  27 +++
>  pc-bios/s390-ccw/bootmap.h       |   9 +
>  pc-bios/s390-ccw/jump2ipl.c      |   7 +
>  pc-bios/s390-ccw/main.c          |  19 +-
>  pc-bios/s390-ccw/s390-ccw.h      |  20 ++
>  pc-bios/s390-ccw/sclp.c          |  27 +++
>  pc-bios/s390-ccw/sclp.h          |   6 +
>  pc-bios/s390-ccw/secure-ipl.c    | 363 +++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/secure-ipl.h    | 115 ++++++++++
>  12 files changed, 617 insertions(+), 2 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>  create mode 100644 pc-bios/s390-ccw/secure-ipl.h
> 
> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
> index 9d7d33f5ed..cf6ccf5d57 100644
> --- a/docs/system/s390x/secure-ipl.rst
> +++ b/docs/system/s390x/secure-ipl.rst
> @@ -39,3 +39,18 @@ Configuration:
>  .. code-block:: shell
>  
>      qemu-system-s390x -machine s390-ccw-virtio ...
> +
> +Audit Mode
> +^^^^^^^^^^
> +
> +When the certificate store is populated with at least one certificate
> +and no additional secure IPL parameters are provided on the command
> +line, then secure IPL will proceed in "audit mode". All secure IPL
> +operations will be performed with signature verification errors reported
> +as non-disruptive warnings.
> +
> +Configuration:
> +
> +.. code-block:: shell
> +
> +    qemu-system-s390x -machine s390-ccw-virtio,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 85fe2d3cb4..d0dbf47d74 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -828,6 +828,15 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
>          cpu->env.psw.addr = ipl->bios_start_addr;
>          if (!ipl->iplb_valid) {
>              ipl->iplb_valid = s390_init_all_iplbs(ipl);
> +
> +            /*
> +             * Secure IPL without specifying a boot device.
> +             * IPLB is not generated if no boot device is defined.
> +             */
> +            if (s390_has_certificate() && !ipl->iplb_valid) {
> +                error_report("No boot device defined for Secure IPL");
> +                exit(1);
> +            }
>          } else {
>              ipl->qipl.chain_len = 0;
>          }
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index 3e5dfb64d5..2109d16781 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -35,7 +35,7 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
>  
>  OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
>  	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
> -	  virtio-ccw.o clp.o pci.o virtio-pci.o
> +	  virtio-ccw.o clp.o pci.o virtio-pci.o secure-ipl.o
>  
>  SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
>  
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 7791ca179a..276080709d 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -10,11 +10,13 @@
>  
>  #include <string.h>
>  #include <stdio.h>
> +#include <stdlib.h>
>  #include "s390-ccw.h"
>  #include "s390-arch.h"
>  #include "bootmap.h"
>  #include "virtio.h"
>  #include "bswap.h"
> +#include "secure-ipl.h"
>  
>  #ifdef DEBUG
>  /* #define DEBUG_FALLBACK */
> @@ -710,6 +712,9 @@ static int zipl_run(ScsiBlockPtr *pte)
>      ComponentHeader *header;
>      ComponentEntry *entry;
>      uint8_t tmp_sec[MAX_SECTOR_SIZE];
> +    IplDeviceComponentList comp_list = { 0 };
> +    IplSignatureCertificateList cert_list = { 0 };
> +    uint8_t *tmp_cert_buf = NULL;
>      int rc;
>  
>      if (virtio_read(pte->blockno, tmp_sec)) {
> @@ -736,6 +741,9 @@ static int zipl_run(ScsiBlockPtr *pte)
>      case ZIPL_BOOT_MODE_NORMAL:
>          rc = zipl_run_normal(&entry, tmp_sec);
>          break;
> +    case ZIPL_BOOT_MODE_SECURE_AUDIT:
> +        rc = zipl_run_secure(&entry, tmp_sec, &comp_list, &cert_list, &tmp_cert_buf);
> +        break;
>      default:
>          panic("Unknown boot mode");
>      }
> @@ -751,6 +759,13 @@ static int zipl_run(ScsiBlockPtr *pte)
>  
>      /* should not return */
>      write_reset_psw(entry->compdat.load_psw);
> +
> +    if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT) {
> +        update_cert_list(&cert_list);
> +        update_iirb(&comp_list, &cert_list);
> +        free(tmp_cert_buf);
> +    }
> +

Sorry if I missed this from the previous rounds of review, but why was
this moved outside of `zipl_run_secure()`?  It seems out of place here.

If there is justification for it, I'd suggest at least moving this chunk
a few lines up to before the `write_reset_psw` call to keep the "IPL
jump" code together.  The comment above is meant for the following chunk:

```
    /* should not return */
    write_reset_psw(entry->compdat.load_psw);
    jump_to_IPL_code(0);
    return -1;
```

Otherwise the comment is a bit misleading.  I suppose one could argue
the comment should actually be placed abouve `jump_to_IPL_code`, but
let's not bother with that change.

>      jump_to_IPL_code(0);
>      return -1;
>  }
> @@ -1106,6 +1121,18 @@ static int zipl_load_vscsi(void)
>   * IPL starts here
>   */
>  
> +ZiplBootMode get_boot_mode(uint8_t hdr_flags)
> +{
> +    bool sipl_set = hdr_flags & DIAG308_IPIB_FLAGS_SIPL;
> +    bool iplir_set = hdr_flags & DIAG308_IPIB_FLAGS_IPLIR;
> +
> +    if (!sipl_set && iplir_set) {
> +        return ZIPL_BOOT_MODE_SECURE_AUDIT;
> +    }
> +
> +    return ZIPL_BOOT_MODE_NORMAL;
> +}
> +
>  void zipl_load(void)
>  {
>      VDev *vdev = virtio_get_device();
> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
> index 40580600b5..e1f4130752 100644
> --- a/pc-bios/s390-ccw/bootmap.h
> +++ b/pc-bios/s390-ccw/bootmap.h
> @@ -88,9 +88,18 @@ typedef struct BootMapTable {
>      BootMapPointer entry[];
>  } __attribute__ ((packed)) BootMapTable;
>  
> +#define DER_SIGNATURE_FORMAT 1
> +
> +typedef struct SignatureInformation {
> +    uint8_t format;
> +    uint8_t reserved[3];
> +    uint32_t sig_len;
> +} SignatureInformation;
> +
>  typedef union ComponentEntryData {
>      uint64_t load_psw;
>      uint64_t load_addr;
> +    SignatureInformation sig_info;
>  } ComponentEntryData;
>  
>  typedef struct ComponentEntry {
> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
> index fa2ca5cbe1..8e87c566f9 100644
> --- a/pc-bios/s390-ccw/jump2ipl.c
> +++ b/pc-bios/s390-ccw/jump2ipl.c
> @@ -75,6 +75,13 @@ int jump_to_IPL_code(uint64_t address)
>                   "diag %%r1,%%r1,0x308\n\t"
>                   : : : "1", "memory");
>      puts("IPL code jump failed");
> +
> +    /*
> +     * A failed jump only occurs in extreme conditions, so abort the IPL entirely.
> +     * This also prevents attempts to boot from the chain area if it has been
> +     * overwritten with component data.
> +     */
> +    qipl.chain_len = 0;
>      return -1;
>  }
>  
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 40e568fc71..520c448c2c 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -20,6 +20,7 @@
>  #include "dasd-ipl.h"
>  #include "clp.h"
>  #include "virtio-pci.h"
> +#include "secure-ipl.h"
>  
>  static SubChannelId blk_schid = { .one = 1 };
>  static char loadparm_str[LOADPARM_LEN + 1];
> @@ -386,6 +387,8 @@ static void probe_boot_device(void)
>  
>  void main(void)
>  {
> +    int vcssb_len;
> +
>      iplb = &ipl_blocks.iplb;
>  
>      copy_qipl();
> @@ -397,7 +400,21 @@ void main(void)
>          probe_boot_device();
>      }
>  
> -    boot_mode = ZIPL_BOOT_MODE_NORMAL;
> +    boot_mode = get_boot_mode(iplb->hdr_flags);
> +    switch (boot_mode) {
> +    case ZIPL_BOOT_MODE_SECURE_AUDIT:
> +        if (!secure_ipl_supported()) {
> +            panic("Unable to boot in audit mode");
> +        }
> +
> +        vcssb_len = zipl_secure_get_vcssb();
> +        if (vcssb_len == 0) {
> +            panic("Failed to query certificate storage information!");
> +        }
> +        break;
> +    default:
> +        break;
> +    }
>  
>      while (have_iplb) {
>          boot_setup();
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 5420443ad2..ca2737054d 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -40,6 +40,22 @@ typedef unsigned long long u64;
>                              ((b) == 0 ? (a) : (MIN(a, b))))
>  #endif
>  
> +/*
> + * Round number down to multiple. Requires that d be a power of 2.
> + * Works even if d is a smaller type than n.
> + */
> +#ifndef ROUND_DOWN
> +#define ROUND_DOWN(n, d) ((n) & -(0 ? (n) : (d)))
> +#endif
> +
> +/*
> + * Round number up to multiple. Requires that d be a power of 2.
> + * Works even if d is a smaller type than n.
> + */
> +#ifndef ROUND_UP
> +#define ROUND_UP(n, d) ROUND_DOWN((n) + (d) - 1, (d))
> +#endif
> +
>  #define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
>  
>  #include "cio.h"
> @@ -64,6 +80,8 @@ void sclp_print(const char *string);
>  void sclp_set_write_mask(uint32_t receive_mask, uint32_t send_mask);
>  void sclp_setup(void);
>  void sclp_get_loadparm_ascii(char *loadparm);
> +bool sclp_is_diag320_on(void);
> +bool sclp_is_fac_ipl_flag_on(uint16_t fac_ipl_flag);
>  int sclp_read(char *str, size_t count);
>  
>  /* bootmap.c */
> @@ -71,9 +89,11 @@ void zipl_load(void);
>  
>  typedef enum ZiplBootMode {
>      ZIPL_BOOT_MODE_NORMAL = 0,
> +    ZIPL_BOOT_MODE_SECURE_AUDIT = 1,
>  } ZiplBootMode;
>  
>  extern ZiplBootMode boot_mode;
> +ZiplBootMode get_boot_mode(uint8_t hdr_flags);
>  
>  /* jump2ipl.c */
>  void write_reset_psw(uint64_t psw);
> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
> index 4a07de018d..48bdfedf1f 100644
> --- a/pc-bios/s390-ccw/sclp.c
> +++ b/pc-bios/s390-ccw/sclp.c
> @@ -113,6 +113,33 @@ void sclp_get_loadparm_ascii(char *loadparm)
>      }
>  }
>  
> +bool sclp_is_diag320_on(void)
> +{
> +    ReadInfo *sccb = (void *)_sccb;
> +
> +    memset((char *)_sccb, 0, sizeof(ReadInfo));
> +    sccb->h.length = SCCB_SIZE;
> +    if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
> +        return sccb->fac134 & SCCB_FAC134_DIAG320_BIT;
> +    }
> +
> +    return 0;
> +}
> +
> +/* check if specified IPL facility flag is enabled */
> +bool sclp_is_fac_ipl_flag_on(uint16_t fac_ipl_flag)
> +{
> +    ReadInfo *sccb = (void *)_sccb;
> +
> +    memset((char *)_sccb, 0, sizeof(ReadInfo));
> +    sccb->h.length = SCCB_SIZE;
> +    if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
> +        return sccb->fac_ipl & fac_ipl_flag;
> +    }
> +
> +    return 0;
> +}

I don't recall if I mentioned this in a previous iteration, but let's
make an external note somewhere for future development to implement a
single read SCP info call in the BIOS.  Maybe someone can toss it in as
a patch within a future series.

These patches are not contingent upon this implementation.

> +
>  int sclp_read(char *str, size_t count)
>  {
>      ReadEventData *sccb = (void *)_sccb;
> diff --git a/pc-bios/s390-ccw/sclp.h b/pc-bios/s390-ccw/sclp.h
> index 64b53cad29..a8a41cd004 100644
> --- a/pc-bios/s390-ccw/sclp.h
> +++ b/pc-bios/s390-ccw/sclp.h
> @@ -50,6 +50,8 @@ typedef struct SCCBHeader {
>  } __attribute__((packed)) SCCBHeader;
>  
>  #define SCCB_DATA_LEN (SCCB_SIZE - sizeof(SCCBHeader))
> +#define SCCB_FAC134_DIAG320_BIT 0x4
> +#define SCCB_FAC_IPL_SIPL_BIT   0x4000
>  
>  typedef struct ReadInfo {
>      SCCBHeader h;
> @@ -57,6 +59,10 @@ typedef struct ReadInfo {
>      uint8_t rnsize;
>      uint8_t reserved[13];
>      uint8_t loadparm[LOADPARM_LEN];
> +    uint8_t reserved1[102];
> +    uint8_t fac134;
> +    uint8_t reserved2;
> +    uint16_t fac_ipl;
>  } __attribute__((packed)) ReadInfo;
>  
>  typedef struct SCCB {
> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
> new file mode 100644
> index 0000000000..1ab41e5543
> --- /dev/null
> +++ b/pc-bios/s390-ccw/secure-ipl.c
> @@ -0,0 +1,363 @@
> +/*
> + * S/390 Secure IPL
> + *
> + * Functions to support IPL in secure boot mode (DIAG 320, DIAG 508,
> + * signature verification, and certificate handling).
> + *
> + * For secure IPL overview: docs/system/s390x/secure-ipl.rst
> + * For secure IPL technical: docs/specs/s390x-secure-ipl.rst
> + *
> + * Copyright 2025 IBM Corp.

Unsure if it's important, but the year might need an increment.

> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <stdlib.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include "s390-ccw.h"
> +#include "sclp.h"
> +#include "secure-ipl.h"
> +
> +static VCStorageSizeBlock vcssb __attribute__((__aligned__(8)));
> +
> +#define for_each_rb_entry(entry, list) \
> +    for (entry = (void *)(list) + sizeof((list)->ipl_info_header); \
> +         (void *)(entry) + sizeof(*(entry)) <= \
> +         (void *)(list) + (list)->ipl_info_header.len; \
> +         entry++)
> +
> +int zipl_secure_get_vcssb(void)
> +{
> +    /* avoid retrieving vcssb multiple times */
> +    if (vcssb.length == VCSSB_LEN_VALID) {
> +        goto out;
> +    }
> +
> +    vcssb.length = VCSSB_LEN_VALID;
> +    if (_diag320(&vcssb, DIAG_320_SUBC_QUERY_VCSI) != DIAG_320_RC_OK) {
> +        vcssb.length = 0;
> +    }
> +
> +out:
> +    return vcssb.length;
> +}
> +
> +static uint32_t request_certificate(uint8_t *cert_buf, uint8_t index)
> +{
> +    VCEntryHeader *vce_hdr;
> +    struct vcb {
> +        VCBlockHeader vcb_hdr;
> +        struct vce {
> +            VCEntryHeader vce_hdr;
> +            uint8_t cert_buf[CERT_BUF_MAX_LEN];
> +        } vce;
> +    } __attribute__((__aligned__(PAGE_SIZE))) vcb = { 0 };
> +
> +    /*
> +     * Request single entry
> +     * Fill input fields of single-entry VCB
> +     *
> +     * First and last index must be equal because only one
> +     * VCE per VCB is currently supported
> +     */
> +    vcb.vcb_hdr.in_len = ROUND_UP(vcssb.max_single_vcb_len, PAGE_SIZE);
> +    vcb.vcb_hdr.first_vc_index = index;
> +    vcb.vcb_hdr.last_vc_index = index;
> +
> +    if (_diag320(&vcb, DIAG_320_SUBC_STORE_VC) != DIAG_320_RC_OK) {
> +        puts("Could not get certificate");
> +        return 0;
> +    }
> +
> +    if (vcb.vcb_hdr.out_len == sizeof(VCBlockHeader)) {
> +        puts("No certificate entry");
> +        return 0;
> +    }
> +
> +    if (vcb.vcb_hdr.remain_ct != 0) {
> +        panic("Not enough memory to store requested certificate");
> +    }
> +
> +    vce_hdr = &vcb.vce.vce_hdr;
> +    if (!(vce_hdr->flags & DIAG_320_VCE_FLAGS_VALID)) {
> +        puts("Invalid certificate");
> +        return 0;
> +    }
> +
> +    memcpy(cert_buf, (uint8_t *)&vcb.vce + vce_hdr->cert_offset, vce_hdr->cert_len);
> +
> +    return vce_hdr->cert_len;
> +}
> +
> +static int cert_list_add(IplSignatureCertificateList *cert_list,
> +                         IplSignatureCertificateEntry cert_entry)
> +{
> +    int cert_entry_idx;
> +
> +    cert_entry_idx = (cert_list->ipl_info_header.len - sizeof(IplInfoBlockHeader)) /
> +                     sizeof(IplSignatureCertificateEntry);
> +
> +    cert_list->cert_entries[cert_entry_idx] = cert_entry;
> +    cert_list->ipl_info_header.len += sizeof(IplSignatureCertificateEntry);
> +
> +    return cert_entry_idx;
> +}
> +
> +static void comp_list_add(IplDeviceComponentList *comp_list,
> +                          IplDeviceComponentEntry comp_entry)
> +{
> +    int comp_entry_idx;
> +
> +    comp_entry_idx = (comp_list->ipl_info_header.len - sizeof(IplInfoBlockHeader)) /
> +                     sizeof(IplDeviceComponentEntry);
> +    if (comp_entry_idx > MAX_COMP_ENTRIES - 1) {
> +        printf("Warning: only %d component entries are supported\n",
> +                MAX_COMP_ENTRIES);
> +        panic("The device component list has reached its maximum capacity");
> +    }
> +
> +    comp_list->device_entries[comp_entry_idx] = comp_entry;
> +    comp_list->ipl_info_header.len += sizeof(IplDeviceComponentEntry);
> +}
> +
> +void update_iirb(IplDeviceComponentList *comp_list,
> +                 IplSignatureCertificateList *cert_list)
> +{
> +    IplInfoReportBlock *iirb;
> +    IplDeviceComponentList *iirb_comps;
> +    IplSignatureCertificateList *iirb_certs;
> +    uint32_t iirb_hdr_len;
> +    uint32_t comps_len;
> +    uint32_t certs_len;
> +
> +    if (iplb->len % 8 != 0) {
> +        panic("IPL parameter block length field value is not multiple of 8 bytes");
> +    }
> +
> +    iirb_hdr_len = sizeof(IplInfoReportBlockHeader);
> +    comps_len = comp_list->ipl_info_header.len;
> +    certs_len = cert_list->ipl_info_header.len;
> +    if ((comps_len + certs_len + iirb_hdr_len) > sizeof(IplInfoReportBlock)) {
> +        panic("Not enough space to hold all components and certificates in IIRB");
> +    }
> +
> +    /* IIRB immediately follows IPLB */
> +    iirb = &ipl_blocks.iirb;
> +    iirb->hdr.len = iirb_hdr_len;
> +
> +    /* Copy IPL device component list after IIRB Header */
> +    iirb_comps = (IplDeviceComponentList *) iirb->info_blks;
> +    memcpy(iirb_comps, comp_list, comps_len);
> +
> +    /* Update IIRB length */
> +    iirb->hdr.len += comps_len;
> +
> +    /* Copy IPL sig cert list after IPL device component list */
> +    iirb_certs = (IplSignatureCertificateList *) (iirb->info_blks +
> +                                                  iirb_comps->ipl_info_header.len);
> +    memcpy(iirb_certs, cert_list, certs_len);
> +
> +    /* Update IIRB length */
> +    iirb->hdr.len += certs_len;
> +}
> +
> +bool secure_ipl_supported(void)
> +{
> +    if (!sclp_is_fac_ipl_flag_on(SCCB_FAC_IPL_SIPL_BIT)) {
> +        puts("Secure IPL Facility is not supported by the hypervisor!");
> +        return false;
> +    }
> +
> +    if (!is_signature_verif_supported()) {
> +        puts("Secure IPL extensions are not supported by the hypervisor!");
> +        return false;
> +    }
> +
> +    if (!is_cert_store_facility_supported()) {
> +        puts("Certificate Store Facility is not supported by the hypervisor!");
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static void init_lists(IplDeviceComponentList *comp_list,
> +                       IplSignatureCertificateList *cert_list)
> +{
> +    comp_list->ipl_info_header.type = IPL_INFO_BLOCK_TYPE_COMPONENTS;
> +    comp_list->ipl_info_header.len = sizeof(IplInfoBlockHeader);
> +
> +    cert_list->ipl_info_header.type = IPL_INFO_BLOCK_TYPE_CERTIFICATES;
> +    cert_list->ipl_info_header.len = sizeof(IplInfoBlockHeader);
> +}
> +
> +static int zipl_load_signature(ComponentEntry *entry, uint64_t sig)
> +{
> +    if (entry->compdat.sig_info.format != DER_SIGNATURE_FORMAT) {
> +        puts("Signature is not in DER format");
> +        return -1;
> +    }
> +
> +    if (zipl_load_segment(entry->data.blockno, sig) < 0) {
> +        return -1;
> +    }
> +
> +    return entry->compdat.sig_info.sig_len;
> +}
> +
> +void update_cert_list(IplSignatureCertificateList *cert_list)
> +{

It took me some time to fully digest what this function is doing.  I
have a suggestion to help provide some clarity:

> +    IplSignatureCertificateEntry *cert_entry;
> +    uint8_t *cert_buf;
> +
> +    /* Recover the original base address of ipl_data for cert storage */

Add: "The IplParameterBlocks stored in ipl_data will no longer be needed
after this point. Reuse this region to store certificates from the BIOS
heap into stable memory."

Maybe some justification on "why" they are no longer needed, but it's a
start.

> +    cert_buf = (uint8_t *)qipl.ipl_data - qipl.index * sizeof(IplParameterBlock);
> +
> +    for_each_rb_entry(cert_entry, cert_list) {
> +        memcpy(cert_buf, (uint8_t *)cert_entry->addr, cert_entry->len);
> +        cert_entry->addr = (uint64_t)cert_buf;
> +        cert_buf += cert_entry->len;
> +    }
> +}
> +
> +int zipl_run_secure(ComponentEntry **entry_ptr, const uint8_t *tmp_sec,
> +                    IplDeviceComponentList *comp_list,
> +                    IplSignatureCertificateList *cert_list,
> +                    uint8_t **tmp_cert_buf)
> +{
> +    /*
> +     * Keep track of which certificate store indices correspond to the
> +     * certificate data entries within the IplSignatureCertificateList to
> +     * prevent allocating space for the same certificate multiple times.
> +     *
> +     * The array index corresponds to the certificate's cert-store index.
> +     *
> +     * The array value corresponds to the certificate's entry within the
> +     * IplSignatureCertificateList (with a value of -1 denoting no entry
> +     * exists for the certificate).
> +     */
> +    int cert_list_table[vcssb.total_vc_ct + 1];
> +    IplSignatureCertificateEntry sig_entry = { 0 };
> +    IplSignatureCertificateEntry cert_entry;
> +    IplDeviceComponentEntry comp_entry;
> +    ComponentEntry *entry = *entry_ptr;
> +    int rc = -1;
> +    int sig_len = 0;
> +    int comp_len;
> +    int cert_entry_idx;
> +    uint64_t comp_addr;
> +    uint8_t cert_table_idx;
> +    uint8_t *tmp_buf;
> +    bool verified;
> +    bool signed_found = false;
> +
> +    if ((MAX_SIGNED_COMP * CERT_BUF_MAX_LEN) > CERT_BUF_SIZE) {
> +        panic("Not enough memory to store certificates");
> +    }
> +    *tmp_cert_buf = malloc(CERT_BUF_SIZE);
> +    tmp_buf = *tmp_cert_buf;
> +
> +    init_lists(comp_list, cert_list);
> +    sig_entry.addr = (uint64_t)malloc(MAX_SECTOR_SIZE);
> +    memset(cert_list_table, -1, sizeof(cert_list_table));
> +
> +    while (entry->component_type != ZIPL_COMP_ENTRY_EXEC) {
> +        switch (entry->component_type) {
> +        case ZIPL_COMP_ENTRY_SIGNATURE:
> +            if (sig_entry.len) {
> +                goto error;
> +            }
> +
> +            sig_len = zipl_load_signature(entry, sig_entry.addr);
> +            if (sig_len < 0) {
> +                goto error;
> +            }
> +
> +            sig_entry.len = sig_len;
> +            break;
> +        case ZIPL_COMP_ENTRY_LOAD:
> +            comp_addr = entry->compdat.load_addr;
> +            comp_len = zipl_load_segment(entry->data.blockno, comp_addr);
> +            if (comp_len < 0) {
> +                goto error;
> +            }
> +
> +            comp_entry = (IplDeviceComponentEntry){ 0 };
> +            comp_entry.addr = comp_addr;
> +            comp_entry.len = (uint64_t)comp_len;
> +
> +            /* no signature present (unsigned component) */
> +            if (!sig_entry.len) {
> +                comp_list_add(comp_list, comp_entry);
> +                break;
> +            }
> +
> +            /*
> +             * Initialize with SC flag (signed component)
> +             * CSV flag set upon successful verification
> +             */
> +            comp_entry.flags = S390_IPL_DEV_COMP_FLAG_SC;
> +            signed_found = true;
> +
> +            cert_entry = (IplSignatureCertificateEntry) { 0 };
> +            verified = verify_signature(comp_entry, sig_entry,
> +                                        &cert_entry.len, &cert_table_idx);
> +
> +            if (verified) {
> +                if (cert_list_table[cert_table_idx] == -1) {
> +                    if (!request_certificate(tmp_buf, cert_table_idx)) {
> +                        puts("Could not get certificate");
> +                        goto error;
> +                    }
> +
> +                    cert_entry.addr = (uint64_t)tmp_buf;
> +                    cert_entry_idx = cert_list_add(cert_list, cert_entry);
> +                    /* map cert-store index to cert-list entry index */
> +                    cert_list_table[cert_table_idx] = cert_entry_idx;
> +                    /* increment for the next certificate */
> +                    tmp_buf += cert_entry.len;
> +                }
> +
> +                comp_entry.cert_index = cert_list_table[cert_table_idx];
> +                comp_entry.flags |= S390_IPL_DEV_COMP_FLAG_CSV;
> +                puts("Verified component");
> +            } else {
> +                zipl_secure_error("Could not verify component");
> +            }
> +
> +            comp_list_add(comp_list, comp_entry);
> +
> +            /* After a signature is used another new one can be accepted */
> +            sig_entry.len = 0;
> +            break;
> +        default:
> +            puts("Unknown component entry type");
> +            goto error;
> +        }
> +
> +        entry++;
> +
> +        if ((uint8_t *)(&entry[1]) > tmp_sec + MAX_SECTOR_SIZE) {
> +            puts("Wrong entry value");
> +            rc = -EINVAL;
> +            goto error;
> +        }
> +    }
> +
> +    if (!signed_found) {
> +        zipl_secure_error("Secure boot is on, but components are not signed");
> +    }
> +
> +    *entry_ptr = entry;
> +    free((void *)sig_entry.addr);
> +
> +    return 0;
> +error:
> +    free(*tmp_cert_buf);
> +    *tmp_cert_buf = NULL;
> +    free((void *)sig_entry.addr);
> +
> +    return rc;
> +}
> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
> new file mode 100644
> index 0000000000..e192f8b61d
> --- /dev/null
> +++ b/pc-bios/s390-ccw/secure-ipl.h
> @@ -0,0 +1,115 @@
> +/*
> + * S/390 Secure IPL
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef _PC_BIOS_S390_CCW_SECURE_IPL_H
> +#define _PC_BIOS_S390_CCW_SECURE_IPL_H
> +
> +#include "bootmap.h"
> +#include <diag320.h>
> +#include <diag508.h>
> +
> +#define MAX_SIGNED_COMP     3
> +
> +int zipl_secure_get_vcssb(void);
> +bool secure_ipl_supported(void);
> +void update_iirb(IplDeviceComponentList *comp_list,
> +                 IplSignatureCertificateList *cert_list);
> +void update_cert_list(IplSignatureCertificateList *cert_list);
> +int zipl_run_secure(ComponentEntry **entry_ptr, const uint8_t *tmp_sec,
> +                    IplDeviceComponentList *comp_list,
> +                    IplSignatureCertificateList *cert_list,
> +                    uint8_t **tmp_cert_buf);
> +
> +static inline void zipl_secure_error(const char *message)
> +{
> +    switch (boot_mode) {
> +    case ZIPL_BOOT_MODE_SECURE_AUDIT:
> +        printf("AUDIT MODE WARNING: %s\n", message);
> +        break;
> +    default:
> +        break;

I wonder if the default case should result in a more powerful response
than just silently ignoring a message?  With this patch's context, the
only other mode that could enter default is ZIPL_BOOT_MODE_NORMAL, but
that mode should *never* be touching secure IPL paths.

Perhaps a comment like "errors ignored on non-secure modes" to signal to
the developer that this should only be used for the SECURE modes would
suffice... just to make things clear at-a-glance.

[...]

-- 
Regards,
  Collin

