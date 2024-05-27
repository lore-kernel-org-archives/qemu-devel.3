Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D81C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 12:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBZvh-0000p9-Ap; Mon, 27 May 2024 08:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jojing64@gmail.com>)
 id 1sBUOM-0008KG-8R
 for qemu-devel@nongnu.org; Mon, 27 May 2024 03:03:34 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jojing64@gmail.com>)
 id 1sBUOK-0002LN-4t
 for qemu-devel@nongnu.org; Mon, 27 May 2024 03:03:34 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-681ad081695so2015136a12.3
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 00:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716793409; x=1717398209; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jw+d+zreaVG0HWwbDpy9TPgRKSIWWaLMGiALDR88rQs=;
 b=Tlrk1a2hjU64JasiCkeNvXIvS9MXdUZPyEwy5wAOoi1mK3hdtTFflOyNadC+fsNh3Y
 8z2lN1nicxCftIEFnBJ2s3unaajergwHhO7X5jCr61nHRF7VWpyL2MEh0s1FzSU9UQos
 /MdOgEN1eq4CjwtAz8JEj5yYKAp8xQjPfzEXzYwqB2gA90DLdtGlSIqq2XKVgQA5Urw+
 I9jYEx1IcMB5SrM+aldI7TweRm2n+XsUf6gW2e+cpxFaxqrT7eLbDMKQk1OzwDUtEgC5
 E6FjWDiW9ez3tdvaWNPO0dwqLB+zziGSpPF5BJkIp8WE0V2KalpAlEqe43jBNg5yrPcx
 ii2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716793409; x=1717398209;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Jw+d+zreaVG0HWwbDpy9TPgRKSIWWaLMGiALDR88rQs=;
 b=t/fFTObbzz6sr4v2Yay9arDeDYo33UpGr+Q+OmFeltbOI3Odo6KRLGzJ+k82mrBzsK
 Z3eYg4vfKe/iFJ7xqepdH4P1r+eJzvYYk4u6JyYS8hoRxAVtuMjU5N23VO06pOnOhmAw
 BBbOy3EYq9CLereWX7UbB43IhxsO5+obMs4tDIJkZytP6seH9LW6LCsM5MU+neAENsuE
 +bH1TVUhhHTihbXqp40YVFfgnw8UlYSa9IOF9yy5jxM0H9mg9lKo/QlYD1lNOMqsKwWd
 Pp7PDJaLuebHabdXslYJMmn2ev0/JT1Cq+n/3o+y6cnYH+6aKnErIJGpwK5Epnot45aV
 d34w==
X-Gm-Message-State: AOJu0YwrS4aDcDqsSiCopuo95tS6hV0lG92yzSd3WT0VQzrizcf/pZkN
 ewyjwqC8k9xY2kQKmezSYFS/x2fz4S8C+JFqeoYmK5tn7n1h0OQcMOchCw==
X-Google-Smtp-Source: AGHT+IHb8DSJCTlEnF7nm7gM2l5UE6KJAu4fFB5F8Ed634J+SYfNf77ggkQSBF6mzhzz9TcgDujl7w==
X-Received: by 2002:a05:6a20:9707:b0:1b0:2cae:4622 with SMTP id
 adf61e73a8af0-1b212f0ea28mr7563046637.42.1716793409055; 
 Mon, 27 May 2024 00:03:29 -0700 (PDT)
Received: from ?IPV6:2001:569:590e:4600:1ea1:182:f195:fb52?
 ([2001:569:590e:4600:1ea1:182:f195:fb52])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fc05ab4asm4322102b3a.59.2024.05.27.00.03.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 00:03:28 -0700 (PDT)
Message-ID: <8b639179-e567-469c-bd04-ee8dee12d7d2@gmail.com>
Date: Mon, 27 May 2024 00:03:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org
From: Jin Cao <jojing64@gmail.com>
Subject: block snapshot issue with RBD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=jojing64@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 27 May 2024 08:58:19 -0400
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

Hi,

I encountered RBD block snapshot issue after doing migration.

Steps
-----

1. Start QEMU with:
./qemu-system-x86_64 -name VM -machine q35 -accel kvm -cpu 
host,migratable=on -m 2G -boot menu=on,strict=on 
rbd:image/ubuntu-22.04-server-cloudimg-amd64.raw -net nic -net user 
-cdrom /home/my/path/of/cloud-init.iso -monitor stdio

2. Do block snapshot in monitor cmd: snapshot_delete_blkdev_internal. It 
works as expected: the snapshot is visable with command`rbd snap ls 
pool_name/image_name`.

3. Do pseudo migration with monitor cmd: migrate -d exec:cat>/tmp/vm.out

4. Do block snapshot again with snapshot_delete_blkdev_internal, then I get:
    Error: Block format 'raw' used by device 'ide0-hd0' does not support 
internal snapshots

I was hoping to do the second block snapshot successfully, and it feels 
abnormal the RBD block snapshot function is disrupted after migration.

BTW, I get the same block snapshot error when I start QEMU with:
     "-drive format=raw,file=rbd:pool_name/image_name"

My questions is: how could I proceed with RBD block snapshot after the 
pseudo migration?

