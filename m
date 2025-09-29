Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94A7CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 20:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3KjH-0003hq-DU; Mon, 29 Sep 2025 16:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1v3KjD-0003hS-Hc; Mon, 29 Sep 2025 16:44:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1v3Kj7-0003xl-R3; Mon, 29 Sep 2025 16:44:10 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TJu6uX027016;
 Mon, 29 Sep 2025 20:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=51e1q5
 AG0Wxxf2y0e58sR2LvBYxZrY+4ub/Cbvmi4PE=; b=hdrS/dDVlmcZaCOKrRyb3y
 zxcnidbJePyXEzE/BbIF3x/2ssKBOeCP1VsjAAuEe4dcVlN6iFyYNdivzyzqEDOy
 1DbA9ZeG1Cqv1ghj2DRG/kVvW7Ww9aml3C5XQSpHahNazTW9V/jQ0BcVWOfRUr/+
 J2Fh0X4qJvocqT9s2onaFdFmWHoC1wkM2cIDbT2XuyozbnCPW4wBqytE25y/Yo4j
 ymybDDwuxAU2txgSzQfr5F6rsSmAB/Ie+obKBjYaxU7k23X4EAJ6CCHHhaTG3bD6
 I5KPDaJn6lrQoEnxeSVzm4dWi4nrpwa1VQrCS3uYPoRzqrueF8QtwqFQZ7FwCreQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7n7mndu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Sep 2025 20:43:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58TGoONs026752;
 Mon, 29 Sep 2025 20:43:56 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eu8mqy92-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Sep 2025 20:43:56 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58TKhtNo29688452
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Sep 2025 20:43:55 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28F7A58058;
 Mon, 29 Sep 2025 20:43:55 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E9A658057;
 Mon, 29 Sep 2025 20:43:54 +0000 (GMT)
Received: from [9.61.82.97] (unknown [9.61.82.97])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 29 Sep 2025 20:43:54 +0000 (GMT)
Message-ID: <ddad9154-ae72-43b3-8d20-3ef4c0a43c46@linux.ibm.com>
Date: Mon, 29 Sep 2025 16:43:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 21/28] pc-bios/s390-ccw: Add additional security checks
 for secure boot
To: Thomas Huth <thuth@redhat.com>, berrange@redhat.com, david@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 borntraeger@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-22-zycai@linux.ibm.com>
 <e5faaffd-fb58-4002-817f-ff9e787e8272@redhat.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <e5faaffd-fb58-4002-817f-ff9e787e8272@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Eye6rfwaJppZreTcKFTCbhr8oRoGWcbf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX+aTf1fblBa95
 obLGZOJOrDm0k39Iyvzm2AYkjEmscn5YyH3Yn2FUc/qkGKTAR48UkHBoXFuSfYJWCHDXwhaNl9L
 ENi/ZSS6zSANL+mx1tpgp43PL07P+r+vX0G4J3hp2u6LYlN3IfqXbxUiDgw+gaj5d0czvOFNn1X
 /ZU5xbpa3UVXTe7rQAiAPhRMAFB4RbI5KopK4mPCmSOxfsYMAV3cyPCj9/VtY13rn67iXhpklOl
 7MwiTd6ZWf7+54WGSfYc6FGXQa6F04ErG7WwBErdRc1Igq/Kff86w+wrKzUFvf2EEyluL/BmGf6
 fv1vKce/5MG8YoigRtyAp/q8Gm88WivTthgql+Vcjtsq9//juj3AvKn6UR31p5ajWwH4gxn484T
 ZR7h6NrNnp+QU60l27/mzaWHMzKhHw==
X-Proofpoint-GUID: Eye6rfwaJppZreTcKFTCbhr8oRoGWcbf
X-Authority-Analysis: v=2.4 cv=T7qBjvKQ c=1 sm=1 tr=0 ts=68daef8d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=hBroyG_C7Neg0O3mkUsA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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

Thank you for all the feedback! I'll address the comments in the next
version.

On 9/29/25 9:30 AM, Thomas Huth wrote:
> On 18/09/2025 01.21, Zhuoying Cai wrote:
>> Add additional checks to ensure that components do not overlap with
>> signed components when loaded into memory.
>>
>> Add additional checks to ensure the load addresses of unsigned components
>> are greater than or equal to 0x2000.
>>
>> When the secure IPL code loading attributes facility (SCLAF) is installed,
>> all signed components must contain a secure code loading attributes block
>> (SCLAB).
>>
>> The SCLAB provides further validation of information on where to load the
>> signed binary code from the load device, and where to start the execution
>> of the loaded OS code.
>>
>> When SCLAF is installed, its content must be evaluated during secure IPL.
>> However, a missing SCLAB will not be reported in audit mode. The SCALB
>> checking will be skipped in this case.
>>
>> Add IPL Information Error Indicators (IIEI) and Component Error
>> Indicators (CEI) for IPL Information Report Block (IIRB).
>>
>> When SCLAF is installed, additional secure boot checks are performed
>> during zipl and store results of verification into IIRB.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
> ...
>> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
>> index 8eab19cb09..cd798c1198 100644
>> --- a/pc-bios/s390-ccw/secure-ipl.c
>> +++ b/pc-bios/s390-ccw/secure-ipl.c

