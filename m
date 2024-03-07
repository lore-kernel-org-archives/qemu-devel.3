Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE30C54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 22:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riMIo-0007bd-Uu; Thu, 07 Mar 2024 17:33:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1riMIm-0007b9-JS
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 17:33:24 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1riMIk-00020I-RO
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 17:33:24 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41317cc388dso907995e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 14:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709850801; x=1710455601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3hyM+80BYWzVWFiaczS48nW8SEV1JCraWr4rPcjyUUE=;
 b=e5GUKM3EPVggE2sRKMq0U9zFHTuImZL2jcvgbA6c4UQCBLYl+PeMvIzJRzQcRXacDE
 x7SeDYNJls+7xIqRbyQFDrTTNyj+jTKPVFq6Csk/VL3d2ZqymG2dXK8qqsrQ+O/Dkff2
 wTNWG5j+Aa4YDCzw3Yo0QhpfoG059whDTIpNrtV1DDP+ndXyD4/NfZFTFxePDMIi/uM0
 /AqXEhbjp24bCNz9Ho43nfE+BofVsTesDhhBReQ7TWIIQVWCQcmTh6vBsdIWE0MHfK1I
 /7qmCkJfzvATPnqBG735XFfhu5DVpzRkJbH2oFR2cUydtEd7GXgPve0k4TI9bAcsD6EP
 Zp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709850801; x=1710455601;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3hyM+80BYWzVWFiaczS48nW8SEV1JCraWr4rPcjyUUE=;
 b=jS0R0a66RUQxM12sD/9UbvVoOfntc/XxBHE7dmjrMfjQWzysHSJxSlSgdNu/+Vmb94
 zwwdRcNMUxWpx+bL4p/CVJ+B1rXuxYodCy0PSePRr1TIM+4tJfvAlsFrV1d/t1bo2g9X
 6SQEq8xNpAhctXCoHxZCdUrn/3clKD0AFPs6eOHJBJWZAF80kTlDL93GA1AsgN5YBCQm
 W+GfvQcbDAZxFUsiOTIahQxRsG89AizqYWFI1ioF/F+gUzLiMJiMKhhW6KzJoFA9Vyni
 gDP0v5Kd7Qu8qgGZs/D7U/cpX4IZ9z0YrutALEvln4apLhKS5CwzExZfTXqa5y/5I0oP
 Ercw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQmlUhx09jRp4siW0q3oQGdgMje02BlBQ0fVagnyYJ43Z5x/U+t078giMdRYo5gQnY55cQnXUMsyjKWLumvmzOgMtuZGI=
X-Gm-Message-State: AOJu0YyS1zyy3nVY5lB8GPQNA6WLLFy+JMXre0HzZzV39tKaTQe1lFG1
 rTWcVclO8oYfmpgyMrXdp4VJag+uLg+J7kQyPIO8dRURSm9e5p6Maj2Y8vmb214=
X-Google-Smtp-Source: AGHT+IHZLa+EXPjw7AiCozIGW49n8Ui0K1aJ9r9gj0FkvX6ssHpzLE2Pi65BuQg7jgOIwsAfE9CI7w==
X-Received: by 2002:adf:e6cc:0:b0:33d:6fd8:90d3 with SMTP id
 y12-20020adfe6cc000000b0033d6fd890d3mr13676125wrm.4.1709850800658; 
 Thu, 07 Mar 2024 14:33:20 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h18-20020a5d5052000000b0033cf4e47496sm21162621wrt.51.2024.03.07.14.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 14:33:20 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C17A05F7AD;
 Thu,  7 Mar 2024 22:33:19 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Gustavo Romero <gustavo.romero@linaro.org>,  qemu-devel@nongnu.org,
 peter.maydell@linaro.org,  laurent@vivier.eu,  philmd@linaro.org
