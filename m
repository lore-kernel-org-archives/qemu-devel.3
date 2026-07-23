Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430B3C531D1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 13:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmtt5-0007i5-9o; Thu, 23 Jul 2026 09:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmtt4-0007hw-CO
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 09:54:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmtt2-00035X-SF
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 09:54:58 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NCvghD4172631
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 13:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X8Ur67wfDCGM5dWiMyoi4X79L+V/OmhrRreEQsEctDQ=; b=lFZdzqYjoOkszPao
 hwo+vgLhV2ui40eVHzy4efn/j5fv2b80SDASQ0/CdDm79oHwJ/n49aUUWFvzLQTX
 RdbmDWlbDeE8+wCEoJMnZjSjQRgH/gcJJK/jLlDuL2Dg2O2t3Klx5W7Y+j1amK9h
 fUxPv/+vRCdrnCuG1qYkwDeB5u3i2HR8xHx1QtGhPrT0nEL1Siiui+uoqg498Vm9
 bGD5DNjl941te/PItap7GAftvwS5V6olHfaiGfrdABDT/CPcoCdX/ya/phJjyDrY
 3m+OP7HUSlImHedOon4ebWiWmYe8RWvkRwyY26PKpWDWw6UmI9X5f6HRzl3Kghus
 0gSomA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fke7qhmj7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 13:54:55 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51a8db414c7so13202231cf.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 06:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784814895; x=1785419695; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=X8Ur67wfDCGM5dWiMyoi4X79L+V/OmhrRreEQsEctDQ=;
 b=LP9aFw4HpWrK7NQhZFbAf5EZYEGLsPBt1fUVurRkj/RDfvnZ/TYtkq2eNJEHnpgEC0
 Q9l0kqWSBKiHNN0Hpf3NJtX/LnNRrS8gfMaKLV2VyfNBXaG2CojAbzG2B5i/LRfcjQu7
 G/CrNGWBKJW7BazLCWau6r+Aw0lsTnC8bw903cz5DAdrywYWFED64XmGTTpIBZy3MZ7u
 cAULUfuBVMRdWQzMCwZcRW7+W2JW2z+/Y0xkiFSMS8yq07Pj9aoF86UAhHJGCb4Ymipv
 pxKwyPMcYUTXom5mC3J1PFO7twELACCgHYkrr4b8sjkukwivq/VwgKY2qpYjlmxP6877
 QyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784814895; x=1785419695;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X8Ur67wfDCGM5dWiMyoi4X79L+V/OmhrRreEQsEctDQ=;
 b=XQlX96wIDiI3e61wsZtzZwyx+Fu18AB+Wh8Q19q1X+kvp7A+KXsATbbHWF1nWOBU6/
 QMWIBfvCMHJ/QWC/VZxmmdaiXLimjfX+hncfvTrqyYvvwJ3kXMkRWrUneg5bP2tYPMO1
 CJmbBLL40POCWL1NtL3vkHi17lMVuMsTgG384Bo8Gzvb/c3OOG04k0xUI9RxkniV6Cke
 wH/J8FeXdZ+lYMskwidMwFKdO+cZuXmQT8UunRcjA06q1VOO1LO8xrgxoU0VJRncIK/n
 p52BK0zOo3bpWfT0PhjzugY0r4SeXYRsIfYXsGw/LE5E1e9ev/UdlMaq0X5qFWZ+WZjO
 lZCw==
X-Forwarded-Encrypted: i=1;
 AHgh+RotTSfLVEjdeZ0i+4ZVnh6ooLf3+2Ho/Svm+dYd1WO+yrxwRY59/2jblPTdREhCp4DyzjQ+Sl8CGt9W@nongnu.org
X-Gm-Message-State: AOJu0YyZGqMBOaoOdjVxy1QY6moG6g8yEgDscLQP/3Vt82Qb4Z7U8+N7
 FOIHGAlWEMPNyIoS3mV6f36npBiYthOjPmaX3HEY3YP47KIZP1Ydhadmw0vo62jLVidhBl/CA90
 /lot2ep8Lc2MKhidY7EL5qxdrJPkF7UiS+PkBbMOCYZ2IbkXMBR1esEycfAPSoWp/yA==
X-Gm-Gg: AR+sD1307ZjZ/wkXUOUOe8ED0wCyfUjJG4iUdnk/OmKPIBFPEKktD0LiYu/xxVrXO1x
 CBGydN+/j4szDOyWWbinTUx5L/RVbwH3mn7JNkIwmnafVhJAq3br7+Grz9A5vxlW8F4YSyGTCzM
 VDfmH0qzdyLZqpGEVPImRnlyvZfjSeXv9PFRKw8Frvydj3ZwtJHMdMW7lKQlTFo3c8CNtiaS2Tc
 ol3G5IDsV13c1a+Au6Gu4dmWXar8JbysUnWVrRHAR4HPl7hRPW58WD/h4HoZjc+eJ0ajioHO2tX
 NkGsTSvAbLI6Lhjey5MF/fnlFR9Ov3WomFLaxZeTAN4AuHHH6jm34xN4xBQ0fWm+Nhoyqm6QNH3
 IfgOce4weL5yetEzgFWzkwKOqvDXceyLN7mw54+huqRfnQ0NomJQ=
X-Received: by 2002:a05:622a:c09:b0:517:875a:d634 with SMTP id
 d75a77b69052e-5283dda389dmr29236311cf.2.1784814895046; 
 Thu, 23 Jul 2026 06:54:55 -0700 (PDT)
X-Received: by 2002:a05:622a:c09:b0:517:875a:d634 with SMTP id
 d75a77b69052e-5283dda389dmr29235581cf.2.1784814893648; 
 Thu, 23 Jul 2026 06:54:53 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b7483f0sm128463825e9.3.2026.07.23.06.54.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 06:54:53 -0700 (PDT)
