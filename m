Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5187606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=e6Kb2ndZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJAzK-00012o-UR; Tue, 20 Oct 2026 10:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJAzJ-00012f-8K
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 10:38:49 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJAzH-0001hf-Ds
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 10:38:49 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-8ab37e44643so21593657b3.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 07:38:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792507126; cv=none;
 d=google.com; s=arc-20260327;
 b=E7rmUcx9flSDo0vULe1vare0LFRWk+zztCQyRWiemYZJjf57HoggjVmz6sv0M2OGxP
 ngE36vwuGI5KycDxaI9dVc9zFfUBRIHVRX2rof1tHOA0qeVn29tXM3UyQ/j6w/SjokH4
 aORfotozCV3ckZ+/y85PxWhBPqC7m6CGJuNBnFRiVThQhsd3XkAww3lzDhBknCJVSFmx
 FnzrtRnCeX93EdVkgBrDG/CzhwTH92LC2J2wAnw/IDe+kafCgDgWZPaCGL0iwZ0OEXIf
 PTZ4f/0flj5YU2xxznpuNgkOolTCas+FKi7q/8esi/Tjguj01kbsmT6MsRkqsAnrY9Gq
 6vqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UmB6OysWlhKR3079KDwGGPRE9FeHD3Zc+RQB/NIyXLY=;
 fh=/0mLx2QZvtq8GoWzzSMd7ktKRyEIb2z3fIEkTJl/yJI=;
 b=C9I+C+an4oD4KQ3uPv461ATp6aWQ6ku6PpbHXnEmtm4Ccp4JXps6jUS2uC6sdZWtFA
 TYYWItbqd465IHB6cuCcZ4SNHCTB6U/t0rDLWzANTCYTChrLByra1JQB1/H2ekP5tYOQ
 sMnizkgSlnPjc9sNKoesetUDf1dfv1DlVGYBICc3WYgBTdDp9D36m4XRCbL77yBMKP+7
 SCROiAdVn3CjENTDRw8lUGyykhndzMZ8ccNUJXEkfkSeB0mmAjIRQiQSyRwzxWgbNrx3
 qgDd3pd/rZEEwNTLeEZ6COM9g5trybCM62P9gFf8ssvw1A4js8hPOFGrfvjmMgWvRYuU
 vouw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792507126; x=1793111926; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UmB6OysWlhKR3079KDwGGPRE9FeHD3Zc+RQB/NIyXLY=;
 b=e6Kb2ndZfVgmmuE+1G48WGQjR9YEau4UPZVOi4tFklTya2vaTjx+Kejm4TRVaDjing
 Llaivi6GpfJxi3BeKdQB3PwF814WF8b7okxvK1gdaKLnN+6smPd4JkEBzbahX6aiY/i+
 aMTQEuLgZ89PIP6MWiCLX+IirqKKAOsqgkqVj1In1UWO0whHkm6wN3HWkPiYpOvwD/GF
 eIzYbTa66EYmDlAQb95T922aSAHqnkh0hIoUgVumn7x35O49Eiq2kLt6S5Jy91BQ4sPF
 YaCuNNNyZ+qKdq1gmM/gFHTxMrxeVevPd40oKqC+KVT07CqP6Q8B+oM4Gs2kCQLh2wVe
 UmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792507126; x=1793111926;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UmB6OysWlhKR3079KDwGGPRE9FeHD3Zc+RQB/NIyXLY=;
 b=0UXgD18oQjX0FrEpCBN11GOnrAET5+UwYWSUfPreC4Tp6YaTuoLHwiC7f1Z8JAPikS
 IOmZON+V4Lvf1Zt33HguXZTZItw/InHcDr2WbiqJpu9sLKxEkqKS4ePEIbZ2Gv0NOdAS
 FgksK+wD7+Jg1ByaEq+1KQ0v81FO6Sm4Y+0jmDZudo+8MaKc5B27N45wBNIxnNxzpkyN
 ZVRGCm3IeDn7u/r+xoGZV/ecrAjJN40waMoTiZxZVHo0kt6scf2TUCUnOmqqUq42Q3jv
 QjOlFrZhUuXyXayYNQh4Fi55xKCQKal5fcuCN5C/T4RerZIP/5E8o2qwoUsx7O1JNb7X
 gSyA==
X-Gm-Message-State: AFq9FYLdF4DDFYLemhdtwZVbnMXqqfrxi3YMMtbckqswDE86ktDDquqn
 kz7169vGrQaq3oYX/CaIxcTj/N9nD0p+SdR8k4gDJnEj6ZSdkE0CCGU7azUlzk4Br6B0B458svw
 xRqFocNPv97dOC27HC0HSsCJnBWX7p5m3u5QZRt3DJP9Xf3HE9AmbekDI/A==