Subject: Re: [PATCH v2 3/5] gdbstub: Save target's siginfo
In-Reply-To: <637e4407-4519-4d87-981a-acd9b5124970@linaro.org> (Richard
 Henderson's message of "Thu, 7 Mar 2024 11:09:54 -1000")
References: <20240307182623.1450717-1-gustavo.romero@linaro.org>
 <20240307182623.1450717-3-gustavo.romero@linaro.org>
 <637e4407-4519-4d87-981a-acd9b5124970@linaro.org>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Thu, 07 Mar 2024 22:33:19 +0000
Message-ID: <87y1atu0y8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 3/7/24 08:26, Gustavo Romero wrote:
>> Save target's siginfo into gdbserver_state so it can be used later, for
>> example, in any stub that requires the target's si_signo and si_code.
>> This change affects only linux-user mode.
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   gdbstub/internals.h    |  3 +++
>>   gdbstub/user-target.c  |  3 ++-
>>   gdbstub/user.c         | 14 ++++++++++----
>>   include/gdbstub/user.h |  6 +++++-
>>   linux-user/main.c      |  2 +-
>>   linux-user/signal.c    |  5 ++++-
>>   6 files changed, 25 insertions(+), 8 deletions(-)
>> diff --git a/gdbstub/internals.h b/gdbstub/internals.h
>> index 56b7c13b75..a7cc69dab3 100644
>> --- a/gdbstub/internals.h
>> +++ b/gdbstub/internals.h
>> @@ -58,6 +58,9 @@ typedef struct GDBState {
>>       int line_csum; /* checksum at the end of the packet */
>>       GByteArray *last_packet;
>>       int signal;
>> +#ifdef CONFIG_USER_ONLY
>> +    uint8_t siginfo[MAX_SIGINFO_LENGTH];
>> +#endif
>
> If we this in GDBUserState in user.c -- no need for ifdefs then.

Although it does break on FreeBSD's user target:

  FAILED: libqemu-arm-bsd-user.fa.p/gdbstub_user-target.c.o=20
  cc -m64 -mcx16 -Ilibqemu-arm-bsd-user.fa.p -I. -I.. -Itarget/arm -I../tar=
get/arm -I../common-user/host/x86_64 -I../bsd-user/include -Ibsd-user/freeb=
sd -I../bsd-user/freebsd -I../bsd-user/host/x86_64 -Ibsd-user -I../bsd-user=
 -I../bsd-user/arm -Iqapi -Itrace -Iui -Iui/shader -I/usr/local/include/cap=
stone -I/usr/local/include/glib-2.0 -I/usr/local/lib/glib-2.0/include -I/us=
r/local/include -fdiagnostics-color=3Dauto -Wall -Winvalid-pch -Werror -std=
=3Dgnu11 -O2 -g -fstack-protector-strong -Wempty-body -Wendif-labels -Wexpa=
nsion-to-defined -Wformat-security -Wformat-y2k -Wignored-qualifiers -Winit=
-self -Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs -Wol=
d-style-definition -Wredundant-decls -Wstrict-prototypes -Wtype-limits -Wun=
def -Wvla -Wwrite-strings -Wno-gnu-variable-sized-type-not-at-end -Wno-init=
ializer-overrides -Wno-missing-include-dirs -Wno-psabi -Wno-shift-negative-=
value -Wno-string-plus-int -Wno-tautological-type-limit-compare -Wno-typede=
f-redefinition -Wthread-safety -iquote . -iquote /tmp/cirrus-ci-build -iquo=
te /tmp/cirrus-ci-build/include -iquote /tmp/cirrus-ci-build/host/include/x=
86_64 -iquote /tmp/cirrus-ci-build/host/include/generic -iquote /tmp/cirrus=
-ci-build/tcg/i386 -pthread -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGE=
FILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-ini=
t=3Dzero -fPIE -DNEED_CPU_H '-DCONFIG_TARGET=3D"arm-bsd-user-config-target.=
h"' '-DCONFIG_DEVICES=3D"arm-bsd-user-config-devices.h"' -MD -MQ libqemu-ar=
m-bsd-user.fa.p/gdbstub_user-target.c.o -MF libqemu-arm-bsd-user.fa.p/gdbst=
ub_user-target.c.o.d -o libqemu-arm-bsd-user.fa.p/gdbstub_user-target.c.o -=
c ../gdbstub/user-target.c
  In file included from ../gdbstub/user-target.c:18:
  ../gdbstub/internals.h:62:21: error: use of undeclared identifier 'MAX_SI=
GINFO_LENGTH'
     62 |     uint8_t siginfo[MAX_SIGINFO_LENGTH];
        |                     ^
  1 error generated.
  [2084/6731] Compiling C object libqemu-arm

See: https://gitlab.com/stsquad/qemu/-/jobs/6345829419

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

