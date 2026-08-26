Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA9AC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 06:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz7OI-0003MR-DO; Wed, 26 Aug 2026 02:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wz7OG-0003M1-PA
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 02:45:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wz7OF-0007Cy-7d
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 02:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787726737;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dmD553i3R7mbHOfNOQTqDSWokZ9awtN325Ww0u7K5HM=;
 b=dRqS26qIyZLknPZc0rKe2ZJbePIXGw7UH5WWhyfI901bE925JBhUM1nwHypfL9GNkSmfRV
 Kl3cC2h3qT4LORW5jrsCdVj6RdUs6xX8MMEDDhsSNpC/tom2NFjrdfnlq9fC8f/xVgD/3G
 Ul7wFeB2BGMtE3Cxo0dOpVFD5tcPlRw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-P9t3Xxk9OqeKwgxMBcN_9g-1; Wed, 26 Aug 2026 02:45:34 -0400
X-MC-Unique: P9t3Xxk9OqeKwgxMBcN_9g-1
X-Mimecast-MFC-AGG-ID: P9t3Xxk9OqeKwgxMBcN_9g_1787726733
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c252c2ffeb8so7468666b.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 23:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787726733; x=1788331533;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dmD553i3R7mbHOfNOQTqDSWokZ9awtN325Ww0u7K5HM=;
 b=KzWLbQs9AVp+Qbs/GjcEcSavB5YYT0Q0GpAo9vzSO4N/260FzcQr4/fqQKtlKcCDc+
 PrmqS7NpOV36avfCyuiq92fLqwQI5dsC+Nzb6GcfJh9Pma1wz+3LwFdSmya15lrrm69d
 1TJZxbO9cn0Uh+/UVM4nWaxKg89nm0y17r5WRz5Um7zu8Dd8BRtuiUyLKheTRYmHOB07
 /T/t+rzRtzm2YKdowiMHsgucZ3KS8Tc7ODnxwvEzszjXUtY7icYZCIYv2oCW5N0dPird
 oYOmyAGo7puEmKwGu+qiIL2PbGqeXiIPcDXq8knGXuxHevKTXK+krg7Rr43eOyaEPmmt
 4KlA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqxTeWU1xXRXBc01eWM1vN7Ay1dquCLKRd16HUEI1tJVo32iIzScZRmEOqWoT/O4Aifx3CZEP4xGxNM@nongnu.org
X-Gm-Message-State: AFuF++mh4MSM7wMhj8pzi/ACXH0HjF+Ydw/hr+bfW0xHm57j7IVmaSTl
 ZdHLsFobrEZn0b2hq4rB1cia6wMaTsBbqlYSkod2yT2EyR+Rwe4kw5IvJ+Dklwb4LiBzGeI10vh
 wHE/zVr4eF4F47Cg9AKj7x3hwqiLeGAKSJ0lynyfLwNiNxloIY9bDLBYS
X-Gm-Gg: AR+sD10VxG7fh2CsHo63wMOGsVMQyD4t+kmyrfLBhR8Sd4LCWFapfhaD1iE/3zkM1WL
 8JVEqwaE664zf2dYNFyVuW8GyRZmJ6wiTccSL0sSZLdouJNVaKaAmiRFp6crnG9f1llaqjg+okf
 sl2Obd8vPG0zTK1NNei1B+v1rEtNNkqauAbwoD/tYxLusFOryzW09b/FgffSKju85KyMXexgXYt
 1Cj5By2W26AFYjG2Us5a1JIG+HDGR01YF3dg9gHZjsoAQ7GPyZI+lUKJ/H0F9S0cLZNTmIlZlow
 J2UE8Pnv95MEDv1kw+m22EANppezyB1aLTJoFosGrdLCS9bmsyU2wN1dQDWALWofrI5ll95tq1o
 arGz9HzylhZ4IJvWWsS4VgrehqVwE4XRRF+y+Wys4VVe3GSCY
X-Received: by 2002:a17:907:6d1a:b0:c19:45e3:2f57 with SMTP id
 a640c23a62f3a-c250c4b3348mr459044066b.9.1787726733300; 
 Tue, 25 Aug 2026 23:45:33 -0700 (PDT)
