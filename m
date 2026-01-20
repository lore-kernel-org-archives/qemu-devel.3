Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9B5D2ECF9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 06:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi4rj-0000EL-0B; Tue, 20 Jan 2026 01:05:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vi4rh-0000E6-So; Tue, 20 Jan 2026 01:05:21 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vi4re-0003ow-Kh; Tue, 20 Jan 2026 01:05:21 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 243D7C000F;
 Tue, 20 Jan 2026 09:05:13 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b20::1:6] (unknown [2a02:6bf:8080:b20::1:6])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id B5TSqe1Aq8c0-N4dAFFHO; Tue, 20 Jan 2026 09:05:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768889112;
 bh=dGVjnxDxf1/gNNvREG0g7Apt/n3tCCTUEpaEZzr7uuw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=ZeXWv9LmND9cxvS2rq6JzskvpJMGF3v15RtG1c63KopEpR/kTF32lpdw4nUxKPZP7
 d2F2ZZsa9wdyb7z0ks3kc5I8pbHRfDG7mF14nvMMRCYuOh/fA+jM13TeB82EMIuU8D
 EuFELF+cG9DHsZFY0LLO2G1SFk5AkC3r7YaKiu/Y=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <24e550ca-31bf-496a-9783-af8c8c19f0f9@yandex-team.ru>
Date: Tue, 20 Jan 2026 09:05:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/17] python/mkvenv: add 'tooling' and 'functests'
 dependency groups
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Maksim Davydov <davydov-max@yandex-team.ru>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Hanna Reitz <hreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Ed Maste <emaste@freebsd.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260119212744.1275455-1-jsnow@redhat.com>
 <20260119212744.1275455-4-jsnow@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260119212744.1275455-4-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20.01.26 00:27, John Snow wrote:
> 'tooling' contains depedencies required to run various tools (like
> qmp-shell) as well as dependencies required to run "make check", and as
> such, we promise that these dependencies can be sourced from the user's
> distribution repository or from vendored packages so that "make check"
> can be executed offline in an isolated build environment.
> 
> In contrast, pygdbmi is only needed for functional tests and not tests
> in general; we do not make the same offline/isolated guarantees for
> functional tests, and this dependency group is allowed to fetch
> dependencies from PyPI at runtime.
> 
> For the time being, amend the "check-venv" target to install both
> dependency groups, to avoid a duplicate dependency between them. By the
> end of this series, however, "check-venv" will be eliminated in favor of
> always installing "tooling" at configure time and allowing "functests"
> to be installed on-demand as needed by meson/ninja.
> 
> Signed-off-by: John Snow<jsnow@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir

