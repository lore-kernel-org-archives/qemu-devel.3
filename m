Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428E7CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 01:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw9ii-0007DH-GP; Tue, 09 Sep 2025 21:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1uw9ic-0007CQ-Ir; Tue, 09 Sep 2025 21:33:55 -0400
Received: from [115.124.30.130] (helo=out30-130.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1uw9iM-00043J-MT; Tue, 09 Sep 2025 21:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1757467994; h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:From;
 bh=Ea4sB1bpDdQEJZQMAE94tBq4iUkKtnrepAiA6Scopuc=;
 b=ZkgABqWx4v0+6vpxIjcqkidnzVOJcO36pRuS+qxQ6qTgNEfXWd6tEZMVcWAWzQbCEwdpej2kV4Ja+V/qQG1SLEJQXI4ssJ6wtBrFc0gRJUvHavcyo/mfwl24Wk/AnjVYBNWsAGOsagkbC7E4zlpSGTbTHGyiBBCa0qGBrHayKCc=
Received: from 30.166.64.220(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0Wng5iIN_1757467992 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 10 Sep 2025 09:33:13 +0800
Content-Type: multipart/alternative;
 boundary="------------U67p0gXps4LCGsDGTiQnbFrw"
Message-ID: <6c0e3183-78dd-4c64-8083-f4a8433b7a00@linux.alibaba.com>
Date: Wed, 10 Sep 2025 09:33:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/intc: Save timers array in RISC-V mtimer VMState
To: Peter Xu <peterx@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: TANG Tiancheng <lyndra@linux.alibaba.com>, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20250909-timers-v1-0-7ee18a9d8f4b@linux.alibaba.com>
 <20250909-timers-v1-2-7ee18a9d8f4b@linux.alibaba.com>
 <aa5ea2e9-8d01-4d45-99fc-efa5e6061c8b@ventanamicro.com>
 <aMCdYUZyQWQ4Qc4v@x1.local>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <aMCdYUZyQWQ4Qc4v@x1.local>
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.130 (deferred)
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

This is a multi-part message in MIME format.
--------------U67p0gXps4LCGsDGTiQnbFrw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/10/25 5:34 AM, Peter Xu wrote:
> On Tue, Sep 09, 2025 at 09:45:07AM -0300, Daniel Henrique Barboza wrote:
>>
>> On 9/9/25 6:46 AM, TANG Tiancheng wrote:
>>> The current 'timecmp' field in vmstate_riscv_mtimer is insufficient to keep
>>> timers functional after migration.
>>>
>>> If an mtimer's entry in 'mtimer->timers' is active at the time the snapshot
>>> is taken, it means riscv_aclint_mtimer_write_timecmp() has written to
>>> 'mtimecmp' and scheduled a timer into QEMU's main loop 'timer_list'.
>>>
>>> During snapshot save, these active timers must also be migrated; otherwise,
>>> after snapshot load there is no mechanism to restore 'mtimer->timers' back
>>> into the 'timer_list', and any pending timer events would be lost.
>>>
>>> QEMU's migration framework commonly uses VMSTATE_TIMER_xxx macros to save
>>> and restore 'QEMUTimer' variables. However, 'timers' is a pointer array
>>> with variable length, and vmstate.h did not previously provide a helper
>>> macro for such type.
>>>
>>> This commit adds a new macro, 'VMSTATE_TIMER_PTR_VARRAY', to handle saving
>>> and restoring a variable-length array of 'QEMUTimer *'. We then use this
>>> macro to migrate the 'mtimer->timers' array, ensuring that timer events
>>> remain scheduled correctly after snapshot load.
>>>
>>> Reviewed-by: LIU Zhiwei<zhiwei_liu@linux.alibaba.com>
>>> Signed-off-by: TANG Tiancheng<lyndra@linux.alibaba.com>
>>> ---
>> LGTM but I wonder if changing one of the VMSTATE_TIMER_xxxx macros to accept
>> variable length arrays is better than creating a new macro that only RISC-V
>> cares about. Creating a new macro surely is easier and less messier than
>> changing all existing callers though ...
>>
>> I'll let the migration folks weight in. Thanks,
> I didn't see a 2nd user, though..
>
> I'd split VMSTATE_VARRAY_OF_POINTER_UINT32() into a separate patch,
OK.
>   then
> define VMSTATE_TIMER_PTR_VARRAY() in riscv .c files if that's the only
> user,

OK.

We will send the v2 patch set later, where 
VMSTATE_VARRAY_OF_POINTER_UINT32() as a separate patch for migration and 
the others as a patch set for RISC-V. Thanks, Zhiwei

> and if that helps readability.
>
> Thanks,
>
>> Daniel
>>
>>
>>
>>>    hw/intc/riscv_aclint.c      |  6 ++++--
>>>    include/migration/vmstate.h | 14 ++++++++++++++
>>>    2 files changed, 18 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
>>> index 318a9c8248432a8cd4c3f3fa990739917ecf7ca1..9f4c36e965e2aa379d75c0a9f656177f0dd82a45 100644
>>> --- a/hw/intc/riscv_aclint.c
>>> +++ b/hw/intc/riscv_aclint.c
>>> @@ -323,13 +323,15 @@ static void riscv_aclint_mtimer_reset_enter(Object *obj, ResetType type)
>>>    static const VMStateDescription vmstate_riscv_mtimer = {
>>>        .name = "riscv_mtimer",
>>> -    .version_id = 2,
>>> -    .minimum_version_id = 2,
>>> +    .version_id = 3,
>>> +    .minimum_version_id = 3,
>>>        .fields = (const VMStateField[]) {
>>>                VMSTATE_UINT64(time_delta, RISCVAclintMTimerState),
>>>                VMSTATE_VARRAY_UINT32(timecmp, RISCVAclintMTimerState,
>>>                                      num_harts, 0,
>>>                                      vmstate_info_uint64, uint64_t),
>>> +            VMSTATE_TIMER_PTR_VARRAY(timers, RISCVAclintMTimerState,
>>> +                                     num_harts),
>>>                VMSTATE_END_OF_LIST()
>>>            }
>>>    };
>>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>>> index 1ff7bd9ac425ba67cd5ca7ad97bcf570f9e19abe..255e403e5a103188712425d95a719d181e1a7202 100644
>>> --- a/include/migration/vmstate.h
>>> +++ b/include/migration/vmstate.h
>>> @@ -522,6 +522,16 @@ extern const VMStateInfo vmstate_info_qlist;
>>>        .offset     = vmstate_offset_array(_s, _f, _type*, _n),          \
>>>    }
>>> +#define VMSTATE_VARRAY_OF_POINTER_UINT32(_field, _state, _field_num, _version, _info, _type) { \
>>> +    .name       = (stringify(_field)),                                    \
>>> +    .version_id = (_version),                                             \
>>> +    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t),     \
>>> +    .info       = &(_info),                                               \
>>> +    .size       = sizeof(_type),                                          \
>>> +    .flags      = VMS_VARRAY_UINT32 | VMS_ARRAY_OF_POINTER | VMS_POINTER, \
>>> +    .offset     = vmstate_offset_pointer(_state, _field, _type),          \
>>> +}
>>> +
>>>    #define VMSTATE_STRUCT_SUB_ARRAY(_field, _state, _start, _num, _version, _vmsd, _type) { \
>>>        .name       = (stringify(_field)),                                     \
>>>        .version_id = (_version),                                              \
>>> @@ -1035,6 +1045,10 @@ extern const VMStateInfo vmstate_info_qlist;
>>>    #define VMSTATE_TIMER_PTR_ARRAY(_f, _s, _n)                              \
>>>        VMSTATE_ARRAY_OF_POINTER(_f, _s, _n, 0, vmstate_info_timer, QEMUTimer *)
>>> +#define VMSTATE_TIMER_PTR_VARRAY(_f, _s, _f_n)                        \
>>> +VMSTATE_VARRAY_OF_POINTER_UINT32(_f, _s, _f_n, 0, vmstate_info_timer, \
>>> +                                                        QEMUTimer *)
>>> +
>>>    #define VMSTATE_TIMER_TEST(_f, _s, _test)                             \
>>>        VMSTATE_SINGLE_TEST(_f, _s, _test, 0, vmstate_info_timer, QEMUTimer)
>>>
--------------U67p0gXps4LCGsDGTiQnbFrw
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/10/25 5:34 AM, Peter Xu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:aMCdYUZyQWQ4Qc4v@x1.local">
      <pre wrap="" class="moz-quote-pre">On Tue, Sep 09, 2025 at 09:45:07AM -0300, Daniel Henrique Barboza wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">

