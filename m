Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49719C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 20:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whC7U-0006AV-Dk; Tue, 07 Jul 2026 16:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whC7S-0006AE-II
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 16:10:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whC7Q-0005A3-4g
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 16:10:14 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667J5G4s542074
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 20:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fFm+Ki9ljbW4FOcqVhQ7rsZOL+kTsGwe5C7BP7x33AA=; b=AdHxmmy5mxulF8FQ
 8uHK2LVCIl8RxjOIQNfrQ/mixn5vsZTK+pGydI7ETRjt+Di61WPBx276gd7XgGOB
 mtOL5EYuSa8HV16vE4DsUqrI6IlrygI4RIlkeXHoItSk0L2IkFdRQEPnCelZbnQt
 dp4No8kQEcXDvRw11oMP6gEmZfFwdkAXBtk2vuARbXJNOH78W4OwfipVwxUfyrDK
 IAJJNRDX2k/kOi97MMQHFL8AOVnrJ6N1J+4oVtZuMXKZQZyZj/pIOpQU+k2OghNb
 uBsKbxmjyjvWFiExc0gmvQ9ItZ7IfYauOPcxOOayDOZjOhZ6b1kUNSfAuvkX5Qc5
 NBE/5g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8w11u7cq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 20:10:08 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1e6f602cso80354991cf.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783455008; x=1784059808; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fFm+Ki9ljbW4FOcqVhQ7rsZOL+kTsGwe5C7BP7x33AA=;
 b=f6qH3p5v1QdMyZq6uimMH6iwTK7y41GC8cCqVe+zDvSwBq0nBWNYd8DLMGFenl417D
 yrmdKsW2lzOzpAswAFw3PjskkQIUtSKZcFpd9chP3hbYKbMDectjUTY4uI4x6Xf3Th73
 NNl8usDr3N5PcoQAcQ31cg3yhju0WcGiyy6+7U+O8ScIPZBx6MAPbY7KEmXlMCEbdPaC
 3+HwyKL8s1rwPnc9QE/4vMlFPJ06tczXjAPCpVhByE4iCnottCino3HwL0fYI36G83GN
 EWxTtIo7rsCOzkp4Aw4vIEn47R4xcyWGddmU6xf/T3lVHSS/LzqzMr4yxh7IvLpzV5fb
 KbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783455008; x=1784059808;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fFm+Ki9ljbW4FOcqVhQ7rsZOL+kTsGwe5C7BP7x33AA=;
 b=PesJYSr5+vY7naQbKIId3buX1W4z00OuwKXniwTX6u6lU2TzOpnCQNeljo4m1v2YNx
 w+InfzZ2dN6C74u6GMJGLNANNEuhNuF+l8qWzSk1QdrsSTxVbFTKBlV7EpeHxW2WXww4
 PSkFzmVQmXuauQdYDIzeVmr+liyuFkKCacUBFk+9+H/DU13zsn3QBLgshwGSHs6Zsqx3
 wBfetETnSWITNdY0MlZXT3+rw5lYsElocB5SSSWoNvNZO8BiCKC5ZWjLbKEkjh3kjao7
 F5L9yNbN2uBq9OHqIeV8jzI6Su79YogypQ1XfBSMr4Oixlc1nuWqjZMJUgPuGX69kX63
 4oFg==
X-Gm-Message-State: AOJu0Yz2iWpa+8v9/gClc2GDohlIWUQ99aBvFsqGnJZbnSo+sbG5C95Z
 KA+Fk1B0YjdOiI5in/aj7Xw+Nm3l+/GAP5/cYh2q/zuXkNmzMxAht5cZ7BVHHHCzSRP/xSnxtYQ
 ilfobxH8zqwDTOD8zQqFAHoihDXxZnDLwVN9QT2LF8WWJwOQGjU7SoCcZTR4s9F+xWA==
