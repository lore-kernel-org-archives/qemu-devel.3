Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D21C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 21:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udyQr-0006am-5M; Mon, 21 Jul 2025 17:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1udyPJ-0005LU-Fo; Mon, 21 Jul 2025 17:50:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1udyPG-0001a3-Hf; Mon, 21 Jul 2025 17:50:49 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LK455o000727;
 Mon, 21 Jul 2025 21:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=sErqUd
 MqIFp19cQw/lA/sHMvI5aHkj1IqAb+PqgXlRY=; b=mwDTqJw8Z50gqrprIQKY8M
 UEK+Jxz5EtZL7C1hfXLfU5OdvOjJ3ekhaJTnzJLgBkn4Xredu+lzMsJFSeRjPWqb
 h4n0w/7mVYI9bwDjrCSXWr2dsEHzf1amH9FYuiNf2flbsq/F78x7NBwAA+Cm33yw
 bE/ekdxpRy/b1/qFgCaUOX42Oa8CBlzZiyqf94VIuGniWdvvxPG0QO6l5jFSNSbK
 VMb0gwsaVYyvDstnaacAQj+Q5LQlaXu3LJk/f2O5m6clszq5F1lJ0nUqvhpVIfUA
 tmI8KyUHbP3qlJjrj+5iT9IrV6OJK5vGMW3MdV20NVCQa+PF+nNJDojcZ1I4FVfA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805hfu10v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Jul 2025 21:50:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56LJJp7e024960;
 Mon, 21 Jul 2025 21:50:18 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 480nptg92h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Jul 2025 21:50:18 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56LLoHpA32637618
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Jul 2025 21:50:17 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6055B5805D;
 Mon, 21 Jul 2025 21:50:17 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B974858054;
 Mon, 21 Jul 2025 21:50:15 +0000 (GMT)
Received: from [9.61.127.219] (unknown [9.61.127.219])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 21 Jul 2025 21:50:15 +0000 (GMT)
Message-ID: <86deb470-54a6-460f-bf25-239d2256ea28@linux.ibm.com>
Date: Mon, 21 Jul 2025 17:50:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/28] pc-bios/s390-ccw: Add signature verification for
 secure IPL in audit mode
To: Collin Walling <walling@linux.ibm.com>, thuth@redhat.com,
 berrange@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-21-zycai@linux.ibm.com>
 <eccbac31-7c1d-4b75-a284-a46ad98675db@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <eccbac31-7c1d-4b75-a284-a46ad98675db@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE5MyBTYWx0ZWRfXx2cQUv6MtaJ1
 Wrkwpe3d/jAm4psCULqhqXFVet4EBiN14XtE660T3hELXv0YHFvROJGDrFiwYYXwgNgjgcVNWhx
 Nam4FiErfsRm9qMbo0+GhiRV0pjZG1BcNk/exvvUC0wr4EYZFw9P2XSA48wzJ6CQ6MNEaFOgVNO
 QBfDY3Fjr0iCzjKMID91ZDuj7T1xvMgE/HZFB1r3K7oWPd1ic82iv6K4r671HUHClxmq7omSl+Z
 T+VX8U6KXQTt6JM331E8t216od86zCqqPjEauwQPsXp4Yl021xHu+gQzz86rLkvaS7exnOMIrg0
 YAJFh7CtxFfdJzZJi3x6YPpDMAd6EJtvMv2p7/QzIos6p0O+4TbisW8DVefefFubM1XmRawEkRF
 LIO+Hx061QZqQtM1i1lH+qx48+e/vvjla9xdM1TCcfS6AwQdWveTnetO3kMUCiOBJmGAZrUU
