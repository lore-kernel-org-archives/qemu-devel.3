Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359C4606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 19:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=TE3drCp9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRaR5-0006j0-OL; Thu, 12 Nov 2026 14:26:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xRaQz-0006hY-ID
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 14:26:10 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xRaQx-0001fv-1o
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 14:26:09 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-498f5fa5103so52104f8f.2
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 11:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794511565; x=1795116365; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ijhcOVAedImUfyp7K7aPhDanTYZaWJKneuMJfQVUZP4=;
 b=TE3drCp9zWR7Aspiny1Seg+BMik7lpNdZzNNNRmoiuPU8xd/jhWsv6pYYYW6fDXrU8
 UhrOHQDwU6CuQzDHOLfTQPHmptfNtSl67znOPmBCyL2OT4+0z4k8JRQR1LD3yHcMA02t
 MGAPIl16VAkgyOvL//U1BpthEwUbjjADAdq/LP6TVSGzeqL4b1OOchrFlII4UBt6OvcO
 7keh7FF3Ngkq5GXEg3T1SMLM2HZJDhbyXn/Hof/T5LdtayVjKY0i/qEAYuKywMKRzijs
 nCvf3mByn/35JJE0wi1p0wFhCRS2vLEFQe//wY0hdxKItm52rX7pHXWaJ/uq8AG0vK5P
 MjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794511565; x=1795116365;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ijhcOVAedImUfyp7K7aPhDanTYZaWJKneuMJfQVUZP4=;
 b=gOST5fEUB6lwUizNezXF/Sp3heKPrS417GyTpeOm6upMHBqxHn41SALAP7zLpT1wCM
 8gEfraPgK59EMJUjaHjLhx/WMhNk/kHRNsSipk4SpxupmBrIRdOH1US3kgzhlouiKrrp
 k+rkSg+TJwIYBQwIpuWfbDP9VnT3PfDEpC36nXjylohGT+Hb9ppmnXJRuphtLLEKcD4u
 uh8Dfx2cbse9qc/vhFYcuo69baWwNjw/muJYVA+dYzZGn6Fgp8F02jJBhOTlVt5X60k2
 UW/24UzCIx8eISQBxwfapclCLBWw1HNDGQ2nukl7M3PKcZzxtsi8whursrppuY3AOX4n
 4q7A==
X-Forwarded-Encrypted: i=1;
 AL+hErGi0Baz5l4lol0OZVr/53lw+B2ymagPb5wJ+w4a1cpLjWvBgttloP23fEzrWFLwpRtXycvCdXN9BtQN@nongnu.org
X-Gm-Message-State: APuU4Z8LAP2ORY5/DqnjUh7ikukGL5sjoTJJflp7z5GBUT4y1mftdgRp
 /H7BOZFujDF1C9PWNz4rAyqmm3itpWFE13eN5WvTooEvEx0HztR+FDFaVo0aFw0uNVg=
X-Gm-Gg: AYBFou3sqP5M+594zgLXaUNJFp0RlDG+VUlJdNa/SPinnT/HS6rg/9ocxSMd4elwn6K
 qsDqaEV9i4jFuA7cSCJjREWy5wkG1BXYPeWSdirTLuep1YS46alKDoejHItafWvfX/sIRWfUNwG
 syP8O0jBYlnB4X8gNLYgFsgabt/KSQGWYooZ6dvAydjSqSfOnvKGxYvITQ0Y3mopYTcBFizWxua
 9eRwVq3XYi7JUJEJIc8jFLlhSedDxJQT/DkF3gxLCc1RPLLWWhv+pwttgmy1dWefyqQUACsJCnv
 zeHWY5H93XdbO3WvjUpyEM5d5ftfMHjOWPBtp2AtpFoYgDllg7LP+XGMlsThfQ6+qv0zff0gql1
 5oPONLZvA2CJf3ArAsOJQakaE69fMuITMn3MEgDMYbBrnci9PZh1Oqz9x4nd0FrgI3I9LJkF7Xc
 1rvXnUyTxCSSA5kk8y7W6cIxPIJCKRBPIpYtVDRP7Dub3dc6n3YAev++UARbqCN1FmWKd+HuMyy
 4WLgXNDz2PGJrsRCCoBMDAm2bH4ArOxtppuvlxTPSDt7IicpLgjB3efHeypqECkd9ADclhiUJZm
 k71yem3K/etg1ydjDDk2+sSu7l6C7yypdd7hJkOMyZsH8Kn19A==
