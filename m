Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A49FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISGR-00043s-5X; Thu, 30 Apr 2026 10:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIRZN-0005Vx-N8
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:36:45 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIRZM-00056N-02
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:36:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso7272465e9.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 06:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777556202; x=1778161002; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0FMkEDXEEbdcOqK+gp9+ysnRsGvwXoPwN74nsJzPPPU=;
 b=oQCcMkWjlFGAGjFB0tLx7O435C5QSoPguD0SbQQ98pPQRT41bOYWOJCqWtvVXPwi8B
 P67Nhdh60URfmKOOcuXaIsCV3F2gZ5Rcm/zMW0fj5B4YYpf4f5kGTW4qwGm/fXuVjEfD
 807AMunHYL0WbDf6a4CaGAyiAQWSOEeWpH7aqdghlmvOZceATwEic2nwVqnYxIiGi+R9
 LfQFGvj9JVBLQbkvr7al8a87ZY5xaXbuYF3dvr1mSGDrEz6OMHdnlEhCdAifsG7MgbEd
 qyVLqmiphYtzppQFH6awoV9yp0tN0WJvqZ1cfIWQn3NPpDbo5rlllL6sHgk6o8B2UiMi
 IL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777556202; x=1778161002;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0FMkEDXEEbdcOqK+gp9+ysnRsGvwXoPwN74nsJzPPPU=;
 b=Y6+VKsQOSNykWCfPEK2OVQxUWPFyTZA5qDgWOwrUuiiWpRwrBhEEr514SZOpGJos2B
 WBvE42lPNcT1qZaGuYQkKy+rIonHtBoEuEK0KloBuGzlYUCrHwNMzCE5w9IXSlAl+tOB
 WGsyyiOX9d0NhaMBQj/eHSSldkZE8vo71ccNLXyDopt0eiwb6e5Iu0z9JcksgBzR8HfZ
 4tq60+7ci6MFY6wI26XZycwA4XNaRN6FyrE+fHhjFXFU3VBVENvjkQ/K8wmQABAindGN
 2Y+qWT1tKnW2wZtbYzx1QXOKi9bGcgh8z8VWUa5/fxrm96JYbD+UBMmoGM4GSm6AyN2m
 PspQ==
X-Gm-Message-State: AOJu0YyaXI9Y5/j2bdYM95GQuJHhtQi7cS8Xx8F0VEc8hiRSly2iT4Uc
 sk+QtEaw8JZMqSIHLWXMaG256MNTSHuW+44IMBpKzrwz20rMeFwxRv24ggqCX6pmxlE=
X-Gm-Gg: AeBDiet/wlFedjUZ+DFNPj8sKptab3JWyKFzl1Ryb7iTN03YNXI/a7pCb4i6J6U4i8m
 Hee89+OzYZWmzHB4FRBRCH34hvEDtPyg0h1QZRD//gYty/3bLrvkUbpS6f9NqVD2tTlfnQJn2YY
 n/vVIHotzBkEVl0rePqGKsluY84rah1daQFj0yqUmUzaiaSVzx/mxMy0cK2u1lC9Ufcq4N73qe4
 jMjdhv07t1MXedjQH29lhYPIX1gi7yguwQW51nVVoSMF4HSPGldecBy0tVEXtUG00x3XGGz9qQv
 A8Q0TwfNK/Ob3EBwnQ8xnBQP3YcS4jkivv7INixzDzYkNPnC4QVK6XmEF3L+HTatCx5yyKMPtNJ
 tWC7Cyq3zu1Wt3gy5N8gOTgULwBt/h2Sx1dCVUqttevrFMnz8dp+tf0uc/d+/6Jw8cLMREUVASj
 SS1s0Kn5Ew2n4509b4zozEA/qOY2zFD2Ti/zZZ8AqsFEIg0BtTr+cYsReWIAhigXDCh2Jka0O/Y
 JX4
X-Received: by 2002:a05:600c:34c9:b0:48a:5565:ec3d with SMTP id
 5b1f17b1804b1-48a845291femr54181225e9.22.1777556201913; 
 Thu, 30 Apr 2026 06:36:41 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b3d4843bsm12790762f8f.7.2026.04.30.06.36.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 06:36:41 -0700 (PDT)
Message-ID: <0d73bf7a-f944-4354-93e1-e403de327fd8@linaro.org>
Date: Thu, 30 Apr 2026 15:36:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] qom/object: merge double hash table traversal in
 object_property_del_child
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260429062004.36582-1-guobin@linux.alibaba.com>
 <20260429062004.36582-2-guobin@linux.alibaba.com>
 <81772bda-5aed-43a0-ab2d-ac9b95b518d5@linaro.org>
 <afMfxMlnBsXH7kGQ@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <afMfxMlnBsXH7kGQ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 30/4/26 11:24, Daniel P. Berrangé wrote:
> On Thu, Apr 30, 2026 at 07:07:03AM +1000, Richard Henderson wrote:
>> On 4/29/26 16:20, Bin Guo wrote:
>>> object_property_del_child() previously performed two full iterations
>>> over obj->properties: the first to find the matching child property and
>>> call its release callback, the second to find the same property again
>>> and remove it from the hash table.
>>>
>>> Merge the two loops into one: when the matching property is found, call
>>> the release callback and immediately remove the entry via
>>> g_hash_table_iter_remove(), then break.  This halves the number of hash
>>> table operations in the common case and avoids the redundant second scan.
>>>
>>> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
>>> ---
>>>    qom/object.c | 7 -------
>>>    1 file changed, 7 deletions(-)
>>>
>>> diff --git a/qom/object.c b/qom/object.c
>>> index f981e27044..9c0e8dfd02 100644
>>> --- a/qom/object.c
>>> +++ b/qom/object.c
>>> @@ -629,13 +629,6 @@ static void object_property_del_child(Object *obj, Object *child)
>>>                    prop->release(obj, prop->name, prop->opaque);
>>>                    prop->release = NULL;
>>>                }
>>> -            break;
>>> -        }
>>> -    }
>>> -    g_hash_table_iter_init(&iter, obj->properties);
>>> -    while (g_hash_table_iter_next(&iter, &key, &value)) {
>>> -        prop = value;
>>> -        if (object_property_is_child(prop) && prop->opaque == child) {
>>>                g_hash_table_iter_remove(&iter);
>>>                break;
>>>            }
>>
>> Fixes: b604a854e84 ("qom: Replace object property list with GHashTable")
> 
> On the contrary, this proposed patch breaks that commit.
> 
> The original proposal for that old commit had a single iteration,
> but it was discovered that this broke cleanup for certain devices,
> as prop->release can have side-effects that trigger assertions in
> g_hash_table_iter_remove.  This requires a two phase iteration
> to be safe.

Worth a comment in the code :)

> A test for that problem was added in 8c4d156c187c84b574d287bd4b9ddf9a6975de7c
> and this new patch proposal duly breaks the check-qom-proplist test.
> 
> With regards,
> Daniel
> 
> 