Message-ID: <fe596402-0be0-4edb-ada4-73e73b72e0d8@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 15:54:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/vmware_vga: Don't allow guest to trigger long
 running loop in host
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: qemu-trivial@nongnu.org, qemu-stable@nongnu.org
References: <20260723120020.330089-1-thuth@redhat.com>
 <d934b1b8-d639-420c-9974-f728fb752bbd@oss.qualcomm.com>
 <a4e46837-e55a-4f9f-8ad5-03f490e39cf8@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <a4e46837-e55a-4f9f-8ad5-03f490e39cf8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEzNyBTYWx0ZWRfX4eVTzvbiYwZi
 k4FQFVUCkCSnTwCf6YM4Ljh4cVobGK3cQpFBXqXMdllfWDBKdu0nhWNZB6+Q2pG+3FZmgSRIQZx
 ICoAiJUDL/d/7uqQQGBwDkK4AW2GqfM=
X-Authority-Analysis: v=2.4 cv=aYxRWxot c=1 sm=1 tr=0 ts=6a621d2f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=J_-Nd1mkAAAA:8 a=NdJ0D6ZV-04Lh1VSvEgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-GUID: SFsAvbEcV5K7mMI_Sh_4CJYK6q8wx7tk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEzNyBTYWx0ZWRfXwpXTYJyls0AG
 LkgumTLDf7qGDROWKzXIrT+vDTlnoInGo6hwFl0A8SW0HGK76cUaGpR/LZo1iffN1j6Cmlc4rDp
 Okl5S9yYolMFsl0EZ63zJDMd6pzwXhB0v/bMxWdWrVH1VxMprZf0B9p0n/ZQeN1fAgfXQPFLSwO
 7mBJNJxaZK5Nf4BSRGT6s64qjn9mnSLJpiPxcYHDZ3VlghrxDVerLI3y8YILb3D4C/dZ12p7vGD
 fth5p9iAo2f8QyZTCnCLcByY+3kFWc4NSourAol3QiDHG5I04w9AqJUDSb+/zu/2eu84sWLQ4Ja
 yr3i7wuwcAIJ33goCqzEH1TNMFHXMzs/y8F5dmtxcvJePipE8NSKWgwaHudR8nkeEDCTT6Od1VD
 X6os8Y65nOVcg5FO8DE4Nu0lq5F5w6ifOnybnmh0c0QaEtzdWnGYVnSNTS/nZgfnjTdKxtWuX5k
 Ux8FjZz7ivRfapYPE4g==
X-Proofpoint-ORIG-GUID: SFsAvbEcV5K7mMI_Sh_4CJYK6q8wx7tk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230137
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 23/7/26 14:35, Thomas Huth wrote:
> On 23/07/2026 14.27, Philippe Mathieu-Daudé wrote:
>> Hi Thomas,
>>
>> On 23/7/26 14:00, Thomas Huth wrote:
>>> From: Thomas Huth <thuth@redhat.com>
>>>
>>> The code in the SVGA_CMD_DEFINE_ALPHA_CURSOR handler in 
>>> vmsvga_fifo_run()
>>> basically does:
>>>
>>>              x = vmsvga_fifo_read(s);
>>>              y = vmsvga_fifo_read(s);
>>>              args = x * y;
>>>              goto badcmd;
>>>              ...
>>> badcmd:
>>>              len -= args;
>>>              if (len < 0) {
>>>                  goto rewind;
>>>              }
>>>              while (args--) {
>>>                  vmsvga_fifo_read(s);
>>>              }
>>>
>>> Thus by supplying huge values for x and y that overflow the result of
>>> the multiplication, the guest can trigger a long-running loop here
>>> that burns the host's CPU cycles.
>>>
>>> Add some sanity checks so that this cannot happen anymore.
>>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3782
>>> Reported-by: Feifan Qian <bea1e@proton.me>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4026
>>> Reported-by: Tristan Madani <tristan@talencesecurity.com>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4076
>>> Reported-by: Sunday Jiang
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   hw/display/vmware_vga.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
>>> index f6f9edfd1d9..04cc438cc02 100644
>>> --- a/hw/display/vmware_vga.c
>>> +++ b/hw/display/vmware_vga.c
>>> @@ -737,6 +737,9 @@ static void vmsvga_fifo_run(struct vmsvga_state_s 
>>> *s)
>>>               vmsvga_fifo_read(s);
>>>               x = vmsvga_fifo_read(s);
>>>               y = vmsvga_fifo_read(s);
>>> +            if (x < 0 || x >= 32768 || y < 0 || y >= 32768) {
>>
>> Maybe add a self-decribing definition instead of magic number?
>>
>>    #define ALPHA_CURSOR_SAFE_LIMIT 32768 /* Arbitrary limit */
>>
>> Otherwise LGTM.
> 
> There is already this in the code:
> 
> #define SVGA_MAX_WIDTH                  2368
> #define SVGA_MAX_HEIGHT                 1770
> 
> Shall I use those? WDYT?

Ah, these look like good candidates :)

> 
>   Thomas
> 
>>> +                goto rewind;
>>> +            }
>>>               args = x * y;
>>>               goto badcmd;
>>>           case SVGA_CMD_RECT_ROP_FILL:
>>> @@ -776,7 +779,7 @@ static void vmsvga_fifo_run(struct vmsvga_state_s 
>>> *s)
>>>               if (len < 0) {
>>>                   goto rewind;
>>>               }
>>> -            while (args--) {
>>> +            while (args-- > 0) {
>>>                   vmsvga_fifo_read(s);
>>>               }
>>>               printf("%s: Unknown command 0x%02x in SVGA command 
>>> FIFO\n",
>>
> 
> 


