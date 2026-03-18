Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A625CFCD0C1
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 06:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2kc7-0007Cz-Qp; Wed, 18 Mar 2026 02:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2kc2-0007B4-BJ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 02:42:38 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2kc0-0005XZ-5o
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 02:42:38 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43b45bb7548so266084f8f.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 23:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773816154; x=1774420954; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sOwXNX63OVg1KRKqmr0UFjgn+eyovuUAv6hy60d5c3U=;
 b=l4UqqqeJ6WRJg3bCc5sgetXc+ss7p+nukZI8Ngzxc3airdxbOvCKaPr9gCqrOeu7ui
 sHxixhyBdnkcO+gvVQnXmrEezK3VPMMldWDdB0XKePnscxVYEWZZw9d7avwNYgO9IkyO
 XtdmSgsDDx75LL+P4YPeyQ9Pg29sYSydXU0QXn/bo+p4SWxGxLGg4vS9IPkqEaGUyIxs
 pou1Mh3J5Ws53k9y4z8Hw7Z97X0rSoQaSXBtCm11YP76b44fS184WQ/uvr3DWTUf/h8Z
 DJX/hifhn0x8YjlDQXPl446J8RWIPDognuVARNbO+xtphI64g2Rz1mRPZ8+G5rjd5EN1
 Ve+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773816154; x=1774420954;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sOwXNX63OVg1KRKqmr0UFjgn+eyovuUAv6hy60d5c3U=;
 b=PXzGrIGyqbVuskqcEvk63QkxXyXbQfWE9GCPjdj43U9mfjNgeo7NIa7DbzPRdZks9n
 HZfbarRaj9QGsitNo/3PyxST/PxhkIfRjw3L1ucRc8nEa69DObJQmv9/q98SnVi2rFTM
 dK2bbs1mdzANsqSC5IP6fRIeffmWzmwE2rdR642fkbO4LnQRI9rY7oV4K7Ml3U/1qT4e
 RLM0AbNPV9FbKpzLHLkMf2Vw+l/LBgihsU7vXeh/PBUhIBaAeya3frM2QvE4jUFsfSTv
 nkBfe68Rbk5S9cbRQLymVilp9ljsQ+qPqEB9hlUZaRgJy/ZzxRBpw0MwntDgPdQN/V1K
 f9Aw==
X-Gm-Message-State: AOJu0YxX9YRx71f7D7gGiZDITnG3vMd0T9eC7ETFpU57HLwE5D3C6/zD
 LGm3Bl6yljAlSNAQ7KbDjmE/ZomuMP612+8N6t9ALXM9XvdklZudemCMlpEBeap/Xk8=
X-Gm-Gg: ATEYQzzrEQleF9guW64sUxcehwZMI/LvKdJkd9GATKKExHUBG2S6B37R0BR1shRWCJP
 Jul90IUnsS3VTVX0ysnk457vAwGs/RD9r4ii2aTYX5c9WEb1xmToQcU9yZmWo2UPCSZWDMekZAW
 XY+DnIvDuDxiS5sXVaki8AWZV7HmZckSmpJEk54bbIpwHiFCqkMJoR12obQYxk7wawtZJW0s/K+
 s3PwfioOfCcDKDAylqhy3rFfDYeZQGOd4QMaF96s7SCj/xFI8jXJXBKU1MGu6CKNq94mPaZZLcC
 5dg5wLzqAeZnu7fpq0+fhQnCSJoagJifRekfNB0t8YSD9B4vdt9Hjp67dbPVd6PQuGYtRKosKGp
 1K4DD/Z3ofttc/d/PtQ/nT6kJF3XWrSjlvQgp4u6+twC+1d/BEefi+sgBEeqYOS/Iw7+pBEAKsm
 RLOdigTZD+EatMffu42QkVHTeaB2SocmUTFF4uyJz+JwuskCVUiOLN5IIbwZ1Qk1HM6A==
X-Received: by 2002:a05:6000:420f:b0:439:b59e:5e6a with SMTP id
 ffacd0b85a97d-43b527a5920mr3182680f8f.14.1773816154019; 
 Tue, 17 Mar 2026 23:42:34 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51892234sm5183442f8f.24.2026.03.17.23.42.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 23:42:32 -0700 (PDT)
Message-ID: <08c5f243-5aaa-4fe2-bc71-6a3fd9a1914e@linaro.org>
Date: Wed, 18 Mar 2026 07:42:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] exec: Add RISC-V WorldGuard WID field to MemTxAttrs
Content-Language: en-US
To: Jim Shu <jim.shu@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, =?UTF-8?Q?Cl=C3=A9ment_Chigot?=
 <chigot@adacore.com>, Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20260209115846.2276651-1-jim.shu@sifive.com>
 <7be3b4f7-7516-40ab-8a95-b3b4a2aea095@linaro.org>
 <CALw707rbMvg1mf1S_3qiqDWbZ0qjzgx4UJ9pUGmQODKWttKFyQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CALw707rbMvg1mf1S_3qiqDWbZ0qjzgx4UJ9pUGmQODKWttKFyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 18/3/26 05:40, Jim Shu wrote:
> On Tue, Feb 10, 2026 at 8:25 AM Richard Henderson
> <richard.henderson@linaro.org> wrote:
> ...
>> Hmm.  This really overlaps the secure and space fields from arm, and possibly some of the
>> others as well (e.g. user, requester_id, pid).
>>
>> I don't really have a good suggestion for that right now, but it would be nice to not keep
>> expanding the count of these sorts of fields that somehow specify the originator, but
>> clearly cannot overlap.
>>
>> I'm reasonably sure we've had this discussion before, but nothing has come of it.
>>
>> Time to paint the bikeshed again?

Last discussion IIRC:
https://lore.kernel.org/qemu-devel/CAFEAcA8vKNkfKgp_Yymo9NA1=E2XJYXAMTgO3z6q6DHgqkAwRw@mail.gmail.com/

(see also a suggestion in 
https://lore.kernel.org/qemu-devel/Z4+P3eHXqcU4Dqdx@intel.com/)

>>
> 
> I can union the 'secure' and 'world_id' fields, as they are not used together.
> However, I have no idea about the 'space' fields.
> 
> I have seen CPUTLBEntryFull has the extra union to support ARM-specific members.
> Another idea is that also adding the extra union to MemTxAttrs to
> place the RISC-V worid_id.
> We can use this extra union to as SoC-specific signals in the bus,
> like AXI AxUSER signal.
> Do you think it is suitable?
> 
> 
> Thanks,
> 
> Jim


