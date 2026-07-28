Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC408C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wocuw-0005qv-46; Tue, 28 Jul 2026 04:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wocus-0005qN-1u
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:11:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wocuq-0005zh-Fd
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:11:57 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S8225k2071357
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Fhuu587XeHAMs8s33mMejQ1w/880UhFTnqd2/hli89w=; b=FKNUSt7smzUcCQvW
 +igZQY8c3lLnIRPuUdEStGSpnhGvMEduldVbpogDnORjf9q4ctGX3/bIoUj6Nues
 cXbMqceLYmjWqLhj7TLqv6z26P8lyqYE59StO+VkVMJy7BWOFJI5alokQnhjSkfR
 2yAElZDzK51qojM39ulZZgPVyCwa5+sfv3E7hoisdzsF+dg56acPBM5UPG1B/u44
 UQ2kAjX1ExP6weZnKc+fdOaBnGBv1fgErbYCTAtni5JW6b46q6TuZN5mU86vYAym
 qQLkuXyZO4wfj+JU2DrFIOFxTgZ/+aeDLVVXQp1hQRcAhH5SX9yFK2Xa303K4cY1
 WTWlfg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpqxjg6rk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:11:54 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso43197951cf.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 01:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785226314; x=1785831114; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Fhuu587XeHAMs8s33mMejQ1w/880UhFTnqd2/hli89w=;
 b=eb/Uub8hKCSTwUWJT5lkTgm0D2uHEbCXtUrRVElj72emRG5Gb1tMADggRz8X+/9/ct
 4YPPneZ0m7JMY89IQ0Airs7VkwYUGD/dpB2pRgaM2wNbHYmaUwkqrgOmB1ZvTE07uBmX
 nEiiBUv+Vhl8IxHmWEAznJutWYRlF5eK6JoyxzEZWyFwG4QcgmA/fjrZINT23qbbegef
 BV8fMGgjm30B0LYhTkskVK6FxkUOieALBxKLTcUaJzyJzGUDzVjyrNOmXVv52J/cWyi/
 BEGxGrs+h3OUj7I9gHDHenxa3mcdFOisJE3jX/kf7CScONaK82N/KGF9ZSqN84RWJ3gp
 RBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785226314; x=1785831114;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fhuu587XeHAMs8s33mMejQ1w/880UhFTnqd2/hli89w=;
 b=rBA/YxVg71BYUCVMC/1D/1HU5ZKnNUD0LI+NuJM0E+qNIGN7Un8N55Asj2LUdkuTI/
 zEdNiUzPUFmyJUCF9bvml7FO3bCBzxtOvRg1xkR+szy8sm7QNrZNIdBK8wy6tY+fZLf1
 ytHZfr4Kfzz0j/D5kuXEWUCR85KSxHM9N0IS+uiyxvA5P60HR+JGM6yXj+XluoT3NPoU
 l+JVeFvU1y7ROKlsufjSjES3S1zifx+W3L+oibzhW4SRLbWAl9DjC5kod0ol9IbnO5we
 Q1ivCwAu/osIdvxr8WsDk9gWl3DeWL5TEeK3HVKBZKOWssG94VpwrIfYy5tqxIhDPG3r
 XeFA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp0+CxS1Wrmq3K63IhxE1zunD6JWhGcZ5KfrObkFAYp6KB4Kx601ImD1fGruTqvaf4exwhY59QrwpTg@nongnu.org
X-Gm-Message-State: AOJu0YyuW7vP8t/C2FO/wctoAEW00bWqxwc2hN6MAk8oYNMtYAcIvsuQ
 ylTKrPUgBCl5AwNN8+DjkfcA7g9WvggQTO9j/OLM4Ah10RaXLHMRix6K+MSeHz5dWEJ9PSjL1m9
 Ye7bk3r0HWCfUfzQQTsNbyKwklXkqoGhtNui1oQc2ZgZUW6LC3J6YCLFetA==
X-Gm-Gg: AR+sD12tDHikO5lgRf/gPvRx853VlMS0wd3w4wH43/qEMwIXGR1JUdKf4/9LSIo4Jhy
 kNuqBk9J4oEZkI+Ja55xrjSHhuUU/R/hM/FnB70KQ38mWbCiFqrkZYdUvIYSHwUBJQcNSSWDT4K
 NHbBiaNSYogn5TMhgX1IDzGKOexBP1sSo15g0NgGH7ANbzLRfu+30zlYiCTh6ndO4kj4BUCMFyo
 VsxfjPBpHsEwmiOXcs7KguB0/0wo2QuXdKkZc/a2fUvdnNE1YIhrdnmKTYpyFhL4dK9EQXwoCOY
 a+4pVttw187a+uvam9CgfZ+e3C09hIKYkO/O/itJ9tCXRzUS/LhkzwxkCV5HQkwQbSMtolfRE/C
 +KE/9Dhd2tiOkVoTfKt0LK5o8yeL/O8NGTNOsGvTWdCHMh7bTApM=
