Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68160C531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 13:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgP82-0000lR-Sf; Tue, 20 Aug 2024 09:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgP7t-0000hh-1P
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 09:42:22 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgP7q-0001s1-Ad
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 09:42:20 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5becc379f3fso4240796a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 06:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724161336; x=1724766136; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x53UA5XZQzcHFqQczWRz/UkFLdL3wtbU8KgAdwqK0ww=;
 b=dsnVNPCgjeth8gLJFkn0EdrkpTA0X8kjB+eGZ3JzuCF0VvZSjrT3VzDbtzv2bbxBCe
 Whi0b/KW32d4k7/sZoErcaDs/tUmZVXrXqeW9XzxsbQadDAmdwk9izihCbtSdBPs5vq6
 Am+vw/sHR+ixHvBPtfQROQiVmPN+JFBlmfjK73u8N062/rs+QcfdPcBBD799eZglWykq
 MWvNG/tDe5RwRYwquJbYrdrMMaXyu7mN+pxrwb91DWb5yXkHsuZKffGElExsynSJ4+j4
 zO7ypbGsboi99Qs4fjnVEcS1ula/drrzX0oenk6qnaA7J2d4PR8c3i3DgEAbS+clvYQB
 5Oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724161336; x=1724766136;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x53UA5XZQzcHFqQczWRz/UkFLdL3wtbU8KgAdwqK0ww=;
 b=vbCOJDOERmgeBRO1NHz4G1XcwtJle6zaluwlC333lBIcZcH84d0yTSvl3zQ0g3r2Bt
 X0NWekqrKlffd/Jf9hWWLqs6KAD/JXv5HVDnn3NsiRPK+FkXWN/csPfh+E+mLQsFOHQQ
 E4VPljiBjisvHvDYeLZBSzstm4qdJOmlERLnLtwQ+KOTH1BOdbR419mDeedl2PSZlq7F
 rQZXOYUf3fSC/dcz10Y9dhxbQCILpBJmKyVFPAnJF7/vs8fGkgpwNchjjNBpc82Vyi2X
 ih+eZ4bNQkIuvGUeDPvs5QmNluF6DqGzwFykTcnR2VPyliPH9ZeXvFpbWl1XNQ9Eda3B
 NP4Q==
X-Gm-Message-State: AOJu0YxqGV/ZsoH37fQzy9xCpJrXC5FOqonaUdcY9eW8x70qVs2S+/iF
 pq0TBCNrOeQlmlXQYqL34/WjPR/1efAbSfJU/qJkPw2AtpslZbBxKkLASlJ/UTLtXQdYQbzspAp
 CCB0ZYZL/78X+WT8Ke2JP+Cx/NPheqILQ7paszg==
X-Google-Smtp-Source: AGHT+IGGu0CztAOGO8/w0o3iwiwmWhaLRMM6N1luRxQuc2ZYBFsX9wd4uLBSEWixU/lVYE08Wy2dWapcI0SLbI+miQo=
X-Received: by 2002:a05:6402:1d4b:b0:5be:f295:a181 with SMTP id
 4fb4d7f45d1cf-5bef295a2dfmr5104451a12.28.1724161335990; Tue, 20 Aug 2024
 06:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240718230031.69641-1-danny_canter@apple.com>
 <CAFEAcA__WZ=uw0VLcP0fLbUTwmctsZ1y=FRf9bXMT9WJC2sRFA@mail.gmail.com>
 <E03A8C36-4079-468F-9596-328D713C3611@apple.com>
 <CAFEAcA9XXhsUeHNjsVkjhjO2_Njkk=L00BG+24xtXWWKgJayRw@mail.gmail.com>
 <CA7E2403-A9F6-4B29-B640-13E41D530744@apple.com>
In-Reply-To: <CA7E2403-A9F6-4B29-B640-13E41D530744@apple.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Aug 2024 14:42:05 +0100
Message-ID: <CAFEAcA948k3=ep0FhqPL929=vB38SR-5sBS4fETrv4HUMC+zug@mail.gmail.com>
Subject: Re: [PATCH] hvf: arm: Allow creating VMs with > 63GB of RAM on macOS
 15+
To: Danny Canter <danny_canter@apple.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Cameron Esfahani <dirty@apple.com>, rbolshakov@ddn.com, agraf@csgraf.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, 17 Aug 2024 at 01:37, Danny Canter <danny_canter@apple.com> wrote:
>
> Peter, thought I=E2=80=99d send this little snippet before getting the re=
st of V2 done in case anyone hates this :). I tried to take a similar appro=
ach to kvm_type,
> but I=E2=80=99m not sure if this will be looked upon favorably so want an=
 early opinion. The nice thing about kvm_type is at least it has differing =
meaning per
> platform so all the impls can do whatever they need, with the below it=E2=
=80=99s really only needed on ARM (and obviously macOS specific) so it's a =
bit odd,
> but couldn=E2=80=99t think of how else to be able to be able to get what =
we need out of the memmap during vm creation.
>
> How this would be used is almost exactly like how ARMs kvm_type is used. =
We set up hvf_get_physical_address_range to freeze the memory
> map and compute the highest gpa, then check if that exceeds our platforms=
 largest IPA size and if so return a sane error message. If everything
> checks out we=E2=80=99d just set the IPA size on the VM config object and=
 then create the VM. The current patch should mostly stay the same after th=
at bit
> of plumbing I think besides removing the macOS 13 ifdef=E2=80=99s (and si=
mplifying the copy and pasted loop you pointed out). x86=E2=80=99s
> hvf_get_physical_address_range can be NULL.
>
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -215,6 +215,10 @@ typedef struct {
>   *    Return the type of KVM corresponding to the kvm-type string option=
 or
>   *    computed based on other criteria such as the host kernel capabilit=
ies.
>   *    kvm-type may be NULL if it is not needed.
> + * @hvf_get_physical_address_range:
> + *    Returns the physical address range in bits to use for the HVF virt=
ual
> + *    machine based on the current boards memory map. This may be NULL i=
f it
> + *    is not needed.
>   * @numa_mem_supported:
>   *    true if '--numa node.mem' option is supported and false otherwise
>   * @hotplug_allowed:
> @@ -253,6 +257,7 @@ struct MachineClass {
>      void (*reset)(MachineState *state, ShutdownCause reason);
>      void (*wakeup)(MachineState *state);
>      int (*kvm_type)(MachineState *machine, const char *arg);
> +    unsigned int (*hvf_get_physical_address_range)(MachineState *machine=
);

My gut feeling was that this felt very specific compared
to the kvm_type method which lets different architectures
use it for whatever they need. But on the other hand we
have exactly one use for this for hvf right now and at
least for the foreseeable future it's unlikely we're going
to want to do more. And this API isn't a set-in-stone one,
so we can come back and generalize it later if we ever need
to do that. (Or, if we find we need this kind of hook for
a third hypervisor type, maybe we try to make it hypervisor
agnostic at that point.)

So I'm OK with this.

thanks
-- PMM

