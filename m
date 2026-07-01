Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A219C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 16:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wexg3-0001XH-2U; Wed, 01 Jul 2026 12:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wexfh-0001W1-Kq; Wed, 01 Jul 2026 12:20:25 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wexfg-00040q-4J; Wed, 01 Jul 2026 12:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=8cQwEbPs8OavULbWWRsnVXGSKV6jgJ+rKs4rGhRUeyA=; b=llgACd8yePpqINpSkeyK1H5noP
 A9kSr4Lt//f6l5Jsr7k0waENPsM3YvDHjfo8uL41bA2W3rEVt1QCDmL6kXNXKD8zssun0M1j5GotA
 4IpofX8OAu8n8aO/Rb2FNPhtqi3sNNv7+ipEioH78UQHJHQmSOdElbdRpsMRvn/CcvnxRowre8uSg
 JEgRyziLV301WJrfzsdWob5IYZ/o4kvjR+wwYtqFBpU7KSCZYD2+F8qQ2hQC7mIpZ8QX9xoNtEOWM
 whD4tgb3KgC9PcWamhc0dfEPh8oOtdjaVH7YmamLYksBG9zXVnYcEi0NUqxxGuoyz74jEfEpcVlij
 OfkAvhi4RtLhAZ8PbEb2Y2RSgK/fJ2vmBwSW4XWxYqeSTcOKQJ7HPw8GWaYoSgmyTmGYnmdXixcYB
 sOsCoXxAeZMvGBqoF3gAYw/aOAATfp+R7rI8Q0/s2Yq0LqkGwjg0jNiwxxuaL70sfEELBVEXOBxj2
 6npJgP8HOunnFAPxBSFn+c8oyTiF6hc83uwg/mpOpcC3ZJIPtFvP9JWcGbxPzmnaLqmrdPHHu69ay
 7nLaX7ugXajtKLzGNtg/A5vYt5l1aKm22vxynXsev/FLiIXvFbkrJYB4BIG3e8SYubUp3gqsPhV+V
 HdHwtWc7Udwrbq1fRn67dnBdoWVT2KuUmjiNIq/8I=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>,
 Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PULL 00/23] 9p queue 2026-06-29
Date: Wed, 01 Jul 2026 18:20:07 +0200
Message-ID: <8700308.T7Z3S40VBb@weasel>
In-Reply-To: <53159abf-ae84-465a-ac70-8ad71fa6c045@oss.qualcomm.com>
References: <cover.1782739719.git.qemu_oss@crudebyte.com>
 <53159abf-ae84-465a-ac70-8ad71fa6c045@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Tuesday, 30 June 2026 09:28:48 CEST Pierrick Bouvier wrote:
> Hi Christian,

Hi Pierrick,

> This series brought a test regression:
> $ ./build/pyvenv/bin/meson test -C build \
> --setup thorough --print-errorlogs \
> qemu:qtest-aarch64/qos-test
> ...
> ERROR:../tests/qtest/libqos/virtio-9p-client.c:280:v9fs_req_recv:
> assertion failed (hdr.id == id): (7 == 121)
> 
> It seems to come test added in patch 19
> "tests/9p: add 3 xattr FID limit test cases (synth fs driver)"
> This test runs only with slow setup, so I suspect it never worked and
> was never ran.

Of course I ran these slow tests.

I intentionally registered these tests as "slow" tests as they take a long 
time to complete and QEMU tests being notorious on exceeding the overall CI 
timeout limit. So these tests are exempted from running in the official CI 
pipeline, but not from mine.

I just reran them with latest master head. However I am unable to reproduce 
your reported test error so far.

You cropped the output too aggressively. I need to know:

- Which test exactly failed? (especially whether it's really a synth backend 
  or a local backend test that failed)

- What is the errno being printed *before* the "assertion failed" message?
  ("(hdr.id == id): (7 == 121)" just means 9p server responded with an error 
  response instead of the expected one)

- Were you running the tests in a Docker environment or something or just 
  plain locally?

- Does the underlying host file system support xattrs? (might matter if it's a 
  local backend test that's failing)

/Christian



