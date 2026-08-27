Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9431C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 16:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzci0-0007Ld-HT; Thu, 27 Aug 2026 12:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ombarkare123@gmail.com>)
 id 1wzchy-0007Kr-Gn
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 12:12:06 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ombarkare123@gmail.com>)
 id 1wzchw-00085v-49
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 12:12:06 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2d7200b2e15so16549305ad.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 09:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787847122; x=1788451922; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0RR9P+O3Z7D5ncDdKnSVmbnZXmb7xth/LnHjtNyI6Uw=;
 b=ZuxJ+/609AEAd+ikB1cb6lRTEAZCCDKQX1t+qrzvX2S5lK5PRDtDt8cu72jKYU47Op
 u0p92Mmyh7Be+97nBBZkIFcJD1ekATKnqgzs0rCcPY8/LE/S6g0ctr/35G2LLQbbqq/b
 5ThfSUNHmG4gKpWrxDYhZo31LD/nthWggnt+Msvj4UA9QrfV+JYzEqzvCZybEh5vFFi4
 8mE/YQGSXgepx6oYn6cIBStOiPoONE3fsYyvuc7tSVFfXHFSWIgV8dGQNqi4V2Z5kTJ5
 CzgvJoszDY8AWpPidU43XppSuKxyrZquPdsg/E4MCLcjmJn8sx/EVZFl4zY7vnaYxGNu
 2JRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787847122; x=1788451922;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0RR9P+O3Z7D5ncDdKnSVmbnZXmb7xth/LnHjtNyI6Uw=;
 b=mJgUJ4WpaHR2cEkj8q4FwHg916aZkqlDBMmcHXfDpIeJ70ACY3ZwjNkTK0NXXM94CT
 bOU22SqZvfefDUZt4rUU6nRM3tWmOlxkhF0lPGfTsYobxngu0rLfaOYmysdIdi+B92LV
 zTqLf50pDHjlfAxVQMqJPgzm+h369CY/ySWXWWToHvn27rydN4zDKwyTX1lqtjp1QTGj
 gUqXNjAiCLiD+MPCHuj8kWyhEqAyfWKt5sRpD9xJyYoW6ruFSAX+KwPmGovoqy/4u9DS
 VsoBFV2ZHZm+TK3bhOXktIRECjsd25wE0JyPzm8xAgfZ+HPkNM9KXl2T+IN6VVTjs3HY
 5AxA==
X-Gm-Message-State: AFuF++kwDSTv94QuPAJlOBsQY+t48EoAGHE7eZnGhJ9XTT8qguDzNroD
 9r7bqXZDJsZU1jNbib/YK+eExnuC860uNU+Jb+7QuixBMMaVQpmFyZRt
X-Gm-Gg: AR+sD12OLLwAH425/PxMqOpTvt9HbO/r3mjcV99RnK0HPiCG5h3sn0OfJ6sizi+vvMr
 h44dQOWZrmelUZCxNfrzvG2wlD7WYvkxqCrMtA2GoanBUOLKyfAAZa4PK68Jj8dSxJ1VL2ezPx0
 k0R/j7zsCPIjlRIdZUQDlB+l6mRl8AC+iMQVettedMveIoa7LET+vpbT0mEysdAT5q8vFC5wmjB
 8L9iomiISkqpKD9bepR+q0La2YPqqcD7Ebg6b2N2VzMkORQGR0GAc28K5eUipX69n1NTo8azt+s
 I+cON1gEUWgsN46itDRfptflWaA2Yc0dBh1Mdhcf/goUBkkkWj4JQfSIeLkyZsJDZvb3l1ch9wG
 lNZ1q/lRxmwNWHN1yi+1eLQMPUFzYFuF9HTpKy/fVLtVU8/DOJpWJpZmRtLAHRtTD9+usL557v7
 CtJNXJ3u+A5Fjymr8QCem7BIYe6EUwckmS26iueJKz55GcJ7xytGCVe96YGBjROcO2oFo6BQ==
X-Received: by 2002:a17:90b:39ab:b0:38d:fda6:4873 with SMTP id
 98e67ed59e1d1-396d0f74e3cmr471752a91.10.1787847121659; 
 Thu, 27 Aug 2026 09:12:01 -0700 (PDT)
Received: from [10.42.0.135] ([103.199.188.243])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b10ff06dsm3520116a91.14.2026.08.27.09.11.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 09:12:00 -0700 (PDT)
Message-ID: <e4341a01-1a6a-46e2-8666-ee25b977a154@gmail.com>
Date: Thu, 27 Aug 2026 21:41:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/block: Add migration support for pflash_cfi02.c
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@mailo.com, kwolf@redhat.com,
 hreitz@redhat.com
