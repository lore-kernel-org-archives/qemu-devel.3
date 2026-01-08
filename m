Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D31D148B7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 07:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdkT7-0007rz-Rf; Thu, 08 Jan 2026 02:30:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdkT6-0007rK-WF
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:30:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdkT4-0002C5-Re
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:30:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767857401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Agey1CWu6Vr4IPNJHPZ2rf6MocWiVfJAH1sxTQgTScU=;
 b=OuRp6Fa9WOlmWQP2UroJLCRqBvIqZY8miuzqoYrNnlwW77E44XNpN+NkeH5I7a/Ni3hn7L
 j6T7CugwXRjX2GPqLSu258ZKqxCQznb4ErCU8q98VekbP1gQu749bV0umW+fPMUkoayZBy
 /S9/BTDJf7hb6SGylZrZ6wl8KJpqHU4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-Y5w2iUBvNKe3l4lpxiBdzw-1; Thu, 08 Jan 2026 02:29:59 -0500
X-MC-Unique: Y5w2iUBvNKe3l4lpxiBdzw-1
X-Mimecast-MFC-AGG-ID: Y5w2iUBvNKe3l4lpxiBdzw_1767857398
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-432488a0ce8so2095817f8f.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 23:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767857398; x=1768462198; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Agey1CWu6Vr4IPNJHPZ2rf6MocWiVfJAH1sxTQgTScU=;
 b=p+b5ZsoFTbxq/x7PuPVi2Sup/ChtDc9/ZkdleStqEErHYXwEqX3Jx6w/L0zMGYlLgG
 20RY2c3/EEBE0FOc1iP0sbN5PiHtqlF3XkON7XOu6GPHqc0H8xJ83hv6DZy8r2gjjpFz
 fw1lRs3AA+nWXLltPmQuIJDoh6jAoCEEa7jgn1qzl/Ys7bqc4rQkxaNtBKQu/SgRgID6
 k3ze1gzJzl07l99elAMhRwjgepx6p1HbLqC9H/p8S/pDqL2h/WGXByDEhg+jxVLO9slZ
 mx0pbBeZ0iiZHg/sbWKeHjzMG5TpKzp7wHet1Q8uU1hMhJ9NNthrRKGEdl5ox7bVKkCs
 YnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767857398; x=1768462198;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Agey1CWu6Vr4IPNJHPZ2rf6MocWiVfJAH1sxTQgTScU=;
 b=BkM1PEsoC8hWgWxFBse30/MwiwzMmjEkvBWClBtAyhBWg20pBXEZbEcmwXOuL8rSHP
 LOCRgC6ed7paS3ByzsVSg52WWbPo1q4MCXFW6zkU7eaBo8Y4Vo4EY+zT6SzPkqAtpc3D
 7GUWHqqwcQc7KvxlcrJ+Z753PbY0y6dYtc2DM+ds3oOr2y8b85tJ5LDqoen0IAobxHO5
 UiJoDExZbcaKXX2yCvi7s/x8k3ttzt+/KhdU1SlHK8loBu142ftQxhCHPyosUbVdB1w7
 4riiybplntP6xf4CnsZynTHjMz6eITjEyP0OVZCXsrsF0jqOy9lSDBsYoWQCTgiVxcRO
 xnKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFB/enPUOWhXibUA1gaNGhbhABJWHFnCrJJCKSWSg6o80Tw425MNCniNKgcDJMrA51i0KEeOm4s9ze@nongnu.org
X-Gm-Message-State: AOJu0YwLvYexKg3675+NHOoBBgjstsYkZT5PTYbKyhu76a8zANsWG0d6
 s7g5vTJMi2tJMSj0EdhTvXcSWAfdiJ2h85/CQ/fznQ6g7ZuC9ag7UmpzfiLe0B0GeK11Nxd1445
 Xk3E0+u5m0E4Z+pszjlO/jXcRASHp0+m9MODaPaA7qR7gnKMavC/SZRRR
X-Gm-Gg: AY/fxX7B1XOufoU4pEaW6K9JpXbStzWKTdhomUio0kAmiotpOpuSf/nBj5abTQwEwyC
 /oXBGvjUAAFPIi/nc37oB4fnZfiglxuVV54o7cLhJxyTCENnMlP43gFbi9uhB3TR4PWZ3ar3U8T
 sNWQl/XCP16FBJlE50BaCRoujukgn0cR9LHsRe6bgPvvmqpmS32MxQxT6jBTlnjFC8Bs+aY9kXR
 yVaOgupkJ+Swg+J6merg/VwqOVZ1pS4kR7QpXm6wZDNNxz17ktNCsNB4kr4fVcJ9XjKzZDSyjUC
 +wvEoc/eN1Yx6szInGCxaVkF+B1+9E8iH2bfXWH71esrar8YrBEgodJvQpddMznzevHPYnBJfPx
 2fzBVEzU=
X-Received: by 2002:a5d:6446:0:b0:432:7d2a:2be4 with SMTP id
 ffacd0b85a97d-432c38d2328mr5172726f8f.60.1767857398290; 
 Wed, 07 Jan 2026 23:29:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUD7zgxcSGf3zK4jF0i1g3m63ux5ttr6jVqPq/YEmnJDutKRFjq7jQySkmVRv+n1oymAzIKA==
X-Received: by 2002:a5d:6446:0:b0:432:7d2a:2be4 with SMTP id
 ffacd0b85a97d-432c38d2328mr5172699f8f.60.1767857397932; 
 Wed, 07 Jan 2026 23:29:57 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e17aasm14960943f8f.15.2026.01.07.23.29.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 23:29:57 -0800 (PST)
Message-ID: <1651ae1f-ed3c-4288-a856-07a5e7815810@redhat.com>
Date: Thu, 8 Jan 2026 08:29:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] target/s390x: Use vaddr for $pc in get_next_pc()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>
References: <20260107130807.69870-1-philmd@linaro.org>
 <20260107130807.69870-4-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260107130807.69870-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 07/01/2026 14.07, Philippe Mathieu-Daudé wrote:
> DisasContextBase::pc_next is of vaddr type.
> Since translator_lduw_end() returns a uint16_t,
> also use that type for clarity.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/tcg/translate.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
> index e38607ee18c..540c5a569c0 100644
> --- a/target/s390x/tcg/translate.c
> +++ b/target/s390x/tcg/translate.c
> @@ -6405,10 +6405,9 @@ static void s390x_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
>       tcg_gen_insn_start(dc->base.pc_next, dc->cc_op, 0);
>   }
>   
> -static target_ulong get_next_pc(CPUS390XState *env, DisasContext *s,
> -                                uint64_t pc)
> +static vaddr get_next_pc(CPUS390XState *env, DisasContext *s, vaddr pc)
>   {
> -    uint64_t insn = translator_lduw_end(env, &s->base, pc, MO_BE);
> +    uint16_t insn = translator_lduw_end(env, &s->base, pc, MO_BE);
>   
>       return pc + get_ilen((insn >> 8) & 0xff);
>   }

Reviewed-by: Thomas Huth <thuth@redhat.com>


