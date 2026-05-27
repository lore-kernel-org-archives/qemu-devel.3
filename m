Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC96CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 23:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSNJv-0004qg-Dv; Wed, 27 May 2026 19:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wSNJs-0004q5-J0; Wed, 27 May 2026 19:05:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wSNJm-0005qO-VC; Wed, 27 May 2026 19:05:46 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RL72Rg3427028; Wed, 27 May 2026 23:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/z8epm
 DK8gpbJ3mTKid2ZixuFRYOZMkCrWHmFkKi5YU=; b=HPDn9DsXkSJoq3ValuoMZh
 Iz1XnVvkQhq3fQQJLv71Y1TR+AZcrgVOlr3DW4lR+U/ueL7Ljium7ZFjcFgtge2h
 VawUmr6wq+Gz+V1u39ZuNyS4+oXkeV33JqrEkPBOHRZkfXdR4yzD0Ve3MaPtTTZ6
 QNY6TPEasKkOZJeXe5wtdI9XTkDVV3KESMimaL/BMt3PXLvfpF3O6avOUS2ZMKYZ
 zaoHICbJVui3L9SlgQLknYiiWEPkooJTUlLnwt7lrKDRGC7+PzPAflGXjGvNyGH7
 4J98GIuXlXWrdppXeQuwtMUqFwLn/Zm4Tak/yBsBXt7n+FG5xtVUG3cgPwp+UvAw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884gb5s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 May 2026 23:05:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64RMsLjg023553;
 Wed, 27 May 2026 23:05:34 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrb5dtk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 May 2026 23:05:34 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64RN5WA227787792
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 May 2026 23:05:33 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9329858050;
 Wed, 27 May 2026 23:05:32 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 46C6158045;
 Wed, 27 May 2026 23:05:30 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 27 May 2026 23:05:30 +0000 (GMT)
Message-ID: <376f419f-764f-48f7-9867-0706ba3f7e62@linux.ibm.com>
Date: Wed, 27 May 2026 19:05:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v11 21/32] pc-bios/s390-ccw: Add signature verification
 for secure IPL in audit mode
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260505201905.997996-1-zycai@linux.ibm.com>
 <20260505201905.997996-22-zycai@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260505201905.997996-22-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a1778bf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=fUcGyWQay5-ygqJEK4QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: U0xnmzuYYPbMO29c_5yEreQJ2CbDpdUF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDIyNiBTYWx0ZWRfX9XzkGMbXCR7C
 Tzl9coo1ptRZBKuEdgqJAbKGszCMQTy6xawyVuUS5l/Qp/29IXHblpnyGzWdrz35TcmH3vFWmmd
 o2wHgRJMuH/tnyXb0L/kEp6PIJDJoSPEeGIZ6o7I5WkYbDSHqGGDjbaLCXD4N1cVwyDhxMZn7Mv
 tSvrVYXUPH5uQtVqgTmBq0eTPXN867tzGAwxKZGFv79ckw8n7N3xKvIfA63VGAYDQ0FxZnp5mk8
 UpfANG6LGvSg/qR1lzlhEpWXl7S68b0Qavs30AQ/TLlKq0sbruptdJCD/Y8JhXiux6J/6RcXLRG
 z1j51XP6j0AcyHnjbuJtD9hG5X1FSNH23/9NkEOQLd1eB4SiVjS0dq0Vecy0vmOBf+REMa3APY+
 kM/PVGtb482nrAl38/d9hrvOl5wlr4Hj+PkKmwkR58OwIalN+qIOQF8DTefeJhSj7c3VAB54oCq
 2wfGHB/pRuBYVc7LS8w==
X-Proofpoint-GUID: U0xnmzuYYPbMO29c_5yEreQJ2CbDpdUF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605270226
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/5/26 16:18, Zhuoying Cai wrote:
> Enable secure IPL in audit mode, which performs signature verification,
> but any error does not terminate the boot process. Only warnings will be
> logged to the console instead.
> 
> Add a comp_len variable to store the length of a segment in
> zipl_load_segment. comp_len variable is necessary to store the
> calculated segment length and is used during signature verification.
> Return the length on success, or a negative return code on failure.

