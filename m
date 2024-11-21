Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4664ED7876B
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 14:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE8HO-0002MV-LE; Thu, 21 Nov 2024 09:35:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tE8HN-0002ME-3v
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 09:35:33 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tE8HK-00057L-8y
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 09:35:32 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ea4d429e43so818371a91.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 06:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1732199727; x=1732804527;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oa//9HiLv+OzTTvxthDQo8QphxTa8XGR6rR8rK6C1JQ=;
 b=Rjh4H4Sc4XM1FI4tbAJm1Xx8f2t40/T8pmOzW8uzSEdzBdcYetSQ0Dy/NQnQfffqjI
 37vt//pI3sewe6eyVywa3Oc6B2qT7wbV0dmgJA5dpUwaYOPhvwlNAiAcl0jEQ4RoM0xl
 L0PhPbzbdVNFUDFjx88LL4ML3uyPqRA1XQ0mpnj/oGvBn68j+3+S8qvj9PfoWQMtPp0e
 KIU0HrbJgsGvoqxUrFUnDULsjfqec5xWR7UUcR9qpdAKg+bzeaWhLABiS9b7Lg0ADl+D
 a+r6ccrfNJ9US8JvsQjstBcvJmV5V0x0BMseTOhnXbuSfLjdJzfVZ/O8BzVzM9bez9g4
 Jjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732199727; x=1732804527;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oa//9HiLv+OzTTvxthDQo8QphxTa8XGR6rR8rK6C1JQ=;
 b=EY+ZeLboLr1eyukiw5DWDrW0I0u8v+gSM90LtAkTTXQ3JDSMKvDVKxhyyZbf642sS3
 WHlK6SA0xpDc4XImDZoall9Ua+6gu0eZu45pBciAdxQPUuqAzsBk7ifbkjvjKPJxw+Ql
 sLGpM7MjzuCp9S0UN2N6nVOU/6kSrfEo8Cf3oaP7iEDZBiBcMJ/LPiVxEC52PN9ZWFnb
 8QKnxTUsDAJgBycwp+2JpV7MdrgwkxxbnN3SQLnQUx10M8ztW2NVFxS4D7UvQmHTIdjw
 g4gWwAaGZ32fg60msHKRaZVMellU2EjTwbHiZFZt/b7nNyz4vQDo0bWHQBjSEAn5Fnig
 2O7A==
X-Gm-Message-State: AOJu0YwFpg3QTeBTP293U9GgTvE0EiVUwcmV3ilk2wSFbjllG5Wpqtp2
 QJ2R2/N2DWyeEfB8tMtzX9lS1WT/3SoiKYUpn4/nrBKIw+fRcv7MGDs/afqhBtSj0DDJAiIsADs
 W5oVnLwm3xGLS8dtPTApq06tDgtvkohsae3LKEynXLMQY+kdakg==
X-Gm-Gg: ASbGnctdoCNx9ZBtpvp6oIoeQAuD4ec+mdZChqZr2uy9qIGEZFhGT80aLmdbzcbrbrx
 /qqc1HQl/CCUlX01J2wsBeD+er1XF3hk=
X-Google-Smtp-Source: AGHT+IFOCG1AJCHTMDqU1it1fKLZGGUzI23U0y6e33hfl554JefTt5laTE8Ue+vGiBJUWtdNiSYPPB0msdyufTb6ttg=
X-Received: by 2002:a17:90b:1b0b:b0:2ea:97b6:c44d with SMTP id
 98e67ed59e1d1-2eaca703c19mr9186262a91.15.1732199727086; Thu, 21 Nov 2024
 06:35:27 -0800 (PST)
