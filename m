Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A33C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wym5N-0005ft-1E; Tue, 25 Aug 2026 04:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wym5J-0005fB-7m
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 04:00:41 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wym5H-0004tk-6K
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 04:00:40 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so5335158a91.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 01:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787644837; x=1788249637; darn=nongnu.org;
 h=references:to:cc:in-reply-to:date:subject:mime-version:content-type
 :message-id:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=euFmNfAinSIbXgk5B0RB8xWWect/SKNPPu9ORlgFI+M=;
 b=dPsDKKRSw+Aw7qT90b6UaA2LPmx2KdQAsD4abrA27CfI6gu0+M1lSmizkBsAGBPHmF
 dc11Z0jSalztt7BMCoHUVQHPcWINTcXQHKnwIju2uXuYjaG475Jh3IlRI0qRVCeZfrtc
 j56NOZs/c4ZWgnzAT+Zwg4Ls55qdIp9K8N2Y42GWRnmong3YHhV7c9Ots6gg8IiTvOE3
 /ORbxsd+LYN2wbWFYZ4tMmQmACeHO+zXxLwlKsex/hBVaqaJFzz3k7qxxXIremVygMCq
 XMTCmrYB43TwHelE5Kn7cAvR4lZ6/dHl7C4gqsnhvwSWkn2liZ9nNmUvHJ41HBNdJV2T
 zQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787644837; x=1788249637;
 h=references:to:cc:in-reply-to:date:subject:mime-version:content-type
 :message-id:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=euFmNfAinSIbXgk5B0RB8xWWect/SKNPPu9ORlgFI+M=;
 b=bOCHGDeHsJwW0V2OrS7fUDTWbM9pSeXS1suF9DHMnzi/T3z+Quv7ySigfCX+o7srfT
 hclao9C/z5q5AwBBeDq/apevXt9hWb8d2d25xED5Gpng3akC7shZSfBxCtmUPJ6rWj1j
 HROfqzyanDHhlunzqiN4pJ2BSiallRMxRJoEnlOu47s4PMnvtUrLXZ5JnZ2S79+Q4Sqx
 y+8JIXkkyP7QIBCuzRPtI/9LLONd87wEPvoeiw0tWjHYyw+tL8WqKbbFOG2KTls6w5MX
 N8SGAKnmDL2qAzanTdFXPw537A8ctA6Zl2t4Vz1Sh6zh5P9lCa/1m+sVabQxea3iIXhE
 cIXg==
X-Gm-Message-State: AFuF++mqSDvR0OKTgTIk00c2dkr9iQIok5e+e+jJR1qC8N39G2wnC0vw
 ZWTCLRHAblRCLinKZqmGNEGNV6MiL4DuH1rfhMGDzHBE4THCNoXB5e1C
X-Gm-Gg: AR+sD11ErCCp86VC9XF9wKzgUeBWaLu3nhsjNO43hIgdT9THZ7VCsS0q7iFyY832nlc
 RHnsu/NX933y/hV8f0YNbrrImLx8cP/0SEQAblgtjuGZYBJ9Yq5KwLnhbFobPTTswMrGde4OKSZ
 usTSuugY1xdMS2jCXHuNuJBmPvzwA+36RggS7cO8+sLTrlOYWhArpU5GLDAHyllQSDBxVm1CHYv
 Ga1Try5wki3K2E0OdSzyZ4GstHQHp/+bfQQ8eSMGVOIWgOHMCaMMd/fUw2Tg3qBnV6tvq5SLAoZ
 IYTG1zy/JywAIN7vR8jaO4CpdwsUml66AH1ZTqeUmLieFLW0k936b+acdjPM8fn08tcDpHd//Kh
 GM6ASDLBTGTgD87TesCOZRyOMsOyO+T6JrzNZi4Cq+9YE2Ly9T5UhS+We3MNlhxQnbU6xNDGOyc
 cZMd8+jFL3+b8lKSoToa8oaN1Ftap8MUB+N/PVlOnjKrvaMXFq5j5T/cCILBrXnj1zP7OZ
X-Received: by 2002:a17:90a:ec8e:b0:38e:c7b0:84ad with SMTP id
 98e67ed59e1d1-395c2f2a10bmr59474917a91.0.1787644834970; 
 Tue, 25 Aug 2026 01:00:34 -0700 (PDT)
