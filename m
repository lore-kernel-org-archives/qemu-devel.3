Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CE61125856
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Mqz-0000k5-2i; Wed, 11 Mar 2026 12:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0Mqs-0000iS-LH
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:56:06 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0Mqq-0006yx-77
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:56:06 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-8c70b5594f4so14657085a.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 09:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773248163; x=1773852963; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MUwOWzdoBHOkIRTyjQJkYU+X66vPyP2A3vm+6OlCb4M=;
 b=mVbPyXlsQX+QJEinToumUIr8CP1jLb6roxR61qLflCvFOQh2WACNcMqt1swl1O6ntQ
 e1RAEvL4/0IGcrQpnmGV/vyaP7mcR2w46/WmdgTHwA+35Vc8eS1qQ290dNxbE3/z7H5w
 hg9yQYmQZ1y68HuFnME4LwP4eMemLjB24yw5zE6Gg9Y3W8fd79sDITgMGYEh3IgjDzsZ
 gL3YkxNIyD9yzZO6DXDnOl4Iv/8P+M/fp0UHTif6ZSm70yZaog/Xzbq1+UaGs5XWo0BQ
 91NK8fSYxaL1vXCnJZ5M01lETzdEgAcOEP9GAysYP+tskTlFUFIqrTfSIn21l2qB3G+V
 vsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773248163; x=1773852963;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MUwOWzdoBHOkIRTyjQJkYU+X66vPyP2A3vm+6OlCb4M=;
 b=P5ReD7ag1On98NCbrGiUZN+sNaZt2EVD3YIhBEdl4Eq53xrbYtmdcAvxCHhPYFe62W
 Wo2pWq8kkNYP19bYxxi90zUQhYMEO1y+opDTR2MoAiY6X0c1w7CWk7b+8P4ZMyBzLTFH
 Ie+nmU6Wo10NcD28af0I4xwpphherOEzFQFQPw2CAUdUq7AC0ynAHZjWZ9Akdd02Mxu/
 fD21ocTMnyekFb7R0o0E4oonCfcjWpKkbwXmfMLyN5y99u2gYO71q5mj4VoMwbaFLPBy
 sneoEsNPoFVX08HBBoKNPs5rOGfTl3GA/hWntiVoTHWJemiCLlCvKN4UOJtDa5s4Xhk0
 hWag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzsxyms+ZUJ6rcjw8/8hIn2itgs1NYUtLF1vf19EvFrbrrMvZi1oeb431gyty+bdKw4PH5FhQrku9c@nongnu.org
X-Gm-Message-State: AOJu0YwR9F9J3W/argzzyOV+0CxVr2qc/5iMBb7Aboqm5UhX3sekpPcw
 vt6kHB7nahQ5cNRzfYDtgDQ4Bk5ifPdqHNZdwplguNvCJBWbhIvIYFZ/90zHcT1E6IE=
X-Gm-Gg: ATEYQzxG3mG6Rz/Bxera2B9uwBk/6iDl5ANg8wNSfooCw+8s1sPWUGB6q0RAfVOWrs0
 RTnCg3e8TfcHgUn8BDwjZrfpgX8L4nFMJJGHOd6hNzoHT6h8eqD5i+aXC1SkhqglJOYWBLyTKhO
 LXAZP+Zssjfp/j7BsevbqF1nGM6z6TakrwfkFmf0tnW9MJlEpr18oFNAlqMLHxHtreQYXlnCSc0
 frqgOfzEPZBp2GtEYwUS3eZrW86NMzeI4zn4O+K3C5wZcCHHyV5Asz2hcQWmhx490+FXCInZKQe
 O7IO2nTeGujD7PUSPbWbaBnPnh/7ITuPcTYi/mfb1up/3sCrXUi3rvR+4mAW6RvxjpDyZcmGnl7
 GN224Zx1jFAO6EyMPqccfX61L6AeLHOy4AIlcWa+JH5SymqEGFFdysescFWtV4aftjFwCBSB4uV
 Gny4sUuUbb32HjqX30DKP31noQn/R20d4vMMZWD6xeM8IZSb6v9Aci2FtsGBkwTIlnLsGL
