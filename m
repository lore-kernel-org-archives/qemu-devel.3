Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C18CE6817B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 12:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsK0F-0001fn-ES; Tue, 17 Feb 2026 07:16:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vsK05-0001Wr-IU
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 07:16:21 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vsK02-0007wX-6t
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 07:16:21 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1e1e:0:640:c6a6:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 631ACC01C1;
 Tue, 17 Feb 2026 15:16:12 +0300 (MSK)
Received: from [IPV6:2a02:6bf:803e:400:2ad6:3ceb:4d8a:4821] (unknown
 [2a02:6bf:803e:400:2ad6:3ceb:4d8a:4821])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 9GYXLj2A2uQ0-q7DWG5o3; Tue, 17 Feb 2026 15:16:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1771330571;
 bh=9c2s5aNxeTJ9djDej//eg2kqV/y0k+i3FZ5nCo4ViJc=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-ID:From;
 b=x/448JLdtu6kGG55SQmTBzgz6VKjs6u38TCCVvo+5Rmn6I6ueLmrnm+c6gIZQGGl8
 /WlOQsuzwdb1ruVYOnCiIjwqtX6sHk8hdcD5VftEHnXxKkU5xEZKyuvjDZp5fZqd+F
 zGMQJ/JxjiBJdaOex7hzwjXa7H7ZnHXH2ZvvjKGY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
Content-Type: multipart/alternative;
 boundary="------------oNJvcRYm0FcpHornIDKrELYf"
Message-ID: <aa07a475-2861-43a9-8a25-b4dfaa5a7f8d@yandex-team.com>
Date: Tue, 17 Feb 2026 17:16:09 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] add build option to disable audio subsystem
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20260217052740.114117-1-heifetz@yandex-team.com>
 <CAJ+F1CJRG5yReEGmCvrvJ-P07U2T0p9YNXHx=iq+WdMPZBZ=mA@mail.gmail.com>
Content-Language: en-US
From: Sergei Heifetz <heifetz@yandex-team.com>
In-Reply-To: <CAJ+F1CJRG5yReEGmCvrvJ-P07U2T0p9YNXHx=iq+WdMPZBZ=mA@mail.gmail.com>
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

This is a multi-part message in MIME format.
--------------oNJvcRYm0FcpHornIDKrELYf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/17/26 14:58, Marc-André Lureau wrote:
> I am planning to send a PR for "[PATCH 00/85] audio: cleanups & add a
> manual test" soon, could you rebase your series on top?
Hi. Yes, sure.
--------------oNJvcRYm0FcpHornIDKrELYf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2/17/26 14:58, Marc-André Lureau
      wrote:<span style="white-space: pre-wrap">
</span></div>
    <blockquote type="cite"
cite="mid:CAJ+F1CJRG5yReEGmCvrvJ-P07U2T0p9YNXHx=iq+WdMPZBZ=mA@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">I am planning to send a PR for "[PATCH 00/85] audio: cleanups &amp; add a
manual test" soon, could you rebase your series on top?
</pre>
    </blockquote>
    Hi. Yes, sure.
  </body>
</html>

--------------oNJvcRYm0FcpHornIDKrELYf--