X-Gm-Gg: AYBFou28MY7bRdeQx7QwgbJxB0bKoN8/2BTArF6/Jw+iAQhkqdUGoewg9tfEBjHn3E6
 t4mWgUeFDtRf8s3GQews8J5zekN9oJ/h8tu3wjInP00Xr9XulsgcAQNlXGFe00dtJIamKK/I4HL
 /ooTAjmSIcNwMXkF0eCwxEcQZVyxlKeN4MQj15ivBjYi+G1r6ofTLVd+vnbv2FRP1R2UcoGLhjw
 7qxwRMQOF+QH6bvR3J4+oOn+yCDrdffHt0RA2v0z6pm9MxPPBbWE/jxvd04vlDVAr7hVZrq6jqm
 Bnd3O3y0TrMdNl3e0YwwGBGgR9cMRNXJG1lSj4FtoaUQBAc+odMSmyTsna/nW3sN+sQsBLXThYg
 so3OK6PJDulX7x7XTgUgUyWhxzar6sPmVbwM1g8o=
X-Received: by 2002:a05:690c:4885:b0:8b0:a7d5:8595 with SMTP id
 00721157ae682-8b0f21e9448mr31481257b3.51.1792507125617; Tue, 20 Oct 2026
 07:38:45 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260908073548.3249551-1-maobibo@loongson.cn>
 <20260908073548.3249551-6-maobibo@loongson.cn>
In-Reply-To: <20260908073548.3249551-6-maobibo@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2026 15:38:33 +0100
X-Gm-Features: AclHuK_94i0bsrovYJ5JVj6AspDJAWH6v3bczgObDJ9onXKexpAlDWhwaaU-f-8
Message-ID: <CAFEAcA9QmRG_ffAqrcXV0pxc8vFKhBqK=ORfLK1FC3w+-SOjgg@mail.gmail.com>
Subject: Re: [PULL 5/5] hw/intc/loongarch_extioi: Add extioi interrupt status
 display
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 8 Sept 2026 at 08:35, Bibo Mao <maobibo@loongson.cn> wrote:
>
> When irqchip in kernel is enabled, the register status of extioi irqchip
> is in KVM kernel. Here add interrupt status display in user side in order
> to debug extioi irqchip driver.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> Reviewed-by: Xianglai Li <lixianglai@loongson.cn>
> ---
>  hw/intc/loongarch_extioi.c | 58 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)

Hi; this code introduces undefined behaviour, which you can see
if you build QEMU with the clang sanitizer (i.e. configure with
"--enable-ubsan --cc=clang --cxx=clang++") and run 'make check'.
The test-hmp test falls over with this backtrace:

    ../../hw/intc/loongarch_extioi.c:439:33: runtime error: load of
misaligned address 0x5b0a281448b4 for type 'uint64_t' (aka 'unsigned
long'), which requires 8 byte alignment
    0x5b0a281448b4: note: pointer points here
      00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00
00 00 00  00 00 00 00 00 00 00 00
                  ^
        #0 0x5b0a0000d823 in loongarch_extioi_print_info
/home/pm215/qemu/build/loongarch-san-dbg/../../hw/intc/loongarch_extioi.c:439:33
        #1 0x5b09ff200b34 in qmp_x_query_intc_foreach
/home/pm215/qemu/build/loongarch-san-dbg/../../hw/core/machine-qmp-cmds.c:437:13
        #2 0x5b0a00042339 in do_object_child_foreach
/home/pm215/qemu/build/loongarch-san-dbg/../../qom/object.c:1254:19
        #3 0x5b0a0004239d in do_object_child_foreach
/home/pm215/qemu/build/loongarch-san-dbg/../../qom/object.c:1259:23
        #4 0x5b0a0004239d in do_object_child_foreach
/home/pm215/qemu/build/loongarch-san-dbg/../../qom/object.c:1259:23
        #5 0x5b0a00042429 in object_child_foreach_recursive
/home/pm215/qemu/build/loongarch-san-dbg/../../qom/object.c:1279:12
        #6 0x5b09ff200978 in qmp_x_query_interrupt_controllers
/home/pm215/qemu/build/loongarch-san-dbg/../../hw/core/machine-qmp-cmds.c:451:5


> +static void loongarch_extioi_print_info(InterruptStatsProvider *obj,
> +                                        GString *buf)
> +{
> +    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(obj);
> +    uint64_t *val;
> +    unsigned long irq;
> +    ExtIOICore *core;
> +    int i;
> +
> +    vmstate_extioi_pre_save(s);
> +    g_string_append_printf(buf, "%s:\n", object_get_typename(OBJECT(obj)));
> +
> +    val = (uint64_t *)s->isr;

This is because s->isr is an array of uint32_t values, not uint64_t.
You can't take a pointer to one and cast it to the other like this:
 (1) it may not be aligned enough
 (2) on a big endian system, it will not give you the same value

> +    g_string_append_printf(buf, "  ISR     0x%016"PRIx64" 0x%016"PRIx64
> +                                " 0x%016"PRIx64" 0x%016"PRIx64"\n",
> +                                *val, *(val + 1), *(val + 2), *(val + 3));

I don't know this device and so I don't know what the natural way
to show these register values to the user is. So I'm not sure whether
it would be better to simply print the values as uint32_t, since that's
what we have, or to manually assemble the two uint32_t halves into a uint64_t.
Printing uint32_t seems like it would be simpler and would match the
representation the device is actually using.

Similar problems apply to all the other places where we cast a uint32_t*
to uint64_t* in this function.

Could you write a patch to fix this, please?

thanks
-- PMM

