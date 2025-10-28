Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19C3CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 11:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhmE-0008D6-7V; Tue, 28 Oct 2025 07:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vDhmB-0008Ck-3o
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:22:07 -0400
Received: from sg-1-38.ptr.blmpb.com ([118.26.132.38])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vDhm5-00031e-KL
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1761650509;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=70yvgD0+mhFTNvdtIMjGBGW7uamPRpGwMMhDNO36wnI=;
 b=vKlLdEbHqMHBSvkXXsb0nTd3uDhOV5zonLfbWpbPgW/cP5qQyOsc3S0RL6CjCwrLuXf6cP
 p7e/15WHQ53UEVXDwezIpgg3YAnm1OS8HCJmLbrEgFRUHBq+efHxFI2p4KH2ePza8fSp5z
 M3RNYeFBkGGWVGa6mM+SCQVslo4HVCtvG3xdvtlxT8oFRDXe3aVe8f+Pip7ydbgpSShoVE
 MCFwWMpy8iowbk6aMopUHV9MH42YyuDfNNVQjk6A+UawH+0pxVN36qCY5wNyOMReNQM58V
 jqXDtpV4rKuakk2XeN9DLbwf2MCgpFqv8B+aqD4sZvLZv8q1UaZiaPo49pCyoA==
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: <zhao1.liu@intel.com>, <manos.pitsidianakis@linaro.org>, 
 <richard.henderson@linaro.org>, <philmd@linaro.org>, 
 <chao.liu@openatom.club>, <qemu-rust@nongnu.org>, 
 <qemu-devel@nongnu.org>, <hust-os-kernel-patches@googlegroups.com>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
In-Reply-To: <CABgObfZEm7nu1gRPHQnYc-WJ2PHrBa40VX6Qv2bRTWBYt2BsOA@mail.gmail.com>
From: "Chen Miao" <chenmiao@openatom.club>
Subject: Re: [RFC PATCH v2 3/5] hw/gpio: Move the pcf8574 struct to header
Received: from [198.18.0.1] ([114.249.194.57]) by smtp.feishu.cn with ESMTPS;
 Tue, 28 Oct 2025 19:21:46 +0800
Message-Id: <73983c4b-2e84-4344-9aba-edf12b1c2219@openatom.club>
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+26900a74b+5b73e7+nongnu.org+chenmiao@openatom.club>
Date: Tue, 28 Oct 2025 19:21:45 +0800
References: <90746cd6a57c0df971158f604c422a23d750e0b4.1761644606.git.chenmiao@openatom.club>
 <CABgObfZEm7nu1gRPHQnYc-WJ2PHrBa40VX6Qv2bRTWBYt2BsOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Chen Miao <chenmiao@openatom.club>
Received-SPF: pass client-ip=118.26.132.38;
 envelope-from=chenmiao@openatom.club; helo=sg-1-38.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/28/2025 6:46 PM, Paolo Bonzini wrote:
> On Tue, Oct 28, 2025 at 11:18=E2=80=AFAM chenmiao <chenmiao@openatom.club=
> wrote:
>> To better implement the Rust PCF8574 bindings, move its struct definitio=
n to
>> the header file.
> This should not be needed, the struct is entirely hidden within the C
> implementation and the same should be true for the Rust one.
>
> Paolo

Ok, delete it in subsequent versions=E2=80=8B.

Chen Miao

