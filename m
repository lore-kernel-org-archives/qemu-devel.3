Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54142C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 16:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp9GI-0005P5-RM; Tue, 26 Mar 2024 12:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rp9G6-0005AS-2h
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 12:02:46 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rp9G3-0005Im-4g
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 12:02:41 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56bf8093dddso1139227a12.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711468956; x=1712073756; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YK43hgjiaGWqspEZFIT8PnwRPXbUGsP2JdXcwjx9h38=;
 b=J39Ktq3mALgac2crmnSgPLXf1CV0lSwiH1aMnHF/Ow/LxA8LB3B1g/F65zZLMT8M3l
 0/wyG8G6ys9Pofdgj8juhHiCo44D4gkNRxw1qZk5ZrS+jqlRa7O7hMLBTNfTjbWyuUTN
 OuFgAhCLbevq/G8YR4LiCq8IB46TpNAG0x0b86RWStVE+vKXy/ZW924bUY1b5CV/3Dn3
 9KxWwX/6XCRCYI9Yd2U9ypsAP2uvZQSg1M/vXBK0f9EPMXPyYsgRQucdAl/NHfzrAfZC
 fxVeZxIpPAuYNCsMWmQdjlQBmTKQgXIQzZwTDgJWmUf1qGnF3DAKMsV7F8r2uk3VvWT9
 4ANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711468956; x=1712073756;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YK43hgjiaGWqspEZFIT8PnwRPXbUGsP2JdXcwjx9h38=;
 b=TOYYbbA/G1nVlGkKLIz6Dd8CGVpYRPHAUUDV3KhklI9sDJVZmO46JxfyrfeXC/eTXr
 27KxRWu/x8tA4aiAPLAAM6bsNoa1MrdMthGen0nPGewI1wOIwiX5UYXlebcpfUD0/hPM
 BfiVLEQuvHkdfHy07ykJzQuXyuG9rDyz7o24kN59yz4dG3BP+ke41de6EhpYN6Mm+avK
 AW0NbGD1LrUR/xPL03N7OvmEDpRfcwopsxlkOrWITvi1wksfm+DnjuLpFCIVDc8FWT/P
 TGYIcdf8EeC7cxphDsAOiNGKodBYvbn1lHvrKemYOz+1ekAly+8TyicUWzS3AFFMvP3O
 sdlQ==
X-Gm-Message-State: AOJu0Yx+rRnrOxkQovcyTuinuSj0XD2c0VYEKyrLJgFaNhLFZfOz1/yx
 RFy8oqyRwiQ6S2jgXEW16ZXUIo1Fn2mZY9ym4DBfSFMUEVGr6ObxtnX2dGp5Ed1gFOurrLmCPEC
 9B3hETflCTS6Qf4kDcoNZh0/aD77Bq8CR73Mzsw==
X-Google-Smtp-Source: AGHT+IGW3M0qyG3TTTJ6344s8KCcVArZxh0YinHmQgPbxuu5dv1LUsAcOGcBHXVCvgngh05pGqWp6cscBL/6Us3obzA=
X-Received: by 2002:a50:d7da:0:b0:56c:18b4:d2ab with SMTP id
 m26-20020a50d7da000000b0056c18b4d2abmr207942edj.42.1711468956018; Tue, 26 Mar
 2024 09:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240312165851.2240242-1-npiggin@gmail.com>
 <20240312165851.2240242-36-npiggin@gmail.com>
In-Reply-To: <20240312165851.2240242-36-npiggin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Mar 2024 16:02:24 +0000
Message-ID: <CAFEAcA9dLHYvY7-zCntKFZGr1VJUW6b3y5UqFAq-XN8zgVe2WQ@mail.gmail.com>
Subject: Re: [PULL 35/38] spapr: nested: Introduce H_GUEST_[GET|SET]_STATE
 hcalls.
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Michael Neuling <mikey@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, 12 Mar 2024 at 17:11, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> From: Harsh Prateek Bora <harshpb@linux.ibm.com>
>
> Introduce the nested PAPR hcalls:
>     - H_GUEST_GET_STATE which is used to get state of a nested guest or
>       a guest VCPU. The value field for each element in the request is
>       destination to be updated to reflect current state on success.
>     - H_GUEST_SET_STATE which is used to modify the state of a guest or
>       a guest VCPU. On success, guest (or its VCPU) state shall be
>       updated as per the value field for the requested element(s).
>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Hi; Coverity points out a problem with this code (CID 1540008, 1540009):



> +static target_ulong h_guest_getset_state(PowerPCCPU *cpu,
> +                                         SpaprMachineState *spapr,
> +                                         target_ulong *args,
> +                                         bool set)
> +{
> +    target_ulong flags = args[0];
> +    target_ulong lpid = args[1];
> +    target_ulong vcpuid = args[2];
> +    target_ulong buf = args[3];
> +    target_ulong buflen = args[4];
> +    struct guest_state_request gsr;
> +    SpaprMachineStateNestedGuest *guest;
> +
> +    guest = spapr_get_nested_guest(spapr, lpid);
> +    if (!guest) {
> +        return H_P2;
> +    }
> +    gsr.buf = buf;
> +    assert(buflen <= GSB_MAX_BUF_SIZE);
> +    gsr.len = buflen;
> +    gsr.flags = 0;
> +    if (flags & H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {

flags is a target_ulong, which means it might only be 32 bits.
But H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE has a bit set in the
upper 32 bits only. So Coverity complains about this condition
being always-zero and the body of the if being dead code.

What was the intention here?

> +        gsr.flags |= GUEST_STATE_REQUEST_GUEST_WIDE;
> +    }
> +    if (flags & !H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
> +        return H_PARAMETER; /* flag not supported yet */
> +    }
> +
> +    if (set) {
> +        gsr.flags |= GUEST_STATE_REQUEST_SET;
> +    }
> +    return map_and_getset_state(cpu, guest, vcpuid, &gsr);
> +}

thanks
-- PMM

