Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68EEC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 16:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP2tf-0000lq-Ad; Wed, 03 Jul 2024 12:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP2tc-0000lW-H7
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 12:31:52 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP2ta-0003pk-IS
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 12:31:52 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-710437d0affso3345067a12.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 09:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720024308; x=1720629108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5imSDxRRvQ1NCfqnWNYe8MKqdt3XxEvCuZ0K7waXPK8=;
 b=fWLOVlmr+c5E99G+PUGyYBU1PcT4qppD8+MnJQdMJtcMHF6BkUEoy2+Wa/+YfHuOWv
 e/V3Nfx4KFR8/mMdRAr61fIwchBU5a0oDxSszITuZAoiGyYierjLJWKbaUk/p4ZWjBVg
 F6ZStPywbKeHny6KVWN88/xiJZ8U1WA4OjOaXthxbzlE2KmIs/K5B51QJMzZ7+nf0x4W
 03CMa1ZIkSTFVQW5cixgFsj7I4tMEFcdN/yKhHABbzjlkIeT0/njhLkLnPUWI6lErQyq
 r75lotYEUqkV9l3fsb3Dt1eRk5VnvHL1acJZfap9D43rjDvt7jle2fnO+gcCL/BHzarU
 McmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720024308; x=1720629108;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5imSDxRRvQ1NCfqnWNYe8MKqdt3XxEvCuZ0K7waXPK8=;
 b=iYC/fXaf3bHj6dZpsAN03dQ/RfG8MkVUwQby8RKaPz4ZFmK1F3dqrBIIfzckC1dlqo
 G82ai/+Fzad1X8u2A1LIsD6//4S9MDSynpCNK16cAprVai9qNClVHZDHroCyQdr9WJXD
 bA2Cpp+g+M1/+7bgLCo5R/YcMmve0uqUh+RmDm+TGAohZCdYYiLLFIaKYGz5qkPE6c33
 t1/Q9wAIZg9MO6C6ceGEjk9dAGqC8wAFKn7UtdN42USvKynl0jBtA6HcMkxSv1UnqhWr
 +/1GFcuLveFyMziHoBOmWV8bOtZBvG7AyIBMh2BFFtRHkf6ZSEfo02CT4rie+sEL5qh8
 Joyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPNQ/s/AI9tRjVRgUw+UfnzH0tuUVohQC/eMcB7A5gdkerpywwLIN3/4/GFxfuHqZFyTigHEV1e2YLhqhYAKjo1uf9fBQ=
X-Gm-Message-State: AOJu0YwcDUbRt3T83SDXCecQvJoZXYrIKIywpDvOaMMKFk0BNkFd6rEE
 6G7d7IVsDQTjD5TXdht68kYvBR40u9747DnSTUM/CHj9gwQfsOWLf+uvtVW+mKM=
X-Google-Smtp-Source: AGHT+IERbz444/0nS+HoE0jrhzRLsR17MG9lZ5TEK60d2bt1eUDsANyqL6MAfuwlHCssomyDDf4kew==
X-Received: by 2002:a05:6a20:7350:b0:1bd:2071:33cb with SMTP id
 adf61e73a8af0-1bef60f2575mr13374381637.13.1720024307466; 
 Wed, 03 Jul 2024 09:31:47 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-708044ae297sm10615327b3a.155.2024.07.03.09.31.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 09:31:47 -0700 (PDT)
