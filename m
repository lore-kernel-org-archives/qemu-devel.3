Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4200C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 12:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWxZE-0005Er-FV; Thu, 25 Jul 2024 08:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWxZC-0005DY-Gr
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 08:27:30 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWxZA-0007oU-Oy
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 08:27:30 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5a309d1a788so1004726a12.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 05:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721910447; x=1722515247; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GOh6PKdCbaMoUdlPd1L+eg1JAZ26MYlPj4SLk05TsGk=;
 b=wS0/ZmP5dJYPEuO+ZQ/CLLcLIk2MMLPTUru+/566sw1bDJ+vo1NkxtqdxgBPJss590
 pyZUtGNq9/8dbFcRuvmuBOnnO5ZP5Ksej+YyJIogixEwmGOGG6kvrCPOWVEC8+sC4374
 f0T48n6KtsegXU+b1cIRTwbsc+Bl/TLcrpe5R5hguAz5Ff3Hx5X8YgBJfa4Hns6a3DIr
 xWibUU3w9pDvrRtKmMckXUSwAIWEy57MmANQXByNlSl3rrRZOUxdVmLXANO/1FHeSzDz
 /jCTrbcSirlIVmfeoNBBlCKaDlz15d+d5DcUlrweq8tumYmkk/SF7dL7pBofrCDhLAvm
 rjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721910447; x=1722515247;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GOh6PKdCbaMoUdlPd1L+eg1JAZ26MYlPj4SLk05TsGk=;
 b=e4ehSOgOXqoQ7bXOdq5FhgE/ilVs2PEvf+fqoTN3m15XCgLPVvEfqKPa6Pfn89G2gb
 d/XOO2ogqH03qZR5R8EYcnaqo1hHWk8+xW/1lool7/Kd6pKrrFK1jmX3cNL1QPZTZpof
 GdpT/XKYtWjcfopkvWfZvv2sncy0WiCWNnleYt1NgW+6T3CcgtKfrn93buynTvWnWDnV
 vPTErtdQKwxFSiANdqHIkahf214XkrCaIbLSuW6IerxpqQXzQVRzpnO4BPLY3lE81ENg
 LwGtgfDnVNylWiyB8ZQpkn6/oPcQuDW+sk9FwHAklSovLww/2udzpfMNw/TYm8aWrKf2
 SZ+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ2IxqqvOG/K08jQ5KmF+qNXALvTBEPv/F4Hyzs3ZtaQyhVF1py4lhwfYcXG6XrRyGbU3j2HMg7hJDwlawKgyS0Jluois=
X-Gm-Message-State: AOJu0YxcYBLT4kfxwQMN6N9Jo6VU7MfvNp9mDAwFifNe9aKfDu8KDaSX
 AL7KVub/QKWngWN05OgZ1/snBwOfVHy3YnD/F0/g5YVBkw5lhNNbYYGi9wdjIvv1+ZuaRI0RlUQ
 fkKD+rqJPtWFM7RlgQZKogVMWkkxvalCas0A8qg==
X-Google-Smtp-Source: AGHT+IEDyBxEvxBsN9vTBlpY82wdgrQiPGM2Bk6P5qhTyE3mo4k/VO1Rtgxf/JjCjs5r4jLmFPukfq3rbKZL28GZa7s=
X-Received: by 2002:a50:ab55:0:b0:57d:456:e838 with SMTP id
 4fb4d7f45d1cf-5ac6519c7d8mr1304019a12.31.1721910446680; Thu, 25 Jul 2024
 05:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1721731723.git.mst@redhat.com>
 <08c328682231b64878fc052a11091bea39577a6f.1721731723.git.mst@redhat.com>
 <CAFEAcA-3_d1c7XSXWkFubD-LsW5c5i95e6xxV09r2C9yGtzcdA@mail.gmail.com>
 <8f5fcf0c1deb4f199d86441f79298629@huawei.com>
In-Reply-To: <8f5fcf0c1deb4f199d86441f79298629@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jul 2024 13:27:15 +0100
Message-ID: <CAFEAcA9-gVBLAH9PaFrPmBLD5tHXMZ+-2m+pRvtjodOBaBa0GQ@mail.gmail.com>
Subject: Re: [PULL v2 37/61] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Gavin Shan <gshan@redhat.com>,
 Vishnu Pajjuri <vishnu@os.amperecomputing.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Xianglai Li <lixianglai@loongson.cn>, 
 Miguel Luis <miguel.luis@oracle.com>, Shaoqin Huang <shahuang@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
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

On Thu, 25 Jul 2024 at 13:05, Salil Mehta <salil.mehta@huawei.com> wrote:
>
> HI Peter,
>
> >  From: Peter Maydell <peter.maydell@linaro.org>
> >  Sent: Thursday, July 25, 2024 11:36 AM
> >  To: Michael S. Tsirkin <mst@redhat.com>
> >
> >  On Tue, 23 Jul 2024 at 11:58, Michael S. Tsirkin <mst@redhat.com> wrote:
> >  >
> >  > From: Salil Mehta <salil.mehta@huawei.com>
> >  >
> >  > KVM vCPU creation is done once during the vCPU realization when Qemu
> >  > vCPU thread is spawned. This is common to all the architectures as of now.
> >  >
> >  > Hot-unplug of vCPU results in destruction of the vCPU object in QOM
> >  > but the corresponding KVM vCPU object in the Host KVM is not destroyed
> >  > as KVM doesn't support vCPU removal. Therefore, its representative KVM
> >  > vCPU object/context in Qemu is parked.
> >  >
> >  > Refactor architecture common logic so that some APIs could be reused
> >  > by vCPU Hotplug code of some architectures likes ARM, Loongson etc.
> >  > Update new/old APIs with trace events. New APIs
> >  > qemu_{create,park,unpark}_vcpu() can be externally called. No functional
> >  change is intended here.
> >
> >  Hi; Coverity points out an issue with this code (CID 1558552):
> >
> >  > +int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id) {
> >  > +    struct KVMParkedVcpu *cpu;
> >  > +    int kvm_fd = -ENOENT;
> >  > +
> >  > +    QLIST_FOREACH(cpu, &s->kvm_parked_vcpus, node) {
> >  > +        if (cpu->vcpu_id == vcpu_id) {
> >  > +            QLIST_REMOVE(cpu, node);
> >  > +            kvm_fd = cpu->kvm_fd;
> >  > +            g_free(cpu);
> >  > +        }
> >  > +    }
> >
> >  If you are going to remove an entry from a list as you iterate over it, you
> >  can't use QLIST_FOREACH(), because QLIST_FOREACH will look at the next
> >  pointer of the iteration variable at the end of the loop when it wants to
> >  advance to the next node. In this case we've already freed 'cpu', so it would
> >  be reading freed memory.
> >
> >  Should we break out of the loop when we find the entry?
>
>
> Thanks for identifying this. Yes, a  break is missing. Should I send a fix for this
> now or you can incorporate it?

The code is already in upstream git, so please send a patch
to fix the bug.

thanks
-- PMM

