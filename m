Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A158CEFC32
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 16:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syDQC-0007Tg-5t; Tue, 08 Oct 2024 12:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1syDQ8-0007T3-5n
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 12:50:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1syDQ5-0003qU-B8
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 12:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728406242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8N0a6zpkIEoby3R/NddoQweXNNf5JiWwyS0NVESqE5g=;
 b=GC/rRUSiZwlKzX4lgUZYd2A66knkWxJThVsDE1A2f99wNs+z5RLPVPc9d6GrMVhcCz3ZMF
 KkY2oQ4KNYaypj3xcaxuH2ujNGoplBXVer8gcpVe3dqdZM7qzJZ8eQlcIrk/KFE9XWRMK2
 mqQJhQ3aB5tSiFFjprLtw55pmHD3+IM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-OEPWsZssN9K3KY7shNf12Q-1; Tue, 08 Oct 2024 12:50:40 -0400
X-MC-Unique: OEPWsZssN9K3KY7shNf12Q-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-7d4fc1a2bb7so5424476a12.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 09:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728406239; x=1729011039;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8N0a6zpkIEoby3R/NddoQweXNNf5JiWwyS0NVESqE5g=;
 b=YCLiloL5rjJCvn6chG3wn4YEM+VzNZ9uGOl7SgWk+Wq1QXFB4638K7q2D1dqUb0neE
 qZsyn62hRF0jJz7yx+wgSg3QSkwTNKY54p3KEQ85dbfmy5V5CSGTui740x+kKjdme+0Y
 OpkT0bKQUoIQQrwI7xJjNXoBjEccJ2Wev7W7J147RGe3dqeHb+Z+p3e2GLbfsQfTG8op
 zywojplKRa+v/3evb+xTufFbutdb+QZJQyCVip2p2q1K5t+Rrrn9dF77ZQnAMw8MUAOI
 2qJvsMIaIy4q3+Qk/xcrnenOKIvsxI/Cay2wREqelpgOZmrFrcB7M8iqfERpEDoSsXVA
 55Rg==
X-Gm-Message-State: AOJu0YwHY0WzOAgMOifSRwxjDsQCwrxAoBzsF/H+Q44dClnBpbFd9pfA
 BrNUsuAcFB3vOqqlVZw/6TD3yCQZ0d7blkr9agxW0i6kyMk90bC8TDC5nrkQGtJI7YwgXfhkctl
 h8JUpss5y1IXQGAyS8MSptoZDr6YNOjNEBHFv1bB//4Jy/f/qSosjzkbBjGpFAdSb//gxBLbEXg
 KOe/TGSo1LZL8aCAX0Hmd0QB75DT0=
X-Received: by 2002:a17:902:f650:b0:20b:5b1a:209 with SMTP id
 d9443c01a7336-20bfe022a28mr207515045ad.9.1728406239658; 
 Tue, 08 Oct 2024 09:50:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrXJlm4Z+W+GlaGQ7XU+Wr2MzgbgBRSApnrcTCyKLy5x2pfEXt7rB+UOWbp7f0QaDwrlpf56u82V3DANzSL4s=
X-Received: by 2002:a17:902:f650:b0:20b:5b1a:209 with SMTP id
 d9443c01a7336-20bfe022a28mr207514745ad.9.1728406239291; Tue, 08 Oct 2024
 09:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_y6xYLyK_qEjngtCm+Y5-Yuw-rqK2Qm0UhVAFHtp610w@mail.gmail.com>
In-Reply-To: <CAFEAcA_y6xYLyK_qEjngtCm+Y5-Yuw-rqK2Qm0UhVAFHtp610w@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 8 Oct 2024 12:50:26 -0400
Message-ID: <CAFn=p-ZU8sDP6xEN=AD6gN-OLCOgSOZ=WxfHZeCmzJVgwcYpcQ@mail.gmail.com>
Subject: Re: qemu-iotests test 297 tries to run python linters on editor
 backup files
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000ebca9a0623f9ef9f"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000ebca9a0623f9ef9f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024, 12:31=E2=80=AFPM Peter Maydell <peter.maydell@linaro.o=
rg>
wrote:

> I made some changes to a block backend so I wanted to run the iotests.
> I ran into an unrelated failure of iotest 297. The bulk of this
> seems to be because the iotest tries to run on all files
> in qemu-iotests, even on editor backups like in this case "040~"
> (which is an old editor backup of 040). But there are also
> some warnings about files that do exist in the tree and which
> I haven't modified:
>
> +tests/migrate-bitmaps-test:63:4: R0201: Method could be a function
> (no-self-use)
> +tests/mirror-change-copy-mode:109:4: R0201: Method could be a
> function (no-self-use)
> +fat16.py:239:4: R0201: Method could be a function (no-self-use)
>
> Q1: can we make this test not run the linters on editor backup files?
>

Shouldn't be a problem. AFAIK we decide what to lint based on looking for
the shebang in the file and exclude a known-bad list, but we can exclude
the emacs confetti files too.

