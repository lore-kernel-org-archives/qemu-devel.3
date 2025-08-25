Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBD2C8303F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 21:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqeh3-0002Nv-30; Mon, 25 Aug 2025 17:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uqegj-00028F-IY
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 17:25:13 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uqegV-0001sK-Rq
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 17:25:13 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45a1b065d59so27024995e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 14:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756157088; x=1756761888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aJ3kJocUM+DJlT90WxsNWrj3cpUD1SBN0JVovFA8CZA=;
 b=Aciby6Ec57FPGI82XI5FVo3K6W0Sj5ghitl7x4IEOJtYcH5UJ0YCEJy0CtlqsIRU9a
 wQ4LrLd44ADKXP4hxrV8pXd1gL6LgZbxk9eOSkKhXzzjKfQnDn4pnqLILZr+zGYF45YN
 SlkVHGbeGzmejEP3IRPjiMFG0Vevqo6aFn2K1sR/HPoNt2n19JcLOOH+7a461kQvuSbx
 e97eaQk9FVsZkT035Y0YwSnLZ0Wm++Oy5Cv3b0xPLxgHanO+2X9HynPqI1TMNCpHPmxS
 bPGF4pCm/I9e85DgUgYAYHeDlY3HGM5Lw/+Tj+SjYs56/cY6nJkYSUqkDSLtASs4ItHL
 YUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756157088; x=1756761888;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aJ3kJocUM+DJlT90WxsNWrj3cpUD1SBN0JVovFA8CZA=;
 b=U8FDu0d84sJAdDofXjGEb0s7i5Rtkf8BFZojxKbAW2aimkINOb/YMt7N1RR/Y/zrtI
 74CuVjCdptLk00fG0GX3j35fusMRV/kz+ArzckhnzmG4iy8jS0+xNgjQNNmd1qYWLGDf
 xi6wk/d1Gflr+sM/dDIKtgvjg5dT7Z1WwfaAC1rrBd1NxIEGOu3Lk6J9aRVbCVL/c4yQ
 PJuSJ+amY0OO1e06rqdo059c5z4EhgKjGphU03JM/io4+8rOdpiDjj5ZSUIVHTNXJgIx
 FRGBgbMFS3GQVz+d1FYC7jCsIRnZo1bXHvyaQTJARfJxVW3xd4Kceswb/EeMzSQpnlYh
 lZqA==
X-Gm-Message-State: AOJu0Yy4vpYM9q5PoDVpzYPbGurWAfHIDAnz8jEjZCLkxgv979QmmH36
 R3vOT+cJkKLyi6EEznqBBBL697UccUboXTW0BHPrd1/+aRtcnQ7cPzrESbHStIZP5Wg=
X-Gm-Gg: ASbGncuM++lmHXtLS8yYxoJj2WY1tOMXGyLywuTszQnA7mTVbz1p2wxC1HtauHrwOWu
 GFDo4Y7+SEDG235kp1nXf0ziU/Kj4oY+Hka40Wq/lpwK+1tEX+krEev10WfRK0+fNXtCb1Y9kam
 HAGpn0ScMxH8JKQctVzB4eTH3AUuU+SWsfh+CF+Y48DSd3cJ5LRGN/zoCa+fVje9CVSyazvZF56
 CDgXmWQeGcYWpnSkJRStuSAu2b8gqFTPLg5oeH+JHaHlRfWnT7qyXJowhlmlI2dO1SE8sjTT2ro
 9ZNYDTKlEJdvs61F0cAeBsA7ePnuRuGhW5cAE/EctKlTbooq4naFZ1Bb4Dgq4bqcTTUilB+ScTK
 4jgAV9lynAgFJgsAPbSXwUdE=
X-Google-Smtp-Source: AGHT+IFkqLG2Plvgz+opVLvk2AxNJZ/KMo1Utzmz9FrH2bus4uHav8rR8W5C4nk7eGwUl/YUg1xPwA==
X-Received: by 2002:a05:600c:a09:b0:459:dde3:1a55 with SMTP id
 5b1f17b1804b1-45b517c2f63mr112981025e9.24.1756157088415; 
 Mon, 25 Aug 2025 14:24:48 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b57592db0sm123332925e9.26.2025.08.25.14.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 14:24:47 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 17A8B5F7CB;
 Mon, 25 Aug 2025 22:24:46 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  thuth@redhat.com,  qemu-arm@nongnu.org,
 1844144@gmail.com
