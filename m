Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B7E606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 21:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Awx9d8Q1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLoK4-0003Zk-UJ; Tue, 27 Oct 2026 17:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLoJn-0003YB-QR
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 17:02:53 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLoJl-0003ik-6V
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 17:02:50 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8b0f59a5fdeso2674797b3.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:02:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793134961; cv=none;
 d=google.com; s=arc-20260327;
 b=IP28G9bod2cx4F/veNdQ9JUMOKUHGpdR8IjxCa7AqBOSPUYMw7n4oFIbYNVypSq5s3
 wTx7uEzwL0unvP3g1qQcowSUYbN6vvhXF1HAHUh5/eok1tARh9k681onI+MEcvH5Timd
 TdZ/eBNTRNUzD6IM6lQ8pvirhdzMBnBgqdo993EZov6bl1ZyjDZAdkcnsvQlpO26PjUx
 MY6yH2wxYSQyScd8SdiJwwEBY2lYBYJntfjiErb9u6kl7ttmUNHFGZ3OEf4eT7m+2eOe
 HEvUMm4ydNKwjGhZM/tCc39mwClSrRfaNSucxQHjcRAG4rTSVy2eKl03uZR7nKIAdX/s
 Sl+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rAfIrFUdkNWvcyJdJVmh15wjPl04VbU10M3J4P7mUXw=;
 fh=6kA7zD1fEbjvrCBaI6MtrsnL+a6Nmdg7AZiPql1yqgM=;
 b=R/2X7jrnOe8FrnFqpjzerOdIuQKUZXg3YuaxghxnjnjCjJQ8suebA21iA69nu3Js0l
 CMb2DD6oLBWjEKlDBW+1458FKzfHjmcaYL9/pGZbnRjZYYCxx/DLUsijb9LnVUMIqiXY
 IfOtZh2lBjyXv6PMUYQzuF5U7idnz/TqIc2v++vVjbwfySVSj6/Fu5ka/gmUinjdP60D
 JnSNl2bNhoNi/eK3UxZiJRojQW7d69Lv3zBc3zDAXPTzUhb0DSgKAXFR3bIXYNNreLZi
 QjlGfZ2ng/5uQ1uuaYw5GUtp+VLBX4e04AxIRWKW2L5Gh4YJvkUrZls1d20ohI9quTPa
 /low==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793134961; x=1793739761; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rAfIrFUdkNWvcyJdJVmh15wjPl04VbU10M3J4P7mUXw=;
 b=Awx9d8Q1ryP9pgWXf/WMyvciGM6yLmIq7fGKjIxrN6ssdvzwrRfsAXwPvWztCRHcO+
 5ZR2UvxW+qge1B3r6R+CjT5hnJIjwWz76wiBKajbGvJbQiZHxfqAxi4b5KW8KIne93Hk
 CpoUAPg4t65Xui3n8ipbBFsDca0QW1LWLwB7maT+U0ZzRMW4PS2liGhLVIrj0yh5s1rP
 tEHlTDqbIgcK8pdbNYCloFmkmlitTIa7OmyIfHTW5DLGo0sSKp8ujUPSOWq2DlnSSgKD
 UAcHVDmr69cFjO89We6+MyCZR6zF64AKQXuVs/aDgjio2zrAFGagDc5Iq6kYoTTcgMJv
 /SmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793134961; x=1793739761;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rAfIrFUdkNWvcyJdJVmh15wjPl04VbU10M3J4P7mUXw=;
 b=s2cCxCWmD7553y9hAkye6JjBbmvA+LkrBA+2BRWxOj2697tZLZc0AxwtXnl3o4Y1A2
 t+3XsdZCNNCKjkmndEChbfogEj1UCXJPgOzFSB71m3z/G7rlg676aMDjlQkOJD5shu8E
 h2NJ3pHwcgWnGDHUpMlsKwIlhWVqGYVPxCy/t8uY4mip96vXTTVxGXqc1XsWY3Gum9MQ
 vbuRkM6Ng1+/tqOH6A4Dr9K+rtEn9kuPGJeGRiD497EbtoOhLgyr9lS2By5XEnf/EN1t
 qDuX9le4/tfoRBza0hiqtzysCV4wcb3Apzfd6JqnvZi/5PuelngZXHAImuN+NruwcFgw
 HfTA==
X-Gm-Message-State: AFq9FYIqZRWd7P2SBau7WXpK2cLdeJ9V7sxawdgzk4PzKBLwN8a36aoT
 YE1jSjQHpvW7N1Wk9tNqpksbLNw2Y6T0Bjz2TDsaECrdwyeFMUmfGBJ1ZRGM6WBZluhf+SZ+CNU
 Mc14SmvJucmaqWMxIiCRLcwrX7dqJ0qXiL+I6a8oS7LWv+vjVr8YjdMEV8w==
