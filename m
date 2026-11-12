Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169CF606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZLKFUCBE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRTmV-0005gd-TV; Thu, 12 Nov 2026 07:19:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xRTmU-0005ea-0d
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 07:19:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xRTmS-0004C6-CG
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 07:19:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794485991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lV7gFTFLljz/e5a7fKfRrT6NU2WpvRiBqJZorOYcYxU=;
 b=ZLKFUCBEcjK95EQeR/uQiUjGKMGEEm1/EBXX2JDJK81U3JgJupu1S/th3dFKMawe3E+b86
 pXT2C9tQ3d8sw50b8Vp5ETEvAWjoGkR5de87Qz+2RvXwPQnd4di5UkxEFNq2cCFfrwvnql
 mTVcq6lxAQ+Oem6XP98iRtRy6mc8IkU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-RpJqNMbOOG2bgmQzDck7UA-1; Thu,
 12 Nov 2026 07:19:48 -0500
X-MC-Unique: RpJqNMbOOG2bgmQzDck7UA-1
X-Mimecast-MFC-AGG-ID: RpJqNMbOOG2bgmQzDck7UA_1794485987
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEF8C18011E1; Thu, 12 Nov 2026 12:19:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5150D18004F7; Thu, 12 Nov 2026 12:19:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 10B2021E6A04; Thu, 12 Nov 2026 13:19:44 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PULL 03/19] .dir-locals: include QEMU code in PYTHONPATH
In-Reply-To: <CAFEAcA-i6SP=Z96DKvckc-BT0eDXqKUOjdk4ccKUeORB9o=-hw@mail.gmail.com>
 (Peter Maydell's message of "Thu, 12 Nov 2026 11:06:41 +0000")
References: <20261023180539.1574134-1-alex.bennee@linaro.org>
 <20261023180539.1574134-4-alex.bennee@linaro.org>
 <CAFEAcA-i6SP=Z96DKvckc-BT0eDXqKUOjdk4ccKUeORB9o=-hw@mail.gmail.com>
Date: Thu, 12 Nov 2026 13:19:44 +0100
Message-ID: <87cxsaqm1r.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 23 Oct 2026 at 19:06, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> When editing python code the linters tools have a hard time with our
>> imports as they can't be found. To ease this we can expand a
>> PYTHONPATH in .dir-locals so at least Emacs users can have less
>> warnings in their editor.
>>
>> I still get complaints from python-mypy about missing library stubs
>> that mean it can't do proper type analysis though.
>>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Message-ID: <20261019192704.3220373-4-alex.bennee@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> diff --git a/.dir-locals.el b/.dir-locals.el
>> index 3ac0cfc6f0d..51871619422 100644
>> --- a/.dir-locals.el
>> +++ b/.dir-locals.el
>> @@ -1,2 +1,8 @@
>>  ((c-mode . ((c-file-style . "stroustrup")
>> -           (indent-tabs-mode . nil))))
>> +           (indent-tabs-mode . nil)))
>> + (python-mode .
>> +              ((eval . (when-let* ((root (locate-dominating-file defaul=
t-directory ".dir-locals.el")))
>> +                         (setq-local process-environment (copy-sequence=
 process-environment))
>> +                         (setenv "PYTHONPATH"
>> +                                 (concat (expand-file-name "python" roo=
t) ":"
>> +                                         (expand-file-name "tests/funct=
ional" root))))))))
>
> With this change, emacs now complains and prompts for input every
> time I open a Python file inside the QEMU source tree:
>
> =3D=3D=3Dbegin=3D=3D=3D
> The local variables list in /home/pm215/qemu/
> or .dir-locals.el contains values that may not be safe (*).
>
> Do you want to apply it?  You can type
> y  -- to apply the local variables list.
> n  -- to ignore the local variables list.
> !  -- to apply the local variables list, and permanently mark these
>       values (*) as safe (in the future, they will be set automatically.)
> i  -- to ignore the local variables list, and permanently mark these
>       values (*) as ignored
>
>   * eval : (when-let* ((root (locate-dominating-file default-directory
> ".dir-locals.el"))) (setq-local process-environment (copy-sequence
> process-environment)) (setenv "PYTHONPATH" (concat (expand-file-name
> "python" root) ":" (expand-file-name "tests/functional" root))))
> =3D=3D=3Dendit=3D=3D=3D
>
> The commit messages says "so Emacs users can have less warnings"
> but from my POV this is "more warnings" (and previously I didn't
> notice any warnings at all).

Same here.

What exactly was the problem this patch tried to solve?

> I think emacs is correct to warn about files and configs that
> try to automatically update PYTHONPATH, so I would favour reverting
> this commit.


