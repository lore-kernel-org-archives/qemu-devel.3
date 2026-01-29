Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEFFD73E84
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 19:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlXYe-00031L-SF; Thu, 29 Jan 2026 14:20:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vlXY9-0002Vy-5R; Thu, 29 Jan 2026 14:19:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vlXY3-00057y-EK; Thu, 29 Jan 2026 14:19:27 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60TF2Xpc012077;
 Thu, 29 Jan 2026 19:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3J8P0X
 qzj/e3UsYy5ULnSZqekuspJ5tmxctj9CNMEvg=; b=EaY8oDdG6qsn8DOt77kWMa
 He8HrSjecV34cMB0Bahbok/cwYY0vjauNfoEqrG+9151h9eP56ceYldkVyUEc4w2
 UOtslTYwg9kmCGuUk1rlQvIMtrNmuUDsJx7QgYMGZ4Q/9mF2Lh9xJbW519nDlWzs
 pnvD/s4P0NPIsLmXiZIdF/wd2i9DRcdVuE+wbOK4hyh2izrwwquc5bKYiCueTVdn
 INoQmS8fdWb0lBx0Ht5m7JPF1sDXJ9JSk7m5NfZY82Sa1iCZ+uWVZhvvX2CZnFNm
 8UgvKF1cYJllKgPzE9r8/x4DtHFGTDqOTQqhd2OPtZ0AtApA4pzwFJ+Rs+sDRmYA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnr6fmfm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 19:19:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60THRceW018303;
 Thu, 29 Jan 2026 19:19:17 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwb4231tu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 19:19:17 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60TJJFmu48169264
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jan 2026 19:19:15 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 10BCD5805D;
 Thu, 29 Jan 2026 19:19:15 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EFF1858058;
 Thu, 29 Jan 2026 19:19:13 +0000 (GMT)
Received: from [9.12.79.241] (unknown [9.12.79.241])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Jan 2026 19:19:13 +0000 (GMT)
Message-ID: <c8331857-02a8-4b22-8587-3834cb1a2e4d@linux.ibm.com>
Date: Thu, 29 Jan 2026 14:19:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 19/29] pc-bios/s390-ccw: Add signature verification for
 secure IPL in audit mode
To: Collin Walling <walling@linux.ibm.com>, thuth@redhat.com,
 berrange@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 brueckner@linux.ibm.com
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-20-zycai@linux.ibm.com>
 <48169821-01a4-4e9f-b301-94d430afe8af@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <48169821-01a4-4e9f-b301-94d430afe8af@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEzOCBTYWx0ZWRfXz0mUTCemkMFH
 yxVQemPkLZHJ092+wAOxdbW20TqaUpFiTcKFFOOhM1v5pxoMaS8iNIvkgJMjSzq/0ayUozo4jJs
 J2joPV2qiEmypsY6mGqBK9G1mZVpe+rKKeFBbrsTMcEqAnpaG+rleTYYHQc3dcz/nUsRJLSm0tf
 ABmaetMXjmDB1S2cSI+dQFruCClQz+Ht1YSxDymE6virjGMuK8VtarCL+xKA6re//+qhgwo94RY
 2cDpBQd7+Ygzals4jZSx0F19ZeVGhZDYY8t4gPTg0DicivzsZXX5vnj+eLBJGfkPwdUR4WMBfKx
 5b7rY2Svx6jJVrZei4s4CnJxGgvpu8+lfxKLdUm7l4ImYmKcm60rLs3gxcf81WqZpV+0mhKb29i
 2WfEVi4KQtR6sMJbGdTI/SPLBvbe5OAlAUdZ9CLjdPG8xpUiWl0i+/BZW2+M1brjQdW2EvuQzrb
 F8sdiRrdm4wig1ogInw==
X-Proofpoint-GUID: DYukmOmAo-4WURKXnZa00uyC9V-jpwKK
X-Proofpoint-ORIG-GUID: DYukmOmAo-4WURKXnZa00uyC9V-jpwKK
X-Authority-Analysis: v=2.4 cv=X+Vf6WTe c=1 sm=1 tr=0 ts=697bb2b6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=nXu4I0ZMhRbYlncBTn8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601290138
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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

Thanks for reviewing!

