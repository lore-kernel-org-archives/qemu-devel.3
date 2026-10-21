Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216D3606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Gw60PqzJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJRGp-00039x-O3; Wed, 21 Oct 2026 04:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJRGS-00036F-U3
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 04:01:37 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJRGQ-0005Ah-AO
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 04:01:36 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a1e34ecb02so2737495e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 01:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792569692; x=1793174492; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KmS6POvOU8uWwtXPwpZvXcIWOBRMCt8xAUzTlXIy8PQ=;
 b=Gw60PqzJjMM3YoqSlOjdPzlaD5I6j7iiDplRHdCEMcB+V44jB3qmYrlGurqbBYLGFL
 X8w/PtAZfc6LoXMgFG48C2jaXQoE5lKVmzAN8obJftmN5ArtZO3AOuoRKdsqK4s0vkOJ
 vmTZWBdaevpDh/yGSquK+xC/1Syt/25B1tV16jTpZauldzZSs6rCGUz6tM/lwLJ0VRvj
 k/jstOBWKfdKnZJM94JjqkC8q8m1PapQ2E9MUm0LjUN6mif4EROaoRWXZjdrk9kGTLTt
 zSZc09PORCFOwhhyDfX/RzsLBVyTQppuUzt6jnEN4EXrpptXpdTgtxB/s7Aw2qMZBJ1X
 Kv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792569692; x=1793174492;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KmS6POvOU8uWwtXPwpZvXcIWOBRMCt8xAUzTlXIy8PQ=;
 b=mpKeWJkCSjIYzO068n6UQVkDqvTtrwZ/uQihYeJuVbFEfqiLJpIZ+5lD/hgjmd5G5N
 L2uvagot0ew+iMNbPmHyvWR5kv9Qvv7EyKkv1IPH48doCZTGLq2x+3xf09EUR9gvAGMo
 YdPy1PYv9oIktG5XT/WmgdDTTnOeJUCjNS4ePX440dwai+8QA0XjodHR5BwcPVkc6/XR
 IlEdy9Z4W/5d/yhwTSvlJbB0McyPPfa/RKCL9qWbouDxZ2NGo16dlZXis4H9uMYNAE4b
 7dXprHP5TXxuCivBC9PZToeLEolNcnaK/iw5FukijKwczyhDoImV+WxwHl2b27fU9MWK
 TOgA==
X-Gm-Message-State: AFq9FYJ1nLyawW8QwrzpftpBNvoJ/KFFvfvrBmUmPpNEJGzbqHGmGIfv
 /z4qre0eL2zZhMARJ37qRL1bZzTvVgVLNfoSLq5es6v+8WqLEkrJc3GsN9q2GQLwGN4=
X-Gm-Gg: AYBFou0JXwQYTBUaRd5RXGFBrLceNF6+PgFsoYTV0AgSXLB1WcaPZo1nKdqBcalUC4U
 +qGRLwvSESeDlpTytp8S+q1WLOr7A2O4n+hEzFiVqfK4BD+Bq+2aQX4AKuE/X30E5WQAgIkFIib
 OOqOR2OjZVM0dcUMa0fzU2Mz1s/7/e65KWWKXWg1Bq6kH2iHd9IUhEoXTWoGOHVFRy35GeEVZ+y
 RgKmciqv9QWPNiNbEEnN0genpths8TnbHAKaV8r21FRbnSlxg7Ze7I/HhGg86NGt2D4sq2ExtoN
 BmIBpKveLR0xeVQ8VWdvLSPOsdrNlEC6k6DsCnnLWZhuhnUauy/swnu2boy703as7XQ+vPw7gGk
 pZdKvTMp2KrBqqgENxau0/x7Rz8yd2pQg554OXbjfdnl/ZHUu6BrUDM3aq2QOMON+LYwD6pzoDN
 wk864rMZSvCr5Zo29ruDx8cFnfF2NQ0k6oUwftcZkZt+e121NLVckLdGsfLDur09ZAdq/1C14yf
 o7VlQNdhV2+j50ufGFKh8S7sp4JVklmIBadfW/t/qj48z57ogAwp4Z/
