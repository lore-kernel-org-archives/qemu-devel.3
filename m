Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3276C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rprdt-0006kl-Fw; Thu, 28 Mar 2024 11:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rprdq-0006kP-JJ
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:26:11 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rprdo-0004x4-Qi
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:26:10 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56bb22ff7baso1246783a12.3
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711639566; x=1712244366; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gadnSdjUqiFWINeZh+jMWLraeqv1KtFwsnhF4+PRa5k=;
 b=sVMoUrBgNSwp75m0RQ/LHC5uyNNf8is3KPQ8WBX0yNomO9BWVkOZdM+EQ4MRFN4+t9
 x02479a3t7vSrKjRaYMDqcSA1XPgB7KBFlSryzIVPTliu9/TTLcac4G+WlDo0aTdYSMa
 n5VmamEuQyfRnfsCoKy1PQ/Ax4MYDvRRnYV998yg8msN3//P0b0QxL5rGiopIRJoa3mX
 pqaHOzv7AGY6ZpNwHd+slFwF5ac/xSpyal4NlzkENF0U3bBelcYNYrqDKXa31BitALns
 33q06ZuEu4FUp/Rau8XWv+iUkyAAJhQgRyelid/tEwGqDxOTeKtcedwODgXHAgrS0Nto
 XGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711639566; x=1712244366;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gadnSdjUqiFWINeZh+jMWLraeqv1KtFwsnhF4+PRa5k=;
 b=RfqHvf9uOtcxp9KAX3gg9BMtxqbA1HWXP4qYlI8O2ZuEKJuTDJc3zbiydHopQDyO6e
 1Q97BpXqg7dTgJn5jB3xO8YzLk/nE03TBXwdVnPfr/3C6QSu3XvzcOL+W3f9PH09dAVt
 qHKBzqG8WkeNSMLomuOrWr6q5/XZEHfpfSHyyY3wUehXkgKN3FfrKIO5OJy66jU6f68v
 aYdogXIis9rYsvalRyV5xnTSrMgOlqeguuvldrIapQL4kwRiW2Xmr/pp2WmqwsIUTjBd
 5T3WYfWrHCmWW/30c+ISq2tMUhx/kuZgRVI2Ew4pbspmtupa+ZoI9HqCPnGhc+Lx/NCA
 IMPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfdBiU/qS2eNP7DP5cUbdKb/FlaZ/2jyYgbltCXTmCxL6rBcnXMnito0UXeOfSgqS3IlfKaW0otFuU5o0GdwYRXWrYLSQ=
X-Gm-Message-State: AOJu0Yw+2BbZF/XpQsRuUkpz+tuiWcTzB9fy+9auGoV5KkIn2m90fT+6
 Ij4ej+IwiT9Q179QN7OOn26edlGdgsMB3sBdfJKle19bZPnhkyhSPCMnB4JMl/BiCVMwJe0ujq9
 y9eO0Gz1KUr1VdwxrnxHLSFYjT4ILleVxIsiYLg==
X-Google-Smtp-Source: AGHT+IGYgr2Avk+/FBnkdPpt0sdW2PLcsiHHI/bJl+jFbAL5v4oLcp3M4oVGmqep/qy/604YJ55D0XGqkyrrGUT9Qtc=
X-Received: by 2002:a50:cc8a:0:b0:56b:9b23:40bc with SMTP id
 q10-20020a50cc8a000000b0056b9b2340bcmr2212891edi.15.1711639566508; Thu, 28
 Mar 2024 08:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240312165851.2240242-1-npiggin@gmail.com>
 <20240312165851.2240242-36-npiggin@gmail.com>
 <CAFEAcA9dLHYvY7-zCntKFZGr1VJUW6b3y5UqFAq-XN8zgVe2WQ@mail.gmail.com>
 <1bc2bb17-23a5-4b36-a11b-bc7384a54a1d@linux.ibm.com>
