Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460A6F5A8AA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 18:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEtHF-0007rZ-FV; Mon, 20 Apr 2026 14:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wEtGv-0007p0-3d; Mon, 20 Apr 2026 14:23:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wEtGl-00008q-NL; Mon, 20 Apr 2026 14:22:57 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KEvZEb3299164; Mon, 20 Apr 2026 18:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4bdF9s
 nEH3PRJfbUERUZPeD9x771ZOWgWV9W4suezIY=; b=CVBGMkuPpVowI+b8G5D2Mf
 aea87uDO4a6/lX8y0ScAbzv5aiWFIMSN3weFyleyKYOmyOtjfUG11o8N6xFHxR4S
 w9Cp61L6LznfiQINx3O3mlPGsYBNx9sjEO+pPU36I+XwLArrheCYWh9J3TVpDBoy
 AfwFoiW0wXUddyvkWUXSdiJDyEvjrqldGXp+mfWUDyAtJ58eWE1vEhsnMAe0NJGu
 +zUP6aIxG2OF0Byr2U1mVBTocDstirIaSzHn4B0Xf3Dgzr/v4j69ZbrGxQRiaqe2
 gJtgm+PrHF2TogQg2iKmohqjxUbpiuVjkDaZGu2+czAgobAbquE9OUwZ2IslAlAA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2j6h2tq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2026 18:22:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63KIKMfi010231;
 Mon, 20 Apr 2026 18:22:41 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmnsgwru0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2026 18:22:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63KIME4i28115598
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Apr 2026 18:22:14 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E47458051;
 Mon, 20 Apr 2026 18:22:40 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECC065805A;
 Mon, 20 Apr 2026 18:22:38 +0000 (GMT)
Received: from [9.61.35.249] (unknown [9.61.35.249])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 Apr 2026 18:22:38 +0000 (GMT)
Message-ID: <0099193c-a518-4dfd-89e3-5e4e35c74786@linux.ibm.com>
Date: Mon, 20 Apr 2026 14:22:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 19/30] pc-bios/s390-ccw: Add signature verification
 for secure IPL in audit mode
To: Collin Walling <walling@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 jdaley@linux.ibm.com
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
 <20260402221453.1602899-20-zycai@linux.ibm.com>
 <dcc60465-07bc-4a37-8b2a-6dcfc5015142@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <dcc60465-07bc-4a37-8b2a-6dcfc5015142@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE3NyBTYWx0ZWRfX0p3d518y5Jtl
 PEnaQpRk3qDo+NZut48bkEwD6fyDGrvkwvQ0yvoozLBlkX4dXMJ1wP2Hpcgu3hYQ4KNuaMUx43c
 2p6CEmIlnjGjxTKto9gya+EUEr+ZF/4+haxA4EedzvDsKAUE8LHF5SvyFRiq3M+v3aNYqqLO722
 D111/fqcDt1cknsue4EoHP1+ASq+3QmMB2MijbsVeEhGsRPyBmo34uAsdQ0UARUxnLFXD0KxdID
 1GkKiVakpn0AXF9PyBh8dxkkTCC5+Nmy3FESYKwGe09QzEsn2IkClKSavFtZtHJw4FMbiQvPxde
 ywKIuVsO98xIwxKT+C0cBawY5KTIXJjVxsSoFQSZMwVptbyI1ppPYdgp0i6uUtvmZtXoHEtIIy9
 ebhZdeMQzzFt3hzy1xDhj16BMDfn3mbpYIdtO2StgBsvwQwXB/T0LrkgLc/QjcMCh3bbJB0NQ8Z
 MEI3328XxPRMPH5DKlw==
X-Proofpoint-GUID: q7TWaZuKDEQTDPn7HRizm6ZQx2pbcpF0
X-Authority-Analysis: v=2.4 cv=SOJykuvH c=1 sm=1 tr=0 ts=69e66ef2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=YsY79D3GabN47MKunnQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: q7TWaZuKDEQTDPn7HRizm6ZQx2pbcpF0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200177
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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

Thanks for the review!

