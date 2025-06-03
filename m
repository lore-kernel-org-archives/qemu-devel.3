Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6595C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 13:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMRdn-0001Dh-4U; Tue, 03 Jun 2025 09:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waissoumurad@gmail.com>)
 id 1uMMXX-00069z-E9
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 03:58:31 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <waissoumurad@gmail.com>)
 id 1uMMXV-00040X-Qz
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 03:58:31 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-401f6513cb2so3696424b6e.0
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 00:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748937507; x=1749542307; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=AvSAvwoyg1rkIw2NJQlGDh4LfuEhQ1059LPoWoeCqrw=;
 b=VSuGm0zAEhoxk9NFEBvNAbCCW5x2WCXbg6YWqol+3iORcD6BU8gu0KgOh/GSRnmzqM
 QXGkSJ1BKpwpF6jbPXfPrwbucIfX6npJ4sNmVD9kD/QTA/o5OMaS8J0QxyYm/jjRKpe1
 2Ff36NVjhBVRTSIpWsePWcoAoWaB2mOugMj+D4VM82M00DqGM5rbrN5LEXxSeooS504x
 GPCbjiq3DcPH/mzrbI3wQ9rWv4vNyaoJhNRCdCQxL9e4hjro0YyRqfx6mdrrgNk7dfOV
 XKQ1F7lrwoA9clAtVQ9B+J5vxAjrHrJFfuyduNu1L58lL6RPfmn7ZqncJrIYIYi1Tpzo
 uGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748937507; x=1749542307;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AvSAvwoyg1rkIw2NJQlGDh4LfuEhQ1059LPoWoeCqrw=;
 b=noTpkmo+Mj80AG69VHLB9VgBNX2QwCCN31ymzMFm2qbuiJO7GSasQqEAHnqSg4k8zq
 Uc6LDxkwGaCp4y3dvaVR0F+4BuYsbViIfkMJud5LFQ3a5FRo4qiCcBD3IsZs35CgiNi4
 on24jn2KnimseU6ZH77dI0NweoLlzf8E1Y0USSDLggFg1oifZWN6bm3r5L0BRtUmEqeJ
 feHd7bEeKGVqi3SAceh99Uh12pQZWNSuPZvzdA5W0LQ9jgJT+r/OpFNKvnCiN9P0BzVj
 b/p5ws53VRTLTNK1BHhCjEC3MYizz88SWmW0yCRF1K07zWoSxQnVVDWcWHtvjURvQ2cB
 eK4Q==
X-Gm-Message-State: AOJu0YypbeWQeiAHgNdz+QyNs0NyiM1i4kQvUbqH71Djlb5SjWsoIXDz
 O0ba+g64gLMsvxXrxC0iI59XgrJnFbWyfjKxagWImw+ZwqDnEq3TmDl//m1rKBJt5X/zbr4/g1E
 JNvTBfkKah7tFDD3YBcJI9/UU3T1n006UUaK6ZT0=
X-Gm-Gg: ASbGncuTDwIzRIjlO41ssxyUjlypXlfDFUaiqC9i+cWtGtuvEa3Ii3T1+Ua86Zs9LrM
 Ld+AA1Eabk4gI+0ylWXkHYXOY1YNxnSsiRTyJb6vZmWN8Ldja7ns0tZTLFOPs7REKNfVIx4/xad
 k5fwuP1cJaJKNCKB0qac+7bEIxRlUwf9cK1sKxBgTiD8WF5Q==
X-Google-Smtp-Source: AGHT+IFORM8+Ssf88N0KLyLtCSx3HWAf4EgAg4x5aGIXvrv1G34lCFqYpRbje7CkEf8aQsWH0XtjlO2gYqDvyP6iKeE=
X-Received: by 2002:a05:6808:320c:b0:3f7:d442:1986 with SMTP id
 5614622812f47-408e3a81667mr929640b6e.1.1748937506642; Tue, 03 Jun 2025
 00:58:26 -0700 (PDT)
MIME-Version: 1.0
From: Murad Waissou <waissoumurad@gmail.com>
Date: Tue, 3 Jun 2025 07:58:16 +0200
X-Gm-Features: AX0GCFscvMI58i8v61sG3UDedh5eWggY6pRulGAv7IsBoxZgN1APczGuLH5ht40
Message-ID: <CAFmGX1B-XYxOt=qt3VVJDn==s6SH8NuoZNturrQWz0KKrPNnrA@mail.gmail.com>
Subject: 
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d16a1f0636a63e66"
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=waissoumurad@gmail.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 03 Jun 2025 09:25:17 -0400
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

--000000000000d16a1f0636a63e66
Content-Type: text/plain; charset="UTF-8"

Dear QEMU Developers,

I'm writing to ask about the feasibility of including a script within
a *closed-source
application* that automates the installation of QEMU from standard Linux
distribution repositories (e.g., *APT, RPM, Zypper, Pacman*).

My aim is to simplify the user experience by offering a convenient way for
them to install QEMU, which is a key dependency for my application. I'm
unsure if providing such a script would be considered "distributing" QEMU
itself, or if it falls under a different category that would necessitate me
building a custom QEMU version.

Could you please clarify if this approach is permissible under QEMU's
licensing and development guidelines? If it's not, could you advise on the
recommended way to handle QEMU as a dependency for a closed-source
application without requiring me to build a custom version (as I currently
lack the expertise to do so)?

Thanks for your time and guidance.

Sincerely,

Waissou murad

waissoumurad@gmail.com

--000000000000d16a1f0636a63e66
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><p style="margin-right:0cm;margin-left:0cm;font-size:12pt;font-family:&quot;Times New Roman&quot;,serif">Dear QEMU Developers,</p>

<p style="margin-right:0cm;margin-left:0cm;font-size:12pt;font-family:&quot;Times New Roman&quot;,serif">I&#39;m writing to ask about the feasibility of
including a script within a <strong>closed-source application</strong> that
automates the installation of QEMU from standard Linux distribution
repositories (e.g., <strong>APT, RPM, Zypper, Pacman</strong>).</p>

<p style="margin-right:0cm;margin-left:0cm;font-size:12pt;font-family:&quot;Times New Roman&quot;,serif">My aim is to simplify the user experience by
offering a convenient way for them to install QEMU, which is a key dependency
for my application. I&#39;m unsure if providing such a script would be considered
&quot;distributing&quot; QEMU itself, or if it falls under a different category
that would necessitate me building a custom QEMU version.</p>

<p style="margin-right:0cm;margin-left:0cm;font-size:12pt;font-family:&quot;Times New Roman&quot;,serif">Could you please clarify if this approach is
permissible under QEMU&#39;s licensing and development guidelines? If it&#39;s not,
could you advise on the recommended way to handle QEMU as a dependency for a
closed-source application without requiring me to build a custom version (as I
currently lack the expertise to do so)?</p>

<p style="margin-right:0cm;margin-left:0cm;font-size:12pt;font-family:&quot;Times New Roman&quot;,serif">Thanks for your time and guidance.</p>

<p style="margin-right:0cm;margin-left:0cm;font-size:12pt;font-family:&quot;Times New Roman&quot;,serif">Sincerely,</p>

<p class="MsoNormal" style="margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">Waissou murad</p>

<p class="MsoNormal" style="margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"><a href="mailto:waissoumurad@gmail.com">waissoumurad@gmail.com</a></p></div>

--000000000000d16a1f0636a63e66--