X-Gm-Gg: AfdE7clx5dooD1UBJFNs4v6Gen4lsT4P5lN7yQCStnMJQG67UQs80H5kpkvX9rQ77i1
 skfkif9RqbFJLEIUeiNOL0NhxLjaVPfO+QB5ppiYS/0gVB/jxsIk3YLHcBjlk1mKU/7bnlIZt7A
 QLzYVMoHyVBm9rdKL9cLo5sT/K+PpsSXgXAdK6Ub+20qC245fK3jOm7LSJAWoevIoRJn9LSdzLF
 0d5o8Zq5eyKJ+h4W2kxqNIDpO14RRz5f5Oge7PVbn5ENUk5RDV07hB5/0u6jzPI2BbzRQ+zWCJJ
 iTBEAdt82HNhQicC/C0IA8CU2zfCc9tgJZW0fQiQuDVLjEYGaIWrFptgKL/bQy1xGOH8OEQqXgJ
 wkbegGWNVS3wkmaB4tL/8Tm4R6SlyuYRJbsrpQkSSgFYUbIUylpb/HmzOVQ1MEg==
X-Received: by 2002:a05:622a:454:b0:51a:88f8:bef2 with SMTP id
 d75a77b69052e-51c747e1e65mr73911141cf.28.1783455007696; 
 Tue, 07 Jul 2026 13:10:07 -0700 (PDT)
X-Received: by 2002:a05:622a:454:b0:51a:88f8:bef2 with SMTP id
 d75a77b69052e-51c747e1e65mr73910791cf.28.1783455007093; 
 Tue, 07 Jul 2026 13:10:07 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f294b3sm71563875e9.3.2026.07.07.13.10.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 13:10:06 -0700 (PDT)
Message-ID: <54b93d27-5223-4832-8dc4-26868b45c32e@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 22:10:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 06/41] hw/sd/sd: Allow multi-byte read/write for generic
 paths
Content-Language: en-US
To: Christian Speich <c.speich@avm.de>
Cc: qemu-devel@nongnu.org
References: <20260512062142.67998-1-philmd@linaro.org>
 <20260512062142.67998-7-philmd@linaro.org>
 <b1910325-bfd7-4f4c-a288-fb40f597ccc0@linaro.org>
 <dfirgzamckaztjht7becglrbcetfhnlj36ge737nowlansrjub@lftxjhzeuhi4>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <dfirgzamckaztjht7becglrbcetfhnlj36ge737nowlansrjub@lftxjhzeuhi4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DMe/JSNb c=1 sm=1 tr=0 ts=6a4d5d20 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=I3iorzQmlbkT6uRqjqUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Ip_AeV6dZ7ZO-C9ZhmAw_ahPRXxOefcO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE5NyBTYWx0ZWRfX5VZ6ZIs14sOm
 QcQ6FFloZAf6l8QY0izC+9rDl/YS0aA0B+YVCDpf2eRB7BzWHan2SCoqciPtfFtyf+p9kqvyxS1
 slKObA/SPPAVQ0zOCkLtK56fgiFCetI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE5NyBTYWx0ZWRfX6wlic7OZumFi
 3Ifbm7TLwmuOMLcL8A5e+1NUuoW1U030JLXYuPjnXZuo8xqFo+E/SHjh5EWZhc71GaKjsjQMmay
 p0yqtCjJHpVRGW7Jyi6+ABecQKPfnCSX7KRhVk5sB6QFXpEF2Cdd1aSssPwEjrisK7qFP/YUACD
 N5QEZr0pwo+c3KbJypXlXG2Xt7LDKFtJSUYm7QNRXe8uFq90dik6EPwBwhw4rc+PsKRqyMdtsTd
 PrSr3HqIxGaAmtZhcV3rgTDZVVLjVM+Y/FDzbYk9knSYEgExs2JAIlB2rdv5hdDFQBh21AKZhj1
 Lf9q+KRDVYTyakO6bkF2PfK2puRuO3rJWDiN4lCmI62QJhnomrbrJL/gQDz3Nf/qBvphPatqX8H
 CnRVVV3rSICwnZx0XY6cdCSUrO9qwgJTJsORUjdd7URZrsTdcUZl6nHxrQpSZfl5o6QXTNZcIXW
 ptvJNvP6OiWU+kGQWDg==
