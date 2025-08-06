Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DF3C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 11:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujchS-0000gN-0k; Wed, 06 Aug 2025 07:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1ujchP-0000d2-2A
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 07:52:51 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1ujchN-0003cB-1p
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 07:52:50 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0214C3F11C
 for <qemu-devel@nongnu.org>; Wed,  6 Aug 2025 11:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1754481165;
 bh=N1asWGi3iDkCQLFiQjAxZtn2dhkTpfRl6Yi8ctQtPzo=;
 h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 b=ZZMlXVI/sY8A8SNzEeKOijs0iexwwZkyYJvQROPrjRS453PR431MlUZfsNjSGh20R
 tjZXlUWUumelZoGPCQzDX8U6LnL+mH/VvW0M5xSqadZjbBQ0AG9QVSvrUVjoLKDj/q
 3SLYKI8k26EW2fKRcL8e/fZ+8o3RYCTQHiqUv74tzz9xbiBPl0AeKcA4YeRxKb10U9
 gt2T4ctPZg8QrXrOnHOMzdSBvKaqyoMMRY6raiWCtDh4WRjsSSvXEmrRSgxDNz2JCk
 5GA+jJKXWGALeAInN2WzOSWRtByrn54RQVHNp7Tfa4FoQozzZcCDZxWepLZYgnT1Ut
 Q8ZK2FenSv1Vg==
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-6155a2c8365so4804642a12.0
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 04:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754481164; x=1755085964;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N1asWGi3iDkCQLFiQjAxZtn2dhkTpfRl6Yi8ctQtPzo=;
 b=ghXuMXX4k71OjQFxMlpmQBk+hTpkXWbsHaoMIkvccg9YFJB9YHCsxzb0c6+zelHA6C
 McWDPsA2VEtQt5SfuNuyKPTAnfv9ZF70h6FzAP/41mytTgzN6QFMHwYXocAi/B5vfNvs
 gWYfo8QEJj+GHhqpjqIi1VF1/usMPpI5JZ93lpIVc9Dy7Lx7CJUxHDC7XVcE8aOLPEOL
 yIkMa6UpCa7HdIja9qbtVFiNn4yxrSUAw+TPXpUFE60IwrYMgZy+5O94fnWF/X091hk2
 6Kyl3JDB64PgtWNkygUto6ReDC8tjqGmQLTBmCvUrxfDgsJbpl+jFiC7BRzZi4K/azk+
 26lQ==
X-Gm-Message-State: AOJu0Yz9o29v92pm0FWl3pPpUct8iunKXVTmfQA4UjCGjvV8DCA9z9J1
 +DFzOXqHMEedWPQiSmIN3xwSL6jBD1H6mueRdItefl/6Ja9f2IzYl2LoWNVHQTvxpkDFEdaL8/y
 5IKGu0tRR4AZiByQDl//S4qPe/cVuM3jTB8rBrDc64uZ5aKNEbtclJBQ92aPDv4KbIAay8S4u0J
 FgrOAnMqaduOhgU57rX1uNjjh3Usu49bXWHVSUUpe2jM9b+doCP9xtLneuqw==
X-Gm-Gg: ASbGncs1aUrknhjp8j4gbwR6O3AJnzaGKxGbLdJpJQZxfY5j7AJUJxibOA5MdcMUSQm
 TaBaaCn2VfgzWiqOniIezUTfRQFlhkRyUGpz+VYs2/afrBpXSEtJWn1Y5ED4gnNlHQYsWXR7kBm
 H9Ndqh/7f2u4yS+eXeSvxW
X-Received: by 2002:a05:6402:2111:b0:615:a253:c7dd with SMTP id
 4fb4d7f45d1cf-6179618a22amr2335108a12.27.1754481163943; 
 Wed, 06 Aug 2025 04:52:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGedOIDlp3U3nQ4Dxz2Q4hALUTHzMTfwXZhrI2/PBlj9DhnnT8A2ZndBgxB5/BJgLHO9yHULtr5EJJT5jl+ues=
