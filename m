Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C276606A33E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=bqCfEh4L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRaUu-0000vh-6t; Thu, 12 Nov 2026 14:30:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xRaUq-0000qP-Pj; Thu, 12 Nov 2026 14:30:09 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xRaUo-0001tg-Ff; Thu, 12 Nov 2026 14:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794511802; bh=zXRfxWfPGq1GPQB6Wv8CR1ZorD2tvimlSODIYbBeTTI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=bqCfEh4LCcMEBiegHS1TbkWQ015TZgbMP5WcRbWVARNVC4RXX1+UqTXnDEnYUdDfO
 Ol5aLmLBeHWHsDpnDgJIyzfpIfOYY7g8W6j7txCuTeR7O1VcaM6Me+fNGWdsu6nzB0
 yQ9N7Ofua/2yzPwjszmSRNRV8XNUl/RNMRJnAJX7+2P/n5QyJu+gdtBO7Tpo8+QbXl
 GfxzNRYrD/7Mnd/F3Flj6HYYIm03j0Ywc0kVnQ0TRiNICqbWPNW5yns5OxDxwMlZpX
 cVh4uAmHGDo3kTiqO+6XfYiSDuqmhnqozmsPf++tWmNtFd6GHiMgfTcWoSDgrmu2k9
 XQtoxh7hkT5dw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 10DB71E5D40;
 Thu, 12 Nov 2026 22:30:02 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 04A6145AB0C;
 Thu, 12 Nov 2026 22:30:02 +0300 (MSK)
Message-ID: <06a309bf-91f7-4873-9a0c-d7720193398b@tls.msk.ru>
Date: Thu, 12 Nov 2026 22:30:01 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 6/6] configure: --disable-containers should prevent
 `docker.py probe`
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Matthew White <mehw.is.me@proton.me>,
 qemu-trivial@nongnu.org
References: <20261112184513.2324634-1-mjt@tls.msk.ru>
 <20261112184513.2324634-7-mjt@tls.msk.ru> <avYMRz3P0-4UNpc-@redhat.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <avYMRz3P0-4UNpc-@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/26 21:58, Daniel P. Berrangé wrote:
> On Thu, Nov 12, 2026 at 09:45:09PM +0300, Michael Tokarev wrote:
>> From: Matthew White <mehw.is.me@proton.me>
>>
>> Upstream commit c4ce04cfb7460d46c0262d437a7f35bb5c5fc449 changed the
>> configure file to set container_command regardless of use_containers.
>> As a result, it runs `docker.py probe` to detect a Docker-compatible
>> application, such as Podman, even when --disable-containers is used.
>>
>> On Gentoo, this reopens https://bugs.gentoo.org/732972.  As reported
>> in https://bugs.gentoo.org/984747, the `docker.py probe` command can
>> trigger SANDBOX ACCESS VIOLATION errors under QEMU v11.1.2:
>>
>>   * ACCESS DENIED:  open_wr_creat: /var/lib/rpm/rpmdb.sqlite-wal
>>   * ACCESS DENIED:  fchown:        /var/lib/rpm/rpmdb.sqlite-wal
>>   ...
> 
> I'm puzzled why docker.py probe would touch the RPM database.

Yeah, that was puzzling for me too, but that wasn't the reason
I took this patch (which turned out not to be trivial in the end).

> As long as the configure script does not break though, having
> the system log sandbox warnings is not a bug from QEMU's POV
> IMHO.

My immediate reaction is - why probe at all once --disable-containers
is given.

There might be different reasons for the error (or lack thereof), but
once it's been told to disable containers, there's no reason to probe
container environment, end of story....

> The probe can be disabled by using --container-command=podman
> or probably even --container-command=false would work.
> 
>> This patch is to prevent `docker.py probe` from running and to clear
>> container_command when --disable-containers is used.
> 
> This reintroduces the problem that c4ce04cfb7460d46c0262d437a7f35bb5c5fc449
> was fixing, because tests/docker/Makefile will now re-run the docker
> probe on every command.
> 
> The --disable-containers arg was only intended to disable the use of
> cross compilation in containers for the purposes of TCG testsuite.

...And this is the actual problem.  It isn't --disable-containers-for-tests.
It is --disable-container.  It's more, the help currently says:

   --disable-containers     don't use containers for cross-building

so it isn't obvious at all this is only used for tests.

And as long as it is actually doing something else, not what the name suggests,
people will try to use it for something it isn't intended for.

As long as these two options (coming together) are interpreted in such
an awkward way, there will be more attempts to do the same, like this one.

(Why this change seemed trivial to me: because it restores the status-quo,
everything seems to match now, disable-containers means empty container
command, end of question).

I re-sent the pull request without this change.  But this should be
fixed one way or another, I think :)

And I should be more careful next time.

Thanks,

/mjt

