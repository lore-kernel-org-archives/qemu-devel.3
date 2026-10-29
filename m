Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42D6606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=AVkWnfZT;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9HudvWPO;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=AVkWnfZT;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9HudvWPO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMVua-0005cs-SF; Thu, 29 Oct 2026 15:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMVuZ-0005ch-N8
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:35:43 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xMVuX-0007Xj-3a
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:35:43 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 139BC1F8C2;
 Thu, 29 Oct 2026 19:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793302539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sMc6vrKL4acfS/mt2N09nnIpXaz0N6W/0UBghlP45nE=;
 b=AVkWnfZTq7+pQ6OC7IQow4LYpuZ608jihBcmWnqGGPDN/R2dpStpFLmNKnqxvyi2aPj3fE
 cRwGWME9Z1MUL2nAIeswKxIk8Fc9mfbOrjwEkJaRWJqagn7NnowFMgl1mjj396DpLf7eDx
 QKBSyopwIp9++pR+k5rUJ5Vz2X3SNXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793302539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sMc6vrKL4acfS/mt2N09nnIpXaz0N6W/0UBghlP45nE=;
 b=9HudvWPO96Aot2hIj4dgxu9p21b+7vCv/oXH+0uE3O+knsCiUa4aWiFKvvwF/o49VNF/+W
 sdkKZLp4RDMEUZAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AVkWnfZT;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9HudvWPO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793302539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sMc6vrKL4acfS/mt2N09nnIpXaz0N6W/0UBghlP45nE=;
 b=AVkWnfZTq7+pQ6OC7IQow4LYpuZ608jihBcmWnqGGPDN/R2dpStpFLmNKnqxvyi2aPj3fE
 cRwGWME9Z1MUL2nAIeswKxIk8Fc9mfbOrjwEkJaRWJqagn7NnowFMgl1mjj396DpLf7eDx
 QKBSyopwIp9++pR+k5rUJ5Vz2X3SNXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793302539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sMc6vrKL4acfS/mt2N09nnIpXaz0N6W/0UBghlP45nE=;
 b=9HudvWPO96Aot2hIj4dgxu9p21b+7vCv/oXH+0uE3O+knsCiUa4aWiFKvvwF/o49VNF/+W
 sdkKZLp4RDMEUZAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 896F71339F;
 Thu, 29 Oct 2026 19:35:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0KHkCwqg42oPBQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 29 Oct 2026 19:35:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peterx@redhat.com, mjt@tls.msk.ru,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v5 1/2] tests/docker/dockerfiles: add release.docker
In-Reply-To: <796b02d4-9cb0-4d04-a2cf-ca167fb01eb9@oss.qualcomm.com>
References: <20261029000853.15166-1-pierrick.bouvier@oss.qualcomm.com>
 <20261029000853.15166-2-pierrick.bouvier@oss.qualcomm.com>
 <87ld7gin6q.fsf@suse.de>
 <7757e99b-0338-4508-b36f-9460d4efdb2f@oss.qualcomm.com>
 <87fqxoic5s.fsf@suse.de>
 <796b02d4-9cb0-4d04-a2cf-ca167fb01eb9@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 16:35:32 -0300