On 1/24/26 1:13 PM, Collin Walling wrote:
> On 12/8/25 16:32, Zhuoying Cai wrote:
>> Enable secure IPL in audit mode, which performs signature verification,
>> but any error does not terminate the boot process. Only warnings will be
>> logged to the console instead.
>>
>> Add a comp_len variable to store the length of a segment in
>> zipl_load_segment. comp_len variable is necessary to store the
>> calculated segment length and is used during signature verification.
>> Return the length on success, or a negative return code on failure.
>>
>> Secure IPL in audit mode requires at least one certificate provided in
>> the key store along with necessary facilities (Secure IPL Facility,
>> Certificate Store Facility and secure IPL extension support).
>>
>> Note: Secure IPL in audit mode is implemented for the SCSI scheme of
>> virtio-blk/virtio-scsi devices.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>  docs/system/s390x/secure-ipl.rst |  34 +++
>>  pc-bios/s390-ccw/Makefile        |   3 +-
>>  pc-bios/s390-ccw/bootmap.c       |  44 +++-
>>  pc-bios/s390-ccw/bootmap.h       |  11 +
>>  pc-bios/s390-ccw/main.c          |   9 +
>>  pc-bios/s390-ccw/s390-ccw.h      |  15 ++
>>  pc-bios/s390-ccw/sclp.c          |  44 ++++
>>  pc-bios/s390-ccw/sclp.h          |   6 +
>>  pc-bios/s390-ccw/secure-ipl.c    | 383 +++++++++++++++++++++++++++++++
>>  pc-bios/s390-ccw/secure-ipl.h    |  94 ++++++++
>>  10 files changed, 638 insertions(+), 5 deletions(-)
>>  create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>>  create mode 100644 pc-bios/s390-ccw/secure-ipl.h
>>
>> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
>> index 0a02f171b4..8958a51f0b 100644
>> --- a/docs/system/s390x/secure-ipl.rst
>> +++ b/docs/system/s390x/secure-ipl.rst
>> @@ -18,3 +18,37 @@ Note: certificate files must have a .pem extension.
>>  .. code-block:: shell
>>  
>>      qemu-system-s390x -machine s390-ccw-virtio,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
>> +
>> +
>> +IPL Modes
>> +=========
>> +Multiple IPL modes are available to differentiate between the various IPL
>> +configurations. These modes are mutually exclusive and enabled based on the
>> +``boot-certs`` option on the QEMU command line.
>> +
>> +Normal Mode
>> +-----------
>> +
>> +The absence of certificates will attempt to IPL a guest without secure IPL
>> +operations. No checks are performed, and no warnings/errors are reported.
>> +This is the default mode.
>> +
>> +Configuration:
>> +
>> +.. code-block:: shell
>> +
>> +    qemu-system-s390x -machine s390-ccw-virtio ...
>> +
>> +Audit Mode
>> +----------
>> +
>> +With *only* the presence of certificates in the store, it is assumed that secure
>> +boot operations should be performed with errors reported as warnings. As such,
>> +the secure IPL operations will be performed, and any errors that stem from these
>> +operations will result in a warning.
> 
> I think both sentences are saying the same thing.  How about:
> 
> "When the certificate store is populated with at least one certificate
> and no additional secure IPL parameters are provided on the command
> line, then secure IPL will proceed in "audit mode". All secure IPL
> operations will be performed with signature verification errors reported
> as non-disruptive warnings."
> 
>> +
>> +Configuration:
>> +
>> +.. code-block:: shell
>> +
>> +    qemu-system-s390x -machine s390-ccw-virtio,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
>> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
>> index a0f24c94a8..603761a857 100644
>> --- a/pc-bios/s390-ccw/Makefile
>> +++ b/pc-bios/s390-ccw/Makefile
>> @@ -34,7 +34,8 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
>>  .PHONY : all clean build-all distclean
>>  
>>  OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
>> -	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o
>> +	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
>> +	  secure-ipl.o
>>  
>>  SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
>>  
>> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
>> index 9a03eab6ed..342772860b 100644
>> --- a/pc-bios/s390-ccw/bootmap.c
>> +++ b/pc-bios/s390-ccw/bootmap.c
>> @@ -15,6 +15,7 @@
>>  #include "bootmap.h"
>>  #include "virtio.h"
>>  #include "bswap.h"
>> +#include "secure-ipl.h"
>>  
>>  #ifdef DEBUG
>>  /* #define DEBUG_FALLBACK */
>> @@ -617,7 +618,7 @@ static int ipl_eckd(void)
>>   * Returns: length of the segment on success,
>>   *          negative value on error.
>>   */
>> -static int zipl_load_segment(ComponentEntry *entry, uint64_t address)
>> +int zipl_load_segment(ComponentEntry *entry, uint64_t address)
>>  {
>>      const int max_entries = (MAX_SECTOR_SIZE / sizeof(ScsiBlockPtr));
>>      ScsiBlockPtr *bprs = (void *)sec;
>> @@ -736,9 +737,22 @@ static int zipl_run(ScsiBlockPtr *pte)
>>      /* Load image(s) into RAM */
>>      entry = (ComponentEntry *)(&header[1]);
>>  
>> -    rc = zipl_run_normal(&entry, tmp_sec);
>> -    if (rc) {
>> -        return rc;
>> +    switch (boot_mode) {
>> +    case ZIPL_BOOT_MODE_SECURE_AUDIT:
>> +        rc = zipl_run_secure(&entry, tmp_sec);
>> +        if (rc) {
>> +            return rc;
>> +        }
>> +        break;
>> +    case ZIPL_BOOT_MODE_NORMAL:
>> +        rc = zipl_run_normal(&entry, tmp_sec);
>> +        if (rc) {
>> +            return rc;
>> +        }
>> +        break;
>> +    default:
>> +        puts("Unknown boot mode");
>> +        return -1;
>>      }
> 
> Each case has a common pattern.  Move the if (rc) check outside the
> switch block.
> 
>>  
>>      if (entry->component_type != ZIPL_COMP_ENTRY_EXEC) {
>> @@ -1103,17 +1117,35 @@ static int zipl_load_vscsi(void)
>>   * IPL starts here
>>   */
>>  
>> +ZiplBootMode zipl_mode(uint8_t hdr_flags)
>> +{
>> +    bool sipl_set = hdr_flags & DIAG308_IPIB_FLAGS_SIPL;
>> +    bool iplir_set = hdr_flags & DIAG308_IPIB_FLAGS_IPLIR;
>> +
>> +    if (!sipl_set && iplir_set) {
>> +        return ZIPL_BOOT_MODE_SECURE_AUDIT;
>> +    }
>> +
>> +    return ZIPL_BOOT_MODE_NORMAL;
>> +}
> 
> What about making this a void function `set_boot_mode()` which gets
> invoked in main just after the iplb is stored.  This would also remove
> the need for the "UNSPECIFIED" mode, since this variable would get
> resolved early on.
> 
> Perhaps it makes more sense to default to NORMAL unless the parameters
> specify otherwise?
> 

I agree that NORMAL can be the default, so the UNSPECIFIED mode can be
removed. It may be clearer to keep this as a value-returning helper and
rename it to get_boot_mode() (or similar). The function simply derives
the boot mode from the IPLB flags, and main can assign it directly after
the IPLB is stored:

boot_mode = get_boot_mode(iplb->hdr_flags);

>> +
>>  void zipl_load(void)
>>  {
>>      VDev *vdev = virtio_get_device();
>>  
>>      if (vdev->is_cdrom) {
>> +        if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT) {
>> +            panic("Secure boot from ISO image is not supported!");
>> +        }
>>          ipl_iso_el_torito();
>>          puts("Failed to IPL this ISO image!");
>>          return;
>>      }
>>  
>>      if (virtio_get_device_type() == VIRTIO_ID_NET) {
>> +        if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT) {
>> +            panic("Virtio net boot device does not support secure boot!");
>> +        }
>>          netmain();
>>          puts("Failed to IPL from this network!");
>>          return;
>> @@ -1124,6 +1156,10 @@ void zipl_load(void)
>>          return;
>>      }
>>  
>> +    if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT) {
>> +        panic("ECKD boot device does not support secure boot!");
>> +    }
>> +
> 
> For all cases here in zipl_load, an IPL_assert is much cleaner.  e.g.
> 
> IPL_assert(boot_mode == ZIPL_BOOT_MODE_NORMAL, "message");
> 
> Which will also cover the need to check for the other boot modes in a
> future patch.
> 
> Additionally, I'm not sure if "ECKD boot device" is correct here.
> Couldn't the IPL devices after this point actually be virtio-blk,
> virtio-scsi, etc?  Perhaps a generic "Boot device does not support
> secure IPL" or something is sufficient.
> 

Yes, IPL devices after this point are virtio-blk/virtio-scsi using the
ECKD scheme. Maybe we could rephrase the message to something like:

"Secure boot with the ECKD scheme is not supported!"

>>      switch (virtio_get_device_type()) {
>>      case VIRTIO_ID_BLOCK:
>>          zipl_load_vblk();
>> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
>> index 95943441d3..dc2783faa2 100644
>> --- a/pc-bios/s390-ccw/bootmap.h
>> +++ b/pc-bios/s390-ccw/bootmap.h
>> @@ -88,9 +88,18 @@ typedef struct BootMapTable {
>>      BootMapPointer entry[];
>>  } __attribute__ ((packed)) BootMapTable;
>>  
>> +#define DER_SIGNATURE_FORMAT 1
>> +
>> +typedef struct SignatureInformation {
>> +    uint8_t format;
>> +    uint8_t reserved[3];
>> +    uint32_t sig_len;
>> +} SignatureInformation;
>> +
>>  typedef union ComponentEntryData {
>>      uint64_t load_psw;
>>      uint64_t load_addr;
>> +    SignatureInformation sig_info;
>>  } ComponentEntryData;
>>  
>>  typedef struct ComponentEntry {
>> @@ -113,6 +122,8 @@ typedef struct ScsiMbr {
>>      ScsiBlockPtr pt;   /* block pointer to program table */
>>  } __attribute__ ((packed)) ScsiMbr;
>>  
>> +int zipl_load_segment(ComponentEntry *entry, uint64_t address);
>> +
>>  #define ZIPL_MAGIC              "zIPL"
>>  #define ZIPL_MAGIC_EBCDIC       "\xa9\xc9\xd7\xd3"
>>  #define IPL1_MAGIC "\xc9\xd7\xd3\xf1" /* == "IPL1" in EBCDIC */
>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>> index c9328f1c51..8aabce115f 100644
>> --- a/pc-bios/s390-ccw/main.c
>> +++ b/pc-bios/s390-ccw/main.c
>> @@ -28,6 +28,7 @@ IplParameterBlock *iplb;
>>  bool have_iplb;
>>  static uint16_t cutype;
>>  LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
>> +ZiplBootMode boot_mode;
>>  
>>  #define LOADPARM_PROMPT "PROMPT  "
>>  #define LOADPARM_EMPTY  "        "
>> @@ -272,9 +273,17 @@ static int virtio_setup(void)
>>  
>>  static void ipl_boot_device(void)
>>  {
>> +    if (boot_mode == ZIPL_BOOT_MODE_UNSPECIFIED) {
>> +        boot_mode = zipl_mode(iplb->hdr_flags);
>> +    }
>> +
>>      switch (cutype) {
>>      case CU_TYPE_DASD_3990:
>>      case CU_TYPE_DASD_2107:
>> +        if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT) {
>> +            panic("Passthrough (vfio) CCW device does not support secure boot!");
>> +        }
>> +
> 
> IPL_assert
> 
>>          dasd_ipl(blk_schid, cutype);
>>          break;
>>      case CU_TYPE_VIRTIO:
>> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
>> index b1dc35cded..c2ba40d067 100644
>> --- a/pc-bios/s390-ccw/s390-ccw.h
>> +++ b/pc-bios/s390-ccw/s390-ccw.h
>> @@ -39,6 +39,9 @@ typedef unsigned long long u64;
>>  #define MIN_NON_ZERO(a, b) ((a) == 0 ? (b) : \
>>                              ((b) == 0 ? (a) : (MIN(a, b))))
>>  #endif
>> +#ifndef ROUND_UP
>> +#define ROUND_UP(n, d) (((n) + (d) - 1) & -(0 ? (n) : (d)))
>> +#endif
>>  
>>  #define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
>>  
>> @@ -64,6 +67,8 @@ void sclp_print(const char *string);
>>  void sclp_set_write_mask(uint32_t receive_mask, uint32_t send_mask);
>>  void sclp_setup(void);
>>  void sclp_get_loadparm_ascii(char *loadparm);
>> +bool sclp_is_diag320_on(void);
>> +bool sclp_is_sipl_on(void);
>>  int sclp_read(char *str, size_t count);
>>  
>>  /* virtio.c */
>> @@ -76,6 +81,16 @@ int virtio_read(unsigned long sector, void *load_addr);
>>  /* bootmap.c */
>>  void zipl_load(void);
>>  
>> +typedef enum ZiplBootMode {
>> +    ZIPL_BOOT_MODE_UNSPECIFIED = 0,
>> +    ZIPL_BOOT_MODE_NORMAL = 1,
>> +    ZIPL_BOOT_MODE_SECURE_AUDIT = 2,
>> +} ZiplBootMode;
>> +
>> +extern ZiplBootMode boot_mode;
>> +
>> +ZiplBootMode zipl_mode(uint8_t hdr_flags);
>> +
>>  /* jump2ipl.c */
>>  void write_reset_psw(uint64_t psw);
>>  int jump_to_IPL_code(uint64_t address);
>> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
>> index 4a07de018d..0b03c3164f 100644
>> --- a/pc-bios/s390-ccw/sclp.c
>> +++ b/pc-bios/s390-ccw/sclp.c
>> @@ -113,6 +113,50 @@ void sclp_get_loadparm_ascii(char *loadparm)
>>      }
>>  }
>>  
>> +static void sclp_get_fac134(uint8_t *fac134)
>> +{
>> +
> 
> Remove extra newline.
> 
>> +    ReadInfo *sccb = (void *)_sccb;
>> +
>> +    memset((char *)_sccb, 0, sizeof(ReadInfo));
>> +    sccb->h.length = SCCB_SIZE;
>> +    if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
>> +        *fac134 = sccb->fac134;
>> +    }
>> +}
>> +
>> +bool sclp_is_diag320_on(void)
>> +{
>> +    uint8_t fac134 = 0;
>> +
>> +    sclp_get_fac134(&fac134);
>> +    return fac134 & SCCB_FAC134_DIAG320_BIT;
>> +}
>> +
>> +/*
>> + * Get fac_ipl (byte 136 and byte 137 of the SCLP Read Info block)
>> + * for IPL device facilities.
>> + */
>> +static void sclp_get_fac_ipl(uint16_t *fac_ipl)
>> +{
>> +
>> +    ReadInfo *sccb = (void *)_sccb;
>> +
>> +    memset((char *)_sccb, 0, sizeof(ReadInfo));
>> +    sccb->h.length = SCCB_SIZE;
>> +    if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
>> +        *fac_ipl = sccb->fac_ipl;
>> +    }
>> +}
> 
> Hmm.  The number of SCLP service calls could be reduced by doing a
> singular read scp info call early and storing all the fields needed to
> be accessed later.
> 
> But maybe that is outside the scope of these patches.
> 
>> +
>> +bool sclp_is_sipl_on(void)
>> +{
>> +    uint16_t fac_ipl = 0;
>> +
>> +    sclp_get_fac_ipl(&fac_ipl);
>> +    return fac_ipl & SCCB_FAC_IPL_SIPL_BIT;
>> +}
>> +
>>  int sclp_read(char *str, size_t count)
>>  {
>>      ReadEventData *sccb = (void *)_sccb;
>> diff --git a/pc-bios/s390-ccw/sclp.h b/pc-bios/s390-ccw/sclp.h
>> index 64b53cad29..cf147f4634 100644
>> --- a/pc-bios/s390-ccw/sclp.h
>> +++ b/pc-bios/s390-ccw/sclp.h
>> @@ -50,6 +50,8 @@ typedef struct SCCBHeader {
>>  } __attribute__((packed)) SCCBHeader;
>>  
>>  #define SCCB_DATA_LEN (SCCB_SIZE - sizeof(SCCBHeader))
>> +#define SCCB_FAC134_DIAG320_BIT 0x4
>> +#define SCCB_FAC_IPL_SIPL_BIT 0x4000
>>  
>>  typedef struct ReadInfo {
>>      SCCBHeader h;
>> @@ -57,6 +59,10 @@ typedef struct ReadInfo {
>>      uint8_t rnsize;
>>      uint8_t reserved[13];
>>      uint8_t loadparm[LOADPARM_LEN];
>> +    uint8_t reserved1[102];
>> +    uint8_t fac134;
>> +    uint8_t reserved2;
>> +    uint16_t fac_ipl;
>>  } __attribute__((packed)) ReadInfo;
>>  
>>  typedef struct SCCB {
>> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
>> new file mode 100644
>> index 0000000000..c1c5bc682a
>> --- /dev/null
>> +++ b/pc-bios/s390-ccw/secure-ipl.c
>> @@ -0,0 +1,383 @@
>> +/*
>> + * S/390 Secure IPL
>> + *
>> + * Functions to support IPL in secure boot mode (DIAG 320, DIAG 508,
>> + * signature verification, and certificate handling).
>> + *
>> + * For secure IPL overview: docs/system/s390x/secure-ipl.rst
>> + * For secure IPL technical: docs/specs/s390x-secure-ipl.rst
>> + *
>> + * Copyright 2025 IBM Corp.
>> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <stdio.h>
>> +#include "bootmap.h"
>> +#include "s390-ccw.h"
>> +#include "secure-ipl.h"
>> +
>> +uint8_t vcssb_data[VCSSB_MIN_LEN] __attribute__((__aligned__(PAGE_SIZE)));
>> +
>> +VCStorageSizeBlock *zipl_secure_get_vcssb(void)
>> +{
>> +    VCStorageSizeBlock *vcssb;
>> +    int rc;
>> +
>> +    if (!sclp_is_diag320_on() || !is_cert_store_facility_supported()) {
>> +        puts("Certificate Store Facility is not supported by the hypervisor!");
>> +        return NULL;
>> +    }
>> +
>> +    vcssb = (VCStorageSizeBlock *)vcssb_data;
>> +    /* avoid retrieving vcssb multiple times */
>> +    if (vcssb->length >= VCSSB_MIN_LEN) {
>> +        return vcssb;
>> +    }
> 
> Change the order of operations here to check if vcssb has been retrieved
> before checking diag320 stuff.  Otherwise, every time
> `zipl_secure_get_vcssb()` is invoked, both an sclp service call and a
> diag320 call is always performed, which is unnecessary if the VCSSB has
> already been stored.
> 
>> +
>> +    vcssb->length = VCSSB_MIN_LEN;
>> +    rc = diag320(vcssb, DIAG_320_SUBC_QUERY_VCSI);
>> +    if (rc != DIAG_320_RC_OK) {
>> +        return NULL;
>> +    }
> 
> Can do if (diag320(vcssb, DIAG_320_SUBC_QUERY_VCSI) != DIAG_320_RC_OK)
> 
> and then get rid of rc
> 
>> +
>> +    return vcssb;
>> +}
>> +
>> +static uint32_t get_certs_length(void)
> 
> The function name is ambiguous.  I had to digest the math below to
> understand the intention.  How about something like...
> 
> `get_total_certs_length()`
> 
> ...to help clarify that this function is returning a value to store all
> certs.
> 
>> +{
>> +    VCStorageSizeBlock *vcssb;
>> +    uint32_t len;
>> +
>> +    vcssb = zipl_secure_get_vcssb();
>> +    if (vcssb == NULL) {
>> +        return 0;
>> +    }
>> +
>> +    len = vcssb->total_vcb_len - VCB_HEADER_LEN - vcssb->total_vc_ct * VCE_HEADER_LEN;
>> +
> 
> Could return the line above and get rid of len.
> 
>> +    return len;
>> +}
>> +
>> +static uint32_t request_certificate(uint8_t *cert, uint8_t index)
>> +{
>> +    VCStorageSizeBlock *vcssb;
>> +    VCBlock *vcb;
>> +    VCEntry *vce;
>> +    uint64_t rc = 0;
>> +    uint32_t cert_len = 0;
>> +    uint32_t max_single_vcb_len;
>> +
>> +    /* Get Verification Certificate Storage Size block with DIAG320 subcode 1 */
>> +    vcssb = zipl_secure_get_vcssb();
>> +    if (vcssb == NULL) {
>> +        return 0;
>> +    }
>> +
>> +    /*
>> +     * Request single entry
>> +     * Fill input fields of single-entry VCB
>> +     */
>> +    max_single_vcb_len = ROUND_UP(vcssb->max_single_vcb_len, PAGE_SIZE);
>> +    vcb = malloc(max_single_vcb_len);
>> +    vcb->in_len = max_single_vcb_len;
>> +    vcb->first_vc_index = index + 1;
>> +    vcb->last_vc_index = index + 1;
> 
> There needs to be a better way to account for the index origin
> differences.  See my comments below for `verify_signature()`.
> 
>> +
>> +    rc = diag320(vcb, DIAG_320_SUBC_STORE_VC);
>> +    if (rc != DIAG_320_RC_OK) {
>> +        goto out;
>> +    }
> 
> if (!diag320(vcb, DIAG_320_SUBC_STORE_VC))
> 
> then get rid of rc
> 
>> +
>> +    if (vcb->out_len == VCB_HEADER_LEN) {
>> +        puts("No certificate entry");
>> +        goto out;
>> +    }
>> +    if (vcb->remain_ct != 0) {
>> +        puts("Not enough memory to store all requested certificates");
>> +        goto out;
>> +    }
>> +
>> +    vce = (VCEntry *)vcb->vce_buf;
>> +    if (!(vce->flags & DIAG_320_VCE_FLAGS_VALID)) {
>> +        puts("Invalid certificate");
>> +        goto out;
>> +    }
>> +
>> +    cert_len = vce->cert_len;
>> +    memcpy(cert, (uint8_t *)vce + vce->cert_offset, vce->cert_len);
>> +
>> +out:
>> +    free(vcb);
>> +    return cert_len;
>> +}
>> +
>> +static void cert_list_add(IplSignatureCertificateList *certs, int cert_index,
>> +                          uint8_t *cert, uint64_t cert_len)
> 
> s/certs/cert_list
> s/cert/cert_addr
> 
>> +{
>> +    if (cert_index > MAX_CERTIFICATES - 1) {
>> +        printf("Warning: Ignoring cert entry [%d] because it's over %d entires\n",
>> +                cert_index + 1, MAX_CERTIFICATES);
>> +        return;
>> +    }
>> +
>> +    certs->cert_entries[cert_index].addr = (uint64_t)cert;
>> +    certs->cert_entries[cert_index].len = cert_len;
>> +    certs->ipl_info_header.len += sizeof(certs->cert_entries[cert_index]);
>> +}
>> +
>> +static void comp_list_add(IplDeviceComponentList *comps, int comp_index,
>> +                          int cert_index, uint64_t comp_addr,
>> +                          uint64_t comp_len, uint8_t flags)
> 
> s/comps/comp_list
> 
>> +{
>> +    if (comp_index > MAX_CERTIFICATES - 1) {
>> +        printf("Warning: Ignoring comp entry [%d] because it's over %d entires\n",
>> +                comp_index + 1, MAX_CERTIFICATES);
>> +        return;
>> +    }
>> +
>> +    comps->device_entries[comp_index].addr = comp_addr;
>> +    comps->device_entries[comp_index].len = comp_len;
>> +    comps->device_entries[comp_index].flags = flags;
>> +    comps->device_entries[comp_index].cert_index = cert_index;
>> +    comps->ipl_info_header.len += sizeof(comps->device_entries[comp_index]);
>> +}
>> +
>> +static int update_iirb(IplDeviceComponentList *comps, IplSignatureCertificateList *certs)
>> +{
>> +    IplInfoReportBlock *iirb;
>> +    IplDeviceComponentList *iirb_comps;
>> +    IplSignatureCertificateList *iirb_certs;
>> +    uint32_t iirb_hdr_len;
>> +    uint32_t comps_len;
>> +    uint32_t certs_len;
>> +
>> +    if (iplb->len % 8 != 0) {
>> +        panic("IPL parameter block length field value is not multiple of 8 bytes");
>> +    }
>> +
>> +    iirb_hdr_len = sizeof(IplInfoReportBlockHeader);
>> +    comps_len = comps->ipl_info_header.len;
>> +    certs_len = certs->ipl_info_header.len;
>> +    if ((comps_len + certs_len + iirb_hdr_len) > sizeof(IplInfoReportBlock)) {
>> +        puts("Not enough space to hold all components and certificates in IIRB");
>> +        return -1;
>> +    }
> 
> Shouldn't this also be a panic?  If there's not enough space for the
> IIRB, then that should be more serious than just warning in audit mode.
> 
>> +
>> +    /* IIRB immediately follows IPLB */
>> +    iirb = &ipl_data.iirb;
>> +    iirb->hdr.len = iirb_hdr_len;
>> +
>> +    /* Copy IPL device component list after IIRB Header */
>> +    iirb_comps = (IplDeviceComponentList *) iirb->info_blks;
>> +    memcpy(iirb_comps, comps, comps_len);
>> +
>> +    /* Update IIRB length */
>> +    iirb->hdr.len += comps_len;
>> +
>> +    /* Copy IPL sig cert list after IPL device component list */
>> +    iirb_certs = (IplSignatureCertificateList *) (iirb->info_blks +
>> +                                                  iirb_comps->ipl_info_header.len);
>> +    memcpy(iirb_certs, certs, certs_len);
>> +
>> +    /* Update IIRB length */
>> +    iirb->hdr.len += certs_len;
>> +
>> +    return 0;
>> +}
>> +
>> +static bool secure_ipl_supported(void)
>> +{
>> +    if (!sclp_is_sipl_on()) {
>> +        puts("Secure IPL Facility is not supported by the hypervisor!");
>> +        return false;
>> +    }
>> +
>> +    if (!is_secure_ipl_extension_supported()) {
>> +        puts("Secure IPL extensions are not supported by the hypervisor!");
>> +        return false;
>> +    }
>> +
>> +    if (!sclp_is_diag320_on() || !is_cert_store_facility_supported()) {
>> +        puts("Certificate Store Facility is not supported by the hypervisor!");
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>> +static void init_lists(IplDeviceComponentList *comps, IplSignatureCertificateList *certs)
>> +{
>> +    comps->ipl_info_header.ibt = IPL_IBT_COMPONENTS;
>> +    comps->ipl_info_header.len = sizeof(comps->ipl_info_header);
>> +
>> +    certs->ipl_info_header.ibt = IPL_IBT_CERTIFICATES;
>> +    certs->ipl_info_header.len = sizeof(certs->ipl_info_header);
>> +}
>> +
>> +static uint32_t zipl_load_signature(ComponentEntry *entry, uint64_t sig_sec)
>> +{
> 
> Needs to be type int, otherwise returning -1 below doesn't make sense.
> 
>> +    uint32_t sig_len;
>> +
>> +    if (zipl_load_segment(entry, sig_sec) < 0) {
>> +        return -1;
>> +    }
>> +
>> +    if (entry->compdat.sig_info.format != DER_SIGNATURE_FORMAT) {
>> +        puts("Signature is not in DER format");
>> +        return -1;
>> +    }
>> +    sig_len = entry->compdat.sig_info.sig_len;
>> +
>> +    return sig_len;
> 
> Could return entry->compdat.sig_info.sig_len, then sig_len goes away.
> 
>> +}
>> +
>> +/*
>> + * Returns: 1 - New certificate requested and added to cert_table and cert list
>> + *          0 - Certificate already exists in the cert_table
>> + *         -1 - Error while requesting certificate
>> + */
>> +static int handle_certificate(int *cert_table, uint8_t **cert,
>> +                             uint64_t cert_len, uint8_t cert_table_idx,
>> +                             IplSignatureCertificateList *certs, int cert_entry_idx)
>> +{
>> +    if (cert_table[cert_table_idx] != -1) {
>> +        return 0;
>> +    }
>> +
>> +    if (!request_certificate(*cert, cert_table_idx)) {
>> +        puts("Could not get certificate");
>> +        return -1;
>> +    }
>> +
>> +    cert_list_add(certs, cert_entry_idx, *cert, cert_len);
>> +    cert_table[cert_table_idx] = cert_entry_idx;
>> +    return 1;
>> +}
>> +
>> +int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>> +{
>> +    IplDeviceComponentList comps;
>> +    IplSignatureCertificateList certs;
> 
> It would read a little easier if these were comp_list and cert_list
> 
>> +    ComponentEntry *entry = *entry_ptr;
>> +    uint8_t *cert = NULL;
>> +    uint64_t *sig = NULL;
>> +    int cert_entry_idx = 0;
>> +    int comp_entry_idx = 0;
>> +    uint64_t comp_addr;
>> +    int comp_len;
>> +    uint32_t sig_len = 0;
>> +    uint64_t cert_len = -1;
>> +    uint8_t cert_table_idx = -1;
>> +    bool verified;
>> +    uint32_t certs_len;
>> +    /*
>> +     * Store indices of cert entry that have already used for signature
>> +     * verification to prevent allocating the same certificate multiple times.
>> +     * cert_table index (cert_table_idx):
>> +     *          index of certificate from qemu cert store used for verification
>> +     * cert_table value (cert_entry_idx):
>> +     *          index of cert entry in cert list that contains the certificate
>> +     */
>> +    int cert_table[MAX_CERTIFICATES] = { [0 ... MAX_CERTIFICATES - 1] = -1};
> 
> If you agree with the suggestion below for verify_signature to adjust
> the returned index, then the cert_table can be used a bit differently:
> 
> Make this an array of booleans.  Use the index returned by
> verify_signature.  Value true means that the cert has already been added
> to the IplSignatureCertificateList.  False means it has yet to be added
> to the list.
> 

If verify_signature adjusted the returned index, I don’t quite see why
cert_table should become a boolean array. We still need to track the
certificate index in IplSignatureCertificateList, since that index is
used later as the IPL-Signature-Certificate Index (SCI) in
IplDeviceComponentList. That’s what cert_table currently provides.

With a boolean array, that index information would be lost. Am I missing
something?

> Remove the mention of "qemu cert store", as the BIOS technically does
> not know anything about the underlying cert store or its implementation.
> 
>> +    int rc;
>> +    int signed_count = 0;
>> +
>> +    if (!secure_ipl_supported()) {
>> +        return -1;
>> +    }
>> +
>> +    init_lists(&comps, &certs);
>> +    certs_len = get_certs_length();
>> +    cert = malloc(certs_len);
> 
> cert = malloc(get_total_certs_length());
> 
> Then get rid of the certs_len variable.
> 
>> +    sig = malloc(MAX_SECTOR_SIZE);
>> +
>> +    while (entry->component_type != ZIPL_COMP_ENTRY_EXEC) {
>> +        switch (entry->component_type) {
>> +        case ZIPL_COMP_ENTRY_SIGNATURE:
>> +            if (sig_len) {
>> +                goto out;
>> +            }
>> +
>> +            sig_len = zipl_load_signature(entry, (uint64_t)sig);
>> +            if (sig_len < 0) {
>> +                goto out;
>> +            }
>> +            break;
>> +        case ZIPL_COMP_ENTRY_LOAD:
>> +            comp_addr = entry->compdat.load_addr;
>> +            comp_len = zipl_load_segment(entry, comp_addr);
>> +            if (comp_len < 0) {
>> +                goto out;
>> +            }
>> +
>> +            if (!sig_len) {
>> +                break;
>> +            }
>> +
>> +            verified = verify_signature(comp_len, comp_addr, sig_len, (uint64_t)sig,
>> +                                        &cert_len, &cert_table_idx);
>> +
>> +            if (verified) {
>> +                rc  = handle_certificate(cert_table, &cert, cert_len,
>> +                                         cert_table_idx, &certs, cert_entry_idx);
> 
> Check cert_table here before calling handle_certificate.  It would
> contain all the cert_table logic to zipl_run_secure and make it a little
> bit easier to understand.  Also less variables to pass around.
> 
>> +                if (rc == -1) {
>> +                    goto out;
>> +                }
>> +
>> +                /* increment for the next certificate */
>> +                if (rc == 1) {
>> +                    cert_entry_idx++;
>> +                    cert += cert_len;
>> +                }
>> +
>> +                puts("Verified component");
>> +                comp_list_add(&comps, comp_entry_idx, cert_table[cert_table_idx],
>> +                              comp_addr, comp_len,
>> +                              S390_IPL_COMPONENT_FLAG_SC | S390_IPL_COMPONENT_FLAG_CSV);
>> +            } else {
>> +                comp_list_add(&comps, comp_entry_idx, -1,
>> +                              comp_addr, comp_len,
>> +                              S390_IPL_COMPONENT_FLAG_SC);
>> +                zipl_secure_handle("Could not verify component");
>> +            }
> 
> This can be cleaned up a bit.  Set cert_index and flags within the
> if/else block.  Call `comp_list_add()` once after the block.
> 
>> +
>> +            comp_entry_idx++;
>> +            signed_count += 1;
>> +            /* After a signature is used another new one can be accepted */
>> +            sig_len = 0;
>> +            break;
>> +        default:
>> +            puts("Unknown component entry type");
>> +            return -1;
>> +        }
>> +
>> +        entry++;
>> +
>> +        if ((uint8_t *)(&entry[1]) > tmp_sec + MAX_SECTOR_SIZE) {
>> +            puts("Wrong entry value");
>> +            return -EINVAL;
>> +        }
>> +    }
>> +
>> +    if (signed_count == 0) {
>> +        zipl_secure_handle("Secure boot is on, but components are not signed");
>> +    }
>> +
>> +    if (update_iirb(&comps, &certs)) {
>> +        zipl_secure_handle("Failed to write IPL Information Report Block");
>> +    }
>> +
>> +    *entry_ptr = entry;
>> +    free(sig);
>> +
>> +    return 0;
>> +out:
>> +    free(cert);
>> +    free(sig);
>> +
>> +    return -1;
>> +}
>> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
>> new file mode 100644
>> index 0000000000..a6fc1ac8de
>> --- /dev/null
>> +++ b/pc-bios/s390-ccw/secure-ipl.h
>> @@ -0,0 +1,94 @@
>> +/*
>> + * S/390 Secure IPL
>> + *
>> + * Copyright 2025 IBM Corp.
>> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef _PC_BIOS_S390_CCW_SECURE_IPL_H
>> +#define _PC_BIOS_S390_CCW_SECURE_IPL_H
>> +
>> +#include <diag320.h>
>> +#include <diag508.h>
>> +
>> +VCStorageSizeBlock *zipl_secure_get_vcssb(void);
>> +int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec);
>> +
>> +static inline void zipl_secure_handle(const char *message)
> 
> This could be implemented like an assert, where the first param is the
> condition.
> 
> e.g.
> 
> `zipl_secure_handle(signed_count > 0, "Secure boot is on, but components
>                                        are not signed");`
> 
> Then some if checks / extra indentation goes away.
> 
>> +{
>> +    switch (boot_mode) {
>> +    case ZIPL_BOOT_MODE_SECURE_AUDIT:
>> +        IPL_check(false, message);
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +}
>> +
>> +static inline uint64_t diag320(void *data, unsigned long subcode)
>> +{
>> +    register unsigned long addr asm("0") = (unsigned long)data;
>> +    register unsigned long rc asm("1") = 0;
>> +
>> +    asm volatile ("diag %0,%2,0x320\n"
>> +                  : "+d" (addr), "+d" (rc)
>> +                  : "d" (subcode)
>> +                  : "memory", "cc");
>> +    return rc;
>> +}
>> +
>> +static inline bool is_cert_store_facility_supported(void)
>> +{
>> +    uint32_t d320_ism;
>> +
>> +    diag320(&d320_ism, DIAG_320_SUBC_QUERY_ISM);
>> +    return (d320_ism & DIAG_320_ISM_QUERY_SUBCODES) &&
>> +           (d320_ism & DIAG_320_ISM_QUERY_VCSI) &&
>> +           (d320_ism & DIAG_320_ISM_STORE_VC);
>> +}
> 
> Don't need to check if DIAG_320_ISM_QUERY_SUBCODES is supported (implied
> if query ISM returns OK).
> 
> Can clean this up by doing `return d320_ism & (DIAG_320_ISM_QUERY_VCSI |
> DIAG_320_ISM_STORE_VC);`
> 
> Merge this function with `sclp_is_diag320_on()`, checking the read scp
> facility bit first before calling diag320.
> 
>> +
>> +static inline uint64_t _diag508(void *data, unsigned long subcode)
>> +{
>> +    register unsigned long addr asm("0") = (unsigned long)data;
>> +    register unsigned long rc asm("1") = 0;
>> +
>> +    asm volatile ("diag %0,%2,0x508\n"
>> +                  : "+d" (addr), "+d" (rc)
>> +                  : "d" (subcode)
>> +                  : "memory", "cc");
>> +    return rc;
>> +}
>> +
>> +static inline bool is_secure_ipl_extension_supported(void)
> 
> "is_signature_verif_supported()" or something like that reads better.
> 
>> +{
>> +    uint64_t d508_subcodes;
>> +
>> +    d508_subcodes = _diag508(NULL, DIAG_508_SUBC_QUERY_SUBC);
>> +    return d508_subcodes & DIAG_508_SUBC_SIG_VERIF;
>> +}
>> +
>> +static inline bool verify_signature(uint64_t comp_len, uint64_t comp_addr,
>> +                                    uint64_t sig_len, uint64_t sig_addr,
>> +                                    uint64_t *cert_len, uint8_t *cert_idx)
>> +{
>> +    Diag508SigVerifBlock svb;
>> +
>> +    svb.length = sizeof(Diag508SigVerifBlock);
>> +    svb.version = 0;
>> +    svb.comp_len = comp_len;
>> +    svb.comp_addr = comp_addr;
>> +    svb.sig_len = sig_len;
>> +    svb.sig_addr = sig_addr;
>> +
>> +    if (_diag508(&svb, DIAG_508_SUBC_SIG_VERIF) == DIAG_508_RC_OK) {
>> +        *cert_len = svb.cert_len;
>> +        *cert_idx = svb.cert_store_index;
> 
> Adjust for different indexing origins here, accounting for what DIAG320
> will later need when retrieving certs:
> 
> ```
> /*
>  * DIAG 508 utilizes an index origin of 0 when indexing the cert store.
>  * The cert_idx will be used for DIAG 320 data structures, which expects
>  * an index origin of 1. Account for the offset here so it's easier to
>  * manage later.
>  */
> *cert_idx = svb.cert_store_index + 1;
> ```
> 
>> +        return true;
>> +    }
>> +
>> +    return false;
>> +}
>> +
>> +#endif /* _PC_BIOS_S390_CCW_SECURE_IPL_H */
> 


