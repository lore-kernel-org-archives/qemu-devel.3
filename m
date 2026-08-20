Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45691C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5Yx-00077T-Sk; Thu, 20 Aug 2026 12:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx5Yr-00071p-UH
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:24:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx5Yp-0006FX-4E
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:24:13 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KG6vZR3503914
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 16:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vgyTWV6FdNqCsNZN3WhiIsq290yXWpQQse9jOSqpP3Y=; b=PS4lTkTnguTQK1kU
 hfN+OTHUA5fWXq/siavpxYQtmDVrJARtg25EGif0SxIguR0yiWucE+wuE5/RCtWY
 5EPZLsA8eD3foTDhRbO5+wNSI9Y1AX/V2Y0O/20rpJWucTZmNsow9DaqdtZVGbXB
 Lu8AN12hB43qY1ouh7Gnplbm0R5oPmFbGvcSp0WLbX7f633Ev47wG+ViNjbW0M84
 M24jlXgugYPMOxzKhCQcVL9hL4JzGSxOViHms9nzVn9HlBNRSyuy4+PvFaUzoFUi
 Mxo8J9YcQEU+wEpMlb3WT5hWZjvpDPp+szrJVRdG+5oWV5VxYgiH39Zkp3vh80kp
 PFB+EA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xbv9w3d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 16:24:09 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca6bd8a190cso110850a12.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787243048; x=1787847848; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vgyTWV6FdNqCsNZN3WhiIsq290yXWpQQse9jOSqpP3Y=;
 b=WHHxZICslDZv8Qrz/I3IR5szQJEVnHLYk96RPtEGPUBzWNAPY4uJ+M238GkSiYpWn3
 grvf1TN/rIgtWw0/Cim4oZl2fkriBAhSahHl5VT0o1vij4EA3rbNgHcdFxirXlRe0NfB
 2AQj3lNhitsFqPMxZ6CSfjjUmlg+kYEuB4j2AWdjc3zjfUJdLdizDdmgYSmL2Qv1cI+Q
 Xe/3IKQEDHnvEMz3kCHBE3xjpOgOlJH5hw2QNEiVK5e/owFIC93uA0V3PLXeYxfQOe2I
 qF6eOycNrK1PpXGyJ4goSqsMggDTL2GC+MQjc3BrKVzuvtPSFY5UMtvBkvZBOaK359pR
 et+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787243048; x=1787847848;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vgyTWV6FdNqCsNZN3WhiIsq290yXWpQQse9jOSqpP3Y=;
 b=IXb3NpQbGePvC/Y3FUwx6zMYVyJAgt7oX9DZcaOWLZ+2oTvyB6SfddjS8ANnprd2A6
 1CX9LDBfaP3bYAUbUpFgiuQKYKRTtUhjcqfmpcaFsQdpgAw/RcYDCYvdQ/anIzDJPAft
 y3RtAgxyd15Z6RLbLIRV4c84QyZuGwdTppVzf9f0isEjPiSWArJiUyrTeOb7CxwKD95u
 9ZSkUHZBU6rXIHllBbKsc+svR4pXTC0FXH/jud4kSV5zNtZWUQ4SmevpEZ8DaorVmejG
 02gyUgXlzZU3XqLXRWWsoIrG2z12ULsUOijCMzZDMa6qvtCJDHG7RBhE2HndqJOb2nl0
 Irog==
X-Forwarded-Encrypted: i=1;
 AHgh+RpygXPjCJqQ/B4W7uttj0oRa5raad+3KpTjApXdjMNtZoHNPNz/o5h3h7ucdfpBcArlw3TASdXlnfSJ@nongnu.org
X-Gm-Message-State: AFuF++nK93rFp6/HjGccCqtn7sPWE7uqiPD0AGBoOX6QP7DVXv61OEyx
 ALEHt1jBv96MBeMueQInrKyb86jnbMMg5UngquIMQNQswtrkZW+7MLtV7NBo/XNAAshu9LzqujG
 /vJdzTQf+SzPgBZSa2YuNGxq83ArE9b326SwlxOq/qqpp+VzAsLajc6ifWQ==
X-Gm-Gg: AR+sD11/NsionyXHHfLQhmUL+0FYpxjkqcPyVPMYjEiUP7dQPBJ3ch2vVbGctkwm8Sh
 eePb/d2oPAPV10VNJiBxBYP5Bg8tPjZHYujpciIdAso0yaTfe+vOqUjyLMyU8vsdwdq+gJgxLKg
 7sg8E12+JQ7SElx1v5npAwRR5uyaJ6q2dvHDdLpRjS74AKL+HWyK60+Lb7kG8zpwp1HOATzz1Lu
 sH6KBzTdnon40SzFr5+c6JZznclThjUUIh2XHC4yMulJPywXFWnQjcea2Hn1fhFYzng/5LY2/7A
 tLwTvHO9QdFTIWBzKNh3hgKrqXiPunxaCUCYg4/IyNEgofoRhuqd/P44UXrqP+ANrxqq96NL1+c
 N+8c5ubP62HY3duHn7OmpBwlUpPLYanXYjngzvkl5hUnpjgvutqdYM4RPK5J4RDzgbuLf
X-Received: by 2002:a17:903:4b4b:b0:2cc:d6de:d597 with SMTP id
 d9443c01a7336-2d5fd6b28b5mr285682675ad.7.1787243048098; 
 Thu, 20 Aug 2026 09:24:08 -0700 (PDT)
X-Received: by 2002:a17:903:4b4b:b0:2cc:d6de:d597 with SMTP id
 d9443c01a7336-2d5fd6b28b5mr285681435ad.7.1787243047607; 
 Thu, 20 Aug 2026 09:24:07 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bf175399sm32127728eec.26.2026.08.20.09.24.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 09:24:06 -0700 (PDT)