MIME-Version: 1.0
References: <20241121131954.98949-1-philmd@linaro.org>
In-Reply-To: <20241121131954.98949-1-philmd@linaro.org>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Thu, 21 Nov 2024 15:35:15 +0100
Message-ID: <CAGCz3vtkJS0Fgx_+1qJbUkYAxJ3WPvhEBxJ7P4T1a-g34KV1RA@mail.gmail.com>
Subject: Re: [PATCH-for-9.2] ui/cocoa: Temporarily ignore annoying deprecated
 declaration warnings
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: multipart/alternative; boundary="00000000000069e69306276d2d55"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::1035;
 envelope-from=lists@philjordan.eu; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--00000000000069e69306276d2d55
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As we're talking about macOS-only code I'd perhaps have used '#pragma clang
diagnostic' rather than the GCC versions, but clang seems to understand
these just fine too. (Plus, we very much intend for these to be genuinely
temporary.)

Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>

I'll try to find some spare cycles to come up with a clean solution to the
deprecation issue towards the end of the year. I need to research the
available alternative APIs for another project anyway.

I think part of the reason for the deprecation is that most modern Macs (as
with other modern laptop and desktop computers) actually use a variable
display frame rate, so the concept of a "native" frame rate is no longer
well-defined. In an ideal world the frame rate would be something that's
negotiable between the host UI and the virtual hardware.

For example, the macOS PV Graphics I've been working on integrating would
actually prefer a "push" arrangement where the guest/PV hardware notify the
host when the next frame is ready, rather than expecting a fixed-rate frame
refresh interrupt or similar. So when using that there would actually not
be any need for the display-linked timer at all if the UI is happy with the
hw calling dpy_gfx_update_full()/graphic_hw_update_done() proactively
whenever it has a new frame available. I'm not sure what the story is for
other display adapters in QEMU, but I can do a survey of that.


On Thu, 21 Nov 2024 at 14:20, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g>
wrote:

> These warnings are breaking some build configurations since 2 months
> now (https://gitlab.com/qemu-project/qemu/-/issues/2575):
>
>   ui/cocoa.m:662:14: error: 'CVDisplayLinkCreateWithCGDisplay' is
> deprecated: first deprecated in macOS 15.0 - use
> NSView.displayLink(target:selector:),
> NSWindow.displayLink(target:selector:), or
> NSScreen.displayLink(target:selector:)  [-Werror,-Wdeprecated-declaration=
s]
>     662 |         if (!CVDisplayLinkCreateWithCGDisplay(display,
> &displayLink)) {
>         |              ^
>
> /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Framew=
orks/CoreVideo.framework/Headers/CVDisplayLink.h:89:20:
> note: 'CVDisplayLinkCreateWithCGDisplay' has been explicitly marked
> deprecated here
>      89 | CV_EXPORT CVReturn CVDisplayLinkCreateWithCGDisplay(
>         |                    ^
>   ui/cocoa.m:663:29: error:
> 'CVDisplayLinkGetNominalOutputVideoRefreshPeriod' is deprecated: first
> deprecated in macOS 15.0 - use NSView.displayLink(target:selector:),
> NSWindow.displayLink(target:selector:), or
> NSScreen.displayLink(target:selector:)  [-Werror,-Wdeprecated-declaration=
s]
>     663 |             CVTime period =3D
> CVDisplayLinkGetNominalOutputVideoRefreshPeriod(displayLink);
>         |                             ^
>
> /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Framew=
orks/CoreVideo.framework/Headers/CVDisplayLink.h:182:18:
> note: 'CVDisplayLinkGetNominalOutputVideoRefreshPeriod' has been explicit=
ly
> marked deprecated here
>     182 | CV_EXPORT CVTime
> CVDisplayLinkGetNominalOutputVideoRefreshPeriod( CVDisplayLinkRef
> CV_NONNULL displayLink );
>         |                  ^
>   ui/cocoa.m:664:13: error: 'CVDisplayLinkRelease' is deprecated: first
> deprecated in macOS 15.0 - use NSView.displayLink(target:selector:),
> NSWindow.displayLink(target:selector:), or
> NSScreen.displayLink(target:selector:)  [-Werror,-Wdeprecated-declaration=
s]
>     664 |             CVDisplayLinkRelease(displayLink);
>         |             ^
>
> /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Framew=
orks/CoreVideo.framework/Headers/CVDisplayLink.h:249:16:
> note: 'CVDisplayLinkRelease' has been explicitly marked deprecated here
>     249 | CV_EXPORT void CVDisplayLinkRelease( CV_RELEASES_ARGUMENT
> CVDisplayLinkRef CV_NULLABLE displayLink );
>         |                ^
>   3 errors generated.
>
> For the next release, ignore the warnings using #pragma directives.
> At least until we figure the correct new API usage.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  ui/cocoa.m | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 4c2dd33532..0422dafde4 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -639,6 +639,9 @@ - (void) updateBounds
>      [self setBoundsSize:NSMakeSize(screen.width, screen.height)];
>  }
>
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> +
>  - (void) updateUIInfoLocked
>  {
>      /* Must be called with the BQL, i.e. via updateUIInfo */
> @@ -685,6 +688,8 @@ - (void) updateUIInfoLocked
>      dpy_set_ui_info(dcl.con, &info, TRUE);
>  }
>
> +#pragma GCC diagnostic pop
> +
>  - (void) updateUIInfo
>  {
>      if (!allow_events) {
> --
> 2.45.2
>
>
>

--00000000000069e69306276d2d55
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>As we&#39;re talking about macOS-only code I&#39;d pe=
rhaps have used &#39;#pragma clang diagnostic&#39; rather than the GCC vers=
ions, but clang seems to understand these just fine too. (Plus, we very muc=
h intend for these to be genuinely temporary.)<br></div><div><br></div><div=
>Reviewed-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu">=
phil@philjordan.eu</a>&gt;<br></div><div>Tested-by: Phil Dennis-Jordan &lt;=
<a href=3D"mailto:phil@philjordan.eu">phil@philjordan.eu</a>&gt;</div><div>=
<br></div><div>I&#39;ll try to find some spare cycles to come up with a cle=
an solution to the deprecation issue towards the end of the year. I need to=
 research the available alternative APIs for another project anyway.</div><=
div><br></div><div>I think part of the reason for the deprecation is that m=
ost modern Macs (as with other modern laptop and desktop computers) actuall=
y use a variable display frame rate, so the concept of a &quot;native&quot;=
 frame rate is no longer well-defined. In an ideal world the frame rate wou=
ld be something that&#39;s negotiable between the host UI and the virtual h=
ardware.</div><div><br></div><div>For example, the macOS PV Graphics I&#39;=
ve been working on integrating would actually prefer a &quot;push&quot; arr=
angement where the guest/PV hardware notify the host when the next frame is=
 ready, rather than expecting a fixed-rate frame refresh interrupt or simil=
ar. So when using that there would actually not be any need for the display=
-linked timer at all if the UI is happy with the hw calling dpy_gfx_update_=
full()/graphic_hw_update_done() proactively whenever it has a new frame ava=
ilable. I&#39;m not sure what the story is for other display adapters in QE=
MU, but I can do a survey of that.<br></div><div><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 21 Nov 2024 =
at 14:20, Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.o=
rg">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">These warnings are breaking some build configurations =
since 2 months<br>
now (<a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2575" rel=3D"=
noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/issues=
/2575</a>):<br>
<br>
=C2=A0 ui/cocoa.m:662:14: error: &#39;CVDisplayLinkCreateWithCGDisplay&#39;=
 is deprecated: first deprecated in macOS 15.0 - use NSView.displayLink(tar=
get:selector:), NSWindow.displayLink(target:selector:), or NSScreen.display=
Link(target:selector:)=C2=A0 [-Werror,-Wdeprecated-declarations]<br>
=C2=A0 =C2=A0 662 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!CVDisplayLinkCrea=
teWithCGDisplay(display, &amp;displayLink)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ^<br>
=C2=A0 /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/F=
rameworks/CoreVideo.framework/Headers/CVDisplayLink.h:89:20: note: &#39;CVD=
isplayLinkCreateWithCGDisplay&#39; has been explicitly marked deprecated he=
re<br>
=C2=A0 =C2=A0 =C2=A089 | CV_EXPORT CVReturn CVDisplayLinkCreateWithCGDispla=
y(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>
=C2=A0 ui/cocoa.m:663:29: error: &#39;CVDisplayLinkGetNominalOutputVideoRef=
reshPeriod&#39; is deprecated: first deprecated in macOS 15.0 - use NSView.=
displayLink(target:selector:), NSWindow.displayLink(target:selector:), or N=
SScreen.displayLink(target:selector:)=C2=A0 [-Werror,-Wdeprecated-declarati=
ons]<br>
=C2=A0 =C2=A0 663 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CVTime p=
eriod =3D CVDisplayLinkGetNominalOutputVideoRefreshPeriod(displayLink);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>
=C2=A0 /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/F=
rameworks/CoreVideo.framework/Headers/CVDisplayLink.h:182:18: note: &#39;CV=
DisplayLinkGetNominalOutputVideoRefreshPeriod&#39; has been explicitly mark=
ed deprecated here<br>
=C2=A0 =C2=A0 182 | CV_EXPORT CVTime CVDisplayLinkGetNominalOutputVideoRefr=
eshPeriod( CVDisplayLinkRef CV_NONNULL displayLink );<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ^<br>
=C2=A0 ui/cocoa.m:664:13: error: &#39;CVDisplayLinkRelease&#39; is deprecat=
ed: first deprecated in macOS 15.0 - use NSView.displayLink(target:selector=
:), NSWindow.displayLink(target:selector:), or NSScreen.displayLink(target:=
selector:)=C2=A0 [-Werror,-Wdeprecated-declarations]<br>
=C2=A0 =C2=A0 664 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CVDispla=
yLinkRelease(displayLink);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0^<br>
=C2=A0 /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/F=
rameworks/CoreVideo.framework/Headers/CVDisplayLink.h:249:16: note: &#39;CV=
DisplayLinkRelease&#39; has been explicitly marked deprecated here<br>
=C2=A0 =C2=A0 249 | CV_EXPORT void CVDisplayLinkRelease( CV_RELEASES_ARGUME=
NT CVDisplayLinkRef CV_NULLABLE displayLink );<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ^<br>
=C2=A0 3 errors generated.<br>
<br>
For the next release, ignore the warnings using #pragma directives.<br>
At least until we figure the correct new API usage.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0ui/cocoa.m | 5 +++++<br>
=C2=A01 file changed, 5 insertions(+)<br>
<br>
diff --git a/ui/cocoa.m b/ui/cocoa.m<br>
index 4c2dd33532..0422dafde4 100644<br>
--- a/ui/cocoa.m<br>
+++ b/ui/cocoa.m<br>
@@ -639,6 +639,9 @@ - (void) updateBounds<br>
=C2=A0 =C2=A0 =C2=A0[self setBoundsSize:NSMakeSize(screen.width, screen.hei=
ght)];<br>
=C2=A0}<br>
<br>
+#pragma GCC diagnostic push<br>
+#pragma GCC diagnostic ignored &quot;-Wdeprecated-declarations&quot;<br>
+<br>
=C2=A0- (void) updateUIInfoLocked<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0/* Must be called with the BQL, i.e. via updateUIInfo *=
/<br>
@@ -685,6 +688,8 @@ - (void) updateUIInfoLocked<br>
=C2=A0 =C2=A0 =C2=A0dpy_set_ui_info(dcl.con, &amp;info, TRUE);<br>
=C2=A0}<br>
<br>
+#pragma GCC diagnostic pop<br>
+<br>
=C2=A0- (void) updateUIInfo<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (!allow_events) {<br>
-- <br>
2.45.2<br>
<br>
<br>
</blockquote></div></div>

--00000000000069e69306276d2d55--