I'll fix it.

(Guess I haven't been editing the tests for a while... and nobody else has
mentioned it. oops.)

Q2: why do I see the errors above but they aren't in the reference file
> output?
>

You mean, why are there errors in files you haven't modified?

Very likely: pylint version differences. I've been meaning to remove iotest
297 for a long time, but when you run it directly through iotests (i.e. not
through the python directory tests, the ones that run on gitlab ci), the
linter versions are not controlled for. It's a remaining ugly spot of the
python consistency work. (sparing you the details on why but it's a known
thing I need to fix.)

In this case I bet "check-python-tox" (an optionally run, may-fail job) is
also failing on gitlab and I didn't notice yet.

for now (assuming my guesses above are right): I'll fix 297 to tolerate the
newest versions. As soon as I'm done my sphinx work, I'll pivot back to
finally adding a "check python" subtest to "make check" that *does* control
linter versions, and delete iotest 297.

Just in case my guesses are wrong, can you please go to your QEMU build
directory (post-configure) and type:

> source pyvenv/bin/activate.[whatever shell suffix you use]
> pylint --version
> deactivate

and let me know what version of pylint you have in the qemu build
environment?


>
> e104462:jammy:qemu-iotests$ ./check 297
> QEMU          --
>
> "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/qemu-system-x8=
6_64"
> -nodefaults -display none -accel qtest
> QEMU_IMG      --
> "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/qemu-img"
> QEMU_IO       --
> "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/qemu-io"
> --cache writeback --aio threads -f raw
> QEMU_NBD      --
> "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/qemu-nbd"
> IMGFMT        -- raw
> IMGPROTO      -- file
> PLATFORM      -- Linux/x86_64 e104462 5.15.0-89-generic
> TEST_DIR      --
>
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/tests/qemu-iote=
sts/scratch
> SOCK_DIR      -- /tmp/qemu-iotests-0c1ft_vw
> GDB_OPTIONS   --
> VALGRIND_QEMU --
> PRINT_QEMU_OUTPUT --
>
> 297   fail       [17:26:10] [17:26:23]   13.1s                output
> mismatch (see
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/tests/qemu-iote=
sts/scratch/raw-file-297/297.out.bad)
>     [case not run] 'mypy' not found
>
> --- /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/qemu-iotests/297.out
> +++
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/tests/qemu-iote=
sts/scratch/raw-file-297/297.out.bad
> @@ -1,2 +1,74 @@
>  =3D=3D=3D pylint =3D=3D=3D
> +************* Module migrate-bitmaps-test
> +tests/migrate-bitmaps-test:63:4: R0201: Method could be a function
> (no-self-use)
> +************* Module mirror-change-copy-mode
> +tests/mirror-change-copy-mode:109:4: R0201: Method could be a
> function (no-self-use)
> +************* Module fat16
> +fat16.py:239:4: R0201: Method could be a function (no-self-use)
> +************* Module 040~
> +040~:50:0: C0301: Line too long (85/79) (line-too-long)
> +040~:64:0: C0301: Line too long (86/79) (line-too-long)
> +040~:91:0: C0301: Line too long (138/79) (line-too-long)
> [PMM: deleted a lot more warnings about this editor backup file]
>  =3D=3D=3D mypy =3D=3D=3D
> Some cases not run in:
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/qemu-iotests/297
> Failures: 297
> Failed 1 of 1 iotests
>
> thanks
> -- PMM
>

Thanks for the report.
--js

>

--000000000000ebca9a0623f9ef9f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Oct 8, 2024, 12:31=E2=80=AFPM Peter Maydell &l=
t;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">I made some changes to a=
 block backend so I wanted to run the iotests.<br>
I ran into an unrelated failure of iotest 297. The bulk of this<br>
seems to be because the iotest tries to run on all files<br>
in qemu-iotests, even on editor backups like in this case &quot;040~&quot;<=
br>
(which is an old editor backup of 040). But there are also<br>
some warnings about files that do exist in the tree and which<br>
I haven&#39;t modified:<br>
<br>
+tests/migrate-bitmaps-test:63:4: R0201: Method could be a function<br>
(no-self-use)<br>
+tests/mirror-change-copy-mode:109:4: R0201: Method could be a<br>
function (no-self-use)<br>
+fat16.py:239:4: R0201: Method could be a function (no-self-use)<br>
<br>
Q1: can we make this test not run the linters on editor backup files?<br></=
blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Should=
n&#39;t be a problem. AFAIK we decide what to lint based on looking for the=
 shebang in the file and exclude a known-bad list, but we can exclude the e=
macs confetti files too.</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>I&#39;ll fix it.</div><div dir=3D"auto"><br></div><div dir=3D"auto">(Guess=
 I haven&#39;t been editing the tests for a while... and nobody else has me=