X-Proofpoint-GUID: Uhxus0u2PEKIn_rhXQ7x6A3bxuUWXuZ5
X-Proofpoint-ORIG-GUID: Uhxus0u2PEKIn_rhXQ7x6A3bxuUWXuZ5
X-Authority-Analysis: v=2.4 cv=X9RSKHTe c=1 sm=1 tr=0 ts=687eb61b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=VfPlyfad5FGNghWyEtcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210193
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 7/11/25 6:50 PM, Collin Walling wrote:
> On 7/11/25 5:10 PM, Zhuoying Cai wrote:
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

[snip...]

>> +static int zipl_run_secure(ComponentEntry *entry, uint8_t *tmp_sec)
>> +{
>> +    IplDeviceComponentList comps;
>> +    IplSignatureCertificateList certs;
>> +    uint64_t *cert = NULL;
>> +    int cert_index = 0;
>> +    int comp_index = 0;
>> +    uint64_t comp_addr;
>> +    int comp_len;
>> +    bool have_sig;
>> +    uint32_t sig_len;
>> +    uint64_t cert_len = -1;
>> +    uint8_t cert_idx = -1;
>> +    bool verified;
>> +    uint32_t certs_len;
>> +    /*
>> +     * Store indices of cert entry that have already used for signature verification
>> +     * to prevent allocating the same certificate multiple times.
>> +     * cert_table index: index of certificate from qemu cert store used for verification
>> +     * cert_table value: index of cert entry in cert list that contains the certificate
>> +     */
>> +    int cert_table[MAX_CERTIFICATES] = { [0 ... MAX_CERTIFICATES - 1] = -1};
>> +    int signed_count = 0;
>> +
>> +    if (!zipl_secure_ipl_supported()) {
>> +        return -1;
>> +    }
>> +
>> +    zipl_secure_init_lists(&comps, &certs);
>> +    certs_len = zipl_secure_get_certs_length();
>> +    cert = malloc(certs_len);
>> +
>> +    have_sig = false;
> 
> You can get rid of this boolean and simply use sig_len as the indicator
> that there were nonzero bytes read when a signature entry was detected
> in the previous loop.  Where you set have_sig to false below, you can
> set sig_len to 0 to reset it.
> 
>> +    while (entry->component_type == ZIPL_COMP_ENTRY_LOAD ||
>> +           entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
>> +
> 
> I'll be honest, I'm not a big fan of neither the design of this while
> loop nor the one in zipl_run_normal.  I'd prefer something like:
> 
> while (entry->component_type != ZIPL_COMP_ENTRY_EXEC) {
> 
>     // sanity checking
> 
>     switch (entry->component_type) {
>     case ZIPL_COMP_ENTRY_SIGNATURE:
>         ...
>         break;
>     case ZIPL_COMP_ENTRY_LOAD:
>         ...
>         break;
>     default:
>         // Unrecognized entry type, return error
>     }
> 
>     entry++;
> }
> 
> The above makes it clear that we're loading in segments until the exec
> entry is found, and the handling for each recognized component type is
> clearly labeled and organized.
> 
> I won't speak for making this change to the zipl_run_normal function
> yet, as it may introduce too many changes in this patch series.
> 
>> +        if (entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
>> +            /* There should never be two signatures in a row */
>> +            if (have_sig) {
>> +                return -1;
>> +            }
>> +
>> +            sig_len = zipl_handle_sig_entry(entry);
>> +            if (sig_len < 0) {
>> +                return -1;
>> +            }
>> +
>> +            have_sig = true;
>> +        } else {
>> +            comp_addr = entry->compdat.load_addr;
>> +            comp_len = zipl_load_segment(entry, comp_addr);
>> +            if (comp_len < 0) {
>> +                return -1;
>> +            }
>> +
>> +            if (have_sig) {
> 
> If you use my idea to re-write this loop, you'll be able to reduce one
> level of indentation of the code that follows by checking the inverse
> condition:
> 
> if (!have_sig) { // or if (!sig_len)
>     break;
> 
>> +                verified = verify_signature(comp_len, comp_addr,
>> +                                            sig_len, (uint64_t)sig_sec,
>> +                                            &cert_len, &cert_idx);
>> +
>> +                if (verified) {
>> +                    cert_index = handle_certificate(cert_table, &cert,
>> +                                                    cert_len, cert_idx,
>> +                                                    &certs, cert_index);
>> +                    if (cert_index == -1) {
>> +                        return -1;
>> +                    }
>> +
>> +                    puts("Verified component");
>> +                    zipl_secure_comp_list_add(&comps, comp_index, cert_table[cert_idx],
>> +                                              comp_addr, comp_len,
>> +                                              S390_IPL_COMPONENT_FLAG_SC |
>> +                                              S390_IPL_COMPONENT_FLAG_CSV);
>> +                } else {
>> +                    zipl_secure_comp_list_add(&comps, comp_index, -1,
>> +                                              comp_addr, comp_len,
>> +                                              S390_IPL_COMPONENT_FLAG_SC);
>> +                    zipl_secure_print("Could not verify component");
>> +                }
>> +
>> +                comp_index++;
>> +                signed_count += 1;
>> +                /* After a signature is used another new one can be accepted */
>> +                have_sig = false;
>> +            }
>> +        }
>> +
>> +        entry++;
>> +
>> +        if ((uint8_t *)(&entry[1]) > tmp_sec + MAX_SECTOR_SIZE) {
>> +            puts("Wrong entry value");
>> +            return -EINVAL;
>> +        }
> 
> Can someone who is more informed than I am of the IPL process please
> explain to me what is the purpose of the above check?  Why does it check
> if the next entry, the one which isn't going to be inspected/loaded, is
> within the bounds of tmp_sec?  This has been here since this file's
> inception and I can't find any documentation or mention that supports it.
> 
> This code precludes any of the secure IPL changes.
> 
> Was this actually meant to be entry[0] to ensure the actual entry we
> want to work on is not outside the bounds of tmp_sec?  Or perhaps it was
> meant to be done before the increment to entry?
> 
>> +    }
>> +
>> +    if (entry->component_type != ZIPL_COMP_ENTRY_EXEC) {
>> +        puts("No EXEC entry");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (signed_count == 0) {
>> +        zipl_secure_print("Secure boot is on, but components are not signed");
>> +    }
> 
> Shouldn't this be handled within the loop?  If it gets to a LOAD type
> without a signature, audit mode should report and move on.  Secure mode
> should report and abort on the spot.  Then you can get rid of signed_count.
> 
> I'll get back to reviewing patch 22 wrt to this variable's usage later on...
> 

This is handled after the loop because the number of LOAD components can
vary, and not all of them require signatures. We count the signed
components once all have been processed to verify whether components,
such as the stage3 bootloader and kernel, are signed for secure IPL.

The signed_count is also used in a later patch for the SCLAB check,
which allows only one signed component when the Single Component flag is
set.

>> +
>> +    if (zipl_secure_update_iirb(&comps, &certs)) {
>> +        zipl_secure_print("Failed to write IPL Information Report Block");
>> +    }
>> +    write_reset_psw(entry->compdat.load_psw);
>> +
>> +    return 0;
>> +}
>> +
>>  static int zipl_run_normal(ComponentEntry *entry, uint8_t *tmp_sec)
>>  {
>>      while (entry->component_type == ZIPL_COMP_ENTRY_LOAD ||
>> @@ -735,8 +893,17 @@ static int zipl_run(ScsiBlockPtr *pte)
>>      /* Load image(s) into RAM */
>>      entry = (ComponentEntry *)(&header[1]);
>>  
>> -    if (zipl_run_normal(entry, tmp_sec)) {
>> -        return -1;
>> +    switch (boot_mode) {
>> +    case ZIPL_SECURE_AUDIT_MODE:
>> +        if (zipl_run_secure(entry, tmp_sec)) {
>> +            return -1;
>> +        }
>> +        break;
>> +    case ZIPL_NORMAL_MODE:
>> +        if (zipl_run_normal(entry, tmp_sec)) {
>> +            return -1;
>> +        }
>> +        break;
>>      }
>>  
>>      /* should not return */
>> @@ -1095,17 +1262,35 @@ static int zipl_load_vscsi(void)
>>   * IPL starts here
>>   */
>>  
>> +ZiplBootMode zipl_mode(uint8_t hdr_flags)
>> +{
>> +    bool sipl_set = hdr_flags & DIAG308_IPIB_FLAGS_SIPL;
>> +    bool iplir_set = hdr_flags & DIAG308_IPIB_FLAGS_IPLIR;
>> +
>> +    if (!sipl_set && iplir_set) {
>> +        return ZIPL_SECURE_AUDIT_MODE;
>> +    }
>> +
>> +    return ZIPL_NORMAL_MODE;
>> +}
>> +
>>  void zipl_load(void)
>>  {
>>      VDev *vdev = virtio_get_device();
>>  
>>      if (vdev->is_cdrom) {
>> +        if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
>> +            panic("Secure boot from ISO image is not supported!");
>> +        }
>>          ipl_iso_el_torito();
>>          puts("Failed to IPL this ISO image!");
>>          return;
>>      }
>>  
>>      if (virtio_get_device_type() == VIRTIO_ID_NET) {
>> +        if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
>> +            panic("Virtio net boot device does not support secure boot!");
>> +        }
>>          netmain();
>>          puts("Failed to IPL from this network!");
>>          return;
>> @@ -1116,6 +1301,10 @@ void zipl_load(void)
>>          return;
>>      }
>>  
>> +    if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
>> +        panic("ECKD boot device does not support secure boot!");
>> +    }
>> +
>>      switch (virtio_get_device_type()) {
>>      case VIRTIO_ID_BLOCK:
>>          zipl_load_vblk();
>> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
>> index 95943441d3..e48823a835 100644
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
>> +} __attribute__((packed)) SignatureInformation;
>> +
>>  typedef union ComponentEntryData {
>>      uint64_t load_psw;
>>      uint64_t load_addr;
>> +    SignatureInformation sig_info;
>>  } ComponentEntryData;
>>  
>>  typedef struct ComponentEntry {
>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>> index c9328f1c51..38962da1dd 100644
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
>> +    if (boot_mode == 0) {
>> +        boot_mode = zipl_mode(iplb->hdr_flags);
>> +    }
>> +
>>      switch (cutype) {
>>      case CU_TYPE_DASD_3990:
>>      case CU_TYPE_DASD_2107:
>> +        if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
>> +            panic("Passthrough (vfio) device does not support secure boot!");
>> +        }
>> +
>>          dasd_ipl(blk_schid, cutype);
>>          break;
>>      case CU_TYPE_VIRTIO:
>> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
>> index 6cdce3e5e5..648f407dc5 100644
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
>> @@ -76,6 +81,15 @@ int virtio_read(unsigned long sector, void *load_addr);
>>  /* bootmap.c */
>>  void zipl_load(void);
>>  
>> +typedef enum ZiplBootMode {
>> +    ZIPL_NORMAL_MODE = 1,
>> +    ZIPL_SECURE_AUDIT_MODE = 2,
>> +} ZiplBootMode;
> 
> These should be ZIPL_BOOT_MODE_*
> 
> Also, is there a reason why the list starts at 1 and not defaulting to
> the implicit 0?
> 

boot_mode is a global variable defined in pc-bios/s390-ccw/main.c, and
it defaults to 0, which indicates that the boot mode hasn’t been
determined yet.

We start the list at 1 to reserve 0 as the implicit “undefined” or “not
yet set” value. The actual boot mode is only set later when boot_mode == 0:
    if (boot_mode == 0) {
        boot_mode = zipl_mode(iplb->hdr_flags);
    }
This allows us to distinguish between an unset state and valid boot modes.

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

[snip...]