On 4/10/26 3:37 PM, Collin Walling wrote:
> On 4/2/26 18:14, Zhuoying Cai wrote:
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
>>  docs/system/s390x/secure-ipl.rst |  35 +++
>>  pc-bios/s390-ccw/Makefile        |   2 +-
>>  pc-bios/s390-ccw/bootmap.c       |  36 +++-
>>  pc-bios/s390-ccw/bootmap.h       |  11 +
>>  pc-bios/s390-ccw/main.c          |   6 +
>>  pc-bios/s390-ccw/s390-ccw.h      |  27 +++
>>  pc-bios/s390-ccw/sclp.c          |  37 ++++
>>  pc-bios/s390-ccw/sclp.h          |   6 +
>>  pc-bios/s390-ccw/secure-ipl.c    | 359 +++++++++++++++++++++++++++++++
>>  pc-bios/s390-ccw/secure-ipl.h    | 110 ++++++++++
>>  10 files changed, 626 insertions(+), 3 deletions(-)
>>  create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>>  create mode 100644 pc-bios/s390-ccw/secure-ipl.h
>>
>> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
>> index 0a02f171b4..3a19b72085 100644
>> --- a/docs/system/s390x/secure-ipl.rst
>> +++ b/docs/system/s390x/secure-ipl.rst
>> @@ -18,3 +18,38 @@ Note: certificate files must have a .pem extension.
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
> 
> Since this patch needs some rework anyway, it might help to reduce LOC
> for this patch and make things more readable by inserting a new patch
> before this one that introduces Normal Mode and does the IPL_checks. In
> that way, this patch would contain the context only for secure IPL
> related operations.
> 
> The commit message should give a brief introduction to what the boot
> modes are intended for.
> 
>> +Audit Mode
>> +----------
>> +
>> +When the certificate store is populated with at least one certificate
>> +and no additional secure IPL parameters are provided on the command
>> +line, then secure IPL will proceed in "audit mode". All secure IPL
>> +operations will be performed with signature verification errors reported
>> +as non-disruptive warnings.
>> +
>> +Configuration:
>> +
>> +.. code-block:: shell
>> +
>> +    qemu-system-s390x -machine s390-ccw-virtio,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
>> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
>> index 3e5dfb64d5..2109d16781 100644
>> --- a/pc-bios/s390-ccw/Makefile
>> +++ b/pc-bios/s390-ccw/Makefile
>> @@ -35,7 +35,7 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
>>  
>>  OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
>>  	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
>> -	  virtio-ccw.o clp.o pci.o virtio-pci.o
>> +	  virtio-ccw.o clp.o pci.o virtio-pci.o secure-ipl.o
>>  
>>  SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
>>

[...]

