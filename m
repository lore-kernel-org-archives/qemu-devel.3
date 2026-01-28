Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA3FD35697
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 09:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl1hI-0007Dh-8X; Wed, 28 Jan 2026 04:18:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vl1hF-00075t-4H
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 04:18:45 -0500
Received: from k57.kb8c70eb.use4.send.mailgun.net ([204.220.184.57])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vl1hC-00018d-6Z
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 04:18:44 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 4b20cd8d1a1242f0b46c1e31ddc214a3f81d77c3c1f55a501848d82fe35a1068 with SMTP id
 6979d468b7a6b47810f41109; Wed, 28 Jan 2026 09:18:32 GMT
X-Mailgun-Sending-Ip: 204.220.184.57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1769591912;
 bh=A8obmdOrS8w88MsuXtLcxiF+B+SeC1JA5HGAWo1Axxs=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 X-Mailgun-Dkim:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=dpjf1QK1I+4w85No6lXXa9v6HD7yKtdwTxyGRI7e1NS2zBHHTIKKfRBAZD3yRib5S
 Af6xqeWSVO0fiRK+dGZFIhbwnDxwMmRKi9hcEz4YwNf7t+kmqEr79viCLwl2QQ2T+4
 mcAEkW88Qcmbcsj5xD/GsW8AW3SZE27XCCGHSdHeS0Fdhhpwq4Z0t1XgEJDcYnAOSl
 TQ6GuIk6q492yrggxi1+ka2JYPPIzxBsrpv8xyklysgKvj4gLZYLe70qo7CFbRxLeg
 yVms0x/aaBtzwn+pyiaQv7LwXxBJSXMt1q9ttAQumK3dFedlvTCm6BRseqScxn3dtT
 Ls2nBFWeelv7Q==
Message-ID: <d048ce39-c0fc-487b-8940-ed23c4b2cb1a@yodel.dev>
Date: Wed, 28 Jan 2026 03:18:30 -0600
MIME-Version: 1.0
Subject: Re: [PATCH 09/37] scripts/modinfo: add type annotations
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-10-marcandre.lureau@redhat.com>
Content-Language: en-US
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <20260123074945.2563196-10-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=204.220.184.57;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=k57.kb8c70eb.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

+ Pierrick, because of name-check.

Hi, Marc-André

On 23/01/2026 01:49, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   scripts/modinfo-generate.py | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 

Are you planning on adding a commit body to the message? I favor
type annotations in most cases including here, because it helps with
readability among other reasons; it would be nice if you included your
reasoning so that we could see more of it over time.

In any case, thanks for the patch and please take these:

Reviewed-by: Yodel Eldar <yodel.eldar@yodel.dev>
Tested-by: Yodel Eldar <yodel.eldar@yodel.dev>

Testing based on 20260122201950.214834-1-pierrick.bouvier@linaro.org,
because building microblaze with --enable-modules is currently broken
on mainline. Pierrick's patch is already reviewed and will probably
land soon.

Commands used to test from build/:
$ ../configure --enable-modules --disable-docs
$ make -j$(nproc)
$ fd -0 -E '.cache' '^modinfo-|\.modinfo$' build/ | sort -z | xargs -0 
cat | sha256sum

Ran the above both with and without your patch and confirmed that the
hashsum was identical on x86_64 Linux.

Thanks,
Yodel

> diff --git a/scripts/modinfo-generate.py b/scripts/modinfo-generate.py
> index aaf23544c46..5a8abcae5d3 100644
> --- a/scripts/modinfo-generate.py
> +++ b/scripts/modinfo-generate.py
> @@ -2,14 +2,16 @@
>   
>   import os
>   import sys
> +from typing import Optional
>   
> -def print_array(name, values):
> +
> +def print_array(name: str, values: list[str]) -> None:
>       if len(values) == 0:
>           return
>       list = ", ".join(values)
>       print("    .%s = ((const char*[]){ %s, NULL })," % (name, list))
>   
> -def parse_line(line):
> +def parse_line(line: str) -> tuple[str, str]:
>       kind = ""
>       data = ""
>       get_kind = False
> @@ -31,7 +33,7 @@ def parse_line(line):
>               continue
>       return (kind, data)
>   
> -def generate(name, lines, enabled):
> +def generate(name: str, lines: list[str], enabled: set[str]) -> Optional[set[str]]:
>       arch = ""
>       objs = []
>       deps = []
> @@ -68,17 +70,17 @@ def generate(name, lines, enabled):
>       print("},{")
>       return {dep.strip('" ') for dep in deps}
>   
> -def print_pre():
> +def print_pre() -> None:
>       print("/* generated by scripts/modinfo-generate.py */")
>       print("#include \"qemu/osdep.h\"")
>       print("#include \"qemu/module.h\"")
>       print("const QemuModinfo qemu_modinfo[] = {{")
>   
> -def print_post():
> +def print_post() -> None:
>       print("    /* end of list */")
>       print("}};")
>   
> -def main(args):
> +def main(args: list[str]) -> None:
>       if len(args) < 3 or args[0] != '--devices':
>           print('Expected: modinfo-generate.py --devices '
>                 'config-device.mak [modinfo files]', file=sys.stderr)


