Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BA2C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 07:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfaXI-0000pQ-MD; Thu, 29 Feb 2024 02:08:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfaXH-0000pH-CD
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 02:08:55 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfaXF-0004BE-Bz
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 02:08:54 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33de64c91abso258501f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 23:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709190531; x=1709795331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZbpVwYEHLFrgKTYsVIBJ1TbcbTxsf2vZ7EqotBOpHPY=;
 b=vFMPYZIJYbfoWMs6bA7LyM6QVsXV+AvpumKVKZ7BErOxUGpthwY3T+O5zptU5Ig3Ck
 CxjfM0L7/MR/fQxKurkOHVXWhcTEnbnHzBwv8PkYMeGH7Rx/isblooutFnJmrbj+0gn/
 7ISORJzM2mC04b8UhZcrPbDvsx/zGSEsejUXntgCdLn40XDDaAXVdvgDkipr/pkiDMuw
 Pb/flIHsIxFKoQG4up4ksEvQY+Rtb8p7kPPeSV7NFqMgrWOxyQLlzs8NeBn5kRhvWRiV
 56qffadRVU+HHQq6xLs1csWYnGBTnloUTXxhm5jXsKvLHmu/dQamdxPmqnziMhRQrEGM
 lyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709190531; x=1709795331;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZbpVwYEHLFrgKTYsVIBJ1TbcbTxsf2vZ7EqotBOpHPY=;
 b=tSI7/OM39+YW9+3Y21t6E1b4cnnMD58dq+v3r/w8IeJBafVIG+IQlFypF92tiVlNXM
 qeFHhN3G8b2F+yic0JKNkX2wU7PWyuIHpZ/rx5lD0SD73zAheWUap9r0sVti/kj8s8If
 FYjfBlpo+LFGCsaUL7fzoykcOfjTJ8Y77llu1TMBaoi9lEBPzGfHoyMAnLB/39mQvfCE
 3nvOqblEqytA4t5Lxsbgwmx5+YGbW+RZUYD3KAVSqdOBoW7S2Qf0MZf5QNPUESge5QUm
 GytZtYpWYiWwzS+FHliDH935QwF7iSvLoOF8ExVS1ohQ1yqwMnOZ/Ptt2kcqsYa9AV0P
 bqdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp5wE8lII52xPlRifHNWMrRQ5T5qTkKKWx3DMK5A6vsESkf4QUY+tYrXu6/dznqpjGNmcpwu3NjzTurhNvDjSwoCzYo58=
X-Gm-Message-State: AOJu0Yx6dCNa+6aHb9HrrUyVailXUX+a62GdvaPV9cs+dPtL50a26r5c
 CkFaopyVPlhWO2llSRPOKUsYoj6llxzzKwoNhKul1zpiN6Bl26zsJ72dLdh9u4o=
X-Google-Smtp-Source: AGHT+IHM/XaO+NrwArkuHE+qd3CPp92XSUwuxSlu691wZGZIrKJrK47EHW0p5l8IVgCN9ZUV8KDu4g==
X-Received: by 2002:adf:ce92:0:b0:33e:d26:3780 with SMTP id
 r18-20020adfce92000000b0033e0d263780mr700495wrn.17.1709190530627; 
 Wed, 28 Feb 2024 23:08:50 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 q16-20020a5d6590000000b0033d56aa4f45sm874630wru.112.2024.02.28.23.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 23:08:50 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D12815F7A0;
 Thu, 29 Feb 2024 07:08:49 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Luc Michel <luc.michel@amd.com>,  qemu-devel@nongnu.org,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Yanan Wang <wangyanan55@huawei.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v5 06/12] tests/plugin/mem: migrate to new per_vcpu API
In-Reply-To: <f0133db0-63e1-4634-a18f-fe181754e17c@linaro.org> (Pierrick
 Bouvier's message of "Thu, 29 Feb 2024 09:19:58 +0400")
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
 <20240226091446.479436-7-pierrick.bouvier@linaro.org>
 <Zd2sxjxegajy7ZbF@luc-work-vm> <875xy8b5sg.fsf@draig.linaro.org>
 <f0133db0-63e1-4634-a18f-fe181754e17c@linaro.org>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Thu, 29 Feb 2024 07:08:49 +0000
Message-ID: <87zfvjagse.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 2/29/24 2:08 AM, Alex Benn=C3=A9e wrote:
>> Luc Michel <luc.michel@amd.com> writes:
>>=20
>>> Hi Pierrick,
>>>
<snip>
>>=20
>
> My bad. Other plugins enable only inline when both are supplied, so I
> missed this here.
> I added an explicit error when user enable callback and inline at the
> same time on this plugin.

We could default to inline unless we need the more features of callbacks?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