On 9/9/25 6:46 AM, TANG Tiancheng wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">The current 'timecmp' field in vmstate_riscv_mtimer is insufficient to keep
timers functional after migration.

If an mtimer's entry in 'mtimer-&gt;timers' is active at the time the snapshot
is taken, it means riscv_aclint_mtimer_write_timecmp() has written to
'mtimecmp' and scheduled a timer into QEMU's main loop 'timer_list'.

During snapshot save, these active timers must also be migrated; otherwise,
after snapshot load there is no mechanism to restore 'mtimer-&gt;timers' back
into the 'timer_list', and any pending timer events would be lost.

QEMU's migration framework commonly uses VMSTATE_TIMER_xxx macros to save
and restore 'QEMUTimer' variables. However, 'timers' is a pointer array
with variable length, and vmstate.h did not previously provide a helper
macro for such type.

This commit adds a new macro, 'VMSTATE_TIMER_PTR_VARRAY', to handle saving
and restoring a variable-length array of 'QEMUTimer *'. We then use this
macro to migrate the 'mtimer-&gt;timers' array, ensuring that timer events
remain scheduled correctly after snapshot load.

Reviewed-by: LIU Zhiwei <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@linux.alibaba.com">&lt;zhiwei_liu@linux.alibaba.com&gt;</a>
Signed-off-by: TANG Tiancheng <a class="moz-txt-link-rfc2396E" href="mailto:lyndra@linux.alibaba.com">&lt;lyndra@linux.alibaba.com&gt;</a>
---
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
LGTM but I wonder if changing one of the VMSTATE_TIMER_xxxx macros to accept
variable length arrays is better than creating a new macro that only RISC-V
cares about. Creating a new macro surely is easier and less messier than
changing all existing callers though ...

