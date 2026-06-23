Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12FECDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc7vM-0002Ee-NH; Tue, 23 Jun 2026 16:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wc7vL-0002EK-E4
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 16:40:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wc7vJ-000537-G5
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 16:40:46 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NJwm2V2296227
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 20:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dRay3uw/wEf+wtGyiw+Wd1o8wbGqqijUzd/7/De8VNI=; b=noqjvj2d817hONwx
 a6WNbjnHbmJXOzbotNVRUAosefzonXCbOrsxZAiH1qK/7iO2hrkpfWUEZQBdkKIY
 gQKUuxbhM9a8UuB3ZG8w3OxndgD2Y2ayDDhS0TBkGyyc3CNT+gZOcfqKHRUxatz1
 QzRUkeJasFrJYNLX22B8tyoDEVqOMu7wibMOrxbFgVFS3muMxWDsbADTMwJc/vED
 BRKs33A4DoKeoqByGJR0LOdTB6fIY/chkT8l4dPGUIkvKyjAOdRd7KJ8GwbbMjqt
 47CWVNCPPQiFoL14WwLAjvhDfB/fdbf84iaLBk3K6yQWhjSvOI8P6Ykb+1kL3IyD
 uzvIlg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyr28tm65-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 20:40:42 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-519899aa6bfso3218731cf.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 13:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782247241; x=1782852041; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dRay3uw/wEf+wtGyiw+Wd1o8wbGqqijUzd/7/De8VNI=;
 b=ROmtfuea5XiQL4+7S+d00fepi/jz98E5IuENdApsR1GK8u82WzeCupH6c99sO4nLiG
 knBhiKePL7Kq2Yv0mafda+PFrjuxD5eN57QWIIpLWvLiSCIfX19AY7p1JLZ7WceEjDS4
 OVPZmgF7L+ToQ8lHwPuhaGpB8yHfASS/ICu3cNkyCT95lR1e6kVS0lbzwNNlZzZjCla0
 cRpn3u3+/bErSTfYZqIFXQ98zzbGW6CFVpuwqZR/dYaxzBODbkZNXuficxdH+mWPRzg2
 eR9jX+LY6o+X7lEQ2YoQE8XyLG1Vw6tt/90xDrulYBShnkttwAks0/eqxiJ5PtWbXeUC
 3jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782247241; x=1782852041;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dRay3uw/wEf+wtGyiw+Wd1o8wbGqqijUzd/7/De8VNI=;
 b=Gwg8/EfkyHJ2+tNFT1o/AkAkL/rxYcF5e9RM1ie7g0xr3NdLBr+Ry1hpizkkIB7fyY
 i9BpuKFo1El758JCSRPTW7kv1NS7/+xq7g4CiaQggGKUEZB0M0qwmIq7KmcsUEdJ+jc0
 jbUuOMf/boFtwASW/F5H6B6xWLdMWkl43gNWe5y4skCjzIx3u8y+6/TSNGtG2/A/sfIy
 iiR5EQXItQ9NoK/1txM4kI3kIjw7BaVA7HkSqmdhsvI9uQfbk9HKCiK0lAe2ZPk1F7B/
 XuHia6qGW9cUCG7w5aWovO6Ib8wUOMUiLuFbY45vvlYY3EmcwVuhbaU6Ciw/pIocVsBC
 Mt/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+JoA2jJ1bVKwURQI98Fp5eh5zWGXlavXY2HyM2wBIRjIrj2feN2vv14xHF71c1Ty7qVBa2AS4zmku2@nongnu.org
X-Gm-Message-State: AOJu0YxNuJNflTl58Y339mVw8h9z7b6YgESzpbA6X6T806/JA2MtO0KG
 XOmthd4FUen8zvy+XJZDkEcuXVEKl/K0ojoOYSyFVuuALDmCutRCaHySzDBS9o5vaItqlJRli8I
 B64eOJg6AYtk3Ls1X17vKn/Lkf/LSAQ7+s/s24ZUDOBRcmNCPeAn4DpCBSw==
X-Gm-Gg: AfdE7ckeXkhNmZNk8zV8SuMhxF7rVKSyq/66WvuRtDhe+Yi8rEHUBVUpUo6zPzwtxg2
 hei0+ApVpcdlHlt1SLK+FpaxgArMdH3uu1kUBKdncOBNtNs3JQJz2+BOEkg7EQGxAl+UWitlmr1
 Iwu1Nwz0PaFi78TsrIQrjOq1Z1By3QZXRMCSpvcrF1cjacce4gimZabxvd1/jqevrjEDXpQc/O7
 tIu31H0ZzFglogQKABEHGwqq6cqSRljLg5UCJ7JlmH7TWwn2U78oU6GyKUwnCsm9iGAotaQXaYI
 zKHjU99JfHz+llgdM3iymQadxr8vifzWRXpURq+29PDxCg8IEIS5y7k8x65/nBUDFmUNbzhinJu
 y48+zylg9Q6Lc5USPDFO9hAgUWyFANaKBFzvxjaRRk71a
X-Received: by 2002:ac8:7f91:0:b0:517:707b:14f1 with SMTP id
 d75a77b69052e-51a61ef6ad5mr8558931cf.46.1782247241146; 
 Tue, 23 Jun 2026 13:40:41 -0700 (PDT)