X-Received: by 2002:a05:6402:2111:b0:615:a253:c7dd with SMTP id
 4fb4d7f45d1cf-6179618a22amr2335086a12.27.1754481163382; Wed, 06 Aug 2025
 04:52:43 -0700 (PDT)
MIME-Version: 1.0
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Wed, 6 Aug 2025 13:52:17 +0200
X-Gm-Features: Ac12FXwiUkLU9Zvkff8GNJLDtLGtiO08o6xC6SVqjXuJHUw5IsWNA9psVtNPiB0
Message-ID: <CAATJJ0+Qq3ksRmNRDrGQLVHQ=XnsnFHxCNxUhjJfNfgwUKkDPQ@mail.gmail.com>
Subject: Issues with pdcm in qemu 10.1-rc on migration and save/restore
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=christian.ehrhardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi,
I was unsure if this would be better sent to libvirt or qemu - the
issue is somewhere between libvirt modelling CPUs and qemu 10.1
behaving differently. I did not want to double post and gladly most of
the people are on both lists - since the switch in/out of the problem
is qemu 10.0 <-> 10.1 let me start here. I beg your pardon for not yet
having all the answers, I'm sure I could find more with debugging, but
I also wanted to report early for your awareness while we are still in
the RC phase.


# Problem

What I found when testing migrations in Ubuntu with qemu 10.1-rc1 was:
  error: operation failed: guest CPU doesn't match specification:
missing features: pdcm

This is behaving the same with libvirt 11.4 or the more recent 11.6.
But switching back to qemu 10.0 confirmed that this behavior is new
with qemu 10.1-rc.

To allow you to have a look I isolated it from the test automation and
simplified it to use save/restore which allows you to see it on just
one machine.


# Steps to reproduce

$ cat testguest.xml
<domain type='kvm'>
<name>testguest</name>
<memory unit='KiB'>524288</memory>
<currentMemory unit='KiB'>524288</currentMemory>
<os>
<type arch='x86_64' machine='pc-q35-10.0'>hvm</type>
</os>
<cpu mode='host-model' check='partial'/>
<devices>
<emulator>/usr/bin/qemu-system-x86_64</emulator>
</devices>
</domain>

$ virsh define testguest.xml
Domain 'testguest' defined from testguest.xml

$ virsh start testguest
Domain 'testguest' started

$ virsh managedsave testguest
Domain 'testguest' state saved by libvirt

$ virsh start testguest
error: Failed to start domain 'testguest'
error: operation failed: guest CPU doesn't match specification:
missing features: pdcm

Without yet having any hard evidence against them I found a few pdcm
related commits between 10.0 and 10.1-rc1:
  7ff24fb65 i386/tdx: Don't mask off CPUID_EXT_PDCM
  00268e000 i386/cpu: Warn about why CPUID_EXT_PDCM is not available
  e68ec2980 i386/cpu: Move adjustment of CPUID_EXT_PDCM before
feature_dependencies[] check
  0ba06e46d i386/tdx: Add TDX fixed1 bits to supported CPUIDs


# Caveat

My test environment is in LXD system containers, that gives me issues
in the power management detection
  libvirtd[406]: error from service: GDBus.Error:System.Error.EROFS:
Read-only file system
  libvirtd[406]: Failed to get host power management capabilities

And the resulting host-model on a  rather old test server will therefore have:
  <cpu mode='custom' match='exact' check='full'>
    <model fallback='forbid'>Haswell-noTSX-IBRS</model>
    <vendor>Intel</vendor>
    <feature policy='require' name='vmx'/>
    <feature policy='disable' name='pdcm'/>
     ...

But that was fine in the past, and the behavior started to break
save/restore or migrations just now with the new qemu 10.1-rc.


# Next steps

I'm soon overwhelmed by meetings for the rest of the day, but would be
curious if one has a suggestion about what to look at next for
debugging or a theory about what might go wrong. If nothing else comes
up I'll try to set up a bisect run tomorrow.

-- 
Christian Ehrhardt
Director of Engineering, Ubuntu Server
Canonical Ltd