Message-ID: <f0961f6f-642c-4dc8-8bf3-1457f71da500@linaro.org>
Date: Wed, 3 Jul 2024 09:31:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/88] virtio: features,fixes
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <cover.1719951168.git.mst@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 7/2/24 13:15, Michael S. Tsirkin wrote:
> The following changes since commit 1152a0414944f03231f3177207d379d58125890e:
> 
>    Merge tag 'pull-xen-20240701' ofhttps://xenbits.xen.org/git-http/people/aperard/qemu-dm  into staging (2024-07-01 09:06:25 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git  tags/for_upstream
> 
> for you to fetch changes up to 29e45afd8d6abf7a67dab5db0ab1cfbc388daefe:
> 
>    hw/pci: Replace -1 with UINT32_MAX for romsize (2024-07-02 11:27:19 -0400)
> 
> ----------------------------------------------------------------
> virtio: features,fixes
> 
> A bunch of improvements:
> - vhost dirty log is now only scanned once, not once per device
> - virtio and vhost now support VIRTIO_F_NOTIFICATION_DATA
> - cxl gained DCD emulation support
> - pvpanic gained shutdown support
> - beginning of patchset for Generic Port Affinity Structure
> - s3 support
> - friendlier error messages when boot fails on some illegal configs
> - for vhost-user, VHOST_USER_SET_LOG_BASE is now only sent once
> - vhost-user now works on any POSIX system
> - sr-iov VF setup code has been reworked significantly
> - new tests, particularly for risc-v ACPI
> - bugfixes
> 
> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>

Fails testing:

https://gitlab.com/qemu-project/qemu/-/jobs/7257337667

qemu-system-loongarch64: -chardev 
socket,id=chr-reconnect,path=/tmp/vhost-test-9Y0NQ2/reconnect.sock,server=on: info: QEMU 
waiting for connection on: disconnected:unix:/tmp/vhost-test-9Y0NQ2/reconnect.sock,server=on
**
ERROR:../src/tests/qtest/vhost-user-test.c:255:wait_for_fds: assertion failed: (s->fds_num)
qemu-system-loongarch64: Failed to set msg fds.
qemu-system-loongarch64: vhost VQ 0 ring restore failed: -22: Invalid argument (22)
qemu-system-loongarch64: Failed to set msg fds.
qemu-system-loongarch64: vhost VQ 1 ring restore failed: -22: Invalid argument (22)
qemu-system-loongarch64: Failed to write msg. Wrote -1 instead of 12.
qemu-system-loongarch64: vhost_backend_init failed: Protocol error
qemu-system-loongarch64: failed to init vhost_net for queue 0
# child process 
(/loongarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-net-pci/virtio-net/virtio-net-tests/vhost-user/reconnect/subprocess 
[43438]) exit status: 1 (error)
# child process 
(/loongarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-net-pci/virtio-net/virtio-net-tests/vhost-user/reconnect/subprocess 
[43438]) stdout: ""
# child process 
(/loongarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-net-pci/virtio-net/virtio-net-tests/vhost-user/reconnect/subprocess 
[43438]) stderr: "qemu-system-loongarch64: -chardev 
socket,id=chr-reconnect,path=/tmp/vhost-test-9Y0NQ2/reconnect.sock,server=on: info: QEMU 
waiting for connection on: 
disconnected:unix:/tmp/vhost-test-9Y0NQ2/reconnect.sock,server=on\n**\nERROR:../src/tests/qtest/vhost-user-test.c:255:wait_for_fds: 
assertion failed: (s->fds_num)\nqemu-system-loongarch64: Failed to set msg 
fds.\nqemu-system-loongarch64: vhost VQ 0 ring restore failed: -22: Invalid argument 
(22)\nqemu-system-loongarch64: Failed to set msg fds.\nqemu-system-loongarch64: vhost VQ 1 
ring restore failed: -22: Invalid argument (22)\nqemu-system-loongarch64: Failed to write 
msg. Wrote -1 instead of 12.\nqemu-system-loongarch64: vhost_backend_init failed: Protocol 
error\nqemu-system-loongarch64: failed to init vhost_net for queue 0\n"
**
ERROR:../src/tests/qtest/qos-test.c:190:subprocess_run_one_test: child process 
(/loongarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-net-pci/virtio-net/virtio-net-tests/vhost-user/reconnect/subprocess 
[43438]) failed unexpectedly
not ok 
/loongarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-net-pci/virtio-net/virtio-net-tests/vhost-user/reconnect 
- ERROR:../src/tests/qtest/qos-test.c:190:subprocess_run_one_test: child process 
(/loongarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-net-pci/virtio-net/virtio-net-tests/vhost-user/reconnect/subprocess 
[43438]) failed unexpectedly
Bail out!
Abort trap (core dumped)


r~

