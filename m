Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD1F606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 05:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=dY4e5d5J
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ1yM-000672-0K; Tue, 20 Oct 2026 01:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xJ1yI-00066V-I6
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 01:01:10 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xJ1yE-0001Dt-UO
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 01:01:09 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3ac7a053626so576362a91.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792472465; x=1793077265; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EAaRc8Swd9yFZG0wYIL94sKXbXDTRScbWo9hSG6e9eQ=;
 b=dY4e5d5JMsvtDwK6yn+GHSg2EZN+9j3RZIwf5W5ADbABhRbQ8+OX6/AQ7qG3G6DJX4
 PzmNhSv3/e037xF10+Y5d/cGTJPGLzMKSmU5qzgJRzI0HiFkywXpw8WgkPnLvgsCn4gx
 8Kcajki2BJ+frLO06HZHt3GjDm1BAMmreCEiJdxHNBr5VLAyTC/5ObccCYCrWw2qcE0f
 RsYUwkPPp8BdJJRN3xB2DC9ADj0YQGEJZTOBfrrUtYnhi2fUTrgbX2KgEgxsgfbREbyC
 xUuEXpN2ISysaoa+HsYaRmKcLuKSrA4dIBpc+1QP1FpXZB5/FO7K1+lrTK1d+mMaRPZ/
 3ULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792472465; x=1793077265;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EAaRc8Swd9yFZG0wYIL94sKXbXDTRScbWo9hSG6e9eQ=;
 b=UB6NwBV10Tfw1n9ATFJ+TlH8JQ8ZeEENwMz6bMokJp+Z2hKbVxUUkIeycCHAQbM222
 k3w2tCWHOBdMXHJ0+D21UIagUP1EPTXzGI6Lc2IOGf4rvZgQ4X3x5jBSntxE/lM1KadG
 ay7VBkppJ4lNlJYODFxxtbYiuJpvgHl4yGlxtU5VSW0brnh+dDfpr148+g2Av8aRVFeC
 XJ6drWy2eG2X/LU+PjFHgSg5uPOkJXIdpIT++PcQY6JrPq0QHie2+arJS+MoXJifwzpv
 fosLkWUUkxSr39iHXEQg1quU6Bzstq/XjjaEuIGtHS906QEeVJyMbBkccYuaLMASkX3a
 5/ww==
X-Gm-Message-State: AFq9FYJuYUJ3zwDb8xGzN+Z96+UnH6BAPAedPi87vZPQAVkQwd4FXb3b
 +rMcuVhYuQKGktSqqAUV9eDNy6cccXfWqnofvv5XO0l4BgitPpqja0ZuaP/OEtCy4Cg=
X-Gm-Gg: AYBFou26XzB1KySZ8OtwgyRkui7z7aYmL27nfRKOzVJcCDORp/Ayg7YvdkgobI2P0Eq
 7rhbveE7uqPclb0preRT0KSRcBi6ZdsjkjFIM95t9ghpbf6B46rfyR1w4BhtJTdWzI5f28gOSqN
 k4tEgSbbU2bBV5Fc9QiMUGjI5rZ1agSBIC2Sv8MRC+x4VCb4sXiAoBoknjfp65BVzvvlhl1sj5u
 ZLeArItso2bZnXzkTNsZqiGIwWY5tl1XLNwaPCodKbPLWTHGTk4USkrypc+gq0DRTPKOsINaFUT
 8B2Qu093yjNivSK4mSDuzm42X9agNPsF3duB3nMrpkfHCwdH4uyNAPClc9k0leZhDv0rM+e79t/
 JTG5iwrK6rroSgf3g6mOrVI8DypUhSWOebJvo1gz7X93jbar29rYh7w33ClSWAUsIlzLdALBPMb
 SjhRyBRjNckADsPukUS89MHKhhwvx4TGU8Q9Pg/S+5ASFKRFwzcdLKhUxHsLtbydCsyxyrdaOZp
 /4MbJ8HeShqhvszY4NfYx+xvAvhn3Lcv3XQ
