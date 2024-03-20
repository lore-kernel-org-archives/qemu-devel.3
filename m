Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2764C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 14:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmwYt-0003ZY-Nw; Wed, 20 Mar 2024 10:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmwYr-0003Yy-HL
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 10:04:57 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmwYq-0002mX-17
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 10:04:57 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-568a53d2ce0so8448485a12.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 07:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710943494; x=1711548294; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WBee3UbUvqirpeGPB42DXXCSEMWsEGrtK9BsNsGp5Cs=;
 b=K0LMwt4xnpRgbj25APWeHEs2RTGDFf16T+qDFw3rAZ1GXigcBRk8KHfMeY8vICZv7V
 Q7wFyxfGmjK1ENYTF9s/YOXm89yAeopb7KtR+HabaR2mXTfehUHDKf/xzJNrFKcmkGtw
 h6OFYw8HrPKRWmYm8LLgMhJ/j8uMJBeRN/M020e89vvkpB/u2B/lBapjrBdDuThrBWQC
 dUf5jsy8XT+RjShX4VRQxvu8aINLszQtiJ0vq/KlpXyUcacGMR8/0O/Oh/QujfmZ2y9T
 b733RlZGs2tN+ILOKXcUnRPNo2Zw+MEP4AEdpc3iFvmT1S5CT5qLBVwQwXUth0/JezkL
 YkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710943494; x=1711548294;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WBee3UbUvqirpeGPB42DXXCSEMWsEGrtK9BsNsGp5Cs=;
 b=ljQsI2wKJmnqtIv20vgCY4JDKLvw0duO0ts+VV7+3kQ5n/YGOYMGFSVZC4FDur73oB
 GSKEhAN5xTD0TP1ymFmD1YF7Ni3q53nb8O/4mCCgA+BJAxXg/qWQuKpfx5Du1JN1FwlH
 6BT9FlnPMS1RHebnerWepOu3Nv9703E01vpANp7FdspdjpzonxHtw73zu63IKoQmNPNm
 IkGW073XxkVCYiURDsJOekwB8lXX+Jzcxz89mOgF75r5ik89VPgz/NOqdxQ4+VDPWRTc
 6mXNgEA8fkT0X2x1eYXPc2gf4gtjUmYFm/7sNAum+PSsKAR/ohs+SKsitsxm1iZ+epKV
 vwTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj3StPn64THJ1Fd4NuT7B62EbFS7ENFuDVD70z6GJe1lb7xwxxfWaH4Lug7ojeZ7xhrUxjZAUZthmK59alb5VhnEWC78w=
X-Gm-Message-State: AOJu0YwQd4LEXoCQSk88hsEadHiratMmBQ54q32YGRvtcYOyZz7gr9Dc
 MAGMHcy8nCOCod6CxTZ4H7RRmqQvWqJYMJzVFDJ1w2xGeWUMaxzabUfY/EUfMTn7d428fNmxa1d
 0zvcF18RdpI+vvp0qN/ism0IqZ9i1sam1dv0XcQ==
X-Google-Smtp-Source: AGHT+IF9zJGZAUGel/WVvK3Kkj2i4ROpfgZzL876++llF+I7kZcxZ0aoNFT7NNvwiD+wjFoPagmNuJACJvAp1PVqrso=
X-Received: by 2002:a05:6402:530f:b0:568:bf95:9b70 with SMTP id
 eo15-20020a056402530f00b00568bf959b70mr8600954edb.10.1710943494263; Wed, 20
 Mar 2024 07:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240320083640.523287-1-tao1.su@linux.intel.com>
 <Zfreb8-swnvSOMhx@redhat.com>
In-Reply-To: <Zfreb8-swnvSOMhx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Mar 2024 14:04:42 +0000
Message-ID: <CAFEAcA8t8C8QCeQS-fxvRKNST80g+84Ggh4B_cZAc6vzHL-wmA@mail.gmail.com>
Subject: Re: [PATCH v2] target/i386: Revert monitor_puts() in
 do_inject_x86_mce()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Tao Su <tao1.su@linux.intel.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, 
 xiaoyao.li@intel.com, alex.bennee@linaro.org, armbru@redhat.com, 
 philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Wed, 20 Mar 2024 at 13:03, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Wed, Mar 20, 2024 at 04:36:40PM +0800, Tao Su wrote:
> > monitor_puts() doesn't check the monitor pointer, but do_inject_x86_mce=
()
> > may have a parameter with NULL monitor pointer. Revert monitor_puts() i=
n
> > do_inject_x86_mce() to fix, then the fact that we send the same message=
 to
> > monitor and log is again more obvious.
>
> Yikes, why do we have such a horrible trap-door in our
> monitor output APIs.
>
> Isn't the right fix here to make 'monitor_puts' check for
> NULL & be a no-op, in the same way 'monitor_printf' does,
> so the APIs have consistent behaviour.

The other difference between monitor_puts(mon, s) and
monitor_printf(mon, "%s", s)
is that the latter will return an error if the monitor is QMP, whereas
the former will go ahead and print the message anyway. That one is
awkward to resolve, because the mechanism the QMP monitor uses to
print the JSON in qmp_send_response() is to call monitor_puts()...

-- PMM

