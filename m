Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B35C4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 21:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmHak-00037X-BL; Tue, 21 Jul 2026 17:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wmHai-000377-5z; Tue, 21 Jul 2026 17:01:28 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wmHaf-00032m-QT; Tue, 21 Jul 2026 17:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=DANVh01wZQngRMeJF44qSiOarmvTfw1KElvyojABCyM=; b=qVvZ8M8ZMR200Oi7/x61RVEg5j
 8ThWpbb0TM4J/Zsq+0GQaLVzIDKwXlZjoA7ZrpSSKLSPOQjsXH0eYUN/daDKRvBdlUjwqWiO2WRuj
 05F498lKdDJB72BLYDrkT7iMcQmY61Hhg+53Gpf5Dc+ysL9lzBHiLbKmgZdOfVFkfj7nYvdESp1S7
 RP+wDTvcglPEKv5NsIa+/Kp2aMGzfwvc0YB/ste4HJOFDjDdBFG/sbaJu3wjUvPbYby9KbNNseZfZ
 67tytl6NP379thoMiDubNn9wdWsCkG6oVcbuycnFZCbAAeh4+6o1yOdGImSNDFkn0hFyAWyuGo/la
 TSV26oaLYE46e/Fk0nITSRwV8QQGfy6KOinb2nzfQ3DpJe7C7VZ/XTV08xIc0qjjGGBqLWmIEmGnm
 FvHtCjjeBSiBCGrd4Z1NcjeLY6RKwjebCSzHZ15of7zv7Z9d6bBZl6VlHvRth+yqpi/MSDk66vbA5
 2IQxYG42zKD0TRpRUktfHXyw+EY/5W3+TPRVOInLnpTMMqnV/mr83qXWnFKQQUKyopCEifKZyfCYm
 JnocYb0TZXFUVAy5W6VxwtCkZdSsjMvzDe//Aky4mcftW1FK49pFYhPJU8J4keLi69pxw/O4FYMdz
 oNUVPcLhHh8NDD6lP6KmHaJF0svU7hyJs78qFnzOs=;
Received: from [2a02:8012:2f01:0:34d0:4e6f:4b12:1620]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wmHaS-003qg4-5x; Tue, 21 Jul 2026 22:01:12 +0100
Message-ID: <db7478f3-3cfa-43bc-901c-01842f180a92@ilande.co.uk>
Date: Tue, 21 Jul 2026 22:01:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 qemu-stable@nongnu.org
References: <20260313170938.449538-1-peter.maydell@linaro.org>
 <48fdece2-5b98-4785-9b47-9eb2528803e2@ilande.co.uk>
 <CAFEAcA_zf5joZKeiU=c5qP+PzbkrPEVOBZ0nMrOhidiywi_s8w@mail.gmail.com>
 <CAFEAcA-MQ8tObH=9j-O-bqfGMLc2oTwaM1xEzv__GU2qrncmgw@mail.gmail.com>
 <CAFEAcA_boBOkNAaUgX=QEQvm3Mgy2ewkSNtx8zR9e=P58aWmmQ@mail.gmail.com>
 <CAFEAcA-VF47TGkRQBh_phZVvZ36tN5OJepbb1z=t=O=R3CwZDg@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <CAFEAcA-VF47TGkRQBh_phZVvZ36tN5OJepbb1z=t=O=R3CwZDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:34d0:4e6f:4b12:1620
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] target/sparc: Set reg window data structures currently
 after vmstate load
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 18/07/2026 09:46, Peter Maydell wrote:

> Ping^3. It would be nice to get this fix into 11.1, since it's
> a bug that trips the address-sanitizer.
> 
> thanks
> -- PMM
> 
> On Mon, 11 May 2026 at 15:45, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> Ping^2. I think this is now the only remaining blocker to being
>> able to do a full sanitizer test run. I'm happy to throw it into
>> my target-arm queue if you don't have any other sparc patches you
>> need to send, but I think it would be better if it had a
>> reviewed-by tag first :-)
>>
>> -- PMM
>>
>> On Thu, 30 Apr 2026 at 14:02, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>
>>> Ping ? Now we're in the 11.1 cycle it would be nice to get these
>>> remaining sanitizer errors fixed so we can maybe get a CI job
>>> to test a sanitizer build.
>>>
>>> thanks
>>> -- PMM
>>>
>>> On Fri, 20 Mar 2026 at 11:02, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>
>>>> On Mon, 16 Mar 2026 at 21:42, Mark Cave-Ayland
>>>> <mark.cave-ayland@ilande.co.uk> wrote:
>>>>>
>>>>> On 13/03/2026 17:09, Peter Maydell wrote:
>>>>>
>>>>>> In the SPARC CPU state, env->regwptr points into the env->regbase
>>>>>> array at wherever the architectural CWP (current window pointer) says
>>>>>> we are in the register windows.  We don't migrate this directly,
>>>>>> since it's a host pointer, so we must ensure it is set up again
>>>>>> after migration load.
>>>>>>
>>>>>> We also have to deal with a special case when CWP is (nwindows - 1).
>>>>>> In this case, while running we keep the "in" register data for this
>>>>>> window in a temporary location at the end of the regbase[] array, so
>>>>>> that generated code doesn't have to special case this "wrap around"
>>>>>> case.  In cpu_pre_save() we call cpu_set_cwp() to force a copy of the
>>>>>> wrapped data from its temporary location into the architectural
>>>>>> location in window 0's "out" registers.  We then migrate only
>>>>>> (nwindows * 16) entries in the regbase[] array.  So on the
>>>>>> destination we need to copy the "in" register data back to its
>>>>>> temporary location again.
>>>>>>
>>>>>> For 32-bit SPARC we get this right, because the CWP is in the PSR.
>>>>>> The get_psr() function does:
>>>>>>       env->cwp = 0;
>>>>>>       cpu_put_psr_raw(env, val);
>>>>>> which causes cpu_put_psr_raw() to call cpu_set_cwp() in a way that
>>>>>> sets up both regwptr and the wrapped-register data.
>>>>>>
>>>>>> However, for 64-bit SPARC the CWP is not in the PSR, and
>>>>>> cpu_put_psr_raw() will not call cpu_set_cwp().  This leaves the guest
>>>>>> register state in a corrupted state, and the guest will likely crash
>>>>>> on the destination if it didn't happen to be executing with CWP == 0.
>>>>>>
>>>>>> Fix this by adding a cpu_post_load hook which does the cpu_set_cwp()
>>>>>> for the 64-bit case, and enough commentary to explain what is going
>>>>>> on.
>>>>>>
>>>>>> Cc: qemu-stable@nongnu.org
>>>>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>>>>> ---
>>>>>> I ran into this because the "sparc64-migration" functional test seems
>>>>>> to hit this reliably when built with the address sanitizer.  This is
>>>>>> probably a timing thing, because it doesn't trip any ASAN failures,
>>>>>> the guest just crashes on the destination side most of the time
>>>>>> because it returns from a subroutine to a corrupt %o7 return address.
>>>>>>
>>>>>> As far as I can tell this is what the problem is, but I'm a bit
>>>>>> surprised that we have never hit this, given how likely you are to
>>>>>> hit it on a vmsave/vmload or migration.  So am I missing something?
>>>>>> ---
>>>>>>    target/sparc/machine.c | 41 +++++++++++++++++++++++++++++++++++++++--
>>>>>>    1 file changed, 39 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/target/sparc/machine.c b/target/sparc/machine.c
>>>>>> index 4dd75aff74..b935c31630 100644
>>>>>> --- a/target/sparc/machine.c
>>>>>> +++ b/target/sparc/machine.c
>>>>>> @@ -167,14 +167,50 @@ static int cpu_pre_save(void *opaque)
>>>>>>        SPARCCPU *cpu = opaque;
>>>>>>        CPUSPARCState *env = &cpu->env;
>>>>>>
>>>>>> -    /* if env->cwp == env->nwindows - 1, this will set the ins of the last
>>>>>> -     * window as the outs of the first window
>>>>>> +    /*
>>>>>> +     * If env->cwp == env->nwindows - 1, this will set the ins of the last
>>>>>> +     * window as the outs of the first window. We do this because we only
>>>>>> +     * transfer the (nwindows * 16) entries of regbase[] that correspond
>>>>>> +     * to the "proper" locations of the registers; this call has the
>>>>>> +     * effect of copying the wrap register values from their temporary
>>>>>> +     * location down to their proper location ready for migration.
>>>>>>         */
>>>>>>        cpu_set_cwp(env, env->cwp);
>>>>>>
>>>>>>        return 0;
>>>>>>    }
>>>>>>
>>>>>> +static int cpu_post_load(void *opaque, int version_id)
>>>>>> +{
>>>>>> +    /*
>>>>>> +     * For 32-bit SPARC we set the register window data structures
>>>>>> +     * up again correctly when get_psr() called cpu_put_psr_raw(),
>>>>>> +     * which calls cpu_set_cwp(). But for 64-bit SPARC the CWP isn't
>>>>>> +     * part of the PSR, so we need to handle it here.
>>>>>> +     *
>>>>>> +     * There are two things we need to have happen:
>>>>>> +     * 1. regwptr points into regbase[] at the location determined by CWP.
>>>>>> +     * 2. If CWP is (nwindows - 1) then we keep the "in" regs of this window
>>>>>> +     *    in a copy at a temporary location at the end of the regbase[]
>>>>>> +     *    array. For migration we only transferred the (nwindows * 16)
>>>>>> +     *    entries of regbase[] that correspond to the "proper" locations
>>>>>> +     *    of the registers, so now we must copy the wrap registers back to
>>>>>> +     *    their temporary location.
>>>>>> +     *
>>>>>> +     * We achieve both of these by setting env->cwp to 0 and then calling
>>>>>> +     * cpu_set_cwp(). This is the same thing get_psr() does for 32-bit.
>>>>>> +     */
>>>>>> +#if defined(TARGET_SPARC64)
>>>>>> +    SPARCCPU *cpu = opaque;
>>>>>> +    CPUSPARCState *env = &cpu->env;
>>>>>> +    uint32_t cwp = env->cwp;
>>>>>> +
>>>>>> +    env->cwp = 0;
>>>>>> +    cpu_set_cwp(env, cwp);
>>>>>> +#endif
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>>    /* 32-bit SPARC retains migration compatibility with older versions
>>>>>>     * of QEMU; 64-bit SPARC has had a migration break since then, so the
>>>>>>     * versions are different.
>>>>>> @@ -190,6 +226,7 @@ const VMStateDescription vmstate_sparc_cpu = {
>>>>>>        .version_id = SPARC_VMSTATE_VER,
>>>>>>        .minimum_version_id = SPARC_VMSTATE_VER,
>>>>>>        .pre_save = cpu_pre_save,
>>>>>> +    .post_load = cpu_post_load,
>>>>>>        .fields = (const VMStateField[]) {
>>>>>>            VMSTATE_UINTTL_ARRAY(env.gregs, SPARCCPU, 8),
>>>>>>            VMSTATE_UINT32(env.nwindows, SPARCCPU),
>>>>>
>>>>> Nice analysis! I suspect the reason this doesn't always show up is because any
>>>>> context switch (e.g. OpenBIOS, kernel to user, 32-bit to 64-bit etc.) will flush the
>>>>> entire register window set to the stack, and hence reset env->cwp back to 0.
>>>>>
>>>>> It does instinctively feel odd that 32-bit and 64-bit aren't handled in the same way
>>>>> - I wonder if this implicit behaviour on 32-bit somehow needs to be more explicit?
>>>>
>>>> I did wonder about that, but I preferred leaving the 32-bit handling
>>>> the way it is -- trying to unify it with 64-bit would require making
>>>> the get_psr() code path go out of its way to avoid updating the
>>>> reg window data structures, which seems awkward and a bit unnecessary
>>>> given the code does work. So I opted to describe the way the 32-bit
>>>> targets do it in the cpu_post_load() comment, so at least we have
>>>> a record of it.
>>>>
>>>> Are you OK with this patch as it stands, or would you like me to
>>>> change it?

Sorry about the long delay getting to this one. Looking through the migration code, 
the current approach uses get/put handlers for registers that need to do more than 
just update value in the state. Longer term that code could do with an update to use 
.post_load, but for now I think it makes sense to use the existing pattern, 
particularly as it keeps the separation between 32-bit and 64-bit.

The following diff gives the same output in analyze-migration.py and I think should 
solve the issue based upon your analysis:

diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 5f402e098cf..8fdf1782113 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -151,6 +151,37 @@ static const VMStateInfo vmstate_xcc = {
      .get = get_xcc,
      .put = put_xcc,
  };
+
+static int get_cwp(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field)
+{
+    SPARCCPU *cpu = opaque;
+    CPUSPARCState *env = &cpu->env;
+    uint32_t val = qemu_get_be32(f);
+
+    /* needed to ensure that the wrapping registers are correctly updated */
+    env->cwp = 0;
+    cpu_set_cwp(env, val);
+
+    return 0;
+}
+
+static int put_cwp(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field, JSONWriter *vmdesc)
+{
+    SPARCCPU *cpu = opaque;
+    CPUSPARCState *env = &cpu->env;
+    uint32_t val = cpu_get_cwp64(env);
+
+    qemu_put_be32(f, val);
+    return 0;
+}
+
+static const VMStateInfo vmstate_cwp = {
+    .name = "uint32",
+    .get = get_cwp,
+    .put = put_cwp,
+};
  #else
  static bool fq_needed(void *opaque)
  {
@@ -286,7 +317,14 @@ const VMStateDescription vmstate_sparc_cpu = {
          VMSTATE_CPU_TIMER(env.hstick, SPARCCPU),
          /* On SPARC32 env.psrpil and env.cwp are migrated as part of the PSR */
          VMSTATE_UINT32(env.psrpil, SPARCCPU),
-        VMSTATE_UINT32(env.cwp, SPARCCPU),
+        {
+            .name = "env.cwp",
+            .version_id = 0,
+            .size = sizeof(uint32_t),
+            .info = &vmstate_cwp,
+            .flags = VMS_SINGLE,
+            .offset = 0,
+        },
  #endif
          VMSTATE_END_OF_LIST()
      },


ATB,

Mark.


