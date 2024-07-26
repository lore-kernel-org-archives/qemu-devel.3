Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21F2C3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 09:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXHL6-0005HD-PH; Fri, 26 Jul 2024 05:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sXHL0-0005Fy-DG
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 05:34:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sXHKy-0003BM-BF
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 05:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721986446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EBGQoV6sWcBATxW+ew0QzqXcAltRs/UxQO6ZDiGBqPo=;
 b=OZu1gXvGV6dqkP+Vx/t86wDcX3x/5WGaDUBy4qWBTkHNG2q67Z0KvFM8/HhipHE7oRMa0d
 0xsEf3ZFuySCCLRKuXErI9Gn/7IB/Rvn5Y0GYGqHc0G00OG2xO/p7q8jmSWZmJGXCHxgTk
 Ipa4ZXg7gOMzY0ovzMtJuOhv1AG/hfg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-2o1-JGgkNMqB6B_ViDGUzw-1; Fri, 26 Jul 2024 05:34:00 -0400
X-MC-Unique: 2o1-JGgkNMqB6B_ViDGUzw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ef23d3650fso8879641fa.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 02:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721986439; x=1722591239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EBGQoV6sWcBATxW+ew0QzqXcAltRs/UxQO6ZDiGBqPo=;
 b=GlBFFAcQa9SfQ+HuwByDvTbh+tnIWD+Rk/MUZIsjcTXdVZz9ydGypnD1yXxMYZ78xo
 2dNEt5TGfRlcUesbVyIG1P/RR2jz/IKhRYB/9wfb6bVrhFGXKmIR7KVyTWUBXCIA7YjH
 esxwg/0wy2N4XI1J5gw0TcXUv1a7Pq3DBSiZsEayl0jnOE30xF2UosjJieZC2aKDHXyg
 +0GedeKWglejK4FPo6zKZFCMegNRMxKkntqyF9lF5yHq52T+Yq34avfuPhM8ODeQYuNg
 gDL4E9FmN5/iWdUlqRu9uIWUj0q3aXgePYNtj+LTyavrn5qgg7afJfp6TpRMETxjjNX1
 8tpA==
X-Gm-Message-State: AOJu0YzIyzeNTZXEf7FINBJwRNOqGqCi/SNbgOk45l4r765nVGdqrloU
 um2ClEiOch40FBXmGjiW1QlyIq7Uf7wpUSdvd6y1HuqpehEUI0qvby6bNr7QTUfuNjb7a+ok+YX
 RzMHDOZtKOnUia45uOzGEZlaqRxW72xVo+Gp/vJePn+m8yG7Er8cO
X-Received: by 2002:a2e:880b:0:b0:2ef:2c86:4d43 with SMTP id
 38308e7fff4ca-2f03db6cf16mr32242301fa.3.1721986439277; 
 Fri, 26 Jul 2024 02:33:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbo4/itypoyGAiOFEuHpwI9IzyoFXRHtxYVhgm/pL/JgBUYv4RZS9xBezs0EU97CnzVBp5dA==
X-Received: by 2002:a2e:880b:0:b0:2ef:2c86:4d43 with SMTP id
 38308e7fff4ca-2f03db6cf16mr32241831fa.3.1721986438827; 
 Fri, 26 Jul 2024 02:33:58 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428057b5f69sm70314565e9.39.2024.07.26.02.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 02:33:58 -0700 (PDT)
Date: Fri, 26 Jul 2024 11:33:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>,
 <peter.maydell@linaro.org>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <richard.henderson@linaro.org>, <andrew.jones@linux.dev>,
 <david@redhat.com>, <philmd@linaro.org>, <eric.auger@redhat.com>,
 <oliver.upton@linux.dev>, <pbonzini@redhat.com>, <will@kernel.org>,
 <gshan@redhat.com>, <rafael@kernel.org>, <alex.bennee@linaro.org>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <npiggin@gmail.com>, <harshpb@linux.ibm.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH] accel/kvm/kvm-all: Fixes the missing break in vCPU
 unpark logic
Message-ID: <20240726113355.731e61fe@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240725145132.99355-1-salil.mehta@huawei.com>
References: <20240725145132.99355-1-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 25 Jul 2024 15:51:32 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> Loop should exit prematurely on successfully finding out the parked vCPU (struct
> KVMParkedVcpu) in the 'struct KVMState' maintained 'kvm_parked_vcpus' list of
> parked vCPUs.
> 
> Fixes: Coverity CID 1558552
> Fixes: 08c3286822 ("accel/kvm: Extract common KVM vCPU {creation,parking} code")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Message-ID: <CAFEAcA-3_d1c7XSXWkFubD-LsW5c5i95e6xxV09r2C9yGtzcdA@mail.gmail.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  accel/kvm/kvm-all.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 0aa4b4624a..c181297f00 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -362,6 +362,7 @@ int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id)
>              QLIST_REMOVE(cpu, node);
>              kvm_fd = cpu->kvm_fd;
>              g_free(cpu);
> +            break;
>          }
>      }
>  


