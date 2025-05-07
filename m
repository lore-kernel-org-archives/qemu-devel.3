Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D69C369DC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 05:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCXFG-0001MC-Qr; Wed, 07 May 2025 01:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCXFB-0001I9-Tc
 for qemu-devel@nongnu.org; Wed, 07 May 2025 01:22:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCXFA-0001gu-43
 for qemu-devel@nongnu.org; Wed, 07 May 2025 01:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746595374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W+2t+fDtOvOF1woVL7wLDhyXeuXD1gKxAf88+1HZbR0=;
 b=V6HUAlpYaRdrqkm9cccGB1WPMOMlIKW+kw6SYcBvl1YpS+2/s5IeT4TMZHlwAkPdoXFaC7
 bGviVJqq5Gv4AVsom8u27/o0bSZGqWeSBqSzojROY94kpCwrxoy/N6a/6LPL5lm8Ntlc5n
 GPfC+DsdyKTZbjKoHyq0YRjt+/pWt4U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-S5tHRp6MP3qqSpaFxVsylA-1; Wed,
 07 May 2025 01:22:53 -0400
X-MC-Unique: S5tHRp6MP3qqSpaFxVsylA-1
X-Mimecast-MFC-AGG-ID: S5tHRp6MP3qqSpaFxVsylA_1746595372
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15BF61801BD6; Wed,  7 May 2025 05:22:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A18761953B80; Wed,  7 May 2025 05:22:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 22CEE21E6768; Wed, 07 May 2025 07:22:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,  devel@daynix.com
Subject: Re: [PATCH 1/2] docs: Bump sphinx to 8.2.3
In-Reply-To: <CAFn=p-bSMFVScSNewv_92-3u2FyyN5CYpUkABppazW53CUF-jw@mail.gmail.com>
 (John Snow's message of "Tue, 6 May 2025 15:42:49 -0400")
References: <20250505-sphinx82-v1-0-85f2418b33b1@daynix.com>
 <20250505-sphinx82-v1-1-85f2418b33b1@daynix.com>
 <CAFn=p-bSMFVScSNewv_92-3u2FyyN5CYpUkABppazW53CUF-jw@mail.gmail.com>
Date: Wed, 07 May 2025 07:22:49 +0200
Message-ID: <871pt1ngeu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> On Mon, May 5, 2025 at 8:19=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com>
> wrote:
>
>> sphinx 5.3.0 fails with Python 3.13.1:
>>
>> ../docs/meson.build:37: WARNING:
>> /home/me/qemu/build/pyvenv/bin/sphinx-build:
>> Extension error:
>> Could not import extension sphinx.builders.epub3 (exception: No module
>> named 'imghdr')
>>
>> ../docs/meson.build:39:6: ERROR: Problem encountered: Install a Python 3
>> version of python-sphinx and the readthedoc theme
>>
>> Bump sphinx to 8.2.3 and also sphinx_rtd_theme as required for the new
>> sphinx version.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

[...]

> Can we set our suggested version to 6.2.0 instead? This version removed
> reliance on 'imghdr' but merely requires Python 3.8+ which is our current
> stated minimum.
>
> If Thomas upgrades our minimum Python to 3.9, then we could use something
> as new as 7.2.0 which requires 3.9+.

Thomas did: commit d64db833d6.

> I'd say 8.0.0 is too new (requires 3.10+) and conflicts with our stated
> minimums.

Requiring more recent versions of dependencies for optional parts of the
build can be okay, but the degradation must be graceful.

This makes sense only when the more recent dependencies save us enough
trouble to justify inconveniencing users stuck on older dependencies as
well as the additional build system complexity.

I have no opinion on whether that's the case here.  If you think it is,
make your argument :)

"Graceful" means that if we require Sphinx 8, which requires Python
3.10, the build must still succeed when we have only Python 3.9 (our
stated minimum), but we don't build documentation then.  If the user
demands documentation with configure --enable-docs, the build fails.

[...]


