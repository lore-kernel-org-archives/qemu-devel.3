Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D951C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 11:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOEsW-0001cQ-Np; Mon, 01 Jul 2024 07:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sOEsU-0001MU-Kg
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:07:22 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sOEsS-00066w-4Y
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:07:22 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a7241b2fe79so296298466b.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 04:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719832038; x=1720436838; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Od2/jZBLxgbQRrQXshh83CzTsx/CJFDt98b+evwPNE=;
 b=wwq39pqBFQM5KgigKbvB1v5470CBGPq4piSpSzmgzQf+QJKqluQdBY7va/djYgfn86
 setIQCy1ojo5LQ7hYV6HdKfYppENPSe5W3pN8u1QUZw46GKuWaT6L1gGduJcEqAtkM/k
 W4eX3ygkSPbiWoa0Jqi7IwUxLwA3EgFy/FUv718qCssQ1g01aBGyGVIc6evgMMtetfjI
 S1PsQQEQbE5DfRFsVg6+aR11uMCI/Iwb5P8jb/lPfyKRu8tlaAvQ1b9uuVV/0+ABRvmp
 j/Iwf7ow9+IadLLlDY9h2uPNPSGp9rnAGxvSqBe044tODx5CaEy8pvGwsRPwZmaRi5ez
 5rLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719832038; x=1720436838;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Od2/jZBLxgbQRrQXshh83CzTsx/CJFDt98b+evwPNE=;
 b=IbDrBUzt8HCnzD3RUFxvW04QuvQugi5lAqEpvmrJ8/q/7uHHYlok7j+vr/4fAO2LQ7
 gqGLktqgShsAQgx0UpJ0HtCMORDfCFS1nvgOMke6OXetnrk7ZWxCTxEN/UxJ7VB7yxad
 wZ4vCgu/4q5zFLTEpJ69WOmIJ/VtpAbRQU0GFFIqZxS7g4Z4tN4emmeE56iu5kgV27oe
 csw9vBovs8OXutAkyxa/SyfPBDjnxl7MFJUUqfD20RtIwZF7oMs4t+WiH6LtXLOS6UZb
 tkG2oQLvLfhP/qpTAxBUoP1/Um7GgEsJmnb83t70FHinQuPtvP9NmXPWH9w0OZqQ15d+
 xeTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpXskzLv5J5rdQGnc65zG+gNbDd9cXhKVs+q5e/Uwbe7F7LuUklLkST7VUjsGFFoxUVy9W02gJ+eVYYMN49ooCZ/PgaHY=
X-Gm-Message-State: AOJu0Yxe/8JRMa12YOts2G6OG8YBG1zX23RgYlU+g71c/CnwLMzsVdhL
 nbymrHEXtaa2vrGFbvyd4UeJySy7LjkBG06S/Z+cx95AzCorqXy8MX9I1RKay5kgI9cEXqYTB9B
 bHyeXSKAqiWGGohm2Csgbo2rSyZ/NNZ3k2Wr1hA==
X-Google-Smtp-Source: AGHT+IGz02tGKxERCfC5Yigs+6ggl6sTE5HkWjYzw9VXX2F+TCfOL6sQ7KGQk+WeUybvu1pB+TtGnONMWWmlJiFHj74=
X-Received: by 2002:a17:906:3748:b0:a72:7d95:a786 with SMTP id
 a640c23a62f3a-a751445461dmr359830366b.25.1719832037517; Mon, 01 Jul 2024
 04:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240610144708.81351-1-berto@igalia.com>
 <eyt18.e0s2rty6vd9y@linaro.org> <w51sewtpk1t.fsf@igalia.com>
In-Reply-To: <w51sewtpk1t.fsf@igalia.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 1 Jul 2024 14:07:01 +0300
Message-ID: <CAAjaMXau1qvDrBGn1Kj4Z7g0rRGsp0x6n9hmyK_-SA2HFeZ0Pg@mail.gmail.com>
Subject: Re: [PATCH] scripts/qcow2-to-stdout.py: Add script to write qcow2
 images to stdout
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Madeeha Javed <javed@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x635.google.com
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

Hi Berto :)

On Mon, 1 Jul 2024 at 11:56, Alberto Garcia <berto@igalia.com> wrote:
>
> On Wed 12 Jun 2024 02:00:19 PM +03, Manos Pitsidianakis wrote:
>
> Hi, thanks for the review and sorry for taking so long to reply, I was
> on vacation.
>
> >> scripts/qcow2-to-stdout.py | 330 +++++++++++++++++++++++++++++++++++++
> >> 1 file changed, 330 insertions(+)
> >> create mode 100755 scripts/qcow2-to-stdout.py
> >
> > I recommend running the `black` formatter on this script, it makes the
> > code more diff-friendly and uniform. Also it has become the de-facto
> > python style.
>
> Hmmm, I don't like how it reformats some of the lines. However other
> changes do make sense, so I'll apply those.

It's not a project coding style requirement (for now) so it's fine.

