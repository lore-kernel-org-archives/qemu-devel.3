Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA03C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 18:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX3VP-0008Nt-Ca; Mon, 05 Feb 2024 13:15:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>) id 1rX3VM-0008Md-LJ
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 13:15:41 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>) id 1rX3VG-0006N4-Vp
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 13:15:40 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (Client did not present a certificate)
 by zoidberg.rfc1149.net (Postfix) with ESMTPSA id B563A80025;
 Mon,  5 Feb 2024 19:15:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rfc1149.net; s=smtp;
 t=1707156930; bh=JHCKbWCZGGBXVWMm4/ydutEr2vj6UbOE6RTgq7AvFzw=;
 h=References:From:To:Cc:Subject:Date:In-reply-to;
 b=YlgAffYgXOEchhIOnMTI76BPn284Gl8fmQo/IBwPTL+Nhi9ay6zvi9mIYj7ZAcN7u
 oWM1H2vCPz30aVdBITDmse/awEdItMGsOBdzpo06iV04Ih6f1U0u73pgWXdfagx6I4
 MSF63W4KnicevTIhtukiKSpawyq9aW9HLgax2rrZsXai3GAmKP6PvCNyCTnMVGJU8w
 iK5fDmhFfN3+HGo8mh0EvVfUcKKj/BzYsyhNI6ItduqcSw+nReQtT2I53kvm5md3m4
 ykv5B5pyhRAw1VjiIUPbwJTT8WUowUkrX3i0QOnESMRydKAx2Idd8qbhRdIAjh0No7
 U7EPlPfliNCEg==
References: <20240205171819.474283-1-stefanha@redhat.com>
 <ZcEdrp-y5YFsfir4@redhat.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Samuel Tardieu <sam@rfc1149.net>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Hanna Czenczek
 <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Thomas Huth <thuth@redhat.com>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] docs/style: allow C99 mixed declarations
Date: Mon, 05 Feb 2024 19:12:21 +0100
In-reply-to: <ZcEdrp-y5YFsfir4@redhat.com>
Message-ID: <877cjiaibh.fsf@rfc1149.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=195.154.227.159; envelope-from=sam@rfc1149.net;
 helo=zoidberg.rfc1149.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> $ gcc -Wall -Wuninitialized -o jump jump.c

Note that many GCC warnings don't trigger if you don't enable=20
optimizations. In the case you exhibit, adding -O is enough to get=20
a sensible warning:

$ gcc -Wall -O -o jump jump.c
jump.c: In function =E2=80=98main=E2=80=99:
jump.c:11:3: warning: =E2=80=98foo=E2=80=99 may be used uninitialized=20
[-Wmaybe-uninitialized]
   11 |   free(foo);
      |   ^~~~~~~~~
jump.c:8:9: note: =E2=80=98foo=E2=80=99 was declared here
    8 |   char *foo =3D malloc(30);
      |         ^~~

Best.

  Sam
--=20
Samuel Tardieu

