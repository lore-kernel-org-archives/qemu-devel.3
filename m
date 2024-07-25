Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF8AC3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 10:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWvpE-00019T-Sb; Thu, 25 Jul 2024 06:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWvpA-00016x-HY
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 06:35:53 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWvp7-0004Oq-6T
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 06:35:51 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5ab2baf13d9so912984a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 03:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721903747; x=1722508547; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w5KerTRvkuy9w4kv3vS5mRyABQJuA2uQKXsWkiI4WfA=;
 b=Rvil3irn/zcGsLiEIBXrnJAk0LyaY2XdRlGYbWZctGmEf6Gp10xrvD5Mz6rjrZLyl5
 Mv1hz0tU4A8TjA3TQ658YOArGN3gt4s1rFY4ArrqEOjr8oaVl00s7R0z4B+QGUUzbZPG
 ROGwuw1kaQm4Y3n9+9z4MQRY+cLrXQgD1J9NTj4z+KKJjT6HsupfjaL/fzgW84K3HybW
 GLpX3iBWtG4xYSgZsAJQMLEFA5tPiB60Y9SpT2lJxqCmNyCOfcihTM7bYZOFiKZ3qgRT
 gU4WdcWrZ+ZSeCuwm4TvLIO4hiM8jFnGthQy59ER3ttzf15b5+unn+4juf8R8Em6yCMt
 OyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721903747; x=1722508547;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w5KerTRvkuy9w4kv3vS5mRyABQJuA2uQKXsWkiI4WfA=;
 b=JVcMvAgJVIwB4t4xXfv5n8cReS0+QAcaiBIxjF3X09z1TrwLL9NNaG16Lkb4HvJc7N
 PN/kYGeDV2mRHIoAYTcAcbJ6ogHJxXoZfc0VNs7WhpZG58dF2j5OcYNf//Ju7zqVti6e
 v7UNWdyvRJNbkvnaXOer6sHXRaWaEfhn6+C1k5TscgfDNpW1eh49/CDUyEWOtYyDQt7G
 T0o2UGnIZxseBIHLQp1HOrAxRxcmc6ABhfGdGX5Djmf+D1RSRu1Apbu44Sp8vnQ8NWhB
 n+8b1YPA8w8kCG4D69eEfCrdoCcokvY85rm2bwECE3Ud7gsQc0Owaoh+GJMU+mYHEws0
 YU3g==
X-Gm-Message-State: AOJu0Yw3csHE0y57L3x4WrP921HNJPb3HeLjcDj4dzCTTitjJilCaL78
 dGJanxzJ6ay44jgW8hqjspKEkjk5pYaBN/1EfVy5cvpYFiGAVFa78wCB05hAmVMkA3RdIbdOUcX
 zaskfJfnLJm+wkvqxw3UGveKxuIo814P+hUoqgA==
X-Google-Smtp-Source: AGHT+IEcBYBM3u3BO1medaOE4ZDBSfard0UumxmemZPpsEyAGf4fpl2NSLGhyrGGWvZ67s6IQvdgbkFzTWZsaNzJM4c=
X-Received: by 2002:a05:6402:26ce:b0:5a0:c709:aa0b with SMTP id
 4fb4d7f45d1cf-5ac2c1c441bmr1896028a12.24.1721903747061; Thu, 25 Jul 2024
 03:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1721731723.git.mst@redhat.com>
 <08c328682231b64878fc052a11091bea39577a6f.1721731723.git.mst@redhat.com>
In-Reply-To: <08c328682231b64878fc052a11091bea39577a6f.1721731723.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jul 2024 11:35:35 +0100
Message-ID: <CAFEAcA-3_d1c7XSXWkFubD-LsW5c5i95e6xxV09r2C9yGtzcdA@mail.gmail.com>
Subject: Re: [PULL v2 37/61] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Salil Mehta <salil.mehta@huawei.com>, 
 Gavin Shan <gshan@redhat.com>, Vishnu Pajjuri <vishnu@os.amperecomputing.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Xianglai Li <lixianglai@loongson.cn>, 
 Miguel Luis <miguel.luis@oracle.com>, Shaoqin Huang <shahuang@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Tue, 23 Jul 2024 at 11:58, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Salil Mehta <salil.mehta@huawei.com>
>
> KVM vCPU creation is done once during the vCPU realization when Qemu vCPU thread
> is spawned. This is common to all the architectures as of now.
>
> Hot-unplug of vCPU results in destruction of the vCPU object in QOM but the
> corresponding KVM vCPU object in the Host KVM is not destroyed as KVM doesn't
> support vCPU removal. Therefore, its representative KVM vCPU object/context in
> Qemu is parked.
>
> Refactor architecture common logic so that some APIs could be reused by vCPU
> Hotplug code of some architectures likes ARM, Loongson etc. Update new/old APIs
> with trace events. New APIs qemu_{create,park,unpark}_vcpu() can be externally
> called. No functional change is intended here.

Hi; Coverity points out an issue with this code (CID 1558552):

> +int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id)
> +{
> +    struct KVMParkedVcpu *cpu;
> +    int kvm_fd = -ENOENT;
> +
> +    QLIST_FOREACH(cpu, &s->kvm_parked_vcpus, node) {
> +        if (cpu->vcpu_id == vcpu_id) {
> +            QLIST_REMOVE(cpu, node);
> +            kvm_fd = cpu->kvm_fd;
> +            g_free(cpu);
> +        }
> +    }

If you are going to remove an entry from a list as you
iterate over it, you can't use QLIST_FOREACH(), because
QLIST_FOREACH will look at the next pointer of the
iteration variable at the end of the loop when it
wants to advance to the next node. In this case we've
already freed 'cpu', so it would be reading freed memory.

Should we break out of the loop when we find the entry?

If we do need to continue iteration after removing the
list node, you need to use QLIST_FOREACH_SAFE() to do
the list iteration.

> -static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
> -{
> -    struct KVMParkedVcpu *cpu;
> -
> -    QLIST_FOREACH(cpu, &s->kvm_parked_vcpus, node) {
> -        if (cpu->vcpu_id == vcpu_id) {
> -            int kvm_fd;
> -
> -            QLIST_REMOVE(cpu, node);
> -            kvm_fd = cpu->kvm_fd;
> -            g_free(cpu);
> -            return kvm_fd;

In this old piece of code we were OK using QLIST_FOREACH
because we returned immediately we took the node off
the list and didn't continue the iteration.

> -        }
> -    }
> -
> -    return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
> -}

thanks
-- PMM