Not sure I understand this part of the commit message. Maybe omit?

> 
> Secure IPL in audit mode requires at least one certificate provided in
> the key store along with necessary facilities (Secure IPL Facility,
> Certificate Store Facility and secure IPL extension support).
> 
> Note: Secure IPL in audit mode is implemented for the SCSI scheme of
> virtio-blk/virtio-scsi devices.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  docs/system/s390x/secure-ipl.rst |  15 ++
>  pc-bios/s390-ccw/Makefile        |   2 +-
>  pc-bios/s390-ccw/bootmap.c       |  16 ++
>  pc-bios/s390-ccw/bootmap.h       |   9 +
>  pc-bios/s390-ccw/main.c          |  10 +-
>  pc-bios/s390-ccw/s390-ccw.h      |  24 ++
>  pc-bios/s390-ccw/sclp.c          |  27 +++
>  pc-bios/s390-ccw/sclp.h          |   6 +
>  pc-bios/s390-ccw/secure-ipl.c    | 364 +++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/secure-ipl.h    | 113 ++++++++++
>  10 files changed, 584 insertions(+), 2 deletions(-)
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
> index 667a69f80d..a300fba8cd 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -15,6 +15,7 @@
>  #include "bootmap.h"
>  #include "virtio.h"
>  #include "bswap.h"
> +#include "secure-ipl.h"
>  
>  #ifdef DEBUG
>  /* #define DEBUG_FALLBACK */
> @@ -737,6 +738,9 @@ static int zipl_run(ScsiBlockPtr *pte)
>      case ZIPL_BOOT_MODE_NORMAL:
>          rc = zipl_run_normal(&entry, tmp_sec);
>          break;
> +    case ZIPL_BOOT_MODE_SECURE_AUDIT:
> +        rc = zipl_run_secure(&entry, tmp_sec);
> +        break;
>      default:
>          panic("Unknown boot mode");
>      }
> @@ -1107,6 +1111,18 @@ static int zipl_load_vscsi(void)
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
> index 8d61ac383c..1e00454a1f 100644
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
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 66544f75f5..0bcd32b059 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -394,7 +394,15 @@ void main(void)
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
> +    default:
> +        break;
> +    }
>  
>      while (have_iplb) {
>          boot_setup();
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 5420443ad2..b66a9b50bf 100644
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
> @@ -71,10 +89,16 @@ void zipl_load(void);
>  
>  typedef enum ZiplBootMode {
>      ZIPL_BOOT_MODE_NORMAL = 0,
> +    ZIPL_BOOT_MODE_SECURE_AUDIT = 1,
>  } ZiplBootMode;
>  
>  extern ZiplBootMode boot_mode;
>  
> +ZiplBootMode get_boot_mode(uint8_t hdr_flags);
> +
> +/* secure-ipl.c */
> +bool secure_ipl_supported(void);
> +
>  /* jump2ipl.c */
>  void write_reset_psw(uint64_t psw);
>  int jump_to_IPL_code(uint64_t address);
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

Let's make a note for future work (outside the scope of these patches)
to rework the service calls to get the read scp info.  Ideally, the call
should happen once and the necessary data (loadparm, facility bits, etc)
can be referenced when needed.

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
> index 0000000000..6e943446a7
> --- /dev/null
> +++ b/pc-bios/s390-ccw/secure-ipl.c
> @@ -0,0 +1,364 @@
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
> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <stdlib.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include "bootmap.h"
> +#include "s390-ccw.h"
> +#include "sclp.h"
> +#include "secure-ipl.h"
> +
> +static VCStorageSizeBlock vcssb __attribute__((__aligned__(8)));
> +
> +VCStorageSizeBlock *zipl_secure_get_vcssb(void)
> +{

The return is never captured (only checked).  Since the vcssb is global
and set within the function anyway, it would be a lot cleaner to just
call this function near the beginning of zipl_run_secure() and return
success/fail values.  If the DIAG 320 cert store cannot be queried, then
secure IPL can't proceed.

Handle the errors accordingly.

> +    /* avoid retrieving vcssb multiple times */
> +    if (vcssb.length == VCSSB_MIN_LEN) {
> +        return &vcssb;
> +    }
> +
> +    vcssb.length = VCSSB_MIN_LEN;
> +    if (_diag320(&vcssb, DIAG_320_SUBC_QUERY_VCSI) != DIAG_320_RC_OK) {
> +        vcssb.length = 0;
> +        return NULL;
> +    }
> +
> +    return &vcssb;
> +}
> +
> +static uint32_t get_total_certs_length(void)
> +{
> +    if (zipl_secure_get_vcssb() == NULL) {
> +        return 0;
> +    }> +
> +    return vcssb.total_vcb_len - sizeof(VCBlockHeader) -
> +           vcssb.total_vc_ct * sizeof(VCEntryHeader);
> +}

The function is used when allocating mem for cert_buf... what happens
when the value is 0?  This could happen if vcssb wasn't queried, or if
the calculation returns 0 (possible if there aren't any certs).

I understand sig verif would need to return true before we enter the
code that would attempt to store cert data (which I guess wouldn't if
there aren't any certs?), but it seems dangerous to have a variable that
was malloc(0)'d floating around...

> +
> +static uint32_t request_certificate(uint8_t *cert_buf, uint8_t index)
> +{
> +    VCEntryHeader *vce_hdr;
> +    struct vcb {
> +        VCBlockHeader vcb_hdr;
> +        struct vce {
> +            VCEntryHeader vce_hdr;
> +            uint8_t cert_buf[CERT_BUF_MAX_LEN];

Use vsccb->max_single_vcb_len here.

If the CERT_BUF_MAX_LEN bound is still required, then it belongs in the
cert store or DIAG 320 logic -- if the user tries to store a certificate
that exceeds this bound, then don't allow it to be stored at all (and
let the user know why with an error).

> +        } vce;
> +    } __attribute__((__aligned__(4096))) vcb = { 0 };
> +
> +    /* Get Verification Certificate Storage Size block with DIAG320 subcode 1 */
> +    if (zipl_secure_get_vcssb() == NULL) {
> +        return 0;
> +    }
> +
> +    /*
> +     * Request single entry
> +     * Fill input fields of single-entry VCB
> +     *
> +     * First and last index must be equal because only one
> +     * VCE per VCB is currently supported
> +     */

The last sentence is misleading because it seems like the DIAG 320
implementation *only* allows for a single VCE to be retrieved, but in
reality it allows for a range of entries to be retrieved.

> +    vcb.vcb_hdr.in_len = ROUND_UP(vcssb.max_single_vcb_len, PAGE_SIZE);
> +    vcb.vcb_hdr.first_vc_index = index;
> +    vcb.vcb_hdr.last_vc_index = index;
> +
> +    if (_diag320(&vcb, DIAG_320_SUBC_STORE_VC) != DIAG_320_RC_OK) {
> +        return 0;

Maybe move the puts("Could not get certificate"); to here so it's
consistent with the other error cases?

> +    }
> +
> +    if (vcb.vcb_hdr.out_len == sizeof(VCBlockHeader)) {
> +        puts("No certificate entry");
> +        return 0;
> +    }
> +
> +    if (vcb.vcb_hdr.remain_ct != 0) {
> +        panic("Not enough memory to store all requested certificates");

Shouldn't this be "to store requested certificate" since this function
aims to request only one cert?

Also, is there a reason for the panic? Why not just puts and return 0
like the rest? The program will still terminate, but a little more
gracefully that way.

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
> +                         uint8_t *cert_buf, uint64_t cert_len)
> +{

See below where I mention a change to comp_list_add: same idea for this
function with an IplSignatureCertificateEntry parameter.

> +    static bool warned;
> +    int cert_entry_idx;
> +
> +    cert_entry_idx = (cert_list->ipl_info_header.len - sizeof(IplInfoBlockHeader)) /
> +                     sizeof(IplSignatureCertificateEntry);
> +    if (cert_entry_idx > MAX_CERTIFICATES - 1) {

The certificate store, cert table, and cert list are all bounded by
MAX_CERTIFICATES (64).  Would this check ever occur?

> +        if (!warned) {
> +            printf("Warning: only %d cert entries are supported;"
> +                   " additional entries are ignored\n",
> +                   MAX_CERTIFICATES);
> +            warned = true;
> +        }
> +        return cert_entry_idx;
> +    }
> +
> +    cert_list->cert_entries[cert_entry_idx].addr = (uint64_t)cert_buf;
> +    cert_list->cert_entries[cert_entry_idx].len = cert_len;
> +    cert_list->ipl_info_header.len += sizeof(IplSignatureCertificateEntry);
> +
> +    return cert_entry_idx;
> +}
> +
> +static void comp_list_add(IplDeviceComponentList *comp_list,
> +                          SecureIplCompEntryInfo comp_entry_info)
> +{

This function could be passed an IplDeviceComponentEntry entry
parameter. Then this function becomes:

// get idx

// bounds check

comp_list->device_entries[compy_entry_idx] = entry;

// update header len

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
> +    comp_list->device_entries[comp_entry_idx].addr = comp_entry_info.addr;
> +    comp_list->device_entries[comp_entry_idx].len = comp_entry_info.len;
> +    comp_list->device_entries[comp_entry_idx].flags = comp_entry_info.flags;
> +    /* cert index field is meaningful only when S390_IPL_DEV_COMP_FLAG_SC is set */
> +    if (comp_entry_info.flags & S390_IPL_DEV_COMP_FLAG_SC) {
> +        comp_list->device_entries[comp_entry_idx].cert_index =
> +                                                  comp_entry_info.cert_index;
> +    }

Does this flag need to be checked at all?  Before comp_list_add is
called, the S390_IPL_DEV_COMP_FLAG_SC seems to have been unconditionally
set beforehand anyway.

Or did you mean to check if S390_IPL_DEV_COMP_FLAG_CSV was set (which
means the index was set).

Regardless, if this is changed to be passed an IplDeviceComponentEntry,
then the check isn't necessary since all the logic for setting the
fields in the entry should be handled prior to the call to this function.

> +    comp_list->ipl_info_header.len += sizeof(IplDeviceComponentEntry);
> +}
> +
> +static void update_iirb(IplDeviceComponentList *comp_list,
> +                        IplSignatureCertificateList *cert_list)
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
> +    iirb = &ipl_data.iirb;
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
> +int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
> +{
> +    IplDeviceComponentList comp_list = { 0 };
> +    IplSignatureCertificateList cert_list = { 0 };
> +    SecureIplCompEntryInfo sig_entry_info = { 0 };
> +    SecureIplCompEntryInfo comp_entry_info;

Wouldn't an IplSignatureCertificateEntry and IplDeviceComponentEntry
suffice here instead?  Then the info structs can go away.

(I acknowledge I suggested the info structs previously as a means to
reduce parameters passed to certain functions, but I missed that the
existing structs should be sufficient).

> +    ComponentEntry *entry = *entry_ptr;
> +    uint8_t *cert_buf = NULL;
> +    int sig_len = 0;
> +    int comp_len;
> +    int cert_entry_idx;
> +    uint64_t comp_addr;
> +    uint64_t cert_len;
> +    uint8_t cert_table_idx;
> +    bool verified;
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
> +    int cert_list_table[MAX_CERTIFICATES] = { [0 ... MAX_CERTIFICATES - 1] = -1 };

Use vcssb->max_vc_ct or total_vc_ct.  The value comes out the same, but
it allows the code in the BIOS to be closer tied to the DIAG 320 and
S390 cert store bounds.

This would ensure that the table has enough space to account for all
certificates in the store.

Also keep in mind: verify_signature will return idx +1 to align with the
DIAG 320 cert store indexing.  This means it's possible the function
could return a value equal to MAX_CERTIFICATES + 1, which exceeds the
buffer.

> +    int signed_count = 0;
> +
> +    init_lists(&comp_list, &cert_list);
> +    cert_buf = malloc(get_total_certs_length());

Are we certain this memory won't get clobbered after the BIOS exits?
From what I understand, kernel boot startup will read the IIRB from
lowcore (protected area) and then copy each cert from the addresses into
some memory region managed by the kernel (protected) and later loaded
into the platform keyring.

However, cert_buf exists on the heap (unprotected). Does this memory get
reclaimed between BIOS exit and the kernel starts to boot? What protects
this memory so that the kernel can successfully read from the addresses?

Maybe the timing just works out and this is an overthought... but the
design seems fragile..?

The same questions stand for the component addresses as well.

> +    sig_entry_info.addr = (uint64_t)malloc(MAX_SECTOR_SIZE);
> +
> +    while (entry->component_type != ZIPL_COMP_ENTRY_EXEC) {
> +        switch (entry->component_type) {
> +        case ZIPL_COMP_ENTRY_SIGNATURE:
> +            if (sig_entry_info.len) {
> +                goto out;
> +            }
> +
> +            sig_len = zipl_load_signature(entry, sig_entry_info.addr);
> +            if (sig_len < 0) {
> +                goto out;
> +            }
> +
> +            sig_entry_info.len = sig_len;
> +            break;
> +        case ZIPL_COMP_ENTRY_LOAD:
> +            comp_addr = entry->compdat.load_addr;
> +            comp_len = zipl_load_segment(entry->data.blockno, comp_addr);
> +            if (comp_len < 0) {
> +                goto out;
> +            }
> +
> +            comp_entry_info = (SecureIplCompEntryInfo){ 0 };
> +            comp_entry_info.addr = comp_addr;
> +            comp_entry_info.len = (uint64_t)comp_len;
> +
> +            /* no signature present (unsigned component) */
> +            if (!sig_entry_info.len) {
> +                break;
> +            }
> +
> +            /*
> +             * Initialize with SC flag (signed component)
> +             * CSV flag set upon successful verification
> +             */
> +            comp_entry_info.flags = S390_IPL_DEV_COMP_FLAG_SC;
> +
> +            verified = verify_signature(comp_entry_info, sig_entry_info,
> +                                        &cert_len, &cert_table_idx);
> +
> +            if (verified) {
> +                if (cert_list_table[cert_table_idx] == -1) {
> +                    if (!request_certificate(cert_buf, cert_table_idx)) {
> +                        puts("Could not get certificate");
> +                        goto out;
> +                    }
> +
> +                    cert_entry_idx = cert_list_add(&cert_list, cert_buf, cert_len);
> +                    /* map cert-store index to cert-list entry index */
> +                    cert_list_table[cert_table_idx] = cert_entry_idx;
> +                    /* increment for the next certificate */
> +                    cert_buf += cert_len;
> +                }
> +
> +                comp_entry_info.cert_index = cert_list_table[cert_table_idx];
> +                comp_entry_info.flags |= S390_IPL_DEV_COMP_FLAG_CSV;
> +                puts("Verified component");
> +            } else {
> +                zipl_secure_error("Could not verify component");
> +            }
> +
> +            comp_list_add(&comp_list, comp_entry_info);
> +
> +            signed_count += 1;
> +            /* After a signature is used another new one can be accepted */
> +            sig_entry_info.len = 0;
> +            break;
> +        default:
> +            puts("Unknown component entry type");
> +            return -1;
> +        }
> +
> +        entry++;
> +
> +        if ((uint8_t *)(&entry[1]) > tmp_sec + MAX_SECTOR_SIZE) {
> +            puts("Wrong entry value");
> +            return -EINVAL;
> +        }

For the two return cases above, should cert_buf be freed?

> +    }
> +
> +    if (signed_count == 0) {
> +        zipl_secure_error("Secure boot is on, but components are not signed");
> +    }
> +
> +    update_iirb(&comp_list, &cert_list);
> +
> +    *entry_ptr = entry;
> +    free((void *)sig_entry_info.addr);
> +
> +    return 0;
> +out:

This is an error path, not out path.

> +    free(cert_buf);
> +    free((void *)sig_entry_info.addr);
> +
> +    return -1;
> +}
> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
> new file mode 100644
> index 0000000000..cc0302f56b
> --- /dev/null
> +++ b/pc-bios/s390-ccw/secure-ipl.h
> @@ -0,0 +1,113 @@
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
> +#include <diag320.h>
> +#include <diag508.h>
> +
> +VCStorageSizeBlock *zipl_secure_get_vcssb(void);
> +int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec);
> +
> +/* Custom struct for secure IPL component entry information */
> +typedef struct SecureIplCompEntryInfo {
> +    uint64_t addr;
> +    uint64_t len;
> +    uint16_t cert_index;
> +    uint8_t  flags;
> +} SecureIplCompEntryInfo;
> +
> +static inline void zipl_secure_error(const char *message)
> +{
> +    switch (boot_mode) {
> +    case ZIPL_BOOT_MODE_SECURE_AUDIT:
> +        printf("AUDIT MODE WARNING: %s\n", message);
> +        break;
> +    default:
> +        break;
> +    }
> +}
> +
> +static inline uint64_t _diag320(void *data, unsigned long subcode)
> +{
> +    register unsigned long addr asm("0") = (unsigned long)data;
> +    register unsigned long rc asm("1") = 0;
> +
> +    asm volatile ("diag %0,%2,0x320\n"
> +                  : "+d" (addr), "+d" (rc)
> +                  : "d" (subcode)
> +                  : "memory", "cc");
> +    return rc;
> +}
> +
> +static inline bool is_cert_store_facility_supported(void)
> +{
> +    uint32_t d320_ism;
> +
> +    if (!sclp_is_diag320_on()) {
> +        return false;
> +    }
> +
> +    if (_diag320(&d320_ism, DIAG_320_SUBC_QUERY_ISM) != DIAG_320_RC_OK) {
> +        return false;
> +    }
> +
> +    return d320_ism & (DIAG_320_ISM_QUERY_VCSI | DIAG_320_ISM_STORE_VC);
> +}
> +
> +static inline uint64_t _diag508(void *data, unsigned long subcode)
> +{
> +    register unsigned long addr asm("0") = (unsigned long)data;
> +    register unsigned long rc asm("1") = 0;
> +
> +    asm volatile ("diag %0,%2,0x508\n"
> +                  : "+d" (addr), "+d" (rc)
> +                  : "d" (subcode)
> +                  : "memory", "cc");
> +    return rc;
> +}
> +
> +static inline bool is_signature_verif_supported(void)
> +{
> +    uint64_t d508_subcodes;
> +
> +    d508_subcodes = _diag508(NULL, DIAG_508_SUBC_QUERY_SUBC);
> +    return d508_subcodes & DIAG_508_SUBC_SIG_VERIF;
> +}
> +
> +static inline bool verify_signature(SecureIplCompEntryInfo comp_entry_info,
> +                                    SecureIplCompEntryInfo sig_entry_info,
> +                                    uint64_t *cert_len, uint8_t *cert_idx)
> +{
> +    Diag508SigVerifBlock svb;
> +
> +    svb.length = sizeof(Diag508SigVerifBlock);
> +    svb.version = 0;
> +    svb.comp_len = comp_entry_info.len;
> +    svb.comp_addr = comp_entry_info.addr;
> +    svb.sig_len = sig_entry_info.len;
> +    svb.sig_addr = sig_entry_info.addr;
> +
> +    if (_diag508(&svb, DIAG_508_SUBC_SIG_VERIF) == DIAG_508_RC_OK) {
> +        *cert_len = svb.cert_len;
> +        /*
> +         * DIAG 508 utilizes an index origin of 0 when indexing the cert store.
> +         * The cert_idx will be used for DIAG 320 data structures, which expects
> +         * an index origin of 1. Account for the offset here so it's easier to
> +         * manage later.
> +         */
> +        *cert_idx = svb.cert_store_index + 1;
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +#endif /* _PC_BIOS_S390_CCW_SECURE_IPL_H */


-- 
Regards,
  Collin