X-Received: by 2002:a17:90b:39a4:b0:3a8:736e:c19b with SMTP id
 98e67ed59e1d1-3acef4e05e6mr13912591a91.4.1792472464858; 
 Mon, 19 Oct 2026 22:01:04 -0700 (PDT)
Received: from [172.16.1.33] ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad5d6df937sm2257387a91.12.2026.10.19.22.00.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 22:01:04 -0700 (PDT)
Message-ID: <1cb7fae6-79c4-4d5b-88c2-968727defbf4@oss.tenstorrent.com>
Date: Tue, 20 Oct 2026 15:00:57 +1000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] machine: Support extra board CPUs outside -smp
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Michael Ellerman <mpe@kernel.org>
References: <20261015031804.2406055-1-portias@oss.tenstorrent.com>
 <20261015031804.2406055-8-portias@oss.tenstorrent.com>
 <b87a7231-ca35-4c1d-bc05-ffeee15eebf0@oss.qualcomm.com>
 <atH7u-UCZ3dbA-ui@redhat.com>
 <763f740c-559c-4f99-a237-daf1e88d4e07@oss.qualcomm.com>
Content-Language: en-US
From: Portia Stephens <portias@oss.tenstorrent.com>
In-Reply-To: <763f740c-559c-4f99-a237-daf1e88d4e07@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=portias@tenstorrent.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 16/10/2026 9:23 PM, Daniel Henrique Barboza wrote:
>
>
> On 10/16/2026 7:26 AM, Daniel P. Berrangé wrote:
>> On Thu, Oct 15, 2026 at 05:31:33PM -0300, Daniel Henrique Barboza wrote:
>>> Phil, Pierrick,
>>>
>>> This patch seems to dwell around your turf.  Did you think about how to
>>> instantiate different CPUs that might have different SMP topologies in
>>> the context of single binary/split accel work?
>>
>> IMHO the -smp argument as it exists today is essentially unfixable
>> for the general case and will ultimately need to be declared legacy
>> / for simplistic usage only. Trying to paper over the limitations of
>> -smp with special cases like "extra cpus" is unlikely to deliver
>> attractive solutions long term.
>>
>> The eventual emulation of heterogeneous CPUS in the single binary
>> work will bring this to a head, but it already causes problems
>> today with our per-target binaries because even individual the real
>> world CPUs we want to be able to model are not symmetric.
>>
>> As a historical reference, a while back, Zhao had an RFC that proposed
>> we use '-device' to define each topology level discretely, which would
>> allow for arbitrary asymmetric topologies:
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2024-09/msg03727.html
>
> This RFC looks solid.  Any reason why we didn't go through with it 
> back then?
> The conversation just fizzled out quietly from what I'm reading in the 
> archives ...
>
> I am not sure about the schedule/planning around the heterogeneous CPU 
> work
> but if this RFC is aligned with that effort it would be great if we 
> could push
> that forward.   Enabling multiple CPUs of the same architecture/target 
> into
> a single board seems like a step into that direction.
>
> We have the tt-atlantis RISC-V board that has a use case for 
> additional CPUs outside
> of the main smp topology, i.e. we can use the board as a 
> testcase/validation for
> the RFC.
>

Thanks for pointing to the RFC. It does look like it would give the user 
control to specify hart count for just the Ascalon cluster, the problem 
this patch is trying to solve. tt-atlantis will be less configurable 
than what the RFC proposes. For example, it won't support running 
without the Ascalon cluster enabled. It only supports specifying the 
number of harts on the Ascalon cluster and enabling/disabling the single 
RCPU hart.


I am going to send a v2 of this series that lumps the smp CPU count of 
the RCPU and Ascalon together removing the need for this patch, this is 
what the Xilinx machines currently do with their A- and R- cores. Then I 
can take a look at reviving the RFC and using the topology on Atlantis. 
I worry that the Atlantis machine isn't configurable enough to justify 
the new topology. I will take a stab at it and see if it makes sense.



>
> Cheers,
> Daniel
>
>
>>
>>
>> With regards,
>> Daniel
>

