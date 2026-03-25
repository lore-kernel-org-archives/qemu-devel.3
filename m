Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DECB109C058
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 19:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Tdn-0001Oe-5e; Wed, 25 Mar 2026 15:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1w5Tdj-0001OJ-PM; Wed, 25 Mar 2026 15:11:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1w5Tdg-0008Ut-JO; Wed, 25 Mar 2026 15:11:39 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PGeqrp3444471; Wed, 25 Mar 2026 19:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0y6Wzs
 FHNtwNwt+DxIl5CqQ+iLuT9kBvB5T1zay3gYY=; b=V2UDEJqLN6yVTXNu/0uxEW
 5hnAyaQ96n87SQXYv2pcG1C2H2lQELhYwNSFjHqUjZnenivIGa1cTLhkHb3MMqhR
 3SbyTyaedcZWjIiEemGLdZrv4CQql6rp7pSBjbAmJSllWXOuHTtlnXdR89uMwqmr
 00ph1efZcKDI19hbZEEfIV+ww5/Rsyofqn9E7kt1Wr+fjJw3bGirrICGDGkmEkE+
 jWtCTz3NLDeBuWaB0xXHMS9A/qj/rXFreBRIF4nW+LEgiQWfhWNsZ407ic8Cuwk8
 xuef0PGb6hNZTISH3RsXLCNoAFa8V1sf/iu88enHjue3331RyF8pzodOqzzoZR+w
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktv1789-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2026 19:11:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PJ9pOb005964;
 Wed, 25 Mar 2026 19:11:30 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yr17n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2026 19:11:30 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62PJBSDK24314400
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2026 19:11:28 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F04E58059;
 Wed, 25 Mar 2026 19:11:28 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A00A558043;
 Wed, 25 Mar 2026 19:11:26 +0000 (GMT)
Received: from [9.61.30.97] (unknown [9.61.30.97])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 25 Mar 2026 19:11:26 +0000 (GMT)
Message-ID: <ef08f0ad-b516-4713-b7b0-c3a37772090d@linux.ibm.com>
Date: Wed, 25 Mar 2026 15:11:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 19/30] pc-bios/s390-ccw: Add signature verification for
 secure IPL in audit mode
To: Collin Walling <walling@linux.ibm.com>, thuth@redhat.com,
 berrange@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 jdaley@linux.ibm.com
References: <20260305224146.664053-1-zycai@linux.ibm.com>
 <20260305224146.664053-20-zycai@linux.ibm.com>
 <c062e73a-660d-4c92-9c84-937cb10d944d@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <c062e73a-660d-4c92-9c84-937cb10d944d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: c-cScL10PPOojZZ70UzjQ0ma8NiOC0Fm
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c43362 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=1k8kn31hTM8Rqylfde4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEzNyBTYWx0ZWRfXyHB20j6QidMI
 4S7PJ7tMEQ/VH5yRz8NS21q+s773ociUAUAY7sAG599p6cOGxSva7fTIEsoOyohsF3yZo+KMRaJ
 q+3cnsyuQE113teKV7mIG2qQupZ2WU5zlVcWH/2Xzh4s2kKy9dKB9UVMvjZkW20T9g9FaGYyQHz
 nshnITmSIoOw/tN/yFskKKXm45y+bmxAE9pQ1og+79mtX8kwvTKEK1VuHVh1GS9OMR1W8qvBjr+
 hYXF79Q8MT7AAcchfbtRHGvOPBlE2ZZ0vMldR6ojT9CRil4pJcgE4qWSiN38sZslGBYDedHTdy6
 gsFm4ruM9nfgiVDAdHy8iAWvP4+FEMDGQGBahPriAQlYiRHckJN5+nSIro/5wsE7E8Wi3WGM0Bb
 e4DtgruL3Ks3bTjV2N+hVgfPSgkzOa1ZEdO4q1LlbdX592EHa8WCSGxiociXmJcZ5bbOFM/celT
 7zeIeW3VsWHJFAquxYw==
X-Proofpoint-GUID: c-cScL10PPOojZZ70UzjQ0ma8NiOC0Fm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250137
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