>
> > Also, it's more pythonic to name constants in uppercase, like
> > allocated_l2_tables. You can check such lints with pylint
> > scripts/qcow2-to-stdout.py
>
> allocated_l2_tables is not a constant :-?

Eeeh right, correct. `pylint`'s error message said it was a constant,
my bad. It says it is a constant because it is declared as a global
(module-level), `__all__` is not defined with any globals, and
according to PEP-8 non-public globals start with an underscore in the
name.

>
> >>+    struct.pack_into('>I', header, 0x70, 0x6803f857)
> >>+    struct.pack_into('>I', header, 0x74, len(qcow2_features) * 48)
> >>+    cur_offset =3D 0x78
> >
> > Minor comment: extract magic values/offsets into constant globals with
> > descriptive names, it'd help the code be more readable and easier to
> > maintain if ported in the future to other formats.
>
> Good idea, will do.
>
> >>+    for (feature_type, feature_bit, feature_name) in qcow2_features:
> >>+        struct.pack_into('>BB46s', header, cur_offset,
> >>+                         feature_type, feature_bit, feature_name.encod=
e('ascii'))
> >>+        cur_offset +=3D 48
> >>+
> >
> >>From here onwards put everything under a main block like so:
>
> Ok.
>
> >>+# Command-line arguments
> >>+parser =3D argparse.ArgumentParser(description=3D'This program convert=
s a QEMU disk image to qcow2 '
> >>+                                 'and writes it to the standard output=
')
> >>+parser.add_argument('input_file', help=3D'name of the input file')
> >
> > Suggestion:
> >
> > -parser.add_argument('input_file', help=3D'name of the input file')
> > +parser.add_argument('input_file', help=3D'name of the input file', typ=
e=3Dpathlib.Path, required=3DTrue)
>
> 'required' is not valid in positional arguments,

Sorry did not notice it's a positional!

> and I'm not sure what
> benefits using pathlib brings in this case.

implicit type requirement, argument value validations, path normalization e=
tc.

>
> >>+parser.add_argument('-v', dest=3D'qcow2_version', metavar=3D'qcow2_ver=
sion',
> >
> > Maybe -q instead of -v? No strong feelings on this one, it's just that
> > -v is usually version. -q is also usually --quiet so not sure...
>
> Yeah, I thought the same but I didn't want to complicate this too much,
> this is just a helper script.
>
> >>+# If the input file is not in raw format we can use
> >>+# qemu-storage-daemon to make it appear as such
> >>+if input_format !=3D 'raw':
> >>+    temp_dir =3D tempfile.mkdtemp()
> >
> > Consider using the tempfile.TemporaryDirectory as with... context
> > manager so that the temp dir cleanup is performed automatically
>
> I don't think I can do that directly here because the temp dir has to
> live until the very end (qemu-storage-daemon needs it).
>
> >>+    pid_file =3D temp_dir + "/pid"
> >>+    raw_file =3D temp_dir + "/raw"
> >>+    open(raw_file, 'wb').close()
> >
> > Consider using a with open(...) open manager for opening the file
>
> How would that be? Like this?
>
>     with open(raw_file, 'wb'):
>         pass
>
> If so I don't see the benefit, I just need to create an empty file and
> close it immediately.

My only argument here is that it's "more pythonic" which I know is of
little value and consequence :) Feel free to ignore! They were mere
suggestions.

>
> >>+    atexit.register(kill_storage_daemon, pid_file, raw_file, temp_dir)
> >
> > Hm, this too could be a context manager. Seems very C-like to use
> > atexit here.
>
> Yeah it is, but I think that using the context manager would require me
> to split the main function in two, and I'm not sure that it's worth it
> for this case. Other Python scripts in the QEMU repo use atexit already.
>
> >>+    ret =3D subprocess.run(["qemu-storage-daemon", "--daemonize", "--p=
idfile", pid_file,
> >>+                          "--blockdev", f"driver=3Dfile,node-name=3Dfi=
le0,driver=3Dfile,filename=3D{input_file},read-only=3Don",
> >>+                          "--blockdev", f"driver=3D{input_format},node=
-name=3Ddisk0,file=3Dfile0,read-only=3Don",
> >>+                          "--export", f"type=3Dfuse,id=3Dexport0,node-=
name=3Ddisk0,mountpoint=3D{raw_file},writable=3Doff"])
> >
> > You can add shell=3DTrue, check=3DFalse arguments to subprocess.run() s=
o
> > that it captures the outputs. (check=3DFalse is the default behavior, b=
ut
> > better make it explicit)
>
> I'm not sure that I understand, why would I need to use a shell here?

I must have meant capture_output=3DTrue, not shell=3DTrue, sorry for that
=F0=9F=A4=94. The explicit check=3DFalse says to the reader that this won't=
 throw
an exception so it's just for readability. The capture_output part is
so that you can print the outputs if the return code is an error.

I wouldn't want to overcomplicate things for no real reason,
especially for a simple single patch like this so I suggested minor
stuff for code readability. Should have made it more explicit in the
first place! :)

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