X-Gm-Gg: AYBFou1zYmdJaqmDJQGQZz26QoXeMrbDxnxjhZDusAqt6NCbQVmq+oAIxCA60vlPcHq
 GYdJRj4IAkr2FVOfdgd9NXmpImPYTUzUEwpJF9ROVe8OKR2uxQn4A1oI6LbzjGrt4GeVNLAaoq9
 7OtxB1Il25bpz4+fm4WoBjLax7fDT/iLQvoppxa/zfW5iHTUCbIprv/uCzoXVla3XR762vNUj+L
 xbJwou5Hw3zn53zllkxfeps6AH4MNf71K5X9Wf1EvQuzTd9uqLdHPmL4fgh5n4tNY5xjBBFdYPR
 WKxcUOB92Tax9BF3W82nnD91WHkIlL6mCUu1pCo5UhKxM9tCjqe/W1JeINQGDSGBgjXGPJMA0MT
 BhtSFMmNDeLeHKiM1VNCDk0hzebhtT6tQU91LwT+XZc2paFDqyk416II2iYa/X3SCCBThTFnvgc
 wxmgGRlsevYESh+peKe7UA
X-Received: by 2002:a05:690c:9990:b0:8a0:76e8:c738 with SMTP id
 00721157ae682-8b1b55b2713mr2217277b3.0.1793134959549; Tue, 27 Oct 2026
 14:02:39 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027174625.4025878-1-peter.maydell@linaro.org>
In-Reply-To: <20261027174625.4025878-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Oct 2026 21:02:28 +0000
X-Gm-Features: AclHuK8B14h-yW6pW10DxMGr4StvblpQ8afaHxc8JdSqBTl6fD37rh92X6JTDU8
Message-ID: <CAFEAcA97DJoshh+34HPdjbKERQftqSZYF7+3Cv0r=qCqX9TjbA@mail.gmail.com>
Subject: Re: [PATCH 0/4] net: Consistently pad short packets for all backends
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Jason Wang <jasowangio@gmail.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Oops, I meant to cc Bin on this series as it's the result of
a previous thread on the topic, but forgot...
https://lore.kernel.org/qemu-devel/CAFEAcA_UhmCxJc16CHE=4ZR1+PA0=4-29=fEe+d+iUmhLTzpuQ@mail.gmail.com/

-- PMM

On Tue, 27 Oct 2026 at 17:46, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The net core code design is that by default packets are padded out to
> the ethernet frame minimum before being handed to a network device
> model, unless that device explicitly opted in by setting do_not_pad.
> This avoids a whole class of bugs where network device receive code
> has to be very careful about handling short packets.
>
> However, at the moment we do this check manually in the network
> backend code before it calls qemu_send_packet() or
> qemu_send_packet_async(), and we forgot to do it in all backends.  So
> you get the padding for the slirp, tap and vmnet backends, but not
> for the "minor" backends like 'passt', 'socket' and 'dgram', or if
> you configure two network devices connected by an emulated hub.
>
> This series fixes this by moving the padding code to
> qemu_send_packet()/qemu_sendv_packet(), so that it always happens
> regardless of the backend.
>
> The main bug this is fixing is
> https://gitlab.com/qemu-project/qemu/-/work_items/2362
> but it's been re-reported multiple times for various combinations
> of network devices and backends.
>
> The whole series is cc stable because without the padding you can
> provoke various bugs in different network device models.
>
> thanks
> -- PMM
>
> Peter Maydell (4):
>   tests/qtest: Make netfilter tests accept padded ethernet packets
>   net: Set do_not_pad for net backends
>   net: Pad short packets in qemu_send_packet and qemu_sendv_packet
>   net: Remove padding code from net backends
>
>  include/net/eth.h                    | 22 +++++++++++++++++++
>  include/net/net.h                    |  3 ++-
>  net/eth.c                            | 18 ++++++++++++++++
>  net/net.c                            | 32 ++++++++++++++++++++++++----
>  net/slirp.c                          |  9 --------
>  net/tap-win32.c                      | 15 ++-----------
>  net/tap.c                            | 11 +---------
>  tests/qtest/test-filter-buffer.c     |  4 +++-
>  tests/qtest/test-filter-mirror.c     |  4 +++-
>  tests/qtest/test-filter-redirector.c |  4 +++-
>  net/vmnet-common.m                   | 11 ----------
>  11 files changed, 82 insertions(+), 51 deletions(-)

