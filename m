Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18CDCF2592
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 06:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szru3-0007ed-VW; Sun, 13 Oct 2024 02:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1szru2-0007eV-Ji
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 02:16:30 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1szru1-0007ev-54
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 02:16:30 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4XR99K6Dwfz8PbP;
 Sun, 13 Oct 2024 02:16:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=default;
 bh=CzVjADn7mdP05BxwtmbNHnO34ECtIUfa0OOtztUHLRY=; b=UiCvY2tfcC0w
 qsac+QnF/5ist7YNgehpkDK7Yn6E0v2hziYoHBq767/RVA1PPs9T33QrkST63HW8
 FOUISHvxC60oz0zfiGLEZZIlsvrQ91LSfJJAvygDFGFKLOZrJEGqOvzalJyiFMob
 kKeHsUo6qjXRKzzCdNTKIKZeAo8z9CU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=message-id
 :date:mime-version:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding; q=dns; s=default; b=D8/
 f+z3mM/PTDy7RC4VUs/Gy6pyY00HcV0WAlN+2sG35Jf7NVk+Geu7rlkplvOI0r6M
 eKpNixwSuHeXGWEPP9xU1YVzNwpSaHog51/iwVd2IAetmDYYNWSxkIvD9B2dhKmz
 GnupMouvOdNubQfIE5C8qB0wHZonGVLpg/f2COMA=
Received: from [IPV6:2001:470:b050:6:cc31:46d5:f26a:a82b] (unknown
 [IPv6:2001:470:b050:6:cc31:46d5:f26a:a82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4XR99K5bJVz8PbN;
 Sun, 13 Oct 2024 02:16:21 -0400 (EDT)
Message-ID: <842a0a34-47d4-4732-9569-153da7a66268@comstyle.com>
Date: Sun, 13 Oct 2024 02:16:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/vm: update openbsd image to 7.6
To: Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Alex Benn_e <alex.bennee@linaro.org>,
 Philippe Mathieu-Daud_ <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc: qemu-devel@nongnu.org
References: <ZwtANoy5IzByoQgU@humpty.home.comstyle.com>
 <efd27fca-d73a-4152-a405-5e44d2ce2395@redhat.com>
Content-Language: en-US
From: Brad Smith <brad@comstyle.com>
In-Reply-To: <efd27fca-d73a-4152-a405-5e44d2ce2395@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 2024-10-13 2:06 a.m., Thomas Huth wrote:
> On 13/10/2024 05.36, Brad Smith wrote:
>> tests/vm: update openbsd image to 7.6
>
> Maybe change the patch description to something more meaningful, e.g.=20
> a comment about the removed py3-tomli package ?

Ok, I will post an updated diff.

>> Signed-off-by: Brad Smith <brad@comstyle.com>
>> ---
>> =C2=A0 tests/vm/openbsd | 6 +++---
>> =C2=A0 1 file changed, 3 insertions(+), 3 deletions(-)
>
> Anyway:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
>