References: <20260822183900.110111-1-ombarkare123@gmail.com>
 <CAFEAcA-f-=gP2GZEtTE7x=0mNvk0xL=TvHYDOvK=8GfVybuMQA@mail.gmail.com>
Content-Language: en-US
From: Om <ombarkare123@gmail.com>
In-Reply-To: <CAFEAcA-f-=gP2GZEtTE7x=0mNvk0xL=TvHYDOvK=8GfVybuMQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=ombarkare123@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


On 27/08/26 15:38, Peter Maydell wrote:
> On Sat, 22 Aug 2026 at 19:39, Om Barkare <ombarkare123@gmail.com> wrote:
>> From: OmBarkare <ombarkare123@gmail.com>
>>
>> Device did not have migration support, which would result in its
>> internal state being lost during migration or saves.
>>
>> Add VMStateDescription to serialize state and set memory regions
>> romd_mode to rom_mode field in post load hook
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4157
>>
>> Signed-off-by: Om Barkare <ombarkare123@gmail.com>
>> ---
>>   hw/block/pflash_cfi02.c | 73 ++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 72 insertions(+), 1 deletion(-)
> Thanks for this patch; I have a few comments below, but mostly
> this looks good.
>
> We could mention in the commit message that the only boards
> using pflash_cfi02 are the sh4 r2d and the arm canon-a1100,
> musicpal and xilinx-zynq-a9.
Will mention that
>
>> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
>> index 6f952fe7de..82965e6cdc 100644
>> --- a/hw/block/pflash_cfi02.c
>> +++ b/hw/block/pflash_cfi02.c
>> @@ -46,6 +46,7 @@
>>   #include "qemu/module.h"
>>   #include "hw/core/sysbus.h"
>>   #include "migration/vmstate.h"
>> +#include "system/runstate.h"
>>   #include "trace.h"
>>
>>   #define PFLASH_LAZY_ROMD_THRESHOLD 42
>> @@ -71,7 +72,7 @@ struct PFlashCFI02 {
>>       BlockBackend *blk;
>>       uint32_t uniform_nb_blocs;
>>       uint32_t uniform_sector_len;
>> -    uint32_t total_sectors;
>> +    int32_t total_sectors;
> I think it's worth mentioning in the commit message that we
> have to change total_sectors from uint32_t to int32_t to
> satisfy the VMSTATE_BITMAP macro, but that this is OK because
> it's a value we calculate based on the size of the flash,
> and it's never going to be large enough to overflow an int32_t.
Will mention as this was something that was changed :)
>>       uint32_t nb_blocs[PFLASH_MAX_ERASE_REGIONS];
>>       uint32_t sector_len[PFLASH_MAX_ERASE_REGIONS];
>>       uint32_t chip_len;
>> @@ -107,6 +108,50 @@ struct PFlashCFI02 {
>>       unsigned long *sector_erase_map;
>>       char *name;
>>       void *storage;
>> +    VMChangeStateEntry *vmstate;
>> +};
>> +
>> +static int pflash_post_load(void *opaque, int version_id);
>> +
>> +static bool pflash_sector_erase_needed(void *opaque)
>> +{
>> +    PFlashCFI02 *pfl = opaque;
>> +
>> +    return (pfl->sectors_to_erase > 0);
>> +}
>> +
>> +static const VMStateDescription vmstate_pflash_sector_erase = {
>> +    .name = "pflash_cfi02_erase_sector",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = pflash_sector_erase_needed,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_INT32(sectors_to_erase, PFlashCFI02),
>> +        VMSTATE_UINT64(erase_time_remaining, PFlashCFI02),
>> +        VMSTATE_BITMAP(sector_erase_map, PFlashCFI02, 1, total_sectors),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +
>> +};
> Why did you choose to put this in a subsection ?
These states are accessed only if an erase is ongoing or if it is pending
which can happen if migration is performed mid-erase or when an erase
is suspended. As they are only accessed during an erase, so I thought I 
would
put them in a subsection
>> +
>> +static const VMStateDescription vmstate_pflash = {
>> +    .name = "pflash_cfi02",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .post_load = pflash_post_load,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_INT32(wcycle, PFlashCFI02),
>> +        VMSTATE_UINT8(cmd, PFlashCFI02),
>> +        VMSTATE_UINT8(status, PFlashCFI02),
>> +        VMSTATE_INT32(read_counter, PFlashCFI02),
>> +        VMSTATE_BOOL(rom_mode, PFlashCFI02),
>> +        VMSTATE_TIMER(timer, PFlashCFI02),
> You've missed out "bypass", which is also state that the guest
> can cause the device to change at runtime.
oops, will add that


Thanks for the review


