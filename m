Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474BDC9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9jQj-0002sL-Re; Thu, 24 Sep 2026 09:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9jQh-0002rD-Dt
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 09:24:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9jQe-0004O5-Jd
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 09:24:03 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC66A32221035; Thu, 24 Sep 2026 13:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DtnfmB
 QKPsYfTylGtCC7KRhOEC75fJbWfwlkLiKHXMY=; b=REOMIx+YcND+WEn3qbguLi
 Ix7MkRXPinoXR1HcodoHmHcz8YtGKamFQpdqxs67au5FOpzn0GvdfE2QR7a1wHJF
 txzByAyab2eeJl4YGvhpf1s8yN2l0E6PpaFMR7YpRmQMYxBnkDUUAS1y3n/8TSWh
 wqJ7EZLY2xsZOxSp0EG/ltbSy1dmT1VYjKRSaFRr15tAjxffzGVauUI26Zv5BNZG
 7qvP0wqFTxtEVIwvk/PiGB3TvDwL+duNg9T4vLOltRLb6zVNO/T96jrRbLkjr3Qh
 H4bQvsTWoafudAr12GQNaeA2uGocRsK+B1KuOHSDgCPQXX6RIEn46qbgP8ujlKvQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvgkkq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 13:23:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OCHblY2060536; Thu, 24 Sep 2026 13:23:58 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qp1ex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 13:23:58 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68ODNvgL32244280
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 13:23:57 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C12B958060;
 Thu, 24 Sep 2026 13:23:57 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D5EF58056;
 Thu, 24 Sep 2026 13:23:57 +0000 (GMT)
Received: from [9.47.158.153] (unknown [9.47.158.153])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 13:23:57 +0000 (GMT)
Message-ID: <96c5ceac-4e74-4db3-81b0-d15b77d7e378@linux.ibm.com>
Date: Thu, 24 Sep 2026 09:23:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] tpm_util: Pass TPMVersion to function writing fatal
 error response
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, armenon@redhat.com, marcandre.lureau@gmail.com
References: <20260924012527.858527-1-stefanb@linux.ibm.com>
 <20260924012527.858527-2-stefanb@linux.ibm.com>
 <179023566484.1794827.7857065416987116127.b4-review@b4>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <179023566484.1794827.7857065416987116127.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: x0kP-B8WYCKWx42UOIsBeQlW8PwcmeaA
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1NCBTYWx0ZWRfX8QA+uZjNOVZz
 eKK4zmIOwtu+pfrpHmrTCiRjZpNoBmK20oCki5b28w2IZjU4wESmU5WqmkEr/ku4CCRoMnyt19I
 WVMdty9NvQC47C7+TWbWYUSbdwIADco=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab5246f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=IK8IUtuwpHpVJ6zup8IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Vbc5m6zvXCmKv2DeGyPJugSSQjqNVblh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1NCBTYWx0ZWRfX4DG56vK5VxgV
 NLXfUGyRtGeSECcQmc+kE2z/KwsXE9lJE7yiPf7UzDOt1QdXm6OYU2RVhTRrsdP/rquMo0AxUCI
 eqnAVhyuHg5sJ1Os0VD1oeKBnUqfo518LRkt9Lfd+MZN4+L3aHpIWJwY2oAOrXF68zA8bV5qWBY
 9w/LpDBQpLJ0iYBuuxWaMAS4tq8zSx0nQqrWc55xPicPneiqA7yZ8fvMkwmbnSrc9sLpJZvwUOK
 fK+/AamtIIJLIWlG9qxVxEXqVU9apbdpIWP9wBLBt2fK4bNplNLPzn/G3aHZJ1aAvdvyr9aN6so
 VvpiKphzyMvvj5jIDrfvv3aAf6zt3wdDTXYQhZNd+FDRBigEBO6TEIvuE+0gggsCxPrh7h8RN8H
 XYuKQ2M3uuLxOrWXPcXGSEgW2dTsaLZQ/kJet/8HLm8NysuM24JS3m0HJFFz/uTfoiJKXKnd3YZ
 2uXW/XjNmsGkVvpDZeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240054
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 9/24/26 3:41 AM, marcandre.lureau@redhat.com wrote:
>> Have tpm_util_write_fatal_error_response write a TPM version specific
>> error response with error code TPM_FAIL for a TPM 1.2 and TPM_RC_FAILURE
>> for a TPM 2. Adjust the callers.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Message-ID: <20260924012527.858527-2-stefanb@linux.ibm.com>
>>
>> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
>> index 95d2de2f48b8..16ae44c8d722 100644
>> --- a/backends/tpm/tpm_emulator.c
>> +++ b/backends/tpm/tpm_emulator.c
>> @@ -270,7 +270,8 @@ static void tpm_emulator_handle_request(TPMBackend *tb, TPMBackendCmd *cmd,
>>           tpm_emulator_unix_tx_bufs(tpm_emu, cmd->in, cmd->in_len,
>>                                     cmd->out, cmd->out_len,
>>                                     &cmd->selftest_done, errp) < 0) {
>> -        tpm_util_write_fatal_error_response(cmd->out, cmd->out_len);
>> +        tpm_util_write_fatal_error_response(cmd->out, cmd->out_len,
>> +                                            TPM_EMULATOR(tb)->tpm_version);
>>       }
>>   }
>>   
>> diff --git a/backends/tpm/tpm_passthrough.c b/backends/tpm/tpm_passthrough.c
>> index a9f35ab7d606..8a4f8183c7c9 100644
>> --- a/backends/tpm/tpm_passthrough.c
>> +++ b/backends/tpm/tpm_passthrough.c
>> @@ -118,7 +118,7 @@ static void tpm_passthrough_unix_tx_bufs(TPMPassthruState *tpm_pt,
>>   
>>   err_exit:
>>       if (ret < 0) {
>> -        tpm_util_write_fatal_error_response(out, out_len);
>> +        tpm_util_write_fatal_error_response(out, out_len, tpm_pt->tpm_version);
>>       }
>>   
>>       tpm_pt->tpm_executing = false;
>> diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
>> index 264bff22a91a..cdb7a4886104 100644
>> --- a/backends/tpm/tpm_util.c
>> +++ b/backends/tpm/tpm_util.c
>> @@ -87,12 +87,18 @@ const PropertyInfo qdev_prop_tpm = {
>>   /*
>>    * Write an error message in the given output buffer.
>>    */
>> -void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len)
>> +void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len,
>> +                                         TPMVersion tpm_version)
>>   {
>>       if (out_len >= sizeof(struct tpm_resp_hdr)) {
>> -        tpm_cmd_set_tag(out, TPM_TAG_RSP_COMMAND);
>> +        if (tpm_version == TPM_VERSION_1_2) {
>> +            tpm_cmd_set_tag(out, TPM_TAG_RSP_COMMAND);
>> +            tpm_cmd_set_error(out, TPM_FAIL);
>> +        } else {
> 
> I would rather use a switch/case than fallback

Will change for v2.