ntioned it. oops.)</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Q2: why do I see the errors above but they aren&#39;t in the reference file=
<br>
output?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D=
"auto">You mean, why are there errors in files you haven&#39;t modified?</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Very likely: pylint versio=
n differences. I&#39;ve been meaning to remove iotest 297 for a long time, =
but when you run it directly through iotests (i.e. not through the python d=
irectory tests, the ones that run on gitlab ci), the linter versions are no=
t controlled for. It&#39;s a remaining ugly spot of the python consistency =
work. (sparing you the details on why but it&#39;s a known thing I need to =
fix.)</div><div dir=3D"auto"><br></div><div dir=3D"auto">In this case I bet=
 &quot;check-python-tox&quot; (an optionally run, may-fail job) is also fai=
ling on gitlab and I didn&#39;t notice yet.</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">for now (assuming my guesses above are right): I&#39;ll=
 fix 297 to tolerate the newest versions. As soon as I&#39;m done my sphinx=
 work, I&#39;ll pivot back to finally adding a &quot;check python&quot; sub=
test to &quot;make check&quot; that *does* control linter versions, and del=
ete iotest 297.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Just in =
case my guesses are wrong, can you please go to your QEMU build directory (=
post-configure) and type:</div><div dir=3D"auto"><br></div><div dir=3D"auto=
">&gt; source pyvenv/bin/activate.[whatever shell suffix you use]</div><div=
 dir=3D"auto">&gt; pylint --version</div><div dir=3D"auto">&gt; deactivate<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">and let me know what ver=
sion of pylint you have in the qemu build environment?</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
<br>
e104462:jammy:qemu-iotests$ ./check 297<br>
QEMU=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --<br>
&quot;/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/qemu-system=
-x86_64&quot;<br>
-nodefaults -display none -accel qtest<br>
QEMU_IMG=C2=A0 =C2=A0 =C2=A0 --<br>
&quot;/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/qemu-img&qu=
ot;<br>
QEMU_IO=C2=A0 =C2=A0 =C2=A0 =C2=A0--<br>
&quot;/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/qemu-io&quo=
t;<br>
--cache writeback --aio threads -f raw<br>
QEMU_NBD=C2=A0 =C2=A0 =C2=A0 --<br>
&quot;/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/qemu-nbd&qu=
ot;<br>
IMGFMT=C2=A0 =C2=A0 =C2=A0 =C2=A0 -- raw<br>
IMGPROTO=C2=A0 =C2=A0 =C2=A0 -- file<br>
PLATFORM=C2=A0 =C2=A0 =C2=A0 -- Linux/x86_64 e104462 5.15.0-89-generic<br>
TEST_DIR=C2=A0 =C2=A0 =C2=A0 --<br>
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/tests/qemu-iotest=
s/scratch<br>
SOCK_DIR=C2=A0 =C2=A0 =C2=A0 -- /tmp/qemu-iotests-0c1ft_vw<br>
GDB_OPTIONS=C2=A0 =C2=A0--<br>
VALGRIND_QEMU --<br>
PRINT_QEMU_OUTPUT --<br>
<br>
297=C2=A0 =C2=A0fail=C2=A0 =C2=A0 =C2=A0 =C2=A0[17:26:10] [17:26:23]=C2=A0 =
=C2=A013.1s=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 output<b=
r>
mismatch (see /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/tes=
ts/qemu-iotests/scratch/raw-file-297/297.out.bad)<br>
=C2=A0 =C2=A0 [case not run] &#39;mypy&#39; not found<br>
<br>
--- /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/qemu-iotests/297.out<b=
r>
+++ /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/tests/qemu-io=
tests/scratch/raw-file-297/297.out.bad<br>
@@ -1,2 +1,74 @@<br>
=C2=A0=3D=3D=3D pylint =3D=3D=3D<br>
+************* Module migrate-bitmaps-test<br>
+tests/migrate-bitmaps-test:63:4: R0201: Method could be a function<br>
(no-self-use)<br>
+************* Module mirror-change-copy-mode<br>
+tests/mirror-change-copy-mode:109:4: R0201: Method could be a<br>
function (no-self-use)<br>
+************* Module fat16<br>
+fat16.py:239:4: R0201: Method could be a function (no-self-use)<br>
+************* Module 040~<br>
+040~:50:0: C0301: Line too long (85/79) (line-too-long)<br>
+040~:64:0: C0301: Line too long (86/79) (line-too-long)<br>
+040~:91:0: C0301: Line too long (138/79) (line-too-long)<br>
[PMM: deleted a lot more warnings about this editor backup file]<br>
=C2=A0=3D=3D=3D mypy =3D=3D=3D<br>
Some cases not run in:<br>
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/qemu-iotests/297<br>
Failures: 297<br>
Failed 1 of 1 iotests<br>
<br>
thanks<br>
-- PMM<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Thanks for the report.</div><div dir=3D"auto">--js</div><div dir=3D"a=
uto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000ebca9a0623f9ef9f--


