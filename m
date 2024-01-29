Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F36BC47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 09:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUOEO-0007M9-LK; Mon, 29 Jan 2024 04:47:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>) id 1rUOEM-0007Lq-9l
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 04:47:06 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>) id 1rUOEK-00038e-1D
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 04:47:06 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (Client did not present a certificate)
 by zoidberg.rfc1149.net (Postfix) with ESMTPSA id DD5E580027;
 Mon, 29 Jan 2024 10:46:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rfc1149.net; s=smtp;
 t=1706521619; bh=8CksjY3RGc6wJNoiQCe3RBOhEojLng/TbR22PaY7vcQ=;
 h=References:From:To:Cc:Subject:Date:In-reply-to;
 b=wUs1Bgu10NulZgGSi0ey9iPWPC725pDWoLphNkU6MSwXpDJ62Z32UN88/7Uji0NrR
 pfBTWKwWATNCh9XSq00xg/GSDAc2cKWfQcbRuWoaB4zDV52E7mbau/4iFSYn7gJp3U
 snWug9GqE4VI976Av81WpJLTnuM06fu4y/DUz2GTPvjkmowmE0+LtWvHYSBwtZy0Lv
 1udHN6RiN1ddMXh0IO3CpbCfyO1P26V6C969jebBt+bwr89xLoz5dEx6JkQ0NvkZJN
 jndmcigdTe2XzEIDrOzvkXSgxs07/3swwTIbuMpeVy39Ncae0cHLNZ9vjBlr9RiC7e
 QiRxVmyd3JZKA==
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-2-berrange@redhat.com>
 <ZbUU6CTgxgCLG0a9@intel.com> <ZbdwhR6h6T97vR8J@redhat.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Samuel Tardieu <sam@rfc1149.net>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Richard Henderson
 <richard.henderson@linaro.org>, Alexander Graf <agraf@csgraf.de>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Phil =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Stefan
 Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] docs: introduce dedicated page about code
 provenance / sign-off
Date: Mon, 29 Jan 2024 10:35:40 +0100
In-reply-to: <ZbdwhR6h6T97vR8J@redhat.com>
Message-ID: <8734uglbe5.fsf@rfc1149.net>
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
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

>> Is there any requirement for the order of tags?
>>=20
>> My previous understanding was that if the Reviewed-by/Tested-by=20
>> tags
>> were obtained by the author within his company, then those tags=20
>> should
>> be placed before the signed-off-by of the author. If the=20
>> Reviewed-by/
>> Tested-by were acquired in the community, then they should be=20
>> placed
>> after the author's signed-off-by, right?
>
> Common practice is for Signed-off-by tags to be kept in time=20
> order
> from earliest author to latest author / maintainer. Common case=20
> is
> 2 S-o-B, the first from the patch author, and the last from the
> sub-system maintainer who sends the pull request.
>
> For other tags I don't see any broadly acceptable pattern. Some=20
> people
> add Reviewed-by before the S-o-B, others add Reviewed-by after=20
> the
> S-o-B. Either is fine IMHO.

From what I've seen in other projects, S-o-B means that you accept=20
accountability for everything above. One scenario would be:

- Send original patch, which has been tested inside the company:

  Tested-by: Tester <tester@example.com>
  Signed-off-by: Developper <developper@example.com>

- Get some R-b, but need to make some requested minor changes and=20
  resend a new patch series:

  Tested-by: Tester <tester@example.com>
  Reviewed-by: Reviewer <reviewer@othercompany.com>
  Signed-off-by: Developper <developper@example.com>

  This is a way of saying "I guarantee that the R-b still applies=20
  after the new changes I made to this series"

- Then reviewed and pulled into their tree by the maintainer:

  Tested-by: Tester <tester@example.com>
  Reviewed-by: Reviewer <reviewer@othercompany.com>
  Signed-off-by: Developper <developper@example.com>
  Reviewed-by: Maintainer <maintainer@org.org>
  Signed-off-by: Maintainer <maintainer@org.org>

If, after being reviewed, the initial patch would not have needed=20
any change, the order would have been:

  Tested-by: Tester <tester@example.com>
  Signed-off-by: Developper <developper@example.com>
  Reviewed-by: Reviewer <reviewer@othercompany.com>
  Reviewed-by: Maintainer <maintainer@org.org>
  Signed-off-by: Maintainer <maintainer@org.org>

This is consistent with what software like "b4" do: if the S-o of=20
the current user is present, it is moved last, as the current user=20
is the one accepting accountability at this point.

However, this is not what QEMU has been using as far as I can see,=20
as S-o-b tend to stay in their original positions. I even opened=20
an issue on b4 a few weeks ago because of this=20
<https://github.com/mricon/b4/issues/16>, and I reverted to using=20
git-publish. But if this is ok to use an arbitrary order for=20
non-S-o-b headers, I can get back to b4.

  Sam
--=20
Samuel Tardieu