>> Signed-off-by: chenmiao <chenmiao@openatom.club>
>> ---
>>   hw/gpio/pcf8574.c         | 32 --------------------------------
>>   include/hw/gpio/pcf8574.h | 36 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 36 insertions(+), 32 deletions(-)
>>
>> diff --git a/hw/gpio/pcf8574.c b/hw/gpio/pcf8574.c
>> index 274b44bb61..670fc006bb 100644
>> --- a/hw/gpio/pcf8574.c
>> +++ b/hw/gpio/pcf8574.c
>> @@ -15,38 +15,6 @@
>>   #include "qemu/module.h"
>>   #include "qom/object.h"
>>
>> -/*
>> - * PCF8574 and compatible chips incorporate quasi-bidirectional
>> - * IO. Electrically it means that device sustain pull-up to line
>> - * unless IO port is configured as output _and_ driven low.
>> - *
>> - * IO access is implemented as simple I2C single-byte read
>> - * or write operation. So, to configure line to input user write 1
>> - * to corresponding bit. To configure line to output and drive it low
>> - * user write 0 to corresponding bit.
>> - *
>> - * In essence, user can think of quasi-bidirectional IO as
>> - * open-drain line, except presence of builtin rising edge acceleration
>> - * embedded in PCF8574 IC
>> - *
>> - * PCF8574 has interrupt request line, which is being pulled down when
>> - * port line state differs from last read. Port read operation clears
>> - * state and INT line returns to high state via pullup.
>> - */
>> -
>> -OBJECT_DECLARE_SIMPLE_TYPE(PCF8574State, PCF8574)
>> -
>> -#define PORTS_COUNT (8)
>> -
>> -struct PCF8574State {
>> -    I2CSlave parent_obj;
>> -    uint8_t  lastrq;     /* Last requested state. If changed - assert i=
rq */
>> -    uint8_t  input;      /* external electrical line state */
>> -    uint8_t  output;     /* Pull-up (1) or drive low (0) on bit */
>> -    qemu_irq handler[PORTS_COUNT];
>> -    qemu_irq intrq;      /* External irq request */
>> -};
>> -
>>   static void pcf8574_reset(DeviceState *dev)
>>   {
>>       PCF8574State *s =3D PCF8574(dev);
>> diff --git a/include/hw/gpio/pcf8574.h b/include/hw/gpio/pcf8574.h
>> index 3291d7dbbc..fe1ce891b7 100644
>> --- a/include/hw/gpio/pcf8574.h
>> +++ b/include/hw/gpio/pcf8574.h
>> @@ -10,6 +10,42 @@
>>   #ifndef _HW_GPIO_PCF8574
>>   #define _HW_GPIO_PCF8574
>>
>> +#include "qemu/osdep.h"
>> +#include "hw/i2c/i2c.h"
>> +#include "qom/object.h"
>> +
>>   #define TYPE_PCF8574 "pcf8574"
>>
>> +/*
>> + * PCF8574 and compatible chips incorporate quasi-bidirectional
>> + * IO. Electrically it means that device sustain pull-up to line
>> + * unless IO port is configured as output _and_ driven low.
>> + *
>> + * IO access is implemented as simple I2C single-byte read
>> + * or write operation. So, to configure line to input user write 1
>> + * to corresponding bit. To configure line to output and drive it low
>> + * user write 0 to corresponding bit.
>> + *
>> + * In essence, user can think of quasi-bidirectional IO as
>> + * open-drain line, except presence of builtin rising edge acceleration
>> + * embedded in PCF8574 IC
>> + *
>> + * PCF8574 has interrupt request line, which is being pulled down when
>> + * port line state differs from last read. Port read operation clears
>> + * state and INT line returns to high state via pullup.
>> + */
>> +
>> +OBJECT_DECLARE_SIMPLE_TYPE(PCF8574State, PCF8574)
>> +
>> +#define PORTS_COUNT (8)
>> +
>> +struct PCF8574State {
>> +    I2CSlave parent_obj;
>> +    uint8_t  lastrq;     /* Last requested state. If changed - assert i=
rq */
>> +    uint8_t  input;      /* external electrical line state */
>> +    uint8_t  output;     /* Pull-up (1) or drive low (0) on bit */
>> +    qemu_irq handler[PORTS_COUNT];
>> +    qemu_irq intrq;      /* External irq request */
>> +};
>> +
>>   #endif /* _HW_GPIO_PCF8574 */
>> --
>> 2.43.0
>>