X-Received: by 2002:ac8:5ad5:0:b0:516:d699:a99b with SMTP id
 d75a77b69052e-529d71d740amr10575031cf.40.1785226313670; 
 Tue, 28 Jul 2026 01:11:53 -0700 (PDT)
X-Received: by 2002:ac8:5ad5:0:b0:516:d699:a99b with SMTP id
 d75a77b69052e-529d71d740amr10574841cf.40.1785226313268; 
 Tue, 28 Jul 2026 01:11:53 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45cb67esm61824155e9.8.2026.07.28.01.11.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 01:11:52 -0700 (PDT)
Message-ID: <c2fe6483-82c1-4531-8140-6105349defab@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 10:11:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 060/103] scripts/probe-gdb-support.py: add mapping for
 mips architecture
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-61-pierrick.bouvier@oss.qualcomm.com>
 <2c415665-f86c-4640-b681-b5ee929ea184@oss.qualcomm.com>
 <e1227756-4df4-434d-85a6-bf4087c1107b@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <e1227756-4df4-434d-85a6-bf4087c1107b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AhQDgHeFdQeRIe78NfpKhhhzUHQ-cv5-
X-Authority-Analysis: v=2.4 cv=MORQXsZl c=1 sm=1 tr=0 ts=6a68644a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2OSBTYWx0ZWRfX95cyROcql8RU
 BcJCXkNsesj9ZpRK0zm+1AEU+YzQAEpFm+S60p4kv0+EKQHBqXz5EhaXlCMTeC4e68S1PUxsD0V
 yLIH+0w/FdAJ+ZTA48IEL+zpAiv2NiI=
X-Proofpoint-ORIG-GUID: AhQDgHeFdQeRIe78NfpKhhhzUHQ-cv5-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2OSBTYWx0ZWRfX5jkBTroHeb/Z
 hgzw90dkeM9cnY4jJU3WIP+xvJlsXV9WjaMCD2wNBRb7OKHIJ8tJGE7MVVjrdcZKGLfrlgMIkXk
 w2HzEfYjrS0C+FXJogVwZ1lx96qs8Ks8OpDaaVlGIOkxL8TVG745bR5+K6DoYsNjBr+9gNAwG4L
 pzTKvsuitM3Lsu3DZzngqtVv+5nOnvUO1ZHp84T5KfIrrx+hstGbKXTSqC+ocmmoAufMKoUwrYM
 7PxeHBMhx36C5GtlD+qdFmC1/na9Jr6EhtITiry0HUVo7C01XkGgKsW/idF+xs4qfY0C7H5fCFa
 /33mjaTYGheVT2fJDcq7n7lrDYulQC8x1OzjteDCoEaoQE8yY5nksAv0qtCKJjvRJHD3ftdXzTt
 vLNs2PgR8rV73Jh80yZ1dOTParLYpvK3FOOiKgPo+lq/Un9CTXDfdc/SgqzFe9crChDMnPwsfBD
 t4JDCM58RerscX9lvCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280069
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

On 28/7/26 09:56, Pierrick Bouvier wrote:
> On 7/28/26 12:39 AM, Philippe Mathieu-Daudé wrote:
>> On 28/7/26 06:42, Pierrick Bouvier wrote:
>>> Tested-by: Alex Bennée <alex.bennee@linaro.org>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>    scripts/probe-gdb-support.py | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/scripts/probe-gdb-support.py b/scripts/probe-gdb-support.py
>>> index 43c70302873..6e3b2579770 100644
>>> --- a/scripts/probe-gdb-support.py
>>> +++ b/scripts/probe-gdb-support.py
>>> @@ -35,6 +35,7 @@
>>>        "Loongarch64" : ["loongarch64"],
>>>        "m68k" : ["m68k"],
>>>        "MicroBlaze" : ["microblaze"],
>>> +    "mips" : ["mips"],
>>
>> IIUC we want (for still few releases):
>>
>>          "mips" : ["mips", "mipsel"],
>>
>>>        "mips:isa64" : ["mips64", "mips64el"],
>>>        "or1k" : ["or1k"],
>>>        "powerpc:common" : ["ppc"],
>>
> 
> I can add it, thanks.

Then including this change:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