X-Received: by 2002:ac8:7f91:0:b0:517:707b:14f1 with SMTP id
 d75a77b69052e-51a61ef6ad5mr8558581cf.46.1782247240662; 
 Tue, 23 Jun 2026 13:40:40 -0700 (PDT)
Received: from [192.168.68.103] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df82692bddsm133102246d6.43.2026.06.23.13.40.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 13:40:40 -0700 (PDT)
Message-ID: <5b6aad47-d3ba-4066-a301-9b360d03f7c5@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 17:40:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/24] target/riscv: gate riscv_cpu_update_mip with
 tcg_enabled()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <20260622193141.1449724-17-daniel.barboza@oss.qualcomm.com>
 <49c4f746-41bf-4a8c-bd43-00658e101c0f@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <49c4f746-41bf-4a8c-bd43-00658e101c0f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE3MCBTYWx0ZWRfX3Ml2UWrwniYV
 sYzeimG7/yKDqRORzagruLM6AEvMh0FGc5fIVUu2kVGlHwGTp4TBfE6eXQ+1VWrDRAxl5oDfO9l
 UuU84vWKJ8cB2T/JfOdbSjSCRENeGoc=
X-Authority-Analysis: v=2.4 cv=b4KCJNGx c=1 sm=1 tr=0 ts=6a3aef4a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=bvpVmVbehaGjik5zenYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: usV99E83EhR3JKSm2G93F7O1OCe_bKMh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE3MCBTYWx0ZWRfX7h5SuRvLpjyb
 0NUSMvhY0+KFZHqhdDuHQcNzU+lx7oJBZiojy5yBBZtdAEueYgpa3tK6uSjJU6Z3SJligw6UJFV
 xdJ9gB315Vb9KhyBRTidvpc4y2f7/K35m60Lfbg7L89sZRGa8jej9ZTSfdUHPm8AFHovILj+Mpc
 RBbCoULpjTYMYIzdil8RPzId0LvDwLnS1wATzwAIrXLo3kigrhGzXwOIvLjR/HUAV+uGWzOonYv
 6D3u4ods8YXxqgrCb4p4VbNSAdSsXHZICb2MiBF4gsE5eDWv6V4veqk8SifGy9boZoPArNs4B8P
 KECLm/f53J3ZvX1cynRE9omK7eL32bei7muWIiefpUORZ+DRQqPG4t4rP7IZD+IbL2DVjWDSGI4
 97ykmNcigHPDdHIoSbId8MihNikml3UKOv3GMFFdaa1nfVvU1XiZe5baSzs7UX8iTk9huVw29cf
 CaQsPMd+yewiMERTnzw==
X-Proofpoint-ORIG-GUID: usV99E83EhR3JKSm2G93F7O1OCe_bKMh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230170
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 6/22/2026 6:12 PM, Philippe Mathieu-Daudé wrote:
> On 22/6/26 21:31, Daniel Henrique Barboza wrote:
>> riscv_cpu_update_mip() is a TCG only call.  Its KVM equivalent is
>> kvm_riscv_set_irq().  cpu.c gates the KVM only function with a
>> kvm_enabled() check, making it unavailable for TCG only builds.  We need
>> to do the same for riscv_cpu_update_mip() otherwise a KVM only build
>> will fail because it doesn't know what this function is.
>>
>> Use tcg_enabled() for the couple of riscv_cpu_update_mip() calls we have
>> unguarded in cpu.c.
>>
>> We have way more calls to deal with in time_helper.c which isn't using
>> kvm_riscv_set_irq() at all. For this file create a riscv_set_irq() local
>> helper that will choose whether to use the KVM or TCG API.
>>
>> The reason we're going through all this hassle in time_helper.c is
>> because hw/int/riscv_aclint.c uses it, and if we don't do something
>> about we won't have riscv_aclint working for KVM.  Whether this is a
>> real problem or not and we should remove aclint support for KVM is
>> question for another day.
>>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> ---
>>   target/riscv/cpu.c         | 19 ++++++++++++++-----
>>   target/riscv/time_helper.c | 33 +++++++++++++++++++++++++--------
>>   2 files changed, 39 insertions(+), 13 deletions(-)
> 
> 
>> diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
>> index 400e917354..2679dbba6c 100644
>> --- a/target/riscv/time_helper.c
>> +++ b/target/riscv/time_helper.c
>> @@ -21,19 +21,34 @@
>>   #include "cpu_bits.h"
>>   #include "time_helper.h"
>>   #include "hw/intc/riscv_aclint.h"
>> +#include "kvm/kvm_riscv.h"
>> +#include "system/kvm.h"
>> +#include "system/tcg.h"
>> +
>> +static void riscv_set_irq(RISCVCPU *cpu, int irq, int level)
> 
> riscv_accel_set_irq? Regardless,
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 

Renamed. thx!

>> +{
>> +    if (kvm_enabled()) {
>> +        kvm_riscv_set_irq(cpu, irq, level);
>> +    }
>> +
>> +    if (tcg_enabled()) {
>> +        riscv_cpu_update_mip(&cpu->env, irq, level);
>> +    }
>> +}
> 
> 