Message-ID: <87cxssi9kr.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 139BC1F8C2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,qualcomm.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.51
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 10/29/2026 10:39 AM, Fabiano Rosas wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>=20
>>> On 10/29/2026 6:41 AM, Fabiano Rosas wrote:
>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>
>>>>> This new dockerfile allows to build a distroless image containing only
>>>>> qemu stripped release binaries, their lib dependencies, and installed
>>>>> artifacts (roms, keymap, ...). There is no shell, no python, nothing
>>>>> else. This is achieved thanks to a multi-stage build, where we add qe=
mu
>>>>> binaries, artifacts and libraries in a new scratch image. Image has
>>>>> the minimal size possible.
>>>>>
>>>>> This is based on Ubuntu, which has the advantage to have working
>>>>> containers available down to 14.04. Debian old old stable have broken
>>>>> apt sources for instance.
>>>>>
>>>>> This unique dockerfile works for all qemu versions >=3D 3.1.0 (2018).
>>>>> We could build down to v0.12.0, but it would require more tweaks in t=
he
>>>>> dockerfile, so we keep it simple instead.
>>>>>
>>>>> To build the image, you need to provide a qemu and ubuntu version:
>>>>> $ podman build -f release.Dockerfile --build-arg QEMU_VERSION=3Dv11.1=
.0 --build-arg UBUNTU_VERSION=3D24.04 -t qemu/v11.1.0
>>>>>
>>>>> To run it, as there is no shell, and no defined entrypoint, you need =
to
>>>>> choose the binary you want explicitely:
>>>>> $ podman run -it --rm qemu/v11.1.0 qemu-system-aarch64 --version
>>>>>
>>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
>>>>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>> ---
>>>>>  tests/docker/dockerfiles/release.docker | 48 +++++++++++++++++++++++=
++
>>>>>  1 file changed, 48 insertions(+)
>>>>>  create mode 100644 tests/docker/dockerfiles/release.docker
>>>>>
>>>>> diff --git a/tests/docker/dockerfiles/release.docker b/tests/docker/d=
ockerfiles/release.docker
>>>>> new file mode 100644
>>>>> index 00000000000..ca6babde01e
>>>>> --- /dev/null
>>>>> +++ b/tests/docker/dockerfiles/release.docker
>>>>> @@ -0,0 +1,48 @@
>>>>> +ARG UBUNTU_VERSION=3D"UBUNTU_VERSION_build_arg_must_be_set"
>>>>> +
>>>>> +FROM ubuntu:$UBUNTU_VERSION AS build
>>>>> +
>>>>> +# add deb-src for apt build-dep
>>>>> +RUN sed -e 's/Types: deb/Types: deb deb-src/' -i /etc/apt/sources.li=
st.d/* || true
>>>>> +RUN sed -e 's/# deb-src/deb-src/' -i /etc/apt/sources.list
>>>>> +# archive.canonical.com is not reachable anymore, and cause a long t=
imeout
>>>>> +RUN sed -e '/archive.canonical.com/d' -i /etc/apt/sources.list
>>>>> +
>>>>> +# build dependencies
>>>>> +RUN apt update && \
>>>>> +env DEBIAN_FRONTEND=3Dnoninteractive apt install -y git build-essent=
ial flex bison
>>>>> +RUN apt update && \
>>>>> +env DEBIAN_FRONTEND=3Dnoninteractive apt build-dep -y --arch-only qe=
mu
>>>>> +
>>>>> +ARG QEMU_VERSION
>>>>> +RUN echo "QEMU_VERSION=3D${QEMU_VERSION:?QEMU_VERSION build arg must=
 be set}"
>>>>> +ARG QEMU_REPO=3D"https://gitlab.com/qemu-project/qemu.git"
>>>>> +
>>>>> +RUN cd /tmp && \
>>>>> +mkdir qemu && cd qemu && git init && \
>>>>> +git remote add origin "${QEMU_REPO}" && \
>>>>> +git fetch origin "${QEMU_VERSION}" --depth 1 && \
>>>>> +git checkout FETCH_HEAD && \
>>>>> +./configure --prefix=3D/opt/qemu --disable-docs --disable-werror && \
>>>>> +make install -j $(nproc) && \
>>>>> +strip /opt/qemu/bin/* && \
>>>>
>>>> For the record, here I included a 'cp <list of bins> /opt/qemu/bin' li=
ne
>>>> to make migration-test work from inside the container:
>>>>
>>>> migration-test
>>>> sh
>>>> env
>>>> docker (installed as docker.io up there)
>>>> cat
>>>>
>>>
>>> You mean by mounting current folder in the container?
>>>
>>=20
>> I mean having the test binary present in the container as well.
>>=20
>> This is something specific to migration compat testing: to avoid having
>> issues due to features mismatches, we run the older version of
>> migration-test when testing two different QEMU versions.
>>=20
>> But then...
>> $ git checkout <old tag>
>> $ make check-build
>> $ ./migration-test <QEMU old container> <QEMU new container>
>>=20
>> is kind of wasteful. I can simply build a container with QEMU +
>> migration-test already in it and invoke:
>>=20
>> $ ./<migration-test old container> <QEMU old container> <QEMU new contai=
ner>
>>
>
> Ok, I see. I'm not very familiar with migration testing, and assumed the
> logic was opposite (that migration-test is backward compatible to test
> from old versions).
>

It was the original idea, but we noticed it was way easier to just pin
the test.

> But migration-test is not included in old container, since it's a test
> binary (thus not installed). I feel that for this case, you need to
> build from sources, at least to get migration-test-old.
>

It's built inside the container along with QEMU. The cp line I added
brings it over.

>>> I'm not against it, but I feel that if we go this way, it's just easier
>>> to say "let's use the full base image", since it will become "I need to
>>> run python, and X, and Y, and Z".
>>>
>>=20
>> I think we should merge this series as is. However if we intend to use
>> it in the future for something more complex, something like the above
>> will probably come up. Anyway, I posted literally "for the record".
>>
>
> Sure, I'm just interested to make something useful for you. If it's half
> baked, there is little value in merging this.
>

I don't want to enlarge this container too much. In its current form
it's also useful to others.

For migration, we'd need the extra binaries I mentioned plus the output
of -dump-vmstate to run ./scripts/vmstate-static-checker.py. It's
probably better to have a separate container image with those.

> Regards,
> Pierrick