X-Received: by 2002:a05:6000:268a:b0:48f:d3ba:7314 with SMTP id
 ffacd0b85a97d-49c7178383emr843241f8f.21.1794511565204; 
 Thu, 12 Nov 2026 11:26:05 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c608c5debsm805574f8f.42.2026.11.12.11.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 11:26:04 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 501E25F8CE;
 Thu, 12 Nov 2026 19:26:03 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PULL 03/19] .dir-locals: include QEMU code in PYTHONPATH
In-Reply-To: <CAFEAcA8OOMbrPqhDJ3=K3m5fnfqAQg+Eio46=krPk+PkaLAXeQ@mail.gmail.com>
 (Peter Maydell's message of "Thu, 12 Nov 2026 17:52:43 +0000")
References: <20261023180539.1574134-1-alex.bennee@linaro.org>
 <20261023180539.1574134-4-alex.bennee@linaro.org>
 <CAFEAcA-i6SP=Z96DKvckc-BT0eDXqKUOjdk4ccKUeORB9o=-hw@mail.gmail.com>
 <87cxsaqm1r.fsf@pond.sub.org> <87tslmarws.fsf@draig.linaro.org>
 <CAFEAcA8OOMbrPqhDJ3=K3m5fnfqAQg+Eio46=krPk+PkaLAXeQ@mail.gmail.com>
User-Agent: mu4e 1.14.5-pre1; emacs 30.1
Date: Thu, 12 Nov 2026 19:26:03 +0000
Message-ID: <87o6btc0ms.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 12 Nov 2026 at 17:19, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>> > Peter Maydell <peter.maydell@linaro.org> writes:
>> >
>> >> On Fri, 23 Oct 2026 at 19:06, Alex Benn=C3=A9e <alex.bennee@linaro.or=
g> wrote:
>> >>>
>> >>> When editing python code the linters tools have a hard time with our
>> >>> imports as they can't be found. To ease this we can expand a
>> >>> PYTHONPATH in .dir-locals so at least Emacs users can have less
>> >>> warnings in their editor.
>> >>>
>> >>> I still get complaints from python-mypy about missing library stubs
>> >>> that mean it can't do proper type analysis though.
>
>> >> With this change, emacs now complains and prompts for input every
>> >> time I open a Python file inside the QEMU source tree:
>> >>
>> >> =3D=3D=3Dbegin=3D=3D=3D
>> >> The local variables list in /home/pm215/qemu/
>> >> or .dir-locals.el contains values that may not be safe (*).
>> >>
>> >> Do you want to apply it?  You can type
>> >> y  -- to apply the local variables list.
>> >> n  -- to ignore the local variables list.
>> >> !  -- to apply the local variables list, and permanently mark these
>> >>       values (*) as safe (in the future, they will be set
>> >> automatically.)
>>
>> It should mark them as safe for this particular directory, not generally
>> for setting PYTHONPATH.
>>
>> >> i  -- to ignore the local variables list, and permanently mark these
>> >>       values (*) as ignored
>> >>
>> >>   * eval : (when-let* ((root (locate-dominating-file default-directory
>> >> ".dir-locals.el"))) (setq-local process-environment (copy-sequence
>> >> process-environment)) (setenv "PYTHONPATH" (concat (expand-file-name
>> >> "python" root) ":" (expand-file-name "tests/functional" root))))
>> >> =3D=3D=3Dendit=3D=3D=3D
>> >>
>> >> The commit messages says "so Emacs users can have less warnings"
>> >> but from my POV this is "more warnings" (and previously I didn't
>> >> notice any warnings at all).
>> >
>> > Same here.
>> >
>> > What exactly was the problem this patch tried to solve?
>>
>> It ensures the python lsp's don't complain about invalid imports because
>> they don't have visibility of the PYTHONPATH set by ./run
>
> That's a bit unfortunate, but I think it's a lot less bad
> than emacs complaining every single time you open a python file.

If you trust a project not to do bad things you can set:

  safe-local-variable-directories

which for me is set to:

  ("/home/alex/lsrc/qemu.git/")

But I take your point. I'll figure out how to do this without
.dir-locals and send a revert documenting it.

>
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