[ ... ]

>> +
>> +static bool is_psw_valid(uint64_t psw, SecureIplCompAddrRange *comp_addr_range,
>> +                         int range_index)
>> +{
>> +    uint32_t addr = psw & 0x3FFFFFFF;
> 
> Shouldn't that be 0x7fffffff instead?
> 

Thanks for pointing it out. It should be 0x7fffffff.

>> +    /* PSW points within a signed binary code component */
>> +    for (int i = 0; i < range_index; i++) {
>> +        if (comp_addr_range[i].is_signed &&
>> +            addr >= comp_addr_range[i].start_addr &&
>> +            addr <= comp_addr_range[i].end_addr) {
> 
> is it still OK if the address points to the end_addr? Or should that be 
> end_addr - 2 instead (since an opcode has at least two bytes)?
> 

Using end_addr - 2 seems correct, since it accounts for the minimum
instruction length.

Just to clarify: using end_addr - 2 should ensure that at least a 2-byte
instruction fits. Should longer instructions (e.g., 4 and 6 bytes) be a
concern in this context?

>> +            return true;
>> +       }
>> +    }
>> +
>> +    return false;
>> +}
> ...
>>   
>> +static inline bool is_sclab_flag_set(uint16_t sclab_flags, uint16_t flag)
>> +{
>> +    return (sclab_flags & flag) != 0;
>> +}
>> +
>> +static inline bool validate_unsigned_addr(uint64_t comp_load_addr)
>> +{
>> +    /* usigned load address must be greater than or equal to 0x2000 */
>> +    return comp_load_addr >= 0x2000;
>> +}
>> +
>> +static inline bool validate_sclab_magic(uint8_t *sclab_magic)
>> +{
>> +    /* identifies the presence of SCLAB */
>> +    return magic_match(sclab_magic, ZIPL_MAGIC);
>> +}
>> +
>> +static inline bool validate_sclab_length(uint16_t sclab_len)
>> +{
>> +    /* minimum SCLAB length is 32 bytes */
>> +    return sclab_len >= 32;
>> +}
>> +
>> +static inline bool validate_sclab_format(uint8_t sclab_format)
>> +{
>> +    /* SCLAB format must set to zero, indicating a format-0 SCLAB being used */
>> +    return sclab_format == 0;
>> +}
>> +
>> +static inline bool validate_sclab_ola_zero(uint64_t sclab_load_addr)
>> +{
>> +    /* Load address field in SCLAB must contain zeros */
>> +    return sclab_load_addr == 0;
>> +}
>> +
>> +static inline bool validate_sclab_ola_one(uint64_t sclab_load_addr,
>> +                                          uint64_t comp_load_addr)
>> +{
>> +   /* Load address field must match storage address of the component */
>> +   return sclab_load_addr == comp_load_addr;
>> +}
>> +
>> +static inline bool validate_sclab_opsw_zero(uint64_t sclab_load_psw)
>> +{
>> +    /* Load PSW field in SCLAB must contain zeros */
>> +    return sclab_load_psw == 0;
>> +}
>>
>> +static inline bool validate_sclab_opsw_one(uint16_t sclab_flags)
>> +{
>> +   /* OLA must set to one */
>> +   return is_sclab_flag_set(sclab_flags, S390_SECURE_IPL_SCLAB_FLAG_OLA);
>> +}
>> +
>> +static inline bool validate_lpsw(uint64_t sclab_load_psw, uint64_t comp_load_psw)
>> +{
>> +    /* compare load PSW with the PSW specified in component */
>> +    return sclab_load_psw == comp_load_psw;
>> +}
> 
> Most of these inline functions just compare something with 0 or other values 
> here, and you only use them in one spot of the code ... So you need 5 lines 
> of code for something that could be done in two lines of code at the calling 
> sites instead, i.e. this looks like unnecessary code to me. Please inline 
> the comparisons (together with the comment that you've got here) in the 
> calling sites to get rid of this code bloat.
> 
>   Thanks,
>    Thomas
> 