X-Proofpoint-ORIG-GUID: Ip_AeV6dZ7ZO-C9ZhmAw_ahPRXxOefcO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_05,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070197
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Hi Christian,

On 19/5/26 10:58, Christian Speich wrote:
> Hey Phil,
> 
> On Tue, May 12, 2026 at 10:37:34PM +0200, Philippe Mathieu-Daudé wrote:
>> On 12/5/26 08:21, Philippe Mathieu-Daudé wrote:
>>> From: Christian Speich <c.speich@avm.de>
>>>
>>> Paths that use sd_generic_write/read_data can now write/read multiple
>>> bytes with one call.
>>>
>>> Signed-off-by: Christian Speich <c.speich@avm.de>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Message-ID: <20260417-sdcard-performance-b4-v4-2-119e66be10c2@avm.de>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>    hw/sd/sd.c | 62 ++++++++++++++++++++++++++++++------------------------
>>>    1 file changed, 35 insertions(+), 27 deletions(-)


>>> -static bool sd_generic_write_byte(SDState *sd, uint8_t value)
>>> +static bool sd_generic_write_data(SDState *sd, const void *buf, size_t *len)
>>>    {
>>> -    sd->data[sd->data_offset] = value;
>>> +    size_t to_write = MIN(sd->data_size - sd->data_offset, *len);
>>> -    if (++sd->data_offset >= sd->data_size) {
>>> +    memcpy(sd->data, buf, to_write);
>>
>> Always writing beginning of buffer.
>>
>>> +    sd->data_offset += to_write;
>>> +    *len = to_write;
>>> +
>>> +    if (sd->data_offset >= sd->data_size) {
>>>            sd->state = sd_transfer_state;
>>>            return true;
>>>        }
>>> @@ -2627,11 +2631,15 @@ static bool sd_generic_write_byte(SDState *sd, uint8_t value)
>>>    }
>>>    /* Return true when buffer is consumed. Configured by sd_cmd_to_sendingdata() */
>>> -static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
>>> +static bool sd_generic_read_data(SDState *sd, void *buf, size_t *len)
>>>    {
>>> -    *value = sd->data[sd->data_offset];
>>> +    size_t to_read = MIN(sd->data_size - sd->data_offset, *len);
>>> -    if (++sd->data_offset >= sd->data_size) {
>>> +    memcpy(buf, sd->data, to_read);
>>
>> Always reading beginning of buffer.
> 
> Oh, good find! Thanks!
> 
> I see that only 3 of 7 patches from my series made it into this PULL, are there any
> problems with the others I can help with?

This series is the last thing I wanted to get in for the next release
but unfortunately I don't feel having having enough energy to do that
in time tonight :/ Sigh.

Per my notes from May 12, there is a problem in "hw/sd/sd: Use
multi-byte/block writes for block path"

      case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
      ...
+        else if (length >= io_len
+                 && partition_access != EXT_CSD_PART_CONFIG_ACC_RPMB) {
+            length = QEMU_ALIGN_DOWN(length, io_len);
+
+            /* For limited reads, only read the requested block count. */
+            if (sd->multi_blk_cnt != 0) {
+                length = MIN(length, sd->multi_blk_cnt * io_len);
+            }
+
+            sd_blk_read(sd, buf, sd->data_start, length);

              ^^^ at this line.

Too long passed and I don't remember neither the problem or how I was
testing your series, so I'll have to restart from scratch. (Maybe a
short read from the host backend?) Nothing to be done on your side,
I'm at fault here for not updating what happened (why I didn't merged
the whole series) when it was time. I apologize for the delays...

Regards,

Phil.

> Greetings,
> Christian

