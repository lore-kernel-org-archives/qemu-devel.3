Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6B6C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 17:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBeaY-00064a-UU; Mon, 27 May 2024 13:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jojing64@gmail.com>)
 id 1sBeaU-00063w-CM; Mon, 27 May 2024 13:56:46 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jojing64@gmail.com>)
 id 1sBeaS-000377-QT; Mon, 27 May 2024 13:56:46 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-681bee6bb13so2125716a12.1; 
 Mon, 27 May 2024 10:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716832603; x=1717437403; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ETuEu4+9waDFh/8QAS0HJsAQaBcePV4UZWL5Q40Ms4U=;
 b=LqwS8NBjysFU6iDOhVSwbUPTRdCK/oLs0iSge8KqgH6mHSi9rzeakG09lWRnErn7fg
 LgAZCraP/6XCclKzAtdBPE0vwoyXsqxvPfu1UmtSCPZPLtplmvS4nUQqilqH0j/n+3Od
 2vihnWwdCNOniqhJxRPNiXiexRxOKJ3Jjkat9g4GI+rJ5DD8NclgTqPMvjPpZhjw6PVA
 RutX/hd7yjBgIWanbpTpbRsRVOpCebyGF5b/3p8J6ZkD13WjP0ELPA6hBtJzhuUc+LbL
 aUice/Bu+0NV2+pBF7smkoEZLGGPmuz1BQS7khnTQXtMVN1QVep9A2Fw2sSavqOOJteA
 P4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716832603; x=1717437403;
 h=content-transfer-encoding:in-reply-to:cc:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ETuEu4+9waDFh/8QAS0HJsAQaBcePV4UZWL5Q40Ms4U=;
 b=nqVo1tQ/GM9nULpRY441ZNkcnYy0+9FdoBddVDZt5zP/zQmmx7yekWTC6HV9qfZ0hF
 YXsm4nvQyfoqXytwgonILBKOIbOAY3FhcoDQlctfqW/Dtdhine6KsI1Jycj1mS/URRP/
 x+h9bx9Mvml3CdgTNCb1VErcn854Im5vilYESyPkqOoGKIItS0DCBJgM0DJIO/ssB+gv
 9i3S3vmaSJOwdcQzs8biYj+sqvNevCICD+Sv5bJ5YGgXRaJ4mWVXv4MUVXM5Kb4b5jdY
 89f4waxFotyXbtde4BUh+1+8s3x84QpZqLEkTtfP1cV0OQ8weFR8AaPZrqlNlV2RfneI
 iiUw==
X-Gm-Message-State: AOJu0Yzo9isNwqfJFUjIQPGB83yqyq0MMyNctKYTJqzemJcfAxxZPVvm
 bknAsmhnoh4IeX6yC2SiWtf9RAlkn+x8ZdshIqioHntAO0fUlUUubuuy/A==
X-Google-Smtp-Source: AGHT+IHSk06Y/8vFXBESHLxExKu1Dgv/V/X9isVElPBAeKRB7ZeuPfMtGlCIE33rwvP/BwW8EU65DQ==
X-Received: by 2002:a17:90a:3d01:b0:2b0:763b:370e with SMTP id
 98e67ed59e1d1-2bddcf04389mr17911141a91.18.1716832602622; 
 Mon, 27 May 2024 10:56:42 -0700 (PDT)
Received: from ?IPV6:2001:569:590e:4600:1ea1:182:f195:fb52?
 ([2001:569:590e:4600:1ea1:182:f195:fb52])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bdd9f4c604sm7926072a91.41.2024.05.27.10.56.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 10:56:42 -0700 (PDT)
Message-ID: <0e01a8e2-a543-4524-939c-05413fd99e86@gmail.com>
Date: Mon, 27 May 2024 10:56:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: block snapshot issue with RBD
From: Jin Cao <jojing64@gmail.com>
To: qemu-devel@nongnu.org
References: <8b639179-e567-469c-bd04-ee8dee12d7d2@gmail.com>
Content-Language: en-US
Cc: qemu-block@nongnu.org, kwolf@redhat.com, idryomov@gmail.com, pl@kamp.de,
 hreitz@redhat.com, peterx@redhat.com, farosas@suse.de
In-Reply-To: <8b639179-e567-469c-bd04-ee8dee12d7d2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=jojing64@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

CC block and migration related address.

On 5/27/24 12:03 AM, Jin Cao wrote:
> Hi,
> 
> I encountered RBD block snapshot issue after doing migration.
> 
> Steps
> -----
> 
> 1. Start QEMU with:
> ./qemu-system-x86_64 -name VM -machine q35 -accel kvm -cpu 
> host,migratable=on -m 2G -boot menu=on,strict=on 
> rbd:image/ubuntu-22.04-server-cloudimg-amd64.raw -net nic -net user 
> -cdrom /home/my/path/of/cloud-init.iso -monitor stdio
> 
> 2. Do block snapshot in monitor cmd: snapshot_delete_blkdev_internal. It 
> works as expected: the snapshot is visable with command`rbd snap ls 
> pool_name/image_name`.
> 
> 3. Do pseudo migration with monitor cmd: migrate -d exec:cat>/tmp/vm.out
> 
> 4. Do block snapshot again with snapshot_delete_blkdev_internal, then I 
> get:
>     Error: Block format 'raw' used by device 'ide0-hd0' does not support 
> internal snapshots
> 
> I was hoping to do the second block snapshot successfully, and it feels 
> abnormal the RBD block snapshot function is disrupted after migration.
> 
> BTW, I get the same block snapshot error when I start QEMU with:
>      "-drive format=raw,file=rbd:pool_name/image_name"
> 
> My questions is: how could I proceed with RBD block snapshot after the 
> pseudo migration?

