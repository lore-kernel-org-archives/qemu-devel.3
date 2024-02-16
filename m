Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8192C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 17:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb2Ld-0007KZ-2D; Fri, 16 Feb 2024 12:50:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1rb2LZ-0007JX-Mh
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 12:50:01 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1rb2LX-000150-Dt
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 12:50:01 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-563d32ee33aso1711863a12.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 09:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1708105795; x=1708710595; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TamnEb5MKguc0sTG3vLEj4iQF8pApqTmVaP3/vf2pl8=;
 b=gAdHwMUdXZO0hYS+BLfy7Kr9MA2Lo3iZSM9CJtKzYRH/9FG2l+q9l2/qtjGeknaByV
 D4rArdWqQJ8dHR/6xtXPqQk2TgHnVm2mSXsYcs2AZ0Mxb8egmgO3KJCAnv1/qVP1Nirg
 i375oCWRBqPZXrNZRdv/5PKnpVLBG7fGUZw83G9/s8QlR3LjZC6/vK+54mOfKZp69YQ6
 S5uS9hPBrFuUifvJkTtfbjUCauv58lTgCgCcMtEjrAIqhq1QnI2IKsNtmKpSWycVrlyV
 Ax0DrN+goG0/svDQpYK9NiXxUDwf+htJ8hA6SCErcrAMnnCJEW4VMerxNuZWngN7nOt0
 zH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708105795; x=1708710595;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TamnEb5MKguc0sTG3vLEj4iQF8pApqTmVaP3/vf2pl8=;
 b=I/W0vZjnW4cjNWMyI+r8Fg0Zz8MfwL4E7WgUSelr8vLv9WlPVlw9+wkj9uhVN1+6vs
 JQf9OZwGSVeDeCtyPrSKTw2/UpOrMsiL0EQzwtLkrka5VdkYdonrJ9NxoDcYAfJ614zc
 rqj2xOwndXXhg/A9y6zdbZUJ3mPcpRV+jlLdG8ujNvagakm3hSuxJsHQHbePU5oEyRy8
 14zLzgfk0iWuNSbEXhc3XN2vece94SksgiE3xPhJmu/9mv7C7/86xS0NGv28U1xcPqDU
 lJdGY449xfcVVAlft/OXk9gbHU6f+u62uEt5sQBvpajOrPUic+HYlUzYVLQCEaLAkgGN
 b6Gw==
X-Gm-Message-State: AOJu0YzXlW/MlKjgteUffV1WCGkr1Dd9r/w14f1HsZxpblD7hrp/Pnya
 8p+BI/lGutHmsPp3irRrcMMNtwDOklczYh6YFsl4fQaUdR23667mJWoshBdul4XG5cZu8gp74NA
 546zMuYL6Zpm9mYE57ky7sG8TOERTdPqIQg0DmzH3FOYjJ8M448Q=
X-Google-Smtp-Source: AGHT+IF1KNKNxhkXTlTWtQusRQURSBzWdVEJMd5t3J64rIBD3HW982aRJwktEtuvx23s7rt0km+uU3iqhhM0QbGSvOc=
X-Received: by 2002:aa7:d354:0:b0:560:4e74:9cf8 with SMTP id
 m20-20020aa7d354000000b005604e749cf8mr3894602edr.34.1708105794892; Fri, 16
 Feb 2024 09:49:54 -0800 (PST)
MIME-Version: 1.0
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Fri, 16 Feb 2024 18:49:44 +0100
Message-ID: <CAMGffEm7pet7rB8MH_VsY0ToZ3N+2Kd5HzGzyfgkLgs+G5_n0g@mail.gmail.com>
Subject: [RFC] Convert VMWARE vmdk (snapshot) to raw disk
To: qemu-devel <qemu-devel@nongnu.org>, fam@euphon.net, kwolf@redhat.com, 
 qemu-block@nongnu.org, hreitz@redhat.com, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: permerror client-ip=2a00:1450:4864:20::536;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Hi,

We want to convert some VMWARE VM to KVM, and to reduce the VM down
time, we want to do it in two steps copy approach:

1. a snapshot is taken
- source VM continues to run on VMware => diff creates

2. snapshot is available for download as vmdk
- we need a software to copy snapshot to target VM raw disk

3. source VM is shut down
- diff is available

4. diff needs to be applied to target raw disk
is qemu-img able to do it, or is there another tool?  I saw commit
98eb9733f4cf2eeab6d12db7e758665d2fd5367b
Author: Sam Eiderman <shmuel.eiderman@oracle.com>
Date:   Thu Jun 20 12:10:57 2019 +0300

    vmdk: Add read-only support for seSparse snapshots

So it seems qemu vmdk already support the seSparse snapshot format,
but it is unclear for us how to connect all these features together.

In short we want to
1 vmdk => raw (big size)
2 vmdk delta => same raw disk (later time, with less content)

Can you give us some suggestions?

Thx!
Jinpu Wang

