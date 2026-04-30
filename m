Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6AFCD13D2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 21:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIYl5-0000ib-15; Thu, 30 Apr 2026 17:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wIYl1-0000iN-VL; Thu, 30 Apr 2026 17:17:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wIYkz-0005V6-In; Thu, 30 Apr 2026 17:17:15 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UDSvs72981403; Thu, 30 Apr 2026 21:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NlrosY
 mV77SdDx7MHMmPDyA/5hV/xvKwg+uAvK810G4=; b=kfpgYTRWCWJ547mxZCGyR2
 2RMKimg94Q5/bW1zJqnO3yv3liD6Er0ERgVvG82yzM9+rV6ofSFEQR+f17i2f9jq
 WaFWz4xjWPhWkXSCeo78Q6r9OM04QOqjuzVVn2c0pU33EZgdwFkOKSLRhelaxela
 YfAHXe+6KF3Yq2aZ4goCMBxogyYwA11qnvD/j0DtOnw76G02dceX7sQH+6wycYkn
 T8E+G0Une5krL+iXRpxpV3Tq0G9pqh1LaSQtOx8ptwTGXAqwtGr44pH0tmVag1ye
 uUX+k/JgxzhgXXBmclGk/y2raX6AeaH35e2Mo2pMa7Kk7LbmSGjrPJ+0Ur3QzPkQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb5hyyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 21:17:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UL8mDx001514;
 Thu, 30 Apr 2026 21:17:03 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamymn21-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 21:17:03 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63ULGYxT29295212
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Apr 2026 21:16:35 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C216D58059;
 Thu, 30 Apr 2026 21:17:01 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A546358043;
 Thu, 30 Apr 2026 21:17:00 +0000 (GMT)
Received: from [9.61.106.54] (unknown [9.61.106.54])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Apr 2026 21:17:00 +0000 (GMT)
Message-ID: <6cc10035-7ecf-464c-bafa-b3d1b954b7c9@linux.ibm.com>
Date: Thu, 30 Apr 2026 17:17:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 25/30] pc-bios/s390-ccw: Handle true secure IPL mode
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
 <20260402221453.1602899-26-zycai@linux.ibm.com>
 <69556fbe-9cb6-4f55-adac-5eedeafc2e55@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <69556fbe-9cb6-4f55-adac-5eedeafc2e55@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f3c6d0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=txb9UqXIoVj3cLDVLnEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIxNSBTYWx0ZWRfX/DRTJ+HdudSJ
 Sghb62Juq3yF1M6Ktq+q+i6djQnzJ6WW+fm4gK5Bp6zze2Qv/GZxIPtsDx+o/OIBFyWyzpi09cb
 XMJvncqgIDbGCuuMq8J9+KkUXlRfM86EtS9QQjEr4fTo0ZlcX7M/PBuYIAtFuFg2t7Xqu/XOZ3e
 Sgj8s5H+qp8PaWU/WrdEbqI3s0G3WBUYOJQ7e7VWJ8A2s9mgGwoZ+nLtoigSWb1bfbTiNEXak9N
 neuqPIYB8M7hwUnIqK3VW14NWRvlOtxGG7XbhGSqsX5vHk7Ed4VQ0CLGeKZ/Ug27eGasvcvYogS
 25ZssMkSGcIzgOW9Z8hUOBzM69km8igPoP8mngVouc/l6w5jgLeRm0dZ11yNbxXNp/XwFv+q+kx
 y6FayrRZftcNaW8b3M4HkrGfihaxwr9x9szZ00yNFFs839pw3/2aJ+pJSdlMWtNOWeapQdW7jOL
 WEOPMOXv7JbyJcYf0vw==
X-Proofpoint-GUID: d6YRADKcrWewM8nQhGJJbov01V-XKj4l
X-Proofpoint-ORIG-GUID: d6YRADKcrWewM8nQhGJJbov01V-XKj4l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300215
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

On 4/10/26 4:11 PM, Collin Walling wrote:
> On 4/2/26 18:14, Zhuoying Cai wrote:
>> When secure boot is enabled (-secure-boot on) and certificate(s) are
>> provided, the boot operates in True Secure IPL mode.
>>
>> Any verification error during True Secure IPL mode will cause the
>> entire boot process to terminate.
>>
>> Secure IPL in audit mode requires at least one certificate provided in
>> the key store along with necessary facilities. If secure boot is enabled
>> but no certificate is provided, the boot process will also terminate, as
>> this is not a valid secure boot configuration.
>>
>> Note: True Secure IPL mode is implemented for the SCSI scheme of
>> virtio-blk/virtio-scsi devices.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> Reviewed-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>  docs/system/s390x/secure-ipl.rst | 13 +++++++++++++
>>  pc-bios/s390-ccw/bootmap.c       |  8 ++++++++
>>  pc-bios/s390-ccw/s390-ccw.h      |  1 +
>>  pc-bios/s390-ccw/secure-ipl.c    |  4 ++++
>>  pc-bios/s390-ccw/secure-ipl.h    |  3 +++
>>  5 files changed, 29 insertions(+)
>>

[...]
>> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
>> index d4e455ed0c..0befa6a8b3 100644
>> --- a/pc-bios/s390-ccw/secure-ipl.c
>> +++ b/pc-bios/s390-ccw/secure-ipl.c
>> @@ -280,6 +280,10 @@ static bool check_sclab_presence(uint8_t *sclab_magic, uint32_t *cei_flags)
>>      *cei_flags |= S390_CEI_INVALID_SCLAB;
>>  
>>      /* a missing SCLAB will not be reported in audit mode */
>> +    if (boot_mode == ZIPL_BOOT_MODE_SECURE) {
>> +        zipl_secure_handle("Magic does not match. SCLAB does not exist");
>> +    }
>> +
> 
> Hmm I know I already gave my r-b, but I don't recall the boot_mode check
> here.  Is there anything inherently wrong with reporting a missing
> SCLAB, even if it's not present for audit mode?  The whole point of
> audit is to just do everything secure IPL does, but report warnings
> instead of terminating.
> 

Thanks for pointing this out. The boot_mode check was already present in
the previous versions. During the early design phase of this line item,
it was suggested that missing SCLAB would not be reported in audit mode.

>>      return false;
>>  }
>>  
>> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
>> index 75d1c8e046..039fcec516 100644
>> --- a/pc-bios/s390-ccw/secure-ipl.h
>> +++ b/pc-bios/s390-ccw/secure-ipl.h
>> @@ -82,6 +82,9 @@ static inline void zipl_secure_handle(const char *message)
>>      case ZIPL_BOOT_MODE_SECURE_AUDIT:
>>          IPL_check(false, message);
>>          break;
>> +    case ZIPL_BOOT_MODE_SECURE:
>> +        panic(message);
>> +        break;
>>      default:
>>          break;
>>      }
> 
> 