I'll let the migration folks weight in. Thanks,
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I didn't see a 2nd user, though..

I'd split VMSTATE_VARRAY_OF_POINTER_UINT32() into a separate patch,</pre>
    </blockquote>
    OK.
    <blockquote type="cite" cite="mid:aMCdYUZyQWQ4Qc4v@x1.local">
      <pre wrap="" class="moz-quote-pre"> then
define VMSTATE_TIMER_PTR_VARRAY() in riscv .c files if that's the only
user, </pre>
    </blockquote>
    <p>OK.</p>
    <p>We will send the v2 patch set later, where <span
      style="white-space: pre-wrap">VMSTATE_VARRAY_OF_POINTER_UINT32() as a separate patch for migration and the others as a patch set for RISC-V. 

Thanks,
Zhiwei</span></p>
    <blockquote type="cite" cite="mid:aMCdYUZyQWQ4Qc4v@x1.local">
      <pre wrap="" class="moz-quote-pre">and if that helps readability.

Thanks,

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Daniel



</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">  hw/intc/riscv_aclint.c      |  6 ++++--
  include/migration/vmstate.h | 14 ++++++++++++++
  2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 318a9c8248432a8cd4c3f3fa990739917ecf7ca1..9f4c36e965e2aa379d75c0a9f656177f0dd82a45 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -323,13 +323,15 @@ static void riscv_aclint_mtimer_reset_enter(Object *obj, ResetType type)
  static const VMStateDescription vmstate_riscv_mtimer = {
      .name = "riscv_mtimer",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
      .fields = (const VMStateField[]) {
              VMSTATE_UINT64(time_delta, RISCVAclintMTimerState),
              VMSTATE_VARRAY_UINT32(timecmp, RISCVAclintMTimerState,
                                    num_harts, 0,
                                    vmstate_info_uint64, uint64_t),
+            VMSTATE_TIMER_PTR_VARRAY(timers, RISCVAclintMTimerState,
+                                     num_harts),
              VMSTATE_END_OF_LIST()
          }
  };
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1ff7bd9ac425ba67cd5ca7ad97bcf570f9e19abe..255e403e5a103188712425d95a719d181e1a7202 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -522,6 +522,16 @@ extern const VMStateInfo vmstate_info_qlist;
      .offset     = vmstate_offset_array(_s, _f, _type*, _n),          \
  }
+#define VMSTATE_VARRAY_OF_POINTER_UINT32(_field, _state, _field_num, _version, _info, _type) { \
+    .name       = (stringify(_field)),                                    \
+    .version_id = (_version),                                             \
+    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t),     \
+    .info       = &amp;(_info),                                               \
+    .size       = sizeof(_type),                                          \
+    .flags      = VMS_VARRAY_UINT32 | VMS_ARRAY_OF_POINTER | VMS_POINTER, \
+    .offset     = vmstate_offset_pointer(_state, _field, _type),          \
+}
+
  #define VMSTATE_STRUCT_SUB_ARRAY(_field, _state, _start, _num, _version, _vmsd, _type) { \
      .name       = (stringify(_field)),                                     \
      .version_id = (_version),                                              \
@@ -1035,6 +1045,10 @@ extern const VMStateInfo vmstate_info_qlist;
  #define VMSTATE_TIMER_PTR_ARRAY(_f, _s, _n)                              \
      VMSTATE_ARRAY_OF_POINTER(_f, _s, _n, 0, vmstate_info_timer, QEMUTimer *)
+#define VMSTATE_TIMER_PTR_VARRAY(_f, _s, _f_n)                        \
+VMSTATE_VARRAY_OF_POINTER_UINT32(_f, _s, _f_n, 0, vmstate_info_timer, \
+                                                        QEMUTimer *)
+
  #define VMSTATE_TIMER_TEST(_f, _s, _test)                             \
      VMSTATE_SINGLE_TEST(_f, _s, _test, 0, vmstate_info_timer, QEMUTimer)

</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------U67p0gXps4LCGsDGTiQnbFrw--