Message-ID: <7ce963fc-cca4-43df-8e03-36fe09dc80f1@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 09:24:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] hw/vfio: all vfio files can now be common files
To: Andreas Grapentin <gra@linux.ibm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 eric.auger@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, philmd@linaro.org,
 qemu-ppc@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Steffen Eiden <seiden@linux.ibm.com>
References: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
 <20260318174733.1717643-9-pierrick.bouvier@linaro.org>
 <aoPw6-MGBcTOfxwp@li-d8547bcc-2d90-11b2-a85c-a70f2a37009a.ibm.com>
 <29fca8f4-9730-4090-8c89-813ba5c248fb@oss.qualcomm.com>
 <aoWvPGCSA54hg_Dc@li-d8547bcc-2d90-11b2-a85c-a70f2a37009a.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aoWvPGCSA54hg_Dc@li-d8547bcc-2d90-11b2-a85c-a70f2a37009a.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AMKAkK6n c=1 sm=1 tr=0 ts=6a872a29 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=B_4C9q_AyOhyNvvIeM0A:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEyMyBTYWx0ZWRfX6WjLTv53yTrV
 hR+H8KA3/TvAsmMMG64vUUigNulS0kPsEt5BI63yQmxwj+EJ1NmdyPB5Mh316o64JdVl2ZRSzKn
 63FIoBVizXJyR2NM0wNip1EM5/zNhfdUeGOM+EszyvWXfzPYz8WECf5JTAfQKdOdq70yhwz7WUH
 yI4qrHo4KRtOVWRq7TNDQlGuN702kp8sgskHrJTOTr4KBBZK0U+u16G6ndwBPbCegvkTXHcbBMX
 qGRz625vKY3Y66CLUUxb4eXj9RtxN9NHLBas9Aca+4XIRfSKgLoUMGzt9V+8/J81Es1w+Oafsnl
 h4DOfY2pw7iG6v3Fkjre+hTAsqTCfPh1AZehCBTfEUZz+/6/fsy4UD9jez8YhKJ/fzdBH+DfL1d
 zujealqt8lj9tiUy0PgZYBIFORYGgdAh1u8gPp8noKBsFrNrnHpQKMsQ0WVAQBAMQshSROUJQ6N
 El7JDUfBeQw23eMlSyA==
X-Proofpoint-GUID: 1S0GVdGhbUmVg3c4AIZbHHZAue87B92J
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEyMyBTYWx0ZWRfX4rf9eOjZsK5B
 QzXpB0H5h+/VG3+5l0ZuUVNsoN+X727KTZX2HVaGzaIs78UH3gL9/Qlrz/0q2LVJzI5GvZlXEp3
 sOaHJV8oPTqlDyyhwUQ8WoFJctnxz9k=
X-Proofpoint-ORIG-GUID: 1S0GVdGhbUmVg3c4AIZbHHZAue87B92J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200123
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 8/19/2026 1:06 PM, Andreas Grapentin wrote:
> On Aug 18 26, Pierrick Bouvier wrote:
>> It would be better to keep it as system_ss, since bringing back
>> specific_ss will break the single-binary compilation.
>> It should not be needed to rely on target config within the C file
>> directly. At least, we didn't meet any situation where it was.
>> That said, there is nothing in CI (yet) that prevent such regression,
>> but I would appreciate if you could keep it as it is for now.
>>
>> If you need to filter a specific function per config
>> (host/target/whatever), the right way is to isolate this in a new file,
>> and condition inclusion from build system instead.
>>
>> system_ss.add_all(when: 'CONFIG_X', if_true: [newfile.c])
>> Also, you can add associated stubs for other configs in stub_ss.
>> stub_ss.add(files('newfile-stubs.c'))
>>
>> I don't know the details of the series you sent (and too big for me to
>> take a look now), but if you have a precise question on a specific
>> patch, feel free to reach out to me by email.
>>
>> Regards,
>> Pierrick
> 
> Thanks Patrick,
> 
> To give some context, the linked series enables s390 host linux KVM to
> virtualize guests with different (non-native) guest architectures. So we
> would need to build (on host architecture s390x):
> 
> a) qemu-system-s390x with vfio using asm-s390/kvm.h, and
> b) qemu-system-aarch64 with vfio using asm-arm64/kvm.h
> 
> which (based on my current understanding of the code) would make it
> necessary to build the kvm-helpers in the vfio code twice, once per
> guest architecture s390x and aarch64.
>

Depending which functions/constants you need from asm-$arch/kvm.h, the
simpler is probably to expose it in a proper API, and then prefix
symbols per architecture. Finally, you can have a dispatcher function to
return the right value:

void kvm_get_X() {
  if (target_aarch64()) {
    return kvm_aarch64_get_X();
  }
  else if (target_s390x()) {
    return kvm_s390x_get_X();
  }
  g_assert_not_reached().
}

However, it does not scale very well if you need to expose a lot of X.
You could also generate a struct with all values populated per arch, and
use that.

What kind of information do you need to extract from this header?

> I understand that this is a problem for the single-binary efforts of
> qemu, and needs further thought. We are currently trying to come up with
> an approach that more closely aligns with the single-binary goal, and
> any advice you could give to that end would be appreciated :)
> 
> Of course this problem extends to all components in qemu that require
> architecture-specific components of the KVM UAPI.
>

We didn't really meet any issue so far with this, but maybe it's because
we didn't yet to mix two different arch supporting kvm. In all cases, we
take the problems one after another, and we don't anticipate things - it
proved to an inefficient approach.

> Thanks,
> Andreas

Regards,
Pierrick

