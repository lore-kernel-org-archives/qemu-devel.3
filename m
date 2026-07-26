Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EC9C531FA
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 05:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnrpQ-0005Cn-4W; Sun, 26 Jul 2026 01:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wnrpO-0005CS-Qq
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 01:55:10 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wnrpN-0000VH-CI
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 01:55:10 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-cb20b0a387bso252469a12.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 22:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785045308; x=1785650108; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xUM5ZXHD/oLWvFDoO+hHlLuSDfgeblRNtAYDQvQBs2Q=;
 b=sgov9Tjv9Yj6zjeTZu0VLlIow6chFznAFOdob0xo0F8Pytj/FZ9Ipp57+/DrKLr21D
 83+rwPKizxLEnd6ygj33d0K4YcbxtOReDWn8bsk6a/FPbbUmo/3NUF/+MaXK1LBtPG3l
 RDQDbfaj7za7hjmZmZdrAcZqfzop2xbXOMAbL5sePl7hfFWtX10XkfovMqFdtaBfDZhI
 eNRpmoAn/m6q+IccDIeX92VSDfFIdooYDg44XM9n9MjbSjHFCoL9nearmExni9zc5kaC
 UExagu5DPHtZW1UD7GNwAw1+ohqZKXbDt0z5GqAhKpF9StJ2Cg9tYUDSklOIyqLTNfSc
 EUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785045308; x=1785650108;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xUM5ZXHD/oLWvFDoO+hHlLuSDfgeblRNtAYDQvQBs2Q=;
 b=cUfrLfYY8qg4n4+SBIQVF0Ow6Z5kmXH8wlc3l9umDiBH0EaXL40+WeMM2TQPkSrvs5
 UlN2FkhPcSOsh49m+3wQcybCOK0tAlaUVzL/5lEMwQ3N6aegknG/GhHlOBw/PAi/xRo/
 v1ZtFYFygcBpregQmnspL8Nzk2ks+zTf5sHgCCHVvhWZCJlCrLjOy1yHcawLk8TqUF2e
 i/21fGXdAxzAIO+WQ5GIaReRPpNxjrt5ful7qN5SW8R6/Q1qjvtm57OzXRtvipMAERiR
 46OBcaxzcN0A3jp0GnFkJMTVTlOimG4YD1BRdEJmY9g98AtZF6zTutry4ceFb3NNWD52
 pz9g==
X-Gm-Message-State: AOJu0YxxzFvqeL84AW/Ck5vdLdeEZoBmvM7iSYLl5kkU32NEEm1PGv+s
 VFd2meYudPN70AzZYzkKFr+oAQvF8181I/UlawWIJx04bPVGt0Ir2ghW
X-Gm-Gg: AR+sD10rzX+MvEWjpAu+Y6bHDmzNv9sGknSs/mjPq9Woq3qDm114g8bYkwT83WlZuXZ
 yvgL9JHGbLmPG888pjstz1nc5VNT4Kfb+paulIPpADWuSiCJUVzdBbjf2NYG1jKOQINEqCalZAt
 N0KOgFcVuL4KU4+NiH+UGmvQdyFR9aEv+WZqr/7DWDAX51KJuYhXGJW2/9IRJP6nvGJFl+5DZ5z
 1SwNyJ6+b4eTRNtpl2dTj2xjwEJ7HHjMA2Yn3tYIBqx87+jU5OOhcDth8GvDZXFscrGSCaioOBT
 Ye/n3ndz6k6+OrOWBe3QeX2ytfDtpzwq2JKb1y/XsfnQs77fVriQYtQXeSogK8Wn2r3VuszFNBq
 gbmyvNt4Kfs5Ojbtxr+G+DbkF7yWXUM1vms1A3YmMayT12I1ASo4aqY0zMXrVBMXGise9zk9tsz
 FgVmMXPRgOPA0zP9xAo7qJdTxikzMDNmk=
X-Received: by 2002:a17:903:1843:b0:2cf:7dfa:7f56 with SMTP id
 d9443c01a7336-2cfde792b83mr33341805ad.2.1785045307775; 
 Sat, 25 Jul 2026 22:55:07 -0700 (PDT)
Received: from DESKTOP-7HME356.localdomain ([38.34.7.236])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc447f6bsm19200010eec.12.2026.07.25.22.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 22:55:07 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/7] tests/qtest: add test for K230 gsdma
From: Junze Cao <caojunze424@gmail.com>
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com
In-Reply-To: <20260721161335.73872-4-dingtao0430@163.com>
References: <20260721161335.73872-1-dingtao0430@163.com>
 <20260721161335.73872-4-dingtao0430@163.com>
Date: Sun, 26 Jul 2026 13:54:57 +0800
Message-Id: <178504529704.906524.5128555664916138089.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785045302; l=848;
 i=caojunze424@gmail.com; s=junze-gmail; h=from:subject:message-id;
 bh=7MpjXv6qCPx3zXPy801wbS7gVS/EmtI8CjqujWNQ8dE=;
 b=IDNd01fXNgki4OaXfz0inGNKABsxmcRzS+rWwxc5ClbiPA5jmN4gBKwSo2j0e1Ip8js8zvmVU
 DxOqd0kPPR2DTicKxWVyWWwjuLfu3rh2zkEFERGpLnM4b0DAxj+/tB8
X-Developer-Key: i=caojunze424@gmail.com; a=ed25519;
 pk=lnFIWNw+6CoDrHFIKUJKdgrRbvgAbQGcEFiVsIigOJ8=
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=caojunze424@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 22 Jul 2026 00:13:31 +0800, Tao Ding <dingtao0430@163.com> wrote:
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 56ff860e21..1b13a777c9 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -297,7 +297,7 @@ qtests_riscv64 = ['riscv-csr-test'] + \
>    (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
>     config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
>     ['iommu-riscv-test'] : []) + \
> -  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
> +  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test', 'k230-gsdma-test'] : [])
>  
>  qtests_hexagon = ['boot-serial-test']
>  

The new source files haven't been added to the MAINTAINERS.
Please update.
Other than that, there are no issues.

-- 
Junze Cao <caojunze424@gmail.com>


