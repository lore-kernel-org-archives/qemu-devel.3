Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86DD606A327
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bq6Hyjuw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRYSq-0002fc-H7; Thu, 12 Nov 2026 12:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xRYSo-0002cA-Uf
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:19:54 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xRYSn-000611-6j
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:19:54 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c505b2e1cb9so117765166b.2
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 09:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794503991; x=1795108791; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nDmdq5Z6Beet4vn+J9cncDdb8UbQhc9KwdLd/2u2Sn4=;
 b=bq6Hyjuwnj1q7LY3cQXdKhbSGJ1PY/CrUBAchqdMAvcl/fB1keVpYXJdO8TPp6GyOq
 VFW9NF/O6gmvTSEMHqDtaoCgRGaBbXUCxUqrFbIZn0Fv3Q2paZJGVjKvlBH/Wm4IoSVc
 Npsc8Q45kXAJ/LsfobQV73X1DBYBtI06hNtxX9LjaAgwF93DRHd/kgOjJG4teWiNJPkD
 0Jb++NzjdRCy+gMbiWQ2uq8tNtO8qfg72r5g09VKxmpKNVKPgWw0CHW37Gj3If8Ah7T/
 PbG2BmESh/NaY4ewFuLXAg5UZ0+FpwivinL5EicXZjQdME1lVHbpVn8gt+IzdhN32uTi
 nsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794503991; x=1795108791;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nDmdq5Z6Beet4vn+J9cncDdb8UbQhc9KwdLd/2u2Sn4=;
 b=R+tf8ijRRzZ2DfhdcasYDrRMIFUa29kfv5LNSTO0IS4kvb/qKDJJ+2ekIMkpIcCzJr
 XfnDNcVC2wuv++iYvkCdnm4PmAwV/GicdUFlvGH40cDnXRDAOfm8bgRNf1jKnZl5cgY4
 +yxjxfwldrrNjZ2gMxsNN31gyIsA0U5ncn3tptQUo6Ns3SSNHKO9aIowHcjw9+YPha+t
 3JUt/PIKi9RTI2UynDQdvsTdqGBTzUY9+nJRi5Vd30uwlAkfbZXC819Ip6+cXU9eL1V5
 FpDarNtY+03+wA4qu5KIOnmEnxpFF8bUbAfpsp45psHSpzw64gl0QupSsRMmB3XqPZny
 NHZw==
X-Forwarded-Encrypted: i=1;
 AL+hErGmBzIN8bPFPqMmbT5LWmO4zTRTKLPDh8rlOXj+eH3sCP2nwgRebCNrgv9IIRfIG69d3zcmJ87NBTvK@nongnu.org
X-Gm-Message-State: APuU4Z/jFeSuJ3s5kxK5t/X3/uFQbtR3jeXsZUteDwY9mYVNbiv6kmKU
 r7+jUqc1wF30zraJkGiO6t2vEkrNOMHLR14pl6jDn3wpKVPv5DCrFqWneMHR3D7T+QU=
X-Gm-Gg: AYBFou1VlE1vWC0qY1mnFyKeAvj7RxV1sCMjXtL/r6uLcNLUJdwakTJVb7MjGlxJ235
 GxRgIA9byF2LR+EXLvWrXJ61c66sbw3EqkuDlqEG3akG/ZIqZF9Ul/cLKNbqjtemfaN/8vC2jG6
 vg7IdAx4ujxxCWubCU16JIyV5t1ptb1u15w5SyiRXLrFgO/r0Pz2rlj7rWLud+zU0g/lBth9EwV
 +EQz3QQd8zJyzxVOQfQVZEpPLoGtTbUqNy42AMC5oLO6N9H9N0uQ4HF2+GeiUjPKDUeb8Ly1km6
 rFBfUMUlHv9ccjB/E8pUXIVskOEJosgMZb+A0gttaKYyK1jZ5lVAFHHsnFJIMjjXiHOtAaoyLxw
 5hg4gy0Ai4WJ9V9LtAT19jqUQTTtU4XMy1c5M2kb0aDuDzT8SVTxVyNU65f2azYHNEN5xN3thlJ
 ryqEfweF7XdWHhTWqqvRSVTiCtYmNZRROW8kr0xjthXdFyGtXx6+teTsEuguEHmBHiLLCzqAQAZ
 2NGGR0B0WRKlfXFuLwrVyhaVeXjRehAZqDUgSM/URC4CFI7j+vBD7IngKBxI2k4xzijlfU0RnGN
 SNM4hXLtxkABxFbKrZvbYjaq07vW