X-Received: by 2002:a05:600c:4f0e:b0:4a1:71e5:9420 with SMTP id
 5b1f17b1804b1-4a1fdd1426cmr25142295e9.13.1792569691508; 
 Wed, 21 Oct 2026 01:01:31 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a200c1cc03sm3605885e9.0.2026.10.21.01.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 01:01:29 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 902BD5F828;
 Wed, 21 Oct 2026 09:01:28 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: qemu-devel@nongnu.org,  Cornelia Huck <cohuck@redhat.com>,  Thomas Huth
 <th.huth+qemu@posteo.eu>,  Paolo Bonzini <pbonzini@redhat.com>,  Christian
 Borntraeger <borntraeger@linux.ibm.com>,  Peter Xu <peterx@redhat.com>,
 Warner Losh <imp@bsdimp.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Kyle Evans <kevans@freebsd.org>,  Keith
 Busch <kbusch@kernel.org>,  Matthew Rosato <mjrosato@linux.ibm.com>,  Eric
 Farman <farman@linux.ibm.com>,  Zhao Liu <zhao1.liu@intel.com>,  Ani Sinha
 <anisinha@redhat.com>,  Anders Roxell <anders.roxell@linaro.org>,
 qemu-arm@nongnu.org,  Song Gao <gaosong@loongson.cn>,  Peter Maydell
 <peter.maydell@linaro.org>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier
 <laurent@vivier.eu>,  qemu-s390x@nongnu.org,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Brad Smith <brad@comstyle.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,  Halil Pasic
 <pasic@linux.ibm.com>,  Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Yoshinori Sato
 <yoshinori.sato@nifty.com>,  Klaus Jensen <its@irrelevant.dk>,  John Snow
 <jsnow@redhat.com>
Subject: Re: [PATCH v3 19/19] tests/functional: add tuxrun kvm gdb test for
 s390x
In-Reply-To: <7a3867d3-5fff-462e-9aca-5dcbb437d883@linux.ibm.com> (Ilya
 Leoshkevich's message of "Wed, 21 Oct 2026 00:46:45 +0200")
References: <20261019192704.3220373-1-alex.bennee@linaro.org>
 <20261019192704.3220373-20-alex.bennee@linaro.org>
 <7a3867d3-5fff-462e-9aca-5dcbb437d883@linux.ibm.com>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Wed, 21 Oct 2026 09:01:28 +0100
Message-ID: <87qzhj1nzb.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> On 10/19/26 21:27, Alex Benn=C3=A9e wrote:
>> As with x86_64 we now have the bits to add a KVM gdb test. A couple of
>> minor wrinkles need to be handled.
>> The first is applying an offset when loading the symbols to take
>> into
>> account the relocation that happens.
>> The other minor wrinkle is the s390x only supports WP_WRITE watch
>> points so we skip the other watch point tests lest we get confusing
>> messages about failing to insert HW breakpoints.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>> v3
>>    - add symbol-offset handling
>>    - limit the watchpoint tests
>>    - add skipIfMissingEnv("QEMU_TEST_GDB") decorator
>> ---
>>   .../functional/gdb-scripts/kernel_gdb_test.py  | 10 ++++++----
>>   tests/functional/qemu_test/tuxruntest.py       |  4 ++++
>>   tests/functional/s390x/test_tuxrun.py          | 18 +++++++++++++++++-
>>   tests/guest-debug/run-test.py                  |  7 ++++++-
>>   tests/lcitool/libvirt-ci                       |  2 +-
>
> Did you intend to bump this submodule here?

oops - no. I've never figured out the git foo needed to reset submodules
automatically on checkout. If you jump branches a lot its invariably out
of date.

Will fix.


> Otherwise: this now works and LGTM.
>
> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
>
> [...]

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