Subject: Re: [PATCH 1/4] tests/guest-debug: Make QEMU optional in run-test.py
In-Reply-To: <3ba9ea8d-1590-4f87-8758-1b18bad0d3b8@linaro.org> (Gustavo
 Romero's message of "Mon, 25 Aug 2025 14:30:10 -0300")
References: <20250819143916.4138035-1-gustavo.romero@linaro.org>
 <20250819143916.4138035-2-gustavo.romero@linaro.org>
 <875xeb2v4w.fsf@draig.linaro.org>
 <afd31a15-d4ed-477d-9f72-9c9a23b64047@linaro.org>
 <3ba9ea8d-1590-4f87-8758-1b18bad0d3b8@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 25 Aug 2025 22:24:46 +0100
Message-ID: <87zfbn14dd.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Hi Alex,
>
> On 8/25/25 14:26, Gustavo Romero wrote:
>> Hi Alex!
>> On 8/25/25 14:01, Alex Benn=C3=A9e wrote:
>>> Gustavo Romero <gustavo.romero@linaro.org> writes:
>>>
>>>> This commit makes QEMU optional in run-test.py, allowing it to be used
>>>> as a GDB runner, i.e., to call GDB and pass a test script to it without
>>>> launching QEMU. In this configuration, it is the test script=E2=80=99s=
 duty to
>>>> configure and run the VMs that GDB connects to.
>>>>
>>>> The --binary option continues to be required when --qemu is passed.
>>>> sys.argv now includes the full path to the test script in addition to
>>>> the script=E2=80=99s arguments, which allows unittest introspection to=
 work
>>>> properly in case it is used in the test script.
>>>>
>>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>> ---
>>>> =C2=A0 tests/guest-debug/run-test.py | 81 +++++++++++++++++++---------=
-------
>>>> =C2=A0 1 file changed, 45 insertions(+), 36 deletions(-)
>>>>
>>>> diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-tes=
t.py
>>>> index 75e9c92e03..7fa17aedca 100755
>>>> --- a/tests/guest-debug/run-test.py
>>>> +++ b/tests/guest-debug/run-test.py
>>>> @@ -22,10 +22,10 @@
>>>> =C2=A0 def get_args():
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parser =3D argparse.ArgumentParser(desc=
ription=3D"A gdbstub test runner")
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parser.add_argument("--qemu", help=3D"Q=
emu binary for test",
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 requi=
red=3DTrue)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 requi=
red=3DFalse)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parser.add_argument("--qargs", help=3D"=
Qemu arguments for test")
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parser.add_argument("--binary", help=3D=
"Binary to debug",
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 requi=
red=3DTrue)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 requi=
red=3DFalse)
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 parser.add_argument("--binary", help=3D"Binary=
 to debug",
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 required=3D'--qemu' in sys.argv)
>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parser.add_argument("--test", help=3D"G=
DB test script")
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parser.add_argument('test_args', nargs=
=3D'*',
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 help=3D"Additional args for GDB test script. "
>>>> @@ -53,7 +53,7 @@ def log(output, msg):
>>>> =C2=A0 if __name__ =3D=3D '__main__':
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 args =3D get_args()
>>>> -=C2=A0=C2=A0=C2=A0 # Search for a gdb we can use
>>>> +=C2=A0=C2=A0=C2=A0 # Search for a gdb we can use.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not args.gdb:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 args.gdb =3D sh=
util.which("gdb-multiarch")
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not args.gdb:
>>>> @@ -73,41 +73,49 @@ def log(output, msg):
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 socket_dir =3D TemporaryDirectory("qemu=
-gdbstub")
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 socket_name =3D os.path.join(socket_dir=
.name, "gdbstub.socket")
>>>> -=C2=A0=C2=A0=C2=A0 # Launch QEMU with binary
>>>> -=C2=A0=C2=A0=C2=A0 if "system" in args.qemu:
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if args.no_suspend:
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 su=
spend =3D ''
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 su=
spend =3D ' -S'
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd =3D f'{args.qemu} {arg=
s.qargs} {args.binary}' \
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f'=
{suspend} -gdb unix:path=3D{socket_name},server=3Don'
>>>> -=C2=A0=C2=A0=C2=A0 else:
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if args.no_suspend:
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 su=
spend =3D ',suspend=3Dn'
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 su=
spend =3D ''
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd =3D f'{args.qemu} {arg=
s.qargs} -g {socket_name}{suspend}' \
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f'=
 {args.binary}'
>>>> -
>>>> -=C2=A0=C2=A0=C2=A0 log(output, "QEMU CMD: %s" % (cmd))
>>>> -=C2=A0=C2=A0=C2=A0 inferior =3D subprocess.Popen(shlex.split(cmd))
>>>> +=C2=A0=C2=A0=C2=A0 if args.qemu and not args.binary:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print("QEMU needs a binary=
 to run, but no binary provided")
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(-1)
>>>
>>> then we can avoid this.
>> Sure, thanks for the suggestion. I'm fixing it in v2.
>>=20
>>>> -=C2=A0=C2=A0=C2=A0 # Now launch gdb with our test and collect the res=
ult
>>>> -=C2=A0=C2=A0=C2=A0 gdb_cmd =3D "%s %s" % (args.gdb, args.binary)
>>>> +=C2=A0=C2=A0=C2=A0 if args.qemu:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Launch QEMU with binary.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if "system" in args.qemu:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 args.no_suspend:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 suspend =3D ''
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 el=
se:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 suspend =3D ' -S'
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cm=
d =3D f'{args.qemu} {args.qargs} {args.binary}' \
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 f'{suspend} -gdb unix:path=3D{socket_name},server=3Do=
n'
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 args.no_suspend:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 suspend =3D ',suspend=3Dn'
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 el=
se:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 suspend =3D ''
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cm=
d =3D f'{args.qemu} {args.qargs} -g {socket_name}{suspend}' \
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 f' {args.binary}'
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log(output, "QEMU CMD: %s"=
 % (cmd))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inferior =3D subprocess.Po=
pen(shlex.split(cmd))
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 # Now launch gdb with our test and collect the res=
ult.
>>>> +=C2=A0=C2=A0=C2=A0 gdb_cmd =3D args.gdb
>>>> +=C2=A0=C2=A0=C2=A0 if args.binary:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb_cmd +=3D " %s" % (args=
.binary)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if args.gdb_args:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb_cmd +=3D " =
%s" % (args.gdb_args)
>>>> -=C2=A0=C2=A0=C2=A0 # run quietly and ignore .gdbinit
>>>> +=C2=A0=C2=A0=C2=A0 # Run quietly and ignore .gdbinit.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb_cmd +=3D " -q -n -batch"
>>>> -=C2=A0=C2=A0=C2=A0 # disable pagination
>>>> +=C2=A0=C2=A0=C2=A0 # Disable pagination.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb_cmd +=3D " -ex 'set pagination off'"
>>>> -=C2=A0=C2=A0=C2=A0 # disable prompts in case of crash
>>>> +=C2=A0=C2=A0=C2=A0 # Disable prompts in case of crash.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb_cmd +=3D " -ex 'set confirm off'"
>>>
>>> The re-formatting makes the diffs very noisy. If you want to clean up
>>> the captilization of stuff do that in another commit.
>> OK.
>>=20
>>>> -=C2=A0=C2=A0=C2=A0 # connect to remote
>>>> -=C2=A0=C2=A0=C2=A0 gdb_cmd +=3D " -ex 'target remote %s'" % (socket_n=
ame)
>>>> -=C2=A0=C2=A0=C2=A0 # finally the test script itself
>>>> +=C2=A0=C2=A0=C2=A0 # Connect automatically to remote only if QEMU is =
launched.
>>>> +=C2=A0=C2=A0=C2=A0 if args.qemu:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb_cmd +=3D " -ex 'target=
 remote %s'" % (socket_name)
>>>> +=C2=A0=C2=A0=C2=A0 # Finally the test script itself.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if args.test:
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if args.test_args:
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gd=
b_cmd +=3D f" -ex \"py sys.argv=3D{args.test_args}\""
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 argv =3D [args.test] + arg=
s.test_args
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb_cmd +=3D f" -ex \"py s=
ys.argv=3D{argv}\""
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb_cmd +=3D " =
-x %s" % (args.test)
>>>
>>> I can see this echoes from:
>>>
>>> =C2=A0=C2=A0=C2=A0 env QEMU_TEST_FLAKY_TESTS=3D1 ./pyvenv/bin/meson tes=
t --suite thorough func-aarch64-aarch64_reverse_debug --verbose
>>>
>>> Shows:
>>>
>>> =C2=A0=C2=A0 GDB CMD: /usr/bin/gdb-multiarch -q -n -batch -ex 'set pagi=
nation
>>> off' -ex 'set confirm off' -ex "py
>>> sys.argv=3D['/home/alex/lsrc/qemu.git/tests/functional/test_aarch64_rev=
erse_debug.py']"
>>> -x
>>> /home/alex/lsrc/qemu.git/tests/functional/test_aarch64_reverse_debug.py
>>>
>>> But trying to piece that together on my the command line:
>>>
>>> =C2=A0=C2=A0 env
>>> PYTHONPATH=3D/home/alex/lsrc/qemu.git/python:/home/alex/lsrc/qemu.git/t=
ests/functional
>>> /usr/bin/gdb-multiarch -q -n -batch -ex 'set pagination off' -ex
>>> 'set confirm off' -ex "py
>>> sys.argv=3D['/home/alex/lsrc/qemu.git/tests/functional/test_aarch64_rev=
erse_debug.py']"
>>> -x
>>> /home/alex/lsrc/qemu.git/tests/functional/test_aarch64_reverse_debug.py
>>> Python Exception <class 'ModuleNotFoundError'>: No module named 'pycota=
p'
>>> Error occurred in Python: No module named 'pycotap'
>>>
>>> What am I missing?
>> meson.build in tests/functional is properly setting PYTHONPATH in
>> the env
>> when meson runs this command. libpython called from gdb binary will insp=
ect
>> PYTHONPATH later. It's meson that knows where site-packages from the pyv=
env
>> is located, so that's why meson is setting PYTHONPATH and that's why it =
works
>> when run by meson.
>> We should never need to put pieces together to run QEMU tests, I
>> really
>> hate it (see my previous reply to Thomas about why using Avocado GDB for
>> test like this is not a good idea IMO).
>
> ah, and I can think of some way to avoid having to put command pieces
> together to re-run the test after we agree in the other more fundamental
> aspects of this series, e.g., ok to kept it in tests/functional, ok to
> use GDB Python API, etc.

Hmm could meson devenv help?

>
> Cheers,
> Gustavo
>
>> That said, try to add the site-packages from your pyvenv set in your
>> build dir to PYTHONPATH:
>> gromero@gromero0:/mnt/git/qemu_/build$ ls -l
>> ./pyvenv/lib/python3.10/site-packages
>> total 16
>> drwxrwxr-x=C2=A0 3 gromero gromero 4096 Aug 25 12:47 meson-1.8.1.dist-in=
fo
>> drwxrwxr-x 17 gromero gromero 4096 Aug 25 12:47 mesonbuild
>> drwxrwxr-x=C2=A0 3 gromero gromero 4096 Aug 25 12:47 pycotap
>> drwxrwxr-x=C2=A0 2 gromero gromero 4096 Aug 25 12:47 pycotap-1.3.1.dist-=
info
>> This is where the pycotap and other potential modules reside.
>> Cheers,
>> Gustavo
>>=20
>>>> @@ -129,10 +137,11 @@ def log(output, msg):
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log(output, "GD=
B crashed? (%d, %d) SKIPPING" % (result, result - 128))
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(0)
>>>> -=C2=A0=C2=A0=C2=A0 try:
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inferior.wait(2)
>>>> -=C2=A0=C2=A0=C2=A0 except subprocess.TimeoutExpired:
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log(output, "GDB never con=
nected? Killed guest")
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inferior.kill()
>>>> +=C2=A0=C2=A0=C2=A0 if args.qemu:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
ferior.wait(2)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except subprocess.TimeoutE=
xpired:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lo=
g(output, "GDB never connected? Killed guest")
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
ferior.kill()
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(result)
>>>
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

