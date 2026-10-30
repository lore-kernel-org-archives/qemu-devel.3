Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDDA606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KEzijzT0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmyZ-00012W-7W; Fri, 30 Oct 2026 09:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmyQ-00011j-1y
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:48:53 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmyM-0008RU-MJ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:48:48 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-53a448f86e0so464633b6e.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793368124; x=1793972924; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TIXuFF5aqP4NX5yvgitKrjCHzBFZAN1f4lmeb37ZkR0=;
 b=KEzijzT0yT+GUYGm366dMKxkmdQKocfkv8fPPn9ORuMAMhIJPKb4yjyIS169VqxKgs
 uhEKrqOKkWSGc/7vMXDSnydrF8C/gUgJZL11RqNo37uf2yulNZEdZ6R21G+HI8PbwiZe
 NoD+knVvHviuPjrwNM0VC5kQCcR1X5LhKiVioPE0/XmQetTCtg6mpj0POt2xz2AjcIpw
 XVD6PvsAQzvweigqioZ1rNgd8n1fj1SoO8TdBcw03Vck/p7+mX0xPvYOxmIf+cg5kDfQ
 5C71Mv8OnDMSywo7YdLT+q8PE4AaBT+6mEmcAGZGXoPFgtWUR9HzpL5Yni2PwIgylfNW
 pKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793368124; x=1793972924;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TIXuFF5aqP4NX5yvgitKrjCHzBFZAN1f4lmeb37ZkR0=;
 b=c+xbW2kZwQkvQANapS7ocB6g/1a6gSlFCh8IM5JUlxHCh2Lc+dKFE72PqGRz96jGS9
 aScKqdy8bNVwuTrGqkxLL+sy3q9UazcNpENUBHfvRNB4AmBoCvmPsxQPo/ScAOOfXjLt
 iDnsnnCtCszHzMBFIIqWpokdU4yPGZH75lsm5vwvkE4VMDwEpkkKa4aMP/IR8DYc0Gi7
 Uypjg10FyQrml9fIo0snWBq96dEljM3gb6lV2e786o4EtiGTCuDEgFonlHksakAh1Y8v
 jApTLvadEz8DUt3a958hP49J2JTNcgRRUwQfjj9kkK1U3Co9qnzm/pXjH6Q8TTEANstQ
 qBjQ==
X-Gm-Message-State: AFq9FYJEDDop97/E8JX08zAMYoDuMaf5Tj7z+SpZ6F6FiU9eQi8Rt/Yg
 QnIWyPExxjvo7xBiQ4UDJA6LlkGDfEoYw0MQHy/IWB9cDr38ybd0kvhMZRJ0HbZm6JQ=
X-Gm-Gg: AYBFou1LslcvDsigELxQUbymJ3q363LqVE3u4FNZzSHUYMYingT4Tj/IQgsLxZVYvs1
 pDWKBe57WrKeup/kpVNZmYIRYMAby+M6bn7lhqUJLNT9SDd3UKXfGUimTlsctlWQ76IMaqcDrk9
 6cntugK9qc8VcILZaxv2Dxv+nN9Ro68wZ3xj8NkbWxsRKZwx+wpi9V8FUJ9/oEblkxDQdiIeU+8
 SDXO521iMqScrHRsyJhjrw2kuytObZrhhTjkys/Km9la4DjaxMOsfZAFJAXmXBXXaYDdjVq/i1a
 CQ/V9Ytn0tvVxv9nwPTwlujk1DqWELUEjmHtaSBbKOHOqOd55KapEyGmTa+K1XjpIArMk3ZqZta
 usBghpH8sTWpe9UHE5rd1PymXBirCVMaovq4F2FqcEG6C5oYRhj++aUEncHFjIEIQoTR2khH/74
 2UAG9cepR02eqi6TVPUmvUTzXhiUKxGmSc5a2NCOO9x1ZyGAqFxbqMnQX3VkyHlTjzGr7CCaP62
 XEQy4Mh9vRajYqzz7v0AFNJhbG7l+m3XTXU5fMqr3IVDHWx2SGBrF1dvR2dP/NdLBp4pOIY6wGr
 1SHx/8yN4FGJXfQ16NU51B2eb647O9c/HvYLGQEv2befH1wPbIDZgogfTTLTnJJ+Bw==
X-Received: by 2002:a05:6808:124d:b0:4e9:3412:14ac with SMTP id
 5614622812f47-5640de4b73cmr1555150b6e.33.1793368124362; 
 Fri, 30 Oct 2026 06:48:44 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-5640fe423fasm1610958b6e.16.2026.10.30.06.48.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 06:48:43 -0700 (PDT)
Message-ID: <38a9e837-0313-428b-87b9-35dec3317968@linaro.org>
Date: Fri, 30 Oct 2026 08:48:42 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/i386: terminate a tcg block on gen_RDMSR
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20261029171737.2126803-1-alex.bennee@linaro.org>
 <451d1cfb-a94e-40c1-bb10-a768c5701f9b@linaro.org>
 <87fqxn8i2p.fsf@draig.linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <87fqxn8i2p.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 07:54, Alex Bennée wrote:
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 10/29/26 12:17, Alex Bennée wrote:
>>> End the block the same way that gen_WRMSR does so an IO access under
>>> icount. While this fixes this particular case I suspect there are more
>>> IO like accesses the x86 TCG front-end should take care off.
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4779
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>    target/i386/tcg/emit.c.inc | 1 +
>>>    1 file changed, 1 insertion(+)
>>> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
>>> index ed56edf8a3a..911bce5f539 100644
>>> --- a/target/i386/tcg/emit.c.inc
>>> +++ b/target/i386/tcg/emit.c.inc
>>> @@ -3783,6 +3783,7 @@ static void gen_RDMSR(DisasContext *s, X86DecodedInsn *decode)
>>>        gen_update_cc_op(s);
>>>        gen_update_eip_cur(s);
>>>        gen_helper_rdmsr(tcg_env);
>>> +    s->base.is_jmp = DISAS_EOB_NEXT;
>>>    }
>>>    #else
>>>    #define gen_RDMSR gen_unreachable
>>
>> You've done nothing to update state.  I think you want
>>
>>      translator_io_start(&s->base);
>>
>> which will go though DISAS_TOO_MANY.
> 
> Should WRMSR do the same? If not why is it different?
Oops, mis-read that.  Just above is updating.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