On 3/16/26 11:41 PM, Collin Walling wrote:
> On 3/5/26 17:41, Zhuoying Cai wrote:
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
>>  pc-bios/s390-ccw/Makefile        |   3 +-
>>  pc-bios/s390-ccw/bootmap.c       |  36 +++-
>>  pc-bios/s390-ccw/bootmap.h       |  11 +
>>  pc-bios/s390-ccw/main.c          |   6 +
>>  pc-bios/s390-ccw/s390-ccw.h      |  27 +++
>>  pc-bios/s390-ccw/sclp.c          |  38 ++++
>>  pc-bios/s390-ccw/sclp.h          |   6 +
>>  pc-bios/s390-ccw/secure-ipl.c    | 357 +++++++++++++++++++++++++++++++
>>  pc-bios/s390-ccw/secure-ipl.h    | 102 +++++++++
>>  10 files changed, 618 insertions(+), 3 deletions(-)
>>  create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>>  create mode 100644 pc-bios/s390-ccw/secure-ipl.h
>>

[...]

>> +
>> +int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>> +{
>> +    IplDeviceComponentList comp_list = { 0 };
>> +    IplSignatureCertificateList cert_list = { 0 };
>> +    ComponentEntry *entry = *entry_ptr;
>> +    uint8_t *cert_addr = NULL;
>> +    uint64_t *sig = NULL;
>> +    int cert_entry_idx = 0;
>> +    int comp_entry_idx = 0;
>> +    uint64_t comp_addr;
>> +    int comp_len;
>> +    uint32_t sig_len = 0;
>> +    uint64_t cert_len = -1;
>> +    uint8_t cert_table_idx = -1;
>> +    int cert_index;
>> +    uint8_t flags;
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
> I'm concerned about the cert_addr being malloc'd here...
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
>> +            /* default cert index and flags for unverified component */
>> +            cert_index = -1;
>> +            flags = S390_IPL_DEV_COMP_FLAG_SC;
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
> 
> ...then the malloc'd cert is added to the cert list (and this list later
> gets appended to the IIRB).
> 
> Once IPL starts, the data at this address will eventually be
> lost/overwritten. The certificate address needs to point to either:
>  - somewhere on the disk
>  - some dedicated memory space (likely designated by QEMU)
> 
> Though that begs the question: who/what makes use of the IIRB?  It seems
> this information gets lost?
> 

Thanks for raising the concern. I looked into this further.

The IIRB is actively consumed by the kernel, and its contents are
preserved until they are explicitly copied.

It is used for:
* Boot logging: log_component_list() reports what was loaded and verified.
* kexec operations: kexec_file_add_ipl_report() builds the next kernel’s
IPL report from the existing one.
* Keying: load_ipl_certs() installs IPL certificates into the platform
trusted keyring.

In addition, the IPL report block data is not lost during boot (see
arch/s390/boot/ipl_report.c).

Early during boot, read_ipl_report() reserves the entire IPL report
memory region, including the IPL parameter block and the IPL report
itself. Certificate entries reference the actual certificate data via
physical addresses, and all subsequent physical memory allocations are
checked for overlap using ipl_report_certs_intersects(). This ensures
that no allocation can overwrite certificate data before it is saved.

Later, save_ipl_cert_comp_list() allocates permanent storage and copies
the actual certificate data. As a result, the IIRB data is both used and
protected throughout early boot and is not lost.

I also verified, from both the BIOS and the guest kernel, that the
certificate addresses, lengths, and contents are correctly preserved.
For example:

BIOS debug log:
cert_entries = {{addr = 0x3fd6e98c, len = 0x3e7},
                {addr = 0x3fd6ed73, len = 0x3e7}, ...}

Guest kernel debug log:
[    0.060583] boot: copy_certificates_bootdata()
[    0.060584] boot: Certificate data at 0x3fd6e98c (len=0x3e7):
...
[    0.060588] boot: Certificate data at 0x3fd6ed73 (len=0x3e7):
...

>> +
>> +                    /* increment for the next certificate */
>> +                    cert_entry_idx++;
>> +                    cert_addr += cert_len;
>> +                }
>> +
>> +                puts("Verified component");
>> +                cert_index = cert_list_table[cert_table_idx];
>> +                flags |= S390_IPL_DEV_COMP_FLAG_CSV;
>> +            }
>> +
>> +            comp_list_add(&comp_list, comp_entry_idx, cert_index,
>> +                          comp_addr, comp_len, flags);
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
>> +    free(sig);
>> +
>> +    return 0;
>> +out:
>> +    free(cert_addr);
>> +    free(sig);
>> +
>> +    return -1;
>> +}

[...]


