Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2487BCA1013
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 12:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuVgC-0005SI-52; Fri, 05 Sep 2025 08:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uuVg9-0005Qh-M2
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 08:36:33 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uuVfz-0008A9-4w
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 08:36:33 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-61d7b2ec241so2501127a12.0
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 05:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757075779; x=1757680579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pb6OHHH0GbwSnYSTxdh1Uy266GBfyqWbgQuTH1ReFls=;
 b=abw3RgSDii7Cw4dM9YoLBQigk3rZbx3QKVFls9tSfIenv4ZThf+4Xn4b5+U5O7shzg
 TdQNbn9hiWNxOcW4WWDvdSxevqrVw9opIqPCVi3CiPHDURjGOrQfOwGWEfgBVUKvM8e7
 4jub2bHlrbs2HbiolXXTyeAx0YIL/FG8xTCilBo42TfgUQ6xF3NiYqGcQKLpgARybAmK
 twcGMagQB6gf6QXxBmAvBaeNi3u4Au7TFf1XEkvkg5rivLn6f14tkCj5YdspKRHpY/9G
 tlF1GcXOq2F6IeNo7WwR4okpQi/ElN4TEmq8t55ozGe0B7Q2OLN7Gn3NwysR88rOOD+H
 CSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757075779; x=1757680579;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pb6OHHH0GbwSnYSTxdh1Uy266GBfyqWbgQuTH1ReFls=;
 b=dsWFVLc/5Uc0cbcrnn4Cil68v/usZ9Oq6cIRiJ65lg5vE0+AI8Q9eOzYGgyIkEH33Y
 LvEZD3w2BAxAe9NiEc8KL2Bgvnk7cnGUnji28L8XytyezfImSm2csSsOPUE6lBLwe9rg
 AVBcixZLDpg4pq0ji9BG3jGNwfpJaxMhmml+EX8sMEpV2FVn3uVXQJa3HI4R9PrIW6Y2
 Ztobfp4TC6bJ9vlWZ7a0yOg4goPthpT1rK1Fq5lE4dPDlYtW1faI1bfvuc73TRXNZXbM
 mOrNip1rg3GFQ2i+9I5e5ecrZzD4wViaiAx9s4ZYNWdUPG/DZ2tADKyQWa85KNgPgI+K
 0Dvg==
X-Gm-Message-State: AOJu0Yy1nYTwaMQyJEj55DlcjtMpEq5xhY1mlODbFhkS3DTWa5DgtTjJ
 JuZPi4wYQnkt6n6qjVUsAmP0jBDPgrjnVa+YwpCvWaDVm8oH8Du6qIY40p1eNjjm/VY=
X-Gm-Gg: ASbGncswr/H7VRQB1ZvhjdOSkXy5lwHNGK6xVIxxPSH8V/zIlEO+OMpJmwD/t4qbYGJ
 UWRlU4GrkAeP2SUfB1rMPLANke/ms1nufv8iVuJIlA0Bg7IVjMHbpHQzAm52qtwdsRC0nF+Cg/i
 knLdVmvZUYHoO7iZ1bFbrUM5NPXUbeQHvrbF4NdMNHp/MET9iXWLlR+9kxLFPjOBBkBHAuOAI7C
 ODIoX4zctZoHc69Vz2qKKE14bntlM0BvORkXY0jA/PB62cLfc7fI+PJ9qFqnQdnj/+63kwEbNSZ
 BlAIHlFV3PbQuWzXY6No8ur4GDJsuuY4G9+q4fw5Cu0HwFW7Kk0w1G4ldhIfp3EIvZUVssxv0Mb
 EJrInfniOQoiBJhjBV5oMxglUs7vVeZdAMA==
X-Google-Smtp-Source: AGHT+IF1xNk7vuC7eHQ26fRIq75spIeVK5vgqryYGaHRGVjM8eNLZe2i9TKiz3ooRN3JdTnS93qKDA==
X-Received: by 2002:a05:6402:26cf:b0:61d:30b0:da43 with SMTP id
 4fb4d7f45d1cf-61d30b0e1a9mr18492585a12.33.1757075779490; 
 Fri, 05 Sep 2025 05:36:19 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6222f293a31sm493115a12.12.2025.09.05.05.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 05:36:18 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6C5925F879;
 Fri, 05 Sep 2025 13:36:17 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Xin Wang <wangxinxin.wang@huawei.com>
