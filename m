Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4246C4452A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlp86-0003xV-LQ; Mon, 20 Jul 2026 10:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlp4g-0002SJ-R9
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:34:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlp4f-0002jz-3X
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:34:30 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KDqe612604305
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 14:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 40DLNsd71N5eBW/MZDm6EHHz8FUOpH65CDFh15oybyQ=; b=T8CXIzCZDY2RNEUT
 o9NqrYhq6+e2ckezEK8aq0FjKRAT4IxErZsz65kyn4kraXgM5WsgDQQX00/y6KOJ
 vBAbQV8VuvqNw554UytpLd1zuJZ0wAnSQB8RSWcEw2FAHQUyiqZFeZHF/TYEvlpE
 7VZUZKVO/w3pJMoM5zemwYnV2NT1GiDYfMc2b9usBFpgmczgDSl5qxELRijVmwyZ
 iRIrdGVZef6KC3G0N9vWWXpaYc2IBECqhWnURZWCO1wbsq/Ib9OG9idpvs5Be78k
 rYCXv8oCXkWa1GfBBQXugCyPycgHQstqjYHfMOodKCrsNjdb9Qy+AyRj+O4SCe+/
 qciLJw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhggg9ktt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 14:34:26 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e8e864ef0so339124a91.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 07:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784558065; x=1785162865; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=40DLNsd71N5eBW/MZDm6EHHz8FUOpH65CDFh15oybyQ=;
 b=cgYKU+CgGQadPZ4TiTMqlWCTsal3k/HbJYLIIozQxDCTltxvDxEPeki2APRxGH5WCs
 5e7k4IuCT3O9f0IYctOAtfEFkAK4Jezmyi/1+ziMA9UgRe7RXo0LITGMYxYWeZG5IQdr
 rGikfKs4IjpUU/9qiMrhrq5fTYqVSPQ1eSi6hrGKLug+WDzQSO3J9fQMGKZT53QR/SVp
 YtSszfrBsmAIYZXVcQuLNlxJpZckh2KUHIkErXFv8WSY1TgG3UIVEzubgmC4r/l+FMaS
 hyUkS3CYBDwK4EWk3usI5RVycpvmklz5+5AnuxgzKL/GicOmsXNIbnxos101irrASMqM
 8gFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784558065; x=1785162865;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=40DLNsd71N5eBW/MZDm6EHHz8FUOpH65CDFh15oybyQ=;
 b=P2AsoIORPF06oeahaKgIMuo4lq04pDdoufBcpGOTho+wQmIA8xWtZkXDjyC7k7c3mD
 X1/3iYl+l0tRramiqixd6rANSwi7b4wUBHWWnyWVq6t+cBn+Iio4fVMJaTJx3J5b6WJc
 WBeVWMuBll7Q1Jz48MFnJ+Kz6Ly+wxw79LXdKiITrqOd9wdw+pJge0HqiIi29gNti06r
 afzMvOoT08PUtRF17ZG8sc+zstSA705oY2HuSpq3LNMmL0aOtNe6JeyLPo4t+yvB1CZf
 L/PzBz6GTort461L3qCK2CfsRzJsXe/jIUWqaJGliolCD5/fqWiron72lioOjjlvX0Ty
 DUaQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr1OH9q+hYQj3KqPafyk3SoxJX414ojaotYNxPFUWOmFhE1ZSSTZHAD+anS8OrENYOecUz5lCGAqPcO@nongnu.org
X-Gm-Message-State: AOJu0YzUd85ltPMPf9jdmPt0fSYaF7NjRAJs+Aty76fxf1JUJebiw8q2
 ON18AnzNrIbKB/lOzrxPJZtjYfHKTIkwl+RjLBehjr8FFKZ4IIORR5Krwjtxg7u5vw5hAWADr1v
 t3NO7wrCuIo9GKdfVOet/zsTVUA/24X2E79YFpWQ+RGC09db7/BWwUfb5Yw==
X-Gm-Gg: AR+sD11T3BLDbuYBy5ED1Q+l5xE4xNrt0yHk6fa+BSrg9y1WRzeFsQ47TJ3WyRV3Kzn
 fPGCcgp06IR30/o5MVC6TUDF4KqCBB2EmfLycnV7SAHxjk/AwYGReaEQo/YKHDVh/dtoX99cYjY
 t7UgLb1EvhS3NyrMx07v+rn/Dvth4Wb52onemxysvGeJAO2uOFMjPe4gGp+0ayt6W5fT5pyknhh
 zMvoz1EHD0xL4iZu2Pdxss1IKYxZeVvr2oNAXa+704UzKcgAJf/Hd4msYHfGOG3NkujZC1YC+bX
 fWCpzqQOtkASP9e1P1+MCcPMtFUbyejE6B/6pv+mUj24h/Z/lwA26lQVDtrocMOD6CGopq4FOxC
 bnIEcyTJblLFVSt8yUrqGYdLYfAa1CSP+M5j5MNvcKtTV0Qc6A4iRFSg1mszYjwuSRgMU
X-Received: by 2002:a17:90b:3dce:b0:38e:7f1b:f01 with SMTP id
 98e67ed59e1d1-38e7f1b144cmr4216058a91.36.1784558065254; 
 Mon, 20 Jul 2026 07:34:25 -0700 (PDT)
X-Received: by 2002:a17:90b:3dce:b0:38e:7f1b:f01 with SMTP id
 98e67ed59e1d1-38e7f1b144cmr4216027a91.36.1784558064717; 
 Mon, 20 Jul 2026 07:34:24 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e656e5686sm4010215a91.14.2026.07.20.07.34.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 07:34:23 -0700 (PDT)
