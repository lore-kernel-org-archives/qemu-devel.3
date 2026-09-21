Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FEDC982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8d8I-0003sv-Co; Mon, 21 Sep 2026 08:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.boutry@canonical.com>)
 id 1x8bmB-0005pC-NN
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:01:35 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.boutry@canonical.com>)
 id 1x8bm9-0008Kw-Bh
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:01:35 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4EE843F427
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 11:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1789988490;
 bh=VjgLxxI6yTKl37LYDqar6DpHNFBpEGIpsKrMQ6/0piY=;
 h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type;
 b=EsBen9FxSgLpnsKZb8kAN2L5Fhj2yChtkdHUp/BzygSxEXpksNa0/nLmR6R3AoILl
 g14kf+GtLru/bDzXtJR0eAQm2veialLPbedo6jHZ+2TN21kzDZJrBH3G9WRZEhn3gx
 J14dRJenNmWJzlR6NNg3leVOcVENaUAY/Zs7EM/uzn8sWZZ3NP2LxF1Rd25UTtrdte
 floz75o94pLd2ztVXM2CEOCL0M+QIrP2BkR13W5vuuIz5+PBPQnEZ+Y5IwqW5bNEhj
 6nCXHRqe49+Jfz5RylwgAe/ONZooeswN9Gcl5sAepZe0pQ/3SfrASIKJ4bOfihgroe
 OWgSdV7NW1apINZclp8HnoZshX0tAtw6XIq71wC1LftVWvb4Ss/5Uc2bxglBGTepKb
 eJd2dfVAhfEAnV53Ys6Mdh7/kR7CzJmnG+3UKbsQ1Rdfa5nEBe5xhqZjr/MQFRVbqg
 0EoODw4ewAiLM5rEWktu9cWSIJnbVjqbaSwxvPh91ikX3DOs0aTK1AC1ri786PKfQY
 Fc0ZPqUK6R52qQxQMLxqZ3G+wNwo+EwJH9yQnsZcZwPsbwd1teeAxQwL2AFW5nKTtp
 qe5xDAtMNBDjaPooKzwNDSbOqy0NOYV0SxsusA8QIzQXjKOwj+vCwF7IYfnkAhaPDw
 ZM74tDAbijyPYLk8S/Uyh8+A=
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc73ab90ae7so1847561a12.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 04:01:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789988489; cv=none;
 d=google.com; s=arc-20260327;
 b=AiSqB9GhLMcWCLejssJ/FQ8CnKMEoEQzCPYqCcbjnTs+hDnW2QhfFWnSC/3MGsur9h
 MEgmBgIjDKRbtsZfS7rdVZpJaVB+HxJCUNB3PuL4IosdUe7Hq1nLulYK/ZxayVkQustA
 O7Y2FIk9nrtR7E+J6Xy070zydu9lQZEkAgGVmiuFcVXnFtswmAe+BZEBUxU7qaGEdFHT
 K6mwcgnuOYvkrG9hDGanWx9gBJlnDTcA9ckx3QfC/VBiPeio2cmCmjR0hgUlFb3J3SOY
 TtVanYViuS5lEMB9og0Vh6DX6XsnYhyVXoA9GUhXlnyfGSH4i3C0yIDRyM8RJP+wItn9
 3/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version;
 bh=VjgLxxI6yTKl37LYDqar6DpHNFBpEGIpsKrMQ6/0piY=;
 fh=hUk9p/DWEMi90rHHsuT1xE4tEE2OCwfT7Nl3NHKH8IY=;
 b=pkT6SRf4USFzZcBHsk0yZEyP7WotVNzpZQ3HFztXjaPkq908r08r8TM0pKjNaEOHFD
 RBDTva0cc8q/GqLZY8Ud3O/CPfpnj6FfaaPcBnrFmjnC3JxfMt6YT40Ga5ra+1kuwhf+
 Np4qf8k8mXA/ClblUmVSFcRkjAWJ1AnggF+WMvnU6GtFy+iHXHBd7ym+E3po7EYPgfKU
 XWEcGGsxGz47fUTr/GkBTx9qBtx2q1feJOAUUbwiIBFqfa7d8SpW2sAfGhApZKEGRflc
 lT8wrfzuUSlvO2DOvv5UNdHLCB0hxVWu5w9E8d1vUE/lqcoFlLd9HKGgXrr2yddjuFBn
 g3XA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789988489; x=1790593289;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VjgLxxI6yTKl37LYDqar6DpHNFBpEGIpsKrMQ6/0piY=;
 b=FL9S00HMkRO8ZJsZXsB4w4d1jX4eXOFetpcqgBxuZU4DO4Qx0AwgagRHWrnX0t9DyS
 /aYKXC+muOHGu8Bg5CXU5knjjLwNjCwSsvtjHBf2taH9Bbq41fS/mOdOtHY18o+s98Kr
 4Nh8v1R5Lqh+gBE7zSlidQntTPNup71NnUym98l7RozpRYKTcCiPdMxF+oE8Z0pXqmG8
 MIMJEp4n3d0gb/z4CAdMmaEAKL1PrYMtL5LgYoi4CCcAbWCWHP5L9daksAvZzjiDLWrb
 6X7GN6Vo7Adzd/r2+agv/QR7fx5tnhUlpqLINnSOG+SpYxfKJDKMF9pJkT0NkKcr/ldQ
 /mVg==