>> +
>> +static int zipl_load_signature(ComponentEntry *entry, uint64_t sig_sec)
> 
> The _sec suffix doesn't make sense here.  It's mainly used for global
> variables.
> 
>> +{
>> +    if (zipl_load_segment(entry, sig_sec) < 0) {
>> +        return -1;
>> +    }
>> +
>> +    if (entry->compdat.sig_info.format != DER_SIGNATURE_FORMAT) {
>> +        puts("Signature is not in DER format");
>> +        return -1;
>> +    }
> 
> Swap the order of the if statements since the format is known before
> loading the segment from the disk.  That way we don't bother doing any
> uneccessary I/O if the signature is invalid.
> 
>> +
>> +    return entry->compdat.sig_info.sig_len;
> 
> Question: are sig_len and the successful rc of zipl_load_segment
> equivalent?  If so, and with the suggestion above, you could just
> `return zipl_load_segment(...)`.  In that way, on error the proper -rc
> is returned.
> 

No, they are not the same. zipl_load_segment() returns the length of the
loaded segment, and sig_len is the exact signature size.

Debug output:
sig_len returns: 525 bytes (actual signature size)
zipl_load_segment() returns: 1024 bytes (actual data loaded from disk,
two 512-byte sectors)

>> +}
>> +
>> +int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>> +{
>> +    IplDeviceComponentList comp_list = { 0 };
>> +    IplSignatureCertificateList cert_list = { 0 };
>> +    SecureIplCompEntryInfo comp_entry_info;
>> +    ComponentEntry *entry = *entry_ptr;
>> +    uint8_t *cert_addr = NULL;
>> +    uint64_t *sig = NULL;
>> +    int cert_entry_idx = 0;
>> +    int comp_entry_idx = 0;
>> +    int sig_len = 0;
>> +    int comp_len;
>> +    uint64_t comp_addr;
>> +    uint64_t cert_len;
>> +    uint8_t cert_table_idx;
>> +    bool verified;
>> +    /*
>> +     * Keep track of which certificate store indices correspond to the
>> +     * certificate data entries within the IplSignatureCertificateList to
>> +     * prevent allocating space for the same certificate multiple times.
>> +     *
>> +     * The array index corresponds to the certificate's cert-store index.
>> +     *
>> +     * The array value corresponds to the certificate's entry within the
>> +     * IplSignatureCertificateList (with a value of -1 denoting no entry
>> +     * exists for the certificate).
>> +     */
>> +    int cert_list_table[MAX_CERTIFICATES] = { [0 ... MAX_CERTIFICATES - 1] = -1 };
>> +    int signed_count = 0;
>> +
>> +    if (!secure_ipl_supported()) {
>> +        panic("Unable to boot in secure/audit mode");
>> +    }
>> +
>> +    init_lists(&comp_list, &cert_list);
>> +    cert_addr = malloc(get_total_certs_length());
> 
> This makes more sense as `cert_buf` since it's storing the actual
> certificate data and not holding an address.
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
> 
> What about using another SecureIplCompEntryInfo for the signature info?
> You could use it as a pointer and change some checks to `if (sig)`.
> During the ENTRY_LOAD case, do `free(sig)` at the end or something like
> that.
> 
> Whether making it a pointer makes sense or not, I think using the struct
> would still simplify things.
> 
>> +        case ZIPL_COMP_ENTRY_LOAD:
>> +            comp_addr = entry->compdat.load_addr;
>> +            comp_len = zipl_load_segment(entry, comp_addr);
> 
> Why not set the `comp_entry_info` fields here directly?  Then
> `comp_addr` and `comp_len` go away.
>

comp_addr can be set directly here; however, comp_len must be handled
separately because zipl_load_segment() may return a negative value.
Assigning it directly to a uint32_t field could result in incorrect
behavior due to implicit type conversion.

I also think deferring these assignments improves readability and
ensures the structure is only initialized when it is actually needed for
verification.

>> +            if (comp_len < 0) {
>> +                goto out;
>> +            }
>> +
>> +            if (!sig_len) {
>> +                break;
>> +            }
>> +
>> +            comp_entry_info = (SecureIplCompEntryInfo){ 0 };
>> +            comp_entry_info.addr = comp_addr;
>> +            comp_entry_info.len = (uint64_t)comp_len;
>> +
>> +            verified = verify_signature(comp_entry_info,
>> +                                        sig_len, (uint64_t)sig,
>> +                                        &cert_len, &cert_table_idx);
> 
> If the signature uses a SecureIplCompEntryInfo, you can further reduce
> the param list to this function.
> 
>> +
>> +            /* default flags for unverified component */
>> +            comp_entry_info.flags |= S390_IPL_DEV_COMP_FLAG_SC;
> 
> Move setting this flag to near where the comp addr and len are set.
> Just do a regular = assign instead of |= since it's the first flag to be
> set for the variable.
> 
>> +
>> +            if (verified) {
>> +                if (cert_list_table[cert_table_idx] == -1) {
>> +                    if (!request_certificate(cert_addr, cert_table_idx)) {
>> +                        puts("Could not get certificate");
>> +                        goto out;
>> +                    }
>> +
>> +                    cert_list_table[cert_table_idx] = cert_entry_idx;
>> +                    cert_list_add(&cert_list, cert_entry_idx, cert_addr, cert_len);
>> +
>> +                    /* increment for the next certificate */
>> +                    cert_entry_idx++;
>> +                    cert_addr += cert_len;
>> +                }
>> +
>> +                puts("Verified component");
>> +                comp_entry_info.cert_index = cert_list_table[cert_table_idx];
>> +                comp_entry_info.flags |= S390_IPL_DEV_COMP_FLAG_CSV;
>> +            }
> 
> Add an `else` here and move the `zipl_secure_handle()` from below.
> 
>> +
>> +            comp_list_add(&comp_list, comp_entry_idx, comp_entry_info);
>> +
>> +            if (!verified) {
>> +                zipl_secure_handle("Could not verify component");
>> +            }
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
>> +    update_iirb(&comp_list, &cert_list);
>> +
>> +    *entry_ptr = entry;
>> +    free(sig);> +
>> +    return 0;
>> +out:
> 
> "goto out" should be used to jump to a label for a regular return case.
> However, this is the error case.  Change the label to `error`.
> 
>> +    free(cert_addr);
>> +    free(sig);
>> +
>> +    return -1;
>> +}

[...]