Subject: Re: [PATCH v2 001/281] target/i386: Add support for save/load of
 exception error code
In-Reply-To: <20250904140844.5b670290@fedora> (Igor Mammedov's message of
 "Thu, 4 Sep 2025 14:08:44 +0200")
References: <20250904081128.1942269-1-alex.bennee@linaro.org>
 <20250904081128.1942269-2-alex.bennee@linaro.org>
 <20250904140844.5b670290@fedora>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 05 Sep 2025 13:36:17 +0100
Message-ID: <87a539vzy6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Igor Mammedov <imammedo@redhat.com> writes:

(trim the CC list somewhat)

> On Thu,  4 Sep 2025 09:06:35 +0100
> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
>> From: Xin Wang <wangxinxin.wang@huawei.com>
>>=20
>> For now, qemu save/load CPU exception info(such as exception_nr and
>> has_error_code), while the exception error_code is ignored. This will
>> cause the dest hypervisor reinject a vCPU exception with error_code(0),
>> potentially causing a guest kernel panic.
>>=20
>> For instance, if src VM stopped with an user-mode write #PF (error_code =
6),
>> the dest hypervisor will reinject an #PF with error_code(0) when vCPU re=
sume,
>> then guest kernel panic as:
>>   BUG: unable to handle page fault for address: 00007f80319cb010
>>   #PF: supervisor read access in user mode
>>   #PF: error_code(0x0000) - not-present page
>>   RIP: 0033:0x40115d
>>=20
>> To fix it, support save/load exception error_code.
>
> this potentially will break migration between new/old QEMU versions
> due to presence new subsection. But then according to commit message
> the guest might panic (on dst) when resumed anyways.
>
> So patch changes how guest will fail
> (panic: old =3D> old, old =3D> new
>  vs migration error: new =3D> old ).
>
> Peter,
> do we care and do we need a compat knob to make existing
> machine type behave old way?

Igor,

So this patch is already in master, it was only posted in this series
because my master is never upto date with origin/master.

Apologies again for the noise.

>
>>=20
>> Signed-off-by: Xin Wang <wangxinxin.wang@huawei.com>
>> Link: https://lore.kernel.org/r/20250819145834.3998-1-wangxinxin.wang@hu=
awei.com
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  target/i386/machine.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>=20
>> diff --git a/target/i386/machine.c b/target/i386/machine.c
>> index dd2dac1d443..45b7cea80aa 100644
>> --- a/target/i386/machine.c
>> +++ b/target/i386/machine.c
>> @@ -462,6 +462,24 @@ static const VMStateDescription vmstate_exception_i=
nfo =3D {
>>      }
>>  };
>>=20=20
>> +static bool cpu_errcode_needed(void *opaque)
>> +{
>> +    X86CPU *cpu =3D opaque;
>> +
>> +    return cpu->env.has_error_code !=3D 0;
>> +}
>> +
>> +static const VMStateDescription vmstate_error_code =3D {
>> +    .name =3D "cpu/error_code",
>> +    .version_id =3D 1,
>> +    .minimum_version_id =3D 1,
>> +    .needed =3D cpu_errcode_needed,
>> +    .fields =3D (const VMStateField[]) {
>> +        VMSTATE_INT32(env.error_code, X86CPU),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>  /* Poll control MSR enabled by default */
>>  static bool poll_control_msr_needed(void *opaque)
>>  {
>> @@ -1746,6 +1764,7 @@ const VMStateDescription vmstate_x86_cpu =3D {
>>      },
>>      .subsections =3D (const VMStateDescription * const []) {
>>          &vmstate_exception_info,
>> +        &vmstate_error_code,
>>          &vmstate_async_pf_msr,
>>          &vmstate_async_pf_int_msr,
>>          &vmstate_pv_eoi_msr,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