X-Gm-Message-State: AFuF++k4No26x7FQrLDa+E3KcTsv6lRaX1KnDN6GlIpZhRZinDi+g4cZ
 4fg/C8u6y4yJERWOLG0+ug7Ffb8Lauid4EwIz64h1zp+iMbJjsWqG+x2c3RoY40qi1Q2clMnpcM
 plFA6eaDA3O5+xoKEu1Fq3DckrP9WEBc+3HRpLBUCwpgbdOfl42Co54TchU7PmRT7M1wIfmcCPm
 BmBZZPfty9wojZDccM3ulXFl5KBp53KWf58eR9n2+3OCMKPB2rMnzKqdONMA==
X-Gm-Gg: AYBFou0NGMbtyWIGmqOTTnhQ1Jw0HfiHEMKFHHpLcXgzGMXI4XNZ9XoJox1zZCyhJFC
 Yaflv2m4GNuPU+pQ5IMODV+6BG0Gi3hajoGoN5mza+qkEM348EEqKXpECR5zrmYhFyj3rrsJ7j1
 ZXk8crXc19piZYIdv+Qz+ptpUk3/jP3MS+9WXDNDzgySK7IfSQjzQ7uL03YszG/iA6kd5uhITCc
 GSoUjABnvn7NWt6kJ21cJpM0WDX6Xj9lsyUrDsLBBZZzCmW2aco01L1xAxyiBIpX5sr8qpnRSTw
 7skCnvCy1KrXDxMdY1OtijsF8Z1Oq0YVQ4zzl78W2SUWtE8iw6LjT4HB6nM=
X-Received: by 2002:a17:90a:bd6:b0:39e:6a81:5a96 with SMTP id
 98e67ed59e1d1-39e6a815de4mr7389103a91.42.1789988488714; 
 Mon, 21 Sep 2026 04:01:28 -0700 (PDT)
X-Received: by 2002:a17:90a:bd6:b0:39e:6a81:5a96 with SMTP id
 98e67ed59e1d1-39e6a815de4mr7389073a91.42.1789988488148; Mon, 21 Sep 2026
 04:01:28 -0700 (PDT)
MIME-Version: 1.0
From: Guillaume Boutry <guillaume.boutry@canonical.com>
Date: Mon, 21 Sep 2026 13:01:17 +0200
X-Gm-Features: AcwNN1XmTEQTq4Ir_PDbR6JibB7VsjKZQdDm79hvb072NeVvtfPTa1B4Bx9_LUk
Message-ID: <CA+BajB4XxyRgT+EKupVZjv1zEMCfgr1mebCzAMbEBZBsPaCx3A@mail.gmail.com>
Subject: Re: [PATCH v2] io: cork TLS writes to avoid small TLS records
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, peterx@redhat.com, jmarcin@redhat.com, 
 farosas@suse.de
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=guillaume.boutry@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 21 Sep 2026 08:27:53 -0400
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

Hello,

I tested this patch this weekend, and saw that it significantly
improves native TLS migration.

In a sample example, while trying to migrate 4-core, 8GiB VMs with a
40Mbps dirtying rate, I observed the following:
                     Completed   Total time (s)     Throughput (Mbps,
min/avg/max)
                     ---------   --------------     -----------------

stock   tcp-main          10/10      11 / 12.4 / 14     4836 /  5555 /  6304
stock   tls-main           0/10     225 / 226  / 229     268 /   280 /   292
stock   tcp-mf4           10/10       4 /  4.3 /  5    15076 / 19761 / 22413
stock   tls-mf4           10/10      22 / 25.7 / 28     2183 /  2436 /  3204

patched tcp-main          10/10      11 / 12.5 / 15     4691 /  5236 /  6386
patched tls-main          10/10      53 / 60.9 / 68     1021 /  1068 /  1177
patched tcp-mf4           10/10       4 /  4.3 /  5    16167 / 20270 / 22393
patched tls-mf4           10/10      12 / 12.1 / 13     5514 /  5704 /  6085

(mf4 stands for multifd 4 streams)

This has been compared against the QEMU version currently in Ubuntu
26.04 (1:10.2.1+ds-1ubuntu3.2) and the patched version
uses the resolute version with only this patch applied.

In another run where I sampled perf data, I observed the following:
                                                      Stock             Patched
Transfer rate (median)                  315 Mbps       1163 Mbps
                                                     (39 MB/s)        (145 MB/s)
core-ms per MB                           25.4                 6.9
bytes per sendmsg                       ~3.9 KiB          ~17.4 KiB
sendmsg calls per MB                  ~254                ~58

We can see that the average bytes sent through sendmsg went from ~4K
to ~17K, and the overall number of syscals has decreased. (The median
transfer rate jumped from 315 mbps to 1163 mbps).

Thank you,