X-Received: by 2002:a05:620a:4688:b0:8cd:8cc3:e0a with SMTP id
 af79cd13be357-8cdaa7c1392mr48052885a.16.1773248162634; 
 Wed, 11 Mar 2026 09:56:02 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda1eab31dsm167115085a.0.2026.03.11.09.56.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 09:56:02 -0700 (PDT)
Message-ID: <81c23f73-e49f-408f-9fb5-6f805ced199d@linaro.org>
Date: Wed, 11 Mar 2026 09:56:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial] plugins: add missing docstrings to qemu-plugin.h
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, richard.henderson@linaro.org
References: <20260309-add-missing-plugin-docs-v1-1-41dddcd177c8@epfl.ch>
 <f624f3d9-aa11-406a-ac9b-f3fa2b103291@linaro.org>
 <87o6kuit4m.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 xsDNBGK9dgwBDACYuRpR31LD+BnJ0M4b5YnPZKbj+gyu82IDN0MeMf2PGf1sux+1O2ryzmnA
 eOiRCUY9l7IbtPYPHN5YVx+7W3vo6v89I7mL940oYAW8loPZRSMbyCiUeSoiN4gWPXetoNBg
 CJmXbVYQgL5e6rsXoMlwFWuGrBY3Ig8YhEqpuYDkRXj2idO11CiDBT/b8A2aGixnpWV/s+AD
 gUyEVjHU6Z8UervvuNKlRUNE0rUfc502Sa8Azdyda8a7MAyrbA/OI0UnSL1m+pXXCxOxCvtU
 qOlipoCOycBjpLlzjj1xxRci+ssiZeOhxdejILf5LO1gXf6pP+ROdW4ySp9L3dAWnNDcnj6U
 2voYk7/RpRUTpecvkxnwiOoiIQ7BatjkssFy+0sZOYNbOmoqU/Gq+LeFqFYKDV8gNmAoxBvk
 L6EtXUNfTBjiMHyjA/HMMq27Ja3/Y73xlFpTVp7byQoTwF4p1uZOOXjFzqIyW25GvEekDRF8
 IpYd6/BomxHzvMZ2sQ/VXaMAEQEAAc0uUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91
 dmllckBsaW5hcm8ub3JnPsLBDgQTAQoAOBYhBGa5lOyhT38uWroIH3+QVA0KHNAPBQJivXYM
 AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH+QVA0KHNAPX58L/1DYzrEO4TU9ZhJE
 tKcw/+mCZrzHxPNlQtENJ5NULAJWVaJ/8kRQ3Et5hQYhYDKK+3I+0Tl/tYuUeKNV74dFE7mv
 PmikCXBGN5hv5povhinZ9T14S2xkMgym2T3DbkeaYFSmu8Z89jm/AQVt3ZDRjV6vrVfvVW0L
 F6wPJSOLIvKjOc8/+NXrKLrV/YTEi2R1ovIPXcK7NP6tvzAEgh76kW34AHtroC7GFQKu/aAn
 HnL7XrvNvByjpa636jIM9ij43LpLXjIQk3bwHeoHebkmgzFef+lZafzD+oSNNLoYkuWfoL2l
 CR1mifjh7eybmVx7hfhj3GCmRu9o1x59nct06E3ri8/eY52l/XaWGGuKz1bbCd3xa6NxuzDM
 UZU+b0PxHyg9tvASaVWKZ5SsQ5Lf9Gw6WKEhnyTR8Msnh8kMkE7+QWNDmjr0xqB+k/xMlVLE
 uI9Pmq/RApQkW0Q96lTa1Z/UKPm69BMVnUvHv6u3n0tRCDOHTUKHXp/9h5CH3xawms7AzQRi
 vXYMAQwAwXUyTS/Vgq3M9F+9r6XGwbak6D7sJB3ZSG/ZQe5ByCnH9ZSIFqjMnxr4GZUzgBAj
 FWMSVlseSninYe7MoH15T4QXi0gMmKsU40ckXLG/EW/mXRlLd8NOTZj8lULPwg/lQNAnc7GN
 I4uZoaXmYSc4eI7+gUWTqAHmESHYFjilweyuxcvXhIKez7EXnwaakHMAOzNHIdcGGs8NFh44
 oPh93uIr65EUDNxf0fDjnvu92ujf0rUKGxXJx9BrcYJzr7FliQvprlHaRKjahuwLYfZK6Ma6
 TCU40GsDxbGjR5w/UeOgjpb4SVU99Nol/W9C2aZ7e//2f9APVuzY8USAGWnu3eBJcJB+o9ck
 y2bSJ5gmGT96r88RtH/E1460QxF0GGWZcDzZ6SEKkvGSCYueUMzAAqJz9JSirc76E/JoHXYI
 /FWKgFcC4HRQpZ5ThvyAoj9nTIPI4DwqoaFOdulyYAxcbNmcGAFAsl0jJYJ5Mcm2qfQwNiiW
 YnqdwQzVfhwaAcPVABEBAAHCwPYEGAEKACAWIQRmuZTsoU9/Llq6CB9/kFQNChzQDwUCYr12
 DAIbDAAKCRB/kFQNChzQD/XaC/9MnvmPi8keFJggOg28v+r42P7UQtQ9D3LJMgj3OTzBN2as
 v20Ju09/rj+gx3u7XofHBUj6BsOLVCWjIX52hcEEg+Bzo3uPZ3apYtIgqfjrn/fPB0bCVIbi
 0hAw6W7Ygt+T1Wuak/EV0KS/If309W4b/DiI+fkQpZhCiLUK7DrA97xA1OT1bJJYkC3y4seo
 0VHOnZTpnOyZ+8Ejs6gcMiEboFHEEt9P+3mrlVJL/cHpGRtg0ZKJ4QC8UmCE3arzv7KCAc+2
 dRDWiCoRovqXGE2PdAW8788qH5DEXnwfzDhnCQ9Eot0Eyi41d4PWI8TWZFi9KzGXJO82O9gW
 5SYuJaKzCAgNeAy3gUVUUPrUsul1oe2PeWMFUhWKrqko0/Qo4HkwTZY6S16drTMncoUahSAl
 X4Z3BbSPXPq0v1JJBYNBL9qmjULEX+NbtRd3v0OfB5L49sSAC2zIO8S9Cufiibqx3mxZTaJ1
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <87o6kuit4m.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qk1-x736.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 3/11/26 2:59 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> On 3/9/26 9:21 AM, Florian Hofhammer wrote:
>>> This patch adds docstrings for typedefs and function declarations in
>>> include/plugins/qemu-plugin.h that were previously missing. This
>>> resolves inconsistencies in the docs, e.g., the description for
>>> qemu_plugin_read_register() referring to qemu_plugin_register_flush_cb()
>>> but code cache flush callbacks not being documented themselves.
>>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>>> ---
>>> Hi,
>>> While working on a QEMU plugin and browsing the online docs at
>>> https://www.qemu.org/docs/master/devel/tcg-plugins.html, I noticed that
>>> some of the API functions were not actually documented.
>>> I went through the include/plugins/qemu-plugin.h header file and
>>> added
>>> docstrings where they were missing, hoping of course that I documented
>>> the correct functionality based on my understanding of the plugin
>>> internals.
>>> I hope that's useful and I didn't miss anything!
>>>
>>
>> Thanks for the effort, that's always welcome to add documentation on a
>> public API like this!
>>
>>> Best regards,
>>> Florian
>>> --
>>> Florian Hofhammer
>>> ---
>>>    include/plugins/qemu-plugin.h | 98 ++++++++++++++++++++++++++++++++++++++-----
>>>    1 file changed, 88 insertions(+), 10 deletions(-)
>>> diff --git a/include/plugins/qemu-plugin.h
>>> b/include/plugins/qemu-plugin.h
>>> index 827e8e1787..fcf5af52ed 100644
>>> --- a/include/plugins/qemu-plugin.h
>>> +++ b/include/plugins/qemu-plugin.h
>>> @@ -339,12 +339,28 @@ enum qemu_plugin_cb_flags {
>>>        QEMU_PLUGIN_CB_RW_REGS_PC,
>>>    };
>>>    +/**
>>> + * enum qemu_plugin_mem_rw - type of memory access
>>> + *
>>> + * @QEMU_PLUGIN_MEM_R: memory read access only
>>> + * @QEMU_PLUGIN_MEM_W: memory write access only
>>> + * @QEMU_PLUGIN_MEM_RW: memory read and write access
>>> + */
>>>    enum qemu_plugin_mem_rw {
>>>        QEMU_PLUGIN_MEM_R = 1,
>>>        QEMU_PLUGIN_MEM_W,
>>>        QEMU_PLUGIN_MEM_RW,
>>>    };
>>>    +/**
>>> + * enum qemu_plugin_mem_value_type - size of memory value
>>> + *
>>> + * @QEMU_PLUGIN_MEM_VALUE_U8: unsigned 8-bit value
>>> + * @QEMU_PLUGIN_MEM_VALUE_U16: unsigned 16-bit value
>>> + * @QEMU_PLUGIN_MEM_VALUE_U32: unsigned 32-bit value
>>> + * @QEMU_PLUGIN_MEM_VALUE_U64: unsigned 64-bit value
>>> + * @QEMU_PLUGIN_MEM_VALUE_U128: unsigned 128-bit value
>>> + */
>>>    enum qemu_plugin_mem_value_type {
>>>        QEMU_PLUGIN_MEM_VALUE_U8,
>>>        QEMU_PLUGIN_MEM_VALUE_U16,
>>> @@ -353,7 +369,13 @@ enum qemu_plugin_mem_value_type {
>>>        QEMU_PLUGIN_MEM_VALUE_U128,
>>>    };
>>>    -/* typedef qemu_plugin_mem_value - value accessed during a
>>> load/store */
>>> +/**
>>> + * typedef qemu_plugin_mem_value - value accessed during a load/store
>>> + *
>>> + * @type: the memory access size
>>> + * @data: the value accessed during the memory operation (value after
>>> + *        read/write)
>>> + */
>>>    typedef struct {
>>>        enum qemu_plugin_mem_value_type type;
>>>        union {
>>> @@ -462,7 +484,6 @@ void qemu_plugin_register_vcpu_tb_exec_cond_cb(struct qemu_plugin_tb *tb,
>>>     * @QEMU_PLUGIN_INLINE_ADD_U64: add an immediate value uint64_t
>>>     * @QEMU_PLUGIN_INLINE_STORE_U64: store an immediate value uint64_t
>>>     */
>>> -
>>>    enum qemu_plugin_op {
>>>        QEMU_PLUGIN_INLINE_ADD_U64,
>>>        QEMU_PLUGIN_INLINE_STORE_U64,
>>> @@ -803,6 +824,20 @@ const void *qemu_plugin_request_time_control(void);
>>>    QEMU_PLUGIN_API
>>>    void qemu_plugin_update_ns(const void *handle, int64_t time);
>>>    +/**
>>> + * typedef qemu_plugin_vcpu_syscall_cb_t - vCPU syscall callback function type
>>> + * @id: plugin id
>>> + * @vcpu_index: the executing vCPU
>>> + * @num: the syscall number
>>> + * @a1: the 1st syscall argument
>>> + * @a2: the 2nd syscall argument
>>> + * @a3: the 3rd syscall argument
>>> + * @a4: the 4th syscall argument
>>> + * @a5: the 5th syscall argument
>>> + * @a6: the 6th syscall argument
>>> + * @a7: the 7th syscall argument
>>> + * @a8: the 8th syscall argument
>>> + */
>>>    typedef void
>>>    (*qemu_plugin_vcpu_syscall_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_index,
>>>                                     int64_t num, uint64_t a1, uint64_t a2,
>>> @@ -836,24 +871,61 @@ typedef bool
>>>                                            uint64_t a6, uint64_t a7, uint64_t a8,
>>>                                            uint64_t *sysret);
>>>    -QEMU_PLUGIN_API
>>> -void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
>>> -                                          qemu_plugin_vcpu_syscall_cb_t cb);
>>> -
>>> +/**
>>> + * typedef qemu_plugin_vcpu_syscall_ret_cb_t - vCPU syscall return callback
>>> + * function type
>>> + * @id: plugin id
>>> + * @vcpu_index: the executing vCPU
>>> + * @num: the syscall number
>>> + * @ret: the syscall return value
>>> + */
>>>    typedef void
>>>    (*qemu_plugin_vcpu_syscall_ret_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_idx,
>>>                                         int64_t num, int64_t ret);
>>>    +/**
>>> + * qemu_plugin_register_vcpu_syscall_cb() - register a syscall entry callback
>>> + * @id: plugin id
>>> + * @cb: callback of type qemu_plugin_vcpu_syscall_cb_t
>>> + *
>>> + * This registers a callback for every syscall executed by the guest. The @cb
>>> + * function is executed before a syscall is handled by the host.
>>> + */
>>>    QEMU_PLUGIN_API
>>> -void
>>> -qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
>>> -                                         qemu_plugin_vcpu_syscall_ret_cb_t cb);
>>> +void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
>>> +                                          qemu_plugin_vcpu_syscall_cb_t cb);
>>>    +/**
>>> + * qemu_plugin_register_vcpu_syscall_filter_cb() - register a syscall filter
>>> + * callback
>>> + * @id: plugin id
>>> + * @cb: callback of type qemu_plugin_vcpu_syscall_filter_cb_t
>>> + *
>>> + * This registers a callback for every syscall executed by the guest. The @cb
>>> + * function is executed before a syscall is handled by the host. If the
>>> + * callback returns true, the syscall is filtered and will not be executed by
>>> + * the host. The callback must then set the syscall return value via the
>>> + * corresponding pointer passed to it.
>>> + */
>>>    QEMU_PLUGIN_API
>>>    void
>>>    qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,
>>>                                                qemu_plugin_vcpu_syscall_filter_cb_t cb);
>>>    +/**
>>> + * qemu_plugin_register_vcpu_syscall_ret_cb() - register a syscall entry
>>> + * callback
>>> + * @id: plugin id
>>> + * @cb: callback of type qemu_plugin_vcpu_syscall_ret_cb_t
>>> + *
>>> + * This registers a callback for every syscall executed by the guest. The @cb
>>> + * function is executed upon return from the host syscall before execution is
>>> + * handed back to the guest.
>>> + */
>>> +QEMU_PLUGIN_API
>>> +void
>>> +qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
>>> +                                         qemu_plugin_vcpu_syscall_ret_cb_t cb);
>>>      /**
>>>     * qemu_plugin_insn_disas() - return disassembly string for instruction
>>> @@ -861,7 +933,6 @@ qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,
>>>     *
>>>     * Returns an allocated string containing the disassembly
>>>     */
>>> -
>>>    QEMU_PLUGIN_API
>>>    char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn);
>>>    @@ -888,6 +959,13 @@ QEMU_PLUGIN_API
>>>    void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
>>>                                   qemu_plugin_vcpu_simple_cb_t cb);
>>>    +/**
>>> + * qemu_plugin_register_flush_cb() - register code cache flush callback
>>> + * @id: plugin ID
>>> + * @cb: callback
>>> + *
>>> + * The @cb function is called every time the code cache is flushed.
>>> + */
>>
>> Thanks, I was thinking to document this since someone asked a question
>> on IRC a few weeks ago.
>>
>> May you add here:
>> "This callback can be used to free resources associated with existing
>> translated blocks in a plugin. @cb is guaranteed to run with all cpus
>> being stopped, thus no lock is required within it."
> 
> This does make me wonder what the use case for this callback is? In
> theory the state of the code cache should be an internal implementation
> detail that plugins shouldn't need to concern themselves with.
>

It can be useful for plugins who want a callback to cleanup resources 
they allocated for each tb (like a hashtable associating a pc to some 
data). At the moment, that's the only way to be notified that a TB won't 
be used anymore.
Even though it's an implementation detail when we do such an operation, 
it's one thing that is mandatory for plugins allocating a lot of data 
per tb, which quickly adds up.
In all cases, when a tb won't be used anymore will always be an 
implementation detail, since we need to do flush them in case we fill 
the jump cache for instance.

All that said, there is no usage of this callback in any existing 
plugins, and the documentation I asked to Florian was inspired by 
someone coming on IRC a few weeks ago with the question "How can I know 
when a tb won't be used anymore so I can free data associated?".

Regards,
Pierrick