Received: from smtpclient.apple ([117.55.237.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645b4d52asm2954576a91.8.2026.08.25.01.00.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Aug 2026 01:00:34 -0700 (PDT)
From: Jack Wang <163wangjack@gmail.com>
Message-Id: <5783F0B2-CF7F-450D-82DA-93A6BB0CFA38@gmail.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_89A7ACB3-A0DD-4BA4-9A66-588A552C91FB"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v3 0/5] Add Axiado SoC AX3005 and EVB
Date: Tue, 25 Aug 2026 16:00:17 +0800
In-Reply-To: <9eb76bbd-be48-4095-85ab-7097a7a94a09@axiado.com>
Cc: qemu-devel@nongnu.org,
 peter.maydell@linaro.org,
 qemu-arm@nongnu.org
To: kchiu@axiado.com
References: <9eb76bbd-be48-4095-85ab-7097a7a94a09@axiado.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=163wangjack@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--Apple-Mail=_89A7ACB3-A0DD-4BA4-9A66-588A552C91FB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Understand.
I still need some basic info for confirmation.What the is mmio window =
size for each uart? Is it designed to be overlapped.Do all UART =
instances use the same register layout and window size?

Thanks=20
JW..
> On Tue, 25 Aug 2026 14:07:07 +0800, Kuan-Jui Chiu <kchiu@axiado.com> =
wrote:
> Hi Jack
>=20
> Sorry that I can't provide the datasheet due to the company policy
>=20
> I can only share about the SoC specification in cover letter and use =
the=20
> existing QEMU models like Axiado SDHCI and Cadence GPIO
>=20
>=20
> I never enabled QMP before but you are right on this missing class=20
> problem. I am studying for how to use QMP right now.
>=20
>=20
> B.R.
>=20
> Howard
>=20
> Jack Wang =E6=96=BC 2026/8/25 =E4=B8=8B=E5=8D=88 01:52 =E5=AF=AB=E9=81=93=
:
>=20
>=20

>> On Tue, 25 Aug 2026 13:52:51 +0800, Jack Wang <163wangjack@gmail.com =
<mailto:163wangjack@gmail.com>> wrote:
>> Hi Kuan-Jui,
>>=20
>> Cheers for the v3, that was a really quick update!
>>=20
>> The basic tests passed on my local machine, and I will look through =
each patch carefully next. I'm not sure if I'm qualified enough to give =
Reviewed-by or Tested-by tags yet. Anyway, if anything I do during the =
review is inappropriate, please just let me know.
>>=20
>> I checked the https://axiado.com/products/ link you mentioned, but =
didn't find the critical info I needed. I googled for the AX3005 =
datasheet but not much useful infomation. AI tell me it's not =
public.emmm.. If you could offer me some key hardware information for =
the QEMU modeling, that would be much better.
>>=20
>> Also, since you asked for my commands before, if I find any problems, =
I will attach the exact commands I used in the email to help identify =
the bug. I am testing on my Mac now, so please contact me if you have =
any trouble reproducing the issues.
>>=20
>> Best regards, : )
>>=20
>> JW..

--Apple-Mail=_89A7ACB3-A0DD-4BA4-9A66-588A552C91FB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta charset=3D"UTF-8"><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><span style=3D"caret-color: rgb(0, 0, =
0); color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; display: inline =
!important; float: none;">Understand.</span><br style=3D"caret-color: =
rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; display: inline !important; float: none;">I still =
need some basic info for confirmation.What the is mmio window size for =
each uart? Is it designed to be overlapped.Do all UART instances use the =
same register layout and window size?</span><br style=3D"caret-color: =
rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><span style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; display: inline =
!important; float: none;">Thanks<span =
class=3D"Apple-converted-space">&nbsp;</span></span><br =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><span style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; display: inline =
!important; float: none;">JW..</span><br style=3D"caret-color: rgb(0, 0, =
0); color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: =
none; text-decoration-thickness: auto; text-decoration-style: solid;">On =
Tue, 25 Aug 2026 14:07:07 +0800, Kuan-Jui Chiu &lt;kchiu@axiado.com&gt; =
wrote:<br>Hi Jack<br><br>Sorry that I can't provide the datasheet due to =
the company policy<br><br>I can only share about the SoC specification =
in cover letter and use the<span =
class=3D"Apple-converted-space">&nbsp;</span><br>existing QEMU models =
like Axiado SDHCI and Cadence GPIO<br><br><br>I never enabled QMP before =
but you are right on this missing class<span =
class=3D"Apple-converted-space">&nbsp;</span><br>problem. I am studying =
for how to use QMP right now.<br><br><br>B.R.<br><br>Howard<br><br>Jack =
Wang =E6=96=BC 2026/8/25 =E4=B8=8B=E5=8D=88 01:52 =
=E5=AF=AB=E9=81=93:<br><br><br></blockquote><br style=3D"caret-color: =
rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: =
none; text-decoration-thickness: auto; text-decoration-style: =
solid;"><blockquote type=3D"cite">On Tue, 25 Aug 2026 13:52:51 +0800, =
Jack Wang &lt;<a =
href=3D"mailto:163wangjack@gmail.com">163wangjack@gmail.com</a>&gt; =
wrote:<br>Hi Kuan-Jui,<br><br>Cheers for the v3, that was a really quick =
update!<br><br>The basic tests passed on my local machine, and I will =
look through each patch carefully next. I'm not sure if I'm qualified =
enough to give Reviewed-by or Tested-by tags yet. Anyway, if anything I =
do during the review is inappropriate, please just let me know.<br><br>I =
checked the<span class=3D"Apple-converted-space">&nbsp;</span><a =
href=3D"https://axiado.com/products/">https://axiado.com/products/</a><spa=
n class=3D"Apple-converted-space">&nbsp;</span>link you mentioned, but =
didn't find the critical info I needed. I googled for the AX3005 =
datasheet but not much useful infomation. AI tell me it's not =
public.emmm.. If you could offer me some key hardware information for =
the QEMU modeling, that would be much better.<br><br>Also, since you =
asked for my commands before, if I find any problems, I will attach the =
exact commands I used in the email to help identify the bug. I am =
testing on my Mac now, so please contact me if you have any trouble =
reproducing the issues.<br><br>Best regards, : =
)<br><br>JW..</blockquote></blockquote></body></html>=

--Apple-Mail=_89A7ACB3-A0DD-4BA4-9A66-588A552C91FB--