In-Reply-To: <1bc2bb17-23a5-4b36-a11b-bc7384a54a1d@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Mar 2024 15:25:55 +0000
Message-ID: <CAFEAcA9BxWD66dCRJCbmf-YN-PzLMo0Hx12vZDWWsUZmbhYnxQ@mail.gmail.com>
Subject: Re: [PULL 35/38] spapr: nested: Introduce H_GUEST_[GET|SET]_STATE
 hcalls.
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Neuling <mikey@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Wed, 27 Mar 2024 at 05:41, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>
>
>
> On 3/26/24 21:32, Peter Maydell wrote:
> > On Tue, 12 Mar 2024 at 17:11, Nicholas Piggin <npiggin@gmail.com> wrote:
> >>
> >> From: Harsh Prateek Bora <harshpb@linux.ibm.com>
> >>
> >> Introduce the nested PAPR hcalls:
> >>      - H_GUEST_GET_STATE which is used to get state of a nested guest or
> >>        a guest VCPU. The value field for each element in the request is
> >>        destination to be updated to reflect current state on success.
> >>      - H_GUEST_SET_STATE which is used to modify the state of a guest or
> >>        a guest VCPU. On success, guest (or its VCPU) state shall be
> >>        updated as per the value field for the requested element(s).
> >>
> >> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> >> Signed-off-by: Michael Neuling <mikey@neuling.org>
> >> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >
> > Hi; Coverity points out a problem with this code (CID 1540008, 1540009):
> >
> >
> >
> >> +static target_ulong h_guest_getset_state(PowerPCCPU *cpu,
> >> +                                         SpaprMachineState *spapr,
> >> +                                         target_ulong *args,
> >> +                                         bool set)
> >> +{
> >> +    target_ulong flags = args[0];
> >> +    target_ulong lpid = args[1];
> >> +    target_ulong vcpuid = args[2];
> >> +    target_ulong buf = args[3];
> >> +    target_ulong buflen = args[4];
> >> +    struct guest_state_request gsr;
> >> +    SpaprMachineStateNestedGuest *guest;
> >> +
> >> +    guest = spapr_get_nested_guest(spapr, lpid);
> >> +    if (!guest) {
> >> +        return H_P2;
> >> +    }
> >> +    gsr.buf = buf;
> >> +    assert(buflen <= GSB_MAX_BUF_SIZE);
> >> +    gsr.len = buflen;
> >> +    gsr.flags = 0;
> >> +    if (flags & H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
> >
> > flags is a target_ulong, which means it might only be 32 bits.
> > But H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE has a bit set in the
> > upper 32 bits only. So Coverity complains about this condition
> > being always-zero and the body of the if being dead code.
> >
> > What was the intention here?
>
> Hi Peter,
> Ideally this is intended to be running on a ppc64 where target_ulong
> should be uint64_t. I guess same holds true for existing nested-hv code
> as well.

Sorry, I'm afraid I misread the Coverity report here;
sorry for the confusion. The 32-vs-64 bits question is a red
herring.

What Coverity is actually pointing out is in this next bit:

> >> +        gsr.flags |= GUEST_STATE_REQUEST_GUEST_WIDE;
> >> +    }
> >> +    if (flags & !H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {

The C operator ! is the logical-NOT operator; since
H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE is a non-zero value
that means that !H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE is 0;
so we're testing (flags & 0), which is always false, and this
is the if() body which is dead-code as a result.

Should this be the bitwise-NOT ~  (ie "if any flag other
than this one is set"), or should this be an else clause
to the previous if() (ie "if this flag is not set") ?

> >> +        return H_PARAMETER; /* flag not supported yet */
> >> +    }
> >> +
> >> +    if (set) {
> >> +        gsr.flags |= GUEST_STATE_REQUEST_SET;
> >> +    }
> >> +    return map_and_getset_state(cpu, guest, vcpuid, &gsr);
> >> +}
> >

thanks
-- PMM