Message-ID: <5e5d5996-5376-429f-8787-d448f9bfbf81@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 07:34:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] hw/remote/machine.c: Mark x-remote machine as OK for
 AArch64 and AArch32
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20260507194728.2034696-1-peter.maydell@linaro.org>
 <20260507194728.2034696-2-peter.maydell@linaro.org>
 <1bcf5fd5-b2ee-4adf-ad16-bac12050baa3@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <1bcf5fd5-b2ee-4adf-ad16-bac12050baa3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: TwVhjgkKpepBx7Tk5UpDGobFjeDVGbPQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE2MiBTYWx0ZWRfX4QOA4HrYyrhg
 oIBR2FUiZQl5ePU8FhLApeOtl5P/h/1KAl2JLy9fkpNtZWN+8DS7cqQEGPeXIFgHffkhSTogU43
 WMAV9FdD6A3U969Hcxigo5t3p4bZFrkr9dGiWH+QPTdaJpk9W8Utt5D5QMFxoVGQYnbgBtrhb3A
 zsKVXxAE8HRrIn30qAKHB+iA+WBjtCf9koN+ZQLKlux4D+yzVfZ4PuAZ+VaITJ9UluBS5Cx7RXT
 XfGJa1h+6sf9WHEAThpQrtLtjNhFOT5yU5LkyWFkc6v2QuaB38mApPNUcUTW5GA3KiJPtG7bY9w
 EmheTCVGz1Kshym9oZKXG/rffi2hVNno2kTYX3oP7fCYJuwcwqEGksoI8KXL9rB/EBSHKOFjP5u
 2do4y+GBbI1Oo9DkyCdJiUl7uZ70c4jdHnbQ27ysY2TK1k4qA6ITtT0eIkij3goihB2Ak9mLGEM
 5AmAHuOhb+vte9WoCSA==
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a5e31f2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=LG1_uKtv5rtgl5um6SgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: TwVhjgkKpepBx7Tk5UpDGobFjeDVGbPQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE2MiBTYWx0ZWRfX+78V/jRUrp7V
 eLS6j8KOkK2ouwu6owSJUiBrS1w4hxZXr7EXh815U0Iyv9tWzTrG6sgxfJZpIUrkCcoN+t3WO92
 lGLk/GHRVOpGclbH+FBdsuaIRd7DKWs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_03,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200162
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 7/20/2026 5:39 AM, Philippe Mathieu-Daudé wrote:
> +Stefan
> 
> On 7/5/26 21:47, Peter Maydell wrote:
>> When we updated Arm and AArch64 board types to mark them for the
>> target_machine_typename() filter, we forgot about the "x-remote"
>> machine type, which meant that it disappeared from the set of board
>> types exposed on the qemu-system-arm and qemu-system-aarch64
>> binaries.  We didn't notice this, because although we have a
>> functional test for it, it requires the KVM accelerator and we don't
> 
> I don't remember why it requires KVM.
> 
> $ git grep -i kvm hw/remote/
> hw/remote/Kconfig:3:    depends on PCI && PCI_EXPRESS && KVM
> hw/remote/proxy.c:36: kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state,
> &dev->intr, dev->virq);
> hw/remote/proxy.c:45: kvm_irqchip_add_irqfd_notifier_gsi(kvm_state,
> &dev->intr,
> 
> I suppose these 2 calls should be replaced by generic equivalents:
> - accel_irqchip_remove_irqfd_notifier_gsi()
> - accel_irqchip_add_irqfd_notifier_gsi()
> 
>> run the functional tests on an AArch64 host in CI.
>>
>> Mark the machine as being OK to expose in qemu-system-arm and
> 
> Otherwise if it is tied to KVM, we removed support for 32-bit ARM
> KVM in commit 82bf7ae84ce; ...
> 
>> qemu-system-aarch64, in the same way we do for the "none" machine
>> type. This fixes a check-functional failure on aarch64 host, where
>> it would otherwise fail with:
>>     qemu-system-aarch64: unsupported machine type: "x-remote"
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: eb796c55513d9d39 ("hw/core: Allow ARM/Aarch64 binaries to use
>> the 'none' machine")
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> I couldn't figure out which git commit started enforcing the
>> filtering of machine types based on the TARGET_FOO_MACHINE
>> interface markings, so I picked the Fixes: commit hash for when
>> we added them to the "none" machine, on the basis that that's
>> the point at which we logically ought to have also done x-remote.
>> ---
>>   hw/remote/machine.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/remote/machine.c b/hw/remote/machine.c
>> index ced782f6a9..df08f64019 100644
>> --- a/hw/remote/machine.c
>> +++ b/hw/remote/machine.c
>> @@ -24,6 +24,7 @@
>>   #include "hw/core/qdev.h"
>>   #include "hw/remote/vfio-user-obj.h"
>>   #include "hw/pci/msi.h"
>> +#include "hw/arm/machines-qom.h"
>>     static void remote_machine_init(MachineState *machine)
>>   {
>> @@ -148,6 +149,8 @@ static const TypeInfo remote_machine = {
>>       .class_init = remote_machine_class_init,
>>       .interfaces = (const InterfaceInfo[]) {
>>           { TYPE_HOTPLUG_HANDLER },
>> +        { TYPE_TARGET_AARCH64_MACHINE },
>> +        { TYPE_TARGET_ARM_MACHINE },
> 
> ... so exposing this machine on 32-bit host binary doesn't
> look right.
>

I noticed that and fix it in the upcoming series for single-binary.

>>           { }
>>       }
>>   };
> 