X-Received: by 2002:a17:907:6d1a:b0:c19:45e3:2f57 with SMTP id
 a640c23a62f3a-c250c4b3348mr459040566b.9.1787726732930; 
 Tue, 25 Aug 2026 23:45:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a7303casm437391466b.25.2026.08.25.23.45.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 23:45:31 -0700 (PDT)
Message-ID: <7ce15b69-11bd-497e-9463-0745700fe6fd@redhat.com>
Date: Wed, 26 Aug 2026 08:45:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v7 03/18] target/arm/cpu-sysregs.h.inc: Update with
 automatic generation
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
References: <20260726153221.24773-1-eric.auger@redhat.com>
 <20260726153221.24773-4-eric.auger@redhat.com>
 <42EB7A4B-9C09-4E31-B435-556C6020E451@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <42EB7A4B-9C09-4E31-B435-556C6020E451@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Khushit,
On 8/20/26 8:55 AM, Khushit Shah wrote:
>
>> On 26 Jul 2026, at 8:59 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> Generated definitions with scripts/update-aarch64-cpu-sysregs-header.py
>> based on "AARCHMRS containing the JSON files for Arm A-profile
>> architecture (2026-03)" Registers.json file.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
>> ---
>> target/arm/cpu-sysregs.h.inc | 13 +++++++++++++
>> 1 file changed, 13 insertions(+)
>>
>> diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
>> index ec5a12b0f4..2188cd7be0 100644
>> --- a/target/arm/cpu-sysregs.h.inc
>> +++ b/target/arm/cpu-sysregs.h.inc
>> @@ -1,11 +1,20 @@
>> /* SPDX-License-Identifier: GPL-2.0-or-later */
>> +
>> +/* This file is autogenerated by scripts/update-aarch64-cpu-sysregs-header.py */
>> +/* DEF(<name>, <op0>, <op1>, <crn>, <crm>, <op2>) */
>> +
>> +DEF(AIDR_EL1, 3, 1, 0, 0, 7)
>> +DEF(CCSIDR2_EL1, 3, 1, 0, 0, 2)
>> +DEF(CCSIDR_EL1, 3, 1, 0, 0, 0)
> As CCSIDR*_EL1 are demux registers, a single entry for them does
> not make sense.
OK I removed them

Thanks

Eric
>
> Warm Regards,
> Khushit
>> DEF(CLIDR_EL1, 3, 1, 0, 0, 1)
>> DEF(CTR_EL0, 3, 3, 0, 0, 1)
>> DEF(DCZID_EL0, 3, 3, 0, 0, 7)
>> +DEF(GMID_EL1, 3, 1, 0, 0, 4)
>> DEF(ID_AA64AFR0_EL1, 3, 0, 0, 5, 4)
>> DEF(ID_AA64AFR1_EL1, 3, 0, 0, 5, 5)
>> DEF(ID_AA64DFR0_EL1, 3, 0, 0, 5, 0)
>> DEF(ID_AA64DFR1_EL1, 3, 0, 0, 5, 1)
>> +DEF(ID_AA64DFR2_EL1, 3, 0, 0, 5, 2)
>> DEF(ID_AA64FPFR0_EL1, 3, 0, 0, 4, 7)
>> DEF(ID_AA64ISAR0_EL1, 3, 0, 0, 6, 0)
>> DEF(ID_AA64ISAR1_EL1, 3, 0, 0, 6, 1)
>> @@ -40,6 +49,10 @@ DEF(ID_MMFR5_EL1, 3, 0, 0, 3, 6)
>> DEF(ID_PFR0_EL1, 3, 0, 0, 1, 0)
>> DEF(ID_PFR1_EL1, 3, 0, 0, 1, 1)
>> DEF(ID_PFR2_EL1, 3, 0, 0, 3, 4)
>> +DEF(MIDR_EL1, 3, 0, 0, 0, 0)
>> +DEF(MPIDR_EL1, 3, 0, 0, 0, 5)
>> DEF(MVFR0_EL1, 3, 0, 0, 3, 0)
>> DEF(MVFR1_EL1, 3, 0, 0, 3, 1)
>> DEF(MVFR2_EL1, 3, 0, 0, 3, 2)
>> +DEF(REVIDR_EL1, 3, 0, 0, 0, 6)
>> +DEF(SMIDR_EL1, 3, 1, 0, 0, 6)
>> -- 
>> 2.53.0
>>