X-Received: by 2002:a17:906:c110:b0:c49:8fa2:4a22 with SMTP id
 a640c23a62f3a-c5066cd80bfmr546105366b.41.1794503990904; 
 Thu, 12 Nov 2026 09:19:50 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6020bb0fsm317860f8f.34.2026.11.12.09.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:19:49 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8D67A5F8CE;
 Thu, 12 Nov 2026 17:19:47 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PULL 03/19] .dir-locals: include QEMU code in PYTHONPATH
In-Reply-To: <87cxsaqm1r.fsf@pond.sub.org> (Markus Armbruster's message of
 "Thu, 12 Nov 2026 13:19:44 +0100")
References: <20261023180539.1574134-1-alex.bennee@linaro.org>
 <20261023180539.1574134-4-alex.bennee@linaro.org>
 <CAFEAcA-i6SP=Z96DKvckc-BT0eDXqKUOjdk4ccKUeORB9o=-hw@mail.gmail.com>
 <87cxsaqm1r.fsf@pond.sub.org>
User-Agent: mu4e 1.14.5-pre1; emacs 30.1
Date: Thu, 12 Nov 2026 17:19:47 +0000
Message-ID: <87tslmarws.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Markus Armbruster <armbru@redhat.com> writes:

> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On Fri, 23 Oct 2026 at 19:06, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>>>
>>> When editing python code the linters tools have a hard time with our
>>> imports as they can't be found. To ease this we can expand a
>>> PYTHONPATH in .dir-locals so at least Emacs users can have less
>>> warnings in their editor.
>>>
>>> I still get complaints from python-mypy about missing library stubs
>>> that mean it can't do proper type analysis though.
>>>
>>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>> Message-ID: <20261019192704.3220373-4-alex.bennee@linaro.org>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>
>>> diff --git a/.dir-locals.el b/.dir-locals.el
>>> index 3ac0cfc6f0d..51871619422 100644
>>> --- a/.dir-locals.el
>>> +++ b/.dir-locals.el
>>> @@ -1,2 +1,8 @@
>>>  ((c-mode . ((c-file-style . "stroustrup")
>>> -           (indent-tabs-mode . nil))))
>>> +           (indent-tabs-mode . nil)))
>>> + (python-mode .
>>> +              ((eval . (when-let* ((root (locate-dominating-file defau=
lt-directory ".dir-locals.el")))
>>> +                         (setq-local process-environment (copy-sequenc=
e process-environment))
>>> +                         (setenv "PYTHONPATH"
>>> +                                 (concat (expand-file-name "python" ro=
ot) ":"
>>> +                                         (expand-file-name "tests/func=
tional" root))))))))
>>
>> With this change, emacs now complains and prompts for input every
>> time I open a Python file inside the QEMU source tree:
>>
>> =3D=3D=3Dbegin=3D=3D=3D
>> The local variables list in /home/pm215/qemu/
>> or .dir-locals.el contains values that may not be safe (*).
>>
>> Do you want to apply it?  You can type
>> y  -- to apply the local variables list.
>> n  -- to ignore the local variables list.
>> !  -- to apply the local variables list, and permanently mark these
>>       values (*) as safe (in the future, they will be set
>> automatically.)

It should mark them as safe for this particular directory, not generally
for setting PYTHONPATH.

>> i  -- to ignore the local variables list, and permanently mark these
>>       values (*) as ignored
>>
>>   * eval : (when-let* ((root (locate-dominating-file default-directory
>> ".dir-locals.el"))) (setq-local process-environment (copy-sequence
>> process-environment)) (setenv "PYTHONPATH" (concat (expand-file-name
>> "python" root) ":" (expand-file-name "tests/functional" root))))
>> =3D=3D=3Dendit=3D=3D=3D
>>
>> The commit messages says "so Emacs users can have less warnings"
>> but from my POV this is "more warnings" (and previously I didn't
>> notice any warnings at all).
>
> Same here.
>
> What exactly was the problem this patch tried to solve?

It ensures the python lsp's don't complain about invalid imports because
they don't have visibility of the PYTHONPATH set by ./run.

>
>> I think emacs is correct to warn about files and configs that
>> try to automatically update PYTHONPATH, so I would favour reverting
>> this commit.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

