Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDB4E7DF11
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 17:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmxwh-0001FK-SI; Mon, 02 Feb 2026 12:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vmxwf-0001Et-FY
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:42:41 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vmxwd-0005QF-Oi
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:42:41 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b8871718b05so744616166b.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 09:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770054158; x=1770658958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A5iEbnZiMI5JktEUcqTFYwNIYDAbh15eacXWSPeJSYw=;
 b=YZz2ji//mvpBefkveEKx9vGUfagAFxAgMFX9k3PXZr9GxWFijs74yuFXf7Uc/JYKq1
 bWEPXuk5+JNAkmhFgldmZmzzWcsLHVlrWKWBx5VMSxs+0O6pBSp0dqJXI9Ynrra54hEz
 kQR6608cs6j8QyCe6yl/3QTQl3ozP9jwxYufoxURW9pdnaWHBBi9kRBMepHNI41AmOCj
 LRHu8E+w7taWrOcLz6fmpk10hvZgCRAceBqoTk78F7eNrbU0auwhRtjrHW2J1SDSmep3
 EEmpGagOXuT0rfuNtiwy5JFm6JlhNlDh+qRC030HmsjiejLHFoYxLyJq0J7SgfTvTu5o
 1ggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770054158; x=1770658958;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A5iEbnZiMI5JktEUcqTFYwNIYDAbh15eacXWSPeJSYw=;
 b=FYXCeOqduRjgTPRftpK6jkmWEP/Fzk4VRZHpc02/pVepaW1B05GgGdMKMEnBDmKJBO
 Zl9h73pqQNcXtwMaV9TmKx7syd2b9T1N0QoooBbzmm9iOEjsdFidAvRefG3fw8+N61ra
 IEaWWKWHN3VyxXfJ8YRSqJSGQSqxlTDkD7WyOiDBnkeztwm2Ol472JkFNY7+VZtOBRBp
 Ml8whmAuqrcRXKkWq/pBokkc7VdzSdQwWQUpxMcisAdl+OW5lJevbQVHJBOO8SmnaYrP
 thR2qLJYkwKV8rqFIASbkXzkh80acMnxxZ605uwyKiO4kg6MNfJlF8/5g3hRO9JH2omS
 zwQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdwfK08TT//9S/bMiYfeAevJimFbXagWPBANXioUjtsjTM69yDW98fpxfAuw9J2/un3m5jbvof+KIM@nongnu.org
X-Gm-Message-State: AOJu0YzjjWhGwVTNX9kPSllOhMHWnLBwi2p278RRyf3JYigf3vHGjo7k
 t4ejwWi45SPrmSrJWz5/dbXMvHSOwgbIggRUWfGUOLdACVVAYKVkjQhO6+soll6KU48=
X-Gm-Gg: AZuq6aKs1L3LJt7ukDK8PPqujk+RBX3fOUBy0711m5odSvG+4B7KmEC/Yu/siZZx5UK
 DKCdArTxksi3pnXmVXrvcP6SiO4NQ8xYNN0mrrr9UkJY5RfUvRDBPdMOGPaZxjRlqSEzMwl2S3x
 cwacyPMGLVNxOLX2juHMVoLIaCuTvrdh7mFj/sRKkVfAA/4m/a7qkJ/ubvQV+DuWlGXdHrBG9vR
 J6a3qgUoJWn43q6nTn88AmOJTR//VMhIxJNuMO0ogYkjkdXHznrNX0QTx5AEtByXSUZxz0EvqYb
 AVULAv24flDDn2KHgGZG8zLEMy/RYQ09TVLdptVoiQNHkD5vX7hhnrI6+NOPTvFWT0hUTZ2bGPv
 qyYucWxrehkJMGdlQM+N9S1+8BMJUx7D7PborkHS8GJrkbXNCiMMD5ptTUTc5/NLek8WewiXQWy
 ublP/wgVeGfRcI2sPg6Z0fKQ==
X-Received: by 2002:a17:906:ee86:b0:b8d:7c0f:5bfc with SMTP id
 a640c23a62f3a-b8dff7241camr757121366b.64.1770054157848; 
 Mon, 02 Feb 2026 09:42:37 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8dbeffed15sm884542866b.31.2026.02.02.09.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 09:42:37 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 50A9A5F7D8;
 Mon, 02 Feb 2026 17:42:36 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>,  qemu-devel@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  qemu-trivial@nongnu.org, gustavo.romero@linaro.org
Subject: Re: [PATCH] configure: Remove duplicated entry of --gdb in the help
 text
In-Reply-To: <35b3750b-31ab-4120-8edd-74aa1ae5f0bf@redhat.com> (Thomas Huth's
 message of "Tue, 20 Jan 2026 13:02:59 +0100")
References: <20260114155355.82096-1-thuth@redhat.com>
 <878qe0jfgs.fsf@draig.linaro.org>
 <bc463c63-ec0c-4666-a9ed-7c53e02a24c4@tls.msk.ru>
 <35b3750b-31ab-4120-8edd-74aa1ae5f0bf@redhat.com>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Mon, 02 Feb 2026 17:42:36 +0000
Message-ID: <87tsvznisz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Thomas Huth <thuth@redhat.com> writes:

> On 20/01/2026 12.31, Michael Tokarev wrote:
>> On 1/14/26 20:01, Alex Benn=C3=A9e wrote:
>>> Thomas Huth <thuth@redhat.com> writes:
>>>
>>>> From: Thomas Huth <thuth@redhat.com>
>>>>
>>>> Since --gdb has recently been added to meson_options.txt, the help
>>>> text shows up twice in the output of "./configure --help":
>>>>
>>>> =C2=A0 $ ./configure --help | grep gdb
>>>> =C2=A0=C2=A0=C2=A0 --gdb=3DGDB-path=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb to use for gdbstub tests [/usr/bin/gdb]
>>>> =C2=A0=C2=A0=C2=A0 --gdb=3DVALUE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Path to GDB
>>>
>>> It's a shame to loose the default value - is there anyway for the meson
>>> version to show the auto-detected value?
>> Maybe we can drop this line from meson but keep it in ./configure?
>
> The meson stuff is generated automatically, so no clue how that could
> be done in a nice way?

I tried the other way around and squashed the meson_options_help text
with:

  20260202174123.1943748-1-alex.bennee@linaro.org

>
>  Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

